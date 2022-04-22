//---------------------------------------------------------------------------
#ifndef AddFilesH
#define AddFilesH

//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\ExtCtrls.hpp>
#include <vcl\FileCtrl.hpp>

#include "Main.h"

//---------------------------------------------------------------------------
class TAddFile : public TForm {
	__published:	// IDE-managed Components
		TBevel				*Bevel1;
		TButton				*AddFileBut;
		TButton				*RemoveBut;
		TButton				*OKBut;
		TButton				*CancelBut;
		TButton				*SortBut;
		TButton				*SelectAllBut;
		TButton				*AddDirBut;
		TCheckBox			*DirNameCB;
		TCheckBox			*RecurseCB;
		TCheckBox			*EncryptCB;
		TLabel				*Label2;
		TLabel				*Label1;
		TPanel				*Panel1;
		TPanel				*Panel2;
		TPanel				*Panel3;
		TPanel				*Panel4;
		TPanel				*Panel5;
		TPanel				*Panel6;
		TPanel				*Panel7;
		TPanel				*Panel8;
		TListBox				*SelectedList;
		TDriveComboBox		*DriveComboBox1;
		TFileListBox		*FileListBox1;
		TDirectoryListBox	*DirectoryListBox1;

		void __fastcall OKButClick( TObject *Sender );
		void __fastcall CancelButClick( TObject *Sender );
		void __fastcall SortButClick( TObject *Sender );
		void __fastcall RemoveButClick( TObject *Sender );
		void __fastcall SelectAllButClick( TObject *Sender );
		void __fastcall FormCreate( TObject *Sender );
		void __fastcall AddDirButClick( TObject *Sender );
		void __fastcall AddFileButClick( TObject *Sender );

	
	private:		// User declarations

	public:		// User declarations
		__fastcall TAddFile( TComponent *Owner ) : TForm( Owner ) { }

		System::AnsiString __fastcall SlashAppend( System::AnsiString sDir );
};

//---------------------------------------------------------------------------
extern TAddFile *AddFile;

extern bool InMouseClick;

#endif

