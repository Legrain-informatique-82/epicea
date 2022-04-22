//----------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ZIPBuilder.h"

USEUNIT("CallBackUnit.cpp");
USEUNIT("ZipDLL.cpp");
USEUNIT("UnZipDLL.cpp");

//----------------------------------------------------------------------------
static inline TZipBuilder *ValidCtrCheck() {
	return new TZipBuilder( NULL );
}

//----------------------------------------------------------------------------
namespace Zipbuilder {
	void __fastcall Register() {
		TComponentClass classes[1] = {__classid( TZipBuilder ) };
		RegisterComponents( "Components", classes, 0 );
 	}
}

GetZipExecAddress		ZipDLL::ZipDllExec;
GetZipVersionAddress	ZipDLL::GetZipDllVersion;
GetUnzExecAddress		UnzipDLL::UnzDllExec;
GetUnzVersionAddress	UnzipDLL::GetUnzDllVersion;

HINSTANCE ZipDLL::ZipDllHandle;
HINSTANCE UnzipDLL::UnzDllHandle;

//----------------------------------------------------------------------------
/* Dennis Passmore (Compuserve: 71640,2464) contributed the idea of passing an
   instance handle to the DLL, and, in turn, getting it back from the callback.
   This lets us reference variables in the TZipBuilder class from within the
   callback function.  Way to go Dennis! */
unsigned long __stdcall ZCallback( CallBackUnit::PZCallBackStruct cbr ) {
	TZipBuilder *tzb = (TZipBuilder *)cbr->Caller;

	if ( tzb->OnProgress ) {
		switch ( cbr->ActionCode ) {
			// Progress type 1 = starting any ZIP operation on a new file.
			case 1:
				tzb->OnProgress( tzb, NewFile, StrPas( cbr->FileNameOrMsg ), cbr->FileSize );
				break;
			// Progress type 2 = increment bar.
			case 2:
				tzb->OnProgress( tzb, ProgressUpdate, "", 0 );
            break;
			// End of a batch of 1 or more files.
			case 3:
				tzb->OnProgress( tzb, EndOfBatch, "", 0 );
            break;
		}
	}
	// Show a routine status message.
	if ( cbr->ActionCode >= 4 && tzb->OnMessage ) {
     System::AnsiString Msg = StrPas( cbr->FileNameOrMsg ).TrimRight();

     tzb->OnMessage( tzb, cbr->ErrorCode, Msg );
	}

	/* If you return TRUE, then the DLL will abort it's current
		batch job as soon as it can. */
	return ( (tzb->Cancel) ? true : false );
}

__fastcall TZipBuilder::TZipBuilder( Classes::TComponent *AOwner ) : TComponent( AOwner ) {
	FHandle			 = ((TForm *)AOwner)->Handle;
	FZipContents 	 = new TList();
	FFSpecArgs  	 = new TStringList();
	FZipFilename	 = "";
	FSuccessCnt 	 =  0;
	FAddCompLevel	 =  9;  // Default to tightest compression.
	FPassword		 = "";
	FSFXPath			 = "";
	FEncrypt			 = false;
	FDLLDirectory	 = "";
	FSFXDefaultDir  = "";
	FSFXCommandLine = "";
	FSFXCaption		 = "Self-extracting Archive";
	FSFXOverWriteMode    = OvrConfirm;
}

__fastcall TZipBuilder::~TZipBuilder( void ) {
	FreeZipDirEntryRecords();
	delete FFSpecArgs;
	delete FZipContents;
}

int __fastcall TZipBuilder::GetZipVers( void ) {
	bool AutoLoad = false;	// User's pgm did load the DLL, so let him unload it.

	if ( !ZipDllHandle ) {
		AutoLoad = true;		// User's program didn't load the DLL.
		Load_Zip_Dll();		// Load it...
	}
	if ( !ZipDllHandle ) return 0;	// Load failed - error msg was shown to user.

	int result = GetZipDllVersion();

	if ( AutoLoad ) Unload_Zip_Dll();
	return result;
}

int  __fastcall TZipBuilder::GetUnzVers( void ) {
	bool AutoLoad = false;	// User's pgm did load the DLL, so let him unload it.

	if ( !UnzDllHandle ) {
		AutoLoad = true;		// User's program didn't load the DLL.
		Load_Unz_Dll();		// Load it...
	}
	if ( !UnzDllHandle ) return 0;	// Load failed - error msg was shown to user.

	int result = GetUnzDllVersion();

	if ( AutoLoad ) Unload_Unz_Dll();
	return result;
}

// We'll normally have a TStringList value, since TStrings itself is an abstract class.
void __fastcall TZipBuilder::SetFSpecArgs( Classes::TStrings *Value ) {
	FFSpecArgs->Assign( Value );
}

void __fastcall TZipBuilder::SetFileName( System::AnsiString Value ) {
	FZipFilename = Value;
	// Automatically build a new TLIST of contents in "ZipContents".
	if ( !ComponentState.Contains( csDesigning ) ) List();
}

// NOTE: we will allow a dir to be specified that doesn't exist,
// since this is not the only way to locate the DLLs.
void __fastcall TZipBuilder::SetDLLDirectory( System::AnsiString Value ) {
	if ( Value != FDLLDirectory ) {
		int ValLen = Value.Length();
		// If there is a trailing \ in dirname, cut it off:
		if ( ValLen > 0 )	 // Shorten the dirname by one.
			if ( Value[ValLen] == '\\' ) Value.SetLength( ValLen - 1 );
		FDLLDirectory = Value;
	}
}

