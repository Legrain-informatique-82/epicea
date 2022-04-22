unit S2_MsgForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMsgForm = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MsgForm: TMsgForm;

implementation

{$R *.dfm}

procedure TMsgForm.Button1Click(Sender: TObject);
begin
self.Close;
end;

procedure TMsgForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #27 then ModalResult := mrCancel;
end;

end.
