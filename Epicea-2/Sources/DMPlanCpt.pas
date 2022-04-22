{***************************************************************
 *
 * Unit Name: DMPlanCpt
 * Purpose  :
 * Author   :
 * History  :
 *             Attention : penser à intégrer les procédure d'isabelle
                           Mettre en local TaparamCpt -> Pourkoi ??
 *       Vérifier la Function TDMPlan.TaPlanCptPredicat(IndexPredicat:integer):boolean;

 ****************************************************************}
{//////// le 29-04-03   Modif_Isa
j'ai modifier la fonction CptEstAmortissable
///////}
unit DMPlanCpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dbgrids,Gr_Librairie_obj,E2_Librairie_obj,E2_AideCompte,
  stdctrls,E2_SuprCptGen,E2_AideTva, GestPlan,grids,DMBalances,LibZoneSaisie,
  LibSQL,E2_Decl_Records,LibRessourceString,lib_chaine, Db, DBTables,E2_LibInfosTable,
  DMConstantes,
  ObjetEdition,
  LibFichrep,
  DMRecherche_Obj,DiversProjets,
  Variants,Editions,ShellApi,ChoixPeriode,libdates,E2_GenerCpt_PM
  ;
Const
 C_Plan_Update_Plan_Saisie = 0;
 C_Plan_Update_Plan_TvaDebit = 1;

type
  TDMPlan = class(TDataModule)
    TaPlanCpte: TTable;
    DaPlanCpte: TDataSource;
    TaParamCpt: TTable;
    DaParamCpt: TDataSource;
    TaPlanCpt: TTable;
    DaPlanCpt: TDataSource;
    TaEcriture: TTable;
    TaParamCptAideCpt: TTable;
    DaParamCptAideCpt: TDataSource;
    TaCompte: TTable;
    DaCompte: TDataSource;
    TaPlanBO: TTable;
    DaPlanBO: TDataSource;
    TaPlanBOCompte: TStringField;
    TaPlanBODebit_Deb: TFloatField;
    TaPlanBOCredit_Deb: TFloatField;
    TaPlanBOQt1_Deb: TFloatField;
    TaPlanBOQt2_Deb: TFloatField;
    TaPlanBOOuverture: TBooleanField;
    QuCompteUtiliseOuvClot: TQuery;
    TaPlanBODebit_Deb_Calc: TCurrencyField;
    DaCompteGenere: TDataSource;
    TaCompteGener: TTable;
    TaPlanCptTrans1: TTable;
    TaPlanCptTrans2: TTable;
    DaPlanCptTrans1: TDataSource;
    DaPlanCptTrans2: TDataSource;
    TaPlanBOLibelle: TStringField;
    TaCompteGenerCompte: TStringField;
    TaCompteGenerLibelle: TStringField;
    TaCompteGenerDebit_Deb: TFloatField;
    TaCompteGenerCredit_Deb: TFloatField;
    TaCompteGenerUn1: TStringField;
    TaCompteGenerUn2: TStringField;
    TaCompteGenerQt1_Deb: TFloatField;
    TaCompteGenerQt2_Deb: TFloatField;
    TaCompteGenerPlanSaisie: TBooleanField;
    TaCompteGenerTvaCode: TStringField;
    TaCompteGenerTvaType: TStringField;
    TaCompteGenerTvaDebit: TBooleanField;
    TaCompteGenerSensCredit: TBooleanField;
    TaCompteGenerCollectif: TBooleanField;
    TaCompteGenerCentraliser: TBooleanField;
    TaCompteGenerTiers: TBooleanField;
    TaCompteGenerRapprochement: TBooleanField;
    TaCompteGenerImmobilisation: TBooleanField;
    TaCompteGenerImmoAmort: TBooleanField;
    TaCompteGenerImmoDegressif: TBooleanField;
    TaCompteGenerEmprunt: TBooleanField;
    TaCompteGenerAbandonne: TBooleanField;
    TaCompteGenerQui: TStringField;
    TaCompteGenerQuand: TDateTimeField;
    TaPlanBOCredit_Deb_Calc: TCurrencyField;
    QuMAJBalAutoBalManu: TQuery;
    QuMAJBalManuBlAuto: TQuery;
    QuPrepareMAJBalManuBalAuto: TQuery;
    TaBalanceUpdate: TTable;
    TaPlanUpdate: TTable;
    QuCptAmort: TQuery;
    TaCptImmos: TTable;
    DaCptImmos: TDataSource;
    TaCptImmosNumImmo: TStringField;
    TaCptImmosCompte: TStringField;
    TaCptImmosDebit_Deb: TFloatField;
    TaCptImmosCredit_Deb: TFloatField;
    TaCptImmosUn1: TStringField;
    TaCptImmosUn2: TStringField;
    TaCptImmosQt1_Deb: TFloatField;
    TaCptImmosQt2_Deb: TFloatField;
    TaCptImmosPlanSaisie: TBooleanField;
    TaCptImmosTvaCode: TStringField;
    TaCptImmosTvaType: TStringField;
    TaCptImmosTvaDebit: TBooleanField;
    TaCptImmosSensCredit: TBooleanField;
    TaCptImmosCollectif: TBooleanField;
    TaCptImmosCentraliser: TBooleanField;
    TaCptImmosTiers: TBooleanField;
    TaCptImmosRapprochement: TBooleanField;
    TaCptImmosImmobilisation: TBooleanField;
    TaCptImmosImmoAmort: TBooleanField;
    TaCptImmosImmoDegressif: TBooleanField;
    TaCptImmosEmprunt: TBooleanField;
    TaCptImmosAbandonne: TBooleanField;
    TaCptImmosQui: TStringField;
    TaCptImmosQuand: TDateTimeField;
    TaCptImmosLibelle: TStringField;
    TaCptImmosID_Affichage: TIntegerField;
    TaCptImmosJBanque: TStringField;
    TaCompteGenerID_Affichage: TIntegerField;
    TaCompteGenerJBanque: TStringField;
    TaCptImmospointable: TBooleanField;
    TaCompteGenerPointable: TBooleanField;
    TaPlanMaint: TTable;
    TaCompteListeUtil: TTable;
    DaCompteListeUtil: TDataSource;
    TaCompteGenerTaux: TFloatField;
    TaCompteGenerDiv: TStringField;
    TaPlanBOCalc: TTable;
    TaPlanBOCalcCompte: TStringField;
    TaPlanBOCalcLibelle: TStringField;
    TaPlanBOCalcDebit_Deb: TFloatField;
    TaPlanBOCalcCredit_Deb: TFloatField;
    TaPlanBOCalcOuverture: TBooleanField;
    TaPlanBOCalcDebit_Deb_Calc: TCurrencyField;
    TaPlanBOCalcCredit_Deb_Calc: TCurrencyField;
    TaPlanBOUn1: TStringField;
    TaPlanBOUn2: TStringField;
    TaPlanBOPlanSaisie: TBooleanField;
    TaPlanBOTvaCode: TStringField;
    TaPlanBOTvaType: TStringField;
    TaPlanBOTvaDebit: TBooleanField;
    TaPlanBOSensCredit: TBooleanField;
    TaPlanBOCollectif: TBooleanField;
    TaPlanBOCentraliser: TBooleanField;
    TaPlanBOTiers: TBooleanField;
    TaPlanBORapprochement: TBooleanField;
    TaPlanBOImmobilisation: TBooleanField;
    TaPlanBOImmoAmort: TBooleanField;
    TaPlanBOImmoDegressif: TBooleanField;
    TaPlanBOEmprunt: TBooleanField;
    TaPlanBOAbandonne: TBooleanField;
    TaPlanBOQui: TStringField;
    TaPlanBOQuand: TDateTimeField;
    TaPlanBOID_Affichage: TIntegerField;
    TaPlanBOJBanque: TStringField;
    TaPlanBOpointable: TBooleanField;
    TaPlanBOTaux: TFloatField;
    TaPlanBODiv: TStringField;
    TaPlanMaintS: TTable;
    Tabilan: TTable;
    QuPlanCptEdition: TQuery;
    QuGrandLivreCgEdition: TQuery;
    QuGrandLivreCgEditionID: TIntegerField;
    QuGrandLivreCgEditionID_Piece: TIntegerField;
    QuGrandLivreCgEditionContreP: TStringField;
    QuGrandLivreCgEditionTypeLigne: TStringField;
    QuGrandLivreCgEditionID_Ligne: TSmallintField;
    QuGrandLivreCgEditionDate: TDateField;
    QuGrandLivreCgEditionCompte: TStringField;
    QuGrandLivreCgEditionTiers: TStringField;
    QuGrandLivreCgEditionLibelle: TStringField;
    QuGrandLivreCgEditionQt1: TFloatField;
    QuGrandLivreCgEditionQt2: TFloatField;
    QuGrandLivreCgEditionDebitSaisie: TCurrencyField;
    QuGrandLivreCgEditionCreditSaisie: TCurrencyField;
    QuGrandLivreCgEditionID_Devise: TIntegerField;
    QuGrandLivreCgEditionDebit: TCurrencyField;
    QuGrandLivreCgEditionCredit: TCurrencyField;
    QuGrandLivreCgEditionTvaCode: TStringField;
    QuGrandLivreCgEditionTvaType: TStringField;
    QuGrandLivreCgEditionTvaTaux: TFloatField;
    QuGrandLivreCgEditionTvaDate: TDateField;
    QuGrandLivreCgEditionRapprochement: TStringField;
    QuGrandLivreCgEditionValidation: TDateField;
    QuGrandLivreCgEditionQui: TStringField;
    QuGrandLivreCgEditionQuand: TDateTimeField;
    QuGrandLivreCgEditionNum_Cheque: TStringField;
    QuGrandLivreCgEditionTable_Gen: TStringField;
    QuGrandLivreCgEditionChamp_Gen: TStringField;
    QuGrandLivreCgEditionVal_Champ_Gen: TStringField;
    QuGrandLivreCgEditionID_GESTCO: TFloatField;
    QuGrandLivreCgEditionCODE_GESTCO: TStringField;
    QuGrandLivreCgEditionMontant_Tva: TCurrencyField;
    QuGrandLivreCgEditionID_GESTANAL: TIntegerField;
    QuGrandLivreCgEditionCODE_GESTANAL: TStringField;
    QuGrandLivreCgEditionID_1: TIntegerField;
    QuGrandLivreCgEditionJournal: TIntegerField;
    QuGrandLivreCgEditionReference: TStringField;
    QuGrandLivreCgEditionDate_1: TDateField;
    QuGrandLivreCgEditionLibelle_1: TStringField;
    QuGrandLivreCgEditionTypePiece: TSmallintField;
    QuGrandLivreCgEditionCompte_1: TStringField;
    QuGrandLivreCgEditionID_Devise_1: TIntegerField;
    QuGrandLivreCgEditionValidation_1: TDateField;
    QuGrandLivreCgEditionQui_1: TStringField;
    QuGrandLivreCgEditionQuand_1: TDateTimeField;
    QuGrandLivreCgEditionNum_Cheque_1: TStringField;
    QuGrandLivreCgEditionID_GESTCO_1: TFloatField;
    QuGrandLivreCgEditionCODE_GESTCO_1: TStringField;
    QuGrandLivreCgEditionTable_Gen_1: TStringField;
    QuGrandLivreCgEditionChamp_Gen_1: TStringField;
    QuGrandLivreCgEditionVal_Champ_Gen_1: TStringField;
    QuGrandLivreCgEditionprix: TCurrencyField;
    QuListeValRupt: TQuery;
    QuSousTotal1: TQuery;
    QuTotalG: TQuery;
    QuSousTotal3: TQuery;
    QuSousTotal2: TQuery;
    QuReport: TQuery;
    QuGrandLivreCgEditionReferencePiece: TStringField;
    QuPlanCpt: TQuery;
    procedure DMPlanCreate(Sender: TObject);
    procedure DMPlanDestroy(Sender: TObject);
    procedure TaPlanCptBeforePost(DataSet: TDataSet);
    function PereCompte(cpte:string):string;
    function PereComptePCU(cpte:string):string;
    function CompteExistePCU(Cpte:string):boolean;
    Function PossedeFils (cpte : string): boolean;
    Function PossedeFrereCptGene(Cpte : string) : boolean;
    Function PossedePereNonPrevu(Cpte : string) : boolean;
    Function VerifComptePCG(cpte : string) : boolean;
    Function PossedeEcriture (cpte : string): boolean;
    Function PossedeEcritureDirect(cpte : string): boolean;
    function LibelleDuNumCpt(Cpte:string):string;
    function LibelleDuNumCptPCU(Cpte:string):string;
    Function NumCompte(Cpt : String) : String;
    Function ListePlanCptPouvantDevenirPointable:TStringList;
    Function CptDevenirPointable(Cpt:string):boolean;
    Function CptEstPointable(Cpt:string):boolean;
    Function CptTiers(Cpt:string):boolean;
    Function CptEstCollectif(Cpt:String):Boolean;
    Function CreationCpt(CCourant:Tfield):TErreurSaisie;
    Function SuppressionCpt(Cpte:string;DataSet:TDataSet;Mess:Boolean):TErreurSaisie;
    Function ModificationCpt(CCourant:TField):TErreurSaisie;
    procedure TaPlanCptAfterInsert(DataSet: TDataSet);
    procedure TaPlanCptGenereBeforeInsert(DataSet: TDataSet);
    Procedure ChampObligatoire(Cpte: String; var Champ: TStringList);
    procedure TaPlanCptAfterPost(DataSet: TDataSet);
    procedure TaPlanCptAfterPostAuto(DataSet: TDataSet);
    procedure TaPlanCptBeforeDelete(DataSet: TDataSet);
    procedure TaPlanCptAfterEdit(DataSet: TDataSet);
    procedure TaPlanCptBeforeCancel(DataSet: TDataSet);
    Procedure CreationAuto(CpteDepart:string;ParamGenerCptAffiche:TParamGenerCptAffiche);
    Function PossedePerePCU(Cpte:string):Boolean;
    Function DemandeCreation(Cpte:string;Controle :Tcomponent;MessCreat:boolean):Texceptlgr;
    procedure TaPlanCptBeforeInsert(DataSet: TDataSet);
//    procedure TaPlanCptAfterScroll(DataSet: TDataSet);
    Function CompteGenerateur(Cpt:string):boolean;
    Function CompteGenere(Cpt:string):boolean;
    Function VerifSiCptGenereEncoreLie(Cpt:String):Boolean;
    Procedure NettoieListeChOblig(var Liste:TStringList);
    function FiltrageAideCompte(Famille:integer;ListeCptExclus:TStringList;EventFilterRecord: TFilterRecordEvent):TStringlist;
//    procedure FiltrageAideCompte(Famille:integer);
    function FiltrageParamCPT(Famille:integer;Regime:string):TStringList;
    procedure FiltrageAideCompteSurCompte(Famille:integer;Compte:string;ListeCptExclus:TStringList;EventFilterRecord: TFilterRecordEvent);
    function FiltrageParamCPTSurCompte(Famille:integer;Compte,Regime:string):TStringList;
    function FiltrageParamCPTSurComptePourOD(Famille,Nb:integer;Compte,Regime:string):tstringlist;
    Function CptDevenirAmortissable(Cpt:string):boolean;
    Function CptEstAmortissable(Cpt:string):TTypeImmo;
    Function TvaCodePourCompte(Famille:integer;Regime,Compte:string):TTvaCodePourCompte;
    function CompteValideDansParamContexte(Compte:string;AffMessage:Boolean;Const Racx:array of string;ListeCptExclus:TStringList):boolean;
    Procedure InitChampAutoriseBO(Table:TTable);
    procedure TaPlanBOBeforeEdit(DataSet: TDataSet);
    procedure TaPlanBOCalcFields(DataSet: TDataSet);
    procedure TaPlanBOBeforeInsert(DataSet: TDataSet);
    procedure TaPlanBOBeforeOpen(DataSet: TDataSet);
    procedure TaPlanBOAfterDelete(DataSet: TDataSet);
    procedure TaPlanBOAfterClose(DataSet: TDataSet);
    Function TaPlanCptPredicat(Dataset:TDataset;IndexPredicat:integer):boolean;
    Function ListeCompteExclusEnteteEtPiece(Famille:integer;Regime:string):TStringList;
    function CodeDeTvaDuCompte(compte:string):string;
    function TauxDeTvaDuCompte(compte:string):real;
    procedure TaPlanBOBeforePost(DataSet: TDataSet);
    procedure TaPlanBOAfterPost(DataSet: TDataSet);
    procedure MAJBalManuBalAuto;
    procedure TaPlanCptAfterDelete(DataSet: TDataSet);
    procedure TaPlanCptBeforeEdit(DataSet: TDataSet);
    procedure TaCptImmosBeforeEdit(DataSet: TDataSet);
    procedure TaCptImmosAfterEdit(DataSet: TDataSet);
    procedure TaCptImmosBeforePost(DataSet: TDataSet);
    procedure TaCptImmosBeforeInsert(DataSet: TDataSet);
    function TypeCompteCrediteur(Compte:string):boolean;
    function FiltrageParamCPTSurComptePourDotation(Famille:integer;Compte,Regime:string):TCompteAmortissement;
    procedure TaPlanCptAfterOpen(DataSet: TDataSet);
    procedure TaPlanBOAfterOpen(DataSet: TDataSet);
    function FiltrageParamCPTSurComptePourImmo_A_Solder(Famille:integer;Compte,Regime:string):string;
    procedure QuPrepareMAJBalManuBalAutoFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuPrepareMAJBalManuBalAutoBeforeOpen(DataSet: TDataSet);
    procedure QuCompteUtiliseOuvClotBeforeOpen(DataSet: TDataSet);
    procedure QuCompteUtiliseOuvClotAfterOpen(DataSet: TDataSet);
    procedure TaCompteFilterRecordCptExclus(DataSet: TDataSet; var Accept: Boolean);
    procedure TaCompteFilterRecordCptReduit(DataSet: TDataSet; var Accept: Boolean);
    procedure TaCompteListeUtilFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    Procedure InitialiseInsertionCompte(Compte:string;DataSet:TDataSet);
    procedure TaCompteFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    Procedure GestionCompteEnCoursDeSaisie(Compte:String;Objet:TObject;Ajout:Boolean);
    Function CompteEnCoursDeSaisie(Compte:String;Objet:TObject):Boolean;
    Procedure AjouteCompteEnCoursDeSaisie(Value : TStringList);
    procedure TaPlanBOCalcCalcFields(DataSet: TDataSet);
    function FiltrageSurComptePourOD(Famille,Nb:integer;compte,Regime:string):TCompte1;
    Function NomTablePrincipale:TDataSet;
    Procedure GestionDesComptesObligatoireDsPlanCpt(AffichMess:boolean);
    procedure QuGrandLivreCgEditionCalcFields(DataSet: TDataSet);
    Function VerifSoldeCompteDansBO(Compte:string):Tcalcul;
    function FiltrageParamCPTSurCompteDotation_PourRecupCompteImmos(Famille:integer;Compte,Regime:string):string;
    Function CompteImmobilisation(Cpt:string):boolean;

    { isa  le  17/12/03 }
    Function PossedeEcritureSurPeriode (cpte : string;DemandePeriode:Boolean): boolean;
    { isa  le  17/12/03 }


    // Evénement spécifique lors de l'importation d'un plan comptable
    // Ils sont branché uniquement ponctuellement
    procedure TaPlanCptBeforeInsert_Import(DataSet: TDataSet);
    procedure TaPlanCptBeforePost_Import(DataSet: TDataSet);

    Procedure MiseAJourTauxParDefaut;{ isa  le  18/11/03 }
    Procedure GestionAccesPlanBO;
    procedure TaPlanBOBeforeEIDClo_Abort(DataSet: TDataSet);
    Procedure MarquerListeBooleenPlan(DAtaSet:TDataSet;TypeChamp,TypeMarquage:Integer);
    Procedure MarquerCompteBooleenPlan(Compte:String;TypeChamp,TypeMarquage:Integer);
    procedure QuPlanCpt_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);

    function ListeContientDebutCpt(Cpt:string;Famille:integer):boolean;

  protected
    FAideCompteVisible:Boolean;
    FListeCompteEnCoursDeSaisie:TStringList; // Liste qui contient les numero de compte en
                                            // cours de saisie dans un des écrans de saisie d'épicea
    Property ListeCompteEnCoursDeSaisie:TStringList read FListeCompteEnCoursDeSaisie ;//write AjouteCompteEnCoursDeSaisie;

  private
    { Déclarations privées }
    ListeCptExclusAideCompte,ListeCptReduitAideCompte:TStringList;
    ListeEdit:TStringList;
    // Ne doit pas pouvoir être d'ailleurs que de DMPlan ! Ne pas déplacer !!
    Procedure FiltrageAideCompteSurListe(ListeCptExclus:TStringList;EventFilterRecord: TFilterRecordEvent);
  public
    { Déclarations publiques }
    ListeChampOblig,ListeChamp,ListeCptOkBO,ListeCompteJournaux,ListeNonModifDsBO:TStringList;
    DernierEnregModif:TBookmark;
    CompteAJournal:boolean;
    DernierNumCptValideEnInsert:string; // Ce compte sert a savoir si le num Cpt a change
                                        // durant l'insertion d'un nouveau compte
    DernierComptePost:TInfosplancpt;
    DernierCompteSupprime,DernierCompteSupprimetmp:TInfosplancpt;

    EnDemandeCreation:Boolean; // Sert à savoir si on est en demande création
                               // d'un compte à partir d'un autre écran que planCpt
                               // (Création en saisie);
    Procedure Import_Plan(Valeurs:array of const;DataSet:TDataSet);
    Procedure Import_BilanOuverture(Valeurs:array of const;DataSet:TDataSet);
    Procedure Import_Plan_SIEA(Valeurs:array of const;DataSet:TDataSet);
    Procedure Import_BO_SIEA_DOS(Valeurs:array of const;DataSet:TDataSet);
    Procedure Import_BO_SIEA_DOS_MAJ(Valeurs:array of const;DataSet:TDataSet);
    Function ImporterCpt(Cpt:String):Boolean;
    Property AideCompteVisible:Boolean read FAideCompteVisible write FAideCompteVisible;


  end;

var
  DMPlan: TDMPlan;
  RetFunction : TErreurSaisie;
  OldValueCpt:string;
  ListeCptExclusPointage,ListeCptExclusAideCompte:Tstringlist;

function DmPlanRecupEnregistrementComplet(compte:string):TEnregistrementComplet;
function DmPlanRecupPartieEnregistrement(compte:string;Champ:string):TPartieEnregistrement;
Procedure DMPlanInitListeCompteJournaux;
Procedure MiseAJourPlanPourCptCollectif(Compte:String;ContientTiers:Boolean);
Function VerifSiCompteSaisieDsBO(Compte:string;Mess:boolean;DataSetEnCours:TDataSet;Ouverture:Boolean):boolean;Overload;
Function VerifSiCompteSaisieDsBO(Compte:string;Mess:boolean;DataSetEnCours:TDataSet):boolean;Overload;
Function VerifSiCompteSaisieDsGestionDesImmos(Compte:string;Mess:boolean):boolean;