int __fastcall TZipBuilder::GetCount( void ) {
	return ( FZipFilename != "" ) ? FZipContents->Count : 0;
}

// Empty FZipContents and free the storage used for dir entries.
void __fastcall TZipBuilder::FreeZipDirEntryRecords( void ) {
	for ( int i = FZipContents->Count - 1; i >= 0; i-- ) {
		if ( FZipContents->Items[i] ) {
      	// Dispose of the memory pointed-to by this entry.
			delete FZipContents->Items[i];
		   FZipContents->Delete( i );	// Delete pointer from the TList itself.
		}
	}
	// The caller will free the FZipContents TList itself, if needed.
}

/* The Delphi code used in the List method is based on the TZReader VCL by
	 Dennis Passmore (Compuserve: 71640,2464).  This "list" code is also used
   in the ZIPDIR VCL used by Demo3. TZReader was inspired by Pier Carlo Chiodi
   pc.chiodi@mbox.thunder.it
*/
/* This version fixes an odd bug reported by Markus Stephany.  Zip
   self-extracting archives created by WinZip can have their first local
   signature on any byte - we normally expect it to be aligned to 32
   bits.  This fix makes it a little slower to read the dir of self-
   extracting archives, but at least it will work right in every case now!
*/
/* The List method reads thru all entries in the local Zip directory.
   This is triggered by an assignment to the ZipFilename, or by calling
   this method directly. */
void __fastcall TZipBuilder::List( void ) { // All work is local - no DLL calls.
	TFileStream  *ZipStream;
	ZipDirEntry  *pzd;
	long          Sig, Res, Count;
	char          Name[256];
	bool			  FirstEntryFound;
	Byte			  Byt;

	// Can't do LIST at design time.
	if ( ComponentState.Contains( csDesigning ) ) return;

	// Zero out any previous entries.
	FreeZipDirEntryRecords();

	// Don't complain - this may intentionally be a new zip file.
	if ( !FileExists( FZipFilename ) ) return;

	FirstEntryFound = false;
	Count		  = 0;
	FSFXOffset = 0;
	ZipStream = new TFileStream( FZipFilename, fmOpenRead );
	// The smallest ZipSfx code is a little bigger than 14K.  We'll skip
	// the first 14K, since a valid zip entry can't be so early in file
	if ( UpperCase( ExtractFileExt( FZipFilename ) ) == ".EXE" )
		ZipStream->Seek( 14000, soFromBeginning );
	try {
		while ( true ) {
			if ( !FirstEntryFound ) {
				/* Bug fix for WinZip-created self-extracting archives.
					It makes archives with local headers that don't necessarily
					line up in a "mod 4" manner from beginning of file.
					Read the zip file one byte at a time until we find the
					first local zip header.  From there on, everything will
					be properly aligned. This won't slow down processing on
					non-self-extracting archives, but it will take longer to
					read the dir on self-extracting archives.						 */
				Res = ZipStream->Read( &Byt, 1 );
				if ( Res == HFILE_ERROR || Res != 1 ) {
					// raise EStreamError.create('Error reading Zip File');
					ShowMessage( "No valid zip entries found!" );
					break;
				}
				Count++;
				// We'll allow 60000 attempts to find byte 1 of a local header.
				// Most variations of self-extracting code should be under 64K.
				if ( Count > 60000 ) {
					// ZipFilename:='';
					// raise EStreamError.create('Error reading Zip File');
					ShowMessage( "No valid zip entries found!" );
					break;
				}
				if ( Byt != 0x50 ) continue;
				Res = ZipStream->Read( &Byt, 1 );
				if ( Res == HFILE_ERROR || Res != 1 ) {
					// raise EStreamError.create('Error 1b reading Zip File');
					ShowMessage( "No valid zip entries found!" );
					break;
				}
				if ( Byt != 0x4b ) continue;
				Res = ZipStream->Read( &Byt, 1 );
				if ( Res == HFILE_ERROR || Res != 1 ) {
					// raise EStreamError.create('Error 1c reading Zip File');
					ShowMessage( "No valid zip entries found!" );
					break;
				}
				if ( Byt != 0x03 ) continue;
				Res = ZipStream->Read( &Byt, 1 );
				if ( Res == HFILE_ERROR || Res != 1 ) {
					// raise EStreamError.create('Error 1d reading Zip File');
					ShowMessage( "No valid zip entries found" );
					break;
				}
				if ( Byt != 0x04 ) continue;
				FirstEntryFound = true;		// next time, we'll read 32 bits at a time.
				Sig = LocalFileHeaderSig;	// we've read all 4 bytes.
				FSFXOffset = ZipStream->Position - 4; // subt. size of signature
			} else {
				Res = ZipStream->Read( &Sig, sizeof( Sig ) );
				if ( Res == HFILE_ERROR || Res != (signed)sizeof( Sig ) )
					throw EStreamError( "Error reading Zip File!" );
			}
			if ( Sig == LocalFileHeaderSig ) {
				//===============================================================
				// This is what we want.  We'll read the local file header info.

				// Create a new ZipDirEntry record, and zero fill it.
				pzd = new ZipDirEntry;
				memset( pzd, '\0', sizeof( ZipDirEntry ) );

				// fill the ZipDirEntry struct with local header info for one entry.
				/* Note: In the "if" statement's first clause we're reading the info
				for a whole Zip dir entry, not just the version info. */
				if ( ( ZipStream->Read( &pzd->Version, LocalDirEntrySize ) == LocalDirEntrySize )
						&& ( ZipStream->Read( Name, pzd->FileNameLength ) == pzd->FileNameLength ) ) {
              	Name[pzd->FileNameLength] = 0;
					pzd->FileName = ReplaceForwardSlash( Name );
				} else {
					delete pzd;  // Bad entry - free up memory for it.
					if ( !FZipContents->Count ) {
						/* test code to see if we can ignore problems with some
							SFX code that contains a false local signature			*/
						FirstEntryFound = false;
						continue;
					} else throw EStreamError( "Error 2 reading Zip file" );
				}

				if ( ( ZipStream->Position + pzd->ExtraFieldLength + pzd->CompressedSize ) > ( ZipStream->Size - 22 ) ) {
            	// Should never happen due to presence of central dir.
					if ( !FZipContents->Count ) {
						/* test code to see if we can ignore problems with some
							SFX code that contains a false local signature			*/
						FirstEntryFound = false;
						continue;
					} else throw EStreamError( "Error 3 reading Zip file" + pzd->FileName );
				}
				if ( pzd->ExtraFieldLength > 0 ) {
            	// Skip over the extra fields.
               Res = (ZipStream->Position + pzd->ExtraFieldLength);
               if ( ZipStream->Seek( pzd->ExtraFieldLength, soFromCurrent) != Res )
                  throw EStreamError( "Error 4 reading Zip file" + pzd->FileName );
				}

				// Skip over the compressed data for the file entry just parsed.
				Res = (ZipStream->Position + pzd->CompressedSize);
            if (ZipStream->Seek( pzd->CompressedSize, soFromCurrent) != Res )
            	throw EStreamError( "Error 5 reading Zip file" + pzd->FileName );
				//================================================================
				FZipContents->Add( (void *)pzd );
			} // End of local stuff.
			// We're not going to read the Central or End directories.
			else if ( (Sig == CentralFileHeaderSig) || (Sig == EndCentralDirSig) )
				break;   // Found end of local stuff - we're done.
		} // End while loop
	} // End of try.
	catch ( EStreamError &e ) {
		ShowMessage( e.Message );
	}
	catch ( ... ) {
		ShowMessage( "Unknow error in List() section!" );
	}

	delete ZipStream;

	// Let user's program know we just refreshed the zip dir contents.
	if ( FOnDirUpdate ) FOnDirUpdate( this );
}

