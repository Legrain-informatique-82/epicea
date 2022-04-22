unit dmComptesA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TRETFonction = record
     result: boolean;
     codeerreur: integer;
  end;

  TdmCompteA = class(TDataModule)
    TaCompteA: TTable;
    daCompteA: TDataSource;
    TaCpt_CptA: TTable;
    daCpt_CptA: TDataSource;
    TaCpt_CptAId: TIntegerField;
    TaCpt_CptACompte: TStringField;
    TaCpt_CptACompteA: TStringField;
    TaCpt_CptARatio: TFloatField;
    TaCpt_CptAIDCompteA: TIntegerField;
    qTrouveCompte: TQuery;
    qTrouveCompteA: TQuery;
    qTrouveRelationCompteA: TQuery;
    qMaxIdCompteA: TQuery;
    qMaxIdCompteAMaxId: TIntegerField;
    qMaxIdCpt_CptA: TQuery;
    qMaxIdCpt_CptAMaxId: TIntegerField;
    TaCompteAId: TIntegerField;
    TaCompteACompteA: TStringField;
    TaCompteALibelleA: TStringField;
    qEcritureCompteA: TQuery;
    daEcritureCompteA: TDataSource;
    qEcritureCompteACompteA: TStringField;
    qEcritureCompteACompte: TStringField;
    qEcritureCompteACredit: TCurrencyField;
    qEcritureCompteADebit: TCurrencyField;
    qEcritureCompteARatio: TFloatField;
    qSumEcritureCompteA: TQuery;
    daSumEcritureCompteA: TDataSource;
    qSumRatioCompteA: TQuery;
    qSumRatioCompteATotRatio: TFloatField;
    qSumEcritureCompteATotCredit: TCurrencyField;
    qSumEcritureCompteATotDebit: TCurrencyField;
    qEcritureCompteALibelle: TStringField;
    procedure TaCompteABeforePost(DataSet: TDataSet);
    procedure TaCompteABeforeDelete(DataSet: TDataSet);
    procedure TaCompteABeforeEdit(DataSet: TDataSet);
    procedure TaCpt_CptABeforePost(DataSet: TDataSet);
    procedure TaCpt_CptACompteValidate(Sender: TField);
    procedure TaCompteACompteAValidate(Sender: TField);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Debit, Credit: Real;
    function TrouveCompte(Const Cpt: String): Boolean;
    function TrouveCompteA(Const CptA: String): Boolean;
    function TrouveRelationCompteA(Const CptA: String): Boolean;
    function RechercheMaxIdCompteA: Integer;
    function RechercheMaxIdCpt_CptA: Integer;
    procedure ListeEcritureCompteA(Const CompteA: String);
    procedure SumEcritureCompteA(Const CompteA: String);
    procedure CalculDebitCreditCompteA(Const CompteA: String; Const TypeGestion: Integer);
  end;

var
  dmCompteA: TdmCompteA;

implementation

uses Unit1, dmCdps;

{$R *.DFM}

//******************************************************************************
//  Fonction qui permet de tester l'existence d'un compte
//******************************************************************************
function TdmCompteA.TrouveCompte(Const Cpt: String): Boolean;
begin
     With qTrouveCompte do
     begin
          If Active Then Close;
          Params.ParamByName('vCompte').AsString := Trim(Cpt);
          Open;
          Result := Not IsEmpty;
          Close;
     end;
end;

//******************************************************************************
//  Fonction qui permet de tester l'existence d'un compteA
//******************************************************************************
function TdmCompteA.TrouveCompteA(Const CptA: String): Boolean;
begin
     With qTrouveCompteA do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteA').AsString := Trim(CptA);
          Open;
          Result := Not IsEmpty;
          Close;
     end;
end;

//******************************************************************************
//  Fonction qui permet de déterminer si le compteA est dans une table de relation
//******************************************************************************
function TdmCompteA.TrouveRelationCompteA(Const CptA : String): Boolean;
begin
     with qTrouveRelationCompteA do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteA').AsString := Trim(CptA);
          Open;
          Result := Not IsEmpty;
          Close;
     end;
end;

//******************************************************************************
//  Fonction qui permet de rechercher le max Id de la table CompteA
//******************************************************************************
function TdmCompteA.RechercheMaxIdCompteA: Integer;
begin
     with qMaxIdCompteA do
     begin
          If Active then close;
          Open;
          Result := FieldByName('MaxId').AsInteger;
          Close;
     end;
end;

//******************************************************************************
//  Fonction qui permet de rechercher le max Id de la table Cpt_CptA
//******************************************************************************
function TdmCompteA.RechercheMaxIdCpt_CptA: Integer;
begin
     with qMaxIdCpt_CptA do
     begin
          If Active then close;
          Open;
          Result := FieldByName('MaxId').AsInteger;
          Close;
     end;