Function EditionPlanCptL(TypeEdition : integer; DataSet:TDataSet;ListeCompte:TStringList;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
Function EditionPlanCpt(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
Function EditionGrandLivreCG(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;

Function DetermineQte_Cpt(Qte:real;Debit,Credit:Currency;Cpt:string):real;



implementation

uses
//  E2_GenerCpt_PM,
//  E2_CreationCompte_PM,
  DMTier,
  DMEcriture,
  DMTVA,
  E2_AideModel,
  DMBaseDonnee,
  DMDiocEtatBalance,
  DMParamEnt,
  DMRecherche,
    DMCorrection,
  DMAnalytique,
  E2_GesPlanCpt_PM,
  DMExports;

{$R *.DFM}

Function EditionGrandLivreCG(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var NomFich,Chemin,
      Cpt1,Cpt2:String;
  var periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
Begin

  Chemin :=E.RepertoireComptaWeb;
  NomFich:='GrandLivreCG';
  Cpt1:='1';
//  Cpt1:='1688';
  DMPlan.QuTotalG.SQL.Clear;
  DMPlan.QuTotalG.SQL.Add('select distinct compte from ecriture order by compte');
  DMPlan.QuTotalG.Open;
  DMPlan.QuTotalG.Last;
//  Cpt2:='2';
  Cpt2:='8';
  DMPlan.QuTotalG.Close;
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  if periode.Retour then begin
      if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

//      DMPlan.QuListeValRupt.SQL.Clear;
//      DMPlan.QuListeValRupt.SQL.Add('select distinct compte from ecriture');
//      DMPlan.QuListeValRupt.SQL.Add(' where compte between '''+Cpt1+''' and '''+cpt2+'''');
//      DMPlan.QuListeValRupt.SQL.Add(' and ecriture."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DMPlan.QuListeValRupt.SQL.Add(' order by compte');
//      DMPlan.QuListeValRupt.Open;

      DMPlan.QuListeValRupt.SQL.Clear;
      DMPlan.QuListeValRupt.SQL.Add('select distinct compte from "'+E.RepertoireExercice+'Balance"');
      DMPlan.QuListeValRupt.SQL.Add(' where compte between '''+Cpt1+''' and '''+cpt2+'''');
      DMPlan.QuListeValRupt.SQL.Add(' order by compte');
      DMPlan.QuListeValRupt.Open;


//      //report debut
//      DMPlan.QuReport.SQL.Clear;
//      DMPlan.QuReport.Params.Clear;
//      DMPlan.QuReport.SQL.Add('select cast(b.debit_report as numeric)+ ');
//      DMPlan.QuReport.SQL.Add('  (select cast(sum(e.debitsaisie) as numeric) ');
//      DMPlan.QuReport.SQL.Add('  from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
//      DMPlan.QuReport.SQL.Add('  where e.compte=b.compte and p.id=e.id_piece and b.compte=:compte and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''' ');
//      DMPlan.QuReport.SQL.Add('  ) as TotDebit ');
//      DMPlan.QuReport.SQL.Add(',cast(b.credit_report as numeric)+ ');
//
//      DMPlan.QuReport.SQL.Add('  (select cast(sum(e.Creditsaisie) as numeric) ');
//      DMPlan.QuReport.SQL.Add('  from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
//      DMPlan.QuReport.SQL.Add('  where e.compte=b.compte and p.id=e.id_piece and b.compte=:compte and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''' ');
//      DMPlan.QuReport.SQL.Add('  ) as TotCredit ');
//      DMPlan.QuReport.SQL.Add('from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
//      DMPlan.QuReport.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and b.compte=:compte ');
//      DMPlan.QuReport.Params[0].DataType := ftString;
//      DMPlan.QuReport.Open;

      //report debut
      DMPlan.QuReport.SQL.Clear;
      DMPlan.QuReport.Params.Clear;
      DMPlan.QuReport.SQL.Add('select (cast(b.debit_report as numeric))as TotDebit');
      DMPlan.QuReport.SQL.Add(',(cast(b.credit_report as numeric))as TotCredit');
      DMPlan.QuReport.SQL.Add('from "'+E.RepertoireExercice+'Balance" b ');
      DMPlan.QuReport.SQL.Add('where b.compte=:compte ');
      DMPlan.QuReport.Params[0].DataType := ftString;
      DMPlan.QuReport.Open;


      //mouvement de la periode
      DMPlan.QuSousTotal1.SQL.Clear;
      DMPlan.QuSousTotal1.Params.Clear;
      DMPlan.QuSousTotal1.SQL.Add('select sum(debitsaisie),sum(creditsaisie),sum(Qt1) from ecriture where compte= :compte');
      DMPlan.QuSousTotal1.SQL.Add(' and ecriture."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMPlan.QuSousTotal1.Params[0].DataType := ftString;
      DMPlan.QuSousTotal1.Open;


//      /////total des mouvements
//      DMPlan.QuSousTotal2.SQL.Clear;
//      DMPlan.QuSousTotal2.Params.Clear;
//      DMPlan.QuSousTotal2.SQL.Add('select distinct (cast(b.debit_report as numeric)- cast(b.credit_report as numeric))+ ');
//      DMPlan.QuSousTotal2.SQL.Add('  ((Select  cast(sum(e.DebitSaisie) as numeric)');
//      DMPlan.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
//      DMPlan.QuSousTotal2.SQL.Add('  where p.id=e.id_piece');
//      DMPlan.QuSousTotal2.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte )),');
////      DMPlan.QuSousTotal2.SQL.Add('  -(Select  cast(sum(e.creditSaisie) as numeric)');
////      DMPlan.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
////      DMPlan.QuSousTotal2.SQL.Add('  where p.id=e.id_piece');
////      DMPlan.QuSousTotal2.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte )),');
//
//      DMPlan.QuSousTotal2.SQL.Add('(cast(b.Credit_report as numeric)- cast(b.Debit_report as numeric))+ ');
//      //DMPlan.QuSousTotal2.SQL.Add('(cast(b.Debit_report as numeric)- cast(b.Credit_report as numeric))+ ');
//      DMPlan.QuSousTotal2.SQL.Add('  ((Select  cast(sum(e.creditSaisie) as numeric)');
//      DMPlan.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
//      DMPlan.QuSousTotal2.SQL.Add('  where p.id=e.id_piece');
//      DMPlan.QuSousTotal2.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte ))');
////      DMPlan.QuSousTotal2.SQL.Add('  -(Select  cast(sum(e.DebitSaisie) as numeric)');
////      DMPlan.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
////      DMPlan.QuSousTotal2.SQL.Add('  where p.id=e.id_piece');
////      DMPlan.QuSousTotal2.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte ))');
//
////      DMPlan.QuSousTotal2.SQL.Add(',qt1 ');
//
////      DMPlan.QuSousTotal2.SQL.Add('from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
////      DMPlan.QuSousTotal2.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and compte=:compte ');
//      DMPlan.QuSousTotal2.SQL.Add('from "'+E.RepertoireExercice+'Balance" b');
//      DMPlan.QuSousTotal2.SQL.Add('where b.compte=:compte ');
//      DMPlan.QuSousTotal2.Params[0].DataType := ftString;
//      DMPlan.QuSousTotal2.Open;


      //total des mouvements
      DMPlan.QuSousTotal2.SQL.Clear;
      DMPlan.QuSousTotal2.Params.Clear;
      DMPlan.QuSousTotal2.SQL.Add('select distinct cast(b.debit_report as numeric)+ ');
      DMPlan.QuSousTotal2.SQL.Add('  (select cast(sum(e.debitsaisie) as numeric) ');
      DMPlan.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuSousTotal2.SQL.Add('  where p.id=e.id_piece and compte=:compte and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMPlan.QuSousTotal2.SQL.Add('  (Select  cast(sum(e.DebitSaisie) as numeric)');
      DMPlan.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuSousTotal2.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuSousTotal2.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte )');

      DMPlan.QuSousTotal2.SQL.Add(', cast(b.credit_report as numeric)+ ');
      DMPlan.QuSousTotal2.SQL.Add('  (select cast(sum(e.Creditsaisie) as numeric) ');
      DMPlan.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuSousTotal2.SQL.Add('  where p.id=e.id_piece and compte=:compte and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMPlan.QuSousTotal2.SQL.Add('  (Select  cast(sum(e.creditSaisie) as numeric)');
      DMPlan.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuSousTotal2.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuSousTotal2.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte )');

      DMPlan.QuSousTotal2.SQL.Add(',qt1 ');
      DMPlan.QuSousTotal2.SQL.Add('from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
      DMPlan.QuSousTotal2.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and compte=:compte ');

//      DMPlan.QuSousTotal2.SQL.Add('from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
//      DMPlan.QuSousTotal2.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and compte=:compte ');
      DMPlan.QuSousTotal2.Params[0].DataType := ftString;
      DMPlan.QuSousTotal2.Open;

      //solde du compte
      DMPlan.QuSousTotal3.SQL.Clear;
      DMPlan.QuSousTotal3.Params.Clear;
      DMPlan.QuSousTotal3.SQL.Add('select distinct (cast(b.debit_report as numeric)+ ');
      DMPlan.QuSousTotal3.SQL.Add('  (Select  cast(sum(e.DebitSaisie) as numeric)');
      DMPlan.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuSousTotal3.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuSousTotal3.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte )');
      DMPlan.QuSousTotal3.SQL.Add(' )-( ');
      DMPlan.QuSousTotal3.SQL.Add('  cast(b.credit_report as numeric)+ ');
      DMPlan.QuSousTotal3.SQL.Add('  (Select  cast(sum(e.creditSaisie) as numeric)');
      DMPlan.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuSousTotal3.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuSousTotal3.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte )');
      DMPlan.QuSousTotal3.SQL.Add('),(cast(b.credit_report as numeric)+ ');
      DMPlan.QuSousTotal3.SQL.Add('  (Select cast(sum(e.creditSaisie) as numeric)');
      DMPlan.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuSousTotal3.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuSousTotal3.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte )');
      DMPlan.QuSousTotal3.SQL.Add(' )-( ');
      DMPlan.QuSousTotal3.SQL.Add('  cast(b.debit_report as numeric)+ ');
      DMPlan.QuSousTotal3.SQL.Add('  (Select  cast(sum(e.DebitSaisie) as numeric)');
      DMPlan.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuSousTotal3.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuSousTotal3.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte= :compte )');

      DMPlan.QuSousTotal3.SQL.Add('),0 ');

//      DMPlan.QuSousTotal3.SQL.Add('from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
//      DMPlan.QuSousTotal3.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and b.compte=:compte ');
      DMPlan.QuSousTotal3.SQL.Add('from "'+E.RepertoireExercice+'Balance" b');
      DMPlan.QuSousTotal3.SQL.Add('where b.compte=:compte ');

      DMPlan.QuSousTotal3.Params[0].DataType := ftString;
      DMPlan.QuSousTotal3.Open;

      //Total Général
      DMPlan.QuTotalG.SQL.Clear;
      DMPlan.QuTotalG.SQL.Add('select distinct(select cast(sum(b.debit_report) as numeric)-cast(sum(b.credit_report) as numeric) ');
      DMPlan.QuTotalG.SQL.Add('  from "'+E.RepertoireExercice+'Balance" b ');
      DMPlan.QuTotalG.SQL.Add('  where b.compte between '''+Cpt1+''' and '''+cpt2+''')+  ');
      DMPlan.QuTotalG.SQL.Add('  (Select  cast(sum(e.DebitSaisie) as numeric)');
      DMPlan.QuTotalG.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuTotalG.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuTotalG.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte between '''+Cpt1+''' and '''+cpt2+''' )');

      DMPlan.QuTotalG.SQL.Add('  -(Select  cast(sum(e.creditSaisie) as numeric)');
      DMPlan.QuTotalG.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuTotalG.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuTotalG.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte between '''+Cpt1+''' and '''+cpt2+''' )');
      //deuxième valeur
      DMPlan.QuTotalG.SQL.Add(',(select cast(sum(b.credit_report)as numeric)-cast(sum(b.debit_report) as numeric) ');
      DMPlan.QuTotalG.SQL.Add('  from "'+E.RepertoireExercice+'Balance" b ');
      DMPlan.QuTotalG.SQL.Add('  where b.compte between '''+Cpt1+''' and '''+cpt2+''')+  ');
      DMPlan.QuTotalG.SQL.Add('  (Select  cast(sum(e.creditSaisie) as numeric)');
      DMPlan.QuTotalG.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuTotalG.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuTotalG.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte between '''+Cpt1+''' and '''+cpt2+''' )');

      DMPlan.QuTotalG.SQL.Add('  -(Select  cast(sum(e.DebitSaisie) as numeric)');
      DMPlan.QuTotalG.SQL.Add('  from ecriture e, piece p ');
      DMPlan.QuTotalG.SQL.Add('  where p.id=e.id_piece');
      DMPlan.QuTotalG.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and compte between '''+Cpt1+''' and '''+cpt2+''' )');

      //troisieme valeur
      DMPlan.QuTotalG.SQL.Add(',0 ');
      DMPlan.QuTotalG.SQL.Add('from "'+E.RepertoireExercice+'Balance" b, ecriture e, piece p ');
      DMPlan.QuTotalG.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and compte between '''+Cpt1+''' and '''+cpt2+''' ');

      DMPlan.QuTotalG.Open;

      ///////
      DMPlan.QuGrandLivreCgEdition.SQL.Clear;
      DMPlan.QuGrandLivreCgEdition.SQL.Add('select * from ecriture,piece where id_piece=piece.id');
      DMPlan.QuGrandLivreCgEdition.SQL.Add(' and compte between '''+Cpt1+''' and '''+cpt2+'''');
      DMPlan.QuGrandLivreCgEdition.SQL.Add(' and ecriture."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMPlan.QuGrandLivreCgEdition.Open;

      case TypeEdition  of
          C_EditionSimple:Begin
                              Site.lien := false;
//                              EditGrandLivreCG(Chemin,NomFich,DMPlan.QuGrandLivreCgEdition,'compte',DMPlan.QuListeValRupt,DMPlan.QuReport,DMPlan.QuSousTotal1,DMPlan.QuSousTotal2,DMPlan.QuSousTotal3,DMPLan.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),cpt1,cpt2,Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
          C_EditionWeb: Begin
                            Site.lien := false;
                            //EditDetteCreanceTiers(NomMenuSiteWeb,Chemin,NomFich,DMPointage2.QuStocksEdition,'Compte',DMPointage2.QuListeValRupt,DMStock.QuTotalG,DateToStr(now),Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
      end;
      DMPlan.QuListeValRupt.Close;
      DMPlan.QuReport.Close;
      DMPlan.QuSousTotal1.Close;
      DMPlan.QuSousTotal2.Close;
      DMPlan.QuSousTotal3.Close;
      DMPlan.QuTotalG.Close;
      DMPlan.QuGrandLivreCgEdition.Close;
  end;
End;

Function EditionPlanCptL(TypeEdition : integer; DataSet:TDataSet;ListeCompte:TStringList;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
var
ListeValeur:TStringList;
ValeurCompte:String;
ObjPrn:TObjetEdition;
ListeEdition:Tstringlist;
Begin
try
 Screen.Cursor := crSQLWait;
 ListeValeur:=TStringList.Create;
 ListeEdition:=TStringList.Create;
 ObjPrn:=TObjetEdition.Create(application.MainForm);

 if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 DMPlan.QuPlanCptEdition.Close;
 DMPlan.ListeEdit.Clear;
 if dataset <> nil then
  begin
   if ListeCompte = nil then
    begin
     ValeurCompte:=dataSet.FindField('Compte').AsString;
     DMPlan.ListeEdit:=ChampTableVersListe('Compte',dataSet);
     dataSet.Locate('Compte',ValeurCompte,[]);
     ReEnableControls(DataSet);
    end
    else
    begin
    if ListeCompte.Count>0 then
      ValeurCompte:=ListeCompte.Strings[0];
    DMPlan.ListeEdit.Assign(ListeCompte);
    //showmessage(ErrInterne+': EditionPlanCptL : ne pas passer un dataset et une liste !');
    end;
  end
 else
  begin
   if ListeCompte <> nil then
     DMPlan.ListeEdit.Assign(ListeCompte);
  end;

 DMPlan.QuPlanCptEdition.OnFilterRecord:=DMPlan.QuPlanCpt_EditionFilterRecord;
 DMPlan.QuPlanCptEdition.Filtered:=true;

 DMPlan.QuPlanCptEdition.SQL.Clear;
 DMPlan.QuPlanCptEdition.Params.Clear;
 DMPlan.QuPlanCptEdition.SQL.Add('select * from planCpt.db ');
// DMPlan.QuPlanCptEdition.SQL.Add(' where Actif=true and Date_Saisie =:DateANouveau');
// DMPlan.QuPlanCptEdition.SQL.Add(' order by compte');
 DMPlan.QuPlanCptEdition.Open;
 ListeEdition.Add(' Compte ; Libellé ; U1 ; U2 ; Code Tva ; Tva Déb ; SensC ; Coll. ; Rapp. ; Immo. ; Point. ; Plan S ');
 if DMPlan.QuPlanCptEdition.RecordCount <> 0 then
  begin
    DMPlan.QuPlanCptEdition.First;
    while not DMPlan.QuPlanCptEdition.Eof do
      begin
        ListeEdition.Add(DMPlan.QuPlanCptEdition.FindField('Compte').AsString+
                         ';'+
                         GereLibelle(DMPlan.QuPlanCptEdition.FindField('Libelle').AsString)+
                         ';'+
                         GereLibelle(DMPlan.QuPlanCptEdition.FindField('Un1').AsString)+
                         ';'+
                         GereLibelle(DMPlan.QuPlanCptEdition.FindField('Un2').AsString)+
                         ';'+
                         DMPlan.QuPlanCptEdition.FindField('TvaCode').AsString+
                         ';'+
                         str_bool2str_FR(DMPlan.QuPlanCptEdition.FindField('TvaDebit').AsBoolean)+
                         ';'+
                         str_bool2str_FR(DMPlan.QuPlanCptEdition.FindField('SensCredit').AsBoolean)+
                         ';'+
                         str_bool2str_FR(DMPlan.QuPlanCptEdition.FindField('Collectif').AsBoolean)+
                         ';'+
                         str_bool2str_FR(DMPlan.QuPlanCptEdition.FindField('Rapprochement').AsBoolean)+
                         ';'+
                         str_bool2str_FR(DMPlan.QuPlanCptEdition.FindField('Immobilisation').AsBoolean)+
                         ';'+
                         str_bool2str_FR(DMPlan.QuPlanCptEdition.FindField('Pointable').AsBoolean)+
                         ';'+
                         str_bool2str_FR(DMPlan.QuPlanCptEdition.FindField('PlanSaisie').AsBoolean));

        ListeValeur.Add('16'+
                         ';'+
                         DMPlan.QuPlanCptEdition.FindField('Compte').AsString+
                         ';'+
                         GereLibelle(DMPlan.QuPlanCptEdition.FindField('Libelle').AsString)+
                         ';'+
                         GereLibelle(DMPlan.QuPlanCptEdition.FindField('Un1').AsString)+
                         ';'+
                         GereLibelle(DMPlan.QuPlanCptEdition.FindField('Un2').AsString)+
                         ';'+
                         DMPlan.QuPlanCptEdition.FindField('TvaCode').AsString+
                         ';'+
                         str_bool2str_LGR(DMPlan.QuPlanCptEdition.FindField('TvaDebit').AsBoolean,'x','')+
                         ';'+
                         str_bool2str_LGR(DMPlan.QuPlanCptEdition.FindField('SensCredit').AsBoolean,'x','')+
                         ';'+
                         str_bool2str_LGR(DMPlan.QuPlanCptEdition.FindField('Collectif').AsBoolean,'x','')+
                         ';'+
                         str_bool2str_LGR(DMPlan.QuPlanCptEdition.FindField('Rapprochement').AsBoolean,'x','')+
                         ';'+
                         str_bool2str_LGR(DMPlan.QuPlanCptEdition.FindField('Immobilisation').AsBoolean,'x','')+
                         ';'+
                         str_bool2str_LGR(DMPlan.QuPlanCptEdition.FindField('Pointable').AsBoolean,'x','')+
                         ';'+
                         str_bool2str_LGR(DMPlan.QuPlanCptEdition.FindField('PlanSaisie').AsBoolean,'x','')
                         );
//        ListeValeur.Add('16');
        DMPlan.QuPlanCptEdition.Next;
      end;
        DMPlan.QuPlanCptEdition.Close;

        if DossierTypeRegime = 'A' then
        ObjPrn.FTitreEdition := 'Extrait du plan comptable général Agricole';

        if DossierTypeRegime = 'I' then
        ObjPrn.FTitreEdition := 'Extrait du plan comptable général Industriel';

        ListeValeur.Add('7'+
                        ';'+
                        '');
        ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
        ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
        ListeValeur.Insert(0,' Compte ; Libellé ; U1 ; U2 ; Code Tva ; Tva Déb ; SensC ; Coll. ; Rapp. ; Immo. ; Point. ; Plan S ');
        ListeValeur.Insert(1,'0.6;2;0.3;0.3;0.6;0.6;0.5;0.5;0.5;0.5;0.5;0.5');
        ListeValeur.Insert(2,'texte;texte;texte;texte;texte;texte;texte;texte;texte;texte;texte;texte');
     end;//s'il y a des données à imprimer
       if TypeEdition=C_Exportation then
         ExportDonnees(ListeEdition,E.RepertoireExportDossier,'PlanComptable_'+E.NomDossier + E.NomExo + '.Txt')
       else
         ObjPrn.AffichageImp(ListeValeur);
//  end
//  else
//  begin
//   MessageDlg('Aucune données à imprimer.', mtInformation, [mbOK], 0);
//  end;
Finally
 Screen.Cursor := crDefault;
 LibereObjet(tobject(ObjPrn));
 Initialise_TStringlist(Listevaleur);
 Initialise_TStringlist(ListeEdition);
 DMPlan.QuPlanCptEdition.OnFilterRecord:=nil;
end;
End;

Function EditionPlanCpt(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var
    NomFich,
    Chemin,
    Cpt1,Cpt2:String;
Begin

 Chemin :=E.RepertoireComptaWeb;
 NomFich:='PlanCpt';
 Cpt1:='1';
 if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 DMPlan.QuPlanCptEdition.SQL.Clear;
 DMPlan.QuPlanCptEdition.SQL.Add('select distinct compte from plancpt order by compte');
 DMPlan.QuPlanCptEdition.Open;
 DMPlan.QuPlanCptEdition.Last;
 Cpt2:=DMPlan.QuPlanCptEdition.findfield('compte').AsString;
 DMPlan.QuPlanCptEdition.Close;

 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
  end;

  DMPlan.QuPlanCptEdition.SQL.Clear;
  DMPlan.QuPlanCptEdition.SQL.Add('select * from plancpt');
  DMPlan.QuPlanCptEdition.SQL.Add('where compte between '''+Cpt1+''' and '''+cpt2+'''');
  DMPlan.QuPlanCptEdition.Open;

   case TypeEdition  of
      C_EditionSimple:Begin
          Site.lien := false;
//          EditPlanCpt(Chemin,NomFich,DMPlan.QuPlanCptEdition,Site);
          ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
      End;
      C_EditionWeb:Begin
          Site.lien := false;
         // LienEditPlanCpt(NomMenuSiteWeb,Chemin,NomFich,DMPlan.QuPlanCptEdition,Site);
          ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
      end;
  end;
  DMPlan.QuPlanCptEdition.Close;
End;

//******************************************************************************
//******************************************************************************
//******************* DmPlanRecupPartieEnregistrement *************************
//******************************************************************************
//******************************************************************************
//Cette fonction permet de récupérer un champ d'un enregistrement à partir
//d'un numéro de compte
//******************************************************************************
//******************************************************************************
//*************************************************************************
function DmPlanRecupPartieEnregistrement(compte:string;Champ:string):TPartieEnregistrement;
//var
//TableAux:TTable;
begin
////
DMRech_Obj.Ta_InfosDiverses.Close;
DMRech_Obj.Ta_InfosDiverses.Filter:='';
DMRech_Obj.Ta_InfosDiverses.filtered:=false;

   result.codeRetour:=false;
   if DMPlan = nil then
     DMPlan:=TDMPlan.Create(Application.MainForm);
//   TableAux:=TTable.Create(Application.MainForm);
   DMRech_Obj.Ta_InfosDiverses.DatabaseName:=DMPlan.TaPlanCpt.DatabaseName;
   DMRech_Obj.Ta_InfosDiverses.TableName:=DMPlan.TaPlanCpt.TableName;
   DMRech_Obj.Ta_InfosDiverses.Open;
    result.CodeRetour:=DMRech_Obj.Ta_InfosDiverses.Locate('Compte',compte,[]);
    if result.CodeRetour then
       begin //si result.codeRetour =true
        result.Partie:=DMRech_Obj.Ta_InfosDiverses.FindField(Champ).value;
       end;
    result.codeRetour := result.Partie <> NULL;
   DMRech_Obj.Ta_InfosDiverses.Close;
//   TableAux.Free;
end;



//******************************************************************************
//******************************************************************************
//******************* DmPlanRecupEnregistrementComplet *************************
//******************************************************************************
//******************************************************************************
//Cette fonction permet de récupérer tous les champs d'un enregistrement à partir
//d'un numéro de compte
//*************************************************************************
//******************************************************************************
//******************************************************************************
//function DmPlanRecupEnregistrementComplet(compte:string):TEnregistrementComplet;
//var
//Infosplancpt:TInfosplancpt;
//begin
//if DMRech = nil then
//  DMRech:=TDMRech.Create(Application.MainForm);
//  Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[compte]);
//
// result.CodeRetour:=Infosplancpt.ResultInfos;
// if result.CodeRetour then
//    begin //si result.codeRetour =true
//    result.Compte:=compte;
//    result.Abandonne:=Infosplancpt.Abandonne;
//    result.Centraliser:=Infosplancpt.Centraliser;
//    result.Collectif:=Infosplancpt.Collectif;
//    result.Credit_Deb:=Infosplancpt.Credit_Deb;
//    result.Debit_Deb:=Infosplancpt.Debit_Deb;
//    result.Emprunt:=Infosplancpt.Emprunt;
//    result.ImmoAmort:=Infosplancpt.ImmoAmort;
//    result.Immobilisation:=Infosplancpt.Immobilisation;
//    result.ImmoDegressif:=Infosplancpt.ImmoDegressif;
//    result.Libelle:=Infosplancpt.Libelle;
//    result.PlanSaisie:=Infosplancpt.PlanSaisie;
//    result.Qt1_Deb:=Infosplancpt.Qt1_Deb;
//    result.Qt2_Deb:= Infosplancpt.Qt2_Deb;
//    result.Quand:=Infosplancpt.Quand;
//    result.Qui:=Infosplancpt.Qui;
//    result.Rapprochement:=Infosplancpt.Rapprochement;
//    if not empty(BoolTostr(Infosplancpt.SensCredit)) then
//      Begin
//        if Infosplancpt.SensCredit then
//          result.SensCredit:=C_true
//        else
//          result.SensCredit:=C_False;
//      End
//    else
//      result.SensCredit:=C_Nul;
//    result.Tiers:=Infosplancpt.Tiers;
//    result.TvaCode:=Infosplancpt.TvaCode;
//    result.TvaDebit:=Infosplancpt.TvaDebit;
//    result.TvaType:=Infosplancpt.TvaType;
//    result.Un1:=Infosplancpt.Un1;
//    result.Un2:=Infosplancpt.Un2;
//    end; //fin de result.codeRetour =true
//end;

// PB le 19/02/04
function DmPlanRecupEnregistrementComplet(compte:string):TEnregistrementComplet;
//var
//TableAux:TTable;
begin
////
DMRech_Obj.Ta_InfosDiverses.Close;
DMRech_Obj.Ta_InfosDiverses.Filter:='';
DMRech_Obj.Ta_InfosDiverses.filtered:=false;

if DMPlan = nil then
  DMPlan:=TDMPlan.Create(Application.MainForm);
//TableAux:=TTable.Create(Application.MainForm);
DMRech_Obj.Ta_InfosDiverses.DatabaseName:=DMPlan.TaPlanCpt.DatabaseName;
DMRech_Obj.Ta_InfosDiverses.TableName:=DMPlan.TaPlanCpt.TableName;
DMRech_Obj.Ta_InfosDiverses.Open;
 result.CodeRetour:=DMRech_Obj.Ta_InfosDiverses.Locate('Compte',compte,[]);
 if result.CodeRetour then
    begin //si result.codeRetour =true
    result.Compte:=compte;
    result.Abandonne:=DMRech_Obj.Ta_InfosDiverses.FindField('Abandonne').AsBoolean;
    result.Centraliser:=DMRech_Obj.Ta_InfosDiverses.FindField('Centraliser').AsBoolean;
    result.Collectif:=DMRech_Obj.Ta_InfosDiverses.FindField('Collectif').AsBoolean;
    result.Credit_Deb:=DMRech_Obj.Ta_InfosDiverses.FindField('Credit_Deb').AsFloat;
    result.Debit_Deb:=DMRech_Obj.Ta_InfosDiverses.FindField('Debit_Deb').AsFloat;
    result.Emprunt:=DMRech_Obj.Ta_InfosDiverses.FindField('Emprunt').AsBoolean;
    result.ImmoAmort:=DMRech_Obj.Ta_InfosDiverses.FindField('ImmoAmort').AsBoolean;
    result.Immobilisation:=DMRech_Obj.Ta_InfosDiverses.FindField('Immobilisation').AsBoolean;
    result.ImmoDegressif:=DMRech_Obj.Ta_InfosDiverses.FindField('ImmoDegressif').AsBoolean;
    result.Libelle:=DMRech_Obj.Ta_InfosDiverses.FindField('Libelle').Asstring;
    result.PlanSaisie:=DMRech_Obj.Ta_InfosDiverses.FindField('PlanSaisie').AsBoolean;
    result.Qt1_Deb:=DMRech_Obj.Ta_InfosDiverses.FindField('Qt1_Deb').AsFloat;
    result.Qt2_Deb:= DMRech_Obj.Ta_InfosDiverses.FindField('Qt2_Deb').AsFloat;
    result.Quand:=DMRech_Obj.Ta_InfosDiverses.FindField('Quand').AsDateTime;
    result.Qui:=DMRech_Obj.Ta_InfosDiverses.FindField('Qui').Asstring;
    result.Rapprochement:=DMRech_Obj.Ta_InfosDiverses.FindField('Rapprochement').AsBoolean;
    if not empty(DMRech_Obj.Ta_InfosDiverses.FindField('SensCredit').Asstring)then
      Begin
        if DMRech_Obj.Ta_InfosDiverses.FindField('SensCredit').AsBoolean then
          result.SensCredit:=C_true
        else
          result.SensCredit:=C_False;
      End
    else
      result.SensCredit:=C_Nul;
    result.Tiers:=DMRech_Obj.Ta_InfosDiverses.FindField('Tiers').AsBoolean;
    result.TvaCode:=DMRech_Obj.Ta_InfosDiverses.FindField('TvaCode').Asstring;
    result.TvaDebit:=DMRech_Obj.Ta_InfosDiverses.FindField('TvaDebit').AsBoolean;
    result.TvaType:=DMRech_Obj.Ta_InfosDiverses.FindField('TvaType').Asstring;
    result.Un1:=DMRech_Obj.Ta_InfosDiverses.FindField('Un1').Asstring;
    result.Un2:=DMRech_Obj.Ta_InfosDiverses.FindField('Un2').Asstring;
    end; //fin de result.codeRetour =true
DMRech_Obj.Ta_InfosDiverses.Close;
//TableAux.Free;
end;
//
// Fin PB le 19/02/04
Procedure DMPlanInitListeCompteJournaux;
begin
  if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
  DMPlan.ListeCompteJournaux:=DMPlan.FiltrageParamCPT(101,E.Regime);
  FiltrageDataSet(DMRech.TaPlanCptRech,CreeFiltreOU('Compte',[DMPlan.ListeCompteJournaux]));
  DMPlan.ListeCompteJournaux.Clear;
  DMPlan.ListeCompteJournaux:=ChampTableVersListe('Compte',DMRech.TaPlanCptRech);
end;

//****************************************************************************//
// Procedure qui met a jour les champs tiers et Pointable lors de la creation d'un tiers dans DMTiers
//****************************************************************************//

Procedure MiseAJourPlanPourCptCollectif(Compte:String;ContientTiers:Boolean);
var
OldOpen:boolean;
//,OldFiltered:boolean;
//OldFilter:string;
EtatFiltre:TEtatFiltre;
Begin

try
   try
     if DMPlan = nil then
         DMPlan:=TDMPlan.Create(Application.MainForm);
     OldOpen:=DMPlan.TaPlanCpt.Active;
     if not OldOpen then DMPlan.TaPlanCpt.Open;
     TableSauveEtatFiltre(DMPlan.TaPlanCpt,EtatFiltre); // PB le 02/09/03
//     OldFiltered:=DMPlan.TaPlanCpt.Filtered;
//     OldFilter:=DMPlan.TaPlanCpt.Filter;
     if DMPlan.TaPlanCpt.State in [dsInsert,dsEdit] then TableGerePost(DMPlan.TaPlanCpt);
     DMPlan.TaPlanCpt.Filtered:=false;
     if DMPlan.TaPlanCpt.Locate('Compte',Compte,[]) then
     begin
       case DMPlan.TaPlanCpt.State of
          dsBrowse:Begin
                    try
//                     if DMPlan.TaPlanCpt.FindField('Tiers').AsBoolean <> true then
                      begin
                        DMPlan.TaPlanCpt.Edit;
                        DMPlan.TaPlanCpt.FindField('Tiers').AsBoolean:=ContientTiers;
                        if ContientTiers then
                         begin
                           DMPlan.TaPlanCpt.FindField('Pointable').AsBoolean:=True;
                           DMPlan.TaPlanCpt.FindField('Collectif').AsBoolean:=true;
                           DMPlan.TaPlanCpt.FindField('Rapprochement').AsBoolean:=True;
                         end
                         else
                         begin
  //                        DMPlan.TaPlanCpt.FindField('Pointable').AsBoolean:=DMPlan.CptDevenirPointable(Compte);
                         end;
                        TableGerePost(DMPlan.TaPlanCpt);
                       end;
                      Except
                       abort;
                      end;
                   End;

          dsEdit:begin
                   try
                     if DMPlan.TaPlanCpt.FindField('Tiers').AsBoolean <> true then
                      begin
                        DMPlan.TaPlanCpt.FindField('Tiers').AsBoolean:=ContientTiers;
                        if ContientTiers then
                         begin
                           DMPlan.TaPlanCpt.FindField('Pointable').AsBoolean:=True;
                           DMPlan.TaPlanCpt.FindField('Collectif').AsBoolean:=true;
                           DMPlan.TaPlanCpt.FindField('Rapprochement').AsBoolean:=True;
                         end
                         else
                         begin
    //                      DMPlan.TaPlanCpt.FindField('Pointable').AsBoolean:=DMPlan.CptDevenirPointable(Compte);
                         end;
                       end;
                   except
                    abort;
                   end;
                 end;
//          dsInsert:DMPlan.TaPlanCpt.FindField('Tiers').AsBoolean:=true;
       end;
   end;
   except
    Showmessage('Un problème est apparu lors de la mise à jour compte');
    abort;
   end;
finally
   if not OldOpen then DMPlan.TaPlanCpt.close;
   TableRestoreEtatFiltre(DMPlan.TaPlanCpt,EtatFiltre); // PB le 02/09/03
//   DMPlan.TaPlanCpt.Filter:=OldFilter;
//   DMPlan.TaPlanCpt.Filtered:=OldFiltered;
end;

End;

Function VerifSiCompteSaisieDsBO(Compte:string;Mess:boolean;DataSetEnCours:TDataSet;Ouverture:Boolean):boolean;
Begin
result := false;
if Ouverture then
 result:=VerifSiCompteSaisieDsBO(Compte,Mess,DataSetEnCours);
End;


// Voir avec Denis si on doit rajouter aussi les comptes pouvant devenir Pointable
//Vérifie si un compte à directement été saisie dans le BO
// d'ouverture, si oui, renvoie true
Function VerifSiCompteSaisieDsBO(Compte:string;Mess:boolean;DataSetEnCours:TDataSet):boolean;
var
Infosplancpt:TInfosplancpt;
Begin
result:=false;
{ isa  le  18/02/04 }
// if  (not((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'))and (e.TypeEtatExercice <> ET_EnCloture)) then
 if  (not((ParamUtil.maintenance)and (ParamUtil.TypeMaintenance='MaintS'))and (e.TypeMAJBalance<>MAJ_Report) and (e.TypeEtatExercice <> ET_EnCloture)) then
  begin
    result:=false;
    if not empty(compte) then result:=((copy(compte,1,1) <> '6') and (copy(compte,1,1) <> '7'));
    if result then
     begin
       try
          try
            if DMPlan <> nil then
             if DMPlan.TaPlanBO.State in [dsInsert,dsEdit] then
             begin
               TableGerePost(DMPlan.TaPlanBO);
             end;
            DeFiltrageDataSet(DMRech.TaPlanCptRech);
            Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Compte]);
            if Infosplancpt.ResultInfos then
            begin
             result:=not VerifNumeric(CurrToStr(Infosplancpt.Debit_Deb)).VideOUZero;
             if not result then
                 result:=not VerifNumeric(CurrToStr(Infosplancpt.Credit_Deb)).VideOUZero;
             if not result then
              begin
                DMPlan.QuCompteUtiliseOuvClotBeforeOpen(DataSetEnCours);
                result:=DMPlan.ListeNonModifDsBO.IndexOf(Compte) <> -1 ;
              end;
             if result and mess then
                Showmessage('Vous ne pouvez pas utiliser le compte : '+Infosplancpt.Compte+RetourChariotDouble+'Il possède une valeur qui a été saisie dans le Bilan d''Ouverture');

            end;
          except
           Showmessage('Un problème est apparu lors de la recherche du compte : '+Compte+' dans le BO');
           abort;
          end;
       finally

       end;
     end;
  end;
End;



//******************* CompteValideDansParamContexte *************************
//
// Retourne VRAI si Compte : - est plus long ou egal à la racine d'un compte de
//                             la table parametre et s'il existe dans cette table
//                           - une des racine de la table param = la racine de
//                             compte
//                           - si le compte n'est pas dans la liste des comptes exclus
//*************************************************************************

function TDMPlan.CompteValideDansParamContexte(Compte:string;AffMessage:Boolean;Const Racx:array of string;ListeCptExclus:TStringList):boolean;
var
CptAux:string;
i:integer;
Begin
if not TaParamCptAideCpt.Active then TaParamCptAideCpt.Open;
CptAux:=Compte;
result:=false;
i:=0;
if length(compte)<=2 then
 begin
  result:=false;
  CptAux:='';
 end
else
Repeat
  Repeat
  result:=TaParamCptAideCpt.locate(Racx[i],CptAux,[]);
  inc(i);
  Until ((result=true) or (i>high(Racx)));
  i:=0;
  CptAux:=copy(CptAux,1,length(CptAux)-1);
Until ((result=true) or (length(CptAux)=0));
if ListeCptExclus <> nil then
 result:=ListeCptExclus.IndexOf(Compte) = -1;
//result:=not (length(CptAux)<=2);
if ((AffMessage=true) and (length(CptAux)=0) and (result=false)) then
   showmessage('Le Compte : ' + Compte + ' n''est pas utilisable dans ce contexte !');
End;


// Cette Procedure set à 2 chose :
// Elle permet d'exclure une liste supplémentaire de compte
// et elle accorde La Table qui gere la liste des cpt utilisable dans AideCOmpte
Procedure TDMPlan.FiltrageAideCompteSurListe(ListeCptExclus:TStringList;EventFilterRecord: TFilterRecordEvent);
Begin

FiltrageDataSet(TaCompteListeUtil,DMPlan.TaCompte.Filter);

if ListeCptExclus <> nil then
DMPlan.ListeCptExclusAideCompte.Assign(ListeCptExclus)
else
DMPlan.ListeCptExclusAideCompte.Clear;


// On branche TaCompte.OnFilterRecord sur le gestionnaire
// d'évènement passé en paramètre, ( nil, pour ne rien avoir)!

DMPlan.TaCompte.Close;
DMPlan.TaCompte.OnFilterRecord:=EventFilterRecord;
DMPlan.TaCompte.Open;

// Si le gestionnaire d'évènement de TaCompte est <> nil, alors on branche
// TaCompteListeUtil.OnFilterRecord sur le gestionnaire d'évènement passé en paramètre,

// Sinon

// Si le gestionnaire d'évènement de TaCompte est nil, alors on peut brancher
// TaCompteListeUtil.OnFilterRecord sur son gestionnaire d'évènement courant qui permet
// de n'obtenir que les compte utilisables lors de la saisie d'un compte

if @EventFilterRecord <> nil then
 begin
  TaCompteListeUtil.Close;
  TaCompteListeUtil.OnFilterRecord:=EventFilterRecord;
  TaCompteListeUtil.Open;
 end
  else
  begin
   TaCompteListeUtil.Close;
   TaCompteListeUtil.OnFilterRecord:=TaCompteListeUtilFilterRecord;
   TaCompteListeUtil.Open;
  end;
End;

function TDMPlan.FiltrageAideCompte(Famille:integer;ListeCptExclus:TStringList;EventFilterRecord: TFilterRecordEvent):TStringlist;
var
ListeCpt:TStringList;
begin
try
result:=TStringList.Create;
if Famille <> 0 then
 begin
   ListeCpt:=TStringList.Create;
   ListeCpt:=FiltrageParamCPT(Famille,e.Regime);
   FiltrageDataSet(DMPlan.TaCompte,CreeFiltreOU('Compte',[ListeCpt]));
   Initialise_TStringlist(Listecpt);
//   ListeCpt.Free;
 end
 else
 begin
  FiltrageDataSet(DMPlan.TaCompte,''); //On filtre mais on affiche tous les éléments
 end;
FiltrageAideCompteSurListe(ListeCptExclus,EventFilterRecord);
result:=ChampTableVersListe('Compte',dmplan.TaCompte);
except
end;
end;

//******************* FiltrageParamCPT *************************
//
//Filtrage de la table paramcpt d'après la famille et le régime
// et récupération du résultat dans une liste
//
//*************************************************************************
function TDMPlan.FiltrageParamCPT(Famille:integer;Regime:string):TStringList;
var
//TableParamCpt:ttable;
CptAux:string;
begin
try
result:=TStringList.Create;
 if Famille <> 0 then
 begin
//  TableParamCpt:=TTable.Create(self);
//  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
//  TableParamCpt.TableName:=TaParamCpt.TableName;

//  TableParamCpt.Filtered:=false;
//  FiltrageDataSet(TableParamCpt,CreeFiltreET(['Famille','Regime'],[inttostr(Famille),Regime]));
{ isa  le  17/08/04 }
  FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime'],[inttostr(Famille),Regime]));

//  TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime'],[inttostr(Famille),Regime]);
//  TableParamCpt.Filtered:=true;
  // Filtrage de la table param pour le contexte en cours
//  FiltrageDataSet(TaParamCptAideCpt,TableParamCpt.Filter);
  { isa  le  17/08/04 }
  FiltrageDataSet(TaParamCptAideCpt,DMRech_Obj.TaParamcpt_Obj.Filter);
//  TaParamCptAideCpt.filter:=TableParamCpt.Filter;
//  TaParamCptAideCpt.Filtered:=true;

  DMRech_Obj.TaParamcpt_Obj.Open;
  DMRech_Obj.TaParamcpt_Obj.First;
  result.Duplicates:=dupIgnore;
  result.Sorted:=true;
  while not  DMRech_Obj.TaParamcpt_Obj.EOF  do
     begin
      CptAux:=DMRech_Obj.TaParamcpt_Obj.findfield('Rac1').asstring;
      CptAux:=copy(CptAux,1,length(CptAux)-1);
          while length(CptAux)>0 do
          begin
              result.Add(CptAux);
             CptAux:=copy(CptAux,1,length(CptAux)-1);
          end;
     result.Add(DMRech_Obj.TaParamcpt_Obj.findfield('Rac1').asstring+'*');
     DMRech_Obj.TaParamcpt_Obj.Next;
     end;

 end
 else
 begin
  DeFiltrageDataSet(TaParamCptAideCpt);
//  TaParamCptAideCpt.filter:='';
//  TaParamCptAideCpt.Filtered:=false;
 end;
finally
  DeFiltrageDataSet(DMRech_Obj.TaParamcpt_Obj);
//  TableParamCpt.close;
//  TableParamCpt.free;
end;
end;

procedure TDMPlan.FiltrageAideCompteSurCompte(Famille:integer;Compte:string;ListeCptExclus:TStringList;EventFilterRecord: TFilterRecordEvent);
var
ListeCpt:TStringList;
begin
if Famille <> 0 then
 begin
   ListeCpt:=TStringList.Create;
   ListeCpt:= DMPlan.FiltrageParamCPTSurCompte(Famille,Compte,e.Regime);
   FiltrageDataSet(DMPlan.TaCompte,CreeFiltreOU('Compte',[ListeCpt]));
   Initialise_TStringlist(ListeCpt);
   //ListeCpt.Free;
 end
 else
 begin
  FiltrageDataSet(DMPlan.TaCompte,''); //On filtre mais on affiche tous les éléments
 end;
FiltrageAideCompteSurListe(ListeCptExclus,EventFilterRecord);
end;


function TDMPlan.FiltrageParamCPTSurCompte(Famille:integer;Compte,Regime:string):TStringList;
var
//TableParamCpt:ttable;
i:integer;
CptAux:string;
begin
try
  result:=TStringList.Create;
 if Famille <> 0 then
 begin
//  TableParamCpt:=TTable.Create(self);
//  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
//  TableParamCpt.TableName:=TaParamCpt.TableName;
  FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]));
  while (DMRech_Obj.TaParamcpt_Obj.RecordCount=0) and (length(compte)>0) do
     begin
      compte:=copy(compte,1,length(compte)-1);
      FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]));
     end;
  // Filtrage de la table param pour le contexte en cours
  FiltrageDataSet(TaParamCptAideCpt,DMRech_Obj.TaParamcpt_Obj.Filter);
//  TaParamCptAideCpt.filter:=TableParamCpt.Filter;
//  TaParamCptAideCpt.Filtered:=true;
   for I:=4 to 8 do
   begin
   if not (empty(DMRech_Obj.TaParamcpt_Obj.Fields[i].asstring)) then
    begin
       result.Add(DMRech_Obj.TaParamcpt_Obj.Fields[i].asstring+'*');
      CptAux:=copy(DMRech_Obj.TaParamcpt_Obj.Fields[i].asstring,1,length(DMRech_Obj.TaParamcpt_Obj.Fields[i].asstring)-1);
          while length(CptAux)>0 do
          begin
              result.Add(CptAux);
             CptAux:=copy(CptAux,1,length(CptAux)-1);
          end;
     end;
   end;
 end
 else
 begin
  DeFiltrageDataSet(TaParamCptAideCpt);
//  TaParamCptAideCpt.filter:='';
//  TaParamCptAideCpt.Filtered:=false;
 end;
finally
  DeFiltrageDataSet(DMRech_Obj.TaParamcpt_Obj)
//  TableParamCpt.Free;
end;
end;

//****************************************************************************//

function TDMPlan.FiltrageParamCPTSurComptePourOD(Famille,Nb:integer;Compte,Regime:string):tstringlist;
var
//TableParamCpt:ttable;
i:integer;
cpttemp:string;
begin
try
  try
  result:=TStringList.Create;

//  TableParamCpt:=TTable.Create(self);
//  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
//  TableParamCpt.TableName:=TaParamCpt.TableName;
//  TableParamCpt.Filtered:=false;
  FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]));
//  TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]);
//  TableParamCpt.Filtered:=true;
  DMRech_Obj.TaParamcpt_Obj.Open;
  CptTemp:=compte;
  while (DMRech_Obj.TaParamcpt_Obj.RecordCount=0) and (length(compte)>0) do
     begin
      CptTemp:=copy(CptTemp,1,length(CptTemp)-1);
//      TableParamCpt.Filtered:=false;
//      TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,CptTemp]);
//      TableParamCpt.Filtered:=true;
      FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,CptTemp]));
     end;
   for I:=4 to 4+Nb-1 do
   begin
   if not (empty(DMRech_Obj.TaParamcpt_Obj.Fields[i].asstring)) then
       result.add(DMRech_Obj.TaParamcpt_Obj.Fields[i].asstring+copy(compte,length(cpttemp)+1,length(compte)-length(cpttemp)));
   end;
   except
   showmessage('Problème à la récupération du compte de variation !!! ');
   abort;
   end;//fin du try
finally
DeFiltrageDataSet(DMRech_Obj.TaParamcpt_Obj);
//  TableParamCpt.close;
//  TableParamCpt.free;
end;
end;

Function TDMPlan.CptDevenirAmortissable(Cpt:string):boolean;
Var
ListeFiltreCptAmort:TStringList;
Begin
result:=false;
ListeFiltreCptAmort:=TStringList.Create;
QuCptAmort.Close;
QuCptAmort.ParamByName('Regi').AsString:=E.Regime;
QuCptAmort.ParamByName('CptGenere').AsString:='28%';
QuCptAmort.ParamByName('Fami').AsInteger:=100;
QuCptAmort.Open;
QuCptAmort.First;
While not QuCptAmort.EOF do
 Begin
   ListeFiltreCptAmort.Add(QuCptAmort.findField('Rac1').AsString);
   // SI cpt contient le numero de cpt de Rac1 alors
   // Cpt est un compte amortissable
   if not result then
   result:=(pos(QuCptAmort.findField('Rac1').AsString,cpt)=1);
   QuCptAmort.Next;
 End;

//ListeFiltreCptAmort:=FiltrageParamCPT(

QuCptAmort.Close;
Initialise_TStringlist(ListeFiltreCptAmort);
//ListeFiltreCptAmort.Free;
End;
//****************************************************************************//

Function TDMPlan.CptEstAmortissable(Cpt:string):TTypeImmo;
Begin
    result.Amortissable:=false;
    result.Degressif:=false;
  try
  if GrLocate(DMRech.TaPlanCptRech,'Compte',[cpt]) then
   begin
     result.Amortissable:=DMRech.TaPlanCptRech.FindField('ImmoAmort').asboolean;
     result.Degressif:=DMRech.TaPlanCptRech.FindField('ImmoDegressif').asboolean;
   end;
  except
    result.Amortissable:=false;
    result.Degressif:=false;
    abort;
  end;
End;

//****************************************************************************//
// Retour vrai si un compte peut recevoir un code Tva
// Si Retour=Vrai alors retourne aussi la liste des code TVA Autorisé
//****************************************************************************//
Function TDMPlan.TvaCodePourCompte(Famille:integer;Regime,Compte:string):TTvaCodePourCompte;
begin
result.ListeCode:=TStringList.Create;
result.ListeCode.Clear;
result.ListeCompteTVA:=TStringList.Create;
result.ListeCompteTVA.Clear;
result.ListeClasse:=TStringList.Create;
result.ListeClasse.Clear;
if empty(compte) then
   begin
    result.Retour:=false;
    exit;
   end
   else
   begin
     if compte[1] in ['1','3','4','5'] then
        begin
         result.Retour:=false;
         exit;
        end;
     ChampObligatoire(Compte,ListeChamp);
     if ListeChamp.IndexOf('TvaCode') <> -1 then
         Begin
           result.Retour:=True;
           case strtoint_lgr(compte[1]) of
              2:Begin
                  Result.ListeClasse.Add('I');
                  Result.ListeClasse.Add('C');
                  Result.ListeClasse.Add('M');
                  Result.ListeClasse.Add('N');
                End;
              6:Begin
                  Result.ListeClasse.Add('A');
                  Result.ListeClasse.Add('C');
                  Result.ListeClasse.Add('N');
                  Result.ListeClasse.Add('M');
                  // denis le 25-06-03
                  if ((str_n_prem_char(Compte,3) = '609') or (str_n_prem_char(Compte,3) = '665')
                  or (str_n_prem_char(Compte,3) = '654')
                  or (str_n_prem_char(Compte,3) = '664')
                  or (str_n_prem_char(Compte,4) = '6714')) then
                   Begin
                     Result.ListeClasse.Add('V');
                     Result.ListeClasse.Add('L');
                     Result.ListeClasse.Add('E');
                   End;
                End;
              7:Begin
                  Result.ListeClasse.Add('V');
                  Result.ListeClasse.Add('L');
                  Result.ListeClasse.Add('E');
                  Result.ListeClasse.Add('N');
                  Result.ListeClasse.Add('F');
                  Result.ListeClasse.Add('T');
                  // denis le 25-06-03
                  if ((str_n_prem_char(Compte,3) = '709') or (str_n_prem_char(Compte,3) = '765')) then
                   Begin
                     Result.ListeClasse.Add('A');
                     Result.ListeClasse.Add('C');
                     Result.ListeClasse.Add('M');
                   End;
                End;
           end;
         End
         else
         begin
           result.Retour:=false;
         end;
     end;
if result.ListeClasse.Count <> 0 then
   Begin
       if (DMTVACode = nil) then DMTVACode:=TDMTVACode.Create(application.MainForm);
       FiltrageDataSet(DMTVACode.TaTvaCodeRec,CreeFiltreOU('Classe',[Result.ListeClasse]));
//       DMTVACode.TaTvaCodeRec.Filter:=CreeFiltreOU('Classe',[Result.ListeClasse]);
//       DMTVACode.TaTvaCodeRec.Filtered:=true;
       DMTVACode.TaTvaCodeRec.Open;
       DMTVACode.TaTvaCodeRec.first;
       while not DMTVACode.TaTvaCodeRec.EOF do
             Begin
              result.ListeCode.Add(UpperCase(DMTVACode.TaTvaCodeRec.findfield('TvaCode').AsString));
              result.ListeCompteTVA.Add(UpperCase(DMTVACode.TaTvaCodeRec.findfield('Compte').AsString));
              DMTVACode.TaTvaCodeRec.Next;
             End;
       DeFiltrageDataSet(DMTVACode.TaTvaCodeRec);
//       DMTVACode.TaTvaCodeRec.Filter:='';
//       DMTVACode.TaTvaCodeRec.Filtered:=false;
       DMTVACode.TaTvaCodeRec.Close;
   End;
//ListeChampOKTva.Free;
//NettoieListeChOblig(ListeChampOKTva);
//  try
//  result.ListeCode:=TStringList.Create;
//  TableParamCpt:=TTable.Create(self);
//  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
//  TableParamCpt.TableName:=TaParamCpt.TableName;
//  TableParamCpt.Filtered:=false;
//  TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]);
//  TableParamCpt.Filtered:=true;
//  TableParamCpt.Open;
//  CptAux:=Compte;
//  if length(compte)<=2 then result.Retour:=false
//  else
//  Repeat
//    result.Retour:=TaParamCptAideCpt.locate('Rac1',Compte,[]);
//    CptAux:=copy(Compte,1,length(Compte)-1);
//    TableParamCpt.Filtered:=false;
//    TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,CptAux]);
//    TableParamCpt.Filtered:=true;
//  Until ((result.Retour=true) or (length(CptAux)=0));
//  if Result.Retour then
//  for i:=2 to 4 do
//      begin
//       if TaParamCptAideCpt.locate('Rac'+inttostr(i),'*',[]) then
//       case i of
//          2:result.ListeCode.Add('V');
//          3:begin
//            result.ListeCode.Add('A');
//            result.ListeCode.Add('C');
//            end;
//          4:result.ListeCode.Add('I');
//       end;
//      end;
//   except
//   showmessage('Problème à la récupération des comptes de TVA !!! ');
//   abort;
//   end;//fin du try

end;

//****************************************************************************//
//                       Ouverture des tables                                 //
//****************************************************************************//
procedure TDMPlan.DMPlanCreate(Sender: TObject);
var
i:integer;
begin
  ListeChamp:=TStringList.Create;
  ListeChampOblig:=TStringList.Create;
  ListeCptOkBO:=TStringList.Create;
  ListeCompteJournaux:=TStringList.Create;
  ListeNonModifDsBO:=TStringList.Create;
  ListeCptExclusAideCompte:=TStringList.Create;
  ListeCptReduitAideCompte:=TStringList.Create;
  ListeEdit:=TStringList.Create;
  ListeCptExclusPointage:=TStringlist.Create;

  TaCompte.OnFilterRecord:=TaCompteFilterRecord;{ isa  le  26/08/04 }

  //ListeCompteEnCoursDeSaisie:=TStringList.Create;
  for i:=0 to 26 do ListeChamp.Add('');
  for i:=0 to 26 do ListeChampOblig.Add('');
  Initialise_TInfosplancpt(DernierComptePost);
  Initialise_TInfosplancpt(DernierCompteSupprime);
  Initialise_TInfosplancpt(DernierCompteSupprimetmp);
case E.TypeDossier of
  VerAgricole:begin
//                GestionDesComptesObligatoireDsPlanCpt(false);
              end;
  VerDiocese:begin

              end;

end;

end;
//******************************************************************************


//****************************************************************************//
//******************************************************************************
//******************* TDMPlan.DMPlanDestroy ************************************
//******************************************************************************
//******************************************************************************
//                           Fermeture des tables                             //
//****************************************************************************//
//******************************************************************************
//******************************************************************************
procedure TDMPlan.DMPlanDestroy(Sender: TObject);
begin
  Initialise_TStringlist(ListeChamp);
  Initialise_TStringlist(ListeChampOblig);
  Initialise_TStringlist(ListeCptOkBO);
  Initialise_TStringlist(ListeCompteJournaux);
  Initialise_TStringlist(ListeNonModifDsBO);
  Initialise_TStringlist(ListeCptExclusAideCompte);
  Initialise_TStringlist(ListeCptReduitAideCompte);
  Initialise_TStringlist(ListeCompteEnCoursDeSaisie);
  Initialise_TStringlist(ListeEdit);
  Initialise_TStringlist(ListeCptExclusPointage);
  if TaCompte<>nil then
    TaCompte.OnFilterRecord:=nil;
  FermerTouteTable('',TControl(self));
  DMPlan:=nil;
end;


//******************************************************************************
//******************************************************************************
//******************* TDMPlan.NettoieListeChOblig *************************
//******************************************************************************
//******************************************************************************
// Vide la liste des champ obligatoire établie pour la saisie d'un compte
// Compte et libelle sont toujours obligatoire
//******************************************************************************
//******************************************************************************
//******************************************************************************
Procedure TDMPlan.NettoieListeChOblig(var Liste:TStringList);
var
i:integer;
begin
  for i:=2 to 26 do Liste.Strings[i]:='';
  Liste.Strings[0]:='Compte';
  Liste.Strings[1]:='Libelle';
  Liste.Strings[11]:='ID_Affichage';
  Liste.Strings[12]:='Pointable';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
  Liste.Strings[0]:='Compte';
end;
//******************************************************************************


//******************************************************************************
//******************************************************************************
//******************* TDMPlan.PereCompte *************************
//******************************************************************************
//******************************************************************************
//  Retourne le premier ancêtre valide ou lui-même si pas d'ancêtre ds
//  le plan comptable général
//****************************************************************************//
//******************************************************************************
//******************************************************************************
function TDMPlan.PereCompte(cpte:string):string;
begin
  DefiltrageDataSet(DMRech.TaPlanCPTERech);
  if not DMRech.TaPlanCPTERech.Active then DMRech.TaPlanCPTERech.Open;
  while ((not DMRech.TaPlanCPTERech.Locate('Regime;Compte', VarArrayOf([E.Regime,cpte]), [LoCaseInsensitive]))
  // with TaPlanCpte do
  //   begin
  //     while ((not Locate('Regime;Compte', VarArrayOf([E.Regime,cpte]), [LoCaseInsensitive]))
        and (length(Cpte)>0)) do
        Cpte:=copy(Cpte,1,length(cpte)-1);
       result:=Cpte;
  //   end;
end;
//******************************************************************************

//******************************************************************************
//******************************************************************************
//******************* TDMPlan.PereCompte *************************
//******************************************************************************
//******************************************************************************
//  Retourne le premier ancêtre valide ds
//  le plan comptable utilisateur
//****************************************************************************//
//******************************************************************************
//******************************************************************************
function TDMPlan.PereComptePCU(cpte:string):string;
begin
  result:='1';
  DefiltrageDataSet(DMRech.TaPlanCPTRech);
  if not DMRech.TaPlanCPTRech.Active then DMRech.TaPlanCPTRech.Open;
  Cpte:=copy(Cpte,1,length(cpte)-1);
  while ((not DMRech.TaPlanCPTRech.Locate('Compte', cpte, [])) and (length(Cpte)>0)) do
        Cpte:=copy(Cpte,1,length(cpte)-1);
  result:=Cpte;
end;
//******************************************************************************

//******************************************************************************
//******************************************************************************
//******************* TDMPlan.CompteExistePCU *************************
//******************************************************************************
//******************************************************************************
//             Verifie si Cpte existe ou non dans le plan utilisateur         //
//******************************************************************************
//******************************************************************************
//******************************************************************************
function TDMPlan.CompteExistePCU(Cpte:string):boolean;
begin
  DefiltrageDataSet(DMRech.TaPlanCptRech);
  Result:=DMRech.TaPlanCptRech.Locate('Compte',Cpte,[]);
end;
//******************************************************************************


//******************************************************************************
//******************************************************************************
//******************* TDMPlan.PossedeFils *************************
//******************************************************************************
//****************************************************************************//
//                Vérifie si cpte possede des subdivisions dans le plan Utilisateur
//******************************************************************************
//******************************************************************************
//****************************************************************************//
Function TDMPlan.PossedeFils (cpte : string): boolean;
begin
  Result := false;
  if Length(Cpte) < 8 then
   begin
    FiltrageDataSet(DMRech.TaPlanCptRech,'Compte = '''+Cpte+'*'' and compte <> '''+Cpte+'''');
    result:=DMRech.TaPlanCptRech.RecordCount > 0 ;
    DeFiltrageDataSet(DMRech.TaPlanCptRech);
   end;
End;
//******************************************************************************


//******************************************************************************
//******************************************************************************
//******************* TDMPlan.PossedeFrereCptGene *************************
//******************************************************************************
//****************************************************************************//
//                  Vérifie si un compte possède des frères dans le PCG       //
//****************************************************************************//
//******************************************************************************
//******************************************************************************
Function TDMPlan.PossedeFrereCptGene(Cpte : string) : boolean;
var
  CptFrere : string;
  i:integer;
begin
  Result := false;
  with TaPlanCpte do
      begin
        IndexFieldNames:='Regime;Compte';
        for i:=1 to 9 do
          begin
           CptFrere:=copy(Cpte,1,length(cpte)-1)+inttostr(i);
           if Locate('Regime;Compte', VarArrayOf([E.Regime,CptFrere]), []) then result:=true;
          end;
      end;
end;
//******************************************************************************


//****************************************************************************//
//******************************************************************************
//******************* TDMPlan.PossedePereNonPrevu *************************
//****************************************************************************//
//******************************************************************************
//  Vérifie si cpte possède un pere dans le PCU non prevu dans le PCG         //
//****************************************************************************//
//******************************************************************************
//****************************************************************************//
Function TDMPlan.PossedePereNonPrevu(Cpte : string) : boolean;
begin
  Result := false;
  DefiltrageDataSet(DMRech.TaPlanCptRech);
  TableRefresh(DMRech.TaPlanCptRech,'Compte');
  repeat
    Cpte:=copy(Cpte,1,length(cpte)-1);           
    result:=not VerifComptePCG(Cpte);
    //empty( CpteRech)or à rajouter si okj pour denis
  until (DMRech.TaPlanCptRech.Locate('Compte',Cpte,[]));
end;
//******************************************************************************


//******************************************************************************
//******************************************************************************
//******************* TDMPlan.VerifComptePCG *************************
//******************************************************************************
//****************************************************************************//
//  Vérifie si un compte existe et ne possède pas de frères dans le PCG       //
//****************************************************************************//
//******************************************************************************
//******************************************************************************
Function TDMPlan.VerifComptePCG(cpte : string) : boolean;
var
   CpteRech : string;
begin
  if not TaPlanCpte.Active then TaPlanCpte.Open;
  CpteRech:=Cpte;
  if (TaPlanCpte.Locate('Regime;Compte', VarArrayOf([E.Regime,CpteRech]), [])) then
   Begin
   	Result := True
   End
   Else
   Begin
     repeat
      result:=not PossedeFrereCptGene(CpteRech);
      CpteRech:=copy(CpteRech,1,length(CpteRech)-1);
      //empty( CpteRech)or à rajouter si okj pour denis
     until (TaPlanCpte.Locate('Regime;Compte', VarArrayOf([E.Regime,CpteRech]), []));
   End;
end;
//****************************************************************************//


//****************************************************************************//
//****************************************************************************//
//******************* TDMPlan.PossedeEcriture *************************
//****************************************************************************//
//****************************************************************************//
//                Vérifie si cpte possede des écritures                       //
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
Function TDMPlan.PossedeEcriture (cpte : string): boolean;
Begin
  if not TaEcriture.Active then TaEcriture.Open;
  Result:=false;
  if length(cpte) > 0 then
     if cpte[1]='+' then
      begin
       with TaEcriture do
         begin
          IndexFieldNames:='Tiers';
          Result:=Locate('Tiers',cpte,[]);
         End;
      end
      else
      begin
        with TaEcriture do
          begin
            IndexFieldNames:='Compte';
            Result:=Locate('Compte',cpte,[]);
          End;
      end;
end;
//****************************************************************************//

//****************************************************************************//
//****************************************************************************//
//******************* TDMPlan.PossedeEcriture *************************
//****************************************************************************//
//****************************************************************************//
//  Vérifie si cpte possede des écritures directment sur le compte désigné    //
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
Function TDMPlan.PossedeEcritureDirect(cpte : string): boolean;
Begin
  DeFiltrageDataSet(TaEcriture);
  if not TaEcriture.Active then TaEcriture.Open;
  Result:=false;
  if length(cpte) > 0 then
     if cpte[1]='+' then
      begin
       with TaEcriture do
         begin
          IndexFieldNames:='Tiers';
          Result:=Locate('Tiers',cpte,[]);
         End;
      end
      else
      begin
        with TaEcriture do
          begin
            FiltrageDataSet(TaEcriture,'Compte = '''+Cpte+''' and Tiers = ''''');
            IndexFieldNames:='Compte';
            Result:=Locate('Compte',cpte,[]);
            DeFiltrageDataSet(TaEcriture);
          End;
      end;
end;

//****************************************************************************//

//****************************************************************************//
//****************************************************************************//
//******************* TDMPlan.LibelleDuNumCpt *************************
//****************************************************************************//
//****************************************************************************//
//        Retourne le libelle du cpte ou de son pere direct du plan général   //
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
function TDMPlan.LibelleDuNumCpt(Cpte:string):string;
begin
  result:='';
  Cpte:=PereCompte(Cpte);
  DeFiltrageDataSet(DMRech.TaPlanCPTERech);
  if not DMRech.TaPlanCPTERech.Active then DMRech.TaPlanCPTERech.open;
  if DMRech.TaPlanCPTERech.Locate('Regime;Compte', VarArrayOf([E.Regime,cpte]), [LoCaseInsensitive])then
    result:=DMRech.TaPlanCPTERech.findfield('Libelle').AsString;
end;
//****************************************************************************//



//****************************************************************************//
//****************************************************************************//
//******************* TDMPlan.LibelleDuNumCptPCU *************************
//****************************************************************************//
//****************************************************************************//
//        Retourne le libelle du cpte ou de son pere direct du plan Utilisateur
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
function TDMPlan.LibelleDuNumCptPCU(Cpte:string):string;
var
InfosPlanCpt:TInfosPlanCpt;
Compte:String;
Begin
  result:='Compte';
  DeFiltrageDataSet(DMRech.TaPlanCptRech);
  InfosPlanCpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[cpte]);
  if InfosPlanCpt.ResultInfos then
   result:=InfosPlanCpt.Libelle
   else
   begin
     Compte:=PereComptePCU(cpte);
     InfosPlanCpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Compte]);
     if InfosPlanCpt.ResultInfos then
       result:=InfosPlanCpt.Libelle;

   end;
end;
//****************************************************************************//


//****************************************************************************//
//****************************************************************************//
//******************* TDMPlan.NumCompte *************************
//****************************************************************************//
//****************************************************************************//
//  Retourne un numéro de compte valide fonction de ce que contient cpt
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
Function TDMPlan.NumCompte(Cpt : String) : String;
Var
i :Integer;
AutreChar:boolean;
Begin
   Result:= '';
   AutreChar:=false;
   if cpt<>'' then
   For i:= 1 to Length(Cpt) do
   begin
      case i of
         1:begin
             case ord(cpt[i]) of
                48:begin {0}
                     Application.messagebox(Pchar('Vous avez saisi : '+cpt+' .'+#10#13#10#13+'Les numéros du plan comptable ne peuvent pas commencer par 0.'),'Erreur de saisie',0);
                     abort;
                   end ;

                56,57:begin {8,9}
                       Application.messagebox(Pchar('Vous avez saisi : '+cpt+' .'+#10#13#10#13+'Ces numéros du plan comptable ne sont pas encore prévu.'),'Erreur de saisie',0);
                       abort;
                      end  ;
             else
               if (Cpt[i] in ['0'..'9']) then Result:= Result + Cpt[i] else AutreChar:=true;
             end;
           end;
      else
   	 if (Cpt[i] in ['0'..'9']) then Result:= Result + Cpt[i] else AutreChar:=true;
      end;
   end;
   if AutreChar then Application.MessageBox(PChar('Seul les chiffres sont autorisés pour les comptes du plan comptable'),'Erreur de saisie',0);
End;

//****************************************************************************//
Function TDMPlan.ListePlanCptPouvantDevenirPointable:TStringList;
begin
Result:=TStringList.Create;
FiltrageDataSet(DMRech.TaPlanCptRech,'Compte = ''4*'' and Compte <> ''445*''');
DMRech.TaPlanCptRech.First;
ChampTableVersVarListe('Compte',DMRech.TaPlanCptRech,Result);
DeFiltrageDataSet(DMRech.TaPlanCptRech);
end;

Function TDMPlan.CptDevenirPointable(Cpt:string):boolean;
Var
ListeTmp:TStringlist;
Infosplancpt:TInfosplancpt;
Begin
try
  ListeTmp:=TStringlist.Create;
  Initialise_TStringlist(ListeCptExclusPointage,DMPlan,false);{ isa  le  24/08/04 }
//  if ListeCptExclusPointage = nil then
//    ListeCptExclusPointage:=TStringlist.Create
//    else ListeCptExclusPointage.Clear;
  ListeCptExclusPointage:=FiltrageParamCPT(23,e.Regime);
  ListeTmp:=FiltrageParamCPT(42,e.Regime);
  //AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeTmp]),true);
  //aidecompte.InitialiseCompte;
//  FiltrageDataSet(DMRech.TaPlanCptRech,CreeFiltreOU('Compte',[ListeTmp]));
  //result:=((not CptTiers(cpt)) and VerifIfExist(TaPlanCptRecherche,'Compte',Cpt) and (not PossedeEcriture(cpt)) and (length(Cpt) > 2));

//  result:=((not CptTiers(cpt)) and Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[cpt]).ResultInfos and (not PossedeEcriture(cpt)) and (length(Cpt) > 2));
  result:=(length(Cpt) > 2);
  // ListeTmp contient la racine des comptes pouvant devenir pointable !
  if result then result:=ListeTmp.IndexOf(copy(cpt,1,2)+'*') <> -1;
  if result then
    begin
      result:=ListeCptExclusPointage.IndexOf(copy(cpt,1,3)+'*') = -1;
      if result then result:=ListeCptExclusPointage.IndexOf(copy(cpt,1,3)) = -1;
    end;
  if result then
   begin
    DeFiltrageDataSet(DMRech.TaPlanCptRech);
    Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[cpt]);
    if Infosplancpt.ResultInfos then
    result:=((Infosplancpt.Debit_Deb = 0) and (Infosplancpt.Credit_Deb = 0));
   end;
finally
  Initialise_TStringlist(ListeTmp);
//  ListeTmp.Free;
end;//fin du try finally
End;

//****************************************************************************//
Function TDMPlan.CptEstPointable(Cpt:string):boolean;
var
InfosPlanCpt:TInfosPlanCpt;
Begin
result:=false;
DeFiltrageDataSet(DMRech.TaTiersRech);
DeFiltrageDataSet(DMRech.TaPlanCptRech);
  try
  if str_commence_par(cpt,'+') then
   begin
     result:=Infos_TInfosTiers(DMRech.TaTiersRech,'Tiers',[cpt]).ResultInfos;
//     result:=VerifIfExist(DMTiers.TaTiers,'Tiers',Cpt);
   end
   else
   begin
     InfosPlanCpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[cpt]);
     if InfosPlanCpt.ResultInfos then
      result:=((InfosPlanCpt.pointable) and (not(InfosPlanCpt.Collectif)));
//    if result then result:=Pointable.AsBoolean and not Collectif.AsBoolean;
//     if TaPlanCptRecherche.Locate('Compte',cpt,[])then
//       result:=((TaPlanCptRecherche.FindField('Pointable').asboolean)and(not TaPlanCptRecherche.FindField('collectif').asboolean));
   end;
  except
    result:=false;
    abort;
  end;
End;


//****************************************************************************//
Function TDMPlan.CptTiers(Cpt:string):boolean;
var
InfosPlanCpt:TInfosPlanCpt;
Begin
  DeFiltrageDataSet(DMRech.TaPlanCptRech);
  result:=false;
  InfosPlanCpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[cpt]);
  if InfosPlanCpt.ResultInfos then
     result:=InfosPlanCpt.Tiers;
End;

Function TDMPlan.CptEstCollectif(Cpt:String):Boolean;
var
InfosPlanCpt:TInfosPlanCpt;
Begin
  DeFiltrageDataSet(DMRech.TaPlanCptRech);
  result:=false;
  InfosPlanCpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[cpt]);
  if InfosPlanCpt.ResultInfos then
     result:=InfosPlanCpt.Collectif;
End;
//****************************************************************************//
Function TDMPlan.CreationCpt(CCourant:Tfield):TErreurSaisie;
var
CptTmp,cptTest:string;
//Infosplancpt:TInfosPlanCpt;
//InfosPlanCPTE:TInfosPlanCPTE;
begin
// Si l'utilisateur est en mode insertion

if CCourant.DataSet.State in [dsinsert] then
  begin
  CreationCpt.CodeErreur:=0;
  CreationCpt.Retour:=true;
  case CCourant.FieldNo of
     1:begin
        CCourant.AsString:=NumCompte(CCourant.AsString);
        if empty(CCourant.AsString) then
         begin //Numéro de compte vide
          CreationCpt.CodeErreur:=1000;
          CreationCpt.Retour:=false;
          Application.Messagebox(Pchar('Le numéro de compte est obligatoire !'),'Erreur de saisie',0);
         end
         else
         begin
          if CompteExistePCU(CCourant.AsString) then
           begin  //Numéro de compte existe déjà dans le plan utilisateur
            CreationCpt.CodeErreur:=1001;
            CreationCpt.Retour:=false;
            Application.MessageBox(Pchar('Ce compte existe déjà dans le plan comptable.'),'Erreur de saisie',0);
            //            Erreur('Reference','Doublon');
           end
           else
           begin  //Numéro de compte Valide
           if ((not VerifComptePCG(CCourant.AsString)) and (not PossedePereNonPrevu(CCourant.AsString))) then
            begin
             if messagedlg(PChar('Êtes-vous sûr de vouloir créer le compte : '+CCourant.AsString+' ? '+#10#13#10#13+'Ce compte n''est pas prévu dans le plan comptable général,'),mtconfirmation, [mbno,mbyes],0) = mryes then
              begin
               CptTmp:=CCourant.AsString;
               if DernierNumCptValideEnInsert <> CCourant.AsString then
                begin
//                   CCourant.dataset.ClearFields;
                   InitialiseInsertionCompte(CCourant.AsString,CCourant.DataSet);
//                   InitChampAfterInsert([nil,nil,nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],CCourant.Dataset);
                end;
                 CCourant.AsString:=CptTmp;
                 //affectation du libellé par défaut
                 if(CCourant.DataSet.findField('Libelle').Value='')then CCourant.DataSet.findField('Libelle').Value:=LibelleDuNumCpt(CCourant.AsString);
                 //Création de la liste des champs obligatoire pour ce numéro de cpte dans AfterScroll
//                 ChampObligatoire(CCourant.AsString,ListeChampOblig);
                   if @CCourant.DataSet.AfterScroll <> nil then
                       CCourant.DataSet.AfterScroll(CCourant.DataSet);
              end
              else
              begin
               CreationCpt.CodeErreur:=1002;
               CreationCpt.Retour:=false;
              end;
            end
            else
            begin
              CptTmp:=CCourant.AsString;
               if DernierNumCptValideEnInsert <> CCourant.AsString then
                begin
//                   CCourant.dataset.ClearFields;
                   InitialiseInsertionCompte(CCourant.AsString,CCourant.DataSet);
                 //  InitChampAfterInsert([nil,nil,nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],CCourant.Dataset);
                   CCourant.AsString:=CptTmp;
                   //affectation du libellé par défaut
                   CCourant.DataSet.findField('Libelle').Value:=LibelleDuNumCpt(CCourant.AsString);
                   //Création de la liste des champs obligatoire pour ce numéro de cpte dans AfterScroll
//                 ChampObligatoire(CCourant.AsString,ListeChampOblig);
                   if @CCourant.DataSet.AfterScroll <> nil then
                       CCourant.DataSet.AfterScroll(CCourant.DataSet);
               end;
            end;
           end;
         end;
       if result.Retour then
         begin
          CCourant.DataSet.findField('ID_Affichage').AsString:=CCourant.AsString;
         end;
       end;
     2:begin //Traitement libellé
        if empty(CCourant.AsString) then
         begin //Numéro de compte vide
          // Si le compte existe dans le PG
          if Infos_TInfosPlanCPTE(DMRech.TaPlanCpteRech,'Compte',[CCourant.DataSet.findField('Compte').AsString]).ResultInfos then
          begin
           CCourant.DataSet.findField('Libelle').Value:=Infos_TInfosPlanCPTE(DMRech.TaPlanCpteRech,'Compte',[CCourant.DataSet.findField('Compte').AsString]).Libelle;
          end
          else
          begin
           CCourant.DataSet.findField('Libelle').Value:=LibelleDuNumCpt(CCourant.DataSet.findField('Compte').AsString);
          end;
         end
         else
        if CCourant.AsString[1]='*' then
         begin //Si le libellé est = *, on affecte le libellé du pere CPU
          CptTmp:=PereComptePCU(CCourant.DataSet.findField('Compte').AsString);
          CCourant.DataSet.findField('Libelle').Value:=LibelleDuNumCptPCU(CptTmp);
         end

       end;
     10:begin // Traitement code tva
        if ListeChampOblig.IndexOf('TvaCode') <> -1 then
         begin
 //         if AideTvaCodeValide(CCourant.DataSet.findField('TvaCode').AsString,CCourant.DataSet.findField('Compte').AsString) then
          if TvaCodePourCompte(31,E.Regime,CCourant.DataSet.findField('Compte').AsString).Retour then
             begin
               if (empty(ccourant.asstring) or (TvaCodePourCompte(31,E.Regime,CCourant.DataSet.findField('Compte').AsString).ListeCode.IndexOf(UpperCase(CCourant.AsString)) <> -1)) then
                  begin
                    CreationCpt.CodeErreur:=0;
                    CreationCpt.Retour:=true;
                    ccourant.asstring:=UpperCase(ccourant.asstring);
//                    if not (empty(ccourant.asstring)) then
//                     begin
//                     if not Empty(CCourant.DataSet.findField('Compte').AsString) then
//                       Begin
//                        PereCompteAux:=DMPlan.PereComptePCU(CCourant.DataSet.findField('Compte').AsString);
//                        Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[PereCompteAux]);
//                        CCourant.DataSet.findField('TvaType').AsString:=Infosplancpt.TvaType;
//                        CCourant.DataSet.findField('TvaDebit').AsBoolean:=Infosplancpt.TvaDebit;
////                       end;
//
////                       CCourant.DataSet.findField('TvaType').AsString:=FTvaTypeTva(CCourant.DataSet.findField('Compte').AsString);
////                       CCourant.DataSet.findField('TvaDebit').AsBoolean:=CCourant.DataSet.findField('TvaType').AsString='D';
//                       end;
//                     end;
                  end
                  else
                  Begin
                    CreationCpt.CodeErreur:=4001;
                    CreationCpt.Retour:=false;
                  End;

             end
             else
             begin
                CreationCpt.CodeErreur:=4002;
                CreationCpt.Retour:=false;
             end;
         end
         else
         Begin
           CreationCpt.CodeErreur:=4003;
           CreationCpt.Retour:=false;
//           messagedlg('Ce numéro de compte ne peut pas être associé à un code de TVA', mtwarning, [mbok],0);
         End;
       end;
     12:begin //champ TvaDebit
        if CCourant.AsBoolean then
           TaPlanCpt.findField('TvaType').Value:='D'
         else
           TaPlanCpt.findField('TvaType').Value:='E';
       end;

     14:begin // Traitement Collectif
         if CCourant.AsBoolean = true then
          begin
          cptTest:=PereCompte(CCourant.DataSet.FindField('Compte').AsString);
            if ((CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteProduitARecevoirDefaut)
                or (CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteProduitConstateDAvance)
                or (CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteChargeConstateeDAvance)
                or (CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteChargeAPayerDefaut)
                or (CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteChargeARepartir)
                or (ListeContientDebutCpt(cptTest,9))
                or (ListeContientDebutCpt(cptTest,10))
                or (ListeContientDebutCpt(cptTest,11)))then
                           begin
                             Result.CodeErreur:=14004;
                             Result.retour:=false;
                             messagedlg('Vous ne pouvez pas rendre collectif un compte utilisable dans les écrans d''ouverture et de clôture !', mtwarning, [mbok],0);
                             CCourant.AsBoolean:=false;
                             CCourant.DataSet.FindField('Pointable').AsBoolean:=false;
                             abort;
                           end;
            CCourant.DataSet.FindField('Pointable').AsBoolean:=true;
            if not CreationCpt(CCourant.DataSet.FindField('Pointable')).retour then
             Begin
              Result.retour:=false;
              Result.CodeErreur:=14001;
              CCourant.AsBoolean:=false;
             End;
          end;

       end;

     // Traitement Tiers
     //*************************************************************************
     16:begin
       if CCourant.AsBoolean = true then
        begin
         CCourant.DataSet.FindField('Collectif').AsBoolean:=true;

           if not CreationCpt(CCourant.DataSet.FindField('Collectif')).retour then
            begin
              Result.CodeErreur:=16001;
              Result.retour:=false;
              CCourant.AsBoolean:=false;
            end;
        end;
       end;
     //*************************************************************************

     // Traitement Pointable
     //*************************************************************************
     27:begin
        if CCOurant.AsBoolean = true then
         if not CptDevenirPointable(CCourant.DataSet.FindField('Compte').AsString) then
            begin
              CCourant.AsBoolean:=false;
              CreationCpt.CodeErreur:=26000;
              CreationCpt.Retour:=false;
            end;
       end;
  end;

  end;
  end;

//****************************************************************************//
Function TDMPlan.SuppressionCpt(Cpte:string;DataSet:TDataSet;Mess:Boolean):TErreurSaisie;
begin
if DataSet.State in [dsBrowse] then
  begin
   Result.Retour:=true;
   Result.CodeErreur:=0;
   If length(DataSet.Fields[0].AsString) in [1..2] Then
      Begin // Compte Racine
        Result.Retour:=False;
        Result.CodeErreur:=2000;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString), MtWarning,[mbok],0);
      end
      else // Compte en cours d'utilisation
      if CompteEnCoursDeSaisie(DataSet.findField('Compte').AsString,nil) then
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2001;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte est en cours d''utilisation dans un écran de saisie !'),MtWarning,[mbok],0);
       end
       else
      if PossedeFils (cpte) then
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2001;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte possède des subdivisions.'),MtWarning,[mbok],0);
       end
       else  // COmpte qui possède des écritures
//       if PossedeEcriture (cpte) then //Possede des écritures
       if DetailEcritureCompte(cpte,false,False) then //Possede des écritures
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2002;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte possède des écritures.'),MtWarning,[mbok],0);
       end
       else  // COmpte qui existe dans la balances
       if CptExisteDansBalance(cpte) then //existe dans la balances
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2002;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte est actuellement utilisé.'),MtWarning,[mbok],0);
       end
       else  // COmpte qui existe dans les tiers
       if Infos_TInfosTiers(DMRech.TaTiersRech,'Compte',[cpte]).ResultInfos then
//       if DMTiers.VerifIfExist(DMtiers.TaTiersGest,'Compte',cpte) then
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2002;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+''),MtWarning,[mbok],0);
       end //
       else  // Compte qui appartient dans un journal
       if  AideModelCompteEstJournal(Cpte) then
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2002;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte est actuellement utilisé dans un journal'),MtWarning,[mbok],0);
       end
       else  // Compte qui possède un montant au débit dans le Bilan d'ouverture manuel
       if not VerifFNumeric(Dataset.FindField('Debit_Deb')).VideOUZero then
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2002;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte possède un solde débiteur de '+FormatCurr('0.00 '+E.DeviseSigle,Dataset.FindField('Debit_Deb').AsCurrency)+' dans le bilan d''ouverture manuel.'),MtWarning,[mbok],0);
       end
       else  // Compte qui possède un montant au Crédit dans le Bilan d'ouverture manuel
       if not VerifFNumeric(Dataset.FindField('Credit_Deb')).VideOUZero then
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2002;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte possède un solde de '+FormatCurr('0.00 '+E.DeviseSigle,Dataset.FindField('Credit_Deb').AsCurrency)+' dans le bilan d''ouverture manuel.'),MtWarning,[mbok],0);
       end
       else
       if DM_C_ListeCptObligatoire.IndexOf(Cpte) <> -1 then
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2005;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+''),MtWarning,[mbok],0);
       end
       else  // Compte généré
       if CompteGenere(cpte) then
       begin
       if VerifSiCptGenereEncoreLie(cpte) then
        begin
         Result.Retour:=False;
         Result.CodeErreur:=2003;
        end
        else
        begin
          Result.Retour:=true;
          Result.CodeErreur:=0;
        end;
        if Mess then
        if SuprCptAffiche(cpte,false,DataSet) then
           begin
              Result.Retour:=false;
              Result.CodeErreur:=2006;
           end;
       end
       else  // Compte générateur
       if CompteGenerateur(cpte) then
       begin
