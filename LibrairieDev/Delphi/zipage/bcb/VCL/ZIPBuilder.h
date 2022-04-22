//---------------------------------------------------------------------------
#ifndef ZipMainUnitH
#define ZipMainUnitH

//---------------------------------------------------------------------------
#include <vcl\FileCtrl.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Controls.hpp>
#include <vcl\Dialogs.hpp>
#include <vcl\Messages.hpp>
#include <vcl\Classes.hpp>
#include <vcl\SysUtils.hpp>
#include <vcl\Windows.hpp>
#include <vcl\System.hpp>

#include "CallBackUnit.h"
#include "UnzipDLL.h"
#include "ZipDLL.h"


#define ZIPVERSION 140
//---------------------------------------------------------------------------
extern unsigned long __stdcall ZCallback( CallBackUnit::PZCallBackStruct ZCallBackRec );

const long LocalFileHeaderSig   = 0x04034B50; // 'PK34 (in file: 504B0304)'
const long CentralFileHeaderSig = 0x02014B50; // 'PK12'
const long EndCentralDirSig     = 0x06054B50; // 'PK56'
const int  LocalDirEntrySize    = 26;         // Size of zip dir entry in local zip directory.

#pragma option -a1
struct ZipDirEntry {
	Word					 Version;
	Word					 Flag;
	Word					 CompressionMethod;
	long					 DateTime;          		 // Time: Word; Date: Word;
	long					 CRC32;
	long					 CompressedSize;
	long					 UncompressedSize;
	Word					 FileNameLength;
	Word					 ExtraFieldLength;
	System::AnsiString FileName;
};
#pragma option -a.

enum ProgressType { NewFile, ProgressUpdate, EndOfBatch };
enum AddOptsEnum  { AddDirNames, AddRecurseDirs, AddMove, AddFreshen, AddUpdate,
						  AddZipTime,  AddForceDOS,    AddHiddenFiles,      AddEncrypt };
typedef Set<AddOptsEnum, AddDirNames, AddEncrypt>  AddOpts;

enum ExtrOptsEnum { ExtrDirNames, ExtrOverWrite, ExtrFreshen, ExtrUpdate, ExtrTest };
typedef Set<ExtrOptsEnum, ExtrDirNames, ExtrTest>  ExtrOpts;

enum OvrOpts      { OvrConfirm, OvrAlways, OvrNever };

enum SFXOptsEnum  { SFXAskCmdLine, SFXAskFiles, SFXHideOverWriteBox };
typedef Set<SFXOptsEnum, SFXAskCmdLine, SFXHideOverWriteBox> SfxOpts;


typedef void __fastcall (__closure *TProgressEvent)(System::TObject *Sender, ProgressType ProgrType, System::AnsiString FileName, long FileSize);
typedef void __fastcall (__closure *TMsgEvent)(System::TObject *Sender, int ErrCode, System::AnsiString Message);

class TZipBuilder : public Classes::TComponent {
	private:
		bool				       FVerbose;
		bool				       FCancel;
		bool				       FTrace;
		bool  				    FZipBusy;
		bool					    FUnzBusy;
		bool						 FEncrypt;			// New v1.3
		HWND						 FHandle;			// set to 0 if you don't need DLL-generated dialog msgs
		int   					 FErrCode;
		int  					    FSuccessCnt;
		int						 FAddCompLevel;
		int						 FSFXOffset;		// New v1.3
		AddOpts					 FAddOptions;
		ExtrOpts					 FExtrOptions;
		SfxOpts					 FSFXOptions;		// New v1.4
		System::AnsiString    FMessage;
		System::AnsiString	 FPassword;			// New v1.3
		System::AnsiString	 FSFXPath;			// New v1.3
		Classes::TList       *FZipContents;
		System::AnsiString    FExtrBaseDir;
		Classes::TStrings    *FFSpecArgs;
		System::AnsiString    FZipFilename;
		ZipDLL::ZipParms      ZipParms1;
		UnzipDLL::UnZipParms  UnZipParms1;
		// New v1.4
		System::AnsiString	 FDLLDirectory;
		OvrOpts					 FSFXOverWriteMode;	// OvrConfirm  (others: OvrAlways, OvrNever)
      System::AnsiString	 FSFXCaption;			// dflt = "Self-extracting Archive"
		System::AnsiString	 FSFXDefaultDir;		// dflt = ""
		System::AnsiString	 FSFXCommandLine;		// dflt = ""

		// Event variables
		Classes::TNotifyEvent FOnDirUpdate;
		TProgressEvent        FOnProgress;
		TMsgEvent             FOnMessage;

		// Property get/set functions
		int  __fastcall GetCount(void);
		int  __fastcall GetZipVers(void);
		int  __fastcall GetUnzVers(void);
		void __fastcall SetFSpecArgs(Classes::TStrings *Value);
		void __fastcall SetFileName( System::AnsiString Value);
		void __fastcall SetDLLDirectory( System::AnsiString Value );	// New v1.4

