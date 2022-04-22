{$DEFINE Diocese}
{***************************************************************
 *
 * Unit Name: E2_Main
 * Purpose  :
 * Author   :  JS, BP, IA
 * History  :
 *
 ****************************************************************}

// Ecran du menu pricipal
// Tout est commenté
unit E2_Main;

interface

uses
  Windows,SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, Menus, ExtCtrls,XLSFile,
    //Gr_Calculatrice,
  ComCtrls, ToolWin, Gr_Librairie_obj,DBTables, Db,
  {Gr_LecTab, Gr_Sql, E2_VisuPiece,E2_SaisieRegnmt,}Gr_MultDos,Registry,
//  RXShell,
  //SpeedBar,
//  GIFCtrl,
//  ComObj,
  DMChargesAPayer,E2_Provisions_Isa, RxMenus, RXClock, RXCtrls,
   GestPlan,LibZoneSaisie,
   //GrDBGrid,
   //piece,
   {LibDates,}E2_AssistantClotureDef,FileCtrl,LibRessourceString,
//  OleCtrls,
  //AgentObjects_TLB,
  //Grids,
  LibFichRep,E2_Decl_Records,ImportDll,lib_chaine
  ,ShlObj,shellApi,FileUtil,
  //DDEMan,
  //LibConvertisseur,
  libdates,
  //RxRichEd,
  E2_Patientez,E2_LibInfosTable,
  //Grids,
  //GrGrid,
  //ShockwaveFlashObjects_TLB,
//  DBGrids,
  ChoixPeriode,
  UMail,
  E2_VisuListeView,
  ImgList,
  LibGestionParamXML,
  AffectImmoCptCOGERE,
  LibSaisieIP,
  E2_ConfirmImportCOGERE,
  ObjetEdition,
  E2_AideModel,
  E2_InfosEpicea,
  DMAnalytique,
  DMCorrection,
  UniteCorrection,
  DMRepartition,
  editions, Gauges,
  Deduction,
  Unit76, OleCtrls, SHDocVw, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, ZipMstr19 ;
  //, PdfLib_TLB;


  
type
TInfoDB=record
 TAbleName:PChar;
 DBName:PChar;
 AliasDB:PChar;
end;



//  TFormNotCloseQuery = set of (Main);
  TMain = class(TForm)
    MenuMain: TMainMenu;
    mnMethodes: TMenuItem;
    mnOuverture: TMenuItem;
    mnEcritures: TMenuItem;
    mnGestion: TMenuItem;
    mnCloture: TMenuItem;
    mnOutils: TMenuItem;
    mnEntreprise: TMenuItem;
    mnSaisiePiece: TMenuItem;
    mnReglementSurListe: TMenuItem;
    mnAide: TMenuItem;
    mnAffichage: TMenuItem;
    mnDossiers: TMenuItem;
    mnOuvrir: TMenuItem;
    mnFermer: TMenuItem;
    N1: TMenuItem;
    mnQuitter: TMenuItem;
    timHeure: TTimer;
    BasMain: THeaderControl;
    mnMessage: TMenuItem;
    mnAfficheEspion: TMenuItem;
    mnImmobilisations: TMenuItem;
    mnMouvements: TMenuItem;
    N3: TMenuItem;
    mnOuvertureImmo: TMenuItem;
    N4: TMenuItem;
    mnFinExerciceImmo: TMenuItem;
    mnPriodeAmortissement: TMenuItem;
    mnPlanComptes: TMenuItem;
    mnDescriptionOuverture: TMenuItem;
    mnDescriptionPassageReel: TMenuItem;
    mnChoixAmortis: TMenuItem;
    mnEditionsImmos: TMenuItem;
    mnChangeExercice: TMenuItem;
    ImageList1: TImageList;
    ImageList2: TImageList;
    mnLectureTable: TMenuItem;
    mnRequeteSql: TMenuItem;
    mnOptionsMenu: TMenuItem;
    mnApropos: TMenuItem;
    Panel1: TPanel;
    OpenDialog1: TOpenDialog;
    Transfertdefond1: TMenuItem;
    mnDemo: TMenuItem;
    Emprunts1: TMenuItem;
    PlanComptable1: TMenuItem;
    PlanAuxiliaire1: TMenuItem;
    CodeTVA1: TMenuItem;
    TramesdeSaisie1: TMenuItem;
    Stoks1: TMenuItem;
    DettetCreances: TMenuItem;
    RepriseStoks1: TMenuItem;
    StoksdeFin1: TMenuItem;
    Button3: TButton;
    SaisieAnneeAnterieur: TMenuItem;
    BalancedesTiers1: TMenuItem;
    Autressituationdedbut1: TMenuItem;
    Chargesrpartir1: TMenuItem;
    CEtPConstatsdavance1: TMenuItem;
    CEtPrecevoir1: TMenuItem;
    Provisions1: TMenuItem;
    Bilandouverture1: TMenuItem;
    ChargesetProduitsAnneAntrieure1: TMenuItem;
    Stocks1: TMenuItem;
    Chargesetproduitsconstatsdavances1: TMenuItem;
    Chargespayeretproduitsrecevoir2: TMenuItem;
    Button4: TButton;
    Visualisation1: TMenuItem;
    Pieces1: TMenuItem;
    OptionsLicence1: TMenuItem;
    Autrescritures1: TMenuItem;
    Chargesetproduitsconstatsdavance2: TMenuItem;
    Chargespayeretproduitsrecevoir3: TMenuItem;
    Chargesrpartir2: TMenuItem;
    Dpensedelentreprise1: TMenuItem;
    PopupMenu1: TPopupMenu;
    PlanComptabledebase1: TMenuItem;
    ValidationBalancedouverture1: TMenuItem;
    Provisions2: TMenuItem;
    Button2: TButton;
    Proprits1: TMenuItem;
    Shape2: TShape;
    Shape1: TShape;
    TransfertdeSolde1: TMenuItem;
    Changementdexercice1: TMenuItem;
    InfosVersion1: TMenuItem;
    Aide1: TMenuItem;
    Edition1: TMenuItem;
    Button5: TButton;
    Pointages1: TMenuItem;
    Immobilisations1: TMenuItem;
    EtatdeVersement1: TMenuItem;
    Etatdegestionanalytique1: TMenuItem;
    AssistantOuverture1: TMenuItem;
    ImageList3: TImageList;
    PaMenuGraph: TPanel;
    Panel3: TPanel;
    MenuPrincipal1: TMenuItem;
    Panel4: TPanel;
    ListMenu: TListView;
    ImExit: TImage;
    ImHelp: TImage;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    PaOutils: TPanel;
    ListeOutils: TListView;
    ImListOutils: TImageList;
    Bureau1: TMenuItem;
    InformationsParoisse1: TMenuItem;
    AffichInfoComposant1: TMenuItem;
    VideTAble1: TMenuItem;
    Recherche1: TMenuItem;
    Dotationamortissements1: TMenuItem;
    Genererlapiece1: TMenuItem;
    Supprimerlapiece1: TMenuItem;
    Visualiserlapiece1: TMenuItem;
    PaMessageSilencieux: TPanel;
    PaTitre: TPanel;
    PaMessage: TPanel;
    Edition2: TMenuItem;
    PaTitreMenu: TPanel;
    N030920021: TMenuItem;
    Analytique1: TMenuItem;
    EditionFin1: TMenuItem;
    Balance2: TMenuItem;
    BalanceTiers1: TMenuItem;
    Sauvegarde1: TMenuItem;
    PaBtn: TPanel;
    BtnPlanCpt: TRxSpeedButton;
    BtnPlanAux: TRxSpeedButton;
    BtnInserer: TRxSpeedButton;
    BtnPointages: TRxSpeedButton;
    BtnSaisiePiece: TRxSpeedButton;
    BtnFermer: TRxSpeedButton;
    BtnBalance: TRxSpeedButton;
    PaDate: TPanel;
    RxClock1: TRxClock;
    Rapprochementbancaire1: TMenuItem;
    TiAffichAide: TTimer;
    Journaux1: TMenuItem;
    ImportationOuverture1: TMenuItem;
    Epica2DOS1: TMenuItem;
    TVA1: TMenuItem;
    Nouvelledclaration1: TMenuItem;
    Anciennedclaration1: TMenuItem;
    Button7: TButton;
    Gestiondesemprunts1: TMenuItem;
    AffichInfoObjet1: TMenuItem;
    Supprimerderniredclaration1: TMenuItem;
    Rsultats1: TMenuItem;
    Panel2: TPanel;
    SpeedButton1: TRxSpeedButton;
    SimulationVrouillageFin1: TMenuItem;
    GrandLivre1: TMenuItem;
    GrandLivredesTiers1: TMenuItem;
    Journaux2: TMenuItem;
    Journaldespices1: TMenuItem;
    JournauxTVA1: TMenuItem;
    Restauration1: TMenuItem;
    MaintenanceSpciale1: TMenuItem;
    Priseenmainmaintenance1: TMenuItem;
    EditionBalance1: TMenuItem;
    EditionBalanceTiers2: TMenuItem;
    SIEADOS1: TMenuItem;
    VosSuggestionsEMail1: TMenuItem;
    Proprits2: TMenuItem;
    DettesetCrances1: TMenuItem;
    SlectionJournal1: TMenuItem;
    Analytique2: TMenuItem;
    VA1: TMenuItem;
    GrandlivredesAteliers1: TMenuItem;
    BalancedesAtelier1: TMenuItem;
    ImportTrame1: TMenuItem;
    ParamtresSystmes1: TMenuItem;
    Choisiruneimprimante1: TMenuItem;
    LecteursRseaux1: TMenuItem;
    Modem1: TMenuItem;
    ImportationE2FAC1: TMenuItem;
    Typeclient1: TMenuItem;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Corrections1: TMenuItem;
    Immobilisations6: TMenuItem;
    Cloture1: TMenuItem;
    Ouverture1: TMenuItem;
    TableauxdesAcquisitions: TMenuItem;
    TableauxdesAmortissements: TMenuItem;
    Synthesedutableauxdesamortissements1: TMenuItem;
    Synthesedeschoixdamortissements1: TMenuItem;
    PlusetMoinsvaluesfiscales1: TMenuItem;
    Plusetmoinsvaluescomptables2: TMenuItem;
    ableauxdesimmobillisations1: TMenuItem;
    Synthesedutableaudesimmobilisations1: TMenuItem;
    Immobilisations7: TMenuItem;
    Subventions5: TMenuItem;
    Immobilisations8: TMenuItem;
    Subventions6: TMenuItem;
    Immobilisations9: TMenuItem;
    Subventions7: TMenuItem;
    Immobilisations10: TMenuItem;
    Subventions8: TMenuItem;
    Immobilisations11: TMenuItem;
    Subventions9: TMenuItem;
    Immobilisations12: TMenuItem;
    Subventions10: TMenuItem;
    AvecDrogatoire1: TMenuItem;
    SansDrogatoire1: TMenuItem;
    AvecDrogatoire2: TMenuItem;
    SansDrogatoire2: TMenuItem;
    Avecdtaildudrogatoire1: TMenuItem;
    Sansdtaildudrogatoire1: TMenuItem;
    Avecdtaildudrogatoire2: TMenuItem;
    Sansdtaildudrogatoire2: TMenuItem;
    Emprunts2: TMenuItem;
    ableauMensueldeTresorerie1: TMenuItem;
    Mouvementdelexercice1: TMenuItem;
    Rpartitiondesannuits1: TMenuItem;
    ableauprvisionnel1: TMenuItem;
    CrationDuFichierAffichResult1: TMenuItem;
    Historique1: TMenuItem;
    Decimal1: TMenuItem;
    N2: TMenuItem;
    MultiDossier1: TMenuItem;
    Verifavantcloture1: TMenuItem;
    Historiquecorrection1: TMenuItem;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Gauge1: TGauge;
    EditionBilandouverture1: TMenuItem;
    AvecSoldebanque1: TMenuItem;
    avecquantits1: TMenuItem;
    Autresprogrammes1: TMenuItem;
    Internet2: TMenuItem;
    Rechercher2: TMenuItem;
    Explorateurwindows1: TMenuItem;
    InternetExplorer1: TMenuItem;
    RepertoireSauvegardes1: TMenuItem;
    LgrDoss2: TMenuItem;
    EMail2: TMenuItem;
    Web2: TMenuItem;
    News2: TMenuItem;
    AvecPrixUnitaire1: TMenuItem;
    ExportationDonnes1: TMenuItem;
    avecprcision1: TMenuItem;
    sansprcision1: TMenuItem;
    BalanceAnalytique1: TMenuItem;
    BalanceExport1: TMenuItem;
    Stocks2: TMenuItem;
    Annulerreprise1: TMenuItem;
    Plancomptable2: TMenuItem;
    PlanAuxiliaire2: TMenuItem;
    CompteFTP1: TMenuItem;
    GrandLivre2: TMenuItem;
    avecsoldeprogressif1: TMenuItem;
    avecquantit1: TMenuItem;
    normale1: TMenuItem;
    GrandlivredesTiers2: TMenuItem;
    Journaux3: TMenuItem;
    Journaldespices2: TMenuItem;
    BalancedesTiers2: TMenuItem;
    SurEcheance1: TMenuItem;
    Grandlivredesactivits1: TMenuItem;
    Balancedesactivits1: TMenuItem;
    Balancedouverture1: TMenuItem;
    ChargesetProduitsN11: TMenuItem;
    dtaills1: TMenuItem;
    Synthse1: TMenuItem;
    Liassefiscale2: TMenuItem;
    Dtaille1: TMenuItem;
    Synthse2: TMenuItem;
    Dtaille2: TMenuItem;
    Synthse3: TMenuItem;
    Amortissementsur5ans1: TMenuItem;
    BalanceCerfaLiasse1: TMenuItem;
    Grandlivreanalytique1: TMenuItem;
    Compte3chiffres1: TMenuItem;
    Synthsecompte3chiffres1: TMenuItem;
    rames1: TMenuItem;
    ImportationE2Fac2: TMenuItem;
    Dernierrapporterreur1: TMenuItem;
    ImportationSARA2: TMenuItem;
    N5: TMenuItem;
    EnvoierapportparEmail1: TMenuItem;
    EdDossierTransmis2: TEdit;
    Epuration1: TMenuItem;
    Rgnrationdestables1: TMenuItem;
    Requetesql1: TMenuItem;
    DPI: TMenuItem;
    DPIpratiques1: TMenuItem;
    UtilisationsdesDPI1: TMenuItem;
    RintgrationdesDPI1: TMenuItem;
    DductionDPI1: TMenuItem;
    SaisiedesDPIetleursutilisations1: TMenuItem;
    RintgrationdesDPI2: TMenuItem;
    Requeteisa1: TMenuItem;
    EdDossierTransmis1: TEdit;
    BalanceAvecSeparateur1: TMenuItem;
    Calcul1: TMenuItem;
    EdExerciceEpure: TEdit;
    GestionduBDE1: TMenuItem;
    Associationavecoutilrestauration1: TMenuItem;
    riparcodeemprunt1: TMenuItem;
    ripardatederalisation1: TMenuItem;
    Listedesateliers1: TMenuItem;
    Listedesactivits1: TMenuItem;
    Rapprochementrelev1: TMenuItem;
    Edit3: TEdit;
    EcrituresavecTVA1: TMenuItem;
    Button6: TButton;
    Button8: TButton;
    Balancecomparative1: TMenuItem;
    immosSur5Ans1: TMenuItem;
    subventionSur5ans1: TMenuItem;
    Envoiehistoriquedansdossier1: TMenuItem;
    EnvoiehistoriqueparEmail1: TMenuItem;
    Dernierrapporterreurpointages1: TMenuItem;
    ableaudesemprunstslongsterme1: TMenuItem;
    Importationcaisse1: TMenuItem;
    tableaudebord1: TMenuItem;
    Modificationplanettrame1: TMenuItem;
    Modificationcodetva1: TMenuItem;
    Modificationtauxtva1: TMenuItem;
    Misejourdestrames1: TMenuItem;
    Exportationdescritures1: TMenuItem;
    ZipMaster1: TZipMaster19;
    LabDossier: TLabel;
    BalanceCerfaLiasseAsc1: TMenuItem;
//    dbNameDossier: TDatabase;
    procedure mnSaisiePieceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure timHeureTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnMessageClick(Sender: TObject);
    procedure mnAfficheEspionClick(Sender: TObject);
    procedure mnAproposClick(Sender: TObject);
    procedure btPointageClick(Sender: TObject);
    procedure mnLectureTableClick(Sender: TObject);
    procedure mnRequeteSqlClick(Sender: TObject);
    procedure btVisuPieceClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Rglementsurliste1Click(Sender: TObject);
    procedure mnImmoToutesClick(Sender: TObject);
    procedure mnQuitterClick(Sender: TObject);
    procedure btQuitterClick(Sender: TObject);
    procedure mnImmoParCompteClick(Sender: TObject);
    procedure mnSyntheseImmoClick(Sender: TObject);
    procedure mnCrationFichesAcquisClick(Sender: TObject);
//    procedure mnAcquisExerciceClick(Sender: TObject);
    procedure mnPlusMoinsValuesClick(Sender: TObject);
    procedure mnAmortisImmo5ansClick(Sender: TObject);
    procedure mnCessionsSimplesClick(Sender: TObject);
    procedure mnCessionsGroupeesClick(Sender: TObject);
    procedure mnCessionsExerciceClick(Sender: TObject);
    procedure mnMiseAuRebutClick(Sender: TObject);
    procedure mnDivisionImmoClick(Sender: TObject);
    procedure mnOptionsMenuClick(Sender: TObject);
    procedure mnOuvrirClick(Sender: TObject);
    procedure mnOuvrirForceClick(Sender: TObject);
    Function DetruitTout:Boolean;
    procedure mnFermerClick(Sender: TObject);
    procedure mnEntrepriseClick(Sender: TObject);
    procedure mnFenetreClick(Sender: TObject);
    procedure mnDemoClick(Sender: TObject);
    procedure Balance1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Transfertdefond1Click(Sender: TObject);
    procedure Nouveau1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Emprunts1Click(Sender: TObject);
    procedure PlanComptable1Click(Sender: TObject);
    procedure PlanAuxiliaire1Click(Sender: TObject);
    procedure Stoks1Click(Sender: TObject);
    procedure Balance2Click(Sender: TObject);
    procedure DettetCreancesClick(Sender: TObject);
    procedure RepriseStoks1Click(Sender: TObject);
    procedure StoksdeFin1Click(Sender: TObject);
    procedure CreationNewDossierClick(Sender: TObject);
    procedure Chargesrpartir1Click(Sender: TObject);
    procedure CEtPConstatsdavance1Click(Sender: TObject);
    procedure CEtPrecevoir1Click(Sender: TObject);
    procedure Chargesetproduitsconstatsdavances1Click(Sender: TObject);
    procedure SaisieAnneeAnterieurClick(Sender: TObject);
    Function OuvreExo(NomDossier,NomExo : String;Reindexation:boolean=true):Boolean;
    procedure Button4Click(Sender: TObject);
    procedure Chargespayeretproduitsrecevoir2Click(Sender: TObject);
    procedure Pieces1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OptionsLicence1Click(Sender: TObject);
    procedure Chargesetproduitsconstatsdavance2Click(Sender: TObject);
    procedure Chargespayeretproduitsrecevoir3Click(Sender: TObject);
    procedure Chargesrpartir2Click(Sender: TObject);
    procedure Dpensedelentreprise1Click(Sender: TObject);
    procedure CodeTVA1Click(Sender: TObject);
    procedure PlanComptabledebase1Click(Sender: TObject);
    procedure ValidationBalancedouverture1Click(Sender: TObject);
    procedure Provisions1Click(Sender: TObject);
    procedure Provisions2Click(Sender: TObject);
    procedure TramesdeSaisie1Click(Sender: TObject);
    procedure BasMainSectionClick(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure RxClock1Alarm(Sender: TObject);
    procedure Panel2DblClick(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure ChargesetProduitsAnneAntrieure1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Proprits1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AppDeactivate(Sender: TObject);
    procedure AppActivate(Sender: TObject);
    procedure ChaqueClic(var Msg: TMsg; var Handled: Boolean);
    procedure ChangementForm(Sender: TObject);
    Procedure ChangementControle(Sender: TObject);
    procedure TransfertdeSolde1Click(Sender: TObject);
    procedure Changementdexercice1Click(Sender: TObject);
    procedure InfosVersion1Click(Sender: TObject);
    procedure BtnPlanCptClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure Agent1Click(Sender: TObject; const CharacterID: WideString;
      Button, Shift, x, y: Smallint);
{$IFDEF Diocese}
    procedure EtatdeVersement1Click(Sender: TObject);
    procedure Etatdegestionanalytique1Click(Sender: TObject);
{$ENDIF}
    procedure AssistantOuverture1Click(Sender: TObject);
    Procedure AffichageForm(MonoAffichage:boolean;Form:TForm);
    procedure ListMenuKeyPress(Sender: TObject; var Key: Char);
    procedure mnMethodesClick(Sender: TObject);
    Procedure GestListMenu(MenuItem:TMenuItem);
    procedure ListMenuDblClick(Sender: TObject);
    Procedure InitGestListMenu(MenuItem:TMenuItem);
    procedure MenuPrincipal1Click(Sender: TObject);
    procedure ListMenuMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel4Resize(Sender: TObject);
    procedure ListeOutilsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Immobilisations1Click(Sender: TObject);
    procedure Immos_OuvertureClick(Sender: TObject);
    procedure mnDescriptionOuvertureClick(Sender: TObject);
    procedure mnDescriptionPassageReelClick(Sender: TObject);
    procedure mnChoixAmortisClick(Sender: TObject);
    procedure mnMouvementsClick(Sender: TObject);
    procedure mnPlanComptesClick(Sender: TObject);
    procedure Bureau1Click(Sender: TObject);
    procedure InformationsParoisse1Click(Sender: TObject);
    procedure ListMenuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BalanceTiers1Click(Sender: TObject);
    procedure ImHelpClick(Sender: TObject);
    procedure AffichInfoComposant1Click(Sender: TObject);
    procedure VideTAble1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Recherche1Click(Sender: TObject);
    procedure Genererlapiece1Click(Sender: TObject);
    procedure Supprimerlapiece1Click(Sender: TObject);
    procedure Visualiserlapiece1Click(Sender: TObject);
    procedure PaTitreMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaMessageSilencieuxMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure PaTitreDblClick(Sender: TObject);
    procedure RxRichEdit1URLClick(Sender: TObject; const URLText: String;
      Button: TMouseButton);
    procedure ShockwaveFlash1FSCommand(Sender: TObject; const command,
      args: WideString);
    procedure Timer1Timer(Sender: TObject);
    procedure Analytique1Click(Sender: TObject);
    procedure EditionFin1Click(Sender: TObject);
    procedure BtnSaisiePieceClick(Sender: TObject);
    procedure BtnPointagesClick(Sender: TObject);
    procedure BtnPlanAuxClick(Sender: TObject);
    procedure BtnBalanceClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Rapprochementbancaire1Click(Sender: TObject);
    procedure TiAffichAideTimer(Sender: TObject);
    procedure Journaux1Click(Sender: TObject);
    procedure RxClock1Click(Sender: TObject);
    procedure Epica2DOS1Click(Sender: TObject);
    procedure Nouvelledclaration1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure RecalculerAmortissement1Click(Sender: TObject);
    procedure mnChangeExerciceClick(Sender: TObject);
    procedure Gestiondesemprunts1Click(Sender: TObject);
    procedure AffichInfoObjet1Click(Sender: TObject);
    procedure Supprimerderniredclaration1Click(Sender: TObject);
    procedure PaBtnClick(Sender: TObject);
    procedure Anciennedclaration1Click(Sender: TObject);
    procedure SimulationVrouillageFin1Click(Sender: TObject);
    procedure GrandLivredesTiers1Click(Sender: TObject);
    procedure Journaux2Click(Sender: TObject);
    procedure Journaldespices1Click(Sender: TObject);
//    procedure mnChoixAmortisClick(Sender: TObject);
    procedure PlanComptable1DrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
//    procedure Plusetmoinsvaluefiscales1Click(Sender: TObject);
    procedure Dductionpourinvestissements1Click(Sender: TObject);
//    procedure ImportationPice1Click(Sender: TObject);
    procedure MaintenanceSpciale1Click(Sender: TObject);
    procedure Priseenmainmaintenance1Click(Sender: TObject);
    procedure EditionBalance1Click(Sender: TObject);
    procedure EditionBalanceTiers2Click(Sender: TObject);
    procedure SIEADOS1Click(Sender: TObject);
    procedure VosSuggestionsEMail1Click(Sender: TObject);
    procedure Proprits2Click(Sender: TObject);
    procedure DettesetCrances1Click(Sender: TObject);
    procedure SlectionJournal1Click(Sender: TObject);
    procedure Sauvegarde1Click(Sender: TObject);
    procedure Restauration1Click(Sender: TObject);
    procedure GrandlivredesAteliers1Click(Sender: TObject);
    procedure BalancedesAtelier1Click(Sender: TObject);
    procedure ImportTrame1Click(Sender: TObject);
    procedure N030920021Click(Sender: TObject);
    procedure Choisiruneimprimante1Click(Sender: TObject);
    procedure ImportationE2FAC1Click(Sender: TObject);
    procedure Suppressiondesimmosincorrectes1Click(Sender: TObject);
    procedure Typeclient1Click(Sender: TObject);
//    procedure Immobilisations2Click(Sender: TObject);
//    procedure Subventions1Click(Sender: TObject);
//    procedure ableaudesacquisitions1Click(Sender: TObject);
//    procedure Immobilisations3Click(Sender: TObject);
//    procedure subventions2Click(Sender: TObject);
//    procedure ableaudesamortissements1Click(Sender: TObject);
//    procedure Immobilisations4Click(Sender: TObject);
//    procedure subventions3Click(Sender: TObject);
//    procedure Synthesedeschoixdamortissement1Click(Sender: TObject);
    procedure Corrections1Click(Sender: TObject);
//    procedure Immobilisations5Click(Sender: TObject);
    procedure Synthsedutableaudesamortissments1Click(Sender: TObject);
//    procedure Subventions4Click(Sender: TObject);
    procedure Ouverture1Click(Sender: TObject);
    procedure Cloture1Click(Sender: TObject);
    procedure ableauxdesimmobillisations1Click(Sender: TObject);
    procedure Synthesedutableaudesimmobilisations1Click(Sender: TObject);
    procedure TableauxdesAcquisitionsClick(Sender: TObject);
    procedure TableauxdesAmortissementsClick(Sender: TObject);
    procedure Synthesedutableauxdesamortissements1Click(Sender: TObject);
    procedure Synthesedeschoixdamortissements1Click(Sender: TObject);
    procedure Immobilisations9Click(Sender: TObject);
    procedure Subventions7Click(Sender: TObject);
    procedure Subventions8Click(Sender: TObject);
    procedure Immobilisations11Click(Sender: TObject);
    procedure Subventions9Click(Sender: TObject);
    procedure Immobilisations12Click(Sender: TObject);
    procedure Subventions10Click(Sender: TObject);
    procedure Plusetmoinsvaluescomptables2Click(Sender: TObject);
    procedure PlusetMoinsvaluesfiscales1Click(Sender: TObject);
    procedure Immobilisations6Click(Sender: TObject);
    procedure Immobilisations7Click(Sender: TObject);
    procedure Subventions5Click(Sender: TObject);
    procedure Immobilisations8Click(Sender: TObject);
    procedure Subventions6Click(Sender: TObject);
    procedure AvecDrogatoire1Click(Sender: TObject);
    procedure SansDrogatoire1Click(Sender: TObject);
    procedure AvecDrogatoire2Click(Sender: TObject);
    procedure SansDrogatoire2Click(Sender: TObject);
    procedure Immobilisations10Click(Sender: TObject);
    procedure Avecdtaildudrogatoire1Click(Sender: TObject);
    procedure Avecdtaildudrogatoire2Click(Sender: TObject);
    procedure Sansdtaildudrogatoire2Click(Sender: TObject);
    procedure Sansdtaildudrogatoire1Click(Sender: TObject);
    procedure ableauMensueldeTresorerie1Click(Sender: TObject);
    procedure Emprunts2Click(Sender: TObject);
    procedure Mouvementdelexercice1Click(Sender: TObject);
    procedure Rpartitiondesannuits1Click(Sender: TObject);
    procedure ableauprvisionnel1Click(Sender: TObject);
    procedure CrationDuFichierAffichResult1Click(Sender: TObject);
    procedure Historique1Click(Sender: TObject);
    procedure Decimal1Click(Sender: TObject);
    procedure MultiDossier1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure Verifavantcloture1Click(Sender: TObject);
    procedure Historiquecorrection1Click(Sender: TObject);
    procedure mnFinExerciceImmoClick(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure Panel7Click(Sender: TObject);
    procedure EditionBilandouverture1Click(Sender: TObject);
    procedure AvecSoldebanque1Click(Sender: TObject);
    procedure avecquantits1Click(Sender: TObject);
    procedure GrandLivre1Click(Sender: TObject);
    procedure Rechercher2Click(Sender: TObject);
    procedure Explorateurwindows1Click(Sender: TObject);
    procedure RepertoireSauvegardes1Click(Sender: TObject);
    procedure LgrDoss2Click(Sender: TObject);
    procedure InternetExplorer1Click(Sender: TObject);
    procedure Autresprogrammes1Click(Sender: TObject);
    procedure EMail2Click(Sender: TObject);
    procedure Web2Click(Sender: TObject);
    procedure News2Click(Sender: TObject);
    procedure Internet2Click(Sender: TObject);
    procedure AvecPrixUnitaire1Click(Sender: TObject);
    procedure ExportationDonnes1Click(Sender: TObject);
    procedure sansprcision1Click(Sender: TObject);
    procedure avecprcision1Click(Sender: TObject);
    procedure BalanceAnalytique1Click(Sender: TObject);
    procedure BalanceExport1Click(Sender: TObject);
    procedure Annulerreprise1Click(Sender: TObject);
    procedure Plancomptable2Click(Sender: TObject);
    procedure PlanAuxiliaire2Click(Sender: TObject);
    procedure CompteFTP1Click(Sender: TObject);
    procedure GrandLivre2Click(Sender: TObject);
    procedure normale1Click(Sender: TObject);
    procedure avecquantit1Click(Sender: TObject);
    procedure avecsoldeprogressif1Click(Sender: TObject);
    procedure GrandlivredesTiers2Click(Sender: TObject);
    procedure Avecsoldeprogressif2Click(Sender: TObject);
    procedure Avecquantit2Click(Sender: TObject);
    procedure Avecprixunitaire2Click(Sender: TObject);
    procedure Journaux3Click(Sender: TObject);
    procedure Journaldespices2Click(Sender: TObject);
    procedure BalancedesTiers2Click(Sender: TObject);
    procedure SurEcheance1Click(Sender: TObject);
    procedure Grandlivredesactivits1Click(Sender: TObject);
    procedure Balancedesactivits1Click(Sender: TObject);
    procedure Balancedouverture1Click(Sender: TObject);
    procedure ChargesetProduitsN11Click(Sender: TObject);
    procedure dtaills1Click(Sender: TObject);
    procedure Synthse1Click(Sender: TObject);
    procedure Liassefiscale2Click(Sender: TObject);
    procedure Dtaille1Click(Sender: TObject);
    procedure Synthse2Click(Sender: TObject);
    procedure Dtaille2Click(Sender: TObject);
    procedure Synthse3Click(Sender: TObject);
    procedure Amortissementsur5ans1Click(Sender: TObject);
    procedure BalanceCerfaLiasse1Click(Sender: TObject);
    procedure Grandlivreanalytique1Click(Sender: TObject);
    procedure Compte3chiffres1Click(Sender: TObject);
    procedure Synthsecompte3chiffres1Click(Sender: TObject);
    procedure rames1Click(Sender: TObject);
    procedure Dernierrapporterreur1Click(Sender: TObject);
    procedure ImportationE2Fac2Click(Sender: TObject);
    procedure ImportationSara2Click(Sender: TObject);
    procedure EnvoierapportparEmail1Click(Sender: TObject);
       Procedure InitMain(Type_Utilisation:Integer);
    procedure Epuration1Click(Sender: TObject);
    procedure Rgnrationdestables1Click(Sender: TObject);
    procedure Requetesql1Click(Sender: TObject);
    procedure DductionDPI1Click(Sender: TObject);
    procedure DPIClick(Sender: TObject);
    procedure SaisiedesDPIetleursutilisations1Click(Sender: TObject);
    procedure RintgrationdesDPI2Click(Sender: TObject);
    procedure DPIpratiques1Click(Sender: TObject);
    procedure UtilisationsdesDPI1Click(Sender: TObject);
    procedure RintgrationdesDPI1Click(Sender: TObject);
    procedure Requeteisa1Click(Sender: TObject);
    procedure BalanceAvecSeparateur1Click(Sender: TObject);
    procedure Calcul1Click(Sender: TObject);
    Procedure FormateCaptionMain(FinCaption:String = '');
    procedure GestionduBDE1Click(Sender: TObject);
    procedure Associationavecoutilrestauration1Click(Sender: TObject);
    procedure riparcodeemprunt1Click(Sender: TObject);
    procedure ripardatederalisation1Click(Sender: TObject);
    procedure Listedesateliers1Click(Sender: TObject);
    procedure Listedesactivits1Click(Sender: TObject);
    procedure Rapprochementrelev1Click(Sender: TObject);
    procedure EcrituresavecTVA1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Balancecomparative1Click(Sender: TObject);
    procedure immosSur5Ans1Click(Sender: TObject);
    procedure subventionSur5ans1Click(Sender: TObject);
    procedure Envoiehistoriquedansdossier1Click(Sender: TObject);
    procedure EnvoiehistoriqueparEmail1Click(Sender: TObject);
    procedure Dernierrapporterreurpointages1Click(Sender: TObject);
    procedure ableaudesemprunstslongsterme1Click(Sender: TObject);
    procedure Importationcaisse1Click(Sender: TObject);
    procedure tableaudebord1Click(Sender: TObject);


    function SelectionListeComptePourDettesEtCreances(var ParamAffichCompte:TParamAffichCompte):TResultStrList;
    procedure Modificationplanettrame1Click(Sender: TObject);
    procedure Modificationcodetva1Click(Sender: TObject);
    procedure RequeteCompteFilterRecord(DataSet: TDataSet;
    var Accept: Boolean);
    procedure RequeteCompteValideFilterRecord(DataSet: TDataSet;
    var Accept: Boolean);
    procedure Misejourdestrames1Click(Sender: TObject);
    procedure Modificationtauxtva1Click(Sender: TObject);
    procedure Exportationdescritures1Click(Sender: TObject);
    function initialisationBirt:boolean;
    function InstallationBirt:boolean;
    procedure InsallerAdobeReader1Click(Sender: TObject);
    procedure BalanceCerfaLiasseAsc1Click(Sender: TObject);
    procedure PaTitreMenuClick(Sender: TObject);
//    procedure mnChoixAmortisClick(Sender: TObject);
  private
    { Déclarations private }
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    Procedure GestListForm(CaptionForm:string;ProcClick:TObject);
    Procedure OnException(Sender : TObject; E:Exception);
    Procedure OnShortCut(var Msg:TWMKey;var Handled:Boolean);
    Procedure FormateMenuMain;
    Procedure FormateMenuMain_Revise;

  public
//   ContourCouleur,ShadowColorOn,ShadowColorOff,TextColorOn,TextColorOff:TColor;
//   DateDebutDeclarationTVA,DateFinDeclarationTVA,PremiereDateDeclaration:TdateTime;

// DBGrid
//   CouleurDBGrid:TVarColorGrid;
// Titre
   AfficheTitre:Boolean;
// Couleur Panel
//  PanelColor:TColor;
//  LastZoneEdit:TWincontrol;
  VersionBeta:Boolean;
  Monofenetrage:boolean;

  ListForm:TStringList;
//  Maintenance:boolean;
//  TypeMaintenance:string;
//   LigneContour,CelActiveContour,CelActiveColorFond,CelActiveColorFont,
//   CelActiveSAisieColorFont,CelActiveSAisieColorFond,
//   CelFixeColorFond,CelFixeColorFont,GrilleColorFond,GrilleColorFont:TColor;


//*************************** Gestion du debuggage*****************************/
  ListeClic:TStringList;
  DebutSession,DernierAcces,DeltaTime:TDateTime;
//  LastWinControl:TWinControl;
  Multidossier,DossierProt:boolean;
//  Claude:IAgentCtlCharacterEX;//

//  protected
//    procedure WMDROPFILES (var Msg: TMessage); message WM_DROPFILES;
  end;
//TCdClasse = (cdJour, cdMois, cdAnnee);

const
FormNotCloseQuery : array[0..4] of string = ('Main', 'Recherche','AutreDossier','DosProtect','ParamProg');
//FormNotForMenu : array[0..1] of string = ('Form1', 'Main','AutreDossier','DosProtect','ParamProg');
var
   Main: TMain;
   MenuRes :TMainMenu;
   MenuP:TMainMenu;
   iMain:integer;
   DebutSession:TDateTime;
   CtrlEnfonce:boolean;
       tvaTaux:real;
    OldtvaTaux:real;
    tvaCode:string;
    filtreTaux:boolean;
    listeCompteValide:Tstringlist;
//   procedure Creer_Form(InfoDB:TInfoDB);  external 'GenCode';
//   procedure Free_Form;  external 'GenCode';
         procedure Initialiser_ShortCut_Main(Init_A_Zero:boolean);

implementation
{uses Gr_SaisieMessage, E2_Librairie, E2_VisuApropos, E2_Pointage,
     E2_ListeImmos, E2_DetailImmo,
     E2_AideDevise,GestRes, E2_ChoixMenu, E2_RegmntListe2,
     E2_AideCompte, DMImmos, E2_CumulImmos, E2_ListeAcquis, E2_Amo3Ans,
     E2_PlusMoinsValues, E2_ParamEnt, E2_Balance, E2_TransFond, E2_Emprunts,
  E2_DescEmp, E2_GesPlanCpt, E2_Tiers, E2_Stoks, E2_BilanOuverture,
  E2_BalanceTiers, E2_RepriseStockDeb, E2_CreatDos, E2_TabVisuPiece2,GR_GestPlanCpt,
  E2_ChargeRepartir, E2_OuverturePCA, E2_ChargesAPayer, E2_RCCA,
  E2_ParamProg, E2_AutreDossier, E2_RepriseChargeAPayer_Isa, E2_VisuPieces,
  E2_DosProtect, E2_OKCreatExoDlg, E2_DepensesEntreprise, E2_GesPlanCpt_PM,
  E2_CreationCompte_PM, DMPlanCpt, E2_AideTva,E2_ChargeRepartir_Isa,
  E2_ChargesAPayer_Isa, E2_ChargesCA_Isa, E2_RepriseChargesCA, DMChargesCA;}

uses {Gr_SaisieMessage,} E2_Librairie_obj, E2_VisuApropos, //E2_Pointage,
     E2_ListeImmos, E2_DetailImmo,
     {E2_AideDevise,}GestRes, E2_ChoixMenu, {E2_RegmntListe2,}
     E2_AideCompte, DMImmos, E2_CumulImmos, E2_ListeAcquis, E2_Amo3Ans,

     E2_PlusMoinsValues, E2_ParamEnt, {E2_Balance, E2_TransFond,}
     //E2_Emprunts,
  {E2_DescEmp, E2_GesPlanCpt, }E2_Tiers,E2_BilanOuverture,
  E2_BalanceTiers,{ E2_RepriseStockDeb,} E2_CreatDos, E2_TabVisuPiece2,LibSQL,
  {E2_OuverturePCA, E2_ChargesAPayer,{ E2_RCCA,}
  E2_ParamProg, E2_AutreDossier,{ E2_RepriseChargeAPayer, E2_VisuPieces,}
  E2_DosProtect, E2_OKCreatExoDlg, E2_DepensesEntreprise, E2_GesPlanCpt_PM,
  //E2_CreationCompte_PM,
  DMPlanCpt, E2_AideTva, E2_PlanOrg, {E2_VBalOuv,}
  E2_ChargeRepartir_Isa,E2_ChargesAPayer_Isa, E2_ChargesCA_Isa, E2_RepriseChargesCA,
  DMChargesCA,E2_Stocks_Isa, E2_RepriseChargeAPayer_Isa, DMBaseDonnee,
  // E2_Trame,
  DMDepenses, DMStocks,E2_Emprunts_Isa2,
//  ProposeDate,
  E2_SaisieP_3,
  E2_BalanceNew, E2_Proprietes,
  // E2_GestVisu,
  // E2_TtmntTVA,
//  E2_Menu,
  E2_Pointages, E2_RepartitionResult,DMParamEnt,DMClotures,DMDevises,
  E2_VisuImmo, E2_SelectionLigne, DMImmo_Clot, E2_TranfertSolde, DMPiece,
  E2_SaisieReglement, E2_Immo_Ouverture,E2_CptImmos
  {$IFDEF Diocese}
  , DMDiocEtatVersements, E2_EtatVerse, DMDiocEtatGestionAnalytique,
  E2_EtatGestAnal,
  {$ENDIF}
  E2_AssistantOuverture, E2_Logo, E2_ChoixAmortissement,
  DMProgramme,LibClassObjetSenders, E2_ParamParoisse, E2_BalanceNewT,
  E2_Pointages2, DMInitTablesEpi, E2_ReglementSurListe, E2_RechercheBD,
  E2_Cloture_Def, E2_AffectReglement,
  //E2_TtmntTVA,
  DMRecherche, E2_ChoixReglementAuto, DMImportation, DMBalances,DMPointages2,
  E2_GestionAnalytique, E2_EditionFin,E2_EditionFin_Bic, DMTVA, AideMontant2,DMConstantes,
  E2_RapprochementBancaire, E2_AideAssist, E2_CreationJournal , E2_ConfirmImport
  ,E2_SyntheseTVA, E2_DescEmp, DMTTVA, DMAide, DMJournaux, DMEcriture,
  DMDiocEtatBalance, DMDiocEtatBalanceT, DMTier, ModuleTrame
//  , Unit1
//, E2_RelanceTiers
  , E2_Test1,
  DMImmosOuverture,
  E2_GestionSauvegarde,
  E2_GestSauvegarde,
  DMEmprunt,
  DMXMLs, E2_InfosProtect, E2_EditionBilanOuverture,
  E2_EditionOuverture_Bic,
  DMExports,LibChoixCompte, DMDeductions, RequeteSql , ShellCtrls,
  WinShellFolder, BdeInit, RapprochementReleve, DiversProjets,
  DmGestionVersions, BalancesComparatives, ImportReleve, TableauDeBord,
   LibChoixCompteCoche, ListeEditions, E2_ChangementTva,
  E2_ChangementTauxTva;

{$R *.DFM}




//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//********************* Fonctions et procedures ********************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
Procedure TMain.InitMain(Type_Utilisation:Integer);
//var
//Ecran_A_Verrouille_Toujours,
//Ecran_A_Verrouille_TypeClient:TStringList;
Begin
try//finally
  case Type_Utilisation of

    CT_DEVELOPPEMENT:Begin
    FormateCaptionMain(' - Vous êtes en version Developpement ! -');
//  05/03/2009           Application.MainForm.caption:='Dossier : '+E.NomDossier+ ' - '+ 'Exercice : ' + E.NomExo;
             //Application.MainForm.caption:=Application.MainForm.caption + ' - Vous êtes en version Developpement ! -';

                      N030920021.Caption := 'VERSION MODE DEVELOPPEMENT';
                      case E.TypeClient of
                        CL_Cogere:N030920021.Caption := N030920021.Caption + ' '+'Client : COGERE' ;
                        CL_Normal:N030920021.Caption := N030920021.Caption + ' '+'Client : Normal' ;
                        CL_Inconnu:N030920021.Caption := N030920021.Caption + ' '+'Client : Inconnu' ;
                        CL_Isa:N030920021.Caption := N030920021.Caption + ' '+'Client : Isa' ;           //23/09/2010
//                        CL_Demo:N030920021.Caption := N030920021.Caption + ' '+'Client : Demo' ;
//                        CL_Saisie_Normal:N030920021.Caption := N030920021.Caption + ' '+'Client : Saisie_Normal' ;
//                        CL_Saisie_Demo:N030920021.Caption := N030920021.Caption + ' '+'Client : Saisie_Demo' ;
//                        CL_Saisie_Cogere:N030920021.Caption := N030920021.Caption + ' '+'Client : Saisie_Cogere' ;
//                        CL_Normal_2:N030920021.Caption := N030920021.Caption + ' '+'Client : Normal 2' ;
//                        CL_Normal_3:N030920021.Caption := N030920021.Caption + ' '+'Client : Normal 3' ;
                      else ;
                      end;

                     End;

    CT_DISTRIBUTION:Begin
                      //N030920021.Caption :=numVersion.DAteVersion+' '+RetourChariotSimple+TypeClientToStrLibelle(E.TypeClient);
                      N030920021.Caption :=numVersion.DAteVersion;
                      FormateCaptionMain;
                      //Application.MainForm.caption:='Dossier : '+E.NomDossier+ ' - '+ 'Exercice : ' + E.NomExo;
                      if ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')) then
                       begin
                       FormateCaptionMain(' - Vous êtes en version Maintenance ! - Spéciale -');
                         //Application.MainForm.caption:='Dossier : '+E.NomDossier+ ' - '+ 'Exercice : ' + E.NomExo + ' - Vous êtes en version Maintenance ! - Spéciale -';
                       end;

//                      VisibleItemMenu([ImportationOuverture1],e.AccesOuverture);

//                      Ecran_A_Verrouille_Toujours:= RecupListeMenu_Exclusion('toujours');
//                        for iMain:=0 to Ecran_A_Verrouille_Toujours.count-1 do
//                         VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouille_Toujours.Strings[iMain]))],false);
//
//                      //on traite typeClient menu à verrouiller
//                      Ecran_A_Verrouille_TypeClient:=RecupListeExclusionMenu_Type(e.TypeClientToStr(e.TypeClient));
//                      for iMain:=0 to Ecran_A_Verrouille_TypeClient.count-1 do
//                          EnableItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouille_TypeClient.Strings[iMain]))],false);

//                    if (e.TypeClient=cl_Demo)or(e.TypeClient=CL_Saisie_Demo) then
//                      EnableItemMenu([GrandLivre1,GrandLivredesTiers1,Journaux2,SlectionJournal1,
//                      Journaldespices1,Immobilisations6,JournauxTVA1,EditionBalance1,EditionBalanceTiers2,
//                      DettesetCrances1,Analytique2,VA1,Emprunts2,Sauvegarde1,Restauration1],false);

//case E.TypeClient of
//  CL_COGERE:begin
//Rsultats1,
//              end;
//  VerDiocese:begin
//
//              end;
//end;                                        ,Button6
                      VisibleControl([Button1,Button7,Edit1,Edit2],false);

                      // Traitement du menu spécifique pour COGERE
                     // VisibleItemMenu([SIEADOS1],((E.TypeClient = CL_Cogere)and(not e.ExerciceCloture)));
                    End;

  else showmessage('Le type de l''exécutable n''est pas défini !');
  end;
finally
  FormateMenuMain;
  EdDossierTransmis1.Visible:=FileExists(IncludeTrailingPathDelimiter(E.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable);
  EdDossierTransmis2.Visible:=FileExists(IncludeTrailingPathDelimiter(E.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable);
  Main.EdExerciceEpure.Visible:=(ExerciceEpure(E.RepertoireExercice));
end
End;

Procedure TMain.InitGestListMenu(MenuItem:TMenuItem);
var
i,j:integer;
Begin
ListMenu.Items.Clear;
j:=0;
for i:=0 to self.Menu.Items.Count-1 do
   Begin
    if self.Menu.Items[i].Visible then
     begin
      ListMenu.Items.Add.Caption:=str_remplacesouschaine(self.Menu.Items[i].Caption,'&','');
      ListMenu.Items.Item[j].ImageIndex:=i+4;
//         (sender as TDataModule)

//      ListMenu.Items.Item[i].SubItems.AddObject(self.Menu.Items[i].Caption,self.MethodAddress('AssistantOuverture1Click'));
      ListMenu.Items.Item[j].SubItems.AddObject(self.Menu.Items[i].Caption,self.Menu.Items[i]);
      inc(j);
     end;
   End;

PaTitreMenu.Caption:='Menu Principal';
ListMenu.Tag:=0;
ListMenu.Items[0].Selected:=true;
ListMenu.Items[0].Focused:=true;
End;



Procedure TMain.GestListMenu(MenuItem:TMenuItem);
var
i,j:integer;
//ListItem:TListItem;
Begin
  ListMenu.Items.Clear;
  j:=0;
  if (menuItem.Parent is TMenuItem) then
   begin
     ListMenu.Items.Add.Caption:='Précédent';
     ListMenu.Items.Item[0].ImageIndex:=0;

     if not empty(menuItem.Parent.Name) then
      begin
        ListMenu.Items.Item[j].SubItems.AddObject('Précédent',menuItem.Parent);
//        PaTitreMenu.Caption:=str_remplacesouschaine((menuItem.Parent as TmenuItem).Caption,'&','');
        PaTitreMenu.Caption:='Menu Principal >> '+str_remplacesouschaine((menuItem.Parent as TmenuItem).Caption,'&','')+' >> '+str_remplacesouschaine(menuItem.Caption,'&','');
      end
     else
      begin
        ListMenu.Items.Item[j].SubItems.AddObject('Précédent',MenuPrincipal1);
        PaTitreMenu.Caption:='Menu Principal >> '+str_remplacesouschaine(menuItem.Caption,'&','');
      end;

     j:=1;
   end;

  for i:=0 to MenuItem.Count-1 do
   Begin
   if ((MenuItem.Items[i].Caption <> '-') and (MenuItem.Items[i].Visible = true)) then
      begin
       ListMenu.Items.Add.Caption:=str_remplacesouschaine(MenuItem.Items[i].Caption,'&','');
       if MenuItem.Items[i].Count > 0 then
           ListMenu.Items.Item[j].ImageIndex:=2
        else
           ListMenu.Items.Item[j].ImageIndex:=1;
       ListMenu.Items.Item[j].SubItems.AddObject(MenuItem.Items[i].Caption,MenuItem.Items[i]);
       inc(j);
     end;
   End;

  ListMenu.Tag:=1;

  if ListMenu.Items.Count > 1
    then
      begin
        ListMenu.Items[0].Focused:=true;
        ListMenu.Items[0].Selected:=true;
      end
    else
       begin
         ListMenu.Items[0].Focused:=true;
         ListMenu.Items[0].Selected:=true;
       end;
End;


Procedure TMain.GestListForm(CaptionForm:string;ProcClick:TObject);
var
IndexProc,i:integer;
Begin
IndexProc:=ListForm.IndexOf(CaptionForm);
if IndexProc =-1 then
 Begin
  ListForm.InsertObject(0,CaptionForm,ProcClick);
 End
 else
 Begin
  ListForm.Delete(IndexProc);
  ListForm.InsertObject(0,CaptionForm,ProcClick);
 End;

while mnAffichage.Count > 0 do
 begin
   mnAffichage.Items[0].Free;
 end;

for i:=0 to ListForm.count-1 do
 begin
 if i < 10 then
 ConstruitPopMenu(i,'&'+inttostr(i)+' - '+ListForm.strings[i],mnAffichage,self,TMenuItem(ListForm.Objects[i]).OnClick)
 else
 if i < 37 then
 ConstruitPopMenu(i,'&'+chr(i+55)+' - '+ListForm.strings[i],mnAffichage,self,TMenuItem(ListForm.Objects[i]).OnClick)
 end;
//
////if AppliOne <> nil
////then if AppliOne.Visible then
//// begin
//// AppliOne.Hide;
//// i:=AppliOne.Tag;
//// if i = 2 then AppliOne.tag:=1;
//// AppliOne.FormShow(AppliOne);
//// AppliOne.Show;
//// end
//// else
//// begin
////   if i = 1 then AppliOne.tag:=2;
////   AppliOne.FormShow(AppliOne);
//// end;
////
//
End;

Procedure TMain.AffichageForm(MonoAffichage:boolean;Form:TForm);
Begin
self.PopupMenu:=nil;
if MonoAffichage then
 begin
  Form.BorderIcons:=Form.BorderIcons-[biMinimize];
  if Form.WindowState = wsMinimized then
      Form.WindowState:=wsMaximized;
  if Form.FindComponent('PaTitre') <> nil then
   TPanel(Form.FindComponent('PaTitre')).Visible:=paramutil.AfficheTitre;
  if Form.FindComponent('RxSpeedButton1') <> nil then
   TRxSpeedButton(Form.FindComponent('RxSpeedButton1')).Visible:=not MonoAffichage;
  if Form.FindComponent('RxSpeedButton2') <> nil then
   TRxSpeedButton(Form.FindComponent('RxSpeedButton2')).Visible:=not MonoAffichage;

  Form.ShowModal;
  Initialiser_ShortCut_Main(false);
 end
 else
 Begin
  Form.BorderIcons:=Form.BorderIcons+[biMinimize];
  if Form.WindowState = wsMinimized then
      Form.WindowState:=wsMaximized;
  if Form.FindComponent('PaTitre') <> nil then
   TPanel(Form.FindComponent('PaTitre')).Visible:=paramutil.AfficheTitre;
  if Form.FindComponent('RxSpeedButton1') <> nil then
   TRxSpeedButton(Form.FindComponent('RxSpeedButton1')).Visible:=MonoAffichage;
  if Form.FindComponent('RxSpeedButton2') <> nil then
   TRxSpeedButton(Form.FindComponent('RxSpeedButton2')).Visible:=MonoAffichage;
  Form.Show;
 End;

End;


procedure TMain.ChaqueClic(var Msg: TMsg; var Handled: Boolean);
var
//Texte:string;
  NombreDeFichiers,size,i:integer;
  NomDuFichierStr:string;
  NomDuFichier:array[0..255] of char;
  PointDuLache:TPoint; // point du laché
  H:Integer;
  fichier :  array[0..255] of char;
  Icone:TIcon;
//  Texte2:PChar;
begin

if Msg.message = WM_PROTECTMESSAGE then
 begin
  showmessage('WM_PROTECTMESSAGE');
 end;

//if Msg.message = WM_MOUSEMOVE then
// begin
////   GetWindowText(GetTopWindow(Msg.hwnd),PChar(Texte),255);
////   PaTitreMenu.Caption:=Texte;
//   PaTitreMenu.Caption:=GetCaptionSousSouris(Msg.pt);
// end;

  if Msg.message=WM_DROPFILES then
  begin
    NombreDeFichiers:= DragQueryFile( Msg.wParam, $FFFFFFFF, NomDuFichier, sizeof(NomDuFichier));// récupération du nombre de fichiers
    for i:=0 to NombreDeFichiers-1 do
    begin
      size:= DragQueryFile( Msg.wParam, i, NomDuFichier, sizeof(NomDuFichier) );// récupération du nom du fichier
      NomDuFichierStr:=NomDuFichier; // tansformation du tableau de char en STRING
      DragQueryPoint(Msg.wParam,PointDuLache); // récupération du point de laché
    strpcopy(fichier,NomDuFichier);
    if ExtractIcon(handle,fichier,UINT(-1))=0 then showMessage('ne peut afficher l''icône car ce n''est pas un .ico ou un .exe ou un .dll'+
                                                 #13+' ou il n''y a pas d''icône')
    else
    begin
      ListeOutils.Items.Add.Caption:=extractFilename(NomDuFichierStr);
      H:=ExtractIcon(handle,fichier,0);
      Icone:=TIcon.Create;
      Icone.Handle:=H;
      ImListOutils.AddIcon(Icone);
      ListeOutils.Items[ListeOutils.Items.Count-1].ImageIndex:=ImListOutils.Count-1;
      ListeOutils.Items[ListeOutils.Items.Count-1].SubItems.Text:=extractFilename(NomDuFichierStr);
      Icone.Free;
    end;
//      Memo1.Lines.add(NomDuFichierStr+' X='+IntToStr(PointDuLache.x)+' Y='+ IntToStr(PointDuLache.y));
//      DessineIcone(NomDuFichier,PointDuLache);
    end;
  end;

if Msg.message=WM_LBUTTONUP then
   begin
   if GetCaptureControl <> nil then
     begin
     DeltaTime:=Now-DernierAcces;
     if  not (GetCaptureControl is TWincontrol) then
     begin
//      if GetCaptureControl.ClassNameIs('TRxSpeedButton') then
//         Accueil2.ListeClic.Add((GetCaptureControl.Name)+';'+timeToStr(Accueil2.DeltaTime)+';'+DateTimeToStr(now)+';'+(GetCaptureControl as TRxSpeedButton).Caption)
//         else
         ListeClic.Add((GetCaptureControl.Name)+';'+timeToStr(DeltaTime)+';'+DateTimeToStr(now));
     end;
     DernierAcces:=now;
     end;
   end;

//if Msg.message=WM_SETFOCUS then
//   begin
//   if GetCaptureControl <> nil then
//     begin
//     DeltaTime:=Now-DernierAcces;
////     if  not (GetCaptureControl is TWincontrol) then
//     begin
////      if GetCaptureControl.ClassNameIs('TRxSpeedButton') then
////         Accueil2.ListeClic.Add((GetCaptureControl.Name)+';'+timeToStr(Accueil2.DeltaTime)+';'+DateTimeToStr(now)+';'+(GetCaptureControl as TRxSpeedButton).Caption)
////         else
//         ListeClic.Add((GetCaptureControl.Name)+';'+timeToStr(DeltaTime)+';'+DateTimeToStr(now));
//     end;
//     DernierAcces:=now;
//     end;
//   end;

End;

procedure TMain.ChangementForm(Sender: TObject);
//var
//NomFic:string;
Begin
 if screen.ActiveForm <> nil then
  begin
//   ListeTmp:=ListeClic;
   if not (DirectoryExists(E.RepertoireProgram+'0000000000')) then ForceDirectories(E.RepertoireProgram+'0000000000');
//      ListeClic.SaveToFile(E.RepertoireProgram+'0000000000\'+quedeschiffres(DateTimeToStr(now))+'.fic');
//   ListeClic.Clear;
   ListeClic.Add((screen.ActiveForm.Name)+';'+timeToStr(DeltaTime)+';'+DateTimeToStr(now)+';'+screen.ActiveForm.Caption);

   // si ParamUtil.ConstPosition = true alors affichage automatique du menu de modification des constantes d'affichage (type2)
   if ParamUtil.ConstPosition then
     DMConst.AfficheMenuConstPos(Screen.ActiveForm);

  end;
//if (Screen.ActiveForm.Name <> 'Main') and
//   (Screen.ActiveForm.Name <> 'AutreDossier') and
//   (Screen.ActiveForm.Name <> 'Recherche') and
//   (Screen.ActiveForm.Name <> 'DosProtect') and
//   (Screen.ActiveForm.Name <> 'Form1') and
//   (Screen.ActiveForm.Name <> 'ParamProg') then
//   begin
//     NomFic:=screen.ActiveForm.caption;


//     Form1.ListeProg.add(NomFic);
//     //Form1.ListeIcon.AddObject(E.RepertoireProgram+RepLogo+'Icone'+inttostr(ListeProg.count-1)+'.Ico',Icone);
//     //Form1.ListeChe.Append(aux);
//     Form1.ConstruitPopMenu(Form1.ListeProg.count-1,NomFic,Form1.RxPopMain.items);
//     //Form1.ImIcone.AddIcon(icone);
//     //    GetIcon((ListeProg.count-1),);
//     Form1.AjouteItem(Form1.ListeProg.count-1,NomFic);
//     Form1.Image3DblClick(Form1.Image5);
//   end;

End;

procedure TMain.AppDeactivate(Sender: TObject);
Begin
//   if form1.visible then
//    form1.Hide;
End;

procedure TMain.AppActivate(Sender: TObject);
Begin
//   if not form1.visible then
//    form1.show;
End;

procedure TMain.AppMessage(var Msg: TMsg; var Handled: Boolean);
//var
//Point:TPoint;
begin
//self.caption:=IntToStr(Msg.message);
//if Msg.message = WM_MOUSEMOVE then
// begin
//   PaTitreMenu.Caption:=GetCaptionSousSouris(Msg.pt);
// end;

//////   Form4.Memo1.Lines.Add(inttostr(Msg.message));
//  if Msg.message = WM_KEYDOWN then
//  begin
////    Memo1.Lines.add('DOWN '+inttostr(Msg.lParam)+' ' + inttostr(Msg.wParam)+' ' +booltostr(CtrlEnfonce));
//  if CtrlEnfonce then
//  if Msg.wParam=16 then
//   begin
//   if form1.visible then
//    form1.Hide else form1.Show;
//   end;
//   if not CtrlEnfonce then
//     CtrlEnfonce:=(Msg.wParam=17);
//
//  end;
//  if Msg.message = WM_KEYUP then
//  begin
//   if CtrlEnfonce then
//     CtrlEnfonce:=not(Msg.wParam=17);
////    Memo1.Lines.add('UP '+inttostr(Msg.lParam)+' ' + inttostr(Msg.wParam)+' ' +booltostr(CtrlEnfonce));
//  end;
////  { Pour tous les autres messages, cette gestion est inactive}
////  { les gestionnaires des autres messages peuvent répondre }
end;

Function TMain.DetruitTout:Boolean;
begin
result:=false;
  try
    // Avant de tout détruire, on récupère les Shapes qui servent à dessiner
    // les contours des TWinControl actif
    if Shape1 <> nil then
    Shape1.Parent:=Panel4;
    if Shape2 <> nil then
    Shape2.Parent:=Panel4;
    Result:=false;
    while mnAffichage.Count > 0 do
     begin
       mnAffichage.Delete(0);
     end;

    ListForm.Clear;
    ExecuteProcInit('InitialiseTable_A_Nil');   //,Convertisseur
    result:=DetruitTouteForm([main,E2_AutreDossier.AutreDossier,Logo,AideMontantTTC2]);
  except
    Showmessage('Erreur 10001 lors de la réinitialisation du dossier');
    abort;
  end;
end;

Function TMain.OuvreExo(NomDossier,NomExo : String;Reindexation:boolean):Boolean;
begin
 try
    try
    result:=false;
      if FermerDossier(E) then
//      if DetruitTout then
      begin
        if (DMPlan = nil) then
           DMPlan:=TDMPlan.Create(Application.MainForm);
        OuvreExercice(NomDossier,NomExo,gauge1,Reindexation);
        FormateCaptionMain;

        if ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')) then
         begin
         FormateCaptionMain(' - Vous êtes en version Maintenance ! - Spéciale -');
           //Application.MainForm.caption:=Application.MainForm.caption + ' - Vous êtes en version Maintenance ! - Spéciale -';
         end;
        Main.Menu.Items[0].delete(0);
        Main.Menu.Items[0].Insert(0,NewItem('Nouveau Dossier ...',0,false,true,CreationNewDossierClick,0,'DosCourant'));
    //    GEstDossierMaJDateUtilDossier(E.NomExo);
      //  Main.Menu.Items[0].Delete(Main.Menu.Items[0].Count-1);
      //  Main.Menu.Items[0].Delete(Main.Menu.Items[0].Count-1);
        AjoutMenu(Multidossier);
        FormateMenuMain;
        result:=true;
      end
      else
      begin
       showmessage('Le changement de dossier à été abandonné !'+#10#13+'Le dossier :'+#10#13+E.NomDossier+#10#13#10#13+'Exercice :'+#10#13+E.NomExo+' est toujours actif !');
       FormateMenuMain;
      end;
    except
       Application.MessageBox(PChar('Une erreur de type : Ouverture de dossier est survenue !'+#10#13+'Le dossier Demo va être activé.'),'Attention',0);
       //FormateMenuMain;
       abort;
    end;
 Finally
  FormateCaptionMain;
  FormateMenuMain;
  InitGestListMenu(self.menu.Items);
 end;
end;

procedure TMain.btPointageClick(Sender: TObject);
begin
 if (Tiers = nil) then Tiers:=TTiers.Create(self);
 if Tiers.Visible then Tiers.Close;
 Tiers.Tag:=2;
 Tiers.BorderStyle:=bsSizeable;
 if (sender as TMenuItem).Parent <> mnAffichage then
   Tiers.TitreForm:=(Sender as TMenuItem).Caption
     else
     GestListMenu(mnAffichage);
 Tiers.SousTitreForm:=CMouvement;
 GestListForm(Tiers.TitreForm+' - '+Tiers.SousTitreForm,Pointages1);
 AffichageForm(Monofenetrage,Tiers);
end;

//******************************************************************************
procedure TMain.btVisuPieceClick(Sender: TObject);
begin
//   if (FVisuPiece = nil) Then FVisuPiece:= TVisuPiece.Create(Application.MainForm);
//   FVisuPiece.Show;
end;

procedure TMain.mnOuvrirForceClick(Sender: TObject);
begin
e.ControleDuDossier:=false;
mnOuvrirClick(sender);
//E.DateVersion:=C_Date+'-'+C_Version;
E.DateVersion:=numVersion.DateVersion+'-'+numVersion.Version;
DMXml.ModifieVarDos(E.NomDossier,CXML_DateVersion,E.DateVersion);
end;


//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Dossiers **********************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
procedure TMain.mnOuvrirClick(Sender: TObject);
var
NomDossier,NomExo:String;
ParamAfficheAutreDossier:TParamAfficheAutreDossier;
begin
try
try
   // Avant d'ouvrir un nouveau dossier, on sauve les paramètres du dossier en cours
   DMProg.SauveGestDossierFichier(E.NomDossier);
   ////////////////////////////////////////////
   NomDossier:=((Sender as TMenuItem).Parent).Caption;
   NomExo:=(Sender as TMenuItem).Caption;
   if (((sender as TMenuItem).Name='Exo0') or ((sender as TMenuItem).Name='Exo1')) then
    begin
     if OuvreExo(NomDossier,NomExo) then
       ShowMessage('Vous venez d''activer le dossier :'+RetourChariotDouble+E.NomDossier+RetourChariotDouble+'Exercice : '+RetourChariotDouble+E.NomExo);
    end;

   if ((sender as TMenuItem).Name='Exo0Desc') then
     begin
      NomExo:=Str_Avant(NomExo,':');
      NomExo:=str_supprespaces(NomExo);
      if OuvreExo(NomDossier,NomExo,false) then
       begin
         mnEntrepriseClick(mnEntreprise);
         Main.Menu.Items[0].delete(0);
         Main.Menu.Items[0].Insert(0,NewItem('Nouveau Dossier ...',0,false,true,CreationNewDossierClick,0,'DosCourant'));
         AjoutMenu(Multidossier);
         ShowMessage('Vous venez d''activer le dossier :'+RetourChariotDouble+E.NomDossier+RetourChariotDouble+'Exercice : '+RetourChariotDouble+E.NomExo);
         mnMethodesClick(mnDossiers);
       end;
     end;

   if (sender as TMenuItem).Name='Exo2' then
     begin
       ParamAfficheAutreDossier.Tag:=1;
       AutreDossierAffiche(ParamAfficheAutreDossier);
//      if (AutreDossier = nil) then AutreDossier:=TAutreDossier.Create(self);
//      AutreDossier.tag:=1;
////      E.NomDossier:= NomDossier;
//      AutreDossier.showModal;
     end;

   if (sender as TMenuItem).Name='Dos' then
     begin
       ParamAfficheAutreDossier.Tag:=0;
       AutreDossierAffiche(ParamAfficheAutreDossier);
//      if (AutreDossier = nil) then AutreDossier:=TAutreDossier.Create(self);
//      AutreDossier.tag:=0;
//      AutreDossier.showModal;
     end;
//   FormateMenuMain;
except
  //
end;
finally
  FormateMenuMain;
end;
end;

//******************************************************************************
procedure TMain.mnFermerClick(Sender: TObject);
begin
//
end;

procedure TMain.mnQuitterClick(Sender: TObject);
begin                                               //,Convertisseur
if DetruitTouteForm([main,E2_AutreDossier.AutreDossier,Logo,AideMontantTTC2]) then
 begin
   if Logo = nil then Logo:=TLogo.create(Application.MainForm);
   Logo.tag:=1;
   Logo.RxLabel1.Left:=85;
   Logo.RxLabel1.Caption:='Fermeture en cours ...';
   Logo.TimFermeture.Enabled:=true;
   Logo.BtnAnnuler.Visible:=true;
   Logo.BtnSortir.Visible:=true;
   //Logo.BtnSortir.SetFocus;
   Logo.Tag:=1;
   Logo.Showmodal;
end
else
begin
  if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
end;
//Messagedlg(PChar('Epicéa va se fermer dans 3 secondes ....'),mtWarning,[mbCancel],0);
// if Messagedlg(PChar('Êtes-vous sûr de vouloir quitter Epicéa ?'),mtconfirmation, [mbno,mbyes],0) = mryes then
//self.close;
//	Application.Terminate;
end;

//******************************************************************************
procedure TMain.btQuitterClick(Sender: TObject);
begin
	mnQuitterClick(Sender);
end;

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Methode ***********************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
procedure TMain.CodeTVA1Click(Sender: TObject);
begin
 If (AideTva = nil) then AideTva:=TAideTva.Create(self);
 AideTva.Tag:=1;
   DeFiltrageDataSet(DMTVACode.TaTvaCode);
 if (sender as TMenuItem).Parent <> mnAffichage then
   AideTva.TitreForm:=(Sender as TMenuItem).Caption
     else
     GestListMenu(mnAffichage);
   AideTva.SousTitreForm:=CMethode;
   GestListForm(AideTva.Caption,CodeTVA1);
   AffichageForm(Monofenetrage,AideTva);
end;

//******************************************************************************

procedure TMain.PlanComptabledebase1Click(Sender: TObject);
begin
 if (PlanCptbase = nil) then PlanCptbase:=TPlanCptbase.Create(self);
// Application.MainForm.SendToBack;
   GestListForm(PlanCptbase.Caption,PlanComptabledebase1);
 PlanCptbase.AffichePlanDefaut:=false;
 PlanCptbase.showModal;
Initialiser_ShortCut_Main(false);
end;

//******************************************************************************

procedure TMain.TramesdeSaisie1Click(Sender: TObject);
begin
// If (Trame = nil) then Trame:=TTrame.Create(self);
// Trame.show;
Showmessage(TrameRxSBInfoVersionWarning+numVersion.messageVersion);
end;
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Ouverture *********************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

//******************************************************************************

procedure TMain.Chargesrpartir1Click(Sender: TObject);
var
ParamAfficheChargeARepartir:TParamAfficheChargeARepartir;
begin
ParamAfficheChargeARepartir.AffichageModal := Monofenetrage;
ParamAfficheChargeARepartir.Affiche := true;
ParamAfficheChargeARepartir.Quand := C_Ouverture;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAfficheChargeARepartir.TitreForm :=(Sender as TMenuItem).Caption;
ParamAfficheChargeARepartir.SousTitreForm := COuverture;

ChargeARepartirAffiche(ParamAfficheChargeARepartir);
// if (ChargeARepartir_Isa = nil) then ChargeARepartir_Isa:=TChargeARepartir_Isa.Create(self);
// if ChargeARepartir_Isa.tag=C_Cloture then ChargeARepartir_Isa.close;
// ChargeARepartir_Isa.tag:=C_Ouverture;
//   GestListForm(ChargeARepartir_Isa.Caption,Chargesrpartir1);
//   ChargeARepartir_Isa.TitreForm:=(Sender as TMenuItem).Caption;
//   ChargeARepartir_Isa.SousTitreForm:=COuverture;
// AffichageForm(Monofenetrage,ChargeARepartir_Isa);
end;

//******************************************************************************

procedure TMain.CEtPConstatsdavance1Click(Sender: TObject);
begin
 if (ChargeCA_Isa = nil) then ChargeCA_Isa:=TChargeCA_Isa.Create(self);
 if ChargeCA_Isa.tag=2 then ChargeCA_Isa.Close;
 ChargeCA_Isa.tag := 1;
   GestListForm(ChargeCA_Isa.Caption,Cetpconstatsdavance1);
   ChargeCA_Isa.TitreForm:=(Sender as TMenuItem).Caption;
   ChargeCA_Isa.SousTitreForm:=COuverture;
    AffichageForm(Monofenetrage,ChargeCA_Isa);
end;

//******************************************************************************

procedure TMain.CEtPrecevoir1Click(Sender: TObject);
begin
 if (ChargesAPayer_Isa = nil) then ChargesAPayer_Isa:=TChargesAPayer_Isa.Create(self);
 if ChargesAPayer_Isa.Tag=2 then ChargesAPayer_Isa.close;
 ChargesAPayer_Isa.Tag:=1;
   GestListForm(ChargesAPayer_Isa.Caption,Cetprecevoir1);
   ChargesAPayer_Isa.TitreForm:=(Sender as TMenuItem).Caption;
   ChargesAPayer_Isa.SousTitreForm:=COuverture;
 AffichageForm(Monofenetrage,ChargesAPayer_Isa);
end;

//******************************************************************************

procedure TMain.Provisions1Click(Sender: TObject);
var
ParamAfficheProvision:TParamAfficheProvisions;
begin

ParamAfficheProvision.AffichageModal := Monofenetrage;
ParamAfficheProvision.Affiche := true;
ParamAfficheProvision.Quand := C_Ouverture;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAfficheProvision.TitreForm :=(Sender as TMenuItem).Caption;
ParamAfficheProvision.SousTitreForm := COuverture;
ParamAfficheProvision.AfficheListe:=false;
ProvisionsAffiche(ParamAfficheProvision);

end;

//******************************************************************************

procedure TMain.ValidationBalancedouverture1Click(Sender: TObject);
begin
// If (VBalOuv = nil) then VBalOuv:=TVBalOuv.Create(self);
// VBalOuv.show;
end;

//******************************************************************************

procedure TMain.SaisieAnneeAnterieurClick(Sender: TObject);
var
conteneur:TPieceAnterieure;
begin
 if E.AccesOuverture then
   begin
      if SaisieP_3 = Nil then SaisieP_3:= TSaisieP_3.Create(Self);
      if ((DMPieces.Piece1.EtatPiece in [dsinsert,dsedit])and(DMPieces.piece1.AnneePiece.PieceAnterieure=false))then
        begin
          showmessage('Vous saisissez actuellement une pièce dans le menu Ecriture/Saisie Pièce, terminez la saisie de cette pièce puis revenez dans dettes et créances');
        end
      else
        begin
           //if SaisieP_3.Visible then SaisieP_3.close;
          // SaisieP_3.Tag:=2;{ isa  le  02/06/04 déterminé dans le activate en fonction de "DMPieces.piece1.AnneePiece.PieceAnterieure"}
          if e.ExerciceSaisie='00'then
            conteneur.ExoAnterieure:='99'
          else
           if ((strtoint_lgr(E.ExerciceSaisie) <= 10) and (strtoint_lgr(E.ExerciceSaisie) > 0)) then
            begin
            conteneur.ExoAnterieure:='0'+IntToStr(strtoint_lgr(E.ExerciceSaisie)-1);
            end
            else
            begin
            conteneur.ExoAnterieure:=IntToStr(strtoint_lgr(E.ExerciceSaisie)-1);
            end;
          conteneur.PieceAnterieure:=true;
          DMPieces.piece1.AnneePiece:=conteneur;
          DMPieces.Piece1.SuppressionParticulieres:=false;
        end;
       GestListForm(SaisieP_3.Caption,SaisieAnneeAnterieur);
       SaisieP_3.TitreForm:=(Sender as TMenuItem).Caption;
       SaisieP_3.SousTitreForm:=COuverture;
       AffichageForm(Monofenetrage,SaisieP_3);
   end
  else
   begin
    AffichPieceOuverture;   
   end;
end;

//******************************************************************************

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Ecritures *********************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

//******************************************************************************

procedure TMain.mnSaisiePieceClick(Sender: TObject);
// Lance saisie pièce
var
conteneur:TPieceAnterieure;
begin
 if E.ExerciceCloture=false then
   begin
      if SaisieP_3 = Nil then SaisieP_3:= TSaisieP_3.Create(Self);
      if ((DMPieces.Piece1.EtatPiece in [dsinsert,dsedit])and(DMPieces.piece1.AnneePiece.PieceAnterieure))then
        begin
           showmessage('Vous saisissez actuellement une pièce dans le menu Ouverture/Dettes et Créances, terminez la saisie de cette Dette ou créance puis revenez dans Saisie Pièce');
        end
      else
        begin
          //if SaisieP_3.Visible then SaisieP_3.close;
          conteneur.ExoAnterieure:=e.ExerciceSaisie;
          conteneur.PieceAnterieure:=false;
          DMPieces.piece1.AnneePiece:=conteneur;
          DMPieces.Piece1.SuppressionParticulieres:=false;
          //SaisieP_3.Tag:=1; { isa  le  02/06/04 déterminé dans le activate en fonction de "DMPieces.piece1.AnneePiece.PieceAnterieure"}
       end;
       GestListForm('Ecritures : '+SaisieP_3.Caption,mnSaisiePiece);
       SaisieP_3.TitreForm:=str_remplacesouschaine((Sender as TMenuItem).Caption,'&','');
       SaisieP_3.SousTitreForm:=CMouvement;
       AffichageForm(Monofenetrage,SaisieP_3);
   end
 else
    begin
      //AffichPieceOuverture;
      AffichPieceSurPeriode(e.DatExoDebut,e.DatExoFin);
    end;
end;


//******************************************************************************

procedure TMain.Chargespayeretproduitsrecevoir2Click(Sender: TObject);
begin
 If (RepriseChargeAPayer_Isa = nil) then
 RepriseChargeAPayer_Isa:=TRepriseChargeAPayer_Isa.Create(self);
 try
   FiltrageDataSet(DMChargeAPayer.TaChAPayer,CreeFiltreEt(['DateSaisie'],[DateToStr(E.DatExoDebut - 1)]));
   if DMChargeAPayer.TaChAPayer.RecordCount=0 then
   abort;
   RepriseChargeAPayer_Isa.Tag:=1;
   if Monofenetrage then
     RepriseChargeAPayer_Isa.Showmodal
   else
     RepriseChargeAPayer_Isa.Show;
   GestListForm(RepriseChargeAPayer_Isa.Caption,Chargespayeretproduitsrecevoir2);
 except
   Messagedlg('Opération impossible !!!'+#10#13+'Vous n''avez pas saisie vos charges à payer et vos produits à recevoir dans l''ouverture !!!',MtWarning,[mbok],0);
   //abort;
 End;//fin du try
end;

//******************************************************************************

procedure TMain.Chargesetproduitsconstatsdavances1Click(Sender: TObject);
begin
 If (RepriseChargeCA = Nil) then RepriseChargeCA:=TRepriseChargeCA.Create(Self);
  try
   FiltrageDataSet(DMChargeCA.TaPCA,CreeFiltreEt(['DateSaisie'],[DateToStr(E.DatExoDebut - 1)]));
   if DMChargeCA.TaPCA.RecordCount=0 then abort;
   RepriseChargeCA.Tag:=1;
   if Monofenetrage then
     RepriseChargeCA.Showmodal
   else
     RepriseChargeCA.Show;
   GestListForm(RepriseChargeCA.Caption,Chargesetproduitsconstatsdavances1);
  except
//   showmessage('Opération impossible !!!'+#10#13+'Vous n''avez pas saisie vos charges et produits constatées d''avance dans l''ouverture !!!');
   Messagedlg('Opération impossible !!!'+#10#13+'Vous n''avez pas saisie vos charges et produits constatées d''avance dans l''ouverture !!!',MtWarning,[mbok],0);
//   abort;
  End;//fin du try
end;

//******************************************************************************

procedure TMain.Rglementsurliste1Click(Sender: TObject);
begin
 if (ReglementSurListe = nil) then ReglementSurListe:=TReglementSurListe.Create(self);
 if (sender as TMenuItem).Parent <> mnAffichage then
   ReglementSurListe.TitreForm:=(Sender as TMenuItem).Caption
 else
   GestListMenu(mnAffichage);
 ReglementSurListe.SousTitreForm:=CMouvement;
 GestListForm(ReglementSurListe.TitreForm+' - '+ReglementSurListe.SousTitreForm,mnReglementSurListe);
 AffichageForm(Monofenetrage,ReglementSurListe);


//if AffectReglement = nil then
//   AffectReglement:=TAffectReglement.Create(Application.MainForm);

end;

//******************************************************************************

procedure TMain.RepriseStoks1Click(Sender: TObject);
begin
 if DMStock=nil then
 DMStock:=TDMStock.Create(self);
     if DMStock.FiltragePourAffichageOD(e.DatExoDebut-1)=true then
     begin
         try
         DMStock.CreationODStockOuverture;
         except
           begin
//           showmessage('Problème à la création des OD ');
           abort;
           end;
         end;
//        SendToBack;
        Initialiser_ShortCut_Main(true);
        DMStock.DemandeAffichageReprise(e.DatExoDebut-1,'Reprise des Stocks d''Ouverture');
        Initialiser_ShortCut_Main(false);
        GestListForm('Reprise des Stocks d''Ouverture',RepriseStoks1);
        AssistantClotRafraichit(1);
        try
    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
      begin
        if Cloture_Def.EtapeSuivante>=1 then
          Cloture_Def.EtapeSuivante:=0;{ isa  le  16/09/03 }
      end;
        except
          //
        end;
     end
     else
     Begin
     Messagedlg('Opération impossible !!! Vous n''avez pas saisie vos stocks dans le bilan d''ouverture !!!',MtWarning,[Mbok],0);
     DeFiltrageDataSet(DMStock.DataStock.DataSet);
     End;
end;

//******************************************************************************

procedure TMain.Pieces1Click(Sender: TObject);
var
ParamRechercheBD:TParamRechercheBD;
begin
  ParamRechercheBD.Ouverture := true;
  ParamRechercheBD.Ecriture:=true;
  RechercheBDAffiche(ParamRechercheBD);


// if (GestVisu = nil) then GestVisu:=TGestVisu.Create(self);
//   GestListForm(GestVisu.Caption,Pices1);
// AffichageForm(Monofenetrage,GestVisu);

//   if Monofenetrage then
//       GestVisu.showmodal else
// GestVisu.show;
// if (VisuPieces = nil) then VisuPieces:=TVisuPieces.Create(self);
// VisuPieces.show;
end;

//******************************************************************************

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Gestion ***********************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

//******************************************************************************

procedure TMain.Balance2Click(Sender: TObject);
begin
 if (Balancenew = nil) then Balancenew:=TBalancenew.Create(Application.MainForm);
 if (sender as TMenuItem).Parent <> mnAffichage then
 Balancenew.TitreForm:=(sender as TMenuItem).Caption
 else
 GestListMenu(mnAffichage);
 Balancenew.SousTitreForm:=CMouvement;
 GestListForm(Balancenew.Caption,Balance2);
 AffichageForm(Monofenetrage,Balancenew);
//    if Monofenetrage then
//       Balancenew.showmodal else
//       Balancenew.show;
end;

//******************************************************************************

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Cloture ***********************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

//******************************************************************************
procedure TMain.StoksdeFin1Click(Sender: TObject);
var
ParamAfficheStock:TParamAffichageStock;
begin
ParamAfficheStock.AffichageModal := Monofenetrage;
ParamAfficheStock.Affiche := true;
ParamAfficheStock.Quand := C_cloture;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAfficheStock.TitreForm :=(Sender as TMenuItem).Caption;
ParamAfficheStock.SousTitreForm := CCloture;
StocksAffiche(ParamAfficheStock);
//    // On filtre la table pour savoir s'il reste des stocks à reprendre à l'ouverture
//    FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie','Reference'],['True',DateToStr(E.DatExoDebut - 1),'']));
//   if DMRech.TaStockRech.RecordCount=0 then
//      begin
//        If (Stocks = Nil) Then Stocks:=TStocks.Create(Self);
//        if ((stocks.tag = C_Ouverture) and (Stocks.Visible=true)) then Stocks.Close;
//        Stocks.Tag:=C_cloture;
////        FiltrageDataSet(DMStock.DataStock.DataSet,'ID=-1');
//        if (sender as TMenuItem).Parent <> mnAffichage then
//          Stocks.TitreForm:=(Sender as TMenuItem).Caption;
//        Stocks.SousTitreForm:=CCloture;
//        GestListForm(stocks.TitreForm+' - '+Stocks.SousTitreForm,StoksdeFin1);
//        AffichageForm(Monofenetrage,Stocks);
//      end
//    else
//      begin
//        Messagedlg('Opération impossible !!! Tous vos Stocks d''Ouverture n''ont pas été repris !!!',MtWarning,[mbok],0);
//        DeFiltrageDataSet(DMRech.TaStockRech);
//      end;
end;

//******************************************************************************

procedure TMain.Dpensedelentreprise1Click(Sender: TObject);
begin
     If (DepensesEntreprise = nil) Then
     DepensesEntreprise := TDepensesEntreprise.create(Self);

     //DMPlan.FiltrageAideCompte(16);
     AideCompte.FiltrageAideCompte(16);

     If DMPlan.taCompte.RecordCount = 0 Then
     Begin
       Messagedlg('Votre plan comptable ne contient aucun compte attendu ici !!!'+#10#13+'Pour pouvoir utiliser ce menu, vous devez créer le ou les comptes nécessaires dans Méthodes/Plan Comptable!!!',MtWarning,[mbok],0);
     End
     Else
     Begin
       DMDepenseEnt.TaDepense.Filtered:=false;
       GestListForm(DepensesEntreprise.Caption,Dpensedelentreprise1);
       AffichageForm(Monofenetrage,DepensesEntreprise);
     End;
end;

//******************************************************************************

procedure TMain.Chargesrpartir2Click(Sender: TObject);
var
ParamAfficheChargeARepartir:TParamAfficheChargeARepartir;
begin

ParamAfficheChargeARepartir.AffichageModal := Monofenetrage;
ParamAfficheChargeARepartir.Affiche := true;
ParamAfficheChargeARepartir.Quand := C_Cloture;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAfficheChargeARepartir.TitreForm :=(Sender as TMenuItem).Caption;
ParamAfficheChargeARepartir.SousTitreForm := CCloture;

ChargeARepartirAffiche(ParamAfficheChargeARepartir);

// if (ChargeARepartir_Isa = nil) then ChargeARepartir_Isa:=TChargeARepartir_Isa.Create(self);
// if ChargeARepartir_Isa.tag=C_Ouverture then ChargeARepartir_Isa.close;
// ChargeARepartir_Isa.Tag := C_Cloture;
// GestListForm(ChargeARepartir_Isa.Caption,Chargesrpartir2);
//   ChargeARepartir_Isa.TitreForm:=(Sender as TMenuItem).Caption;
//   ChargeARepartir_Isa.SousTitreForm:=CCloture;
// AffichageForm(Monofenetrage,ChargeARepartir_Isa);
end;

//******************************************************************************

procedure TMain.Chargespayeretproduitsrecevoir3Click(Sender: TObject);
begin
 If (ChargesAPayer_Isa = nil) then
 ChargesAPayer_Isa:=TChargesAPayer_Isa.Create(self);
 try
   if ChargesAPayer_Isa.Tag=1 then ChargesAPayer_Isa.close;
    try
//     DMChargeAPayer.filtrageAvantCloture;
     FiltrageDataSet(DMChargeAPayer.TaChAPayer,CreeFiltreET(['DateSaisie','Reference'],[DateToStr(E.DatExoDebut -1),'']));
     if DMChargeAPayer.TaChAPayer.RecordCount<>0 then
     abort;
    except
     //Messagedlg('Opération impossible !!!'+#10#13+'Toutes les Charges à Payer et tous les Produits à Recevoir de l''Ouverture n''ont pas été repris !!!',MtWarning,[mbok],0);
     if application.MessageBox(Pchar('Attention !!!'+#10#13+'Toutes les Charges à Payer et tous les Produits à Recevoir de l''Ouverture n''ont pas été repris, voulez-vous continuer !!!'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mrno then
       abort;
    end;//fin du try
 ChargesAPayer_Isa.Tag := 2;
 GestListForm(ChargesAPayer_Isa.Caption,Chargespayeretproduitsrecevoir3);
   ChargesAPayer_Isa.TitreForm:=(Sender as TMenuItem).Caption;
   ChargesAPayer_Isa.SousTitreForm:=CCloture;
 AffichageForm(Monofenetrage,ChargesAPayer_Isa);
 except
   //
 end;//fin du try
end;

//******************************************************************************

procedure TMain.Provisions2Click(Sender: TObject);
var
ParamAfficheProvision:TParamAfficheProvisions;
begin
ParamAfficheProvision.AffichageModal := Monofenetrage;
ParamAfficheProvision.Affiche := true;
ParamAfficheProvision.Quand := C_Cloture;
if sender<>nil then
    begin
      if (sender as TMenuItem).Parent <> mnAffichage then
         ParamAfficheProvision.TitreForm :=(Sender as TMenuItem).Caption;
    end;
ParamAfficheProvision.SousTitreForm := CCloture;
ParamAfficheProvision.AfficheListe:=sender=nil;
ProvisionsAffiche(ParamAfficheProvision);

end;

//******************************************************************************

procedure TMain.Chargesetproduitsconstatsdavance2Click(Sender: TObject);
begin
try
 If (ChargeCA_Isa = nil) then ChargeCA_Isa:=TChargeCA_Isa.Create(self);
 try
  FiltrageDataSet(DMChargeCA.TaPCA,CreeFiltreET(['DateSaisie','Reference'],[DateToStr(E.DatExoDebut -1),'']));
  if DMChargeCA.TaPCA.recordcount <> 0 then abort; // PB le 28/07/03 ( <> remplace = )
 except
  //Messagedlg('Attention !!!'+#10#13+'Toutes les Charges et Produits constatés d''avance de l''Ouverture n''ont pas été repris !!!',MtWarning,[mbok],0);
  if application.MessageBox(Pchar('Attention !!!'+#10#13+'Toutes les Charges et Produits constatés d''avance de l''Ouverture n''ont pas été repris, voulez-vous continuer !!!'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mrno then
    begin
      DeFiltrageDataSet(DMChargeCA.TaPCA);
      abort;
    end;
 end;//fin du try
  if ChargeCA_Isa.tag=1 then ChargeCA_Isa.Close;
  ChargeCA_Isa.Tag := 2;
 GestListForm(ChargeCA_Isa.Caption,Chargesetproduitsconstatsdavance2);
   ChargeCA_Isa.TitreForm:=(Sender as TMenuItem).Caption;
   ChargeCA_Isa.SousTitreForm:=CCloture;
 AffichageForm(Monofenetrage,ChargeCA_Isa);
except
  DeFiltrageDataSet(DMChargeCA.TaPCA); // PB le 28/07/03
end;
end;

//******************************************************************************

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§                 Menu Immo                       §§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

//******************************************************************************

procedure TMain.mnImmoToutesClick(Sender: TObject);
begin
//// Consultation de toutes les immos
//   if ListeImmos = Nil then ListeImmos := TListeImmos.Create(Self);
//   ListeImmos.Tag := C_IMMOS;
//   with DMImmos.DataModuleImmos.qryImmos do begin
//      Active := false;
//      ParamByName('Cpt').AsString := '%';
//      ParamByName('DateAchat').AsDate := StrToDate('01/01/1901');
//		Active := true;
//   end;
//   ListeImmos.show;
end;
//******************************************************************************
procedure TMain.mnImmoParCompteClick(Sender: TObject);
begin
//// Consultation des immos par compte
//   if ListeImmos = Nil then ListeImmos := TListeImmos.Create(Self);
//   ListeImmos.Compte.Text := '2';
//   ListeImmos.Tag := C_IMMOS;
//   if(AideCompte = Nil) then
//	   AideCompte:= TAideCompte.Create(Application.MainForm);
//   AideCompte.Tag := C_NO_CONTROL;
//   AideCompteAffiche(ListeImmos.Compte);
//   with DMImmos.DataModuleImmos.qryImmos do begin
//      Active := false;
//      ParamByName('Cpt').AsString := ListeImmos.Compte.Text + '%';
//      ParamByName('DateAchat').AsDate := StrToDate('01/01/1901');
//      Active := true;
//   end;
//   ListeImmos.show;
end;

//******************************************************************************
procedure TMain.mnSyntheseImmoClick(Sender: TObject);
begin
// Cumul des immos
   if CumulImmos = Nil then CumulImmos := TCumulImmos.Create(Self);
   CumulImmos.Show;
end;

//******************************************************************************
procedure TMain.mnCrationFichesAcquisClick(Sender: TObject);
begin
   if ListeAcquis = Nil then ListeAcquis := TListeAcquis.Create(Self);
   with DMImmos.DataModuleImmos.qryListeAcquis do begin
	   Active := true;
   end;
   ListeAcquis.Tag := C_ACQUISITION_Terminee;
   ListeAcquis.show;
end;

//******************************************************************************
//procedure TMain.mnAcquisExerciceClick(Sender: TObject);
//begin
//
//end;

//******************************************************************************
procedure TMain.mnPlusMoinsValuesClick(Sender: TObject);
begin
// Plus et moins values
   if PlusMoinsValues = Nil then PlusMoinsValues := TPlusMoinsValues.Create(Self);
   PlusMoinsValues.show;
end;

//******************************************************************************
procedure TMain.mnAmortisImmo5ansClick(Sender: TObject);
begin
// Amortissement sur 5 ans des immos
	if Amort5Ans = Nil then Amort5Ans := TAmort5Ans.Create(Self);
	Amort5Ans.show;
end;

//******************************************************************************
procedure TMain.mnCessionsSimplesClick(Sender: TObject);
begin
// Cessions simples
	if ListeAcquis = Nil then ListeAcquis := TListeAcquis.Create(Self);
   ListeAcquis.Tag := C_CESSION;
	ListeAcquis.show;
end;

//******************************************************************************
procedure TMain.mnCessionsGroupeesClick(Sender: TObject);
begin
// Cessions groupees
end;

//******************************************************************************
procedure TMain.mnCessionsExerciceClick(Sender: TObject);
begin
// Cessions de l'exercice
	if ListeImmos = Nil then ListeImmos := TListeImmos.Create(Self);
   ListeImmos.Compte.Text := '2';
   ListeImmos.Tag := C_CESSION_EXO;
	ListeImmos.show;
end;

//******************************************************************************
procedure TMain.mnMiseAuRebutClick(Sender: TObject);
begin
//// Mise au rebut d'une immo
//	if ListeImmos = Nil then ListeImmos := TListeImmos.Create(Self);
//   ListeImmos.Compte.Text := '2';
//   ListeImmos.Tag := C_REBUT;
//   if(AideCompte = Nil) then
//		AideCompte:= TAideCompte.Create(Application.MainForm);
//   AideCompte.Tag := C_NO_CONTROL;
//   AideCompteAffiche(ListeImmos.Compte);
//   with DMImmos.DataModuleImmos.qryImmos do begin
//      Active := false;
//      ParamByName('Cpt').AsString := ListeImmos.Compte.Text + '%';
//      ParamByName('DateAchat').AsDate := StrToDate('01/01/1901');
//		Active := true;
//   end;
//	ListeImmos.show;
end;

//******************************************************************************

procedure TMain.mnDivisionImmoClick(Sender: TObject);
begin
//// Division d'une immo
// if ListeImmos = Nil then ListeImmos := TListeImmos.Create(Self);
// ListeImmos.Compte.Text := '2';
// ListeImmos.Tag := C_DIVISION;
// if(AideCompte = Nil) then AideCompte:= TAideCompte.Create(Application.MainForm);
// AideCompte.Tag := C_NO_CONTROL;
// AideCompteAffiche(ListeImmos.Compte);
// with DMImmos.DataModuleImmos.qryImmos do
//  begin
//   Active := false;
//   ParamByName('Cpt').AsString := ListeImmos.Compte.Text + '%';
//   ParamByName('DateAchat').AsDate := StrToDate('01/01/1901');
//   Active := true;
//  end;
// ListeImmos.show;
end;

//******************************************************************************

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Outils ************************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

//******************************************************************************

procedure TMain.mnMessageClick(Sender: TObject);
begin
// AfficheSaisieMessage;
end;

//******************************************************************************

procedure TMain.mnAfficheEspionClick(Sender: TObject);
begin
 AfficheEspion:= mnAfficheEspion.Checked;
end;

//******************************************************************************

procedure TMain.mnLectureTableClick(Sender: TObject);
//var
// frmLecture :TLectureTable;
begin
// frmLecture:= TLectureTable.Create(Self);
// frmLecture.Affiche('');
end;

//******************************************************************************

procedure TMain.mnRequeteSqlClick(Sender: TObject);
//var
// frmSql :TRequeteSql;
begin
// frmSql:= TRequeteSql.Create(Self);
// frmSql.Affiche(E.RepertoireProgram, '', E.RepertoireDonnees,False);
end;

//******************************************************************************

procedure TMain.mnOptionsMenuClick(Sender: TObject);
begin
 if (ChMenu = nil) then ChMenu:=TChMenu.Create(self);
 ChMenu.show;
end;

//******************************************************************************

procedure TMain.OptionsLicence1Click(Sender: TObject);
begin
 if (ParamProg = nil) then ParamProg:=TParamProg.Create(self);
 ParamProg.show;
end;

//******************************************************************************

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Affichage *********************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§


//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//***************************** Menu Aide **************************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
procedure TMain.mnAproposClick(Sender: TObject);
var
//	VisuAPropos: TVisuAPropos;
distribution:string;
begin
distribution:=TypeVersionToStr(E.TypeVersion)+';'+
              TypeClientToStr(E.TypeClient)+';'+
              TypeUtilisateurToStr(E.TypeUtilisateur);
//AfficheAPropos(main.Handle,PChar('A Propos'),PChar(TypeClientToStr(E.TypeClient)));
AfficheAPropos(main.Handle,PChar('A Propos'),PChar(distribution));

//   VisuAPropos:= TVisuAPropos.Create(Self);
//   VisuAPropos.ShowModal;
//   VisuAPropos.Free;
end;

//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//**************************** Main ********************************************
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

procedure TMain.FormCreate(Sender: TObject);
Var
//   Registre :TRegistry;
//   DirOk:boolean;
   ListeCouleurDBGrid:TStringList;
   i:integer;
   ListFicSuppr:TStringList;
   CheminIco:string;
//   TabBool:TBits;
begin

listeCompteValide:=TStringList.Create;
InitMain(Type_version_execution);


Application.OnShortCut := OnShortCut;
Application.OnException:=OnException;
// Version COGERE du 5/11/2002
// Fin version COGERE du 5/11/2002


// Version COGERE du 5/11/2002
 Panel3.Visible:=not Panel3.Visible;
 PaOutils.Visible:= not PaOutils.Visible;
// Fin version COGERE du 5/11/2002

//grgrid1.Champ_Readonly.Add(true);
//grgrid1.Champ_Readonly.Add(false);
//grgrid1.Champ_Readonly.Add(true);
//grgrid1.Champ_Readonly.Add(false);
//grgrid1.Champ_Readonly.Add(true);
//TabBool:=TBits.Create;
//TabBool.Size:=grgrid1.RowCount-1;
//grgrid1.Cols[3].AddObject('test',Tabbool);
//grgrid1.ParamColor:=true;
//grgrid1.Param:=ParamUtil.CouleurDBGrid;
//grgrid1.UpDateColor;

////ListMenu.OnDblClick:=LibClassObjetSender.SenderOnClick;
////PAramUtil:=TParamUtil.Create;
////PAramUtil:=Paramutil.InitParamDefaut;
////Paramutil:=TParamUtil.Create
CheminIco:=E.RepertoireProgram+'Favoris Epicea';
if not DirectoryExists(CheminIco) then
        ForceDirectories(CheminIco);
CheminIco:=CheminIco+'\';
DragAcceptFiles(ListeOutils.Handle, true);
//DragAcceptFiles(TMyCustomListView(PaOutils).Handle, true);

 ListForm:=TStringList.Create;

ListFicSuppr:=TStringList.Create;
ListFicSuppr:=ListeFic(quedeschiffres(DateToStr(now-1))+'*.fic',E.RepertoireProgram+'0000000000\',faAnyFile,true,true);
for i:=0 to ListFicSuppr.Count-1 do
    begin
//     showmessage(ListFicSuppr.strings[i]);
     deletefile(PChar(ListFicSuppr.strings[i]));
    end;
ListFicSuppr.Free;
//Agent1.Connected:=True;//On "branche" l'agent à notre appli
//Agent1.Characters.Load('MERLIN', 'MERLIN.ACS');//on charge le perso Claude
//Claude:=IAgentCtlCharacterEX(Agent1.Characters.Character('MERLIN'));//on désigne Claude comme agent de l'application
//Claude.LanguageID:=$40C;

 ListeClic:=TStringList.Create;
//Epicea2.
LastWinControl:=ActiveControl;
Lastzoneedit:=ActiveControl;

VersionBeta:=true;
//Screen.OnActiveControlChange:=ChangementControle;
//application.onmessage:=AppMessage;
//Application.OnDeactivate := AppDeactivate;
//Application.OnActivate := AppActivate;
//Screen.OnActiveFormChange:=ChangementForm;
// Init des Variables Globales
////////////////***************** ATTENTION A RECHANGER***********************
//E.DateDebutDeclarationTVA:=strtodate('01/01/2002');
//E.DateFinDeclarationTVA:=strtodate('30/06/2002');
//E.PremiereDateDeclaration:=strtodate('01/01/2002');
////////////////////////////////////////////////////////////////////////////

//ContourCouleur:=$0033CCFF;
//PanelColor:=ParamUtil.CouleurPanelCorps;
//PanelColor:=$00BADCDC; // Vert ( comme VisuImmo)
//PanelColor:=$00BDD8DF; // Marron ( comme stoks )

// PArametre couleur sur zone saisie
//ContourCouleur:=clRed;
//ShadowColorOn:=clRed;
//TextColorOn:=clWindowText;
//ShadowColorOff:=clBtnHighlight;
//TextColorOff:=clWindowText;

//// DBGrid
  ParamUtil.CouleurDBGrid.LigneContour:=clGreen;
  ParamUtil.CouleurDBGrid.CelActiveContour:=$0000E600;
  ParamUtil.CouleurDBGrid.CelActiveColorFond:=clactiveBorder;
  ParamUtil.CouleurDBGrid.CelActiveColorFont:=clWhite;
  ParamUtil.CouleurDBGrid.CelActiveSAisieColorFont:=clBlack;
  ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond:=$0000E600;
  ParamUtil.CouleurDBGrid.CelFixeColorFond:=clBtnFace;
  ParamUtil.CouleurDBGrid.CelFixeColorFont:=clWindowText;
  ParamUtil.CouleurDBGrid.GrilleColorFond:=$00EAFAFF;
  ParamUtil.CouleurDBGrid.GrilleColorFont:=clWindowText;
// Affichage des Titres
//Panel1.Color:=$00EAFAFF;
// Parametre client pour DBGrid
  if FileExists(E.RepertoireProgram+ 'Datadb.dat') then
  begin
  ListeCouleurDBGrid:=TStringList.Create;
  ListeCouleurDBGrid.LoadFromFile(E.RepertoireProgram+ 'Datadb.dat');
  try
    for i:=0 to ListeCouleurDBGrid.Count-1 do
        begin
         case i of
            0:ParamUtil.CouleurDBGrid.LigneContour:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            1:ParamUtil.CouleurDBGrid.CelActiveContour:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            2:ParamUtil.CouleurDBGrid.CelActiveColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            3:ParamUtil.CouleurDBGrid.CelActiveColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            4:ParamUtil.CouleurDBGrid.CelActiveSAisieColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            5:ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            6:ParamUtil.CouleurDBGrid.CelFixeColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            7:ParamUtil.CouleurDBGrid.CelFixeColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            8:ParamUtil.CouleurDBGrid.GrilleColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            9:ParamUtil.CouleurDBGrid.GrilleColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
         end;
        end;
//    Panel1.Color:=CouleurDBGrid.GrilleColorFond;
    ListeCouleurDBGrid.Free;
  except
  // DBGrid
    showmessage('La lecture de certains paramètres à échouée, ceux par défaut ont été restaurés !');
    ParamUtil.CouleurDBGrid.LigneContour:=clGreen;
    ParamUtil.CouleurDBGrid.CelActiveContour:=$0000E600;
    ParamUtil.CouleurDBGrid.CelActiveColorFond:=clactiveBorder;
    ParamUtil.CouleurDBGrid.CelActiveColorFont:=clWhite;
    ParamUtil.CouleurDBGrid.CelActiveSAisieColorFont:=clBlack;
    ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond:=$0000E600;
    ParamUtil.CouleurDBGrid.CelFixeColorFond:=clBtnFace;
    ParamUtil.CouleurDBGrid.CelFixeColorFont:=clWindowText;
    ParamUtil.CouleurDBGrid.GrilleColorFond:=$00EAFAFF;
    ParamUtil.CouleurDBGrid.GrilleColorFont:=clWindowText;
//    Panel1.Color:=CouleurDBGrid.GrilleColorFond;
    ListeCouleurDBGrid.Free;
  end;

  end;
//   Multidossier:=false;                                             (e.TypeClient<>CL_Saisie_Demo) and (e.TypeClient<>Cl_Demo)
   Multidossier:=((not E.Type_Version_Test_Client)
       and (e.TypeUtilisateur<>u_Demo)
       and (e.TypeUtilisateur<>U_Comptable)
       and (e.TypeUtilisateur<>U_LibreService)); //23/09/2010
   DossierProt:=true;

//showwindow(application.Handle,SW_HIDE); {Cache l'appli dans la barre des taches}
DebutSession:=now;
//DanHint1.HintActive:=true;
ShortDateFormat:='dd/mm/yyyy';
//Menu.name:='MenuP';
//WriteComponentResFile(E.RepertoireProgram+'MOrg',Menu);
//Menu.name:='MenuMain';
//Registre:= TRegistry.Create;
//                    with Registre do begin
//                      RootKey := HKEY_LOCAL_MACHINE;
//                      OpenKey('\SOFTWARE\LGR\Epicea2\Defaut\', false);
//                      try
//                       E.User:=ReadString('LastUser');
//                       if empty(E.User) then E.User:='Anonyme';
//                       IDExo:=ReadString('IDExo');
//                       DirDos:=ReadString('DirDos');
//                       DirExo:=ReadString('DirExo');
//                       NomDos:=ReadString('NomDos');
//                       NomExo:=ReadString('NomExo');
//                       IdDosExo:=ReadString('ID');
//                       IDDos:=ReadString('IDDOS');
//                       DosProtectAffiche(E.User);
//                       Closekey;
//                      except
//                       E.User:='Anonyme';
//                       IDExo:='0';
//                       case TypeVersion of
//                       VerAgricole:begin
//                                    DirDos:=E.RepertoireProgram + 'Demo\';
//                                    DirExo:=E.RepertoireProgram + 'Demo\ExoDemo\';
//                                    NomDos:='Demo';
//                                    NomExo:='ExoDemo';
//                                   end;
//                       VerDiocese:begin
//                                    DirDos:=E.RepertoireProgram+ 'DosParoisse\';
//                                    DirExo:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
//                                    NomDos:='DosParoisse';
//                                    NomExo:='ExoParoisse';
//                                   end;
//                       end;
//                       IdDosExo:='0';
//                       IDDos:='0';
//                       DosProtectAffiche(E.User);
//                       Closekey;
//                      end;
//
//                  end;

/////////////////////////Section d'initialisation avec base de registre/////////////
// PB le 14/09/03

//    try
//
//	InitialiseForm(E.User,Self);
//        ScreenAjuste_OldDef_DefinitionCourant(ParamUtil.OldScreenWidth,ParamUtil.OldScreenHeight,self);
//                 InitialiseListView('\SOFTWARE\LGR\Epicea2\'+E.User+ '\'+ self.Name+ '\',ListeOutils,ImListOutils,CheminIco);
//                 with Registre do
//                 begin
//                    RootKey := HKEY_LOCAL_MACHINE;
//                    OpenKey('\SOFTWARE\LGR\Epicea2\'+E.User+ '\' + self.Name, false);
//                    try
//                     AfficheTitre:=ReadBool('AfficheTitre');
//                     paramutil.AfficheTitre:=ReadBool('AfficheTitre');
//                     Monofenetrage:=ReadBool('Mono');
//                     ParamUtil.IcoMenuDemarrer:=ReadBool('IcoMenuDemarrer');
//                     ParamUtil.IcoMenuProgramme:=ReadBool('IcoMenuProgramme');
//                     ParamUtil.IcoBureau:=ReadBool('IcoBureau');
//                     ParamUtil.AssistantAffichageAuto:=ReadBool('AssistantAffichageAuto');
//                     ParamUtil.AssistantDelaiAffichage:=ReadInteger('AssistantDelaiAffichage');
//                    except
//                     AfficheTitre:=true;
//                     Monofenetrage:=true;
//                    end;
//                 end;
//    except
//        Position:=poDesigned;
//        InitialiseFormPosDefaut(self);
//        ScreenAjuste_OldDef_DefinitionCourant(ParamUtil.OldScreenWidth,ParamUtil.OldScreenHeight,self);
////	Left:= 0; Top:= 0; Width:= screen.Width; Height:= screen.Height;
//    end;
/////////////////////////Fin Section d'initialisation avec base de registre/////////////
// PB le 14/09/03

    try

  	LibGestionParamXML.InitialiseForm(E.User,Self);
    ScreenAjuste_OldDef_DefinitionCourant(ParamUtil.OldScreenWidth,ParamUtil.OldScreenHeight,self);
    InitialiseListView('\SOFTWARE\LGR\Epicea2\'+E.User+ '\'+ self.Name+ '\',ListeOutils,ImListOutils,CheminIco);
        try
         AfficheTitre:=StrToBool(DMXml.RetourneValItemVarEcran(E.User,Self.name,'AfficheTitre')).valeur;
         paramutil.AfficheTitre:=AfficheTitre;
         Monofenetrage:=StrToBool(DMXml.RetourneValItemVarEcran(E.User,Self.name,'Mono')).valeur;
         ParamUtil.FocusDesactive:=StrToBool(DMXml.RetourneValItemVarEcran(E.User,Self.name,'FocusDesactive')).valeur;
         ParamUtil.MonoFenetre:=Monofenetrage;
         ParamUtil.IcoMenuDemarrer:=StrToBool(DMXml.RetourneValItemVarEcran(E.User,Self.name,'IcoMenuDemarrer')).valeur;
         ParamUtil.IcoMenuProgramme:=StrToBool(DMXml.RetourneValItemVarEcran(E.User,Self.name,'IcoMenuProgramme')).valeur;
         ParamUtil.IcoBureau:=StrToBool(DMXml.RetourneValItemVarEcran(E.User,Self.name,'IcoBureau')).valeur;
         ParamUtil.AssistantAffichageAuto:=StrToBool(DMXml.RetourneValItemVarEcran(E.User,Self.name,'AssistantAffichageAuto')).valeur;
         ParamUtil.AssistantDelaiAffichage:=strtoint_lgr(DMXml.RetourneValItemVarEcran(E.User,Self.name,'AssistantDelaiAffichage'));
        except
         AfficheTitre:=true;
         paramutil.AfficheTitre:=AfficheTitre;
         Monofenetrage:=true;
         ParamUtil.MonoFenetre:=true;
        end;
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
        ScreenAjuste_OldDef_DefinitionCourant(ParamUtil.OldScreenWidth,ParamUtil.OldScreenHeight,self);
//	Left:= 0; Top:= 0; Width:= screen.Width; Height:= screen.Height;
    end;

try
  if ParamUtil.IcoMenuDemarrer then
    CreateShortcut(Application.ExeName,_STARTMENU,'');
  if ParamUtil.IcoMenuProgramme then
    CreateShortcut(Application.ExeName,_STARTMENU,'Programmes');
  if ParamUtil.IcoBureau then
    CreateShortcut(Application.ExeName,_DESKTOP ,'');
except

end;
DMXml.AjouteUtilisateur(E.User);
//if (CreatDos = nil) then CreatDos:=TCreatDos.Create(self);
//           CreatDos.tag:=1;
//	   CreatDos.showModal;

//case TypeVersion of
//   VerAgricole:try
//                 with Registre do begin
//                    RootKey := HKEY_LOCAL_MACHINE;
//                    OpenKey('\SOFTWARE\LGR\Epicea2\'+E.User+ '\' + self.Name, false);
//                    try
////                     DirDos:=ReadString('DirDos');
////                     DirExo:=ReadString('DirExo');
////                     IdDosExo:=ReadString('ID');
////                     IDDos:=ReadString('IDDOS');
//                     AfficheTitre:=ReadBool('AfficheTitre');
//                     Monofenetrage:=ReadBool('Mono');
//                     DirOk:=((DirDos<>'') and (DirExo<>''));
//                     if empty(DirDos) then DirDos:=E.RepertoireProgram + 'Demo\';
//                     if empty(dirExo) then DirExo:=E.RepertoireProgram + 'Demo\ExoDemo\';
//                     if empty(NomDos) then NomDos:='Demo';
//                     if empty(NomExo) then NomExo:='ExoDemo';
////!!!!!!!!!!!!!!!!!!!!!! A enlever
////                     DirDos:=E.RepertoireProgram+ 'Demo\';
////                     DirExo:=E.RepertoireProgram + 'Demo\ExoDemo\';
////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//                    Except
//                     DirDos:=E.RepertoireProgram+ 'Demo\';
//                     DirExo:=E.RepertoireProgram + 'Demo\ExoDemo\';
//                     NomDos:='Demo';
//                     NomExo:='ExoDemo';
//                     Monofenetrage:=true;
//                     AfficheTitre:=true;
//                     end;
//                    end;
//                  finally
//                  Registre.free;
//               end;
//
//   VerDiocese:try
//                self.caption:='Epi2 Diocèse - Logiciel de comptabilité pour les diocèses - Diocèse de Montpellier';
//                 with Registre do begin
//                    RootKey := HKEY_LOCAL_MACHINE;
//                    OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
//                    try
////                     DirDos:=ReadString('DirDos');
////                     DirExo:=ReadString('DirExo');
////                     IdDosExo:=ReadString('ID');
////                     IDDos:=ReadString('IDDOS');
//                     AfficheTitre:=ReadBool('AfficheTitre');
//                     Monofenetrage:=ReadBool('Mono');
//                     Monofenetrage:=true;
//                     DirOk:=((DirDos<>'') and (DirExo<>''));
//
//                     DirDos:='';
//                     DirExo:='';
////                     if DirDos='' then DirDos:='T:\Program Files\EpiceaW\DosParoisse\';
////                     if DirExo='' then DirExo:='T:\Program Files\EpiceaW\DosParoisse\ExoParoisse\';
//                     if Empty(DirDos) then DirDos:=E.RepertoireProgram + 'DosParoisse\';
//                     if empty(dirExo) then DirExo:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
//                     if empty(NomDos) then NomDos:='DosParoisse';
//                     if empty(NomExo) then NomExo:='ExoParoisse';
//                    Except
//                     DirDos:=E.RepertoireProgram+ 'DosParoisse\';
//                     DirExo:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
//                     NomDos:='DosParoisse';
//                     NomExo:='ExoParoisse';
//                     Monofenetrage:=true;
//                     AfficheTitre:=true;
//
////                     DirDos:='';
////                     DirExo:='';
////                     if DirDos='' then DirDos:='T:\Program Files\EpiceaW\DosParoisse\';
////                     if DirExo='' then DirExo:='T:\Program Files\EpiceaW\DosParoisse\ExoParoisse\';
//                     end;
//                    end;
//                  finally
//                  Registre.free;
////                  {$IFDEF Diocese}
////                  EtatdeVersement1.Visible:=true;
////                  {$ENDIF}
//               end;
//end;

//    DMBD.InitBDExercice(DirExo);
//    DMBD.InitBDDossier(DirDos);
//    DMBD.OpenAllTAble;

//  if DMBD=Nil then DMBD:=TDMBD.Create(Application);

//   if ParamCount>0 then
//   MessageDlg(ParamStr(0), mtInformation,[mbOk], 0);


   timHeureTimer(Sender);
   AfficheEspion:= True;
//   dbNameProg
   {Ouverture des DataBases, et affectation des repertoires}
//   TaMessage.DatabaseName:=dbNameProg.DatabaseName;
//   dbNameProg.Connected:=true;
//   dbNameProg.close;
//   dbNameProg.Params[0]:= 'PATH=' + E.RepertoireProgram;
//   dbNameProg.open;
//   TaMessage.close;
//   TaMessage.Open;
//  if DMBD=Nil then DMBD:=TDMBD.Create(self);
//   DMBD.DMBDCreate(application.MainForm);

//   OuvreExo(NomDos,NomExo);
//   DMBD.InitAllDB(E.RepertoireProgram,DirDos,DirExo);
//   E.RepertoireDossier :String;
//   E.RepertoireExercice :=DirExo;
//   E.RepertoireProgram : String;
//   E.RepertoireDonnees:=
//   E.ExerciceBase:='02';
//   E.ExerciceSaisie:='02';
//   E.Regime:='A';
//   E.TypeEntreprise:=DossierTypeEntreprise;
//   E.Devise:=DossierIDDevise;

//   E.DeviseSigle:='';
//   E.DeviseSigle:=DeviseSigle(E.Devise);
//   E.FormatMonnaie:=',0.00 '+E.DeviseSigle+';-,0.00 '+E.DeviseSigle+';,0.00 '+E.DeviseSigle;
//   E.EditFormat:='0.00 ;-0.00 ';
//   dbNameDossier.Close;
//   dbNameDossier.Params[0]:= 'PATH=' + DirDos;
//   dbNameDossier.Open;
//   dbNameExo.Close;
//   dbNameExo.Params[0]:= 'PATH=' + DirExo;
//   dbNameExo.Open;
//   dbNameDossier.Params[0]:= 'PATH=' +    E.RepertoireExercice;

// Première Utilisation
//GestDos.DatabaseName:=DMBD.dbNameProg.DatabaseName;
//   GestDos.Close;
//   GestDos.Open;
//   if GestDos.RecordCount = 0 then
//      begin
//	if (ParamProg = nil) then ParamProg:=TParamProg.Create(self);
//	ParamProg.showModal;
//        if ParamProg.SpeedButton2.Down then begin
//         mnDemoClick(self);
//         end else
//         begin
//         if (CreatDos = nil) then CreatDos:=TCreatDos.Create(self);
//           CreatDos.tag:=1;
//	   CreatDos.showModal;
//      end;
//      end;
// {Parametre de l'entreprise}
//   // A remplir dynamiquement
//   TaIdDos.TableName:='Param_Dossier.DB';
//   TaIdDos.Active:=true;
//   with E do begin
//      {Monnaie:= 'Fr';}
//      ExerciceSaisie:= '98';
//      ExerciceBase:= '98';
//      Regime:= 'A';
//      Devise:= DeviseFranc;
//      ArrondiCredit:= '758';
//      ArrondiDebit:= '658';
//      DatExoDebut:= StrToDate('01/01/1998');
//      DatExoFin:= StrToDate('31/12/1998');
//   end;
//   with E do begin
//      {Monnaie:= 'Fr';}
//      ExerciceSaisie:= TaIdDos.findField('EXO_SAISIE').AsString;
//      ExerciceBase:= TaIdDos.findField('EXO_BASE').AsString;
//      Regime:= TaIdDos.findField('REGIME_Agr').AsString;
//      Devise:= DeviseFranc;
//      ArrondiCredit:= '758';
//      ArrondiDebit:= '658';
//        E.RepertoireExercice :=DirExo;
//      RepertoireDonnees:=DirExo;
//
//      DatExoDebut:= StrToDate(TaIdDos.findField('DATE_DEB_EXO').ASString);
//      DatExoFin:= StrToDate(TaIdDos.findField('DATE_FIN_EXO').ASString);
//   end;
//   TaIdDos.Active:=false;
//   TaIdDos.TableName:='';
////   self.Caption:=' Dossier : Demo   -   Exercice : ExoDemo ';
//   GestDos.Close;
//   GestDos.Open;
//
//if GestDos.RecordCount > 0 then begin
//   if ((DirDos=E.RepertoireProgram + 'Demo') and (DirExo=E.RepertoireProgram + 'Demo\ExoDemo')) then
//   self.Caption:=' Dossier : Demo   -   Exercice : ExoDemo ' else
//   begin
//
//   self.Caption:='Dossier : '+DirDos+ ' - '+ 'Exercice : ' + DirExo;
//   end;
//   end;
if (DMPlan = nil) then DMPlan:=TDMPlan.Create(self);
RxClock1Alarm(RxClock1);
  Main.Menu.Items[0].delete(0);
  Main.Menu.Items[0].Insert(0,NewItem('Nouveau Dossier ...',0,false,true,CreationNewDossierClick,0,'DosCourant'));
//  Main.Menu.Items[0].Delete(Main.Menu.Items[0].Count-1);
//  Main.Menu.Items[0].Delete(Main.Menu.Items[0].Count-1);
  AjoutMenu(Multidossier);
FormateMenuMain;
//ConstruitPopMenu(self.PopupMenu.Items.Count,'Modifier Const Pos',self.PopupMenu.Items,self,DMConst.BtnMAJPosConstClick);

initialisationBirt;

end;

//******************************************************************************
procedure TMain.timHeureTimer(Sender: TObject);
begin
	BasMain.Sections[0].Text:= DateTimeToStr(Now);
//	BasMain.Sections[0].Text:= Copy(DateTimeToStr(Now), 1, 16);
end;

//******************************************************************************
procedure TMain.FormDestroy(Sender: TObject);
Var
//	Registre :TRegistry;
CheminIco:string;
//IntegreHandle:integer;
NomFichier:string;
begin
Initialise_TStringlist(listeCompteValide);
//   IntegreHandle:=FindWindow('TMainILGR','LGRProtect');
//   PostMessage(IntegreHandle,WM_DESTROY,0,0);
//******************************************************************************
// Sauvegarde du dossier en cours
//   if not DirectoryExists(DirDos+'\GrSauvB\') then CreateDir(DirDos+'\GrSauvB\');
//   CopyAllFiles(DirExo+'\*.*',DirDos+'\GrSauvB\',false);
//******************************************************************************

CheminIco:=E.RepertoireProgram+'Favoris Epicea';
   timHeure.Enabled:= False;
if self.WindowState <> wsminimized then LibGestionParamXML.DestroyForm(Self,E.USer);
if not DirectoryExists(CheminIco) then
        ForceDirectories(CheminIco);
CheminIco:=CheminIco+'\';
//DeleteFiles(CheminIco+'*.*');
DestroyListView('\SOFTWARE\LGR\Epicea2\'+E.User+ '\'+ self.Name+ '\',ListeOutils,ImListOutils,CheminIco);
DMXml.SauveUserDef(E.User);
// on sauve les paramètres du dossier en cours
DMProg.SauveGestDossierFichier(E.NomDossier);

/////////////////////////Section d'initialisation avec base de registre/////////////
// PB le 14/09/03
//      Registre:= TRegistry.Create;
//
//      try
//         with Registre do begin
//            RootKey := HKEY_LOCAL_MACHINE;
//            OpenKey('\SOFTWARE\LGR\Epicea2\Defaut\', True);
//            WriteString('LastUser',E.User);
//
//            WriteString('DirDos',E.RepertoireDossier);
//            WriteString('DirExo',E.RepertoireExercice);
//            WriteString('DirImp',E.RepertoireImportEPI_DOS);
//            WriteInteger('IDDOS',E.ID_Dos);
//            WriteInteger('IDExo',E.ID_Exo);
//            WriteString('NomDos',E.NomDossier);
//            WriteString('NomExo',E.NomExo);
//            WriteInteger('TypeDossier',E.TypeVersionToInt(E.TypeDossier));
//            WriteInteger('TypeDossierDemo',E.TypeVersionToInt(E.TypeDossierdemo));
//
//            WriteInteger('OldScH',Screen.Height);
//            WriteInteger('OldScW',Screen.Width);
//
//            CloseKey;
//         end;
//      except
//      end;
//      try
//         with Registre do begin
//            RootKey := HKEY_LOCAL_MACHINE;
//            OpenKey('\SOFTWARE\LGR\Epicea2\'+E.User+ '\' + self.Name, True);
//            WriteString('DirDos',E.RepertoireDossier);
//            WriteString('DirExo',E.RepertoireExercice);
//            WriteInteger('IDDOS',E.ID_Dos);
//            WriteInteger('IDExo',E.ID_Exo);
//            WriteString('NomDos',E.NomDossier);
//            WriteString('NomExo',E.NomExo);
//            WriteInteger('TypeDossier',E.TypeVersionToInt(E.TypeDossier));
//            WriteInteger('TypeDossierDemo',E.TypeVersionToInt(E.TypeDossierdemo));
////            WriteString('DirDos',DirDos);
////            WriteString('DirExo',DirExo);
////            WriteString('ID',IdDosExo);
////            WriteString('IDDos',IdDos);
//            Writebool('AfficheTitre',AfficheTitre);
//            Writebool('Mono',Monofenetrage);
//
//            Writebool('IcoMenuDemarrer',ParamUtil.IcoMenuDemarrer);
//            Writebool('IcoMenuProgramme',ParamUtil.IcoMenuProgramme);
//            Writebool('IcoBureau',ParamUtil.IcoBureau);
//            Writebool('AssistantAffichageAuto',ParamUtil.AssistantAffichageAuto);
//            WriteInteger('AssistantDelaiAffichage',ParamUtil.AssistantDelaiAffichage);
//            CloseKey;
//         end;
//      finally
//         Registre.Free;
////         E.Destroy;
//      end;
/////////////////////////Fin Section d'initialisation avec base de registre/////////////
// PB le 14/09/03


// C'est peut être inutile !!!!
//// A sauver dans la section Programme
//DMXml.ModifieItemProgramme('DirDos',E.RepertoireDossier);
//DMXml.ModifieItemProgramme('DirExo',E.RepertoireExercice);
//DMXml.ModifieItemProgramme('DirImp',E.RepertoireImportEPI_DOS);
//DMXml.ModifieItemProgramme('IDDOS',IntToStr(E.ID_Dos));
//DMXml.ModifieItemProgramme('IDExo',IntToStr(E.ID_Exo));
//DMXml.ModifieItemProgramme('NomDos',E.NomDossier);
//DMXml.ModifieItemProgramme('NomExo',E.NomExo);
//DMXml.ModifieItemProgramme('TypeDossier',IntToStr(E.TypeVersionToInt(E.TypeDossier)));
//DMXml.ModifieItemProgramme('TypeDossierDemo',IntToStr(E.TypeVersionToInt(E.TypeDossierdemo)));

//DMXml.ModifieVarEcran(E.User,self.Name,'DirDos',E.RepertoireDossier);
//DMXml.ModifieVarEcran(E.User,self.Name,'DirExo',E.RepertoireExercice);
//DMXml.ModifieVarEcran(E.User,self.Name,'DirImp',E.RepertoireImportEPI_DOS);
//DMXml.ModifieVarEcran(E.User,self.Name,'IDDos',IntToStr(E.ID_Dos));
//DMXml.ModifieVarEcran(E.User,self.Name,'IDExo',IntToStr(E.ID_Exo));
//DMXml.ModifieVarEcran(E.User,self.Name,'NomExo',E.NomExo);
//DMXml.ModifieVarEcran(E.User,self.Name,'TypeDossier',IntToStr(E.TypeVersionToInt(E.TypeDossier)));
//DMXml.ModifieVarEcran(E.User,self.Name,'TypeDossierDemo',IntToStr(E.TypeVersionToInt(E.TypeDossierdemo)));


// Sauve les paramètres du Dossier en cours
//showmessage('Sauve parametre Dossier');
SauveXMLAvantFermer;
//
// Sauve les paramètres de l'utilisateur en cours dans la section de l'écran Main
//showmessage('Sauve parametre main');
DMXml.ModifieVarEcran(E.User,self.Name,'NomDos',E.NomDossier);
DMXml.ModifieVarEcran(E.User,self.Name,'OldScH',IntToStr(Screen.Height));
DMXml.ModifieVarEcran(E.User,self.Name,'OldScW',IntToStr(Screen.Width));

DMXml.ModifieVarEcran(E.User,self.Name,'AfficheTitre',BoolToStr(AfficheTitre));
DMXml.ModifieVarEcran(E.User,self.Name,'Mono',BoolToStr(Monofenetrage));
DMXml.ModifieVarEcran(E.User,self.Name,'FocusDesactive',BoolToStr(ParamUtil.FocusDesactive));

DMXml.ModifieVarEcran(E.User,self.Name,'IcoMenuDemarrer',BoolToStr(ParamUtil.IcoMenuDemarrer));
DMXml.ModifieVarEcran(E.User,self.Name,'IcoMenuProgramme',BoolToStr(ParamUtil.IcoMenuProgramme));
DMXml.ModifieVarEcran(E.User,self.Name,'IcoBureau',BoolToStr(ParamUtil.IcoBureau));
DMXml.ModifieVarEcran(E.User,self.Name,'AssistantAffichageAuto',BoolToStr(ParamUtil.AssistantAffichageAuto));
DMXml.ModifieVarEcran(E.User,self.Name,'AssistantDelaiAffichage',IntToStr(ParamUtil.AssistantDelaiAffichage));

DMXml.ModifieItemProgramme('MaxDosMenu',IntToStr(ParamUtil.MaxDosMenu));
DMXml.ModifieItemProgramme('Possibilite_Affectation',str_bool2str_LGR(E.Possibilite_Affectation ,'Oui','Non'));
DMXml.ModifieItemProgramme('RemiseAuto',str_bool2str_LGR(E.RemiseAuto ,'Oui','Non'));
DMXml.ModifieItemProgramme('SautDePageAutomatique',str_bool2str_LGR(E.SautDePageAutomatique ,'Oui','Non'));
DMXml.ModifieItemProgramme('AfficheIDPiece',str_bool2str_LGR(ParamUtil.AffichIDPiece,'Oui','Non'));

FermerDossier(E);
//CT_MaxDosMenu
//showmessage('Sauve fichier');
ParamUtil.Free;
DMXml.XMLDocument1.SaveToFile(DMXml.XMLDocument1.FileName);
NomFichier:=ExtractFilePath(Application.ExeName)+C_FileOccupe;

Free_form(-1);
if FileExists(NomFichier) then
    if sysutils.deleteFile(NomFichier) = false
        then showmessage('Impossible de détruire le fichier [Occupe.tmp]');


end;

//******************************************************************************
procedure TMain.FormShow(Sender: TObject);

begin
//GetFirstDayOfMonth(now);
application.onmessage:=ChaqueClic;
Screen.OnActiveControlChange:=ChangementControle;
Application.OnDeactivate := AppDeactivate;
Application.OnActivate := AppActivate;
Screen.OnActiveFormChange:=ChangementForm;


FormateMenuMain;

FormateCaptionMain;
InitGestListMenu(self.Menu.Items);

// Lecture des paramètres sur la ligne de commande
// showmessage('Lecture ParamEnLigne');
ParamEnLigneLec(0);
// declenche la maintenance automatique
//ParamEnLigneLec(2);

//InfoTailleForm(self);

//MessageSilencieux(MessTitre,Mess:string;PanelMessage:TPanel;PaTop,PaWidth,PaLeft,PaHeigth:Integer;Form:TForm);

//MessageSilencieux('Messagerie Epicéa-2','Bienvenue dans Epicéa-2',PaMessageSilencieux,PaOutils.Top,PaOutils.Width-90,PaOutils.Left+90,PaOutils.Height,self);

end;

//******************************************************************************
procedure TMain.mnEntrepriseClick(Sender: TObject);
begin
try//finally
//    GenereDatamodule;
   if (ParamEnt = nil) then ParamEnt:=TParamEnt.Create(self);
   ParamEnt.Tag:=0;
// Application.MainForm.SendToBack;
   ParamEnt.WindowState:=wsNormal;
   GestListForm(ParamEnt.Caption,mnEntreprise);
   if Monofenetrage then
   begin
      ParamEnt.showmodal;
      ParamEnt.Release;
   end
    else
   begin
     ParamEnt.showModal;
     ParamEnt.Release;
   end;
finally
  Initialiser_ShortCut_Main(false);
  FormateCaptionMain;
  FormateMenuMain;
end;
end;

//******************************************************************************
procedure TMain.mnFenetreClick(Sender: TObject);
begin
//
end;

//******************************************************************************
procedure TMain.Balance1Click(Sender: TObject);
begin
if e.AccesOuverture then
  begin
   if (BilanOuverture = nil) then BilanOuverture:=TBilanOuverture.Create(self);
        BilanOuverture.tag:=1;
    if BilanOuverture.Visible then
       begin
         GestListForm(BilanOuverture.Caption,Bilandouverture1);
         BilanOuverture.FormShow(BilanOuverture);
         BilanOuverture.BringToFront;
       end
        else
        begin
         GestListForm(BilanOuverture.Caption,Bilandouverture1);
         BilanOuverture.TitreForm:=(Sender as TMenuItem).Caption;
         BilanOuverture.SousTitreForm:=COuverture;
         AffichageForm(true,BilanOuverture);
        end;
  end
else
  AffichBilanOuvertureSurPeriode;        
Initialiser_ShortCut_Main(false);
//if Monofenetrage then
//           BilanOuverture.showmodal else
//	BilanOuverture.show;
end;

//******************************************************************************
procedure TMain.Button3Click(Sender: TObject);
begin
	if (ChargesAPayer_Isa = nil) then ChargesAPayer_Isa:=TChargesAPayer_Isa.Create(self);
   ChargesAPayer_Isa.Tag:=1;
	ChargesAPayer_Isa.show;
//i:=i+1;
//i:=DlgDirList(main.handle,'a:\*.*',Edit1.handle,ListBox1.handle,DDL_READWRITE);
//MessageBox(0,'Changement de Dossier','Les données de votre dossier en cours ne sont peut-être pas toutes enregistrées. Continuer ?',MB_YESNO + MB_SYSTEMMODAL + MB_ICONQUESTION+MB_DEFBUTTON2);
//  if (ParamProg = nil) then ParamProg:=TParamProg.Create(self);
//   ParamProg.show;
//Button3.Caption:=IntTOStr(i);
end;

//******************************************************************************
procedure TMain.Transfertdefond1Click(Sender: TObject);
begin
//   if (TransFond = nil) then TransFond:=TTransFond.Create(self);
//   GestListForm(TransFond.Caption,Transfertdefond1);
// AffichageForm(Monofenetrage,TransFond);
//   if Monofenetrage then
//       Pointages.showmodal else
//   TransFond.show;
end;

//******************************************************************************
procedure TMain.mnDemoClick(Sender: TObject);
begin
//PatientThAffich(false);

//PatienterAffich(false);
//MessageSilencieux('Messagerie Epicéa-2','Veuillez patienter ...',PaMessageSilencieux,PaOutils.Top,PaOutils.Width-90,PaOutils.Left+90,PaOutils.Height,self);

try
if DetruitTout then
   begin
//    DMBD.CloseAllTAble;
//    OuvreExercice('Demo','ExoDemo');
    case E.TypeDossierdemo of
      VerDemoAgri,VerDemoGeneral:begin
//                   E.TypeDossierdemo:=VerDemoAgri;
                   OuvreExercice(DM_C_NomAliasDemo,DM_C_NomAliasExoDemo,gauge1,false);
//                    DirDos:=E.RepertoireProgram+'Demo';
//                    DirExo:=E.RepertoireProgram+'Demo\ExoDemo';
//                    NomDos:='Demo';
//                    NomExo:='ExoDemo';
//                    E.NomDossier:=NomDos;
//                    E.NomExo:=NomExo;
//                    E.ID_Dos:=0;
//                    E.ID_Exo:=0;
//                    self.Caption:=' Dossier : Demo   -   Exercice : ExoDemo ';
                    FormateCaptionMain;
                    ShowMessage('Vous venez d''activer le dossier :'+RetourChariotDouble+E.NomDossier+RetourChariotDouble+'Exercice : '+RetourChariotDouble+E.NomExo);
                    FormateMenuMain;
                  end;
      VerDemoDioc:begin

//                   E.TypeDossierdemo:=VerDemoDioc;
                   OuvreExercice('DosParoisse','ExoParoisse',gauge1,false);
//                    DirDos:=E.RepertoireProgram+ 'DosParoisse\';
//                    DirExo:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
//                    NomDos:='DosParoisse';
//                    NomExo:='ExoParoisse';
//                    E.NomDossier:=NomDos;
//                    E.NomExo:=NomExo;
//                    E.ID_Dos:=0;
//                    E.ID_Exo:=0;
                    FormateCaptionMain(' -   Version Diocèse');
                    ShowMessage('Vous venez d''activer le dossier :'+RetourChariotDouble+E.NomDossier+RetourChariotDouble+'Exercice : '+RetourChariotDouble+E.NomExo);
                    FormateMenuMain;
                  end;
     VerInconnu:begin
                 FormateMenuMain;
                 abort;
                end;
    end;

//    IdDosExo:='0';
//    IdDos:='0';
//    DMBD.InitBDExercice(DirExo);
//    DMBD.InitBDDossier(DirDos);
//    DMBD.OpenAllTAble;
   end
  else
  begin
   showmessage('Le changement de dossier à été abandonné !'+#10#13+'Le dossier :'+#10#13+E.NomDossier+#10#13#10#13+'Exercice :'+#10#13+E.NomExo+' est toujours actif !');
  end;
except
//PatientThFermer;
//PatienterFermer;
//MessageSilencieuxEfface(PaMessageSilencieux,self,self);
Showmessage('Erreur 10001 lors de l''ouverture du dossier démo');
end;
//MessageSilencieuxEfface(PaMessageSilencieux,self,self);
//PatientThFermer
//PatienterFermer;
end;

//******************************************************************************
procedure TMain.Nouveau1Click(Sender: TObject);
Var
Nom_Dossier:string;
//NomExo:string;
//dateTmp:TDateTime;
InfosGestDossier:TInfosGestDossier;
begin
Nom_Dossier:=(Sender as TMenuItem).Parent.Caption;
try
  if CreationNewExoAffich(Nom_Dossier,InfosGestDossier.Dir_Dossier,InfosGestDossier.DATE_DEB_EXO,InfosGestDossier.DATE_FIN_EXO) then
   Begin
    Main.Menu.Items[0].delete(0);
    Main.Menu.Items[0].Insert(0,NewItem('Nouveau Dossier ...',0,false,true,CreationNewDossierClick,0,'DosCourant'));
    AjoutMenu(Multidossier);
   End
   else
   begin
//    abort;
   end;

except
Showmessage('Erreur 10001 lors de la création du nouvel exercice !');
end;

//Nom_Dossier:=(Sender as TMenuItem).Parent.Caption;
//try
//  FiltrageDataSet(DMRech.TaGestDossierRech,'Nom_Dossier = '''+Nom_Dossier+''' and Cloture = faux ');
//  if DMRech.TaGestDossierRech.RecordCount > 1 then
//   begin
//    MessageDlg('Vous ne pouvez pas créer de nouvel exercice', mtInformation, [mbOK], 0);
//    abort;
//   end;
//  InfosGestDossier:=Infos_TInfosGestDossier(DMRech.TaGestDossierRech,'Nom_Dossier',[Nom_Dossier]);
//  if InfosGestDossier.resultInfos then
//  if CreationNewExoAffich(InfosGestDossier.Nom_Dossier,InfosGestDossier.Dir_Dossier,InfosGestDossier.DATE_DEB_EXO,InfosGestDossier.DATE_FIN_EXO) then
//   Begin
//    Main.Menu.Items[0].delete(0);
//    Main.Menu.Items[0].Insert(0,NewItem('Nouveau Dossier ...',0,false,true,CreationNewDossierClick,0,'DosCourant'));
//    AjoutMenu(Multidossier);
//   End
//   else
//   begin
////    abort;
//   end;
//
//except
//Showmessage('Erreur 10001 lors de la création du nouvel exercice !');
//end;
end;

//******************************************************************************
procedure TMain.Button1Click(Sender: TObject);
//var
//F:TFORM;
//i,j:integer;
//th:integer;
//mes:TMessage;
//key:word;
//ret:TResultPropDate;
//DateAux:TDateTime;
//ObjPrn:TObjetEdition;
//Liste:TStringList;
begin
showmessage(inttostr(str_position_caseInsensitive('Remise','La remise 1')));
//Suppression_Derniere_Declaration_Tva_Deverrouillable('OD0000001',true,false,true,false);
//MaJReportChargeEtProduit(DMRech.TaBalanceRech);
//  showmessage(inttostr(AnsiCompareFileName('RLLL/','rrPO/')));
//  showmessage(inttostr(AnsiCompareFileName(edit1.Text,edit2.Text)));
//AfficheInfosProtect;
//FiltrageDataSet(DMPlan.TaParamCpt,'Regime = ''A'' and Famille = 100');
//Liste:=TStringList.Create;
//Liste:=ChampTableVersListeEx(['ID','Regime','Famille','Rac1','Rac2','Rac3','Rac4','Rac5','Rac6'],DMPlan.TaParamCpt,';',true);
//Liste.SaveToFile(E.RepertoireExport+'\ParamCpt.txt');

//SauveDossier(nil);
//GestSauvegardeAffiche(true,0);
//DMBD.CloseAllTAbleExo('');
//DMBD.CloseAllTAbleDossier('');
//DMProg.SauveGestDossierFichier(E.NomDossier);
//showmessage('bonjour');
//DMProg.LitGestDossierFichier(E.NomDossier);
//FreeAndNil(ListeValeur);
//if ListeValeur = nil then  showmessage('nil')
// else showmessage('no nil');
//for i:=0 to self.f
//ObjPrn:=TObjetEdition.Create(application.MainForm);
//ListeValeur:=TStringList.Create;
//ListeValeur.Add('Col1;Col2;Col3');
//ListeValeur.Add('1.5;2.5;3.4');
//ObjPrn.AffichageImp(ListeValeur);


//Anciennedclaration1Click(Anciennedclaration1);
////AffichAffectImmosCptCOGERE(nil);
//CopierStructure('C:\Projet\Epicea-2\Execution\GestDossier.db','C:\Projet\Epicea-2\Divers\TableTmp\TableGestDossierVide2\GestDossier.db');
//
//SendMail('Test','TestBody','c:\js\TvaCode.DB','toto','legrain','philippeblanc@legrain.fr','legrain@wanadoo.fr');
//if Monofenetrage then
//Form1.show
//else
//Form1.showmodal;
//               if SaisieReglements=nil then
//               SaisieReglements:=TSaisieReglements.Create(self);
//               SaisieReglements.ShowModal;

//AideSelectionImmoEnCours(DMImmo_Clo.TaImmo_Clo);
// if (SelectionLigne = nil) then SelectionLigne:=TSelectionLigne.Create(self);
// SelectionLigne.show;
// if (VisuImmo = nil) then VisuImmo:=TVisuImmo.Create(self);
// VisuImmo.show;

// if (Cloture_Def = nil) then Cloture_Def:=TCloture_Def.Create(self);
// Cloture_Def.show;

// if (DescEmp = nil) then DescEmp:=TDescEmp.Create(self);
// DescEmp.show;


////DAteAux:=CalculDate(now,-1,cdjour,0);
////DAteAux:=jourSuivant(now,1).Date_;
//DAteAux:=jourPrecedent(now,-1).Date_;
//DAteAux:=MoisPrecedent(now,0).Date_;
// if (RepartitionResult = nil) then RepartitionResult:=TRepartitionResult.Create(self);
// RepartitionResult.show;
//if ColorDialog1.Execute then
//   self.ContourCouleur:=ColorDialog1.Color;
//DMPlan.DemandeCreation('512111',nil);
//ret:=DatePropose('3');
//if ret.retour then
//   Button1.Caption:=datetostr(ret.DateValide);
//DMPlan.FiltrageParamCPT(99,'A');
//DMPlan.CompteValideDansParamContexte('102',False,['Rac1']);

//mes.Msg:=WM_LBUTTONDOWN;
//self.MenuMain.Items[0].Items[4].Dispatch(mes);
//self.MenuMain.Items[0].Click;
////self.MenuMain.Dispatch(mes);
//mes.Msg:=WM_LBUTTONUP;
//self.MenuMain.Items[0].Items[4].Dispatch(mes);
//key:=111;
//self.KeyUp(key,[ssalt]);
//self.MenuMain.Dispatch(mes);
//messagebox(0,'eee','rrr',0);
//   if (DescEmp = nil) then DescEmp:=TDescEmp.Create(self);
//	DescEmp.show;
//th:=GetWindowThreadProcessId(i,nil);
//EnumThreadWindows(th,TFormClass,j);
//	Button1.Caption:=IntToStr(j );
//  for I := Application.ComponentCount -1 downto 0 do
//  if Application.Components[I] is TForm then
//    begin
//      F := TForm(Application.Components[I]);
//      if F.Visible then showmessage(F.Name + 'est déjà ouverte') else showmessage('Salut' + F.Name);
//    end

end;

//******************************************************************************
procedure TMain.Emprunts1Click(Sender: TObject);
var
ParamAfficheEmprunts:TParamAfficheEmprunts;
begin

ParamAfficheEmprunts.AffichageModal := Monofenetrage;
ParamAfficheEmprunts.Affiche := true;
ParamAfficheEmprunts.Quand := C_Ouverture;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAfficheEmprunts.TitreForm :=(Sender as TMenuItem).Caption;
ParamAfficheEmprunts.SousTitreForm := COuverture;


EmpruntsAffiche(ParamAfficheEmprunts);
// if (Emprunt_Isa = nil) then Emprunt_Isa:=TEmprunt_Isa.Create(self);
//   Emprunt_Isa.TitreForm:=(Sender as TMenuItem).Caption;
//   Emprunt_Isa.SousTitreForm:=COuverture;
//   GestListForm(Emprunt_Isa.TitreForm+' - '+Emprunt_Isa.SousTitreForm,Emprunts1);
//   AffichageForm(Monofenetrage,Emprunt_Isa);
end;

//******************************************************************************
procedure TMain.PlanComptable1Click(Sender: TObject);
begin
 if (PlanCpt_PM = nil) then PlanCpt_PM:=TPlanCpt_PM.Create(Application);
 if  PlanCpt_PM.WindowState =wsMinimized then
   PlanCpt_PM.WindowState:=wsNormal;
   if (sender as TMenuItem).Parent <> mnAffichage then
     PlanCpt_PM.TitreForm:=(Sender as TMenuItem).Caption
     else
     GestListMenu(mnAffichage);
   PlanCpt_PM.SousTitreForm:=CMethode;
   GestListForm(PlanCpt_PM.TitreForm+' - '+PlanCpt_PM.SousTitreForm,PlanComptable1);
   AffichageForm(Monofenetrage,PlanCpt_PM);
end;

//******************************************************************************
procedure TMain.PlanAuxiliaire1Click(Sender: TObject);
begin
 if (Tiers = nil) then Tiers:=TTiers.Create(self);
 if Tiers.Visible then Tiers.Close;
// Application.CreateForm(TLibClassObjetSender, LibClassObjetSender);
 Tiers.Tag:=1;
 Tiers.BorderStyle:=bsSizeable;
 if (sender as TMenuItem).Parent <> mnAffichage then
     Tiers.TitreForm:=(Sender as TMenuItem).Caption
     else
     GestListMenu(mnAffichage);
 Tiers.SousTitreForm:=CMethode;
 GestListForm(Tiers.TitreForm+' - '+Tiers.SousTitreForm,PlanAuxiliaire1);
 AffichageForm(Monofenetrage,Tiers);

//AideTiersAfficheEnSaisie('+toto');
end;

//******************************************************************************
procedure TMain.Stoks1Click(Sender: TObject);
var
ParamAfficheStock:TParamAffichageStock;
begin

ParamAfficheStock.AffichageModal := Monofenetrage;
ParamAfficheStock.Affiche := true;
ParamAfficheStock.Quand := C_Ouverture;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAfficheStock.TitreForm :=(Sender as TMenuItem).Caption;
ParamAfficheStock.SousTitreForm := COuverture;

StocksAffiche(ParamAfficheStock);
// if (Stocks = nil) then Stocks:=TStocks.Create(self);
// if ((stocks.tag = c_Cloture) and (Stocks.Visible=true)) then Stocks.Close;
// Stocks.tag:=C_Ouverture;
// if (sender as TMenuItem).Parent <> mnAffichage then
//     Stocks.TitreForm:=(Sender as TMenuItem).Caption;
// Stocks.SousTitreForm:=COuverture;
// GestListForm(Stocks.TitreForm+' - '+Stocks.SousTitreForm,Stoks1);
// AffichageForm(Monofenetrage,Stocks);
end;

//******************************************************************************
procedure TMain.DettetCreancesClick(Sender: TObject);
begin
 if (BalanceTiers = nil) then BalanceTiers:=TBalanceTiers.Create(self);
 BalanceTiers.Tag := 1;
// SendToBack;
   GestListForm(BalanceTiers.Caption,DettetCreances);
    AffichageForm(Monofenetrage,BalanceTiers);
//if Monofenetrage then
// BalanceTiers.showmodal else
// BalanceTiers.show;
end;


//******************************************************************************
procedure TMain.CreationNewDossierClick(Sender: TObject);
begin
if not E.Type_Version_Test_Client then
 begin
   if (CreatDos = nil) then CreatDos:=TCreatDos.Create(self);
   CreatDos.showModal;
   mnMethodesClick(mnDossiers);
   FormateMenuMain;
 end
 else
  Showmessage('Vous êtes en version d''évaluation !'+RetourChariotDouble+'Veuillez contacter le SERVICE DE MAINTENANCE de LEGRAIN S.A. pour la création d''un nouveau dossier !');
end;


procedure TMain.Button4Click(Sender: TObject);
//var
//Nom_Dos:string;
//ListeExo:TStringList;
//Rec:TRect;
//key:word;
begin
//   if (AutreDossier = nil) then AutreDossier:=TAutreDossier.Create(self);
//   AutreDossier.show;
//HiliteMenuItem(main.handle,MenuMain.Handle,1,Mf_BYPOSITION+MFS_HILITE);
//GetMenuItemRect(main.handle,mnOuverture.Handle,1,rec);
//Main.MouseDown(mbLeft,[],rec.Left+1,Rec.bottom+1);
//key:=111;
//Main.KeyDown(key,[ssalt])
//Main.Perform(WM_MENUSELECT,mnOuverture.Handle,MF_MOUSESELECT	);
//MenuMain.DispatchCommand(
//Main.GetPopupMenu
//Main.MenuMain.Items.s
//mnOuverture.Click;
//Button4.Caption:=InterBase1.ChampList.Listeorg.Strings[0];
//ListeExo:=TStringList.Create;
//Nom_Dos:=copy(DirDos,LastDelimiter('\',DirDos)+1,length(DirDos));
//ListeExo:=ListeExoDosEnCours(Nom_Dos);
//CreetableMultiExo(Nom_Dos,'ecriture',ListeExo);
//CreetableMultiExo(Nom_Dos,'piece',ListeExo);
//ListeExo.Free;
end;

procedure TMain.FormActivate(Sender: TObject);
const
  Flags: array[TPopupAlignment] of Word = (TPM_LEFTALIGN, TPM_RIGHTALIGN,
    TPM_CENTERALIGN);
var
rec:trect;
key:word;
Point:TPoint;
h:Integer;
b:boolean;
mes:TMessage;
begin
Initialiser_ShortCut_Main(false);
EdDossierTransmis1.Visible:=FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable);
EdDossierTransmis2.Visible:=FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable);
EdExerciceEpure.Visible:=(ExerciceEpure(E.RepertoireExercice));

//Main.PlanComptable1.ShortCut:=ShortCut(VK_F2,[]);
Panel1.Color:=ParamUtil.CouleurDBGrid.GrilleColorFond;
ListMenu.SetFocus;
//ListMenu.Items[0].Focused:=true;
//ListMenu.Items[0].Selected:=true;
self.PopupMenu:=PopupMenu1;
//ListMenu.Focused;
//self.Menu.Items.Count
//PopMenuVersPopUpMenu(mnMethodes,PopupMenu1);
//PopupMenu1.Popup(0,0);
//TPopUpMenu(mnMethodes);
//mnMethodes.sh
// Screen.OnActiveControlChange:=ChangementControle;
//  screen.OnActiveControlChange:=nil;
//  LoadMenu(handle,'mnEntreprise');
//    if SendAppMessage(CM_APPKEYDOWN, CharCode, KeyData) <> 0 then Exit;
//      self.Perform(WM_SYSKEYDOWN,0,29);

//mes.Msg:=WM_LBUTTONDOWN;
//self.MenuMain.Dispatch(mes);
//mes.Msg:=WM_LBUTTONUP;
//self.MenuMain.Dispatch(mes);

//TrackPopupMenu(mnDossiers.Handle,Flags[paLeft] or TPM_RIGHTBUTTON, 0, 10,
//    0 { reserved}, handle, nil);
//PopupMenu1.Popup
//mnDossiers.Items.
//Clotur(1,1);
//Emprunts1.Parent.Click;
//MenuMain.DispatchPopup(mnOuverture.Handle);
{GetMenuItemRect(main.handle,mnOuverture.Handle,1,rec);
Point:=ScreenToClient(rec.BottomRight);
h:=GetsubMenu(mnOuverture.Handle,0);
b:=TrackPopupMenu(h,TPM_RETURNCMD,rec.Left,Rec.Bottom,0,main.handle,nil);}
//mnOuverture.Parent:=main;
//drawmenubar(main.menu.Handle);
//Main.MouseDown(mbLeft,[],rec.Left+1,Rec.bottom+1);
//mnOuverture.Command=
//screen.Active:=Main;
//beep;
//key:=111;
//Menu.DispatchPopup
//Main.KeyDown(key,[ssalt]);
//popupMenu1.Assign(TPersistent(mnOuverture));//:=TPopupMenu(mnOuverture);
//popupmenu1.AutoPopup:=false;
//PopupMenu1.Popup(10,10);
//popupmenu.popup(0,0);

// Version COGERE du 5/11/2002
 VisibleItemMenu([AssistantOuverture1],false);
// Fin version COGERE du 5/11/2002

    if Shape1 <> nil then
    Shape1.Parent:=Panel4
    else
     begin
//       showmessage(' Shape1 est nil !');
       Shape1:=TShape.Create(self);
       Shape1.Parent:=Panel4;
     end;
    if Shape2 <> nil then
    Shape2.Parent:=Panel4
    else
     begin
//       showmessage(' Shape2 est nil !');
       Shape2:=TShape.Create(self);
       Shape2.Parent:=Panel4;
     end;
Panel4Resize(Panel4);
//WebBrowser2.Visible:=false;
end;


procedure TMain.BasMainSectionClick(HeaderControl: THeaderControl;
  Section: THeaderSection);
begin
if section.ID = 0 then
PaDate.Visible:= not PaDate.Visible;
end;

procedure TMain.RxClock1Alarm(Sender: TObject);
var
  Present: TDateTime;
begin
Present:= Now+0.00001;
ShortDateFormat:='dddd d mmmm yyyy';
Panel2.Caption:=datetostr(present);
ShortDateFormat:='dd/mm/yyyy';
end;

procedure TMain.Panel2DblClick(Sender: TObject);
var
  Present,duree: TDateTime;
  Heure,minute,sec,msec:word;
begin
duree:= Now-DebutSession;
Decodetime(duree,Heure,minute,sec,Msec);
case Heure of
   0:case Minute of
           0:ShortDateFormat:='"Début de la session ..."';
           1:ShortDateFormat:='n" minute"';
           2..59:ShortDateFormat:='n" minutes"';
        end;
   1:case Minute of
           0:ShortDateFormat:='h" heure "';
           1:ShortDateFormat:='h" heure "n" minute"';
           2..59:ShortDateFormat:='h" heure "n" minutes"';
        end;

   2..23:case Minute of
           0:ShortDateFormat:='h" heures "';
           1:ShortDateFormat:='h" heures "n" minute"';
           2..59:ShortDateFormat:='h" heures "n" minutes"';
        end;
end;
case Panel2.Tag of
   0:begin
      Panel2.Caption:='Durée de la session : '+ DateToStr(Duree);
      Panel2.Tag:=1;
     end;
   1:begin
      RxClock1Alarm(RxClock1);
      Panel2.Tag:=0;
     end;
end;
ShortDateFormat:='dd/mm/yyyy';
end;

procedure TMain.Panel2Resize(Sender: TObject);
begin
SpeedButton1.top:=1;
SpeedButton1.Left:=1;
SpeedButton1.Width:=Panel2.Width-2;
SpeedButton1.Height:=Panel2.Height-2;

gauge1.top:=Panel2.height-21;
gauge1.Left:=Panel2.Width-(Panel2.Width-(Panel2.Width div 8));
gauge1.Width:=Panel2.Width-(gauge1.Left*2);
gauge1.Height:=20;

end;

procedure TMain.ChargesetProduitsAnneAntrieure1Click(Sender: TObject);
begin
if e.AccesOuverture then
begin
   if (BilanOuverture = nil) then BilanOuverture:=TBilanOuverture.Create(self);
        BilanOuverture.tag:=2;
    if BilanOuverture.Visible then
     begin
        BilanOuverture.RxSpeedButton1.Visible:=false;
	BilanOuverture.FormShow(BilanOuverture);
         GestListForm(BilanOuverture.Caption,ChargesetProduitsAnneAntrieure1);
        BilanOuverture.BringToFront;
     end
        else
        begin
         BilanOuverture.RxSpeedButton1.Visible:=false;
         BilanOuverture.TitreForm:=(Sender as TMenuItem).Caption;
         BilanOuverture.SousTitreForm:=COuverture;
          AffichageForm(true,BilanOuverture);
         GestListForm(BilanOuverture.Caption,ChargesetProduitsAnneAntrieure1);
        end;
end
else
  AffichChargesEtProduitOuvertureSurPeriode;
Initialiser_ShortCut_Main(false);
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
canclose:=DetruitTouteForm([main,Logo]);
end;

procedure TMain.Proprits1Click(Sender: TObject);
begin
 if (PgProperty = nil) then PgProperty:=TPgProperty.Create(self);
// PgProperty.Tag := 1;
if ((sender=GestSauvegarde)or(sender=GestionSauvegarde)) then
  PgProperty.PageControl1.TabIndex:=PgProperty.TabSheet5.PageIndex;
 GestListForm(PgProperty.Caption,Proprits1);
 AffichageForm(Monofenetrage,PgProperty);
//   if Monofenetrage then
//       PgProperty.showmodal else
// PgProperty.show;
end;

procedure TMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//MessageSilencieuxEfface(PaMessageSilencieux,self,self);
if ((Shift = [ssCtrl])and(Key=67)) then
 begin
  E.ControleDuDossier:=false;
  MessageDlg('Contrôle du dossier désactivé !', mtWarning, [mbOK], 0);
 end;

if key=VK_ESCAPE then
 if ListMenu.Tag > 0 then
 TMenuItem(ListMenu.Items[0].SubItems.Objects[0]).Click
 else
    mnQuitterClick(Sender);

//if ssCtrl in (Shift) then
//if key = vk_tab then
//    Begin
//     try
//       if AppliOne= nil then AppliOne:=TAppliOne.Create(Application.MainForm);
//       AppliOne.Show;
//     except
//     if Applione <> nil then
//      AppliOne.Release;
//      AppliOne:=nil;
//      Showmessage('L''assistant n''est pas disponible.');
//     end;
//    End;

//if shift = [ssctrl,ssShift] then
//   if form1.visible then
//    form1.Hide else form1.Show;
end;

Procedure TMain.ChangementControle;
begin
    if screen.ActiveControl <> nil then
     begin
    //     Convertis;
         TiAffichAide.Enabled := False;
    //     TiAffichAide.Enabled := ParamUtil.AssistantAffichageAuto;
         DeltaTime:=Now-DernierAcces;
    //     if  not (GetCaptureControl is TWincontrol) then
         begin
    //      if GetCaptureControl.ClassNameIs('TRxSpeedButton') then
    //         Accueil2.ListeClic.Add((GetCaptureControl.Name)+';'+timeToStr(Accueil2.DeltaTime)+';'+DateTimeToStr(now)+';'+(GetCaptureControl as TRxSpeedButton).Caption)
    //         else
           ListeClic.Add((screen.ActiveControl.Name)+';'+timeToStr(DeltaTime)+';'+DateTimeToStr(now));
         end;
         DernierAcces:=now;
     end;

  try
    WinShape(screen.ActiveControl,Shape1,shape2,ParamUtil.ContourCouleur);
    LastZoneEdit:=screen.ActiveControl;
  except
  on EInvalidOperation do
    ShowMessage('EInvalidOperation');
  on EInvalidPointer do
    ShowMessage('EInvalidPointer');
  on EOutOfResources do
    ShowMessage('EOutOfResources');
   on EInvalidPointer do
   try
       Shape1.Free;
       Shape1:=nil;
       Shape2.Free;
       Shape2:=nil;
       if Shape1=nil then Shape1:=TShape.Create(self);
       if Shape2=nil then Shape2:=TShape.Create(self);
       WinShape(screen.ActiveControl,Shape1,shape2,ParamUtil.ContourCouleur);
       LastZoneEdit:=screen.ActiveControl;
//    end
   except
   on EInvalidPointer do
    begin
      Screen.OnActiveControlChange:=nil;
      Shape1.Free;
      Shape1:=nil;
      Shape2.Free;
      Shape2:=nil;
      abort;
    end;
   end
   else
     begin
      Screen.OnActiveControlChange:=nil;
      //Shape1.Free;
      Shape1:=nil;
      //Shape2.Free;
      Shape2:=nil;
      abort;
     end;
  end;//fin except

end;


procedure TMain.TransfertdeSolde1Click(Sender: TObject);
begin
 if (TranfertSolde = nil) then TranfertSolde:=TTranfertSolde.Create(self);
   GestListForm(TranfertSolde.Caption,TransfertdeSolde1);
 AffichageForm(Monofenetrage,TranfertSolde);
end;

procedure TMain.Changementdexercice1Click(Sender: TObject);
var
ParamAfficheCloture:TParamAfficheCloture;
begin
//ParamAfficheCloture.AffichageModal := Monofenetrage;
ParamAfficheCloture.AffichageModal := true;

ParamAfficheCloture.Affiche := true;
ParamAfficheCloture.TypeAppel := F_ChangtExo;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAfficheCloture.TitreForm :=(Sender as TMenuItem).Caption
else
  ParamAfficheCloture.TitreForm :='Changement d''exercice';
     
ParamAfficheCloture.SousTitreForm := (Sender as TMenuItem).Caption;

ClotureAffiche(ParamAfficheCloture);

// if (Cloture_Def = nil) then Cloture_Def:=TCloture_Def.Create(Application.MainForm);
//   GestListForm('Clôture définitive et changement d''exercice',Changementdexercice1);
//   AffichageForm(Monofenetrage,Cloture_Def);

end;

procedure TMain.InfosVersion1Click(Sender: TObject);
begin
showmessage(numVersion.messageVersion);
end;

procedure TMain.BtnPlanCptClick(Sender: TObject);
begin
PlanComptable1Click(PlanComptable1);
end;

procedure TMain.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnPlanCpt,BtnPlanAux,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],PaBtn,110,0); //le 21/01/2013  ,BtnInserer
BtnPlanCpt.NumGlyphs:=1;

end;

procedure TMain.Agent1Click(Sender: TObject; const CharacterID: WideString;
  Button, Shift, x, y: Smallint);
begin
//Main.Claude.Hide(100);
end;

procedure TMain.Immobilisations1Click(Sender: TObject);
var
ParamAfficheImmo_Ouverture:TParamAfficheImmo_Ouverture;
begin
try
ParamAfficheImmo_Ouverture.TypePresentation:=1;
ParamAfficheImmo_Ouverture.AffichageModal := Monofenetrage;
ParamAfficheImmo_Ouverture.Affiche := true;
ParamAfficheImmo_Ouverture.Quand := C_Ouverture;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAfficheImmo_Ouverture.TitreForm :=(Sender as TMenuItem).Caption;
ParamAfficheImmo_Ouverture.SousTitreForm := COuverture;
ParamAfficheImmo_Ouverture.Compte:='';
ParamAfficheImmo_Ouverture.LibImmo:='';
ParamAfficheImmo_Ouverture.Locate:=false;
ParamAfficheImmo_Ouverture.typeImmos:=C_NonIndique;
AfficheImmo_Ouverture(ParamAfficheImmo_Ouverture);

finally
  E.TypeMAJBalance := MAJ_Normal;
end;//fin du try finally
end;

{$IFDEF Diocese}
procedure TMain.EtatdeVersement1Click(Sender: TObject);
begin
  if DMDiocEtatVersement = nil then DMDiocEtatVersement:=TDMDiocEtatVersement.Create(self);
  if EtatVerse = nil then EtatVerse:=TEtatVerse.Create(self);
   GestListForm(EtatVerse.Caption,EtatdeVersement1);
   AffichageForm(Monofenetrage,EtatVerse);
end;

procedure TMain.Etatdegestionanalytique1Click(Sender: TObject);
begin
if DMDiocEtatGestionAnal = nil then DMDiocEtatGestionAnal:=TDMDiocEtatGestionAnal.Create(self);
if EtatGestAnal = nil then EtatGestAnal:=TEtatGestAnal.Create(self);
 GestListForm(EtatGestAnal.Caption,Etatdegestionanalytique1);
 AffichageForm(Monofenetrage,EtatGestAnal);
end;
{$ENDIF}

procedure TMain.AssistantOuverture1Click(Sender: TObject);
begin
if AssistantOuverture = nil then AssistantOuverture:=TAssistantOuverture.Create(self);
AssistantOuverture.top:=0;
AssistantOuverture.left:=0;
   GestListForm(AssistantOuverture.Caption,AssistantOuverture1);
AssistantOuverture.Show;
end;

procedure TMain.ListMenuKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  TMenuItem(ListMenu.Selected.SubItems.Objects[0]).Click;
end;

procedure TMain.mnMethodesClick(Sender: TObject);
begin
// je l'ai enlevé car sur N+1, le menu n'arrive pas à afficher les sous menus, ça clignotte
//c'est dû au fait que certain menu sont cachés sur N+1 apparemment

//    FormateMenuMain;
    GestListMenu(sender as TMenuItem);
end;

procedure TMain.ListMenuDblClick(Sender: TObject);
begin
//if LibClassObjetSender.MethodAddress('SenderOnClick') <> nil then showmessage('Not nil');
if Main.ListMenu.Selected <> nil then
 begin
  //@TMenuItem(ListMenu.Selected.SubItems.Objects[0]).OnClick:=LibClassObjetSender.MethodAddress('SenderOnClick');
  // Affectation dynamique de la méthode "AssistantOuverture1Click" au click de l'item en cours
//  @TMenuItem(ListMenu.Selected.SubItems.Objects[0]).OnClick:=self.MethodAddress('AssistantOuverture1Click');
  TMenuItem(Main.ListMenu.Selected.SubItems.Objects[0]).Click;
 end
else Main.ListMenu.Selected:=Main.ListMenu.Items.Item[0];

//showmessage('Main');
end;

procedure TMain.MenuPrincipal1Click(Sender: TObject);
begin
InitGestListMenu(sender as TMenuItem);
end;

procedure TMain.ListMenuMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if TListView(Sender).GetItemAt(X,Y) <> nil then
    TListView(Sender).Cursor:=crHandPoint
   else
    TListView(Sender).Cursor:=crDefault;
end;


procedure TMain.Panel4Resize(Sender: TObject);
begin
  if ListMenu.Visible then
  WinShape(ListMenu,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
//  MessageSilencieux('Messagerie Epicéa-2','Bienvenue dans Epicéa-2',PaMessageSilencieux,PaOutils.Top,PaOutils.Width-90,PaOutils.Left+90,PaOutils.Height,self);
end;

//procedure TMain.WMDROPFILES (var Msg: TMessage);
//var
//  i,anzahl,
//  size : integer;
//  k,j:integer;
//  kk:word;
//  Dateiname,NomExe,DateinameBis : PChar;
//  Icone:TIcon;
//  extension,aux,NomRep,NomFic:string;
//  NomProg:PChar;
//  MySLink : IShellLink;
//  MyObject : IUnknown;
//  F:TWin32FindDataA;
//  MaxPAth,Flags:integer;
////  PersistFile : IPersistFile;
// res:array[1..250] of char;
// l:Integer;
//   CheminIco:string;
//begin
//  inherited;
//CheminIco:=E.RepertoireProgram+'Favoris Epicea';
//if not DirectoryExists(CheminIco) then
//        ForceDirectories(CheminIco);
//CheminIco:=CheminIco+'\';
//
//  MyObject := CreateComObject(CLSID_ShellLink);
//  MySLink := MyObject as IShellLink;
//
//  anzahl := DragQueryFile(Msg.WParam, $FFFFFFFF, Dateiname, 255);
////  MySLink.QueryInterface(IPersistFile, PersistFile);
//  aux:='';
//  icone:=TIcon.Create;
// if self.tag=2 then self.tag:=1;
//  for i := 0 to (anzahl - 1) do begin
//    size := DragQueryFile(Msg.WParam, i , nil, 0) + 1;
//    Dateiname:= StrAlloc(size);
//    DragQueryFile(Msg.WParam,i , Dateiname, size);
////    RxSpeedButton1.Caption:=StrPas(Dateiname);
//    extension:=ExtractFileExt(StrPas(Dateiname));
//    if uppercase(extension)='.LNK' then
//      begin
////        PersistFile.Load(PWideChar(Dateiname),Flags);
//        MySLink.setPath(Pchar(Dateiname));
//       icone.Handle:=ExtractAssociatedIcon(hInstance,Dateiname,kk);
//       NomRep:=ExtractFilePath(StrPas(DateIName));
//       NomFic:=extractFilename(StrPas(DateIName));
//       NomFic:=copy(NomFic,1,length(NomFic)-4);
////       ImIco.Picture.Icon:=icone;
//       end
//       else
//    if uppercase(extension)='.EXE' then
//      begin
//       NomRep:=ExtractFilePath(StrPas(DateIName));
//       NomFic:=extractFilename(StrPas(DateIName));
//       NomFic:=copy(NomFic,1,length(NomFic)-4);
//       icone.Handle:=ExtractIcon(hInstance,PChar(Dateiname),0);
////       ImIco.Picture.Icon:=icone;
//     end
//    else
//    begin
//     try
//       NomRep:=ExtractFilePath(StrPas(DateIName));
//       NomFic:=extractFilename(StrPas(DateIName));
// fillchar(res,sizeof(res),' ');
// res[250]:=#13;
// l:=FindExecutable(@NomFic[1],@NomRep[1],@res[1]);
// if l <=32 then
// begin
//  If Application.messagebox(PChar('Ce fichier n''a pas d''application associée'+#10#13+'Voulez-vous en choisir une ?'),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
//        begin
//         ShellExecute(Application.Handle, 'open', PChar('rundll32.exe'),
//         PChar('shell32.dll,OpenAs_RunDLL ' + NomFic), nil,SW_SHOWNORMAL);
//          exit;
//          end
//          else exit;
// end
// else
// begin  If Application.messagebox(PChar('Voulez-vous créer un raccourci vers ce document :'+#10#13+Dateiname+' ?'),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDYES then
//        begin
//          icone.Handle:=ExtractIcon(hInstance,(@res[1]),0);
////          ImIco.Picture.Icon:=icone;
//        end
//        else
//        begin
//          icone.Handle:=ExtractIcon(hInstance,(@res[1]),0);
////          ImIco.Picture.Icon:=icone;
//         DateinameBis:= StrAlloc(size);
//         DateinameBis:=@res;
//         aux:=PChar(DateinameBis);
//         NomFic:=extractFilename(aux);
//         NomFic:=copy(NomFic,1,length(NomFic)-4);
//        end;
// end;
//     except;
//     exit;
//     end;
//    end;
//    if aux='' then
//    aux:=StrPas(Dateiname);
//    ListeOutils.Items.Add.Caption:=NomFic;
//    ImListOutils.AddIcon(Icone);
//    ListeOutils.Items[ListeOutils.Items.Count-1].ImageIndex:=ImListOutils.Count-1;
//    ListeOutils.Items[ListeOutils.Items.Count-1].SubItems.Text:=aux;
////    ListeProg.Append(NomFic);
//    try
//     Icone.SaveToFile(CheminIco+'Icone'+inttostr(ImListOutils.count-1)+'.Ico');
//    except
//     Showmessage('Ce fichier ne peut-être accepté !');
//     icone.Free;
//     DragFinish(Msg.WParam);
//     exit;
//    end;
////
////     if not DirectoryExists(E.RepertoireProgram+RepLogo) then
////        ForceDirectories(E.RepertoireProgram+RepLogo);
////
////     if FileExists(E.RepertoireProgram+RepLogo+'Icone'+inttostr(ListeProg.count-1)+'.Ico') then
////        deleteFile(E.RepertoireProgram+RepLogo+'Icone'+inttostr(ListeProg.count-1)+'.Ico');
////     ListeProg.Delete(ListeProg.Count-1);
////     icone.Free;
////     DragFinish(Msg.WParam);
////     exit;
////    end;
////    ListeIcon.AddObject(E.RepertoireProgram+RepLogo+'Icone'+inttostr(ListeProg.count-1)+'.Ico',Icone);
////    ListeChe.Append(aux);
////    ConstruitPopMenu(ListeProg.count-1,aux,RxPopMain.items);
////    ImIcone.AddIcon(icone);
////    GetIcon((ListeProg.count-1),);
////    AjouteItem(ListeProg.count-1,NomFic);
////    Image3DblClick(Image5);
//  end;
//icone.Free;
//DragFinish(Msg.WParam);
//
//end;

procedure TMain.ListeOutilsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
IndexImage, IndexItem,i:integer;
begin
if key = vk_delete then
 if ListeOutils.Selected <> nil then
  begin
   IndexImage:=ListeOutils.Selected.ImageIndex;
   ImListOutils.Delete(IndexImage);
   IndexItem:=ListeOutils.Selected.Index;
   ListeOutils.Selected.Delete;
   For i:=IndexItem to ListeOutils.Items.Count - 1 do
          ListeOutils.Items[i].ImageIndex:=ListeOutils.Items[i].ImageIndex-1;
   ListeOutils.Refresh;
   ListeOutils.Update;
  end;
end;

procedure TMain.Immos_OuvertureClick(Sender: TObject);
begin
 if (Immo_Ouverture = nil) then Immo_Ouverture:=TImmo_Ouverture.Create(self);
// GestListForm(Immo_Ouverture.Caption,Immos_Ouverture);
// AffichageForm(Monofenetrage,Immo_Ouverture);
 Immo_Ouverture.show;
end;


procedure TMain.mnDescriptionOuvertureClick(Sender: TObject);
begin
  Immobilisations1Click(Immobilisations1);
end;

procedure TMain.mnDescriptionPassageReelClick(Sender: TObject);
begin
 if (Immo_Ouverture = nil) then Immo_Ouverture:=TImmo_Ouverture.Create(self);
 Immo_Ouverture.tag:=2;
//  AffichageForm(Monofenetrage,Immo_Ouverture);
 Immo_Ouverture.show;
end;

procedure TMain.mnChoixAmortisClick(Sender: TObject);
var
ParamAffichageChoixAmortissement:TParamAffichageChoixAmortissement;
begin
try
//  if ChoixAmortissement=nil then
//  ChoixAmortissement:=TChoixAmortissement.Create(self);
////   AffichageForm(Monofenetrage,ChoixAmortissement);
//  ChoixAmortissement.show;
  ParamAffichageChoixAmortissement.AffichageModal := Monofenetrage;
  ParamAffichageChoixAmortissement.Affiche := true;
  ParamAffichageChoixAmortissement.Quand := C_Mouvement;
  ParamAffichageChoixAmortissement.TypePresentation:=0;
  ParamAffichageChoixAmortissement.TitreForm :='Choix des amortissements';
  ParamAffichageChoixAmortissement.SousTitreForm := CMouvement;
  ParamAffichageChoixAmortissement.QuiAppel:=F_ChoixAmortissement;
  ParamAffichageChoixAmortissement.ImmoCourante:=0;
  if not ChoixAmortissementAffiche(ParamAffichageChoixAmortissement) then abort;
except
   abort;
end;
end;

procedure TMain.mnMouvementsClick(Sender: TObject);
var
ParamAfficheImmos:TParamAfficheImmos;
begin
//if VisuImmo=nil then VisuImmo:=TVisuImmo.Create(self);
// GestListForm(VisuImmo.Caption,mnMouvements);
// AffichageForm(Monofenetrage,VisuImmo);                                                    or (e.TypeClient=cl_demo)or(e.TypeClient=CL_Saisie_Demo)
if ((GEstDossierExerciceEnCoursCloturable(E))or(e.ExerciceCloture)or(e.TypeUtilisateur=u_Demo)) then  //23/09/2010
  begin
      ParamAfficheImmos.TypePresentation:=1;
      if sender<>nil then
        begin
          ParamAfficheImmos.AffichageModal := Monofenetrage;
          if (sender as TMenuItem).Parent <> mnAffichage then
               ParamAfficheImmos.TitreForm :=(Sender as TMenuItem).Caption;
        end
      else
        Begin
          ParamAfficheImmos.AffichageModal :=true;
        end;
      ParamAfficheImmos.SousTitreForm := CMouvement;
      ParamAfficheImmos.Affiche := true;
      ParamAfficheImmos.Quand := C_Mouvement;
      ParamAfficheImmos.Compte:='';
      ParamAfficheImmos.LibImmo:='';
      ParamAfficheImmos.Locate:=false;
      ParamAfficheImmos.typeImmos:=C_NonIndique;
      AfficheImmos(ParamAfficheImmos);
  end
else
 begin
  MessageDlg(AccesRefuseExoN1, mtWarning, [mbOK], 0);
 end;

end;

procedure TMain.mnPlanComptesClick(Sender: TObject);
begin
  GestCompteImmosAffiche('');
  Initialiser_ShortCut_Main(false);
end;

procedure TMain.Bureau1Click(Sender: TObject);
begin
  Panel3.Visible:=not Panel3.Visible;
  PaOutils.Visible:= not PaOutils.Visible;
end;

procedure TMain.InformationsParoisse1Click(Sender: TObject);
begin
 if (ParamParoisse = nil) then ParamParoisse:=TParamParoisse.Create(self);
   GestListForm(ParamParoisse.Caption,InformationsParoisse1);
   AffichageForm(Monofenetrage,ParamParoisse);
end;

procedure TMain.ListMenuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//if key = vk_right then
//  if ListMenu.Selected.Index = 0 then ListMenu.Items[1].Selected:=true;
//  ListMenu.Selected:=1;

end;

procedure TMain.BalanceTiers1Click(Sender: TObject);
begin
 if (BalancenewT = nil) then BalancenewT:=TBalancenewT.Create(Application.MainForm);
 if ((sender <>nil)and((sender as TMenuItem).Parent <> mnAffichage)) then
 BalancenewT.TitreForm:=(sender as TMenuItem).Caption
 else
 GestListMenu(mnAffichage);
 BalancenewT.SousTitreForm:=CMouvement;
 GestListForm(BalancenewT.Caption,BalanceTiers1);
 AffichageForm(Monofenetrage,BalancenewT);

end;

procedure TMain.ImHelpClick(Sender: TObject);
var
//tt:^Pointer;
//detailDate:TDetailDate;
//i:integer;
i:double;
MessageLGR:TMessageLGR;
Messa : TMsg;
HandleE2Main:Integer;
begin

// HandleE2Main:=FindWindow('TMainILGR','LGRProtect');
// self.caption:=IntToStr(HandleE2Main);
// setForeGroundWindow(HandleE2Main);

//Messa.message :=WM_PROTECTMESSAGE;
//DispatchMessage(Messa);
//PostMessage(HandleE2Main,WM_PROTECTMESSAGE,Handle,0);
//SendNotifyMessageA(Application.handle,WM_PROTECTMESSAGE,0,0);  
//ImageFormEnBitMap(self);

//DMImport.Import_E2FAC(nil,false);

//if ParamUtil.maintenance then
//   winexec(PChar('NotePad.exe '+E.RepertoireProgram+'error.txt'),SW_SHOW);


//  MessageSilencieux('Messagerie Epicéa-2','Bienvenue dans Epicéa-2',Main.PaMessageSilencieux,0,self.Width,self.Left,80,self);

//if VisuEditFisc = nil then VisuEditFisc:=TVisuEditFisc.Create(Application.MainForm);
//VisuEditFisc.show;


//if EditionFin = nil then EditionFin:=TEditionFin.Create(Application.MainForm);
//EditionFin.show;

//if FBilanActif = nil then FBilanActif:=TFBilanActif.Create(Application.MainForm);
//FBilanActif.Preview;


// if (GestionAnalytique = nil) then GestionAnalytique:=TGestionAnalytique.Create(Application.MainForm);
// GestionAnalytique.show;


//ChoixPeriodeAffich(E.DatExoDebut,E.DatExoFin);
//ChoixPeriodeAffich(0,0);
// if (ChoixReglementAuto = nil) then ChoixReglementAuto:=TChoixReglementAuto.Create(Application.MainForm);
//   GestListForm(ChoixReglementAuto.Caption,Recherche1);
// AffichageForm(Monofenetrage,ChoixReglementAuto);

//i:=12 / 90;
//i:=45600*i;
//showmessage('');
//TDetailDate[0].
//tt:=@detailDate;
//detailDate.
//i:=high(tt);
//tt
//TdetailDate(tt).
//TDetailDate(tt);
//tt:=TypeInfo(TDetailDate);
//if @@tt = @detaildate then showmessage('');


//tt[0].
//showmessage(ImportDll.dateInfos1(now));

//showmessage(libdates.dateInfos(now).DateStr);
//DateValide('1/6');
end;

procedure TMain.AffichInfoComposant1Click(Sender: TObject);
begin
AfficheInfoComposantform(ParamUtil.maintenance,ParamUtil.TypeMaintenance);

//AfficheInfoComposantInput;
end;

procedure TMain.VideTAble1Click(Sender: TObject);
begin
  InitDataBase(DMBD.dbNameProg,DMBD.dbNameDossier,DMBD.dbNameExo,true);
end;

procedure TMain.FormDeactivate(Sender: TObject);
begin
  Main.PlanComptable1.ShortCut:=0;
  
end;

procedure TMain.Recherche1Click(Sender: TObject);
begin
 if (RechercheBD = nil) then RechercheBD:=TRechercheBD.Create(Application.MainForm);
   GestListForm(RechercheBD.Caption,Recherche1);
 AffichageForm(Monofenetrage,RechercheBD);

end;

procedure TMain.Genererlapiece1Click(Sender: TObject);
var
erreur:TerreurCloture;
reference:string;
Begin
  try
//     erreur:=DMImmo_Clo.VerifGestionImmo_AvantCloture(e.DatExoDebut,e.DatExoFin);
//     if ((erreur.erreur.retour)or(not (erreur.erreur.codeErreur in [1,2]))) then
//       begin

     if DMImmo_Clo = nil then DMImmo_Clo:=TDMImmo_Clo.Create(Application.MainForm);
     //création de la pièce de dotation
     DMImmo_Clo.GenererPieceDotation(reference);

   if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
     if (Cloture_Def.EtapeSuivante>=7 )then
       Cloture_Def.EtapeSuivante:=6;{ isa  le  16/09/03 }
  finally
      TableGereCommit(DMPieces.TaPiece);
      TableGereCommit(DMBalance.TaBalance);
      Initialiser_ShortCut_Main(false);
  end;
end;

procedure TMain.Supprimerlapiece1Click(Sender: TObject);
var
reference:string;
begin
try
  try
    DMImmo_Clo.SuppressionPieceDeDotationAmortissement(reference);
     if ((Cloture_Def<>nil)and(Cloture_Def.EtapeSuivante>=7 ))then
//    if Cloture_Def.EtapeSuivante>=7 then
      Cloture_Def.EtapeSuivante:=6;{ isa  le  16/09/03 }
  except
    //
  end;
finally
 Initialiser_ShortCut_Main(false);
end;
end;

procedure TMain.Visualiserlapiece1Click(Sender: TObject);
var
ListOD:TStringList;
reference:string;
begin
  Initialiser_ShortCut_Main(true);
  try
     try
     ListOD:=TStringList.Create;
     if VerificationSiPieceDeDotation(reference) then
       begin
         listod.Add(reference);
         DMPieces.AffichageFeuilleReprise(0,ListOd,nil,'Affichage de la pièce de dotation aux amortissements','','',false);
       end;
     except
        abort;
     end;//fin du try except
  finally
      Initialiser_ShortCut_Main(false);
  end;//fin du try finally
end;

procedure TMain.PaTitreMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    ReLeaseCapture;
    PaMessageSilencieux.perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TMain.PaMessageSilencieuxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if X = (PaMessageSilencieux.Width-5) then
 PaMessageSilencieux.Cursor:=crSizeWE
 else
if Y = (PaMessageSilencieux.Height-5) then
 PaMessageSilencieux.Cursor:=crSizeNS;

if ssLeft in shift  then

case PaMessageSilencieux.Cursor of
   crSizeWE:if X > (PaMessageSilencieux.Width) then
              PaMessageSilencieux.Width:=X
              else
               if X > 30 then
               PaMessageSilencieux.Width:=X;

   crSizeNS:if Y > (PaMessageSilencieux.Height) then
              PaMessageSilencieux.Height:=Y
              else
               if Y > (PaTitre.Height+3) then
               PaMessageSilencieux.Height:=Y;
end;
//PaMessageSilencieux.Cursor:=crDefault;
PaMessage.Caption:='';
end;

procedure TMain.PaTitreDblClick(Sender: TObject);
begin
if PaMessageSilencieux.Height <= PaTitre.Height+7 then PaMessageSilencieux.Height:=100
 else
PaMessageSilencieux.Height:=PaTitre.Height+7;
PaMessage.Caption:='';

end;

procedure TMain.RxRichEdit1URLClick(Sender: TObject; const URLText: String;
  Button: TMouseButton);
var
adresse : array [0..255] of Char ;
MailTo:string;
begin
StrPCopy(adresse,'http:'+ URLText);
ShellExecute(Handle, 'open', adresse, nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.ShockwaveFlash1FSCommand(Sender: TObject; const command,
  args: WideString);
begin
//showmessage(command);
end;

procedure TMain.Timer1Timer(Sender: TObject);
begin
// if      ShockwaveFlash1.Movie='C:\Philippe\AppliOne\0000000001\pub2.swf' then
// begin
//     ShockwaveFlash1.StopPlay;
//     ShockwaveFlash1.EmbedMovie:=false;
//     ShockwaveFlash1.Movie:='C:\Philippe\AppliOne\0000000001\pub1.swf';
//     ShockwaveFlash1.EmbedMovie:=True;
//     ShockwaveFlash1.Play;
// end
// else
// begin
//     ShockwaveFlash1.StopPlay;
//     ShockwaveFlash1.EmbedMovie:=false;
//     ShockwaveFlash1.Movie:='C:\Philippe\AppliOne\0000000001\pub2.swf';
//     ShockwaveFlash1.EmbedMovie:=True;
//     ShockwaveFlash1.Play;
// end;

end;

//procedure TMain.Initialiser_ShortCut_Main(Init_A_Zero:boolean);
//Begin
//if Main<>nil then
// begin
//  if Init_A_Zero then
//    Begin
//      PlanComptable1.ShortCut:=0;
//      PlanAuxiliaire1.ShortCut:=0;
//      AssistantOuverture1.ShortCut:=0;
//      mnSaisiePiece.ShortCut:=0;
//      Pointages1.ShortCut:=0;
//      Balance2.ShortCut:=0;
//      Edition1.ShortCut:=0;
//      StoksdeFin1.ShortCut:=0;
//    End
//  else
//    Begin
//      PlanComptable1.ShortCut:=ShortCut(VK_F2,[]);
//      PlanAuxiliaire1.ShortCut:=ShortCut(VK_F3,[]);
//      AssistantOuverture1.ShortCut:=ShortCut(VK_F4,[]);
//      mnSaisiePiece.ShortCut:=ShortCut(VK_F6,[]);
//      Pointages1.ShortCut:=ShortCut(VK_F5,[]);
//      Balance2.ShortCut:=ShortCut(VK_F8,[]);
//      Edition1.ShortCut:=ShortCut(VK_F11,[]);
//      StoksdeFin1.ShortCut:=ShortCut(VK_F12,[]);
//    End;
// end;//si main créé
//End;

procedure TMain.Analytique1Click(Sender: TObject);
var
Equilibre:TErreurSaisie;
begin
Equilibre:=DMBalance.VerifEquilibreBalanceN;
if Equilibre.retour=false then
  Begin
      if Equilibre.CodeErreur=7001 then
        Begin
          //     GestionGauge(10,gauge1,40,0);
             DMcorrection.CorrectionDeLaBalance(true,false);
        //     GestionGauge(10);
             DMcorrection.CorrectionDeLaBalanceDesTiers(true,false);
        //     GestionGauge(10);
             DMcorrection.CorrectionDeLaBalanceDesMouvements(true,false);
        //     GestionGauge(10);
        //     GestionGauge(0,gauge1,0,0,false);
            if DMBalance.VerifEquilibreBalanceN.retour=false then
                begin
                  if Application.MessageBox(Pchar('Votre balance est déséquilibrée.'+Retourchariotsimple+'Voulez_vous vraiment ouvrir la gestion de l''analytique ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                    abort;
                end;
        end
      else
              if Application.MessageBox(Pchar('Votre balance est déséquilibrée.'+Retourchariotsimple+'Voulez_vous vraiment ouvrir la gestion de l''analytique ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                abort;
  end;
  
if uppercase(E.NomDossier) <> uppercase('Demo') then
 begin
//  if GEstDossierExerciceEnCoursCloturable(E) then                 or (e.TypeClient=cl_demo)or(e.TypeClient=CL_Saisie_Demo)
  if ((GEstDossierExerciceEnCoursCloturable(E))or(e.ExerciceCloture)or(e.TypeUtilisateur=u_Demo)) then //23/09/2010
   begin
     if (GestionAnalytique = nil) then GestionAnalytique:=TGestionAnalytique.Create(Application.MainForm);
       GestListForm(GestionAnalytique.Caption,Analytique1);
     AffichageForm(Monofenetrage,GestionAnalytique);
   end
   else
   begin
    MessageDlg(AccesRefuseExoN1, mtWarning, [mbOK], 0);
   end;
 end
else
 begin
   if (GestionAnalytique = nil) then GestionAnalytique:=TGestionAnalytique.Create(Application.MainForm);
     GestListForm(GestionAnalytique.Caption,Analytique1);
   AffichageForm(Monofenetrage,GestionAnalytique);
 end;
end;

procedure TMain.EditionFin1Click(Sender: TObject);
var
Equilibre:TErreurSaisie;
begin
Equilibre:=DMBalance.VerifEquilibreBalanceN;
if Equilibre.retour=false then
  Begin
      if Equilibre.CodeErreur=7001 then
        Begin
          //     GestionGauge(10,gauge1,40,0);
             DMcorrection.CorrectionDeLaBalance(true,false);
        //     GestionGauge(10);
             DMcorrection.CorrectionDeLaBalanceDesTiers(true,false);
        //     GestionGauge(10);
             DMcorrection.CorrectionDeLaBalanceDesMouvements(true,false);
        //     GestionGauge(10);
        //     GestionGauge(0,gauge1,0,0,false);
            if DMBalance.VerifEquilibreBalanceN.retour=false then
                begin
                  if Application.MessageBox(Pchar('Votre balance est déséquilibrée.'+Retourchariotsimple+'Voulez_vous vraiment ouvrir la gestion des résultats ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                    abort;
                end;
        end
      else
              if Application.MessageBox(Pchar('Votre balance est déséquilibrée.'+Retourchariotsimple+'Voulez_vous vraiment ouvrir la gestion des résultats ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                abort;
  end;


if E.Regime='A' then
  begin
    if EditionFin = nil then EditionFin:=TEditionFin.Create(Application.MainForm);
    EditionFin.show;
  end
else
  begin
//    if ((Type_version_execution=ct_distribution)and(e.TypeClient<>cl_isa)) then
//    MessageDlg(AccesProcedureRefuse_General, mtInformation, [mbOK], 0)
//  else
//    Begin
        if EditionFin_Bic = nil then EditionFin_Bic:=TEditionFin_Bic.Create(Application.MainForm);
          EditionFin_Bic.show;
//    end;
  end
end;

procedure TMain.BtnSaisiePieceClick(Sender: TObject);
begin
mnSaisiePiece.Click;
end;

procedure TMain.BtnPointagesClick(Sender: TObject);
begin
btPointageClick(Pointages1);
end;

procedure TMain.BtnPlanAuxClick(Sender: TObject);
begin
PlanAuxiliaire1Click(PlanAuxiliaire1);
end;

procedure TMain.BtnBalanceClick(Sender: TObject);
begin
Balance2.Click;
end;

procedure TMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
Point:TPoint;
begin
Point.x:=X;
Point.y:=Y;
PaTitreMenu.Caption:=GetCaptionSousSouris(Point);
end;

Procedure TMain.OnException(Sender : TObject; E:Exception);
var
w:word;
NomCtrl,proprietaire:String;
Begin
//Application.ShowException(E);
nomCtrl:='Controle Inconnu';
if Sender is TComponent then
//RecupClassTypeComponent(Sender as TComponent)
 nomCtrl:=(Sender as TComponent).Name;
 proprietaire:=(Sender as TComponent).Owner.Name;
AjouterFichierTexte(E2_Librairie_Obj.E.RepertoireProgram+'Error.txt','Erreur : '+E.Message+#10#13+NomCtrl+#10#13+NomCtrl+#10#13+
Sender.ClassName+#10#13+'Nom Dossier : '+E2_Librairie_Obj.e.NomDossier+#10#13+'Le : '+dateInfos(now).DateStrFormat);
w:=MessageDlg('Erreur : '+E.Message+#10#13+NomCtrl+#10#13+proprietaire+#10#13+Sender.ClassName+#10#13+'Nom Dossier : '+
E2_Librairie_Obj.e.NomDossier+#10#13+'Le : '+dateInfos(now).DateStrFormat,mtError,[mbok],0);
End;

Procedure TMain.OnShortCut(var Msg:TWMKey;var Handled:Boolean);
Begin
//ajouterfichiertexte(E.RepertoireExportation+'TestTouche.txt',
//                    Inttostr(msg.CharCode)+' '+Inttostr(msg.KeyData)+' '+Inttostr(ShortCut(VK_F1,[ssCtrl]))+' '+str_bool2str_LGR(Handled,'Vrai','Faux'));
//if msg.KeyData = ShortCut(VK_F1,[ssCtrl]) then ;
//if ((msg.CharCode = VK_F1) and (Handled)) then
// begin
//  if AideAssist = nil then
//   AideAssist := TAideAssist.Create(Application.MainForm);
//   AideAssist.show;
// end;
////Handled:= (msg.CharCode = VK_CONTROL);
End;


procedure TMain.Rapprochementbancaire1Click(Sender: TObject);
begin
 if (RappBanc = nil) then RappBanc:=TRappBanc.Create(self);
   GestListForm(RappBanc.Caption,Rapprochementbancaire1);
//   if Immo_Ouverture.Visible then Immo_Ouverture.close;
//   RappBanc.TitreForm:=(Sender as TMenuItem).Caption;
//   RappBanc.SousTitreForm:=COuverture;
   AffichageForm(Monofenetrage,RappBanc);
end;

procedure TMain.TiAffichAideTimer(Sender: TObject);
begin
if AideAssist = nil then
 AideAssist := TAideAssist.Create(Application.MainForm);
 AideAssist.show;
//
end;

procedure TMain.Journaux1Click(Sender: TObject);
begin
 if (CreationJournal = nil) then CreationJournal:=TCreationJournal.Create(self);
   GestListForm(CreationJournal.Caption,Journaux1);
//   if Immo_Ouverture.Visible then Immo_Ouverture.close;
//   RappBanc.TitreForm:=(Sender as TMenuItem).Caption;
//   RappBanc.SousTitreForm:=COuverture;
   AffichageForm(Monofenetrage,CreationJournal);
end;

procedure TMain.RxClock1Click(Sender: TObject);
begin
if RxClock1.ShowMode = scDigital then
RxClock1.ShowMode := scAnalog
else RxClock1.ShowMode :=scDigital;
end;

procedure TMain.Epica2DOS1Click(Sender: TObject);
begin
 if (ConfirmImport = nil) then ConfirmImport:=TConfirmImport.Create(self);
 ConfirmImport.ShowModal;
 Initialiser_ShortCut_Main(false);
end;

procedure TMain.Nouvelledclaration1Click(Sender: TObject);
begin
  SyntheseTVAAffiche;
  Initialiser_ShortCut_Main(false);
end;

procedure TMain.Button7Click(Sender: TObject);
begin
//Free_Form;
end;

procedure TMain.RecalculerAmortissement1Click(Sender: TObject);
begin
try
AppelRecalculGeneralImmos;
////recalculer l'amortissement de toutes les immos existantes
//if DataModuleImmos = nil then DataModuleImmos := TDataModuleImmos.Create(Application.MainForm);
//if DataModuleImmos.RecalculGeneralAmortissement(DataModuleImmos.taDetailImmo,false,e.DatExoDebut,e.DatExoFin) then
//  showmessage('le recalcul est terminé.')
except
//  Messagebox(0,Pchar(ErrInterne+' : Le calcul ne s"est pas déroulé correctement, contactez le service maintenance !'),Pchar(ErrInterne),0);
//  abort;
end;
end;

procedure TMain.mnChangeExerciceClick(Sender: TObject);
begin
try
if Application.MessageBox(Pchar('Confirmer le changement d"exercice ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
  begin
    InitialisationDesImmosApresChangementExercice;
    showmessage('le changement d"exercice est terminé.')
  end;
except
  Messagebox(0,Pchar(ErrInterne+' : Le changement d"exercice ne s"est pas déroulé correctement, contactez le service maintenance !'),Pchar(ErrInterne),0);
  abort;
end;
end;

procedure TMain.Gestiondesemprunts1Click(Sender: TObject);
var
ParamAfficheDescEmprunts:TParamAfficheDescEmprunts;
begin                                                             // or(e.TypeClient=cl_demo)or(e.TypeClient=CL_Saisie_Demo)
  if ((GEstDossierExerciceEnCoursCloturable(E))or(e.ExerciceCloture)or(e.TypeUtilisateur=u_Demo)) then //23/09/2010
  begin
      ParamAfficheDescEmprunts.AffichageModal := Monofenetrage;
      ParamAfficheDescEmprunts.Affiche := true;
      ParamAfficheDescEmprunts.Quand := C_Mouvement;
      if (sender as TMenuItem).Parent <> mnAffichage then
           ParamAfficheDescEmprunts.TitreForm :=(Sender as TMenuItem).Caption;
      ParamAfficheDescEmprunts.SousTitreForm := CMouvement;
      ParamAfficheDescEmprunts.QuiAppel:=F_DescEmp;


      DescEmpruntsAffiche(ParamAfficheDescEmprunts);
  end
else
 begin
  MessageDlg(AccesRefuseExoN1, mtWarning, [mbOK], 0);
 end;

// if (DescEmp = nil) then DescEmp:=TDescEmp.Create(self);
// DescEmp.show;
end;

procedure TMain.AffichInfoObjet1Click(Sender: TObject);
begin
if ParamUtil.maintenance then
 begin
  AfficheInfoObjet('Info Objet',E,true);
  AfficheInfoObjet('Info Objet',ParamUtil,true);
 end;
end;

procedure TMain.Supprimerderniredclaration1Click(Sender: TObject);
begin
  try
    if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',true,true,true,false).retour then
      abort
    else
      begin
        showmessage('La dernière pièce de Tva a bien été supprimée.');
      end;
  except
     //abort;
     //showmessage('Problème rencontré lors de la suppression de la dernière déclaration de TVA');
  end;
end;


procedure TMain.PaBtnClick(Sender: TObject);
//var
//ParamAffichage:TParamAffichage;
//List1:TStringList;
//i:integer;
begin
//DMXml.ExportDossier(E.NomDossier,E.RepertoireComptaWeb);

//DMXml.AjouteDossier('DosTEst','c:\Test');
//DMXml.ModifieVarExo('DosTEst','ExoVar','Var1','ValeurVar1');
////DMXml.ModifieVarEcran('toto','EcranVar','Var2','ValeurVar2');
//
//DMXml.ModifieVarEcran('toto','EcranVar','Var1','ValeurVar1');
//DMXml.ModifieVarEcran('toto','EcranVar','Var2','ValeurVar2');
//DMXml.ModifieVarEcran('toto','EcranVar','Var3','ValeurVar3');
//DMXml.RetourneValItemVarEcran('toto','EcranVar','Var'+inttostr(1));
//DMXml.RetourneValItemVarEcran('toto','EcranVar','Var'+inttostr(2));
//DMXml.RetourneValItemVarEcran('toto','EcranVar','Var'+inttostr(3));
//DMXml.RetourneItemUtilisateur('TEstAjout');
//i:=0;
//DMXml.AjouteUtilisateur('toto');
//DMXml.AjouteEcran('toto',self.Name+inttostr((i+1)));
//DMXml.AjouteEcran('toto',self.Name+inttostr((i+2)));
//DMXml.AjouteEcran('toto',self.Name+inttostr((i+3)));
//DMXml.RetourneItemEcran('toto',self.Name);
//DMXml.AjouteEcran('toto',self.Name);
//DMXml.AjouteUtilisateur('toto');
//DMXml.AjouteEcran('toto',self.Name);

// showmessage(DMXml.ValeuritemEcran('phil','main_phil','left'));
// DMXml.ModifieItemEcran('phil','main_phil','left','120');
//// showmessage(DMXml.ValeuritemEcran('phil','main_phil','left'));
// DMXml.ModifieItemEcran('phil','main_phil','down','110');
// showmessage(DMXml.ValeuritemEcran('phil','main_phil','down'));
//// showmessage(DMXml.ValeuritemEcran('phil','main_phil','right'));

//ShellExecute(Handle, 'open', 'C:\Program Files\WinRAR\WinRAR.exe','-cpSauve Source', nil, SW_SHOWNORMAL);
//ShellExecute(Handle, 'open', 'C:\WINDOWS\Bureau\Sauve Librairies.lnk',nil, nil, SW_SHOWNORMAL);

//List1:=TStringList.Create;
//List1.Add('aaaa1;tttt1;');
//List1.Add('aaaa;tttt;');
//ParamAffichage.AffichModal := true;
//ParamAffichage.Titre:='TestTitre';
//AfficheVisuListView(ParamAffichage,['Colonne1','Col2'],[200,250],[List1],[taleftJustify,taleftJustify],[100..100],[0..1],[0]);
//List1.Free;
end;

Procedure TMain.FormateCaptionMain(FinCaption:String);
var
texte:string;
TexteVersion:string;
Begin
if E.NomDossier = DM_C_NomAliasDemo then
 begin
  LabDossier.Font.Color := clRed;
  LabDossier.Color := clWhite;
 end
 else
  begin
   LabDossier.Font.Color := clWhite;
   LabDossier.Color := PaTitreMenu.Color;
  end;
LabDossier.Caption := 'DOSSIER : '+E.NomDossier+'  ';
if(FileExists(e.RepertoireExercice+'\Epure.txt'))then texte:='- Attention !!! Exercice épuré'
else texte:='';
if(E.TypeClient=CL_Education)then TexteVersion:=' >>  VERSION '+TypeClientToStrLibelle(E.TypeClient)+' : ce programme ne peut-être cédé  >>  ' else  TexteVersion:=' >> VERSION '+TypeClientToStrLibelle(E.TypeClient)+' >> ';
self.Caption:='Dossier : '+ E.RaisonSociale+' >> Code Dossier : [ '+E.NomDossier+ ' ] >> '+ 'Exercice : [ ' + E.NomExo +' ]'+TexteVersion+texte+' - '+FinCaption;
Panel6.Caption:='Début exercice : '+datetostr_lgr(e.DatExoDebut);
Panel7.Caption:='    Fin exercice : '+datetostr_lgr(e.DatExofin);
End;

Procedure TMain.FormateMenuMain;
var
Ecran_A_Verrouiller,
Ecran_A_VerrouilleN1,
Ecran_A_VerrouilleOuverture:Tstringlist;
ExoN1:boolean;
Begin
FormateMenuMain_Revise;
//try//finally
//  ExoN1:=Verif_Si_Ouverture_ExoN1(e.NomDossier,e.NomExo);
////  Rsultats1.visible := FileExists(E.RepertoireProgram+'BILAN');
////  if Rsultats1.Visible then Rsultats1.Visible := (E.TypeDossier <> VerGeneral);
//  Ecran_A_Verrouiller:=DM_C_ListeEcranVerrouilleExoCloture; { isa  le  11/05/04 }
//  Ecran_A_VerrouilleN1:=DM_C_ListeEcranVerrouilleN1;{ isa  le  04/06/04 }
//  Ecran_A_VerrouilleOuverture:=DM_C_ListeEcranVerrouilleOuverture;{ isa  le  04/06/04 }
//                      // Traitement du menu spécifique pour COGERE
//                      VisibleItemMenu([SIEADOS1],((E.TypeClient = CL_Cogere)and(not e.ExerciceCloture)));
//  case E.TypeDossier of
//    // Si type Inconnu, certainement nouveau dossier
//    VerInconnu:Begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
//                                PlanComptable1,PlanAuxiliaire1,CodeTVA1,Journaux1,PlanComptabledebase1],false);
//                EnableRxButton([BtnPlanCpt,BtnPlanAux,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],False);
//                Verifavantcloture1.Visible := False;
//               End;
//    // Dossier de type agricole
//    VerAgricole:begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
//                                PlanComptable1,CodeTVA1,Journaux1,PlanComptabledebase1],true);
//                PlanAuxiliaire1.Enabled:=E.PlanAuxT;
//                EnableRxButton([BtnPlanCpt,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],True);
//                BtnPlanAux.Enabled:=E.PlanAuxT;
//                Verifavantcloture1.Visible := True;
//                end;
//    VerDemoAgri:Begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
//                                PlanComptable1,CodeTVA1,Journaux1,PlanComptabledebase1],true);
//                PlanAuxiliaire1.Enabled:=E.PlanAuxT;
//                EnableRxButton([BtnPlanCpt,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],True);
//                BtnPlanAux.Enabled:=E.PlanAuxT;
//                Changementdexercice1.Enabled :=not E.Type_Version_Test_Client;
//                ImportationOuverture1.Enabled := not E.Type_Version_Test_Client;
//                Changementdexercice1.Enabled := not E.Type_Version_Test_Client;
//                Changementdexercice1.Visible := false;
//                Verifavantcloture1.Visible := false;
//                End;
//    VerAgriClot:Begin
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                Verifavantcloture1.Visible := False;
//                End;
////    // Dossier de type Diocese
////    VerDiocese:begin
////                 EtatdeVersement1.Visible:=true;
////                 Etatdegestionanalytique1.Visible:=true;
////                end;
////    VerDemoDioc:Begin
////                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
////                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
////                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
////                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
////                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
////                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
////                mncloture.Visible:=not ExoN1;
////                 EtatdeVersement1.Visible:=true;
////                 Etatdegestionanalytique1.Visible:=true;
////                 Changementdexercice1.Visible := false;
////                Verifavantcloture1.Visible := False;
////                End;
////    VerDiocClot:Begin
////                 EtatdeVersement1.Visible:=true;
////                 Etatdegestionanalytique1.Visible:=true;
////                End;
//    // Dossier de type Industriel
//    VerGeneral:Begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
//                                PlanComptable1,CodeTVA1,Journaux1,PlanComptabledebase1],true);
//                PlanAuxiliaire1.Enabled:=E.PlanAuxT;
//                EnableRxButton([BtnPlanCpt,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],True);
//                BtnPlanAux.Enabled:=E.PlanAuxT;
//                Verifavantcloture1.Visible := True;
//               end;
//    VerDemoGeneral:Begin
//                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
//                                PlanComptable1,CodeTVA1,Journaux1,PlanComptabledebase1],true);
//                PlanAuxiliaire1.Enabled:=E.PlanAuxT;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                EnableRxButton([BtnPlanCpt,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],True);
//                BtnPlanAux.Enabled:=E.PlanAuxT;
//                Changementdexercice1.Enabled :=not E.Type_Version_Test_Client;
//                ImportationOuverture1.Enabled := not E.Type_Version_Test_Client;
//                Changementdexercice1.Enabled := not E.Type_Version_Test_Client;
//                Changementdexercice1.Visible := false;
//                Verifavantcloture1.Visible := False;
//                   End;
//    VerGeneClot:Begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                Changementdexercice1.Visible := false;
//                Verifavantcloture1.Visible := False;
//                End;
//  end;//fin du case
//  BalanceAvecSeparateur1.Visible:=(E.TypeClient = CL_Cogere)or(e.TypeClient=CL_Saisie_Cogere);
//  BalanceCerfaLiasse1.Visible:=(E.TypeClient = CL_Cogere)or(e.TypeClient=CL_Saisie_Cogere);
//  Liassefiscale2.Visible:=(E.TypeClient = CL_Cogere);
//  Rgnrationdestables1.Visible:=((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
//  Requetesql1.Visible:=((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
//
//  //Traitement pour Client Saisie uniquement
//    if (RepriseStoks1.Visible)then RepriseStoks1.Visible:=(E.TypeClient <> CL_Saisie_Normal)AND(E.TypeClient <> CL_Saisie_Demo)AND(E.TypeClient <> CL_Saisie_Cogere);
//    if (mnGestion.Visible)then mnGestion.Visible:=(E.TypeClient <> CL_Saisie_Normal)AND(E.TypeClient <> CL_Saisie_Demo)AND(E.TypeClient <> CL_Saisie_Cogere);
//    if (mnImmobilisations.Visible)then mnImmobilisations.Visible:=(E.TypeClient <> CL_Saisie_Normal)AND(E.TypeClient <> CL_Saisie_Demo)AND(E.TypeClient <> CL_Saisie_Cogere);
//    if (mnCloture.Visible)then mnCloture.Visible:=(E.TypeClient <> CL_Saisie_Normal)AND(E.TypeClient <> CL_Saisie_Demo)AND(E.TypeClient <> CL_Saisie_Cogere);
//  //fin Traitement pour Client Saisie uniquement
//finally
//end;
End;

Procedure TMain.FormateMenuMain_Revise;
var
MenuTous,
Ecran_A_Verrouiller,
Ecran_A_VerrouilleN1,
Ecran_A_VerrouilleOuverture,
Ecran_A_Verrouille_TypeClient,
//Ecran_A_Verrouille_TypeDossier,
Ecran_A_Verrouille_Toujours:Tstringlist;

Ecran_Autorise_TypeClient1,
Ecran_Autorise_TypeVersion:Tstringlist;
ExoN1:boolean;
Begin
try//finally
  try//except
  ExoN1:=Verif_Si_Ouverture_ExoN1(e.NomDossier,e.NomExo);
  TypeDistribution.TypeDossier:=e.TypeDossier;

  MenuTous:=RecupListeMenuTous;
  Ecran_A_Verrouiller:=RecupListeMenu_Exclusion('EcranVerrouilleExoCloture');
  Ecran_A_VerrouilleN1:=RecupListeMenu_Exclusion('EcranVerrouilleN1');
  Ecran_A_VerrouilleOuverture:=RecupListeMenu_Exclusion('EcranVerrouilleOuverture');
  Ecran_A_Verrouille_TypeClient:=RecupListeExclusionMenu_Type(TypeDistribution);
 // Ecran_A_Verrouille_TypeDossier:=RecupListeExclusionMenu_Type(e.TypeDossierToStr(e.TypeDossier));
  Ecran_A_Verrouille_Toujours:= RecupListeMenu_Exclusion('toujours');
  Ecran_Autorise_TypeClient1:=RecupListeInclusionMenu_Type(TypeDistribution);
  Ecran_Autorise_TypeVersion:=RecupListeInclusion('Maints');


  //on traite tous les menus décris dans la table de gestion des versions
  for iMain:=0 to MenuTous.count-1 do
      VisibleItemMenu([TMenuItem(FindComponent(MenuTous.Strings[iMain]))],true);
  //on traite les toujours invisibles
  for iMain:=0 to Ecran_A_Verrouille_Toujours.count-1 do
      VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouille_Toujours.Strings[iMain]))],false);
  //on traite typeClient menu à verrouiller
  for iMain:=0 to Ecran_A_Verrouille_TypeClient.count-1 do
      VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_A_Verrouille_TypeClient.Strings[iMain]))],false);
//  //on traite typeDossier
//  for iMain:=0 to Ecran_A_Verrouille_TypeDossier.count-1 do
//      VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_A_Verrouille_TypeDossier.Strings[iMain]))],false);
    //on traite typeClient menu autorises
  for iMain:=0 to Ecran_Autorise_TypeClient1.count-1 do
      VisibleItemMenu([TMenuItem(FindComponent(Ecran_Autorise_TypeClient1.Strings[iMain]))],true);

  //on traite les verrouillages autres
  for iMain:=0 to Ecran_A_Verrouiller.count-1 do
      VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
  for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
      VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
  for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
      VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));


//  VisibleItemMenu_SiDejaVisible([SIEADOS1],not e.ExerciceCloture);
//  mncloture.Visible:=not ExoN1;

  case E.TypeDossier of
    // Si type Inconnu, certainement nouveau dossier
    VerInconnu:Begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
                                PlanComptable1,PlanAuxiliaire1,CodeTVA1,Journaux1,PlanComptabledebase1],false);
                EnableRxButton([BtnPlanCpt,BtnPlanAux,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],False);
//                Verifavantcloture1.Visible := False;
               End;
    // Dossier de type agricole
    VerAgricole:begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
                                PlanComptable1,CodeTVA1,Journaux1,PlanComptabledebase1],true);
                PlanAuxiliaire1.Enabled:=E.PlanAuxT;
                EnableRxButton([BtnPlanCpt,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],True);
                BtnPlanAux.Enabled:=E.PlanAuxT;
//                Verifavantcloture1.Visible := True;
                end;
    VerDemoAgri:Begin
 //               for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
                                PlanComptable1,CodeTVA1,Journaux1,PlanComptabledebase1],true);
                PlanAuxiliaire1.Enabled:=E.PlanAuxT;
                EnableRxButton([BtnPlanCpt,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],True);
                BtnPlanAux.Enabled:=E.PlanAuxT;
//                Changementdexercice1.Enabled :=not E.Type_Version_Test_Client;
//                ImportationOuverture1.Enabled := not E.Type_Version_Test_Client;
//                Changementdexercice1.Enabled := not E.Type_Version_Test_Client;
//                Changementdexercice1.Visible := false;
//                Verifavantcloture1.Visible := false;
                End;
    VerAgriClot:Begin
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                Verifavantcloture1.Visible := False;
                End;
//    // Dossier de type Diocese
//    VerDiocese:begin
//                 EtatdeVersement1.Visible:=true;
//                 Etatdegestionanalytique1.Visible:=true;
//                end;
//    VerDemoDioc:Begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                 EtatdeVersement1.Visible:=true;
//                 Etatdegestionanalytique1.Visible:=true;
//                 Changementdexercice1.Visible := false;
//                Verifavantcloture1.Visible := False;
//                End;
//    VerDiocClot:Begin
//                 EtatdeVersement1.Visible:=true;
//                 Etatdegestionanalytique1.Visible:=true;
//                End;
    // Dossier de type Industriel
    VerGeneral:Begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
                                PlanComptable1,CodeTVA1,Journaux1,PlanComptabledebase1],true);
                PlanAuxiliaire1.Enabled:=E.PlanAuxT;
                EnableRxButton([BtnPlanCpt,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],True);
                BtnPlanAux.Enabled:=E.PlanAuxT;
//                Verifavantcloture1.Visible := True;
               end;
    VerDemoGeneral:Begin
                EnableItemMenu([mnOuverture,mnEcritures,Edition2,mnGestion,mnImmobilisations,mnCloture,
                                PlanComptable1,CodeTVA1,Journaux1,PlanComptabledebase1],true);
                PlanAuxiliaire1.Enabled:=E.PlanAuxT;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
                EnableRxButton([BtnPlanCpt,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],True);
                BtnPlanAux.Enabled:=E.PlanAuxT;
////                Changementdexercice1.Enabled :=not E.Type_Version_Test_Client;
////                ImportationOuverture1.Enabled := not E.Type_Version_Test_Client;
////                Changementdexercice1.Enabled := not E.Type_Version_Test_Client;
//                Changementdexercice1.Visible := false;
//                Verifavantcloture1.Visible := False;
                   End;
    VerGeneClot:Begin
//                for iMain:=0 to Ecran_A_Verrouiller.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_Verrouiller.Strings[iMain]))],not E.ExerciceCloture);
//                for iMain:=0 to Ecran_A_VerrouilleN1.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleN1.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)));
//                for iMain:=0 to Ecran_A_VerrouilleOuverture.count-1 do
//                    VisibleItemMenu([TMenuItem(FindComponent(Ecran_A_VerrouilleOuverture.Strings[iMain]))],((not E.ExerciceCloture)and(not ExoN1)and (e.AccesOuverture)));
//                mncloture.Visible:=not ExoN1;
//                EtatdeVersement1.Visible:=false;
//                Etatdegestionanalytique1.Visible:=false;
//                Changementdexercice1.Visible := false;
//                Verifavantcloture1.Visible := False;
                End;
  end;//fin du case
//  BalanceAvecSeparateur1.Visible:=(E.TypeClient = CL_Cogere)or(e.TypeClient=CL_Saisie_Cogere);
//  BalanceCerfaLiasse1.Visible:=(E.TypeClient = CL_Cogere)or(e.TypeClient=CL_Saisie_Cogere);
//  Liassefiscale2.Visible:=(E.TypeClient = CL_Cogere);

    //on traite MaintSpeciale menu autorises
  for iMain:=0 to Ecran_Autorise_TypeVersion.count-1 do
      VisibleItemMenu_SiDejaVisible([TMenuItem(FindComponent(Ecran_Autorise_TypeVersion.Strings[iMain]))],((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')));

//  Rgnrationdestables1.Visible:=((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
//  Requetesql1.Visible:=((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));

//  //Traitement pour Client Saisie uniquement
//    if (RepriseStoks1.Visible)then RepriseStoks1.Visible:=(E.TypeClient <> CL_Saisie_Normal)AND(E.TypeClient <> CL_Saisie_Demo)AND(E.TypeClient <> CL_Saisie_Cogere);
//    if (mnGestion.Visible)then mnGestion.Visible:=(E.TypeClient <> CL_Saisie_Normal)AND(E.TypeClient <> CL_Saisie_Demo)AND(E.TypeClient <> CL_Saisie_Cogere);
//    if (mnImmobilisations.Visible)then mnImmobilisations.Visible:=(E.TypeClient <> CL_Saisie_Normal)AND(E.TypeClient <> CL_Saisie_Demo)AND(E.TypeClient <> CL_Saisie_Cogere);
//    if (mnCloture.Visible)then mnCloture.Visible:=(E.TypeClient <> CL_Saisie_Normal)AND(E.TypeClient <> CL_Saisie_Demo)AND(E.TypeClient <> CL_Saisie_Cogere);
  //fin Traitement pour Client Saisie uniquement
  except
      for imain:=0 to main.MenuMain.Items.Count-1 do
      begin
        main.MenuMain.Items.Items[imain].Visible:=false;
      end;
      EnableRxButton([BtnPlanCpt,BtnPlanAux,BtnPointages,BtnSaisiePiece,BtnFermer,BtnBalance],False);

      Application.MessageBox(Pchar('L''application ne s''est pas ouverte correctement.'+AppelerServiceMaintenance),'Attention',MB_ICONWARNING);
    end;
finally
  //if(e.TypeUtilisateur in [U_Normal,U_SuperComptable,U_LibreService])then
//       main.Edit3.Visible:=true;
end;
End;

procedure TMain.Anciennedclaration1Click(Sender: TObject);
var
ParamHistorique:TParamHistorique;
begin
initialise_Tparamhistorique(ParamHistorique);
ParamHistorique:=AfficheListeHistoriqueDeclarationTVA;
end;

procedure TMain.SimulationVrouillageFin1Click(Sender: TObject);
begin
 if (Test1 = nil) then Test1:=TTest1.Create(self);
 Test1.ShowModal;
end;

procedure TMain.GrandLivredesTiers1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
Filtre:string;
ParamAffichCompte:TParamAffichCompte;
  EventButtonClick:TNotifyEvent;
begin
try
//    requete := TQuery.Create(self);
//    //pour récupérer les types de tiers
//    ListeCpt.Liste:=TStringList.Create;
//    ListeCpt.result:=true;
//    requete.DatabaseName :=DMRech.TaTiersRech.DatabaseName;
//    requete.SQL.Add(' select distinct type,compte from tiers T');
//    requete.Open;
//    requete.First;
//    Filtre:='';
//    listecpt:=ChoixCompteAffich('Sélectionnez les types de tiers ...',requete,['type','compte'],true);
//    if(ListeCpt.Result) and (ListeCpt.Liste.Count>0)then
//      filtre:=' where '+CreeFiltreOU('type',[ListeCpt.Liste]);
//    requete.close;
//    requete.SQL.Clear;
//
//    requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
//    requete.SQL.Add(' select BT.compte,Bt.tiers,T.nom,T.type from BalanceTiers bt');
//    requete.SQL.Add(' join "'+e.RepertoireDossier+'Tiers" T on (T.tiers=Bt.tiers)');
//    requete.SQL.Add(filtre);
//    requete.Open;
//    ListeCpt.Liste:=TStringList.Create;
//    ListeCpt.result:=true;
//    DeFiltrageDataSet(requete);
//
//
//    listecpt:=ChoixCompteAffich('Sélectionnez les tiers...',requete,['Tiers','compte','nom','type'],true);
                        requete := TQuery.Create(self);
                        requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
                        requete.SQL.Add(' select BT.compte,Bt.tiers,T.nom,T.type from BalanceTiers bt');
                        requete.SQL.Add(' join "'+e.RepertoireDossier+'Tiers" T on (T.tiers=Bt.tiers)');

                        requete.Open;
                        ListeCpt.Liste:=TStringList.Create;
                        ListeCpt.result:=true;
                        DeFiltrageDataSet(requete);
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:= 'Sélectionnez les tiers ...';
                  ParamAffichCompte.Tiers:=true;
                  ParamAffichCompte.Dataset:=requete;
                  ParamAffichCompte.sautDePage:=e.SautDePageAutomatique;
                  ParamAffichCompte.titreSautDePage:='Saut de page entre les tiers';

                  EventButtonClick:=LibChoixComptes.BtnSupplTypeTiersClick;
                 ParamAffichCompte.ListeItemAction.AddObject('Sélection des types de tiers', @EventButtonClick);

                  //ParamAffichCompte.EventButtonSupplementClick:=LibChoixComptes.BtnSupplClick;
                  ParamAffichCompte.ListeChamps.Add('Tiers');
                  ParamAffichCompte.ListeChamps.Add('compte');
                  ParamAffichCompte.ListeChamps.Add('nom');
                  ParamAffichCompte.ListeChamps.Add('type');
                        listecpt:=ChoixCompteAffich(ParamAffichCompte);
    if ListeCpt.Result then
      EditionEcritureL(0,C_TypeEditionLigneComplet,true,ListeCpt.Liste,nil,nil,ParamAffichCompte.sautDePage);
finally
    Requete.Close;
    requete.free;
end;
end;

procedure TMain.Journaux2Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
end;

procedure TMain.Journaldespices1Click(Sender: TObject);
var 
etattmp:boolean;
begin
etattmp:=e.PeriodeAutreImpression.Retour;
e.PeriodeAutreImpression.Retour:=false;
EditionDesPiecesL(C_EditionSimple,True,nil,nil); { isa  le  16/02/04 pas fini !!!!}
e.PeriodeAutreImpression.Retour:=etattmp;
end;

//procedure TMain.Plusetmoinsvaluescomptables1Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_MOZiLLA_LOCAL:Begin
//                          EditionPMValuesComptables(C_EditionSimple,nil,nil,site);
//                        End;
//
//    C_IMP_NORMAL:Begin
//                  EditionPMValuesComptablesL(C_EditionSimple,True,nil,nil,'');
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

procedure TMain.PlanComptable1DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
OldPen:TPen;
begin
ACanvas.TextRect(AREct,7,1,(Sender as TMenuItem).Caption);
if Selected then
 begin
  OldPen:=ACanvas.Pen;
  ACanvas.Pen.Color := clRed;
  ACanvas.Brush.Color := $0078DCF5;
  ACanvas.FrameRect(ARect);
  ACanvas.Rectangle(ARect.TopLeft.X+1,ARect.TopLeft.Y+1,ARect.BottomRight.X-1,ARect.BottomRight.Y-1);
  ACanvas.TextRect(AREct,7,1,(Sender as TMenuItem).Caption);
//  ACanvas.Pen :=OldPen;
 end;
end;

//procedure TMain.Plusetmoinsvaluefiscales1Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_MOZiLLA_LOCAL:Begin
//                          EditionPMValuesFiscales(C_EditionSimple,nil,nil,site);
//                        End;
//
//    C_IMP_NORMAL:Begin
//                  EditionPMValuesFiscalesL(C_EditionSimple,True,nil,nil,'');
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

procedure TMain.Dductionpourinvestissements1Click(Sender: TObject);
var
Site:TEditLien;
begin
//EditionDeductionInvestissement(C_EditionSimple,nil,nil,Site)
end;

//procedure TMain.ImportationPice1Click(Sender: TObject);
//var
//ListFic:TStringList;
//begin
//try
//  ListFic:=TStringList.Create;
//  try
//   ListFic.LoadFromFile(E.RepertoireProgram+'FicImport.txt');
//    if ListFic.Count > 0 then
//     begin
//      try
//       while ListFic.Count > 0 do
//        begin
//         try
//         DMImport.Import_Piece_SurType(nil,true,ListFic.Strings[0],C_IMPORT_BLOQUEL);
//         except
//         end;
//         ListFic.Delete(0);
//        end;
//      except
//       showmessage('Erreur lors de l''importation.');
//      end;
//     end
//    else
//      showmessage('Le fichier FicImport.txt est vide.');
//  except
//   showmessage('Erreur lors de l''importation');
//  end;
//finally
// ListFic.Free;
//end;
////DMImport.Import_trame(nil,true,'');
//end;

procedure TMain.MaintenanceSpciale1Click(Sender: TObject);
Var
Qui:String;
begin
if e.TypeClient=cl_isa then Qui := IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82);
 if ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')) then
  begin
   ParamUtil.maintenance := false;
   ParamUtil.TypeMaintenance:='';
   ParamUtil.TypeMaintenanceSpeciale:='';
   FormateCaptionMain;
   //Application.MainForm.caption:='Dossier : '+E.NomDossier+ ' - '+ 'Exercice : ' + E.NomExo;
  end
 else
  begin
   if InputQuery('Activation Maintenance Spéciale','Saisie du Code : ',Qui) then
    begin
     if UpperCase(Qui) = 'LGR' then
      begin // Calcul du Numero à rentrer
       showmessage(IntToStr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82));
      end;
     if UpperCase(Qui) = 'SAUV' then
      begin // Calcul du Numero à rentrer pour désactiver le contrôle des sauvegarde
       showmessage(IntToStr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82+11));
      end;
     if UpperCase(Qui) = 'COGERE' then
      begin //
      if (E.TypeClient = CL_COGERE) then        //or(e.TypeClient=CL_Saisie_Cogere)
       begin
         ParamUtil.maintenance := true;
         ParamUtil.TypeMaintenance:='MaintS';
         ParamUtil.TypeMaintenanceSpeciale:=Qui;
         FormateCaptionMain(' - Vous êtes en version Maintenance ! - Spéciale -');
         //Application.MainForm.caption:=Application.MainForm.caption + ' - Vous êtes en version Maintenance ! - Spéciale -';
       end
      else
       begin
        Showmessage('Vous n''êtes pas en version COGERE');
       end;
      end;
     if ((Qui = IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82))or
        (Qui = IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82+11)))then
      begin //
       ParamUtil.maintenance := true;
       ParamUtil.TypeMaintenance:='MaintS';
       ParamUtil.TypeMaintenanceSpeciale:=Qui;
       FormateCaptionMain( ' - Vous êtes en version Maintenance ! - Spéciale -');
       //Application.MainForm.caption:=Application.MainForm.caption + ' - Vous êtes en version Maintenance ! - Spéciale -';
      end;
    end;
  end;
  FormateMenuMain;
end;

procedure TMain.Priseenmainmaintenance1Click(Sender: TObject);
var
RepertoireLgr:String;
begin
RepertoireLgr:=GetRepertoireLGR;
if RepertoireLgr<>'' then RepertoireLGR:=RepertoireLGR+'Utilitaires'
else
  RepertoireLGR:=IncludeTrailingPathDelimiter(GetSpecialFolderPath(CSIDL_PROGRAM_FILES,false))+'LGR\Utilitaires';
   if ShellExecute(Application.Handle,nil,PChar(RepertoireLGR+'\ShowMyPC.exe'),
             nil,nil,sw_show)>32 then

end;

procedure TMain.EditionBalance1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
requete : TQuery;
ParamAffichCompte:TParamAffichCompte;
begin
try
CoherenceBalance(gauge1);
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.DatabaseName :=DMDiocEtatBal.TaBalanceCalc.DatabaseName;
requete.SQL.Add(' select * from balance b');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = B.compte)');
requete.Open;

InitialiseParamAffichCompte(ParamAffichCompte);
ParamAffichCompte.Regrouper:=8;
ParamAffichCompte.Tiers:=false;
ParamAffichCompte.Dataset:=requete;
ParamAffichCompte.Titre:='Sélectionnez les comptes...';
ParamAffichCompte.ListeChamps.Add('compte');
ParamAffichCompte.ListeChamps.Add('libelle');
ParamAffichCompte.ListeChamps.Add('Collectif');
ParamAffichCompte.ListeChamps.Add('Pointable');

//listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Collectif','Pointable']);
listecpt:=ChoixCompteAffich(ParamAffichCompte);
if ListeCpt.Result then
  begin
    EditionBalanceL(C_EditionSimple,true,listecpt.Liste,nil,ListeCpt.Regrouper);
  end;
finally
  requete.close;
  requete.free;
end;
end;

procedure TMain.EditionBalanceTiers2Click(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
Filtre:string;
ParamAffichCompte:TParamAffichCompte;
  EventButtonClick:TNotifyEvent;
begin
try
    CoherenceBalance(Gauge1);
//    requete := TQuery.Create(self);
//    //pour récupérer les types de tiers
//    ListeCpt.Liste:=TStringList.Create;
//    ListeCpt.result:=true;
//    requete.DatabaseName :=DMRech.TaTiersRech.DatabaseName;
//    requete.SQL.Add(' select distinct type,compte from tiers T');
//    requete.Open;
//    requete.First;
//    Filtre:='';
//    listecpt:=ChoixCompteAffich('Sélectionnez les types de tiers ...',requete,['type','compte'],true);
//    if(ListeCpt.Result) and (ListeCpt.Liste.Count>0)then
//      filtre:=' where '+CreeFiltreOU('type',[ListeCpt.Liste]);
//    requete.close;
//    requete.SQL.Clear;
//
//
//
//    requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
//    requete.SQL.Add(' select BT.compte,Bt.tiers,T.nom,T.type from BalanceTiers bt');
//    requete.SQL.Add(' join "'+e.RepertoireDossier+'Tiers" T on (T.tiers=Bt.tiers)');
//    requete.sql.add(filtre);
//    requete.SQL.Add(' order by BT.compte,BT.tiers ');
//    requete.Open;
//    ListeCpt.Liste:=TStringList.Create;
//    ListeCpt.result:=true;
//    DeFiltrageDataSet(requete);
//    listecpt:=ChoixCompteAffich('Sélectionnez les tiers ...',requete,['Tiers','compte','nom','type'],true);
                        requete := TQuery.Create(self);
                        requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
                        requete.SQL.Add(' select BT.compte,Bt.tiers,T.nom,T.type from BalanceTiers bt');
                        requete.SQL.Add(' join "'+e.RepertoireDossier+'Tiers" T on (T.tiers=Bt.tiers)');

                        requete.Open;
                        ListeCpt.Liste:=TStringList.Create;
                        ListeCpt.result:=true;
                        DeFiltrageDataSet(requete);
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:= 'Sélectionnez les tiers ...';
                  ParamAffichCompte.Tiers:=true;
                  ParamAffichCompte.Dataset:=requete;
                  ParamAffichCompte.sautDePage:=e.SautDePageAutomatique;
                  ParamAffichCompte.titreSautDePage:='Saut de page entre les collectifs';

                  EventButtonClick:=LibChoixComptes.BtnSupplTypeTiersClick;
                 ParamAffichCompte.ListeItemAction.AddObject('Sélection des types de tiers', @EventButtonClick);

                  //ParamAffichCompte.EventButtonSupplementClick:=LibChoixComptes.BtnSupplClick;
                  ParamAffichCompte.ListeChamps.Add('Tiers');
                  ParamAffichCompte.ListeChamps.Add('compte');
                  ParamAffichCompte.ListeChamps.Add('nom');
                  ParamAffichCompte.ListeChamps.Add('type');
                        listecpt:=ChoixCompteAffich(ParamAffichCompte);
if ListeCpt.Result then
  EditionBalanceTiersL(C_EditionSimple,true,listecpt.Liste,nil,ParamAffichCompte.sautDePage);

finally
    Requete.Close;
    requete.free;
end;
end;

procedure TMain.SIEADOS1Click(Sender: TObject);
begin
ConfirmImportCOGEREAffiche;
end;

procedure TMain.VosSuggestionsEMail1Click(Sender: TObject);
begin
 SendMail('Suggestion Epicéa-2',
          'Saisissez ici vos suggestions pour le programme Epicéa-2 Win',
          '',
          E.NomDossier,
          '',
          '',
          'support@legrain.fr');
end;

procedure TMain.Proprits2Click(Sender: TObject);
var
ParamInfosEpicea:TParamInfosEpicea;
ListeModule:TStringList;
begin
if (Sender is TMenuItem) then
 begin
   AfficheInfoObjet('Info dossier',E,true);
 end;
if (Sender is TLabel) then
 begin
    ListeModule:=TStringList.Create;
    ListeModule.Add(C_InfosStocks);
    ListeModule.Add(C_InfosEmprunts);
    ListeModule.Add(C_InfosDossier);
    ParamInfosEpicea.ListeModule := ListeModule;
    AfficheInfosEpicea(ParamInfosEpicea)
 end;
//while (Sender as TMenuItem).Count > 0 do
////(Sender as TMenuItem).Items[0].Delete(0);
//(Sender as TMenuItem).Delete(0);
//
//ConstruitPopMenu(0,'Nom dossier : '+E.NomDossier,(Sender as TMenuItem),self,nil);
//ConstruitPopMenu(1,'Nom exercice : '+E.NomExo,(Sender as TMenuItem),self,nil);
//ConstruitPopMenu(2,'Date de début d''exercice : '+DateInfos(E.DatExoDebut).DateStr,(Sender as TMenuItem),self,nil);
//ConstruitPopMenu(3,'Date de fin d''exercice : '+DateInfos(E.DatExoFin).DateStr,(Sender as TMenuItem),self,nil);

//mnMethodesClick(sender);
//Proprits2
end;

procedure TMain.DettesetCrances1Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
end;

procedure TMain.SlectionJournal1Click(Sender: TObject);
var
Edit:TEdit;
begin
  try
    Edit:=TEdit.Create(nil);
    AideModelAffiche(Edit,nil,false);
  Finally
    if Edit <> nil then Edit.Free;
  end;
end;

procedure TMain.Sauvegarde1Click(Sender: TObject);
begin
 GestSauvegardeAffiche(true,0);
   Initialiser_ShortCut_Main(false);
end;

procedure TMain.Restauration1Click(Sender: TObject);
begin
 ParamUtil.GestionSauvegarde := true;
 GestionSauvegardeAffiche(ParamUtil.GestionSauvegarde,CT_DOSSIER_COURANT);
   Initialiser_ShortCut_Main(false);

end;

procedure TMain.GrandlivredesAteliers1Click(Sender: TObject);
var
ListeAtelier:TResultStrList;
begin
//on traite les ateliers
ListeAtelier.Liste:=TStringList.Create;
ListeAtelier.result:=true;
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.create(application.Mainform);
defiltrageDataset(DMRech.TaTA_ActiviteRech);
DMAnalytiques.ListeActiviteResult:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[DMAnalytiques.ListeActiviteResult]));
DMAnalytiques.ListeAtelierResult.Clear;

ListeAtelier:=ChoixCompteAffich('Sélectionnez les ateliers...',DMRech.TaTA_AtelierRech,['Code_Atelier','libelle_atelier','code_activite'],true);
if ListeAtelier.Result then
  EditionGLivreAnalytiqueAtelierL(C_EditionSimple,TRue,nil,ListeAtelier.Liste,nil);


end;

procedure TMain.BalancedesAtelier1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
begin
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.create(application.Mainform);
defiltrageDataset(DMRech.TaTA_ActiviteRech);
DMAnalytiques.ListeActiviteResult:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[DMAnalytiques.ListeActiviteResult]));
DMAnalytiques.ListeAtelierResult.Clear;

listecpt:=ChoixCompteAffich('Sélectionnez les ateliers...',DMRech.TaTA_AtelierRech,['Code_Atelier','libelle_atelier','code_activite'],true);
if ListeCpt.Result then
  EditionBalanceAnalytiqueAtelierL(C_EditionSimple,TRue,nil,ListeCpt.Liste,nil);
//DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
//EditionBalanceAnalytiqueAtelierL(C_EditionSimple,TRue,DMAnalytiques.ListeAtelierResult,nil);
end;

procedure TMain.ImportTrame1Click(Sender: TObject);
begin
DMImport.Import_Trame(nil,true,'');
end;

procedure TMain.N030920021Click(Sender: TObject);
var
ParamInfosEpicea:TParamInfosEpicea;
ListeModule:TStringList;
ParamRechercheBD:TParamRechercheBD;
begin
  case Type_version_execution of
    CT_DEVELOPPEMENT:Begin
//                      ParamRechercheBD.CompteDep := '145';
//                      ParamRechercheBD.Ouverture := true;
//                      RechercheBDAffiche(ParamRechercheBD);
//                      ListeModule:=TStringList.Create;
//                      ListeModule.Add(C_InfosStocks);
//                      ListeModule.Add(C_InfosEmprunts);
//                      ListeModule.Add(C_InfosDossier);
//                      ParamInfosEpicea.ListeModule := ListeModule;
//                      AfficheInfosEpicea(ParamInfosEpicea)
//                        EgaliteMontant(nil,nil);

                     if AfficheReport('C:\LGRDOSS\EPICEA\DESC\Cloture_Exercice_2004.TXT',
                                      'Rapport de votre clôture',
                                      PChar('Période du '+LibDates.DateInfos(E.DatExoDebut).DateStr+' au '+LibDates.DateInfos(E.DatExoFin).DateStr),
                                      PChar('Dossier : '+E.NomDossier +' - ' +e.RaisonSociale),
                                      600,
                                      800,
                                      1,
                                      1) = mrOk then
                      showmessage('Retour AfficheReport');
                     End;

    CT_DISTRIBUTION:Begin
                     PropertiesDialog(Application.ExeName);
                    End;

  else showmessage('Le type de l''exécutable n''est pas défini !');
  end;

end;

procedure TMain.Choisiruneimprimante1Click(Sender: TObject);
var
Prog:PChar;
begin
Prog:='intl.cpl';
WinExec(PChar('rundll32.exe shell32.dll,'+'Control_RunDLL '+Prog),SW_SHOWNORMAL);
end;

procedure TMain.ImportationE2FAC1Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
end;

procedure TMain.Suppressiondesimmosincorrectes1Click(Sender: TObject);
begin
//
end;

procedure TMain.Typeclient1Click(Sender: TObject);
var
Retour:integer;
valeur:string;
ListetypeClient,ListetypeVersion,ListeTypeUtilisateur:string;
begin
 valeur:=InputBox('Indiquer le mot de passe','','*******');
 if valeur='lepelet' then
// if e.TypeClient=cl_isa then
   begin
//       Type_version_execution
       Retour:=strtoint_lgr(InputBox('Indiquer le Type de Version souhaité','Developpement=1'+RetourChariotSimple+'Distribution=0'+RetourChariotSimple+'Maintenance=2'+RetourChariotSimple+'Changement Type Client=3',inttostr(Type_version_execution)));
       case Retour of
         CT_DISTRIBUTION:begin
         FormateCaptionMain('');
//             Application.MainForm.caption:='Dossier : '+E.NomDossier+ ' - '+ 'Exercice : ' + E.NomExo;
//             Application.MainForm.caption:=Application.MainForm.caption + ' - Vous êtes en version Developpement ! -';
             Type_version_execution:=retour;
         end;
         CT_DEVELOPPEMENT:begin
         FormateCaptionMain(' - Vous êtes en version Developpement ! -');
//             Application.MainForm.caption:='Dossier : '+E.NomDossier+ ' - '+ 'Exercice : ' + E.NomExo;
//             Application.MainForm.caption:=Application.MainForm.caption + ' - Vous êtes en version Developpement ! -';
             Type_version_execution:=retour;
         end;
         2:begin
             ParamUtil.maintenance:=true;
             ParamUtil.TypeMaintenance:='MaintS';
             FormateCaptionMain( ' - Vous êtes en version Maintenance ! - Spéciale -');
//             Application.MainForm.caption:='Dossier : '+E.NomDossier+ ' - '+ 'Exercice : ' + E.NomExo;
//             Application.MainForm.caption:=Application.MainForm.caption + ' - Vous êtes en version Maintenance ! - Spéciale -';
             InitMain(Type_version_execution);
           end;
         3:begin
         Initialise_TDistribution(TypeDistribution);
         TypeDistribution.TypeVersion:=e.TypeVersion;
         TypeDistribution.TypeClient:=e.TypeClient;
         TypeDistribution.TypeUtilisateur:=e.TypeUtilisateur;
         InitListeType(TypeDistribution) ;
//               e.TypeClient:= IntToTypeClient(strtoint_lgr(InputBox('Indiquer le Type de client souhaité',
//               'CL_Cogere=1'+RetourChariotSimple+'CL_Normal=2'+
//               RetourChariotSimple+'CL_Isa=3'
////               +RetourChariotSimple+'CL_Demo=4'+RetourChariotSimple+'CL_Saisie_Normal=5'
////               +RetourChariotSimple+'CL_Saisie_Demo=6'
////               +RetourChariotSimple+'CL_Saisie_Cogere=7'
////               +RetourChariotSimple+'CL_Normal_2=8'
////               +RetourChariotSimple+'CL_Normal_3=9'
//               ,
//               TypeClientToStr(e.TypeClient))));
                 e.TypeVersion:=TypeDistribution.TypeVersion;
                 e.TypeClient:=TypeDistribution.TypeClient;
                 e.TypeUtilisateur:=TypeDistribution.TypeUtilisateur;
               OuvreExercice(e.NomDossier,e.NomExo,Gauge1,false);
               InitMain(Type_version_execution);
           end;
       end;//fin du case
   end;
end;

//procedure TMain.Immobilisations2Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_MOZiLLA_LOCAL:Begin
//                           EditionAcquisitions(C_EditionSimple,nil,nil,Site)
//                        End;
//
//    C_IMP_NORMAL:Begin
//                    EditionDesAcquisitionsL(C_EditionSimple,'2*',True,nil,'Immobilisations');
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

//procedure TMain.Subventions1Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_MOZiLLA_LOCAL:Begin
//                           EditionAcquisitions(C_EditionSimple,nil,nil,Site)
//                        End;
//
//    C_IMP_NORMAL:Begin
//                    EditionDesAcquisitionsL(C_EditionSimple,'131*',True,nil,'Subventions');
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

//procedure TMain.ableaudesacquisitions1Click(Sender: TObject);
//begin
//GestListMenu(sender as TMenuItem);
//FormateMenuMain;
//end;

//procedure TMain.Immobilisations3Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_NORMAL,
//    C_IMP_MOZiLLA_LOCAL:Begin
//                  EditionTableauDesAmortissementL(C_EditionSimple,'2*',True,nil,'Immobilisations',false);
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

//procedure TMain.subventions2Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_NORMAL,
//    C_IMP_MOZiLLA_LOCAL:Begin
//                  EditionTableauDesAmortissementL(C_EditionSimple,'131*',True,nil,'Subventions',true);
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

//procedure TMain.ableaudesamortissements1Click(Sender: TObject);
//begin
//GestListMenu(sender as TMenuItem);
//FormateMenuMain;
//end;

//procedure TMain.Immobilisations4Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_MOZiLLA_LOCAL:Begin
//                          EditionChoixAmortissements(C_EditionSimple,nil,nil,Site)
//                        End;
//
//    C_IMP_NORMAL:Begin
//                  EditionSyntheseDesChoixAmortissementL(C_EditionSimple,'2*',True,nil,'Immobilisations');
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

//procedure TMain.subventions3Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_MOZiLLA_LOCAL:Begin
//                          EditionChoixAmortissements(C_EditionSimple,nil,nil,Site)
//                        End;
//
//    C_IMP_NORMAL:Begin
//                  EditionSyntheseDesChoixAmortissementL(C_EditionSimple,'131*',True,nil,'Subventions');
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

//procedure TMain.Synthesedeschoixdamortissement1Click(Sender: TObject);
//begin
//GestListMenu(sender as TMenuItem);
//FormateMenuMain;
//end;

procedure TMain.Corrections1Click(Sender: TObject);
var
ParamAffichageCorrection:TParamAffichageCorrection;
begin
ParamAffichageCorrection.AffichageModal := Monofenetrage;
ParamAffichageCorrection.Affiche := true;
ParamAffichageCorrection.Quand := C_cloture;
if (sender as TMenuItem).Parent <> mnAffichage then
     ParamAffichageCorrection.TitreForm :=(Sender as TMenuItem).Caption;
ParamAffichageCorrection.SousTitreForm := 'Corrections';

ParamAffichageCorrection.DateDeb:=e.DatExoDebut;
ParamAffichageCorrection.DateFin:=e.DatExoFin;
ParamAffichageCorrection.DemandePeriode:=false;

CorrectionAffiche(ParamAffichageCorrection);
end;

//procedure TMain.Immobilisations5Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_NORMAL,
//    C_IMP_MOZiLLA_LOCAL:Begin
//                  EditionSyntheseTableauDesAmortissementL(C_EditionSimple,'2*',True,nil,'Immobilisations',true);
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

procedure TMain.Synthsedutableaudesamortissments1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
FormateMenuMain;
end;

//procedure TMain.Subventions4Click(Sender: TObject);
//var
//Site:TEditLien;
//begin
//  case E.Type_Edition of
//    C_IMP_NORMAL,
//    C_IMP_MOZiLLA_LOCAL:Begin
//                  EditionSyntheseTableauDesAmortissementL(C_EditionSimple,'131*',True,nil,'Immobilisations',true);
//                 End;
//
//    C_IMP_MOZiLLA_WEB:Begin
//
//                      End;
//
//    else showmessage('Type_Edition non défini');
//  end;
//end;

procedure TMain.Ouverture1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Cloture1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.ableauxdesimmobillisations1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
FormateMenuMain;
end;

procedure TMain.Synthesedutableaudesimmobilisations1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
FormateMenuMain;
end;

procedure TMain.TableauxdesAcquisitionsClick(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.TableauxdesAmortissementsClick(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Synthesedutableauxdesamortissements1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Synthesedeschoixdamortissements1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Immobilisations9Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionDesAcquisitionsL(C_EditionSimple,True,listecpt.Liste,nil,'Immobilisations');
  //EditionDesAcquisitionsL(C_EditionSimple,'2*',True,nil,'Immobilisations');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Subventions7Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''13%'')and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionDesAcquisitionsL(C_EditionSimple,True,listecpt.Liste,nil,'Subventions');
  //EditionDesAcquisitionsL(C_EditionSimple,'131*',True,nil,'Subventions');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Subventions8Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Immobilisations11Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Subventions9Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Immobilisations12Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionSyntheseDesChoixAmortissementL(C_EditionSimple,false,listecpt.Liste,nil,'Immobilisations');
  //EditionSyntheseDesChoixAmortissementL(C_EditionSimple,'2*',false,nil,'Immobilisations');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Subventions10Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''13%'')and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionSyntheseDesChoixAmortissementL(C_EditionSimple,false,listecpt.Liste,nil,'Subventions');
  //EditionSyntheseDesChoixAmortissementL(C_EditionSimple,'131*',false,nil,'Subventions');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Plusetmoinsvaluescomptables2Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.PlusetMoinsvaluesfiscales1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Immobilisations6Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Immobilisations7Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionDesImmosOuvertureL(C_EditionSimple,True,listecpt.Liste,nil,'Immobilisations');
  //EditionDesImmosOuvertureL(C_EditionSimple,'2*',True,nil,'Immobilisations');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Subventions5Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''13%'')and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionDesImmosOuvertureL(C_EditionSimple,True,listecpt.Liste,nil,'Subventions');
  //EditionDesImmosOuvertureL(C_EditionSimple,'131*',True,nil,'Subventions');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Immobilisations8Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionSyntheseDesImmosOuvertureL(C_EditionSimple,True,listecpt.Liste,nil,'Immobilisations');
  //EditionSyntheseDesImmosOuvertureL(C_EditionSimple,'2*',True,nil,'Immobilisations');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Subventions6Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''13%'')and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionSyntheseDesImmosOuvertureL(C_EditionSimple,True,listecpt.Liste,nil,'Subventions');
  //EditionSyntheseDesImmosOuvertureL(C_EditionSimple,'131*',True,nil,'Subventions');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.AvecDrogatoire1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionTableauDesAmortissementL(C_EditionSimple,false,ListeCpt.Liste,nil,'Immobilisations',True);
  //EditionTableauDesAmortissementL(C_EditionSimple,'2*',false,nil,'Immobilisations',True);
finally
   requete.close;
   requete.Free;
end;
end;


procedure TMain.SansDrogatoire1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionTableauDesAmortissementL(C_EditionSimple,false,ListeCpt.Liste,nil,'Immobilisations',false);
  //EditionTableauDesAmortissementL(C_EditionSimple,'2*',false,nil,'Immobilisations',false);
finally
   requete.close;
   requete.Free;
end; 
end;

procedure TMain.AvecDrogatoire2Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''13%'')and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionTableauDesAmortissementL(C_EditionSimple,false,listecpt.Liste,nil,'Subventions',True);
  //EditionTableauDesAmortissementL(C_EditionSimple,'131*',false,nil,'Subventions',True);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.SansDrogatoire2Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''13%'')and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionTableauDesAmortissementL(C_EditionSimple,false,listecpt.Liste,nil,'Subventions',false);
  //EditionTableauDesAmortissementL(C_EditionSimple,'131*',false,nil,'Subventions',false);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Immobilisations10Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Avecdtaildudrogatoire1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionTableauDesAmortissementL(C_EditionSimple,false,listecpt.Liste,nil,'Immobilisations',true,false);
  //EditionTableauDesAmortissementL(C_EditionSimple,'2*',false,nil,'Immobilisations',true,false);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Avecdtaildudrogatoire2Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''13%'')and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionTableauDesAmortissementL(C_EditionSimple,false,listecpt.Liste,nil,'Subventions',true,false);
  //EditionTableauDesAmortissementL(C_EditionSimple,'131*',false,nil,'Subventions',true,false);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Sansdtaildudrogatoire2Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''13%'') and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionTableauDesAmortissementL(C_EditionSimple,false,listecpt.Liste,nil,'Subventions',false,false);
  //EditionTableauDesAmortissementL(C_EditionSimple,'131*',false,nil,'Subventions',false,false);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Sansdtaildudrogatoire1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionTableauDesAmortissementL(C_EditionSimple,false,listecpt.Liste,nil,'Immobilisations',false,false);
  //EditionTableauDesAmortissementL(C_EditionSimple,'2*',false,nil,'Immobilisations',false,false);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.ableauMensueldeTresorerie1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
FormateMenuMain;
end;

procedure TMain.Emprunts2Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
//FormateMenuMain;
end;

procedure TMain.Mouvementdelexercice1Click(Sender: TObject);
begin
EditionEmpruntMouvExerciceL(C_EditionSimple,True,nil,nil);

end;

procedure TMain.Rpartitiondesannuits1Click(Sender: TObject);
begin
EditionEmpruntRepartitionL(C_EditionSimple,True,nil,nil);
end;

procedure TMain.ableauprvisionnel1Click(Sender: TObject);
begin
EditionEmpruntPrevisionnelL(C_EditionSimple,True,nil,nil);
end;

procedure TMain.CrationDuFichierAffichResult1Click(Sender: TObject);
begin
AjouterFichierTexte(E.RepertoireProgram+'BILAN',DateToStr(now));
InitMain(Type_version_execution);
end;

procedure TMain.Historique1Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar(E.RepertoireProgram+'error.txt'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.Decimal1Click(Sender: TObject);
begin
//GetCurrencyFormat(LOCALE_USER_DEFAULT,0,'.',)
end;

procedure TMain.MultiDossier1Click(Sender: TObject);
var
ParamAfficheAutreDossier:TParamAfficheAutreDossier;
begin
if(Multidossier)then
  begin
     ParamAfficheAutreDossier.Tag:=0;
     ParamAfficheAutreDossier.SaisieNomDossier:=true;
     GestListForm('Autres dossiers',MultiDossier1);
      if (AutreDossier = nil) then AutreDossier:=TAutreDossier.Create(self);
      AutreDossierAffiche(ParamAfficheAutreDossier);
  end;
end;

procedure TMain.Aide1Click(Sender: TObject);
var
ShiftState:TShiftState;
key:Integer;
Str:WideString;
begin
//ShiftState:=[ssCtrl];
//key:=VK_F1;
////ShortCut(VK_F1,[ssCtrl])
//Application.IsShortCut(VK_F1,
//           (ShiftState),Str);
end;

procedure TMain.Verifavantcloture1Click(Sender: TObject);
var
ParamAfficheCloture:TParamAfficheCloture;
begin
ParamAfficheCloture.AffichageModal := Monofenetrage;

ParamAfficheCloture.Affiche := true;
ParamAfficheCloture.TypeAppel := F_VerifCloture;
if (sender as TMenuItem).Parent <> mnAffichage then
  ParamAfficheCloture.TitreForm :=(Sender as TMenuItem).Caption
else
  ParamAfficheCloture.TitreForm :='Opérations de clôture';
ParamAfficheCloture.SousTitreForm := (Sender as TMenuItem).Caption;

ClotureAffiche(ParamAfficheCloture);


end;

procedure TMain.Historiquecorrection1Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar(E.RepertoireExportation+'error.txt'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.mnFinExerciceImmoClick(Sender: TObject);
begin                                                                     //   or (e.TypeClient=cl_demo)or(e.TypeClient=CL_Saisie_Demo)
  if ((GEstDossierExerciceEnCoursCloturable(E))or(e.ExerciceCloture)or(e.TypeUtilisateur=u_Demo)) then //23/09/2010
  begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
  end
else
 begin
  MessageDlg(AccesRefuseExoN1, mtWarning, [mbOK], 0);
 end;
end;

procedure TMain.Panel6Click(Sender: TObject);
begin
Proprits2.Click;
end;

procedure TMain.Panel7Click(Sender: TObject);
begin
Proprits2.Click;
end;

procedure TMain.EditionBilandouverture1Click(Sender: TObject);
var
Equilibre:TErreurSaisie;
begin
Equilibre:=DMBalance.VerifEquilibreBalanceN;
if Equilibre.retour=false then
  Begin
      if Equilibre.CodeErreur<>7001 then
              if Application.MessageBox(Pchar('Votre balance d''ouverture est déséquilibrée.'+Retourchariotsimple+'Voulez_vous vraiment ouvrir l''édition du bilan d''ouverture ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                abort;
  end;


if E.Regime='A' then
  begin
    if EditionOuverture = nil then EditionOuverture:=TEditionOuverture.Create(Application.MainForm);
    EditionOuverture.show;
  end
else
  begin
        if EditionOuverture_Bic = nil then EditionOuverture_Bic:=TEditionOuverture_Bic.Create(Application.MainForm);
          EditionOuverture_Bic.show;
  end
end;  

procedure TMain.AvecSoldebanque1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
requete : TQuery;
begin
try
CoherenceBalance(gauge1);
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
//TableSauveEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
requete := TQuery.Create(self);
requete.DatabaseName :=DMDiocEtatBal.TaBalanceCalc.DatabaseName;
requete.SQL.Add(' select * from balance b');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = B.compte)');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Collectif','Pointable']);
if ListeCpt.Result then
EditionEcritureL(0,C_TypeEditionLigneComplet_AvecSoldeBanque,true,ListeCpt.Liste,nil,nil,e.SautDePageAutomatique);
finally
   //TableRestoreEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
   requete.close;
   requete.Free
end;
end;

procedure TMain.avecquantits1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
requete : TQuery;
begin
try
CoherenceBalance(gauge1);
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
//TableSauveEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
requete := TQuery.Create(self);
requete.DatabaseName :=DMDiocEtatBal.TaBalanceCalc.DatabaseName;
requete.SQL.Add(' select * from balance b');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = B.compte)');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Collectif','Pointable']);
if ListeCpt.Result then
  EditionEcritureL(0,C_TypeEditionLigneComplet,true,ListeCpt.Liste,nil,nil,e.SautDePageAutomatique);
finally
  //TableRestoreEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
  requete.close;
  requete.free;
end;
end;

procedure TMain.GrandLivre1Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
end;

procedure TMain.Rechercher2Click(Sender: TObject);
begin
SearchInFolder('c:\');
end;

procedure TMain.Explorateurwindows1Click(Sender: TObject);
begin
 ShellExecute(handle, 'explore', 'c:\', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TMain.RepertoireSauvegardes1Click(Sender: TObject);
begin
ShellExecute(handle, 'explore', Pchar(ParamUtil.RepertoireSauvegarde+E.NomDossier+'\'), NiL, NiL, SW_SHOWNORMAL);
end;

procedure TMain.LgrDoss2Click(Sender: TObject);
begin
ShellExecute(handle, 'explore', 'C:\Lgrdoss\EPICEA\', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TMain.InternetExplorer1Click(Sender: TObject);
begin
if e.TypeClient=cl_isa then
  ShellExecute(handle,'open','IEXPLORE.EXE', 'ftp://isabelle:lgr005@linux/', NiL, SW_SHOWNORMAL)
else
  ShellExecute(handle,'open','IEXPLORE.EXE', nil, NiL, SW_SHOWNORMAL);
end;

procedure TMain.Autresprogrammes1Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
end;

procedure TMain.EMail2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'mailto:', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TMain.Web2Click(Sender: TObject);
begin
   ShellExecute(0, 'open', 'http://www.legrain.fr', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TMain.News2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'news:', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TMain.Internet2Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
end;

procedure TMain.AvecPrixUnitaire1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
requete : TQuery;
begin
try
CoherenceBalance(gauge1);
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
//TableSauveEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
requete := TQuery.Create(self);
requete.DatabaseName :=DMDiocEtatBal.TaBalanceCalc.DatabaseName;
requete.SQL.Add(' select * from balance b');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = B.compte)');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Collectif','Pointable']);
if ListeCpt.Result then
  EditionEcritureL(0,C_TypeEditionLigneComplet_AvecPrixUnitaire,true,ListeCpt.Liste,nil,nil,e.SautDePageAutomatique);
finally
  //TableRestoreEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
  requete.close;
  requete.free;
end;
end;

procedure TMain.ExportationDonnes1Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
end;

procedure TMain.sansprcision1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
ParamAffichCompte:TParamAffichCompte;
begin
try
InitialiseParamAffichCompte(ParamAffichCompte);
ListeCpt:=SelectionListeComptePourDettesEtCreances(ParamAffichCompte);

if ListeCpt.Result then
  EditionDetteCreanceL_affinee(C_EditionSimple,True,ListeCpt.Liste,nil,e.SautDePageAutomatique,false);
finally
end;

end;

procedure TMain.avecprcision1Click(Sender: TObject);
var ParamAffichCompte:TParamAffichCompte;
ListeCpt:TResultStrList;
begin
try
InitialiseParamAffichCompte(ParamAffichCompte);
ListeCpt:=SelectionListeComptePourDettesEtCreances(ParamAffichCompte);
if ListeCpt.Result then
  EditionDetteCreanceL_affinee(C_EditionSimple,True,ListeCpt.Liste,nil,e.SautDePageAutomatique,false,true);
finally
end;
end;

procedure TMain.BalanceAnalytique1Click(Sender: TObject);
begin
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.create(application.Mainform);
defiltrageDataset(DMRech.TaTA_ActiviteRech);
DMAnalytiques.ListeActiviteResult:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[DMAnalytiques.ListeActiviteResult]));
DMAnalytiques.ListeAtelierResult.Clear;
DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
EditionBalanceAnalytiqueAtelierL(C_EditionSimple,TRue,nil,DMAnalytiques.ListeAtelierResult,nil,1);
end;

procedure TMain.BalanceExport1Click(Sender: TObject);
begin
if ((DMDiocEtatBal.TaBalanceaffich.Filtered) and ((not empty(DMDiocEtatBal.TaBalanceaffich.Filter)or(DMDiocEtatBal.ListeFiltreAffich.count<>0)))) then
 begin
//   showmessage(DMDiocEtatBal.TaBalanceaffich.Filter);
   if MessageDlg('La balance est filtrée, vous risquez de ne pas exporter toutes '+#13+#10+'les informations !'+#13+#10+''+#13+#10+'Êtes vous sûr de vouloir continuer ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
      case e.TypeClient of
         Cl_Cogere:ExportBalanceCOGEREFiscal(DMDiocEtatBal.TaBalanceaffich);
         else ExportBalanceNormale(DMDiocEtatBal.TaBalanceaffich);
      end;//fin du case
 end
 else
  begin
      case e.TypeClient of
         Cl_Cogere:ExportBalanceCOGEREFiscal(DMDiocEtatBal.TaBalanceaffich);
         else ExportBalanceNormale(DMDiocEtatBal.TaBalanceaffich);
      end;//fin du case
  end;
end;


procedure Initialiser_ShortCut_Main(Init_A_Zero:boolean);
Begin
if Main<>nil then
 begin
  if Init_A_Zero then
    Begin
      Main.PlanComptable1.ShortCut:=0;
      Main.PlanAuxiliaire1.ShortCut:=0;
      Main.AssistantOuverture1.ShortCut:=0;
      Main.mnSaisiePiece.ShortCut:=0;
      Main.Pointages1.ShortCut:=0;
      Main.Balance2.ShortCut:=0;
      Main.Edition1.ShortCut:=0;
      Main.MultiDossier1.ShortCut:=0;
    End
  else
    Begin
      Main.PlanComptable1.ShortCut:=ShortCut(VK_F2,[]);
      Main.PlanAuxiliaire1.ShortCut:=ShortCut(VK_F3,[]);
      Main.AssistantOuverture1.ShortCut:=ShortCut(VK_F4,[]);
      Main.mnSaisiePiece.ShortCut:=ShortCut(VK_F6,[]);
      Main.Pointages1.ShortCut:=ShortCut(VK_F5,[]);
      Main.Balance2.ShortCut:=ShortCut(VK_F8,[]);
      Main.Edition1.ShortCut:=ShortCut(VK_F11,[]);
      Main.MultiDossier1.ShortCut:=ShortCut(VK_F12,[]);
    End;
 end;//si main créé
end;

procedure TMain.RintgrationdesDPI2Click(Sender: TObject);
begin
 EditionAmort_A_Reinteg(C_EditionSimple,false,nil,nil,'');
end;

procedure TMain.DPIpratiques1Click(Sender: TObject);
begin
EditionDesDeductions(C_EditionSimple,false,nil,nil,'');
end;

procedure TMain.UtilisationsdesDPI1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
requete : TQuery;
ParamAffichCompte:TParamAffichCompte;
begin
try
if DMDeduction=nil then DMDeduction := TDMDeduction.Create(Application.MainForm);
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.DatabaseName :=DM_C_NomAliasExercice;
requete.SQL.Text:=RequeteExercice;
requete.Open;

InitialiseParamAffichCompte(ParamAffichCompte);
ParamAffichCompte.Dataset:=requete;
ParamAffichCompte.Filtrer:=false;
ParamAffichCompte.FiltreNbChiffre := 0;
ParamAffichCompte.ListeChamps.Add('Exercice');
ParamAffichCompte.EventButtonAjouterClick:=nil;
ParamAffichCompte.EventButtonSupprimerClick:=nil;

listecpt:=ChoixCompteAffich(ParamAffichCompte);
if ListeCpt.Result then
  begin
    EditionDesDeductions(C_EditionSimple,false,listecpt.Liste,nil,'');
  end;
finally
  requete.close;
  requete.free;
end;  
end;

procedure TMain.RintgrationdesDPI1Click(Sender: TObject);
begin
 EditionAmort_A_Reinteg(C_EditionSimple,false,nil,nil,'');
end;


procedure TMain.Annulerreprise1Click(Sender: TObject);
begin
 if DMStock=nil then
 DMStock:=TDMStock.Create(self);

     if DMStock.FiltragePourAffichageOD(e.DatExoDebut-1,DMRech.TaStockRech)=true then
     begin
         try
           DMStock.AnnuleRepriseStocks(DMRech.TaStockRech);
           ShowMessage('Annulation terminée');
         except
           begin
           abort;
           end;
         end;
     end;

end;

procedure TMain.Plancomptable2Click(Sender: TObject);
var
Site:TEditLien;
begin
EditionPlanCptL(C_Exportation,DMRech.TaPlanCptRech,nil,nil,Site);
end;

procedure TMain.PlanAuxiliaire2Click(Sender: TObject);
begin
DeFiltrageDataSet(DMRech.TaTiersRech);
EditionPlanAuxL(c_Exportation,DMRech.TaTiersRech,nil);
end;

procedure TMain.CompteFTP1Click(Sender: TObject);
begin
if LitFichierParamFTP(e.ParamFTP.Fichier,e.ParamFTP,true,e.NomDossier,DM_C_ServeurFTP,e.ParamFTP,e.RepertoireDossier) then
  ShellExecute(handle,'open','IEXPLORE.EXE', pchar('ftp://'+e.ParamFTP.Login+':'+e.ParamFTP.PassWord+'@'+e.ParamFTP.Serveur),
      NiL, SW_SHOWNORMAL)
else if Application.MessageBox(Pchar('Voulez-vous règler vos paramètres de connexion ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
    Main.Proprits1Click(GestSauvegarde);
end;

procedure TMain.GrandLivre2Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
    //FormateMenuMain;
end;

procedure TMain.normale1Click(Sender: TObject);
var
ListeCpt:TStringList;
begin
ListeCpt:=TStringList.Create;
DeFiltrageDataSet(DMRech.TaBalanceRech);
ListeCpt:=ChampTableVersListe('Compte',DMRech.TaBalanceRech);
EditionEcritureL(C_Exportation,C_TypeEditionLigneComplet_AvecPrixUnitaire,true,ListeCpt,nil,nil,e.SautDePageAutomatique);
end;

procedure TMain.avecquantit1Click(Sender: TObject);
var
ListeCpt:TStringList;
begin
ListeCpt:=TStringList.Create;
DeFiltrageDataSet(DMRech.TaBalanceRech);
ListeCpt:=ChampTableVersListe('Compte',DMRech.TaBalanceRech);
EditionEcritureL(C_Exportation,C_TypeEditionLigneComplet,true,ListeCpt,nil,nil,e.SautDePageAutomatique);
end;

procedure TMain.avecsoldeprogressif1Click(Sender: TObject);
var
ListeCpt:TStringList;
begin
ListeCpt:=TStringList.Create;
DeFiltrageDataSet(DMRech.TaBalanceRech);
ListeCpt:=ChampTableVersListe('Compte',DMRech.TaBalanceRech);
EditionEcritureL(C_Exportation,C_TypeEditionLigneComplet_AvecSoldeBanque,true,ListeCpt,nil,nil,e.SautDePageAutomatique);
end;

procedure TMain.GrandlivredesTiers2Click(Sender: TObject);
var
ListeCpt:TStringList;
begin
ListeCpt:=TStringList.Create;
DeFiltrageDataSet(DMRech.TaBalanceTiersRech);
ListeCpt:=ChampTableVersListe('Tiers',DMRech.TaBalanceTiersRech);
EditionEcritureL(C_Exportation,C_TypeEditionLigneComplet,true,ListeCpt,nil,nil,e.SautDePageAutomatique);
end;

procedure TMain.Avecsoldeprogressif2Click(Sender: TObject);
var
ListeCpt:TStringList;
begin
  case E.Type_Edition of
    C_IMP_NORMAL:Begin
                  ListeCpt:=TStringList.Create;
                  DeFiltrageDataSet(DMRech.TaBalanceTiersRech);
                  ListeCpt:=ChampTableVersListe('Tiers',DMRech.TaBalanceTiersRech);
                  EditionEcritureL(0,C_TypeEditionLigneComplet_AvecSoldeBanque,true,ListeCpt,nil,nil,e.SautDePageAutomatique);
                 End;
    else showmessage('Type_Edition non défini');
  end;
end;

procedure TMain.Avecquantit2Click(Sender: TObject);
var
ListeCpt:TStringList;
begin
  case E.Type_Edition of
    C_IMP_NORMAL:Begin
                  ListeCpt:=TStringList.Create;
                  DeFiltrageDataSet(DMRech.TaBalanceTiersRech);
                  ListeCpt:=ChampTableVersListe('Tiers',DMRech.TaBalanceTiersRech);
                  EditionEcritureL(0,C_TypeEditionLigneComplet,true,ListeCpt,nil,nil,e.SautDePageAutomatique);
                 End;
    else showmessage('Type_Edition non défini');
  end;
end;

procedure TMain.Avecprixunitaire2Click(Sender: TObject);
var
ListeCpt:TStringList;
begin
  case E.Type_Edition of
    C_IMP_NORMAL:Begin
                  ListeCpt:=TStringList.Create;
                  DeFiltrageDataSet(DMRech.TaBalanceTiersRech);
                  ListeCpt:=ChampTableVersListe('Tiers',DMRech.TaBalanceTiersRech);
                  EditionEcritureL(0,C_TypeEditionLigneComplet_AvecPrixUnitaire,true,ListeCpt,nil,nil,e.SautDePageAutomatique);
                 End;
    else showmessage('Type_Edition non défini');
  end;
end;

procedure TMain.Journaux3Click(Sender: TObject);
begin
EditionDesJournauxL(C_Exportation,True,nil,nil);
end;

procedure TMain.Journaldespices2Click(Sender: TObject);
var
etattmp:boolean;
begin
etattmp:=e.PeriodeAutreImpression.Retour;
e.PeriodeAutreImpression.Retour:=false;
EditionDesPiecesL(C_Exportation,True,nil,nil); { isa  le  16/02/04 pas fini !!!!}
e.PeriodeAutreImpression.Retour:=etattmp;
end;

procedure TMain.BalancedesTiers2Click(Sender: TObject);
begin
EditionBalanceTiersL(C_Exportation,true,nil,nil,e.SautDePageAutomatique);
end;

procedure TMain.SurEcheance1Click(Sender: TObject);
var ParamAffichCompte:TParamAffichCompte;
ListeCpt:TResultStrList;
begin
try
InitialiseParamAffichCompte(ParamAffichCompte);
ListeCpt:=SelectionListeComptePourDettesEtCreances(ParamAffichCompte);
if ListeCpt.Result then
  EditionDetteCreanceL_affineeEcheance(C_EditionSimple,True,ListeCpt.Liste,nil,e.SautDePageAutomatique,false,true);
finally
end;
end;



procedure TMain.Grandlivredesactivits1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
begin
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.create(application.Mainform);
defiltrageDataset(DMRech.TaTA_ActiviteRech);

listecpt:=ChoixCompteAffich('Sélectionnez les activités...',DMRech.TaTA_ActiviteRech,['Code_Activite','libelle_activite'],true);
//DMAnalytiques.ListeActiviteResult:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
if ListeCpt.Result then
begin
  FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[ListeCpt.Liste]));
  DMAnalytiques.ListeAtelierResult.Clear;
  DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
  if ListeCpt.Result then
    EditionGLivreAnalytiqueActiviteL(C_EditionSimple,TRue,nil,ListeCpt.Liste,nil);
end;
//DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
//EditionGLivreAnalytiqueActiviteL(C_EditionSimple,TRue,DMAnalytiques.ListeActiviteResult,nil);
end;

procedure TMain.Balancedesactivits1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
begin
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.create(application.Mainform);
defiltrageDataset(DMRech.TaTA_ActiviteRech);

listecpt:=ChoixCompteAffich('Sélectionnez les activités...',DMRech.TaTA_ActiviteRech,['Code_Activite','libelle_activite'],true);
//DMAnalytiques.ListeActiviteResult:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
if ListeCpt.Result then
begin
  FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[ListeCpt.Liste]));
  DMAnalytiques.ListeAtelierResult.Clear;
  DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
  if ListeCpt.Result then
    EditionBalanceAnalytiqueActiviteL(C_EditionSimple,TRue,nil,ListeCpt.Liste,nil);
end;
//EditionBalanceAnalytiqueActiviteL(C_EditionSimple,TRue,DMAnalytiques.ListeActiviteResult,nil);
end;

procedure TMain.Balancedouverture1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
requete : TQuery;
begin
try
CoherenceBalance(gauge1);
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
TableSauveEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
requete := TQuery.Create(self);
requete.DatabaseName :=DMDiocEtatBal.TaBalanceCalc.DatabaseName;
requete.SQL.Add(' select * from balance b');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = B.compte)');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Collectif','Pointable']);
if ListeCpt.Result then
  EditionBalanceOuvertureL(ListeCpt.Liste,nil);
//EditionBalanceOuvertureL(nil,nil);
finally
  //TableRestoreEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
  requete.close;
  requete.free;
end;
end;

procedure TMain.ChargesetProduitsN11Click(Sender: TObject);
var
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
begin
try
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;

    if DMRepart = nil then DMRepart:=TDMRepart.Create(Application.MainForm);
    FiltrageDataSet(DMRepart.TaReport,'Compte >= 6');
    listecpt:=ChoixCompteAffich('',DMRepart.TaReport,['Compte']);
    if (ListeCpt.Result)and (ListeCpt.Liste.count>1) then
    begin
    ListeEdition:=ChampTableVersListeEx(['Compte','Libelle','Debit_Report','Credit_Report'],DMRepart.TaReport,';',true);
    iMain:=0;
        while iMain<=ListeEdition.Count-1 do
          begin
              if listecpt.Liste.IndexOf(str_getstringelement(ListeEdition.Strings[iMain],1,';'))=-1 then
                ListeEdition.Delete(iMain)
              else
                begin
                  ListeEdition.Strings[iMain]:=str_Setstringelement(ListeEdition.Strings[iMain],3,';',e.FormatCurrSansDevise(StrToCurr_Lgr(str_Getstringelement(ListeEdition.Strings[iMain],3,';'))));
                  ListeEdition.Strings[iMain]:=str_Setstringelement(ListeEdition.Strings[iMain],4,';',e.FormatCurrSansDevise(StrToCurr_Lgr(str_Getstringelement(ListeEdition.Strings[iMain],4,';'))));
                  inc(iMain);
                end;
          end;
          EditionChargesEtProduitsOuvertureL(ListeEdition);
    end;
finally
end;
end;

procedure TMain.dtaills1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
begin
try
    requete := TQuery.Create(self);
    requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
    requete.SQL.Add(' select * from "'+e.RepertoireDossier+'model" M');
    requete.Open;
    ListeCpt.Liste:=TStringList.Create;
    ListeCpt.result:=true;
    DeFiltrageDataSet(requete);
    listecpt:=ChoixCompteAffich('Sélectionnez les journaux...',requete,['Journal','Libelle_model','compte'],true);
    if ListeCpt.Result then
      EditionDesJournauxL(C_EditionSimple,True,ListeCpt.Liste,nil);
finally
    Requete.Close;
    requete.free;
end;

end;

procedure TMain.Synthse1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
begin
try
    requete := TQuery.Create(self);
    requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
    requete.SQL.Add(' select * from "'+e.RepertoireDossier+'model" M');
    requete.Open;
    ListeCpt.Liste:=TStringList.Create;
    ListeCpt.result:=true;
    DeFiltrageDataSet(requete);
    listecpt:=ChoixCompteAffich('Sélectionnez les journaux...',requete,['Journal','Libelle_model','compte'],true);
    if ListeCpt.Result then
      EditionDesJournauxL(C_EditionSimple,True,ListeCpt.Liste,nil,true);
finally
    Requete.Close;
    requete.free;
end;
end;

procedure TMain.Liassefiscale2Click(Sender: TObject);
begin
ExportDonnees(e.RepertoireExportLiasse);
end;

procedure TMain.Dtaille1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
CoherenceBalance(gauge1);
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionPMValuesFiscalesL(C_EditionSimple,True,listecpt.Liste,nil,'');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Synthse2Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
CoherenceBalance(gauge1);
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionPMValuesFiscalesL(C_EditionSimple,True,listecpt.Liste,nil,'',false,true);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Dtaille2Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
EditionPMValuesComptablesL(C_EditionSimple,True,listecpt.Liste,nil,'');
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Synthse3Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
CoherenceBalance(gauge1);
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionPMValuesComptablesL(C_EditionSimple,True,listecpt.Liste,nil,'',true);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Amortissementsur5ans1Click(Sender: TObject);
begin
GestListMenu(sender as TMenuItem);
end;

procedure TMain.BalanceCerfaLiasse1Click(Sender: TObject);
begin
if ((DMDiocEtatBal.TaBalanceaffich.Filtered) and ((not empty(DMDiocEtatBal.TaBalanceaffich.Filter)or(DMDiocEtatBal.ListeFiltreAffich.count<>0)))) then
 begin
   if MessageDlg('La balance est filtrée, vous risquez de ne pas exporter toutes '+#13+#10+'les informations !'+#13+#10+''+#13+#10+'Êtes vous sûr de vouloir continuer ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
      case e.TypeClient of
         cl_cogere:ExportBalanceCOGEREFiscal_Liasse(DMDiocEtatBal.TaBalanceaffich);
      end;//fin du case
 end
 else
  begin
      case e.TypeClient of
         cl_cogere:ExportBalanceCOGEREFiscal_Liasse(DMDiocEtatBal.TaBalanceaffich);
      end;//fin du case
  end;
end;

procedure TMain.Grandlivreanalytique1Click(Sender: TObject);
begin
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.create(application.Mainform);
defiltrageDataset(DMRech.TaTA_ActiviteRech);
DMAnalytiques.ListeActiviteResult:=ChampTableVersListe('Code_Activite',DMRech.TaTA_ActiviteRech);
FiltrageDataSet(DMRech.TaTA_AtelierRech,CreeFiltreOU('Code_Activite',[DMAnalytiques.ListeActiviteResult]));
DMAnalytiques.ListeAtelierResult.Clear;
DMAnalytiques.ListeAtelierResult:=ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech);
EditionGLivreAnalytiqueAtelierL(C_EditionSimple,TRue,nil,DMAnalytiques.ListeAtelierResult,nil,1);
end;

procedure TMain.Compte3chiffres1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
  try
  CoherenceBalance(gauge1);
  listecpt.Liste:=nil;
  ListeCpt.result:=true;
  requete := TQuery.Create(self);
  requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
  requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
  requete.Open;
  listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
  if listecpt.Result then
  EditionPMValuesFiscalesL3Chiffres(C_EditionSimple,True,listecpt.Liste,nil,'',false,true);
  finally
     requete.close;
     requete.Free;
  end;
end;

procedure TMain.Synthsecompte3chiffres1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
CoherenceBalance(gauge1);
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
if listecpt.Result then
  EditionPMValuesComptablesL3Chiffres(C_EditionSimple,True,listecpt.Liste,nil,'',true);
finally
   requete.close;
   requete.Free;
end;
end;

procedure TMain.rames1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
requete : TQuery;
begin
try
ListeCpt.Liste:=TStringList.Create;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.DatabaseName :=DMRech.TaTrameRech.DatabaseName;
requete.SQL.Add(' select * from Trame');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les trames...',requete,['code','libelle_trame'],true);
if ListeCpt.Result then
  EditionDesTrames(C_EditionSimple,True,ListeCpt.Liste,nil);
finally
   requete.close;
   requete.Free
end;
end;

procedure TMain.Dernierrapporterreur1Click(Sender: TObject);
var
ParamAffichage:TParamAffichage;
ListeErreur:TStringList;
begin
try
Initialise_TParamAffichage(ParamAffichage);
ParamAffichage.AffichModal := true;
ParamAffichage.Titre:='Rapport d''importation des pièces';
ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
ListeErreur := TStringList.Create;
if(FileExists(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Import_Piece.TXT'))then
  begin
    ListeErreur.LoadFromFile(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Import_Piece.TXT');
    AfficheVisuListView(ParamAffichage,['Erreur','N° Pièce','N° Ligne','Type Pièce','Référence','Date Pièce','Compte','Libellé','Débit','Crédit','Qt1','Qt2','Code Tva','Taux','TVA Débit','TVA Crédit','Echéance','Tiers','Nom','Adresse 1','Adresse 2','Code P.','Ville','TvaDate','Livraison',''],
                                     [40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40],//
                                     [ListeErreur],
                                     [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                     taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                     taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                     taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                     taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                     [1..26],
                                     [],[]);
  end;
finally
  ListeErreur.Free;
end;
end;

procedure TMain.ImportationE2Fac2Click(Sender: TObject);
var
etatTmp:TTypeEtatExercice;
begin
EtatTmp:=e.TypeEtatExercice;
e.TypeEtatExercice:=ET_Importation;
DMImport.Import_Piece_SurType(nil,true,DM_C_NomFichierImportE2_FAC,C_IMPORT_E2_FAC);
e.TypeEtatExercice:=EtatTmp;
end;

procedure TMain.ImportationSara2Click(Sender: TObject);
begin
DMImport.Import_Piece_SurType(nil,true,DM_C_NomFichierImportSARA,C_IMPORT_SARA);
end;

procedure TMain.EnvoierapportparEmail1Click(Sender: TObject);
begin
if (FileExists(IncludeTrailingPathDelimiter(E.repertoireImportCourante)+'Import_Piece.TXT'))then
  begin
   SendMail('Rapport d''importation Epicéa-2',
            'Saisissez ici vos commentaires : ',
            IncludeTrailingPathDelimiter(E.RepertoireImportation)+'Import_Piece.TXT',
            E.NomDossier,
            '',
            '',
            'support@legrain.fr');
  end;
end;

procedure TMain.Epuration1Click(Sender: TObject);
begin
if (DMcorrections = nil ) then DMcorrections := TDMcorrections.Create(Application.MainForm);
if Epuration(true).retour then
  Application.MessageBox(Pchar('L''épuration du dossier est terminée'),'Terminée avec succès',MB_ICONINFORMATION);
end;

procedure TMain.Rgnrationdestables1Click(Sender: TObject);
begin
 if regeneration = nil then regeneration:=Tregeneration.Create(Application.MainForm);
    regeneration.ShowModal;
end;

procedure TMain.Requetesql1Click(Sender: TObject);
begin
    ShellExecute(handle,nil,'DBEXPL32.exe',nil,PChar(ExtractFilePath(Application.ExeName)),SW_SHOW);
end;

procedure TMain.DductionDPI1Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
end;

procedure TMain.DPIClick(Sender: TObject);
begin
     GestListMenu(sender as TMenuItem);
end;

procedure TMain.SaisiedesDPIetleursutilisations1Click(Sender: TObject);
var
ParamAffichageDeduction:TParamAfficheDeduction;
begin
try
  ParamAffichageDeduction.AffichageModal := Monofenetrage;
  ParamAffichageDeduction.Affiche := true;
  ParamAffichageDeduction.TitreForm :='';
  ParamAffichageDeduction.SousTitreForm := '';

  if not DeductionAffiche(ParamAffichageDeduction) then abort;
except
   abort;
end;
end;
procedure TMain.Requeteisa1Click(Sender: TObject);
begin
if EditeurRequeteSql=nil then EditeurRequeteSql :=TEditeurRequeteSql.Create(application.MainForm);
EditeurRequeteSql.Show
end;

procedure TMain.BalanceAvecSeparateur1Click(Sender: TObject);
begin
if ((DMDiocEtatBal.TaBalanceaffich.Filtered) and ((not empty(DMDiocEtatBal.TaBalanceaffich.Filter)or(DMDiocEtatBal.ListeFiltreAffich.count<>0)))) then
 begin
   if MessageDlg('La balance est filtrée, vous risquez de ne pas exporter toutes '+#13+#10+'les informations !'+#13+#10+''+#13+#10+'Êtes vous sûr de vouloir continuer ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
        ExportBalanceNormale(DMDiocEtatBal.TaBalanceaffich);
 end
 else
  begin
       ExportBalanceNormale(DMDiocEtatBal.TaBalanceaffich);
  end;
end;

procedure TMain.Calcul1Click(Sender: TObject);
begin
if (DMcorrections = nil ) then DMcorrections := TDMcorrections.Create(Application.MainForm);
ShowMessage(Resultats.GetText);
end;





procedure TMain.GestionduBDE1Click(Sender: TObject);
 var
  sDirEXE: string;
 begin
  sDirEXE := ExtractFilePath(Application.ExeName);
  if not VerifBDE(sDirExe) then
    begin
			ShowMessage('Moteur Base de donnée non trouvé !!!');
			Exit;
		end;
    BDE_InitComplet(BDE_Exist);
end;

procedure TMain.Associationavecoutilrestauration1Click(Sender: TObject);
begin
if application.MessageBox(pchar('Voulez-vous associer vos sauvegardes Epicéa (.zlg) à l''outil de restauration "MDCogere" ?'),'Paramètrage de l''outil "MDCogere"',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
  begin
    //ShellExecute(Handle, 'open', Pchar(e.RepertoireProgram+'\assoc.bat'),nil, nil, SW_SHOWNORMAL);
    ShellExecute(handle,nil,Pchar(e.RepertoireProgram+'\assoc.bat'), pchar('%1'),
            NiL, SW_SHOWNORMAL);
  end;
end;

procedure TMain.riparcodeemprunt1Click(Sender: TObject);
begin
EditionEmpruntTresorerieL(C_EditionSimple,True,nil,nil,CodeEmp);
end;

procedure TMain.ripardatederalisation1Click(Sender: TObject);
begin
EditionEmpruntTresorerieL(C_EditionSimple,True,nil,nil,DateRealisation);
end;

procedure TMain.Listedesateliers1Click(Sender: TObject);
begin
EditionAteliersL(C_EditionSimple,nil)
end;

procedure TMain.Listedesactivits1Click(Sender: TObject);
begin
EditionActivitesL(C_EditionSimple,nil);
end;

procedure TMain.Rapprochementrelev1Click(Sender: TObject);
var
ParamAfficheReleve:TParamAfficheReleve;
begin
ParamAfficheReleve.Titre:='';
ParamAfficheReleve.Direct:=true;
ParamAfficheReleve.DateFinReleve:=now;
ParamAfficheReleve.Marque:=DateToStr(now);
RapprochementRelevesAffiche(ParamAfficheReleve);

end;

procedure TMain.EcrituresavecTVA1Click(Sender: TObject);
var
requete:TQuery;
infosJournal:TInfosModel;
ParamAffichCompte:TParamAffichCompte;
ResultStrList:TResultStrList;
begin
try//finally
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:='Sélectionnez un code de TVA';
                  ParamAffichCompte.Tiers:=false;
                  requete:=TQuery.create(self);
                  requete.close;
                  requete.SQL.Clear;
                  requete.DatabaseName := DM_C_NomAliasDossier;
                  requete.SQL.Add('select tvaCode,libelle,compte,taux_inf,taux_supp from tvacode.db');
                  requete.Open;
                  ParamAffichCompte.Dataset:=requete;

                  ParamAffichCompte.Filtrer:=false;
                  ParamAffichCompte.FiltreNbChiffre := 0;
                  ParamAffichCompte.ListeChamps.Add('tvaCode');
                  ParamAffichCompte.ListeChamps.Add('libelle');
                  ParamAffichCompte.ListeChamps.Add('compte');
                  ParamAffichCompte.ListeChamps.Add('taux_inf');
                  ParamAffichCompte.ListeChamps.Add('taux_supp');
                  ParamAffichCompte.EventButtonAjouterClick:=nil;
                  ParamAffichCompte.EventButtonSupprimerClick:=nil;
          ResultStrList:=ChoixCompteAffich(ParamAffichCompte);
          if(ResultStrList.Result)then
          begin
            EditionDesJournauxDeTvaSansCalcul(C_EditionSimple,True,ResultStrList.Liste,nil);
          end;
finally
  requete.close;
  requete.Free;
  if ResultStrList.Liste<>nil then Initialise_TStringlist(ResultStrList.Liste,self);
  LibereParamAffichCompte(ParamAffichCompte);
end;
end;


procedure TMain.Button8Click(Sender: TObject);
begin
//if(fmMain=nil)then fmMain:=TfmMain.Create(self);
//if(frmProgress=nil)then frmProgress:=TfrmProgress.create(self);
//fmMain.Show;
end;



procedure TMain.Balancecomparative1Click(Sender: TObject);
var
ParamAffiche:TParamAfficheBalanceComparative;
begin
BalanceComparativeAffiche(ParamAffiche);
end;

procedure TMain.immosSur5Ans1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
etatFiltre:TEtatFiltre;
begin
try
if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.create(application.MainForm);
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where upper(I.type_amt)<>''N'' and (I.amort_eco+I.amort_derog<I.valeur_a_amortir)');
requete.SQL.Add(' and I.compte like(''2%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
etatFiltre.Filtree:=DataModuleImmos.QuImmosEdition.Filtered;
DataModuleImmos.QuImmosEdition.Filtered:=false;
if listecpt.Result then
  EditionAmort5AnsSimplifieL(C_EditionSimple,false,listecpt.Liste,DataModuleImmos.QuImmosEdition,'');
finally
   DataModuleImmos.QuImmosEdition.Filtered:=etatFiltre.Filtree;
   requete.close;
   requete.Free;
end;
end;

procedure TMain.subventionSur5ans1Click(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
etatFiltre:TEtatFiltre;
begin
try
if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.create(application.MainForm);
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
requete.SQL.Add(' where upper(I.type_amt)<>''N'' and (I.amort_eco+I.amort_derog<I.valeur_a_amortir)');
requete.SQL.Add(' and I.compte like(''13%'')and I.compte not like(''139%'')');
requete.Open;
listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
etatFiltre.Filtree:=DataModuleImmos.QuImmosEdition.Filtered;
DataModuleImmos.QuImmosEdition.Filtered:=false;
if listecpt.Result then
  EditionAmort5AnsSimplifieL(C_EditionSimple,false,listecpt.Liste,DataModuleImmos.QuImmosEdition,'');
finally
   DataModuleImmos.QuImmosEdition.Filtered:=etatFiltre.Filtree;
   requete.close;
   requete.Free;
end;
end;

procedure TMain.Envoiehistoriquedansdossier1Click(Sender: TObject);
begin
CopyFile(PChar(E.RepertoireProgram+'error.txt'),PChar(E.RepertoireDossier+'error.txt'),nil);
//ShellExecute(Handle, 'open', PChar(E.RepertoireProgram+'error.txt'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMain.EnvoiehistoriqueparEmail1Click(Sender: TObject);
begin
if (FileExists(IncludeTrailingPathDelimiter(E.RepertoireProgram)+'Error.TXT'))then
  begin
   SendMail('Rapport d''erreur Epicéa-2',
            'Saisissez ici vos commentaires : ',
            IncludeTrailingPathDelimiter(E.RepertoireProgram)+'Error.TXT',
            E.NomDossier,
            '',
            '',
            'support@legrain.fr');
  end;
end;

procedure TMain.Dernierrapporterreurpointages1Click(Sender: TObject);
var
ParamAffichage:TParamAffichage;
ListeErreur:TStringList;
begin
try
            ListeErreur:=TStringList.Create;
            Initialise_TParamAffichage(ParamAffichage);
            ParamAffichage.AffichModal := true;
            ParamAffichage.Titre:='Rapport d''importation des pointages';
            ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
            if(FileExists(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Import_Pointage.TXT'))then
            begin
            ListeErreur.LoadFromFile(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Import_Pointage.TXT');
              AfficheVisuListView(ParamAffichage,['Erreur','N° Pièce','N° Ligne','Type Pièce','Référence','Date Pièce','Compte','Libellé','Débit','Crédit',
              'RefContrepartie','DateContrepartie','MontantDebitContrepartie','MontantCreditContrepartie','Montant pointage',''],
                                               [40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40],//
                                               [ListeErreur],
                                               [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify],
                                               [1..16],
                                               [],[]);
            end;

finally
  ListeErreur.Free;
end;
end;

procedure TMain.ableaudesemprunstslongsterme1Click(Sender: TObject);
begin
EditionEmpruntMouvExerciceEtAnnuiteL(C_EditionSimple,True,nil,nil);
end;

function TMain.InstallationBirt:boolean;
var
Dirtomcat:string;
begin
Dirtomcat:=IncludeTrailingPathDelimiter(RepertoirePere(e.RepertoireProgram))+'Tomcat';
//Dirtomcat:=str_remplacesouschaine(e.RepertoireProgram,'Epicea','Tomcat');
//showmessage(Dirtomcat);
//if(str_commence_par(e.RepertoireProgram,'C:\Projet\Epicea-2'))then
//Dirtomcat:='C:\Program Files\Apache Software Foundation\Tomcat 7.0';
if(not DirExists(Dirtomcat+'\webapps\birt'))then
begin
CreeRepertoire(Dirtomcat+'\webapps\birt',true);
ZipMaster1.Verbose := true;
ZipMaster1.ExtrOptions := ZipMaster1.ExtrOptions+[ZipMstr19.ExtrOverWrite]+[ZipMstr19.ExtrDirNames];
ZipMaster1.ExtrBaseDir :=Dirtomcat+'\webapps\birt';
ZipMaster1.ZipFilename :=Dirtomcat+'\webapps\birt.war';
ZipMaster1.Extract;
end;
if(DirExists(IncludeTrailingPathDelimiter(Dirtomcat)+'webapps\birt\report'))then
begin
  //showmessage('de la source : '+IncludeTrailingPathDelimiter(e.RepertoireProgram)+'birt');
  //showmessage('vers la source : '+IncludeTrailingPathDelimiter(Dirtomcat)+'webapps\');
  CopyAllFilesEx(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'birt',IncludeTrailingPathDelimiter(Dirtomcat)+'webapps\','Copie des fichiers d''édition',false);
  //showmessage('après copie');
end;
end;

function TMain.initialisationBirt:boolean;
var
retour:integer;
begin
InstallationBirt;
if  (ShellExecute(0,nil,'CMD',PChar('/c net start Tomcat7'),nil,0)>32)then
  retour:=ShellExecute(0,nil,PChar(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'lancementEditionBirt.jar'),nil,PChar(e.RepertoireProgram),0)
else
 showmessage('Le service tomcat n''a pas pu s''initialiser');
end;

procedure TMain.Importationcaisse1Click(Sender: TObject);
var
etatTmp:TTypeEtatExercice;
begin
EtatTmp:=e.TypeEtatExercice;
e.TypeEtatExercice:=ET_Importation;
//DMImport.Import_Piece_SurType(nil,true,DM_C_NomFichierImportE2_FAC,C_IMPORT_CAISSE);
DMImport.Import_Piece_SurType(nil,true,DM_C_NomFichierImportCAISSE,C_IMPORT_CAISSE);
e.TypeEtatExercice:=EtatTmp;
end;

procedure TMain.tableaudebord1Click(Sender: TObject);
var
ParamAfficheListeEdition:TParamAfficheListeEdition;
begin
ParamAfficheListeEdition.Titrefenetre:='Tableau de bord';
ParamAfficheListeEdition.Titre:='Tableau de bord';
ParamAfficheListeEdition.ParametreVisible:=false;
ParamAfficheListeEdition.ModuleVisible:=false;

ListeEditionAffiche(ParamAfficheListeEdition);
end;






function TMain.SelectionListeComptePourDettesEtCreances(var ParamAffichCompte:TParamAffichCompte):TResultStrList;
var
ListeCpt:TResultStrList;
Requete : TQuery;
rang:integer;
Filtre:string;
EventButtonClick:TNotifyEvent;
begin
try
    ListeCpt.Liste:=TStringList.Create;
    requete := TQuery.Create(self);
    requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
//                        requete.SQL.Add(' select BT.compte,Bt.tiers,T.nom,T.type from BalanceTiers bt');
//                        requete.SQL.Add(' join "'+e.RepertoireDossier+'Tiers" T on (T.tiers=Bt.tiers)');
    requete.DatabaseName := DMRech.TaTiersRech.DatabaseName;
    requete.SQL.Add(' select Tiers,compte,nom,type from tiers T');

//    requete.SQL.Add(filtre);

    requete.SQL.Add(' union all');
    requete.SQL.Add(' select P.compte,P.compte,P.Libelle,'''' from plancpt P where');
    requete.SQL.Add(' P.pointable=true and P.compte not in');
    requete.SQL.Add(' (select T2.compte from tiers T2 where T2.compte=P.compte)');
    requete.SQL.Add(' order by compte,tiers');

                        requete.Open;

                        ListeCpt.result:=true;
                        DeFiltrageDataSet(requete);
                  //InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:= 'Sélectionnez les tiers ...';
                  ParamAffichCompte.Tiers:=true;
                  ParamAffichCompte.Dataset:=requete;
                  ParamAffichCompte.sautDePage:=e.SautDePageAutomatique;
                 // ParamAffichCompte.titreSautDePage:='Saut de page entre les tiers';

                  EventButtonClick:=LibChoixComptes.BtnSupplTypeTiersClick;
                 ParamAffichCompte.ListeItemAction.AddObject('Sélection des types de tiers', @EventButtonClick);

                  //ParamAffichCompte.EventButtonSupplementClick:=LibChoixComptes.BtnSupplClick;
                  ParamAffichCompte.ListeChamps.Add('Tiers');
                  ParamAffichCompte.ListeChamps.Add('compte');
                  ParamAffichCompte.ListeChamps.Add('nom');
                  ParamAffichCompte.ListeChamps.Add('type');
                        listecpt:=ChoixCompteAffich(ParamAffichCompte);
                        requete.first;
    if (ListeCpt.Result)and (ListeCpt.Liste.count>1) then
        begin //si la liste contient plus d'un tiers, on inverse les champs pour rentrer dans la configuration de l'edition
            while not requete.Eof do
            begin
              rang:=ListeCpt.Liste.IndexOf(requete.findfield('Tiers').AsString);
              if rang>-1 then
                ListeCpt.Liste.Strings[rang]:=requete.findfield('compte').AsString+';'+ListeCpt.Liste.Strings[rang]+';'+requete.findfield('nom').AsString;
              requete.next;
            end;
        end ;
finally
    result:=ListeCpt;
    Requete.Close;
    requete.free;
end;
end;





procedure TMain.Modificationplanettrame1Click(Sender: TObject);
begin
    GestListMenu(sender as TMenuItem);
end;

procedure TMain.Modificationcodetva1Click(Sender: TObject);
var
Requete:Tquery;
UpdateSql:TQuery;
ListeCpt:TResultStrList;
i:integer;
continuer,sauvegarde:boolean;
enMaintenance:boolean;
ParamAfficheChangementTva:TParamAfficheChangementCodeTva;
recup:TRecupMiniMaxTva;
ParamAffichCompte:TParamAffichCompte;
tag:integer;
continue:boolean;
begin
ParamAfficheChangementTva.OldtvaCode:='';
ParamAfficheChangementTva.OldtvaTaux:=0;
ParamAfficheChangementTva.plancpt:=true;
ParamAfficheChangementTva.trame:=true;
ParamAfficheChangementTva.filtreTaux:=true;
ParamAfficheChangementTva.ModifTaux:=true;
Requete:=TQuery.Create(self);
UpdateSql:=TQuery.Create(self);
UpdateSql.DatabaseName:=DM_C_NomAliasDossier;
continuer:=true;
sauvegarde:= Application.MessageBox(Pchar(MessageChangementCodeTva+retourchariotsimple+'Voulez-vous faire une sauvegarde de secours ?')
,'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrYes ;
if(sauvegarde)then
begin
  if FermerDossier(E) then
    continuer:=SauveDossier(nil,'','','-SauvegardeAvantChangementCodeTva-');
   //confirmation:=(confirmation) or (E.TypeClient=CL_Isa);
   //if not continuer then abort;
   OuvreExo(e.NomDossier,e.NomExo,false);
end;

if (continuer)and(ChangementCodeTvaAffiche(ParamAfficheChangementTva)) then
  begin
  tvaCode:=ParamAfficheChangementTva.newTvaCode;
  filtreTaux:=ParamAfficheChangementTva.filtreTaux;
  OldtvaTaux:=ParamAfficheChangementTva.OldTvaTaux;
  recup:=FTvaRecupMiniMaxTva(tvaCode);
  ParamAfficheChangementTva.NewTvaTaux:=recup.Taux_Supp;
if(DMPlan=nil)then DMPlan:=TDMPlan.Create(application.MainForm);
      if(not ParamAfficheChangementTva.plancpt)and(not ParamAfficheChangementTva.trame)then
      begin
        showmessage('Vous n''avez sélectionné aucune action');
      end
      else
      begin
      if(ParamAfficheChangementTva.OldtvaCode='')then ParamAfficheChangementTva.OldtvaCode:='%';
         //selectionner tous les comptes auquels on peut affecter le nouveau code tva
         //et qui contiennent l'ancien code

         if(ParamAfficheChangementTva.plancpt)and( ParamAfficheChangementTva.trame)then
         begin
             tag:=1;
             Requete.DatabaseName:=DM_C_NomAliasDossier;
             Requete.SQL.Clear;
             Requete.SQL.Add(' select P.compte,P.libelle,P.tvaCode,P.taux from plancpt p');
             Requete.SQL.Add('  where P.tvacode =(:code)');
             Requete.SQL.Add(' union ');
             Requete.SQL.Add(' select l.compte,p2.libelle,l.tvaCode,l.tvataux as taux from trameL l join plancpt p2 on p2.compte=l.compte');
             Requete.SQL.Add('  where (l.tvacode =(:code))');
             Requete.ParamByName('code').AsString:=ParamAfficheChangementTva.OldtvaCode;
             requete.OnFilterRecord:=RequeteCompteFilterRecord;
             Requete.open;
         end
         else
         if (ParamAfficheChangementTva.plancpt)then
         begin
             tag:=2;
             Requete.DatabaseName:=DM_C_NomAliasDossier;
             Requete.SQL.Clear;
             Requete.SQL.Add(' select P.compte,P.libelle,P.tvaCode,P.taux from plancpt p');
             Requete.SQL.Add('  where P.tvacode like(:code)');
             Requete.SQL.Add(' order by 1');
             Requete.ParamByName('code').AsString:=ParamAfficheChangementTva.OldtvaCode;
             requete.OnFilterRecord:=RequeteCompteFilterRecord;
             Requete.open;
         end
         else
            if(ParamAfficheChangementTva.trame)then
            begin
             tag:=3;
             Requete.DatabaseName:=DM_C_NomAliasDossier;
             Requete.SQL.Clear;
             Requete.SQL.Add('select  tl.compte,tl.libelle,tl.tvaCode,tl.tvataux as taux,tl.tvatype,t.code,t.libelle_trame,tl.id from TrameL tl ');
             Requete.SQL.Add(' join Trame t on t.id=tl.id_trame where tl.tvacode like(:code)');
             Requete.ParamByName('code').AsString:=ParamAfficheChangementTva.OldtvaCode;
             requete.OnFilterRecord:=RequeteCompteFilterRecord;
             Requete.open;
            end;

         if(requete.RecordCount>0)then
           begin
              case tag of
                1,2:listecpt:=ChoixCompteAffichCoche('Sélectionnez les comptes...',requete,['compte','libelle','tvaCode','taux'],true);
                3:listecpt:=ChoixCompteAffichCoche('Sélectionnez les lignes des trames...',requete,['compte','libelle','tvaCode','taux','TvaType','code','libelle_trame','id'],true);
              end;//fin case

              if ListeCpt.Result then
                begin
                try
                PatienterAffich();
               if Application.MessageBox(Pchar('Vous allez changer les codes tva '+ParamAfficheChangementTva.OldtvaCode+' par les codes tva '+
               ParamAfficheChangementTva.newTvaCode+' des comptes sélectionnés'+retourchariotdouble+
               'Voulez-vous continuer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                  if(ParamAfficheChangementTva.plancpt)then
                    begin
                       try
//                       if Application.MessageBox(Pchar('Vous allez changer les codes tva '+ParamAfficheChangementTva.OldtvaCode+' par les codes tva '+
//                       ParamAfficheChangementTva.newTvaCode+' des comptes sélectionnés'+retourchariotdouble+
//                       'Voulez-vous continuer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                         begin
                             DMPlan.TaPlanCpt.DisableControls;
                             for i:=0 to ListeCpt.Liste.Count-1 do
                               begin
                                     if (DMPlan.TaPlanCpt.Locate('compte',GetStringElement(ListeCpt.Liste.Strings[i],1,';'),[]))and
                                        (DMPlan.TaPlanCpt.FindField('tvacode').AsString=ParamAfficheChangementTva.OldTvaCode) then
                                   begin
                                      continue:=true;
                                      if(ParamAfficheChangementTva.filtreTaux)then continue:= DMPlan.TaPlanCpt.FindField('taux').AsFloat=ParamAfficheChangementTva.OldTvaTaux ;
                                      if(continue)then
                                        begin
                                            TableGereEdit(DMPlan.TaPlanCpt);
                                            DMPlan.TaPlanCpt.FindField('tvacode').AsString:=tvaCode;
                                            if(ParamAfficheChangementTva.ModifTaux)then DMPlan.TaPlanCpt.FindField('taux').AsCurrency:=ParamAfficheChangementTva.NewTvaTaux;
                                            TableGerePost(DMPlan.TaPlanCpt);
                                        end;
                                   end;
                               end;
                          //end;//fin si ok message
                       finally
                          DMPlan.TaPlanCpt.EnableControls;
                       end;
                    end;//fin si plancpt ok
                  if(ParamAfficheChangementTva.trame)then
                  begin
                       case tag of
                          1:begin
                               UpdateSql.SQL.Add('update TrameL set tvaCode=:Newcode ,tvataux=:NewTaux '+
                               'where compte like :cpt and tvaCode like(:Oldcode) ');
                                 if(ParamAfficheChangementTva.filtreTaux)then UpdateSql.SQL.Add(' and tvataux =:OldTaux');
                                   for i:=0 to ListeCpt.Liste.Count-1 do
                                   begin
                                       UpdateSql.ParamByName('Newcode').AsString:=ParamAfficheChangementTva.newTvaCode;
                                       UpdateSql.ParamByName('Oldcode').AsString:=ParamAfficheChangementTva.OldTvaCode;
                                       UpdateSql.ParamByName('NewTaux').AsFloat:=ParamAfficheChangementTva.NewTvaTaux;
                                      if(ParamAfficheChangementTva.filtreTaux)then UpdateSql.ParamByName('OldTaux').AsFloat:=ParamAfficheChangementTva.OldTvaTaux;
                                       if(ParamAfficheChangementTva.ModifTaux)then UpdateSql.ParamByName('NewTaux').AsCurrency:=ParamAfficheChangementTva.NewTvaTaux;
                                       UpdateSql.ParamByName('cpt').AsString:=GetStringElement(ListeCpt.Liste.Strings[i],1,';');
                                       UpdateSql.ExecSQL;
                                   end;
                            end;
                          3:begin
                               UpdateSql.SQL.Add('update TrameL set tvaCode=:Newcode ,tvataux=:NewTaux '+
                               'where id = :idLTrame and tvaCode like(:Oldcode) ');
                              if(ParamAfficheChangementTva.filtreTaux)then UpdateSql.SQL.Add(' and tvataux =:OldTaux');

                                   for i:=0 to ListeCpt.Liste.Count-1 do
                                   begin
                                       UpdateSql.ParamByName('Newcode').AsString:=ParamAfficheChangementTva.newTvaCode;
                                       UpdateSql.ParamByName('Oldcode').AsString:=ParamAfficheChangementTva.OldTvaCode;
                                       UpdateSql.ParamByName('NewTaux').AsFloat:=ParamAfficheChangementTva.NewTvaTaux;
                                       if(ParamAfficheChangementTva.filtreTaux)then UpdateSql.ParamByName('OldTaux').AsFloat:=ParamAfficheChangementTva.OldTvaTaux;
                                       if(ParamAfficheChangementTva.ModifTaux)then UpdateSql.ParamByName('NewTaux').AsCurrency:=ParamAfficheChangementTva.NewTvaTaux;
                                       UpdateSql.ParamByName('idLTrame').AsInteger:=StrToInt_Lgr(GetStringElement(ListeCpt.Liste.Strings[i],8,';'));
                                       UpdateSql.ExecSQL;
                                   end;
                            end;
                       end;//fin case

                  end;//fin si trame ok
                end;//si message ok
                finally
                   PatienterFermer();
                end;
                end;//fin si liste choix compte ok

           end//fin si recordcount >0
         else
         showmessage('Il n''y a aucun compte pour le code tva sélectionné à modifier');
       end;//fin si au moins 1 action
  end;//fin si changement code tva ok

end;

procedure TMain.RequeteCompteFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
listeCodeValide:Tstringlist;
begin
Accept:=false;
if ((not((csDestroying)in dataset.ComponentState))and(dataset<>nil)) then
  begin
      listeCodeValide:=DMPlan.TvaCodePourCompte(31,E.Regime,dataset.FindField('compte').AsString).ListeCode;
      if(listeCodeValide<>nil)and(listeCodeValide.IndexOf(tvacode)<>-1) then
        accept:=true;
        if(accept)and(filtreTaux)then
          accept:=dataset.FindField('taux').AsFloat=OldtvaTaux;
  end;
end;

procedure TMain.RequeteCompteValideFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
Accept:=false;
if ((not((csDestroying)in dataset.ComponentState))and(dataset<>nil)) then
  begin
    Accept:=listeCompteValide.IndexOf(dataset.findfield('compte').AsString)<>-1;
  end;
end;

procedure TMain.Misejourdestrames1Click(Sender: TObject);
var
UpdateSql:TQuery;
Requete:Tquery;
ModifTaux:boolean;
ListeCpt:TResultStrList;
i:integer;
continuer,sauvegarde:boolean;
ParamAffichCompte:TParamAffichCompte;
strings:TStrings;
recup:TRecupMiniMaxTva;
begin
try
Requete:=TQuery.Create(self);
UpdateSql:=TQuery.Create(self);
continuer:=true;
sauvegarde:= Application.MessageBox(Pchar(MessageMiseAJourTrameSaisie+retourchariotsimple+'Voulez-vous faire une sauvegarde de secours ?')
,'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrYes ;
if(sauvegarde)then
begin
  if FermerDossier(E) then
    continuer:=SauveDossier(nil,'','','-SauvegardeAvantChangementCodeTva-');
   OuvreExo(e.NomDossier,e.NomExo,false);
end;

if(continuer)then
begin
//selectionner tous les comptes auquels on peut affecter le nouveau code tva
//et qui contiennent l'ancien code
Requete.DatabaseName:=DM_C_NomAliasDossier;
Requete.SQL.Clear;
Requete.SQL.Add(' select compte,tvaCode,taux from plancpt ');
Requete.SQL.Add(' where exists(select compte from trameL)');
Requete.open;
ListeCpt.Liste:=ChampTableVersListeExLGR(requete,';',false);
for i:=0 to ListeCpt.Liste.Count-1 do
begin
  recup:=FTvaRecupMiniMaxTva(GetStringElement(ListeCpt.Liste.Strings[i],1,';'));
  if recup.Taux_Inf<>recup.Taux_Supp  then
     listeCompteValide.Add(GetStringElement(ListeCpt.Liste.Strings[i],1,';'))
  else
    if (recup.Taux_Inf=StrToInt_Lgr(GetStringElement(ListeCpt.Liste.Strings[i],3,';')))then
       listeCompteValide.Add(GetStringElement(ListeCpt.Liste.Strings[i],1,';'));
end;

Requete.DatabaseName:=DM_C_NomAliasDossier;
Requete.SQL.Clear;
Requete.SQL.Add('select  tl.compte,tl.libelle,tl.tvaCode,tl.tvataux,tl.tvatype,t.code,t.libelle_trame,tl.id from TrameL tl ');
Requete.SQL.Add(' join Trame t on t.id=tl.id_trame');
Requete.Filtered:=true;
Requete.OnFilterRecord:=RequeteCompteValideFilterRecord;
Requete.open;

UpdateSql.DatabaseName:=DM_C_NomAliasDossier;
 if(requete.RecordCount>0)then
           begin
              InitialiseParamAffichCompte(ParamAffichCompte);
              ParamAffichCompte.Titre:='Sélectionnez les lignes des trames...';
              rempliTstringlist(['compte','libelle','tvaCode','tvataux','TvaType','code','libelle_trame'],ParamAffichCompte.ListeChamps);
              rempliTstringlist(['compte','libellé','tva Code','tva taux','Tva Type','code trame','libelle trame'],ParamAffichCompte.TitreChamp);
              rempliTstringlist(['50','150','50','50','50','100','150'],ParamAffichCompte.longueurChamp);
             //
              ParamAffichCompte.Dataset:=requete;
              listecpt:=ChoixCompteAffichCoche('Sélectionnez les lignes des trames...',requete,['compte','libelle','tvaCode','tvataux','TvaType','code','libelle_trame','id'],true);
              if ListeCpt.Result then
                begin
                   try
                   PatienterAffich();
                       if Application.MessageBox(Pchar(MessageAttentionMiseAJourTrame),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                         begin
//                             UpdateSql.SQL.Add('update TrameL set tvaCode=:code ,tvataux=:Taux where compte =:cpt and tvaCode is not null and tvaCode<>''''');
                         UpdateSql.SQL.Add('update TrameL set tvaCode=(select tvacode from plancpt where compte like :cpt) ,'+
                             'tvataux=(select taux from plancpt where compte like :cpt),tvaType=(select tvatype from plancpt where compte like :cpt) '+
                             'where compte like :cpt and tvaCode is not null and tvaCode<>''''');
                             for i:=0 to ListeCpt.Liste.Count-1 do
                             begin
//                                FiltrageDataSet(DMRech.TaPlanCptRech,'compte ='''+ListeCpt.Liste.Strings[i]+'''');
//                                if(DMRech.TaPlanCptRech.RecordCount>0)then
//                                  begin
//                                      UpdateSql.ParamByName('code').AsString:=DMRech.TaPlanCptRech.findfield('tvaCode').asstring;
//                                      UpdateSql.ParamByName('Taux').asFloat:=DMRech.TaPlanCptRech.findfield('taux').asFloat;;
                                      UpdateSql.ParamByName('cpt').AsString:=GetStringElement(ListeCpt.Liste.Strings[i],1,';');
                                      UpdateSql.ExecSQL;
//                                  end;
                             end;
                         end;//fin si message ok
                   finally
                     PatienterFermer();
                   end;
                end;
           end
         else
         showmessage('Il n''y a aucune trame à modifier');
end;
finally
 UpdateSql.Close;
 UpdateSql.Free;
end;
end;

procedure TMain.Modificationtauxtva1Click(Sender: TObject);
var
Requete:Tquery;
UpdateSql:TQuery;
ListeCpt:TResultStrList;
i:integer;
continuer,sauvegarde:boolean;
enMaintenance:boolean;
ParamAfficheChangementTva:TParamAfficheChangementTauxTva;
recup:TRecupMiniMaxTva;
tag:integer;
continue:boolean;
begin
ParamAfficheChangementTva.OldtvaCode:='';
ParamAfficheChangementTva.OldtvaTaux:=0;
ParamAfficheChangementTva.plancpt:=true;
ParamAfficheChangementTva.trame:=true;
ParamAfficheChangementTva.filtreTaux:=true;
ParamAfficheChangementTva.ModifTaux:=true;
Requete:=TQuery.Create(self);
UpdateSql:=TQuery.Create(self);
UpdateSql.DatabaseName:=DM_C_NomAliasDossier;
continuer:=true;
sauvegarde:= Application.MessageBox(Pchar(MessageChangementTauxTva+retourchariotsimple+'Voulez-vous faire une sauvegarde de secours ?')
,'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrYes ;
if(sauvegarde)then
begin
  if FermerDossier(E) then
    continuer:=SauveDossier(nil,'','','-SauvegardeAvantChangementCodeTva-');
   //confirmation:=(confirmation) or (E.TypeClient=CL_Isa);
   //if not continuer then abort;
   OuvreExo(e.NomDossier,e.NomExo,false);
end;
//if(continuer)then
//enMaintenance:=(ParamUtil.maintenance)and(ParamUtil.TypeMaintenance='MaintS');
//continuer := (not enMaintenance)and(Application.MessageBox(Pchar('Cette procédure est irréversible.'+retourchariotsimple+
//'Nous vous conseillons d''effectuer une sauvegarde de secours avant de la lancer.'+
//retourchariotdouble+'Voulez-vous continuer ou annuler pour effectuer une sauvegarde ?'),
//'Attention',MB_ICONEXCLAMATION +MB_OKCANCEL+MB_DEFBUTTON2)=mrok) ;

if (continuer)and(ChangementTauxTvaAffiche(ParamAfficheChangementTva)) then
  begin
  tvaCode:=ParamAfficheChangementTva.newTvaCode;
  filtreTaux:=ParamAfficheChangementTva.filtreTaux;
  OldtvaTaux:=ParamAfficheChangementTva.OldTvaTaux;
if(DMPlan=nil)then DMPlan:=TDMPlan.Create(application.MainForm);
      if(not ParamAfficheChangementTva.plancpt)and(not ParamAfficheChangementTva.trame)then
      begin
        showmessage('Vous n''avez sélectionné aucune action');
      end
      else
      begin
      if(ParamAfficheChangementTva.OldtvaCode='')then ParamAfficheChangementTva.OldtvaCode:='%';
         //selectionner tous les comptes auquels on peut affecter le nouveau code tva
         //et qui contiennent l'ancien code


         if(ParamAfficheChangementTva.plancpt)and( ParamAfficheChangementTva.trame)then
         begin
             tag:=1;
             Requete.DatabaseName:=DM_C_NomAliasDossier;
             Requete.SQL.Clear;
             Requete.SQL.Add(' select P.compte,P.libelle,P.tvaCode,P.taux from plancpt p');
             Requete.SQL.Add('  where P.tvacode =(:code)');
             Requete.SQL.Add(' union ');
             Requete.SQL.Add(' select l.compte,p2.libelle,l.tvaCode,l.tvataux as taux from trameL l join plancpt p2 on p2.compte=l.compte');
             Requete.SQL.Add('  where (l.tvacode =(:code))');
             Requete.ParamByName('code').AsString:=ParamAfficheChangementTva.OldtvaCode;
             requete.OnFilterRecord:=RequeteCompteFilterRecord;
             Requete.open;
         end
         else
         if (ParamAfficheChangementTva.plancpt)then
         begin
             tag:=2;
             Requete.DatabaseName:=DM_C_NomAliasDossier;
             Requete.SQL.Clear;
             Requete.SQL.Add(' select P.compte,P.libelle,P.tvaCode,P.taux from plancpt p');
             Requete.SQL.Add('  where P.tvacode like(:code)');
             Requete.SQL.Add(' order by 1');
             Requete.ParamByName('code').AsString:=ParamAfficheChangementTva.OldtvaCode;
             requete.OnFilterRecord:=RequeteCompteFilterRecord;
             Requete.open;
         end
         else
            if(ParamAfficheChangementTva.trame)then
            begin
             tag:=3;
             Requete.DatabaseName:=DM_C_NomAliasDossier;
             Requete.SQL.Clear;
             Requete.SQL.Add('select  tl.compte,tl.libelle,tl.tvaCode,tl.tvataux as taux,tl.tvatype,t.code,t.libelle_trame,tl.id from TrameL tl ');
             Requete.SQL.Add(' join Trame t on t.id=tl.id_trame  where tl.tvacode like(:code)');
             Requete.ParamByName('code').AsString:=ParamAfficheChangementTva.OldtvaCode;
             requete.OnFilterRecord:=RequeteCompteFilterRecord;
             Requete.open;
            end;


         if(requete.RecordCount>0)then
           begin
              case tag of
                1,2:listecpt:=ChoixCompteAffichCoche('Sélectionnez les comptes...',requete,['compte','libelle','tvaCode','taux'],true);
                3:listecpt:=ChoixCompteAffichCoche('Sélectionnez les lignes des trames...',requete,['compte','libelle','tvaCode','taux','TvaType','code','libelle_trame','id'],true);
              end;//fin case

              if ListeCpt.Result then
                begin
                try
                PatienterAffich();
               if Application.MessageBox(Pchar('Vous allez changer les taux de tva '+FloatToStr_Lgr(ParamAfficheChangementTva.OldTvaTaux)+' par les taux de tva '+
               FloatToStr_Lgr(ParamAfficheChangementTva.NewTvaTaux)+' des comptes sélectionnés'+retourchariotdouble+
               'Voulez-vous continuer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                    if(ParamAfficheChangementTva.plancpt)then
                        begin
                           try

                                 DMPlan.TaPlanCpt.DisableControls;
                                 for i:=0 to ListeCpt.Liste.Count-1 do
                                   begin
                                     if (DMPlan.TaPlanCpt.Locate('compte',GetStringElement(ListeCpt.Liste.Strings[i],1,';'),[]))and
                                        (DMPlan.TaPlanCpt.FindField('tvacode').AsString=ParamAfficheChangementTva.OldTvaCode) then
                                           begin
                                              continue:=true;
                                              if(ParamAfficheChangementTva.filtreTaux)then continue:= DMPlan.TaPlanCpt.FindField('taux').AsFloat=ParamAfficheChangementTva.OldTvaTaux ;
                                              if(continue)then
                                               begin
                                                  TableGereEdit(DMPlan.TaPlanCpt);
                                                  DMPlan.TaPlanCpt.FindField('taux').AsCurrency:=ParamAfficheChangementTva.NewTvaTaux;
                                                  TableGerePost(DMPlan.TaPlanCpt);
                                               end;
                                           end;
                                   end;
                             // end;//fin si ok message
                           finally
                              DMPlan.TaPlanCpt.EnableControls;
                           end;
                        end;//fin si plancpt ok
                        if(ParamAfficheChangementTva.trame)then
                        begin
                       case tag of
                          1:begin
                               UpdateSql.SQL.Add('update TrameL set tvataux=:NewTaux '+
                               'where compte like :cpt and tvaCode like(:Oldcode) ');
                               if(ParamAfficheChangementTva.filtreTaux)then UpdateSql.SQL.Add(' and tvataux =:OldTaux');

                                   for i:=0 to ListeCpt.Liste.Count-1 do
                                   begin
                                       UpdateSql.ParamByName('Oldcode').AsString:=ParamAfficheChangementTva.OldTvaCode;
                                       UpdateSql.ParamByName('NewTaux').AsFloat:=ParamAfficheChangementTva.NewTvaTaux;
                                       if(ParamAfficheChangementTva.filtreTaux)then UpdateSql.ParamByName('OldTaux').AsFloat:=ParamAfficheChangementTva.OldTvaTaux;
                                       if(ParamAfficheChangementTva.ModifTaux)then UpdateSql.ParamByName('NewTaux').AsCurrency:=ParamAfficheChangementTva.NewTvaTaux;
                                       UpdateSql.ParamByName('cpt').AsString:=GetStringElement(ListeCpt.Liste.Strings[i],1,';');
                                       UpdateSql.ExecSQL;
                                   end;
                            end;
                          3:begin
                               UpdateSql.SQL.Add('update TrameL set tvataux=:NewTaux '+
                               'where id = :idLTrame and tvaCode like(:Oldcode) ');
                               if(ParamAfficheChangementTva.filtreTaux)then UpdateSql.SQL.Add(' and tvataux =:OldTaux');

                                   for i:=0 to ListeCpt.Liste.Count-1 do
                                   begin
                                       UpdateSql.ParamByName('Oldcode').AsString:=ParamAfficheChangementTva.OldTvaCode;
                                       UpdateSql.ParamByName('NewTaux').AsFloat:=ParamAfficheChangementTva.NewTvaTaux;
                                       if(ParamAfficheChangementTva.filtreTaux)then UpdateSql.ParamByName('OldTaux').AsFloat:=ParamAfficheChangementTva.OldTvaTaux;
                                       if(ParamAfficheChangementTva.ModifTaux)then UpdateSql.ParamByName('NewTaux').AsCurrency:=ParamAfficheChangementTva.NewTvaTaux;
                                       UpdateSql.ParamByName('idLTrame').AsInteger:=StrToInt_Lgr(GetStringElement(ListeCpt.Liste.Strings[i],8,';'));
                                       UpdateSql.ExecSQL;
                                   end;
                            end;
                       end;//fin case

                        end;//fin si trame ok
                  end;//fin si message ok
                  finally
                     PatienterFermer();
                  end;
                end;//fin si liste choix compte ok
           end//fin si recordcount >0
         else
         showmessage('Il n''y a aucun compte pour le code tva sélectionné à modifier');
       end;//fin si au moins 1 action
  end;//fin si changement code tva ok

end;

procedure TMain.Exportationdescritures1Click(Sender: TObject);
var
etattmp:boolean;
begin
etattmp:=e.PeriodeAutreImpression.Retour;
e.PeriodeAutreImpression.Retour:=false;
EditionDesEcrituresL(C_Exportation,True,nil,nil); { isa  le  16/02/04 pas fini !!!!}
e.PeriodeAutreImpression.Retour:=etattmp;
end;

procedure TMain.InsallerAdobeReader1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://get.adobe.com/fr/reader', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TMain.BalanceCerfaLiasseAsc1Click(Sender: TObject);
begin
if ((DMDiocEtatBal.TaBalanceaffich.Filtered) and ((not empty(DMDiocEtatBal.TaBalanceaffich.Filter)or(DMDiocEtatBal.ListeFiltreAffich.count<>0)))) then
 begin
   if MessageDlg('La balance est filtrée, vous risquez de ne pas exporter toutes '+#13+#10+'les informations !'+#13+#10+''+#13+#10+'Êtes vous sûr de vouloir continuer ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
      case e.TypeClient of
         cl_cogere:ExportBalanceCOGEREFiscal_LiasseAsc(DMDiocEtatBal.TaBalanceaffich);
      end;//fin du case
 end
 else
  begin
      case e.TypeClient of
         cl_cogere:ExportBalanceCOGEREFiscal_LiasseAsc(DMDiocEtatBal.TaBalanceaffich);
      end;//fin du case
  end;
end;



end.


