unit DMDiocEtatGestionAnalytique;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,E2_Librairie_Obj,E2_Decl_Records,LibSQL;

type
  TDMDiocEtatGestionAnal = class(TDataModule)
    QuEtatAnal: TQuery;
    TaTrame: TTable;
    DaTrame: TDataSource;
    DaEtatAnal: TDataSource;
    QuEtatAnalcompte: TStringField;
    QuEtatAnalCredit: TCurrencyField;
    QuEtatAnalDebit: TCurrencyField;
    QuEtatAnalSolde: TCurrencyField;
    TaTrameID: TAutoIncField;
    TaTrameLibelle_Trame: TStringField;
    TaTrameJournal: TStringField;
    TaTrameCompte: TStringField;
    TaTrameSolde: TCurrencyField;
    TaTrameL: TTable;
    DaTrameL: TDataSource;
    TaTrameLID: TAutoIncField;
    TaTrameLID_Trame: TIntegerField;
    TaTrameLLigne: TSmallintField;
    TaTrameLCompte: TStringField;
    TaTrameLLibelle: TStringField;
    TaTrameLSolde: TCurrencyField;
    QuTotauxTrame: TQuery;
    QuTotauxTrameCredit: TCurrencyField;
    QuTotauxTrameDebit: TCurrencyField;
    QuTotauxTrameSolde: TCurrencyField;
    TaTrameCode: TStringField;
    procedure DMDiocEtatGestionAnalCreate(Sender: TObject);
    procedure DMDiocEtatGestionAnalDestroy(Sender: TObject);
    procedure QuEtatAnalBeforeInsert(DataSet: TDataSet);
    procedure QuEtatAnalBeforeEdit(DataSet: TDataSet);
    procedure TaTrameLCalcFields(DataSet: TDataSet);
    procedure TaTrameLBeforeOpen(DataSet: TDataSet);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMDiocEtatGestionAnal: TDMDiocEtatGestionAnal;
  Function DiocTotauxTrame(DateDeb,DateFin:TDate;CodeTrame:string):TTotaux;

implementation

uses E2_EtatGestAnal;
{$R *.DFM}

Function DiocTotauxTrame(DateDeb,DateFin:TDate;CodeTrame:string):TTotaux;
Begin
result.debit:=0;
result.credit:=0;
result.solde:=0;
if DMDiocEtatGestionAnal = nil then DMDiocEtatGestionAnal:=TDMDiocEtatGestionAnal.Create(Application.MainForm);
DMDiocEtatGestionAnal.QuTotauxTrame.Close;
DMDiocEtatGestionAnal.QuTotauxTrame.ParamByName('DateDeb').AsDate:=DateDeb;
DMDiocEtatGestionAnal.QuTotauxTrame.ParamByName('DateFin').AsDate:=DateFin;
DMDiocEtatGestionAnal.QuTotauxTrame.ParamByName('CodeTrame').AsString:=CodeTrame;
DMDiocEtatGestionAnal.QuTotauxTrame.open;
if DMDiocEtatGestionAnal.QuTotauxTrameDebit.AsCurrency <> 0 then
result.debit:=DMDiocEtatGestionAnal.QuTotauxTrameDebit.AsCurrency;
if DMDiocEtatGestionAnal.QuTotauxTrameCredit.AsCurrency <> 0 then
result.Credit:=DMDiocEtatGestionAnal.QuTotauxTrameCredit.AsCurrency;
if DMDiocEtatGestionAnal.QuTotauxTrameSolde.AsCurrency <> 0 then
result.Solde:=abs(DMDiocEtatGestionAnal.QuTotauxTrameSolde.AsCurrency);
End;


procedure TDMDiocEtatGestionAnal.DMDiocEtatGestionAnalCreate(
  Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
end;

procedure TDMDiocEtatGestionAnal.DMDiocEtatGestionAnalDestroy(
  Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMDiocEtatGestionAnal:=nil;
end;

procedure TDMDiocEtatGestionAnal.QuEtatAnalBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMDiocEtatGestionAnal.QuEtatAnalBeforeEdit(DataSet: TDataSet);
begin
abort;
end;

procedure TDMDiocEtatGestionAnal.TaTrameLCalcFields(DataSet: TDataSet);
begin
if QuEtatAnal.Locate('Compte',TaTrameLcompte.AsString,[]) then
//if TaTrame.Locate('Compte',QuEtatAnalcompte.AsString,[]) then
TaTrameLSolde.AsCurrency:=abs(QuEtatAnalSolde.AsCurrency) else
TaTrameLSolde.AsCurrency:=0;
end;

procedure TDMDiocEtatGestionAnal.TaTrameLBeforeOpen(DataSet: TDataSet);
begin
TaTrameLSolde.DisplayFormat:=E.FormatMonnaie;
end;

end.
