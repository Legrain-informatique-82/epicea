unit dmComptesB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TdmCompteB = class(TDataModule)
    TaCompteB: TTable;
    daCompteB: TDataSource;
    TaCpt_CptB: TTable;
    daCpt_CptB: TDataSource;
    TaCompteBId: TIntegerField;
    TaCompteBCompteB: TStringField;
    TaCompteBLibelleB: TStringField;
    qTrouveRelationCompteB: TQuery;
    qMaxIdCompteB: TQuery;
    qMaxIdCompteBMaxId: TIntegerField;
    qTrouveCompteB: TQuery;
    TaCpt_CptBId: TIntegerField;
    TaCpt_CptBIDCompteB: TIntegerField;
    TaCpt_CptBCompte: TStringField;
    TaCpt_CptBCompteB: TStringField;
    TaCpt_CptBRatio: TFloatField;
    qTrouveCompte: TQuery;
    qMaxIdCpt_CptB: TQuery;
    qMaxIdCpt_CptBMaxId: TIntegerField;
    qEcritureCompteB: TQuery;
    daEcritureCompteB: TDataSource;
    qSumEcritureCompteB: TQuery;
    daSumEcritureCompteB: TDataSource;
    qSumRatioCompteB: TQuery;
    qEcritureCompteBCompteB: TStringField;
    qEcritureCompteBCompte: TStringField;
    qEcritureCompteBCredit: TCurrencyField;
    qEcritureCompteBDebit: TCurrencyField;
    qEcritureCompteBRatio: TFloatField;
    qSumEcritureCompteBTotCredit: TCurrencyField;
    qSumEcritureCompteBTotDebit: TCurrencyField;
    qSumRatioCompteBTotRatio: TFloatField;
    qEcritureCompteBLibelle: TStringField;
    procedure TaCompteBBeforeDelete(DataSet: TDataSet);
    procedure TaCompteBBeforeEdit(DataSet: TDataSet);
    procedure TaCompteBBeforePost(DataSet: TDataSet);
    procedure TaCompteBCompteBValidate(Sender: TField);
    procedure TaCpt_CptBBeforePost(DataSet: TDataSet);
    procedure TaCpt_CptBCompteValidate(Sender: TField);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Debit, Credit: Real;
    function TrouveRelationCompteB(Const CptB: String): Boolean;
    function RechercheMaxIdCompteB: Integer;
    function TrouveCompteB(Const CptB: String): Boolean;
    function TrouveCompte(Const Cpt: String): Boolean;
    function RechercheMaxIdCpt_CptB: Integer;
    procedure ListeEcritureCompteB(Const CompteB: String);
    procedure SumEcritureCompteB(Const CompteB: String);
    procedure CalculDebitCreditCompteB(Const CompteB: String; Const TypeGestion: Integer);
  end;

var
  dmCompteB: TdmCompteB;

implementation

uses dmCdps;

{$R *.DFM}

//******************************************************************************
//  Fonction qui permet de déterminer si le compteA est dans une table de relation
//******************************************************************************
function TdmCompteB.TrouveRelationCompteB(Const CptB : String): Boolean;
begin
     with qTrouveRelationCompteB do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteB').AsString := Trim(CptB);
          Open;
          Result := Not IsEmpty;
          Close;
     end;
end;

//******************************************************************************
//  Fonction qui permet de rechercher le max Id de la table CompteA
//******************************************************************************
function TdmCompteB.RechercheMaxIdCompteB: Integer;
begin
     with qMaxIdCompteB do
     begin
          If Active then close;
          Open;
          Result := FieldByName('MaxId').AsInteger;
          Close;
     end;
end;

//******************************************************************************
//  Fonction qui permet de tester l'existence d'un compteB
//******************************************************************************
function TdmCompteB.TrouveCompteB(Const CptB: String): Boolean;
begin
     With qTrouveCompteB do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteB').AsString := Trim(CptB);
          Open;
          Result := Not IsEmpty;
          Close;
     end;
end;

//******************************************************************************
//  Fonction qui permet de tester l'existence d'un compte
//******************************************************************************
function TdmCompteB.TrouveCompte(Const Cpt: String): Boolean;
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
//  Fonction qui permet de rechercher le max Id de la table Cpt_CptA
//******************************************************************************
function TdmCompteB.RechercheMaxIdCpt_CptB: Integer;
begin
     with qMaxIdCpt_CptB do
     begin
          If Active then close;
          Open;
          Result := FieldByName('MaxId').AsInteger;
          Close;
     end;
end;

