unit DMEmprunt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  LibSQL,
  StdCtrls,
  E2_Decl_Records,
  LibZoneSaisie,
  E2_LibInfosTable,
  DMPlanCPt,
  DMRecherche,
  LibDates,
  DMEcriture,
  Variants,
  Editions,
  ShellApi,
  ChoixPeriode,
  ObjetEdition,
  Printers,
  LibRessourceString,
  Lib_Chaine;


const
requeteQuRecupEmpruntsSurCpt:String ='select ID,Code_Emp,Compte_Emp,Designation_Emp,'+
'CapiResteDu_Emp,CapiTotal_Emp,CodeGr,DateRealisation,' +
'NbPeriode,P1,PP1,P2,PP2,P3,PP3,TypeRb,PeriodeRb,  '+
'Differe,FraisAnnexe,Assurance,DatePremEcheance,CapitalRbPE,  '+
'InteretRbPE,NbRbFait,Banque,Actif,differeMois,  '+
'max(echEmp."Date") as DateFin '+
'from emprunts                     '+
'left join echEmp on (echEmp.id_emp = id)   '+
'where Compte_Emp=:compte and ((actif=true)or(actif is null))'+
'group by        '+
'ID,Code_Emp,Compte_Emp,Designation_Emp,  '+
'CapiResteDu_Emp,CapiTotal_Emp,CodeGr,DateRealisation, '+
'NbPeriode,P1,PP1,P2,PP2,P3,PP3,TypeRb,PeriodeRb,     '  +
'Differe,FraisAnnexe,Assurance,DatePremEcheance,CapitalRbPE,   '+
'InteretRbPE,NbRbFait,Banque,Actif,differeMois' ;


  type
TTri=(DateRealisation,CodeEmp);
TPeriodeAnnuite=Record
  Mois:word;
  MoisAnnee:string;
  Annuite:currency;
  TotAnnuite:currency;
  TotGENAnnuite:currency;
end;

  TParamDMEmprunts=Record
   Quand:Integer;
   EmpruntsDataStateChange:TNotifyEvent;
   EcheEmpruntDataStateChange:TNotifyEvent;
   EmpruntsQuCptEmpruntsAfterScroll:TDataSetNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
   QuiAppel:TTypeFenetre;
   typeEmprunt:TtypeEmprunts;
  end;

  TInfosDMEmprunts=Record
    Retour:Boolean;
    NbEmpruntsOuverture:Integer;
   end;

    TDMEmprunts = class(TDataModule)
    TAEmprunts: TTable;
    DAEmprunts: TDataSource;
    TAEmpruntsCompte_Emp: TStringField;
    TAEmpruntsCode_Emp: TStringField;
    TAEmpruntsCapiResteDu_Emp: TCurrencyField;
    TAEmpruntsCapiTotal_Emp: TCurrencyField;
    TAEmpruntsID: TIntegerField;
    TaEcheance: TTable;
    DataEcheance: TDataSource;
    TAEmpruntsDesignation_Emp: TStringField;
    TaEmpruntGestion: TTable;
    DaEmpruntGestion: TDataSource;
    TaEcheanceGestion: TTable;
    DaEcheanceGestion: TDataSource;
    QuCptEmprunts: TQuery;
    QuCptEmpruntsCompte_Emp: TStringField;
    DaCptEmprunts: TDataSource;
    QuDeleteEcheance: TQuery;
    QuRecupEmpruntsSurCpt: TQuery;
    DaRecupEmpruntsSurCpt: TDataSource;
    QuTotalEcheance: TQuery;
    QuTotalEcheanceSUMOFAnnuite: TCurrencyField;
    QuTotalEcheanceSUMOFInterets: TCurrencyField;
    QuTotalEcheanceSUMOFAssurances: TCurrencyField;
    QuTotalEcheanceSUMOFFrais_Divers: TCurrencyField;
    DATotalEcheance: TDataSource;
    QuTotalEcheanceSUMOFCapital: TCurrencyField;
    QuTotalEmprunts: TQuery;
    DaTotalEmprunts: TDataSource;
    TaEmpruntGestionID: TIntegerField;
    TaEmpruntGestionCode_Emp: TStringField;
    TaEmpruntGestionCompte_Emp: TStringField;
    TaEmpruntGestionDesignation_Emp: TStringField;
    TaEmpruntGestionCapiResteDu_Emp: TCurrencyField;
    TaEmpruntGestionCapiTotal_Emp: TCurrencyField;
    TaEmpruntGestionCodeGr: TStringField;
    TaEmpruntGestionDateRealisation: TDateField;
    TaEmpruntGestionNbPeriode: TFloatField;
    TaEmpruntGestionP1: TFloatField;
    TaEmpruntGestionPP1: TFloatField;
    TaEmpruntGestionP2: TFloatField;
    TaEmpruntGestionPP2: TFloatField;
    TaEmpruntGestionP3: TFloatField;
    TaEmpruntGestionPP3: TFloatField;
    TaEmpruntGestionTypeRb: TStringField;
    TaEmpruntGestionPeriodeRb: TStringField;
    TaEmpruntGestionDiffere: TFloatField;
    TaEmpruntGestionFraisAnnexe: TFloatField;
    TaEmpruntGestionAssurance: TFloatField;
    TaEmpruntGestionDatePremEcheance: TDateField;
    TaEmpruntGestionCapitalRbPE: TCurrencyField;
    TaEmpruntGestionInteretRbPE: TCurrencyField;
    TaEmpruntGestionNbRbFait: TFloatField;
    TaEmpruntGestionBanque: TStringField;
    TaEmpruntGestionActif: TBooleanField;
    QuRecupEmpruntsSurCptID: TIntegerField;
    QuRecupEmpruntsSurCptCode_Emp: TStringField;
    QuRecupEmpruntsSurCptCompte_Emp: TStringField;
    QuRecupEmpruntsSurCptDesignation_Emp: TStringField;
    QuRecupEmpruntsSurCptCapiResteDu_Emp: TCurrencyField;
    QuRecupEmpruntsSurCptCapiTotal_Emp: TCurrencyField;
    QuRecupEmpruntsSurCptCodeGr: TStringField;
    QuRecupEmpruntsSurCptDateRealisation: TDateField;
    QuRecupEmpruntsSurCptNbPeriode: TFloatField;
    QuRecupEmpruntsSurCptP1: TFloatField;
    QuRecupEmpruntsSurCptPP1: TFloatField;
    QuRecupEmpruntsSurCptP2: TFloatField;
    QuRecupEmpruntsSurCptPP2: TFloatField;
    QuRecupEmpruntsSurCptP3: TFloatField;
    QuRecupEmpruntsSurCptPP3: TFloatField;
    QuRecupEmpruntsSurCptTypeRb: TStringField;
    QuRecupEmpruntsSurCptPeriodeRb: TStringField;
    QuRecupEmpruntsSurCptDiffere: TFloatField;
    QuRecupEmpruntsSurCptFraisAnnexe: TFloatField;
    QuRecupEmpruntsSurCptAssurance: TFloatField;
    QuRecupEmpruntsSurCptDatePremEcheance: TDateField;
    QuRecupEmpruntsSurCptCapitalRbPE: TCurrencyField;
    QuRecupEmpruntsSurCptInteretRbPE: TCurrencyField;
    QuRecupEmpruntsSurCptNbRbFait: TFloatField;
    QuRecupEmpruntsSurCptBanque: TStringField;
    QuRecupEmpruntsSurCptActif: TBooleanField;
    TaEcheanceGestionId_Annuite: TIntegerField;
    TaEcheanceGestionId_Emp: TIntegerField;
    TaEcheanceGestionDate: TDateField;
    TaEcheanceGestionAnnuite: TCurrencyField;
    TaEcheanceGestionCapital: TCurrencyField;
    TaEcheanceGestionInterets: TCurrencyField;
    TaEcheanceGestionAssurances: TCurrencyField;
    TaEcheanceGestionFrais_Divers: TCurrencyField;
    TaEcheanceGestionCapital_Restant_du: TCurrencyField;
    TaEcheanceGestionRembourse: TBooleanField;
    TaEcheanceGestionAnnule: TBooleanField;
    TaEcheanceGestionDateRemboursement: TDateField;
    TaEcheanceGestionReference: TStringField;
    QuReferenceReglement: TQuery;
    DaReferenceReglement: TDataSource;
    QuReferenceReglementID: TIntegerField;
    QuReferenceReglementJournal: TIntegerField;
    QuReferenceReglementReference: TStringField;
    QuReferenceReglementDate: TDateField;
    QuReferenceReglementLibelle: TStringField;
    QuReferenceReglementCompte: TStringField;
    QuTotalG: TQuery;
    QuEcheancierEdition: TQuery;
    TAEmpruntsActif: TBooleanField;
    QuEmprunt_EditionMouvement: TQuery;
    QuCapitalRestantAvantExo: TQuery;
    QuEmprunt_EditionMouvementCodeGr: TStringField;
    QuEmprunt_EditionMouvementCode_Emp: TStringField;
    QuEmprunt_EditionMouvementDesignation_Emp: TStringField;
    QuEmprunt_EditionMouvementnonEchu: TCurrencyField;
    QuEmprunt_EditionMouvementDepart: TCurrencyField;
    QuCapitalRembourseAvantExo: TQuery;
    QuCapitalRestantApresExo: TQuery;
    QuCapitalRembourseApresExo: TQuery;
    QuEmprunt_EditionMouvementInteretsCourus: TCurrencyField;
    QuEmprunt_Edition: TQuery;
    QuEmprunt_EditionMouvementCapiTotal_emp: TCurrencyField;
    QuEmprunt_EditionMouvementDateRealisation: TDateField;
    QuEmprunt_EditionMouvementid_emp: TIntegerField;
    QuEmprunt_EditionMouvementCapitalRestantAvantExo: TCurrencyField;
    QuEmprunt_EditionMouvementRembourseAvantExo: TCurrencyField;
    QuEmprunt_EditionMouvementCapitalRestantApresExo: TCurrencyField;
    QuEmprunt_EditionMouvementRembourseApresExo: TCurrencyField;
    QuEmprunt_EditionMouvementDerniereDateEch: TDateField;
    QuEmprunt_EditionMouvementFrais: TCurrencyField;
    QuEmprunt_EditionCodeGr: TStringField;
    QuEmprunt_Editionid: TIntegerField;
    QuEmprunt_EditionCode_Emp: TStringField;
    QuEmprunt_EditionDate: TDateField;
    QuEmprunt_EditionAnnuite: TCurrencyField;
    QuEmprunt_EditionCapitalRestantAvantExo: TCurrencyField;
    QuEmprunt_EditionDesignation_emp: TStringField;
    QuEmprunt_Editioncapital: TCurrencyField;
    QuEmpruntSansEchDansAnnee: TQuery;
    QuEmpruntSansEchDansAnneeCodeGr: TStringField;
    QuEmpruntSansEchDansAnneeCode_Emp: TStringField;
    QuEmpruntSansEchDansAnneeid_emp: TIntegerField;
    QuEmpruntSansEchDansAnneeDesignation_Emp: TStringField;
    QuEmpruntSansEchDansAnneenonEchu: TCurrencyField;
    QuEmpruntSansEchDansAnneeCapiTotal_emp: TCurrencyField;
    QuEmpruntSansEchDansAnneeDateRealisation: TDateField;
    QuDistinctEmprunts: TQuery;
    QuEmpruntSansEchDansAnneeInteretsCourus: TCurrencyField;
    QuEmpruntSansEchDansAnneePremiereDate: TDateField;
    QuEmpruntInteret: TQuery;
    QuEmpruntInteretid_emp: TIntegerField;
    QuEmpruntInteretinterets: TCurrencyField;
    QuEmpruntInteretDate: TDateField;
    QuTotalEcheanceMINOFCapital_Restant_Du: TCurrencyField;
    QuCapitalRestantAvantExoSansEcheance: TQuery;
    QuEmprunt_EditionCapitalRestantAvantExoSansEch: TCurrencyField;
    QuEmprunt_EditionCapitalRestantAvant: TCurrencyField;
    QuEmprunt_EditionPP1: TFloatField;
    QuEmprunt_EditionDuree: TFloatField;
    QuEmprunt_EditionCapiTotal_Emp: TCurrencyField;
    QuProchaineDateEch: TQuery;
    QuEmpruntSansEchDansAnneeDateFinEmprunt: TDateField;
    QuEmpruntSansEchDansAnneeCapitalRestantAvantExo: TCurrencyField;
    QuEmpruntSansEchDansAnneeRembourseAvantExo: TCurrencyField;
    QuEmpruntSansEchDansAnneeDatePremEcheance: TDateField;
    QuEmprunt_EditionMouvementCapiResteDu_emp: TCurrencyField;
    QuEmprunt_EditionMouvementPremiereDate: TDateField;
    QuTotalEmpruntsCapiTotal_Emp: TCurrencyField;
    QuTotalEmpruntsCapiResteDu_emp: TCurrencyField;
    QuTotalEmpruntsCapitalRbPE: TCurrencyField;
    QuTotalEmpruntsInteretRbPE: TCurrencyField;
    QuTotalEmpruntsFraisAnnexe: TFloatField;
    QuTotalEmpruntsAssurance: TFloatField;
    QuEmpruntOuverture: TQuery;
    QuEmpruntInteret_Anterieur: TQuery;
    QuEmpruntInteret_Anterieurinterets: TCurrencyField;
    QuEmpruntInteret_AnterieurDate_Ant: TDateField;
    QuEmpruntInteret_AnterieurDate: TDateField;
    QuEmprunt_EditionCompte_Emp: TStringField;
    QuRecupEmpruntsSurCptdiffereMois: TIntegerField;
    TaEmpruntGestiondiffereMois: TIntegerField;
    QuEmprunt_EditionMouvementinterets: TCurrencyField;
    QuEmprunt_EditionMouvementP1: TFloatField;
    QuEmprunt_EditionMouvementPP1: TFloatField;
    QuRecupEmpruntsSurCptFini: TStringField;
    QuEmprunt_EditionDateRealisation: TDateField;
    QuEmprunt_Editionbanque: TStringField;
    QuMaxDateEch: TQuery;
    QuMaxDateEchid_emp: TIntegerField;
    QuMaxDateEchDateFin: TDateField;
    QuEmprunt_EditionDateFin: TDateField;
    QuRecupEmpruntsSurCptDateFin: TDateField;
    QuEmpruntSansEchDansAnneeP1: TFloatField;
    QuEmpruntSansEchDansAnneePP1: TFloatField;
    QuEmpruntSansEchDansAnneeBanque: TStringField;
    QuCapitalRestantAvantExo2: TQuery;
    QuEmprunt_EditionMouvementDateFin: TDateField;
    QuEmpruntSansEchDansAnneeDateFin: TDateField;
    QuEmprunt_EditionMouvementBanque: TStringField;
    procedure DMEmpruntsCreate(Sender: TObject);
    procedure DMEmpruntsDestroy(Sender: TObject);
//    Function CtrlSaisieEmprunt(CCourant:Tfield):TErreurSaisie;
    Function CtrlSaisieEmprunt(CCourant:Tfield):TExceptLGR;
    procedure TAEmpruntsBeforePost(DataSet: TDataSet);
    procedure TAEmpruntsAfterPost(DataSet: TDataSet);
    procedure TAEmpruntsBeforeInsert(DataSet: TDataSet);
    procedure TAEmpruntsBeforeEdit(DataSet: TDataSet);
    procedure TAEmpruntsBeforeDelete(DataSet: TDataSet);
    procedure EcritureEcheance(var1,var2:integer;var3:tdatetime;var4,var5,var6,var7,var8,var9:real);
    procedure TraitementMAJBalance(Suppression:boolean;EtatTaStock:TDataSetState);
    procedure TAEmpruntsAfterDelete(DataSet: TDataSet);
    procedure TAEmpruntsPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TAEmpruntsDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaEmpruntGestionBeforePost(DataSet: TDataSet);
    procedure CalculEcheancier(DataSet:TDataSet);
    function NbRb(TypeRemboursement:string):TRemboursement;
    procedure TaEmpruntGestionBeforeInsert(DataSet: TDataSet);
    Function CtrlSaisieEcheance(CCourant:Tfield):TExceptLGR;
    procedure TaEcheanceGestionAfterInsert(DataSet: TDataSet);
    procedure TaEcheanceGestionBeforeInsert(DataSet: TDataSet);
    procedure TaEcheanceGestionBeforePost(DataSet: TDataSet);
    procedure TaEmpruntGestionBeforeDelete(DataSet: TDataSet);
    Function Puiss(X,Y:Double):Extended;
    procedure Filtrage_QuRecupEmpruntsSurCpt_SurCpt(Cpt:string);
    procedure TaEmpruntGestionAfterOpen(DataSet: TDataSet);
    procedure TaEmpruntGestionAfterPost(DataSet: TDataSet);
    Procedure ReactualiseQuerys;
    procedure TaEcheanceGestionAfterScroll(DataSet: TDataSet);
    procedure QuTotalEcheanceAfterOpen(DataSet: TDataSet);
    procedure TaEmpruntGestionAfterDelete(DataSet: TDataSet);
    procedure TaEmpruntGestionAfterInsert(DataSet: TDataSet);
    procedure BtnDetail_VisuListe_Click(Sender: TObject);
    procedure PaGrilleResize_VisuListe(Sender: TObject);
    procedure TaEcheanceGestionAfterOpen(DataSet: TDataSet);
    procedure TaEcheanceAfterOpen(DataSet: TDataSet);
    procedure QuRecupEmpruntsSurCptAfterOpen(DataSet: TDataSet);
    procedure QuTotalEmpruntsAfterOpen(DataSet: TDataSet);
    procedure TAEmpruntsAfterOpen(DataSet: TDataSet);
    procedure QuCptEmpruntsAfterScroll(DataSet: TDataSet);
    Procedure GestionAccesEmprunts;

    procedure TAEmpruntsBeforeEIDOuv_Abort(DataSet: TDataSet);
    procedure TaEmpruntGestionBeforeEIDClo_Abort(DataSet: TDataSet);
    procedure TaEcheanceGestionBeforeEIDClo_Abort(DataSet: TDataSet);
    procedure TaEcheanceGestionBeforeEdit(DataSet: TDataSet);
    Function RecalculCapitalRestantDu(DataSet: TDataSet;IdEmp:integer;CapitalDepart:currency):TExceptLGR;
    procedure TaEcheanceGestionAfterPost(DataSet: TDataSet);
    procedure QuEmprunt_EditionMouvementFilterRecord(
        DataSet: TDataSet; var Accept: Boolean);
    procedure QuEmprunt_EditionOuvertureFilterRecord(
      DataSet: TDataSet; var Accept: Boolean);
    procedure QuEmprunt_EditionMouvementCalcFields(DataSet: TDataSet);
    procedure QuEmpruntSansEchDansAnneeCalcFields(DataSet: TDataSet);
    procedure QuEmprunt_EditionCalcFields(DataSet: TDataSet);
    procedure QuRecupEmpruntsSurCptCalcFields(DataSet: TDataSet);

    procedure QuRecupEmpruntsSurCptFilterRecordFinis(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuRecupEmpruntsSurCptFilterRecordEnCours(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuEmprunt_EditionBeforeOpen(DataSet: TDataSet);
  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

  public
    { Déclarations publiques }
    ListeFilterRecordEmprunt:Tstringlist;
    MessDerSub:boolean;
    CompteEmprunt:string;
    Quand:Integer;
    QuiAppel:TTypeFenetre;
    typeEmprunts:TtypeEmprunts;
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
  end;

var
  DMEmprunts: TDMEmprunts;
//  Mark: TBookmark;
  CompteTmp : String;
  CapitalDuTmp:currency;
  DernierLibelle:string;
  EmpruntCourant:integer;
  CompteCourant:string;
  CapitalTmp:currency;
  CapitalRestantDuAvantCapital:currency;
    Function AffichReferenceReglement(Requete:TDataset;Datasource:Tdatasource):TReference;
    Function EditionEcheancier(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
    Function InitialiseDMEmprunts(ParamDMEmprunts:TParamDMEmprunts):TInfosDMEmprunts;

    Function EditionEmpruntTresorerieL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet;tri:TTri=CodeEmp):Boolean;overload;
    Function EditionEmpruntTresorerieL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:String;DataSet:TDataSet;tri:TTri=CodeEmp):Boolean;overload;

    Function EditionEmpruntMouvExerciceL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet;Relance:boolean=false):TStringList;overload;
    Function EditionEmpruntMouvExerciceL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:String;DataSet:TDataSet;Relance:boolean=false):TStringList;overload;

    Function EditionEmpruntMouvExerciceEtAnnuiteL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet;Relance:boolean=false):TStringList;overload;
    Function EditionEmpruntMouvExerciceEtAnnuiteL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:String;DataSet:TDataSet;Relance:boolean=false):TStringList;overload;


    Function EditionEmpruntRepartitionL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet;Relance:boolean=false):TStringList;overload;
    Function EditionEmpruntRepartitionL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:String;DataSet:TDataSet;Relance:boolean=false):TStringList;overload;

    Function EditionEmpruntPrevisionnelL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet):Boolean;overload;
    Function EditionEmpruntPrevisionnelL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:String;DataSet:TDataSet):Boolean;overload;
    procedure initialise_PeriodeAnnuite(Var PeriodeAnnuite:TPeriodeAnnuite);

    Function EditionEmpruntEcheancierL(TypeEdition : integer; idEmp:integer;DataSet:TDataSet):Boolean;
    Function EditionEmpruntOuvertureL(TypeEdition : integer; idEmp:integer;Compte:string;DataSet:TDataSet):Boolean;overload;
    Function EditionEmpruntOuvertureL(TypeEdition : integer; idEmp:integer;Compte:Tstringlist;DataSet:TDataSet):Boolean;overload;

    Procedure Initialise_ParamDMEmprunts(ParamDMEmprunts:TParamDMEmprunts);  { isa  le  12/05/04 }
    
implementation

uses
E2_AideCompte, DMBalances, DMPiece, E2_VisuListe, E2_Main;

{$R *.DFM}
Procedure Initialise_ParamDMEmprunts(ParamDMEmprunts:TParamDMEmprunts);
begin
   ParamDMEmprunts.Quand:=0;
   ParamDMEmprunts.EmpruntsDataStateChange:=nil;
   ParamDMEmprunts.EcheEmpruntDataStateChange:=nil;
   ParamDMEmprunts.EmpruntsQuCptEmpruntsAfterScroll:=nil;
   ParamDMEmprunts.GEstInterfaceEvent:=nil;
   ParamDMEmprunts.QuiAppel:=F_inconnu;
   ParamDMEmprunts.typeEmprunt:=C_Tous;
end;

Function InitialiseDMEmprunts(ParamDMEmprunts:TParamDMEmprunts):TInfosDMEmprunts;
Begin
 if DMEmprunts=nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 if AideCompte=nil then AideCompte:=TAideCompte.Create(Application.MainForm);
 DMEmprunts.OnGEstInterfaceEvent := ParamDMEmprunts.GEstInterfaceEvent;
 DMEmprunts.Quand := ParamDMEmprunts.Quand;
 DMEmprunts.QuiAppel:=ParamDMEmprunts.QuiAppel;
 DMEmprunts.typeEmprunts:=ParamDMEmprunts.typeEmprunt;
 if DMEmprunts.Quand = C_InfoEpicea then
  begin
     FiltrageDataSet(DMRech.TaEmpruntsRech,'actif = faux');
     Result.NbEmpruntsOuverture:= DMRech.TaEmpruntsRech.RecordCount;
  end
 else
  begin
     Case DMEmprunts.Quand Of
          C_Ouverture: Begin //si ouverture
                 DMEmprunts.DAEmprunts.OnStateChange := ParamDMEmprunts.EmpruntsDataStateChange;
                 FiltrageDataSet(DMEmprunts.TAEmprunts,'actif=faux');
             End;
          C_Mouvement: Begin //si Exercice
                         Case DMEmprunts.QuiAppel Of
                               F_DescEmp:begin
                                             DMEmprunts.DaEmpruntGestion.OnStateChange := ParamDMEmprunts.EmpruntsDataStateChange;
                                             DMEmprunts.QuCptEmprunts.AfterScroll:=DMEmprunts.QuCptEmpruntsAfterScroll;
                                             DMEmprunts.TaEmpruntGestion.Close;
                                             DMEmprunts.TaEmpruntGestion.MasterSource:=DMEmprunts.DaRecupEmpruntsSurCpt;
                                             DMEmprunts.TaEmpruntGestion.MasterFields:='ID';
                                             DMEmprunts.TaEmpruntGestion.IndexFieldNames:='ID';
                                             if DMEmprunts.QuCptEmprunts.Active then DMEmprunts.QuCptEmprunts.close;
                                                DMEmprunts.QuCptEmprunts.open;
                                             DMEmprunts.QuCptEmpruntsAfterScroll(DMEmprunts.QuCptEmprunts);
                                             DMEmprunts.TaEmpruntGestion.open;
                                             case DMEmprunts.typeEmprunts of
                                             C_Tous:begin
                                                       DMEmprunts.QuRecupEmpruntsSurCpt.OnFilterRecord:=nil;
                                                    end;
                                             C_EnCours:begin
                                                       DMEmprunts.QuRecupEmpruntsSurCpt.OnFilterRecord:=DMEmprunts.QuRecupEmpruntsSurCptFilterRecordEnCours;
                                                    end;
                                             C_Finis:begin
                                                       DMEmprunts.QuRecupEmpruntsSurCpt.OnFilterRecord:=DMEmprunts.QuRecupEmpruntsSurCptFilterRecordFinis;
                                                    end;
                                             end;//fin case  DMEmprunts.typeEmprunts

                                         end;
                           F_EcheEmprunt:begin
                                             DMEmprunts.TaEcheanceGestion.AfterScroll:=nil;
                                             DMEmprunts.DaEcheanceGestion.OnStateChange :=nil;
                                             DMEmprunts.QuTotalEcheance.Close;
                                             DMEmprunts.TaEcheanceGestion.Close;
                                             DMEmprunts.TaEcheanceGestion.MasterSource:=DMEmprunts.DaEmpruntGestion;
                                             DMEmprunts.TaEcheanceGestion.MasterFields:='ID';
                                             DMEmprunts.TaEcheanceGestion.IndexName:='DateEch_';
                                             //DMEmprunts.TaEcheanceGestion.IndexFieldNames:='id_emp';
                                             DMEmprunts.TaEcheanceGestion.open;
                                             DMEmprunts.TaEcheanceGestion.Refresh;
                                             DMEmprunts.DaEcheanceGestion.OnStateChange := ParamDMEmprunts.EcheEmpruntDataStateChange;
                                             DMEmprunts.TaEcheanceGestion.AfterScroll:=DMEmprunts.TaEcheanceGestionAfterScroll;
                                             //DMEmprunts.TaEcheanceGestionAfterScroll(DMEmprunts.TaEcheanceGestion);
                                         end;
                         end;
                    End;
     End; // Fin du case DMEmprunts.Quand
  end;
End;


