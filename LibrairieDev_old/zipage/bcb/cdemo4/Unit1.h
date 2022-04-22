// ViewZip - Demo4 of C-Builder Zip v1.40
/* This is a C-Builder 1.0 example of how a small self-installing program
 * might be written. If it runs with an argument of /INSTALL, it automatically
 * brings up the install menu.  If it runs with an argument of /UNINSTALL
 * (such as when running from the Control Panel Uninstall option), it
 * does the uninstall and exits.  If the argument is anything else, then
 * it assumes it's a zip file and tries to open it.
 *
 * IMPORTANT!!!  The "InstUnit" is designed for Win95 Registry keys.  It
 * should work on Win98, but it will likely require some tweaks for WinNT.
 * YOU HAVE BEEN WARNED!
 */

//---------------------------------------------------------------------------
#ifndef Unit1H
#define Unit1H

//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\ExtCtrls.hpp>
#include <vcl\Dialogs.hpp>
#include <vcl\Buttons.hpp>

#include "SortGrid.hpp"
#include "Grids.hpp"

#include "ZIPBuilder.h"

//---------------------------------------------------------------------------
class TForm1 : public TForm {
	__published:	// IDE-managed Components
		TPanel		*Panel1;
		TLabel		*Label1;
		TLabel		*Label2;
		TLabel		*ZipFName;
		TLabel		*Label4;
		TButton		*OpenBut;
		TButton		*CancelBut;
		TButton		*InstBut;
		TSortGrid	*SortGrid1;
		TImageList	*ImageList1;
		TOpenDialog *OpenDialog1;
		TZipBuilder *ZipDir1;

		void __fastcall FormActivate( TObject *Sender );
		void __fastcall FormCreate( TObject *Sender );
		void __fastcall OpenButClick( TObject *Sender );
		void __fastcall InstButClick( TObject *Sender );
		void __fastcall CancelButClick( TObject *Sender );
		void __fastcall SortGrid1DrawCell( TObject *Sender, long Col, long Row, TRect &Rect, TGridDrawState State );
		void __fastcall SortGrid1ClickSort( TObject *Sender, long Col, long Row, TSortOptions &SortOptions );

	private:			// User declarations

	public:			// User declarations
		__fastcall TForm1( TComponent *Owner );

		TSortOptions GSortOptions;
		long			 GSortCol;
		bool			 AutoUnInstall;

		void __fastcall FillGrid( void );
};

//---------------------------------------------------------------------------
extern TForm1 *Form1;

#endif

