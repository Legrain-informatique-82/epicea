//---------------------------------------------------------------------------
#ifndef MessageH
#define MessageH

//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\ComCtrls.hpp>
#include <vcl\ExtCtrls.hpp>

#include "Main.h"

//---------------------------------------------------------------------------
class TMsgForm : public TForm {
	__published:	// IDE-managed Components
		TPanel		 *Panel2;
		TPanel		 *Panel1;
		TButton		 *DismissBut;
		TButton		 *CancelBut;
		TLabel		 *FileBeingZipped;
		TMemo			 *Memo1;
		TProgressBar *ProgressBar1;

		void __fastcall DismissButClick( TObject *Sender );
		void __fastcall CancelButClick( TObject *Sender );

	private:		// User declarations

	public:		// User declarations

		__fastcall TMsgForm( TComponent *Owner ) : TForm( Owner ) { }
};

//---------------------------------------------------------------------------
extern TMsgForm *MsgForm;

#endif