end;

//******************************************************************************
procedure TdmCompteA.TaCompteABeforePost(DataSet: TDataSet);
begin
     // Affectation Id en mode Insertion
     If DataSet.State = dsInsert Then
        DataSet.FieldByName('Id').AsInteger := RechercheMaxIdCompteA + 1;
end;

//******************************************************************************
procedure TdmCompteA.TaCpt_CptABeforePost(DataSet: TDataSet);
begin
     // Vérifier l'existence du compte
     If Not TrouveCompte(DataSet.FieldByName('Compte').AsString) Then
     begin
          Raise Exception.Create('Ce numéro de compte n''existe pas');
     end;
     // Affectation Id en mode insertion
     If DataSet.State = dsInsert Then
     begin
          DataSet.FieldByName('Id').AsInteger := RechercheMaxIdCpt_CptA + 1;
          DataSet.FieldByName('IdCompteA').AsInteger := TaCompteA.FieldByName('Id').Asinteger;
          Dataset.FieldByName('CompteA').AsString := TaCompteA.FieldByName('CompteA').AsString;
     end;
end;

//******************************************************************************
procedure TdmCompteA.TaCpt_CptACompteValidate(Sender: TField);
begin
     If Not TrouveCompte(TaCpt_CptA.FieldByName('Compte').AsString) Then
        Raise Exception.Create('Ce numéro de compte n''existe pas');
end;

//******************************************************************************
procedure TdmCompteA.TaCompteACompteAValidate(Sender: TField);
begin
     If TrouveCompteA(TaCompteA.FieldByName('CompteA').AsString) Then
        Raise Exception.Create('Ce compteA existe déjà');
end;

//******************************************************************************
procedure TdmCompteA.TaCompteABeforeDelete(DataSet: TDataSet);
begin
     If TrouveRelationCompteA(TaCpt_CptA.FieldByName('CompteA').AsString) Then
        Raise Exception.Create('Suppression impossible: ce compte est dans une table de relation');
end;

//******************************************************************************
procedure TdmCompteA.TaCompteABeforeEdit(DataSet: TDataSet);
begin
     If TrouveRelationCompteA(TaCpt_CptA.FieldByName('CompteA').AsString) Then
        Raise Exception.Create('Modification impossible: ce compte est dans une table de relation');
end;

//******************************************************************************
procedure TdmCompteA.ListeEcritureCompteA(Const CompteA: String);
begin
     With qEcritureCompteA do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteA').AsString := Trim(CompteA);
          Open;
     end;
end;

//******************************************************************************
procedure TdmCompteA.SumEcritureCompteA(Const CompteA: String);
begin
     With qSumEcritureCompteA do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteA').AsString := Trim(CompteA);
          Open;
     end;
end;


//******************************************************************************
procedure TdmCompteA.CalculDebitCreditCompteA(Const CompteA: String; Const TypeGestion: Integer);
var
   RatioTotal: real;
begin
     // Calcul du ratio total pour le compteA
     With qSumRatioCompteA do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteA').AsString := Trim(CompteA);
          Open;
          RatioTotal := FieldByName('TotRatio').AsFloat;
          Close;
     end;
     Debit := 0;
     Credit := 0;
     // Calcul du débit/Crédit du compteA
     With qSumEcritureCompteA do
     begin
          If Active Then Close;
          Sql.Clear;
          Sql.Add('Select ');
          Sql.Add('  Sum((Cpt_CptA.Ratio / ' + FloatToStr(RatioTotal) + ') * E.Credit) As TotCredit, ');
          Sql.Add('  Sum((Cpt_CptA.Ratio / ' + FloatToStr(RatioTotal) + ') * E.debit) As TotDebit ');
          Sql.Add('From CompteA CptA ');
          Sql.Add('  Join Cpt_CptA CptCptA On (CptA.Id = CptCptA.IdCompteA) ');
          Sql.Add('  Join Ecriture E On (E.Compte = CptCptA.Compte) ');
          Sql.Add('Where CptA.CompteA = ''' + Trim(CompteA) + '''');
          Open;
          Case TypeGestion Of
               0 : begin
                       // Gestion du Cdp
                       dmCdp.Debit := dmCdp.Debit + (dmCdp.Ratio * FieldByName('TotDebit').AsFloat);
                       dmCdp.Credit := dmCdp.Credit + (dmCdp.Ratio * FieldByName('TotCredit').AsFloat);
               end;
               -1: begin
                        // Gestion du compteA
                        Debit := FieldByName('TotDebit').AsFloat;
                        Credit := FieldByName('TotCredit').AsFloat;
               end;
          end;
          Close;
     end;
end;

end.
