unit DMImmo_Clot;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL,E2_ImmoEnCours,RxMemDS,DMPlanCpt,DMBalances,
  E2_AideCompte,Gr_Librairie_obj, E2_Librairie_obj,DMImmos,E2_Decl_Records,
  DMTVA,AideMontant2,Libdates,PickDate,stdctrls,DMDiocEtatBalance,
  E2_Cloture_Def,
  LibZoneSaisie,
  E2_LibInfosTable,
  DMConstantes,
  LibRessourceString,
  DMProgramme,
  Lib_Chaine;
  

type

  TDMImmo_Clo = class(TDataModule)
    TaImmo_Clo: TTable;
    DaImmo_Clo: TDataSource;
    QuListeCharge: TQuery;
    DaListeCharge: TDataSource;
    QuListeChargeReference: TStringField;
    QuListeChargeDate: TDateField;
    QuListeChargeCompte: TStringField;
    QuListeChargeDebitSaisie: TCurrencyField;
    QuListeCompteCharge: TQuery;
    StringField2: TStringField;
    QuMaxCode: TQuery;
    QuMaxCodeMaxCode: TFloatField;
    QuTotauxCompte: TQuery;
    QuTotauxCompteCompte: TStringField;
    QuTotauxCompteTotalDebit: TCurrencyField;
    QuListeChargeID: TIntegerField;
    QuEcritureImmos_Periode: TQuery;
    QuImmos_Periode: TQuery;
    QuListeChargeLibelle: TStringField;
    TaImmo_Clo2: TTable;
    TaImmo_Clo2ID: TIntegerField;
    TaImmo_Clo2Code: TFloatField;
    TaImmo_Clo2Reference_OP: TStringField;
    TaImmo_Clo2COMPTE: TStringField;
    TaImmo_Clo2Contrepartie: TStringField;
    TaImmo_Clo2Designation: TStringField;
    TaImmo_Clo2Quantite: TIntegerField;
    TaImmo_Clo2Montant: TCurrencyField;
    TaImmo_Clo2TVA: TCurrencyField;
    TaImmo_Clo2Date: TDateField;
    TaImmo_Clo2Type_Immo: TFloatField;
    TaImmo_CloID: TIntegerField;
    TaImmo_CloCode: TFloatField;
    TaImmo_CloReference_OP: TStringField;
    TaImmo_CloCOMPTE: TStringField;
    TaImmo_CloContrepartie: TStringField;
    TaImmo_CloDesignation: TStringField;
    TaImmo_CloQuantite: TIntegerField;
    TaImmo_CloMontant: TCurrencyField;
    TaImmo_CloTVA: TCurrencyField;
    TaImmo_CloDate: TDateField;
    TaImmo_CloType_Immo: TFloatField;
    TaImmo_CloConsultation: TTable;
    TaImmo_CloConsultationID: TIntegerField;
    TaImmo_CloConsultationCode: TFloatField;
    TaImmo_CloConsultationReference_OP: TStringField;
    TaImmo_CloConsultationCOMPTE: TStringField;
    TaImmo_CloConsultationContrepartie: TStringField;
    TaImmo_CloConsultationDesignation: TStringField;
    TaImmo_CloConsultationQuantite: TIntegerField;
    TaImmo_CloConsultationMontant: TCurrencyField;
    TaImmo_CloConsultationTVA: TCurrencyField;
    TaImmo_CloConsultationDate: TDateField;
    TaImmo_CloConsultationType_Immo: TFloatField;
    QuVerifImmoAmortissableAvantClot_avecCession: TQuery;
    QuVerifImmoAmortissableAvantClot_avecCessioncompte: TStringField;
    QuVerifImmoAmortissableAvantClot_avecCessionEco: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionValeur_a_amortir: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionamort_derog: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionAmort_eco: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionvaleur_nette: TCurrencyField;
    QuImmo_Cede_Dans_Annee: TQuery;
    QuImmo_Cede_Dans_Anneecompte: TStringField;
    QuImmo_Cede_Dans_AnneeEco: TCurrencyField;
    QuImmo_Cede_Dans_AnneeDerog: TCurrencyField;
    QuImmo_Cede_Dans_AnneeValeur_a_amortir: TCurrencyField;
    QuImmo_Cede_Dans_Anneeamort_derog: TCurrencyField;
    QuImmo_Cede_Dans_AnneeAmort_eco: TCurrencyField;
    QuImmo_Cede_Dans_Anneevaleur_nette: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_sansCession: TQuery;
    QuVerifImmoAmortissableAvantClot_sansCessioncompte: TStringField;
    QuVerifImmoAmortissableAvantClot_sansCessionEco: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_sansCessionDerog: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_sansCessionValeur_a_amortir: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_sansCessionamort_derog: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_sansCessionAmort_eco: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_sansCessionvaleur_nette: TCurrencyField;
    QuAmortDerogDebit_SiDerog: TQuery;
    QuAmortDerogCredit_SiDerog: TQuery;
    QuAmortDerogDebit_SiDerogcompte: TStringField;
    QuAmortDerogDebit_SiDerogSumDerogDebit: TCurrencyField;
    QuAmortDerogCredit_SiDerogcompte: TStringField;
    QuAmortDerogCredit_SiDerogSumDerogCredit: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionDerogDebit: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionDerogCredit: TCurrencyField;
    QuAmortDerogDebit_SiNonDerog: TQuery;
    StringField1: TStringField;
    CurrencyField1: TCurrencyField;
    QuAmortDerogCredit_SiNonDerog: TQuery;
    StringField3: TStringField;
    CurrencyField2: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionDerogDebit_Non: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionDerogCredit_Non: TCurrencyField;
    QuEcoSiDerog: TQuery;
    TaImmos_ChangementExo: TTable;
    TaImmos_ChangementExoID: TIntegerField;
    TaImmos_ChangementExoLibelle: TStringField;
    TaImmos_ChangementExoEcriture_Achat: TIntegerField;
    TaImmos_ChangementExoEcriture_Cession: TIntegerField;
    TaImmos_ChangementExoCompte: TStringField;
    TaImmos_ChangementExoCode: TStringField;
    TaImmos_ChangementExoSous_Code: TStringField;
    TaImmos_ChangementExoDate_Org: TDateField;
    TaImmos_ChangementExoValeur_Org: TCurrencyField;
    TaImmos_ChangementExoValeur_Venale: TCurrencyField;
    TaImmos_ChangementExoDuree: TSmallintField;
    TaImmos_ChangementExoValeur_a_Amortir: TCurrencyField;
    TaImmos_ChangementExoDate_Achat: TDateField;
    TaImmos_ChangementExoDate_Mise_en_Service: TDateField;
    TaImmos_ChangementExoDuree_Amt: TSmallintField;
    TaImmos_ChangementExoType_Amt: TStringField;
    TaImmos_ChangementExoDeduc_Invest: TBooleanField;
    TaImmos_ChangementExoMt_Deduc_Invest: TCurrencyField;
    TaImmos_ChangementExoReprise_deduc_invest: TCurrencyField;
    TaImmos_ChangementExoValeur_Nette: TCurrencyField;
    TaImmos_ChangementExoAmort_Eco: TCurrencyField;
    TaImmos_ChangementExoAmort_Derog: TCurrencyField;
    TaImmos_ChangementExoMt_Cession: TCurrencyField;
    TaImmos_ChangementExoDate_Cession: TDateField;
    TaImmos_ChangementExoRebut: TBooleanField;
    TaImmos_ChangementExoAchat_dans_Annee: TBooleanField;
    TaImmos_ChangementExoCession_dans_Annee: TBooleanField;
    TaImmos_ChangementExoDuree_Restante: TSmallintField;
    TaImmos_ChangementExoSimulation: TStringField;
    TaImmos_ChangementExoSous_Compte: TBooleanField;
    TaImmos_ChangementExoMaxi: TCurrencyField;
    TaImmos_ChangementExoMini: TCurrencyField;
    TaImmos_ChangementExoChoix: TCurrencyField;
    TaImmos_ChangementExoEco: TCurrencyField;
    TaImmos_ChangementExoTerminee: TBooleanField;
    TaImmos_ChangementExoEnCours: TBooleanField;
    TaImmos_ChangementExoCodeTerminee: TStringField;
    TaImmos_ChangementExoCompteTerminee: TStringField;
    TaImmos_ChangementExoTauxAmo: TFloatField;
    TaImmos_ChangementExoTiers: TStringField;
    TaImmos_ChangementExoReferenceFacture: TStringField;
    TaImmos_ChangementExoMontantTTC: TCurrencyField;
    QuVerifImmoAmortissableAvantClot_avecCessionDerog: TCurrencyField;
    TaImmos_ChangementExoSousCodeTerminee: TStringField;
    procedure DMImmo_CloCreate(Sender: TObject);
    procedure DMImmo_CloDestroy(Sender: TObject);
    function MaxCode:Integer;
    Procedure InitTotauxCompteSelectionne(ListeRef:TStringList);
    Procedure EcritureReference(ID:integer;Ref:string);
    procedure AfterEnregistrementModif;
    function CreationListeOD:TStringList;
    procedure CreationOD_Immos(typeImmos:integer);
    Function CtrlSaisieImmos_Clo(CCourant:Tfield):TErreurSaisie;
    procedure DemandeAffichageReprise(caption:string);
    procedure FiltrageAffichageGrille(Tag_bis:integer;Cpt:string);
    function FiltrageReference(typeImmo:integer):boolean;
    procedure TaImmo_CloAfterDelete(DataSet: TDataSet);
    procedure TaImmo_CloAfterPost(DataSet: TDataSet);
    procedure TaImmo_CloBeforeDelete(DataSet: TDataSet);
    procedure TaImmo_CloBeforeEdit(DataSet: TDataSet);
    procedure TaImmo_CloBeforePost(DataSet: TDataSet);
    procedure TaImmo_CloDeleteError(DataSet: TDataSet;
              E: EDatabaseError; var Action: TDataAction);
    procedure TaImmo_CloPostError(DataSet: TDataSet;
              E: EDatabaseError; var Action: TDataAction);
    function FiltragePourCreationOD(dataset:Tdataset;TypeImmo:integer):Boolean;
    procedure GestionFiltrageAideCompte(ObjetAppelant:string);
    procedure FiltragesAideCompte(Famille:integer);
    procedure VerifTVA;
    procedure TaImmo_CloBeforeInsert(DataSet: TDataSet);
    function CompareSoldeCompteImmo_CompteComptable(DataImmo:Tdataset;DateDebut,DateFin:Tdatetime):Tlist;
    function GenererPieceDotation(var reference:string;VerifPiece:boolean=false):TResultStrList;
