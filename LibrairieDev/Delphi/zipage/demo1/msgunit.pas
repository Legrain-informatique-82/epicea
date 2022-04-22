unit msgunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TMsgform = class(TForm)
    Panel2: TPanel;
    Memo1: TMemo;
    DismissBut: TButton;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    FileBeingZipped: TLabel;
    CancelBut: TButton;
    procedure DismissButClick(Sender: TObject);
    procedure CancelButClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Msgform: TMsgform;
 
implementation

uses mainunit;

{$R *.DFM}

procedure TMsgform.DismissButClick(Sender: TObject);
begin
   Hide;
end;

procedure TMsgform.CancelButClick(Sender: TObject);
begin
   if (MainForm.ZipMaster1.ZipBusy or MainForm.ZipMaster1.UnzBusy) then
      MainForm.ZipMaster1.Cancel:=True
   else
      Hide; { nothing to cancel - assume user wants to close msg window }
end;

end.