void __fastcall TZipBuilder::SetZipSwitches( void ) {
	ZipDLL::ZipParms *zp1 = &ZipParms1;

	zp1->Version = ZIPVERSION;		// Version we expect the DLL to be.
	zp1->Caller  = this;				// point to our VCL instance; returned in callback.

	/* Since we don't want the DLL's to generate their own dialog boxes
		for error reporting, we'll set the window handle. Since we
		are doing this, we must also set fQuiet to true. */
	zp1->Handle = FHandle;	// Used for DLL dialogs - esp: password.
	zp1->fQuiet = true;	   // We'll report errors upon notification in our callback.

	zp1->ZCallbackFunc  = ZCallback;	// Pass addr of function to be called from DLL.

	zp1->fJunkSFX       = false;		// if True, Convert input .EXE file to .ZIP.
	zp1->fComprSpecial  = false;		// if True, Try to compr already compressed files.
	zp1->fSystem        = false;		// if True, Include system and hidden files.
	zp1->fVolume        = false;		// if True, Include volume label from root dir.
	zp1->fExtra         = false;		// if True, Include extended file attributes.

	//  fDate and Date are not yet supported
	zp1->fDate          = false;		// if True, Exclude files earlier than specified date.
	//  Date = "100592";  // Date to include files after; only used if fDate=TRUE.

	zp1->fLevel = FAddCompLevel;		// Compression level (0 - 9, 0=none and 9=best).
	zp1->fCRLF_LF       = false;		// if True, Translate text file CRLF to LF (if dest Unix).
	zp1->fGrow          = true;		// if True, Allow appending to a zip file (-g).

	zp1->seven = 7;       // used to QC the data structure passed to DLL
	zp1->fDeleteEntries = false;		// distinguish between Add and Delete

	zp1->fTraceEnabled	= (FTrace)	 ? true : false;
	zp1->fVerboseEnabled = (FVerbose) ? true : false;
	if (zp1->fTraceEnabled && !FVerbose)
		zp1->fVerboseEnabled = true;	// If tracing, we want verbose also.

	// Convert all filenames to 8x3 format.
	zp1->fForce      = ( FAddOptions.Contains(AddForceDOS) ) ? true : false;
	// Make zipfile's timestamp same as newest file.
	zp1->fLatestTime = ( FAddOptions.Contains(AddZipTime) )  ? true : false;
	// Dangerous, beware!
	zp1->fMove       = ( FAddOptions.Contains(AddMove) )     ? true : false;
	zp1->fFreshen    = ( FAddOptions.Contains(AddFreshen) )  ? true : false;
	zp1->fUpdate     = ( FAddOptions.Contains(AddUpdate) )   ? true : false;
	if ( zp1->fFreshen && zp1->fUpdate )
		zp1->fFreshen = false;  	// Update has precedence over freshen.
	// if true DLL will prompt for password
	zp1->fEncrypt	  = ( FAddOptions.Contains(AddEncrypt) )	? true : false;

	/* NOTE: If user wants recursion, then he probably also wants
		AddDirNames, but we won't demand it. */
	zp1->fRecurse = ( FAddOptions.Contains(AddRecurseDirs) ) ? true : false;
	zp1->fNoDirEntries = true;  	// Don't store dirnames by themselves.

	zp1->fJunkDir    = (!FAddOptions.Contains(AddDirNames) ) ? true : false;
	// New for version 1.2
	zp1->fSystem  = ( FAddOptions.Contains(AddHiddenFiles) ) ? true : false;
}

