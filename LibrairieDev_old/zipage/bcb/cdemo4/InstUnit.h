/* IMPORTANT!!!  The "InstUnit" is designed for Win95 Registry keys.  It
 * should work on Win98, but it will likely require some tweaks for WinNT.
 * YOU HAVE BEEN WARNED! */
//---------------------------------------------------------------------------
#ifndef InstUnitH
#define InstUnitH

//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Registry.hpp>

#include <shlobj.h>

//---------------------------------------------------------------------------
class TInstForm : public TForm {
	__published:	// IDE-managed Components
		TGroupBox	 *GroupBox1;
		TCheckBox	 *AssocCB;
		TCheckBox	 *SendToCB;
		TCheckBox	 *StartMenuCB;
		TCheckBox	 *DesktopCB;
		TCheckBox	 *RegistryCB;
		TButton		 *InstBut;
		TButton		 *UnInstBut;
		TButton		 *CancelBut;
		TLabel		 *Label1;
		TLabel		 *Label3;
		TLabel		 *ProgramNameLabel;
		TLabel		 *Label2;
		TRadioButton *StartMenuRB;
		TRadioButton *ProgramRB;

	TCheckBox *KillCB;
		void __fastcall FormCreate( TObject *Sender );
		void __fastcall FormActivate( TObject *Sender );
		void __fastcall InstButClick( TObject *Sender );
		void __fastcall UnInstButClick( TObject *Sender );
		void __fastcall CancelButClick( TObject *Sender );
		void __fastcall StartMenuCBClick( TObject *Sender );

	private:			// User declarations

	public:			// User declarations
		__fastcall TInstForm( TComponent *Owner );

		void __fastcall MakeAssociation( System::AnsiString Ext, System::AnsiString PgmToLinkTo );
		void __fastcall RemoveAssociation( System::AnsiString Ext );
		void __fastcall RegDeleteKey( HKEY RKey, System::AnsiString KeyPath );
		void __fastcall SetValInReg( HKEY RKey, System::AnsiString KeyPath, System::AnsiString ValName,
												System::AnsiString NewVal );
		HRESULT __fastcall MakeLink( System::AnsiString PgmPath, System::AnsiString PgmArgs,
												System::AnsiString LinkPath, System::AnsiString Descr );
		long __fastcall GetSpecialFolder( int aFolder, System::AnsiString &Location );
};

//---------------------------------------------------------------------------
extern TInstForm *InstForm;
extern System::AnsiString WinDir, EXEName, EXETitle;
extern void WINAPI KillMySelf2( DWORD dwExitCode, bool fRemoveDir );

#endif

