#ifndef mainH
#define mainH

//----------------------------------------------------------------------------
#include <vcl\ExtCtrls.hpp>
#include <vcl\Controls.hpp>
#include <vcl\Classes.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Dialogs.hpp>
#include <vcl\Grids.hpp>

#include "SortGrid.hpp"

#include "ZIPBuilder.h"

#include "Message.h"
#include "ExtractFiles.h"
#include "AddFiles.h"
#include "SFX.h"
#include <vcl\Buttons.hpp>

class TMainForm : public TForm {
	__published:	// IDE-managed Components
		TBevel		*Bevel2;
		TBevel		*Bevel1;
		TButton		*CloseBut;
		TButton		*DeleteZipBut;
		TButton		*NewZipBut;
		TButton		*ZipOpenBut;
		TButton		*MsgBut;
		TButton		*ConvertBut;
		TButton		*DeleteBut;
		TButton		*AddBut;
		TButton		*ExtractBut;
		TButton		*TestBut;
		TCheckBox	*VerboseCB;
		TCheckBox	*TraceCB;
		TLabel		*FilesLabel;
		TLabel		*ZipFName;
		TLabel		*Label1;
		TLabel		*Label2;
		TLabel		*TimeLabel;
		TLabel		*Label4;
		TPanel		*Panel2;
		TPanel		*Panel4;
		TPanel		*Panel3;
		TPanel		*Panel1;
		TSortGrid	*StringGrid1;
		TOpenDialog	*OpenDialog1;
		TZipBuilder *ZipBuilder1;

	TImageList *ImageList1;
		void __fastcall CloseButClick( TObject *Sender );
		void __fastcall ZipOpenButClick( TObject *Sender );
		void __fastcall NewZipButClick( TObject *Sender );
		void __fastcall DeleteZipButClick( TObject *Sender );
		void __fastcall ExtractButClick( TObject *Sender );
		void __fastcall FormCreate( TObject *Sender );
		void __fastcall AddButClick( TObject *Sender );
		void __fastcall ZipBuilder1DirUpdate( TObject *Sender );
		void __fastcall ZipBuilder1Message( TObject *Sender, int ErrCode, AnsiString Message );
		void __fastcall ZipBuilder1Progress( TObject *Sender, ProgressType ProgrType, AnsiString Filename, long FileSize );
		void __fastcall DeleteButClick( TObject *Sender );
		void __fastcall FormDestroy( TObject *Sender );
		void __fastcall TestButClick( TObject *Sender );
		void __fastcall MsgButClick( TObject *Sender );
		void __fastcall ConvertButClick(TObject *Sender );
		void __fastcall StringGrid1ClickSort( TObject *Sender, long Col, long Row, TSortOptions &SortOptions );
		void __fastcall StringGrid1DrawCell( TObject *Sender, long Col, long Row, TRect &Rect, TGridDrawState State );

	private:		// User declarations

	public:		// User declarations
		bool			 DoIt;
		long			 GSortCol;
      TSortOptions GSortOptions;

		__fastcall TMainForm( TComponent *Owner ) :  TForm( Owner ) { }

		System::AnsiString ShowLTime( long s, long f );
		void __fastcall SetZipFName( System::AnsiString aCaption );
		void __fastcall FillGrid( void );
};

//-- var, const, procedure ---------------------------------------------------
extern TMainForm *MainForm;

extern System::AnsiString ExtractDir;

extern bool	ExpandDirs;
extern bool	OverWr;
extern bool	AllFiles;
extern bool	Canceled;
extern bool MemoFull;

#endif