void __fastcall TZipBuilder::SetUnZipSwitches( void ) {
	UnzipDLL::UnZipParms *uz1 = &UnZipParms1;

	uz1->Version = ZIPVERSION;			// Version we expect the DLL to be
	uz1->Caller  = this;					// point to our VCL instance; returned in callback.

	/* Since we don't want the DLLs to generate their own dialog boxes
		for error reporting, we'll set the window handle. Since we
		are doing this, we must also set fQuiet to true.					*/
	uz1->Handle = FHandle;				// Used for DLL dialogs - esp: password.
	uz1->fQuiet = true;  				// We'll report errors upon notification in our callback.

	uz1->ZCallbackFunc = ZCallback;	// Pass addr of function to be called from DLL.

	uz1->fTraceEnabled   = (FTrace)   ? true : false;
	uz1->fVerboseEnabled = (FVerbose) ? true : false;
	if ( uz1->fTraceEnabled && !uz1->fVerboseEnabled )
		uz1->fVerboseEnabled = true;	// If tracing, we want verbose also.

	uz1->fQuiet    = true;				// No DLL error reporting.
	uz1->fComments = false;				// Zipfile comments - not supported.
	uz1->fConvert  = false;				// ASCII/EBCDIC conversion - not supported.
	uz1->seven     = 7;					// Used to QC the data structure passed to DLL.

	uz1->fDirectories = ( FExtrOptions.Contains(ExtrDirNames) )  ? true : false;
	uz1->fOverwrite   = ( FExtrOptions.Contains(ExtrOverWrite) ) ? true : false;
	uz1->fFreshen     = ( FExtrOptions.Contains(ExtrFreshen) )   ? true : false;
	uz1->fUpdate      = ( FExtrOptions.Contains(ExtrUpdate) )    ? true : false;
	uz1->fTest	      = ( FExtrOptions.Contains(ExtrTest) )		 ? true : false;

	// Update has precedence over freshen.
	if ( uz1->fFreshen && uz1->fUpdate ) uz1->fFreshen = false;
}

void __fastcall TZipBuilder::GetAddPassword( void ) {
	FPassword = "";
	System::AnsiString s1 = GetPassword( 1 );
	if ( s1.Length() ) {
		System::AnsiString s2 = GetPassword( 0 );
		if ( s2.Length() ) {
			if ( CompareStr( s1, s2 ) )
				ShowMessage( "Error - passwords do NOT match\nPassword ignored" );
	   	else
				FPassword = s2;
		}
	}
}

// Same as GetAddPassword, but does NOT verify
void __fastcall TZipBuilder::GetExtrPassword( void ) {
	FPassword = GetPassword( 1 );
}

System::AnsiString __fastcall TZipBuilder::GetPassword( int Type ) {
	System::AnsiString s1 = InputBox( "Password", (Type) ? "Enter Password" : "Confirm Password", "" );
	if ( s1.Length() > 80  || !s1.Length() ) s1 = "";
	return s1;
}

void __fastcall TZipBuilder::Add( void ) {
	bool AutoLoad = false;

	FSuccessCnt = 0;
	if ( !FFSpecArgs->Count ) {
      ShowMessage( "Error - no files to zip!" );
      return;
	}
	/* We must allow a zipfile to be specified that doesn't already exist,
      so don't check here for existance. */
	if ( FZipFilename == "" ) {   // Make sure we have a zip filename.
		ShowMessage( "Error - no zip file specified!" );
		return;
	}
	if ( FZipBusy ) return;
	// Make sure we can't get back in here while work is going on.
	FCancel  = false;

	if ( !ZipDllHandle ) {
		AutoLoad = true;				// User's program didn't load the DLL.
		Load_Zip_Dll();				// Load it...
	}
	if ( !ZipDllHandle ) return;	// Load failed - error msg was shown to user.
	FZipBusy = true;

	SetZipSwitches();
	ZipDLL::ZipParms *zp1 = &ZipParms1;

	zp1->PZipFN = StrAlloc( 256 );				// Allocate room for null terminated string.
	StrPCopy( zp1->PZipFN, FZipFilename );		// Name of zip file.
	zp1->PZipPassword = StrAlloc( 81 );			// Allocate room for null terminated string.
	StrPCopy( zp1->PZipPassword, FPassword );	// Password for encryption/decryption.
	zp1->argc = 0;										// Init to zero.

	/* Copy filenames from the Stringlist to new var's we will alloc
		storage for.  This lets us append the null needed by the DLL. */
	for ( int i = 0; i < FFSpecArgs->Count; i++ ) {
		zp1->PFileNames[i] = StrAlloc( 256 );	// alloc room for the filespec.
		StrPCopy( zp1->PFileNames[i], FFSpecArgs->Strings[i] );	// file to add to archive.
		zp1->argc++;
	}
	// argc is now the no. of filespecs we want added.

	try {  // Pass in a ptr to parms.
		FSuccessCnt = ZipDllExec( zp1 );
	}
	catch ( ... ) {
		ShowMessage( "Fatal Error ZipDLL.DLL: abort exception" );
	}

	FFSpecArgs->Clear();
	/* Free the memory for the zipfilename and parameters
		we know we had a filename, so we'll dispose it's space. */
	StrDispose( zp1->PZipFN );
	StrDispose( zp1->PZipPassword );
	// Loop thru each parameter filename and dispose it's space.
	for ( int i = zp1->argc - 1; i >= 0; i-- ) StrDispose( zp1->PFileNames[i] );

	if ( AutoLoad ) Unload_Zip_Dll();

	FCancel	= false;
	FZipBusy	= false;
	if ( FSuccessCnt > 0 ) List();  // Update the Zip Directory by calling List method.
}