		// Private "helper" functions
		void __fastcall   FreeZipDirEntryRecords(void);
		void __fastcall   SetZipSwitches(void);
		void __fastcall   SetUnZipSwitches(void);
		int  __fastcall   CopyBuffer( int &InFile, int &OutFile );
		char * __fastcall ReplaceForwardSlash( char *aStr );
		System::AnsiString __fastcall AppendSlash( System::AnsiString sDir );
		System::AnsiString __fastcall GetPassword( int Type );

	public:
		__fastcall virtual TZipBuilder( Classes::TComponent *AOwner );
		__fastcall virtual ~TZipBuilder( void );
		__property HWND  Handle     = {read=FHandle,     write=FHandle, nodefault};
		__property int   ErrCode    = {read=FErrCode,    nodefault};
		__property int   Count      = {read=GetCount,    nodefault};
		__property int   SuccessCnt = {read=FSuccessCnt, nodefault};
		__property int   ZipVers    = {read=GetZipVers,  nodefault};
		__property int   UnzVers    = {read=GetUnzVers,  nodefault};
		__property bool  Cancel     = {read=FCancel,     write=FCancel, nodefault};
		__property bool  ZipBusy    = {read=FZipBusy,    nodefault};
		__property bool  UnzBusy    = {read=FUnzBusy,    nodefault};
		__property System::AnsiString  Message     = {read=FMessage,     nodefault};
		__property Classes::TList     *ZipContents = {read=FZipContents, nodefault};

		void __fastcall Add( void );
		void __fastcall Delete( void );
		void __fastcall Extract( void );
		void __fastcall List( void );
		void __fastcall Load_Zip_Dll( void );
		void __fastcall Load_Unz_Dll( void );
		void __fastcall Unload_Zip_Dll( void );
		void __fastcall Unload_Unz_Dll( void );
		int  __fastcall CopyFile( const System::AnsiString src, const System::AnsiString dest );

		int  __fastcall ConvertSFX( void );
		int  __fastcall ConvertZIP( void );
		void __fastcall GetAddPassword( void );
		void __fastcall GetExtrPassword( void );

	__published:
		__property bool Verbose         = {read=FVerbose,      write=FVerbose,      nodefault};
		__property bool Trace           = {read=FTrace,        write=FTrace,        nodefault};
		__property int AddCompLevel     = {read=FAddCompLevel, write=FAddCompLevel, default=9};
		__property AddOpts  AddOptions  = {read=FAddOptions,   write=FAddOptions,   nodefault};
		__property ExtrOpts ExtrOptions = {read=FExtrOptions,  write=FExtrOptions,  nodefault};
		__property SfxOpts  SFXOptions  = {read=FSFXOptions,   write=FSFXOptions,   nodefault};
		__property System::AnsiString    ExtrBaseDir = {read=FExtrBaseDir, write=FExtrBaseDir, nodefault};
		__property Classes::TStrings    *FSpecArgs   = {read=FFSpecArgs,   write=SetFSpecArgs, nodefault};
		__property System::AnsiString    ZipFilename = {read=FZipFilename, write=SetFileName,  nodefault};
		__property System::AnsiString		Password		= {read=FPassword,	 write=FPassword,		nodefault};
		__property System::AnsiString		SFXPath		= {read=FSFXPath,		 write=FSFXPath,		nodefault};
		__property System::AnsiString		DLLDirectory  = {read=FDLLDirectory,	write=SetDLLDirectory, nodefault};
		__property OvrOpts					SFXOverWriteMode    = {read=FSFXOverWriteMode,    write=FSFXOverWriteMode,    default=OvrConfirm};
		__property System::AnsiString		SFXCaption	  = {read=FSFXCaption,     write=FSFXCaption,     nodefault};
		__property System::AnsiString		SFXDefaultDir = {read=FSFXDefaultDir,	write=FSFXDefaultDir,  nodefault};
		__property System::AnsiString		SFXCommandLine= {read=FSFXCommandLine,	write=FSFXCommandLine, nodefault};

		__property TProgressEvent			OnProgress  = {read=FOnProgress,  write=FOnProgress};
		__property TMsgEvent					OnMessage   = {read=FOnMessage,   write=FOnMessage};
		__property Classes::TNotifyEvent	OnDirUpdate = {read=FOnDirUpdate, write=FOnDirUpdate};
};

//-- template instantiations -------------------------------------------------
template class ExtrOpts;
template class AddOpts;
template class SfxOpts;

