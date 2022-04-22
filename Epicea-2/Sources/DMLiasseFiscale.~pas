unit DMLiasseFiscale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL,E2_Librairie_Obj,E2_Decl_records,LibZoneSaisie,DMEcriture;

type
  TDMLiasseFisc = class(TDataModule)
    QuPBilan: TQuery;
    TaPBilan: TTable;
    DaQuPBilan: TDataSource;
    QuPBilancompte: TStringField;
    QuParamLia: TQuery;
    TaBalanceCptPourZoneBilan: TTable;
    DaBalanceCptPourZoneBilan: TDataSource;
    TaPlanCpt: TTable;
    DaPlanCpt: TDataSource;
    TaBalanceCptPourZoneBilanCompte: TStringField;
    TaBalanceCptPourZoneBilanLibelle: TStringField;
    TaBalanceCptPourZoneBilanSoldeFinDebit: TCurrencyField;
    TaBalanceCptPourZoneBilanSoldeFinCredit: TCurrencyField;
    TaPBilan_Bic: TTable;
    taPBilanOuverture: TTable;
    procedure DMLiasseFiscCreate(Sender: TObject);
    procedure DMLiasseFiscDestroy(Sender: TObject);
    procedure TaBalanceCptPourZoneBilanCalcFields(DataSet: TDataSet);
    procedure TaBalanceCptPourZoneBilanBeforeInsert(DataSet: TDataSet);
    procedure TaBalanceCptPourZoneBilanBeforeEdit(DataSet: TDataSet);
    Procedure InitTableSurNumLiasse(NumLiasse:string);
    Procedure InitTableSurNumLiasse_Bic(NumLiasse:string);
//    Procedure InitTableSurNumLiasse_Ouverture(NumLiasse:string);

  private
    { Déclarations privées }
    ListeCompteFiltreBalance:TStringList;
  public
    { Déclarations publiques }
  end;

var
  DMLiasseFisc: TDMLiasseFisc;

implementation

uses DMRecherche, DMPlanCpt, DMDiocEtatBalance, E2_VisuListe, E2_Main;

{$R *.DFM}


procedure TDMLiasseFisc.DMLiasseFiscCreate(Sender: TObject);
begin
 ListeCompteFiltreBalance:=TStringList.Create;
end;

procedure TDMLiasseFisc.DMLiasseFiscDestroy(Sender: TObject);
begin
ListeCompteFiltreBalance.Free;
DMLiasseFisc := nil;
end;

procedure TDMLiasseFisc.TaBalanceCptPourZoneBilanCalcFields(
  DataSet: TDataSet);
var
TotauxBalance:TTotauxBalance;
begin
TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,TaBalanceCptPourZoneBilan.FindField('Compte').AsString);
TaBalanceCptPourZoneBilan.FindField('SoldeFinDebit').AsCurrency:=TotauxBalance.TotalSoldeDebitTotal;
TaBalanceCptPourZoneBilan.FindField('SoldeFinCredit').AsCurrency:=TotauxBalance.TotalSoldeCreditTotal;
end;

procedure TDMLiasseFisc.TaBalanceCptPourZoneBilanBeforeInsert(
  DataSet: TDataSet);
begin
abort;
end;

procedure TDMLiasseFisc.TaBalanceCptPourZoneBilanBeforeEdit(
  DataSet: TDataSet);
begin
abort;
end;

Procedure TDMLiasseFisc.InitTableSurNumLiasse(NumLiasse:string);
Begin
   DMLiasseFisc.TaPBilan.Close;
   DMLiasseFisc.QuParamLia.Close;
   DMLiasseFisc.QuParamLia.SQL.Clear;
   DMLiasseFisc.QuParamLia.SQL.add('select * from ParamLia');
   DMLiasseFisc.QuParamLia.SQL.add('where type =:TypeDocLiasse');
   DMLiasseFisc.QuParamLia.SQL.add('order by ID_Ligne');
   DMLiasseFisc.QuParamLia.ParamByName('TypeDocLiasse').AsString:=NumLiasse;
   DMLiasseFisc.QuParamLia.Open;
   DMLiasseFisc.QuParamLia.First;
   DMLiasseFisc.TaPBilan.Open;
End;

Procedure TDMLiasseFisc.InitTableSurNumLiasse_Bic(NumLiasse:string);
Begin
   DMLiasseFisc.TaPBilan.Close;
   DMLiasseFisc.QuParamLia.Close;
   DMLiasseFisc.QuParamLia.SQL.Clear;
   DMLiasseFisc.QuParamLia.SQL.add('select * from ParamLia_Bic');
   DMLiasseFisc.QuParamLia.SQL.add('where type =:TypeDocLiasse');
   DMLiasseFisc.QuParamLia.SQL.add('order by ID_Ligne');
   DMLiasseFisc.QuParamLia.ParamByName('TypeDocLiasse').AsString:=NumLiasse;
   DMLiasseFisc.QuParamLia.Open;
   DMLiasseFisc.QuParamLia.recordcount;
   DMLiasseFisc.QuParamLia.First;
   DMLiasseFisc.TaPBilan.Open;
End;


//Procedure TDMLiasseFisc.InitTableSurNumLiasse_Ouverture(NumLiasse:string);
//Begin
//   DMLiasseFisc.taPBilanOuverture.Close;
//   DMLiasseFisc.QuParamLia.Close;
//   DMLiasseFisc.QuParamLia.SQL.Clear;
//   DMLiasseFisc.QuParamLia.SQL.add('select * from ParamLia_ouverture');
//   DMLiasseFisc.QuParamLia.SQL.add('where type =:TypeDocLiasse');
//   DMLiasseFisc.QuParamLia.SQL.add('order by ID_Ligne');
//   DMLiasseFisc.QuParamLia.ParamByName('TypeDocLiasse').AsString:=NumLiasse;
//   DMLiasseFisc.QuParamLia.Open;
//   DMLiasseFisc.QuParamLia.recordcount;
//   DMLiasseFisc.QuParamLia.First;
//   DMLiasseFisc.taPBilanOuverture.Open;
//End;
end.
