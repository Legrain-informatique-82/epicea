{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit DMCorrection;

interface


uses
  SysUtils,
  Math,
  Classes,
  Windows,
  Gr_Librairie_Obj,
  E2_Decl_Records,
  DB,
  Forms,
  LibSQL,
  Controls,
  ChoixPeriode,
  E2_LibInfosTable,
  lib_chaine,
  LibDates,
  E2_Librairie_Obj,
  E2_VisuListeView,
  StdCtrls,
  E2_GenerCpt_PM,
  DMImmos,
  E2_Patientez,
  BdeUtils,
  DMPiece,
  DMEcriture,
  LibZoneSaisie,
  DMImportation,
  DMBalances,
  DMPointages2,
  Gr_MultDos,
  DMImmo_Clot,
  DMConstantes,
  DMDiocEtatBalance,
  DMDiocEtatBalanceT,
  LibRessourceString,
  ReindexationTable,
  DMTTVA,
  DMProgramme,
  DMTVA,
  Gauges,
  LibFichRep,
  LibImport,
  RXCtrls,
  DBTables,
  InputQueryFrm_F,
  ShellAPI,
  LibChoixCompte;

type

  TParamDMcorrections=Record
   Quand:Integer;
   DateDeb,DateFin:Tdate;
   GEstInterfaceEvent:TGEstInterfaceEvent;
   dbProgram:TDataBase;
   dbDossier:TDataBase;
   dbExo:TDataBase;
  end;

  TCompteTrouve=record
    compte:string;
    trouve:boolean;
    SoldeFinDebit:string;
    SoldeFinCredit:string;
    SoldeReportDebit:string;
    SoldeReportCredit:string;
  end;


  TImmos=Class(Tobject)
    NumImmos:string;
    reportN2:currency;
    reportN1:currency;
    choixN2:currency;
    Diff:currency;
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;



  TDMcorrections = class(TDataModule)
    QuCorrectionDossier: TQuery;
    QuCorrectionInsert: TQuery;
    QuCorrectionMaxID: TQuery;
    QuCorrectionPointage: TQuery;
    TaCorrection: TTable;
    QuCorrectionExo: TQuery;
    QuCorrectionProgram: TQuery;
    UpdateSQL1: TUpdateSQL;
    dbCorrection: TDatabase;
    TaCorrectionExoCourant: TTable;
    TaCorrectionExo: TTable;
    QuCorrectionUpdate: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TaCorrectionFilterRecordLibelle(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaCorrectionFilterRecordTiers(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaCorrectionFilterRecordTVA(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FilterRecordSumPartDeclaree_PresqueTotal(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FilterRecordSumPartDeclaree_Total(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FilterRecordListeTotalementReglee(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FilterRecordTVA_NON_IMPOSABLE(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaCorrectionFilterRecordIntituleBic(DataSet: TDataSet;
      var Accept: Boolean);
    procedure initialise_TCompteTrouve(Var CompteTrouve:TCompteTrouve);

  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;
    procedure BtnAjouterClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);

  public
    { Déclarations publiques }
    Quand:integer;
    DateDeb,DateFin:Tdate;
    ChampCourant:string;
    TaListeFilterRecord:Tstringlist;
    ListeCodeNonImposable:Tstringlist;

    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;

  end;

//
  TCorrectionTVA = class(TObject)
  private
    { Déclarations privées }
  protected
    { Déclarations protégées }
    FCodeTVA:string;
    FCompteTVA:string;
    FHistoriqueDebit:currency;
    FHistoriqueCredit:currency;
    FReference_OD:string;
    FDeclaration_Debit:currency;
    FDeclaration_Credit:currency;
    FId_Declaration:integer;
    FDebut_Periode:Tdate;
    FFin_Periode:Tdate;
    FPrendreEnCompte:boolean;
  public
    { Déclarations publiques }
    Constructor Create(AOwner :TComponent);
    Destructor Destroy;override;
  published
    { Déclarations publiées }
    property CodeTVA:string read  FCodeTVA write FCodeTVA;
    property CompteTVA:string read  FCompteTVA write FCompteTVA;
    property HistoriqueDebit:currency read FHistoriqueDebit write FHistoriqueDebit;
    property HistoriqueCredit:currency read FHistoriqueCredit write FHistoriqueCredit;
    property Reference_OD:string read FReference_OD write FReference_OD;
    property Declaration_Debit:currency read FDeclaration_Debit write FDeclaration_Debit;
    property Declaration_Credit:currency read FDeclaration_Credit write FDeclaration_Credit;
    property Id_Declaration:integer read FId_Declaration write FId_Declaration;
    property PrendreEnCompte:Boolean read FPrendreEnCompte write FPrendreEnCompte;

    property Debut_Periode:Tdate read FDebut_Periode write FDebut_Periode;
    property Fin_Periode:Tdate read FFin_Periode write FFin_Periode;
  end;//

var
  DMcorrections: TDMcorrections;

  ListeTotalementReglee:Tstringlist;
  PourcentageTvaRegle:Currency;

  Function CorrectionDesTvaCode(Gauge:TGauge=nil;DemandeConfirmation:boolean=true):texceptlgr;
  function CorrectionDesImmosIncorrectes(DateDebCorrection,DateFinCorrection:Tdate;DemandePeriode:boolean;DemandeConfirmation:boolean=true):TexceptLgr;
  function CorrectionImmos_SurCession(DateDebCorrection,DateFinCorrection:Tdate;DemandeConfirmation:boolean=true):TexceptLgr;
  Function InitialiseDMcorrections(ParamDMcorrections:TParamDMcorrections):boolean;
  Function CorrectionDesPointages(DemandeConfirmation:boolean=true):texceptlgr;
  Function VerificationsDesPointagesSurComptesPointables(DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionDeLaBalance(MessageSourd:boolean=false;DemandeConfirmation:boolean=true):texceptlgr;
  function CorrectionTotal(Gauge:TGauge;DemandeConfirmation:boolean=true):Texceptlgr;
  function CorrectionDesPieces(DateDebCorrection,DateFinCorrection:Tdate;DemandePeriode:boolean;DemandeConfirmation:boolean=true):TexceptLgr;
  Function CorrectionDeParamCpt(DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionDossierChangementDateCloture(Exo,ExoAncien:string;DemandeConfirmation:boolean=true):texceptlgr;
  function VerifSiBalanceVerrouillee(DateDebCorrection,DateFinCorrection:Tdate):TexceptLgr;
  function VerifSiReportDerogatoire(DateDebCorrection,DateFinCorrection:Tdate):TexceptLgr;
  Function CorrectionDesTiers_ou_Libelle(Tiers:Boolean;Gauge:TGauge=nil;DemandeConfirmation:boolean=True):texceptlgr;
  Function VerifCoherence_ResteDC_Ecriture(DemandeConfirmation:boolean=False):texceptlgr;
  Function RecupExerciceDossier(idDossier:integer):Tstringlist;
  Function RecupExerciceDossier_Tous(idDossier:integer):Tstringlist;
  Function ReindexationTableProc(ListeTable:Tstringlist;Gauge:TGauge=nil;MessageSourd:boolean=false;
     DemandeConfirmation:boolean=True;ForceReindex:boolean=false):TExceptLGR;
  Function PackTableProc(ListeTable:Tstringlist;Gauge:TGauge=nil;MessageSourd:boolean=false;DemandeConfirmation:boolean=True):TExceptLGR;
  Function VerifCoherence_HTVA(DemandeConfirmation:boolean=true):TExceptlgr;
  Function CorrectionDeLaBalanceDesMouvements(MessageSourd:boolean=false;DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionDeLaBalanceDesTiers(MessageSourd:boolean=false;DemandeConfirmation:boolean=true):texceptlgr;
  Function RestaurationTableImmos(DemandeConfirmation:boolean=true):TExceptLGR;
  Function CorrectionDeclarationTVA(DemandeConfirmation:boolean=true):texceptlgr;
  Function ModificationTableH_TVA(AvecCreationLigne:boolean=true;Partiel:boolean=false;DemandeConfirmation:boolean=true):texceptlgr;
//  Function CorrectionArrondiDeclarationTVA(ListeEcritureTotalementReglee:Tstringlist;DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionArrondiDeclarationTVA(IDDeclaration:integer=-1;DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionPlanComptable(DemandeConfirmation:boolean=true):texceptlgr;
  function CorrectionImmos_Initialisation(DemandeConfirmation:boolean=true):TexceptLgr;
  Function CorrectionAnalytique(DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionDeLaBalanceDesQuantites(Gauge:TGauge=nil;DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionDesIntitulePBilan_Bic(DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionDesSubdivisionsNonAffectesPBilan_Bic(DemandeConfirmation:boolean=true):texceptlgr;
  Function RecuperationDesComptesSurZoneBilan(DemandeConfirmation:boolean=true):texceptlgr;
  procedure CreationODPourVerificationBilan_Bic(NomFichier:string;ListeComptes:Tstringlist;CompteContrepartie:string='';LibellePiece:string='';DatePiece:string='');
  Procedure InitialisePImport(var Import_E2FAC:PImport_E2FAC);
  Function RecuperationDesComptesBilanBIC(DemandeConfirmation:boolean=true):texceptlgr;
  Function ModeleCorrection(DemandeConfirmation:boolean=true):texceptlgr;
  Function VerificationsDesPointagesSurReste_Inf_0(DemandeConfirmation:boolean):texceptlgr;
  Function CorrectionTVASurTypeD(DemandeConfirmation:boolean=true):texceptlgr;
  Function ControleTVASurType(DemandeConfirmation:boolean=true;MessageErreur:boolean=true):texceptlgr;
  Function ControleTVAEnAttente(Gauge:TGauge;DateDeb,DateFin:Tdatetime;Calcul:boolean;DemandeConfirmation:boolean;MessageErreur:boolean;correction:boolean=false):texceptlgr;
  Function CorrectionDesimmosSurRecalculAmort(Gauge:TGauge=nil;ForcerMarquage:boolean=false;ForcerControle:boolean=false;DemandeConfirmation:boolean=true):texceptlgr;
 // Function ControleAmort_DerogSurChangementExercice(Gauge:TGauge=nil;DemandeConfirmation:boolean=true):texceptlgr;
  Function ListeChampTableDansFichier(Table:string;DemandeConfirmation:boolean=true):texceptlgr;
  Function ReinitialisationH_Tva_AvantControle(DemandeConfirmation:boolean=false):texceptlgr;
  Function CoherenceBalance(Gauge:TGauge;DemandeConfirmation:boolean=false):texceptlgr;
  Function initialisationMAJ_Balance(Btn:TRxSpeedButton):string;
  procedure Activation_Desactivation_MAJ_Balance;
  Function Epuration(DemandeConfirmation:boolean):texceptlgr;
  Function CorrectionMultiDossier(Gauge:TGauge;DemandeConfirmation:boolean=false):texceptlgr;
  Function CorrectionCodeEmprunts(Gauge:TGauge;DemandeConfirmation:boolean=false):texceptlgr;
  Function CorrectionDiffereEmprunts(Gauge:TGauge;DemandeConfirmation:boolean=false):texceptlgr;
  function Resultats:TStringList;
  function ExerciceEpure(Exercice:string):Boolean;
 // function PeriodeEpure(DateDeb,DateFin:Tdate):Boolean;
  Function coherenceImmosReport(Gauge:TGauge;DemandeConfirmation:boolean;mess:integer):texceptlgr;
  Function VerifTableImmosIdentique(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
  Function CorrectionDeLaBalanceReportDesTiers(Gauge:TGauge=nil;DemandeConfirmation:boolean=false):texceptlgr;
  Function CorrectionDuPlanComptable(Gauge:TGauge=nil;DemandeConfirmation:boolean=false):texceptlgr;
  Function CorrectionPlanComptableTauxTva(DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionIdEcriture(Gauge:TGauge=nil;DemandeConfirmation:boolean=true):texceptlgr;
  Function CorrectionDesPointages_pasMemeTiers(DemandeConfirmation:boolean=true):texceptlgr;
implementation

uses
  Dialogs, LibClassObjetSenders, DMRecherche, DMPlanCpt, DMBaseDonnee,
  TStringlistLGR, DiversProjets, TypInfo;

{$R *.dfm}

Function InitialiseDMcorrections(ParamDMcorrections:TParamDMcorrections):boolean;
Begin
try
result:=true;
 if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 DMcorrections.Quand := ParamDMcorrections.Quand;
 DMcorrections.DateDeb:=ParamDMcorrections.DateDeb;
 DMcorrections.DateFin:=ParamDMcorrections.DateFin;
 DMcorrections.OnGEstInterfaceEvent := ParamDMcorrections.GEstInterfaceEvent;
except
  result:=false;
end;
End;


Function CorrectionDesTvaCode(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=3000;
        result.retour:=true;
 result.NomModule:='CorrectionDesTvaCode';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le transfert du Code Tva  A2  sur le Code '+#13+#10+'Tva  A1  ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        //Table tvacode
        //select tvacode from tvacode where tvacode='A2' and Compte='44566'
  GestionGauge(10,gauge,30,0,'Contrôle des codes TVA');

        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('select tvacode from tvacode where tvacode=''A2'' and Compte=''44566''');
        DMcorrections.QuCorrectionDossier.Open;
        if DMcorrections.QuCorrectionDossier.RecordCount = 1 then
         begin
            //Table tvacode
            //select tvacode from tvacode where tvacode='A2'
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('update tvacode set tvaCode=''A1'' where tvacode=''A2''');
            DMcorrections.QuCorrectionDossier.ExecSQL;

            //Table Plancpt
            //select tvacode from plancpt where tvacode='A2'
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('update plancpt set tvaCode=''A1'' where tvacode=''A2''');
            DMcorrections.QuCorrectionDossier.ExecSQL;

            //Table Ecriture
            //select tvacode from ecriture where tvacode='A2'
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('update ecriture set tvaCode=''A1'' where tvacode=''A2''');
            DMcorrections.QuCorrectionDossier.ExecSQL;

            //Table ModelL
            //select tvacode from ModelL where tvacode='A2'
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('update ModelL set tvaCode=''A1'' where tvacode=''A2''');
            DMcorrections.QuCorrectionDossier.ExecSQL;

            //Table TrameL
            //select tvacode from TrameL where tvacode='A2'
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('update TrameL set tvaCode=''A1'' where tvacode=''A2''');
            DMcorrections.QuCorrectionDossier.ExecSQL;

  GestionGauge(10,gauge,-1,-1,'');

            DMcorrections.QuCorrectionDossier.close;
         end;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  GestionGauge(10,gauge,0,0,'',false);

  DMcorrections.QuCorrectionDossier.Close;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;

procedure TDMcorrections.DataModuleCreate(Sender: TObject);
begin
//OuvrirTouteTable('',TControl(self));
TaListeFilterRecord:=Tstringlist.Create;
ListeTotalementReglee:=Tstringlist.Create;//
ListeCodeNonImposable:=Tstringlist.Create;//
end;

procedure TDMcorrections.DataModuleDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
Initialise_TStringlist(TaListeFilterRecord);
Initialise_TStringlist(ListeTotalementReglee);
Initialise_TStringlist(ListeCodeNonImposable);
end;

function CorrectionDesImmosIncorrectes(DateDebCorrection,DateFinCorrection:Tdate;DemandePeriode:boolean;DemandeConfirmation:boolean):TexceptLgr;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
Confirmation:boolean;
Reference:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
      result.NumErreur:=6000;
      result.retour:=true;
 result.NomModule:='CorrectionDesImmosIncorrectes';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=not e.ExerciceCloture;
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des immobilisations ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
      if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);

     Periode.DateDeb:=DateDebCorrection;
     Periode.DateFin:=DateFinCorrection;
     if DemandePeriode then
       begin
         try
             if Choix_Periode = nil then Choix_Periode:=TChoix_Periode.Create(Application.MainForm);
             Choix_Periode.EdDateDeb.OnExit:=LibClassObjetSender.SenderOnDateDebExit;
             Choix_Periode.EdDateFin.OnExit:=LibClassObjetSender.SenderOnDateFinExit;
             Initialise_ParamAffichPeriode(ParamAffichPeriode);
             Periode:=ChoixPeriodeAffich(Periode.DateDeb,Periode.DateFin,'Dates de prise en compte du contrôle!',ParamAffichPeriode);
         finally
           Choix_Periode.EdDateDeb.OnExit:=Choix_Periode.EdDateDebExit;
           Choix_Periode.EdDateFin.OnExit:= Choix_Periode.EdDateFinExit;
         end;//fin du try finally
       end
     else
        begin
         periode.Retour := true;
         periode.DateDeb := DateDebCorrection;
         periode.DateFin := DateFinCorrection;
        end;

        PatienterAffich;
        if periode.Retour then
         begin
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('select (Compte||''-''||Code||''-''||sous_code)as Immo from immos where (date_Achat>=:DateDeb) and');
            DMcorrections.QuCorrectionDossier.SQL.add('((Ecriture_Achat is null)or(Ecriture_Achat=0))');
            DMcorrections.QuCorrectionDossier.ParamByName('DateDeb').AsDate:=periode.DateDeb;
            DMcorrections.QuCorrectionDossier.Open;
            if DMcorrections.QuCorrectionDossier.recordcount<>0 then
              begin
               if  Type_version_execution<>CT_DEVELOPPEMENT then
                raise ExceptLGR.Create('L''immobilisation : '+DMcorrections.QuCorrectionDossier.findfield('Immo').asstring+' présente une incohérence. Acquisition ou division mal décrite.',result.NumErreur,false,mtError,Result)
               else
                 begin
                    if VerificationSiPieceDeDotation(Reference) then
                        raise ExceptLGR.Create('La pièce de dotation est déjà passée. CorrectionDesImmosIncorrectes ',result.NumErreur,false,mtError,Result);
                    DMcorrections.QuCorrectionDossier.Close;
                    DMcorrections.QuCorrectionDossier.SQL.Clear;
                    DMcorrections.QuCorrectionDossier.SQL.add('delete from immos where (date_Achat>=:DateDeb) and');
                    DMcorrections.QuCorrectionDossier.SQL.add('((Ecriture_Achat is null)or(Ecriture_Achat=0))');
                    DMcorrections.QuCorrectionDossier.ParamByName('DateDeb').AsDate:=periode.DateDeb;
                    DMcorrections.QuCorrectionDossier.ExecSQL;
                 end;
              end;
            DMcorrections.QuCorrectionDossier.close;

            //correction des cessions
            result.retour:=CorrectionImmos_SurCession(periode.DateDeb,periode.DateFin,DemandeConfirmation).retour;
            
         end;
         //PatienterFermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  DMcorrections.QuCorrectionDossier.close;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;

function CorrectionImmos_SurCession(DateDebCorrection,DateFinCorrection:Tdate;DemandeConfirmation:boolean):TexceptLgr;
var
Confirmation:boolean;
Reference:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
      result.NumErreur:=6001;
      result.retour:=true;
 result.NomModule:='CorrectionImmos_SurCession';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=not e.ExerciceCloture;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
  if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des cessions ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
  begin
  PatienterAffich;
  DMcorrections.QuCorrectionDossier.Close;
  DMcorrections.QuCorrectionDossier.SQL.Clear;
  DMcorrections.QuCorrectionDossier.SQL.add('select (Compte||''-''||Code||''-''||sous_code)as Immo from immos where ((((ecriture_cession=0)or(ecriture_cession is null)) and rebut=false and Terminee=false and ((date_cession between :DateDeb and :datefin)or(cession_dans_annee=true)))');
  DMcorrections.QuCorrectionDossier.SQL.add('or');
  DMcorrections.QuCorrectionDossier.SQL.add('(((ecriture_cession<>0)or(ecriture_cession is not null)) and rebut=false');
  DMcorrections.QuCorrectionDossier.SQL.add('and Terminee=false and (date_cession is null)and(cession_dans_annee=true)))');

  DMcorrections.QuCorrectionDossier.ParamByName('DateDeb').AsDate:=DateDebCorrection;
  DMcorrections.QuCorrectionDossier.ParamByName('Datefin').AsDate:=DateFinCorrection;
  DMcorrections.QuCorrectionDossier.open;
  if DMcorrections.QuCorrectionDossier.recordcount<>0 then
    begin
       if  Type_version_execution<>CT_DEVELOPPEMENT then
          raise ExceptLGR.Create('L''immobilisation : '+DMcorrections.QuCorrectionDossier.findfield('Immo').asstring+' présente une incohérence. Cession mal décrite.',result.NumErreur,false,mtError,Result)
       else
         begin
          if VerificationSiPieceDeDotation(Reference) then
              raise ExceptLGR.Create('La pièce de dotation est déjà passée. CorrectionImmos_SurCession',result.NumErreur,false,mtError,Result);
          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('update immos set mt_cession=0 where ((ecriture_cession=0)or(ecriture_cession is null)) and rebut=false and Terminee=false and ((date_cession between :DateDeb and :datefin)or(cession_dans_annee=true)) ');
          DMcorrections.QuCorrectionDossier.ParamByName('DateDeb').AsDate:=DateDebCorrection;
          DMcorrections.QuCorrectionDossier.ParamByName('Datefin').AsDate:=DateFinCorrection;
          DMcorrections.QuCorrectionDossier.ExecSQL;

          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('update immos set cession_dans_Annee=false where ((ecriture_cession=0)or(ecriture_cession is null)) and rebut=false and Terminee=false and ((date_cession between :DateDeb and :datefin)or(cession_dans_annee=true)) ');
          DMcorrections.QuCorrectionDossier.ParamByName('DateDeb').AsDate:=DateDebCorrection;
          DMcorrections.QuCorrectionDossier.ParamByName('Datefin').AsDate:=DateFinCorrection;
          DMcorrections.QuCorrectionDossier.ExecSQL;

          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('update immos set date_cession=null where ((ecriture_cession=0)or(ecriture_cession is null)) and rebut=false and Terminee=false and ((date_cession between :DateDeb and :datefin)or(cession_dans_annee=true)) ');
          DMcorrections.QuCorrectionDossier.ParamByName('DateDeb').AsDate:=DateDebCorrection;
          DMcorrections.QuCorrectionDossier.ParamByName('Datefin').AsDate:=DateFinCorrection;
          DMcorrections.QuCorrectionDossier.ExecSQL;
         end;
    end;

  end;//fin si confirmation
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  DMcorrections.QuCorrectionDossier.Close;
//  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;


Function CorrectionDesPointages_pasMemeTiers(DemandeConfirmation:boolean):texceptlgr;
var
infoIdPointage:integer;
//i:integer;
Confirmation:boolean;
ListeCaracteresCorrects:Tstringlist;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=9002;
        result.retour:=true;
 result.NomModule:='CorrectionDesPointages_pasMemeTiers';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
// if ((confirmation=false) and (DemandeConfirmation)) then
//   confirmation:=inputbox('Saisir le mot de passe','','***')=IntToStr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82);
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des pointages ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin



        PatienterAffich;
        //recherche des lignes dans pointage dont les écritures n'ont pas le même tiers
        DMcorrections.QuCorrectionPointage.Close;
        DMcorrections.QuCorrectionPointage.SQL.Clear;
        DMcorrections.QuCorrectionPointage.SQL.add('select * from pointage p join ecriture ed on ed.id=p.id_debit join ecriture ec on ec.id=p.id_credit where ed.tiers<>ec.tiers');
        DMcorrections.QuCorrectionPointage.open;
        if DMcorrections.QuCorrectionPointage.recordcount<>0 then
        begin
              infoIdPointage:=DMcorrections.QuCorrectionPointage.findfield('id').asinteger;
              raise ExceptLGR.Create('Problème dans les pointages, il y a des pointages sur des tiers différents',result.NumErreur,false,mtError,Result);
        end;
        PatienterFermer;

        PatienterAffich;
        //recherche des lignes dans pointage dont les écritures n'ont pas le même tiers
        DMcorrections.QuCorrectionPointage.Close;
        DMcorrections.QuCorrectionPointage.SQL.Clear;
        DMcorrections.QuCorrectionPointage.SQL.add('select * from pointage p join ecriture ed on ed.id=p.id_debit join ecriture ec on ec.id=p.id_credit where ec.creditSaisie<P.montant or ed.debitSaisie<P.montant');
        DMcorrections.QuCorrectionPointage.open;
        if DMcorrections.QuCorrectionPointage.recordcount<>0 then
        begin
              infoIdPointage:=DMcorrections.QuCorrectionPointage.findfield('id').asinteger;
              raise ExceptLGR.Create('Problème dans les pointages, il y a des montants de pointage supérieurs au montant d''une des écritures .',result.NumErreur,false,mtError,Result);
        end;
        PatienterFermer;

    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Arrêt sur le pointage :'+inttostr(infoIdPointage)+RetourChariotdouble+'Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  DMcorrections.QuCorrectionPointage.close;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;



Function CorrectionDesPointages(DemandeConfirmation:boolean):texceptlgr;
var
infosResteDc:TInfosResteDC;
//i:integer;
Confirmation:boolean;
ListeCaracteresCorrects:Tstringlist;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=9000;
        result.retour:=true;
 result.NomModule:='CorrectionDesPointages';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
// if ((confirmation=false) and (DemandeConfirmation)) then
//   confirmation:=inputbox('Saisir le mot de passe','','***')=IntToStr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82);
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des Restes à pointer ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin



        PatienterAffich;
        //suppression des lignes dans resteDc
        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('select * from resteDc');
        DMcorrections.QuCorrectionDossier.open;
        if DMcorrections.QuCorrectionDossier.recordcount<>0 then
        begin
          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('delete from resteDc');
          DMcorrections.QuCorrectionDossier.ExecSQL;
        end;
        PatienterFermer;

        PatienterAffich;
        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('select E.*,P.reference from ecriture E');
        DMcorrections.QuCorrectionDossier.SQL.add('join Piece P on (E.id_piece=P.id)');
        DMcorrections.QuCorrectionDossier.SQL.add('where not(E.id in (select id_ecriture from restedc))');
        DMcorrections.QuCorrectionDossier.SQL.add('and ((E.tiers<>'''') or (E.compte in (select compte from plancpt where pointable=true and collectif=false)))');
        DMcorrections.QuCorrectionDossier.open;
        DMcorrections.QuCorrectionDossier.first;
        PatienterFermer;

        PatienterAffich;
        if DMcorrections.QuCorrectionDossier.recordcount<>0 then
           begin
             ListeCaracteresCorrects:=Tstringlist.Create;
             ListeCaracteresCorrects.clear;
             ListeCaracteresCorrects:=DM_C_ListeCaractereCorrect_SQL;
           end;

        TableGereClose(DMcorrections.TaCorrection);   
        DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;
        DMcorrections.TaCorrection.TableName:='restedc.db'  ;
        TableGereOpen(DMcorrections.TaCorrection);


      while not(DMcorrections.QuCorrectionDossier.eof) do
        begin
          Initialise_TInfosResteDC(InfosResteDC);
          DeFiltrageDataSet(DMRech.TaResteDCRech);
          DMRech.TaResteDCRech.Refresh;

          InfosResteDC.ID:=MaxId_Query(DMRech.TaResteDCRech,'id');
          InfosResteDC.ID_Ecriture:=DMcorrections.QuCorrectionDossier.findfield('id').AsInteger;

          InfosResteDC.ID_Piece:=DMcorrections.QuCorrectionDossier.findfield('id_piece').AsInteger;
          InfosResteDC.Date:=DMcorrections.QuCorrectionDossier.findfield('Date').Asdatetime;
          InfosResteDC.Reference:=DMcorrections.QuCorrectionDossier.findfield('Reference').Asstring;
          if not empty(DMcorrections.QuCorrectionDossier.findfield('Tiers').Asstring)then
            InfosResteDC.Tiers:=DMcorrections.QuCorrectionDossier.findfield('Tiers').Asstring
          else
            InfosResteDC.Tiers:=DMcorrections.QuCorrectionDossier.findfield('compte').Asstring;
          InfosResteDC.Libelle:=DMcorrections.QuCorrectionDossier.findfield('Libelle').Asstring;
          InfosResteDC.Libelle:=str_remplacesouschaine(InfosResteDC.Libelle,chr(39),chr(34));
          InfosResteDC.Debit:=DMcorrections.QuCorrectionDossier.findfield('Debit').AsCurrency;
          InfosResteDC.Credit:=DMcorrections.QuCorrectionDossier.findfield('Credit').AsCurrency;
          if DMcorrections.QuCorrectionDossier.findfield('Debit').AsCurrency>0 then
            InfosResteDC.Sens:='D'
          else
            InfosResteDC.Sens:='C';
        InfosResteDC.Reste:=abs(DMcorrections.QuCorrectionDossier.findfield('Debit').AsCurrency+DMcorrections.QuCorrectionDossier.findfield('Credit').AsCurrency);

        DMcorrections.QuCorrectionPointage.close;
        DMcorrections.QuCorrectionPointage.SQL.Clear;
        DMcorrections.QuCorrectionPointage.SQL.add('select sum(montant)as Montant from pointage');
        if InfosResteDC.Sens='D' then
          DMcorrections.QuCorrectionPointage.SQL.add('where id_debit=:id')
        else
          DMcorrections.QuCorrectionPointage.SQL.add('where id_credit=:id');
        DMcorrections.QuCorrectionPointage.ParamByName('id').asinteger:=InfosResteDC.ID_Ecriture;
        DMcorrections.QuCorrectionPointage.Open; //
        if DMcorrections.QuCorrectionPointage.recordcount<>0 then
          InfosResteDC.Reste:=InfosResteDC.Reste-DMcorrections.QuCorrectionPointage.findfield('Montant').ascurrency;                                                                                                                                                 
        DMcorrections.QuCorrectionInsert.Close;

//        DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;
//        DMcorrections.TaCorrection.TableName:='restedc.db'  ;
//        TableGereOpen(DMcorrections.TaCorrection);
        TableGereStartTransaction(DMcorrections.TaCorrection);
        TableGereInsert(DMcorrections.TaCorrection);
         DMcorrections.TaCorrection.FindField('id').AsInteger:=InfosResteDC.ID;
         DMcorrections.TaCorrection.FindField('id_ecriture').AsInteger:=InfosResteDC.ID_Ecriture;
         DMcorrections.TaCorrection.FindField('id_piece').AsInteger :=InfosResteDC.ID_Piece;
         DMcorrections.TaCorrection.FindField('date').AsDateTime:=InfosResteDC.Date;
         DMcorrections.TaCorrection.FindField('Reference').AsString :=InfosResteDC.Reference;
         DMcorrections.TaCorrection.FindField('tiers').AsString:=InfosResteDC.Tiers;
         DMcorrections.TaCorrection.FindField('libelle').AsString:=InfosResteDC.Libelle;
         DMcorrections.TaCorrection.FindField('Debit').AsCurrency:=InfosResteDC.Debit;
         DMcorrections.TaCorrection.FindField('Credit').AsCurrency:=InfosResteDC.Credit;
         DMcorrections.TaCorrection.FindField('sens').AsString:=InfosResteDC.Sens;
         DMcorrections.TaCorrection.FindField('reste').AsCurrency :=InfosResteDC.Reste;
        TableGerePost(DMcorrections.TaCorrection);
        TableGereCommit(DMcorrections.TaCorrection);

//        DMcorrections.QuCorrectionInsert.SQL.Clear;                                                                                                                                                                                                        // Str_StringAcceptSQL(,ListeCaracteresCorrects)
//        DMcorrections.QuCorrectionInsert.SQL.add('insert into restedc');
//        DMcorrections.QuCorrectionInsert.SQL.add('(id,id_ecriture,id_piece,resteDc."Date",Reference,tiers,libelle,Debit,Credit,sens,reste)');
//        DMcorrections.QuCorrectionInsert.SQL.add('values('+inttostr(InfosResteDC.ID)+
//        ','+inttostr(InfosResteDC.ID_Ecriture)+','+inttostr(InfosResteDC.ID_Piece)+
//        ','''+DateInfos(InfosResteDC.Date).DatePourSQLStr+''','''+InfosResteDC.Reference+
//        ''','''+InfosResteDC.Tiers+''','''+Str_StringAcceptSQL(InfosResteDC.Libelle,ListeCaracteresCorrects)+''','+str_QueDesChiffresCurr_SQL(currtostr(InfosResteDC.Debit))+','+str_QueDesChiffresCurr_SQL(currtostr(InfosResteDC.Credit))+','''+InfosResteDC.Sens+''','+str_QueDesChiffresCurr_SQL(currtostr(InfosResteDC.reste))+')');
//        DMcorrections.QuCorrectionInsert.ExecSQL;

        DMcorrections.QuCorrectionDossier.next;
        end;
          Initialise_TInfosResteDC(InfosResteDC);
          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('select * from ResteDC ');
          DMcorrections.QuCorrectionDossier.SQL.add('where reste<0 ');
          DMcorrections.QuCorrectionDossier.open;

          if DMcorrections.QuCorrectionDossier.recordcount <> 0 then
            begin
              InfosResteDC.ID_Ecriture:=DMcorrections.QuCorrectionDossier.findfield('id_ecriture').asinteger;
              raise ExceptLGR.Create('Problème dans les pointages, il y a des restes < 0.',9002,false,mtError,Result);
            end;
        PatienterFermer;
        if DemandeConfirmation then
          Application.MessageBox(Pchar('Recalcul des pointages terminé'),'Attention',MB_ICONINFORMATION);
        DMcorrections.QuCorrectionDossier.close;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Arrêt sur l''Ecriture :'+inttostr(InfosResteDC.ID_Ecriture)+RetourChariotdouble+'Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result:=VerifCoherence_ResteDC_Ecriture;
      if result.retour then
        begin
          result.retour:=confirmation;
          result.NumErreur:=-1;
        end;
    end;
  DMcorrections.QuCorrectionDossier.close;
  DMcorrections.QuCorrectionInsert.close;
  DMcorrections.QuCorrectionPointage.close;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;


//Cette fonction sert à controler que tous les pointages inscris dans la table "pointages" correspondent
//à des écritures existantes et portent sur des comptes pointables
//si ce n'est pas le cas, il y a suppression du pointage en question.
Function VerificationsDesPointagesSurComptesPointables(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=8000;
        result.retour:=true;
 result.NomModule:='VerificationsDesPointagesSurComptesPointables';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
          if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
          if dmpieces=nil then dmpieces:=Tdmpieces.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des pointages ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
          //verification si tous les pointages de la tables pointages correspondent bien à des lignes
          //contenant des tiers ou des comptes pointables non collectifs.
        PatienterAffich;
//
//
//
           //trop long 
//          DMcorrections.QuCorrectionDossier.Close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.SQL.add('select P.id,P.id_debit,P.id_credit,P.montant from pointage P ');
//          DMcorrections.QuCorrectionDossier.SQL.add('where P.id_debit not in (select id from ecriture) ');
//          DMcorrections.QuCorrectionDossier.SQL.add('or P.id_credit not in (select id from ecriture)');
//          DMcorrections.QuCorrectionDossier.open;


//sur Debit
          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('select P.id,E.compte,P.id_debit,P.id_credit,P.montant from pointage P ');
          DMcorrections.QuCorrectionDossier.SQL.add('join ecriture E on (E.id=P.id_debit) ');
          DMcorrections.QuCorrectionDossier.SQL.add('join Plancpt Pct on (Pct.compte=e.compte)');
          DMcorrections.QuCorrectionDossier.SQL.add('where Pct.pointable=false');
          DMcorrections.QuCorrectionDossier.open;

          DMcorrections.QuCorrectionDossier.first;
          while not(DMcorrections.QuCorrectionDossier.eof)do
            Begin
              if not dmpieces.piece1.Verification_TvaDeclare_Pointage_new(true,DMcorrections.QuCorrectionDossier.findfield('ID_Debit').AsInteger,DMcorrections.QuCorrectionDossier.findfield('ID_Credit').AsInteger).retour then
                 raise ExceptLGR.Create('Verification_TvaDeclare_Pointage 1: le pointage entre les ecritures '+DMcorrections.QuCorrectionDossier.findfield('ID_Debit').Asstring+' - '+DMcorrections.QuCorrectionDossier.findfield('ID_Credit').Asstring+' rentre dans une période déclarée',Result.NumErreur,false,mtError,Result);
              //supprimer directement les pointages qui portent sur des comptes non pointables
              DMcorrections.QuCorrectionPointage.Close;
              DMcorrections.QuCorrectionPointage.SQL.Clear;
              DMcorrections.QuCorrectionPointage.SQL.add('Delete from pointage ');
              DMcorrections.QuCorrectionPointage.SQL.add('where id=:idPointage');
              DMcorrections.QuCorrectionPointage.ParamByName('idPointage').asinteger:=DMcorrections.QuCorrectionDossier.findfield('id').AsInteger;
              DMcorrections.QuCorrectionPointage.ExecSQL;
              ///
              DMcorrections.QuCorrectionDossier.next;
            end;

//sur Credit
          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('select P.id,E.compte,P.id_debit,P.id_credit,P.montant from pointage P ');
          DMcorrections.QuCorrectionDossier.SQL.add('join ecriture E on (E.id=P.id_credit) ');
          DMcorrections.QuCorrectionDossier.SQL.add('join Plancpt Pct on (Pct.compte=e.compte)');
          DMcorrections.QuCorrectionDossier.SQL.add('where Pct.pointable=false');
          DMcorrections.QuCorrectionDossier.open;

          DMcorrections.QuCorrectionDossier.first;
          while not(DMcorrections.QuCorrectionDossier.eof)do
            Begin
              if not dmpieces.piece1.Verification_TvaDeclare_Pointage_new(true,DMcorrections.QuCorrectionDossier.findfield('ID_Debit').AsInteger,DMcorrections.QuCorrectionDossier.findfield('ID_Credit').AsInteger).retour then
                 raise ExceptLGR.Create('Verification_TvaDeclare_Pointage 1: le pointage entre les ecritures '+DMcorrections.QuCorrectionDossier.findfield('ID_Debit').Asstring+' - '+DMcorrections.QuCorrectionDossier.findfield('ID_Credit').Asstring+' rentre dans une période déclarée',Result.NumErreur,false,mtError,Result);
              //supprimer directement les pointages qui portent sur des comptes non pointables
              DMcorrections.QuCorrectionPointage.Close;
              DMcorrections.QuCorrectionPointage.SQL.Clear;
              DMcorrections.QuCorrectionPointage.SQL.add('Delete from pointage ');
              DMcorrections.QuCorrectionPointage.SQL.add('where id=:idPointage');
              DMcorrections.QuCorrectionPointage.ParamByName('idPointage').asinteger:=DMcorrections.QuCorrectionDossier.findfield('id').AsInteger;
              DMcorrections.QuCorrectionPointage.ExecSQL;
              ///
              DMcorrections.QuCorrectionDossier.next;
            end;

          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('select P.id, P.ID_Debit,P.ID_Credit from pointage P');
          DMcorrections.QuCorrectionDossier.SQL.add('join ecriture E1 on (E1.id=P.id_debit)');
          DMcorrections.QuCorrectionDossier.SQL.add('join ecriture E2 on (E2.id=P.id_credit)');
{ isa  le  19/04/04 }DMcorrections.QuCorrectionDossier.SQL.add('where ((e1.Tiers<>E2.tiers) or (e1.compte<>e2.compte))');
       //   DMcorrections.QuCorrectionDossier.SQL.add('where ((e1.Tiers<>E2.tiers) and (e1.compte<>e2.compte))');
          DMcorrections.QuCorrectionDossier.open;

          DMcorrections.QuCorrectionDossier.first;
          while not(DMcorrections.QuCorrectionDossier.eof)do
            Begin
              //supprimer directement les pointages qui portent sur des tiers différents
              if not dmpieces.piece1.Verification_TvaDeclare_Pointage_new(true,DMcorrections.QuCorrectionDossier.findfield('ID_Debit').AsInteger,DMcorrections.QuCorrectionDossier.findfield('ID_Credit').AsInteger).retour then
                 raise ExceptLGR.Create('Verification_TvaDeclare_Pointage 2: le pointage entre les ecritures '+DMcorrections.QuCorrectionDossier.findfield('ID_Debit').Asstring+' - '+DMcorrections.QuCorrectionDossier.findfield('ID_Credit').Asstring+' rentre dans une période déclarée',Result.NumErreur,false,mtError,Result);
              DMcorrections.QuCorrectionPointage.Close;
              DMcorrections.QuCorrectionPointage.SQL.Clear;
              DMcorrections.QuCorrectionPointage.SQL.add('Delete from pointage ');
              DMcorrections.QuCorrectionPointage.SQL.add('where id=:idPointage');
              DMcorrections.QuCorrectionPointage.ParamByName('idPointage').asinteger:=DMcorrections.QuCorrectionDossier.findfield('id').AsInteger;
              DMcorrections.QuCorrectionPointage.ExecSQL;
              ///
              DMcorrections.QuCorrectionDossier.next;
            end;

    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
    DMcorrections.QuCorrectionDossier.Close;
    DMcorrections.QuCorrectionPointage.Close;
  PatienterFermer;
 result.GestMessageLGR.Enregistrement:=false;
end;
end;






procedure TDMcorrections.TaCorrectionFilterRecordLibelle(DataSet: TDataSet;
  var Accept: Boolean);
var
j:integer;
begin
if not((csDestroying)in DataSet.ComponentState) then
begin
accept:=false;
accept:=((empty(DataSet.findfield(ChampCourant).asstring))and((dataset as TTable).TableName<>dmrech.TaTrameLRech.TableName)and((dataset as TTable).TableName<>dmrech.TaTrameRech.TableName));
if TaListeFilterRecord<>nil then
  if TaListeFilterRecord.Count<>0 then
    begin
      for j:=0 to TaListeFilterRecord.Count-1 do
      begin
      if not accept then
        accept:= str_recherchesouschaine(DataSet.findfield(ChampCourant).asstring,chr(42)+chr(StrToIntDef(str_getstringelement(TaListeFilterRecord.strings[j],1,'='),0))+chr(42)).retour;
      end;
    end;
end;
end;

procedure TDMcorrections.TaCorrectionFilterRecordTiers(DataSet: TDataSet;
  var Accept: Boolean);
var
j:integer;
begin
if not((csDestroying)in DataSet.ComponentState) then
begin
accept:=false;
if TaListeFilterRecord<>nil then
  if TaListeFilterRecord.Count<>0 then
    begin
      for j:=0 to TaListeFilterRecord.Count-1 do
      begin
      if not accept then
        accept:= str_recherchesouschaine(DataSet.findfield(ChampCourant).asstring,chr(42)+chr(StrToIntDef(str_getstringelement(TaListeFilterRecord.strings[j],1,'='),0))+chr(42)).retour;
      end;
    end;
end;
end;

Function CorrectionDeLaBalance(MessageSourd:boolean;DemandeConfirmation:boolean):texceptlgr;
var
i:integer;
ParamGenerCptAffiche:TParamGenerCptAffiche;
Confirmation:boolean;
ListeExercices:Tstringlist;
RepertoireExocourant:string;
begin
try//finally
try//except
ListeExercices:=TStringList.Create;
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=5000;
result.retour:=true;
 result.NomModule:='CorrectionDeLaBalance';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=((not e.ExerciceCloture) or (e.TypeClient=cl_isa));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de la balance ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin

        PatienterAffich;

        ListeExercices:=RecupExerciceDossier_Tous(E.ID_Dos);
        if ListeExercices=nil then
          raise ExceptLGR.Create('',0,false,mtError);
        for i:=0 to ListeExercices.Count-1 do
          begin //pour tous les execices existants du dossier
              RepertoireExocourant:=str_getstringelement(ListeExercices.Strings[i],1,';');
              DMcorrections.QuCorrectionExo.Close;
              DMcorrections.QuCorrectionExo.SQL.Clear;
              DMcorrections.QuCorrectionExo.SQL.add('delete from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db"');
              DMcorrections.QuCorrectionExo.SQL.add('where (Debit_Report=0)and (Credit_Report=0)and(Debit_base=0)and(Credit_base=0)');
              DMcorrections.QuCorrectionExo.ExecSQL;
              PatienterFermer;

              PatienterAffich;
              DMcorrections.QuCorrectionExo.Close;
              DMcorrections.QuCorrectionExo.SQL.Clear;
              DMcorrections.QuCorrectionExo.SQL.add('select compte from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db"');
              DMcorrections.QuCorrectionExo.SQL.add('where not (compte in(select compte from "'+e.RepertoireDossier+'Plancpt"))');
              DMcorrections.QuCorrectionExo.open;

              DMcorrections.QuCorrectionExo.first;
              while not(DMcorrections.QuCorrectionExo.eof) do
                Begin
                  DMPlan.TaCompte.Insert;
                  DMPlan.InitialiseInsertionCompte(DMcorrections.QuCorrectionExo.findfield('compte').asstring,DMPlan.TaCompte);
                  DMPlan.TaCompte.FlushBuffers;
                  ParamGenerCptAffiche.Affiche:=true;
                  DMPlan.CreationAuto(DMcorrections.QuCorrectionExo.findfield('compte').asstring,ParamGenerCptAffiche);
                  DMcorrections.QuCorrectionExo.next;
                end;
          end;//fin pour tous les execices existants du dossier

        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if ((result.retour=false)and (not MessageSourd)) then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  DMcorrections.QuCorrectionExo.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

function CorrectionTotal(Gauge:TGauge;DemandeConfirmation:boolean):Texceptlgr;
var
Retour:TExceptLGR;
Liste:Tstringlist;
//,ListeBackup
i:integer;
ParamAffichageReindexation:TParamAffichageReindexation;
Confirmation:boolean;
MaxValue:integer;
begin
try//finally
try//except
 GestMessageLGR.ModeTrace := true;
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
 result.NomModule:='CorrectionTotal';
 result.GestMessageLGR.ModulePrincipal:='CorrectionTotal';
 result.GestMessageLGR.Enregistrement:=true;
 result.NomDossier:=e.NomDossier;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);

result.retour:=true;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=true;
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle général ?', mtConfirmation, [mbyes,mbno], 0) = mrYes;
if Confirmation then
    begin
ParamAffichageReindexation.AffichageModal:=true;
ParamAffichageReindexation.Affiche:=true;
ParamAffichageReindexation.SelectionListeTable:=nil;
ParamAffichageReindexation.dbProgram:=DMRech.TaGestDossier_OK.Database;
ParamAffichageReindexation.dbDossier:=DMRech.TaParam_DossierRech.Database;
ParamAffichageReindexation.dbExo:=DMRech.TaBalanceRech.Database;
ParamAffichageReindexation.SelectionListeTable:=TStringList.Create;
Liste := TStringList.Create;
  MaxValue:=260;
  GestionGauge(10,Gauge,MaxValue,0,'Contrôle générale');
  GestionGauge(10,Gauge,-1,-1,'Récupération tables Dossier');

Session.GetTableNames(DMRech.TaParam_DossierRech.DatabaseName, '*.db',true, False, Liste);
for i:=0 to Liste.count-1 do
begin
  if str_position_caseInsensitive('_QSQ',Liste.Strings[i])=0 then
    ParamAffichageReindexation.SelectionListeTable.Add(DMRech.TaParam_DossierRech.DatabaseName+';'+Liste.Strings[i]+'; 1');
end;
  GestionGauge(10,Gauge,-1,-1,'Récupération tables exercice');

Liste.Clear;
// Exercice
Session.GetTableNames(DMRech.TaBalanceRech.DatabaseName, '*.db',true, False, Liste);
for i:=0 to Liste.count-1 do
begin
  if str_position_caseInsensitive('_QSQ',Liste.Strings[i])=0 then
    ParamAffichageReindexation.SelectionListeTable.Add(DMRech.TaBalanceRech.DatabaseName+';'+Liste.Strings[i]+'; 1');
end;
  GestionGauge(10,Gauge,-1,-1,'Réindexation des tables');
Liste.Clear;
  try//je veux que le reste continue même si plantage sur la réindexation
            result:=ReindexationTableProc(ParamAffichageReindexation.SelectionListeTable,nil,false,false);
            GestionGauge(10,Gauge,-1,-1,'Optimisation de la taille des tables');
            result:=PackTableProc(ParamAffichageReindexation.SelectionListeTable,nil,false,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',0000,false,mtError);
   except
   end;
  GestionGauge(10,Gauge,-1,-1,'Contrôle des Tiers');
            result:=CorrectionDesTiers_ou_Libelle(false,nil,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',1000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle des libellés');
            result:=CorrectionDesTiers_ou_Libelle(true,nil,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',2000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle des codes tva');
            result:=CorrectionDesTvaCode(nil,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',3000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle de la balance');
            result:=CorrectionDeLaBalance(false,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',5000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle de la balance des mouvements');
            result:=CorrectionDeLaBalanceDesMouvements(false,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',5001,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle de la balance des tiers');
            result:=CorrectionDeLaBalanceDesTiers(false,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',5002,false,mtError);
//  GestionGauge(10,Gauge,-1,-1,'Contrôle de la balance des quantités');
//            if E.DateVersion<>'09/12/04-1.2.0.21' then
//              begin
//                result:=CorrectionDeLaBalanceDesQuantites(nil,false);    //procedure trop longue pour la mettre dans
//                if ((result.retour=false)and(result.NumErreur<>-1)) then
//                    raise ExceptLGR.Create('',5003,false,mtError);
//              end;                                                       // les contrôles automatiques
  GestionGauge(20,Gauge,-1,-1,'Contrôle des pièces');
            result:=CorrectionDesPieces(e.DatExoDebut,e.DatExoFin,false,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',4000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle des immobilisations (1)');
            result:=CorrectionDesImmosIncorrectes(e.DatExoDebut,e.DatExoFin,false,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',6000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle des immobilisations (2)');
            result:=CorrectionImmos_Initialisation(false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',6002,false,mtError);
//  GestionGauge(10,Gauge,-1,-1,'Contrôle des immobilisations (3)'); //** A mettre pour Version ****///// { isa  le  17/02/05 }
//            result:=CorrectionDesimmosSurRecalculAmort(nil,false,false,false);
//            if ((result.retour=false)and(result.NumErreur<>-1)) then
//                raise ExceptLGR.Create('',6003,false,mtError);
//  GestionGauge(10,Gauge,-1,-1,'Contrôle des immobilisations (1)');
//            result:=AppelRecalculGeneralImmos(false);
//            if ((result.retour=false)and(result.NumErreur<>-1)) then
//                raise ExceptLGR.Create('',7000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle de cohérence des Pointages');
            result:=VerificationsDesPointagesSurComptesPointables(false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',8000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Recalcul des pointages');
            result:=CorrectionDesPointages(false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',9000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Vérification des pointages Tiers');
            result:=CorrectionDesPointages_pasMemeTiers(false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',9002,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle de cohérence de la TVA');
            result:=VerifCoherence_HTVA(false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',10000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'contrôle de l''historique de la TVA');
            result:=ModificationTableH_TVA(false,false,false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',13000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle du plan comptable');
            result:=CorrectionPlanComptable(false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',15000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle de l''analytique');
            result:=CorrectionAnalytique(false);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',16000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle de la tva sur le type "D"');
            try
              result:=ControleTVASurType(false,false);
            finally
                if ((result.retour=false)and(result.NumErreur<>-1)and(result.NumErreur<>17001)) then
                  begin
                    GestionGauge(10,Gauge);
                    result:=CorrectionTVASurTypeD(false);
                    if ((result.retour=false)and(result.NumErreur<>-1)) then
                        raise ExceptLGR.Create('',17000,false,mtError);
                  end
                else  GestionGauge(10,Gauge);
            end;//fin finally
//  GestionGauge(10,Gauge,-1,-1,'Contrôle de la gestion du dérogatoire ');
//            result:=ControleAmort_DerogSurChangementExercice(gauge,false);
//            if ((result.retour=false)and(result.NumErreur<>-1)) then
//                raise ExceptLGR.Create('',19000,false,mtError);
  GestionGauge(10,Gauge,-1,-1,'Contrôle de la gestion du dérogatoire ');
            result:=coherenceImmosReport(gauge,false,1);
            if ((result.retour=false)and(result.NumErreur<>-1)) then
                raise ExceptLGR.Create('',21000,false,mtError);
//showmessage('Fin Contrôle général');
    end;
except
  result.retour:=false;
end;
finally
  GestionGauge(0,Gauge,0,0,'',false);
     if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

result.GestMessageLGR.Enregistrement:=false;
   GestMessageLGR.ModeTrace := false;
end;
end;


function CorrectionDesPieces(DateDebCorrection,DateFinCorrection:Tdate;DemandePeriode:boolean;DemandeConfirmation:boolean):TexceptLgr;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
      result.NumErreur:=4000;
      result.retour:=true;
 result.NomModule:='CorrectionDesPieces';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=not e.ExerciceCloture;
      if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
      if DMImport=nil then DMImport:=TDMImport.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des pièces ?', mtConfirmation, [mbYes,mbNo], 0) in[mrYes,mrok];
if Confirmation then
    begin

     Periode.DateDeb:=DateDebCorrection;
     Periode.DateFin:=DateFinCorrection;
     if DemandePeriode then
       begin
         try
             if Choix_Periode = nil then Choix_Periode:=TChoix_Periode.Create(Application.MainForm);
             Choix_Periode.EdDateDeb.OnExit:=LibClassObjetSender.SenderOnDateDebExit;
             Choix_Periode.EdDateFin.OnExit:=LibClassObjetSender.SenderOnDateFinExit;
             Initialise_ParamAffichPeriode(ParamAffichPeriode);
             Periode:=ChoixPeriodeAffich(Periode.DateDeb,Periode.DateFin,'Dates de prise en compte du contrôle!',ParamAffichPeriode);
         finally
           Choix_Periode.EdDateDeb.OnExit:=Choix_Periode.EdDateDebExit;
           Choix_Periode.EdDateFin.OnExit:= Choix_Periode.EdDateFinExit;
         end;//fin du try finally
       end
     else
        begin
         periode.Retour := true;
         periode.DateDeb := DateDebCorrection;
         periode.DateFin := DateFinCorrection;
        end;

        PatienterAffich;
        if periode.Retour then
         begin
            // Début de vérif sur les pièces
            try//except
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('select E.id_piece,E.id from ecriture E');
            DMcorrections.QuCorrectionDossier.SQL.add('where E.id_piece not in (select id from piece)');
            DMcorrections.QuCorrectionDossier.open;
            if DMcorrections.QuCorrectionDossier.recordcount<>0 then
              raise ExceptLGR.Create('L''écriture : '+DMcorrections.QuCorrectionDossier.findfield('id').asstring+' ne fait partie d''aucune pièce existante.',result.NumErreur,false,mtError,Result);
            except
              result.retour:=false;
            end;
////
            // Début de vérif sur les pièces
            try//except
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('select P.id,P.Reference from Piece P');
            DMcorrections.QuCorrectionDossier.SQL.add('where P.id not in (select id_piece from Ecriture)');
            DMcorrections.QuCorrectionDossier.open;
            if DMcorrections.QuCorrectionDossier.recordcount<>0 then
              raise ExceptLGR.Create('La pièce : '+DMcorrections.QuCorrectionDossier.findfield('Reference').asstring+' n''a aucune écriture.',result.NumErreur,false,mtError,Result);
            except
              result.retour:=false;
            end;
////
            // Début de vérif sur les pièces
            try//except
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('select distinct P.reference from ecriture E');
            DMcorrections.QuCorrectionDossier.SQL.add('join  piece P on (P.id=E.ID_piece)');
            DMcorrections.QuCorrectionDossier.SQL.add('join Tiers T on (E.Tiers=T.Tiers)');
            DMcorrections.QuCorrectionDossier.SQL.add('where ((E.compte is null)or(E.compte<>T.compte))');
            DMcorrections.QuCorrectionDossier.open;
            if DMcorrections.QuCorrectionDossier.recordcount<>0 then
              raise ExceptLGR.Create('La Pièce : '+DMcorrections.QuCorrectionDossier.findfield('Reference').asstring+' présente une incohérence. Contrôle des tiers dans les écritures.',result.NumErreur,false,mtError,Result);
            except
              result.retour:=false;
            end;
            // fin de vérif sur les pièces
            //Début de vérif sur les tiers
            try//except
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('select distinct T1.compte,T1.Tiers from Tiers T1');
            DMcorrections.QuCorrectionDossier.SQL.add('join Plancpt Pct on ((T1.compte=Pct.compte)and(Pct.collectif=false))');
            DMcorrections.QuCorrectionDossier.SQL.add('union all');
            DMcorrections.QuCorrectionDossier.SQL.add('select distinct T2.compte,T2.Tiers from tiers T2');
            DMcorrections.QuCorrectionDossier.SQL.add('where (T2.compte is null) or (T2.compte not in (select compte from plancpt))');
            DMcorrections.QuCorrectionDossier.open;
            if DMcorrections.QuCorrectionDossier.recordcount<>0 then
              raise ExceptLGR.Create('Contrôle de cohérence sur les comptes non collectifs ou non existants liés aux tiers .',result.NumErreur,false,mtError,Result);
            except
              result.retour:=false;
            end;
            //fin de vérif sur les tiers
            //Début de vérif sur les comptes collectifs
            try//except
            DMcorrections.QuCorrectionDossier.Close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.SQL.add('select Pct.compte,E.id,E.id_piece from plancpt Pct');
            DMcorrections.QuCorrectionDossier.SQL.add('join ecriture E on (Pct.compte=E.compte)');
            DMcorrections.QuCorrectionDossier.SQL.add('where ((E.Tiers is null)and (Pct.collectif=true))');
            DMcorrections.QuCorrectionDossier.open;
            if DMcorrections.QuCorrectionDossier.recordcount<>0 then
              raise ExceptLGR.Create('Contrôle sur comptes collectifs possédants des écritures directement.',result.NumErreur,false,mtError,Result);
            except
              result.retour:=false;
            end;
            DMcorrections.QuCorrectionDossier.close;
         end;//fin si periode ok
    end;//fin si confirmation
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  PatienterFermer;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.close;
  DMcorrections.TaCorrection.close;
  DMcorrections.QuCorrectionInsert.close;
  DMcorrections.Tacorrection.BeforePost :=nil;
  DMcorrections.Tacorrection.AfterPost :=nil;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;


Function CorrectionDeParamCpt(DemandeConfirmation:boolean):texceptlgr;
var
//i:integer;
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=0;
        result.retour:=true;
 result.NomModule:='CorrectionDeParamCpt';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de ParamCpt ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin

        PatienterAffich;

        DMcorrections.QuCorrectionProgram.Close;
        DMcorrections.QuCorrectionProgram.SQL.Clear;
        DMcorrections.QuCorrectionProgram.SQL.add('select * from paramcpt_export');
        DMcorrections.QuCorrectionProgram.open;
        PatienterFermer;

        DMcorrections.QuCorrectionInsert.DatabaseName:=DMcorrections.QuCorrectionProgram.DatabaseName;
        with DMcorrections.QuCorrectionProgram do
        while not(eof) do
          Begin
            DMcorrections.QuCorrectionInsert.Close;
            DMcorrections.QuCorrectionInsert.SQL.Clear;
            DMcorrections.QuCorrectionInsert.SQL.add('insert into paramcpt');
            DMcorrections.QuCorrectionInsert.SQL.add('(Regime,Famille,Rac1,Rac2,Rac3,Rac4,Rac5,Rac6)');
            DMcorrections.QuCorrectionInsert.SQL.add('values('''+findfield('Regime').asstring+''','+findfield('Famille').asstring+','''+findfield('Rac1').asstring+''','''+findfield('Rac2').asstring+''','''+findfield('Rac3').asstring+''','''+findfield('Rac4').asstring+''','''+findfield('Rac5').asstring+''','''+findfield('Rac6').asstring+''')');
            DMcorrections.QuCorrectionInsert.ExecSQL;
            next;
          end;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionProgram.close;
  DMcorrections.QuCorrectionInsert.close;
  PatienterFermer;
   result.GestMessageLGR.Enregistrement:=false;
end;
end;

Function CorrectionDossierChangementDateCloture(Exo,ExoAncien:string;DemandeConfirmation:boolean):texceptlgr;
var
//infosResteDc:TInfosResteDC;
//i:integer;
Confirmation:boolean;
ListeExercices:Tstringlist;
RepertoireExocourant,RepertoireExoNMoins1:string;
i:integer;
begin
try//finally
try//except
ListeExercices:=TStringList.Create;
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=0;
        result.retour:=true;
 result.NomModule:='CorrectionDossierChangementDateCloture';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=true;
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le changement de référence suite au changement du code exercice ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
          if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
          //verification si tous les pointages de la tables pointages correspondent bien à des lignes
          //contenant des tiers ou des comptes pointables non collectifs.
        PatienterAffich;
        
        ListeExercices:=RecupExerciceDossier_tous(E.ID_Dos);
//        ListeExercices:=RecupExerciceDossier(E.ID_Dos);
        if ((ListeExercices=nil)or(ListeExercices.Count=0)) then
          raise ExceptLGR.Create('',0,false,mtError);

        if ExoAncien='' then ExoAncien:=InputBox('Saisir le code Exercice à changer','Le code exo courant est : '+e.ExerciceSaisie,'');
        if ExoAncien='' then   raise ExceptLGR.Create('',result.NumErreur,false,mtError,Result);
        if exo='' then exo:=InputBox('Saisir le nouveau code Exercice','Le code exo courant est : '+e.ExerciceSaisie,'');
        if Exo='' then   raise ExceptLGR.Create('',result.NumErreur,false,mtError,Result);

          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('select Reference from piece where substring(Reference from 3 for 2)='''+exo+'''');
          DMcorrections.QuCorrectionDossier.open;
          if DMcorrections.QuCorrectionDossier.recordcount<>0 then
            raise ExceptLGR.Create('Attention, des pièces sont déjà créées à partir du code Exercice '+exo,result.NumErreur,true,mtError,Result);


          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('select Reference from piece where substring(Reference from 3 for 2)='''+ExoAncien+'''');
          DMcorrections.QuCorrectionDossier.open;

          DMcorrections.QuCorrectionDossier.first;
          while not DMcorrections.QuCorrectionDossier.eof do
            Begin
               TableGereStartTransaction(dmrech.TaPieceRech);//StartTransaction dossier
               TableGereStartTransaction(dmrech.TaBalanceRech);//StartTransaction exercice

               //Dossier
               DMcorrections.TaCorrection.Active:=false;
               DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;

               //Table ResteDC
               DMcorrections.TaCorrection.Active:=false;
               DMcorrections.TaCorrection.tablename:=dmrech.TaResteDCRech.TableName;
               filtrageDataset(DMcorrections.TaCorrection,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
               DMcorrections.TaCorrection.first;
               while not DMcorrections.TaCorrection.eof do
                 Begin
                     tablegereedit(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.FindField('Reference').asstring:=copy(DMcorrections.TaCorrection.FindField('Reference').asstring,1,2)+Exo+copy(DMcorrections.TaCorrection.FindField('Reference').asstring,5,5);
                     TableGerePost(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.next;
                 end;

               //Table EchEmp
               DMcorrections.TaCorrection.Active:=false;
               DMcorrections.TaCorrection.tablename:=dmrech.TaEchEmpRech.TableName;
               filtrageDataset(DMcorrections.TaCorrection,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
               DMcorrections.TaCorrection.first;
               while not DMcorrections.TaCorrection.eof do
                 Begin
                     tablegereedit(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.FindField('Reference').asstring:=copy(DMcorrections.TaCorrection.FindField('Reference').asstring,1,2)+Exo+copy(DMcorrections.TaCorrection.FindField('Reference').asstring,5,5);
                     TableGerePost(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.next;
                 end;

               //Table H_TVA
               DMcorrections.TaCorrection.Active:=false;
               DMcorrections.TaCorrection.tablename:=dmrech.TaH_TVARech.TableName;
               filtrageDataset(DMcorrections.TaCorrection,'reference_OD='''+DMcorrections.QuCorrectionDossier.FindField('reference').asstring+'''');
               DMcorrections.TaCorrection.first;
               while not DMcorrections.TaCorrection.eof do
                 Begin
                     tablegereedit(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.FindField('reference_OD').asstring:=copy(DMcorrections.TaCorrection.FindField('reference_OD').asstring,1,2)+Exo+copy(DMcorrections.TaCorrection.FindField('reference_OD').asstring,5,5);
                     TableGerePost(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.next;
                 end;

               //Table H_PieceTVA
               DMcorrections.TaCorrection.Active:=false;
               DMcorrections.TaCorrection.tablename:=dmrech.TaH_PieceTvaRech.TableName;
               filtrageDataset(DMcorrections.TaCorrection,'reference_OD='''+DMcorrections.QuCorrectionDossier.FindField('reference').asstring+'''');
               DMcorrections.TaCorrection.first;
               while not DMcorrections.TaCorrection.eof do
                 Begin
                     tablegereedit(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.FindField('reference_OD').asstring:=copy(DMcorrections.TaCorrection.FindField('reference_OD').asstring,1,2)+Exo+copy(DMcorrections.TaCorrection.FindField('reference_OD').asstring,5,5);
                     TableGerePost(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.next;
                 end;


               //Exercice en fonction du code ExoAncien
               DMcorrections.TaCorrection.Active:=false;
               DMcorrections.TaCorrectionExo.Active:=false;
              RepertoireExocourant:='';
              for i:=0 to ListeExercices.count-1 do
                Begin
                  if str_getstringelement(ListeExercices.Strings[i],4,';')=ExoAncien then
                    RepertoireExocourant:=str_getstringelement(ListeExercices.Strings[i],1,';');
                end;
                
              if empty(RepertoireExocourant)then
              if Application.MessageBox(Pchar('Il n''y a pas de base de données pour l''exo '+ExoAncien+', Voulez-vous continuer'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                raise ExceptLGR.Create('Problème récupération base exercice',result.NumErreur,true,mtError,Result);

               DMcorrections.TaCorrectionExo.DatabaseName:=RepertoireExocourant;

               if not empty(RepertoireExocourant) then
                 Begin
                     //Table ChargeAPayer
                     DMcorrections.TaCorrectionExo.Active:=false;
                     DMcorrections.TaCorrectionExo.tablename:=dmrech.TaChargeAPayerRech.TableName;
                     filtrageDataset(DMcorrections.TaCorrectionExo,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
                     DMcorrections.TaCorrectionExo.first;
                     while not DMcorrections.TaCorrectionExo.eof do
                       Begin
                           tablegereedit(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.FindField('Reference').asstring:=copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,1,2)
                             +Exo+copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,5,5);
                           TableGerePost(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.next;
                       end;


                     //Table ChargesRepartir
                     DMcorrections.TaCorrectionExo.Active:=false;
                     DMcorrections.TaCorrectionExo.tablename:=dmrech.TaChargesRepartirRech.TableName;
                     filtrageDataset(DMcorrections.TaCorrectionExo,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
                     DMcorrections.TaCorrectionExo.first;
                     while not DMcorrections.TaCorrectionExo.eof do
                       Begin
                           tablegereedit(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.FindField('Reference').asstring:=copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,1,2)
                              +Exo+copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,5,5);
                           TableGerePost(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.next;
                       end;

                     //Table TaDepensesEntreprisesRech
                     DMcorrections.TaCorrectionExo.Active:=false;
                     DMcorrections.TaCorrectionExo.tablename:=dmrech.TaDepensesEntreprisesRech.TableName;
                     filtrageDataset(DMcorrections.TaCorrectionExo,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
                     DMcorrections.TaCorrectionExo.first;
                     while not DMcorrections.TaCorrectionExo.eof do
                       Begin
                           tablegereedit(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.FindField('Reference').asstring:=copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,1,2)
                              +Exo+copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,5,5);
                           TableGerePost(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.next;
                       end;

                     //Table Immos_clot
                     DMcorrections.TaCorrectionExo.Active:=false;
                     DMcorrections.TaCorrectionExo.tablename:=dmrech.TaImmos_clotRech.TableName;
                     filtrageDataset(DMcorrections.TaCorrectionExo,'Reference_OP='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
                     DMcorrections.TaCorrectionExo.first;
                     while not DMcorrections.TaCorrectionExo.eof do
                       Begin
                           tablegereedit(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.FindField('Reference_OP').asstring:=copy(DMcorrections.TaCorrectionExo.FindField('Reference_OP').asstring,1,2)
                             +Exo+copy(DMcorrections.TaCorrectionExo.FindField('Reference_OP').asstring,5,5);
                           TableGerePost(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.next;
                       end;

                     //Table PCA
                     DMcorrections.TaCorrectionExo.Active:=false;
                     DMcorrections.TaCorrectionExo.tablename:=dmrech.TaPCARech.TableName;
                     filtrageDataset(DMcorrections.TaCorrectionExo,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
                     DMcorrections.TaCorrectionExo.first;
                     while not DMcorrections.TaCorrectionExo.eof do
                       Begin
                           tablegereedit(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.FindField('Reference').asstring:=copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,1,2)
                             +Exo+copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,5,5);
                           TableGerePost(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.next;
                       end;

                     //Table Provisions
                     DMcorrections.TaCorrectionExo.Active:=false;
                     DMcorrections.TaCorrectionExo.tablename:=dmrech.TaProvisionsRech.TableName;
                     filtrageDataset(DMcorrections.TaCorrectionExo,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
                     DMcorrections.TaCorrectionExo.first;
                     while not DMcorrections.TaCorrectionExo.eof do
                       Begin
                           tablegereedit(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.FindField('Reference').asstring:=copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,1,2)
                             +Exo+copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,5,5);
                           TableGerePost(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.next;
                       end;

                     //Table Stock
                     DMcorrections.TaCorrectionExo.Active:=false;
                     DMcorrections.TaCorrectionExo.tablename:=dmrech.TaStockRech.TableName;
                     filtrageDataset(DMcorrections.TaCorrectionExo,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
                     DMcorrections.TaCorrectionExo.first;
                     while not DMcorrections.TaCorrectionExo.eof do
                       Begin
                           tablegereedit(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.FindField('Reference').asstring:=copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,1,2)
                             +Exo+copy(DMcorrections.TaCorrectionExo.FindField('Reference').asstring,5,5);
                           TableGerePost(DMcorrections.TaCorrectionExo);
                           DMcorrections.TaCorrectionExo.next;
                       end;
                 end;

               //Traiter la pièce courante //
               DMcorrections.TaCorrection.Active:=false;
               DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;

               DMcorrections.TaCorrection.tablename:=dmrech.TaPieceRech.TableName;
               filtrageDataset(DMcorrections.TaCorrection,'Reference='''+DMcorrections.QuCorrectionDossier.FindField('Reference').asstring+'''');
               if (not DMcorrections.TaCorrection.Locate('Reference',DMcorrections.QuCorrectionDossier.FindField('Reference').asstring,[]))
               then
                 abort
               else
                 begin
                     tablegereedit(DMcorrections.TaCorrection);
                     DMcorrections.TaCorrection.FindField('Reference').asstring:=copy(DMcorrections.TaCorrection.FindField('Reference').asstring,1,2)+Exo+copy(DMcorrections.TaCorrection.FindField('Reference').asstring,5,5);
                     TableGerePost(DMcorrections.TaCorrection);
                 end;
               DMcorrections.QuCorrectionDossier.next;
               tablegereCommit(dmrech.TaPieceRech);//commit dossier
               tablegereCommit(dmrech.TaBalanceRech);//commit exercice
            end;

    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
    Initialise_TStringlist(ListeExercices);
  DMcorrections.QuCorrectionDossier.Close;
  DMcorrections.QuCorrectionPointage.Close;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;

function VerifSiBalanceVerrouillee(DateDebCorrection,DateFinCorrection:Tdate):TexceptLgr;
var
Confirmation:boolean;
count:integer;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
 result.NomModule:='VerifSiBalanceVerrouillee';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
  result.NumErreur:=0000;
  result.retour:=false;
  PatienterAffich;
  if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
  if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);
  DeFiltrageDataSet(dmrech.TaBalanceRech);
  result.retour:=dmrech.TaBalanceRech.RecordCount<>0;//si balance non vide
  if result.retour then
  begin
  DMcorrections.QuCorrectionDossier.Close;
  DMcorrections.QuCorrectionDossier.SQL.Clear;
  DMcorrections.QuCorrectionDossier.SQL.add(' select * from "'+e.RepertoireExercice+'Balance" B1 ');
  DMcorrections.QuCorrectionDossier.SQL.add(' where (B1.Debit_Report<>0 ');
  DMcorrections.QuCorrectionDossier.SQL.add(' or Credit_Report<>0) ');
  DMcorrections.QuCorrectionDossier.Open;
  count:=DMcorrections.QuCorrectionDossier.RecordCount;//récupérer le nombre de compte qui ont un report dans la balanc
  //pour le comparer avec la requete suivante.
  //si le count=le recordcount suivant alors la balance n'est pas verrouillée car elle ne possède que des comptes
  //soit pointable soit relié à des codes tva.
  end;
  if result.retour then
  begin  //ici je compte tous les comptes de la balance qui sont ou pointable ou lié à un code tva
  DMcorrections.QuCorrectionDossier.Close;
  DMcorrections.QuCorrectionDossier.SQL.Clear;
  DMcorrections.QuCorrectionDossier.SQL.add(' select * from "'+e.RepertoireExercice+'Balance" B1 ');
  DMcorrections.QuCorrectionDossier.SQL.add(' join Plancpt Pct on (B1.compte=Pct.compte) where ');
  DMcorrections.QuCorrectionDossier.SQL.add(' (B1.Debit_Report<>0 ');
  DMcorrections.QuCorrectionDossier.SQL.add(' or Credit_Report<>0) ');
  DMcorrections.QuCorrectionDossier.SQL.add(' and(( Pct.pointable=true)or(Pct.compte in (select compte from TvaCode))) ');
  DMcorrections.QuCorrectionDossier.Open;
  result.retour:=(count<>DMcorrections.QuCorrectionDossier.RecordCount);
  //si le nombre de compte dans la balance est différent du nombre de compte de la balance (pointable ou lié à un code tva)
  //alors je continue ma vérification, sinon la balance n'est pas verrouillée.
  end;
  if result.retour then
  begin
  DMcorrections.QuCorrectionDossier.Close;
  DMcorrections.QuCorrectionDossier.SQL.Clear;
  DMcorrections.QuCorrectionDossier.SQL.add(' select B1.compte,B1.Debit_Report,B1.Credit_Report from "'+e.RepertoireExercice+'Balance" B1 ');
  DMcorrections.QuCorrectionDossier.SQL.add(' join Plancpt Pct on ((B1.compte=Pct.compte)and(Pct.Pointable=false)) where ');
  DMcorrections.QuCorrectionDossier.SQL.add(' (B1.Debit_Report<>0 ');
  DMcorrections.QuCorrectionDossier.SQL.add(' or Credit_Report<>0) ');
  DMcorrections.QuCorrectionDossier.SQL.add(' and not(Pct.Debit_Deb<>0 or Pct.Credit_Deb<>0)and(Pct.compte not in (select compte from TvaCode)) ');
  DMcorrections.QuCorrectionDossier.Open;
  result.retour:=DMcorrections.QuCorrectionDossier.RecordCount=0;
  end;
except
  result.retour:=false;
end;
finally
  PatienterFermer;
//    try
//    if result.retour=false then
//        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
//    except
//    end;
//  DMcorrections.QuCorrectionDossier.Close;
result.GestMessageLGR.Enregistrement:=false;
end;
end;


function VerifSiReportDerogatoire(DateDebCorrection,DateFinCorrection:Tdate):TexceptLgr;
var
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
 result.NomModule:='VerifSiReportDerogatoire';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
  result.NumErreur:=0;
  result.retour:=false;
  PatienterAffich;
  if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);

  DMcorrections.QuCorrectionDossier.Close;
  DMcorrections.QuCorrectionDossier.SQL.Clear;
//  DMcorrections.QuCorrectionDossier.SQL.add('select Sum(Amort_derog)as Amort_derog, sum(choix-eco)as derog from');
  DMcorrections.QuCorrectionDossier.SQL.add('select Sum(Amort_derog)as Amort_derog from');
  DMcorrections.QuCorrectionDossier.SQL.add('Immos I');
  DMcorrections.QuCorrectionDossier.Open;
  if DMcorrections.QuCorrectionDossier.RecordCount<>0 then
    result.retour:=DMcorrections.QuCorrectionDossier.findfield('Amort_derog').AsCurrency<>0;
//    result.retour:=((DMcorrections.QuCorrectionDossier.findfield('Amort_derog').AsCurrency<>0)or(DMcorrections.QuCorrectionDossier.findfield('derog').AsCurrency<>0));
except
  result.retour:=false;
end;
finally
  PatienterFermer;
//    try
//    if result.retour=false then
//        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
//    except
//    end;
  DMcorrections.QuCorrectionDossier.Close;
 result.GestMessageLGR.Enregistrement:=false;
end;
end;


Function CorrectionDesTiers_ou_Libelle(Tiers:Boolean;Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
LibelleCorrect:string;
ListeTable,{ListeCaractereCorrects,}ListeExercices:Tstringlist;
i:integer;
Confirmation:boolean;
MessageTmp,RepertoireExocourant:string;
tableExo:TTable;
begin
try//finally
try//except
 confirmation:=true;
 tableExo:=TTable.Create(application.MainForm);
Initialise_ExceptLGR(result,GestMessageLGR);
        if tiers then result.NumErreur:=2000
        else result.NumErreur:=1000;
        result.retour:=true;
   result.NomModule:='CorrectionDesLibelle_ou_Tiers';
 result.NomDossier:=e.NomDossier;
   result.GestMessageLGR.Enregistrement:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
 if tiers then
   MessageTmp:='Voulez_vous lancer le contrôle des tiers ?'
 else
   MessageTmp:='Voulez_vous lancer le contrôle des libellés ?';
// confirmation:=((((e.AccesOuverture)and(not e.ExerciceCloture)))or(((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'))));
 if ((confirmation=false) and (DemandeConfirmation)) then
   confirmation:=inputbox('Saisir le mot de passe','','***')=IntToStr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr(MessageTmp, mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin

        ListeExercices:=RecupExerciceDossier_Tous(E.ID_Dos);
        if ListeExercices=nil then
          raise ExceptLGR.Create('',0000,false,mtError);

        PatienterAffich;
        ListeTable:=TStringList.Create;
        ListeTable.Clear;
        DMcorrections.TaListeFilterRecord.clear;
        DMcorrections.TaListeFilterRecord:=DM_C_ListeCaractereCorrect_SQL;
        // travail sur table dossier
        if tiers then
            begin
  GestionGauge(10,gauge,30,0,'Contrôle des tiers sur dossier');
                if ((tiers)and (not((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')))) then
                  TableGereStartTransaction(DMcorrections.QuCorrectionDossier);
                if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+DMrech.TaPieceRech.TableName)then
                  begin//si répertoire rempli (pour parer à un problème de suppression de dossier)
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTiersRech.TableName+';Tiers');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaEcritureRech.TableName+';Tiers');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaModelRech.TableName+';compte');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaModelLRech.TableName+';compte');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaPieceRech.TableName+';compte');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaResteDCRech.TableName+';Tiers');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTrameRech.TableName+';compte');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTrameLRech.TableName+';compte');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTvaCodeRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaPiece_ImportRech.TableName+';compte');
                  end;
            end
        else
            begin
  GestionGauge(10,gauge,30,0,'Contrôle des Libellés sur dossier');
                if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+DMrech.TaPieceRech.TableName)then
                  begin//si répertoire rempli (pour parer à un problème de suppression de dossier)
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTiersRech.TableName+';Nom');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaEcritureRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaImmosRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaModelRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaModelLRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaPieceRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaPlanCptRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaResteDCRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTrameRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTrameLRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTvaCodeRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaTa_Affect_AtelierRech.TableName+';Libelle');
                    ListeTable.Add(DMcorrections.QuCorrectionDossier.DatabaseName+';'+DMrech.TaPiece_ImportRech.TableName+';Libelle');
                  end;
            end;
        for i:=0 to ListeTable.count-1 do
        begin
        LibelleCorrect:='';
        DMcorrections.TaCorrection.close;
        DMcorrections.TaCorrection.OnFilterRecord:=nil;
        DMcorrections.TaCorrection.DatabaseName:=str_getstringelement(ListeTable.Strings[i],1,';');
        DMcorrections.TaCorrection.TableName:=str_getstringelement(ListeTable.Strings[i],2,';');
        DMcorrections.ChampCourant:=str_getstringelement(ListeTable.Strings[i],3,';');
        if tiers then
          DMcorrections.TaCorrection.OnFilterRecord:=DMcorrections.TaCorrectionFilterRecordTiers
        else
          DMcorrections.TaCorrection.OnFilterRecord:=DMcorrections.TaCorrectionFilterRecordLibelle;
        FiltrageDataSet(DMcorrections.TaCorrection,'');//permet de déclencher le filter Record
        DMcorrections.TaCorrection.first;
        while not(DMcorrections.TaCorrection.Eof)do
          begin
            DeFiltrageDataSet(DMRech.TaTiersRech);
            tablegereEdit(DMcorrections.TaCorrection);
            LibelleCorrect:=Str_StringAcceptSQL(DMcorrections.TaCorrection.findfield(DMcorrections.ChampCourant).asstring,DMcorrections.TaListeFilterRecord);
            if (tiers)and (uppercase(DMcorrections.TaCorrection.TableName)='TIERS.DB')and(uppercase(DMcorrections.ChampCourant)='TIERS')and
            (DMRech.TaTiersRech.Locate('TIERS',libellecorrect,[]))then
              begin //tiers avec le codetiers existant,impossible de modifier le tiers courant, il faut le supprimer
                 TableGereCancel(DMcorrections.TaCorrection);
                 TableGereDelete(DMcorrections.TaCorrection);
              end
            else
            if empty(LibelleCorrect) then
               begin
                 if tiers then
                   raise ExceptLGR.Create('Le Tiers '+DMcorrections.TaCorrection.findfield(DMcorrections.ChampCourant).asstring+' n''est pas correct',1000,true,mtError,result)
                 else
                   if ((DMcorrections.TaCorrection.TableName<>DMrech.TaTrameLRech.TableName)and(DMcorrections.TaCorrection.TableName<>DMrech.TaTrameRech.TableName)) then
                     LibelleCorrect:='Libellé vide';
               end;

            if DMcorrections.TaCorrection.State =dsedit then
              begin
                  DMcorrections.TaCorrection.findfield(DMcorrections.ChampCourant).asstring:= LibelleCorrect;
                  try
                  TableGerePost(DMcorrections.TaCorrection);
                  except
                    abort;
                  end;
              end;
            //DMcorrections.TaCorrection.next;
            //je ne fais pas de next car la table
            //est automatiquement refiltrée
          end;
        end;


        // ***** travail sur table Exercice *****
        /////////////////////////////////////////

        ListeTable.Clear;
        
        for i:=0 to ListeExercices.Count-1 do
          begin//pour tous les exercices du dossier courant
            RepertoireExocourant:=str_getstringelement(ListeExercices.Strings[i],1,';');
            if tiers then
                begin
  GestionGauge(10,gauge,-1,-1,'Contrôle des tiers sur Exercices');
                    if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaBalanceTiersRech.TableName)then
                      ListeTable.Add(RepertoireExocourant+';'+DMrech.TaBalanceTiersRech.TableName+';Tiers');
                end
            else
                begin
  GestionGauge(10,gauge,-1,-1,'Contrôle des Libellés sur Exercices');

                    if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaChargesRepartirRech.TableName)then
                        begin //si répertoire rempli (pour parer à un problème de suppression de dossier)
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaChargesRepartirRech.TableName)then
                               ListeTable.Add(RepertoireExocourant+';'+DMrech.TaChargesRepartirRech.TableName+';Designation');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaImmosRech.TableName)then
                              ListeTable.Add(RepertoireExocourant+';'+DMrech.TaImmosRech.TableName+';Libelle');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaImmos_ClotRech.TableName)then
                               ListeTable.Add(RepertoireExocourant+';'+DMrech.TaImmos_ClotRech.TableName+';Designation');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaProvisionsRech.TableName)then
                               ListeTable.Add(RepertoireExocourant+';'+DMrech.TaProvisionsRech.TableName+';Designation');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaStockRech.TableName)then
                               ListeTable.Add(RepertoireExocourant+';'+DMrech.TaStockRech.TableName+';Designation');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaChargeAPayerRech.TableName)then
                              ListeTable.Add(RepertoireExocourant+';'+DMrech.TaChargeAPayerRech.TableName+';Libelle');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaDepensesEntreprisesRech.TableName)then
                               ListeTable.Add(RepertoireExocourant+';'+DMrech.TaDepensesEntreprisesRech.TableName+';Libelle');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaPCARech.TableName)then
                               ListeTable.Add(RepertoireExocourant+';'+DMrech.TaPCARech.TableName+';Libelle');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaTa_Compte_AtelierRech.TableName)then
                               ListeTable.Add(RepertoireExocourant+';'+DMrech.TaTa_Compte_AtelierRech.TableName+';Libelle');
                            if FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+DMrech.TaTa_Ecriture_AtelierRech.TableName)then
                               ListeTable.Add(RepertoireExocourant+';'+DMrech.TaTa_Ecriture_AtelierRech.TableName+';Libelle');
                        end;
                end;
          end;//fin pour tous les exercices du dossier courant
//
        for i:=0 to ListeTable.count-1 do
        begin
            LibelleCorrect:='';

            tableExo.close;
            tableExo.OnFilterRecord:=nil;
            RepertoireExocourant:=str_getstringelement(ListeTable.Strings[i],1,';');
            if (RepertoireExocourant<>DMBD.DbNameExoN1.Directory)then
              begin
                tablegerecommit(tableExo);
                (DMBD.InitBDExo_N1(ExcludeTrailingPathDelimiter(RepertoireExocourant),false));
              end;

            if(RepertoireExocourant=DMRech.TaBalanceRech.Database.Directory)then
              tableExo.DatabaseName:=DMRech.TaBalanceRech.Database.DatabaseName
            else
              tableExo.DatabaseName:=DMBD.DbNameExoN1.DatabaseName;

            tableExo.TableName:=str_getstringelement(ListeTable.Strings[i],2,';');
            DMcorrections.ChampCourant:=str_getstringelement(ListeTable.Strings[i],3,';');
            if tiers then
              begin
              tableExo.OnFilterRecord:=DMcorrections.TaCorrectionFilterRecordTiers;
              if not((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')) then
                 TableGereStartTransaction(tableExo);
              end
            else
              tableExo.OnFilterRecord:=DMcorrections.TaCorrectionFilterRecordLibelle;


            FiltrageDataSet(tableExo,'');//permet de déclencher le filter Record

            tableExo.first;
            while not(tableExo.Eof)do
              begin
                tablegereEdit(tableExo);
                LibelleCorrect:=Str_StringAcceptSQL(tableExo.findfield(DMcorrections.ChampCourant).asstring,DMcorrections.TaListeFilterRecord);
                if empty(LibelleCorrect) then
                   begin
                     if tiers then
                       raise ExceptLGR.Create('Le Tiers '+tableExo.findfield(DMcorrections.ChampCourant).asstring+' n''est pas correct',1000,true,mtError,result)
                     else
                       LibelleCorrect:='Libellé vide';
                   end;
                tableExo.findfield(DMcorrections.ChampCourant).asstring:= LibelleCorrect;
                try
                TableGerePost(tableExo);
                except
                abort;
                end;
                //DMcorrections.TaCorrectionExoCourant.next;
                //je ne fais pas de next car la table
                //est automatiquement refiltrée
              end;
        end
        //begin
//            LibelleCorrect:='';
//
//            DMcorrections.TaCorrectionExoCourant.close;
//            DMcorrections.TaCorrectionExoCourant.OnFilterRecord:=nil;
//            RepertoireExocourant:=str_getstringelement(ListeTable.Strings[i],1,';');
//            if (RepertoireExocourant<>DMBD.DbNameExoN1.Directory)then
//              begin
//                tablegerecommit(DMcorrections.TaCorrectionExoCourant);
//                (DMBD.InitBDExo_N1(ExcludeTrailingPathDelimiter(RepertoireExocourant),false));
//              end;
//
//            DMcorrections.TaCorrectionExoCourant.DatabaseName:=DMBD.DbNameExoN1.DatabaseName;
//            DMcorrections.TaCorrectionExoCourant.TableName:=str_getstringelement(ListeTable.Strings[i],2,';');
//            DMcorrections.ChampCourant:=str_getstringelement(ListeTable.Strings[i],3,';');
//            if tiers then
//              begin
//              DMcorrections.TaCorrectionExoCourant.OnFilterRecord:=DMcorrections.TaCorrectionFilterRecordTiers;
//              if not((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')) then
//                 TableGereStartTransaction(DMcorrections.TaCorrectionExoCourant);
//              end
//            else
//              DMcorrections.TaCorrectionExoCourant.OnFilterRecord:=DMcorrections.TaCorrectionFilterRecordLibelle;
//
//
//            FiltrageDataSet(DMcorrections.TaCorrectionExoCourant,'');//permet de déclencher le filter Record
//
//            DMcorrections.TaCorrectionExoCourant.first;
//            while not(DMcorrections.TaCorrectionExoCourant.Eof)do
//              begin
//                tablegereEdit(DMcorrections.TaCorrectionExoCourant);
//                LibelleCorrect:=Str_StringAcceptSQL(DMcorrections.TaCorrectionExoCourant.findfield(DMcorrections.ChampCourant).asstring,DMcorrections.TaListeFilterRecord);
//                if empty(LibelleCorrect) then
//                   begin
//                     if tiers then
//                       raise ExceptLGR.Create('Le Tiers '+DMcorrections.TaCorrectionExoCourant.findfield(DMcorrections.ChampCourant).asstring+' n''est pas correct',1000,true,mtError,result)
//                     else
//                       LibelleCorrect:='Libellé vide';
//                   end;
//                DMcorrections.TaCorrectionExoCourant.findfield(DMcorrections.ChampCourant).asstring:= LibelleCorrect;
//                try
//                TableGerePost(DMcorrections.TaCorrectionExoCourant);
//                except
//                abort;
//                end;
//                //DMcorrections.TaCorrectionExoCourant.next;
//                //je ne fais pas de next car la table
//                //est automatiquement refiltrée
//              end;
//        end;
    end;
    tablegereCommit(DMcorrections.TaCorrection);
    tablegereCommit(DMcorrections.TaCorrectionExoCourant);
except
  result.retour:=false;
    TableGereRollBack(DMcorrections.TaCorrection);
    TableGereRollBack(DMcorrections.TaCorrectionExoCourant);
  TableGereClose(DMcorrections.TaCorrection);
  TableGereClose(DMcorrections.TaCorrectionExoCourant);

  DMcorrections.TaCorrection.OnFilterRecord:=nil;
  DMcorrections.TaCorrectionExoCourant.OnFilterRecord:=nil;
end;
finally
  GestionGauge(10,gauge,0,0,'',false);
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  tableExo.Close;
  tableExo.Free;
  DMcorrections.TaCorrection.close;
  DMcorrections.TaCorrectionExoCourant.close;
  DMcorrections.dbCorrection.Close;
  DMcorrections.TaCorrection.OnFilterRecord:=nil;
  DMcorrections.TaCorrectionExoCourant.OnFilterRecord:=nil;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;

Function VerifCoherence_ResteDC_Ecriture(DemandeConfirmation:boolean):TExceptlgr;
var
Confirmation:boolean;
NbError:Integer;
begin
try//finally
  try//except
   NbError:=0;
Initialise_ExceptLGR(result,GestMessageLGR);
//   result.GestMessageLGR:=GestMessageLGR;
          result.NumErreur:=9001;
          result.retour:=true;
   result.GestMessageLGR.Enregistrement := true;
 result.NomDossier:=e.NomDossier;
   result.NomModule:='VerifCoherence_ResteDC_Ecriture';
 confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
          if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
  if DemandeConfirmation then
    Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de cohérence entre les écritures et les Dettes et Créances ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
  if Confirmation then
      begin

          PatienterAffich;

          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add(' select count(*) as NbErreur from ecriture E ');
          DMcorrections.QuCorrectionDossier.SQL.add(' where not(E.id in (select id_ecriture from restedc)) ');
          DMcorrections.QuCorrectionDossier.SQL.add(' and ((E.tiers <>'''') or (E.compte in (select compte from plancpt where pointable=true and collectif=false))) ');
          DMcorrections.QuCorrectionDossier.Open;
          NbError:=DMcorrections.QuCorrectionDossier.FindField('NbErreur').AsInteger;
          result.retour :=(NbError = 0);
          PatienterFermer;
      end;
  except
    result.retour:=false;
  end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

    DMcorrections.QuCorrectionDossier.Close;
   result.GestMessageLGR.Enregistrement := false;
  PatienterFermer;
end;
End;


//récupération dans une liste de tous les exercices d'un dossier
//en rajoutant en fin de chemin un "\"
Function RecupExerciceDossier(idDossier:integer):Tstringlist;
var
ExceptLGRTmp:TExceptLGR;
ExoNMoins1:string;
begin
 result:=TStringList.Create;
Initialise_ExceptLGR(ExceptLGRTmp,GestMessageLGR);
// ExceptLGRTmp.GestMessageLGR:=GestMessageLGR;
 ExceptLGRTmp.NomModule:='RecupExerciceDossier';
 ExceptLGRTmp.GestMessageLGR.Enregistrement:=true;
  try//finally
      try//except
        if idDossier=0 then
         begin
           ExoNMoins1:=IncludeTrailingPathDelimiter(E.RepertoireProgram)+DM_C_NomAliasDemo+'\'+DM_C_NomAliasExoDemo;
           result.Add(IncludeTrailingPathDelimiter(E.RepertoireProgram)+DM_C_NomAliasDemo+'\'+DM_C_NomAliasExoDemo+';'+e.ExerciceBase+';'+ExoNMoins1);
         end
        else
         begin
           // raise ExceptLGR.Create('IDDossier vide',0000,false,mtError,ExceptLGRTmp);
          if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
          FiltrageDataSet(DMRech.TaGestDossierRech,'id_Dossier='+inttostr(idDossier)+' and cloture=faux');
          DMRech.TaGestDossierRech.first;
          ExoNMoins1:=IncludeTrailingPathDelimiter(DMRech.TaGestDossierRech.findfield('Dir_Exo').AsString);
          while not(DMRech.TaGestDossierRech.eof) do
            begin
              result.Add(IncludeTrailingPathDelimiter(DMRech.TaGestDossierRech.findfield('Dir_Exo').AsString)+';'+DMRech.TaGestDossierRech.findfield('Exo_Base').AsString+';'+ExoNMoins1);
              ExoNMoins1:=IncludeTrailingPathDelimiter(DMRech.TaGestDossierRech.findfield('Dir_Exo').AsString);
              DMRech.TaGestDossierRech.next;
            end;
         end;
      except
        result:=nil;
      end;
  finally
    DeFiltrageDataSet(DMRech.TaGestDossierRech);
    ExceptLGRTmp.GestMessageLGR.Enregistrement:=false;
  end;
end;



Function ReindexationTableProc(ListeTable:Tstringlist;Gauge:TGauge;MessageSourd:boolean;
   DemandeConfirmation:boolean;ForceReindex:boolean):TExceptLGR;
var
i:integer;
Confirmation:boolean;
ListeTmp, ListeBackup :TStringList;
begin
try//finally
try//except
ListeTmp:= TStringList.Create;

Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
 result.NomModule:='ReindexationTable';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);

        result.NumErreur:=0000;
        result.retour:=true;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=true;
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la réindexation des tables ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        if not FermerDossier(E) then abort;
        if listetable=nil then
          Begin
              listetable := TStringList.Create;
              //// Programme
              Session.GetTableNames(DMRech.TaParam_DossierRech.DatabaseName, '*.db',true, False, ListeTmp);
              for i:=0 to ListeTmp.count-1 do
              begin
                if str_position_caseInsensitive('_QSQ',ListeTmp.Strings[i])=0 then
                  listetable.Add(DMRech.TaParam_DossierRech.DatabaseName+';'+ListeTmp.Strings[i]+'; 1');
              end;
              ListeTmp.Clear;
              // Exercice
              Session.GetTableNames(DMRech.TaBalanceRech.DatabaseName, '*.db',true, False, ListeTmp);
              for i:=0 to ListeTmp.count-1 do
              begin
                if str_position_caseInsensitive('_QSQ',ListeTmp.Strings[i])=0 then
                  listetable.Add(DMRech.TaBalanceRech.DatabaseName+';'+ListeTmp.Strings[i]+'; 1');
              end;
              ListeTmp.Clear;
          end;
        if (ListeTable<>nil) then
          begin
               if(not ForceReindex)then
                begin
            try
                 ListeBackup := TStringList.Create;
                if FileExists(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ReindexListDef.bk')then
                  begin
                      ListeBackup.LoadFromFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ReindexListDef.bk');
                      i:=0;
                      while i<ListeTable.Count do
                        begin
                          if ListeBackup.IndexOf(uppercase(str_getstringelement(ListeTable.strings[i],2,';')))=-1 then
                             ListeTable.Delete(i)
                           else
                             inc(i);
                        end;
                  end
                 else
                 showmessage('ReindexListDef.bk n''existe pas');
            except
            end;
              end;
     GestionGauge(10,Gauge,(ListeTable.count*10)+10,0,'Reindexation des Tables');
           for i:=0 to ListeTable.count-1 do
             begin
                if trim(str_getstringelement(listeTable.Strings[i],3,';'))='1'then
                  begin //on ne travaille que sur les tables cochées
                      DMcorrections.TaCorrection.close;
                      DMcorrections.TaCorrection.databasename:=str_getstringelement(listeTable.Strings[i],1,';');
                      DMcorrections.TaCorrection.Tablename:=str_getstringelement(listeTable.Strings[i],2,';');
                      BdeUtils.ReindexTable(DMcorrections.TaCorrection);
                      DMcorrections.TaCorrection.Open;
                      BdeUtils.PackTable(DMcorrections.TaCorrection);
                  end;
  GestionGauge(10,Gauge);
             end;
          end;
     if DemandeConfirmation then MessageDlg_lgr('La réindexation des tables est terminée', mtInformation, [mbOK], 0);
    end;//fin si confirmation
except
  MessageDlg_lgr('La table '+DMcorrections.TaCorrection.TableName+' n''a pas pu être reindexée', mtInformation, [mbOK], 0);
  result.retour:=false;
end;
finally
    try
    if ((result.retour=false)and(not MessageSourd)) then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
Initialise_TStringlist(ListeTmp);
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

    DMcorrections.TaCorrection.close;
GestionGauge(0,Gauge);
    GenereDMDossier;
    DMBD.OpenAllTAble;
GestionGauge(0,Gauge,0,0,'',false);
  Patienterfermer;
 result.GestMessageLGR.Enregistrement:=false;
end;
end;


Function PackTableProc(ListeTable:Tstringlist;Gauge:TGauge;MessageSourd:boolean;DemandeConfirmation:boolean):TExceptLGR;
var
i:integer;
Confirmation:boolean;
ListeTmp, ListeBackup :TStringList;
begin
try//finally
try//except
ListeTmp:= TStringList.Create;

Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
 result.NomModule:='PackTable';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);

        result.NumErreur:=0000;
        result.retour:=true;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=true;
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer l''optimisation de la taille des tables ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        if not FermerDossier(E) then abort;
        if listetable=nil then
          Begin
              listetable := TStringList.Create;
              //// Programme
              Session.GetTableNames(DMRech.TaParam_DossierRech.DatabaseName, '*.db',true, False, ListeTmp);
              for i:=0 to ListeTmp.count-1 do
              begin
                if str_position_caseInsensitive('_QSQ',ListeTmp.Strings[i])=0 then
                  listetable.Add(DMRech.TaParam_DossierRech.DatabaseName+';'+ListeTmp.Strings[i]+'; 1');
              end;
              ListeTmp.Clear;
              // Exercice
              Session.GetTableNames(DMRech.TaBalanceRech.DatabaseName, '*.db',true, False, ListeTmp);
              for i:=0 to ListeTmp.count-1 do
              begin
                if str_position_caseInsensitive('_QSQ',ListeTmp.Strings[i])=0 then
                  listetable.Add(DMRech.TaBalanceRech.DatabaseName+';'+ListeTmp.Strings[i]+'; 1');
              end;
              ListeTmp.Clear;
          end;
        if ListeTable<>nil then
          begin
            try
                ListeBackup := TStringList.Create;
                if FileExists(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ReindexListDef.bk')then
                  begin
                      ListeBackup.LoadFromFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ReindexListDef.bk');
                      i:=0;
                      while i<ListeTable.Count do
                        begin
                          if ListeBackup.IndexOf(uppercase(str_getstringelement(ListeTable.strings[i],2,';')))=-1 then
                             ListeTable.Delete(i)
                           else
                             inc(i);
                        end;
                  end
                 else
                 showmessage('ReindexListDef.bk n''existe pas');
            except
            end;

     GestionGauge(10,Gauge,(ListeTable.count*10)+10,0,'optimisation de la taille des Tables');
           for i:=0 to ListeTable.count-1 do
             begin
                if trim(str_getstringelement(listeTable.Strings[i],3,';'))='1'then
                  begin //on ne travaille que sur les tables cochées
                      DMcorrections.TaCorrection.close;
                      DMcorrections.TaCorrection.databasename:=str_getstringelement(listeTable.Strings[i],1,';');
                      DMcorrections.TaCorrection.Tablename:=str_getstringelement(listeTable.Strings[i],2,';');
                      //BdeUtils.ReindexTable(DMcorrections.TaCorrection);
                      DMcorrections.TaCorrection.Open;
                      BdeUtils.PackTable(DMcorrections.TaCorrection);
                  end;
  GestionGauge(10,Gauge);
             end;
          end;
     if DemandeConfirmation then MessageDlg_lgr('L''optimisation de la taille des tables est terminée', mtInformation, [mbOK], 0);
    end;//fin si confirmation
except
  MessageDlg_lgr('La table '+DMcorrections.TaCorrection.TableName+' n''a pas pu être obtimisée', mtInformation, [mbOK], 0);
  result.retour:=false;
end;
finally
    try
    if ((result.retour=false)and(not MessageSourd)) then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
Initialise_TStringlist(ListeTmp);
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

    DMcorrections.TaCorrection.close;
GestionGauge(0,Gauge);
    GenereDMDossier;
    DMBD.OpenAllTAble;
GestionGauge(0,Gauge,0,0,'',false);
  Patienterfermer;
 result.GestMessageLGR.Enregistrement:=false;
end;
end;



Function VerifCoherence_HTVA(DemandeConfirmation:boolean):TExceptlgr;
var
Confirmation:boolean;
NbError:Integer;
liste:TStringlistLGR1;
begin
try//finally
  try//except
   NbError:=0;
Initialise_ExceptLGR(result,GestMessageLGR);
//   result.GestMessageLGR:=GestMessageLGR;
          result.NumErreur:=10000;
          result.retour:=true;
   result.GestMessageLGR.Enregistrement := true;
 result.NomDossier:=e.NomDossier;
   result.NomModule:='VerifCoherence_HTVA';
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=true;
          if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
  if DemandeConfirmation then
    Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de cohérence sur la gestion de la TVA ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
  if Confirmation then
      begin
          PatienterAffich;
          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add(' select id_ecriture, sum(Part_Declaree)as Part from H_tva ');
          DMcorrections.QuCorrectionDossier.SQL.add(' where en_attente = false and divers is null');
          DMcorrections.QuCorrectionDossier.SQL.add(' group by id_ecriture ');
          DMcorrections.QuCorrectionDossier.OnFilterRecord:=DMcorrections.TaCorrectionFilterRecordTVA;
          DMcorrections.QuCorrectionDossier.filtered:=true;
          DMcorrections.QuCorrectionDossier.Open;
          if (DMcorrections.QuCorrectionDossier.recordcount <> 0)then
          begin
            raise ExceptLGR.Create('',result.NumErreur,false,mtError,Result);
          end;
          PatienterFermer;
      end;
  except
    DMcorrections.QuCorrectionDossier.OnFilterRecord:=nil;
    result.retour:=false;
  end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  DMcorrections.QuCorrectionDossier.OnFilterRecord:=nil;
  DMcorrections.QuCorrectionDossier.filtered:=false;  
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

    DMcorrections.QuCorrectionDossier.Close;
   result.GestMessageLGR.Enregistrement := false;
  PatienterFermer;
end;
End;


procedure TDMcorrections.TaCorrectionFilterRecordTVA(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if not((csDestroying)in DataSet.ComponentState) then
    begin
      accept:=arrondi(DataSet.findfield('Part').ascurrency,2)>1;
    end;
end;

Function CorrectionDeLaBalanceDesMouvements(MessageSourd:boolean;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ListeCpt,ListeRetour,ListeErreur:Tstringlist;

begin
try//finally
try//except
ListeCpt:=TStringList.Create;
ListeRetour:=TStringList.Create;
ListeErreur:=TStringList.Create;
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=5001;
result.retour:=true;
 result.NomModule:='CorrectionDeLaBalanceDesMouvements';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;

 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=((not e.ExerciceCloture) or (e.TypeClient=cl_isa));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de la balance des mouvements ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;

//        ListeCpt.Add('1*');
//        ListeCpt.Add('2*');
//        ListeCpt.Add('3*');
//        ListeCpt.Add('4*');
//        ListeCpt.Add('5*');
//        ListeCpt.Add('6*');
//        ListeCpt.Add('7*');
        if not ControleBalanceCpt(nil,ListeRetour) then
          begin
             if DemandeConfirmation then
              Confirmation:=MessageDlg_lgr('Votre balance présente des incohérences, Voulez_vous lancer le recalcul de la balance des mouvements ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
             if confirmation then
               begin
                  if not MiseAJourBalanceNCpt then
                    begin
                        raise ExceptLGR.Create('Le recalcul de la balance des mouvements ne peut pas s''effectuer correctement. ControleBalanceCpt.',result.NumErreur,false,mtError,Result);
                    end;
               end;
          end;
        if DMBalance.VerifEquilibreBalanceN.retour=false then
            begin
                  //raise ExceptLGR.Create('La balance des mouvements présente des incohérences. ControleBalanceCpt.',result.NumErreur,false,mtError,Result);
                DMcorrections.QuCorrectionProgram.Close;
                DMcorrections.QuCorrectionProgram.DatabaseName:=DM_C_NomAliasDossier;
                DMcorrections.QuCorrectionProgram.SQL.Clear;
                DMcorrections.QuCorrectionProgram.SQL.add('Select Ecr.id_piece,Pi.Reference, sum(Ecr.DebitSaisie)as TotDebit,Sum(Ecr.CreditSaisie)as TotCredit');
                DMcorrections.QuCorrectionProgram.SQL.add('from Ecriture Ecr');
                DMcorrections.QuCorrectionProgram.SQL.add('join Piece Pi on (Pi.ID=Ecr.ID_Piece)');
                DMcorrections.QuCorrectionProgram.SQL.add('where Pi."Date" >=:DateDeb and Pi."Date" <=:DateFin');
                DMcorrections.QuCorrectionProgram.SQL.add('group by Ecr.id_piece,Pi.Reference');
                DMcorrections.QuCorrectionProgram.SQL.add('having (sum(Ecr.DebitSaisie)-sum(Ecr.CreditSaisie))<>0');
                DMcorrections.QuCorrectionProgram.SQL.add('order by Ecr.id_piece');
                DMcorrections.QuCorrectionProgram.ParamByName('DateDeb').AsDate:=e.DatExoDebut;
                DMcorrections.QuCorrectionProgram.ParamByName('DateFin').AsDate:=e.DatExoFin;
                DMcorrections.QuCorrectionProgram.open;
                DMcorrections.QuCorrectionProgram.first;
                while not DMcorrections.QuCorrectionProgram.eof do
                  Begin
                     if DMcorrections.QuCorrectionProgram.findfield('TotDebit').ascurrency<>DMcorrections.QuCorrectionProgram.findfield('TotCredit').ascurrency then
                       begin
                        result.retour:=false;
                        ListeErreur.Add('La Piece '+DMcorrections.QuCorrectionProgram.findfield('Reference').asstring+' n''est pas équilibrée')
                        //raise ExceptLGR.Create('La Piece '+DMcorrections.QuCorrectionProgram.findfield('Reference').asstring+' n''est pas équilibrée',result.NumErreur,false,mtError,Result);
                       end;
                    DMcorrections.QuCorrectionProgram.next;
                  end;
            end;//fin si déséquilibre dans balance
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if ((result.retour=false)and (not MessageSourd)) then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'DesequilibreBalanceMouvementListe.txt',ListeErreur.GetText) ;
    Confirmation:=MessageDlg_lgr('Voulez-vous afficher le fichier des erreurs ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
    if(Confirmation)then ShellExecute(Application.Handle, 'open', PChar(E.RepertoireDossier+'DesequilibreBalanceMouvementListe.txt'), nil, nil, SW_SHOWNORMAL);
//     ListeErreur.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'DesequilibreBalanceMouvementListe.txt');
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  ListeErreur.Clear;
  Initialise_TStringlist(ListeErreur);
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

Function modificationNumeroPiece(DemandeConfirmation:boolean;MessageErreur:boolean):texceptlgr;
var
Confirmation:boolean;
ReferenceOD:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=17000;
result.retour:=true;
 result.NomModule:='modificationNumeroPiece';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);

 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la modification des numéros de pièce ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
          //verif sur la date mal remplie sur type D
          result.NumErreur:=17000;
          DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.sql.Add('select * from piece p');
          DMcorrections.QuCorrectionDossier.sql.Add('where p.reference like ''B113%''');
          DMcorrections.QuCorrectionDossier.sql.Add('order by id');
          DMcorrections.QuCorrectionDossier.open;
          DMcorrections.QuCorrectionDossier.first;
          result.retour:=DMcorrections.QuCorrectionDossier.recordcount=0;

          if result.retour then
            begin
              //verif sur type mal rempli
              result.NumErreur:=17001;
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.sql.Add('select * from ecriture E');
              DMcorrections.QuCorrectionDossier.sql.Add('where e.tvatype<>''D'' and e.tvatype<>''E'' and tvacode is not null and e.compte between ''6'' and ''79999999''');
              DMcorrections.QuCorrectionDossier.open;
              DMcorrections.QuCorrectionDossier.first;
              result.retour:=DMcorrections.QuCorrectionDossier.recordcount=0;
            end;

        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
//       if ((MessageErreur)or(result.NumErreur=17001)) then
       if MessageErreur then
         raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'_'+inttostr(DMcorrections.QuCorrectionDossier.recordcount)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


Function CorrectionDeLaBalanceDesTiers(MessageSourd:boolean;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ListeCpt,ListeRetour:Tstringlist;
begin
try//finally
try//except
ListeCpt:=TStringList.Create;
ListeRetour:=TStringList.Create;
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=5002;
result.retour:=true;
 result.NomModule:='CorrectionDeLaBalanceDesTiers';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=((not e.ExerciceCloture) or (e.TypeClient=cl_isa));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de la balance des tiers ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;

        ListeCpt.Add('*');
        if not ControleBalanceTiers(ListeCpt,ListeRetour) then
          begin
             if DemandeConfirmation then
              Confirmation:=MessageDlg_lgr('Votre balance présente des incohérences, Voulez_vous lancer le recalcul de la balance des tiers ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
             if confirmation then
               begin
                  if not MiseAJourBalanceNTiers then
                    begin
                        raise ExceptLGR.Create('Le recalcul de la balance des tiers ne peut pas s''effectuer correctement. ControleBalanceTiers.',result.NumErreur,false,mtError,Result);
                    end;
               end;
          end;
          //raise ExceptLGR.Create('La balance des tiers présente des incohérences. ControleBalanceTiers.',result.NumErreur,false,mtError,Result);
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if ((result.retour=false)and (not MessageSourd)) then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;



Function CorrectionDeLaBalanceReportDesTiers(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ListeCpt,ListeRetour:Tstringlist;
begin
try//finally
try//except
ListeCpt:=TStringList.Create;
ListeRetour:=TStringList.Create;
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=22000;
result.retour:=true;
 result.NomModule:='CorrectionDeLaBalanceReportDesTiers';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=((not e.ExerciceCloture) or (e.TypeClient=cl_isa));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de la balance des reports des tiers ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;

        ListeCpt.Add('*');
        if not DMBalance.ControlBalanceTiersReport2(Gauge,false,true).retour then abort;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if (result.retour=false) then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


Function RestaurationTableImmos(DemandeConfirmation:boolean):TExceptLGR;
var
i:integer;
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
 result.NomModule:='RestaurationTableImmos';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);

        result.NumErreur:=11000;
        result.retour:=true;
 confirmation:=not e.ExerciceCloture;
 confirmation:=true;
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la restauration de la table des immobilisations ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        if not FermerDossier(E) then abort;
        //faire restauration
        RestaureImmosDossierNew;
     if DemandeConfirmation then MessageDlg_lgr('la restauration de la table des immobilisations est terminée', mtInformation, [mbOK], 0);
    end;//fin si confirmation
except
  raise ExceptLGR.Create('la restauration de la table des immobilisations n''a pas pu s''effectuer',result.NumErreur,true,mtError,Result);
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

    DMcorrections.TaCorrection.close;
    GenereDMDossier;
    DMBD.OpenAllTAble;
  Patienterfermer;
 result.GestMessageLGR.Enregistrement:=false;
end;
end;

Function CorrectionDeclarationTVA(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ReferenceOD:string;
begin
try//finally
try//except
// result.GestMessageLGR:=GestMessageLGR;
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=12000;
result.retour:=true;
 result.NomModule:='CorrectionDeclarationTVA';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=not e.ExerciceCloture;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des déclarations de TVA ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('select reference_od from h_tva');
        DMcorrections.QuCorrectionDossier.SQL.add('where  not exists(select reference_od from h_piecetva)');
        DMcorrections.QuCorrectionDossier.SQL.add('and id_declaration>0');
        DMcorrections.QuCorrectionDossier.open;
        result.retour:=DMcorrections.QuCorrectionDossier.recordcount=0;
        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

procedure TDMcorrections.FilterRecordSumPartDeclaree_PresqueTotal(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=((dataset.FindField('part_declaree').AsFloat>PourcentageTvaRegle) and (dataset.FindField('part_declaree').AsFloat<1));
end;

procedure TDMcorrections.FilterRecordSumPartDeclaree_Total(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=arrondi(dataset.FindField('part_declaree').AsFloat,2)>=1;
end;

procedure TDMcorrections.FilterRecordListeTotalementReglee(DataSet: TDataSet;
  var Accept: Boolean);
begin
if ListeTotalementReglee<>nil then
  accept:=((ListeTotalementReglee.IndexOf(inttostr(dataset.FindField('id_ecriture').Asinteger))<>-1)
  or(dataset.FindField('id_ecriture').Asinteger=0));
end;

procedure TDMcorrections.FilterRecordTVA_NON_IMPOSABLE(DataSet: TDataSet;
  var Accept: Boolean);
begin
if ListeCodeNonImposable<>nil then
  accept:=ListeCodeNonImposable.IndexOf(copy(dataset.FindField('TvaCode').Asstring,1,1))=-1;
end;



Function ModificationTableH_TVA(AvecCreationLigne:boolean;Partiel:boolean;DemandeConfirmation:boolean):texceptlgr;
//var
//Confirmation:boolean;
//i,rangListe:integer;
//MTTVA,HT:currency;
//ListePeriode,ListeSumPartDeclareePresqueTotale,ListeSumPartDeclareeTotale:Tstringlist;
//EcritureDeclaree:TEcritureDeclaree;
//DateDepart:Tdate;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=13000;
result.retour:=true;
 result.NomModule:='ModificationTableH_TVA';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
//ListePeriode:=TStringList.Create;
//ListeSumPartDeclareePresqueTotale:=TStringList.Create;
//ListeSumPartDeclareeTotale:=TStringList.Create;
//PourcentageTvaRegle:=DM_C_PourcentageTvaRegle;


// confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
//        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
//        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
// if not confirmation then
//   begin
//    if DemandeConfirmation then
//      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
//   end
// else
// if DemandeConfirmation then
//  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la modification de la table des déclarations de TVA ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
//if Confirmation then
//    begin
        PatienterAffich;
//
//            Initialise_TStringlist(DMcorrections.ListeCodeNonImposable,DMcorrections,false);//nettoyage de la liste avant utilisation
//            DMcorrections.ListeCodeNonImposable:=DM_C_ListeCTVANonImposable;

            //nettoyage de la table avant de réécrire
            DMcorrections.QuCorrectionInsert.Close;
            DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;
            DMcorrections.QuCorrectionInsert.SQL.Clear;
            DMcorrections.QuCorrectionInsert.SQL.add('Delete from H_Tva');
            DMcorrections.QuCorrectionInsert.SQL.add('where ID_Declaration=-2');
            DMcorrections.QuCorrectionInsert.ExecSQL;

//            //On regarde si déjà corrigé une première fois, si oui on ne continue pas sinon on corrige
//            DMcorrections.QuCorrectionInsert.Close;
//            //DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;
//            DMcorrections.QuCorrectionInsert.SQL.Clear;
//            DMcorrections.QuCorrectionInsert.SQL.add('select H.codeCompensation from H_Tva H,h_Piecetva HP ');
//            DMcorrections.QuCorrectionInsert.SQL.add('where H.codeCompensation is not null or HP.divers_Str =''Ok''');
//            DMcorrections.QuCorrectionInsert.open;
//            if DMcorrections.QuCorrectionInsert.recordcount=0 then
//            begin
//                //récupérer les différentes périodes déclarées
//                DMcorrections.QuCorrectionDossier.Close;
//                DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
//                DMcorrections.QuCorrectionDossier.SQL.Clear;
//                DMcorrections.QuCorrectionDossier.SQL.add('select  distinct id_declaration,Debut_Periode,fin_Periode,Reference_Od  from h_tva  ');
//                DMcorrections.QuCorrectionDossier.SQL.add(' where ID_Declaration<>0 ');
//                if partiel then
//                  Begin
//                     DMcorrections.QuCorrectionDossier.SQL.add(' and id_declaration not in (select distinct id_declaration from h_tva where divers is not null)');
//                  end;
//                DMcorrections.QuCorrectionDossier.open;
//                DMcorrections.QuCorrectionDossier.first;
//
//
//                ListePeriode:=ChampTableVersListeEx(['id_declaration','Debut_Periode','fin_Periode','Reference_Od'],DMcorrections.QuCorrectionDossier,';',false);
//                //fin de la récupération des différentes périodes déclarées
//                Initialise_TStringlist(ListeTotalementReglee,DMcorrections,false);
//
//                for i:=0 to ListePeriode.Count-1 do
//                begin
//                 Initialise_TStringlist(ListeSumPartDeclareeTotale,DMcorrections,false);
//                 Initialise_TStringlist(ListeSumPartDeclareePresqueTotale,DMcorrections,false);
//      //          //récupérer les sum des parts déclarées jusqu'à période en cours de vérification
//                if DMTmTVA=nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);
//
//                DMTmTVA.QuCorrectionDeclarationTVA.Close;
//                DMTmTVA.QuCorrectionDeclarationTVA.DatabaseName:=DM_C_NomAliasDossier;
//
//                DMTmTVA.QuCorrectionDeclarationTVA.ParamByName('DateDeb').DataType:=ftDate;
//                DMTmTVA.QuCorrectionDeclarationTVA.ParamByName('DateFin').DataType:=ftDate;
//                DMTmTVA.QuCorrectionDeclarationTVA.ParamByName('DateDeb').AsDate:=0;
//                DMTmTVA.QuCorrectionDeclarationTVA.ParamByName('DateFin').AsDate:=StrToDate_Lgr(str_getstringelement(ListePeriode.Strings[i],3,';'));
//                //récuperation des lignes presque totalement déclarées (Part > 0.95 et < 1)
//                DMTmTVA.QuCorrectionDeclarationTVA.OnFilterRecord:=DMcorrections.FilterRecordSumPartDeclaree_PresqueTotal;
//                DMTmTVA.QuCorrectionDeclarationTVA.filtered:=true;
//                DMTmTVA.QuCorrectionDeclarationTVA.open;
//                DMTmTVA.QuCorrectionDeclarationTVA.first;
//                while not(DMTmTVA.QuCorrectionDeclarationTVA.Eof)do  //DMcorrections.QuCorrectionDossier.findfield('').As
//                    Begin
//                       EcritureDeclaree:=TEcritureDeclaree.Create(application.MainForm);
//                       EcritureDeclaree.Id:= DMTmTVA.QuCorrectionDeclarationTVA.findfield('id_ecriture').Asinteger;
//                       EcritureDeclaree.PartDeclaree:= DMTmTVA.QuCorrectionDeclarationTVA.findfield('Part_Declaree').AsCurrency;
//                       EcritureDeclaree.MontantDeclare:= DMTmTVA.QuCorrectionDeclarationTVA.findfield('montanttva').AsCurrency;
//                       EcritureDeclaree.HTDeclare:= DMTmTVA.QuCorrectionDeclarationTVA.findfield('HTDeclare').AsCurrency;
//                       ListeSumPartDeclareePresqueTotale.AddObject(inttostr(EcritureDeclaree.Id),EcritureDeclaree);
//                       ListeTotalementReglee.AddObject(inttostr(EcritureDeclaree.Id),EcritureDeclaree);
//                       DMTmTVA.QuCorrectionDeclarationTVA.next;
//                    end;
//                ListeSumPartDeclareePresqueTotale.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExportation)+'ListeSumPartDeclareePresqueTotale_Du'+ DateInfos(now,'-').DateStrFormat+'.txt');
//
//
//                DMcorrections.QuCorrectionDossier.Close;
//                DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
//                DMcorrections.QuCorrectionDossier.SQL.Clear;
//
//                DMcorrections.QuCorrectionDossier.SQL.add('select h.id_ecriture , sum(h.part_declaree)as part_declaree,sum(montanttva)as montanttva,sum(HTDeclare)as HTDeclare from  ');
//                DMcorrections.QuCorrectionDossier.SQL.add('Ecriture E');
//                DMcorrections.QuCorrectionDossier.SQL.add('join H_tva h on (h.Id_ecriture=E.Id)');
//                DMcorrections.QuCorrectionDossier.SQL.add(' where E.tvatype=''E'' and h.en_attente=false');
//                DMcorrections.QuCorrectionDossier.SQL.add(' and fin_periode <=:DateFin');
//                DMcorrections.QuCorrectionDossier.SQL.add('group by h.id_ecriture');
//      //          DMcorrections.QuCorrectionDossier.ParamByName('DateDeb').DataType:=ftDate;
//                DMcorrections.QuCorrectionDossier.ParamByName('DateFin').DataType:=ftDate;
//      //          if i=0 then DateDepart:=StrToDate_Lgr(str_getstringelement(ListePeriode.Strings[i],2,';'));
//      //          DMcorrections.QuCorrectionDossier.ParamByName('DateDeb').AsDate:=DateDepart;
//                DMcorrections.QuCorrectionDossier.ParamByName('DateFin').AsDate:=StrToDate_Lgr(str_getstringelement(ListePeriode.Strings[i],3,';'));
//
//                //récuperation des lignes totalement déclarées (Part >= 1)
//
//                DMcorrections.QuCorrectionDossier.OnFilterRecord:=DMcorrections.FilterRecordSumPartDeclaree_Total;
//                DMcorrections.QuCorrectionDossier.filtered:=true;
//                DMcorrections.QuCorrectionDossier.open;
//                DMcorrections.QuCorrectionDossier.first;
//                while not(DMcorrections.QuCorrectionDossier.Eof)do  //DMcorrections.QuCorrectionDossier.findfield('').As
//                    Begin
//                       EcritureDeclaree:=TEcritureDeclaree.Create(application.MainForm);
//                       EcritureDeclaree.Id:= DMcorrections.QuCorrectionDossier.findfield('id_ecriture').Asinteger;
//                       EcritureDeclaree.PartDeclaree:= DMcorrections.QuCorrectionDossier.findfield('Part_Declaree').AsCurrency;
//                       EcritureDeclaree.MontantDeclare:= DMcorrections.QuCorrectionDossier.findfield('montanttva').AsCurrency;
//                       EcritureDeclaree.HTDeclare:= DMcorrections.QuCorrectionDossier.findfield('HTDeclare').AsCurrency;
//                       ListeSumPartDeclareeTotale.AddObject(inttostr(EcritureDeclaree.Id),EcritureDeclaree);
//                       ListeTotalementReglee.AddObject(inttostr(EcritureDeclaree.Id),EcritureDeclaree);
//                       DMcorrections.QuCorrectionDossier.next;
//                    end;
//                ListeSumPartDeclareeTotale.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExportation)+'ListeSumPartDeclareeTotale_Du'+ DateInfos(now,'-').DateStrFormat+'.txt');
//                //fin récuperation des lignes totalement déclarées (Part >= 1)
//
//
//                DMcorrections.QuCorrectionDossier.OnFilterRecord:=nil;
//                DMcorrections.QuCorrectionDossier.Close;
//                DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
//                DMcorrections.QuCorrectionDossier.SQL.Clear;
//
//                //récupérer toutes les lignes déclarées de la période en cours de vérification
////                DMcorrections.QuCorrectionDossier.SQL.add('');
//                DMcorrections.QuCorrectionDossier.SQL.add('select e.tvacode,h.Id,h.Id_ecriture,e.montant_tva,e.DebitSaisie,e.CreditSaisie,h.part_declaree,h.montanttva,h.htdeclare from ');
//                DMcorrections.QuCorrectionDossier.SQL.add('Ecriture E');
//                DMcorrections.QuCorrectionDossier.SQL.add('join H_tva h on (h.Id_ecriture=E.Id)');
//                DMcorrections.QuCorrectionDossier.SQL.add('where h.id_declaration=:idDeclaration and e.tvacode is not null ');
//                DMcorrections.QuCorrectionDossier.SQL.add('union');
//                DMcorrections.QuCorrectionDossier.SQL.add('select '''+StringVideDixCaractere+''',h.Id,h.Id_ecriture,(e.DebitSaisie-e.CreditSaisie)as montant_tva,e.DebitSaisie,e.CreditSaisie,h.part_declaree,h.montanttva,h.htdeclare from ');
//                DMcorrections.QuCorrectionDossier.SQL.add('Ecriture E');
//                DMcorrections.QuCorrectionDossier.SQL.add('join H_tva h on (h.Id_ecriture=E.Id)');
//                DMcorrections.QuCorrectionDossier.SQL.add('where h.id_declaration=:idDeclaration and e.tvacode is null and e.tvatype is null');
//                DMcorrections.QuCorrectionDossier.Params[0].DataType:=ftInteger;
//                DMcorrections.QuCorrectionDossier.Params[0].AsInteger:=StrToInt_Lgr(str_getstringelement(ListePeriode.Strings[i],1,';'));
//                DMcorrections.QuCorrectionDossier.OnFilterRecord:=DMcorrections.FilterRecordTVA_NON_IMPOSABLE;
//                DMcorrections.QuCorrectionDossier.Filtered:=true;
//                DMcorrections.QuCorrectionDossier.open;
//                DMcorrections.QuCorrectionDossier.first;
//      //
//                DMcorrections.QuCorrectionInsert.Close;
//                DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;
//
//                     while not(DMcorrections.QuCorrectionDossier.eof) do
//                       begin
//                        rangListe:=ListeSumPartDeclareeTotale.IndexOf(inttostr(DMcorrections.QuCorrectionDossier.findfield('Id_ecriture').Asinteger));
//                        if rangListe<>-1 then
//                          begin//si dernière part à déclarer
//                            MTTVA:=arrondi(abs(DMcorrections.QuCorrectionDossier.findfield('montant_tva').ascurrency)-(TEcritureDeclaree(ListeSumPartDeclareeTotale.Objects[rangListe]).MontantDeclare-DMcorrections.QuCorrectionDossier.findfield('montanttva').ascurrency),2);
//                            if DMcorrections.QuCorrectionDossier.findfield('DebitSaisie').ascurrency<>0 then
//                              HT:=arrondi(DMcorrections.QuCorrectionDossier.findfield('DebitSaisie').ascurrency-(TEcritureDeclaree(ListeSumPartDeclareeTotale.Objects[rangListe]).HTDeclare-DMcorrections.QuCorrectionDossier.findfield('htdeclare').ascurrency),2)
//                            else
//                              HT:=arrondi(DMcorrections.QuCorrectionDossier.findfield('CreditSaisie').ascurrency-(TEcritureDeclaree(ListeSumPartDeclareeTotale.Objects[rangListe]).HTDeclare-DMcorrections.QuCorrectionDossier.findfield('htdeclare').ascurrency),2);
//                          end
//                        else
//                        begin
//                          rangListe:=ListeSumPartDeclareePresqueTotale.IndexOf(inttostr(DMcorrections.QuCorrectionDossier.findfield('Id_ecriture').Asinteger));
//                          if rangListe<>-1 then
//                            begin//si dernière part à déclarer
//                              MTTVA:=arrondi(abs(DMcorrections.QuCorrectionDossier.findfield('montant_tva').ascurrency)-(TEcritureDeclaree(ListeSumPartDeclareePresqueTotale.Objects[rangListe]).MontantDeclare-DMcorrections.QuCorrectionDossier.findfield('montanttva').ascurrency),2);
//                              if DMcorrections.QuCorrectionDossier.findfield('DebitSaisie').ascurrency<>0 then
//                                HT:=arrondi(DMcorrections.QuCorrectionDossier.findfield('DebitSaisie').ascurrency-(TEcritureDeclaree(ListeSumPartDeclareePresqueTotale.Objects[rangListe]).HTDeclare-DMcorrections.QuCorrectionDossier.findfield('htdeclare').ascurrency),2)
//                              else
//                                HT:=arrondi(DMcorrections.QuCorrectionDossier.findfield('CreditSaisie').ascurrency-(TEcritureDeclaree(ListeSumPartDeclareePresqueTotale.Objects[rangListe]).HTDeclare-DMcorrections.QuCorrectionDossier.findfield('htdeclare').ascurrency),2);
//                            end
//                          else
//                          begin
//                              MTTVA:=arrondi(abs(DMcorrections.QuCorrectionDossier.findfield('montant_tva').ascurrency)*DMcorrections.QuCorrectionDossier.findfield('part_declaree').asfloat,2);
//                              if DMcorrections.QuCorrectionDossier.findfield('DebitSaisie').ascurrency<>0 then
//                                HT:=arrondi(DMcorrections.QuCorrectionDossier.findfield('DebitSaisie').ascurrency*DMcorrections.QuCorrectionDossier.findfield('part_declaree').asfloat,2)
//                              else
//                                HT:=arrondi(DMcorrections.QuCorrectionDossier.findfield('CreditSaisie').ascurrency*DMcorrections.QuCorrectionDossier.findfield('part_declaree').asfloat,2);
//                          end;
//                        end;
//
//                        DMcorrections.QuCorrectionInsert.Close;
//                        DMcorrections.QuCorrectionInsert.SQL.Clear;
//                        DMcorrections.QuCorrectionInsert.SQL.add(' Update h_tva set montantTVA='+str_QueDesChiffresCurr_SQL(currtostr(MTTVA))+',');
//                        DMcorrections.QuCorrectionInsert.SQL.add(' HTDeclare='+str_QueDesChiffresCurr_SQL(currtostr(HT))+'');
//                        DMcorrections.QuCorrectionInsert.SQL.add(' where id='+inttostr(DMcorrections.QuCorrectionDossier.findfield('id').asinteger)+'');
//                        DMcorrections.QuCorrectionInsert.ExecSQL;
//
//
//                        DMcorrections.QuCorrectionDossier.next;
//                       end;
//                    DMcorrections.QuCorrectionDossier.OnFilterRecord:=nil;
//                    DMcorrections.QuCorrectionDossier.filtered:=false;
//                end;//fin boucle for ListePeriode.Count-1
                //faire traitement pour comparer sum de chaque code tva avec liste des ecritures de la pièce de déclaration
                //correspondante
                //si pas ok, créer une ligne dans HTva pour compenser la différence d'un côté ou de l'autre
//                 if AvecCreationLigne then
//                   CorrectionArrondiDeclarationTVA(-1,false);
                 PatienterFermer;
//            end;//fin si pas déjà corrigé
//    end;
except
//  DMcorrections.QuCorrectionDossier.OnFilterRecord:=nil;
//  DMTmTVA.QuCorrectionDeclarationTVA.OnFilterRecord:=nil;
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
//      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

//  DMcorrections.QuCorrectionExo.Close;
  DMcorrections.QuCorrectionInsert.Close;
//  DMcorrections.QuCorrectionDossier.Close;
//  DMTmTVA.QuCorrectionDeclarationTVA.Close;
//  Initialise_TStringlist(ListePeriode);
//  Initialise_TStringlist(ListeSumPartDeclareePresqueTotale);
//  Initialise_TStringlist(ListeSumPartDeclareeTotale);
//  Initialise_TStringlist(DMcorrections.ListeCodeNonImposable,DMcorrections,false);//cette liste est détruite dans le destroy du datamodule
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;



Function CorrectionArrondiDeclarationTVA(IDDeclaration:integer;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
compteTVA,CodeTva:string;
ListeCorrection,ListeEdit,ListeCodeImposeDeduite:Tstringlist;
CorrectionTVA:TCorrectionTVA;
rang,ID:integer;
Solde,HTRecup:currency;
TauxTva:real;
ParamIDDeclaration:integer;
ListeCode_Declaration:Tstringlist;
begin
try//finally
try//except
ListeCorrection:=TStringList.Create;
ListeEdit:=Tstringlist.create;
ListeCodeImposeDeduite:=Tstringlist.create;

Initialise_ExceptLGR(result,GestMessageLGR);

 result.NomModule:='CorrectionArrondiDeclarationTVA';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
result.NumErreur:=14000;
result.retour:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
// confirmation:=not e.ExerciceCloture;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des arrondis des déclarations de TVA ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        if IDDeclaration=-1 then //si traitement complet et que l'on est pas forcement passer dans procédure
          Begin  //d'écriture des montanttva alors je nettoie avant de compenser l'historique par rapport aux od de déclaration                                                                                             
            //nettoyage de la table avant de réécrire
            DMcorrections.QuCorrectionInsert.Close;
            DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;
            DMcorrections.QuCorrectionInsert.SQL.Clear;
            DMcorrections.QuCorrectionInsert.SQL.add('Delete from H_Tva');
            DMcorrections.QuCorrectionInsert.SQL.add('where (ID_Declaration=-2)');
            DMcorrections.QuCorrectionInsert.ExecSQL;
          end;

        //distinguer chaque déclaration
        DMcorrections.QuCorrectionExo.Close;
        DMcorrections.QuCorrectionExo.DatabaseName:=DM_C_NomAliasDossier;
        DMcorrections.QuCorrectionExo.SQL.Clear;
        DMcorrections.QuCorrectionExo.SQL.add('select distinct reference_od,id_declaration,Debut_Periode,Fin_Periode,divers from h_tva');
        DMcorrections.QuCorrectionExo.SQL.add(' where en_attente=false and id_declaration<>0');
//        DMcorrections.QuCorrectionExo.SQL.add(' where en_attente=false and reference_od not in(select reference_od from h_tva where divers is not null)');
        if IDDeclaration<>-1 then
          Begin
             DMcorrections.QuCorrectionExo.SQL.add(' and id_declaration=:ID');
             DMcorrections.QuCorrectionExo.ParamByName('ID').asinteger:=IDDeclaration;
          end;
        DMcorrections.QuCorrectionExo.open;
        DMcorrections.QuCorrectionExo.first;

        while not(DMcorrections.QuCorrectionExo.eof)do
          begin  //pour chaque déclaration trouvée
              Initialise_TStringlist(ListeCorrection,DMcorrections,false);
              idDeclaration:=DMcorrections.QuCorrectionExo.findfield('id_declaration').asinteger;
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;

              //récupérer la somme des tva au débit pour chaque code tva
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select h.id_ecriture,E.tvaCode,E.compte, sum(H.montanttva) as TVADebit,divers,sum(part_declaree)as part_declaree from h_tva H');
              DMcorrections.QuCorrectionDossier.SQL.add('join Ecriture E on (E.id=H.id_ecriture)');
              DMcorrections.QuCorrectionDossier.SQL.add('where E.Debitsaisie<>0 and E.Debitsaisie is not null and H.id_declaration=:id and en_attente=false');
              DMcorrections.QuCorrectionDossier.SQL.add('  group by E.tvaCode,E.compte,H.id_ecriture,divers');
//              DMcorrections.QuCorrectionDossier.SQL.add('union ');
//              DMcorrections.QuCorrectionDossier.SQL.add('select   0,(codecompensation)as tvaCode, sum(H.montanttva) as TVADebit,'''+StringVideCentsCaractere+''',sum(part_declaree)as part_declaree  from h_tva H');
//              DMcorrections.QuCorrectionDossier.SQL.add('where divers is not null and id_ecriture=:id and Montanttva<0');
//              DMcorrections.QuCorrectionDossier.SQL.add('group by  codecompensation');
              DMcorrections.QuCorrectionDossier.Params[0].DataType:=ftinteger;
              DMcorrections.QuCorrectionDossier.Params[0].Asinteger:=idDeclaration;
              //rajouter un filterRecord sur la liste des écritures completement réglées
//              DMcorrections.QuCorrectionDossier.OnFilterRecord:=DMcorrections.FilterRecordListeTotalementReglee;
//              DMcorrections.QuCorrectionDossier.Filtered:=true;
              DMcorrections.QuCorrectionDossier.open;
              DMcorrections.QuCorrectionDossier.first;
              //récupérer ces sommes dans une liste
              while not(DMcorrections.QuCorrectionDossier.eof)do
                begin
                  if not VerifFNumeric(DMcorrections.QuCorrectionDossier.findfield('Compte')).VideOUZero then
                    begin//si <> d'un enregistrement vide
                        if DMcorrections.QuCorrectionDossier.findfield('tvaCode').asstring='' then
                          begin
                            DeFiltrageDataSet(dmrech.TaTvaCodeRech);
                            CodeTva:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'Compte',[DMcorrections.QuCorrectionDossier.findfield('Compte').asstring]).TvaCode;
                            compteTVA:=DMcorrections.QuCorrectionDossier.findfield('Compte').asstring;
                          end
                        else
                          begin
                            CodeTva:=DMcorrections.QuCorrectionDossier.findfield('tvaCode').asstring;
                            compteTVA:=FTvaRecupCompteTva(CodeTva);
                          end;
                      rang:=ListeCorrection.IndexOf(compteTVA);
                      if rang<>-1 then
                        begin
                          TcorrectionTva(ListeCorrection.Objects[rang]).HistoriqueDebit:=TcorrectionTva(ListeCorrection.Objects[rang]).HistoriqueDebit+DMcorrections.QuCorrectionDossier.findfield('TVADebit').ascurrency;
//                          if not TcorrectionTva(ListeCorrection.Objects[rang]).PrendreEnCompte then
//                            TcorrectionTva(ListeCorrection.Objects[rang]).PrendreEnCompte:=empty(DMcorrections.QuCorrectionDossier.findfield('Divers').asstring);
                        end
                      else
                        begin
                          CorrectionTVA:=TCorrectionTVA.Create(application.MainForm);
                          CorrectionTVA.PrendreEnCompte:=true;
                          CorrectionTVA.CodeTVA:=CodeTva;
                          CorrectionTVA.Id_Declaration:=DMcorrections.QuCorrectionExo.findfield('id_declaration').asinteger;
                          CorrectionTVA.CompteTVA:=compteTVA;
                          CorrectionTVA.Debut_Periode:=DMcorrections.QuCorrectionExo.findfield('Debut_Periode').AsDateTime;
                          CorrectionTVA.Fin_Periode:=DMcorrections.QuCorrectionExo.findfield('Fin_Periode').AsDateTime;
                          CorrectionTVA.Reference_OD:=DMcorrections.QuCorrectionExo.findfield('Reference_OD').asstring;
                          CorrectionTVA.HistoriqueDebit:=DMcorrections.QuCorrectionDossier.findfield('TVADebit').ascurrency;
//                          if not CorrectionTVA.PrendreEnCompte then
//                            CorrectionTVA.PrendreEnCompte:=empty(DMcorrections.QuCorrectionDossier.findfield('Divers').asstring);
                          ListeCorrection.AddObject(CorrectionTVA.CompteTVA,CorrectionTVA);
                        end;
                    end;//fin si <> d'un enregistrement vide
                 DMcorrections.QuCorrectionDossier.next;
                end;//fin récupérer ces sommes dans une liste
              //récupérer la somme des tva au credit pour chaque code tva
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select h.id_ecriture,E.tvaCode,E.compte, sum(H.montanttva) as TVACredit,divers,sum(part_declaree)as part_declaree from h_tva H');
              DMcorrections.QuCorrectionDossier.SQL.add('join Ecriture E on (E.id=H.id_ecriture)');
              DMcorrections.QuCorrectionDossier.SQL.add('where E.creditsaisie<>0 and E.creditsaisie is not null and H.id_declaration=:id and en_attente=false');
              DMcorrections.QuCorrectionDossier.SQL.add('  group by E.tvaCode,E.compte,H.id_ecriture,divers');
//              DMcorrections.QuCorrectionDossier.SQL.add('union ');
//              DMcorrections.QuCorrectionDossier.SQL.add('select   0,(codecompensation)as tvaCode, -1*sum(H.montanttva) as TVACredit,'''+StringVideCentsCaractere+''',sum(part_declaree)as part_declaree  from h_tva H');
//              DMcorrections.QuCorrectionDossier.SQL.add('where divers is not null and id_ecriture=:id and Montanttva>0');
//              DMcorrections.QuCorrectionDossier.SQL.add('group by  codecompensation');
              DMcorrections.QuCorrectionDossier.Params[0].DataType:=ftinteger;
              DMcorrections.QuCorrectionDossier.Params[0].Asinteger:=idDeclaration;
              //rajouter un filterRecord sur la liste des écritures complètement réglées
//              DMcorrections.QuCorrectionDossier.OnFilterRecord:=DMcorrections.FilterRecordListeTotalementReglee;
//              DMcorrections.QuCorrectionDossier.Filtered:=true;
              DMcorrections.QuCorrectionDossier.open;
              DMcorrections.QuCorrectionDossier.first;
              //récupérer ces sommes dans une liste
              while not(DMcorrections.QuCorrectionDossier.eof)do
                begin
                  if not VerifFNumeric(DMcorrections.QuCorrectionDossier.findfield('Compte')).VideOUZero then
                    begin//si <> d'un enregistrement vide
                        if DMcorrections.QuCorrectionDossier.findfield('tvaCode').asstring='' then
                          begin
                            DeFiltrageDataSet(dmrech.TaTvaCodeRech);
                            CodeTva:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'Compte',[DMcorrections.QuCorrectionDossier.findfield('Compte').asstring]).TvaCode;
                            compteTVA:=DMcorrections.QuCorrectionDossier.findfield('Compte').asstring;
                          end
                        else
                          begin
                            CodeTva:=DMcorrections.QuCorrectionDossier.findfield('tvaCode').asstring;
                            compteTVA:=FTvaRecupCompteTva(CodeTva);
                          end;
                      rang:=ListeCorrection.IndexOf(compteTVA);
                        if rang<>-1 then
                          begin
                            TcorrectionTva(ListeCorrection.Objects[rang]).HistoriqueCredit:=TcorrectionTva(ListeCorrection.Objects[rang]).HistoriqueCredit+DMcorrections.QuCorrectionDossier.findfield('TVACredit').ascurrency;
//                            if not TcorrectionTva(ListeCorrection.Objects[rang]).PrendreEnCompte then
//                              TcorrectionTva(ListeCorrection.Objects[rang]).PrendreEnCompte:=empty(DMcorrections.QuCorrectionDossier.findfield('Divers').asstring);
                          end
                        else
                          begin
                            CorrectionTVA:=TCorrectionTVA.Create(application.MainForm);
                            CorrectionTVA.PrendreEnCompte:=true;
                            CorrectionTVA.CodeTVA:=CodeTva;
                            CorrectionTVA.CompteTVA:=compteTVA;
                            CorrectionTVA.Debut_Periode:=DMcorrections.QuCorrectionExo.findfield('Debut_Periode').AsDateTime;
                            CorrectionTVA.Fin_Periode:=DMcorrections.QuCorrectionExo.findfield('Fin_Periode').AsDateTime;
                            CorrectionTVA.Id_Declaration:=DMcorrections.QuCorrectionExo.findfield('id_declaration').asinteger;
                            CorrectionTVA.HistoriqueCredit:=DMcorrections.QuCorrectionDossier.findfield('TVACredit').ascurrency;
                            CorrectionTVA.Reference_OD:=DMcorrections.QuCorrectionExo.findfield('Reference_OD').asstring;
//                            if not CorrectionTVA.PrendreEnCompte then
//                              CorrectionTVA.PrendreEnCompte:=empty(DMcorrections.QuCorrectionDossier.findfield('Divers').asstring);
                            ListeCorrection.AddObject(CorrectionTVA.CompteTVA,CorrectionTVA);
                          end;
                    end;//fin si <> d'un enregistrement vide
                 DMcorrections.QuCorrectionDossier.next;
                end;//fin récupérer ces sommes dans une liste
                //récupérer les infos de l'od de déclaration
                DMcorrections.QuCorrectionProgram.Close;
                DMcorrections.QuCorrectionProgram.DatabaseName:=DM_C_NomAliasDossier;
                DMcorrections.QuCorrectionProgram.SQL.Clear;
                DMcorrections.QuCorrectionProgram.SQL.add('select E.compte,E.debitsaisie,E.creditsaisie from ecriture E');
                DMcorrections.QuCorrectionProgram.SQL.add('join Piece P on (E.ID_Piece=P.id)');//
                DMcorrections.QuCorrectionProgram.SQL.add('join tvacode T on (T.compte=E.compte)');
                DMcorrections.QuCorrectionProgram.SQL.add('where P.reference=:od');//
                DMcorrections.QuCorrectionProgram.Params[0].DataType:=ftString;
                DMcorrections.QuCorrectionProgram.Params[0].AsString:=DMcorrections.QuCorrectionExo.findfield('Reference_OD').asstring;
                DMcorrections.QuCorrectionProgram.open;
                DMcorrections.QuCorrectionProgram.first;
                while not(DMcorrections.QuCorrectionProgram.eof)do
                  begin
//                        if FTvaRecupCodeTva(DMcorrections.QuCorrectionProgram.findfield('compte').asstring)<>'' then
//                          begin
                            rang:=ListeCorrection.IndexOf(DMcorrections.QuCorrectionProgram.findfield('compte').asstring);
                            if rang<>-1 then
                              begin
                                 if DMcorrections.QuCorrectionProgram.findfield('debitsaisie').ascurrency<>0 then
                                   TcorrectionTva(ListeCorrection.Objects[rang]).Declaration_Debit:=DMcorrections.QuCorrectionProgram.findfield('debitsaisie').ascurrency;
                                 if DMcorrections.QuCorrectionProgram.findfield('creditsaisie').ascurrency<>0 then
                                   TcorrectionTva(ListeCorrection.Objects[rang]).Declaration_Credit:=DMcorrections.QuCorrectionProgram.findfield('creditsaisie').ascurrency;
                              end;
//                            else
//                                raise ExceptLGR.Create('le compte '+DMcorrections.QuCorrectionProgram.findfield('compte').asstring+' figure dans l''od de déclaration '+DMcorrections.QuCorrectionExo.findfield('Reference_OD').asstring+' mais pas dans l''historique',result.NumErreur,false,mtError,Result);;
//                          end;
                        DMcorrections.QuCorrectionProgram.next;
                  end;
            for rang:=0 to ListeCorrection.count-1 do
              begin
                  ListeEdit.Add(TcorrectionTVA(ListeCorrection.Objects[rang]).Reference_OD
                                +';'
                                +inttostr(TcorrectionTVA(ListeCorrection.Objects[rang]).Id_Declaration)
                                +';'
                                +TcorrectionTVA(ListeCorrection.Objects[rang]).CompteTVA
                                +';'
                                +CurrToStr(TcorrectionTVA(ListeCorrection.Objects[rang]).HistoriqueDebit)
                                +';'
                                +CurrToStr(TcorrectionTVA(ListeCorrection.Objects[rang]).FHistoriqueCredit)
                                +';'
                                +TcorrectionTVA(ListeCorrection.Objects[rang]).CodeTVA
                                +';'
                                +datetostr(TcorrectionTVA(ListeCorrection.Objects[rang]).Debut_Periode)
                                +';'
                                +datetostr(TcorrectionTVA(ListeCorrection.Objects[rang]).Fin_Periode)
                                +';'
                                +CurrToStr(TcorrectionTVA(ListeCorrection.Objects[rang]).Declaration_Debit)
                                +';'
                                +CurrToStr(TcorrectionTVA(ListeCorrection.Objects[rang]).Declaration_Credit)
                                );
              end;
            DeFiltrageDataSet(DMRech.TaH_TVARech);
            DMRech.TaH_TVARech.Refresh;
            ParamIDDeclaration:=-2;
            ListeCodeImposeDeduite:=DM_C_ListeCTVAImposeDeduite;
            for rang:=0 to ListeCorrection.count-1 do
              begin
                 if TcorrectionTVA(ListeCorrection.Objects[rang]).PrendreEnCompte then
                 begin//si à prendre en compte, si pas que de la compensation
                 solde:=(TcorrectionTVA(ListeCorrection.Objects[rang]).HistoriqueDebit-TcorrectionTVA(ListeCorrection.Objects[rang]).FHistoriqueCredit)
                        +(TcorrectionTVA(ListeCorrection.Objects[rang]).Declaration_Debit-TcorrectionTVA(ListeCorrection.Objects[rang]).Declaration_Credit);
                  if ((solde <>0)and (TcorrectionTVA(ListeCorrection.Objects[rang]).CodeTVA<>'')and(ListeCodeImposeDeduite.IndexOf(copy(TcorrectionTVA(ListeCorrection.Objects[rang]).CodeTVA,1,1))=-1)) then
//                  if solde <>0 then
                    Begin//créer une ligne dans H_Tva pour compenser à la prochaine déclaration
                         DeFiltrageDataSet(dmrech.TaH_TVARech);
                         DMRech.TaH_TVARech.Refresh;
                         id:=MaxId_Query(DMRech.TaH_TVARech,'ID');
                         TauxTva:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[TcorrectionTVA(ListeCorrection.Objects[rang]).CodeTVA]).Taux_Supp;
                         HTRecup:=0;
                         if TauxTva<>0 then
                            HTRecup:= (solde*100)/TauxTva;
                         HTRecup:=arrondi(HTRecup,2);
                         DMcorrections.QuCorrectionInsert.Close;
                         DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;                                           //  Debut_Periode,Fin_Periode,
                         DMcorrections.QuCorrectionInsert.SQL.Clear;
                         DMcorrections.QuCorrectionInsert.SQL.add('insert into H_Tva');
                         DMcorrections.QuCorrectionInsert.SQL.add('(Part_declaree,Taux,id,id_Ecriture,ID_Declaration,verrouillee,deverrouillable,en_attente,Montanttva,HTDeclare,Divers,CodeCompensation)');
                         DMcorrections.QuCorrectionInsert.SQL.add('values(1,'+str_QueDesChiffresCurr_SQL(Floattostr(TauxTva))+','+inttostr(ID)+','+inttostr(TcorrectionTVA(ListeCorrection.Objects[rang]).Id_Declaration)+','+inttostr(ParamIDDeclaration)+',''True'',''True'',''false'','
                                                         //         +DateInfos(TcorrectionTVA(ListeCorrection.Objects[rang]).Debut_Periode).DatePourSQLStr+''','''
//                                                                  +DateInfos(TcorrectionTVA(ListeCorrection.Objects[rang]).fin_Periode).DatePourSQLStr+''','
                                                                  +str_QueDesChiffresCurr_SQL(currtostr(-solde))+','+str_QueDesChiffresCurr_SQL(currtostr(-HTRecup))+','''+TcorrectionTVA(ListeCorrection.Objects[rang]).CodeTVA+'_'
                                                                  +TcorrectionTVA(ListeCorrection.Objects[rang]).CompteTVA+'_'
                                                                  +inttostr(TcorrectionTVA(ListeCorrection.Objects[rang]).Id_Declaration)+'_'
                                                                  +TcorrectionTVA(ListeCorrection.Objects[rang]).Reference_OD+'_'+inttostr(ID)+''','''+TcorrectionTVA(ListeCorrection.Objects[rang]).CodeTVA+''')');
                         DMcorrections.QuCorrectionInsert.ExecSQL;
                    end;
                 end;//fin si à prendre en compte, si pas que de la compensation
              end;
            DMcorrections.QuCorrectionExo.next;
          end;//fin pour chaque déclaration trouvée
//          end;

        ListeEdit.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExportation)+'CorrectionDeclarationTVA.txt');
        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  Initialise_TStringlist(ListeCorrection);
  Initialise_TStringlist(ListeEdit);
  Initialise_TStringlist(ListeCodeImposeDeduite);
  DMcorrections.QuCorrectionExo.Close;
  DMcorrections.QuCorrectionDossier.Filtered:=false;
  DMcorrections.QuCorrectionDossier.Close;
  DMcorrections.QuCorrectionInsert.Close;
  DMcorrections.QuCorrectionProgram.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

Function CorrectionPlanComptableTauxTva(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ReferenceOD:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=25000;
result.retour:=true;
 result.NomModule:='CorrectionPlanComptableTauxTva';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
// confirmation:=not e.ExerciceCloture;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);

 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des taux de tva du plan comptable ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;

        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('Update Plancpt p set taux = (select taux_supp from tvaCode t2 where t2.tvacode = p.tvacode) where (taux is null or taux=0) ');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

Function CorrectionPlanComptable(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ReferenceOD:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=15000;
result.retour:=true;
 result.NomModule:='CorrectionPlanComptable';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
// confirmation:=not e.ExerciceCloture;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle du plan comptable ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;

        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('Update Plancpt set tvatype = null');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('Update Plancpt set tvatype=''D'' where tvacode is not null and tvadebit=true');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('Update Plancpt set tvatype=''E'' where tvacode is not null and tvadebit=false');
        DMcorrections.QuCorrectionDossier.ExecSQL;

       if(DemandeConfirmation)then CorrectionDuPlanComptable(nil,true);
       if(DemandeConfirmation)then CorrectionPlanComptableTauxTva(true);
        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

//

///
Constructor TCorrectionTVA.Create(AOwner :TComponent);
begin
inherited create;
PourcentageTvaRegle:=DM_C_PourcentageTvaRegle;
end;

Destructor TCorrectionTVA.Destroy;
begin
inherited destroy;
end;



function CorrectionImmos_Initialisation(DemandeConfirmation:boolean):TexceptLgr;
var
Confirmation:boolean;
Reference:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
      result.NumErreur:=6002;
      result.retour:=true;
 result.NomModule:='CorrectionImmos_Initialisation';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
// confirmation:=not e.ExerciceCloture;
// confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
  if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des immos - Initialisation des choix -  ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
  begin
  PatienterAffich;
//          if VerificationSiPieceDeDotation(Reference) then
//              raise ExceptLGR.Create('La pièce de dotation est déjà passée. CorrectionImmos_SurCession',result.NumErreur,false,mtError,Result);

          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('update immos set Amort_Eco=0,Amort_Derog=0,Eco=0,Mini=0,Maxi=0,Choix=0 where type_amt=''N''');
          DMcorrections.QuCorrectionDossier.ExecSQL;

  PatienterFermer;
  end;//fin si confirmation
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
//  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;



Function CorrectionAnalytique(DemandeConfirmation:boolean):texceptlgr;
var
i:integer;
Confirmation:boolean;
ListeExercices:Tstringlist;
RepertoireExocourant:string;
begin
try//finally
try//except
ListeExercices:=TStringList.Create;
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=16000;
result.retour:=true;
 result.NomModule:='CorrectionAnalytique';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=GEstDossierExerciceEnCoursCloturable(E);
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de l''analytique ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin

        PatienterAffich;
              //on ne travail que sur l'exercice N
              if GEstDossierExerciceEnCoursCloturable(E) then
              begin
              RepertoireExocourant:=e.RepertoireExercice;
              DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
              DMcorrections.QuCorrectionExo.DatabaseName:=RepertoireExocourant;

              //travail sur table affectation des ecritures
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select distinct id_ligne from   "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'ta_ecriture_atelier.db",ecriture E ');
              DMcorrections.QuCorrectionDossier.SQL.add('where  e.id=id_ligne and ((e.code_gestanal is null)or(e.id_gestanal is null))');
              DMcorrections.QuCorrectionDossier.open;

              DMcorrections.QuCorrectionDossier.first;
              while not DMcorrections.QuCorrectionDossier.eof do
                begin
                  DMcorrections.QuCorrectionExo.Close;
                  DMcorrections.QuCorrectionExo.SQL.Clear;
                  DMcorrections.QuCorrectionExo.SQL.add('delete from   "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'ta_ecriture_atelier.db"');
                  DMcorrections.QuCorrectionExo.SQL.add('where id_ligne=:idEcriture');

                  DMcorrections.QuCorrectionExo.ParamByName('idEcriture').AsInteger:=DMcorrections.QuCorrectionDossier.findfield('id_ligne').asinteger;
                  DMcorrections.QuCorrectionExo.ExecSQL;
                  DMcorrections.QuCorrectionDossier.next;
                end;

              //travail sur table affectation des comptes
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select distinct CA.compte from   "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'ta_Compte_atelier.db" CA,Plancpt P ');
              DMcorrections.QuCorrectionDossier.SQL.add('where  P.compte=CA.compte and ((P.code_gestanal is null)or(p.id_gestanal is null))');
              DMcorrections.QuCorrectionDossier.open;

              DMcorrections.QuCorrectionDossier.first;
              while not DMcorrections.QuCorrectionDossier.eof do
                begin
                  DMcorrections.QuCorrectionExo.Close;
                  DMcorrections.QuCorrectionExo.SQL.Clear;
                  DMcorrections.QuCorrectionExo.SQL.add('delete from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'ta_Compte_atelier.db"');
                  DMcorrections.QuCorrectionExo.SQL.add('where compte=:compte');

                  DMcorrections.QuCorrectionExo.ParamByName('compte').Asstring:=DMcorrections.QuCorrectionDossier.findfield('compte').Asstring;
                  DMcorrections.QuCorrectionExo.ExecSQL;
                  DMcorrections.QuCorrectionDossier.next;
                end;

              //travail sur table ecriture
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select id from ecriture ');
              DMcorrections.QuCorrectionDossier.SQL.add('where ((id_gestanal is not null)or(code_gestanal is not null)) ');
              DMcorrections.QuCorrectionDossier.SQL.add('and id not in (select id_ligne from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'ta_ecriture_atelier.db")');
              DMcorrections.QuCorrectionDossier.open;

              if DMcorrections.QuCorrectionDossier.recordcount<>0 then
              begin
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('update ecriture set id_gestanal = null ,Code_gestanal = null');
              DMcorrections.QuCorrectionDossier.SQL.add('where ((id_gestanal is not null)or(code_gestanal is not null)) ');
              DMcorrections.QuCorrectionDossier.SQL.add('and id not in (select id_ligne from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'ta_ecriture_atelier.db")');
              DMcorrections.QuCorrectionDossier.ExecSQL;
              end;

             //travail sur table plancpt
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select compte from plancpt ');
              DMcorrections.QuCorrectionDossier.SQL.add('where ((id_gestanal is not null)or(code_gestanal is not null)) ');
              DMcorrections.QuCorrectionDossier.SQL.add('and compte not in (select compte from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'ta_Compte_atelier.db")');
              DMcorrections.QuCorrectionDossier.open;

              if DMcorrections.QuCorrectionDossier.recordcount<>0 then
              begin
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('update plancpt set id_gestanal = null ,Code_gestanal = null');
              DMcorrections.QuCorrectionDossier.SQL.add('where ((id_gestanal is not null)or(code_gestanal is not null)) ');
              DMcorrections.QuCorrectionDossier.SQL.add('and compte not in (select compte from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'ta_Compte_atelier.db")');
              DMcorrections.QuCorrectionDossier.ExecSQL;
              end;
            end;//fin si exercice N
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionExo.Close;
  DMcorrections.QuCorrectionDossier.close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


Function CorrectionDeLaBalanceDesQuantites(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
i:integer;
ParamGenerCptAffiche:TParamGenerCptAffiche;
Confirmation:boolean;
ListeExercices:Tstringlist;
RepertoireExocourant,RepertoireExoNMoins1:string;
InfosGestDossier:TInfosGestDossier;
begin
try//finally
try//except
ListeExercices:=TStringList.Create;
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=5003;
result.retour:=true;
 result.NomModule:='CorrectionDeLaBalanceDesQuantites';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
 confirmation:=not e.ExerciceCloture;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de la Balance des Quantités, Attention, cette procédure peut-être assez longue ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin

        PatienterAffich;
        ListeExercices:=RecupExerciceDossier_tous(E.ID_Dos);
//        ListeExercices:=RecupExerciceDossier(E.ID_Dos);
        if ((ListeExercices=nil)or(ListeExercices.Count=0)) then
          raise ExceptLGR.Create('',0,false,mtError);
        GestionGauge(10,Gauge,(120*ListeExercices.Count)+50,0,'Correction De La Balance Des Quantites');
        //traitement des ecritures de 1ère ouverture
              DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
              //chercher les infos sur les dates de l'exercice en question
              //pour filtrer les ecritures en fonction de ces dates
              //et ne modifier que les exercices non clôturés
              RepertoireExocourant:=str_getstringelement(ListeExercices.Strings[0],1,';');
              RepertoireExoNMoins1:=str_getstringelement(ListeExercices.Strings[0],3,';');
              DeFiltrageDataSet(dmrech.TaGestDossierRech);
              InfosGestDossier:=Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(RepertoireExocourant)]);

              DMcorrections.TaCorrection.Close;
              DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;
              DMcorrections.TaCorrection.TableName:=dmrech.TaEcritureRech.TableName;
              DeFiltrageDataSet(DMcorrections.TaCorrection);

  GestionGauge(10,Gauge);

              //traitement table Ecriture Qt1_Report_Debit,Qt1_Report_Credit
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select E.id,E.Qt1 from ecriture E ,plancpt P');
              DMcorrections.QuCorrectionDossier.SQL.add('where E.compte=P.compte and e."date" < :DateDeb and');
              DMcorrections.QuCorrectionDossier.SQL.add('((e.debitSaisie>0');
              DMcorrections.QuCorrectionDossier.SQL.add('and ((P.sensCredit=true and e.Qt1>0)or(P.sensCredit=false and e.Qt1<0)))');
              DMcorrections.QuCorrectionDossier.SQL.add('or');
              DMcorrections.QuCorrectionDossier.SQL.add('(e.CreditSaisie>0');
              DMcorrections.QuCorrectionDossier.SQL.add('and ((P.sensCredit=true and e.Qt1<0)or(P.sensCredit=false and e.Qt1>0))))');
              DMcorrections.QuCorrectionDossier.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
              DMcorrections.QuCorrectionDossier.open;
              DMcorrections.QuCorrectionDossier.first;
              while not DMcorrections.QuCorrectionDossier.Eof do
                Begin
                  if DMcorrections.TaCorrection.Locate('id',DMcorrections.QuCorrectionDossier.FindField('id').Asinteger,[])then
                    begin
                        tablegereEdit(DMcorrections.TaCorrection);
                        DMcorrections.TaCorrection.FindField('Qt1').AsFloat:=-1*(DMcorrections.TaCorrection.FindField('Qt1').AsFloat);
                        TableGerePost(DMcorrections.TaCorrection);
                    end;
                  DMcorrections.QuCorrectionDossier.next;
                end;

  GestionGauge(20,Gauge);

              //traitement table Ecriture Qt2_Report_Debit,Qt2_Report_Credit
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select E.id,E.Qt2 from ecriture E ,plancpt P');
              DMcorrections.QuCorrectionDossier.SQL.add('where E.compte=P.compte and e."date" < :DateDeb and');
              DMcorrections.QuCorrectionDossier.SQL.add('((e.debitSaisie>0');
              DMcorrections.QuCorrectionDossier.SQL.add('and ((P.sensCredit=true and e.Qt2>0)or(P.sensCredit=false and e.Qt2<0)))');
              DMcorrections.QuCorrectionDossier.SQL.add('or');
              DMcorrections.QuCorrectionDossier.SQL.add('(e.CreditSaisie>0');
              DMcorrections.QuCorrectionDossier.SQL.add('and ((P.sensCredit=true and e.Qt2<0)or(P.sensCredit=false and e.Qt2>0))))');
              DMcorrections.QuCorrectionDossier.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
              DMcorrections.QuCorrectionDossier.open;
              DMcorrections.QuCorrectionDossier.first;
              while not DMcorrections.QuCorrectionDossier.Eof do
                Begin
                  if DMcorrections.TaCorrection.Locate('id',DMcorrections.QuCorrectionDossier.FindField('id').Asinteger,[])then
                    begin
                        tablegereEdit(DMcorrections.TaCorrection);
                        DMcorrections.TaCorrection.FindField('Qt2').AsFloat:=-1*(DMcorrections.TaCorrection.FindField('Qt2').AsFloat);
                        TableGerePost(DMcorrections.TaCorrection);
                    end;
                  DMcorrections.QuCorrectionDossier.next;
                end;
//        //fin traitement des ecritures de 1ère ouverture

  GestionGauge(20,Gauge);
        for i:=0 to ListeExercices.Count-1 do
          begin //pour tous les execices existants du dossier
              RepertoireExocourant:=str_getstringelement(ListeExercices.Strings[i],1,';');
              RepertoireExoNMoins1:=str_getstringelement(ListeExercices.Strings[0],3,';');
              //chercher les infos sur les dates de l'exercice en question
              //pour filtrer les ecritures en fonction de ces dates
              //et ne modifier que les exercices non clôturés
              DeFiltrageDataSet(dmrech.TaGestDossierRech);
              InfosGestDossier:=Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(RepertoireExocourant)]);

  GestionGauge(10,Gauge);
                    DMcorrections.QuCorrectionExo.Close;
                    DMcorrections.QuCorrectionExo.SQL.Clear;
                    DMcorrections.QuCorrectionExo.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" ');
                    DMcorrections.QuCorrectionExo.SQL.add('set  Qt1_Report=0,Qt2_Report=0,Qt1_Base=0,Qt2_Base=0');
                    DMcorrections.QuCorrectionExo.ExecSQL;


  GestionGauge(10,Gauge);
              ///traitement des ecritures ////
              /////////////////////////////////////////////////////////

              DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
              //traitement table Ecriture Qt1_base_Debit,Qt1_base_Credit
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select E.id,E.Qt1 from ecriture E ,plancpt P');
              DMcorrections.QuCorrectionDossier.SQL.add('where E.compte=P.compte and e."date" between :dateDeb and :Datefin and');
              DMcorrections.QuCorrectionDossier.SQL.add('((e.debitSaisie>0');
              DMcorrections.QuCorrectionDossier.SQL.add('and ((P.sensCredit=true and e.Qt1>0)or(P.sensCredit=false and e.Qt1<0)))');
              DMcorrections.QuCorrectionDossier.SQL.add('or');
              DMcorrections.QuCorrectionDossier.SQL.add('(e.CreditSaisie>0');
              DMcorrections.QuCorrectionDossier.SQL.add('and ((P.sensCredit=true and e.Qt1<0)or(P.sensCredit=false and e.Qt1>0))))');
              DMcorrections.QuCorrectionDossier.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
              DMcorrections.QuCorrectionDossier.ParamByName('Datefin').asdatetime:=InfosGestDossier.DATE_FIN_EXO;
              DMcorrections.QuCorrectionDossier.open;
              DMcorrections.QuCorrectionDossier.first;
              while not DMcorrections.QuCorrectionDossier.Eof do
                Begin
                  if DMcorrections.TaCorrection.Locate('id',DMcorrections.QuCorrectionDossier.FindField('id').Asinteger,[])then
                    begin
                        tablegereEdit(DMcorrections.TaCorrection);
                        DMcorrections.TaCorrection.FindField('Qt1').AsFloat:=-1*(DMcorrections.TaCorrection.FindField('Qt1').AsFloat);
                        TableGerePost(DMcorrections.TaCorrection);
                    end;
                  DMcorrections.QuCorrectionDossier.next;
                end;

  GestionGauge(20,Gauge);
              //traitement table Ecriture Qt2_base_Debit,Qt2_base_Credit
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('select E.id,E.Qt2 from ecriture E ,plancpt P');
              DMcorrections.QuCorrectionDossier.SQL.add('where E.compte=P.compte and e."date" between :dateDeb and :Datefin and');
              DMcorrections.QuCorrectionDossier.SQL.add('((e.debitSaisie>0');
              DMcorrections.QuCorrectionDossier.SQL.add('and ((P.sensCredit=true and e.Qt2>0)or(P.sensCredit=false and e.Qt2<0)))');
              DMcorrections.QuCorrectionDossier.SQL.add('or');
              DMcorrections.QuCorrectionDossier.SQL.add('(e.CreditSaisie>0');
              DMcorrections.QuCorrectionDossier.SQL.add('and ((P.sensCredit=true and e.Qt2<0)or(P.sensCredit=false and e.Qt2>0))))');
              DMcorrections.QuCorrectionDossier.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
              DMcorrections.QuCorrectionDossier.ParamByName('Datefin').asdatetime:=InfosGestDossier.DATE_FIN_EXO;
              DMcorrections.QuCorrectionDossier.open;
              DMcorrections.QuCorrectionDossier.first;
              while not DMcorrections.QuCorrectionDossier.Eof do
                Begin
                  if DMcorrections.TaCorrection.Locate('id',DMcorrections.QuCorrectionDossier.FindField('id').Asinteger,[])then
                    begin
                        tablegereEdit(DMcorrections.TaCorrection);
                        DMcorrections.TaCorrection.FindField('Qt2').AsFloat:=-1*(DMcorrections.TaCorrection.FindField('Qt2').AsFloat);
                        TableGerePost(DMcorrections.TaCorrection);
                    end;
                  DMcorrections.QuCorrectionDossier.next;
                end;

              ///traitement de la balance par rapport aux ecritures ////
              /////////////////////////////////////////////////////////

  GestionGauge(10,Gauge);
               if RepertoireExoNMoins1=RepertoireExocourant then
                   begin
                  //traitement table chargeAPayer en report
                  DMcorrections.QuCorrectionExo.Close;
                  DMcorrections.QuCorrectionExo.SQL.Clear;
                  DMcorrections.QuCorrectionExo.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt1_report=Qt1_report+(select sum(C.Qte)');
                  DMcorrections.QuCorrectionExo.SQL.add('from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'chargeAPayer" C');
                  DMcorrections.QuCorrectionExo.SQL.add('where B.compte=C.compte and C.Datesaisie <:dateDeb)');
                  DMcorrections.QuCorrectionExo.SQL.add('where B.compte in (select compte from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'chargeAPayer" where Qte is not null and Datesaisie <:dateDeb)');
                  DMcorrections.QuCorrectionExo.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
                  DMcorrections.QuCorrectionExo.ExecSQL;


      GestionGauge(10,Gauge);
                  //traitement table PCA en report
                  DMcorrections.QuCorrectionExo.Close;
                  DMcorrections.QuCorrectionExo.SQL.Clear;
                  DMcorrections.QuCorrectionExo.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt1_report=Qt1_report+(select sum(C.Qte)');
                  DMcorrections.QuCorrectionExo.SQL.add('from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'PCA" C');
                  DMcorrections.QuCorrectionExo.SQL.add('where B.compte=C.compte and C.Datesaisie <:dateDeb)');
                  DMcorrections.QuCorrectionExo.SQL.add('where B.compte in (select compte from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'PCA" where Qte is not null and Datesaisie <:dateDeb)');
                  DMcorrections.QuCorrectionExo.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
                  DMcorrections.QuCorrectionExo.ExecSQL;


      GestionGauge(10,Gauge);
                  //traitement table Stock en report
                  DMcorrections.QuCorrectionExo.Close;
                  DMcorrections.QuCorrectionExo.SQL.Clear;
                  DMcorrections.QuCorrectionExo.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt1_report=Qt1_report+(select sum(C.Qte)');
                  DMcorrections.QuCorrectionExo.SQL.add('from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'Stock" C');
                  DMcorrections.QuCorrectionExo.SQL.add('where B.compte=C.compte and C.Date_saisie <:dateDeb)');
                  DMcorrections.QuCorrectionExo.SQL.add('where B.compte in (select compte from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'Stock" where Qte is not null and Date_saisie <:dateDeb)');
                  DMcorrections.QuCorrectionExo.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
                  DMcorrections.QuCorrectionExo.ExecSQL;
              end;

  GestionGauge(20,Gauge);
              //traitement de la balance Qt1_Base
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt1_Base= Qt1_Base+');
              DMcorrections.QuCorrectionDossier.SQL.add('(select sum (Qt1) from ecriture E where');
              DMcorrections.QuCorrectionDossier.SQL.add('E."date" between :dateDeb and :Datefin');
              DMcorrections.QuCorrectionDossier.SQL.add('and E.compte=B.compte )');
              DMcorrections.QuCorrectionDossier.SQL.add('where B.compte in (select compte from ecriture where Qt1 is not null and ecriture."date" between :dateDeb and :Datefin)');
              DMcorrections.QuCorrectionDossier.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
              DMcorrections.QuCorrectionDossier.ParamByName('Datefin').asdatetime:=InfosGestDossier.DATE_FIN_EXO;
              DMcorrections.QuCorrectionDossier.ExecSQL;

  GestionGauge(10,Gauge);
              //traitement de la balance Qt2_Base
              DMcorrections.QuCorrectionDossier.Close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt2_Base= Qt2_Base+');
              DMcorrections.QuCorrectionDossier.SQL.add('(select sum (Qt2) from ecriture E where');
              DMcorrections.QuCorrectionDossier.SQL.add('E."date" between :dateDeb and :Datefin');
              DMcorrections.QuCorrectionDossier.SQL.add('and E.compte=B.compte )');
              DMcorrections.QuCorrectionDossier.SQL.add('where B.compte in (select compte from ecriture where Qt2 is not null and ecriture."date" between :dateDeb and :Datefin)');
              DMcorrections.QuCorrectionDossier.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
              DMcorrections.QuCorrectionDossier.ParamByName('Datefin').asdatetime:=InfosGestDossier.DATE_FIN_EXO;
              DMcorrections.QuCorrectionDossier.ExecSQL;

    GestionGauge(10,Gauge);
               if RepertoireExoNMoins1=RepertoireExocourant then
                    begin //si première année, alors je prend ce qu'il y a dans les tables d'ouverture
                    //+ les dettes et créances

                        //traitement de la balance Qt1_Report
                        DMcorrections.QuCorrectionDossier.Close;
                        DMcorrections.QuCorrectionDossier.SQL.Clear;
                        DMcorrections.QuCorrectionDossier.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt1_Report= Qt1_Report+');
                        DMcorrections.QuCorrectionDossier.SQL.add('(select sum (Qt1) from ecriture E where');
                        DMcorrections.QuCorrectionDossier.SQL.add('E."date" < :dateDeb ');
                        DMcorrections.QuCorrectionDossier.SQL.add('and E.compte=B.compte )');
                        DMcorrections.QuCorrectionDossier.SQL.add('where B.compte in (select compte from ecriture where Qt1 is not null and ecriture."date" < :dateDeb)');
                        DMcorrections.QuCorrectionDossier.SQL.add('and B.compte < ''6'' ');
                        DMcorrections.QuCorrectionDossier.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
                        DMcorrections.QuCorrectionDossier.ExecSQL;


        GestionGauge(10,Gauge);
                        //traitement de la balance Qt2_Report
                        DMcorrections.QuCorrectionDossier.Close;
                        DMcorrections.QuCorrectionDossier.SQL.Clear;
                        DMcorrections.QuCorrectionDossier.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt2_Report= Qt2_Report+');
                        DMcorrections.QuCorrectionDossier.SQL.add('(select sum (Qt2) from ecriture E where');
                        DMcorrections.QuCorrectionDossier.SQL.add('E."date" < :dateDeb ');
                        DMcorrections.QuCorrectionDossier.SQL.add('and E.compte=B.compte )');
                        DMcorrections.QuCorrectionDossier.SQL.add('where B.compte in (select compte from ecriture where Qt2 is not null and ecriture."date" < :dateDeb)');
                        DMcorrections.QuCorrectionDossier.SQL.add('and B.compte < ''6'' ');
                        DMcorrections.QuCorrectionDossier.ParamByName('dateDeb').asdatetime:=InfosGestDossier.DATE_DEB_EXO;
                        DMcorrections.QuCorrectionDossier.ExecSQL;
                    end
                  else
                    Begin//sinon, je prend le solde fin de l'année antérieur seulement 
                        //traitement de la balance Qt1_Report
//                       showmessage(RepertoireExoNMoins1);
                        DMcorrections.QuCorrectionDossier.Close;
                        DMcorrections.QuCorrectionDossier.SQL.Clear;
                        DMcorrections.QuCorrectionDossier.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt1_Report= ');
                        DMcorrections.QuCorrectionDossier.SQL.add('(select sum(Qt1_Report+Qt1_base) from "'+IncludeTrailingPathDelimiter(RepertoireExoNMoins1)+'balance.db" B2 where');
                        DMcorrections.QuCorrectionDossier.SQL.add(' B2.compte=B.compte and B.compte < ''6'')');
                        DMcorrections.QuCorrectionDossier.ExecSQL;


        GestionGauge(10,Gauge);
                        //traitement de la balance Qt2_Report
                        DMcorrections.QuCorrectionDossier.Close;
                        DMcorrections.QuCorrectionDossier.SQL.Clear;
                        DMcorrections.QuCorrectionDossier.SQL.add('update "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'balance.db" B set Qt2_Report= ');
                        DMcorrections.QuCorrectionDossier.SQL.add('(select sum(Qt2_Report+Qt2_base) from "'+IncludeTrailingPathDelimiter(RepertoireExoNMoins1)+'balance.db" B2 where');
                        DMcorrections.QuCorrectionDossier.SQL.add(' B2.compte=B.compte and B.compte < ''6'')');
                        DMcorrections.QuCorrectionDossier.ExecSQL;
                    end;
          end;//fin pour tous les execices existants du dossier
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
GestionGauge(0,Gauge,0,0,'',false);
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  Initialise_TStringlist(ListeExercices);
  DMcorrections.QuCorrectionExo.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


Function CorrectionDesIntitulePBilan_Bic(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
Libelle:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=0;
        result.retour:=true;
 result.NomModule:='CorrectionDesIntitulePBilan_Bic';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des intitulés du Bilan Bic?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
          DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasProgram;
          DMcorrections.TaCorrection.TableName:='PBilan_Bic';
//          DMcorrections.TaCorrection.OnFilterRecord:=DMcorrections.TaCorrectionFilterRecordIntituleBic;
          DMcorrections.TaCorrection.OnFilterRecord:=nil;
          FiltrageDataSet(DMcorrections.TaCorrection,'');
          DMcorrections.TaCorrection.first;
          while not (DMcorrections.TaCorrection.eof) do
            Begin
              TableGereEdit(DMcorrections.TaCorrection);
              //Libelle:=DMPlan.LibelleDuNumCptPCU(DMcorrections.TaCorrection.findfield('compte').asstring);
              Libelle:=DMPlan.LibelleDuNumCpt(DMcorrections.TaCorrection.findfield('compte').asstring);
              DMcorrections.TaCorrection.FindField('intitule').asstring:=Libelle;
              TableGerePost(DMcorrections.TaCorrection);
            DMcorrections.TaCorrection.next;
            end;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.TaCorrection.close;
  DMcorrections.TaCorrection.OnFilterRecord:=nil;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;




procedure TDMcorrections.TaCorrectionFilterRecordIntituleBic(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if not((csDestroying)in DataSet.ComponentState) then
    begin
      accept:=DataSet.findfield('Intitule').asstring='';
    end;
end;

Function CorrectionDesSubdivisionsNonAffectesPBilan_Bic(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
CompteTrouve:TCompteTrouve;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=0;
        result.retour:=true;
 result.NomModule:='CorrectionDesSubdivisionsNonAffectesPBilan_Bic';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des Subdivisions Non Affectées du Bilan Bic?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        DMcorrections.TaCorrection.active:=false;
          DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasProgram;
          DMcorrections.TaCorrection.TableName:='PBilan_Bic';
          DMcorrections.TaCorrection.OnFilterRecord:=nil;
          FiltrageDataSet(DMcorrections.TaCorrection,'');
//je traite les soldes fin
//          DMcorrections.QuCorrectionProgram.close;
//          DMcorrections.QuCorrectionProgram.DatabaseName:=DM_C_NomAliasProgram;
//          DMcorrections.QuCorrectionProgram.SQL.Clear;
//          DMcorrections.QuCorrectionProgram.SQL.Add('select * from PBilan_Bic where SoldeFinDebit is null or SoldeFinCredit is null');
//          DMcorrections.QuCorrectionProgram.open;
//
//          DMcorrections.QuCorrectionProgram.first;
//          while not (DMcorrections.QuCorrectionProgram.eof) do
//            Begin
//             DMcorrections.initialise_TCompteTrouve(CompteTrouve);
//             CompteTrouve.compte:=DMcorrections.QuCorrectionProgram.findfield('compte').AsString;
//              while CompteTrouve.trouve=false do
//                Begin
//                   CompteTrouve.compte:=str_Suppr_N_Car_ADroite(CompteTrouve.compte,1);
//                   if empty(CompteTrouve.compte) then break;
//                   CompteTrouve.trouve:=DMcorrections.TaCorrection.Locate('Compte',comptetrouve.compte,[]);
//                   if CompteTrouve.trouve then CompteTrouve.trouve:=not empty(DMcorrections.TaCorrection.FindField('SoldeFinDebit').asstring);
//                   if CompteTrouve.trouve then
//                     Begin
//                       CompteTrouve.SoldeFinDebit:=DMcorrections.TaCorrection.FindField('SoldeFinDebit').asstring;
//                       CompteTrouve.SoldeFinCredit:=DMcorrections.TaCorrection.FindField('SoldeFinCredit').asstring;
//                       CompteTrouve.SoldeReportDebit:=DMcorrections.TaCorrection.FindField('SoldeReportDebit').asstring;
//                       CompteTrouve.SoldeReportCredit:=DMcorrections.TaCorrection.FindField('SoldeReportCredit').asstring;
//                     end;
//                end;
//              if ((CompteTrouve.trouve)and(DMcorrections.TaCorrection.Locate('Compte',DMcorrections.QuCorrectionProgram.findfield('compte').AsString,[]))) then
//                  begin
//                      TableGereEdit(DMcorrections.TaCorrection);
//                      DMcorrections.TaCorrection.FindField('SoldeFinDebit').asstring:='00';
//                      DMcorrections.TaCorrection.FindField('SoldeFinCredit').asstring:='00';
//                      TableGerePost(DMcorrections.TaCorrection);
//                  end;
//            DMcorrections.QuCorrectionProgram.next;
//            end;
//fin des soldes fin

//je traite les reports
          DMcorrections.QuCorrectionProgram.close;
          DMcorrections.QuCorrectionProgram.DatabaseName:=DM_C_NomAliasProgram;
          DMcorrections.QuCorrectionProgram.SQL.Clear;
          DMcorrections.QuCorrectionProgram.SQL.Add('select * from PBilan_Bic where SoldeReportDebit is null or SoldeReportCredit is null');
          DMcorrections.QuCorrectionProgram.open;

          DMcorrections.QuCorrectionProgram.first;
          while not (DMcorrections.QuCorrectionProgram.eof) do
            Begin
             DMcorrections.initialise_TCompteTrouve(CompteTrouve);
             CompteTrouve.compte:=DMcorrections.QuCorrectionProgram.findfield('compte').AsString;
              while CompteTrouve.trouve=false do
                Begin
                   CompteTrouve.compte:=str_Suppr_N_Car_ADroite(CompteTrouve.compte,1);
                   if empty(CompteTrouve.compte) then break;
                   CompteTrouve.trouve:=DMcorrections.TaCorrection.Locate('Compte',comptetrouve.compte,[]);
                   if CompteTrouve.trouve then CompteTrouve.trouve:=not empty(DMcorrections.TaCorrection.FindField('SoldeReportDebit').asstring);
                   if CompteTrouve.trouve then
                     Begin
                       CompteTrouve.SoldeFinDebit:=DMcorrections.TaCorrection.FindField('SoldeFinDebit').asstring;
                       CompteTrouve.SoldeFinCredit:=DMcorrections.TaCorrection.FindField('SoldeFinCredit').asstring;
                       CompteTrouve.SoldeReportDebit:=DMcorrections.TaCorrection.FindField('SoldeReportDebit').asstring;
                       CompteTrouve.SoldeReportCredit:=DMcorrections.TaCorrection.FindField('SoldeReportCredit').asstring;
                     end;
                end;
              if ((CompteTrouve.trouve)and(DMcorrections.TaCorrection.Locate('Compte',DMcorrections.QuCorrectionProgram.findfield('compte').AsString,[]))) then
                  begin
                      TableGereEdit(DMcorrections.TaCorrection);
                      DMcorrections.TaCorrection.FindField('SoldeReportDebit').asstring:='00';
                      DMcorrections.TaCorrection.FindField('SoldeReportCredit').asstring:='00';
                      TableGerePost(DMcorrections.TaCorrection);
                  end;
            DMcorrections.QuCorrectionProgram.next;
            end;
//fin des reports
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.TaCorrection.close;
  DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;
  DMcorrections.TaCorrection.OnFilterRecord:=nil;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;


procedure TDMcorrections.initialise_TCompteTrouve(Var CompteTrouve:TCompteTrouve);
begin
CompteTrouve.compte:=C_StrVide;
CompteTrouve.trouve:=false;
CompteTrouve.SoldeFinDebit:=C_StrVide;
CompteTrouve.SoldeFinCredit:=C_StrVide;
CompteTrouve.SoldeReportDebit:=C_StrVide;
CompteTrouve.SoldeReportCredit:=C_StrVide;
end;

//

//

Function RecuperationDesComptesSurZoneBilan(DemandeConfirmation:boolean):texceptlgr;
var
Zone1,Zone2,TypeFormulaire:string;
Confirmation:boolean;
ListeComptes,ListeEdit,ListePieces:Tstringlist;
compte:string;
i,J,k:integer;
TotalPiece:currency;
Import_E2FAC:PImport_E2FAC;
Ligne:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=0;
        result.retour:=true;
 result.NomModule:='RecuperationDesComptesSurZoneBilan';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;

ListeComptes:=TStringList.Create;
ListeEdit:=TStringList.Create;
ListePieces:=TStringList.Create;

 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la récupération des comptes par rapport aux zones saisies ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin

        PatienterAffich;
        TypeFormulaire:=UpperCase(InputBox('Saisir un type','','2150'));
        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasProgram;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('select col1 from "Paramlia_bic_Essai"');
        DMcorrections.QuCorrectionDossier.SQL.add('where type = '''+TypeFormulaire+'''');
//        DMcorrections.QuCorrectionDossier.SQL.add('where col1='''+Zone+'''');
        DMcorrections.QuCorrectionDossier.open;
        DMcorrections.QuCorrectionDossier.first;
        j:=2;
        k:=1;
        while not DMcorrections.QuCorrectionDossier.eof do
          Begin
             try//except
//              Zone1:=UpperCase(InputBox('Saisir une Zone','','AA'));
              Zone1:=UpperCase(DMcorrections.QuCorrectionDossier.findfield('col1').asstring);
              DMcorrections.QuCorrectionProgram.Close;
              DMcorrections.QuCorrectionProgram.DatabaseName:=DM_C_NomAliasProgram;
              DMcorrections.QuCorrectionProgram.SQL.Clear;
              DMcorrections.QuCorrectionProgram.SQL.add('select col2 from "Paramlia_bic_Essai"');
              DMcorrections.QuCorrectionProgram.SQL.add('where col1='''+Zone1+'''');
              DMcorrections.QuCorrectionProgram.open;

              if DMcorrections.QuCorrectionProgram.recordcount=0 then
                raise ExceptLGR.Create('Pas de retour pour la zone : '+Zone1,result.NumErreur,true,mtError,Result);

              Zone2:= DMcorrections.QuCorrectionProgram.findfield('col2').asstring;
              DMcorrections.QuCorrectionProgram.Close;
              DMcorrections.QuCorrectionProgram.SQL.Clear;
              DMcorrections.QuCorrectionProgram.SQL.add('select compte,soldeReportDebit,soldeReportCredit,soldefinDebit,soldefinCredit,"Paramlia_bic_Essai".col1');
              DMcorrections.QuCorrectionProgram.SQL.add('from pbilan_bic,"Paramlia_bic_Essai" where');
              DMcorrections.QuCorrectionProgram.SQL.add('(substring(soldeReportDebit from 2)='''+Zone2+''' or');
              DMcorrections.QuCorrectionProgram.SQL.add('substring(soldeReportCredit from 2)='''+Zone2+''' or');
              DMcorrections.QuCorrectionProgram.SQL.add('substring(soldefinDebit from 2)='''+Zone2+''' or');
              DMcorrections.QuCorrectionProgram.SQL.add('substring(soldefinCredit from 2)='''+Zone2+''')');
              DMcorrections.QuCorrectionProgram.SQL.add('and "Paramlia_bic_Essai".col2='''+Zone2+'''');
              DMcorrections.QuCorrectionProgram.open;
              if DMcorrections.QuCorrectionProgram.recordcount=0 then
                raise ExceptLGR.Create('Pas de retour pour la zone : '+Zone2+' liée à la zone : '+zone1,result.NumErreur,false,mtError,Result);
              except
                 result.retour:=true;
              end;
             ListeComptes:=ChampTableVersListeEx(['Compte','SoldeReportDebit','SoldeReportCredit','SoldefinDebit','SoldefinCredit','Col1'],DMcorrections.QuCorrectionProgram,';',false);
             New(Import_E2FAC);
             for i:=0 to ListeComptes.count-1 do
               begin
                 ListeEdit.Add(ListeComptes.strings[i]);
                 //remplir une pièce pour l'importer
                //Remplissage de la liste pour création de l'OD
                compte:=str_getstringelement(ListeComptes.strings[i],1,';');
                while length(compte)<3 do
                  compte:=compte+'0';

               if ListePieces.count<100 then
                 begin
                     InitialisePImport(Import_E2FAC);
                            Import_E2FAC.NumPiece:=StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumLigne:=StrNbCaractere(inttostr(j),' ',3);
                            inc(j);
                            Import_E2FAC.DatePiece:=DateInfos(e.DatExoDebut,true).DateStrFormat;
                            Import_E2FAC.TypePiece:='O';
                            Import_E2FAC.CompteLigne:=StrNbCaractere(compte,' ',8);
//                            Import_E2FAC.MontantDebit:=StrNbCaractere(currtostr(StrToCurr_Lgr(compte)),' ',12);
                            Import_E2FAC.MontantCredit:=StrNbCaractere(currtostr(StrToCurr_Lgr(compte+'0')),' ',12);
                               Ligne:=Import_E2FAC.NumPiece
                                    +Import_E2FAC.NumLigne
                                    +Import_E2FAC.TypePiece
                                    +Import_E2FAC.Reference
                                    +Import_E2FAC.DatePiece
                                    +Import_E2FAC.CompteLigne
                                    +Import_E2FAC.Libelle
                                    +Import_E2FAC.MontantDebit
                                    +Import_E2FAC.MontantCredit
                                    +Import_E2FAC.Qte1
                                    +Import_E2FAC.Qte2
                                    +Import_E2FAC.CodeTVA
                                    +Import_E2FAC.TauxTVA
                                    +Import_E2FAC.MontantDebitTVA
                                    +Import_E2FAC.MontantCreditTVA
                                    +Import_E2FAC.DateEcheancePiece
                                    +Import_E2FAC.CompteColl
                                    +Import_E2FAC.Adr1
                                    +Import_E2FAC.Adr2
                                    +Import_E2FAC.CodePostal
                                    +Import_E2FAC.Ville
                                    +Import_E2FAC.ExibiliteTVA
                                    +Import_E2FAC.DateLivraisonLigne;
                           ListePieces.Add(ligne);
                    TotalPiece:=TotalPiece+strtocurr_lgr(compte+'0');
                end
                else
                  begin
                     InitialisePImport(Import_E2FAC);
                            Import_E2FAC.NumPiece:=StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumLigne:=StrNbCaractere('1',' ',3);
                            Import_E2FAC.DatePiece:=DateInfos(e.DatExoDebut,true).DateStrFormat;
                            Import_E2FAC.TypePiece:='O';
                            Import_E2FAC.CompteLigne:=StrNbCaractere('1081',' ',8);
                            Import_E2FAC.MontantDebit:=StrNbCaractere(currtostr(TotalPiece),' ',12);
//                            Import_E2FAC.MontantCredit:=StrNbCaractere(currtostr(TotalPiece),' ',12);
                            Import_E2FAC.Libelle:='Pièce pour Bic_'+TypeFormulaire+'_'+inttostr(k);
                               Ligne:=Import_E2FAC.NumPiece
                                    +Import_E2FAC.NumLigne
                                    +Import_E2FAC.TypePiece
                                    +Import_E2FAC.Reference
                                    +Import_E2FAC.DatePiece
                                    +Import_E2FAC.CompteLigne
                                    +Import_E2FAC.Libelle
                                    +Import_E2FAC.MontantDebit
                                    +Import_E2FAC.MontantCredit
                                    +Import_E2FAC.Qte1
                                    +Import_E2FAC.Qte2
                                    +Import_E2FAC.CodeTVA
                                    +Import_E2FAC.TauxTVA
                                    +Import_E2FAC.MontantDebitTVA
                                    +Import_E2FAC.MontantCreditTVA
                                    +Import_E2FAC.DateEcheancePiece
                                    +Import_E2FAC.CompteColl
                                    +Import_E2FAC.Adr1
                                    +Import_E2FAC.Adr2
                                    +Import_E2FAC.CodePostal
                                    +Import_E2FAC.Ville
                                    +Import_E2FAC.ExibiliteTVA
                                    +Import_E2FAC.DateLivraisonLigne;
                           ListePieces.Add(ligne);
                        ListePieces.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ListePiecesPourZoneBilan_'+TypeFormulaire+'_'+inttostr(k)+'.txt');
                        CreationODPourVerificationBilan_Bic('ListePiecesPourZoneBilan_'+TypeFormulaire+'_'+inttostr(k)+'.txt',ListePieces);
                        inc(k);
                        Initialise_TStringlist(ListePieces,DMcorrections,false);
                        TotalPiece:=0;
                     InitialisePImport(Import_E2FAC);
                            Import_E2FAC.NumPiece:=StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumLigne:=StrNbCaractere(inttostr(j),' ',3);
                            inc(j);
                            Import_E2FAC.TypePiece:='O';
                            Import_E2FAC.DatePiece:=DateInfos(e.DatExoDebut,true).DateStrFormat;
                            Import_E2FAC.CompteLigne:=StrNbCaractere(compte,' ',8);
//                            Import_E2FAC.MontantDebit:=StrNbCaractere(currtostr(StrToCurr_Lgr(compte)),' ',12);
                            Import_E2FAC.MontantCredit:=StrNbCaractere(currtostr(StrToCurr_Lgr(compte+'0')),' ',12);
                               Ligne:=Import_E2FAC.NumPiece
                                    +Import_E2FAC.NumLigne
                                    +Import_E2FAC.TypePiece
                                    +Import_E2FAC.Reference
                                    +Import_E2FAC.DatePiece
                                    +Import_E2FAC.CompteLigne
                                    +Import_E2FAC.Libelle
                                    +Import_E2FAC.MontantDebit
                                    +Import_E2FAC.MontantCredit
                                    +Import_E2FAC.Qte1
                                    +Import_E2FAC.Qte2
                                    +Import_E2FAC.CodeTVA
                                    +Import_E2FAC.TauxTVA
                                    +Import_E2FAC.MontantDebitTVA
                                    +Import_E2FAC.MontantCreditTVA
                                    +Import_E2FAC.DateEcheancePiece
                                    +Import_E2FAC.CompteColl
                                    +Import_E2FAC.Adr1
                                    +Import_E2FAC.Adr2
                                    +Import_E2FAC.CodePostal
                                    +Import_E2FAC.Ville
                                    +Import_E2FAC.ExibiliteTVA
                                    +Import_E2FAC.DateLivraisonLigne;
                           ListePieces.Add(ligne);
                    TotalPiece:=TotalPiece+strtocurr_lgr(compte+'0');
                  end;
               end;
             Initialise_TStringlist(listecomptes,DMcorrections,false);
             DMcorrections.QuCorrectionDossier.next;
          end;
                     InitialisePImport(Import_E2FAC);     // StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumPiece:=StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumLigne:=StrNbCaractere('1',' ',3);
                            Import_E2FAC.TypePiece:='O';
                            Import_E2FAC.DatePiece:=DateInfos(e.DatExoDebut,true).DateStrFormat;
                            Import_E2FAC.CompteLigne:=StrNbCaractere('1081',' ',8);
                            Import_E2FAC.MontantDebit:=StrNbCaractere(currtostr(TotalPiece),' ',12);
//                            Import_E2FAC.MontantCredit:=StrNbCaractere(currtostr(TotalPiece),' ',12);
                            Import_E2FAC.Libelle:='Pièce pour Bic_'+TypeFormulaire+'_'+inttostr(k);
                               Ligne:=Import_E2FAC.NumPiece
                                    +Import_E2FAC.NumLigne
                                    +Import_E2FAC.TypePiece
                                    +Import_E2FAC.Reference
                                    +Import_E2FAC.DatePiece
                                    +Import_E2FAC.CompteLigne
                                    +Import_E2FAC.Libelle
                                    +Import_E2FAC.MontantDebit
                                    +Import_E2FAC.MontantCredit
                                    +Import_E2FAC.Qte1
                                    +Import_E2FAC.Qte2
                                    +Import_E2FAC.CodeTVA
                                    +Import_E2FAC.TauxTVA
                                    +Import_E2FAC.MontantDebitTVA
                                    +Import_E2FAC.MontantCreditTVA
                                    +Import_E2FAC.DateEcheancePiece
                                    +Import_E2FAC.CompteColl
                                    +Import_E2FAC.Adr1
                                    +Import_E2FAC.Adr2
                                    +Import_E2FAC.CodePostal
                                    +Import_E2FAC.Ville
                                    +Import_E2FAC.ExibiliteTVA
                                    +Import_E2FAC.DateLivraisonLigne;
                           ListePieces.Add(ligne);
        ListePieces.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ListePiecesPourZoneBilan_'+TypeFormulaire+'_'+inttostr(k)+'.txt');
        CreationODPourVerificationBilan_Bic('ListePiecesPourZoneBilan_'+TypeFormulaire+'_'+inttostr(k)+'.txt',ListePieces);
        ListeEdit.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ListeComptePourZone.txt');
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  Initialise_TStringlist(ListeComptes);
  Initialise_TStringlist(ListeEdit);
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionProgram.close;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;



Function RecuperationDesComptesBilanBIC(DemandeConfirmation:boolean):texceptlgr;
var
CompteDeb,CompteFin:string;
Confirmation:boolean;
ListeComptes,ListePieces:Tstringlist;
compte:string;
i,J,k:integer;
TotalPiece:currency;
Import_E2FAC:PImport_E2FAC;
Ligne:string;
Vide:string[60];
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=0;
        result.retour:=true;
 result.NomModule:='RecuperationDesComptesBilanBIC';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;

ListeComptes:=TStringList.Create;
ListePieces:=TStringList.Create;

 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la récupération des comptes du BIC ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin

        PatienterAffich;
        j:=2;
        k:=1;
        Vide:=StrNbCaractere('',' ',60);

              DMcorrections.QuCorrectionProgram.Close;
              DMcorrections.QuCorrectionProgram.SQL.Clear;
              DMcorrections.QuCorrectionProgram.SQL.add('select compte');
              DMcorrections.QuCorrectionProgram.SQL.add('from pbilan_bic where SoldeFinDebit<>''00''');
              DMcorrections.QuCorrectionProgram.SQL.add('order by compte');
              DMcorrections.QuCorrectionProgram.open;
              DMcorrections.QuCorrectionProgram.first;
             ListeComptes:=ChampTableVersListeEx(['Compte'],DMcorrections.QuCorrectionProgram,';',true);
             New(Import_E2FAC);
             for i:=0 to ListeComptes.count-1 do
               begin
                 //remplir une pièce pour l'importer
                //Remplissage de la liste pour création de l'OD
                compte:=str_getstringelement(ListeComptes.strings[i],1,';');
                while length(compte)<3 do
                  compte:=compte+'0';
//               if (((compte >='16881')and (compte <='206')))or(((compte >='236')and (compte <='273')))
//               or(((compte >='2977')and (compte <='395')))or(((compte >='396')and (compte <='4086')))
//               or(((compte >='4087')and (compte <='415')))or(((compte >='510')and (compte <='601'))) then
              if ((compte >='2977')and (compte <='471')) then
               begin
               if i=0 then
                 CompteDeb:=compte;
               if ListePieces.count<20 then
                 begin
                     InitialisePImport(Import_E2FAC);
                           CompteFin:=compte;
                            Import_E2FAC.NumPiece:=StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumLigne:=StrNbCaractere(inttostr(j),' ',3);
                            inc(j);
                            Import_E2FAC.DatePiece:=DateInfos(e.DatExoDebut,true).DateStrFormat;
                            Import_E2FAC.TypePiece:='O';
                            //Import_E2FAC.Reference:='OD0000001';
                            //Import_E2FAC.Libelle:='Pièce importée'
                            Import_E2FAC.CompteLigne:=StrNbCaractere(compte,' ',8,false);
                            Import_E2FAC.MontantDebit:=StrNbCaractere(FormatCurr('0.00;-0.00;0.00',StrToCurr_Lgr(compte)),' ',12);
//                            Import_E2FAC.MontantCredit:=StrNbCaractere(FormatCurr('0.00;-0.00;0.00',StrToCurr_Lgr(compte+'0')),' ',12);
                               Ligne:=Import_E2FAC.NumPiece
                                    +Import_E2FAC.NumLigne
                                    +Import_E2FAC.TypePiece
                                    +Import_E2FAC.Reference
                                    +Import_E2FAC.DatePiece
                                    +Import_E2FAC.CompteLigne
                                    +Import_E2FAC.Libelle
                                    +Import_E2FAC.MontantDebit
                                    +Import_E2FAC.MontantCredit
                                    +Import_E2FAC.Qte1
                                    +Import_E2FAC.Qte2
                                    +Import_E2FAC.CodeTVA
                                    +Import_E2FAC.TauxTVA
                                    +Import_E2FAC.MontantDebitTVA
                                    +Import_E2FAC.MontantCreditTVA
                                    +Import_E2FAC.DateEcheancePiece
                                    +Import_E2FAC.CompteColl
                                    +Import_E2FAC.Adr1
                                    +Import_E2FAC.Adr2
                                    +Import_E2FAC.CodePostal
                                    +Import_E2FAC.Ville
                                    +Import_E2FAC.ExibiliteTVA
                                    +Import_E2FAC.DateLivraisonLigne
                                    +Vide;
                           ListePieces.Add(ligne);
                    TotalPiece:=TotalPiece+strtocurr_lgr(compte);//pour le Debit
//                    TotalPiece:=TotalPiece+strtocurr_lgr(compte+'0'); //pour le crédit
                end
                else
                  begin
                     InitialisePImport(Import_E2FAC);
                           //CompteFin:=compte;
                            Import_E2FAC.NumPiece:=StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumLigne:=StrNbCaractere('1',' ',3);
                            Import_E2FAC.DatePiece:=DateInfos(e.DatExoDebut,true).DateStrFormat;
                            Import_E2FAC.TypePiece:='O';
                            Import_E2FAC.CompteLigne:=StrNbCaractere('1081',' ',8,false);
//                            Import_E2FAC.MontantDebit:=StrNbCaractere(FormatCurr('0.00;-0.00;0.00',TotalPiece),' ',12);
                            Import_E2FAC.MontantCredit:=StrNbCaractere(FormatCurr('0.00;-0.00;0.00',TotalPiece),' ',12);
                            Import_E2FAC.Libelle:=StrNbCaractere('Debit_'+CompteDeb+'_'+CompteFin,' ',23,false);;
//                            Import_E2FAC.Libelle:=StrNbCaractere('Crédit_'+CompteDeb+'_'+CompteFin,' ',23,false);;
                               Ligne:=Import_E2FAC.NumPiece
                                    +Import_E2FAC.NumLigne
                                    +Import_E2FAC.TypePiece
                                    +Import_E2FAC.Reference
                                    +Import_E2FAC.DatePiece
                                    +Import_E2FAC.CompteLigne
                                    +Import_E2FAC.Libelle
                                    +Import_E2FAC.MontantDebit
                                    +Import_E2FAC.MontantCredit
                                    +Import_E2FAC.Qte1
                                    +Import_E2FAC.Qte2
                                    +Import_E2FAC.CodeTVA
                                    +Import_E2FAC.TauxTVA
                                    +Import_E2FAC.MontantDebitTVA
                                    +Import_E2FAC.MontantCreditTVA
                                    +Import_E2FAC.DateEcheancePiece
                                    +Import_E2FAC.CompteColl
                                    +Import_E2FAC.Adr1
                                    +Import_E2FAC.Adr2
                                    +Import_E2FAC.CodePostal
                                    +Import_E2FAC.Ville
                                    +Import_E2FAC.ExibiliteTVA
                                    +Import_E2FAC.DateLivraisonLigne
                                    +Vide;
                           ListePieces.Add(ligne);
                        ListePieces.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ListePiecesPourZoneBilan_'+CompteDeb+'_auCpt_'+CompteFin+'.txt');
                        //CreationODPourVerificationBilan_Bic('ListePiecesPourZoneBilan_'+CompteDeb+'_auCpt_'+CompteFin+'.txt',ListePieces);
                        compteDeb:=compte;
                        inc(k);
                        Initialise_TStringlist(ListePieces,DMcorrections,false);
                        TotalPiece:=0;
                     InitialisePImport(Import_E2FAC);
                    CompteFin:=compte;
                            Import_E2FAC.NumPiece:=StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumLigne:=StrNbCaractere(inttostr(j),' ',3);
                            inc(j);
                            Import_E2FAC.TypePiece:='O';
                            Import_E2FAC.DatePiece:=DateInfos(e.DatExoDebut,true).DateStrFormat;
                            Import_E2FAC.CompteLigne:=StrNbCaractere(compte,' ',8,false);
                            Import_E2FAC.MontantDebit:=StrNbCaractere(FormatCurr('0.00;-0.00;0.00',StrToCurr_Lgr(compte)),' ',12);
//                            Import_E2FAC.MontantCredit:=StrNbCaractere(FormatCurr('0.00;-0.00;0.00',StrToCurr_Lgr(compte+'0')),' ',12);
                               Ligne:=Import_E2FAC.NumPiece
                                    +Import_E2FAC.NumLigne
                                    +Import_E2FAC.TypePiece
                                    +Import_E2FAC.Reference
                                    +Import_E2FAC.DatePiece
                                    +Import_E2FAC.CompteLigne
                                    +Import_E2FAC.Libelle
                                    +Import_E2FAC.MontantDebit
                                    +Import_E2FAC.MontantCredit
                                    +Import_E2FAC.Qte1
                                    +Import_E2FAC.Qte2
                                    +Import_E2FAC.CodeTVA
                                    +Import_E2FAC.TauxTVA
                                    +Import_E2FAC.MontantDebitTVA
                                    +Import_E2FAC.MontantCreditTVA
                                    +Import_E2FAC.DateEcheancePiece
                                    +Import_E2FAC.CompteColl
                                    +Import_E2FAC.Adr1
                                    +Import_E2FAC.Adr2
                                    +Import_E2FAC.CodePostal
                                    +Import_E2FAC.Ville
                                    +Import_E2FAC.ExibiliteTVA
                                    +Import_E2FAC.DateLivraisonLigne
                                    +Vide;
                           ListePieces.Add(ligne);
                    TotalPiece:=TotalPiece+strtocurr_lgr(compte);//pour le Debit
//                    TotalPiece:=TotalPiece+strtocurr_lgr(compte+'0'); //pour le crédit
                  end;
          end;//si dans fourchettes de comptes
          end;
          if ListePieces.Count<>0 then
            begin//traitement dernier sortie de boucle
                     InitialisePImport(Import_E2FAC);
                     CompteFin:=compte;
                            Import_E2FAC.NumPiece:=StrNbCaractere('1',' ',5);
                            Import_E2FAC.NumLigne:=StrNbCaractere('1',' ',3);
                            Import_E2FAC.DatePiece:=DateInfos(e.DatExoDebut,true).DateStrFormat;
                            Import_E2FAC.TypePiece:='O';
                            Import_E2FAC.CompteLigne:=StrNbCaractere('1081',' ',8,false);
//                            Import_E2FAC.MontantDebit:=StrNbCaractere(FormatCurr('0.00;-0.00;0.00',TotalPiece),' ',12);
                            Import_E2FAC.MontantCredit:=StrNbCaractere(FormatCurr('0.00;-0.00;0.00',TotalPiece),' ',12);
                            Import_E2FAC.Libelle:=StrNbCaractere('Debit_'+CompteDeb+'_'+CompteFin,' ',23,false);;
//                            Import_E2FAC.Libelle:=StrNbCaractere('Crédit_'+CompteDeb+'_'+CompteFin,' ',23,false);;
                               Ligne:=Import_E2FAC.NumPiece
                                    +Import_E2FAC.NumLigne
                                    +Import_E2FAC.TypePiece
                                    +Import_E2FAC.Reference
                                    +Import_E2FAC.DatePiece
                                    +Import_E2FAC.CompteLigne
                                    +Import_E2FAC.Libelle
                                    +Import_E2FAC.MontantDebit
                                    +Import_E2FAC.MontantCredit
                                    +Import_E2FAC.Qte1
                                    +Import_E2FAC.Qte2
                                    +Import_E2FAC.CodeTVA
                                    +Import_E2FAC.TauxTVA
                                    +Import_E2FAC.MontantDebitTVA
                                    +Import_E2FAC.MontantCreditTVA
                                    +Import_E2FAC.DateEcheancePiece
                                    +Import_E2FAC.CompteColl
                                    +Import_E2FAC.Adr1
                                    +Import_E2FAC.Adr2
                                    +Import_E2FAC.CodePostal
                                    +Import_E2FAC.Ville
                                    +Import_E2FAC.ExibiliteTVA
                                    +Import_E2FAC.DateLivraisonLigne
                                    +Vide;
                           ListePieces.Add(ligne);
                        ListePieces.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ListePiecesPourZoneBilan_'+CompteDeb+'_auCpt_'+CompteFin+'.txt');
                        //CreationODPourVerificationBilan_Bic('ListePiecesPourZoneBilan_'+CompteDeb+'_auCpt_'+CompteFin+'.txt',ListePieces);
            end;//fin traitement dernier sortie de boucle
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  Initialise_TStringlist(ListeComptes);
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionProgram.close;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;



procedure CreationODPourVerificationBilan_Bic(NomFichier:string;ListeComptes:Tstringlist;CompteContrepartie:string;LibellePiece:string;DatePiece:string);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
ValPieceAutoGen:TValPieceAutoGenere;
i:integer;
NomRep:string;
Begin
   try
     try
       listeFactice:=nil;
       if dmpieces=nil then Dmpieces:=TDMPieces.Create(application.MainForm);
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(dmpieces.TaPiece);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=StrToDate_Lgr(DatePiece,e.DatExoDebut);
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Compte:=StrToStr_Lgr(CompteContrepartie,'','1081');
       SourcePiece.Libelle:=StrToStr_Lgr(LibellePiece,'','Pièce importée');
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:='';
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
//       if ListeComptes=nil then
         Begin
           ListeComptes:=TStringList.Create;
           NomRep:=e.RepertoireProgram;
//           if ChercheFileDialog(NomRep,NomFichier,'.txt',true,'Saisir le chemin du fichier')then
           if FileExistDialog(Nomrep,Nomfichier,true)then
             ListeComptes.LoadFromFile(NomRep+NomFichier)
           else
             raise ExceptLGR.Create('',0,false,mtError);
           //InputBox('Saisir le chemin du fichier','Ex: C:\Mes Documents',));
         end;
       //remplissage des lignes pour l'OD

       DMImport.Import_Piece_SurType(nil,true,NomFichier,C_IMPORT_SARA)

//       for i:=0 to ListeComptes.count-1 do
//         DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,[
//                  strtostr_lgr(str_getstringelement(ListeComptes.strings[i],1,';'),'','H'),//Type Ligne
//                  str_getstringelement(ListeComptes.strings[i],2,';'),//Compte
//                  str_getstringelement(ListeComptes.strings[i],3,';'), //compte tiers
//                  strtostr_lgr(str_getstringelement(ListeComptes.strings[i],4,';'),'',''),//Libellé
//                  strtofloat_lgr(str_getstringelement(ListeComptes.strings[i],5,';')),//Qt1
//                  strtofloat_lgr(str_getstringelement(ListeComptes.strings[i],6,';')),//Qt2
//                  strtocurr_lgr(str_getstringelement(ListeComptes.strings[i],7,';')),//Montant HT Préciser le signe
//                  strtocurr_lgr(str_getstringelement(ListeComptes.strings[i],8,';')),//Montant TVA  Préciser le signe
//                  str_getstringelement(ListeComptes.strings[i],9,';'),//Compte Tva
//                  str_getstringelement(ListeComptes.strings[i],10,';'),// Code Tva
//                  strtocurr_lgr(str_getstringelement(ListeComptes.strings[i],11,';')),//Taux Tva
//                  str_getstringelement(ListeComptes.strings[i],12,';'),//Type Tva
//                  str_getstringelement(ListeComptes.strings[i],13,';')//Date Tva
//                  ],true,false,-1);
//       DMImport.RecupPieceEcriture_SurRecords(true,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
//       ListeOd:=TStringList.Create;
//       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
//       DMPieces.AffichageFeuilleReprise(0,ListeOd,nil,'Affichage des nouvelles pièces créées','','',false);
     except
      abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMcorrections,false);
   end;//fin du try finally
End;

Procedure InitialisePImport(var Import_E2FAC:PImport_E2FAC);
Begin
Import_E2FAC.NumPiece:=StrNbCaractere('',' ',5);  //
Import_E2FAC.NumLigne:=StrNbCaractere('',' ',3);
Import_E2FAC.TypePiece:=StrNbCaractere('',' ',1);
Import_E2FAC.Reference:=StrNbCaractere('',' ',9);
Import_E2FAC.DatePiece:=StrNbCaractere('',' ',8);;
Import_E2FAC.CompteLigne:=StrNbCaractere('',' ',8);;
Import_E2FAC.Libelle:=StrNbCaractere('',' ',23);;
Import_E2FAC.MontantDebit:=StrNbCaractere('0.00',' ',12);;
Import_E2FAC.MontantCredit:=StrNbCaractere('0.00',' ',12);;
Import_E2FAC.Qte1:=StrNbCaractere('0.00',' ',9);;
Import_E2FAC.Qte2:=StrNbCaractere('0.00',' ',9);;
Import_E2FAC.CodeTVA:=StrNbCaractere('',' ',1);;
Import_E2FAC.TauxTVA:=StrNbCaractere('0.00',' ',6);;
Import_E2FAC.MontantDebitTVA:=StrNbCaractere('0.00',' ',11);;
Import_E2FAC.MontantCreditTVA:=StrNbCaractere('0.00',' ',11);;
Import_E2FAC.DateEcheancePiece:=StrNbCaractere('',' ',8);;
Import_E2FAC.CompteColl:=StrNbCaractere('',' ',8);;
Import_E2FAC.NomTiers:=StrNbCaractere('',' ',30);;
Import_E2FAC.Adr1:=StrNbCaractere('',' ',30);;
Import_E2FAC.Adr2:=StrNbCaractere('',' ',30);;
Import_E2FAC.CodePostal:=StrNbCaractere('',' ',5);;
Import_E2FAC.Ville:=StrNbCaractere('',' ',25);;
Import_E2FAC.ExibiliteTVA:=StrNbCaractere('',' ',1);;
Import_E2FAC.DateLivraisonLigne:=StrNbCaractere('',' ',8);;
Import_E2FAC.Enregistrer:='0';
Import_E2FAC.CompteTva:=StrNbCaractere('',' ',8);;
End;





Function RecupExerciceDossier_Tous(idDossier:integer):Tstringlist;
var
ExceptLGRTmp:TExceptLGR;
Requete:TQuery;
ExoNMoins1:string;
begin
 result:=TStringList.Create;
Initialise_ExceptLGR(ExceptLGRTmp,GestMessageLGR);
// ExceptLGRTmp.GestMessageLGR:=GestMessageLGR;
 ExceptLGRTmp.NomModule:='RecupExerciceDossier';
 ExceptLGRTmp.GestMessageLGR.Enregistrement:=true;
  try//finally
    Requete:=TQuery.Create(application.MainForm);
    Requete.DatabaseName:=DM_C_NomAliasProgram;
      try//except
        if idDossier=0 then
         begin
           ExoNMoins1:=IncludeTrailingPathDelimiter(E.RepertoireProgram)+DM_C_NomAliasDemo+'\'+DM_C_NomAliasExoDemo;
           result.Add(IncludeTrailingPathDelimiter(E.RepertoireProgram)+DM_C_NomAliasDemo+'\'+DM_C_NomAliasExoDemo+';'+e.ExerciceBase+';'+ExoNMoins1+';'+e.ExerciceSaisie);
         end
        else
         begin
           // raise ExceptLGR.Create('IDDossier vide',0000,false,mtError,ExceptLGRTmp);
         // if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
          //FiltrageDataSet(DMRech.TaGestDossierRech,'id_Dossier='+inttostr(idDossier)+' and cloture=faux');
          Requete.sql.Add('select Dir_Exo,Exo_Saisie,Exo_Base,cloture,Date_Deb_Exo,Date_Fin_Exo from GestDossier');
          Requete.sql.Add('where id_dossier=:Dossier');
          Requete.sql.Add('Order by Date_Deb_Exo,Date_Fin_Exo');
          Requete.ParamByName('Dossier').asinteger:=idDossier;
          Requete.Open;
          Requete.first;
          ExoNMoins1:=IncludeTrailingPathDelimiter(Requete.findfield('Dir_Exo').AsString);
          while not(Requete.eof) do
            begin
              result.Add(IncludeTrailingPathDelimiter(Requete.findfield('Dir_Exo').AsString)+';'+Requete.findfield('Exo_Base').AsString
              +';'+ExoNMoins1+';'+Requete.findfield('Exo_Saisie').AsString);
              ExoNMoins1:=IncludeTrailingPathDelimiter(Requete.findfield('Dir_Exo').AsString);
              Requete.next;
            end;
         end;
      except
        result:=nil;
      end;
  finally
  Requete.close;
    LibereObjet(TObject(Requete));
//    DeFiltrageDataSet(DMRech.TaGestDossierRech);
    ExceptLGRTmp.GestMessageLGR.Enregistrement:=false;
  end;
end;


Function ModeleCorrection(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ReferenceOD:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=0;
result.retour:=true;
 result.NomModule:='ModeleCorrection';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);

 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le  ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;

        DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;
        DMcorrections.TaCorrection.TableName:=dmrech.TaH_TVARech.TableName;

        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


Function VerificationsDesPointagesSurReste_Inf_0(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=8001;
        result.retour:=true;
 result.NomModule:='VerificationsDesPointagesSurReste_Inf_0';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
          if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
          if dmpieces=nil then dmpieces:=Tdmpieces.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des pointages par rapport au Reste à pointer ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
          //verification si tous les pointages de la tables pointages correspondent bien à des lignes
          //contenant des tiers ou des comptes pointables non collectifs.
        PatienterAffich;


          DMcorrections.QuCorrectionDossier.Close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.SQL.add('select * from pointage Po where id_debit in (select id_ecriture from restedc dc where reste<0)');
          DMcorrections.QuCorrectionDossier.open;

          DMcorrections.QuCorrectionDossier.first;
          while not(DMcorrections.QuCorrectionDossier.eof)do
            Begin
              if not dmpieces.piece1.Verification_TvaDeclare_Pointage_new(true,DMcorrections.QuCorrectionDossier.findfield('ID_Debit').AsInteger,DMcorrections.QuCorrectionDossier.findfield('ID_Credit').AsInteger).retour then
                 raise ExceptLGR.Create('Verification_TvaDeclare_Pointage 1: le pointage entre les ecritures '+DMcorrections.QuCorrectionDossier.findfield('ID_Debit').Asstring+' - '+DMcorrections.QuCorrectionDossier.findfield('ID_Credit').Asstring+' rentre dans une période déclarée',Result.NumErreur,false,mtError,Result);
              //supprimer directement les pointages qui portent sur des comptes non pointables
              DMcorrections.QuCorrectionPointage.Close;
              DMcorrections.QuCorrectionPointage.SQL.Clear;
              DMcorrections.QuCorrectionPointage.SQL.add('Update pointage set montant=Montant+');
              DMcorrections.QuCorrectionPointage.SQL.add('(select reste from restedc dc where dc.id_ecriture=Po.id_debit)');
              DMcorrections.QuCorrectionPointage.SQL.add('where id=:idPointage');
              DMcorrections.QuCorrectionPointage.ParamByName('idPointage').asinteger:=DMcorrections.QuCorrectionDossier.findfield('id').AsInteger;
              DMcorrections.QuCorrectionPointage.ExecSQL;
              ///
              DMcorrections.QuCorrectionDossier.next;
            end;

    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
    DMcorrections.QuCorrectionDossier.Close;
    DMcorrections.QuCorrectionPointage.Close;
  PatienterFermer;
 result.GestMessageLGR.Enregistrement:=false;
end;
end;


Function ControleTVASurType(DemandeConfirmation:boolean;MessageErreur:boolean):texceptlgr;
var
Confirmation:boolean;
ReferenceOD:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=17000;
result.retour:=true;
 result.NomModule:='ControleTVASurType';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);

 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de la TVA ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
          //verif sur la date mal remplie sur type D
          result.NumErreur:=17000;
          DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.sql.Add('select * from ecriture E');
          DMcorrections.QuCorrectionDossier.sql.Add('where e.tvatype=''D'' and tvaDate is null and e.compte between ''6'' and ''79999999''');
          DMcorrections.QuCorrectionDossier.sql.Add('and not exists (select id_ecriture from h_tva where en_attente=false and e.id=id_ecriture)');
          DMcorrections.QuCorrectionDossier.open;
          DMcorrections.QuCorrectionDossier.first;
          result.retour:=DMcorrections.QuCorrectionDossier.recordcount=0;

          if result.retour then
            begin
              //verif sur type mal rempli
              result.NumErreur:=17001;
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.sql.Add('select * from ecriture E');
              DMcorrections.QuCorrectionDossier.sql.Add('where e.tvatype<>''D'' and e.tvatype<>''E'' and tvacode is not null and e.compte between ''6'' and ''79999999''');
              DMcorrections.QuCorrectionDossier.open;
              DMcorrections.QuCorrectionDossier.first;
              result.retour:=DMcorrections.QuCorrectionDossier.recordcount=0;
            end;

        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
//       if ((MessageErreur)or(result.NumErreur=17001)) then
       if MessageErreur then
         raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'_'+inttostr(DMcorrections.QuCorrectionDossier.recordcount)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


Function CorrectionTVASurTypeD(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ReferenceOD:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=17001;
result.retour:=true;
 result.NomModule:='CorrectionTVASurTypeD';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);

 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la correction de la TVA ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
          DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          //Update des lignes hors taxes avec type D sans date tva
            DMcorrections.QuCorrectionDossier.sql.Add('Update ecriture E set tvaDate=(select P."date" from piece P where P.id=E.id_piece)');
            DMcorrections.QuCorrectionDossier.sql.Add('where e.tvatype=''D'' and tvaDate is null and e.compte between ''6'' and ''79999999''');
            DMcorrections.QuCorrectionDossier.sql.Add('and not e.id in (select id_ecriture from h_tva where en_attente=false)');
          //fin update
          DMcorrections.QuCorrectionDossier.ExecSQL;
        result:=ControleTVASurType(DemandeConfirmation,false);
        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


Function ControleTVAEnAttente(Gauge:TGauge;DateDeb,DateFin:Tdatetime;Calcul:boolean;DemandeConfirmation:boolean;MessageErreur:boolean;correction:boolean):texceptlgr;
var
Confirmation:boolean;
ListeCodeTVATmp,ListeTmp:Tstringlist;
i,j,id,id_Decl:integer;
TotauxCompte:TTotauxBalance;
Solde,HTRecup:currency;
TauxTva:real;
//
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
ListeCodeTVATmp:=TStringList.Create;
ListeTmp:=TStringList.Create;
result.NumErreur:=18000;
result.retour:=true;
 result.NomModule:='ControleTVAEnAttente';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
GestionGauge(100,Gauge,1000,0,'Contrôle de la Tva en attente');
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMTmTVA=nil then DMTmTVA:=TDMTmTVA.Create(Application.MainForm);
        if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de la TVA en attente?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        if correction then
          begin
            ReinitialisationH_Tva_AvantControle;
            deletefile(pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt'));
          end;
          //verif sur la tva en attente
          if calcul then
            begin
              GestionGauge(100,Gauge,-1,-1,'Calcul de la Tva');
              result.retour:=CalculDeclarationTva(DateDeb,DateFin,false);
            end;
          AffichInfoDeclarationTVA(RqDec_Tva_SommeTvaParCode_1,false);
          FiltrageDataSet(DMREch.TaTvaCodeRech,'compte <> null');
          ListeTmp:=ChampTableVersListeEx(['TvaCode','Compte'],DMREch.TaTvaCodeRech,';',false);
          //passage pour les lignes qui remplissent la condition suivante :
          // selection des lignes dont la date pièce est > à la date fin periode tva et
          //la date tva est <= à la date fin période tva et de type tva 'D'.
          for i:=0 to ListeTmp.Count-1 do
            Begin
              GestionGauge((800 div ListeTmp.Count),Gauge,-1,-1,'Contrôle de la Tva en attente');
              DMTmTVA.QuDec_Tva_VisuListe.Close;
              DMTmTVA.QuDec_Tva_VisuListe.SQL.Clear;
              DMTmTVA.QuDec_Tva_VisuListe.SQL.Add(RqDec_Tva_SommeTvaParCode_2);
              DMTmTVA.QuDec_Tva_VisuListe.ParamByName('datefin').AsDate:=DateFin;
              DMTmTVA.QuDec_Tva_VisuListe.ParamByName('Code').asstring:=str_getstringelement(ListeTmp.Strings[i],1,';') ;
              DMTmTVA.QuDec_Tva_VisuListe.open;
              DMTmTVA.QuDec_Tva_VisuListe.first;
              while not (DMTmTVA.QuDec_Tva_VisuListe.eof)do
                Begin
                   if DMTmTVA.QuDec_Tva_VisuListe.Locate('En_Attente',false,[]) then
                     ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(DMTmTVA.QuDec_Tva_VisuListe.FindField('TottvaMontantDebit').Ascurrency-DMTmTVA.QuDec_Tva_VisuListe.FindField('TottvaMontantCredit').Ascurrency)
                   else
                     ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';0';
                   if DMTmTVA.QuDec_Tva_VisuListe.Locate('En_Attente',true,[]) then
                     ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(DMTmTVA.QuDec_Tva_VisuListe.FindField('TottvaMontantDebit').Ascurrency-DMTmTVA.QuDec_Tva_VisuListe.FindField('TottvaMontantCredit').Ascurrency)
                   else
                     ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';0';//
                 //total
                 ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(strtocurr_lgr(str_getstringelement(ListeTmp.Strings[i],3,';'))+StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],4,';')));
                 ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(0);
   //              ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(strtocurr_lgr(str_getstringelement(ListeTmp.Strings[i],3,';'))+StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],4,';'))-strtocurr(str_getstringelement(ListeTmp.Strings[i],6,';')))+';';
                    ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],6,';'))-(strtocurr_lgr(str_getstringelement(ListeTmp.Strings[i],3,';'))+StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],4,';'))))+';';
              ListeTmp.Strings[i]:=ListeTmp.Strings[i]+'*;';
                 ListeTmp.Strings[i]:=ListeTmp.Strings[i]+'-4;';
                 if str_getstringelement(ListeTmp.Strings[i],7,';')<>'0' then ListeCodeTVATmp.add(ListeTmp.strings[i]);
//                 if ((str_getstringelement(ListeTmp.Strings[i],5,';')<>'0')or(str_getstringelement(ListeTmp.Strings[i],6,';')<>'0'))then ListeCodeTVATmp.add(ListeTmp.strings[i]);
                 DMTmTVA.QuDec_Tva_VisuListe.next;
                end;
            end;
          //passage sur les autres lignes qui ne remplissent pas la condition
          ListeTmp.clear;
          ListeTmp:=ChampTableVersListeEx(['TvaCode','Compte'],DMREch.TaTvaCodeRech,';',false);
          for i:=0 to ListeTmp.Count-1 do
            Begin
              GestionGauge((800 div ListeTmp.Count),Gauge,-1,-1,'Contrôle de la Tva en attente');
              DMTmTVA.QuDec_Tva_VisuListe.Close;
              DMTmTVA.QuDec_Tva_VisuListe.SQL.Clear;
              DMTmTVA.QuDec_Tva_VisuListe.SQL.Add(RqDec_Tva_SommeTvaParCode_3);
              DMTmTVA.QuDec_Tva_VisuListe.ParamByName('datefin').AsDate:=DateFin;
              DMTmTVA.QuDec_Tva_VisuListe.ParamByName('Code').asstring:=str_getstringelement(ListeTmp.Strings[i],1,';') ;
              DMTmTVA.QuDec_Tva_VisuListe.open;
              DMTmTVA.QuDec_Tva_VisuListe.first;
              while not (DMTmTVA.QuDec_Tva_VisuListe.eof)do
                Begin
                   if DMTmTVA.QuDec_Tva_VisuListe.Locate('En_Attente',false,[]) then
                     ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(DMTmTVA.QuDec_Tva_VisuListe.FindField('TottvaMontantDebit').Ascurrency-DMTmTVA.QuDec_Tva_VisuListe.FindField('TottvaMontantCredit').Ascurrency)
                   else
                     ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';0';
                   if DMTmTVA.QuDec_Tva_VisuListe.Locate('En_Attente',true,[]) then
                     ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(DMTmTVA.QuDec_Tva_VisuListe.FindField('TottvaMontantDebit').Ascurrency-DMTmTVA.QuDec_Tva_VisuListe.FindField('TottvaMontantCredit').Ascurrency)
                   else
                     ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';0';//
                 //total
                  ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(strtocurr_lgr(str_getstringelement(ListeTmp.Strings[i],3,';'))+StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],4,';')));
                  TotauxCompte:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,DateFin,str_getstringelement(ListeTmp.Strings[i],2,';'));
                  if TotauxCompte.SoldeDebitCreditFin then
                    ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(TotauxCompte.SoldeFin)
                  else
                    ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(-TotauxCompte.SoldeFin);
      //           ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(strtocurr_lgr(str_getstringelement(ListeTmp.Strings[i],3,';'))+StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],4,';'))-StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],6,';')))+';';
                 ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';'+currtostr(StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],6,';'))-(strtocurr_lgr(str_getstringelement(ListeTmp.Strings[i],3,';'))+StrToCurr_Lgr(str_getstringelement(ListeTmp.Strings[i],4,';'))))+';';
                 ListeTmp.Strings[i]:=ListeTmp.Strings[i]+';';
                 ListeTmp.Strings[i]:=ListeTmp.Strings[i]+'-3;';
                 if str_getstringelement(ListeTmp.Strings[i],7,';')<>'0' then ListeCodeTVATmp.add(ListeTmp.strings[i]);
//               if ((str_getstringelement(ListeTmp.Strings[i],5,';')<>'0')or(str_getstringelement(ListeTmp.Strings[i],6,';')<>'0'))then ListeCodeTVATmp.add(ListeTmp.strings[i]);
                 DMTmTVA.QuDec_Tva_VisuListe.next;
                end;
            end;
          for i:=0 to ListeCodeTVATmp.Count-1 do
            Begin
              result.retour:=currtostr(strtocurr_lgr(str_getstringelement(ListeCodeTVATmp.Strings[i],3,';'))+StrToCurr_Lgr(str_getstringelement(ListeCodeTVATmp.Strings[i],4,';')))=str_getstringelement(ListeCodeTVATmp.Strings[i],6,';');
              if not result.retour then abort;
            end;
                           //strtocurr_lgr(str_getstringelement(ListeCodeTVA.Strings[i],,';'))
        PatienterFermer
    end;
except
  ListeCodeTVATmp.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt');
  result.retour:=false;
end;
finally
  AffichInfoDeclarationTVA(RqDec_Tva_SommeTvaParCode_1,false);
  DeFiltrageDataSet(DMTmTVA.QuDec_Tva_VisuListe);
  DeFiltrageDataSet(DMREch.TaTvaCodeRech);
    try
    if result.retour=false then
       if MessageErreur then
         raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result)
       else
           if correction then
             begin //si correction
              id_Decl:=-3;
              for i:=0 to ListeCodeTVATmp.Count-1 do
                Begin       //str_getstringelement(ListeCodeTVA.Strings[i],2,';')
                   solde:=strtocurr_lgr(str_getstringelement(ListeCodeTVATmp.Strings[i],7,';'));
                   if ((abs(solde)>0)and(str_getstringelement(ListeCodeTVATmp.Strings[i],9,';')=inttostr(id_Decl))) then
                     begin//si solde <>0
                         DeFiltrageDataSet(DMRech.TaH_TVARech);
                         DMRech.TaH_TVARech.Refresh;
                         id:=MaxId_Query(DMRech.TaH_TVARech,'ID');
                         DeFiltrageDataSet(dmrech.TaH_TVARech);
                         DeFiltrageDataSet(DMRech.TaTvaCodeRech);
                         TauxTva:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[str_getstringelement(ListeCodeTVATmp.Strings[i],1,';')]).Taux_Supp;
                         HTRecup:=0;
                         if TauxTva<>0 then
                            HTRecup:= (solde*100)/TauxTva;
                         HTRecup:=arrondi(HTRecup,2);
                         DMcorrections.QuCorrectionInsert.Close;
                         DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;                                           //  Debut_Periode,Fin_Periode,
                         DMcorrections.QuCorrectionInsert.SQL.Clear;
                         DMcorrections.QuCorrectionInsert.SQL.add('insert into H_Tva');
                         DMcorrections.QuCorrectionInsert.SQL.add('(Part_declaree,Taux,id,id_Ecriture,ID_Declaration,verrouillee,deverrouillable,en_attente,Montanttva,HTDeclare,Divers,CodeCompensation)');
                         DMcorrections.QuCorrectionInsert.SQL.add('values(1,'+str_QueDesChiffresCurr_SQL(Floattostr(TauxTva))+','+inttostr(ID)+','+inttostr_lgr(id_Decl)+','+inttostr_lgr(id_Decl)+',''True'',''True'',''false'','
                                                                  +str_QueDesChiffresCurr_SQL(currtostr(solde))+','+str_QueDesChiffresCurr_SQL(currtostr(HTRecup))+','''+str_getstringelement(ListeCodeTVATmp.Strings[i],1,';')+'_'
                                                                  +str_getstringelement(ListeCodeTVATmp.Strings[i],2,';')+'_'
                                                                  +inttostr_lgr(id_Decl)
                                                                  +' _'+inttostr(ID)+''','''+str_getstringelement(ListeCodeTVATmp.Strings[i],1,';')+''')');
                         DMcorrections.QuCorrectionInsert.ExecSQL;
                     end;//fin si solde <>0
                end;
               DeclarationTVATypeRegulation(DateDeb,DateFin);
               //result.retour:=true;
             end;//fin si correction
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  result.GestMessageLGR.Enregistrement:=false;
  Initialise_TStringlist(ListeCodeTVATmp,DMcorrections);
  Initialise_TStringlist(ListeTmp,DMcorrections);
  PatienterFermer;
end;
end;


Function CorrectionDesimmosSurRecalculAmort(Gauge:TGauge;ForcerMarquage:boolean;ForcerControle:boolean;DemandeConfirmation:boolean):texceptlgr;
var
i,j,k:integer;
Confirmation,Trouve:boolean;
ListeExercices,PieceDotationExistante,PieceDotationNew:Tstringlist;
RepertoireExocourant,RepertoireExoNMoins1:string;
InfosGestDossier:TInfosGestDossier;
DBAux:TDataBase;
RepertoireDest,RepertoireSource:string;
RetourTmp,Cloture:boolean;
reference,Marque,Etape:string;
NbMarque:integer;
label Marquage;
label ExoSuivant;
begin
try//finally
try//except
      DBAux:=TDataBase.Create(Application);
      DBAux.DatabaseName:='Tmp';
      DBAux.Params.Add('ENABLE BCD=FALSE');
      DBAux.Params.Add('DEFAULT DRIVER=PARADOX');
      DBAux.TransIsolation:=tiDirtyRead;
      DBAux.DriverName:='Standard';
      DBAux.Params.Add('PATH=' + e.RepertoireExercice);
      DBAux.open;

       if DMImmo_Clo=nil then DMImmo_Clo:=TDMImmo_Clo.Create(application.MainForm);

ListeExercices:=TStringList.Create;
Initialise_ExceptLGR(result,GestMessageLGR);
RetourTmp:=true;
Etape:='0';
result.NumErreur:=6003;
result.retour:=true;
 result.NomModule:='CorrectionDesimmosSurRecalculAmort';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;

 confirmation:=true; ////????????????
//if not ForcerControle then
  //Marque:=e.Exo_A_Verifier;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DataModuleImmos=nil then DataModuleImmos:=TDataModuleImmos.Create(Application.MainForm);

 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des immobilisations par rapport au recalcul des amortissements, Attention, cette procédure peut-être assez longue ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
GestionGauge(10,gauge,100,0,'Contrôle des amortissements');
        ListeExercices:=RecupExerciceDossier_tous(E.ID_Dos);
      if ForcerMarquage then
        begin
          if Application.MessageBox(Pchar('Etes-vous sûr de vouloir marquer le dossier et ignorer le contrôle des amortissements'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
            goto marquage;
        end;
        if ((ListeExercices=nil)or(ListeExercices.Count=0)) then
          raise ExceptLGR.Create('',0,false,mtError)
        else
          if ListeExercices.Count>=2 then
            Begin//si liste exercice >=2
              nbmarque:=Str_Count_Str(';',marque);
              if marque='' then
                Begin//si marque n'est pas faite dans comptaWeb
                    Cloture:=false;
                    nbmarque:=1;
                    for i:=0 to ListeExercices.Count-1 do //on les prend tous sauf le dernier si l'avant dernier n'a pas été cloturé
                      begin //pour tous les exercices existants du dossier
                         if not((cloture=false) and (i=ListeExercices.Count-1)) then//si on est pas sur dernier exercice avec l'avant dernier non cloturé
                           begin
                             marque:=marque+str_getstringelement(ListeExercices.Strings[i],1,';')+';';
                             inc(nbmarque);
                           end;
                    DeFiltrageDataSet(DMRech.TaGestDossierRech);
                    InfosGestDossier:=Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(str_getstringelement(ListeExercices.Strings[i],1,';'))]);
                    Cloture:=InfosGestDossier.Cloture;
                      end;
                end;//fin si marque n'est pas faite dans comptaWeb
              if nbmarque=0 then
                nbmarque:=Str_Count_Str(';',marque);
//              DeFiltrageDataSet(DMcorrections.TaCorrection);
              DMcorrections.TaCorrection.Close;
              DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;
              DMcorrections.TaCorrection.TableName:=str_n_prem_char(DMRech.TaImmosRech.TableName,LastDelimiter('.',DMRech.TaImmosRech.TableName)-1)+'tmp.db';
              for i:=0 to ListeExercices.Count-1 do
                begin //pour tous les exercices existants du dossier
                    RepertoireExocourant:=str_getstringelement(ListeExercices.Strings[i],1,';');
                    RepertoireExoNMoins1:=str_getstringelement(ListeExercices.Strings[i],3,';');
                    reference:='';
                    RetourTmp:=true;
                    DeFiltrageDataSet(dmrech.TaGestDossierRech);
                    DMcorrections.TaCorrection.Close;
                    DBAux.Connected:=false;
                    DBAux.Close;
                    if i=0 then
                      begin
                        RepertoireDest:=RepertoireExoNMoins1;
                        DBAux.Params.Delete(2);
                        DBAux.Params.Add('PATH=' + RepertoireDest);
                      end
                    else
                      begin
                            RepertoireDest:=RepertoireExocourant;
                            DBAux.Params.Delete(2);
                            DBAux.Params.Add('PATH=' + RepertoireDest);
                      end;
                    trouve:=ForcerControle;
                    j:=1;
                    while ((j<= nbmarque)and(trouve=false)) do
                      Begin
                        trouve:=str_getstringelement(marque,j,';')=RepertoireDest;
                        inc(j);
                      end;
                    if trouve then
                        begin
                            //on crée la table immos temporaire
                            DeFiltrageDataSet(DMRech.TaGestDossierRech);
                            InfosGestDossier:=Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(RepertoireDest)]);
        GestionGauge(10,gauge,-1,-1,'Contrôle exercice '+InfosGestDossier.Nom_Exo);
                            RepertoireSource:=e.RepertoireDossier;
                            if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ImmosTmp.DB')then
                              if not DeleteFile(PChar(IncludeTrailingPathDelimiter(RepertoireSource)+'ImmosTmp.DB')) then
                                raise ExceptLGR.Create('Problème à la suppression de la table ImmosTmp.DB',result.NumErreur,false,mtError,Result);
                            if ((FileExists(extractfilepath(RepertoireDest)+'Immos.db'))and(InfosGestDossier.Cloture)) then
                                begin
                                    //on duplique la table de l'exercice en cours
                                    RepertoireSource:=RepertoireDest;
                                    DMcorrections.TaCorrection.Close;
                                    DMcorrections.TaCorrection.DatabaseName:='Tmp';
                                    DMcorrections.TaCorrection.TableName:=dmrech.TaImmosRech.TableName;
                                    DBAux.Connected:=true;
                                    DBAux.open;
                                    //on regarde si table pas déjà corrigée
                                    FiltrageDataSet(DMcorrections.TaCorrection,'id =''-1''');
                                    if ((DMcorrections.TaCorrection.RecordCount<>0)and(not ForcerControle)) then goto ExoSuivant;
                                    DeFiltrageDataSet(DMcorrections.TaCorrection);
                                    SauvegardeImmosExo(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ImmosTmp.DB',RepertoireSource,DMcorrections.TaCorrection);
                                    DMcorrections.TaCorrection.Close;
                                    DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;
                                    DMcorrections.TaCorrection.TableName:=str_n_prem_char(DMRech.TaImmosRech.TableName,LastDelimiter('.',DMRech.TaImmosRech.TableName)-1)+'tmp.db';
                                end
                              else
                                Begin
                                    //sinon on duplique la table immos du dossier
                                    //on regarde si table pas déjà corrigée
                                    FiltrageDataSet(DMRech.TaImmosRech,'id =''-1''');
                                    if ((DMRech.TaImmosRech.RecordCount<>0)and(not ForcerControle)) then goto ExoSuivant;
                                    SauvegardeImmosExo(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ImmosTmp.DB',RepertoireSource);
                                    DeFiltrageDataSet(DMRech.TaImmosRech);
                                end;
                            //commencer le calcul sur table temporaire
                            if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ImmosTmp.DB'))then
                            begin
                                    DMcorrections.TaCorrection.Close;
                                    DMcorrections.TaCorrection.DatabaseName:=DM_C_NomAliasDossier;
                                    DMcorrections.TaCorrection.TableName:=str_n_prem_char(DMRech.TaImmosRech.TableName,LastDelimiter('.',DMRech.TaImmosRech.TableName)-1)+'tmp.db';
                            DeFiltrageDataSet(DMcorrections.TaCorrection);
        GestionGauge(10,gauge,-1,-1,'Recalcul temporaire sur exercice '+InfosGestDossier.Nom_Exo);
        Etape:='1';
                            if DataModuleImmos.RecalculGeneralAmortissement(DMcorrections.TaCorrection,false,InfosGestDossier.DATE_DEB_EXO,InfosGestDossier.DATE_FIN_EXO) then
                              begin//si le calcul se passe bien, on peut comparer les 2 tables
                                 DMRech.TaImmosRech.Refresh;
                                 DataModuleImmos.TaImmosRecalcul.Refresh;
                                 DMcorrections.QuCorrectionExo.Close;                                                                     // (I.choix)as choix_origine,
                                 DMcorrections.QuCorrectionExo.DatabaseName:='Tmp';
                                 DMcorrections.QuCorrectionExo.SQL.Clear;
                                 DMcorrections.QuCorrectionExo.SQL.Add('select I.compte,I.Code,I.sous_code,(I.mini)as mini_Origine,(I.maxi)as maxi_Origine,(I.Eco)as Eco_Origine');
                                 DMcorrections.QuCorrectionExo.SQL.Add(',(I2.Eco)as Eco_Tmp,(I2.mini)as Mini_tmp,(I2.maxi)as Maxi_tmp,(I2.choix)as Choix_tmp from "'+IncludeTrailingPathDelimiter(RepertoireSource)+'immos.db" I,"'+IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immostmp.db" I2');
                                 DMcorrections.QuCorrectionExo.SQL.Add('where ((I.id=I2.id)and((I.mini)<>(I2.mini) or (I.maxi)<>(I2.maxi)or (I.Eco)<>(I2.Eco)))');
                                 DMcorrections.QuCorrectionExo.SQL.Add('order by compte');
                                 DMcorrections.QuCorrectionExo.Open;
        Etape:='2';
                                 RetourTmp:=DMcorrections.QuCorrectionExo.RecordCount=0;
        GestionGauge(10,gauge,-1,-1,'Contrôle différence calcul sur exercice '+InfosGestDossier.Nom_Exo);
                                 ChampTableVersListeEx(DMcorrections.QuCorrectionExo,';',true).SaveToFile(IncludeTrailingPathDelimiter(RepertoireDest)+'CompareTablesImmos.txt');
                              end//fin si le calcul se passe bien, on peut comparer les 2 tables
                            else
                              Begin //si le calcul ne se passe pas correctement
                                 raise ExceptLGR.Create('Problème sur calcul de la table Temporaire',result.NumErreur,true,mtError,Result);
                              end;//fin si le calcul ne se passe pas correctement
                            end;
                            if result.retour=true then
                              result.retour:=RetourTmp;
                            if ((result.retour)and(ListeExercices.Count<=2)and(InfosGestDossier.Cloture=false))then
                              goto Marquage;
                            if ((result.retour=false)and(InfosGestDossier.Cloture=false)) then
                                Begin//si pas ok et pas cloturé et pas de pièce de dotation, alors on recalcul sur table d'origine directement
            GestionGauge(10,gauge,-1,-1,'Vérif si pièce dotation sur exercice '+InfosGestDossier.Nom_Exo);
                                   if VerificationSiPieceDeDotation(reference,InfosGestDossier.DATE_DEB_EXO,InfosGestDossier.DATE_FIN_EXO)=false then
                                     begin
            Etape:='3';
                                         DeFiltrageDataSet(DataModuleImmos.TaImmosRecalcul);
            GestionGauge(10,gauge,-1,-1,'Piece non existante, Recalcul sur table origine sur exercice '+InfosGestDossier.Nom_Exo);
                                         if not DataModuleImmos.RecalculGeneralAmortissement(DataModuleImmos.TaImmosRecalcul,false,InfosGestDossier.DATE_DEB_EXO,InfosGestDossier.DATE_FIN_EXO) then
                                             raise ExceptLGR.Create('Problème sur recalcul de la table d''origine',result.NumErreur,false,mtError,Result)
                                         else
                                           result.retour:=true;
                                      DMRech.TaImmosRech.Refresh;
                                      DataModuleImmos.TaImmosRecalcul.Refresh;
                                     end
                                   else
                                      begin //si pièce de dotation, comparaison entre pièce et table temporaire
                                         ///
                                          try//finally
            GestionGauge(10,gauge,-1,-1,'Piece existante, comparaison des pièces sur exercice '+InfosGestDossier.Nom_Exo);
            Etape:='5';
                                          PieceDotationNew:=Tstringlist.Create;
                                          PieceDotationExistante:=Tstringlist.Create;
                                          DMcorrections.QuCorrectionDossier.Close;
                                          DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
                                          DMcorrections.QuCorrectionDossier.SQL.Clear;
                                          DMcorrections.QuCorrectionDossier.SQL.Add('select E.compte,(E.CreditSaisie-E.DebitSaisie)as Montant from ecriture E,Piece P');
                                          DMcorrections.QuCorrectionDossier.SQL.Add('where P.id=E.id_piece and P.reference=:Ref');
                                          DMcorrections.QuCorrectionDossier.ParamByName('Ref').AsString:=Reference;
                                          DMcorrections.QuCorrectionDossier.Open;
                                          PieceDotationExistante:=ChampTableVersListeEx(['Compte','Montant'],DMcorrections.QuCorrectionDossier,';',true);
                                          PieceDotationNew:=DMImmo_Clo.GenererPieceDotation(Reference,true).Liste;//génère un fichier au lieu de la pièce
                                          PieceDotationExistante.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceDotationExistante.txt');
                                          //maintenant, on compare ce fichier avec la pièce déjà créée
                                          if PieceDotationExistante.count<>PieceDotationNew.count then
                                            raise ExceptLGR.Create('La pièce de dotation existe et il y a une différence entre la pièce existante et celle recalculée',result.NumErreur,false,mtError,Result);
                                          for k:=0 to PieceDotationExistante.count-1 do
                                            Begin
                                               j:=0;
                                               Trouve:=false;
                                               while ((j<=PieceDotationNew.count-1)and (not trouve)) do
                                                 Begin
                                                   if str_getstringelement(PieceDotationNew.Strings[j],1,';')=str_getstringelement(PieceDotationExistante.Strings[k],1,';')then
                                                     trouve:=str_getstringelement(PieceDotationNew.Strings[j],2,';')=str_getstringelement(PieceDotationExistante.Strings[k],2,';');
                                                   inc(j);
                                                 end;
                                             if trouve=false then
                                                 raise ExceptLGR.Create('La pièce de dotation existe et il y a une différence entre la pièce existante et celle recalculée',result.NumErreur,false,mtError,Result)
                                            end;
                                            if trouve then
                                              Begin
                                                 etape:='7';
                                                 DeFiltrageDataSet(DataModuleImmos.TaImmosRecalcul);
                    GestionGauge(10,gauge,-1,-1,'Piece existante correcte, Recalcul sur table origine sur exercice '+InfosGestDossier.Nom_Exo);
                                                 if not DataModuleImmos.RecalculGeneralAmortissement(DataModuleImmos.TaImmosRecalcul,false,InfosGestDossier.DATE_DEB_EXO,InfosGestDossier.DATE_FIN_EXO) then
                                                     raise ExceptLGR.Create('Problème sur recalcul de la table d''origine',result.NumErreur,false,mtError,Result)
                                                 else
                                                   result.retour:=true;
                                              end;
                                          finally
                                             Initialise_TStringlist(PieceDotationNew);
                                             Initialise_TStringlist(PieceDotationExistante);
                                          end;
                                      end;
                                end
                              else
                                if ((result.retour=false)and(InfosGestDossier.Cloture=true)) then
                                  begin//si
            Etape:='6';
                                      raise ExceptLGR.Create('L''exercice est clôturé et il y a un problème sur la table immos de l''exercice "'+RepertoireDest+'"',result.NumErreur,false,mtError,Result);
                                  end;
                            if ((ListeExercices.Count<=2)and(InfosGestDossier.Cloture=false))then
                              goto Marquage;
                        end;//fin si marque trouvée pour l'exercice courant
                ExoSuivant:;
                end;//fin pour tous les exercices existants du dossier
            end;//fin si liste exercice >=2
       Marquage:;
       if result.retour then
        begin
        GestionGauge(10,gauge,-1,-1,'Marquage ');
          for i:=0 to ListeExercices.Count-1 do
            Begin
              //marquer l'exercice en rajoutant une ligne particulière dans la table immos
                DMcorrections.QuCorrectionInsert.Close;
                DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;
                DMcorrections.QuCorrectionInsert.SQL.Clear;
                RepertoireExocourant:='immos.db';
                DeFiltrageDataSet(DMRech.TaGestDossierRech);
                InfosGestDossier:=Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(str_getstringelement(ListeExercices.Strings[i],1,';'))]);
              if ((FileExists(extractfilepath(str_getstringelement(ListeExercices.Strings[i],1,';'))+'Immos.db'))and (InfosGestDossier.Cloture))then
                  RepertoireExocourant:='"'+IncludeTrailingPathDelimiter(str_getstringelement(ListeExercices.Strings[i],1,';'))+'Immos.db"';

                DMcorrections.QuCorrectionInsert.Close;
                DMcorrections.QuCorrectionInsert.SQL.Clear;
                DMcorrections.QuCorrectionInsert.SQL.Add('select * from '+RepertoireExocourant);
                DMcorrections.QuCorrectionInsert.SQL.Add('where id=-1 ');
                DMcorrections.QuCorrectionInsert.open;
                if DMcorrections.QuCorrectionInsert.recordcount=0 then
                  begin
                GestionGauge(10,gauge,-1,-1,'Marquage sur exercice '+InfosGestDossier.Nom_Exo);
                      DMcorrections.QuCorrectionInsert.Close;
                      DMcorrections.QuCorrectionInsert.SQL.Clear;
                      DMcorrections.QuCorrectionInsert.SQL.Add('insert into '+RepertoireExocourant);
                      DMcorrections.QuCorrectionInsert.SQL.Add('(id,libelle,type_amt) ');
                      DMcorrections.QuCorrectionInsert.SQL.Add('values(-1,"Table vérifiée","N") ');
                      DMcorrections.QuCorrectionInsert.ExecSQL;
                  end;
            end;
        end;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    DBAux.Close;
    DBAux.Free;
    E.Exo_A_Verifier:=marque;
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier a renvoyé le code '+InfosGestDossier.Nom_Exo+'_'+etape+' !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  GestionGauge(0,gauge,0,0,'',false);
  Initialise_TStringlist(ListeExercices);
  DMcorrections.QuCorrectionExo.Close;
  DMcorrections.QuCorrectionExo.DatabaseName:=DM_C_NomAliasDossier;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


//Function ControleAmort_DerogSurChangementExercice(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
//var
//i:integer;
//Confirmation:boolean;
//ListeExercices:Tstringlist;
//RepertoireExocourant,RepertoireExoNMoins1:string;
//InfosGestDossier:TInfosGestDossier;
//begin
//try//finally
//try//except
//
//ListeExercices:=TStringList.Create;
//Initialise_ExceptLGR(result,GestMessageLGR);
//result.NumErreur:=19000;
//result.retour:=true;
// result.NomModule:='ControleAmort_DerogSurChangementExercice';
// result.NomDossier:=e.NomDossier;
// result.GestMessageLGR.Enregistrement:=true;
// //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
// confirmation:=true;
//        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
//        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
// if not confirmation then
//   begin
//    if DemandeConfirmation then
//      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
//   end
// else
// if DemandeConfirmation then
//  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle des amortissements dérogatoires suite au changement d''exercice ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
//if Confirmation then
//    begin
//GestionGauge(10,Gauge,20,0,'Contrôle de la gestion du dérogatoire');
//        PatienterAffich;
//        ListeExercices:=RecupExerciceDossier_Tous(E.ID_Dos);
//        if ListeExercices=nil then
//          raise ExceptLGR.Create('',0,false,mtError);
//        for i:=0 to ListeExercices.Count-1 do
//          begin //pour tous les execices existants du dossier
//              DMcorrections.QuCorrectionExo.Close;
//              DMcorrections.QuCorrectionExo.DatabaseName:=DM_C_NomAliasDossier;
//              DMcorrections.QuCorrectionExo.SQL.Clear;
//              RepertoireExocourant:=str_getstringelement(ListeExercices.Strings[i],1,';');
//              RepertoireExoNMoins1:=str_getstringelement(ListeExercices.Strings[i],3,';');
//              InfosGestDossier:=Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(str_getstringelement(ListeExercices.Strings[i],1,';'))]);
//               if RepertoireExocourant<>RepertoireExoNMoins1 then
//                  Begin
//                    if ((FileExists(IncludeTrailingPathDelimiter(RepertoireExoNMoins1)+dmrech.TaImmosRech.TableName))
//                      and(Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(RepertoireExoNMoins1)]).Cloture))then
//                      begin //si table immos dans exercice n-1 et exercice n-1 est clôturé
//                      if ((FileExists(IncludeTrailingPathDelimiter(RepertoireExocourant)+dmrech.TaImmosRech.TableName))
//                      and(Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(RepertoireExocourant)]).Cloture))then
//                        Begin //si immos dans table exercice courant et exercice courant clôturé
//                            DMcorrections.QuCorrectionExo.SQL.add('select (I1.compte||I1.code||I1.sous_Code||I1.libelle)as immo, (I1.amort_derog)as Derog_dossier,(I2.amort_derog+(I2.choix-I2.eco))as Derog_Exercice from "'+IncludeTrailingPathDelimiter(RepertoireExocourant)+'immos" I1');
//                            DMcorrections.QuCorrectionExo.SQL.add('join "'+IncludeTrailingPathDelimiter(RepertoireExoNMoins1)+'immos" I2 on (I1.id=I2.id)');
//                            DMcorrections.QuCorrectionExo.SQL.add('where (I1.amort_derog <>(I2.amort_derog+(I2.choix-I2.eco)))');
//                            DMcorrections.QuCorrectionExo.open;
//                        end//fin si immos dans table exercice courant et exercice courant clôturé
//                      else
//                        Begin//si exercice courant non clôturé alors on travail sur table immos du dossier
//                            DMcorrections.QuCorrectionExo.SQL.add('select (I1.compte||I1.code||I1.sous_Code||I1.libelle)as immo,(I1.amort_derog) as Derog_dossier,(I2.amort_derog+(I2.choix-I2.eco))as Derog_Exercice from "'+IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immos" I1');
//                            DMcorrections.QuCorrectionExo.SQL.add('join "'+IncludeTrailingPathDelimiter(RepertoireExoNMoins1)+'immos" I2 on (I1.id=I2.id)');
//                            DMcorrections.QuCorrectionExo.SQL.add('where (I1.amort_derog <>(I2.amort_derog+(I2.choix-I2.eco)))');
//                            DMcorrections.QuCorrectionExo.open;
//                        end;//fin si exercice courant non clôturé alors on travail sur table immos du dossier
//                           if DMcorrections.QuCorrectionExo.recordcount<>0 then
//                           begin
//                               DMcorrections.QuCorrectionExo.first;
//                               while ((not (DMcorrections.QuCorrectionExo.eof))and (result.retour)) do
//                                 begin
//                                    result.retour:=DMcorrections.QuCorrectionExo.findfield('Derog_dossier').AsCurrency=DMcorrections.QuCorrectionExo.findfield('Derog_Exercice').AsCurrency;
//                                    //if(not result.retour)then showmessage('Problème sur immo : '+DMcorrections.QuCorrectionExo.findfield('immo').AsString+' sur l''exercice : '+RepertoireExocourant);
//                                    DMcorrections.QuCorrectionExo.next;
//                                 end;
//                           end;
//                      end;//fin si table immos dans exercice n-1 et exercice n-1 est clôturé
//                  end;
//          end;//fin pour tous les execices existants du dossier
//GestionGauge(10,Gauge,-1,-1,'Contrôle de la gestion du dérogatoire');
//        Patienterfermer;
//    end;
//except
//  result.retour:=false;
//end;
//finally
//    try
//    if result.retour=false then
//        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
//    except
//    end;
//  if result.retour then
//    begin
//      result.retour:=confirmation;
//      result.NumErreur:=-1;
//    end;
//  DMcorrections.QuCorrectionExo.Close;
//  result.GestMessageLGR.Enregistrement:=false;
//  GestionGauge(0,Gauge,0,0,'',false);
//  PatienterFermer;
//end;
//end;



Function ListeChampTableDansFichier(Table:string;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ReferenceOD:string;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
result.NumErreur:=0;
result.retour:=true;
 result.NomModule:='CorrectionPlanComptable';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
 //confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
// confirmation:=not e.ExerciceCloture;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
        if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous générer la liste des champs de la table immos ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;

        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('select * from '+Table);
        DMcorrections.QuCorrectionDossier.open;
        DMcorrections.QuCorrectionDossier.FieldList.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'ListeChampsImmos.txt');
        PatienterFermer
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

Function ReinitialisationH_Tva_AvantControle(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ListeCpt,ListeRetour:Tstringlist;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=0;
result.retour:=true;
 result.NomModule:='ReinitialisationH_Tva_AvantControle';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la réinitialisation de la table H_Tva avant contrôle ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
            //nettoyage de la table avant de réécrire
            DMcorrections.QuCorrectionInsert.Close;
            DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;
            DMcorrections.QuCorrectionInsert.SQL.Clear;
            DMcorrections.QuCorrectionInsert.SQL.add('Delete from H_Tva');
            DMcorrections.QuCorrectionInsert.SQL.add('where (ID_Declaration=-3)or (ID_Declaration=-4)');
            DMcorrections.QuCorrectionInsert.ExecSQL;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;



Function CoherenceBalance(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ListeRetour:Tstringlist;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=0;
result.retour:=true;
 result.NomModule:='CoherenceBalance';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de Cohérence Balance ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        ListeRetour:=TStringList.Create;
        if not ControleBalanceCpt(nil,ListeRetour) then
          Begin
             GestionGauge(10,gauge,30,0);
             DMcorrection.CorrectionDeLaBalance(true,false);
             GestionGauge(10);
             DMcorrection.CorrectionDeLaBalanceDesTiers(true,false);
             GestionGauge(10);
             DMcorrection.CorrectionDeLaBalanceDesMouvements(true,false);
             GestionGauge(0,gauge,0,0,'',false);
          end;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


procedure Activation_Desactivation_MAJ_Balance;
begin
//TODO vérifier la désactivation si ouverture d'un écran sur un autre et autres cas
if ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'))then
  begin
      if (e.TypeMAJBalance=MAJ_Report)then
      begin
          if application.MessageBox('Etes-vous sûr de vouloir activer la mise à jour de la balance d''ouverture','Attention',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
              e.TypeMAJBalance:=MAJ_Normal;
      end
      else
      begin
          if application.MessageBox('Etes-vous sûr de vouloir désactiver la mise à jour de la balance d''ouverture','Attention',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
             e.TypeMAJBalance:=MAJ_Report;
      end;
  end;
end;


Function initialisationMAJ_Balance(Btn:TRxSpeedButton):string;
var
Hint : string;
begin
try
  case e.TypeMAJBalance of
    MAJ_Normal,MAJ_Base:begin
                   result:='Désactiver';
                   Hint:='Permet de désactiver la mise à jour de la balance d''ouverture';
               end;
    MAJ_Report:begin
                  result:='Activer';
                  Hint:='Permet d''activer la mise à jour de la balance d''ouverture';
               end;
  end;//fin case
if btn<>nil then
  begin
      if ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'))then
        Btn.Enabled:=true
      else
        Btn.Enabled:=false;
      Btn.Caption:=result;
      btn.Hint:=Hint;
  end;
except
end;  
end;

/// *********** version actuelle *************** ///////
Function Epuration(DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
ListePiece,ListePieceTmp,ListeEcriture,ListeHTVA,ListeCompteRappTemp,
ListePieceSupprime,ListeEcritureSupprime,
ListeResteDC,ListePointage,ListeTmp,ListePlancpt,ListePlanAux,ListeCompteRapp,
listeExoEpures:TStringlistLGR1;
i,j,k,nb,rang:integer;
chiffre,NomDossier:string;
dateFin,dateDebut,DateFinEpuration:TDate;
Debut,fin:Ttime;
ParamAffichCompte:TParamAffichCompte;
ResultStrList:TResultStrList;
RetourMessage:integer;
sortir:boolean;
texteFinal:string;
ExerciceDepart:string;
RepertoireExercice:string;
ListeEcritureASupprime,ListePieceASupprime:TStringlistLGR1;
begin
try//finally
try//except
ListePiece:=TStringlistLGR1.Create;
ListeEcriture:=TStringlistLGR1.Create;
ListeResteDC:=TStringlistLGR1.Create;
ListePointage:=TStringlistLGR1.Create;
ListePieceTmp:=TStringlistLGR1.Create;
ListeHTVA:=TStringlistLGR1.Create;
ListeTmp:=TStringlistLGR1.Create;
ListePlancpt:=TStringlistLGR1.Create;
ListePlanAux:=TStringlistLGR1.Create;
ListeCompteRappTemp:=TStringlistLGR1.Create;
ListeCompteRappTemp.Duplicates:=dupIgnore;
ListeCompteRapp:=TStringlistLGR1.Create;
listeExoEpures:=TStringlistLGR1.Create;
//le 26-02-2006
ListeEcritureASupprime:=TStringlistLGR1.Create;
ListePieceASupprime:=TStringlistLGR1.Create;

ListeEcritureSupprime:=TStringlistLGR1.Create;
ListePieceSupprime:=TStringlistLGR1.Create;
ListePieceSupprime.DelimitedText:=';';
//le 26-02-2006
texteFinal:='';
ExerciceDepart:='';

Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=33000;
result.retour:=true;
 result.NomModule:='Epuration';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;


        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);

 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=Application.MessageBox(Pchar('Merci de lire attentivement tous les messages qui vous seront proposés.'+ContinuerOuAnnuler),'Epuration du dossier',MB_ICONEXCLAMATION +MB_OKCANCEL+MB_DEFBUTTON1)=mrok ;
  //Confirmation:=MessageDlg_lgr('Merci de lire attentivement tous les messages qui vous seront proposés.', mtConfirmation, [mbRetry,mbAbort], 0) = mrRetry;
//

  if confirmation then
    Confirmation:=Application.MessageBox(Pchar(RappelEpuration+ContinuerOuAnnuler),'Attention',MB_ICONEXCLAMATION +MB_OKCANCEL+MB_DEFBUTTON2)=mrok ;

  if Confirmation then
    begin
        PatienterAffich;
          DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
         // ShowMessage('DM_C_NomAliasDossier : '+DM_C_NomAliasDossier);
          TableGereStartTransaction(DMcorrections.QuCorrectionDossier);
          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
//
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:='Sélectionnez un code exercice';
                  ParamAffichCompte.SousTitre:= 'En sélectionnant un code exercice,'
                  +' vous indiquez jusqu''à quel exercice l''épuration doit être réalisée...';
                  ParamAffichCompte.Tiers:=false;
                  DMcorrections.QuCorrectionProgram.close;
                  DMcorrections.QuCorrectionProgram.SQL.Clear;
                  DMcorrections.QuCorrectionProgram.DatabaseName := DM_C_NomAliasProgram;
                  DMcorrections.QuCorrectionProgram.SQL.Add('select nom_exo,Date_deb_exo,date_fin_exo from GestDossier where nom_dossier='''+E.NomDossier+''' and cloture = true');
                  DMcorrections.QuCorrectionProgram.Open;
                  ParamAffichCompte.Dataset:=DMcorrections.QuCorrectionProgram;

                  ParamAffichCompte.Filtrer:=false;
                  ParamAffichCompte.FiltreNbChiffre := 0;
                  ParamAffichCompte.ListeChamps.Add('nom_exo');
                  ParamAffichCompte.ListeChamps.Add('Date_deb_exo');
                  ParamAffichCompte.ListeChamps.Add('date_fin_exo');
                  ParamAffichCompte.EventButtonAjouterClick:=nil;
                  ParamAffichCompte.EventButtonSupprimerClick:=nil;

//
          if(not MyInputQuery_F1(Application.MainForm, 'Exercices à épurer','Saisir le code de l''exercice à épurer',
              ExerciceDepart,ParamAffichCompte,'L''épuration se fera sur l''exercice choisi'+RetourChariotSimple+
                  'et tous les exercices antérieurs...',[#0],10)) then
          begin
            confirmation:=false;
            abort;
          end;
          DMcorrections.QuCorrectionProgram.close;
          DMcorrections.QuCorrectionProgram.SQL.Clear;
          //rechercher la date fin de cet exercice
          FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[e.NomDossier,true]) +' and Nom_exo = '''+ExerciceDepart+'''');
          if DMRech.TaGestDossierRech.RecordCount=0 then
            begin
              ShowMessage('Ce code exercice n''existe pas ou n''est pas clôturé !!!');
              confirmation:=false;
              abort;
            end;
  Application.MessageBox(Pchar('Attention, une sauvegarde de votre dossier va être lancée.'+
        retourchariotsimple+'Si vous annuler cette sauvegarde, l''épuration sera automatiquement annulée...')
        ,'Attention',MB_ICONEXCLAMATION +MB_OK);
//        begin
          dateFin:=DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsDateTime;
          DateFinEpuration:=DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsDateTime;
          dateDebut:=DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsDateTime;
          chiffre:=DMRech.TaGestDossierRech.FindField('exo_saisie').AsString;
          
          //lancer la declaration tva
          ViderTable(DMTmTVA.TaDec_Tva);
          try


         ///  ********** A remettre le 10-02-2014***************


//          //calcul déclaration avec contrôle
//          if (ControleTVAEnAttente(nil,e.DateDebutDeclarationTVA,StrToDate_Lgr(C_DateFinInfini),true,false,true,true).retour=false)then
//            begin
//              result.retour:=false;
//              if ((ParamUtil.maintenance)and(ParamUtil.TypeMaintenance='MaintS'))then
//               result.retour:=Application.MessageBox(Pchar('La déclaration fait apparaître une erreur, voulez-vous continuer la procédure d''épuration ?'),'Attention',
//                   MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes ;
//            end;
//          if result.retour=false then abort;
////          if (not CalculDeclarationTva(e.DateDebutDeclarationTVA,StrToDate(C_DateFinInfini),false))then
////            begin
////              result.retour:=false;
////            end;
////            if result.retour=false then abort;
//          //fin declaration tva



                   ///  ********** A remettre le 10-02-2014***************

                   
          except
            result.retour:=false;
            raise ExceptLGR.Create('',0,false,mtError,Result);
          end;


        if FermerDossier(E) then
          confirmation:=SauveDossier(nil,'','','-SauvegardeAvantEpuration-'+ExerciceDepart+'-');
         confirmation:=(confirmation) or (E.TypeClient=CL_Isa);
         if not confirmation then abort;
//        end;
          PatienterAffich;
         // ShowMessage('Avant création table "PieceSupprime"');
          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceSupprime.db') then
            begin
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.sql.Add('create table PieceSupprime (ID integer,Journal integer,Reference varchar(9),DatePiece date,Libelle varchar(100),TypePiece integer,Compte varchar(8) ,primary key (id))');
              DMcorrections.QuCorrectionDossier.ExecSQL;
              TableGereCommit(DMcorrections.QuCorrectionDossier);
            end;
          //if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceSupprime.db') then showmessage('PieceSupprime existe');

          if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureSupprime.db') then
            begin
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.sql.Add('drop table EcritureSupprime ');
              DMcorrections.QuCorrectionDossier.ExecSQL;
            end;
          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureSupprime.db') then
            begin
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.sql.Add('create table EcritureSupprime (ID integer,ID_Piece integer,tvatype varchar(1),primary key (id))');
              DMcorrections.QuCorrectionDossier.ExecSQL;
              TableGereCommit(DMcorrections.QuCorrectionDossier);
            end;
           //if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureSupprime.db') then showmessage('EcritureSupprime existe');
           // ShowMessage('Après création table "EcritureSupprime"');

          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceRemises.db') then
            begin
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.sql.Add('create table PieceRemises (ID integer,Journal integer,Reference varchar(9),DatePiece date,Libelle varchar(100),TypePiece integer,Compte varchar(8) ,primary key (id))');
              DMcorrections.QuCorrectionDossier.ExecSQL;
              TableGereCommit(DMcorrections.QuCorrectionDossier);
            end;
           // ShowMessage('Après création table "PieceRemises"');
          try


          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Compte_Rapp.db') then
            begin
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.sql.Add('CREATE TABLE Compte_Rapp(compte varchar(8),PRIMARY KEY (compte))');
              DMcorrections.QuCorrectionDossier.ExecSQL;
              TableGereCommit(DMcorrections.QuCorrectionDossier);
            end;
              //récupérer les valeurs anciennes
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.SQL.Clear;
              DMcorrections.QuCorrectionDossier.sql.Add('select compte from Compte_Rapp');
              DMcorrections.QuCorrectionDossier.Open;
              ListeCompteRappTemp:=ChampTableVersListeLGR('compte',DMcorrections.QuCorrectionDossier);
              TableGereCommit(DMcorrections.QuCorrectionDossier);


           // ShowMessage('Après création table "Compte_Rapp"');
              RetourMessage:=Application.MessageBox(Pchar('Souhaitez_vous conserver les écritures de banque des exercices '+ExerciceDepart+' et antérieurs'+
              retourchariotsimple+' qui n''ont pas été rapprochées dans le menu ''Ecritures/Rapprochement bancaire'''+
              retourchariotsimple+LigneSeparation+retourchariotsimple+
              retourchariotsimple+'Si vous ne marquez jamais vos écritures de banque dans le menu ''Ecritures/Rapprochement bancaire'' répondez "NON." '+
              retourchariotsimple+LigneSeparation+retourchariotsimple+
              retourchariotsimple+'Si vous suivez et marquez scrupuleusement vos écritures de banque dans le menu ''Ecritures/Rapprochement bancaire'' répondez "OUI."'+
              retourchariotsimple+LigneSeparation+retourchariotsimple+
              retourchariotsimple+'Dans le doute, n''hésitez pas à nous contacter.'),'Conserver les écritures de banque non rapprochées',MB_ICONQUESTION +MB_YESNOCANCEL+MB_DEFBUTTON1);
              if RetourMessage=mrcancel then
                begin
                confirmation:=false;
                abort;
                end;
                PatienterAffich;
              if RetourMessage=mryes then
                begin
                  DMcorrections.QuCorrectionDossier.close;
                  DMcorrections.QuCorrectionDossier.SQL.Clear;
                  DMcorrections.QuCorrectionDossier.sql.Add('insert into Compte_Rapp  (compte) select distinct E.compte from ecriture E where E.rapprochement');
                  DMcorrections.QuCorrectionDossier.sql.Add('is not null and E.rapprochement<>''''');
                  DMcorrections.QuCorrectionDossier.sql.Add('and E.compte not in(select compte from Compte_Rapp)');
                  DMcorrections.QuCorrectionDossier.ExecSQL;
                  TableGereCommit(DMcorrections.QuCorrectionDossier);
                  DMcorrections.QuCorrectionDossier.close;
                  DMcorrections.QuCorrectionDossier.SQL.clear;
//                  DMcorrections.QuCorrectionDossier.SQL.Add('select C.compte,P.libelle from Compte_Rapp C'
//                  +' left join plancpt P on(C.compte=P.compte)');
                  DMcorrections.QuCorrectionDossier.SQL.Add('select C.compte from Compte_Rapp C');
                  DMcorrections.QuCorrectionDossier.Open;
                  //////////////////////////
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:= 'Sélectionnez les comptes rapprochables...';
                  ParamAffichCompte.Tiers:=false;
                  ParamAffichCompte.Dataset:=DMcorrections.QuCorrectionDossier;

                  ParamAffichCompte.FiltreNbChiffre := 3;
                  ParamAffichCompte.ListeChamps.Add('compte');
                  //ParamAffichCompte.ListeChamps.Add('Libelle');
                  ParamAffichCompte.EventButtonAjouterClick:=DMcorrections.BtnAjouterClick;
                  ParamAffichCompte.EventButtonSupprimerClick:=DMcorrections.BtnSupprimerClick;
                  sortir:=false;
                  while (sortir=false)do
                    begin
                      ResultStrList:=ChoixCompteAffich(ParamAffichCompte);
                      sortir:=ResultStrList.Result=false;
                      if not sortir then
                        begin
                          if(ResultStrList.Liste<>nil)then
                            begin
                              sortir:=Application.MessageBox(Pchar('Vous avez sélectionné le(s) compte(s) de rapprochement : '+
                            retourchariotsimple+ResultStrList.Liste.Text+
                            retourchariotsimple+'à prendre en compte dans l''épuration.'+
                            retourchariotDouble+'Si vous êtes d''accord avec cette liste, cliquez sur "Oui",' +
                            retourchariotDouble+'Sinon, pour revenir à la liste, cliquez sur "Non"'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
                            end
                          else
                            begin
                                sortir:=Application.MessageBox(Pchar('ATTENTION, vous avez souhaité conserver les écritures de banques non rapprochées,'+
                              retourchariotsimple+'mais vous n''avez sélectionné aucun compte dans la liste des comptes rapprochables.'+
                              retourchariotDouble+'L''épuration ne pourra pas conserver les écritures de banque non rapprochées.'+
                              retourchariotDouble+'Si vous êtes d''accord, cliquez sur "Oui",' +
                              retourchariotDouble+'Sinon, pour revenir à la liste, cliquez sur "Non"'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
                            end;
                        end;
                    end;
                  if(ResultStrList.Result=false)then
                     begin
                       confirmation:=false;
                       abort;
                     end;
                  if RetourMessage=mryes then
                    begin
                       if ResultStrList.Liste<>nil then
                          texteFinal:=LigneSeparation+RetourChariotDouble+'Vous avez souhaité conserver les écritures de banque non rapprochées.'+RetourChariotDouble
                       else
                          texteFinal:=LigneSeparation+RetourChariotDouble+'Vous avez souhaité conserver les écritures de banque non rapprochées,.'+
                          retourChariotsimple+'mais vous n''avez sélectionné aucun compte dans la liste des comptes rapprochables.'+RetourChariotDouble;
                    end
                  else texteFinal := LigneSeparation+RetourChariotDouble+'Vous n''avez pas souhaité conserver les écritures de banque non rapprochées.'+RetourChariotDouble;
                  confirmation:=Application.MessageBox(Pchar(RetourChariotDouble+'Vous avez demandé à épurer l''exercice '+ExerciceDepart+' et tous les exercices antérieurs'+
                  RetourchariotSimple+texteFinal+
                  ContinuerOuAnnuler),'Attention',MB_ICONEXCLAMATION +MB_OKCANCEL+MB_DEFBUTTON2)=mrOk;
                  if not confirmation then abort;
                  PatienterAffich;
                  TStringList(ListeCompteRapp):=ResultStrList.Liste;
                  if ListeCompteRapp=nil then ListeCompteRapp:=TStringlistLGR1.Create;
                  DMcorrections.QuCorrectionDossier.close;
                  DMcorrections.QuCorrectionDossier.SQL.Clear;
                  DMcorrections.QuCorrectionDossier.sql.Add('delete from Compte_Rapp ');
                  DMcorrections.QuCorrectionDossier.ExecSQL;
                  //showmessage('delete from compte_Rapp');

                  for nb:=0 to ListeCompteRapp.Count-1 do
                  begin
                      DMcorrections.QuCorrectionDossier.close;
                      DMcorrections.QuCorrectionDossier.SQL.Clear;
                      DMcorrections.QuCorrectionDossier.sql.Add('insert into Compte_Rapp (compte) values('''+ListeCompteRapp.Strings[nb]+''')');
                      DMcorrections.QuCorrectionDossier.ExecSQL;
                      //showmessage('insert into compte_Rapp avec liste recupéree');
                  end;

                 ////////////////////////
                end
                else
                begin
                  texteFinal := LigneSeparation+RetourChariotDouble+'Vous n''avez pas souhaité conserver les écritures de banque non rapprochées.'+RetourChariotDouble;
                  confirmation:=Application.MessageBox(Pchar(RetourChariotDouble+'Vous avez demandé à épurer l''exercice '+ExerciceDepart+' et tous les exercices antérieurs'+
                  RetourchariotSimple+texteFinal+
                  ContinuerOuAnnuler),'Attention',MB_ICONEXCLAMATION +MB_OKCANCEL+MB_DEFBUTTON2)=mrOk;
                  if not confirmation then abort;
                  DMcorrections.QuCorrectionDossier.close;
                  DMcorrections.QuCorrectionDossier.SQL.Clear;
                  DMcorrections.QuCorrectionDossier.sql.Add('delete from Compte_Rapp ');
                  DMcorrections.QuCorrectionDossier.ExecSQL;
                  //showmessage('delete from compte_Rapp');
                end;

             // ShowMessage('Après "insert into Compte_Rapp"');
          // selection d'une liste de pièces à supprimer
          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;

//          DMcorrections.QuCorrectionDossier.sql.Add('Insert into PieceSupprime (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' Select distinct P.id,P.Journal,P.Reference,P."Date",P.Libelle,P.TypePiece,P.Compte from piece P');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where P."date"  <= cast('''+DateToStr(dateFin)+''' as date)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select P3.id from h_piecetva h join piece P3 on(P3.reference = h.reference_od) )');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select id_piece from resteDC dc where dc.reste>0)');
//          //DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select E.id_piece from ecriture E where e.compte in (select compte from compte_Rapp )');
//          //DMcorrections.QuCorrectionDossier.sql.Add(' and (e.rapprochement is null or e.rapprochement =''''))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in(');
//          DMcorrections.QuCorrectionDossier.sql.Add(' select E2.id_piece from pointage PO ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' join Ecriture E2 on (E2.id=PO.id_debit or E2.id=PO.id_credit)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where  ');
//          DMcorrections.QuCorrectionDossier.sql.Add('    Po."date"  >cast('''+DateToStr(dateFin)+''' as date)');
//          DMcorrections.QuCorrectionDossier.sql.Add('    or  ');
//          DMcorrections.QuCorrectionDossier.sql.Add('    Po."Tvadate"  >cast('''+DateToStr(dateFin)+''' as date))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in(select id_piece from Dec_Tva.db)');
          //ShowMessage('Etape 1');
          DMcorrections.QuCorrectionDossier.sql.clear;
          DMcorrections.QuCorrectionDossier.sql.Add('Insert into PieceSupprime (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte)');
          DMcorrections.QuCorrectionDossier.sql.Add(' Select distinct P.id,P.Journal,P.Reference,P."Date",P.Libelle,P.TypePiece,P.Compte from piece P');
          DMcorrections.QuCorrectionDossier.sql.Add(' where P."date"  <= cast( :datefin as date)');
          DMcorrections.QuCorrectionDossier.ParamByName('datefin').AsDateTime:=datefin;
          DMcorrections.QuCorrectionDossier.Prepare;
          ShowMessage(DMcorrections.QuCorrectionDossier.SQL.Text);
          DMcorrections.QuCorrectionDossier.ExecSQL;
          //abort;
          //ShowMessage('Etape 2');
           DMcorrections.QuCorrectionDossier.sql.clear;
          DMcorrections.QuCorrectionDossier.sql.Add(' delete from PieceSupprime P where ');
          DMcorrections.QuCorrectionDossier.sql.Add('  P.id  in (select P3.id from h_piecetva h join piece P3 on(P3.reference = h.reference_od) )');
          DMcorrections.QuCorrectionDossier.Prepare;
          DMcorrections.QuCorrectionDossier.ExecSQL;

          //ShowMessage('Etape 3');
           DMcorrections.QuCorrectionDossier.sql.clear;
          DMcorrections.QuCorrectionDossier.sql.Add(' delete from PieceSupprime P where ');
          DMcorrections.QuCorrectionDossier.sql.Add('  P.id  in (select id_piece from resteDC dc where dc.reste>0)');
          DMcorrections.QuCorrectionDossier.Prepare;
          DMcorrections.QuCorrectionDossier.ExecSQL;

          //ShowMessage('Etape 4');

           DMcorrections.QuCorrectionDossier.sql.clear;
          DMcorrections.QuCorrectionDossier.sql.Add(' delete from PieceSupprime P where ');
          DMcorrections.QuCorrectionDossier.sql.Add('  P.id  in (select E.id_piece from ecriture E where e.compte in (select compte from compte_Rapp )');
          DMcorrections.QuCorrectionDossier.sql.Add(' and (e.rapprochement is null or e.rapprochement =''''))');
          DMcorrections.QuCorrectionDossier.Prepare;
          DMcorrections.QuCorrectionDossier.ExecSQL;

         // ShowMessage('Etape 5');

           DMcorrections.QuCorrectionDossier.sql.clear;
          DMcorrections.QuCorrectionDossier.sql.Add(' delete from PieceSupprime P where ');
          DMcorrections.QuCorrectionDossier.sql.Add(' P.id  in(');
          DMcorrections.QuCorrectionDossier.sql.Add(' select E2.id_piece from pointage PO ');
          DMcorrections.QuCorrectionDossier.sql.Add(' join Ecriture E2 on (E2.id=PO.id_debit)');
          DMcorrections.QuCorrectionDossier.sql.Add(' where  ');
          DMcorrections.QuCorrectionDossier.sql.Add('    Po."date"  >cast(:datefin as date)');
          DMcorrections.QuCorrectionDossier.sql.Add('    or  ');
          DMcorrections.QuCorrectionDossier.sql.Add('    Po."Tvadate"  >cast(:datefin as date))');
          DMcorrections.QuCorrectionDossier.ParamByName('datefin').AsDateTime:=datefin;
          DMcorrections.QuCorrectionDossier.Prepare;
          DMcorrections.QuCorrectionDossier.ExecSQL;

          //ShowMessage('Etape 6');

           DMcorrections.QuCorrectionDossier.sql.clear;
          DMcorrections.QuCorrectionDossier.sql.Add(' delete from PieceSupprime P where ');
          DMcorrections.QuCorrectionDossier.sql.Add(' P.id  in(');
          DMcorrections.QuCorrectionDossier.sql.Add(' select E2.id_piece from pointage PO ');
          DMcorrections.QuCorrectionDossier.sql.Add(' join Ecriture E2 on (E2.id=PO.id_credit)');
          DMcorrections.QuCorrectionDossier.sql.Add(' where  ');
          DMcorrections.QuCorrectionDossier.sql.Add('    Po."date"  >cast(:datefin as date)');
          DMcorrections.QuCorrectionDossier.sql.Add('    or  ');
          DMcorrections.QuCorrectionDossier.sql.Add('    Po."Tvadate"  >cast(:datefin as date))');
          DMcorrections.QuCorrectionDossier.ParamByName('datefin').AsDateTime:=datefin;
          DMcorrections.QuCorrectionDossier.Prepare;
          DMcorrections.QuCorrectionDossier.ExecSQL;

          //ShowMessage('Etape 7');

          DMcorrections.QuCorrectionDossier.sql.clear;
          DMcorrections.QuCorrectionDossier.sql.Add(' delete from PieceSupprime P where ');
          DMcorrections.QuCorrectionDossier.sql.Add('  P.id  in (select id_piece from Dec_Tva.db)');
          DMcorrections.QuCorrectionDossier.Prepare;
          DMcorrections.QuCorrectionDossier.ExecSQL;


            
          //DMcorrections.QuCorrectionDossier.sql.Add(' where  en_attente=false');
          //DMcorrections.QuCorrectionDossier.sql.Add(' group by id_piece');
          //DMcorrections.QuCorrectionDossier.sql.Add(' having (sum(part_declaree))<1 or fin_periode >cast('''+DateToStr(dateFin)+''' as date) )');
//         //modifie le 28/04/2009 par isa
//          DMcorrections.QuCorrectionDossier.sql.Add(' delete from PieceSupprime P where P.id not in (');
//          DMcorrections.QuCorrectionDossier.sql.Add(' select E.id_piece from Ecriture E where E.id_piece=P.id ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and E.compte in(select distinct compte from tvacode))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and E.id in(select distinct compte from tvacode))');
//         //modifie le 28/04/2009 par isa

         // ShowMessage('Après grosse requete "Insert into PieceSupprime"');
//         debut:=time;
//          DMcorrections.QuCorrectionDossier.Prepare;
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//          fin:=time;

          //ShowMessage('Etape 8');

          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.sql.Add('insert into EcritureSupprime (id,ID_Piece,Tvatype)select E.id,P.id,E.tvatype from PieceSupprime P join ecriture E on(e.id_piece = P.id)');
          DMcorrections.QuCorrectionDossier.ExecSQL;
          TableGereCommit(DMcorrections.QuCorrectionDossier);
          //ShowMessage('Après "Insert into EcritureSupprime"');

          //ShowMessage('Etape 9');

          DMcorrections.QuCorrectionInsert.close;
          DMcorrections.QuCorrectionInsert.sql.clear;
          DMcorrections.QuCorrectionInsert.DatabaseName:=DMcorrections.QuCorrectionDossier.DatabaseName;


//

          //ShowMessage('Etape 10');

          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          //Modifié le 27-02-2009
//          DMcorrections.QuCorrectionDossier.sql.Add(' select distinct E1.id_piece from ecrituresupprime E1  ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' join Ecriture E2 on(E2.id=E1.id)  ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where (E2.tvatype=''E'') and (E1.id in  ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' (select P1.id_debit from pointage P1 where P1.id_credit not in  ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' (select E2.id from ecrituresupprime E2))  ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' or E1.id in   ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' (select P2.id_credit from pointage P2 where P2.id_debit not in  ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' (select E3.id from ecrituresupprime E3)))  ');
//          //Modifié le 27-02-2009

            //ShowMessage('Etape 11');


DMcorrections.QuCorrectionDossier.sql.Add(' select distinct(E1.id_piece) from ecrituresupprime E1 ');
DMcorrections.QuCorrectionDossier.sql.Add(' where ');
DMcorrections.QuCorrectionDossier.sql.Add(' (E1.id_piece in(select ec.id_piece from ecriture ec');
DMcorrections.QuCorrectionDossier.sql.Add(' join plancpt pl on pl.compte=ec.compte ');
DMcorrections.QuCorrectionDossier.sql.Add('  where (pl.pointable=true)))');
DMcorrections.QuCorrectionDossier.sql.Add(' and ');
DMcorrections.QuCorrectionDossier.sql.Add('  (E1.id in ');
DMcorrections.QuCorrectionDossier.sql.Add('  (select P1.id_debit from pointage P1 where P1.id_credit not in (select E2.id from ecrituresupprime E2))');
DMcorrections.QuCorrectionDossier.sql.Add('  or E1.id in ');
DMcorrections.QuCorrectionDossier.sql.Add('  (select P2.id_credit from pointage P2 where P2.id_debit not in (select E3.id from ecrituresupprime E3)))');
DMcorrections.QuCorrectionDossier.Open;


for i:=0 to ListePieceTmp.Count-1 do
begin
   ListePieceASupprime.Add(ListePieceTmp.Strings[i]) ;
end;
          //ShowMessage('Après "select distinct E1.id_piece from ecrituresupprime"');
          k:=0;

          //ShowMessage('Etape 12');
          //ShowMessage('RecordCount = "'+IntToStr(DMcorrections.QuCorrectionDossier.RecordCount));


          while DMcorrections.QuCorrectionDossier.RecordCount<>0 do
          begin
              DMcorrections.QuCorrectionDossier.first;
              while not(DMcorrections.QuCorrectionDossier.eof)do
              begin
                  DMcorrections.QuCorrectionInsert.close;
                  DMcorrections.QuCorrectionInsert.sql.clear;
                  DMcorrections.QuCorrectionInsert.SQL.Add(' delete from EcritureSupprime where id_piece = '+DMcorrections.QuCorrectionDossier.findfield('id_piece').AsString);
                  DMcorrections.QuCorrectionInsert.ExecSQL;
                  TableGereCommit(DMcorrections.QuCorrectionInsert);
                  if(k=0)then
                    begin   //récupérer le premier jet de pièces remises
                      DMcorrections.QuCorrectionInsert.close;
                      DMcorrections.QuCorrectionInsert.sql.clear;
                      DMcorrections.QuCorrectionInsert.SQL.Add(' insert into pieceRemises (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte) select ID '+
                      ',Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte from pieceSupprime where id = '+DMcorrections.QuCorrectionDossier.findfield('id_piece').AsString);
                      DMcorrections.QuCorrectionInsert.ExecSQL;
                      DMcorrections.QuCorrectionDossier.next;
                      TableGereCommit(DMcorrections.QuCorrectionInsert);
                    end;
                  DMcorrections.QuCorrectionDossier.next;
              end;
              inc(k);
              DMcorrections.QuCorrectionDossier.close;
              DMcorrections.QuCorrectionDossier.Open;
          end;
          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.sql.Add('delete from pieceRemises ');
          DMcorrections.QuCorrectionDossier.ExecSQL;
          TableGereCommit(DMcorrections.QuCorrectionDossier);


          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.sql.Add('insert into pieceRemises (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte) select ID ,Journal '+
          ',Reference ,DatePiece ,Libelle ,TypePiece ,Compte from pieceSupprime where id not in (select distinct id_piece from EcritureSupprime)');
          DMcorrections.QuCorrectionDossier.ExecSQL;
          TableGereCommit(DMcorrections.QuCorrectionDossier);

          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.sql.Add('delete from pieceSupprime where id not in (select distinct id_piece from EcritureSupprime)');
          DMcorrections.QuCorrectionDossier.ExecSQL;
          TableGereCommit(DMcorrections.QuCorrectionDossier);

          DMcorrections.QuCorrectionDossier.close;
          DMcorrections.QuCorrectionDossier.SQL.Clear;
          DMcorrections.QuCorrectionDossier.sql.Add('select id from PieceSupprime');
          DMcorrections.QuCorrectionDossier.Open;
          ListePiece:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false);

//          ShowMessage('temp de remplissage liste : '+TimeToStr(fin-debut)+' - '+IntToStr(ListePiece.Count)+' pièces à supprimer');

              //modifié le 26-02-2009
                   NomDossier:=CreerDossierDateJour(E.RepertoireDossier,'Archivage-');

                   AjouterFichierTexte(NomDossier+'\infodossier.txt','nom_dossier;'+E.NomDossier);
             //Toutes les Pieces des exercices epurés
                 begin
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from Piece P ');
                     DMcorrections.QuCorrectionDossier.sql.Add(' where P."date"  <= cast(:DateFinEpuration as date)');
                     DMcorrections.QuCorrectionDossier.ParamByName('DateFinEpuration').AsDateTime:=DateFinEpuration;
                     DMcorrections.QuCorrectionDossier.Open;
                     ListePieceASupprime:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,true);
                 end;
             //Toutes les Ecritures des exercices epurés
                 begin
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select E.* from "'+IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Ecriture.db" E ');
                     DMcorrections.QuCorrectionDossier.sql.Add(' join "'+IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Piece.db" P on(p.id=E.id_piece) ');
                     DMcorrections.QuCorrectionDossier.sql.Add(' where P."date"  <= cast(:dateFin as date)');
                     DMcorrections.QuCorrectionDossier.ParamByName('dateFin').AsDateTime:=dateFin;
                     DMcorrections.QuCorrectionDossier.Open;
                     ListeEcritureASupprime:=ChampTableVersListeExLgr(DMcorrections.QuCorrectionDossier,';',false,true);
                 end;
//                 ListeEcritureASupprime.SaveToFile(NomDossier+'\Ecritures_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//                 ListePieceASupprime.SaveToFile(NomDossier+'\Pieces_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');


          except
            //raise ExceptLGR.Create('Vérifier si la table "compte_Rapp" existe !!!',0,true,mtError,Result);
          end;
          debut:=time;
          //A partir de la liste des Ecritures, suppression dans les tables correspondantes
          listePiece.SaveToFile(NomDossier+'\ListePieceAvant.csv');
           for i:=0 to ListePiece.Count-1 do
             begin
               TableGereStartTransaction(DMcorrections.QuCorrectionDossier);


               //ResteDC
              // if(Type_version_execution=CT_DISTRIBUTION)then
                 begin
                   DMcorrections.QuCorrectionDossier.close;
                   DMcorrections.QuCorrectionDossier.SQL.Clear;
                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from ResteDC where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
                   DMcorrections.QuCorrectionDossier.Open;
                   ListeTmp:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,ListeResteDC.Count=0);
                   for j:=0 to ListeTmp.Count-1 do
                     begin
                        ListeResteDC.Add(ListeTmp.Strings[j]) ;
                     end;
                 end;
               DMcorrections.QuCorrectionDossier.close;
               DMcorrections.QuCorrectionDossier.SQL.Clear;
               DMcorrections.QuCorrectionDossier.sql.Add(' delete from ResteDC where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
               DMcorrections.QuCorrectionDossier.ExecSQL;
               TableGereCommit(DMcorrections.QuCorrectionDossier);

               //H_Tva
               //if(Type_version_execution=CT_DISTRIBUTION)then
                 begin
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from H_Tva where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
                     DMcorrections.QuCorrectionDossier.Open;
                     ListeTmp:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,ListeHTVA.Count=0);
                     for j:=0 to ListeTmp.Count-1 do
                       begin
                          ListeHTVA.Add(ListeTmp.Strings[j]) ;
                       end;
                 end;

               DMcorrections.QuCorrectionDossier.close;
               DMcorrections.QuCorrectionDossier.SQL.Clear;
               DMcorrections.QuCorrectionDossier.sql.Add(' delete from H_Tva where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
               DMcorrections.QuCorrectionDossier.ExecSQL;
               TableGereCommit(DMcorrections.QuCorrectionDossier);

               //Ecriture
              // if(Type_version_execution=CT_DISTRIBUTION)then
                 begin
                   DMcorrections.QuCorrectionDossier.close;
                   DMcorrections.QuCorrectionDossier.SQL.Clear;
                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from Ecriture where id_piece  = '+GetStringElement(ListePiece.Strings[i],1,';'));
                   DMcorrections.QuCorrectionDossier.Open;
                   ListeTmp:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,ListeEcriture.Count=0);
                   for j:=0 to ListeTmp.Count-1 do
                     begin
                        ListeEcriture.Add(ListeTmp.Strings[j]) ;
                     end;
                 end;
               DMcorrections.QuCorrectionDossier.close;
               DMcorrections.QuCorrectionDossier.SQL.Clear;
               DMcorrections.QuCorrectionDossier.sql.Add(' delete from Ecriture where id_piece  = '+GetStringElement(ListePiece.Strings[i],1,';'));
               DMcorrections.QuCorrectionDossier.ExecSQL;
               TableGereCommit(DMcorrections.QuCorrectionDossier);

               //pièce
              // if(Type_version_execution=CT_DISTRIBUTION)then
                 begin
                   DMcorrections.QuCorrectionDossier.close;
                   DMcorrections.QuCorrectionDossier.SQL.Clear;
                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from piece where id = '+GetStringElement(ListePiece.Strings[i],1,';'));
                   DMcorrections.QuCorrectionDossier.Open;
                   ListeTmp:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,ListePieceTmp.Count=0);
                   for j:=0 to ListeTmp.Count-1 do
                     begin
                        ListePieceTmp.Add(ListeTmp.Strings[j]) ;
                     end;
                 end;
               DMcorrections.QuCorrectionDossier.close;
               DMcorrections.QuCorrectionDossier.SQL.Clear;
               DMcorrections.QuCorrectionDossier.sql.Add(' delete from piece where id = '+GetStringElement(ListePiece.Strings[i],1,';'));
               DMcorrections.QuCorrectionDossier.ExecSQL;

               TableGereCommit(DMcorrections.QuCorrectionDossier);
             end;

             //pointage
             //  if(Type_version_execution=CT_DISTRIBUTION)then
                 begin
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from pointage P where id_debit  in (select id from EcritureSupprime )and id_credit  in(select id from EcritureSupprime )');
                     DMcorrections.QuCorrectionDossier.Open;
                     ListePointage:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,true);
                 end;

               DMcorrections.QuCorrectionDossier.close;
               DMcorrections.QuCorrectionDossier.SQL.Clear;
               DMcorrections.QuCorrectionDossier.sql.Add(' delete from pointage where id_debit  in (select id from EcritureSupprime )and id_credit in (select id from EcritureSupprime)');
               DMcorrections.QuCorrectionDossier.ExecSQL;
               TableGereCommit(DMcorrections.QuCorrectionDossier);

             //Plan comptable
          //     if(Type_version_execution=CT_DISTRIBUTION)then
                 begin
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from plancpt ');
                     DMcorrections.QuCorrectionDossier.Open;
                     ListePlancpt:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,true);
                 end;
             //Plan auxiliaire
             //  if(Type_version_execution=CT_DISTRIBUTION)then
                 begin
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from tiers ');
                     DMcorrections.QuCorrectionDossier.Open;
                     ListePlanAux:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,true);
                 end;

//               if(Type_version_execution=CT_DISTRIBUTION)then
  //               begin

             //Rajout le 10/12/2008 pour archivage
            // Toutes les Pieces des exercices epurés
                 begin
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from pieceSupprime');
                     DMcorrections.QuCorrectionDossier.Open;
                     ListePieceSupprime:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,true);
                 end;
             //Toutes les Ecritures des exercices epurés
                 begin
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from EcritureSupprime');
                     DMcorrections.QuCorrectionDossier.Open;
                     ListeEcritureSupprime:=ChampTableVersListeExLGR(DMcorrections.QuCorrectionDossier,';',false,true);
                 end;

             //récupérer tous les exercices épurés
                 begin
                     DMcorrections.QuCorrectionProgram.close;
                     DMcorrections.QuCorrectionProgram.SQL.Clear;
                     DMcorrections.QuCorrectionProgram.SQL.Add('select nom_exo,Dir_exo,Date_deb_exo,date_fin_exo from ');
                     DMcorrections.QuCorrectionProgram.SQL.Add(' GestDossier G where nom_dossier='''+E.NomDossier+''' and cloture = true ');
                     DMcorrections.QuCorrectionProgram.sql.Add(' and G.date_fin_exo  <= cast(:dateFin as date)');
                     DMcorrections.QuCorrectionProgram.ParamByName('dateFin').AsDateTime:=dateFin;
                     DMcorrections.QuCorrectionProgram.Open;
                     DMcorrections.QuCorrectionProgram.First;
                 end;
                 //Balance des tiers sur exercices cloturés
                 listeExoEpures.Clear;
                 listeExoEpures.Add('Epuré');
                 while not DMcorrections.QuCorrectionProgram.eof do
                 begin
                     RepertoireExercice:=IncludeTrailingPathDelimiter(DMcorrections.QuCorrectionProgram.findfield('Dir_exo').asstring);
                     listeExoEpures.SaveToFile(DMcorrections.QuCorrectionProgram.findfield('Dir_exo').asstring+'\Epure.txt');
                     //balance des comptes
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from "'+RepertoireExercice+'\balance"  ');
                     DMcorrections.QuCorrectionDossier.Open;
                     ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,true).SaveToFile(NomDossier+'\balance-'+DMcorrections.QuCorrectionProgram.findfield('nom_exo').asstring+'-'+DateInfos(now,'-').DateStrFormat+'.txt');
                     //balance des tiers
                     DMcorrections.QuCorrectionDossier.close;
                     DMcorrections.QuCorrectionDossier.SQL.Clear;
                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from "'+RepertoireExercice+'\balanceTiers" ');
                     DMcorrections.QuCorrectionDossier.Open;
                     ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,true).SaveToFile(NomDossier+'\balanceTiers-'+DMcorrections.QuCorrectionProgram.findfield('nom_exo').asstring+'-'+DateInfos(now,'-').DateStrFormat+'.txt');

                     DMcorrections.QuCorrectionProgram.next;
                 end;
                   //Procédure pour marquer dans la liste des pieces à Supprimer les pièces réellement supprimées
                   for i:=0 to ListeEcritureASupprime.Count-1 do
                   begin
                      if(ListeEcritureSupprime.indexOfCol(str_getstringelement(ListeEcritureASupprime.Strings[i],1,';'),1,';')<>-1)then
//                      if(ListeEcritureSupprime.indexOf(str_getstringelement(ListeEcritureASupprime.Strings[i],1,';')+';'
//                         +str_getstringelement(ListeEcritureASupprime.Strings[i],2,';')+';')<>-1)then
                            ListeEcritureASupprime.Strings[i]:='*;'+ListeEcritureASupprime.Strings[i]
                       else
                          ListeEcritureASupprime.Strings[i]:=';'+ListeEcritureASupprime.Strings[i]
                   end;
                   ListeEcritureASupprime.Strings[0]:='Supprime'+ListeEcritureASupprime.Strings[0];

                   for i:=0 to ListePieceASupprime.Count-1 do
                   begin
                   if(ListePieceSupprime.indexOfCol(str_getstringelement(ListePieceASupprime.Strings[i],1,';'),1,';')<>-1)then
//                      if(ListePieceSupprime.IndexOf(str_getstringelement(ListePieceASupprime.Strings[i],1,';')+
//                      ';'+str_getstringelement(ListePieceASupprime.Strings[i],2,';')+
//                      ';'+str_getstringelement(ListePieceASupprime.Strings[i],3,';')+
//                      ';'+str_getstringelement(ListePieceASupprime.Strings[i],4,';')+
//                      ';'+str_getstringelement(ListePieceASupprime.Strings[i],5,';')+
//                      ';'+str_getstringelement(ListePieceASupprime.Strings[i],6,';')+
//                      ';'+str_getstringelement(ListePieceASupprime.Strings[i],7,';')
//                      )<>-1)then
                         ListePieceASupprime.Strings[i]:='*;'+ListePieceASupprime.Strings[i]
                       else
                         ListePieceASupprime.Strings[i]:=';'+ListePieceASupprime.Strings[i]
                   end;
                   ListePieceASupprime.Strings[0]:='Supprime'+ListePieceASupprime.Strings[0];

                   ListeHTVA.SaveToFile(NomDossier+'\HTva_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');

                   ListeResteDC.SaveToFile(NomDossier+'\ResteDC_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');

                   ListePointage.SaveToFile(NomDossier+'\Pointage_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');

                   ListeEcritureASupprime.SaveToFile(NomDossier+'\Ecritures_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');

                   ListePieceASupprime.SaveToFile(NomDossier+'\Pieces_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');

                   ListePlancpt.SaveToFile(NomDossier+'\PlanCpt-'+DateInfos(now,'-').DateStrFormat+'.txt');

                   ListePlanAux.SaveToFile(NomDossier+'\PlanAux-'+DateInfos(now,'-').DateStrFormat+'.txt');
//                 end;
          TableGereCommit(DMcorrections.QuCorrectionDossier);
          fin:=time;
//           ShowMessage('fin suppression pièce : '+TimeToStr(fin-debut));

        PatienterFermer
    end;
except
  result.retour:=false;
  TableGereRollBack(DMcorrections.QuCorrectionDossier);
  //ShowMessage('heure Problème : '+TimeToStr(time));
end;
finally
    try
    if (confirmation)and (result.retour=false) then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  DMcorrections.QuCorrectionDossier.Close;
  result.GestMessageLGR.Enregistrement:=false;
  Initialise_TStringlist(ListeEcriture);
  Initialise_TStringlist(ListePointage);
  Initialise_TStringlist(ListeResteDC);
  Initialise_TStringlist(ListePieceTmp);
  Initialise_TStringlist(ListeHTVA);
  Initialise_TStringlist(ListeTmp);
  Initialise_TStringlist(ListePlancpt);
  Initialise_TStringlist(ListePlanAux);
  Initialise_TStringlist(ListePieceSupprime);
  Initialise_TStringlist(ListeEcritureSupprime);
  Initialise_TStringlist(listeExoEpures);
  Initialise_TStringlist(ListeEcritureASupprime);
  Initialise_TStringlist(ListePieceASupprime);
  PatienterFermer;

//   if(FileExists(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'PieceSupprime.db'))then
//      begin
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('drop table PieceSupprime');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//      end;
//   if(FileExists(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'EcritureSupprime.db'))then
//      begin
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('drop table EcritureSupprime');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//      end;

   if(FileExists(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Compte_Rapp.db'))then
      begin
      ListeCompteRappTemp.Duplicates:=dupIgnore;
        for nb:=0 to ListeCompteRapp.Count-1 do
        begin
          if ListeCompteRappTemp.IndexOf(ListeCompteRapp.Strings[nb])=-1 then
             ListeCompteRappTemp.Add(ListeCompteRapp.Strings[nb]);
        end;
        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('delete from compte_Rapp');
        DMcorrections.QuCorrectionDossier.ExecSQL;
        for nb:=0 to ListeCompteRappTemp.Count-1 do
          begin
          //rajouter les valeurs courantes au valeurs anciennes pour prochaine épuration
            DMcorrections.QuCorrectionDossier.close;
            DMcorrections.QuCorrectionDossier.SQL.Clear;
            DMcorrections.QuCorrectionDossier.sql.Add('insert into Compte_Rapp (compte) values('''+ListeCompteRappTemp.Strings[nb]+''')') ;
            DMcorrections.QuCorrectionDossier.ExecSQL;
          end;
       TableGereCommit(DMcorrections.QuCorrectionDossier);
       Initialise_TStringlist(ListeCompteRapp);
       Initialise_TStringlist(ListeCompteRappTemp);
      end;
if (confirmation)then
  begin
   PackTableProc(nil,nil,false,false);
   ShowMessage('fin de l''épuration : '+TimeToStr(fin-debut)+ ' - '+IntToStr(ListePiece.Count)+' pièces supprimées');
  end
  else ShowMessage('Epuration abandonnée');
OuvreExercice(E.NomDossier,E.NomExo);
//Relancer la declaration tva
ViderTable(DMTmTVA.TaDec_Tva);
ControleTVAEnAttente(nil,e.DateDebutDeclarationTVA,StrToDate_Lgr(C_DateFinInfini),true,false,true,true);
end;
end;
/// *********** FIN version actuelle *************** ///////

////version du 09/2008////
//Function Epuration(DemandeConfirmation:boolean):texceptlgr;
//var
//Confirmation:boolean;
//ListePiece,ListePieceTmp,ListeEcriture,ListeHTVA,
//ListeResteDC,ListePointage,ListeTmp,ListePlancpt,ListePlanAux:TStringList;
//i,j,k:integer;
//chiffre:string;
//dateFin,dateDebut:TDate;
//Debut,fin:Ttime;
//begin
//try//finally
//try//except
//ListePiece:=TStringList.Create;
//ListeEcriture:=TStringList.Create;
//ListeResteDC:=TStringList.Create;
//ListePointage:=TStringList.Create;
//ListePieceTmp:=TStringList.Create;
//ListeHTVA:=TStringList.Create;
//ListeTmp:=TStringList.Create;
//ListePlancpt:=TStringList.Create;
//ListePlanAux:=TStringList.Create;
//
//Initialise_ExceptLGR(result,GestMessageLGR);
//result.NumErreur:=33000;
//result.retour:=true;
// result.NomModule:='Epuration';
// result.NomDossier:=e.NomDossier;
// result.GestMessageLGR.Enregistrement:=true;
// confirmation:=true;
//        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
//        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
//
// if not confirmation then
//   begin
//    if DemandeConfirmation then
//      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
//   end
// else
// if DemandeConfirmation then
//  Confirmation:=MessageDlg_lgr('Voulez_vous lancer l''épuration du dossier ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
//if Confirmation then
//    begin
//        PatienterAffich;
//          DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
//         // ShowMessage('DM_C_NomAliasDossier : '+DM_C_NomAliasDossier);
//          TableGereStartTransaction(DMcorrections.QuCorrectionDossier);
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          chiffre:=InputBox('Saisir le code de l''exercice à épurer','','') ;
//          //rechercher la date fin de cet exercice
//          FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[e.NomDossier,true]) +' and Nom_exo = '''+chiffre+'''');
//          if DMRech.TaGestDossierRech.RecordCount=0 then
//            begin
//              ShowMessage('Ce code exercice n''existe pas ou n''est pas clôturé !!!');
//              abort;
//            end;
//          dateFin:=DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsDateTime;
//          dateDebut:=DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsDateTime;
//          chiffre:=DMRech.TaGestDossierRech.FindField('exo_saisie').AsString;
//         // ShowMessage('Avant création table "PieceSupprime"');
//          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceSupprime.db') then
//            begin
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('create table PieceSupprime (ID integer,Journal integer,Reference varchar(9),DatePiece date,Libelle varchar(100),TypePiece integer,Compte varchar(8) ,primary key (id))');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//              TableGereCommit(DMcorrections.QuCorrectionDossier);
//            end;
//           //ShowMessage('Après création table "PieceSupprime"');
//          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureSupprime.db') then
//            begin
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('create table EcritureSupprime (ID integer,ID_Piece integer,primary key (id))');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//              TableGereCommit(DMcorrections.QuCorrectionDossier);
//            end;
//           // ShowMessage('Après création table "EcritureSupprime"');
//          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Compte_Rapp.db') then
//            begin
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('CREATE TABLE Compte_Rapp(compte varchar(8),PRIMARY KEY (compte))');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//              TableGereCommit(DMcorrections.QuCorrectionDossier);
//            end;
//           // ShowMessage('Après création table "Compte_Rapp"');
//          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceRemises.db') then
//            begin
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('create table PieceRemises (ID integer,Journal integer,Reference varchar(9),DatePiece date,Libelle varchar(100),TypePiece integer,Compte varchar(8) ,primary key (id))');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//              TableGereCommit(DMcorrections.QuCorrectionDossier);
//            end;
//           // ShowMessage('Après création table "PieceRemises"');
//          try
//
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('delete from Compte_Rapp ');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//              TableGereCommit(DMcorrections.QuCorrectionDossier);
//             // ShowMessage('Après "delete from Compte_Rapp"');
//
//              if(MessageDlg_lgr('Voulez_vous récupérer les comptes rapprochables ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes)then
//                begin
//                  DMcorrections.QuCorrectionDossier.close;
//                  DMcorrections.QuCorrectionDossier.SQL.Clear;
//                  DMcorrections.QuCorrectionDossier.sql.Add('insert into Compte_Rapp  (compte) select distinct compte from ecriture where rapprochement is not null and rapprochement<>''''');
//                  DMcorrections.QuCorrectionDossier.ExecSQL;
//                  TableGereCommit(DMcorrections.QuCorrectionDossier);
//                end;
//             // ShowMessage('Après "insert into Compte_Rapp"');
//          // selection d'une liste de pièces à supprimer
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//
//          DMcorrections.QuCorrectionDossier.sql.Add('Insert into PieceSupprime (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' Select distinct P.id,P.Journal,P.Reference,P."Date",P.Libelle,P.TypePiece,P.Compte from piece P');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where P."date"  <= cast('''+DateToStr(dateFin)+''' as date)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select P3.id from h_piecetva h join piece P3 on(P3.reference = h.reference_od) )');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select id_piece from resteDC dc where dc.reste>0)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select E.id_piece from ecriture E where e.compte in (select compte from compte_Rapp )');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and (e.rapprochement is null or e.rapprochement =''''))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in(');
//          DMcorrections.QuCorrectionDossier.sql.Add(' select E2.id_piece from pointage PO ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' join Ecriture E2 on (E2.id=PO.id_debit or E2.id=PO.id_credit)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where  ');
//          DMcorrections.QuCorrectionDossier.sql.Add('    Po."date"  >cast('''+DateToStr(dateFin)+''' as date)');
//          DMcorrections.QuCorrectionDossier.sql.Add('    or  ');
//          DMcorrections.QuCorrectionDossier.sql.Add('    Po."Tvadate"  >cast('''+DateToStr(dateFin)+''' as date))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in(select id_piece from h_tva');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where  en_attente=false');
//          DMcorrections.QuCorrectionDossier.sql.Add(' group by id_piece');
//          DMcorrections.QuCorrectionDossier.sql.Add(' having (sum(part_declaree))<1 or fin_periode >cast('''+DateToStr(dateFin)+''' as date) )');
//         // ShowMessage('Après grosse requete "Insert into PieceSupprime"');
//         debut:=time;
//          DMcorrections.QuCorrectionDossier.Prepare;
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//          fin:=time;
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('insert into EcritureSupprime (id,ID_Piece)select E.id,P.id from PieceSupprime P join ecriture E on(e.id_piece = P.id)');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//          TableGereCommit(DMcorrections.QuCorrectionDossier);
//          //ShowMessage('Après "Insert into EcritureSupprime"');
//
//          DMcorrections.QuCorrectionInsert.close;
//          DMcorrections.QuCorrectionInsert.sql.clear;
//          DMcorrections.QuCorrectionInsert.DatabaseName:=DMcorrections.QuCorrectionDossier.DatabaseName;
//
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add(' select distinct E1.id_piece from ecrituresupprime E1 where E1.id in');
//          DMcorrections.QuCorrectionDossier.sql.Add(' (select P1.id_debit from pointage P1 where P1.id_credit not in (select E2.id from ecrituresupprime E2))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' or E1.id in');
//          DMcorrections.QuCorrectionDossier.sql.Add(' (select P2.id_credit from pointage P2 where P2.id_debit not in (select E3.id from ecrituresupprime E3))');
//          DMcorrections.QuCorrectionDossier.Open;
//          //ShowMessage('Après "select distinct E1.id_piece from ecrituresupprime"');
//          k:=0;
//          //ShowMessage('RecordCount = "'+IntToStr(DMcorrections.QuCorrectionDossier.RecordCount));
//          while DMcorrections.QuCorrectionDossier.RecordCount<>0 do
//          begin
//              DMcorrections.QuCorrectionDossier.first;
//              while not(DMcorrections.QuCorrectionDossier.eof)do
//              begin
//                  DMcorrections.QuCorrectionInsert.close;
//                  DMcorrections.QuCorrectionInsert.sql.clear;
//                  DMcorrections.QuCorrectionInsert.SQL.Add(' delete from EcritureSupprime where id_piece = '+DMcorrections.QuCorrectionDossier.findfield('id_piece').AsString);
//                  DMcorrections.QuCorrectionInsert.ExecSQL;
//                  TableGereCommit(DMcorrections.QuCorrectionInsert);
//                  if(k=0)then
//                    begin   //récupérer le premier jet de pièces remises
//                      DMcorrections.QuCorrectionInsert.close;
//                      DMcorrections.QuCorrectionInsert.sql.clear;
//                      DMcorrections.QuCorrectionInsert.SQL.Add(' insert into pieceRemises (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte) select ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte from pieceSupprime where id = '+DMcorrections.QuCorrectionDossier.findfield('id_piece').AsString);
//                      DMcorrections.QuCorrectionInsert.ExecSQL;
//                      DMcorrections.QuCorrectionDossier.next;
//                      TableGereCommit(DMcorrections.QuCorrectionInsert);
//                    end;
//                  DMcorrections.QuCorrectionDossier.next;
//              end;
//              inc(k);
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.Open;
//          end;
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('delete from pieceRemises ');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//          TableGereCommit(DMcorrections.QuCorrectionDossier);
//
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('insert into pieceRemises (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte) select ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte from pieceSupprime where id not in (select distinct id_piece from EcritureSupprime)');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//          TableGereCommit(DMcorrections.QuCorrectionDossier);
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('delete from pieceSupprime where id not in (select distinct id_piece from EcritureSupprime)');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//          TableGereCommit(DMcorrections.QuCorrectionDossier);
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('select id from PieceSupprime');
//          DMcorrections.QuCorrectionDossier.Open;
//          ListePiece:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false);
//
////          ShowMessage('temp de remplissage liste : '+TimeToStr(fin-debut)+' - '+IntToStr(ListePiece.Count)+' pièces à supprimer');
//
//
//
//          except
//            raise ExceptLGR.Create('Vérifier si la table "compte_Rapp" existe !!!',0,true,mtError,Result);
//          end;
//          debut:=time;
//          //A partir de la liste des Ecritures, suppression dans les tables correspondantes
//           for i:=0 to ListePiece.Count-1 do
//             begin
//               TableGereStartTransaction(DMcorrections.QuCorrectionDossier);
//
//               //ResteDC
//              // if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                   DMcorrections.QuCorrectionDossier.close;
//                   DMcorrections.QuCorrectionDossier.SQL.Clear;
//                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from ResteDC where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
//                   DMcorrections.QuCorrectionDossier.Open;
//                   ListeTmp:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,ListeResteDC.Count=0);
//                   for j:=0 to ListeTmp.Count-1 do
//                     begin
//                        ListeResteDC.Add(ListeTmp.Strings[j]) ;
//                     end;
//                 end;
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from ResteDC where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//               TableGereCommit(DMcorrections.QuCorrectionDossier);
//
//               //H_Tva
//               //if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                     DMcorrections.QuCorrectionDossier.close;
//                     DMcorrections.QuCorrectionDossier.SQL.Clear;
//                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from H_Tva where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
//                     DMcorrections.QuCorrectionDossier.Open;
//                     ListeTmp:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,ListeHTVA.Count=0);
//                     for j:=0 to ListeTmp.Count-1 do
//                       begin
//                          ListeHTVA.Add(ListeTmp.Strings[j]) ;
//                       end;
//                 end;
//
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from H_Tva where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//               TableGereCommit(DMcorrections.QuCorrectionDossier);
//
//               //Ecriture
//              // if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                   DMcorrections.QuCorrectionDossier.close;
//                   DMcorrections.QuCorrectionDossier.SQL.Clear;
//                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from Ecriture where id_piece  = '+GetStringElement(ListePiece.Strings[i],1,';'));
//                   DMcorrections.QuCorrectionDossier.Open;
//                   ListeTmp:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,ListeEcriture.Count=0);
//                   for j:=0 to ListeTmp.Count-1 do
//                     begin
//                        ListeEcriture.Add(ListeTmp.Strings[j]) ;
//                     end;
//                 end;
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from Ecriture where id_piece  = '+GetStringElement(ListePiece.Strings[i],1,';'));
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//               TableGereCommit(DMcorrections.QuCorrectionDossier);
//
//               //pièce
//              // if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                   DMcorrections.QuCorrectionDossier.close;
//                   DMcorrections.QuCorrectionDossier.SQL.Clear;
//                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from piece where id = '+GetStringElement(ListePiece.Strings[i],1,';'));
//                   DMcorrections.QuCorrectionDossier.Open;
//                   ListeTmp:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,ListePieceTmp.Count=0);
//                   for j:=0 to ListeTmp.Count-1 do
//                     begin
//                        ListePieceTmp.Add(ListeTmp.Strings[j]) ;
//                     end;
//                 end;
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from piece where id = '+GetStringElement(ListePiece.Strings[i],1,';'));
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//
//               TableGereCommit(DMcorrections.QuCorrectionDossier);
//             end;
//
//             //pointage
//             //  if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                     DMcorrections.QuCorrectionDossier.close;
//                     DMcorrections.QuCorrectionDossier.SQL.Clear;
//                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from pointage P where id_debit  in (select id from EcritureSupprime )and id_credit  in(select id from EcritureSupprime )');
//                     DMcorrections.QuCorrectionDossier.Open;
//                     ListePointage:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,true);
//                 end;
//
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from pointage where id_debit  in (select id from EcritureSupprime )and id_credit in (select id from EcritureSupprime)');
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//               TableGereCommit(DMcorrections.QuCorrectionDossier);
//
//             //Plan comptable
//          //     if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                     DMcorrections.QuCorrectionDossier.close;
//                     DMcorrections.QuCorrectionDossier.SQL.Clear;
//                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from plancpt ');
//                     DMcorrections.QuCorrectionDossier.Open;
//                     ListePlancpt:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,true);
//                 end;
//             //Plan auxiliaire
//             //  if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                     DMcorrections.QuCorrectionDossier.close;
//                     DMcorrections.QuCorrectionDossier.SQL.Clear;
//                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from tiers ');
//                     DMcorrections.QuCorrectionDossier.Open;
//                     ListePlanAux:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,true);
//                 end;
//
////               if(Type_version_execution=CT_DISTRIBUTION)then
//  //               begin
//                   ListeHTVA.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'HTva_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListeResteDC.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ResteDC_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListePointage.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Pointage_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListeEcriture.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Ecritures_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListePieceTmp.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Pieces_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListePlancpt.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PlanCpt-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListePlanAux.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PlanAux-'+DateInfos(now,'-').DateStrFormat+'.txt');
////                 end;
//          TableGereCommit(DMcorrections.QuCorrectionDossier);
//          fin:=time;
////           ShowMessage('fin suppression pièce : '+TimeToStr(fin-debut));
//
//        PatienterFermer
//    end;
//except
//  result.retour:=false;
//  TableGereRollBack(DMcorrections.QuCorrectionDossier);
//  ShowMessage('heure Problème : '+TimeToStr(time));
//end;
//finally
//    try
//    if result.retour=false then
//        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
//    except
//    end;
//  if result.retour then
//    begin
//      result.retour:=confirmation;
//      result.NumErreur:=-1;
//    end;
//
//  DMcorrections.QuCorrectionDossier.Close;
//  result.GestMessageLGR.Enregistrement:=false;
//  Initialise_TStringlist(ListeEcriture);
//  Initialise_TStringlist(ListePointage);
//  Initialise_TStringlist(ListeResteDC);
//  Initialise_TStringlist(ListePieceTmp);
//  Initialise_TStringlist(ListeHTVA);
//  Initialise_TStringlist(ListeTmp);
//  Initialise_TStringlist(ListePlancpt);
//  Initialise_TStringlist(ListePlanAux);
//  PatienterFermer;
//  
//            DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('drop table PieceSupprime');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('drop table EcritureSupprime');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//PackTableProc(nil,nil,false,false);
//ShowMessage('fin suppression pièce : '+TimeToStr(fin-debut)+ ' - '+IntToStr(ListePiece.Count)+' pièces supprimées');
//  Initialise_TStringlist(ListePiece);
//
//end;
//end;
//// ******** fin version du 09/2008 ***********///////////////////

//Function Epuration(DemandeConfirmation:boolean):texceptlgr;
//var
//Confirmation:boolean;
//ListePiece,ListePieceTmp,ListeEcriture,ListeHTVA,
//ListeResteDC,ListePointage,ListeTmp,ListePlancpt,ListePlanAux:TStringList;
//i,j,k:integer;
//chiffre:string;
//dateFin,dateDebut:TDate;
//Debut,fin:Ttime;
//begin
//try//finally
//try//except
//ListePiece:=TStringList.Create;
//ListeEcriture:=TStringList.Create;
//ListeResteDC:=TStringList.Create;
//ListePointage:=TStringList.Create;
//ListePieceTmp:=TStringList.Create;
//ListeHTVA:=TStringList.Create;
//ListeTmp:=TStringList.Create;
//ListePlancpt:=TStringList.Create;
//ListePlanAux:=TStringList.Create;
//
//Initialise_ExceptLGR(result,GestMessageLGR);
//result.NumErreur:=33000;
//result.retour:=true;
// result.NomModule:='Epuration';
// result.NomDossier:=e.NomDossier;
// result.GestMessageLGR.Enregistrement:=true;
// confirmation:=true;
//        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
//        if Dmrech=nil then DmRech:=TDmRech.Create(Application.MainForm);
//
// if not confirmation then
//   begin
//    if DemandeConfirmation then
//      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
//   end
// else
// if DemandeConfirmation then
//  Confirmation:=MessageDlg_lgr('Voulez_vous lancer l''?puration du dossier ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
//if Confirmation then
//    begin
//        PatienterAffich;
//          DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
//          TableGereStartTransaction(DMcorrections.QuCorrectionDossier);
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          chiffre:=InputBox('Saisir le code de l''exercice ? ?purer','','') ;
//          //rechercher la date fin de cet exercice
//          FiltrageDataSet(DMRech.TaGestDossierRech,CreeFiltreET(['Nom_Dossier','Cloture'],[e.NomDossier,true]) +' and Nom_exo = '''+chiffre+'''');
//          if DMRech.TaGestDossierRech.RecordCount=0 then
//            begin
//              ShowMessage('Ce code exercice n''existe pas ou n''est pas cl?tur? !!!');
//              abort;
//            end;
//          dateFin:=DMRech.TaGestDossierRech.FindField('DATE_FIN_EXO').AsDateTime;
//          dateDebut:=DMRech.TaGestDossierRech.FindField('DATE_DEB_EXO').AsDateTime;
//          chiffre:=DMRech.TaGestDossierRech.FindField('exo_saisie').AsString;
//
//          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceSupprime.db') then
//            begin
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('create table PieceSupprime (ID integer,Journal integer,Reference varchar(9),DatePiece date,Libelle varchar(100),TypePiece integer,Compte varchar(8) ,primary key (id))');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//            end;
//          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'EcritureSupprime.db') then
//            begin
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('create table EcritureSupprime (ID integer,ID_Piece integer,primary key (id))');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//            end;
//          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Compte_Rapp.db') then
//            begin
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('CREATE TABLE Compte_Rapp(compte varchar(8),PRIMARY KEY (compte))');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//            end;
//          if not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PieceRemises.db') then
//            begin
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('create table PieceRemises (ID integer,Journal integer,Reference varchar(9),DatePiece date,Libelle varchar(100),TypePiece integer,Compte varchar(8) ,primary key (id))');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//            end;
//          try
//
////              DMcorrections.QuCorrectionDossier.close;
////              DMcorrections.QuCorrectionDossier.SQL.Clear;
////              DMcorrections.QuCorrectionDossier.sql.Add('delete from Compte_Rapp ');
////              DMcorrections.QuCorrectionDossier.ExecSQL;
//
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.SQL.Clear;
//              DMcorrections.QuCorrectionDossier.sql.Add('insert into Compte_Rapp  (compte) select distinct compte from ecriture where rapprochement is not null and rapprochement<>''''');
//              DMcorrections.QuCorrectionDossier.ExecSQL;
//
//          // selection d'une liste de pi?ces ? supprimer
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//
//          DMcorrections.QuCorrectionDossier.sql.Add('Insert into PieceSupprime (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' Select distinct P.id,P.Journal,P.Reference,P."Date",P.Libelle,P.TypePiece,P.Compte from piece P');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where P."date"  <= cast('''+DateToStr(dateFin)+''' as date)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select P3.id from h_piecetva h join piece P3 on(P3.reference = h.reference_od) )');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select id_piece from resteDC dc where dc.reste>0)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in (select E.id_piece from ecriture E where e.compte in (select compte from compte_Rapp )');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and (e.rapprochement is null or e.rapprochement =''''))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in(');
//          DMcorrections.QuCorrectionDossier.sql.Add(' select E2.id_piece from pointage PO ');
//          DMcorrections.QuCorrectionDossier.sql.Add(' join Ecriture E2 on (E2.id=PO.id_debit or E2.id=PO.id_credit)');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where  ');
//          DMcorrections.QuCorrectionDossier.sql.Add('    Po."date"  >cast('''+DateToStr(dateFin)+''' as date)');
//          DMcorrections.QuCorrectionDossier.sql.Add('    or  ');
//          DMcorrections.QuCorrectionDossier.sql.Add('    Po."Tvadate"  >cast('''+DateToStr(dateFin)+''' as date))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' and P.id not in(select id_piece from h_tva');
//          DMcorrections.QuCorrectionDossier.sql.Add(' where  en_attente=false');
//          DMcorrections.QuCorrectionDossier.sql.Add(' group by id_piece');
//          DMcorrections.QuCorrectionDossier.sql.Add(' having (sum(part_declaree))<1 or fin_periode >cast('''+DateToStr(dateFin)+''' as date) )');
//                        
//         debut:=time;
//          DMcorrections.QuCorrectionDossier.Prepare;
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//          fin:=time;
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('insert into EcritureSupprime (id,ID_Piece)select E.id,P.id from PieceSupprime P join ecriture E on(e.id_piece = P.id)');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//
//          DMcorrections.QuCorrectionInsert.close;
//          DMcorrections.QuCorrectionInsert.sql.clear;
//          DMcorrections.QuCorrectionInsert.DatabaseName:=DMcorrections.QuCorrectionDossier.DatabaseName;
//
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add(' select distinct E1.id_piece from ecrituresupprime E1 where E1.id in');
//          DMcorrections.QuCorrectionDossier.sql.Add(' (select P1.id_debit from pointage P1 where P1.id_credit not in (select E2.id from ecrituresupprime E2))');
//          DMcorrections.QuCorrectionDossier.sql.Add(' or E1.id in');
//          DMcorrections.QuCorrectionDossier.sql.Add(' (select P2.id_credit from pointage P2 where P2.id_debit not in (select E3.id from ecrituresupprime E3))');
//          DMcorrections.QuCorrectionDossier.Open;
//          k:=0;
//          while DMcorrections.QuCorrectionDossier.RecordCount<>0 do
//          begin
//              DMcorrections.QuCorrectionDossier.first;
//              while not(DMcorrections.QuCorrectionDossier.eof)do
//              begin
//                  DMcorrections.QuCorrectionInsert.close;
//                  DMcorrections.QuCorrectionInsert.sql.clear;
//                  DMcorrections.QuCorrectionInsert.SQL.Add(' delete from EcritureSupprime where id_piece = '+DMcorrections.QuCorrectionDossier.findfield('id_piece').AsString);
//                  DMcorrections.QuCorrectionInsert.ExecSQL;
//                  if(k=0)then
//                    begin   //r?cup?rer le premier jet de pi?ces remises
//                      DMcorrections.QuCorrectionInsert.close;
//                      DMcorrections.QuCorrectionInsert.sql.clear;
//                      DMcorrections.QuCorrectionInsert.SQL.Add(' insert into pieceRemises (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte) select ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte from pieceSupprime where id = '+DMcorrections.QuCorrectionDossier.findfield('id_piece').AsString);
//                      DMcorrections.QuCorrectionInsert.ExecSQL;
//                      DMcorrections.QuCorrectionDossier.next;
//                    end;
//                  DMcorrections.QuCorrectionDossier.next;
//              end;
//              inc(k);
//              DMcorrections.QuCorrectionDossier.close;
//              DMcorrections.QuCorrectionDossier.Open;
//          end;
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('delete from pieceRemises ');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('insert into pieceRemises (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte) select ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte from pieceSupprime where id not in (select distinct id_piece from EcritureSupprime)');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('delete from pieceSupprime where id not in (select distinct id_piece from EcritureSupprime)');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('select id from PieceSupprime');
//          DMcorrections.QuCorrectionDossier.Open;
//          ListePiece:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false);
//
//          ShowMessage('temp de remplissage liste : '+TimeToStr(fin-debut)+' - '+IntToStr(ListePiece.Count)+' pi?ces ? supprimer');
//
//
//
//          except
//            raise ExceptLGR.Create('V?rifier si la table "compte_Rapp" existe !!!',0,true,mtError,Result);
//          end;
//          debut:=time;
//          //A partir de la liste des Ecritures, suppression dans les tables correspondantes
//           for i:=0 to ListePiece.Count-1 do
//             begin
//               TableGereStartTransaction(DMcorrections.QuCorrectionDossier);
//
//               //ResteDC
//              // if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                   DMcorrections.QuCorrectionDossier.close;
//                   DMcorrections.QuCorrectionDossier.SQL.Clear;
//                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from ResteDC where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
//                   DMcorrections.QuCorrectionDossier.Open;
//                   ListeTmp:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,ListeResteDC.Count=0);
//                   for j:=0 to ListeTmp.Count-1 do
//                     begin
//                        ListeResteDC.Add(ListeTmp.Strings[j]) ;
//                     end;
//                 end;
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from ResteDC where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//
//               //H_Tva
//               //if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                     DMcorrections.QuCorrectionDossier.close;
//                     DMcorrections.QuCorrectionDossier.SQL.Clear;
//                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from H_Tva where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
//                     DMcorrections.QuCorrectionDossier.Open;
//                     ListeTmp:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,ListeHTVA.Count=0);
//                     for j:=0 to ListeTmp.Count-1 do
//                       begin
//                          ListeHTVA.Add(ListeTmp.Strings[j]) ;
//                       end;
//                 end;
//
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from H_Tva where id_piece = '+GetStringElement(ListePiece.Strings[i],1,';'));
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//
//               //Ecriture
//              // if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                   DMcorrections.QuCorrectionDossier.close;
//                   DMcorrections.QuCorrectionDossier.SQL.Clear;
//                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from Ecriture where id_piece  = '+GetStringElement(ListePiece.Strings[i],1,';'));
//                   DMcorrections.QuCorrectionDossier.Open;
//                   ListeTmp:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,ListeEcriture.Count=0);
//                   for j:=0 to ListeTmp.Count-1 do
//                     begin
//                        ListeEcriture.Add(ListeTmp.Strings[j]) ;
//                     end;
//                 end;
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from Ecriture where id_piece  = '+GetStringElement(ListePiece.Strings[i],1,';'));
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//
//               //pi?ce
//              // if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                   DMcorrections.QuCorrectionDossier.close;
//                   DMcorrections.QuCorrectionDossier.SQL.Clear;
//                   DMcorrections.QuCorrectionDossier.sql.Add(' select * from piece where id = '+GetStringElement(ListePiece.Strings[i],1,';'));
//                   DMcorrections.QuCorrectionDossier.Open;
//                   ListeTmp:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,ListePieceTmp.Count=0);
//                   for j:=0 to ListeTmp.Count-1 do
//                     begin
//                        ListePieceTmp.Add(ListeTmp.Strings[j]) ;
//                     end;
//                 end;
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from piece where id = '+GetStringElement(ListePiece.Strings[i],1,';'));
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//
//               TableGereCommit(DMcorrections.QuCorrectionDossier);
//             end;
//
//             //pointage
//             //  if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                     DMcorrections.QuCorrectionDossier.close;
//                     DMcorrections.QuCorrectionDossier.SQL.Clear;
//                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from pointage P where id_debit  in (select id from EcritureSupprime )and id_credit  in(select id from EcritureSupprime )');
//                     DMcorrections.QuCorrectionDossier.Open;
//                     ListePointage:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,true);
//                 end;
//
//               DMcorrections.QuCorrectionDossier.close;
//               DMcorrections.QuCorrectionDossier.SQL.Clear;
//               DMcorrections.QuCorrectionDossier.sql.Add(' delete from pointage where id_debit  in (select id from EcritureSupprime )and id_credit in (select id from EcritureSupprime)');
//               DMcorrections.QuCorrectionDossier.ExecSQL;
//
//             //Plan comptable
//          //     if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                     DMcorrections.QuCorrectionDossier.close;
//                     DMcorrections.QuCorrectionDossier.SQL.Clear;
//                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from plancpt ');
//                     DMcorrections.QuCorrectionDossier.Open;
//                     ListePlancpt:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,true);
//                 end;
//             //Plan auxiliaire
//             //  if(Type_version_execution=CT_DISTRIBUTION)then
//                 begin
//                     DMcorrections.QuCorrectionDossier.close;
//                     DMcorrections.QuCorrectionDossier.SQL.Clear;
//                     DMcorrections.QuCorrectionDossier.sql.Add(' select * from tiers ');
//                     DMcorrections.QuCorrectionDossier.Open;
//                     ListePlanAux:=ChampTableVersListeEx(DMcorrections.QuCorrectionDossier,';',false,true);
//                 end;
//
////               if(Type_version_execution=CT_DISTRIBUTION)then
//  //               begin
//                   ListeHTVA.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'HTva_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListeResteDC.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ResteDC_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListePointage.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Pointage_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListeEcriture.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Ecritures_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListePieceTmp.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Pieces_Epurees-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListePlancpt.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PlanCpt-'+DateInfos(now,'-').DateStrFormat+'.txt');
//
//                   ListePlanAux.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'PlanAux-'+DateInfos(now,'-').DateStrFormat+'.txt');
////                 end;
//          TableGereCommit(DMcorrections.QuCorrectionDossier);
//          fin:=time;
//           ShowMessage('fin suppression pi?ce : '+TimeToStr(fin-debut));
//           
//        PatienterFermer
//    end;
//except
//  result.retour:=false;
//  TableGereRollBack(DMcorrections.QuCorrectionDossier);
//  ShowMessage('heure Probl?me : '+TimeToStr(time));
//end;
//finally
//    try
//    if result.retour=false then
//        raise ExceptLGR.Create('Le contr?le [N? '+inttostr(result.NumErreur)+'] du dossier ne s''est pas d?roul? correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
//    except
//    end;
//  if result.retour then
//    begin
//      result.retour:=confirmation;
//      result.NumErreur:=-1;
//    end;
//
//  DMcorrections.QuCorrectionDossier.Close;
//  result.GestMessageLGR.Enregistrement:=false;
//  Initialise_TStringlist(ListePiece);
//  Initialise_TStringlist(ListeEcriture);
//  Initialise_TStringlist(ListePointage);
//  Initialise_TStringlist(ListeResteDC);
//  Initialise_TStringlist(ListePieceTmp);
//  Initialise_TStringlist(ListeHTVA);
//  Initialise_TStringlist(ListeTmp);
//    Initialise_TStringlist(ListePlancpt);
//      Initialise_TStringlist(ListePlanAux);
//  PatienterFermer;
//
//            DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('drop table PieceSupprime');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//
//          DMcorrections.QuCorrectionDossier.close;
//          DMcorrections.QuCorrectionDossier.SQL.Clear;
//          DMcorrections.QuCorrectionDossier.sql.Add('drop table EcritureSupprime');
//          DMcorrections.QuCorrectionDossier.ExecSQL;
//end;
//end;


Function CorrectionMultiDossier(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=0;
result.retour:=true;
 result.NomModule:='CorrectionMultiDossier';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la correction du multi dossiers ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        //ShowMessage('Update Multi-dossiers début');
        PatienterAffich;
        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.Add(' Update "'+e.RepertoireProgram+'Gestdossier" G1 set G1.designation_dossier = (select distinct G2.designation_dossier from "'+e.RepertoireProgram+'Gestdossier" G2 where G2.id_dossier=G1.id_dossier ');
        DMcorrections.QuCorrectionDossier.SQL.Add(' and  G2.designation_dossier<>'''' and G2.designation_dossier is not null)');
        DMcorrections.QuCorrectionDossier.SQL.Add(' where G1.designation_dossier is null or G1.designation_dossier = ''''');
        DMcorrections.QuCorrectionDossier.ExecSQL;
        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMRech.TaGestDossierRech.Refresh;
        //ShowMessage('Update Multi-dossiers fin');
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;


Function CorrectionCodeEmprunts(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=0;
result.retour:=true;
 result.NomModule:='CorrectionCodeEmprunts';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la correction du code Emprunt ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);
        DMcorrections.QuCorrectionDossier.DatabaseName:=DMRech.TaEmpruntsRech.DatabaseName;
        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.Add(' Alter table emprunts add Code_Emp_Tmp char(20)');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.Add(' update emprunts set Code_Emp_Tmp = code_emp ');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.Add(' Alter table emprunts drop Code_Emp');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.Add(' Alter table emprunts add Code_Emp char(20)');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.Add(' update emprunts set Code_Emp = code_emp_tmp');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.Add(' Alter table emprunts drop Code_Emp_Tmp ');
        DMcorrections.QuCorrectionDossier.ExecSQL;

        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

Function CorrectionDiffereEmprunts(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=0;
result.retour:=true;
 result.NomModule:='CorrectionDiffereEmprunts';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la correction des differés des Emprunts ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);
        DMcorrections.QuCorrectionDossier.DatabaseName:=DMRech.TaEmpruntsRech.DatabaseName;
        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.Add(' update emprunts set differeMois = (differe*12) where differemois is null and not differe is null)');
        DMcorrections.QuCorrectionDossier.ExecSQL;


        DMcorrections.QuCorrectionDossier.close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

procedure TDMcorrections.BtnAjouterClick(Sender: TObject);
    var
    NewCpt:String;
    Requete : TQuery;
    ParamAffichCompte:TParamAffichCompte;
    ResultStrList:TResultStrList;
    i:integer;
    ChoixCompte:TLibChoixComptes;
    begin
        try//finally
        NewCpt:='';
        Requete := TQuery.Create(Application.MainForm);
        Requete.DatabaseName := DM_C_NomAliasDossier;
//          if(MyInputQuery(Application.MainForm,'Ajouter un compte','Saisir le compte à ajouter à la liste',
//              NewCpt,[#48..#57],8)) then
                  Requete.close;
                  Requete.SQL.Clear;
                  Requete.SQL.Add('select compte,libelle from plancpt ');
                  Requete.open;
                  ChoixCompte:=TLibChoixComptes.Create(Application.MainForm);
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:= 'Sélectionnez les comptes à rajouter...';
                  ParamAffichCompte.SousTitre:= 'Sélectionnez les comptes que vous souhaitez rajouter à l''écran de sélection précédent...';
                  ParamAffichCompte.Tiers:=false;
                  ParamAffichCompte.Dataset:=Requete;

                  SetLength(ParamAffichCompte.ListeClasse,9);
                  ParamAffichCompte.ListeClasse[1]:=1;
                  ParamAffichCompte.ListeClasse[2]:=2;
                  ParamAffichCompte.ListeClasse[3]:=3;
                  ParamAffichCompte.ListeClasse[4]:=4;
                  ParamAffichCompte.ListeClasse[5]:=6;
                  ParamAffichCompte.ListeClasse[6]:=7;
                  ParamAffichCompte.ListeClasse[7]:=8;
                  ParamAffichCompte.ListeClasse[8]:=9;

                  ParamAffichCompte.FiltreNbChiffre := 3;
                  ParamAffichCompte.ListeChamps.Add('compte');
                  ParamAffichCompte.ListeChamps.Add('Libelle');
                  ParamAffichCompte.EventButtonAjouterClick:=nil;
                  ParamAffichCompte.EventButtonSupprimerClick:=nil;
                  ResultStrList:=ChoixCompte.ChoixCompteAffich(ParamAffichCompte);
                  ChoixCompte.Destroy;
        if (ResultStrList.Result)and(ResultStrList.Liste<>nil) then
            begin
            for i:=0 to ResultStrList.Liste.Count-1 do
              begin
                  Requete.close;
                  Requete.SQL.Clear;
                  Requete.SQL.Add('select compte from plancpt where compte='''+ResultStrList.Liste.Strings[i]+'''');
                  Requete.open;
                  if(Requete.RecordCount>0)then
                      begin
                        Requete.close;
                        Requete.SQL.Clear;
                        Requete.SQL.add('select compte from Compte_Rapp where compte ='''+ResultStrList.Liste.Strings[i]+'''');
                        Requete.open;
                        if(Requete.RecordCount<=0)then
                          begin
                            Requete.close;
                            Requete.SQL.Clear;
                            Requete.SQL.Add('insert into compte_Rapp(compte)values('''+ResultStrList.Liste.Strings[i]+''')');
                            Requete.ExecSQL;
                            TableGereCommit(Requete);
                          end;
                      end
                      else Application.MessageBox(Pchar('Le compte '+ResultStrList.Liste.Strings[i]+' ne fait pas partie du plan comptable'),'Attention',MB_ICONWARNING );
                end;//fin boucle for
            end;//fin si result ok
        finally
          Requete.Free;
          LibChoixComptes.ParamAffichCompteObjet.Dataset.close;
          LibChoixComptes.ParamAffichCompteObjet.Dataset.open;
          LibChoixComptes.BtnClasse1.Click;
        end;
    end;


procedure TDMcorrections.BtnSupprimerClick(Sender: TObject);
    var
    NewCpt:String;
    Requete : TQuery;
    begin
        try//finally
        NewCpt:=LibChoixComptes.RxChListCpt.Selected.SubItems[0];
        if Application.MessageBox(Pchar('Etes-vous sûr de vouloir enlever le compte : "'+NewCpt+'" de la liste des comptes rapprochables à prendre en compte lors de l''épuration ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
          begin
              Requete := TQuery.Create(Application.MainForm);
              Requete.DatabaseName := DM_C_NomAliasDossier;
              Requete.close;
              Requete.SQL.Clear;
              Requete.SQL.Add('delete from Compte_Rapp where compte='''+NewCpt+'''');
              Requete.ExecSQL;
          end;
        finally
          Requete.Free;
          LibChoixComptes.ParamAffichCompteObjet.Dataset.close;
          LibChoixComptes.ParamAffichCompteObjet.Dataset.open;
          LibChoixComptes.BtnClasse1.Click;
        end;
    end;

function Resultats:TStringList;
var J : integer;
liste1:Tstringlist;
begin
liste1:=Tstringlist.Create;
result:=Tstringlist.Create;
liste1.Duplicates:=dupIgnore;
    while (liste1.Count<5) do
    begin
      J:=RandomRange(1, 49);
//      if (result.IndexOf(IntToStr(j))=-1)then
//      begin
         liste1.Add(IntToStr(j));
//      end;
    end;
    //ordonner par grandeur
result.Assign(liste1);
      J:=RandomRange(1, 10);
      if (result.IndexOf(IntToStr(j))=-1)then
      begin
         result.Add('('+IntToStr(j)+')');
      end;

liste1.free;
end;

function ExerciceEpure(Exercice:string):Boolean;
begin
  result:=(FileExists(Exercice+'\Epure.txt'));
end;

//function PeriodeEpure(DateDeb,DateFin:Tdate):Boolean;
//var
//retour:boolean;
//Requete:TQuery;
//exercice:String;
//begin
//retour:=false;
//try
//Requete:=TQuery.Create(application.MainForm);
//Requete.DatabaseName:=DM_C_NomAliasProgram;
//Requete.SQL.Clear;
//Requete.SQL.Add('select dir_exo,date_deb_exo,date_fin_exo from GestDossier ');
//Requete.SQL.Add(' where nom_Dossier like('''+e.NomDossier+''')');
//Requete.SQL.Add(' and  (cast('''+DateToStr_SQL(DateDeb)+'''as date) between date_deb_exo and date_fin_exo ');
//Requete.SQL.Add(' or cast('''+DateToStr_SQL(DateFin)+'''as date) between date_deb_exo and date_fin_exo)');
//Requete.Open;
//if(requete.RecordCount>0) then
//begin
// requete.first;
// while (not requete.eof) and (retour=false)do
// begin
//    retour:=(FileExists(Requete.findfield('dir_exo').AsString+'\Epure.txt'));
//    requete.Next;
//  end;
//end;
//Requete.close;
//Requete.free;
//finally
//result:=retour;
//end;
//end;

Function coherenceImmosReport(Gauge:TGauge;DemandeConfirmation:boolean;mess:integer):texceptlgr;
var
i:integer;
Confirmation:boolean;
ListeRetour,ListeDebug:Tstringlist;
ListeExercices:Tstringlist;
RepertoireExoNMoins2,RepertoireExoNMoins1,RepertoireExoN:string;
InfosGestDossier:TInfosGestDossier;
immobilisation:Timmos;
messageRetour:string;
N2,N1,N:TStringArray;
label fin;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
ListeExercices:=TStringList.Create;
ListeRetour:=TStringList.Create;
ListeDebug:=TStringList.Create;
result.NumErreur:=21000;
result.retour:=true;
 result.NomModule:='coherenceImmosReport';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
case mess of
  1: messageRetour:=
        RetourChariotSimple+'Des erreurs ont été détectées dans les amortissements cumulés de vos immobilisations à l''ouverture de l''exercice '+e.NomExo+'.'+
        RetourChariotSimple+'Elles rendent incohérents les amortissements de cet exercice.' +
        RetourChariotSimple+'Pour corriger ces erreurs :'+AppelerServiceMaintenance;

  2: messageRetour:=
        RetourChariotSimple+'Des erreurs ont été détectées dans les amortissements cumulés de vos immobilisations à l''ouverture de l''exercice '+e.NomExo+'.'+
        RetourChariotDouble+'Elles rendent incohérents les amortissements de cet exercice.' +
        RetourChariotDouble+'Le changement d''exercice ne peut pas continuer.'+
        RetourChariotSimple+'Pour corriger ces erreurs :'+AppelerServiceMaintenance;
end;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de Cohérence du report des immos ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        GestionGauge(10,gauge,200,0,'Contrôle des amortissements (report)');
        ListeExercices:=RecupExerciceDossier_tous(E.ID_Dos);

           if(ExcludeTrailingPathDelimiter(ChercheInfos_ExoN(e.NomDossier).Dir_Exo)<>ExcludeTrailingPathDelimiter
           (str_getstringelement(ListeExercices.Strings[ListeExercices.count-1],1,';')))then
               ListeExercices.Delete(ListeExercices.count-1);

        //ChercheInfos_ExoN

        if ((ListeExercices=nil)or(ListeExercices.Count=0)) then
          raise ExceptLGR.Create('',0,false,mtError)
        else
          if ListeExercices.Count>1 then
            Begin//si liste exercice >=2
                 RepertoireExoN:=str_getstringelement(ListeExercices.Strings[ListeExercices.Count-1],1,';');
                 RepertoireExoNMoins1:=str_getstringelement(ListeExercices.Strings[ListeExercices.Count-2],1,';');
                 DeFiltrageDataSet(DMRech.TaGestDossierRech);
                 InfosGestDossier:=Infos_TInfosGestDossier(dmrech.TaGestDossierRech,'Dir_Exo',[ExcludeTrailingPathDelimiter(RepertoireExoNMoins1)]);
                 if(InfosGestDossier.Cloture=false)then goto fin;
                 DMcorrections.QuCorrectionDossier.close;
                 DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
                    DMcorrections.QuCorrectionDossier.SQL.Clear;
               if ListeExercices.Count>2 then
                 begin
                 RepertoireExoNMoins2:=str_getstringelement(ListeExercices.Strings[ListeExercices.Count-3],1,';');

                    DMcorrections.QuCorrectionDossier.close;
                    DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
                    DMcorrections.QuCorrectionDossier.SQL.Clear;
                    DMcorrections.QuCorrectionDossier.SQL.Add('select n.id,n.Compte||n.Code||n.Sous_Code||n.Libelle as Immobilisation');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,n2.amort_eco +n2.amort_derog+n2.choix as reportN2');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,n1.amort_eco +n1.amort_derog as reportN1');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,((n1.amort_eco +n1.amort_derog ) -(n2.amort_eco +n2.amort_derog+n2.choix ))as dif');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,n2.choix as choixN2,n1.valeur_a_amortir as V1,n2.valeur_a_amortir as V2');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' from immos.db n');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' join "'+IncludeTrailingPathDelimiter(RepertoireExoNMoins1)+'immos.db" n1 on n1.id=n.id');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' join "'+IncludeTrailingPathDelimiter(RepertoireExoNMoins2)+'immos.db" n2 on n2.id=n.id');
                 DMcorrections.QuCorrectionDossier.open;
                 DMcorrections.QuCorrectionDossier.first;
                 GestionGauge(30,gauge,200,0,'Contrôle des amortissements (report)');
                 while not DMcorrections.QuCorrectionDossier.eof do
                 begin
                     immobilisation:=Timmos.Create(DMcorrections);
                     immobilisation.NumImmos:=DMcorrections.QuCorrectionDossier.findfield('Immobilisation').asstring;
                     immobilisation.reportN1:=DMcorrections.QuCorrectionDossier.findfield('reportN1').AsCurrency;
                     immobilisation.reportN2:=DMcorrections.QuCorrectionDossier.findfield('reportN2').AsCurrency;
                     immobilisation.choixN2:=DMcorrections.QuCorrectionDossier.findfield('choixN2').AsCurrency;
                     immobilisation.Diff:=DMcorrections.QuCorrectionDossier.findfield('dif').AsCurrency;
                     if(DMcorrections.QuCorrectionDossier.findfield('V1').AsCurrency)=
                     DMcorrections.QuCorrectionDossier.findfield('V2').AsCurrency then
                       ListeRetour.AddObject(immobilisation.NumImmos,immobilisation);
                     DMcorrections.QuCorrectionDossier.next;
                 end;
                 ListeDebug.clear;
                 N2:= monSplitArray(IncludeTrailingPathDelimiter(RepertoireExoNMoins2),PathDelim);
                 N1:= monSplitArray(IncludeTrailingPathDelimiter(RepertoireExoNMoins1),PathDelim);
                 ListeDebug.Add('Immos;'+N2[Length(N2)-1]+';'+N1[Length(N1)-1]+';Dif');
                 for i:=0 to listeRetour.count-1 do
                 begin
                     ListeDebug.Add(Timmos(ListeRetour.Objects[i]).NumImmos+';'+
                     CurrToStr_Lgr(Timmos(ListeRetour.Objects[i]).reportN1)+';'+
                     CurrToStr_Lgr(Timmos(ListeRetour.Objects[i]).reportN2)+';'+
                     CurrToStr_Lgr(Timmos(ListeRetour.Objects[i]).Diff))
                 end;
                 ListeDebug.SaveToFile(e.RepertoireDossier+'reportImmos21000.txt');
                 GestionGauge(50,gauge,200,0,'Contrôle des amortissements (report)');
                for i:=0 to ListeRetour.count-1 do
                begin
                   if(Timmos(ListeRetour.Objects[i]).reportN2<>Timmos(ListeRetour.Objects[i]).reportN1)then
                     begin
                       abort;
                     end;
                end;
                end;
                   result.NumErreur:=21001;
                //si de N-2 vers N-1 ok alors on contrôle la table du dossier
                    DMcorrections.QuCorrectionDossier.close;
                    DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
                    DMcorrections.QuCorrectionDossier.SQL.Clear;
                    DMcorrections.QuCorrectionDossier.SQL.Add('select n.id,n.Compte||n.Code||n.Sous_Code||n.Libelle as Immobilisation');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,n1.amort_eco +n1.amort_derog+n1.choix as reportN1');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,n.amort_eco +n.amort_derog as reportN');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,((n.amort_eco +n.amort_derog ) -(n1.amort_eco +n1.amort_derog+n1.choix ))as dif');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,n1.choix as choixN1,n.valeur_a_amortir as V1,n1.valeur_a_amortir as V2');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' from immos.db n');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' join "'+IncludeTrailingPathDelimiter(RepertoireExoNMoins1)+'immos.db" n1 on n1.id=n.id');
                 DMcorrections.QuCorrectionDossier.open;
                 DMcorrections.QuCorrectionDossier.first;
                 GestionGauge(30,gauge,200,0,'Contrôle des amortissements (report)');
                 while not DMcorrections.QuCorrectionDossier.eof do
                 begin
                     immobilisation:=Timmos.Create(DMcorrections);
                     immobilisation.NumImmos:=DMcorrections.QuCorrectionDossier.findfield('Immobilisation').asstring;
                     immobilisation.reportN1:=DMcorrections.QuCorrectionDossier.findfield('reportN').AsCurrency;
                     immobilisation.reportN2:=DMcorrections.QuCorrectionDossier.findfield('reportN1').AsCurrency;
                     immobilisation.choixN2:=DMcorrections.QuCorrectionDossier.findfield('choixN1').AsCurrency;
                     immobilisation.Diff:=DMcorrections.QuCorrectionDossier.findfield('dif').AsCurrency;
                     if(DMcorrections.QuCorrectionDossier.findfield('V1').AsCurrency)=
                     DMcorrections.QuCorrectionDossier.findfield('V2').AsCurrency then
                       ListeRetour.AddObject(immobilisation.NumImmos,immobilisation);
                     DMcorrections.QuCorrectionDossier.next;
                 end;
                 ListeDebug.clear;
                 N:= monSplitArray(IncludeTrailingPathDelimiter(e.RepertoireExercice),PathDelim);
                 N1:= monSplitArray(IncludeTrailingPathDelimiter(RepertoireExoNMoins1),PathDelim);
                 ListeDebug.Add('Immos;'+N[Length(N)-1]+';'+N1[Length(N1)-1]+';Dif');
                 for i:=0 to listeRetour.count-1 do
                 begin
                     ListeDebug.Add(Timmos(ListeRetour.Objects[i]).NumImmos+';'+
                     CurrToStr_Lgr(Timmos(ListeRetour.Objects[i]).reportN1)+';'+
                     CurrToStr_Lgr(Timmos(ListeRetour.Objects[i]).reportN2)+';'+
                     CurrToStr_Lgr(Timmos(ListeRetour.Objects[i]).Diff))
                 end;
                 ListeDebug.SaveToFile(e.RepertoireDossier+'reportImmos21001.txt');
                 GestionGauge(50,gauge,200,0,'Contrôle des amortissements (report)');
                for i:=0 to ListeRetour.count-1 do
                begin
                   if(Timmos(ListeRetour.Objects[i]).reportN2<>Timmos(ListeRetour.Objects[i]).reportN1)then
                     begin
                       abort;
                     end;
                end;
             end;//fin si liste exercice >=2
             GestionGauge(10,gauge,200,0,'Contrôle des amortissements (report)');
        Patienterfermer;
    end;
    fin:
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+']'+messageRetour,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  GestionGauge(100,gauge,100,0,'Contrôle des amortissements (report)');
  PatienterFermer;
  FreeAndNil(ListeExercices);
  FreeAndNil(ListeRetour);
  FreeAndNil(ListeDebug);
  result.GestMessageLGR.Enregistrement:=false;
end;
end;

constructor TImmos.Create(AOwner :TComponent);
Begin
inherited create;
End;

destructor TImmos.Destroy;
Begin
inherited Destroy;
End;



Function VerifTableImmosIdentique(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
i:integer;
Confirmation:boolean;
ListeRetour:Tstringlist;
ListeExercices:Tstringlist;
RepertoireExoNMoins2,RepertoireExoNMoins1,RepertoireExoN:string;
InfosGestDossier:TInfosGestDossier;
immobilisation:Timmos;
label fin;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
ListeExercices:=TStringList.Create;
result.NumErreur:=21002;
result.retour:=true;
 result.NomModule:='VerifTableImmosIdentique';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de Cohérence du report des immos sur le dossier ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;
        GestionGauge(10,gauge,100,0,'Contrôle des amortissements sur le dossier');
        ListeRetour:=TStringList.Create;
                 if(not FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immosTemporaire.db'))then goto fin;
                 DMcorrections.QuCorrectionDossier.close;
                 DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
                    DMcorrections.QuCorrectionDossier.SQL.Clear;

                    DMcorrections.QuCorrectionDossier.SQL.Add('select n.id,n.Compte||n.Code||n.Sous_Code||n.Libelle as Immobilisation');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,n.amort_eco +n.amort_derog+n.choix as reportDossier');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' ,n2.amort_eco +n2.amort_derog+n2.choix as reportTemp');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' from immos.db n');
                    DMcorrections.QuCorrectionDossier.SQL.Add(' left join "'+IncludeTrailingPathDelimiter(e.RepertoireDossier)+'immosTemporaire.db" n2 on n2.id=n.id');
                 DMcorrections.QuCorrectionDossier.open;
                 DMcorrections.QuCorrectionDossier.first;
                 GestionGauge(30,gauge,100,0,'Contrôle des amortissements sur le dossier');
                 while not DMcorrections.QuCorrectionDossier.eof do
                 begin
                     immobilisation:=Timmos.Create(DMcorrections);
                     immobilisation.NumImmos:=DMcorrections.QuCorrectionDossier.findfield('Immobilisation').asstring;
                     immobilisation.reportN1:=DMcorrections.QuCorrectionDossier.findfield('reportDossier').AsCurrency;
                     immobilisation.reportN2:=DMcorrections.QuCorrectionDossier.findfield('reportTemp').AsCurrency;
                     ListeRetour.AddObject(immobilisation.NumImmos,immobilisation);
                     DMcorrections.QuCorrectionDossier.next;
                 end;
                 GestionGauge(50,gauge,100,0,'Contrôle des amortissements sur le dossier');
                for i:=0 to ListeRetour.count-1 do
                begin
                   if(Timmos(ListeRetour.Objects[i]).reportN2<>Timmos(ListeRetour.Objects[i]).reportN1)then
                     begin
                       abort;
                     end;
                end;
             GestionGauge(10,gauge,100,0,'Contrôle des amortissements sur le dossier');
        Patienterfermer;
    end;
    fin:
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  GestionGauge(100,gauge,100,0,'Contrôle des amortissements sur le dossier');
  PatienterFermer;
  FreeAndNil(ListeExercices);
  FreeAndNil(ListeRetour);
  result.GestMessageLGR.Enregistrement:=false;
end;
end;


Function CorrectionDuPlanComptable(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
  table: TTable;
  DBAux:TDataBase;
Confirmation:boolean;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
        result.NumErreur:=22000;
        result.retour:=true;
 result.NomModule:='CorrectionDuPlanComptable';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=((e.AccesOuverture)and(not e.ExerciceCloture));
        if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer la correction du paramètrage du plan comptable ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;

        GestionGauge(10,gauge,30,0,'Correction du paramètrage du plan comptable');

        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.SQL.Clear;
        DMcorrections.QuCorrectionDossier.SQL.add('delete from plancpt where compte =''131''' +
        ' or compte =''201'' or compte = ''203'' or compte = ''206'' or compte = ''207'' or compte = ''211'' or compte = ''212'' or compte = ''213'' or compte = ''214'' or compte = ''215'' or compte = ''218'' or compte = ''2181'' or compte = ''2182'' or compte = ''2183'''+
        ' or compte = ''2184'' or compte = ''2186'' or compte = ''22'' or compte = ''220'' or compte = ''222'' or compte = ''231'' or compte = ''237'' or compte = ''238'' or compte = ''261'' or compte = ''266'' or compte = ''271'' or compte = ''272'' or compte = ''277'''+
        ' or compte = ''60'' or compte = ''601'' or compte = ''6011'' or compte = ''6012'' or compte = ''6017'' or compte = ''602'' or compte = ''6021'' or compte = ''60211'' or compte = ''60212'' or compte = ''6022'' or compte = ''60221'' or compte = ''60222'''+
        ' or compte = ''60223'' or compte = ''60224'' or compte = ''60225'' or compte = ''6026'' or compte = ''604'' or compte = ''605'' or compte = ''606'' or compte = ''6061'' or compte = ''6063'' or compte = ''6064'' or compte = ''6068'' or compte = ''607'''+
        ' or compte = ''6071'' or compte = ''6072'' or compte = ''608'' or compte = ''609'' or compte = ''61'' or compte = ''611'' or compte = ''612'' or compte = ''6122'' or compte = ''6125'' or compte = ''613'' or compte = ''6132'' or compte = ''6135'' or compte = ''614'''+
        ' or compte =''615'' or compte = ''6152'' or compte = ''6155'' or compte = ''6156'' or compte = ''617'' or compte = ''618'' or compte = ''6181'' or compte = ''6183'' or compte = ''6185'' or compte = ''619'' or compte = ''62'' or compte = ''621'' or compte = ''622'''+
        ' or compte = ''6221'' or compte = ''6222'' or compte = ''6224'' or compte = ''6225'' or compte = ''6226'' or compte = ''6227'' or compte = ''6228'' or compte = ''623'' or compte = ''6231'' or compte = ''6232'' or compte = ''6233'' '+
        ' or  compte = ''6234'' or compte = ''6235'' or compte = ''6236'' or compte = ''6237'' or compte = ''6238'' or compte = ''624'' or compte = ''6241'' or compte = ''6242''' +
        ' or compte = ''6243'' or compte = ''6248'' or compte = ''625'' or compte = ''6251'' or compte = ''6255'' or compte = ''6256'' or compte = ''6257'''+
        ' or compte = ''626'' or compte = ''627'' or compte = ''6271'' or compte = ''6272'' or compte = ''6275'' or compte = ''628'' or compte = ''6281'' or compte = ''6284'' or compte = ''629'' or compte = ''661'' or compte = ''6615'' or compte = ''6616'' or compte = ''6617'''+
        ' or compte = ''6618'' or compte = ''664'' or compte = ''665'' or compte = ''666'' or compte = ''667'' or compte = ''668'' or compte = ''671'' or compte = ''6712'' or compte = ''6713'' or compte = ''6714'' or compte = ''6715'' or compte = ''6718'' or compte = ''672'''+
        ' or compte = ''678'' or compte = ''701'' or compte = ''7011'' or compte = ''7012'' or compte = ''702'' or compte = ''703'' or compte = ''704'' or compte = ''7041'' or compte = ''7042'' or compte = ''705'' or compte = ''706'' or compte = ''708'' or compte = ''7082'''+
        ' or compte = ''7083'' or compte = ''7085'' or compte = ''7088'' or compte = ''709'' or compte = ''721'' or compte = ''731'' or compte = ''739'' or compte = ''74'' or compte = ''740''');
        DMcorrections.QuCorrectionDossier.ExecSQL;
        DMcorrections.QuCorrectionDossier.close;
        GestionGauge(10,gauge,-1,-1,'');


      Try
        with DMcorrections.TaCorrection do
          begin
            DatabaseName := DM_C_NomAliasDossier;
            TableName := 'PlanCpt.DB';
            open;
            //if RecordCount = 0 then
            begin
            flushBuffers;
                AppendRecord([131,'Subventions d''équipement',0,0,Nil,Nil,0,0,False,Nil,Nil,False,True,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',131,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([201,'Frais d''établissement',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',201,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([203,'Frais de recherche et dével.',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',203,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([206,'Droit au bail',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',206,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([207,'Fonds commercial',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',207,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([211,'Terrains',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',211,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([212,'Agencements et aménag. terrain',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',212,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([213,'Constructions',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',213,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([214,'Constructions sur sol d''autrui',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',214,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([215,'Matériel et outillage',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',215,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([218,'Autres immos corporelles',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',218,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([2181,'Agencements et installations',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',2181,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([2182,'Matériel de transport',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',2182,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([2183,'Mat. de bureau et informatique',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',2183,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([2184,'Mobilier',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',2184,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([2186,'Emballages récupérables',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',2186,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([22,'IMMOBILIS. MISES EN CONCESSION',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',22,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([220,'Immobilis. mises en conces.',0,0,Nil,Nil,0,0,False,Nil,Nil,False,False,False,False,False,False,True,True,False,False,False,'LGR','01/01/1980 00:00:00',220,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([222,'Production immos. corporelles',0,0,Nil,Nil,0,0,False,'I1','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',222,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([231,'Immobilis. corpor. en cours',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',231,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([237,'Avances /immos incorporelles',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',237,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([238,'Avances /immos corporelles',0,0,Nil,Nil,0,0,False,'I1','D',True,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',238,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([261,'Titres de participation',0,0,Nil,Nil,0,0,False,Nil,Nil,False,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',261,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([266,'Autres formes de participation',0,0,Nil,Nil,0,0,False,Nil,Nil,False,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',266,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([271,'Titres immobilisés',0,0,Nil,Nil,0,0,False,Nil,Nil,False,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',271,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([272,'Titres immobilisés (droit de créances)',0,0,Nil,Nil,0,0,False,Nil,Nil,False,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',272,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([277,'Actions ou parts propres',0,0,Nil,Nil,0,0,False,Nil,Nil,False,False,False,False,False,False,True,False,False,False,False,'LGR','01/01/1980 00:00:00',277,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([60,'ACHATS',0,0,Nil,Nil,0,0,False,Nil,'D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',60,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([601,'Achat stockés de mat. prem.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',601,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6011,'Achat matières prem. A',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6011,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6012,'Achat matières prem. B',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6012,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6017,'Achat fournitures',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6017,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([602,'Achats stockés, Autres appros',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',602,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6021,'Matières consommables',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6021,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([60211,'Achat mat. consomm. C',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',60211,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([60212,'Achat mat. consomm. D',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',60212,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6022,'Fournitures consommables',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6022,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([60221,'Achat combustibles',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',60221,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([60222,'Achat produits d''entretien',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',60222,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([60223,'Achat fournitures d''atelier',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',60223,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([60224,'Achat fournitures de magasin',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',60224,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([60225,'Achat fournitures de bureau',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',60225,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6026,'Achat d''emballages',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6026,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([604,'Achat études et prestat. serv.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',604,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([605,'Achat matériel, équipement',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',605,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([606,'Achat non stockés fourn. mat.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',606,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6061,'Fourn. non stockables',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6061,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6063,'Fourn. d''entret. petit équipement',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6063,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6064,'Fourn. administratives',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6064,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6068,'Autres fournitures',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6068,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([607,'Achat de marchandises',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',607,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6071,'Achat marchandises A',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6071,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6072,'Achat marchandises B',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6072,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([608,'Frais accessoires d''achat',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',608,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([609,'R.R.R.O sur achats',0,0,Nil,Nil,0,0,False,'A1','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',609,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([61,'SERVICES EXTERIEURS',0,0,Nil,Nil,0,0,False,Nil,'D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',61,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([611,'Sous-traitance générale',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',611,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([612,'Redevances de crédit-bail',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',612,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6122,'Crédit bail mobilier',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6122,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6125,'Crédit bail immobilier',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6125,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([613,'Locations',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',613,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6132,'Location immobilière',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6132,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6135,'Location mobilière',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6135,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([614,'Charge locative de co-proprié.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',614,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([615,'Entretien et réparations',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',615,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6152,'Entretien sur bien immobilier',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6152,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6155,'Entretien sur bien mobilier',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6155,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6156,'Maintenance',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6156,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([617,'Etudes et recherches',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',617,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([618,'Divers',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',618,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6181,'Documentation générale',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6181,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6183,'Documentation technique',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6183,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6185,'Frais de colloque,séminaire...',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6185,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([619,'RRRO /services extérieurs',0,0,Nil,Nil,0,0,False,'A1','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',619,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([62,'AUTRES SERVICES EXTERIEURS',0,0,Nil,Nil,0,0,False,Nil,'D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',62,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([621,'Personnel extérieur à l''entre.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',621,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([622,'Rémunérat. interméd. et honor.',0,0,Nil,Nil,0,0,False,'A1','E',False,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',622,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6221,'Commissions sur achats',0,0,Nil,Nil,0,0,False,'A1','E',False,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6221,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6222,'Commissions sur ventes',0,0,Nil,Nil,0,0,False,'A1','E',False,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6222,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6224,'Rémunération des transitaires',0,0,Nil,Nil,0,0,False,'A1','E',False,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6224,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6225,'Rémunération d''affacturage',0,0,Nil,Nil,0,0,False,'A1','E',False,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6225,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6226,'Honoraires',0,0,Nil,Nil,0,0,False,'A1','E',False,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6226,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6227,'Frais d''acte et de contentieux',0,0,Nil,Nil,0,0,False,'A1','E',False,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6227,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6228,'Divers',0,0,Nil,Nil,0,0,False,'A1','E',False,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6228,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([623,'Publicité, publications',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',623,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6231,'Annonces et insertions',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6231,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6232,'Echantillons',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6232,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6233,'Foires et expositions',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6233,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6234,'Cadeaux à la clientèle',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6234,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6235,'Primes',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6235,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6236,'Catalogues et imprimés',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6236,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6237,'Publications',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6237,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6238,'Divers : dons, pourboires...',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6238,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([624,'Transports de biens et person.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',624,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6241,'Transports sur achats',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6241,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6242,'Transports sur ventes',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6242,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6243,'Transports sur chantiers',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6243,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6248,'Divers',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6248,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([625,'Déplacem., missions et récept.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',625,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6251,'Voyages et déplacements',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6251,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6255,'Frais de déménagement',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6255,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6256,'Missions',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6256,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6257,'Réceptions',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6257,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([626,'Frais postaux et télécommunic.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',626,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([627,'Services bancaires & assimilés',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',627,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6271,'Frais sur titres',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6271,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6272,'Commissions sur émiss. d''emp.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6272,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6275,'Frais sur effets',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6275,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([628,'Divers',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',628,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6281,'Cotisations',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6281,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6284,'Frais de recrutement de pers.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6284,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([629,'R.R.R.O services extérieurs',0,0,Nil,Nil,0,0,False,'A1','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',629,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([661,'Charges d''intérêts',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',661,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6615,'Intér. des comptes courants',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6615,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6616,'Intér. bancaires',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6616,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6617,'Intér. des obligations',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6617,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6618,'Intér. des autres dettes',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6618,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([664,'Pertes /créances à des partic.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',664,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([665,'Escomptes accordés',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',665,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([666,'Pertes de change',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',666,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([667,'Charges /cess. valeurs placem.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',667,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([668,'Autres charges financières',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',668,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([671,'Charges exceptionnelles',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',671,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6712,'Pénalités, amendes fiscales',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6712,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6713,'Dons, libéralités',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6713,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6714,'Créances devenues irrécouvrab.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6714,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6715,'Subventions accordées',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6715,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([6718,'Autres charges except./op.gest',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',6718,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([672,'Charges except./exercices ant.',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',672,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([678,'Autres charges exceptionnelles',0,0,Nil,Nil,0,0,False,'A1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',678,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([701,'Ventes de produits finis',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',701,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([7011,'Vente produits finis A',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',7011,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([7012,'Vente produits finis B',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',7012,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([702,'Vente produits intermédiaires',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',702,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([703,'Vente produits résiduels',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',703,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([704,'Travaux',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',704,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([7041,'Vente de travaux A',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',7041,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([7042,'Vente de travaux B',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',7042,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([705,'Etudes',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',705,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([706,'Prestations de services',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',706,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([708,'Produits des activités annexes',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',708,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([7082,'Commissions et courtages',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',7082,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([7083,'Locations diverses',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',7083,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([7085,'Ports et frais accessoires facturés',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',7085,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([7088,'Autres produits d''activ. annex',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',7088,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([709,'R.R.R. Accordés par l''entrep.',0,0,Nil,Nil,0,0,False,'V4','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',709,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([721,'Production immob. incorporelle',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',721,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([731,'Prod. nets part. opér.en cours',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',731,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([739,'Prod. nets part. opér. termin.',0,0,Nil,Nil,0,0,False,'V4','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',739,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([74,'SUBVENTIONS D''EXPLOITATION',0,0,Nil,Nil,0,0,False,'N1','D',True,False,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',74,Nil,False,0,Nil,0,'',Nil]);
                AppendRecord([740,'Subventions d''exploitation',0,0,Nil,Nil,0,0,False,'N1','D',True,True,False,False,False,False,False,False,False,False,False,'LGR','01/01/1980 00:00:00',740,Nil,False,0,Nil,0,'',Nil]);

            flushBuffers;
            DMcorrections.TaCorrection.Close;
            end;
          end
      except
        Application.MessageBox('Erreur lors de l''initialisation du plan comptable Industriel','Attention',MB_OK+MB_ICONSTOP);
      end;

    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;
  GestionGauge(10,gauge,0,0,'',false);

  DMcorrections.QuCorrectionDossier.Close;
  PatienterFermer;
  result.GestMessageLGR.Enregistrement:=false;
end;
end;


//Function CorrectionIdEcriture(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
//var
//Confirmation:boolean;
//exoSaisie:string;
//dateDeb,dateFin,datePiece:TDateTime;
//idEcritureSearch,idEcritureNew:integer;
//begin
//try//finally
//try//except
//Initialise_ExceptLGR(result,GestMessageLGR);
//result.NumErreur:=0;
//result.retour:=true;
// result.NomModule:='CorrectionIdEcriture';
// result.NomDossier:=e.NomDossier;
// result.GestMessageLGR.Enregistrement:=true;
// confirmation:=true;
//exoSaisie:='';
//dateDeb:=0;
//dateFin:=0;
// if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
// if DMEcritures=nil then DMEcritures:=TDMEcritures.Create(Application.MainForm);
// if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);
// if not confirmation then
//   begin
//    if DemandeConfirmation then
//      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
//   end
// else
// if DemandeConfirmation then
//  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de Correction des Id Ecriture ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
//if Confirmation then
//    begin
//        PatienterAffich;
//
//        DMcorrections.QuCorrectionDossier.Close;
//        DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
//        //Récupérer toutes les lignes d''écriture avec un id <10000000
//        DMcorrections.QuCorrectionDossier.SQL.Clear;
////        DMcorrections.QuCorrectionDossier.SQL.Add('select e.id,e.id_piece, p."date" as datePiece from ecriture e join piece p on p.id=e.id_piece where e.id < 10000000 order by p."date"');
//        DMcorrections.QuCorrectionDossier.SQL.Add('select e.id,e.id_piece, p."date" as datePiece from ecriture e join piece p on p.id=e.id_piece where e.id < 10000000 order by p."date" ');
////        ' order by p."date" as datePiece');                                         //, p."date" as datePiece
//        DMcorrections.QuCorrectionDossier.open;
//        DMcorrections.QuCorrectionDossier.first;
//        exoSaisie:='';
//        dateDeb:=0;
//        dateFin:=0;
//        //if(DMcorrections.QuCorrectionDossier.RecordCount>0)then showmessage('Dossier à corriger');
//
//        while (not DMcorrections.QuCorrectionDossier.Eof) do
//        begin
//           datePiece:=DMcorrections.QuCorrectionDossier.findfield('datePiece').AsDateTime;
//           if(not DateDsIntervale(dateDeb,datePiece,dateFin))then
//             begin
//                 //récupérer le code ExoSaisie correspondant à la période de la pièce
//                 DMcorrections.QuCorrectionInsert.Close;
//                 DMcorrections.QuCorrectionInsert.SQL.Clear;
//                 DMcorrections.QuCorrectionInsert.SQL.Add('select G.exo_saisie,G.date_deb_exo , G.date_fin_exo from Gdossier G where '+
//                 ' cast(G.date_deb_exo as date) <= :datePiece and cast(G.date_fin_exo as date)>=:datePiece');
//                 DMcorrections.QuCorrectionInsert.ParamByName('datePiece').AsDateTime:=datePiece;
//                 DMcorrections.QuCorrectionInsert.open;
//                 DMcorrections.QuCorrectionInsert.first;
//                  exoSaisie:='';
//                  dateDeb:=0;
//                  dateFin:=0;
//                 if(DMcorrections.QuCorrectionInsert.RecordCount>0)then
//                 begin
//                    exoSaisie:=DMcorrections.QuCorrectionInsert.findfield('exo_saisie').AsString;
//                    dateDeb:=DMcorrections.QuCorrectionInsert.findfield('date_deb_exo').AsDateTime;
//                    dateFin:=DMcorrections.QuCorrectionInsert.findfield('date_fin_exo').AsDateTime;
//                 end
//                 else abort;
//             end;
//            //on utilise les paramètres récupéré pour modifier l'id ecriture
//            idEcritureSearch:=DMcorrections.QuCorrectionDossier.findfield('id').AsInteger;
//            idEcritureNew:=DMEcritures.MaxIdEcriture_Exo(exoSaisie,idEcritureSearch);
//
//            DMcorrections.QuCorrectionUpdate.Close;
//            DMcorrections.QuCorrectionUpdate.DatabaseName:=DM_C_NomAliasDossier;
//             TableGereStartTransaction(DMcorrections.QuCorrectionUpdate);
//
//            //table ecriture
//            DMcorrections.QuCorrectionUpdate.SQL.Clear;
//            DMcorrections.QuCorrectionUpdate.SQL.Add(('update ecriture set id = '+IntToStr_Lgr(idEcritureNew)+' where id='+IntToStr_Lgr(idEcritureSearch)));
//            DMcorrections.QuCorrectionUpdate.ExecSQL;
//             TableGereCommit(DMcorrections.QuCorrectionUpdate);
//            //table pointage debit
//
//            DMcorrections.QuCorrectionUpdate.SQL.Clear;
//            DMcorrections.QuCorrectionUpdate.SQL.Add(('update pointage set id_debit = '+IntToStr_Lgr(idEcritureNew)+' where id_debit='+IntToStr_Lgr(idEcritureSearch)));
//            DMcorrections.QuCorrectionUpdate.ExecSQL;
//             TableGereCommit(DMcorrections.QuCorrectionUpdate);
//            //table pointage credit
//
//            DMcorrections.QuCorrectionUpdate.SQL.Clear;
//            DMcorrections.QuCorrectionUpdate.SQL.Add(('update pointage set id_credit = '+IntToStr_Lgr(idEcritureNew)+' where id_credit='+IntToStr_Lgr(idEcritureSearch)));
//            DMcorrections.QuCorrectionUpdate.ExecSQL;
//
//            DMcorrections.QuCorrectionUpdate.SQL.Clear;
//            DMcorrections.QuCorrectionUpdate.SQL.Add(('update resteDc set id_ecriture = '+IntToStr_Lgr(idEcritureNew)+' where id_ecriture='+IntToStr_Lgr(idEcritureSearch)));
//            DMcorrections.QuCorrectionUpdate.ExecSQL;
//
//            TableGereCommit(DMcorrections.QuCorrectionUpdate);
//            DMcorrections.QuCorrectionUpdate.sql.clear;
//            DMcorrections.QuCorrectionUpdate.close;
//          DMcorrections.QuCorrectionDossier.Next;
//        end;
//        Patienterfermer;
//    end;
//except
//  result.retour:=false;
//end;
//finally
//    try
//    if result.retour=false then
//        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
//    except
//    end;
//  if result.retour then
//    begin
//      result.retour:=confirmation;
//      result.NumErreur:=-1;
//    end;
//
//  result.GestMessageLGR.Enregistrement:=false;
//  PatienterFermer;
//end;
//end;

Function CorrectionIdEcriture(Gauge:TGauge;DemandeConfirmation:boolean):texceptlgr;
var
Confirmation:boolean;
exoSaisie:string;
dateDeb,dateFin,datePiece:TDateTime;
idEcritureSearch,idEcritureNew:integer;
listeEcriture:Tstringlist;
i:integer;
begin
try//finally
try//except
Initialise_ExceptLGR(result,GestMessageLGR);
result.NumErreur:=0;
result.retour:=true;
 result.NomModule:='CorrectionIdEcriture';
 result.NomDossier:=e.NomDossier;
 result.GestMessageLGR.Enregistrement:=true;
 confirmation:=true;
exoSaisie:='';
dateDeb:=0;
dateFin:=0;
listeEcriture:=TStringList.Create;
 if DMcorrections=nil then DMcorrections:=TDMcorrections.Create(Application.MainForm);
 if DMEcritures=nil then DMEcritures:=TDMEcritures.Create(Application.MainForm);
 if DMRech=nil then DMRech:=TDMRech.Create(Application.MainForm);
 if not confirmation then
   begin
    if DemandeConfirmation then
      MessageDlg_lgr(AccesProcedureRefuse_General, mtInformation, [mbOK], 0);
   end
 else
 if DemandeConfirmation then
  Confirmation:=MessageDlg_lgr('Voulez_vous lancer le contrôle de Correction des Id Ecriture ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes;
if Confirmation then
    begin
        PatienterAffich;

        DMcorrections.QuCorrectionDossier.Close;
        DMcorrections.QuCorrectionDossier.DatabaseName:=DM_C_NomAliasDossier;
        //Récupérer toutes les lignes d''écriture avec un id <10000000
        DMcorrections.QuCorrectionDossier.SQL.Clear;
//        DMcorrections.QuCorrectionDossier.SQL.Add('select e.id,e.id_piece, p."date" as datePiece from ecriture e join piece p on p.id=e.id_piece where e.id < 10000000 order by p."date"');
        DMcorrections.QuCorrectionDossier.SQL.Add('select e.id,e.id_piece, p."date" as datePiece from ecriture e join piece p on p.id=e.id_piece where e.id < 10000000 ');
        DMcorrections.QuCorrectionDossier.open;
        DMcorrections.QuCorrectionDossier.first;
        exoSaisie:='';
        dateDeb:=0;
        dateFin:=0;
        listeEcriture.Sorted:=true;
        listeEcriture.Duplicates:=dupAccept;
        //if(DMcorrections.QuCorrectionDossier.RecordCount>0)then showmessage('Dossier à corriger');
        while (not DMcorrections.QuCorrectionDossier.Eof) do
        begin
          listeEcriture.Add(DMcorrections.QuCorrectionDossier.findfield('datePiece').AsString+';'+DMcorrections.QuCorrectionDossier.findfield('id').AsString);
          DMcorrections.QuCorrectionDossier.Next;
        end;

        for i:=0 to listeEcriture.Count-1 do
       // while (not DMcorrections.QuCorrectionDossier.Eof) do
        begin
           //
           datePiece:=StrToDate_Lgr(str_getstringelement(listeEcriture.Strings[i],1,';'));
           if(not DateDsIntervale(dateDeb,datePiece,dateFin))then
             begin
                 //récupérer le code ExoSaisie correspondant à la période de la pièce
                 DMcorrections.QuCorrectionInsert.Close;
                 DMcorrections.QuCorrectionInsert.SQL.Clear;
                 DMcorrections.QuCorrectionInsert.SQL.Add('select G.exo_saisie,G.date_deb_exo , G.date_fin_exo from Gdossier G where '+
                 ' cast(G.date_deb_exo as date) <= :datePiece and cast(G.date_fin_exo as date)>=:datePiece');
                 DMcorrections.QuCorrectionInsert.ParamByName('datePiece').AsDateTime:=datePiece;
                 DMcorrections.QuCorrectionInsert.open;
                 DMcorrections.QuCorrectionInsert.first;
                  exoSaisie:='';
                  dateDeb:=0;
                  dateFin:=0;
                 if(DMcorrections.QuCorrectionInsert.RecordCount>0)then
                 begin
                    exoSaisie:=DMcorrections.QuCorrectionInsert.findfield('exo_saisie').AsString;
                    dateDeb:=DMcorrections.QuCorrectionInsert.findfield('date_deb_exo').AsDateTime;
                    dateFin:=DMcorrections.QuCorrectionInsert.findfield('date_fin_exo').AsDateTime;
                 end
                 else abort;
             end;
            //on utilise les paramètres récupéré pour modifier l'id ecriture
            idEcritureSearch:=StrToInt_Lgr(str_getstringelement(listeEcriture.Strings[i],2,';'));
            idEcritureNew:=DMEcritures.MaxIdEcriture_Exo(exoSaisie,idEcritureSearch);

            DMcorrections.QuCorrectionUpdate.Close;
            DMcorrections.QuCorrectionUpdate.DatabaseName:=DM_C_NomAliasDossier;
             TableGereStartTransaction(DMcorrections.QuCorrectionUpdate);

            //table ecriture
            DMcorrections.QuCorrectionUpdate.SQL.Clear;
            DMcorrections.QuCorrectionUpdate.SQL.Add(('update ecriture set id = '+IntToStr_Lgr(idEcritureNew)+' where id='+IntToStr_Lgr(idEcritureSearch)));
            DMcorrections.QuCorrectionUpdate.ExecSQL;
 //            TableGereCommit(DMcorrections.QuCorrectionUpdate);
            //table pointage debit

            DMcorrections.QuCorrectionUpdate.SQL.Clear;
            DMcorrections.QuCorrectionUpdate.SQL.Add(('update pointage set id_debit = '+IntToStr_Lgr(idEcritureNew)+' where id_debit='+IntToStr_Lgr(idEcritureSearch)));
            DMcorrections.QuCorrectionUpdate.ExecSQL;
 //            TableGereCommit(DMcorrections.QuCorrectionUpdate);
            //table pointage credit

            DMcorrections.QuCorrectionUpdate.SQL.Clear;
            DMcorrections.QuCorrectionUpdate.SQL.Add(('update pointage set id_credit = '+IntToStr_Lgr(idEcritureNew)+' where id_credit='+IntToStr_Lgr(idEcritureSearch)));
            DMcorrections.QuCorrectionUpdate.ExecSQL;

            DMcorrections.QuCorrectionUpdate.SQL.Clear;
            DMcorrections.QuCorrectionUpdate.SQL.Add(('update resteDc set id_ecriture = '+IntToStr_Lgr(idEcritureNew)+' where id_ecriture='+IntToStr_Lgr(idEcritureSearch)));
            DMcorrections.QuCorrectionUpdate.ExecSQL;


            DMcorrections.QuCorrectionUpdate.SQL.Clear;
            DMcorrections.QuCorrectionUpdate.SQL.Add(('update h_tva set id_ecriture = '+IntToStr_Lgr(idEcritureNew)+' where id_ecriture='+IntToStr_Lgr(idEcritureSearch)));
            DMcorrections.QuCorrectionUpdate.ExecSQL;



            
            DMcorrections.QuCorrectionUpdate.SQL.Clear;
            DMcorrections.QuCorrectionUpdate.SQL.Add(('update immos set ecriture_achat = '+IntToStr_Lgr(idEcritureNew)+' where ecriture_achat='+IntToStr_Lgr(idEcritureSearch)));
            DMcorrections.QuCorrectionUpdate.ExecSQL;


            DMcorrections.QuCorrectionUpdate.SQL.Clear;
            DMcorrections.QuCorrectionUpdate.SQL.Add(('update immos set ecriture_cession = '+IntToStr_Lgr(idEcritureNew)+' where ecriture_cession='+IntToStr_Lgr(idEcritureSearch)));
            DMcorrections.QuCorrectionUpdate.ExecSQL;

            
            if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'Ta_releveBancaire.db'))then
              begin
                DMcorrections.QuCorrectionUpdate.SQL.Clear;
                DMcorrections.QuCorrectionUpdate.SQL.Add(('update Ta_releveBancaire set id_ecriture = '+IntToStr_Lgr(idEcritureNew)+' where id_ecriture='+IntToStr_Lgr(idEcritureSearch)));
                DMcorrections.QuCorrectionUpdate.ExecSQL;
             end;
            if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'Ta_affect_Atelier.db'))then
              begin
                DMcorrections.QuCorrectionUpdate.SQL.Clear;
                DMcorrections.QuCorrectionUpdate.SQL.Add(('update Ta_affect_Atelier set id_ligne = '+IntToStr_Lgr(idEcritureNew)+' where id_ligne='+IntToStr_Lgr(idEcritureSearch)));
                DMcorrections.QuCorrectionUpdate.ExecSQL;
              end;

            TableGereCommit(DMcorrections.QuCorrectionUpdate);

            //on passe à l'exercice
            DMcorrections.QuCorrectionUpdate.Close;
            DMcorrections.QuCorrectionUpdate.DatabaseName:=DM_C_NomAliasExercice;

            TableGereStartTransaction(DMcorrections.QuCorrectionUpdate);
            if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'immos.db'))then
              begin
                  DMcorrections.QuCorrectionUpdate.SQL.Clear;
                  DMcorrections.QuCorrectionUpdate.SQL.Add(('update immos set ecriture_achat = '+IntToStr_Lgr(idEcritureNew)+' where ecriture_achat='+IntToStr_Lgr(idEcritureSearch)));
                  DMcorrections.QuCorrectionUpdate.ExecSQL;

                  DMcorrections.QuCorrectionUpdate.SQL.Clear;
                  DMcorrections.QuCorrectionUpdate.SQL.Add(('update immos set ecriture_cession = '+IntToStr_Lgr(idEcritureNew)+' where ecriture_cession='+IntToStr_Lgr(idEcritureSearch)));
                  DMcorrections.QuCorrectionUpdate.ExecSQL;
              end;

            DMcorrections.QuCorrectionUpdate.SQL.Clear;
            DMcorrections.QuCorrectionUpdate.SQL.Add(('update Ta_ecriture_atelier set id_ligne = '+IntToStr_Lgr(idEcritureNew)+' where id_ligne='+IntToStr_Lgr(idEcritureSearch)));
            DMcorrections.QuCorrectionUpdate.ExecSQL;

            if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireExercice)+'reglemnt.db'))then
              begin
                DMcorrections.QuCorrectionUpdate.SQL.Clear;
                DMcorrections.QuCorrectionUpdate.SQL.Add(('update reglemnt set id_debit = '+IntToStr_Lgr(idEcritureNew)+' where id_debit='+IntToStr_Lgr(idEcritureSearch)));
                DMcorrections.QuCorrectionUpdate.ExecSQL;


                DMcorrections.QuCorrectionUpdate.SQL.Clear;
                DMcorrections.QuCorrectionUpdate.SQL.Add(('update reglemnt set id_credit = '+IntToStr_Lgr(idEcritureNew)+' where id_credit='+IntToStr_Lgr(idEcritureSearch)));
                DMcorrections.QuCorrectionUpdate.ExecSQL;
              end;

            TableGereCommit(DMcorrections.QuCorrectionUpdate);
            DMcorrections.QuCorrectionUpdate.sql.clear;
            DMcorrections.QuCorrectionUpdate.close;
          //DMcorrections.QuCorrectionDossier.Next;
        end;
        Patienterfermer;
    end;
except
  result.retour:=false;
end;
finally
    try
    if result.retour=false then
        raise ExceptLGR.Create('Le contrôle [N° '+inttostr(result.NumErreur)+'] du dossier ne s''est pas déroulé correctement !'+AppelerServiceMaintenance,result.NumErreur,true,mtError,Result);
    except
    end;
  if result.retour then
    begin
      result.retour:=confirmation;
      result.NumErreur:=-1;
    end;

  result.GestMessageLGR.Enregistrement:=false;
  PatienterFermer;
end;
end;

end.