void __fastcall TZipBuilder::Delete( void ) {
	bool AutoLoad = false;

	FSuccessCnt = 0;
	if ( !FFSpecArgs->Count ) {
		ShowMessage( "Error - no files selected for deletion" );
		return;
	}
	if (!FileExists( FZipFilename )) {
		ShowMessage( "Error - no zip file specified" );
		return;
	}
	if ( FZipBusy ) return;
	FCancel  = false;

	if ( !ZipDllHandle ) {
		AutoLoad = true;				// User's program didn't load the DLL.
		Load_Zip_Dll();				// Load it...
	}
	if ( !ZipDllHandle ) return;	// Load failed - error msg was shown to user.
	FZipBusy = true;					// Delete uses the ZIPDLL, so it shares the FZipBusy flag.

	SetZipSwitches();					// Override "add" behavior assumed by SetZipSwitches.

	ZipDLL::ZipParms *zp1 = &ZipParms1;
	zp1->fDeleteEntries	 = true;
	zp1->fGrow				 = false;
	zp1->fJunkDir			 = false;
	zp1->fMove				 = false;   // Since version 1.2
	zp1->fFreshen			 = false;
	zp1->fUpdate			 = false;
	zp1->fRecurse			 = false;	// Bug fix per Angus Johnson.
	zp1->fEncrypt			 = false;   // You don't need the password to delete a file.

	zp1->PZipFN = StrAlloc( 256 );				// Allocate room for null terminated string.
	StrPCopy( zp1->PZipFN, FZipFilename );		// Name of zip file.
	zp1->PZipPassword = StrAlloc( 81 );			// Allocate room for null terminated string.
	StrPCopy( zp1->PZipPassword, FPassword ); // Password for encryption/decryption.
	zp1->argc = 0;

	/* Copy filenames from the Stringlist to new var's we will allow
		storage for.  This lets us append the null needed by the DLL. */
	for (int i = 0; i < FFSpecArgs->Count; i++ ) {
      zp1->PFileNames[zp1->argc] = StrAlloc( 256 );  // Alloc room for the filespec.
      // ShowMessage(fFSpecArgs[i]); // for debugging.
		// File to delete from archive.
      StrPCopy( zp1->PFileNames[zp1->argc], FFSpecArgs->Strings[i] );
      zp1->argc++;
	}
	// argc is now the no. of filespecs we want deleted.

	try { // Pass in a ptr to parms.
		FSuccessCnt = ZipDllExec( zp1 );
	}
	catch ( ... ) {
		ShowMessage( "Fatal Error ZipDLL.DLL: abort exception" );
	}

	FFSpecArgs->Clear();

	// Free the memory.
	StrDispose( zp1->PZipFN );
	StrDispose( zp1->PZipPassword );
	for ( int i = zp1->argc - 1; i >= 0; i-- ) StrDispose( zp1->PFileNames[i] );

	if ( AutoLoad ) Unload_Zip_Dll();

	FZipBusy = false;
	if ( FSuccessCnt > 0 ) List();  // Update the Zip Directory by calling List method.
}

void __fastcall TZipBuilder::Extract( void ) {
	bool AutoLoad = false;

	FSuccessCnt = 0;
	if ( !FileExists( FZipFilename ) ) {
		ShowMessage( "Error - no zip file specified" );
		return;
	}
	FCancel  = false;
	if ( FUnzBusy ) return;

	if ( !UnzDllHandle ) {
		AutoLoad = true;				// user's program didn't load the DLL.
		Load_Unz_Dll();				// Load it...
	}
	if ( !UnzDllHandle ) return;	// Load failed - error msg was shown to user.

	// Make sure we can't get back in here while work is going on.
	FUnzBusy = true;

	// Select the extract directory.
	if ( DirectoryExists( FExtrBaseDir ) ) SetCurrentDir( FExtrBaseDir );

	SetUnZipSwitches();

	UnzipDLL::UnZipParms *uz1 = &UnZipParms1;
	uz1->PZipFN = StrAlloc( 256 );				// Allocate room for null terminated string.
	StrPCopy( uz1->PZipFN, FZipFilename );		// Name of zip file.
	uz1->PZipPassword = StrAlloc( 81 );			// Allocate room for null terminated string.
	StrPCopy( uz1->PZipPassword, FPassword );	// Password for encryption/decryption.

	/* Copy filenames from the Stringlist to new var's we will alloc
		storage for.  This lets us append the null needed by the DLL. */
	for ( int i = 0; i < FFSpecArgs->Count; i++ ) {
		uz1->PFileNames[i] = StrAlloc( 256 );							// Alloc room for the filespec.
		// ShowMessage( FFSpecArgs->Strings[i] );						// For debugging.
		StrPCopy( uz1->PFileNames[i], FFSpecArgs->Strings[i] );	// File to extr from archive.
	}
	uz1->argc = FFSpecArgs->Count;

	// argc is now the no. of filespecs we want extracted.

	try {  // Pass in a ptr to parms.
		FSuccessCnt = UnzDllExec( uz1 );
	}
	catch ( ... ) {
		ShowMessage( "Fatal Error UnzDLL.DLL: abort exception" );
	}

	FFSpecArgs->Clear();

	// Free the memory.
	StrDispose( uz1->PZipFN );
	StrDispose( uz1->PZipPassword );
	for ( int i = uz1->argc - 1; i >= 0; i--) StrDispose( uz1->PFileNames[i] );

	if ( AutoLoad ) Unload_Unz_Dll();

	FCancel  = false;
	FUnzBusy = false;
	// No need to call the List method; contents unchanged.
}

