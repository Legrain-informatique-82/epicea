unit Aide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw;

type
  TFormAide = class(TForm)
    Button1: TButton;
    WebBrowser1: TWebBrowser;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormAide: TFormAide;

implementation

{$R *.dfm}

procedure TFormAide.Button1Click(Sender: TObject);
begin
    FormAide.Close;
end;

end.
