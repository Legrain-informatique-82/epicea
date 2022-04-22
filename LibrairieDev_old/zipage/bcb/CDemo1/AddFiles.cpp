//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "AddFiles.h"

//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TAddFile *AddFile;

bool InMouseClick;

//---------------------------------------------------------------------------
System::AnsiString __fastcall TAddFile::SlashAppend( System::AnsiString sDir ) {
	System::AnsiString Result = sDir;

	if ( sDir.Length() > 0 && sDir[sDir.Length()] != '\\' ) Result += "\\";
	return Result;
}

//---------------------------------------------------------------------------
void __fastcall TAddFile::OKButClick( TObject *Sender ) {
	Canceled = false;
	Close();
}

//---------------------------------------------------------------------------
void __fastcall TAddFile::CancelButClick( TObject *Sender ) {
	Canceled = true;
	Close();
}

//---------------------------------------------------------------------------
void __fastcall TAddFile::SortButClick( TObject *Sender ) {
	SelectedList->Sorted = true;
	SortBut->Enabled     = false;  // List will remain sorted.
}

//---------------------------------------------------------------------------
void __fastcall TAddFile::RemoveButClick( TObject *Sender ) {
	for ( int i = SelectedList->Items->Count - 1; i >= 0 ; i-- ) {
		if ( SelectedList->Selected[i] )
			SelectedList->Items->Delete( i );
	}
}

//---------------------------------------------------------------------------
void __fastcall TAddFile::SelectAllButClick( TObject *Sender ) {
	for ( int i = 0; i < FileListBox1->Items->Count; i++ )
		FileListBox1->Selected[i] = true;
}

//---------------------------------------------------------------------------
void __fastcall TAddFile::FormCreate( TObject *Sender ) {
	DirNameCB->Checked = false;
	RecurseCB->Checked = false;
	EncryptCB->Checked = false;
	InMouseClick = false;
}

//---------------------------------------------------------------------------
void __fastcall TAddFile::AddDirButClick( TObject *Sender ) {
	System::AnsiString FullName;

	Canceled = true;  // Default.
	for ( int i = 0; i < DirectoryListBox1->Items->Count; i++ ) {
		if ( DirectoryListBox1->Selected[i] ) {
			// Add this file if it isn't already in listbox.
			FullName = SlashAppend( DirectoryListBox1->Directory ) + "*.*";

			if ( SelectedList->Items->IndexOf( FullName ) < 0 )
				SelectedList->Items->Add( FullName );
			// Never de-select dirnames from the DirectoryList!
			// DirectoryListBox1->Selected[i] = false;
		}
	}
	// Position the "SelectedList" listbox at the bottom.
	SelectedList->Selected[SelectedList->Items->Count - 1] = true;
	SelectedList->Selected[SelectedList->Items->Count - 1] = false;
}

//---------------------------------------------------------------------------
void __fastcall TAddFile::AddFileButClick( TObject *Sender ) {
	System::AnsiString FullName;

	Canceled = true;  // default
	for ( int i = 0; i < FileListBox1->Items->Count; i++ ) {
		if ( FileListBox1->Selected[i] ) {
			// Add this file if it isn't already in listbox.
			FullName =  SlashAppend( DirectoryListBox1->Directory ) + FileListBox1->Items->Strings[i];
			if ( SelectedList->Items->IndexOf( FullName ) < 0 )
				SelectedList->Items->Add( FullName );
			FileListBox1->Selected[i] = false;
		}
	}
	// Position the "SelectedList" listbox at the bottom.
	SelectedList->Selected[SelectedList->Items->Count - 1] = true;
	SelectedList->Selected[SelectedList->Items->Count - 1] = false;
}

//---------------------------------------------------------------------------
