//---------------------------------------------------------------------------
#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\ExtCtrls.hpp>

#include "ZIPBuilder.h"

//---------------------------------------------------------------------------
class TForm3 : public TForm {
	__published:	// IDE-managed Components
		TPanel		*Panel1;
		TPanel		*Panel2;
		TPanel		*Panel3;
		TButton		*Button2;
		TMemo			*Memo1;
		TButton		*AddBut;
		TButton		*ExtrBut;
		TButton		*ListBut;
		TButton		*DeleteBut;
		TButton		*TestBut;
		TButton		*VersBut;
		TButton		*AddPwdBut;
		TZipBuilder *ZipBuilder1;

		void __fastcall AddButClick( TObject *Sender );
		void __fastcall ZipBuilder1Message( TObject *Sender, int ErrCode, AnsiString Message );
		void __fastcall Button2Click( TObject *Sender );
		void __fastcall ExtrButClick( TObject *Sender );
		void __fastcall VersButClick( TObject *Sender );
		void __fastcall ListButClick( TObject *Sender );
		void __fastcall FormCreate( TObject *Sender );
		void __fastcall FormDestroy( TObject *Sender );
		void __fastcall TestButClick( TObject *Sender );
		void __fastcall DeleteButClick( TObject *Sender );
		void __fastcall AddPwdButClick( TObject *Sender );

	private:		// User declarations

	public:		// User declarations
		__fastcall TForm3( TComponent *Owner ) : TForm( Owner ) { }
};

//---------------------------------------------------------------------------
extern TForm3 *Form3;
#endif