//       if VerifSiCptGenereEncoreLie(cpte) then
//        begin
//         Result.Retour:=False;
//         Result.CodeErreur:=2004;
//        end
//        else
//        begin
//          Result.Retour:=true;
//          Result.CodeErreur:=0;
//        end;
        Result.Retour:=False;
        Result.CodeErreur:=2004;
        if Mess then
        if SuprCptAffiche(cpte,true,DataSet) then
           begin
              Result.Retour:=false;
              Result.CodeErreur:=2006;
           end;
       end
       else
       if FTvaCompteDeTva(Cpte) then
       begin
        Result.Retour:=False;
        Result.CodeErreur:=2005;
        if Mess then
        Messagedlg(PChar('Impossible de supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte est utilisé comme compte de TVA.'),MtWarning,[mbok],0);
       end
       else
       if Mess then
       begin
          Case E.TypeEtatExercice of
           ET_Importation:begin
                                Result.Retour:=true;
                                Result.CodeErreur:=0;
                          end;
            ET_Normal:    begin
                             if Application.MessageBox(PChar('Êtes-vous sûr de vouloir supprimer le compte : '+cpte+' - '+DataSet.findField('Libelle').AsString+' ?'),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
                               begin
                                Result.Retour:=true;
                                Result.CodeErreur:=0;
                               end
                             else
                               begin
                                Result.Retour:=False;
                                Result.CodeErreur:=2100;
                               end;
                          end;
          end;//fin du case E.TypeEtatExercice
       end;
     end;
end;

//****************************************************************************//
Function TDMPlan.ModificationCpt(CCourant:TField):TErreurSaisie;
var
OldBoolean:Boolean;
ListeCpt:TStringList;
begin
if CCourant.DataSet.State in [dsEdit] then
  begin
  ChampObligatoire(CCourant.DataSet.findField('Compte').AsString,ListeChampOblig);
  ModificationCpt.CodeErreur:=0;
  ModificationCpt.Retour:=true;
  case CCourant.FieldNo of
     1:begin
        if CCourant.AsString <> OldValueCpt then
         begin //Numéro de compte vide
          ModificationCpt.CodeErreur:=1000;
          ModificationCpt.Retour:=false;
          messagedlg('Vous ne pouvez pas modifier le numéro de compte', mtwarning, [mbok],0);
         end;
       end;
     2:begin
        if (empty(CCourant.AsString) and (not Empty(CCourant.DataSet.findField('Compte').AsString))) then
         begin //Numéro de compte pas vide
          CCourant.DataSet.findField('Libelle').Value:=LibelleDuNumCpt(CCourant.DataSet.findField('Compte').AsString);
         end;
       end;
     10:begin // Traitement code tva
        if ListeChampOblig.IndexOf('TvaCode') <> -1 then
         begin
 //         if AideTvaCodeValide(CCourant.DataSet.findField('TvaCode').AsString,CCourant.DataSet.findField('Compte').AsString) then
          if TvaCodePourCompte(31,E.Regime,CCourant.DataSet.findField('Compte').AsString).Retour then
             begin
               if (empty(ccourant.asstring) or (TvaCodePourCompte(31,E.Regime,CCourant.DataSet.findField('Compte').AsString).ListeCode.IndexOf(UpperCase(CCourant.AsString)) <> -1)) then
                  begin
                    ModificationCpt.CodeErreur:=0;
                    ModificationCpt.Retour:=true;
                    ccourant.asstring:=UpperCase(ccourant.asstring);
                  end
                  else
                  Begin
                    ModificationCpt.CodeErreur:=4001;
                    ModificationCpt.Retour:=false;
                  End;

             end
             else
             begin
                ModificationCpt.CodeErreur:=4002;
                ModificationCpt.Retour:=false;
             end;
         end
         else
         Begin
          ModificationCpt.CodeErreur:=4003;
           ModificationCpt.Retour:=false;
//           messagedlg('Ce numéro de compte ne peut pas être associé à un code de TVA', mtwarning, [mbok],0);
         End;
       end;
     12:begin //champ TvaDebit
        if CCourant.AsBoolean then
           CCourant.DataSet.findField('TvaType').Value:='D'
         else
           CCourant.DataSet.findField('TvaType').Value:='E';
       end;
     //*************************************************************************

     // Traitement Collectif
     //*************************************************************************
     14:begin
         if CCourant.AsBoolean = true then
          begin
            OldBoolean:=CCourant.DataSet.FindField('Pointable').AsBoolean;
            CCourant.DataSet.FindField('Pointable').AsBoolean:=true;
            if not PossedeEcritureDirect(CCourant.DataSet.FindField('Compte').AsString) then
             begin
               if not ModificationCpt(CCourant.DataSet.FindField('Pointable')).retour then
                Begin
                 Result.retour:=false;
                 Result.CodeErreur:=14001;
                 CCourant.AsBoolean:=false;
                 CCourant.DataSet.FindField('Pointable').AsBoolean:=OldBoolean;
                End
                else
                    begin
                        if ((CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteProduitARecevoirDefaut)
                            or (CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteProduitConstateDAvance)
                            or (CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteChargeConstateeDAvance)
                            or (CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteChargeAPayerDefaut)
                            or (CCourant.DataSet.FindField('Compte').AsString=DM_C_CompteChargeARepartir)
                            or (ListeContientDebutCpt(CCourant.DataSet.FindField('Compte').AsString,9))
                            or (ListeContientDebutCpt(CCourant.DataSet.FindField('Compte').AsString,10))
                            or (ListeContientDebutCpt(CCourant.DataSet.FindField('Compte').AsString,11)))then
                                       begin
                                         Result.CodeErreur:=14004;
                                         Result.retour:=false;
                                         messagedlg('Vous ne pouvez pas rendre collectif un compte utilisable dans les écrans d''ouverture et de clôture !', mtwarning, [mbok],0);
                                         CCourant.AsBoolean:=false;
                                         CCourant.DataSet.FindField('Pointable').AsBoolean:=OldBoolean;
                                         abort;
                                       end;
                    end;
             end
             else
             begin
              messagedlg('Vous ne pouvez pas rendre collectif un compte qui possède des écritures !', mtwarning, [mbok],0);
              Result.retour:=false;
              Result.CodeErreur:=14002;
              CCourant.AsBoolean:=false;
              CCourant.DataSet.FindField('Pointable').AsBoolean:=OldBoolean;
             end;
          end
          else
            begin
             FiltrageDataSet(DMRech.TaTiersRech,'Compte = '''+CCourant.DataSet.FindField('Compte').AsString+'''');
             Result.retour:=(DMRech.TaTiersRech.RecordCount > 0 );
             DeFiltrageDataSet(DMRech.TaTiersRech);
             if Result.retour then
                         begin
                           Result.CodeErreur:=14003;
                           Result.retour:=false;
                           messagedlg('Vous ne pouvez pas rendre non collectif un compte qui possède des TIERS !', mtwarning, [mbok],0);
                           CCourant.AsBoolean:=true;
                           abort;
                         end;
             // ne doit pas posséder de tiers
            end;
       end;
     //*************************************************************************

     // Traitement Tiers
     //*************************************************************************
     16:begin
       if CCourant.AsBoolean = true then
        begin
         CCourant.DataSet.FindField('Collectif').AsBoolean:=true;

           if not CreationCpt(CCourant.DataSet.FindField('Collectif')).retour then
            begin
              Result.CodeErreur:=16001;
              Result.retour:=false;
              CCourant.AsBoolean:=false;
            end;
        end;
       end;
     //*************************************************************************

     // Traitement Pointable
     //*************************************************************************
     27:begin
        if CCOurant.AsBoolean = true then
         if not CptDevenirPointable(CCourant.DataSet.FindField('Compte').AsString) then
            begin
              CCourant.AsBoolean:=false;
              Result.CodeErreur:=26000;
              Result.Retour:=false;
            end;
       end;
//     14:begin // Traitement Collectif old
//       if ListeChampOblig.IndexOf('Collectif') <> -1 then
//        begin
//         if CCourant.AsBoolean = true then
//         begin
//          CCourant.DataSet.FindField('Rapprochement').AsBoolean:=true;
//         end
//         else
//         begin
//          if CCourant.DataSet.FindField('Tiers').AsBoolean=true then
//             begin
//               messagedlg('Le compte : '+ CCourant.DataSet.FindField('Compte').AsString+' - '+CCourant.DataSet.FindField('Libelle').AsString+' doit rester collectif.'+#10#13+'Des Comptes de Tiers lui sont rattachés !', mtwarning, [mbok],0);
//               CCourant.AsBoolean:=true;
//               CCourant.DataSet.FindField('Rapprochement').AsBoolean:=true;
////               Abort;
//             end;
//         end;
//        end;
//       end;                                           //or(e.TypeClient=CL_Saisie_Cogere)
     18:Begin // Immobilisation
          if ((E.TypeEtatExercice = ET_ImPORTATION) and ((E.TypeClient = CL_CoGERE))) then
           begin
            if CCourant.DataSet.FindField('Immobilisation').AsBoolean=false then
               begin
                if VerifSiCompteSaisieDsGestionDesImmos(CCourant.DataSet.FindField('Compte').AsString,true) then
                 Begin
                   CCourant.AsBoolean:=true;
                   ModificationCpt.CodeErreur:=18000;
                   ModificationCpt.Retour:=false;
                 End;
               end
            else
               begin
                try//finally
                    ListeCpt:=TStringList.Create;
                    ListeCpt.Add(CCourant.DataSet.FindField('Compte').AsString);
                   if (DMDiocEtatBal.SommeTotauxBalanceCalc(0,e.DatExoFin,listeCpt,'Compte').SoldeFin<>0) then
                    Begin
                      CCourant.AsBoolean:=true;
                      ModificationCpt.CodeErreur:=18001;
                      ModificationCpt.Retour:=false;
                      showmessage('Le compte : '+CCourant.DataSet.FindField('Compte').AsString+RetourChariotDouble+' présente un solde sur la balance, vous ne pouvez pas le rendre immobilisable.');
                      abort;
                    End;
                finally
                 ListeCpt.Free;
                end;
               end;
           end
          else
           begin
            if CCourant.DataSet.FindField('Immobilisation').AsBoolean=false then
               begin
                if VerifSiCompteSaisieDsGestionDesImmos(CCourant.DataSet.FindField('Compte').AsString,true) then
                 Begin
                   CCourant.AsBoolean:=true;
                   ModificationCpt.CodeErreur:=18000;
                   ModificationCpt.Retour:=false;
                 End;
               end
            else
               begin
               // // PB le 28/05/04 en concertation avec Denis
//                try//finally
//                    ListeCpt:=TStringList.Create;
//                    ListeCpt.Add(CCourant.DataSet.FindField('Compte').AsString);
//                   if ((DMDiocEtatBal.SommeTotauxBalanceCalc(0,e.DatExoFin,listeCpt,'Compte').SoldeFin<>0)or(VerifSiCompteSaisieDsBO(CCourant.DataSet.FindField('Compte').AsString,true,CCourant.DataSet))) then
//                    Begin
//                      CCourant.AsBoolean:=true;
//                      ModificationCpt.CodeErreur:=18001;
//                      ModificationCpt.Retour:=false;
//                      showmessage('Le compte : '+CCourant.DataSet.FindField('Compte').AsString+RetourChariotDouble+' présente un solde sur la balance, vous ne pouvez pas le rendre immobilisable.');
//                      abort;
//                    End;
//                finally
//                 ListeCpt.Free;
//                end;
               end;
            end;
        End;
     19:Begin // Amortissable
          if CCourant.DataSet.FindField('ImmoAmort').AsBoolean=true then
             begin
              if not CptDevenirAmortissable(CCourant.DataSet.FindField('Compte').AsString) then
               Begin
               messagedlg('Le compte : ~~   '+ CCourant.DataSet.FindField('Compte').AsString+' - '+CCourant.DataSet.FindField('Libelle').AsString+'    ~~'+#10#13#10#13+
                          'n''est pas amortissable.'+#10#13+'', mtwarning, [mbok],0);
               CCourant.AsBoolean:=false;
               ModificationCpt.CodeErreur:=19000;
               ModificationCpt.Retour:=false;
               End;
             end;
        End;
     20:Begin // Degressif

        End;


  end;

  end;
//
end;
//****************************************************************************//
procedure TDMPlan.TaPlanCptAfterInsert(DataSet: TDataSet);
begin
ChampObligatoire('',ListeChampOblig);
DernierNumCptValideEnInsert:='';
InitChampAfterInsert([nil,nil,nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],Dataset);
end;

//****************************************************************************//
Procedure TDMPlan.ChampObligatoire(Cpte: String; var Champ: TStringList);
Begin
NettoieListeChOblig(champ);
     // champs communs à tous les comptes
     Champ.Strings[0]:='Compte';
     Champ.Strings[1]:='Libelle';
     Champ.Strings[10]:='PlanSaisie';
     Champ.Strings[11]:='ID_Affichage';
cpte:=QueDesChiffres(cpte);
If length(cpte) >= 1 then
begin
  try
       case strtoint_lgr(cpte[1]) of
       1: begin
           If length(cpte) = 1 then
              begin
                Champ.Strings[2]:='Un1';
                Champ.Strings[3]:='Un2';
                Champ.Strings[6]:='SensCredit';
              end;
           If length(cpte) > 1 then
              Case strtoint_lgr(cpte[2]) of
           0..2 : begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                  end;
              3 : begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                    Champ.Strings[9]:='Immobilisation';
                  end;
            4..9 : begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                  end;
              end;
          end; // Fin Case Compte de classe 1
       2: begin
           If length(cpte) = 1 then
              begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[4]:='TvaCode';
                    Champ.Strings[5]:='TvaDebit';
                    Champ.Strings[6]:='SensCredit';
                    Champ.Strings[9]:='Immobilisation';
              end;
          If length(cpte) > 1 Then
             Case strtoint_lgr(cpte[2]) of
             0..7 : Begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[4]:='TvaCode';
                    Champ.Strings[5]:='TvaDebit';
                    Champ.Strings[6]:='SensCredit';
                    Champ.Strings[9]:='Immobilisation';
                    end;
             8..9 : Begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                    Champ.Strings[9]:='Immobilisation';
                    end;
             end;
          end;

       3: begin
           If length(cpte) = 1 then
              begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                    Champ.Strings[9]:='Immobilisation';
              end;
          If length(cpte) > 1 Then
             Case strtoint_lgr(cpte[2]) of
             0..9 : Begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                    Champ.Strings[9]:='Immobilisation';
                    end;
             end;
          end;

       4: begin
           If length(cpte) = 1 then
              begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                    Champ.Strings[7]:='Collectif';
                    Champ.Strings[8]:='Rapprochement';
                    Champ.Strings[12]:='Pointable';
              end;
          If length(cpte) > 1 Then
             Case strtoint_lgr(cpte[2]) of
             0..3 : begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                    Champ.Strings[7]:='Collectif';
                    Champ.Strings[8]:='Rapprochement';
                    Champ.Strings[12]:='Pointable';
                    end;
                4 : Begin
                    If length(cpte) = 2 then {compte 44}
                       begin
                         Champ.Strings[2]:='Un1';
                         Champ.Strings[3]:='Un2';
                         Champ.Strings[6]:='SensCredit';
                         Champ.Strings[8]:='Rapprochement';
                       end;
                    If length(cpte) >= 3 Then
                       Begin
                         Case strtoint_lgr(Cpte[3]) Of
                         0..4 : begin
                                 Champ.Strings[2]:='Un1';
                                 Champ.Strings[3]:='Un2';
                                 Champ.Strings[6]:='SensCredit';
                                 Champ.Strings[7]:='Collectif';
                                 Champ.Strings[8]:='Rapprochement';
                                 Champ.Strings[12]:='Pointable';
                                end;
                            5 : begin
                                    Champ.Strings[2]:='Un1';
                                    Champ.Strings[3]:='Un2';
                                    Champ.Strings[6]:='SensCredit';
                                   end;
                         6..9 : begin
                                    Champ.Strings[2]:='Un1';
                                    Champ.Strings[3]:='Un2';
                                    Champ.Strings[6]:='SensCredit';
                                    Champ.Strings[7]:='Collectif';
                                    Champ.Strings[8]:='Rapprochement';
                                    Champ.Strings[12]:='Pointable';
                                End;
                         end;
                       End;
                   end;
             5..7 : begin
                      Champ.Strings[2]:='Un1';
                      Champ.Strings[3]:='Un2';
                      Champ.Strings[6]:='SensCredit';
                      Champ.Strings[7]:='Collectif';
                      Champ.Strings[8]:='Rapprochement';
                      Champ.Strings[12]:='Pointable';
                    end;
             8..9 : begin
                        Champ.Strings[2]:='Un1';
                        Champ.Strings[3]:='Un2';
                        Champ.Strings[6]:='SensCredit';
                    End;
          end;//fin case strtoint_lgr(cpte[2]) of
          if ((cpte=DM_C_CompteProduitARecevoirDefaut)
              or (cpte=DM_C_CompteProduitConstateDAvance)
              or (cpte=DM_C_CompteChargeConstateeDAvance)
              or (cpte=DM_C_CompteChargeAPayerDefaut)
              or (cpte=DM_C_CompteChargeARepartir))then
              Champ.Strings[7]:='';
          end;
       5: begin
           If length(cpte) = 1 then
              begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
              end;
          If length(cpte) > 1 Then
               Case strtoint_lgr(cpte[2]) of
             0..9 : Begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[6]:='SensCredit';
                    end;
               end;
          end;

       6: begin
           If length(cpte) = 1 then
              begin
                 Champ.Strings[2]:='Un1';
                 Champ.Strings[3]:='Un2';
                 Champ.Strings[4]:='TvaCode';
                 Champ.Strings[5]:='TvaDebit';
                 Champ.Strings[6]:='SensCredit';
              end;
          If length(cpte) > 1 Then
             Case strtoint_lgr(cpte[2]) of
             0 : Begin
                      If length(cpte) = 2 Then
                      Begin
                        Champ.Strings[2]:='Un1';
                        Champ.Strings[3]:='Un2';
                        Champ.Strings[4]:='TvaCode';
                        Champ.Strings[5]:='TvaDebit';
                        Champ.Strings[6]:='SensCredit';
                      end;
                      If length(cpte) >= 3 Then
                      begin
                           Case strtoint_lgr(cpte[3]) of
                           0..2 : begin
                                   Champ.Strings[2]:='Un1';
                                   Champ.Strings[3]:='Un2';
                                   Champ.Strings[4]:='TvaCode';
                                   Champ.Strings[5]:='TvaDebit';
                                   Champ.Strings[6]:='SensCredit';
                                  end;
                           3:begin
                                   Champ.Strings[2]:='Un1';
                                   Champ.Strings[3]:='Un2';
                                   Champ.Strings[6]:='SensCredit';
                             end;
                           4..9 : begin
                                   Champ.Strings[2]:='Un1';
                                   Champ.Strings[3]:='Un2';
                                   Champ.Strings[4]:='TvaCode';
                                   Champ.Strings[5]:='TvaDebit';
                                   Champ.Strings[6]:='SensCredit';
                                  end;
                           end;
                      end;
                 end;
             1..7 : begin
                      Champ.Strings[2]:='Un1';
                      Champ.Strings[3]:='Un2';
                      Champ.Strings[4]:='TvaCode';
                      Champ.Strings[5]:='TvaDebit';
                      Champ.Strings[6]:='SensCredit';
                    end;
             8 :begin
                 Champ.Strings[2]:='Un1';
                 Champ.Strings[3]:='Un2';
                 Champ.Strings[6]:='SensCredit';
                end;
             9 : begin
                      Champ.Strings[2]:='Un1';
                      Champ.Strings[3]:='Un2';
                      Champ.Strings[4]:='TvaCode';
                      Champ.Strings[5]:='TvaDebit';
                      Champ.Strings[6]:='SensCredit';
                 end;
             end;
          end;

       7: Begin
           If length(cpte) = 1 then
              begin
                 Champ.Strings[2]:='Un1';
                 Champ.Strings[3]:='Un2';
                 Champ.Strings[4]:='TvaCode';
                 Champ.Strings[5]:='TvaDebit';
                 Champ.Strings[6]:='SensCredit';
              end;
          If length(cpte) > 1 Then
             Case strtoint_lgr(cpte[2]) of
             0 : Begin
                      If length(cpte) >= 2 Then
                      Begin
                        Champ.Strings[2]:='Un1';
                        Champ.Strings[3]:='Un2';
                        Champ.Strings[4]:='TvaCode';
                        Champ.Strings[5]:='TvaDebit';
                        Champ.Strings[6]:='SensCredit';
                      end;
                 end;
             1 : begin
                      Champ.Strings[2]:='Un1';
                      Champ.Strings[3]:='Un2';
                      Champ.Strings[6]:='SensCredit';
                    end;
             2..7 :begin
                    Champ.Strings[2]:='Un1';
                    Champ.Strings[3]:='Un2';
                    Champ.Strings[4]:='TvaCode';
                    Champ.Strings[5]:='TvaDebit';
                    Champ.Strings[6]:='SensCredit';
                      If length(cpte) >= 3 Then
                      begin
                           Case strtoint_lgr(cpte[3]) of
                           7 : begin
                                   Champ.Strings[2]:='Un1';
                                   Champ.Strings[3]:='Un2';
                                   Champ.Strings[4]:='';
                                   Champ.Strings[5]:='';
                                   Champ.Strings[6]:='SensCredit';
                                  end;
                           end;
                      end;
                   end;
             8 : begin
                      Champ.Strings[2]:='Un1';
                      Champ.Strings[3]:='Un2';
                      Champ.Strings[6]:='SensCredit';
                    end;
             9 : begin
                      Champ.Strings[2]:='Un1';
                      Champ.Strings[3]:='Un2';
                      Champ.Strings[4]:='TvaCode';
                      Champ.Strings[5]:='TvaDebit';
                      Champ.Strings[6]:='SensCredit';
                 end;
             end;
          end;
       end;   // Fin du case
  except
  end;
end;
End;

//****************************************************************************//
procedure TDMPlan.TaPlanCptAfterPost(DataSet: TDataSet);
var
ParamGenerCptAffiche:TParamGenerCptAffiche;
begin
   Remplit_TInfosplancpt(DAtaSet,DernierComptePost);
   if (DataSet is TTable) then
            if DataSet.Active then
                TTable(DataSet).FlushBuffers;
   NettoieListeChOblig(ListeChampOblig);
   ParamGenerCptAffiche.Affiche := true;
   CreationAuto(DataSet['Compte'],ParamGenerCptAffiche);
   If TaCompte.Active then TaCompte.Refresh;
   if DMRech <> nil then
     if DMRech.TaPlanCptRech.Active then
          DMRech.TaPlanCptRech.Refresh;
//  if DernierComptePost.ID_GESTANAL<>0 then
//    begin//créer l'affectation du compte
//      try//finally
//      finally
//      end;
//    end;
//   if TaPlanCptCreat.Active then TaPlanCptCreat.FlushBuffers;
end;

//****************************************************************************//
procedure TDMPlan.TaPlanCptAfterPostAuto(DataSet: TDataSet);
begin
NettoieListeChOblig(ListeChampOblig);
end;

//****************************************************************************//
procedure TDMPlan.TaPlanCptBeforeDelete(DataSet: TDataSet);
var
RetCre:TErreurSaisie;
begin
 Remplit_TInfosplancpt(DAtaSet,DernierCompteSupprimetmp);

if DataSet.State in [dsbrowse] then
 begin
   retCre:=SuppressionCpt(DataSet.findField('Compte').AsString,DataSet,true);
   if not RetCre.Retour then
    case RetCre.CodeErreur of
    2000:abort;
    2001:abort;
    2002:abort;
    2003:abort;
    2004:abort;
    2005:abort;
    2006:abort;
    2100:begin
          DataSet.findField('Compte').FocusControl;
          abort;
         end;
    end;
 end;
end;

//****************************************************************************//
procedure TDMPlan.TaPlanCptAfterEdit(DataSet: TDataSet);
begin
NettoieListeChOblig(ListeChampOblig);
ChampObligatoire(DataSet.Fields[0].AsString,ListeChampOblig);
OldValueCpt:=DataSet.Fields[0].AsString;
end;

//****************************************************************************//
procedure TDMPlan.TaPlanCptBeforeCancel(DataSet: TDataSet);
begin

//case taplancpt.State of
//   dsEdit:if Messagedlg(PChar('Etes-vous sûr de vouloir annuler les modifications faites sur le compte : '+DataSet.FindField('Compte').AsString+' - '+TaPlanCpt.findField('Libelle').Text+' ?'),mtconfirmation, [mbno,mbyes],0) = mrNo then
//             abort;
////   : ;
//end;

end;

//****************************************************************************//
// Crée les comptes à générer en fonction de Cpt                              //
//****************************************************************************//
function TDMPlan.CompteGenerateur(Cpt:string):boolean;
var
CptRech:string;
begin
   CptRech:=cpt;
   FiltrageDataSet(TaParamCpt,'Famille=''100'' and Rac1='''+ CptRech +''' and Regime='''+ E.Regime +'''');
   while ((TaParamCpt.recordcount = 0) and (length(CptRech)>0)) do
         begin
            delete(CptRech,length(CptRech),1);
            FiltrageDataSet(TaParamCpt,'Famille=''100'' and Rac1='''+ CptRech +''' and Regime='''+ E.Regime +'''');
         end;
   result:=(TaParamCpt.locate('Rac1',CptRech,[]) and (length(CptRech)=length(TaParamCpt.FindField('Rac1').AsString)));
   if copy(cpt,1,3)='139' then result:=false;
end;
//****************************************************************************//
Function TDMPlan.CompteGenere(Cpt:string):boolean;
var
CptRech:string;
begin
   Result:=false;
   CptRech:=cpt;
   FiltrageDataSet(TaParamCpt,'Famille=''100'' and Rac2='''+ CptRech +''' and Regime='''+ E.Regime +'''');
   while ((TaParamCpt.recordcount = 0) and (length(CptRech)>0)) do
         begin
            delete(CptRech,length(CptRech),1);
            FiltrageDataSet(TaParamCpt,'Famille=''100'' and Rac2='''+ CptRech +''' and Regime='''+ E.Regime +'''');
         end;
   FiltrageDataSet(TaParamCpt,'Famille=''100'' and Rac1='''+ TaParamCpt.findField('Rac1').AsString +''' and Regime='''+ E.Regime +'''');
   result:=(TaParamCpt.locate('Rac2',CptRech,[]) and (length(CptRech)=length(TaParamCpt.FindField('Rac2').AsString)));
   if copy(cpt,1,2)='13' then result:=false;
end;

{-----------------------------------------------------------------------------
  Procedure: TDMPlan.VerifSiCptGenereEncoreLie
  Author:    Blanc Philippe
  Date:      30-oct.-2003
  Arguments: Cpt:String  : Compte générés
  Result:    Boolean
  Description : Permet de savoir si un compte généré est encore lié à un
                compte gérérateur !
-----------------------------------------------------------------------------}
//****************************************************************************//
Function TDMPlan.VerifSiCptGenereEncoreLie(Cpt:String):Boolean;
var
CptRech,ExtensionCpt:string;
ListeCptGenerateur:TStringList;
i:integer;
begin
try//finally
   Result:=false;
   ListeCptGenerateur:=TStringList.create;
   CptRech:=cpt;
   ExtensionCpt := '';
   FiltrageDataSet(DMRech.TaParamCptRech,'Famille=''100'' and Rac2='''+ CptRech +''' and Regime='''+ E.Regime +'''');
   while ((DMRech.TaParamCptRech.recordcount = 0) and (length(CptRech)>0)) do
         begin
            ExtensionCpt := copy(CptRech,length(CptRech),1)+ExtensionCpt;
            delete(CptRech,length(CptRech),1);
            FiltrageDataSet(DMRech.TaParamCptRech,'Famille=''100'' and Rac2='''+ CptRech +''' and Regime='''+ E.Regime +'''');
         end;
   ListeCptGenerateur:=ChampTableVersListe('Rac1',DMRech.TaParamCptRech);
   FiltrageDataSet(DMRech.TaParamCptRech,'Famille=''100'' and Rac1='''+ DMRech.TaParamCptRech.findField('Rac1').AsString +''' and Regime='''+ E.Regime +'''');
   result:=(DMRech.TaParamCptRech.locate('Rac2',CptRech,[]) and (length(CptRech)=length(DMRech.TaParamCptRech.FindField('Rac2').AsString)));
   if copy(cpt,1,2)='13' then result:=false;
if result then
 begin
   for i:=0 to ListeCptGenerateur.Count-1 do
    begin
        FiltrageDataSet(DMRech.TaPlanCptRech,'Compte='''+ListeCptGenerateur.Strings[i]+ExtensionCpt+'*''');
        result:= (DMRech.TaPlanCptRech.RecordCount<2);
        if not result then break;
    end;
 end;
finally
 Initialise_TStringlist(ListeCptGenerateur);
end;
End;

//****************************************************************************//

Procedure TDMPlan.CreationAuto(CpteDepart:string;ParamGenerCptAffiche:TParamGenerCptAffiche);
var
LibCptNonPrevu,CptDep,ExtensionCpt:string;
CptNonPrev:boolean;
ListeCpt:TstringList;
i:integer;

begin
ListeCpt:=TStringList.Create;
ListeCpt.Duplicates:=dupIgnore;

TaCompteGener.AfterEdit:=nil;
TaCompteGener.AfterPost:=nil;
TaCompteGener.BeforePost:=nil;
TaCompteGener.BeforeInsert:=nil;
TaCompteGener.AfterScroll:=nil;

if not TaCompteGener.Active then TaCompteGener.Open;
if length(CpteDepart)>8 then delete(CpteDepart,8,length(CpteDepart)-8);
CptDep:=CpteDepart;
if ((not VerifComptePCG(CpteDepart)) and (not PossedePereNonPrevu(CpteDepart))) then
   begin
   LibCptNonPrevu:=TaPlanCpt.findField('Libelle').AsString;
   CptNonPrev:=true;
   end else CptNonPrev:=false;
CptNonPrev:=false; // Denis le 27/10/03
if not PossedePerePCU(CpteDepart) then
 begin
 // Gestion des comptes genere / Generateur pour le compte en cours de creation
 if not CptNonPrev then
    begin
        if CompteGenerateur(CpteDepart) then
          begin
           TaParamCpt.First;
           ExtensionCpt:=CpteDepart;
           delete(ExtensionCpt,1,length(TaParamCpt.findfield('Rac1').AsString));
           while not TaParamCpt.EOF do
                 begin
                  if length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)>8
                         then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
                   if not CompteExistePCU(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)
                      then
                      begin
                      TaCompteGener.Insert;
                      DMPlan.InitialiseInsertionCompte(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,TaCompteGener);
                      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
                      //InitChampAfterInsert([TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                      TableGerePost(TaCompteGener);
                      ListeCpt.Add(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt);
                      end;
                  TaParamCpt.next;
                 end;
          end;
        if CompteGenere(CpteDepart) then
          begin
           TaParamCpt.First;
           ExtensionCpt:=CpteDepart;
           delete(ExtensionCpt,1,length(TaParamCpt.findfield('Rac2').AsString));
           while not TaParamCpt.EOF do
                 begin
                   if length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)>8
                         then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
                   if not CompteExistePCU(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)
                      then
                      begin
                      TaCompteGener.Insert;
                      DMPlan.InitialiseInsertionCompte(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,TaCompteGener);
                      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//                      InitChampAfterInsert([TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                      TableGerePost(TaCompteGener);
                      ListeCpt.Add(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt);
                      end;
                  if length(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)>8
                         then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
                   if not CompteExistePCU(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)
                      then
                      begin
                      TaCompteGener.Insert;
                      DMPlan.InitialiseInsertionCompte(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt,TaCompteGener);
                      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//                      InitChampAfterInsert([TaParamCpt.findfield('Rac1').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                      TableGerePost(TaCompteGener);
                      ListeCpt.Add(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt);
                      end;
                  TaParamCpt.next;
                 end;
          end;
    end;
  while not PossedePerePCU(CpteDepart) do
   begin
   CpteDepart:=copy(CpteDepart,1,length(CpteDepart)-1);
   ListeCpt.Add(CpteDepart);
   if CptNonPrev then
    begin
      TaCompteGener.Insert;
      DMPlan.InitialiseInsertionCompte(CpteDepart,TaCompteGener);
      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//      InitChampAfterInsert([CpteDepart,LibCptNonPrevu,nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
      TableGerePost(TaCompteGener);
    end
   else
    begin
        TaCompteGener.Insert;