/* class EInvalidOperation : public Sysutils::Exception {
	public:
		/* Exception.Create
     __fastcall EInvalidOperation(const System::AnsiString Msg) : Sysutils::Exception(Msg) { }

		/* Exception.CreateFmt
     __fastcall EInvalidOperation(const System::AnsiString Msg, const System::TVarRec
			*Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
		/* Exception.CreateRes
     __fastcall EInvalidOperation(int Ident) : Sysutils::Exception(Ident) { }
		/* Exception.CreateResFmt
     __fastcall EInvalidOperation(int Ident, const System::TVarRec * Args,
			const int Args_Size) : Sysutils::Exception(Ident, Args, Args_Size) { }
		/* Exception.CreateHelp
     __fastcall EInvalidOperation(const System::AnsiString Msg, int AHelpContext)
       	: Sysutils::Exception(Msg, AHelpContext) { }
		/* Exception.CreateFmtHelp
     __fastcall EInvalidOperation(const System::AnsiString Msg, const System::TVarRec
			*Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
		/* Exception.CreateResHelp
     __fastcall EInvalidOperation(int Ident, int AHelpContext) : Sysutils::
			Exception(Ident, AHelpContext) { }
		/* Exception.CreateResFmtHelp
     __fastcall EInvalidOperation(int Ident, const System::TVarRec *Args
			, const int Args_Size, int AHelpContext) : Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }

		/* TObject.Destroy
     __fastcall virtual ~EInvalidOperation(void) { }
}; */

/* TZipBuilder component by Chris Vleghert cvleghrt@Worldonline.nl a C++ Builder 1.0 wrapper
	for the freeware ZIP and UNZIP DLL's from Eric W. Engler Internet: englere@swcp.com.
	Based upon and related to the TZipMaster component from Eric W. Engler.
	v1.40  Feb 20, 1998

	The new SFX options in this version are made possible by changes
	made to the SFX source code by Markus Stephany, mirbir.st@saargate.de.
	Please send him an e-mail to say "thanks for the hard work"!

	Quick summary of changes in version 1.40:

   Bug fixes:
       Correct filenames are now given in the "skipping encrypted file..."
         error messages.  Thanks to: Markus Stephany, mirbir.st@saargate.de

       The SFX module now extracts more than 1 passworded file in an
         archive.   Thanks to: Markus Stephany, mirbir.st@saargate.de

       Correct progress events now generated for extraction of
         uncompressed files.  Thanks to: Esa Raita, eza@netlife.fi

   DLLDirectory property - allows manual specification of the dir
       used to hold ZIPDLL.DLL and UNZDLL.DLL.  Should NOT end
       in a slash.  This is an optional property. if used, it overrides
       the Windows search path for DLLs.  If you specify a dirname
       here, but the DLLs are not actually in that dir, then the
       std Windows search path will be consulted.
          The idea for this came from Thomas Hensle, thensle@t-online.de.

   In case SFXPath isn't set, DLLDirectory will also be consulted
       when trying to locate ZIPSFX.BIN.  Here's the order that will
       be used to locate ZIPSFX.BIN:
         1) Location given by the SFXPath property.
         2) The current directory.
         3) The application directory. (location of current .EXE file)
         4) The Windows System directory. (where DLLs go.)
         5) The Windows directory. (where DLLs go.)
         6) Location given by the DLLDirectory property.

   These are the advanced options for creating more powerful Self-Extracting
   archives.  By using these options, you can turn the new .EXE archive into
   a small self-contained setup program!

   The following three boolean options are set members of SFXOptions:

   SFXAskCmdLine     boolean   (only matters if a cmd line is present)
        If yes, allows user to de-select the command line checkbox.
        Once deselected, the command line will not be run.
        NOTE: The checkbox doesn't appear unless there is a command line
        specified.

   SFXAskFiles       boolean   (if yes, lets user modify list of files
        to be extracted)

   SFXHideOverWriteBox   boolean  (if yes, user does not get to
        choose the overwrite action at runtime for files that already exist)

   SFXOverWriteMode  enum     dflt=ovrConfirm  (others: ovrAlways, ovrNever)
        This is the dflt overwrite option (if SFXHideOverWriteBox is true, then
        this option will be used during extraction)

   SFXCaption        string   dflt="Self-extracting Archive"
        Caption of the SFX dialog box at runtime.

   SFXDefaultDir     string   dflt=""
        Default target dir for extraction.  Can be changed at runtime.
        If you don't specify this, the user's current directory will
        be the default.

   SFXCommandLine    string   dflt=""
        This command line will be executed immediately after extracting the
        files.  Typically used to view the readme file, but can do anything.
        There is a predefined symbol that can be used in the command line
        to tell you which target directory was actually used.
        Special symbols: | is the command/arg separator
                        >< is the actual extraction dir selected by user
        Example:
           notepad.exe|><readme.txt
        Run notepad to show "readme.txt" in the actual extraction dir.

	For more information read the helpfile: ZipHelp.hlp
*/
#endif
