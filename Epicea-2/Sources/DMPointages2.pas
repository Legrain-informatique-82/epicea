unit DMPointages2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL,E2_Decl_Records,Gr_Librairie_Obj,LibZoneSaisie,E2_Librairie_Obj,
  Lib_Chaine,E2_DetailPointage,Piece,Ecriture_Isa,LibDates,E2_LibInfosTable,
  LibRessourceString,DMRecherche,DMTTVA,E2_ReglementSurListe2,DMPlanCpt,Variants,editions,
  LibFichRep,DMDiocEtatBalance,DMProgramme,
  shellapi,
  DMExports,
  ObjetEdition,DiversProjets,
  ChoixPeriode, ExtCtrls;


type

  TDettesEtCreances=class(TObject)
    compte:string;
    libelle:string;
    date:Tdate;
    Exo:string;
    Dettes:currency;
    DettesEcheance:currency;
    CreancesEcheance:currency;
    Creances:currency;
    ordre:integer;
    constructor Create;
    destructor Destroy;
  end;

Tinfos_Pointage=record
  ID_Debit:integer;
  ID_Credit:integer;
  DateMaitre:Tdate;
  DateEsclave:Tdate;
  MontantDebit:currency;
  MontantCredit:currency;
  MontantPointage:currency;
  Tiers:string;
  RefDebit:string;
  RefCredit:String;
  idPieceDebit:integer;
  idPieceCredit:integer;
end;
Pinfos_Pointage=^Tinfos_Pointage;

  TDMPointage2 = class(TDataModule)
    TaResteDC: TTable;
    TaInfoPointageDebit: TTable;
    DaResteDC: TDataSource;
    TaResteDCReglement: TTable;
    DaResteDCReglement: TDataSource;
    TaResteDCID: TIntegerField;
    TaResteDCID_Ecriture: TIntegerField;
    TaResteDCID_Piece: TIntegerField;
    TaResteDCDate: TDateField;
    TaResteDCReference: TStringField;
    TaResteDCTiers: TStringField;
    TaResteDCLibelle: TStringField;
    TaResteDCDebit: TCurrencyField;
    TaResteDCCredit: TCurrencyField;
    TaResteDCSens: TStringField;
    TaResteDCReste: TCurrencyField;
    TaResteDCLettre: TStringField;
    TaResteDCMontant: TCurrencyField;
    TaResteDCLigne: TIntegerField;
    QuSumPointageCredit: TQuery;
    QuSumPointageDebit: TQuery;
    TaReste: TTable;
    DaPointageAffich: TDataSource;
    QuPointageAffich: TQuery;
    TaPointage: TTable;
    DataPointage: TDataSource;
    TaInfoPointageDebitID: TFloatField;
    TaInfoPointageDebitID_Debit: TIntegerField;
    TaInfoPointageDebitID_Credit: TIntegerField;
    TaInfoPointageDebitDate: TDateField;
    TaInfoPointageDebitMontant: TCurrencyField;
    TaInfoPointageDebitTvaDate: TDateField;
    TaInfoPointageDebitValidation: TDateField;
    TaInfoPointageDebitQui: TStringField;
    TaInfoPointageDebitQuand: TDateTimeField;
    TaInfoPointageCredit: TTable;
    FloatField1: TFloatField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    DateField1: TDateField;
    CurrencyField1: TCurrencyField;
    DateField2: TDateField;
    DateField3: TDateField;
    StringField1: TStringField;
    DateTimeField1: TDateTimeField;
    TaResteDCReglementID: TIntegerField;
    TaResteDCReglementID_Ecriture: TIntegerField;
    TaResteDCReglementID_Piece: TIntegerField;
    TaResteDCReglementDate: TDateField;
    TaResteDCReglementReference: TStringField;
    TaResteDCReglementTiers: TStringField;
    TaResteDCReglementLibelle: TStringField;
    TaResteDCReglementDebit: TCurrencyField;
    TaResteDCReglementCredit: TCurrencyField;
    TaResteDCReglementSens: TStringField;
    TaResteDCReglementReste: TCurrencyField;
    TaResteDCReglementLettre: TStringField;
    TaResteDCReglementMontant: TCurrencyField;
    TaResteDCReglementLigne: TIntegerField;
    TaResteDCReglementAutrePointageDebit: TCurrencyField;
    TaResteDCReglementAutrePointageCredit: TCurrencyField;
    DaInfoPointageDebit: TDataSource;
    DaInfoPointageCredit: TDataSource;
    TaResteDCReglementAutrePointage: TCurrencyField;
    TaPieceRecherche: TTable;
    TaResteDCReglementComptePiece: TStringField;
    TaResteDCReglementTotalReglement: TCurrencyField;
    QuSumPointageDebitID_Debit: TIntegerField;
    QuSumPointageDebitTotalPointeAutre: TCurrencyField;
    QuSumPointageCreditID_Credit: TIntegerField;
    QuSumPointageCreditTotalPointeAutre: TCurrencyField;
    TaResteDCReglementImputation: TCurrencyField;
    TaResteDCReglementImputationDebit: TCurrencyField;
    TaResteDCReglementImputationCredit: TCurrencyField;
    TaResteRecherche: TTable;
    QuRecupListeLettres: TQuery;
    TaResteUpdateLettrage: TTable;
    TaResteDCResteAffich: TCurrencyField;
    TaPointage1: TTable;
    TaAffectReglement: TTable;
    DaAffectReglement: TDataSource;
    TaAffectReglementID: TIntegerField;
    TaAffectReglementID_Ecriture: TIntegerField;
    TaAffectReglementID_Piece: TIntegerField;
    TaAffectReglementDate: TDateField;
    TaAffectReglementReference: TStringField;
    TaAffectReglementTiers: TStringField;
    TaAffectReglementLibelle: TStringField;
    TaAffectReglementDebit: TCurrencyField;
    TaAffectReglementCredit: TCurrencyField;
    TaAffectReglementSens: TStringField;
    TaAffectReglementReste: TCurrencyField;
    TaAffectReglementLettre: TStringField;
    TaAffectReglementMontant: TCurrencyField;
    TaAffectReglementLigne: TIntegerField;
    TaAffectReglementResteAffich: TCurrencyField;
    TaVisuResteDC: TTable;
    TaVisuPointage: TTable;
    DaVisuResteDC: TDataSource;
    DaVisuPointage: TDataSource;
    TaVisuResteDCID: TIntegerField;
    TaVisuResteDCID_Ecriture: TIntegerField;
    TaVisuResteDCID_Piece: TIntegerField;
    TaVisuResteDCDate: TDateField;
    TaVisuResteDCReference: TStringField;
    TaVisuResteDCTiers: TStringField;
    TaVisuResteDCLibelle: TStringField;
    TaVisuResteDCDebit: TCurrencyField;
    TaVisuResteDCCredit: TCurrencyField;
    TaVisuResteDCSens: TStringField;
    TaVisuResteDCReste: TCurrencyField;
    TaVisuResteDCLettre: TStringField;
    TaVisuResteDCMontant: TCurrencyField;
    TaVisuResteDCLigne: TIntegerField;
    TaVisuResteDCImputation: TCurrencyField;
    TaVisuPointageID: TFloatField;
    TaVisuPointageID_Debit: TIntegerField;
    TaVisuPointageID_Credit: TIntegerField;
    TaVisuPointageDate: TDateField;
    TaVisuPointageMontant: TCurrencyField;
    TaVisuPointageTvaDate: TDateField;
    TaVisuPointageValidation: TDateField;
    TaVisuPointageQui: TStringField;
    TaVisuPointageQuand: TDateTimeField;
    TaLookUpVisuPointage_ResteDC: TTable;
    TaVisuPointageReference: TStringField;
    TaVisuPointageLibelle: TStringField;
    TaVisuPointageDatePiece: TDateField;
    TaVisuPointageDebit: TCurrencyField;
    TaVisuPointageCredit: TCurrencyField;
    TaVisuPointageTiers: TStringField;
    TaPointageRecherche: TTable;
    TaResteDCResteDebit: TCurrencyField;
    TaResteDCResteCredit: TCurrencyField;
    TaVisuPointageID_Ecriture: TIntegerField;
    TaResteDCMontantPiece: TCurrencyField;
    QuListeValRupt: TQuery;
    QuTotalG: TQuery;
    TaResteDCSolde: TCurrencyField;
    QuDettesCreance_Edition: TQuery;
    QuDistinctTiers_Edition:TQuery;
    QuSumPointageDansPeriodeDebit_Edition:TQuery;
    QuSumPointageDansPeriodeCredit_Edition:TQuery;
    TaResteDCMontantDebit: TCurrencyField;
    TaResteDCMontantCredit: TCurrencyField;
    QuSoldeDettes: TQuery;
    QuSoldeCreances: TQuery;
    QuControleTiers: TQuery;
    QuDateDeb_Edition: TQuery;
    TaResteDCEcheance: TDateTimeField;
    Requete: TQuery;
    QuSumPointageDansPeriodeDebit_Edition2: TQuery;
    QuSumPointageDansPeriodeCredit_Edition2: TQuery;
    TaResteDCSensSolde: TStringField;
    Function CtrlSaisiePointage(CCourant:TField):TErreurSaisie;
    Function CalculLettrageEnCours(DatasetEnCours:TDataset;Tiers:String;LettrageEnCours:string;ValeurEnCours:currency;Sens:String):TResteDCInfoLettrageEnCours;
    Function LettrageAutomatique(DataSet:TDataSet;Tiers:String;DateDeb,DateFin:TDate;ForcerFiltrage:boolean=false):integer;
    Function LettrageAutomatiqueSurSoldeFin(DataSet:TDataSet;Tiers:String;DateDeb,DateFin:TDate;ForcerFiltrage:boolean=false):integer;

    Function LettrageEnregCourant(DataSet:TDataset;Lettre:string;MontantAffect:currency):boolean;
    Function Gestion_Annulation_Lettrage(DataSet:TDataSet;Lettre,MessStr:string;Confirmer:boolean):boolean;
    procedure DMPointage2Create(Sender: TObject);
    procedure DMPointage2Destroy(Sender: TObject);
    procedure TaResteDCBeforeOpen(DataSet: TDataSet);
    procedure TaResteDCFilterRecordPourPointage(DataSet: TDataSet;
               var Accept: Boolean);
    procedure TaResteDCFilterRecordPourPointageDebit(DataSet: TDataSet;
               var Accept: Boolean);
    procedure TaResteDCFilterRecordPourPointageCredit(DataSet: TDataSet;
               var Accept: Boolean);
    procedure TaResteDCFilterRecordPourPointage_PointeTotal(DataSet: TDataSet;
              var Accept: Boolean);
    procedure TaResteDCFilterRecordPourPointage_PointePartiel(DataSet: TDataSet;
              var Accept: Boolean);
    procedure TaResteDCBeforeInsert(DataSet: TDataSet);
    procedure TaResteDCBeforeDelete(DataSet: TDataSet);
    procedure TaResteDCBeforePost(DataSet: TDataSet);
    procedure TaResteDCFilterRecord(DataSet: TDataSet;
              var Accept: Boolean);
    procedure GestionDuReste(var InfosCreationReste:TInfosCreationReste;SupprPointage:boolean);
    procedure GestionDuResteSurCompte(Tiers:string;idEcriture:integer);
    function FiltragePointageSurEcritureAffich(var Requete:TQuery;IDentifiant:string;TypeIdentifiant:Integer;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointageS;
    procedure QuPointageAffichBeforeInsert(DataSet: TDataSet);
    procedure TaResteDCReglementCalcFields(DataSet: TDataSet);
    procedure QuSumPointageCreditFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuSumPointageDebitFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    function SupprimePointageSurEcriture(RequeteFiltree:Tquery;infosPiece:TStringlist;Indice:integer):integer;
    function FiltragePointageSurEcriture(var Requete:TQuery;IDEcriture:string;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointageS;Overload;
    procedure RemplissageListePointages_SurDataset(var ListeIDEcriture:Tstringlist;var ListePointage:Tstringlist);
    procedure EnregistrementPointages(ListePointage,ListeLettrages:Tstringlist;var ListeID_Pointage:Tstringlist;TiersPointe:string;Gerer_Reste:boolean);Overload;
    Function ValiderPointages(DataSetTaResteDC:TDataSet;TiersPointe:string;Gerer_Reste:boolean):boolean;
    Function RecupListeLettre_surDataset(DataSet: TDataSet;ListeLettre:boolean):TResultStrList;
    procedure SuppressionLettrage_Enreg_Courant(DataSet:TDataSet);
    procedure SuppressionLettrage_ApresGestionDesPointages(DataSetAMettreAJour:TDataSet;lettreASupprimer:string;ListePointage:Tstringlist=nil);
    procedure SuppressionLettrage_Tous_ApresGestionDesPointages(DataSetAMettreAJour:TDataSet;liste_lettre:Tstringlist);
    procedure RecupListeIDEcriturePointages_SurDataset(var ListeIDEcriture:Tstringlist;liste_lettre:Tstringlist);
    procedure TaResteDCAfterPost(DataSet: TDataSet);
    procedure TaResteDCCalcFields(DataSet: TDataSet);
    procedure QuPointageAffichCalcFields(DataSet: TDataSet);
    procedure TaPointage1BeforeDelete(DataSet: TDataSet);
    Procedure SuppressionTousPointage_SurID_Appelant(Id_Appelant:Integer;Reference:string;Confirmer:boolean);
    Procedure SuppressionPointage(DataSetAffich:TDataSet;Confirmer:boolean);
    procedure TaAffectReglementCalcFields(DataSet: TDataSet);
    Function InitTableVisuPointage(Tiers : string;ID_Ecriture:Integer;DateDeb,DateFin:TDate;Journal:string):boolean;
    procedure TaVisuResteDCAfterScroll(DataSet: TDataSet);
    procedure TaVisuResteDCCalcFields(DataSet: TDataSet);
    procedure TaVisuPointageCalcFields(DataSet: TDataSet);
    procedure TaVisuPointageBeforeOpen(DataSet: TDataSet);
    procedure TaVisuResteDCAfterOpen(DataSet: TDataSet);
    procedure TaVisuPointageAfterOpen(DataSet: TDataSet);
    procedure TaVisuResteDCBeforeInsert(DataSet: TDataSet);
    procedure TaVisuPointageBeforeInsert(DataSet: TDataSet);
    Function InfosPointageSurResteDC(ID_Ecriture:Integer):TInfoResteDCSurEcriture;
    function SupprimeResteSurIDEcriture(IDEcriture:integer):boolean;
    function CalculResteSurIDEcriture(IDEcriture:integer;Tiers:string):TReste;
    procedure TaAffectReglementAfterEdit(DataSet: TDataSet);
    Function ModifLettrageEnregCourant(DataSet:TDataset;Lettre:string):boolean;
//    function Verification_TvaDeclare_Pointage(Suppression:boolean;IDEcriture_Debit,IDEcriture_Credit:integer):TerreurTva;
    procedure TaPointage1BeforePost(DataSet: TDataSet);
    function ListResteAffect_IndexOf(valeur:array of string;valeurRech:array of integer;Liste:Tlist):integer;
    procedure TaResteDCBeforeEdit(DataSet: TDataSet);
    procedure Initialisation_Liste;
    procedure TaAffectReglementBeforeDelete(DataSet: TDataSet);
    function TotalImputation_IDReste(idReste,ID_Appelant:integer):currency;
    procedure TaPointageBeforeDelete(DataSet: TDataSet);
    procedure TaPointageBeforePost(DataSet: TDataSet);
    function RecupListeLettreExclu_SurJournal(JournalExclu:array of string;lettreLike:string):Tstringlist;
    procedure TaAffectReglementBeforePost_PourAffectReglement(DataSet: TDataSet);
    procedure TaAffectReglementAfterPost_PourAffectReglement(DataSet: TDataSet);
    Function CtrlSaisiePointage_PourAffectReglement(CCourant:TField):TErreurSaisie;
    procedure TaCompteFilterRecordComptePointable(DataSet: TDataSet; var Accept: Boolean);
    Procedure FiltreDettesEtCreancesSurJournal(var Dataset:TDataset;ListeExclue:array of string;SensReglement:integer;Tiers_:string;MontantARegler:currency);

    procedure RemplissageListePointages_SurDataset_EtLettrage(ListeLettre:Tstringlist;var ListePointage:Tstringlist);
    procedure TaVisuResteDCFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaResteDCReglementBeforeOpen(DataSet: TDataSet);
    procedure QuDettesCreance_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuDettesCreance_EditionFilterRecord2(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaResteUpdateLettrageFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaResteUpdateLettrageBeforeOpen(DataSet: TDataSet);
    procedure TaResteUpdateLettrageAfterClose(DataSet: TDataSet);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    ListeDettesAffich:Tstringlist;
    ListecompteAffich:Tstringlist;
    ListeTiersAffich:Tstringlist;
    TypeDettes:string;
    IDEcritureAppelanteLoc:integer;
    LettrageEnCours,SensPiece:string;
    ForceLettrage:string;
    supprODDeclaration:boolean;
    MontantTmp:currency;
    ListeID_Appelant:Tlist;
    ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
    FiltrePourSolde:string;
        function FiltragePointageSurEcriture(IDEcriture:string;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointages;Overload;
//    procedure EnregistrementPointages(ListePointage:Tstringlist;var ListeID_Pointage:Tstringlist;Gerer_Reste:boolean);Overload;
  end;
    function CreationPointageSurIDEcriture(InfosPointage:Tinfos_Pointage;TiersTmp:string;GererReste:boolean):TExceptLGR_ImportPiece;overload;
    function CreationPointageSurIDEcriture(var TabID:Variant;TiersTmp:string;GererReste:boolean):TExceptLGR_ImportPiece;overload;
     procedure initialise_TInfosPointage(var infosPointage:Pinfos_Pointage);
var
  DMPointage2: TDMPointage2;
  ListeLettreUtil:TStringList;
  ListeEcritureFilterRecord:Tstringlist;
  LettreSaisie:String;
  ImputationTmp:currency;
  TiersDemande:string;
  TiersCalcSolde,filtre:string;     //pour edition dette et creance
  Solde:Currency;                   //pour edition dette et creance
  ListeIdDC,ListeSolde:TStringList; //pour edition dette et creance


  Function RecupDetteCreance(FiltreParam:string;Cpt,Sens:string;JournalExclu:array of string;DateDeb,DateFin:TDate;MontantResteMini,MontantResteMaxi:currency;ListeLettreExclue:TStringList;GereDataSet:Boolean;Dataset:TDataset=nil):TInfoResteDCSurCompte;
  procedure CreationReste(Max,ID,IDPiece:integer;Date:Tdate;Ref,Tiers,Libelle,Lettre:string;sens:boolean;Debit,Credit,reste,montant:currency);
  Function DetailPointageAffich(TiersCourant,Id_Identifiant:string;TypeIdentifiant:integer;affich:boolean;Suppression_Accept:boolean):boolean;
  Function RecupPointagePourReglement(Cpt,Sens,Journal:string;ID_Journal:array of string;DateDeb,DateFin:TDate;Option:integer;IDEcritureAppelante:integer):TInfoResteDCSurCompte;
  Function AffectReglementAffiche(DataSetOrg:TDataSet;TraiterDataSetOrg,GererListe:Boolean;Tiers_,Lettre,SensLigneAppel : string; var MontantAPointer:currency;DateDeb,DateFin:TDate;ListeLettreExclue:TStringList;ParametreAppelant:TParamAffichPointage;Acces:boolean=true):boolean;
  Function GestionAffichagePointageSurRef(Pointage_Auto:boolean;AnnulerSiLettrageEnCours:boolean;ParamAffichPointage:TParamAffichPointage;Acces:boolean=true):Boolean;
  Function GestionAffichagePointageSurCompte(ParamAffichPointage:TParamAffichPointage;Acces:boolean=true):Boolean;
  procedure Lettrage_Sur_Liste_Affich(AnnulerSiLettrageEnCours:boolean;Dataset:TTable;ListeReglement:Tlist;Affich,confirmValidation:boolean;lettre:string);
  procedure ListResteAffect__Add_Insert(var Liste:Tlist;Valeur:array of const;Add,Remplace:boolean;Rang:integer);


  Function EditionDetteCreanceL(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:TStringList;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean=false;ListeExclu:Tstringlist=nil;TypeDettes:string=''):Boolean;overload;
  Function EditionDetteCreanceL(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:String;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean=false;ListeExclu:Tstringlist=nil;TypeDettes:String=''):Boolean;overload;
  Function EditionDetteCreanceL_affinee(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:String;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean=false;ListeExclu:Tstringlist=nil;TypeDettes:String=''):Boolean;overload;
  Function EditionDetteCreanceL_affinee(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:TStringList;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean=false;ListeExclu:Tstringlist=nil;TypeDettes:string=''):Boolean;overload;
  Function EditionDetteCreanceL_affineeEcheance(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:String;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean=false;ListeExclu:Tstringlist=nil;TypeDettes:String=''):Boolean;overload;
  Function EditionDetteCreanceL_affineeEcheance(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:TStringList;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean=false;ListeExclu:Tstringlist=nil;TypeDettes:string=''):Boolean;overload;

//  Function TableauDetteCreance( DemandePeriode:Boolean; CompteDeTiers:TStringList;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string):Tstringlist;
  Function TableauEvolutionAnnuelleDetteCreance( CompteDeTiers:TStringList;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string;Regrouper : integer;exercice:TExercice;ExoCourant:integer):Tstringlist;
  Function TableauEvolutionMensuelleDetteCreance(DemandePeriode:Boolean; ListeParDate:Tstringlist):Tstringlist;

  function listeDettesEtCreancesSurPeriode(DemandePeriode:Boolean; CompteDeTiers:TStringList;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string;ordre:integer; Regrouper : integer):Tstringlist;
  function TriListe(LaListe: TStringList; Index1, Index2: Integer): Integer;
implementation

uses DMEcriture,DMPiece,ObjReglement, DMBalances, E2_AffectReglement,
  DMJournaux, E2_SaisieReglement, E2_VisuPointage, E2_Pointages2,
  E2_ReglementSurListe,DMTier,E2_Patientez,Printers,
   DmTableauBord;

{$R *.DFM}


Function EditionDetteCreanceL_affinee(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:string;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (CompteDeTiers)then
     begin
       Maliste.Add(CompteDeTiers);
     end
   else
     raise ExceptLGR.Create('Aucun compte n''est defini !',1000,true,mtError,Retour);
   EditionDetteCreanceL_affinee(TypeEdition,DemandePeriode,Maliste,DataSet,SautDePage,Relance,precision,ListeExclu,TypeDettes);
  except
     abort;
  end;
end;

Function EditionDetteCreanceL_affineeEcheance(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:string;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (CompteDeTiers)then
     begin
       Maliste.Add(CompteDeTiers);
     end
   else
     raise ExceptLGR.Create('Aucun compte n''est defini !',1000,true,mtError,Retour);
   EditionDetteCreanceL_affineeEcheance(TypeEdition,DemandePeriode,Maliste,DataSet,SautDePage,Relance,precision,ListeExclu,TypeDettes);
  except
     abort;
  end;
end;

Function EditionDetteCreanceL(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:string;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (CompteDeTiers)then
     begin
       Maliste.Add(CompteDeTiers);
     end
   else
     raise ExceptLGR.Create('Aucun compte n''est defini !',1000,true,mtError,Retour);
   EditionDetteCreanceL(TypeEdition,DemandePeriode,Maliste,DataSet,SautDePage,Relance,precision,ListeExclu,TypeDettes);
  except
     abort;
  end;
end;

Function EditionDetteCreanceL(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:TStringList;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string):Boolean;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeRelance:TStringList;
MontantTotal,DEjaRegle,Creance,Dette,Solde,TotalMouvementDette,TotalMouvementCreance:Currency;
TotalMvtCreanteTiers,TotalMvtDetteTiers,Reste,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
SoldeMouvementDette,SoldeMouvementCreance:Currency;
ParamAffichPeriode:TParamAffichPeriode;
LibelleCorrect:string;
Requete:TQuery;
CompteDeTiersTmp,CompteTmp,NomTiers:string;
compteRempli,compteCollectifRempli:boolean;
begin

//TypeDettes='' -> Dettes et Créances
//TypeDettes='C' -> Dettes
//TypeDettes='D' -> Créances
//ListeExclu = liste des journaux exclu

try//finally
    PatienterAffich();
    ObjPrn:=TObjetEdition.Create(application.MainForm);
       Initialise_ParamAffichPeriode(ParamAffichPeriode);

Requete:=TQuery.Create(application.MainForm);
Requete.SQL.Clear;
//
//select min(ResteDC."Date") as DateDebDebite
//from ResteDC rd where reste<>0 or(
//((reste=0 and rd.sens='D' and  rd.id_ecriture  in (select id_debit from pointage p where P."Date" >'12/31/2005')))
//or((reste=0 and rd.sens='C' and  rd.id_ecriture  in(select id_credit from pointage p where P."TvaDate" >'12/31/2005'))))
//
Requete.SQL.Add(' select min(ResteDC."Date") as DateDeb');
Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd where reste<>0 ');
if (not precision) then
  begin
      if not relance then
        showmessage('Attention !!!, cette édition tient compte des réglements de l''exercice N+1');
      DemandePeriode:=false;
  end
else
  begin
      Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" >:DateFin)))');
      Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" >:DateFin))))');
      Requete.ParamByName('DateFin').AsDate := e.DatExoFin;
  end;

Requete.open;
if ((requete.recordcount<>0)and(not empty(Requete.findfield('DateDeb').Asstring)))then
  periode.DateDeb:=Requete.findfield('DateDeb').AsDateTime
else
  periode.DateDeb:=e.DatExoDebut;

Requete.Close;

  if DemandePeriode then
    Begin
       periode:=ChoixPeriodeAffich(periode.DateDeb,E.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeRelance:=TStringList.Create;
    if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
DMPointage2.TypeDettes:=TypeDettes;
if ListeExclu=nil then
  Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false)
else
  if DMPointage2.ListeDettesAffich.ClassInfo<>ListeExclu.ClassInfo then
  begin
    Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false);
    for i:=0 to ListeExclu.count-1 do
      DMPointage2.ListeDettesAffich.Add(ListeExclu.strings[i]);
  end;

  DMPointage2.QuDettesCreance_Edition.Close;
DMPointage2.QuDettesCreance_Edition.Filter:='';
DMPointage2.QuDettesCreance_Edition.Filtered:=false;
  DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
  DMPointage2.QuDettesCreance_Edition.filtered:=true;
  DMPointage2.QuDettesCreance_Edition.sql.Clear;
  DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,R.Tiers,T.Nom,R.Sens');
  DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
  DMPointage2.QuDettesCreance_Edition.sql.Add(' left join tiers T on (r.tiers=T.tiers)');
  DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
  DMPointage2.QuDettesCreance_Edition.sql.Add(' join Ecriture E on (E.id=R.id_Ecriture)');
  DMPointage2.QuDettesCreance_Edition.sql.Add(' where  R."Date" between :DateDeb and  :DateFin');
  DMPointage2.QuDettesCreance_Edition.sql.Add(' and  upper(E.typeligne) =''X''');
  if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and R.reste<>0');
    DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,R.tiers');

      SoldeMouvementDette:=0;
      SoldeMouvementCreance:=0;
      TotalMouvementDette:=0;
      TotalMouvementCreance:=0;

    if CompteDeTiers=nil then
     // Tous les Compte de Tiers
     begin
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Prepare;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;
      CompteDeTiers:=Tstringlist.Create;
      CompteDeTiers.Sorted:=True;
      CompteDeTiers.Duplicates:=dupIgnore;
      while not DMPointage2.QuDettesCreance_Edition.Eof do
        Begin
          if (empty(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString)) and (str_commence_par(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString,'+')=false)then
            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString)
          else
            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString);
          DMPointage2.QuDettesCreance_Edition.Next;
        end;
      DMPointage2.QuDettesCreance_Edition.close;
      DMPointage2.QuDettesCreance_Edition.sql.Clear;
      DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' join Ecriture E on (E.id=R.id_Ecriture)');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' where (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and R."Date" between :DateDeb and  :DateFin');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' and  upper(E.typeligne) =''X''');
      if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,R."Date",Reference');

     ListeRelance.Add('Id_Ecriture'+
                     ';'+
                     'Id_Piece'+
                     ';'+
                     'DAte'+
                     ';'+
                     'Reference'+
                     ';'+
                     'Tiers'+
                     ';'+
                     'Libelle'+
                     ';'+
                     'Sens'+
                     ';'+
                     'MontantTotal'+ //
                     ';'+
                     'DejaRegle'+ // Deja Reglé
                     ';'+
                     'Creance'+  // Créances
                     ';'+
                     'Dette'+  // Dettes
                     ';'+
                     'Nom Tiers'+
                     ';'+
                     'Adresse1'+
                     ';'+
                     'Adresse2'+
                     ';'+
                     'Code Postal'+
                     ';'+
                     'ville'+
                     ';'+
                     'Pays');
compteCollectifRempli:=false;
      if CompteDeTiers.count<>0 then
        begin//si il y a des dettes ou creances dans période
           for i:=0 to CompteDeTiers.count-1 do
             begin
                Solde :=0;
                TotalMvtCreanteTiers:=0;
                TotalMvtDetteTiers:=0;
                CompteTmp:=GetStringElement(CompteDeTiers.strings[i],1,';');
                CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],2,';');
                if str_commence_par(CompteDeTiersTmp,'+')then
                  begin
                    NomTiers:=GetStringElement(CompteDeTiers.strings[i],3,';');
                  end
                else
                  begin
                    NomTiers:=dmplan.LibelleDuNumCptPCU(CompteDeTiersTmp);
                  end;
                DMPointage2.QuDettesCreance_Edition.Close;
                DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := GetStringElement(CompteDeTiers.strings[i],1,';');
                DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
                DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
                DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
                DMPointage2.QuDettesCreance_Edition.Open;
                DMPointage2.QuDettesCreance_Edition.First;
                if DMPointage2.QuDettesCreance_Edition.recordcount=0 then
                  CompteDeTiersTmp:='';
                compteRempli:=false;
                while not DMPointage2.QuDettesCreance_Edition.Eof do
                  begin
                   if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
                    else
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
                    // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
                    // les dates de pièce sont antérieures à la date de fin de période
                    // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //              DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;

                    if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                     Begin
                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition.findfield('MontantPointeCredit').AsCurrency;
                       Dette:=MontantTotal - DejaRegle;
                       TotalMouvementDette:=Dette+ TotalMouvementDette;
                       TotalMvtDetteTiers:=Dette+ TotalMvtDetteTiers;
                       TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
                       SoldeMouvementDette:=Dette+SoldeMouvementDette;
                       Creance :=0;
                     end
                    else
                      begin
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition.findfield('MontantPointeDebit').AsCurrency;
                        Creance:=MontantTotal - DejaRegle;
                        TotalMouvementCreance:=Creance + TotalMouvementCreance;
                        TotalMvtCreanteTiers:=Creance + TotalMvtCreanteTiers;
                        TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
                        SoldeMouvementCreance:=Creance+SoldeMouvementCreance;
                        Dette:=0;
                      end;

                   Solde := Creance - Dette + Solde;
                   if DejaRegle <> MontantTotal then
                   begin //si solde <> 0 on rempli dans la liste
                     if compteRempli=false then
                       begin
                          ListeValeur.Add('9;COMPTE DE TIERS : '+GereLibelle(CompteDeTiersTmp)+' - '+CompteTmp+' - '+GereLibelle(NomTiers));
                          compteRempli:=true;
                          compteCollectifRempli:=true;
                       end;
                   LibelleCorrect:=str_remplacesouschaine(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString,';',',');
                   ListeValeur.Add('0'+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('DAte').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+ // Créances
                                   ';'+
                                   CurrToStr(Dette)+ // Dettes
                                   ';'+
                                   CurrToStr(Solde) // Soldes
                                   );
                 ///////
                 ListeRelance.Add(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').Asstring+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.findfield('Id_Piece').Asstring+
                                 ';'+
                                 dateinfos(DMPointage2.QuDettesCreance_Edition.FindField('DAte').AsDateTime).DateStrFormat+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                 ';'+
                                 GereLibelle(CompteDeTiersTmp)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                 ';'+
                                 CurrToStr(arrondi(MontantTotal,2))+ //
                                 ';'+
                                 CurrToStr(arrondi(DejaRegle,2))+ // Deja Reglé
                                 ';'+
                                 CurrToStr(arrondi(Creance,2))+  // Créances
                                 ';'+
                                 CurrToStr(arrondi(Dette,2))+  // Dettes
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Nom').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse1').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse2').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Poste').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('ville').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Pays').Asstring)
                                 );
                   end;//si solde <>0
                   DMPointage2.QuDettesCreance_Edition.Next;
                  end;
                if (CompteDeTiersTmp<>'') and (compteRempli) then
                  ListeValeur.Add('4;;; @Tiers : '+GereLibelle(CompteDeTiersTmp)+' ;;; @TOTAL DES MOUVEMENTS ;'+CurrToStr(TotalMvtCreanteTiers) +';'+CurrToStr(TotalMvtDetteTiers)+'; ');
                if (i<CompteDeTiers.count-1)and (compteCollectifRempli) and(CompteTmp<>GetStringElement(CompteDeTiers.strings[i+1],1,';'))then
                    begin//changement de compte collectif, donc totaux
                      DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
                      ListeValeur.Add('1;;;@Collectif : '+CompteTmp+' ;;;@SOLDE ;'+CurrToStr(TotalMouvementCreanceCollectif) +';'+CurrToStr(TotalMouvementDetteCollectif)+'; ');
                      TotalMouvementDetteCollectif:=0;
                      TotalMouvementCreanceCollectif:=0;
                      compteCollectifRempli:=false;
                      if(SautDePage)then listeValeur.add('20');
                    end;
             end;//fin parcours liste des comptes
            if (CompteTmp<>'')and (compteCollectifRempli)then
              begin
              DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
              ListeValeur.Add('1;;;@Collectif : '+CompteTmp+' ;;;@SOLDE ;'+CurrToStr(TotalMouvementCreanceCollectif) +';'+CurrToStr(TotalMouvementDetteCollectif)+'; ');
              TotalMouvementDetteCollectif:=0;
              TotalMouvementCreanceCollectif:=0;
              end;
           if ListeValeur.Count<>0 then
           begin
             // if(SautDePage)then ListeValeur.add('20');
              ListeValeur.Add('2;;; @;;; @TOTAL GLOBAL ;'+CurrToStr(SoldeMouvementCreance) +';'+CurrToStr(SoldeMouvementDette)+'; ');
              DetermineSolde(SoldeMouvementDette,SoldeMouvementCreance);
              ListeValeur.Add('1;;; @;;; @SOLDE ;'+CurrToStr(SoldeMouvementCreance) +';'+CurrToStr(SoldeMouvementDette)+'; ');
           ObjPrn.FTitreEdition := 'DETTES ET CREANCES DES TIERS';
           ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
           ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ListeValeur.Insert(0,' Date ;Réf. Pièce ; Désignation ; ; Mtant Total ; Déjà Réglé ; Créances ; Dettes ; Soldes ');
           ListeValeur.Insert(1,'0.6;0.8;2;0.1;0.8;0.8;0.8;0.8;0.8');
           ListeValeur.Insert(2,'texte;texte;texte;texte;curr;curr;curr;curr;curr');
           end;
       end;//fin si il y a des dettes ou creances dans période
     if Relance then
       begin
           try
             ExportRelanceDesTiers(ListeRelance);
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
     end
    else
     // un seul tiers
     begin
      CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[0],1,';');
      if str_commence_par(CompteDeTiersTmp,'+')then
        begin
          CompteTmp:=DMTiers.CptDuTiers(CompteDeTiersTmp);
          NomTiers:=DMTiers.LibelleDuTiers(CompteDeTiersTmp);
        end
      else
        begin
          CompteTmp:=CompteDeTiersTmp;
          NomTiers:=DMPlan.LibelleDuNumCptPCU(comptetmp);
        end;
      Solde :=0;
      compteRempli:=false;
      TotalMouvementDette:=0;
      TotalMouvementCreance:=0;
      DMPointage2.QuDettesCreance_Edition.close;
      DMPointage2.QuDettesCreance_Edition.sql.Clear;
DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
DMPointage2.QuDettesCreance_Edition.sql.Add(' where (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and R."Date" between :DateDeb and  :DateFin');
DMPointage2.QuDettesCreance_Edition.sql.Add(' and  upper(E.typeligne) =''X''');
if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,R."Date",Reference');


      DMPointage2.QuDettesCreance_Edition.Close;
      DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := CompteTmp;
      DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;
      if DMPointage2.QuDettesCreance_Edition.recordcount<>0 then
        begin//si il y a des dettes ou creances dans période
              while not DMPointage2.QuDettesCreance_Edition.Eof do
                begin
                 if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
                 else
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
                  // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
                  // les dates de pièce sont antérieures à la date de fin de période
                  // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;

                  if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                   Begin
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
                     DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition.findfield('MontantPointeCredit').AsCurrency;
                     Dette:=MontantTotal - DejaRegle;
                     TotalMouvementDette:=Dette+ TotalMouvementDette;
                     Creance :=0;
                   end
                  else
                    begin
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition.findfield('MontantPointeDebit').AsCurrency;
                      Creance:=MontantTotal - DejaRegle;
                      TotalMouvementCreance:=Creance + TotalMouvementCreance;
                      Dette:=0;
                    end;

                 Solde := Creance - Dette + Solde;
                 if DejaRegle <> MontantTotal then
                   begin //si solde <> 0 on rempli dans la liste
                     if compteRempli=false then
                       begin
                          ListeValeur.Add('9;COMPTE DE TIERS : '+GereLibelle(CompteDeTiersTmp)+'-'+CompteTmp+' - '+GereLibelle(NomTiers));
                          compteRempli:=true;
                       end;
                   ListeValeur.Add('0'+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('DAte').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+ // Créances
                                   ';'+
                                   CurrToStr(Dette)+ // Dettes
                                   ';'+
                                   CurrToStr(Solde) // Soldes
                                   );
                   ///////
                   ListeRelance.Add(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').Asstring+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.findfield('Id_Piece').Asstring+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('DAte').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   GereLibelle(CompteDeTiersTmp)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+ //
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+  // Créances
                                   ';'+
                                   CurrToStr(Dette)+  // Dettes
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Nom').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse1').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse2').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Poste').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('ville').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Pays').Asstring)
                                   );
                   end;
                 DMPointage2.QuDettesCreance_Edition.Next;
                end;
         ObjPrn.FTitreEdition := 'DETTES ET CREANCES DES TIERS';
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ListeValeur.Insert(0,' Date ;Réf. Pièce ; Désignation ; ; Mtant Total ; Déjà Réglé ; Créances ; Dettes ; Soldes ');
         ListeValeur.Insert(1,'0.6;0.8;2;0.1;0.8;0.8;0.8;0.8;0.8');
         ListeValeur.Insert(2,'texte;texte;texte;texte;curr;curr;curr;curr;curr');
         //ListeValeur.Insert(3,'8;Compte de Tiers : '+CompteDeTiersTmp);
         ListeValeur.Add('4;;; @Tiers : '+CompteDeTiersTmp+' ;;; @TOTAL DES MOUVEMENTS ;'+CurrToStr(TotalMvtCreanteTiers) +';'+CurrToStr(TotalMouvementDette)+'; ');
              DetermineSolde(TotalMouvementDette,TotalMouvementCreance);
              ListeValeur.Add('1;;;@Collectif : '+CompteTmp+' ;;;@SOLDE ;'+CurrToStr(TotalMouvementCreance) +';'+CurrToStr(TotalMouvementDette)+'; ');
        end;//fin si il y a des dettes ou creances dans période
     if Relance then
       begin
           try
           ExportRelanceDesTiers(ListeRelance);
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;
   end;
finally
PatienterFermer();
Initialise_TStringlist(CompteDeTiers,DMPointage2);
DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;
DMPointage2.QuDettesCreance_Edition.filtered:=false;
DMPointage2.QuDettesCreance_Edition.close;
LibereObjet(TObject(Requete));
LibereObjet(TObject(ObjPrn));
end;
End;


Function EditionDetteCreanceL_affinee(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:TStringList;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string):Boolean;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeRelance:TStringList;
MontantTotal,DEjaRegle,Creance,Dette,Solde,TotalMouvementDette,TotalMouvementCreance:Currency;
TotalMvtCreanteTiers,TotalMvtDetteTiers:Currency;
Reste,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
SoldeMouvementDette,SoldeMouvementCreance:Currency;
ParamAffichPeriode:TParamAffichPeriode;
LibelleCorrect:string;
Requete:TQuery;
CompteDeTiersTmp,CompteTmp,NomTiers:string;
compteRempli,compteCollectifRempli:boolean;
begin

//TypeDettes='' -> Dettes et Créances
//TypeDettes='C' -> Dettes
//TypeDettes='D' -> Créances
//ListeExclu = liste des journaux exclu

try//finally
    PatienterAffich();
    ObjPrn:=TObjetEdition.Create(application.MainForm);
       Initialise_ParamAffichPeriode(ParamAffichPeriode);

Requete:=TQuery.Create(application.MainForm);
Requete.SQL.Clear;
//
//select min(ResteDC."Date") as DateDebDebite
//from ResteDC rd where reste<>0 or(
//((reste=0 and rd.sens='D' and  rd.id_ecriture  in (select id_debit from pointage p where P."Date" >'12/31/2005')))
//or((reste=0 and rd.sens='C' and  rd.id_ecriture  in(select id_credit from pointage p where P."TvaDate" >'12/31/2005'))))
//
Requete.SQL.Add(' select min(ResteDC."Date") as DateDeb');
Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd where reste<>0 ');
if (not precision) then
  begin
      if not relance then
        showmessage('Attention !!!, cette édition tient compte des réglements de l''exercice N+1');
      DemandePeriode:=false;
  end
else
  begin
      Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" >:DateFin)))');
      Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" >:DateFin))))');
      Requete.ParamByName('DateFin').AsDate := e.DatExoFin;
  end;

Requete.open;
if ((requete.recordcount<>0)and(not empty(Requete.findfield('DateDeb').Asstring)))then
  periode.DateDeb:=Requete.findfield('DateDeb').AsDateTime
else
  periode.DateDeb:=e.DatExoDebut;

Requete.Close;

  if DemandePeriode then
    Begin
       periode:=ChoixPeriodeAffich(periode.DateDeb,E.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeRelance:=TStringList.Create;
    if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
DMPointage2.TypeDettes:=TypeDettes;
if ListeExclu=nil then
  Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false)
else
  if DMPointage2.ListeDettesAffich.ClassInfo<>ListeExclu.ClassInfo then
  begin
    Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false);
    for i:=0 to ListeExclu.count-1 do
      DMPointage2.ListeDettesAffich.Add(ListeExclu.strings[i]);
  end;

  DMPointage2.QuDettesCreance_Edition.Close;
DMPointage2.QuDettesCreance_Edition.Filter:='';
DMPointage2.QuDettesCreance_Edition.Filtered:=false;
  DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
  DMPointage2.QuDettesCreance_Edition.filtered:=true;
  DMPointage2.QuDettesCreance_Edition.sql.Clear;
  DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,R.Tiers,T.Nom,R.Sens');
  DMPointage2.QuDettesCreance_Edition.sql.Add('from ResteDC R');
  DMPointage2.QuDettesCreance_Edition.sql.Add('left join tiers T on (r.tiers=T.tiers)');
  DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
  DMPointage2.QuDettesCreance_Edition.sql.Add('where  R."Date" between :DateDeb and  :DateFin');
  if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and R.reste<>0');
    DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,R.tiers');

      SoldeMouvementDette:=0;
      SoldeMouvementCreance:=0;
      TotalMouvementDette:=0;
      TotalMouvementCreance:=0;

    if CompteDeTiers=nil then
     // Tous les Comptes de Tiers
     begin
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Prepare;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;
      CompteDeTiers:=Tstringlist.Create;
      CompteDeTiers.Sorted:=True;
      CompteDeTiers.Duplicates:=dupIgnore;
      while not DMPointage2.QuDettesCreance_Edition.Eof do
        Begin
          if (empty(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString)) and (str_commence_par(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString,'+')=false)then
            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString)
          else
            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString);
          DMPointage2.QuDettesCreance_Edition.Next;
        end;
      end;

    if (CompteDeTiers<>nil)and (CompteDeTiers.count>1) then //si plus d'un tiers
     begin
      DMPointage2.QuDettesCreance_Edition.close;
      DMPointage2.QuDettesCreance_Edition.sql.Clear;
      DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' where (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and R."Date" between :DateDeb and  :DateFin');
      if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,R."Date",Reference');

     ListeRelance.Add('Id_Ecriture'+
                     ';'+
                     'Id_Piece'+
                     ';'+
                     'DAte'+
                     ';'+
                     'Reference'+
                     ';'+
                     'Tiers'+
                     ';'+
                     'Libelle'+
                     ';'+
                     'Sens'+
                     ';'+
                     'MontantTotal'+ //
                     ';'+
                     'DejaRegle'+ // Deja Reglé
                     ';'+
                     'Creance'+  // Créances
                     ';'+
                     'Dette'+  // Dettes
                     ';'+
                     'Nom Tiers'+
                     ';'+
                     'Adresse1'+
                     ';'+
                     'Adresse2'+
                     ';'+
                     'Code Postal'+
                     ';'+
                     'ville'+
                     ';'+
                     'Pays');
compteCollectifRempli:=false;
      if CompteDeTiers.count<>0 then
        begin//si il y a des dettes ou creances dans période
           for i:=0 to CompteDeTiers.count-1 do
             begin
                Solde :=0;
                TotalMvtCreanteTiers:=0;
                TotalMvtDetteTiers:=0;
                CompteTmp:=GetStringElement(CompteDeTiers.strings[i],1,';');
                CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],2,';');
                if str_commence_par(CompteDeTiersTmp,'+')then
                  begin
                    NomTiers:=GetStringElement(CompteDeTiers.strings[i],3,';');
                  end
                else
                  begin
                    NomTiers:=dmplan.LibelleDuNumCptPCU(CompteDeTiersTmp);
                  end;
                DMPointage2.QuDettesCreance_Edition.Close;
                DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := GetStringElement(CompteDeTiers.strings[i],1,';');
                DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
                DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
                DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
                DMPointage2.QuDettesCreance_Edition.Open;
                DMPointage2.QuDettesCreance_Edition.First;
                if DMPointage2.QuDettesCreance_Edition.recordcount=0 then
                  CompteDeTiersTmp:='';
                compteRempli:=false;
                while not DMPointage2.QuDettesCreance_Edition.Eof do
                  begin
                   if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
                    else
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
                    // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
                    // les dates de pièce sont antérieures à la date de fin de période
                    // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //              DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;

                    if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                     Begin
                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition.findfield('MontantPointeCredit').AsCurrency;
                       Dette:=MontantTotal - DejaRegle;
                       TotalMouvementDette:=Dette+ TotalMouvementDette;
                       TotalMvtDetteTiers:=Dette+ TotalMvtDetteTiers;
                       TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
                       SoldeMouvementDette:=Dette+SoldeMouvementDette;
                       Creance :=0;
                     end
                    else
                      begin
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition.findfield('MontantPointeDebit').AsCurrency;
                        Creance:=MontantTotal - DejaRegle;
                        TotalMouvementCreance:=Creance + TotalMouvementCreance;
                        TotalMvtCreanteTiers:=Creance + TotalMvtCreanteTiers;
                        TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
                        SoldeMouvementCreance:=Creance+SoldeMouvementCreance;
                        Dette:=0;
                      end;

                   Solde := Creance - Dette + Solde;
                   if DejaRegle <> MontantTotal then
                   begin //si solde <> 0 on rempli dans la liste
                     if compteRempli=false then
                       begin
                          ListeValeur.Add('9;COMPTE DE TIERS : '+GereLibelle(CompteDeTiersTmp)+' - '+CompteTmp+' - '+GereLibelle(NomTiers));
                          compteRempli:=true;
                          compteCollectifRempli:=true;
                       end;
                   LibelleCorrect:=str_remplacesouschaine(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString,';',',');
                   ListeValeur.Add('0'+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('DAte').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+ // Créances
                                   ';'+
                                   CurrToStr(Dette)+ // Dettes
                                   ';'+
                                   CurrToStr(Solde) // Soldes
                                   );
                 ///////
                 ListeRelance.Add(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').Asstring+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.findfield('Id_Piece').Asstring+
                                 ';'+
                                 dateinfos(DMPointage2.QuDettesCreance_Edition.FindField('DAte').AsDateTime).DateStrFormat+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                 ';'+
                                 GereLibelle(CompteDeTiersTmp)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                 ';'+
                                 CurrToStr(arrondi(MontantTotal,2))+ //
                                 ';'+
                                 CurrToStr(arrondi(DejaRegle,2))+ // Deja Reglé
                                 ';'+
                                 CurrToStr(arrondi(Creance,2))+  // Créances
                                 ';'+
                                 CurrToStr(arrondi(Dette,2))+  // Dettes
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Nom').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse1').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse2').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Poste').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('ville').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Pays').Asstring)
                                 );
                   end;//si solde <>0
                   DMPointage2.QuDettesCreance_Edition.Next;
                  end;
                if (CompteDeTiersTmp<>'') and (compteRempli) then
                  ListeValeur.Add('4;;; @Tiers : '+GereLibelle(CompteDeTiersTmp)+' ;;; @TOTAL DES MOUVEMENTS ;'+e.FormatCurrSansDevise(TotalMvtCreanteTiers) +';'+e.FormatCurrSansDevise(TotalMvtDetteTiers)+'; ');
                if (i<CompteDeTiers.count-1)and (compteCollectifRempli) and(CompteTmp<>GetStringElement(CompteDeTiers.strings[i+1],1,';'))then
                    begin//changement de compte collectif, donc totaux
                      DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
                      ListeValeur.Add('1;;;@Collectif : '+CompteTmp+' ;;;@SOLDE ;'+e.FormatCurrSansDevise(TotalMouvementCreanceCollectif) +';'+e.FormatCurrSansDevise(TotalMouvementDetteCollectif)+'; ');
                      TotalMouvementDetteCollectif:=0;
                      TotalMouvementCreanceCollectif:=0;
                      compteCollectifRempli:=false;
                      if(SautDePage)then ListeValeur.add('20');
                    end;
             end;//fin parcours liste des comptes
            if (CompteTmp<>'')and (compteCollectifRempli)then
              begin
              DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
              ListeValeur.Add('1;;;@Collectif : '+CompteTmp+' ;;;@SOLDE ;'+CurrToStr(TotalMouvementCreanceCollectif) +';'+CurrToStr(TotalMouvementDetteCollectif)+'; ');
              TotalMouvementDetteCollectif:=0;
              TotalMouvementCreanceCollectif:=0;
              end;
           if ListeValeur.Count<>0 then
           begin
             // if(SautDePage)then ListeValeur.add('20');
              ListeValeur.Add('2;;; @;;; @TOTAL GLOBAL ;'+e.FormatCurrSansDevise(SoldeMouvementCreance) +';'+e.FormatCurrSansDevise(SoldeMouvementDette)+'; ');
              DetermineSolde(SoldeMouvementDette,SoldeMouvementCreance);
              ListeValeur.Add('1;;; @;;; @SOLDE ;'+e.FormatCurrSansDevise(SoldeMouvementCreance) +';'+e.FormatCurrSansDevise(SoldeMouvementDette)+'; ');
           if (not precision) then
             ObjPrn.FTitreEdition := 'DETTES ET CREANCES DES TIERS (Calcul rapide)'
           else
             ObjPrn.FTitreEdition := 'DETTES ET CREANCES DES TIERS ';
           ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
           ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ListeValeur.Insert(0,' Date ;Réf. Pièce ; Désignation ; ; Mtant Total ; Déjà Réglé ; Créances ; Dettes ; Soldes ');
           ListeValeur.Insert(1,'0.6;0.8;2;0.1;0.8;0.8;0.8;0.8;0.8');
           ListeValeur.Insert(2,'texte;texte;texte;texte;curr;curr;curr;curr;curr');
           end;
       end;//fin si il y a des dettes ou creances dans période
     if Relance then
       begin
           try
             ExportRelanceDesTiers(ListeRelance);
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
     end
    else
     // un seul tiers
     begin
      CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[0],1,';');
      if str_commence_par(CompteDeTiersTmp,'+')then
        begin
          CompteTmp:=DMTiers.CptDuTiers(CompteDeTiersTmp);
          NomTiers:=DMTiers.LibelleDuTiers(CompteDeTiersTmp);
        end
      else
        begin
          CompteTmp:=CompteDeTiersTmp;
          NomTiers:=DMPlan.LibelleDuNumCptPCU(comptetmp);
        end;
      Solde :=0;
      compteRempli:=false;
      TotalMouvementDette:=0;
      TotalMouvementCreance:=0;
      DMPointage2.QuDettesCreance_Edition.close;
      DMPointage2.QuDettesCreance_Edition.sql.Clear;
DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
DMPointage2.QuDettesCreance_Edition.sql.Add(' where (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and R."Date" between :DateDeb and  :DateFin');
if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,R."Date",Reference');


      DMPointage2.QuDettesCreance_Edition.Close;
      DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := CompteTmp;
      DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;
      if DMPointage2.QuDettesCreance_Edition.recordcount<>0 then
        begin//si il y a des dettes ou creances dans période
              while not DMPointage2.QuDettesCreance_Edition.Eof do
                begin
                 if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
                 else
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
                  // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
                  // les dates de pièce sont antérieures à la date de fin de période
                  // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;

                  if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                   Begin
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
                     DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition.findfield('MontantPointeCredit').AsCurrency;
                     Dette:=MontantTotal - DejaRegle;
                     TotalMouvementDette:=Dette+ TotalMouvementDette;
                     Creance :=0;
                   end
                  else
                    begin
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition.findfield('MontantPointeDebit').AsCurrency;
                      Creance:=MontantTotal - DejaRegle;
                      TotalMouvementCreance:=Creance + TotalMouvementCreance;
                      Dette:=0;
                    end;

                 Solde := Creance - Dette + Solde;
                 if DejaRegle <> MontantTotal then
                   begin //si solde <> 0 on rempli dans la liste
                     if compteRempli=false then
                       begin
                          ListeValeur.Add('9;COMPTE DE TIERS : '+GereLibelle(CompteDeTiersTmp)+'-'+CompteTmp+' - '+GereLibelle(NomTiers));
                          compteRempli:=true;
                       end;
                   ListeValeur.Add('0'+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('DAte').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+ // Créances
                                   ';'+
                                   CurrToStr(Dette)+ // Dettes
                                   ';'+
                                   CurrToStr(Solde) // Soldes
                                   );
                   ///////
                   ListeRelance.Add(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').Asstring+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.findfield('Id_Piece').Asstring+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('DAte').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   GereLibelle(CompteDeTiersTmp)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+ //
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+  // Créances
                                   ';'+
                                   CurrToStr(Dette)+  // Dettes
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Nom').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse1').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse2').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Poste').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('ville').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Pays').Asstring)
                                   );
                   end;
                 DMPointage2.QuDettesCreance_Edition.Next;
                end;
         ObjPrn.FTitreEdition := 'DETTES ET CREANCES DES TIERS';
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ListeValeur.Insert(0,' Date ;Réf. Pièce ; Désignation ; ; Mtant Total ; Déjà Réglé ; Créances ; Dettes ; Soldes ');
         ListeValeur.Insert(1,'0.6;0.8;2;0.1;0.8;0.8;0.8;0.8;0.8');
         ListeValeur.Insert(2,'texte;texte;texte;texte;curr;curr;curr;curr;curr');
         //ListeValeur.Insert(3,'8;Compte de Tiers : '+CompteDeTiersTmp);
         ListeValeur.Add('4;;; @Tiers : '+GereLibelle(CompteDeTiersTmp)+' ;;; @TOTAL DES MOUVEMENTS ;'+e.FormatCurrSansDevise(TotalMouvementCreance) +';'+e.FormatCurrSansDevise(TotalMouvementDette)+'; ');
              DetermineSolde(TotalMouvementDette,TotalMouvementCreance);
              ListeValeur.Add('1;;;@Collectif : '+CompteTmp+' ;;;@SOLDE ;'+e.FormatCurrSansDevise(TotalMouvementCreance) +';'+e.FormatCurrSansDevise(TotalMouvementDette)+'; ');
        end;//fin si il y a des dettes ou creances dans période
     if Relance then
       begin
           try
           ExportRelanceDesTiers(ListeRelance);
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;
   end;
finally
PatienterFermer();
Initialise_TStringlist(CompteDeTiers,DMPointage2);
DMPointage2.QuDettesCreance_Edition.close;
DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;
DMPointage2.QuDettesCreance_Edition.filtered:=false;

LibereObjet(TObject(Requete));
LibereObjet(TObject(ObjPrn));
end;
End;


Function EditionDetteCreanceL_affineeEcheance(TypeEdition : integer; DemandePeriode:Boolean; CompteDeTiers:TStringList;DataSet:TDataSet;SautDePage:boolean;Relance:boolean;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string):Boolean;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeRelance:TStringList;
MontantTotal,DEjaRegle,Creance,Dette,Solde,TotalMouvementDette,TotalMouvementCreance:Currency;
TotalMvtCreanteTiers,TotalMvtDetteTiers,Reste,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
SoldeMouvementDette,SoldeMouvementCreance:Currency;
ParamAffichPeriode:TParamAffichPeriode;
LibelleCorrect:string;
//Requete:TQuery;
CompteDeTiersTmp,CompteTmp,NomTiers:string;
compteRempli,compteCollectifRempli:boolean;
begin

//TypeDettes='' -> Dettes et Créances
//TypeDettes='C' -> Dettes
//TypeDettes='D' -> Créances
//ListeExclu = liste des journaux exclu

try//finally
    PatienterAffich();
    ObjPrn:=TObjetEdition.Create(application.MainForm);
       Initialise_ParamAffichPeriode(ParamAffichPeriode);

//Requete:=TQuery.Create(application.MainForm);
DMPointage2.Requete.SQL.Clear;
//
//select min(ResteDC."Date") as DateDebDebite
//from ResteDC rd where reste<>0 or(
//((reste=0 and rd.sens='D' and  rd.id_ecriture  in (select id_debit from pointage p where P."Date" >'12/31/2005')))
//or((reste=0 and rd.sens='C' and  rd.id_ecriture  in(select id_credit from pointage p where P."TvaDate" >'12/31/2005'))))
//
DMPointage2.Requete.SQL.Add(' select min(P.Echeance) as DateDeb');
DMPointage2.Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd  ');
DMPointage2.Requete.SQL.Add(' join "'+e.RepertoireDossier+'Piece" P on(P.id=Rd.id_piece) where reste<>0 ');
if (not precision) then
  begin
      if not relance then
        showmessage('Attention !!!, cette édition tient compte des réglements de l''exercice N+1');
      if not relance then DemandePeriode:=false;
  end
else
  begin
      DMPointage2.Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" >:DateFin)))');
      DMPointage2.Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" >:DateFin))))');
      DMPointage2.Requete.ParamByName('DateFin').AsDate := e.DatExoFin;
  end;

DMPointage2.Requete.open;
if ((DMPointage2.Requete.recordcount<>0)and(not empty(DMPointage2.Requete.findfield('DateDeb').Asstring)))then
  periode.DateDeb:=DMPointage2.Requete.findfield('DateDeb').AsDateTime
else
  periode.DateDeb:=e.DatExoDebut;

DMPointage2.Requete.Close;

  if DemandePeriode then
    Begin
       periode:=ChoixPeriodeAffich(periode.DateDeb,E.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

DMPointage2.QuDettesCreance_Edition.Filter:='';
DMPointage2.QuDettesCreance_Edition.Filtered:=false;
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeDebit_Edition2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeCredit_Edition2);   
    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Close;
    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.ParamByName('FinPeriode').AsDate:=periode.DateFin;
    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Open;

    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Close;
    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.ParamByName('FinPeriode').AsDate:=periode.DateFin;
    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Open;

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeRelance:=TStringList.Create;
    if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
DMPointage2.TypeDettes:=TypeDettes;
if ListeExclu=nil then
  Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false)
else
  if DMPointage2.ListeDettesAffich.ClassInfo<>ListeExclu.ClassInfo then
  begin
    Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false);
    for i:=0 to ListeExclu.count-1 do
      DMPointage2.ListeDettesAffich.Add(ListeExclu.strings[i]);
  end;
  DMPointage2.QuDettesCreance_Edition.Close;
  DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
  DMPointage2.QuDettesCreance_Edition.filtered:=true;
  DMPointage2.QuDettesCreance_Edition.sql.Clear;
  DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,R.Tiers,T.Nom,R.Sens');
  DMPointage2.QuDettesCreance_Edition.sql.Add('from ResteDC R');
  DMPointage2.QuDettesCreance_Edition.sql.Add('left join tiers T on (r.tiers=T.tiers)');
  DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
  DMPointage2.QuDettesCreance_Edition.sql.Add('where  P.Echeance between :DateDeb and :DateFin');
  if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and R.reste<>0');
    DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,R.tiers');

      SoldeMouvementDette:=0;
      SoldeMouvementCreance:=0;
      TotalMouvementDette:=0;
      TotalMouvementCreance:=0;

    if CompteDeTiers=nil then
     // Tous les Compte de Tiers
     begin

      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Prepare;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;
      CompteDeTiers:=Tstringlist.Create;
      CompteDeTiers.Sorted:=True;
      CompteDeTiers.Duplicates:=dupIgnore;
      while not DMPointage2.QuDettesCreance_Edition.Eof do
        Begin
          if (empty(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString)) and (str_commence_par(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString,'+')=false)then
            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString)
          else 
            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString);
          DMPointage2.QuDettesCreance_Edition.Next;
        end;
      end;

      //////////////////////////////////////////////////////////////////////////////////////
                                //si plus d'un tiers
      //////////////////////////////////////////////////////////////////////////////////
      if (CompteDeTiers<>nil)and (CompteDeTiers.count>1) then //si plus d'un tiers
      begin
      DMPointage2.QuDettesCreance_Edition.close;
      DMPointage2.QuDettesCreance_Edition.sql.Clear;
      DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,P.compte,R.Tiers,Reference,P.Echeance,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');         // (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and
      DMPointage2.QuDettesCreance_Edition.sql.Add(' where  P.Echeance between :DateDeb and  :DateFin');
      if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' order by P.compte,tiers,P.Echeance,Reference');
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;
      DMPointage2.QuDettesCreance_Edition.RecordCount;
      DMPointage2.QuSumPointageDansPeriodeCredit_Edition.open;
      DMPointage2.QuSumPointageDansPeriodeDebit_Edition.open;

     ListeRelance.Add('Id_Ecriture'+
                     ';'+
                     'Id_Piece'+
                     ';'+
                     'Echéance'+
                     ';'+
                     'Date'+
                     ';'+
                     'Reference'+
                     ';'+
                     'Tiers'+
                     ';'+
                     'Libelle'+
                     ';'+
                     'Sens'+
                     ';'+
                     'MontantTotal'+ //
                     ';'+
                     'DejaRegle'+ // Deja Reglé
                     ';'+
                     'Creance'+  // Créances
                     ';'+
                     'Dette'+  // Dettes
                     ';'+
                     'Nom Tiers'+
                     ';'+
                     'Adresse1'+
                     ';'+
                     'Adresse2'+
                     ';'+
                     'Code Postal'+
                     ';'+
                     'ville'+
                     ';'+
                     'Pays');
compteCollectifRempli:=false;
      if CompteDeTiers.count<>0 then
        begin//si il y a des dettes ou creances dans période
           for i:=0 to CompteDeTiers.count-1 do
             begin
                Solde :=0;
                TotalMvtCreanteTiers:=0;
                TotalMvtDetteTiers:=0;
                CompteTmp:=GetStringElement(CompteDeTiers.strings[i],1,';');
                CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],2,';');
                if str_commence_par(CompteDeTiersTmp,'+')then
                  begin
                    NomTiers:=GetStringElement(CompteDeTiers.strings[i],3,';');
                    filtre:='Tiers = '''+CompteDeTiersTmp+'''';
                  end
                else
                  begin
                    NomTiers:=dmplan.LibelleDuNumCptPCU(CompteDeTiersTmp);
                    filtre:='Tiers = '''+GetStringElement(CompteDeTiers.strings[i],1,';')+'''';
                  end;
//                DMPointage2.QuDettesCreance_Edition.Close;

//                filtre:='compte = '''+GetStringElement(CompteDeTiers.strings[i],1,';')+'''and Tiers = '''+CompteDeTiersTmp+'''';
                FiltrageDataSet(DMPointage2.QuDettesCreance_Edition,filtre);
//                DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := GetStringElement(CompteDeTiers.strings[i],1,';');
//                DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
//                DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//                DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//                DMPointage2.QuDettesCreance_Edition.Open;
//                DMPointage2.QuDettesCreance_Edition.First;
//                DMPointage2.QuSumPointageDansPeriodeCredit_Edition.open;
//                DMPointage2.QuSumPointageDansPeriodeDebit_Edition.open;
                if DMPointage2.QuDettesCreance_Edition.recordcount=0 then
                  CompteDeTiersTmp:='';
                compteRempli:=false;
                while not DMPointage2.QuDettesCreance_Edition.Eof do
                  begin
                   if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
                    else
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
                    // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
                    // les dates de pièce sont antérieures à la date de fin de période
                    // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //              DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;

                    if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                     Begin
                          //DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Prepare;
//                       //DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
                        DejaRegle:=0;
                      if  DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Locate('id_credit',IntToStr(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger),[]) then
                         DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.findfield('MontantPointeCredit').AsCurrency;
                       Dette:=MontantTotal - DejaRegle;
                       TotalMouvementDette:=Dette+ TotalMouvementDette;
                       TotalMvtDetteTiers:=Dette+ TotalMvtDetteTiers;
                       TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
                       SoldeMouvementDette:=Dette+SoldeMouvementDette;
                       Creance :=0;
                     end
                    else
                      begin
                      DejaRegle:=0;
////                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Prepare;
////                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
                       if(DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Locate('id_debit',IntToStr(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger),[]))then
                            DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.findfield('MontantPointeDebit').AsCurrency;
                        Creance:=MontantTotal - DejaRegle;
                        TotalMouvementCreance:=Creance + TotalMouvementCreance;
                        TotalMvtCreanteTiers:=Creance + TotalMvtCreanteTiers;
                        TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
                        SoldeMouvementCreance:=Creance+SoldeMouvementCreance;
                        Dette:=0;
                      end;

                   Solde := Creance - Dette + Solde;
                   if DejaRegle <> MontantTotal then
                   begin //si solde <> 0 on rempli dans la liste
                     if compteRempli=false then
                       begin
                          ListeValeur.Add('9;COMPTE DE TIERS : '+GereLibelle(CompteDeTiersTmp)+' - '+CompteTmp+' - '+GereLibelle(NomTiers));
                          compteRempli:=true;
                          compteCollectifRempli:=true;
                       end;
                   LibelleCorrect:=str_remplacesouschaine(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString,';',',');
                   ListeValeur.Add('0'+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Echeance').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.findField('Date').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+ // Créances
                                   ';'+
                                   CurrToStr(Dette)+ // Dettes
                                   ';'+
                                   CurrToStr(Solde) // Soldes
                                   );
                 ///////
                 ListeRelance.Add(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').Asstring+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.findfield('Id_Piece').Asstring+
                                 ';'+
                                 dateinfos(DMPointage2.QuDettesCreance_Edition.FindField('Echeance').AsDateTime).DateStrFormat+
                                 ';'+
                                 dateinfos(DMPointage2.QuDettesCreance_Edition.FindField('Date').AsDateTime).DateStrFormat+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                 ';'+
                                 GereLibelle(CompteDeTiersTmp)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                 ';'+
                                 DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                 ';'+
                                 CurrToStr(arrondi(MontantTotal,2))+ //
                                 ';'+
                                 CurrToStr(arrondi(DejaRegle,2))+ // Deja Reglé
                                 ';'+
                                 CurrToStr(arrondi(Creance,2))+  // Créances
                                 ';'+
                                 CurrToStr(arrondi(Dette,2))+  // Dettes
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Nom').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse1').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse2').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Poste').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('ville').Asstring)+
                                 ';'+
                                 GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Pays').Asstring)
                                 );
                   end;//si solde <>0
                   DMPointage2.QuDettesCreance_Edition.Next;
                  end;
                if (CompteDeTiersTmp<>'') and (compteRempli) then
                  ListeValeur.Add('4;;; @Tiers : '+GereLibelle(CompteDeTiersTmp)+' ;;;; @TOTAL DES MOUVEMENTS ;'+CurrToStr(TotalMvtCreanteTiers) +';'+CurrToStr(TotalMvtDetteTiers)+'; ');
                if (i<CompteDeTiers.count-1)and (compteCollectifRempli) and(CompteTmp<>GetStringElement(CompteDeTiers.strings[i+1],1,';'))then
                    begin//changement de compte collectif, donc totaux
                      DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
                      ListeValeur.Add('1;;;;;;;@COLLECTIF : '+CompteTmp+' - SOLDE ;'+CurrToStr(TotalMouvementCreanceCollectif) +';'+CurrToStr(TotalMouvementDetteCollectif)+'; ');
                      TotalMouvementDetteCollectif:=0;
                      TotalMouvementCreanceCollectif:=0;
                      compteCollectifRempli:=false;
                      if(SautDePage)then ListeValeur.add('20');
                    end;
             end;//fin parcours liste des comptes
            if (CompteTmp<>'')and (compteCollectifRempli)then
              begin
              DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
              ListeValeur.Add('11;;;;;;;COLLECTIF : '+CompteTmp+' - SOLDE ;'+CurrToStr(TotalMouvementCreanceCollectif) +';'+CurrToStr(TotalMouvementDetteCollectif)+'; ');
              TotalMouvementDetteCollectif:=0;
              TotalMouvementCreanceCollectif:=0;
              end;
           if ListeValeur.Count<>0 then
           begin
          // if(SautDePage)then ListeValeur.Add('20');
              ListeValeur.Add('2;;; @;;;; @TOTAL GLOBAL ;'+CurrToStr(SoldeMouvementCreance) +';'+CurrToStr(SoldeMouvementDette)+'; ');
              DetermineSolde(SoldeMouvementDette,SoldeMouvementCreance);
              ListeValeur.Add('1;;; @;;;; @SOLDE ;'+CurrToStr(SoldeMouvementCreance) +';'+CurrToStr(SoldeMouvementDette)+'; ');
           if (not precision) then
             ObjPrn.FTitreEdition := 'DETTES ET CREANCES DES TIERS (Calcul rapide)'
           else
             ObjPrn.FTitreEdition := 'DETTES ET CREANCES DES TIERS ';
           ObjPrn.Orientation:=poLandscape;
           ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
           ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ListeValeur.Insert(0,' Echéance ; Date ;Réf. Pièce ; Désignation ; ; Mtant Total ; Déjà Réglé ; Créances ; Dettes ; Soldes ');
           ListeValeur.Insert(1,'0.8;0.8;0.8;2;0.1;0.8;0.8;0.8;0.8;0.8');
           ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr;curr;curr;curr');
           end;
       end;//fin si il y a des dettes ou creances dans période
     if Relance then
       begin
           try
             ExportRelanceDesTiers(ListeRelance);
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
     end
    else
          //////////////////////////////////////////////////////////////////////////////////////
                                //un seul tiers
      //////////////////////////////////////////////////////////////////////////////////
     //
     begin
      CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[0],2,';');
      if str_commence_par(CompteDeTiersTmp,'+')then
        begin
          CompteTmp:=DMTiers.CptDuTiers(CompteDeTiersTmp);
          NomTiers:=DMTiers.LibelleDuTiers(CompteDeTiersTmp);
        end
      else
        begin
          CompteTmp:=CompteDeTiersTmp;
          NomTiers:=DMPlan.LibelleDuNumCptPCU(comptetmp);
        end;
      Solde :=0;
      compteRempli:=false;
      TotalMouvementDette:=0;
      TotalMouvementCreance:=0;
      DMPointage2.QuDettesCreance_Edition.close;
      DMPointage2.QuDettesCreance_Edition.sql.Clear;
DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,P.Echeance,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
DMPointage2.QuDettesCreance_Edition.sql.Add(' where (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and P.Echeance between :DateDeb and  :DateFin');
if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,P.Echeance,Reference');


      DMPointage2.QuDettesCreance_Edition.Close;
      DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := CompteTmp;
      DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;
      if DMPointage2.QuDettesCreance_Edition.recordcount<>0 then
        begin//si il y a des dettes ou creances dans période
              while not DMPointage2.QuDettesCreance_Edition.Eof do
                begin
                 if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
                 else
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
                  // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
                  // les dates de pièce sont antérieures à la date de fin de période
                  // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;

                  if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                   Begin
                     //DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
                     TableGereOpen(DMPointage2.QuSumPointageDansPeriodeCredit_Edition);
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Refresh;
                     //DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
                     DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition.findfield('MontantPointeCredit').AsCurrency;
                     Dette:=MontantTotal - DejaRegle;
                     TotalMouvementDette:=Dette+ TotalMouvementDette;
                     Creance :=0;
                   end
                  else
                    begin
                       //DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
                       TableGereOpen(DMPointage2.QuSumPointageDansPeriodeDebit_Edition);
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Refresh;
                       //DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition.findfield('MontantPointeDebit').AsCurrency;
                      Creance:=MontantTotal - DejaRegle;
                      TotalMouvementCreance:=Creance + TotalMouvementCreance;
                      Dette:=0;
                    end;

                 Solde := Creance - Dette + Solde;
                 if DejaRegle <> MontantTotal then
                   begin //si solde <> 0 on rempli dans la liste
                     if compteRempli=false then
                       begin
                          ListeValeur.Add('9;COMPTE DE TIERS : '+GereLibelle(CompteDeTiersTmp)+'-'+CompteTmp+' - '+GereLibelle(NomTiers));
                          compteRempli:=true;
                       end;
                   ListeValeur.Add('0'+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Echeance').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Date').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+ // Créances
                                   ';'+
                                   CurrToStr(Dette)+ // Dettes
                                   ';'+
                                   CurrToStr(Solde) // Soldes
                                   );
                   ///////
                   ListeRelance.Add(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').Asstring+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.findfield('Id_Piece').Asstring+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Echeance').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Date').AsString+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Reference').AsString+
                                   ';'+
                                   GereLibelle(CompteDeTiersTmp)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString+
                                   ';'+
                                   CurrToStr(MontantTotal)+ //
                                   ';'+
                                   CurrToStr(DejaRegle)+ // Deja Reglé
                                   ';'+
                                   CurrToStr(Creance)+  // Créances
                                   ';'+
                                   CurrToStr(Dette)+  // Dettes
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Nom').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse1').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Adresse2').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Poste').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('ville').Asstring)+
                                   ';'+
                                   GereLibelle(DMPointage2.QuDettesCreance_Edition.findfield('Pays').Asstring)
                                   );
                   end;
                 DMPointage2.QuDettesCreance_Edition.Next;
                end;
         ObjPrn.Orientation:=poLandscape;
         ObjPrn.FTitreEdition := 'DETTES ET CREANCES DES TIERS';
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ListeValeur.Insert(0,' Echéance ;Date ;Réf. Pièce ; Désignation ; ; Mtant Total ; Déjà Réglé ; Créances ; Dettes ; Soldes ');
         ListeValeur.Insert(1,'0.8;0.8;0.8;2;0.1;0.8;0.8;0.8;0.8;0.8');
         ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr;curr;curr;curr');
         //ListeValeur.Insert(3,'8;Compte de Tiers : '+CompteDeTiersTmp);
         ListeValeur.Add('4;;; @Tiers : '+GereLibelle(CompteDeTiersTmp)+' ;;;; @TOTAL DES MOUVEMENTS ;'+CurrToStr(TotalMouvementCreance) +';'+CurrToStr(TotalMouvementDette)+'; ');
              DetermineSolde(TotalMouvementDette,TotalMouvementCreance);
              ListeValeur.Add('1;;;;;;;@COLLECTIF : '+CompteTmp+' - SOLDE ;'+CurrToStr(TotalMouvementCreance) +';'+CurrToStr(TotalMouvementDette)+'; ');
        end;//fin si il y a des dettes ou creances dans période
     if Relance then
       begin
           try
           ExportRelanceDesTiers(ListeRelance);
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;
   end;
finally
PatienterFermer();
Initialise_TStringlist(CompteDeTiers,DMPointage2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeDebit_Edition2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeCredit_Edition2);
DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Close;
DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Close;
DMPointage2.QuDettesCreance_Edition.close;
DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;
DMPointage2.QuDettesCreance_Edition.filtered:=false;
DeFiltrageDataSet(DMPointage2.QuDettesCreance_Edition);
DMPointage2.Requete.close;
//LibereObjet(TObject(Requete));
LibereObjet(TObject(ObjPrn));
end;
End;



Function RecupDetteCreance(FiltreParam:string;Cpt,Sens:string;JournalExclu:array of string;DateDeb,DateFin:TDate;MontantResteMini,MontantResteMaxi:currency;ListeLettreExclue:TStringList;GereDataSet:Boolean;Dataset:TDataset):TInfoResteDCSurCompte;
var
CodeJounaux:Tstringlist;
Filtre,Coordination:string;
//RetourTranstypage:TTypeTranstypage;
Begin
try//finally
if (DMPointage2 = nil) then DMPointage2:=TDMPointage2.Create(Application.MainForm);
with DMPointage2 do
 begin
//   if dataset=nil then dataset:=DMPointage2.TaResteDC;
//   dataset.close;
   DMPointage2.TaResteDC.close;
   FiltrePourSolde:='';

   TiersDemande:=Cpt;

   Filtre:='reste<>0';
   FiltrePourSolde:='reste<>0';
   Coordination:=' And ';

   if not empty(FiltreParam)then filtre:=filtre+Coordination+FiltreParam;

   if cpt<>'*' then
     begin
        Filtre:=Filtre+coordination+'('+CreeFiltreET(['Tiers'],[Cpt])+')';
        FiltrePourSolde:=FiltrePourSolde+coordination+'('+CreeFiltreET(['Tiers'],[Cpt])+')';
     end;

   if ((sens = 'C') or (sens='D')) then
    begin
      Filtre:=Filtre+Coordination+'('+CreeFiltreET(['Sens'],[Sens])+')';
      //je ne récupère pas ce morceaux de filtre car ma procédure de récupération des soldes travail
      //sur les deux sens
    end;

   if ListeLettreExclue <> nil then
     begin
      Filtre:=Filtre+Coordination+' ('+CreeFiltreET(['Lettre'],[ListeLettreExclue])+')';
      FiltrePourSolde:=FiltrePourSolde+coordination+' ('+CreeFiltreET(['Lettre'],[ListeLettreExclue])+')';
    end;

   if DateDeb > 0 then
     begin
      Filtre:=Filtre+Coordination+' ( Date >= '''+DateToStr(DateDeb)+''')';
      FiltrePourSolde:=FiltrePourSolde+coordination+' ( resteDc."Date" >= '''+DateInfos(DateDeb).DatePourSQLStr+''')';
    end;

   if DateFin > 0 then
     begin
      Filtre:=Filtre+Coordination+' ( Date <= '''+DateToStr(DateFin)+''')';
      FiltrePourSolde:=FiltrePourSolde+Coordination+' ( resteDc."Date" <= '''+DateInfos(DateFin).DatePourSQLStr+''')';
    end;

   if MontantResteMaxi > 0 then
     begin
      Filtre:=Filtre+Coordination+' ( Reste <= '+CurrToStr(MontantResteMaxi)+')';
      FiltrePourSolde:=FiltrePourSolde+coordination+' ( Reste <= '+CurrToStr(MontantResteMaxi)+')';
    end;

   if MontantResteMini > 0 then
     begin
      Filtre:=Filtre+Coordination+' ( Reste >= '+CurrToStr(MontantResteMini)+')';
      FiltrePourSolde:=FiltrePourSolde+coordination+' ( Reste >= '+CurrToStr(MontantResteMini)+')';
    end;
   CodeJounaux:=RecupListeLettreExclu_SurJournal(JournalExclu,'*');
   if ((CodeJounaux<>nil)and(CodeJounaux.count>1)) then
     Filtre:=Filtre+Coordination+' ( not ('+CreeFiltreou('reference',[CodeJounaux])+'))';

   CodeJounaux:=RecupListeLettreExclu_SurJournal(JournalExclu,'');
   if ((CodeJounaux<>nil)and(CodeJounaux.count>1)) then
     FiltrePourSolde:=FiltrePourSolde+Coordination+' ( not ('+CreeFiltreou('substring(reference from 1 for 2) ',[CodeJounaux])+'))';

//   dataset.OnFilterRecord:=DMPointage2.TaResteDCFilterRecord;
//   Filtragedataset(dataset,Filtre);
   DMPointage2.TaResteDC.OnFilterRecord:=DMPointage2.TaResteDCFilterRecord;
   Filtragedataset(DMPointage2.TaResteDC,Filtre);
//
////   // Compte le nombre de ligne pointée totalement
//   dataset.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointage_PointeTotal;
//   REsult.NBLignePointee:=dataset.RecordCount;
   DMPointage2.TaResteDC.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointage_PointeTotal;
   REsult.NBLignePointee:=DMPointage2.TaResteDC.RecordCount;

   // Compte le nombre de ligne pointée partiellement
//   dataset.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointage_PointePartiel;
//   REsult.NBLignePartiellementPointee:=dataset.RecordCount;

   DMPointage2.TaResteDC.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointage_PointePartiel;
   REsult.NBLignePartiellementPointee:=DMPointage2.TaResteDC.RecordCount;

   // Compte le nombre de ligne non pointée au debit
//   dataset.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointageDebit;
//   REsult.NBLigneResteAPointerDebit:=dataset.RecordCount;

   DMPointage2.TaResteDC.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointageDebit;
   REsult.NBLigneResteAPointerDebit:=DMPointage2.TaResteDC.RecordCount;

   // Compte le nombre de ligne non pointée  au credit
//   dataset.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointageCredit;
//   REsult.NBLigneResteAPointerCredit:=dataset.RecordCount;

   DMPointage2.TaResteDC.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointageCredit;
   REsult.NBLigneResteAPointerCredit:=DMPointage2.TaResteDC.RecordCount;

   Result.ComptePointable := ((REsult.NBLigneResteAPointerDebit > 0) and (REsult.NBLigneResteAPointerCredit > 0));

   // Compte le nombre de ligne non pointée
//   DMPointage2.TaResteDC.OnFilterRecord:=DMPointage2.TaResteDCFilterRecordPourPointage;
//   REsult.NBLigneResteAPointer:=DMPointage2.TaResteDC.RecordCount;
   REsult.NBLigneResteAPointer:=REsult.NBLigneResteAPointerDebit + REsult.NBLigneResteAPointerCredit;

//      dataset.OnFilterRecord:=DMPointage2.TaResteDCFilterRecord;
   DMPointage2.TaResteDC.OnFilterRecord:=DMPointage2.TaResteDCFilterRecord;
   if dataset<>nil then
      Begin
       dataset.OnFilterRecord:=DMPointage2.TaResteDCFilterRecord;
       Filtragedataset(dataset,Filtre);
      end;

   if gereDataSet then
    begin
     Result.DataSetResult:=TTable.Create(Application.MainForm);
     Result.DataSetResult:=TTable(CloneDataSet(Dataset,Result.DataSetResult));
//     Result.DataSetResult:=TTable(CloneDataSet(DMPointage2.TaResteDC,Result.DataSetResult));
    end;

   if str_commence_par(cpt,'+') then
   begin
     if cpt = ('+*') then
      begin
        Result.Compte:='';
        Result.MessageCpt:=' tous les comptes de tiers ';
      end
     else
      begin
        Result.Compte:=Cpt;
        Result.MessageCpt:=' le compte de tiers : '+ cpt;
      end;
   end;
 end;
finally
  TiersDemande:='';
end;
End;

Function RecupPointagePourReglement(Cpt,Sens,Journal:string;ID_Journal:array of string;DateDeb,DateFin:TDate;Option:integer;IDEcritureAppelante:integer):TInfoResteDCSurCompte;
var
SensReglement,CodeJounaux:string;
Premier_Tour:boolean;
i:integer;
Begin
try
if (DMPointage2 = nil) then DMPointage2:=TDMPointage2.Create(Application.MainForm);
with DMPointage2 do
 begin
 TiersDemande:=Cpt;

   if sens= 'C' then SensReglement:='D' else SensReglement:='C';
   TaResteDCReglement.Close;
   if not empty(Journal)then
     TaResteDCReglement.Filter:=CreeFiltreET(['Tiers','sens','Reference'],[Cpt,SensReglement,journal])
   else
     begin
     TaResteDCReglement.Filter:=CreeFiltreET(['Tiers','sens'],[Cpt,SensReglement]);
     Premier_Tour:=true;
        for i:=0 to high(ID_Journal) do
          Begin//debut boucle for
          //récupérer tous les codes journaux en fontion du n° du journal
          CodeJounaux:='';
          if not empty(ID_Journal[i])then
            Begin//si tableau rempli
              FiltrageDataSet(dmrech.TaModelRech,'ID_Journal = '+ID_Journal[i]);
              dmrech.TaModelRech.First;
              while not (dmrech.TaModelRech.eof)do
                begin
                  CodeJounaux:=copy(dmrech.TaModelRech.findfield('Journal').asstring,1,2);
                  if Premier_Tour then
                    TaResteDCReglement.Filter:=TaResteDCReglement.Filter + ' and((reference = '''+CodeJounaux+'*'')'
                  else
                    DMPointage2.TaResteDCReglement.Filter:=TaResteDCReglement.Filter + ' or (reference = '''+CodeJounaux+'*'')';
                  dmrech.TaModelRech.next;
                  Premier_Tour:=false;
                end;
//            if not Premier_Tour then
              if i=high(ID_Journal) then
                 TaResteDCReglement.Filter:=TaResteDCReglement.Filter + ')';
            End;//fin si tableau rempli
          End;//fin debut boucle for
     end;
   TaResteDCReglement.Filtered:=true;
   DMPointage2.TaResteDCReglement.Open;


 TaInfoPointageDebit.close;
 TaInfoPointageCredit.close;

if sens='C'then
  begin
   IDEcritureAppelanteLoc:=IDEcritureAppelante;
   SensPiece:=sens;
   TaInfoPointageDebit.filtered:=false;
   TaInfoPointageDebit.Filter:='id_Credit ='''+inttostr(IDEcritureAppelante)+'''';
   TaInfoPointageDebit.filtered:=true;
   DMPointage2.TaInfoPointageDebit.open;
  end
else
  begin
   IDEcritureAppelanteLoc:=IDEcritureAppelante;
   SensPiece:=sens;
   TaInfoPointageCredit.filtered:=false;
   TaInfoPointageCredit.Filter:='id_Debit ='''+inttostr(IDEcritureAppelante)+'''';
   TaInfoPointageCredit.filtered:=true;
   TaInfoPointageCredit.open;
  end;


case option of
41,31:Begin //affichage vide
      //
      End;//fin affichage vide
42,32:Begin //récupérer tous les réglements concernant le tiers courant et qui soient encore pointables
        // Compte le nombre de ligne pointé totalement
        DMPointage2.TaResteDCReglement.OnFilterRecord:=TaResteDCFilterRecordPourPointage_PointeTotal;
        REsult.NBLignePointee:=DMPointage2.TaResteDCReglement.RecordCount;
        // Compte le nombre de ligne non pointé
        DMPointage2.TaResteDCReglement.OnFilterRecord:=TaResteDCFilterRecordPourPointage;
        REsult.NBLigneResteAPointer:=DMPointage2.TaResteDCReglement.RecordCount;
      End;//fin récupérer tous les réglements concernant le tiers courant et qui soient encore pointables
43,33:Begin //récupérer tous les réglements concernant le tiers courant et déjà pointés
        // Compte le nombre de ligne non pointé
        DMPointage2.TaResteDCReglement.OnFilterRecord:=TaResteDCFilterRecordPourPointage;
        REsult.NBLigneResteAPointer:=DMPointage2.TaResteDCReglement.RecordCount;
        // Compte le nombre de ligne pointé totalement
        DMPointage2.TaResteDCReglement.OnFilterRecord:=TaResteDCFilterRecordPourPointage_PointeTotal;
        REsult.NBLignePointee:=DMPointage2.TaResteDCReglement.RecordCount;
      End;//fin récupérer tous les réglements concernant le tiers courant et déjà pointés
end;//fin du case

   if str_commence_par(cpt,'+') then
   begin
     if cpt = ('+*') then
      begin
        Result.Compte:='';
        Result.MessageCpt:=' tous les comptes de tiers ';
      end
     else
      begin
        Result.Compte:=Cpt;
        Result.MessageCpt:=' le compte de tiers : '+ cpt;
      end;
   end
   else
   begin
   end;
 end;
finally
//  TiersDemande:='';
end;
End;


//Function AffectReglementAffiche(DataSetOrg:TDataSet;TraiterDataSetOrg,GererListe:Boolean;Tiers_,Lettre,SensLigneAppel : string; var MontantAPointer:currency;DateDeb,DateFin:TDate;ListeLettreExclue:TStringList;ParametreAppelant:TParamAffichPointage):boolean;
//var
//EtatFiltre:TEtatFiltre;
//ID_Reste_Appelant,i:Integer;
//begin
//if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(application.MainForm);
//if DataSetOrg = nil then abort;
//TableSauveEtatFiltre(TTable(DataSetOrg),EtatFiltre);
//if AffectReglement = nil then
//   AffectReglement:=TAffectReglement.Create(Application.MainForm);
//
//if GererListe then
//  Begin//si on gere la liste, supprimer tous les lettrages et remplacer par les lettrages correspondant
//       //à l'id_Ligne_Appelant
//    try
//    DMPointage2.Initialisation_Liste;
//    DMPointage2.TaResteDC.AfterPost:=nil;
//    DMPointage2.SuppressionLettrage_Tous_ApresGestionDesPointages(DMPointage2.TaResteDC,nil);
//    if DMPointage2.ListeID_Appelant.Count<>0 then
//      Begin//si ListeID_Appelant existe
//        for i:=0 to DMPointage2.ListeID_Appelant.count-1 do
//          Begin//début boucle for
//            if PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.ID_Ligne_Appelant=ParametreAppelant.ID_Ecriture_Appelant then
//              Begin//si
//                 //se positionner sur idreste
//                 if PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Montant<=ParametreAppelant.Montant_Appelant then
//                 begin
//                   if DMPointage2.TaResteDC.Locate('id',PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.ID_Reste,[])then
//                     DMPointage2.LettrageEnregCourant(DMPointage2.TaResteDC,PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Lettre,PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Montant);
//                 end
//                 else
//                   begin
//                     DMPointage2.ListeID_Appelant.delete(i);
////                   if DMPointage2.TaResteDC.Locate('id',PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.ID_Reste,[])then
////                     begin
////                       DMPointage2.LettrageEnregCourant(DMPointage2.TaResteDC,PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Lettre,ParametreAppelant.Montant_Appelant);
////                       PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Montant:=ParametreAppelant.Montant_Appelant;
////                     end;
//                   end;
//              End;//fin si
//          End;//fin boucle for
//      End;//fin si ListeID_Appelant existe
//    finally
//      DMPointage2.TaResteDC.AfterPost:=DMPointage2.TaResteDCAfterPost;
//    end;//fin du try finally
//  End;//fin si on gere la liste
//
//if TraiterDataSetOrg then
// begin
//   if DMPointage2.RecupListeLettre_surDataset(DataSetOrg,false).Result then
//      begin
//        Showmessage('Un lettrage est déjà en cours, vous devez le valider !!!');
//        result:=false;
//        abort;
//      end;
//    Tiers_:=DataSetOrg.findfield('Tiers').AsString;
//    ID_Reste_Appelant:=DataSetOrg.findfield('ID').AsInteger;
//    MontantAPointer:=DataSetOrg.findfield('Reste').AsCurrency;
//    AffectReglement.MontantARegler:=MontantAPointer;
//    if not VerifFNumeric(DataSetOrg.findfield('Debit')).VideOUZero then
//      Begin//si ligne au debit
//         SensLigneAppel:='D';
//         affectReglement.MontantReglement:=DataSetOrg.findfield('Debit').ascurrency;
//      End//fin si ligne au debit
//    else
//      Begin//si ligne au Credit
//        SensLigneAppel:='C';
//        affectReglement.MontantReglement:=DataSetOrg.findfield('Credit').ascurrency;
//      End;//fin si ligne au Credit
//    // Attention, si ListeLEttreExclu <> nil possible duplication de lettrage
//    // A Traiter
//    if empty(Lettre) then Lettre:='A';
// end
//   else
//   begin
//    Tiers_:=ParametreAppelant.CptTiers;
//    ID_Reste_Appelant:=ParametreAppelant.ID_Reste_Appelant;
//    AffectReglement.MontantARegler:=ParametreAppelant.Reste_Appelant;
//    affectReglement.MontantReglement:=ParametreAppelant.Montant_Appelant;
//    SensLigneAppel:=ParametreAppelant.SensAppelant;
//    // Attention, si ListeLEttreExclu <> nil possible duplication de lettrage
//    // A Traiter
//    if empty(Lettre) then Lettre:='A';
// end;
// AffectReglement.EdCompte.Text:=Tiers_;
// DMPointage2.IDEcritureAppelanteLoc:=ParametreAppelant.ID_Ecriture_Appelant;
//    if SensLigneAppel='D' then
//       begin//si sens Debit
//        affectReglement.Sensreglement:=-1;
////        CloneDataSet(TTable(RecupDetteCreance(Tiers_,'C',['4','3'],DateDeb,DateFin,0,0,ListeLettreExclue,True).DataSetResult),DMPointage2.TaAffectReglement).Free;
////        DMPointage2.TaAffectReglement.OnFilterRecord:=nil;
////        GrDbGridInitColonne(AffectReglement.GrDBAffectReg,DMPointage2.DaAffectReglement,DMPointage2.TaAffectReglement,
////                           ['Référence','Libellé','Date','Debit','Credit','Non Pointé','Imputation'],
////                           ['Reference','Libelle','Date','Debit','Credit','ResteAffich','Montant']
////                           ,E.FormatMonnaie,E.EditFormat);
////        DMPointage2.TaAffectReglement.Locate('Reste',MontantAPointer,[loPartialKey]);
//        DMPointage2.LettrageEnCours:=Lettre;
//        DMPointage2.ForceLettrage:=Lettre;
//        result:=AffectReglement.ShowModal= mrOk;
//        //TableRestoreEtatFiltre(TTable(DataSetOrg),EtatFiltre);
////        if result then
//          MontantAPointer:=DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation;
//        defiltragedataset(DataSetOrg);
//        if not result then
//          Begin//si on annule
//            DMPointage2.Gestion_Annulation_Lettrage(DMPointage2.TaAffectReglement,Lettre,'',false);
//            DMPointage2.LettrageEnCours:='';
//            DMPointage2.ForceLettrage:='';
//            TTable(DataSetOrg).locate('ID',ID_Reste_Appelant,[]);
//          End//fin si on annule
//        else
//           Begin//si on confirme
//             if ((ID_Reste_Appelant=0)and(TTable(DataSetOrg).locate('ID_Ecriture',ParametreAppelant.ID_Ecriture_Appelant,[]))) then
//               Begin//si on a récupéré un idecriture
//                   DMPointage2.DaResteDC.OnStateChange:=nil;
//                   DMPointage2.taResteDC.AfterPost:=nil;
//                   DMPointage2.LettrageEnregCourant(DataSetOrg,'A',0);
//                   If Application.messagebox(PChar('Voulez-vous enregistrer le Pointage de ces pièces ?' ),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
//                     begin//si on veut enregistrer directement les pointages en cours
//                     //DMPointage2.supprODDeclaration:=SupprOD;
//                     if not DMPointage2.ValiderPointages(nil,Tiers_,true) then
//                       abort;
//                     end//fin si on veut enregistrer directement les pointages en cours
//                   else
//                     DMPointage2.Gestion_Annulation_Lettrage(DataSetOrg,'A','Voulez-vous conserver les lettrages en cours ?',true);
//                   DMPointage2.taResteDC.AfterPost:=DMPointage2.TaResteDCAfterPost;
//               End//fin si on a récupéré un idecriture
//             else
//               if TTable(DataSetOrg).locate('ID',ID_Reste_Appelant,[]) then
//                 begin //sinon, on travail sur l'idReste
//                   DMPointage2.LettrageEnregCourant(DataSetOrg,'A',0);
//                 end;//fin sinon on travail sur l'idReste
//           End;//fin si on confirme
//       end //fin si sens Debit
//    else
//       begin//si sens Credit
//        affectReglement.Sensreglement:=1;
////        CloneDataSet(TTable(RecupDetteCreance(Tiers_,'D',['4','3'],DateDeb,DateFin,0,0,ListeLettreExclue,True).DataSetResult),DMPointage2.TaAffectReglement).Free;
////       DMPointage2.TaAffectReglement.OnFilterRecord:=nil;
////       GrDbGridInitColonne(AffectReglement.GrDBAffectReg,DMPointage2.DaAffectReglement,DMPointage2.TaAffectReglement,
////                          ['Référence','Libellé','Date','Debit','Credit','Non Pointé','Imputation'],
////                          ['Reference','Libelle','Date','Debit','Credit','ResteAffich','Montant']
////                          ,E.FormatMonnaie,E.EditFormat);
////       DMPointage2.TaAffectReglement.Locate('Reste',MontantAPointer,[loPartialKey]);
//       DMPointage2.LettrageEnCours:=Lettre;
//       DMPointage2.ForceLettrage:=Lettre;
//       result:=AffectReglement.ShowModal= mrOk;
//        if result then
//          MontantAPointer:=DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation;
//       defiltragedataset(DataSetOrg);
//       //TableRestoreEtatFiltre(TTable(DataSetOrg),EtatFiltre);
//       if not result then
//        Begin
//          DMPointage2.Gestion_Annulation_Lettrage(DMPointage2.TaAffectReglement,Lettre,'',false);
//          DMPointage2.LettrageEnCours:='';
//          DMPointage2.ForceLettrage:='';
//          TTable(DataSetOrg).locate('ID',ID_Reste_Appelant,[]);
//        End
//        else
//        Begin
//          if ((ID_Reste_Appelant=0)and(TTable(DataSetOrg).locate('ID_Ecriture',ParametreAppelant.ID_Ecriture_Appelant,[]))) then
//            Begin//si on a récupéré un idecriture
//                DMPointage2.taResteDC.AfterPost:=nil;
//                DMPointage2.DaResteDC.OnStateChange:=nil;
//                DMPointage2.LettrageEnregCourant(DataSetOrg,'A',0);
//                If Application.messagebox(PChar('Voulez-vous enregistrer le Pointage de ces pièces ?' ),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
//                  begin//si on veut enregistrer directement les pointages en cours
//                  //DMPointage2.supprODDeclaration:=SupprOD;
//                  if not DMPointage2.ValiderPointages(nil,Tiers_,true) then
//                    abort;
//                  end//fin si on veut enregistrer directement les pointages en cours
//                else
//                  DMPointage2.Gestion_Annulation_Lettrage(DataSetOrg,'A','Voulez-vous conserver les lettrages en cours ?',true);
//                DMPointage2.taResteDC.AfterPost:=DMPointage2.TaResteDCAfterPost;
//            End//fin si on a récupéré un idecriture
//          else
//            if TTable(DataSetOrg).locate('ID',ID_Reste_Appelant,[]) then
//              begin //sinon, on travail sur l'idReste
//                DMPointage2.LettrageEnregCourant(DataSetOrg,'A',0);
//              end;//fin sinon on travail sur l'idReste
//        End;
//     end;//fin si sens Credit
//
//   DMPointage2.ForceLettrage:='';
//   TableRestoreEtatFiltre(TTable(DataSetOrg),EtatFiltre);
//
//end;
Function AffectReglementAffiche(DataSetOrg:TDataSet;TraiterDataSetOrg,GererListe:Boolean;Tiers_,Lettre,SensLigneAppel : string; var MontantAPointer:currency;DateDeb,DateFin:TDate;ListeLettreExclue:TStringList;ParametreAppelant:TParamAffichPointage;Acces:boolean):boolean;
var
EtatFiltre:TEtatFiltre;
ID_Reste_Appelant,i:Integer;
sommePointe:currency;
begin
if acces then
begin
if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(application.MainForm);
if DataSetOrg = nil then abort;
TableSauveEtatFiltre(TTable(DataSetOrg),EtatFiltre);
if AffectReglement = nil then
   AffectReglement:=TAffectReglement.Create(Application.MainForm);

if GererListe then
  Begin//si on gere la liste, supprimer tous les lettrages et remplacer par les lettrages correspondant
       //à l'id_Ligne_Appelant
    try
    sommePointe:=0;
    DMPointage2.Initialisation_Liste;
    DMPointage2.TaResteDC.AfterPost:=nil;
    DMPointage2.SuppressionLettrage_Tous_ApresGestionDesPointages(DMPointage2.TaResteDC,nil);
    if DMPointage2.ListeID_Appelant.Count<>0 then
      Begin//si ListeID_Appelant existe
      i:=0;
      while i<DMPointage2.ListeID_Appelant.count do
        //for i:=0 to DMPointage2.ListeID_Appelant.count-1 do
          Begin//début boucle for
            if PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.ID_Ligne_Appelant=ParametreAppelant.ID_Ecriture_Appelant then
              Begin//si
                 //se positionner sur idreste
                 if (PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Montant<=ParametreAppelant.Montant_Appelant)and(sommePointe+PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Montant<=ParametreAppelant.Montant_Appelant) then
                 begin
                   if DMPointage2.TaResteDC.Locate('id',PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.ID_Reste,[])then
                     begin
                       DMPointage2.LettrageEnregCourant(DMPointage2.TaResteDC,PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Lettre,PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Montant);
                       sommePointe:=sommePointe+PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Montant;
                     end;
                 end
                 else
                   begin
                     DMPointage2.ListeID_Appelant.delete(i);
                     dec(i);
//                   if DMPointage2.TaResteDC.Locate('id',PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.ID_Reste,[])then
//                     begin
//                       DMPointage2.LettrageEnregCourant(DMPointage2.TaResteDC,PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Lettre,ParametreAppelant.Montant_Appelant);
//                       PListeResteAffect(DMPointage2.ListeID_Appelant.items[i])^.Montant:=ParametreAppelant.Montant_Appelant;
//                     end;
                   end;
              End;//fin si
              inc(i);
          End;//fin boucle for
      End;//fin si ListeID_Appelant existe
    finally
      DMPointage2.TaResteDC.AfterPost:=DMPointage2.TaResteDCAfterPost;
    end;//fin du try finally
  End;//fin si on gere la liste

if TraiterDataSetOrg then
 begin
   if DMPointage2.RecupListeLettre_surDataset(DataSetOrg,false).Result then
      begin
        Showmessage('Un lettrage est déjà en cours, vous devez le valider !!!');
        result:=false;
        abort;
      end;
    Tiers_:=DataSetOrg.findfield('Tiers').AsString;
    ID_Reste_Appelant:=DataSetOrg.findfield('ID').AsInteger;
    MontantAPointer:=DataSetOrg.findfield('Reste').AsCurrency;
    AffectReglement.MontantARegler:=MontantAPointer;
    if not VerifFNumeric(DataSetOrg.findfield('Debit')).VideOUZero then
      Begin//si ligne au debit
         SensLigneAppel:='D';
         affectReglement.MontantReglement:=DataSetOrg.findfield('Debit').ascurrency;
      End//fin si ligne au debit
    else
      Begin//si ligne au Credit
        SensLigneAppel:='C';
        affectReglement.MontantReglement:=DataSetOrg.findfield('Credit').ascurrency;
      End;//fin si ligne au Credit
    // Attention, si ListeLEttreExclu <> nil possible duplication de lettrage
    // A Traiter
    if empty(Lettre) then Lettre:='A';
 end
   else
   begin
    Tiers_:=ParametreAppelant.CptTiers;
    ID_Reste_Appelant:=ParametreAppelant.ID_Reste_Appelant;
    AffectReglement.MontantARegler:=ParametreAppelant.Reste_Appelant;
    affectReglement.MontantReglement:=ParametreAppelant.Montant_Appelant;
    SensLigneAppel:=ParametreAppelant.SensAppelant;
    // Attention, si ListeLEttreExclu <> nil possible duplication de lettrage
    // A Traiter
    if empty(Lettre) then Lettre:='A';
 end;
 AffectReglement.EdCompte.Text:=Tiers_;
 DMPointage2.IDEcritureAppelanteLoc:=ParametreAppelant.ID_Ecriture_Appelant;
    if SensLigneAppel='D' then
       begin//si sens Debit
        affectReglement.Sensreglement:=-1;
//        CloneDataSet(TTable(RecupDetteCreance(Tiers_,'C',['4','3'],DateDeb,DateFin,0,0,ListeLettreExclue,True).DataSetResult),DMPointage2.TaAffectReglement).Free;
//        DMPointage2.TaAffectReglement.OnFilterRecord:=nil;
//        GrDbGridInitColonne(AffectReglement.GrDBAffectReg,DMPointage2.DaAffectReglement,DMPointage2.TaAffectReglement,
//                           ['Référence','Libellé','Date','Debit','Credit','Non Pointé','Imputation'],
//                           ['Reference','Libelle','Date','Debit','Credit','ResteAffich','Montant']
//                           ,E.FormatMonnaie,E.EditFormat);
        DMPointage2.TaAffectReglement.Locate('Reste',MontantAPointer,[loPartialKey]);
        DMPointage2.LettrageEnCours:=Lettre;
        DMPointage2.ForceLettrage:=Lettre;
        result:=AffectReglement.ShowModal= mrOk;
        //TableRestoreEtatFiltre(TTable(DataSetOrg),EtatFiltre);
//        if result then
          MontantAPointer:=DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation;
        defiltragedataset(DataSetOrg);
        if not result then
          Begin//si on annule
            DMPointage2.Gestion_Annulation_Lettrage(DMPointage2.TaAffectReglement,Lettre,'',false);
            DMPointage2.LettrageEnCours:='';
            DMPointage2.ForceLettrage:='';
            TTable(DataSetOrg).locate('ID',ID_Reste_Appelant,[]);
          End//fin si on annule
        else
           Begin//si on confirme
             if ((ID_Reste_Appelant=0)and(TTable(DataSetOrg).locate('ID_Ecriture',ParametreAppelant.ID_Ecriture_Appelant,[]))) then
               Begin//si on a récupéré un idecriture
                   DMPointage2.DaResteDC.OnStateChange:=nil;
                   DMPointage2.taResteDC.AfterPost:=nil;
                   DMPointage2.LettrageEnregCourant(DataSetOrg,'A',0);
                   If Application.messagebox(PChar('Voulez-vous enregistrer le Pointage de ces pièces ?' ),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
                     begin//si on veut enregistrer directement les pointages en cours
                     //DMPointage2.supprODDeclaration:=SupprOD;
                     if not DMPointage2.ValiderPointages(nil,Tiers_,true) then
                       abort;
                     end//fin si on veut enregistrer directement les pointages en cours
                   else
                     DMPointage2.Gestion_Annulation_Lettrage(DataSetOrg,'A','Voulez-vous conserver les lettrages en cours ?',true);
                   DMPointage2.taResteDC.AfterPost:=DMPointage2.TaResteDCAfterPost;
               End//fin si on a récupéré un idecriture
             else
               if TTable(DataSetOrg).locate('ID',ID_Reste_Appelant,[]) then
                 begin //sinon, on travail sur l'idReste
                   DMPointage2.LettrageEnregCourant(DataSetOrg,'A',0);
                 end;//fin sinon on travail sur l'idReste
           End;//fin si on confirme
       end //fin si sens Debit
    else
       begin//si sens Credit
  // A conserver mais n'est pas fini,
  // conserver plutot la solution existante !!!!
  //     DMPointage2.TaAffectReglement:=TTable(RecupDetteCreance(Tiers,'','D',DateDeb,DateFin,0,0,ListeLettreExclue).DataSetResult);
  //     DMPointage2.DaAffectReglement.DataSet:=DMPointage2.TaAffectReglement;
  //     DMPointage2.TaAffectReglement.IndexFieldNames:='Tiers;Reste;Date;Reference';
  //     DMPointage2.TaAffectReglement.Refresh;
       affectReglement.Sensreglement:=1;
//       CloneDataSet(TTable(RecupDetteCreance(Tiers_,'D',['4','3'],DateDeb,DateFin,0,0,ListeLettreExclue,True).DataSetResult),DMPointage2.TaAffectReglement).Free;
//       DMPointage2.TaAffectReglement.OnFilterRecord:=nil;
//       GrDbGridInitColonne(AffectReglement.GrDBAffectReg,DMPointage2.DaAffectReglement,DMPointage2.TaAffectReglement,
//                          ['Référence','Libellé','Date','Debit','Credit','Non Pointé','Imputation'],
//                          ['Reference','Libelle','Date','Debit','Credit','ResteAffich','Montant']
//                          ,E.FormatMonnaie,E.EditFormat);
       DMPointage2.TaAffectReglement.Locate('Reste',MontantAPointer,[loPartialKey]);
       DMPointage2.LettrageEnCours:=Lettre;
       DMPointage2.ForceLettrage:=Lettre;
       result:=AffectReglement.ShowModal= mrOk;
        if result then
          MontantAPointer:=DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation;
       defiltragedataset(DataSetOrg);
       //TableRestoreEtatFiltre(TTable(DataSetOrg),EtatFiltre);
       if not result then
        Begin
          DMPointage2.Gestion_Annulation_Lettrage(DMPointage2.TaAffectReglement,Lettre,'',false);
          DMPointage2.LettrageEnCours:='';
          DMPointage2.ForceLettrage:='';
          TTable(DataSetOrg).locate('ID',ID_Reste_Appelant,[]);
        End
        else
        Begin
          if ((ID_Reste_Appelant=0)and(TTable(DataSetOrg).locate('ID_Ecriture',ParametreAppelant.ID_Ecriture_Appelant,[]))) then
            Begin//si on a récupéré un idecriture
                DMPointage2.taResteDC.AfterPost:=nil;
                DMPointage2.DaResteDC.OnStateChange:=nil;
                DMPointage2.LettrageEnregCourant(DataSetOrg,'A',0);
                If Application.messagebox(PChar('Voulez-vous enregistrer le Pointage de ces pièces ?' ),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
                  begin//si on veut enregistrer directement les pointages en cours
                  //DMPointage2.supprODDeclaration:=SupprOD;
                  if not DMPointage2.ValiderPointages(nil,Tiers_,true) then
                    abort;
                  end//fin si on veut enregistrer directement les pointages en cours
                else
                  DMPointage2.Gestion_Annulation_Lettrage(DataSetOrg,'A','Voulez-vous conserver les lettrages en cours ?',true);
                DMPointage2.taResteDC.AfterPost:=DMPointage2.TaResteDCAfterPost;
            End//fin si on a récupéré un idecriture
          else
            if TTable(DataSetOrg).locate('ID',ID_Reste_Appelant,[]) then
              begin //sinon, on travail sur l'idReste
                DMPointage2.LettrageEnregCourant(DataSetOrg,'A',0);
              end;//fin sinon on travail sur l'idReste
        End;
     end;//fin si sens Credit

   DMPointage2.ForceLettrage:='';
   TableRestoreEtatFiltre(TTable(DataSetOrg),EtatFiltre);
end//fin si acces accordé
else
  MessageDlg(AccesEcranRefuse_General, mtInformation, [mbOK], 0);
end;


Function GestionAffichagePointageSurRef(Pointage_Auto:boolean;AnnulerSiLettrageEnCours:boolean;ParamAffichPointage:TParamAffichPointage;Acces:boolean):Boolean;
Var
InfosJournal:TInfosModel;
BookMark:TBookMark;
ID_Reste_Appelant,i:integer;
ListeARegler,ListeReglement:tlist;
EcritureARegler:TEcriture_A_Regler;
coord:trect;
MontantAPointer:currency;
begin
try
if ParamAffichPointage.ALettrer then // Gestion sur F5 (A Pointer)
 begin
//Initialise_TParamAffichPointage(ParamAffichPointage);
//if ParamAffichPointage.ID_Reste_Appelant<>0 then
//  ID_Reste_Appelant:=ParamAffichPointage.ID_Reste_Appelant
//else
  if Acces then
    begin
        ID_Reste_Appelant:=ParamAffichPointage.ID_Ecriture_Appelant;
        InfosJournal:=DMJournal.InfosJournal_Reference(ParamAffichPointage.Reference);
        if InfosJournal.ResultInfos then
        case InfosJournal.ID_Journal of
          // Achat
          1:Begin
             // Si totalement pointé, Détail Pointage
             if not DMPointage2.InfosPointageSurResteDC(ID_Reste_Appelant).ResteAPointee then
              begin
                DetailPointageAffich(ParamAffichPointage.CptTiers,IntTOStr(ID_Reste_Appelant),0,true,true)
              end
              else  // Si partiellement pointé ou non pointé, Saisie Règlement
              begin
                ListeARegler:=TList.Create;
                EcritureARegler:=Ecriture_A_Regler(ID_Reste_Appelant);
                ListEcriture_A_Regler_Add_Insert(ListeARegler,[EcritureARegler.ID_Ecriture,EcritureARegler.Tiers_,EcritureARegler.Montant,EcritureARegler.Sens,'5121',EcritureARegler.TvaSurE],true,false,-1);
                ListeReglement:=ReglementSurListe_Creation(coord,false,true,true,ListeARegler);
                //si lettrage en cours, compléter le lettrage avec les nouveaux réglements
                //sinon, créer un nouveau lettrage pour chaque nouveaux réglement
                if ListeReglement<>nil then
                     Lettrage_Sur_Liste_Affich(AnnulerSiLettrageEnCours,DMPointage2.TaResteDC,ListeReglement,false,false,DMPointage2.LettrageEnCours);
              end;
            End;
          // Vente
          2:Begin
             // Si totalement pointé, Détail Pointage
             if not DMPointage2.InfosPointageSurResteDC(ID_Reste_Appelant).ResteAPointee then
              begin
                DetailPointageAffich(ParamAffichPointage.CptTiers,IntTOStr(ID_Reste_Appelant),0,true,true)
              end
              else // Si partiellement pointé ou non pointé, creation Règlement
              begin
                ListeARegler:=TList.Create;
                EcritureARegler:=Ecriture_A_Regler(ID_Reste_Appelant);
                ListEcriture_A_Regler_Add_Insert(ListeARegler,[EcritureARegler.ID_Ecriture,EcritureARegler.Tiers_,EcritureARegler.Montant,EcritureARegler.Sens,'5121',EcritureARegler.TvaSurE],true,false,-1);
                ListeReglement:=ReglementSurListe_Creation(coord,false,true,true,ListeARegler);
                //si lettrage en cours, compléter le lettrage avec les nouveaux réglements
                //sinon, créer un nouveau lettrage pour chaque réglement nouveaux
                if ListeReglement<>nil then
                     Lettrage_Sur_Liste_Affich(AnnulerSiLettrageEnCours,DMPointage2.TaResteDC,ListeReglement,false,false,DMPointage2.LettrageEnCours);
              end;
            end;
          // OD
          3:Begin

            End;

          // Banque
          4:Begin
             // Si totalement pointé, Détail Pointage
             if not DMPointage2.InfosPointageSurResteDC(ID_Reste_Appelant).ResteAPointee then
              begin
                DetailPointageAffich(ParamAffichPointage.CptTiers,IntTOStr(ID_Reste_Appelant),0,true,true)
              end
              else // Si partiellement pointé ou non pointé, Affect Reglement
              begin
               // if ParamAffichPointage.SensAppelant='D'then
                AffectReglementAffiche(DMPointage2.TaResteDC,not Pointage_Auto,false,'','A','',ParamAffichPointage.Reste_Appelant,0,0,nil,ParamAffichPointage);
              end;

      ////      ID_Reste_Appelant:=0;
      ////      ID_Reste_Appelant:=GrDBPointage.DataSource.DataSet.FindField('ID').AsInteger;
      //      if AffectReglementAffiche(DMPointage2.TaResteDC,true,'','A','',0,E.DatExoDebut,E.DatExoFin,nil) then
      //       begin
      ////         DMPointage2.DaResteDC.OnStateChange:=ChangementEtatGrille;
      ////         EdCompteExit(EdCompte);
      ////         ChangementEtatGrille(DMPointage2.TaResteDC);
      ////         if TTable(GrDBPointage.DataSource.DataSet).locate('ID',ParamAffichPointage.ID_Reste_Appelant,[]) then
      ////          begin
      ////            DMPointage2.LettrageEnregCourant(DMPointage2.TaResteDC,'A',0);
      ////          end;
      //       end
      //       else
      //       begin
      ////         DMPointage2.DaResteDC.OnStateChange:=ChangementEtatGrille;
      ////         EdCompteExit(EdCompte);
      ////         ChangementEtatGrille(DMPointage2.TaResteDC);
      ////         TTable(GrDBPointage.DataSource.DataSet).locate('ID',ID_Reste_Appelant,[])
      ////         DMPointage2.ForceLettrage:='';
      //       end;

            End;
        end;//fin du case InfosJournal.ID_Journal
    end//fin si acces accordé
  else
      MessageDlg(AccesEcranRefuse_General, mtInformation, [mbOK], 0);
 end
else
 begin // Gestion sur Ctrl+F5 (Visu Pointage)
   if DMPointage2.InitTableVisuPointage(ParamAffichPointage.CptTiers,0,ParamAffichPointage.DateDeb,ParamAffichPointage.DateFin,'') then
    begin
      if VisuPointage = nil then
      VisuPointage:=TVisuPointage.Create(Application.MainForm);
      VisuPointage.show;
    end
    else
    begin
     Showmessage('Aucune écritures pour le tiers : '+ParamAffichPointage.CptTiers+' ,'+RetourChariotDouble+'dans la période du '+DateInfos(ParamAffichPointage.DateDeb).DateStr+' au '+DateInfos(ParamAffichPointage.DateFin).DateStr+' !');
    end;
 end;
finally
Initialise_TList(ListeARegler);
 if ListeReglement<>nil then
   begin
      for i:=0 to ListeReglement.Count-1 do
         begin
             if TEcriture_Isa(ListeReglement.Items[i]).piece.trame<>nil then
               TEcriture_Isa(ListeReglement.Items[i]).piece.trame.free;
             TEcriture_Isa(ListeReglement.Items[i]).piece.free;
             TEcriture_Isa(ListeReglement.Items[i]).free;
         end;
      ListeReglement.Clear;
      LibereObjet(tobject(ListeReglement));
   end;
end;//fin du try finally
End;

Function GestionAffichagePointageSurCompte(ParamAffichPointage:TParamAffichPointage;Acces:boolean):Boolean;
Begin
if ParamAffichPointage.ALettrer then // Gestion sur F5 (A Pointer)
 begin
      if acces then
      begin
      //  if RecupDetteCreance(ParamAffichPointage.CptTiers,'',[''],ParamAffichPointage.DateDeb,ParamAffichPointage.DateFin,0,0,nil,False).ComptePointable then
        if RecupDetteCreance('',ParamAffichPointage.CptTiers,'',[''],ParamAffichPointage.DateDeb,ParamAffichPointage.DateFin,0,0,nil,False).NBLigneResteAPointer>0 then
         begin
           if (Pointages2= nil) Then Pointages2:= TPointages2.Create(Application.MainForm);
           Pointages2.EdCompte.Text:=ParamAffichPointage.CptTiers;
           Pointages2.ShowModal;
         end
         else
         Begin
         if DMPointage2.InitTableVisuPointage(ParamAffichPointage.CptTiers,0,ParamAffichPointage.DateDeb,ParamAffichPointage.DateFin,'') then
          begin
            ShowMessage('Il ne reste aucune écritures à pointer pour le tiers : '+ParamAffichPointage.CptTiers+' ,'+RetourChariotDouble+'dans la période du '+DateInfos(ParamAffichPointage.DateDeb).DateStr+' au '+DateInfos(ParamAffichPointage.DateFin).DateStr+' !');
            if VisuPointage = nil then
            VisuPointage:=TVisuPointage.Create(Application.MainForm);
            VisuPointage.show;
          end
          else
          begin
           Showmessage('Aucune écritures pour le tiers : '+ParamAffichPointage.CptTiers+' ,'+RetourChariotDouble+'dans la période du '+DateInfos(ParamAffichPointage.DateDeb).DateStr+' au '+DateInfos(ParamAffichPointage.DateFin).DateStr+' !');
          end;
         end;
      end//fin si acces accordé
      else
        MessageDlg(AccesEcranRefuse_General, mtInformation, [mbOK], 0);
 end
 else
 begin // Gestion sur Ctrl+F5 (Visu Pointage)
   if DMPointage2.InitTableVisuPointage(ParamAffichPointage.CptTiers,0,ParamAffichPointage.DateDeb,ParamAffichPointage.DateFin,'') then
    begin
      if VisuPointage = nil then
      VisuPointage:=TVisuPointage.Create(Application.MainForm);
      VisuPointage.show;
    end
    else
    begin
     Showmessage('Aucune écritures pour le tiers : '+ParamAffichPointage.CptTiers+' ,'+RetourChariotDouble+'dans la période du '+DateInfos(ParamAffichPointage.DateDeb).DateStr+' au '+DateInfos(ParamAffichPointage.DateFin).DateStr+' !');
    end;
 end;
End;

procedure TDMPointage2.DMPointage2Create(Sender: TObject);
begin
ListeLettreUtil:=TStringList.Create;
ListeDettesAffich:=TStringList.Create;
ListecompteAffich:=TStringList.Create;
ListeTiersAffich:=TStringList.Create;
ListeEcritureFilterRecord:=TStringList.Create;
TypeDettes:='';
ForceLettrage:='';
OuvrirTouteTable('',Tcontrol(self));
end;

procedure TDMPointage2.DMPointage2Destroy(Sender: TObject);
begin
//if ListeLettreUtil<>nil then
// begin
//    LibereObjet(Tobject(ListeLettreUtil));
// end;
Initialise_TStringlist(ListeLettreUtil);
Initialise_TStringlist(ListeDettesAffich);
Initialise_TStringlist(ListecompteAffich);
Initialise_TStringlist(ListeTiersAffich);
Initialise_TStringlist(ListeEcritureFilterRecord);
FermerTouteTable('',TControl(self));
DMPointage2:=nil;
end;

Function TDMPointage2.CtrlSaisiePointage(CCourant:TField):TErreurSaisie;
Var
OldValue:currency;
Begin
//
result.retour:=true;
result.CodeErreur:=0;
case CCourant.DataSet.State of
   dsEdit:Begin
             case CCourant.Index of
                 //Lettre
                11:Begin
                       if empty(CCourant.AsString) then
                        Begin
                          CCourant.DataSet.FindField('Montant').AsString:='';
                          result.retour:=false;
                          result.CodeErreur:=1102;
                        End
                        else
                        begin
                         if empty(LettrageEnCours) then
                           LettrageEnCours:=CCourant.AsString;

                         if LettrageEnCours <> CCourant.AsString then
                            begin
                              OldValue:=CCourant.DataSet.FindField('Montant').AsCurrency;
                              if VerifFNumeric(CCourant.DataSet.FindField('Montant')).VideOUZero then
                               if not VerifFNumeric(CCourant.DataSet.FindField('Debit')).VideOUZero then
                                begin
                                 CCourant.DataSet.FindField('Montant').AsCurrency:=CCourant.DataSet.FindField('Reste').AsCurrency;
                                end;

   //                           if CalculLettrageEnCours(LettrageEnCours,CCourant.DataSet.FindField('Montant').AsCurrency,CCourant.DataSet.FindField('Sens').AsString).Equilibre = false then
                              if CalculLettrageEnCours(nil,CCourant.DataSet.FindField('Tiers').AsString,LettrageEnCours,0,CCourant.DataSet.FindField('Sens').AsString).Equilibre = false then
                               Begin
                                 CCourant.DataSet.FindField('Montant').AsCurrency:=OldValue;
                                 CCourant.AsString:='';
                                 result.retour:=false;
                                 result.CodeErreur:=1101;
                                 showmessage('Le pointage pour la lettre : '+ LettrageEnCours + ' n''est pas équilibré !');
                                 abort;
                               End
                               else
                               begin
                                 LettrageEnCours:=CCourant.AsString;
                               end;
                            end
                            else
                            begin
                              if VerifFNumeric(CCourant.DataSet.FindField('Montant')).VideOUZero then
                               if not VerifFNumeric(CCourant.DataSet.FindField('Debit')).VideOUZero then
                                begin
                                 CCourant.DataSet.FindField('Montant').AsCurrency:=CCourant.DataSet.FindField('Reste').AsCurrency;
                                end
                                else
                                begin
                                 CCourant.DataSet.FindField('Montant').AsCurrency:=CCourant.DataSet.FindField('Reste').AsCurrency;
                                end;
                            end;
                        end;
                  End;// Fin de Lettre

                 // Montant
                12:Begin
                    if VerifFNumeric(CCourant).VideOUZero then
                     begin
                       CCourant.DataSet.FindField('Lettre').AsString:='';
                       CCourant.AsString:='';
                     end
                    else
                      if ((result.retour) and (CCourant.AsCurrency > CCourant.DataSet.FindField('Reste').AsCurrency)) then
                       begin
                         result.retour:=false;
                         result.CodeErreur:=1202;
                         showmessage('Le montant imputé doit être inférieur ou égal au reste !');
                       end;
                       if ((result.retour)and(CCourant.AsString<>'')) then
                         if empty(LettrageEnCours) then
                             LettrageEnCours:='a'
                             else
                             begin
                             CCourant.DataSet.FindField('Lettre').AsString:=LettrageEnCours;
                             if VerifFNumeric(CCourant.DataSet.FindField('Montant')).VideOUZero then
                               CCourant.AsCurrency:=CCourant.DataSet.FindField('Reste').AsCurrency;
                             end;
                   End;
             end;
          End;
end;

End;

Function TDMPointage2.CalculLettrageEnCours(DatasetEnCours:TDataset;Tiers:String;LettrageEnCours:string;ValeurEnCours:currency;Sens:String):TResteDCInfoLettrageEnCours;
var
SensLettre:string;
DatasetTmp:TDataset;
TableTmp:TTable;
QueryTmp:TQuery;
filtre:string;
IDTmp:Integer;
Begin
try//finally
if not TaResteRecherche.Active then TaResteRecherche.Open;
Initialise_ResteDCInfoLettrageEnCours(result);
SensLettre:='C';
if DatasetEnCours <> nil then
  begin
    TaResteRecherche.Filter:=DatasetEnCours.filter;

  if LettrageEnCours='*' then
    Begin//si
      if empty(TaResteRecherche.Filter)then
      filtre:= 'lettre <> '''''
      else
      filtre:=TaResteRecherche.Filter+ 'And lettre <> ''''';
    End//fin si
  else
    Begin//si
      if empty(TaResteRecherche.Filter)then
      filtre:= 'lettre = '''+LettrageEnCours+''''
      else
      filtre:=TaResteRecherche.Filter+ 'And lettre = '''+LettrageEnCours+'''';
    End;//fin si
    TaResteRecherche.Filter:=filtre;
  result.TotalMontantImputationSensC:=0;
  if sens=SensLettre then
    result.TotalMontantImputationSensC:=SommeTotauxGeneric(['Montant'],TaResteRecherche).Total1
    else
      if empty(sens)then
        begin
          FiltrageDataSet(dmrech.TaResteDCRech,TaResteRecherche.filter+' and sens=''C''');
          result.TotalMontantImputationSensC:=SommeTotauxGeneric(['Montant'],dmrech.TaResteDCRech).Total1 ;
          DeFiltrageDataSet(dmrech.TaResteDCRech);
        end;
  end
else
  begin
      if LettrageEnCours='*' then
         filtre:=CreeFiltreET(['Tiers','Sens'],[Tiers,SensLettre])+ 'And lettre <> '''''
       else
        filtre:=CreeFiltreET(['Tiers','Lettre','Sens'],[Tiers,LettrageEncours,SensLettre]);
      filtrageDataset(TaResteRecherche,filtre);
      result.TotalMontantImputationSensC:=SommeTotauxGeneric(['Montant'],TaResteRecherche).Total1;
  end;

if (Sens = 'C') then result.TotalMontantImputationSensC:=result.TotalMontantImputationSensC + ValeurEnCours;

SensLettre:='D';
if DatasetEnCours<>nil then
  begin
    TaResteRecherche.Filter:=DatasetEnCours.filter;
  if LettrageEnCours='*' then
    Begin//si
      if empty(TaResteRecherche.Filter)then
      filtre:= 'lettre <> '''''
      else
      filtre:=TaResteRecherche.Filter+ 'And lettre <> ''''';
    End//fin si
  else
    Begin//si
      if empty(TaResteRecherche.Filter)then
      filtre:= 'lettre = '''+LettrageEnCours+''''
      else
      filtre:=TaResteRecherche.Filter+ 'And lettre = '''+LettrageEnCours+'''';
    End;//fin si
    TaResteRecherche.Filter:=filtre;
    result.TotalMontantImputationSensD:=0;
    if sens=senslettre then
      result.TotalMontantImputationSensD:=SommeTotauxGeneric(['Montant'],TaResteRecherche).Total1
    else
      if empty(sens)then
        begin
          FiltrageDataSet(dmrech.TaResteDCRech,TaResteRecherche.filter+' and sens=''D''');
          result.TotalMontantImputationSensD:=SommeTotauxGeneric(['Montant'],dmrech.TaResteDCRech).Total1 ;
          DeFiltrageDataSet(dmrech.TaResteDCRech);
        end;
  end
else
  begin
    if LettrageEnCours='*' then
       Filtre:=CreeFiltreET(['Tiers','Sens'],[Tiers,SensLettre])+ 'And lettre <> '''''
    else
       Filtre:=CreeFiltreET(['Tiers','Lettre','Sens'],[Tiers,LettrageEncours,SensLettre]);
    filtrageDataset(TaResteRecherche,filtre);
    result.TotalMontantImputationSensD:=SommeTotauxGeneric(['Montant'],TaResteRecherche).Total1;
  end;

if (Sens = 'D') then result.TotalMontantImputationSensC:=result.TotalMontantImputationSensC + ValeurEnCours;

result.Equilibre:=(result.TotalMontantImputationSensD=result.TotalMontantImputationSensC);
result.SoldeTotalImputationAuDebit:=result.TotalMontantImputationSensD > result.TotalMontantImputationSensC;
result.SoldeTotalImputation:=abs(result.TotalMontantImputationSensD - result.TotalMontantImputationSensC);
if DatasetEnCours = nil then
  begin//si on travail sur taRecherche, pour l'instant, on remonte tous les restes depuis le début
//   TaResteRecherche.Filter:='Tiers = '''+Tiers+''' and date >='''+DateToStr(E.DatExoDebut)+''' and date <='''+DateToStr(E.DatExoFin)+'''';
   Filtre:='Tiers = '''+Tiers+''' and date >='''+DateToStr(0)+''' and date <='''+DateToStr(E.DatExoFin)+'''';
   filtrageDataset(TaResteRecherche,filtre);
   TaResteRecherche.First;
   While not TaResteRecherche.EOF do
    begin
     if TaResteRecherche.FindField('Sens').AsString = 'C' then
      begin
       Result.TotalCreditMvt:=TaResteRecherche.FindField('Credit').AsCurrency + Result.TotalCreditMvt;
       Result.TotalResteCredit:=TaResteRecherche.FindField('Reste').AsCurrency + Result.TotalResteCredit;
      end;

     if TaResteRecherche.FindField('Sens').AsString = 'D' then
      begin
       Result.TotalDebitMvt:=TaResteRecherche.FindField('Debit').AsCurrency + Result.TotalDebitMvt;
       Result.TotalResteDebit:=TaResteRecherche.FindField('Reste').AsCurrency + Result.TotalResteDebit;
      end;
     TaResteRecherche.Next;
    end;
  end//fin si on travail sur taRecherche
else
  Begin//si on travail sur table en cours
   // Demander à isa si important de se servir d'un dataSet temporaire ????????????????????????
    case RecupClassTypeComponent(DataSetEnCours) of
       GTable:begin
//               TableTmp:=TTable.Create(self);
//               TableTmp:=(CloneDataSet(DatasetEnCours,nil) as TTable);
               IDTmp:=DataSetEnCours.findField('ID').AsInteger;
               DataSetEnCours.DisableControls;
               DataSetEnCours.First;
               While not DataSetEnCours.EOF do
                begin
                 if DataSetEnCours.FindField('Sens').AsString = 'C' then
                  begin
                   Result.TotalCreditMvt:=DataSetEnCours.FindField('Credit').AsCurrency + Result.TotalCreditMvt;
                   Result.TotalResteCredit:=DataSetEnCours.FindField('Reste').AsCurrency + Result.TotalResteCredit;
                  end;

                 if DataSetEnCours.FindField('Sens').AsString = 'D' then
                  begin
                   Result.TotalDebitMvt:=DataSetEnCours.FindField('Debit').AsCurrency + Result.TotalDebitMvt;
                   Result.TotalResteDebit:=DataSetEnCours.FindField('Reste').AsCurrency + Result.TotalResteDebit;
                  end;
                 DataSetEnCours.Next;
                end;
                 DataSetEnCours.EnableControls;
                 DataSetEnCours.Locate('ID',IDTmp,[]);
//               TableTmp.Close;
//               TableTmp.Free;
              end;
       GTQuery:begin
//                QueryTmp:=TQuery.Create(self);
//                QueryTmp:=(CloneDataSet(DatasetEnCours,nil) as TQuery);
                DataSetEnCours.First;
                While not DataSetEnCours.EOF do
                 begin
                  if DataSetEnCours.FindField('Sens').AsString = 'C' then
                   begin
                    Result.TotalCreditMvt:=DataSetEnCours.FindField('Credit').AsCurrency + Result.TotalCreditMvt;
                    Result.TotalResteCredit:=DataSetEnCours.FindField('Reste').AsCurrency + Result.TotalResteCredit;
                   end;

                  if DataSetEnCours.FindField('Sens').AsString = 'D' then
                   begin
                    Result.TotalDebitMvt:=DataSetEnCours.FindField('Debit').AsCurrency + Result.TotalDebitMvt;
                    Result.TotalResteDebit:=DataSetEnCours.FindField('Reste').AsCurrency + Result.TotalResteDebit;
                   end;
                  DataSetEnCours.Next;
                 end;
//                QueryTmp.Free;
               end;
    end;

//   DatasetTmp:=TDataSet.Create(self);
//   DatasetTmp:=CloneDataSet(DatasetEnCours,nil);
//   DatasetTmp.First;
//   While not DatasetTmp.EOF do
//    begin
//     if DatasetTmp.FindField('Sens').AsString = 'C' then
//      begin
//       Result.TotalCreditMvt:=DatasetTmp.FindField('Credit').AsCurrency + Result.TotalCreditMvt;
//       Result.TotalResteCredit:=DatasetTmp.FindField('Reste').AsCurrency + Result.TotalResteCredit;
//      end;
//
//     if DatasetTmp.FindField('Sens').AsString = 'D' then
//      begin
//       Result.TotalDebitMvt:=DatasetTmp.FindField('Debit').AsCurrency + Result.TotalDebitMvt;
//       Result.TotalResteDebit:=DatasetTmp.FindField('Reste').AsCurrency + Result.TotalResteDebit;
//      end;
//     DatasetTmp.Next;
//    end;
//   DatasetTmp.Free;
  End;//fin si on travail sur table en cours
// Calcul des soldes

result.SoldeMvtAuDebit:=result.TotalDebitMvt > result.TotalCreditMvt;
result.SoldeMvt:=abs(result.TotalDebitMvt - result.TotalCreditMvt);

result.SoldeResteAuDebit:=result.TotalResteDebit > result.TotalResteCredit;
result.SoldeReste:=abs(result.TotalResteDebit - result.TotalResteCredit);

DeFiltrageDataSet(TaResteRecherche);
//TaResteRecherche.Filter:='';
//TaResteRecherche.Filtered:=False;
finally
//  DatasetTmp.free;
end;
//if DatasetTmp <> nil then
//DatasetTmp.Free;
End;

Function TDMPointage2.LettrageAutomatique(DataSet:TDataSet;Tiers:String;DateDeb,DateFin:TDate;ForcerFiltrage:boolean):integer;
Var
OldFiltre,F1,F1Tmp,F2,filtre:String;
OldFilterd,ModifFiltre,PasserSuivant:boolean;
BookMarkLettrage:TBookmark;
DataSetDeb,DataSetCre:TTable;
i,NumPointage:integer;
Crestant,Drestant:boolean;
Begin
ModifFiltre:=false;
filtre:='';
result:=0;
if DataSet = nil then abort;
if not DataSet.Active then abort;
if ((not DataSet.Filtered)or(ForcerFiltrage)) then
 begin
 if empty(Tiers) then
  abort
  else
   begin
    OldFiltre:=DataSet.Filter;
    OldFilterd:=DataSet.Filtered;
    ModifFiltre:=true;
    if ((dataset.filtered)and(not empty(dataset.filter))) then
      filtre:= dataset.filter + ' and ';
    filtre:=filtre + ' Tiers = '''+Tiers+''' and  date >= '''+DateToStr(DateDeb)+''' and date <='''+DateToStr(DateFin)+''' and reste > 0 ';
    DataSet.Filtered:=false;
    DataSet.Filter:=filtre;
    DataSet.Filtered:=true;
   end;
 end;
DataSetDeb:=TTable.Create(self);
DataSetCre:=TTable.Create(self);

CloneDataSet(DataSet,DataSetDeb).Free;
CloneDataSet(DataSet,DataSetCre).Free;

//DataSetDeb:=(CloneDataSet(DataSet,nil) as TTable);
//DataSetCre:=(CloneDataSet(DataSet,nil) as TTable);

F1:=DataSetCre.filter;
DataSetCre.filter:=F1 + ' and Sens = ''C''';
F1Tmp:=DataSetCre.filter;

F2:=DataSetDeb.filter;
F2:=F2 + ' and Sens = ''D'' and (lettre = '''' or lettre is null)';
DataSetDeb.filter:=F2;
NumPointage:=1;
i:=1;

Crestant:=false;
Drestant:=false;
DataSetDeb.First;
while ((i < C_NbPointageMaxi) and (not DataSetDeb.Eof)) do
//for i:=1 to C_NbPointageMaxi do
 begin
//  DataSet.First;

  if DataSetDeb.RecordCount > 0 then
   begin
    PasserSuivant:=true;
    F1:=F1tmp;
//    F1:=DataSetCre.filter;
//    delete(F1,length(F1),1);
    DataSetCre.filter:=F1 + ' and Reste = '+DataSetDeb.FindField('Reste').AsString+' and (lettre = '''' or lettre is null)';

    DataSetCre.First;
     if DataSetCre.RecordCount > 0 then
      begin
        DataSetCre.Locate('Reste',DataSetDeb.FindField('Reste').AsString,[]);
        DataSetCre.Edit;

        DataSetCre.FindField('Lettre').AsString:=chr(NumPointage+64);
        DataSetCre.FindField('Montant').AsCurrency:=DataSetDeb.FindField('Reste').AsCurrency;
        TableGerePost(DataSetCre);

//        BookMarkLettrage:=DataSetDeb.GetBookmark;
        DataSetDeb.Edit;
        DataSetDeb.FindField('Lettre').AsString:=chr(NumPointage+64);
        DataSetDeb.FindField('Montant').AsCurrency:=DataSetDeb.FindField('Reste').AsCurrency;
        TableGerePost(DataSetDeb);
        PasserSuivant:=False;
//        DataSetDeb.GotoBookmark(BookMarkLettrage);
//        DataSetDeb.FreeBookmark(BookMarkLettrage);
        inc(NumPointage);
        inc(i);
      end;
     DataSetCre.Refresh;
//     DataSetDeb.Refresh;
     DataSet.Refresh;
   end;
 if PasserSuivant then DataSetDeb.Next;
 if(not DataSetDeb.eof)then
   begin
     DataSetCre.filter:=F1 + ' and Reste >0  and (lettre = '''' or lettre is null)';
     DataSetCre.first;
     Crestant:=not DataSetCre.eof;
   end;

 PasserSuivant:=true;
//  DataSetDeb.filter:=DataSetDeb.filter + ' and Sens = ''D''''';
 end;
 Drestant:=not DataSetDeb.eof ;
 if(Drestant)and (Crestant)then
  result:=1;
//While not DataSet.RecordCount > 0 do
// begin
//  DataSet.First;
//  BookMarkLettrage:=DataSet.GetBookmark;
////  DataSet.Next;
// end;
DataSetDeb.Close;
DataSetDeb.Free;
DataSetCre.Close;
DataSetCre.Free;
End;


Function TDMPointage2.LettrageAutomatiqueSurSoldeFin(DataSet:TDataSet;Tiers:String;DateDeb,DateFin:TDate;ForcerFiltrage:boolean):integer;
Var
OldFiltre,F1,F1Tmp,F2,filtre:String;
OldFilterd,ModifFiltre,PasserSuivant:boolean;
BookMarkLettrage:TBookmark;
DataSetDeb,DataSetCre:TTable;
i,NumPointage,trouveSoldeZero:integer;
Crestant,Drestant:boolean;
Begin
ModifFiltre:=false;

filtre:='';
result:=0;
if DataSet = nil then abort;
if not DataSet.Active then abort;
if ((not DataSet.Filtered)or(ForcerFiltrage)) then
 begin
 if empty(Tiers) then
  abort
  else
   begin
    OldFiltre:=DataSet.Filter;
    OldFilterd:=DataSet.Filtered;
    ModifFiltre:=true;
    if ((dataset.filtered)and(not empty(dataset.filter))) then
      filtre:= dataset.filter + ' and ';
    filtre:=filtre + ' Tiers = '''+Tiers+''' and  date >= '''+DateToStr(DateDeb)+''' and date <='''+DateToStr(DateFin)+''' and reste > 0 ';
    DataSet.Filtered:=false;
    DataSet.Filter:=filtre;
    DataSet.Filtered:=true;
   end;
 end;




DataSet.First;
trouveSoldeZero:=-1;
while ((i < (C_NbPointageMaxi*2)) and (not DataSet.Eof)) do
begin
    if DataSet.FindField('Solde').AsCurrency=0 then
      begin
         trouveSoldeZero:=i;
      end;
       inc(i);
      DataSet.next;
end;

NumPointage:=1;
i:=0;
DataSet.First;
while ( (i <= trouveSoldeZero) and (not DataSet.Eof)) do
 begin
        DataSet.Edit;
        DataSet.FindField('Lettre').AsString:=chr(NumPointage+64);
        DataSet.FindField('Montant').AsCurrency:=DataSet.FindField('Reste').AsCurrency;
        TableGerePost(DataSet);
        inc(i);
          DataSet.next;
 end;
End;




Function TDMPointage2.LettrageEnregCourant(DataSet:TDataset;Lettre:string;MontantAffect:currency):boolean;
Begin
if DataSet.State = dsBrowse then DataSet.Edit;
 if DataSet.State in [dsEdit,dsInsert] then
 begin
 if not VerifFNumeric(DataSet.FindField('Debit')).VideOUZero then
  begin

   if MontantAffect = 0 then
    begin
     DataSet.FindField('Montant').AsCurrency:=DataSet.FindField('Reste').AsCurrency;
    end
   else
   begin
    if MontantAffect <= DataSet.FindField('Reste').AsCurrency then
      DataSet.FindField('Montant').AsCurrency:=MontantAffect
      else
      DataSet.FindField('Montant').AsCurrency:=DataSet.FindField('Reste').AsCurrency;
   end;

  end
  else
 if not VerifFNumeric(DataSet.FindField('Credit')).VideOUZero then
  begin

   if MontantAffect = 0 then
    begin
     DataSet.FindField('Montant').AsCurrency:=DataSet.FindField('Reste').AsCurrency;
    end
   else
   begin
    if MontantAffect <= DataSet.FindField('Reste').AsCurrency then
      DataSet.FindField('Montant').AsCurrency:=MontantAffect
      else
      DataSet.FindField('Montant').AsCurrency:=DataSet.FindField('Reste').AsCurrency;
   end;

  end;
  DataSet.FindField('Lettre').AsString:=Lettre;
  TableGerePost(dataset);
 end
End;

Function TDMPointage2.Gestion_Annulation_Lettrage(DataSet:TDataSet;Lettre,MessStr:string;Confirmer:boolean):boolean;
var
   i:integer;
   Mess,TiersPointe:string;
begin

if DataSet.state= dsEdit then TableGerePost(DataSet);

if DMPointage2.RecupListeLettre_surDataset(DataSet,false).Result then
     Begin
          if confirmer then
          begin
          mess:='Voulez-vous valider le lettrage en cours ?';
          if not empty(messStr) then mess:=messStr;
          If Messagedlg(mess,MtConfirmation,[mbyes,mbno],0) = mryes Then
           begin
            Result:=false;
            DataSet.Locate('Lettre',lettre,[]);
            TiersPointe:=DataSet.findfield('Tiers').asstring;
            if RecupDetteCreance('',TiersPointe,'',[''],0,0,0,0,nil,False).NBLigneResteAPointer > 0 then
             begin
               if (Pointages2= nil) Then Pointages2:= TPointages2.Create(Application.MainForm);
               Pointages2.EdCompte.Text:=TiersPointe;
               if not pointages2.Showing then
                 Pointages2.ShowModal;
             end;
            end
             else
            begin
             if lettre = '%' then
              SuppressionLettrage_Tous_ApresGestionDesPointages(DataSet,nil)
              else
              SuppressionLettrage_ApresGestionDesPointages(DataSet,Lettre);

              DMPointage2.LettrageEnCours:='';
              DMPointage2.ForceLettrage:='';
              result:=true;
            end;
           end
            else
           begin
             if lettre = '%' then
              SuppressionLettrage_Tous_ApresGestionDesPointages(DataSet,nil)
              else
              SuppressionLettrage_ApresGestionDesPointages(DataSet,Lettre);

              DMPointage2.LettrageEnCours:='';
              DMPointage2.ForceLettrage:='';
              result:=true;
           end;
     end;
end;

procedure TDMPointage2.TaResteDCBeforeOpen(DataSet: TDataSet);
begin
TaPieceRecherche.Close; //isa le 17/08/2007 pour travailler sur les dates d'échéance
TaPieceRecherche.Open;

FormateMonnaieField(Dataset,E.FormatMonnaie,E.EditFormat);
ListeIdDC:=TStringList.Create;  //pour edition dette et creance
ListeSolde:=TStringList.Create; //pour edition dette et creance
Solde:=0;
//ListeSoldeProgressif:=TStringList.Create; //pour edition dette et creance

//TaPointageCredit.Close;
//TaPointageDebit.Close;
//TaLookUpPointageCredit.Close;
//TaLookUpPointageDebit.Close;
//QuSumPointageCredit.Close;
//QuSumPointageDebit.Close;
//
//if not TaPointageCredit.Active then
//TaPointageCredit.Open;
//
//if not TaPointageDebit.Active then
//TaPointageDebit.Open;
//
//if not TaLookUpPointageCredit.Active then
//TaLookUpPointageCredit.Open;
//
//if not TaLookUpPointageDebit.Active then
//TaLookUpPointageDebit.Open;
//
//if not QuSumPointageCredit.Active then
//QuSumPointageCredit.Open;
//
//if not QuSumPointageDebit.Active then
//QuSumPointageDebit.Open;
end;


procedure TDMPointage2.TaResteDCFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
     if ((not empty(TiersDemande))and(TiersDemande<>'*')) then
       accept:=DataSet.FindField('Tiers').asstring=TiersDemande;
    except
     accept:=false;
    end;
  end;
end;


procedure TDMPointage2.TaResteDCFilterRecordPourPointage(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
     if ((not empty(TiersDemande))and(TiersDemande<>'*')) then
       accept:=((DataSet.FindField('Reste').ascurrency>0)and(DataSet.FindField('Tiers').asstring=TiersDemande))
     else
       accept:=DataSet.FindField('Reste').ascurrency>0;
    except
     accept:=false;
    end;
  end;
end;

procedure TDMPointage2.TaResteDCFilterRecordPourPointageDebit(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
     if ((not empty(TiersDemande))and(TiersDemande<>'*')) then
       accept:=((DataSet.FindField('Reste').ascurrency>0)and(DataSet.FindField('Tiers').asstring=TiersDemande) and (DataSet.FindField('Debit').ascurrency>0))
     else
       accept:=((DataSet.FindField('Reste').ascurrency>0)and (DataSet.FindField('Debit').ascurrency>0));
    except
     accept:=false;
    end;
  end;
end;

procedure TDMPointage2.TaResteDCFilterRecordPourPointageCredit(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
     if ((not empty(TiersDemande))and(TiersDemande<>'*')) then
       accept:=((DataSet.FindField('Reste').ascurrency>0)and(DataSet.FindField('Tiers').asstring=TiersDemande) and (DataSet.FindField('Credit').ascurrency>0))
     else
       accept:=((DataSet.FindField('Reste').ascurrency>0) and (DataSet.FindField('Credit').ascurrency>0));
    except
     accept:=false;
    end;
  end;
end;


//procedure TDMPointage2.TaResteDCFilterRecord(DataSet: TDataSet;
//  var Accept: Boolean);
//begin
//if not((csDestroying)in dataset.ComponentState) then
// begin
//   try
//    accept:=((DataSet.FindField('Reste').ascurrency=0)and(DataSet.FindField('Tiers').asstring=TiersDemande));
//   except
//    accept:=false;
//   end;
// end;
//
//end;


procedure TDMPointage2.TaResteDCFilterRecordPourPointage_PointeTotal(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
 begin
   try
     if ((not empty(TiersDemande))and(TiersDemande<>'*')) then
      accept:=((DataSet.FindField('Reste').ascurrency=0)and(DataSet.FindField('Tiers').asstring=TiersDemande))
     else
      accept:=DataSet.FindField('Reste').ascurrency=0;
   except
    accept:=false;
   end;
 end;

end;

procedure TDMPointage2.TaResteDCFilterRecordPourPointage_PointePartiel(DataSet: TDataSet;
    var Accept: Boolean);
Begin
if not((csDestroying)in dataset.ComponentState) then
  Begin//si
   try
    if not VerifFNumeric(DataSet.FindField('Debit')).VideOUZero then
     begin
     if ((not empty(TiersDemande))and(TiersDemande<>'*')) then
         accept:=(((DataSet.FindField('Debit').AsCurrency > DataSet.FindField('Reste').AsCurrency))and(DataSet.FindField('Tiers').asstring=TiersDemande) and (DataSet.FindField('Reste').AsCurrency > 0))
       else
         accept:=(((DataSet.FindField('Debit').AsCurrency > DataSet.FindField('Reste').AsCurrency)) and (DataSet.FindField('Reste').AsCurrency > 0));
     end
     else
     begin
     if ((not empty(TiersDemande))and(TiersDemande<>'*')) then
         accept:=(((DataSet.FindField('Credit').AsCurrency > DataSet.FindField('Reste').AsCurrency))and(DataSet.FindField('Tiers').asstring=TiersDemande) and (DataSet.FindField('Reste').AsCurrency > 0))
       else
         accept:=(((DataSet.FindField('Credit').AsCurrency > DataSet.FindField('Reste').AsCurrency)) and (DataSet.FindField('Reste').AsCurrency > 0));
     end;
   except
    accept:=false;
   end;
  End;//fin si
End;

procedure TDMPointage2.TaResteDCBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMPointage2.TaResteDCBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDMPointage2.TaResteDCBeforePost(DataSet: TDataSet);
var
RetourCtrlPointage:TErreurSaisie;
i:integer;
begin

if ((ForceLettrage=LettrageEnCours) and not empty(ForceLettrage)) then
 begin
  if DataSet.State = dsEdit then
       Dataset.FindField('Lettre').AsString := ForceLettrage;
 end;
for i:=11 to 12 do
 begin
   RetourCtrlPointage:=CtrlSaisiePointage(Dataset.Fields[i]);
   if not RetourCtrlPointage.retour then
   case RetourCtrlPointage.CodeErreur of
     1101:abort;
     //1201:abort;
     1202:abort;
   end;
 end;
end;

// Isa : A garder
// Si on trouve la ligne d'écriture dans la table ResteDc, on
// modifie son reste suivant si on vient de créer ou de supprimer un pointage (SupprPointage)
// Sinon // on crée la ligne d'écriture dans ResteDC
procedure TDMPointage2.GestionDuReste(var InfosCreationReste:TInfosCreationReste;SupprPointage:boolean);
begin
if not TaReste.Active then
   TaReste.open;
 if TaReste.Locate('ID_Ecriture',InfosCreationReste.IDEcriture,[])then
    Begin//si on trouve une ligne reste pour cette écriture, on la modifie
      TaReste.edit;
      if SupprPointage then
        TaReste.FindField('Reste').ascurrency:=TaReste.FindField('Reste').ascurrency+InfosCreationReste.Pointage.MontantPointage
      else
        TaReste.FindField('Reste').ascurrency:=TaReste.FindField('Reste').ascurrency-InfosCreationReste.Pointage.MontantPointage;
      TableGerePost(TaReste);
    end
 else
  if not SupprPointage then
   Begin
     CreationReste(MaxId_Query(TaReste,'ID'),InfosCreationReste.IDEcriture,InfosCreationReste.idpiece,
     InfosCreationReste.DatePiece,InfosCreationReste.Reference,InfosCreationReste.tiers,
     InfosCreationReste.Libelle,'',InfosCreationReste.Reste.SensReste,
     InfosCreationReste.MontantDebit,InfosCreationReste.MontantCredit,
     InfosCreationReste.Reste.reste,0);
   End;
end;

procedure TDMPointage2.GestionDuResteSurCompte(Tiers:string;idEcriture:integer);
begin
  try
    if not TaReste.Active then
       TaReste.open;
     if not TaReste.Locate('ID_Ecriture',IDEcriture,[])then   raise ExceptLGR.Create('Le Reste n''est pas créé',0,true,mtError);
     //si on trouve une ligne reste pour cette écriture, on la modifie
     TableGereEdit(TaReste);
     TaReste.FindField('Tiers').asstring:=Tiers;
     TableGerePost(TaReste);
  except
      raise;
  end;
end;


procedure CreationReste(Max,ID,IDPiece:integer;Date:Tdate;Ref,Tiers,Libelle,Lettre:string;sens:boolean;Debit,Credit,reste,montant:currency);
var
sensTmp:string;
Begin
    try
    if sens then
      sensTmp:='C'
    else
      sensTmp:='D';

    DMPointage2.TaReste.AppendRecord([Max,ID,IDPiece,Date,Ref,Tiers,Libelle,Debit,Credit,sensTmp,reste,Lettre]);
    DMPointage2.TaReste.FlushBuffers;
    except
    showmessage('Problème lors de la création d''une Dette et Créance !!!');
    abort;
    end;//fin du try except
End;


Function DetailPointageAffich(TiersCourant,Id_Identifiant:string;TypeIdentifiant:integer;affich:boolean;Suppression_Accept:boolean):boolean;
var
SensDebit:boolean;
begin
SensDebit:=true;
if (DMPointage2 = nil) then DMPointage2:=TDMPointage2.Create(Application.MainForm);
if (DetailPointage = nil) then DetailPointage:=TDetailPointage.Create(Application.MainForm);
//isa le 13-12-02
DetailPointage.BtnSupprimer.Enabled:=Suppression_Accept;
DetailPointage.Supprimer1.Enabled:=Suppression_Accept;
DetailPointage.TiersCourant:=TiersCourant;
//isa le 13-12-02

if DMEcritures.TaEcritureRecherche.locate('Id',ID_Identifiant,[]) then
 SensDebit:=not VerifFNumeric(DMEcritures.TaEcritureRecherche.FindField('DebitSaisie')).VideOUZero;

with DMPointage2 do
   begin
     TypeIdentifiant:=0;
      case TypeIdentifiant of
         // Recherche sur ID Ecriture
         0:Begin
            result:=DMPointage2.FiltragePointageSurEcritureaffich(QuPointageAffich,Id_Identifiant,TypeIdentifiant,false,true,false,-1).Pointee;
           End;
         1:Begin//recherche sur reference
            result:=DMPointage2.FiltragePointageSurEcritureaffich(QuPointageAffich,Id_Identifiant,TypeIdentifiant,false,true,false,-1).Pointee;

           End;
      end;//fin du case TypeIdentifiant

      if SensDebit then
         begin
           GrDbGridInitColonne(DetailPointage.GrDBDetailPointages,DaPointageAffich,QuPointageAffich,
                               ['Référence','Date','Libellé','Débit','Crédit','Imputation'],
                               ['EcrReferenceCredit','EcrDateCredit','EcrLibelleCredit','EcrDebitSaisie','EcrCreditSaisie','PoMontantPointage'],
                               E.FormatMonnaie,'');
         end
      else
         begin
           GrDbGridInitColonne(DetailPointage.GrDBDetailPointages,DaPointageAffich,QuPointageAffich,
                               ['Référence','Date','Libellé','Débit','Crédit','Imputation'],
                               ['EcrReferenceDebit','EcrDateDebit','EcrLibelleDebit','EcrDebitSaisieDebit','EcrCreditSaisieDebit','PoMontantPointage'],
                               E.FormatMonnaie,'');
         end;

     TypeIdentifiant:=0;
      case TypeIdentifiant of
         // Recherche sur ID Ecriture
         0:Begin
            result:=DMPointage2.FiltragePointageSurEcritureaffich(QuPointageAffich,Id_Identifiant,TypeIdentifiant,false,true,false,-1).Pointee;
           End;
         1:Begin//recherche sur reference
            result:=DMPointage2.FiltragePointageSurEcritureaffich(QuPointageAffich,Id_Identifiant,TypeIdentifiant,false,true,false,-1).Pointee;

           End;
      end;//fin du case TypeIdentifiant

    if sensDebit then
      DetailPointage.Caption:='Ecritures pointées avec l''écriture du Compte : '+ TiersCourant+' de la référence : '+ QuPointageAffich.FindField('EcrReferenceDebit').AsString
    else
      DetailPointage.Caption:='Ecritures pointées avec l''écriture du Compte : '+ TiersCourant+' de la référence : '+ QuPointageAffich.FindField('EcrReferenceCredit').AsString;

    result:=DetailPointage.Showmodal=mrok;
   end;//fin du with dmpointage2
End;

function TDMPointage2.FiltragePointageSurEcritureAffich(var Requete:TQuery;IDentifiant:string;TypeIdentifiant:Integer;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointageS;
var
sens,SaisieAu,SensPointe:string;
//TableTemp:TTable;
tab:variant;
ID:string;
begin
//TypeIdentifiant:=0;
case TypeIdentifiant of
   0:begin  // Recherche sur ID Ecriture
     if RenvoieInfoSurTableDiverse(IDentifiant,DMEcritures.TaEcriture,'ID',['DebitSaisie'],tab)>
     RenvoieInfoSurTableDiverse(IDentifiant,DMEcritures.TaEcriture,'ID',['CreditSaisie'],tab)then
     sensCredit:=false
     else
     sensCredit:=true;
     tab:=Unassigned;
     end;
   1:begin // REcherche sur compte !!! A finir
     if RenvoieInfoSurTableDiverse(IDentifiant,DMEcritures.TaEcriture,'Compte',['DebitSaisie'],tab)>
     RenvoieInfoSurTableDiverse(IDentifiant,DMEcritures.TaEcriture,'Compte',['CreditSaisie'],tab)then
     sensCredit:=false
     else
     sensCredit:=true;
     tab:=Unassigned;
     end;
end;


result.NbLignePointee:=0;
result.Pointee:=false;
  case ord(sensCredit) of
   0:begin
      sens:='ID_Debit';
      SensPointe:='ID_Credit';
      SaisieAu:='DebitSaisie';
     end;
   1:begin
      sens:='ID_Credit';
      SensPointe:='ID_Debit';
      SaisieAu:='CreditSaisie';
     end;
  end;//fin du case

//select Po.id, E1.Id, P1.reference, P1."Date",E1.Libelle,E1.DebitSaisie,Po.Montant,E.Id,P.Reference,P."Date",E.Libelle,E.CreditSaisie from Pointage Po
//
//join Ecriture E on (E.Id =  Po.Id_Credit)
//join Ecriture E1 on ( E1.id = Po.id_debit)
//join Piece P on (P.id = E.Id_Piece)
//join Piece P1 on (P1.id = E1.Id_Piece)
//where E.Tiers='+LEGRAIN'
//order by P1."Date"

Requete.SQL.Clear;
Requete.SQL.Add('select Po.id,Po.Id_Debit,Po.Id_Credit, E1.Id as EcrIdDebit, P1.reference as EcrReferenceDebit, P1."Date" as EcrDateDebit,E1.Libelle as EcrLibelleDebit, ');
Requete.SQL.Add('E1.DebitSaisie as EcrDebitSaisieDebit,E1.CreditSaisie as EcrCreditSaisieDebit,E1.id_piece as id_pieceDebit,Po.Montant as PoMontantPointage,E.Id as EcrIdCredit,P.Reference as EcrReferenceCredit, ');
Requete.SQL.Add('P."Date" as EcrDateCredit,E.Libelle as EcrLibelleCredit,E.DebitSaisie as EcrDebitSaisie,E.CreditSaisie as EcrCreditSaisie,E.id_piece as id_pieceCredit from Pointage Po ');
Requete.SQL.Add('join Ecriture E on (E.Id =  Po.Id_Credit) ');
Requete.SQL.Add('join Ecriture E1 on ( E1.id = Po.id_debit) ');
Requete.SQL.Add('join Piece P on (P.id = E.Id_Piece) ');
Requete.SQL.Add('join Piece P1 on (P1.id = E1.Id_Piece) ');
case TypeIdentifiant of
   0:Requete.SQL.Add('where Po.'+sens+'='''+IDentifiant+'''');
   1:Requete.SQL.Add('where E.Compte='''+IDentifiant+'''');
   2:Requete.SQL.Add('where E.Tiers='''+IDentifiant+'''');
end;


// A conserver tant que le dessus ne marche pas !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//Requete.SQL.Clear;
//Requete.SQL.Add('select E.Id,P.Reference,P."Date",E.Libelle,E.DebitSaisie,E.CreditSaisie,Po.Montant from Pointage Po ');
////Requete.SQL.Add('select P.Reference,P."Date",E.Libelle,E.'+SaisieAu+',Po.Montant from Pointage Po ');
//Requete.SQL.Add('join Ecriture E on (E.Id =  Po.'+SensPointe+') ');
//Requete.SQL.Add('join Piece P on (P.id = E.Id_Piece) ');
//case TypeIdentifiant of
//   0:Requete.SQL.Add('where Po.'+sens+'='''+IDentifiant+'''');
//   1:Requete.SQL.Add('where E.Compte='''+IDentifiant+'''');
//end;

//Requete.SQL.Add('select * from Pointage.db where '+sens+'= '''+inttostr(IDEcriture)+'''');
//   if ((partiel)and(IDContrepartie<>-1)) then
//   begin
//     case ord(sensCredit) of
//      1:sens:='ID_Debit';
//      0:sens:='ID_Credit';
//     end;//fin du case
//   Requete.SQL.Add(' and '+sens+'= '''+inttostr(IDcontrePartie)+'''');
//   end;
Requete.Open;
if Requete.RecordCount<>0 then
   begin
   result.NbLignePointee:=Requete.RecordCount;
   result.Pointee:=true;
   result.Dataset:=Requete;
   end;
End;

function CreationPointageSurIDEcriture(var TabID:Variant;TiersTmp:string;GererReste:boolean):TExceptLGR_ImportPiece;
var       //
i,j:integer;
IDDebit,IDCredit:integer;
TvaDate:TdateTime;
tab:variant;
InfosCreationReste:TInfosCreationReste;
montantPointage:currency;
begin
montantPointage:=0;
initialise_TExceptLGR_ImportPiece(result);
result.Id_Piece:=-1;
   try
      try
        with DMPointage2 do
         begin
         if not TaPointage.active then
           TaPointage.open;
         if not tareste.active then
           tareste.open;
             IDDebit:=TabID[0];
             IDCredit:=TabID[1];
             montantPointage:=TabID[3];
             TaPointage.Filtered:=false;
             TaPointage.filter:='';
             TaPointage.filter:=('ID_Debit= '''+inttostr(IDDebit)+'''and ID_Credit= ''' +inttostr(IDCredit)+'''');
             TaPointage.Filtered:=true;
             if TaPointage.RecordCount<>0 then
                Begin
                 //rechercher si reste>0

                 TaPointage.Edit;
                 TaPointage.FindField('Montant').AsCurrency:=TaPointage.FindField('Montant').AsCurrency+montantPointage ;
                 TableGerePost(TaPointage);
                 TaPointage.Filtered:=false;
                 TaPointage.filter:='';
                 TaPointage.Filtered:=true;
                End
             else
                TaPointage.AppendRecord([MaxId_Query(TaPointage,'ID'),TabID[0],TabID[1],TabID[2],
                montantPointage,TabID[4],null,'',now]);
             TaPointage.FlushBuffers;
             if GererReste then
               begin//si gestion du reste
                 for j:=0 to 1 do
                   begin
                     initialise_InfosCreationReste(InfosCreationReste);
                     InfosCreationReste.Pointage.MontantPointage:=montantPointage;
                     InfosCreationReste.Tiers:=Tierstmp;
                     InfosCreationReste.IDEcriture:=TabID[j];
                     //rechercher la pièce concernant l'écriture en cours pour récupérer la référence
                     //l'IDPiece et le libelle de la pièce
                     InfosCreationReste.IDPiece:=StrToInt_Lgr(RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDEcriture),DMEcritures.TaEcriture,'ID',['ID_Piece'],tab));
                     //récupérer la référence de la pièce
                     if InfosCreationReste.IDPiece<>0 then
                       begin
                         RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDPiece),DMpieces.TaPiece,'ID',['Reference','Libelle','Date'],tab);
                         InfosCreationReste.Reference:=tab[0];
                         InfosCreationReste.Libelle:=tab[1];
                         InfosCreationReste.DatePiece:=StrToDate_Lgr(tab[2]);
                         InfosCreationReste.Tiers:=InfosCreationReste.Tiers;
                         InfosCreationReste.IDEcriture:=InfosCreationReste.IDEcriture;
                         RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDEcriture),DMEcritures.TaEcriture,'ID',['DebitSaisie','CreditSaisie'],tab);
                         InfosCreationReste.MontantDebit:=StrToCurr_lgr(tab[0]);
                         InfosCreationReste.MontantCredit:=StrToCurr_lgr(tab[1]);
                       end
                     else
                        abort;
                     if InfosCreationReste.MontantDebit<>0 then
                       begin
                         InfosCreationReste.Reste.Reste:=InfosCreationReste.MontantDebit-InfosCreationReste.Pointage.MontantPointage;
                         InfosCreationReste.Reste.SensReste:=false;
                       end
                     else
                       begin
                         InfosCreationReste.Reste.Reste:=InfosCreationReste.MontantCredit-InfosCreationReste.Pointage.MontantPointage;;
                         InfosCreationReste.Reste.SensReste:=true;
                       end;

                     GestionDuReste(InfosCreationReste,false);
                   end;//fin for j
               end;//fin si gestion du reste
             result.Id_Piece:=MaxId_Query(TaPointage,'ID')-1;
         end;//fin du with DMPointage2
      except
      //showmessage('Problème à la création des pointages !!');
      TableGereRollBack(DMPointage2.TaPointage);
      TableGereRollBack(DMBalance.TaBalance);
      result.Id_Piece:=-1;
      abort;
      end;//fin du try
   finally
   DMPointage2.tareste.close;
   end;//fin du try finally
End;


procedure TDMPointage2.QuPointageAffichBeforeInsert(DataSet: TDataSet);
begin
abort;
end;



procedure TDMPointage2.TaResteDCReglementCalcFields(DataSet: TDataSet);
begin
if(Dataset <>nil) and (not((csDestroying)in dataset.ComponentState)) then
begin
QuSumPointageDebit.Close;
//QuSumPointageDebit.ParamByName('ID_Ecriture').AsInteger:=DAtasEt['ID_Ecriture'];
QuSumPointageDebit.ParamByName('ID_Ecriture').AsInteger:=DAtasEt.findfield('ID_Ecriture').asinteger;{ isa  le  26/04/04 }
QuSumPointageDebit.ParamByName('ID_Appelant').AsInteger:=IDEcritureAppelanteLoc;
if not QuSumPointageDebit.Active then QuSumPointageDebit.Open;

QuSumPointageCredit.Close;
//QuSumPointageCredit.ParamByName('ID_Ecriture').AsInteger:=DAtasEt['ID_Ecriture'];
QuSumPointageCredit.ParamByName('ID_Ecriture').AsInteger:=DAtasEt.findfield('ID_Ecriture').asinteger;{ isa  le  26/04/04 }
QuSumPointageDebit.ParamByName('ID_Appelant').AsInteger:=IDEcritureAppelanteLoc;
if not QuSumPointageCredit.Active then QuSumPointageCredit.Open;

Dataset.findfield('AutrePointageDebit').AsCurrency:=QuSumPointageDebit.findfield('TotalPointeAutre').AsCurrency;

Dataset.findfield('AutrePointageCredit').AsCurrency:=QuSumPointageCredit.findfield('TotalPointeAutre').AsCurrency;

if not VerifFNumeric(Dataset.findfield('AutrePointageDebit')).VideOUZero then
  Dataset.findfield('AutrePointage').AsCurrency:=Dataset.findfield('AutrePointageDebit').AsCurrency
 else
  Dataset.findfield('AutrePointage').AsCurrency:=Dataset.findfield('AutrePointageCredit').AsCurrency;

TaInfoPointageDebit.Filter:=CreeFiltreET(['ID_Debit','Id_Credit'],[DAtasEt.findfield('ID_Ecriture').asstring,inttostr(IDEcritureAppelanteLoc)]);
TaInfoPointageCredit.Filter:=CreeFiltreET(['ID_Debit','Id_Credit'],[inttostr(IDEcritureAppelanteLoc),DAtasEt.findfield('ID_Ecriture').asstring]);

TaInfoPointageDebit.Filtered:=true;
TaInfoPointageCredit.Filtered:=true;

Dataset.findfield('ImputationDebit').AsCurrency:=TaInfoPointageDebit.FindField('Montant').AsCurrency;
Dataset.findfield('ImputationCredit').AsCurrency:=TaInfoPointageCredit.FindField('Montant').AsCurrency;

if not VerifFNumeric(Dataset.findfield('ImputationDebit')).VideOUZero then
  Dataset.findfield('Imputation').AsCurrency:=Dataset.findfield('ImputationDebit').AsCurrency
 else
  Dataset.findfield('Imputation').AsCurrency:=Dataset.findfield('ImputationCredit').AsCurrency;


if not VerifFNumeric(Dataset.findfield('Debit')).VideOUZero then
Dataset.findfield('TotalReglement').AsCurrency:=Dataset.findfield('Debit').AsCurrency
else
Dataset.findfield('TotalReglement').AsCurrency:=Dataset.findfield('Credit').AsCurrency;
end;
end;

procedure TDMPointage2.QuSumPointageCreditFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=dataset['id_Credit']=IDEcritureAppelanteLoc;
  end;
end;

procedure TDMPointage2.QuSumPointageDebitFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
      accept:=dataset['id_Debit']<>IDEcritureAppelanteLoc;
  end;    
end;



function TDMPointage2.SupprimePointageSurEcriture(RequeteFiltree:Tquery;infosPiece:TStringlist;Indice:integer):integer;
var
MontantPointage:currency;
Tab:variant;
IDDebit,IDCredit:integer;
CreationReste_Debit,CreationReste_Credit:TInfosCreationReste;
begin
TaPointage.open;
tapointage.Filtered:=false;
result:=0;
   try
      RequeteFiltree.First;
         while not(RequeteFiltree.EOF) do
         Begin
           if TaPointage.Locate('ID',RequeteFiltree.findfield('ID').asinteger,[]) then
              try
                MontantPointage:=TaPointage.findfield('Montant').ascurrency;
                IDDebit:=TaPointage.findfield('ID_Debit').asinteger;
                IDCredit:=TaPointage.findfield('ID_Credit').asinteger;
                //récup infos sur ecriture debit ///////////
                //initiallisation des infos reste pour l'ecriture debit
                initialise_InfosCreationReste(CreationReste_Debit);
                CreationReste_Debit.Pointage.MontantPointage:=MontantPointage;
                if (infospiece.Objects[indice]is Tpiece) then
                  CreationReste_Debit.Tiers:=(infospiece.Objects[indice]as Tpiece).tiers
                else
                if (infospiece.Objects[indice]is TReglementList) then
                  CreationReste_Debit.Tiers:=(infospiece.Objects[indice]as TReglementList).tiers;
                CreationReste_Debit.IDEcriture:=IDDebit;
                RenvoieInfoSurTableDiverse(inttostr(IDDebit),DMEcritures.TaEcriture,'ID',['ID_Piece','DebitSaisie','CreditSaisie','Libelle','Date'],Tab);
                CreationReste_Debit.IDPiece:=tab[0];//id_piece
                CreationReste_Debit.MontantDebit:=tab[1];//DebitSaisie
                CreationReste_Debit.MontantCredit:=tab[2];//créditSaisie
                CreationReste_Debit.Libelle:=tab[3];//Libelle
                CreationReste_Debit.DatePiece:=StrToDate_Lgr(tab[4]);//Dateecriture
                RenvoieInfoSurTableDiverse(inttostr(CreationReste_Debit.IDPiece),DMPieces.TaPiece,'ID',['Reference'],Tab);
                CreationReste_Debit.Reference:=tab[0];//reference
                if CreationReste_Debit.MontantDebit<>0 then
                    CreationReste_Debit.Reste.SensReste:=false
                else
                    CreationReste_Debit.Reste.SensReste:=true;

                //récup infos sur ecriture Crédit ///////////
                //initiallisation des infos reste pour l'ecriture debit
                initialise_InfosCreationReste(CreationReste_Credit);
                CreationReste_Credit.Pointage.MontantPointage:=MontantPointage;
                if (infospiece.Objects[indice]is Tpiece) then
                  CreationReste_Credit.Tiers:=(infospiece.Objects[indice]as Tpiece).tiers
                else
                if (infospiece.Objects[indice]is TReglementList) then
                  CreationReste_Credit.Tiers:=(infospiece.Objects[indice]as TReglementList).tiers;
                CreationReste_Credit.IDEcriture:=IDCredit;
                RenvoieInfoSurTableDiverse(inttostr(IDCredit),DMEcritures.TaEcriture,'ID',['ID_Piece','DebitSaisie','CreditSaisie','Libelle','Date'],Tab);
                CreationReste_Credit.IDPiece:=tab[0];//id_piece
                CreationReste_Credit.MontantDebit:=tab[1];//DebitSaisie
                CreationReste_Credit.MontantCredit:=tab[2];//créditSaisie
                CreationReste_Credit.Libelle:=tab[3];//Libelle
                CreationReste_Credit.DatePiece:=StrToDate_Lgr(tab[4]);//Dateecriture
                RenvoieInfoSurTableDiverse(inttostr(CreationReste_Credit.IDPiece),DMPieces.TaPiece,'ID',['Reference'],Tab);
                CreationReste_Credit.Reference:=tab[0];//reference
                if CreationReste_Credit.MontantDebit<>0 then
                    CreationReste_Credit.Reste.SensReste:=false
                else
                    CreationReste_Credit.Reste.SensReste:=true;

                TableGereDelete(TaPointage);
              ///////////////////////
              GestionDuReste(CreationReste_Debit,true);//pour l'ecriture Debit
              GestionDuReste(CreationReste_Credit,true);//pour l'ecriture Crédit
              ///////////////////////
                Tab:=Unassigned;
              except
              abort;
              end;//fin du try
         RequeteFiltree.Next;
         End;
   except
   showmessage('Problème à la suppression des pointages de la pièce en cours !!');
   abort;
   end;//fin du try except
TaPointage.close;
End;


function TDMPointage2.FiltragePointageSurEcriture(IDEcriture:string;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointages;
var
Requete:TQuery;
Begin
try
  Requete:=TQuery.Create(self);
  Result:=FiltragePointageSurEcriture(Requete,IDEcriture,sensCredit,ChercheSens,Partiel,IDContrePartie);
finally
libereObjet(Tobject(Requete));
end;//fin finally  
end;

function TDMPointage2.FiltragePointageSurEcriture(var Requete:TQuery;IDEcriture:string;sensCredit:boolean;ChercheSens:boolean;Partiel:boolean;IDContrePartie:integer):TinfosPointages;
var
sens:string;
tab:variant;
i,idPiece:integer;
begin
  if ChercheSens then
     begin
         if RenvoieInfoSurTableDiverse(IDEcriture,DMEcritures.TaEcriture,'ID',['DebitSaisie'],tab)>
         RenvoieInfoSurTableDiverse(IDEcriture,DMEcritures.TaEcriture,'ID',['CreditSaisie'],tab)then
         sensCredit:=false
         else
         sensCredit:=true;
         tab:=Unassigned;
     end;
result.NbLignePointee:=0;
result.Pointee:=false;
  case ord(sensCredit) of
   0:sens:='ID_Debit';
   1:sens:='ID_Credit';
  end;//fin du case
if Requete=nil then Requete:=TQuery.Create(self);
Requete.DatabaseName:=DMEcritures.TaEcriture.DatabaseName;
Requete.SQL.Clear;
Requete.SQL.Add('select * from Pointage.db where '+sens+'= '''+IDEcriture+'''');
   if ((partiel)and(IDContrepartie<>-1)) then
   begin
     case ord(sensCredit) of
      1:sens:='ID_Debit';
      0:sens:='ID_Credit';
     end;//fin du case
   Requete.SQL.Add(' and '+sens+'= '''+inttostr(IDcontrePartie)+'''');
   end;
Requete.Open;
if Requete.RecordCount>0 then
   begin
   result.NbLignePointee:=Requete.RecordCount;
   result.Pointee:=true;
   requete.First;
   while ((not requete.EOF)and(result.TvaSurE=false)) do
     Begin//debut du while requete.EOF
       //pour chaque pointage regarder si 1 des 2 pièces comporte de la tva sur E
       //si oui, arrêter la recherche
       //travail sur iddebit
       DeFiltrageDataSet(DMRech.TaEcritureRech);
       idpiece:=Infos_TInfosEcriture(DMRech.TaEcritureRech,'ID',[requete.findfield('ID_Debit').asinteger]).ID_Piece;
       FiltrageDataSet(DMRech.TaEcritureRech,'TvaType=''E'' and id_Piece = '+inttostr(idpiece));
       DMRech.TaEcritureRech.first;
       if DMRech.TaEcritureRech.recordcount>0 then
         result.TvaSurE:=IDEcriture<>DMRech.TaEcritureRech.FindField('ID').asstring;
       //travail sur idCredit
       if result.TvaSurE=false then
         begin//si tvaSurE=false
         DeFiltrageDataSet(DMRech.TaEcritureRech);
         idpiece:=Infos_TInfosEcriture(DMRech.TaEcritureRech,'ID',[requete.findfield('ID_Credit').asinteger]).ID_Piece;
         FiltrageDataSet(DMRech.TaEcritureRech,'TvaType=''E'' and id_Piece = '+inttostr(idpiece));
         DMRech.TaEcritureRech.first;
         if DMRech.TaEcritureRech.recordcount>0 then
           result.TvaSurE:=IDEcriture<>DMRech.TaEcritureRech.FindField('ID').asstring;
         end;//fin si tvaSurE=false
     DeFiltrageDataSet(DMRech.TaEcritureRech);
     requete.Next;
     End;//fin du while requete.EOF
   end;
End;


procedure TDMPointage2.RemplissageListePointages_SurDataset_EtLettrage(ListeLettre:Tstringlist;var ListePointage:Tstringlist);
Var
PointageDebit:TPointageDebit;
PointageCredit:TPointageCredit;
Lettrage:TLettrage;
IndexLettre,i,j,IndexLettrage:Integer;
Sens:String;
Debuggage:Boolean;
Begin
 try
  try
    if not TaResteRecherche.Active then
      TaResteRecherche.Open;
    if ListeLettre<>nil then
      Begin
       if ListePointage=nil then
         ListePointage:=TStringList.Create;
       for IndexLettre:=0 to ListeLettre.Count-1 do
        begin
        Sens:='D';
        FiltrageDataSet(TaResteRecherche,CreeFiltreEt(['Lettre','Sens'],[ListeLettre[IndexLettre],Sens]));
        Lettrage:=TLettrage.Create(nil);
        IndexLettrage:=ListePointage.AddObject(ListeLettre[IndexLettre],Lettrage);
        TaResteRecherche.first;
        while not TaResteRecherche.eof do
          Begin //récupérer infos pointages de l'id ecriture
               PointageDebit := TPointageDebit.Create(nil);
               PointageDebit.Imputation:=TaResteRecherche.findfield('Montant').AsString;
               PointageDebit.IDEcriture:=TaResteRecherche.findfield('ID_Ecriture').asinteger;
               PointageDebit.Pointer:=PointageDebit.Imputation;
               PointageDebit.Lettre:=TaResteRecherche.findfield('lettre').asstring;
               PointageDebit.sens:=TaResteRecherche.findfield('sens').asstring;
               PointageDebit.Tiers:=TaResteRecherche.findfield('Tiers').asstring;
               PointageDebit.DateTva:=TaResteRecherche.findfield('Date').AsDateTime;
               TLettrage(ListePointage.Objects[IndexLettrage]).MontantTotalImputationDebit :=
                                                      TLettrage(ListePointage.Objects[IndexLettrage]).MontantTotalImputationDebit+
                                                      TaResteRecherche.findfield('Montant').AsCurrency;
               TLettrage(ListePointage.Objects[IndexLettrage]).ListeLigneDebit.AddObject(TaResteRecherche.findfield('ID_Ecriture').AsString,PointageDebit);
             TaResteRecherche.next;
          End;//fin récupérer infos pointages des id ecritures Credit

        Sens:='C';
        FiltrageDataSet(TaResteRecherche,CreeFiltreEt(['Lettre','Sens'],[ListeLettre[IndexLettre],Sens]));
        TaResteRecherche.first;
        while not TaResteRecherche.eof do
          Begin //récupérer infos pointages de l'id ecriture
               PointageCredit := TPointageCredit.Create(nil);
               PointageCredit.Imputation:=TaResteRecherche.findfield('Montant').AsString;
               PointageCredit.IDEcriture:=TaResteRecherche.findfield('ID_Ecriture').asinteger;
               PointageCredit.Pointer:=PointageDebit.Imputation;
               PointageCredit.Lettre:=TaResteRecherche.findfield('lettre').asstring;
               PointageCredit.sens:=TaResteRecherche.findfield('sens').asstring;
               PointageCredit.Tiers:=TaResteRecherche.findfield('Tiers').asstring;
               PointageCredit.DateTva:=TaResteRecherche.findfield('Date').AsDateTime;
               TLettrage(ListePointage.Objects[IndexLettrage]).MontantTotalImputationCredit :=
                                                      TLettrage(ListePointage.Objects[IndexLettrage]).MontantTotalImputationCredit+
                                                      TaResteRecherche.findfield('Montant').AsCurrency;
               TLettrage(ListePointage.Objects[IndexLettrage]).ListeLigneCredit.AddObject(TaResteRecherche.findfield('ID_Ecriture').AsString,PointageCredit);
             TaResteRecherche.next;
          End;//fin récupérer infos pointages des id ecritures Credit
        // Création des affectations ligne à ligne ....
        // recherche des id ayant le même montant imputé
        // A Faire ....
        // recherche des id les plus grand ayant le même montant imputé que la somme des imputation des id de l'autre sens
        // A Faire ....
        end;
      End
    else
    abort;
  except
    abort;
  end;
 finally
  Debuggage:=false;
  if Debuggage then
   begin
    for i:=0 to ListePointage.Count-1 do
     begin
      AjouterFichierTexte(E.REpertoireFiscal+'ListePointage.txt',ListePointage.Strings[i]);
      for j:=0 to TLettrage(ListePointage.Objects[i]).ListeLigneDebit.Count -1 do
       begin
        AjouterFichierTexte(E.REpertoireFiscal+'ListePointage.txt',TLettrage(ListePointage.Objects[i]).ListeLigneDebit.Strings[j]);
        AjouterFichierTexte(E.REpertoireFiscal+'ListePointage.txt',TPointageDebit(TLettrage(ListePointage.Objects[i]).ListeLigneDebit.Objects[j]).Imputation);
        AjouterFichierTexte(E.REpertoireFiscal+'ListePointage.txt',TPointageDebit(TLettrage(ListePointage.Objects[i]).ListeLigneDebit.Objects[j]).Sens);
       end;
      for j:=0 to TLettrage(ListePointage.Objects[i]).ListeLigneCredit.Count -1 do
       begin
        AjouterFichierTexte(E.REpertoireFiscal+'ListePointage.txt',TLettrage(ListePointage.Objects[i]).ListeLigneCredit.Strings[j]);
        AjouterFichierTexte(E.REpertoireFiscal+'ListePointage.txt',TPointageCredit(TLettrage(ListePointage.Objects[i]).ListeLigneCredit.Objects[j]).Imputation);
        AjouterFichierTexte(E.REpertoireFiscal+'ListePointage.txt',TPointageCredit(TLettrage(ListePointage.Objects[i]).ListeLigneCredit.Objects[j]).Sens);
       end;
     end;
   end;
 end;
//
End;

procedure TDMPointage2.RemplissageListePointages_SurDataset(var ListeIDEcriture:Tstringlist;var ListePointage:Tstringlist);
var
i:integer;
NewPointage:TPointageList;
Begin
  try
    if not TaResteRecherche.Active then
      TaResteRecherche.Open;
    if ListeIDEcriture<>nil then
      Begin
        TaResteRecherche.filter:=CreeFiltreOU('ID_Ecriture',[ListeIDEcriture]);
        TaResteRecherche.filtered:=true;
        TaResteRecherche.first;
        while not TaResteRecherche.eof do
          Begin //récupérer infos pointages de l'id ecriture
             if ListePointage=nil then
               ListePointage:=TStringList.Create;
             NewPointage:=TPointageList.Create(self);
             NewPointage.Tiers:=TaResteRecherche.findfield('Tiers').AsString;
             NewPointage.Imputation:=TaResteRecherche.findfield('Montant').AsString;
             NewPointage.IDEcriture:=TaResteRecherche.findfield('ID_Ecriture').asinteger;
             NewPointage.Pointer:=NewPointage.Imputation;
             NewPointage.Lettre:=TaResteRecherche.findfield('lettre').asstring;
             NewPointage.sens:=TaResteRecherche.findfield('sens').asstring;
             NewPointage.DateTva:=TaResteRecherche.findfield('Date').AsDateTime;
             ListePointage.AddObject(NewPointage.Imputation,NewPointage);
             TaResteRecherche.next;
          End;//fin récupérer infos pointages de l'id ecriture
      End
    else
    abort;
  except
    abort;
  end;
End;

//procedure TDMPointage2.EnregistrementPointages(ListePointage:Tstringlist;var ListeID_Pointage:Tstringlist;Gerer_Reste:boolean);
//var
//i,j,rangMaitre,rangEsclave:integer;
//LettreCourante:string;
//ResteItemMaitre,ValeurAPointer:currency;
//RecordPointage:variant;
//InfosPointage:Tinfos_Pointage;
//listetemp,ListeMaitres,ListeEsclaves:tstringlist;
//IDPointage:integer;
//messagetmp:string;
//TiersPointe:string;
//begin
////récupérer les différentes lettres
//   try//début du try except
//       try//debut du try finally
//            //pour toutes ses lettres renouveler l'opération suivante
//             for i:=0 to ListePointage.count-1 do
//               Begin //début boucle pour listelettres
//               //récupérer dans listeMaitres les débits et dans listeEsclaves tous les crédits
//               //concernant la lettre en cours
//               LettreCourante:=ListePointage.Strings[i];
//                  /////////********
//                   RecordPointage:=VarArrayCreate([0,4],varVariant);
//                   if (ListeMaitres.Objects[rangMaitre]as TPointageList).Sens='D'then
//                      Begin
//                       RecordPointage[0]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
//                       RecordPointage[1]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).IDEcriture;
//                       RecordPointage[2]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).DateTva;
//                       RecordPointage[4]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).DateTva;
//
////                     InfosPointage.ID_Debit:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
////                     InfosPointage.ID_credit:=(ListeMaitres.Objects[rangEsclave]as TPointageList).IDEcriture;
////                     InfosPointage.DateMaitre:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).DateTva;
////                     InfosPointage.DateEsclave:=(ListeMaitres.Objects[rangMaitre]as TPointageList).DateTva;
//                      End
//                   else
//                      Begin
//                       RecordPointage[0]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).IDEcriture;
//                       RecordPointage[1]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
//                       RecordPointage[2]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).DateTva;
//                       RecordPointage[4]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).DateTva;
////                     InfosPointage.ID_Debit:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).IDEcriture;
////                     InfosPointage.ID_credit:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
////                     InfosPointage.DateMaitre:=(ListeMaitres.Objects[rangMaitre]as TPointageList).DateTva;
////                     InfosPointage.DateEsclave:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).DateTva;
//                      End;
////                                     InfosPointage.MontantPointage:=ValeurAPointer;
//                   RecordPointage[3]:=ValeurAPointer;
//
//                 IDPointage:=CreationPointageSurIDEcriture(RecordPointage,TiersPointe,Gerer_Reste);
////                                   IDPointage:=CreationPointageSurIDEcriture(InfosPointage,TiersPointe,Gerer_Reste);
//                 if IDPointage<>-1 then
//                    ListeID_Pointage.Add(inttostr(IDPointage));
//                (ListeMaitres.Objects[rangMaitre]as TPointageList).Pointer:=currtostr(StrToCurr_lgr((ListeMaitres.Objects[rangMaitre]as TPointageList).Pointer)-ValeurAPointer);
//                (ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer:=currtostr(StrToCurr_lgr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)-ValeurAPointer);
//               if not empty(LettreCourante)then
//                  SuppressionLettrage_ApresGestionDesPointages(TaResteDC,LettreCourante);
//                  End;//fin boucle for pour ListePointage
//       if not TaPointage.Active then
//         TaPointage.open;
//       TableGereCommit(TaPointage);
//       TableGereCommit(DMBalance.TaBalance);
//      finally
//         RecordPointage:=Unassigned;
//         LettrageEnCours:='';
//         messagetmp:='Abandon de l''enregistrement du pointage';
//      end;//fin du try finally
//   except
//     if not TaPointage.Active then
//       TaPointage.open;
//     TableGereRollBack(TaPointage);
//     TableGereRollBack(DMBalance.TaBalance);
//     if not empty(messagetmp)then
//       showmessage(messagetmp);
//     abort;
//   end;//fin du try except
//End;



procedure TDMPointage2.EnregistrementPointages(ListePointage,ListeLettrages:Tstringlist;var ListeID_Pointage:Tstringlist;TiersPointe:string;Gerer_Reste:boolean);
var
i,j,rangMaitre,rangEsclave:integer;
LettreCourante:string;
ResteItemMaitre,ValeurAPointer:currency;
RecordPointage:variant;
InfosPointage:Tinfos_Pointage;
listetemp,liste_IDEcriture,ListeMaitres,ListeEsclaves:tstringlist;
IDPointage:integer;
messagetmp:string;
TiersCourant:string;
begin
//récupérer les différentes lettres
   try//début du try except
       try//debut du try finally
         ListeMaitres:=Tstringlist.create;
         ListeEsclaves:=Tstringlist.create;
         liste_IDEcriture:=Tstringlist.create;
         ListeLettrages.Sorted:=true;
         if ListeLettrages.Count<>0 then
            begin//s'il y au moins une lettre dans liste
            //pour toutes ses lettres renouveler l'opération suivante
            while ((ListePointage.Count>0)and(ListeLettrages.Count>0)) do
              begin//tant qu'il reste des pointages
                i:=0;
                while ListeLettrages.Count>0 do
                   Begin //début boucle pour listelettres
                   //récupérer dans listeMaitres les débits et dans listeEsclaves tous les crédits
                   //concernant la lettre en cours
                   LettreCourante:=ListeLettrages.Strings[i];
                   TiersCourant:=(ListePointage.Objects[0]as TPointageList).Tiers;

                   for j:=0 to ListeMaitres.count-1 do
                    TPointageList(ListeMaitres.Objects[j]).destroy;
                   ListeMaitres.clear;

                   for j:=0 to ListeEsclaves.count-1 do
                    TPointageList(ListeEsclaves.Objects[j]).destroy;
                    ListeEsclaves.clear;

                   ListeMaitres.Duplicates:=dupAccept;
                   ListeEsclaves.Duplicates:=dupAccept;
                   j:=0;
                     while j<=ListePointage.count-1 do
                       Begin //début boucle for pour récupérer listeMaitres et Esclaves pour lettre courante
//                         showmessage((ListePointage.Objects[j]as TPointageList).lettre);
//                         showmessage((ListePointage.Objects[j]as TPointageList).Tiers);
                         if (((ListePointage.Objects[j]as TPointageList).lettre=LettreCourante)and((ListePointage.Objects[j]as TPointageList).Tiers=TiersCourant)) then
                            Begin //si ligne correspond à lettre courante, récupérer le montant imputé et l'id Ecriture
                               if (ListePointage.Objects[j]as TPointageList).sens='D' then
                                  Begin //si ligne au débit
                                     ListeMaitres.Addobject((ListePointage.Objects[j]as TPointageList).Imputation,(ListePointage.Objects[j]as TPointageList));
                                     ListePointage.delete(j);
                                     dec(j);
                                  End//fin si ligne au débit
                               else
                                  Begin//si ligne au crédit
                                     ListeEsclaves.Addobject((ListePointage.Objects[j]as TPointageList).Imputation,(ListePointage.Objects[j]as TPointageList));
                                     ListePointage.delete(j);
                                     dec(j);
                                  End;//fin si ligne au crédit
                            End;// fin si ligne correspond à lettre courante
                       inc(j)
                       End;//fin boucle for pour récupérer listeMaitres et Esclaves pour lettre courante


                    TriListeInteger(ListeMaitres);
                    TriListeInteger(ListeEsclaves);
                    if ListeMaitres.Strings[0]<ListeEsclaves.Strings[0]then
                      Begin //si montant le plus grand fait partie de la liste esclave, liste esclave devient listeMaitre
                        if ListeTemp<>nil then
                           ListeTemp:=tstringlist.Create;
                        ListeTemp:=ListeEsclaves;
                        ListeEsclaves:=ListeMaitres;
                        ListeMaitres:=ListeTemp;
                      End;//fin si montant le plus grand fait partie de la liste esclave
    
                   rangMaitre:=0;
                   //Button1Click(button1);
                   while rangMaitre<=ListeMaitres.count-1 do
                      Begin //tant que pas fin listeMaitre faire
                      rangEsclave:=0;
                        ResteItemMaitre:=StrToCurr_lgr(ListeMaitres.Strings[rangMaitre]);
                           while  ResteItemMaitre>0 do
                              Begin//tant que ResteItemMaitre >0
                                  if StrToCurr_lgr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)>0 then
                                     begin
                                          if ResteItemMaitre>StrToCurr_lgr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)then
                                             ValeurAPointer:=StrToCurr_lgr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)
                                          else
                                             ValeurAPointer:= ResteItemMaitre;
                                        ResteItemMaitre:=ResteItemMaitre-StrToCurr_lgr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer);
                                        /////////********
                                         RecordPointage:=VarArrayCreate([0,4],varVariant);
                                         if (ListeMaitres.Objects[rangMaitre]as TPointageList).Sens='D'then
                                            Begin
                                             RecordPointage[0]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
                                             RecordPointage[1]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).IDEcriture;
                                             RecordPointage[2]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).DateTva;
                                             RecordPointage[4]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).DateTva;

    //                                         InfosPointage.ID_Debit:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
    //                                         InfosPointage.ID_credit:=(ListeMaitres.Objects[rangEsclave]as TPointageList).IDEcriture;
    //                                         InfosPointage.DateMaitre:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).DateTva;
    //                                         InfosPointage.DateEsclave:=(ListeMaitres.Objects[rangMaitre]as TPointageList).DateTva;
                                            End
                                         else
                                            Begin
                                             RecordPointage[0]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).IDEcriture;
                                             RecordPointage[1]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
                                             RecordPointage[2]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).DateTva;
                                             RecordPointage[4]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).DateTva;
    //                                         InfosPointage.ID_Debit:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).IDEcriture;
    //                                         InfosPointage.ID_credit:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
    //                                         InfosPointage.DateMaitre:=(ListeMaitres.Objects[rangMaitre]as TPointageList).DateTva;
    //                                         InfosPointage.DateEsclave:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).DateTva;
                                            End;
    //                                     InfosPointage.MontantPointage:=ValeurAPointer;
                                         RecordPointage[3]:=ValeurAPointer;

                                       IDPointage:=CreationPointageSurIDEcriture(RecordPointage,TiersPointe,Gerer_Reste).Id_Piece;
    //                                   IDPointage:=CreationPointageSurIDEcriture(InfosPointage,TiersPointe,Gerer_Reste);
                                       if IDPointage<>-1 then
                                          ListeID_Pointage.Add(inttostr(IDPointage));
                                      (ListeMaitres.Objects[rangMaitre]as TPointageList).Pointer:=currtostr(StrToCurr_lgr((ListeMaitres.Objects[rangMaitre]as TPointageList).Pointer)-ValeurAPointer);
                                      (ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer:=currtostr(StrToCurr_lgr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)-ValeurAPointer);
                                      inc(rangEsclave);
                                     end
                                  else
                                     inc(rangEsclave);
                              End;//fin tant que ResteItemMaitre >0
                      inc(rangMaitre);
                      End;//fin tant que pas fin listeMaitre faire
                   if not empty(LettreCourante)then
                      begin
                        SuppressionLettrage_ApresGestionDesPointages(TaResteDC,LettreCourante,ListePointage);
                        TaResteDC.Refresh;
                        ListeLettrages:=RecupListeLettre_surDataset(TaResteDC,true).Liste;
                      end;
                      End;//fin boucle for pour listelettres
              end;//fin tant qu'il reste des pointages
            end;//fin s'il y au moins une lettre dans liste
        for i:=0 to ListeMaitres.count-1 do
          TPointageList(ListeMaitres.Objects[i]).destroy;
        LibereObjet(tobject(ListeMaitres));
//       Initialise_TStringlist(ListeMaitres);
        for i:=0 to ListeEsclaves.count-1 do
          TPointageList(ListeEsclaves.Objects[i]).destroy;
        LibereObjet(tobject(ListeEsclaves));
//       Initialise_TStringlist(ListeEsclaves);
//       Initialise_TStringlist(ListePointage);

       if not TaPointage.Active then
         TaPointage.open;
       TableGereCommit(TaPointage);
       TableGereCommit(DMBalance.TaBalance);
      finally
         RecordPointage:=Unassigned;
         LettrageEnCours:='';
         messagetmp:='Abandon de l''enregistrement du pointage';
      end;//fin du try finally
   except
     if not TaPointage.Active then
       TaPointage.open;
     TableGereRollBack(TaPointage);
     TableGereRollBack(DMBalance.TaBalance);
     if not empty(messagetmp)then
       showmessage(messagetmp);
     abort;
   end;//fin du try except
End;

Function TDMPointage2.ValiderPointages(DataSetTaResteDC:TDataSet;TiersPointe:string;Gerer_Reste:boolean):boolean;
var
i:integer;
ListeLettres,liste_IDEcriture,liste_Pointages,ListeIDPointages:Tstringlist;
ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
begin
result:=true;

ListeLettres:=RecupListeLettre_surDataset(DataSetTaResteDC,true).Liste;
for i:=0 to ListeLettres.Count - 1 do
 begin//début boucle for listelettres
      ResteDCInfoLettrageEnCours:=DMPointage2.CalculLettrageEnCours(nil,TiersPointe,ListeLettres.Strings[i],0,'');
      if not ResteDCInfoLettrageEnCours.Equilibre then
       begin//si pointages en cours pas équilibrés
        showmessage('Les pointages regroupés sous la lettre : '+ListeLettres.Strings[i]+' ne sont pas équilibrés !');
        TaResteDC.Locate('Lettre',ListeLettres.Strings[i],[]);
        if RecupDetteCreance('',TiersPointe,'',[''],0,0,0,0,nil,False).NBLigneResteAPointer > 0 then
         begin
           if (Pointages2= nil) Then Pointages2:= TPointages2.Create(Application.MainForm);
           Pointages2.EdCompte.Text:=TiersPointe;
           if not pointages2.Showing then
             Pointages2.ShowModal;
         end;
        exit;
       end;//fin si pointages en cours pas équilibrés
 end;//fin boucle for listelettres
try//finally
ListeIDPointages:=tstringlist.Create;
if ListeLettres=nil then ListeLettres:=tstringlist.Create;
liste_IDEcriture:=tstringlist.Create;
liste_Pointages:=tstringlist.Create;
 if listelettres.count<>0 then
  begin// si listelettres créée
     try//except
          if TaPointage.active=false then
              TaPointage.open;
           TableGereStartTransaction(TaPointage);


          //si besoin, suppression de la dernière OD de déclaration
           if supprODDeclaration then
             Begin
               //Supprimer la dernière OD de déclaration
               DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false);
               supprODDeclaration:=false;
             End;
//         RemplissageListePointages_SurDataset_EtLettrage(listelettres,Liste_Pointages); // PB le 10/04/04

         RecupListeIDEcriturePointages_SurDataset(liste_IDEcriture,listelettres);
         RemplissageListePointages_SurDataset(liste_IDEcriture,liste_Pointages);
         EnregistrementPointages(liste_Pointages,ListeLettres,ListeIDPointages,TiersPointe,true);
     except
     result:=false;
     abort;
     end;//fin du try except
  end;//fin si listelettres créée
finally
Initialise_TStringlist(ListeIDPointages);
Initialise_TStringlist(ListeLettres);
Initialise_TStringlist(liste_IDEcriture);
for i:=0 to Liste_pointages.count-1 do
  TPointageList(liste_Pointages.Objects[i]).destroy;
LibereObjet(tobject(liste_Pointages));
//Initialise_TStringlist(liste_Pointages);
end;//fin du finally
End;


Function TDMPointage2.RecupListeLettre_surDataset(DataSet:TDataSet;ListeLettre:boolean):TResultStrList;
Begin
  result.Liste:=TStringList.Create;
  QuRecupListeLettres.close;
  QuRecupListeLettres.open;
result.Result:=QuRecupListeLettres.RecordCount<>0;
 if ListeLettre then
 begin
  while not QuRecupListeLettres.eof do
    begin
      if result.Liste.indexof(QuRecupListeLettres.findfield('lettre').asstring)=-1 then
        result.Liste.add(QuRecupListeLettres.findfield('lettre').asstring);
      QuRecupListeLettres.next;
    end;
 end;
End;

procedure TDMPointage2.SuppressionLettrage_Enreg_Courant(DataSet:TDataSet);
var
ProcBeforePost:TDataSetNotifyEvent;
Begin
if not DataSet.Active then abort;
if DataSet.RecordCount = 0 then abort;
if DataSet.State in [dsEdit,dsInsert] then DataSet.cancel;
if DataSet.State in [dsBrowse] then
 begin
   DataSet.Edit;
   ProcBeforePost:=DataSet.beforePost;
   if (dataset as Ttable).Name='TaAffectReglement'then
     DataSet.beforePost:=TaAffectReglementBeforeDelete
   else
     DataSet.beforePost:=nil;
   MontantTmp:=DataSet.FindField('Montant').AsCurrency;
   DataSet.FindField('Montant').AsString:='';
   DataSet.FindField('Lettre').AsString:='';
   TableGerePost(DataSet);
   DataSet.beforePost:=ProcBeforePost;
 end;
//
End;


procedure TDMPointage2.SuppressionLettrage_ApresGestionDesPointages(DataSetAMettreAJour:TDataSet;lettreASupprimer:string;ListePointage:Tstringlist);
var
Nb,i:integer;
begin
try//finally
Initialise_TStringlist(ListeEcritureFilterRecord,nil,false);
if not TaResteUpdateLettrage.active then
  TaResteUpdateLettrage.open
  else
  TaResteUpdateLettrage.Refresh;
if ListePointage<>nil then
    begin
        for i:=0 to ListePointage.count-1 do
          ListeEcritureFilterRecord.add(inttostr((ListePointage.Objects[i]as TPointageList).IDEcriture));
        TaResteUpdateLettrage.OnFilterRecord:=TaResteUpdateLettrageFilterRecord;
    end;
TaResteUpdateLettrage.Filter:=CreeFiltreou('lettre',[lettreASupprimer]);
TaResteUpdateLettrage.first;
nb:=TaResteUpdateLettrage.RecordCount;
while nb>0 do
  begin
  TaResteUpdateLettrage.edit;
  TaResteUpdateLettrage.FindField('lettre').asstring:='';
  TaResteUpdateLettrage.FindField('montant').asstring:='';
  TableGerePost(TaResteUpdateLettrage);
  dec(nb);
  end;
if DataSetAMettreAJour <> nil then
DataSetAMettreAJour.Refresh;
finally
 TaResteUpdateLettrage.OnFilterRecord:=nil;
end;
end;

// Cette prodecure supprime tous les lettrages de liste_lettre
// ou du dataset : DataSetAMettreAJour
// !!!!!!!! Si liste_lettre = nil, alors suppression de tous les lettrages en cours !!!!!!!
// !!!!!!!! Sinon, suppression uniquement des lettres de Liste_lettre !!!!!!!!!!!!!!!!
// DataSetAMettreAJour est le dataset que l'on veut mettre à jour pour l'affichage
procedure TDMPointage2.SuppressionLettrage_Tous_ApresGestionDesPointages(DataSetAMettreAJour:TDataSet;liste_lettre:Tstringlist);
var
i:integer;
Begin
if liste_lettre <> nil then
 begin
   for i:=0 to liste_lettre.Count-1 do
    begin
     DMPointage2.SuppressionLettrage_ApresGestionDesPointages(nil,liste_lettre.Strings[i]);
    end;
 end
 else
 Begin
  liste_lettre:=RecupListeLettre_surDataset(DataSetAMettreAJour,true).Liste;
   for i:=0 to liste_lettre.Count-1 do
    begin
     DMPointage2.SuppressionLettrage_ApresGestionDesPointages(nil,liste_lettre.Strings[i]);
    end;
  liste_lettre.Free;
 End;
if DataSetAMettreAJour <> nil then
DataSetAMettreAJour.Refresh;


End;


// Attention, le nom de la procedure est à changer,
// Car la recherche porte sur la table ResteDC et non sur la table Pointage

// Retourne la liste des id actuellement lettré dans la table ResteDC
procedure TDMPointage2.RecupListeIDEcriturePointages_SurDataset(var ListeIDEcriture:Tstringlist;liste_lettre:Tstringlist);
var
i:integer;
Begin
  try
    if not TaResteRecherche.Active then
      TaResteRecherche.Open
      else
      TaResteRecherche.Refresh;

    if ListeIDEcriture=nil then
       ListeIDEcriture:=TStringList.Create;
    TaResteRecherche.filter:=CreeFiltreOU('lettre',[liste_lettre]);
    TaResteRecherche.filtered:=true;
    TaResteRecherche.first;
    while not TaResteRecherche.eof do
      Begin //
        if ListeIDEcriture.IndexOf(TaResteRecherche.findfield('ID_Ecriture').asstring)=-1 then
          ListeIDEcriture.Add(TaResteRecherche.findfield('ID_Ecriture').asstring);
        TaResteRecherche.next;
      End;
    TaResteRecherche.filter:='';
    TaResteRecherche.filtered:=False;
  except
    TaResteRecherche.filter:='';
    TaResteRecherche.filtered:=False;
    abort;
  end;
End;


procedure TDMPointage2.TaResteDCAfterPost(DataSet: TDataSet);
begin
if (dataset as ttable).Name='TaResteDC' then
  begin
    DAtaSet.EnableControls;
    DAtaSet.Fields[11].FocusControl; 
  end;
end;

procedure TDMPointage2.TaResteDCCalcFields(DataSet: TDataSet);
var a:integer;
begin

//if(TaResteDCReference.AsString='AC1500075')then showmessage('ok');
TaResteDCResteAffich.AsCurrency:=TaResteDCReste.AsCurrency - TaResteDCMontant.AsCurrency;
if TaResteDCSens.asstring='D'then
  begin
    TaResteDCResteDebit.AsCurrency:=TaResteDCReste.AsCurrency;
    TaResteDCMontantPiece.AsCurrency:=TaResteDCDebit.AsCurrency;
    TaResteDCMontantDebit.AsCurrency:=TaResteDCMontant.AsCurrency;
  end
else
  begin
    TaResteDCResteCredit.AsCurrency:=TaResteDCReste.AsCurrency;
    TaResteDCMontantPiece.AsCurrency:=TaResteDCCredit.AsCurrency;
    TaResteDCMontantCredit.AsCurrency:=TaResteDCMontant.AsCurrency;
  end;

  //calc solde sur "montant" progressif
  if ListeIdDC.IndexOf(TaResteDCID.AsString)=-1 then
  begin
    //Dette ou Creance non deja traitée
    if TiersCalcSolde<>TaResteDCTiers.AsString then
      begin
        solde:=0;
      end;
    if TaResteDCSens.asstring='D'then begin
        TaResteDCSolde.AsCurrency:=solde+TaResteDCReste.AsCurrency;
        solde:=TaResteDCSolde.AsCurrency;

    end
    else begin
        TaResteDCSolde.AsCurrency:=solde-TaResteDCReste.AsCurrency;
        solde:=TaResteDCSolde.AsCurrency;

    end;
    TiersCalcSolde:=TaResteDC.findfield('Tiers').AsString;
    ListeIdDC.Add(TaResteDCID.AsString);
    ListeSolde.Add(CurrToStr(solde));
  end
  else
    begin
      //Dette ou créance déja traitée ;on reprend son solde
      TaResteDCSolde.AsCurrency:=StrToCurr_lgr(ListeSolde[ListeIdDC.IndexOf(TaResteDCID.AsString)]);
    end;
  if(TaResteDCSolde.AsCurrency>0)then TaResteDCSensSolde.AsString:='D' else if(TaResteDCSolde.AsCurrency<0) then TaResteDCSensSolde.AsString:='C'

end;


//procedure TDMPointage2.TaResteDCCalcFields_SoldeProgressif(DataSet: TDataSet);
//var a:integer;
//begin
//
////if(TaResteDCReference.AsString='AC1500075')then showmessage('ok');
//TaResteDCResteAffich.AsCurrency:=TaResteDCReste.AsCurrency - TaResteDCMontant.AsCurrency;
//if TaResteDCSens.asstring='D'then
//  begin
//    TaResteDCResteDebit.AsCurrency:=TaResteDCReste.AsCurrency;
//    TaResteDCMontantPiece.AsCurrency:=TaResteDCDebit.AsCurrency;
//    TaResteDCMontantDebit.AsCurrency:=TaResteDCMontant.AsCurrency;
//  end
//else
//  begin
//    TaResteDCResteCredit.AsCurrency:=TaResteDCReste.AsCurrency;
//    TaResteDCMontantPiece.AsCurrency:=TaResteDCCredit.AsCurrency;
//    TaResteDCMontantCredit.AsCurrency:=TaResteDCMontant.AsCurrency;
//  end;
//
//  //calc solde sur "montant" progressif
//  if ListeIdDC.IndexOf(TaResteDCID.AsString)=-1 then
//  begin
//    //Dette ou Creance non deja traitée
//    if TiersCalcSolde<>TaResteDCTiers.AsString then
//      begin
//        solde:=0;
//      end;
//    if TaResteDCSens.asstring='D'then begin
//        TaResteDCSolde.AsCurrency:=solde+TaResteDCReste.AsCurrency;
//        solde:=TaResteDCSolde.AsCurrency;
//
//    end
//    else begin
//        TaResteDCSolde.AsCurrency:=solde-TaResteDCReste.AsCurrency;
//        solde:=TaResteDCSolde.AsCurrency;
//
//    end;
//    TiersCalcSolde:=TaResteDC.findfield('Tiers').AsString;
//    ListeIdDC.Add(TaResteDCID.AsString);
//    ListeSolde.Add(CurrToStr(solde));
//  end
//  else
//    begin
//      //Dette ou créance déja traitée ;on reprend son solde
//      TaResteDCSolde.AsCurrency:=StrToCurr_lgr(ListeSolde[ListeIdDC.IndexOf(TaResteDCID.AsString)]);
//    end;
//  if(TaResteDCSolde.AsCurrency>0)then TaResteDCSensSolde.AsString:='D' else if(TaResteDCSolde.AsCurrency<0) then TaResteDCSensSolde.AsString:='C'
//
//end;

procedure TDMPointage2.QuPointageAffichCalcFields(DataSet: TDataSet);
begin
//QuPointageAffichRefAppelante.AsString:=QuPointageAffich_Ref_Appelante.findField('Reference').AsString;
end;

procedure TDMPointage2.TaPointage1BeforeDelete(DataSet: TDataSet);
Var
InfosCreationReste : TInfosCreationReste;
GestErreur:TErreurTva;
begin
  try
  //regarder si la suppression ne va pas engendrer un problème de TVA
  GestErreur:=dmpieces.piece1.Verification_TvaDeclare_Pointage_new(true,DataSet.findfield('ID_Debit').AsInteger,DataSet.findfield('ID_Credit').AsInteger);
  if not GestErreur.Retour then
    Begin//si problème tva rencontré
       if not gesterreur.Continuer then
         Begin//si on ne peut pas supprimer l'od de déclaration
           showmessage(gesterreur.Messages);
           abort;
         End//fin si on ne peut pas supprimer l'od de déclaration
       else
         Begin//si
           if GestErreur.SupprODDecl then
             begin
             if application.MessageBox(Pchar(gesterreur.messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
               Begin//si
               if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                 abort;
               End//fin si
             else
               abort;
             end
           else
             begin
               showmessage('Ce pointage entre dans une période de tva déclarée non modifiable, vous ne pouvez donc pas le modifiez ou le supprimer');
               abort;
             end;
         End;//fin si
    End;//fin si problème tva rencontré
  // Montant du pointage en cours
  InfosCreationReste.Pointage.MontantPointage:=DataSet.findfield('Montant').AsCurrency;
  InfosCreationReste.IDEcriture:=DataSet.findfield('ID_Debit').AsInteger;
  GestionDuReste(InfosCreationReste,true);
  InfosCreationReste.IDEcriture:=DataSet.findfield('ID_Credit').AsInteger;
  GestionDuReste(InfosCreationReste,true);
  except
    if not ((e.TypeClient=cl_isa) or (((ParamUtil.maintenance)and(ParamUtil.TypeMaintenanceSpeciale='Pointage')))) then
      abort;
  end;
end;

// PB
// Supprime tous les pointages liés à l'ID_Appelant, qui doit être un Id écriture valide
// Utilise DMPointage2.SuppressionPointage
Procedure TDMPointage2.SuppressionTousPointage_SurID_Appelant(Id_Appelant:Integer;Reference:string;Confirmer:boolean);
var
SuppressionOk:Boolean;
begin
if Confirmer then
 begin
  if empty(Reference) then
    SuppressionOk:=Messagedlg('Êtes-Vous sûr de vouloir supprimer tous les pointages liées à l''ID : '+IntToStr(Id_Appelant)+' ?',MtConfirmation,[mbyes,mbno],0) = mrYes
    else
    SuppressionOk:=Messagedlg('Êtes-Vous sûr de vouloir supprimer tous les pointages liées à :'+Reference+' ?',MtConfirmation,[mbyes,mbno],0) = mrYes
 end
  else
  SuppressionOk:=true;


if SuppressionOk then
begin
  try
   TaPointageRecherche.Close;
   TaPointageRecherche.Filter:='ID_Debit='+IntToStr(Id_Appelant)+' or id_Credit='+IntToStr(Id_Appelant);
   TaPointageRecherche.Filtered:=true;
//   DataSetRechercher(TaPointageRecherche,'ID_Debit='+IntToStr(Id_Appelant)+' or id_Credit='+IntToStr(Id_Appelant),true);
   TaPointageRecherche.Open;
//   AfficheInfoComposant('',TaPointageRecherche,true);
   while TaPointageRecherche.RecordCount <> 0 do
     begin
       SuppressionPointage(TaPointageRecherche,false);
       TaPointageRecherche.Refresh;
     end;
  except
    //showmessage(ErrInterne+'Erreur à la suppression des pointages');
  end;
end;
End;

Procedure TDMPointage2.SuppressionPointage(DataSetAffich:TDataSet;Confirmer:boolean);
var
Id_Deb,Id_Cre:Integer;
SuppressionOk:Boolean;
TvaSurE_Debit,TvaSurE_Credit:boolean;
begin
if Confirmer then
  SuppressionOk:=Messagedlg('Êtes-Vous sûr de vouloir supprimer ce pointage ?',MtConfirmation,[mbyes,mbno],0) = mrYes
else
  SuppressionOk:=true;


if SuppressionOk then
begin
  try
  if GrLocate(TaPointage1,'ID_Debit;ID_Credit',[DataSetAffich.FindField('Id_Debit').AsVariant,DataSetAffich.FindField('Id_Credit').AsVariant]) then
   begin
    TableGereDelete(TaPointage1);
    DataSetAffich.Close;
    DataSetAffich.Open;
   end
   else
   begin
    showMessage('Le Pointage n''a pu être trouvé !');
    abort;
   end;
  finally
    //
  end;
end;
End;


procedure TDMPointage2.TaAffectReglementCalcFields(DataSet: TDataSet);
var
rang:integer;
begin
rang:=-1;
//caculer le total imputé pour cet id reste
if ListeID_Appelant<>nil then
  Begin//si
    if ListeID_Appelant.count<>0 then
     rang:=ListResteAffect_IndexOf([DataSet.Fields[0].asstring],[2],DMPointage2.ListeID_Appelant);
     if rang<>-1 then
       Begin//si
          TaAffectReglementResteAffich.AsCurrency:=TaAffectReglementReste.AsCurrency-TotalImputation_IDReste(DataSet.Fields[0].asinteger,-1);
       End//fin si
     else
       TaAffectReglementResteAffich.AsCurrency:=TaAffectReglementReste.AsCurrency - TaAffectReglementMontant.AsCurrency;
  //showmessage(TaAffectReglementResteAffich.asstring+'  '+DataSet.Name);
  End//fin si
Else
  TaAffectReglementResteAffich.AsCurrency:=TaAffectReglementReste.AsCurrency - TaAffectReglementMontant.AsCurrency;
end;

Function TDMPointage2.InitTableVisuPointage(Tiers : string;ID_Ecriture:Integer;DateDeb,DateFin:TDate;Journal:string):boolean;
var
Coord:string;
Begin
TaVisuResteDC.Filter:=CreeFiltreET(['Tiers'],[Tiers]);
if dateDeb<>0 then
  begin
    TaVisuResteDC.OnFilterRecord:=nil;
    if not empty(TaVisuResteDC.Filter) then
      Coord:=' and '
    else
      Coord:=' ';
    TaVisuResteDC.Filter:=TaVisuResteDC.Filter+Coord+' Date >= '''+datetostr(DateDeb)+'''';
    TaVisuResteDC.Filter:=TaVisuResteDC.Filter+Coord+' Date <= '''+datetostr(DateFin)+'''';
  end
else
  TaVisuResteDC.OnFilterRecord:=TaVisuResteDCFilterRecord;
TaVisuResteDC.Filtered:=true;
TaVisuResteDC.Open;
TaVisuResteDC.Locate('ID_Ecriture',ID_Ecriture,[]);
result:=TaVisuResteDC.RecordCount <> 0;
End;

procedure TDMPointage2.TaVisuResteDCAfterScroll(DataSet: TDataSet);
begin
if DataSet.recordCount <> 0 then
 begin
   if not VerifFNumeric(DataSet.FindField('Debit')).VideOUZero then
    TaVisuPointage.Filter:=CreeFiltreET(['Id_Debit'],[DataSet.FindField('Id_Ecriture').AsString])
    else
    TaVisuPointage.Filter:=CreeFiltreET(['Id_Credit'],[DataSet.FindField('Id_Ecriture').AsString]);
 end
 else
 begin
  TaVisuPointage.Filter:=CreeFiltreET(['Id_Credit'],['-1']);
 end;
TaVisuPointage.Filtered:=true;
TaVisuPointage.Open;

end;

procedure TDMPointage2.TaVisuResteDCCalcFields(DataSet: TDataSet);
begin
if not VerifFNumeric(TaVisuResteDCDebit).VideOUZero then
TaVisuResteDCImputation.AsCurrency:=TaVisuResteDCDebit.AsCurrency - TaVisuResteDCReste.AsCurrency
else
TaVisuResteDCImputation.AsCurrency:=TaVisuResteDCCredit.AsCurrency - TaVisuResteDCReste.AsCurrency
end;

procedure TDMPointage2.TaVisuPointageCalcFields(DataSet: TDataSet);
begin
TaVisuPointageID_Ecriture.AsInteger:=0;
if not VerifFNumeric(TaVisuResteDCDebit).VideOUZero then
 begin
   if TaLookUpVisuPointage_ResteDC.Locate('Id_Ecriture',TaVisuPointage.findField('Id_Credit').AsString,[]) then
    begin
      TaVisuPointageReference.AsString:=TaLookUpVisuPointage_ResteDC.findField('Reference').AsString;
      TaVisuPointageLibelle.AsString:=TaLookUpVisuPointage_ResteDC.findField('Libelle').AsString;
      TaVisuPointageTiers.AsString:=TaLookUpVisuPointage_ResteDC.findField('Tiers').AsString;
      TaVisuPointageDatePiece.AsDateTime:=TaLookUpVisuPointage_ResteDC.findField('Date').AsDateTime;
      TaVisuPointageDebit.AsCurrency:=TaLookUpVisuPointage_ResteDC.findField('Debit').AsCurrency;
      TaVisuPointageCredit.AsCurrency:=TaLookUpVisuPointage_ResteDC.findField('Credit').AsCurrency;
      TaVisuPointageID_Ecriture.AsInteger:=TaVisuPointage.findField('Id_Credit').AsInteger;
    end
    else
    begin
     TaVisuPointageReference.AsString:='Erreur sur les pointages Credit';
    end;
 end
 else
if not VerifFNumeric(TaVisuResteDCCredit).VideOUZero then
 begin
   if TaLookUpVisuPointage_ResteDC.Locate('Id_Ecriture',TaVisuPointage.findField('Id_Debit').AsString,[]) then
    begin
      TaVisuPointageReference.AsString:=TaLookUpVisuPointage_ResteDC.findField('Reference').AsString;
      TaVisuPointageLibelle.AsString:=TaLookUpVisuPointage_ResteDC.findField('Libelle').AsString;
      TaVisuPointageTiers.AsString:=TaLookUpVisuPointage_ResteDC.findField('Tiers').AsString;
      TaVisuPointageDatePiece.AsDateTime:=TaLookUpVisuPointage_ResteDC.findField('Date').AsDateTime;
      TaVisuPointageDebit.AsCurrency:=TaLookUpVisuPointage_ResteDC.findField('Debit').AsCurrency;
      TaVisuPointageCredit.AsCurrency:=TaLookUpVisuPointage_ResteDC.findField('Credit').AsCurrency;
      TaVisuPointageID_Ecriture.AsInteger:=TaVisuPointage.findField('Id_Debit').AsInteger;
    end
    else
    begin
     TaVisuPointageReference.AsString:='Erreur sur les pointages débit';
    end;
 end
 else
 Showmessage('Une erreur est survenu pendant le parcours des Lignes de compte !');

end;

procedure TDMPointage2.TaVisuPointageBeforeOpen(DataSet: TDataSet);
begin
TaLookUpVisuPointage_ResteDC.Open;
end;

procedure TDMPointage2.TaVisuResteDCAfterOpen(DataSet: TDataSet);
begin
 FormateMonnaieField(DataSet,E.FormatMonnaie,'');
end;

procedure TDMPointage2.TaVisuPointageAfterOpen(DataSet: TDataSet);
begin
 FormateMonnaieField(DataSet,E.FormatMonnaie,'');
end;

procedure TDMPointage2.TaVisuResteDCBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMPointage2.TaVisuPointageBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

Function TDMPointage2.InfosPointageSurResteDC(ID_Ecriture:Integer):TInfoResteDCSurEcriture;
Var
InfosResteDC:TInfosResteDC;
Begin
InfosResteDC:=Infos_TInfosResteDC(dmrech.tarestedcRech,'ID_Ecriture',[Id_Ecriture]);
if InfosResteDC.ResultInfos then
 begin
  Result.NBLignePointee:=-1;
  Result.NBLigneResteAPointer:=-1;
  Result.ResteAPointee:=InfosResteDC.Reste > 0;
  Result.reste:=InfosResteDC.Reste;
 end
 else
 begin
  Result.ResteAPointee:=true;
 end;
End;


function TDMPointage2.SupprimeResteSurIDEcriture(IDEcriture:integer):boolean;
Begin
  try
  if not TaReste.active then
  TaReste.open;
      try
        if TaReste.Locate('ID_Ecriture',IDEcriture,[]) then
        begin
          TableGereDelete(TaReste);
        end
      except
      result:=false;
      abort;
      end;//fin du try except
  finally
  TaReste.close;
  end;
End;


function TDMPointage2.CalculResteSurIDEcriture(IDEcriture:integer;Tiers:string):TReste;
Begin
result.Reste:=0;
result.ResteInitial:=0;
result.SensReste:=false;
  try
     FiltrageDataSet(TaResteRecherche,CreeFiltreET(['ID_Ecriture','Tiers'],[inttostr(IDEcriture),Tiers]));
     if TaResteRecherche.RecordCount<>0 then
       begin
       result.Reste:=TaResteRecherche.findfield('Reste').AsCurrency;
       result.SensReste:=TaResteRecherche.findfield('Sens').AsBoolean;
       Result.ResteInitial:=0;
       end;
  except
   showmessage('Problème au calcul du reste des Dettes et Créances');
   abort;
  end;
End;


procedure Lettrage_Sur_Liste_Affich(AnnulerSiLettrageEnCours:boolean;Dataset:TTable;ListeReglement:Tlist;Affich,confirmValidation:boolean;lettre:string);
var
i,j,ITmp:integer;
PlusieursTiers:boolean;
TiersEnCours:tstringlist;
LettreCourante:string;
SupprOD:boolean;
filtre:string;
etatfiltre:boolean;
idAPointer:integer;
ListIdPointer:Tstringlist;
Begin
try//finally
filtre:=Dataset.filter;
etatfiltre:=Dataset.filtered;
DeFiltrageDataSet(dataset);
TiersEnCours:=tstringlist.Create;
SupprOD:=false;
idAPointer:=0;
ListIdPointer:=tstringlist.create;
  try
    if ListeReglement<>nil then
      Begin//si liste créée
        if ((DMPointage2.RecupListeLettre_surDataset(Dataset,false).Result)and(AnnulerSiLettrageEnCours)) then
          begin
            showmessage('Un lettrage est déjà en cours, vous devez le valider !!!');
            abort;
          end;
        for i:=0 to ListeReglement.count-1 do
          Begin
//          if Type_version_execution=CT_DEVELOPPEMENT then
//            AfficheInfoComposant('',TEcriture_Isa(ListeReglement.Items[i]),true);
          iTmp:=1;
          if not SupprOD then
            SupprOD:=TEcriture_Isa(ListeReglement.Items[i]).Piece.SuppDerniereDeclTva;
          if empty(lettre)then
            LettreCourante:=Chr(i+65)
          else
            LettreCourante:=lettre;
            //d'abord, on enregistre le pointages des nouvelles pièces créées
            //si ces pièces sont de type achat ou ventes, les lignes à pointer correspondent aux lignes de contrepartie
            //d'ou la récupération de firstidecriture
            //sinon, il faut récupérer toutes les lignes du corps qui sont pointables
             if TEcriture_Isa(ListeReglement.Items[i]).Piece.IDJournal in [1,2] then
               idAPointer:=TEcriture_Isa(ListeReglement.Items[i]).FirstIDEcriture
             else
               begin
                 while ((((idAPointer=0))or(ListIdPointer.indexof(inttostr(IdAPointer))<>-1))and(ITmp<=TEcriture_Isa(ListeReglement.Items[i]).ListIdentifiant.Count-1))do
                   begin
                     if ((dmplan.CptEstPointable(PIdentifiant_obj(TEcriture_Isa(ListeReglement.Items[i]).ListIdentifiant.Items[ITmp])^.Ligne.Compte)) or (dmplan.CptEstPointable(PIdentifiant_obj(TEcriture_Isa(ListeReglement.Items[i]).ListIdentifiant.Items[ITmp])^.Ligne.tiers)))then
                       idAPointer:=PIdentifiant_obj(TEcriture_Isa(ListeReglement.Items[i]).ListIdentifiant.Items[ITmp])^.ID_Ord
                     else
                       idAPointer:=0;
                     inc(iTmp);
                   end;
               end;
                if idAPointer<>0 then
                  begin
                     if Dataset.Locate('id_ecriture',idAPointer,[])then
                       DMPointage2.LettrageEnregCourant(Dataset,LettreCourante,TEcriture_Isa(ListeReglement.Items[i]).Piece.Montant)
                     else
                       begin
                         Showmessage('La nouvelle écriture n''apparaît pas dans la table des dettes et créances !!!');
                         abort;
                       end;
                  end;
                ListIdPointer.add(inttostr(idAPointer));
                idAPointer:=0;
            //ensuite, on enregistre le pointages des lignes à régler du départ sur lesquelles on a mis un montant à régler et qui
            //on servi de point de départ
                for j:=0 to TEcriture_Isa(ListeReglement.Items[i]).ListeContrepartie.count-1 do
                  Begin//début du for j
                    if Dataset.Locate('id_ecriture', PEcriture_A_Regler(TEcriture_Isa(ListeReglement.Items[i]).ListeContrepartie[j])^.ID_Ecriture,[])then
                       DMPointage2.LettrageEnregCourant(Dataset,LettreCourante,PEcriture_A_Regler(TEcriture_Isa(ListeReglement.Items[i]).ListeContrepartie[j])^.Montant);
                    if TiersEnCours.IndexOf(PEcriture_A_Regler(TEcriture_Isa(ListeReglement.Items[i]).ListeContrepartie[j])^.Tiers_)=-1 then
                      TiersEnCours.add(PEcriture_A_Regler(TEcriture_Isa(ListeReglement.Items[i]).ListeContrepartie[j])^.Tiers_);
                  End;//fin du for j
             if not empty(TEcriture_Isa(ListeReglement.Items[i]).TiersEcriture)then
               begin
               if TiersEnCours.IndexOf(TEcriture_Isa(ListeReglement.Items[i]).TiersEcriture)=-1 then
                 TiersEnCours.add(TEcriture_Isa(ListeReglement.Items[i]).TiersEcriture);
               end
             else
               TiersEnCours.add(TEcriture_Isa(ListeReglement.Items[i]).CompteEcriture);
          End;//fin boucle for i
//        if not affich then
//          affich:=Type_version_execution=CT_DEVELOPPEMENT;
        if affich then
        begin//si on veut afficher la fenêtre des pointages
          if Pointages2=nil then Pointages2:=tPointages2.Create(application.MainForm);
           if TiersEnCours.count>1 then
             pointages2.paEntete.Visible:=false
           else
             pointages2.EdCompte.text:=TiersEnCours[0];
           DMPointage2.supprODDeclaration:=SupprOD;
           Pointages2.ShowModal;
        end//fin si on veut afficher la fenêtre des pointages
        else
        Begin//sinon, on demande si enregistrer les pointages directement
          if confirmValidation then
            begin//si demande de confirmation pour la validation des pointages
            If Application.messagebox(PChar('Voulez-vous enregistrer le Pointage automatique de ces nouvelles pièces entre elles ?' ),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
              begin
              DMPointage2.supprODDeclaration:=SupprOD;
              for i:=0 to TiersEnCours.Count-1 do
                Begin//
                   if not DMPointage2.ValiderPointages(nil,TiersEnCours[i],true) then
                     abort;
                End;//fin boucle for TiersEnCours
              end
            else
              Begin//si
                 DMPointage2.Gestion_Annulation_Lettrage(Dataset,DMPointage2.LettrageEnCours,'Voulez-vous conserver les lettrages en cours ?',true);
                 //DMPointage2.taResteDC.AfterPost:=DMPointage2.TaResteDCAfterPost;
              End;//fin si
            end//fin si demande de confirmation pour la validation des pointages
          else
              DMPointage2.supprODDeclaration:=SupprOD;
              for i:=0 to TiersEnCours.Count-1 do
                Begin//
                   if not DMPointage2.ValiderPointages(nil,TiersEnCours[i],true) then
                     abort;
                End;//fin boucle for TiersEnCours
            //if DMPointage2.ValiderPointages(nil,edCompte.Text,true) then
        End;//fin si on demande si enregistrer les pointages directement
      End//fin si liste créée
    else
      abort;
  except
    abort;
  end;
finally
  TiersEnCours.free;
  LibereObjet(tobject(ListIdPointer));
  //if ListIdPointer <> nil then ListIdPointer.free;
  if etatfiltre then
    FiltrageDataSet(dataset,filtre)
  else
    Dataset.filter:=filtre;
//  Initialise_TList(ListeReglement);
end;
End;


procedure TDMPointage2.TaAffectReglementAfterEdit(DataSet: TDataSet);
begin
MontantTmp:=TaAffectReglementMontant.ascurrency;
end;



Function TDMPointage2.ModifLettrageEnregCourant(DataSet:TDataset;Lettre:string):boolean;
Begin
if DataSet.State = dsBrowse then DataSet.Edit;
 if DataSet.State in [dsEdit,dsInsert] then
 begin
  DataSet.FindField('Lettre').AsString:=Lettre;
  if empty(Lettre)then
    DataSet.FindField('Montant').AsString:='';
  TableGerePost(dataset);
 end
End;


//Cette procédure permet de vérifier s'il n'y a un traitement
//de TVA engendré par ce pointage




procedure TDMPointage2.TaPointage1BeforePost(DataSet: TDataSet);
Var
//InfosCreationReste : TInfosCreationReste;
GestErreur:TErreurTva;
begin
  try
  //regarder si la suppression ne va pas engendrer un problème de TVA
  GestErreur:=dmpieces.piece1.Verification_TvaDeclare_Pointage_new(false,DataSet.findfield('ID_Debit').AsInteger,DataSet.findfield('ID_Credit').AsInteger);
  if not GestErreur.Retour then
    Begin//si problème tva rencontré
       if not gesterreur.Continuer then
         Begin//si on ne peut pas supprimer l'od de déclaration
           showmessage(gesterreur.Messages);
           abort;
         End//fin si on ne peut pas supprimer l'od de déclaration
       else
         Begin//si
           if GestErreur.SupprODDecl then
             begin
             if application.MessageBox(Pchar(gesterreur.messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
               Begin//si
               if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                 abort;
               End//fin si
             else
               abort;
             end
           else
             if application.MessageBox(Pchar(gesterreur.messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrno then
               abort;
         End;//fin si
    End;//fin si problème tva rencontré
  // Montant du pointage en cours
//  InfosCreationReste.Pointage.MontantPointage:=DataSet.findfield('Montant').AsCurrency;
//  InfosCreationReste.IDEcriture:=DataSet.findfield('ID_Debit').AsInteger;
//  GestionDuReste(InfosCreationReste,true);
//  InfosCreationReste.IDEcriture:=DataSet.findfield('ID_Credit').AsInteger;
//  GestionDuReste(InfosCreationReste,true);
  except
    abort;
  end;
end;


function TDMPointage2.ListResteAffect_IndexOf(valeur:array of string;valeurRech:array of integer;Liste:Tlist):integer;
var
i:integer;
S1:string;
Begin
result:=-1;
i:=0;
   while i<= Liste.Count-1 do
   begin
     case valeurRech[0] of
     1: if inttostr(PListeResteAffect(Liste.items[i])^.ID_Ligne_Appelant)=valeur[0] then
        begin
          if high(valeurRech)>=1 then
             case valeurRech[1] of
               2:if inttostr(PListeResteAffect(Liste.items[i])^.ID_Reste)=valeur[1] then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
               3:if CompareText(PListeResteAffect(Liste.items[i])^.Lettre,valeur[1])=0 then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
               4:begin
                   S1:=str_bool2str(PListeResteAffect(Liste.items[i])^.validation);
                   if CompareText(S1,valeur[1])=0 then
                     Begin//si
                       result:=i;
                       i:=Liste.Count-1;
                     End;//fin si
                 end;
             end//fin du 2ième case
             else
               Begin//si
                   result:=i;
                   i:=Liste.Count-1;
               End;//fin si
        end;
     2: if inttostr(PListeResteAffect(Liste.items[i])^.ID_Reste)=valeur[0] then
        begin
          if high(valeurRech)>=1 then
             case valeurRech[1] of
               1:if inttostr(PListeResteAffect(Liste.items[i])^.ID_Ligne_Appelant)=valeur[1] then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
               3:if CompareText(PListeResteAffect(Liste.items[i])^.Lettre,valeur[1])=0 then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
               4:begin
                   S1:=str_bool2str(PListeResteAffect(Liste.items[i])^.validation);
                   if CompareText(S1,valeur[1])=0 then
                     Begin//si
                       result:=i;
                       i:=Liste.Count-1;
                     End;//fin si
                 end;
             end//fin du 2ième case
             else
               Begin//si
                   result:=i;
                   i:=Liste.Count-1;
               End;//fin si
        end;
     3: if CompareText(PListeResteAffect(Liste.items[i])^.Lettre,valeur[0])=0 then
        begin
          if high(valeurRech)>=1 then
             case valeurRech[1] of
               1:if inttostr(PListeResteAffect(Liste.items[i])^.ID_Ligne_Appelant)=valeur[1] then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
               2:if inttostr(PListeResteAffect(Liste.items[i])^.ID_Reste)=valeur[1] then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
               4:begin
                   S1:=str_bool2str(PListeResteAffect(Liste.items[i])^.validation);
                   if CompareText(S1,valeur[1])=0 then
                     Begin//si
                       result:=i;
                       i:=Liste.Count-1;
                     End;//fin si
                 end;
             end//fin du 2ième case
             else
               Begin//si
                   result:=i;
                   i:=Liste.Count-1;
               End;//fin si
        end;
     4:begin
       S1:=str_bool2str(PListeResteAffect(Liste.items[i])^.Validation);
       if  CompareText(S1,valeur[0])=0 then
        begin
          if high(valeurRech)>=1 then
             case valeurRech[1] of
               1:if inttostr(PListeResteAffect(Liste.items[i])^.ID_Ligne_Appelant)=valeur[1] then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
               2:if inttostr(PListeResteAffect(Liste.items[i])^.ID_Reste)=valeur[1] then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
               3:if CompareText(PListeResteAffect(Liste.items[i])^.lettre,valeur[1])=0 then
                 Begin//si
                   result:=i;
                   i:=Liste.Count-1;
                 End;//fin si
             end//fin du 2ième case
             else
               Begin//si
                   result:=i;
                   i:=Liste.Count-1;
               End;//fin si
        end;
       end;
//     5: if PListeResteAffect(Liste.items[i])^.Validation=valeur[0] then
//        begin
//        result:=i;
//        i:=Liste.Count-1;
//        end;
     end;//fin du case
   inc(i);
   end;
End;


procedure TDMPointage2.TaResteDCBeforeEdit(DataSet: TDataSet);
begin
ImputationTmp:=TaResteDCMontant.AsCurrency;
end;


procedure ListResteAffect__Add_Insert(var Liste:Tlist;Valeur:array of const;Add,Remplace:boolean;Rang:integer);
var
i,rangTmp:integer;
typeligne:Char;
retourboolean:TRetourBool;
RetourTranstypage:TTypeTranstypage;
TListeResteAffect:PListeResteAffect;
Begin
if Liste=nil then Liste:=TList.Create;
new(TListeResteAffect);
   for i:=0 to high(valeur)do
   begin//Début boucle
   RetourTranstypage:=VTypeTranstypage(valeur[i],valeur[i].vtype);
       if  RetourTranstypage.retour then
       begin //si RetourTranstypage.retour=true
           case i mod 6 of
           0:TListeResteAffect^.ID_Ligne_Appelant:=StrToInt_Lgr(RetourTranstypage.valeur);
           1:TListeResteAffect^.ID_Reste:=StrToInt_Lgr(RetourTranstypage.valeur);
           2:TListeResteAffect^.Lettre:=RetourTranstypage.valeur;
           3:TListeResteAffect^.Montant:=StrToCurr_lgr(RetourTranstypage.valeur);
           4:begin
              retourboolean:=strtobool(RetourTranstypage.valeur);
              if retourboolean.retour then
              TListeResteAffect^.Validation:=retourboolean.valeur;
              end;
          end;//fin du case
       end;// fin si RetourTranstypage.retour=true
   end;//fin de boucle

   if Add then
     Liste.Add(TListeResteAffect)
   else
   if ((rang<>-1)and(remplace)) then
     Begin
     Liste.delete(rang);
     Liste.Insert(rang,TListeResteAffect)
     End
     else
       if ((rang<>-1)and(not remplace)) then
       begin
       Liste.Insert(rang,TListeResteAffect);
       end;
End;


procedure TDMPointage2.Initialisation_Liste;
Begin
if DMPointage2.ListeID_Appelant=nil then
  DMPointage2.ListeID_Appelant:=tlist.Create;
End;

procedure TDMPointage2.TaAffectReglementBeforeDelete(DataSet: TDataSet);
var
RetourCtrlPointage:TErreurSaisie;
i,j:integer;
rang:integer;
ResultStrList:TResultStrList;
begin
with DMPointage2 do
  Begin//déhut du with
    if DMPointage2.ListeID_Appelant<>nil then
      Begin//si liste appelant existe
        rang:=ListResteAffect_IndexOf([inttostr(IDEcritureAppelanteloc),Dataset.FindField('ID').Asstring],[1,2],DMPointage2.ListeID_Appelant);
        if rang<>-1 then
          Begin//si
               DMPointage2.ListeID_Appelant.Delete(rang);
          End//fin si
      End;//fin si liste appelant existe
//  TaAffectReglementCalcFields(dataset);
  End;//fin du with
end;

function TDMPointage2.TotalImputation_IDReste(idReste,ID_Appelant:integer):currency;
var
i:integer;
Begin
result:=0;
if DMPointage2.ListeID_Appelant<>nil then
  begin
    if DMPointage2.ListeID_Appelant.count<>0 then
      Begin//si
        for i:=0 to DMPointage2.ListeID_Appelant.count-1 do
          Begin//si
            if ID_Appelant<>-1 then
              begin
              if ((PListeResteAffect(DMPointage2.ListeID_Appelant.Items[i])^.ID_Reste=idReste)and(PListeResteAffect(DMPointage2.ListeID_Appelant.Items[i])^.ID_Ligne_Appelant=ID_Appelant)) then
                result:=result+PListeResteAffect(DMPointage2.ListeID_Appelant.Items[i])^.Montant;
              end
            else
              begin
              if PListeResteAffect(DMPointage2.ListeID_Appelant.Items[i])^.ID_Reste=idReste then
                result:=result+PListeResteAffect(DMPointage2.ListeID_Appelant.Items[i])^.Montant;
              end;
          End;//fin si
      End;//fin si
  end;
End;

procedure TDMPointage2.TaPointageBeforeDelete(DataSet: TDataSet);
Var
InfosCreationReste : TInfosCreationReste;
GestErreur:TErreurTva;
begin
  try
  //regarder si la suppression ne va pas engendrer un problème de TVA
  GestErreur:=dmpieces.piece1.Verification_TvaDeclare_Pointage_new(true,DataSet.findfield('ID_Debit').AsInteger,DataSet.findfield('ID_Credit').AsInteger);
  if not GestErreur.Retour then
    Begin//si problème tva rencontré
       if not gesterreur.Continuer then
         Begin//si on ne peut pas supprimer l'od de déclaration
           showmessage(gesterreur.Messages);
           abort;
         End//fin si on ne peut pas supprimer l'od de déclaration
       else
         Begin//si
           if GestErreur.SupprODDecl then
             begin
             if application.MessageBox(Pchar(gesterreur.messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
               Begin//si
               if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                 abort;
               End//fin si
             else
               abort;
             end
           else
             begin
               showmessage('Ce pointage entre dans une période de tva déclarée non modifiable, vous ne pouvez donc pas le modifiez ou le supprimer');
               abort;
             end;
         End;//fin si
    End;//fin si problème tva rencontré
//  // Montant du pointage en cours
//  InfosCreationReste.Pointage.MontantPointage:=DataSet.findfield('Montant').AsCurrency;
//  InfosCreationReste.IDEcriture:=DataSet.findfield('ID_Debit').AsInteger;
//  GestionDuReste(InfosCreationReste,true);
//  InfosCreationReste.IDEcriture:=DataSet.findfield('ID_Credit').AsInteger;
//  GestionDuReste(InfosCreationReste,true);

  except
    if not ((e.TypeClient=cl_isa) or (((ParamUtil.maintenance)and(ParamUtil.TypeMaintenanceSpeciale='Pointage')))) then
      abort;
  end;
end;


procedure TDMPointage2.TaPointageBeforePost(DataSet: TDataSet);
Var
//InfosCreationReste : TInfosCreationReste;
GestErreur:TErreurTva;
Tiers1,Tiers2,compte1,compte2:string;
Exception:TExceptLGR;
begin
Initialise_ExceptLGR(Exception);
  try
  //regarder si la suppression ne va pas engendrer un problème de TVA
  GestErreur:=dmpieces.piece1.Verification_TvaDeclare_Pointage_new(false,DataSet.findfield('ID_Debit').AsInteger,DataSet.findfield('ID_Credit').AsInteger);
  if not GestErreur.Retour then
    Begin//si problème tva rencontré
       if not gesterreur.Continuer then
         Begin//si on ne peut pas supprimer l'od de déclaration
           showmessage(gesterreur.Messages);
           abort;
         End//fin si on ne peut pas supprimer l'od de déclaration
       else
         Begin//si
           if GestErreur.SupprODDecl then
             begin
             if application.MessageBox(Pchar(gesterreur.messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
               Begin//si
               if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                 abort;
               End//fin si
             else
               abort;
             end
           else
             if application.MessageBox(Pchar(gesterreur.messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrno then
               abort;
         End;//fin si
    End;//fin si problème tva rencontré
Tiers1:='';
compte1:='';
QuControleTiers.close;
QuControleTiers.SQL.Clear;
QuControleTiers.SQL.add('select Tiers,compte from ecriture where id=:idpointage');
QuControleTiers.ParamByName('idPointage').asinteger:=DataSet.findfield('id_debit').asinteger;
QuControleTiers.open;
if QuControleTiers.recordcount<>0 then
  Begin
    Tiers1:=QuControleTiers.findfield('Tiers').asstring;
    compte1:=QuControleTiers.findfield('compte').asstring;
  end;

Tiers2:='';
compte2:='';
QuControleTiers.close;
QuControleTiers.SQL.Clear;
QuControleTiers.SQL.add('select Tiers,compte from ecriture where id=:idpointage');
QuControleTiers.ParamByName('idPointage').asinteger:=DataSet.findfield('id_Credit').asinteger;
QuControleTiers.open;
if QuControleTiers.recordcount<>0 then
  Begin
    Tiers2:=QuControleTiers.findfield('Tiers').asstring;
    compte2:=QuControleTiers.findfield('compte').asstring;
  end;
if ((Tiers1<>Tiers2)or(Compte1<>Compte2)) then
    raise ExceptLGR.Create('Pointage incohérent, il y a une différence entre les tiers. Contactez le service maintenance',1000,true,mtError,Exception);
  // Montant du pointage en cours
//  InfosCreationReste.Pointage.MontantPointage:=DataSet.findfield('Montant').AsCurrency;
//  InfosCreationReste.IDEcriture:=DataSet.findfield('ID_Debit').AsInteger;
//  GestionDuReste(InfosCreationReste,true);
//  InfosCreationReste.IDEcriture:=DataSet.findfield('ID_Credit').AsInteger;
//  GestionDuReste(InfosCreationReste,true);
  except
    abort;
  end;
end;

function TDMPointage2.RecupListeLettreExclu_SurJournal(JournalExclu:array of string;lettreLike:string):Tstringlist;
var
i:integer;
Begin
try
result:=TStringList.Create;
  for i:=0 to high(JournalExclu) do
    Begin//debut boucle for
    //récupérer tous les codes journaux en fontion du n° du journal
    if not empty(JournalExclu[i])then
      Begin//si tableau rempli
        FiltrageDataSet(dmrech.TaModelRech,'ID_Journal = '+JournalExclu[i]);
        dmrech.TaModelRech.First;
        while not (dmrech.TaModelRech.eof)do
          begin
            if result.IndexOf(copy(dmrech.TaModelRech.findfield('Journal').asstring,1,2)+lettreLike)=-1 then
              result.Add(copy(dmrech.TaModelRech.findfield('Journal').asstring,1,2)+lettreLike);
            dmrech.TaModelRech.next;
          end;
        DeFiltrageDataSet(dmrech.TaModelRech);
      End;//fin si tableau rempli
    End;//fin debut boucle for
except
  result:=nil;
end;
End;


procedure TDMPointage2.TaAffectReglementBeforePost_PourAffectReglement(DataSet: TDataSet);
var
RetourCtrlPointage:TErreurSaisie;
i,j:integer;
rang:integer;
ResultStrList:TResultStrList;
begin
with DMPointage2 do
  Begin//déhut du with
    RetourCtrlPointage:=CtrlSaisiePointage_PourAffectReglement(Dataset.Fields[12]);
    if not RetourCtrlPointage.retour then
      case RetourCtrlPointage.CodeErreur of
        1201:abort;
        1202:abort;
      end;
    if DMPointage2.ListeID_Appelant<>nil then
      Begin//si
       ForceLettrage:='';
       rang:=ListResteAffect_IndexOf([inttostr(IDEcritureAppelanteLoc)],[1],DMPointage2.ListeID_Appelant);
       if rang<>-1 then
         ForceLettrage:=PListeResteAffect(DMPointage2.ListeID_Appelant.Items[rang])^.Lettre
       else //sinon récupérer la liste des lettres déjà utilisé pour changer de lettre
         Begin//si
           ResultStrList:=RecupListeLettre_surDataset(DMPointage2.TaResteDC,true);
           j:=65;
           while empty(ForceLettrage) do
             Begin//si
               ForceLettrage:=chr(j);
               if ResultStrList.Liste.IndexOf(ForceLettrage)<>-1 then
                 ForceLettrage:='';
               inc(j);
             End;//fin si
         End;//fin si
      if not empty(ForceLettrage)then
        LettrageEnCours:=ForceLettrage;
      End;//fin si

    if ((DMPointage2.ForceLettrage=DMPointage2.LettrageEnCours) and not empty(DMPointage2.ForceLettrage)) then
     begin
      if DataSet.State = dsEdit then
           Dataset.FindField('Lettre').AsString := DMPointage2.ForceLettrage;
     end;

//    RetourCtrlPointage:=CtrlSaisiePointage_PourAffectReglement(Dataset.Fields[12]);
//    if not RetourCtrlPointage.retour then
//      case RetourCtrlPointage.CodeErreur of
//        1201:abort;
//        1202:abort;
//      end;

if DMPointage2.ListeID_Appelant<>nil then
  Begin//si liste appelant existe
    rang:=ListResteAffect_IndexOf([inttostr(dmpointage2.IDEcritureAppelanteloc),Dataset.FindField('ID').Asstring],[1,2],DMPointage2.ListeID_Appelant);
    if rang<>-1 then
      Begin//si
         if DataSet.FindField('Montant').AsCurrency>0 then
           PListeResteAffect(dmpointage2.ListeID_Appelant.Items[rang])^.Montant:=DataSet.FindField('Montant').AsCurrency
         else
           DMPointage2.ListeID_Appelant.Delete(rang);
      End//fin si
    else
      Begin//si
        //récupérer la lettre utilisée pour cet id Appelant
         if DataSet.FindField('Montant').AsCurrency>0 then
           ListResteAffect__Add_Insert(DMPointage2.ListeID_Appelant,[IDEcritureAppelanteLoc,Dataset.FindField('ID').AsString,Dataset.FindField('Lettre').asstring,Dataset.FindField('Montant').AsCurrency,false],true,false,-1);
      End;//fin si
  End;//fin si liste appelant existe
//   TaAffectReglementCalcFields(dataset);
  End;//fin du with
end;


Function TDMPointage2.CtrlSaisiePointage_PourAffectReglement(CCourant:TField):TErreurSaisie;
Var
OldValue:currency;
rang:integer;
reste:currency;
Begin
result.retour:=true;
result.CodeErreur:=0;
reste:=0;
  case CCourant.DataSet.State of
     dsEdit:Begin
               case CCourant.Index of
                   // Montant
                  12:Begin
                      if VerifFNumeric(CCourant).VideOUZero then
                        begin//si montant vide, on enlève la lettre
                          CCourant.DataSet.FindField('Lettre').AsString:='';
                        end//fin si montant vide, on enlève la lettre
                      else
                        begin//si montant rempli
                          rang:=-1;
                          //caculer le total imputé pour cet id reste
                          if ListeID_Appelant<>nil then
                            Begin//si
                              if ListeID_Appelant.count<>0 then
                               rang:=ListResteAffect_IndexOf([CCourant.DataSet.Fields[0].asstring],[2],DMPointage2.ListeID_Appelant);
                               if rang<>-1 then
                                 Begin//si
                                    reste:=TaAffectReglementResteAffich.AsCurrency+TotalImputation_IDReste(CCourant.DataSet.Fields[0].asinteger,CCourant.DataSet.Fields[1].asinteger);
                                 End//fin si
                               else
                                 reste:=TaAffectReglementResteAffich.AsCurrency + TaAffectReglementMontant.AsCurrency;
                            End//fin si
                          Else
                            reste:=TaAffectReglementResteAffich.AsCurrency + TaAffectReglementMontant.AsCurrency;
                           if CCourant.AsCurrency > reste then
                               begin// on regarde s'il n'est pas supérieur à son reste à pointer
                                 result.retour:=false;
                                 result.CodeErreur:=1201;
                                 showmessage('Le montant imputé doit être inférieur ou égal au reste à pointer de cette écriture !');
                               end;//fin on regarde s'il n'est pas supérieur à son reste à pointer
                        if result.retour then
                          Begin//si retour ok
                            if DMPointage2.MontantTmp>0 then
                              Begin//si montant déjà renseigné
                                if ((CCourant.AsCurrency >(AffectReglement.MontantARegler+(-ResteDCInfoLettrageEnCours.SoldeTotalImputation+DMPointage2.MontantTmp)))) then
                                   begin// on regarde s'il n'est pas supérieur au reste à pointer de la ligne appelante
                                     result.retour:=false;
                                     result.CodeErreur:=1202;
                                     showmessage('Le montant imputé doit être inférieur ou égal au reste à pointer du réglement !');
                                   end;//fin on regarde s'il n'est pas supérieur au reste à pointer de la ligne appelante
                              End//fin si montant déjà renseigné
                            else
                              Begin//si
                                if ((CCourant.AsCurrency >(AffectReglement.MontantARegler+(-ResteDCInfoLettrageEnCours.SoldeTotalImputation+DMPointage2.MontantTmp)))) then
                                   begin// on regarde s'il n'est pas supérieur au reste à pointer de la ligne appelante
                                     result.retour:=false;
                                     result.CodeErreur:=1202;
                                     showmessage('Le montant imputé doit être inférieur ou égal au reste à pointer du réglement !');
                                   end;//fin on regarde s'il n'est pas supérieur au reste à pointer de la ligne appelante
                              End;//fin si
                          End;//fin si retour ok

                        end;//fin si montant rempli
                    if result.retour then
                      begin//si result.retour=true
                       if empty(DMPointage2.LettrageEnCours) then
                         DMPointage2.LettrageEnCours:='A'
                       else
                         begin//si lettrage en cours rempli
                         CCourant.DataSet.FindField('Lettre').AsString:=DMPointage2.LettrageEnCours;
                         if VerifFNumeric(CCourant.DataSet.FindField('Montant')).VideOUZero then
                            Begin//si Montant vide, on affecte un montant par défaut
//                              if CCourant.DataSet.FindField('Reste').AsCurrency<(AffectReglement.MontantARegler+(-ResteDCInfoLettrageEnCours.SoldeTotalImputation+DMPointage2.MontantTmp)) then
//                                CCourant.AsCurrency:=CCourant.DataSet.FindField('Reste').AsCurrency
//                              else
//                                CCourant.AsCurrency:=(AffectReglement.MontantARegler+(-ResteDCInfoLettrageEnCours.SoldeTotalImputation+DMPointage2.MontantTmp));
                              if CCourant.DataSet.FindField('ResteAffich').AsCurrency<(AffectReglement.MontantARegler+(-ResteDCInfoLettrageEnCours.SoldeTotalImputation+DMPointage2.MontantTmp)) then
                                CCourant.AsCurrency:=CCourant.DataSet.FindField('ResteAffich').AsCurrency
                              else
                                CCourant.AsCurrency:=(AffectReglement.MontantARegler+(-ResteDCInfoLettrageEnCours.SoldeTotalImputation+DMPointage2.MontantTmp));
                            End;//fin si si Montant vide, on affecte un montant par défaut
                         end;//fin si lettrage en cours rempli
                       end;//fin si result.retour=true
                     End;//fin si colonne Montant
               end;//fin du case colonne
            End;//fin si modification
  end;//fin case etat dataset
End;


procedure TDMPointage2.TaCompteFilterRecordComptePointable(DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
  if DataSet.Name <> 'quLibelle' then
   begin
     try
       accept:=((DataSet.findField('Pointable').AsBoolean) and not (DataSet.findField('collectif').asboolean) and ((length(DataSet.FindField('Compte').AsString) > 2)));
     except
       accept:=false;
     end;
   end;
  end;
end;


procedure TDMPointage2.TaAffectReglementAfterPost_PourAffectReglement(DataSet: TDataSet);
begin
//  DMPointage2.TaAffectReglement.Close;
//  DMPointage2.TaAffectReglement.OnCalcFields:=DMPointage2.TaAffectReglementCalcFields;
//  DMPointage2.TaAffectReglement.open;
//  DMPointage2.TaAffectReglement.OnCalcFields:=nil;
end;

Procedure TDMPointage2.FiltreDettesEtCreancesSurJournal(var Dataset:TDataset;ListeExclue:array of string;SensReglement:integer;Tiers_:string;MontantARegler:currency);
var
Sens:string;
begin
case sensreglement of
0:Sens:='';
1:Sens:='D';
-1:Sens:='C';
end;//fin du case sensreglement
//CloneDataSet(TTable(RecupDetteCreance(Tiers_,sens,ListeExclue,0,0,0,0,nil,true).DataSetResult),Dataset).Free;
RecupDetteCreance('',Tiers_,sens,ListeExclue,0,0,0,0,nil,false,dataset);
//RecupDetteCreance(Tiers_,sens,ListeExclue,0,0,0,0,nil,true);
DMPointage2.TaAffectReglement.OnFilterRecord:=nil;
GrDbGridInitColonne(AffectReglement.GrDBAffectReg,DMPointage2.DaAffectReglement,DMPointage2.TaAffectReglement,
                  ['Référence','Libellé','Date','Debit','Credit','Non Pointé','Imputation'],
                  ['Reference','Libelle','Date','Debit','Credit','ResteAffich','Montant']
                  ,E.FormatMonnaie,E.EditFormat);
DMPointage2.TaAffectReglement.Locate('Reste',MontantARegler,[loPartialKey]);

end;


function CreationPointageSurIDEcriture(InfosPointage:Tinfos_Pointage;TiersTmp:string;GererReste:boolean):TExceptLGR_ImportPiece;overload;
var
i,j:integer;
IDDebit,IDCredit:integer;
TvaDate:TdateTime;
tab:variant;
InfosCreationReste:TInfosCreationReste;
montantPointage:currency;
begin
montantPointage:=0;
result.Id_Piece:=-1;
   try
      try
        with DMPointage2 do
         begin
         if not  TaPointage.active then
           TaPointage.open;
         if not tareste.active then
           tareste.open;
//             IDDebit:=TabID[0];
//             IDCredit:=TabID[1];
//             montantPointage:=TabID[3];
             TaPointage.Filtered:=false;
             TaPointage.filter:='';
             TaPointage.filter:=('ID_Debit= '''+inttostr(InfosPointage.ID_Debit)+'''and ID_Credit= ''' +inttostr(InfosPointage.ID_Credit)+'''');
             TaPointage.Filtered:=true;
             if TaPointage.RecordCount<>0 then
                Begin
                 TaPointage.Edit;
                 TaPointage.FindField('Montant').AsCurrency:=TaPointage.FindField('Montant').AsCurrency+InfosPointage.montantPointage ;
                 TableGerePost(TaPointage);
                 TaPointage.Filtered:=false;
                 TaPointage.filter:='';
                 TaPointage.Filtered:=true;
                End
             else
                TaPointage.AppendRecord([MaxId_Query(TaPointage,'ID'),InfosPointage.ID_Debit,InfosPointage.ID_Credit,InfosPointage.DateMaitre,
                InfosPointage.montantPointage,InfosPointage.DateMaitre,null,'',now]);
             TaPointage.FlushBuffers;
             if GererReste then
               begin//si gestion du reste
                     // gestion du reste Maître
                     initialise_InfosCreationReste(InfosCreationReste);
                     InfosCreationReste.Pointage.MontantPointage:=InfosPointage.montantPointage;
                     InfosCreationReste.Tiers:=Tierstmp;
                     InfosCreationReste.IDEcriture:=InfosPointage.ID_Debit;
                     //rechercher la pièce concernant l'écriture en cours pour récupérer la référence
                     //l'IDPiece et le libelle de la pièce
                     InfosCreationReste.IDPiece:=StrToInt_Lgr(RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDEcriture),DMEcritures.TaEcriture,'ID',['ID_Piece'],tab));
                     //récupérer la référence de la pièce
                     if InfosCreationReste.IDPiece<>0 then
                       begin
                         RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDPiece),DMpieces.TaPiece,'ID',['Reference','Libelle','Date'],tab);
                         InfosCreationReste.Reference:=tab[0];
                         InfosCreationReste.Libelle:=tab[1];
                         InfosCreationReste.DatePiece:=StrToDate_Lgr(tab[2]);
                         InfosCreationReste.Tiers:=InfosCreationReste.Tiers;
                         InfosCreationReste.IDEcriture:=InfosCreationReste.IDEcriture;
                         RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDEcriture),DMEcritures.TaEcriture,'ID',['DebitSaisie','CreditSaisie'],tab);
                         InfosCreationReste.MontantDebit:=StrToCurr_lgr(tab[0]);
                         InfosCreationReste.MontantCredit:=StrToCurr_lgr(tab[1]);
                       end
                     else
                        abort;
                     if InfosCreationReste.MontantDebit<>0 then
                       begin
                         InfosCreationReste.Reste.Reste:=InfosCreationReste.MontantDebit-InfosCreationReste.Pointage.MontantPointage;
                         InfosCreationReste.Reste.SensReste:=false;
                       end
                     else
                       begin
                         InfosCreationReste.Reste.Reste:=InfosCreationReste.MontantCredit-InfosCreationReste.Pointage.MontantPointage;;
                         InfosCreationReste.Reste.SensReste:=true;
                       end;

                     GestionDuReste(InfosCreationReste,false);
                     //fin gestion du reste Maître
                     //fin gestion du reste Esclave
                     initialise_InfosCreationReste(InfosCreationReste);
                     InfosCreationReste.Pointage.MontantPointage:=InfosPointage.montantPointage;
                     InfosCreationReste.Tiers:=Tierstmp;
                     InfosCreationReste.IDEcriture:=InfosPointage.ID_Credit;
                     //rechercher la pièce concernant l'écriture en cours pour récupérer la référence
                     //l'IDPiece et le libelle de la pièce
                     InfosCreationReste.IDPiece:=StrToInt_Lgr(RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDEcriture),DMEcritures.TaEcriture,'ID',['ID_Piece'],tab));
                     //récupérer la référence de la pièce
                     if InfosCreationReste.IDPiece<>0 then
                       begin
                         RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDPiece),DMpieces.TaPiece,'ID',['Reference','Libelle','Date'],tab);
                         InfosCreationReste.Reference:=tab[0];
                         InfosCreationReste.Libelle:=tab[1];
                         InfosCreationReste.DatePiece:=StrToDate_Lgr(tab[2]);
                         InfosCreationReste.Tiers:=InfosCreationReste.Tiers;
                         InfosCreationReste.IDEcriture:=InfosCreationReste.IDEcriture;
                         RenvoieInfoSurTableDiverse(inttostr(InfosCreationReste.IDEcriture),DMEcritures.TaEcriture,'ID',['DebitSaisie','CreditSaisie'],tab);
                         InfosCreationReste.MontantDebit:=StrToCurr_lgr(tab[0]);
                         InfosCreationReste.MontantCredit:=StrToCurr_lgr(tab[1]);
                       end
                     else
                        abort;
                     if InfosCreationReste.MontantDebit<>0 then
                       begin
                         InfosCreationReste.Reste.Reste:=InfosCreationReste.MontantDebit-InfosCreationReste.Pointage.MontantPointage;
                         InfosCreationReste.Reste.SensReste:=false;
                       end
                     else
                       begin
                         InfosCreationReste.Reste.Reste:=InfosCreationReste.MontantCredit-InfosCreationReste.Pointage.MontantPointage;;
                         InfosCreationReste.Reste.SensReste:=true;
                       end;

                     GestionDuReste(InfosCreationReste,false);
                   //fin gestion du reste Esclave
               end;//fin si gestion du reste
             result.Id_Piece:=MaxId_Query(TaPointage,'ID')-1;
         end;//fin du with DMPointage2
      except
      //showmessage('Problème à la création des pointages !!');
      TableGereRollBack(DMPointage2.TaPointage);
      TableGereRollBack(DMBalance.TaBalance);
      result.Id_Piece:=-1;
      abort;
      end;//fin du try
   finally
   DMPointage2.tareste.close;
   end;//fin du try finally
End;

procedure TDMPointage2.TaVisuResteDCFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if e.ExerciceBase>E.ExerciceSaisie then
  accept:=(TaVisuResteDC.FindField('Date').asDatetime)<e.DatExoDebut
else
  accept:=((TaVisuResteDC.FindField('Date').asDatetime >=e.DatExoDebut) and (TaVisuResteDC.FindField('Date').asDatetime <=e.DatExoFin));

//  accept:=(TaVisuResteDC.FindField('id_ecriture').asinteger div 10000000)<=strtoint_lgr(e.ExerciceSaisie)
//else
//  accept:=(TaVisuResteDC.FindField('id_ecriture').asinteger div 10000000)>=strtoint_lgr(e.ExerciceBase);
end;

procedure TDMPointage2.TaResteDCReglementBeforeOpen(DataSet: TDataSet);
begin
TaPieceRecherche.Close;
TaPieceRecherche.Open;

TaInfoPointageCredit.Close;
TaInfoPointageCredit.Open;

TaInfoPointageDebit.Close;
TaInfoPointageDebit.Open;
end;

procedure TDMPointage2.QuDettesCreance_EditionFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
      if ((ListeDettesAffich<>nil)and(ListeDettesAffich.count<>0)) then
        accept:=ListeDettesAffich.IndexOf(dataset.findfield('journal').asstring)=-1;
      if ((accept)and (not empty (TypeDettes))) then
        accept:=dataset.findfield('Sens').asstring=DMPointage2.TypeDettes;
  end;
end;

procedure TDMPointage2.QuDettesCreance_EditionFilterRecord2(
  DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
      if(dataset.findfield('tiers').asstring<>'')then
        begin
            if ((ListeTiersAffich<>nil)and(ListeTiersAffich.count<>0)) then
              accept:=ListeTiersAffich.IndexOf(dataset.findfield('tiers').asstring)<>-1;
        end
      else
      if(dataset.findfield('compte').asstring<>'')then
        begin
            if ((ListecompteAffich<>nil)and(ListecompteAffich.count<>0)) then
              accept:=ListecompteAffich.IndexOf(dataset.findfield('compte').asstring)<>-1;
        end;
      if ((accept)and (not empty (TypeDettes))) then
        accept:=dataset.findfield('Sens').asstring=DMPointage2.TypeDettes;
  end;
end;

procedure TDMPointage2.TaResteUpdateLettrageFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
if ListeEcritureFilterRecord<>nil then
  accept:=ListeEcritureFilterRecord.IndexOf(dataset.findfield('id_ecriture').asstring)=-1;
end;
end;

procedure initialise_TInfosPointage(var infosPointage:Pinfos_Pointage);
begin
  infosPointage.ID_Debit:=0;
  infosPointage.ID_Credit:=0;
  infosPointage.DateMaitre:=0;
  infosPointage.DateEsclave:=0;
  infosPointage.MontantDebit:=0;
  infosPointage.MontantCredit:=0;
  infosPointage.MontantPointage:=0;
  infosPointage.Tiers:='';
  infosPointage.RefDebit:='';
  infosPointage.RefCredit:='';
  infosPointage.idPieceDebit:=0;
  infosPointage.idPieceCredit:=0;
end;



function listeDettesEtCreancesSurPeriode(DemandePeriode:Boolean; CompteDeTiers:TStringList;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string;ordre:integer; Regrouper : integer):Tstringlist;
var
periode:TPeriode;
i:integer;
CreanceEcheance,DetteEcheance,SoldeEcheance:Currency;
MontantTotal,DEjaRegle,Creance,Dette,Solde:Currency;
Reste,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
TotalMouvementDetteCollectifEcheance,TotalMouvementCreanceCollectifEcheance:Currency;
DettesEtCreances:TDettesEtCreances;
ParamAffichPeriode:TParamAffichPeriode;
LibelleCorrect:string;
//Requete:TQuery;
CompteDeTiersTmp,NomTiers,CompteRegroupe:string;
compteRempli,compteCollectifRempli:boolean;
datePiece:TDate;
listeParCompte,listeParDate:TStringList;
begin

//TypeDettes='' -> Dettes et Créances
//TypeDettes='C' -> Dettes
//TypeDettes='D' -> Créances
//ListeExclu = liste des journaux exclu

try//finally
PatienterAffich();
listeParCompte:=TStringList.create;
listeParDate:=TStringList.create;
result:=TStringList.create;
Initialise_ParamAffichPeriode(ParamAffichPeriode);

//Requete:=TQuery.Create(application.MainForm);
DMPointage2.Requete.SQL.Clear;

//
DMPointage2.Requete.SQL.Add(' select min(ResteDC."Date") as DateDeb');
DMPointage2.Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd where reste<>0 ');
if (not precision) then
  begin
      //if not relance then
        showmessage('Attention !!!, cette édition tient compte des réglements de l''exercice N+1');
      DemandePeriode:=false;
  end
else
  begin
      DMPointage2.Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" > :DateFin)))');
      DMPointage2.Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" > :DateFin))))');
      DMPointage2.Requete.ParamByName('DateFin').AsDate := e.DatExoFin;
  end;

DMPointage2.Requete.open;
if ((DMPointage2.Requete.recordcount<>0)and(not empty(DMPointage2.Requete.findfield('DateDeb').Asstring)))then
  periode.DateDeb:=DMPointage2.Requete.findfield('DateDeb').AsDateTime
else
  periode.DateDeb:=e.DatExoDebut;

DMPointage2.Requete.Close;

  if DemandePeriode then
    Begin
       periode:=ChoixPeriodeAffich(periode.DateDeb,E.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeDebit_Edition2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeCredit_Edition2);
    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Close;
    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.ParamByName('FinPeriode').AsDate:=periode.DateFin;
    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Open;

    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Close;
    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.ParamByName('FinPeriode').AsDate:=periode.DateFin;
    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Open;

    if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);

DMPointage2.TypeDettes:=TypeDettes;
if ListeExclu=nil then
  Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false)
else
  if DMPointage2.ListeDettesAffich.ClassInfo<>ListeExclu.ClassInfo then
  begin
    Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false);
    for i:=0 to ListeExclu.count-1 do
      DMPointage2.ListeDettesAffich.Add(ListeExclu.strings[i]);
  end;

    if CompteDeTiers=nil then
     // Tous les Comptes de Tiers
     begin
      DMPointage2.QuDettesCreance_Edition.Close;
      DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
      DMPointage2.QuDettesCreance_Edition.filtered:=true;
      DMPointage2.QuDettesCreance_Edition.sql.Clear;
      DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,P.compte,R.Tiers,T.Nom,R.Sens');
      DMPointage2.QuDettesCreance_Edition.sql.Add('from ResteDC R');
      DMPointage2.QuDettesCreance_Edition.sql.Add('left join tiers T on (r.tiers=T.tiers)');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
      DMPointage2.QuDettesCreance_Edition.sql.Add('where  P.Echeance between :DateDeb and  :DateFin');
      if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and R.reste<>0');
        DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,R.tiers,P.Echeance');

      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Prepare;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;
      CompteDeTiers:=Tstringlist.Create;
      CompteDeTiers.Sorted:=True;
      CompteDeTiers.Duplicates:=dupIgnore;
      while not DMPointage2.QuDettesCreance_Edition.Eof do
        Begin
          if (empty(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString)) and (str_commence_par(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString,'+')=false)then
            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString)
          else
            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString);
          DMPointage2.QuDettesCreance_Edition.Next;
        end;
      end;

    if (CompteDeTiers<>nil)and (CompteDeTiers.count>0) then //
     begin
//      DMPointage2.QuDettesCreance_Edition.close;
//      DMPointage2.QuDettesCreance_Edition.sql.Clear;
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,P.compte,R.Tiers,Reference,R."Date" as datePiece,P.Echeance,debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' where (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and R."Date" between :DateDeb and  :DateFin');
//      if(ordre=1)then
//        DMPointage2.QuDettesCreance_Edition.sql.Add(' order by P.compte,tiers,R."Date",Reference')
//      else DMPointage2.QuDettesCreance_Edition.sql.Add(' order by R."Date"');

      DMPointage2.QuDettesCreance_Edition.close;
      DMPointage2.QuDettesCreance_Edition.sql.Clear;
      DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,P.compte,R.Tiers,Reference,R."Date"as datePiece,P.Echeance,debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');      // (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and
      DMPointage2.QuDettesCreance_Edition.sql.Add(' where  P.Echeance between :DateDeb and  :DateFin');
      if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
      DMPointage2.QuDettesCreance_Edition.sql.Add(' order by P.compte,R.tiers,P.Echeance,Reference');
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
      DMPointage2.QuDettesCreance_Edition.Open;
      DMPointage2.QuDettesCreance_Edition.First;


compteCollectifRempli:=false;
      if CompteDeTiers.count<>0 then
        begin//si il y a des dettes ou creances dans période
           for i:=0 to CompteDeTiers.count-1 do
             begin
                Solde :=0;
                CompteRegroupe:=copy(GetStringElement(CompteDeTiers.strings[i],1,';'),1,Regrouper);

                CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],2,';');
                if str_commence_par(CompteDeTiersTmp,'+')then
                  begin
                    NomTiers:=GetStringElement(CompteDeTiers.strings[i],3,';');
                    filtre:=' Tiers = '''+CompteDeTiersTmp+'''';
                    FiltrageDataSet(DMPointage2.QuDettesCreance_Edition,filtre);
                  end
                else
                  begin
                    NomTiers:=dmplan.LibelleDuNumCptPCU(CompteDeTiersTmp);
                    filtre:='Tiers = '''+GetStringElement(CompteDeTiers.strings[i],1,';')+'''';
                    FiltrageDataSet(DMPointage2.QuDettesCreance_Edition,filtre);
                  end;
//                DMPointage2.QuDettesCreance_Edition.Close;
//                DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := GetStringElement(CompteDeTiers.strings[i],1,';');
//                DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
//                DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//                DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//                DMPointage2.QuDettesCreance_Edition.Open;
//                DMPointage2.QuDettesCreance_Edition.First;
                if DMPointage2.QuDettesCreance_Edition.recordcount=0 then
                  CompteDeTiersTmp:='';
                compteRempli:=false;
                while not DMPointage2.QuDettesCreance_Edition.Eof do
                  begin
                   if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
                    else
                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;

                    datePiece:= DMPointage2.QuDettesCreance_Edition.FindField('Echeance').AsDateTime;
                    // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
                    // les dates de pièce sont antérieures à la date de fin de période
                    // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                      if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                       Begin
                         DejaRegle:=0;
                         if  DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Locate('id_credit',IntToStr(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger),[]) then
                           DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.findfield('MontantPointeCredit').AsCurrency;
                         Dette:=MontantTotal - DejaRegle;
                         TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
                         Creance :=0;
                       end
                      else
                        begin
                        DejaRegle:=0;
                         if  DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Locate('id_debit',IntToStr(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger),[]) then
                            DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.findfield('MontantPointeDebit').AsCurrency;
                          Creance:=MontantTotal - DejaRegle;
                          TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
                          Dette:=0;
                        end;

                    if(DMPointage2.QuDettesCreance_Edition.FindField('Echeance').AsDateTime<=periode.DateFin)then
                        begin
                         // MontantTotalEcheance:=MontantTotal;
                          if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                           Begin
                             DetteEcheance:=MontantTotal - DejaRegle;
                             TotalMouvementDetteCollectifEcheance:=DetteEcheance+TotalMouvementDetteCollectifEcheance;
                             CreanceEcheance :=0;
                           end
                          else
                            begin
                              CreanceEcheance:=MontantTotal - DejaRegle;
                              TotalMouvementCreanceCollectifEcheance:=CreanceEcheance+TotalMouvementCreanceCollectifEcheance;
                              DetteEcheance:=0;
                            end;
                          SoldeEcheance := CreanceEcheance - DetteEcheance + SoldeEcheance;
                        end;
//                    if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
//                     Begin
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
//                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition.findfield('MontantPointeCredit').AsCurrency;
//                       Dette:=MontantTotal - DejaRegle;
//                       TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
//
//                       Creance :=0;
//                     end
//                    else
//                      begin
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
//                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition.findfield('MontantPointeDebit').AsCurrency;
//                        Creance:=MontantTotal - DejaRegle;
//                        TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
//                        Dette:=0;
//                      end;

                   Solde := Creance - Dette + Solde;
                   if DejaRegle <> MontantTotal then
                   begin //si solde <> 0 on rempli dans la liste
                     if compteRempli=false then
                       begin
                          compteRempli:=true;
                          compteCollectifRempli:=true;
                       end;
                   end;//si solde <>0
                    DettesEtCreances:=TDettesEtCreances.Create;
                    DettesEtCreances.compte:=CompteRegroupe;
                    DettesEtCreances.date:=datePiece;
                    DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
                    DettesEtCreances.Creances:=Creance;
                    DettesEtCreances.Dettes:=Dette;
                    DettesEtCreances.CreancesEcheance:=CreanceEcheance;
                    DettesEtCreances.DettesEcheance:=DetteEcheance;
                    listeParDate.AddObject(DateToStr(DatePiece),DettesEtCreances);
                   DMPointage2.QuDettesCreance_Edition.Next;
                  end;
                if (i<CompteDeTiers.count-1)and (compteCollectifRempli) and(CompteRegroupe<>Copy(GetStringElement(CompteDeTiers.strings[i+1],1,';'),1,Regrouper))then
                    begin//changement de compte collectif, donc totaux
                      //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
                      //ListeValeur.Add('1;;;Collectif : '+CompteTmp+' ;;;@SOLDE ;'+e.FormatCurrSansDevise(TotalMouvementCreanceCollectif) +';'+e.FormatCurrSansDevise(TotalMouvementDetteCollectif)+'; ');
                      DettesEtCreances:=TDettesEtCreances.Create;
                      DettesEtCreances.compte:=CompteRegroupe;
                      DettesEtCreances.date:=datePiece;
                      DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
                      DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
                      DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
                      DettesEtCreances.CreancesEcheance:=TotalMouvementCreanceCollectifEcheance;
                      DettesEtCreances.DettesEcheance:=TotalMouvementDetteCollectifEcheance;
                      listeParCompte.AddObject(CompteRegroupe,DettesEtCreances);
                      TotalMouvementDetteCollectif:=0;
                      TotalMouvementCreanceCollectif:=0;
                      TotalMouvementDetteCollectifEcheance:=0;
                      TotalMouvementCreanceCollectifEcheance:=0;
                      compteCollectifRempli:=false;

                    end;
             end;//fin parcours liste des comptes
            if (CompteRegroupe<>'')and (compteCollectifRempli)then
              begin
              //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
              DettesEtCreances:=TDettesEtCreances.Create;
              DettesEtCreances.compte:=CompteRegroupe;
              DettesEtCreances.date:=datePiece;
              DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
              DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
              DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
              DettesEtCreances.CreancesEcheance:=TotalMouvementCreanceCollectifEcheance;
              DettesEtCreances.DettesEcheance:=TotalMouvementDetteCollectifEcheance;
              listeParCompte.AddObject(CompteRegroupe,DettesEtCreances);
              TotalMouvementDetteCollectifEcheance:=0;
              TotalMouvementCreanceCollectifEcheance:=0;
              TotalMouvementDetteCollectif:=0;
              TotalMouvementCreanceCollectif:=0;
              end;

       end;//fin si il y a des dettes ou creances dans période
   end;
   end;
finally
PatienterFermer();
result.AddObject('Compte',listeParCompte);
result.AddObject('date',listeParDate);
//Initialise_TStringlist(CompteDeTiers,DMPointage2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeDebit_Edition2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeCredit_Edition2);
DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.close;
DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.close;
DMPointage2.QuDettesCreance_Edition.close;
DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;
DMPointage2.QuDettesCreance_Edition.filtered:=false;

DMPointage2.Requete.close;
//Requete:=nil;
end;


end;

//Function TableauDetteCreance( DemandePeriode:Boolean; CompteDeTiers:TStringList;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string):Tstringlist;
//var
//periode:TPeriode;
//i:integer;
//MontantTotal,DEjaRegle,Creance,Dette,Solde:Currency;
//Reste,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
//DettesEtCreances:TDettesEtCreances;
//ParamAffichPeriode:TParamAffichPeriode;
//LibelleCorrect:string;
//Requete:TQuery;
//CompteDeTiersTmp,CompteTmp,NomTiers:string;
//compteRempli,compteCollectifRempli:boolean;
//begin
//
////TypeDettes='' -> Dettes et Créances
////TypeDettes='C' -> Dettes
////TypeDettes='D' -> Créances
////ListeExclu = liste des journaux exclu
//
//try//finally
//result:=TStringList.create;
//Initialise_ParamAffichPeriode(ParamAffichPeriode);
//
//Requete:=TQuery.Create(application.MainForm);
//Requete.SQL.Clear;
//
////
//Requete.SQL.Add(' select min(ResteDC."Date") as DateDeb');
//Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd where reste<>0 ');
//if (not precision) then
//  begin
//      //if not relance then
//        showmessage('Attention !!!, cette édition tient compte des réglements de l''exercice N+1');
//      DemandePeriode:=false;
//  end
//else
//  begin
//      Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" >:DateFin)))');
//      Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" >:DateFin))))');
//      Requete.ParamByName('DateFin').AsDate := e.DatExoFin;
//  end;
//
//Requete.open;
//if ((requete.recordcount<>0)and(not empty(Requete.findfield('DateDeb').Asstring)))then
//  periode.DateDeb:=Requete.findfield('DateDeb').AsDateTime
//else
//  periode.DateDeb:=e.DatExoDebut;
//
//Requete.Close;
//
//  if DemandePeriode then
//    Begin
//       periode:=ChoixPeriodeAffich(periode.DateDeb,E.DatExoFin,'',ParamAffichPeriode);
//    end
//   else
//    begin
//     periode.Retour := true;
//     periode.DateFin := E.DatExoFin;
//    end;
//  if periode.Retour then
//   begin
//    PatienterAffich();
//
//    if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);
//
//DMPointage2.TypeDettes:=TypeDettes;
//if ListeExclu=nil then
//  Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false)
//else
//  if DMPointage2.ListeDettesAffich.ClassInfo<>ListeExclu.ClassInfo then
//  begin
//    Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false);
//    for i:=0 to ListeExclu.count-1 do
//      DMPointage2.ListeDettesAffich.Add(ListeExclu.strings[i]);
//  end;
//  DMPointage2.QuDettesCreance_Edition.Close;
//  DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
//  DMPointage2.QuDettesCreance_Edition.filtered:=true;
//  DMPointage2.QuDettesCreance_Edition.sql.Clear;
//  DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,R.Tiers,T.Nom,R.Sens');
//  DMPointage2.QuDettesCreance_Edition.sql.Add('from ResteDC R');
//  DMPointage2.QuDettesCreance_Edition.sql.Add('left join tiers T on (r.tiers=T.tiers)');
//  DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
//  DMPointage2.QuDettesCreance_Edition.sql.Add('where  R."Date" between :DateDeb and  :DateFin');
//  if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and R.reste<>0');
//    DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,R.tiers');
//
//
//
//    if CompteDeTiers=nil then
//     // Tous les Comptes de Tiers
//     begin
//      DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//      DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//      DMPointage2.QuDettesCreance_Edition.Prepare;
//      DMPointage2.QuDettesCreance_Edition.Open;
//      DMPointage2.QuDettesCreance_Edition.First;
//      CompteDeTiers:=Tstringlist.Create;
//      CompteDeTiers.Sorted:=True;
//      CompteDeTiers.Duplicates:=dupIgnore;
//      while not DMPointage2.QuDettesCreance_Edition.Eof do
//        Begin
//          if (empty(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString)) and (str_commence_par(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString,'+')=false)then
//            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString)
//          else
//            CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString);
//          DMPointage2.QuDettesCreance_Edition.Next;
//        end;
//      end;
//
//    if (CompteDeTiers<>nil)and (CompteDeTiers.count>0) then //
//     begin
//      DMPointage2.QuDettesCreance_Edition.close;
//      DMPointage2.QuDettesCreance_Edition.sql.Clear;
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' where (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and R."Date" between :DateDeb and  :DateFin');
//      if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
//      DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,R."Date",Reference');
//
//
//compteCollectifRempli:=false;
//      if CompteDeTiers.count<>0 then
//        begin//si il y a des dettes ou creances dans période
//           for i:=0 to CompteDeTiers.count-1 do
//             begin
//                Solde :=0;
//
//                CompteTmp:=GetStringElement(CompteDeTiers.strings[i],1,';');
//                CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],2,';');
//                if str_commence_par(CompteDeTiersTmp,'+')then
//                  begin
//                    NomTiers:=GetStringElement(CompteDeTiers.strings[i],3,';');
//                  end
//                else
//                  begin
//                    NomTiers:=dmplan.LibelleDuNumCptPCU(CompteDeTiersTmp);
//                  end;
//                DMPointage2.QuDettesCreance_Edition.Close;
//                DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := GetStringElement(CompteDeTiers.strings[i],1,';');
//                DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
//                DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//                DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//                DMPointage2.QuDettesCreance_Edition.Open;
//                DMPointage2.QuDettesCreance_Edition.First;
//                if DMPointage2.QuDettesCreance_Edition.recordcount=0 then
//                  CompteDeTiersTmp:='';
//                compteRempli:=false;
//                while not DMPointage2.QuDettesCreance_Edition.Eof do
//                  begin
//                   if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
//                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
//                    else
//                    MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
//                    // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
//                    // les dates de pièce sont antérieures à la date de fin de période
//                    // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//      //              DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;
//
//                    if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
//                     Begin
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                       DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
//                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition.findfield('MontantPointeCredit').AsCurrency;
//                       Dette:=MontantTotal - DejaRegle;
//                       TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
//
//                       Creance :=0;
//                     end
//                    else
//                      begin
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                       DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
//                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition.findfield('MontantPointeDebit').AsCurrency;
//                        Creance:=MontantTotal - DejaRegle;
//                        TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
//                        Dette:=0;
//                      end;
//
//                   Solde := Creance - Dette + Solde;
//                   if DejaRegle <> MontantTotal then
//                   begin //si solde <> 0 on rempli dans la liste
//                     if compteRempli=false then
//                       begin
//                          compteRempli:=true;
//                          compteCollectifRempli:=true;
//                       end;
//
//                   end;//si solde <>0
//                   DMPointage2.QuDettesCreance_Edition.Next;
//                  end;
//                if (i<CompteDeTiers.count-1)and (compteCollectifRempli) and(CompteTmp<>GetStringElement(CompteDeTiers.strings[i+1],1,';'))then
//                    begin//changement de compte collectif, donc totaux
//                      DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
//                      //ListeValeur.Add('1;;;Collectif : '+CompteTmp+' ;;;@SOLDE ;'+e.FormatCurrSansDevise(TotalMouvementCreanceCollectif) +';'+e.FormatCurrSansDevise(TotalMouvementDetteCollectif)+'; ');
//                      DettesEtCreances:=TDettesEtCreances.Create;
//                      DettesEtCreances.compte:=CompteTmp;
//                      DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
//                      DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
//                      DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
//                      result.AddObject(CompteTmp,DettesEtCreances);
//                      TotalMouvementDetteCollectif:=0;
//                      TotalMouvementCreanceCollectif:=0;
//                      compteCollectifRempli:=false;
//
//                    end;
//             end;//fin parcours liste des comptes
//            if (CompteTmp<>'')and (compteCollectifRempli)then
//              begin
//              DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
//              //ListeValeur.Add('1;;;Collectif : '+CompteTmp+' ;;;@SOLDE ;'+CurrToStr(TotalMouvementCreanceCollectif) +';'+CurrToStr(TotalMouvementDetteCollectif)+'; ');
//              DettesEtCreances:=TDettesEtCreances.Create;
//              DettesEtCreances.compte:=CompteTmp;
//              DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
//              DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
//              DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
//              result.AddObject(CompteTmp,DettesEtCreances);
//              TotalMouvementDetteCollectif:=0;
//              TotalMouvementCreanceCollectif:=0;
//              end;
//
//       end;//fin si il y a des dettes ou creances dans période
//   end;
//   end;
//finally
//PatienterFermer();
////Initialise_TStringlist(CompteDeTiers,DMPointage2);
//DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;
//DMPointage2.QuDettesCreance_Edition.filtered:=false;
//DMPointage2.QuDettesCreance_Edition.close;
//LibereObjet(TObject(Requete));
//end;
//End;


Function TableauEvolutionMensuelleDetteCreance(DemandePeriode:Boolean; ListeParDate:Tstringlist):Tstringlist;
var
periode:TPeriode;
i,j:integer;
MontantTotal,DEjaRegle,Creance,Dette,Solde:Currency;
Reste,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
DettesEtCreances:TDettesEtCreances;
ParamAffichPeriode:TParamAffichPeriode;
LibelleCorrect:string;
//Requete:TQuery;
CompteDeTiersTmp,CompteTmp,NomTiers:string;
compteRempli,compteCollectifRempli:boolean;
listeMoisExo:Tstringlist;
Exercice:TExercice;
DateDepart,DateFin,DateTmp:TDate;
fini:boolean;
A,M,D : word;
begin

//TypeDettes='' -> Dettes et Créances
//TypeDettes='C' -> Dettes
//TypeDettes='D' -> Créances
//ListeExclu = liste des journaux exclu

try//finally
PatienterAffich();
result:=TStringList.create;
listeMoisExo:=Tstringlist.create;

Initialise_ParamAffichPeriode(ParamAffichPeriode);

    //Requete:=TQuery.Create(application.MainForm);
    DMPointage2.Requete.SQL.Clear;

    //
    DMPointage2.Requete.SQL.Add(' select min(ResteDC."Date") as DateDeb');
    DMPointage2.Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd where reste<>0 ');
    DMPointage2.Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" >:DateFin)))');
    DMPointage2.Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" >:DateFin))))');
    DMPointage2.Requete.ParamByName('DateFin').AsDate := e.DatExoFin;

    DMPointage2.Requete.open;
    if ((DMPointage2.Requete.recordcount<>0)and(not empty(DMPointage2.Requete.findfield('DateDeb').Asstring)))then
      periode.DateDeb:=DMPointage2.Requete.findfield('DateDeb').AsDateTime
    else
      periode.DateDeb:=e.DatExoDebut;

    DMPointage2.Requete.Close;

  if DemandePeriode then
    Begin
       periode:=ChoixPeriodeAffich(periode.DateDeb,E.DatExoFin,'',ParamAffichPeriode);
    end
   else
    begin
     periode.Retour := true;
     periode.DateFin := E.DatExoFin;
    end;

if(periode.DateDeb<=e.DatExoDebut)then                                              //on ne travail que sur les mois de l'exercice en cours
  DateDepart:=e.DatExoDebut else  dateDepart:=periode.DateDeb;   //ou sur les mois demandés si dans l'exercice en cours
if(periode.DateFin>=e.DatExoFin)then
  dateFin:=e.DatExoFin else  dateFin:=periode.DateFin;

DecodeDate(DateDepart,A,M,D);
DateDepart:=EncodeDate(A,M,1);
DecodeDate(Datefin,A,M,D);
Datefin:=EncodeDate(A,M,1)-1;

fini:=false;
DateTmp:=DateDepart;
Exercice:=TExercice.Create;
Exercice.Date_Deb_Exo:=DateTmp;
Exercice.Date_Fin_Exo:=moissuivant(DateTmp,0).Date_-1;
listeMoisExo.AddObject(DateInfos(DateTmp).MoisAnneeStr,Exercice);
while (not fini)do
begin

DateTmp:=MoisSuivant(DateTmp,0).Date_;
   if(DateTmp-1<=DateFin) then
     begin
       Exercice:=TExercice.Create;
       Exercice.Date_Deb_Exo:=DateTmp;
       Exercice.Date_Fin_Exo:=moissuivant(DateTmp,0).Date_-1;
       listeMoisExo.AddObject(DateInfos(DateTmp).MoisAnneeStr,Exercice);
//       showmessage(datetostr(Exercice.Date_Deb_Exo));
//       showmessage(datetostr(Exercice.Date_Fin_Exo));
     end else fini:=true;
end;

ListeParDate.CustomSort(TriListe);

if(listeMoisExo.Count>0)then
begin
       for j:=0 to listeMoisExo.Count-1 do
         begin
              TotalMouvementCreanceCollectif:=0;
              TotalMouvementDetteCollectif:=0;
              periode.Retour := true;
              periode.DateFin := TExercice(listeMoisExo.Objects[j]).Date_Fin_Exo;
              for i:=0 to ListeParDate.Count-1 do
              begin
                 DettesEtCreances:=TDettesEtCreances(ListeParDate.Objects[i]);
                 if(DateDsIntervale(strtodate('01/01/1900'), DettesEtCreances.date,TExercice(listeMoisExo.Objects[j]).Date_Fin_Exo))then
                   begin
                      TotalMouvementCreanceCollectif:= TotalMouvementCreanceCollectif+DettesEtCreances.Creances;
                      TotalMouvementDetteCollectif:= TotalMouvementDetteCollectif+DettesEtCreances.Dettes;
                   end;
              end;
              DettesEtCreances:=TDettesEtCreances.Create;
              DettesEtCreances.Exo:=listeMoisExo.Strings[j];
              DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
              DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
              result.AddObject(listeMoisExo.Strings[j],DettesEtCreances);
       end;//fin boucle sur listeExo
   end;//fin si au moins 1 période
finally
PatienterFermer();
//Initialise_TStringlist(listeTmp,DMPointage2);
Initialise_TStringlist(listeMoisExo,DMPointage2);
//DMPointage2.QuDettesCreance_Edition.close;
//DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;
//DMPointage2.QuDettesCreance_Edition.filtered:=false;

DMPointage2.Requete.close;
//Requete:=nil;
end;
End;

function TriListe(LaListe: TStringList; Index1, Index2: Integer): Integer;
var
  sTmp1, sTmp2: tdatetime;
begin
// Chaines à comparer
  sTmp1 := strtodate(LaListe[Index1]);
  sTmp2 := strtodate(LaListe[Index2]);
// Valeur de retour pour classement
  Result := CompareDate(sTmp1, sTmp2) ;

end;

//Function TableauEvolutionAnnuelleDetteCreance( CompteDeTiers:TStringList;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string;Regrouper : integer):Tstringlist;
//var
//periode:TPeriode;
//i,j:integer;
//MontantTotal,DEjaRegle,Creance,Dette,Solde:Currency;
//Reste,TotalFinalDette,TotalFinalCreance,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
//DettesEtCreances:TDettesEtCreances;
//ParamAffichPeriode:TParamAffichPeriode;
//LibelleCorrect:string;
//Requete:TQuery;
//CompteDeTiersTmp,CompteRegroupe,NomTiers:string;
//compteRempli,compteCollectifRempli:boolean;
//listeExo,Liste3Derniers,listeTmp:Tstringlist;
//Compte3Annee:TCompte3Annee;
//ExoCourant:integer;
//listeParCompte,listeParDate:TStringList;
//begin
//
////TypeDettes='' -> Dettes et Créances
////TypeDettes='C' -> Dettes
////TypeDettes='D' -> Créances
////ListeExclu = liste des journaux exclu
//
//try//finally
////PatienterAffich();
//listeParCompte:=TStringList.create;
//listeParDate:=TStringList.create;
//result:=TStringList.create;
//listeExo:=Tstringlist.create;
//Liste3Derniers:=Tstringlist.create;
//Initialise_ParamAffichPeriode(ParamAffichPeriode);
//    Requete:=TQuery.Create(application.MainForm);
//
//listeTmp:=listeExercice(e.ID_Dos);
//
//   //récupérer tous les exercices pour travailler dessus
//    listeTmp:=listeExercice(e.ID_Dos);
//
//    //récupérer les 3 derniers exercices pour travailler dessus
//    for i:=0 to listeTmp.count-1 do
//    begin
//       if(listeTmp.Strings[i]=e.NomExo)then
//         begin
//             Liste3Derniers.AddObject(listeTmp.Strings[i],listeTmp.Objects[i]);
//             if(i>0)then Liste3Derniers.AddObject(listeTmp.Strings[i-1],listeTmp.Objects[i-1]);;
//             if(i>1)then Liste3Derniers.AddObject(listeTmp.Strings[i-2],listeTmp.Objects[i-2]);;
//         end;
//    end;
//
//if(listeTmp.Count>0)then
//begin
////    for i:=listeTmp.count-1 downto  0   do
////    begin
////      listeExo.AddObject(listeTmp.Strings[i],listeTmp.Objects[i]);
////    end;
//   TotalFinalDette:=0;
//   TotalFinalCreance:=0;
//    listeExo:=listeTmp;
//
//    Requete.close;
//    Requete.SQL.Clear;
//    //
//    Requete.SQL.Add(' select min(ResteDC."Date") as DateDeb');
//    Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd where reste<>0 ');
//    Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" >:DateFin)))');
//    Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" >:DateFin))))');
//    Requete.ParamByName('DateFin').AsDate := e.DatExoFin;
//
//    Requete.open;
//    if ((requete.recordcount<>0)and(not empty(Requete.findfield('DateDeb').Asstring)))then
//      periode.DateDeb:=Requete.findfield('DateDeb').AsDateTime
//    else
//    //  periode.DateDeb:=e.DatExoDebut;
//        periode.DateDeb:=TExercice(listeExo.Objects[0]).Date_Deb_Exo;
//
//
//    Requete.Close;
//       for j:=0 to listeExo.Count-1 do
//         begin
//            if(TExercice(listeExo.Objects[j]).Date_Fin_Exo>=periode.DateDeb)then
//              begin
//              ExoCourant:=Liste3Derniers.IndexOf(listeExo.Strings[j]);
//              periode.Retour := true;
//              periode.DateFin := TExercice(listeExo.Objects[j]).Date_Fin_Exo;
//
//
//              if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);
//
//              DMPointage2.TypeDettes:=TypeDettes;
//              if ListeExclu=nil then
//                Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false)
//              else
//                if DMPointage2.ListeDettesAffich.ClassInfo<>ListeExclu.ClassInfo then
//                begin
//                  Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false);
//                  for i:=0 to ListeExclu.count-1 do
//                    DMPointage2.ListeDettesAffich.Add(ListeExclu.strings[i]);
//                end;
//                DMPointage2.QuDettesCreance_Edition.Close;
//                DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
//                DMPointage2.QuDettesCreance_Edition.filtered:=true;
//                DMPointage2.QuDettesCreance_Edition.sql.Clear;
//                DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,R.Tiers,T.Nom,R.Sens');
//                DMPointage2.QuDettesCreance_Edition.sql.Add('from ResteDC R');
//                DMPointage2.QuDettesCreance_Edition.sql.Add('left join tiers T on (r.tiers=T.tiers)');
//                DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
//                DMPointage2.QuDettesCreance_Edition.sql.Add('where  R."Date" between :DateDeb and  :DateFin');
//                if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and R.reste<>0');
//                  DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,R.tiers');
//
//
//
//            if CompteDeTiers=nil then
//             // Tous les Comptes de Tiers
//             begin
//              DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//              DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//              DMPointage2.QuDettesCreance_Edition.Prepare;
//              DMPointage2.QuDettesCreance_Edition.Open;
//              DMPointage2.QuDettesCreance_Edition.First;
//              CompteDeTiers:=Tstringlist.Create;
//              CompteDeTiers.Sorted:=True;
//              CompteDeTiers.Duplicates:=dupIgnore;
//              while not DMPointage2.QuDettesCreance_Edition.Eof do
//                Begin
//                  if (empty(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString)) and (str_commence_par(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString,'+')=false)then
//                    CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString)
//                  else
//                    CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString);
//                  DMPointage2.QuDettesCreance_Edition.Next;
//                end;
//              end;
//
//            if (CompteDeTiers<>nil)and (CompteDeTiers.count>0) then //
//             begin
//                    DMPointage2.QuDettesCreance_Edition.close;
//                    DMPointage2.QuDettesCreance_Edition.sql.Clear;
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' where (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and R."Date" between :DateDeb and  :DateFin');
//                    if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,R."Date",Reference');
//
//
//
//              compteCollectifRempli:=false;
//                    if CompteDeTiers.count<>0 then
//                      begin//si il y a des dettes ou creances dans période
//                         for i:=0 to CompteDeTiers.count-1 do
//                           begin
//                              Solde :=0;
//                              if (CompteDeTiers.count=1)then
//                                 CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[0],1,';')
//                              else  CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],2,';');
//                              if str_commence_par(CompteDeTiersTmp,'+')then
//                                begin
//                                  CompteRegroupe:=DMTiers.CptDuTiers(CompteDeTiersTmp);
//                                  NomTiers:=DMTiers.LibelleDuTiers(CompteDeTiersTmp);
//                                  DMPointage2.QuDettesCreance_Edition.Close;
//                                  DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := CompteRegroupe;
//                                end
//                              else
//                                begin
//                                  CompteRegroupe:=copy(CompteDeTiersTmp,1,regrouper);
//                                  NomTiers:=DMPlan.LibelleDuNumCptPCU(CompteRegroupe);
//                                  DMPointage2.QuDettesCreance_Edition.Close;
//                                  DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := GetStringElement(CompteDeTiers.strings[0],1,';');
//                                end;
//
//                              DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
//                              DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//                              DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//                              DMPointage2.QuDettesCreance_Edition.Open;
//                              DMPointage2.QuDettesCreance_Edition.First;
//                              if DMPointage2.QuDettesCreance_Edition.recordcount=0 then
//                                CompteDeTiersTmp:='';
//                              compteRempli:=false;
//                              while not DMPointage2.QuDettesCreance_Edition.Eof do
//                                begin
//                                 if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
//                                  MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
//                                  else
//                                  MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
//                                  // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
//                                  // les dates de pièce sont antérieures à la date de fin de période
//                                  // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//                    //              DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;
//
//                                  if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
//                                   Begin
//                                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
//                                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
//                                     DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition.findfield('MontantPointeCredit').AsCurrency;
//                                     Dette:=MontantTotal - DejaRegle;
//                                     TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
//                                     TotalFinalDette:=Dette+TotalFinalDette;
//                                     Creance :=0;
//                                   end
//                                  else
//                                    begin
//                                     DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
//                                     DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                                     DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                                     DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
//                                     DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition.findfield('MontantPointeDebit').AsCurrency;
//                                      Creance:=MontantTotal - DejaRegle;
//                                      TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
//                                      TotalFinalCreance:=Creance+TotalFinalCreance;
//                                      Dette:=0;
//                                    end;
//
//                                 Solde := Creance - Dette + Solde;
//                                 if DejaRegle <> MontantTotal then
//                                 begin //si solde <> 0 on rempli dans la liste
//                                   if compteRempli=false then
//                                     begin
//                                        compteRempli:=true;
//                                        compteCollectifRempli:=true;
//                                     end;
//
//                                 end;//si solde <>0
//                                 DMPointage2.QuDettesCreance_Edition.Next;
//                                end;
//                                if(i=75)then showmessage('ok');
//                            if (i<CompteDeTiers.count-1)and (compteCollectifRempli) and(CompteRegroupe<>Copy(GetStringElement(CompteDeTiers.strings[i+1],1,';'),1,Regrouper))then
//                                  begin//changement de compte collectif, donc totaux
//                                    //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
//                                    DettesEtCreances:=TDettesEtCreances.Create;
//                                    DettesEtCreances.compte:=CompteRegroupe;
//                                    DettesEtCreances.ordre:=ExoCourant;
//                                    DettesEtCreances.Exo:=TExercice(listeExo.Objects[j]).nom_exo;
//                                    DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
//                                    DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
//                                    DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
//                                    listeParCompte.AddObject(CompteRegroupe,DettesEtCreances);
//                                    TotalMouvementDetteCollectif:=0;
//                                    TotalMouvementCreanceCollectif:=0;
//                                    compteCollectifRempli:=false;
//
//                                  end;
//                           end;//fin parcours liste des comptes
//                          if (CompteRegroupe<>'')and(ExoCourant<>-1)then
//                            begin
//                                    //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
//                                    DettesEtCreances:=TDettesEtCreances.Create;
//                                    DettesEtCreances.compte:=CompteRegroupe;
//                                    DettesEtCreances.ordre:=ExoCourant;
//                                    DettesEtCreances.Exo:=TExercice(listeExo.Objects[j]).nom_exo;
//                                    DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
//                                    DettesEtCreances.Creances:=TotalFinalCreance;
//                                    DettesEtCreances.Dettes:=TotalFinalCreance;
//                                    listeParCompte.AddObject(CompteRegroupe,DettesEtCreances);
////                                    TotalMouvementDetteCollectif:=0;
////                                    TotalMouvementCreanceCollectif:=0;
//                            end;
//                          if (CompteRegroupe<>'')then
//                            begin
//                            //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
//                            DettesEtCreances:=TDettesEtCreances.Create;
//                            DettesEtCreances.Exo:=TExercice(listeExo.Objects[j]).nom_exo;
//                            DettesEtCreances.libelle:='';
//                            DettesEtCreances.Creances:=TotalFinalCreance;
//                            DettesEtCreances.Dettes:=TotalFinalDette;
//                            listeParDate.AddObject(TExercice(listeExo.Objects[j]).nom_exo,DettesEtCreances);
//                            TotalFinalDette:=0;
//                            TotalFinalCreance:=0;
//                            end;
//
//                     end;//fin si il y a des dettes ou creances dans période
//           end;//fin si liste compte rempli
//           end;//fin si date fin >=dateDeb
//       end;//fin boucle sur listeExo
//   end;//fin si au moins 1 période
//finally
////PatienterFermer();
//result.AddObject('Compte',listeParCompte);
//result.AddObject('date',listeParDate);
////Initialise_TStringlist(Liste3Derniers);
////Initialise_TStringlist(listeExo);
////Initialise_TStringlist(CompteDeTiers,DMPointage2);
//DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
//DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
//DMPointage2.QuDettesCreance_Edition.close;
//DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;
//DMPointage2.QuDettesCreance_Edition.filtered:=false;
//
//Requete.close;
//Requete:=nil;
//end;
//End;


Function TableauEvolutionAnnuelleDetteCreance( CompteDeTiers:TStringList;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string;Regrouper : integer;exercice:TExercice;ExoCourant:integer):Tstringlist;
var
periode:TPeriode;
i,j:integer;
MontantTotal,DEjaRegle,Creance,Dette,Solde:Currency;
Reste,TotalFinalDette,TotalFinalCreance,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
DettesEtCreances:TDettesEtCreances;
ParamAffichPeriode:TParamAffichPeriode;
LibelleCorrect,filtre:string;
Requete:TQuery;
CompteDeTiersTmp,CompteRegroupe,NomTiers:string;
compteRempli,compteCollectifRempli,compteCollectifRempliHorsListe:boolean;
Liste3Derniers,listeTmp:Tstringlist;
Compte3Annee:TCompte3Annee;
listeParCompte,listeParDate:TStringList;
begin

try//finally
PatienterAffich();
listeParCompte:=TStringList.create;
listeParDate:=TStringList.create;
result:=TStringList.create;
periode.DateDeb:=exercice.Date_Deb_Exo;
periode.DateFin:=exercice.Date_Fin_Exo;
Initialise_ParamAffichPeriode(ParamAffichPeriode);
    Requete:=TQuery.Create(application.MainForm);
Requete:=TQuery.Create(application.MainForm);
    Requete.close;
    Requete.SQL.Clear;
    //
    Requete.SQL.Add(' select min(ResteDC."Date") as DateDeb');
    Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd where reste<>0 ');
    Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" >:DateFin)))');
    Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" >:DateFin))))');
    Requete.ParamByName('DateFin').AsDate := e.DatExoFin;

    Requete.open;
    if ((requete.recordcount<>0)and(not empty(Requete.findfield('DateDeb').Asstring)))then
      periode.DateDeb:=Requete.findfield('DateDeb').AsDateTime
    else
        periode.DateDeb:=exercice.Date_Deb_Exo;

Requete.Close;

if(periode.DateFin>=periode.DateDeb)then
   begin
//    for i:=listeTmp.count-1 downto  0   do
//    begin
//      listeExo.AddObject(listeTmp.Strings[i],listeTmp.Objects[i]);
//    end;
   TotalFinalDette:=0;
   TotalFinalCreance:=0;

//       for j:=0 to listeExo.Count-1 do
//         begin
//            if(TExercice(listeExo.Objects[j]).Date_Fin_Exo>=periode.DateDeb)then
//              begin

//              periode.Retour := true;
//              periode.DateFin := TExercice(listeExo.Objects[j]).Date_Fin_Exo;


              if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);

              DMPointage2.TypeDettes:=TypeDettes;
              if ListeExclu=nil then
                Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false)
              else
                if DMPointage2.ListeDettesAffich.ClassInfo<>ListeExclu.ClassInfo then
                begin
                  Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false);
                  for i:=0 to ListeExclu.count-1 do
                    DMPointage2.ListeDettesAffich.Add(ListeExclu.strings[i]);
                end;
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeDebit_Edition2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeCredit_Edition2);                
            DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Close;
    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.ParamByName('FinPeriode').AsDate:=periode.DateFin;
    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Open;

    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Close;
    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.ParamByName('FinPeriode').AsDate:=periode.DateFin;
    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Open;

DMPointage2.QuDettesCreance_Edition.Close;
DMPointage2.QuDettesCreance_Edition.Filter:='';
DMPointage2.QuDettesCreance_Edition.Filtered:=false;

            if CompteDeTiers=nil then
             // Tous les Comptes de Tiers
             begin
                DMPointage2.QuDettesCreance_Edition.Close;
                DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
                DMPointage2.QuDettesCreance_Edition.filtered:=true;
                DMPointage2.QuDettesCreance_Edition.sql.Clear;
                DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,P.compte,R.Tiers,T.Nom,R.Sens');
                DMPointage2.QuDettesCreance_Edition.sql.Add('from ResteDC R');
                DMPointage2.QuDettesCreance_Edition.sql.Add('left join tiers T on (r.tiers=T.tiers)');
                DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
                DMPointage2.QuDettesCreance_Edition.sql.Add('where  R."Date" between :DateDeb and  :DateFin');
                if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and R.reste<>0');
                  DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,R.tiers');

              DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
              DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
              DMPointage2.QuDettesCreance_Edition.Prepare;
              DMPointage2.QuDettesCreance_Edition.Open;
              DMPointage2.QuDettesCreance_Edition.First;
              CompteDeTiers:=Tstringlist.Create;
              CompteDeTiers.Sorted:=True;
              CompteDeTiers.Duplicates:=dupIgnore;
              while not DMPointage2.QuDettesCreance_Edition.Eof do
                Begin
                  if (empty(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString)) and (str_commence_par(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString,'+')=false)then
                    CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString)
                  else
                    CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString);
                  DMPointage2.QuDettesCreance_Edition.Next;
                end;
              end;


            if (CompteDeTiers<>nil)and (CompteDeTiers.count>0) then //
             begin
                    DMPointage2.QuDettesCreance_Edition.close;
                    DMPointage2.QuDettesCreance_Edition.sql.Clear;
                    DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,P.compte,R.Tiers,Reference,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece,');
                    DMPointage2.QuDettesCreance_Edition.sql.Add(' Nom,Adresse1,Adresse2,Poste,Ville,Pays ');
                    DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
                    DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
                    DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');      // (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and
                    DMPointage2.QuDettesCreance_Edition.sql.Add(' where  R."Date" between :DateDeb and  :DateFin');
                    if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
                    DMPointage2.QuDettesCreance_Edition.sql.Add(' order by P.compte,R.tiers,R."Date",Reference');
                    DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
                    DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
                              DMPointage2.QuDettesCreance_Edition.Open;
                              DMPointage2.QuDettesCreance_Edition.First;

              compteCollectifRempli:=false;
              compteCollectifRempliHorsListe:=false;
                    if CompteDeTiers.count<>0 then
                      begin//si il y a des dettes ou creances dans période
                         for i:=0 to CompteDeTiers.count-1 do
                           begin
                              Solde :=0;
                              if (CompteDeTiers.count=1)then
                                 CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],1,';')
                              else  CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],2,';');
                              if str_commence_par(CompteDeTiersTmp,'+')then
                                begin
                                  CompteRegroupe:=DMTiers.CptDuTiers(CompteDeTiersTmp);
                                  NomTiers:=DMTiers.LibelleDuTiers(CompteDeTiersTmp);
                                  filtre:='Tiers = '''+CompteDeTiersTmp+'''';
                                  FiltrageDataSet(DMPointage2.QuDettesCreance_Edition,filtre);
//                                  DMPointage2.QuDettesCreance_Edition.Close;
//                                  DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := CompteRegroupe;
                                end
                              else
                                begin
                                  CompteRegroupe:=copy(CompteDeTiersTmp,1,regrouper);
                                  NomTiers:=DMPlan.LibelleDuNumCptPCU(CompteRegroupe);
                                  filtre:='Tiers = '''+GetStringElement(CompteDeTiers.strings[i],1,';')+'''';
                                  FiltrageDataSet(DMPointage2.QuDettesCreance_Edition,filtre);
//                                  DMPointage2.QuDettesCreance_Edition.Close;
//                                  DMPointage2.QuDettesCreance_Edition.ParamByName('CompteTmp').AsString := GetStringElement(CompteDeTiers.strings[0],1,';');
                                end;

//                              DMPointage2.QuDettesCreance_Edition.ParamByName('TiersTmp').AsString := CompteDeTiersTmp;
//                              DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//                              DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//                              DMPointage2.QuDettesCreance_Edition.Open;
//                              DMPointage2.QuDettesCreance_Edition.First;
                              if DMPointage2.QuDettesCreance_Edition.recordcount=0 then
                                CompteDeTiersTmp:='';
                              compteRempli:=false;
                              while not DMPointage2.QuDettesCreance_Edition.Eof do
                                begin
                                 if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
                                  MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
                                  else
                                  MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
                                  // DejaRegle doit contenir le montant total des pièces pointé avec la pièce courante et dont
                                  // les dates de pièce sont antérieures à la date de fin de période
                                  // A FAIRE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    //              DejaRegle:=MontantTotal - DMPointage2.QuDettesCreance_Edition.FindField('Reste').AsCurrency;

                                  if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
                                   Begin
//                                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Close;
//                                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                                     DMPointage2.QuSumPointageDansPeriodeCredit_Edition.Open;
                                     DejaRegle:=0;
                                     if  DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Locate('id_credit',IntToStr(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger),[]) then
                                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.findfield('MontantPointeCredit').AsCurrency;
                                     Dette:=MontantTotal - DejaRegle;
                                     TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
                                     TotalFinalDette:=Dette+TotalFinalDette;
                                     Creance :=0;
                                   end
                                  else
                                    begin
                                    DejaRegle:=0;
//                                     DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Close;
//                                     DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('Id_Ecriture').AsInteger := DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger;
//                                     DMPointage2.QuSumPointageDansPeriodeDebit_Edition.ParamByName('FinPeriode').AsDate := Periode.DateFin;
//                                     DMPointage2.QuSumPointageDansPeriodeDebit_Edition.Open;
                                     if  DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Locate('id_debit',IntToStr(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger),[]) then
                                        DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.findfield('MontantPointeDebit').AsCurrency;
                                      Creance:=MontantTotal - DejaRegle;
                                      TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
                                      TotalFinalCreance:=Creance+TotalFinalCreance;
                                      Dette:=0;
                                    end;

                                 Solde := Creance - Dette + Solde;
                                 if DejaRegle <> MontantTotal then
                                 begin //si solde <> 0 on rempli dans la liste
                                   if compteRempli=false then
                                     begin
                                        compteRempli:=true;
                                        compteCollectifRempli:=true;
                                        compteCollectifRempliHorsListe:=true;
                                     end;

                                 end;//si solde <>0
                                 DMPointage2.QuDettesCreance_Edition.Next;
                                end;
                                //if(i=75)then showmessage('ok');
                            if (i<CompteDeTiers.count-1)and (compteCollectifRempli) and(CompteRegroupe<>Copy(GetStringElement(CompteDeTiers.strings[i+1],1,';'),1,Regrouper))then
                                  begin//changement de compte collectif, donc totaux
                                    //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
                                    DettesEtCreances:=TDettesEtCreances.Create;
                                    DettesEtCreances.compte:=CompteRegroupe;
                                    DettesEtCreances.ordre:=ExoCourant;
                                    DettesEtCreances.Exo:=exercice.nom_exo;
                                    DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
                                    DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
                                    DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
                                    listeParCompte.AddObject(CompteRegroupe,DettesEtCreances);
                                    if(i<CompteDeTiers.Count-1)then
                                    begin
                                      TotalMouvementDetteCollectif:=0;
                                      TotalMouvementCreanceCollectif:=0;
                                      compteCollectifRempli:=false;
                                      compteCollectifRempliHorsListe:=false;
                                    end;
                                  end;
                           end;//fin parcours liste des comptes
                          if (CompteRegroupe<>'')and(ExoCourant<>-1)and(compteCollectifRempliHorsListe)then
                            begin
                                    //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
                                    DettesEtCreances:=TDettesEtCreances.Create;
                                    DettesEtCreances.compte:=CompteRegroupe;

                                    DettesEtCreances.ordre:=ExoCourant;
                                    DettesEtCreances.Exo:=exercice.nom_exo;
                                    DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
                                    DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
                                    DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
                                    listeParCompte.AddObject(CompteRegroupe,DettesEtCreances);
//                                    TotalMouvementDetteCollectif:=0;
//                                    TotalMouvementCreanceCollectif:=0;
                            end;
                          if (CompteRegroupe<>'')then
                            begin
                            //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
                            DettesEtCreances:=TDettesEtCreances.Create;
                            DettesEtCreances.Exo:=exercice.nom_exo;
                            DettesEtCreances.libelle:='';
                            DettesEtCreances.Creances:=TotalFinalCreance;
                            DettesEtCreances.Dettes:=TotalFinalDette;
                            listeParDate.AddObject(exercice.nom_exo,DettesEtCreances);
                            TotalFinalDette:=0;
                            TotalFinalCreance:=0;
                            end;

                     end;//fin si il y a des dettes ou creances dans période
           end;//fin si liste compte rempli
           //end;//fin si date fin >=dateDeb
       //end;//fin boucle sur listeExo
   end;//fin si au moins 1 période
finally
PatienterFermer();
result.AddObject('Compte',listeParCompte);
result.AddObject('date',listeParDate);
//Initialise_TStringlist(Liste3Derniers);
//Initialise_TStringlist(listeExo);
//Initialise_TStringlist(CompteDeTiers,DMPointage2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeDebit_Edition2);
DeFiltrageDataSet(DMPointage2.QuSumPointageDansPeriodeCredit_Edition2);
DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Close;
DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Filtered:=false;
DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Close;
DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Filtered:=false;
DMPointage2.QuDettesCreance_Edition.close;
DMPointage2.QuDettesCreance_Edition.filtered:=false;
DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;

Requete.close;
Requete:=nil;
end;
End;

//Function TableauEvolutionAnnuelleDetteCreance( CompteDeTiers:TStringList;precision:boolean;ListeExclu:Tstringlist;TypeDettes:string;Regrouper : integer;exercice:TExercice;ExoCourant:integer):Tstringlist;
//var
//periode:TPeriode;
//i,j:integer;
//MontantTotal,DEjaRegle,Creance,Dette,Solde:Currency;
//Reste,TotalFinalDette,TotalFinalCreance,TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif:Currency;
//DettesEtCreances:TDettesEtCreances;
//ParamAffichPeriode:TParamAffichPeriode;
//LibelleCorrect:string;
//CompteDeTiersTmp,CompteRegroupe,NomTiers:string;
//compteRempli,compteCollectifRempli:boolean;
//Compte3Annee:TCompte3Annee;
//listeParCompte,listeParDate:TStringList;
//begin
//
//try//finally
////PatienterAffich();
//listeParCompte:=TStringList.create;
//listeParDate:=TStringList.create;
//result:=TStringList.create;
//
//periode.DateDeb:=exercice.Date_Deb_Exo;
//periode.DateFin:=exercice.Date_Fin_Exo;
//Initialise_ParamAffichPeriode(ParamAffichPeriode);
//   // Requete:=TQuery.Create(application.MainForm);
//    DMPointage2.Requete.close;
//    DMPointage2.Requete.SQL.Clear;
//    //
//    DMPointage2.Requete.SQL.Add(' select min(ResteDC."Date") as DateDeb');
//    DMPointage2.Requete.SQL.Add(' from "'+e.RepertoireDossier+'ResteDC" rd where reste<>0 ');
//    DMPointage2.Requete.SQL.Add(' or(((reste=0 and rd.sens=''D'' and  rd.id_ecriture  in (select id_debit from "'+e.RepertoireDossier+'pointage" p where P."Date" >:DateFin)))');
//    DMPointage2.Requete.SQL.Add(' or((reste=0 and rd.sens=''C'' and  rd.id_ecriture  in(select id_credit from "'+e.RepertoireDossier+'pointage" p where P."TvaDate" >:DateFin))))');
//    DMPointage2.Requete.ParamByName('DateFin').AsDate := e.DatExoFin;
//
//    DMPointage2.Requete.open;
//    if ((DMPointage2.Requete.recordcount<>0)and(not empty(DMPointage2.Requete.findfield('DateDeb').Asstring)))then
//      periode.DateDeb:=DMPointage2.Requete.findfield('DateDeb').AsDateTime
//    else
//        periode.DateDeb:=exercice.Date_Deb_Exo;
//
//DMPointage2.Requete.Close;
//
//if(periode.DateFin>=periode.DateDeb)then
//   begin
////    for i:=listeTmp.count-1 downto  0   do
////    begin
////      listeExo.AddObject(listeTmp.Strings[i],listeTmp.Objects[i]);
////    end;
//   TotalFinalDette:=0;
//   TotalFinalCreance:=0;
//            DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Close;
//    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.ParamByName('FinPeriode').AsDate:=periode.DateFin;
//    DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Open;
//
//    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Close;
//    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.ParamByName('FinPeriode').AsDate:=periode.DateFin;
//    DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Open;
////       for j:=0 to listeExo.Count-1 do
////         begin
////            if(TExercice(listeExo.Objects[j]).Date_Fin_Exo>=periode.DateDeb)then
////              begin
//
////              periode.Retour := true;
////              periode.DateFin := TExercice(listeExo.Objects[j]).Date_Fin_Exo;
//
//
//              if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);
//
//              DMPointage2.TypeDettes:=TypeDettes;
//              if ListeExclu=nil then
//                Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false)
//              else
//                if DMPointage2.ListeDettesAffich.ClassInfo<>ListeExclu.ClassInfo then
//                begin
//                  Initialise_TStringlist(DMPointage2.ListeDettesAffich,DMPointage2,false);
//                  for i:=0 to ListeExclu.count-1 do
//                    DMPointage2.ListeDettesAffich.Add(ListeExclu.strings[i]);
//                end;
//
//                DMPointage2.QuDettesCreance_Edition.Close;
//                DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
//                DMPointage2.QuDettesCreance_Edition.filtered:=true;
//
////
////
////
//            if CompteDeTiers=nil then
//             // Tous les Comptes de Tiers
//             begin
//
//                DMPointage2.QuDettesCreance_Edition.sql.Clear;
//                DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,R.Tiers,T.Nom,R.Sens');
//                DMPointage2.QuDettesCreance_Edition.sql.Add('from ResteDC R');
//                DMPointage2.QuDettesCreance_Edition.sql.Add('left join tiers T on (r.tiers=T.tiers)');
//                DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
//                DMPointage2.QuDettesCreance_Edition.sql.Add('where  R."Date" between :DateDeb and  :DateFin');
//                if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and R.reste<>0');
//                  DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,R.tiers');
//              DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//              DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//              DMPointage2.QuDettesCreance_Edition.Prepare;
//              DMPointage2.QuDettesCreance_Edition.Open;
//              DMPointage2.QuDettesCreance_Edition.First;
//              CompteDeTiers:=Tstringlist.Create;
//              CompteDeTiers.Sorted:=True;
//              CompteDeTiers.Duplicates:=dupIgnore;
//              while not DMPointage2.QuDettesCreance_Edition.Eof do
//                Begin
//                  if (empty(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString)) and (str_commence_par(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString,'+')=false)then
//                    CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString)
//                  else
//                    CompteDeTiers.Add(DMPointage2.QuDettesCreance_Edition.findfield('compte').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('tiers').AsString+';'+DMPointage2.QuDettesCreance_Edition.findfield('Nom').AsString);
//                  DMPointage2.QuDettesCreance_Edition.Next;
//                end;
//              end;
//
//            if (CompteDeTiers<>nil)and (CompteDeTiers.count>0) then //
//             begin
////                    for i:=0 to CompteDeTiers.count-1 do
////                    begin
////                        if (CompteDeTiers.count=1)then
////                           CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[0],1,';')
////                        else  CompteDeTiersTmp:=GetStringElement(CompteDeTiers.strings[i],2,';');
////                        if str_commence_par(CompteDeTiersTmp,'+')then
////                          begin
////                            DMPointage2.ListeTiersAffich.Add(CompteDeTiersTmp);
////                          end
////                        else
////                          begin
////                            DMPointage2.ListecompteAffich.Add(CompteDeTiersTmp);
////
////                          end;
////                    end;
//                    DMPointage2.QuDettesCreance_Edition.close;
//                    DMPointage2.QuDettesCreance_Edition.sql.Clear;
//                    DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=DMPointage2.QuDettesCreance_EditionFilterRecord;
//                    DMPointage2.QuDettesCreance_Edition.filtered:=true;
//
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,R."Date",debit,Credit,Sens, Reste, R.id_ecriture,Libelle,id_piece,');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' (select sum (Montant) ');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' from pointage ');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' where (id_debit=R.id_ecriture )');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' and (Pointage."Date"<=:DateFin ))as MontantPointeDebit');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' ,(select sum (Montant) ');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' from pointage ');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' where (id_credit=R.id_ecriture )');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' and (Pointage."Date"<=:DateFin ))as MontantPointeCredit');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');   // (compte=:CompteTmp or compte is null) and Tiers=:TiersTmp and
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' where  R."Date" between :DateDeb and  :DateFin');
////                    if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
////                    DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,R."Date",Reference');
//
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' select P.journal,T.compte,Tiers,Reference,P.Echeance,R."Date",debit,Credit,Sens, Reste, id_ecriture,Libelle,id_piece');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' from ResteDC R');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' left join  Tiers T on (T.tiers=R.tiers)');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' join Piece P on (P.id=R.id_piece)');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' where  P.Echeance between :DateDeb and  :DateFin');
//                    if not precision then DMPointage2.QuDettesCreance_Edition.sql.Add(' and reste<>0');
//                    DMPointage2.QuDettesCreance_Edition.sql.Add(' order by T.compte,tiers,P.Echeance,Reference');
//
//                              DMPointage2.QuDettesCreance_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
//                              DMPointage2.QuDettesCreance_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
//                              DMPointage2.QuDettesCreance_Edition.Open;
//                              DMPointage2.QuDettesCreance_Edition.First;
//                              CompteRegroupe:='';
//                              while not DMPointage2.QuDettesCreance_Edition.Eof do
//                                begin
//                            if (CompteRegroupe<>Copy(DMPointage2.QuDettesCreance_Edition.FindField('compte').AsString,1,Regrouper))then
//                                  begin//changement de compte collectif, donc totaux
//                                    //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
//                                    DettesEtCreances:=TDettesEtCreances.Create;
//                                    DettesEtCreances.compte:=CompteRegroupe;
//                                    DettesEtCreances.ordre:=ExoCourant;
//                                    DettesEtCreances.Exo:=exercice.nom_exo;
//                                    DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
//                                    DettesEtCreances.Creances:=TotalMouvementCreanceCollectif;
//                                    DettesEtCreances.Dettes:=TotalMouvementDetteCollectif;
//                                    listeParCompte.AddObject(CompteRegroupe,DettesEtCreances);
//                                    TotalMouvementDetteCollectif:=0;
//                                    TotalMouvementCreanceCollectif:=0;
//                                    compteCollectifRempli:=false;
//                                  end;
//                                  CompteRegroupe:=Copy(DMPointage2.QuDettesCreance_Edition.FindField('compte').AsString,1,Regrouper);
//                                 if not VerifFnumeric(DMPointage2.QuDettesCreance_Edition.FindField('debit')).VideOUZero then
//                                  MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('debit').AsCurrency
//                                  else
//                                  MontantTotal:=DMPointage2.QuDettesCreance_Edition.FindField('Credit').AsCurrency;
//
//                                  if DMPointage2.QuDettesCreance_Edition.FindField('Sens').AsString = 'C' then
//                                   Begin
//                                     DejaRegle:=0;
//                                     if  DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Locate('id_credit',IntToStr(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger),[]) then
//                                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.findfield('MontantPointeCredit').AsCurrency;
//                                    // DejaRegle:=DMPointage2.QuDettesCreance_Edition.findfield('MontantPointeCredit').AsCurrency;
//                                     Dette:=MontantTotal - DejaRegle;
//                                     TotalMouvementDetteCollectif:=Dette+TotalMouvementDetteCollectif;
//                                     TotalFinalDette:=Dette+TotalFinalDette;
//                                     Creance :=0;
//                                   end
//                                  else
//                                    begin
//                                     DejaRegle:=0;
//                                     if  DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Locate('id_debit',IntToStr(DMPointage2.QuDettesCreance_Edition.findfield('Id_Ecriture').AsInteger),[]) then
//                                       DejaRegle:=DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.findfield('MontantPointeDebit').AsCurrency;
//                                      //DejaRegle:=DMPointage2.QuDettesCreance_Edition.findfield('MontantPointeDebit').AsCurrency;
//                                      Creance:=MontantTotal - DejaRegle;
//                                      TotalMouvementCreanceCollectif:=Creance+TotalMouvementCreanceCollectif;
//                                      TotalFinalCreance:=Creance+TotalFinalCreance;
//                                      Dette:=0;
//                                    end;
//                                 Solde := Creance - Dette + Solde;
//                                 if DejaRegle <> MontantTotal then
//                                 begin //si solde <> 0 on rempli dans la liste
//                                   if compteRempli=false then
//                                     begin
//                                        compteRempli:=true;
//                                        compteCollectifRempli:=true;
//                                     end;
//
//                                 end;//si solde <>0
//                                 DMPointage2.QuDettesCreance_Edition.Next;
//                                end;//fin du while not eof
//                          if (CompteRegroupe<>'')and(ExoCourant<>-1)then
//                            begin
//                                    //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
//                                    DettesEtCreances:=TDettesEtCreances.Create;
//                                    DettesEtCreances.compte:=CompteRegroupe;
//                                    DettesEtCreances.ordre:=ExoCourant;
//                                    DettesEtCreances.Exo:=exercice.nom_exo;
//                                    DettesEtCreances.libelle:=DMPlan.LibelleDuNumCpt(DettesEtCreances.compte);
//                                    DettesEtCreances.Creances:=TotalFinalCreance;
//                                    DettesEtCreances.Dettes:=TotalFinalCreance;
//                                    listeParCompte.AddObject(CompteRegroupe,DettesEtCreances);
////                                    TotalMouvementDetteCollectif:=0;
////                                    TotalMouvementCreanceCollectif:=0;
//                            end;
//                          if (CompteRegroupe<>'')then
//                            begin
//                            //DetermineSolde(TotalMouvementDetteCollectif,TotalMouvementCreanceCollectif);
//                            DettesEtCreances:=TDettesEtCreances.Create;
//                            DettesEtCreances.Exo:=exercice.nom_exo;
//                            DettesEtCreances.libelle:='';
//                            DettesEtCreances.Creances:=TotalFinalCreance;
//                            DettesEtCreances.Dettes:=TotalFinalDette;
//                            listeParDate.AddObject(exercice.nom_exo,DettesEtCreances);
//                            TotalFinalDette:=0;
//                            TotalFinalCreance:=0;
//                            end;
//
//           end;//fin si liste compte rempli
//           //end;//fin si date fin >=dateDeb
//       //end;//fin boucle sur listeExo
//   end;//fin si au moins 1 période
//finally
////PatienterFermer();
//Compte3Annee:=nil;
//result.AddObject('Compte',listeParCompte);
//result.AddObject('date',listeParDate);
////Initialise_TStringlist(Liste3Derniers);
////Initialise_TStringlist(listeExo);
////Initialise_TStringlist(CompteDeTiers,DMPointage2);
//DMPointage2.QuSumPointageDansPeriodeDebit_Edition2.Close;
//DMPointage2.QuSumPointageDansPeriodeCredit_Edition2.Close;
//DMPointage2.QuDettesCreance_Edition.close;
//DMPointage2.QuDettesCreance_Edition.filtered:=false;
//DMPointage2.QuDettesCreance_Edition.OnFilterRecord:=nil;
//
//DMPointage2.Requete.close;
////Requete:=nil;
//end;
//End;

constructor TDettesEtCreances.Create;
    //constructeur
begin
  inherited Create;
  compte:='';
  libelle:='';
  Dettes:=0;
  Creances:=0;
  DettesEcheance:=0;
  CreancesEcheance:=0;
end;

destructor TDettesEtCreances.Destroy;
//destructeur
begin
  inherited Destroy;
end;

//function SelectionListeComptePourDettesEtCreances(var ParamAffichCompte:TParamAffichCompte):TResultStrList;
//var
//ListeCpt:TResultStrList;
//Requete : TQuery;
//rang:integer;
//Filtre:string;
//EventButtonClick:TNotifyEvent;
//begin
//try
//    ListeCpt.Liste:=TStringList.Create;
//    requete := TQuery.Create(self);
//    requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
////                        requete.SQL.Add(' select BT.compte,Bt.tiers,T.nom,T.type from BalanceTiers bt');
////                        requete.SQL.Add(' join "'+e.RepertoireDossier+'Tiers" T on (T.tiers=Bt.tiers)');
//    requete.DatabaseName := DMRech.TaTiersRech.DatabaseName;
//    requete.SQL.Add(' select Tiers,compte,nom,type from tiers T');
//
////    requete.SQL.Add(filtre);
//
//    requete.SQL.Add(' union all');
//    requete.SQL.Add(' select P.compte,P.compte,P.Libelle,'''' from plancpt P where');
//    requete.SQL.Add(' P.pointable=true and P.compte not in');
//    requete.SQL.Add(' (select T2.compte from tiers T2 where T2.compte=P.compte)');
//    requete.SQL.Add(' order by compte,tiers');
//
//                        requete.Open;
//
//                        ListeCpt.result:=true;
//                        DeFiltrageDataSet(requete);
//                  //InitialiseParamAffichCompte(ParamAffichCompte);
//                  ParamAffichCompte.Titre:= 'Sélectionnez les tiers ...';
//                  ParamAffichCompte.Tiers:=true;
//                  ParamAffichCompte.Dataset:=requete;
//                  ParamAffichCompte.sautDePage:=e.SautDePageAutomatique;
//                 // ParamAffichCompte.titreSautDePage:='Saut de page entre les tiers';
//
//                  EventButtonClick:=LibChoixComptes.BtnSupplTypeTiersClick;
//                 ParamAffichCompte.ListeItemAction.AddObject('Sélection des types de tiers', @EventButtonClick);
//
//                  //ParamAffichCompte.EventButtonSupplementClick:=LibChoixComptes.BtnSupplClick;
//                  ParamAffichCompte.ListeChamps.Add('Tiers');
//                  ParamAffichCompte.ListeChamps.Add('compte');
//                  ParamAffichCompte.ListeChamps.Add('nom');
//                  ParamAffichCompte.ListeChamps.Add('type');
//                        listecpt:=ChoixCompteAffich(ParamAffichCompte);
//                        requete.first;
//    if (ListeCpt.Result)and (ListeCpt.Liste.count>1) then
//        begin //si la liste contient plus d'un tiers, on inverse les champs pour rentrer dans la configuration de l'edition
//            while not requete.Eof do
//            begin
//              rang:=ListeCpt.Liste.IndexOf(requete.findfield('Tiers').AsString);
//              if rang>-1 then
//                ListeCpt.Liste.Strings[rang]:=requete.findfield('compte').AsString+';'+ListeCpt.Liste.Strings[rang]+';'+requete.findfield('nom').AsString;
//              requete.next;
//            end;
//        end ;
//finally
//    result:=ListeCpt;
//    Requete.Close;
//    requete.free;
//end;
//end;


procedure TDMPointage2.TaResteUpdateLettrageBeforeOpen(DataSet: TDataSet);
begin
TaResteUpdateLettrage.OnFilterRecord:=TaResteUpdateLettrage.OnFilterRecord;
end;

procedure TDMPointage2.TaResteUpdateLettrageAfterClose(DataSet: TDataSet);
begin
TaResteUpdateLettrage.OnFilterRecord:=nil;
end;

end.

