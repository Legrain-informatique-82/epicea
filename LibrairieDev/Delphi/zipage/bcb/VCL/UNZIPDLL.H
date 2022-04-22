//---------------------------------------------------------------------------
#ifndef UnZipDLLH
#define UnZipDLLH
// UnzDLL.h   - C++ Builder translation of file "wizunzip.h" by Eric W. Engler
/* Header file for UNZDLL - put this into the "include" statement of any
   other unit that wants to access the UNZDLL. */

/* I changed this to use dynamic loading of the DLL in order to allow
   the user program to control when to load and unload the DLLs.
   Thanks to these people for sending me dynamic loading code:
     Ewart Nijburg, Nijsoft@Compuserve.com
     P.A. Gillioz,  pag.aria@rhone.ch
*/

//---------------------------------------------------------------------------
namespace UnzipDLL {
#include "CallBackUnit.h"

#include <vcl\Windows.hpp>
#include <vcl\System.hpp>

//-- type declarations -------------------------------------------------------
#pragma option -a1
/* This record is very critical.  Any changes in the order of items, the
   size of items, or modifying the number of items, may have disasterous
   results.  You have been warned! */
struct UnZipParms {
	void	*Handle;
	void  *Caller;   // "self" referance of the Delphi form
                    /* This is passed back to us in the callback function
                       so we can direct the info to the proper form instance
                       - thanks to Dennis Passmore for this idea. */
	long   Version;  // version of DLL we expect to see
	CallBackUnit::ZFunctionPtrType ZCallbackFunc;     // typedef in ZIPDLL.PAS
	DWord  fTraceEnabled;

   //============== Begin UnZip Flag section ==============
	DWord  fPromptToOverwrite;  // not used yet
	char	*PZipPassword;			 // password pointer. (changed v1.3)
	DWord  fTest;               // if true, test zipfile (not used yet)
	DWord  fComments;           // show zip comment (not supported yet)
	DWord  fConvert;            // if true, do ASCII/EBCDIC or EOL translation
	DWord  fQuiet;              // DLL be quiet!
	DWord  fVerboseEnabled;     // verbose flag
	DWord  fUpdate;             // "update" (extract only newer files & brand new files)
	DWord  fFreshen;            // "freshen" (extract only newer files that already exist)
	DWord  fDirectories;        // if true, recreate dir structure
	DWord  fOverwrite;          // if true, overwrite existing (no asking)

	//Count of filespecs to extract - don't forget to set this!
	long   argc;

	//ptr to zipfile name
	char  *PZipFN;
	long   seven;               // pass a 7 here to validate struct size

   // Array of filenames contained in the ZIP archive
	char  *PFileNames[FilesMax + 1];
} ;
#pragma option -a4


typedef UnZipParms *PUnZipParms;
typedef int __stdcall (*GetUnzExecAddress)(PUnZipParms);
typedef int __stdcall (*GetUnzVersionAddress)(void);

//-- var, const, procedure ---------------------------------------------------
extern GetUnzExecAddress		UnzDllExec;
extern GetUnzVersionAddress	GetUnzDllVersion;
extern HINSTANCE					UnzDllHandle;

//int __stdcall (*UnzDllExec)(PUnZipParms UnZipRec);
//int __stdcall (*GetUnzDllVersion)(void);
//HINSTANCE UnzDllHandle;

/* Used in static linking...
//-- var, const, procedure ---------------------------------------------------
extern "C" int __stdcall UnzDllExec(PUnZipParms UnZipRec);
extern "C" int __stdcall GetUnzDllVersion( void );

inline int __stdcall UnzDllExec( PUnZipParms UnZipRec ) {
	return UnzDllExec(UnZipRec);
}

inline int __stdcall GetUnzDllVersion( void ) {
	return GetUnzDllVersion();
}
*/

}	/* namespace UnzipDLL */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
	using namespace UnzipDLL;
#endif
#endif