//        InitChampAfterInsert([CpteDepart,LibelleDuNumCpt(CpteDepart),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
        DMPlan.InitialiseInsertionCompte(CpteDepart,TaCompteGener);
        TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
        TableGerePost(TaCompteGener);
        if CompteGenerateur(CpteDepart) then
          begin
           TaParamCpt.First;
           ExtensionCpt:=CpteDepart;
           delete(ExtensionCpt,1,length(TaParamCpt.findfield('Rac1').AsString));
           while not TaParamCpt.EOF do
                 begin
                  if length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)>8
                         then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
                   if not CompteExistePCU(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)
                      then
                      begin
                      TaCompteGener.Insert;
                      InitialiseInsertionCompte(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,TaCompteGener);
                      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//                      InitChampAfterInsert([TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                      TableGerePost(TaCompteGener);
                      ListeCpt.Add(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt);
                      end;
                  TaParamCpt.next;
                 end;
          end;
        if CompteGenere(CpteDepart) then
          begin
           TaParamCpt.First;
           ExtensionCpt:=CpteDepart;
           delete(ExtensionCpt,1,length(TaParamCpt.findfield('Rac2').AsString));
           while not TaParamCpt.EOF do
                 begin
                   if length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)>8
                         then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
                   if not CompteExistePCU(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)
                      then
                      begin
                      TaCompteGener.Insert;
                      InitialiseInsertionCompte(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,TaCompteGener);
                      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//                      InitChampAfterInsert([TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                      TableGerePost(TaCompteGener);
                      ListeCpt.Add(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt);
                      end;
                   if length(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)>8
                         then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
                   if not CompteExistePCU(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)
                      then
                      begin
                      TaCompteGener.Insert;
                      InitialiseInsertionCompte(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt,TaCompteGener);
                      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//                      InitChampAfterInsert([TaParamCpt.findfield('Rac1').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                      TableGerePost(TaCompteGener);
                      ListeCpt.Add(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt);
                      end;
                  TaParamCpt.next;
                 end;
          end;
    end;
 end;
 end
 else
 if CompteGenerateur(CpteDepart) then
    begin
     TaParamCpt.First;
     ExtensionCpt:=CpteDepart;
     delete(ExtensionCpt,1,length(TaParamCpt.findfield('Rac1').AsString));
     while not TaParamCpt.EOF do
           begin
             if length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)>8
                   then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
             if not CompteExistePCU(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)
                then
                begin
                TaCompteGener.Insert;
                InitialiseInsertionCompte(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,TaCompteGener);
                TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//                InitChampAfterInsert([TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                TableGerePost(TaCompteGener);
                ListeCpt.Add(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt);
                end;
            TaParamCpt.next;
           end;
    end
 else
        if CompteGenere(CpteDepart) then
          begin
           TaParamCpt.First;
           ExtensionCpt:=CpteDepart;
           delete(ExtensionCpt,1,length(TaParamCpt.findfield('Rac2').AsString));
           while not TaParamCpt.EOF do
                 begin
                  if length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)>8
                        then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
                   if not CompteExistePCU(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt)
                      then
                      begin
                      TaCompteGener.Insert;
                      InitialiseInsertionCompte(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,TaCompteGener);
                      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//                      InitChampAfterInsert([TaParamCpt.findfield('Rac2').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                      TableGerePost(TaCompteGener);
                      ListeCpt.Add(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt);
                      end;
                  if length(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)>8
                         then delete(ExtensionCpt,length(ExtensionCpt)-((length(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)-8)),length(ExtensionCpt));
                   if not CompteExistePCU(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt)
                      then
                      begin
                      TaCompteGener.Insert;
                      InitialiseInsertionCompte(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt,TaCompteGener);
                      TaCompteGener.findField('ID_Affichage').AsString:=TaCompteGener.findField('Compte').AsString;
