{***************************************************************
 *
 * Unit Name: DMImmos
 * Purpose  :
 * Author   :  Blanchard
 * History  :
 *
 ****************************************************************}
{//////// le 29-04-03  Modif_Isa
j'ai modifier la fonction Amort_lin_SurBase360 ,et rajouter les fonctions suivantes
VerifSiPieceDecriteDansLesCessions,VerifSiEcritureDecriteDansLesCessions
///////}
unit DMImmos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db,DMClotures,Gr_Librairie_Obj,E2_Decl_Records,stdctrls,LibSQL,
  LibDates,E2_Librairie_Obj,LibZoneSaisie,E2_LibInfosTable,Variants,
  editions,shellapi,ChoixPeriode,lib_chaine,
  ObjetEdition,
  Printers,
  E2_Patientez,
  DMConstantes,
  DMProgramme,
  LibRessourceString;

const ChampPublies=', ID,Libelle,Ecriture_Achat,Ecriture_Cession,Compte,Code,Sous_Code,Date_Org,Valeur_Org,Valeur_Venale,Duree,Valeur_a_Amortir'+
',Date_Achat,Date_Mise_en_Service,Duree_Amt,Type_Amt,Deduc_Invest,Mt_Deduc_Invest,Reprise_deduc_invest,Valeur_Nette,Amort_Eco'+
',Amort_Derog,Mt_Cession,Date_Cession,Rebut,Achat_dans_Annee,Cession_dans_Annee,Duree_Restante,Simulation,Sous_Compte'+
',Maxi,Mini,Choix,Eco,Terminee,EnCours,CodeTerminee,CompteTerminee,sousCodeTerminee,TauxAmo,Tiers,ReferenceFacture,MontantTTC';


type
 TTypeModif=(RxNonModifies,RxMini,RxMaxi,RxInitMini,RxInitMaxi,RxInconnu);
   TMinMax = record
     Mini, Maxi,MiniCumul,AmortCumulMini,AmortCumulMaxi,Eco,Derog : Currency;
     pere, annee : integer; // pere met en rapport avec l'élément ancetre
   end;
	TValeur = array[1..31] of TMinMax; // traitement sur 5 ans
	TValeurSimplifie = array[1..5] of TMinMax; // traitement sur 5 ans


TParamDMImmos=record
   typeImmos:TtypeImmos;
   typeAmort:TTypeAmort;
   TypePresentation:integer;
   Quand:Integer;
   QuiAppel:TTypeFenetre;
   ImmosDataStateChange:TNotifyEvent;
   TimerEvent:TNotifyEvent;
   TimerDisabled:TNotifyEvent;
   ImmosAfterScroll:TDataSetNotifyEvent;
   CptImmosAfterScroll:TDataSetNotifyEvent;
   CptImmosAfterOpen:TDataSetNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
   Tag:integer;
   ImmoCourante:integer;
   verrouillage:boolean;
   Periode:TPeriode;
   TypeModif:TTypeModif;
  end;

  TInfosCession=record
     Ecriture_Cession:Integer;
     Mt_Cession:Currency;
     Date_Cession:TDate;
     Cession_dans_Annee:boolean;
  end;

  TinfosRebut=record
     Mt_Cession:Currency;
     Date_Cession:TDate;
     Cession_dans_Annee:boolean;
     Rebut:boolean;
  end;

  TinfosDivision=record
     Compte:string;
     Code:string;
     Sous_Code:string;
     Libelle:String;
     Valeur_Acq:Currency;
     Valeur_A_Amortir:currency;
     Amort_Eco:currency;
     Amort_Derog:currency;
  end;

  TinfosDetailAcquis=record
         id:integer;
         Libelle:String;
         Date_Achat:Tdate;
         Ecriture_Achat:Integer;
         Deduc_Invest:boolean;
         Reprise_deduc_invest:Currency;
         Amort_Eco:Currency;
         Amort_Derog:Currency;
         Duree_Amt:Integer;
         Mt_Cession:Currency;
         Rebut:boolean;
         Achat_dans_Annee:boolean;
         Cession_dans_Annee:boolean;
         Maxi:Currency;
         Mini:Currency;
         Choix:Currency;
         Eco:Currency;
         Type_Amt:string;
//         Terminee:boolean;
         EnCours:boolean;
         CodeTerminee:String;
         CompteTerminee:String;
         SousCodeTerminee:String;
         TauxAmo:currency;
  end;

  TAmortissement_Obj=Class(Tobject)
    TMontantChoix:currency;
    private
    property MontantChoix:currency read TMontantChoix write TMontantChoix;
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;

  TobjetImmos=Class(Tobject)
    TMontantcession:currency;
    TMontantEnCours:currency;
    TDesignationEnCours:string;
    TEcritureCession:integer;
    private
    property Montantcession:currency read TMontantcession write TMontantcession;
    property MontantEnCours:currency read TMontantEnCours write TMontantEnCours;
    property DesignationEnCours:string read TDesignationEnCours write TDesignationEnCours;
    property EcritureCession:integer read TEcritureCession write TEcritureCession;
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;


  TDataModuleImmos = class(TDataModule)
    QuRecupImmosSurCpt: TQuery;
    daRecupImmosSurCpt: TDataSource;
    taDetailImmo: TTable;
    daDetailImmo: TDataSource;
    qryCumulImmosChoix: TQuery;
    dsCumulImmosChoix: TDataSource;
    qryTotalCumulImmosSurCpt: TQuery;
    dsTotalCumulImmosSurCpt: TDataSource;
    qryListeAcquis: TQuery;
    dsListeAcquis: TDataSource;
    QuRecImmos_ParamDivers: TQuery;
    QuRecupImmosSurCptTypeA: TStringField;
    dsDivers: TDataSource;
    tbPMV: TTable;
    dsPMV: TDataSource;
    tbPMVCode: TStringField;
    tbPMVSous_Code: TStringField;
    tbPMVMt_Cession: TCurrencyField;
    tbPMVDate_Cession: TDateField;
    tbPMVCode_ID: TStringField;
    tbPMVpvCT: TCurrencyField;
    tbPMVpvLT: TCurrencyField;
    tbPMVDate_Org: TDateField;
    tbPMVValeur_Org: TCurrencyField;
    tbPMVValeur_Venale: TCurrencyField;
    tbPMVValeur_a_Amortir: TCurrencyField;
    tbPMVDate_Achat: TDateField;
    tbPMVMt_Deduc_Invest: TCurrencyField;
    tbPMVAmort_Eco: TCurrencyField;
    tbPMVAmort_Derog: TCurrencyField;
    tbPMVChoix: TCurrencyField;
    QuCptUtiliseImmos: TQuery;
    DaCptUtiliseImmos: TDataSource;
    qryCumulImmosChoixV_Acq: TCurrencyField;
    qryCumulImmosChoixVNC: TCurrencyField;
    qryListeAcquisDate: TDateField;
    qryListeAcquisDebit: TFloatField;
    qryListeAcquisCredit: TFloatField;
    qryListeAcquisID: TIntegerField;
    taDetailImmoID: TIntegerField;
    taDetailImmoEcriture_Achat: TIntegerField;
    taDetailImmoEcriture_Cession: TIntegerField;
    taDetailImmoCode: TStringField;
    taDetailImmoSous_Code: TStringField;
    taDetailImmoDate_Org: TDateField;
    taDetailImmoValeur_Org: TCurrencyField;
    taDetailImmoValeur_Venale: TCurrencyField;
    taDetailImmoDuree: TSmallintField;
    taDetailImmoValeur_a_Amortir: TCurrencyField;
    taDetailImmoDate_Achat: TDateField;
    taDetailImmoDate_Mise_en_Service: TDateField;
    taDetailImmoDuree_Amt: TSmallintField;
    taDetailImmoType_Amt: TStringField;
    taDetailImmoDeduc_Invest: TBooleanField;
    taDetailImmoMt_Deduc_Invest: TCurrencyField;
    taDetailImmoReprise_deduc_invest: TCurrencyField;
    taDetailImmoValeur_Nette: TCurrencyField;
    taDetailImmoAmort_Eco: TCurrencyField;
    taDetailImmoAmort_Derog: TCurrencyField;
    taDetailImmoMt_Cession: TCurrencyField;
    taDetailImmoDate_Cession: TDateField;
    taDetailImmoRebut: TBooleanField;
    taDetailImmoAchat_dans_Annee: TBooleanField;
    taDetailImmoCession_dans_Annee: TBooleanField;
    taDetailImmoDuree_Restante: TSmallintField;
    taDetailImmoSimulation: TStringField;
    taDetailImmoSous_Compte: TBooleanField;
    taDetailImmoMaxi: TCurrencyField;
    taDetailImmoMini: TCurrencyField;
    taDetailImmoChoix: TCurrencyField;
    taDetailImmoEco: TCurrencyField;
    DaImmos_A_Ceder: TDataSource;
    TaImmos_A_CederID: TIntegerField;
    TaImmos_A_CederEcriture_Achat: TIntegerField;
    TaImmos_A_CederEcriture_Cession: TIntegerField;
    TaImmos_A_CederCode: TStringField;
    TaImmos_A_CederSous_Code: TStringField;
    TaImmos_A_CederDate_Org: TDateField;
    TaImmos_A_CederValeur_Org: TCurrencyField;
    TaImmos_A_CederValeur_Venale: TCurrencyField;
    TaImmos_A_CederDuree: TSmallintField;
    TaImmos_A_CederValeur_a_Amortir: TCurrencyField;
    TaImmos_A_CederDate_Achat: TDateField;
    TaImmos_A_CederDate_Mise_en_Service: TDateField;
    TaImmos_A_CederDuree_Amt: TSmallintField;
    TaImmos_A_CederType_Amt: TStringField;
    TaImmos_A_CederDeduc_Invest: TBooleanField;
    TaImmos_A_CederMt_Deduc_Invest: TCurrencyField;
    TaImmos_A_CederReprise_deduc_invest: TCurrencyField;
    TaImmos_A_CederValeur_Nette: TCurrencyField;
    TaImmos_A_CederAmort_Eco: TCurrencyField;
    TaImmos_A_CederAmort_Derog: TCurrencyField;
    TaImmos_A_CederMt_Cession: TCurrencyField;
    TaImmos_A_CederDate_Cession: TDateField;
    TaImmos_A_CederRebut: TBooleanField;
    TaImmos_A_CederAchat_dans_Annee: TBooleanField;
    TaImmos_A_CederCession_dans_Annee: TBooleanField;
    TaImmos_A_CederDuree_Restante: TSmallintField;
    TaImmos_A_CederSimulation: TStringField;
    TaImmos_A_CederSous_Compte: TBooleanField;
    TaImmos_A_CederMaxi: TCurrencyField;
    TaImmos_A_CederMini: TCurrencyField;
    TaImmos_A_CederChoix: TCurrencyField;
    TaImmos_A_CederEco: TCurrencyField;
    TaImmos_A_Ceder: TTable;
    TaImmosEnCours: TTable;
    DaImmosEnCours: TDataSource;
    TaImmosEnCoursID: TIntegerField;
    TaImmosEnCoursEcriture_Achat: TIntegerField;
    TaImmosEnCoursEcriture_Cession: TIntegerField;
    TaImmosEnCoursCode: TStringField;
    TaImmosEnCoursSous_Code: TStringField;
    TaImmosEnCoursDate_Org: TDateField;
    TaImmosEnCoursValeur_Org: TCurrencyField;
    TaImmosEnCoursValeur_Venale: TCurrencyField;
    TaImmosEnCoursDuree: TSmallintField;
    TaImmosEnCoursValeur_a_Amortir: TCurrencyField;
    TaImmosEnCoursDate_Achat: TDateField;
    TaImmosEnCoursDate_Mise_en_Service: TDateField;
    TaImmosEnCoursDuree_Amt: TSmallintField;
    TaImmosEnCoursType_Amt: TStringField;
    TaImmosEnCoursDeduc_Invest: TBooleanField;
    TaImmosEnCoursMt_Deduc_Invest: TCurrencyField;
    TaImmosEnCoursReprise_deduc_invest: TCurrencyField;
    TaImmosEnCoursValeur_Nette: TCurrencyField;
    TaImmosEnCoursAmort_Eco: TCurrencyField;
    TaImmosEnCoursAmort_Derog: TCurrencyField;
    TaImmosEnCoursMt_Cession: TCurrencyField;
    TaImmosEnCoursDate_Cession: TDateField;
    TaImmosEnCoursRebut: TBooleanField;
    TaImmosEnCoursAchat_dans_Annee: TBooleanField;
    TaImmosEnCoursCession_dans_Annee: TBooleanField;
    TaImmosEnCoursDuree_Restante: TSmallintField;
    TaImmosEnCoursSimulation: TStringField;
    TaImmosEnCoursSous_Compte: TBooleanField;
    TaImmosEnCoursMaxi: TCurrencyField;
    TaImmosEnCoursMini: TCurrencyField;
    TaImmosEnCoursChoix: TCurrencyField;
    TaImmosEnCoursEco: TCurrencyField;
    TaImmosEnCoursTerminee: TBooleanField;
    TaImmosEnCoursEnCours: TBooleanField;
    TaImmosEnCoursCodeTerminee: TStringField;
    QuImmosLiee_A_Ecriture: TQuery;
    taDetailImmoTerminee: TBooleanField;
    taDetailImmoEnCours: TBooleanField;
    taDetailImmoCodeTerminee: TStringField;
    taDetailImmoLibelle: TStringField;
    qryListeAcquisLibelle: TStringField;
    TaImmosEnCoursLibelle: TStringField;
    QuCptUtiliseImmosLibelle: TStringField;
    TaImmos_A_CederLibelle: TStringField;
    tbPMVLibelle: TStringField;
    qryListeAcquisCompte: TStringField;
    taDetailImmoCompte: TStringField;
    TaImmosEnCoursCompte: TStringField;
    QuCptUtiliseImmosCompte: TStringField;
    TaImmos_A_CederCompte: TStringField;
    TaImmos_A_CederTerminee: TBooleanField;
    TaImmos_A_CederEnCours: TBooleanField;
    TaImmos_A_CederCompteTerminee: TStringField;
    tbPMVCompte: TStringField;
    TaImmos_A_CederCodeTerminee: TStringField;
    taDetailImmoCompteTerminee: TStringField;
    TaImmosEnCoursCompteTerminee: TStringField;
    QuRecupCoef: TQuery;
    QuCptUtiliseImmosReport: TCurrencyField;
    QuCptUtiliseImmosCumul: TCurrencyField;
    QuCptUtiliseImmosValeur_nette: TCurrencyField;
    QuRecupImmosSurCptImmobilisation: TStringField;
    QuRecupImmosSurCptreport: TCurrencyField;
    QuRecupImmosSurCptValeur_a_Amortir: TCurrencyField;
    QuRecupImmosSurCptchoix: TCurrencyField;
    QuRecupImmosSurCptCumul: TCurrencyField;
    QuRecupImmosSurCptValeur_nette: TCurrencyField;
    QuRecupImmosSurCptType_Amt: TStringField;
    QuRecupImmosSurCptID: TIntegerField;
    QuRecupImmosSurCptEcriture_Cession: TIntegerField;
    QuRecupImmosSurCptCompte: TStringField;
    QuRecupImmosSurCptDate_mise_en_service: TDateField;
    taDetailImmoTauxAmo: TFloatField;
    taDetailImmoTiers: TStringField;
    taDetailImmoReferenceFacture: TStringField;
    taDetailImmoMontantTTC: TCurrencyField;
    TaImmosChoix: TTable;
    DaImmosChoix: TDataSource;
    TaImmosChoixID: TIntegerField;
    TaImmosChoixLibelle: TStringField;
    TaImmosChoixEcriture_Achat: TIntegerField;
    TaImmosChoixEcriture_Cession: TIntegerField;
    TaImmosChoixCompte: TStringField;
    TaImmosChoixCode: TStringField;
    TaImmosChoixSous_Code: TStringField;
    TaImmosChoixDate_Org: TDateField;
    TaImmosChoixValeur_Org: TCurrencyField;
    TaImmosChoixValeur_Venale: TCurrencyField;
    TaImmosChoixDuree: TSmallintField;
    TaImmosChoixValeur_a_Amortir: TCurrencyField;
    TaImmosChoixDate_Achat: TDateField;
    TaImmosChoixDate_Mise_en_Service: TDateField;
    TaImmosChoixDuree_Amt: TSmallintField;
    TaImmosChoixType_Amt: TStringField;
    TaImmosChoixDeduc_Invest: TBooleanField;
    TaImmosChoixMt_Deduc_Invest: TCurrencyField;
    TaImmosChoixReprise_deduc_invest: TCurrencyField;
    TaImmosChoixValeur_Nette: TCurrencyField;
    TaImmosChoixAmort_Eco: TCurrencyField;
    TaImmosChoixAmort_Derog: TCurrencyField;
    TaImmosChoixMt_Cession: TCurrencyField;
    TaImmosChoixDate_Cession: TDateField;
    TaImmosChoixRebut: TBooleanField;
    TaImmosChoixAchat_dans_Annee: TBooleanField;
    TaImmosChoixCession_dans_Annee: TBooleanField;
    TaImmosChoixDuree_Restante: TSmallintField;
    TaImmosChoixSimulation: TStringField;
    TaImmosChoixSous_Compte: TBooleanField;
    TaImmosChoixMaxi: TCurrencyField;
    TaImmosChoixMini: TCurrencyField;
    TaImmosChoixChoix: TCurrencyField;
    TaImmosChoixEco: TCurrencyField;
    TaImmosChoixTerminee: TBooleanField;
    TaImmosChoixEnCours: TBooleanField;
    TaImmosChoixCodeTerminee: TStringField;
    TaImmosChoixCompteTerminee: TStringField;
    TaImmosChoixImmobilisation: TStringField;
    qryCumulImmosChoixTotalMini: TCurrencyField;
    qryCumulImmosChoixTotalMaxi: TCurrencyField;
    qryCumulImmosChoixTotalChoix: TCurrencyField;
    QuRecupImmosSurCptAchat_Dans_Annee: TBooleanField;
    QuCptUtiliseImmosexercice: TCurrencyField;
    QuCalculAmort: TQuery;
    DaCalculAmort: TDataSource;
    QuCalculAmortID: TIntegerField;
    QuCalculAmortLibelle: TStringField;
    QuCalculAmortEcriture_Achat: TIntegerField;
    QuCalculAmortEcriture_Cession: TIntegerField;
    QuCalculAmortcompte: TStringField;
    QuCalculAmortCode: TStringField;
    QuCalculAmortSous_Code: TStringField;
    QuCalculAmortDate_Org: TDateField;
    QuCalculAmortValeur_Org: TCurrencyField;
    QuCalculAmortValeur_Venale: TCurrencyField;
    QuCalculAmortDuree: TSmallintField;
    QuCalculAmortValeur_a_Amortir: TCurrencyField;
    QuCalculAmortDate_Achat: TDateField;
    QuCalculAmortDate_Mise_en_Service: TDateField;
    QuCalculAmortDuree_Amt: TSmallintField;
    QuCalculAmorttype_Amt: TStringField;
    QuCalculAmortDeduc_Invest: TBooleanField;
    QuCalculAmortMt_Deduc_Invest: TCurrencyField;
    QuCalculAmortReprise_deduc_invest: TCurrencyField;
    QuCalculAmortValeur_Nette: TCurrencyField;
    QuCalculAmortAmort_Eco: TCurrencyField;
    QuCalculAmortAmort_Derog: TCurrencyField;
    QuCalculAmortMt_Cession: TCurrencyField;
    QuCalculAmortdate_cession: TDateField;
    QuCalculAmortrebut: TBooleanField;
    QuCalculAmortAchat_dans_Annee: TBooleanField;
    QuCalculAmortcession_dans_annee: TBooleanField;
    QuCalculAmortDuree_Restante: TSmallintField;
    QuCalculAmortSimulation: TStringField;
    QuCalculAmortSous_Compte: TBooleanField;
    QuCalculAmortMaxi: TCurrencyField;
    QuCalculAmortMini: TCurrencyField;
    QuCalculAmortChoix: TCurrencyField;
    QuCalculAmortEco: TCurrencyField;
    QuCalculAmortTerminee: TBooleanField;
    QuCalculAmortEnCours: TBooleanField;
    QuCalculAmortCodeTerminee: TStringField;
    QuCalculAmortCompteTerminee: TStringField;
    QuCalculAmortTauxAmo: TFloatField;
    QuCalculAmortTiers: TStringField;
    QuCalculAmortReferenceFacture: TStringField;
    QuCalculAmortMontantTTC: TCurrencyField;
    QuSelectionCalculAmort: TQuery;
    DaSelectionCalculAmort: TDataSource;
    qryCumulImmosChoixA_Cumul: TCurrencyField;
    QuRecupImmoSurSuppressionPieceComptable: TQuery;
    QuRecupImmoSurSuppressionPieceComptableID_Immo: TIntegerField;
    QuRecupImmoSurSuppressionPieceComptableType_Amt: TStringField;
    QuRecupImmoSurSuppressionPieceComptableChoix: TCurrencyField;
    QuCptUtiliseImmosValeur_a_amortir: TCurrencyField;
    TaImmosEnCoursTauxAmo: TFloatField;
    TaImmosEnCoursTiers: TStringField;
    TaImmosEnCoursReferenceFacture: TStringField;
    TaImmosEnCoursMontantTTC: TCurrencyField;
    TaImmos_A_CederTauxAmo: TFloatField;
    TaImmos_A_CederTiers: TStringField;
    TaImmos_A_CederReferenceFacture: TStringField;
    TaImmos_A_CederMontantTTC: TCurrencyField;
    TaImmosChoixTauxAmo: TFloatField;
    TaImmosChoixTiers: TStringField;
    TaImmosChoixReferenceFacture: TStringField;
    TaImmosChoixMontantTTC: TCurrencyField;
    TableImmos: TTable;
    tbPMVValeur_Nette_Calc: TCurrencyField;
    tbPMVCession_dans_Annee: TBooleanField;
    TaImmosRebut: TTable;
    DaImmosRebut: TDataSource;
    TaImmosRebutID: TIntegerField;
    TaImmosRebutLibelle: TStringField;
    TaImmosRebutEcriture_Achat: TIntegerField;
    TaImmosRebutEcriture_Cession: TIntegerField;
    TaImmosRebutCompte: TStringField;
    TaImmosRebutCode: TStringField;
    TaImmosRebutSous_Code: TStringField;
    TaImmosRebutDate_Org: TDateField;
    TaImmosRebutValeur_Org: TCurrencyField;
    TaImmosRebutValeur_Venale: TCurrencyField;
    TaImmosRebutDuree: TSmallintField;
    TaImmosRebutValeur_a_Amortir: TCurrencyField;
    TaImmosRebutDate_Achat: TDateField;
    TaImmosRebutDate_Mise_en_Service: TDateField;
    TaImmosRebutDuree_Amt: TSmallintField;
    TaImmosRebutType_Amt: TStringField;
    TaImmosRebutDeduc_Invest: TBooleanField;
    TaImmosRebutMt_Deduc_Invest: TCurrencyField;
    TaImmosRebutReprise_deduc_invest: TCurrencyField;
    TaImmosRebutAmort_Eco: TCurrencyField;
    TaImmosRebutAmort_Derog: TCurrencyField;
    TaImmosRebutMt_Cession: TCurrencyField;
    TaImmosRebutDate_Cession: TDateField;
    TaImmosRebutRebut: TBooleanField;
    TaImmosRebutAchat_dans_Annee: TBooleanField;
    TaImmosRebutCession_dans_Annee: TBooleanField;
    TaImmosRebutDuree_Restante: TSmallintField;
    TaImmosRebutSimulation: TStringField;
    TaImmosRebutSous_Compte: TBooleanField;
    TaImmosRebutMaxi: TCurrencyField;
    TaImmosRebutMini: TCurrencyField;
    TaImmosRebutChoix: TCurrencyField;
    TaImmosRebutEco: TCurrencyField;
    TaImmosRebutTerminee: TBooleanField;
    TaImmosRebutEnCours: TBooleanField;
    TaImmosRebutCodeTerminee: TStringField;
    TaImmosRebutCompteTerminee: TStringField;
    TaImmosRebutTauxAmo: TFloatField;
    TaImmosRebutTiers: TStringField;
    TaImmosRebutReferenceFacture: TStringField;
    TaImmosRebutMontantTTC: TCurrencyField;
    TaImmosRebutvaleurNette: TCurrencyField;
    QuRecupImmosSurCptSituation: TStringField;
    QuRecupImmosSurCptCession_dans_annee: TBooleanField;
    QuRecupImmosSurCptrebut: TBooleanField;
    tbPMVID: TIntegerField;
    QuRecupImmosSurCptValue: TCurrencyField;
    QuRecupImmosSurCptDate_cession: TDateField;
    QuRecupImmosSurCptMt_Cession: TCurrencyField;
    qryTotalCumulImmos: TQuery;
    DaTotalCumulImmos: TDataSource;
    qryTotalCumulImmosValeur_a_amortir: TCurrencyField;
    qryTotalCumulImmosReport: TCurrencyField;
    qryTotalCumulImmosexercice: TCurrencyField;
    qryTotalCumulImmosCumul: TCurrencyField;
    qryTotalCumulImmosValeur_nette: TCurrencyField;
    qryTotalCumulImmosSurCptValeur_a_amortir: TCurrencyField;
    qryTotalCumulImmosSurCptReport: TCurrencyField;
    qryTotalCumulImmosSurCptexercice: TCurrencyField;
    qryTotalCumulImmosSurCptCumul: TCurrencyField;
    qryTotalCumulImmosSurCptValeur_nette: TCurrencyField;
    qryTotalCumulImmosSurCptMtCession: TCurrencyField;
    TaImmosChoixDerog: TCurrencyField;
    QuRecupImmoSurSuppressionPieceComptablevaleurNette: TCurrencyField;
    TaImmosRebutValeur_Nette: TCurrencyField;
    tbPMVType_Amt: TStringField;
    tbPMVPlusValue: TCurrencyField;
    QuImmosEdition: TQuery;
    QuImmosEditionID: TIntegerField;
    QuImmosEditionLibelle: TStringField;
    QuImmosEditionEcriture_Achat: TIntegerField;
    QuImmosEditionEcriture_Cession: TIntegerField;
    QuImmosEditionCompte: TStringField;
    QuImmosEditionCode: TStringField;
    QuImmosEditionSous_Code: TStringField;
    QuImmosEditionDate_Org: TDateField;
    QuImmosEditionValeur_Org: TCurrencyField;
    QuImmosEditionValeur_Venale: TCurrencyField;
    QuImmosEditionDuree: TSmallintField;
    QuImmosEditionValeur_a_Amortir: TCurrencyField;
    QuImmosEditionDate_Achat: TDateField;
    QuImmosEditionDate_Mise_en_Service: TDateField;
    QuImmosEditionDuree_Amt: TSmallintField;
    QuImmosEditionType_Amt: TStringField;
    QuImmosEditionDeduc_Invest: TBooleanField;
    QuImmosEditionMt_Deduc_Invest: TCurrencyField;
    QuImmosEditionReprise_deduc_invest: TCurrencyField;
    QuImmosEditionValeur_Nette: TCurrencyField;
    QuImmosEditionAmort_Eco: TCurrencyField;
    QuImmosEditionAmort_Derog: TCurrencyField;
    QuImmosEditionMt_Cession: TCurrencyField;
    QuImmosEditionDate_Cession: TDateField;
    QuImmosEditionRebut: TBooleanField;
    QuImmosEditionAchat_dans_Annee: TBooleanField;
    QuImmosEditionCession_dans_Annee: TBooleanField;
    QuImmosEditionDuree_Restante: TSmallintField;
    QuImmosEditionSimulation: TStringField;
    QuImmosEditionSous_Compte: TBooleanField;
    QuImmosEditionMaxi: TCurrencyField;
    QuImmosEditionMini: TCurrencyField;
    QuImmosEditionChoix: TCurrencyField;
    QuImmosEditionEco: TCurrencyField;
    QuImmosEditionTerminee: TBooleanField;
    QuImmosEditionEnCours: TBooleanField;
    QuImmosEditionCodeTerminee: TStringField;
    QuImmosEditionCompteTerminee: TStringField;
    QuImmosEditionTauxAmo: TFloatField;
    QuImmosEditionTiers: TStringField;
    QuImmosEditionReferenceFacture: TStringField;
    QuImmosEditionMontantTTC: TCurrencyField;
    QuImmosEditionCodeLong: TStringField;
    QuImmosEditionexercice: TCurrencyField;
    QuImmosEditioncumul: TCurrencyField;
    QuImmosEditionnet: TCurrencyField;
    QuImmosEditionvaleur_res: TCurrencyField;
    QuImmosEditionPlusvalue: TCurrencyField;
    QuImmosEditionamort_forfait: TCurrencyField;
    QuImmosEditionamort_reel: TCurrencyField;
    QuImmosEditionPVCourtTerme: TCurrencyField;
    QuImmosEditionMVCourtTerme: TCurrencyField;
    QuImmosEditionPVLongTerme: TCurrencyField;
    QuImmosEditionMVLongTerme: TCurrencyField;
    TaImmosRecalcul: TTable;
    QuAcquisition_Edition: TQuery;
    QuSyntheseChoixAmort_Edition: TQuery;
    DaDivision: TDataSource;
    TaDivision: TTable;
    TaDivisionVNC: TCurrencyField;
    TaDivisionID: TIntegerField;
    TaDivisionLibelle: TStringField;
    TaDivisionEcriture_Achat: TIntegerField;
    TaDivisionEcriture_Cession: TIntegerField;
    TaDivisionCompte: TStringField;
    TaDivisionCode: TStringField;
    TaDivisionSous_Code: TStringField;
    TaDivisionDate_Org: TDateField;
    TaDivisionValeur_Org: TCurrencyField;
    TaDivisionValeur_Venale: TCurrencyField;
    TaDivisionDuree: TSmallintField;
    TaDivisionValeur_a_Amortir: TCurrencyField;
    TaDivisionDate_Achat: TDateField;
    TaDivisionDate_Mise_en_Service: TDateField;
    TaDivisionDuree_Amt: TSmallintField;
    TaDivisionType_Amt: TStringField;
    TaDivisionDeduc_Invest: TBooleanField;
    TaDivisionMt_Deduc_Invest: TCurrencyField;
    TaDivisionReprise_deduc_invest: TCurrencyField;
    TaDivisionValeur_Nette: TCurrencyField;
    TaDivisionAmort_Eco: TCurrencyField;
    TaDivisionAmort_Derog: TCurrencyField;
    TaDivisionMt_Cession: TCurrencyField;
    TaDivisionDate_Cession: TDateField;
    TaDivisionRebut: TBooleanField;
    TaDivisionAchat_dans_Annee: TBooleanField;
    TaDivisionCession_dans_Annee: TBooleanField;
    TaDivisionDuree_Restante: TSmallintField;
    TaDivisionSimulation: TStringField;
    TaDivisionSous_Compte: TBooleanField;
    TaDivisionMaxi: TCurrencyField;
    TaDivisionMini: TCurrencyField;
    TaDivisionChoix: TCurrencyField;
    TaDivisionEco: TCurrencyField;
    TaDivisionTerminee: TBooleanField;
    TaDivisionEnCours: TBooleanField;
    TaDivisionCodeTerminee: TStringField;
    TaDivisionCompteTerminee: TStringField;
    TaDivisionTauxAmo: TFloatField;
    TaDivisionTiers: TStringField;
    TaDivisionReferenceFacture: TStringField;
    TaDivisionMontantTTC: TCurrencyField;
    QuRecupImmosSurCptTerminee: TBooleanField;
    QuRecupImmosSurCptEnCours: TBooleanField;
    QuRecupImmosSurCptCodeTerminee: TStringField;
    QuRecupImmosSurCptCompteTerminee: TStringField;
    TaImmosEnCoursSousCodeTerminee: TStringField;
    taDetailImmoSousCodeTerminee: TStringField;
    tbPMVTerminee: TBooleanField;
    TaImmosChoixSousCodeTerminee: TStringField;
    TaImmos_A_CederSousCodeTerminee: TStringField;
    TaDivisionSousCodeTerminee: TStringField;
    TaImmosRebutSousCodeTerminee: TStringField;
    tbPMVSousCodeTerminee: TStringField;
    QuImmosEditionSousCodeTerminee: TStringField;
    QuCalculAmortSousCodeTerminee: TStringField;
    QuRecupImmosSurCptSousCodeTerminee: TStringField;
    QuImmosEditionModifiable: TQuery;
    QuImmosEditionModifiableID: TIntegerField;
    QuImmosEditionModifiableLibelle: TStringField;
    QuImmosEditionModifiableEcriture_Achat: TIntegerField;
    QuImmosEditionModifiableEcriture_Cession: TIntegerField;
    QuImmosEditionModifiableCompte: TStringField;
    QuImmosEditionModifiableCode: TStringField;
    QuImmosEditionModifiableSous_Code: TStringField;
    QuImmosEditionModifiableDate_Org: TDateField;
    QuImmosEditionModifiableValeur_Org: TCurrencyField;
    QuImmosEditionModifiableValeur_Venale: TCurrencyField;
    QuImmosEditionModifiableDuree: TSmallintField;
    QuImmosEditionModifiableValeur_a_Amortir: TCurrencyField;
    QuImmosEditionModifiableDate_Achat: TDateField;
    QuImmosEditionModifiableDate_Mise_en_Service: TDateField;
    QuImmosEditionModifiableDuree_Amt: TSmallintField;
    QuImmosEditionModifiableType_Amt: TStringField;
    QuImmosEditionModifiableDeduc_Invest: TBooleanField;
    QuImmosEditionModifiableMt_Deduc_Invest: TCurrencyField;
    QuImmosEditionModifiableReprise_deduc_invest: TCurrencyField;
    QuImmosEditionModifiableValeur_Nette: TCurrencyField;
    QuImmosEditionModifiableAmort_Eco: TCurrencyField;
    QuImmosEditionModifiableAmort_Derog: TCurrencyField;
    QuImmosEditionModifiableMt_Cession: TCurrencyField;
    QuImmosEditionModifiableDate_Cession: TDateField;
    QuImmosEditionModifiableRebut: TBooleanField;
    QuImmosEditionModifiableAchat_dans_Annee: TBooleanField;
    QuImmosEditionModifiableCession_dans_Annee: TBooleanField;
    QuImmosEditionModifiableDuree_Restante: TSmallintField;
    QuImmosEditionModifiableSimulation: TStringField;
    QuImmosEditionModifiableSous_Compte: TBooleanField;
    QuImmosEditionModifiableMaxi: TCurrencyField;
    QuImmosEditionModifiableMini: TCurrencyField;
    QuImmosEditionModifiableChoix: TCurrencyField;
    QuImmosEditionModifiableEco: TCurrencyField;
    QuImmosEditionModifiableTerminee: TBooleanField;
    QuImmosEditionModifiableEnCours: TBooleanField;
    QuImmosEditionModifiableCodeTerminee: TStringField;
    QuImmosEditionModifiableCompteTerminee: TStringField;
    QuImmosEditionModifiableSousCodeTerminee: TStringField;
    QuImmosEditionModifiableTauxAmo: TFloatField;
    QuImmosEditionModifiableTiers: TStringField;
    QuImmosEditionModifiableReferenceFacture: TStringField;
    QuImmosEditionModifiableMontantTTC: TCurrencyField;
    QuImmosEditionModifiableCodeLong: TStringField;
    QuImmosEditionModifiableexercice: TCurrencyField;
    QuImmosEditionModifiablecumul: TCurrencyField;
    QuImmosEditionModifiablenet: TCurrencyField;
    QuImmosEditionModifiablevaleur_res: TCurrencyField;
    QuImmosEditionModifiablePlusvalue: TCurrencyField;
    QuImmosEditionModifiableamort_forfait: TCurrencyField;
    QuImmosEditionModifiableamort_reel: TCurrencyField;
    QuImmosEditionModifiablePVCourtTerme: TCurrencyField;
    QuImmosEditionModifiableMVCourtTerme: TCurrencyField;
    QuImmosEditionModifiablePVLongTerme: TCurrencyField;
    QuImmosEditionModifiableMVLongTerme: TCurrencyField;


    procedure QuRecupImmosSurCptCalcFields(DataSet: TDataSet);
    procedure tbPMVCalcFields(DataSet: TDataSet);
    procedure DataModuleImmosDestroy(Sender: TObject);
    procedure Filtrage_QuRecupImmosSurCpt_SurTag(TagTmp:integer;Partiel:boolean;Rang:integer;SQLText,Cpt:string;DateDeb,Datefin:Tdate);
    procedure Filtrage_qryTotalCumulImmosSurCpt_SurTag(TagTmp:integer;Partiel:boolean;Rang:integer;SQLText,Cpt:string;DateDeb,Datefin:Tdate);
    procedure Filtrage_qryListeAcquis_SurTag(TagTmp:integer;Partiel:boolean;Rang:integer;SQLText:string);
    procedure UpdateImmosSurValeurs(TableEnCours:TTable;rang:array of string;Valeurs: array of variant;TableState:Tdatasetstate;IDImmos:integer);
    procedure taDetailImmoPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure taDetailImmoAfterPost(DataSet: TDataSet);
    procedure FiltrageQuRecImmos_ParamDivers(TextSql:string);
    function Trouve_sous_code(Cpt,Code:string): string;
    procedure DataModuleImmosCreate(Sender: TObject);
    Function CtrlSaisieCessions(CCourant:Tfield):TErreurSaisie;
    procedure TaImmos_A_CederBeforePost(DataSet: TDataSet);
    procedure TaImmos_A_CederBeforePost_Simple(DataSet: TDataSet);
    function CalculTotalColonneMontant(Liste:TstringList;RangDep,rangFin:integer;TInfos:integer):currency;
    procedure Pre_Remplir_Cession(Montant:currency);
    procedure InitialiserCession;
    procedure Remplir_ou_Modifier_Liste(Supp:boolean;TInfos:integer);
//    procedure GererDoubleClick(A_Ceder:boolean);
    procedure TaImmos_A_CederAfterPost(DataSet: TDataSet);
    procedure TaImmos_A_CederPostError(DataSet: TDataSet;
      E: EDatabaseError; var Action: TDataAction);
    procedure TaImmos_A_CederBeforeClose(DataSet: TDataSet);
    procedure TaImmosEnCoursAfterPost(DataSet: TDataSet);
    procedure TaImmosEnCoursPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    function RetourneSiPieceContientdesImmosEnCours(idEcriture:integer;DatabaseTmp:TDatabase):boolean;
    Function CtrlSaisieImmosTerminee(CCourant:Tfield):TErreurSaisie;
    function GererRemplissageLibelle(Liste:tstringlist;LibDefaut:string;var Dernier:string):string;
    function ListImmosEnCoursALier_IndexOf(Const S:String;ValeurRech:integer):integer;
    procedure TaImmosEnCoursFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
//    Procedure RaffraichitDonnees(Querys:array of TQuery;Tables:array of TTable);
    procedure TaImmosEnCoursBeforeClose(DataSet: TDataSet);
    function TrouveCode(Cpt:string) : string;
    function ExisteNumImmo(table:TTable;Compte,Code,SousCode,IDCourant:string):boolean;
    function RechercherCoefficient_surPeriodeValidite(dateAchat:TdateTime;Duree:integer):real;
    procedure TaImmos_A_CederBeforeDelete(DataSet: TDataSet);
    procedure TaImmos_A_CederBeforeInsert(DataSet: TDataSet);
    procedure TaImmosChoixCalcFields(DataSet: TDataSet);
    procedure DaImmosChoixStateChange(Sender: TObject);
    procedure TaImmosChoixBeforeInsert(DataSet: TDataSet);
    procedure TaImmosChoixBeforeDelete(DataSet: TDataSet);
    procedure Remplir_ou_Modifier_ListeChoix(Supp:boolean;Liste:Tstringlist;MessageTmp:string);
//    procedure RestaurerChoixAvantModif(Liste:Tstringlist);
    procedure TaImmosChoixBeforePost(DataSet: TDataSet);
    procedure TaImmosChoixAfterEdit(DataSet: TDataSet);
//    procedure SauvegardeChoixAvantModif(Liste:tstringlist);
    procedure SuppressionImmo(TableCourante:TTable;ID:integer;Suppression:boolean;Messages:boolean=true);
    procedure taDetailImmoDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure taDetailImmoAfterDelete(DataSet: TDataSet);
    procedure QuRecupImmosSurCptBeforeInsert(DataSet: TDataSet);
    function Amort_degr(DateDebutAmo,DatefinAnneeAmo,finAmort:TDateTime; VNC,MiniAnnee:Currency; Taux:currency;Var nb_Mois:integer;AnneeRestantes,Restant:integer;Ceder:boolean):Currency;
//    function Amort_lin(DateDebutAmo,DatefinAnneeAmo,DateDebutExo,DateFinExo:TDateTime;ValeurAcquis,Cumul, Taux:currency;Var nbJour:integer):Currency;
    function Amort_lin_SurBase360(DateDebutAmo,DatefinAnneeAmo,DateCession:TDateTime;ValeurAcquis,Cumul:currency; Taux:extended;TypeAmort:char;Var nbJour:integer;Ceder,DerniereAnnee,CalculCumul:boolean):Currency;
    function CtrlInfosChoixAmortissement(EditCourant:Tfield):TExceptLGR;
    procedure initialiserChoix_Choix(ChoixLocal:TTypeModif;ListeParticularites:Tstringlist);
//    procedure SauvegardeParticularitesAvantModif(ListeModif:Tstringlist);
    Procedure ReactualiseQuery;
    function CalculerAmortAnneeSurImmo(Immoscourante:TInfosImmos;DebutExo,FinExo:Tdatetime;ChoixAvantModif:Tchoix;ConserverChoix:boolean=false):TAmortImmo;
    procedure Calcule_taux(DureeAmo:integer; DateDebutAmo,DateAcquisition:TDateTime; var TauxLin, TauxDeg : Extended;TauxDefaut:single);
    function CalculMini(CumulMini,CumulAmort,VNC:currency):currency;
    procedure taDetailImmoBeforePost(DataSet: TDataSet);
    procedure Filtrage_QuSelectionCalculAmort_SurTag(Dataset:TQuery;TagTmp:integer;Partiel:boolean;Rang:integer;SQLText:string);
    procedure Filtrage_qryCumulImmosChoix_SurTag(TagTmp,ID:integer);
    function VerifSiPieceDecriteDansLesImmos(ID_Piece:integer;var ListeImmosASupprimer:Tstringlist):TErreurSaisie;Overload;

    function VerifSiEcritureDecriteDansLesImmos(ID_Ecriture,ID_Piece:integer;var ListeImmosASupprimer:Tstringlist):TErreurSaisie;Overload;
    procedure tbPMVAfterOpen(DataSet: TDataSet);
    Procedure InitFiltrePlusOuMoinsValues(Dataset:TDataset);
    procedure qryListeAcquisAfterOpen(DataSet: TDataSet);
    procedure qryListeAcquisBeforeInsert(DataSet: TDataSet);
    procedure qryListeAcquisEditError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaImmosRebutCalcFields(DataSet: TDataSet);
    procedure TaImmosRebutAfterDelete(DataSet: TDataSet);
    procedure TaImmosRebutAfterPost(DataSet: TDataSet);
    procedure TaImmosRebutBeforePost(DataSet: TDataSet);
    procedure TaImmosRebutDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaImmosRebutPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure taDetailImmoBeforeDelete(DataSet: TDataSet);
    procedure TaImmosRebutBeforeDelete(DataSet: TDataSet);
    procedure taDetailImmoAfterInsert(DataSet: TDataSet);
    procedure Calcule_PM_Values(var pvCT, pvLT:Currency;Dataset:Tdataset);
    procedure QuRecupImmosSurCptBeforeOpen(DataSet: TDataSet);
    Function CalculDerogSurImmos(Var Immos:TAmortImmo):TCalcul;
    function RecalculGeneralAmortissement(Dataset:Tdataset;Ouverture:boolean;DateDebut,DateFin:Tdatetime):boolean;
    Function CalculEcoRepartitionSurImmos(Var Immos:TAmortImmo;DerniereAnnee:boolean):TCalcul;

    function VerifSiPieceDecriteDansLesCessions(ID_Piece:integer;var ListeCessionsASupprimer:Tstringlist):TErreurSaisie;Overload;
    function VerifSiEcritureDecriteDansLesCessions(ID_Ecriture,ID_Piece:integer;var ListeCessionsASupprimer:Tstringlist):TErreurSaisie;Overload;
    procedure TaImmosRebutBeforeEdit(DataSet: TDataSet);
    procedure TaImmos_A_CederBeforeEdit(DataSet: TDataSet);
    procedure qryListeAcquisBeforeDelete(DataSet: TDataSet);

//    function RetourneBaseCalculSurAnneeExercice(DebutExo:Tdate;var FinExo:Tdate):integer;
    function CtrlSaisieRebut(EditCourant:Tfield):TErreurSaisie;
    procedure QuImmosEditionCalcFields(DataSet: TDataSet);
    Procedure ChangementRepertoireTableImmos;
    procedure TaImmosChoixFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuAcquisition_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuImmosEditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuImmosEditionFilterRecordPlusOuMoinsValues(DataSet: TDataSet;
      var Accept: Boolean);
    function CtrlSaisieDescriptionAmort(EditCourant:Tfield):TExceptLGR;
    procedure taDetailImmoBeforeEdit(DataSet: TDataSet);
    procedure RempliInfosDetailAcquis(var infosDetailAcquis:TinfosDetailAcquis);
    procedure TadetailImmoBeforeEIDClo_Abort(DataSet: TDataSet);
    procedure TadetailImmoBeforeEIDVerrouillage_Abort(DataSet: TDataSet);
    Procedure GestionAccesImmos;
    procedure TaDivisionAfterDelete(DataSet: TDataSet);
    procedure TaDivisionAfterPost(DataSet: TDataSet);
    procedure TaDivisionBeforeDelete(DataSet: TDataSet);
    procedure TaDivisionBeforePost(DataSet: TDataSet);
    procedure TaDivisionCalcFields(DataSet: TDataSet);
    procedure TaImmosChoixAfterPost(DataSet: TDataSet);
    procedure TaImmoChoixBeforeEIDVerrouillage_Abort(DataSet: TDataSet);
    procedure TaImmoChoixBeforeEIDClo_Abort(DataSet: TDataSet);
    procedure TaDivisionAfterInsert(DataSet: TDataSet);
    Function RemplirChoixAvantModif(Dataset:TDataset;ImmosEnCours:TInfosImmos):Tchoix;
    procedure TaDivisionBeforeEdit(DataSet: TDataSet);
    Procedure RecalculAmort_ApresModifDataset(Dataset:TDataset;ChoixAvantModif:Tchoix;ConserverChoix:boolean=false);
    function ImmosRebut(ImmoEnCours:TInfosImmos):boolean;
    function ImmosTerminee(ImmoEnCours:TInfosImmos):boolean;
    function ImmosCedee(ImmoEnCours:TInfosImmos):boolean;
    Function InitialisationImmoEnCoursSurModif(Dataset:TDataset=Nil):TExceptLGR;
    Function InitialisationImmoEnCours(Dataset:TDataset;Terminer:boolean):TExceptLGR;
    procedure taDetailImmoAfterCancel(DataSet: TDataSet);
    procedure qryListeAcquisFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure tbPMVFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure EditionAmort5AnsCompteFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuImmosEditionModifiableCalcFields(DataSet: TDataSet);
    function CalculRepriseDeduction(Dataset:TDataSet):currency;
  private
      FOnGEstInterfaceEvent:TGEstInterfaceEvent;
      function Compare(Date_A, Date_B:TDateTime):TDateTime ;

  public
    { Déclarations publiques }
//    filtre:TFiltre;
    ListeImmobilisable:Tstringlist;
    ListImmosEnCoursALier:Tstringlist;
    ListeRestaure,ListeModif,ListeParticularite:TstringList;
    ListMtACeder:Tstringlist;
    IDtmp:integer;
    DernierLibAffecte:string;
    //Mini,Maxi:currency;
    ModificationImmos:boolean;
    suppressionPieceDotation:boolean;
    choix,Choix_AvantCession,Choix_AvantRebut,Choix_avantSupp:Tchoix;
    Choix_Division:Tchoix;
    ModificationImmo_A_Ceder:boolean;
    ID_DernierCree:integer;
    Compte_DernierCree:string;
    ListeFilterRecordAcquisition:Tstringlist;
    Quand:integer;
    verrouillage:boolean;
    QuiAppel:TTypeFenetre;
    TypePresentation:integer;
    InfosCession:TInfosCession;
    Infosdivision:TinfosDivision;
    infosrebut:TinfosRebut;
    infosDetailAcquis:TinfosDetailAcquis;
    TimerEvent:TNotifyEvent;
    TimerDisabled:TNotifyEvent;
    tauxDegressif:currency;
    typeImmos:TtypeImmos;
    typeAmort:TTypeAmort;

    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
    function Amortissable(Compte:string):TTypeImmo;

    function VerifSiPieceDecriteDansLesImmos(ID_Piece:integer):TErreurSaisie;Overload;
    function VerifSiEcritureDecriteDansLesImmos(ID_Ecriture,ID_Piece:integer):TErreurSaisie;Overload;
    function VerifSiEcritureDecriteDansLesCessions(ID_Ecriture,ID_Piece:integer):TErreurSaisie;Overload;
    function VerifSiPieceDecriteDansLesCessions(ID_Piece:integer):TErreurSaisie;Overload;

  end;

//  Function EditionAcquisitions(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  Function EditionAmortissements(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  Function EditionChoixAmortissements(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  Function EditionPMValuesComptables(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  Function EditionPMValuesFiscales(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  Function EditionDeductionInvestissement(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;

  function RecupSoldeImmosSurCompte(compte:string):TCalcul;

  function AppelRecalculGeneralImmos(DemandeConfirmation:boolean=true):TExceptLGR;
  { isa  le  16/10/03 }
    Function EditionDesAcquisitionsL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Relance:boolean=false):TStringList;overload;
    Function EditionDesAcquisitionsL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string;Relance:boolean=false):TStringList;overload;
    Function EditionDesAcquisitionsL(TypeEdition : integer; Filtre:string;DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string;Relance:boolean=false):TStringList;overload;

    Function EditionPMValuesFiscalesL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Relance:boolean=false;Synthese:boolean=false):TStringList;overload;
    Function EditionPMValuesFiscalesL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string;Relance:boolean=false;Synthese:boolean=false):TStringList;overload;
    Function EditionPMValuesFiscalesL3Chiffres(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Relance:boolean=false;Synthese:boolean=false):TStringList;overload;
    Function EditionPMValuesFiscalesL3Chiffres(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string;Relance:boolean=false;Synthese:boolean=false):TStringList;overload;

    Function EditionPMValuesComptablesL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Synthese:boolean=false):Boolean;overload;
    Function EditionPMValuesComptablesL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string;Synthese:boolean=false):Boolean;overload;
    Function EditionPMValuesComptablesL3Chiffres(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Synthese:boolean=false):Boolean;overload;
    Function EditionPMValuesComptablesL3Chiffres(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string;Synthese:boolean=false):Boolean;overload;

    Function EditionTableauDesAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Derogatoire:boolean;Detail:boolean=true):Boolean;overload;
    Function EditionTableauDesAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string;Derogatoire:boolean;Detail:boolean=true):Boolean;overload;
    Function EditionTableauDesAmortissementL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string;Derogatoire:boolean;Detail:boolean=true):Boolean;overload;

    Function EditionListeDesChoixAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet):Boolean;overload;
    Function EditionListeDesChoixAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet):Boolean;overload;
    Function EditionListeDesChoixAmortissementL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet):Boolean;overload;

//    Function EditionSyntheseTableauDesAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Derogatoire:boolean):Boolean;overload;
//    Function EditionSyntheseTableauDesAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string;Derogatoire:boolean):Boolean;overload;
//    Function EditionSyntheseTableauDesAmortissementL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string;Derogatoire:boolean):Boolean;overload;

    Function EditionSyntheseDesChoixAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;overload;
    Function EditionSyntheseDesChoixAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string):Boolean;overload;
    Function EditionSyntheseDesChoixAmortissementL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;overload;

    Function EditionAmort5AnsL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;overload;
    Function EditionAmort5AnsL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string):Boolean;overload;
    Function EditionAmort5AnsL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;overload;

    Function EditionAmort5AnsSimplifieL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;overload;
    Function EditionAmort5AnsSimplifieL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string):Boolean;overload;
    Function EditionAmort5AnsSimplifieL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;overload;

  { isa  le  16/10/03 }
  Function InitialiseDMImmos(ParamDMImmos:TParamDMImmos):TExceptLgr;
  Procedure Initialise_TinfosDetailAcquis(var infosDetailAcquis:TinfosDetailAcquis);
  Procedure Initialise_TinfosDivision(var infosDivision:TinfosDivision);
  Procedure Initialise_TinfosRebut(var infosRebut:TinfosRebut);
  Procedure Initialise_TInfosCession(var InfosCession:TInfosCession);
  Procedure Initialise_ParamDMimmos(ParamDMimmos:TParamDMimmos);

  Function CalculAmortissementSurSelection_2(DatasetCalcul:Tdataset):Tvaleur;
  Function CalculAmortissementSurSelection_Simplifie(DatasetCalcul:Tdataset):TValeurSimplifie;
   function Calcule_Valeur_Ancetre(j:integer; Valeur:TValeur; var ImmosCourante:TinfosImmos):TinfosImmos;
   function Calcule_Valeur_AncetreSimplifie(j:integer; Valeur:TValeurSimplifie; var ImmosCourante:TinfosImmos;Maxi : boolean = false):TinfosImmos;
   procedure raz(var Valeur:TValeur);
   procedure ajoute(var Valeur, cumul:TValeur);
   procedure razSimplifie(var Valeur:TValeurSimplifie);
   procedure ajouteSimplifie(var Valeur, cumul:TValeurSimplifie);
   Function AffichInfoImmos(Affiche:boolean=true):TParamHistorique;

var
  DataModuleImmos: TDataModuleImmos;
//  ListMtACeder:Tstringlist;  IDtmp:integer;
  Immos:TobjetImmos;
  Amortissement:TAmortissement_Obj;
  choixValeur:currency;
  ImmosEnCours:tinfosimmos;
  EcritureImmos:integer;
  CompteCourant:string;
implementation

uses {RB_Librairie,Gr_AideDate,} E2_ChoixAmortissement, DMPlanCpt, DMBalances,
  DMPiece, DMImmosOuverture, DMRecherche, E2_AideCompte,DMExports,
    DMCorrection,LibChoixCompte,
      DMParamEnt,

DMImmo_Clot, E2_VisuListe, E2_Main, E2_VisuListeView;

{$R *.DFM}

Function InitialiseDMImmos(ParamDMImmos:TParamDMImmos):TExceptLgr;
var
immoCourante:integer;
Begin
result.retour:=true;
try
 if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 if AideCompte=nil then AideCompte:=TAideCompte.Create(Application.MainForm);
 DataModuleImmos.OnGEstInterfaceEvent := ParamDMImmos.GEstInterfaceEvent;
 DataModuleImmos.QuiAppel:=ParamDMImmos.QuiAppel;
 DataModuleImmos.Quand := ParamDMImmos.Quand;
 DataModuleImmos.tag:=ParamDMImmos.Tag;
 DataModuleImmos.TypePresentation:=ParamDMImmos.TypePresentation;
  DataModuleImmos.QuCptUtiliseImmos.AfterScroll:=ParamDMImmos.CptImmosAfterScroll;
  DataModuleImmos.QuCptUtiliseImmos.AfterOpen:=ParamDMImmos.CptImmosAfterOpen;
  DataModuleImmos.QuRecupImmosSurCpt.AfterScroll:=ParamDMImmos.ImmosAfterScroll;
  DataModuleImmos.daDetailImmo.OnStateChange:=ParamDMImmos.ImmosDataStateChange;
  DataModuleImmos.verrouillage:=false;
  DataModuleImmos.typeImmos:=ParamDMImmos.typeImmos;
  DataModuleImmos.typeAmort:=ParamDMImmos.typeAmort;
 Case DataModuleImmos.QuiAppel Of
      F_VisuImmo: Begin //si cours d'année
                      ///
                        DataModuleImmos.ChangementRepertoireTableImmos;
                        DataModuleImmos.QuRecupImmosSurCpt.DisableControls;
                        DataModuleImmos.QuCptUtiliseImmos.DisableControls;

                        if ParamDMImmos.typeImmos=c_toutes then
                          DataModuleImmos.QuCptUtiliseImmos.ParamByName('Cpt').asstring:='%'
                          else
                            if ParamDMImmos.typeImmos=C_Immo then
                              DataModuleImmos.QuCptUtiliseImmos.ParamByName('Cpt').asstring:='2%'
                            else
                                DataModuleImmos.QuCptUtiliseImmos.ParamByName('Cpt').asstring:='131%';

                         DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateDebut').asdate:=ParamDMImmos.Periode.DateDeb;
                         DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate:=ParamDMImmos.Periode.DateFin;
                         if ParamDMImmos.TypePresentation=C_CESSION_EXO then
                             begin
                               DataModuleImmos.QuCptUtiliseImmos.SQL.Strings[6] :='and ((rebut=true and Terminee=false )or(((Immos.Ecriture_Cession <>0))and(not (compte like(''131%''))))) GROUP BY Immos.Compte, PlanCpt.Libelle';
                               if DataModuleImmos.qryTotalCumulImmos.SQL.Count<8 then
                                 DataModuleImmos.qryTotalCumulImmos.SQL.Add('where  ((rebut=true and Terminee=false) or(((Ecriture_Cession <>0 ) and (not (compte like(''131%''))))))');
                             end
                           else
                             begin
                             DataModuleImmos.QuCptUtiliseImmos.SQL.Strings[6] :=' and ((Terminee=false) or ((Terminee=true) and (Cession_Dans_Annee=true)))  GROUP BY Immos.Compte, PlanCpt.Libelle';
                             if DataModuleImmos.qryTotalCumulImmos.SQL.Count>7 then
                               DataModuleImmos.qryTotalCumulImmos.SQL.delete(7);
                             end;
                          DataModuleImmos.ReactualiseQuery;
                          DataModuleImmos.QuRecupImmosSurCpt.EnableControls;
                          DataModuleImmos.QuCptUtiliseImmos.EnableControls;
                      DataModuleImmos.daDetailImmo.OnStateChange(DataModuleImmos.taDetailImmo);
                      ///
                      //DataModuleImmos.QuCptUtiliseImmos_Ouverture.AfterScroll:=ParamDMImmos_Ouverture.ImmosAfterScroll;
//                      if not(DataModuleImmos.daDetailImmo.State in [dsinsert,dsedit]) then
//                        begin
//                          FiltrageDataSet(DataModuleImmos.taDetailImmo,'');
//
//                        end;
                   End;
      F_Rebut:     begin
                         if not DataModuleImmos.taimmosrebut.Active then
                               DataModuleImmos.taimmosrebut.open;
                         FiltrageDataSet(DataModuleImmos.taimmosrebut,'id='+inttostr(ParamDMImmos.ImmoCourante));
                         if DataModuleImmos.taimmosrebut.recordcount=0 then
                             raise ExceptLGR.Create('',1000,false,mtError);
                         DataModuleImmos.taimmosrebut.Edit;
                         if now<e.DatExoFin then
                           DataModuleImmos.taimmosrebut.FindField('Date_Cession').AsDateTime:=now
                         else
                           DataModuleImmos.taimmosrebut.FindField('Date_Cession').AsDateTime:=e.DatExoFin;
                   end;
      F_Division:  begin
                         if not DataModuleImmos.TaDivision.Active then
                               DataModuleImmos.TaDivision.open;
                         FiltrageDataSet(DataModuleImmos.TaDivision,'id='+inttostr(ParamDMImmos.ImmoCourante));
                         if DataModuleImmos.taimmosrebut.recordcount=0 then
                             raise ExceptLGR.Create('',1000,false,mtError);
                   end;
      F_Cession:  begin
                     //

                      DataModuleImmos.daImmos_A_Ceder.OnStateChange:=ParamDMImmos.ImmosDataStateChange;
                      DataModuleImmos.daImmos_A_Ceder.OnStateChange(DataModuleImmos.TaImmos_A_Ceder);

                   end;
      F_ChoixAmortissement:  begin
                                DataModuleImmos.taImmosChoix.OnFilterRecord:=DataModuleImmos.TaImmosChoixFilterRecord;
                                DeFiltrageDataSet(DataModuleImmos.TaImmosChoix);
                                if ParamDMImmos.ImmoCourante<>0 then
                                  begin
                                    FiltrageDataSet(DataModuleImmos.TaImmosChoix,'ID='''+inttostr(ParamDMImmos.ImmoCourante)+'''');
                                  end
                                else
                                    FiltrageDataSet(DataModuleImmos.TaImmosChoix,''); //je filtre à vide car les conditions du filterRecord suffisent dans ce cas
                                DataModuleImmos.choix.tag:=ParamDMImmos.TypePresentation;
                                DataModuleImmos.ModificationImmos:= ParamDMImmos.TypeModif<>RxNonModifies;
                                DataModuleImmos.initialiserChoix_Choix(ParamDMImmos.TypeModif,nil);

                                DataModuleImmos.DaImmosChoix.OnStateChange:=ParamDMImmos.ImmosDataStateChange;
                                DataModuleImmos.taImmosChoix.AfterScroll:=ParamDMImmos.ImmosAfterScroll;
                                DataModuleImmos.TimerEvent:= ParamDMImmos.TimerEvent;
                                DataModuleImmos.TimerDisabled:= ParamDMImmos.TimerDisabled;
                                DataModuleImmos.DaImmosChoixStateChange(DataModuleImmos.TaImmosChoix);
                             end;
      F_DetailAcquis: Begin //si cours d'année
                      DataModuleImmos.daDetailImmo.OnStateChange:=ParamDMImmos.ImmosDataStateChange;
                      initialise_TinfosDetailAcquis(DataModuleImmos.infosDetailAcquis);
                      initialiserChoix(DataModuleImmos.Choix);
                      if ((not empty(DataModuleImmos.taDetailImmoChoix.AsString))and(DataModuleImmos.taDetailImmoChoix.Ascurrency<>0)) then
                         DataModuleImmos.choix.choixDefaut:=DataModuleImmos.taDetailImmoChoix.Ascurrency;
                      DataModuleImmos.suppressionPieceDotation:=false;
                      if not(DataModuleImmos.daDetailImmo.State in [dsinsert,dsedit]) then
                        begin
                          FiltrageDataSet(DataModuleImmos.taDetailImmo,'');
                          DataModuleImmos.daDetailImmo.OnStateChange(DataModuleImmos.taDetailImmo);
                       case ParamDMImmos.TypePresentation of
                        C_ACQUISITION_Terminee,
                        C_ACQUISITION_En_Cours,
                        C_ACQUISITION_Simple  : begin
                                                  if DataModuleImmos.taDetailImmo.State in [dsbrowse] then
                                                      DataModuleImmos.taDetailImmo.append;
                                                  if ParamDMImmos.TypePresentation in [C_ACQUISITION_En_Cours,C_ACQUISITION_Terminee] then
                                                    begin
//                                                      filtragedataset(DataModuleImmos.TaImmosEnCours,'(compte=''23*'') and ((Terminee=faux) or (compteTerminee is null) or (codeTerminee is null) or (SouscodeTerminee is null)) and (Rebut=faux)');
                                                      filtragedataset(DataModuleImmos.TaImmosEnCours,'compte=''23*''');
                                                    end;
                                                end;
                        C_DESCRIPTION_terminee,
                        C_DESCRIPTION_Simple,
                        C_DESCRIPTION_En_Cours: Begin
                                                  if ((not DataModuleImmos.taDetailImmo.FindField('Achat_dans_annee').AsBoolean)or(DataModuleImmos.taDetailImmo.FindField('Cession_dans_annee').AsBoolean)) then
                                                     DataModuleImmos.verrouillage:=true;
                                                  if ParamDMImmos.TypePresentation in [C_DESCRIPTION_En_Cours,C_DESCRIPTION_terminee] then
                                                    begin                                                                                   // DataModuleImmos.taDetailImmo.FindField('').As
//                                                      filtragedataset(DataModuleImmos.TaImmosEnCours,'compte=''23*'' and  compteTerminee ='''+DataModuleImmos.taDetailImmo.FindField('Compte').Asstring+'''  and codeTerminee ='''+DataModuleImmos.taDetailImmo.FindField('Code').Asstring+'''  and SouscodeTerminee = '''+DataModuleImmos.taDetailImmo.FindField('Sous_Code').Asstring+''' and Rebut=faux');
                                                      filtragedataset(DataModuleImmos.TaImmosEnCours,'compte=''23*''');
                                                    end;
                                                end;
                       end;//fin du case
                        end;
                   End;
 End;
except
  //
end;
End;



//Function EditionDeductionInvestissement(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  var NomFich,Chemin:string;
//  var periode:TPeriode;
//ParamAffichPeriode:TParamAffichPeriode;
//Begin
//
//  Chemin :=E.RepertoireComptaWeb;
//  NomFich:='DeductionPourInvestissement';
//    Initialise_ParamAffichPeriode(ParamAffichPeriode);
//    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
//  if periode.Retour then begin
//      if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
//      if dataset = nil then begin
//         // Prevu pour passer le dataset concerné
//      end;
//
//
//      DataModuleImmos.QuImmosEdition.SQL.Clear;
//      DataModuleImmos.QuImmosEdition.SQL.Add('select * from immos ');
//     // DataModuleImmos.QuImmosEdition.SQL.Add(' where Date_Cession >= '''+ DateInfos(periode.DateDeb).DatePourSQLStr + ''' and Date_Cession <= '''+ DateInfos(periode.DateFin).DatePourSQLStr + ''' and Cession_Dans_Annee = ''Vrai''');
//      DataModuleImmos.QuImmosEdition.Open;
//
//      DataModuleImmos.QuSousTotal1.SQL.Clear;
//      DataModuleImmos.QuSousTotal1.SQL.Add('select sum(PVCourtTerme)-sum(MVCourtTerme) ');
//      DataModuleImmos.QuSousTotal1.SQL.Add('from edition ');
//      DataModuleImmos.QuSousTotal1.Open;
//
//      DataModuleImmos.QuSousTotal2.SQL.Clear;
//      DataModuleImmos.QuSousTotal2.SQL.Add('select sum(PVCourtTerme)-sum(MVCourtTerme) ');
//      DataModuleImmos.QuSousTotal2.SQL.Add('from edition ');
//      DataModuleImmos.QuSousTotal2.Open;
//
//      DataModuleImmos.QuSousTotal3.SQL.Clear;
//      DataModuleImmos.QuSousTotal3.SQL.Add('select sum(PVCourtTerme)-sum(MVCourtTerme) ');
//      DataModuleImmos.QuSousTotal3.SQL.Add('from edition ');
//      DataModuleImmos.QuSousTotal3.Open;
//
//      DataModuleImmos.QuTotalG1.SQL.Clear;
//      DataModuleImmos.QuTotalG1.SQL.Add('select distinct 0');
//      DataModuleImmos.QuTotalG1.SQL.Add('from immos ');
//      DataModuleImmos.QuTotalG1.SQL.Add('where Date_Cession >= '''+ DateInfos(periode.DateDeb).DatePourSQLStr + ''' and Date_Cession <= '''+ DateInfos(periode.DateFin).DatePourSQLStr + ''' and Cession_Dans_Annee = ''Vrai''');
//      DataModuleImmos.QuTotalG1.Open;
//
//      DataModuleImmos.QuTotalG2.SQL.Clear;
//      DataModuleImmos.QuTotalG2.SQL.Add('select sum(PVCourtTerme)-sum(MVCourtTerme) ');
//      DataModuleImmos.QuTotalG2.SQL.Add('from edition ');
//      DataModuleImmos.QuTotalG2.Open;
//
//      DataModuleImmos.QuTotalG3.SQL.Clear;
//      DataModuleImmos.QuTotalG3.SQL.Add('select sum(PVLongTerme)-sum(MVLongTerme) ');
//      DataModuleImmos.QuTotalG3.SQL.Add('from edition ');
//      DataModuleImmos.QuTotalG3.Open;
//
//      case TypeEdition  of
//          C_EditionSimple:Begin
//                              Site.lien := false;
//                              EditDeductionInvestissement(Chemin,NomFich,DataModuleImmos.QuImmosEdition,DataModuleImmos.QuSousTotal1,DataModuleImmos.QuSousTotal2,DataModuleImmos.QuSousTotal3,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DataModuleImmos.QuTotalG3,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                          End;
//          C_EditionWeb: Begin
//                            Site.lien := false;
//                            //EditPlusValueComptable(Chemin,NomFich,DataModuleImmos.QuImmosEdition,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                        End;
//      end;
//      DataModuleImmos.QuSousTotal1.Close;
//      DataModuleImmos.QuSousTotal2.Close;
//      DataModuleImmos.QuSousTotal3.Close;
//      DataModuleImmos.QuTotalG1.Close;
//      DataModuleImmos.QuTotalG2.Close;
//      DataModuleImmos.QuTotalG3.Close;
//      DataModuleImmos.QuImmosEdition.Close;
//  end;
//End;

//Function EditionPMValuesFiscales(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  var NomFich,Chemin:string;
//  var periode:TPeriode;
//  var TaPMValueFiscales : TTable;
//ParamAffichPeriode:TParamAffichPeriode;
//Begin
//
//  Chemin :=E.RepertoireComptaWeb;
//  NomFich:='PMValuesFiscales';
//    Initialise_ParamAffichPeriode(ParamAffichPeriode);
//    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
//  if periode.Retour then begin
//      if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
//      if dataset = nil then begin
//         // Prevu pour passer le dataset concerné
//      end;
//
//      DataModuleImmos.QuImmosEdition.SQL.Clear;
//      DataModuleImmos.QuImmosEdition.SQL.Add('select * from immos ');
//      DataModuleImmos.QuImmosEdition.SQL.Add(' where ((Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') and (Cession_Dans_Annee=true))');
//      DataModuleImmos.QuImmosEdition.Open;
//
//      //Création de la table temporaire
//      TaPMValueFiscales:=TTable.Create(DataModuleImmos);
//      TaPMValueFiscales.TableName:='Edition';
//      TaPMValueFiscales.TableType:=ttParadox;
//      TaPMValueFiscales.DatabaseName:='Dossier';
//      TaPMValueFiscales.FieldDefs.Clear;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='compte';
//        DataType:=ftString;
//        Size:=8;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='CodeLong';
//        DataType:=ftString;
//        Size:=100;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='Libelle';
//        DataType:=ftString;
//        Size:=100;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='valeur_res';
//        DataType:=ftCurrency;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='Mt_cession';
//        DataType:=ftCurrency;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='plusvalue';
//        DataType:=ftCurrency;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='PVCourtTerme';
//        DataType:=ftCurrency;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='MVCourtTerme';
//        DataType:=ftCurrency;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='PVLongTerme';
//        DataType:=ftCurrency;
//        Required:=true;
//      end;
//      with TaPMValueFiscales.FieldDefs.AddFieldDef do begin
//        Name:='MVLongTerme';
//        DataType:=ftCurrency;
//        Required:=true;
//      end;
//      TaPMValueFiscales.CreateTable;
//
//      //Remplissage de la table temporaire
//      TaPMValueFiscales.Active:=true;
//      while not DataModuleImmos.QuImmosEdition.Eof do begin
//          TaPMValueFiscales.AppendRecord([
//            DataModuleImmos.QuImmosEdition.FindField('Compte').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('CodeLong').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('Libelle').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('valeur_res').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('Mt_cession').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('plusvalue').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('PVCourtTerme').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('MVCourtTerme').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('PVLongTerme').AsString,
//            DataModuleImmos.QuImmosEdition.FindField('MVLongTerme').AsString
//          ]);
//          DataModuleImmos.QuImmosEdition.Next;
//      end;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG1.SQL.Clear;
//      DataModuleImmos.QuTotalG1.SQL.Add('select distinct sum(valeur_a_amortir)-sum(amort_eco)-sum(amort_derog) valeur_res,sum(Mt_cession),sum(Mt_cession)-(sum(valeur_a_amortir)-sum(amort_eco)-sum(amort_derog)) plusvalue,');
//      DataModuleImmos.QuTotalG1.SQL.Add('(select sum(PVCourtTerme) from edition), ');
//      DataModuleImmos.QuTotalG1.SQL.Add('(select sum(MVCourtTerme) from edition),');
//      DataModuleImmos.QuTotalG1.SQL.Add('(select sum(PVLongTerme) from edition),');
//      DataModuleImmos.QuTotalG1.SQL.Add('(select sum(MVLongTerme) from edition) ');
//      DataModuleImmos.QuTotalG1.SQL.Add('from immos ');
//      DataModuleImmos.QuTotalG1.SQL.Add('where Date_Cession >= '''+ DateInfos(periode.DateDeb).DatePourSQLStr + ''' and Date_Cession <= '''+ DateInfos(periode.DateFin).DatePourSQLStr + ''' and Cession_Dans_Annee = ''Vrai''');
//      DataModuleImmos.QuTotalG1.Open;
//
//      //Total court terme
//      DataModuleImmos.QuTotalG2.SQL.Clear;
//      DataModuleImmos.QuTotalG2.SQL.Add('select sum(PVCourtTerme)-sum(MVCourtTerme) ');
//      DataModuleImmos.QuTotalG2.SQL.Add('from edition ');
//      DataModuleImmos.QuTotalG2.Open;
//
//      //Total long terme
//      DataModuleImmos.QuTotalG3.SQL.Clear;
//      DataModuleImmos.QuTotalG3.SQL.Add('select sum(PVLongTerme)-sum(MVLongTerme) ');
//      DataModuleImmos.QuTotalG3.SQL.Add('from edition ');
//      DataModuleImmos.QuTotalG3.Open;
//
//      case TypeEdition  of
//          C_EditionSimple:Begin
//                              Site.lien := false;
//                              EditPlusValuesFiscale(Chemin,NomFich,DataModuleImmos.QuImmosEdition,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DataModuleImmos.QuTotalG3,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                          End;
//          C_EditionWeb: Begin
//                            Site.lien := false;
//                            //EditPlusValueComptable(Chemin,NomFich,DataModuleImmos.QuImmosEdition,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                        End;
//      end;
//      TaPMValueFiscales.Close;
//      TaPMValueFiscales.Free;
//      DataModuleImmos.QuTotalG1.Close;
//      DataModuleImmos.QuTotalG2.Close;
//      DataModuleImmos.QuTotalG3.Close;
//      DataModuleImmos.QuImmosEdition.Close;
//  end;
//End;

//Function EditionPMValuesComptables(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  var NomFich,Chemin:string;
//  var periode:TPeriode;
//ParamAffichPeriode:TParamAffichPeriode;
//Begin
//
//  Chemin :=E.RepertoireComptaWeb;
//  NomFich:='PMValuesComptables';
//    Initialise_ParamAffichPeriode(ParamAffichPeriode);
//    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
//  if periode.Retour then begin
//      if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
//      if dataset = nil then begin
//         // Prevu pour passer le dataset concerné
//      end;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG1.SQL.Clear;
//      DataModuleImmos.QuTotalG1.SQL.Add('select distinct sum(valeur_a_amortir) base_amort,sum(amort_eco)+sum(amort_derog)+sum(choix) cumul ');
//      DataModuleImmos.QuTotalG1.SQL.Add(',sum(valeur_a_amortir)-sum(amort_eco)-sum(amort_derog) valeur_res,sum(Mt_cession),sum(Mt_cession)-(sum(valeur_a_amortir)-sum(amort_eco)-sum(amort_derog)) plusvalue ');
//      DataModuleImmos.QuTotalG1.SQL.Add('from immos ');
//      DataModuleImmos.QuImmosEdition.SQL.Add(' where ((Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') and (Cession_Dans_Annee=true))');
//      DataModuleImmos.QuTotalG1.Open;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG2.SQL.Clear;
//      DataModuleImmos.QuTotalG2.SQL.Add('select distinct sum(valeur_a_amortir),sum(valeur_venale),');
//      DataModuleImmos.QuTotalG2.SQL.Add('(select sum(valeur_a_amortir-valeur_org) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and valeur_org<>0 )');
//      DataModuleImmos.QuTotalG2.SQL.Add(',sum(amort_eco)+sum(amort_derog)+sum(choix),sum(valeur_a_amortir)-sum(amort_eco)-sum(amort_derog) ');
//      DataModuleImmos.QuTotalG2.SQL.Add('from immos ');
//      DataModuleImmos.QuImmosEdition.SQL.Add(' where ((Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') and (Cession_Dans_Annee=true))');
//      DataModuleImmos.QuTotalG2.Open;
//
//      DataModuleImmos.QuImmosEdition.SQL.Clear;
//      DataModuleImmos.QuImmosEdition.SQL.Add('select * from immos ');
//      DataModuleImmos.QuImmosEdition.SQL.Add(' where ((Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') and (Cession_Dans_Annee=true))');
//      DataModuleImmos.QuImmosEdition.Open;
//
//      case TypeEdition  of
//          C_EditionSimple:Begin
//                              Site.lien := false;
//                              EditPlusValueComptable(Chemin,NomFich,DataModuleImmos.QuImmosEdition,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                          End;
//          C_EditionWeb: Begin
//                            Site.lien := false;
//                            //EditPlusValueComptable(Chemin,NomFich,DataModuleImmos.QuImmosEdition,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                        End;
//      end;
//      DataModuleImmos.QuTotalG1.Close;
//      DataModuleImmos.QuTotalG2.Close;
//      DataModuleImmos.QuImmosEdition.Close;
//  end;
//End;

//Function EditionChoixAmortissements(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  var NomFich,Chemin:string;
//  var periode:TPeriode;
//ParamAffichPeriode:TParamAffichPeriode;
//Begin
//
//  Chemin :=E.RepertoireComptaWeb;
//  NomFich:='TableauChoixAmortissements';
//    Initialise_ParamAffichPeriode(ParamAffichPeriode);
//    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
//  if periode.Retour then begin
//      if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
//      if dataset = nil then begin
//         // Prevu pour passer le dataset concerné
//      end;
//
//      DataModuleImmos.QuListeValRupt.SQL.Clear;
//      DataModuleImmos.QuListeValRupt.SQL.Add('select distinct compte from immos');
//      DataModuleImmos.QuListeValRupt.SQL.Add(' where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuListeValRupt.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuListeValRupt.Open;
//
//      //total du compte avant cession
//      DataModuleImmos.QuSousTotal1.SQL.Clear;
//      DataModuleImmos.QuSousTotal1.Params.Clear;
//      DataModuleImmos.QuSousTotal1.SQL.Add('select sum(valeur_a_amortir)');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',sum(Amort_eco)');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',Sum(Amort_derog)');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',sum(Eco)');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',sum(Mini)');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',sum(Maxi)');
//      DataModuleImmos.QuSousTotal1.SQL.Add('from immos where compte= :compte');
//      DataModuleImmos.QuSousTotal1.SQL.Add(' and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuSousTotal1.Params[0].DataType := ftString;
//      DataModuleImmos.QuSousTotal1.Open;
//
//      //dont biens vendus ou sortis
//      DataModuleImmos.QuSousTotal2.SQL.Clear;
//      DataModuleImmos.QuSousTotal2.Params.Clear;
//      DataModuleImmos.QuSousTotal2.SQL.Add('select sum(valeur_a_amortir)');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',sum(Amort_eco)');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',Sum(Amort_derog)');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',sum(Eco)');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',sum(Mini)');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',sum(Maxi)');
//      DataModuleImmos.QuSousTotal2.SQL.Add('from immos where compte= :compte');
//      DataModuleImmos.QuSousTotal2.SQL.Add(' and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null');
//      DataModuleImmos.QuSousTotal2.Params[0].DataType := ftString;
//      DataModuleImmos.QuSousTotal2.Open;
//
//      //solde du compte
//      DataModuleImmos.QuSousTotal3.SQL.Clear;
//      DataModuleImmos.QuSousTotal3.Params.Clear;
//      DataModuleImmos.QuSousTotal3.SQL.Add('select sum(valeur_a_amortir)-cast((select sum(valeur_a_amortir) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',sum(Amort_eco)-cast((select sum(Amort_eco) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',Sum(Amort_derog)-cast((select sum(Amort_derog) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',sum(Eco)-cast((select sum(Eco) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',sum(Mini)-cast((select sum(Mini) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',sum(Maxi)-cast((select sum(Maxi) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add('from immos where compte= :compte');
//      DataModuleImmos.QuSousTotal3.SQL.Add(' and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuSousTotal3.Params[0].DataType := ftString;
//      DataModuleImmos.QuSousTotal3.Open;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG1.SQL.Clear;
//      DataModuleImmos.QuTotalG1.SQL.Add('select sum(valeur_a_amortir)');
//      DataModuleImmos.QuTotalG1.SQL.Add(',sum(Amort_eco)');
//      DataModuleImmos.QuTotalG1.SQL.Add(',Sum(Amort_derog)');
//      DataModuleImmos.QuTotalG1.SQL.Add(',sum(Eco)');
//      DataModuleImmos.QuTotalG1.SQL.Add(',sum(Mini)');
//      DataModuleImmos.QuTotalG1.SQL.Add(',sum(Maxi)');
//      DataModuleImmos.QuTotalG1.SQL.Add('from immos where');
//      DataModuleImmos.QuTotalG1.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuTotalG1.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuTotalG1.Open;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG2.SQL.Clear;
//      DataModuleImmos.QuTotalG2.SQL.Add('select sum(valeur_a_amortir)');
//      DataModuleImmos.QuTotalG2.SQL.Add(',sum(Amort_eco)');
//      DataModuleImmos.QuTotalG2.SQL.Add(',Sum(Amort_derog)');
//      DataModuleImmos.QuTotalG2.SQL.Add(',sum(Eco)');
//      DataModuleImmos.QuTotalG2.SQL.Add(',sum(Mini)');
//      DataModuleImmos.QuTotalG2.SQL.Add(',sum(Maxi)');
//      DataModuleImmos.QuTotalG2.SQL.Add('from immos where');
//      DataModuleImmos.QuTotalG2.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null');
//      DataModuleImmos.QuTotalG2.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuTotalG2.Open;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG3.SQL.Clear;
//      DataModuleImmos.QuTotalG3.SQL.Add('select sum(valeur_a_amortir)-cast((select sum(valeur_a_amortir) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',sum(Amort_eco)-cast((select sum(Amort_eco) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',Sum(Amort_derog)-cast((select sum(Amort_derog) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',sum(Eco)-cast((select sum(Eco) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',sum(Mini)-cast((select sum(Mini) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',sum(Maxi)-cast((select sum(Maxi) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add('from immos where');
//      DataModuleImmos.QuTotalG3.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuTotalG3.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuTotalG3.Open;
//
//      //
//      DataModuleImmos.QuImmosEdition.SQL.Clear;
//      DataModuleImmos.QuImmosEdition.SQL.Add('select * from immos where ');
//      DataModuleImmos.QuImmosEdition.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuImmosEdition.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuImmosEdition.Open;
//
//      case TypeEdition  of
//          C_EditionSimple:Begin
//                              Site.lien := false;
//                              EditChoixAmort(Chemin,NomFich,DataModuleImmos.QuImmosEdition,'compte',DataModuleImmos.QuListeValRupt,DataModuleImmos.QuSousTotal1,DataModuleImmos.QuSousTotal2,DataModuleImmos.QuSousTotal3,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DataModuleImmos.QuTotalG3,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                          End;
//          C_EditionWeb: Begin
//                            Site.lien := false;
//                            //EditDetteCreanceTiers(NomMenuSiteWeb,Chemin,NomFich,DMPointage2.QuStocksEdition,'Compte',DMPointage2.QuListeValRupt,DMStock.QuTotalG,DateToStr(now),Site);
//                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                        End;
//      end;
//      DataModuleImmos.QuListeValRupt.Close;
//      DataModuleImmos.QuSousTotal1.Close;
//      DataModuleImmos.QuTotalG1.Close;
//      DataModuleImmos.QuImmosEdition.Close;
//  end;
//End;

//Function EditionAmortissements(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  var NomFich,Chemin:string;
//  var periode:TPeriode;
//ParamAffichPeriode:TParamAffichPeriode;
//Begin
//
//  Chemin :=E.RepertoireComptaWeb;
//  NomFich:='TableauAmortissements';
//    Initialise_ParamAffichPeriode(ParamAffichPeriode);
//    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
//  if periode.Retour then begin
//      if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
//      if dataset = nil then begin
//         // Prevu pour passer le dataset concerné
//      end;
//
////      DataModuleImmos.QuListeValRupt.SQL.Clear;
////      DataModuleImmos.QuListeValRupt.SQL.Add('select distinct compte from immos');
////      DataModuleImmos.QuListeValRupt.SQL.Add(' where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
////      DataModuleImmos.QuListeValRupt.SQL.Add(' and compte like ''2%'' ');
////      DataModuleImmos.QuListeValRupt.Open;
//
//      DataModuleImmos.QuListeValRupt.SQL.Clear;
//      DataModuleImmos.QuListeValRupt.SQL.Add('select distinct compte from immos');
//      DataModuleImmos.QuListeValRupt.SQL.Add(' where (Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''')');
//      DataModuleImmos.QuListeValRupt.SQL.Add(' and (compte like ''2%'' )');
//      DataModuleImmos.QuListeValRupt.Open;
//
//      //total du compte avant cession
//      DataModuleImmos.QuSousTotal1.SQL.Clear;
//      DataModuleImmos.QuSousTotal1.Params.Clear;
//      DataModuleImmos.QuSousTotal1.SQL.Add('select sum(valeur_a_amortir)');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',0 ');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',sum(Choix)');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',Sum(Amort_eco+Amort_derog)+sum(choix)');
//      DataModuleImmos.QuSousTotal1.SQL.Add(',sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix)');
//      DataModuleImmos.QuSousTotal1.SQL.Add('from immos where compte= :compte');
//      //DataModuleImmos.QuSousTotal1.SQL.Add(' and (Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''')');
//      DataModuleImmos.QuSousTotal1.SQL.Add(' and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuSousTotal1.Params[0].DataType := ftString;
//      DataModuleImmos.QuSousTotal1.Open;
//
//      //dont biens vendus ou sortis
//      DataModuleImmos.QuSousTotal2.SQL.Clear;
//      DataModuleImmos.QuSousTotal2.Params.Clear;
//      DataModuleImmos.QuSousTotal2.SQL.Add('select sum(valeur_a_amortir)');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',0 ');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',sum(Choix)');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',(Sum(Amort_eco+Amort_derog)+sum(choix))');
//      DataModuleImmos.QuSousTotal2.SQL.Add(',(sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))');
//      DataModuleImmos.QuSousTotal2.SQL.Add('from immos where compte= :compte');
//      //DataModuleImmos.QuSousTotal2.SQL.Add(' and (Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''')');
//      DataModuleImmos.QuSousTotal2.SQL.Add(' and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null');
//      DataModuleImmos.QuSousTotal2.Params[0].DataType := ftString;
//      DataModuleImmos.QuSousTotal2.Open;
//
//      //solde du compte
//      DataModuleImmos.QuSousTotal3.SQL.Clear;
//      DataModuleImmos.QuSousTotal3.Params.Clear;
//      DataModuleImmos.QuSousTotal3.SQL.Add('select sum(valeur_a_amortir)-cast((select sum(valeur_a_amortir) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',0 ');
////      DataModuleImmos.QuSousTotal3.SQL.Add(',sum(Choix)-cast((select sum(choix) from immos where compte= :compte and Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
////      DataModuleImmos.QuSousTotal3.SQL.Add(',(Sum(Amort_eco+Amort_derog)+sum(choix))-cast((select (Sum(Amort_eco+Amort_derog)+sum(choix)) from immos where compte= :compte and Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
////      DataModuleImmos.QuSousTotal3.SQL.Add(',(sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))-cast((select (sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix)) from immos where compte= :compte and Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',sum(Choix)-cast((select sum(choix) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',(Sum(Amort_eco+Amort_derog)+sum(choix))-cast((select (Sum(Amort_eco+Amort_derog)+sum(choix)) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add(',(sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))-cast((select (sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix)) from immos where compte= :compte and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuSousTotal3.SQL.Add('from immos where compte= :compte');
//      DataModuleImmos.QuSousTotal3.SQL.Add(' and (Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''')');
////      DataModuleImmos.QuSousTotal3.SQL.Add(' and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuSousTotal3.Params[0].DataType := ftString;
//      DataModuleImmos.QuSousTotal3.Open;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG1.SQL.Clear;
//      DataModuleImmos.QuTotalG1.SQL.Add('select sum(valeur_a_amortir)');
//      DataModuleImmos.QuTotalG1.SQL.Add(',0 ');
//      DataModuleImmos.QuTotalG1.SQL.Add(',sum(Choix)');
//      DataModuleImmos.QuTotalG1.SQL.Add(',Sum(Amort_eco+Amort_derog)+sum(choix)');
//      DataModuleImmos.QuTotalG1.SQL.Add(',sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix)');
//      DataModuleImmos.QuTotalG1.SQL.Add('from immos where');
//      DataModuleImmos.QuTotalG1.SQL.Add(' (Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''')');
//      //DataModuleImmos.QuTotalG1.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuTotalG1.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuTotalG1.Open;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG2.SQL.Clear;
//      DataModuleImmos.QuTotalG2.SQL.Add('select sum(valeur_a_amortir)');
//      DataModuleImmos.QuTotalG2.SQL.Add(',0 ');
//      DataModuleImmos.QuTotalG2.SQL.Add(',sum(Choix)');
//      DataModuleImmos.QuTotalG2.SQL.Add(',(Sum(Amort_eco+Amort_derog)+sum(choix))');
//      DataModuleImmos.QuTotalG2.SQL.Add(',(sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))');
//      DataModuleImmos.QuTotalG2.SQL.Add('from immos where');
//      DataModuleImmos.QuTotalG2.SQL.Add(' (Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''')');
//      //DataModuleImmos.QuTotalG2.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null');
//      DataModuleImmos.QuTotalG2.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuTotalG2.Open;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG3.SQL.Clear;
//      DataModuleImmos.QuTotalG3.SQL.Add('select sum(valeur_a_amortir)-cast((select sum(valeur_a_amortir) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',0 ');
////      DataModuleImmos.QuTotalG3.SQL.Add(',sum(Choix)-cast((select sum(choix) from immos where Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
////      DataModuleImmos.QuTotalG3.SQL.Add(',(Sum(Amort_eco+Amort_derog)+sum(choix))-cast((select sum(choix) from immos where Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
////      DataModuleImmos.QuTotalG3.SQL.Add(',(sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))-cast((select sum(choix) from immos where Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',sum(Choix)-cast((select sum(choix) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',(Sum(Amort_eco+Amort_derog)+sum(choix))-cast((select sum(choix) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add(',(sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))-cast((select sum(choix) from immos where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' and Date_cession is not null) as numeric)');
//      DataModuleImmos.QuTotalG3.SQL.Add('from immos where');
//      DataModuleImmos.QuTotalG3.SQL.Add(' (Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''')');
//      //DataModuleImmos.QuTotalG3.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuTotalG3.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuTotalG3.Open;
//
//      //
//      DataModuleImmos.QuImmosEdition.SQL.Clear;
//      DataModuleImmos.QuImmosEdition.SQL.Add('select * from immos where ');
//      DataModuleImmos.QuImmosEdition.SQL.Add('(Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''')');
////      DataModuleImmos.QuImmosEdition.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuImmosEdition.SQL.Add(' and compte like ''2%'' ');
//      DataModuleImmos.QuImmosEdition.Open;
//
//      case TypeEdition  of
//          C_EditionSimple:Begin
//                              Site.lien := false;
//                              EditAmort(Chemin,NomFich,DataModuleImmos.QuImmosEdition,'compte',DataModuleImmos.QuListeValRupt,DataModuleImmos.QuSousTotal1,DataModuleImmos.QuSousTotal2,DataModuleImmos.QuSousTotal3,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DataModuleImmos.QuTotalG3,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                          End;
//          C_EditionWeb: Begin
//                            Site.lien := false;
//                            //EditDetteCreanceTiers(NomMenuSiteWeb,Chemin,NomFich,DMPointage2.QuStocksEdition,'Compte',DMPointage2.QuListeValRupt,DMStock.QuTotalG,DateToStr(now),Site);
//                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                        End;
//      end;
//      DataModuleImmos.QuListeValRupt.Close;
//      DataModuleImmos.QuSousTotal1.Close;
//      DataModuleImmos.QuSousTotal2.Close;
//      DataModuleImmos.QuSousTotal2.Close;
//      DataModuleImmos.QuTotalG1.Close;
//      DataModuleImmos.QuTotalG2.Close;
//      DataModuleImmos.QuTotalG3.Close;
//      DataModuleImmos.QuImmosEdition.Close;
//  end;
//End;
//
//Function EditionAcquisitions(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
//  var NomFich,Chemin:string;
//  var periode:TPeriode;
//ParamAffichPeriode:TParamAffichPeriode;
//Begin
//
//  Chemin :=E.RepertoireComptaWeb;
//  NomFich:='TableauAcquisitions';
//    Initialise_ParamAffichPeriode(ParamAffichPeriode);
//    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
//  if periode.Retour then begin
//      if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
//      if dataset = nil then begin
//         // Prevu pour passer le dataset concerné
//      end;
//
//      DataModuleImmos.QuListeValRupt.SQL.Clear;
//      DataModuleImmos.QuListeValRupt.SQL.Add('select distinct compte from immos');
//      DataModuleImmos.QuListeValRupt.SQL.Add('where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuListeValRupt.Open;
//
//      //total du compte
//      DataModuleImmos.QuSousTotal1.SQL.Clear;
//      DataModuleImmos.QuSousTotal1.Params.Clear;
//      DataModuleImmos.QuSousTotal1.SQL.Add('select sum(valeur_a_amortir),sum(Mt_deduc_invest) from immos where compte= :compte');
//      DataModuleImmos.QuSousTotal1.SQL.Add(' and Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuSousTotal1.Params[0].DataType := ftString;
//      DataModuleImmos.QuSousTotal1.Open;
//
//      //Total de l'exercice
//      DataModuleImmos.QuTotalG1.SQL.Clear;
//      DataModuleImmos.QuTotalG1.SQL.Add('select sum(valeur_a_amortir),sum(Mt_deduc_invest) from immos ');
//      DataModuleImmos.QuTotalG1.SQL.Add(' where Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuTotalG1.Open;
//
//      //
//      DataModuleImmos.QuImmosEdition.SQL.Clear;
//      DataModuleImmos.QuImmosEdition.SQL.Add('select * from immos where');
//      DataModuleImmos.QuImmosEdition.SQL.Add(' Date_achat between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuImmosEdition.Open;
//
//      case TypeEdition  of
//          C_EditionSimple:Begin
//                              Site.lien := false;
//                              EditAcquisitions(Chemin,NomFich,DataModuleImmos.QuImmosEdition,'compte',DataModuleImmos.QuListeValRupt,DataModuleImmos.QuSousTotal1,DataModuleImmos.QuTotalG1,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
//                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                          End;
//          C_EditionWeb: Begin
//                            Site.lien := false;
//                            //EditDetteCreanceTiers(NomMenuSiteWeb,Chemin,NomFich,DMPointage2.QuStocksEdition,'Compte',DMPointage2.QuListeValRupt,DMStock.QuTotalG,DateToStr(now),Site);
//                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                        End;
//      end;
//      DataModuleImmos.QuListeValRupt.Close;
//      DataModuleImmos.QuSousTotal1.Close;
//      DataModuleImmos.QuTotalG1.Close;
//      DataModuleImmos.QuImmosEdition.Close;
//  end;
//End;

constructor TobjetImmos.Create(AOwner :TComponent);
Begin
inherited create;
End;

destructor TobjetImmos.Destroy;
Begin
inherited Destroy;
End;


procedure TDataModuleImmos.QuRecupImmosSurCptCalcFields(DataSet: TDataSet);
//var pvCT, pvLT:Currency;
begin
//pvCT:=0;
//pvLT:=0;
   with Dataset do
    begin
      if FieldValues['Type_Amt'] = 'L' then
        FieldValues['TypeA'] := 'Linéaire';
      if FieldValues['Type_Amt'] = 'D' then
        FieldValues['TypeA'] := 'Dégressif';
      if FieldValues['Type_Amt'] = 'N' then
        FieldValues['TypeA'] := 'Non amortissable';
      if ((FieldValues['Cession_dans_Annee']=false)and(FieldValues['rebut']=false)) then
        FieldValues['situation'] := '';
      ///
      Initialise_TInfosImmos(ImmosEnCours);
      ImmosEnCours.Ecriture_Cession:=DataSet.FindField('Ecriture_Cession').AsInteger;
      ImmosEnCours.Mt_Cession:=DataSet.FindField('Mt_Cession').AsCurrency;
      ImmosEnCours.Date_Cession:=DataSet.FindField('Date_Cession').AsDateTime;
      ImmosEnCours.Rebut:=DataSet.FindField('Rebut').Asboolean;
      ImmosEnCours.Cession_dans_Annee:=DataSet.FindField('Cession_dans_Annee').Asboolean;

      ImmosEnCours.Terminee:=DataSet.FindField('Terminee').Asboolean;
      ImmosEnCours.EnCours:=DataSet.FindField('EnCours').Asboolean;
      ImmosEnCours.CodeTerminee:=DataSet.FindField('CodeTerminee').AsString;
      ImmosEnCours.CompteTerminee:=DataSet.FindField('CompteTerminee').AsString;
      //
//      if ((FieldValues['Cession_dans_Annee']=true)or(not empty(Dataset.Findfield('Date_Cession').asstring)))then
      if ImmosCedee(ImmosEnCours) then
        FieldValues['situation'] := 'C';
//      if FieldValues['rebut']=True then
      if ImmosRebut(ImmosEnCours) then
          FieldValues['situation'] := 'R';
      if ImmosTerminee(ImmosEnCours) then
          FieldValues['situation'] := 'T';
    end;
end;

//******************* TDataModuleImmos.Amortissable *************************
function TDataModuleImmos.Amortissable(Compte:string):TTypeImmo;
begin
//Rechercher si le compte est amortissable en fonction de l'étoile
//trouvé dans le plan comptable
result.Amortissable:=false;
result.Degressif:=false;
result.devenirAmortissable := DMPlan.CptDevenirAmortissable(Compte);
result:=dmplan.CptEstAmortissable(compte);
end;

//******************* TDataModuleImmos.Compare *************************
function TDataModuleImmos.Compare(Date_A, Date_B:TDateTime):TDateTime ;
begin
   if Date_A > Date_B then result := Date_A
   else result := Date_B;
end;

//******************* TDataModuleImmos.Calcule_PM_Values *************************
procedure TDataModuleImmos.Calcule_PM_Values(var pvCT, pvLT:Currency;Dataset:Tdataset);
var
valnet, amant, rmdi,amt,pval,vres:currency;
datach:TDateTime;
begin
   pvCT := 0; pvLT := 0;
	with Dataset do begin
//      valnet := FindField('Valeur_Nette').AsCurrency - FindField('Choix').AsCurrency;
Dataset.FindField('id').asinteger;
      valnet := (FindField('Valeur_A_Amortir').AsCurrency)-(FindField('Amort_Derog').AsCurrency)-(FindField('Amort_Eco').AsCurrency)-(FindField('Choix').AsCurrency);
      if FindField('Mt_Deduc_Invest').AsCurrency > 0 then
         rmdi := FindField('Mt_Deduc_Invest').AsCurrency * valnet / FindField('Valeur_a_Amortir').AsCurrency
      else
         rmdi := 0;
      if FindField('Valeur_Org').AsCurrency > FindField('Valeur_a_Amortir').AsCurrency then
         amant := FindField('Valeur_Org').AsCurrency - FindField('Valeur_a_Amortir').AsCurrency
      else
         amant := 0;
      valnet := valnet - rmdi;
      amt := FindField('Amort_Eco').AsCurrency + FindField('Amort_Derog').AsCurrency + FindField('Choix').AsCurrency + amant + rmdi;
      if FindField('Valeur_Venale').AsCurrency > 0 then begin
         amt := amt - amant;
         vres := FindField('Valeur_Venale').AsCurrency - amt;
         if vres < 0 then vres := 0;
         pval := FindField('Mt_Cession').AsCurrency - vres;
      end
      else
         pval := FindField('Mt_Cession').AsCurrency - valnet;
      datach := Compare(FindField('Date_Org').AsDateTime, FindField('Date_Achat').AsDateTime);
      if FindField('Date_Cession').AsDateTime - datach + 1 > 730 then begin // > 2 ans
         //if Amortissable(FindField('Compte').AsString).Amortissable then begin // amortissable
         if FindField('type_amt').AsString<>'N' then begin // amortissable
            if pval > 0 then begin // plus value
               pvCT := min(amt, pval);
               if FindField('Valeur_Venale').AsCurrency > 0 then
                  pvCT := min(FindField('Valeur_Venale').AsCurrency, pvCT);
               pvLT := pval - pvCT;
            end
            else // moins value
               pvCT := pval;
         end
         else // non amortissable
            pvLT := pval;
      end
      else   // < 2 ans
         pvCT := pval;
   end; // with
end;

procedure TDataModuleImmos.tbPMVCalcFields(DataSet: TDataSet);
var pvCT, pvLT:Currency;
begin
tbPMVCode_ID.Value := tbPMVCompte.Value + '  ' + tbPMVCode.Value + '  ' + tbPMVSous_Code.Value;
   Calcule_PM_Values(pvCT, pvLT,tbPMV);
   tbPMVpvCT.Value := pvCT;
   tbPMVpvLT.Value := pvLT;
   tbPMV.FindField('PlusValue').AsCurrency:=pvCT+pvLT;
   tbPMVValeur_Nette_Calc.AsCurrency:=tbPMVValeur_a_Amortir.AsCurrency - tbPMVAmort_Eco.AsCurrency - tbPMVAmort_Derog.AsCurrency-tbPMVChoix.AsCurrency;
//   tbPMVValeur_Nette_Calc.AsCurrency:=tbPMVValeur_a_Amortir.AsCurrency - tbPMVAmort_Eco.AsCurrency - tbPMVAmort_Derog.AsCurrency;
end;

procedure TDataModuleImmos.DataModuleImmosDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
//FreeAndNil(ListMtACeder);
//FreeAndNil(ListImmosEnCoursALier);
//FreeAndNil(ListeRestaure);
//FreeAndNil(ListeParticularite);
//FreeAndNil(ListeModif);
//FreeAndNil(ListeFilterRecordAcquisition);
Initialise_TStringlist(ListMtACeder);
Initialise_TStringlist(ListImmosEnCoursALier);
Initialise_TStringlist(ListeRestaure);
Initialise_TStringlist(ListeParticularite);
Initialise_TStringlist(ListeModif);
Initialise_TStringlist(ListeFilterRecordAcquisition);
Initialise_TStringlist(ListeImmobilisable);
if DMImmos_Ouverture<>nil then DMImmos_Ouverture.free;
DataModuleImmos:=nil;
end;




procedure TDataModuleImmos.Filtrage_QuRecupImmosSurCpt_SurTag(TagTmp:integer;Partiel:boolean;Rang:integer;SQLText,Cpt:string;DateDeb,Datefin:Tdate);
Begin
//Filtrage des Immos en fonction des écrans (ListeImmos,ListeAcquis,ListeCessions,...)
QuRecupImmosSurCpt.Close;
if partiel then
Begin
QuRecupImmosSurCpt.SQL.Strings[Rang] := SQLText;
End
else
Begin
QuRecupImmosSurCpt.SQL.Clear;
   case TagTmp of
   0,1,2,3,4,6:Begin //C_IMMOS, C_ACQUIS_EXO, C_CESSION, C_REBUT, C_DIVISION, C_ACQUISITION_Termninee
       QuRecupImmosSurCpt.SQL.Add('select Compte + "  " + Code + "  " + Sous_Code + "  " + Libelle as Immobilisation,');
       QuRecupImmosSurCpt.SQL.Add(' (amort_eco+amort_derog)as report, Valeur_a_Amortir,choix,(choix+(amort_eco+amort_derog))as Cumul,  (Valeur_a_Amortir-(choix+(amort_eco+amort_derog)))as Valeur_nette,');
       QuRecupImmosSurCpt.SQL.Add('Type_Amt, Date_mise_en_service,Achat_Dans_Annee,ID,Ecriture_Cession,Cession_dans_annee,rebut,Date_cession,Mt_Cession,Compte,Terminee,EnCours,CodeTerminee,CompteTerminee,SousCodeTerminee ');
       QuRecupImmosSurCpt.SQL.Add('from immos');
       QuRecupImmosSurCpt.SQL.Add('where Compte like :Cpt and ((Terminee=false) or ((Terminee=true) and (Cession_Dans_Annee=true)))');
       QuRecupImmosSurCpt.SQL.Add('and Immos.Date_Achat>= :DateDebut');
       QuRecupImmosSurCpt.SQL.Add('and Immos.Date_Achat <= :DateFin and ((Date_Cession is null) or (Date_Cession >=:DateExoEnCours))');
       QuRecupImmosSurCpt.SQL.Add('order by Immobilisation');
       QuRecupImmosSurCpt.parambyname('Cpt').asstring:=Cpt;
       QuRecupImmosSurCpt.parambyname('DateDebut').asDate:=DateDeb;
       QuRecupImmosSurCpt.parambyname('DateFin').asDate:=Datefin;
       QuRecupImmosSurCpt.ParamByName('DateExoEnCours').AsDate:=e.DatExoDebut;
     End;
//   1:;//C_ACQUIS_EXO
//   2:;//C_REBUT
//   3:;//C_DIVISION
//   4:;//C_ACQUISITION
//   5:;
   7:Begin//C_CESSION_EXO
       QuRecupImmosSurCpt.SQL.Add('select Compte + "  " + Code + "  " + Sous_Code + "  " + Libelle as Immobilisation,');
       QuRecupImmosSurCpt.SQL.Add(' (amort_eco+amort_derog)as report, Valeur_a_Amortir,choix,(choix+(amort_eco+amort_derog))as Cumul,  (Valeur_a_Amortir-(choix+(amort_eco+amort_derog)))as Valeur_nette,');
       QuRecupImmosSurCpt.SQL.Add('Type_Amt, Date_mise_en_service,Achat_Dans_Annee,ID,Ecriture_Cession,Cession_dans_annee,rebut,Date_cession,Mt_Cession, Compte,Terminee,EnCours,CodeTerminee,CompteTerminee,SousCodeTerminee ');
       QuRecupImmosSurCpt.SQL.Add('from immos');
       QuRecupImmosSurCpt.SQL.Add('where ((Date_Cession Is not Null)or(Rebut=true))');
       QuRecupImmosSurCpt.SQL.Add('and Compte like :Cpt and Terminee=false');
       QuRecupImmosSurCpt.SQL.Add('and Date_Achat >= :DateDebut and Date_Achat <= :DateFin and Date_Cession >=:DateExoEnCours');
       QuRecupImmosSurCpt.SQL.Add('order by Immobilisation');
       QuRecupImmosSurCpt.parambyname('DateDebut').asDate:=strtodate('01/01/1900');
       QuRecupImmosSurCpt.parambyname('DateFin').asDate:=Datefin;
       QuRecupImmosSurCpt.ParamByName('DateExoEnCours').AsDate:=e.DatExoDebut;
     End;
   end;//fin du case
QuRecupImmosSurCpt.parambyname('Cpt').asstring:=Cpt;
End;
QuRecupImmosSurCpt.Prepare;
QuRecupImmosSurCpt.open;
Filtrage_qryTotalCumulImmosSurCpt_SurTag(TagTmp,Partiel,Rang,SQLText,Cpt,DateDeb,Datefin);
End;


procedure TDataModuleImmos.Filtrage_qryListeAcquis_SurTag(TagTmp:integer;Partiel:boolean;Rang:integer;SQLText:string);
Begin
Initialise_TStringlist(ListeImmobilisable,DataModuleImmos,false);
//Filtrage des Immos en fonction des écrans (ListeImmos,ListeAcquis,ListeCessions,...)
with qryListeAcquis do
   begin
      Close;
      if partiel then
      Begin
      SQL.Strings[Rang] := SQLText;
      End
      else
      Begin
      SQL.Clear;
         case TagTmp of
         0:Begin //C_IMMOS
                 End;
         1:;//C_ACQUIS_EXO
         2:;//C_REBUT
         3:;//C_DIVISION
         4,41,42,5,51,52,10,101,102:Begin //C_ACQUISITION_Terminee/Immos
             FiltrageDataSet(dmrech.TaPlanCptRech,'Immobilisation = Vrai');
             ListeImmobilisable:=ChampTableVersListe('compte',dmrech.TaPlanCptRech);
             OnFilterRecord:=qryListeAcquisFilterRecord;
             SQL.Add('SELECT Compte, "Ecriture.db"."Date", Libelle, Debit, Credit, ID ');
             SQL.Add('From Ecriture.db E LEFT JOIN Immos.db I ON E.ID = I.Ecriture_Achat ');
             SQL.Add('LEFT JOIN plancpt.db P ON E.compte = P.Compte ');
             SQL.Add('where (P.Immobilisation = true) and I.Ecriture_Achat Is Null');
             case tagTmp of
             4,5,10:Begin //tous
                   SQL.Add('and ((Compte like "2%"');
                   SQL.Add('and Compte not like "28%"');
                   SQL.Add('and Compte not like "29%" and E.Debit<>0 and not E.Debit is null)');
                   SQL.Add('or(compte like "13%" and E.Credit<>0 and not E.Credit is null))');
                  End;
            41,51,101:Begin //Immos
                   SQL.Add('and (Compte like "2%"');
                   SQL.Add('and Compte not like "28%"');
                   SQL.Add('and Compte not like "29%" and E.Debit<>0 and not E.Debit is null)');
                  End;
            42,52,102:Begin //sub
                   SQL.Add('and (Compte like "13%"');
                   SQL.Add('and E.Credit<>0 and not E.Credit is null)');
                  End;
             end;//fin du 2ième case.tag
             SQL.Add(' Order by  Compte');
           End;
         6,61,62:Begin//C_CESSION
             OnFilterRecord:=nil;
             SQL.Add('SELECT Compte, "Ecriture.db"."Date", Libelle, Debit, Credit, ID');
             SQL.Add('From Ecriture.db E LEFT JOIN Immos.db I ON E.ID = I.Ecriture_cession');
             SQL.Add('where ((I.Ecriture_cession Is Null)or(I.Ecriture_cession=0)) ');
             case tagTmp of
//               6:Begin //tous
//                   SQL.Add('and((Compte like "775%"  and E.Credit<>0 and not E.Credit is null)or(compte like "131%" and E.Debit<>0 and not E.Debit is null))');
//                 End;

               6:Begin //Immos
                   SQL.Add('and (Compte like "775%"  and E.Credit<>0 and not E.Credit is null)');
                  End;
//               62:Begin //sub
//                   SQL.Add('and (Compte like "131%"');
//                   SQL.Add('and E.Debit<>0 and not E.Debit is null)');
//                  End;

             end;//fin du 2ième case.tag
             SQL.Add('Order by  Compte');
           End;
         7:Begin//C_CESSION_EXO

           End;
         end;//fin du case
      End;
      qryListeAcquis.filter:='date>= '''+datetostr(e.DatExoDebut)+''' and date<= '''+datetostr(e.DatExoFin)+'''';
      qryListeAcquis.filtered:=true;
      Prepare;
      open;
   end;//fin du with
End;

procedure TDataModuleImmos.UpdateImmosSurValeurs(TableEnCours:TTable;rang:array of string;Valeurs: array of variant;TableState:Tdatasetstate;IDImmos:integer);
var
i:integer;
Begin
   try
    if TableEnCours.active=false then
      TableEnCours.Open;
   TableGereStartTransaction(TableEnCours);
   if not (TableEnCours.State in [dsinsert,dsedit])then
     begin //si table en browse ou dsinactive
        case tablestate of
        dsinsert:Begin //si on veut insérer un nouvel enregistrement
                  TableEnCours.insert;
                  if IDImmos<>-1 then
                  TableEnCours.FindField('ID').AsInteger:=IDImmos
                  else
                  TableEnCours.FindField('ID').AsInteger:=MaxId_Query(TableEnCours,'ID');
                 End; //fin si on veut insérer un nouvel enregistrement
          dsEdit:Begin //si on veut modifier un enregistrement
                  if TableEnCours.FindField('ID').AsInteger=idimmos then
                  TableEnCours.edit
                  else
                   Begin
                    if TableEnCours.locate('ID',idimmos,[])then
                       TableEnCours.edit
                       else
                       abort;
                   End;
                 End;// fin si on veut modifier un enregistrement
        end;//fin du case;
     end//fin si table en browse ou dsinactive
     else
      if TableEnCours.State=dsedit then
      begin //si table en edition
       if IDImmos<>-1 then //si idimmos est renseigné
        if TableEnCours.FindField('ID').AsInteger<>idimmos then
          begin //si on n'est pas positionné sur le bon enregistrement
          showmessage('La table Immos n''est pas positionné sur le bon enregistrement');
          abort;
          end;// fin si on n'est pas positionné sur le bon enregistrement
      end// fin si table en edition
      else
        if TableEnCours.State=dsinsert then
          if IDImmos<>-1 then
            TableEnCours.FindField('ID').AsInteger:=IDImmos
          else
            TableEnCours.FindField('ID').AsInteger:=MaxId_Query(TableEnCours,'ID');

   for i:=0 to high(rang)do
   begin
     if (((TableEnCours.findfield(rang[i]).DataType=ftDate)or(TableEnCours.findfield(rang[i]).DataType=ftDateTime))and(valeurs[i]=0))then
       TableEnCours.findfield(rang[i]).asstring:=''
     else
       TableEnCours.findfield(rang[i]).Value:=valeurs[i];
   end;
   DataModuleImmos.Compte_DernierCree:=TableEnCours.FindField('compte').Asstring;
   DataModuleImmos.ID_DernierCree:=TableEnCours.FindField('ID').AsInteger;
   TableGerePost(TableEnCours);
//   tablegerecommit(tableEncours);
   except
    showmessage('Problème lors de l''enregistrement d''une immobilisation ');
    TableGereRollBack(TableEnCours);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
   end;//fin du try
End;


procedure TDataModuleImmos.taDetailImmoPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDataModuleImmos.taDetailImmoAfterPost(DataSet: TDataSet);
begin
  try
   TableGereCommit(DataSet);
   TableGereCommit(DMBalance.TaBalance);
  except
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
end;



procedure TDataModuleImmos.FiltrageQuRecImmos_ParamDivers(TextSql:string);
Begin
   try
   QuRecImmos_ParamDivers.Close;
   QuRecImmos_ParamDivers.SQL.Clear;
   QuRecImmos_ParamDivers.SQL.Add(TextSql);
   QuRecImmos_ParamDivers.Open;
   except
     showmessage('Problème lors du filtrage d''une immobilisation ');
     abort;
   end;//fin du try except
End;

function TDataModuleImmos.Trouve_sous_code(Cpt,code:string): string;
var i:integer; s:string;
begin
  try
     FiltrageQuRecImmos_ParamDivers('select Compte, Code, Sous_Code From Immos.db Where Compte = "'+Cpt +'" and Code = "' + code + '" Order by Sous_Code');
     QuRecImmos_ParamDivers.Last;
        if not empty(QuRecImmos_ParamDivers.FindField('Sous_Code').AsString)then
        Begin
        i := StrToInt_Lgr(QuRecImmos_ParamDivers.FindField('Sous_Code').AsString);
        s := IntToStr(i + 1);
        result := s;
        End
        else
        result:='1';
  except
   result:='';
   abort;
  end;
end;


procedure TDataModuleImmos.DataModuleImmosCreate(Sender: TObject);
begin
ListeImmobilisable:=Tstringlist.Create;
OuvrirTouteTable('',TControl(self));
if ListeFilterRecordAcquisition=nil then
  ListeFilterRecordAcquisition:=Tstringlist.Create;
if ListMtACeder=nil then
ListMtACeder:=tstringlist.Create;
if ListImmosEnCoursALier=nil then
ListImmosEnCoursALier:=tstringlist.Create;
 if ListeRestaure=nil then
    ListeRestaure:=TStringList.Create;
 if ListeParticularite=nil then
    ListeParticularite:=TStringList.Create;
 if ListeModif=nil then
    ListeModif:=TStringList.Create;
ModificationImmos:=false;
ModificationImmo_A_Ceder:=false;
initialiserChoix(Choix_AvantCession);
initialiserChoix(Choix_AvantRebut);
suppressionPieceDotation:=false;

//  taDetailImmo
FormateMonnaieField(taDetailImmo,E.FormatMonnaie,'0.00 ;-0.00 ');
//FormateMonnaieField(taDetailImmo,E.FormatMonnaie,E.EditFormat);

taDetailImmoCode.ValidChars:=(['0'..'9']);
taDetailImmoSous_Code.ValidChars:=(['1'..'9']);
taDetailImmoCompte.ValidChars:=(['0'..'9']);

// TaImmosEnCours
FormateMonnaieField(TaImmosEnCours,E.FormatMonnaie,'0.00 ;-0.00 ');
TaImmosEnCoursCode.ValidChars:=(['0'..'9']);
TaImmosEnCoursSous_Code.ValidChars:=(['1'..'9']);
TaImmosEnCoursCompte.ValidChars:=(['0'..'9']);

// TaImmos_A_Ceder
FormateMonnaieField(TaImmos_A_Ceder,E.FormatMonnaie,'0.00 ;-0.00 ');
TaImmos_A_CederCode.ValidChars:=(['0'..'9']);
TaImmos_A_CederSous_Code.ValidChars:=(['1'..'9']);
TaImmos_A_CederCompte.ValidChars:=(['0'..'9']);

// TaImmosChoix
FormateMonnaieField(TaImmosChoix,E.FormatMonnaie,'0.00 ;-0.00 ');
TaImmosChoixCode.ValidChars:=(['0'..'9']);
TaImmosChoixSous_Code.ValidChars:=(['1'..'9']);
TaImmosChoixCompte.ValidChars:=(['0'..'9']);

//// TaCalculAmort
//FormateMonnaieField(TaCalculAmort,E.FormatMonnaie,'0.00 ;-0.00 ');
//TaCalculAmortCode.ValidChars:=(['0'..'9']);
//TaCalculAmortSous_Code.ValidChars:=(['1'..'9']);
//TaCalculAmortCompte.ValidChars:=(['0'..'9']);

//QuRecupImmosSurCpt
FormateMonnaieField(QuRecupImmosSurCpt,E.FormatMonnaie,'0.00 ;-0.00 ');

//QuCptUtiliseImmos
FormateMonnaieField(QuCptUtiliseImmos,E.FormatMonnaie,'0.00 ;-0.00 ');

//qryCumulImmosChoix
FormateMonnaieField(qryCumulImmosChoix,E.FormatMonnaie,'0.00 ;-0.00 ');

// qryTotalCumulImmos
FormateMonnaieField(qryTotalCumulImmos,E.FormatMonnaie,'0.00 ;-0.00 ');
//  taImmosRebut
FormateMonnaieField(taImmosRebut,E.FormatMonnaie,'0.00 ;-0.00 ');

end;

Function TDataModuleImmos.CtrlSaisieCessions(CCourant:Tfield):TErreurSaisie;
var
MontantInitial:currency;
begin // initialisation des variables de retour de fonction
result.CodeErreur:=0;
result.Retour:=True;
  if TaImmos_A_Ceder.State in [dsEdit] then
  begin //si état  modification
    if qryListeAcquisDebit.AsCurrency<qryListeAcquisCredit.AsCurrency then
    MontantInitial:=qryListeAcquisCredit.AsCurrency
    else
    MontantInitial:=qryListeAcquisDebit.AsCurrency;
        case CCourant.Index of
        22: begin // si champ Montant Cession
             if TaImmos_A_CederMt_Cession.Ascurrency<>0 then
               begin//si montantcession <>0
                Remplir_ou_Modifier_Liste(false,T_Cession);
                if CalculTotalColonneMontant(ListMtACeder,0,ListMtACeder.count-1,T_cession) >MontantInitial then
                  Begin
                   showmessage('Le montant total des cessions est supérieur au montant initial de la cession en cours ');
                   result.CodeErreur:=22001;
                   result.Retour:=false;
                  End;
               end;//fin si montantcession <>0
            end; //fin si champ Montant Cession
        23: begin // si champ Date cession
               //Vérifier la cohérence de la date par rapport à l'exercice
           if ((not DateValide(CCourant.Asstring))and(TaImmos_A_CederMt_Cession.Ascurrency<>0))then
                Pre_Remplir_Cession(TaImmos_A_CederMt_Cession.Ascurrency);
               //raise ExceptLGR.Create('La date de cession doit-être renseignée.',12001,true,mtError,Result);
            end; //fin si champ Date cession
        26: begin // si champ Cession dans année
              if ccourant.AsBoolean then
               begin //si à céder=true
                if ((empty(TaImmos_A_CederMt_Cession.AsString))or(TaImmos_A_CederMt_Cession.AsCurrency=0)) then
                 begin //si le montant n'est pas déjà rempli
                   if ListMtACeder.count>0 then
                      begin //si liste remplie
                      Remplir_ou_Modifier_Liste(true,T_Cession);
                      if MontantInitial-CalculTotalColonneMontant(ListMtACeder,0,ListMtACeder.count-1,T_Cession) >0 then
                         begin
                           Pre_Remplir_Cession(MontantInitial-CalculTotalColonneMontant(ListMtACeder,0,ListMtACeder.count-1,T_Cession));//tout remplir avec valeurs par défaut;
                           Remplir_ou_Modifier_Liste(false,T_Cession);
                         end
                      else
                         Begin
                           showmessage('Le montant de la cession comptable est déjà totalement répartie sur les immobilisation à céder');
                           ccourant.AsBoolean:=not ccourant.AsBoolean;
                           result.CodeErreur:=26001;
                           result.Retour:=false;
                         End;
                      end// fin si liste remplie
                   else
                      Begin//si liste vide
                        if MontantInitial>0 then
                          begin
                          Pre_Remplir_Cession(MontantInitial);
                          Remplir_ou_Modifier_Liste(false,T_Cession);
                          end;
                      End;// fin si liste vide
                 end//fin si le montant n'est pas déjà rempli
                 else
                   Begin
                     Remplir_ou_Modifier_Liste(false,T_Cession);
                     if CalculTotalColonneMontant(ListMtACeder,0,ListMtACeder.count-1,T_Cession) >MontantInitial then
                        Begin
                         showmessage('Le montant total des cessions est supérieur au montant initial de la cession en cours ');
                         Pre_Remplir_Cession(MontantInitial);
                         Remplir_ou_Modifier_Liste(false,T_Cession);
                         result.CodeErreur:=22001;
                         result.Retour:=false;
                        End;
                   End;
               end // fin si à céder=true
              else
                begin //si à céder=false
//                  if ((not empty(TaImmos_A_CederMt_Cession.AsString))and(TaImmos_A_CederMt_Cession.AsCurrency<>0)) then
//                    begin

                    Remplir_ou_Modifier_Liste(true,T_Cession);
                    InitialiserCession; //tout vider
//                    end;
                end; //fin si à céder=false
            end; //fin si champ Cession dans année
        end;//fin du case sur ccourant.index
  end;
end;


Function TDataModuleImmos.CtrlSaisieImmosTerminee(CCourant:Tfield):TErreurSaisie;
var
MontantInitial:currency;
begin // initialisation des variables de retour de fonction
result.CodeErreur:=0;
result.Retour:=True;
  if TaImmosEnCours.State in [dsEdit] then
  begin //si état  modification
        case CCourant.Index of
        34: begin // si champ Terminee
              if ccourant.AsBoolean then
               begin //si à Terminee=true
                 //remplir la liste des montants liés
                 //regarder si ce montant ne dépasse pas le montant de la nouvelle acquisition
                if qryListeAcquisDebit.AsCurrency<qryListeAcquisCredit.AsCurrency then
                MontantInitial:=qryListeAcquisCredit.AsCurrency
                else
                MontantInitial:=qryListeAcquisDebit.AsCurrency;
                if CalculTotalColonneMontant(ListImmosEnCoursALier,0,ListImmosEnCoursALier.Count-1,T_ImmosEnCours)+TaImmosEnCoursValeur_Org.AsCurrency<=MontantInitial then
                  Remplir_ou_Modifier_Liste(false,T_ImmosEnCours)
                else
                  Begin
                    showmessage('Le montant total des immobilisations en cours dépassent la valeur de la nouvelle acquisition');
                    ccourant.AsBoolean:=not ccourant.AsBoolean;
                    result.CodeErreur:=2601;
                    result.Retour:=false;
                  End;
               end // fin si à Terminee=true
              else
                begin //si à Terminee=false
                //effacer le montant de la ligne correspondante dans la liste
                Remplir_ou_Modifier_Liste(true,T_ImmosEnCours);
                end; //fin si à céder=false
            end; //fin si champ Cession dans année
        end;//fin du case sur ccourant.index
  end;//fin si état  modification
end;




procedure TDataModuleImmos.TaImmos_A_CederBeforePost(DataSet: TDataSet);
var
i:integer;
Valide:TErreurSaisie;
//AmortAnnee:TAmortImmo;
reference:string;
Ecriture_Defaut:string;
Solde:currency;
exception:TExceptLGR;
begin
Initialise_ExceptLGR(exception);
//avant, vérifier que le total des immos cédées soit
//inférieur ou égal au montant de l'écriture comptable
try//finally
try
if TaImmos_A_Ceder.State=dsedit then
  begin //si table en modification
  if VerificationSiPieceDeDotation(reference)then
    begin
    if application.MessageBox(Pchar('La pièce de dotation aux amortissement va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      DMPieces.SuppressionOD(reference)
    else
      abort;
    end;
   for i:=22  to 26 do
     begin //début du for i
        if i in [22,23,26] then
        begin //si champ 23,24 ou 27
        valide:=CtrlSaisieCessions(TaImmos_A_Ceder.Fields[i]);
        if valide.Retour=false then
              case valide.CodeErreur of
              22001:begin //champ Montant Cession
                     DataSet.Fields[22].FocusControl;
                     abort;
                   end;
              23001:begin //champ Date Cession
                     DataSet.Fields[23].FocusControl;
                     abort;
                   end;
              26001:begin //champ Cession dans année
                     DataSet.Fields[26].FocusControl;
                     abort;
                   end;
              end;//fin du case
        end;//fin si champ 23,24 ou 27
     end;//fin du for i
   RecalculAmort_ApresModifDataset(dataset,Choix_AvantCession);

//   Remplit_TInfosImmos(TaImmos_A_Ceder,ImmosEnCours);
//   AmortAnnee:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix_AvantCession);
//   TaImmos_A_CederValeur_Nette.AsCurrency:=AmortAnnee.VNC;
//   TaImmos_A_CederChoix.AsCurrency:=AmortAnnee.Choix;
//   if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
//      AmortAnnee.EcoRepartition:=AmortAnnee.Choix-AmortAnnee.Derog;
//   TaImmos_A_CederEco.AsCurrency:=AmortAnnee.EcoRepartition;
//   TaImmos_A_CederMini.AsCurrency:=amortannee.Mini;
//   TaImmos_A_CederMaxi.AsCurrency:=amortannee.Maxi;
  end;// fin si table en modification
////
    if infoscession.Ecriture_Cession<>0 then
      begin
          TableGereStartTransaction(DataModuleImmos.TaImmos_A_Ceder);
          if not VerifFNumeric(DataModuleImmos.qryListeAcquisDebit).VideOUZero then
            Solde:=DataModuleImmos.qryListeAcquisDebit.AsCurrency
          else
            Solde:=DataModuleImmos.qryListeAcquiscredit.AsCurrency;
          if DataModuleImmos.CalculTotalColonneMontant(DataModuleImmos.ListMtACeder,0,DataModuleImmos.ListMtACeder.count-1,T_cession)<>solde then
            raise ExceptLGR.Create ('Le montant de vos cessions ne correspond pas à celui de l"écriture comptable de cession, vous devez finir votre cession !',1000,true,mtError,exception);
          with DataModuleImmos.TaImmos_A_Ceder do
            begin
            if ((DataModuleImmos.TaImmos_A_Ceder.State in [dsedit,dsinsert])or(DataModuleImmos.ModificationImmo_A_Ceder)) then
               begin//si modification de la cession d'une immo
                 DataModuleImmos.TaImmos_A_Ceder.BeforePost:=nil;
                 for i:=0 to DataModuleImmos.ListMtACeder.Count-1 do
                   Begin
                       if not (DataModuleImmos.TaImmos_A_Ceder.State in [dsedit,dsinsert]) then
                        DataModuleImmos.TaImmos_A_Ceder.Locate('id',DataModuleImmos.ListMtACeder.strings[i],[]);
                       DataModuleImmos.UpdateImmosSurValeurs(DataModuleImmos.TaImmos_A_Ceder,['Ecriture_Cession'],
                        [infosCession.Ecriture_Cession],dsEdit,StrToInt_Lgr(DataModuleImmos.ListMtACeder.strings[i]));
                   End;
                   abort;
               end;//fin si modification de la cession d'une immo
             Initialise_TInfosCession(infoscession);
            end;//fin du with
         DataModuleImmos.Filtrage_qryListeAcquis_SurTag(C_Cession,false,-1,'');
          DataModuleImmos.tbPMV.Close;
          DataModuleImmos.tbPMV.open;
          DataModuleImmos.taDetailImmo.Refresh;
          TableGerecommit(DataModuleImmos.TaImmos_A_Ceder);
          TableGerecommit(DMBalance.TaBalance);
      end;
///
  except
     DataModuleImmos.TaImmos_A_Ceder.Cancel;
     TableGereRollBack(DataModuleImmos.TaImmos_A_Ceder);
     TableGereRollBack(DMBalance.TaBalance);
     abort;
  end;//fin du try except
finally
 DataModuleImmos.TaImmos_A_Ceder.BeforePost:=DataModuleImmos.TaImmos_A_CederBeforePost;
end;//fin du try finally
end;

procedure TDataModuleImmos.TaImmos_A_CederBeforePost_Simple(DataSet: TDataSet);
var
i:integer;
Valide:TErreurSaisie;
reference:string;
exception:TExceptLGR;
begin
Initialise_ExceptLGR(exception);
//avant, vérifier que le total des immos cédées soit
//inférieur ou égal au montant de l'écriture comptable
try//finally
try
if TaImmos_A_Ceder.State=dsedit then
  begin //si table en modification
  if VerificationSiPieceDeDotation(reference)then
    begin
    if application.MessageBox(Pchar('La pièce de dotation aux amortissement va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      DMPieces.SuppressionOD(reference)
    else
      abort;
    end;
   for i:=22  to 26 do
     begin //début du for i
        if i in [22,23,26] then
        begin //si champ 23,24 ou 27
        valide:=CtrlSaisieCessions(TaImmos_A_Ceder.Fields[i]);
        if valide.Retour=false then
              case valide.CodeErreur of
              22001:begin //champ Montant Cession
                     DataSet.Fields[22].FocusControl;
                     abort;
                   end;
              23001:begin //champ Date Cession
                     DataSet.Fields[23].FocusControl;
                     abort;
                   end;
              26001:begin //champ Cession dans année
                     DataSet.Fields[26].FocusControl;
                     abort;
                   end;
              end;//fin du case
        end;//fin si champ 23,24 ou 27
     end;//fin du for i
   end;
///
  except
     DataModuleImmos.TaImmos_A_Ceder.Cancel;
     TableGereRollBack(DataModuleImmos.TaImmos_A_Ceder);
     TableGereRollBack(DMBalance.TaBalance);
     abort;
  end;//fin du try except
finally
 DataModuleImmos.TaImmos_A_Ceder.BeforePost:=DataModuleImmos.TaImmos_A_CederBeforePost;
end;//fin du try finally
end;


function TDataModuleImmos.CalculTotalColonneMontant(Liste:TstringList;RangDep,rangFin:integer;TInfos:integer):currency;
var
i:integer;
Begin
result:=0;
 for i:=RangDep to rangFin do
   begin
     case Tinfos of
     1:begin
         if (liste.objects[i]as TobjetImmos).EcritureCession=qryListeAcquisID.Asinteger then
            result:=result+(liste.objects[i]as TobjetImmos).MontantCession;
       end;
     2:result:=result+(liste.objects[i]as TobjetImmos).MontantEnCours;
     end;//fin du case Tinfos
   end;//fin du for
End;


procedure TDataModuleImmos.Pre_Remplir_Cession(Montant:currency);
Begin
 TaImmos_A_CederCession_dans_Annee.AsBoolean:=true;
 TaImmos_A_CederDate_Cession.AsDateTime:=qryListeAcquisDate.AsDateTime;
 TaImmos_A_CederMt_Cession.AsCurrency:=Montant;
End;

procedure TDataModuleImmos.Remplir_ou_Modifier_Liste(Supp:boolean;TInfos:integer);
var
rang:integer;
IDTmp:string;
Begin
rang:=0;
  try
  case Tinfos of
    1:Begin
        IDTmp:=TaImmos_A_CederID.asstring;
        rang:=ListMtACeder.IndexOf(IDTmp);
      End;
    2:Begin
        IDTmp:=TaImmosEnCoursID.asstring;
        rang:=ListImmosEnCoursALier.IndexOf(IDTmp);
      End;
  end;//fin du case Tinfos (1er)
  if not supp then
    begin //si on veut la créer ou la modifier
      if rang =-1 then
        Begin //si la ligne n'existe pas, on la crée
        immos:=TobjetImmos.Create(self);
        case TInfos of
          1:Begin //si remplissage pour cession
              immos.Montantcession:=TaImmos_A_CederMt_Cession.AsCurrency;
              immos.EcritureCession:=qryListeAcquisID.AsInteger;
              ListMtACeder.AddObject(idtmp,immos);
            End;// fin si remplissage pour cession
          2:Begin//si remplissage pour Lier Immos en cours
              immos.DesignationEnCours:=TaImmosEnCoursLibelle.AsString+'_'+TaImmosEnCoursCompte.AsString+'_'+TaImmosEnCoursCode.AsString+'_'+TaImmosEnCoursSous_Code.AsString;
              immos.MontantEnCours:=TaImmosEnCoursValeur_Org.AsCurrency;
              ListImmosEnCoursALier.AddObject(idtmp,immos);
            End; //fin si remplissage pour Lier Immos en cours
        end;//fin du case Tinfos (2ieme)

        End //fin si elle n'existe pas
      else
        Begin //si elle existe, on la modifie
           case TInfos of
             1:Begin //si modification pour cession
                 (ListMtACeder.Objects[rang]as TobjetImmos).Montantcession:=TaImmos_A_CederMt_Cession.AsCurrency;
               End;// fin si remplissage pour cession
             2:Begin//si remplissage pour Lier Immos en cours
                 (ListImmosEnCoursALier.Objects[rang]as TobjetImmos).DesignationEnCours:=TaImmosEnCoursLibelle.AsString+'_'+TaImmosEnCoursCompte.AsString+'_'+TaImmosEnCoursCode.AsString+'_'+TaImmosEnCoursSous_Code.AsString;
                 (ListImmosEnCoursALier.Objects[rang]as TobjetImmos).MontantEnCours:=TaImmosEnCoursValeur_Org.AsCurrency;
               End; //fin si remplissage pour Lier Immos en cours
           end;//fin du 3ieme case TInfos
        End;//fin si elle existe, on la modifie
    end//fin si on veut la créer ou la modifier
  else
    if rang<>-1 then
      Begin //si on veut la supprimer
           case TInfos of
             1:Begin //si modification pour cession
                 ListMtACeder.Delete(rang);
               End;// fin si remplissage pour cession
             2:Begin//si remplissage pour Lier Immos en cours
                 ListImmosEnCoursALier.Delete(rang);
               End; //fin si remplissage pour Lier Immos en cours
           end;//fin du 3ieme case TInfos

      End;//fin si on veut la supprimer
  except
   showmessage('Problème lors de l"initialisation d"une immobilisation à céder ');
   abort;
  end;
End;


procedure TDataModuleImmos.InitialiserCession;
Begin
 TaImmos_A_CederCession_dans_Annee.Asboolean:=false;
 TaImmos_A_CederDate_Cession.Asstring:='';
 TaImmos_A_CederMt_Cession.Ascurrency:=0;
End;

//procedure TDataModuleImmos.GererDoubleClick(A_Ceder:boolean);
//var
//Montantinitial:currency;
//Begin
//if TaImmos_A_Ceder.State=dsedit then
//   begin
//    if qryListeAcquisDebit.AsCurrency<qryListeAcquisCredit.AsCurrency then
//       MontantInitial:=qryListeAcquisCredit.AsCurrency
//    else
//       MontantInitial:=qryListeAcquisDebit.AsCurrency;
//
//    if A_Ceder then
//      Pre_Remplir_Cession(MontantInitial)
//    else
//      InitialiserCession;
//   end;
//
//End;

procedure TDataModuleImmos.TaImmos_A_CederAfterPost(DataSet: TDataSet);
begin
   TableGereCommit(DataSet);
   TableGereCommit(DMBalance.TaBalance);
   initialiserChoix(Choix_AvantCession);
end;

procedure TDataModuleImmos.TaImmos_A_CederPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
   TableGereRollBack(DataSet);
   TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDataModuleImmos.TaImmos_A_CederBeforeClose(DataSet: TDataSet);
begin
  try
  TaImmos_A_Ceder.BeforePost:=nil;
  TaImmos_A_Ceder.afterPost:=nil;
  TaImmos_A_Ceder.First;
  while not TaImmos_A_Ceder.EOF do
    Begin
//    if empty(TaImmos_A_CederEcriture_Cession.AsString) then
    if ((empty(TaImmos_A_CederEcriture_Cession.AsString))and(TaImmos_A_CederRebut.AsBoolean=false)) then
        Begin
        TaImmos_A_Ceder.Edit;
        TaImmos_A_CederCession_dans_Annee.AsBoolean:=false;
        TaImmos_A_CederDate_Cession.AsString:='';
        TaImmos_A_CederMt_Cession.AsString:='';
        TaImmos_A_CederRebut.AsBoolean:=false;
        TableGerePost(DataSet);
        End;
    TaImmos_A_Ceder.Next;
    End;
  finally
    TaImmos_A_Ceder.BeforePost:=TaImmos_A_CederBeforePost;
    TaImmos_A_Ceder.afterPost:=TaImmos_A_CederAfterPost;
    if ProtectObjetNil([ListMtACeder]) then
      ListMtACeder.clear;
  end;
end;

procedure TDataModuleImmos.TaImmosEnCoursAfterPost(DataSet: TDataSet);
begin
//   TableGereCommit(DataSet);
//   TableGereCommit(DMBalance.TaBalance);
end;

procedure TDataModuleImmos.TaImmosEnCoursPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
   TableGereRollBack(DataSet);
   TableGereRollBack(DMBalance.TaBalance);
end;


function TDataModuleImmos.RetourneSiPieceContientdesImmosEnCours(idEcriture:integer;DatabaseTmp:TDatabase):boolean;
var
QueryTmp:Tquery;
Begin
  try
    try
    QueryTmp:=TQuery.Create(self);
    QueryTmp.DatabaseName:=DatabaseTmp.DatabaseName;
    QueryTmp.sql.Add('select p.id');
    QueryTmp.sql.Add('from Ecriture E1 join piece p on(E1.id_piece=P.id)');
    QueryTmp.sql.Add('where p.id in (select P1.id');
    QueryTmp.sql.Add('from piece P1 join Ecriture E on(E.id_piece=P1.id)');
    QueryTmp.sql.Add('where E.compte like(''23%''))');
    QueryTmp.sql.Add('and E1.id=:ID');
    QueryTmp.ParamByName('ID').asinteger:= idEcriture;
    QueryTmp.open;
    result:=QueryTmp.recordcount<>0;
    except
     result:=false;
     abort;
    end;//fin du try except
  finally
    QueryTmp.close;
    LibereObjet(Tobject(QueryTmp));
  //QueryTmp.Free;
  end;//fin du try finally
End;


function TDataModuleImmos.GererRemplissageLibelle(Liste:tstringlist;LibDefaut:string;var Dernier:string):string;
Begin
result:=Dernier;
// if liste.Count<>0 then
//   Begin
//    if liste.Count=1 then
//      result:=(Liste.Objects[0]as TobjetImmos).DesignationEnCours;
//   End
// else
   Begin
     if not empty(LibDefaut) then
       result:=LibDefaut;
   End;
//if not empty(result)then
  Dernier:=result;
End;


function TDataModuleImmos.ListImmosEnCoursALier_IndexOf(Const S:String;ValeurRech:integer):integer;
var
i:integer;
Begin
result:=-1;
i:=0;
while i<= ListImmosEnCoursALier.Count-1 do
   begin
     case valeurRech of
     1: if (ListImmosEnCoursALier.Objects[i]as TobjetImmos).DesignationEnCours=S then
        begin //si designation en cours
        result:=i;
        i:=ListImmosEnCoursALier.Count-1;
        end;
     2: if E.FormatCurrSansDevise((ListImmosEnCoursALier.Objects[i]as TobjetImmos).MontantEnCours)=S then
        begin  //si montant en cours
        result:=i;
        i:=ListImmosEnCoursALier.Count-1;
        end;
     3: if E.FormatCurrSansDevise((ListImmosEnCoursALier.Objects[i]as TobjetImmos).Montantcession)=S then
        begin //si montant cession
        result:=i;
        i:=ListImmosEnCoursALier.Count-1;
        end;
     end;//fin du case Valeur Rech
     inc(i);
   end;//fin du while
End;


procedure TDataModuleImmos.TaImmosEnCoursFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
Begin//si
 case TypePresentation of
C_ACQUISITION_Terminee,      
C_ACQUISITION_En_Cours,
C_ACQUISITION_Simple: Begin//si acquisition
                         Accept:=(((TaImmosEnCoursTerminee.asboolean=false) or(empty(TaImmosEnCoursCompteTerminee.asstring)))and (TaImmosEnCoursRebut.AsBoolean=false));
                      End;
C_DESCRIPTION_terminee,
C_DESCRIPTION_Simple,
C_DESCRIPTION_En_Cours:Begin//si description
                         accept:=((TaImmosEnCoursCompteTerminee.asstring=taDetailImmoCompte.AsString) and (TaImmosEnCoursCodeTerminee.Asstring=taDetailImmoCode.AsString)and (TaImmosEnCoursSousCodeTerminee.Asstring=taDetailImmoSous_Code.AsString));
                       End;
 end;//fin du case
 end;
end;

//Procedure TDataModuleImmos.RaffraichitDonnees(Querys:array of TQuery;Tables:array of TTable);
//var
//i:integer;
//Begin
// for i:=0 to high(Querys) do
//   begin
//    Querys[i].Active:=false;
//    Querys[i].Active:=true;
//   end;
// for i:=0 to high(Tables) do
//   Begin
//    Tables[i].Active:=false;
//    Tables[i].Active:=true;
//   End;
//End;

procedure TDataModuleImmos.TaImmosEnCoursBeforeClose(DataSet: TDataSet);
begin
TaImmosEnCours.First;
while not TaImmosEnCours.EOF do
  Begin
  if ((TaImmosEnCoursEnCours.AsBoolean)and(empty(TaImmosEnCoursCodeTerminee.AsString)) or (empty(TaImmosEnCoursCompteTerminee.AsString))) then
      Begin
      TaImmosEnCours.Edit;
      TaImmosEnCoursTerminee.AsBoolean:=false;
      TableGerePost(DataSet);
      End;
  TaImmosEnCours.Next;
  End;
end;


function TDataModuleImmos.TrouveCode(Cpt:string) : string;
var i:integer; s:string;
begin
   with DMImmos.DataModuleImmos.QuRecImmos_ParamDivers do begin
      Close;
		SQL.Clear;
      SQL.Add('select Compte, Code, Sous_Code');
      SQL.Add('From Immos.db');
      SQL.Add('Where Compte = "' + Cpt + '"');
      SQL.Add('Order by Code, Sous_Code');
      Prepare;
      Open;
      if RecordCount > 0 then begin
         Last;
         i := StrToInt_Lgr(FindField('Code').AsString);
         s := IntToStr(i+1);
         while length(s) < 3 do s := '0' + s;
         result := s;
      end
      else begin
         result := '001';
      end;
		Close;
      UnPrepare;
   end;
end;

function TDataModuleImmos.ExisteNumImmo(table:TTable;Compte,Code,SousCode,IDCourant:string):boolean;
var
TableTemp:TTable;
Begin
  try
  result:=false;
  TableTemp:=TTable.Create(self);
  TableTemp.DatabaseName:=table.DatabaseName;
  TableTemp.TableName:=table.TableName;
  TableTemp.Open;
  if Table.State=dsedit then
    tabletemp.Filter:='Compte='''+Compte+'''and Code='''+Code+'''and sous_Code='''+SousCode+'''and ID<>'''+IDCourant+''''
  else
    tabletemp.Filter:='Compte='''+Compte+'''and Code='''+Code+'''and sous_Code='''+SousCode+'''';
  tabletemp.filtered:=true;
  if tabletemp.recordcount<>0 then
    result:=true;
  finally
  TableTemp.close;
  LibereObjet(TObject(TableTemp));
//  tabletemp.Free;
//  tabletemp:=nil;
  end;//fin du try finally
End;


function TDataModuleImmos.RechercherCoefficient_surPeriodeValidite(dateAchat:TdateTime;Duree:integer):real;
Begin
//remplir cette variable en fonction des données récupérées dans la table des plages et
//des périodes de validité
result:=1;
//if ((duree>=36) and (duree<=48)) then
//result := 1.5
//  else
//    if ((duree>=49) and (duree<=72)) then
//    result := 2
//    else
//      if duree>=73  then
//      result := 2.25
QuRecupCoef.close;
QuRecupCoef.ParamByName('Duree').asinteger:=Duree;
QuRecupCoef.ParamByName('DateAchat').AsDateTime:=dateAchat;
QuRecupCoef.open;
if QuRecupCoef.findfield('Coefficient').AsFloat<>0 then
  result :=QuRecupCoef.findfield('Coefficient').AsFloat;

End;

procedure TDataModuleImmos.TaImmos_A_CederBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDataModuleImmos.TaImmos_A_CederBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDataModuleImmos.TaImmosChoixCalcFields(DataSet: TDataSet);
var
immos:TAmortImmo;
begin
initialiserAmortissement(immos);
immos.compte:=TaImmosChoixCompte.AsString;
immos.Gerer_Derog:=e.Derogatoire;
immos.Report_Derog:=TaImmosChoixAmort_Derog.AsCurrency;
immos.Choix:=TaImmosChoixChoix.AsCurrency;
immos.EcoRepartition:=TaImmosChoixEco.AsCurrency;
TaImmosChoixDerog.AsCurrency:=TaImmosChoixChoix.AsCurrency-TaImmosChoixEco.AsCurrency;

TaImmosChoixImmobilisation.AsString:=TaImmosChoixCompte.AsString+' '+TaImmosChoixCode.AsString+' '+TaImmosChoixSous_Code.AsString+' '+TaImmosChoixLibelle.AsString;
//if ((e.Derogatoire)or(((TaImmosChoixAmort_Derog.AsCurrency>0))and(TaImmosChoixChoix.AsCurrency-TaImmosChoixEco.AsCurrency<0)))then
//  begin
//  if TaImmosChoixChoix.AsCurrency-TaImmosChoixEco.AsCurrency<0 then
//    begin
//    TaImmosChoixDerog.AsCurrency:=TaImmosChoixChoix.AsCurrency-TaImmosChoixEco.AsCurrency;
//    if abs(TaImmosChoixDerog.AsCurrency)>TaImmosChoixAmort_Derog.AsCurrency then
//       TaImmosChoixDerog.AsCurrency:=TaImmosChoixAmort_Derog.AsCurrency;
//    end
//  end
//else
// TaImmosChoixDerog.AsCurrency:=0;

end;

procedure TDataModuleImmos.DaImmosChoixStateChange(Sender: TObject);
begin
qryCumulImmosChoix.close;
qryCumulImmosChoix.open;
end;

procedure TDataModuleImmos.TaImmosChoixBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDataModuleImmos.TaImmosChoixBeforeDelete(DataSet: TDataSet);
begin
abort;
end;


constructor TAmortissement_Obj.Create(AOwner :TComponent);
Begin
inherited create;
End;

destructor TAmortissement_Obj.Destroy;
Begin
inherited Destroy;
End;


procedure TDataModuleImmos.Remplir_ou_Modifier_ListeChoix(Supp:boolean;Liste:Tstringlist;MessageTmp:string);
var
rang:integer;
IDTmp:string;
Begin
  try
  IDTmp:=TaImmosChoixID.asstring;
  rang:=Liste.IndexOf(IDTmp);
  if not supp then
    begin //si on veut la créer ou la modifier
      if rang =-1 then
        Begin //si la ligne n'existe pas, on la crée
          Amortissement:=TAmortissement_Obj.Create(self);
          Amortissement.MontantChoix:=TaImmosChoixChoix.AsCurrency;
          Liste.AddObject(idtmp,Amortissement);
        End //fin si elle n'existe pas
      else
        Begin //si elle existe, on la modifie
          (Liste.Objects[rang]as TAmortissement_Obj).MontantChoix:=TaImmosChoixChoix.AsCurrency;
        End;//fin si elle existe, on la modifie
    end//fin si on veut la créer ou la modifier
  else
    if rang<>-1 then
      Begin //si on veut la supprimer
        Liste.Delete(rang);
      End;//fin si on veut la supprimer
  except
   showmessage(MessageTmp);
   abort;
  end;
End;

//procedure TDataModuleImmos.RestaurerChoixAvantModif(Liste:Tstringlist);
//var
//rang:integer;
//Begin
//try
//TaImmosChoix.DisableControls;
//TaImmosChoix.BeforePost:=nil;
//TaImmosChoix.first;
//  while not(TaImmosChoix.EOF) do
//    Begin
//      rang:=Liste.IndexOf(TaImmosChoixID.asstring);
//      if rang<>-1 then
//        begin
//        taimmoschoix.edit;
//        taimmoschoixchoix.AsCurrency:=(Liste.Objects[rang] as TAmortissement_Obj).MontantChoix;
//        TableGerePost(taimmoschoix);
//        end;
//    TaImmosChoix.Next;
//    End;
//finally
// TaImmosChoix.BeforePost:=TaImmosChoixBeforePost;
// TaImmosChoix.EnableControls;
//end;//fin du try finally
//End;

procedure TDataModuleImmos.TaImmosChoixBeforePost(DataSet: TDataSet);
var
valide:TExceptLGR;
//AmortAnnee:TAmortImmo;
choix_Choix:Tchoix;
begin
  try
    valide:=DataModuleImmos.CtrlInfosChoixAmortissement(TaImmosChoix.Fields[32]);
    if not valide.Retour then
       abort;
   initialiserChoix(choix_Choix);
   if ((choixValeur<>taimmoschoixchoix.AsCurrency)and(taimmoschoixchoix.AsCurrency<>taimmoschoixMini.AsCurrency)and(taimmoschoixchoix.AsCurrency<>taimmoschoixMaxi.AsCurrency))then
     Remplir_ou_Modifier_ListeChoix(false,ListeModif,'Problème lors de la sauvegarde d''un choix après modification.');
     //recalculer le dérogatoire et l'Eco
     choix_Choix:=RemplirChoixAvantModif(taimmoschoix,ImmosEnCours);
     RecalculAmort_ApresModifDataset(dataset,choix_Choix,true);
//     Remplit_TInfosImmos(taimmoschoix,ImmosEnCours);
//     AmortAnnee:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,choix_Choix);
//     AmortAnnee.Choix:=taimmoschoixchoix.AsCurrency;
//  //   CalculEcoRepartitionSurImmos(AmortAnnee);
//     CalculDerogSurImmos(AmortAnnee);
//   if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
//      AmortAnnee.EcoRepartition:=AmortAnnee.Choix-AmortAnnee.Derog;{ isa  le  13/03/04 }
//     taimmoschoixEco.AsCurrency:=AmortAnnee.EcoRepartition;
//     TableGerePost(TaCalculAmort);
  //   TableGereCommit(TaCalculAmort);
  //   TableGereCommit(DMBalance.TaBalance);
  //  Filtrage_qryCumulImmosChoix_SurTag(choix.tag,taimmoschoixID.AsInteger);
  except
     TableGereRollBack(DataSet);
     TableGereRollBack(DMBalance.TaBalance);
     abort;
  end;//fin du try except

end;

procedure TDataModuleImmos.TaImmosChoixAfterEdit(DataSet: TDataSet);
begin
//récupérer choix avant modification particulière
choixValeur:=taimmoschoixchoix.ascurrency;
end;


//procedure TDataModuleImmos.SauvegardeChoixAvantModif(Liste:tstringlist);
//var
//id_Depart:integer;
//Begin
//id_Depart:=TaImmosChoixID.asinteger;
//TaImmosChoix.DisableControls;
//TaImmosChoix.First;
//  while not(TaImmosChoix.eof)do
//   Begin
//     Remplir_ou_Modifier_ListeChoix(false,Liste,'Problème lors de la sauvegarde des choix avant modification.');
//     TaImmosChoix.next;
//   End;
//TaImmosChoix.EnableControls;
//TaImmosChoix.Locate('id',id_Depart,[]);
//End;




procedure TDataModuleImmos.SuppressionImmo(TableCourante:TTable;ID:integer;Suppression:boolean;Messages:boolean);
var
messageTmp,reference:string;
AfterDelete,BeforeDelete:TDataSetNotifyEvent;
Begin
try//finally
try//except
AfterDelete:=TableCourante.afterdelete;
BeforeDelete:=TableCourante.BeforeDelete;
TableCourante.AfterDelete:=DataModuleImmos.taDetailImmoAfterDelete;
TableCourante.BeforeDelete:=DataModuleImmos.taDetailImmoBeforeDelete;
TableGereStartTransaction(TableCourante);
  if TableCourante.Locate('ID',id,[])then
    begin
    if suppression then
       begin//si on veut supprimer l'immo
          if not TableCourante.findfield('Achat_dans_Annee').AsBoolean then
            begin
            messageTmp:='Cette immobilisation ne fait pas partie de l''exercice en cours, Vous ne pouvez pas la supprimer dans cet écran.';
            abort;
            end
          else
            messageTmp:='Problème lors de la suppression d''une immobilisation';
         if Messages then
         begin
         if application.MessageBox(Pchar('Êtes-vous sûr de vouloir supprimer cette immobilisation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           TableGereDelete(TableCourante);
         end
         else
           TableGereDelete(TableCourante);
       end//fin si on veut supprimer l'immo
    else
       Begin//si on veut juste supprimer la cession
         suppression:=true;
         if messages then
         begin
           suppression:=application.MessageBox(Pchar('Êtes-vous sûr de vouloir supprimer la cession de cette immobilisation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes;
         end;
         if suppression then
           Begin
             if ((VerificationSiPieceDeDotation(reference))and(TableCourante.findfield('type_Amt').asstring<>'N'))then
               begin
               if application.MessageBox(Pchar('La pièce de dotation aux amortissements va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 DMPieces.SuppressionOD(reference)
               else
                 abort;
               end;
             messageTmp:='Problème lors de la suppression d''une cession';
             Choix_avantSupp:=RemplirChoixAvantModif(tablecourante,immosencours);
             TableCourante.edit;
             TableCourante.findfield('Cession_dans_Annee').AsBoolean:=false;
             TableCourante.findfield('Ecriture_Cession').Value:=0;
             TableCourante.findfield('Mt_Cession').AsCurrency:=0;
             TableCourante.findfield('Date_Cession').Value:=null;
             TableCourante.findfield('Rebut').asboolean:=false;
             TableGerePost(TableCourante);
           End;
       End;//fin /si on veut juste supprimer la cession
    end;
  ReactualiseQuery;
  tbPMV.close;
  tbPMV.open;
except
  TableGereRollBack(TableCourante);
  TableGereRollBack(DMBalance.TaBalance);
  if not empty(messageTmp) then
    showmessage(messageTmp);
  abort;
end;//fin du try except
finally
TableCourante.AfterDelete:=AfterDelete;
TableCourante.BeforeDelete:=BeforeDelete;
end;
End;


procedure TDataModuleImmos.taDetailImmoDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  TableGereRollBack(dataset);
  TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDataModuleImmos.taDetailImmoAfterDelete(DataSet: TDataSet);
begin
  try
  TableGereStartTransaction(TableImmos);
  if EcritureImmos<>0 then
    Begin
      FiltrageDataSet(TableImmos,'Ecriture_achat='+inttostr(EcritureImmos));

      if TableImmos.recordcount<>0 then
        begin
        if MessageDlg('Cette immobilisation a été liée à d''autres immobilisations à '
                      +#13+#10+'la suite d''une division.'+#13+#10+'Si vous la supprimez, les autres seront également supprimées.'
                      +#13+#10+'Voulez-vous continuer ? ', mtWarning, [mbYes,mbNo], 0) = mrYes then
              begin
                TableImmos.first;
                while not TableImmos.Eof do
                   begin
                     FiltrageDataSet(TaImmosEnCours,'CompteTerminee='''+TableImmos.findfield('Compte').asstring+''' and CodeTerminee='''+TableImmos.findfield('Code').asstring+''' and SousCodeTerminee='''+TableImmos.findfield('Sous_Code').asstring+'''');
                     InitialisationImmoEnCoursSurModif(TaImmosEnCours);
                     TableGereDelete(TableImmos);
                   end;
              end
        else //si abandon de la suppression (Rollback)
          abort;
        end;//s'il y a des immobilisation liées  
    end;
  TableGereCommit(DataSet);
  TableGereCommit(DMBalance.TaBalance);
  if @DataModuleImmos.daDetailImmo.OnStateChange<>nil then
    DataModuleImmos.daDetailImmo.OnStateChange(DataModuleImmos.TaDetailImmo);
  except
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
end;

procedure TDataModuleImmos.QuRecupImmosSurCptBeforeInsert(
  DataSet: TDataSet);
begin
abort;
end;




//function TDataModuleImmos.Amort_lin(DateDebutAmo,DatefinAnneeAmo,DateDebutExo,DateFinExo:TDateTime;
//	ValeurAcquis,Cumul, Taux:currency;Var nbJour:integer):Currency;
//var
//nbJourAnnee:integer;
//RapportArrondis:currency;
//begin
//Result := 0;
//nbJourAnnee:=nbdejours(DateDebutExo,DateFinExo);
//nbJour:=NbDeJours(DateDebutAmo,DatefinAnneeAmo);
//RapportArrondis:=int((nbJour / nbJourAnnee)*1000);//pour ramener le rapport nbjour/NbJourAnnée à 2 chiffres
////après la virgule seulement, ceci pour ce rapprocher le plus possible du rapport a*30/360
//RapportArrondis:=RapportArrondis/1000;
//   if nbJour = 0 then
//      exit;
//   if (valeurAcquis*taux)<(ValeurAcquis-cumul)then
//     Result := ValeurAcquis * Taux * RapportArrondis
//   else
//     Result := (ValeurAcquis-cumul)* RapportArrondis;
//end;

function TDataModuleImmos.Amort_degr(DateDebutAmo,DatefinAnneeAmo,finAmort:TDateTime; VNC,MiniAnnee:Currency; Taux:currency;Var nb_Mois:integer;AnneeRestantes,Restant:integer;Ceder:boolean):Currency;
var
reste:integer;
nbjour:integer;
base:integer;
//FinTmp:Tdate;
A,M,J : Word;
begin
result:=0;
reste:=(Restant div 12);
nbjour:=0;
DecodeDate(dateDebutAmo,A,M,J);
if ceder then
  Begin //si cédé, on calcul au jour près
    dateDebutAmo:=Encodedate(A,M,1);
    nbjour:=NbDeJours_SurBase360(DateDebutAmo,DatefinAnneeAmo,true);
    //if ((ceder)and(DateDebutAmo<>DatefinAnneeAmo)) then inc(nbjour);
  End
else
  Begin//sinon c'est au mois près
    nb_mois:=NbMois(DateDebutAmo,DatefinAnneeAmo);
    if ((((nb_mois=0) and (DateDebutAmo=DatefinAnneeAmo)))or(j>=30)) then
      inc(nb_mois);
  End;
if nb_mois>12 then
  nb_mois:=12;
   if ((nb_mois=0)and(nbjour=0))then
      exit;

if Not IsLeapYear(A)then
base:=365
else
base:=366;
if finAmort-DateDebutAmo<=base then
base:=NbDeJours_SurBase360(DateDebutAmo,finAmort,true)
else
base:=360;
//FinTmp:=finAmort;
//base:=RetourneBaseCalculSurAnneeExercice(DateDebutAmo,FinTmp);

  if ceder then
    begin
    if base=nbjour then
      Result := VNC * Taux
    else
      Begin
        if base=1 then result:=vnc
        else
        begin
            if base<>360 then
              Result := VNC * Taux * nbjour /(base-1)
            else
              Result := VNC * Taux * nbjour /(base);
        end;
      End;
    end
  else
    Result := VNC * Taux * nb_mois /12;


  if Result < 0 then
    Result := 0
  else
    begin//s'il reste de l'amortissement
      if reste<=0 then reste:=1;
      if result<=(VNC/reste)then
        begin
            if ((((not ceder)and(nb_mois=12)))or((reste=1)and(not ceder))) then result:=vnc/reste
            else
            if ceder then
                Begin
                  if base=nbjour then
                     result:=(vnc/reste)
                  else
                    Begin
                      if base=1 then result:=(vnc/reste)
                      else
                      begin
                          if base<>360 then
                            result:=(vnc/reste)*nbjour/(base-1)
                          else
                            result:=(vnc/reste)*nbjour/(base);
                      end;
                    End;                    
                End;
        end;
    end;//fin s'il reste de l'amortissement

  //ajoute le 13/10/2006
  result:=arrondi(result,2);
  
end;


function TDataModuleImmos.CtrlInfosChoixAmortissement(EditCourant:Tfield):TExceptLGR;
var
TitreTmp,messageTmp:string;
begin
try//except
result.NumErreur:=0;
result.retour:=true;
  if taimmoschoix.State in [dsedit]then
  begin//si en modification
     case EditCourant.Index of
     32:Begin //si Champ choix
         if empty(editcourant.asstring)then
           Begin
             editcourant.AsCurrency:=TaImmosChoixMini.AsCurrency;
             if ModificationImmos=false then
               ModificationImmos:=true;
           End
         else
           Begin//si pas vide
//           DataModuleImmos.Remplir_ou_Modifier_ListeChoix(true,DataModuleImmos.ListeModif,'Problème lors de la suppression d''un choix avant modification');
           Remplit_TInfosImmos(TaImmosChoix,ImmosEnCours);
           if ((editcourant.AsCurrency<>TaImmosChoixMini.AsCurrency)and(editcourant.AsCurrency<>TaImmosChoixMaxi.AsCurrency)) then
             Begin//si choix particulier, l'enregistrer dans la listes des particularités
             //si un choix particuliers était déjà inscrit dans la liste on le supprime de la liste

             if ((ImmosCedee(ImmosEnCours)) or(ImmosRebut(ImmosEnCours))) then
             begin
                if ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'))then
                begin
                    if Application.MessageBox(Pchar('Cette immobilisation a été cédée.'+#13+#10+
                    'Etes-vous sûr de vouloir la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                       abort;
                end
                else
                begin
                  showmessage('Cette immobilisation a été cédée, vous ne pouvez pas la modifier');
                  abort;
                end;
                if editcourant.ascurrency >(TaImmosChoixValeur_a_Amortir.ascurrency-(TaImmosChoixAmort_Eco.ascurrency+TaImmosChoixAmort_Derog.ascurrency))then
                  raise ExceptLGR.Create('Le choix ne peut exéder la valeur nette !',result.NumErreur,true,mtError,Result);
             end;
             if editcourant.ascurrency<=(TaImmosChoixValeur_a_Amortir.ascurrency-(TaImmosChoixAmort_Eco.ascurrency+TaImmosChoixAmort_Derog.ascurrency))then
               begin //si choix inférieur ou égal à valeur nette
               if editcourant.AsCurrency<TaImmosChoixMini.AsCurrency then
                 begin
                 messageTmp:='Cette pratique anormale ne peut être utilisée que pour corriger des différences de calculs entre logiciels.'+#10#13#10#13+
                 'L''amortissement ainsi différé sera reporté sur les exercices suivants.';
                 TitreTmp:='Amortissement inférieur au minimum';
                 if Application.MessageBox(PChar(messageTmp),PChar(TitreTmp),MB_YESNO + MB_DEFBUTTON2) = IDNo then
                    Begin
                      TaImmosChoix.cancel;
                      result.retour:=false;
                      result.NumErreur:=31000;
                    End
                 else
                    Begin
                      //DataModuleImmos.Remplir_ou_Modifier_ListeChoix(false,DataModuleImmos.ListeModif,'Problème lors de la l''enregistrement d''un choix particulier');
                      if ModificationImmos=false then
                        ModificationImmos:=true;
                    End;
                 end
               else
               if editcourant.AsCurrency>TaImmosChoixMaxi.AsCurrency then
                 begin
                 messageTmp:='La part d''amortissement excédant le maximum sera considérée comme un amortissement exceptionnel.';
                 TitreTmp:='Amortissement exceptionnel';
                 if Application.MessageBox(PChar(messageTmp),PChar(TitreTmp),MB_YESNO + MB_DEFBUTTON2) = IDNo then
                    Begin
                      TaImmosChoix.cancel;
                      result.retour:=false;
                      result.NumErreur:=30000;
                    End
                 else
                    Begin
                      //DataModuleImmos.Remplir_ou_Modifier_ListeChoix(false,DataModuleImmos.ListeModif,'Problème lors de la l''enregistrement d''un choix particulier');
                      if ModificationImmos=false then
                        ModificationImmos:=true;
                    End;
                 end
               else
                 Begin
                   //DataModuleImmos.Remplir_ou_Modifier_ListeChoix(false,DataModuleImmos.ListeModif,'Problème lors de la l''enregistrement d''un choix particulier');
                   if ModificationImmos=false then
                     ModificationImmos:=true;
                 End;
               end//fin si choix inférieur ou égal à valeur nette
             else
               begin//si choix supérieur à valeur nette
                  showmessage('Le choix ne peut exéder la valeur nette de l''immobilisation');
                  TaImmosChoix.cancel;
                  result.retour:=false;
                  result.NumErreur:=32000;
               end;//fin si choix supérieur à valeur nette
             End
           else
             Begin//si pas particulier, choix normal
               //
             End;//fin si pas particulier, choix normal
           End;//fin si pas vide
       end;//fin si Champ choix
     end;//fin du case tag
  end;//fin si en modification
except
  abort;
end;//fin du try except
end;


procedure TDataModuleImmos.initialiserChoix_Choix(ChoixLocal:TTypeModif;ListeParticularites:Tstringlist);
var
//amortissement:TAmortImmo;
rang:integer;
Choix_init:Tchoix;
Event:TNotifyEvent;
Filtre:TFiltre;
ok : boolean ;
Begin
   try//finally
   try//except
   //if not ((E.AccesCloture)and(not DataModuleImmos.verrouillage)) then abort;
   TaImmosChoix.BeforePost:=nil;
   TaImmosChoix.AfterPost:=nil;
   TaImmosChoix.DisableControls;
   Event:=daImmosChoix.OnStateChange;
   daImmosChoix.OnStateChange:=nil;
   Filtre.filtrer:=DataModuleImmos.TaImmosChoix.Filtered;
   initialiserChoix(Choix_init);
    case ChoixLocal of
      RxNonModifies:Begin //Restauration
        DataModuleImmos.TaImmosChoix.Filtered:=false;
        TableGereRollBack(DataModuleImmos.TaImmosChoix);
        DataModuleImmos.TaImmosChoix.Filtered:=Filtre.filtrer;
        End;//fin Restauration
      RxMini:Begin //Mini sauf particuliers
        TaImmosChoix.first;
          while not (TaImmosChoix.EOF) do
            Begin

              rang:=ListeParticularites.IndexOf(TaImmosChoixID.asstring);
              if (rang<>-1) then
                Begin
                  if taimmoschoix.state=dsbrowse then
                    taimmoschoix.edit;
                  taimmoschoixchoix.AsCurrency:=(ListeParticularites.Objects[rang] as TAmortissement_Obj).MontantChoix;
                End
              else
                Begin
                  if taimmoschoix.state=dsbrowse then
                    taimmoschoix.edit;
                  taimmoschoixchoix.AsCurrency:=TaImmosChoixMini.AsCurrency;
                End;

              { isa  le  14/09/04 }
              Choix_init:=RemplirChoixAvantModif(taimmoschoix,ImmosEnCours);
//              RecalculAmort_ApresModifDataset(taimmoschoix,Choix_init,true);
              { isa  le  24/01/05 }
              RecalculAmort_ApresModifDataset(taimmoschoix,Choix_init,false);
//            Remplit_TInfosImmos(taimmoschoix,ImmosEnCours);
//            amortissement:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix_init);
//            amortissement.Choix:=TaImmosChoix.findfield('Choix').AsCurrency;
////            CalculEcoRepartitionSurImmos(amortissement);
//            CalculDerogSurImmos(amortissement);
//   if amortissement.Choix-amortissement.Derog<>amortissement.EcoRepartition then
//      amortissement.EcoRepartition:=amortissement.Choix-amortissement.Derog; { isa  le  13/03/04 }
//
//            TaImmosChoixEco.AsCurrency:=amortissement.EcoRepartition;

            TableGerePost(taimmoschoix);
            TaImmosChoix.next;
            End;
        End;//fin mini sauf particuliers
      RxMaxi:Begin //Maxi sauf particuliers
        TaImmosChoix.first;
          while not (TaImmosChoix.EOF) do
            Begin
              rang:=ListeParticularites.IndexOf(TaImmosChoixID.asstring);
              if (rang<>-1) then
                Begin
                  if taimmoschoix.state=dsbrowse then
                    taimmoschoix.edit;
                  taimmoschoixchoix.AsCurrency:=(ListeParticularites.Objects[rang] as TAmortissement_Obj).MontantChoix;
                End
              else
                Begin
                  if taimmoschoix.state=dsbrowse then
                    taimmoschoix.edit;
                  taimmoschoixchoix.AsCurrency:=TaImmosChoixMaxi.AsCurrency;
                End;

              { isa  le  14/09/04 }
              Choix_init:=RemplirChoixAvantModif(taimmoschoix,ImmosEnCours);
//              RecalculAmort_ApresModifDataset(taimmoschoix,Choix_init,true);
              { isa  le  24/01/05 }
              RecalculAmort_ApresModifDataset(taimmoschoix,Choix_init,false);
//            Remplit_TInfosImmos(taimmoschoix,ImmosEnCours);
//            amortissement:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix_init);
//            amortissement.Choix:=TaImmosChoix.findfield('Choix').AsCurrency;
////            CalculEcoRepartitionSurImmos(amortissement);
//            CalculDerogSurImmos(amortissement);
//   if amortissement.Choix-amortissement.Derog<>amortissement.EcoRepartition then
//      amortissement.EcoRepartition:=amortissement.Choix-amortissement.Derog; { isa  le  13/03/04 }
//
//            TaImmosChoixEco.AsCurrency:=amortissement.EcoRepartition;

            TableGerePost(taimmoschoix);
            TaImmosChoix.next;
            End;
        End;//fin Maxi sauf particuliers
      RxInitMini:Begin//Tous au mini
        TableGereStartTransaction(DataModuleImmos.TaImmosChoix);
        TaImmosChoix.first;
          while not (TaImmosChoix.EOF) do
            Begin
              if taimmoschoix.state=dsbrowse then
                taimmoschoix.edit;
              taimmoschoixchoix.AsCurrency:=TaImmosChoixMini.AsCurrency;

              { isa  le  14/09/04 }
              Choix_init:=RemplirChoixAvantModif(taimmoschoix,ImmosEnCours);
//              RecalculAmort_ApresModifDataset(taimmoschoix,Choix_init,true);
              { isa  le  24/01/05 }
              RecalculAmort_ApresModifDataset(taimmoschoix,Choix_init,false);
//            Remplit_TInfosImmos(taimmoschoix,ImmosEnCours);
//            amortissement:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix_init);
//            amortissement.Choix:=TaImmosChoix.findfield('Choix').AsCurrency;
////            CalculEcoRepartitionSurImmos(amortissement);
//            CalculDerogSurImmos(amortissement);
//   if amortissement.Choix-amortissement.Derog<>amortissement.EcoRepartition then
//      amortissement.EcoRepartition:=amortissement.Choix-amortissement.Derog; { isa  le  13/03/04 }
//
//            TaImmosChoixEco.AsCurrency:=amortissement.EcoRepartition;

            TableGerePost(taimmoschoix);
            TaImmosChoix.next;
            End;
        End;//fin Tous au mini
      RxInitMaxi:Begin
        TableGereStartTransaction(DataModuleImmos.TaImmosChoix);
        TaImmosChoix.first;
          while not (TaImmosChoix.EOF) do
            Begin
              if taimmoschoix.state=dsbrowse then
                taimmoschoix.edit;
              taimmoschoixchoix.AsCurrency:=TaImmosChoixMaxi.AsCurrency;

              { isa  le  14/09/04 }
              Choix_init:=RemplirChoixAvantModif(taimmoschoix,ImmosEnCours);
//              RecalculAmort_ApresModifDataset(taimmoschoix,Choix_init,true);
              { isa  le  24/01/05 }
              RecalculAmort_ApresModifDataset(taimmoschoix,Choix_init,false);
//            Remplit_TInfosImmos(taimmoschoix,ImmosEnCours);
//            amortissement:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix_init);
//            amortissement.Choix:=TaImmosChoix.findfield('Choix').AsCurrency;
////            CalculEcoRepartitionSurImmos(amortissement);
//            amortissement.derog:=0;
//            CalculDerogSurImmos(amortissement);
//   if amortissement.Choix-amortissement.Derog<>amortissement.EcoRepartition then
//      amortissement.EcoRepartition:=amortissement.Choix-amortissement.Derog; { isa  le  13/03/04 }
//
//            TaImmosChoixEco.AsCurrency:=amortissement.EcoRepartition;

            TableGerePost(taimmoschoix);
            TaImmosChoix.next;
            End;
        End;
    end;//fin du case choix
    TaImmosChoix.first;
    TaImmosChoix.EnableControls;
     if ChoixLocal<>RxNonModifies then
       ModificationImmos:=true
     else
       ModificationImmos:=false;
    except
      if @TimerDisabled<>nil then
        TimerDisabled(nil);
      ModificationImmos:=false;
      abort;
    end;
   finally
   TaImmosChoix.BeforePost:=TaImmosChoixBeforePost;
   daImmosChoix.OnStateChange:=Event;
   DaImmosChoixStateChange(TaImmosChoix);
   TaImmosChoix.AfterPost:=TaImmosChoixAfterPost;
   TaImmosChoix.EnableControls;
   end;//fin du try finally
End;



//procedure TDataModuleImmos.SauvegardeParticularitesAvantModif(ListeModif:Tstringlist);
//var
//id_Depart:integer;
//Begin
//id_Depart:=TaImmosChoixID.asinteger;
//TaImmosChoix.disableControls;
//TaImmosChoix.First;
//  while not(TaImmosChoix.eof)do
//   Begin
//    if ((taimmoschoixchoix.AsCurrency<>Taimmoschoixmini.AsCurrency)and(taimmoschoixchoix.AsCurrency<>Taimmoschoixmaxi.AsCurrency))then
//       Remplir_ou_Modifier_ListeChoix(false,ListeModif,'Problème lors de la sauvegarde des choix avant modification.');
//    TaImmosChoix.next;
//   End;
//TaImmosChoix.EnableControls;
//TaImmosChoix.Locate('id',id_Depart,[]);
//End;


Procedure TDataModuleImmos.ReactualiseQuery;
Begin
QuCptUtiliseImmos.DisableControls;
QuCptUtiliseImmos.close;
QuCptUtiliseImmos.ParamByName('DateExoEnCours').AsDate:=e.DatExoDebut;
QuCptUtiliseImmos.Open;
QuCptUtiliseImmos.EnableControls;
QuRecupImmosSurCpt.close;
QuRecupImmosSurCpt.ParamByName('DateExoEnCours').AsDate:=e.DatExoDebut;
QuRecupImmosSurCpt.open;
//daDetailImmo.OnStateChange(taDetailImmo); //à verifier si je dois réellement l'enlever, pose problème quand
//on supprime une pièce qui est liée à une ou plusieurs immos
End;


function TDataModuleImmos.CalculerAmortAnneeSurImmo(Immoscourante:TInfosImmos;DebutExo,FinExo:Tdatetime;ChoixAvantModif:Tchoix;ConserverChoix:boolean):TAmortImmo;
var
MiniCumul,
Report:currency;
Nb_Jour,Nb_Mois,AnneeRestantes,reste:integer;
DatefinAmo,DatefinAnneeAmo2,DateDebutAnneeAmo,DatefinAnneeAmo,DebutExoCalculDeg:tdatetime;
TauxLin, TauxDeg:Extended;
DerniereAnnee,CessionDsExoFinAmort:boolean;
A1,M1,J1: Word;
mess:TMessageLGR;
base:integer;
nbjour:integer;
Begin
try//finally
try//except
DerniereAnnee:=false;
initialiserAmortissement(result);
CessionDsExoFinAmort:=false;
if ((Immoscourante.id>=0)and(((Immoscourante.date_cession>=DebutExo)or(Immoscourante.date_cession=0)))and(Immoscourante.Type_Amt<>'N')) then
  Begin
     MiniCumul:=0;
     Nb_Jour:=0;
     Nb_Mois:=0;
     //report total
     report:=Immoscourante.Amort_Derog+Immoscourante.Amort_Eco;
     DateDebutAnneeAmo := Immoscourante.date_mise_en_service;
     //pour le calcul du dégressif, on calcul au mois près d'où j1=1 pour commencer le cacul
     //au début du mois de mise en service
     DecodeDate(Immoscourante.date_mise_en_service,A1,M1,J1);
     j1:=1;
     DebutExoCalculDeg:=EncodeDate(A1,M1,J1);
     ///
     if Immoscourante.date_cession<>0  then
       begin //si l'immo a été cédée
         if moissuivant(Immoscourante.date_mise_en_service,Immoscourante.Duree_Amt-1).Date_>Immoscourante.date_cession then
         DatefinAmo:=Immoscourante.date_cession
         else
         DatefinAmo:=moissuivant(Immoscourante.date_mise_en_service,Immoscourante.Duree_Amt-1).Date_;
       //si la date de cession intervient avant la fin de l'amortissement, alors
       //on considère que l'on n'est pas sur la dernière année d'amortissement
         DerniereAnnee:=(Immoscourante.date_cession>=moissuivant(Immoscourante.date_mise_en_service,Immoscourante.Duree_Amt-1).Date_-1);
       //  CessionDsExoFinAmort:=((Immoscourante.date_cession>=e.DatExoDebut)and(DateDsIntervale(e.DatExoDebut,moissuivant(Immoscourante.date_mise_en_service,Immoscourante.Duree_Amt-1).Date_,e.DatExofin,mess)));
         CessionDsExoFinAmort:=((Immoscourante.date_cession>=DebutExo)and(DateDsIntervale(DebutExo,moissuivant(Immoscourante.date_mise_en_service,Immoscourante.Duree_Amt-1).Date_-1,FinExo,mess)));
       end
     else
       begin
         DatefinAmo:=moissuivant(Immoscourante.date_mise_en_service,Immoscourante.Duree_Amt-1).Date_;
         //si date fin amort est atteinte dans l'exo en cours, alors on est sur la dernière année
         DerniereAnnee:=DatefinAmo<=finexo;
       end;
     DatefinAnneeAmo:=datefinamo;
     DatefinAnneeAmo2:=moissuivant(Immoscourante.date_mise_en_service,Immoscourante.Duree_Amt-1).Date_;
     if Immoscourante.date_mise_en_service<debutexo then
       DateDebutAnneeAmo:=debutexo//si date de mise en service est antérieur à l'exo en cours
       //alors, on commence le calcul le 1er jour de l'exo en cours
     else
       if DateDsIntervale(debutexo,Immoscourante.date_mise_en_service,FinExo,mess) then
         //sinon, si regarde si mise en service dans l'exo, si oui, alors on commence le
         //calcul le jour de la mise en service
         DateDebutAnneeAmo:=Immoscourante.date_mise_en_service
       else
         abort; //sinon, on ne calcule pas, tout est à 0
     if datefinamo>finexo then
       DatefinAnneeAmo:=finexo;
       
     Calcule_taux(Immoscourante.Duree_Amt, Immoscourante.date_mise_en_service,Immoscourante.Date_Achat, TauxLin, TauxDeg,Immoscourante.TauxAmo);

//     if Immoscourante.date_cession<>0 then
//       begin
//           DecodeDate(DateDebutAnneeAmo,A1,M1,J1);
//           DateDebutAnneeAmo:=encodedate(A1,M1,1);
//           result.MiniAnnee:=Amort_lin_SurBase360(DateDebutAnneeAmo,DatefinAnneeAmo,Immoscourante.date_cession,Immoscourante.Valeur_a_Amortir,Immoscourante.Amort_Eco,TauxLin,'D',Nb_jour,((Immoscourante.date_cession<>0)and(not DerniereAnnee)));
//         end
//     else
       result.MiniAnnee:=Amort_lin_SurBase360(DateDebutAnneeAmo,DatefinAnneeAmo,Immoscourante.date_cession,Immoscourante.Valeur_a_Amortir,Immoscourante.Amort_Eco,TauxLin,'L',Nb_jour,((Immoscourante.date_cession<>0)and(not DerniereAnnee)),DerniereAnnee,false);
     reste:=Immoscourante.Duree_Amt mod 12;
     if reste>0 then
       AnneeRestantes:=(Immoscourante.Duree_Amt div 12)+1
     else
       AnneeRestantes:=Immoscourante.Duree_Amt div 12;
     reste:=Immoscourante.Duree_Amt;
     if Immoscourante.date_mise_en_service<>DateDebutAnneeAmo then
       reste:=reste-NbMois(Immoscourante.date_mise_en_service,DateDebutAnneeAmo);
     AnneeRestantes:=AnneeRestantes-(NbAnne(Immoscourante.date_mise_en_service,DateDebutAnneeAmo)-1);
     if (Immoscourante.Type_Amt='D') then
       MiniCumul:=Amort_lin_SurBase360(DebutExoCalculDeg,DatefinAnneeAmo,Immoscourante.date_cession,Immoscourante.Valeur_a_Amortir,Immoscourante.Amort_Eco,TauxLin,'D',Nb_jour,false,DerniereAnnee,true)
     else
       MiniCumul:=Amort_lin_SurBase360(Immoscourante.date_mise_en_service,DatefinAnneeAmo,Immoscourante.date_cession,Immoscourante.Valeur_a_Amortir,Immoscourante.Amort_Eco,TauxLin,'L',Nb_jour,false,DerniereAnnee,true);
     if ((Immoscourante.Type_Amt = 'L')or(result.MiniAnnee=0)) then
        begin
           if result.MiniAnnee >((Immoscourante.Valeur_a_Amortir-(Immoscourante.amort_Eco+Immoscourante.Amort_Derog))) then
             result.MiniAnnee := (Immoscourante.Valeur_a_Amortir-(Immoscourante.amort_Eco+Immoscourante.Amort_Derog))
           else
             result.Mini :=result.MiniAnnee;
        end
     else
        result.Mini :=CalculMini(MiniCumul,Report,Immoscourante.Valeur_a_Amortir-(Immoscourante.amort_Eco+Immoscourante.Amort_Derog));
     if Immoscourante.Type_Amt = 'D' then
         result.Maxi := DataModuleImmos.Amort_degr(DateDebutAnneeAmo,DatefinAnneeAmo,DatefinAnneeAmo2,Immoscourante.Valeur_a_Amortir-(Immoscourante.amort_Eco+Immoscourante.Amort_Derog),result.MiniAnnee, TauxDeg,Nb_Mois,AnneeRestantes,reste,Immoscourante.date_cession<>0)
         //result.Maxi := DataModuleImmos.Amort_degr(DateDebutAnneeAmo,DatefinAnneeAmo,DatefinAnneeAmo2,Immoscourante.Valeur_a_Amortir-(Immoscourante.amort_Eco+Immoscourante.Amort_Derog),result.MiniAnnee, TauxDeg,Nb_Mois,AnneeRestantes,reste,((Immoscourante.date_cession<>0)and(not DerniereAnnee)))
      else result.Maxi := result.Mini;
     result.Mini:=ArrondiCentieme(result.Mini);
     result.Maxi:=ArrondiCentieme(result.Maxi);
     result.MiniAnnee:=ArrondiCentieme(result.MiniAnnee);
     //result.ecotherique:=MiniCumul-datasettmp.FindField('Amort_Eco').Ascurrency;
//     result.EcoObligatoire:=result.MiniAnnee;

     if Immoscourante.Type_Amt<>'N'then
     begin
     //calcul Eco oblig du mois
     if Immoscourante.Type_Amt = 'D' then
     begin
        if MiniCumul-Immoscourante.Amort_Eco>=0 then
          result.EcoObligatoire:=MiniCumul-Immoscourante.Amort_Eco;
     end;

     if not derniereAnnee then
       begin
       if result.EcoObligatoire>result.MiniAnnee then
         result.EcoObligatoire:=result.MiniAnnee;
       end
     else
       Begin
         result.EcoObligatoire:=ArrondiCentieme(Immoscourante.Valeur_a_Amortir-Immoscourante.amort_Eco);
       End;
     //fin calcul Eco oblig du mois

     //calcul mini
     if not DerniereAnnee then
       begin
       if result.Mini>result.MiniAnnee then
         result.Mini:=result.MiniAnnee-Immoscourante.Amort_Derog;
       if ((Minicumul>Immoscourante.Amort_Eco)and(Immoscourante.Amort_Derog>0))then
          result.Mini:=result.EcoObligatoire-Immoscourante.Amort_Derog;
       end
     else
       begin
         result.Mini:=(Immoscourante.Valeur_a_Amortir-(Immoscourante.amort_Eco+Immoscourante.Amort_Derog));
         if Immoscourante.Type_Amt <> 'D' then
           result.Maxi:=result.Mini;
       end;
     if result.Mini<0 then result.Mini:=0;
     //fin calcul mini
//    if ((Immoscourante.date_cession<>0)and(not DerniereAnnee)and(CessionDsExoFinAmort)) then
    if ((Immoscourante.date_cession<>0)and(CessionDsExoFinAmort)) then
      Begin
          base:=NbDeJours_SurBase360(DateDebutAnneeAmo,DatefinAnneeAmo2,true);
          result.Mini:=result.Maxi;
          if base<>360 then
              base:=base-1;
          nbjour:=NbDeJours_SurBase360(DateDebutAnneeAmo,Immoscourante.date_cession,true);
          if nbjour>base then
            nbjour:=base;
           if base=0 then //si période d'amortissement dépassée, mais qu'il reste à amortir on prend tout
             result.EcoObligatoire:=  result.Mini // on récupère ce qu'il reste à amortir
           else
             result.EcoObligatoire:=  result.Mini +(Immoscourante.Amort_Derog*(nbjour/base))
      End;

      //remplissage par défaut
//      result.choix:=result.Mini;
      //restauration du choix suivant l'ancien choix s'il existait
//     if ChoixAvantModif.ChoixItem<>-1 then
//       Begin
         case ChoixAvantModif.ChoixItem of
           0,-1:result.choix:=result.Mini;
           1:result.choix:=result.Maxi;
           2:Begin
               if ((ConserverChoix)or(((ChoixAvantModif.choixDefaut>=result.Mini)and(ChoixAvantModif.choixDefaut<=result.Maxi)) ))then
                 result.choix:=ChoixAvantModif.choixDefaut
               else
                 result.choix:=result.Mini;
             End;
         end;//fin du case ChoixAvantModif.ChoixItem
//       End;

//      { isa  le  12/02/04 } //provisoire voir avec denis car pas ok !!!!!!
//      if Immoscourante.Type_Amt <> 'D' then  result.MiniAnnee:=result.Mini;
//      { isa  le  12/02/04 }
      result.compte:=Immoscourante.Compte;
      result.VNC:=Immoscourante.Valeur_a_Amortir-(Immoscourante.amort_Eco+Immoscourante.Amort_Derog);
      result.Report_Derog:=Immoscourante.Amort_Derog;
      result.Report_Eco:=Immoscourante.Amort_Eco;
      result.Gerer_Derog:=e.Derogatoire;
      CalculEcoRepartitionSurImmos(result,((Immoscourante.date_cession<>0)and(CessionDsExoFinAmort)));
     result.VNC:=ArrondiCentieme(result.VNC-result.choix);
     //pour le calcul, il faut avoir initialisé correctement le result
     //avec les valeurs de l'enregistrement courant, ainsi que des paramètres comme la gestion du dérogatoire
     if Immoscourante.Type_Amt = 'D' then
       CalculDerogSurImmos(result);

    end;//si amortissable
     //debut:=false;
  End;
except
  //
end;
finally
//  DatasetTmp.Free;
end;
End;



procedure TDataModuleImmos.Calcule_taux(DureeAmo:integer; DateDebutAmo,DateAcquisition:TDateTime; var TauxLin, TauxDeg : Extended;TauxDefaut:single);
var
Coef:single;
begin
   if DureeAmo>0 then
     begin
      TauxLin := 12 / DureeAmo;
      if TauxDefaut=0 then
        begin
          coef:=DataModuleImmos.RechercherCoefficient_surPeriodeValidite(DateAcquisition,DureeAmo);
          if Coef > 0 then TauxDeg := (12 * Coef) / DureeAmo
          else TauxDeg := 0;
        end
      else
        tauxDeg:=TauxDefaut;
     end;
end;


function TDataModuleImmos.CalculMini(CumulMini,CumulAmort,VNC:currency):currency;
Begin
result:=0;
  if CumulMini-CumulAmort>0 then
    result:=CumulMini-CumulAmort;
  if result>vnc then result:=VNC;
result:=Arrondi(result,2);  
End;

procedure TDataModuleImmos.taDetailImmoBeforePost(DataSet: TDataSet);
var
coef:real;
//AmortAnnee:Tamortimmo;
Choix_Detail:Tchoix;
i,NbEnreg:integer;
reference_:string;
filtrer:boolean;
rang:integer;
begin
try//finally
////
DataModuleImmos.QuCptUtiliseImmos.DisableControls;
//DataModuleImmos.ID_DernierCree:=-1;{ isa  le  05/04/04 }
  try
  reference_:='';
  if DataModuleImmos.taDetailImmo.State in [dsinsert,dsedit]then
  begin //si table en insertion ou modification
  TableGereStartTransaction(DataModuleImmos.taDetailImmo);
    with DataModuleImmos.taDetailImmo do
      begin
//        if DataModuleImmos.taDetailImmoType_Amt.AsString<>'N' then
        if ((DataModuleImmos.taDetailImmoType_Amt.AsString<>'N')or(((DataModuleImmos.infosDetailAcquis.Type_Amt<>'N'))and(DataModuleImmos.infosDetailAcquis.Type_Amt<>''))) then
        begin//si amortissable
           if VerificationSiPieceDeDotation(reference_)then
              if Application.MessageBox(PChar('Si vous enregister cette immobilisation, la pièce de dotation sera supprimée, voulez-vous continuer ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON1) = IDYES then
                begin
                if DMImmo_Clo.SuppressionPieceDeDotationAmortissement(reference_,false)then
                  DataModuleImmos.suppressionPieceDotation:=true;
                end
              else
                abort;
        end;//fin si amortissable
        Initialise_TinfosDetailAcquis(DataModuleImmos.infosDetailAcquis);
        //récupère les infos déjà inscrite dans table
        DataModuleImmos.RempliInfosDetailAcquis(DataModuleImmos.infosDetailAcquis);
        if taDetailImmo.State = dsinsert then
           begin
             infosDetailAcquis.Ecriture_Achat:=qryListeAcquis.findfield('id').asinteger;
             taDetailImmoid.asinteger:=MaxId_Query(taDetailImmo,'ID');
             infosDetailAcquis.Achat_dans_Annee:=qryListeAcquis.findfield('id').asinteger<>0;
             infosDetailAcquis.EnCours:=copy(qryListeAcquisCompte.AsString,1,2)='23';
             infosDetailAcquis.Deduc_Invest:=taDetailImmoMt_Deduc_Invest.AsCurrency<>0;
             infosDetailAcquis.CompteTerminee:=taDetailImmoCompte.AsString;
             infosDetailAcquis.codeterminee:=taDetailImmoCode.AsString;
             infosDetailAcquis.SousCodeTerminee:=taDetailImmoSous_Code.AsString;
             infosDetailAcquis.Date_Achat:=taDetailImmoDate_Achat.AsDateTime;
             if taDetailImmoDuree_Amt.AsInteger<>0 then
                Begin
                  coef:=DataModuleImmos.RechercherCoefficient_surPeriodeValidite(tadetailimmo.findfield('Date_Achat').AsDateTime,taDetailImmoDuree_Amt.AsInteger);
                  infosDetailAcquis.TauxAmo:= (Round(10000 * 12 * Coef / taDetailImmoDuree_Amt.AsInteger) / 10000);
                  //infosDetailAcquis.TauxAmo:=infosDetailAcquis.TauxAmo*100;
                End;
           end;
        initialiserChoix(Choix_Detail);
        //initialiserAmortissement(AmortAnnee);
        case DataModuleImmos.QuiAppel of
           F_division:RecalculAmort_ApresModifDataset(taDetailImmo,Choix_Division,true);
            //suppression d'une cession ou d'un rebut, on met le maxi en choix
           F_VisuImmo:RecalculAmort_ApresModifDataset(taDetailImmo,Choix_avantSupp,true);
           F_Rebut:RecalculAmort_ApresModifDataset(taDetailImmo,Choix_AvantRebut,true);
           F_Cession:RecalculAmort_ApresModifDataset(taDetailImmo,Choix_AvantCession,true);
          // F_ChoixAmortissement:RecalculAmort_ApresModifDataset(taDetailImmo,choix_Choix,true);
           F_DetailAcquis:RecalculAmort_ApresModifDataset(taDetailImmo,Choix,true);
        end;//fin du case fenetre appelante


          taDetailImmoEcriture_Achat.AsCurrency:=infosDetailAcquis.Ecriture_Achat;
          taDetailImmoEnCours.AsBoolean:=infosDetailAcquis.EnCours;
          taDetailImmoDeduc_Invest.AsBoolean:=infosDetailAcquis.Deduc_Invest;
          taDetailImmoReprise_Deduc_Invest.AsCurrency:=infosDetailAcquis.Reprise_deduc_invest;
          taDetailImmoAmort_Eco.AsCurrency:=infosDetailAcquis.Amort_Eco;
          taDetailImmoAmort_Derog.AsCurrency:=infosDetailAcquis.Amort_Derog;
          taDetailImmoMt_Cession.AsCurrency:=infosDetailAcquis.Mt_Cession;
          taDetailImmoRebut.AsBoolean:=infosDetailAcquis.Rebut;
          taDetailImmoAchat_dans_Annee.AsBoolean:=infosDetailAcquis.Achat_dans_Annee;
          taDetailImmoCession_dans_Annee.AsBoolean:=infosDetailAcquis.Cession_dans_Annee;
          taDetailImmoTauxAmo.AsCurrency:=infosDetailAcquis.TauxAmo;
          taDetailImmoLibelle.AsString:=infosDetailAcquis.Libelle;

//        filtrer:=DataModuleImmos.TaImmosEnCours.filtered;
//        DataModuleImmos.TaImmosEnCours.filtered:=false;
         if TypePresentation in [C_ACQUISITION_Terminee,C_DESCRIPTION_terminee] then
        begin //si tag in [C_ACQUISITION_Terminee,C_DESCRIPTION_terminee]
              DataModuleImmos.TaImmosEnCours.First;

          while (not DataModuleImmos.TaImmosEnCours.eof) do
            Begin
            //corrigé le 13/05/2011
             rang:=DataModuleImmos.TaImmosEnCoursID.asinteger;  //je récupère le rang en cours et après enregistrement, si la ligne a disparut du fait du filtre
             if TaImmosEnCoursTerminee.AsBoolean then    //alors je ne fais pas le next, sinon je le fais (sinon boucle sans fin)
             begin
               UpdateImmosSurValeurs(TaImmosEnCours,['CompteTerminee','CodeTerminee','SousCodeTerminee','Cession_dans_annee','Date_Cession'],
               [taDetailImmoCompte.asstring,taDetailImmoCode.asstring,taDetailImmoSous_Code.asstring,true,taDetailImmoDate_Achat.asdatetime],dsEdit,DataModuleImmos.TaImmosEnCoursID.asinteger);
              if(rang=DataModuleImmos.TaImmosEnCoursID.asinteger)then TaImmosEnCours.Next;
             end
             else
               begin
               if ((not empty(TaImmosEnCoursCodeTerminee.AsString))or (not empty(TaImmosEnCoursCompteTerminee.AsString)))then
                  UpdateImmosSurValeurs(TaImmosEnCours,['CompteTerminee','CodeTerminee','SousCodeTerminee','Cession_dans_annee','Date_Cession'],
                  ['','','',false,0],dsEdit,TaImmosEnCoursID.asinteger);
                 if(rang=DataModuleImmos.TaImmosEnCoursID.asinteger)then TaImmosEnCours.Next;
               end;
            End; //fin du while
        InitialisationImmoEnCoursSurModif;
//        DataModuleImmos.TaImmosEnCours.filtered:=filtrer;
        end;//fin si tag in [C_ACQUISITION_Terminee,C_DESCRIPTION_terminee]
      end;//fin du with
  end;//fin si table en insertion ou modification
  except
    if not (taDetailImmo.state = dsbrowse) then
       taDetailImmo.Cancel;
     TableGereRollBack(taDetailImmo);
  end;//fin du try except
/////
finally
  DataModuleImmos.QuCptUtiliseImmos.EnableControls;
end;
end;


procedure TDataModuleImmos.Filtrage_qryCumulImmosChoix_SurTag(TagTmp,ID:integer);
Begin
with qryCumulImmosChoix do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('Sum(Valeur_a_amortir) AS V_Acq,');
      SQL.Add('Sum(choix+(amort_eco+amort_derog))AS A_Cumul,');
      SQL.Add('Sum(Valeur_a_Amortir-(choix+(amort_eco+amort_derog)))AS VNC,');
      SQL.Add('sum(Mini)as TotalMini,');
      SQL.Add('sum(Maxi)as TotalMaxi,');
      SQL.Add('sum(Choix)as TotalChoix');
      SQL.Add('FROM  Immos.DB');
        case TagTmp of
         0:Begin //C_ImmoCourante
            SQL.Add('where ID =:ID');
            ParamByName('ID').asinteger:=ID;
           End;
         1:Begin //C_SelectionSurToutes
             //
           End;
         2:Begin //C_SelectionSurImmo
             SQL.Add('where Compte=:Cpt');
             ParamByName('Cpt').asstring:='2%'
           End;         
         3:Begin //C_SelectionSurSub
             SQL.Add('where Compte=:Cpt');
             ParamByName('Cpt').asstring:='131%'
           End;
         end;//fin du case
      qryCumulImmosChoix.Prepare;
      qryCumulImmosChoix.open;
      qryCumulImmosChoix.recordcount;
   end;//fin du with
End;

procedure TDataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag(Dataset:TQuery;TagTmp:integer;Partiel:boolean;Rang:integer;SQLText:string);
Begin
with Dataset do
   begin
      Close;
      if partiel then
      Begin
      SQL.Strings[Rang] := SQLText;
      End
      else
      Begin
      SQL.Clear;
         case TagTmp of
         0:Begin //C_ImmoCourante
            //
           End;
           
         1:Begin //C_SelectionSurToutes
             SQL.Add(' select ( Compte +'' ''+ Code +'' ''+ Sous_Code +'' ''+ Libelle) as Immobilisation '+ChampPublies+' from immos');
           End;
         2:Begin //C_SelectionSurImmo
             SQL.Add(' select (Compte +'' ''+ Code +'' ''+ Sous_Code +'' ''+ Libelle) as Immobilisation '+ChampPublies+' from immos');
//             SQL.Add('select ''Compte''+''  ''+'' Code ''+''  ''+'' Sous_Code ''+''  ''+'' Libelle'' as Immobilisation '+ChampPublies+' from immos');
             SQL.Add(' where Compte like(:Cpt)');
             ParamByName('Cpt').asstring:='2%'
           End;
         3:Begin //C_SelectionSurSub
             SQL.Add(' select (Compte +'' ''+ Code +'' ''+ Sous_Code +'' ''+ Libelle) as Immobilisation '+ChampPublies+' from immos');
//             SQL.Add('select ''Compte''+''  ''+'' Code ''+''  ''+'' Sous_Code ''+''  ''+'' Libelle'' as Immobilisation '+ChampPublies+' from immos');
             SQL.Add(' where Compte like(:Cpt)');
             ParamByName('Cpt').asstring:='131%'
           End;
         end;//fin du case
         SQL.Add(' order by compte, code, sous_code');
      End;
      Prepare;
      open;
      Dataset.recordcount;
   end;//fin du with
End;

function TDataModuleImmos.VerifSiPieceDecriteDansLesImmos(ID_Piece:integer):TErreurSaisie;
Var
ListeImmosASupprimer:Tstringlist;
begin
try
ListeImmosASupprimer:=TStringList.Create;
Result:=VerifSiPieceDecriteDansLesImmos(ID_Piece,ListeImmosASupprimer);
finally
Initialise_TStringlist(ListeImmosASupprimer);
end;//fin finally
end;


function TDataModuleImmos.VerifSiPieceDecriteDansLesImmos(ID_Piece:integer;var ListeImmosASupprimer:Tstringlist):TErreurSaisie;
begin
result.retour:=true;
result.CodeErreur:=0;
 QuRecupImmoSurSuppressionPieceComptable.close;
 QuRecupImmoSurSuppressionPieceComptable.sql.Clear;
QuRecupImmoSurSuppressionPieceComptable.SQL.Add('SELECT I.id as ID_Immo,Type_Amt,Choix,(Valeur_a_amortir-amort_eco-amort_derog)as valeurNette');
QuRecupImmoSurSuppressionPieceComptable.SQL.Add('From Piece.db P left join Ecriture.db E on P.ID = E.ID_Piece');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('JOIN Immos.db I ON E.ID = I.Ecriture_Achat');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('where P.ID=:IDPiece');
 QuRecupImmoSurSuppressionPieceComptable.ParamByName('IDPiece').asinteger:=ID_Piece;
 QuRecupImmoSurSuppressionPieceComptable.Open;
 if QuRecupImmoSurSuppressionPieceComptable.recordcount<>0 then
   Begin
     QuRecupImmoSurSuppressionPieceComptable.first;
     result.retour:=false;
     if ListeImmosASupprimer=nil then
       ListeImmosASupprimer:=TStringList.Create;
     while not (QuRecupImmoSurSuppressionPieceComptable.EOF) do
       begin//debut du while
          if ((QuRecupImmoSurSuppressionPieceComptablevaleurnette.Ascurrency>0)and(QuRecupImmoSurSuppressionPieceComptableType_Amt.AsString<>'N')) then
            Begin//si encore amortissable
              if result.CodeErreur=0 then
                result.CodeErreur:=1;
            End;//fin si encore amortissable
          if ListeImmosASupprimer.IndexOf(QuRecupImmoSurSuppressionPieceComptableID_Immo.Asstring)=-1 then
            ListeImmosASupprimer.Add(QuRecupImmoSurSuppressionPieceComptableID_Immo.Asstring);
       QuRecupImmoSurSuppressionPieceComptable.next;
       end;//fin du while
   End;
end;

function TDataModuleImmos.VerifSiEcritureDecriteDansLesImmos(ID_Ecriture,ID_Piece:integer):TErreurSaisie;
Var
ListeImmosASupprimer:Tstringlist;
begin
try//finally
ListeImmosASupprimer:=TStringList.Create;
result:=VerifSiEcritureDecriteDansLesImmos(ID_Ecriture,ID_Piece,ListeImmosASupprimer);
finally
  Initialise_TStringlist(ListeImmosASupprimer);
end;
end;

function TDataModuleImmos.VerifSiEcritureDecriteDansLesImmos(ID_Ecriture,ID_Piece:integer;var ListeImmosASupprimer:Tstringlist):TErreurSaisie;
begin
result.retour:=true;
result.CodeErreur:=0;
 QuRecupImmoSurSuppressionPieceComptable.close;
 QuRecupImmoSurSuppressionPieceComptable.sql.Clear;
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('SELECT I.id as ID_Immo,Type_Amt,Choix,(Valeur_a_amortir-amort_eco-amort_derog)as valeurNette');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('From Piece.db P left join Ecriture.db E on P.ID = E.ID_Piece');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('JOIN Immos.db I ON E.ID = I.Ecriture_Achat');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('where P.ID=:IDPiece and E.ID=:IDEcriture');
 QuRecupImmoSurSuppressionPieceComptable.ParamByName('IDPiece').asinteger:=ID_Piece;
 QuRecupImmoSurSuppressionPieceComptable.ParamByName('IDEcriture').asinteger:=ID_Ecriture;
 QuRecupImmoSurSuppressionPieceComptable.Open;
 if QuRecupImmoSurSuppressionPieceComptable.recordcount<>0 then
   Begin
     QuRecupImmoSurSuppressionPieceComptable.first;
     result.retour:=false;
     if ListeImmosASupprimer=nil then
       ListeImmosASupprimer:=TStringList.Create;
     while not (QuRecupImmoSurSuppressionPieceComptable.EOF) do
       begin//debut du while
          if ((QuRecupImmoSurSuppressionPieceComptablevaleurnette.Ascurrency>0)and(QuRecupImmoSurSuppressionPieceComptableType_Amt.AsString<>'N')) then
            Begin//si encore amortissable
              if result.CodeErreur=0 then
                result.CodeErreur:=1;
            End;//fin si encore amortissable
          if ListeImmosASupprimer.IndexOf(QuRecupImmoSurSuppressionPieceComptableID_Immo.Asstring)=-1 then
            ListeImmosASupprimer.Add(QuRecupImmoSurSuppressionPieceComptableID_Immo.Asstring);
       QuRecupImmoSurSuppressionPieceComptable.next;
       end;//fin du while
   End;
end;

procedure TDataModuleImmos.tbPMVAfterOpen(DataSet: TDataSet);
begin
tbPMVValeur_Nette_Calc.DisplayFormat:=E.FormatMonnaie;
tbPMVValeur_Nette_Calc.EditFormat:='0.00 ;-0.00 ';

tbPMVMt_Cession.DisplayFormat:=E.FormatMonnaie;
tbPMVMt_Cession.EditFormat:='0.00 ;-0.00 ';

tbPMVpvCT.DisplayFormat:=E.FormatMonnaie;
tbPMVpvCT.EditFormat:='0.00 ;-0.00 ';

tbPMVpvLT.DisplayFormat:=E.FormatMonnaie;
tbPMVpvLT.EditFormat:='0.00 ;-0.00 ';

InitFiltrePlusOuMoinsValues(dataset);
end;

Procedure TDataModuleImmos.InitFiltrePlusOuMoinsValues(Dataset:TDataset);
Begin
dataset.Filter:='Date_Cession >= '''+ DateToStr(E.DatExoDebut) + ''' and Date_Cession <= '''+ DateToStr(E.DatExoFin) + ''' and Cession_Dans_Annee = Vrai and Terminee = faux';
dataset.Filtered:=true;
//tbPMV.Filter:='Date_Cession >= '''+ DateToStr(E.DatExoDebut) + ''' and Date_Cession <= '''+ DateToStr(E.DatExoFin) + ''' and Cession_Dans_Annee = Vrai and Terminee = faux';
//tbPMV.Filtered:=true;
End;

procedure TDataModuleImmos.qryListeAcquisAfterOpen(DataSet: TDataSet);
begin
qryListeAcquisDebit.DisplayFormat:=E.FormatMonnaie;
qryListeAcquisDebit.EditFormat:='0.00 ;-0.00 ';

qryListeAcquisCredit.DisplayFormat:=E.FormatMonnaie;
qryListeAcquisCredit.EditFormat:='0.00 ;-0.00 ';
end;

procedure TDataModuleImmos.qryListeAcquisBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDataModuleImmos.qryListeAcquisEditError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
action:=daAbort;
end;

procedure TDataModuleImmos.TaImmosRebutCalcFields(DataSet: TDataSet);
begin
TaImmosRebutvaleurNette.AsCurrency:=TaImmosRebutValeur_a_Amortir.ascurrency-(TaImmosRebutAmort_Eco.ascurrency+TaImmosRebutAmort_Derog.ascurrency)
end;

procedure TDataModuleImmos.TaImmosRebutAfterDelete(DataSet: TDataSet);
begin
  try
  TableGereCommit(DataSet);
  TableGereCommit(DMBalance.TaBalance);
  except
  TableGereRollBack(DataSet);
  TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
end;

procedure TDataModuleImmos.TaImmosRebutAfterPost(DataSet: TDataSet);
begin
  try
    TableGereCommit(DataSet);
    TableGereCommit(DMBalance.TaBalance);
    DataModuleImmos.tbPMV.Close;
    DataModuleImmos.tbPMV.open;
    DataModuleImmos.taDetailImmo.Refresh;
    initialiserChoix(Choix_AvantRebut);
  except
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
end;

procedure TDataModuleImmos.TaImmosRebutBeforePost(DataSet: TDataSet);
var
//AmortAnnee:Tamortimmo;
reference:string;
i:integer;
valide:TErreurSaisie;
begin
 // vérifier infos avant de poster
  try
    for i:=19 to 41 do
      Begin
      Valide.retour:=true;
      valide.CodeErreur:=0;
           valide:=DataModuleImmos.CtrlSaisieRebut(DataModuleImmos.taimmosrebut.Fields[i]);
      if valide.Retour=false then
        if valide.CodeErreur=22001 then
          begin
            if application.MessageBox(Pchar('Votre immobilisation n''a pas une valeur nette égale à zéro, confirmez-vous cette mise au rebut ?'),'Erreur de saisie',MB_YESNO + MB_DEFBUTTON2) = IDNO then
               abort;
          end
        else
          abort;
      end;
      if VerificationSiPieceDeDotation(reference)then
        begin
        if application.MessageBox(Pchar('La pièce de dotation aux amortissement va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
          DMPieces.SuppressionOD(reference)
        else
          abort;
        end;
      //initialiserAmortissement(AmortAnnee);
      RecalculAmort_ApresModifDataset(dataset,Choix_AvantRebut);
//        //recalculer le dérogatoire et l'Eco
//        if TaImmosRebutType_Amt.AsString<>'N' then
//        Begin
//         Remplit_TInfosImmos(TaImmosRebut,ImmosEnCours);
//         AmortAnnee:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix_AvantRebut);
//        End;
//
//         TaImmosRebutValeur_Nette.AsCurrency:=AmortAnnee.VNC;
//         TaImmosRebutChoix.AsCurrency:=AmortAnnee.Choix;
//         if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
//            AmortAnnee.EcoRepartition:=AmortAnnee.Choix-AmortAnnee.Derog;
//         TaImmosRebutEco.AsCurrency:=AmortAnnee.EcoRepartition;
//         TaImmosRebutMini.AsCurrency:=amortannee.Mini;
//         TaImmosRebutMaxi.AsCurrency:=amortannee.Maxi;
         TaImmosRebutRebut.AsBoolean:=true;
         TaImmosRebutCession_dans_Annee.AsBoolean:=true;
         TaImmosRebutMt_Cession.ascurrency:=0;

//     with DataModuleImmos do
//       begin
//       DataModuleImmos.UpdateImmosSurValeurs(taimmosrebut,['Date_Cession','Rebut',
//       'Cession_dans_annee','Mt_Cession'],[Date_Rebut.Text,True,true,
//       0],dsEdit,taimmosrebutID.Asinteger);
//       end;
//    DataModuleImmos.tbPMV.Close;
//    DataModuleImmos.tbPMV.open;
//    DataModuleImmos.taDetailImmo.Refresh;
  except
    abort;
  end;//fin du try except

end;

procedure TDataModuleImmos.TaImmosRebutDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(Dataset);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDataModuleImmos.TaImmosRebutPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(Dataset);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDataModuleImmos.taDetailImmoBeforeDelete(DataSet: TDataSet);
var
reference:string;
begin
  try
   EcritureImmos:=DataSet.findfield('Ecriture_Achat').asinteger;
   if ((VerificationSiPieceDeDotation(reference))and(DataSet.FindField('Type_Amt').asstring<>'N')) then
    begin
    if application.MessageBox(Pchar('La pièce de dotation aux amortissements va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      DMPieces.SuppressionOD(reference)
    else
      abort;
    end;
   FiltrageDataSet(TaImmosEnCours,'CompteTerminee='''+DataSet.findfield('Compte').asstring+''' and CodeTerminee='''+DataSet.findfield('Code').asstring+''' and SousCodeTerminee='''+DataSet.findfield('Sous_Code').asstring+'''');
   InitialisationImmoEnCoursSurModif(TaImmosEnCours);
  except
    EcritureImmos:=0;
    abort;
  end;
end;

procedure TDataModuleImmos.TaImmosRebutBeforeDelete(DataSet: TDataSet);
var
reference:string;
begin
  try
  if VerificationSiPieceDeDotation(reference)then
    begin
    if application.MessageBox(Pchar('La pièce de dotation aux amortissements va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      DMPieces.SuppressionOD(reference)
    else
      abort;
    end;
  except
    abort;
  end;
end;

procedure TDataModuleImmos.taDetailImmoAfterInsert(DataSet: TDataSet);
begin
InitChampAfterInsert([0,nil,0,0,nil,nil,nil,nil,0,0,0,0,nil,nil,0,nil,false,0,0,0,0,0,0,nil,false,false,false,0,nil,false,0,0,0,0,false,false,nil,nil,0,nil,nil,0],DataSet);
end;

function TDataModuleImmos.Amort_lin_SurBase360(DateDebutAmo,DatefinAnneeAmo,DateCession:TDateTime;
	ValeurAcquis,Cumul:currency; Taux:extended;TypeAmort:char;Var nbJour:integer;Ceder,DerniereAnnee,CalculCumul:boolean):Currency;
var
NbJour_Sur360:integer;
//Base360:integer;
nbmois:integer;
nbjour_cedes:integer;
//FinTmp:tdate;
begin
Result := 0;
nbmois:=0;
nbJour:=0;
NbJour_Sur360:=0;

 while DateDebutAmo<=DatefinAnneeAmo do
  Begin
//   Base360:=RetourneBaseCalculSurAnneeExercice(DateDebutAmo,FinTmp);
   nbjour_cedes:=NbDeJours_SurBase360(DatefinAnneeAmo,DateCession,TypeAmort='L');
   if nbjour_cedes<0 then nbjour_cedes:=0;
   NbJour_Sur360:=NbJour_Sur360+NbDeJours_SurBase360(DateDebutAmo,DatefinAnneeAmo,TypeAmort='L');
   if NbJour_Sur360>360 then NbJour_Sur360:=360;
   nbmois:=NbJour_Sur360 div 30;
      if NbJour_Sur360 = 0 then
         exit;
   if DerniereAnnee then Result :=Result+ arrondi(ValeurAcquis-cumul,2)
   else
     begin
        if (((((valeurAcquis*taux)<(ValeurAcquis-cumul))or(ceder)))or(CalculCumul))then
          Result :=Result+ arrondi(ValeurAcquis * Taux *(NbJour_Sur360/360),2)
        else
           if not DerniereAnnee then
             Result :=Result+ arrondi((ValeurAcquis-cumul)*(NbJour_Sur360/360),2)
           else
            Result :=Result+ arrondi(ValeurAcquis-cumul,2);
     end;
     cumul:=result;
   CalculCumul:=false;//réinitialiser juste après le premier passage dans le calcul
   DateDebutAmo:=MoisSuivant(DateDebutAmo,nbmois-1).Date_;
   nbJour:= NbJour_Sur360- nbmois* 30 ;
   if TypeAmort='L' then
   if nbJour>0 then
     Begin
         if TypeAmort='D' then
           nbJour:=30;
         DateDebutAmo:=JourSuivant(DateDebutAmo,nbJour).Date_+1;
     End;
  NbJour_Sur360:=0;
  End;
//Result:=Arrondi(result,2);
end;

procedure TDataModuleImmos.QuRecupImmosSurCptBeforeOpen(DataSet: TDataSet);
begin
  tbPMV.close;
  tbPMV.Open;
  qryTotalCumulImmos.DisableControls;
  qryTotalCumulImmos.Active:=false;
  qryTotalCumulImmos.Open;
  qryTotalCumulImmos.EnableControls;
end;


Function TDataModuleImmos.CalculDerogSurImmos(Var Immos:TAmortImmo):TCalcul;
Begin
result.Retour:=true;
result.SensTotal:=0;
result.Total:=0;
  try
  Immos.Derog:=0;
//       if (Immos.Gerer_Derog) then
//         Begin
//            if Immos.Report_Derog+(Immos.choix-Immos.EcoRepartition)<0 then
//               begin
//                 immos.derog:=-immos.Report_Derog ;
//                  if (abs(immos.derog)>immos.ecoobligatoire) then
//                    immos.derog:=-immos.ecoobligatoire;
//               end
//            else
//              Immos.Derog:=Immos.choix-Immos.EcoRepartition;
//         End;
      if (empty(immos.compte)) and (Type_version_execution=ct_developpement) then showmessage('Le compte immos pour le calcul du dérogatoire n''est pas renseigné');
      if not str_commence_par(immos.compte,'131')then
      if ((Immos.TypeAmort<>'L')or(Immos.Report_Derog>0))then
       if ((Immos.Gerer_Derog)or(((Immos.Report_Derog>0)and(Immos.choix-Immos.EcoRepartition<0)))) then
         Begin
            if Immos.Report_Derog+(Immos.choix-Immos.EcoRepartition)<0 then
               begin
                 immos.derog:=-immos.Report_Derog ;
                  if (abs(immos.derog)>immos.ecoobligatoire) then
                    immos.derog:=-immos.ecoobligatoire;
               end
            else
              Immos.Derog:=Immos.choix-Immos.EcoRepartition;
         End;

  result.Total:=Immos.Derog;
  if Immos.Derog<0 then
    result.SensTotal:=-1
  else
    if Immos.Derog>0 then
      result.SensTotal:=1;
//  immos.Eco:=immos.Choix-immos.Derog;
  except
    result.Retour:=false;
    result.SensTotal:=0;
    result.Total:=0;
  end;
End;

Function TDataModuleImmos.CalculEcoRepartitionSurImmos(Var Immos:TAmortImmo;DerniereAnnee:boolean):TCalcul;
Begin
result.Retour:=true;
result.SensTotal:=0;
result.Total:=0;
  try
//     if ((Immos.choix>Immos.MiniAnnee)and((Immos.Gerer_Derog)or(((Immos.Report_Derog>0)and(Immos.choix-Immos.MiniAnnee<0))))) then
      //     Immos.EcoRepartition:=Immos.MiniAnnee
//     else
//    if ((DerniereAnnee)or(immos.choix<Immos.EcoObligatoire)) then
    if ((not Immos.Gerer_Derog)and(immos.TypeAmort='L')and(Immos.Report_Derog<=0)) then
       Immos.EcoRepartition:=Immos.choix
    else
      begin
        if (DerniereAnnee) then
             Immos.EcoRepartition:=Immos.EcoObligatoire
           else
    //         Immos.EcoRepartition:=Immos.choix;
    //modifié le 06/06/03 par isa voir avec denis si ok

         Immos.EcoRepartition:=Immos.MiniAnnee;
         if ((Immos.EcoRepartition>Immos.VNC)and(Immos.Report_Derog<=0)) then
           Immos.EcoRepartition:=Immos.VNC;
     end;
//
  result.Total:=Immos.EcoRepartition;

  if Immos.EcoRepartition<0 then
    result.SensTotal:=-1
  else
    if Immos.EcoRepartition>0 then
      result.SensTotal:=1;
  except
    result.Retour:=false;
    result.SensTotal:=0;
    result.Total:=0;
  end;
End;


function TDataModuleImmos.RecalculGeneralAmortissement(Dataset:Tdataset;Ouverture:boolean;DateDebut,DateFin:Tdatetime):boolean;
var
AmortAnnee:TAmortImmo;
choixTmp:Tchoix;
casTmp:integer;
Begin
try
result:=true;
casTmp:=0;
initialiserChoix(choixTmp);
if not dataset.Active then dataset.open;
dataset.first;
if VerifSiReportDerogatoire(e.DatExoDebut,e.DatExoFin).retour then
  begin
    ModifChampDerogatoire;
    e.Derogatoire:=true;
  end;

while not (dataset.EOF) do
  Begin
  Remplit_TInfosImmos(dataset,ImmosEnCours);
    if ouverture then
     begin
       if DMImmos_Ouverture=nil then DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);
        AmortAnnee:=DMImmos_Ouverture.CalculerAmortAnneeSurImmo(dataset,dataset.findfield('id').Asinteger)
     end
    else
      AmortAnnee:=CalculerAmortAnneeSurImmo(ImmosEnCours,DateDebut,DateFin,choixTmp);
   tablegereEdit(dataset);
//   dataset.Edit;


   { isa  le  29/04/04 vu avec phil et Denis}
   if dataset.findfield('Choix').AsCurrency=dataset.findfield('Mini').AsCurrency then
     casTmp:=1
   else
     if dataset.findfield('Choix').AsCurrency=dataset.findfield('Maxi').AsCurrency then
        casTmp:=2;
   if  ((dataset.findfield('Choix').AsCurrency=0)and(casTmp=0)) then
     dataset.findfield('Choix').AsCurrency:=amortannee.Mini;
                              case casTmp of
{si ancien choix était au mini} 1:if amortannee.Mini<>dataset.findfield('Mini').AsCurrency then
                                    begin //si amort mini a changé
                                       dataset.findfield('Choix').AsCurrency:=amortannee.Mini;
                                    end; //fin si amort mini a changé
{si ancien choix était au maxi} 2:if amortannee.Maxi<>dataset.findfield('Maxi').AsCurrency then
                                    begin //si amort maxi a changé
                                       dataset.findfield('Choix').AsCurrency:=amortannee.Maxi;
                                    end; //fin si amort maxi a changé
{si ancien choix était autre}   else
                                    begin
                                       //dans ce cas , ne pas changer le choix
                                    end;
                              end;//fin du case
   { isa  le  29/04/04 vu avec phil et Denis}
   
   { isa  le  27/07/04 }
   AmortAnnee.Choix:=dataset.findfield('Choix').AsCurrency;

    DataModuleImmos.CalculDerogSurImmos(AmortAnnee);

   if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
      AmortAnnee.EcoRepartition:=AmortAnnee.Choix-AmortAnnee.Derog; { isa  le  13/03/04 }
   { isa  le  27/07/04 }

   dataset.findfield('Eco').AsCurrency:=AmortAnnee.EcoRepartition;
   dataset.findfield('Mini').AsCurrency:=amortannee.Mini;
   dataset.findfield('Maxi').AsCurrency:=amortannee.Maxi;
   dataset.findfield('Choix').AsCurrency:=AmortAnnee.Choix;
   TableGerePost(dataset);
   dataset.next;
  End;
except
   result:=false;
   abort;
end;
End;

function TDataModuleImmos.VerifSiPieceDecriteDansLesCessions(ID_Piece:integer):TErreurSaisie;
var
 ListeCessionsASupprimer:Tstringlist;
begin
try//finally
ListeCessionsASupprimer:=Tstringlist.Create;
result:=VerifSiPieceDecriteDansLesCessions(ID_Piece,ListeCessionsASupprimer);
finally
Initialise_TStringlist(ListeCessionsASupprimer);
end;
end;

function TDataModuleImmos.VerifSiPieceDecriteDansLesCessions(ID_Piece:integer;var ListeCessionsASupprimer:Tstringlist):TErreurSaisie;
begin
result.retour:=true;
result.CodeErreur:=0;
 QuRecupImmoSurSuppressionPieceComptable.close;
 QuRecupImmoSurSuppressionPieceComptable.sql.Clear;
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('SELECT I.id as ID_Immo,Type_Amt,Choix,(Valeur_a_amortir-amort_eco-amort_derog)as valeurNette');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('From Piece.db P left join Ecriture.db E on P.ID = E.ID_Piece');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('JOIN Immos.db I ON E.ID = I.Ecriture_Cession');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('where P.ID=:IDPiece');
 QuRecupImmoSurSuppressionPieceComptable.ParamByName('IDPiece').asinteger:=ID_Piece;
 QuRecupImmoSurSuppressionPieceComptable.Open;
 if QuRecupImmoSurSuppressionPieceComptable.recordcount<>0 then
   Begin
     QuRecupImmoSurSuppressionPieceComptable.first;
     result.retour:=false;
     if ListeCessionsASupprimer=nil then
       ListeCessionsASupprimer:=TStringList.Create;
     while not (QuRecupImmoSurSuppressionPieceComptable.EOF) do
       begin//debut du while
          if ((QuRecupImmoSurSuppressionPieceComptablevaleurnette.Ascurrency>0)and(QuRecupImmoSurSuppressionPieceComptableType_Amt.AsString<>'N')) then
            Begin//si encore amortissable
              if result.CodeErreur=0 then
                result.CodeErreur:=1;
            End;//fin si encore amortissable
          if ListeCessionsASupprimer.IndexOf(QuRecupImmoSurSuppressionPieceComptableID_Immo.Asstring)=-1 then
            ListeCessionsASupprimer.Add(QuRecupImmoSurSuppressionPieceComptableID_Immo.Asstring);
       QuRecupImmoSurSuppressionPieceComptable.next;
       end;//fin du while
   End;
end;

function TDataModuleImmos.VerifSiEcritureDecriteDansLesCessions(ID_Ecriture,ID_Piece:integer):TErreurSaisie;
var
ListeCessionsASupprimer:Tstringlist;
begin
try//finally
ListeCessionsASupprimer:=Tstringlist.Create;
result:=VerifSiEcritureDecriteDansLesCessions(ID_Ecriture,ID_Piece,ListeCessionsASupprimer);
finally
Initialise_TStringlist(ListeCessionsASupprimer);
end;//fin finally
end;


function TDataModuleImmos.VerifSiEcritureDecriteDansLesCessions(ID_Ecriture,ID_Piece:integer;var ListeCessionsASupprimer:Tstringlist):TErreurSaisie;
begin
result.retour:=true;
result.CodeErreur:=0;
 QuRecupImmoSurSuppressionPieceComptable.close;
 QuRecupImmoSurSuppressionPieceComptable.sql.Clear;
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('SELECT I.id as ID_Immo,Type_Amt,Choix,(Valeur_a_amortir-amort_eco-amort_derog)as valeurNette');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('From Piece.db P left join Ecriture.db E on P.ID = E.ID_Piece');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('JOIN Immos.db I ON E.ID = I.Ecriture_Cession');
 QuRecupImmoSurSuppressionPieceComptable.SQL.Add('where P.ID=:IDPiece and E.ID=:IDEcriture');

 QuRecupImmoSurSuppressionPieceComptable.ParamByName('IDPiece').asinteger:=ID_Piece;
 QuRecupImmoSurSuppressionPieceComptable.ParamByName('IDEcriture').asinteger:=ID_Ecriture;
 QuRecupImmoSurSuppressionPieceComptable.Open;
 if QuRecupImmoSurSuppressionPieceComptable.recordcount<>0 then
   Begin
     QuRecupImmoSurSuppressionPieceComptable.first;
     result.retour:=false;
     if ListeCessionsASupprimer=nil then
       ListeCessionsASupprimer:=TStringList.Create;
     while not (QuRecupImmoSurSuppressionPieceComptable.EOF) do
       begin//debut du while
          if ((QuRecupImmoSurSuppressionPieceComptablevaleurnette.Ascurrency>0)and(QuRecupImmoSurSuppressionPieceComptableType_Amt.AsString<>'N')) then
            Begin//si encore amortissable
              if result.CodeErreur=0 then
                result.CodeErreur:=1;
            End;//fin si encore amortissable
          if ListeCessionsASupprimer.IndexOf(QuRecupImmoSurSuppressionPieceComptableID_Immo.Asstring)=-1 then
            ListeCessionsASupprimer.Add(QuRecupImmoSurSuppressionPieceComptableID_Immo.Asstring);
       QuRecupImmoSurSuppressionPieceComptable.next;
       end;//fin du while
   End;
end;

procedure TDataModuleImmos.Filtrage_qryTotalCumulImmosSurCpt_SurTag(TagTmp:integer;Partiel:boolean;Rang:integer;SQLText,Cpt:string;DateDeb,Datefin:Tdate);
Begin
//Filtrage des Immos en fonction des écrans (ListeImmos,ListeAcquis,ListeCessions,...)
qryTotalCumulImmosSurCpt.Close;
if partiel then
Begin
qryTotalCumulImmosSurCpt.SQL.Strings[Rang] := SQLText;
End
else
Begin
qryTotalCumulImmosSurCpt.SQL.Clear;
   case TagTmp of
   0,1,2,3,4,6:Begin //C_IMMOS, C_ACQUIS_EXO, C_CESSION, C_REBUT, C_DIVISION, C_ACQUISITION_Termninee
       qryTotalCumulImmosSurCpt.SQL.Add('select sum(Valeur_a_amortir) as Valeur_a_amortir ,');
       qryTotalCumulImmosSurCpt.SQL.Add(' Sum((Amort_eco+Amort_derog))as Report,');
       qryTotalCumulImmosSurCpt.SQL.Add(' sum(Choix)as exercice,');
       qryTotalCumulImmosSurCpt.SQL.Add(' (sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))as Valeur_nette,');
       qryTotalCumulImmosSurCpt.SQL.Add(' (Sum((Amort_eco+Amort_derog))+sum(choix))as Cumul,');
       qryTotalCumulImmosSurCpt.SQL.Add(' Sum(Mt_Cession)as MtCession');
       qryTotalCumulImmosSurCpt.SQL.Add(' From immos.db');
       qryTotalCumulImmosSurCpt.SQL.Add(' where Compte like :Cpt and ((Terminee=false) or ((Terminee=true) and (Cession_Dans_Annee=true)))');
       qryTotalCumulImmosSurCpt.SQL.Add(' and Date_Achat>= :DateDebut');
       qryTotalCumulImmosSurCpt.SQL.Add(' and Date_Achat <= :DateFin and ((Date_Cession is null) or (Date_Cession >=:DateExoEnCours))');
       qryTotalCumulImmosSurCpt.parambyname('Cpt').asstring:=Cpt;
       qryTotalCumulImmosSurCpt.parambyname('DateDebut').asDate:=DateDeb;
       qryTotalCumulImmosSurCpt.parambyname('DateFin').asDate:=Datefin;
       qryTotalCumulImmosSurCpt.ParamByName('DateExoEnCours').AsDate:=e.DatExoDebut;
     End;
//   1:;//C_ACQUIS_EXO
//   2:;//C_REBUT
//   3:;//C_DIVISION
//   4:;//C_ACQUISITION
//   5:;
   7:Begin//C_CESSION_EXO
       qryTotalCumulImmosSurCpt.SQL.Add('select sum(Valeur_a_amortir) as Valeur_a_amortir ,');
       qryTotalCumulImmosSurCpt.SQL.Add(' Sum((Amort_eco+Amort_derog))as Report,');
       qryTotalCumulImmosSurCpt.SQL.Add(' sum(Choix)as exercice,');
       qryTotalCumulImmosSurCpt.SQL.Add(' (sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))as Valeur_nette,');
       qryTotalCumulImmosSurCpt.SQL.Add(' (Sum((Amort_eco+Amort_derog))+sum(choix))as Cumul,');
       qryTotalCumulImmosSurCpt.SQL.Add(' Sum(Mt_Cession)as MtCession');
       qryTotalCumulImmosSurCpt.SQL.Add(' From immos.db');
       qryTotalCumulImmosSurCpt.SQL.Add(' where ((Date_Cession Is not Null)or(Rebut=true))');
       qryTotalCumulImmosSurCpt.SQL.Add(' and Compte like :Cpt and Terminee=false');
       qryTotalCumulImmosSurCpt.SQL.Add(' and Date_Achat >= :DateDebut and Date_Achat <= :DateFin and Date_Cession >=:DateExoEnCours');
       qryTotalCumulImmosSurCpt.parambyname('cpt').AsString:=cpt;
       qryTotalCumulImmosSurCpt.parambyname('DateDebut').asDate:=strtodate('01/01/1900');
       qryTotalCumulImmosSurCpt.parambyname('DateFin').asDate:=Datefin;
       qryTotalCumulImmosSurCpt.ParamByName('DateExoEnCours').AsDate:=e.DatExoDebut;

     End;
   end;//fin du case
End;


qryTotalCumulImmosSurCpt.Prepare;
qryTotalCumulImmosSurCpt.open;
End;



procedure TDataModuleImmos.TaImmosRebutBeforeEdit(DataSet: TDataSet);
//var
//amortissement:TAmortImmo;
begin
Choix_AvantRebut:=RemplirChoixAvantModif(dataset,ImmosEnCours);
//initialiserChoix(Choix_AvantRebut);
//Remplit_TInfosImmos(taimmosRebut,ImmosEnCours);
//amortissement:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix_AvantRebut);
//amortissement.Choix:=TaImmosRebut.findfield('Choix').AsCurrency;
////récupérer le choix avant modif
//Choix_AvantRebut.choixDefaut:=0;
//if ((amortissement.Choix<>amortissement.Mini)and(amortissement.Choix<>amortissement.Maxi))then
// begin
//   Choix_AvantRebut.choixDefaut:=amortissement.Choix;
//   Choix_AvantRebut.ChoixItem:=2;
// end
//else
//  if amortissement.Choix=amortissement.Mini then Choix_AvantRebut.ChoixItem:=0
//  else
//    if amortissement.Choix=amortissement.Maxi then Choix_AvantRebut.ChoixItem:=1;
end;

procedure TDataModuleImmos.TaImmos_A_CederBeforeEdit(DataSet: TDataSet);
//var
//amortissement:TAmortImmo;
begin
Choix_AvantCession:=RemplirChoixAvantModif(dataset,ImmosEnCours);
//Remplit_TInfosImmos(TaImmos_A_Ceder,ImmosEnCours);
//initialiserChoix(Choix_AvantCession);
//amortissement:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Choix_AvantCession);
//amortissement.Choix:=TaImmos_A_Ceder.findfield('Choix').AsCurrency;
////récupérer le choix avant modif
//Choix_AvantCession.choixDefaut:=0;
//if ((amortissement.Choix<>amortissement.Mini)and(amortissement.Choix<>amortissement.Maxi))then
// begin
//   Choix_AvantCession.choixDefaut:=amortissement.Choix;
//   Choix_AvantCession.ChoixItem:=2;
// end
//else
//  if amortissement.Choix=amortissement.Mini then Choix_AvantCession.ChoixItem:=0
//  else
//    if amortissement.Choix=amortissement.Maxi then Choix_AvantCession.ChoixItem:=1;
end;

procedure TDataModuleImmos.qryListeAcquisBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

//function TDataModuleImmos.RetourneBaseCalculSurAnneeExercice(DebutExo:Tdate;var FinExo:Tdate):integer;
//Begin
//try
//FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['ID_Dossier','Date_Deb_Exo'],[inttostr(e.ID_Dos),datetostr(DebutExo)]));
//if DMRech.TaGestDossierRech.RecordCount<>0 then
// begin
//   FinExo:=DMRech.TaGestDossierRech.findfield('Date_Fin_Exo').AsDateTime;
//   result:=NbDeJours_SurBase360(debutExo,finexo,true);
// end
//else
// begin
//   FinExo:=MoisSuivant(DebutExo,11).Date_-1;;
//   result:=360;
// end;
//finally
//  DeFiltrageDataSet(DMRech.TaGestDossierRech);
//end;
//End;


function TDataModuleImmos.CtrlSaisieRebut(EditCourant:Tfield):TErreurSaisie;
var
DateDefaut:Tdatetime;
Begin
result.CodeErreur:=0;
result.Retour:=true;
if taimmosrebut.State in [dsinsert,dsedit]then
  begin//si en insertion ou modification
       case EditCourant.Index of
         22:Begin //si edit dateCession
            if now>e.DatExoFin then
              DateDefaut:=e.DatExoFin
            else
              DateDefaut:=now;
             if not DateValide(EditCourant.asstring)then
               Begin
                 EditCourant.AsDateTime:=DateDefaut;
               End
               else
               if ((EditCourant.AsDateTime<e.DatExoDebut)or(EditCourant.AsDateTime>e.DatExofin)) then
                 begin
                   showmessage('La date de cession doit faire partie de l''exercice courant.');
                   result.CodeErreur:=23001;
                   result.Retour:=false;
                 end
                 else
                   if EditCourant.AsDateTime<EditCourant.dataset.FindField('Date_Achat').AsDateTime then
                     begin
                       showmessage('La date de cession est antérieure à la date d''acquisition.');
                       result.CodeErreur:=23002;
                       result.Retour:=false;
                     end;
           end;//fin si edit dateCession
         41:Begin //si edit ValeurNette(VNC)
              if editcourant.AsCurrency<>0 then
                Begin
                  result.CodeErreur:=22001;
                  result.Retour:=false;
                End;
           end;//fin si edit Montantcession(VNC)
       end;//fin du case
  end;

end;


procedure TDataModuleImmos.QuImmosEditionCalcFields(DataSet: TDataSet);
  var pvCT, pvLT:Currency;
begin
  QuImmosEditionCodeLong.AsString:=QuImmosEditionCode.AsString+' '+QuImmosEditionSous_Code.AsString;
  QuImmosEditionexercice.AsCurrency:=QuImmosEditionChoix.AsCurrency;
  QuImmosEditioncumul.AsCurrency:=QuImmosEditionAmort_Eco.AsCurrency+QuImmosEditionAmort_Derog.AsCurrency+QuImmosEditionChoix.AsCurrency;
  QuImmosEditionnet.AsCurrency:=QuImmosEditionValeur_a_Amortir.AsCurrency-QuImmosEditionAmort_Eco.AsCurrency-QuImmosEditionAmort_Derog.AsCurrency-QuImmosEditionChoix.AsCurrency;
  QuImmosEditionvaleur_res.AsCurrency := QuImmosEditionValeur_a_Amortir.AsCurrency-QuImmosEditioncumul.AsCurrency;
  QuImmosEditionPlusvalue.AsCurrency := QuImmosEditionMt_Cession.AsCurrency-QuImmosEditionvaleur_res.AsCurrency;

  if QuImmosEditionValeur_Org.AsCurrency=0 then
      QuImmosEditionamort_forfait.AsCurrency:=0
  else
      QuImmosEditionamort_forfait.AsCurrency:= QuImmosEditionValeur_a_Amortir.AsCurrency-QuImmosEditionValeur_Org.AsCurrency;

  Calcule_PM_Values(pvCT,PVLT,QuImmosEdition);
  if pvCT<0 then begin
      //moins value
      QuImmosEditionPVCourtTerme.AsCurrency:=0;
      QuImmosEditionMVCourtTerme.AsCurrency:=-pvCT;
  end
  else begin
      //plus value
      QuImmosEditionPVCourtTerme.AsCurrency:=pvCT;
      QuImmosEditionMVCourtTerme.AsCurrency:=0;
  end;
  if pvLT<0 then begin
      //moins value
      QuImmosEditionPVLongTerme.AsCurrency:=0;
      QuImmosEditionMVLongTerme.AsCurrency:=-pvLT;
  end
  else begin
      //plus value
      QuImmosEditionPVLongTerme.AsCurrency:=pvLT;
      QuImmosEditionMVLongTerme.AsCurrency:=0;
  end;

  QuImmosEditionamort_reel.AsCurrency:=QuImmosEditioncumul.AsCurrency;
end;



//changer le chemin d'accès à la table immos  { isa  le  11/09/03 }
Procedure TDataModuleImmos.ChangementRepertoireTableImmos;
begin
    try
//       FermerTouteTable('',Tcontrol(DataModuleImmos));
       case taDetailImmo.State of
          dsEdit:Begin
                   Application.MessageBox(Pchar('La table : ' + #13#10#13#10+UpperCase(taDetailImmo.Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(DataModuleImmos.Name)+ #13#10#13#10+'est en modification.'),'Attention',MB_ICONWARNING +MB_OK);
                 End;
          dsInsert:Begin
                     Application.MessageBox(Pchar('La table : ' + #13#10#13#10+UpperCase(taDetailImmo.Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(DataModuleImmos.Name)+ #13#10#13#10+'est en insertion.'),'Attention',MB_ICONWARNING +MB_OK);
                   End;
          dsBrowse:begin
                      QuCptUtiliseImmos.Close;
                      QuRecupImmosSurCpt.close;
                      qryTotalCumulImmosSurCpt.Close;
                      //taDetailImmo.close ;
                      if E.ExerciceCloture then
                        Begin //si exo clôturé
                          if FileExists(DMBalance.TaBalance.Database.Directory+'Immos.db') then
                            begin
                              //taDetailImmo.DatabaseName:=DMBalance.TaBalance.DatabaseName;
                              QuCptUtiliseImmos.DatabaseName:=DMBalance.TaBalance.DatabaseName;
                              QuCptUtiliseImmos.sql.clear;
                              QuCptUtiliseImmos.sql.Add('SELECT Immos.Compte, PlanCpt.Libelle,sum(Valeur_a_amortir) as Valeur_a_amortir ,Sum((Amort_eco+Amort_derog))as Report,sum(Choix)as exercice,');
                              QuCptUtiliseImmos.sql.Add('(Sum((Amort_eco+Amort_derog))+sum(choix))as Cumul,(sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog)-sum(choix))as Valeur_nette');
                              QuCptUtiliseImmos.sql.Add('FROM Immos INNER JOIN "'+E.RepertoireDossier+'PlanCpt" ON Immos.Compte = PlanCpt.Compte');
                              QuCptUtiliseImmos.sql.Add('where Immos.Compte like:Cpt');
                              QuCptUtiliseImmos.sql.Add('and Immos.Date_Achat>= :DateDebut');
                              { isa  le  09/01/04     ????? à vérifier }
//                              QuCptUtiliseImmos.sql.Add('and Immos.Date_Achat <= :DateFin and (Immos.Date_Cession is null or Date_Cession>=:DateDebut)');
                              QuCptUtiliseImmos.sql.Add('and Immos.Date_Achat <= :DateFin and (Immos.Date_Cession is null or Date_Cession>=:DateExoEnCours)');

                              QuCptUtiliseImmos.sql.Add('GROUP BY Immos.Compte, PlanCpt.Libelle');
                              QuRecupImmosSurCpt.DatabaseName:=DMBalance.TaBalance.DatabaseName;
                              qryTotalCumulImmosSurCpt.DatabaseName:=DMBalance.TaBalance.DatabaseName;
                            end
                          else
                            begin
                              //taDetailImmo.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                              QuCptUtiliseImmos.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                              QuRecupImmosSurCpt.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                              qryTotalCumulImmosSurCpt.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                            end;
                        end //fin si exo clôturé
                      else
                        begin //si exo non clôturé
                          taDetailImmo.DatabaseName:=DMPieces.TaPiece.DatabaseName;
                        end;//fin si exo non clôturé
                      //QuCptUtiliseImmos.open;
                      //QuRecupImmosSurCpt.open;
                      //taDetailImmo.open;
                   end;
       end;//fin du case
    except
       begin
       Application.MessageBox(Pchar('Erreur à la redirection de la table : ' + #13#10#13#10+UpperCase(taDetailImmo.Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(DataModuleImmos.Name)),'Attention',MB_ICONWARNING +MB_OK);
       end;
    end;
end;


function RecupSoldeImmosSurCompte(compte:string):TCalcul;
var
Requete:TQuery;
begin
  try//except
   result.Total:=0;
   result.SensTotal:=0;
   Requete:=TQuery.Create(Application.MainForm);
   Requete.SQL.clear;
   Requete.SQL.Add('SELECT (sum(Valeur_a_amortir)-Sum(Amort_eco+Amort_derog))as Valeur_nette');
   Requete.SQL.Add('From immos.db');
   Requete.SQL.Add('where Compte =:Cpt');
   Requete.ParamByName('Cpt').AsString:=Compte;
   Requete.Prepare;
   Requete.open;
   result.retour:=((Requete.recordcount<>0)and(not VerifFNumeric(Requete.findfield('Valeur_nette')).VideOUZero));
   if (result.retour) then
     begin
       result.Total:=Requete.findfield('Valeur_nette').ascurrency;
       if copy(compte,1,1)='1' then
         result.SensTotal:=1
       else
         result.SensTotal:=-1;
     end;
  except
   result.retour:=false;
   if Requete<>nil then
     begin
       Requete.free;
       Requete:=nil;
     end;
  end;//fin except
end;


procedure TDataModuleImmos.TaImmosChoixFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  if TaImmosChoixDate_Cession<>nil then
    Accept:=((TaImmosChoixDate_Cession.Asstring ='') or (TaImmosChoixDate_Cession.AsDateTime>=e.DatExoDebut));
if accept then
  Accept:=(TaImmosChoixtype_amt.AsString<>'N');
if accept then
  begin
      case typeImmos of
       C_Immo:accept:=str_n_prem_char(TaImmosChoixCompte.AsString,1)='2';
       C_Sub:accept:=str_n_prem_char(TaImmosChoixCompte.AsString,2)='13';
      end;
  end;
if accept then
  begin
      case typeAmort of
       C_Degessif:accept:=TaImmosChoixtype_amt.AsString='D';
       C_Lineaire:accept:=TaImmosChoixtype_amt.AsString='L';
      end;
  end;
end;



Function EditionDesAcquisitionsL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Relance:boolean):TStringList;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
ListeEdition:TStringList;
compteTmp:string;
TotalCompteVal,TotalCompteDeduc,TotalVal,TotalDeduc:currency;
TitreCompte:string;
Compteur:integer;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalCompteVal:=0;
TotalCompteDeduc:=0;
TotalVal:=0;
TotalDeduc:=0;

  if ((DemandePeriode) and (not Relance)) then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;

    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    Initialise_TStringlist(DataModuleImmos.ListeFilterRecordAcquisition,nil,false);
    DataModuleImmos.QuAcquisition_Edition.OnFilterRecord:=nil;
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DataModuleImmos.ListeFilterRecordAcquisition.clear;
        if (Compte<>nil)and(compte.Count=0)then abort;

        if Compte<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
          DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
          DataModuleImmos.QuAcquisition_Edition.OnFilterRecord:=DataModuleImmos.QuAcquisition_EditionFilterRecord;
          DataModuleImmos.QuAcquisition_Edition.filtered:=true;
         end
        else
          begin
            DataModuleImmos.QuAcquisition_Edition.OnFilterRecord:=nil;
            Titrecompte:='Tous les comptes';
          end;
          DataModuleImmos.QuAcquisition_Edition.Close;
          DataModuleImmos.QuAcquisition_Edition.SQL.Clear;
          if e.ExerciceCloture then
            DataModuleImmos.QuAcquisition_Edition.SQL.Add('select * from "'+IncludeTrailingPathDelimiter(e.RepertoireExercice)+'Immos"')
          else
            DataModuleImmos.QuAcquisition_Edition.SQL.Add('select * from Immos');
          DataModuleImmos.QuAcquisition_Edition.SQL.Add('where  date_achat  between :DateDeb and  :DateFin');
          DataModuleImmos.QuAcquisition_Edition.SQL.Add('order by Compte,code,sous_code');

          DataModuleImmos.QuAcquisition_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DataModuleImmos.QuAcquisition_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DataModuleImmos.QuAcquisition_Edition.Open;
          DataModuleImmos.QuAcquisition_Edition.First;
          if DataModuleImmos.QuAcquisition_Edition.recordcount<>0 then
          begin
          compteTmp:=DataModuleImmos.QuAcquisition_Edition.FindField('Compte').AsString;
          Compteur:=0;
          ListeEdition.Add('5A3;Compte'+
                   ';'+
                   'Débit'+
                   ';'+
                   'Crédit'
                   );
          ListeValeur.Add('9;COMPTE : '+compteTmp);
                while not DataModuleImmos.QuAcquisition_Edition.Eof do
                  begin

                        ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle(DataModuleImmos.QuAcquisition_Edition.FindField('Code').AsString)+
                                         ';'+
                                         GereLibelle(DataModuleImmos.QuAcquisition_Edition.FindField('Sous_Code').AsString)+
                                         ';'+
                                         GereLibelle(DataModuleImmos.QuAcquisition_Edition.FindField('Libelle').AsString)+
                                         ';'+
                                         DataModuleImmos.QuAcquisition_Edition.FindField('Type_Amt').AsString+
                                         ';'+
                                         DataModuleImmos.QuAcquisition_Edition.FindField('Duree_Amt').AsString+
                                         ';'+
                                         DataModuleImmos.QuAcquisition_Edition.FindField('Date_Achat').AsString+
                                         ';'+
                                         DataModuleImmos.QuAcquisition_Edition.FindField('Valeur_A_Amortir').AsString+
                                         ';'+
                                         DataModuleImmos.QuAcquisition_Edition.FindField('Mt_Deduc_Invest').AsString
                                         );
                         TotalCompteVal:=TotalCompteVal+DataModuleImmos.QuAcquisition_Edition.FindField('Valeur_A_Amortir').AsCurrency;
                         TotalCompteDeduc:=TotalCompteDeduc+DataModuleImmos.QuAcquisition_Edition.FindField('Mt_Deduc_Invest').AsCurrency;
                         inc(Compteur);
                         DataModuleImmos.QuAcquisition_Edition.Next;
                    if compteTmp<>DataModuleImmos.QuAcquisition_Edition.FindField('Compte').AsString then
                      begin
                      ListeEdition.Add('5A3;'+compteTmp+
                                         ';'+CurrToStr_Lgr(TotalCompteVal) +';0');
                        compteTmp:=DataModuleImmos.QuAcquisition_Edition.FindField('Compte').AsString;
                        ListeValeur.Add('3;;;;;; @TOTAL COMPTE :  ;'+E.FormatCurrSansDevise(TotalCompteVal) +';'+E.FormatCurrSansDevise(TotalCompteDeduc));
                        ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp));
                        TotalVal:=TotalVal+TotalCompteVal;
                        TotalDeduc:=TotalDeduc+TotalCompteDeduc;
                        TotalCompteVal:=0;
                        TotalCompteDeduc:=0;
                      end;
                  end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
                      ListeEdition.Add('5A3;'+GereLibelle(compteTmp)+
                                         ';'+CurrToStr_Lgr(TotalCompteVal) +';0');
             compteTmp:=DataModuleImmos.QuAcquisition_Edition.FindField('Compte').AsString;
             ListeValeur.Add('3;;;;;; @TOTAL COMPTE :  ;'+E.FormatCurrSansDevise(TotalCompteVal) +';'+E.FormatCurrSansDevise(TotalCompteDeduc));
             TotalVal:=TotalVal+TotalCompteVal;
             TotalDeduc:=TotalDeduc+TotalCompteDeduc;
             ListeValeur.Add('8;Nombre total d''immobilisation : '+ inttostr(Compteur));
             ListeValeur.Add('1;;;;;; @TOTAL ACQUISITION DE L''EXERCICE :  ;'+E.FormatCurrSansDevise(TotalVal) +';'+E.FormatCurrSansDevise(TotalDeduc));

             ObjPrn.FTitreEdition := 'TABLEAUX DES ACQUISITIONS ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

             ListeValeur.Insert(0,' Code ; S/Code ;Désignation ;  ;  ;  ;  ;  ');
             ListeValeur.Insert(1,'0.5;0.5;2;0.8;0.8;0.8;0.8;0.8');
             ListeValeur.Insert(2,'texte;texte;texte;texte;float;texte;curr;curr');
             ListeValeur.Insert(3,' Immobilisation ; Type ; Durée ; Date d"acquisition ; Valeur d"origine ; Déduc. Invest. ;SURTITRE');
             ListeValeur.Insert(4,'3;0.8;0.8;0.8;0.8;0.8');
          end;
     if Relance then
       begin
           try
             result:=ListeEdition;
            // ExportDonnees(ListeEdition,'22','Aquisition_'+E.NomDossier + E.NomExo + '.Txt');
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;



Function EditionDesAcquisitionsL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string;Relance:boolean):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     begin
       Maliste.Add(Compte);
     end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   result:=EditionDesAcquisitionsL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,Relance);
  except
     abort;
  end;
end;

Function EditionDesAcquisitionsL(TypeEdition : integer; Filtre:string;DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string;Relance:boolean):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (filtre)then
     begin
      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
     end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   result:=EditionDesAcquisitionsL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,Relance);
  except
     abort;
  end;
end;

procedure TDataModuleImmos.QuAcquisition_EditionFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListeFilterRecordAcquisition.IndexOf(DataSet.FindField('compte').AsString) <> -1;
  end;

end;


function AppelRecalculGeneralImmos(DemandeConfirmation:boolean):TExceptLGR;
var
Confirmation:boolean;
reference:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
 result.NomModule:='AppelRecalculGeneralImmos';
 result.GestMessageLGR.ModeTrace:=true;
 result.GestMessageLGR.Enregistrement:=true;
 result.NomDossier:=e.NomDossier;

//result.retour:=true;
Result.NumErreur:=7000;

// //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
////if ((e.TypeClient=cl_isa)and(Type_version_execution=CT_DEVELOPPEMENT)) then
//// confirmation:=not e.ExerciceCloture
////else
 confirmation:=((not e.ExerciceCloture)and(GEstDossierExerciceEnCoursCloturable(E)));
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg('Voulez-vous recalculer l''amortissement de toutes vos '+#13+#10+'immobilisations ?', mtWarning, [mbYes,mbNo], 0) = mrYes;
//recalculer l'amortissement de toutes les immos existantes
result.retour:= not VerificationSiPieceDeDotation(reference);
if ((result.retour=false)and(confirmation)) then
  begin
    try
    if DemandeConfirmation then
      raise ExceptLGR.Create('La pièce de dotation aux amortissements a été passée, le calcul ne peut pas s''effectuer',result.NumErreur,DemandeConfirmation,mtError,Result);
    except
    end;
  end;
if ((Confirmation)and(result.retour)) then
  begin
      if DataModuleImmos = nil then DataModuleImmos := TDataModuleImmos.Create(Application.MainForm);
      PatienterAffich;
      DataModuleImmos.GestionAccesImmos;
      DeFiltrageDataSet(DataModuleImmos.TaImmosRecalcul);
      DataModuleImmos.TaImmosRecalcul.Refresh;
      if DataModuleImmos.RecalculGeneralAmortissement(DataModuleImmos.TaImmosRecalcul,false,e.DatExoDebut,e.DatExoFin) then
        begin
        if DemandeConfirmation then
          showmessage('le recalcul est terminé.');
        end;
      DataModuleImmos.TaImmosRecalcul.Refresh;
  end;
result.retour:=true;
except
  //Messagebox(0,Pchar(ErrInterne+' : Le calcul ne s"est pas déroulé correctement, contactez le service maintenance !'),Pchar(ErrInterne),0);
  result.retour:=false;
end;
finally
      try
      if (result.retour=false) then
          raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
      except
      end;
PatienterFermer;
 result.GestMessageLGR.Enregistrement:=false;
 result.GestMessageLGR.ModeTrace:=true;
end;
end;


Function EditionPMValuesFiscalesL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Relance:boolean;Synthese:boolean):TStringList;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
listeEdition:TStringList;
compteTmp,libelle:string;
TotalResiduel,TotalCession,TotalPlusMoinsValues,TotalFCourtTerme,TotalFLongTerme,TotalCCourtTerme,TotalCLongTerme:currency;
TotalResiduelCompte,TotalCessionCompte,TotalPlusMoinsValuesCompte,TotalFCourtTermeCompte,TotalFLongTermeCompte,
TotalCCourtTermeCompte,TotalCLongTermeCompte:currency;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalResiduel:=0;
TotalCession:=0;
TotalPlusMoinsValues:=0;
TotalFCourtTerme:=0;
TotalFLongTerme:=0;
TotalCCourtTerme:=0;
TotalCLongTerme:=0;

TotalResiduelCompte:=0;
TotalCessionCompte:=0;
TotalPlusMoinsValuesCompte:=0;
TotalFCourtTermeCompte:=0;
TotalFLongTermeCompte:=0;
TotalCCourtTermeCompte:=0;
TotalCLongTermeCompte:=0;

compteTmp:='';
libelle:='';
  if ((DemandePeriode) and(not relance)) then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    listeEdition:=TStringList.Create;
    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    Initialise_TStringlist(DataModuleImmos.ListeFilterRecordAcquisition,nil,false);
    DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DataModuleImmos.ListeFilterRecordAcquisition.clear;
        if (Compte<>nil)and(compte.Count=0)then abort;
        if Compte<>nil then      // Tous les Comptes
         begin
           TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
           DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
           DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues;
         end
        else
          begin //on filtre au moins les comptes 13
            DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues;
            TitreCompte:='Tous les comptes ';
          end;

          DataModuleImmos.QuImmosEditionModifiable.SQL.Clear;
          if e.ExerciceCloture then
            DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from "'+IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos" ')
          else
            DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from immos ');
          DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' where ((Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') and (Cession_Dans_Annee=true)and (Terminee=false))');
          DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' order by compte');
          DataModuleImmos.InitFiltrePlusOuMoinsValues(DataModuleImmos.QuImmosEditionModifiable);
          DataModuleImmos.QuImmosEditionModifiable.Open;

          DataModuleImmos.QuImmosEditionModifiable.First;
          if DataModuleImmos.QuImmosEditionModifiable.recordcount<>0 then
          begin

          while not DataModuleImmos.QuImmosEditionModifiable.Eof do
            begin
            if compteTmp<>DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString then
              begin
                if compteTmp<>'' then
                  begin
                     ListeValeur.Add('1;;; @Total compte '+GereLibelle(compteTmp)+' :  ;'+E.FormatCurrSansDevise(TotalResiduelCompte) +';'+E.FormatCurrSansDevise(TotalCessionCompte)+';'+E.FormatCurrSansDevise(TotalPlusMoinsValuesCompte)
                     +';'+E.FormatCurrSansDevise(TotalFCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalFLongTermeCompte)+';'+E.FormatCurrSansDevise(TotalCCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalCLongTermeCompte));
                     DetermineSolde(TotalFCourtTermeCompte,TotalFLongTermeCompte);
                     DetermineSolde(TotalCCourtTermeCompte,TotalCLongTermeCompte);
                     ListeValeur.Add('1;;;;;@Plus/Moins Values Nettes compte '+compteTmp+' : ;'+E.FormatCurrSansDevise(TotalPlusMoinsValuesCompte)+';'+E.FormatCurrSansDevise(TotalFCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalFLongTermeCompte)+';'+E.FormatCurrSansDevise(TotalCCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalCLongTermeCompte));
                     TotalResiduelCompte:=0;
                     TotalCessionCompte:=0;
                     TotalPlusMoinsValuesCompte:=0;
                     TotalFCourtTermeCompte:=0;
                     TotalFLongTermeCompte:=0;
                     TotalCCourtTermeCompte:=0;
                     TotalCLongTermeCompte:=0;
                  end;
                compteTmp:=DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString;
                libelle:=DMPlan.LibelleDuNumCpt(compteTmp);
                if not Synthese then  ListeValeur.Add('9; Compte : '+GereLibelle(compteTmp)+' - '+GereLibelle(libelle));
              end;
                  if(not Synthese) then
                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('CodeLong').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Libelle').AsString)+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_res').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_cession').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('plusvalue').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('PVCourtTerme').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('MVCourtTerme').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('PVLongTerme').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('MVLongTerme').AsString
                                   );
                   TotalResiduel:=TotalResiduel+DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_res').AsCurrency;
                   TotalCession:=TotalCession+DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_cession').AsCurrency;
                   TotalPlusMoinsValues:=TotalPlusMoinsValues+DataModuleImmos.QuImmosEditionModifiable.FindField('plusvalue').AsCurrency;
                   TotalFCourtTerme:=TotalFCourtTerme+DataModuleImmos.QuImmosEditionModifiable.FindField('PVCourtTerme').AsCurrency;
                   TotalFLongTerme:=TotalFLongTerme+DataModuleImmos.QuImmosEditionModifiable.FindField('MVCourtTerme').AsCurrency;
                   TotalCCourtTerme:=TotalCCourtTerme+DataModuleImmos.QuImmosEditionModifiable.FindField('PVLongTerme').AsCurrency;
                   TotalCLongTerme:=TotalCLongTerme+DataModuleImmos.QuImmosEditionModifiable.FindField('MVLongTerme').AsCurrency;

                   TotalResiduelCompte:=TotalResiduelCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_res').AsCurrency;
                   TotalCessionCompte:=TotalCessionCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_cession').AsCurrency;
                   TotalPlusMoinsValuesCompte:=TotalPlusMoinsValuesCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('plusvalue').AsCurrency;
                   TotalFCourtTermeCompte:=TotalFCourtTermeCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('PVCourtTerme').AsCurrency;
                   TotalFLongTermeCompte:=TotalFLongTermeCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('MVCourtTerme').AsCurrency;
                   TotalCCourtTermeCompte:=TotalCCourtTermeCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('PVLongTerme').AsCurrency;
                   TotalCLongTermeCompte:=TotalCLongTermeCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('MVLongTerme').AsCurrency;

                   DataModuleImmos.QuImmosEditionModifiable.Next;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
             ListeValeur.Add('1;;; @Total compte '+GereLibelle(compteTmp)+' :  ;'+E.FormatCurrSansDevise(TotalResiduelCompte) +';'+E.FormatCurrSansDevise(TotalCessionCompte)+';'+E.FormatCurrSansDevise(TotalPlusMoinsValuesCompte)
             +';'+E.FormatCurrSansDevise(TotalFCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalFLongTermeCompte)+';'+E.FormatCurrSansDevise(TotalCCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalCLongTermeCompte));
             DetermineSolde(TotalFCourtTermeCompte,TotalFLongTermeCompte);
             DetermineSolde(TotalCCourtTermeCompte,TotalCLongTermeCompte);
             ListeValeur.Add('1;;;;;@Plus/Moins Values Nettes compte '+GereLibelle(compteTmp)+' : ;'+E.FormatCurrSansDevise(TotalPlusMoinsValuesCompte)+';'+E.FormatCurrSansDevise(TotalFCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalFLongTermeCompte)+';'+E.FormatCurrSansDevise(TotalCCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalCLongTermeCompte));
             ListeValeur.Add('1;;; @TOTAL :  ;'+E.FormatCurrSansDevise(TotalResiduel) +';'+E.FormatCurrSansDevise(TotalCession)+';'+E.FormatCurrSansDevise(TotalPlusMoinsValues)
             +';'+E.FormatCurrSansDevise(TotalFCourtTerme)+';'+E.FormatCurrSansDevise(TotalFLongTerme)+';'+E.FormatCurrSansDevise(TotalCCourtTerme)+';'+E.FormatCurrSansDevise(TotalCLongTerme));

             DetermineSolde(TotalFCourtTerme,TotalFLongTerme);
             DetermineSolde(TotalCCourtTerme,TotalCLongTerme);
             ListeValeur.Add('1;;;;;@Plus/Moins Values Nettes : ;'+E.FormatCurrSansDevise(TotalPlusMoinsValues)+';'+E.FormatCurrSansDevise(TotalFCourtTerme)+';'+E.FormatCurrSansDevise(TotalFLongTerme)+';'+E.FormatCurrSansDevise(TotalCCourtTerme)+';'+E.FormatCurrSansDevise(TotalCLongTerme));
             listeEdition.Add('9WM;Compte;Debit;Credit');
             listeEdition.Add('9WM;Tous;'+CurrToStr_Lgr(TotalCLongTerme,'0','0')+';0');
             ObjPrn.FTitreEdition := 'PLUS ET MOINS VALUES FISCALES ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

             ListeValeur.Insert(0,'; Code ;Désignation ;;;; C/terme ; C/Terme ; L/terme ; L/Terme ');
             ListeValeur.Insert(1,'0.6;0.4;0.9;0.8;0.8;0.8;0.8;0.8;0.8;0.8');
             ListeValeur.Insert(2,'texte;texte;texte;curr;curr;curr;curr;curr;curr;curr');
             ListeValeur.Insert(3,' Compte ; Immobilisation ; Mt/résiduel ; Mt/Cession ; P/M Values ; P/Value ; M/Value ; P/Value ; M/Value ;SURTITRE');
             ListeValeur.Insert(4,'0.6;1.3;0.8;0.8;0.8;0.8;0.8;0.8;0.8');
          end;
          if(relance)then
            result:=ListeEdition
          else
          ObjPrn.AffichageImp(ListeValeur);

  end;//fin du periode.retour
  finally
     DefiltrageDataset(DataModuleImmos.QuImmosEditionModifiable);
     DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
     DataModuleImmos.ListeFilterRecordAcquisition.clear;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
  end;
end;

Function EditionPMValuesFiscalesL3Chiffres(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Relance:boolean;Synthese:boolean):TStringList;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
listeEdition:TStringList;
compteTmp,libelle:string;
TotalResiduel,TotalCession,TotalPlusMoinsValues,TotalFCourtTerme,TotalFLongTerme,TotalCCourtTerme,TotalCLongTerme:currency;
TotalResiduelCompte,TotalCessionCompte,TotalPlusMoinsValuesCompte,TotalFCourtTermeCompte,TotalFLongTermeCompte,
TotalCCourtTermeCompte,TotalCLongTermeCompte:currency;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalResiduel:=0;
TotalCession:=0;
TotalPlusMoinsValues:=0;
TotalFCourtTerme:=0;
TotalFLongTerme:=0;
TotalCCourtTerme:=0;
TotalCLongTerme:=0;

TotalResiduelCompte:=0;
TotalCessionCompte:=0;
TotalPlusMoinsValuesCompte:=0;
TotalFCourtTermeCompte:=0;
TotalFLongTermeCompte:=0;
TotalCCourtTermeCompte:=0;
TotalCLongTermeCompte:=0;

compteTmp:='';
libelle:='';
  if ((DemandePeriode) and(not relance)) then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    listeEdition:=TStringList.Create;
    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    Initialise_TStringlist(DataModuleImmos.ListeFilterRecordAcquisition,nil,false);
    DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DataModuleImmos.ListeFilterRecordAcquisition.clear;
        if (Compte<>nil)and(compte.Count=0)then abort;
        if Compte<>nil then      // Tous les Comptes
         begin
           TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
           DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
           DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues;
         end
        else
          begin //on filtre au moins les comptes 13
            DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues;
            TitreCompte:='Tous les comptes ';
          end;

          DataModuleImmos.QuImmosEditionModifiable.SQL.Clear;
          if e.ExerciceCloture then
            DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from "'+IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos" ')
          else
            DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from immos ');
          DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' where ((Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') and (Cession_Dans_Annee=true)and (Terminee=false))');
          DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' order by compte');
          DataModuleImmos.InitFiltrePlusOuMoinsValues(DataModuleImmos.QuImmosEditionModifiable);
          DataModuleImmos.QuImmosEditionModifiable.Open;

          DataModuleImmos.QuImmosEditionModifiable.First;
          if DataModuleImmos.QuImmosEditionModifiable.recordcount<>0 then
          begin

          while not DataModuleImmos.QuImmosEditionModifiable.Eof do
            begin
            if compteTmp<>str_n_prem_char(DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString,3) then
              begin
                if compteTmp<>'' then
                  begin
                     ListeValeur.Add('1;;; @Total compte '+GereLibelle(compteTmp)+' :  ;'+E.FormatCurrSansDevise(TotalResiduelCompte) +';'+E.FormatCurrSansDevise(TotalCessionCompte)+';'+E.FormatCurrSansDevise(TotalPlusMoinsValuesCompte)
                     +';'+E.FormatCurrSansDevise(TotalFCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalFLongTermeCompte)+';'+E.FormatCurrSansDevise(TotalCCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalCLongTermeCompte));
                     DetermineSolde(TotalFCourtTermeCompte,TotalFLongTermeCompte);
                     DetermineSolde(TotalCCourtTermeCompte,TotalCLongTermeCompte);
                     ListeValeur.Add('1;;;;;@Plus/Moins Values Nettes compte '+GereLibelle(compteTmp)+' : ;'+E.FormatCurrSansDevise(TotalPlusMoinsValuesCompte)+';'+E.FormatCurrSansDevise(TotalFCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalFLongTermeCompte)+';'+E.FormatCurrSansDevise(TotalCCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalCLongTermeCompte));
                     TotalResiduelCompte:=0;
                     TotalCessionCompte:=0;
                     TotalPlusMoinsValuesCompte:=0;
                     TotalFCourtTermeCompte:=0;
                     TotalFLongTermeCompte:=0;
                     TotalCCourtTermeCompte:=0;
                     TotalCLongTermeCompte:=0;
                  end;
                compteTmp:=str_n_prem_char(DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString,3);
//                compteTmp:=DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString;
                libelle:=DMPlan.LibelleDuNumCpt(compteTmp);
                if not Synthese then  ListeValeur.Add('9; Compte : '+GereLibelle(compteTmp)+' - '+GereLibelle(libelle));
              end;
                  if(not Synthese) then
                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('CodeLong').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Libelle').AsString)+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_res').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_cession').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('plusvalue').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('PVCourtTerme').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('MVCourtTerme').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('PVLongTerme').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('MVLongTerme').AsString
                                   );
                   TotalResiduel:=TotalResiduel+DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_res').AsCurrency;
                   TotalCession:=TotalCession+DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_cession').AsCurrency;
                   TotalPlusMoinsValues:=TotalPlusMoinsValues+DataModuleImmos.QuImmosEditionModifiable.FindField('plusvalue').AsCurrency;
                   TotalFCourtTerme:=TotalFCourtTerme+DataModuleImmos.QuImmosEditionModifiable.FindField('PVCourtTerme').AsCurrency;
                   TotalFLongTerme:=TotalFLongTerme+DataModuleImmos.QuImmosEditionModifiable.FindField('MVCourtTerme').AsCurrency;
                   TotalCCourtTerme:=TotalCCourtTerme+DataModuleImmos.QuImmosEditionModifiable.FindField('PVLongTerme').AsCurrency;
                   TotalCLongTerme:=TotalCLongTerme+DataModuleImmos.QuImmosEditionModifiable.FindField('MVLongTerme').AsCurrency;

                   TotalResiduelCompte:=TotalResiduelCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_res').AsCurrency;
                   TotalCessionCompte:=TotalCessionCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_cession').AsCurrency;
                   TotalPlusMoinsValuesCompte:=TotalPlusMoinsValuesCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('plusvalue').AsCurrency;
                   TotalFCourtTermeCompte:=TotalFCourtTermeCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('PVCourtTerme').AsCurrency;
                   TotalFLongTermeCompte:=TotalFLongTermeCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('MVCourtTerme').AsCurrency;
                   TotalCCourtTermeCompte:=TotalCCourtTermeCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('PVLongTerme').AsCurrency;
                   TotalCLongTermeCompte:=TotalCLongTermeCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('MVLongTerme').AsCurrency;

                   DataModuleImmos.QuImmosEditionModifiable.Next;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
             ListeValeur.Add('1;;; @Total compte '+GereLibelle(compteTmp)+' :  ;'+E.FormatCurrSansDevise(TotalResiduelCompte) +';'+E.FormatCurrSansDevise(TotalCessionCompte)+';'+E.FormatCurrSansDevise(TotalPlusMoinsValuesCompte)
             +';'+E.FormatCurrSansDevise(TotalFCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalFLongTermeCompte)+';'+E.FormatCurrSansDevise(TotalCCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalCLongTermeCompte));
             DetermineSolde(TotalFCourtTermeCompte,TotalFLongTermeCompte);
             DetermineSolde(TotalCCourtTermeCompte,TotalCLongTermeCompte);
             ListeValeur.Add('1;;;;;@Plus/Moins Values Nettes compte '+GereLibelle(compteTmp)+' : ;'+E.FormatCurrSansDevise(TotalPlusMoinsValuesCompte)+';'+E.FormatCurrSansDevise(TotalFCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalFLongTermeCompte)+';'+E.FormatCurrSansDevise(TotalCCourtTermeCompte)+';'+E.FormatCurrSansDevise(TotalCLongTermeCompte));
             ListeValeur.Add('1;;; @TOTAL :  ;'+E.FormatCurrSansDevise(TotalResiduel) +';'+E.FormatCurrSansDevise(TotalCession)+';'+E.FormatCurrSansDevise(TotalPlusMoinsValues)
             +';'+E.FormatCurrSansDevise(TotalFCourtTerme)+';'+E.FormatCurrSansDevise(TotalFLongTerme)+';'+E.FormatCurrSansDevise(TotalCCourtTerme)+';'+E.FormatCurrSansDevise(TotalCLongTerme));

             DetermineSolde(TotalFCourtTerme,TotalFLongTerme);
             DetermineSolde(TotalCCourtTerme,TotalCLongTerme);
             ListeValeur.Add('1;;;;;@Plus/Moins Values Nettes : ;'+E.FormatCurrSansDevise(TotalPlusMoinsValues)+';'+E.FormatCurrSansDevise(TotalFCourtTerme)+';'+E.FormatCurrSansDevise(TotalFLongTerme)+';'+E.FormatCurrSansDevise(TotalCCourtTerme)+';'+E.FormatCurrSansDevise(TotalCLongTerme));
             listeEdition.Add('9WM;Compte;Debit;Credit');
             listeEdition.Add('9WM;Tous;'+CurrToStr_Lgr(TotalCLongTerme,'0','0')+';0');
             ObjPrn.FTitreEdition := 'PLUS ET MOINS VALUES FISCALES ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

             ListeValeur.Insert(0,'; Code ;Désignation ;;;; C/terme ; C/Terme ; L/terme ; L/Terme ');
             ListeValeur.Insert(1,'0.6;0.4;0.9;0.8;0.8;0.8;0.8;0.8;0.8;0.8');
             ListeValeur.Insert(2,'texte;texte;texte;curr;curr;curr;curr;curr;curr;curr');
             ListeValeur.Insert(3,' Compte ; Immobilisation ; Mt/résiduel ; Mt/Cession ; P/M Values ; P/Value ; M/Value ; P/Value ; M/Value ;SURTITRE');
             ListeValeur.Insert(4,'0.6;1.3;0.8;0.8;0.8;0.8;0.8;0.8;0.8');
          end;
          if(relance)then
            result:=ListeEdition
          else
          ObjPrn.AffichageImp(ListeValeur);

  end;//fin du periode.retour
  finally
     DefiltrageDataset(DataModuleImmos.QuImmosEditionModifiable);
     DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
     DataModuleImmos.ListeFilterRecordAcquisition.clear;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
  end;
end;


Function EditionPMValuesFiscalesL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string;Relance:boolean;Synthese:boolean):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   result:=EditionPMValuesFiscalesL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,relance,Synthese);
  except
     abort;
  end;
end;

Function EditionPMValuesFiscalesL3Chiffres(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string;Relance:boolean;Synthese:boolean):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   result:=EditionPMValuesFiscalesL3Chiffres(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,relance,Synthese);
  except
     abort;
  end;
end;

procedure TDataModuleImmos.QuImmosEditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListeFilterRecordAcquisition.IndexOf(DataSet.FindField('compte').AsString) <> -1;
  end;
end;

procedure TDataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    if ((ListeFilterRecordAcquisition<> nil)and(ListeFilterRecordAcquisition.count<>0)) then
      accept:=ListeFilterRecordAcquisition.IndexOf(DataSet.FindField('compte').AsString) <> -1;
    if accept then accept:=copy(DataSet.FindField('compte').AsString,1,2)<>'13';
  end;
end;


Function EditionPMValuesComptablesL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Synthese:boolean):Boolean;
var
periode:TPeriode;
i,Deuxieme:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
compteTmp,libelle:string;
cumul:currency;
TotalBase,TotalCumule,TotalResiduel,TotalCession,
TotalPMValuesComptables,TotalVenale,TotalForfait,TotalReel,ValeurForfait:currency;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
TotalBaseCompte,TotalCumuleCompte,TotalResiduelCompte,TotalCessionCompte,
TotalPMValuesComptablesCompte:currency;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalBase:=0;
TotalCumule:=0;
TotalResiduel:=0;
TotalCession:=0;
TotalPMValuesComptables:=0;
TotalVenale:=0;
TotalForfait:=0;
TotalReel:=0;
ValeurForfait:=0;

TotalBaseCompte:=0;
TotalCumuleCompte:=0;
TotalResiduelCompte:=0;
TotalCessionCompte:=0;
TotalPMValuesComptablesCompte:=0;


compteTmp:='';
libelle:='';

  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    Initialise_TStringlist(DataModuleImmos.ListeFilterRecordAcquisition,nil,false);
    DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DataModuleImmos.ListeFilterRecordAcquisition.clear;
        if (Compte<>nil)and(compte.Count=0)then abort;
        
        if Compte<>nil then      // Tous les Comptes
         begin
          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
          DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
          DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues;
         end
        else
          begin //on filtre les comptes 13
            DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues;
            TitreCompte:='Tous les comptes';
          end;

          DataModuleImmos.QuImmosEditionModifiable.SQL.Clear;
          if e.ExerciceCloture then
            DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from "'+IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos" ')
          else
            DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from immos ');
          DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' where ((Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') and (Cession_Dans_Annee=true) and (Terminee=false))');
          DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' order by compte');
          DataModuleImmos.InitFiltrePlusOuMoinsValues(DataModuleImmos.QuImmosEditionModifiable);
          DataModuleImmos.QuImmosEditionModifiable.Open;

          DataModuleImmos.QuImmosEditionModifiable.First;
          Deuxieme:=0;
          if DataModuleImmos.QuImmosEditionModifiable.recordcount<>0 then
          begin
          while not DataModuleImmos.QuImmosEditionModifiable.Eof do
            begin
            if compteTmp<>DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString then
              begin
                if compteTmp<>'' then
                  begin
                     ListeValeur.Add('1;;; @Total compte '+GereLibelle(compteTmp)+' - '+GereLibelle(libelle)+' :  ;'+E.FormatCurrSansDevise(TotalBaseCompte) +';'+E.FormatCurrSansDevise(TotalCumuleCompte)+';'+E.FormatCurrSansDevise(TotalResiduelCompte)
                     +';'+E.FormatCurrSansDevise(TotalCessionCompte)+';'+E.FormatCurrSansDevise(TotalPMValuesComptablesCompte));
                     TotalBaseCompte:=0;
                     TotalCumuleCompte:=0;
                     TotalResiduelCompte:=0;
                     TotalCessionCompte:=0;
                     TotalPMValuesComptablesCompte:=0;
                  end;
                compteTmp:=DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString;
                libelle:=DMPlan.LibelleDuNumCpt(compteTmp);
                if not Synthese then  ListeValeur.Add('9; Compte : '+GereLibelle(compteTmp)+' - '+GereLibelle(libelle));
              end;

            cumul:=(DataModuleImmos.QuImmosEditionModifiable.FindField('amort_Eco').Ascurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('eco').Ascurrency);
                  if(not Synthese) then
                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('CodeLong').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Libelle').AsString)+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise(cumul)+
                                   ';'+
                                   E.FormatCurrSansDevise(DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul)+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise((DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').Ascurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul)))
                                   );
                TotalBaseCompte:=TotalBaseCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency;
                TotalCessionCompte:=TotalCessionCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').AsCurrency;
                TotalCumuleCompte:=TotalCumuleCompte+cumul;
                TotalResiduelCompte:=TotalResiduelCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul;
                TotalPMValuesComptablesCompte:=TotalPMValuesComptablesCompte+(DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').Ascurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul));


                TotalBase:=TotalBase+DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency;
                TotalCession:=TotalCession+DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').AsCurrency;
                TotalCumule:=TotalCumule+cumul;
                TotalResiduel:=TotalResiduel+DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul;
                TotalPMValuesComptables:=TotalPMValuesComptables+(DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').Ascurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul));
                inc(Deuxieme);
                DataModuleImmos.QuImmosEditionModifiable.Next;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
             ListeValeur.Add('1;;; @Total compte '+GereLibelle(compteTmp)+' - '+GereLibelle(libelle)+' :  ;'+E.FormatCurrSansDevise(TotalBaseCompte) +';'+E.FormatCurrSansDevise(TotalCumuleCompte)+';'+E.FormatCurrSansDevise(TotalResiduelCompte)
             +';'+E.FormatCurrSansDevise(TotalCessionCompte)+';'+E.FormatCurrSansDevise(TotalPMValuesComptablesCompte));
             ListeValeur.Add('1;;; @TOTAL :  ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalCumule)+';'+E.FormatCurrSansDevise(TotalResiduel)
             +';'+E.FormatCurrSansDevise(TotalCession)+';'+E.FormatCurrSansDevise(TotalPMValuesComptables));
             ObjPrn.FTitreEdition := 'PLUS ET MOINS VALUES COMPTABLES ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;

             ListeValeur.Insert(0,'; Code ; Désignation ; Amort. ; Cumulé ; Residuelle ; Cession ; comptable ');
             ListeValeur.Insert(1,'0.6;0.4;2;0.8;0.8;0.8;0.8;0.8');
             ListeValeur.Insert(2,'texte;texte;texte;curr;curr;curr;curr;curr');
             ListeValeur.Insert(3,' Compte ; Immobilisation ; Base ; Amort. ; Valeur ; Montant; P/M Value ;SURTITRE');
             ListeValeur.Insert(4,'0.6;2.4;0.8;0.8;0.8;0.8;0.8');
          end;
     ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
  finally
     DefiltrageDataset(DataModuleImmos.QuImmosEditionModifiable);
     DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
     DataModuleImmos.ListeFilterRecordAcquisition.clear;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
  end;
end;


Function EditionPMValuesComptablesL3Chiffres(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Synthese:boolean):Boolean;
var
periode:TPeriode;
i,Deuxieme:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
compteTmp,libelle:string;
cumul:currency;
TotalBase,TotalCumule,TotalResiduel,TotalCession,
TotalPMValuesComptables,TotalVenale,TotalForfait,TotalReel,ValeurForfait:currency;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
TotalBaseCompte,TotalCumuleCompte,TotalResiduelCompte,TotalCessionCompte,
TotalPMValuesComptablesCompte:currency;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalBase:=0;
TotalCumule:=0;
TotalResiduel:=0;
TotalCession:=0;
TotalPMValuesComptables:=0;
TotalVenale:=0;
TotalForfait:=0;
TotalReel:=0;
ValeurForfait:=0;

TotalBaseCompte:=0;
TotalCumuleCompte:=0;
TotalResiduelCompte:=0;
TotalCessionCompte:=0;
TotalPMValuesComptablesCompte:=0;


compteTmp:='';
libelle:='';

  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    Initialise_TStringlist(DataModuleImmos.ListeFilterRecordAcquisition,nil,false);
    DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DataModuleImmos.ListeFilterRecordAcquisition.clear;
        if (Compte<>nil)and(compte.Count=0)then abort;
        if Compte<>nil then      // Tous les Comptes
         begin
          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
          DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
          DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues;
         end
        else
          begin //on filtre les comptes 13
            DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecordPlusOuMoinsValues;
            TitreCompte:='Tous les comptes';
          end;

          DataModuleImmos.QuImmosEditionModifiable.SQL.Clear;
          if e.ExerciceCloture then
            DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from "'+IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos" ')
          else
            DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from immos ');
          DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' where ((Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''') and (Cession_Dans_Annee=true) and (Terminee=false))');
          DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' order by compte');
          DataModuleImmos.InitFiltrePlusOuMoinsValues(DataModuleImmos.QuImmosEditionModifiable);
          DataModuleImmos.QuImmosEditionModifiable.Open;

          DataModuleImmos.QuImmosEditionModifiable.First;
          Deuxieme:=0;
          if DataModuleImmos.QuImmosEditionModifiable.recordcount<>0 then
          begin
          while not DataModuleImmos.QuImmosEditionModifiable.Eof do
            begin
            if compteTmp<>str_n_prem_char(DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString,3) then
              begin
                if compteTmp<>'' then
                  begin
                     ListeValeur.Add('1;;; @Total compte '+GereLibelle(compteTmp)+' - '+GereLibelle(libelle)+' :  ;'+E.FormatCurrSansDevise(TotalBaseCompte) +';'+E.FormatCurrSansDevise(TotalCumuleCompte)+';'+E.FormatCurrSansDevise(TotalResiduelCompte)
                     +';'+E.FormatCurrSansDevise(TotalCessionCompte)+';'+E.FormatCurrSansDevise(TotalPMValuesComptablesCompte));
                     TotalBaseCompte:=0;
                     TotalCumuleCompte:=0;
                     TotalResiduelCompte:=0;
                     TotalCessionCompte:=0;
                     TotalPMValuesComptablesCompte:=0;
                  end;
                compteTmp:=str_n_prem_char(DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString,3);
                libelle:=DMPlan.LibelleDuNumCpt(compteTmp);
                if not Synthese then  ListeValeur.Add('9; Compte : '+GereLibelle(compteTmp)+' - '+GereLibelle(libelle));
              end;

            cumul:=(DataModuleImmos.QuImmosEditionModifiable.FindField('amort_Eco').Ascurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('eco').Ascurrency);
                  if(not Synthese) then
                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('CodeLong').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Libelle').AsString)+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise(cumul)+
                                   ';'+
                                   E.FormatCurrSansDevise(DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul)+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise((DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').Ascurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul)))
                                   );
                TotalBaseCompte:=TotalBaseCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency;
                TotalCessionCompte:=TotalCessionCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').AsCurrency;
                TotalCumuleCompte:=TotalCumuleCompte+cumul;
                TotalResiduelCompte:=TotalResiduelCompte+DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul;
                TotalPMValuesComptablesCompte:=TotalPMValuesComptablesCompte+(DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').Ascurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul));


                TotalBase:=TotalBase+DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency;
                TotalCession:=TotalCession+DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').AsCurrency;
                TotalCumule:=TotalCumule+cumul;
                TotalResiduel:=TotalResiduel+DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul;
                TotalPMValuesComptables:=TotalPMValuesComptables+(DataModuleImmos.QuImmosEditionModifiable.FindField('Mt_Cession').Ascurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('valeur_A_Amortir').Ascurrency-cumul));
                inc(Deuxieme);
                DataModuleImmos.QuImmosEditionModifiable.Next;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
             ListeValeur.Add('1;;; @Total compte '+GereLibelle(compteTmp)+' - '+GereLibelle(libelle)+' :  ;'+E.FormatCurrSansDevise(TotalBaseCompte) +';'+E.FormatCurrSansDevise(TotalCumuleCompte)+';'+E.FormatCurrSansDevise(TotalResiduelCompte)
             +';'+E.FormatCurrSansDevise(TotalCessionCompte)+';'+E.FormatCurrSansDevise(TotalPMValuesComptablesCompte));
             ListeValeur.Add('1;;; @TOTAL :  ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalCumule)+';'+E.FormatCurrSansDevise(TotalResiduel)
             +';'+E.FormatCurrSansDevise(TotalCession)+';'+E.FormatCurrSansDevise(TotalPMValuesComptables));
             ObjPrn.FTitreEdition := 'PLUS ET MOINS VALUES COMPTABLES ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;

             ListeValeur.Insert(0,'; Code ; Désignation ; Amort. ; Cumulé ; Residuelle ; Cession ; comptable ');
             ListeValeur.Insert(1,'0.6;0.4;2;0.8;0.8;0.8;0.8;0.8');
             ListeValeur.Insert(2,'texte;texte;texte;curr;curr;curr;curr;curr');
             ListeValeur.Insert(3,' Compte ; Immobilisation ; Base ; Amort. ; Valeur ; Montant; P/M Value ;SURTITRE');
             ListeValeur.Insert(4,'0.6;2.4;0.8;0.8;0.8;0.8;0.8');
          end;
     ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
  finally
     DefiltrageDataset(DataModuleImmos.QuImmosEditionModifiable);
     DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
     DataModuleImmos.ListeFilterRecordAcquisition.clear;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
  end;
end;



Function EditionPMValuesComptablesL3Chiffres(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string;Synthese:boolean):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionPMValuesComptablesL3Chiffres(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,Synthese);
  except
     abort;
  end;
end;

Function EditionPMValuesComptablesL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string;Synthese:boolean):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionPMValuesFiscalesL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,Synthese);
  except
     abort;
  end;
end;


Function EditionTableauDesAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Derogatoire:boolean;Detail:boolean):Boolean;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
compteTmp:string;
Derog:currency;
TotalExercice,TotalExerciceCumule,TotalBase,TotalCumule,TotalCumulDerog,TotalNetteEco,TotalNetteFiscale,TotalEco,TotalDerog:currency;
ValeurNetteEco,ValeurNetteFiscale,AmortCumul,DerogCumul:currency;
//Vendu
TotalExerciceVendu,TotalExerciceCumulVendu,TotalAcquiVendu,TotalEcoVendu,TotalDerogVendu,TotalCumulVendu,TotalCumulDerogVendu,TotalNetteEcoVendu,TotalNetteFiscaleVendu:currency;
TotalGExerciceVendu,TotalGExerciceCumulVendu,TotalGVendu,TotalGEcoVendu,TotalGDerogVendu,TotalGCumulVendu,TotalGCumulDerogVendu,TotalGNetteEcoVendu,TotalGNetteFiscaleVendu:currency;
///
TotalGExercice,TotalGExerciceCumul,TotalGEco,TotalGDerog,TotalGCumulEco,TotalGCumulDerog,TotalGNetteEco,TotalGNetteFiscale,TotalGAvantCession:currency;
Compteur:integer;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
immos:TAmortImmo;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
ValeurNetteEco:=0;
ValeurNetteFiscale:=0;

AmortCumul:=0;
DerogCumul:=0;
Derog:=0;

TotalBase:=0;
TotalExercice:=0;//*
TotalExerciceCumule:=0;//*
TotalEco:=0;
TotalCumule:=0;
TotalDerog:=0;
TotalCumulDerog:=0;
TotalNetteEco:=0;
TotalNetteFiscale:=0;

TotalAcquiVendu:=0;
TotalExerciceVendu:=0;//*
TotalExerciceCumulVendu:=0;//*
TotalEcoVendu:=0;
TotalCumulVendu:=0;
TotalDerogVendu:=0;
TotalCumulDerogVendu:=0;
TotalNetteEcoVendu:=0;
TotalNetteFiscaleVendu:=0;

TotalGAvantCession:=0;
TotalGExercice:=0;//*
TotalGExerciceCumul:=0;//*
TotalGEco:=0;
TotalGCumulEco:=0;
TotalGDerog:=0;
TotalGCumulDerog:=0;
TotalGNetteEco:=0;
TotalGNetteFiscale:=0;

TotalGVendu:=0;
TotalGExerciceVendu:=0;//*
TotalGExerciceCumulVendu:=0;//*
TotalGEcoVendu:=0;
TotalGCumulVendu:=0;
TotalGDerogVendu:=0;
TotalGCumulDerogVendu:=0;
TotalGNetteEcoVendu:=0;
TotalGNetteFiscaleVendu:=0;

Compteur:=0;

  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin
    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    Initialise_TStringlist(DataModuleImmos.ListeFilterRecordAcquisition,nil,false);
    DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        if (Compte<>nil)and(compte.Count=0)then abort;
        if Compte<>nil then      // Tous les Comptes
         begin
          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
          DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
          DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecord;
          DataModuleImmos.QuImmosEditionModifiable.filtered:=true;
         end
        else
          begin
            DataModuleImmos.QuImmosEditionModifiable.OnFilterRecord:=nil;
            TitreCompte:='Tous les comptes ';
          end;
      DataModuleImmos.QuImmosEditionModifiable.SQL.Clear;
      if e.ExerciceCloture then
        DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from "'+IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos" where ')
      else
        DataModuleImmos.QuImmosEditionModifiable.SQL.Add('select * from immos where ');
      DataModuleImmos.QuImmosEditionModifiable.SQL.Add(' Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DataModuleImmos.QuImmosEditionModifiable.SQL.Add('order by compte,Code,sous_code');
      DataModuleImmos.QuImmosEditionModifiable.Open;
      DataModuleImmos.QuImmosEditionModifiable.First;
      if DataModuleImmos.QuImmosEditionModifiable.recordcount<>0 then
      begin
          compteTmp:=DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString;
          ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp) +' - '+ GereLibelle(DMPlan.LibelleDuNumCptPCU(compteTmp )));
     if Derogatoire then
       Begin
          while not DataModuleImmos.QuImmosEditionModifiable.Eof do
            begin
            compteTmp:=DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString;
            ValeurNetteEco:=DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency);
initialiserAmortissement(immos);
immos.Gerer_Derog:=e.Derogatoire;
immos.compte:=DataModuleImmos.QuImmosEditionModifiable.FindField('compte').AsString;
immos.Report_Derog:=DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_Derog').AsCurrency;
immos.Choix:=DataModuleImmos.QuImmosEditionModifiable.FindField('choix').AsCurrency;
immos.EcoRepartition:=DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency;
Derog:=DataModuleImmos.CalculDerogSurImmos(immos).Total;

//            if ((e.Derogatoire)or(((DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_Derog').AsCurrency>0))and(DataModuleImmos.QuImmosEditionModifiable.FindField('Choix').AsCurrency-DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency<0)))then
//              begin
//                if DataModuleImmos.QuImmosEditionModifiable.FindField('Choix').AsCurrency-DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency<0 then
//                begin
//                Derog:=DataModuleImmos.QuImmosEditionModifiable.FindField('Choix').AsCurrency-DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency;
//                if abs(Derog)>DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_Derog').AsCurrency  then
//                  Derog:=DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_Derog').AsCurrency;
//                end;
//              end
//            else
//              derog:=0;
            AmortCumul:=(DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency);
            DerogCumul:=(DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_Derog').AsCurrency+Derog);
            ValeurNetteFiscale:=DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_Derog').AsCurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency+derog);
            if Detail then
                begin
                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('CodeLong').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuImmosEditionModifiable.FindField('Libelle').AsString)+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Date_Achat').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Date_mise_en_service').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Duree_Amt').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Type_Amt').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Date_Cession').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise(DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').Ascurrency+Derog)+
                                   ';'+
                                   E.FormatCurrSansDevise(AmortCumul+DerogCumul)+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise(AmortCumul)+
                                   ';'+
                                   E.FormatCurrSansDevise(Derog)+
                                   ';'+
                                   E.FormatCurrSansDevise(DerogCumul)+
                                   ';'+
                                   E.FormatCurrSansDevise(ValeurNetteEco)+
                                   ';'+
                                   E.FormatCurrSansDevise(ValeurNetteFiscale)
                                   );
                end;//fin si detail
                TotalBase:=TotalBase+DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency;
                TotalExercice:=TotalExercice+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency+Derog;//*
                TotalExerciceCumule:=TotalExerciceCumule+AmortCumul+DerogCumul;//*
                TotalEco:=TotalEco+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency;
                TotalCumule:=TotalCumule+AmortCumul;
                TotalDerog:=TotalDerog+Derog;
                TotalCumulDerog:=TotalCumulDerog+DerogCumul;
                TotalNetteEco:=TotalNetteEco+ValeurNetteEco;
                TotalNetteFiscale:=TotalNetteFiscale+ValeurNetteFiscale;

                if not empty(DataModuleImmos.QuImmosEditionModifiable.FindField('Date_Cession').AsString) then
                  begin
                    TotalAcquiVendu:=TotalAcquiVendu+DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency;;
                    TotalExerciceVendu:=TotalExerciceVendu+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').Ascurrency+Derog;//*
                    TotalExerciceCumulVendu:=TotalExerciceCumulVendu+AmortCumul+DerogCumul;//*
                    TotalEcoVendu:=TotalEcoVendu+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').Ascurrency;
                    TotalCumulVendu:=TotalCumulVendu+AmortCumul;
                    TotalDerogVendu:=TotalDerogVendu+Derog;
                    TotalCumulDerogVendu:=TotalCumulDerogVendu+DerogCumul;
                    TotalNetteEcoVendu:=TotalNetteEcoVendu+ValeurNetteEco;
                    TotalNetteFiscaleVendu:=TotalNetteFiscaleVendu+ValeurNetteFiscale;
                  end;
            Derog:=0;
            AmortCumul:=0;
            DerogCumul:=0;
            
                inc(Compteur);
                DataModuleImmos.QuImmosEditionModifiable.Next;
              if compteTmp<>DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString then
                begin
                  compteTmp:=DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString;
                  if detail then
                    Begin
                        ListeValeur.Add('3;;;;;; @TOTAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase) +'; ;'+E.FormatCurrSansDevise(TotalExercice) +';'+E.FormatCurrSansDevise(TotalExerciceCumule) +';'+E.FormatCurrSansDevise(TotalEco) +';'+E.FormatCurrSansDevise(TotalCumule)+';'+E.FormatCurrSansDevise(TotalDerog)+';'+E.FormatCurrSansDevise(TotalCumulDerog)+';'+E.FormatCurrSansDevise(TotalNetteEco)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
                        ListeValeur.Add('3;;;;;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +'; ;'+E.FormatCurrSansDevise(TotalExerciceVendu) +';'+E.FormatCurrSansDevise(TotalExerciceCumulVendu) +';'+E.FormatCurrSansDevise(TotalEcoVendu) +';'+E.FormatCurrSansDevise(TotalCumulVendu)+';'+E.FormatCurrSansDevise(TotalDerogVendu)+';'+E.FormatCurrSansDevise(TotalCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
                        ListeValeur.Add('3;;;;;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalExerciceCumule-TotalExerciceCumulVendu) +'; ;'+E.FormatCurrSansDevise(TotalCumule-TotalCumulVendu)+'; ;'+E.FormatCurrSansDevise(TotalCumulDerog-TotalCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalNetteEco-TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscale-TotalNetteFiscaleVendu));
                    end
                  else
                    Begin
                        ListeValeur.Add('3;; @TOTAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalExercice) +';'+E.FormatCurrSansDevise(TotalExerciceCumule) +';'+E.FormatCurrSansDevise(TotalEco) +';'+E.FormatCurrSansDevise(TotalCumule)+';'+E.FormatCurrSansDevise(TotalDerog)+';'+E.FormatCurrSansDevise(TotalCumulDerog)+';'+E.FormatCurrSansDevise(TotalNetteEco)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
                        ListeValeur.Add('3;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +';'+E.FormatCurrSansDevise(TotalExerciceVendu) +';'+E.FormatCurrSansDevise(TotalExerciceCumulVendu) +';'+E.FormatCurrSansDevise(TotalEcoVendu) +';'+E.FormatCurrSansDevise(TotalCumulVendu)+';'+E.FormatCurrSansDevise(TotalDerogVendu)+';'+E.FormatCurrSansDevise(TotalCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
                        ListeValeur.Add('3;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu) +'; ;'+E.FormatCurrSansDevise(TotalExerciceCumule-TotalExerciceCumulVendu) +'; ;'+E.FormatCurrSansDevise(TotalCumule-TotalCumulVendu)+'; ;'+E.FormatCurrSansDevise(TotalCumulDerog-TotalCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalNetteEco-TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscale-TotalNetteFiscaleVendu));
                    end;
                  ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp) +' - '+ GereLibelle(DMPlan.LibelleDuNumCptPCU(compteTmp )));

                  TotalGAvantCession:=TotalGAvantCession+TotalBase;
                  TotalGVendu:=TotalGVendu+TotalAcquiVendu;

                  TotalGExercice:=TotalGExercice+TotalEco+TotalDerog;//*
                  TotalGExerciceVendu:=TotalGExerciceVendu+TotalEcoVendu+TotalDerogVendu;//*

                  TotalGExerciceCumul:=TotalGExerciceCumul+TotalCumule+TotalcumulDerog;//*
                  TotalGExerciceCumulVendu:=TotalGExerciceCumulVendu+TotalCumulVendu+TotalCumulDerogVendu;//*

                  TotalGEco:=TotalGEco+TotalEco;
                  TotalGEcoVendu:=TotalGEcoVendu+TotalEcoVendu;

                  TotalGCumulEco:=TotalGCumulEco+TotalCumule;
                  TotalGCumulVendu:=TotalGCumulVendu+TotalCumulVendu;

                  TotalGDerog:=TotalGDerog+TotalDerog;
                  TotalGDerogVendu:=TotalGDerogVendu+TotalDerogVendu;

                  TotalGCumulDerog:=TotalGCumulDerog+TotalcumulDerog;
                  TotalGCumulDerogVendu:=TotalGCumulDerogVendu+TotalCumulDerogVendu;

                  TotalGNetteEco:=TotalGNetteEco+TotalNetteEco;
                  TotalGNetteEcoVendu:=TotalGNetteEcoVendu+TotalNetteEcoVendu;

                  TotalGNetteFiscale:=TotalGNetteFiscale+TotalNetteFiscale;
                  TotalGNetteFiscaleVendu:=TotalGNetteFiscaleVendu+TotalNetteFiscaleVendu;

                  TotalBase:=0;
                  TotalExercice:=0;//*
                  TotalExerciceCumule:=0;//*
                  TotalCumule:=0;
                  TotalEco:=0;
                  TotalDerog:=0;
                  TotalCumulDerog:=0;
                  TotalNetteEco:=0;
                  TotalNetteFiscale:=0;

                  TotalAcquiVendu:=0;
                  TotalExerciceVendu:=0;//*
                  TotalExerciceCumulVendu:=0;//*
                  TotalEcoVendu:=0;
                  TotalCumulVendu:=0;
                  TotalDerogVendu:=0;
                  TotalCumulDerogVendu:=0;
                  TotalNetteEcoVendu:=0;
                  TotalNetteFiscaleVendu:=0;
                end;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
                  TotalGAvantCession:=TotalGAvantCession+TotalBase;
                  TotalGVendu:=TotalGVendu+TotalAcquiVendu;

                  TotalGExercice:=TotalGExercice+TotalEco+TotalDerog;//*
                  TotalGExerciceVendu:=TotalGExerciceVendu+TotalEcoVendu+TotalDerogVendu;//*

                  TotalGExerciceCumul:=TotalGExerciceCumul+TotalCumule+TotalcumulDerog;//*
                  TotalGExerciceCumulVendu:=TotalGExerciceCumulVendu+TotalCumulVendu+TotalCumulDerogVendu;//*

                  TotalGEco:=TotalGEco+TotalEco;
                  TotalGEcoVendu:=TotalGEcoVendu+TotalEcoVendu;

                  TotalGCumulEco:=TotalGCumulEco+TotalCumule;
                  TotalGCumulVendu:=TotalGCumulVendu+TotalCumulVendu;

                  TotalGDerog:=TotalGDerog+TotalDerog;
                  TotalGDerogVendu:=TotalGDerogVendu+TotalDerogVendu;

                  TotalGCumulDerog:=TotalGCumulDerog+TotalcumulDerog;
                  TotalGCumulDerogVendu:=TotalGCumulDerogVendu+TotalCumulDerogVendu;

                  TotalGNetteEco:=TotalGNetteEco+TotalNetteEco;
                  TotalGNetteEcoVendu:=TotalGNetteEcoVendu+TotalNetteEcoVendu;

                  TotalGNetteFiscale:=TotalGNetteFiscale+TotalNetteFiscale;
                  TotalGNetteFiscaleVendu:=TotalGNetteFiscaleVendu+TotalNetteFiscaleVendu;

//dernier compte
                  if detail then
                    Begin
                        ListeValeur.Add('3;;;;;; @TOTAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase) +'; ;'+E.FormatCurrSansDevise(TotalExercice) +';'+E.FormatCurrSansDevise(TotalExerciceCumule) +';'+E.FormatCurrSansDevise(TotalEco) +';'+E.FormatCurrSansDevise(TotalCumule)+';'+E.FormatCurrSansDevise(TotalDerog)+';'+E.FormatCurrSansDevise(TotalCumulDerog)+';'+E.FormatCurrSansDevise(TotalNetteEco)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
                        ListeValeur.Add('3;;;;;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +'; ;'+E.FormatCurrSansDevise(TotalExerciceVendu) +';'+E.FormatCurrSansDevise(TotalExerciceCumulVendu) +';'+E.FormatCurrSansDevise(TotalEcoVendu) +';'+E.FormatCurrSansDevise(TotalCumulVendu)+';'+E.FormatCurrSansDevise(TotalDerogVendu)+';'+E.FormatCurrSansDevise(TotalCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
                        ListeValeur.Add('3;;;;;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalExerciceCumule-TotalExerciceCumulVendu) +'; ;'+E.FormatCurrSansDevise(TotalCumule-TotalCumulVendu)+'; ;'+E.FormatCurrSansDevise(TotalCumulDerog-TotalCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalNetteEco-TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscale-TotalNetteFiscaleVendu));
                    end
                  else
                    Begin
                        ListeValeur.Add('3;; @TOTAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalExercice) +';'+E.FormatCurrSansDevise(TotalExerciceCumule) +';'+E.FormatCurrSansDevise(TotalEco) +';'+E.FormatCurrSansDevise(TotalCumule)+';'+E.FormatCurrSansDevise(TotalDerog)+';'+E.FormatCurrSansDevise(TotalCumulDerog)+';'+E.FormatCurrSansDevise(TotalNetteEco)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
                        ListeValeur.Add('3;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +';'+E.FormatCurrSansDevise(TotalExerciceVendu) +';'+E.FormatCurrSansDevise(TotalExerciceCumulVendu) +';'+E.FormatCurrSansDevise(TotalEcoVendu) +';'+E.FormatCurrSansDevise(TotalCumulVendu)+';'+E.FormatCurrSansDevise(TotalDerogVendu)+';'+E.FormatCurrSansDevise(TotalCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
                        ListeValeur.Add('3;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu) +'; ;'+E.FormatCurrSansDevise(TotalExerciceCumule-TotalExerciceCumulVendu) +'; ;'+E.FormatCurrSansDevise(TotalCumule-TotalCumulVendu)+'; ;'+E.FormatCurrSansDevise(TotalCumulDerog-TotalCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalNetteEco-TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscale-TotalNetteFiscaleVendu));
                    end;

            ListeValeur.Add('8;Nombre total d''immobilisation : '+ inttostr(Compteur));

                  if detail then
                    Begin
                        ListeValeur.Add('3;;;;;; @TOTAL GEN. Av/CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession) +'; ;'+E.FormatCurrSansDevise(TotalGExercice)+';'+E.FormatCurrSansDevise(TotalGExerciceCumul)+';'+E.FormatCurrSansDevise(TotalGEco)+';'+E.FormatCurrSansDevise(TotalGCumulEco)+';'+E.FormatCurrSansDevise(TotalGDerog)+';'+E.FormatCurrSansDevise(TotalGCumulDerog)+';'+E.FormatCurrSansDevise(TotalGNetteEco)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale));
                        ListeValeur.Add('3;;;;;; @TOTAL GEN. CESSIONS : ;'+E.FormatCurrSansDevise(TotalGVendu) +'; ;'+E.FormatCurrSansDevise(TotalGExerciceVendu)+';'+E.FormatCurrSansDevise(TotalGExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalGEcoVendu)+';'+E.FormatCurrSansDevise(TotalGCumulVendu)+';'+E.FormatCurrSansDevise(TotalGDerogVendu)+';'+E.FormatCurrSansDevise(TotalGCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalGNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscaleVendu));
                        ListeValeur.Add('3;;;;;; @TOTAL GEN. Ap/CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession-TotalGVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalGExerciceCumul-TotalGExerciceCumulVendu)+'; ;'+E.FormatCurrSansDevise(TotalGCumulEco-TotalGCumulVendu)+'; ;'+E.FormatCurrSansDevise(TotalGCumulDerog-TotalGCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalGNetteEco-TotalGNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale-TotalGNetteFiscaleVendu));
                        ObjPrn.Orientation:=poLandscape;
                        ObjPrn.FTitreEdition := 'TABLEAUX DES AMORTISSEMENTS ';
                        ListeValeur.Insert(0,' Code ;Désignation ; D/Acquis ; D/Amort. ;Duree ; T. ;;; Exercice ; Cumulé ; Exercice ; Cumulé ; Exercice ; Cumulé ; Economique ; Fiscale ');
                        ListeValeur.Insert(1,'0.4;1.6;0.6;0.6;0.4;0.2;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7');
                        ListeValeur.Insert(2,'texte;texte;texte;texte;float;Texte;curr;Texte;curr;curr;curr;curr;curr;curr;curr;curr');
                        ListeValeur.Insert(3,' Immobilisation ; Base d''Amortissement ; V. Acquis. ; D/Vente ; Amortissement ; Amort. Eco ; Amort. Derog. ; Valeur nette ;SURTITRE');
                        ListeValeur.Insert(4,'2;1.8;0.7;0.7;1.4;1.4;1.4;1.4');
                    end
                  else
                    Begin
                        ListeValeur.Add('3;; @TOTAL GEN. Av/CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession) +';'+E.FormatCurrSansDevise(TotalGExercice)+';'+E.FormatCurrSansDevise(TotalGExerciceCumul)+';'+E.FormatCurrSansDevise(TotalGEco)+';'+E.FormatCurrSansDevise(TotalGCumulEco)+';'+E.FormatCurrSansDevise(TotalGDerog)+';'+E.FormatCurrSansDevise(TotalGCumulDerog)+';'+E.FormatCurrSansDevise(TotalGNetteEco)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale));
                        ListeValeur.Add('3;; @TOTAL GEN. CESSIONS : ;'+E.FormatCurrSansDevise(TotalGVendu) +';'+E.FormatCurrSansDevise(TotalGExerciceVendu)+';'+E.FormatCurrSansDevise(TotalGExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalGEcoVendu)+';'+E.FormatCurrSansDevise(TotalGCumulVendu)+';'+E.FormatCurrSansDevise(TotalGDerogVendu)+';'+E.FormatCurrSansDevise(TotalGCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalGNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscaleVendu));
                        ListeValeur.Add('3;; @TOTAL GEN. Ap/CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession-TotalGVendu) +'; ;'+E.FormatCurrSansDevise(TotalGExerciceCumul-TotalGExerciceCumulVendu)+'; ;'+E.FormatCurrSansDevise(TotalGCumulEco-TotalGCumulVendu)+'; ;'+E.FormatCurrSansDevise(TotalGCumulDerog-TotalGCumulDerogVendu)+';'+E.FormatCurrSansDevise(TotalGNetteEco-TotalGNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale-TotalGNetteFiscaleVendu));
                        ObjPrn.Orientation:=poPortrait;
                        ObjPrn.FTitreEdition := 'SYNTHESE DU TABLEAUX DES AMORTISSEMENTS ';
                        ListeValeur.Insert(0,'  ; ; Acquis. ; Exercice ; Cumulé ; Exercice ; Cumulé ; Exercice ; Cumulé ; Economique ; Fiscale ');
                        ListeValeur.Insert(1,'0.4;1;0.65;0.65;0.65;0.65;0.65;0.65;0.65;0.65;0.65');
                        ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr;curr;curr;curr;curr;curr');
                        ListeValeur.Insert(3,' Immobilisation ; Valeur ; Amortissement ;  Amort. Eco ; Amort. Derog. ; Valeur nette ;SURTITRE');
                        ListeValeur.Insert(4,'1.4;0.65;1.3;1.3;1.3;1.3');
                    end;
           ObjPrn.FSousTitreEdition:=SousTitre;
           ObjPrn.FTitre2Edition :=TitreCompte;
           ObjPrn.FNomDossier:='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

       end
     else
       Begin
          while not DataModuleImmos.QuImmosEditionModifiable.Eof do
            begin
            compteTmp:=DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString;
            ValeurNetteEco:=DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency);
            AmortCumul:=(DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency);
            DerogCumul:=(DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_Derog').AsCurrency+(DataModuleImmos.QuImmosEditionModifiable.FindField('Choix').AsCurrency-DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency));
            ValeurNetteFiscale:=DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency-(DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('Amort_Derog').AsCurrency+DataModuleImmos.QuImmosEditionModifiable.FindField('Choix').AsCurrency);
            Derog:=DataModuleImmos.QuImmosEditionModifiable.FindField('Choix').AsCurrency-DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency;
            if Detail then
                begin
                  ListeValeur.Add('0'+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('CodeLong').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Libelle').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Date_Achat').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Date_mise_en_service').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Duree_Amt').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Type_Amt').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsString+
                                   ';'+
                                   DataModuleImmos.QuImmosEditionModifiable.FindField('Date_Cession').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise(DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').Ascurrency+Derog)+
                                   ';'+
                                   E.FormatCurrSansDevise(AmortCumul+DerogCumul)+
                                   ';'+
                                   E.FormatCurrSansDevise(ValeurNetteFiscale)
                                   );
                end;//fin si detail
                TotalBase:=TotalBase+DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency;
                TotalExercice:=TotalExercice+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency+Derog;//*
                TotalExerciceCumule:=TotalExerciceCumule+AmortCumul+DerogCumul;//*
                TotalEco:=TotalEco+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').AsCurrency;
                TotalCumule:=TotalCumule+AmortCumul;
                TotalDerog:=TotalDerog+Derog;
                TotalCumulDerog:=TotalCumulDerog+DerogCumul;
                TotalNetteEco:=TotalNetteEco+ValeurNetteEco;
                TotalNetteFiscale:=TotalNetteFiscale+ValeurNetteFiscale;

                if not empty(DataModuleImmos.QuImmosEditionModifiable.FindField('Date_Cession').AsString) then
                  begin
                    TotalAcquiVendu:=TotalAcquiVendu+DataModuleImmos.QuImmosEditionModifiable.FindField('Valeur_A_Amortir').AsCurrency;;
                    TotalExerciceVendu:=TotalExerciceVendu+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').Ascurrency+Derog;//*
                    TotalExerciceCumulVendu:=TotalExerciceCumulVendu+AmortCumul+DerogCumul;//*
                    TotalEcoVendu:=TotalEcoVendu+DataModuleImmos.QuImmosEditionModifiable.FindField('Eco').Ascurrency;
                    TotalCumulVendu:=TotalCumulVendu+AmortCumul;
                    TotalDerogVendu:=TotalDerogVendu+Derog;
                    TotalCumulDerogVendu:=TotalCumulDerogVendu+DerogCumul;
                    TotalNetteEcoVendu:=TotalNetteEcoVendu+ValeurNetteEco;
                    TotalNetteFiscaleVendu:=TotalNetteFiscaleVendu+ValeurNetteFiscale;
                  end;
                inc(Compteur);
                DataModuleImmos.QuImmosEditionModifiable.Next;
              if compteTmp<>DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString then
                begin
                  compteTmp:=DataModuleImmos.QuImmosEditionModifiable.FindField('Compte').AsString;
                  if detail then
                    Begin
                      ListeValeur.Add('3;;;;;; @TOTAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase) +'; ;'+E.FormatCurrSansDevise(TotalExercice) +';'+E.FormatCurrSansDevise(TotalExerciceCumule)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
                      ListeValeur.Add('3;;;;;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +'; ;'+E.FormatCurrSansDevise(TotalExerciceVendu) +';'+E.FormatCurrSansDevise(TotalExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
                      ListeValeur.Add('3;;;;;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalExerciceCumule-TotalExerciceCumulVendu)+';'+E.FormatCurrSansDevise((TotalNetteFiscale)-(TotalNetteFiscaleVendu)));
                    end
                  else
                    Begin
                      ListeValeur.Add('3;; @TOTAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalExercice) +';'+E.FormatCurrSansDevise(TotalExerciceCumule)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
                      ListeValeur.Add('3;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +';'+E.FormatCurrSansDevise(TotalExerciceVendu) +';'+E.FormatCurrSansDevise(TotalExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
                      ListeValeur.Add('3;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu)+'; ;'+E.FormatCurrSansDevise(TotalExerciceCumule-TotalExerciceCumulVendu)+';'+E.FormatCurrSansDevise((TotalNetteFiscale)-(TotalNetteFiscaleVendu)));
                    end;
                  ListeValeur.Add('9;COMPTE : '+compteTmp +' - '+ DMPlan.LibelleDuNumCptPCU(compteTmp ));

                  TotalGAvantCession:=TotalGAvantCession+TotalBase;
                  TotalGVendu:=TotalGVendu+TotalAcquiVendu;

                  TotalGExercice:=TotalGExercice+TotalEco+TotalDerog;//*
                  TotalGExerciceVendu:=TotalGExerciceVendu+TotalEcoVendu+TotalDerogVendu;//*

                  TotalGExerciceCumul:=TotalGExerciceCumul+TotalCumule+TotalcumulDerog;//*
                  TotalGExerciceCumulVendu:=TotalGExerciceCumulVendu+TotalCumulVendu+TotalCumulDerogVendu;//*

                  TotalGEco:=TotalGEco+TotalEco;
                  TotalGEcoVendu:=TotalGEcoVendu+TotalEcoVendu;

                  TotalGCumulEco:=TotalGCumulEco+TotalCumule;
                  TotalGCumulVendu:=TotalGCumulVendu+TotalCumulVendu;

                  TotalGDerog:=TotalGDerog+TotalDerog;
                  TotalGDerogVendu:=TotalGDerogVendu+TotalDerogVendu;

                  TotalGCumulDerog:=TotalGCumulDerog+TotalcumulDerog;
                  TotalGCumulDerogVendu:=TotalGCumulDerogVendu+TotalCumulDerogVendu;

                  TotalGNetteEco:=TotalGNetteEco+TotalNetteEco;
                  TotalGNetteEcoVendu:=TotalGNetteEcoVendu+TotalNetteEcoVendu;

                  TotalGNetteFiscale:=TotalGNetteFiscale+TotalNetteFiscale;
                  TotalGNetteFiscaleVendu:=TotalGNetteFiscaleVendu+TotalNetteFiscaleVendu;

                  TotalBase:=0;
                  TotalExercice:=0;//*
                  TotalExerciceCumule:=0;//*
                  TotalCumule:=0;
                  TotalEco:=0;
                  TotalDerog:=0;
                  TotalCumulDerog:=0;
                  TotalNetteEco:=0;
                  TotalNetteFiscale:=0;

                  TotalAcquiVendu:=0;
                  TotalExerciceVendu:=0;//*
                  TotalExerciceCumulVendu:=0;//*
                  TotalEcoVendu:=0;
                  TotalCumulVendu:=0;
                  TotalDerogVendu:=0;
                  TotalCumulDerogVendu:=0;
                  TotalNetteEcoVendu:=0;
                  TotalNetteFiscaleVendu:=0;

                end;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
                  TotalGAvantCession:=TotalGAvantCession+TotalBase;
                  TotalGVendu:=TotalGVendu+TotalAcquiVendu;

                  TotalGExercice:=TotalGExercice+TotalEco+TotalDerog;//*
                  TotalGExerciceVendu:=TotalGExerciceVendu+TotalEcoVendu+TotalDerogVendu;//*

                  TotalGExerciceCumul:=TotalGExerciceCumul+TotalCumule+TotalcumulDerog;//*
                  TotalGExerciceCumulVendu:=TotalGExerciceCumulVendu+TotalCumulVendu+TotalCumulDerogVendu;//*

                  TotalGEco:=TotalGEco+TotalEco;
                  TotalGEcoVendu:=TotalGEcoVendu+TotalEcoVendu;

                  TotalGCumulEco:=TotalGCumulEco+TotalCumule;
                  TotalGCumulVendu:=TotalGCumulVendu+TotalCumulVendu;

                  TotalGDerog:=TotalGDerog+TotalDerog;
                  TotalGDerogVendu:=TotalGDerogVendu+TotalDerogVendu;

                  TotalGCumulDerog:=TotalGCumulDerog+TotalcumulDerog;
                  TotalGCumulDerogVendu:=TotalGCumulDerogVendu+TotalCumulDerogVendu;

                  TotalGNetteEco:=TotalGNetteEco+TotalNetteEco;
                  TotalGNetteEcoVendu:=TotalGNetteEcoVendu+TotalNetteEcoVendu;

                  TotalGNetteFiscale:=TotalGNetteFiscale+TotalNetteFiscale;
                  TotalGNetteFiscaleVendu:=TotalGNetteFiscaleVendu+TotalNetteFiscaleVendu;
//dernier compte
                  if detail then
                    Begin
                      ListeValeur.Add('3;;;;;; @TOTAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase) +'; ;'+E.FormatCurrSansDevise(TotalExercice) +';'+E.FormatCurrSansDevise(TotalExerciceCumule)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
                      ListeValeur.Add('3;;;;;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +'; ;'+E.FormatCurrSansDevise(TotalExerciceVendu) +';'+E.FormatCurrSansDevise(TotalExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
                      ListeValeur.Add('3;;;;;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalExerciceCumule-TotalExerciceCumulVendu)+';'+E.FormatCurrSansDevise((TotalNetteFiscale)-(TotalNetteFiscaleVendu)));
                    end
                  else
                    Begin
                      ListeValeur.Add('3;; @TOTAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalExercice) +';'+E.FormatCurrSansDevise(TotalExerciceCumule)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
                      ListeValeur.Add('3;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +';'+E.FormatCurrSansDevise(TotalExerciceVendu) +';'+E.FormatCurrSansDevise(TotalExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
                      ListeValeur.Add('3;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu)+'; ;'+E.FormatCurrSansDevise(TotalExerciceCumule-TotalExerciceCumulVendu)+';'+E.FormatCurrSansDevise((TotalNetteFiscale)-(TotalNetteFiscaleVendu)));
                    end;
            ListeValeur.Add('8;Nombre total d''immobilisation : '+ inttostr(Compteur));

                  if detail then
                    Begin
                      ListeValeur.Add('3;;;;;; @TOTAL GENERAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession) +'; ;'+E.FormatCurrSansDevise(TotalGExercice)+';'+E.FormatCurrSansDevise(TotalGExerciceCumul)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale));
                      ListeValeur.Add('3;;;;;; @TOTAL GENERAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalGVendu)+'; ;'+E.FormatCurrSansDevise(TotalGExerciceVendu)+';'+E.FormatCurrSansDevise(TotalGExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscaleVendu));
                      ListeValeur.Add('3;;;;;; @TOTAL GENERAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession-TotalGVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalGExerciceCumul-TotalGExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale-TotalGNetteFiscaleVendu));
                      ObjPrn.FTitreEdition := 'TABLEAUX DES AMORTISSEMENTS ';
                      ListeValeur.Insert(0,' Code ;Désignation ; D/Acquis. ; D/Amort. ;Duree ; T. ;;; Exercice ; Cumulé ;  ');
                      ListeValeur.Insert(1,'0.4;1.6;0.6;0.6;0.4;0.2;0.7;0.7;0.7;0.7;0.8;');
                      ListeValeur.Insert(2,'texte;texte;texte;texte;float;Texte;curr;Texte;curr;curr;curr;curr;curr;curr');
                      ListeValeur.Insert(3,' Immobilisation ; Base d''Amortissement ; V. Acquis. ; D/Vente ; Amortissement ; Valeur nette ;SURTITRE');
                      ListeValeur.Insert(4,'2;1.8;0.7;0.7;1.4;0.8');
                    end
                  else
                    Begin
                      ListeValeur.Add('3;; @TOTAL GENERAL AVANT CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession) +';'+E.FormatCurrSansDevise(TotalGExercice)+';'+E.FormatCurrSansDevise(TotalGExerciceCumul)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale));
                      ListeValeur.Add('3;; @TOTAL GENERAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalGVendu)+';'+E.FormatCurrSansDevise(TotalGExerciceVendu)+';'+E.FormatCurrSansDevise(TotalGExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscaleVendu));
                      ListeValeur.Add('3;; @TOTAL GENERAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession-TotalGVendu)+'; ;'+E.FormatCurrSansDevise(TotalGExerciceCumul-TotalGExerciceCumulVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale-TotalGNetteFiscaleVendu));
                      ObjPrn.FTitreEdition := 'SYNTHESE DU TABLEAUX DES AMORTISSEMENTS ';
                      ListeValeur.Insert(0,' ; ; Acquis. ; Exercice ; Cumulé ;  ');
                      ListeValeur.Insert(1,'0.6;2.4;0.9;0.9;0.9;0.9;');
                      ListeValeur.Insert(2,'texte;texte;texte;texte;float;Texte;curr;Texte;curr;curr;curr;curr;curr;curr');
                      ListeValeur.Insert(3,' Immobilisation ; Valeur ; Amortissement ; Valeur nette ;SURTITRE');
                      ListeValeur.Insert(4,'3;0.9;1.8;0.9');
                    end;

           ObjPrn.FSousTitreEdition:=SousTitre;
           ObjPrn.FTitre2Edition :=TitreCompte;
           ObjPrn.FNomDossier:='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

       end;
      end;
     ObjPrn.AffichageImp(ListeValeur);
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;

//Function EditionSyntheseTableauDesAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string;Derogatoire:boolean):Boolean;overload;
//var
//periode:TPeriode;
//i:integer;
//ObjPrn:TObjetEdition;
//ListeValeur:TStringList;
//compteTmp:string;
//Derog:currency;
//TotalBase,TotalCumule,TotalCumulDerog,TotalNetteEco,TotalNetteFiscale,TotalEco,TotalDerog:currency;
//TotalGAvantCession{,TotalGVendu}:currency;
//ValeurNetteEco,ValeurNetteFiscale,AmortCumul,DerogCumul:currency;
////TotalAcquiVendu,TotalNetteEcoVendu,TotalNetteFiscaleVendu,TotalCumulVendu:currency;
//TotalGEco,TotalGDerog,TotalGCumulEco,TotalGCumulDerog{,TotalGCumulVendu},TotalGNetteEco,TotalGNetteFiscale{,TotalGNetteEcoVendu,TotalGNetteFiscaleVendu}:currency;
//Compteur:integer;
//TitreCompte:string;
//begin
//ValeurNetteEco:=0;
//ValeurNetteFiscale:=0;
//
//AmortCumul:=0;
//DerogCumul:=0;
//Derog:=0;
//
//TotalBase:=0;
//TotalCumule:=0;
//TotalCumulDerog:=0;
//TotalNetteEco:=0;
//TotalNetteFiscale:=0;
//TotalEco:=0;
//TotalDerog:=0;
////TotalNetteEcoVendu:=0;
////TotalNetteFiscaleVendu:=0;
////TotalCumulVendu:=0;
////TotalAcquiVendu:=0;
//
//TotalGAvantCession:=0;
////TotalGVendu:=0;
//
//TotalGEco:=0;
//TotalGDerog:=0;
//
//TotalGCumulEco:=0;
//TotalGCumulDerog:=0;
//
////TotalGCumulVendu:=0;
//
//TotalGNetteEco:=0;
//TotalGNetteFiscale:=0;
//
////TotalGNetteEcoVendu:=0;
////TotalGNetteFiscaleVendu:=0;
//
//Compteur:=0;
//
//  if DemandePeriode then
//   periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',true)
//   else
//    begin
//     periode.Retour := true;
//     periode.DateDeb := E.DatExoDebut;
//     periode.DateFin := E.DatExoFin;
//    end;
//  if periode.Retour then
//   begin
//
//    ObjPrn:=TObjetEdition.Create(application.MainForm);
//    ObjPrn.FontLigneSeule.Style := [fsBold];
//    ListeValeur:=TStringList.Create;
//
//    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
//    if dataset = nil then
//      begin
//        // Prevu pour passer le dataset concerné
//      end;
//       //on branche un filter record sur requete en passant une liste
//        DataModuleImmos.ListeFilterRecordAcquisition.clear;
//        if Compte<>nil then      // Tous les Comptes
//         begin
//          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
//          DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
//          DataModuleImmos.QuSyntheseChoixAmort_Edition.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecord;
//          DataModuleImmos.QuSyntheseChoixAmort_Edition.filtered:=true;
//         end
//        else
//          begin
//            DataModuleImmos.QuSyntheseChoixAmort_Edition.OnFilterRecord:=nil;
//            TitreCompte:='Tous les comptes';
//          end;
//      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Clear;
//      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('select count(id)as NB_Immos_Compte,compte,P.libelle, sum(Valeur_A_Amortir)as Valeur_A_Amortir,sum(Amort_eco)as Amort_eco,');
//      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('sum(Amort_Derog)as Amort_Derog, sum(Eco)as Eco,sum(choix)as choix');
//      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('from immos I Join plancpt P on (I.compte=P.compte)');
//      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('where Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('Group by compte,P.libelle');
//      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('order by compte');
//      DataModuleImmos.QuSyntheseChoixAmort_Edition.Open;
//
//          DataModuleImmos.QuSyntheseChoixAmort_Edition.First;
//          compteTmp:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString;
//          ListeValeur.Add('9;COMPTE : '+compteTmp);
//     if Derogatoire then
//       Begin
//          while not DataModuleImmos.QuSyntheseChoixAmort_Edition.Eof do
//            begin
//            compteTmp:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString;
//            ValeurNetteEco:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Valeur_A_Amortir').AsCurrency-(DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Eco').AsCurrency);
//            AmortCumul:=(DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Eco').AsCurrency);
//            DerogCumul:=(DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Amort_Derog').AsCurrency+(DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Choix').AsCurrency-DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Eco').AsCurrency));
//            ValeurNetteFiscale:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Valeur_A_Amortir').AsCurrency-(DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Amort_eco').AsCurrency+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Amort_Derog').AsCurrency+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Choix').AsCurrency);
//            Derog:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Choix').AsCurrency-DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Eco').AsCurrency;
//                  ListeValeur.Add('0'+
//                                   ';'+
//                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString+
//                                   ';'+
//                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('libelle').AsString+
//                                   ';'+
//                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Valeur_A_Amortir').AsString+
//                                   ';'+
//                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Eco').AsString+
//                                   ';'+
//                                   E.FormatCurrSansDevise(AmortCumul)+
//                                   ';'+
//                                   E.FormatCurrSansDevise(Derog)+
//                                   ';'+
//                                   E.FormatCurrSansDevise(DerogCumul)+
//                                   ';'+
//                                   E.FormatCurrSansDevise(ValeurNetteEco)+
//                                   ';'+
//                                   E.FormatCurrSansDevise(ValeurNetteFiscale)
//                                   );
//                TotalBase:=TotalBase+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Valeur_A_Amortir').AsCurrency;
//                TotalEco:=TotalEco+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Eco').AsCurrency;
//                TotalCumule:=TotalCumule+AmortCumul;
//                TotalDerog:=TotalDerog+Derog;
//                TotalCumulDerog:=TotalCumulDerog+DerogCumul;
//                TotalNetteEco:=TotalNetteEco+ValeurNetteEco;
//                TotalNetteFiscale:=TotalNetteFiscale+ValeurNetteFiscale;
//
////                if not empty(DataModuleImmos.QuImmosEdition.FindField('Date_Cession').AsString) then
////                  begin
////                    TotalAcquiVendu:=TotalAcquiVendu+DataModuleImmos.QuImmosEdition.FindField('Valeur_A_Amortir').AsCurrency;;
////                    TotalCumulVendu:=TotalCumulVendu+AmortCumul;
////                    TotalNetteEcoVendu:=TotalNetteEcoVendu+ValeurNetteEco;
////                    TotalNetteFiscaleVendu:=TotalNetteFiscaleVendu+ValeurNetteFiscale;
////                  end;
//                inc(Compteur,DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('NB_Immos_Compte').Asinteger);
//                DataModuleImmos.QuSyntheseChoixAmort_Edition.Next;
//              if compteTmp<>DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString then
//                begin
//                  compteTmp:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString;
//                  ListeValeur.Add('3;; @TOTAL : ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalEco) +';'+E.FormatCurrSansDevise(TotalCumule)+';'+E.FormatCurrSansDevise(TotalNetteEco)+';'+E.FormatCurrSansDevise(TotalDerog)+';'+E.FormatCurrSansDevise(TotalCumulDerog)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
////                  ListeValeur.Add('3;;;;;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalCumulVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
////                  ListeValeur.Add('3;;;;;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalCumule-TotalCumulVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalNetteEco-TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscale-TotalNetteFiscaleVendu));
//                  ListeValeur.Add('9;COMPTE : '+compteTmp);
//
//                  TotalGAvantCession:=TotalGAvantCession+TotalBase;
//                 // TotalGVendu:=TotalGVendu+TotalAcquiVendu;
//                  TotalGEco:=TotalGEco+TotalEco;
//                  TotalGCumulEco:=TotalGCumulEco+TotalCumule;
//                  //TotalGCumulVendu:=TotalGCumulVendu+TotalCumulVendu;
//                  TotalGNetteEco:=TotalGNetteEco+TotalNetteEco;
//                  //TotalGNetteEcoVendu:=TotalGNetteEcoVendu+TotalNetteEcoVendu;
//                  TotalGNetteFiscale:=TotalGNetteFiscale+TotalNetteFiscale;
//                  //TotalGNetteFiscaleVendu:=TotalGNetteFiscaleVendu+TotalNetteFiscaleVendu;
//
//                  TotalBase:=0;
//                  TotalCumule:=0;
//                  TotalEco:=0;
//                  TotalDerog:=0;
//                  TotalCumulDerog:=0;
//                  TotalNetteEco:=0;
//                  TotalNetteFiscale:=0;
//                  TotalNetteEco:=0;
////                  TotalAcquiVendu:=0;
////                  TotalCumulVendu:=0;
////                  TotalNetteEcoVendu:=0;
////                  TotalNetteFiscaleVendu:=0;
//
//
//                end;
//            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
//            TotalGAvantCession:=TotalGAvantCession+TotalBase;
////            TotalGVendu:=TotalGVendu+TotalAcquiVendu;
//            TotalGEco:=TotalGEco+TotalEco;
//            TotalGCumulEco:=TotalGCumulEco+TotalCumule;
////            TotalGCumulVendu:=TotalGCumulVendu+TotalCumulVendu;
//            TotalGNetteEco:=TotalGNetteEco+TotalNetteEco;
////            TotalGNetteEcoVendu:=TotalGNetteEcoVendu+TotalNetteEcoVendu;
//            TotalGNetteFiscale:=TotalGNetteFiscale+TotalNetteFiscale;
////            TotalGNetteFiscaleVendu:=TotalGNetteFiscaleVendu+TotalNetteFiscaleVendu;
//
////dernier compte
//            ListeValeur.Add('3;; @TOTAL : ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalEco) +';'+E.FormatCurrSansDevise(TotalCumule)+';'+E.FormatCurrSansDevise(TotalNetteEco)+';'+E.FormatCurrSansDevise(TotalDerog)+';'+E.FormatCurrSansDevise(TotalCumulDerog)+';'+E.FormatCurrSansDevise(TotalNetteFiscale));
////            ListeValeur.Add('3;;;;;; @TOTAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalAcquiVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalCumulVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscaleVendu));
////            ListeValeur.Add('3;;;;;; @TOTAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalBase-TotalAcquiVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalCumule-TotalCumulVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalNetteEco-TotalNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalNetteFiscale-TotalNetteFiscaleVendu));
//
//            ListeValeur.Add('8;Nombre total d''immobilisation : '+ inttostr(Compteur));
//            ListeValeur.Add('3;; @TOTAL GENERAL : ;'+E.FormatCurrSansDevise(TotalGAvantCession) +';'+E.FormatCurrSansDevise(TotalGEco)+';'+E.FormatCurrSansDevise(TotalGCumulEco)+';'+E.FormatCurrSansDevise(TotalGNetteEco)+';'+E.FormatCurrSansDevise(TotalGDerog)+';'+E.FormatCurrSansDevise(TotalGCumulDerog)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale));
////            ListeValeur.Add('3;;;;;; @TOTAL GENERAL DES CESSIONS : ;'+E.FormatCurrSansDevise(TotalGVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalGCumulVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalGNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscaleVendu));
////            ListeValeur.Add('3;;;;;; @TOTAL GENERAL APRES CESSIONS : ;'+E.FormatCurrSansDevise(TotalGAvantCession-TotalGVendu) +'; ; ;'+E.FormatCurrSansDevise(TotalGCumulEco-TotalGCumulVendu)+'; ; ;'+E.FormatCurrSansDevise(TotalGNetteEco-TotalGNetteEcoVendu)+';'+E.FormatCurrSansDevise(TotalGNetteFiscale-TotalGNetteFiscaleVendu));
//
////           ObjPrn.Orientation:=poLandscape;
//           ObjPrn.FTitreEdition := 'SYNTHESE DU TABLEAUX DES AMORTISSEMENTS ';
//           ObjPrn.FSousTitreEdition:=SousTitre;
//           ObjPrn.FTitre2Edition :=TitreCompte;
//           ObjPrn.FNomDossier:='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
//           ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
//
//           ListeValeur.Insert(0,' Compte ; Désignation ; Amortissement ; Exo. ; Cumulé ; Comptable ; Exo. ; Cumulé ;  Fiscale ');
//           ListeValeur.Insert(1,'0.6;1;0.7;0.7;0.7;0.8;0.7;0.7;0.8');
//           ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr;curr;curr;curr');
//           ListeValeur.Insert(3,' ; Base ; Amort. Economique ;Valeur nette ; Amort. Derog. ; Valeur nette ;SURTITRE');
//           ListeValeur.Insert(4,'1.6;0.7;1.4;0.8;1.4;0.8');
//
//       end;
//     ObjPrn.AffichageImp(ListeValeur);
//     //end;//fin du empty journal
//  end;//fin du periode.retour                                           
//end;
//
//Function EditionSyntheseTableauDesAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string;Derogatoire:boolean):Boolean;
//var
//Maliste:Tstringlist;
//Retour:TExceptLGR;
//begin
//Initialise_ExceptLGR(retour);
//  try
//   Maliste:=TStringList.Create;
//   if not empty (Compte)then
//     Maliste.Add(Compte)
//   else
//     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
//   EditionSyntheseTableauDesAmortissementL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,Derogatoire);
//  except
//     abort;
//  end;
//end;
//
//Function EditionSyntheseTableauDesAmortissementL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string;Derogatoire:boolean):Boolean;
//var
//Maliste:Tstringlist;
//Retour:TExceptLGR;
//begin
//Initialise_ExceptLGR(retour);
//  try
//   Maliste:=TStringList.Create;
//   if not empty (filtre)then
//    begin
//      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
//      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
//    end
//   else
//     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
//   EditionSyntheseTableauDesAmortissementL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,Derogatoire);
//  except
//     abort;
//  end;
//end;


Function EditionTableauDesAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string;Derogatoire:boolean;Detail:boolean):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionTableauDesAmortissementL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,Derogatoire,Detail);
  except
     abort;
  end;
end;

Function EditionTableauDesAmortissementL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string;Derogatoire:boolean;Detail:boolean):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (filtre)then
    begin
      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
    end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionTableauDesAmortissementL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre,Derogatoire,Detail);
  except
     abort;
  end;
end;


Function EditionSyntheseDesChoixAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
compteTmp:string;
TotalBase,TotalReportEco,TotalReportDerog,TotalEco:currency;
TotalMini,TotalMaxi:currency;
Compteur:integer;
TotalBaseG,TotalReportEcoG,TotalReportDerogG,TotalEcoG:currency;
TotalMiniG,TotalMaxiG:currency;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalBase:=0;
TotalReportEco:=0;
TotalReportDerog:=0;
TotalEco:=0;
TotalMini:=0;
TotalMaxi:=0;

TotalBaseG:=0;
TotalReportEcoG:=0;
TotalReportDerogG:=0;
TotalEcoG:=0;
TotalMiniG:=0;
TotalMaxiG:=0;

Compteur:=0;

  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    Initialise_TStringlist(DataModuleImmos.ListeFilterRecordAcquisition,nil,false);
    DataModuleImmos.QuSyntheseChoixAmort_Edition.OnFilterRecord:=nil;
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        if (Compte<>nil)and(compte.Count=0)then abort;
        if (Compte<>nil) then      // Tous les Comptes
         begin
          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
          DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
                    { isa  le  23/01/04 }
          DataModuleImmos.QuSyntheseChoixAmort_Edition.OnFilterRecord:=DataModuleImmos.QuImmosEditionFilterRecord;
          DataModuleImmos.QuSyntheseChoixAmort_Edition.filtered:=true;
         end
        else
          begin
            DataModuleImmos.QuSyntheseChoixAmort_Edition.OnFilterRecord:=nil;
            TitreCompte:='Tous les comptes ';
          end;

      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Clear;
      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('select count(id)as NB_Immos_Compte,compte,P.libelle,sum(Valeur_a_amortir)as Base,');
      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('sum(Amort_eco)as Reporteco,sum(Amort_Derog)as ReportDerog,sum(Eco)as Eco,sum(Mini)as mini,sum(Maxi)as maxi ');
      if e.ExerciceCloture then
        DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add(' from "'+IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos" I')
      else
        DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add(' from immos I ');
      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('Join plancpt P on (I.compte=P.compte)');
      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('where Date_Cession is null or Date_Cession between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('Group by compte,P.libelle');
      DataModuleImmos.QuSyntheseChoixAmort_Edition.SQL.Add('order by compte');
      DataModuleImmos.QuSyntheseChoixAmort_Edition.Open;

      DataModuleImmos.QuSyntheseChoixAmort_Edition.First;
      if DataModuleImmos.QuSyntheseChoixAmort_Edition.recordcount<>0 then
        begin
          compteTmp:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString;
          ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp));
          while not DataModuleImmos.QuSyntheseChoixAmort_Edition.Eof do
            begin
            compteTmp:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString;
                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Base').AsString+
                                   ';'+
                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Reporteco').AsString+
                                   ';'+
                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('ReportDerog').AsString+
                                   ';'+
                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Eco').AsString+
                                   ';'+
                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('mini').AsString+
                                   ';'+
                                   DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('maxi').AsString
                                   );
                TotalBase:=TotalBase+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Base').AsCurrency;
                TotalReportEco:=TotalReportEco+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Reporteco').AsCurrency;
                TotalReportDerog:=TotalReportDerog+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('ReportDerog').AsCurrency;
                TotalEco:=TotalEco+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Eco').AsCurrency;
                TotalMini:=TotalMini+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('mini').AsCurrency;
                TotalMaxi:=TotalMaxi+DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('maxi').AsCurrency;

                TotalBaseG:=TotalBaseG+TotalBase;
                TotalReportEcoG:=TotalReportEcoG+TotalReportEco;
                TotalReportDerogG:=TotalReportDerogG+TotalReportDerog;
                TotalEcoG:=TotalEcoG+TotalEco;
                TotalMiniG:=TotalMiniG+TotalMini;
                TotalMaxiG:=TotalMaxiG+TotalMaxi;
                inc(Compteur,DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('NB_Immos_Compte').Asinteger);
                //inc(Compteur);
                DataModuleImmos.QuSyntheseChoixAmort_Edition.Next;
              if compteTmp<>DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString then
                begin
                  compteTmp:=DataModuleImmos.QuSyntheseChoixAmort_Edition.FindField('Compte').AsString;
                  ListeValeur.Add('3;; @TOTAL :  ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalReportEco) +';'+E.FormatCurrSansDevise(TotalReportDerog) +';'+E.FormatCurrSansDevise(TotalEco)+';'+E.FormatCurrSansDevise(TotalMini)+';'+E.FormatCurrSansDevise(TotalMaxi));
                  ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp));
                  TotalBase:=0;
                  TotalReportEco:=0;
                  TotalReportDerog:=0;
                  TotalEco:=0;
                  TotalMini:=0;
                  TotalMaxi:=0;
                end;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
            //dernier compte
            ListeValeur.Add('3;; @TOTAL :  ;'+E.FormatCurrSansDevise(TotalBase) +';'+E.FormatCurrSansDevise(TotalReportEco) +';'+E.FormatCurrSansDevise(TotalReportDerog) +';'+E.FormatCurrSansDevise(TotalEco)+';'+E.FormatCurrSansDevise(TotalMini)+';'+E.FormatCurrSansDevise(TotalMaxi));

            ListeValeur.Add('8;Nombre total d''immobilisation : '+ inttostr(Compteur));
            ListeValeur.Add('3;; @TOTAL GENERAL :  ;'+E.FormatCurrSansDevise(TotalBaseG) +';'+E.FormatCurrSansDevise(TotalReportEcoG) +';'+E.FormatCurrSansDevise(TotalReportDerogG) +';'+E.FormatCurrSansDevise(TotalEcoG)+';'+E.FormatCurrSansDevise(TotalMiniG)+';'+E.FormatCurrSansDevise(TotalMaxiG));
           ObjPrn.FontLigneSeule.Size:=7;
           ObjPrn.FTitreEdition := 'SYNTHESE DES CHOIX D''AMORTISSEMENTS ';
           ObjPrn.FSousTitreEdition:=SousTitre;
           ObjPrn.FTitre2Edition :=TitreCompte;
           ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

           ListeValeur.Insert(0,' Compte ;Désignation ; Amort ; Amort.Eco ; Amort.Derog ; Eco ; Mini ; Maxi ');
           ListeValeur.Insert(1,'1;1.6;0.8;0.8;0.8;0.8;0.8;0.8');
           ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr;curr;curr');
           ListeValeur.Insert(3,'  ; Base  ; Situation début Exer. ; Exercice ; Amortissement ;SURTITRE');
           ListeValeur.Insert(4,'2.6;0.8;1.6;0.8;1.6');
        end;
     ObjPrn.AffichageImp(ListeValeur);
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;



Function EditionSyntheseDesChoixAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet;SousTitre:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionSyntheseDesChoixAmortissementL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;


Function EditionSyntheseDesChoixAmortissementL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (filtre)then
    begin
      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
    end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionSyntheseDesChoixAmortissementL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;


Procedure Initialise_TInfosCession(var InfosCession:TInfosCession);
Begin
InfosCession.Ecriture_Cession:=0;
InfosCession.Mt_Cession:=0;
InfosCession.Date_Cession:=0;
InfosCession.Cession_dans_Annee:=false;
end;


Procedure Initialise_TinfosRebut(var infosRebut:TinfosRebut);
Begin
infosRebut.Mt_Cession:=0;
infosRebut.Date_Cession:=0;
infosRebut.Cession_dans_Annee:=false;
infosRebut.Rebut:=false;
end;

Procedure Initialise_TinfosDivision(var infosDivision:TinfosDivision);
Begin
infosDivision.Compte:=C_StrVide;
infosDivision.Code:=C_StrVide;
infosDivision.Sous_Code:=C_StrVide;
infosDivision.Libelle:=C_StrVide;
infosDivision.Valeur_Acq:=0;
infosDivision.Valeur_A_Amortir:=0;
infosDivision.Amort_Eco:=0;
infosDivision.Amort_Derog:=0;
end;

Procedure Initialise_TinfosDetailAcquis(var infosDetailAcquis:TinfosDetailAcquis);
Begin
infosDetailAcquis.id:=0;
infosDetailAcquis.Libelle:=c_strvide;
infosDetailAcquis.Date_Achat:=0;
infosDetailAcquis.Ecriture_Achat:=0;
infosDetailAcquis.Deduc_Invest:=false;
infosDetailAcquis.Reprise_deduc_invest:=0;
infosDetailAcquis.Amort_Eco:=0;
infosDetailAcquis.Amort_Derog:=0;
infosDetailAcquis.Duree_Amt:=0;
infosDetailAcquis.Mt_Cession:=0;
infosDetailAcquis.Rebut:=false;
infosDetailAcquis.Achat_dans_Annee:=false;
infosDetailAcquis.Cession_dans_Annee:=false;
infosDetailAcquis.Maxi:=0;
infosDetailAcquis.Mini:=0;
infosDetailAcquis.Choix:=0;
infosDetailAcquis.Eco:=0;
infosDetailAcquis.EnCours:=false;
infosDetailAcquis.CodeTerminee:=C_StrVide;
infosDetailAcquis.CompteTerminee:=C_StrVide;
infosDetailAcquis.sousCodeTerminee:=C_StrVide;
infosDetailAcquis.TauxAmo:=0;
infosDetailAcquis.Type_Amt:=C_StrVide;
end;

function TDataModuleImmos.CtrlSaisieDescriptionAmort(EditCourant:Tfield):TExceptLGR;
var
LibelleEcriture:string;
Begin
try
Initialise_ExceptLGR(result);
//result.NumErreur:=0;
//result.retour:=true;
if DataModuleImmos.taDetailImmo.state in [dsinsert,dsedit]then
       case EditCourant.index of
         4:Begin //si edit Compte
           //
           end;
         5:Begin //si edit Code
             if empty(editcourant.AsString)then
                 raise ExceptLGR.Create('Le Code '+editcourant.AsString+' n''est pas valide',5001,true,mtError,Result);
//             if not empty(editcourant.DataSet.findfield('Sous_code').AsString) then
//               begin
//                 if (DataModuleImmos.ExisteNumImmo(DataModuleImmos.taDetailImmo,editcourant.DataSet.findfield('compte').AsString,editcourant.AsString,editcourant.DataSet.findfield('Sous_code').AsString,DataModuleImmos.taDetailImmoID.asstring))then
//                     raise ExceptLGR.Create('Ce Code et sous-Code existe déjà pour une immobilisation portant sur le même compte',5002,true,mtError,Result);
//               end;
           end;
         6:Begin //si edit SousCode
             if empty(editcourant.AsString) then
                 raise ExceptLGR.Create('Le Sous-Code '+editcourant.AsString+' n''est pas valide',6001,true,mtError,Result);
             if not empty(editcourant.DataSet.findfield('code').AsString) then
               begin
                 if (DataModuleImmos.ExisteNumImmo(DataModuleImmos.taDetailImmo,editcourant.DataSet.findfield('compte').AsString,editcourant.DataSet.findfield('code').AsString,editcourant.AsString,DataModuleImmos.taDetailImmoID.asstring))then
                     raise ExceptLGR.Create('Ce Code et sous-Code existe déjà pour une immobilisation portant sur le même compte',6002,true,mtError,Result);
               end;
             if not empty(editcourant.DataSet.findfield('Sous_code').AsString) then
               begin
                 if (DataModuleImmos.ExisteNumImmo(DataModuleImmos.taDetailImmo,editcourant.DataSet.findfield('compte').AsString,editcourant.AsString,editcourant.DataSet.findfield('Sous_code').AsString,DataModuleImmos.taDetailImmoID.asstring))then
                     raise ExceptLGR.Create('Ce Code et sous-Code existe déjà pour une immobilisation portant sur le même compte',5002,true,mtError,Result);
               end;
           end;
         1:Begin //si edit  Libelle
              if DataModuleImmos.taDetailImmo.state=dsinsert then
                LibelleEcriture:=qryListeAcquisLibelle.AsString
              else
                LibelleEcriture:=infosDetailAcquis.Libelle;
            with DataModuleImmos do
              Begin
              if empty(EditCourant.AsString)then
                EditCourant.AsString:=GererRemplissageLibelle(ListImmosEnCoursALier,LibelleEcriture,DataModuleImmos.DernierLibAffecte)
              else
                Begin
                  if ((ListImmosEnCoursALier_IndexOf(editcourant.AsString,1)<>-1)or(((ListImmosEnCoursALier.Count=0)and(DataModuleImmos.DernierLibAffecte=EditCourant.AsString)))or(EditCourant.AsString=LibelleEcriture)) then
                      EditCourant.AsString:=GererRemplissageLibelle(ListImmosEnCoursALier,LibelleEcriture,DataModuleImmos.DernierLibAffecte);
                End;
              End;//fin du with dataModuleImmos
           end;//fin si edit libelle
         7:Begin //si edit Date Acquisition
           if not DateValide(editcourant.Asstring)then
               raise ExceptLGR.Create('La date d"acquisition doit-être renseignée.',7001,true,mtError,Result)
             else
             if editcourant.AsDateTime>e.DatExoFin then
                 raise ExceptLGR.Create('La date d"acquisition doit faire partie de l''exercice courant.',7002,true,mtError,Result);
           end;
         13:Begin //si edit Date Debut Amort
           if not DateValide(datetostr(EditCourant.AsDateTime))then
               raise ExceptLGR.Create('La date de début d"amortissement n''est pas valide.',12001,true,mtError,Result);
           end;
         8:Begin //si edit Valeur Acquisition
             if ((empty(EditCourant.AsString))or(EditCourant.AsCurrency=0)) then
                  raise ExceptLGR.Create('Le montant '+EditCourant.AsString+' n'+#39+'est pas correct',8001,true,mtError,Result);
           end;
         17:Begin //si edit Montant Deduction
            //
           end;
         14:Begin //si edit Durée amortissement
             if ((Empty(EditCourant.AsString))or(EditCourant.Asinteger=0)) then
                   raise ExceptLGR.Create('La durée d"amortissement doit-être renseignée.',14001,true,mtError,Result)
             else
             if EditCourant.Asinteger < 12 then
                  raise ExceptLGR.Create('La durée d"amortissement doit être supérieure à 12 mois',14002,true,mtError,Result);
             if ((infosDetailAcquis.Duree_Amt<>DataModuleImmos.taDetailImmo.findfield('Duree_Amt').AsInteger)and(DataModuleImmos.taDetailImmo.state in [dsinsert,dsedit])) then
                 begin
                   tauxDegressif:=0;
                   DataModuleImmos.taDetailImmoTauxAmo.AsString:='';
                 end;
           end;
       end;//fin du case EditCourant.Tag
except
  abort;
end;//fin du try except       
End;

procedure TDataModuleImmos.taDetailImmoBeforeEdit(DataSet: TDataSet);
begin
Initialise_TinfosDetailAcquis(infosDetailAcquis);
RempliInfosDetailAcquis(infosDetailAcquis);
end;


procedure TDataModuleImmos.RempliInfosDetailAcquis(var infosDetailAcquis:TinfosDetailAcquis);
begin
infosDetailAcquis.id:=DataModuleImmos.taDetailImmo.findfield('id').AsInteger;;
infosDetailAcquis.Libelle:=DataModuleImmos.taDetailImmo.findfield('Libelle').AsString;
infosDetailAcquis.Date_Achat:=DataModuleImmos.taDetailImmo.findfield('Date_Achat').AsDateTime;
infosDetailAcquis.Ecriture_Achat:=DataModuleImmos.taDetailImmo.findfield('Ecriture_Achat').AsInteger;
infosDetailAcquis.Deduc_Invest:=DataModuleImmos.taDetailImmo.findfield('Deduc_Invest').AsBoolean;
infosDetailAcquis.Reprise_deduc_invest:=DataModuleImmos.taDetailImmo.findfield('Reprise_deduc_invest').AsCurrency;
infosDetailAcquis.Amort_Eco:=DataModuleImmos.taDetailImmo.findfield('Amort_Eco').AsCurrency;
infosDetailAcquis.Amort_Derog:=DataModuleImmos.taDetailImmo.findfield('Amort_Derog').AsCurrency;
infosDetailAcquis.Duree_Amt:=DataModuleImmos.taDetailImmo.findfield('Duree_Amt').AsInteger;
infosDetailAcquis.Mt_Cession:=DataModuleImmos.taDetailImmo.findfield('Mt_Cession').AsCurrency;
infosDetailAcquis.Rebut:=DataModuleImmos.taDetailImmo.findfield('Rebut').AsBoolean;
infosDetailAcquis.Achat_dans_Annee:=DataModuleImmos.taDetailImmo.findfield('Achat_dans_Annee').AsBoolean;
infosDetailAcquis.Cession_dans_Annee:=DataModuleImmos.taDetailImmo.findfield('Cession_dans_Annee').AsBoolean;
infosDetailAcquis.Maxi:=DataModuleImmos.taDetailImmo.findfield('Maxi').AsCurrency;
infosDetailAcquis.Mini:=DataModuleImmos.taDetailImmo.findfield('Mini').AsCurrency;
infosDetailAcquis.Choix:=DataModuleImmos.taDetailImmo.findfield('Choix').AsCurrency;
infosDetailAcquis.Eco:=DataModuleImmos.taDetailImmo.findfield('Eco').AsCurrency;
infosDetailAcquis.EnCours:=DataModuleImmos.taDetailImmo.findfield('EnCours').AsBoolean;
infosDetailAcquis.CodeTerminee:=DataModuleImmos.taDetailImmo.findfield('CodeTerminee').AsString;
infosDetailAcquis.CompteTerminee:=DataModuleImmos.taDetailImmo.findfield('CompteTerminee').AsString;
infosDetailAcquis.SousCodeTerminee:=DataModuleImmos.taDetailImmo.findfield('SousCodeTerminee').AsString;
infosDetailAcquis.TauxAmo:=DataModuleImmos.taDetailImmo.findfield('TauxAmo').AsFloat;
infosDetailAcquis.Type_Amt:=DataModuleImmos.taDetailImmo.findfield('Type_Amt').AsString;
end;


procedure TDataModuleImmos.TadetailImmoBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesCloture then
  MessageDlg('Vous ne pouvez plus modifier les immobilisations !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les immobilisations !', mtError, [mbOK], 0);
abort;
End;

procedure TDataModuleImmos.TadetailImmoBeforeEIDVerrouillage_Abort(DataSet: TDataSet);
Begin
 MessageDlg('Vous ne pouvez pas modifier cette immobilisation !', mtInformation, [mbOK], 0);
abort;
End;

procedure TDataModuleImmos.TaImmoChoixBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
  if @TimerDisabled<>nil then
    TimerDisabled(nil);
if not e.AccesCloture then
  MessageDlg('Vous ne pouvez plus modifier les immobilisations !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les immobilisations !', mtError, [mbOK], 0);
abort;
End;

procedure TDataModuleImmos.TaImmoChoixBeforeEIDVerrouillage_Abort(DataSet: TDataSet);
Begin
  if @TimerDisabled<>nil then
    TimerDisabled(nil);
 MessageDlg('Vous ne pouvez pas modifier cette immobilisation !', mtInformation, [mbOK], 0);
abort;
End;

Procedure TDataModuleImmos.GestionAccesImmos;
Begin
  case Quand of
     C_Mouvement:Begin
                  if ((E.AccesCloture)and(not DataModuleImmos.verrouillage)) then
                   begin
                      taDetailImmo.BeforeInsert := nil;
                      taDetailImmo.BeforeEdit := taDetailImmoBeforeEdit;
                      taDetailImmo.BeforeDelete := taDetailImmoBeforeDelete;
                      //
                      TaImmosRebut.BeforeInsert := nil;
                      TaImmosRebut.BeforeEdit := TaImmosRebutBeforeEdit;
                      TaImmosRebut.BeforeDelete := TaImmosRebutBeforeDelete;
                      //
                      TaImmosChoix.BeforeInsert := TaImmosChoixBeforeInsert;
                      TaImmosChoix.BeforeEdit := nil;
                      TaImmosChoix.BeforeDelete := TaImmosChoixBeforeDelete;
                      //
                      TaImmosEnCours.BeforeInsert := nil;
                      TaImmosEnCours.BeforeEdit := nil;
                      TaImmosEnCours.BeforeDelete := nil;
                      //
                      TaImmos_A_Ceder.BeforeInsert := TaImmos_A_CederBeforeInsert;
                      TaImmos_A_Ceder.BeforeEdit := TaImmos_A_CederBeforeEdit;
                      TaImmos_A_Ceder.BeforeDelete := TaImmos_A_CederBeforeDelete;
                      //
                      TaDivision.BeforeInsert := nil;
                      TaDivision.BeforeEdit := TaDivisionBeforeEdit;
                      TaDivision.BeforeDelete := TaDivisionBeforeDelete;
                      //
                      TaImmosRecalcul.BeforeInsert := nil;
                      TaImmosRecalcul.BeforeEdit := nil;
                      TaImmosRecalcul.BeforeDelete := nil;
                   end
                  else
                   if not e.AccesCloture then
                     begin
                      taDetailImmo.BeforeInsert := TadetailImmoBeforeEIDClo_Abort;
                      taDetailImmo.BeforeEdit := TadetailImmoBeforeEIDClo_Abort;
                      taDetailImmo.BeforeDelete := TadetailImmoBeforeEIDClo_Abort;
                      //
                      TaImmosRebut.BeforeInsert := TadetailImmoBeforeEIDClo_Abort;
                      TaImmosRebut.BeforeEdit := TadetailImmoBeforeEIDClo_Abort;
                      TaImmosRebut.BeforeDelete := TadetailImmoBeforeEIDClo_Abort;
                      //

                      // Attention, celui-ci est particulier
                      TaImmosChoix.BeforeInsert := TaImmoChoixBeforeEIDClo_Abort;
                      TaImmosChoix.BeforeEdit := TaImmoChoixBeforeEIDClo_Abort;
                      TaImmosChoix.BeforeDelete := TaImmoChoixBeforeEIDClo_Abort;
                      // Attention, celui-ci est particulier

                      //
                      TaImmosEnCours.BeforeInsert := TadetailImmoBeforeEIDClo_Abort;
                      TaImmosEnCours.BeforeEdit := TadetailImmoBeforeEIDClo_Abort;
                      TaImmosEnCours.BeforeDelete := TadetailImmoBeforeEIDClo_Abort;
                      //
                      TaImmos_A_Ceder.BeforeInsert := TadetailImmoBeforeEIDClo_Abort;
                      TaImmos_A_Ceder.BeforeEdit := TadetailImmoBeforeEIDClo_Abort;
                      TaImmos_A_Ceder.BeforeDelete := TadetailImmoBeforeEIDClo_Abort;
                      //
                      TaDivision.BeforeInsert := TadetailImmoBeforeEIDClo_Abort;
                      TaDivision.BeforeEdit := TadetailImmoBeforeEIDClo_Abort;
                      TaDivision.BeforeDelete := TadetailImmoBeforeEIDClo_Abort;
                      //
                      TaImmosRecalcul.BeforeInsert := TadetailImmoBeforeEIDClo_Abort;
                      TaImmosRecalcul.BeforeEdit := TadetailImmoBeforeEIDClo_Abort;
                      TaImmosRecalcul.BeforeDelete := TadetailImmoBeforeEIDClo_Abort;
                     end
                   else
                     begin
                      taDetailImmo.BeforeInsert := TadetailImmoBeforeEIDVerrouillage_Abort;
                      taDetailImmo.BeforeEdit := TadetailImmoBeforeEIDVerrouillage_Abort;
                      taDetailImmo.BeforeDelete := TadetailImmoBeforeEIDVerrouillage_Abort;
                      //
                      TaImmosRebut.BeforeInsert := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaImmosRebut.BeforeEdit := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaImmosRebut.BeforeDelete := TadetailImmoBeforeEIDVerrouillage_Abort;
                      //

                      // Attention, celui-ci est particulier
                      TaImmosChoix.BeforeInsert := TaImmoChoixBeforeEIDVerrouillage_Abort;
                      TaImmosChoix.BeforeEdit := TaImmoChoixBeforeEIDVerrouillage_Abort;
                      TaImmosChoix.BeforeDelete := TaImmoChoixBeforeEIDVerrouillage_Abort;
                      // Attention, celui-ci est particulier

                      //
                      TaImmosEnCours.BeforeInsert := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaImmosEnCours.BeforeEdit := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaImmosEnCours.BeforeDelete := TadetailImmoBeforeEIDVerrouillage_Abort;
                      //
                      TaImmos_A_Ceder.BeforeInsert := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaImmos_A_Ceder.BeforeEdit := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaImmos_A_Ceder.BeforeDelete := TadetailImmoBeforeEIDVerrouillage_Abort;
                      //
                      TaDivision.BeforeInsert := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaDivision.BeforeEdit := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaDivision.BeforeDelete := TadetailImmoBeforeEIDVerrouillage_Abort;
                      //
                      TaImmosRecalcul.BeforeInsert := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaImmosRecalcul.BeforeEdit := TadetailImmoBeforeEIDVerrouillage_Abort;
                      TaImmosRecalcul.BeforeDelete := TadetailImmoBeforeEIDVerrouillage_Abort;
                     end;
               End;
  end;
End;

Procedure Initialise_ParamDMimmos(ParamDMimmos:TParamDMimmos);
begin
   ParamDMimmos.typeImmos:=C_NonIndique;
   ParamDMimmos.typeAmort:=C_Lineaire;
   ParamDMimmos.TypePresentation:=0;
   ParamDMimmos.Quand:=0;
   ParamDMimmos.QuiAppel:=F_inconnu;
   ParamDMimmos.ImmosDataStateChange:=nil;
   ParamDMimmos.TimerEvent:=nil;
   ParamDMimmos.ImmosAfterScroll:=nil;
   ParamDMimmos.CptImmosAfterScroll:=nil;
   ParamDMimmos.CptImmosAfterOpen:=nil;
   ParamDMimmos.GEstInterfaceEvent:=nil;
   ParamDMimmos.Tag:=0;
   ParamDMimmos.ImmoCourante:=0;
   ParamDMimmos.verrouillage:=false;
   ParamDMimmos.Periode.DateDeb:=0;
   ParamDMimmos.Periode.DateFin:=0;
   ParamDMimmos.Periode.Retour:=true;
   ParamDMimmos.TypeModif:=RxInconnu;
end;
procedure TDataModuleImmos.TaDivisionAfterDelete(DataSet: TDataSet);
begin
  try
  TableGereCommit(DataSet);
  TableGereCommit(DMBalance.TaBalance);
  except
  TableGereRollBack(DataSet);
  TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
end;

procedure TDataModuleImmos.TaDivisionAfterPost(DataSet: TDataSet);
begin
  try
   TableGereCommit(DataSet);
   TableGereCommit(DMBalance.TaBalance);
  except
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
end;

procedure TDataModuleImmos.TaDivisionBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDataModuleImmos.TaDivisionBeforePost(DataSet: TDataSet);
var
coef:real;
//AmortAnnee:Tamortimmo;
i,NbEnreg:integer;
reference_:string;
begin
try//finally
//////
QuCptUtiliseImmos.DisableControls;
//ID_DernierCree:=-1;{ isa  le  05/04/04 }
  try
  reference_:='';
  if Tadivision.State in [dsinsert,dsedit]then
  begin //si table en insertion ou modification
  TableGereStartTransaction(Tadivision);
    with Tadivision do
      begin
        if taDivision.findfield('Type_Amt').AsString<>'N' then
        begin//si amortissable
           if VerificationSiPieceDeDotation(reference_)then
              if Application.MessageBox(PChar('Si vous divisez cette immobilisation, la pièce de dotation sera supprimée, voulez-vous continuer ?'),'Confirmation',MB_YESNO + MB_DEFBUTTON1) = IDYES then
                begin
                if DMImmo_Clo.SuppressionPieceDeDotationAmortissement(reference_,false)then
                  suppressionPieceDotation:=true;
                end
              else
                abort;
        end;//fin si amortissable
        Initialise_TinfosDivision(infosDivision);
        RecalculAmort_ApresModifDataset(dataset,choix_division,true);
      end;//fin du with
  end;//fin si table en insertion ou modification
  except
//    if not (DataModuleImmos.taDetailImmo.state = dsbrowse) then
//       DataModuleImmos.taDetailImmo.Cancel;
     TableGereRollBack(DataModuleImmos.taDivision);
  end;//fin du try except
/////
finally
  DataModuleImmos.QuCptUtiliseImmos.EnableControls;
end;
end;

procedure TDataModuleImmos.TaDivisionCalcFields(DataSet: TDataSet);
begin
TaDivision.FindField('VNC').AsCurrency:=TaDivision.findfield('Valeur_a_Amortir').ascurrency-(TaDivision.findfield('Amort_Eco').ascurrency+TaDivision.findfield('Amort_Derog').ascurrency)
end;

procedure TDataModuleImmos.TaImmosChoixAfterPost(DataSet: TDataSet);
begin
DataModuleImmos.TimerEvent(nil);
TaImmosChoix.Locate('id',ImmosEnCours.ID,[]);
end;

Function EditionAmort5AnsSimplifieL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;
var
periode:TPeriode;
i,K:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
TitreCompte:string;
cumul:TValeurSimplifie;
ParamAffichPeriode:TParamAffichPeriode;
Requete : TQuery;
TotMini1,TotMini2,TotMini3,TotMini4,TotMini5:currency;
TotMaxi1,TotMaxi2,TotMaxi3,TotMaxi4,TotMaxi5:currency;
FiltreInitial:string;

begin
try//finally
TotMini1:=0;
TotMini2:=0;
TotMini3:=0;
TotMini4:=0;
TotMini5:=0;
TotMaxi1:=0;
TotMaxi2:=0;
TotMaxi3:=0;
TotMaxi4:=0;
TotMaxi5:=0;
CompteCourant:='';
    ObjPrn:=TObjetEdition.Create(application.MainForm);
    Requete := TQuery.Create(application.MainForm);
    Requete.DatabaseName := DMRech.TaImmosRech.DatabaseName;

    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    if dataset = nil then
      begin
        dataset:=DataModuleImmos.QuAcquisition_Edition;
      end;

  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    FiltreInitial:=dataset.Filter;
    dataset.OnFilterRecord:=nil;
    dataset.Open;

        if (dataset is TQuery) then
          begin
            //faire ressortir une liste de compte du dataset passé en paramètre
            dataset.first;
           if (Compte<>nil)and(compte.Count=0)then abort;

            if(Compte=nil)then
              begin
                  Compte:=TStringList.Create;
                  Compte.Duplicates:=dupIgnore;
                  while not dataset.eof do
                  begin
                    if ((dataset.FindField('compte').AsString<>'') and (UpperCase(dataset.FindField('type_amt').AsString)<>'N')
                       and(dataset.FindField('amort_eco').AsCurrency+dataset.FindField('amort_derog').AsCurrency<dataset.FindField('valeur_a_amortir').AsCurrency)and(Compte.IndexOf(dataset.FindField('compte').AsString)=-1)) then
                      Compte.Add(dataset.FindField('compte').AsString);
                    dataset.next;
                  end;
              end;
            //permet de filtrer par rapport au compte courant;
            dataset.OnFilterRecord:=DataModuleImmos.EditionAmort5AnsCompteFilterRecord;

            for i:=0 to Compte.Count-1 do
              begin
                 if CompteCourant<>Compte.Strings[i] then
                      begin
                      //brancher un filterRecord sur compte courant
                      
//                          if FiltreInitial<>'' then
//                            FiltrageDataSet(dataset,FiltreInitial+' and (Compte = '''+ListeCompte.Strings[i]+''')')
//                          else
//                            FiltrageDataSet(dataset,'Compte = '''+ListeCompte.Strings[i]+'''');
                      CompteCourant:=Compte.Strings[i];
                      FiltrageDataSet(dataset,FiltreInitial);//accept que les immos du compte courant
                      Cumul:=CalculAmortissementSurSelection_Simplifie(dataset);
                      ListeValeur.Add('9; Compte : '+GereLibelle(CompteCourant));
                         ListeValeur.Add('0; ;Mini : '+
                         ';'+
                         E.FormatCurrSansDevise(cumul[1].Mini)+
                         ';'+
                         E.FormatCurrSansDevise(cumul[2].Mini)+
                         ';'+
                         E.FormatCurrSansDevise(cumul[3].Mini)+
                         ';'+
                         E.FormatCurrSansDevise(cumul[4].Mini)+
                         ';'+
                         E.FormatCurrSansDevise(cumul[5].Mini));

                         ListeValeur.Add('0; ;Maxi : '+
                         ';'+
                         E.FormatCurrSansDevise(cumul[1].Maxi)+
                         ';'+
                         E.FormatCurrSansDevise(cumul[2].Maxi)+
                         ';'+
                         E.FormatCurrSansDevise(cumul[3].Maxi)+
                         ';'+
                         E.FormatCurrSansDevise(cumul[4].Maxi)+
                         ';'+
                         E.FormatCurrSansDevise(cumul[5].Maxi));
                         TotMini1:= TotMini1+cumul[1].Mini;
                         TotMini2:= TotMini2+cumul[2].Mini;
                         TotMini3:= TotMini3+cumul[3].Mini;
                         TotMini4:= TotMini4+cumul[4].Mini;
                         TotMini5:= TotMini5+cumul[5].Mini;

                         TotMaxi1:= TotMaxi1+cumul[1].Maxi;
                         TotMaxi2:= TotMaxi2+cumul[2].Maxi;
                         TotMaxi3:= TotMaxi3+cumul[3].Maxi;
                         TotMaxi4:= TotMaxi4+cumul[4].Maxi;
                         TotMaxi5:= TotMaxi5+cumul[5].Maxi;
                       end; //fin si changement de compte
              end;//fin for ListeCompte.Count-1
          end
          else
          begin
                  Cumul:=CalculAmortissementSurSelection_Simplifie(dataset);
                  CompteCourant:= dataset.findfield('Compte').AsString;
                  ListeValeur.Add('9; Compte : '+GereLibelle(CompteCourant));
                     ListeValeur.Add('0; ;Mini : '+
                     ';'+
                     E.FormatCurrSansDevise(cumul[1].Mini)+
                     ';'+
                     E.FormatCurrSansDevise(cumul[2].Mini)+
                     ';'+
                     E.FormatCurrSansDevise(cumul[3].Mini)+
                     ';'+
                     E.FormatCurrSansDevise(cumul[4].Mini)+
                     ';'+
                     E.FormatCurrSansDevise(cumul[5].Mini));

                     ListeValeur.Add('0; ;Maxi : '+
                     ';'+
                     E.FormatCurrSansDevise(cumul[1].Maxi)+
                     ';'+
                     E.FormatCurrSansDevise(cumul[2].Maxi)+
                     ';'+
                     E.FormatCurrSansDevise(cumul[3].Maxi)+
                     ';'+
                     E.FormatCurrSansDevise(cumul[4].Maxi)+
                     ';'+
                     E.FormatCurrSansDevise(cumul[5].Maxi));

                             TotMini1:= TotMini1+cumul[1].Mini;
                             TotMini2:= TotMini2+cumul[2].Mini;
                             TotMini3:= TotMini3+cumul[3].Mini;
                             TotMini4:= TotMini4+cumul[4].Mini;
                             TotMini5:= TotMini5+cumul[5].Mini;

                             TotMaxi1:= TotMaxi1+cumul[1].Maxi;
                             TotMaxi2:= TotMaxi2+cumul[2].Maxi;
                             TotMaxi3:= TotMaxi3+cumul[3].Maxi;
                             TotMaxi4:= TotMaxi4+cumul[4].Maxi;
                             TotMaxi5:= TotMaxi5+cumul[5].Maxi;
          end;
             //ListeValeur.Add('3; Total Mini: '+compteTmp);
                     ListeValeur.Add('1;Total ; Mini   '+
                     ';'+
                     E.FormatCurrSansDevise(TotMini1)+
                     ';'+
                     E.FormatCurrSansDevise(TotMini2)+
                     ';'+
                     E.FormatCurrSansDevise(TotMini3)+
                     ';'+
                     E.FormatCurrSansDevise(TotMini4)+
                     ';'+
                     E.FormatCurrSansDevise(TotMini5));
                     ListeValeur.Add('1;Total ; Maxi   '+
                     ';'+
                     E.FormatCurrSansDevise(TotMaxi1)+
                     ';'+
                     E.FormatCurrSansDevise(TotMaxi2)+
                     ';'+
                     E.FormatCurrSansDevise(TotMaxi3)+
                     ';'+
                     E.FormatCurrSansDevise(TotMaxi4)+
                     ';'+
                     E.FormatCurrSansDevise(TotMaxi5));

             ObjPrn.FTitreEdition := 'TABLEAUX DES AMORTISSEMENTS SUR 5 ANS ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
             ObjPrn.Orientation := poLandscape;
             ListeValeur.Insert(0,' Compte ; Type ; 1ère Année ; 2ème Année ; 3ème Année ;  4ème Année ; 5ème Année  ');
             ListeValeur.Insert(1,'2;1; 1.5;1.5;1.5;1.5;1.5');
             ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr;curr');
             //ListeValeur.Insert(3,' Amortissement sur 5 ans ;SURTITRE');
           //  ListeValeur.Insert(4,'10.5');
             ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//     Initialise_TStringlist(ListeCompte);
     CompteCourant:='';
     dataset.OnFilterRecord:=nil;
     FiltrageDataSet(dataset,FiltreInitial);
//   ObjPrn.destroy;
end;
end;

Function EditionAmort5AnsSimplifieL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string):Boolean;overload;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     begin
       Maliste.Add(Compte);
     end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionAmort5AnsSimplifieL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;

Function EditionAmort5AnsSimplifieL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;overload;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (filtre)then
     begin
      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
     end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionAmort5AnsSimplifieL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;

Function EditionAmort5AnsL(TypeEdition : integer; DemandePeriode:Boolean; Compte:TStringList;DataSet:TDataSet;SousTitre:string):Boolean;
var
periode:TPeriode;
i,K:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
compteTmp:string;
TitreCompte:string;
cumul:TValeur;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);

  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);
    if dataset = nil then
      begin
        dataset:=DataModuleImmos.QuAcquisition_Edition;
      end;
       //on branche un filter record sur requete en passant une liste
        DataModuleImmos.ListeFilterRecordAcquisition.clear;
        if (Compte<>nil)and(compte.Count=0)then abort;
        
        if Compte<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du compte :'+compte.Strings[0]+' au compte :'+compte.Strings[compte.count-1];
          DataModuleImmos.ListeFilterRecordAcquisition.Assign(compte);
          dataset.OnFilterRecord:=DataModuleImmos.QuAcquisition_EditionFilterRecord;
          dataset.filtered:=true;
         end
        else
          begin
            DataModuleImmos.QuAcquisition_Edition.OnFilterRecord:=nil;
            Titrecompte:=' Tous les comptes ';
          end;
          if (dataset is TQuery) then
            DataModuleImmos.Filtrage_QuSelectionCalculAmort_SurTag((dataset as TQuery),C_SelectionSurImmo,false,-1,'');
          Cumul:=CalculAmortissementSurSelection_2(dataset);

             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[16].Mini));
             ListeValeur.Add('0;;;;Mini : '+E.FormatCurrSansDevise(cumul[8].Mini));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[16].Maxi));
             ListeValeur.Add('0;;;Mini : '+E.FormatCurrSansDevise(cumul[4].Mini));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[17].Mini));
             ListeValeur.Add('0;;;;Maxi : '+E.FormatCurrSansDevise(cumul[8].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[17].Maxi));
             ListeValeur.Add('0;;Mini : '+E.FormatCurrSansDevise(cumul[2].Mini));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[18].Mini));
             ListeValeur.Add('0;;;;Mini : '+E.FormatCurrSansDevise(cumul[9].Mini));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[18].Maxi));
             ListeValeur.Add('0;;;Maxi : '+E.FormatCurrSansDevise(cumul[4].Maxi));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[19].Mini));
             ListeValeur.Add('0;;;;Maxi : '+E.FormatCurrSansDevise(cumul[9].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[19].Maxi));
             ListeValeur.Add('0;Mini : '+E.FormatCurrSansDevise(cumul[1].Mini));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[20].Mini));
             ListeValeur.Add('0;;;;Mini : '+E.FormatCurrSansDevise(cumul[10].Mini));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[20].Maxi));
             ListeValeur.Add('0;;;Mini : '+E.FormatCurrSansDevise(cumul[5].Mini));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[21].Mini));
             ListeValeur.Add('0;;;;Maxi : '+E.FormatCurrSansDevise(cumul[10].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[21].Maxi));
             ListeValeur.Add('0;;Maxi : '+E.FormatCurrSansDevise(cumul[2].Maxi));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[22].Mini));
             ListeValeur.Add('0;;;;Mini : '+E.FormatCurrSansDevise(cumul[11].Mini));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[22].Maxi));
             ListeValeur.Add('0;;;Maxi : '+E.FormatCurrSansDevise(cumul[5].Maxi));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[23].Mini));
             ListeValeur.Add('0;;;;Maxi : '+E.FormatCurrSansDevise(cumul[11].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[23].Maxi));

//             //coupure page
//             ListeValeur.Add('15');

             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[24].Mini));
             ListeValeur.Add('0;;;;Mini : '+E.FormatCurrSansDevise(cumul[12].Mini));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[24].Maxi));
             ListeValeur.Add('0;;;Mini : '+E.FormatCurrSansDevise(cumul[6].Mini));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[25].Mini));
             ListeValeur.Add('0;;;;Maxi : '+E.FormatCurrSansDevise(cumul[12].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[25].Maxi));
             ListeValeur.Add('0;;Mini : '+E.FormatCurrSansDevise(cumul[3].Mini));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[26].Mini));
             ListeValeur.Add('0;;;;Mini : '+E.FormatCurrSansDevise(cumul[13].Mini));
             ListeValeur.Add('0;;;Maxi : '+E.FormatCurrSansDevise(cumul[6].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[26].Maxi));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[27].Mini));
             ListeValeur.Add('0;;;;Maxi : '+E.FormatCurrSansDevise(cumul[13].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[27].Maxi));
             ListeValeur.Add('0;Maxi : '+E.FormatCurrSansDevise(cumul[1].Maxi));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[28].Mini));
             ListeValeur.Add('0;;;;Mini : '+E.FormatCurrSansDevise(cumul[14].Mini));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[28].Maxi));
             ListeValeur.Add('0;;;Mini : '+E.FormatCurrSansDevise(cumul[7].Mini));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[29].Mini));
             ListeValeur.Add('0;;;;Maxi : '+E.FormatCurrSansDevise(cumul[14].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[29].Maxi));
             ListeValeur.Add('0;;Maxi : '+E.FormatCurrSansDevise(cumul[3].Maxi));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[30].Mini));
             ListeValeur.Add('0;;;;Mini : '+E.FormatCurrSansDevise(cumul[15].Mini));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[30].Maxi));
             ListeValeur.Add('0;;;Maxi : '+E.FormatCurrSansDevise(cumul[7].Maxi));
             ListeValeur.Add('0;;;;;Mini : '+E.FormatCurrSansDevise(cumul[31].Mini));
             ListeValeur.Add('0;;;;Maxi : '+E.FormatCurrSansDevise(cumul[15].Maxi));
             ListeValeur.Add('0;;;;;Maxi : '+E.FormatCurrSansDevise(cumul[31].Maxi));

             ObjPrn.FTitreEdition := 'TABLEAUX DES AMORTISSEMENTS SUR 5 ANS ';
             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
             ObjPrn.Orientation := poLandscape;
             ListeValeur.Insert(0,' 1ère Année ; 2ème Année ; 3ème Année ;  4ème Année ; 5ème Année  ');
             ListeValeur.Insert(1,'1.5;1.5;1.5;1.5;1.5');
             ListeValeur.Insert(2,'texte;texte;texte;texte;texte');
             //ListeValeur.Insert(3,' Amortissement sur 5 ans ;SURTITRE');
           //  ListeValeur.Insert(4,'7.5');
             ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;

Function EditionAmort5AnsL(TypeEdition : integer; DemandePeriode:Boolean; Compte:String;DataSet:TDataSet;SousTitre:string):Boolean;overload;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     begin
       Maliste.Add(Compte);
     end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionAmort5AnsL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;

Function EditionAmort5AnsL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet;SousTitre:string):Boolean;overload;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (filtre)then
     begin
      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
     end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionAmort5AnsL(TypeEdition,DemandePeriode,Maliste,DataSet,SousTitre);
  except
     abort;
  end;
end;



Function CalculAmortissementSurSelection_2(DatasetCalcul:Tdataset):Tvaleur;
var
dateDebutExo,DateFinExo:TDateTime;
i, j, k,L,conteneur:integer;
Valeur:TValeur;
immocourante,immocouranteTmp:TInfosImmos;
AmortAnnee:TAmortImmo;
choix_Choix:Tchoix;
EcoTmp:currency;
begin
try//finally
//showmessage('Calcul');
   with DatasetCalcul do
      begin
          Screen.Cursor := crSQLWait;
          First;
          raz(result);
          while not eof do
              begin
                raz(Valeur);
                dateDebutExo:=e.DatExoDebut;
                DateFinExo:=e.DatExoFin;
                initialiserChoix(choix_Choix);
                Remplit_TInfosImmos(DatasetCalcul,immocourante);
//                if ((immocourante.Type_Amt<>'N')and((immocourante.Amort_Eco+immocourante.Amort_Derog)<immocourante.Valeur_a_Amortir)) then
                begin
                immocouranteTmp:=immocourante;
//        // traiter les 5 années
                 for i := 1 to 5 do
                    begin
                    L:=0;
                    k := 1 shl (i - 1);
                    for j := 1 to k do
                        begin  // de 1 à 2^(i-1)
                            if (k + j - 1)>1 then
                              immocourante:=Calcule_Valeur_Ancetre((k + j - 1),valeur,immocourante);
                            AmortAnnee:=DataModuleImmos.CalculerAmortAnneeSurImmo(immocourante,dateDebutExo,DateFinExo,choix_Choix);
                            Valeur[k + j - 1].Mini :=AmortAnnee.Mini;
                            Valeur[k + j - 1].Maxi := AmortAnnee.Maxi;
                            Valeur[k + j - 1].pere := (k + j - 1) div 2;
                            Valeur[k + j - 1].annee := i;
                            Valeur[k + j - 1].eco:=amortAnnee.EcoRepartition;
                            EcoTmp:=amortAnnee.EcoRepartition;
                            if (k + j - 1) > 1 then
                             begin
                                   //calcul derog et ecoRepartition si mini
                                   AmortAnnee.Choix:=AmortAnnee.Mini;
                                   DataModuleImmos.CalculDerogSurImmos(AmortAnnee);
                                   if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
                                      EcoTmp:=AmortAnnee.Choix-AmortAnnee.Derog;{ isa  le  13/03/04 }
                                   if L mod 2=0 then
                                       Valeur[k + j - 1].AmortCumulMini:=valeur[(k + j - 1) div 2].AmortCumulMini+EcoTmp+AmortAnnee.Derog
                                   else
                                       Valeur[k + j - 1].AmortCumulMini:=valeur[(k + j - 1) div 2].AmortCumulMaxi+EcoTmp+AmortAnnee.Derog;
                                   //calcul derog et ecorepartition si maxi
                                   AmortAnnee.Choix:=AmortAnnee.Maxi;
                                   DataModuleImmos.CalculDerogSurImmos(AmortAnnee);
                                   if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
                                      EcoTmp:=AmortAnnee.Choix-AmortAnnee.Derog;{ isa  le  13/03/04 }
                                   if L mod 2=0 then
                                       Valeur[k + j - 1].AmortCumulMaxi:=valeur[(k + j - 1) div 2].AmortCumulMini+EcoTmp+AmortAnnee.Derog
                                   else
                                       Valeur[k + j - 1].AmortCumulMaxi:=valeur[(k + j - 1) div 2].AmortCumulMaxi+EcoTmp+AmortAnnee.Derog;
                             end
                             else
                             begin
                                   Valeur[k + j - 1].AmortCumulMini:=Valeur[k + j - 1].Mini+immocourante.Amort_Eco+immocourante.Amort_Derog;
                                   Valeur[k + j - 1].AmortCumulMaxi:=Valeur[k + j - 1].maxi+immocourante.Amort_Eco+immocourante.Amort_Derog;
                             end;
                            inc(L);
                        end;//fin de 1 à 2^(i-1)
                    DateFinExo:=MoisSuivant(DateFinExo,11).Date_;
                    dateDebutExo:=MoisSuivant(dateDebutExo,11).Date_;
                    end;//fin du for i := 1 to 5
                 ajoute(Valeur, result);
                 end;//fin si amortissable
                next;
              end;//fin du while
      end;//fin du with DatasetCalcul
finally
Screen.Cursor := crDefault;
end;//fin du try finally      
end;


Function CalculAmortissementSurSelection_Simplifie(DatasetCalcul:Tdataset):TValeurSimplifie;
var
dateDebutExo,DateFinExo:TDateTime;
i, conteneur:integer;
Valeur:TValeurSimplifie;
immocourante,immocouranteTmp:TInfosImmos;
AmortAnnee:TAmortImmo;
choix_Choix:Tchoix;
EcoTmp:currency;
begin
try//finally
   with DatasetCalcul do
      begin
          Screen.Cursor := crSQLWait;
          First;
          razSimplifie(result);
          while not eof do
              begin
                razSimplifie(Valeur);
                dateDebutExo:=e.DatExoDebut;
                DateFinExo:=e.DatExoFin;
                initialiserChoix(choix_Choix);
                Remplit_TInfosImmos(DatasetCalcul,immocourante);
                immocouranteTmp:=immocourante;
//        // traiter les 5 années
                 for i := 1 to 5 do
                    begin
                            //Traitement du Mini
                            if i > 1 then
                              immocourante:=Calcule_Valeur_AncetreSimplifie((i),valeur,immocourante);
                            AmortAnnee:=DataModuleImmos.CalculerAmortAnneeSurImmo(immocourante,dateDebutExo,DateFinExo,choix_Choix);
                            Valeur[i].Mini :=AmortAnnee.Mini;
                            if i > 1 then
                             begin
                                   //calcul derog et ecoRepartition si mini
                                   EcoTmp:=AmortAnnee.Mini;
                                   AmortAnnee.Choix:=AmortAnnee.Mini;
                                   DataModuleImmos.CalculDerogSurImmos(AmortAnnee);
                                   if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
                                       EcoTmp:=AmortAnnee.Choix-AmortAnnee.Derog;{ isa  le  13/03/04 }
                                   Valeur[i].AmortCumulMini:=valeur[(i - 1)].AmortCumulMini+EcoTmp+AmortAnnee.Derog;
                             end
                            else Valeur[i].AmortCumulMini:=Valeur[i].Mini+immocourante.Amort_Eco+immocourante.Amort_Derog;
                            //Traitement du Maxi
                            if i > 1 then
                              immocourante:=Calcule_Valeur_AncetreSimplifie((i),valeur,immocourante,true);
                            AmortAnnee:=DataModuleImmos.CalculerAmortAnneeSurImmo(immocourante,dateDebutExo,DateFinExo,choix_Choix);
                            Valeur[i].Maxi := AmortAnnee.Maxi;
                            if i > 1 then
                             begin
                                   //calcul derog et ecorepartition si maxi
                                   EcoTmp:=AmortAnnee.Maxi;
                                   AmortAnnee.Choix:=AmortAnnee.Maxi;
                                   DataModuleImmos.CalculDerogSurImmos(AmortAnnee);
                                   if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
                                      EcoTmp:=AmortAnnee.Choix-AmortAnnee.Derog;{ isa  le  13/03/04 }
                                   Valeur[i].AmortCumulMaxi:=valeur[(i - 1)].AmortCumulMaxi+EcoTmp+AmortAnnee.Derog;
                             end
                            else Valeur[i].AmortCumulMaxi:=Valeur[i].maxi+immocourante.Amort_Eco+immocourante.Amort_Derog;

                    Valeur[i].pere := (i - 1);
                    Valeur[i].annee := i;
                    Valeur[i].eco:=amortAnnee.EcoRepartition;
                    EcoTmp:=amortAnnee.EcoRepartition;

                        //end;//fin de 1 à 2^(i-1)
                    DateFinExo:=MoisSuivant(DateFinExo,11).Date_;
                    dateDebutExo:=MoisSuivant(dateDebutExo,11).Date_;
                    end;//fin du for i := 1 to 5
                 ajouteSimplifie(Valeur, result);
                next;
              end;//fin du while
      end;//fin du with DatasetCalcul
finally
Screen.Cursor := crDefault;
end;//fin du try finally      
end;


function Calcule_Valeur_Ancetre(j:integer; Valeur:TValeur; var ImmosCourante:TinfosImmos):TinfosImmos;
var ancetre:integer; VN:Currency;
begin
// retourne la VNC en fonction des choix déjà effectués

   result:=ImmosCourante;
   ancetre := j div 2;
   if odd(j) then
      begin
        Result.Choix := arrondicentieme(Valeur[ancetre].Maxi);
        Result.Amort_Eco :=arrondicentieme(Valeur[ancetre].AmortCumulMaxi);
      end
   else
      begin
        Result.Choix := arrondicentieme(Valeur[ancetre].Mini);
        Result.Amort_Eco :=arrondicentieme(Valeur[ancetre].AmortCumulMini);
      end;
end;


function Calcule_Valeur_AncetreSimplifie(j:integer; Valeur:TValeurSimplifie; var ImmosCourante:TinfosImmos;Maxi : boolean):TinfosImmos;
var ancetre:integer; VN:Currency;
begin
// retourne la VNC en fonction des choix déjà effectués
if j-1>0 then
  begin
     result:=ImmosCourante;
     ancetre := j -1;
     if Maxi then
       begin
           Result.Choix := arrondicentieme(Valeur[ancetre].Maxi);
           Result.Amort_Eco :=arrondicentieme(Valeur[ancetre].AmortCumulMaxi);
       end
     else
       begin
           Result.Choix := arrondicentieme(Valeur[ancetre].Mini);
           Result.Amort_Eco :=arrondicentieme(Valeur[ancetre].AmortCumulMini);
       end;
  end;
end;


procedure raz(var Valeur:TValeur);
var i:integer;
begin
// Remise à 0 du tableau Valeur
	for i := 1 to 31 do
   begin
     with Valeur[i] do
      begin
      	Mini := 0;
        Maxi := 0;
        annee := 0;
        pere := 0;
        AmortCumulMini:=0;
        AmortCumulMaxi:=0;
        MiniCumul:=0;
      end;
   end;
end;

procedure ajoute(var Valeur, cumul:TValeur);
var i:integer;
begin
// Cumul des valeurs
	for i := 1 to 31 do begin
      with cumul[i] do begin
         Mini := Mini + Valeur[i].Mini;
         Maxi := Maxi + Valeur[i].Maxi;
         pere := Valeur[i].pere;
         annee := Valeur[i].annee;
      end;
   end;
end;


procedure razSimplifie(var Valeur:TValeurSimplifie);
var i:integer;
begin
// Remise à 0 du tableau Valeur
	for i := 1 to 5 do
   begin
     with Valeur[i] do
      begin
      	Mini := 0;
        Maxi := 0;
        annee := 0;
        pere := 0;
        AmortCumulMini:=0;
        AmortCumulMaxi:=0;
        MiniCumul:=0;
      end;
   end;
end;

procedure ajouteSimplifie(var Valeur, cumul:TValeurSimplifie);
var i:integer;
begin
// Cumul des valeurs
	for i := 1 to 5 do begin
      with cumul[i] do begin
         Mini := Mini + Valeur[i].Mini;
         Maxi := Maxi + Valeur[i].Maxi;
         pere := Valeur[i].pere;
         annee := Valeur[i].annee;
      end;
   end;
end;

procedure TDataModuleImmos.TaDivisionAfterInsert(DataSet: TDataSet);
begin
InitChampAfterInsert([0,nil,0,0,nil,nil,nil,nil,0,0,0,0,nil,nil,0,nil,false,0,0,0,0,0,0,nil,false,false,false,0,nil,false,0,0,0,0,false,false,nil,nil,0,nil,nil,0],DataSet);
end;



Function TDataModuleImmos.RemplirChoixAvantModif(Dataset:TDataset;ImmosEnCours:TInfosImmos):Tchoix;
var
amortissement:TAmortImmo;
begin
Remplit_TInfosImmos(Dataset,ImmosEnCours);
initialiserChoix(Result);
amortissement:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,Result);
amortissement.Choix:=Dataset.findfield('Choix').AsCurrency;

if not((QuiAppel =F_detailAcquis)and(Dataset.State in [dsinsert]))then
  begin
//      case QuiAppel of
//           F_Cession,F_Rebut: Result.ChoixItem:=1;
//           else
//              begin
              if ((amortissement.Choix<>amortissement.Mini)and(amortissement.Choix<>amortissement.Maxi))then
               begin
                 Result.choixDefaut:=amortissement.Choix;
                 Result.ChoixItem:=2;
               end
              else
                if amortissement.Choix=amortissement.Mini then Result.ChoixItem:=0
                else
                  if amortissement.Choix=amortissement.Maxi then Result.ChoixItem:=1;
//             end;
//      end;//fin du case
  end;
end;

procedure TDataModuleImmos.TaDivisionBeforeEdit(DataSet: TDataSet);
begin
Choix_Division:=RemplirChoixAvantModif(dataset,ImmosEnCours);
end;



Procedure TDataModuleImmos.RecalculAmort_ApresModifDataset(Dataset:TDataset;ChoixAvantModif:Tchoix;ConserverChoix:boolean);
var
AmortAnnee:Tamortimmo;
begin
initialiserAmortissement(AmortAnnee);
  //recalculer le dérogatoire et l'Eco
  if Dataset.findfield('Type_Amt').AsString<>'N' then
  Begin
     Remplit_TInfosImmos(Dataset,ImmosEnCours);
     AmortAnnee:=CalculerAmortAnneeSurImmo(ImmosEnCours,e.DatExoDebut,e.DatExoFin,ChoixAvantModif,ConserverChoix);
     if AmortAnnee.Choix-AmortAnnee.Derog<>AmortAnnee.EcoRepartition then
        AmortAnnee.EcoRepartition:=AmortAnnee.Choix-AmortAnnee.Derog; { isa  le  13/03/04 }
  End;

Dataset.findfield('Eco').AsCurrency:=AmortAnnee.EcoRepartition;
Dataset.findfield('Mini').AsCurrency:=amortannee.Mini;
Dataset.findfield('Maxi').AsCurrency:=amortannee.Maxi;
Dataset.findfield('Choix').AsCurrency:=amortannee.choix;
end;


function TDataModuleImmos.ImmosCedee(ImmoEnCours:TInfosImmos):boolean;
begin
//une immo est cédée quand les champs suivant sont remplis
//EcritureCession est remplie avec l'identifiant de l'ecriture de cession
//dateCession est remplie
//MontantCession est Remplie
//Rebut=false
//Cession_Dans_Annee est <> nil
//Terminée =false
result:=((ImmoEnCours.Ecriture_Cession<>0)and(ImmoEnCours.Date_Cession<>0)and(ImmoEnCours.Mt_Cession<>0)and(ImmoEnCours.Terminee=false)) ;
end;

function TDataModuleImmos.ImmosRebut(ImmoEnCours:TInfosImmos):boolean;
begin
//une immo est considérée comme mise au Rebut quand les champs suivant sont remplis
//EcritureCession n'est pas rempli
//MontantCession n'est pas rempli
//Rebut=True
//Terminée =false
result:=((ImmoEnCours.Ecriture_Cession=0)and(ImmoEnCours.Mt_Cession=0)and(ImmoEnCours.Rebut=true)and(ImmoEnCours.Terminee=false)) ;
end;


function TDataModuleImmos.ImmosTerminee(ImmoEnCours:TInfosImmos):boolean;
begin
//une immo est considérée comme Terminee quand les champs suivant ont comme valeur :
//EcritureCession n'est pas rempli
//dateCession n'est pas rempli
//MontantCession n'est pas rempli
//Terminée =true

//!!!!je n'ai pas mis dans cette condition le champ Rebut=false car pour l'instant on se sert de ce champ en le mettant à "true"
//plus le champ "terminee=true" pour que les immos terminées n'apparaissent plus après la clôture tant que les gens n'ont
//pas la nouvelle version, ensuite il me faudra faire une moulinette pour remettre le champ "Rebut=false" dans le cadre
//d'une immo terminée !!!!

result:=((ImmoEnCours.Ecriture_Cession=0)and(ImmoEnCours.Mt_Cession=0)and(ImmoEnCours.Terminee=true)) ;
end;


Function TDataModuleImmos.InitialisationImmoEnCoursSurModif(Dataset:TDataset):TExceptLGR;
var
Query:TQuery;
begin
try//finally
try//except
Query:=TQuery.Create(application.MainForm);
Initialise_ExceptLGR(result);
if dataset<>nil then
  begin
//  filtrageDataset(dataset,'Terminee=faux and compteTerminee is not null');
//  dataset.First;
  while not (dataset.Eof) do
      begin
        dataset.First;
          with dataset do
            begin
              tablegereedit(dataset);
                  findfield('terminee').asboolean:=false;
                  findfield('CompteTerminee').asstring:='';
                  findfield('CodeTerminee').asstring:='';
                  findfield('SousCodeTerminee').asstring:='';
                  findfield('Date_Cession').asstring:='';
                  findfield('Cession_dans_annee').asboolean:=false;
                  findfield('Rebut').AsBoolean:=false;
              tablegerePost(dataset);
            end;
      end;//fin du while not eof
  end//fin si dataset<>nil
else
  Begin
    Query.DatabaseName:=DM_C_NomAliasDossier;
    Query.SQL.Clear;
    Query.SQL.Add('update immos.db set compteTerminee = null, codeTerminee = null, souscodeTerminee = null,Date_Cession=null,Cession_dans_annee=false,Rebut=false');
    Query.SQL.Add('where compte like (''23%'') and terminee=false and ((compteTerminee is not null)or(codeTerminee is not null)or(SouscodeTerminee is not null))');
    Query.ExecSQL;
  end;
except
  result.retour:=false
end;//fin du try except
finally
  Query.Close;
  libereobjet(Tobject(Query));
end;//fin du try finally
end;



Function TDataModuleImmos.InitialisationImmoEnCours(Dataset:TDataset;Terminer:boolean):TExceptLGR;
var
Query:TQuery;
begin
try//finally
try//except
Query:=TQuery.Create(application.MainForm);
Initialise_ExceptLGR(result);
if dataset<>nil then
  begin
  dataset.First;
  while not (dataset.Eof) do
      begin
        dataset.First;
          with dataset do
            begin
              tablegereedit(dataset);
              if terminer then
              begin
                  findfield('terminee').asboolean:=true;
                  findfield('CompteTerminee').asstring:='-';
                  findfield('CodeTerminee').asstring:='-';
                  findfield('SousCodeTerminee').asstring:='-';
                  findfield('Date_Cession').AsDateTime:=e.DatExoFin;
                  findfield('Cession_dans_annee').asboolean:=true;
                  findfield('Rebut').AsBoolean:=false;
              end
              else
              begin
                  findfield('terminee').asboolean:=false;
                  findfield('CompteTerminee').asstring:='';
                  findfield('CodeTerminee').asstring:='';
                  findfield('SousCodeTerminee').asstring:='';
                  findfield('Date_Cession').asstring:='';
                  findfield('Cession_dans_annee').asboolean:=false;
                  findfield('Rebut').AsBoolean:=false;
              end;
              tablegerePost(dataset);
              DataSet.Next;
            end;
      end;//fin du while not eof
  end;//fin si dataset<>nil
except
  result.retour:=false
end;//fin du try except
finally
  Query.Close;
  libereobjet(Tobject(Query));
end;//fin du try finally
end;



procedure TDataModuleImmos.taDetailImmoAfterCancel(DataSet: TDataSet);
begin
if DataModuleImmos.TaImmosEnCours.State in [dsedit,dsinsert] then
    DataModuleImmos.TaImmosEnCours.cancel;
TableGereRollBack(DataModuleImmos.TaImmosEnCours);
end;

procedure TDataModuleImmos.qryListeAcquisFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if ((ListeImmobilisable<>nil)and(ListeImmobilisable.Count<>0)) then
  accept:=  ListeImmobilisable.IndexOf(qryListeAcquisCompte.asstring)<>-1;
end;

Function AffichInfoImmos(Affiche:boolean):TParamHistorique;
var
ParamAffichage:TParamAffichage;
List1:TStringList;
RetourVisuListe:TRetourViewListe;
begin
try
List1:=TStringList.Create;
DeFiltrageDataSet(DataModuleImmos.tableimmos);
List1:=ChampTableVersListeEx(['Libelle','Ecriture_Achat','Ecriture_Cession','compte','code','Sous_Code','Date_Org',
                              'Valeur_Org','Valeur_Venale','Duree','Valeur_a_Amortir','Date_Achat','Date_Mise_en_service',
                              'Duree_amt','type_amt','Amort_eco','amort_derog','mt_cession','date_cession','rebut','achat_dans_annee',
                              'cession_dans_annee','duree_restante','sous_compte','maxi','mini','choix','eco','terminee','encours',
                              'Compteterminee','codeterminee','souscodeterminee','tauxamo'],DataModuleImmos.tableimmos,';',true);
List1.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'TableImmos.txt');
Initialise_TParamAffichage(ParamAffichage);
ParamAffichage.AffichModal := true;
ParamAffichage.Titre:='Liste des immobilisations';
result.Periode.Retour:=List1.Count<>0;
if result.Periode.Retour then
  begin
     if VisuListeView=nil then VisuListeView:=TVisuListeView.Create(application.MainForm);
     ParamAffichage.EventButtonDetailClick:=VisuListeView.BtnEnregistrerClick;
     ParamAffichage.EventButtonValiderClick:=nil;
     ParamAffichage.EventListViewDbleClick:=VisuListeView.BtnEnregistrerClick;
     RetourVisuListe:=AfficheVisuListView(ParamAffichage,['Libelle','Ecriture_Achat','Ecriture_Cession','compte','code','Sous_Code','Date_Org',
                                      'Valeur_Org','Valeur_Venale','Duree','Valeur_a_Amortir','Date_Achat','Date_Mise_en_service','Duree_amt',
                                      'type_amt','Amort_eco','amort_derog','mt_cession','date_cession','rebut','achat_dans_annee',
                                      'cession_dans_annee','duree_restante','sous_compte','maxi','mini','choix','eco',
                                      'terminee','encours','Compteterminee','codeterminee','souscodeterminee','tauxamo'],
                                      [70,60,60,50,50,50,70,70,70,50,70,70,70,50,50,70,70,70,70,50,50,50,50,60,70,70,70,70,50,50,70,50,50,50],                                      [List1],
                                      [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                      taRightJustify,taRightJustify,taRightJustify,taRightJustify,taLeftJustify,taLeftJustify,taRightJustify,
                                      taLeftJustify,taRightJustify,taRightJustify,taRightJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                      taLeftJustify,taRightJustify,taLeftJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify,
                                      taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taRightJustify],
                                      [1..6,15,20..22,24,29..33],
                                      [8..11,14,16..18,23,25..28,33],[7,12,13,19]);
     result.Periode.Retour:=RetourVisuListe.Retour;
  End;
finally
  if list1<>nil then list1.free;
end;//fin du try finally
End;


procedure TDataModuleImmos.tbPMVFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if ((DataSet<>nil)and(DataSet.FindField('compte')<>nil))then
  accept:=copy(DataSet.FindField('compte').AsString,1,2)<>'13';
end;


procedure TDataModuleImmos.EditionAmort5AnsCompteFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
   accept:=(CompteCourant=dataset.FindField('compte').AsString);
end;
procedure TDataModuleImmos.QuImmosEditionModifiableCalcFields(
  DataSet: TDataSet);
  var pvCT, pvLT:Currency;
begin
  QuImmosEditionModifiableCodeLong.AsString:=QuImmosEditionModifiableCode.AsString+' '+QuImmosEditionModifiableSous_Code.AsString;
  QuImmosEditionModifiableexercice.AsCurrency:=QuImmosEditionModifiableChoix.AsCurrency;
  QuImmosEditionModifiablecumul.AsCurrency:=QuImmosEditionModifiableAmort_Eco.AsCurrency+QuImmosEditionModifiableAmort_Derog.AsCurrency+QuImmosEditionModifiableChoix.AsCurrency;
  QuImmosEditionModifiablenet.AsCurrency:=QuImmosEditionModifiableValeur_a_Amortir.AsCurrency-QuImmosEditionModifiableAmort_Eco.AsCurrency-QuImmosEditionModifiableAmort_Derog.AsCurrency-QuImmosEditionModifiableChoix.AsCurrency;
  QuImmosEditionModifiablevaleur_res.AsCurrency := QuImmosEditionModifiableValeur_a_Amortir.AsCurrency-QuImmosEditionModifiablecumul.AsCurrency;
  QuImmosEditionModifiablePlusvalue.AsCurrency := QuImmosEditionModifiableMt_Cession.AsCurrency-QuImmosEditionModifiablevaleur_res.AsCurrency;

  if QuImmosEditionModifiableValeur_Org.AsCurrency=0 then
      QuImmosEditionModifiableamort_forfait.AsCurrency:=0
  else
      QuImmosEditionModifiableamort_forfait.AsCurrency:= QuImmosEditionModifiableValeur_a_Amortir.AsCurrency-QuImmosEditionModifiableValeur_Org.AsCurrency;

  Calcule_PM_Values(pvCT,PVLT,QuImmosEditionModifiable);
  if pvCT<0 then begin
      //moins value
      QuImmosEditionModifiablePVCourtTerme.AsCurrency:=0;
      QuImmosEditionModifiableMVCourtTerme.AsCurrency:=-pvCT;
  end
  else begin
      //plus value
      QuImmosEditionModifiablePVCourtTerme.AsCurrency:=pvCT;
      QuImmosEditionModifiableMVCourtTerme.AsCurrency:=0;
  end;
  if pvLT<0 then begin
      //moins value
      QuImmosEditionModifiablePVLongTerme.AsCurrency:=0;
      QuImmosEditionModifiableMVLongTerme.AsCurrency:=-pvLT;
  end
  else begin
      //plus value
      QuImmosEditionModifiablePVLongTerme.AsCurrency:=pvLT;
      QuImmosEditionModifiableMVLongTerme.AsCurrency:=0;
  end;

  QuImmosEditionModifiableamort_reel.AsCurrency:=QuImmosEditionModifiablecumul.AsCurrency;
end;



function TDataModuleImmos.CalculRepriseDeduction(Dataset:TDataSet):currency;
begin
result:=0;

if(Dataset.findfield('date_cession').Value = null) or
  (libdates.DateDsIntervale(E.DatExoDebut,Dataset.findfield('date_cession').AsDateTime,E.DatExoFin) )then
  begin
      if (str_commence_par(Dataset.findfield('compte').AsString,'262'))and
      (not libdates.DateDsIntervale(E.DatExoDebut,Dataset.findfield('date_achat').AsDateTime,E.DatExoFin))then
        begin
           result:=Dataset.findfield('Mt_Deduc_Invest').AsCurrency/10;
        end
      else
        begin
           if (Dataset.findfield('Valeur_a_Amortir').AsCurrency<>0)then
           result:=(Dataset.findfield('choix').AsCurrency/Dataset.findfield('Valeur_a_Amortir').AsCurrency*
               Dataset.findfield('Mt_Deduc_Invest').AsCurrency);
        end;
  if Dataset.findfield('Reprise_deduc_invest').AsCurrency+result>Dataset.findfield('Mt_Deduc_Invest').AsCurrency then
      result:=Dataset.findfield('Mt_Deduc_Invest').AsCurrency-Dataset.findfield('Reprise_deduc_invest').AsCurrency;
  if result<0 then result:=0;
      result:=arrondi(result,2);
  end;
end;



Function EditionListeDesChoixAmortissementL(TypeEdition : integer; DemandePeriode:Boolean; Compte:string;DataSet:TDataSet):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Compte)then
     Maliste.Add(Compte)
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionListeDesChoixAmortissementL(TypeEdition,DemandePeriode,Maliste,DataSet);
  except
     abort;
  end;
end;

Function EditionListeDesChoixAmortissementL(TypeEdition : integer; Filtre:string; DemandePeriode:Boolean; DataSet:TDataSet):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(retour);
  try
   Maliste:=TStringList.Create;
   if not empty (filtre)then
    begin
      FiltrageDataSet(dmrech.TaPlanCptRech,CreeFiltreET(['compte','Immobilisation'],[Filtre,True]));
      Maliste:=ChampTableVersListeEx(['compte'],dmrech.TaPlanCptRech,';',false);
    end
   else
     raise ExceptLGR.Create('Aucun Compte n''est defini !',1000,true,mtError,Retour);
   EditionListeDesChoixAmortissementL(TypeEdition,DemandePeriode,Maliste,DataSet);
  except
     abort;
  end;
end;

Function EditionListeDesChoixAmortissementL(TypeEdition : integer; DemandePeriode:Boolean;Compte:TStringList; DataSet:TDataSet):Boolean;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
compteTmp:string;
TotalEco,TotalDerog,TotalMini,TotalMaxi,TotalChoix:currency;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
DatasetLoc:Tdataset;
Requete:TQuery;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalEco:=0;
TotalDerog:=0;
TotalMini:=0;
TotalMaxi:=0;
TotalChoix:=0;

  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DataModuleImmos =nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);


    if dataset <> nil then
      begin
        DatasetLoc:=dataset;
      end
    else
      begin
        application.MessageBox(pchar(EditionUlterieure),'Attention',MB_OK+MB_ICONSTOP);
        abort;
      end;
      DatasetLoc.DisableControls;

      if DatasetLoc.RecordCount<>0 then
        begin
          DatasetLoc.first;
          while not DatasetLoc.Eof do
            begin
                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DatasetLoc.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DatasetLoc.FindField('Immobilisation').AsString)+
                                   ';'+
                                   DatasetLoc.FindField('Type_Amt').AsString+
                                   ';'+
                                   DatasetLoc.FindField('eco').AsString+
                                   ';'+
                                   DatasetLoc.FindField('Derog').AsString+
                                   ';'+
                                   DatasetLoc.FindField('mini').AsString+
                                   ';'+
                                   DatasetLoc.FindField('maxi').AsString+
                                   ';'+
                                   DatasetLoc.FindField('choix').AsString
                                   );
                TotalEco:=TotalEco+DatasetLoc.FindField('Eco').AsCurrency;
                TotalDerog:=TotalDerog+DatasetLoc.FindField('Derog').AsCurrency;
                TotalMini:=TotalMini+DatasetLoc.FindField('Mini').AsCurrency;
                TotalMaxi:=TotalMaxi+DatasetLoc.FindField('Maxi').AsCurrency;
                TotalChoix:=TotalChoix+DatasetLoc.FindField('choix').AsCurrency;

                DatasetLoc.Next;
            end;//fin du while not DatasetLoc.eof
            ListeValeur.Add('3;;; @TOTAL :  ;'+E.FormatCurrSansDevise(TotalEco) +';'+E.FormatCurrSansDevise(TotalDerog) +';'+E.FormatCurrSansDevise(TotalMini) +';'+E.FormatCurrSansDevise(TotalMaxi)+';'+E.FormatCurrSansDevise(TotalChoix));

           ObjPrn.FontLigneSeule.Size:=7;
           ObjPrn.FTitreEdition := 'LISTE DES CHOIX D''AMORTISSEMENTS ';
           ObjPrn.FTitre2Edition :=TitreCompte;
           ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

           ListeValeur.Insert(0,' Compte ;Désignation ; T ; Eco ; Derog ;  Mini ; Maxi ; Choix ');
           ListeValeur.Insert(1,'0.6;3.0;0.2;0.8;0.8;0.8;0.8;0.8');
           ListeValeur.Insert(2,'texte;texte;texte;curr;curr;curr;curr;curr');
            end;
     ObjPrn.AffichageImp(ListeValeur);
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
     DatasetLoc.EnableControls;
//   ObjPrn.destroy;
end;
end;

end.


