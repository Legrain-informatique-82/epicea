//---------------------------------------------------------------------------
#ifndef ZipDLLH
#define ZipDLLH
// ZIPDLL.H   - C++ Builder translation of file "wizzip.h" by Eric W. Engler
/* Header file for ZIPDLL - put this into the "include" statement of any
   other unit that wants to access the DLL. */

/* Version 1.2
	 I changed this to use dynamic loading of the DLL in order to allow
   the user program to control when to load and unload the DLLs.
   Thanks to these people for sending me dynamic loading code:
     Ewart Nijburg, Nijsoft@Compuserve.com
     P.A. Gillioz,  pag.aria@rhone.ch
*/

//---------------------------------------------------------------------------
#include "CallBackUnit.h"

#include <vcl\Windows.hpp>
#include <vcl\System.hpp>
namespace ZipDLL {
//-- type declarations -------------------------------------------------------

/* This record is very critical.  Any changes in the order of items, the
  size of items, or modifying the number of items, may have disasterous
  results.  You have been warned! */
#pragma option -a1
struct ZipParms {
	void	*Handle;
	void  *Caller; /* "self" referance of the Delphi form.
                     This is passed back to us in the callback function
                     so we can direct the info to the proper form instance
                     - thanks to Dennis Passmore for this idea.            */
	long   Version;
	CallBackUnit::ZFunctionPtrType ZCallbackFunc;
	DWord  fTraceEnabled;

   //============== Begin Zip Flag section ==============
	char	*PZipPassword;		// password pointer (changed v1.3)
	DWord  fSuffix;         // not used yet
	DWord  fEncrypt;        // Encrypt files to be added?
	DWord  fSystem;			// Add hidden system files.
	DWord  fVolume;

   // Include extra file attributes (read-only, unix timestamps, etc)
	DWord  fExtra;

   // Do not add directory names to .ZIP archive
   // see also: fJunkDir
	DWord  fNoDirEntries;

   // Only add files newer a specified date
   // See the "Date" array below if you set this to TRUE
	DWord  fDate;

   // Give a little more information to the user via message boxes
	DWord  fVerboseEnabled;

   // Quiet operation - the DLL won't issue any messages at all.
   // Delphi program MUST handle ALL errors via it's callback function.
	DWord  fQuiet;

   // Compression level (0 - 9; 9=max, 0=none)
   // All of these levels are variations of deflate.
   // I strongly recommend you use one of 3 values here:
	// 		0 = no compression, just store file
   //      3 = "fast" compression
   //      9 = "best" compression
	long   fLevel;

   //  Try to compress files that appear to be already compressed
   // based on their extension: .zip, .arc, .gif, ...
	DWord  fComprSpecial;
	DWord  fCRLF_LF;         // translate text file end-of-lines

   // junk the directory names
   /* If true, this says not to save dirnames as separate entries,
      in addition to being save with filenames. */
   // see also: fNoDirEntries
	DWord  fJunkDir;
	DWord  fRecurse;         // Recurse into subdirectories
	DWord  fGrow;            // Allow appending to a zip file

   /* Convert filenames to DOS 8x3 names - for compatibility
      with PKUNZIP v2.04g, which doesn't understand long filenames */
	DWord  fForce;

   // Delete orig files that were added or updated in zip file
   // This is a variation of Add
	DWord  fMove;
	DWord  fDeleteEntries;   // Delete specified files from zip file

   // Update zip -- if true, rezip changed, and add new files in fspec
   // This is a variation of Add
	DWord  fUpdate;

   // Freshen zip -- if true, rezip all changed files in fspec
   // This is a variation of Add
	DWord  fFreshen;

   // junk the SFX prefix on the self-extracing .EXE archives
	DWord  fJunkSFX;

   // Set zip file time to time of newest file in it
	DWord  fLatestTime;
   // ============== End Zip Flag section ==============

   // Cutoff Date for Add-by-date; add files newer than this day
   // This is only used if the "fDate" option is TRUE
   // format = MMDDYY plus a trailing null
	char   Date[8];

   // Count of files to add or delete - don't forget to set this!
	long   argc;
	char  *PZipFN;       // ptr to name of zip file
	long   seven;        // pass a 7 here to validate struct size

   // Array of filenames contained in the ZIP archive
	char  *PFileNames[FilesMax + 1]; // :=4097
};
#pragma option -a4

typedef ZipParms *PZipParms;
//typedef Word     *PWord;
typedef int __stdcall (*GetZipExecAddress)(PZipParms);
typedef int __stdcall (*GetZipVersionAddress)(void);

// Note: Freshen, Update, and Move are only variations of Add.
enum ZipOpt { ZipAdd, ZipDelete };

//-- var, const, procedure ---------------------------------------------------
/* Main call to execute a ZIP add or Delete.  This call returns the
  	number of files that were sucessfully operated on. 					*/
extern GetZipExecAddress		ZipDllExec;
extern GetZipVersionAddress	GetZipDllVersion;
extern HINSTANCE					ZipDllHandle;

//int __stdcall (*ZipDllExec)(PZipParms ZipRec);
//int __stdcall (*GetZipDllVersion)(void);
//HINSTANCE ZipDllHandle;

/* -- Used in case of static linking...

//-- var, const, procedure ---------------------------------------------------
extern "C" int __stdcall ZipDllExec(PZipParms ZipRec);
extern "C" int __stdcall GetZipDllVersion( void );

// Main call to execute a ZIP add or Delete.  This call returns the
// number of files that were sucessfully operated on.
inline int __stdcall ZipDllExec( PZipParms ZipRec ) {
	return ZipDllExec( ZipRec );
}

inline int __stdcall GetZipDllVersion( void ) {
	return GetZipDllVersion();
}
*/

}	/* namespace ZipDLL */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
	using namespace ZipDLL;
#endif
#endif
