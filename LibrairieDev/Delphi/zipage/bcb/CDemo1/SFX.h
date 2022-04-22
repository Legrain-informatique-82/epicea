//---------------------------------------------------------------------------
#ifndef Unit1H
#define Unit1H

//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\ExtCtrls.hpp>
#include <vcl\Buttons.hpp>

#include <shlobj.h>

#include "Main.h"

//---------------------------------------------------------------------------
class TMakeSFX : public TForm {
	__published:	// IDE-managed Components
		TPanel		*Panel1;
		TPanel		*Panel2;
		TCheckBox	*CmdLineCB;
		TCheckBox	*FileListCB;
		TCheckBox	*HideOverWriteCB;
		TRadioGroup	*DfltOverWriteGrp;
		TEdit			*CaptionEdit;
		TEdit			*DirectoryEdit;
		TEdit			*CommandEdit;
		TButton		*ExecBut;
		TButton		*CancelBut;
		TLabel		*Label1;
		TLabel		*Label2;
		TLabel		*Label3;
		TLabel		*Label4;
		TLabel		*Label5;
		TLabel		*Label6;
		TLabel		*Label7;
		TLabel		*Label8;

	TBitBtn *BitBtn1;
		void __fastcall ExecButClick( TObject *Sender );
		void __fastcall CancelButClick( TObject *Sender );
		void __fastcall FormCreate( TObject *Sender );

	
	void __fastcall BitBtn1Click(TObject *Sender);
	private:		// User declarations

	public:		// User declarations
		__fastcall TMakeSFX( TComponent *Owner ) : TForm( Owner ) { }
};

//---------------------------------------------------------------------------
extern TMakeSFX  *MakeSFX;

#endif

