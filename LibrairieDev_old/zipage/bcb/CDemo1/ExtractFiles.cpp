//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "ExtractFiles.h"

//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TExtract *Extract;

//---------------------------------------------------------------------------
void __fastcall TExtract::OKButClick( TObject *Sender ) {
	Canceled   = false;
	ExtractDir = DirectoryListBox1->Directory;
	ExpandDirs = ( !RadioGroup1->ItemIndex ) ? false : true;
	OverWr	  = ( !RadioGroup2->ItemIndex ) ? false : true;
	AllFiles	  = ( !RadioGroup3->ItemIndex ) ? true  : false;
	Close();
}

//---------------------------------------------------------------------------
void __fastcall TExtract::CancelButClick( TObject *Sender ) {
	ExtractDir = "";
	Close();
}

//---------------------------------------------------------------------------
void __fastcall TExtract::FormCreate( TObject *Sender ) {
	RadioGroup1->ItemIndex = 0;	 // dflt: do not expand dirs.
	RadioGroup2->ItemIndex = 1;	 // dflt: overwrite existing files.
	RadioGroup3->ItemIndex = 0;	 // dflt: extract all files.
}

//---------------------------------------------------------------------------
void __fastcall TExtract::FormActivate(TObject *Sender) {
	Canceled = true;					 // Default.
}
//---------------------------------------------------------------------------