void __fastcall TZipBuilder::Load_Zip_Dll(void) {
	// This is new code that tries to locate the DLL before loading it.
	// The user can specify a dir in the DLLDirectory property.
	// The user's dir is our first choice, but we'll still try the
	// standard Windows DLL dirs (Windows, Windows System, Current dir).
	System::AnsiString FullPath = "ZIPDLL.DLL";
	if ( FDLLDirectory != "" )
		if ( FileExists( FDLLDirectory + "\\ZIPDLL.DLL" ) )
			FullPath = FDLLDirectory + "\\ZIPDLL.DLL";

	long OldMode = ::SetErrorMode( SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX );

	try {
		if ( ( ZipDllHandle = ::LoadLibrary( FullPath.c_str() )) != NULL ) {
			if ( FTrace ) ShowMessage( "ZIP DLL Loaded" );
			ZipDllExec			= (GetZipExecAddress)::GetProcAddress( ZipDllHandle, "ZipDllExec" );
			GetZipDllVersion	= (GetZipVersionAddress)::GetProcAddress( ZipDllHandle, "GetZipDllVersion" );
			if ( !ZipDllExec )
				ShowMessage( "ZipDllExec function not found in ZIPDLL.DLL!" );
			if ( !GetZipDllVersion )
				ShowMessage( "GetZipDllVersion function not found in ZIPDLL.DLL!" );
		} else {
			ZipDllHandle = NULL;		// Reset.
			ShowMessage( "ZIPDLL.DLL not found!" );
		}
	} catch ( ... ) { }
	::SetErrorMode( OldMode );
}

void __fastcall TZipBuilder::Load_Unz_Dll(void) {
	// This is new code that tries to locate the DLL before loading it.
	// The user can specify a dir in the DLLDirectory property.
	// The user's dir is our first choice, but we'll still try the
	// standard Windows DLL dirs (Windows, Windows System, Current dir).
	System::AnsiString FullPath = "UNZDLL.DLL";
	if ( FDLLDirectory != "" )
		if ( FileExists( FDLLDirectory + "\\UNZDLL.DLL" ) )
			FullPath = FDLLDirectory + "\\UNZDLL.DLL";

	long OldMode = ::SetErrorMode( SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX );

	try {
		if ( ( UnzDllHandle = ::LoadLibrary( FullPath.c_str() )) != NULL ) {
			if ( FTrace ) ShowMessage( "UNZDLL Loaded!" );
			UnzDllExec			= (GetUnzExecAddress)::GetProcAddress( UnzDllHandle, "UnzDllExec" );
			GetUnzDllVersion	= (GetUnzVersionAddress)::GetProcAddress( UnzDllHandle, "GetUnzDllVersion" );
			if ( !UnzDllExec )
				ShowMessage( "UnzDllExec function not found in UNZDLL.DLL!" );
			if ( !GetUnzDllVersion )
				ShowMessage( "GetZipDllVersion function not found in UNZDLL.DLL!" );
		} else {
			UnzDllHandle = NULL;		// Reset.
			ShowMessage( "UNZDLL.DLL not found!" );
		}
	} catch( ... ) { }
	::SetErrorMode( OldMode );
}

void __fastcall TZipBuilder::Unload_Zip_Dll(void) {
	if ( ZipDllHandle ) ::FreeLibrary( ZipDllHandle );
	ZipDllHandle = NULL;
}

void __fastcall TZipBuilder::Unload_Unz_Dll(void) {
	if ( UnzDllHandle ) ::FreeLibrary( UnzDllHandle );
	UnzDllHandle = NULL;
}

System::AnsiString __fastcall TZipBuilder::AppendSlash( System::AnsiString sDir ) {
	return ( (sDir.Length() > 0) && (sDir[sDir.Length()] != '\\') ) ? ( sDir + '\\' ) : sDir;
}

char * __fastcall TZipBuilder::ReplaceForwardSlash( char *aStr ) {
	while ( char *aPtr = StrScan( aStr, '/' ) ) *aPtr = '\\';
	return aStr;
}

// Used CopyFile, ConvertSFX and ConvertZip.
int __fastcall TZipBuilder::CopyBuffer( int &InFile, int &OutFile ) {
	const BufSize = 8192,		// Keep under 12K to avoid Winsock problems on Win95.
										// If chunks are too large, the Winsock stack can
										// lose bytes being sent or received.
			SE_CopyError = -2;	// Write error or no memory during copy.
	int   SizeR, Result = SE_CopyError;
	char *Buffer = NULL;

	try {
		Buffer = new char[BufSize];
		Result = 0;					// No memory error!
		do {
			SizeR = FileRead( InFile, Buffer, BufSize );
			if ( FileWrite( OutFile, Buffer, SizeR ) == -1 ) {
				Result = SE_CopyError;
				break;
			}
			Application->ProcessMessages();	// Mostly for winsock.
		} while ( SizeR == BufSize );
	} catch ( ... ) { }
	delete[] Buffer;
	return Result;
}