//                      InitChampAfterInsert([TaParamCpt.findfield('Rac1').AsString+ExtensionCpt,LibelleDuNumCpt(TaParamCpt.findfield('Rac2').AsString+ExtensionCpt),nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],TaCompteGener);
                      TableGerePost(TaCompteGener);
                      ListeCpt.Add(TaParamCpt.findfield('Rac1').AsString+ExtensionCpt);
                      end;
                  TaParamCpt.next;
                 end;
          end;
if ListeCpt.Count>0 then
   begin
//   if (GenerCpt_PM = nil) then GenerCpt_PM:=TGenerCpt_PM.Create(self);
   TaCompteGener.AfterEdit:=TaPlanCptAfterEdit;
   TaCompteGener.AfterPost:=TaPlanCptAfterPostAuto;
   TaCompteGener.BeforePost:=TaPlanCptBeforePost;
   TaCompteGener.BeforeInsert:=TaPlanCptGenereBeforeInsert;
//   TaCompteGener.AfterScroll:=TaPlanCptAfterScroll;
//   TaCompteGener.Filtered:=false;
   FiltrageDataSet(TaCompteGener,CreeFiltreOU('compte',[ListeCpt]));
//   TaCompteGener.Filter:=CreeFiltreOU('compte',[ListeCpt]);
//   TaCompteGener.Filtered:=True;
   TaCompteGener.FindFirst;
   OldValueCpt:=TaCompteGener.findfield('Compte').AsString;
