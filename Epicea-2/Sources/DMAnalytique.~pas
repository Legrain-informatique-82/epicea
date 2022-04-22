
unit DMAnalytique;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibZoneSaisie,LibSQL,E2_Librairie_Obj,Gr_Librairie_Obj,E2_Decl_Records,
  E2_LibInfosTable,LibRessourceString,Variants,DMpiece,lib_chaine,DiversProjets,
  ObjetEdition,ChoixPeriode,LibDates;

type
  TDMAnalytiques = class(TDataModule)
    Ta_Ecriture_Atelier: TTable;
    Ta_Atelier: TTable;
    Ta_Compte_Atelier: TTable;
    Ta_Activite: TTable;
    Ta_Atelier_Activite: TTable;
    Ta_Affect_Atelier_Compte: TTable;
    DaEcriture_Atelier: TDataSource;
    DaCompte_Atelier: TDataSource;
    DaActivite: TDataSource;
    DaAtelier: TDataSource;
    DaAffect_Atelier_Compte: TDataSource;
    DaAtelier_Activite: TDataSource;
    TaEcriture_Anal: TTable;
    DaEcriture_Anal: TDataSource;
    TaEcriture_AnalID: TIntegerField;
    TaEcriture_AnalID_Ligne: TSmallintField;
    TaEcriture_AnalCompte: TStringField;
    TaEcriture_AnalLibelle: TStringField;
    TaEcriture_AnalID_GESTANAL: TIntegerField;
    TaEcriture_AnalCODE_GESTANAL: TStringField;
    TaEcriture_AnalMontant: TCurrencyField;
    TaEcriture_AnalDebitSaisie: TCurrencyField;
    TaEcriture_AnalCreditSaisie: TCurrencyField;
    Ta_AtelierID_Atelier: TIntegerField;
    Ta_AtelierCode_Atelier: TStringField;
    Ta_AtelierLibelle_Atelier: TStringField;
    Ta_AtelierNB_Unite_Atelier: TFloatField;
    Ta_AtelierUnite_Atelier: TStringField;
    Ta_AtelierID_Activite: TIntegerField;
    Ta_AtelierCode_Activite: TStringField;
    Ta_Affect_Atelier_CompteID_Atelier: TIntegerField;
    Ta_Affect_Atelier_CompteID_Ligne: TIntegerField;
    Ta_Affect_Atelier_CompteCompte: TStringField;
    Ta_Affect_Atelier_CompteLibelle: TStringField;
    Ta_Affect_Atelier_CompteCode_Atelier: TStringField;
    Ta_Affect_Atelier_CompteRatio: TFloatField;
    Ta_Atelier_ActiviteID_Atelier: TIntegerField;
    Ta_Atelier_ActiviteID_Activite: TIntegerField;
    Ta_Atelier_ActiviteRatio: TFloatField;
    Ta_ActiviteID_Activite: TIntegerField;
    Ta_ActiviteCode_Activite: TStringField;
    Ta_ActiviteLibelle_Activite: TStringField;
    Ta_Compte_AtelierCompte: TStringField;
    Ta_Compte_AtelierID_Atelier: TIntegerField;
    Ta_Compte_AtelierLibelle: TStringField;
    Ta_Compte_AtelierRatio: TFloatField;
    Ta_Ecriture_AtelierID_Ligne: TIntegerField;
    Ta_Ecriture_AtelierID_Atelier: TIntegerField;
    Ta_Ecriture_AtelierRatio: TFloatField;
    QuSupp_Atelier_Activite: TQuery;
    TaPlanAnal: TTable;
    DaPlanAnal: TDataSource;
    TaPlanAnalCompte: TStringField;
    TaPlanAnalLibelle: TStringField;
    TaPlanAnalID_GESTANAL: TIntegerField;
    TaPlanAnalCODE_GESTANAL: TStringField;
    QuSupp_Compte_Atelier: TQuery;
    Ta_Affect_Atelier_Ecriture: TTable;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    FloatField1: TFloatField;
    DaAffect_Atelier_Ecriture: TDataSource;
    QuSupp_Ecriture_Atelier: TQuery;
    Ta_Ecriture_AtelierLibelle: TStringField;
    TaAffectationDirecte: TTable;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField4: TStringField;
    FloatField2: TFloatField;
    TaEcriture_AnalID_Piece: TIntegerField;
    TA_Compte_Atelier_Lk: TTable;
    Da_Compte_Atelier_Lk: TDataSource;
    TA_Atelier_Lk: TTable;
    TA_Compte_Atelier_LkCompte: TStringField;
    TA_Compte_Atelier_LkID_Atelier: TIntegerField;
    TA_Compte_Atelier_LkLibelle: TStringField;
    TA_Compte_Atelier_LkRatio: TFloatField;
    TA_Compte_Atelier_LkCode_Atelier: TStringField;
    TA_Atelier_LkID_Atelier: TIntegerField;
    TA_Atelier_LkCode_Atelier: TStringField;
    TA_Atelier_LkLibelle_Atelier: TStringField;
    TA_Atelier_LkNB_Unite_Atelier: TFloatField;
    TA_Atelier_LkUnite_Atelier: TStringField;
    TA_Atelier_LkID_Activite: TIntegerField;
    TA_Atelier_LkCode_Activite: TStringField;
    Ta_Affect_Atelier_EcritureID: TAutoIncField;
    QuMontantEcrParAtelier: TQuery;
    QuSumRatio: TQuery;
    QuSumRatioId_Ligne: TIntegerField;
    QuSumRatioTotRatio: TFloatField;
    QuMontantEcrParAtelierId: TIntegerField;
    QuMontantEcrParAtelierDebitSaisie: TCurrencyField;
    QuMontantEcrParAtelierCreditSaisie: TCurrencyField;
    QuMontantEcrParAtelierId_Atelier: TIntegerField;
    QuMontantEcrParAtelierRatio: TFloatField;
    QuMontantEcrParAtelierProRataRatio: TCurrencyField;
    QuMontantEcrParAtelierMontantRepartiDebit: TCurrencyField;
    QuMontantEcrParAtelierMontantRepartiCredit: TCurrencyField;
    DaMontantEcrParAtelier: TDataSource;
    QuMontantEcrParAtelierCompte: TStringField;
    QuMontantEcrParAtelierCode_Atelier: TStringField;
    QuMontantEcrParAtelierDate: TDateField;
    QuMontantEcrParAtelierId_Piece: TIntegerField;
    QuMontantEcrParAtelierLibelle: TStringField;
    QuPossibiliteSupp_Atelier_Compte: TQuery;
    QuPossibiliteSupp_Atelier_Ecriture: TQuery;
    Ta_Affect_Atelier_CompteID: TAutoIncField;
    TaEcriture_AnalPieceAnnee: TBooleanField;
    QuMontantEcrParAtelier_Edition: TQuery;
    QuMontantEcrParAtelier_EditionProRataRatio: TCurrencyField;
    QuMontantEcrParAtelier_EditionMontantRepartiDebit: TCurrencyField;
    QuMontantEcrParAtelier_EditionMontantRepartiCredit: TCurrencyField;
    QuMontantEcrParAtelier_EditionId: TIntegerField;
    QuMontantEcrParAtelier_EditionDebitSaisie: TCurrencyField;
    QuMontantEcrParAtelier_EditionCreditSaisie: TCurrencyField;
    QuMontantEcrParAtelier_EditionCompte: TStringField;
    QuMontantEcrParAtelier_EditionId_Atelier: TIntegerField;
    QuMontantEcrParAtelier_EditionRatio: TFloatField;
    QuMontantEcrParAtelier_EditionDate: TDateField;
    QuMontantEcrParAtelier_EditionId_Piece: TIntegerField;
    QuMontantEcrParAtelier_EditionLibelle: TStringField;
    QuMontantEcrParAtelierSumRation: TFloatField;
    QuMontantEcrParAtelier_EditionSumRation: TFloatField;
    QuMontantEcrParAtelierqt1: TFloatField;
    QuMontantEcrParAtelierqt2: TFloatField;
    QuMontantEcrParAtelierQt1Repartie: TFloatField;
    QuMontantEcrParAtelierQt2Repartie: TFloatField;
    QuMontantEcrParAtelier_Editionqt1: TFloatField;
    QuMontantEcrParAtelier_Editionqt2: TFloatField;
    QuMontantEcrParAtelier_EditionQt1Repartie: TFloatField;
    QuMontantEcrParAtelier_EditionQt2Repartie: TFloatField;
    TaEcriture_AnalDate: TDateField;
    QuMontantEcrParAtelier_EditionNB_Unite_Atelier: TFloatField;
    QuEcritureFilterRecord: TQuery;
    QuMontantEcrParAtelier_EditionUnite_Atelier: TStringField;
    QuMontantEcrParAtelier_EditionId_activite: TIntegerField;
    QuMontantEcrParAtelierNB_Unite_Atelier: TFloatField;
    QuMontantEcrParAtelier_Editioncode_atelier: TStringField;
    QuMontantEcrParAtelier_Editioncode_activite: TStringField;
    QuMontantEcrParAtelier_Editionlibelle_atelier: TStringField;
    QuMontantEcrParAtelier_Editionlibelle_activite: TStringField;
    QuMontantEcrParAtelier_Editioncode_atelier_calc: TStringField;
    QuMontantEcrParAtelier_Editionlibelle_atelier_calc: TStringField;
    QuMontantEcrParAtelier_Editioncode_activite_calc: TStringField;
    QuMontantEcrParAtelier_Editionlibelle_activite_calc: TStringField;
    TaAtelierDefaut: TTable;
    TaAtelierDefautID: TIntegerField;
    TaAtelierDefautCode_Atelier: TStringField;
    TaAtelierDefautlibelle_Atelier: TStringField;
    TaAtelierDefautCpt_Plan: TStringField;
    TaAtelierDefautCpt_Racine: TStringField;
    TaAtelierDefautCode_Activite: TStringField;
    TaAtelierDefautDivers: TStringField;
    QuMontantEcrParAtelier_EditionCodeActiviteAnal: TStringField;
    QuMontantEcrParAtelier_Editioncode_Gestanal: TStringField;

    //commun
    procedure DMAnalytiquesCreate(Sender: TObject);
    procedure DMAnalytiquesDestroy(Sender: TObject);
    procedure PaGrilleResize_VisuListe(Sender: TObject);
    procedure FormKeyDown_VisuListe(Sender: TObject; var Key: Word;
         Shift: TShiftState);
    //////

    //FenetreCreationActivite
    procedure Ta_Atelier_ActiviteAfterInsert(DataSet: TDataSet);
    procedure Ta_AtelierAfterDelete(DataSet: TDataSet);
    procedure Ta_AtelierAfterPost(DataSet: TDataSet);
    procedure Ta_AtelierBeforeInsert(DataSet: TDataSet);
    procedure Ta_Atelier_ActiviteBeforeInsert(DataSet: TDataSet);
    procedure Ta_ActiviteBeforeInsert(DataSet: TDataSet);
    procedure Ta_AtelierDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure Ta_AtelierPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure Ta_AtelierBeforePost(DataSet: TDataSet);
    procedure Ta_Atelier_ActiviteBeforePost(DataSet: TDataSet);
    procedure Ta_ActiviteBeforePost(DataSet: TDataSet);
    procedure Ta_ActiviteAfterInsert(DataSet: TDataSet);
    procedure Ta_AtelierBeforeDelete(DataSet: TDataSet);
    procedure Ta_Atelier_ActiviteBeforeDelete(DataSet: TDataSet);
    procedure Ta_ActiviteBeforeDelete(DataSet: TDataSet);
    Function CtrlSaisieTA_Atelier(CCourant:TField):TExceptLGR;
    Function CtrlSaisieTA_Atelier_Activite(CCourant:TField):TExceptLGR;
    procedure Ta_Atelier_ActiviteAfterPost(DataSet: TDataSet);
    procedure Ta_Atelier_ActiviteAfterDelete(DataSet: TDataSet);
    procedure Ta_Atelier_ActiviteDeleteError(DataSet: TDataSet;
      E: EDatabaseError; var Action: TDataAction);
    procedure Ta_Atelier_ActivitePostError(DataSet: TDataSet;
      E: EDatabaseError; var Action: TDataAction);
    procedure Ta_ActiviteAfterPost(DataSet: TDataSet);
    procedure Ta_ActiviteAfterDelete(DataSet: TDataSet);
    Function CtrlSaisieTA_Activite(CCourant:TField):TExceptLGR;
    function GestionSuppressionActivite(Activite:TInfosTA_Activite):boolean;
    function GestionSuppressionRelation_Atelier_Activite(ID_Atelier:integer):boolean;
    //////

    //FenetreAffectCompte
    Function CtrlSaisieTA_Compte_Atelier(CCourant:TField):TExceptLGR;
    procedure Ta_Compte_AtelierBeforePost(DataSet: TDataSet);
    Function CtrlSaisieTA_PlanAnal(CCourant:TField):TExceptLGR;
    procedure TaPlanAnalBeforePost(DataSet: TDataSet);
    function GestionSuppressionRelation_Compte_Atelier(Compte:string;id_Atelier:integer):boolean;
    //////

    //FenetreAffectEcriture
    procedure TaEcriture_AnalCalcFields(DataSet: TDataSet);
    procedure TaEcriture_AnalAfterOpen(DataSet: TDataSet);
    Function CtrlSaisieTA_Ecriture_Atelier(CCourant:TField):TExceptLGR;
    procedure Ta_Ecriture_AtelierBeforePost(DataSet: TDataSet);
    Function CtrlSaisieTA_EcritureAnal(CCourant:TField):TExceptLGR;
    procedure TaEcriture_AnalBeforePost(DataSet: TDataSet);
    procedure Ta_Ecriture_AtelierBeforeDelete(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureBeforePost_AvecAffectation(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureBeforePost_SansAffectation(DataSet: TDataSet);
    Procedure FiltrageTa_Affect_Atelier_SurEcritureCourante(id:string;DataEcriture:Tdataset);
    //////

    //FenetreResultat

    //////

    ///Communs à Comptes et Ecritures
    Function CtrlSaisieTA_Affect_Atelier_PourCompte(CCourant:TField):TExceptLGR;
    Function CtrlSaisieTA_Affect_Atelier_PourEcriture(CCourant:TField):TExceptLGR;
    procedure Ta_Affect_Atelier_CompteBeforeInsert(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_CompteBeforePost_AvecAffectation(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_CompteBeforePost_SansAffectation(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_CompteBeforeDelete(DataSet: TDataSet);
    procedure Ta_Compte_AtelierAfterInsert(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_CompteAfterEdit(DataSet: TDataSet);
    procedure Ta_Compte_AtelierAfterPost(DataSet: TDataSet);
    procedure Ta_Ecriture_AtelierAfterPost(DataSet: TDataSet);
    procedure TaEcriture_AnalAfterPost(DataSet: TDataSet);
    procedure TaPlanAnalAfterPost(DataSet: TDataSet);

    Procedure FiltrageTa_Affect_Atelier_SurCompteCourant(Compte:string;DataCompte:Tdataset);
    function AffectationExiste_SurCompte(affectation:TInfosTA_Affect_Atelier):boolean;

    procedure TaPlanAnalAfterScroll(DataSet: TDataSet);
    procedure Ta_Compte_AtelierAfterDelete(DataSet: TDataSet);
    procedure TaPlanAnalAfterCancel(DataSet: TDataSet);
    procedure TaEcriture_AnalAfterCancel(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureAfterDelete(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureAfterEdit(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureAfterPost(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureBeforeDelete(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureBeforeInsert(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureDeleteError(DataSet: TDataSet;
      E: EDatabaseError; var Action: TDataAction);
    procedure Ta_Affect_Atelier_EcriturePostError(DataSet: TDataSet;
      E: EDatabaseError; var Action: TDataAction);
    procedure Ta_Ecriture_AtelierAfterInsert(DataSet: TDataSet);
    procedure TaEcriture_AnalBeforeDelete(DataSet: TDataSet);
    procedure TaEcriture_AnalBeforeInsert(DataSet: TDataSet);
    procedure TaPlanAnalBeforeInsert(DataSet: TDataSet);
    procedure TaPlanAnalBeforeDelete(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_CompteAfterPost(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_EcritureAfterInsert(DataSet: TDataSet);
    procedure Ta_Affect_Atelier_CompteAfterInsert(DataSet: TDataSet);
    procedure TaPlanAnalAfterEdit(DataSet: TDataSet);
    function Multi_Affectation(Dataset:Tdataset;affectation:TInfosTA_Affect_Atelier):TInfosTA_Affect_Atelier;
    procedure Ta_Compte_AtelierBeforeDelete(DataSet: TDataSet);
    procedure TaEcriture_AnalAfterEdit(DataSet: TDataSet);

    function Affectation_APartir_DuCompte(Compte:String;ID_Ligne:integer;DatasetDest:Tdataset):TExceptLGR;
    procedure TaEcriture_AnalFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcriture_AnalFilterRecordAffecte(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcriture_AnalFilterRecordNonAffecte(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcriture_AnalAfterScroll(DataSet: TDataSet);
    procedure TaPlanAnalFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaPlanAnalFilterRecordAffecte(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaPlanAnalFilterRecordNonAffecte(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaPlanAnalFilterRecordEcriture(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaPlanAnalFilterRecordNonAffecteUtilise(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaPlanAnalFilterRecordAffecteUtilise(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaPlanAnalBeforeOpen(DataSet: TDataSet);
    Procedure AffecteLigneCourante;
    procedure AffecteTouteLigne(Vide:boolean);
    Procedure ViderTouteAffectationEcriture;
    procedure QuMontantEcrParAtelierCalcFields(DataSet: TDataSet);
    procedure QuMontantEcrParAtelierBeforeOpen(DataSet: TDataSet);
    procedure QuMontantEcrParAtelierFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuMontantEcrParActiviteFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    Procedure ViderTouteAffectationEcriture_SurSousSelection;
    procedure AffecteTouteLigne_SurSousSelection;

    procedure nouvelleAffectation_Ecriture(Dataset:Tdataset);
    procedure nouvelleAffectation_Compte(Dataset:Tdataset);
    procedure TaEcriture_AnalBeforeOpen(DataSet: TDataSet);
    procedure TaEcriture_AnalBeforeEdit(DataSet: TDataSet);
    procedure TaPlanAnalBeforeEdit(DataSet: TDataSet);
    procedure Ta_AtelierBeforeEdit(DataSet: TDataSet);
    procedure Ta_ActiviteBeforeEdit(DataSet: TDataSet);
//    Function GestionSuppressionRelation_Atelier_Compte(Id_Atelier:integer):boolean;
//    Function GestionSuppressionRelation_Atelier_Ecriture(Id_Atelier:integer):boolean;

  function PossibiliteSuppAtelier(idAtelier:integer):TExceptLGR;
    procedure QuMontantEcrParAtelier_EditionCalcFields(DataSet: TDataSet);
    procedure QuMontantEcrParAtelier_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuMontantEcrParActivite_EditionFilterRecord(
              DataSet: TDataSet; var Accept: Boolean);
    procedure Ta_AtelierAfterCancel(DataSet: TDataSet);
    procedure QuMontantEcrParAtelier_EditionBeforeOpen(DataSet: TDataSet);

//    procedure TaEcritureFilterRecordFilterRecord(DataSet: TDataSet;
//      var Accept: Boolean);

    //////
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    AtelierCourant:TInfosTA_Atelier;
    AffectationCourante_Compte,AffectationCourante_Ecriture,Affectation_Old:TInfosTA_Affect_Atelier;
    ListeActiviteResult,ListeAtelierResult,listeCompteResult:TStringList;
    ProcHorsFenetre:boolean;
    IdEcritureEnModif:integer;
    CompteEnModif:string;
    ListeFilterRecordEdition:TSTringlist;
    ListeFilterCompteEdition:TSTringlist;
    ProblemeExportation:boolean;
    listeAtelierSpecifique:TStringlist;
  end;
{ isa  le  24/10/03 }
    Function EditionGLivreAnalytiqueAtelierL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Atelier:TStringList;DataSet:TDataSet;Relance:integer=-1):TStringList;overload;
    Function EditionGLivreAnalytiqueAtelierL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Atelier:String;DataSet:TDataSet;Relance:integer=-1):TStringList;overload;

    Function EditionBalanceAnalytiqueAtelierL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Atelier:TStringList;DataSet:TDataSet;Relance:integer=-1):TStringList;overload;
    Function EditionBalanceAnalytiqueAtelierL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Atelier:String;DataSet:TDataSet;Relance:integer=-1):TStringList;overload;
{ isa  le  24/10/03 }

{ isa  le  21/08/2007 }
    Function EditionGLivreAnalytiqueActiviteL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Activite:TStringList;DataSet:TDataSet;Relance:integer=-1):TStringList;overload;
    Function EditionGLivreAnalytiqueActiviteL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Activite:String;DataSet:TDataSet;Relance:integer=-1):TStringList;overload;

    Function EditionBalanceAnalytiqueActiviteL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Activite:TStringList;DataSet:TDataSet;Relance:integer=-1):TStringList;overload;
    Function EditionBalanceAnalytiqueActiviteL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Activite:String;DataSet:TDataSet;Relance:integer=-1):TStringList;overload;
{ isa  le  21/08/2007 }

    function GestionSuppressionRelation_Ecriture_Atelier(id:integer;id_Atelier:integer):boolean;
    function SauvegardeAnalytiqueExo(DestPath:string='Defaut';SourcePath:string='Defaut';Table:TTable=nil):TexceptLGR;
    
{ isa  le  27/10/2009}
    Function EditionAteliersL(TypeEdition : integer; DataSet:TDataSet):Boolean;
    Function EditionActivitesL(TypeEdition : integer; DataSet:TDataSet):Boolean;
    
var
  DMAnalytiques: TDMAnalytiques;

  Function AffichActivitesExistantes(Requete:TDataset;Datasource:Tdatasource;Activite:string=''):TInfosTA_Activite;
  Function AffichAteliersExistants(Requete:TDataset;Datasource:Tdatasource;Atelier:string=''):TInfosTA_Atelier;
implementation

uses DMBalances, DMRecherche, E2_VisuListe, E2_Main, DMConstAnalytique,
  DMPlanCpt,DMExports, DMConstantes;

{$R *.DFM}

procedure TDMAnalytiques.TaEcriture_AnalCalcFields(DataSet: TDataSet);
begin
if not (VerifFNumeric(TaEcriture_AnalDebitSaisie).VideOUZero) then
  TaEcriture_AnalMontant.AsCurrency:=TaEcriture_AnalDebitSaisie.AsCurrency
else
  if not (VerifFNumeric(TaEcriture_AnalCreditSaisie).VideOUZero) then
    TaEcriture_AnalMontant.AsCurrency:=TaEcriture_AnalCreditSaisie.AsCurrency;
TaEcriture_AnalPieceAnnee.AsBoolean:=((TaEcriture_AnalDate.AsDateTime>=e.DatExoDebut)and(TaEcriture_AnalDate.AsDateTime<=e.DatExoFin));
end;

procedure TDMAnalytiques.DMAnalytiquesCreate(Sender: TObject);
begin
if ListeFilterRecordEdition= nil then ListeFilterRecordEdition:=TSTringlist.create;
if ListeFilterCompteEdition=nil then ListeFilterCompteEdition:=Tstringlist.create;
IdEcritureEnModif:=0;
CompteEnModif:='';

//if TaEcriture_Anal.IndexDefs.Find('IndexEcriture')<>nil then
//   TaEcriture_Anal.IndexName:='IndexEcriture';
OuvrirTouteTable('',TControl(self));
FiltrageDataSet(TaEcriture_Anal,CreeFiltreOU('compte',['6*','7*']));
FiltrageDataSet(TaPlanAnal,CreeFiltreOU('compte',['6*','7*']));
FormateMonnaieField(TaEcriture_Anal,E.FormatMonnaie,E.EditFormat);
FormateMonnaieField(Ta_Ecriture_Atelier,E.FormatMonnaie,E.EditFormat);

 ListeActiviteResult:=TStringList.Create;
 ListeAtelierResult:=TStringList.Create;
 listeCompteResult:=Tstringlist.Create;
    listeAtelierSpecifique:=TStringList.Create;

    listeAtelierSpecifique.Add('AQUA');
    listeAtelierSpecifique.Add('LOMB');
    listeAtelierSpecifique.Add('AROM');
    listeAtelierSpecifique.Add('CACA');
    listeAtelierSpecifique.Add('VIGN');
    listeAtelierSpecifique.Add('VINIF');
    listeAtelierSpecifique.Add('MISE');
    listeAtelierSpecifique.Add('STOCK');
    listeAtelierSpecifique.Add('COMMER');
 
end;

procedure TDMAnalytiques.DMAnalytiquesDestroy(Sender: TObject);
begin
 ListeActiviteResult.Free;
 ListeAtelierResult.Free;
 listeCompteResult.free;
 if ListeFilterRecordEdition <> nil then ListeFilterRecordEdition.free;
 if ListeFilterCompteEdition <> nil then ListeFilterCompteEdition.free;
if listeAtelierSpecifique <>nil then listeAtelierSpecifique.free;
FermerTouteTable('',TControl(self));
DMAnalytiques:=nil;
end;

procedure TDMAnalytiques.Ta_Atelier_ActiviteAfterInsert(DataSet: TDataSet);
begin
InitChampAfterInsert([AtelierCourant.ID_Atelier,AtelierCourant.ID_Activite],dataset);
end;

procedure TDMAnalytiques.Ta_AtelierAfterDelete(DataSet: TDataSet);
begin
//TableGereCommit(DataSet);
//TableGereCommit(DMBalance.TaBalance);
end;



procedure TDMAnalytiques.TaEcriture_AnalAfterOpen(DataSet: TDataSet);
begin
FormateValidCharCurrField(DataSet,['0'..'9',DecimalSeparator]);
FormateMonnaieField(DataSet,E.FormatMonnaie,'0.00');
end;

procedure TDMAnalytiques.Ta_AtelierAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
DataSet.FindField('Code_Atelier').ReadOnly:= false;
DataSet.FindField('Code_Activite').ReadOnly:= false;
DataSet.FindField('Libelle_Atelier').ReadOnly:=false;
end;

procedure TDMAnalytiques.Ta_AtelierBeforeInsert(DataSet: TDataSet);
begin
//  dataset.Fields[1].focuscontrol;
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_CompteBeforeInsert(DataSet: TDataSet);
begin
if empty(AffectationCourante_Compte.Compte) then
  abort;
end;

procedure TDMAnalytiques.Ta_Atelier_ActiviteBeforeInsert(
  DataSet: TDataSet);
begin
//dataset.Fields[2].focuscontrol;
end;

procedure TDMAnalytiques.Ta_ActiviteBeforeInsert(DataSet: TDataSet);
begin
//dataset.Fields[1].FocusControl;
end;

procedure TDMAnalytiques.Ta_AtelierDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollback(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMAnalytiques.Ta_AtelierPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollback(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;


// BeforePOST
Procedure TDMAnalytiques.Ta_AtelierBeforePost(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
Try
Initialise_ExceptLGR(CtrlSaisie);
//CtrlSaisie.NumErreur:=0;
//CtrlSaisie.Retour:=True;
Remplit_TInfosTA_Atelier(dataset,AtelierCourant);
Case DataSet.State of
   dsInsert:Begin
            dataset.FindField('Id_Atelier').asinteger:=MaxId_Query((dataset as TTable),'Id_Atelier');
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Atelier(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
                0000:Begin
                        Application.Messagebox(Pchar('L"id Atelier est vide'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
           1001,1000,1002:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle_Atelier
                //*************************************************************************
                2000:Begin
                        Application.Messagebox(Pchar('Vous devez indiquer un libellé'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement NB_Unite_Atelier
                //*************************************************************************
                3000:Begin
                        Application.Messagebox(Pchar('Vous devez indiquer un nombre d''unités'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Unite_Atelier
                //*************************************************************************
                4000:Begin
                        Application.Messagebox(Pchar('Vous devez indiquer une unité'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement ID_Activite
                //*************************************************************************
                5000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Activite
                //*************************************************************************
                6000:Begin// code vide
                        Application.MessageBox(Pchar('Vous devez saisir un code activité'),'Attention',MB_ICONWARNING);
//                        MessageDlg('Vous devez saisir un code activité', mtWarning, [mbOK], 0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                6001:Begin//code saisi non existant
                       if not (ta_activite.state =dsinsert) then
                         begin
                         if Application.MessageBox(Pchar('Cette activité n"existe pas, voulez-vous la créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                           begin
                             TableGereInsert(Ta_Activite);
//                             Ta_Activite.Insert;
                             Ta_Activite.FindField('Code_Activite').asstring:=AtelierCourant.Code_Activite;
                             abort;
                           end
                         else
                           abort;
                         end
                       else
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
// Zone Edition
   dsEdit:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Atelier(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
                0000:Begin
                        Application.Messagebox(Pchar('L"id Atelier est vide'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
           1001,1000,1002:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle_Atelier
                //*************************************************************************
                2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement NB_Unite_Atelier
                //*************************************************************************
                3000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Unite_Atelier
                //*************************************************************************
                4000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement ID_Activite
                //*************************************************************************
                5000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Activite
                //*************************************************************************
                6000:Begin// code vide
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                6001:Begin//code saisi non existant
                       if not (ta_activite.state =dsinsert) then
                         begin
                         if Application.MessageBox(Pchar('Cette activité n"existe pas, voulez-vous la créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                           begin
                             TableGereInsert(Ta_Activite);
                             //Ta_Activite.Insert;
                             Ta_Activite.FindField('Code_Activite').asstring:=AtelierCourant.Code_Activite;
                             abort;
                           end
                         else
                           abort;
                         end
                       else
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsEdit
End; // Fin du Case
Remplit_TInfosTA_Atelier(dataset,AtelierCourant);
//si AtelierCourant.ID_Activite=0, alors supprimer les relations existantes pour cet atelier
if AtelierCourant.ID_Activite=0 then
  GestionSuppressionRelation_Atelier_Activite(AtelierCourant.ID_Atelier)
else
  begin
    //remplir la table relation (ta_Activite_Atelier)
    if Ta_Atelier_Activite.Locate('ID_Atelier',AtelierCourant.ID_Atelier,[]) then
      Begin
         Ta_Atelier_Activite.edit;
         Ta_Atelier_Activite.FindField('ID_Activite').asinteger:=AtelierCourant.ID_Activite;
         Ta_Atelier_Activite.FindField('Ratio').asfloat:=1;
         TableGerePost(Ta_Atelier_Activite);
      End
    else
      Begin
         TableGereInsert(Ta_Atelier_Activite);
//         Ta_Atelier_Activite.insert;
         TableGerePost(Ta_Atelier_Activite);
      End;
  end;

Except
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
if Ta_Activite.State in [dsinsert] then
  Ta_Activite.FindField('Code_Activite').FocusControl;
abort;
End;
End;


procedure TDMAnalytiques.Ta_Affect_Atelier_CompteBeforePost_SansAffectation(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
Try
Initialise_ExceptLGR(CtrlSaisie);
//CtrlSaisie.NumErreur:=0;
//CtrlSaisie.Retour:=True;
Case DataSet.State of
   dsedit,
   dsInsert:Begin
            Remplit_TInfosTA_Affect_Atelier(dataset,AffectationCourante_compte);
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier_PourCompte(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
           1001,1000,1002:Begin
                        DataSet.Findfield('code_Atelier').FocusControl;//l'id n'est pas publié alors focus sur code
                        abort;
                     End;
                // Traitement ID_Ligne
                //*************************************************************************
           2001,2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Compte
                //*************************************************************************
           3001,3000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle
                //*************************************************************************
                4000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
                5000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                5001:begin//code non existant et <> de '*'
//                       if Application.MessageBox(Pchar('Cet atelier n"existe pas, voulez-vous le créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
//                           Ta_Atelier.Insert;
//                           Ta_Atelier.FindField('Code_Atelier').asstring:=AffectationCourante.Code_Atelier;
//                           abort;
//                         end
//                       else
//                        abort;
                       //afficher fenetre de création des ateliers
                        Application.Messagebox(Pchar('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités'),'Erreur de saisie',0);
                        abort;
                     end;
                // Traitement Ratio
                //*************************************************************************
                6000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//            For I:=0 to DataSet.FieldCount-1 do
//              begin
//               try
//                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier(DataSet.Fields[i]);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//           0001,0000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//           1001,1000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Compte
//                //*************************************************************************
//           2001,2000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Libelle
//                //*************************************************************************
//                3000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//           4001,4000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Ratio
//                //*************************************************************************
//                5000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//              End; // Fin du begin de boucle For
//            End; // Fin Begin du dsEdit
End; // Fin du Case
Remplit_TInfosTA_Affect_Atelier(dataset,AffectationCourante_compte);
Except
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
abort;
End;
End;


procedure TDMAnalytiques.Ta_Affect_Atelier_CompteBeforePost_AvecAffectation(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
Filtre:TFiltre;
begin
TableGereStartTransaction(dataset);
Initialise_ExceptLGR(CtrlSaisie);
//CtrlSaisie.NumErreur:=0;
//CtrlSaisie.Retour:=True;
Try
Case DataSet.State of
   dsedit,
   dsInsert:Begin
            CtrlSaisieTA_Affect_Atelier_PourCompte(DataSet.FieldByName('Code_atelier'));
            Remplit_TInfosTA_Affect_Atelier(dataset,AffectationCourante_compte);
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier_PourCompte(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
      1001,1000,1002:Begin
                        DataSet.Findfield('code_Atelier').FocusControl;//l'id n'est pas publié alors focus sur code
                        abort;
                     End;
                // Traitement ID_Ligne
                //*************************************************************************
      2001,2000,2002:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Compte
                //*************************************************************************
      3001,3000,3002:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle
                //*************************************************************************
                4000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
           5000,5002:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                5001:begin//code non existant et <> de '*'
//                       if Application.MessageBox(Pchar('Cet atelier n"existe pas, voulez-vous le créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
//                           Ta_Atelier.Insert;
//                           Ta_Atelier.FindField('Code_Atelier').asstring:=AffectationCourante.Code_Atelier;
//                           abort;
//                         end
//                       else
//                        abort;
                       //afficher fenetre de création des ateliers
                        Application.Messagebox(Pchar('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités'),'Erreur de saisie',0);
                        abort;
                     end;
                // Traitement Ratio
                //*************************************************************************
                6000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//            For I:=0 to DataSet.FieldCount-1 do
//              begin
//               try
//                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier(DataSet.Fields[i]);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//           0001,0000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//           1001,1000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Compte
//                //*************************************************************************
//           2001,2000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Libelle
//                //*************************************************************************
//                3000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//           4001,4000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Ratio
//                //*************************************************************************
//                5000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//              End; // Fin du begin de boucle For
//            End; // Fin Begin du dsEdit
End; // Fin du Case
Remplit_TInfosTA_Affect_Atelier(dataset,AffectationCourante_compte);
//Ecrire l'affectation courante dans la table de relation (Ta_Compte_Atelier)
case DataSet.State of
dsinsert:Begin
              TableGereInsert(Ta_Compte_Atelier);
//           Ta_Compte_Atelier.insert;
           TableGerePost(Ta_Compte_Atelier);
         End;
  dsedit:Begin
           if Affectation_Old.Compte=AffectationCourante_compte.Compte then
             begin
             Filtre.filtre:=Ta_Compte_Atelier.Filter;
             Filtre.filtrer:=Ta_Compte_Atelier.Filtered;
             FiltrageDataSet(Ta_Compte_Atelier,'Compte='''+AffectationCourante_compte.Compte+''' and ID_Atelier='''+inttostr(Affectation_Old.ID_Atelier)+'''');
             Ta_Compte_Atelier.edit;
             Ta_Compte_Atelier.FindField('ID_Atelier').asinteger:=AffectationCourante_compte.ID_Atelier;
             DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
             AffectationCourante_compte.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'ID_Atelier',[Ta_Compte_Atelier.FindField('ID_Atelier').AsString]).Libelle_Atelier;
             Ta_Compte_Atelier.FindField('Libelle').asstring:=AffectationCourante_compte.Libelle;
             Ta_Compte_Atelier.FindField('Ratio').AsFloat:=AffectationCourante_compte.Ratio;
             TableGerePost(Ta_Compte_Atelier);
             if ((Filtre.filtrer)and(not empty(Filtre.filtre)))then
               FiltrageDataSet(Ta_Compte_Atelier,filtre.filtre)
             else
               DeFiltrageDataSet(Ta_Compte_Atelier);
             end
           else
             begin
               showmessage(ErrInterne+' : Affectation Courante <> Affectation Old!');
               abort;
             end;
         End;
end;//fin du case state
Except
//TableGereRollBack(DataSet);
//TableGereRollBack(DMBalance.TaBalance);
abort;
End;
End;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureBeforePost_AvecAffectation(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
filtre:TFiltre;
begin
TableGereStartTransaction(dataset);
Try
Initialise_ExceptLGR(CtrlSaisie);
//CtrlSaisie.NumErreur:=0;
//CtrlSaisie.Retour:=True;
Case DataSet.State of
   dsedit,
   dsInsert:Begin
            CtrlSaisieTA_Affect_Atelier_PourEcriture(DataSet.Fields[4]);
            Remplit_TInfosTA_Affect_Atelier(dataset,AffectationCourante_Ecriture);
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier_PourEcriture(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
      1001,1000,1002:Begin
                        DataSet.Findfield('code_Atelier').FocusControl;//
                        abort;
                     End;
                // Traitement ID_Ligne
                //*************************************************************************
      2001,2000,2002:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Compte
                //*************************************************************************
      3001,3000,3002:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle
                //*************************************************************************
                4000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
           5000,5002:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                5001:begin//code non existant et <> de '*'
//                       if Application.MessageBox(Pchar('Cet atelier n"existe pas, voulez-vous le créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
//                           Ta_Atelier.Insert;
//                           Ta_Atelier.FindField('Code_Atelier').asstring:=AffectationCourante.Code_Atelier;
//                           abort;
//                         end
//                       else
//                        abort;
                       //afficher fenetre de création des ateliers
                        Application.Messagebox(Pchar('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités'),'Erreur de saisie',0);
                        abort;
                     end;
                // Traitement Ratio
                //*************************************************************************
                6000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//            For I:=0 to DataSet.FieldCount-1 do
//              begin
//               try
//                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier(DataSet.Fields[i]);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//           0001,0000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//           1001,1000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Compte
//                //*************************************************************************
//           2001,2000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Libelle
//                //*************************************************************************
//                3000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//           4001,4000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Ratio
//                //*************************************************************************
//                5000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//              End; // Fin du begin de boucle For
//            End; // Fin Begin du dsEdit
End; // Fin du Case
Remplit_TInfosTA_Affect_Atelier(dataset,AffectationCourante_Ecriture);
//Ecrire l'affectation courante dans la table de relation (Ta_Compte_Atelier)
case DataSet.State of
dsinsert:Begin
           TableGereInsert(Ta_Ecriture_Atelier);
//           Ta_Ecriture_Atelier.insert;
           TableGerePost(Ta_Ecriture_Atelier);
         End;
  dsedit:Begin
           if Affectation_Old.ID_Ligne=AffectationCourante_Ecriture.ID_Ligne then
             begin
             Filtre.filtre:=Ta_Ecriture_Atelier.Filter;
             Filtre.filtrer:=Ta_Ecriture_Atelier.Filtered;
             FiltrageDataSet(Ta_Ecriture_Atelier,'id_Ligne='''+inttostr(AffectationCourante_Ecriture.ID_Ligne)+''' and ID_Atelier='''+inttostr(Affectation_Old.ID_Atelier)+'''');
             Ta_Ecriture_Atelier.edit;
             Ta_Ecriture_Atelier.FindField('ID_Atelier').asinteger:=AffectationCourante_Ecriture.ID_Atelier;
             DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
             AffectationCourante_Ecriture.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'ID_Atelier',[DataSet.findfield('ID_Atelier').AsString]).Libelle_Atelier;
             Ta_Ecriture_Atelier.FindField('Libelle').asstring:=AffectationCourante_Ecriture.Libelle;
             Ta_Ecriture_Atelier.FindField('Ratio').AsFloat:=AffectationCourante_Ecriture.Ratio;
             TableGerePost(Ta_Ecriture_Atelier);
             if ((Filtre.filtrer)and(not empty(Filtre.filtre)))then
               FiltrageDataSet(Ta_Ecriture_Atelier,filtre.filtre)
             else
               DeFiltrageDataSet(Ta_Ecriture_Atelier);
             end
           else
             begin
               showmessage(ErrInterne+' : Affectation Courante <> Affectation Old!');
               abort;
             end;
         End;
end;//fin du case state
Except
//TableGereRollBack(DataSet);
//TableGereRollBack(DMBalance.TaBalance);
abort;
End;
End;


procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureBeforePost_SansAffectation(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
Try
Initialise_ExceptLGR(CtrlSaisie);
Case DataSet.State of
   dsedit,
   dsInsert:Begin
//            CtrlSaisieTA_Affect_Atelier_PourEcriture(DataSet.Fields[5]);
            Remplit_TInfosTA_Affect_Atelier(dataset,AffectationCourante_Ecriture);
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier_PourEcriture(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
           1001,1000:Begin
                        DataSet.Findfield('code_Atelier').FocusControl;
                        abort;
                     End;
                // Traitement ID_Ligne
                //*************************************************************************
           2001,2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Compte
                //*************************************************************************
           3001,3000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle
                //*************************************************************************
                4000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
                5000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                5001:begin//code non existant et <> de '*'
//                       if Application.MessageBox(Pchar('Cet atelier n"existe pas, voulez-vous le créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
//                           Ta_Atelier.Insert;
//                           Ta_Atelier.FindField('Code_Atelier').asstring:=AffectationCourante.Code_Atelier;
//                           abort;
//                         end
//                       else
//                        abort;
                       //afficher fenetre de création des ateliers
                        Application.Messagebox(Pchar('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités'),'Erreur de saisie',0);
                        abort;
                     end;
                // Traitement Ratio
                //*************************************************************************
                6000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//            For I:=0 to DataSet.FieldCount-1 do
//              begin
//               try
//                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier(DataSet.Fields[i]);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//           0001,0000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//           1001,1000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Compte
//                //*************************************************************************
//           2001,2000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Libelle
//                //*************************************************************************
//                3000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//           4001,4000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Ratio
//                //*************************************************************************
//                5000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//              End; // Fin du begin de boucle For
//            End; // Fin Begin du dsEdit
End; // Fin du Case
Remplit_TInfosTA_Affect_Atelier(dataset,AffectationCourante_Ecriture);
Except
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
abort;
End;
End;


procedure TDMAnalytiques.Ta_Atelier_ActiviteBeforePost(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
Try
Initialise_ExceptLGR(CtrlSaisie);
//CtrlSaisie.NumErreur:=0;
//CtrlSaisie.Retour:=True;
Case DataSet.State of
   dsInsert:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Atelier_Activite(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
                0000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
                     End;
                // Traitement ID_Activite
                //*************************************************************************
           1001,1000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Ratio
                //*************************************************************************
                2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
// Zone Edition
   dsEdit:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Atelier_Activite(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
                0000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
                     End;
                // Traitement ID_Activite
                //*************************************************************************
           1001,1000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Ratio
                //*************************************************************************
                2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsEdit
End; // Fin du Case
// il n'y a pas d'id à générer sur cette table
Except
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
abort;
End;
End;





procedure TDMAnalytiques.Ta_ActiviteBeforePost(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
Try
Initialise_ExceptLGR(CtrlSaisie);
Case DataSet.State of
   dsInsert:Begin
            dataset.FindField('id_Activite').asinteger:=MaxId_Query((dataset as TTable),'id_Activite');     
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Activite(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Activite
                //*************************************************************************
                0000:Begin
                        Application.Messagebox(Pchar('L"id activite est vide'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Activite
                //*************************************************************************
                1000,1001:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle_Activite
                //*************************************************************************
                2000:Begin
                        Application.Messagebox(Pchar('Vous devez indiquer un libellé'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
// Zone Edition
   dsEdit:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Activite(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Activite
                //*************************************************************************
                0000:Begin
                        Application.Messagebox(Pchar('L"id activite est vide'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Code_Activite
                //*************************************************************************
                1000,1001:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle_Activite
                //*************************************************************************
                2000:Begin
                        Application.Messagebox(Pchar('Vous devez indiquer un libellé'),'Erreur de saisie',0);
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
abort;
End;
End;

procedure TDMAnalytiques.Ta_ActiviteAfterInsert(DataSet: TDataSet);
begin  
InitChampAfterInsert([null,AtelierCourant.Code_Activite],dataset);
end;

procedure TDMAnalytiques.Ta_AtelierBeforeDelete(DataSet: TDataSet);
var
affichemess:boolean;
begin
try
affichemess:=true;

if not PossibiliteSuppAtelier(DataSet.FindField('id_atelier').asinteger).retour then
  begin
    affichemess:=false;
    abort;
  end
else
  Begin
     FiltrageDataSet(DMRech.TaTA_Atelier_ActiviteRech,CreeFiltreOU('id_atelier',[DataSet.FindField('id_atelier').asstring]));
     if DMRech.TaTA_Atelier_ActiviteRech.RecordCount<>0 then
        Begin
          if Application.MessageBox(Pchar('Cet atelier est lié à une ou plusieurs activité(s), '+#10#13+'si vous le supprimer, toutes ces relations seront également supprimées, '+#10#13+'voulez_vous continuer  ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
            begin
            if not GestionSuppressionRelation_Atelier_Activite(DataSet.FindField('id_atelier').asinteger) then
               abort;
            end
          else
            begin
             affichemess:=false;
             abort;
            end;
        End
    else
     if not GestionSuppressionRelation_Atelier_Activite(DataSet.FindField('id_atelier').asinteger) then
        abort;
  End;
except
  if affichemess then
    Application.Messagebox(Pchar(ErrInterne+' : Ta_AtelierBeforeDelete'),Pchar(ErrInterne),0);
  abort;
end;
end;


procedure TDMAnalytiques.Ta_Affect_Atelier_CompteBeforeDelete(DataSet: TDataSet);
var
Filtre:TFiltre;
EventRecord:TFilterRecordEvent;
CompteCourant:string;
begin
//vérifier si pas existant dans autres tables
//si oui ABORT
try
TableGereStartTransaction(dataset);
TableGereStartTransaction(DMBalance.TaBalance);
Remplit_TInfosTA_Affect_Atelier(dataset,Affectation_Old);
filtre.filtre:=Ta_Compte_Atelier.filter;
filtre.filtrer:=Ta_Compte_Atelier.filtered;
FiltrageDataSet(Ta_Compte_Atelier,CreeFiltreou('Compte',[Affectation_Old.Compte]));
CompteCourant:=TaPlanAnalCompte.AsString ;
if Ta_Compte_Atelier.Locate('id_Atelier',Affectation_Old.ID_Atelier,[]) then
  TableGereDelete(Ta_Compte_Atelier);
if Ta_Compte_Atelier.RecordCount= 0 then
//supprimer l'affection dans DmPlanAnal
  begin
    try
    EventRecord:=TaPlanAnal.OnFilterRecord;
    TaPlanAnal.OnFilterRecord:=nil;
    if not (TaPlanAnal.State in [dsinsert,dsedit]) then
     begin
       if not TaPlanAnal.locate('compte',comptecourant,[])then
         abort;
       TaPlanAnal.Edit;
     end;
     TaPlanAnal.FindField('ID_Gestanal').asstring:='';
     TaPlanAnal.FindField('Code_Gestanal').asstring:='';
     TableGerePost(TaPlanAnal);
    finally
         TaPlanAnal.OnFilterRecord:=EventRecord;
         TaPlanAnal.Locate('Compte',CompteCourant,[]);
    end;
  end;
finally
  if ((filtre.filtrer)and(not empty(filtre.filtre)))then
    FiltrageDataSet(Ta_Compte_Atelier,filtre.filtre)
  else
    DeFiltrageDataSet(Ta_Compte_Atelier);
end;
end;

procedure TDMAnalytiques.Ta_Atelier_ActiviteBeforeDelete(
  DataSet: TDataSet);
begin
//vérifier si pas existant dans autres tables
//si oui ABORT
end;

procedure TDMAnalytiques.Ta_ActiviteBeforeDelete(DataSet: TDataSet);
var
activiteCourante:TInfosTA_Activite;
affichemess:boolean;
begin
try
affichemess:=true;
FiltrageDataSet(DMRech.TaTA_Atelier_ActiviteRech,CreeFiltreOU('id_activite',[Ta_Activite.FindField('id_activite').asstring]));
if DMRech.TaTA_Atelier_ActiviteRech.RecordCount<>0 then
//  if Application.MessageBox(Pchar('Cette activité est liée à un ou plusieurs ateliers, '+#10#13+'si vous la supprimer, ces relations seront également supprimées, '+#10#13+'voulez_vous continuer  ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//    Begin
//      //gestion suppression dans table atelier
//      Remplit_TInfosTA_Activite(dataset,activiteCourante);
//      if not GestionSuppressionActivite(activiteCourante) then
//        begin
//         affichemess:=false;
//         abort;
//        end;
//    End
//  else
  begin
//    Application.MessageBox(Pchar(','Attention');
    Application.MessageBox(Pchar('Cette activité est liée à un ou plusieurs ateliers, '+#13+#10+'Vous devez modifier ces affectation avant de pouvoir supprimer '+#13+#10+'cette activité !'),'Attention',MB_ICONWARNING);
    //MessageDlg('Cette activité est liée à un ou plusieurs ateliers, '+#13+#10+'Vous devez modifier ces affectation avant de pouvoir supprimer '+#13+#10+'cette activité !', mtWarning, [mbOK], 0);
    affichemess:=false;
    abort;
  end;
except
  if affichemess then
    Application.Messagebox(Pchar(ErrInterne+' : Ta_ActiviteBeforeDelete'),Pchar(ErrInterne),0);
  abort;
end;
end;


// Controle de Saisie de la table TA_Atelier
Function TDMAnalytiques.CtrlSaisieTA_Atelier(CCourant:TField):TExceptLGR;
var
Activite:TInfosTA_Activite;
InfosAtelierDefaut:TInfosAtelierDefaut;
active:boolean;
begin
Try
Initialise_ExceptLGR(Result);
if(DMConstAnal=nil)then DMConstAnal:=TDMConstAnal.Create(application.MainForm);
//Result.NumErreur:=0;
//Result.Retour:=True;
Case CCourant.DataSet.State of
     dsInsert,
     dsedit:Begin
             case CCourant.Index of
                // Traitement ID_Atelier
                //*************************************************************************
                0:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement Code_Atelier
                //*************************************************************************
                1:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Vous devez indiquer un code d''atelier',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                  else
                     begin//si code rempli
                       case CCourant.DataSet.State of
                          dsinsert:// Si l'utilisateur a saisie un code Atelier qui existe déjà
                             begin
                             DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                             if Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,CCourant.FieldName,[CCourant.AsString]).ResultInfos then
                                 begin
                                   raise ExceptLGR.Create('Ce code atelier existe déjà !',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
                                 end;
                             end;
                          dsEdit:begin
                                  FiltrageDataSet(DMRech.TaTA_AtelierRech,CCourant.FieldName+'='''+CCourant.AsString+ ''' and ID_Atelier <> '''+CCourant.DataSet.FindField('ID_Atelier').AsString+'''');
                                  if Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,CCourant.FieldName,[CCourant.AsString]).ResultInfos then
                                        begin
                                          raise ExceptLGR.Create('Ce code atelier existe déjà !',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
                                        end;
                                  DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                                 end;
                       end;//fin du case
                       case e.TypeClient of
                       CL_Cogere:begin    //,CL_Saisie_Cogere
                       active := not ((VersionMaintenance) or (E.Regime= 'I'));
                                   if ((active)and(not (DMConstAnal.ExisteDansCodeAtelierDefaut(Ccourant.AsString)))) then
                                     begin
                                       raise ExceptLGR.Create('Ce code atelier ne fait pas partie des codes par défaut à utiliser. '+#13+#10+''+#13+#10+'Appuyez sur F1 pour afficher cette liste!',StrToInt_Lgr(inttostr(CCourant.Index)+'002'),true,mtError,result);
                                     end;
                                   case CCourant.DataSet.State of
                                   dsinsert:begin
                                               InfosAtelierDefaut:=Infos_TInfosAtelierDefaut(dmrech.TaAtelierDefautRech,'Code_Atelier',[ccourant.asstring]);
                                               if empty(CCourant.dataset.FindField('Code_Activite').AsString) then
                                                 CCourant.dataset.FindField('Code_Activite').AsString:=InfosAtelierDefaut.Code_Activite;
                                               if empty(CCourant.dataset.FindField('Code_Activite').asstring) then
                                                 CCourant.dataset.FindField('Unite_Atelier').AsString:= str_GetStringElement(InfosAtelierDefaut.Divers,1,';');

                                            end;
                                   end;//fin du case
                                 end;
                       end;//fin du case typeclient
                     end;//fin si code rempli
                  End;
                // Traitement Libelle_Atelier
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement NB_Unite_Atelier
                //*************************************************************************
                3:Begin
                  if ((VerifFNumeric(CCourant).VideOUZero)and(not empty(CCourant.DataSet.Fields[4].asstring))) then//si nb unite vide, mais unite remplie,
                  //alors demander à saisir une valeur
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement Unite_Atelier
                //*************************************************************************
                4:Begin
                  if ((Empty(CCourant.AsString))and(not VerifFNumeric(CCourant.DataSet.Fields[3]).VideOUZero)) then
                  //si unite vide mais nb unite rempli, alors demander à remplir l'unite
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
                  else
                  if not Empty(CCourant.AsString)then
                     begin// vérifier cohérence de l'unité saisie

                     end;
                  End;
                // Traitement ID_Activite
                //*************************************************************************
                5:Begin
//                   if ((not VerifFNumeric(CCourant).VideOUZero)and(empty(CCourant.DataSet.Fields[6].asstring))) then
//                      Begin//si ID_Activite remplie, vérifier cohérence
//                        Activite:=Infos_TInfosTA_Activite(DMRech.TaTA_ActiviteRech,CCourant.FieldName,[CCourant.asinteger]);
//                        if ((not Activite.ResultInfos)and(CCourant.DataSet.Fields[6].asstring<>'*')) then
//                           raise ExceptLGR.Create('Cet ID Activite n''existe pas !',StrToInt_Lgr(inttostr(CCourant.Index)+'000'),true,mtError,result)
//                        else
//                         if Activite.ResultInfos then
//                           Begin //si ok, remplir le Code_Activite correspondant
//                             CCourant.DataSet.Fields[6].asstring:=Activite.Code_Activite;
//                           End;
//                      End;//fin si ID_Activite remplie
                  End;
                // Traitement Code_Activite
                //*************************************************************************
                6:Begin
                  if Empty(CCourant.AsString) then
                      //CCourant.DataSet.Fields[5].asstring:=''
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
                  else
                    Begin//si Code_Activite remplie, vérifier cohérence
                      DeFiltrageDataSet(DMRech.TaTA_ActiviteRech);
                      Activite:=Infos_TInfosTA_Activite(DMRech.TaTA_ActiviteRech,CCourant.FieldName,[CCourant.AsString]);
                      if ((not Activite.ResultInfos)and(CCourant.AsString<>'*')) then
                         raise ExceptLGR.Create(' !',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result)
                      else
                        if Activite.ResultInfos then
                         Begin //si ok, remplir l'id_activite correspondante
                           CCourant.DataSet.Fields[5].AsInteger:=Activite.ID_Activite;
                         End
                        else
                          if CCourant.AsString='*' then CCourant.DataSet.Fields[5].AsInteger:=0;
                    End;//fin si Code_Activite remplie
                  End;
             End; // Fin du case
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//             case CCourant.Index of
//                // Traitement ID_Atelier
//                //*************************************************************************
//                0:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//                1:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Libelle_Atelier
//                //*************************************************************************
//                2:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement NB_Unite_Atelier
//                //*************************************************************************
//                3:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Unite_Atelier
//                //*************************************************************************
//                4:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement ID_Activite
//                //*************************************************************************
//                5:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Code_Activite
//                //*************************************************************************
//                6:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//             End; // Fin du case
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
  abort;
End;
End;


// Controle de Saisie
Function TDMAnalytiques.CtrlSaisieTA_Atelier_Activite(CCourant:TField):TExceptLGR;
begin
Try
//Result.NumErreur:=0;
//Result.Retour:=True;
Initialise_ExceptLGR(Result);
Case CCourant.DataSet.State of
   dsInsert,
   dsedit  :Begin
             case CCourant.Index of
                // Traitement ID_Atelier
                //*************************************************************************
                0:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('l''ID_Atelier est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                  else
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     //si ID_Atelier rempli, alors vérifier existence l'ID_Atelier
                     DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                     if Ta_Atelier.State in [dsinsert,dsedit] then
                       begin
                          if Ta_Atelier.FindField('id_atelier').asinteger<>CCourant.asinteger then
                             CCourant.asinteger:=Ta_Atelier.FindField('id_atelier').asinteger;
                            //Raise ExceptLGR.Create('L"ID_Atelier saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                       end
                     else
                       Begin
                          if not Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,CCourant.FieldName,[CCourant.asinteger]).ResultInfos then
                            raise ExceptLGR.Create('L"ID_Atelier saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                       End;
                     end;
                  End;
                // Traitement ID_Activite
                //*************************************************************************
                1:Begin
                  DeFiltrageDataSet(DMRech.TaTA_ActiviteRech);
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('l''ID_Activite est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                  else
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     //si ID_Activite rempli, alors vérifier existence l'ID_Activite
                     if not Infos_TInfosTA_Activite(DMRech.TaTA_ActiviteRech,CCourant.FieldName,[CCourant.asinteger]).ResultInfos then
                       raise ExceptLGR.Create('L"ID_Activite saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                     end;
                 End;
                // Traitement Ratio
                //*************************************************************************
                2:Begin
                  if VerifFNumeric(CCourant).VideOUZero then
                     ccourant.AsInteger:=1;
                     //raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                  End;
             End; // Fin du case
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//             case CCourant.Index of
//                // Traitement ID_Atelier
//                //*************************************************************************
//                0:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement ID_Activite
//                //*************************************************************************
//                1:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Ratio
//                //*************************************************************************
//                2:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//             End; // Fin du case
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
  abort;
End;
End;



procedure TDMAnalytiques.Ta_Atelier_ActiviteAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
end;

procedure TDMAnalytiques.Ta_Atelier_ActiviteAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
end;

procedure TDMAnalytiques.Ta_Atelier_ActiviteDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollback(DataSet);
TableGereRollBack(DMBalance.TaBalance);

end;

procedure TDMAnalytiques.Ta_Atelier_ActivitePostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollback(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;


Function AffichActivitesExistantes(Requete:TDataset;Datasource:Tdatasource;Activite:string):TInfosTA_Activite;
Begin
  try
    Initialise_TInfosTA_Activite(result);
    if VisuListe = nil then VisuListe:=TVisuListe.Create(Application.MainForm);
    if DMAnalytiques = nil then DMAnalytiques:=TDMAnalytiques.Create(application.MainForm);

    VisuListe.BtnDetail.OnClick:=nil;
    VisuListe.PaGrille.OnResize:=DMAnalytiques.PaGrilleResize_VisuListe;
    VisuListe.BtnEnregistrer.OnClick:=VisuListe.BtnEnregistrerClick;
    VisuListe.GrDBVisu.OnDblClick:=VisuListe.BtnEnregistrerClick;
    VisuListe.Enregister1.OnClick:=VisuListe.BtnEnregistrerClick;

    VisuListe.OnKeyDown:=DMAnalytiques.FormKeyDown_VisuListe;
    VisuListe.BtnEnregistrer.visible:=true;
    VisuListe.Enregister1.visible:=true;

    VisuListe.RxLabTitre.Caption:='Liste des activités existantes';
    VisuListe.PaTitrePetit.Caption:='Activités à sélectionner';

    VisuListe.GrDBVisu.DefaultDrawing:=False;
    GrDbGridInitColonne(VisuListe.GrDBVisu,Datasource,Requete,
                       ['Code Activite','Libelle de l"Activite'],
                       ['Code_Activite','Libelle_Activite'],E.FormatMonnaie,E.EditFormat);
    if Activite<>'' then VisuListe.GrDBVisu.DataSource.DataSet.Locate('Code_Activite',Activite,[loCaseInsensitive,loPartialKey]);

    if VisuListe.Showmodal=mrok then
     Remplit_TInfosTA_Activite(Requete,result)
    else
     result.ResultInfos:=false;
  except
    Result.ResultInfos:=false;
  end;//fin du try finally
End;



procedure TDMAnalytiques.Ta_ActiviteAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
if Ta_Atelier.State in [dsinsert,dsedit] then
  TableGerePost(Ta_Atelier);
end;

procedure TDMAnalytiques.Ta_ActiviteAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
end;


// Controle de Saisie
Function TDMAnalytiques.CtrlSaisieTA_Activite(CCourant:TField):TExceptLGR;
begin
Try
//Result.NumErreur:=0;
//Result.Retour:=True;
Initialise_ExceptLGR(Result);
Case CCourant.DataSet.State of
   dsInsert:Begin
             case CCourant.Index of
                // Traitement ID_Activite
                //*************************************************************************
                0:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement Code_Activite
                //*************************************************************************
                1:Begin
                  DeFiltrageDataSet(DMRech.TaTA_ActiviteRech);
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Vous devez indiquer un code d"activité',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                  else
                     begin//si code rempli
                       case CCourant.DataSet.State of
                          dsinsert:// Si l'utilisateur a saisie un code activité qui existe déjà
                             if Infos_TInfosTA_Activite(DMRech.TaTA_ActiviteRech,CCourant.FieldName,[CCourant.AsString]).ResultInfos then
                                 begin
                                   raise ExceptLGR.Create('Ce code activité existe déjà !',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
                                 end;
                       end;//fin du case
                     end;//fin si code rempli
                  End;
                // Traitement Libelle_Activite
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
             End; // Fin du case
            End; // Fin Begin du dsInsert
// Zone Edition
   dsEdit:Begin
             case CCourant.Index of
                // Traitement ID_Activite
                //*************************************************************************
                0:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement Code_Activite
                //*************************************************************************
                1:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Vous devez indiquer un code d''activité',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                  else
                     begin//si code rempli
                       case CCourant.DataSet.State of
                          dsEdit:begin
                                  FiltrageDataSet(DMRech.TaTA_ActiviteRech,CCourant.FieldName+'='''+CCourant.AsString+ ''' and ID_Activite <> '''+CCourant.DataSet.FindField('ID_Activite').AsString+'''');
                                  if Infos_TInfosTA_Atelier(DMRech.TaTA_ActiviteRech,CCourant.FieldName,[CCourant.AsString]).ResultInfos then
                                        begin
                                          raise ExceptLGR.Create('Ce code activité existe déjà !',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),true,mtError,result);
                                        end;
                                  DeFiltrageDataSet(DMRech.TaTA_ActiviteRech);
                                 end;
                       end;//fin du case
                     end;//fin si code rempli
                  End;
                // Traitement Libelle_Activite
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
             End; // Fin du case
            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
  abort;
End;
End;

function TDMAnalytiques.GestionSuppressionActivite(Activite:TInfosTA_Activite):boolean;
Begin
  try//finally
    try//except
     result:=true;
     Ta_Atelier.DisableControls;
//     FiltrageDataSet(Ta_Atelier,CreeFiltreOU('id_activite',[Activite.ID_Activite]));
     Ta_Atelier.first;
     while not Ta_Atelier.EOF do
       Begin
          if Ta_Atelier.FindField('ID_Activite').asinteger=Activite.ID_Activite then
            Begin
               Ta_Atelier.edit;
               Ta_Atelier.FindField('ID_Activite').Asstring:='';
               Ta_Atelier.FindField('Code_Activite').Asstring:='';
               TableGerePost(Ta_Atelier);
            End;
         Ta_Atelier.Next;
       End;
    except
       result:=false;
    end;
  finally
//    DeFiltrageDataSet(Ta_Atelier);
    Ta_Atelier.EnableControls;
  end;
End;

function TDMAnalytiques.GestionSuppressionRelation_Atelier_Activite(ID_Atelier:integer):boolean;
Begin
  try//finally
    try//except
     result:=true;
     //executer la requete de suppression des relations sur id
     QuSupp_Atelier_Activite.Close;
     QuSupp_Atelier_Activite.ParamByName('id').asinteger:=ID_Atelier;
     QuSupp_Atelier_Activite.ExecSQL;
    except
       result:=false;
    end;
  finally
     QuSupp_Atelier_Activite.close;
     ProcHorsFenetre:=false;
  end;
End;



// Controle de Saisie
Function TDMAnalytiques.CtrlSaisieTA_Ecriture_Atelier(CCourant:TField):TExceptLGR;
begin
Try
//Result.NumErreur:=0;
//Result.Retour:=True;
Initialise_ExceptLGR(Result);
Case CCourant.DataSet.State of
   dsedit,
   dsInsert:Begin
             case CCourant.Index of
                // Traitement ID_Ligne
                //*************************************************************************
                0:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('L"id_Ligne est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                  else
                  //vérifier existence de l'id_ligne
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     DeFiltrageDataSet(DMRech.TaEcritureRech);
                     //si id_ligne rempli, alors vérifier existence de l'id_ligne
                     if not Infos_TInfosEcriture(DMRech.TaEcritureRech,'id',[CCourant.asinteger]).ResultInfos then
                       raise ExceptLGR.Create('L"id_ligne saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                     end;
                  End;
                // Traitement ID_Atelier
                //*************************************************************************
                1:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('L"ID_Atelier est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                  else
                  //vérifier existence de l'ID_Atelier
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     //si ID_Atelier rempli, alors vérifier existence de l'ID_Atelier
                     DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                     if not Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'id_Atelier',[CCourant.asinteger]).ResultInfos then
                       raise ExceptLGR.Create('L"ID_Atelier saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                     end;
                  End;
                // Traitement Libelle
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement Ratio
                //*************************************************************************
                3:Begin
                  if VerifFNumeric(CCourant).Vide then
                     ccourant.asfloat:=1;
                     //raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                  End;
             End; // Fin du case
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//             case CCourant.Index of
//                // Traitement ID_Ligne
//                //*************************************************************************
//                0:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement ID_Atelier
//                //*************************************************************************
//                1:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Ratio
//                //*************************************************************************
//                2:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//             End; // Fin du case
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
  abort;
End;
End;


procedure TDMAnalytiques.Ta_Ecriture_AtelierBeforePost(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
Try
Initialise_ExceptLGR(CtrlSaisie);
TableGereStartTransaction(dataset);
Case DataSet.State of
   dsInsert:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Ecriture_Atelier(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Ligne
                //*************************************************************************
           0001,0000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement ID_Atelier
                //*************************************************************************
           1001,1000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Ratio
                //*************************************************************************
                2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
// Zone Edition
   dsEdit:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Ecriture_Atelier(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Ligne
                //*************************************************************************
           0001,0000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement ID_Atelier
                //*************************************************************************
           1001,1000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Ratio
                //*************************************************************************
                2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
abort;
End;
End;

// Controle de Saisie
Function TDMAnalytiques.CtrlSaisieTA_Compte_Atelier(CCourant:TField):TExceptLGR;
begin
Try
//Result.NumErreur:=0;
//Result.Retour:=True;
Initialise_ExceptLGR(Result);
Case CCourant.DataSet.State of
   dsedit,
   dsInsert:Begin
             case CCourant.Index of
                // Traitement Compte
                //*************************************************************************
                0:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Le Compte est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  else
//                  //vérifier existence du Compte
//                  if not (VerifFNumeric(CCourant).VideOUZero) then
//                     begin
                     //si Compte rempli, alors vérifier existence du Compte
                     DeFiltrageDataSet(DMRech.TaplancptRech);
                     if not Infos_TInfosplancpt(DMRech.TaplancptRech,'Compte',[CCourant.asstring]).ResultInfos then
                       raise ExceptLGR.Create('Le Compte saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                     //end;
                     End;
                // Traitement ID_Atelier
                //*************************************************************************
                1:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('l''ID_Atelier est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                  else
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     //si ID_Atelier rempli, alors vérifier existence l'ID_Atelier
                     DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                     if not Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,CCourant.FieldName,[CCourant.asinteger]).ResultInfos then
                       raise ExceptLGR.Create('L"ID_Atelier saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                     end;
                  End;
                // Traitement Libelle
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement Ratio
                //*************************************************************************
                3:Begin
                  if Empty(CCourant.AsString) then
                     CCourant.AsInteger:=1;
                     //raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                  End;
             End; // Fin du case
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//             case CCourant.Index of
//                // Traitement Compte
//                //*************************************************************************
//                0:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement ID_Atelier
//                //*************************************************************************
//                1:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Libelle
//                //*************************************************************************
//                2:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Ratio
//                //*************************************************************************
//                3:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//             End; // Fin du case
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
  abort;
End;
End;


procedure TDMAnalytiques.Ta_Compte_AtelierBeforePost(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
TableGereStartTransaction(dataset);
Initialise_ExceptLGR(CtrlSaisie);
Try
Case DataSet.State of
   dsInsert:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Compte_Atelier(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement Compte
                //*************************************************************************
           0001,0000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement ID_Atelier
                //*************************************************************************
           1001,1000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle
                //*************************************************************************
                2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Ratio
                //*************************************************************************
                3000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
// Zone Edition
   dsEdit:Begin
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_Compte_Atelier(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement Compte
                //*************************************************************************
           0001,0000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement ID_Atelier
                //*************************************************************************
           1001,1000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Libelle
                //*************************************************************************
                2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement Ratio
                //*************************************************************************
                3000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
abort;
End;
End;

// Controle de Saisie
Function TDMAnalytiques.CtrlSaisieTA_Affect_Atelier_PourCompte(CCourant:TField):TExceptLGR;
var
Atelier:TInfosTA_Atelier;
begin
Try //
//Result.NumErreur:=0;
//Result.Retour:=True;
Initialise_ExceptLGR(Result);
Case CCourant.DataSet.State of
   dsedit,
   dsInsert:Begin
             case CCourant.Index of
                // Traitement ID_Atelier
                //*************************************************************************
                1:Begin
                  //  Affectation de l'id_Atelier ( pour le traitement du post direct )
//                  if Empty(CCourant.AsString) then
//                        CtrlSaisieTA_Affect_Atelier_PourCompte(CCourant.DataSet.Fields[4]);
                        
                  if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('l''ID_Atelier est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
                  else
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin//si ID_Atelier rempli, alors vérifier existence de l'ID_Atelier
                     DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                     Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,CCourant.FieldName,[CCourant.asinteger]);
                     if not Atelier.ResultInfos then
                       raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),false,mtError,result)
                     else
                       begin//si correct, vérifier si cette affectation n'existe pas déjà
                         if empty(CCourant.DataSet.findfield('Code_Atelier').asstring) then
                           CCourant.DataSet.findfield('Code_Atelier').asstring:=atelier.Code_Atelier;
                         AffectationCourante_Compte.ID_Atelier:=CCourant.AsInteger;
                         AffectationCourante_Compte.Code_Atelier:=CCourant.DataSet.findfield('Code_Atelier').asstring;
//                         if AffectationExiste_SurCompte(AffectationCourante_Compte).ResultInfos then
//                            raise ExceptLGR.Create('Cette affectation existe déjà',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result);
                       end;//fin si correct
                     end;//fin si ID_Atelier rempli
                     if empty(CCourant.DataSet.findfield('libelle').asstring)then
                       begin
                         DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
                         AffectationCourante_Compte.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[ccourant.DataSet.findfield('CODE_atelier').AsString]).Libelle_Atelier;
                         CCourant.DataSet.findfield('libelle').asstring:=AffectationCourante_Compte.Libelle;
                       end;
                  End;
                // Traitement ID_Ligne
                //*************************************************************************
                2:Begin
//                  if Empty(CCourant.AsString) then
//                    begin
//                     if empty(ccourant.DataSet.FindField('Compte').asstring) then
//                       raise ExceptLGR.Create('L"id_Ligne est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                    end
//                  else
//                  if not (VerifFNumeric(CCourant).VideOUZero) then
//                     begin //vérifier existence de l'id_ligne
//                     //si id_ligne rempli, alors vérifier existence de l'id_ligne
//                     if not Infos_TInfosEcriture(DMRech.TaEcritureRech,'id',[CCourant.asinteger]).ResultInfos then
//                       raise ExceptLGR.Create('L"id_ligne saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result)
//                     else
//                       begin//si correct, vérifier si cette affectation n'existe pas déjà
//                         AffectationCourante_Compte.ID_Ligne:=CCourant.AsInteger;
////                         if AffectationExiste_SurCompte(AffectationCourante_Compte).ResultInfos then
////                            raise ExceptLGR.Create('Cette affectation existe déjà',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result);
//                       end;//fin si correct
//                     end;//fin //vérifier existence de l'id_ligne
                  End;
                // Traitement Compte
                //*************************************************************************
                3:Begin
                  if Empty(CCourant.AsString) then
                    begin
                     if VerifFNumeric(ccourant.DataSet.FindField('id_ligne')).VideOUZero then
                       raise ExceptLGR.Create('Le Compte est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                    end
                  else
                  //vérifier existence du Compte
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     //si Compte rempli, alors vérifier existence du Compte
                     DeFiltrageDataSet(DMRech.TaplancptRech);
                     if not Infos_TInfosplancpt(DMRech.TaplancptRech,'Compte',[CCourant.asstring]).ResultInfos then
                       raise ExceptLGR.Create('Le Compte saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result)
                     else
                       begin//si correct, vérifier si cette affectation n'existe pas déjà
                         AffectationCourante_Compte.Compte:=CCourant.asstring;
//                         if AffectationExiste_SurCompte(AffectationCourante_Compte).ResultInfos then
//                            raise ExceptLGR.Create('Cette affectation existe déjà',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result);
                       end;//fin si correct
                     end;//fin vérifier existence du Compte
                  End;
                // Traitement Libelle
                //*************************************************************************
                4:Begin
                  if Empty(CCourant.AsString) then
                     begin
                       DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
                       AffectationCourante_Compte.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[ccourant.DataSet.findfield('CODE_atelier').AsString]).Libelle_Atelier;
                       ccourant.AsString:=AffectationCourante_Compte.Libelle;
                     end;
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement Code_Atelier
                //*************************************************************************
                5:Begin
                  if Empty(CCourant.AsString) then
                    begin
                      CCourant.DataSet.findfield('id_Atelier').asstring:='';
                      AffectationCourante_Compte.ID_Atelier:=CCourant.DataSet.findfield('id_Atelier').AsInteger;
                      AffectationCourante_Compte.Code_Atelier:=CCourant.asstring;
                    end
                     //raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
                  else
                    Begin//si Code_Atelier remplie, vérifier cohérence
                      DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                      Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,CCourant.FieldName,[CCourant.AsString]);
                      if not Atelier.ResultInfos then
                         raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result)
                      else
                        if Atelier.ResultInfos then
                          begin//si correct, vérifier si cette affectation n'existe pas déjà
                            CCourant.DataSet.findfield('id_Atelier').AsInteger:=Atelier.ID_Atelier;
                            AffectationCourante_Compte.ID_Atelier:=CCourant.DataSet.findfield('id_Atelier').AsInteger;
                            AffectationCourante_Compte.Code_Atelier:=CCourant.asstring;
                          End;
                    end;//fin si Code_Atelier remplie
                  if AffectationExiste_SurCompte(AffectationCourante_Compte) then
                     raise ExceptLGR.Create('Cette affectation existe déjà',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result);
                  if empty(CCourant.DataSet.findfield('libelle').asstring)then
                    begin
                      DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
                      AffectationCourante_Compte.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[ccourant.DataSet.findfield('CODE_atelier').AsString]).Libelle_Atelier;
                      CCourant.DataSet.findfield('libelle').asstring:=AffectationCourante_Compte.Libelle;
                    end;
                  End;
                // Traitement Ratio
                //*************************************************************************
                6:Begin
                  if VerifFNumeric(CCourant).VideOUZero then
                     CCourant.AsInteger:=1;
                     //raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                  End;
             End; // Fin du case CCourant.Index
            end;//fin si modif ou insertion
End; // Fin du Case CCourant.DataSet.State

Except
   abort;
End;
End;

// Controle de Saisie
Function TDMAnalytiques.CtrlSaisieTA_Affect_Atelier_PourEcriture(CCourant:TField):TExceptLGR;
var
Atelier:TInfosTA_Atelier;
begin
Try //
//Result.NumErreur:=0;
//Result.Retour:=True;
Initialise_ExceptLGR(Result);
Case CCourant.DataSet.State of
   dsedit,
   dsInsert:Begin
             case CCourant.Index of
                // Traitement ID_Atelier
                //*************************************************************************
                1:Begin
                  //if ((Empty(CCourant.AsString))and(not empty(CCourant.DataSet.findfield('Code_Atelier').asstring))) then
                  if Empty(CCourant.AsString) then
                  //                     raise ExceptLGR.Create('l''ID_Atelier est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
                  else
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin//si ID_Atelier rempli, alors vérifier existence de l'ID_Atelier
                     DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                     Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,CCourant.FieldName,[CCourant.asinteger]);
                     if not Atelier.ResultInfos then
                       //raise ExceptLGR.Create('L"ID_Atelier saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result)
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),false,mtError,result)
                     else
                       begin//si correct, vérifier si cette affectation n'existe pas déjà
                         if empty(CCourant.DataSet.findfield('Code_Atelier').asstring) then
                           CCourant.DataSet.findfield('Code_Atelier').asstring:=atelier.Code_Atelier;
                         AffectationCourante_Ecriture.ID_Atelier:=CCourant.AsInteger;
                         AffectationCourante_Ecriture.Code_Atelier:=CCourant.DataSet.findfield('Code_Atelier').asstring;
//                         if AffectationExiste_SurCompte(AffectationCourante_Ecriture).ResultInfos then
//                            raise ExceptLGR.Create('Cette affectation existe déjà',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result);
                       end;//fin si correct
                     end;//fin si ID_Atelier rempli
                  if empty(ccourant.DataSet.findfield('libelle').AsString) then
                    begin
                      DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
                      AffectationCourante_Ecriture.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[ccourant.DataSet.findfield('CODE_atelier').AsString]).Libelle_Atelier;
                      ccourant.DataSet.findfield('libelle').AsString:=AffectationCourante_Ecriture.Libelle;
                    end;
                  End;
                // Traitement ID_Ligne
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                    begin
                     if empty(ccourant.DataSet.FindField('Compte').asstring) then
                       raise ExceptLGR.Create('L"id_Ligne est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                    end
                  else
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin //vérifier existence de l'id_ligne
                     //si id_ligne rempli, alors vérifier existence de l'id_ligne
                     DeFiltrageDataSet(DMRech.TaEcritureRech);
                     if not Infos_TInfosEcriture(DMRech.TaEcritureRech,'id',[CCourant.asinteger]).ResultInfos then
                       raise ExceptLGR.Create('L"id_ligne saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result)
                     else
                       begin//si correct, vérifier si cette affectation n'existe pas déjà
                         AffectationCourante_Ecriture.ID_Ligne:=CCourant.AsInteger;
//                         if AffectationExiste_SurCompte(AffectationCourante_Ecriture).ResultInfos then
//                            raise ExceptLGR.Create('Cette affectation existe déjà',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result);
                       end;//fin si correct
                     end;//fin //vérifier existence de l'id_ligne
                  End;
                // Traitement Compte
                //*************************************************************************
                3:Begin
                  if Empty(CCourant.AsString) then
                    begin
                     if VerifFNumeric(ccourant.DataSet.FindField('id_ligne')).VideOUZero then
                       raise ExceptLGR.Create('Le Compte est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                    end
                  else
                  //vérifier existence du Compte
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     //si Compte rempli, alors vérifier existence du Compte
                     DeFiltrageDataSet(DMRech.TaplancptRech);
                     if not Infos_TInfosplancpt(DMRech.TaplancptRech,'Compte',[CCourant.asstring]).ResultInfos then
                       raise ExceptLGR.Create('Le Compte saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result)
                     else
                       begin//si correct, vérifier si cette affectation n'existe pas déjà
                         AffectationCourante_Ecriture.Compte:=CCourant.asstring;
//                         if AffectationExiste_SurCompte(AffectationCourante_Ecriture).ResultInfos then
//                            raise ExceptLGR.Create('Cette affectation existe déjà',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result);
                       end;//fin si correct
                     end;//fin vérifier existence du Compte
                  End;
                // Traitement Libelle
                //*************************************************************************
                4:Begin
                  if Empty(CCourant.AsString) then
                     begin
                       DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
                       AffectationCourante_Ecriture.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[ccourant.DataSet.findfield('CODE_atelier').AsString]).Libelle_Atelier;
                       ccourant.AsString:=AffectationCourante_Ecriture.Libelle;
                     end;

                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result);
                  End;
                // Traitement Code_Atelier
                //*************************************************************************
                5:Begin
                  if ((Empty(CCourant.AsString))and(VerifFNumeric(CCourant.DataSet.findfield('compte')).VideOUZero) and(VerifFNumeric(CCourant.DataSet.findfield('ratio')).VideOUZero)) then
                    begin
                      CCourant.DataSet.findfield('id_Atelier').asstring:='';
                      AffectationCourante_Ecriture.ID_Atelier:=CCourant.DataSet.findfield('id_Atelier').AsInteger;
                      AffectationCourante_Ecriture.Code_Atelier:=CCourant.asstring;
                    end
                  else
                    if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
                  else
                    Begin//si Code_Atelier remplie, vérifier cohérence
                      DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                      Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,CCourant.FieldName,[CCourant.AsString]);
                      if not Atelier.ResultInfos then
                         raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result)
                      else
                        if Atelier.ResultInfos then
                          begin//si correct, vérifier si cette affectation n'existe pas déjà
                            CCourant.DataSet.findfield('id_Atelier').AsInteger:=Atelier.ID_Atelier;
                            AffectationCourante_Ecriture.ID_Atelier:=CCourant.DataSet.findfield('id_Atelier').AsInteger;
                            AffectationCourante_Ecriture.Code_Atelier:=CCourant.asstring;
                          End;
                    end;//fin si Code_Atelier remplie
                  if AffectationExiste_SurCompte(AffectationCourante_Ecriture) then
                     raise ExceptLGR.Create('Cette affectation existe déjà',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result);
                  if empty(ccourant.DataSet.findfield('libelle').AsString) then
                    begin
                      DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
                      AffectationCourante_Ecriture.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[ccourant.DataSet.findfield('CODE_atelier').AsString]).Libelle_Atelier;
                      ccourant.DataSet.findfield('libelle').AsString:=AffectationCourante_Ecriture.Libelle;
                    end;
                  End;
                // Traitement Ratio
                //*************************************************************************
                6:Begin
                  if VerifFNumeric(CCourant).VideOUZero then
                     CCourant.asfloat:=1;
                     //raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
                  End;
             End; // Fin du case CCourant.Index
            end;//fin si modif ou insertion
End; // Fin du Case CCourant.DataSet.State

Except
   abort;
End;
End;



Function TDMAnalytiques.CtrlSaisieTA_EcritureAnal(CCourant:TField):TExceptLGR;
var
Atelier:TInfosTA_Atelier;
begin
Try
//Result.NumErreur:=0;
//Result.Retour:=True;
Initialise_ExceptLGR(Result);
Case CCourant.DataSet.State of
   dsedit,
   dsInsert:Begin
             case CCourant.Index of
                // Traitement ID_GESTANAL
                //*************************************************************************
                4:Begin
                  if ((VerifFNumeric(CCourant).Vide)and(not empty(ccourant.DataSet.FindField('Code_Gestanal').asstring))) then
                    begin
                      DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                      Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'Code_atelier',[ccourant.DataSet.FindField('Code_Gestanal').asstring]);
                      if Atelier.ResultInfos then
                        ccourant.AsInteger:=atelier.ID_Atelier;
                    end
                  else
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     //si ID_Atelier rempli, alors vérifier existence de l'ID_Atelier
                     DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                     if not Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'Id_Atelier',[CCourant.asinteger]).ResultInfos then
                       raise ExceptLGR.Create('L"ID_GESTANAL saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                     end;
                  End;
                // Traitement CODE_GESTANAL
                //*************************************************************************
                5:Begin
                  if Empty(CCourant.AsString) then
                      CCourant.DataSet.Findfield('ID_Gestanal').asstring:=''
                     //raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
                  else
                    Begin//si CODE_GESTANAL remplie, vérifier cohérence
                      DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                      Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'Code_atelier',[CCourant.AsString]);
                      if ((not Atelier.ResultInfos)and(ccourant.AsString<>'*')) then
                         raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result)
                      else
                        if Atelier.ResultInfos then
                         Begin //si ok, remplir l'id_atelier correspondant
                           CCourant.DataSet.Findfield('ID_Gestanal').AsInteger:=Atelier.ID_Atelier;
                         End
                        else
                          if ccourant.AsString='*' then
                            Begin
                              CCourant.DataSet.Findfield('ID_Gestanal').AsInteger:=0;
                              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'002'),false,mtError,result)
                            End;
                    end;
                  End;
             End; // Fin du case
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//             case CCourant.Index of
//                // Traitement ID_Atelier
//                //*************************************************************************
//                0:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//                1:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Compte
//                //*************************************************************************
//                2:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Libelle
//                //*************************************************************************
//                3:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//                4:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//                // Traitement Ratio
//                //*************************************************************************
//                5:Begin
////                  if Empty(CCourant.AsString) then
////                     raise ExceptLGR.Create('Mess',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  End;
//             End; // Fin du case
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
   abort;
End;
End;

procedure TDMAnalytiques.TaEcriture_AnalBeforePost(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
Try
Initialise_ExceptLGR(CtrlSaisie);
TableGereStartTransaction(dataset);
Case DataSet.State of
   dsedit,
   dsInsert:Begin
            AffectationCourante_Ecriture.ID_Ligne:=DataSet.findfield('id').AsInteger;
            AffectationCourante_Ecriture.Compte:=DataSet.findfield('Compte').asstring;
            if DataSet.findfield('CODE_GESTANAL').AsString='*' then
              DataSet.findfield('ID_GESTANAL').asstring:='';
            AffectationCourante_Ecriture.ID_Atelier:=DataSet.findfield('ID_GESTANAL').asinteger;
            AffectationCourante_Ecriture.Code_Atelier:=DataSet.findfield('CODE_GESTANAL').AsString;
            DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
            AffectationCourante_Ecriture.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[DataSet.findfield('CODE_GESTANAL').AsString]).Libelle_Atelier;
//            AffectationCourante_Ecriture.ratio:=1;
            For I:=4 to 5 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_EcritureAnal(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_GESTANAL
                //*************************************************************************
           4001,4000:Begin
                        DataSet.Fields[i+1].FocusControl;//l'id n'est pas publié
                        abort; //alors focus sur code
                     End;
                // Traitement CODE_GESTANAL
                //*************************************************************************
                5000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                5001:begin//code non existant et <> de '*'
//                       if Application.MessageBox(Pchar('Cet atelier n"existe pas, voulez-vous le créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
//                           Ta_Atelier.Insert;
//                           Ta_Atelier.FindField('Code_Atelier').asstring:=AffectationCourante_Ecriture.Code_Atelier;
//                           abort;
//                         end
//                       else
//                        abort;
                        Application.Messagebox(Pchar('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités'),'Erreur de saisie',0);
                        abort;
                     end;
                5002:begin//code = '*'
//                       if Application.MessageBox(Pchar('Cet atelier n"existe pas, voulez-vous le créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
//                         if ((Ta_Affect_Atelier_Ecriture.RecordCount<2)or(VerifFNumeric(Ta_Affect_Atelier_Ecriture.FindField('id_Ligne')).VideOUZero)) then
                         if ((Ta_Affect_Atelier_Ecriture.RecordCount<2)and (Ta_Affect_Atelier_Ecriture.state<>dsinsert)and(not ProcHorsFenetre)) then
                           begin
                           TableGereInsert(Ta_Affect_Atelier_Ecriture);
                           //Ta_Affect_Atelier_Ecriture.Insert;
                           Ta_Affect_Atelier_Ecriture.FindField('id_Ligne').AsInteger:=AffectationCourante_Ecriture.ID_Ligne;
                           abort;
                           end;
//                         end
//                       else
//                        abort;
                     end;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//            For I:=0 to DataSet.FieldCount-1 do
//              begin
//               try
//                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier(DataSet.Fields[i]);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//           0001,0000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//           1001,1000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Compte
//                //*************************************************************************
//           2001,2000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Libelle
//                //*************************************************************************
//                3000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//           4001,4000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Ratio
//                //*************************************************************************
//                5000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//              End; // Fin du begin de boucle For
//            End; // Fin Begin du dsEdit
End; // Fin du Case
AffectationCourante_Ecriture.ID_Ligne:=DataSet.findfield('id').AsInteger;
AffectationCourante_Ecriture.Compte:=DataSet.findfield('Compte').asstring;
AffectationCourante_Ecriture.ID_Atelier:=DataSet.findfield('ID_GESTANAL').asinteger;
AffectationCourante_Ecriture.Code_Atelier:=DataSet.findfield('CODE_GESTANAL').AsString;
DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
AffectationCourante_Ecriture.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[DataSet.findfield('CODE_GESTANAL').AsString]).Libelle_Atelier;
//AffectationCourante_Ecriture.ratio:=1;
//si affectation simple, je supprime les anciennes relations et
//je remplace directement par la nouvelle
if AffectationCourante_Ecriture.Code_Atelier<>'*' then
  begin//si affectation simple
     //on supprime automatique toutes relations existantes
     if not ProcHorsFenetre then
       begin
          GestionSuppressionRelation_Ecriture_Atelier(AffectationCourante_Ecriture.ID_Ligne,-1);
          if AffectationCourante_Ecriture.ID_Atelier<>0 then
            begin //s'il y une affectation à écrire
              //remplir la table relation (Ta_Compte_Atelier)
              tablegereinsert(Ta_ecriture_Atelier);
//              Ta_ecriture_Atelier.insert;
              TableGerePost(Ta_ecriture_Atelier);
            end;//fin s'il y une affectation à écrire
       end;
  end;//fin si affectation simple
Except
if not(Ta_Affect_Atelier_Ecriture.State in [dsinsert,dsedit])then
  begin
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
  end;
  TableGerePost(Ta_Affect_Atelier_Ecriture);
  abort;
End;
End;

Function AffichAteliersExistants(Requete:TDataset;Datasource:Tdatasource;Atelier:string):TInfosTA_Atelier;
Begin
  try
    Initialise_TInfosTA_Atelier(result);
    if VisuListe = nil then VisuListe:=TVisuListe.Create(Application.MainForm);
    if DMAnalytiques = nil then DMAnalytiques:=TDMAnalytiques.Create(application.MainForm);

    VisuListe.BtnDetail.OnClick:=nil;
    VisuListe.PaGrille.OnResize:=DMAnalytiques.PaGrilleResize_VisuListe;
    VisuListe.BtnEnregistrer.OnClick:=VisuListe.BtnEnregistrerClick;
    VisuListe.GrDBVisu.OnDblClick:=VisuListe.BtnEnregistrerClick;
    VisuListe.Enregister1.OnClick:=VisuListe.BtnEnregistrerClick;

    VisuListe.OnKeyDown:=DMAnalytiques.FormKeyDown_VisuListe;
    VisuListe.BtnEnregistrer.visible:=true;
    VisuListe.Enregister1.visible:=true;

    VisuListe.RxLabTitre.Caption:='Liste des ateliers existants';
    VisuListe.PaTitrePetit.Caption:='ateliers à sélectionner';

    VisuListe.GrDBVisu.DefaultDrawing:=False;
    GrDbGridInitColonne(VisuListe.GrDBVisu,Datasource,Requete,
                       ['Code Atelier','Libellé de l"atelier'],
                       ['Code_Atelier','Libelle_Atelier'],E.FormatMonnaie,E.EditFormat);

    if Atelier<>'' then VisuListe.GrDBVisu.DataSource.DataSet.Locate('Code_Atelier',Atelier,[loCaseInsensitive,loPartialKey]);
    if VisuListe.Showmodal=mrok then
     Remplit_TInfosTA_Atelier(Requete,result)
    else
     result.ResultInfos:=false;
  except
    Result.ResultInfos:=false;
  end;//fin du try finally
End;


//formkeyDown de visuliste
procedure TDMAnalytiques.FormKeyDown_VisuListe(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(VisuListe.Handle,key,[VisuListe.GrDBVisu]);
  if Key = VK_ESCAPE then
   begin
      Key:= 0;
      VisuListe.Close;
   end;
  if Key = vk_return then
   begin
      Key:= 0;
      VisuListe.BtnEnregistrerClick(VisuListe);
   end;
end;


// PaGrilleResize de VisuListe
procedure TDMAnalytiques.PaGrilleResize_VisuListe (Sender: TObject);
begin
  FormateTailleColonne(visuliste.GrDBVisu,20,[3,10]);
  WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;


Function TDMAnalytiques.CtrlSaisieTA_PlanAnal(CCourant:TField):TExceptLGR;
var
Atelier:TInfosTA_Atelier;
begin
Try
//Result.NumErreur:=0;
//Result.Retour:=True;
Initialise_ExceptLGR(Result);
Case CCourant.DataSet.State of
   dsedit,
   dsInsert:Begin
             case CCourant.Index of
                // Traitement ID_GESTANAL
                //*************************************************************************
                2:Begin
                  if ((VerifFNumeric(CCourant).Vide)and(not empty(ccourant.DataSet.FindField('Code_Gestanal').asstring))) then
                    begin
                      DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                      Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'Code_atelier',[ccourant.DataSet.FindField('Code_Gestanal').asstring]);
                      if Atelier.ResultInfos then
                        ccourant.AsInteger:=atelier.ID_Atelier;
                    end
                  else
                  if not (VerifFNumeric(CCourant).VideOUZero) then
                     begin
                     //si ID_Atelier rempli, alors vérifier existence de l'ID_Atelier
                     DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                     if not Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'Id_Atelier',[CCourant.asinteger]).ResultInfos then
                       raise ExceptLGR.Create('L"ID_GESTANAL saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
                     end;
                  End;
                // Traitement CODE_GESTANAL
                //*************************************************************************
                3:Begin
                  if Empty(CCourant.AsString) then
                      CCourant.DataSet.Findfield('ID_Gestanal').asstring:=''
                     //raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
                  else
                    Begin//si CODE_GESTANAL remplie, vérifier cohérence
                      DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
                      Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'Code_atelier',[CCourant.AsString]);
                      if ((not Atelier.ResultInfos)and(ccourant.AsString<>'*')) then
                         raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result)
                      else
                        if Atelier.ResultInfos then
                         Begin //si ok, remplir l'id_atelier correspondant
                           CCourant.DataSet.Findfield('ID_Gestanal').AsInteger:=Atelier.ID_Atelier;
                         End
                        else
                          if ccourant.AsString='*' then
                            Begin
                              CCourant.DataSet.Findfield('ID_Gestanal').AsInteger:=0;
                              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'002'),false,mtError,result)
                            End;
                    end;
                  End;
             End; // Fin du case
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//             case CCourant.Index of
//                // Traitement ID_GESTANAL
//                //*************************************************************************
//                2:Begin
//                  if Empty(CCourant.AsString) then
//                     raise ExceptLGR.Create('l''ID_GESTANAL est vide',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result)
//                  else
//                  if not (VerifFNumeric(CCourant).VideOUZero) then
//                     begin
//                     //si ID_Atelier rempli, alors vérifier existence de l'ID_Atelier
//                     if not Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'Id_Atelier',[CCourant.asinteger]).ResultInfos then
//                       raise ExceptLGR.Create('L"ID_GESTANAL saisi n"existe pas ',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result);
//                     end;
//                  End;
//                // Traitement CODE_GESTANAL
//                //*************************************************************************
//                3:Begin
//                  if Empty(CCourant.AsString) then
//                      CCourant.DataSet.Findfield('ID_Gestanal').asstring:=''
//                     //raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),false,mtError,result)
//                  else
//                    Begin//si CODE_GESTANAL remplie, vérifier cohérence
//                      Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'Code_atelier',[CCourant.AsString]);
//                      if ((not Atelier.ResultInfos)and(ccourant.AsString<>'*')) then
//                         raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'001'),false,mtError,result)
//                      else
//                        if Atelier.ResultInfos then
//                         Begin //si ok, remplir l'id_atelier correspondant
//                           CCourant.DataSet.Findfield('ID_Gestanal').AsInteger:=Atelier.ID_Atelier;
//                         End
//                        else
//                          if ccourant.AsString='*' then
//                            Begin
//                              CCourant.DataSet.Findfield('ID_Gestanal').AsInteger:=0;
//                              raise ExceptLGR.Create('',StrToInt_Lgr(inttostr(CCourant.Index)+'002'),false,mtError,result)
//                            End;
//                    end;
//                  End;
//             End; // Fin du case

//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
   abort;
End;
End;

procedure TDMAnalytiques.TaPlanAnalBeforePost(DataSet: TDataSet);
Var
I:Integer;
CtrlSaisie:TExceptLGR;
begin
TableGereStartTransaction(dataset);
Try
Initialise_ExceptLGR(CtrlSaisie);
Case DataSet.State of
   dsedit,
   dsInsert:Begin
            AffectationCourante_Compte.Compte:=DataSet.findfield('Compte').asstring;
            if DataSet.findfield('CODE_GESTANAL').AsString='*' then
              DataSet.findfield('ID_GESTANAL').asstring:='';
            AffectationCourante_Compte.ID_Atelier:=DataSet.findfield('ID_GESTANAL').asinteger;
            AffectationCourante_Compte.Code_Atelier:=DataSet.findfield('CODE_GESTANAL').AsString;
            DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
            AffectationCourante_Compte.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[DataSet.findfield('CODE_GESTANAL').AsString]).Libelle_Atelier;
            AffectationCourante_Compte.ratio:=1;
            For I:=0 to DataSet.FieldCount-1 do
              begin
               try
                CtrlSaisie:=CtrlSaisieTA_PlanAnal(DataSet.Fields[i]);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_GESTANAL
                //*************************************************************************
           2001,2000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                // Traitement CODE_GESTANAL
                //*************************************************************************
                3000:Begin
                        DataSet.Fields[i].FocusControl;
                        abort;
                     End;
                3001:begin//code non existant et <> de '*'
//                       if Application.MessageBox(Pchar('Cet atelier n"existe pas, voulez-vous le créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
//                           Ta_Atelier.Insert;
//                           Ta_Atelier.FindField('Code_Atelier').asstring:=AffectationCourante_Compte.Code_Atelier;
//                           abort;
//                         end
//                       else
//                        abort;
                        Application.Messagebox(Pchar('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités'),'Erreur de saisie',0);
                        abort;
                     end;
                3002:begin//code = '*'
//                       if Application.MessageBox(Pchar('Cet atelier n"existe pas, voulez-vous le créer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
//                           if ((Ta_Affect_Atelier_Compte.RecordCount<2)or(VerifFNumeric(Ta_Affect_Atelier_Compte.FindField('id_Ligne')).VideOUZero)) then
                           if ((Ta_Affect_Atelier_Compte.RecordCount<2)and (Ta_Affect_Atelier_Compte.state<>dsinsert) and(not ProcHorsFenetre)) then
                             begin
                             tablegereinsert(Ta_Affect_Atelier_Compte);
//                             Ta_Affect_Atelier_Compte.Insert;
                             Ta_Affect_Atelier_Compte.FindField('Compte').asstring:=AffectationCourante_Compte.Compte;
                             abort;
                             end;
//                         end
//                       else
//                        abort;
                     end;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//            For I:=0 to DataSet.FieldCount-1 do
//              begin
//               try
//                CtrlSaisie:=CtrlSaisieTA_Affect_Atelier(DataSet.Fields[i]);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//           0001,0000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//           1001,1000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Compte
//                //*************************************************************************
//           2001,2000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Libelle
//                //*************************************************************************
//                3000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//           4001,4000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                // Traitement Ratio
//                //*************************************************************************
//                5000:Begin
//                        DataSet.Fields[i].FocusControl;
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//              End; // Fin du begin de boucle For
//            End; // Fin Begin du dsEdit
End; // Fin du Case

AffectationCourante_Compte.Compte:=DataSet.findfield('Compte').asstring;
AffectationCourante_Compte.ID_Atelier:=DataSet.findfield('ID_GESTANAL').asinteger;
AffectationCourante_Compte.Code_Atelier:=DataSet.findfield('CODE_GESTANAL').AsString;
DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
AffectationCourante_Compte.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[DataSet.findfield('CODE_GESTANAL').AsString]).Libelle_Atelier;
AffectationCourante_Compte.ratio:=1;
//si affectation simple, je supprime les anciennes relations et
//je remplace directement par la nouvelle
if AffectationCourante_Compte.Code_Atelier<>'*' then
  begin//si affectation simple
     //on supprime automatique toutes relations existantes
     if not ProcHorsFenetre then
       begin
         GestionSuppressionRelation_Compte_Atelier(AffectationCourante_Compte.Compte,-1);
         if AffectationCourante_Compte.ID_Atelier<>0 then
           begin //s'il y une affectation à écrire
             //remplir la table relation (Ta_Compte_Atelier)
             tablegereinsert(Ta_Compte_Atelier);
//             Ta_Compte_Atelier.insert;
             TableGerePost(Ta_Compte_Atelier);
           end;//fin s'il y une affectation à écrire
       end;
  end;//fin si affectation simple
Except
if not(Ta_Affect_Atelier_Compte.State in [dsinsert,dsedit])then
  begin
    TableGereRollBack(DataSet);
    TableGereRollBack(DMBalance.TaBalance);
  end;
TableGerePost(Ta_Affect_Atelier_Compte);
abort;
End;
End;

procedure TDMAnalytiques.Ta_Ecriture_AtelierBeforeDelete(
  DataSet: TDataSet);
begin
TableGereStartTransaction(dataset);
TableGereStartTransaction(DMBalance.TaBalance);
end;


function TDMAnalytiques.GestionSuppressionRelation_Compte_Atelier(Compte:string;id_Atelier:integer):boolean;
var
filtre:TFiltre;
Event:TDataSetNotifyEvent;
Begin
    try//except
     result:=true;
     //executer la requete de suppression des relations sur id
     if not empty(compte) then
       begin
       QuSupp_Compte_Atelier.Close;
       QuSupp_Compte_Atelier.ParamByName('Cpt').asstring:=Compte;
       QuSupp_Compte_Atelier.ExecSQL;
       end
     else
       Begin
          //supprimer les relations avec les comptes
          try//finally
             ProcHorsFenetre:=true;
//             Event:=TaPlanAnal.BeforePost;
//             TaPlanAnal.BeforePost:=nil;
             Ta_Compte_Atelier.DisableControls;
             filtre.filtre:=Ta_Compte_Atelier.Filter;
             filtre.filtrer:=Ta_Compte_Atelier.Filtered;
             FiltrageDataSet(Ta_Compte_Atelier,CreeFiltreou('id_atelier',[inttostr(Id_Atelier)]));
             Ta_Compte_Atelier.First;
             while Ta_Compte_Atelier.RecordCount<>0 do
               Begin
                 AffectationCourante_Compte.Compte:=Ta_Compte_Atelier.findfield('compte').asstring;
                 AffectationCourante_Compte.ID_Ligne:=0;
                 TableGereDelete(Ta_Compte_Atelier);
                 TableGerePost(TaPlanAnal);
               End;
          finally
//             TaPlanAnal.BeforePost:=Event;
             ProcHorsFenetre:=false;
             if filtre.filtrer then
               Begin
                 FiltrageDataSet(Ta_Compte_Atelier,filtre.filtre);
               End
             else
               DeFiltrageDataSet(Ta_Compte_Atelier);
             Ta_Compte_Atelier.enableControls;
          end;
       End;
    except
       result:=false;
    end;
End;

function GestionSuppressionRelation_Ecriture_Atelier(id:integer;id_Atelier:integer):boolean;
var
filtre:TFiltre;
Event:TDataSetNotifyEvent;
Begin
try//except
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.Create(application.MainForm);
 result:=true;
 //executer la requete de suppression des relations sur id
 if id<>-1 then
   begin
      DMAnalytiques.QuSupp_Ecriture_Atelier.Close;
      DMAnalytiques.QuSupp_Ecriture_Atelier.ParamByName('id').asinteger:=id;
      DMAnalytiques.QuSupp_Ecriture_Atelier.ExecSQL;
      DMAnalytiques.QuSupp_Ecriture_Atelier.close;
   end
 else
   Begin
      //supprimer les relations avec les comptes
      try//finally
          DMAnalytiques.ProcHorsFenetre:=true;
         DMAnalytiques.Ta_Ecriture_Atelier.DisableControls;
//         Event:=Ta_Ecriture_Atelier.BeforePost;
//         Ta_Ecriture_Atelier.BeforePost:=nil;
         filtre.filtre:=DMAnalytiques.Ta_Ecriture_Atelier.Filter;
         filtre.filtrer:=DMAnalytiques.Ta_Ecriture_Atelier.Filtered;
         FiltrageDataSet(DMAnalytiques.Ta_Ecriture_Atelier,CreeFiltreou('id_atelier',[inttostr(Id_Atelier)]));
         DMAnalytiques.Ta_Ecriture_Atelier.First;
         while DMAnalytiques.Ta_Ecriture_Atelier.RecordCount<>0 do
           Begin
             DMAnalytiques.AffectationCourante_Ecriture.Compte:='';
             DMAnalytiques.AffectationCourante_Ecriture.ID_Ligne:=DMAnalytiques.Ta_Ecriture_Atelier.findfield('id_Ligne').asinteger;
             TableGereDelete(DMAnalytiques.Ta_Ecriture_Atelier);
             TableGerePost(DMAnalytiques.TaEcriture_Anal);
           End;
      finally
//         Ta_Ecriture_Atelier.BeforePost:=Event;
         DMAnalytiques.ProcHorsFenetre:=false;
         if ((filtre.filtrer)and(not empty(filtre.filtre))) then
           Begin
             FiltrageDataSet(DMAnalytiques.Ta_Ecriture_Atelier,filtre.filtre);
           End
         else
           DeFiltrageDataSet(DMAnalytiques.Ta_Ecriture_Atelier);
         DMAnalytiques.Ta_Ecriture_Atelier.enableControls;
      end;
   End;
except
   result:=false;
end;
End;


procedure TDMAnalytiques.Ta_Compte_AtelierAfterInsert(DataSet: TDataSet);
begin
TableGereStartTransaction(dataset);
TableGereStartTransaction(Ta_Affect_Atelier_Compte);
InitChampAfterInsert([AffectationCourante_compte.Compte,AffectationCourante_compte.ID_Atelier,AffectationCourante_compte.Libelle,AffectationCourante_compte.Ratio],dataset);
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_CompteAfterEdit(DataSet: TDataSet);
begin
if not (TaPlanAnal.State in [dsedit])then
  TaPlanAnal.edit;
Remplit_TInfosTA_Affect_Atelier(dataset,Affectation_Old);
end;

procedure TDMAnalytiques.Ta_Compte_AtelierAfterPost(DataSet: TDataSet);
var
nouvelleAffection:TInfosTA_Affect_Atelier;
event:TDataSetNotifyEvent;
begin
try
//si affectation non existantes, alors vide les champs id_Gestanal et Code_Gestanal
event:=TaPlanAnal.AfterPost;
TaPlanAnal.AfterPost:=nil;
nouvelleAffection:=Multi_Affectation(dataset,AffectationCourante_Compte);
if ((nouvelleAffection.ResultInfos)and(TaPlanAnalCODE_GESTANAL.asstring<>nouvelleAffection.Code_Atelier)) then
  Begin
    if not (TaPlanAnal.State in [dsedit]) then TaPlanAnal.edit;
    TaPlanAnalID_GESTANAL.asinteger:=nouvelleAffection.ID_Atelier;
    TaPlanAnalCODE_GESTANAL.asstring:=nouvelleAffection.Code_Atelier;
//    TableGerePost(TaPlanAnal);
  End;
finally
  TaPlanAnal.AfterPost:=event;
end;
end;

procedure TDMAnalytiques.Ta_Ecriture_AtelierAfterPost(DataSet: TDataSet);
var
nouvelleAffection:TInfosTA_Affect_Atelier;
event:TDataSetNotifyEvent;
begin
try
//si affectation non existantes, alors vide les champs id_Gestanal et Code_Gestanal
event:=TaEcriture_Anal.AfterPost;
TaEcriture_Anal.AfterPost:=nil;
nouvelleAffection:=Multi_Affectation(dataset,AffectationCourante_Ecriture);
if ((nouvelleAffection.ResultInfos)and(TaEcriture_AnalCODE_GESTANAL.asstring<>nouvelleAffection.Code_Atelier)) then
  Begin
    if not (TaEcriture_Anal.State in [dsedit]) then TaEcriture_Anal.edit;
    TaEcriture_AnalID_GESTANAL.asinteger:=nouvelleAffection.ID_Atelier;
    TaEcriture_AnalCODE_GESTANAL.asstring:=nouvelleAffection.Code_Atelier;
//    TableGerePost(TaEcriture_Anal);
  End;
finally
  TaEcriture_Anal.AfterPost:=event;
end;
end;

procedure TDMAnalytiques.TaEcriture_AnalAfterPost(DataSet: TDataSet);
begin
IdEcritureEnModif:=0;
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
DataSet.Refresh;
FiltrageTa_Affect_Atelier_SurEcritureCourante(dataset.findfield('id').AsString,dataset);
end;

procedure TDMAnalytiques.TaPlanAnalAfterPost(DataSet: TDataSet);
begin
CompteEnModif:='';
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
DataSet.Refresh;
FiltrageTa_Affect_Atelier_SurCompteCourant(dataset.findfield('compte').AsString,dataset);
end;


Procedure TDMAnalytiques.FiltrageTa_Affect_Atelier_SurCompteCourant(Compte:string;DataCompte:Tdataset);
var
CompteCourant:string;
Filtre:TFiltre;
Begin
try//finally
try//except
TableGereCommit(Ta_Affect_Atelier_Compte);
TableGereCommit(DMBalance.TaBalance);
viderTable(Ta_Affect_Atelier_Compte);
if Ta_Affect_Atelier_Compte.State in [dsinsert,dsedit]then
   begin
     Application.Messagebox(Pchar(ErrInterne+' : la table Ta_Affect_Atelier est en modification ou insertion '),Pchar(ErrInterne),0);
     abort;
   end
 else
  if ((Ta_Affect_Atelier_Compte.State in [dsbrowse])and(not empty(compte)))then
   Begin
     try
       DataCompte.DisableControls;
       Filtre.filtre:=Ta_Compte_Atelier.Filter;
       Filtre.filtrer:=Ta_Compte_Atelier.Filtered;
       FiltrageDataSet(Ta_Compte_Atelier,CreeFiltreOU('Compte',[Compte]));
       Ta_Affect_Atelier_Compte.BeforeInsert:=nil;
       Ta_Affect_Atelier_Compte.AfterInsert:=nil;
       Ta_Affect_Atelier_Compte.BeforePost:=Ta_Affect_Atelier_CompteBeforePost_SansAffectation;
       TableGereStartTransaction(Ta_Affect_Atelier_Compte);
       TableGereStartTransaction(DMBalance.TaBalance);
       Ta_Compte_Atelier.first;
       while not Ta_Compte_Atelier.eof do
         Begin
           tablegereinsert(Ta_Affect_Atelier_Compte);
//           Ta_Affect_Atelier_Compte.insert;
           Ta_Affect_Atelier_Compte.FindField('Compte').asstring:= Ta_Compte_Atelier.FindField('Compte').asstring;
           Ta_Affect_Atelier_Compte.FindField('ID_Atelier').asinteger:=Ta_Compte_Atelier.FindField('ID_Atelier').asinteger;
           Ta_Affect_Atelier_Compte.FindField('Libelle').asstring:=Ta_Compte_Atelier.FindField('Libelle').asstring;
           Ta_Affect_Atelier_Compte.FindField('Ratio').asfloat:=Ta_Compte_Atelier.FindField('Ratio').asfloat;
           TableGerePost(Ta_Affect_Atelier_Compte);
           Ta_Compte_Atelier.next;
         End;
       Ta_Affect_Atelier_Compte.first;
       TableGereCommit(Ta_Affect_Atelier_Compte);
       TableGereCommit(DMBalance.TaBalance);
       Ta_Affect_Atelier_Compte.Refresh;
     finally
       if ((filtre.filtrer)and(not empty(filtre.filtre)))then
         FiltrageDataSet(Ta_Compte_Atelier,filtre.filtre)
       else
         DeFiltrageDataSet(Ta_Compte_Atelier);
       DataCompte.EnableControls;
       Ta_Affect_Atelier_Compte.AfterInsert:=Ta_Affect_Atelier_CompteAfterInsert;
       Ta_Affect_Atelier_Compte.BeforeInsert:=Ta_Affect_Atelier_CompteBeforeInsert;
       Ta_Affect_Atelier_Compte.BeforePost:=Ta_Affect_Atelier_CompteBeforePost_AvecAffectation;
     end;
   End;
AffectationCourante_compte.Compte:=DataCompte.findfield('Compte').asstring;
AffectationCourante_compte.Code_Atelier:=DataCompte.findfield('code_gestanal').asstring;
AffectationCourante_compte.ID_Atelier:=DataCompte.findfield('id_gestanal').asinteger;
DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
AffectationCourante_Compte.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[DataCompte.findfield('code_gestanal').AsString]).Libelle_Atelier;
except
  abort;
end;
finally
//
end;
End;

Procedure TDMAnalytiques.FiltrageTa_Affect_Atelier_SurEcritureCourante(id:string;DataEcriture:Tdataset);
var
Filtre:TFiltre;
Begin
try//finally
try//except
TableGereCommit(Ta_Affect_Atelier_Ecriture);
TableGereCommit(DMBalance.TaBalance);
viderTable(Ta_Affect_Atelier_Ecriture);
 if Ta_Affect_Atelier_Ecriture.State in [dsinsert,dsedit]then
   begin
     Application.Messagebox(Pchar(ErrInterne+' : la table Ta_Affect_Atelier est en modification ou insertion '),Pchar(ErrInterne),0);
     abort;
   end
 else
  if ((Ta_Affect_Atelier_Ecriture.State in [dsbrowse])and(not empty(id)))then
   Begin
     try
       viderTable(Ta_Affect_Atelier_Ecriture);
       Filtre.filtre:=Ta_Ecriture_Atelier.Filter;
       Filtre.filtrer:=Ta_Ecriture_Atelier.Filtered;
       FiltrageDataSet(Ta_Ecriture_Atelier,CreeFiltreOU('id_ligne',[id]));
       Ta_Affect_Atelier_Ecriture.BeforeInsert:=nil;
       Ta_Affect_Atelier_Ecriture.AfterInsert:=nil;

       Ta_Affect_Atelier_Ecriture.BeforePost:=Ta_Affect_Atelier_EcritureBeforePost_SansAffectation;
       DataEcriture.DisableControls;
       Ta_Ecriture_Atelier.first;
       TableGereStartTransaction(Ta_Affect_Atelier_Ecriture);
       TableGereStartTransaction(DMBalance.TaBalance);
       if Ta_Ecriture_Atelier.RecordCount > 0 then
        begin
          while not Ta_Ecriture_Atelier.EOF do
            Begin
              tablegereinsert(Ta_Affect_Atelier_Ecriture);
//              Ta_Affect_Atelier_Ecriture.insert;
              Ta_Affect_Atelier_Ecriture.FindField('id_ligne').asinteger:= Ta_Ecriture_Atelier.FindField('id_ligne').asinteger;
              Ta_Affect_Atelier_Ecriture.FindField('ID_Atelier').asinteger:=Ta_Ecriture_Atelier.FindField('ID_Atelier').asinteger;
              Ta_Affect_Atelier_Ecriture.FindField('Libelle').asstring:=Ta_Ecriture_Atelier.FindField('Libelle').asstring;
              Ta_Affect_Atelier_Ecriture.FindField('Ratio').asfloat:=Ta_Ecriture_Atelier.FindField('Ratio').asfloat;
              TableGerePost(Ta_Affect_Atelier_Ecriture);
              Ta_Ecriture_Atelier.next;
            End;
       end;
      Ta_Affect_Atelier_Ecriture.first;
      TableGereCommit(Ta_Affect_Atelier_Ecriture);
      TableGereCommit(DMBalance.TaBalance);
      Ta_Affect_Atelier_Ecriture.Refresh;
     finally
       if ((filtre.filtrer)and(not empty(filtre.filtre)))then
         FiltrageDataSet(Ta_Ecriture_Atelier,filtre.filtre)
       else
         DeFiltrageDataSet(Ta_Ecriture_Atelier);
       DeFiltrageDataSet(Ta_Ecriture_Atelier);
       Ta_Affect_Atelier_Ecriture.BeforeInsert:=Ta_Affect_Atelier_EcritureBeforeInsert;
       Ta_Affect_Atelier_Ecriture.AfterInsert:=Ta_Affect_Atelier_EcritureAfterInsert;
       Ta_Affect_Atelier_Ecriture.BeforePost:=Ta_Affect_Atelier_EcritureBeforePost_AvecAffectation;
       DataEcriture.EnableControls;
     end;
   End;
AffectationCourante_Ecriture.Compte:=DataEcriture.findfield('Compte').asstring;
AffectationCourante_Ecriture.ID_Ligne:=DataEcriture.findfield('id').asinteger;
AffectationCourante_Ecriture.Code_Atelier:=DataEcriture.findfield('code_gestanal').asstring;
AffectationCourante_Ecriture.ID_Atelier:=DataEcriture.findfield('id_gestanal').asinteger;
DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
AffectationCourante_Ecriture.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[DataEcriture.findfield('CODE_GESTANAL').AsString]).Libelle_Atelier;
except
  abort;
end;
finally
end;
End;



procedure TDMAnalytiques.TaPlanAnalAfterScroll(DataSet: TDataSet);
begin
//if not empty(TaPlanAnal.findfield('Compte').asstring) then
//  FiltrageTa_Affect_Atelier_SurCompteCourant(TaPlanAnal.findfield('Compte').asstring,TaPlanAnal);
end;

procedure TDMAnalytiques.Ta_Compte_AtelierAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMBalance.TaBalance);
end;

procedure TDMAnalytiques.TaPlanAnalAfterCancel(DataSet: TDataSet);
begin
CompteEnModif:='';
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
DataSet.Refresh;
//Initialise_TInfosTA_Affect_Atelier(AffectationCourante_compte);
FiltrageTa_Affect_Atelier_SurCompteCourant(DataSet.findfield('compte').asstring,TaPlanAnal);
end;

procedure TDMAnalytiques.TaEcriture_AnalAfterCancel(DataSet: TDataSet);
begin
IdEcritureEnModif:=0;
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
DataSet.Refresh;
//Initialise_TInfosTA_Affect_Atelier(AffectationCourante_ecriture);
FiltrageTa_Affect_Atelier_SurEcritureCourante(DataSet.findfield('id').asstring,TaEcriture_Anal);
end;


function TDMAnalytiques.AffectationExiste_SurCompte(affectation:TInfosTA_Affect_Atelier):boolean;
var
ccourantCompte,CcourantEcriture:integer;
Begin
try
  try
   //Ta_Affect_Atelier_Ecriture.DisableControls;
   ccourantCompte :=Ta_Affect_Atelier_Compte.findfield('ID').asinteger;
   CcourantEcriture:=Ta_Affect_Atelier_ecriture.findfield('ID').asinteger;
   if affectation.id_ligne<>0 then
     begin
       FiltrageDataSet(DMRech.TaTA_Affect_AtelierRech,CreeFiltreET(['id_ligne','Code_Atelier'],[inttostr(affectation.id_ligne),affectation.Code_Atelier]));
       result:=((DMRech.TaTA_Affect_AtelierRech.RecordCount<>0) and(DMRech.TaTA_Affect_AtelierRech.findfield('ID').asinteger<>CcourantEcriture)) ;
     end
   else
     begin
       FiltrageDataSet(DMRech.TaTA_Affect_AtelierRech,CreeFiltreET(['Compte','Code_Atelier'],[affectation.Compte,affectation.Code_Atelier]));
       result:=((DMRech.TaTA_Affect_AtelierRech.RecordCount<>0) and(DMRech.TaTA_Affect_AtelierRech.findfield('ID').asinteger<>ccourantCompte)) ;
     end;
  finally
    DeFiltrageDataSet(DMRech.TaTA_Affect_AtelierRech);
  end;
except
  result:=false;
end;//fin du try except
End;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureAfterDelete(
  DataSet: TDataSet);
begin
//TableGereCommit(DataSet);
//TableGereCommit(DMBalance.TaBalance);
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureAfterEdit(
  DataSet: TDataSet);
begin
if not (TaEcriture_Anal.State in [dsedit])then
  TaEcriture_Anal.edit;
Remplit_TInfosTA_Affect_Atelier(dataset,Affectation_Old);
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureAfterPost(
  DataSet: TDataSet);
begin
//TableGereCommit(DataSet);
//TableGereCommit(DMBalance.TaBalance);
//if TaEcriture_Anal.State in [dsedit]then
//  TableGerePost(TaEcriture_Anal);
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureBeforeDelete(
  DataSet: TDataSet);
var
Filtre:TFiltre;
EventRecord:TFilterRecordEvent;
idcourantEcriture:integer;
begin
//vérifier si pas existant dans autres tables
//si oui ABORT
try
TableGereStartTransaction(dataset);
TableGereStartTransaction(DMBalance.TaBalance);
Remplit_TInfosTA_Affect_Atelier(dataset,Affectation_Old);
filtre.filtre:=Ta_Ecriture_Atelier.Filter;
filtre.filtrer:=Ta_Ecriture_Atelier.Filtered;
FiltrageDataSet(Ta_Ecriture_Atelier,CreeFiltreou('id_ligne',[Affectation_Old.id_ligne]));
idcourantEcriture:=TaEcriture_AnalID.AsInteger;
if Ta_Ecriture_Atelier.Locate('id_Atelier',Affectation_Old.ID_Atelier,[]) then
  TableGereDelete(Ta_Ecriture_Atelier);
if Ta_Ecriture_Atelier.RecordCount= 0 then
//supprimer l'affection dans DmPlanAnal
  begin
    //d'abord il faut désactive le on filter record
    try
    EventRecord:=TaEcriture_Anal.OnFilterRecord;
    TaEcriture_Anal.OnFilterRecord:=nil;
    if not (TaEcriture_Anal.State in [dsinsert,dsedit]) then
      begin
        if not TaEcriture_Anal.Locate('id',idcourantEcriture,[])then
          abort;
        TaEcriture_Anal.Edit;
      end;
    TaEcriture_Anal.FindField('ID_Gestanal').asstring:='';
    TaEcriture_Anal.FindField('Code_Gestanal').asstring:='';
    TableGerePost(TaEcriture_Anal);
    finally
         TaEcriture_Anal.OnFilterRecord:=EventRecord;
         TaEcriture_Anal.Locate('id',idcourantEcriture,[]);
    end;
  end;
finally
  if ((filtre.filtrer)and(not empty(filtre.filtre)))then
    FiltrageDataSet(Ta_Ecriture_Atelier,filtre.filtre)
  else
    DeFiltrageDataSet(Ta_Ecriture_Atelier);
end;

end;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureBeforeInsert(
  DataSet: TDataSet);
begin
if AffectationCourante_Ecriture.ID_Ligne=0 then
  abort;
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureDeleteError(
  DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollback(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcriturePostError(
  DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollback(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMAnalytiques.Ta_Ecriture_AtelierAfterInsert(DataSet: TDataSet);
begin
TableGereStartTransaction(dataset);
TableGereStartTransaction(Ta_Affect_Atelier_ecriture);
InitChampAfterInsert([AffectationCourante_ecriture.ID_Ligne,AffectationCourante_ecriture.ID_Atelier,AffectationCourante_ecriture.Libelle,AffectationCourante_ecriture.Ratio],dataset);
end;

procedure TDMAnalytiques.TaEcriture_AnalBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDMAnalytiques.TaEcriture_AnalBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMAnalytiques.TaPlanAnalBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMAnalytiques.TaPlanAnalBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_CompteAfterPost(
  DataSet: TDataSet);
begin
//TableGereCommit(DataSet);
//TableGereCommit(DMBalance.TaBalance);
//if TaPlanAnal.State in [dsedit]then
//  TableGerePost(TaPlanAnal);
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_EcritureAfterInsert(
  DataSet: TDataSet);
begin
try
if not (TaEcriture_Anal.State in [dsedit])then
  TaEcriture_Anal.edit;
//if AffectationCourante_ecriture.Code_Atelier='*' then
  InitChampAfterInsert([null,null,AffectationCourante_ecriture.ID_Ligne,AffectationCourante_ecriture.Compte,'','',AffectationCourante_ecriture.Ratio],dataset);
//else
//  InitChampAfterInsert([null,AffectationCourante_ecriture.ID_Atelier,AffectationCourante_ecriture.ID_Ligne,AffectationCourante_ecriture.Compte,AffectationCourante_ecriture.Libelle,'',AffectationCourante_ecriture.Ratio],dataset);
dataset.Fields[5].focuscontrol;
finally
//
end;
end;

procedure TDMAnalytiques.Ta_Affect_Atelier_CompteAfterInsert(
  DataSet: TDataSet);
begin
try
if not (TaPlanAnal.State in [dsedit])then
  TaPlanAnal.edit;
//if AffectationCourante_compte.Code_Atelier='*' then
  InitChampAfterInsert([null,null,AffectationCourante_compte.ID_Ligne,AffectationCourante_compte.Compte,'','',AffectationCourante_ecriture.Ratio],dataset);
//else
//  InitChampAfterInsert([null,AffectationCourante_compte.ID_Atelier,AffectationCourante_compte.ID_Ligne,AffectationCourante_compte.Compte,AffectationCourante_compte.Libelle,'',AffectationCourante_compte.Ratio],dataset);
dataset.FieldByName('Code_atelier').FocusControl ;
finally
//
end;
end;

procedure TDMAnalytiques.TaPlanAnalAfterEdit(DataSet: TDataSet);
begin
try
//remplir affectation
TableGereStartTransaction(dataset);
Initialise_TInfosTA_Affect_Atelier(AffectationCourante_compte);
AffectationCourante_compte.Compte:=TaPlanAnalCompte.AsString;
AffectationCourante_compte.Ratio:=1;
DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
AffectationCourante_Compte.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[DataSet.findfield('CODE_GESTANAL').AsString]).Libelle_Atelier;
if TaPlanAnalCODE_GESTANAL.AsString<>'*' then
  begin
    AffectationCourante_compte.Code_Atelier:=TaPlanAnalCODE_GESTANAL.AsString;
    AffectationCourante_compte.ID_Atelier:=TaPlanAnalID_GESTANAL.AsInteger;
  end;
except
 abort;
end;//fin du try except
end;


function TDMAnalytiques.Multi_Affectation(Dataset:Tdataset;affectation:TInfosTA_Affect_Atelier):TInfosTA_Affect_Atelier;
var
filtre:TFiltre;
Begin
try//finally
try//except
Initialise_TInfosTA_Affect_Atelier(result);
result.ResultInfos:=true;
filtre.filtre:=Dataset.Filter;
filtre.filtrer:=Dataset.Filtered;
  if affectation.ID_Ligne<>0 then
    FiltrageDataSet(Dataset,CreeFiltreOU('ID_Ligne',[inttostr(affectation.ID_Ligne)]))
else
  if not empty(affectation.Compte) then
    FiltrageDataSet(Dataset,CreeFiltreOU('Compte',[affectation.Compte]));
if dataset.RecordCount>1 then
  Begin
    result.Code_Atelier:='*';
    result.ID_Atelier:=0;
  End
else
  Begin
    result.ID_Atelier:=dataset.findfield('ID_Atelier').asinteger;
    result.Code_Atelier:=Infos_TInfosTA_Atelier(Ta_Atelier,'id_atelier',[result.ID_Atelier]).Code_Atelier;
  End;
except
  result.ResultInfos:=false;
end;//fin du try except
finally
  if ((filtre.filtrer)and(not empty(filtre.filtre)))then
    FiltrageDataSet(dataset,filtre.filtre)
  else
    DeFiltrageDataSet(dataset);
end;//fin du try finally
End;


procedure TDMAnalytiques.Ta_Compte_AtelierBeforeDelete(DataSet: TDataSet);
begin
TableGereStartTransaction(dataset);
TableGereStartTransaction(DMBalance.TaBalance);
end;

procedure TDMAnalytiques.TaEcriture_AnalAfterEdit(DataSet: TDataSet);
begin
  try
    //remplir affectation
    TableGereStartTransaction(dataset);
    Initialise_TInfosTA_Affect_Atelier(AffectationCourante_Ecriture);
    AffectationCourante_Ecriture.Compte:=TaEcriture_AnalCompte.AsString;
    AffectationCourante_Ecriture.ID_Ligne:=TaEcriture_AnalID.Asinteger;
    AffectationCourante_Ecriture.Ratio:=1;
    DeFiltrageDataSet(dmrech.TaTA_AtelierRech);
    AffectationCourante_Ecriture.Libelle:=Infos_TInfosTA_Atelier(dmrech.TaTA_AtelierRech,'code_atelier',[DataSet.findfield('CODE_GESTANAL').AsString]).Libelle_Atelier;
    if TaEcriture_AnalCODE_GESTANAL.AsString<>'*' then
     begin
       AffectationCourante_Ecriture.Code_Atelier:=TaEcriture_AnalCODE_GESTANAL.AsString;
       AffectationCourante_Ecriture.ID_Atelier:=TaEcriture_AnalID_GESTANAL.AsInteger;
     end;
  except
   abort;
  end;//fin du try except
end;

function TDMAnalytiques.Affectation_APartir_DuCompte(Compte:String;ID_Ligne:integer;DatasetDest:Tdataset):TExceptLGR;
var
Event1,Event2,Event3:Tnotifyevent;
Begin
try//except
//result.retour:=true;
Initialise_ExceptLGR(Result);
TableGereStartTransaction(DatasetDest);
  try//finally
    if DatasetDest= nil then abort;
    DatasetDest.open;
    result.NumErreur:=0;
    result.retour:=true;
    FiltrageDataSet(DMRech.TaTA_Compte_AtelierRech,CreeFiltreOU('Compte',[compte]));
    if DMRech.TaTA_Compte_AtelierRech.recordcount<>0 then
      GestionSuppressionRelation_Ecriture_Atelier(id_ligne,-1);
    DMRech.TaTA_Compte_AtelierRech.first;
    while not(DMRech.TaTA_Compte_AtelierRech.eof) do
      Begin//début while
        DatasetDest.AppendRecord([ID_Ligne,DMRech.TaTA_Compte_AtelierRech.findfield('id_atelier').asinteger,DMRech.TaTA_Compte_AtelierRech.findfield('Libelle').asstring,DMRech.TaTA_Compte_AtelierRech.findfield('ratio').asfloat]);
        DMRech.TaTA_Compte_AtelierRech.next;
      End;//fin du while
  finally
     DeFiltrageDataSet(DMRech.TaTA_Compte_AtelierRech);
  end;//fin du try finally
except
  result.retour:=false;
  raise ExceptLGR.Create(ErrInterne+' ',0,true,mtError,result);end;//fin du try except
End;



// Toutes les ecritures de l'exo courant
procedure TDMAnalytiques.TaEcriture_AnalFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet.FindField('Date')<>nil then
    accept:=((DataSet.FindField('Date').Asdatetime>=e.DatExoDebut) and (DataSet.FindField('Date').Asdatetime<=e.DatExoFin));
end;

// Toutes les ecritures Affectées de l'exo courant
procedure TDMAnalytiques.TaEcriture_AnalFilterRecordAffecte(DataSet: TDataSet;
  var Accept: Boolean);
begin
//Accept:=((int((DataSet.FindField('ID_Piece').AsInteger / 10000000)) = StrToInt_Lgr(E.ExerciceSaisie))
//        and (not empty(DataSet.FindField('CODE_GESTANAL').AsString)));
 if DataSet.FindField('Date')<>nil then
  Accept:=((((DataSet.FindField('Date').Asdatetime>=e.DatExoDebut) and (DataSet.FindField('Date').Asdatetime<=e.DatExoFin)))
        and (not empty(DataSet.FindField('CODE_GESTANAL').AsString)));
//if accept then
//  accept:=((DataSet.FindField('Date').Asdatetime>=e.DatExoDebut) and (DataSet.FindField('Date').Asdatetime<=e.DatExoFin));
end;

// Toutes les ecritures Non Affectées de l'exo courant
procedure TDMAnalytiques.TaEcriture_AnalFilterRecordNonAffecte(DataSet: TDataSet;
  var Accept: Boolean);
begin
//Accept:=((((int((DataSet.FindField('ID_Piece').AsInteger / 10000000)) = StrToInt_Lgr(E.ExerciceSaisie))
//        and (empty(DataSet.FindField('CODE_GESTANAL').AsString))))or(IdEcritureEnModif=DataSet.FindField('ID').AsInteger));
 if DataSet.FindField('Date')<>nil then
Accept:=((((((DataSet.FindField('Date').Asdatetime>=e.DatExoDebut) and (DataSet.FindField('Date').Asdatetime<=e.DatExoFin)))
        and (empty(DataSet.FindField('CODE_GESTANAL').AsString))))or(IdEcritureEnModif=DataSet.FindField('ID').AsInteger));
//if accept then
//  accept:=((DataSet.FindField('Date').Asdatetime>=e.DatExoDebut) and (DataSet.FindField('Date').Asdatetime<=e.DatExoFin));
end;

procedure TDMAnalytiques.TaEcriture_AnalAfterScroll(DataSet: TDataSet);
begin
if not empty(TaEcriture_Anal.findfield('id').asstring) then
  FiltrageTa_Affect_Atelier_SurEcritureCourante(TaEcriture_Anal.findfield('id').asstring,TaEcriture_Anal);
end;

// Tous les comptes du plan comptable
procedure TDMAnalytiques.TaPlanAnalFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept := true;
end;


procedure TDMAnalytiques.TaPlanAnalFilterRecordEcriture(DataSet: TDataSet;
  var Accept: Boolean);
begin
//Accept :=DMPlan.PossedeEcritureSurPeriode(TaPlanAnalCompte.AsString,false);
//if TaEcritureFilterRecord.active=false then TaEcritureFilterRecord.open;
////Accept :=TaEcritureFilterRecord.recordcount<>0;
Accept :=QuEcritureFilterRecord.Locate('Compte',TaPlanAnalCompte.AsString,[]);
end;

// Tous les comptes du plan comptable affectés
procedure TDMAnalytiques.TaPlanAnalFilterRecordAffecte(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=not empty(DataSet.FindField('CODE_GESTANAL').AsString);
end;

// Tous les comptes du plan comptable non affectés
procedure TDMAnalytiques.TaPlanAnalFilterRecordNonAffecte(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=((empty(DataSet.FindField('CODE_GESTANAL').AsString))or(CompteEnModif=DataSet.FindField('Compte').Asstring));
end;

// Tous les comptes du plan comptable affectés et utilisés dans pièce
procedure TDMAnalytiques.TaPlanAnalFilterRecordAffecteUtilise(DataSet: TDataSet;
  var Accept: Boolean);
begin
//if TaEcritureFilterRecord.active=false then TaEcritureFilterRecord.open;
Accept:=((not empty(DataSet.FindField('CODE_GESTANAL').AsString))and(QuEcritureFilterRecord.Locate('Compte',TaPlanAnalCompte.AsString,[])));
////Accept:=((not empty(DataSet.FindField('CODE_GESTANAL').AsString))and(TaEcritureFilterRecord.recordcount<>0));
//Accept:=((not empty(DataSet.FindField('CODE_GESTANAL').AsString))and(DMPlan.PossedeEcritureSurPeriode(TaPlanAnalCompte.AsString,false)));
end;

// Tous les comptes du plan comptable non affectés et utilisés dans pièce
procedure TDMAnalytiques.TaPlanAnalFilterRecordNonAffecteUtilise(DataSet: TDataSet;
  var Accept: Boolean);
begin
//if TaEcritureFilterRecord.active=false then TaEcritureFilterRecord.open;
Accept:=((((empty(DataSet.FindField('CODE_GESTANAL').AsString))or(CompteEnModif=DataSet.FindField('Compte').Asstring)))and(QuEcritureFilterRecord.Locate('Compte',TaPlanAnalCompte.AsString,[])));
////Accept:=((((empty(DataSet.FindField('CODE_GESTANAL').AsString))or(CompteEnModif=DataSet.FindField('Compte').Asstring)))and(TaEcritureFilterRecord.recordcount<>0));
//Accept:=((((empty(DataSet.FindField('CODE_GESTANAL').AsString))or(CompteEnModif=DataSet.FindField('Compte').Asstring)))and(DMPlan.PossedeEcritureSurPeriode(TaPlanAnalCompte.AsString,false)));
end;


procedure TDMAnalytiques.TaPlanAnalBeforeOpen(DataSet: TDataSet);
begin
dataset.Filtered := true;
QuEcritureFilterRecord.Close;
QuEcritureFilterRecord.ParamByName('DateDeb').AsDate:=e.DatExoDebut;
QuEcritureFilterRecord.ParamByName('DateFin').AsDate:=e.DatExoFin;
QuEcritureFilterRecord.open;
//FiltrageDataSet(TaEcritureFilterRecord,'Date >='''+datetostr_lgr(e.DatExoDebut)+''' and date <='''+datetostr_lgr(e.DatExoFin)+'''');
end;

Procedure TDMAnalytiques.AffecteLigneCourante;
var
nouvelleAffection:TInfosTA_Affect_Atelier;
begin
  try
    if not Affectation_APartir_DuCompte(TaEcriture_AnalCompte.AsString,TaEcriture_AnalID.Asinteger,TaAffectationDirecte).retour then
      abort
    else
    begin
//    Initialise_TInfosTA_Affect_Atelier(AffectationCourante_ecriture);
    if Ta_Affect_Atelier_Ecriture.state =dsinactive then Ta_Affect_Atelier_Ecriture.open;
//     FiltrageDataSet(Ta_Ecriture_Atelier,CreeFiltreou('id_ligne',[TaEcriture_AnalID.Asstring]));
//    if Ta_Ecriture_Atelier.RecordCount<>0 then
//       begin
//         AffectationCourante_Ecriture.ID_Ligne:=TaEcriture_AnalID.Asinteger;
//         AffectationCourante_Ecriture.ID_Atelier:=Ta_Ecriture_Atelier.findfield('id_atelier').asinteger;
//         DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
//         AffectationCourante_Ecriture.Code_Atelier:=Infos_TInfosTA_Atelier(DMRech.TaTA_AtelierRech,'id_atelier',[AffectationCourante_Ecriture.ID_Atelier]).Code_Atelier;
//       end;
//    DeFiltrageDataSet(Ta_Ecriture_Atelier);
    FiltrageTa_Affect_Atelier_SurEcritureCourante(TaEcriture_AnalID.Asstring,TaEcriture_Anal);
    nouvelleAffection:=Multi_Affectation(Ta_Ecriture_Atelier,AffectationCourante_Ecriture);
//    if ((nouvelleAffection.ResultInfos)and(TaEcriture_AnalCODE_GESTANAL.asstring<>nouvelleAffection.Code_Atelier)) then
    if ((nouvelleAffection.ResultInfos)and(not empty(nouvelleAffection.Code_Atelier))) then
//    if nouvelleAffection.ResultInfos then
      Begin
        if not (TaEcriture_Anal.State in [dsedit]) then TaEcriture_Anal.edit;
        TaEcriture_AnalID_GESTANAL.asinteger:=nouvelleAffection.ID_Atelier;
        TaEcriture_AnalCODE_GESTANAL.asstring:=nouvelleAffection.Code_Atelier;
        TableGerePost(TaEcriture_Anal);
        TableGereCommit(TaEcriture_Anal);
        TableGereCommit(DMBalance.TaBalance);
      End;
    AffectationCourante_Ecriture.Code_Atelier:=TaEcriture_AnalCODE_GESTANAL.AsString;
    AffectationCourante_Ecriture.ID_Atelier:=TaEcriture_AnalID_GESTANAL.AsInteger;
   end;
  except
    showmessage('Problème à l''affectation de l''écriture en fonction du compte : "AffecteLigneCourante" ');
    abort;
  end;//fin du try except
End;

procedure TDMAnalytiques.AffecteTouteLigne(Vide:boolean);
Begin
TaEcriture_Anal.DisableControls;
Ta_Affect_Atelier_Ecriture.DisableControls;
TaEcriture_Anal.OnFilterRecord:=nil;
//if(vide)then TaEcriture_Anal.OnFilterRecord:=TaEcriture_AnalFilterRecordNonAffecte
//else TaEcriture_Anal.OnFilterRecord:=TaEcriture_AnalFilterRecord;
TaEcriture_Anal.AfterPost:=nil;
if not TaEcriture_Anal.Active then TaEcriture_Anal.Open;
TaEcriture_Anal.First;
while  not TaEcriture_Anal.eof do
 Begin
   if TaEcriture_AnalPieceAnnee.AsBoolean then
     Begin
        if ((empty(TaEcriture_Anal.findField('CODE_GESTANAL').AsString))or(not vide)) then
          AffecteLigneCourante;
     end;
  TaEcriture_Anal.next;
 End;
TaEcriture_Anal.OnFilterRecord:=DMAnalytiques.TaEcriture_AnalFilterRecord;
TaEcriture_Anal.AfterPost:=TaEcriture_AnalAfterPost;
TaEcriture_AnalAfterPost(TaEcriture_Anal);
TaEcriture_Anal.First;
TaEcriture_Anal.EnableControls;
Ta_Affect_Atelier_Ecriture.EnableControls;
End;

Procedure TDMAnalytiques.ViderTouteAffectationEcriture;
Begin
if TaEcriture_Anal.State in [dsEdit] then
 Begin
 showmessage('La Table des ecritures est en édition, abandon !');
 abort;
 End;
try
try//except
  TaEcriture_Anal.DisableControls;
  TaEcriture_Anal.AfterPost:=nil;
  TaEcriture_Anal.OnFilterRecord:=TaEcriture_AnalFilterRecordAffecte;
  if not TaEcriture_Anal.Active then TaEcriture_Anal.Open;
  TaEcriture_Anal.first;
  while not TaEcriture_Anal.eof do
   Begin
    TaEcriture_Anal.Edit;
    TaEcriture_Anal.FindField('CODE_GESTANAL').AsString := '';
    TaEcriture_Anal.FindField('ID_GESTANAL').Asinteger := 0;
    TableGerePost(TaEcriture_Anal);
    TableGereCommit(TaEcriture_Anal);
    TableGereCommit(DMBalance.TaBalance);
    TaEcriture_Anal.first;
    //TaEcriture_Anal.next;
   End;
  TaEcriture_Anal.AfterPost:=TaEcriture_Anal.AfterPost;
  TaEcriture_Anal.OnFilterRecord:=TaEcriture_AnalFilterRecord;
  TaEcriture_Anal.First;
  TaEcriture_Anal.EnableControls;
  except
     showmessage('Problème lors de la réinitialisation de l''affectation des écritures : "ViderTouteAffectationEcriture" ');
     abort;
  end;
finally
//
end;//fin du try finally
End;


procedure TDMAnalytiques.QuMontantEcrParAtelierCalcFields(
  DataSet: TDataSet);
begin
  if  QuMontantEcrParAtelierSumRation.Asfloat<>0 then
    QuMontantEcrParAtelierProRataRatio.AsFloat := QuMontantEcrParAtelierRatio.Asfloat / QuMontantEcrParAtelierSumRation.Asfloat
  else
      QuMontantEcrParAtelierProRataRatio.AsFloat := QuMontantEcrParAtelierRatio.Asfloat;
  QuMontantEcrParAtelierMontantRepartiDebit.AsCurrency := QuMontantEcrParAtelierDebitSaisie.AsCurrency * QuMontantEcrParAtelierProRataRatio.AsFloat;
  QuMontantEcrParAtelierMontantRepartiCredit.AsCurrency := QuMontantEcrParAtelierCreditSaisie.AsCurrency * QuMontantEcrParAtelierProRataRatio.AsFloat;

  QuMontantEcrParAtelierQt1Repartie.AsFloat := QuMontantEcrParAtelierQt1.AsFloat * QuMontantEcrParAtelierProRataRatio.AsFloat;
  QuMontantEcrParAtelierQt2Repartie.AsFloat := QuMontantEcrParAtelierQt2.AsFloat * QuMontantEcrParAtelierProRataRatio.AsFloat;
end;

procedure TDMAnalytiques.QuMontantEcrParAtelierBeforeOpen(
  DataSet: TDataSet);
begin
  QuSumRatio.Close;
  QuMontantEcrParAtelier.SQL.Clear;
  QuMontantEcrParAtelier.SQL.Add('select E.id, E.DebitSaisie, E.CreditSaisie, E.Compte, EcrAt.Id_Atelier, EcrAt.Ratio, Atelier.Code_Atelier, E."Date", E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier from ecriture.db E ');
  QuMontantEcrParAtelier.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Ecriture_Atelier.db" EcrAt on (E.Id = EcrAt.Id_Ligne) ');
if ((e.ExerciceCloture)and(FileExists(E.RepertoireExercice+'Ta_Atelier.db'))) then
  QuMontantEcrParAtelier.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Atelier.db" Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ')
else
  QuMontantEcrParAtelier.SQL.Add(' join Ta_Atelier Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ');
  QuMontantEcrParAtelier.SQL.Add(' group by EcrAt.Id_Atelier , Atelier.Code_Atelier, E.Compte ,E.Id, EcrAt.Ratio, E.DebitSaisie, E.CreditSaisie, E."Date" , E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier');
end;

procedure TDMAnalytiques.QuMontantEcrParAtelierFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if(ListeAtelierResult<>nil) then
  accept:=(ListeAtelierResult.IndexOf(DataSet.FindField('Code_Atelier').AsString) <> -1);
if(listeCompteResult<>nil )and (accept)then
  accept:=(listeCompteResult.IndexOf(DataSet.FindField('compte').AsString[1]) <> -1);
end;


procedure TDMAnalytiques.QuMontantEcrParActiviteFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if(ListeActiviteResult<>nil) and (ListeAtelierResult<>nil) then
  accept:=(ListeActiviteResult.IndexOf(DataSet.FindField('Code_Activite').AsString) <> -1)and(ListeAtelierResult.IndexOf(DataSet.FindField('Code_Atelier').AsString) <> -1);
if(listeCompteResult<>nil )and (accept)then
  accept:=(listeCompteResult.IndexOf(DataSet.FindField('compte').AsString[1]) <> -1);
end;

//Function TDMAnalytiques.GestionSuppressionRelation_Atelier_Compte(Id_Atelier:integer):boolean;
//var
//filtre:TFiltre;
//ListeCompte:Tstringlist;
//Begin
//  //supprimer les relations avec les comptes
//try//finally
//  try//except
//  result:=true;
//  ListeCompte:=tstringlist.create;
//  FiltrageDataSet(Dmrech.TaTA_Compte_AtelierRech,CreeFiltreOU('id_atelier',[inttostr(Id_Atelier)]));
//  ListeCompte:=ChampTableVersListe('compte',Dmrech.TaTA_Compte_AtelierRech);
//  if ListeCompte.Count<>0 then
//    Begin
//       TaPlanAnal.DisableControls;
//       filtre.filtre:=TaPlanAnal.Filter;
//       filtre.filtrer:=TaPlanAnal.Filtered;
//       FiltrageDataSet(TaPlanAnal,CreeFiltreou('compte',[ListeCompte]));
//       TaPlanAnal.First;
//       while not(TaPlanAnal.EOF) do
//         Begin
//           TaPlanAnal.edit;
//           TaPlanAnal.FindField('id_gestanal').asstring:='';
//           TaPlanAnal.FindField('Code_gestanal').asstring:='';
//           TaPlanAnal.Post;
//           TaPlanAnal.Next;
//         End;
//    End;
//  except
//     result:=false;
//  end;//fin du try except
//finally
//    if filtre.filtrer then
//      Begin
//        FiltrageDataSet(TaPlanAnal,filtre.filtre);
//      End
//    else
//      DeFiltrageDataSet(TaPlanAnal);
//    TaPlanAnal.enableControls;
//    if ListeCompte<>nil then ListeCompte.free;
//end;//fin du try finally
//End;


//Function TDMAnalytiques.GestionSuppressionRelation_Atelier_Ecriture(Id_Atelier:integer):boolean;
//var
//filtre:TFiltre;
//Begin
////supprimer les relations avec les lignes d'Ecritures
//try//finally
//  try//except
//  result:=true;
//  TaEcriture_Anal.DisableControls;
//  filtre.filtre:=TaEcriture_Anal.Filter;
//  filtre.filtrer:=TaEcriture_Anal.Filtered;
//  FiltrageDataSet(TaEcriture_Anal,CreeFiltreou('id_Gestanal',[inttostr(Id_Atelier)]));
//  TaEcriture_Anal.First;
//  while not(TaEcriture_Anal.EOF) do
//    Begin
//      TaEcriture_Anal.edit;
//      TaEcriture_Anal.FindField('id_gestanal').asstring:='';
//      TaEcriture_Anal.FindField('Code_gestanal').asstring:='';
//      TaEcriture_Anal.Post;
//      TaEcriture_Anal.Next;
//    End;
//  except
//     result:=false;
//  end;//fin du try except
//finally
//    if filtre.filtrer then
//      Begin
//        FiltrageDataSet(TaEcriture_Anal,filtre.filtre);
//      End
//    else
//      DeFiltrageDataSet(TaEcriture_Anal);
//  TaEcriture_Anal.enableControls;
//end;//fin du try finally
//End;


Procedure TDMAnalytiques.ViderTouteAffectationEcriture_SurSousSelection;
Begin
if TaEcriture_Anal.State in [dsEdit] then
 Begin
 showmessage('La Table des ecritures est en édition, abandon !');
 abort;
 End;
try//finally
try//except
  TaEcriture_Anal.DisableControls;
  TaEcriture_Anal.AfterPost:=nil;
  if not TaEcriture_Anal.Active then TaEcriture_Anal.Open;
  while TaEcriture_Anal.recordcount<>0 do
   Begin
    TaEcriture_Anal.Edit;
    TaEcriture_Anal.FindField('CODE_GESTANAL').AsString := '';
    TaEcriture_Anal.FindField('ID_GESTANAL').Asinteger := 0;
    tablegerePost(TaEcriture_Anal);
    TableGereCommit(TaEcriture_Anal);
    TableGereCommit(DMBalance.TaBalance);
   End;
  TaEcriture_Anal.AfterPost:=TaEcriture_AnalAfterPost;
  TaEcriture_Anal.First;
  TaEcriture_Anal.EnableControls;
  except
     showmessage('Problème lors de la réinitialisation de l''affectation des écritures : "ViderTouteAffectationEcriture_SurSousSelection" ');
     abort;
  end;
finally
//
end;//fin du try finally
End;


//
procedure TDMAnalytiques.AffecteTouteLigne_SurSousSelection;
Begin
//TaEcriture_Anal.DisableControls;
////TaEcriture_Anal.OnFilterRecord:=nil;
//if not TaEcriture_Anal.Active then TaEcriture_Anal.Open;
//TaEcriture_Anal.First;
//while  not TaEcriture_Anal.eof do
// Begin
//  if empty(TaEcriture_Anal.findField('CODE_GESTANAL').AsString) then
//    AffecteLigneCourante;
// End;
////TaEcriture_Anal.OnFilterRecord:=DMAnalytiques.TaEcriture_AnalFilterRecord;
//TaEcriture_Anal.First;
//TaEcriture_Anal.EnableControls;
End;



procedure TDMAnalytiques.nouvelleAffectation_Ecriture(Dataset:Tdataset);
var
nouvelleAffection:TInfosTA_Affect_Atelier;
event:TDataSetNotifyEvent;
begin
try
//si affectation non existantes, alors vide les champs id_Gestanal et Code_Gestanal
event:=TaEcriture_Anal.AfterPost;
TaEcriture_Anal.AfterPost:=nil;
AffectationCourante_Ecriture.ID_Ligne:=TaEcriture_Analid.AsInteger;
AffectationCourante_Ecriture.compte:=TaEcriture_AnalCompte.AsString;
nouvelleAffection:=Multi_Affectation(dataset,AffectationCourante_Ecriture);
if ((nouvelleAffection.ResultInfos)and(TaEcriture_AnalCODE_GESTANAL.asstring<>nouvelleAffection.Code_Atelier)) then
  Begin
    if not (TaEcriture_Anal.State in [dsedit]) then TaEcriture_Anal.edit;
    TaEcriture_AnalID_GESTANAL.asinteger:=nouvelleAffection.ID_Atelier;
    TaEcriture_AnalCODE_GESTANAL.asstring:=nouvelleAffection.Code_Atelier;
  End;
finally
  TableGerePost(TaEcriture_Anal);
  TaEcriture_Anal.AfterPost:=event;
end;
End;


procedure TDMAnalytiques.nouvelleAffectation_Compte(Dataset:Tdataset);
var
nouvelleAffection:TInfosTA_Affect_Atelier;
event:TDataSetNotifyEvent;
begin
try
//si affectation non existantes, alors vide les champs id_Gestanal et Code_Gestanal
event:=TaPlanAnal.AfterPost;
TaPlanAnal.AfterPost:=nil;
AffectationCourante_Compte.Compte:=TaPlanAnalCompte.Asstring;
nouvelleAffection:=Multi_Affectation(dataset,AffectationCourante_Compte);
if ((nouvelleAffection.ResultInfos)and(TaPlanAnalCODE_GESTANAL.asstring<>nouvelleAffection.Code_Atelier)) then
  Begin
    if not (TaPlanAnal.State in [dsedit]) then TaPlanAnal.edit;
    TaPlanAnalID_GESTANAL.asinteger:=nouvelleAffection.ID_Atelier;
    TaPlanAnalCODE_GESTANAL.asstring:=nouvelleAffection.Code_Atelier;
  End;
finally
  TableGerePost(TaPlanAnal);
  TaPlanAnal.AfterPost:=event;
end;
End;

procedure TDMAnalytiques.TaEcriture_AnalBeforeOpen(DataSet: TDataSet);
begin
//dataset.Filtered := true;
end;

procedure TDMAnalytiques.TaEcriture_AnalBeforeEdit(DataSet: TDataSet);
begin
IdEcritureEnModif:=TaEcriture_AnalID.AsInteger;
end;

procedure TDMAnalytiques.TaPlanAnalBeforeEdit(DataSet: TDataSet);
begin
CompteEnModif:=DataSet.findfield('compte').asstring;
end;

procedure TDMAnalytiques.Ta_AtelierBeforeEdit(DataSet: TDataSet);
var
affichemess:boolean;
begin
try
affichemess:=true;
    DataSet.FindField('Code_Atelier').ReadOnly:=false;
    DataSet.FindField('Code_activite').ReadOnly:=false;
if not PossibiliteSuppAtelier(DataSet.FindField('id_atelier').asinteger).retour then
  Begin
    DataSet.FindField('Code_Atelier').ReadOnly:=true;
//    DataSet.FindField('Code_activite').ReadOnly:=true;
  end;
except
  if affichemess then
    Application.Messagebox(Pchar(ErrInterne+' : Ta_AtelierBeforeEdit '+Inttostr(iMain)),Pchar(ErrInterne),0);
  abort;
end;
end;

procedure TDMAnalytiques.Ta_ActiviteBeforeEdit(DataSet: TDataSet);
begin
DataSet.FindField('Code_activite').ReadOnly:=false;
//si activité lié a un atelier, ne pas permettre sa modif
FiltrageDataSet(DMRech.TaTA_Atelier_ActiviteRech,CreeFiltreOU('id_activite',[Ta_Activite.FindField('id_activite').asstring]));
if DMRech.TaTA_Atelier_ActiviteRech.RecordCount<>0 then
  Begin
      DataSet.FindField('Code_activite').ReadOnly:=true;
//      Application.MessageBox(Pchar('Cette activité est liée à un ou plusieurs ateliers, '+#10#13+'si vous voulez la modifier, vous devez d"abord supprimer ces relations !'),'Attention',0);
//      abort;
  End;
end;


function TDMAnalytiques.PossibiliteSuppAtelier(idAtelier:integer):TExceptLGR;
var
RelationCompte,RelationEcriture:integer;
begin
try
RelationCompte:=0;
RelationEcriture:=0;
//result.retour:=true;
//result.NumErreur:=0;
Initialise_ExceptLGR(Result);

FiltrageDataSet(DMRech.TaTA_Atelier_ActiviteRech,CreeFiltreOU('id_atelier',[inttostr(idAtelier)]));

QuPossibiliteSupp_Atelier_Compte.Active:=false;

  QuPossibiliteSupp_Atelier_Compte.SQL.Clear;
  QuPossibiliteSupp_Atelier_Compte.SQL.Add('select A.id_atelier,count(C.id_atelier)as relation_Compte ');
  QuPossibiliteSupp_Atelier_Compte.SQL.Add(' from Ta_Atelier A ');
  QuPossibiliteSupp_Atelier_Compte.SQL.Add(' join "'+E.RepertoireExercice+'ta_compte_atelier.db" C on (A.id_atelier = C.id_atelier) ');
  QuPossibiliteSupp_Atelier_Compte.SQL.Add(' where A.id_atelier=:id ');
  QuPossibiliteSupp_Atelier_Compte.SQL.Add(' group by A.id_atelier,C.id_atelier');
  QuPossibiliteSupp_Atelier_Compte.ParamByName('id').DataType:=ftInteger;

QuPossibiliteSupp_Atelier_Compte.ParamByName('id').asinteger:=idAtelier;
QuPossibiliteSupp_Atelier_Compte.Open;

QuPossibiliteSupp_Atelier_Ecriture.Active:=false;


  QuPossibiliteSupp_Atelier_Ecriture.SQL.Clear;
  QuPossibiliteSupp_Atelier_Ecriture.SQL.Add('select A.id_atelier,count(E.id_atelier)as relation_Ecriture ');
  QuPossibiliteSupp_Atelier_Ecriture.SQL.Add(' from Ta_Atelier A ');
  QuPossibiliteSupp_Atelier_Ecriture.SQL.Add(' join "'+E.RepertoireExercice+'ta_Ecriture_atelier.db" E on (A.id_atelier = E.id_atelier) ');
  QuPossibiliteSupp_Atelier_Ecriture.SQL.Add(' where A.id_atelier=:id ');
  QuPossibiliteSupp_Atelier_Ecriture.SQL.Add(' group by A.id_atelier,E.id_atelier');
  QuPossibiliteSupp_Atelier_Ecriture.ParamByName('id').DataType:=ftInteger;

QuPossibiliteSupp_Atelier_Ecriture.ParamByName('id').asinteger:=idAtelier;
QuPossibiliteSupp_Atelier_Ecriture.Open;

//QuPossibiliteSupp_Atelier_Compte.findfield('relation_Compte').asinteger
//QuPossibiliteSupp_Atelier_Compte.findfield('relation_Ecriture').asinteger
 if QuPossibiliteSupp_Atelier_Compte.recordcount<>0 then
   RelationCompte:=QuPossibiliteSupp_Atelier_Compte.findfield('relation_Compte').asinteger;
 if QuPossibiliteSupp_Atelier_Ecriture.recordcount<>0 then
   RelationEcriture:=QuPossibiliteSupp_Atelier_Ecriture.findfield('relation_Ecriture').asinteger;
     if ((relationcompte<>0) or (relationEcriture<>0)) then
     begin
        Result.retour:=false;
//       raise ExceptLGR.Create('Cet atelier est lié à '+inttostr(relationcompte)+' comptes et '+inttostr(relationEcriture)+' Lignes d"écritures, vous devez supprimer ces relations avant de modifier cet atelier',0001,true,mtError,result)
    end;
except
  //
end;
end;


Function EditionGLivreAnalytiqueAtelierL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Atelier:TStringList;DataSet:TDataSet;Relance:integer):TStringList;overload;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeActivite,ListeEdition:TStringList;
compteTmp,AtelierTmp,UniteNb,LibelleAtelier,LibelleCpt:string;
SousTotDebit,SousTotCredit,TotDebit,
TotCredit,TotalAtelierCourantDebit,
TotalAtelierCourantCredit,TotalGDebit,TotalGCredit,
PU1,PU2,HTDebit,HTCredit:currency;
SousTotQt1,SousTotQt2,TotQt1,TotQt2,
TotalAtelierCourantQt1,TotalAtelierCourantQt2,TotalGQt1,TotalGQt2,NB_Unite_Atelier:real;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
LibelleAtelier:='';
LibelleCpt:='';
CompteTmp:='';
AtelierTmp:='';
SousTotDebit:=0;
SousTotCredit:=0;
TotDebit:=0;
TotCredit:=0;
TotalAtelierCourantDebit:=0;
TotalAtelierCourantCredit:=0;
TotalGDebit:=0;
TotalGCredit:=0;
PU1:=0;
PU2:=0;
SousTotQt1:=0;
SousTotQt2:=0;
TotQt1:=0;
TotQt2:=0;
TotalAtelierCourantQt1:=0;
TotalAtelierCourantQt2:=0;
TotalGQt1:=0;
TotalGQt2:=0;
    ListeValeur:=TStringList.Create;
    ListeActivite:=TStringList.Create;
    ListeEdition:=TStringList.Create;

  if ((DemandePeriode) and(relance<0)) then
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
    if DMAnalytiques =nil then DMAnalytiques:=TDMAnalytiques.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMAnalytiques.ListeFilterRecordEdition.clear;
        DMAnalytiques.ListeFilterCompteEdition.Clear;
        if(listeCpt<>nil)then DMAnalytiques.ListeFilterCompteEdition.Assign(listeCpt);
        if Atelier<>nil then      // Tous les Comptes
         begin
          DMAnalytiques.ListeFilterRecordEdition.Assign(Atelier);
          DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=DMAnalytiques.QuMontantEcrParAtelier_EditionFilterRecord;
         end
        else
          begin
            ListeActivite:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
            FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[ListeActivite]));
//            DMAnalytiques.ListeAtelierResult.Clear;
//            DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
            DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=DMAnalytiques.QuMontantEcrParAtelierFilterRecord;
          end;

        DMAnalytiques.QuSumRatio.Close;
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Clear;

        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add('select E.id, E.DebitSaisie, E.CreditSaisie, E.Compte, EcrAt.Id_Atelier, EcrAt.Ratio, Atelier.Code_Atelier, E."Date", E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(',Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal  from ecriture.db E ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Ecriture_Atelier.db" EcrAt on (E.Id = EcrAt.Id_Ligne) ');
        if ((e.ExerciceCloture)and(FileExists(E.RepertoireExercice+'Ta_Atelier.db'))) then
          DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Atelier.db" Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ')
        else
          DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Atelier Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Activite Activite on (Activite.Id_Activite = Atelier.Id_activite) ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' group by EcrAt.Id_Atelier , Atelier.Code_Atelier, E.Compte ,E.Id, EcrAt.Ratio, E.DebitSaisie, E.CreditSaisie, E."Date" , E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' ,Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal ');

//        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add('select E.id, E.DebitSaisie, E.CreditSaisie, E.Compte, EcrAt.Id_Atelier, EcrAt.Ratio, Atelier.Code_Atelier, E."Date", E.Id_Piece, E.Libelle,E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier from ecriture.db E ');
//        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Ecriture_Atelier.db" EcrAt on (E.Id = EcrAt.Id_Ligne) ');
//        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Atelier Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ');
//        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' group by EcrAt.Id_Atelier , Atelier.Code_Atelier, E.Compte ,E.Id, EcrAt.Ratio, E.DebitSaisie, E.CreditSaisie, E."Date" , E.Id_Piece, E.Libelle,E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier');

        DMAnalytiques.QuMontantEcrParAtelier_Edition.open;
        DMAnalytiques.QuMontantEcrParAtelier_Edition.First;
        if DMAnalytiques.QuMontantEcrParAtelier_Edition.recordcount<>0 then
         begin

                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   'Atelier'+
                                   ';'+
                                   'Libellé atelier'+
                                   ';'+
                                   'Date'+
                                   ';'+
                                   'Compte'+
                                   ';'+
                                   'Désignation'+
                                   ';'+
                                   'charges'+
                                   ';'+
                                   'produits'+
                                   ';'+
                                   'Qt 1'+
                                   ';'+
                                   'PU 1'+
                                   ';'+
                                   'Qt 2'+
                                   ';'+
                                   'PU 2'+
                                   ';'+
                                   'Code activité'+
                                   ';'+
                                   'Libellé activité'+
                                   ';'+
                                   'Nb Unité Atelier'
                                   );

          AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString;
          LibelleAtelier :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_Atelier').AsString;
          UniteNb:='(Unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Unite_Atelier').Asstring
          +') - (Nb d''unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsString+')';
          ListeValeur.Add('5;ATELIER : '+GereLibelle(AtelierTmp)+' - '+GereLibelle(LibelleAtelier));
          compteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString;
          LibelleCpt:=DMPlan.LibelleDuNumCptPCU(compteTmp);
          ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp)+' - '+GereLibelle(LibelleCpt));
          while not DMAnalytiques.QuMontantEcrParAtelier_Edition.Eof do
            begin
                  HTDebit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiDebit').Ascurrency;
                  HTCredit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiCredit').Ascurrency;
                  PU1:=GereDivision(DetermineSolde(HtDebit,HtCredit),DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt1Repartie').Asfloat);
                  PU2:=GereDivision(DetermineSolde(HtDebit,HtCredit),DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt2Repartie').Asfloat);
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   GereLibelle(AtelierTmp)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_atelier').AsString)+
                                   ';'+
                                   DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Date').AsString+
                                   ';'+
                                   GereLibelle(compteTmp)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu2)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite').AsString)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_activite').AsString)+
                                   ';'+
                                   currtostr(NB_Unite_Atelier)
                                   );

                  ListeValeur.Add('0'+
                                   ';'+
                                   DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Date').AsString+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiDebit').AsString+
                                   ';'+
                                   DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiCredit').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt1Repartie').Asfloat)+
                                   ';'+
                                   E.FormatCurrSansDevise(PU1)+
                                   ';'+
                                   E.FormatCurrSansDevise(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt2Repartie').Asfloat)+
                                   ';'+
                                   E.FormatCurrSansDevise(PU2)
                                   );
                SousTotDebit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiDebit').AsCurrency+SousTotDebit;
                SousTotCredit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiCredit').AsCurrency+SousTotCredit;
                SousTotQt1:=SousTotQt1+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt1Repartie').Asfloat;
                SousTotQt2:=SousTotQt2+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt2Repartie').Asfloat;
                NB_Unite_Atelier:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').Asfloat;
                DMAnalytiques.QuMontantEcrParAtelier_Edition.Next;
              if ((compteTmp<>DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)or(AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString)) then
                begin
                  HTDebit:=SousTotDebit;
                  HTCredit:=SousTotCredit;
                  PU1:=GereDivision(DetermineSolde(HtDebit,HtCredit),SousTotQt1);
                  PU2:=GereDivision(DetermineSolde(HtDebit,HtCredit),SousTotQt2);

                  ListeValeur.Add('3;;; @TOTAL : '+CompteTmp+' ;'+E.FormatCurrSansDevise(SousTotDebit) +';'+E.FormatCurrSansDevise(SousTotCredit)+';'+E.FormatCurrSansDevise(SousTotQt1)+';'+E.FormatCurrSansDevise(PU1)+';'+E.FormatCurrSansDevise(SousTotQt2)+';'+E.FormatCurrSansDevise(PU2));
                  TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
                  TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
                  TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
                  TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
                  TotDebit:=TotDebit+SousTotDebit;
                  TotCredit:=TotCredit+SousTotCredit;
                  TotQt1:=TotQt1+SousTotQt1;
                  TotQt2:=TotQt2+SousTotQt2;
                  SousTotDebit:=0;
                  SousTotCredit:=0;
                  SousTotQt1:=0;
                  SousTotQt2:=0;
                  if AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString then
                   begin
                    // Totaux de l'atelier avant changement d'atelier
                    //ListeValeur.Add('3;;; @TOTAL ATELIER : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
                    ListeValeur.Add('3;;; @TOTAL ATELIER : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
                    TotalAtelierCourantDebit:=0;
                    TotalAtelierCourantCredit:=0;
                    TotalAtelierCourantQt1:=0;
                    TotalAtelierCourantQt2:=0;
              DetermineSolde(TotDebit,TotCredit);
              // Affichage du solde
              if TotDebit > 0 then
                ListeValeur.Add('1;;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;' +E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(0))
              else
                ListeValeur.Add('1;;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;' +E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(TotCredit));
                ListeValeur.Add('3;;; @'+UniteNb);
                    if TotDebit > TotCredit then
                      ListeValeur.Add('4;;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(GereDivision(TotDebit,NB_Unite_Atelier,TotDebit)) +';'+E.FormatCurrSansDevise(0))
                    else
                      ListeValeur.Add('4;;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(GereDivision(TotCredit,NB_Unite_Atelier,TotCredit)));
                    TotalGDebit:=TotalGDebit+TotDebit;
                    TotalGCredit:=TotalGCredit+TotCredit;
                    TotalGQt1:=TotalGQt1+TotQt1;
                    TotalGQt2:=TotalGQt2+TotQt2;
                    TotDebit:=0;
                    TotCredit:=0;
                    TotQt1:=0;
                    TotQt2:=0;
                    // Nouvel Atelier
                    AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString;
                    LibelleAtelier :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_Atelier').AsString;
                    UniteNb:='(Unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Unite_Atelier').Asstring
                    +') - (Nb d''unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsString+')';
//                    ListeValeur.Add('5;ATELIER : '+AtelierTmp);
          ListeValeur.Add('5;ATELIER : '+GereLibelle(AtelierTmp)+' - '+GereLibelle(LibelleAtelier));
                   end;
                  compteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString;
                  LibelleCpt:=DMPlan.LibelleDuNumCptPCU(compteTmp);
                  ListeValeur.Add('9;COMPTE : '+compteTmp+' - '+GereLibelle(LibelleCpt));
                end;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
               if not empty(CompteTmp) then
               begin
                TotDebit:=TotDebit+SousTotDebit;
                TotCredit:=TotCredit+SousTotCredit;
                TotQt1:=TotQt1+SousTotQt1;
                TotQt2:=TotQt2+SousTotQt2;
                TotalGDebit:=TotalGDebit+TotDebit;
                TotalGCredit:=TotalGCredit+TotCredit;
                TotalGQt1:=TotalGQt1+TotQt1;
                TotalGQt2:=TotalGQt2+TotQt2;
                  HTDebit:=SousTotDebit;
                  HTCredit:=SousTotCredit;
                  PU1:=GereDivision(DetermineSolde(HtDebit,HtCredit),SousTotQt1);
                  PU2:=GereDivision(DetermineSolde(HtDebit,HtCredit),SousTotQt2);

                  ListeValeur.Add('3;;; @TOTAL : '+CompteTmp+' ;'+E.FormatCurrSansDevise(SousTotDebit) +';'+E.FormatCurrSansDevise(SousTotCredit)+';'+E.FormatCurrSansDevise(SousTotQt1)+';'+E.FormatCurrSansDevise(PU1)+';'+E.FormatCurrSansDevise(SousTotQt2)+';'+E.FormatCurrSansDevise(PU2));
               end;
              // Totaux du dernier atelier
              TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
              TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
              TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
              TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
                  HTDebit:=TotalAtelierCourantDebit;
                  HTCredit:=TotalAtelierCourantCredit;
                  PU1:=GereDivision(DetermineSolde(HtDebit,HtCredit),TotalAtelierCourantQt1);
                  PU2:=GereDivision(DetermineSolde(HtDebit,HtCredit),TotalAtelierCourantQt2);
              ListeValeur.Add('3;;; @TOTAL ATELIER : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
              TotalAtelierCourantDebit:=0;
              TotalAtelierCourantCredit:=0;
              TotalAtelierCourantQt1:=0;
              TotalAtelierCourantQt2:=0;
              DetermineSolde(TotDebit,TotCredit);
              // Affichage du solde
              if TotDebit > 0 then
                ListeValeur.Add('1;;; @Solde (ou marge)  : '+AtelierTmp+' ;' +E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(0))
              else
                ListeValeur.Add('1;;; @Solde (ou marge)  : '+AtelierTmp+' ;' +E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(TotCredit));
                ListeValeur.Add('3;;; @'+UniteNb);
                    if TotDebit > TotCredit then
                      ListeValeur.Add('4;;; @Marge / Unité de Qté Atelier : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(GereDivision(TotDebit,NB_Unite_Atelier,TotDebit)) +';'+E.FormatCurrSansDevise(0))
                    else
                      ListeValeur.Add('4;;; @Marge / Unité de Qté Atelier : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(GereDivision(TotCredit,NB_Unite_Atelier,TotCredit)));

              // Affichage du total général
              ListeValeur.Add('1;;; @TOTAL DE L''ENSEMBLE DES ATELIERS :  ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
          DetermineSolde(TotalGDebit,TotalGCredit);
          if TotalGDebit>0 then
            ListeValeur.Add('1;;; @Solde (ou marge) Générale : ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(0))
          else
            ListeValeur.Add('1;;; @Solde (ou marge) Générale : ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(TotalGCredit));
           ObjPrn.FTitreEdition := 'GRAND-LIVRE ANALYTIQUE';
           ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
           ObjPrn.FNomDossier :='Dossier : '+GereLibelle(E.NomDossier) +' - ' +GereLibelle(e.RaisonSociale);
           ListeValeur.Insert(0,' Date ;Compte ; Désignation ; Charges ; Produits ; Qté 1 ; PU 1 ; Qté 2 ; PU 2 ');
           ListeValeur.Insert(1,'0.7;1;1.5;0.8;0.8;0.5;0.8;0.5;0.8');
           ListeValeur.Insert(2,'texte;texte;texte;curr;curr;float;curr;float;curr');
      //     ListeValeur.Insert(3,'  ; Base  ; Situation début Exer. ; Exercice ; Amortissement ;SURTITRE');
      //     ListeValeur.Insert(4,'2.6;0.8;1.6;0.8;1.6');
         end;
     if ((Relance =1)  or (Relance=2)) then
       begin
           try
             result:=ListeEdition;
             if relance = 1 then ExportDonnees(Result,e.RepertoireExportBalance,'GDL_Ana_'+E.NomDossier + E.NomExo + '.Txt');
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
    Initialise_TStringlist(ListeValeur);
    Initialise_TStringlist(ListeActivite);

     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;//fin finally
end;

Function EditionGLivreAnalytiqueAtelierL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Atelier:String;DataSet:TDataSet;Relance:integer):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Atelier)then
     Maliste.Add(Atelier)
   else
     raise ExceptLGR.Create('Aucun Atelier n''est defini !',1000,true,mtError,Retour);
   result:=EditionGLivreAnalytiqueAtelierL(TypeEdition,DemandePeriode,listeCpt,Maliste,DataSet,Relance);
  except
     abort;
  end;
end;

procedure TDMAnalytiques.QuMontantEcrParAtelier_EditionCalcFields(
  DataSet: TDataSet);
begin
QuMontantEcrParAtelier_Editioncode_atelier_calc.AsString:=QuMontantEcrParAtelier_Editioncode_atelier.AsString;
QuMontantEcrParAtelier_Editionlibelle_atelier_calc.AsString:=QuMontantEcrParAtelier_Editionlibelle_atelier.AsString;
QuMontantEcrParAtelier_Editioncode_activite_calc.AsString:=QuMontantEcrParAtelier_Editioncode_activite.AsString;
QuMontantEcrParAtelier_Editionlibelle_activite_calc.AsString:=QuMontantEcrParAtelier_Editionlibelle_activite.AsString  ;

  if(QuMontantEcrParAtelier_Editioncode_atelier_calc.AsString='') then
  begin
     if(not empty(QuMontantEcrParAtelier_Editioncode_gestanal.AsString))then
       begin
       if(listeAtelierSpecifique.IndexOf(QuMontantEcrParAtelier_Editioncode_gestanal.AsString)<>-1)then
         begin
          QuMontantEcrParAtelier_Editioncode_atelier_calc.AsString:='VIGN';
          QuMontantEcrParAtelier_Editionlibelle_atelier_calc.AsString:='Vignes en production';
          QuMontantEcrParAtelier_Editioncode_activite_calc.AsString:='6';
          QuMontantEcrParAtelier_Editionlibelle_activite_calc.AsString:='Viticulture';
         end
        else
        begin
          QuMontantEcrParAtelier_Editioncode_atelier_calc.AsString:=QuMontantEcrParAtelier_Editioncode_gestanal.AsString;
          QuMontantEcrParAtelier_Editionlibelle_atelier_calc.AsString:=QuMontantEcrParAtelier_Editioncode_gestanal.AsString;
          QuMontantEcrParAtelier_Editioncode_activite_calc.AsString:=QuMontantEcrParAtelier_EditionCodeActiviteAnal.AsString;
          QuMontantEcrParAtelier_Editionlibelle_activite_calc.AsString:=QuMontantEcrParAtelier_EditionCodeActiviteAnal.AsString;
          if(empty(QuMontantEcrParAtelier_Editioncode_atelier_calc.AsString)or(empty(QuMontantEcrParAtelier_Editioncode_activite_calc.AsString)))then
             ProblemeExportation:=true;
        end;
       end
     else
       begin
       ProblemeExportation:=true;
        QuMontantEcrParAtelier_Editioncode_atelier_calc.AsString:='inconnu';
        QuMontantEcrParAtelier_Editionlibelle_atelier_calc.AsString:='inconnu';
        QuMontantEcrParAtelier_Editioncode_activite_calc.AsString:='inconnu';
        QuMontantEcrParAtelier_Editionlibelle_activite_calc.AsString:='inconnu';
       end;
  end;
 if QuMontantEcrParAtelier_EditionSumRation.AsFloat<>0 then
  QuMontantEcrParAtelier_EditionProRataRatio.AsFloat := QuMontantEcrParAtelier_EditionRatio.AsFloat / QuMontantEcrParAtelier_EditionSumRation.AsFloat
 else
  QuMontantEcrParAtelier_EditionProRataRatio.AsFloat := QuMontantEcrParAtelier_EditionRatio.AsFloat;
  QuMontantEcrParAtelier_EditionMontantRepartiDebit.AsCurrency := QuMontantEcrParAtelier_EditionDebitSaisie.AsCurrency * QuMontantEcrParAtelier_EditionProRataRatio.AsFloat;
  QuMontantEcrParAtelier_EditionMontantRepartiCredit.AsCurrency := QuMontantEcrParAtelier_EditionCreditSaisie.AsCurrency * QuMontantEcrParAtelier_EditionProRataRatio.AsFloat;

  QuMontantEcrParAtelier_Editionqt1Repartie.AsFloat := QuMontantEcrParAtelier_Editionqt1.AsFloat * QuMontantEcrParAtelier_EditionProRataRatio.AsFloat;
  QuMontantEcrParAtelier_Editionqt2Repartie.AsFloat := QuMontantEcrParAtelier_Editionqt2.AsFloat * QuMontantEcrParAtelier_EditionProRataRatio.AsFloat;
end;

procedure TDMAnalytiques.QuMontantEcrParAtelier_EditionFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if(ListeFilterRecordEdition<>nil)then
  accept:=(ListeFilterRecordEdition.IndexOf(DataSet.FindField('Code_Atelier').AsString) <> -1);
if(accept) and(ListeFilterCompteEdition<>nil )and(ListeFilterCompteEdition.count<>0)then
  accept:= (ListeFilterCompteEdition.IndexOf(DataSet.FindField('compte').AsString) <> -1);
end;


procedure TDMAnalytiques.QuMontantEcrParActivite_EditionFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if(ListeFilterRecordEdition<>nil)then
  accept:=(ListeFilterRecordEdition.IndexOf(DataSet.FindField('code_activite').AsString) <> -1);
if(accept) and(ListeFilterCompteEdition<>nil )and(ListeFilterCompteEdition.count<>0)then
  accept:= (ListeFilterCompteEdition.IndexOf(DataSet.FindField('compte').AsString) <> -1);
end;

Function EditionBalanceAnalytiqueAtelierL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Atelier:TStringList;DataSet:TDataSet;Relance:integer):TStringList;overload;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeActivite,ListeEdition:TStringList;
compteTmp,AtelierTmp,UniteNb,LibelleAtelier,LibelleCpt:string;
ActiviteTmp,LibelleActiviteTmp:string;
SousTotDebit,SousTotCredit,TotDebit,
TotCredit,TotalAtelierCourantDebit,
TotalAtelierCourantCredit,TotalGDebit,TotalGCredit,
HtDebit,HtCredit,PU1,PU2:currency;
ParamAffichPeriode:TParamAffichPeriode;
SousTotQt1,SousTotQt2,TotQt1,TotQt2,
TotalAtelierCourantQt1,TotalAtelierCourantQt2,TotalGQt1,TotalGQt2,NB_Unite_Atelier:real;
RepertoireAtelier:string;
TrouveAtelier:boolean;

begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
//
LibelleAtelier:='';
LibelleCpt:='';
CompteTmp:='';
AtelierTmp:='';
SousTotDebit:=0;
SousTotCredit:=0;
TotDebit:=0;
TotCredit:=0;
TotalAtelierCourantDebit:=0;
TotalAtelierCourantCredit:=0;
TotalGDebit:=0;
TotalGCredit:=0;
ActiviteTmp:='';
LibelleActiviteTmp:='';

SousTotQt1:=0;
SousTotQt2:=0;
TotQt1:=0;
TotQt2:=0;
TotalAtelierCourantQt1:=0;
TotalAtelierCourantQt2:=0;
TotalGQt1:=0;
TotalGQt2:=0;
TrouveAtelier:=true;
    ListeValeur:=TStringList.Create;
    ListeActivite:=TStringList.Create;
    ListeEdition:=TStringList.Create;


  if ((DemandePeriode) and(relance<0)) then
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
   if ((e.ExerciceCloture)and(not FileExists(E.RepertoireExercice+'Ta_Atelier.db'))) then
      begin
        TrouveAtelier:=false;
//        ShowMessage('La table atelier n''existe pas sur l''exercice : '+e.RepertoireExercice+RetourChariotSimple+
//            'Les quantités ne seront pas calculées.');
       // periode.Retour := false;
      end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];

    if DMAnalytiques =nil then DMAnalytiques:=TDMAnalytiques.Create(Application.MainForm);
    DMAnalytiques.ProblemeExportation:=false;

    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMAnalytiques.ListeFilterRecordEdition.clear;
        DMAnalytiques.ListeFilterCompteEdition.clear;
        if(listeCpt<>nil)then DMAnalytiques.ListeFilterCompteEdition.Assign(listeCpt);
        if Atelier<>nil then      // Tous les Comptes
         begin
          DMAnalytiques.ListeFilterRecordEdition.Assign(Atelier);
          DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=DMAnalytiques.QuMontantEcrParAtelier_EditionFilterRecord;
         end
        else
          begin
//            DMAnalytiques.ListeActiviteResult:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
//            FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[DMAnalytiques.ListeActiviteResult]));
//            DMAnalytiques.ListeAtelierResult.Clear;
//            DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
            if relance<2 then DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=DMAnalytiques.QuMontantEcrParAtelierFilterRecord
            else DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=nil;
          end;
        if(TrouveAtelier)then
          begin
              DMAnalytiques.QuSumRatio.Close;
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Clear;
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add('select E.id, E.DebitSaisie, E.CreditSaisie, E.Compte, EcrAt.Id_Atelier, EcrAt.Ratio, Atelier.Code_Atelier, E."Date", E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(',Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal  from ecriture.db E ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Ecriture_Atelier.db" EcrAt on (E.Id = EcrAt.Id_Ligne) ');
              if (e.ExerciceCloture) then
                DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Atelier.db" Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ')
              else
                DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Atelier Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Activite Activite on (Activite.Id_Activite = Atelier.Id_activite) ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' group by EcrAt.Id_Atelier , Atelier.Code_Atelier, E.Compte ,E.Id, EcrAt.Ratio, E.DebitSaisie, E.CreditSaisie, E."Date" , E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' ,Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal ');
          end
        else
          begin
              DMAnalytiques.QuSumRatio.Close;
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Clear;
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add('select E.id, E.DebitSaisie, E.CreditSaisie, E.Compte, EcrAt.Id_Atelier, EcrAt.Ratio,Atelier.Code_Atelier, E."Date", E.Id_Piece, E.Libelle, E.qt1,E.qt2,(0)as Atelier.NB_Unite_Atelier,('''')as Atelier.Unite_Atelier');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(',Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal  from ecriture.db E ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Ecriture_Atelier.db" EcrAt on (E.Id = EcrAt.Id_Ligne) ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' left join Ta_Atelier Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' left join Ta_Activite Activite on (Activite.Id_Activite = Atelier.Id_activite) ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' group by EcrAt.Id_Atelier , Atelier.Code_Atelier, E.Compte ,E.Id, EcrAt.Ratio, E.DebitSaisie, E.CreditSaisie, E."Date" , E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier ');
              DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' ,Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal ');
          end;
        DMAnalytiques.QuMontantEcrParAtelier_Edition.open;
        if DMAnalytiques.QuMontantEcrParAtelier_Edition.recordcount<>0 then
          begin
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   'Atelier'+
                                   ';'+
                                   'Libellé atelier'+
                                   ';'+
                                   'Compte'+
                                   ';'+
                                   'Désignation'+
                                   ';'+
                                   'Total charges'+
                                   ';'+
                                   'Total produits'+
                                   ';'+
                                   'Qt1'+
                                   ';'+
                                   'PU 1'+
                                   ';'+
                                   'Qt2'+
                                   ';'+
                                   'PU 2'+
                                   ';'+
                                   'Code activité'+
                                   ';'+
                                   'Libellé activité'+
                                   ';'+
                                   'Nb Unité Atelier'
                                   );

          DMAnalytiques.QuMontantEcrParAtelier_Edition.First;
          AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier_calc').AsString;
          LibelleAtelier :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_atelier_calc').AsString;
          UniteNb:='(Unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Unite_Atelier').Asstring
          +') - (Nb d''unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsString+')';
          ListeValeur.Add('9;ATELIER : '+AtelierTmp+' - '+LibelleAtelier);
          compteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString;
          LibelleCpt:=DMPlan.LibelleDuNumCptPCU(CompteTmp);
          NB_Unite_Atelier := DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsFloat;
          ActiviteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite_calc').AsString;
          LibelleActiviteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_activite_calc').AsString;
          while not DMAnalytiques.QuMontantEcrParAtelier_Edition.Eof do
            begin
                SousTotDebit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiDebit').AsCurrency+SousTotDebit;
                SousTotCredit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiCredit').AsCurrency+SousTotCredit;
                SousTotQt1:=SousTotQt1+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt1Repartie').Asfloat;
                SousTotQt2:=SousTotQt2+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt2Repartie').Asfloat;
                Pu1:=GereDivision(DetermineSolde(SousTotDebit,SousTotCredit),SousTotQt1);
                Pu2:=GereDivision(DetermineSolde(SousTotDebit,SousTotCredit),SousTotQt2);
                NB_Unite_Atelier:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').Asfloat;
                DMAnalytiques.QuMontantEcrParAtelier_Edition.Next;
                if(DMAnalytiques.ProblemeExportation)then
                  begin
                     ShowMessage('Problème rencontré sur l''exportation de l''analytique.'+AppelerServiceMaintenance);
                     abort;
                  end;
              if ((compteTmp<>DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)or(AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier_calc').AsString)) then
                begin
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   GereLibelle(AtelierTmp)+
                                   ';'+
                                   GereLibelle(LibelleAtelier)+
                                   ';'+
                                   GereLibelle(compteTmp)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   e.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   e.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   e.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   e.FormatCurrSansDevise(Pu2)+
                                   ';'+
                                   GereLibelle(ActiviteTmp)+
                                   ';'+
                                   GereLibelle(LibelleActiviteTmp)+
                                   ';'+
                                   currtostr(NB_Unite_Atelier)
                                   );

                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(compteTmp)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu2)
                                   );

                  TotDebit:=TotDebit+SousTotDebit;
                  TotCredit:=TotCredit+SousTotCredit;
                  TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
                  TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;

                  TotQt1:=TotQt1+SousTotQt1;
                  TotQt2:=TotQt2+SousTotQt2;
                  TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
                  TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;

                  SousTotDebit:=0;
                  SousTotCredit:=0;
                  SousTotQt1:=0;
                  SousTotQt2:=0;
                  if AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier_calc').AsString then
                   begin
                    // Totaux de l'atelier avant changement d'atelier
                    ListeValeur.Add('3;; @TOTAL ATELIER : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
                    TotalAtelierCourantDebit:=0;
                    TotalAtelierCourantCredit:=0;
                    TotalAtelierCourantQt1:=0;
                    TotalAtelierCourantQt2:=0;
                    // Affichage du solde
                    DetermineSolde(TotDebit,TotCredit);
//                    if TotDebit > TotCredit then
//                      ListeValeur.Add('1;; @Solde (ou marge)  : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(TotDebit)) +';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0))
//                    else
                      ListeValeur.Add('1;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(TotCredit));
          ListeValeur.Add('3;;@'+UniteNb);

                    if TotDebit > TotCredit then
                      ListeValeur.Add('4;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(GereDivision(TotDebit,NB_Unite_Atelier,TotDebit)) +';'+E.FormatCurrSansDevise(0))
                    else
                      ListeValeur.Add('4;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(GereDivision(TotCredit,NB_Unite_Atelier,TotCredit)));

                    TotalGDebit:=TotalGDebit+TotDebit;
                    TotalGCredit:=TotalGCredit+TotCredit;
                    TotalGQt1:=TotalGQt1+TotQt1;
                    TotalGQt2:=TotalGQt2+TotQt2;

                    TotDebit:=0;
                    TotCredit:=0;
                    TotQt1:=0;
                    TotQt2:=0;
                    // Nouvel Atelier
                    AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier_calc').AsString;
                    LibelleAtelier:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_atelier_calc').AsString;
                    ActiviteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite_calc').AsString;
                    LibelleActiviteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_activite_calc').AsString;
                    UniteNb:='(Unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Unite_Atelier').Asstring
          +') - (Nb d''unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsString+')';
          ListeValeur.Add('9;ATELIER : '+GereLibelle(AtelierTmp)+' - '+GereLibelle(LibelleAtelier));
                   end;
                  compteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString;
                  LibelleCpt:=DMPlan.LibelleDuNumCptPCU(CompteTmp);
                end;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
         if not empty(CompteTmp) then
         begin
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   GereLibelle(AtelierTmp)+
                                   ';'+
                                   GereLibelle(LibelleAtelier)+
                                   ';'+
                                   GereLibelle(compteTmp)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   e.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   e.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   e.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   e.FormatCurrSansDevise(Pu2)+
                                   ';'+
                                   GereLibelle(ActiviteTmp)+
                                   ';'+
                                   GereLibelle(LibelleActiviteTmp)+
                                   ';'+
                                   currtostr(NB_Unite_Atelier)
                                   );

                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu2)
                                   );
          TotDebit:=TotDebit+SousTotDebit;
          TotCredit:=TotCredit+SousTotCredit;
          TotQt1:=TotQt1+SousTotQt1;
          TotQt2:=TotQt2+SousTotQt2;
          TotalGDebit:=TotalGDebit+TotDebit;
          TotalGCredit:=TotalGCredit+TotCredit;
          TotalGQt1:=TotalGQt1+TotQt1;
          TotalGQt2:=TotalGQt2+TotQt2;
         end;
          // Totaux du dernier atelier
          TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
          TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
          TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
          TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
          ListeValeur.Add('3;; @TOTAL ATELIER : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
          TotalAtelierCourantDebit:=0;
          TotalAtelierCourantCredit:=0;
          TotalAtelierCourantQt1:=0;
          TotalAtelierCourantQt2:=0;
                    // Affichage du solde
                    DetermineSolde(TotDebit,TotCredit);
//                    if TotDebit > TotCredit then
//                      ListeValeur.Add('1;; @Solde (ou marge)  : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0))
//                    else
//                      ListeValeur.Add('1;; @Solde (ou marge)  : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQt1)+';'+E.FormatCurrSansDevise(TotQt2));
                      ListeValeur.Add('1;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(TotCredit));
          ListeValeur.Add('3;;@'+UniteNb);

                    if TotDebit > TotCredit then
                      ListeValeur.Add('4;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(GereDivision(TotDebit,NB_Unite_Atelier,TotDebit)) +';'+E.FormatCurrSansDevise(0))
                    else
                      ListeValeur.Add('4;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(GereDivision(TotCredit,NB_Unite_Atelier,TotCredit)));
          // Affichage du total général
          ListeValeur.Add('1;; @TOTAL DE L''ENSEMBLE DES ATELIERS :  ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
          DetermineSolde(TotalGDebit,TotalGCredit);
          if  TotalGDebit>0 then
            ListeValeur.Add('1;; @Solde (ou marge) Générale : ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(0))
          else
            ListeValeur.Add('1;; @Solde (ou marge) Générale : ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(TotalGCredit));

           ObjPrn.FTitreEdition := 'BALANCE ANALYTIQUE';
           ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
           ObjPrn.FNomDossier :='Dossier : '+GereLibelle(E.NomDossier) +' - ' +GereLibelle(e.RaisonSociale);
           ListeValeur.Insert(0,' Compte ; Désignation ; Total Charges ; Total Produits ; Qt1 ; PU 1 ; Qt2 ; PU 2');
           ListeValeur.Insert(1,'1;1.5;0.8;0.8;0.8;0.8;0.8;0.8');
           ListeValeur.Insert(2,'texte;texte;curr;curr;float;curr;float;curr');
          end;
     if ((Relance =1)  or (Relance=2)) then
       begin
           try
             result:=ListeEdition;
             if relance = 1 then ExportDonnees(Result,e.RepertoireExportBalance,'Bal_Ana_'+E.NomDossier + E.NomExo + '.Txt');
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally//
  Initialise_TStringlist(ListeValeur);
  Initialise_TStringlist(ListeActivite);
//  Initialise_TStringlist(listeAtelierSpecifique);
    //Initialise_TStringlist(ListeEdition);
  
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;//fin du finally
end;



Function EditionBalanceAnalytiqueActiviteL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Activite:String;DataSet:TDataSet;Relance:integer):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Activite)then
     Maliste.Add(Activite)
   else
     raise ExceptLGR.Create('Aucune Activité n''est definie !',1000,true,mtError,Retour);
   result:=EditionBalanceAnalytiqueActiviteL(TypeEdition,DemandePeriode,listeCpt,Maliste,DataSet,Relance);
  except
     abort;
  end;
end;

Function EditionBalanceAnalytiqueActiviteL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Activite:TStringList;DataSet:TDataSet;Relance:integer):TStringList;overload;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeActivite,ListeEdition:TStringList;
compteTmp,AtelierTmp,UniteNb,LibelleAtelier,LibelleCpt,ActiviteTmp,libelle_activite:string;
SousTotDebit,SousTotCredit,TotDebit,
TotCredit,TotalAtelierCourantDebit,
TotalAtelierCourantCredit,TotalGDebit,TotalGCredit,TotalActiviteCourantDebit,
TotalActiviteCourantCredit,
HtDebit,HtCredit,PU1,PU2:currency;
ParamAffichPeriode:TParamAffichPeriode;
SousTotQt1,SousTotQt2,TotQt1,TotQt2,
TotalAtelierCourantQt1,TotalAtelierCourantQt2,TotalGQt1,TotalGQt2,NB_Unite_Atelier:real;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
//
ActiviteTmp:='';
libelle_activite:='';
LibelleAtelier:='';
LibelleCpt:='';
CompteTmp:='';
AtelierTmp:='';
SousTotDebit:=0;
SousTotCredit:=0;
TotDebit:=0;
TotCredit:=0;
TotalAtelierCourantDebit:=0;
TotalAtelierCourantCredit:=0;
TotalActiviteCourantDebit:=0;
TotalActiviteCourantCredit:=0;
TotalGDebit:=0;
TotalGCredit:=0;

SousTotQt1:=0;
SousTotQt2:=0;
TotQt1:=0;
TotQt2:=0;
TotalAtelierCourantQt1:=0;
TotalAtelierCourantQt2:=0;
TotalGQt1:=0;
TotalGQt2:=0;
    ListeValeur:=TStringList.Create;
    ListeActivite:=TStringList.Create;
    ListeEdition:=TStringList.Create;

  if ((DemandePeriode) and(relance<0)) then
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

    if DMAnalytiques =nil then DMAnalytiques:=TDMAnalytiques.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMAnalytiques.ListeFilterRecordEdition.clear;
        DMAnalytiques.ListeFilterCompteEdition.clear;
        if(listeCpt<>nil)then DMAnalytiques.ListeFilterCompteEdition.Assign(listeCpt);        
        if Activite<>nil then      // Tous les Comptes
         begin
          DMAnalytiques.ListeFilterRecordEdition.Assign(Activite);
          DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=DMAnalytiques.QuMontantEcrParActivite_EditionFilterRecord;
         end
        else
          begin
//            DMAnalytiques.ListeActiviteResult:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
//            FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[DMAnalytiques.ListeActiviteResult]));
//            DMAnalytiques.ListeAtelierResult.Clear;
//            DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
            if relance<2 then DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=DMAnalytiques.QuMontantEcrParActiviteFilterRecord
            else DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=nil;
          end;

        DMAnalytiques.QuSumRatio.Close;
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Clear;
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add('select E.id, E.DebitSaisie, E.CreditSaisie, E.Compte, EcrAt.Id_Atelier, EcrAt.Ratio, Atelier.Code_Atelier, E."Date", E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(',Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal  from ecriture.db E ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Ecriture_Atelier.db" EcrAt on (E.Id = EcrAt.Id_Ligne) ');
        if ((e.ExerciceCloture)and(FileExists(E.RepertoireExercice+'Ta_Atelier.db'))) then
          DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Atelier.db" Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ')
        else
          DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Atelier Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Activite Activite on (Activite.Id_Activite = Atelier.Id_activite) ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' group by EcrAt.Id_Atelier , Atelier.Code_Atelier, E.Compte ,E.Id, EcrAt.Ratio, E.DebitSaisie, E.CreditSaisie, E."Date" , E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' ,Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' order by Atelier.code_activite ,Atelier.code_Atelier,E.Compte,E.id ');

        DMAnalytiques.QuMontantEcrParAtelier_Edition.open;
        if DMAnalytiques.QuMontantEcrParAtelier_Edition.recordcount<>0 then
          begin
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   'Atelier'+
                                   ';'+
                                   'Libellé atelier'+
                                   ';'+
                                   'Compte'+
                                   ';'+
                                   'Désignation'+
                                   ';'+
                                   'Total charges'+
                                   ';'+
                                   'Total produits'+
                                   ';'+
                                   'Qt1'+
                                   ';'+
                                   'PU 1'+
                                   ';'+
                                   'Qt2'+
                                   ';'+
                                   'PU 2'+
                                   ';'+
                                   'Code activité'+
                                   ';'+
                                   'Libellé activité'+
                                   ';'+
                                   'Nb Unité Atelier'
                                   );

          DMAnalytiques.QuMontantEcrParAtelier_Edition.First;
          ActiviteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite').AsString;
          libelle_activite:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Libelle_activite').AsString;
          AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString;
          LibelleAtelier :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_atelier').AsString;
          UniteNb:='(Unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Unite_Atelier').Asstring
          +') - (Nb d''unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsString+')';
          listeValeur.Add('2');
          listeValeur.Add('14;ACTIVITE : '+GereLibelle(ActiviteTmp)+' - '+GereLibelle(libelle_activite));

          ListeValeur.Add('9;ATELIER : '+GereLibelle(AtelierTmp)+' - '+GereLibelle(LibelleAtelier));
          compteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString;
          LibelleCpt:=DMPlan.LibelleDuNumCptPCU(CompteTmp);
          NB_Unite_Atelier := DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsFloat;
          while not DMAnalytiques.QuMontantEcrParAtelier_Edition.Eof do
            begin
                SousTotDebit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiDebit').AsCurrency+SousTotDebit;
                SousTotCredit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiCredit').AsCurrency+SousTotCredit;
                SousTotQt1:=SousTotQt1+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt1Repartie').Asfloat;
                SousTotQt2:=SousTotQt2+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt2Repartie').Asfloat;
                Pu1:=GereDivision(DetermineSolde(SousTotDebit,SousTotCredit),SousTotQt1);
                Pu2:=GereDivision(DetermineSolde(SousTotDebit,SousTotCredit),SousTotQt2);
                NB_Unite_Atelier:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').Asfloat;
                DMAnalytiques.QuMontantEcrParAtelier_Edition.Next;
              if ((compteTmp<>DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)or(AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString)or (ActiviteTmp<>DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('code_activite').AsString)) then
                begin
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   GereLibelle(AtelierTmp)+
                                   ';'+
                                   GereLibelle(LibelleAtelier)+
                                   ';'+
                                   GereLibelle(compteTmp)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu2)+
                                   ';'+
                                   GereLibelle(ActiviteTmp)+
                                   ';'+
                                   GereLibelle(libelle_activite)+
                                   ';'+
                                   currtostr(NB_Unite_Atelier)
                                   );

                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(compteTmp)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu2)
                                   );

                  TotDebit:=TotDebit+SousTotDebit;
                  TotCredit:=TotCredit+SousTotCredit;
                  TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
                  TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;

                  TotQt1:=TotQt1+SousTotQt1;
                  TotQt2:=TotQt2+SousTotQt2;
                  TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
                  TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;

                  SousTotDebit:=0;
                  SousTotCredit:=0;
                  SousTotQt1:=0;
                  SousTotQt2:=0;
                  if AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString then
                   begin
                    // Totaux de l'atelier avant changement d'atelier
                    ListeValeur.Add('3;; @TOTAL ATELIER : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
                    TotalActiviteCourantDebit:=TotalActiviteCourantDebit+TotalAtelierCourantDebit;
                    TotalActiviteCourantCredit:=TotalActiviteCourantCredit+TotalAtelierCourantCredit;

                    TotalAtelierCourantDebit:=0;
                    TotalAtelierCourantCredit:=0;
                    TotalAtelierCourantQt1:=0;
                    TotalAtelierCourantQt2:=0;
                    // Affichage du solde
                    DetermineSolde(TotDebit,TotCredit);
//                    if TotDebit > TotCredit then
//                      ListeValeur.Add('1;; @Solde (ou marge)  : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(TotDebit)) +';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0))
//                    else
                      ListeValeur.Add('1;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(TotCredit));
          ListeValeur.Add('3;;@'+UniteNb);

                    if TotDebit > TotCredit then
                      ListeValeur.Add('4;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(GereDivision(TotDebit,NB_Unite_Atelier,TotDebit)) +';'+E.FormatCurrSansDevise(0))
                    else
                      ListeValeur.Add('4;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(GereDivision(TotCredit,NB_Unite_Atelier,TotCredit)));

                    TotalGDebit:=TotalGDebit+TotDebit;
                    TotalGCredit:=TotalGCredit+TotCredit;
                    TotalGQt1:=TotalGQt1+TotQt1;
                    TotalGQt2:=TotalGQt2+TotQt2;

                    TotDebit:=0;
                    TotCredit:=0;
                    TotQt1:=0;
                    TotQt2:=0;
                  if ActiviteTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite').AsString then
                   begin
                    ListeValeur.Add('3;;; @TOTAL ACTIVITE : '+GereLibelle(ActiviteTmp)+' ;'+E.FormatCurrSansDevise(TotalActiviteCourantDebit) +';'+E.FormatCurrSansDevise(TotalActiviteCourantCredit));
                    DetermineSolde(TotalActiviteCourantDebit,TotalActiviteCourantCredit);
                    ListeValeur.Add('1;;; @Solde (ou marge) : '+GereLibelle(ActiviteTmp)+' ;'+E.FormatCurrSansDevise(TotalActiviteCourantDebit) +';'+E.FormatCurrSansDevise(TotalActiviteCourantCredit));
                    TotalActiviteCourantDebit:=0;
                    TotalActiviteCourantCredit:=0;
                    ActiviteTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite').AsString;
                    libelle_activite :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_Activite').AsString;
                    listeValeur.Add('2');
                    listeValeur.Add('14;ACTIVITE : '+GereLibelle(ActiviteTmp)+' - '+GereLibelle(libelle_activite));
                   end;
                    // Nouvel Atelier
                    AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString;
                    LibelleAtelier:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_atelier').AsString;
                    UniteNb:='(Unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Unite_Atelier').Asstring
          +') - (Nb d''unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsString+')';
          ListeValeur.Add('9;ATELIER : '+GereLibelle(AtelierTmp)+' - '+GereLibelle(LibelleAtelier));
                   end;
                  compteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString;
                  LibelleCpt:=DMPlan.LibelleDuNumCptPCU(CompteTmp);
                end;
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
         if not empty(CompteTmp) then
         begin
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   GereLibelle(AtelierTmp)+
                                   ';'+
                                   GereLibelle(LibelleAtelier)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu2)+
                                   ';'+
                                   GereLibelle(ActiviteTmp)+
                                   ';'+
                                   GereLibelle(libelle_activite)+
                                   ';'+
                                   currtostr(NB_Unite_Atelier)
                                   );

                  ListeValeur.Add('0'+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu2)
                                   );
          TotDebit:=TotDebit+SousTotDebit;
          TotCredit:=TotCredit+SousTotCredit;
          TotQt1:=TotQt1+SousTotQt1;
          TotQt2:=TotQt2+SousTotQt2;
          TotalGDebit:=TotalGDebit+TotDebit;
          TotalGCredit:=TotalGCredit+TotCredit;
          TotalGQt1:=TotalGQt1+TotQt1;
          TotalGQt2:=TotalGQt2+TotQt2;
         end;
          // Totaux du dernier atelier
          TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
          TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
          TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
          TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
          ListeValeur.Add('3;; @TOTAL ATELIER : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
          TotalActiviteCourantDebit:=TotalActiviteCourantDebit+TotalAtelierCourantDebit;
          TotalActiviteCourantCredit:=TotalActiviteCourantCredit+TotalAtelierCourantCredit;
          TotalAtelierCourantDebit:=0;
          TotalAtelierCourantCredit:=0;
          TotalAtelierCourantQt1:=0;
          TotalAtelierCourantQt2:=0;
                    // Affichage du solde
                    DetermineSolde(TotDebit,TotCredit);
                      ListeValeur.Add('1;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(TotCredit));
          ListeValeur.Add('3;;@'+UniteNb);

                    if TotDebit > TotCredit then
                      ListeValeur.Add('4;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(GereDivision(TotDebit,NB_Unite_Atelier,TotDebit)) +';'+E.FormatCurrSansDevise(0))
                    else
                      ListeValeur.Add('4;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(GereDivision(TotCredit,NB_Unite_Atelier,TotCredit)));
          // Affichage du total général
                    //activite
                    ListeValeur.Add('3;;; @TOTAL ACTIVITE : '+GereLibelle(ActiviteTmp)+' ;'+E.FormatCurrSansDevise(TotalActiviteCourantDebit) +';'+E.FormatCurrSansDevise(TotalActiviteCourantCredit));
                    DetermineSolde(TotalActiviteCourantDebit,TotalActiviteCourantCredit);
                    ListeValeur.Add('1;;; @Solde (ou marge) : '+GereLibelle(ActiviteTmp)+' ;'+E.FormatCurrSansDevise(TotalActiviteCourantDebit) +';'+E.FormatCurrSansDevise(TotalActiviteCourantCredit));
                    //fin activite
            ListeValeur.Add('1;;; @TOTAL DE L''ENSEMBLE DES ACTIVITES :  ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
            DetermineSolde(TotalGDebit,TotalGCredit);
            ListeValeur.Add('1;;; @Solde (ou marge) Générale : ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));


           ObjPrn.FTitreEdition := 'BALANCE ANALYTIQUE';
           ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
           ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ListeValeur.Insert(0,' Compte ; Désignation ; Total Charges ; Total Produits ; Qt1 ; PU 1 ; Qt2 ; PU 2');
           ListeValeur.Insert(1,'1;1.5;0.8;0.8;0.8;0.8;0.8;0.8');
           ListeValeur.Insert(2,'texte;texte;curr;curr;float;curr;float;curr');
          end;
     if ((Relance =1)  or (Relance=2)) then
       begin
           try
             result:=ListeEdition;
             if relance = 1 then ExportDonnees(Result,e.RepertoireExportBalance,'Bal_Ana_'+E.NomDossier + E.NomExo + '.Txt');
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally//
  Initialise_TStringlist(ListeValeur);
  Initialise_TStringlist(ListeActivite);
    //Initialise_TStringlist(ListeEdition);

     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;//fin du finally
end;

Function EditionBalanceAnalytiqueAtelierL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Atelier:String;DataSet:TDataSet;Relance:integer):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Atelier)then
     Maliste.Add(Atelier)
   else
     raise ExceptLGR.Create('Aucun Atelier n''est defini !',1000,true,mtError,Retour);
   result:=EditionBalanceAnalytiqueAtelierL(TypeEdition,DemandePeriode,listeCpt,Maliste,DataSet,Relance);
  except
     abort;
  end;
end;

procedure TDMAnalytiques.Ta_AtelierAfterCancel(DataSet: TDataSet);
begin
DataSet.FindField('Code_Atelier').ReadOnly:= false;
DataSet.FindField('Code_Activite').ReadOnly:= false;
DataSet.FindField('Libelle_Atelier').ReadOnly:=false;
end;


function SauvegardeAnalytiqueExo(DestPath:string;SourcePath:string;Table:TTable):TexceptLGR;
begin
try
if Table=nil then Table:=DMRech.TaTA_AtelierRech;
result.retour:=true;
if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
DeFiltrageDataSet(Table);
if SourcePath='Defaut' then SourcePath:=E.RepertoireDossier;
if DestPath='Defaut' then DestPath:=IncludeTrailingPathDelimiter(E.RepertoireExercice)+str_n_prem_char(Table.TableName,LastDelimiter('.',Table.TableName)-1)+'.DB';
TableDuplique(Table,SourcePath,ExtractFileName(DestPath),ExtractFilePath(DestPath),false);
except
  result.retour:=false;
end;
end;

//procedure TDMAnalytiques.TaEcritureFilterRecordFilterRecord(
//  DataSet: TDataSet; var Accept: Boolean);
//begin
////accept:=((TaEcritureFilterRecord.FindField('Date').AsDateTime>=e.DatExoDebut) and (TaEcritureFilterRecord.FindField('Date').AsDateTime<=e.DatExoFin) );
//end;



Function EditionGLivreAnalytiqueActiviteL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Activite:TStringList;DataSet:TDataSet;Relance:integer):TStringList;overload;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeActivite,ListeEdition:TStringList;
compteTmp,AtelierTmp,UniteNb,LibelleAtelier,LibelleCpt,ActiviteTmp,libelle_activite:string;
SousTotDebit,SousTotCredit,TotDebit,
TotCredit,TotalAtelierCourantDebit,
TotalAtelierCourantCredit,TotalGDebit,TotalGCredit,TotalActiviteCourantDebit,
TotalActiviteCourantCredit,
PU1,PU2,HTDebit,HTCredit:currency;
SousTotQt1,SousTotQt2,TotQt1,TotQt2,
TotalAtelierCourantQt1,TotalAtelierCourantQt2,TotalGQt1,TotalGQt2,NB_Unite_Atelier:real;
ParamAffichPeriode:TParamAffichPeriode;
begin
try//finally
ObjPrn:=TObjetEdition.Create(application.MainForm);
ActiviteTmp:='';
libelle_activite:='';
LibelleAtelier:='';
LibelleCpt:='';
CompteTmp:='';
AtelierTmp:='';
SousTotDebit:=0;
SousTotCredit:=0;
TotDebit:=0;
TotCredit:=0;
TotalAtelierCourantDebit:=0;
TotalAtelierCourantCredit:=0;
TotalActiviteCourantDebit:=0;
TotalActiviteCourantCredit:=0;
TotalGDebit:=0;
TotalGCredit:=0;
PU1:=0;
PU2:=0;
SousTotQt1:=0;
SousTotQt2:=0;
TotQt1:=0;
TotQt2:=0;
TotalAtelierCourantQt1:=0;
TotalAtelierCourantQt2:=0;
TotalGQt1:=0;
TotalGQt2:=0;
    ListeValeur:=TStringList.Create;
    ListeActivite:=TStringList.Create;
    ListeEdition:=TStringList.Create;

  if ((DemandePeriode) and(relance<0)) then
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
    if DMAnalytiques =nil then DMAnalytiques:=TDMAnalytiques.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMAnalytiques.ListeFilterRecordEdition.clear;
        DMAnalytiques.ListeFilterCompteEdition.clear;
        if(listeCpt<>nil)then DMAnalytiques.ListeFilterCompteEdition.Assign(listeCpt);
        if Activite<>nil then      // Tous les Comptes
         begin
          DMAnalytiques.ListeFilterRecordEdition.Assign(Activite);
          DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=DMAnalytiques.QuMontantEcrParActivite_EditionFilterRecord;
         end
        else
          begin
            ListeActivite:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
            FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[ListeActivite]));
//            DMAnalytiques.ListeAtelierResult.Clear;
//            DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
            DMAnalytiques.QuMontantEcrParAtelier_Edition.OnFilterRecord:=DMAnalytiques.QuMontantEcrParActiviteFilterRecord;
          end;

        DMAnalytiques.QuSumRatio.Close;
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Clear;

        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add('select E.id, E.DebitSaisie, E.CreditSaisie, E.Compte, EcrAt.Id_Atelier, EcrAt.Ratio, Atelier.Code_Atelier, E."Date", E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(',Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal  from ecriture.db E ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Ecriture_Atelier.db" EcrAt on (E.Id = EcrAt.Id_Ligne) ');
        if ((e.ExerciceCloture)and(FileExists(E.RepertoireExercice+'Ta_Atelier.db'))) then
          DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join "'+E.RepertoireExercice+'Ta_Atelier.db" Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ')
        else
          DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Atelier Atelier on (Atelier.Id_Atelier = EcrAt.Id_Atelier) ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' join Ta_Activite Activite on (Activite.Id_Activite = Atelier.Id_activite) ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' group by  Atelier.Code_Atelier,EcrAt.Id_Atelier , E.Compte ,E.Id, EcrAt.Ratio, E.DebitSaisie, E.CreditSaisie, E."Date" , E.Id_Piece, E.Libelle, E.qt1,E.qt2,Atelier.NB_Unite_Atelier,Atelier.Unite_Atelier ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' ,Atelier.id_activite,Atelier.code_activite,Activite.libelle_activite,Atelier.libelle_atelier,E.code_gestanal ');
        DMAnalytiques.QuMontantEcrParAtelier_Edition.SQL.Add(' order by Atelier.code_activite ,Atelier.code_Atelier,E.Compte,E.id ');

        DMAnalytiques.QuMontantEcrParAtelier_Edition.open;
        DMAnalytiques.QuMontantEcrParAtelier_Edition.First;
        if DMAnalytiques.QuMontantEcrParAtelier_Edition.recordcount<>0 then
         begin
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   'Atelier'+
                                   ';'+
                                   'Libellé atelier'+
                                   ';'+
                                   'Date'+
                                   ';'+
                                   'Compte'+
                                   ';'+
                                   'Désignation'+
                                   ';'+
                                   'charges'+
                                   ';'+
                                   'produits'+
                                   ';'+
                                   'Qt 1'+
                                   ';'+
                                   'PU 1'+
                                   ';'+
                                   'Qt 2'+
                                   ';'+
                                   'PU 2'+
                                   ';'+
                                   'Code activité'+
                                   ';'+
                                   'Libellé activité'+
                                   ';'+
                                   'Nb Unité Atelier'
                                   );

          ActiviteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite').AsString;
          libelle_activite:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Libelle_activite').AsString;
          AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString;
          LibelleAtelier :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_Atelier').AsString;
          UniteNb:='(Unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Unite_Atelier').Asstring
          +') - (Nb d''unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsString+')';
          listeValeur.Add('2');
          listeValeur.Add('14;ACTIVITE : '+GereLibelle(ActiviteTmp)+' - '+GereLibelle(libelle_activite));
          ListeValeur.Add('5;ATELIER : '+GereLibelle(AtelierTmp)+' - '+GereLibelle(LibelleAtelier));
          compteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString;
          LibelleCpt:=DMPlan.LibelleDuNumCptPCU(compteTmp);
          ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp)+' - '+GereLibelle(LibelleCpt));
          while not DMAnalytiques.QuMontantEcrParAtelier_Edition.Eof do
            begin
                  HTDebit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiDebit').Ascurrency;
                  HTCredit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiCredit').Ascurrency;
                  PU1:=GereDivision(DetermineSolde(HtDebit,HtCredit),DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt1Repartie').Asfloat);
                  PU2:=GereDivision(DetermineSolde(HtDebit,HtCredit),DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt2Repartie').Asfloat);
                  ListeEdition.Add('Analytique'+
                                   ';'+
                                   GereLibelle(AtelierTmp)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_atelier').AsString)+
                                   ';'+
                                   DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Date').AsString+
                                   ';'+
                                   GereLibelle(compteTmp)+
                                   ';'+
                                   GereLibelle(DMPlan.LibelleDuNumCptPCU(CompteTmp))+
                                   ';'+
                                   currtostr(SousTotDebit)+
                                   ';'+
                                   currtostr(SousTotCredit)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt1)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu1)+
                                   ';'+
                                   E.FormatCurrSansDevise(SousTotQt2)+
                                   ';'+
                                   E.FormatCurrSansDevise(Pu2)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite').AsString)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_activite').AsString)+
                                   ';'+
                                   currtostr(NB_Unite_Atelier)
                                   );

                  ListeValeur.Add('0'+
                                   ';'+
                                   DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Date').AsString+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)+
                                   ';'+
                                   GereLibelle(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Libelle').AsString)+
                                   ';'+
                                   DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiDebit').AsString+
                                   ';'+
                                   DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiCredit').AsString+
                                   ';'+
                                   E.FormatCurrSansDevise(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt1Repartie').Asfloat)+
                                   ';'+
                                   E.FormatCurrSansDevise(PU1)+
                                   ';'+
                                   E.FormatCurrSansDevise(DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt2Repartie').Asfloat)+
                                   ';'+
                                   E.FormatCurrSansDevise(PU2)
                                   );
                SousTotDebit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiDebit').AsCurrency+SousTotDebit;
                SousTotCredit:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('MontantRepartiCredit').AsCurrency+SousTotCredit;
                SousTotQt1:=SousTotQt1+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt1Repartie').Asfloat;
                SousTotQt2:=SousTotQt2+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Qt2Repartie').Asfloat;
                NB_Unite_Atelier:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').Asfloat;
                DMAnalytiques.QuMontantEcrParAtelier_Edition.Next;
              if ((compteTmp<>DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString)or(AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString)or (ActiviteTmp<>DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('code_activite').AsString)) then
                begin
                  HTDebit:=SousTotDebit;
                  HTCredit:=SousTotCredit;
                  PU1:=GereDivision(DetermineSolde(HtDebit,HtCredit),SousTotQt1);
                  PU2:=GereDivision(DetermineSolde(HtDebit,HtCredit),SousTotQt2);

                  ListeValeur.Add('3;;; @TOTAL : '+GereLibelle(CompteTmp)+' ;'+E.FormatCurrSansDevise(SousTotDebit) +';'+E.FormatCurrSansDevise(SousTotCredit)+';'+E.FormatCurrSansDevise(SousTotQt1)+';'+E.FormatCurrSansDevise(PU1)+';'+E.FormatCurrSansDevise(SousTotQt2)+';'+E.FormatCurrSansDevise(PU2));
                  TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
                  TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
                  TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
                  TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
                  TotDebit:=TotDebit+SousTotDebit;
                  TotCredit:=TotCredit+SousTotCredit;
                  TotQt1:=TotQt1+SousTotQt1;
                  TotQt2:=TotQt2+SousTotQt2;
                  SousTotDebit:=0;
                  SousTotCredit:=0;
                  SousTotQt1:=0;
                  SousTotQt2:=0;
                  if AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString then
                   begin
                    // Totaux de l'atelier avant changement d'atelier
                    //ListeValeur.Add('3;;; @TOTAL ATELIER : '+AtelierTmp+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
                    ListeValeur.Add('3;;; @TOTAL ATELIER : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
                    TotalActiviteCourantDebit:=TotalActiviteCourantDebit+TotalAtelierCourantDebit;
                    TotalActiviteCourantCredit:=TotalActiviteCourantCredit+TotalAtelierCourantCredit;
                    TotalAtelierCourantDebit:=0;
                    TotalAtelierCourantCredit:=0;
                    TotalAtelierCourantQt1:=0;
                    TotalAtelierCourantQt2:=0;
              DetermineSolde(TotDebit,TotCredit);
              // Affichage du solde
              if TotDebit > 0 then
                ListeValeur.Add('1;;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;' +E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(0))
              else
                ListeValeur.Add('1;;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;' +E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(TotCredit));
                ListeValeur.Add('3;;; @'+UniteNb);
                    if TotDebit > TotCredit then
                      ListeValeur.Add('4;;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(GereDivision(TotDebit,NB_Unite_Atelier,TotDebit)) +';'+E.FormatCurrSansDevise(0))
                    else
                      ListeValeur.Add('4;;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(GereDivision(TotCredit,NB_Unite_Atelier,TotCredit)));
                    TotalGDebit:=TotalGDebit+TotDebit;
                    TotalGCredit:=TotalGCredit+TotCredit;
                    TotalGQt1:=TotalGQt1+TotQt1;
                    TotalGQt2:=TotalGQt2+TotQt2;
                    TotDebit:=0;
                    TotCredit:=0;
                    TotQt1:=0;
                    TotQt2:=0;
                  if ActiviteTmp <> DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite').AsString then
                   begin
//            ListeValeur.Add('1;;; @TOTAL DE L''ENSEMBLE DES ATELIERS POUR L''ACTIVITE : '+ActiviteTmp+'  ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
//            DetermineSolde(TotalGDebit,TotalGCredit);
//            ListeValeur.Add('1;;; @Solde (ou marge) Générale : ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
//            TotalGDebit:=0;
//            TotalGCredit:=0;

                    ListeValeur.Add('3;;; @TOTAL ACTIVITE : '+GereLibelle(ActiviteTmp)+' ;'+E.FormatCurrSansDevise(TotalActiviteCourantDebit) +';'+E.FormatCurrSansDevise(TotalActiviteCourantCredit));
                    DetermineSolde(TotalActiviteCourantDebit,TotalActiviteCourantCredit);
                    ListeValeur.Add('1;;; @Solde (ou marge) : '+GereLibelle(ActiviteTmp)+' ;'+E.FormatCurrSansDevise(TotalActiviteCourantDebit) +';'+E.FormatCurrSansDevise(TotalActiviteCourantCredit));
                    TotalActiviteCourantDebit:=0;
                    TotalActiviteCourantCredit:=0;
                    ActiviteTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Activite').AsString;
                    libelle_activite :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_Activite').AsString;
                    listeValeur.Add('2');
                    listeValeur.Add('14;ACTIVITE : '+GereLibelle(ActiviteTmp)+' - '+GereLibelle(libelle_activite));
                   end;
                    // Nouvel Atelier
                    AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Code_Atelier').AsString;
                    LibelleAtelier :=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('libelle_Atelier').AsString;
                    UniteNb:='(Unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Unite_Atelier').Asstring
                    +') - (Nb d''unité : '+DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('NB_Unite_Atelier').AsString+')';
          ListeValeur.Add('5;ATELIER : '+GereLibelle(AtelierTmp)+' - '+GereLibelle(LibelleAtelier));
                   end;//fin si atelier à changé
                  compteTmp:=DMAnalytiques.QuMontantEcrParAtelier_Edition.FindField('Compte').AsString;
                  LibelleCpt:=DMPlan.LibelleDuNumCptPCU(compteTmp);
                  ListeValeur.Add('9;COMPTE : '+GereLibelle(compteTmp)+' - '+GereLibelle(LibelleCpt));
                end; //fin si compte à changé
            end;//fin du while not DataModuleImmos.QuAcquisition_Edition.eof
               if not empty(CompteTmp) then
               begin
                TotDebit:=TotDebit+SousTotDebit;
                TotCredit:=TotCredit+SousTotCredit;
                TotQt1:=TotQt1+SousTotQt1;
                TotQt2:=TotQt2+SousTotQt2;
                TotalGDebit:=TotalGDebit+TotDebit;
                TotalGCredit:=TotalGCredit+TotCredit;
                TotalGQt1:=TotalGQt1+TotQt1;
                TotalGQt2:=TotalGQt2+TotQt2;
                  HTDebit:=SousTotDebit;
                  HTCredit:=SousTotCredit;
                  PU1:=GereDivision(DetermineSolde(HtDebit,HtCredit),SousTotQt1);
                  PU2:=GereDivision(DetermineSolde(HtDebit,HtCredit),SousTotQt2);

                  ListeValeur.Add('3;;; @TOTAL : '+GereLibelle(CompteTmp)+' ;'+E.FormatCurrSansDevise(SousTotDebit) +';'+E.FormatCurrSansDevise(SousTotCredit)+';'+E.FormatCurrSansDevise(SousTotQt1)+';'+E.FormatCurrSansDevise(PU1)+';'+E.FormatCurrSansDevise(SousTotQt2)+';'+E.FormatCurrSansDevise(PU2));
               end;
              // Totaux du dernier atelier
              TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
              TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
              TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
              TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
                  HTDebit:=TotalAtelierCourantDebit;
                  HTCredit:=TotalAtelierCourantCredit;
                  PU1:=GereDivision(DetermineSolde(HtDebit,HtCredit),TotalAtelierCourantQt1);
                  PU2:=GereDivision(DetermineSolde(HtDebit,HtCredit),TotalAtelierCourantQt2);
              ListeValeur.Add('3;;; @TOTAL ATELIER : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(TotalAtelierCourantDebit) +';'+E.FormatCurrSansDevise(TotalAtelierCourantCredit));
                    TotalActiviteCourantDebit:=TotalActiviteCourantDebit+TotalAtelierCourantDebit;
                    TotalActiviteCourantCredit:=TotalActiviteCourantCredit+TotalAtelierCourantCredit;
              TotalAtelierCourantDebit:=0;
              TotalAtelierCourantCredit:=0;
              TotalAtelierCourantQt1:=0;
              TotalAtelierCourantQt2:=0;
              DetermineSolde(TotDebit,TotCredit);
              // Affichage du solde
              if TotDebit > 0 then
                ListeValeur.Add('1;;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;' +E.FormatCurrSansDevise(TotDebit) +';'+E.FormatCurrSansDevise(0))
              else
                ListeValeur.Add('1;;; @Solde (ou marge)  : '+GereLibelle(AtelierTmp)+' ;' +E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(TotCredit));
                ListeValeur.Add('3;;; @'+UniteNb);
                    if TotDebit > TotCredit then
                      ListeValeur.Add('4;;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(GereDivision(TotDebit,NB_Unite_Atelier,TotDebit)) +';'+E.FormatCurrSansDevise(0))
                    else
                      ListeValeur.Add('4;;; @Marge / Unité de Qté Atelier : '+GereLibelle(AtelierTmp)+' ;'+E.FormatCurrSansDevise(0) +';'+E.FormatCurrSansDevise(GereDivision(TotCredit,NB_Unite_Atelier,TotCredit)));
                    //activite
//            ListeValeur.Add('1;;; @TOTAL DE L''ENSEMBLE DES ATELIERS POUR L''ACTIVITE : '+ActiviteTmp+'  ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
//            DetermineSolde(TotalGDebit,TotalGCredit);
//            ListeValeur.Add('1;;; @Solde (ou marge) Générale : ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
//            TotalGDebit:=0;
//            TotalGCredit:=0;
                    ListeValeur.Add('3;;; @TOTAL ACTIVITE : '+GereLibelle(ActiviteTmp)+' ;'+E.FormatCurrSansDevise(TotalActiviteCourantDebit) +';'+E.FormatCurrSansDevise(TotalActiviteCourantCredit));
                    DetermineSolde(TotalActiviteCourantDebit,TotalActiviteCourantCredit);
                    ListeValeur.Add('1;;; @Solde (ou marge) : '+GereLibelle(ActiviteTmp)+' ;'+E.FormatCurrSansDevise(TotalActiviteCourantDebit) +';'+E.FormatCurrSansDevise(TotalActiviteCourantCredit));
                    //fin activite
              // Affichage du total général

            ListeValeur.Add('1;;; @TOTAL DE L''ENSEMBLE DES ACTIVITES :  ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
            DetermineSolde(TotalGDebit,TotalGCredit);
            ListeValeur.Add('1;;; @Solde (ou marge) Générale : ;'+E.FormatCurrSansDevise(TotalGDebit) +';'+E.FormatCurrSansDevise(TotalGCredit));
              
           ObjPrn.FTitreEdition := 'GRAND-LIVRE ANALYTIQUE';
           ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
           ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
           ListeValeur.Insert(0,' Date ;Compte ; Désignation ; Charges ; Produits ; Qté 1 ; PU 1 ; Qté 2 ; PU 2 ');
           ListeValeur.Insert(1,'0.7;1;1.5;0.8;0.8;0.5;0.8;0.5;0.8');
           ListeValeur.Insert(2,'texte;texte;texte;curr;curr;float;curr;float;curr');
      //     ListeValeur.Insert(3,'  ; Base  ; Situation début Exer. ; Exercice ; Amortissement ;SURTITRE');
      //     ListeValeur.Insert(4,'2.6;0.8;1.6;0.8;1.6');
         end;
     if ((Relance =1)  or (Relance=2)) then
       begin
           try
             result:=ListeEdition;
             if relance = 1 then ExportDonnees(Result,e.RepertoireExportBalance,'GDL_Ana_'+E.NomDossier + E.NomExo + '.Txt');
           except
           end;
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
    Initialise_TStringlist(ListeValeur);
    Initialise_TStringlist(ListeActivite);

     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;//fin finally
end;

Function EditionGLivreAnalytiqueActiviteL(TypeEdition : integer; DemandePeriode:Boolean; listeCpt:Tstringlist;Activite:String;DataSet:TDataSet;Relance:integer):TStringList;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
Initialise_ExceptLGR(Retour);
  try
   Maliste:=TStringList.Create;
   if not empty (Activite)then
     Maliste.Add(Activite)
   else
     raise ExceptLGR.Create('Aucune Activite n''est definie !',1000,true,mtError,Retour);
   result:=EditionGLivreAnalytiqueAtelierL(TypeEdition,DemandePeriode,listeCpt,Maliste,DataSet,Relance);
  except
     abort;
  end;
end;

procedure TDMAnalytiques.QuMontantEcrParAtelier_EditionBeforeOpen(
  DataSet: TDataSet);
begin
TaAtelierDefaut.Close;
TaAtelierDefaut.Open;
end;


Function EditionActivitesL(TypeEdition : integer;DataSet:TDataSet):Boolean;
var
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
Requete:TQuery;
RepertoireTable:string;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DMAnalytiques =nil then DMAnalytiques:=TDMAnalytiques.Create(Application.MainForm);
          Requete:=TQuery.Create(application.MainForm);
          RepertoireTable:=e.RepertoireDossier;
          if FileExists(e.RepertoireExercice+'ta_activite.db')then
            RepertoireTable:=e.RepertoireExercice;
          Requete.DatabaseName:=RepertoireTable;
          Requete.SQL.Clear;
          Requete.SQL.Add('select * from ta_activite  ');
          Requete.Open;
          Requete.first;
          if Requete.recordcount<>0 then
          begin
          with Requete do
              begin
                      while not Eof do
                        begin
                              ListeValeur.Add('0'+
                                               ';'+
                                               FindField('Code_activite').Asstring+
                                               ';'+
                                               FindField('libelle_activite').Asstring);
                                next;
                        end;//fin du while not eof
                 ObjPrn.FTitreEdition := ' Liste des activités:';
                 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;

                 ListeValeur.Insert(0,' Code de l''activité ; libellé ');
                 ListeValeur.Insert(1,'2.0;4.0');
                 ListeValeur.Insert(2,'texte;texte');
              end;//fin du with
          end;
          ObjPrn.AffichageImp(ListeValeur);
//  end;//fin du periode.retour
finally
     LibereObjet(Tobject(Requete));
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;


Function EditionAteliersL(TypeEdition : integer; DataSet:TDataSet):Boolean;
var
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
TitreCompte:string;
ParamAffichPeriode:TParamAffichPeriode;
Requete:TQuery;
RepertoireTable:string;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;

    if DMAnalytiques =nil then DMAnalytiques:=TDMAnalytiques.Create(Application.MainForm);
          Requete:=TQuery.Create(application.MainForm);
          RepertoireTable:=e.RepertoireDossier;
          if FileExists(e.RepertoireExercice+'ta_atelier.db')then
            RepertoireTable:=e.RepertoireExercice;
          Requete.DatabaseName:=RepertoireTable;
          Requete.SQL.Clear;
          Requete.SQL.Add('select * from ta_atelier  ');
          Requete.Open;
          Requete.first;
          if Requete.recordcount<>0 then
          begin
          with Requete do
              begin
                      while not Eof do
                        begin
                              ListeValeur.Add('0'+
                                               ';'+
                                               FindField('Code_atelier').Asstring+
                                               ';'+
                                               FindField('libelle_atelier').Asstring+
                                               ';'+
                                               FindField('nb_unite_atelier').Asstring+
                                               ';'+
                                               FindField('unite_atelier').Asstring+
                                               ';'+
                                               FindField('code_activite').Asstring
                                               );
                                next;
                        end;//fin du while not eof
                 ObjPrn.FTitreEdition := ' Liste des ateliers:';
                 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;

                 ListeValeur.Insert(0,' Code atelier ; libellé ; nb. unité ; unité ; code activité ');
                 ListeValeur.Insert(1,'1.0;3.0;0.8;1.0;1.0');
                 ListeValeur.Insert(2,'texte;texte;float;texte;texte');
              end;//fin du with
          end;
          ObjPrn.AffichageImp(ListeValeur);
//  end;//fin du periode.retour
finally
     LibereObjet(Tobject(Requete));
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;
end.
