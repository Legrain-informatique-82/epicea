unit AfficheWeb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ExtCtrls ,E2_Decl_Records;

type
  TAffichageWeb = class(TForm)
    Panel1: TPanel;
    WebBrowser1: TWebBrowser;
    editURL: TEdit;
    btnnext: TButton;
    btnback: TButton;
    btnrefresh: TButton;
    btnHome: TButton;
    btnStop: TButton;
    Label1: TLabel;
    btnLoad: TButton;
    btnQuit: TButton;
    procedure WebBrowser1TitleChange(Sender: TObject;
      const Text: WideString);
    procedure btnStopClick(Sender: TObject);
    procedure btnrefreshClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure btnnextClick(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnbackClick(Sender: TObject);
    procedure editURLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLoadClick(Sender: TObject);

  private
    { Déclarations privées }
     procedure OpenURL;
  public
    { Déclarations publiques }
  end;

var
  AffichageWeb: TAffichageWeb;
  Function ChoixParamAffichePageWeb():TResultAffichePageWeb;

implementation



{$R *.dfm}

Function ChoixParamAffichePageWeb():TResultAffichePageWeb;
Begin

if AffichageWeb = nil then AffichageWeb:=TAffichageWeb.Create(Application.MainForm);
Result.Retour := (AffichageWeb.ShowModal=mrOk);
if Result.Retour then
 begin

 end;
AffichageWeb.Free;
AffichageWeb := nil;
//
End;



procedure TAffichageWeb.WebBrowser1TitleChange(Sender: TObject;
  const Text: WideString);
begin
editURL.Text := Text;
end;

procedure TAffichageWeb.btnStopClick(Sender: TObject);
begin
WebBrowser1.Stop;
end;

procedure TAffichageWeb.btnrefreshClick(Sender: TObject);
begin
WebBrowser1.Refresh;
end;

procedure TAffichageWeb.btnQuitClick(Sender: TObject);
begin
WebBrowser1.Quit;
end;

procedure TAffichageWeb.btnnextClick(Sender: TObject);
begin
WebBrowser1.GoForward;
end;

procedure TAffichageWeb.btnHomeClick(Sender: TObject);
begin
WebBrowser1.GoHome;
end;

procedure TAffichageWeb.btnbackClick(Sender: TObject);
begin
WebBrowser1.GoBack
end;

procedure TAffichageWeb.editURLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_RETURN then
    OpenURL;
end;

procedure TAffichageWeb.btnLoadClick(Sender: TObject);
begin
  OpenURL;
end;


procedure TAffichageWeb.OpenURL;
begin
  WebBrowser1.Navigate(editURL.Text);
// URL can be www.google.com
// URL can be C:\testfolder
// URL can be C:\testfolder\tset1.jpg
end;

end.