//   TaCompteGener.AfterScroll(TaCompteGener);
//   TaPlanGener.Edit;
     ParamGenerCptAffiche.CompteGenerateur := CpteDepart;
     ParamGenerCptAffiche.DataSourceGrille := DaCompteGenere;       //or(e.TypeClient=CL_Saisie_Cogere)
     ParamGenerCptAffiche.Affiche :=not ((E.TypeEtatExercice = ET_Importation) and ((E.TypeClient = CL_COGERE)));
     ParamGenerCptAffiche.Affiche :=false;
     GenerCptAffiche(ParamGenerCptAffiche);
//   GenerCpt_PM.GrilleCptGene.DataSource:=DaCompteGenere;
//   GenerCpt_PM.CompteGenere:=CptDep;
//   GenerCpt_PM.Showmodal;
   if TaPlanCpt.Active then
    begin
     TaPlanCpt.Refresh;
     TaPlanCpt.Locate('Compte',CptDep,[]);
    end;
   end;
TaCompteGener.AfterEdit:=nil;
TaCompteGener.AfterPost:=nil;
TaCompteGener.BeforePost:=nil;
TaCompteGener.BeforeInsert:=nil;
TaCompteGener.AfterScroll:=nil;
TaCompteGener.FlushBuffers;
TaCompteGener.Close;
for i:=0 to TaCompteGener.FieldCount - 1 do
    begin
      TaCompteGener.ReadOnly:=false;
    end;


//TaPlanGener.Free;
//TaPlanGener:=nil;
Initialise_TStringlist(ListeCpt);
//ListeCpt.Free;
end;

//****************************************************************************//
Function TDMPlan.PossedePerePCU(Cpte:string):Boolean;
var
CptAux:string;
begin
CptAux:=Cpte;
CptAux:=copy(CptAux,1,length(CptAux)-1);
IF (length(cpte)=1) then
   begin
    if (cpte <>'9') then
        result:=true
        else
        result:=false;
   end
   else
    result:=CompteExistePCU(CptAux);
end;

//****************************************************************************//
Function TDMPlan.DemandeCreation(Cpte:string;Controle :Tcomponent;MessCreat:boolean):Texceptlgr;
var
ValidCreation:boolean;
begin
try//except
if MessCreat then
ValidCreation:=messagedlg(PChar('Le compte : '+Cpte+' n''existe pas ! '+#10#13#10#13+'Voulez-vous le créer ?'),mtconfirmation, [mbno,mbyes],0) = mryes
else ValidCreation:=true;

result.retour:=ValidCreation;

if ValidCreation then
   begin
   if E2_GesPlanCpt_PM.CreationCompteAffiche(Cpte,true) then
    begin
      if Controle <> nil then
      case RecupClassTypeComponent(controle)of
      GTEdit:TCustomEdit(Controle).Text:=DernierComptePost.Compte;
      GTStringGrid: with TStringGrid(Controle) do Cells[Col, Row]:=DernierComptePost.Compte;
      GTGrid: with TStringGrid(Controle) do Cells[Col, Row]:=DernierComptePost.Compte;
      GTDBGrid:     begin
                    if TCustomdbgrid(controle).SelectedField.DataSet.State in [dsedit,dsinsert] then
                    TCustomdbgrid(controle).selectedfield.asstring:=DernierComptePost.Compte;
                    end;
      GTFieldString:begin
                    if TField(controle).DataSet.State in [dsedit,dsinsert] then
                    TField(controle).asstring:=DernierComptePost.Compte;
                    end;
      end;//fin du case
    end
    else
      abort;
   end;
except
  result.retour:=false;
end;
end;
//****************************************************************************//
procedure TDMPlan.TaPlanCptBeforeInsert(DataSet: TDataSet);
begin
case e.TypeDossier of
  VerAgricole:begin
                DernierNumCptValideEnInsert:='';
                Dataset.Fields[0].FocusControl;
              end;
  VerDiocese:begin
                abort;
              end;
end;

end;

//****************************************************************************//
procedure TDMPlan.TaPlanCptBeforeInsert_Import(DataSet: TDataSet);
begin
case e.TypeDossier of
  VerAgricole:begin
                DernierNumCptValideEnInsert:='';
              end;
  VerDiocese:begin
                abort;
              end;
end;

end;

//****************************************************************************//
procedure TDMPlan.TaPlanCptGenereBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

//****************************************************************************//
//obsolète
//procedure TDMPlan.TaPlanCptAfterScroll(DataSet: TDataSet);
//var
//i:integer;
//CptTmp:string;
//begin
////NettoieListeChOblig(ListeChampOblig);
//CptTmp:=DataSet.Fields[0].AsString;
//CompteAJournal:=false;
//case Dataset.State
// of
//   dsBrowse:begin
//            ChampObligatoire(CptTmp,ListeChampOblig);
//            for i:=0 to DataSet.FieldCount - 1 do
//                begin
//                 if ListeChampOblig.IndexOf(TaPlanCpt.Fields[i].FieldName) <> - 1 then
////                 DataSet.Fields[i].ReadOnly:= (ListeChampOblig.IndexOf(TaPlanCpt.Fields[i].FieldName) = - 1);
//                          DataSet.Fields[i].ReadOnly:=true;
//                end;
////            for i:=0 to DataSet.FieldCount - 1 do
////                begin
////                 if ListeChampOblig.IndexOf(TaPlanCpt.Fields[i].FieldName) <> - 1 then
////                          DataSet.Fields[i].ReadOnly:=false else
////                          DataSet.Fields[i].ReadOnly:=true;
////                end;
//           CompteAJournal:=((ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'])));
//           DataSet.FindField('Compte').ReadOnly:=true;
//            end;
//
//   dsEdit:begin
//            ChampObligatoire(CptTmp,ListeChampOblig);
////            ListeChampOblig.strings[1]:='Libelle';
//            for i:=0 to DataSet.FieldCount - 1 do
//                begin
//                 if ListeChampOblig.IndexOf(DataSet.Fields[i].FieldName) <> - 1 then
//                          DataSet.Fields[i].ReadOnly:=false else
//                          DataSet.Fields[i].ReadOnly:=true;
//                end;
//            DataSet.FindField('Compte').ReadOnly:=true;
//            end;
//   dsInsert:begin
//            for i:=0 to DataSet.FieldCount - 1 do
//                begin
//                DataSet.Fields[i].ReadOnly:=false;
//                end;
//            end;
// end;
//
//end;

Procedure TDMPlan.InitChampAutoriseBO(Table:TTable);
var
ListeCpt:TStringList;
BookTmp:TBookmark;
TableParamCpt:ttable;
CptAux,regime:string;
//OldFilter:String;
//OldFileterd:Boolean;
EtatFiltre:TEtatFiltre;
begin
try
TableSauveEtatFiltre(TAble,EtatFiltre);
//OldFilter:=Table.Filter;
//OldFileterd:=Table.Filtered;
regime:=E.Regime;
ListeCpt:=TStringList.Create;
  TableParamCpt:=TTable.Create(self);
  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
  TableParamCpt.TableName:=TaParamCpt.TableName;
//  TableParamCpt.Filtered:=false;
  FiltrageDataSet(TableParamCpt,CreeFiltreET(['Famille','Regime'],[inttostr(98),regime]));
//  TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime'],[inttostr(98),regime]);
//  TableParamCpt.Filtered:=true;
  // Filtrage de la table param pour le contexte en cours
  FiltrageDataSet(TaParamCptAideCpt,TableParamCpt.Filter);
//  TaParamCptAideCpt.filter:=TableParamCpt.Filter;
//  TaParamCptAideCpt.Filtered:=true;

  if not table.Active then Table.Open;
  TableParamCpt.Open;
  TableParamCpt.First;
  ListeCpt.Duplicates:=dupIgnore;
  ListeCpt.Sorted:=true;
  while not  TableParamCpt.EOF  do
     begin
      CptAux:=TableParamCpt.findfield('Rac1').asstring;
      CptAux:=copy(CptAux,1,length(CptAux)-1);
          while length(CptAux)>0 do
          begin
              ListeCpt.Add(CptAux);
             CptAux:=copy(CptAux,1,length(CptAux)-1);
          end;
     ListeCpt.Add(TableParamCpt.findfield('Rac1').asstring+'*');
     TableParamCpt.Next;
     end;

BookTmp:=Table.GetBookmark;
Table.DisableControls;
Table.Refresh;
//TaPlanRech:=TTable.Create(self);
//TaPlanRech.Databasename:=Table.DatabaseName;
//TaPlanRech.TableName:=Table.TableName;
//ListeCpt:= DMPlan.FiltrageParamCPT(98,e.Regime);
FiltrageDataSet(table,CreeFiltreOU('Compte',[ListeCpt]));
//Table.Filter:=CreeFiltreOU('Compte',[ListeCpt]);
//Table.Filtered:=true;
//TaPlanRech.Open;
Table.First;
while not Table.EOF do
      begin
       ListeCptOkBO.add(Table.findfield('Compte').AsString);
       Table.Next;
      end;
TableRestoreEtatFiltre(Table,EtatFiltre);
//Table.Filter:=OldFilter;
//Table.Filtered:=OldFileterd;
Table.GotoBookmark(Booktmp);
Table.EnableControls;
Table.FreeBookmark(Booktmp);
finally
  ListeCpt.Free;
  TableParamCpt.close;
  TableParamCpt.free;
end;
End;


//******************************************************************************
//******************************************************************************
// Vérifi si un compte est modifiable dans le Bilan d'Ouverture
// La sélection des comptes eet faite par la Requete
//                             QuCompteUtiliseOuvClot
// TaPlanBO possede un champ calcule qui = true si un compte
// du plan comptable est utilisé dans une des tables de l'ouverture
// ce qui interdit l'utilisation de ce compte dans Bilan d'Ouverture
//******************************************************************************
//******************************************************************************
procedure TDMPlan.TaPlanBOBeforeEdit(DataSet: TDataSet);
var
CptTmp:String;
begin
//DataSet.Fields
//if DataSet.FieldNo in [1..2] then abort;
CptTmp:=DataSet.FindField('Compte').AsString;
if ((DataSet.FindField('Ouverture').AsBoolean = true) and (copy(CptTmp,1,1)<>'6') and (copy(CptTmp,1,1)<>'7')) then
   Begin
      if not ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')) then
      begin
       ShowMessage('Vous ne pouvez pas modifier le compte : '+CptTmp+', il possède des opérations dans les menus d''ouverture ou de clôture automatique');
       abort;
      end;
   End

   else

   if length(CptTmp)<=2 then
   begin
    ShowMessage('Vous ne pouvez pas modifier les comptes à '+IntTosTr(length(CptTmp))+' chiffres !');
    abort;
   end

   else

   if PossedeFils(CptTmp) then
    begin
     if not (MessageDlg('Le compte '+CptTmp+' n''est pas la dernière subdivision !'+#10#13 + 'Confirmez-vous votre choix ?', mtConfirmation, mbYesNo, 0) = mrYes) then
      abort;
//     if not Question('AideCompte', 'Subdivision') then abort;
    end;
end;


//******************************************************************************
//******************************************************************************
// Calcule les champs :
//   Ouverture (V/F) : indique si une compte du plan cpt est utilisé dans l'ouverture
//   Debit_Deb_Calc : recupére le débit report dans la balance
//   Credit_Deb_Calc : recupére le Credit report dans la balance
//******************************************************************************
//******************************************************************************
procedure TDMPlan.TaPlanBOCalcFields(DataSet: TDataSet);
var
compteImmos:string;
begin
try
DataSet.FindField('Ouverture').AsBoolean:=(ListeNonModifDsBO.IndexOf(dataset.FindField('Compte').AsString) <> -1);
if ((DataSet.FindField('Ouverture').AsBoolean)and (((str_commence_par(dataset.FindField('Compte').AsString,'28'))or(str_commence_par(dataset.FindField('Compte').AsString,'139'))))) then
  Begin                                             
    compteImmos:=FiltrageParamCPTSurCompteDotation_PourRecupCompteImmos(100,dataset.FindField('Compte').AsString,e.regime);
    DataSet.FindField('Ouverture').AsBoolean:=CompteImmobilisation(compteImmos);
  end;
////  TaPlanBOOuverture.AsBoolean:=QuCompteUtiliseOuvClot.Locate('Compte',dataset.FindField('Compte').AsString,[]);
  if str_commence_par(dataset.FindField('Compte').AsString,DM_C_CompteAmortDerogatoire)
   then DataSet.FindField('Ouverture').AsBoolean:=Derogatoire;
//  //  dataset.FindField('Ouverture').Value:=QuCompteUtiliseOuvClot.Locate('Compte',dataset.FindField('Compte').AsString,[]);
  if DMDiocEtatBal <> nil then
     begin

////      TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,dataset.FindField('Compte').AsString);
////      dataset.FindField('Debit_Deb_Calc').AsCurrency:=TotauxBalance.TotalSoldeDebitReport;
////      dataset.FindField('Credit_Deb_Calc').AsCurrency:=TotauxBalance.TotalSoldeCreditReport;

      if DMDiocEtatBal.TaBalanceCalc.Locate('Compte',dataset.FindField('Compte').AsString,[]) then
       begin
         dataset.FindField('Debit_Deb_Calc').AsCurrency:=DMDiocEtatBal.TaBalanceCalc.findField('Debit_Report').AsCurrency;
         dataset.FindField('Credit_Deb_Calc').AsCurrency:=DMDiocEtatBal.TaBalanceCalc.findField('Credit_Report').AsCurrency;
       end;
     end;
except
//showmessage('erreur sur le calc field plan Bo');
end;
end;


//******************************************************************************
//******************************************************************************
// Appelle l'écran de création de compte
//******************************************************************************
//******************************************************************************
procedure TDMPlan.TaPlanBOBeforeInsert(DataSet: TDataSet);
begin
  DemandeCreation('',nil,false);
  abort;
end;


//******************************************************************************
//******************************************************************************
// QuMAJBalAutoBalManu met à jour les soldes dans plan comptable
// avec les soldes du report en provenance de la Balance
//******************************************************************************
//******************************************************************************
procedure TDMPlan.TaPlanBOBeforeOpen(DataSet: TDataSet);
begin
//TaPlanBO.OnCalcFields:=nil;
  try

//    QuMAJBalAutoBalManu.Close;
//    QuMAJBalAutoBalManu.Prepare;
//    QuMAJBalAutoBalManu.ExecSQL;

//    QuCompteUtiliseOuvClot.ParamByName('DateDebExo').AsDate:=E.DatExoDebut;
    if not QuCompteUtiliseOuvClot.Active then QuCompteUtiliseOuvClot.Open;

//    showmessage(QuCompteUtiliseOuvClot.Database.Params[0]);
    if DMDiocEtatBal <> nil then
     begin
      if not DMDiocEtatBal.TaBalanceCalc.Active then DMDiocEtatBal.TaBalanceCalc.Open;
     end
     else
     begin
      DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
      if not DMDiocEtatBal.TaBalanceCalc.Active then DMDiocEtatBal.TaBalanceCalc.Open;
     end;
  except
//    messageDlg('Erreur à l''ouverture de la table TaPlanBO 2 dans le module DMPLanCpt ',mtError,[],0);
  end;
end;


//******************************************************************************
//******************************************************************************
// Valide une suppression et rafraichit la table planCpt
//******************************************************************************
//******************************************************************************
procedure TDMPlan.TaPlanBOAfterDelete(DataSet: TDataSet);
begin
  TaPlanBO.FlushBuffers;
  TableRefresh(DataSet,'Compte');
  TaPlanBOCalc.Refresh;
end;


//******************************************************************************
//******************************************************************************
// Ferme la requete : QuCompteUtiliseOuvClot
//******************************************************************************
//******************************************************************************
procedure TDMPlan.TaPlanBOAfterClose(DataSet: TDataSet);
begin
QuCompteUtiliseOuvClot.Close;
end;


//******************************************************************************
//******************************************************************************
// Execute les predicats déclenché dans GestPlan avec la RxCheckListBox1
// et retourne vrai si OK
//******************************************************************************
//******************************************************************************
Function TDMPlan.TaPlanCptPredicat(Dataset:TDataset;IndexPredicat:integer):boolean;
var
i,j:integer;
Begin
if DMrech.TaTiersRech.Filtered then DeFiltrageDataSet(DMrech.TaTiersRech);
if dmrech.TaEcritureRech.Filtered then DeFiltrageDataSet(dmrech.TaEcritureRech);
Result:=False;
for i:=1 to length(IntToStr(IndexPredicat)) do
 begin
    J:=strtoint_lgr(IntToStr(IndexPredicat)[i]);
    case J of
       0:Result:=true;
                 // Vrai si un compte possede des écritures
       1:result:=PossedeEcritureSurPeriode(Dataset.findfield('Compte').AsString,False) or result;
//       1:result:=PossedeEcriture(TaPlanCpt.findfield('Compte').AsString) or result;
                 // Vrai si un compte à des Tiers Ratachés
       2:result:=DMRech.TaTiersRech.Locate('Compte',Dataset.findfield('Compte').AsString,[]) or result;
                 // Vrai si un compte est une dernière subdivisions
       3:result:=not PossedeFils(Dataset.findfield('Compte').AsString) or result;
                  // Vrai si est associé à un code TVA
       4:result:=not empty(Dataset.findfield('TvaCode').AsString) or result;
                 // Vrai si est un compte d'immo
       5:result:=Dataset.findfield('Immobilisation').AsBoolean or result;
                 // Vrai si est un compte pointable
       6:result:=Dataset.findfield('Pointable').AsBoolean or result;
                 // Vrai si est un compte appartient au plan de saisie
       7:result:=Dataset.findfield('PlanSaisie').AsBoolean or result;
    end;
 end;
if length(IntToStr(IndexPredicat))=0 then
  result:=true;
End;

Function TDMPlan.ListeCompteExclusEnteteEtPiece(Famille:integer;Regime:string):TStringList;
var
TableParamCpt:ttable;
begin
try
result:=TStringList.Create;
  TableParamCpt:=TTable.Create(self);
  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
  TableParamCpt.TableName:=TaParamCpt.TableName;

//  TableParamCpt.Filtered:=false;
//  TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime'],[inttostr(Famille),Regime]);
//  TableParamCpt.Filtered:=true;
//  TableParamCpt.Open;
  FiltrageDataSet(TableParamCpt,CreeFiltreET(['Famille','Regime'],[inttostr(Famille),Regime]));
  
  TableParamCpt.First;
  result.Duplicates:=dupIgnore;
  result.Sorted:=true;
  while not  TableParamCpt.EOF  do
     begin
      result.Add(TableParamCpt.findfield('Rac1').asstring);
      TableParamCpt.Next;
     end;
finally
  TableParamCpt.close;
  TableParamCpt.free;
end;
end;
//****************************************************************************//
//           Traitement avant la validation du nouveau compte                 //
//****************************************************************************//
procedure TDMPlan.TaPlanCptBeforePost(DataSet: TDataSet);
var
RetCre:TErreurSaisie;
i:integer;
begin
for i:=0 to DataSet.FieldCount - 1 do
    begin
    DataSet.Fields[i].ReadOnly:=false;
    end;
if Dataset.State  in [dsinsert] then
 begin
  for i:=0 to Dataset.FieldCount -1 do
   begin
   if ListeChampOblig.IndexOf(Dataset.Fields[i].FieldName) <> -1 then
    begin
    retCre:=DMPlan.CreationCpt(Dataset.FindField(ListeChampOblig.Strings[ListeChampOblig.IndexOf(Dataset.Fields[i].FieldName)]));
    if not RetCre.Retour then
     case RetCre.CodeErreur of
     1000,1001:begin
         NettoieListeChOblig(ListeChampOblig);
         Dataset.Fields[i].FocusControl;
         abort;
         end;
     1002:begin
         Dataset.Cancel;
         Dataset.Fields[0].FocusControl;
         NettoieListeChOblig(ListeChampOblig);
         abort;
         end;
      4001,4002 :begin
                  if not AideTvaAffiche(DataSet.Fields[10],DataSet.Fields[0].AsString)
                  then
                    begin
                    Dataset.Fields[i].FocusControl;
                    abort;
                    end;
                 end;
     14002:begin
             abort;
           end;
     end;
    end;
   end;
   if DMPlan.EnDemandeCreation then
    begin
//     FiltrageDataSet(DataSet,'Compte = '''+DataSet['Compte']+'''');
     DMPlan.EnDemandeCreation:=false;
    end;

 end;

if Dataset.State  in [dsEdit] then
 begin
  for i:=0 to Dataset.FieldCount -1 do
   begin
   if ListeChampOblig.IndexOf(Dataset.Fields[i].FieldName) <> -1 then
    begin
    retCre:=DMPlan.ModificationCpt(Dataset.FindField(ListeChampOblig.Strings[ListeChampOblig.IndexOf(Dataset.Fields[i].FieldName)]));
    if not RetCre.Retour then
     case RetCre.CodeErreur of
     1000:begin
         NettoieListeChOblig(ListeChampOblig);
         Dataset.Fields[i].FocusControl;
         abort;
         end;
//   18001:begin
//         Dataset.Cancel;
//         showmessage('ce compte présente un solde sur la balance, vous ne pouvez pas le rendre immobilisable.');
//         Dataset.Fields[i].FocusControl;
//         abort;
//         end;
      4001,4002 :begin
//                 DBGrid1.EditorMode:=true;
                 Dataset.Fields[i].FocusControl;
                 abort;
//                 AideTvaAffiche(DBGrid1.InplaceEditor,DBGrid1.InplaceEditor.Text);
//                 abort;
                end;
     end;
    end;
   end;
 end;
end;


procedure TDMPlan.TaPlanCptBeforePost_Import(DataSet: TDataSet);
var
RetCre:TErreurSaisie;
i:integer;
begin
for i:=0 to DataSet.FieldCount - 1 do
    begin
    DataSet.Fields[i].ReadOnly:=false;
    end;
if Dataset.State  in [dsinsert] then
 begin
  for i:=0 to Dataset.FieldCount -1 do
   begin
   if ListeChampOblig.IndexOf(Dataset.Fields[i].FieldName) <> -1 then
    begin
    retCre:=DMPlan.CreationCpt(Dataset.FindField(ListeChampOblig.Strings[ListeChampOblig.IndexOf(Dataset.Fields[i].FieldName)]));
    if not RetCre.Retour then
     case RetCre.CodeErreur of
     1000,1001:begin
         NettoieListeChOblig(ListeChampOblig);
         abort;
         end;
     1002:begin
         Dataset.Cancel;
         NettoieListeChOblig(ListeChampOblig);
         abort;
         end;
      4001,4002 :begin
                  if not AideTvaAffiche(DataSet.Fields[10],DataSet.Fields[0].AsString)
                  then
                    begin
                    abort;
                    end;
                 end;
     14002:begin
             abort;
           end;
     end;
    end;
   end;
   if DMPlan.EnDemandeCreation then
    begin
//     FiltrageDataSet(DataSet,'Compte = '''+DataSet['Compte']+'''');
     DMPlan.EnDemandeCreation:=false;
    end;

 end;

if Dataset.State  in [dsEdit] then
 begin
  for i:=0 to Dataset.FieldCount -1 do
   begin
   if ListeChampOblig.IndexOf(Dataset.Fields[i].FieldName) <> -1 then
    begin
    retCre:=DMPlan.ModificationCpt(Dataset.FindField(ListeChampOblig.Strings[ListeChampOblig.IndexOf(Dataset.Fields[i].FieldName)]));
    if not RetCre.Retour then
     case RetCre.CodeErreur of
     1000:begin
         NettoieListeChOblig(ListeChampOblig);
         Dataset.Fields[i].FocusControl;
         abort;
         end;
//   18001:begin
//         Dataset.Cancel;
//         showmessage('ce compte présente un solde sur la balance, vous ne pouvez pas le rendre immobilisable.');
//         Dataset.Fields[i].FocusControl;
//         abort;
//         end;
      4001,4002 :begin
//                 DBGrid1.EditorMode:=true;
                 Dataset.Fields[i].FocusControl;
                 abort;
//                 AideTvaAffiche(DBGrid1.InplaceEditor,DBGrid1.InplaceEditor.Text);
//                 abort;
                end;
     end;
    end;
   end;
 end;
end;

function TDMPlan.CodeDeTvaDuCompte(compte:string):string;
begin
result:='';
DeFiltrageDataSet(DMRech.TaPlanCptRech);
result:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Compte]).TvaCode;
end;

function TDMPlan.TauxDeTvaDuCompte(compte:string):real;
begin
result:=0;
DeFiltrageDataSet(DMRech.TaPlanCptRech);
result:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Compte]).taux;
end;