//    function GenererPieceDotation(var reference:string):boolean;
    Procedure TraitementCloture1(Sender:TObject);
    Procedure TraitementCloture2(Sender:TObject);
    Procedure TraitementCloture3(Sender:TObject);
    Procedure TraitementCloture6(Sender:TObject);
    procedure CreationODImmos_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure QuVerifImmoAmortissableAvantClot_avecCessionBeforeOpen(
      DataSet: TDataSet);
    procedure TaImmos_ChangementExoAfterPost(DataSet: TDataSet);
    function SuppressionPieceDeDotationAmortissement(var reference:string;DemandeConfirmation:boolean=true):boolean;
    procedure QuVerifImmoAmortissableAvantClot_avecCessionFilterRecord(
      DataSet: TDataSet; var Accept: Boolean);
    
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    BoutonEnregistrer:boolean;
    Contrepartie:string;
    ImmosEnCours:tinfosimmos;
  end;

var
  DMImmo_Clo: TDMImmo_Clo;
  EtatTable:TDataSetState;
  MontantTmp,MontantTVATmp: Currency;
  DesignationTmp,compteTmp: String;
  OD,compte:string;
  montantBilan:currency;
  erreurClotureImmo:Tlist;

    function SauvegardeImmosExo(DestPath:string='Defaut';SourcePath:string='Defaut';Table:TTable=nil):TexceptLGR;
    function RestaureImmosDossier:TexceptLGR;
    function RestaureImmosDossierNew(SourcePath:string='Defaut';aliasTableSource:string='Defaut'):TexceptLGR;

  Function ListeCompteCharge(Cpt:string;DateDebutExo,DateFinExo:Tdatetime):TStringList;
  function RecupCompteDotationSurCompteImmo(Famille:integer;compte:string):TCompteAmortissement;
  function RecupCompte_A_Solder_SurCompteImmo(Famille:integer;compte:string):string;

    function VerifGestionImmo_AvantCloture(DateDebut,DateFin:Tdatetime):TerreurCloture;
    function VerifResteAcquisitionOuCession_AvantCloture(DateDebut,DateFin:Tdatetime):TerreurCloture;
    function InitialisationDesImmosApresChangementExercice:boolean;

implementation

uses DMPiece, DMChargesCA, E2_Main, DMImportation,DMBaseDonnee,
DMCorrection,
  DMRecherche, Gr_MultDos;

{$R *.DFM}

procedure TDMImmo_Clo.DMImmo_CloCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(self); 
end;

procedure TDMImmo_Clo.DMImmo_CloDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
if DataModuleImmos<>nil then  DataModuleImmos.Free;
DMImmo_Clo:=nil;
end;

Function ListeCompteCharge(Cpt:string;DateDebutExo,DateFinExo:Tdatetime):TStringList;
Begin
if DMImmo_Clo=nil then DMImmo_Clo:=TDMImmo_Clo.create(Application.MainForm);
result:=TStringList.Create;
if result.Count > 0 then result.Clear;
DMImmo_Clo.QuListeCompteCharge.Close;
DMImmo_Clo.QuListeCompteCharge.ParamByName('Cpt').AsString:=Cpt;
DMImmo_Clo.QuListeCompteCharge.ParamByName('DebutExo').Asdatetime:=DateDebutExo;
DMImmo_Clo.QuListeCompteCharge.ParamByName('FinExo').Asdatetime:=DateFinExo;
DMImmo_Clo.QuListeCompteCharge.open;
DMImmo_Clo.QuListeCompteCharge.First;
while not DMImmo_Clo.QuListeCompteCharge.EOF do
      Begin
      result.Add(DMImmo_Clo.QuListeCompteCharge.findfield('Compte').AsString);
      DMImmo_Clo.QuListeCompteCharge.Next;
      End;
DMImmo_Clo.QuListeCompteCharge.Close;
End;

function TDMImmo_Clo.MaxCode:Integer;
Begin
QuMaxCode.Close;
QuMaxCode.Open;
result:=QuMaxCodeMaxCode.AsInteger+1;
QuMaxCode.Close;
End;


Procedure TDMImmo_Clo.InitTotauxCompteSelectionne(ListeRef:TStringList);
Begin
QuTotauxCompte.Close;
QuTotauxCompte.SQL.Clear;
QuTotauxCompte.SQL.Add('select Ecriture.Compte, sum(Ecriture.DebitSaisie) TotalDebit from Piece ');
QuTotauxCompte.SQL.Add('join Ecriture on (Piece.Id = Ecriture.Id_Piece) where ');
QuTotauxCompte.SQL.Add(CreeFiltreOU('Ecriture.ID',[ListeRef]));
QuTotauxCompte.SQL.Add(' group by Ecriture.compte');
QuTotauxCompte.Open;
End;


Procedure TDMImmo_Clo.EcritureReference(ID:integer;Ref:string);
begin
  if TaImmo_CloConsultation.Locate('ID',ID,[]) then
  begin
  TaImmo_CloConsultation.Edit;
  TaImmo_CloConsultationReference_OP.Value:= Ref;
  TableGerePost(TaImmo_CloConsultation);
 end;
end;

procedure TDMImmo_Clo.AfterEnregistrementModif;
var
ODModif:string;
begin
ODModif:='';
ODModif:=TaImmo_CloReference_OP.AsString;
 if trim(TaImmo_CloReference_OP.AsString)<>'' then
   begin //si la charge a une OD
     if (TaImmo_CloMontant.AsCurrency<>MontantTmp) or (TaImmo_CloTVA.AsCurrency<>MontantTVATmp) then
       begin//si montant a changé
           DMPieces.SuppressionOD(TaImmo_CloReference_OP.AsString);
           CreationODImmos_avecObjet(taimmo_clo,ODModif);
       end//fin montant a changé
       else
       if TaImmo_CloDesignation.AsString<>DesignationTmp then
         begin //si désignation a changé
           DMPieces.ModificationOD(ODModif,TaImmo_CloDesignation.AsString);
         end;//fin désignation a changé
   end;  //fin la charge a une OD

end;

function TDMImmo_Clo.CreationListeOD:TStringList;
begin
try
FiltrageReference(self.tag);
result:=TStringList.Create;
result.Clear;
 While (Not(TaImmo_Clo.EOF)) Do
   Begin
   If result.IndexOf(TaImmo_CloReference_OP.AsString) = -1 Then
      result.Add(TaImmo_CloReference_OP.AsString);
   TaImmo_Clo.Next;
   End;
except
  result.clear;
end;//fin du try except     
end;

procedure TDMImmo_Clo.CreationOD_Immos(typeImmos:integer);
begin
    try
    TableGereStartTransaction(TaImmo_Clo2);
    FiltragePourCreationOD(TaImmo_Clo2,typeImmos);
    //filtrage de TaImmo_Clo2 de la reference remplie ou non
    TaImmo_Clo2.First;
        While (Not(TaImmo_Clo2.EOF)) Do
        Begin
        CreationODImmos_avecObjet(TaImmo_Clo2,'');
        EcritureReference(TaImmo_Clo2ID.AsInteger,DMImport.Piece_Import.Reference);;
        TaImmo_Clo2.next;
        end;
    except
        begin
        showmessage('Problème à l''enregistrement des OD de clôture');
        TableGereRollBack(TaImmo_Clo2);
        TableGereRollBack(DMBalance.TaBalance);
        abort;
        end;
    end;

end;


Function TDMImmo_Clo.CtrlSaisieImmos_Clo(CCourant:Tfield):TErreurSaisie;
var
RetourEnregistrement:TEnregistrementComplet;
Date:Tdatetime;
//EditDate:Tedit;
begin // initialisation des variables de retour de fonction
try
 result.CodeErreur:=0;
 result.Retour:=True;
  if TaImmo_Clo.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
    case self.Tag of
    1,
    2,
    3:begin  // si tous les écrans
           case CCourant.Index of
           3: begin // si champ n° 3 (compte)
               GestionFiltrageAideCompte('2');//on filtre aideCompte
                 if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
                   Begin
                      result.CodeErreur:=3100;  //Compte vide
                      result.Retour:=False;
                   End
                 else
                   Begin//si compte valide regarder s'il possède des paramètres TVA
                     RetourEnregistrement:=DmPlanRecupEnregistrementComplet(CCourant.AsString);
                     if RetourEnregistrement.CodeRetour then
                        begin//si le compte a été trouvé
                           if empty(RetourEnregistrement.TvaCode)then
                             TaImmo_Clo.Fields[8].ReadOnly:=true;
                        end;
                   End;
               end;//fin champ3
           5: begin // si champ (désignation)
               If Empty(CCourant.AsString) then
                Begin // si champ vide
                if DMPlan.CompteExistePCU(TaImmo_CloCOMPTE.asstring) then
                  if not (empty(DMPlan.LibelleDuNumCptPCU(TaImmo_CloCOMPTE.asstring))) then
                  ccourant.AsString:=DMPlan.LibelleDuNumCptPCU(TaImmo_CloCOMPTE.asstring) +inttostr(TaImmo_Clo.RecordCount)
                  else
                  begin
                  result.CodeErreur:=5100;
                  result.Retour:=False;
                  Application.Messagebox(Pchar('La saisie de la désignation est obligatoire !!!'),'Erreur de saisie',0);
                  end;
                end;//fin champ vide
               end;//fin champ4
           7: begin // si champ n° 6 (Montant HT)
               if Empty(CCourant.AsString)or (CCourant.AsFloat =0) then
                  Begin // si champ vide
                  result.CodeErreur:=7100;
                  result.Retour:=False;
                  Application.Messagebox(Pchar('La saisie du Montant de l''immobilisation est obligatoire !!!'),'Erreur de saisie',0);
                  end; //fin champ vide
               end;//fin champ 6
            8: begin  // si champ n° 8 (Montant tva)
                 //voir traitement de la TVA s'il en faut
                   if self.Tag =3 then
                   begin//si self.tag=3 (si production immobilisée)
                   //regarder si le champ n'est readonly
                   if (ccourant.ReadOnly=false) then
                     begin
                        If Empty(CCourant.AsString) then
                        Begin // si champ n°5 vide et pas en lecture seule
                        cCourant.AsString:='0';
                        end;//fin si champ n°5 vide et pas en lecture seule
                        If not(Empty(CCourant.AsString))and (CCourant.Asfloat<>0) then
                        Begin // si champ n°5 pas vide
                        // vérifie la cohérence du montant tva saisie avec le montant calculé en fonction
                        // des taux récupérés. si incohérent,envoie message et AideMontantTTC
                        VerifTVA;
                        end;//fin si champ n°5 pas vide
                     end;
                   end;//fin si self.tag=3 (si production immobilisée)
               end;//fin champ 8
            9: begin  // si champ n° 9 (Date)
               if not empty(CCourant.asstring)then
                  begin //si la date est remplie
                    if not DateValide(CCourant.asstring)then
                      Begin //si la date n'est pas valide
                        //déclencher le popupdate
                        showmessage('Cette date n''est pas correcte.');
                        result.CodeErreur:=9101;//date pas valide
                        result.Retour:=false;
                      End;//fin si la date n'est pas valide
                  end //fin si la date est remplie
               else
                  Begin //si la date est vide
                    //déclencher le popupdate
                        showmessage('Vous devez saisir une date.');
                        result.CodeErreur:=9102;//date vide
                        result.Retour:=false;
                  End;//fin si la date est vide
               if result.retour then
                  begin
                  if ((CCourant.AsDateTime<e.DatExoDebut)or(CCourant.AsDateTime>e.DatExofin)) then
                    Begin
                      showmessage('La date doit faire partie de l''exercice courant.');
                      result.CodeErreur:=9103;
                      result.Retour:=false;
                    End;
                  end;
               end;//fin champ 9
           end;//fin du case index
       end; // fin du case suivant ecran
  end; //fin de l'état insertion ou modification
