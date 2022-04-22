//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "Message.h"

//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TMsgForm *MsgForm;

//---------------------------------------------------------------------------
void __fastcall TMsgForm::DismissButClick( TObject *Sender ) {
	Hide();
}

//---------------------------------------------------------------------------
void __fastcall TMsgForm::CancelButClick( TObject *Sender ) {
	if ( MainForm->ZipBuilder1->ZipBusy || MainForm->ZipBuilder1->UnzBusy )
		MainForm->ZipBuilder1->Cancel = true;
	else
		Hide(); // Nothing to cancel - assume user wants to close msg window.
}
//---------------------------------------------------------------------------