procedure TDMPlan.TaPlanBOBeforePost(DataSet: TDataSet);
begin
//if dataset.Fields[dataset.Fields.Index].FieldName = 'Debit_Deb' then

//if dataset.Fields.Index = 2 then
  if  not VerifFNumeric(DataSet.FindField('Credit_Deb')).VideOUZero then
     if not VerifFNumeric(DataSet.FindField('Debit_Deb')).VideOUZero then
   begin
     ShowMessage('Vous ne pouvez pas écrire un montant à la fois au débit et au crédit !');
     abort;
   end;
  if  VerifFNumeric(DataSet.FindField('Credit_Deb')).Vide then
       DataSet.FindField('Credit_Deb').AsCurrency:=0;
  if  VerifFNumeric(DataSet.FindField('Debit_Deb')).Vide then
       DataSet.FindField('Debit_Deb').AsCurrency:=0;

end;

procedure TDMPlan.TaPlanBOAfterPost(DataSet: TDataSet);
begin
if TaPlanCpt.State = dsBrowse then TaPlanCpt.Refresh;
TaPlanBO.FlushBuffers;
end;

procedure TDMPlan.MAJBalManuBalAuto;
var
OldFilter:string;
Begin
// Recuperation des comptes mis à jour manuellement dans la balance d'ouverture
// cad directement dans le planCpt et qui n'existe pas dans la balance automatique
// sauf les classes 6 et 7
QuPrepareMAJBalManuBalAuto.Close;
QuPrepareMAJBalManuBalAuto.Open;

QuPrepareMAJBalManuBalAuto.First;
while not QuPrepareMAJBalManuBalAuto.EOF do
      Begin // Insertion des nouveaux compte dans la balance auto
      if not CptExisteDansBalance(QuPrepareMAJBalManuBalAuto.findfield('compte').AsString) then
      begin
        QuMAJBalManuBlAuto.Close;

        QuMAJBalManuBlAuto.ParamByName('cpte').AsString:=QuPrepareMAJBalManuBalAuto.findfield('compte').AsString;
        QuMAJBalManuBlAuto.ParamByName('Debit_rep').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Credit_Rep').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Debit_Bas').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Credit_Bas').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Debit_Tot').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Credit_Tot').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Qt1_Rep').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Qt2_Rep').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Qt1_Bas').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Qt2_Bas').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Qt1_Tot').AsCurrency:=0;
        QuMAJBalManuBlAuto.ParamByName('Qt2_Tot').AsCurrency:=0;

        QuMAJBalManuBlAuto.ExecSQL;
      end;
      QuPrepareMAJBalManuBalAuto.Next;
      End;

TaBalanceUpdate.Close;
TaBalanceUpdate.Open;

//TaPlanBO.Close;
//TaPlanBO.Open;

OldFilter:=TaPlanBO.Filter;
TaPlanBO.DisableControls;
TaPlanBO.Filter:='compte < 6';    // ne pas utiliser FiltrageDataSet
TaPlanBO.Filtered:=true;          // à cause du DisableControls !!!!!!!!!!!
TaPlanBO.First;

while not TaPlanBO.EOF do
  Begin
   if TaPlanBO.FindField('Ouverture').AsBoolean <> true then
      Begin
       if TaBalanceUpdate.Locate('compte',TaPlanBO.FindField('Compte').AsString,[]) then
        Begin
          TaBalanceUpdate.Edit;
          TaBalanceUpdate.SetFields([TaPlanBO.FindField('Compte').AsString,null,TaPlanBODebit_Deb.ascurrency,TaPlanBOCredit_Deb.ascurrency,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]);
          TableGerePost(TaBalanceUpdate);
          DMBalance.DetruitCptSiVide(TaPlanBO.FindField('Compte').AsString,false,DMBalance.TaBalance);
        End;
      End;
   TaPlanBO.Next;
  End;
TaBalanceUpdate.Close;
TaPlanBO.Filter:=OldFilter;
TaPlanBO.First;
TaPlanBO.EnableControls;
//TaPlanBO.Close;
//TaPlanBO.Open;
End;

procedure TDMPlan.TaPlanCptAfterDelete(DataSet: TDataSet);
begin
DernierCompteSupprime:=DernierCompteSupprimetmp;
TaPlanCpt.FlushBuffers;
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.Create(application.MainForm);
DMAnalytiques.GestionSuppressionRelation_Compte_Atelier(DernierCompteSupprime.Compte,DernierCompteSupprime.ID_GESTANAL);
// Remplit_TInfosplancpt(DAtaSet,DernierCompteSupprimetmp.);
end;

procedure TDMPlan.TaPlanCptBeforeEdit(DataSet: TDataSet);
begin
case e.TypeDossier of
  VerAgricole:begin

              end;
  VerDiocese:begin
               abort;
              end;
end;
if CompteEnCoursDeSaisie(DataSet.FindField('Compte').AsString,nil) then
 begin
   Messagedlg(PChar('Impossible de modifier le compte : '+DataSet.FindField('Compte').AsString+' - '+DataSet.findField('Libelle').AsString+RetourChariotDouble+'Ce compte est en cours d''utilisation dans un écran de saisie !'),MtWarning,[mbok],0);
   abort;
 end;
end;

procedure TDMPlan.TaCptImmosBeforeEdit(DataSet: TDataSet);
begin
if TaPlanCpt.State in [dsInsert,dsEdit] then TableGerePost(TaPlanCpt);
end;

procedure TDMPlan.TaCptImmosAfterEdit(DataSet: TDataSet);
begin
OldValueCpt:=DataSet.Fields[0].AsString;
end;

procedure TDMPlan.TaCptImmosBeforePost(DataSet: TDataSet);
var
retCre:TErreurSaisie;
begin
if DAtaSet.State in [dsEdit] then
 Begin
    retCre:=DMPlan.ModificationCpt(Dataset.FindField('ImmoAmort'));
    if not RetCre.Retour then abort;
 End;
end;

procedure TDMPlan.TaCptImmosBeforeInsert(DataSet: TDataSet);
begin
DemandeCreation('',screen.ActiveControl,false);
abort;
end;



function TDMPlan.TypeCompteCrediteur(Compte:string):boolean;
Begin
result:=false;
if empty(compte)then exit;
 case strtoint_lgr(copy(compte,1,1))of
  4:Begin
      if length(compte)>=4 then
        if copy(compte,4,1)='7'then
          result:=true;
    End;
  6:result:=False;
  7:result:=true;
 else
  begin
   if Compte[1]='+' then
    begin
      case strtoint_lgr(copy(Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[Compte]).Compte,1,1))of
       4:Begin
           if length(compte)>=4 then
             if copy(compte,4,1)='7'then
               result:=true;
         End;
       6:result:=False;
       7:result:=true;
      end;
    end;
  end;
 end;//fin du case compte of
End;


function TDMPlan.FiltrageParamCPTSurComptePourDotation(Famille:integer;Compte,Regime:string):TCompteAmortissement;
var
//TableParamCpt:ttable;
CptTemp:string;
begin
try
  try
  result.CompteAmort:='';
  result.compteDotation:='';
//  TableParamCpt:=TTable.Create(self);
//  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
//  TableParamCpt.TableName:=TaParamCpt.TableName;

//  TableParamCpt.Filtered:=false;
//  TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]);
//  TableParamCpt.Filtered:=true;
//  TableParamCpt.Open;
  FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]));

  DMRech_Obj.TaParamcpt_Obj.first;
  CptTemp:=compte;
  while (DMRech_Obj.TaParamcpt_Obj.RecordCount=0) and (length(CptTemp)>0) do
     begin
      CptTemp:=copy(CptTemp,1,length(CptTemp)-1);

//      TableParamCpt.Filtered:=false;
//      TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,CptTemp]);
//      TableParamCpt.Filtered:=true;

      FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,CptTemp]));
     end;
    while not DMRech_Obj.TaParamcpt_Obj.eof do
     begin
        if ((not (empty(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring)))and(((copy(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring,1,2)='78')or(copy(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring,1,2)='28')or(copy(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring,1,3)='139')))) then
           begin
             result.CompteAmort:=DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring+copy(compte,length(cpttemp)+1,length(compte)-length(cpttemp));
           end
        else
          if ((not (empty(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring)))and(((copy(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring,1,2)='68')or(copy(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring,1,3)='777')))) then
           begin
             result.compteDotation:=DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring+copy(compte,length(cpttemp)+1,length(compte)-length(cpttemp));
           end;
        DMRech_Obj.TaParamcpt_Obj.next;
     end;//fin du while
   except
   showmessage('Problème à la récupération du compte de Dotation !!! ');
   abort;
   end;//fin du try
finally
DeFiltrageDataSet(DMRech_Obj.TaParamcpt_Obj);
//  TableParamCpt.close;
//  TableParamCpt.free;
end;
end;


procedure TDMPlan.TaPlanCptAfterOpen(DataSet: TDataSet);
begin
DataSet.findField('Compte').ValidChars:=['0'..'9'];
DataSet.findField('SensCredit').ValidChars:=[' ','D','C','d','c'];
DataSet.findField('Collectif').ValidChars:=[' ','O','o','N','n'];
DataSet.findField('Rapprochement').ValidChars:=[' ','O','o','N','n'];
DataSet.findField('Immobilisation').ValidChars:=[' ','O','o','N','n'];
DataSet.findField('PlanSaisie').ValidChars:=[' ','O','o','N','n'];
//showmessage('Table du plan ouverte');
end;

procedure TDMPlan.TaPlanBOAfterOpen(DataSet: TDataSet);
begin
//TaPlanBO.OnCalcFields:=TaPlanBOCalcFields;
  try
   FormateMonnaieField(dataset,E.FormatMonnaie,E.EditFormat);

   TaPlanBODebit_Deb.DisplayFormat:=E.FormatMonnaie;
   TaPlanBODebit_Deb.EditFormat:='0.00 ;-0.00 ';

   TaPlanBOCredit_Deb.DisplayFormat:=E.FormatMonnaie;
   TaPlanBOCredit_Deb.EditFormat:='0.00 ;-0.00 ';
   if TaPlanBOCalc.Active then TaPlanBOCalc.Close;
   TaPlanBOCalc.Open;
//
//   TaPlanBODebit_Deb_Calc.DisplayFormat:=E.FormatMonnaie;
//   TaPlanBODebit_Deb_Calc.EditFormat:='0.00 ;-0.00 ';
  except
    MessageDlg('Erreur à l''ouverture de la table TaPlanBo sur les champs calculé dans le module DMPLanCpt ',mtError,[],0);
  end;
end;


function TDMPlan.FiltrageParamCPTSurComptePourImmo_A_Solder(Famille:integer;Compte,Regime:string):string;
var
//TableParamCpt:ttable;
CptTemp:string;
begin
try
  try
  result:='';
//  TableParamCpt:=TTable.Create(self);
//  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
//  TableParamCpt.TableName:=TaParamCpt.TableName;

//  TableParamCpt.Filtered:=false;
//  TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]);
//  TableParamCpt.Filtered:=true;
//  TableParamCpt.Open;

  FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,Compte]));
  DMRech_Obj.TaParamcpt_Obj.first;
  CptTemp:=compte;
  while (DMRech_Obj.TaParamcpt_Obj.RecordCount=0) and (length(CptTemp)>0) do
     begin
      CptTemp:=copy(CptTemp,1,length(CptTemp)-1);

//      TableParamCpt.Filtered:=false;
//      TableParamCpt.Filter:=CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,CptTemp]);
//      TableParamCpt.Filtered:=true;

      FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac1'],[inttostr(Famille),Regime,CptTemp]))
     end;
    while not DMRech_Obj.TaParamcpt_Obj.eof do
     begin
        if ((not (empty(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring)))and(((copy(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring,1,3)='777')or(copy(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring,1,3)='675')))) then
           begin
             result:=DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring;
           end;
        DMRech_Obj.TaParamcpt_Obj.next;
     end;//fin du while
   except
   showmessage('Problème à la récupération du compte de Dotation !!! ');
   abort;
   end;//fin du try
finally
  DeFiltrageDataSet(DMRech_Obj.TaParamcpt_Obj);
//  TableParamCpt.close;
//  TableParamCpt.free;
end;
end;



procedure TDMPlan.QuPrepareMAJBalManuBalAutoFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if ((not((csDestroying)in dataset.ComponentState))and(dataset<>nil)) then
accept:=not DMRech.TaBalanceRech.Locate('Compte',DataSet.findField('Compte').AsString,[]);
end;

procedure TDMPlan.QuPrepareMAJBalManuBalAutoBeforeOpen(DataSet: TDataSet);
begin
DeFiltrageDataSet(DMRech.TaBalanceRech);
DMRech.TaBalanceRech.Open;
end;