// Returns 0 if good copy, or a negative error code.
int __fastcall TZipBuilder::CopyFile( const System::AnsiString InFileName, const System::AnsiString OutFileName ) {
	const
		SE_CreateError   = -1,	// Error in open or creation of OutFile.
		SE_OpenReadError = -3,	// Error in open or Seek of InFile.
		SE_SetDateError  = -4,	// Error setting date/time of OutFile.
		SE_GeneralError  = -9;
	int InFile, OutFile, InSize = -1, OutSize = -1, Result = SE_OpenReadError;

	if ( !FileExists( InFileName ) ) return Result;
	Screen->Cursor = crHourGlass;
	if ( (InFile = FileOpen( InFileName, fmOpenRead | fmShareDenyWrite )) != -1 ) {
		if ( FileExists( OutFileName ) ) ::DeleteFile( OutFileName.c_str() );
		if ( (OutFile = FileCreate( OutFileName )) != -1 ) {
			Result = CopyBuffer( InFile, OutFile );
			if ( !Result && FileSetDate( OutFile, FileGetDate( InFile ) ) != 0 )
				Result = SE_SetDateError;
			OutSize = FileSeek( OutFile, 0, 2 );
			FileClose( OutFile );
		} else Result = SE_CreateError;
		InSize = FileSeek( InFile, 0, 2 );
		FileClose( InFile );
	}
	// An extra check if the filesizes are the same.
	if ( !Result && (InSize == -1 || OutSize == -1 || InSize != OutSize) )
		Result = SE_GeneralError;
	// Don't leave a corrupted outfile lying around.
	if ( Result ) ::DeleteFile( OutFileName.c_str() );

	Screen->Cursor = crDefault;
	return Result;
}

// Convert an .ZIP archive to a .EXE archive.
// Returns 0 if good, or else a negative error code.
int __fastcall TZipBuilder::ConvertSFX( void ) {
	const
		SE_CreateError   = -1,  // Error in open of OutFile.
		SE_CopyError     = -2,  // Read or write error during copy.
		SE_OpenReadError = -3,  // Error in open of InFile.
		SE_GeneralError  = -9;
	int InFile = -1, OutFile, Result = SE_GeneralError;
	int SFXSize = -1, ZipSize = -1, OutSize = -1;
	char dirbuf[MAX_PATH];

	if ( !FileExists( FZipFilename ) ) {
		ShowMessage( "Error - no zip file specified" );
		return Result;
	}
	if ( UpperCase( ExtractFileExt( FZipFilename ) ) != ".ZIP" ) {
		ShowMessage( "Error: input file is not a zip file" );
		return Result;
	}
	/* Do a simple validation to ensure that the 3 variable length text
    * fields are small enough to fit inside the SFX control block. */
   int L = FSFXCaption.Length() + FSFXDefaultDir.Length() + FSFXCommandLine.Length();
	if ( L > 249 ) {
		ShowMessage( "Error - The total size of the 3 text properties exceeds 249!\
			\r\nSFXCaption + SFXDefaultDir + SFXCommandLine = " + IntToStr( L ) );
		return Result;
	}

	// Try to find the SFX binary file: ZIPSFX.BIN
	// Look in the location given by the SFXPath property first.
	if ( !FileExists( FSFXPath ) ) {
		// Try the current directory.
		FSFXPath = "ZIPSFX.BIN";
		if ( !FileExists( FSFXPath ) ) {
			// Try the application directory.
			FSFXPath = ExtractFilePath( ParamStr( 0 ) ) + "\\ZIPSFX.BIN";
			if ( !FileExists( FSFXPath ) ) {
				// Try the Windows System dir (where DLL's go).
				::GetSystemDirectory( dirbuf, MAX_PATH );
				FSFXPath = StrPas( dirbuf ) + "\\ZIPSFX.BIN";
				if ( !FileExists( FSFXPath ) ) {
					// Try the Windows dir (where DLL's go).
					::GetWindowsDirectory( dirbuf, MAX_PATH );
					FSFXPath = StrPas( dirbuf ) + "\\ZIPSFX.BIN";
					if ( !FileExists( FSFXPath ) ) {
						// Try the dir specified in the DLLDirectory property.
						if ( FDLLDirectory != "" ) {
							FSFXPath = FDLLDirectory + "\\ZIPSFX.BIN";
							if ( !FileExists( FSFXPath ) ) {
								ShowMessage( "Error - ZIPSFX.BIN not found!" );
								return Result;
							}
						} else {
							ShowMessage( "Error - ZIPSFX.BIN not found!" );
							return Result;
						}
					}
				}
			}
		}
	}
	Screen->Cursor = crHourGlass;
	char sfxblk[ 256 ] = { "MPU" }, cll = 0;

	// Create a packed byte with various 1 bit settings.
	if ( FSFXOptions.Contains( SFXAskCmdLine ) ) cll  = 1;			// Don't ask user if he wants to run cmd line.
	if ( FSFXOptions.Contains( SFXAskFiles ) )	cll |= 2;			// Allow user to edit files in selection box.
	if ( FSFXOptions.Contains( SFXHideOverWriteBox ) ) cll |= 4;	// Hide overwrite mode box at runtime.
	if ( FSFXOverWriteMode == OvrAlways ) cll |= 8;						// Default = ovrConfirm.
	if ( FSFXOverWriteMode == OvrNever  ) cll |= 16;
	sfxblk[3] = cll;

	sfxblk[4] = (BYTE)FSFXCaption.Length();
	sfxblk[5] = (BYTE)FSFXDefaultDir.Length();
	sfxblk[6] = (BYTE)FSFXCommandLine.Length();
	StrLCopy( &sfxblk[7], FSFXCaption.c_str(), sfxblk[4] );
	StrLCopy( &sfxblk[7 + sfxblk[4]], FSFXDefaultDir.c_str(), sfxblk[5] );
	StrLCopy( &sfxblk[7 + sfxblk[4] + sfxblk[5]], FSFXCommandLine.c_str(), sfxblk[6] );

	// Create the destination.
	System::AnsiString OutFileName = ChangeFileExt( FZipFilename, ".exe" );
	if ( FileExists( OutFileName ) ) ::DeleteFile( OutFileName.c_str() );
	if ( (OutFile = FileCreate( OutFileName )) != -1 ) {
		// Copy the SFX code to destination .EXE file.
		if ( (InFile = FileOpen( SFXPath, fmOpenRead | fmShareDenyWrite )) != -1 ) {
			Result = CopyBuffer( InFile, OutFile );
			SFXSize = FileSeek( InFile, 0, 2 );
			FileClose( InFile );
			InFile = -1;
		} else Result = SE_OpenReadError;
		// Copy the special SFX block to the destination.
		if ( !Result ) {
			if ( FileWrite( OutFile, sfxblk, 256 ) != 256 ) Result = SE_CopyError;
			if ( !Result ) {
				// Copy the ZIP file to the destination.
				if ( (InFile = FileOpen( FZipFilename, fmOpenRead | fmShareDenyWrite )) != -1 ) {
					Result = CopyBuffer( InFile, OutFile );
					ZipSize = FileSeek( InFile, 0, 2 );
					FileClose(  InFile );
				} else Result = SE_OpenReadError;
			}
		}
		OutSize = FileSeek( OutFile, 0, 2 );
		FileClose( OutFile );
	} else Result = SE_CreateError;

	if ( !Result && (SFXSize == -1 || ZipSize == -1 || OutSize == -1 || OutSize != SFXSize + ZipSize + 256 ) )
   	Result = SE_GeneralError;

   if ( !Result ) {
		::DeleteFile( FZipFilename.c_str() );
		FZipFilename = OutFileName;	// The .EXE file is now the default archive.
		List();								// Explicitly invoke the List method.
	} else ::DeleteFile( OutFileName.c_str() );

	Screen->Cursor = crDefault;
   return Result;
}