end;
finally
//
end;//fin du try finally
end;

procedure TDMImmo_Clo.DemandeAffichageReprise(caption:string);
begin
DMPieces.AffichageFeuilleReprise(0,CreationListeOD,nil,'Reprise des Immobilisation','','',false);
end;


procedure TDMImmo_Clo.FiltrageAffichageGrille(Tag_bis:integer;Cpt:string);
begin
TaImmo_Clo.Filtered:=false;
TaImmo_Clo.Filter:='';
TaImmo_Clo.Filter :='type_Immo ='''+inttostr(Tag_bis)+'''and contrepartie='''+Cpt+'''';
TaImmo_Clo.Filtered:=true;
end;

function TDMImmo_Clo.FiltrageReference(typeImmo:integer):boolean;
begin
  try
    TaImmo_Clo.Filtered := False;
    TaImmo_Clo.Filter := ('Reference_OP<> ''''and type_Immo='''+inttostr(TypeImmo)+'''');
    TaImmo_Clo.Filtered := True;
    result:=TaImmo_Clo.RecordCount<>0;
  except
    result:=false;
  end;//fin du try finally
end;


procedure TDMImmo_Clo.TaImmo_CloAfterDelete(DataSet: TDataSet);
begin
if TaImmo_Clo.Database.InTransaction then
   TableGereCommit(TaImmo_Clo);
   TableGereCommit(DMBalance.TaBalance);
end;

procedure TDMImmo_Clo.TaImmo_CloAfterPost(DataSet: TDataSet);
begin
   TableGereCommit(DataSet);
   TableGereCommit(DMBalance.TaBalance);
  compteTmp:=TaImmo_CloCompte.AsString;
  MontantTmp := TaImmo_CloMontant.AsCurrency;
  MontantTVATmp := TaImmo_CloTVA.AsCurrency;
  DesignationTmp := TaImmo_CloDesignation.AsString;
end;


procedure TDMImmo_Clo.TaImmo_CloBeforeDelete(DataSet: TDataSet);
begin
OD:='';
compte:='';
compte:=TaImmo_CloCompte.AsString;
//montantBilan:=TaProvisionMtBilanOuverture.AsCurrency;
OD:=TaImmo_CloReference_OP.AsString;

//si charge n'a pas de référence
    if TaImmo_CloReference_OP.AsString='' then
    begin
         if MessageDlg('Êtes-vous sûr de vouloir supprimer cette immobilisation ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
         abort;
    end//fin charge n'a pas de référence
    else //si charge a une référence
     begin
          If Messagedlg('Attention, La suppression de cette immobilisation entraînera la suppression de l''OD et la mise à jour de la balance !!!'+
          #10#13+'Confirmez la suppression de cette provision à répartir ?',mtconfirmation,[mbyes,mbno],0) = mrno Then
           abort;
     end;//fin charge a une référence
TableGereStartTransaction(DataSet);
 try
 if TaImmo_CloReference_OP.AsString<>'' then //si charge a une référence
      DMPieces.SuppressionOD(TaImmo_CloReference_OP.AsString);
 except
    begin
        TableGereRollBack(DataSet);
        TableGereRollBack(DMBalance.TaBalance);
    showmessage('Problème à la suppression de l''OD ');
    abort;
    end;
 end;
end;

procedure TDMImmo_Clo.TaImmo_CloBeforeEdit(DataSet: TDataSet);
begin
  compteTmp:=TaImmo_CloCompte.AsString;
  MontantTmp := TaImmo_CloMontant.AsCurrency;
  MontantTVATmp := TaImmo_CloTVA.AsCurrency;
  DesignationTmp := TaImmo_CloDesignation.AsString;
  
end;


procedure TDMImmo_Clo.TaImmo_CloBeforePost(DataSet: TDataSet);
var
I:integer;
RetourFonction:TErreurSaisie;
begin
EtatTable:=TaImmo_Clo.State;
  case TaImmo_Clo.State of
  dsInsert: begin
             TaImmo_CloID.AsInteger := MaxId_Query(TaImmo_Clo,'ID');
             TaImmo_CloContrepartie.asstring:=DMImmo_Clo.Contrepartie;
             TaImmo_CloType_Immo.asinteger:=self.tag;
            // TaImmo_CloDate.AsDateTime := E.DatExoDebut;
            end;// fin de l'état insertion
  dsEdit: begin // etat modification
//            TaImmo_CloDate.AsDateTime := Now;
          end; //fin de modification
  end;//fin du case

  //début de la boucle de vérification des saisies
  for I:=0 to 9 do //vérification du champ 2 à 4
     begin
     RetourFonction:=CtrlSaisieImmos_Clo(TaImmo_Clo.Fields[I]);
       if  RetourFonction.Retour=false then
           case  RetourFonction.CodeErreur of
               3100,5100,7100,9101,9102,9103:
                 begin // erreur de saisie, resaisir
                 DataSet.Fields[i].FocusControl;
                 abort;
                 end;
           end;//fin du case
     end; //fin boucle
TableGereStartTransaction(TaImmo_Clo);
   try
      if TaImmo_Clo.State=dsedit then //si modif
      AfterEnregistrementModif;
   except
        TableGereRollBack(dataset);
        TableGereRollBack(DMBalance.TaBalance);
   showmessage('Problème à l''enregistrement de l''immobilisation !!!');
   abort;
   end;//fin du try


end;

procedure TDMImmo_Clo.TaImmo_CloDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;


procedure TDMImmo_Clo.TaImmo_CloPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;




function TDMImmo_Clo.FiltragePourCreationOD(dataset:Tdataset;TypeImmo:integer):Boolean;
Begin
result:=false;
if not dataset.active then
  dataset.Open;
dataset.Filtered := False;
dataset.Filter := ('Reference_OP=''''and type_Immo='''+inttostr(TypeImmo)+'''');
dataset.Filtered := True;
if dataset.RecordCount<>0 then
  result:=true;
End;



function InitialisationDesImmosApresChangementExercice:boolean;
var
amortissement:TAmortImmo;
Choix:Tchoix;
InfosGestDossier:TInfosGestDossier;
RepriseDeduc:currency;
//ChangementExo:TChangtExo;
Begin
try
result:=true;
RepriseDeduc:=0;
if DMImmo_Clo=nil then DMImmo_Clo:=TDMImmo_Clo.Create(application.MainForm);
if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(application.MainForm);

DMImmo_Clo.TaImmos_ChangementExo.Open;
DMImmo_Clo.TaImmos_ChangementExo.First;
//TableGereStartTransaction(DMImmo_Clo.TaImmos_ChangementExo);
while not DMImmo_Clo.TaImmos_ChangementExo.eof do
  begin
  TableGereEdit(DMImmo_Clo.TaImmos_ChangementExo);
  RepriseDeduc:=DataModuleImmos.CalculRepriseDeduction(DMImmo_Clo.TaImmos_ChangementExo);
//  initialiserChoix(Choix);
  //calcul le nouveau report
//  initialiserAmortissement(amortissement);
  //remplissage du record avec dataset
//  Remplit_TInfosImmos(DMImmo_Clo.TaImmos_ChangementExo,ImmosEnCours);
//  amortissement:=DataModuleImmos.CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix);
//  amortissement.Choix:=DMImmo_Clo.TaImmos_ChangementExo.findfield('Choix').AsCurrency;
//  DataModuleImmos.CalculEcoRepartitionSurImmos(amortissement);
//  DataModuleImmos.CalculDerogSurImmos(amortissement);

  DMImmo_Clo.TaImmos_ChangementExoReprise_deduc_invest.AsCurrency:=DMImmo_Clo.TaImmos_ChangementExoReprise_deduc_invest.AsCurrency+RepriseDeduc;
  DMImmo_Clo.TaImmos_ChangementExoAmort_Eco.AsCurrency:=DMImmo_Clo.TaImmos_ChangementExoAmort_Eco.AsCurrency+DMImmo_Clo.TaImmos_ChangementExoEco.AsCurrency;
//  DMImmo_Clo.TaImmos_ChangementExoAmort_Derog.AsCurrency:=DMImmo_Clo.TaImmos_ChangementExoAmort_Derog.AsCurrency+amortissement.Derog;
  DMImmo_Clo.TaImmos_ChangementExoAmort_Derog.AsCurrency:=DMImmo_Clo.TaImmos_ChangementExoAmort_Derog.AsCurrency+(DMImmo_Clo.TaImmos_ChangementExoChoix.AsCurrency-DMImmo_Clo.TaImmos_ChangementExoEco.AsCurrency);

  DMImmo_Clo.TaImmos_ChangementExoMini.AsCurrency:=0;
  DMImmo_Clo.TaImmos_ChangementExoMaxi.AsCurrency:=0;
  DMImmo_Clo.TaImmos_ChangementExoChoix.AsCurrency:=0;
  DMImmo_Clo.TaImmos_ChangementExoEco.AsCurrency:=0;

//  //calcul du nouvel amortissement
//  initialiserAmortissement(amortissement);
//
//  amortissement:=DataModuleImmos.CalculerAmortAnneeSurImmo(DataModuleImmos.TaCalculAmort,DataModuleImmos.QuCalculAmortID.AsInteger,e.DatExoDebut,e.DatExoFin);

  //reinitialiser certains champs
  DMImmo_Clo.TaImmos_ChangementExoAchat_dans_Annee.AsBoolean:=false;
  DMImmo_Clo.TaImmos_ChangementExoCession_dans_Annee.AsBoolean:=false;

  TableGerePost(DMImmo_Clo.TaImmos_ChangementExo);
  DMImmo_Clo.TaImmos_ChangementExo.next;
//  TableGereCommit(DMImmo_Clo.TaImmos_ChangementExo);
  end;
  if DataModuleImmos.taDetailImmo.active then DataModuleImmos.taDetailImmo.Refresh;
  DMImmo_Clo.TaImmos_ChangementExo.First;

  //récupérer l'id dos et id exo de N+1
  InfosGestDossier:=ChercheInfos_ExoN1(e.NomDossier);
//  ChangementExo:=GestDossierInfosExoN1;
//  TableGereCommit(DMImmo_Clo.TaImmos_ChangementExo);
  if not DataModuleImmos.RecalculGeneralAmortissement(DMImmo_Clo.TaImmos_ChangementExo,false,InfosGestDossier.DATE_DEB_EXO,InfosGestDossier.DATE_FIN_EXO) then
     abort;
//  TableGereCommit(DMImmo_Clo.TaImmos_ChangementExo);
except
  result:=false;
  TableGereRollBack(DMImmo_Clo.TaImmos_ChangementExo);
  abort;
end;
end;


procedure TDMImmo_Clo.FiltragesAideCompte(Famille:integer);
var
ListeCpt:TStringList;
begin
 ListeCpt:=TStringList.Create;
 case famille of
    11,21: ListeCpt := DMPlan.FiltrageParamCPT(38,e.Regime);  //ListeCpt.Add('23*');
    12: ListeCpt := DMPlan.FiltrageParamCPT(39,e.Regime);//ListeCpt.Add('6*');
    22,32: ListeCpt := DMPlan.FiltrageParamCPT(41,e.Regime);//ListeCpt.Add('2*');
    31: ListeCpt := DMPlan.FiltrageParamCPT(40,e.Regime);//ListeCpt.Add('72*');
 end;//fin du case famille

 AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
// AideCompte.InitialiseCompte;
 ListeCpt.Free;
end;



procedure TDMImmo_Clo.GestionFiltrageAideCompte(ObjetAppelant:string);
begin
   FiltragesAideCompte(StrToInt_Lgr(inttostr(self.Tag)+ObjetAppelant));
end;


procedure TDMImmo_Clo.VerifTVA;
var
RetourTva:TRecupMiniMaxTva;
resultat:TAideMontantTTC2RetFunction;
RetourEnregistrement:TEnregistrementComplet;
Tva:currency;
Recuperer:boolean;
begin//si champ TVA rempli
Recuperer:=true;
resultat.Retour:=true;
   //Récupère tous les paramètres d'un compte
   RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaImmo_CloContrepartie.AsString);
   if RetourEnregistrement.CodeRetour then
      begin//si le compte a été trouvé
         if not(empty(RetourEnregistrement.TvaCode))then
         begin //si il y a un code tva
         //récupère les paramètre du codeTva trouvé dans les paramètre du compte
         RetourTva:=FTvaRecupMiniMaxTva(RetourEnregistrement.TvaCode);
         case retourtva.CodeRetour of  //vérifie que la tva saisie rentre dans la fourchette
         //des calculs fais à partir des taux récupérés
         1:begin //le calcul porte sur 1 seul taux (Taux_Inf)
             if calcultva(retourtva.Taux_Inf,0,TaImmo_CloMontant.AsCurrency,0,13).TVA<>TaImmo_CloTVA.AsCurrency then
             begin
             Messagedlg('Le taux de TVA est incohérent !!!',MtWarning,[mbok],0);
             resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaImmo_CloMontant.AsCurrency,TaImmo_CloTVA.AsCurrency],4,True,[TaImmo_CloTVA],[4],E.DeviseSigle[1]);
             end
             else
             Recuperer:=false;
           end;
         2:begin //le calcul porte sur 1 seul taux (Taux_Supp)
             if calcultva(retourtva.Taux_Supp,0,TaImmo_CloMontant.AsCurrency,0,13).TVA<>TaImmo_CloTVA.AsCurrency then
             begin
             Messagedlg('Le taux de TVA est incohérent !!!',MtWarning,[mbok],0);
             resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,TaImmo_CloMontant.AsCurrency,TaImmo_CloTVA.AsCurrency],4,True,[TaImmo_CloTVA],[4],E.DeviseSigle[1]);
//                       resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,TaChAPayerTVA.AsFloat]);
             end
             else
             Recuperer:=false;
           end;
        12:begin //le calcul porte sur 2 taux (Taux_Inf et taux_Supp)
             if (calcultva(retourtva.Taux_Inf,0,TaImmo_CloMontant.AsCurrency,0,13).TVA>TaImmo_CloTVA.AsCurrency)or
              (calcultva(retourtva.Taux_Supp,0,TaImmo_CloMontant.AsCurrency,0,13).TVA<TaImmo_CloTVA.AsCurrency)then
             begin
             Messagedlg('Le taux de TVA est incohérent !!!',MtWarning,[mbok],0);
             resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaImmo_CloMontant.AsCurrency,TaImmo_CloTVA.AsCurrency,retourtva.Taux_Supp,0,TaImmo_CloMontant.AsCurrency,TaImmo_CloTVA.AsCurrency],4,True,[TaImmo_CloTVA],[4],E.DeviseSigle[1]);
//                       resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,TaChAPayerTVA.AsFloat,retourtva.Taux_Supp,0,DMChargeAPayer.TaChAPayerMontantHT.AsCurrency,DMChargeAPayer.TaChAPayerTVA.AsFloat]);
             end
             else
             Recuperer:=false;
           end;
         end;//fin du case retourTva

         /////Si erreur de saisie rencontrée et nouveaux montants tva récupérés
         if (Recuperer) and (resultat.Retour) then
         begin
            TaImmo_Clo.Fields[7].AsCurrency:=resultat.HT;
            TaImmo_Clo.Fields[8].AsCurrency:=resultat.TVA;
             case retourtva.CodeRetour of
            1:begin
                if calcultva(retourtva.Taux_Inf,0,TaImmo_CloMontant.AsCurrency,0,13).TVA>TaImmo_CloTVA.AsFloat then
                  if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                  abort;
              end;
            2:begin
                if calcultva(retourtva.Taux_Supp,0,TaImmo_CloMontant.AsCurrency,0,13).TVA<TaImmo_CloTVA.AsFloat then
                if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                  abort;                     end;
           12:begin
                if (calcultva(retourtva.Taux_Inf,0,TaImmo_CloMontant.AsCurrency,0,13).TVA>TaImmo_CloTVA.AsFloat)or
                 (calcultva(retourtva.Taux_Supp,0,TaImmo_CloMontant.AsCurrency,0,13).TVA<TaImmo_CloTVA.AsFloat)then
                if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                  abort;
              end;
            end;//fin du case retourTva
         end
         else
         if resultat.Retour=false then
          if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre choix',MtWarning,[mbyes,mbno],0)=mrno then
            abort;
         end;
      end;//fin si le compte a été trouvé
end;


procedure TDMImmo_Clo.TaImmo_CloBeforeInsert(DataSet: TDataSet);
begin
dataset.Fields[3].focuscontrol;
end;


function TDMImmo_Clo.CompareSoldeCompteImmo_CompteComptable(DataImmo:Tdataset;DateDebut,DateFin:Tdatetime):Tlist;
var
CompteComptable:string;
SoldeComptable:TTotauxBalance;
SoldeImmo:currency;
Amort_Derog_Cumul,Eco:currency;
ListErreur:PListErreur;
ListeCompte:Tstringlist;
compte,reference:string;
SensTemp:boolean;
Amort:TAmortImmo;
Derog:TCalcul;
Begin
try
ListeCompte:=TStringList.Create;
if DataImmo<>nil then
  begin
    DataImmo.close;
    DataImmo.Open;
  end
  else
  abort;
Amort_Derog_Cumul:=0;
DataImmo.First;
result:=TList.Create;
ListeCompte.Duplicates:=dupIgnore;
while not DataImmo.EOF do
  Begin
    CompteComptable:='';
    ListeCompte.Clear;
    compte:=DataImmo.findfield('Compte').asstring;
    ListeCompte.Add(compte);
    //Vérifier si solde du compte immo = soldefin du même compte comptable
      SoldeComptable:=DMDiocEtatBal.SommeTotauxBalanceCalc(DateDebut,DateFin,ListeCompte,'Compte');
      if copy(compte,1,1)='2'then
        SoldeImmo:=-DataImmo.findfield('Valeur_a_amortir').ascurrency
      else
        SoldeImmo:=DataImmo.findfield('Valeur_a_amortir').ascurrency;
      SensTemp:=SoldeImmo<0;
      if ((abs(SoldeImmo)<>SoldeComptable.SoldeFin)or(SensTemp<>SoldeComptable.SoldeDebitCreditFin)) then
        Begin
          //répertorier le problème
          new(ListErreur);
          ListErreur.Erreur.CodeErreur:=0;
          ListErreur.Erreur.retour:=false;
          ListErreur.CompteImmo:=DataImmo.findfield('Compte').asstring;
          ListErreur.ComptePlan:=ListeCompte[0];
          ListErreur.SoldeImmo:=DataImmo.findfield('Valeur_a_amortir').ascurrency;
          ListErreur.SoldePlan:=SoldeComptable.SoldeFin;
          ListErreur.messages:='Il y a une différence entre le solde de la valeur à amortir du compte '+ListErreur.CompteImmo+' et celle du même compte dans la balance.';
          result.Add(ListErreur);
        End;
    //vérifier si solde de l'amortissement eco pour ce compte = soldefin du compte
    //de dotation généré pour ce même compte
      CompteComptable:=RecupCompteDotationSurCompteImmo(100,DataImmo.findfield('Compte').asstring).CompteAmort;
      if not empty(CompteComptable) then
        begin //si on trouve un compte de dotation pour le compte immo
          ListeCompte.Clear;
          ListeCompte.Add(CompteComptable);
          Eco:=DataImmo.findfield('Eco').ascurrency;
          SoldeComptable:=DMDiocEtatBal.SommeTotauxBalanceCalc(DateDebut,DateFin,ListeCompte,'Compte');
          if copy(Compte,1,1)='2'then
            SoldeImmo:=(DataImmo.findfield('amort_eco').ascurrency+Eco)
          else
            SoldeImmo:=-(DataImmo.findfield('amort_eco').ascurrency+Eco);
          SensTemp:=SoldeImmo<0;
            if ((abs(SoldeImmo)<>SoldeComptable.SoldeFin)or(SensTemp<>SoldeComptable.SoldeDebitCreditFin)) then
              Begin
               //répertorier le problème
               new(ListErreur);
               ListErreur.Erreur.CodeErreur:=0;
               ListErreur.Erreur.retour:=false;
               ListErreur.CompteImmo:=DataImmo.findfield('Compte').asstring;
               ListErreur.ComptePlan:=ListeCompte[0];
               ListErreur.SoldeImmo:=(DataImmo.findfield('amort_eco').ascurrency+DataImmo.findfield('Eco').ascurrency);
               ListErreur.SoldePlan:=SoldeComptable.SoldeFin;
               ListErreur.messages:='Il y a une différence entre le solde de l''amortissement economique du compte '+ListErreur.CompteImmo+' et celle du compte '+ListErreur.ComptePlan+' dans la balance.';
               result.Add(ListErreur);
              End;
        end;
      //calculer derog pour l'immo
//      Amort.Choix:=DataImmo.findfield('choix').ascurrency;
//      amort.Gerer_Derog:=e.Derogatoire;
//      amort.Report_Derog:=DataImmo.findfield('amort_Derog').ascurrency;
//      amort.EcoRepartition:=DataImmo.findfield('Eco').ascurrency;
//      amort.report:=DataImmo.findfield('amort_Eco').ascurrency+DataImmo.findfield('amort_Derog').ascurrency;
//      Derog:=DataModuleImmos.CalculDerogSurImmos(amort);
      Derog.Total:=DataImmo.findfield('Derog').ascurrency;
      if copy(compte,1,1)='2'then
        Amort_Derog_Cumul:=Amort_Derog_Cumul+(DataImmo.findfield('amort_Derog').ascurrency+Derog.Total)
      else
        Amort_Derog_Cumul:=Amort_Derog_Cumul-(DataImmo.findfield('amort_Derog').ascurrency+Derog.Total);
      DataImmo.next;
  End; //fin du while
    //vérifier si solde de l'amortissement dérog pour tous les comptes d'immos amortissable = soldefin du compte 145
  ListeCompte.Clear;
  ListeCompte.Add(DM_C_CompteAmortDerogatoire);
  SoldeComptable:=DMDiocEtatBal.SommeTotauxBalanceCalc(DateDebut,DateFin,ListeCompte,'Compte');
  SensTemp:=Amort_Derog_Cumul<0;
  if ((abs(Amort_Derog_Cumul)<>SoldeComptable.SoldeFin)or(SensTemp<>SoldeComptable.SoldeDebitCreditFin)) then
    Begin
      //répertorier le problème
      new(ListErreur);
      ListErreur.Erreur.CodeErreur:=0;
      ListErreur.Erreur.retour:=false;
      ListErreur.CompteImmo:='Toutes les immos amortissables';
      ListErreur.ComptePlan:=ListeCompte[0];
      ListErreur.SoldeImmo:=Amort_Derog_Cumul;
      ListErreur.SoldePlan:=SoldeComptable.SoldeFin;
      ListErreur.messages:='Il y a une différence entre le solde de l''amortissement economique de '+ListErreur.CompteImmo+' et celle du compte '+ListErreur.ComptePlan+' dans la balance.';
      result.Add(ListErreur);
    End;
finally
ListeCompte.Free;
end;//fin du try finally
End;



function RecupCompteDotationSurCompteImmo(Famille:integer;compte:string):TCompteAmortissement;
begin
result:=DMPlan.FiltrageParamCPTSurComptePourDotation(100,compte,e.Regime);
end;



function VerifGestionImmo_AvantCloture(DateDebut,DateFin:Tdatetime):TerreurCloture;
var
reference:string;
Begin
result.erreur.CodeErreur:=0;
result.erreur.retour:=true;
if DMImmo_Clo=nil then DMImmo_Clo:=TDMImmo_Clo.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
DeFiltrageDataSet(dmrech.TaImmosRech);
    //récup des immos encore valides avec piece de dotation et compte soldés
  if VerificationSiPieceDeDotation(reference)then
     begin
       reference:='';
       DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.close;
       DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.ParamByName('DateDebutExo').AsDateTime:=DateDebut;
       DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.open;
       //à partir de cette requete, comparer tous les soldes d'immos par rapport
       //à ceux de la compta
       Result.ListErreur:=DMImmo_Clo.CompareSoldeCompteImmo_CompteComptable(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession,DateDebut,DateFin);
       if Result.ListErreur<>nil then
         erreurClotureImmo:=Result.ListErreur;
       if (Result.ListErreur.Count<>0) then
         Begin //si erreur dans comparaison
           result.messages.MessageErreur:='La pièce de dotation est passée mais il y a des différences entre la gestion des immobilisations et les traitements comptables, vous devez vérifier si vous n''avez pas effectué d''écriture comptable manuellement sur des comptes d''amortissement !';
           result.TitreBouton:='Vérification des comptes d''immobilisations';
           result.erreur.CodeErreur:=2;//différences avec pièce de dotation existante;
           result.erreur.retour:=false;
         end
       else
         begin
           result.messages.MessageErreur:='La pièce de dotation a été passée par le programme !';
           result.erreur.CodeErreur:=4;//pas d'erreur avec pièce de dotation existante;
           result.TitreBouton:='';
           result.erreur.retour:=true;
         end;
     end
  else
     Begin
     //récup des immos encore valides sans piece de dotation donc pas de comptes soldés
       reference:='';
       DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.close;
       DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.ParamByName('DateDebutExo').AsDateTime:=DateDebut;
       DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.open;
       //à partir de cette requete, comparer tous les soldes d'immos par rapport
       //à ceux de la compta
       Result.ListErreur:=DMImmo_Clo.CompareSoldeCompteImmo_CompteComptable(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession,DateDebut,DateFin);
       if Result.ListErreur<>nil then
         erreurClotureImmo:=Result.ListErreur;
       if (Result.ListErreur.Count<>0) then
         Begin //si erreur dans comparaison
           result.messages.MessageErreur:='Vous n''avez pas passé la pièce de dotation et il y a des différences entre la gestion et les traitements comptables des immobilisations !';
           result.TitreBouton:='Vérification des comptes d''immobilisations ou création de la pièce de dotation';
           result.erreur.CodeErreur:=6;//différences sans pièce de dotation;
           result.erreur.retour:=false;
         end
       else
         begin
           if dmrech.TaImmosRech.RecordCount=0 then
             result.messages.MessageErreur:=''
           else
             result.messages.MessageErreur:='la pièce de dotation n''a pas été passée, mais il n''y a pas de différence entre la gestion et les traitements comptables des immobilisations, cela laisse supposer que vous avez passée la pièce de dotation manuellement !';
           result.erreur.CodeErreur:=5;//pas d'erreur avec supposition que la pièce de dotation est été passée manuellement;
           result.TitreBouton:='';
           result.erreur.retour:=true;
         end;
     End;
End;

//////////A vérifier dans tous les sens, remis le  { isa  le  14/02/05 } /////
/////////////////////////////////////////////////////////////////////////////////////
function TDMImmo_Clo.GenererPieceDotation(var reference:string;VerifPiece:boolean):TResultStrList;
var
//Q:TQuery;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang,i:integer;
ValPieceAutoGen:TValPieceAutoGenere;
compteComptable1,compteComptable2:TCompteAmortissement;
ListOD:TStringList;
CumulDerogDebit,CumulDerogCredit,Cumule,Valeurnette:currency;
Tab:variant;
compte_A_Solder:string;
erreur:TerreurCloture;
ExecProcedure:TProcedure;
Begin
  try
       if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.create(application.MainForm);
       if DMImmo_Clo=nil then DMImmo_Clo:=TDMImmo_Clo.Create(application.MainForm);
       ListOD:=TStringList.Create;
       result.Liste:=TStringList.Create;
       result.Result:=true;
       if ((VerificationSiPieceDeDotation(reference))and(not VerifPiece)) then
         begin
             if MessageDlg('La pièce de dotation existe déjà sous la référence : '+#13+#10+reference+'.'+#13+#10+#13+#10+'voulez-vous la visualiser ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
               ListOd.Add(reference);
         end
       else
         begin
             if verifPiece then
               Begin
    DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.close;
    DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.close;
    DMImmo_Clo.QuImmo_Cede_Dans_Annee.close;
    DMImmo_Clo.QuAmortDerogDebit_SiDerog.close;
    DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.close;
    DMImmo_Clo.QuAmortDerogCredit_SiDerog.close;
    DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.close;
    DMImmo_Clo.QuEcoSiDerog.close;
                  DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.SQL.Text,'Immos','ImmosTmp');
                  DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.SQL.Text,'Immos','ImmosTmp');
                  DMImmo_Clo.QuImmo_Cede_Dans_Annee.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuImmo_Cede_Dans_Annee.SQL.Text,'immos','ImmosTmp');
                  DMImmo_Clo.QuAmortDerogDebit_SiDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuAmortDerogDebit_SiDerog.SQL.Text,'immos','ImmosTmp');
                  DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.SQL.Text,'immos','ImmosTmp');
                  DMImmo_Clo.QuAmortDerogCredit_SiDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuAmortDerogCredit_SiDerog.SQL.Text,'immos','ImmosTmp');
                  DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.SQL.Text,'immos','ImmosTmp');
                  DMImmo_Clo.QuEcoSiDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuEcoSiDerog.SQL.Text,'immos','ImmosTmp');
               end;
             listeFactice:=nil;
             CorrectionImmos_Initialisation(false);
             //à partir d'une selection des immos encore valides et amortissables
             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.close;
             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.ParamByName('DateDebutExo').AsDateTime:=e.DatExoDebut;
//             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.OnFilterRecord:=QuVerifImmoAmortissableAvantClot_avecCessionFilterRecord;
//             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.Filtered:=true;
             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.open;
             if DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.recordcount=0 then
                  raise ExceptLGR.Create('',0,false,mtError);
           try
             DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
             ValPieceAutoGen:=ValAutoPieceGenere(DataModuleImmos.taDetailImmo);
             SourcePiece.IDJournal:=3;
             SourcePiece.Date:=e.DatExoFin;
             SourcePiece.Validation:=SourcePiece.Date;
             SourcePiece.Libelle:='Piece de dotation aux amortissements';
             SourcePiece.Compte:='';
             SourcePiece.Journal:='OD';
             SourcePiece.Reference:=reference;
       DMImport.VerifCreationPieceEcriture;
             DMImport.Piece_Import.NouvellePiece(false);

             if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
             DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
             rang:=1;
                          //remplissage ligne vide
             DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);


           CumulDerogDebit:=0;
           CumulDerogCredit:=0;
          //récupérer pour chaque compte l'amortissement economique
          //récupérer ensuite le compte de dotation équivalent et le compte d'amortissement
           while not DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.EOF do
             Begin
              if arrondi(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,2)<>0 then
                begin//si Eco <> de 0
                  compteComptable1:=RecupCompteDotationSurCompteImmo(100,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString);
                  if e.Derogatoire then
                    begin//si derogatoire géré
                      if copy(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,1,1)='2'then
                        begin//si compte commence par '2*'
                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amortissements '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,0,'','',0,'',''],true,false,-1);
                         //ListeEdit.Add(compteComptable1.CompteAmort+';'+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency);
                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.compteDotation,'','Dotations '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,0,'','',0,'',''],true,false,-1);
                         //ListeEdit.Add(compteComptable1.compteDotation+';'+-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency);
                        end//fin si compte commence par '2*'
                      else
                        begin//si compte commence par '13*'
                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amortissements '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,0,'','',0,'',''],true,false,-1);
                         //ListeEdit.Add(compteComptable1.CompteAmort+';'+-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency);
                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.compteDotation,'','Dotations '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,0,'','',0,'',''],true,false,-1);
                         //ListeEdit.Add(compteComptable1.compteDotation+';'+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency);
                        end;//fin si compte commence par '13*'
                      CumulDerogDebit:=CumulDerogDebit+abs(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('DerogDebit').AsCurrency);
                      CumulDerogCredit:=CumulDerogCredit+abs(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('DerogCredit').AsCurrency);
                    end// fin si derogatoire géré
                  else
                    Begin //si derogatoire non géré
                      if copy(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,1,1)='2'then
                        begin
                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amortissements '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency,0,'','',0,'',''],true,false,-1);
                         //ListeEdit.Add(compteComptable1.CompteAmort+';'+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency);
                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.compteDotation,'','Dotations '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency,0,'','',0,'',''],true,false,-1);
                         //ListeEdit.Add(compteComptable1.compteDotation+';'+-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency);
                        end
                      else
                        begin
                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amortissements '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency,0,'','',0,'',''],true,false,-1);
                         //ListeEdit.Add(compteComptable1.CompteAmort+';'+(-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency));
                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.compteDotation,'','Dotations '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency,0,'','',0,'',''],true,false,-1);
                         //ListeEdit.Add(compteComptable1.compteDotation+';'+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency);
                        end;
                      CumulDerogDebit:=CumulDerogDebit+abs(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('DerogDebit').AsCurrency);
                      CumulDerogCredit:=CumulDerogCredit+abs(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('DerogCredit').AsCurrency);
                    End;//fin si derogatoire non géré
                compteComptable2:=RecupCompteDotationSurCompteImmo(100,DM_C_CompteAmortDerogatoire);
          //ecriture au débit
    //          if e.Derogatoire then
    //            begin
                  if arrondi(CumulDerogDebit,2)<>0 then
                    begin
                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DM_C_CompteAmortDerogatoire,'','Amort. dérogatoire '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-CumulDerogDebit,0,'','',0,'',''],true,false,-1);
                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable2.CompteAmort,'','Reprises '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,CumulDerogDebit,0,'','',0,'',''],true,false,-1);
                     end;
           //ecriture au crédit
                  if arrondi(CumulDerogCredit,2)<>0 then
                     begin
                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DM_C_CompteAmortDerogatoire,'','Amort. dérogatoire '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,CumulDerogCredit,0,'','',0,'',''],true,false,-1);
                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable2.compteDotation,'','Reprises '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-CumulDerogCredit,0,'','',0,'',''],true,false,-1);
                     end;
                  CumulDerogDebit:=0;
                  CumulDerogCredit:=0;
    //              end;
                end;//fin si Eco <> de 0
                DMImmo_Clo.QuImmo_Cede_Dans_Annee.Close;
                DMImmo_Clo.QuImmo_Cede_Dans_Annee.ParamByName('DateDebutExo').AsDateTime:=e.DatExoDebut;
                DMImmo_Clo.QuImmo_Cede_Dans_Annee.ParamByName('Cpt').AsString:=DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCessioncompte.AsString;
                DMImmo_Clo.QuImmo_Cede_Dans_Annee.open;
                //DMImmo_Clo.QuImmo_Cede_Dans_Annee.first;
                //while not DMImmo_Clo.QuImmo_Cede_Dans_Annee.eof do
                if DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.RecordCount<>0 then
                    begin //début du while QuImmo_Cede_Dans_Annee
                        compte_A_Solder:=RecupCompte_A_Solder_SurCompteImmo(44,DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString);
                        compteComptable1:=RecupCompteDotationSurCompteImmo(100,DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString);
                        Cumule:=(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Eco').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Eco').Ascurrency);
                        CumulDerogDebit:=0;
                        CumulDerogCredit:=0;
                        compteComptable2:=RecupCompteDotationSurCompteImmo(100,DM_C_CompteAmortDerogatoire);
                          Valeurnette:=DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Valeur_a_amortir').ascurrency-Cumule;
                          if ((not empty(compte_A_Solder))and(copy(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString,1,1)='2')) then
                            begin //si compte à solder rempli sur compte '2*'
                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString,'','Valeur Origine '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Valeur_A_Amortir').ascurrency,0,'','',0,'',''],true,false,-1);
                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amort. Cumulés '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-Cumule,0,'','',0,'',''],true,false,-1);
                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compte_A_Solder,'','Valeur nette '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-Valeurnette,0,'','',0,'',''],true,false,-1);
                            end//fin si compte à solder rempli sur compte '2*'
                          else
                          if not empty(compte_A_Solder) then
                            begin //si compte à solder rempli sur compte '13*'
                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString,'','Valeur Origine '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Valeur_A_Amortir').ascurrency,0,'','',0,'',''],true,false,-1);
                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amort. Cumulés '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,Cumule,0,'','',0,'',''],true,false,-1);
                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compte_A_Solder,'','Valeur nette '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,Valeurnette,0,'','',0,'',''],true,false,-1);
                            end;//fin si compte à solder rempli sur compte '13*'
                         if (DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency>0) or (DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency >0) then
                          begin //si dérog rempli
                          if DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency<>0 then
                            begin//si reliquat de dérog
                            if (DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency)<0then
                              Begin//si report derog + derog annee <0
                                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DM_C_CompteAmortDerogatoire,'','Reliquat Dérog. '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency),0,'','',0,'',''],true,false,-1);
                                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable2.compteDotation,'','Reliquat Dérog. '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency),0,'','',0,'',''],true,false,-1);
                              End// fin si report derog + derog annee <0
                            else
                              Begin//si report derog + derog annee >0
                                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DM_C_CompteAmortDerogatoire,'','Reliquat Dérog. '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency),0,'','',0,'',''],true,false,-1);
                                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable2.CompteAmort ,'','Reliquat Dérog. '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency),0,'','',0,'',''],true,false,-1);
                              End;//fin si report derog + derog annee >0
                            end;//fin si reliquat de dérog
                          end;//fin si dérog rempli
                    //DMImmo_Clo.QuImmo_Cede_Dans_Annee.next;
                    end;//fin du while QuImmo_Cede_Dans_Annee
                  DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.next;
               end;//fin du while QuVerifImmoAmortissableAvantClot_avecCession
                 if DMImport.Ecriture_Import.ListeEcriturePiece.count>1 then
                   begin
                       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
                       for i:=0 to DMImport.Ecriture_Import.ListeEcriturePiece.Count-1 do
                         Begin
                            if not empty(PRecordEcriture(DMImport.Ecriture_Import.ListeEcriturePiece[i])^.Compte)then
                              result.Liste.Add(PRecordEcriture(DMImport.Ecriture_Import.ListeEcriturePiece[i])^.Compte+';'+currtostr(PRecordEcriture(DMImport.Ecriture_Import.ListeEcriturePiece[i])^.MontantHt)+';')
                         end;
                        result.Liste.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceDotation.txt');
                       //Ecrire dans la pièce les infos dans TableGen,ChampGen,etc...pour reconnaître que
                       //c'est une pièce générée automatiquement
                       if not VerifPiece then
                         begin
                             DMImport.EnregistrementPiece(false,nil,ListOD,listeFactice);
                             reference:=DMImport.Piece_Import.Reference;
                         end;
                   end
                else
                 MessageDlg('Il n''y a pas d''écriture à passer pour la pièce de dotation.', mtWarning, [mbOK], 0);
             except
              showmessage('Problème à l''enregistrement de la pièce de dotation aux amortissements !');
              result.Result:=false;
              Initialise_TStringlist(result.Liste);
              abort;
             end;//fin du try except
         End;
     if ListOd.Count<>0 then
       DMPieces.AffichageFeuilleReprise(0,ListOd,nil,'Affichage de la pièce de dotation aux amortissements','','',false);
  finally
//    if ListOD<>nil then
//     begin
//      ListOD.free;
//      ListOD:=nil;
//     end;
//   Initialise_TStringlist(ListOD); //variable locale, se libere seule !!!!
//   Initialise_TStringlist(ListeEdition); //variable locale, se libere seule !!!!
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,nil,false);
   if verifPiece then
   begin
    DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.close;
    DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.close;
    DMImmo_Clo.QuImmo_Cede_Dans_Annee.close;
    DMImmo_Clo.QuAmortDerogDebit_SiDerog.close;
    DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.close;
    DMImmo_Clo.QuAmortDerogCredit_SiDerog.close;
    DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.close;
    DMImmo_Clo.QuEcoSiDerog.close;

    DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.SQL.Text,'ImmosTmp','Immos');
    DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_sansCession.SQL.Text,'ImmosTmp','Immos');
    DMImmo_Clo.QuImmo_Cede_Dans_Annee.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuImmo_Cede_Dans_Annee.SQL.Text,'ImmosTmp','Immos');
    DMImmo_Clo.QuAmortDerogDebit_SiDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuAmortDerogDebit_SiDerog.SQL.Text,'ImmosTmp','Immos');
    DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.SQL.Text,'ImmosTmp','Immos');
    DMImmo_Clo.QuAmortDerogCredit_SiDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuAmortDerogCredit_SiDerog.SQL.Text,'ImmosTmp','Immos');
    DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.SQL.Text,'ImmosTmp','Immos');
    DMImmo_Clo.QuEcoSiDerog.SQL.Text:=str_remplacesouschaine_1ereOccurence_avecCasse(DMImmo_Clo.QuEcoSiDerog.SQL.Text,'ImmosTmp','immos');
   end
   else
//   if Application.MessageBox(Pchar('Voulez-vous effectuer un contrôle entre la gestion de vos immobilisations et les soldes de votre balance'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//     begin
//         erreur:=VerifGestionImmo_AvantCloture(e.DatExoDebut,e.DatExoFin);
//         if erreur.erreur.retour=false then
//           Begin
//               if not empty(erreur.messages.MessageErreur)then
//                  Begin
//                     if Application.MessageBox(Pchar(erreur.messages.MessageErreur+RetourChariotDouble+erreur.TitreBouton),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
//                      TProcedure(DMImmo_Clo.MethodAddress('TraitementCloture'+inttostr(erreur.erreur.CodeErreur)));
//                  end;
//           end
//         else
//         showmessage('Le contrôle s''est bien déroulé.');  
//    end;
  end;//fin du try finally
End;

{ isa  le  31/01/05 }
//function TDMImmo_Clo.GenererPieceDotation(var reference:string):boolean;
//var
////Q:TQuery;
//SourceEcriture:TRecordEcriture;
//SourcePiece:TRecordPiece;
//listeFactice:Tlist;
//rang:integer;
//ValPieceAutoGen:TValPieceAutoGenere;
//compteComptable1,compteComptable2:TCompteAmortissement;
//ListOD:TStringList;
//CumulDerogDebit,CumulDerogCredit,Cumule,Valeurnette:currency;
//Tab:variant;
//compte_A_Solder:string;
//Begin
//  try
//       ListOD:=TStringList.Create;
//       if VerificationSiPieceDeDotation(reference)then
//         begin
//             if MessageDlg('La pièce de dotation existe déjà sous la référence : '+#13+#10+reference+'.'+#13+#10+#13+#10+'voulez-vous la visualiser ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
//               ListOd.Add(reference);
//         end
//       else
//         begin
//             listeFactice:=nil;
//             CorrectionImmos_Initialisation(false);
//             //à partir d'une selection des immos encore valides et amortissables
//             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.close;
//             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.ParamByName('DateDebutExo').AsDateTime:=e.DatExoDebut;
////             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.OnFilterRecord:=QuVerifImmoAmortissableAvantClot_avecCessionFilterRecord;
////             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.Filtered:=true;
//             DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.open;
//             if DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.recordcount=0 then
//                  raise ExceptLGR.Create('',0,false,mtError);
//           try
//             DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
//             ValPieceAutoGen:=ValAutoPieceGenere(DataModuleImmos.taDetailImmo);
//             SourcePiece.IDJournal:=3;
//             SourcePiece.Date:=e.DatExoFin;
//             SourcePiece.Validation:=SourcePiece.Date;
//             SourcePiece.Libelle:='Piece de dotation aux amortissements';
//             SourcePiece.Compte:='';
//             SourcePiece.Journal:='OD';
//             SourcePiece.Reference:=reference;
//       DMImport.VerifCreationPieceEcriture;
//             DMImport.Piece_Import.NouvellePiece(false);
//
//             if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
//             DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
//             rang:=1;
//                          //remplissage ligne vide
//             DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
//
//
//           CumulDerogDebit:=0;
//           CumulDerogCredit:=0;
//          //récupérer pour chaque compte l'amortissement economique
//          //récupérer ensuite le compte de dotation équivalent et le compte d'amortissement
//           while not DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.EOF do
//             Begin
//              if arrondi(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,2)<>0 then
//                begin//si Eco <> de 0
//                  compteComptable1:=RecupCompteDotationSurCompteImmo(100,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString);
//                  if e.Derogatoire then
//                    begin//si derogatoire géré
//                      if copy(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,1,1)='2'then
//                        begin//si compte commence par '2*'
//                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amortissements '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,0,'','',0,'',''],true,false,-1);
//                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.compteDotation,'','Dotations '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,0,'','',0,'',''],true,false,-1);
//                        end//fin si compte commence par '2*'
//                      else
//                        begin//si compte commence par '13*'
//                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amortissements '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,0,'','',0,'',''],true,false,-1);
//                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.compteDotation,'','Dotations '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency,0,'','',0,'',''],true,false,-1);
//                        end;//fin si compte commence par '13*'
//                      CumulDerogDebit:=CumulDerogDebit+abs(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('DerogDebit').AsCurrency);
//                      CumulDerogCredit:=CumulDerogCredit+abs(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('DerogCredit').AsCurrency);
//                    end// fin si derogatoire géré
//                  else
//                    Begin //si derogatoire non géré
//                      if copy(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,1,1)='2'then
//                        begin
//                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amortissements '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency,0,'','',0,'',''],true,false,-1);
//                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.compteDotation,'','Dotations '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency,0,'','',0,'',''],true,false,-1);
//                        end
//                      else
//                        begin
//                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amortissements '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency-DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency,0,'','',0,'',''],true,false,-1);
//                         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.compteDotation,'','Dotations '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Eco').AsCurrency+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('Derog').AsCurrency,0,'','',0,'',''],true,false,-1);
//                        end;
//                      CumulDerogDebit:=CumulDerogDebit+abs(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('DerogDebit').AsCurrency);
//                      CumulDerogCredit:=CumulDerogCredit+abs(DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('DerogCredit').AsCurrency);
//                    End;//fin si derogatoire non géré
//                compteComptable2:=RecupCompteDotationSurCompteImmo(100,DM_C_CompteAmortDerogatoire);
//          //ecriture au débit
//    //          if e.Derogatoire then
//    //            begin
//                  if arrondi(CumulDerogDebit,2)<>0 then
//                    begin
//                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DM_C_CompteAmortDerogatoire,'','Amort. dérogatoire'+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-CumulDerogDebit,0,'','',0,'',''],true,false,-1);
//                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable2.CompteAmort,'','Reprises '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,CumulDerogDebit,0,'','',0,'',''],true,false,-1);
//                     end;
//           //ecriture au crédit
//                  if arrondi(CumulDerogCredit,2)<>0 then
//                     begin
//                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DM_C_CompteAmortDerogatoire,'','Amort. dérogatoire '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,CumulDerogCredit,0,'','',0,'',''],true,false,-1);
//                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable2.compteDotation,'','Reprises '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-CumulDerogCredit,0,'','',0,'',''],true,false,-1);
//                     end;
//                  CumulDerogDebit:=0;
//                  CumulDerogCredit:=0;
//    //              end;
//                end;//fin si Eco <> de 0
//                DMImmo_Clo.QuImmo_Cede_Dans_Annee.Close;
//                DMImmo_Clo.QuImmo_Cede_Dans_Annee.ParamByName('DateDebutExo').AsDateTime:=e.DatExoDebut;
//                DMImmo_Clo.QuImmo_Cede_Dans_Annee.ParamByName('Cpt').AsString:=DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCessioncompte.AsString;
//                DMImmo_Clo.QuImmo_Cede_Dans_Annee.open;
//                //DMImmo_Clo.QuImmo_Cede_Dans_Annee.first;
//                //while not DMImmo_Clo.QuImmo_Cede_Dans_Annee.eof do
//                if DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.RecordCount<>0 then
//                    begin //début du while QuImmo_Cede_Dans_Annee
//                        compte_A_Solder:=RecupCompte_A_Solder_SurCompteImmo(44,DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString);
//                        compteComptable1:=RecupCompteDotationSurCompteImmo(100,DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString);
//                        Cumule:=(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Eco').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Eco').Ascurrency);
//                        CumulDerogDebit:=0;
//                        CumulDerogCredit:=0;
//                        compteComptable2:=RecupCompteDotationSurCompteImmo(100,DM_C_CompteAmortDerogatoire);
//                          Valeurnette:=DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Valeur_a_amortir').ascurrency-Cumule;
//                          if ((not empty(compte_A_Solder))and(copy(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString,1,1)='2')) then
//                            begin //si compte à solder rempli sur compte '2*'
//                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString,'','Valeur Origine '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Valeur_A_Amortir').ascurrency,0,'','',0,'',''],true,false,-1);
//                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amort. Cumulés '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-Cumule,0,'','',0,'',''],true,false,-1);
//                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compte_A_Solder,'','Valeur nette '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-Valeurnette,0,'','',0,'',''],true,false,-1);
//                            end//fin si compte à solder rempli sur compte '2*'
//                          else
//                          if not empty(compte_A_Solder) then
//                            begin //si compte à solder rempli sur compte '13*'
//                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('compte').AsString,'','Valeur Origine '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Valeur_A_Amortir').ascurrency,0,'','',0,'',''],true,false,-1);
//                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable1.CompteAmort,'','Amort. Cumulés '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,Cumule,0,'','',0,'',''],true,false,-1);
//                              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compte_A_Solder,'','Valeur nette '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,Valeurnette,0,'','',0,'',''],true,false,-1);
//                            end;//fin si compte à solder rempli sur compte '13*'
//                         if DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency>0 then
//                          begin //si dérog rempli
//                          if DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency<>0 then
//                            begin//si reliquat de dérog
//                            if (DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency)<0then
//                              Begin//si report derog + derog annee <0
//                                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DM_C_CompteAmortDerogatoire,'','Reliquat Dérog. '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency),0,'','',0,'',''],true,false,-1);
//                                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable2.compteDotation,'','Reliquat Dérog. '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency),0,'','',0,'',''],true,false,-1);
//                              End// fin si report derog + derog annee <0
//                            else
//                              Begin//si report derog + derog annee >0
//                                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DM_C_CompteAmortDerogatoire,'','Reliquat Dérog. '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,-(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency),0,'','',0,'',''],true,false,-1);
//                                 DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',compteComptable2.CompteAmort ,'','Reliquat Dérog. '+DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.findfield('compte').AsString,0,0,(DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Amort_Derog').Ascurrency+DMImmo_Clo.QuImmo_Cede_Dans_Annee.findfield('Derog').Ascurrency),0,'','',0,'',''],true,false,-1);
//                              End;//fin si report derog + derog annee >0
//                            end;//fin si reliquat de dérog
//                          end;//fin si dérog rempli
//                    //DMImmo_Clo.QuImmo_Cede_Dans_Annee.next;
//                    end;//fin du while QuImmo_Cede_Dans_Annee
//                  DMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCession.next;
//               end;//fin du while QuVerifImmoAmortissableAvantClot_avecCession
//                 if DMImport.Ecriture_Import.ListeEcriturePiece.count>1 then
//                   begin
//                       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
//                       //Ecrire dans la pièce les infos dans TableGen,ChampGen,etc...pour reconnaître que
//                       //c'est une pièce générée automatiquement
//                       DMImport.EnregistrementPiece(false,nil,ListOD,listeFactice);
//                       reference:=DMImport.Piece_Import.Reference;
//                   end
//                else
//                 MessageDlg('Il n''y a pas d''écriture à passer pour la pièce de dotation.', mtWarning, [mbOK], 0);
//             except
//              showmessage('Problème à l''enregistrement de la pièce de dotation aux amortissements !');
//              abort;
//             end;//fin du try except
//         End;
//     if ListOd.Count<>0 then
//       DMPieces.AffichageFeuilleReprise(0,ListOd,nil,'Affichage de la pièce de dotation aux amortissements','','',false);
//  finally
////    if ListOD<>nil then
////     begin
////      ListOD.free;
////      ListOD:=nil;
////     end;
//   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMImmo_Clo,false);
////   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
////     Begin
////        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
////        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
////     End;
//  end;//fin du try finally
//End;



Procedure TDMImmo_Clo.TraitementCloture1(Sender:TObject);
Begin
//    Main.Supprimerlapiece1Click(Main.Supprimerlapiece1);
  //ouverture de la fenêtre visuImmo
    Main.mnMouvementsClick(nil);
    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
     begin
        if ((Cloture_Def.EtapeSuivante>=7)or(Cloture_Def.EtapeSuivante>=8)) then  { isa  le  09/09/03 }
          Cloture_Def.EtapeSuivante:=Cloture_Def.EtapeSuivante-1;
        ClotureDefActivate;
     end;
End;


Procedure TDMImmo_Clo.TraitementCloture2(Sender:TObject);
var
reference:string;
Begin
//suppression de la pièce de dotation et révérification pour
//afficher ensuite les écarts
//if VerificationSiPieceDeDotation(reference)then
// Begin
   //afficher un tableau des écarts
   if erreurClotureImmo<>nil then
     begin
     if erreurClotureImmo.Count<>0 then
       InitialiseTableauEcart(erreurClotureImmo);
     end;

 if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
   begin
        if ((Cloture_Def.EtapeSuivante>=7)or(Cloture_Def.EtapeSuivante>=8)) then  { isa  le  09/09/03 }
          Cloture_Def.EtapeSuivante:=Cloture_Def.EtapeSuivante-1;
   end;
     //  ClotureDefActivate;
// end;
End;


Procedure TDMImmo_Clo.TraitementCloture3(Sender:TObject);
Begin
  try
    Main.Genererlapiece1Click(Main.Genererlapiece1);
    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
     begin
        if ((Cloture_Def.EtapeSuivante>=7)or(Cloture_Def.EtapeSuivante>=8)) then  { isa  le  09/09/03 }
          Cloture_Def.EtapeSuivante:=Cloture_Def.EtapeSuivante-1;
        ClotureDefActivate;
     end;
  except
    //
  end;
End;


Procedure TDMImmo_Clo.TraitementCloture6(Sender:TObject);
Begin
  try
    if MessageDlg('Voulez-vous vérifier les soldes sur vos comptes d''immobilisation'+#13+#10+'avant de passer la pièce de dotation ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      DMImmo_Clo.TraitementCloture2(nil)
    else
      DMImmo_Clo.TraitementCloture3(nil);
    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
     begin
        if ((Cloture_Def.EtapeSuivante>=7)or(Cloture_Def.EtapeSuivante>=8)) then  { isa  le  09/09/03 }
          Cloture_Def.EtapeSuivante:=Cloture_Def.EtapeSuivante-1;
        ClotureDefActivate;
     end;
  except
    //
  end;
End;

procedure TDMImmo_Clo.CreationODImmos_avecObjet(TableEnCours:TTable;ODModif:string);
var
OD:string;
ListeOd:TStringList;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
tab:variant;
ValPieceAutoGen:TValPieceAutoGenere;
Begin
   try
     try
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoFin;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=TableEnCours.findfield('Designation').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Contrepartie').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
        case self.Tag of
          1:Begin //immos en cours
                //2 Ecritures à passer
               DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('Montant').AsCurrency,0,'','',0,'',''],true,false,-1);
               DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Contrepartie').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,-TableEnCours.findfield('Montant').ascurrency,0,'','',0,'',''],true,false,-1);
            End;//fin immos en cours
          2:Begin//immos terminées
                //2 Ecritures à passer
              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Contrepartie').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('Montant').AsCurrency,0,'','',0,'',''],true,false,-1);
              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,-TableEnCours.findfield('Montant').ascurrency,0,'','',0,'',''],true,false,-1);
            End;//fin immos terminées
          3:Begin//Production immobilisée
              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Contrepartie').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('Montant').AsCurrency,TableEnCours.findfield('TVA').ascurrency,DM_C_CompteTVAVente_V4,'',0,'',''],true,false,-1);
              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,-TableEnCours.findfield('Montant').ascurrency,-TableEnCours.findfield('TVA').ascurrency,DM_C_CompteTVAAchatImmo_I1,'',0,'',''],true,false,-1);
            End;//fin Production immobilisée
        end;//fin du case
          //remplissage de 2 lignes pour l'OD
       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMImmo_Clo,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;

function RecupCompte_A_Solder_SurCompteImmo(Famille:integer;compte:string):string;
begin
result:=DMPlan.FiltrageParamCPTSurComptePourImmo_A_Solder(Famille,compte,e.Regime);
end;


procedure TDMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCessionBeforeOpen(
  DataSet: TDataSet);
begin
/// si derogatoire à gérer
     DMImmo_Clo.QuAmortDerogDebit_SiDerog.close;
     DMImmo_Clo.QuAmortDerogDebit_SiDerog.ParamByName('DateDebutExo').AsDateTime:=QuVerifImmoAmortissableAvantClot_avecCession.ParamByName('DateDebutExo').asdatetime;
     DMImmo_Clo.QuAmortDerogDebit_SiDerog.open;

     DMImmo_Clo.QuAmortDerogCredit_SiDerog.close;
     DMImmo_Clo.QuAmortDerogCredit_SiDerog.ParamByName('DateDebutExo').AsDateTime:=QuVerifImmoAmortissableAvantClot_avecCession.ParamByName('DateDebutExo').asdatetime;
     DMImmo_Clo.QuAmortDerogCredit_SiDerog.open;
/// si pas de derogatoire à gérer
     DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.close;
     DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.ParamByName('DateDebutExo').AsDateTime:=QuVerifImmoAmortissableAvantClot_avecCession.ParamByName('DateDebutExo').asdatetime;
     DMImmo_Clo.QuAmortDerogDebit_SiNonDerog.open;

     DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.close;
     DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.ParamByName('DateDebutExo').AsDateTime:=QuVerifImmoAmortissableAvantClot_avecCession.ParamByName('DateDebutExo').asdatetime;
     DMImmo_Clo.QuAmortDerogCredit_SiNonDerog.open;
end;

procedure TDMImmo_Clo.TaImmos_ChangementExoAfterPost(DataSet: TDataSet);
begin
//   TableGereCommit(DataSet);
//   TableGereCommit(DMBalance.TaBalance);
end;


function SauvegardeImmosExo(DestPath:string;SourcePath:string;Table:TTable):TexceptLGR;
begin
try
if Table=nil then Table:=DMRech.TaImmosRech;
result.retour:=true;
if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
DeFiltrageDataSet(Table);
if SourcePath='Defaut' then SourcePath:=E.RepertoireDossier;
if DestPath='Defaut' then DestPath:=IncludeTrailingPathDelimiter(E.RepertoireExercice)+str_n_prem_char(Table.TableName,LastDelimiter('.',Table.TableName)-1)+'.DB';
if(not TableDuplique(Table,ExtractFilePath(SourcePath),ExtractFileName(DestPath),ExtractFilePath(DestPath),false))then abort;
except
  result.retour:=false;
end;
end;

function RestaureImmosDossier:TexceptLGR;
begin
try
result.retour:=true;
if FileExists(IncludeTrailingPathDelimiter(e.RepertoireExercice)+DMRech.TaImmosRech.TableName)then
  begin
      if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
      DeFiltrageDataSet(DMRech.TaImmosRech);
      DMRech.TaImmosRech.close;
      DMBD.CloseAllTAbleDossier('');
      abort;
      TableRestaure(DMRech.TaImmosRech,DMRech.TaImmosRech.TableName,DM_C_NomAliasExercice,true);
      SupprimerTable(DMRech.TaBalanceRech.DatabaseName,DMRech.TaImmosRech.TableName);
      DeleteFile(IncludeTrailingPathDelimiter(e.RepertoireExercice)+DMRech.TaImmosRech.TableName);
      DMBD.OpenTableDossier;
  end;
except
  result.retour:=false;
end;
end;

function RestaureImmosDossierNew(SourcePath:string;aliasTableSource:string):TexceptLGR;
var
tableImmos:TTable;
nomTable:string;
begin
try
result.retour:=true;
if(SourcePath='Defaut')then
begin
  nomtable:='immos.db';
  SourcePath:=IncludeTrailingPathDelimiter(e.RepertoireExercice)+nomtable;
end
else
  nomtable:=ExcludeTrailingPathDelimiter(StringReplace(SourcePath,ExtractFileDir(SourcePath),'',[rfReplaceAll]));

if(aliasTableSource='Defaut')then aliasTableSource:=DM_C_NomAliasExercice;
if (FileExists(SourcePath) and
  not e.ExerciceCloture)then
  begin
  if FermerDossier(E) then
  begin
     tableImmos:=TTable.Create(application.MainForm);
     tableImmos.TableName:='immos.db';
     tableImmos.DatabaseName:=DM_C_NomAliasDossier;
     TableRestaure(tableImmos,nomtable,aliasTableSource,true);
     SupprimerTable(aliasTableSource,nomtable);
     DeleteFile(SourcePath);
     Main.OuvreExo(E.NomDossier,e.NomExo,false);
  end
  else
  Application.MessageBox(Pchar('La restauration de la table des immos ne s''est pas déroulée correctement.'+
  RetourChariotSimple+AppelerServiceMaintenance),'Attention',MB_ICONWARNING);
  end;
except
  Application.MessageBox(Pchar('La restauration de la table des immos ne s''est pas déroulée correctement.'+
  RetourChariotSimple+AppelerServiceMaintenance),'Attention',MB_ICONWARNING);
  result.retour:=false;
end;
end;


function TDMImmo_Clo.SuppressionPieceDeDotationAmortissement(var reference:string;DemandeConfirmation:boolean):boolean;
var
confirmation:boolean;
begin
try
 result:=true;
 confirmation:=true;
  if VerificationSiPieceDeDotation(reference) then
    begin
    if DemandeConfirmation then
      confirmation:=MessageDlg('La pièce de dotation n°: '+reference+' va être supprimée.'+#13+#10+''+#13+#10+'Confirmez-vous cette suppression ?', mtWarning, [mbYes,mbNo], 0) = mrYes;
    if confirmation then
        begin
          DMPieces.SuppressionOD(reference);
          TableGereCommit(DMPieces.TaPiece);
          TableGereCommit(DMBalance.TaBalance);
          if DemandeConfirmation then
            showmessage('La pièce de dotation n°: '+reference+' a bien été supprimée');
        end
        else
          abort;
    end;

except
  result:=false;
end;
end;

function VerifResteAcquisitionOuCession_AvantCloture(DateDebut,DateFin:Tdatetime):TerreurCloture;
var
reference:string;
Begin
result.erreur.CodeErreur:=0;
result.erreur.retour:=true;
if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.create(Application.MainForm);
if DMImmo_Clo=nil then DMImmo_Clo:=TDMImmo_Clo.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);

//verifie s'il reste des acquisitions ou cessions en attentes
DataModuleImmos.Filtrage_qryListeAcquis_SurTag(C_ACQUISITION_Terminee,false,-1,'');
  if DataModuleImmos.qryListeAcquis.RecordCount<>0 then
     result.erreur.retour:=false;
if result.erreur.retour then
begin
DataModuleImmos.Filtrage_qryListeAcquis_SurTag(C_Cession,false,-1,'');
  if DataModuleImmos.qryListeAcquis.RecordCount<>0 then
     result.erreur.retour:=false;
end;
if result.erreur.retour=false then
  Begin
    result.erreur.CodeErreur:=1;//cessions ou acquisitions en attentes
    result.messages.MessageErreur:='Il reste des acquisitions ou des cessions en attentes, vous devez les acquérir ou les céder dans la gestion des immobilisations.';
    result.TitreBouton:='Créations des cessions ou acquisitions en attentes';

  End
end;
procedure TDMImmo_Clo.QuVerifImmoAmortissableAvantClot_avecCessionFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
//accept:=QuVerifImmoAmortissableAvantClot_avecCession.FindField('Terminee').AsBoolean=false;
end;

end.
