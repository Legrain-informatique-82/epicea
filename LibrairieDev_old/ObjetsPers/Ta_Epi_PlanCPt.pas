unit Ta_Epi_PlanCPt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,GR_GestPlanCpt;

type
  TTa_Epi_PlanCPt = class(TTable)
  private
  FTableParamCpt:TTable;
  FTablePlanListe:TTable;
  procedure InitKeyChamp;
  Procedure InitEventValidChamp;
  Procedure ValideCompte(sender : TField);
  Procedure ValideLibelle(sender : TField);

    { Déclarations privées }
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    ListeChamp: TStringList;
    Constructor Create(AOwner :TComponent); override;
	 Destructor Destroy;override;
    procedure PlcptAfterOpen(DataSet: TDataSet);
    procedure PlcptBeforeInsert(DataSet: TDataSet);
    procedure PlcptBeforePost(DataSet: TDataSet);
  published
    { Déclarations publiées }
    Property TableParamCpt:TTable Read FTableParamCpt write FTableParamCpt;
    Property TablePlanListe:TTable Read FTablePlanListe write FTablePlanListe;
  end;

procedure Register;

implementation

uses E2_Librairie,Gr_Librairie;

procedure Register;
begin
  RegisterComponents('TableEpi', [TTa_Epi_PlanCPt]);
end;

Constructor TTa_Epi_PlanCPt.Create(AOwner :TComponent);
begin
inherited create(AOwner);
ListeChamp:=TStringList.Create;
AfterOpen:=PlcptAfterOpen;
end;

Destructor TTa_Epi_PlanCPt.Destroy;
begin
inherited destroy;
ListeChamp.Free;
end;

//****************************************************************************//
//********Initialisation des caractères valide pour chaque champ**************//
//****************************************************************************//
procedure TTa_Epi_PlanCPt.InitKeyChamp;
begin
FieldByName('Compte').ValidChars:=['0','1','2','3','4','5','6','7','8','9'];
FieldByName('SensCredit').ValidChars:=['D','C','d','c'];
FieldByName('Collectif').ValidChars:=['O','o','N','n'];
FieldByName('Rapprochement').ValidChars:=['O','o','N','n'];
FieldByName('Immobilisation').ValidChars:=['O','o','N','n'];
FieldByName('PlanSaisie').ValidChars:=['O','o','N','n'];
end;

//****************************************************************************//
//********Initialisation des évènements onvalidation pour chaque champ********//
//****************************************************************************//
procedure TTa_Epi_PlanCPt.InitEventValidChamp;
begin
FieldByName('Compte').OnValidate:=ValideCompte;
FieldByName('Libelle').OnValidate:=ValideLibelle;
end;

//******************************************************************************
//*******Initialisation des variables à l'ouverture de la table***************//
//******************************************************************************
procedure TTa_Epi_PlanCPt.PlcptAfterOpen(DataSet: TDataSet);
begin
InitKeyChamp;
InitEventValidChamp;
BeforeInsert:=PlcptBeforeInsert;
BeforePost:=PlcptBeforePost;

end;

//******************************************************************************
//*******Initialisation des variables à l'ouverture de la table***************//
//******************************************************************************
procedure TTa_Epi_PlanCPt.PlcptBeforeInsert(DataSet: TDataSet);
begin
beep;
if ListeChamp<> nil then ListeChamp.Clear;
end;

//******************************************************************************
//*************Contrôle sur le champ compte après validation******************//
//******************************************************************************
Procedure TTa_Epi_PlanCPt.ValideCompte(sender : TField);
begin
if FieldByName('Compte').Text<>'' then
   begin
    if NumCompte(FieldByName('Compte').ASString)<>'' then
    begin
     if ValExisteDos('PlanCpt.db','Compte',FieldByName('Compte').ASString) then
       begin
      // si cpte existe ds PCU
       Erreur('Reference','Doublon');
       abort;
      end     // Fin cpte existe ds PCU
      else
      begin   // Si cpte non existe ds PCU
         if VerifCompteCptGene(FieldByName('Compte').AsString) then
         begin   // Si cpte Ok pour PCG
           if FieldByName('Libelle').AsString = '' then
           FieldByName('Libelle').Text := LibelleCompte(FieldByName('Compte').AsString);
           if ListeChamp<> nil then ListeChamp.Clear;
           ChampObligatoire( FieldByName('Compte').AsString, ListeChamp);
         end   // Fin cpte Ok pour PCG
         else
         begin // Si cpt non ok ds PCG
//         FieldByName('Compte').DisplayText
          FieldByName('Compte').Text:='';
          abort;
         end   // Fin cpt non ok ds PCG
      end
   end;
   end // Fin compte <> ''
   else if ListeChamp <> nil then ListeChamp.Clear;

end;

//******************************************************************************
//*************Contrôle sur le champ Libellé après validation******************//
//******************************************************************************
Procedure TTa_Epi_PlanCPt.ValideLibelle(sender : TField);
begin
//if FieldByName('Libelle').text='' then
//   begin
//     messagebox(0,'Vous devez saisir un libellé pour ce compte','Erreur de saisie',0);
//     FieldByName('Libelle').FocusControl;
//     abort;
//   end;
end;

procedure TTa_Epi_PlanCPt.PlcptBeforePost(DataSet: TDataSet);
var
i:integer;
begin
if FieldByName('Compte').text<>'' then
ValideCompte(FieldByName('Compte'))
else begin
     messagebox(0,'Vous devez obligatoirement saisir un numéro de compte ','Erreur de saisie',0);
     FieldByName('Compte').FocusControl;
     abort;
     end;
for i:=0 to ListeChamp.Count-1 do
 begin
//  if FieldByName(ListeChamp.Strings[i]).a
 end;
end;
end.
