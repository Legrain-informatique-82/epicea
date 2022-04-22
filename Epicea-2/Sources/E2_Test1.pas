unit E2_Test1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,E2_Librairie_Obj,DMEcriture, Grids, DBGrids, RXCtrls,
  LibDates,
  Mask, ToolEdit;

type
  TTest1 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    DBGrid1: TDBGrid;
    DateEdit1: TDateEdit;
    RxLabel1: TRxLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DateEdit1Change(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Test1: TTest1;

implementation

{$R *.dfm}

procedure TTest1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  E.AccesOuverture := not CheckBox1.Checked;
  E.AccesCloture := not CheckBox2.Checked;
end;

procedure TTest1.DateEdit1Change(Sender: TObject);
begin
RxLabel1.Caption := IntTostr(DateInfos(date).an)+IntTostr(DateInfos(date).mois)+IntTostr(DateInfos(date).jour);
end;

end.