Function EditionEcheancier(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var
    NomFich,Chemin:String;
    CodeEmp,
    Code,
    Designation,
    Montant,
    An1,an2,an3,
    Mois1,mois2,mois3,
    Groupe,
    periode,
    mode,
    DateDeb,DatePremEch,Date2,Date3,Date4,Date5,Date6,
    Taux1,Taux2,Taux3:string;
    duree1,duree2,duree3,
    tmp:integer;
Begin

 Chemin :=E.RepertoireComptaWeb;
 NomFich:='Echeancier';

 if DMEmprunts=nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
  end;
  CodeEmp:=DataSet.FindField('id_emp').asstring;

  DMEmprunts.QuTotalG.SQL.Clear;
  DMEmprunts.QuTotalG.SQL.Add('select distinct sum(annuite),sum(Capital),sum(interets),0,0,0 from echemp,emprunts where ');
  DMEmprunts.QuTotalG.SQL.Add('id_emp=id and id='''+CodeEmp+'''');
  DMEmprunts.QuTotalG.Open;

  DMEmprunts.QuEcheancierEdition.SQL.Clear;
  DMEmprunts.QuEcheancierEdition.SQL.Add('select * from echemp,emprunts where');
  DMEmprunts.QuEcheancierEdition.SQL.Add('id_emp=id and id='''+CodeEmp+''' order by echemp."date"');
  DMEmprunts.QuEcheancierEdition.Open;

  //préparation des infos
  Designation:=DMEmprunts.QuEcheancierEdition.FindField('Designation_Emp').asstring;
  Montant:=DMEmprunts.QuEcheancierEdition.FindField('Capitotal_Emp').asstring;
  // info periode ?
  DateDeb:=DMEmprunts.QuEcheancierEdition.FindField('Date').AsString;
  DatePremEch:=DMEmprunts.QuEcheancierEdition.FindField('DatePremEcheance').AsString;
  if DatePremEch='' then
      DatePremEch:=DateDeb;
  duree1 :=StrToInt_Lgr(DMEmprunts.QuEcheancierEdition.FindField('p1').AsString);
  duree2 :=StrToInt_Lgr(DMEmprunts.QuEcheancierEdition.FindField('p2').AsString);
  duree3 :=StrToInt_Lgr(DMEmprunts.QuEcheancierEdition.FindField('p3').AsString);
  Taux1  :=DMEmprunts.QuEcheancierEdition.FindField('pp1').AsString;
  Taux2  :=DMEmprunts.QuEcheancierEdition.FindField('pp2').AsString;
  Taux3  :=DMEmprunts.QuEcheancierEdition.FindField('pp3').AsString;

  An1    :=inttostr(round(duree1/12));
  Mois1  :=inttostr(duree1 mod 12);
  An2    :=inttostr(round(duree2/12));
  Mois2  :=inttostr(duree2 mod 12);
  An3    :=inttostr(round(duree3/12));
  Mois3  :=inttostr(duree3 mod 12);
  // info periode ?
  Groupe :=DMEmprunts.QuEcheancierEdition.FindField('CodeGr').AsString;
  Groupe :=UpperCase(Groupe);
  Code   :=DMEmprunts.QuEcheancierEdition.FindField('Code_emp').AsString;
  case length(Code) of
    1: Code:='00'+Code;
    2: Code:='0'+Code;
  end;
  periode:=DMEmprunts.QuEcheancierEdition.FindField('PeriodeRb').AsString;

  if periode = 'ANN' then begin
      periode := 'Annuel';
      Date2  :=DateToStr(IncMonth(StrToDate_Lgr(DateDeb),duree1-(NbMois(StrToDate_Lgr(DateDeb),StrToDate_Lgr(DatePremEch))+StrToInt_Lgr(mois1))));
      Date3  :=DateToStr(IncMonth(StrToDate_Lgr(Date2),12));
      Date4  :=DateToStr(IncMonth(StrToDate_Lgr(Date3),duree2-12));
      Date5  :=DateToStr(IncMonth(StrToDate_Lgr(Date4),12));
      Date6  :=DateToStr(IncMonth(StrToDate_Lgr(Date5),duree3-12));
  end;
  if periode = 'TRI' then begin
      periode := 'Trimestriel';
      Date2  :=DateToStr(IncMonth(StrToDate_Lgr(DateDeb),duree1-(NbMois(StrToDate_Lgr(DateDeb),StrToDate_Lgr(DatePremEch))+StrToInt_Lgr(mois1)-3)));
      Date3  :=DateToStr(IncMonth(StrToDate_Lgr(Date2),3));
      Date4  :=DateToStr(IncMonth(StrToDate_Lgr(Date3),duree2-3));
      Date5  :=DateToStr(IncMonth(StrToDate_Lgr(Date4),3));
      Date6  :=DateToStr(IncMonth(StrToDate_Lgr(Date5),duree3-3));
  end;
  if periode = 'SEM' then begin
      periode := 'Semestriel';
      Date2  :=DateToStr(IncMonth(StrToDate_Lgr(DateDeb),duree1-(NbMois(StrToDate_Lgr(DateDeb),StrToDate_Lgr(DatePremEch))+StrToInt_Lgr(mois1))));
      Date3  :=DateToStr(IncMonth(StrToDate_Lgr(Date2),4));
      Date4  :=DateToStr(IncMonth(StrToDate_Lgr(Date3),duree2-4));
      Date5  :=DateToStr(IncMonth(StrToDate_Lgr(Date4),4));
      Date6  :=DateToStr(IncMonth(StrToDate_Lgr(Date5),duree3-4));
  end;
  if periode = 'MEN' then begin
      periode := 'Mensuel';
      Date2  :=DateToStr(IncMonth(StrToDate_Lgr(DateDeb),duree1-(NbMois(StrToDate_Lgr(DateDeb),StrToDate_Lgr(DatePremEch))+StrToInt_Lgr(mois1)-3)));
      Date3  :=DateToStr(IncMonth(StrToDate_Lgr(Date2),1));
      Date4  :=DateToStr(IncMonth(StrToDate_Lgr(Date3),duree2-1));
      Date5  :=DateToStr(IncMonth(StrToDate_Lgr(Date4),1));
      Date6  :=DateToStr(IncMonth(StrToDate_Lgr(Date5),duree3-1));
  end;

 mode:=DMEmprunts.QuEcheancierEdition.FindField('TypeRb').AsString;
 if mode = 'CAP' then mode := 'Capital constant';
 if mode = 'MEN' then mode := 'Annuité constante';
 if mode = 'AUT' then mode := 'Manuel';

  case TypeEdition  of
      C_EditionSimple:Begin
          Site.lien := false;
          //EditEcheancier(Chemin,NomFich,DMEmprunts.QuEcheancierEdition,Code,Groupe,Designation,Montant,Taux1,Taux2,Taux3,DateDeb,Date2,Date3,Date4,Date5,Date6,an1,an2,an3,mois1,mois2,mois3,periode,mode,DMEmprunts.QuTotalG,Site);
          ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
      End;
      C_EditionWeb:Begin
          Site.lien := false;
          //LienEditEcheancier(NomMenuSiteWeb,Chemin,NomFich,DMEmprunts.QuEcheancierEdition,Code,Designation,Montant,Taux,an,mois,DMEmprunts.QuTotalG,Site);
          ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
      end;
  end;
  DMEmprunts.QuTotalG.Close;
  DMEmprunts.QuEcheancierEdition.Close;
End;

procedure TDMEmprunts.DMEmpruntsCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
TaEmpruntsCompte_Emp.ValidChars := ['0'..'9'];

FormateMonnaieField(TAEmprunts,E.FormatMonnaie,E.EditFormat);
FormateMonnaieField(TaEmpruntGestion,E.FormatMonnaie,E.EditFormat);
FormateMonnaieField(TaEcheanceGestion,E.FormatMonnaie,E.EditFormat);
if ListeFilterRecordEmprunt=nil then
  ListeFilterRecordEmprunt:=Tstringlist.Create;
MessDerSub:=true;
end;

procedure TDMEmprunts.DMEmpruntsDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
//FreeAndNil(ListeFilterRecordEmprunt);
LibereObjet(TObject(ListeFilterRecordEmprunt));
DMEmprunts:=nil;
end;


procedure TDMEmprunts.EcritureEcheance(var1,var2:integer;var3:tdatetime;var4,var5,var6,var7,var8,var9:real);
begin
   try
   TaEcheance.AppendRecord([var1,var2,var3,var4,var5,var6,var7,var8,var9,false,false]);
   TaEcheance.FlushBuffers;
   except
   showmessage('Problème à l''Ecriture des Echéances ');
   abort;
   end;
end;



//****************************************************************************//

// Controle la saisie d'emprunt
// CCourant Champ à controler
// Retourne code d'erreur et retour a false si erreur
//************************************************************************
//Function TDMEmprunts.CtrlSaisieEmprunt(CCourant:Tfield):TErreurSaisie;
Function TDMEmprunts.CtrlSaisieEmprunt(CCourant:Tfield):TExceptLGR;
var
RetourEnregistrement:TEnregistrementComplet;
Begin
try
Initialise_ExceptLGR(result,GestMessageLGR);
//   result.GestMessageLGR:=GestMessageLGR;
   result.NomModule:='CtrlSaisieEmprunt';
   result.NomDossier:=e.NomDossier;
   result.GestMessageLGR.Enregistrement:=false;
   CtrlSaisieEmprunt.NumErreur:=0;
   CtrlSaisieEmprunt.Retour:=True;
   if  CCourant.DataSet.State in [dsinsert,dsEdit] then
   case CCourant.Index of
    1: Begin  // Code emprunt
       If Empty(CCourant.AsString) then
          Begin
              raise ExceptLGR.Create('Le code d''emprunt est obligatoire !',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
          end
          else
          begin
            while length(CCourant.asstring)<3 do
              CCourant.asstring:='0'+CCourant.asstring;
            case CCourant.DataSet.State of
               dsinsert:// Si l'utilisateur a saisie un code emprunt qui existe déjà
                       begin
                            if Quand=c_ouverture then
                              FiltrageDataSet(DMRech.TaEmpruntsRech,CCourant.FieldName+'='''+CCourant.AsString+ '''  and  actif=faux ')
                            else
                              FiltrageDataSet(DMRech.TaEmpruntsRech,CCourant.FieldName+'='''+CCourant.AsString+ '''  and  actif=vrai ');
                            if Infos_TInfosEmprunts(DMRech.TaEmpruntsRech,CCourant.FieldName,[CCourant.AsString]).ResultInfos then
                                begin
                                  raise ExceptLGR.Create('Ce code d''emprunt existe déjà !',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
                                end;
                       end;
               dsEdit:begin
                       if Quand=c_ouverture then
                         FiltrageDataSet(DMRech.TaEmpruntsRech,CCourant.FieldName+'='''+CCourant.AsString+ '''  and  actif=faux and ID <> '''+CCourant.DataSet.FindField('ID').AsString+'''')
                       else
                         FiltrageDataSet(DMRech.TaEmpruntsRech,CCourant.FieldName+'='''+CCourant.AsString+ '''  and  actif=vrai and ID <> '''+CCourant.DataSet.FindField('ID').AsString+'''');
                       if Infos_TInfosEmprunts(DMRech.TaEmpruntsRech,CCourant.FieldName,[CCourant.AsString]).ResultInfos then
                             begin
                             raise ExceptLGR.Create('Ce code d''emprunt existe déjà !',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
                             end;
                       DeFiltrageDataSet(DMRech.TaEmpruntsRech);
                      end;
            end;
           end;
       end;
//         Case DMEmprunts.Quand Of
//      C_Ouverture: Begin //si ouverture
//         End;
//      C_Mouvement: Begin //si Exercice
//         End;

 //**********************************************************************
    2: Begin     //Compte emprunt
       AideCompte.FiltrageAideCompte(22);
       if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
            Begin
             raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result);
             end
          else //si le compte est OK                                                  
            if ((DMEmprunts.Quand<>C_Mouvement))and(VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCOurant.DataSet)) then
              begin
                CCourant.FocusControl;
                raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result);
              end
            else
             begin
                RetourEnregistrement:=DmPlanRecupEnregistrementComplet(CCourant.AsString);
                if not(empty(RetourEnregistrement.Libelle)) then
                begin
                   if (empty(CCourant.DataSet.Fields[3].AsString)) then
                   CCourant.DataSet.Fields[3].AsString:=RetourEnregistrement.Libelle
                   else
                     if (CCourant.DataSet.Fields[3].AsString=trim(dernierlibelle))then
                     CCourant.DataSet.Fields[3].AsString:=RetourEnregistrement.Libelle;
                DernierLibelle:=RetourEnregistrement.Libelle;
                end;
             end;
       end;
//******************************************************************************
    3: Begin     // Designation de l'emprunt
                // Le champ est vide, affectation du libellé utilisateur par défaut
          If Empty(CCourant.AsString) then
             begin
             RetourEnregistrement:=DmPlanRecupEnregistrementComplet(CCourant.DataSet.Fields[2].AsString);
                if not(empty(RetourEnregistrement.Libelle)) then
                begin
                   ccourant.AsString:=RetourEnregistrement.Libelle;
                   DernierLibelle:=RetourEnregistrement.Libelle;
                end;
             end
          else//s'il est rempli, on regarde si le libelle ne correspond pas au dernier
          //compte saisi !!! si oui, on lui affecte le libelle correspondant au nouveau compte
          //saisi
             begin
               if ccourant.AsString=DernierLibelle then
               RetourEnregistrement:=DmPlanRecupEnregistrementComplet(CCourant.DataSet.Fields[2].AsString);
                if not(empty(RetourEnregistrement.Libelle)) then
                   begin
                   ccourant.AsString:=RetourEnregistrement.Libelle;
                   DernierLibelle:=RetourEnregistrement.Libelle;
                   end;
             end;
        end;
//*********************************************************************************
    4 : Begin    //Capital restant
          if empty(CCourant.asstring) then
             Begin
             raise ExceptLGR.Create('Le capital restant dû est obligatoire !',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             end
           Else If not VerifFNumeric(CCourant.DataSet.Fields[5]).VideOUZero then
                  //Si le champ CapTotal_emp n'est pas vide
             Begin
               IF CCourant.AsCurrency > CCourant.DataSet.Fields[5].AsCurrency then
                  //Si le restant est sup au total
                  Begin
                    raise ExceptLGR.Create('Le Capital Restant doit être inférieur ou égal au Capital total  !!!',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
                  end
             end;
        end;
//*********************************************************************************
    5 : Begin    //Capital Total
          if VerifFNumeric(CCourant).VideOUZero then
             Begin
             raise ExceptLGR.Create('Le capital total est obligatoire !',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             end
           Else
             case CCourant.DataSet.state of
                dsedit:  Begin
                           DeFiltrageDataSet(TaEcheanceGestion);
                           if ((TaEcheanceGestion.RecordCount<>0)or(Quand=C_ouverture)) then
                             Begin//si il existe des échéances pour cet emprunt
                                If ((CCourant.AsCurrency < CCourant.DataSet.Fields[4].AsCurrency)and(Quand=C_ouverture)) then
                                begin
                                   // Si le total est sup au restant
                                   if Quand=C_ouverture then
                                     raise ExceptLGR.Create('Le Capital total doit être supérieur ou égal au capital restant dû !!!',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result)
                                end
                                else
                                if Quand=c_mouvement then
                                  CCourant.DataSet.Fields[4].AsCurrency:=CCourant.AsCurrency;
                             end
                         end;
                dsinsert:  Begin
                                if ((CCourant.DataSet.Fields[4].AsCurrency=0)or(Quand=c_mouvement)) then
                                  CCourant.DataSet.Fields[4].AsCurrency:=ccourant.AsCurrency;
                           end;
             end;//fin du case state

       end;
//*********************************************************************************
    6 : Begin    //Code GR
           if Empty(CCourant.AsString) then
              raise ExceptLGR.Create('Vous devez indiquer un code de groupe',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
        end;
//*********************************************************************************
    7 : Begin    //Date realisation
           if not datevalide(CCourant.asstring) then
              raise ExceptLGR.Create('Cette date n''est pas valide',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
        end;
//*********************************************************************************
    8 : Begin    //Nb periode
           if VerifFNumeric(CCourant).VideOUZero then
              Begin
                 CCourant.AsInteger:=1;
              End;
        end;
//*********************************************************************************
    9 : Begin    //P1
           if ((VerifFNumeric(CCourant).VideOUZero)and(not VerifFNumeric(CCourant.DataSet.Fields[8]).VideOUZero)) then
              raise ExceptLGR.Create('Vous devez indiquer une durée pour la période 1',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
        end;
//*********************************************************************************
   10 : Begin    //PP1
//           if ((VerifFNumeric(CCourant).VideOUZero)and(CCourant.DataSet.Fields[9].AsInteger<>0)) then
//              raise ExceptLGR.Create('Vous devez indiquer un taux pour la Période 1',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result)
             if ((VerifFNumeric(CCourant).Vide)and(CCourant.DataSet.Fields[9].AsInteger<>0)) then
               ccourant.Asfloat:=0
           else
             if CCourant.DataSet.Fields[9].AsInteger=0 then ccourant.AsString:='';
        end;
//*********************************************************************************
   11 : Begin    //P2
           if (not VerifFNumeric(CCourant).VideOUZero)then
             Begin
                //if (((CCourant.DataSet.Fields[9].AsInteger mod 12)<>0)and(CCourant.DataSet.Fields[8].AsInteger>2)) then
                //  raise ExceptLGR.Create('Les saisies en mois permettent d''entrer des prêts court (18 mois)'+#10#13+'Les durées 2 et 3 doivent donc rester à 0'+#10#13+'La périodicité dans ce cas là doit être au mois (M)'+#10#13+'Pour les CT non mensualisés, modifier ensuite le tableau des annuités',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
             End
           else
           if (((CCourant.DataSet.Fields[9].AsInteger mod 12)=0)and(CCourant.DataSet.Fields[8].AsInteger>1)) then
              raise ExceptLGR.Create('Vous devez indiquer une durée pour la période 2',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
        end;
//*********************************************************************************
   12 : Begin    //PP2
//           if ((VerifFNumeric(CCourant).VideOUZero)and(CCourant.DataSet.Fields[11].AsInteger<>0)) then
//              raise ExceptLGR.Create('Vous devez indiquer un taux pour la Période 2',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result)
             if ((VerifFNumeric(CCourant).Vide)and(CCourant.DataSet.Fields[11].AsInteger<>0)) then
               ccourant.Asfloat:=0
           else
             if CCourant.DataSet.Fields[11].AsInteger=0 then ccourant.AsString:='';
        end;
//*********************************************************************************
   13 : Begin    //P3
           if (not VerifFNumeric(CCourant).VideOUZero)then
             Begin
                //if (((CCourant.DataSet.Fields[9].AsInteger mod 12)<>0)and(CCourant.DataSet.Fields[8].AsInteger>2)) then
                 // raise ExceptLGR.Create('Les saisies en mois permettent d''entrer des prêts court (18 mois)'+#10#13+'Les durées 2 et 3 doivent donc rester à 0'+#10#13+'La périodicité dans ce cas là doit être au mois (M)'+#10#13+'Pour les CT non mensualisés, modifier ensuite le tableau des annuités',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
             End
           else
           if (((CCourant.DataSet.Fields[9].AsInteger mod 12)=0)and(CCourant.DataSet.Fields[8].AsInteger>2)) then
              raise ExceptLGR.Create('Vous devez indiquer une durée pour la période 3',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
        end;
//*********************************************************************************
   14 : Begin    //PP3
//           if ((VerifFNumeric(CCourant).VideOUZero)and(CCourant.DataSet.Fields[13].AsInteger<>0)) then
//              raise ExceptLGR.Create('Vous devez indiquer un taux pour la Période 3',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result)
             if ((VerifFNumeric(CCourant).Vide)and(CCourant.DataSet.Fields[13].AsInteger<>0)) then
               ccourant.Asfloat:=0
           else
             if CCourant.DataSet.Fields[13].AsInteger=0 then ccourant.AsString:='';
        end;
//*********************************************************************************
   15 : Begin    //TypeRB
           if Empty(CCourant.AsString) then
              raise ExceptLGR.Create('Vous devez indiquer un type de remboursement',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
        end;
//*********************************************************************************
   16 : Begin    //PeriodeRB
           if Empty(CCourant.AsString) then
              raise ExceptLGR.Create('Vous devez indiquer la fréquence des remboursements',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result)
           else
           if (((CCourant.DataSet.Fields[9].AsInteger mod 12)<>0)and(ccourant.AsString<>'MEN')and(CCourant.DataSet.Fields[8].AsInteger>2)) then
             begin
               ccourant.AsString:='MEN';
                  raise ExceptLGR.Create('Les saisies en mois permettent d''entrer des prêts court (18 mois)'+#10#13+'La périodicité dans ce cas là doit être au mois (M)'+#10#13+'Pour les CT non mensualisés, modifier ensuite le tableau des annuités',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
//                  raise ExceptLGR.Create('Les saisies en mois permettent d''entrer des prêts court (18 mois)'+#10#13+'Les durées 2 et 3 doivent donc rester à 0'+#10#13+'La périodicité dans ce cas là doit être au mois (M)'+#10#13+'Pour les CT non mensualisés, modifier ensuite le tableau des annuités',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
             end;
        end;
//*********************************************************************************
   17 : Begin    //Differe
           if Empty(CCourant.AsString) then
             Begin
                CCourant.AsInteger:=0;
                //raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             End
           else
              if CCourant.AsInteger>=CCourant.DataSet.Fields[9].AsInteger then
              raise ExceptLGR.Create('Le différé doit être inférieur à la période N°1',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
        end;
//*********************************************************************************
   18 : Begin    //FraisAnnexe
           if Empty(CCourant.AsString) then
             Begin
                CCourant.AsInteger:=0;
                //raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             End;
        end;
//*********************************************************************************
   19 : Begin    //Assurance
          if Empty(CCourant.AsString) then
             Begin
                CCourant.AsInteger:=0;
                //raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             End;
        end;
//*********************************************************************************
   20 : Begin    //DatePremEcheance
           if not datevalide(CCourant.asstring) then
             begin
              if CCourant.AsDateTime<>0 then
                raise ExceptLGR.Create('Cette date n''est pas valide',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             end
           else
              if CCourant.AsDateTime< CCourant.DataSet.findfield('DateRealisation').asdatetime then
                raise ExceptLGR.Create('La date de première échéance ne peut pas être antérieur à la date de réalisation',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
        end;
//*********************************************************************************
   21 : Begin    //CapitalRbPE
           if Empty(CCourant.AsString) then
             Begin
                CCourant.AsInteger:=0;
                //raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             end
           else
             if ((CCourant.DataSet.Fields[17].Asinteger<>0)and(CCourant.AsInteger<>0)) then //en présence de différé
               raise ExceptLGR.Create('En présence de différé, le capital de la première annuité doit être nul',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result)
             else
               if CCourant.AsInteger<=CCourant.DataSet.Fields[5].ascurrency then
                 CCourant.DataSet.Fields[4].ascurrency:=CCourant.DataSet.Fields[5].ascurrency-CCourant.ascurrency
               else
                 raise ExceptLGR.Create('La première annuité ne peut être supérieure au capital emprunté',StrToInt_Lgr(inttostr(CCourant.Index)+'002'),true,mtError,result);
        end;
//*********************************************************************************
   22 : Begin    //InteretRbPE
           if Empty(CCourant.AsString) then
             Begin
                CCourant.AsInteger:=0;
                //raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             end;
        end;
//*********************************************************************************
   23 : Begin    //NbRbFait
           if Empty(CCourant.AsString) then
             Begin
                CCourant.AsInteger:=0;
                //raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
             end;
        end;
//*********************************************************************************
   24 : Begin    //banque
//           if Empty(CCourant.AsString) then
//              raise ExceptLGR.Create('Vous devez indiquer l''organisme concerné par le prêt',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
        end;
//*********************************************************************************
   25 : Begin    //actif
           if CCourant.asboolean=false then
              CCourant.asboolean:=true;
        end;
   end;
except
  abort;
end;//fin du try except

end;

//******************************************************************/

procedure TDMEmprunts.TAEmpruntsBeforePost(DataSet: TDataSet);
var
I:integer;
controleSaisie:TExceptLGR;
begin
if DataSet.State in [dsinsert,dsedit] then
    begin
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,
        ET_Maint:    Begin
                       try
                          for i:=1 to 5 do //
                               begin
                               controleSaisie:=CtrlSaisieEmprunt(DataSet.Fields[i]);
                               if controleSaisie.Retour=false then
                                 case controleSaisie.NumErreur of
                                    1000,1001:begin
                                                abort;//champ code emprunt
                                              end;
                                         2000:begin
                                                abort;//champ compte
                                              end;
                                         2001:begin
                                                abort;//champ compte
                                              end;
                                    4000,4001:begin
                                                abort;//champs montant restant dû
                                              end;
                                    5000,5001:begin
                                                abort;//champs montant total
                                              end;
                                 end;//fin du case
                               end;
                      //        end;
                      except
                       DataSet.Fields[i].FocusControl;
                       abort;
                      end;
                     end;
        ET_EnCloture,
        ET_MaintS:   Begin
                       //
                     end;
        ET_Cloture:  Begin
                       //
                     end;
        ET_Inconnu:  Begin
                       //
                     end;
      end;//fin du case E.TypeEtatExercice

       try
          if DataSet.State= dsinsert then
            begin //si table en insertion
              DataSet.FindField('ID').AsInteger:= MaxId_Query((DataSet as TTable),'ID');
            end;//fin table en insertion
          DataSet.FindField('actif').AsBoolean:=false;
          except
          showmessage('Problème à l''écriture dans la table Emprunt !!!');
          abort;
       end;//fin du try
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,ET_EnCloture,
        ET_Maint:    Begin
                       TableGereStartTransaction(DataSet);
                       try
                       TraitementMAJBalance(false,DataSet.State);
                       except
                       TableGereRollBack(DataSet);
                       TableGereRollBack(DMPieces.TaPiece);
                       showmessage('Problème à la mise à jour de la balance !!!');
                       abort;
                       end;//fin du try
                     end;
      end;//fin du case typeEtatExercice
    end;//fin si insertion ou modification
end;


procedure TDMEmprunts.TraitementMAJBalance(Suppression:boolean;EtatTaStock:TDataSetState);
begin
    DMBalance.MAJBalance(Suppression,'Qt2_Report','Credit_Report',TAEmpruntsCompte_Emp.AsString,
    compteTmp,0,0,TAEmpruntsCapiResteDu_Emp.AsCurrency,
    CapitalDuTmp,EtatTaStock);
end;


//*************************************************************************
// Si le nombre de caractères saisie est inferieur au nombre de caractères
// du combobox on enlève le filtre
//*************************************************************************
procedure TDMEmprunts.TAEmpruntsAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
MessDerSub:=true;
DataSet.Refresh;
end;

procedure TDMEmprunts.TAEmpruntsBeforeInsert(DataSet: TDataSet);
begin
  dataset.Fields[1].focuscontrol;
end;


procedure TDMEmprunts.TAEmpruntsBeforeEdit(DataSet: TDataSet);
begin
CompteTmp :='';
CapitalDuTmp:=0;
CompteTmp :=DataSet.findfield('Compte_Emp').AsString;
CapitalDuTmp:=DataSet.findfield('CapiResteDu_Emp').AsCurrency;
end;


procedure TDMEmprunts.TAEmpruntsBeforeDelete(DataSet: TDataSet);
begin
if VerifSiCompteSaisieDsBO(DataSet.FindField('Compte_emp').AsString,False,DataSet) then
begin
 Messagedlg(CompteImporte_DossierDos,mtInformation,[mbok],0);
 Abort;
end;

If Messagedlg('Êtes-vous sûr de supprimer cet emprunt ?',MtConfirmation,[mbyes,mbno],0) = mrno Then
   abort
   else
   begin
   CompteTmp :='';
   CapitalDuTmp:=0;
   CompteTmp :=DataSet.findfield('Compte_Emp').AsString;
   CapitalDuTmp:=DataSet.findfield('CapiResteDu_Emp').AsCurrency;
   TableGereStartTransaction(DataSet);
      try
      TraitementMAJBalance(true,dsBrowse);
      
      except
       TableGereRollBack(DataSet);
       TableGereRollBack(DMBalance.TaBalance);
      showmessage('Problème à la Mise A Jour de la balance ');
      abort;
      end;//fin du try
   end;

end;

procedure TDMEmprunts.TAEmpruntsAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
dataset.Refresh;
DataSet.DataSource.OnStateChange(DataSet);
end;

procedure TDMEmprunts.TAEmpruntsPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollback(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMEmprunts.TAEmpruntsDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollback(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMEmprunts.TaEmpruntGestionBeforePost(DataSet: TDataSet);
var
I:integer;
controleSaisie:TExceptLGR;
begin
try
//TableGereStartTransaction(DataSet);
if DataSet.State in [dsinsert,dsedit] then
    begin
         try
            for i:=0 to 25 do //
                 begin
                 controleSaisie:=CtrlSaisieEmprunt(DataSet.Fields[i]);
                 if controleSaisie.Retour=false then
                   abort;
//                   case controleSaisie.NumErreur of
//                      1000,1001:begin
//                                  abort;//champ code emprunt
//                                end;
//                           2000:begin
//                                  abort;//champ compte
//                                end;
//                           2001:begin
//                                  abort;//champ compte
//                                end;
//                      4000,4001:begin
//                                  abort;//champs montant restant dû
//                                end;
//                      5000,5001:begin
//                                  abort;//champs montant total
//                                end;
//                   end;//fin du case
                 end;//fin boucle for i
        except
         DataSet.Fields[i].FocusControl;
         abort;
        end;

       try
          if DataSet.State = dsinsert then
            begin //si table en insertion
              DataSet.FindField('ID').AsInteger:= MaxId_Query((DataSet as TTable),'ID');
            end;//fin table en insertion
       except
            showmessage('Problème à l''écriture dans la table Emprunt !!!');
            abort;
       end;//fin du try
    CompteCourant:=TaEmpruntGestion.FindField('compte_emp').AsString;
    EmpruntCourant:=TaEmpruntGestion.FindField('id').AsInteger;
    if TaEmpruntGestion.State=dsedit then
      begin
        if application.MessageBox(Pchar('Voulez-vous recalculer les annuités de cet emprunt'),'Attention',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mryes then
          begin
            TaEmpruntGestionBeforeDelete(DataSet);
            CalculEcheancier(DataSet);
          end;
      end
    else
    if TaEmpruntGestion.State=dsinsert then
      begin
       CalculEcheancier(DataSet);
      end;
    TaEcheance.Refresh;
    end;//fin si [dsinsert,dsedit]
except
TaEmpruntGestionBeforeDelete(DataSet);
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
abort;
end;//fin du try
end;


procedure TDMEmprunts.CalculEcheancier(DataSet:TDataSet);
var
Partie1,Partie2,Capital,CapitalRestant,CapitalPeriode,Interet,TauxAssurance,MensualiteAssurance,aux,Mensualite : Extended ;
NbRemb:TRemboursement;
NbRemb_Tmp,Differe_Tmp:integer;
TauxPeriode_Tmp:extended;
DateEch:Tdatetime;
tmp:string;
TotalAnnuite:currency;
begin
try
defiltrageDataset(TaEcheance);
NbRemb:=NbRb(DataSet.findfield('PeriodeRb').AsString);
DateEch:=IncMonth(DataSet.findfield('DateRealisation').AsDateTime,NbRemb.IncDate);
//DateEch:=IncMonth(DateEch,(NbRemb.IncDate*NbRemb.differe*DataSet.findfield('differe').Asinteger));
CapitalRestant:=DataSet.findfield('CapiTotal_Emp').ascurrency;
TauxAssurance:=DataSet.findfield('Assurance').ascurrency/100;
if uppercase(DataSet.FindField('TypeRB').asstring)='CAP' then
MensualiteAssurance:=DataSet.findfield('CapiTotal_Emp').ascurrency*TauxAssurance/(12/NbRemb.TypeRemb)
else
if uppercase(DataSet.FindField('TypeRB').asstring)='MEN' then
MensualiteAssurance:=DataSet.findfield('CapiTotal_Emp').ascurrency*TauxAssurance/NbRemb.TypeRemb;
NbRemb_Tmp:=NbRemb.NbRembP1;
TauxPeriode_Tmp:=DataSet.findfield('PP1').AsFloat/100;
partie1:=0;
partie2:=1;
//traiter le cas de la première échéance
if DataSet.findfield('DatePremEcheance').AsDateTime<>0 then
  Begin
     DateEch:=DataSet.findfield('DatePremEcheance').AsDateTime;
     Mensualite:=DataSet.findfield('CapitalRbPE').ascurrency+DataSet.findfield('interetRbPE').ascurrency+MensualiteAssurance;
     Interet:=DataSet.findfield('interetRbPE').ascurrency;
     Capital:=DataSet.findfield('CapitalRbPE').ascurrency;
     CapitalRestant:=CapitalRestant-Capital;
     if CapitalRestant<0 then CapitalRestant:=0;
     if Mensualite<>0 then
         EcritureEcheance(MaxId_Query(DMEmprunts.TaEcheanceGestion,'id_annuite'),DataSet.findfield('ID').AsInteger,
                       DateEch,Mensualite,Capital,Interet,MensualiteAssurance,0,CapitalRestant);
     dec(NbRemb_Tmp);
     dec(NbRemb.NbRemb);
     dec(NbRemb.Duree_Mois,NbRemb.IncDate);
     dec(NbRemb.Differe);
     DateEch:=IncMonth(DateEch,NbRemb.IncDate);
      Mensualite:=0;
      Capital:=0;
      Interet:=0;
      //MensualiteAssurance:=0;
      partie1:=0;
      partie2:=1;
  End;
//else
//  if NbRemb.NbRemb*NbRemb_Tmp <>0 then
//    CapitalRestant:=(DataSet.findfield('CapiTotal_Emp').ascurrency-DataSet.findfield('CapitalRbPE').ascurrency)/NbRemb.Duree_Mois*NbRemb_Tmp*NbRemb.incdate;
///

CapitalPeriode:=CapitalRestant;

if NbRemb.NbRemb<>0 then
  Begin
  if NbRemb_Tmp=0 then
    Begin
         if NbRemb.NbRembP2<>0 then
           begin
             NbRemb_Tmp:=NbRemb.NbRembP2;
             NbRemb.NbRembP2:=0;
             NbRemb.Duree_Mois:=(DataSet.findfield('P2').Asinteger+DataSet.findfield('P3').Asinteger);
             TauxPeriode_Tmp:=DataSet.findfield('PP2').AsFloat/100;
             CapitalPeriode:=CapitalRestant;
             //CapitalRestant:=(DataSet.findfield('CapiTotal_Emp').ascurrency-DataSet.findfield('CapitalRbPE').ascurrency)/NbRemb.Duree_Mois*NbRemb_Tmp*NbRemb.incdate;
           end
         else
           begin
             NbRemb_Tmp:=NbRemb.NbRembP3;
             NbRemb.NbRembP3:=0;
             NbRemb.Duree_Mois:=DataSet.findfield('P3').Asinteger;
             TauxPeriode_Tmp:=DataSet.findfield('PP3').AsFloat/100;
             CapitalPeriode:=CapitalRestant;
             //CapitalRestant:=(DataSet.findfield('CapiTotal_Emp').ascurrency-DataSet.findfield('CapitalRbPE').ascurrency)/NbRemb.Duree_Mois*NbRemb_Tmp*NbRemb.incdate;
           end;
    End;
    while NbRemb_Tmp<>0 do
       begin
         if uppercase(DataSet.FindField('TypeRB').asstring)='MEN' then//Annuité constante
           Begin
              while ((CapitalRestant > 0)and(NbRemb_Tmp<>0)) do
                begin
                  if ((NbRemb.Differe<=0)and (TauxPeriode_Tmp<>0)) then
                    begin
                      partie1:=CapitalPeriode*(TauxPeriode_Tmp/NbRemb.TypeRemb)*(Puiss((1+TauxPeriode_Tmp/NbRemb.TypeRemb),(NbRemb.Duree_Mois/(12/NbRemb.TypeRemb))));
                      partie2:=(puiss((1+TauxPeriode_Tmp/NbRemb.TypeRemb),(NbRemb.Duree_Mois/(12/NbRemb.TypeRemb)))-1);
                    end
                  else
                      if TauxPeriode_Tmp<>0 then
                        partie1:=(CapitalRestant*TauxPeriode_Tmp)/NbRemb.TypeRemb
                      else
                        partie1:=(CapitalRestant)/NbRemb_Tmp;
                  if NbRemb.Differe<=0 then
                      Mensualite:=arrondi((partie1/partie2)+MensualiteAssurance,2)
                  else
                      Mensualite:=arrondi(MensualiteAssurance+interet,2);
                  //traitement de la dernière année, problème arrondi
                  if ((NbRemb_Tmp=1)and(NbRemb.NbRembP2=0)and(NbRemb.NbRembP3=0)and (NbRemb.Differe<=0) and (TauxPeriode_Tmp<>0)) then
                    begin
                      interet:=Mensualite-MensualiteAssurance-CapitalRestant;
                    end
                  else
                    if TauxPeriode_Tmp<>0 then
                      Interet:=arrondi(CapitalRestant*(TauxPeriode_Tmp/NbRemb.TypeRemb),2);


                  if NbRemb.Differe<=0 then
                    Capital:=arrondi(Mensualite-Interet-MensualiteAssurance,2)
                  else
                    //traitement de la dernière année, problème arrondi
                      if ((NbRemb_Tmp=1)and(NbRemb.NbRembP2=0)and(NbRemb.NbRembP3=0)and (TauxPeriode_Tmp<>0)) then
                        Capital:=CapitalRestant
                      else
                        Capital:=0;

                  Mensualite:=capital+interet+mensualiteAssurance;{ isa  le  30/11/04 }

                  if capital>CapitalRestant then CapitalRestant:=capital;
                  
                  CapitalRestant:=CapitalRestant-Capital;
                  EcritureEcheance(MaxId_Query(DMEmprunts.TaEcheanceGestion,'id_annuite'),DataSet.findfield('ID').AsInteger,
                                    DateEch,Mensualite,Capital,Interet,MensualiteAssurance,0,CapitalRestant);
                  DateEch:=IncMonth(DateEch,NbRemb.IncDate);
                  dec(NbRemb_Tmp);
                  dec(NbRemb.NbRemb);
                  Mensualite:=0;
                  Capital:=0;
                  Interet:=0;
                //  MensualiteAssurance:=0;
                  partie1:=0;
                  partie2:=1;
                  if NbRemb.Differe>0 then
                    dec(NbRemb.Duree_Mois,NbRemb.IncDate);
                  dec(NbRemb.Differe);
                end;//fin du while
           End;//fin de l'annuité constante
         if uppercase(DataSet.FindField('TypeRB').asstring)='CAP' then//Capital constant
           Begin
              while ((CapitalRestant > 0)and(NbRemb_Tmp<>0)) do
                begin
                  if NbRemb.Differe<=0 then
                   // Capital:=(DataSet.findfield('CapiTotal_Emp').ascurrency-DataSet.findfield('CapitalRbPE').ascurrency)/(NbRemb.NbRemb)
                  //Capital:=(DataSet.findfield('CapiTotal_Emp').ascurrency-DataSet.findfield('CapitalRbPE').ascurrency)/(NbRemb.Duree_Mois/NbRemb.IncDate)
                    Capital:=CapitalPeriode/(NbRemb.Duree_Mois/NbRemb.IncDate)  { isa  le  31/03/04 }
                  else
                    Capital:=0;
                  if NbRemb.NbRemb<=1 then capital:=CapitalRestant;
                  capital:=arrondi(capital,2);
                  if TauxPeriode_Tmp<>0 then
                    Interet:=arrondi(CapitalRestant*(TauxPeriode_Tmp/(12/NbRemb.TypeRemb)),2);
                  //Interet:=CapitalRestant*(TauxPeriode_Tmp/(12/NbRemb.TypeRemb));
                  Mensualite:=arrondi(Capital+Interet+MensualiteAssurance,2);
                  CapitalRestant:=CapitalRestant-Capital;
                  if CapitalRestant<0 then CapitalRestant:=0;
                  if Mensualite<>0 then
                    EcritureEcheance(MaxId_Query(DMEmprunts.TaEcheanceGestion,'id_annuite'),DataSet.findfield('ID').AsInteger,
                                    DateEch,Mensualite,Capital,Interet,MensualiteAssurance,0,CapitalRestant);
                  DateEch:=IncMonth(DateEch,NbRemb.IncDate);
                  Mensualite:=0;
                  Capital:=0;
                  Interet:=0;
                //  MensualiteAssurance:=0;
                  partie1:=0;
                  partie2:=1;
                  dec(NbRemb_Tmp);
                  if NbRemb.Differe>0 then
                    dec(NbRemb.Duree_Mois,NbRemb.IncDate);
                  dec(NbRemb.Differe);
                  dec(NbRemb.NbRemb);
                end;//fin du while
           End;//fin capital constant
         if uppercase(DataSet.FindField('TypeRB').asstring)='AUT' then
           Begin
              //effacer l'ancien echéancier, l'utilisateur le remplira à la main
              while NbRemb_Tmp<>0 do
                 begin
                  TaEcheance.AppendRecord([MaxId_Query(DMEmprunts.TaEcheanceGestion,'id_annuite'),DataSet.findfield('ID').AsInteger,DateEch,
                                nil,nil,nil,nil,nil,CapitalRestant]);
//                  EcritureEcheance(MaxId_Query(DMEmprunts.TaEcheanceGestion,'id_annuite'),DataSet.findfield('ID').AsInteger,
//                                    DateEch,Mensualite,Capital,Interet,MensualiteAssurance,0,CapitalRestant);
                  Mensualite:=0;
                  Capital:=0;
                  Interet:=0;
                 // MensualiteAssurance:=0;
                  partie1:=0;
                  partie2:=1;

                  TaEcheance.FlushBuffers;
                  DateEch:=IncMonth(DateEch,NbRemb.IncDate);
                  dec(NbRemb_Tmp);
                 end;
           End;//fin autre type de remboursement
         if NbRemb.NbRembP2<>0 then
           begin
             NbRemb_Tmp:=NbRemb.NbRembP2;
             NbRemb.NbRembP2:=0;
             NbRemb.Duree_Mois:=(DataSet.findfield('P2').Asinteger+DataSet.findfield('P3').Asinteger);
             TauxPeriode_Tmp:=DataSet.findfield('PP2').AsFloat/100;
             CapitalPeriode:=CapitalRestant;
             //CapitalRestant:=(DataSet.findfield('CapiTotal_Emp').ascurrency-DataSet.findfield('CapitalRbPE').ascurrency)/NbRemb.Duree_Mois*NbRemb_Tmp*NbRemb.incdate;
           end
         else
           begin
             NbRemb_Tmp:=NbRemb.NbRembP3;
             NbRemb.NbRembP3:=0;
             NbRemb.Duree_Mois:=DataSet.findfield('P3').Asinteger;
             TauxPeriode_Tmp:=DataSet.findfield('PP3').AsFloat/100;
             CapitalPeriode:=CapitalRestant;
             //CapitalRestant:=(DataSet.findfield('CapiTotal_Emp').ascurrency-DataSet.findfield('CapitalRbPE').ascurrency)/NbRemb.Duree_Mois*NbRemb_Tmp*NbRemb.incdate;
           end;
       end;//fin du while NbRemb.NbRemb<>0
  End;//fin si NbRemb.NbRemb<>0
finally
  //
end;//fin du try finally
end;


function TDMEmprunts.NbRb(TypeRemboursement:string):TRemboursement;
var
reste:integer;
begin
result.Retour:=true;
result.IncDate:=0;
result.NbRemb:=0;
result.NbRembP1:=0;
result.NbRembP2:=0;
result.NbRembP3:=0;
result.Differe:=0;
try
    case ord(TypeRemboursement[1])of
     65:begin
          result.IncDate:=12;
          result.Differe:=1;
        end;
     83:begin
          result.IncDate:=6;
          result.Differe:=2;
          if TaEmpruntGestiondiffereMois.asinteger<>0 then
            Begin
               result.Differe:=2;
            End;
        end;
     84:begin
          result.IncDate:=3;
          result.Differe:=4;
        end;
     77:begin
          result.IncDate:=1;
          result.Differe:=12;
        end;
    end;//fin du case
if TaEmpruntGestionTypeRb.AsString='MEN' then
  result.TypeRemb:=result.Differe;
if TaEmpruntGestionTypeRb.AsString='CAP' then
  result.TypeRemb:=result.IncDate;
if TaEmpruntGestionTypeRb.AsString='AUT' then
  result.TypeRemb:=1;
//result.Differe:=result.Differe*TaEmpruntGestionDiffere.asinteger; //Changer par isa le 14/08/2007 pour pouvoir prendre en charge les mois
result.Differe:=TaEmpruntGestiondiffereMois.asinteger div result.IncDate; //Changer par isa le 14/08/2007 pour pouvoir prendre en charge les mois
if TaEmpruntGestionP1.asinteger mod result.IncDate <>0 then reste:=1 else reste:=0;
result.NbRembP1:=(TaEmpruntGestionP1.asinteger div result.IncDate)+reste;
if TaEmpruntGestionP2.asinteger mod result.IncDate <>0 then reste:=1 else reste:=0;
result.NbRembP2:=(TaEmpruntGestionP2.asinteger div result.IncDate)+reste;
if TaEmpruntGestionP3.asinteger mod result.IncDate <>0 then reste:=1 else reste:=0;
result.NbRembP3:=(TaEmpruntGestionP3.asinteger div result.IncDate)+reste;
result.NbRemb:=result.NbRembP1+result.NbRembP2+result.NbRembP3;
result.Duree_Mois:=(TaEmpruntGestionP1.asinteger+ TaEmpruntGestionP2.asinteger+TaEmpruntGestionP3.asinteger);
except
  result.Retour:=false;
end;
end;

procedure TDMEmprunts.TaEmpruntGestionBeforeInsert(DataSet: TDataSet);
begin
dataset.Fields[1].focuscontrol;
end;


Function TDMEmprunts.CtrlSaisieEcheance(CCourant:Tfield):TExceptLGR;
var
RetourEnregistrement:TEnregistrementComplet;
Capital,CapitalRembourse:currency;
Begin
try
    CtrlSaisieEcheance.NumErreur:=0;
    CtrlSaisieEcheance.Retour:=True;
    Capital:=0;
    CapitalRembourse:=0;
   if  CCourant.DataSet.State in [dsinsert,dsEdit] then
   case CCourant.Index of
    0: Begin  //Id_Annuité
//       If Empty(CCourant.AsString) then
//          Begin
//              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
//          end
//       else
//          begin
//            //
//          end;
       end;
    1: Begin  //Id_Emp
//       If Empty(CCourant.AsString) then
//          Begin
//              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
//          end
//       else
//          begin
//            //
//          end;
       end;
    2: Begin  //Date
       If not datevalide(CCourant.AsString) then
          Begin
              raise ExceptLGR.Create('La date d''échéance n''est pas valide',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
          end
       else
         if Infos_TInfosEmprunts(DMRech.TaEmpruntsRech,'ID',[ccourant.DataSet.Fields[1].asstring]).DateRealisation<CCourant.AsDateTime then
          begin
            //Vérifier si pas déjà utilisée
            FiltrageDataSet(DMRech.TaEchEmpRech,'id_annuite<>'+ccourant.DataSet.Fields[0].asstring+' and id_emp='+ccourant.DataSet.Fields[1].asstring);
            if Infos_TInfosEchEmp(DMRech.TaEchEmpRech,'Date',[CCourant.Asstring]).ResultInfos then
              raise ExceptLGR.Create('il ne peut exister 2 annuités pour la même date',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
            DeFiltrageDataSet(DMRech.TaEchEmpRech);
          end
        else
          raise ExceptLGR.Create('La date d''échéance ne peut être antérieure à la date de réalisation de l''emprunt',StrToInt_Lgr(inttostr(CCourant.Index)+'002'),true,mtError,result);
       end;
    3: Begin  //Annuite

         //CCourant.AsCurrency:= CCourant.DataSet.Fields[4].AsCurrency+CCourant.DataSet.Fields[5].AsCurrency+CCourant.DataSet.Fields[6].AsCurrency+CCourant.DataSet.Fields[7].AsCurrency;
         CCourant.DataSet.Fields[4].AsCurrency:=CCourant.AsCurrency-(CCourant.DataSet.Fields[5].AsCurrency+CCourant.DataSet.Fields[6].AsCurrency+CCourant.DataSet.Fields[7].AsCurrency);
         CCourant.DataSet.Fields[8].AsCurrency:=CapitalRestantDuAvantCapital-(CCourant.DataSet.Fields[4].AsCurrency);
       end;
          
    4: Begin  //Capital
       //remplir l'annuité
       CCourant.DataSet.Fields[3].AsCurrency:= CCourant.AsCurrency+CCourant.DataSet.Fields[5].AsCurrency+CCourant.DataSet.Fields[6].AsCurrency+CCourant.DataSet.Fields[7].AsCurrency;
         CCourant.DataSet.Fields[8].AsCurrency:=CapitalRestantDuAvantCapital-(CCourant.DataSet.Fields[4].AsCurrency);
//       Capital:=Infos_TInfosEmprunts(DMRech.TaEmpruntsRech,'ID',[ccourant.DataSet.Fields[1].asstring]).CapiTotal_Emp;
//       CapitalRembourse:=SommeTotauxGeneric(['Capital'],DMRech.TaEchEmpRech).Total1;
//       FiltrageDataSet(DMRech.TaEchEmpRech,'id_emp='+ccourant.DataSet.Fields[1].asstring);
//       If Capital<CapitalRembourse then
//          Begin
//              //if Application.MessageBox(Pchar('Le capital remboursé est supérieur au capital emprunté, voulez-vous confirmer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
//              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result);
//          end;
       end;
    5: Begin  //Interets
//       If Empty(CCourant.AsString) then
//          Begin
//              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
//          end
//       else
          begin  //remplir l'annuité
            CCourant.DataSet.Fields[3].AsCurrency:= CCourant.AsCurrency+CCourant.DataSet.Fields[4].AsCurrency+CCourant.DataSet.Fields[6].AsCurrency+CCourant.DataSet.Fields[7].AsCurrency;
         CCourant.DataSet.Fields[8].AsCurrency:=CapitalRestantDuAvantCapital-(CCourant.DataSet.Fields[4].AsCurrency);
          end;
       end;
    6: Begin  // Assurances
//       If Empty(CCourant.AsString) then
//          Begin
//              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
//          end
//       else
          begin //remplir l'annuité
            CCourant.DataSet.Fields[3].AsCurrency:= CCourant.AsCurrency+CCourant.DataSet.Fields[5].AsCurrency+CCourant.DataSet.Fields[4].AsCurrency+CCourant.DataSet.Fields[7].AsCurrency;
         CCourant.DataSet.Fields[8].AsCurrency:=CapitalRestantDuAvantCapital-(CCourant.DataSet.Fields[4].AsCurrency);
          end;
       end;
    7: Begin  //Frais_divers
//       If Empty(CCourant.AsString) then
//          Begin
//              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
//          end
//       else
          begin //remplir l'annuité
            CCourant.DataSet.Fields[3].AsCurrency := CCourant.AsCurrency+CCourant.DataSet.Fields[5].AsCurrency+CCourant.DataSet.Fields[6].AsCurrency+CCourant.DataSet.Fields[4].AsCurrency;
         CCourant.DataSet.Fields[8].AsCurrency:=CapitalRestantDuAvantCapital-(CCourant.DataSet.Fields[4].AsCurrency);
          end;
       end;
    8: Begin  //Capital_Restant_du
       If Empty(CCourant.AsString) then
          Begin
              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result);
          end
       else
          begin
         CCourant.DataSet.Fields[8].AsCurrency:=CapitalRestantDuAvantCapital-(CCourant.DataSet.Fields[4].AsCurrency);
          end;
       end;
    9: Begin  //Rembourse
          if empty(CCourant.asstring) then
             begin
               CCourant.AsBoolean:=false;
               CCourant.DataSet.Fields[11].asstring:='';
               CCourant.DataSet.Fields[12].asstring:='';
             end
          else
             begin
                If (CCourant.AsBoolean) then
                  begin
                    if empty(CCourant.DataSet.Fields[11].asstring) then
                      CCourant.DataSet.Fields[11].asdatetime:=CCourant.DataSet.Fields[2].asdatetime;
                    CCourant.DataSet.Fields[10].AsBoolean:=false;
                  end
                else
                  begin
                  CCourant.DataSet.Fields[11].asstring:='';
                  CCourant.DataSet.Fields[12].AsString:='';
                  end;
             end;
       end;
    10: Begin  //Annule
          If (CCourant.AsBoolean) then
             Begin
                CCourant.DataSet.Fields[9].AsBoolean:=false;
                CCourant.DataSet.Fields[12].AsString:='';
                CCourant.DataSet.Fields[11].AsString:='';
             end
          else
            if empty(CCourant.asstring) then
             begin
               CCourant.AsBoolean:=false;
             end;
       end;
    11: Begin  //DateRemboursement
          if not VerifFNumeric(CCourant).Vide then
            Begin
              if not datevalide(CCourant.AsString) then
                raise ExceptLGR.Create('Cette date n''est pas valide.',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result)
              else
//                if CCourant.AsDateTime<CCourant.DataSet.Fields[2].AsDateTime then
//                  raise ExceptLGR.Create('La date de remboursement est antérieure à la date d''échéance.',StrToInt_Lgr(inttostr(CCourant.Index)+'002'),true,mtError,result)
//                else
                  CCourant.DataSet.Fields[9].AsBoolean:=true;
            End
          else
            Begin//si champ vide, vérifier si rembourse = false et reference vide sinon demander à remplir date
               if ((CCourant.DataSet.Fields[9].AsBoolean)or(not empty(CCourant.DataSet.Fields[12].AsString))) then
                 raise ExceptLGR.Create('Cette échéance est signalée comme étant remboursée, vous devez indiquer la date de ce remboursement',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
            End;
       end;
    12: Begin  //Reference
          If ((Empty(CCourant.AsString))and(CCourant.DataSet.Fields[9].AsBoolean)) then
             Begin
                 //raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),false,mtError,result);
             end
          else
             if not empty(CCourant.AsString)then
             begin
               //vérifier la validité de cette référence
               if not Infos_TInfosPiece(dmrech.TaPieceRech,'reference',[CCourant.AsString]).ResultInfos then
                 raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result);
               CCourant.DataSet.Fields[9].AsBoolean:=true;
               if empty(CCourant.DataSet.Fields[11].asstring) then
                  CCourant.DataSet.Fields[11].asdatetime:=CCourant.DataSet.Fields[2].asdatetime;
             end;
       end;
   end;
except
  abort;
end;//fin du try except
end;


procedure TDMEmprunts.TaEcheanceGestionAfterInsert(DataSet: TDataSet);
begin
InitChampAfterInsert([null,TaEmpruntGestionID.AsInteger,'',0,0,0,0,0,0,false,false],dataset);
end;

procedure TDMEmprunts.TaEcheanceGestionBeforeInsert(DataSet: TDataSet);
begin
//abort;
dataset.Fields[2].focuscontrol;
end;

procedure TDMEmprunts.TaEcheanceGestionBeforePost(DataSet: TDataSet);
var
I:integer;
controleSaisie:TExceptLGR;
begin
try
//TableGereStartTransaction(DataSet);
if DataSet.State in [dsinsert,dsedit] then
    begin
//         try
                 controleSaisie:=CtrlSaisieEcheance(DataSet.Fields[4]);
                 if controleSaisie.Retour=false then
                   abort;
            for i:=0 to 12 do //
              begin
                 try
                 controleSaisie:=CtrlSaisieEcheance(DataSet.Fields[i]);
//                 if controleSaisie.Retour=false then
//                   abort;
                 except
                   case controleSaisie.NumErreur of
                          1000:begin//id_Emp
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                2000,2001,2002:begin//Date
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                          3000:begin//Annuite
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                          4001:begin//Capital
                                 if Application.MessageBox(Pchar('Le capital remboursé est supérieur au capital emprunté, voulez-vous confirmer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                                   begin
                                     DataSet.Fields[i].FocusControl;
                                     abort;
                                   end;
                               end;
                          5000:begin//Interets
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                          6000:begin//Assurances
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                          7000:begin//Frais_Divers
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                          8000:begin//Capital_Restant_du
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                          9000:begin//Rembourse
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                         10000:begin//Annule
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                   //11002,
                   11000:begin//DateRemboursement
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                         11001:begin//DateRemboursement
//                                   application.Messagebox(Pchar('Cette échéance est signalée comme étant remboursée, vous devez donc indiquer la référence de ce remboursement'),'Erreur de saisie',0);
//                                   DataSet.Fields[i].FocusControl;
//                                   abort;
                               end;
                         12000:begin//Reference
//                                   application.Messagebox(Pchar('Cette échéance est signalée comme étant remboursée, vous devez donc indiquer la référence de ce remboursement'),'Erreur de saisie',0);
//                                   DataSet.Fields[i].FocusControl;
//                                   abort;
                               end;
                         12001:begin//Reference
                                   application.Messagebox(Pchar('Cette référence n''est pas valide'),'Erreur de saisie',0);
                                   DataSet.Fields[i].FocusControl;
                                   abort;
                               end;
                   end;//fin du case
                 end;
              end;//fin boucle for i

       try
          if DataSet.State= dsinsert then
            begin //si table en insertion
              DataSet.FindField('ID_Annuite').AsInteger:= MaxId_Query((DataSet as TTable),'ID_Annuite');
            end;//fin table en insertion
       except
            showmessage('Problème à l''écriture dans la table Echéance !!!');
            abort;
       end;//fin du try
    end;//fin si [dsinsert,dsedit]
except
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
abort;
end;//fin du try
end;


procedure TDMEmprunts.TaEmpruntGestionBeforeDelete(DataSet: TDataSet);
begin
    CompteCourant:=DataSet.FindField('compte_emp').asstring;
    EmpruntCourant:=DataSet.FindField('ID').AsInteger;
    QuDeleteEcheance.close;
    QuDeleteEcheance.ParamByName('id').asinteger:=DataSet.FindField('ID').AsInteger;
    QuDeleteEcheance.ExecSQL;
end;



Function TDMEmprunts.Puiss(X,Y:Double):Extended;
// Elevation De X à la puissance Y
Begin
  Puiss:=Exp(Y * LN(X));
end;


procedure TDMEmprunts.Filtrage_QuRecupEmpruntsSurCpt_SurCpt(Cpt:string);
Begin
try
QuRecupEmpruntsSurCpt.Close;
QuRecupEmpruntsSurCpt.SQL.Clear;

QuRecupEmpruntsSurCpt.SQL.Add(requeteQuRecupEmpruntsSurCpt);

QuRecupEmpruntsSurCpt.parambyname('Compte').asstring:=Cpt;
//QuRecupEmpruntsSurCpt.parambyname('DateDeb').AsDate:=e.DatExoDebut;
DMEmprunts.QuRecupEmpruntsSurCpt.filtered:=false;
QuRecupEmpruntsSurCpt.Prepare;
QuRecupEmpruntsSurCpt.open;
DMEmprunts.QuRecupEmpruntsSurCpt.filtered:=true;
if EmpruntCourant<>0 then
  QuRecupEmpruntsSurCpt.Locate('id',EmpruntCourant,[]);
except
   ///
end;
End;


procedure TDMEmprunts.TaEmpruntGestionAfterOpen(DataSet: TDataSet);
begin
FormateValidCharCurrField(DataSet,['0'..'9',DecimalSeparator]);
FormateValidCharFloatField(DataSet,['0'..'9',DecimalSeparator]);
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;

procedure TDMEmprunts.TaEmpruntGestionAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
MessDerSub:=true;
 DataSet.DisableControls;
 DataSet.Refresh;
 ReactualiseQuerys;
 DataSet.EnableControls;
end;

Procedure TDMEmprunts.ReactualiseQuerys;
Begin
//raffraîchir les querys
 TaEcheanceGestion.Refresh;
 TaEmpruntGestion.Refresh;

 QuCptEmprunts.Close;
 QuCptEmprunts.Open;
 if not empty(CompteCourant)then
   QuCptEmprunts.Locate('compte_emp',CompteCourant,[]);
   
End;


procedure TDMEmprunts.TaEcheanceGestionAfterScroll(DataSet: TDataSet);
begin
QuTotalEcheance.DisableControls;
QuTotalEcheance.close;
QuTotalEcheance.ParamByName('id').asinteger:=dataset.findfield('id_emp').AsInteger;
QuTotalEcheance.Open;
QuTotalEcheance.EnableControls;
end;

procedure TDMEmprunts.QuTotalEcheanceAfterOpen(DataSet: TDataSet);
begin
FormateMonnaieField(dataset,E.FormatMonnaie,'');
//FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;

procedure TDMEmprunts.TaEmpruntGestionAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
// DataSet.DisableControls;//
 DataSet.Refresh;
 ReactualiseQuerys;
// DataSet.EnableControls;
end;

procedure TDMEmprunts.TaEmpruntGestionAfterInsert(DataSet: TDataSet);
begin
//calculer un nouveau code d'emprunt par défaut

InitChampAfterInsert([null,'','','',0,0,'','','','','','','','','','MEN','ANN',0,0,0,'',0,0,null,'',true],dataset);
end;



Function AffichReferenceReglement(Requete:TDataset;Datasource:Tdatasource):TReference;
Begin
  try
    Result.retour:=true;
    if VisuListe = nil then VisuListe:=TVisuListe.Create(Application.MainForm);
    if DMEmprunts = nil then DMEmprunts:=TDMEmprunts.Create(application.MainForm);

    VisuListe.BtnDetail.OnClick:=DMEmprunts.BtnDetail_VisuListe_Click;
    VisuListe.PaGrille.OnResize:=DMEmprunts.PaGrilleResize_VisuListe;
    VisuListe.GrDBVisu.OnDblClick:=VisuListe.BtnEnregistrerClick;
    VisuListe.BtnEnregistrer.visible:=true;
    VisuListe.RxLabTitre.Caption:='Liste de réglements';
    VisuListe.PaTitrePetit.Caption:='Liste de réglements';

    VisuListe.GrDBVisu.DefaultDrawing:=False;
//    (Requete as TQuery).ParamByName('J').AsInteger:=journal;
    //Librairie_Isa.
    GrDbGridInitColonne(VisuListe.GrDBVisu,Datasource,Requete,
                       ['Date','Référence','compte','Libellé'],
                       ['Date','Reference','compte','Libelle'],E.FormatMonnaie,E.EditFormat);

    if VisuListe.Showmodal=mrok then
     result.Reference:=Requete.findfield('Reference').asstring
    else
     result.retour:=false;
  except
    Result.retour:=false;
  end;//fin du try finally
End;


procedure TDMEmprunts.PaGrilleResize_VisuListe(Sender: TObject);
begin
  FormateTailleColonne(visuliste.GrDBVisu,10,[2,2,2,4]);
  WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TDMEmprunts.BtnDetail_VisuListe_Click(Sender: TObject);
begin
  DetailEcritureCompte(visuliste.GrDBVisu.datasource.DataSet.findfield('Compte').asstring,true,false);
end;



procedure TDMEmprunts.TaEcheanceGestionAfterOpen(DataSet: TDataSet);
begin
FormateValidCharCurrField(DataSet,['0'..'9',DecimalSeparator]);
FormateValidCharFloatField(DataSet,['0'..'9',DecimalSeparator]);
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;

procedure TDMEmprunts.TaEcheanceAfterOpen(DataSet: TDataSet);
begin
{ isa  le  22/03/04 }
FormateValidCharCurrField(DataSet,['0'..'9',DecimalSeparator]);
FormateValidCharFloatField(DataSet,['0'..'9',DecimalSeparator]);
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;

procedure TDMEmprunts.QuRecupEmpruntsSurCptAfterOpen(DataSet: TDataSet);
begin
FormateValidCharCurrField(DataSet,['0'..'9',DecimalSeparator]);
FormateValidCharFloatField(DataSet,['0'..'9',DecimalSeparator]);
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
{ isa  le  29/03/04 }
TaEmpruntGestion.close;
TaEmpruntGestion.Open;
end;

procedure TDMEmprunts.QuTotalEmpruntsAfterOpen(DataSet: TDataSet);
begin
FormateValidCharCurrField(DataSet,['0'..'9',DecimalSeparator]);
FormateValidCharFloatField(DataSet,['0'..'9',DecimalSeparator]);
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;

procedure TDMEmprunts.TAEmpruntsAfterOpen(DataSet: TDataSet);
begin
FormateValidCharCurrField(DataSet,['0'..'9',DecimalSeparator]);
FormateValidCharFloatField(DataSet,['0'..'9',DecimalSeparator]);
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;

procedure TDMEmprunts.QuCptEmpruntsAfterScroll(DataSet: TDataSet);
var
compte:string;
begin
compte:='';
if DMEmprunts.QuCptEmprunts.recordcount<>0 then
  compte:=DMEmprunts.QuCptEmprunts.findfield('Compte_Emp').asstring;

DMEmprunts.Filtrage_QuRecupEmpruntsSurCpt_SurCpt(compte);

DMEmprunts.QuTotalEmprunts.DisableControls;
DMEmprunts.QuTotalEmprunts.ParamByName('cpt').AsString:=compte;
DMEmprunts.QuTotalEmprunts.Active:=false;
DMEmprunts.QuTotalEmprunts.Open;
DMEmprunts.QuTotalEmprunts.EnableControls;

end;


Procedure TDMEmprunts.GestionAccesEmprunts;
Begin
  case Quand of
     C_Ouverture:Begin
                  if E.AccesOuverture then
                   begin
                    TAEmprunts.BeforeInsert := TAEmpruntsBeforeInsert;
                    TAEmprunts.BeforeEdit := TAEmpruntsBeforeEdit;
                    TAEmprunts.BeforeDelete := TAEmpruntsBeforeDelete;
                   end
                  else
                   begin
                    TAEmprunts.BeforeInsert := TAEmpruntsBeforeEIDOuv_Abort;
                    TAEmprunts.BeforeEdit := TAEmpruntsBeforeEIDOuv_Abort;
                    TAEmprunts.BeforeDelete := TAEmpruntsBeforeEIDOuv_Abort;
                   end;
                 End;

     C_Mouvement:Begin
                  if E.AccesCloture then
                   begin
                    //Table emprunt
                    TaEmpruntGestion.BeforeInsert := TaEmpruntGestionBeforeInsert;
                    TaEmpruntGestion.BeforeEdit := nil;
                    TaEmpruntGestion.BeforeDelete := TaEmpruntGestionBeforeDelete;
                    // table echeance
                    TaEcheanceGestion.BeforeInsert := TaEcheanceGestionBeforeInsert;
                    TaEcheanceGestion.BeforeEdit := TaEcheanceGestionBeforeEdit;
                    TaEcheanceGestion.BeforeDelete := nil;
                   end
                  else
                   begin
                    TaEmpruntGestion.BeforeInsert := TaEmpruntGestionBeforeEIDClo_Abort;
                    TaEmpruntGestion.BeforeEdit := TaEmpruntGestionBeforeEIDClo_Abort;
                    TaEmpruntGestion.BeforeDelete := TaEmpruntGestionBeforeEIDClo_Abort;
                    // table echeance
                    TaEcheanceGestion.BeforeInsert := TaEcheanceGestionBeforeEIDClo_Abort;
                    TaEcheanceGestion.BeforeEdit := TaEcheanceGestionBeforeEIDClo_Abort;
                    TaEcheanceGestion.BeforeDelete := TaEcheanceGestionBeforeEIDClo_Abort;
                   end;
               End;
  end;
End;

procedure TDMEmprunts.TaEmpruntGestionBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesCloture then
 MessageDlg('Vous ne pouvez plus modifier les emprunts !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les emprunts !', mtError, [mbOK], 0);
abort;
End;

procedure TDMEmprunts.TAEmpruntsBeforeEIDOuv_Abort(DataSet: TDataSet);
Begin
if not e.AccesOuverture then
 MessageDlg('Vous ne pouvez plus modifier les emprunts d''ouverture !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les emprunts d''ouverture !', mtError, [mbOK], 0);
abort;
End;

procedure TDMEmprunts.TaEcheanceGestionBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesCloture then
 MessageDlg('Vous ne pouvez plus modifier les échéances !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les échéances !', mtError, [mbOK], 0);
abort;
End;


procedure TDMEmprunts.TaEcheanceGestionBeforeEdit(DataSet: TDataSet);
begin
//récupérer le capital restant du de la ligne avant modification de l'annuité ou du capital ou autre
//pour recalculer le capital restant du de la ligne
CapitalTmp:=TaEcheanceGestionCapital.AsCurrency;
CapitalRestantDuAvantCapital:=TaEcheanceGestionCapital_Restant_du.AsCurrency+(TaEcheanceGestioncapital.AsCurrency);
end;


Function TDMEmprunts.RecalculCapitalRestantDu(DataSet: TDataSet;IdEmp:integer;CapitalDepart:currency):TExceptLGR;
var
CapitalRestant:currency;
EcheanceCourante:integer;
nb : integer;
begin
try//finally
try//except
result.retour:=true;
if dataset<>nil then
  begin
     //EcheanceCourante:=dataset.findfield('id_Annuite').asinteger;
//     dataset.DisableControls;
    // TableGereStartTransaction(dataset);
     CapitalRestant:=CapitalDepart;
//     FiltrageDataSet(Dataset,'id_Annuite<> '+ inttostr(EcheanceCourante) +' and id_emp='+inttostr(idEmp));
     TTable(Dataset).IndexName:='DateEch_';
     FiltrageDataSet(Dataset,'id_emp='+inttostr(idEmp));
     Dataset.first;
     while not(dataset.Eof) do
       begin
//       TableGereStartTransaction(dataset);
           dataset.edit;
           CapitalRestant:=CapitalRestant-dataset.findfield('Capital').ascurrency;
           dataset.findfield('Capital_restant_du').ascurrency:=CapitalRestant;
//           TableGerePost(dataset);
           dataset.post;
           dataset.next;
//           if(nb>200)then begin
//                 TableGereCommit(dataset);
                // TableGereStartTransaction(dataset);
//                 nb:=0;
//           end;
           inc(nb);
       end;
     if Arrondi(CapitalRestant,2)<>0 then
       if MessageDlg('Le capital restant Du, final de votre emprunt est égal à '+currtostr(Arrondi(CapitalRestant,2))+'.'+#13+#10+'Confirmez-vous votre saisie ?', mtError, [mbYes,mbNo], 0) = mrNo then
           abort;
 // TableGereCommit(dataset);
//  dataset.Locate('id',echeancecourante,[]);
  end;
except
  TableGereRollBack(dataset);
end;
finally
//  dataset.EnableControls;
dataset.Refresh;
TaEcheanceGestionAfterScroll(TaEcheanceGestion);
end;
end;


procedure TDMEmprunts.TaEcheanceGestionAfterPost(DataSet: TDataSet);
var
capitalTotalDepart:currency;
begin
try//finally
try//except            
//if CapitalTmp<>TaEcheanceGestionCapital.AsCurrency then
FiltrageDataSet(DMRech.TaEmpruntsRech,'id='+IntToStr(TaEcheanceGestion.findfield('id_emp').asinteger));

  if DMEmprunts.RecalculCapitalRestantDu(TaEcheance,TaEcheanceGestion.findfield('id_emp').asinteger,
  Infos_TInfosEmprunts(DMRech.TaEmpruntsRech,'ID',[TaEcheanceGestion.findfield('id_emp').asinteger]).CapiTotal_Emp).retour=false then
    abort;
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
MessDerSub:=true;
DataSet.Refresh;
except
  TableGereRollBack(DataSet);
  TableGereRollBack(DMBalance.TaBalance);
  abort;
end;
finally
  dataset.Refresh;
end;
end;


Function EditionEmpruntTresorerieL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet;tri:TTri):Boolean;
var
periode:TPeriode;
i:integer;
//rang:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
CodeGrTmp,EmpruntTmp,DesignationTmp:string;
dateDebut:tDate;
//Un,deux,trois,Quatre,cinq,six,sept,huit,neuf,dix,onze,douze:currency;
//TotUn,Totdeux,Tottrois,TotQuatre,Totcinq,Totsix,Totsept,Tothuit,Totneuf,Totdix,Totonze,Totdouze:currency;
//TotGENUn,TotGENdeux,TotGENtrois,TotGENQuatre,TotGENcinq,TotGENsix,TotGENsept,TotGENhuit,TotGENneuf,TotGENdix,TotGENonze,TotGENdouze:currency;
TitreCompte:string;
Compteur:integer;
ParamAffichPeriode:TParamAffichPeriode;
NumEmprunt:integer;
P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12:TPeriodeAnnuite;
MoisCourant:word;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
initialise_PeriodeAnnuite(P1);
initialise_PeriodeAnnuite(P2);
initialise_PeriodeAnnuite(P3);
initialise_PeriodeAnnuite(P4);
initialise_PeriodeAnnuite(P5);
initialise_PeriodeAnnuite(P6);
initialise_PeriodeAnnuite(P7);
initialise_PeriodeAnnuite(P8);
initialise_PeriodeAnnuite(P9);
initialise_PeriodeAnnuite(P10);
initialise_PeriodeAnnuite(P11);
initialise_PeriodeAnnuite(P12);
  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      ParamAffichPeriode.PreAffichage:=true;
      ParamAffichPeriode.Titre:='Indiquez la date de début';
      ParamAffichPeriode.AffichDateFin:=false;
      periode:=ChoixPeriodeAffich(e.DatExoDebut,0,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := 0;
    end;
  if periode.Retour then
   begin
//    rang:=DateInfos(periode.DateDeb,true).mois-DateInfos(e.DatExoDebut,true).mois;
//    if rang<0 then rang:=0;
    periode.DateFin :=MoisSuivant(periode.DateDeb,11).Date_-1;
    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DMEmprunts =nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMEmprunts.ListeFilterRecordEmprunt.clear;
        if CodeGr<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du groupe :'+CodeGr.Strings[0]+' au groupe :'+CodeGr.Strings[CodeGr.count-1];
          DMEmprunts.ListeFilterRecordEmprunt.Assign(CodeGr);
          DMEmprunts.QuEmprunt_Edition.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionMouvementFilterRecord;
          DMEmprunts.QuEmprunt_Edition.filtered:=true;
         end
        else
          begin
            DMEmprunts.QuEmprunt_Edition.OnFilterRecord:=nil;
            Titrecompte:=' Tous les groupes ';
          end;
          DMEmprunts.QuEmprunt_Edition.Close;
          DMEmprunts.QuEmprunt_Edition.sql.clear;
          DMEmprunts.QuEmprunt_Edition.sql.add('select CodeGr,id, Code_Emp,Compte_Emp,Designation_emp,Ech."Date",Annuite,capital,PP1,(P1+P2+P3)as Duree,CapiTotal_Emp,Banque,DateRealisation from emprunts Emp');
          DMEmprunts.QuEmprunt_Edition.sql.add('join EchEmp Ech on (Emp.id=ech.id_emp)');
          DMEmprunts.QuEmprunt_Edition.sql.add('where Ech."Date" between :DateDeb and :DateFin');
          if(tri=CodeEmp)then
             DMEmprunts.QuEmprunt_Edition.sql.add('order by CodeGr,code_emp,ech."date"')
          else
             DMEmprunts.QuEmprunt_Edition.sql.add('order by CodeGr,dateRealisation,code_emp,ech."date"');

          DMEmprunts.QuEmprunt_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMEmprunts.QuEmprunt_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMEmprunts.QuEmprunt_Edition.Open;
          DMEmprunts.QuEmprunt_Edition.First;
          if DMEmprunts.QuEmprunt_Edition.recordcount<>0 then
          begin
          P1.MoisAnnee:=DateInfos(periode.DateDeb,true).MoisAnnee;
          P1.Mois:=StrToInt_Lgr(copy(P1.MoisAnnee,1,2));
          P2.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,0).Date_,true).MoisAnnee;
          P2.Mois:=StrToInt_Lgr(copy(P2.MoisAnnee,1,2));
          P3.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,1).Date_,true).MoisAnnee;
          P3.Mois:=StrToInt_Lgr(copy(P3.MoisAnnee,1,2));
          P4.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,2).Date_,true).MoisAnnee;
          P4.Mois:=StrToInt_Lgr(copy(P4.MoisAnnee,1,2));
          P5.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,3).Date_,true).MoisAnnee;
          P5.Mois:=StrToInt_Lgr(copy(P5.MoisAnnee,1,2));
          P6.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,4).Date_,true).MoisAnnee;
          P6.Mois:=StrToInt_Lgr(copy(P6.MoisAnnee,1,2));
          P7.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,5).Date_,true).MoisAnnee;
          P7.Mois:=StrToInt_Lgr(copy(P7.MoisAnnee,1,2));
          P8.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,6).Date_,true).MoisAnnee;
          P8.Mois:=StrToInt_Lgr(copy(P8.MoisAnnee,1,2));
          P9.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,7).Date_,true).MoisAnnee;
          P9.Mois:=StrToInt_Lgr(copy(P9.MoisAnnee,1,2));
          P10.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,8).Date_,true).MoisAnnee;
          P10.Mois:=StrToInt_Lgr(copy(P10.MoisAnnee,1,2));
          P11.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,9).Date_,true).MoisAnnee;
          P11.Mois:=StrToInt_Lgr(copy(P11.MoisAnnee,1,2));
          P12.MoisAnnee:=DateInfos(MoisSuivant(periode.DateDeb,10).Date_,true).MoisAnnee;
          P12.Mois:=StrToInt_Lgr(copy(P12.MoisAnnee,1,2));
          CodeGrTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
          Compteur:=0;
          ListeValeur.Add('9;GROUPE : '+CodeGrTmp);
                while not DMEmprunts.QuEmprunt_Edition.Eof do
                  begin
                    NumEmprunt:=DMEmprunts.QuEmprunt_Edition.FindField('id').Asinteger;
                    EmpruntTmp:=DMEmprunts.QuEmprunt_Edition.FindField('Code_emp').AsString;
                    DesignationTmp:=DMEmprunts.QuEmprunt_Edition.FindField('Designation_emp').AsString;
                    dateDebut:=DMEmprunts.QuEmprunt_Edition.FindField('DateRealisation').AsDateTime;
                      while ((not DMEmprunts.QuEmprunt_Edition.Eof)and(NumEmprunt=DMEmprunts.QuEmprunt_Edition.FindField('id').Asinteger)) do
                        Begin
                          MoisCourant:=DateInfos(DMEmprunts.QuEmprunt_Edition.FindField('date').Asdatetime).mois;

                          if MoisCourant=P1.mois then
                            P1.Annuite:=P1.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P2.mois then
                            P2.Annuite:=P2.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P3.mois then
                            P3.Annuite:=P3.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P4.mois then
                            P4.Annuite:=P4.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P5.mois then
                            P5.Annuite:=P5.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P6.mois then
                            P6.Annuite:=P6.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P7.mois then
                            P7.Annuite:=P7.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P8.mois then
                            P8.Annuite:=P8.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P9.mois then
                            P9.Annuite:=P9.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P10.mois then
                           P10.Annuite:=P10.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P11.mois then
                           P11.Annuite:=P11.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                          if MoisCourant=P12.mois then
                           P12.Annuite:=P12.Annuite+arrondi(DMEmprunts.QuEmprunt_Edition.FindField('Annuite').Ascurrency,2);
                        DMEmprunts.QuEmprunt_Edition.next;
                        end;   //
                        ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle(CodeGrTmp)+'-'+GereLibelle(EmpruntTmp)+'-'+GereLibelle(DesignationTmp)+
                                         ';'+
                                         dateinfos(dateDebut,true).DateStr+
                                         ';'+
                                         currtostr(P1.Annuite)+
                                         ';'+
                                         currtostr(P2.Annuite)+
                                         ';'+
                                         currtostr(P3.Annuite)+
                                         ';'+
                                         currtostr(P4.Annuite)+
                                         ';'+
                                         currtostr(P5.Annuite)+
                                         ';'+
                                         currtostr(P6.Annuite)+
                                         ';'+
                                         currtostr(P7.Annuite)+
                                         ';'+
                                         currtostr(P8.Annuite)+
                                         ';'+
                                         currtostr(P9.Annuite)+
                                         ';'+
                                         currtostr(P10.Annuite)+
                                         ';'+
                                         currtostr(P11.Annuite)+
                                         ';'+
                                         currtostr(P12.Annuite)
                                         );
                        P1.TotAnnuite:=P1.TotAnnuite+p1.Annuite;
                        P2.TotAnnuite:=P2.TotAnnuite+p2.Annuite;
                        P3.TotAnnuite:=P3.TotAnnuite+p3.Annuite;
                        P4.TotAnnuite:=P4.TotAnnuite+p4.Annuite;
                        P5.TotAnnuite:=P5.TotAnnuite+p5.Annuite;
                        P6.TotAnnuite:=P6.TotAnnuite+p6.Annuite;
                        P7.TotAnnuite:=P7.TotAnnuite+p7.Annuite;
                        P8.TotAnnuite:=P8.TotAnnuite+p8.Annuite;
                        P9.TotAnnuite:=P9.TotAnnuite+p9.Annuite;
                        P10.TotAnnuite:=P10.TotAnnuite+p10.Annuite;
                        P11.TotAnnuite:=P11.TotAnnuite+p11.Annuite;
                        P12.TotAnnuite:=P12.TotAnnuite+p12.Annuite;

                        P1.TotGENAnnuite:=P1.TotGENAnnuite+p1.Annuite;
                        P2.TotGENAnnuite:=P2.TotGENAnnuite+p2.Annuite;
                        P3.TotGENAnnuite:=P3.TotGENAnnuite+p3.Annuite;
                        P4.TotGENAnnuite:=P4.TotGENAnnuite+p4.Annuite;
                        P5.TotGENAnnuite:=P5.TotGENAnnuite+p5.Annuite;
                        P6.TotGENAnnuite:=P6.TotGENAnnuite+p6.Annuite;
                        P7.TotGENAnnuite:=P7.TotGENAnnuite+p7.Annuite;
                        P8.TotGENAnnuite:=P8.TotGENAnnuite+p8.Annuite;
                        P9.TotGENAnnuite:=P9.TotGENAnnuite+p9.Annuite;
                        P10.TotGENAnnuite:=P10.TotGENAnnuite+p10.Annuite;
                        P11.TotGENAnnuite:=P11.TotGENAnnuite+p11.Annuite;
                        P12.TotGENAnnuite:=P12.TotGENAnnuite+p12.Annuite;
                        P1.Annuite:=0;
                        P2.Annuite:=0;
                        P3.Annuite:=0;
                        P4.Annuite:=0;
                        P5.Annuite:=0;
                        P6.Annuite:=0;
                        P7.Annuite:=0;
                        P8.Annuite:=0;
                        P9.Annuite:=0;
                        P10.Annuite:=0;
                        P11.Annuite:=0;
                        P12.Annuite:=0;
                         inc(Compteur);


                    if CodeGrTmp<>DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString then
                      begin
                        CodeGrTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
                       ListeValeur.Add('9;TOTAL GROUPE : ');
                       ListeValeur.Add('3;;@;'+E.FormatCurrSansDevise(P1.TotAnnuite)+';'+E.FormatCurrSansDevise(P2.TotAnnuite)+
                       ';'+E.FormatCurrSansDevise(P3.TotAnnuite)+';'+E.FormatCurrSansDevise(P4.TotAnnuite)+';'+E.FormatCurrSansDevise(P5.TotAnnuite)+
                       ';'+E.FormatCurrSansDevise(P6.TotAnnuite)+';'+E.FormatCurrSansDevise(P7.TotAnnuite)+';'+E.FormatCurrSansDevise(P8.TotAnnuite)+
                       ';'+E.FormatCurrSansDevise(P9.TotAnnuite)+';'+E.FormatCurrSansDevise(P10.TotAnnuite)+';'+E.FormatCurrSansDevise(P11.TotAnnuite)+
                       ';'+E.FormatCurrSansDevise(P12.TotAnnuite));
                        ListeValeur.Add('9;GROUPE : '+compteTmp);
                        P1.TotAnnuite:=0;
                        P2.TotAnnuite:=0;
                        P3.TotAnnuite:=0;
                        P4.TotAnnuite:=0;
                        P5.TotAnnuite:=0;
                        P6.TotAnnuite:=0;
                        P7.TotAnnuite:=0;
                        P8.TotAnnuite:=0;
                        P9.TotAnnuite:=0;
                        P10.TotAnnuite:=0;
                        P11.TotAnnuite:=0;
                        P12.TotAnnuite:=0;
                      end;
                  end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
             compteTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
             ListeValeur.Add('9;TOTAL GROUPE : ');
             ListeValeur.Add('3;;@;'+E.FormatCurrSansDevise(P1.TotAnnuite)+';'+E.FormatCurrSansDevise(P2.TotAnnuite)+
             ';'+E.FormatCurrSansDevise(P3.TotAnnuite)+';'+E.FormatCurrSansDevise(P4.TotAnnuite)+';'+E.FormatCurrSansDevise(P5.TotAnnuite)+
             ';'+E.FormatCurrSansDevise(P6.TotAnnuite)+';'+E.FormatCurrSansDevise(P7.TotAnnuite)+';'+E.FormatCurrSansDevise(P8.TotAnnuite)+
             ';'+E.FormatCurrSansDevise(P9.TotAnnuite)+';'+E.FormatCurrSansDevise(P10.TotAnnuite)+';'+E.FormatCurrSansDevise(P11.TotAnnuite)+
             ';'+E.FormatCurrSansDevise(P12.TotAnnuite));
             ListeValeur.Add('8;Nombre total d''Emprunts : '+ inttostr(Compteur));
             ListeValeur.Add('9;TOTAL TRESORERIE : ');
             ListeValeur.Add('1;;@;'+E.FormatCurrSansDevise(P1.TotGENAnnuite)+';'+E.FormatCurrSansDevise(P2.TotGENAnnuite)+
             ';'+E.FormatCurrSansDevise(P3.TotGENAnnuite)+';'+E.FormatCurrSansDevise(P4.TotGENAnnuite)+';'+E.FormatCurrSansDevise(P5.TotGENAnnuite)+
             ';'+E.FormatCurrSansDevise(P6.TotGENAnnuite)+';'+E.FormatCurrSansDevise(P7.TotGENAnnuite)+';'+E.FormatCurrSansDevise(P8.TotGENAnnuite)+
             ';'+E.FormatCurrSansDevise(P9.TotGENAnnuite)+';'+E.FormatCurrSansDevise(P10.TotGENAnnuite)+';'+E.FormatCurrSansDevise(P11.TotGENAnnuite)+
             ';'+E.FormatCurrSansDevise(P12.TotGENAnnuite));
             if(tri=Codeemp)then
               ObjPrn.FTitreEdition := 'TABLEAUX MENSUEL DE TRESORERIE - Tri par code emprunt'
             else
               ObjPrn.FTitreEdition := 'TABLEAUX MENSUEL DE TRESORERIE - Tri par date de réalisation';
//             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

             ObjPrn.Orientation:=poLandscape;

             ListeValeur.Insert(0,' Description de l''Emprunt ; D. réal. ; '+P1.MoisAnnee+' ; '+P2.MoisAnnee+' ; '+P3.MoisAnnee+' ; '+P4.MoisAnnee+' ; '+P5.MoisAnnee+' ; '+P6.MoisAnnee+' ; '+
             P7.MoisAnnee+' ; '+P8.MoisAnnee+' ; '+P9.MoisAnnee+' ; '+P10.MoisAnnee+' ; '+P11.MoisAnnee+' ; '+P12.MoisAnnee+'  ');
             ListeValeur.Insert(1,'2.1;0.5;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7;0.7');
             ListeValeur.Insert(2,'texte;texte;Curr;Curr;Curr;Curr;Curr;curr;curr;curr;curr;curr;curr;curr');
          end;
          ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;



Function EditionEmpruntTresorerieL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:string;DataSet:TDataSet;tri:TTri):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (CodeGr)then
     begin
       Maliste.Add(CodeGr);
     end
   else
     raise ExceptLGR.Create('Aucun groupe n''est defini !',1000,true,mtError,Retour);
   EditionEmpruntTresorerieL(TypeEdition,DemandePeriode,Maliste,DataSet,tri);
  except
     abort;
  end;
end;


Function EditionEmpruntMouvExerciceL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet;Relance:boolean):TStringList;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
listeEdition:TStringList;
CodeGrTmp,Periodicite,DateFin:string;
CapitalDu,CapitalRetard,Emprunte,Rembourse,Echu,NonEchu,Frais,Interets:currency;
TotCapitalDu,TotCapitalRetard,TotEmprunte,TotRembourse,TotEchu,TotNonEchu,TotFrais,TotInterets:currency;
TotGENCapitalDu,TotGENCapitalRetard,TotGENEmprunte,TotGENRembourse,TotGENEchu,TotGENNonEchu,TotGENFrais,TotGENInterets:currency;
TitreCompte:string;
Compteur:integer;
ParamAffichPeriode:TParamAffichPeriode;
DatePremiereEch:Tdate;
GroupeAffiche:boolean;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
GroupeAffiche:=false;
CapitalDu:=0;
CapitalRetard:=0;
Emprunte:=0;
Rembourse:=0;
Echu:=0;
NonEchu:=0;
Frais:=0;
Interets:=0;
TotCapitalDu:=0;
TotCapitalRetard:=0;
TotEmprunte:=0;
TotRembourse:=0;
TotEchu:=0;
TotNonEchu:=0;
TotFrais:=0;
TotInterets:=0;
TotGENCapitalDu:=0;
TotGENCapitalRetard:=0;
TotGENEmprunte:=0;
TotGENRembourse:=0;
TotGENEchu:=0;
TotGENNonEchu:=0;
TotGENFrais:=0;
TotGENInterets:=0;

  if ((DemandePeriode)and(not relance)) then
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
    DeFiltrageDataSet(DMRech.TaEmpruntsRech);
    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;

    if DMEmprunts =nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
    if DMRech = nil then DMRech := TDMRech.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMEmprunts.ListeFilterRecordEmprunt.clear;
        if CodeGr<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du groupe :'+CodeGr.Strings[0]+' au groupe :'+CodeGr.Strings[CodeGr.count-1];
          DMEmprunts.ListeFilterRecordEmprunt.Assign(CodeGr);
          DMEmprunts.QuEmprunt_EditionMouvement.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionMouvementFilterRecord;
          DMEmprunts.QuEmprunt_EditionMouvement.filtered:=true;
          DMEmprunts.QuEmpruntSansEchDansAnnee.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionMouvementFilterRecord;
          DMEmprunts.QuEmpruntSansEchDansAnnee.filtered:=true;
         end
        else
          begin
            DMEmprunts.QuEmprunt_EditionMouvement.OnFilterRecord:=nil;
            DMEmprunts.QuEmpruntSansEchDansAnnee.OnFilterRecord:=nil;
            Titrecompte:=' Tous les groupes ';
          end;
          DMEmprunts.QuEmprunt_EditionMouvement.Close;
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Clear;
//          {isa le 25/09/2007}
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' select CapiResteDu_emp,CodeGr,Code_Emp,Ech.id_emp,Designation_Emp,Min(ech.capital_restant_du)as nonEchu ,');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' sum(interets+Assurances+Frais_divers) as Frais,sum(Interets)as interets,(CapiTotal_emp) as Depart,');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' CapiTotal_emp,DateRealisation,P1,PP1,Min(ech."date")as PremiereDate,Banque from emprunts Emp');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' join EchEmp Ech on (Emp.id=ech.id_emp)');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' where (Ech."Date"  between :DateDeb and :DateFin)');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' group by CapiResteDu_emp,CodeGr,Code_Emp,ech.id_emp,Designation_Emp,CapiTotal_emp,DateRealisation,P1,PP1,Banque');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' order by CodeGr,code_emp');
//        {isa le 25/09/2007}
          DMEmprunts.QuEmprunt_EditionMouvement.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMEmprunts.QuEmprunt_EditionMouvement.ParamByName('DateFin').AsDate := Periode.DateFin;
          //
          DMEmprunts.QuCapitalRestantAvantExo.Close;
          DMEmprunts.QuCapitalRestantAvantExo.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRestantAvantExo.Open;

          DMEmprunts.QuCapitalRembourseAvantExo.close;
          DMEmprunts.QuCapitalRembourseAvantExo.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRembourseAvantExo.Open;

          DMEmprunts.QuCapitalRestantApresExo.close;
          DMEmprunts.QuCapitalRestantApresExo.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
          DMEmprunts.QuCapitalRestantApresExo.Open;

//          DMEmprunts.QuEmpruntInteret.Close;
//          DMEmprunts.QuEmpruntInteret.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
//          DMEmprunts.QuEmpruntInteret.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
//          DMEmprunts.QuEmpruntInteret.open;

          DMEmprunts.QuEmpruntSansEchDansAnnee.Close;
          DMEmprunts.QuEmpruntSansEchDansAnnee.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuEmpruntSansEchDansAnnee.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
          DMEmprunts.QuEmpruntSansEchDansAnnee.open;
          DMEmprunts.QuEmpruntSansEchDansAnnee.first;

          DMEmprunts.QuCapitalRembourseApresExo.close;
          DMEmprunts.QuCapitalRembourseApresExo.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRembourseApresExo.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
          DMEmprunts.QuCapitalRembourseApresExo.Open;
          //
          DMEmprunts.QuEmprunt_EditionMouvement.Open;
          DMEmprunts.QuEmprunt_EditionMouvement.First;
          Compteur:=0;
          DMEmprunts.QuDistinctEmprunts.close;
          DMEmprunts.QuDistinctEmprunts.sql.clear;
          DMEmprunts.QuDistinctEmprunts.sql.add('select distinct * from emprunts Emp');
//          DMEmprunts.QuDistinctEmprunts.sql.add(' where actif=true and (DateRealisation <:DateFin or ');
          DMEmprunts.QuDistinctEmprunts.sql.add(' where actif=true and (DateRealisation <=:DateFin or ');  {isa le 25/09/2007}
          DMEmprunts.QuDistinctEmprunts.sql.add(' exists(select * from EchEmp Ech where ech.id_emp=emp.id and Ech."Date"  between :DateDeb and :DateFin))');
          DMEmprunts.QuDistinctEmprunts.sql.add(' order by CodeGR,Code_emp');
          DMEmprunts.QuDistinctEmprunts.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuDistinctEmprunts.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
          DMEmprunts.QuDistinctEmprunts.open;
          DMEmprunts.QuDistinctEmprunts.first;

          if DMEmprunts.QuDistinctEmprunts.recordcount<>0 then
          begin //si il y a des emprunts
          CodeGrTmp:=DMEmprunts.QuDistinctEmprunts.FindField('CodeGr').AsString;
            while not (DMEmprunts.QuDistinctEmprunts.eof)do
             begin// while DMEmprunts.QuDistinctEmprunts.eof
              if DMEmprunts.QuEmprunt_EditionMouvement.locate('id_emp',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]) then
                  begin //travail sur la requete avec echeance
                       with DMEmprunts.QuEmprunt_EditionMouvement do     //FindField('').Ascurrency
                       begin    //DMEmprunts.QuEmprunt_EditionMouvement.
                        if DMEmprunts.QuEmprunt_EditionMouvement.FindField('PremiereDate').AsDateTime<>0 then
                          DatePremiereEch:=DMEmprunts.QuEmprunt_EditionMouvement.FindField('PremiereDate').asdatetime
                        else
                          DatePremiereEch:=DMEmprunts.QuEmprunt_EditionMouvement.FindField('DateRealisation').asdatetime;
//                        if ((DatePremiereEch>periode.DateDeb)and(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantAvantExo').Ascurrency=0)) then

                          //changé le 10/01/2012 voir commentaire du bug 544
//                        if (DMEmprunts.QuEmprunt_EditionMouvement.FindField('DateRealisation').asdatetime>periode.DateDeb) then
//                          CapitalDu:=0
//                        else
//                          if ((DatePremiereEch>periode.DateDeb)and(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantAvantExo').Ascurrency=0)) then
//                            capitalDu:=0
//                            else
//                              begin
//                                  CapitalDu:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantAvantExo').Ascurrency,2);
//                                  if CapitalDu<>0 then
//                                    CapitalRetard:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Depart').Ascurrency-DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantAvantExo').Ascurrency-FindField('RembourseAvantExo').Ascurrency,2);
//                              end;
                        //changé le 10/01/2012 voir commentaire du bug 544
                        {isa le 10/01/2012}
                        CapitalDu:=0;
                        CapitalRetard:=0;
                        if (DMEmprunts.QuEmprunt_EditionMouvement.FindField('DateRealisation').asdatetime<=periode.DateDeb) then
                          begin
                          if ((DatePremiereEch<=periode.DateDeb)or(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantAvantExo').Ascurrency<>0)) then
                              begin
                                  CapitalDu:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantAvantExo').Ascurrency,2);
                                  if CapitalDu<>0 then
                                    CapitalRetard:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Depart').Ascurrency-DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantAvantExo').Ascurrency-FindField('RembourseAvantExo').Ascurrency,2);
                              end
                              else
                              begin
                                 CapitalDu:=DMEmprunts.QuEmprunt_EditionMouvement.FindField('Depart').Ascurrency;
                              end;
                           end;
                        {isa le 10/01/2012}   
                        if DateDsIntervale(periode.DateDeb,DMEmprunts.QuEmprunt_EditionMouvement.FindField('DateRealisation').Ascurrency,periode.Datefin)then
                          begin
                            Emprunte:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapiTotal_Emp').Ascurrency,2);
                          end
                        else
                            if ((DateDsIntervale(e.DatExoDebut,DMEmprunts.QuEmprunt_EditionMouvement.FindField('DateRealisation').Ascurrency,e.DatExofin))and(CapitalDu=0))then
                              CapitalDu:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapiTotal_Emp').Ascurrency,2);
                        Rembourse:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('RembourseApresExo').Ascurrency,2);
                        NonEchu:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantApresExo').Ascurrency,2);
                        Echu:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Depart').Ascurrency-DMEmprunts.QuEmprunt_EditionMouvement.FindField('RembourseAvantExo').Ascurrency-DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantApresExo').Ascurrency-DMEmprunts.QuEmprunt_EditionMouvement.FindField('RembourseApresExo').Ascurrency,2);
                        Frais:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Frais').Ascurrency,2);
                        Interets:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('interetsCourus').Ascurrency,2);
                        datefin:=DateInfos(DMEmprunts.QuEmprunt_EditionMouvement.FindField('dateFin').AsDateTime).AnStr;
                        if(Rembourse<>0) or (NonEchu<>0) or (Echu<>0) or (Frais<>0) or (Interets<>0)  or               //or (CapitalDu<>0) //changé le 10/01/2012 voir commentaire du bug 544
                        (CapitalRetard<>0) or (Emprunte<>0) then
                        begin
                             if (not GroupeAffiche) then
                             begin
                               GroupeAffiche:=true;
                               ListeValeur.Add('9; GROUPE : '+CodeGrTmp);
                             end;
                            Periodicite:='';
                            if DMRech.TaEmpruntsRech.locate('id',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]) then
                              Periodicite:=DMRech.TaEmpruntsRech.findfield('PeriodeRb').AsString[1];
                             ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle(CodeGrTmp)+' '+GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Code_emp').AsString)+
                                         ';'+
                                         GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Designation_emp').AsString)+
                                         ';'+
                                         GereLibelle(Periodicite)+
                                         ';'+
                                         GereLibelle(DateInfos(DMEmprunts.QuEmprunt_EditionMouvement.FindField('DateRealisation').AsDateTime,true).DateStr)+
                                         ';'+
                                         GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('P1').AsString)+
                                         ';'+
                                         GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('PP1').AsString)+
                                         ';'+
                                         currtostr(CapitalDu)+
                                         ';'+
                                         currtostr(CapitalRetard)+
                                         ';'+
                                         currtostr(Emprunte)+
                                         ';'+
                                         currtostr(Rembourse)+
                                         ';'+
                                         currtostr(Echu)+
                                         ';'+
                                         currtostr(NonEchu)+
                                         ';'+
                                         currtostr(Frais)+
                                         ';'+
                                         currtostr(Interets)+
                                         ';'+
                                         datefin
                                         );
                                         Inc(compteur);
                       end//si une des valeur est <>0
                       else CapitalDu:=0;
                       end;//fin du with
                  end//fin du travail sur la requete avec echeance
              else
              if DMEmprunts.QuEmpruntSansEchDansAnnee.locate('id_emp',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]) then
                  begin //travail sur la requete sans échéance
                       with DMEmprunts.QuEmpruntSansEchDansAnnee do     //FindField('').Ascurrency
                       begin
                        CapitalDu:=0;
                        DatePremiereEch:=FindField('PremiereDate').asdatetime;
                        //if (FindField('PremiereDate').asdatetime<=periode.DateDeb) then

//changé le 10/01/2012 voir commentaire du bug 544
//                        if (FindField('DateRealisation').asdatetime<=periode.DateDeb) then {isa le 25/09/2007}
//                             CapitalDu:=arrondi(FindField('CapitalRestantAvantExo').Ascurrency,2);
//changé le 10/01/2012 voir commentaire du bug 544
                        if (FindField('DateRealisation').asdatetime<=periode.DateDeb) then {isa le 10/01/2012}
                          begin
                            if(FindField('CapitalRestantAvantExo').Ascurrency<>0)then CapitalDu:=arrondi(FindField('CapitalRestantAvantExo').Ascurrency,2)
                            else CapitalDu:= arrondi(FindField('CapiTotal_Emp').Ascurrency,2);
                          end;
                        if DateDsIntervale(periode.DateDeb,FindField('DateRealisation').asdatetime,periode.Datefin) then
                          Emprunte:=arrondi(FindField('CapiTotal_Emp').Ascurrency,2);
                        if DatePremiereEch>periode.Datedeb then//si premiere echeance > à période
                          begin
                            NonEchu:=arrondi(FindField('CapiTotal_Emp').Ascurrency,2);
                          end
                        else
                          begin
                            NonEchu:=arrondi(FindField('CapitalRestantAvantExo').Ascurrency,2);
                            Echu:=arrondi(FindField('CapiTotal_Emp').Ascurrency-FindField('RembourseAvantExo').Ascurrency,2);
                            CapitalRetard:=arrondi(FindField('CapiTotal_Emp').Ascurrency-FindField('CapitalRestantAvantExo').Ascurrency-FindField('RembourseAvantExo').Ascurrency,2);
                          end;
                        Interets:=arrondi(FindField('interetsCourus').Ascurrency,2);
                        if(Rembourse<>0) or (NonEchu<>0) or (Echu<>0) or (Frais<>0) or (Interets<>0)  or           //or (CapitalDu<>0) //changé le 10/01/2012 voir commentaire du bug 544
                        (CapitalRetard<>0) or (Emprunte<>0) then
                        begin
                             if (not GroupeAffiche) then
                             begin
                               GroupeAffiche:=true;
                               ListeValeur.Add('9; GROUPE : '+CodeGrTmp);
                             end;
                       Periodicite:='';
                       if DMRech.TaEmpruntsRech.locate('id',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]) then
                          Periodicite:=DMRech.TaEmpruntsRech.findfield('PeriodeRb').AsString[1];
                       datefin:=DateInfos(DMEmprunts.QuEmpruntSansEchDansAnnee.FindField('dateFin').AsDateTime).AnStr;
                        ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle(CodeGrTmp)+' '+GereLibelle(FindField('Code_emp').AsString)+
                                         ';'+
                                         GereLibelle(FindField('Designation_emp').AsString)+
                                         ';'+
                                         GereLibelle(Periodicite)+
                                         ';'+
                                         GereLibelle(DateInfos(FindField('DateRealisation').AsDateTime,true).DateStr)+
                                         ';'+
                                         GereLibelle(FindField('P1').AsString)+
                                         ';'+
                                         GereLibelle(FindField('PP1').AsString)+
                                         ';'+
                                         currtostr(CapitalDu)+
                                         ';'+
                                         currtostr(CapitalRetard)+
                                         ';'+
                                         currtostr(Emprunte)+
                                         ';'+
                                         currtostr(Rembourse)+
                                         ';'+
                                         currtostr(Echu)+
                                         ';'+
                                         currtostr(NonEchu)+
                                         ';'+
                                         currtostr(Frais)+
                                         ';'+
                                         currtostr(Interets)+
                                         ';'+
                                         DateFin
                                         );
                                         inc(compteur);
                       end//si valeur <>0
                       else CapitalDu:=0;

                       end;//fin du with
                  end;//fin du travail sur la requete sans échéance
                          TotCapitalDu:=TotCapitalDu+CapitalDu;
                          TotCapitalRetard:=TotCapitalRetard+CapitalRetard;
                          TotEmprunte:=TotEmprunte+Emprunte;
                          TotRembourse:=TotRembourse+Rembourse;
                          TotEchu:=TotEchu+Echu;
                          TotNonEchu:=TotNonEchu+NonEchu;
                          TotFrais:=TotFrais+Frais;
                          TotInterets:=TotInterets+Interets;

                          TotGENCapitalDu:=TotGENCapitalDu+CapitalDu;
                          TotGENCapitalRetard:=TotGENCapitalRetard+CapitalRetard;
                          TotGENEmprunte:=TotGENEmprunte+Emprunte;
                          TotGENRembourse:=TotGENRembourse+Rembourse;
                          TotGENEchu:=TotGENEchu+Echu;
                          TotGENNonEchu:=TotGENNonEchu+NonEchu;
                          TotGENFrais:=TotGENFrais+Frais;
                          TotGENInterets:=TotGENInterets+Interets;

                          CapitalDu:=0;
                          CapitalRetard:=0;
                          Emprunte:=0;
                          Rembourse:=0;
                          Echu:=0;
                          NonEchu:=0;
                          Frais:=0;
                          Interets:=0;
                          Periodicite:='';
                          //inc(Compteur);
               DMEmprunts.QuDistinctEmprunts.Next;

                    if CodeGrTmp<>DMEmprunts.QuDistinctEmprunts.FindField('CodeGr').AsString then
                      begin
                       if (TotCapitalDu<>0) or (TotCapitalRetard<>0)or (TotEmprunte<>0)or (TotRembourse<>0)
                       or (TotEchu<>0) or (TotNonEchu<>0)or (TotFrais<>0)or (TotInterets<>0)then
                         ListeValeur.Add('3;;;;;; @TOTAL GROUPE '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapitalDu)+';'+E.FormatCurrSansDevise(TotCapitalRetard)+
                       ';'+E.FormatCurrSansDevise(TotEmprunte)+';'+E.FormatCurrSansDevise(TotRembourse)+';'+E.FormatCurrSansDevise(TotEchu)+
                       ';'+E.FormatCurrSansDevise(TotNonEchu)+';'+E.FormatCurrSansDevise(TotFrais)+';'+E.FormatCurrSansDevise(TotInterets));
                       CodeGrTmp:=DMEmprunts.QuDistinctEmprunts.FindField('CodeGr').AsString;
                       GroupeAffiche:=false;
//                        ListeValeur.Add('9; GROUPE : '+CodeGrTmp);
                          TotCapitalDu:=0;
                          TotCapitalRetard:=0;
                          TotEmprunte:=0;
                          TotRembourse:=0;
                          TotEchu:=0;
                          TotNonEchu:=0;
                          TotFrais:=0;
                          TotInterets:=0;
                      end;
             end;//fin du while DMEmprunts.QuDistinctEmprunts.eof
             if (TotCapitalDu<>0) or (TotCapitalRetard<>0)or (TotEmprunte<>0)or (TotRembourse<>0)
             or (TotEchu<>0) or (TotNonEchu<>0)or (TotFrais<>0)or (TotInterets<>0)then
                ListeValeur.Add('3;;;;;; @TOTAL GROUPE '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapitalDu)+';'+E.FormatCurrSansDevise(TotCapitalRetard)+
             ';'+E.FormatCurrSansDevise(TotEmprunte)+';'+E.FormatCurrSansDevise(TotRembourse)+';'+E.FormatCurrSansDevise(TotEchu)+
             ';'+E.FormatCurrSansDevise(TotNonEchu)+';'+E.FormatCurrSansDevise(TotFrais)+';'+E.FormatCurrSansDevise(TotInterets));
             CodeGrTmp:=DMEmprunts.QuDistinctEmprunts.FindField('CodeGr').AsString;
             ListeValeur.Add('8;Nombre total d''Emprunts : '+ inttostr(Compteur));
             ListeValeur.Add('3;;;;;; @TOTAL GENERAL : ;'+E.FormatCurrSansDevise(TotGENCapitalDu)+';'+E.FormatCurrSansDevise(TotGENCapitalRetard)+
             ';'+E.FormatCurrSansDevise(TotGENEmprunte)+';'+E.FormatCurrSansDevise(TotGENRembourse)+';'+E.FormatCurrSansDevise(TotGENEchu)+
             ';'+E.FormatCurrSansDevise(TotGENNonEchu)+';'+E.FormatCurrSansDevise(TotGENFrais)+';'+E.FormatCurrSansDevise(TotGENInterets));
             ListeEdition.Add('8B1VS;Compte;Débit;Crédit');
             ListeEdition.Add('8B1VS;Tous;'+CurrToStr_Lgr(TotGENEmprunte)+';0');
             ListeEdition.Add('8B1VT;Compte;Débit;Crédit');
             ListeEdition.Add('8B1VT;Tous;'+CurrToStr_Lgr(TotGENRembourse)+';0');
             ObjPrn.FTitreEdition := ' MOUVEMENTS DE L''EXERCICE';
//             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

             ObjPrn.Orientation:=poLandscape;

             ListeValeur.Insert(0,' Code ; Désignation; P ; Date ; Durée ; Taux ; '+DateInfos(Periode.DateDeb).DateStr+'; En Retard ; Emprunté ; Remboursé ; échu(retard) ; non échu ; de l''exer. ;  courus ; fin');
             ListeValeur.Insert(1,'1;1.75;0.2;0.5;0.50;0.40;0.75;0.75;0.75;0.75;0.75;0.75;0.75;0.75;0.5');
             ListeValeur.Insert(2,'texte;texte;texte;texte;Curr;Curr;Curr;Curr;Curr;Curr;Curr;Curr;Curr;Curr;texte');

             ListeValeur.Insert(3,' Emprunt ; Capital dû; Capital ; Mouvements de capital ; Capital dû le '+DateInfos(Periode.DateFin).DateStr+' ; F.Financier ; Interêts ; Année;SURTITRE');
             ListeValeur.Insert(4,'4.35;0.75;0.75;1.5;1.5;0.75;0.75;0.5');

          end;//fin si il y a des emprunts
          if(relance)then
            result:=ListeEdition
          else
          ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
          DMEmprunts.QuDistinctEmprunts.close;
          DMEmprunts.QuDistinctEmprunts.sql.clear;
          DMEmprunts.QuDistinctEmprunts.sql.add('select distinct * from emprunts Emp');
          DMEmprunts.QuDistinctEmprunts.sql.add(' where actif=true ');
          DMEmprunts.QuDistinctEmprunts.sql.add(' order by CodeGR,Code_emp');
     LibereObjet(Tobject(ObjPrn));
     //ListeEdition.Free;
//   ObjPrn.destroy;
end;
end;



Function EditionEmpruntMouvExerciceL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:string;DataSet:TDataSet;Relance:boolean):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (CodeGr)then
     begin
       Maliste.Add(CodeGr);
     end
   else
     raise ExceptLGR.Create('Aucun groupe n''est defini !',1000,true,mtError,Retour);
   EditionEmpruntMouvExerciceL(TypeEdition,DemandePeriode,Maliste,DataSet,Relance);
  except
     abort;
  end;
end;


Function EditionEmpruntMouvExerciceEtAnnuiteL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet;Relance:boolean):TStringList;
var
periode_1,periode_2:TPeriode;
Periode1,Periode2,Periode3:currency;
TotPeriode1,TotPeriode2,TotPeriode3:currency;
TotGENPeriode1,TotGENPeriode2,TotGENPeriode3:currency;
TotGEN1643Periode1:currency;
TotGEN1643Periode2:currency;
TotGEN1643Periode3:currency;
TotGEN164Periode1:currency;
TotGEN164Periode2:currency;
TotGEN164Periode3:currency;
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
listeEdition:TStringList;
NumEmprunt:integer;
CodeGrTmp,Periodicite,DateFin:string;
AnneeRealisation:string;
Capital,CapitalRetard,Emprunte,Rembourse,Echu,NonEchu,Frais,Interets:currency;
TotCapital,TotCapitalRetard,TotEmprunte,TotRembourse,TotEchu,TotNonEchu,TotFrais,TotInterets:currency;
TotGENCapital,TotGENCapitalRetard,TotGENEmprunte,TotGENRembourse,TotGENEchu,TotGENNonEchu,TotGENFrais,TotGENInterets:currency;
TitreCompte:string;
Compteur:integer;
ParamAffichPeriode:TParamAffichPeriode;
DatePremiereEch:Tdate;
GroupeAffiche:boolean;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
periode_1.Retour := true;
periode_1.DateDeb := e.DatExoFin+1;
periode_1.DateFin := MoisSuivant(e.DatExoFin,11).Date_;
periode_2.Retour := true;
periode_2.DateDeb := periode_1.DateFin+1;
periode_2.DateFin := MoisSuivant(periode_1.DateFin,47).Date_;
GroupeAffiche:=false;
Capital:=0;
CapitalRetard:=0;
Emprunte:=0;
Rembourse:=0;
Echu:=0;
NonEchu:=0;
Frais:=0;
Interets:=0;
TotCapital:=0;
TotCapitalRetard:=0;
TotEmprunte:=0;
TotRembourse:=0;
TotEchu:=0;
TotNonEchu:=0;
TotFrais:=0;
TotInterets:=0;
TotGENCapital:=0;
TotGENCapitalRetard:=0;
TotGENEmprunte:=0;
TotGENRembourse:=0;
TotGENEchu:=0;
TotGENNonEchu:=0;
TotGENFrais:=0;
TotGENInterets:=0;

  if ((DemandePeriode)and(not relance)) then
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

    if DMEmprunts =nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
    if DMRech = nil then DMRech := TDMRech.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMEmprunts.ListeFilterRecordEmprunt.clear;
        if CodeGr<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du groupe :'+CodeGr.Strings[0]+' au groupe :'+CodeGr.Strings[CodeGr.count-1];
          DMEmprunts.ListeFilterRecordEmprunt.Assign(CodeGr);
          DMEmprunts.QuEmprunt_EditionMouvement.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionMouvementFilterRecord;
          DMEmprunts.QuEmprunt_EditionMouvement.filtered:=true;
          DMEmprunts.QuEmpruntSansEchDansAnnee.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionMouvementFilterRecord;
          DMEmprunts.QuEmpruntSansEchDansAnnee.filtered:=true;
         end
        else
          begin
            DMEmprunts.QuEmprunt_EditionMouvement.OnFilterRecord:=nil;
            DMEmprunts.QuEmpruntSansEchDansAnnee.OnFilterRecord:=nil;
            Titrecompte:=' Tous les groupes ';
          end;
          DMEmprunts.QuEmprunt_EditionMouvement.Close;
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Clear;
//          {isa le 25/09/2007}
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' select CapiResteDu_emp,CodeGr,Code_Emp,Ech.id_emp,Designation_Emp,Min(ech.capital_restant_du)as nonEchu ,');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' sum(interets+Assurances+Frais_divers) as Frais,sum(Interets)as interets,(CapiTotal_emp) as Depart,');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' CapiTotal_emp,DateRealisation,P1,PP1,Min(ech."date")as PremiereDate,Banque from emprunts Emp');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' join EchEmp Ech on (Emp.id=ech.id_emp)');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' where (Ech."Date"  between :DateDeb and :DateFin)');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' group by CapiResteDu_emp,CodeGr,Code_Emp,ech.id_emp,Designation_Emp,CapiTotal_emp,DateRealisation,P1,PP1,Banque');
          DMEmprunts.QuEmprunt_EditionMouvement.SQL.Add(' order by CodeGr,code_emp');
//        {isa le 25/09/2007}
          DMEmprunts.QuEmprunt_EditionMouvement.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMEmprunts.QuEmprunt_EditionMouvement.ParamByName('DateFin').AsDate := Periode.DateFin;
          //
          DMEmprunts.QuCapitalRestantAvantExo.Close;
          DMEmprunts.QuCapitalRestantAvantExo.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRestantAvantExo.Open;

          DMEmprunts.QuCapitalRembourseAvantExo.close;
          DMEmprunts.QuCapitalRembourseAvantExo.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRembourseAvantExo.Open;

          DMEmprunts.QuCapitalRestantApresExo.close;
          DMEmprunts.QuCapitalRestantApresExo.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
          DMEmprunts.QuCapitalRestantApresExo.Open;

          
//          DMEmprunts.QuEmpruntInteret.Close;
//          DMEmprunts.QuEmpruntInteret.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
//          DMEmprunts.QuEmpruntInteret.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
//          DMEmprunts.QuEmpruntInteret.open;

          DMEmprunts.QuEmpruntSansEchDansAnnee.Close;
          DMEmprunts.QuEmpruntSansEchDansAnnee.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuEmpruntSansEchDansAnnee.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
          DMEmprunts.QuEmpruntSansEchDansAnnee.open;
          DMEmprunts.QuEmpruntSansEchDansAnnee.first;

          DMEmprunts.QuCapitalRembourseApresExo.close;
          DMEmprunts.QuCapitalRembourseApresExo.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRembourseApresExo.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
          DMEmprunts.QuCapitalRembourseApresExo.Open;

          if CodeGr<>nil then
         begin
          DMEmprunts.QuEmprunt_Edition.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionMouvementFilterRecord;
          DMEmprunts.QuEmprunt_Edition.filtered:=true;
         end
        else
          begin
            DMEmprunts.QuEmprunt_Edition.OnFilterRecord:=nil;
          end;     
               DMEmprunts.QuEmprunt_Edition.Close;
          DMEmprunts.QuEmprunt_Edition.sql.clear;

          DMEmprunts.QuEmprunt_Edition.sql.add('select CodeGr,id,Compte_Emp, Code_Emp,Designation_emp,Ech."Date",Annuite,capital,PP1,(P1+P2+P3)as Duree,CapiTotal_Emp,Banque,DateRealisation from emprunts Emp');
          DMEmprunts.QuEmprunt_Edition.sql.add('join EchEmp Ech on (Emp.id=ech.id_emp)');
          DMEmprunts.QuEmprunt_Edition.sql.add('where Ech."Date" >= :DateDeb ');
          DMEmprunts.QuEmprunt_Edition.sql.add('order by CodeGr,code_emp,Compte_Emp,ech."date"');

          DMEmprunts.QuEmprunt_Edition.ParamByName('DateDeb').AsDate := periode_1.DateDeb;

          DMEmprunts.QuCapitalRestantAvantExo2.Close;
          DMEmprunts.QuCapitalRestantAvantExo2.ParamByName('DateDeb').AsDate:=periode_1.DateDeb;
          DMEmprunts.QuCapitalRestantAvantExo2.Open;

          DMEmprunts.QuCapitalRestantAvantExoSansEcheance.Close;
          DMEmprunts.QuCapitalRestantAvantExoSansEcheance.ParamByName('DateDeb').AsDate:=periode_1.DateDeb;
          DMEmprunts.QuCapitalRestantAvantExoSansEcheance.Open;

          DMEmprunts.QuEmprunt_Edition.Open;
          DMEmprunts.QuEmprunt_Edition.First;

          DMEmprunts.QuEmprunt_EditionMouvement.Open;
          DMEmprunts.QuEmprunt_EditionMouvement.First;
          Compteur:=0;
          DMEmprunts.QuDistinctEmprunts.close;
          DMEmprunts.QuDistinctEmprunts.sql.clear;
          DMEmprunts.QuDistinctEmprunts.sql.add('select distinct * from emprunts Emp');
//          DMEmprunts.QuDistinctEmprunts.sql.add(' where actif=true and (DateRealisation <:DateFin or ');
          DMEmprunts.QuDistinctEmprunts.sql.add(' where actif=true and (DateRealisation <=:DateFin or ');  {isa le 25/09/2007}
          DMEmprunts.QuDistinctEmprunts.sql.add(' exists(select * from EchEmp Ech where ech.id_emp=emp.id and Ech."Date"  between :DateDeb and :DateFin))');
          DMEmprunts.QuDistinctEmprunts.sql.add(' order by CodeGR,DateRealisation');
          DMEmprunts.QuDistinctEmprunts.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuDistinctEmprunts.ParamByName('DateFin').AsDate:=DMEmprunts.QuEmprunt_EditionMouvement.Parambyname('DateFin').AsDate;
          DMEmprunts.QuDistinctEmprunts.open;
          DMEmprunts.QuDistinctEmprunts.first;

          if DMEmprunts.QuDistinctEmprunts.recordcount<>0 then
          begin //si il y a des emprunts
          CodeGrTmp:=DMEmprunts.QuDistinctEmprunts.FindField('CodeGr').AsString;
            while not (DMEmprunts.QuDistinctEmprunts.eof)do
             begin// while DMEmprunts.QuDistinctEmprunts.eof
                            Periode1:=0;
                            Periode2:=0;
                            Periode3:=0;
             if(DMEmprunts.QuEmprunt_Edition.Locate('id',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]))then
                        begin
                            NumEmprunt:=DMEmprunts.QuEmprunt_Edition.FindField('id').Asinteger;
                            CompteTmp:=DMEmprunts.QuEmprunt_Edition.FindField('Compte_Emp').AsString;

                            datefin:=DateInfos(DMEmprunts.QuEmprunt_Edition.FindField('dateFin').AsDateTime).AnStr;
                            while ((not DMEmprunts.QuEmprunt_Edition.Eof)and(NumEmprunt=DMEmprunts.QuEmprunt_Edition.FindField('id').Asinteger)) do
                              Begin
                                if DateDsIntervale(periode_1.DateDeb,DMEmprunts.QuEmprunt_Edition. FindField('Date').Asdatetime,periode_1.DateFin)then
                                  Periode1:=Periode1+arrondi(DMEmprunts.QuEmprunt_Edition. FindField('capital').Ascurrency,2)
                                else
                                if DateDsIntervale(periode_2.DateDeb,DMEmprunts.QuEmprunt_Edition. FindField('Date').Asdatetime,periode_2.DateFin)then
                                  Periode2:=Periode2+arrondi(DMEmprunts.QuEmprunt_Edition. FindField('capital').Ascurrency,2)
                                else
                                Periode3:=Periode3+arrondi(DMEmprunts.QuEmprunt_Edition. FindField('capital').Ascurrency,2);
                                DMEmprunts.QuEmprunt_Edition.next;
                              end;

                              TotPeriode1:=TotPeriode1+Periode1;
                              TotPeriode2:=TotPeriode2+Periode2;
                              TotPeriode3:=TotPeriode3+Periode3;

                              TotGENPeriode1:=TotGENPeriode1+Periode1;
                              TotGENPeriode2:=TotGENPeriode2+Periode2;
                              TotGENPeriode3:=TotGENPeriode3+Periode3;
                              if( CompteTmp = '164')then
                                begin
                                  TotGEN164Periode1:=TotGEN164Periode1+Periode1;
                                  TotGEN164Periode2:=TotGEN164Periode2+Periode2;
                                  TotGEN164Periode3:=TotGEN164Periode3+Periode3;
                                end;
                              if( CompteTmp = '1643')then
                                begin
                                  TotGEN1643Periode1:=TotGEN1643Periode1+Periode1;
                                  TotGEN1643Periode2:=TotGEN1643Periode2+Periode2;
                                  TotGEN1643Periode3:=TotGEN1643Periode3+Periode3;
                                end;
                        end;
              if DMEmprunts.QuEmprunt_EditionMouvement.locate('id_emp',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]) then
                  begin //travail sur la requete avec echeance
                       with DMEmprunts.QuEmprunt_EditionMouvement do
                       begin

                        if DMEmprunts.QuEmprunt_EditionMouvement.FindField('PremiereDate').AsDateTime<>0 then
                          DatePremiereEch:=DMEmprunts.QuEmprunt_EditionMouvement.FindField('PremiereDate').asdatetime
                        else
                          DatePremiereEch:=DMEmprunts.QuEmprunt_EditionMouvement.FindField('DateRealisation').asdatetime;

                          Capital:=DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapiTotal_emp').Ascurrency;

                        Rembourse:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('RembourseApresExo').Ascurrency,2);
                        NonEchu:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantApresExo').Ascurrency,2);
                        Echu:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Depart').Ascurrency-DMEmprunts.QuEmprunt_EditionMouvement.FindField('RembourseAvantExo').Ascurrency-DMEmprunts.QuEmprunt_EditionMouvement.FindField('CapitalRestantApresExo').Ascurrency-DMEmprunts.QuEmprunt_EditionMouvement.FindField('RembourseApresExo').Ascurrency,2);
                        Frais:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Frais').Ascurrency,2);
                        Interets:=arrondi(DMEmprunts.QuEmprunt_EditionMouvement.FindField('interetsCourus').Ascurrency,2);
                        if(Rembourse<>0) or (NonEchu<>0) or (Echu<>0) or (Frais<>0) or (Interets<>0) or (Capital<>0) or
                        (CapitalRetard<>0) or (Emprunte<>0) then
                        begin
                             if (not GroupeAffiche) then
                             begin
                               GroupeAffiche:=true;
                               ListeValeur.Add('9; GROUPE : '+CodeGrTmp);
                             end;
                            Periodicite:='';
                            AnneeRealisation:=DateInfos(DMEmprunts.QuEmprunt_EditionMouvement.FindField('DateRealisation').AsDateTime).AnStr;
                            if DMRech.TaEmpruntsRech.locate('id',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]) then
                              Periodicite:=DMRech.TaEmpruntsRech.findfield('PeriodeRb').AsString[1];
                            if( Periodicite='A')then Periodicite:=DateInfos(DatePremiereEch).MoisStr;
                              ListeValeur.Add('-1'+
                                         ';'+
                                         GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Banque').AsString)+' / '+GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Code_emp').AsString)+
                                         ';'+
                                         GereLibelle(AnneeRealisation)+
                                         ';'+
                                         GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('Designation_emp').AsString)+
                                          ';'+
                                         currtostr(Capital)+
                                         ';'+
                                         GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('P1').AsString)+
                                         ';'+
                                         GereLibelle(DMEmprunts.QuEmprunt_EditionMouvement.FindField('PP1').AsString)+
                                         ';'+
                                         GereLibelle(Periodicite)+
                                         ';'+
                                         currtostr(Rembourse)+
                                         ';'+
                                         currtostr(Frais)+
                                         ';'+
                                         currtostr(Rembourse+Frais)+
                                         ';'+
                                         currtostr(Interets)+
                                         ';'+
                                         currtostr(Periode1)+
                                         ';'+
                                         currtostr(Periode2)+
                                         ';'+
                                         currtostr(Periode3)+
                                         ';'+
                                         currtostr(Periode1+Periode2+Periode3)
                                         );
                                         ListeValeur.Add('21');
                                         Inc(compteur);
                       end;//si une des valeur est <>0
                       end;//fin du with
                  end//fin du travail sur la requete avec echeance
              else
              if DMEmprunts.QuEmpruntSansEchDansAnnee.locate('id_emp',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]) then
                  begin //travail sur la requete sans échéance
                       with DMEmprunts.QuEmpruntSansEchDansAnnee do     //FindField('').Ascurrency
                       begin
                        Capital:=0;
                        DatePremiereEch:=FindField('PremiereDate').asdatetime;
                        //if (FindField('PremiereDate').asdatetime<=periode.DateDeb) then
                       if DateDsIntervale(periode.DateDeb,FindField('DateRealisation').asdatetime,periode.Datefin) then
                          Capital:=arrondi(FindField('CapiTotal_emp').Ascurrency,2);
                        if (FindField('DateRealisation').asdatetime<=periode.DateDeb) then {isa le 25/09/2007}
                          Capital:=arrondi(FindField('CapitalRestantAvantExo').Ascurrency,2);
                        if DateDsIntervale(periode.DateDeb,FindField('DateRealisation').asdatetime,periode.Datefin) then
                          Emprunte:=arrondi(FindField('CapiTotal_Emp').Ascurrency,2);
                        if DatePremiereEch>periode.Datedeb then//si premiere echeance > à période
                          begin
                            NonEchu:=arrondi(FindField('CapiTotal_Emp').Ascurrency,2);
                          end
                        else
                          begin
                            NonEchu:=arrondi(FindField('CapitalRestantAvantExo').Ascurrency,2);
                            Echu:=arrondi(FindField('CapiTotal_Emp').Ascurrency-FindField('RembourseAvantExo').Ascurrency,2);
                            CapitalRetard:=arrondi(FindField('CapiTotal_Emp').Ascurrency-FindField('CapitalRestantAvantExo').Ascurrency-FindField('RembourseAvantExo').Ascurrency,2);
                          end;
                        Interets:=arrondi(FindField('interetsCourus').Ascurrency,2);
                        if(Rembourse<>0) or (NonEchu<>0) or (Echu<>0) or (Frais<>0) or (Interets<>0) or (Capital<>0) or
                        (CapitalRetard<>0) or (Emprunte<>0) then
                        begin
                             if (not GroupeAffiche) then
                             begin
                               GroupeAffiche:=true;
                               ListeValeur.Add('9; GROUPE : '+CodeGrTmp);
                             end;
                       Periodicite:='';
                       AnneeRealisation:=DateInfos(FindField('DateRealisation').AsDateTime).AnStr;
                       if DMRech.TaEmpruntsRech.locate('id',DMEmprunts.QuDistinctEmprunts.findfield('id').Asinteger,[]) then
                          Periodicite:=DMRech.TaEmpruntsRech.findfield('PeriodeRb').AsString[1];
                       if( Periodicite='A')then Periodicite:=DateInfos(DatePremiereEch).MoisStr;
                        ListeValeur.Add('-1'+
                                         ';'+
                                         GereLibelle(FindField('Banque').AsString)+' / '+GereLibelle(FindField('Code_emp').AsString)+
                                         ';'+
                                         GereLibelle(AnneeRealisation)+
                                         ';'+
                                         GereLibelle(FindField('Designation_emp').AsString)+
                                          ';'+
                                         currtostr(Capital)+
                                         ';'+
                                         GereLibelle(FindField('P1').AsString)+
                                         ';'+
                                         GereLibelle(FindField('PP1').AsString)+
                                         ';'+
                                         GereLibelle(Periodicite)+
                                         ';'+
                                         currtostr(Rembourse)+
                                         ';'+
                                         currtostr(Frais)+
                                         ';'+
                                         currtostr(Rembourse+Frais)+
                                         ';'+
                                         currtostr(Interets)+
                                         ';'+
                                         currtostr(Periode1)+
                                         ';'+
                                         currtostr(Periode2)+
                                         ';'+
                                         currtostr(Periode3)+
                                         ';'+
                                         currtostr(Periode1+Periode2+Periode3)
                                         );
                                         ListeValeur.Add('21');
                                         inc(compteur);
                       end;//si valeur <>0
                       end;//fin du with
                  end;//fin du travail sur la requete sans échéance
                          TotCapital:=TotCapital+Capital;
                          TotCapitalRetard:=TotCapitalRetard+CapitalRetard;
                          TotEmprunte:=TotEmprunte+Emprunte;
                          TotRembourse:=TotRembourse+Rembourse;
                          TotEchu:=TotEchu+Echu;
                          TotNonEchu:=TotNonEchu+NonEchu;
                          TotFrais:=TotFrais+Frais;
                          TotInterets:=TotInterets+Interets;

                          TotGENCapital:=TotGENCapital+Capital;
                          TotGENCapitalRetard:=TotGENCapitalRetard+CapitalRetard;
                          TotGENEmprunte:=TotGENEmprunte+Emprunte;
                          TotGENRembourse:=TotGENRembourse+Rembourse;
                          TotGENEchu:=TotGENEchu+Echu;
                          TotGENNonEchu:=TotGENNonEchu+NonEchu;
                          TotGENFrais:=TotGENFrais+Frais;
                          TotGENInterets:=TotGENInterets+Interets;

                          Capital:=0;
                          CapitalRetard:=0;
                          Emprunte:=0;
                          Rembourse:=0;
                          Echu:=0;
                          NonEchu:=0;
                          Frais:=0;
                          Interets:=0;
                          Periodicite:='';
                          //inc(Compteur);
               DMEmprunts.QuDistinctEmprunts.Next;

                    if CodeGrTmp<>DMEmprunts.QuDistinctEmprunts.FindField('CodeGr').AsString then
                      begin
                       if (TotCapital<>0) or (TotCapitalRetard<>0)or (TotEmprunte<>0)or (TotRembourse<>0)
                       or (TotEchu<>0) or (TotNonEchu<>0)or (TotFrais<>0)or (TotInterets<>0)then
                       begin
                       //  ListeValeur.Add('21');
                         ListeValeur.Add('3;;;@TOTAL GROUPE '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapital)+';;;;'+E.FormatCurrSansDevise(TotRembourse)+
                       ';'+E.FormatCurrSansDevise(TotFrais)+';'+E.FormatCurrSansDevise(TotRembourse+TotFrais)+';'+E.FormatCurrSansDevise(TotInterets)+
                       ';'+E.FormatCurrSansDevise(TotPeriode1)+';'+E.FormatCurrSansDevise(TotPeriode2)+';'+E.FormatCurrSansDevise(TotPeriode3)+';'+E.FormatCurrSansDevise(TotPeriode1+TotPeriode2+TotPeriode3));
                      // ListeValeur.Add('21');
                       end;
                       CodeGrTmp:=DMEmprunts.QuDistinctEmprunts.FindField('CodeGr').AsString;
                       GroupeAffiche:=false;
//                        ListeValeur.Add('9; GROUPE : '+CodeGrTmp);
                          TotCapital:=0;
                          TotCapitalRetard:=0;
                          TotEmprunte:=0;
                          TotRembourse:=0;
                          TotEchu:=0;
                          TotNonEchu:=0;
                          TotFrais:=0;
                          TotInterets:=0;
                          TotPeriode1:=0;
                          TotPeriode2:=0;
                          TotPeriode3:=0;
                      end;
             end;//fin du while DMEmprunts.QuDistinctEmprunts.eof
             if (TotCapital<>0) or (TotCapitalRetard<>0)or (TotEmprunte<>0)or (TotRembourse<>0)
             or (TotEchu<>0) or (TotNonEchu<>0)or (TotFrais<>0)or (TotInterets<>0)then
             begin
            // ListeValeur.Add('21');
             ListeValeur.Add('3;;; @TOTAL GROUPE '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapital)+';;;;'+E.FormatCurrSansDevise(TotRembourse)+
             ';'+E.FormatCurrSansDevise(TotFrais)+';'+E.FormatCurrSansDevise(TotRembourse+TotFrais)+';'+E.FormatCurrSansDevise(TotInterets)+
             ';'+E.FormatCurrSansDevise(TotPeriode1)+';'+E.FormatCurrSansDevise(TotPeriode2)+';'+E.FormatCurrSansDevise(TotPeriode3)+';'+E.FormatCurrSansDevise(TotPeriode1+TotPeriode2+TotPeriode3));
            // ListeValeur.Add('21');
             end;
             CodeGrTmp:=DMEmprunts.QuDistinctEmprunts.FindField('CodeGr').AsString;
             ListeValeur.Add('8;Nombre total d''Emprunts : '+ inttostr(Compteur));
             ListeValeur.Add('3;;; @TOTAL GENERAL : ;'+E.FormatCurrSansDevise(TotGENCapital)+';;;;'+E.FormatCurrSansDevise(TotGENRembourse)+
             ';'+E.FormatCurrSansDevise(TotGENFrais)+';'+E.FormatCurrSansDevise(TotGENRembourse+TotGENFrais)+';'+E.FormatCurrSansDevise(TotGENInterets)+
             ';'+E.FormatCurrSansDevise(TotGENPeriode1)+';'+E.FormatCurrSansDevise(TotGENPeriode2)+';'+E.FormatCurrSansDevise(TotGENPeriode3)+';'+E.FormatCurrSansDevise(TotGENPeriode1+TotGENPeriode2+TotGENPeriode3));
             ListeEdition.Add('8B1VS;Compte;Débit;Crédit');
             ListeEdition.Add('8B1VS;Tous;'+CurrToStr_Lgr(TotGENEmprunte)+';0');
             ListeEdition.Add('8B1VT;Compte;Débit;Crédit');
             ListeEdition.Add('8B1VT;Tous;'+CurrToStr_Lgr(TotGENRembourse)+';0');
             ObjPrn.FTitreEdition := ' TABLEAU DES EMPRUNTS ';
//             ObjPrn.FSousTitreEdition:=SousTitre;
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;

             ObjPrn.Orientation:=poLandscape;

             ListeValeur.Insert(0,' / N° ; ; Destination ; Capital ; Durée ; Taux ; Mois ; Capital ; Intérêts ; Annuité ; 168 - 518 ; à - 1an ; de 1 à 5ans ; à +5ans ; Total ');
             ListeValeur.Insert(1,'1;0.3;1.40;0.75;0.50;0.50;0.40;0.75;0.75;0.75;0.75;0.75;0.75;0.75;0.75');
             ListeValeur.Insert(2,'texte;texte;texte;Curr;Curr;Curr;textecenter;Curr;Curr;Curr;Curr;Curr;Curr;Curr;Curr');

             ListeValeur.Insert(3,' Organismes ; An. ; Caractéristiques ; Remboursement exercice '+e.NomExo+' ; Int. Courus ; Capital restant dû ;SURTITRE');
             ListeValeur.Insert(4,'1;0.3;3.15;2.65;0.75;3');

          end;//fin si il y a des emprunts
          if(relance)then
            result:=ListeEdition
          else
          ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
          DMEmprunts.QuDistinctEmprunts.close;
          DMEmprunts.QuDistinctEmprunts.sql.clear;
          DMEmprunts.QuDistinctEmprunts.sql.add('select distinct * from emprunts Emp');
          DMEmprunts.QuDistinctEmprunts.sql.add(' where actif=true ');
          DMEmprunts.QuDistinctEmprunts.sql.add(' order by CodeGR,Code_emp');
     LibereObjet(Tobject(ObjPrn));
     //ListeEdition.Free;
//   ObjPrn.destroy;
end;
end;

Function EditionEmpruntMouvExerciceEtAnnuiteL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:string;DataSet:TDataSet;Relance:boolean):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (CodeGr)then
     begin
       Maliste.Add(CodeGr);
     end
   else
     raise ExceptLGR.Create('Aucun groupe n''est defini !',1000,true,mtError,Retour);
   EditionEmpruntMouvExerciceEtAnnuiteL(TypeEdition,DemandePeriode,Maliste,DataSet,Relance);
  except
     abort;
  end;
end;

procedure TDMEmprunts.QuEmprunt_EditionMouvementFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListeFilterRecordEmprunt.IndexOf(DataSet.FindField('codeGr').AsString) <> -1;
  end;

end;


procedure TDMEmprunts.QuEmprunt_EditionOuvertureFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListeFilterRecordEmprunt.IndexOf(DataSet.FindField('compte_emp').AsString) <> -1;
  end;

end;
procedure TDMEmprunts.QuEmprunt_EditionMouvementCalcFields(
  DataSet: TDataSet);
var
NbJour,base:real;
DateProchaine:Tdate;
begin
QuProchaineDateEch.Close;
QuProchaineDateEch.ParamByName('DateFin').AsDate:=e.DatExoFin;
QuProchaineDateEch.ParamByName('id').asinteger:=QuEmprunt_EditionMouvementid_emp.AsInteger;
QuProchaineDateEch.open;
if ((QuProchaineDateEch.RecordCount<>0)and(QuProchaineDateEch.findfield('ProchaineDate').AsDateTime<>0)) then
  DateProchaine:=QuProchaineDateEch.findfield('ProchaineDate').AsDateTime
else
  DateProchaine:=e.DatExoFin;


QuEmpruntInteret.Close;
QuEmpruntInteret.ParamByName('DateDeb').AsDate:=QuEmprunt_EditionMouvementDerniereDateEch.AsDateTime+1;
QuEmpruntInteret.ParamByName('id').asinteger:=QuEmprunt_EditionMouvementid_emp.AsInteger;
QuEmpruntInteret.ParamByName('DateFin').AsDate:=DateProchaine;
QuEmpruntInteret.open;

QuEmpruntInteret_Anterieur.Close;
QuEmpruntInteret_Anterieur.ParamByName('DateDeb_ant').AsDate:=e.DatExoDebut;
QuEmpruntInteret_Anterieur.ParamByName('id').asinteger:=QuEmprunt_EditionMouvementid_emp.AsInteger;
QuEmpruntInteret_Anterieur.ParamByName('DateFin_ant').AsDate:=QuEmprunt_EditionMouvementDerniereDateEch.AsDateTime;
QuEmpruntInteret_Anterieur.open;


if ((QuEmpruntInteret.RecordCount<>0)and(QuEmpruntInteret.FindField('Interets').AsCurrency<>0)and(QuEmprunt_EditionMouvementDerniereDateEch.AsDateTime+1<e.DatExoFin)) then
  begin
  if ((QuEmprunt_EditionMouvement.Params[0].AsDate=e.DatExoDebut) and (QuEmprunt_EditionMouvement.Params[1].AsDate=e.DatExoFin))then
    Begin //on ne calcul l'interet courus que si les dates passées en paramètres correspondent exactement aux
    //dates de l'exercice "les bornes"
        if e.DatExoFin+1=dateprochaine then
          NbJour:=0
        else
          NbJour:=NbDeJours(QuEmprunt_EditionMouvementDerniereDateEch.AsDateTime+1,e.DatExoFin);
      base:=NbDeJours(QuEmprunt_EditionMouvementDerniereDateEch.AsDateTime+1,dateprochaine);
      if NbJour=0 then
        QuEmprunt_EditionMouvementInteretsCourus.AsCurrency:=QuEmpruntInteret.FindField('Interets').AsCurrency
      else
        QuEmprunt_EditionMouvementInteretsCourus.AsCurrency:=(QuEmpruntInteret.FindField('Interets').AsCurrency*NbJour/base);
    end;
  end;
//////
QuEmpruntInteret_Anterieur.First;
while not QuEmpruntInteret_Anterieur.eof do
  begin
    if QuEmpruntInteret_Anterieur.FindField('interets').AsCurrency<>0 then
      begin//si interêt <>0
      if ((QuEmprunt_EditionMouvement.Params[0].AsDate=e.DatExoDebut) and (QuEmprunt_EditionMouvement.Params[1].AsDate=e.DatExoFin))then
        Begin //on ne calcul l'interet courus que si les dates passées en paramètres correspondent exactement aux
        //dates de l'exercice "les bornes"
            if QuEmpruntInteret_Anterieur.FindField('Date_ant').AsDateTime<=e.DatExoDebut then
              NbJour:=NbDeJours(e.DatExoDebut,QuEmpruntInteret_Anterieur.FindField('Date').AsDateTime)
            else
              NbJour:=NbDeJours(QuEmpruntInteret_Anterieur.FindField('Date_ant').AsDateTime+1,QuEmpruntInteret_Anterieur.FindField('Date').AsDateTime);
          base:=NbDeJours(QuEmpruntInteret_Anterieur.FindField('Date_ant').AsDateTime+1,QuEmpruntInteret_Anterieur.FindField('Date').AsDateTime);
          if NbJour=0 then
            QuEmprunt_EditionMouvementInteretsCourus.AsCurrency:=QuEmprunt_EditionMouvementInteretsCourus.AsCurrency+QuEmpruntInteret_Anterieur.FindField('interets').AsCurrency
          else
            QuEmprunt_EditionMouvementInteretsCourus.AsCurrency:=QuEmprunt_EditionMouvementInteretsCourus.AsCurrency+(QuEmpruntInteret_Anterieur.FindField('interets').AsCurrency*NbJour/base);
        end;
      end;//fin si interêt <>0
    QuEmpruntInteret_Anterieur.next;
  end;//fin du while
end;


Function EditionEmpruntRepartitionL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet;Relance:boolean):TStringList;
var
periode_1,periode_2:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
ListeEdition:TStringList;
CodeGrTmp:string;
NumEmprunt:integer;
EmpruntTmp,DesignationTmp,CompteTmp:string;
CapitalDu,Periode1,Periode2,Periode3:currency;
TotCapitalDu,TotPeriode1,TotPeriode2,TotPeriode3:currency;
TotGENCapitalDu,TotGENPeriode1,TotGENPeriode2,TotGENPeriode3:currency;
TotGEN1643Periode1:currency;
TotGEN1643Periode2:currency;
TotGEN1643Periode3:currency;
TotGEN164Periode1:currency;
TotGEN164Periode2:currency;
TotGEN164Periode3:currency;
TitreCompte:string;
Compteur:integer;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);

CapitalDu:=0;
Periode1:=0;
Periode2:=0;
Periode3:=0;
TotCapitalDu:=0;
TotPeriode1:=0;
TotPeriode2:=0;
TotPeriode3:=0;
TotGENCapitalDu:=0;
TotGENPeriode1:=0;
TotGENPeriode2:=0;
TotGENPeriode3:=0;

TotGEN1643Periode1:=0;
TotGEN1643Periode2:=0;
TotGEN1643Periode3:=0;
TotGEN164Periode1:=0;
TotGEN164Periode2:=0;
TotGEN164Periode3:=0;

NumEmprunt:=0;
EmpruntTmp:='';
DesignationTmp:='';
CompteTmp:='';

  if ((DemandePeriode) and(not relance)) then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      ParamAffichPeriode.PreAffichage:=true;
      ParamAffichPeriode.Titre:='Indiquez les dates de la 1ère période';
      periode_1:=ChoixPeriodeAffich(e.DatExoFin+1,MoisSuivant(e.DatExoFin,11).Date_,'',ParamAffichPeriode);
      ParamAffichPeriode.Titre:='Indiquez les dates de la 2ème période';
      periode_2:=ChoixPeriodeAffich(periode_1.DateFin+1,MoisSuivant(periode_1.DateFin,47).Date_,'',ParamAffichPeriode);
    end
   else
    begin
     periode_1.Retour := true;
     periode_1.DateDeb := e.DatExoFin+1;
     periode_1.DateFin := MoisSuivant(e.DatExoFin,11).Date_;
     periode_2.Retour := true;
     periode_2.DateDeb := periode_1.DateFin+1;
     periode_2.DateFin := MoisSuivant(periode_1.DateFin,47).Date_;
    end;
  if ((periode_1.Retour)and(periode_2.Retour)) then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;
    if DMEmprunts =nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMEmprunts.ListeFilterRecordEmprunt.clear;
        if CodeGr<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du groupe :'+CodeGr.Strings[0]+' au groupe :'+CodeGr.Strings[CodeGr.count-1];
          DMEmprunts.ListeFilterRecordEmprunt.Assign(CodeGr);
          DMEmprunts.QuEmprunt_Edition.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionMouvementFilterRecord;
          DMEmprunts.QuEmprunt_Edition.filtered:=true;
         end
        else
          begin
            DMEmprunts.QuEmprunt_Edition.OnFilterRecord:=nil;
            Titrecompte:=' Tous les groupes ';
          end;
          DMEmprunts.QuEmprunt_Edition.Close;
          DMEmprunts.QuEmprunt_Edition.sql.clear;

          DMEmprunts.QuEmprunt_Edition.sql.add('select CodeGr,id,Compte_Emp, Code_Emp,Designation_emp,Ech."Date",Annuite,capital,PP1,(P1+P2+P3)as Duree,CapiTotal_Emp,Banque,DateRealisation from emprunts Emp');
          DMEmprunts.QuEmprunt_Edition.sql.add('join EchEmp Ech on (Emp.id=ech.id_emp)');
          DMEmprunts.QuEmprunt_Edition.sql.add('where Ech."Date" >= :DateDeb ');
          DMEmprunts.QuEmprunt_Edition.sql.add('order by CodeGr,code_emp,Compte_Emp,ech."date"');

          DMEmprunts.QuEmprunt_Edition.ParamByName('DateDeb').AsDate := Periode_1.DateDeb;

          DMEmprunts.QuCapitalRestantAvantExo2.Close;
          DMEmprunts.QuCapitalRestantAvantExo2.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_Edition.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRestantAvantExo2.Open;

          DMEmprunts.QuCapitalRestantAvantExo.Close;
          DMEmprunts.QuCapitalRestantAvantExo.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_Edition.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRestantAvantExo.Open;

          DMEmprunts.QuCapitalRestantAvantExoSansEcheance.Close;
          DMEmprunts.QuCapitalRestantAvantExoSansEcheance.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_Edition.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRestantAvantExoSansEcheance.Open;


          DMEmprunts.QuEmprunt_Edition.Open;
          DMEmprunts.QuEmprunt_Edition.First;
          if DMEmprunts.QuEmprunt_Edition.recordcount<>0 then
          begin
          CodeGrTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
          Compteur:=0;
          ListeValeur.Add('9; GROUPE : '+GereLibelle(CodeGrTmp));
                while not DMEmprunts.QuEmprunt_Edition.Eof do
                  begin
                       with DMEmprunts.QuEmprunt_Edition do     //FindField('').Ascurrency
                       begin
                        CapitalDu:=arrondi(FindField('CapitalRestantAvant').Ascurrency,2);
                        NumEmprunt:=FindField('id').Asinteger;
                        EmpruntTmp:=FindField('Code_emp').AsString;
                        DesignationTmp:=FindField('Designation_emp').AsString;
                        CompteTmp:=FindField('Compte_Emp').AsString;
                        while ((not DMEmprunts.QuEmprunt_Edition.Eof)and(NumEmprunt=DMEmprunts.QuEmprunt_Edition.FindField('id').Asinteger)) do
                          Begin
                            if DateDsIntervale(periode_1.DateDeb,FindField('Date').Asdatetime,periode_1.DateFin)then
                              Periode1:=Periode1+arrondi(FindField('capital').Ascurrency,2)
                            else
                            if DateDsIntervale(periode_2.DateDeb,FindField('Date').Asdatetime,periode_2.DateFin)then
                              Periode2:=Periode2+arrondi(FindField('capital').Ascurrency,2)
                            else
                            Periode3:=Periode3+arrondi(FindField('capital').Ascurrency,2);
                            DMEmprunts.QuEmprunt_Edition.next;
                          end;
                        ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle(CodeGrTmp)+' '+GereLibelle(EmpruntTmp)+
                                         ';'+
                                         GereLibelle(DesignationTmp)+
                                         ';'+
                                         currtostr(CapitalDu)+
                                         ';'+
                                         currtostr(Periode1)+
                                         ';'+
                                         currtostr(Periode2)+
                                         ';'+
                                         currtostr(Periode3)
                                         );
                       end;//fin du with
                          TotCapitalDu:=TotCapitalDu+CapitalDu;
                          TotPeriode1:=TotPeriode1+Periode1;
                          TotPeriode2:=TotPeriode2+Periode2;
                          TotPeriode3:=TotPeriode3+Periode3;

                          TotGENCapitalDu:=TotGENCapitalDu+CapitalDu;
                          TotGENPeriode1:=TotGENPeriode1+Periode1;
                          TotGENPeriode2:=TotGENPeriode2+Periode2;
                          TotGENPeriode3:=TotGENPeriode3+Periode3;
                          if( CompteTmp = '164')then
                            begin
                              TotGEN164Periode1:=TotGEN164Periode1+Periode1;
                              TotGEN164Periode2:=TotGEN164Periode2+Periode2;
                              TotGEN164Periode3:=TotGEN164Periode3+Periode3;
                            end;
                          if( CompteTmp = '1643')then
                            begin
                              TotGEN1643Periode1:=TotGEN1643Periode1+Periode1;
                              TotGEN1643Periode2:=TotGEN1643Periode2+Periode2;
                              TotGEN1643Periode3:=TotGEN1643Periode3+Periode3;
                            end;
                          CapitalDu:=0;
                          Periode1:=0;
                          Periode2:=0;
                          Periode3:=0;
                          inc(Compteur);
//                          DMEmprunts.QuEmprunt_Edition.next;


                    if CodeGrTmp<>DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString then
                      begin
                       ListeValeur.Add('3;; @TOTAL GROUPE '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapitalDu)+';'+E.FormatCurrSansDevise(TotPeriode1)+
                       ';'+E.FormatCurrSansDevise(TotPeriode2)+';'+E.FormatCurrSansDevise(TotPeriode3));
                       CodeGrTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
                        ListeValeur.Add('9; GROUPE : '+GereLibelle(CodeGrTmp));
                          TotCapitalDu:=0;
                          TotPeriode1:=0;
                          TotPeriode2:=0;
                          TotPeriode3:=0;
                      end;
                  end;//fin du while not QuEmprunt_Edition.eof
             ListeValeur.Add('3;; @TOTAL GROUPE '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapitalDu)+';'+E.FormatCurrSansDevise(TotPeriode1)+
              ';'+E.FormatCurrSansDevise(TotPeriode2)+';'+E.FormatCurrSansDevise(TotPeriode3));
             CodeGrTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
             ListeValeur.Add('8;Nombre total d''Emprunts : '+ inttostr(Compteur));
             ListeValeur.Add('3;; @TOTAL GENERAL : ;'+E.FormatCurrSansDevise(TotGENCapitalDu)+';'+E.FormatCurrSansDevise(TotGENPeriode1)+
             ';'+E.FormatCurrSansDevise(TotGENPeriode2)+';'+E.FormatCurrSansDevise(TotGENPeriode3));
             ListeEdition.Add('8B2VC;Compte;Debit;Credit') ;
             ListeEdition.Add('8B2VC;1643;'+CurrToStr_Lgr(TotGEN1643Periode1,'0','0')+';0') ;
             ListeEdition.Add('8B2VD;Compte;Debit;Credit');
             ListeEdition.Add('8B2VD;164;'+CurrToStr_Lgr(TotGEN164Periode1,'0','0')+';0') ;
             ListeEdition.Add('8B3VC;Compte;Debit;Credit');
             ListeEdition.Add('8B3VC;1643;'+CurrToStr_Lgr(TotGEN1643Periode2,'0','0')+';0') ;
             ListeEdition.Add('8B3VD;Compte;Debit;Credit');
             ListeEdition.Add('8B3VD;164;'+CurrToStr_Lgr(TotGEN164Periode2,'0','0')+';0') ;
             ListeEdition.Add('8B4VC;Compte;Debit;Credit');
             ListeEdition.Add('8B4VC;1643;'+CurrToStr_Lgr(TotGEN1643Periode3,'0','0')+';0') ;
             ListeEdition.Add('8B4VD;Compte;Debit;Credit');
             ListeEdition.Add('8B4VD;164;'+CurrToStr_Lgr(TotGEN164Periode3,'0','0')+';0') ;
             ObjPrn.FTitreEdition := ' REPARTITION DES ANNUITES ';
             ObjPrn.FSousTitreEdition:=' sur 3 périodes ';
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
//             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
             
             ListeValeur.Insert(0,' Code ; Désignation ;  Le '+DateInfos(Periode_1.DateDeb).DateStr+'; au '+DateInfos(Periode_1.DateFin).DateStr+' ; au '+DateInfos(Periode_2.DateFin).DateStr+' ; '+DateInfos(Periode_2.DateFin+1).DateStr);
             ListeValeur.Insert(1,'0.5;2.0;1.2;1.2;1.2;1.2');
             ListeValeur.Insert(2,'texte;texte;Curr;Curr;Curr;Curr');

             ListeValeur.Insert(3,' Emprunt ; Capital Restant Dû ; du '+DateInfos(Periode_1.DateDeb).DateStr+' ; du '+DateInfos(Periode_2.DateDeb).DateStr+' ; Au dela du ;SURTITRE');
             ListeValeur.Insert(4,'2.5;1.2;1.2;1.2;1.2');

          end;
          if(relance)then
            result:=ListeEdition
          else
          ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;



Function EditionEmpruntRepartitionL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:string;DataSet:TDataSet;Relance:boolean):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (CodeGr)then
     begin
       Maliste.Add(CodeGr);
     end
   else
     raise ExceptLGR.Create('Aucun groupe n''est defini !',1000,true,mtError,Retour);
   EditionEmpruntRepartitionL(TypeEdition,DemandePeriode,Maliste,DataSet,Relance);
  except
     abort;
  end;
end;


Function EditionEmpruntPrevisionnelL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:TStringList;DataSet:TDataSet):Boolean;
var
periode_1,periode_2,periode_3,periode_4,periode_5,periode_6,periode_7,periode_8,periode_9:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
CodeGrTmp:string;
NumEmprunt:integer;
EmpruntTmp,DesignationTmp,Banque:string;
DateDebut,DateFin:TDate;
Duree:integer;
DureeStr:String;
Taux,MontantInitial:currency;
Capital1,Capital2,Capital3,Capital4,Capital5,Capital6,Capital7,Capital8:currency;
TotCapital1,TotCapital2,TotCapital3,TotCapital4,TotCapital5,TotCapital6,TotCapital7,TotCapital8:currency;
TotGENCapital1,TotGENCapital2,TotGENCapital3,TotGENCapital4,TotGENCapital5,TotGENCapital6,TotGENCapital7,TotGENCapital8:currency;
Frais1,Frais2,Frais3,Frais4,Frais5,Frais6,Frais7,Frais8:currency;
TotFrais1,TotFrais2,TotFrais3,TotFrais4,TotFrais5,TotFrais6,TotFrais7,TotFrais8:currency;
TotGENFrais1,TotGENFrais2,TotGENFrais3,TotGENFrais4,TotGENFrais5,TotGENFrais6,TotGENFrais7,TotGENFrais8:currency;
TitreCompte:string;
typeligneTotal:string;
Compteur:integer;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
    typeligneTotal:='3';
Capital1:=0;
Capital2:=0;
Capital3:=0;
Capital4:=0;
Capital5:=0;
Capital6:=0;
Capital7:=0;
Capital8:=0;
TotCapital1:=0;
TotCapital2:=0;
TotCapital3:=0;
TotCapital4:=0;
TotCapital5:=0;
TotCapital6:=0;
TotCapital7:=0;
TotCapital8:=0;
TotGENCapital1:=0;
TotGENCapital2:=0;
TotGENCapital3:=0;
TotGENCapital4:=0;
TotGENCapital5:=0;
TotGENCapital6:=0;
TotGENCapital7:=0;
TotGENCapital8:=0;

Frais1:=0;
Frais2:=0;
Frais3:=0;
Frais4:=0;
Frais5:=0;
Frais6:=0;
Frais7:=0;
Frais8:=0;

TotFrais1:=0;
TotFrais2:=0;
TotFrais3:=0;
TotFrais4:=0;
TotFrais5:=0;
TotFrais6:=0;
TotFrais7:=0;
TotFrais8:=0;

TotGENFrais1:=0;
TotGENFrais2:=0;
TotGENFrais3:=0;
TotGENFrais4:=0;
TotGENFrais5:=0;
TotGENFrais6:=0;
TotGENFrais7:=0;
TotGENFrais8:=0;

NumEmprunt:=0;
EmpruntTmp:='';
DesignationTmp:='';
Duree:=0;
Taux:=0;
Banque:='';
DateDebut:=0;
DateFin:=0;
MontantInitial:=0;
DureeStr:='';
  if DemandePeriode then
    Begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      ParamAffichPeriode.PreAffichage:=true;
      ParamAffichPeriode.Titre:='Indiquez la date de début de prévision';
      ParamAffichPeriode.AffichDateFin:=false;
      periode_1:=ChoixPeriodeAffich(e.DatExoDebut,0,'',ParamAffichPeriode);
    end
   else
    begin
     periode_1.Retour := true;
     periode_1.DateDeb := e.DatExoDebut;
    end;
  if periode_1.Retour then
   begin
     periode_1.DateFin:=MoisSuivant(periode_1.DateDeb,11).Date_-1;

     periode_2.DateDeb:= MoisSuivant(periode_1.DateDeb,11).Date_;
     periode_3.DateDeb:= MoisSuivant(periode_2.DateDeb,11).Date_;
     periode_4.DateDeb:= MoisSuivant(periode_3.DateDeb,11).Date_;
     periode_5.DateDeb:= MoisSuivant(periode_4.DateDeb,11).Date_;
     periode_6.DateDeb:= MoisSuivant(periode_5.DateDeb,11).Date_;
     periode_7.DateDeb:= MoisSuivant(periode_6.DateDeb,11).Date_;
     periode_8.DateDeb:= MoisSuivant(periode_7.DateDeb,11).Date_;
     periode_9.DateDeb:= MoisSuivant(periode_8.DateDeb,11).Date_;

     periode_2.DateFin:= MoisSuivant(periode_1.DateFin,11).Date_;
     periode_3.DateFin:= MoisSuivant(periode_2.DateFin,11).Date_;
     periode_4.DateFin:= MoisSuivant(periode_3.DateFin,11).Date_;
     periode_5.DateFin:= MoisSuivant(periode_4.DateFin,11).Date_;
     periode_6.DateFin:= MoisSuivant(periode_5.DateFin,11).Date_;
     periode_7.DateFin:= MoisSuivant(periode_6.DateFin,11).Date_;
     periode_8.DateFin:= MoisSuivant(periode_7.DateFin,11).Date_;
     periode_9.DateDeb:= MoisSuivant(periode_8.DateDeb,11).Date_;

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DMEmprunts =nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMEmprunts.ListeFilterRecordEmprunt.clear;
        if CodeGr<>nil then      // Tous les comptes
         begin
          TitreCompte:='Du groupe :'+CodeGr.Strings[0]+' au groupe :'+CodeGr.Strings[CodeGr.count-1];
          DMEmprunts.ListeFilterRecordEmprunt.Assign(CodeGr);
          DMEmprunts.QuEmprunt_Edition.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionMouvementFilterRecord;
          DMEmprunts.QuEmprunt_Edition.filtered:=true;
         end
        else
          begin
            DMEmprunts.QuEmprunt_Edition.OnFilterRecord:=nil;
            Titrecompte:=' Tous les groupes ';
          end;
          DMEmprunts.QuEmprunt_Edition.Close;
          DMEmprunts.QuEmprunt_Edition.sql.clear;
          DMEmprunts.QuEmprunt_Edition.sql.add(' select CodeGr,id, Code_Emp,Compte_Emp,Designation_emp,Ech."Date",');
          DMEmprunts.QuEmprunt_Edition.sql.add(' Annuite,capital,PP1,(P1+P2+P3)as Duree,CapiTotal_Emp,Banque,DateRealisation from emprunts Emp');
          DMEmprunts.QuEmprunt_Edition.sql.add(' join EchEmp Ech on (Emp.id=ech.id_emp)');
          DMEmprunts.QuEmprunt_Edition.sql.add(' where Ech."Date" >= :DateDeb ');
          DMEmprunts.QuEmprunt_Edition.sql.add(' order by CodeGr,code_emp,ech."date"');

          DMEmprunts.QuEmprunt_Edition.ParamByName('DateDeb').AsDate := Periode_1.DateDeb;


          DMEmprunts.QuCapitalRestantAvantExo.Close;
          DMEmprunts.QuCapitalRestantAvantExo.ParamByName('DateDeb').AsDate:=DMEmprunts.QuEmprunt_Edition.Parambyname('DateDeb').AsDate;
          DMEmprunts.QuCapitalRestantAvantExo.Open;

          DMEmprunts.QuEmprunt_Edition.Open;
          DMEmprunts.QuEmprunt_Edition.First;
          CodeGrTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
          Compteur:=0;
          if DMEmprunts.QuEmprunt_Edition.recordcount<>0 then
          begin
          ListeValeur.Add('9; GROUPE : '+GereLibelle(CodeGrTmp));
                while not DMEmprunts.QuEmprunt_Edition.Eof do
                  begin
                       with DMEmprunts.QuEmprunt_Edition do     //FindField('').Ascurrency
                       begin
                        NumEmprunt:=FindField('id').Asinteger;
                        EmpruntTmp:=FindField('Code_emp').AsString;
                        DesignationTmp:=FindField('Designation_emp').AsString;
                        Duree:=(FindField('duree').Asinteger div 12);

                        DureeStr:=inttostr(duree)+'a ';
                        if(FindField('duree').Asinteger mod 12)>0 then
                           DureeStr:= DureeStr+inttostr(FindField('duree').Asinteger mod 12)+'m';

                        Taux:=FindField('PP1').Ascurrency;
                        banque:=findfield('banque').asstring;
                        DateDebut:=findfield('dateRealisation').AsDateTime;
                        DateFin :=findfield('dateFin').AsDateTime;
                        MontantInitial:=FindField('CapiTotal_emp').Ascurrency;
                        while ((not DMEmprunts.QuEmprunt_Edition.Eof)and(NumEmprunt=DMEmprunts.QuEmprunt_Edition.FindField('id').Asinteger)) do
                          Begin
                            if DateDsIntervale(periode_1.DateDeb,FindField('Date').Asdatetime,periode_1.DateFin)then
                              begin
                                Capital1:=Capital1+arrondi(FindField('capital').Ascurrency,2);
                                Frais1:=Frais1+arrondi(FindField('Annuite').Ascurrency-FindField('capital').Ascurrency,2);
                              end;
                            if DateDsIntervale(periode_2.DateDeb,FindField('Date').Asdatetime,periode_2.DateFin)then
                              begin
                                Capital2:=Capital2+arrondi(FindField('capital').Ascurrency,2);
                                Frais2:=Frais2+arrondi(FindField('Annuite').Ascurrency-FindField('capital').Ascurrency,2);
                              end;
                            if DateDsIntervale(periode_3.DateDeb,FindField('Date').Asdatetime,periode_3.DateFin)then
                              begin
                                Capital3:=Capital3+arrondi(FindField('capital').Ascurrency,2);
                                Frais3:=Frais3+arrondi(FindField('Annuite').Ascurrency-FindField('capital').Ascurrency,2);
                              end;
                            if DateDsIntervale(periode_4.DateDeb,FindField('Date').Asdatetime,periode_4.DateFin)then
                              begin
                                Capital4:=Capital4+arrondi(FindField('capital').Ascurrency,2);
                                Frais4:=Frais4+arrondi(FindField('Annuite').Ascurrency-FindField('capital').Ascurrency,2);
                              end;
                            if DateDsIntervale(periode_5.DateDeb,FindField('Date').Asdatetime,periode_5.DateFin)then
                              begin
                                Capital5:=Capital5+arrondi(FindField('capital').Ascurrency,2);
                                Frais5:=Frais5+arrondi(FindField('Annuite').Ascurrency-FindField('capital').Ascurrency,2);
                              end;
                            if DateDsIntervale(periode_6.DateDeb,FindField('Date').Asdatetime,periode_6.DateFin)then
                              begin
                                Capital6:=Capital6+arrondi(FindField('capital').Ascurrency,2);
                                Frais6:=Frais6+arrondi(FindField('Annuite').Ascurrency-FindField('capital').Ascurrency,2);
                              end;
                            if DateDsIntervale(periode_7.DateDeb,FindField('Date').Asdatetime,periode_7.DateFin)then
                              begin
                                Capital7:=Capital7+arrondi(FindField('capital').Ascurrency,2);
                                Frais7:=Frais7+arrondi(FindField('Annuite').Ascurrency-FindField('capital').Ascurrency,2);
                              end;
                            if DateDsIntervale(periode_8.DateDeb,FindField('Date').Asdatetime,periode_8.DateFin)then
                              begin
                                Capital8:=Capital8+arrondi(FindField('capital').Ascurrency,2);
                                Frais8:=Frais8+arrondi(FindField('Annuite').Ascurrency-FindField('capital').Ascurrency,2);
                              end;
                            DMEmprunts.QuEmprunt_Edition.next;
                          end;
                        ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle(CodeGrTmp)+' '+GereLibelle(EmpruntTmp)+'  |  '+GereLibelle(banque)+'  |  '+DureeStr+
                                         ';'+
                                         currtostr(taux)+
                                         ';'+
                                         DateInfos(DateDebut,true).DateStr+ //DateRealisation
                                         ';'+
                                         currtostr(Capital1)+
                                         ';'+
                                         currtostr(Capital2)+
                                         ';'+
                                         currtostr(Capital3)+
                                         ';'+
                                         currtostr(Capital4)+
                                         ';'+
                                         currtostr(Capital5)+
                                         ';'+
                                         currtostr(Capital6)+
                                         ';'+
                                         currtostr(Capital7)+
                                         ';'+
                                         currtostr(Capital8)
                                         );
                        ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle(DesignationTmp)+
                                         ';'+
                                         currtostr(MontantInitial)+    //Montant initial
                                         ';'+
                                         dateInfos(DateFin,true).DateStr+
                                         ';'+
                                         currtostr(Frais1)+
                                         ';'+
                                         currtostr(Frais2)+
                                         ';'+
                                         currtostr(Frais3)+
                                         ';'+
                                         currtostr(Frais4)+
                                         ';'+
                                         currtostr(Frais5)+
                                         ';'+
                                         currtostr(Frais6)+
                                         ';'+
                                         currtostr(Frais7)+
                                         ';'+
                                         currtostr(Frais8)
                                         );
                        ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle('Annuité')+
                                         ';'+
                                         currtostr(0)+
                                         ';'+
                                         '-'+
                                         ';'+
                                         currtostr(Frais1+Capital1)+
                                         ';'+
                                         currtostr(Frais2+Capital2)+
                                         ';'+
                                         currtostr(Frais3+Capital3)+
                                         ';'+
                                         currtostr(Frais4+Capital4)+
                                         ';'+
                                         currtostr(Frais5+Capital5)+
                                         ';'+
                                         currtostr(Frais6+Capital6)+
                                         ';'+
                                         currtostr(Frais7+Capital7)+
                                         ';'+
                                         currtostr(Frais8+Capital8)
                                         );
                       ListeValeur.Add('12;;');

                       end;//fin du with
                            TotCapital1:=TotCapital1+Capital1;
                            TotCapital2:=TotCapital2+Capital2;
                            TotCapital3:=TotCapital3+Capital3;
                            TotCapital4:=TotCapital4+Capital4;
                            TotCapital5:=TotCapital5+Capital5;
                            TotCapital6:=TotCapital6+Capital6;
                            TotCapital7:=TotCapital7+Capital7;
                            TotCapital8:=TotCapital8+Capital8;

                            TotFrais1:=TotFrais1+Frais1;
                            TotFrais2:=TotFrais2+Frais2;
                            TotFrais3:=TotFrais3+Frais3;
                            TotFrais4:=TotFrais4+Frais4;
                            TotFrais5:=TotFrais5+Frais5;
                            TotFrais6:=TotFrais6+Frais6;
                            TotFrais7:=TotFrais7+Frais7;
                            TotFrais8:=TotFrais8+Frais8;

                            TotGENCapital1:=TotGENCapital1+Capital1;
                            TotGENCapital2:=TotGENCapital2+Capital2;
                            TotGENCapital3:=TotGENCapital3+Capital3;
                            TotGENCapital4:=TotGENCapital4+Capital4;
                            TotGENCapital5:=TotGENCapital5+Capital5;
                            TotGENCapital6:=TotGENCapital6+Capital6;
                            TotGENCapital7:=TotGENCapital7+Capital7;
                            TotGENCapital8:=TotGENCapital8+Capital8;
                            TotGENFrais1:=TotGENFrais1+Frais1;
                            TotGENFrais2:=TotGENFrais2+Frais2;
                            TotGENFrais3:=TotGENFrais3+Frais3;
                            TotGENFrais4:=TotGENFrais4+Frais4;
                            TotGENFrais5:=TotGENFrais5+Frais5;
                            TotGENFrais6:=TotGENFrais6+Frais6;
                            TotGENFrais7:=TotGENFrais7+Frais7;
                            TotGENFrais8:=TotGENFrais8+Frais8;

                            Capital1:=0;
                            Capital2:=0;
                            Capital3:=0;
                            Capital4:=0;
                            Capital5:=0;
                            Capital6:=0;
                            Capital7:=0;
                            Capital8:=0;
                            Frais1:=0;
                            Frais2:=0;
                            Frais3:=0;
                            Frais4:=0;
                            Frais5:=0;
                            Frais6:=0;
                            Frais7:=0;
                            Frais8:=0;
                          inc(Compteur);
//                          DMEmprunts.QuEmprunt_Edition.next;


                    if CodeGrTmp<>DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString then
                      begin
                       ListeValeur.Add(typeligneTotal+';;; @TOTAL capital '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapital1)+';'+E.FormatCurrSansDevise(TotCapital2)+
                        ';'+E.FormatCurrSansDevise(TotCapital3)+';'+E.FormatCurrSansDevise(TotCapital4)+';'+E.FormatCurrSansDevise(TotCapital5)+';'+E.FormatCurrSansDevise(TotCapital6)+
                        ';'+E.FormatCurrSansDevise(TotCapital7)+';'+E.FormatCurrSansDevise(TotCapital8));
                       ListeValeur.Add(typeligneTotal+';;; @TOTAL Interets '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotFrais1)+';'+E.FormatCurrSansDevise(TotFrais2)+
                        ';'+E.FormatCurrSansDevise(TotFrais3)+';'+E.FormatCurrSansDevise(TotFrais4)+';'+E.FormatCurrSansDevise(TotFrais5)+';'+E.FormatCurrSansDevise(TotFrais6)+
                        ';'+E.FormatCurrSansDevise(TotFrais7)+';'+E.FormatCurrSansDevise(TotFrais8));
                       ListeValeur.Add(typeligneTotal+';;; @TOTAL Annuités '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapital1+TotFrais1)+';'+E.FormatCurrSansDevise(TotCapital2+TotFrais2)+
                        ';'+E.FormatCurrSansDevise(TotCapital3+TotFrais3)+';'+E.FormatCurrSansDevise(TotCapital4+TotFrais4)+';'+E.FormatCurrSansDevise(TotCapital5+TotFrais5)+';'+E.FormatCurrSansDevise(TotCapital6+TotFrais6)+
                        ';'+E.FormatCurrSansDevise(TotCapital7+TotFrais7)+';'+E.FormatCurrSansDevise(TotCapital8+TotFrais8));
                       CodeGrTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
                        ListeValeur.Add('9; GROUPE : '+GereLibelle(CodeGrTmp));
                            TotCapital1:=0;
                            TotCapital2:=0;
                            TotCapital3:=0;
                            TotCapital4:=0;
                            TotCapital5:=0;
                            TotCapital6:=0;
                            TotCapital7:=0;
                            TotCapital8:=0;
                            TotFrais1:=0;
                            TotFrais2:=0;
                            TotFrais3:=0;
                            TotFrais4:=0;
                            TotFrais5:=0;
                            TotFrais6:=0;
                            TotFrais7:=0;
                            TotFrais8:=0;
                     end;
                  end;//fin du while not QuEmprunt_Edition.eof
             ListeValeur.Add(typeligneTotal+';;; @TOTAL capital '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapital1)+';'+E.FormatCurrSansDevise(TotCapital2)+
              ';'+E.FormatCurrSansDevise(TotCapital3)+';'+E.FormatCurrSansDevise(TotCapital4)+';'+E.FormatCurrSansDevise(TotCapital5)+';'+E.FormatCurrSansDevise(TotCapital6)+
              ';'+E.FormatCurrSansDevise(TotCapital7)+';'+E.FormatCurrSansDevise(TotCapital8));
             ListeValeur.Add(typeligneTotal+';;; @TOTAL Interets '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotFrais1)+';'+E.FormatCurrSansDevise(TotFrais2)+
              ';'+E.FormatCurrSansDevise(TotFrais3)+';'+E.FormatCurrSansDevise(TotFrais4)+';'+E.FormatCurrSansDevise(TotFrais5)+';'+E.FormatCurrSansDevise(TotFrais6)+
              ';'+E.FormatCurrSansDevise(TotFrais7)+';'+E.FormatCurrSansDevise(TotFrais8));
             ListeValeur.Add(typeligneTotal+';;; @TOTAL Annuités '+GereLibelle(CodeGrTmp)+' : ;'+E.FormatCurrSansDevise(TotCapital1+TotFrais1)+';'+E.FormatCurrSansDevise(TotCapital2+TotFrais2)+
              ';'+E.FormatCurrSansDevise(TotCapital3+TotFrais3)+';'+E.FormatCurrSansDevise(TotCapital4+TotFrais4)+';'+E.FormatCurrSansDevise(TotCapital5+TotFrais5)+';'+E.FormatCurrSansDevise(TotCapital6+TotFrais6)+
              ';'+E.FormatCurrSansDevise(TotCapital7+TotFrais7)+';'+E.FormatCurrSansDevise(TotCapital8+TotFrais8));
             CodeGrTmp:=DMEmprunts.QuEmprunt_Edition.FindField('CodeGr').AsString;
             ListeValeur.Add('8;Nombre total d''Emprunts : '+ inttostr(Compteur));

             ListeValeur.Add(typeligneTotal+';;; @TOTAL GEN. capital '+' : ;'+E.FormatCurrSansDevise(TotGENCapital1)+';'+E.FormatCurrSansDevise(TotGENCapital2)+
              ';'+E.FormatCurrSansDevise(TotGENCapital3)+';'+E.FormatCurrSansDevise(TotGENCapital4)+';'+E.FormatCurrSansDevise(TotGENCapital5)+';'+E.FormatCurrSansDevise(TotGENCapital6)+
              ';'+E.FormatCurrSansDevise(TotGENCapital7)+';'+E.FormatCurrSansDevise(TotGENCapital8));
             ListeValeur.Add(typeligneTotal+';;; @TOTAL GEN. Interets '+' : ;'+E.FormatCurrSansDevise(TotGENFrais1)+';'+E.FormatCurrSansDevise(TotGENFrais2)+
              ';'+E.FormatCurrSansDevise(TotGENFrais3)+';'+E.FormatCurrSansDevise(TotGENFrais4)+';'+E.FormatCurrSansDevise(TotGENFrais5)+';'+E.FormatCurrSansDevise(TotGENFrais6)+
              ';'+E.FormatCurrSansDevise(TotGENFrais7)+';'+E.FormatCurrSansDevise(TotGENFrais8));
             ListeValeur.Add(typeligneTotal+';;; @TOTAL GEN. Annuités '+' : ;'+E.FormatCurrSansDevise(TotGENCapital1+TotGENFrais1)+';'+E.FormatCurrSansDevise(TotGENCapital2+TotGENFrais2)+
              ';'+E.FormatCurrSansDevise(TotGENCapital3+TotGENFrais3)+';'+E.FormatCurrSansDevise(TotGENCapital4+TotGENFrais4)+';'+E.FormatCurrSansDevise(TotGENCapital5+TotGENFrais5)+';'+E.FormatCurrSansDevise(TotGENCapital6+TotGENFrais6)+
              ';'+E.FormatCurrSansDevise(TotGENCapital7+TotGENFrais7)+';'+E.FormatCurrSansDevise(TotGENCapital8+TotGENFrais8));

             ObjPrn.FTitreEdition := ' TABLEAU PREVISIONNEL A LONG TERME ';
             ObjPrn.FSousTitreEdition:='';
             ObjPrn.FTitre2Edition :=TitreCompte;
             ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
//             ObjPrn.FTitre3Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr  ;
             ObjPrn.RightMargin_Objet:=0.28;
             ObjPrn.Orientation:=poLandscape;
            ListeValeur.Insert(0,'  Désignation ; Mt initial ;  Fin ; Frais F. ; Frais F. ; Frais F. ; Frais F. ; Frais F. ; Frais F. ; Frais F. ; Frais F. ');
            ListeValeur.Insert(1,'2.3;0.9;0.7;0.9;0.9;0.9;0.9;0.9;0.9;0.9;0.9');
             ListeValeur.Insert(2,'texte;curr;texteRight;Curr;Curr;Curr;Curr;Curr;Curr;Curr;Curr');


             //1ER SURTITRE   MoisSuivant(Periode_2.DateDeb,11)
             ListeValeur.Insert(3,' Début de prévision : '+'&'+DateInfos(Periode_1.DateDeb,true).DateStr+
             ' ; du '+DateInfos(Periode_1.DateDeb,true).DateStr+'&'+
             'au '+DateInfos(Periode_1.DateFin,true).DateStr+
             ' ; du '+DateInfos(Periode_2.DateDeb,true).DateStr+'&'+
             'au '+DateInfos(Periode_2.DateFin,true).DateStr+
             ' ; du '+DateInfos(Periode_3.DateDeb,true).DateStr+'&'+
             'au '+DateInfos(Periode_3.DateFin,true).DateStr+
             ' ; du '+DateInfos(Periode_4.DateDeb,true).DateStr+'&'+
             'au '+DateInfos(Periode_4.DateFin,true).DateStr+
             ' ; du '+DateInfos(Periode_5.DateDeb,true).DateStr+'&'+
             'au '+DateInfos(Periode_5.DateFin,true).DateStr+
             ' ; du '+DateInfos(Periode_6.DateDeb,true).DateStr+'&'+
             'au '+DateInfos(Periode_6.DateFin,true).DateStr+
             ' ; du '+DateInfos(Periode_7.DateDeb,true).DateStr+'&'+
             'au '+DateInfos(Periode_7.DateFin,true).DateStr+
             ' ; du '+DateInfos(Periode_8.DateDeb,true).DateStr+'&'+
             'au '+DateInfos(Periode_8.DateFin,true).DateStr+
             ';SURTITREDOUBLE');    //SURTITREDOUBLE
             ListeValeur.Insert(4,'3.9;0.9;0.9;0.9;0.9;0.9;0.9;0.9;0.9');
             //2ème SURTITRE
             ListeValeur.Insert(5,' Groupe-N°  |  banque  |  Durée ; Taux ; Début ; Capital ; Capital ; Capital ; Capital ; Capital ; Capital ; Capital ; Capital ;SURTITRE');
             ListeValeur.Insert(6,'2.3;0.9;0.7;0.9;0.9;0.9;0.9;0.9;0.9;0.9;0.9');
          end;
          ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;



Function EditionEmpruntPrevisionnelL(TypeEdition : integer; DemandePeriode:Boolean; CodeGr:string;DataSet:TDataSet):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (CodeGr)then
     begin
       Maliste.Add(CodeGr);
     end
   else
     raise ExceptLGR.Create('Aucun groupe n''est defini !',1000,true,mtError,Retour);
   EditionEmpruntPrevisionnelL(TypeEdition,DemandePeriode,Maliste,DataSet);
  except
     abort;
  end;
end;
procedure TDMEmprunts.QuEmpruntSansEchDansAnneeCalcFields(
  DataSet: TDataSet);
  var
NbJour,base:real;
DerniereDate,DateProchaine:Tdate;
begin
QuProchaineDateEch.Close;
QuProchaineDateEch.ParamByName('DateFin').AsDate:=e.DatExoFin;
QuProchaineDateEch.ParamByName('id').asinteger:=QuEmpruntSansEchDansAnneeid_emp.AsInteger;
QuProchaineDateEch.open;
if ((QuProchaineDateEch.RecordCount<>0)and(QuProchaineDateEch.findfield('ProchaineDate').AsDateTime<>0)) then
  DateProchaine:=QuProchaineDateEch.findfield('ProchaineDate').AsDateTime
else
  DateProchaine:=e.DatExoFin;


QuEmpruntInteret.Close;
DerniereDate:=QuEmpruntSansEchDansAnneeDateRealisation.AsDateTime+1;
QuEmpruntInteret.ParamByName('DateDeb').AsDate:=DerniereDate;
QuEmpruntInteret.ParamByName('id').asinteger:=QuEmpruntSansEchDansAnneeid_emp.AsInteger;
QuEmpruntInteret.ParamByName('DateFin').AsDate:=DateProchaine;

QuEmpruntInteret.open;
if QuEmpruntSansEchDansAnneeDateFinEmprunt.AsDateTime>=e.DatExoDebut then
if ((QuEmpruntInteret.RecordCount<>0)and(QuEmpruntInteret.FindField('Interets').AsCurrency<>0)and(QuEmpruntSansEchDansAnneeDateRealisation.AsDateTime+1<e.DatExoFin)) then
  begin
    if ((QuEmpruntSansEchDansAnnee.Params[0].AsDate=e.DatExoDebut) and (QuEmpruntSansEchDansAnnee.Params[1].AsDate=e.DatExoFin))then
      Begin
        if e.DatExoFin+1=dateprochaine then
          NbJour:=0
        else
          NbJour:=NbDeJours(DerniereDate,e.DatExoFin);
        base:=NbDeJours(DerniereDate,dateprochaine);
        if NbJour=0 then
          QuEmpruntSansEchDansAnneeInteretsCourus.AsCurrency:=QuEmpruntInteret.FindField('Interets').AsCurrency
        else
          QuEmpruntSansEchDansAnneeInteretsCourus.AsCurrency:=(QuEmpruntInteret.FindField('Interets').AsCurrency*NbJour/base);
      end;
  end;
end;


procedure initialise_PeriodeAnnuite(Var PeriodeAnnuite:TPeriodeAnnuite);
begin
  PeriodeAnnuite.Mois:=0;
  PeriodeAnnuite.MoisAnnee:='';
  PeriodeAnnuite.Annuite:=0;
  PeriodeAnnuite.TotAnnuite:=0;
  PeriodeAnnuite.TotGENAnnuite:=0;
end;


procedure TDMEmprunts.QuEmprunt_EditionCalcFields(DataSet: TDataSet);
begin
if QuEmprunt_EditionCapitalRestantAvantExo.AsCurrency=0  then
  QuEmprunt_EditionCapitalRestantAvant.AsCurrency:=QuEmprunt_EditionCapitalRestantAvantExoSansEch.AsCurrency
else
  QuEmprunt_EditionCapitalRestantAvant.AsCurrency:=QuEmprunt_EditionCapitalRestantAvantExo.AsCurrency;
end;


Function EditionEmpruntEcheancierL(TypeEdition : integer; idEmp:integer;DataSet:TDataSet):Boolean;
var
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
TitreCompte:string;
Compteur:integer;
ParamAffichPeriode:TParamAffichPeriode;
Annuite,Capital,Interet,Assurance,FraisDivers,CapitalRestant:currency;
TotAnnuite,TotCapital,TotInteret,TotAssurance,TotFraisDivers:currency;
An1,an2,an3,Periode,
Mois1,mois2,mois3,mode,dateRemboursement:string;
duree1,duree2,duree3:integer;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
///
TotAnnuite:=0;
TotCapital:=0;
TotInteret:=0;
TotAssurance:=0;
TotFraisDivers:=0;

Annuite:=0;
Capital:=0;
Interet:=0;
Assurance:=0;
FraisDivers:=0;
CapitalRestant:=0;
dateRemboursement:='';
Periode:='';

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DMEmprunts =nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;

          DMEmprunts.QuEcheancierEdition.SQL.Clear;
          DMEmprunts.QuEcheancierEdition.SQL.Add('select * from echEmp Ech ');
          DMEmprunts.QuEcheancierEdition.SQL.Add('join emprunts E on(Ech.id_emp=E.id) ');
          DMEmprunts.QuEcheancierEdition.SQL.Add('where id_emp=:idemp order by echemp."date"');
          DMEmprunts.QuEcheancierEdition.ParamByName('idemp').asinteger:=idemp;
          DMEmprunts.QuEcheancierEdition.Open;
          DMEmprunts.QuEcheancierEdition.first;
          if DMEmprunts.QuEcheancierEdition.recordcount<>0 then
          begin
          with DMEmprunts.QuEcheancierEdition do     //FindField('').Asstring
              begin
                Compteur:=0;
                duree1 :=StrToInt_Lgr(FindField('p1').AsString);
                duree2 :=StrToInt_Lgr(FindField('p2').AsString);
                duree3 :=StrToInt_Lgr(FindField('p3').AsString);
                An1    :=inttostr(round(duree1 div 12));
                Mois1  :=inttostr(duree1 mod 12);
                An2    :=inttostr(round(duree2 div 12));
                Mois2  :=inttostr(duree2 mod 12);
                An3    :=inttostr(round(duree3 div 12));
                Mois3  :=inttostr(duree3 mod 12);
                if FindField('TypeRb').AsString = 'CAP' then mode := 'Capital constant';
                if FindField('TypeRb').AsString = 'MEN' then mode := 'Annuité constante';
                if FindField('TypeRb').AsString = 'AUT' then mode := 'Manuel';

                if FindField('PeriodeRb').AsString='ANN' then Periode:='Annuel';
                if FindField('PeriodeRb').AsString='SEM' then Periode:='Semestriel';
                if FindField('PeriodeRb').AsString='TRI' then Periode:='Trimestriel';
                if FindField('PeriodeRb').AsString='MEN' then Periode:='Mensuel';

                      while not Eof do
                        begin                                                       
                            Annuite:=arrondi(FindField('Annuite').Ascurrency,2);
                            Capital:=arrondi(FindField('Capital').Ascurrency,2);
                            Interet:=arrondi(FindField('interets').Ascurrency,2);
                            Assurance:=arrondi(FindField('Assurances').Ascurrency,2);
                            FraisDivers:=arrondi(FindField('Frais_Divers').Ascurrency,2);
                            CapitalRestant:=arrondi(FindField('Capital_Restant_Du').Ascurrency,2);
                            if FindField('DateRemboursement').Asdatetime<>0 then
                              dateRemboursement:=datetostr(FindField('DateRemboursement').Asdatetime);
                              ListeValeur.Add('0'+
                                               ';'+
                                               FindField('Date').Asstring+          //date échéance
                                               ';'+
                                               currtostr(Annuite)+          //Annuité
                                               ';'+
                                               currtostr(Capital)+//capital
                                               ';'+
                                               currtostr(Interet)+//interets
                                               ';'+
                                               currtostr(Assurance)+//assurance
                                               ';'+
                                               currtostr(FraisDivers)+ //frais divers
                                               ';'+
                                               currtostr(CapitalRestant)+ //Capital restant
                                               ';'+
                                               dateRemboursement//Date remboursement
                                               );
                            // end;//fin du with
                                TotAnnuite:=TotAnnuite+Annuite;
                                TotCapital:=TotCapital+Capital;
                                TotInteret:=TotInteret+Interet;
                                TotAssurance:=TotAssurance+Assurance;
                                TotFraisDivers:=TotFraisDivers+FraisDivers;
                            Annuite:=0;
                            Capital:=0;
                            Interet:=0;
                            Assurance:=0;
                            FraisDivers:=0;
                            CapitalRestant:=0;
                            dateRemboursement:='';
                                inc(Compteur);
                                next;
                        end;//fin du while not QuEmprunt_Edition.eof
                 ListeValeur.Add('3; @TOTAL : ;'+E.FormatCurrSansDevise(TotAnnuite)+';'+E.FormatCurrSansDevise(TotCapital)+
                  ';'+E.FormatCurrSansDevise(TotInteret)+';'+E.FormatCurrSansDevise(TotAssurance)+';'+E.FormatCurrSansDevise(TotFraisDivers)+';'+E.FormatCurrSansDevise(CapitalRestant));
                 ListeValeur.Add('8;Nombre total d''Echéances : '+ inttostr(Compteur));                                                         //

                ListeValeur.Add('12;;');
                ListeValeur.Add('7; Code groupe : '+GereLibelle(FindField('codeGr').asstring)+' - Nom de la banque : '+GereLibelle(FindField('Banque').AsString));
                ListeValeur.Add('7; Montant initial : '+E.FormatCurr(FindField('Capitotal_Emp').AsCurrency)+' - Date de réalisation : '+FindField('DateRealisation').AsString);
                ListeValeur.Add('7; Période 1 : '+ An1 +' ans '+mois1+' mois - Taux : '+ FindField('pp1').AsString+' %' );
                if not VerifFNumeric(FindField('p2')).VideOUZero then
                  ListeValeur.Add('7; Période 2 : '+ An2 +' ans '+mois2+' mois - Taux : '+ FindField('pp2').AsString+' %' );
                if not VerifFNumeric(FindField('p3')).VideOUZero then
                  ListeValeur.Add('7; Période 3 : '+ An3 +' ans '+mois3+' mois - Taux : '+ FindField('pp3').AsString+' %' );
                ListeValeur.Add('7; Périodicité des remboursements  : '+Periode+' - Mode de calcul : '+mode);
                ListeValeur.Add('7; Différé en mois : '+FindField('DiffereMois').Asstring+' - Frais annexes en % : '+FindField('Assurance').Asstring );
                ListeValeur.Add('7; Date 1ère échéance : '+FindField('DatePremEcheance').Asstring );
                ListeValeur.Add('7; Capital remboursé : '+E.FormatCurr(FindField('CapitalRbPE').AsCurrency)+' - Interêts payés : '+ E.FormatCurr(FindField('InteretRbPE').AsCurrency));
                ListeValeur.Add('7;;');
                ListeValeur.Add('12;;');
                 ObjPrn.FTitreEdition := ' ECHEANCIER DE L''EMPRUNT :'+ GereLibelle(DMEmprunts.QuEcheancierEdition.FindField('Code_emp').Asstring);
                 ObjPrn.FSousTitreEdition:=DMEmprunts.QuEcheancierEdition.FindField('Designation_Emp').asstring;
                 ObjPrn.FTitre2Edition :='';
                 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;

                 ListeValeur.Insert(0,' Date ; Annuité ; Capital ; Interêts; Assurances ; Frais divers ; Capital Restant ; Date Remb. ');
                 ListeValeur.Insert(1,'0.9;0.9;0.9;0.9;0.9;0.9;0.9;0.9');
                 ListeValeur.Insert(2,'texte;Curr;Curr;Curr;Curr;Curr;Curr;texte');
              end;//fin du with
          end;
          ObjPrn.AffichageImp(ListeValeur);
//  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;


Function EditionEmpruntOuvertureL(TypeEdition : integer; idEmp:integer;Compte:string;DataSet:TDataSet):Boolean;
Var
ListeCompte:TStringList;
Begin
ListeCompte:=TStringList.Create;
ListeCompte.Add(Compte);
EditionEmpruntOuvertureL(TypeEdition,idEmp,ListeCompte,DataSet);
End;

Function EditionEmpruntOuvertureL(TypeEdition : integer; idEmp:integer;Compte:Tstringlist;DataSet:TDataSet):Boolean;
var
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
TitreCompte:string;
Compteur:integer;
ParamAffichPeriode:TParamAffichPeriode;
CapiResteDu_emp,Capitotal_emp:currency;
TotCapiResteDu_emp,TotCapitotal_emp:currency;
begin
try///finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
CapiResteDu_emp:=0;
Capitotal_emp:=0;
TotCapiResteDu_emp:=0;
TotCapitotal_emp:=0;

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DMEmprunts =nil then DMEmprunts:=TDMEmprunts.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;

          DMEmprunts.QuEmpruntOuverture.SQL.Clear;
          DMEmprunts.QuEmpruntOuverture.SQL.Add('select * from emprunts where actif=false');
          DMEmprunts.QuEmpruntOuverture.OnFilterRecord:=nil;
          if idEmp<>0 then
            begin
              DMEmprunts.QuEmpruntOuverture.SQL.Add(' and id=:idemp');
              DMEmprunts.QuEmpruntOuverture.ParamByName('idemp').asinteger:=idemp;
            end;
          if Compte<> nil then
            begin
              DMEmprunts.ListeFilterRecordEmprunt.Assign(compte);
              DMEmprunts.QuEmpruntOuverture.OnFilterRecord:=DMEmprunts.QuEmprunt_EditionOuvertureFilterRecord;
            end;
          DMEmprunts.QuEmpruntOuverture.Filtered:=true;
          DMEmprunts.QuEmpruntOuverture.Open;
          DMEmprunts.QuEmpruntOuverture.first;
          if DMEmprunts.QuEmpruntOuverture.recordcount<>0 then
          begin
          with DMEmprunts.QuEmpruntOuverture do     //FindField('').Asstring
              begin
                Compteur:=0;
                      while not Eof do
                        begin
                              ListeValeur.Add('0'+
                                               ';'+
                                               GereLibelle(FindField('Code_emp').Asstring)+          //Code_emp
                                               ';'+
                                               GereLibelle(FindField('Compte_emp').Asstring)+          //Compte_emp
                                               ';'+
                                               GereLibelle(FindField('Designation_emp').Asstring)+          //Designation_emp
                                               ';'+
                                               currtostr(FindField('CapiResteDu_emp').Ascurrency)+  //CapiResteDu_emp
                                               ';'+
                                               currtostr(FindField('Capitotal_emp').Ascurrency)  //Capitotal_emp
                                               );
                            // end;//fin du with
                                TotCapiResteDu_emp:=TotCapiResteDu_emp+FindField('CapiResteDu_emp').Ascurrency;
                                TotCapitotal_emp:=TotCapitotal_emp+FindField('Capitotal_emp').Ascurrency;
                                inc(Compteur);
                                next;
                        end;//fin du while not QuEmprunt_Edition.eof
                 ListeValeur.Add('3;;; @TOTAL : ;'+E.FormatCurrSansDevise(TotCapiResteDu_emp)+';'+E.FormatCurrSansDevise(TotCapitotal_emp));
                 ListeValeur.Add('8;Nombre total d''Emprunt : '+ inttostr(Compteur));                                                         //

                 ObjPrn.FTitreEdition := ' Description des emprunts d''ouverture :';
                 ObjPrn.FSousTitreEdition:='';
                 ObjPrn.FTitre2Edition :='';
                 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;

                 ListeValeur.Insert(0,' Code emprunt ; Compte ; Libellé ; Capital total; Capital restant dû ');
                 ListeValeur.Insert(1,'1;1;2;1;1;1');
                 ListeValeur.Insert(2,'texte;texte;texte;Curr;Curr');
              end;//fin du with
          end;
          ObjPrn.AffichageImp(ListeValeur);
//  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;


procedure TDMEmprunts.QuRecupEmpruntsSurCptCalcFields(DataSet: TDataSet);
begin
QuRecupEmpruntsSurCpt.findfield('id').Value;
QuRecupEmpruntsSurCpt.findfield('Fini').Value:=EmptyStr;
if(QuRecupEmpruntsSurCptDateFin.AsDateTime<e.DatExoDebut)then
  QuRecupEmpruntsSurCpt.findfield('Fini').Value:='*'
end;



procedure TDMEmprunts.QuRecupEmpruntsSurCptFilterRecordFinis(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
     accept:=QuRecupEmpruntsSurCptDateFin.AsDateTime<e.DatExoDebut;
  end;
end;

procedure TDMEmprunts.QuRecupEmpruntsSurCptFilterRecordEnCours(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=QuRecupEmpruntsSurCptDateFin.AsDateTime>=e.DatExoDebut;
  end;
end;
procedure TDMEmprunts.QuEmprunt_EditionBeforeOpen(DataSet: TDataSet);
begin
DMEmprunts.QuMaxDateEch.Close;
DMEmprunts.QuMaxDateEch.open;
end;

end.