//******************************************************************************
procedure TdmCompteB.TaCompteBBeforeDelete(DataSet: TDataSet);
begin
     If TrouveRelationCompteB(TaCpt_CptB.FieldByName('CompteB').AsString) Then
        Raise Exception.Create('Suppression impossible: ce compte est dans une table de relation');
end;

//******************************************************************************
procedure TdmCompteB.TaCompteBBeforeEdit(DataSet: TDataSet);
begin
     If TrouveRelationCompteB(TaCpt_CptB.FieldByName('CompteB').AsString) Then
        Raise Exception.Create('Modification impossible: ce compte est dans une table de relation');
end;

//******************************************************************************
procedure TdmCompteB.TaCompteBBeforePost(DataSet: TDataSet);
begin
     // Affectation Id en mode Insertion
     If DataSet.State = dsInsert Then
        DataSet.FieldByName('Id').AsInteger := RechercheMaxIdCompteB + 1;
end;

//******************************************************************************
procedure TdmCompteB.TaCompteBCompteBValidate(Sender: TField);
begin
     If TrouveCompteB(TaCompteB.FieldByName('CompteB').AsString) Then
        Raise Exception.Create('Ce compteA existe déjà');
end;

//******************************************************************************
procedure TdmCompteB.TaCpt_CptBBeforePost(DataSet: TDataSet);
begin
     // Vérifier l'existence du compte
     If Not TrouveCompte(DataSet.FieldByName('Compte').AsString) Then
     begin
          Raise Exception.Create('Ce numéro de compte n''existe pas');
     end;
     // Affectation Id en mode insertion
     If DataSet.State = dsInsert Then
     begin
          DataSet.FieldByName('Id').AsInteger := RechercheMaxIdCpt_CptB + 1;
          DataSet.FieldByName('IdCompteB').AsInteger := TaCompteB.FieldByName('Id').Asinteger;
          Dataset.FieldByName('CompteB').AsString := TaCompteB.FieldByName('CompteB').AsString;
     end;
end;

//******************************************************************************
procedure TdmCompteB.TaCpt_CptBCompteValidate(Sender: TField);
begin
     If Not TrouveCompte(TaCpt_CptB.FieldByName('Compte').AsString) Then
        Raise Exception.Create('Ce numéro de compte n''existe pas');
end;

//******************************************************************************
procedure TdmCompteB.ListeEcritureCompteB(Const CompteB: String);
begin
     With qEcritureCompteB do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteB').AsString := Trim(CompteB);
          Open;
     end;
end;

//******************************************************************************
procedure TdmCompteB.SumEcritureCompteB(Const CompteB: String);
begin
     With qSumEcritureCompteB do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteB').AsString := Trim(CompteB);
          Open;
     end;
end;

//******************************************************************************
procedure TdmCompteB.CalculDebitCreditCompteB(Const CompteB: String; Const TypeGestion: Integer);
var
   RatioTotal: real;
begin
     // Calcul du ratio total pour le compteB
     With qSumRatioCompteB do
     begin
          If Active Then Close;
          Params.ParamByName('vCompteB').AsString := Trim(CompteB);
          Open;
          RatioTotal := FieldByName('TotRatio').AsFloat;
          Close;
     end;
     Debit := 0;
     Credit := 0;
     // Calcul du débit/Crédit du compteB
     With qSumEcritureCompteB do
     begin
          If Active Then Close;
          Sql.Clear;
          Sql.Add('Select ');
          Sql.Add('  Sum((Cpt_CptB.Ratio / ' + FloatToStr(RatioTotal) + ') * E.Credit) As TotCredit, ');
          Sql.Add('  Sum((Cpt_CptB.Ratio / ' + FloatToStr(RatioTotal) + ') * E.debit) As TotDebit ');
          Sql.Add('From CompteB CptB ');
          Sql.Add('  Join Cpt_CptB CptCptB On (CptB.Id = CptCptB.IdCompteB) ');
          Sql.Add('  Join Ecriture E On (E.Compte = CptCptB.Compte) ');
          Sql.Add('Where CptB.CompteB = ''' + Trim(CompteB) + '''');
          Open;
          Case TypeGestion Of
               0 : begin
                       // Gestion du Cdp
                       dmCdp.Debit := dmCdp.Debit + (dmCdp.Ratio * FieldByName('TotDebit').AsFloat);
                       dmCdp.Credit := dmCdp.Credit + (dmCdp.Ratio * FieldByName('TotCredit').AsFloat);
               end;
               -1, 1: begin
                        // Gestion du compteB
                        Debit := FieldByName('TotDebit').AsFloat;
                        Credit := FieldByName('TotCredit').AsFloat;
               end;
          end;
          Close;
     end;
end;

end.
