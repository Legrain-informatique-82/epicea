// Fenêtre à propos
// Tout est commenté
unit DLL_Form_A_Propos;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,
  Dialogs,
  ShellAPI;


type
  TForm_A_Propos = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Memo1: TMemo;
    AdresseEMail: TStaticText;
    Image1: TImage;
    procedure AdresseEMailClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TypeClient:String;
  end;

var
  Form_A_Propos:TForm_A_Propos;
implementation

{$R *.DFM}

procedure TForm_A_Propos.AdresseEMailClick(Sender: TObject);
begin
	ShellExecute(Handle, 'open', 'mailto: contact@legrain.fr', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm_A_Propos.OKButtonClick(Sender: TObject);
begin
self.Close;
end;

procedure TForm_A_Propos.FormShow(Sender: TObject);
const
	InfoNum = 10;
  	InfoStr : array [1..InfoNum] of String =
   	('CompanyName', 'FileDescription', 'FileVersion', 'InternalName',
	   'LegalCopyright', 'LegalTradeMarks', 'OriginalFilename',
		'ProductName', 'ProductVersion', 'Comments');
var
	S         : String;
   n, Len, i : Integer;
	Buf       : PChar;
	Value     : PChar;
  listeRetour:TstringList;
begin
  S := Application.ExeName;
//  n := GetFileVersionInfoSize(PChar(S),n);
  Memo1.Lines.Clear;
//  showmessage(Form_A_Propos.TypeClient);
listeRetour:=TstringList.create;
ExtractStrings([';'],[' '],PAnsiChar(TypeClient),listeRetour);
  Memo1.Lines:=listeRetour;
//  if E.Type_Version_Test_Client then Memo1.Lines.Add('Version d''évaluation');


//   if n > 0 then begin
//   	Buf := AllocMem(n);
//
//    	try
//      	GetFileVersionInfo(PChar(S),0,n,Buf);
//      	for i:=1 to InfoNum do
//      	if VerQueryValue(Buf,PChar('StringFileInfo\040C04E4\'+
//	      	InfoStr[i]),Pointer(Value),Len) then
//	         case i of
//   	        3: Version.Caption:='Version : ' + Value;
//      	     5: Copyright.Caption:= 'Copyright : ' + Value;
//         	else Memo1.Lines.Add(InfoStr[i]+'='+Value);
//	   	end;
//      finally
//      Memo1.Lines.Add(TypeClientToStr(E.
//			FreeMem(Buf,n);
//      end;
//   end
//   else Memo1 .Lines.Add('No FileVersionInfo found');

end;

end.