// Convert an .EXE archive to a .ZIP archive.
// Returns 0 if good, or else a negative error code.
int __fastcall TZipBuilder::ConvertZIP( void ) {
	const
		 SE_CreateError   = -1,  // Error in creation of OutFile.
		 SE_CopyError     = -2,  // Seek error in InFile.
		 SE_OpenReadError = -3,  // Error in open of InFile.
		 SE_GeneralError  = -9;
	int InFile = -1, OutFile, InSize = -1, OutSize = -1, Result = SE_GeneralError;

	if ( !FileExists( FZipFilename ) ) {
		ShowMessage( "Error - no .EXE file specified" );
		return Result;
	}
	if ( UpperCase( ExtractFileExt( FZipFilename ) ) != ".EXE" )  {
		ShowMessage( "Error: input file is not an .EXE file" );
		return Result;
	}

   // The FSFXOffset is the location where the zip file starts inside
   // the .EXE archive.  It is calculated during a ZipBuilder List operation.
   // Since a LIST is done when a filename is assigned, we know that
   // a LIST has already been done on the correct archive.
	if ( !FSFXOffset ) {
		ShowMessage( "Error determining the type of SFX archive" );
		return Result;
	}

	// Create the destination.
	Screen->Cursor = crHourGlass;
	Result = SE_CopyError;
	System::AnsiString OutFileName = ChangeFileExt( FZipFilename, ".zip" );
	if ( FileExists( OutFileName ) ) ::DeleteFile( OutFileName.c_str() );
	if ( (OutFile = FileCreate( OutFileName )) != -1 ) {
		if ( (InFile = FileOpen( FZipFilename, fmOpenRead | fmShareDenyWrite )) != -1 ) {
			// Step over SFX code.
			if ( FileSeek( InFile, FSFXOffset, 0 ) != -1 ) {
				// Copy the Zip'ed code to destination .ZIP file.
				Result = CopyBuffer( InFile, OutFile );
			}
			InSize = FileSeek( InFile, 0, 2 );
         FileClose( InFile );
		} else Result = SE_OpenReadError;
		OutSize = FileSeek( OutFile, 0, 2 );
		FileClose( OutFile );
	} else Result = SE_CreateError;

	if ( !Result && ( InSize == -1 || OutSize == -1 || OutSize != InSize - FSFXOffset ) )
		Result = SE_GeneralError;

	if ( !Result ) {
		::DeleteFile( FZipFilename.c_str() );
		FZipFilename = OutFileName;	// The .ZIP file is now the default archive.
		List();								// Explicitly invoke the List method.
	} else ::DeleteFile( OutFileName.c_str() );

	Screen->Cursor = crDefault;
   return Result;
}

