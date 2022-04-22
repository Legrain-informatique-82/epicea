unit DMParamTaxes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL;

type
  TDMParamTaxe = class(TDataModule)
    TaParamTaxe: TTable;
    DataSource1: TDataSource;
    procedure DMParamTaxeCreate(Sender: TObject);
    procedure DMParamTaxeDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMParamTaxe: TDMParamTaxe;

  Function DiocTaxeContributionHabitant:currency;
  Function DiocTaxePastorale:currency;
implementation

{$R *.DFM}

Function DiocTaxeContributionHabitant:currency;
Begin
result:=0;
if DMParamTaxe = nil then DMParamTaxe:=TDMParamTaxe.Create(Application.MainForm);
if not DMParamTaxe.TaParamTaxe.Active then DMParamTaxe.TaParamTaxe.Open;
if DMParamTaxe.TaParamTaxe.Locate('ID',1,[]) then
 REsult:=DMParamTaxe.TaParamTaxe.findField('Montant').AsCurrency;
End;

Function DiocTaxePastorale:currency;
Begin
result:=0;
if DMParamTaxe = nil then DMParamTaxe:=TDMParamTaxe.Create(Application.MainForm);
if not DMParamTaxe.TaParamTaxe.Active then DMParamTaxe.TaParamTaxe.Open;
if DMParamTaxe.TaParamTaxe.Locate('ID',2,[]) then
 REsult:=DMParamTaxe.TaParamTaxe.findField('Montant').AsCurrency / 100;
End;

procedure TDMParamTaxe.DMParamTaxeCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
end;

procedure TDMParamTaxe.DMParamTaxeDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
end;

end.