procedure TDMPlan.QuCompteUtiliseOuvClotBeforeOpen(DataSet: TDataSet);
Var
ListeTmp:TStringList;
TableNameExclus:String;
begin
  ListeTmp:=TStringList.create;
  ListeNonModifDsBO.Clear;
  ListeNonModifDsBO.Sorted:=true;
  ListeNonModifDsBO.Duplicates:=dupIgnore;
  TableNameExclus:='';
  if dataset <> nil then
  if (DataSet is TTable) then
    TableNameExclus:=(DataSet as TTable).TableName;

  if uppercase(TableNameExclus) <> uppercase(DMRech.TaChargeAPayerRech.TableName) then
  begin
  //or P.Compte in (select distinct Compte from ::Exercice::ChargeAPayer where DateSaisie < :DateDebExo)
    FiltrageDataSet(DMRech.TaChargeAPayerRech,'DateSaisie < '''+ DateToStr(e.DatExoDebut)+'''');
    ChampTableVersVarListe('Compte',DMRech.TaChargeAPayerRech,ListeNonModifDsBO);
    DeFiltrageDataSet(DMRech.TaChargeAPayerRech);
  end;

  if uppercase(TableNameExclus) <> uppercase(DMRech.TaChargesRepartirRech.TableName) then
  begin
  //or P.Compte in (select compte from ChargesRepartir where DateSaisie < :DateDebExo)
    FiltrageDataSet(DMRech.TaChargesRepartirRech,'DateSaisie < '''+ DateToStr(e.DatExoDebut)+'''');
    ChampTableVersVarListe('Compte',DMRech.TaChargesRepartirRech,ListeNonModifDsBO);
    DeFiltrageDataSet(DMRech.TaChargesRepartirRech);
  end;

  if uppercase(TableNameExclus) <> uppercase(DMRech.TaDepensesEntreprisesRech.TableName) then
  begin
  //or P.Compte in (select Compte from DepensesEntreprises where DateSaisie < :DateDebExo)
    FiltrageDataSet(DMRech.TaDepensesEntreprisesRech,'DateSaisie < '''+ DateToStr(e.DatExoDebut)+'''');
    ChampTableVersVarListe('Compte',DMRech.TaDepensesEntreprisesRech,ListeNonModifDsBO);
    DeFiltrageDataSet(DMRech.TaDepensesEntreprisesRech);
  end;

  if uppercase(TableNameExclus) <> uppercase(DMRech.TaEmpruntsRech.TableName) then
  begin
  //or P.Compte in (select compte_emp from Emprunts group by Compte_emp)
    DeFiltrageDataSet(DMRech.TaEmpruntsRech);
    ChampTableVersVarListe('compte_emp',DMRech.TaEmpruntsRech,ListeNonModifDsBO);
  end;

  if uppercase(TableNameExclus) <> uppercase(DMRech.TaPCARech.TableName) then
  begin
  //or P.Compte in (select Compte from PCA where DateSaisie < :DateDebExo)
    FiltrageDataSet(DMRech.TaPCARech,'DateSaisie < '''+ DateToStr(e.DatExoDebut)+'''');
    ChampTableVersVarListe('Compte',DMRech.TaPCARech,ListeNonModifDsBO);
    DeFiltrageDataSet(DMRech.TaPCARech);
  end;

  if uppercase(TableNameExclus) <> uppercase(DMRech.TaProvisionsRech.TableName) then
  begin
  //or P.Compte in (select Compte from Provisions where DateSaisie < :DateDebExo)
    FiltrageDataSet(DMRech.TaProvisionsRech,'DateSaisie < '''+ DateToStr(e.DatExoDebut)+'''');
    ChampTableVersVarListe('Compte',DMRech.TaProvisionsRech,ListeNonModifDsBO);
    DeFiltrageDataSet(DMRech.TaProvisionsRech);
  end;

  if uppercase(TableNameExclus) <> uppercase(DMRech.TaStockRech.TableName) then
  begin
  //or P.Compte in (select Compte from Stock where Date_Saisie < :DateDebExo)
    FiltrageDataSet(DMRech.TaStockRech,'Date_Saisie < '''+ DateToStr(e.DatExoDebut)+'''');
    ChampTableVersVarListe('Compte',DMRech.TaStockRech,ListeNonModifDsBO);
    DeFiltrageDataSet(DMRech.TaStockRech);
  end;

  //***  gérer les immos aussi /// isa le 26/08/03
  if uppercase(TableNameExclus) <> uppercase(DMRech.TaImmosRech.TableName) then
  begin
  //or P.Compte in (select Compte from immos where Date_Achat < DateDebExo)
    FiltrageDataSet(DMRech.TaImmosRech,'Date_Achat < '''+ DateToStr(e.DatExoDebut)+'''');
    ChampTableVersVarListe('Compte',DMRech.TaImmosRech,ListeNonModifDsBO);
    DeFiltrageDataSet(DMRech.TaImmosRech);
  end;

//  if DataSet = QuCompteUtiliseOuvClot then
//  begin
////   Pour les compte pouvant devenir pointable
//  Listetmp:=ListePlanCptPouvantDevenirPointable;
//  CptDevenirPointable('');
//  for i:=0 to Listetmp.Count - 1 do
//    ListeNonModifDsBO.Add(Listetmp.Strings[i]);
//  Listetmp.Free;
//  end;

end;

procedure TDMPlan.QuCompteUtiliseOuvClotAfterOpen(DataSet: TDataSet);
begin
  ChampTableVersVarListe('Compte',DataSet,ListeNonModifDsBO);
end;

procedure TDMPlan.TaCompteFilterRecordCptExclus(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
  if dataset = TaCompte then
    accept:=ListeCptExclusAideCompte.IndexOf(DataSet.FindField('Compte').AsString) = -1;

  if dataset = TaCompteListeUtil then
    accept:=((ListeCptExclusAideCompte.IndexOf(DataSet.FindField('Compte').AsString) = -1) and (not PossedeFils(DataSet.FindField('Compte').AsString)));
  end;
end;


procedure TDMPlan.TaCompteFilterRecordCptReduit(DataSet: TDataSet;
  var Accept: Boolean);
Begin
if not((csDestroying)in dataset.ComponentState) then
  begin
  if dataset = TaCompte then
    accept:=ListeCptReduitAideCompte.IndexOf(DataSet.FindField('Compte').AsString) <> -1;

  if dataset = TaCompteListeUtil then
    accept:=((ListeCptExclusAideCompte.IndexOf(DataSet.FindField('Compte').AsString) <> -1) and (not PossedeFils(DataSet.FindField('Compte').AsString)));
  End;
end;


procedure TDMPlan.TaCompteListeUtilFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
      accept:=not PossedeFils(DataSet.FindField('Compte').AsString);
      if ((accept) and (ParamUtil.PlanDeSaisie = true) and (FAideCompteVisible = true)) then
         accept:=DataSet.FindField('PlanSaisie').asBoolean;
    except
    accept:=true;
    end;
  end;
end;
// Initialise un DAtaSet PlanCpt après une insertion,
// pour mettre comme valeur pas defaut celle du compte pere du plan comptable utilisateur (PCU)
Procedure TDMPlan.InitialiseInsertionCompte(Compte:string;DataSet:TDataSet);
var
  Infosplancpt:TInfosplancpt;
  InfosPlanCPTE:TInfosPlanCPTE;
  PereCompteAux,CompteAux,LibelleAux:String;
Begin
try
   if DataSet = nil then abort;
   If DataSet.State <> dsInsert then abort;
   if not empty(DataSet.FindField('Compte').AsString) then
     CompteAux:=DataSet.FindField('Compte').AsString
   else CompteAux:=Compte;

   LibelleAux:='';
   Initialise_TInfosplancpt(Infosplancpt);
   Initialise_TInfosPlanCPTE(InfosPlanCPTE);

   if not Empty(CompteAux) then
     Begin
     InfosPlanCPTE:=Infos_TInfosPlanCPTE(DMRech.TaPlanCpteRech,'Compte;Regime',[CompteAux,E.Regime]);
     if InfosPlanCPTE.ResultInfos then
     begin
      LibelleAux:=InfosPlanCPTE.Libelle;
      PereCompteAux:=DMPlan.PereComptePCU(CompteAux);
      Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[PereCompteAux]);
     end
     else
     begin
      PereCompteAux:=DMPlan.PereComptePCU(CompteAux);
      Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[PereCompteAux]);
      // Modif demandée pr denis le 30-10-2002:L357 PB
      LibelleAux:=LibelleDuNumCptPCU(PereCompteAux);
     end;
     End;                                               //or(e.TypeClient=CL_Saisie_Cogere)
   if not (((E.TypeEtatExercice = ET_Importation) and ((E.TypeClient = CL_COGERE)))) then
   InitChampAfterInsert([CompteAux,
                         LibelleAux,
                         0,
                         0,
                         Infosplancpt.Un1,
                         Infosplancpt.Un2,
                         0,
                         0,
                         Infosplancpt.PlanSaisie,
                         Infosplancpt.TvaCode,
                         Infosplancpt.TvaType,
                         Infosplancpt.TvaDebit,
                         Infosplancpt.SensCredit,
                         Infosplancpt.Collectif,
                         Infosplancpt.Centraliser,
                         Infosplancpt.Tiers,
                         Infosplancpt.Rapprochement,
                         Infosplancpt.Immobilisation,
                         Infosplancpt.ImmoAmort,
                         Infosplancpt.ImmoDegressif,
                         Infosplancpt.Emprunt,
                         Infosplancpt.Abandonne,
                         E.User,
                         now,
                         0,
                         nil,
                         Infosplancpt.pointable,
                         Infosplancpt.taux,
                         nil
//                         ,
//                         Infosplancpt.ID_GESTANAL,   { isa  le  12/10/04 }
//                         Infosplancpt.CODE_GESTANAL
                         ],dataSet);
   // Spécifique COGERE et en mode importation       //or(e.TypeClient=CL_Saisie_Cogere)
   if ((E.TypeEtatExercice = ET_Importation) and ((E.TypeClient = CL_COGERE))) then
   InitChampAfterInsert([CompteAux,
                         LibelleAux,
                         0,
                         0,
                         Infosplancpt.Un1,
                         Infosplancpt.Un2,
                         0,
                         0,
                         Infosplancpt.PlanSaisie,
                         Infosplancpt.TvaCode,
                         Infosplancpt.TvaType,
                         Infosplancpt.TvaDebit,
                         Infosplancpt.SensCredit,
                         nil,
                         Infosplancpt.Centraliser,
                         nil,
                         Infosplancpt.Rapprochement,
                         Infosplancpt.Immobilisation,
                         Infosplancpt.ImmoAmort,
                         Infosplancpt.ImmoDegressif,
                         Infosplancpt.Emprunt,
                         Infosplancpt.Abandonne,
                         E.User,
                         now,
                         0,
                         nil,
                         nil,
                         Infosplancpt.taux,
                         nil
//                         ,
//                         Infosplancpt.ID_GESTANAL,   { isa  le  12/10/04 }
//                         Infosplancpt.CODE_GESTANAL
                         ],dataSet);
except;
 ShowMessage('Erreur InitialiseInsertionCompte : Le DataSet du plan comptable n''est pas dans le bon etat');
 abort;
end;
end;

procedure TDMPlan.TaCompteFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
      accept:=(length(DataSet.FindField('Compte').AsString) > 2);
//      if ((ParamUtil.PlanDeSaisie = true) and (FAideCompteVisible = true)) then
//         accept:=DataSet.FindField('PlanSaisie').asBoolean and accept;
      if ((accept) and (ParamUtil.PlanDeSaisie = true) and (FAideCompteVisible = true)) then
         accept:=DataSet.FindField('PlanSaisie').asBoolean;
    except
      accept:=false;
    end;
  end;
end;

// Fonction qui verifie si un compte est inscrit dans la liste des comptes en cours d'utilisation
// dans un écran de saisie
// si on passe nil à l'objet, la recherche se fait sur le compte ( valable uniquement à partir de plancpt)
Function TDMPlan.CompteEnCoursDeSaisie(Compte:String;Objet:TObject):Boolean;
begin
result:=(FListeCompteEnCoursDeSaisie <> nil);
if objet <> nil then
 begin
   if result then
    result:=(FListeCompteEnCoursDeSaisie.IndexOfObject(Objet) <> -1);
 end
 else
 begin
   if result then
    result:=(FListeCompteEnCoursDeSaisie.IndexOf(Compte) <> -1);
 end;
end;

// Ajoute (Ajout = true) ou supprime (Ajout = False) un élément dans la liste des comptes
// utilisé dans un écran de saisie
Procedure TDMPlan.GestionCompteEnCoursDeSaisie(Compte:String;Objet:TObject;Ajout:Boolean);
var
result:boolean;
IndexSuppr : integer;
Begin
  result:=(FListeCompteEnCoursDeSaisie <> nil);
 if not ajout then
  begin
    if result then
     begin
         IndexSuppr:=FListeCompteEnCoursDeSaisie.IndexOfObject(Objet);
         if  IndexSuppr <> -1 then
            FListeCompteEnCoursDeSaisie.Delete(IndexSuppr);
     end;
  end
  else
  begin
   if result then
    begin
    if not CompteEnCoursDeSaisie(Compte,Objet) then
     FListeCompteEnCoursDeSaisie.AddObject(Compte,Objet);
    end
    else
    begin
     FListeCompteEnCoursDeSaisie:=TStringList.Create;
     if not CompteEnCoursDeSaisie(Compte,Objet) then
      FListeCompteEnCoursDeSaisie.AddObject(Compte,Objet);
    end;
  end;

//
End;

Procedure TDMPlan.AjouteCompteEnCoursDeSaisie(Value : TStringList);
Begin
//
End;


procedure TDMPlan.TaPlanBOCalcCalcFields(DataSet: TDataSet);
begin
try
DataSet.FindField('Ouverture').AsBoolean:=(ListeNonModifDsBO.IndexOf(dataset.FindField('Compte').AsString) <> -1);
//  TaPlanBOOuverture.AsBoolean:=QuCompteUtiliseOuvClot.Locate('Compte',dataset.FindField('Compte').AsString,[]);
  if str_commence_par(dataset.FindField('Compte').AsString,DM_C_CompteAmortDerogatoire)
   then DataSet.FindField('Ouverture').AsBoolean:=Derogatoire;
  //  dataset.FindField('Ouverture').Value:=QuCompteUtiliseOuvClot.Locate('Compte',dataset.FindField('Compte').AsString,[]);
    if DMDiocEtatBal <> nil then
     begin
      if DMDiocEtatBal.TaBalanceCalc.Locate('Compte',dataset.FindField('Compte').AsString,[]) then
       begin
         dataset.FindField('Debit_Deb_Calc').AsCurrency:=DMDiocEtatBal.TaBalanceCalc.findField('Debit_Report').AsCurrency;
         dataset.FindField('Credit_Deb_Calc').AsCurrency:=DMDiocEtatBal.TaBalanceCalc.findField('Credit_Report').AsCurrency;
       end;
     end;
except
//showmessage('erreur sur le calc field plan Bo');
end;

end;


function TDMPlan.FiltrageSurComptePourOD(Famille,Nb:integer;compte,Regime:string):TCompte1;
var
Liste1:TStringList;
begin
Liste1:=TStringList.Create;
liste1:=DMPlan.FiltrageParamCPTSurComptePourOD(Famille,Nb,compte,Regime);
 if liste1.Count>0 then
 begin
 if liste1.count>1 then
   result.CompteReprise :=liste1[1];
 result.CompteDotation:=liste1[0];
 end;
liste1.Free;
end;


Function VerifSiCompteSaisieDsGestionDesImmos(Compte:string;Mess:boolean):boolean;
var
InfosImmos:TInfosImmos;
Begin
result:=false;
result:=not empty(compte);
if result then
 begin//si compte rempli
    try
      DeFiltrageDataSet(DMRech.TaImmosRech);
      InfosImmos:=Infos_TInfosImmos(DMRech.TaImmosRech,'Compte',[Compte]);
      result:=InfosImmos.ResultInfos;
       if result and mess then
          Showmessage('Le compte : '+InfosImmos.Compte+RetourChariotDouble+' est déjà utilisé dans le module de gestion des immobilisations, vous ne pouvez pas le décocher ');
    except
     Showmessage('Un problème est apparu lors de la recherche du compte : '+Compte+' dans le module de gestion des immobilisations');
     abort;
    end;
 end;//fin si compte rempli
End;

Procedure TDMPlan.Import_Plan(Valeurs:array of const;DataSet:TDataSet);
Begin
  try
   ImportTable(Valeurs,DataSet);
  except
   abort;
  end;
End;

Procedure TDMPlan.Import_Plan_SIEA(Valeurs:array of const;DataSet:TDataSet);
Begin
  try
   if DMRech.TaPlanCptRech.Locate('Compte',String(Valeurs[0].VAnsiString),[]) then
    begin                                    
     If not Dataset.Active then DataSet.Open;
     DataSet.Locate('Compte',String(Valeurs[0].VAnsiString),[]);
     DataSet.Edit;
     DataSet.FindField('Libelle').AsString := String(Valeurs[1].VAnsiString);
     DataSet.FindField('Un1').AsString := String(Valeurs[4].VAnsiString);
     DataSet.FindField('CodeTva').AsString := String(Valeurs[9].VAnsiString);
     DataSet.Post;
    end
     else
    begin
     If not Dataset.Active then DataSet.Open;
     if dataSet.State in [dsEdit,dsInsert] then DataSet.Post;
     ImportTable(Valeurs,DataSet);
    end;
  except
   abort;
  end;
End;

Procedure TDMPlan.Import_BilanOuverture(Valeurs:array of const;DataSet:TDataSet);
//// Vérification sur la possibilité de mise des report début d'un compte
//// on ne peut pas mettre à jour son report si :
////          c'est un compte de classes 6 ou 7
////          c'est un compte collectif
////          c'est un compte pointable
////          c'est un compte liés à un code de TVA dans les paramètres TVA
//Function ImporterCpt(Cpt:String):Boolean;
//var
//Infosplancpt:TInfosplancpt;
//Begin
//  result:=false;
//  try
//    result:=not (str_commence_par(Cpt,'6') or str_commence_par(Cpt,'7'));
//    if result then
//     begin
//       Infosplancpt:=Infos_TInfosplancpt(DMREch.TaPlanCptRech,'Compte',[Cpt]);
//       if Infosplancpt.ResultInfos then
//        result:= not Infosplancpt.Collectif;
//        if result then result:=not Infosplancpt.pointable;
//        if result then result:=not FTvaCompteDeTva(Cpt);
//     end;
//  except
//   result:=false;
//  end;
//End;

Begin
  try
    if Dataset.State = dsinactive then DataSet.Open;
    If not (Dataset.State <> dsBrowse) then
     begin
       DataSet.Open;
       if not GrLocate(DAtaSet,'Compte',[String(Valeurs[0].VAnsiString)]) then
        begin
          showmessage('Erreur Importation Bilan d''ouverture : Le Compte : ' +String(Valeurs[0].VAnsiString)+
                      ' n''a pas été trouvé !');
          abort;
        end;
       if ImporterCpt(String(Valeurs[0].VAnsiString)) then
         Begin
           DataSet.Edit;
           try
             DataSet.SetFields([nil,nil,Valeurs[2].VCurrency^,Valeurs[3].VCurrency^]);
             TableGerePost(DataSet);
           except
             DataSet.Cancel;
             SysUtils.Abort;
           end;
         End;
    end
    else
    begin
     showmessage('Erreur Importation : Le dataset d''importation est en mode : '+ EtatdataSetString(Dataset));
      SysUtils.Abort;
    end;
  except
   abort;
  end;
End;

// Vérification sur la possibilité de mise des report début d'un compte
// on ne peut pas mettre à jour son report si :
//          c'est un compte de classes 6 ou 7
//          c'est un compte collectif
//          c'est un compte pointable
//          c'est un compte liés à un code de TVA dans les paramètres TVA
Function TDMPlan.ImporterCpt(Cpt:String):Boolean;
var
Infosplancpt:TInfosplancpt;
Begin
  result:=false;
  try
    result:=not (str_commence_par(Cpt,'6') or str_commence_par(Cpt,'7'));
    if result then
     begin
       Infosplancpt:=Infos_TInfosplancpt(DMREch.TaPlanCptRech,'Compte',[Cpt]);
       if Infosplancpt.ResultInfos then
        result:= not Infosplancpt.Collectif;
        if result then result:=not Infosplancpt.pointable;
        if result then result:=not FTvaCompteDeTva(Cpt);
     end;
  except
   result:=false;
  end;
End;

Procedure TDMPlan.Import_BO_SIEA_DOS(Valeurs:array of const;DataSet:TDataSet);
var
NumCpt,Libelle:String;
Begin
  try
    if Dataset.State = dsinactive then DataSet.Open;
    If not (Dataset.State <> dsBrowse) then
     begin
       DataSet.Open;
       NumCpt:=String(Valeurs[0].VAnsiString);
       Libelle := String(Valeurs[1].VAnsiString);
       while ((length(NumCpt)>3) and (not DAtaSet.Locate('Compte',NumCpt,[]))) do
         begin
          if ((not DAtaSet.Locate('Compte',NumCpt,[])) and (copy(NumCpt,length(numCpt),1)='0')) then
//          if ((not GrLocate(DAtaSet,'Compte',[NumCpt])) and (copy(NumCpt,length(numCpt),1)='0')) then
           begin
            Delete(NumCpt,length(NumCpt),1);
           end
           else
            exit;
         end;

       if not GrLocate(DAtaSet,'Compte',[NumCpt]) then
        begin
//          showmessage('Erreur Importation Bilan d''ouverture : Le Compte : ' +String(Valeurs[0].VAnsiString)+
//                      ' n''a pas été trouvé !');
          DemandeCreation(NumCpt,nil,false);
          DataSet.Refresh;
       if not GrLocate(DAtaSet,'Compte',[NumCpt]) then
        begin
          showmessage('Erreur Importation Bilan d''ouverture : Le Compte : ' +NumCpt+
                      ' n''a pas été trouvé !');
          abort;
        end;
        end;
//       Showmessage('Ne pas importer les comptes collectifs');
       if ImporterCpt(NumCpt) then
        begin
         DataSet.Edit;
         try
           DataSet.SetFields([nil,Libelle,Valeurs[2].VCurrency^,Valeurs[3].VCurrency^]);
           TableGerePost(DataSet);
         except
           DataSet.Cancel;
           SysUtils.Abort;
         end
        end
        else // Traitement des compte 6 et 7 pour mises à jour des libellés des comptes!!!
        if (str_commence_par(NumCpt,'6') or str_commence_par(NumCpt,'7')) then
        begin
         DataSet.Edit;
         try
           DataSet.SetFields([nil,Libelle,nil,nil]);
           TableGerePost(DataSet);
         except
           DataSet.Cancel;
           SysUtils.Abort;
         end
        end;
    end
    else
    begin
     showmessage('Erreur Importation : Le dataset d''importation est en mode : '+ EtatdataSetString(Dataset));
      SysUtils.Abort;
    end;
  except
   abort;
  end;
End;

Procedure TDMPlan.Import_BO_SIEA_DOS_MAJ(Valeurs:array of const;DataSet:TDataSet);
var
NumCpt,Libelle:String;
Begin
  try
    if Dataset.State = dsinactive then DataSet.Open;
    If not (Dataset.State <> dsBrowse) then
     begin
       DataSet.Open;
       NumCpt:=String(Valeurs[0].VAnsiString);
       Libelle := String(Valeurs[1].VAnsiString);
       while ((length(NumCpt)>3) and (not DAtaSet.Locate('Compte',NumCpt,[]))) do
         begin
          if ((not DAtaSet.Locate('Compte',NumCpt,[])) and (copy(NumCpt,length(numCpt),1)='0')) then
//          if ((not GrLocate(DAtaSet,'Compte',[NumCpt])) and (copy(NumCpt,length(numCpt),1)='0')) then
           begin
            Delete(NumCpt,length(NumCpt),1);
           end
           else
            break;
         end;

       if not GrLocate(DAtaSet,'Compte',[NumCpt]) then
        begin
          try
            If not (Dataset.State <> dsBrowse) then
             begin
               DataSet.Open;
               DataSet.Insert;
               try
                 InitialiseInsertionCompte(NumCpt,DataSet);
//                 if numCpt = '6042' then showmessage('stop');
                 DataSet.FindField('Compte').AsString := NumCpt;
                 DataSet.FindField('Libelle').AsString := Libelle;
//                 DataSet.SetFields([NumCpt,Libelle]);
          //       InitChampAfterInsert(Valeurs,DataSet);  // PB le 06/05/03
                 TableGerePost(DataSet);
               except
                 DataSet.Cancel;
                 showmessage(NumCpt+' ' +Libelle);
                 SysUtils.Abort;
               end;
            end
            else
            begin
             showmessage('Erreur Importation : Le dataset d''importation est en mode : '+ EtatdataSetString(Dataset));
              SysUtils.Abort;
            end;
//           ImportTable([NumCpt,Libelle],DataSet);
          except
           abort;
          end;
       end;
    end
    else
    begin
     showmessage('Erreur Importation : Le dataset d''importation est en mode : '+ EtatdataSetString(Dataset));
      SysUtils.Abort;
    end;
  except
   abort;
  end;
End;


Function TDMPlan.NomTablePrincipale:TDataSet;
Begin
result:=DMPlan.TaPlanCpt;
End;

// Controle et ajoute les comptes obligatoirement présent dans le plan utilisateur
// Utilisé essentiellement après une importation
Procedure TDMPlan.GestionDesComptesObligatoireDsPlanCpt(AffichMess:boolean);
var
ListeTmp,ListeAjout:TStringList;
i:integer;
AffichSiCreation:Boolean;
ParamGenerCptAffiche:TParamGenerCptAffiche;
Begin
ListeTmp:=TStringList.Create;
ListeAjout:=TStringList.Create;
ListeAjout.Clear;
ListeTmp:=DM_C_ListeCptObligatoire;
AffichSiCreation:=not AffichMess;
AffichSiCreation:=false;
if not TaCompte.Active then TaCompte.Open;
if AffichMess then
   ShowMessage('Epicéa va maintenant vérifier que votre Plan Comptable '+
            RetourChariotDouble+
            'possède tous les comptes nécessaire à son bon fonctionnement !');
for i:=0 to ListeTmp.Count-1 do
 begin
  if Not CompteExistePCU(ListeTmp.Strings[i]) then
   begin
    if AffichSiCreation then
     begin
      MessageDlg('Epicéa2 a détecté qu''il manque un ou plusieurs comptes'+#13+#10+'dans votre plan comptable.'+#13+#10+'Ils vont être créés maintenant !', mtInformation, [mbOK], 0);
      AffichSiCreation := false;
     end;
    TaCompte.Insert;
//    DMPlan.TaCompte.SetFields([ListeTmp.Strings[i],DMPlan.LibelleDuNumCpt(ListeTmp.Strings[i])]);
//    DMPlan.TaCompte.InsertRecord([ListeTmp.Strings[i],DMPlan.LibelleDuNumCpt(ListeTmp.Strings[i])]);
    InitialiseInsertionCompte(ListeTmp.Strings[i],TaCompte);
    TaCompte.FlushBuffers;
    ParamGenerCptAffiche.Affiche:=false;
    CreationAuto(ListeTmp.Strings[i],ParamGenerCptAffiche);
    ListeAjout.Add(ListeTmp.Strings[i]);
   end;
 end;
if AffichMess then
  begin
    if ListeAjout.Count > 0 then
     begin
          if MessageDlg('Epicéa à créé : '+
                    IntToStr(ListeAjout.Count)+
                    ' compte(s) dans votre Plan Comptable !'+
                    RetourChariotDouble+
                    'Voulez-Vous voir la liste ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
                        AfficheInfoObjet('Liste des comptes ajoutés.',ListeAjout,true);
     end
    else
     begin
      MessageDlg('Fin de la vérification !', mtInformation, [mbOK], 0);
     end;
  end;
ListeTmp.Free;
ListeAjout.free;
End;

procedure TDMPlan.QuGrandLivreCgEditionCalcFields(DataSet: TDataSet);
begin
    QuGrandLivreCgEditionReferencePiece.AsString:= QuGrandLivreCgEditionReference.AsString+' '+QuGrandLivreCgEditionLibelle_1.AsString;
end;

Function TDMPlan.VerifSoldeCompteDansBO(Compte:string):Tcalcul;
var
InfosReport:TInfosReport;
Infosplancpt:TInfosplancpt;
Begin
   try
      try
        if DMPlan <> nil then
         if DMPlan.TaPlanBO.State in [dsInsert,dsEdit] then
         begin
           TableGerePost(DMPlan.TaPlanBO);
         end;
         initialise_TCalcul(result);
        if e.AccesOuverture=false then
          Begin //si pas 1ere ouverture, alors on utilise la table Report
              //on recherche le solde de ce compte dans la table Report
              DeFiltrageDataSet(DMRech.TaReportRech);
              InfosReport:=Infos_TInfosReport(DMRech.TaReportRech,'Compte',[Compte]);
              result.Retour:=InfosReport.ResultInfos;
              if result.Retour then
                begin
                 if not VerifNumeric(CurrToStr(InfosReport.Debit_Report)).VideOUZero then
                   begin
                     result.Total:=InfosReport.Debit_Report;
                     result.SensTotal:=-1;
                   end
                 else
                   begin
                     result.Total:=InfosReport.Credit_Report;
                     result.SensTotal:=1;
                   end;
                end;
          end//fin si pas 1ere ouverture, alors on utilise la table Report
        else
          Begin//si 1ere ouverture
              //on recherche le solde de ce compte dans le bilan d'ouverture
              DeFiltrageDataSet(DMRech.TaPlanCptRech);
              Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Compte]);
              result.Retour:=Infosplancpt.ResultInfos;
              if result.Retour then
                begin
                 if not VerifNumeric(CurrToStr(Infosplancpt.Debit_Deb)).VideOUZero then
                   begin
                     result.Total:=Infosplancpt.Debit_Deb;
                     result.SensTotal:=-1;
                   end
                 else
                   begin
                     result.Total:=Infosplancpt.Credit_Deb;
                     result.SensTotal:=1;
                   end;
                end;
          end;//fin si 1ere ouverture
        result.Retour:=result.Total<>0;
        if not result.retour then initialise_TCalcul(result);
      except
       Showmessage('Un problème est apparu lors de la recherche du compte : '+Compte+' dans le bilan d''ouverture');
       result.Retour:=false;
      end;
   finally
   end;
End;


function TDMPlan.FiltrageParamCPTSurCompteDotation_PourRecupCompteImmos(Famille:integer;Compte,Regime:string):string;
var
//TableParamCpt:ttable;
CptTemp:string;
begin
try
  try
  result:='';
//  TableParamCpt:=TTable.Create(self);
//  TableParamCpt.DatabaseName:=TaParamCpt.DatabaseName;
//  TableParamCpt.TableName:=TaParamCpt.TableName;

  FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac2'],[inttostr(Famille),Regime,Compte]));

  DMRech_Obj.TaParamcpt_Obj.first;
  CptTemp:=compte;
  while (DMRech_Obj.TaParamcpt_Obj.RecordCount=0) and (length(CptTemp)>0) do
     begin
      CptTemp:=copy(CptTemp,1,length(CptTemp)-1);
      FiltrageDataSet(DMRech_Obj.TaParamcpt_Obj,CreeFiltreET(['Famille','Regime','Rac2'],[inttostr(Famille),Regime,CptTemp]));
     end;
    while not DMRech_Obj.TaParamcpt_Obj.eof do
     begin
        if ((not (empty(DMRech_Obj.TaParamcpt_Obj.Fields[3].asstring)))and(((copy(DMRech_Obj.TaParamcpt_Obj.Fields[3].asstring,1,1)='2')or(copy(DMRech_Obj.TaParamcpt_Obj.Fields[4].asstring,1,2)='13')))) then
           begin
             result:=DMRech_Obj.TaParamcpt_Obj.Fields[3].asstring+copy(compte,length(cpttemp)+1,length(compte)-length(cpttemp));
           end;
        DMRech_Obj.TaParamcpt_Obj.next;
     end;//fin du while
   except
   showmessage('Problème à la récupération du compte de Dotation !!! ');
   abort;
   end;//fin du try
finally
  DeFiltrageDataSet(DMRech_Obj.TaParamcpt_Obj);
//  TableParamCpt.close;
//  TableParamCpt.free;
end;
end;


Function TDMPlan.CompteImmobilisation(Cpt:string):boolean;
Begin
    result:=false;
  try
  DeFiltrageDataSet(DMRech.TaPlanCptRech);
  if GrLocate(DMRech.TaPlanCptRech,'Compte',[cpt]) then
   begin
     result:=DMRech.TaPlanCptRech.FindField('Immobilisation').asboolean;
   end;
  except
    result:=false;
    abort;
  end;
End;


Procedure TDMPlan.MiseAJourTauxParDefaut;
var
Requete:TQuery;
begin
  try//finally
    Requete:= TQuery.Create(self);
    Requete.DatabaseName:=DMPlan.TaPlanCpt.DatabaseName; 
    //on traite les taux à 2.10 %
    Requete.close;
    Requete.SQL.Clear;
    Requete.SQL.add('update PlanCpt.Db  set Taux =2.1 where compte like(''6181%'')or compte like(''6183%'')');
    Requete.ExecSQL;
    //on traite les taux à 5.5 %
    Requete.close;
    Requete.SQL.Clear;
    Requete.SQL.add('update PlanCpt.Db  set Taux =5.5 where compte like(''211%'')or compte like(''6011%'')or compte like(''601'')or compte like(''6010%'')or compte like(''6012%'')or compte like(''6013%'')or compte like(''6014%'')or compte like(''604%'')or compte like(''609%'')');
    Requete.ExecSQL;
    //on traite les Code Tva à A2 => A1
    Requete.close;
    Requete.SQL.Clear;
    Requete.SQL.add('update PlanCpt.Db  set tvacode =''A1'' where tvacode =''A2''');
    Requete.ExecSQL;
    //on traite le Code Tva à A2 => A1 dans table des CodeTVA
    Requete.close;
    Requete.SQL.Clear;
    Requete.SQL.add('update TvaCode.Db  set tvacode =''A1'' where tvacode =''A2''');
    Requete.ExecSQL;

  finally
    Requete.close;
    Requete.Free;
  end;//fin finally
end;



Function TDMPlan.PossedeEcritureSurPeriode (cpte : string;DemandePeriode:Boolean): boolean;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
Begin
try//finally
  if DemandePeriode then
   begin
     if Choix_Periode=nil then Choix_Periode:=tChoix_Periode.Create(application.MainForm);
     Choix_Periode.EdDateFin.Enabled:=false;
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
   end
  else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin :=  E.DatExoFin;
    end;

  if periode.Retour then
   begin//si période ok
      Result:=false;
      if dmrech.TaEcritureRech.Filtered then
       begin
        MessageDlg('PossedeEcritureSurPeriode : La Table TaEcritureRech doit être filtrée avant cet appel!', mtWarning, [mbOK], 0);
        DeFiltrageDataSet(dmrech.TaEcritureRech);
       end;
      FiltrageDataSet(dmrech.TaEcritureRech,'Date >= '''+DateToStr_Lgr(periode.DateDeb)+''' and Date <='''+DateToStr_Lgr(periode.DateFin)+'''');
      if length(cpte) > 0 then
         if cpte[1]='+' then
          begin
           with dmrech.TaEcritureRech do
             begin
// PB le 24/02/04              IndexFieldNames:='Tiers';
              Result:=Locate('Tiers',cpte,[]);
             End;
          end
          else
          begin
            with dmrech.TaEcritureRech do
              begin
// PB le 24/02/04                IndexFieldNames:='Compte';
                Result:=Locate('Compte',cpte,[]);
              End;
          end;
   end;//fin si période ok
finally
DeFiltrageDataSet(dmrech.TaEcritureRech);
end;
end;


Procedure TDMPlan.GestionAccesPlanBO;
begin
if E.AccesOuverture then
 begin
  TaPlanBO.BeforeInsert := TaPlanBOBeforeInsert;
  TaPlanBO.BeforeEdit := TaPlanBOBeforeEdit;
  TaPlanBO.BeforeDelete := TaPlanBOBeforeInsert;
 end
else
 begin
  TaPlanBO.BeforeInsert := TaPlanBOBeforeEIDClo_Abort;
  TaPlanBO.BeforeEdit := TaPlanBOBeforeEIDClo_Abort;
  TaPlanBO.BeforeDelete := TaPlanBOBeforeEIDClo_Abort;
 end;
end;

procedure TDMPlan.TaPlanBOBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesOuverture then
 MessageDlg('Vous ne pouvez plus modifier le bilan d''ouverture !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier le bilan d''ouverture !', mtError, [mbOK], 0);
abort;
End;

Procedure TDMPlan.MarquerListeBooleenPlan(DAtaSet:TDataSet;TypeChamp,TypeMarquage:Integer);
var
CompteDep:String;
Begin
 try
   Screen.Cursor := crSQLWait;

   if not (DataSet is TTable) then
     begin
      MessageDlg('TDMPlan.MarquerListeBooleenPlan : Ne peut faire cette opération sur les objets de type : '+DAtaSet.ClassName, mtError, [mbOK], 0);
      abort;
     end;
  if IndexTableEpicea((DataSet as TTable).TableName) <> C_IPlanCpt then
     begin
      MessageDlg('TDMPlan.MarquerListeBooleenPlan : Ne peut faire cette opération sur la table : '+(DataSet as TTable).TableName, mtError, [mbOK], 0);
      abort;
     end;
   DataSet.DisableControls;
   CompteDep:=(DataSet as TTable).FindField('Compte').AsString;
   DataSet.First;
   case TypeMarquage of
     C_Cocher:if MessageDlg('Etes-Vous sûr de vouloir cocher la sélection courante ?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then abort;
     C_DeCocher:if MessageDlg('Etes-Vous sûr de vouloir décocher la sélection courante ?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then abort;
   else ;
   end;

   case TypeChamp of
     C_Plan_Update_Plan_Saisie:Begin
                                 while not DataSet.Eof do
                                   begin
                                    MarquerCompteBooleenPlan((DataSet as TTable).FindField('Compte').AsString,TypeChamp,TypeMarquage);
                                    DataSet.Next;
                                   end;
                                end;

     C_Plan_Update_Plan_TvaDebit:while not DataSet.Eof do
                                   begin
                                   if (DataSet as TTable).FindField('Compte').AsString >= '7' then
                                      MarquerCompteBooleenPlan((DataSet as TTable).FindField('Compte').AsString,TypeChamp,TypeMarquage);
                                    DataSet.Next;
                                   end;
   else ;
   end;

 Finally
   Screen.Cursor := crDefault;
   DataSet.Refresh;
   DataSet.Locate('Compte',CompteDep,[]);
   ReEnableControls(DataSet);
//   Taplancpt.EnableControls;
 end;
End;

Procedure TDMPlan.MarquerCompteBooleenPlan(Compte:String;TypeChamp,TypeMarquage:Integer);
Begin
if TaPlanCpt.Active then
 if not (TaPlanCpt.State in [dsEdit,dsInsert]) then
  begin
   QuPlanCpt.Close;
   QuPlanCpt.SQL.Clear;
   case TypeChamp of
     C_Plan_Update_Plan_Saisie:case TypeMarquage of
                                 C_Cocher:QuPlanCpt.SQL.Add('update plancpt set PlanSaisie=true where Compte='''+Compte+'''');
                                 C_DeCocher:QuPlanCpt.SQL.Add('update plancpt set PlanSaisie=False where Compte='''+Compte+'''');
                            //     C_Inverse:QuPlanCpt.SQL.Add('update plancpt set PlanSaisie=not PlanSaisie where Compte='''+Compte+'''');  Ne marche pas !!!!!
                               else MessageDlg('TDMPlan.MarquerCompteBooleenPlan : TypeMarquage non défini !', mtError, [mbOK], 0);
                               end;

     C_Plan_Update_Plan_TvaDebit:case TypeMarquage of
                                 C_Cocher:QuPlanCpt.SQL.Add('update plancpt set TvaDebit=true,tvatype=''D'' where TvaCode <> '''' and Compte='''+Compte+'''');
                                 C_DeCocher:QuPlanCpt.SQL.Add('update plancpt set TvaDebit=False,tvatype=''E'' where TvaCode <> '''' and Compte='''+Compte+'''');
                            //     C_Inverse:QuPlanCpt.SQL.Add('update plancpt set PlanSaisie=not PlanSaisie where Compte='''+Compte+'''');  Ne marche pas !!!!!
                               else MessageDlg('TDMPlan.MarquerCompteBooleenPlan : TypeMarquage non défini !', mtError, [mbOK], 0);
                               end;
   else MessageDlg('TDMPlan.MarquerCompteBooleenPlan : TypeChamp non défini !', mtError, [mbOK], 0);
   end;

   QuPlanCpt.ExecSQL;
//   CorrectionPlanComptable(false);
  end;
End;

procedure TDMPlan.QuPlanCpt_EditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ListeEdit.IndexOf(DAtaSet.findField('Compte').AsString) <> -1;
end;


// Détermine le sens d'une quantité en fonction du parametre "SensCredit" du compte
Function DetermineQte_Cpt(Qte:real;Debit,Credit:Currency;Cpt:string):real;
Begin
if dmrech=nil then dmrech:=Tdmrech.Create(application.MainForm);
result:=Qte;
DetermineSolde(Debit,Credit);
DeFiltrageDataSet(dmrech.TaPlanCptRech);
if dmrech.TaPlanCptRech.locate('Compte',Cpt,[]) then
  Begin
    result:=abs(Qte);//on initialise par la valeur absolue qui représente le +
    if ((dmrech.TaPlanCptRech.findfield('SensCredit').AsBoolean)and (Debit>0)) then
      result:=result*-1
    else
    if ((dmrech.TaPlanCptRech.findfield('SensCredit').AsBoolean=false)and (Credit>0)) then
      result:=result*-1;
  end;
End;



function TDMPlan.ListeContientDebutCpt(Cpt:string;Famille:integer):boolean;
var
Liste:Tstringlist;
Valeur:string;
i:integer;
begin
  liste:=TStringlist.Create;
  Liste:=DMPlan.FiltrageAideCompte(Famille,nil,DMPlan.TaCompteFilterRecord);
  for i:=0 to liste.count-1 do
    begin
       valeur:=str_remplacesouschaine(liste.Strings[i],'*','');
       result:=Valeur=cpt;
       if not result then
         result:=str_commence_par(Valeur,cpt);
       if result then exit;
    end;
end;


end.
