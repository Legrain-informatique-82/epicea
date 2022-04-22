// Fenêtre à propos
// Tout est commenté
unit E2_VisuAPropos;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,
//  E2_Librairie_Obj,
  ShellAPI;


type
  TVisuAPropos = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Memo1: TMemo;
    AdresseEMail: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure AdresseEMailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TVisuAPropos.FormCreate(Sender: TObject);
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
begin
//  S := Application.ExeName;
////  n := GetFileVersionInfoSize(PChar(S),n);
//  Memo1.Lines.Clear;
//  Memo1.Lines.Add(E.TypeClientToStr(E.TypeClient));
//  if E.Type_Version_Test_Client then Memo1.Lines.Add('Version d''évaluation');
//
//
////   if n > 0 then begin
////   	Buf := AllocMem(n);
////
////    	try
////      	GetFileVersionInfo(PChar(S),0,n,Buf);
////      	for i:=1 to InfoNum do
////      	if VerQueryValue(Buf,PChar('StringFileInfo\040C04E4\'+
////	      	InfoStr[i]),Pointer(Value),Len) then
////	         case i of
////   	        3: Version.Caption:='Version : ' + Value;
////      	     5: Copyright.Caption:= 'Copyright : ' + Value;
////         	else Memo1.Lines.Add(InfoStr[i]+'='+Value);
////	   	end;
////      finally
////      Memo1.Lines.Add(TypeClientToStr(E.
////			FreeMem(Buf,n);
////      end;
////   end
////   else Memo1 .Lines.Add('No FileVersionInfo found');
end;

procedure TVisuAPropos.AdresseEMailClick(Sender: TObject);
begin
	ShellExecute(Handle, 'open', 'mailto: legrain@wanadoo.fr', nil, nil, SW_SHOWNORMAL);
end;

end.

