//---------------------------------------------------------------------------
#ifndef CallBackUnitH
#define CallBackUnitH

#include <vcl\Windows.hpp>
#include <vcl\System.hpp>

namespace CallBackUnit {
//---------------------------------------------------------------------------

// Maximum no. of files in a single ZIP file (do NOT change):
const int FilesMax = 4096;
const int PWLEN = 80;			// new V1.3

/* All the items in the CallBackStruct are passed to the Delphi
    program from the DLL.  Note that the "Caller" value returned
    here is the same one specified earlier in ZipParms by the
    Delphi pgm. */
#pragma option -a1
struct ZCallBackStruct {
	int   Handle;
	void *Caller;           // "self" referance of the Delphi form
	long  Version;          // version no. of DLL
	DWord IsOperationZip;   // true=zip, false=unzip
	long  ActionCode;
	long  ErrorCode;
	long  FileSize;
	char  FileNameOrMsg[512];
};
#pragma option -a4
typedef ZCallBackStruct *PZCallBackStruct;

/* Declare a function pointer type for the Delphi callback function, to
   be called by the DLL to pass updated status info back to Delphi.
   Your callback function must not be a member of a class!               */
typedef unsigned long __stdcall (*ZFunctionPtrType)(PZCallBackStruct ZCallbackRec);
}	/* EOF namespace CallBackUnit */

#if !defined(NO_IMPLICIT_NAMESPACE_USE)
	using namespace CallBackUnit;
#endif
#endif
