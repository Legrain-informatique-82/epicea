//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "SFX.h"

//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TMakeSFX *MakeSFX;

//---------------------------------------------------------------------------
void __fastcall TMakeSFX::ExecButClick( TObject *Sender ) {
	TZipBuilder *zb = MainForm->ZipBuilder1;

	if ( CmdLineCB->Checked )
		  zb->SFXOptions << SFXAskCmdLine;
	else zb->SFXOptions >> SFXAskCmdLine;
	if ( FileListCB->Checked )
		  zb->SFXOptions << SFXAskFiles;
	else zb->SFXOptions >> SFXAskFiles;
	if ( HideOverWriteCB->Checked )
		  zb->SFXOptions << SFXHideOverWriteBox;
	else zb->SFXOptions >> SFXHideOverWriteBox;
	if ( !DfltOverWriteGrp->ItemIndex )
		zb->SFXOverWriteMode = OvrConfirm;
	if ( DfltOverWriteGrp->ItemIndex == 1 )
		zb->SFXOverWriteMode = OvrAlways;
	if ( DfltOverWriteGrp->ItemIndex == 2 )
		zb->SFXOverWriteMode = OvrNever;
	zb->SFXCaption		 = CaptionEdit->Text;
	zb->SFXDefaultDir  = DirectoryEdit->Text;
	zb->SFXCommandLine = CommandEdit->Text;

   MainForm->DoIt = true;
   Close();
}

//---------------------------------------------------------------------------
void __fastcall TMakeSFX::CancelButClick( TObject *Sender ) {
	MainForm->DoIt = false;
	Close();
}

//---------------------------------------------------------------------------
void __fastcall TMakeSFX::FormCreate(TObject *Sender) {
	CaptionEdit->Text		= "Self-extracting Archive";
	DirectoryEdit->Text	= "C:\\";
	CommandEdit->Text		= "";
	DfltOverWriteGrp->ItemIndex = 0;
	CmdLineCB->Checked		 = false;
	FileListCB->Checked		 = false;
	HideOverWriteCB->Checked = false;
}

//---------------------------------------------------------------------------
void __fastcall TMakeSFX::BitBtn1Click( TObject *Sender ) {
	BROWSEINFO  bi;
	LPSTR		   lpBuffer;
	ITEMIDLIST *pidl;          // PIDL selected by user
	LPMALLOC    g_pMalloc;

	// Get the shell's allocator.
	if ( (SHGetMalloc( &g_pMalloc ) )== E_FAIL ) return;

	// Allocate a buffer to receive browse information.
	if ( (lpBuffer = (LPSTR)g_pMalloc->Alloc( MAX_PATH)) != 0 ) {
		bi.hwndOwner		= MakeSFX->Handle;
		bi.pidlRoot			= NULL;
		bi.pszDisplayName	= lpBuffer;
		bi.lpszTitle		= "Choose a directory:";
		bi.ulFlags			= 0;
		bi.lpfn				= NULL;
		bi.lParam			= 0;

		// if pidl = 0 then cancel is used.
		if ( (pidl = SHBrowseForFolder( &bi )) != 0 ) {
			// if 0 then pidl not part of namespace
			if ( SHGetPathFromIDList( pidl, lpBuffer ) )
				DirectoryEdit->Text = lpBuffer;
			// Free the PIDL returned by SHBrowseForFolder.
			g_pMalloc->Free( pidl );
		}
		// Free the string buffer used for the name
		g_pMalloc->Free( lpBuffer );
	}
	// Release the shell's allocator.
	g_pMalloc->Release();
}
//---------------------------------------------------------------------------
