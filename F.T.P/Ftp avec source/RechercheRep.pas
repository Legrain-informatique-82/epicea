unit RechercheRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ShellCtrls, StdCtrls;

type
  TFormChoixRepSource = class(TForm)
    ShellTreeView1: TShellTreeView;
    ButtonOK: TButton;
    ButtonAnnuler: TButton;
    procedure ButtonAnnulerClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormChoixRepSource: TFormChoixRepSource;

implementation

uses ftp;

{$R *.dfm}

  procedure TFormChoixRepSource.ButtonAnnulerClick(Sender: TObject);
  begin
      FormChoixRepSource.Close;
  end;

  procedure TFormChoixRepSource.ButtonOKClick(Sender: TObject);
  begin
      Form1.EditSource.Text:=ShellTreeView1.Path;
      Form1.EditSource.SetFocus;
      FormChoixRepSource.Close;
  end;

end.
