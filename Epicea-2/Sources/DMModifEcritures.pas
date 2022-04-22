unit DMModifEcritures;

interface

uses
  SysUtils,
  Classes,
  DB,
  E2_Decl_Records,
  Gr_Librairie_Obj,
  E2_Librairie_Obj,
  Dialogs,
  LibDates,
  lib_chaine,
  LibSQL,
  DMRecherche,
  E2_LibInfosTable,
  DMBalances,
  E2_CompLigne,
  Forms,
  referencement,
  StdCtrls,
  AideMontant2,
  Controls,
  Grids,
  LibZoneSaisie,
  LibRessourceString,
  DMConstantes,
  DBTables;

type
    ChampsModifiables=(MF_Compte,MF_Tiers,MF_Libelle,MF_Date,MF_Qt1,MF_Qt2,MF_Debit,MF_Credit,MF_ComplementLigne);
    SetChampsNotModifiable=set of ChampsModifiables;
    TStateChange=procedure (Etat:TDataSetState) of object;

    TParamDMModifEcriture=record
      ModifEcritureDataStateChange:TStateChange;
      ModifInterfaceObjet:TGrProcedure;
      GEstInterfaceEvent:TGEstInterfaceEvent;
      EcritureEnCours:integer;
      PieceEnCours:integer;
    end;

  TEcriture = class(TComponent)
  private
    { Déclarations privées }
        FOnModifPropriete:TGrProcedure;
        FOnStateChange:TStateChange;

    FCompteAffiche:string;
    FComptePlan:string;
    FTiers:string;
    FLibelle:string;
    FDate:Tdatetime;
    FQt1:currency;
    FQt2:currency;
    FDebit:currency;
    FCredit:currency;
    FComplementLigne:TcomplementLigne_obj;
    //Old (avant modif)
    FCompte_Old:string;
    FTiers_Old:string;
    FLibelle_Old:string;
    FDate_Old:Tdatetime;
    FQt1_Old:currency;
    FQt2_Old:currency;
    FDebit_Old:currency;
    FCredit_Old:currency;
    FComplementLigne_Old:TcomplementLigne_obj;
    FSensDebit_old:boolean;
    FJournal:integer;
    FComptePiece:string;

    FLienAvecListe:Tlist;
    FPieceAutoGeneree:boolean;
    FRowGrille:integer;
    FID_Ecriture:integer;
    FID_Piece:integer;
    FDatePiece:Tdate;
    FReference:string[9];
    FtypeLigne:Char;
    FValidation:Tdate;
    FNum_Cheque:string[50];
    FID_Gestco:integer;
    FCode_Gestco:string[50];
    FID_Gestanal:integer;
    FCode_Gestanal:string[50];
    FRapprochement:string[8];
    FID_Ligne:integer;
    FID_Devise:integer;
    FQui:string[10];
    FQuand:Tdatetime;
    FTable_Gen:string[50];
    FChamp_Gen:string[50];
    FVal_Champ_Gen:string[100];

    FEcritureDivisee:integer;
    FPointage:TinfosPointageS;
    FDeclaree:boolean;
    FImmobilise:boolean;
    FSupprimable:boolean;
    FModifiable:boolean;
    FUnite1:string;
    FUnite2:string;

    FexceptLgr:TExceptLGR;
    FEtat:TDataSetState;
    FChampsNotModifiable:SetChampsNotModifiable;
    FDebCredEcriture:string;
    FmontantEcriture:currency;
    FmontantEcriture_Old:currency;
    FQteEcriture1:string;
    FQteEcriture2:string;
//    Function LitID_Ecriture:integer;
//    Procedure EcritID_Ecriture(id:integer);
//
//    Function LitID_Piece:integer;
//    Procedure EcritID_Piece(ID_Piece:integer);

    Function LitPointage:Boolean;
//    Procedure EcritPointage(PointageSaisie:Boolean);

    Function LitDeclaree:boolean;
//    Procedure EcritDeclaree(DeclareeSaisie:boolean);

    Function LitSupprimable:boolean;
//    Procedure EcritSupprimable(SupprimableSaisie:boolean);

    Function LitModifiable:boolean;
//    Procedure EcritModifiable(ModifiableSaisie:boolean);

    Function LitRowGrille:integer;
    Procedure EcritRowGrille(RowGrilleSaisie:integer);

    Function LitComptePlan:String;
    Procedure EcritComptePlan(CompteSaisie:String);

    Function LitCompteAffiche:String;
    Procedure EcritCompteAffiche(CompteSaisie:String);

    Function LitTiers:String;
    Procedure EcritTiers(TiersSaisie:String);

    Function LitLibelle:String;
    Procedure EcritLibelle(LibelleSaisie:String);

    Function LitDate:Tdatetime;
    Procedure Ecritdate(dateSaisie:Tdatetime);

    Function LitQt1:currency;
    Procedure EcritQt1(Qt1Saisie:currency);

    Function LitQt2:currency;
    Procedure EcritQt2(Qt2Saisie:currency);

    Function LitDebit:currency;
    Procedure EcritDebit(DebitSaisie:currency);

    Function LitCredit:currency;
    Procedure EcritCredit(CreditSaisie:currency);

    Function LitComplementLigne:TComplementLigne_obj;
    Procedure EcritComplementLigne(ComplementLigneSaisie:TComplementLigne_obj);

    Function LitEtat:TDataSetState;
    Procedure EcritEtat(EtatSaisie:TDataSetState);

    Function LitChampsNotModifiable:SetChampsNotModifiable;
    Procedure EcritChampsNotModifiable(ChampsNotModifiableSaisie:SetChampsNotModifiable);

    Function CtrlCompte(Var CompteSaisie:string):TexceptLgr;
    Function CtrlCompteAffiche(var CompteSaisie:string):TexceptLgr;
    Function CtrlTiers(Var TiersSaisie:string):TexceptLgr;
    Function CtrlLibelle(Var LibelleSaisie:string):TexceptLgr;
    Function CtrlDate(Var DateSaisie:Tdatetime):TexceptLgr;
    Function CtrlQt1(Var Qt1Saisie:Currency):TexceptLgr;
    Function CtrlQt2(Var Qt2Saisie:Currency):TexceptLgr;
    Function CtrlDebit(Var DebitSaisie:Currency):TexceptLgr;
    Function CtrlCredit(Var CreditSaisie:Currency):TexceptLgr;
    Function CtrlComplementLigne(Var ComplementLigneSaisie:TComplementLigne_obj):TexceptLgr;

    Function RetourneTypeEnregistement:integer;
    function NewIDEcriture(TableEcriture:Ttable;ChampID:string;codeExo:string):integer;
    function NewID_Ligne(TableEcriture:Ttable;ChampID:string):integer;
    Procedure RecuperationComplementLigne(CompteSaisie:string;Forcer:boolean=false);
    procedure ChoixSensEtMontant;
    procedure TaEcriture_ModifAfterPost(DataSet: TDataSet);
  public
    { Déclarations publiques }
//    Property ID_Ecriture:integer read LitID_Ecriture write EcritID_Ecriture;
//    Property ID_Piece:integer read LitID_Piece write EcritID_Piece;
      Property OnModifPropriete : TGrProcedure Read FOnModifPropriete Write FOnModifPropriete;


    Property CompteAffiche:string read LitCompteAffiche write EcritCompteAffiche;
    Property ComptePlan:string read LitComptePlan write EcritComptePlan;
    Property Tiers:string read LitTiers write EcritTiers;
    Property Libelle:string read LitLibelle write EcritLibelle ;
    Property Date:Tdatetime read LitDate write EcritDate;
    Property Qt1:currency read LitQt1 write EcritQt1;
    Property Qt2:currency read LitQt2 write EcritQt2;
    Property Debit:currency read LitDebit write EcritDebit;
    Property Credit:currency read LitCredit write EcritCredit;
    Property ComplementLigne:TcomplementLigne_obj read LitComplementLigne write EcritComplementLigne;
    Property Etat:TDataSetState read LitEtat write EcritEtat;
    Property ChampsNotModifiable:SetChampsNotModifiable read LitChampsNotModifiable write EcritChampsNotModifiable;
    Property RowGrille:integer read LitRowGrille write EcritRowGrille;

    Property EcritureDivisee:integer read FEcritureDivisee;
    Property Pointage:TinfosPointageS read FPointage;
    Property Declaree:boolean read FDeclaree;
    Property Immobilise:boolean read FImmobilise;
    Property Supprimable:boolean read FSupprimable;
    Property Modifiable:boolean read FModifiable;
    Property ComptePiece:string read FComptePiece;
    Property Unite1:string read FUnite1;
    Property Unite2:string read FUnite2;
    Property Debit_Old:Currency read FDebit_Old;
    Property Credit_Old:Currency read FCredit_Old;
    Property ComplementLigne_Old:TcomplementLigne_obj read FComplementLigne_Old;
    Property OnStateChange:TStateChange read FOnStateChange write FOnStateChange;

    Procedure EnregistrementEcriture;
    Procedure Initialise_Ecriture(id:integer);
    Procedure RemplieTableAvecObjet(id:integer);
    Constructor Create(AOwner :TComponent);override;
    Destructor Destroy;override;
    function Division:Tecriture;
    Procedure ModifierTVASurMontant;
    Function MontantDisponible:TTotaux;
    Procedure AffichageDuComplementLigne;
    Procedure AffichageAideMontantTVA;
    Procedure gestionDernierIDEcriture;
    Function MontantRestantTVA(MontantCourant:currency):currency;
    Procedure RemplissageListeSurEcriture(var ListeBox:TlistBox);
    function GestionDesQuantites(ValeurExistante:string;PieceModifiable:Boolean):String;
    procedure ModificationInterface;
    Procedure AffichageAideCompte(Aide:boolean;var CompteSaisie:string);
    Procedure ChangementEtat(EtatSaisie:TdatasetState);
    Procedure InitChampSurChangementCompte;
  end;


//// Objet Liste_Ecriture /////////////////
////////////////////
  TListe_Ecritures = class(TComponent)
//Gère une liste d'écritures.
//Ajout, Cohérence dans globalité et enregistrement.

  private
    { Déclarations privées }
     FListeEcriture : Tlist;


  Public
    { Déclarations publiques }
 	  Constructor Create (Owner:TComponent);override;
   	Destructor Destroy;override;

    Property ListeEcriture : Tlist read FListeEcriture write FListeEcriture ;
     // nettoie la liste (suppression des objets existants);
  	Procedure initialisationListeEcriture;
       // création et initialisation d'une nouvelle écriture//.
       //boucle sur toutes les écritures de la liste et déclenche leur enregistrement.
    Procedure AjoutEcriture(NewEcriture:TEcriture);
     //crée l'objet Liste, initialise la liste.
    function EnregistrementListeEcriture:Texceptlgr;
       // Vérifie que la somme des débits ou credits soit égale au débit ou credit Old
       // Vérifie que la somme des complémentLignes soit égale au complementLigne Old
    Function InteractionListeEcriture : TexceptLgr;
    function CorrespondanceRangListe(RangInterface:integer):integer;
    Procedure SuppressionEcriture(items:integer);
    Procedure DispatcherTVA;
    Function TotauxEcriture:TTotaux;

  end;

////  FIN Objet Liste_Ecriture /////////////////
////////////////////



  TDMModifEcriture = class(TDataModule)
    TaEcriture_Modif: TTable;
    QuEcriture_Modif: TQuery;
    DaEcriture_Modif: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

  public
    { Déclarations publiques }
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
  end;


    TInfosDMModifEcriture=record
      Compte:string;
      Tiers:string;
      Libelle:string;
      Date:Tdatetime;
      Qt1:currency;
      Qt2:currency;
      Debit:currency;
      Credit:currency;
      ComplementLigne:TcomplementLigne_obj;
      retour:boolean;
    end;

var
  DMModifEcriture: TDMModifEcriture;
  DMListeEcriture:TListe_Ecritures;
  
  Function InitialiseDMModifEcriture(ParamDMModifEcriture:TParamDMModifEcriture):TInfosDMModifEcriture;
  Procedure InitialiseTInfosDMModifEcriture(var InfosDMModifEcriture:TInfosDMModifEcriture);


implementation

uses DMPlanCpt, DMPointages2, E2_AideCompte, DMRecherche_Obj, DMImmos,
  DMTTVA, DMPiece, DMAnalytique, DMTier,DMTVA;
{$R *.DFM}


Function InitialiseDMModifEcriture(ParamDMModifEcriture:TParamDMModifEcriture):TInfosDMModifEcriture;
var
NewEcriture:Tecriture;
Begin
 InitialiseTInfosDMModifEcriture(result);
 if DMModifEcriture=nil then DMModifEcriture:=TDMModifEcriture.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 if AideCompte=nil then AideCompte:=TAideCompte.Create(Application.MainForm);
 DMModifEcriture.OnGEstInterfaceEvent := ParamDMModifEcriture.GEstInterfaceEvent;
 NewEcriture:=TEcriture.Create(DMModifEcriture);
 NewEcriture.fetat:=dsOldValue;
 NewEcriture.OnStateChange := ParamDMModifEcriture.ModifEcritureDataStateChange;
 NewEcriture.Initialise_Ecriture(ParamDMModifEcriture.EcritureEnCours);
 NewEcriture.OnModifPropriete:=ParamDMModifEcriture.ModifInterfaceObjet;//on y passe la procedure de raffraîchissement
 //de la grille suite à modif d'une propriété en interne

 DMListeEcriture.AjoutEcriture(NewEcriture);
 result.retour:=true;
End;


//crée l'objet écriture.
Constructor TEcriture.Create(AOwner :TComponent);
begin
inherited create(AOwner);
Initialise_complementLigne_Obj(FComplementLigne);
end;

//détruit l'objet écriture.
Destructor TEcriture.Destroy;
begin
inherited destroy;
end;


function TEcriture.Division:Tecriture;
//créer une nouvelle ecriture à partir de celle en cours.
begin
try//except
Initialise_ExceptLGR(FexceptLgr);
//on ajoute un objet Ecriture
if not(ord(FtypeLigne) in [72,104])then   raise ExceptLGR.Create('Cette écriture n''est pas divisable',0,true,mtError,FexceptLgr);
if ((MF_Debit in ChampsNotModifiable)and(MF_Credit in ChampsNotModifiable)) then raise ExceptLGR.Create('Cette écriture n''est pas divisable',0,true,mtError,FexceptLgr);
result:=TEcriture.Create(DMModifEcriture);
//initialisation à partir de celle en cours

     Result.OnModifPropriete:=FOnModifPropriete;
     result.OnStateChange:=FOnStateChange;
     Result.FLienAvecListe:=FLienAvecListe;
     Result.ChampsNotModifiable:=FChampsNotModifiable;
     result.FEtat:=dsInsert;
     DeFiltrageDataSet(DMRech.TaEcritureRech);
     result.FID_Ecriture:=result.NewIDEcriture(dmrech.TaEcritureRech,'id',inttostr(FID_Ecriture div 10000000));
     DeFiltrageDataSet(DMRech.TaEcritureRech);
     result.gestionDernierIDEcriture;
     result.FID_Piece:=FID_Piece;
     result.FReference:=FReference;
     result.FCompte_Old:=FCompte_Old;
     result.FTiers_Old:=FTiers_Old;
     result.FLibelle_Old:=FLibelle_Old;
     result.FDate_Old:=FDate_Old;
     Result.FComptePiece:=FComptePiece;
     result.FUnite1:=FUnite1;
     result.FUnite2:=FUnite2;
     result.FPieceAutoGeneree:=FPieceAutoGeneree;
//à essayer
     result.FQt1_Old:=FQt1_Old;
     result.FQt2_Old:=FQt2_Old;
     result.FDebit_Old:=FDebit_Old;
     result.FCredit_Old:=FCredit_Old;
//fin à essayer
     result.FComplementLigne_Old.MontantTva:=FComplementLigne_Old.MontantTva;
     result.FComplementLigne_Old.CodeTvaCompl:=FComplementLigne_Old.CodeTvaCompl;
     result.FComplementLigne_Old.TvaDate:=FComplementLigne_Old.TvaDate;
     result.FComplementLigne_Old.TvaTaux:=FComplementLigne_Old.TvaTaux;
     result.FComplementLigne_Old.TvaType:=FComplementLigne_Old.TvaType;

//     result.FComplementLigne_Old.MontantTva:=0;
     result.FSensDebit_old:=FSensDebit_old;
     result.FtypeLigne:=FtypeLigne;
     result.FRapprochement:=FRapprochement;
     DeFiltrageDataSet(DMRech.TaEcritureRech);
     Result.FID_Ligne:=result.NewID_Ligne(dmrech.TaEcritureRech,'id_ligne');
     DeFiltrageDataSet(DMRech.TaEcritureRech);
     result.FJournal:=FJournal;
     result.FDatePiece:=FDatePiece;
     Result.FEcritureDivisee:=FID_Ecriture;

     Result.FPointage:=FPointage;
     result.FDeclaree:=FDeclaree;
     result.FImmobilise:=FImmobilise;
     result.FSupprimable:=FSupprimable;
     result.FModifiable:=FModifiable;
     result.FSupprimable:=FSupprimable;

    Result.FID_Devise:=FID_Devise;
    Result.FQui:=e.User;
    Result.FQuand:=now;
    Result.FTable_Gen:=FTable_Gen;
    Result.FChamp_Gen:=FChamp_Gen;
    Result.FVal_Champ_Gen:=FVal_Champ_Gen;

    Result.FValidation:=FValidation;
    Result.FNum_Cheque:=FNum_Cheque;
    Result.FID_Gestco:=0;
    Result.FCode_Gestco:='';
    Result.FID_Gestanal:=0;
    Result.FCode_Gestanal:='';

     result.FComptePlan:=FComptePlan;
     result.FCompteAffiche:=FCompteAffiche;
     result.FTiers:=FTiers;
     result.FLibelle:=FLibelle;
     result.FDate:=FDate;
     if (MF_ComplementLigne in FChampsNotModifiable) then
       begin
           result.FComplementLigne.MontantTva:=0;
           result.FComplementLigne.CodeTvaCompl:='';
           result.FComplementLigne.TvaDate:='';
           result.FComplementLigne.TvaTaux:=0;
           result.FComplementLigne.TvaType:='';
       end
     else
       begin
           result.FComplementLigne.CodeTvaCompl:=FComplementLigne.CodeTvaCompl;
           result.FComplementLigne.TvaDate:=FComplementLigne.TvaDate;
           result.FComplementLigne.TvaTaux:=0;
           result.FComplementLigne.TvaType:=FComplementLigne.TvaType;
           result.FComplementLigne.MontantTva:=0;
       end;

     result.FQt1:=0;
     result.FQt2:=0;
     result.Debit:=result.MontantDisponible.Debit;
     result.Credit:=result.MontantDisponible.Credit;
     if ((result.Debit=0) and (result.Credit=0)) then
       raise ExceptLGR.Create('Le montant total de l''écriture initiale est déjà réparti',0,true,mtError,FexceptLgr);
except
  raise;
end;//fin except
end;



Procedure TEcriture.Initialise_Ecriture(id:integer);
var
InfosPiece:TInfosPiece;
InfosPlancpt:TInfosPlancpt;
Begin
if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
if DMModifEcriture.TaEcriture_Modif.Locate('id',id,[]) then
  Begin                                            //   TaEcriture_Modif.findfield('').As
     FEtat:=dsBrowse;
     FID_Ecriture:=DMModifEcriture.TaEcriture_Modif.findfield('id').AsInteger;
     FID_Piece:=DMModifEcriture.TaEcriture_Modif.findfield('id_Piece').AsInteger;
     DeFiltrageDataSet(dmrech.TaPieceRech);
     InfosPiece:=Infos_TInfosPiece(dmrech.TaPieceRech,'id',[FID_Piece]);
     
     FReference:=InfosPiece.Reference;
     FJournal:=InfosPiece.Journal;
     FDatePiece:=InfosPiece.Date;
     FComptePiece:=InfosPiece.Compte;
     FEcritureDivisee:=-1;
     FPieceAutoGeneree:=not empty(InfosPiece.Table_Gen);
     FCompte_Old:=DMModifEcriture.TaEcriture_Modif.findfield('compte').Asstring;
     FTiers_Old:=DMModifEcriture.TaEcriture_Modif.findfield('Tiers').Asstring;
     FLibelle_Old:=DMModifEcriture.TaEcriture_Modif.findfield('Libelle').Asstring;
     FDate_Old:=DMModifEcriture.TaEcriture_Modif.findfield('date').AsDateTime;
     FQt1_Old:=DMModifEcriture.TaEcriture_Modif.findfield('Qt1').AsCurrency;
     FQt2_Old:=DMModifEcriture.TaEcriture_Modif.findfield('Qt2').AsCurrency;
     FDebit_Old:=DMModifEcriture.TaEcriture_Modif.findfield('Debit').AsCurrency;
     FCredit_Old:=DMModifEcriture.TaEcriture_Modif.findfield('Credit').AsCurrency;
     FComplementLigne_Old.CodeTvaCompl:=DMModifEcriture.TaEcriture_Modif.findfield('TvaCode').AsString;
     FComplementLigne_Old.TvaDate:=DMModifEcriture.TaEcriture_Modif.findfield('TvaDate').AsString;
     FComplementLigne_Old.TvaTaux:=DMModifEcriture.TaEcriture_Modif.findfield('TvaTaux').AsCurrency;
     FComplementLigne_Old.TvaType:=DMModifEcriture.TaEcriture_Modif.findfield('TvaType').AsString;
     FComplementLigne_Old.MontantTva:=DMModifEcriture.TaEcriture_Modif.findfield('Montant_Tva').AsCurrency;
     FSensDebit_old:=FDebit_Old>0;
     FtypeLigne:=DMModifEcriture.TaEcriture_Modif.findfield('Typeligne').AsString[1];
     FRapprochement:=DMModifEcriture.TaEcriture_Modif.findfield('Rapprochement').AsString;
     FID_Ligne:=DMModifEcriture.TaEcriture_Modif.findfield('ID_Ligne').asinteger;

    FID_Devise:=DMModifEcriture.TaEcriture_Modif.findfield('ID_Devise').asinteger;
    FQui:=e.User;
    FQuand:=now;
    FTable_Gen:=DMModifEcriture.TaEcriture_Modif.findfield('Table_Gen').asstring;
    FChamp_Gen:=DMModifEcriture.TaEcriture_Modif.findfield('Champ_Gen').asstring;
    FVal_Champ_Gen:=DMModifEcriture.TaEcriture_Modif.findfield('Val_Champ_Gen').asstring;

    FValidation:=DMModifEcriture.TaEcriture_Modif.FindField('Validation').asdatetime;
    FNum_Cheque:=DMModifEcriture.TaEcriture_Modif.FindField('Num_Cheque').asstring;
    FID_Gestco:=DMModifEcriture.TaEcriture_Modif.FindField('ID_Gestco').asinteger;
    FCode_Gestco:=DMModifEcriture.TaEcriture_Modif.FindField('Code_Gestco').asstring;
    FID_Gestanal:=DMModifEcriture.TaEcriture_Modif.FindField('ID_Gestanal').asinteger;
    FCode_Gestanal:=DMModifEcriture.TaEcriture_Modif.FindField('Code_Gestanal').asstring;

     FComptePlan:=DMModifEcriture.TaEcriture_Modif.findfield('compte').Asstring;
     FTiers:=DMModifEcriture.TaEcriture_Modif.findfield('Tiers').Asstring;
     if not empty(Ftiers)then
       FCompteAffiche:=Ftiers
     else
       FCompteAffiche:=FComptePlan;
     FLibelle:=DMModifEcriture.TaEcriture_Modif.findfield('Libelle').Asstring;
     FDate:=DMModifEcriture.TaEcriture_Modif.findfield('date').AsDateTime;
     FComplementLigne.CodeTvaCompl:=DMModifEcriture.TaEcriture_Modif.findfield('TvaCode').AsString;
     FComplementLigne.TvaDate:=DMModifEcriture.TaEcriture_Modif.findfield('TvaDate').AsString;
     FComplementLigne.TvaTaux:=DMModifEcriture.TaEcriture_Modif.findfield('TvaTaux').AsCurrency;
     FComplementLigne.TvaType:=DMModifEcriture.TaEcriture_Modif.findfield('TvaType').AsString;
     FComplementLigne.MontantTva:=DMModifEcriture.TaEcriture_Modif.findfield('Montant_Tva').AsCurrency;
     FQt1:=DMModifEcriture.TaEcriture_Modif.findfield('Qt1').AsCurrency;
     FQt2:=DMModifEcriture.TaEcriture_Modif.findfield('Qt2').AsCurrency;
     FDebit:=DMModifEcriture.TaEcriture_Modif.findfield('Debit').AsCurrency;
     FCredit:=DMModifEcriture.TaEcriture_Modif.findfield('Credit').AsCurrency;


     FRowGrille:=1;

     DeFiltrageDataSet(dmrech.TaPlanCptRech);
     InfosPlancpt:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[FcomptePlan]);
     FUnite1:=InfosPlancpt.Un1;
     FUnite2:=InfosPlancpt.Un2;
     if ((empty(FUnite1))and(FQt1<>0)) then FUnite1:='ND';
     if ((empty(FUnite2))and(FQt2<>0)) then FUnite2:='ND';

     //je veux savoir si la ligne en cours de modif est pointée. Ici, je ne regarde pas si la pièce est pointée !!!
     FPointage:=DMPointage2.FiltragePointageSurEcriture(inttostr_lgr(FID_Ecriture),not FSensDebit_old,false,false,-1);

     FImmobilise:=not DataModuleImmos.VerifSiEcritureDecriteDansLesImmos(FID_Ecriture,FID_Piece).retour;
     if not FImmobilise then
       FImmobilise:=not DataModuleImmos.VerifSiEcritureDecriteDansLesCessions(FID_Ecriture,FID_Piece).retour;
     //FModifiable:=FModifiable;
     //FSupprimable:=FSupprimable;

     //initialisation par défaut
     FChampsNotModifiable:=[MF_Compte,MF_Tiers,MF_Date,MF_Qt1,MF_Qt2,MF_Debit,MF_Credit,MF_ComplementLigne];

     //suivant le cas, empêcher la modification de tel ou tel champs
     //ex : si type ligne 'X', ne pas pouvoir modifier tous les montants
     if (not FPieceAutoGeneree)or((ParamUtil.maintenance)and(ParamUtil.TypeMaintenance='MaintS')) then //si pas une pièce auto générée, alors modification possible
     case Ord(FtypeLigne) of
      {'X'}  120,88:Begin
                      FDeclaree:=DMTmTVA.VerifPieceDeclaree(FID_Piece);
                      if ((not FDeclaree)and (not FPointage.Pointee)) then
                         FChampsNotModifiable:=[MF_Qt1,MF_Qt2,MF_Debit,MF_Credit,MF_ComplementLigne]
                       else
                       if not Fdeclaree then
                         FChampsNotModifiable:=[MF_Compte,MF_Tiers,MF_Qt1,MF_Qt2,MF_Debit,MF_Credit,MF_ComplementLigne];
                    end;
      {'H'}  72,104:Begin
                      FChampsNotModifiable:=[MF_Compte,MF_Tiers,MF_Date,MF_Debit,MF_Credit,MF_ComplementLigne];
                      FDeclaree:=DMTmTVA.VerifEcritureDeclaree(FID_Ecriture);
                      if Fdeclaree then
                        Begin
                           //if not(copy(FComplementLigne_Old.CodeTvaCompl,1,1)[1] in ['V','v','N','n','E','e','L','l']) then
                         if DM_C_ListeCodeTvaNonModifiableSiDeclare.IndexOf(uppercase(copy(FComplementLigne_Old.CodeTvaCompl,1,1)))=-1 then
                            FChampsNotModifiable:=[MF_Date,MF_ComplementLigne]
                          else
                            FChampsNotModifiable:=[MF_Date,MF_Debit,MF_Credit,MF_ComplementLigne]
                        end
                      else
                        if Fimmobilise then
                          FChampsNotModifiable:=[MF_Compte,MF_Tiers,MF_Date,MF_Debit,MF_Credit,MF_ComplementLigne]
                      else
                        if not FPointage.Pointee then
                           FChampsNotModifiable:=[MF_Date]
                    end;
      {'T'}  84,116:Begin
                    end;
     end;//fin case
    if empty(FUnite1)then FChampsNotModifiable:=FChampsNotModifiable+[MF_Qt1]
    else FChampsNotModifiable:=FChampsNotModifiable-[MF_Qt1];
    if empty(FUnite2) then FChampsNotModifiable:=FChampsNotModifiable+[MF_Qt2]
    else FChampsNotModifiable:=FChampsNotModifiable-[MF_Qt2];
  end;
end;


Function TEcriture.LitCompteAffiche:String;
Begin
if not(Fetat in [dsInactive]) then
  begin
    result:=FcompteAffiche;
  end
else
  result:=Fcompte_old;
end;

Procedure TEcriture.EcritCompteAffiche(CompteSaisie:String);
var
Infosplancpt:TInfosplancpt;
compteOld:string;
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
      if compteSaisie<>FCompteAffiche then
        begin//si modification
            if not(Fetat in [dsInactive]) then
              begin
                if not (MF_Compte in FChampsNotModifiable) then
                  Begin
                    CtrlCompteAffiche(compteSaisie);
                    FcompteAffiche:=CompteSaisie;
                  end
              else
                 raise ExceptLGR.Create('Le compte n''est pas modifiable',0,True,mtError,FexceptLgr);
              end
            else
              raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       InitChampSurChangementCompte;
       ChangementEtat(dsedit);
       ModificationInterface;
       end;
  except
    raise;
  end;
end;


Function TEcriture.LitComptePlan:String;
Begin
if not(Fetat in [dsInactive]) then
  begin
    result:=FcomptePlan;
  end
else
  result:=Fcompte_old;
end;

Procedure TEcriture.EcritComptePlan(CompteSaisie:String);
var
Infosplancpt:TInfosplancpt;
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
//      if compteSaisie<>FComptePlan then
        begin//si modification
            if not(Fetat in [dsInactive]) then
              begin
                if not (MF_Compte in FChampsNotModifiable) then
                  Begin
                    //contrôler valeur,
                    //si ok, remplir avec
                    CtrlCompte(compteSaisie);
                    RecuperationComplementLigne(compteSaisie);
                    DeFiltrageDataSet(dmrech.TaPlanCptRech);
                    Infosplancpt:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'compte',[CompteSaisie]);
//                    if ((empty(Tiers))and(Infosplancpt.Collectif))then raise ExceptLGR.Create('Ce compte est collectif et n''est pas utilisable dans ce contexte',0,True,mtError,FexceptLgr);
                    FUnite1:=Infosplancpt.Un1;
                    FUnite2:=Infosplancpt.Un2;
                    if ((empty(FUnite1))and(FQt1<>0)) then FUnite1:='ND';
                    if ((empty(FUnite2))and(FQt2<>0)) then FUnite2:='ND';

                    if empty(FUnite1) then FChampsNotModifiable:=FChampsNotModifiable+[MF_Qt1]
                    else FChampsNotModifiable:=FChampsNotModifiable-[MF_Qt1];
                    if empty(FUnite2) then FChampsNotModifiable:=FChampsNotModifiable+[MF_Qt2]
                    else FChampsNotModifiable:=FChampsNotModifiable-[MF_Qt2];
                    FcomptePlan:=compteSaisie;
                    Qt1:=strtocurr_lgr(GestionDesQuantites(currtostr_lgr(Qt1),Not(MF_Qt1 in FChampsNotModifiable)));
                    Qt2:=strtocurr_lgr(GestionDesQuantites(currtostr_lgr(Qt2),Not(MF_Qt2 in FChampsNotModifiable)));
                  end
              else
                 raise ExceptLGR.Create('Le compte n''est pas modifiable',0,True,mtError,FexceptLgr);
              end
            else
              raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       ChangementEtat(dsedit);
       ModificationInterface;
       end;
  except
    raise;
  end;
end;


Function TEcriture.LitTiers:String;
Begin
if not(Fetat in [dsInactive]) then
  begin
    Result:=FTiers;
  end
else
  Result:=FTiers_old;
end;
Procedure TEcriture.EcritTiers(TiersSaisie:String);
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
//      if TiersSaisie<>FTiers then
        begin//si modification
            if not(Fetat in [dsInactive]) then
              begin
                if not (MF_Tiers in ChampsNotModifiable ) then
                  Begin
                    //contrôler valeur,
                    //si ok, remplir avec
                    CtrlTiers(TiersSaisie);
                    FTiers:=TiersSaisie;
                  end
              else
                 raise ExceptLGR.Create('Le Tiers n''est pas modifiable',0,True,mtError,FexceptLgr);
              end
            else
              raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       ChangementEtat(dsedit);
        ModificationInterface;
        end;//fin si modification
  except
    raise;
  end;
end;


Function TEcriture.LitLibelle:String;
Begin
if not(Fetat in [dsInactive]) then
  Result:=FLibelle
else
  Result:=FLibelle_old;
end;

Procedure TEcriture.EcritLibelle(LibelleSaisie:String);
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
      if FLibelle<>LibelleSaisie then
        begin//si modification
            if not(Fetat in [dsInactive]) then
              begin
                    //contrôler valeur,
                    //si ok, remplir avec
                    CtrlLibelle(LibelleSaisie);
                    FLibelle:=LibelleSaisie;
              end
            else
              raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       ChangementEtat(dsedit);
       ModificationInterface;
       end;
  except
    raise;
  end;
end;

Function TEcriture.LitDate:Tdatetime;
Begin
if not(Fetat in [dsInactive]) then
  Result:=FDate
else
  Result:=FDate_old;
end;
Procedure TEcriture.Ecritdate(dateSaisie:Tdatetime);
begin
  try
      Initialise_ExceptLGR(FexceptLgr);
      if dateSaisie<>Fdate then
        begin//si modification
            if not(Fetat in [dsInactive]) then
              begin
                if not (MF_Date in FChampsNotModifiable) then
                  Begin
                    //contrôler valeur,
                    //si ok, remplir avec
                    CtrlDate(dateSaisie);
                    FDate:=dateSaisie;
                  end
              else
                 raise ExceptLGR.Create('La date n''est pas modifiable',0,True,mtError,FexceptLgr);
              end
            else
              raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       ChangementEtat(dsedit);
       end;
  except
    raise;
  end;
end;

Function TEcriture.LitQt1:currency;
Begin
if not(Fetat in [dsInactive]) then
  Result:=FQt1
else
  Result:=FQt1_old;
end;
Procedure TEcriture.EcritQt1(Qt1Saisie:currency);
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
      Qt1Saisie:=strtocurr_lgr(GestionDesQuantites(currtostr_lgr(Qt1Saisie),Not(MF_Qt1 in FChampsNotModifiable)));
      if Qt1Saisie<>FQt1 then
        begin//si modification
        if not(Fetat in [dsInactive]) then
            begin
              if not (MF_Qt1 in ChampsNotModifiable ) then
                Begin
                  //contrôler valeur,
                  //si ok, remplir avec
                  CtrlQt1(Qt1Saisie);
                  FQt1:=Qt1Saisie;
                end
            else
               raise ExceptLGR.Create('La quantité 1 n''est pas modifiable',0,True,mtError,FexceptLgr);
            end
          else
            raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       ChangementEtat(dsedit);
        ModificationInterface;
        end;//fin si modification
  except
    raise;
  end;
end;

Function TEcriture.LitQt2:currency;
Begin
if not(Fetat in [dsInactive]) then
  Result:=FQt2
else
  Result:=FQt2_old;
end;
Procedure TEcriture.EcritQt2(Qt2Saisie:currency);
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
      Qt2Saisie:=strtocurr_lgr(GestionDesQuantites(currtostr_lgr(Qt2Saisie),Not(MF_Qt1 in FChampsNotModifiable)));
      if Qt2Saisie<>FQt2 then
        begin//si modification
        if not(Fetat in [dsInactive]) then
            begin
              if not (MF_Qt2 in ChampsNotModifiable ) then
                Begin
                  //contrôler valeur,
                  //si ok, remplir avec
                  CtrlQt2(Qt2Saisie);
                  FQt2:=Qt2Saisie;
                end
            else
               raise ExceptLGR.Create('La quantité 2 n''est pas modifiable',0,True,mtError,FexceptLgr);
            end
          else
            raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       ChangementEtat(dsedit);
        ModificationInterface;
        end;//fin si modification
  except
    raise;
  end;
end;

Function TEcriture.LitDebit:currency;
Begin
if not(Fetat in [dsInactive]) then
  Result:=FDebit
else
  Result:=FDebit_old;
end;


Procedure TEcriture.EcritDebit(DebitSaisie:currency);
var
complementTmp:TcomplementLigne_Obj;
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
      if DebitSaisie<>FDebit then
        begin//si modification
        if not(Fetat in [dsInactive]) then
            begin
              if not (MF_Debit in ChampsNotModifiable ) then
                Begin
                  //contrôler valeur,
                  //si ok, remplir avec
                  CtrlDebit(DebitSaisie);
                  Qt1:=strtocurr_lgr(GestionDesQuantites(currtostr_lgr(Qt1),Not(MF_Qt1 in FChampsNotModifiable)));
                  Qt2:=strtocurr_lgr(GestionDesQuantites(currtostr_lgr(Qt2),Not(MF_Qt2 in FChampsNotModifiable)));
                  FDebit:=DebitSaisie;
                  FComplementLigne.ModifUtilisateur:=false;
                end
            else
               raise ExceptLGR.Create('Le montant credit n''est pas modifiable',0,True,mtError,FexceptLgr);
            end
          else
            raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       ChangementEtat(dsedit);
       ModificationInterface;
        end;//fin si modification
  except
    raise;
  end;
end;

Function TEcriture.LitCredit:currency;
Begin
if not(Fetat in [dsInactive]) then
  Result:=FCredit
else
  Result:=FCredit_old;
end;
Procedure TEcriture.EcritCredit(CreditSaisie:currency);
var
complementTmp:TcomplementLigne_Obj;
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
      if CreditSaisie<>FCredit then
        begin//si modification
        if not(Fetat in [dsInactive]) then
            begin
              if not (MF_credit in ChampsNotModifiable) then
                Begin
                  //contrôler valeur,
                  //si ok, remplir avec
                  Ctrlcredit(CreditSaisie);
                  Qt1:=strtocurr_lgr(GestionDesQuantites(currtostr_lgr(Qt1),Not(MF_Qt1 in FChampsNotModifiable)));
                  Qt2:=strtocurr_lgr(GestionDesQuantites(currtostr_lgr(Qt2),Not(MF_Qt2 in FChampsNotModifiable)));
                  Fcredit:=CreditSaisie;
                  FComplementLigne.ModifUtilisateur:=false;
                end
            else
               raise ExceptLGR.Create('Le montant crédit n''est pas modifiable',0,True,mtError,FexceptLgr);
            end
          else
            raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
       ChangementEtat(dsedit);
       ModificationInterface;
        end;//fin si modification
  except
    raise;
  end;
end;

Function TEcriture.LitComplementLigne:TComplementLigne_obj;
Begin
if not(Fetat in [dsInactive]) then
  Result:=FComplementLigne
else
  Result:=FComplementLigne_old;
end;
Procedure TEcriture.EcritComplementLigne(ComplementLigneSaisie:TComplementLigne_obj);
Begin
  try
      Initialise_ExceptLGR(FexceptLgr);
      if ((ComplementLigneSaisie.CodeTvaCompl<>FComplementLigne.CodeTvaCompl)
           or(ComplementLigneSaisie.TvaDate<>FComplementLigne.TvaDate)
           or(ComplementLigneSaisie.TvaTaux<>FComplementLigne.TvaTaux)
           or(ComplementLigneSaisie.TvaType<>FComplementLigne.TvaType)
           or(ComplementLigneSaisie.MontantTva<>FComplementLigne.MontantTva)) then
          begin //si modification
              if not(Fetat in [dsInactive]) then
                begin
                 if not (MF_ComplementLigne in ChampsNotModifiable ) then
                    Begin
                        CtrlComplementLigne(ComplementLigneSaisie);
                        ComplementLigneSaisie.TvaTaux:=Arrondi((ComplementLigneSaisie.MontantTva/abs(fdebit-fcredit))*100,2);
                        FComplementLigne:=ComplementLigneSaisie;
                    end
                else
                   raise ExceptLGR.Create('Le complément Ligne n''est pas modifiable',0,True,mtError,FexceptLgr);
                end
              else
                raise ExceptLGR.Create('l''objet n''est pas en modification',0,True,mtError,FexceptLgr);
           ChangementEtat(dsedit);
           ModificationInterface;
          end;//fin si modification
  except
     raise;
  end;
end;

Function TEcriture.LitEtat:TDataSetState;
Begin
  Result:=FEtat;
end;
Procedure TEcriture.EcritEtat(EtatSaisie:TDataSetState);
Begin
  ChangementEtat(EtatSaisie);
end;


Function TEcriture.LitChampsNotModifiable:SetChampsNotModifiable;
Begin
  result:=FChampsNotModifiable;
end;

Procedure TEcriture.EcritChampsNotModifiable(ChampsNotModifiableSaisie:SetChampsNotModifiable);
Begin
  try
//    Initialise_ExceptLGR(FexceptLgr);
//    if MF_libelle in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('le libellé n''est pas modifiable',0,true,mtError,FexceptLgr);
//    if MF_Compte in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('le compte n''est pas modifiable',0,true,mtError,FexceptLgr);
//    if MF_Tiers in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('le compte n''est pas modifiable',0,true,mtError,FexceptLgr);
//    if MF_Date in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('la date n''est pas modifiable',0,true,mtError,FexceptLgr);
//    if Mf_Qt1 in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('la qté 1 n''est pas modifiable',0,true,mtError,FexceptLgr);
//    if Mf_Qt2 in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('la qté 2 n''est pas modifiable',0,true,mtError,FexceptLgr);
//    if Mf_Debit in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('le montant débit n''est pas modifiable',0,true,mtError,FexceptLgr);
//    if Mf_Credit in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('le montant crédit n''est pas modifiable',0,true,mtError,FexceptLgr);
//    if Mf_ComplementLigne in ChampsNotModifiableSaisie then
//      raise ExceptLGR.Create('le Complément Ligne n''est pas modifiable',0,true,mtError,FexceptLgr);
    FChampsNotModifiable:=ChampsNotModifiableSaisie;
  except
    //
  end;
end;

Function TEcriture.LitRowGrille:integer;
Begin
 result:=FRowGrille;
end;


Procedure TEcriture.EcritRowGrille(RowGrilleSaisie:integer);
Begin
  FRowGrille:=RowGrilleSaisie;
end;


//Recherche si la ligne est pointée //
Function TEcriture.LitPointage:boolean;
begin
//Renvoie la valeur dans Pointage

end;

//Procedure TEcriture.EcritPointage(PointageSaisie:boolean);
//begin
//Contrôle la nouvelle valeur et si ok  l'écrit dans Pointage.
//end;


//Recherche si la ligne est déclarée //
Function TEcriture.LitDeclaree:boolean;
begin
    //Renvoie la valeur dans Declaree
end;

//Procedure TEcriture.EcritDeclaree(DeclareeSaisie:boolean);
//begin
//Contrôle la nouvelle valeur et si ok  l'écrit dans Declaree.
//end;


// Recherche si la ligne est supprimable //
Function TEcriture.LitSupprimable:boolean;
begin
    //Renvoie la valeur dans Supprimable
end;


//Procedure TEcriture.EcritSupprimable(SupprimableSaisie:boolean);
//begin
//Contrôle la nouvelle valeur et si ok  l'écrit dans Supprimable.
//end;


// Recherche si la ligne est Modifiable //
Function TEcriture.LitModifiable:boolean;
begin
    //Renvoie la valeur dans Modifiable
end;

//Procedure TEcriture.EcritModifiable(ModifiableSaisie:boolean);
//begin
//Contrôle la nouvelle valeur et si ok  l'écrit dans Modifiable.
//end;

Function TEcriture.CtrlCompte(Var CompteSaisie:string):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
      if empty(CompteSaisie) then
        raise ExceptLGR.Create('Le Compte doit être renseigné',result.NumErreur,True,mtError,Result);
      if copy(CompteSaisie,1,1)='+' then
          raise ExceptLGR.Create('Le Compte '+CompteSaisie+' n''est pas cohérent',result.NumErreur,True,mtError,Result);
      DeFiltrageDataSet(dmrech.TaPlanCptRech);
      if ((Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[CompteSaisie]).Collectif)and(empty(Ftiers))) then
          raise ExceptLGR.Create('Le Compte '+CompteSaisie+' est collectif, il est rattaché à des tiers.'+RetourChariotSimple+'Vous ne pouvez donc pas saisir directement à partir de ce compte',result.NumErreur,True,mtError,Result);
      if ((not Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[CompteSaisie]).Collectif) and (not empty(Ftiers))) then
          Ftiers:='';
  except
     raise;
  end;
end;

Function TEcriture.CtrlCompteAffiche(var CompteSaisie:string):TexceptLgr;
var
oldTiers,Oldcompte:string;
Begin
  try//except
      oldTiers:=Tiers;
      Oldcompte:=comptePlan;
      Initialise_ExceptLGR(Result);
      AffichageAideCompte(false,CompteSaisie);
      if empty(CompteSaisie) then
        raise ExceptLGR.Create('Le Compte doit être renseigné',result.NumErreur,True,mtError,Result);
      if ((compteSaisie=FComptePiece)and(FtypeLigne='H')) then
        raise ExceptLGR.Create('Le Compte d''entête n''est pas utilisable dans les lignes du corps de la pièce',result.NumErreur,True,mtError,Result);
      if copy(CompteSaisie,1,1)='+' then
        begin
          tiers:=compteSaisie;
          DeFiltrageDataSet(dmrech.TaTiersRech);
          comptePlan:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[FTiers]).Compte;
        end
      else
        begin
          tiers:='';
          comptePlan:=compteSaisie;
        end;
  except
     tiers:=oldTiers;
     comptePlan:=Oldcompte;
     raise;
  end;
end;


Function TEcriture.CtrlTiers(Var TiersSaisie:string):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
      if not empty(TiersSaisie) then
        begin
           DeFiltrageDataSet(dmrech.TaTiersRech);
           if ((TiersSaisie<>Ftiers)and(not empty(TiersSaisie))) then
             FcomptePlan:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[TiersSaisie]).Compte;
        end;
  except
     raise;
  end;
end;


Function TEcriture.CtrlLibelle(Var LibelleSaisie:string):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
      if empty(LibelleSaisie) then
        Begin
          DeFiltrageDataSet(dmrech.TaPieceRech);
          LibelleSaisie:=Infos_TInfosPiece(dmrech.TaPieceRech,'id',[FID_Piece]).Libelle;
        end
      else
         if libelleSaisie='*' then
            Begin
              if not empty(FTiers) then
                LibelleSaisie:=dmtiers.LibelleDuTiers(ftiers)
              else
                LibelleSaisie:=DMPlan.LibelleDuNumCptPCU(FComptePlan);
            end;
      if empty(LibelleSaisie) then
          raise ExceptLGR.Create('Le Libellé doit être renseigné',result.NumErreur,True,mtError,Result);
      //if
  except
     raise;
  end;
end;


Function TEcriture.CtrlDate(Var DateSaisie:Tdatetime):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
      if not datevalide(datetostr_lgr(DateSaisie)) then
        raise ExceptLGR.Create('La date doit être renseignée',result.NumErreur,True,mtError,Result);
      //if
  except
     raise;
  end;
end;


Function TEcriture.CtrlQt1(Var Qt1Saisie:Currency):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
//      if Qt1Saisie then
//        raise ExceptLGR.Create('La qté 1 doit être renseigné',result.NumErreur,True,mtError,Result);
      //if
  except
     raise;
  end;
end;


Function TEcriture.CtrlQt2(Var Qt2Saisie:Currency):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
//      if empty(Qt2Saisie) then
//        raise ExceptLGR.Create('La qté 2 doit être renseigné',result.NumErreur,True,mtError,Result);
      //if
  except
     raise;
  end;
end;


Function TEcriture.CtrlDebit(Var DebitSaisie:Currency):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
      if ((not FSensDebit_old)and(DebitSaisie>0)) then
          raise ExceptLGR.Create('Vous ne pouvez pas changer le sens de l''écriture initiale',result.NumErreur,True,mtError,Result);
      if debitSaisie>FDebit_Old then
          raise ExceptLGR.Create('Vous ne pouvez pas dépasser le montant débit de l''écriture initiale',result.NumErreur,True,mtError,Result);
  except
     raise;
  end;
end;


Function TEcriture.CtrlCredit(Var CreditSaisie:Currency):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
      if ((FSensDebit_old)and(CreditSaisie>0)) then
          raise ExceptLGR.Create('Vous ne pouvez pas changer le sens de l''écriture initiale',result.NumErreur,True,mtError,Result);
      if CreditSaisie>FCredit_Old then
          raise ExceptLGR.Create('Vous ne pouvez pas dépasser le montant Crédit de l''écriture initiale',result.NumErreur,True,mtError,Result);
  except
     raise;
  end;
end;


Function TEcriture.CtrlComplementLigne(Var ComplementLigneSaisie:TComplementLigne_obj):TexceptLgr;
Begin
  try//except
      Initialise_ExceptLGR(Result);
      if ComplementLigneSaisie.CodeTvaCompl <> FComplementLigne_old.CodeTvaCompl then
          raise ExceptLGR.Create('Le Code Tva du Complément ligne ne correspond pas à celui de l''écriture initiale',result.NumErreur,True,mtError,Result);
      if ((ComplementLigneSaisie.TvaDate <> FComplementLigne_old.TvaDate)and(FDeclaree=true)) then
          raise ExceptLGR.Create('La Date de Tva du Complément ligne ne correspond pas à celle de l''écriture initiale',result.NumErreur,True,mtError,Result);
      if ((ComplementLigneSaisie.TvaTaux <> FComplementLigne.TvaTaux)and(FDeclaree=true)) then
          raise ExceptLGR.Create('Le Taux de Tva du Complément ligne ne correspond pas à celui de l''écriture initiale',result.NumErreur,True,mtError,Result);
      if ((ComplementLigneSaisie.TvaType <> FComplementLigne.TvaType)and(FDeclaree=true)) then
          raise ExceptLGR.Create('Le Type Tva du Complément ligne ne correspond pas à celui de l''écriture initiale',result.NumErreur,True,mtError,Result);
      if ComplementLigneSaisie.MontantTva > FComplementLigne_old.MontantTva then
          raise ExceptLGR.Create('Le Montant de Tva du Complément ligne est supérieur à celui de l''écriture initiale',result.NumErreur,True,mtError,Result);
  except
     raise;
  end;
end;


Procedure TEcriture.EnregistrementEcriture;
Begin
  try//except
  if not(FEtat in [dsinsert,dsedit]) then   raise ExceptLGR.Create('L''Ecriture n''est pas en modification',0,true,mtError);
  TableGereStartTransaction(DMModifEcriture.TaEcriture_Modif);
   if ((Fdebit<> 0) or (Fcredit <> 0)) then
     begin
      Initialise_ExceptLGR(FExceptlgr);
      case RetourneTypeEnregistement of
         1:Begin// simple enregistrement
             RemplieTableAvecObjet(FID_Ecriture);
           end;
         2:begin//avec MAJ Balance
             RemplieTableAvecObjet(FID_Ecriture);
             DMModifEcriture.TaEcriture_Modif.AfterPost:=TaEcriture_ModifAfterPost;
           end;
         3:begin//avec MAJ Balance et gestion des restes et pointages le cas échéant
             RemplieTableAvecObjet(FID_Ecriture);
             DMModifEcriture.TaEcriture_Modif.AfterPost:=TaEcriture_ModifAfterPost;
             //rajouter la gestion des restes
           end;
      end;//fin du case type enregistrement
      TableGerePost(DMModifEcriture.TaEcriture_Modif);
     end;
  except
     TableGereRollBack(DMModifEcriture.TaEcriture_Modif);
     TableGereRollBack(DMBalance.TaBalance);
     raise;
  end;
end;


Function TEcriture.RetourneTypeEnregistement:integer;
begin
result:=0;
  if ((FComptePlan<>FCompte_Old)or(FTiers<>FTiers_Old)) then
     result:=3
   else
     if ((FQt1<>FQt1_Old)or(FDebit<>FDebit_Old)or(Fcredit<>Fcredit_Old)or(FQt2<>FQt2_Old)
            or(FComplementLigne.CodeTvaCompl<>FComplementLigne_Old.CodeTvaCompl)
            or(FComplementLigne.TvaType<>FComplementLigne_Old.TvaType)
            or(FComplementLigne.TvaDate<>FComplementLigne_Old.TvaDate)
            or(FComplementLigne.TvaTaux<>FComplementLigne_Old.TvaTaux)
            or(FComplementLigne.MontantTva<>FComplementLigne_Old.MontantTva)) then
       result:=2
     else
       if FLibelle<>FLibelle_Old then
         result:=1
end;


procedure TEcriture.TaEcriture_ModifAfterPost(DataSet: TDataSet);
var
creationReste:TInfosCreationReste;
infosTvaCode:TInfosTvaCode;
begin
    try
    Initialise_ExceptLGR(fexceptLgr,nil);
    TableGereStartTransaction(DMBalance.TaBalance);
    ChoixSensEtMontant;
    if ((date<e.DatExoDebut)and(e.AccesOuverture)) then
      Begin//si vraiment pièce année antérieure
        //je passe en suppression sur les old
        if fetat in [dsedit] then
          begin
          if ((not(copy(Fcompte_old,1,1)='6'))and (((not empty(FTiers_old))or (DMPlan.CptEstPointable(Fcompte_old)))) and (not(copy(Fcompte_old,1,1)='7')))then
            DMBalance.MAJBalance_AvecQuantite( true,FQteEcriture1,FQteEcriture2,FDebCredEcriture,Fcompte_old,Fcompte_old,FQt1,FQt2,FQt1_Old,FQt2_Old,FmontantEcriture,FmontantEcriture_Old,fetat);
          end;
        //ensuite je passe en insertion sur les nouveaux
        if ((not(copy(FcomptePlan,1,1)='6'))and (((not empty(FTiers))or (DMPlan.CptEstPointable(FcomptePlan)))) and (not(copy(FcomptePlan,1,1)='7')))then
          DMBalance.MAJBalance_AvecQuantite( false,FQteEcriture1,FQteEcriture2,FDebCredEcriture,FcomptePlan,FcomptePlan,FQt1,FQt2,FQt1_Old,FQt2_Old,FmontantEcriture,FmontantEcriture_Old,dsinsert);
        if FtypeLigne in ['H'] then
          Begin //si typeligne H
            //gérer ancien complément ligne si rempli
             if ((not empty(FComplementLigne_Old.CodeTvaCompl))and(fetat in [dsedit])) then
               Begin
                  if ((FComplementLigne_Old.TvaType='E')or(((FComplementLigne_Old.TvaType='D')and(strtodate_lgr(FComplementLigne_Old.TvaDate)>=e.PremiereDateDeclaration))))then
                    Begin
                       DeFiltrageDataSet(dmrech.TaTvaCodeRech);
                       infosTvaCode:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'tvaCode',[fcomplementligne_old.codetvacompl]);
                       DMBalance.MAJBalance_AvecQuantite( true,FQteEcriture1,FQteEcriture2,FDebCredEcriture,infosTvaCode.Compte,infosTvaCode.Compte,0,0,0,0,FComplementLigne_Old.MontantTva,FComplementLigne_Old.MontantTva,fetat);
                    end
                  else
                    DMTmTVA.GestionDeclarationAvantOuverture(true,FID_Ecriture,FID_Piece,E.PremiereDateDeclaration-1);
               end;
            //gérer nouveau complément ligne si rempli
             if not empty(FComplementLigne.CodeTvaCompl) then
               Begin
                  if ((FComplementLigne.TvaType='E')or(((FComplementLigne.TvaType='D')and(strtodate_lgr(FComplementLigne.TvaDate)>=e.PremiereDateDeclaration))))then
                    Begin
                       DeFiltrageDataSet(dmrech.TaTvaCodeRech);
                       infosTvaCode:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'tvaCode',[FComplementLigne.codetvacompl]);
                       DMBalance.MAJBalance_AvecQuantite( false,FQteEcriture1,FQteEcriture2,FDebCredEcriture,infosTvaCode.Compte,infosTvaCode.Compte,0,0,0,0,FComplementLigne.MontantTva,FComplementLigne.MontantTva,dsinsert);
                    end
                  else
                    DMTmTVA.GestionDeclarationAvantOuverture(false,FID_Ecriture,FID_Piece,E.PremiereDateDeclaration-1);
               end;
          end;//fin si typeligne H
      End//fin si pièce année antérieure
    else
    if not(e.ExerciceCloture)then
      Begin
          DMBalance.MAJBalance_AvecQuantite( false,FQteEcriture1,FQteEcriture2,FDebCredEcriture,FcomptePlan,Fcompte_old,FQt1,FQt2,FQt1_Old,FQt2_Old,FmontantEcriture,FmontantEcriture_Old,fetat);
      end;

    if not(e.ExerciceCloture)then
    begin
       IF not empty(Tiers) THEN
           begin
              if not empty(FTiers_Old) then
                DMBalance.MAJBalanceDesTiers(false,FQteEcriture1,FDebCredEcriture,FTiers,FcomptePlan,FTiers_Old,FQt1,FQt1_Old,FmontantEcriture,FmontantEcriture_Old,fetat)
              else
                DMBalance.MAJBalanceDesTiers(false,FQteEcriture1,FDebCredEcriture,FTiers,FcomptePlan,FTiers_Old,FQt1,FQt1_Old,FmontantEcriture,FmontantEcriture_Old,dsinsert)
           end
        else
         if not empty(FTiers_Old) then
              DMBalance.MAJBalanceDesTiers(true,FQteEcriture1,FDebCredEcriture,FTiers_Old,FcomptePlan,FTiers_Old,FQt1,FQt1_Old,FmontantEcriture,FmontantEcriture_Old,fetat);

    end;
   if FCompteAffiche<>FCompte_Old then
      Begin
         if not GestionSuppressionRelation_Ecriture_Atelier(FID_Ecriture,0) then
           raise ExceptLGR.Create('Erreur de mise à jour de l''analytique',FexceptLgr.NumErreur,false,mtError,FexceptLgr);
      end;
   if (dataset is ttable) then
      (dataset as ttable).FlushBuffers;
   if ((not empty(FTiers_Old)) or (DMPlan.CptEstPointable(FCompte_Old)))then
      DMPointage2.SupprimeResteSurIDEcriture(fid_ecriture);
   if ((not empty(FTiers))or(DMPlan.CptEstPointable(FcomptePlan)))then
       begin
          //if ((FTiers<>FTiers_Old)or(Fcompte<>FCompte_Old)) then
             begin
                 initialise_InfosCreationReste(creationReste);
                 creationReste.DatePiece:=FDatePiece;
                 creationReste.IDEcriture:=FID_Ecriture;
                 creationReste.IDPiece:=FID_Piece;
                 creationReste.Libelle:=FLibelle;
                 creationReste.MontantCredit:=Fcredit;
                 creationReste.MontantDebit:=fdebit;
                 creationReste.Reference:=freference;
                 if creationReste.MontantDebit <>0 then
                    begin
                      creationReste.reste.Reste:=creationReste.MontantDebit-FPointage.MontantPointage;
                      creationReste.reste.sensReste:=false;
                    end
                 else
                    begin
                      creationReste.reste.Reste:=creationReste.MontantCredit-FPointage.MontantPointage;
                      creationReste.reste.sensReste:=true;
                    end;
                 if not empty(FTiers)then
                   creationReste.Tiers:=Ftiers
                 else
                   creationReste.Tiers:=FcomptePlan;
                 DMPointage2.GestionDuReste(creationReste,false);
             end;
       end;
    except
    showmessage('Erreur de mise à jour');
    TableGereRollBack(dataset);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
    end;
end;

procedure TEcriture.ChoixSensEtMontant;
var
sens:boolean;
begin
FDebCredEcriture:='';
FmontantEcriture:=0;
FQteEcriture1:='';
FQteEcriture2:='';
if ((date<e.DatExoDebut)and(e.AccesOuverture)) then
     Begin  //si pièce année antérieure
       if FSensDebit_old then
           begin
           FDebCredEcriture:='Debit_Report';
           FQteEcriture1:='Qt1_Report';
           FQteEcriture2:='Qt2_Report';
           FmontantEcriture:=FDebit;
           FmontantEcriture_Old:=FDebit_Old;
           end
       else
            begin
            FDebCredEcriture:='Credit_Report';
            FQteEcriture1:='Qt1_Report';
            FQteEcriture2:='Qt2_Report';
            FmontantEcriture:= FCredit;
            FmontantEcriture_Old:=FCredit_Old;
            end;
     End//fin si pièce année antérieure
  else
     Begin
       if FSensDebit_old then
           begin
           FDebCredEcriture:='Debit_Base';
           FQteEcriture1:='Qt1_Base';
           FQteEcriture2:='Qt2_Base';
           FmontantEcriture:=FDebit;
           FmontantEcriture_Old:=FDebit_Old;
           end
       else
            begin
            FDebCredEcriture:='Credit_Base';
            FQteEcriture1:='Qt1_Base';
            FQteEcriture2:='Qt2_Base';
            FmontantEcriture:= FCredit;
            FmontantEcriture_Old:=FCredit_Old;
            end;
     End;
end;

Procedure TEcriture.RemplieTableAvecObjet(id:integer);
begin
try
Initialise_ExceptLGR(FexceptLgr);
if Fetat=dsedit then
begin
if not DMModifEcriture.TaEcriture_Modif.Locate('id',id,[])then
  raise ExceptLGR.Create('L''écriture n''a pas pu être récupérée',FexceptLgr.NumErreur,true,mtError,FexceptLgr);
TableGereEdit(DMModifEcriture.TaEcriture_Modif);
end
else
TableGereInsert(DMModifEcriture.TaEcriture_Modif);
DMModifEcriture.TaEcriture_Modif.FindField('Libelle').asstring:=Libelle;
DMModifEcriture.TaEcriture_Modif.FindField('Compte').asstring:=comptePlan;
DMModifEcriture.TaEcriture_Modif.FindField('Tiers').asstring:=Tiers;
DMModifEcriture.TaEcriture_Modif.FindField('Qt1').asfloat:=Qt1;
DMModifEcriture.TaEcriture_Modif.FindField('Qt2').asfloat:=Qt2;
DMModifEcriture.TaEcriture_Modif.FindField('DebitSaisie').ascurrency:=Debit;
DMModifEcriture.TaEcriture_Modif.FindField('CreditSaisie').ascurrency:=Credit;
DMModifEcriture.TaEcriture_Modif.FindField('Debit').ascurrency:=Debit;
DMModifEcriture.TaEcriture_Modif.FindField('Credit').ascurrency:=Credit;
DMModifEcriture.TaEcriture_Modif.FindField('Qui').asstring:=FQui;
DMModifEcriture.TaEcriture_Modif.FindField('Quand').asdateTime:=FQuand;
DMModifEcriture.TaEcriture_Modif.FindField('Table_Gen').asstring:=FTable_Gen;
DMModifEcriture.TaEcriture_Modif.FindField('Champ_Gen').asstring:='Declaree : '+BoolToStr(fdeclaree)+'; Pointée : '+BoolToStr(FPointage.Pointee)+'; Immo : '+BoolToStr(FImmobilise);
DMModifEcriture.TaEcriture_Modif.FindField('Val_Champ_Gen').asstring:='Modification d''écriture, type enreg : '+inttostr_lgr(RetourneTypeEnregistement);
DMModifEcriture.TaEcriture_Modif.FindField('Validation').asdatetime:=FValidation;
DMModifEcriture.TaEcriture_Modif.FindField('Num_Cheque').asstring:=FNum_Cheque;
DMModifEcriture.TaEcriture_Modif.FindField('ID_Gestco').asinteger:=FID_Gestco;
DMModifEcriture.TaEcriture_Modif.FindField('Code_Gestco').asstring:=FCode_Gestco;
DMModifEcriture.TaEcriture_Modif.FindField('ID_Gestanal').asinteger:=FID_Gestanal;
DMModifEcriture.TaEcriture_Modif.FindField('Code_Gestanal').asstring:=FCode_Gestanal;
DMModifEcriture.TaEcriture_Modif.FindField('Rapprochement').asstring:=FRapprochement;

if ((ComplementLigne.MontantTva<>0)or((not empty(ComplementLigne.CodeTvaCompl))and((((copy(ComplementLigne.CodeTvaCompl,1,1)[1])in ['C','c','L','l','N','n','E','e']))))) then
  begin
      DMModifEcriture.TaEcriture_Modif.FindField('Tvacode').asstring:=ComplementLigne.CodeTvaCompl;
      DMModifEcriture.TaEcriture_Modif.FindField('Tvatype').asstring:=ComplementLigne.TvaType;
      DMModifEcriture.TaEcriture_Modif.FindField('TvaDate').asstring:=ComplementLigne.TvaDate;
      DMModifEcriture.TaEcriture_Modif.FindField('Montant_Tva').AsCurrency:=ComplementLigne.MontantTva;
      DMModifEcriture.TaEcriture_Modif.FindField('TvaTaux').AsFloat:=ComplementLigne.TvaTaux;
  end
else
  Begin
      DMModifEcriture.TaEcriture_Modif.FindField('Tvacode').asstring:='';
      DMModifEcriture.TaEcriture_Modif.FindField('Tvatype').asstring:='';
      DMModifEcriture.TaEcriture_Modif.FindField('TvaDate').asstring:='';
      DMModifEcriture.TaEcriture_Modif.FindField('Montant_Tva').AsCurrency:=0;
      DMModifEcriture.TaEcriture_Modif.FindField('TvaTaux').AsFloat:=0;
  end;
//DMModifEcriture.TaEcriture_Modif.FindField('').as:=


DMModifEcriture.TaEcriture_Modif.FindField('Date').asDatetime:=Date;
if Fetat=dsinsert then
  begin
    DMModifEcriture.TaEcriture_Modif.FindField('ID').AsInteger:=FID_Ecriture;
    DMModifEcriture.TaEcriture_Modif.FindField('ID_Piece').AsInteger:=FID_Piece;
    DMModifEcriture.TaEcriture_Modif.FindField('ID_Ligne').AsInteger:=FID_Ligne;
    DMModifEcriture.TaEcriture_Modif.FindField('TypeLigne').asstring:=FtypeLigne;
    DMModifEcriture.TaEcriture_Modif.FindField('Rapprochement').asstring:=FRapprochement;
    DMModifEcriture.TaEcriture_Modif.FindField('ID_Devise').AsInteger:=FID_Devise;
    DMModifEcriture.TaEcriture_Modif.FindField('Val_Champ_Gen').asstring:='Division de l''écriture '+inttostr_lgr(FEcritureDivisee,'0','-1');
  end;
except
  raise;
end;
end;

function TEcriture.NewIDEcriture(TableEcriture:Ttable;ChampID:string;codeExo:string):integer;
//on y passe le codeExo récupéré à partir de l'écriture en cours ce qui fait que même si écriture de l'année antérieur,
//le nouvel identifiant suivra.
var
QueryID:TQuery;
begin
try
QueryID:=tquery.Create(self);
QueryID.DatabaseName:=TableEcriture.DatabaseName;
QueryID.SQL.Clear;
   QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +TableEcriture.TableName+'');
   QueryID.SQL.Add(' Where '+ChampID+' between ' +IntToStr((strtoint(codeExo)*10000000))+' and ' +IntToStr(((strtoint(codeExo)+1)*10000000))+'''');
   QueryID.Open;
   result:=0;
   if QueryID.FindField('resultat').Asinteger = 0 then
   result:=(strtoint(codeExo)*10000000)+1
   else
   result:=QueryID.FindField('resultat').Asinteger+1;
finally
QueryID.close;
QueryID.Free;
end;//fin finally
end;


function TEcriture.NewID_Ligne(TableEcriture:Ttable;ChampID:string):integer;
var
QueryID:TQuery;
begin
try
QueryID:=tquery.Create(self);
QueryID.DatabaseName:=TableEcriture.DatabaseName;
QueryID.SQL.Clear;
   QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +TableEcriture.TableName+'');
   QueryID.SQL.Add(' Where id_Piece = '+inttostr_lgr(FID_Piece));
   QueryID.Open;
   result:=QueryID.FindField('resultat').Asinteger+1;
finally
QueryID.close;
QueryID.Free;
end;//fin finally
end;


Procedure TEcriture.ModifierTVASurMontant;
var
i:integer;
Result:TcomplementLigne_Obj;
Prorata:Real;
begin
  try//except
    if not (MF_complementLigne in FChampsNotModifiable) then
      begin
          Result:=ComplementLigne;
          if not empty(ComplementLigne.CodeTvaCompl)then
            Begin
    //            Prorata:=abs(Fdebit-fcredit)/abs(FDebit_Old-Fcredit_Old);
    //            Result.MontantTva:=arrondi(FComplementLigne_old.MontantTva*Prorata,2);
                Result.MontantTva:=arrondi((abs(Fdebit-fcredit)*FComplementLigne_old.TvaTaux)/100,2);
                Result.TvaTaux:=FComplementLigne_old.TvaTaux;
            end;
          if not ComplementLigne.ModifUtilisateur and ((FDebit_Old<>FDebit)or(FCredit_Old<>FCredit)) then
            ComplementLigne:=Result;
      end;  
  except
    raise;
  end;//fin except
end;


Function TEcriture.MontantRestantTVA(MontantCourant:currency):currency;
var
i:integer;
Montant,Tva:currency;
begin
  try//except
      Result:=0;
      //vérification des montants Crédits
      Montant:=0;
      Tva:=0;
      for i:=0 to FLienAvecListe.Count-1 do
        begin
          if Tecriture(FLienAvecListe.Items[i]).fid_ecriture<>fid_ecriture then
            begin
              Montant:=Montant+abs(Tecriture(FLienAvecListe.Items[i]).fdebit-Tecriture(FLienAvecListe.Items[i]).fcredit);
              Tva:=Tva+Tecriture(FLienAvecListe.Items[i]).FComplementLigne.MontantTva;
            end;
        end;
      if Montant+MontantCourant=abs(Tecriture(FLienAvecListe.Items[0]).FDebit_Old-Tecriture(FLienAvecListe.Items[0]).FCredit_Old) then
//        if tva+FComplementLigne.MontantTva<Tecriture(FLienAvecListe.Items[0]).FComplementLigne_Old.MontantTva then
          Result:=(Tecriture(FLienAvecListe.Items[0]).FComplementLigne_Old.MontantTva-(tva+FComplementLigne.MontantTva)) ;
  except
    raise;
  end;//fin except
end;


Function TEcriture.MontantDisponible:TTotaux;
var
i:integer;
Montant:currency;
begin
  try//except
      Result.Solde:=0;

      //vérification des montants Débits
      Result.Debit:=0;
      Montant:=0;
      for i:=0 to FLienAvecListe.Count-1 do
        begin
//          if FID_Ecriture<>Tecriture(FLienAvecListe.Items[i]).FID_Ecriture then
            Montant:=Montant+Tecriture(FLienAvecListe.Items[i]).Debit;
        end;
      if Montant< Tecriture(FLienAvecListe.Items[0]).FDebit_Old then
        Result.Debit:=abs(Montant-Tecriture(FLienAvecListe.Items[0]).FDebit_Old) ;

      //vérification des montants Crédits
      Result.Credit:=0;
      Montant:=0;
      for i:=0 to FLienAvecListe.Count-1 do
        begin
//          if FID_Ecriture<>Tecriture(FLienAvecListe.Items[i]).FID_Ecriture then
            Montant:=Montant+Tecriture(FLienAvecListe.Items[i]).Credit;
        end;
      if Montant< Tecriture(FLienAvecListe.Items[0]).FCredit_Old then
        Result.Credit:=abs(Montant-Tecriture(FLienAvecListe.Items[0]).FCredit_Old) ;
     Result.Solde:=DetermineSolde(result.debit,result.credit);
  except
    raise;
  end;//fin except
end;

Procedure TEcriture.AffichageDuComplementLigne;
var
result:TComplementLigne_obj;
begin
  try//except
    if not empty(FComplementLigne.CodeTvaCompl) then
      Begin
        result:=FComplementLigne;
        ComplementLigneAffiche(FID_Ecriture,FtypeLigne,FcomptePlan,datetostr_lgr(FDatePiece),
                               result.CodeTvaCompl,result.TvaType,
                               result.TvaDate,abs(fdebit-fcredit),result.TvaTaux,result.MontantTva);
        if not result.ModifUtilisateur then
          result.ModifUtilisateur:=((result.TvaTaux<>ComplementLigne.TvaTaux)or(result.MontantTva<>ComplementLigne.MontantTva));
        ComplementLigne:=result;
      end;
  except
    raise;
  end;//fin except
end;

Procedure TEcriture.AffichageAideMontantTVA;
var
result:TcomplementLigne_obj;
Retour:TAideMontantTTC2RetFunction;
InfosTvaCode:TInfosTvaCode;
HT,TTC,Taux,MtTVA:Tedit;
begin
try//finally
  try//except
    if not empty(FComplementLigne.CodeTvaCompl) then
      Begin
        if abs(fdebit-fcredit)<>0 then
          begin
              HT:=Tedit.Create(Application.MainForm);
              TTC:=Tedit.Create(Application.MainForm);
              Taux:=Tedit.Create(Application.MainForm);
              MtTVA:=Tedit.Create(Application.MainForm);
              
              if FJournal=2 then
                begin
                  Taux.ReadOnly:=true;
                  MtTVA.ReadOnly:=true;
                end;
              DeFiltrageDataSet(dmrech.TaTvaCodeRech);
              InfosTvaCode:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'tvacode',[fcomplementligne.CodeTvaCompl]);
              if (InfosTvaCode.Taux_Inf=InfosTvaCode.Taux_Supp) then
                Retour:=AideMontantAffiche([InfosTvaCode.Taux_Inf,0,abs(fdebit-fcredit),0],2,true,[HT,TTC,Taux,MtTVA],[2,3,1,4],'',fjournal)
              else
                Retour:=AideMontantAffiche([InfosTvaCode.Taux_Inf,0,abs(fdebit-fcredit),0,InfosTvaCode.Taux_Supp,0,abs(fdebit-fcredit),0],2,true,[HT,TTC,Taux,MtTVA],[2,3,1,4],'',fjournal);
          if Retour.Retour then
            begin
                result:=FComplementLigne;
                result.ModifUtilisateur:=((result.TvaTaux<>Retour.Taux)or(result.MontantTva<>Retour.TVA));
                if FDebit_Old<>0 then
                  fdebit:=Retour.HT
                else
                  fcredit:=Retour.HT;
                result.TvaTaux:=Retour.Taux;
                result.MontantTva:=Retour.TVA;
                ComplementLigne:=result;
            end;
          end;
      end;
  except
    raise;
  end;//fin except
finally
LibereObjet(Tobject(HT));
LibereObjet(Tobject(TTC));
LibereObjet(Tobject(Taux));
LibereObjet(Tobject(MtTVA));
end;//fin finally
end;


Procedure TEcriture.gestionDernierIDEcriture;
Var
i:integer;
valeurtmp:TReference;
ValeurNew:integer;
ListeTmp:Tstringlist;
result:boolean;
begin
  try //finally
  try//except
  ListeTmp:=Tstringlist.Create;
  ValeurNew:=FID_Ecriture;
  result:=false;
  while result=false do
    begin
      if FLienAvecListe.Count<>0 then
      begin
      //récupérer tous les identifiants dans une stringlist
      for i:=0 to FLienAvecListe.Count-1 do
        Begin//si
              if ListeTmp.IndexOf(inttostr(Tecriture(FLienAvecListe.Items[i]).FID_Ecriture))=-1 then
                ListeTmp.Add(inttostr(Tecriture(FLienAvecListe.Items[i]).FID_Ecriture))
              else
                abort;
        End;//fin si
        if ListeTmp.IndexOf(inttostr(FID_Ecriture))<>-1 then
        begin
          valeurtmp:=MaxID_EcritureDansListe(ListeTmp);
          if valeurtmp.retour then
            begin
            if valeurtmp.retour then
               FID_Ecriture:= strtoint(valeurtmp.Reference);
            end;
        end
        else
        FID_Ecriture:=ValeurNew;
      end
      else
      FID_Ecriture:=ValeurNew;
      DeFiltrageDataSet(DMRech.TaEcritureRech);
      DMRech.TaEcritureRech.Refresh;
      result:=DMRech.TaEcritureRech.Locate('id',valeurNew,[])=false;
      if result=false then valeurNew:=valeurNew+1;
    end;//fin du while result=false
  except
    showmessage('Problème rencontré lors de la gestion des Identifiants d''Ecriture');
    abort;
  end;
  finally
    ListeTmp.Free;
    ListeTmp:=nil;
  end;
end;

Procedure TEcriture.RemplissageListeSurEcriture(var ListeBox:TlistBox);
var
RetourChar:string;
begin
RetourChar:='';
 ListeBox.items.add('Infos Ecriture'+RetourChar);
 ListeBox.items.add('Nom = '+Name+RetourChar);
 ListeBox.items.add('FCompte = '+FcomptePlan+RetourChar);
 ListeBox.items.add('FTiers = '+FTiers+RetourChar);
 ListeBox.items.add('FLibelle = '+FLibelle+RetourChar);
 ListeBox.items.add('FDate = '+datetostr_lgr(FDate)+RetourChar);
 ListeBox.items.add('FQt1 = '+currtostr_lgr(FQt1)+RetourChar);
 ListeBox.items.add('FQt2 = '+currtostr_lgr(FQt2)+RetourChar);
 ListeBox.items.add('FDebit = '+currtostr_lgr(FDebit)+RetourChar);
 ListeBox.items.add('FCredit = '+currtostr_lgr(FCredit)+RetourChar);
 ListeBox.items.add('FComplementLigne.CodeTvaCompl = '+FComplementLigne.CodeTvaCompl+RetourChar);
 ListeBox.items.add('FComplementLigne.TvaType = '+FComplementLigne.TvaType+RetourChar);
 ListeBox.items.add('FComplementLigne.TvaDate = '+FComplementLigne.TvaDate+RetourChar);
 ListeBox.items.add('FComplementLigne.TvaTaux = '+floattostr_lgr(FComplementLigne.TvaTaux)+RetourChar);
 ListeBox.items.add('FComplementLigne.MontantTva = '+currtostr_lgr(FComplementLigne.MontantTva)+RetourChar);

 ListeBox.items.add('FCompte_Old = '+FCompte_Old+RetourChar);
 ListeBox.items.add('FTiers_Old = '+FTiers_Old+RetourChar);
 ListeBox.items.add('FLibelle_Old = '+FLibelle_Old+RetourChar);
 ListeBox.items.add('FDate_Old = '+datetostr_lgr(FDate_Old)+RetourChar);
 ListeBox.items.add('FQt1_Old = '+currtostr_lgr(FQt1_Old)+RetourChar);
 ListeBox.items.add('FQt2_Old = '+currtostr_lgr(FQt2_Old)+RetourChar);
 ListeBox.items.add('FDebit_Old = '+currtostr_lgr(FDebit_Old)+RetourChar);
 ListeBox.items.add('FCredit_Old = '+currtostr_lgr(FCredit_Old)+RetourChar);
 ListeBox.items.add('FComplementLigne_Old.CodeTvaCompl = '+FComplementLigne_Old.CodeTvaCompl+RetourChar);
 ListeBox.items.add('FComplementLigne_Old.TvaType = '+FComplementLigne_Old.TvaType+RetourChar);
 ListeBox.items.add('FComplementLigne_Old.TvaDate = '+FComplementLigne_Old.TvaDate+RetourChar);
 ListeBox.items.add('FComplementLigne_Old.TvaTaux = '+floattostr_lgr(FComplementLigne_Old.TvaTaux)+RetourChar);
 ListeBox.items.add('FComplementLigne_Old.MontantTva = '+currtostr_lgr(FComplementLigne_Old.MontantTva)+RetourChar);
 ListeBox.items.add('FSensDebit_old = '+booltostr(FSensDebit_old)+RetourChar);
 ListeBox.items.add('FJournal = '+inttostr_lgr(FJournal)+RetourChar);

 ListeBox.items.add('Lien Avec la Liste = '+RetourChar);
 ListeBox.items.add('Count = '+inttostr_lgr(FLienAvecListe.count)+RetourChar);

 ListeBox.items.add('FRowGrille = '+inttostr(FRowGrille)+RetourChar);
 ListeBox.items.add('FID_Ecriture = '+inttostr(FID_Ecriture)+RetourChar);
 ListeBox.items.add('FID_Piece = '+inttostr(FID_Piece)+RetourChar);
 ListeBox.items.add('FEcritureDivisee = '+inttostr(FEcritureDivisee)+RetourChar);
                                   
 ListeBox.items.add('FPointage.Pointee = '+booltostr(FPointage.Pointee)+RetourChar);
 ListeBox.items.add('FPointage.MontantPointage = '+currtostr_lgr(FPointage.MontantPointage)+RetourChar);
 ListeBox.items.add('FPointage.NbLignePointee = '+inttostr_lgr(FPointage.NbLignePointee)+RetourChar);
 ListeBox.items.add('FPointageTvaSurE = '+booltostr(FPointage.TvaSurE)+RetourChar);
 ListeBox.items.add('FPointage.Lettre = '+FPointage.Lettre+RetourChar);
 ListeBox.items.add('FPointage.Ligne = '+inttostr_lgr(FPointage.Ligne)+RetourChar);

 ListeBox.items.add('FDeclaree = '+booltostr(FDeclaree)+RetourChar);
 ListeBox.items.add('FImmobilise = '+booltostr(FImmobilise)+RetourChar);
 ListeBox.items.add('FSupprimable = '+booltostr(FSupprimable)+RetourChar);
 ListeBox.items.add('FModifiable = '+booltostr(FModifiable)+RetourChar);
 ListeBox.items.add('FDatePiece = '+datetostr_lgr(FDatePiece)+RetourChar);
 ListeBox.items.add('FReference = '+FReference+RetourChar);
 ListeBox.items.add('FtypeLigne = '+FtypeLigne+RetourChar);
 ListeBox.items.add('FRapprochement = '+FRapprochement+RetourChar);
 ListeBox.items.add('FID_Ligne = '+inttostr(FID_Ligne)+RetourChar);
 ListeBox.items.add('FTable_Gen = '+FTable_Gen+RetourChar);
 ListeBox.items.add('FChamp_Gen = '+FChamp_Gen+RetourChar);
 ListeBox.items.add('FVal_Champ_Gen = '+FVal_Champ_Gen+RetourChar);
 ListeBox.items.add('FID_Devise = '+inttostr(FID_Devise)+RetourChar);

 ListeBox.items.add('FValidation = '+datetostr_lgr(FValidation)+RetourChar);
 ListeBox.items.add('FNum_Cheque = '+FNum_Cheque+RetourChar);
 ListeBox.items.add('FID_Gestco = '+inttostr(FID_Gestco)+RetourChar);
 ListeBox.items.add('FCode_Gestco = '+FCode_Gestco+RetourChar);
 ListeBox.items.add('FID_Gestanal = '+inttostr(FID_Gestanal)+RetourChar);
 ListeBox.items.add('FCode_Gestanal = '+FCode_Gestanal+RetourChar);
end;



function TEcriture.GestionDesQuantites(ValeurExistante:string;PieceModifiable:Boolean):String;
var
SensLigneConverti:integer;
SensCompte:integer;
begin
result:=ValeurExistante;
SensCompte:=C_Nul;
      SensLigneConverti:=C_Nul;
      //gérer l'affichage des quantités
      //si senscompte est indéterminé, alors récupérer les paramètres du compte
      if SensCompte=C_Nul then
        Begin
          DeFiltrageDataSet(dmrech.TaPlanCptRech);
          if Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[comptePlan]).SensCredit then
            SensCompte:=C_True
          else
            SensCompte:=C_False;
        end;

      if not FSensDebit_old then
        SensLigneConverti:=C_True
      else
        SensLigneConverti:=C_False;

      if ((SensCompte<>SensLigneConverti)and(SensLigneConverti<>C_Nul)) then
       begin
         if StrToCurr_Lgr(ValeurExistante)>0 then
           ValeurExistante:='-'+ValeurExistante;
       end
      else
        if SensLigneConverti<>C_Nul then
         begin
         if StrToCurr_Lgr(ValeurExistante)<0 then
           ValeurExistante:=str_Suppr_N_Car_AGauche(ValeurExistante,1);
         end;
      result:=ValeurExistante;
end;


procedure TEcriture.ModificationInterface;
Begin
try
//si propriétés les initialiser
 if Assigned(FOnModifPropriete) then FOnModifPropriete(FRowGrille);
except
  raise;
end;
End;


Procedure TEcriture.AffichageAideCompte(Aide:boolean;var CompteSaisie:string);
var
InplaceEdit:TInplaceEdit;
MessDerSub:boolean;
IndiceAffichage:integer;
begin
  try//finally
    try//except
    InplaceEdit:=TInplaceEdit.Create(application.MainForm);
    IndiceAffichage:=0;
    InplaceEdit.Text:=CompteSaisie;
    MessDerSub:=not aide;
    DMPieces.GestionFiltrageParamCptSurCompte(FComptePiece,fjournal);
//    if FJournal in [1,2,3,4]  then
//      begin
        //vérifier si compte ne fait pas partie d'un code tva
        //Rajouté par isa le 14/08/2007
        if FTvaCompteDeTva(comptesaisie)then raise ExceptLGR.Create('Compte de TVA lié à un code TVA, non utilisable dans ce context',0,true,mtError);
        if copy(comptesaisie,1,1)='+'then
          IndiceAffichage:=1;
        if AideCompteDansContexte(InplaceEdit.Text,InplaceEdit,['Rac1'],aide,MessDerSub,false,true,true,true,IndiceAffichage) then
         begin
           if InplaceEdit.Text<>CompteSaisie then
              begin//si compte modifie
                  CompteSaisie:=InplaceEdit.Text;
              end;
         end//fin si aide compte ok
       else
         raise ExceptLGR.Create('',0,false,mtError);
//      end;//fin si journal achat, vente ou OD
    except
       raise;
    end;
  finally
   libereObjet(Tobject(InplaceEdit));
  end;//fin finally
end;

Procedure TEcriture.ChangementEtat(EtatSaisie:TdatasetState);
begin
try
//si propriétés les initialiser
if Fetat=dsinactive then   raise ExceptLGR.Create('L''écriture n''est pas modifiable',FexceptLgr.NumErreur,true,mtError,FexceptLgr);
if ((EtatSaisie<>Fetat)and(not(fetat in [dsedit,dsinsert]))) then
    begin
       fetat:=etatSaisie;
    end;
if Assigned(FOnStateChange) then
 FOnStateChange(FEtat);
except
  FOnStateChange:=nil;
  FOnModifPropriete:=nil;
  raise;
end;
end;

Procedure TEcriture.InitChampSurChangementCompte;
begin
 FRapprochement:='';
 FID_Gestanal:=0;
 FCode_Gestanal:='';
 FID_Gestco:=0;
 Fcode_gestco:='';
 FNum_Cheque:='';
end;

//// Objet Liste_Ecriture /////////////////
////////////////////

//crée l'objet Liste, initialise la liste.
Constructor TListe_Ecritures.Create (Owner:TComponent);
begin
inherited create(Owner);
initialisationListeEcriture;
end;


Destructor TListe_Ecritures.Destroy;
var
i:integer;
begin
for i:=0 to FListeEcriture.count-1 do
  begin
      if FListeEcriture.Items[i]<>nil then
        Tecriture(FListeEcriture.Items[i]).Free;
  end;
FListeEcriture.Free;
inherited destroy;
end;


Procedure TListe_Ecritures.initialisationListeEcriture;
var
i:integer;
begin
if FListeEcriture=nil then FListeEcriture:=Tlist.create;
for i:=0 to FListeEcriture.count-1 do
  begin
      if FListeEcriture.Items[i]<>nil then
        Tecriture(FListeEcriture.Items[i]).Free;
  end;
end;


Procedure TListe_Ecritures.AjoutEcriture(NewEcriture:TEcriture);
begin
//Ajout de cette nouvelle écriture dans liste des écritures
//renseigne le lien
NewEcriture.FLienAvecListe:=ListeEcriture;
FListeEcriture.Add(NewEcriture);
NewEcriture.ChangementEtat(NewEcriture.FEtat);
end;

function TListe_Ecritures.CorrespondanceRangListe(RangInterface:integer):integer;
var
i:integer;
begin
//Renvoie le rang liste correspondant à un rang de grille ou autre rentré au préalable
//dans la propriété RowGrille.
result:=-1;
i:=0;
while ((result=-1)and(i<FListeEcriture.Count))do
  Begin
      if Tecriture(FListeEcriture.Items[i]).RowGrille=rangInterface then
        result:=i;
      inc(i);  
  end;
end;


function TListe_Ecritures.EnregistrementListeEcriture:Texceptlgr;
// Vérifie que la somme des débits ou credits soit égale au débit ou credit Old
// Vérifie que la somme des complémentLignes soit égale au complementLigne Old
var
i:integer;
begin
  try//except
    Initialise_ExceptLGR(Result);
    if InteractionListeEcriture.retour=false then
      raise ExceptLGR.Create('',result.NumErreur,false,mtError,Result);
    for i:=0 to ListeEcriture.Count-1 do
      Begin
         TEcriture(ListeEcriture.Items[i]).EnregistrementEcriture;
      end;
     TableGereCommit(DMModifEcriture.TaEcriture_Modif);
     TableGereCommit(DMBalance.TaBalance);
    for i:=0 to ListeEcriture.Count-1 do
      Begin
         TEcriture(ListeEcriture.Items[i]).OnStateChange:=nil;
         TEcriture(ListeEcriture.Items[i]).OnModifPropriete:=nil;
      end;
  except
     raise;
  end;//fin except
end;

Function TListe_Ecritures.InteractionListeEcriture : TexceptLgr;
var
i:integer;
Montant:currency;
begin
  try//except
      Initialise_ExceptLGR(Result);

      //vérification des montants Débits
      Montant:=0;
      for i:=0 to ListeEcriture.Count-1 do
        begin
          Montant:=Montant+Tecriture(ListeEcriture.Items[i]).Debit;
        end;
      if Montant<>Tecriture(ListeEcriture.Items[0]).FDebit_Old then
          raise ExceptLGR.Create('La somme des débits est différente du montant débit de l''écriture initiale.',result.NumErreur,true,mtError,Result);

      //vérification des montants Crédits
      Montant:=0;
      for i:=0 to ListeEcriture.Count-1 do
        begin
          Montant:=Montant+Tecriture(ListeEcriture.Items[i]).Credit;
        end;
      if Montant<>Tecriture(ListeEcriture.Items[0]).FCredit_Old then
          raise ExceptLGR.Create('La somme des Crédits est différente du montant Crédit de l''écriture initiale.',result.NumErreur,true,mtError,Result);

      //vérification des montants Tva
      Montant:=0;
      for i:=0 to ListeEcriture.Count-1 do
        begin
          Montant:=Montant+Tecriture(ListeEcriture.Items[i]).ComplementLigne.MontantTva;
        end;
      if Montant<>Tecriture(ListeEcriture.Items[0]).FComplementLigne_Old.MontantTva then
          raise ExceptLGR.Create('La somme des montants tva est différente du montant tva de l''écriture initiale.',result.NumErreur,true,mtError,Result);
  except
     raise;
  end;
end;


Procedure TListe_Ecritures.SuppressionEcriture(items:integer);
//Supprime une ecriture.
var
i:integer;
begin
try//except
//on vérifie qu'il reste au moins 1 écriture
if ((ListeEcriture.Count < 2)or(TEcriture(ListeEcriture.items[items]).FEcritureDivisee=-1)) then
  raise ExceptLGR.Create('Cette écriture n''est pas supprimable',0,true,mtError);
//initialisation à partir de celle en cours
TEcriture(ListeEcriture.items[items]).Free;
ListeEcriture.Delete(items);
for i:=items to ListeEcriture.Count-1 do
  TEcriture(ListeEcriture.items[i]).FRowGrille:=TEcriture(ListeEcriture.items[i]).FRowGrille-1;
except
  raise;
end;//fin except
end;

Procedure TListe_Ecritures.DispatcherTVA;
//Supprime une ecriture.
var
i:integer;
dernierRangTVA:integer;
result:TcomplementLigne_Obj;
begin
try//except
dernierRangTVA:=-1;
for i:=0 to ListeEcriture.count-1 do
  Begin
    if not empty(TEcriture(ListeEcriture.items[i]).ComplementLigne.CodeTvaCompl)then
      dernierRangTVA:=i;
  end;

for i:=0 to ListeEcriture.count-1 do
  Begin
    TEcriture(ListeEcriture.items[i]).ModifierTVASurMontant;
    if i=dernierRangTVA then
     begin
        if not (MF_complementLigne in TEcriture(ListeEcriture.items[i]).ChampsNotModifiable) then
          begin
           result:=TEcriture(ListeEcriture.items[i]).ComplementLigne;
           result.MontantTva:=result.MontantTva+TEcriture(ListeEcriture.items[i]).MontantRestantTVA(abs(TEcriture(ListeEcriture.items[i]).fdebit-TEcriture(ListeEcriture.items[i]).fcredit));
           if not TEcriture(ListeEcriture.items[i]).ComplementLigne.ModifUtilisateur then
             TEcriture(ListeEcriture.items[i]).ComplementLigne:=result;
          end;
     end;
  end;
except
  raise;
end;//fin except
end;


Function TListe_Ecritures.TotauxEcriture:TTotaux;
//récupère le montant total des écritures et de la tva aussi
var
i:integer;
begin
try//except
result.Credit:=0;
result.Debit:=0;
result.Solde:=0;
for i:=0 to ListeEcriture.count-1 do
  Begin
    result.Debit:=result.Debit+TEcriture(ListeEcriture.items[i]).Debit;
    result.Credit:=result.Credit+TEcriture(ListeEcriture.items[i]).Credit;
    result.solde:=result.solde+TEcriture(ListeEcriture.items[i]).ComplementLigne.MontantTva;
  end;
DetermineSolde(result.debit,result.credit);
except
  raise;
end;//fin except
end;

//// FIN (Objet Liste_Ecriture) /////////////////
////////////////////

procedure TDMModifEcriture.DataModuleCreate(Sender: TObject);
begin
DMListeEcriture:=TListe_Ecritures.Create(self);
OuvrirTouteTable('',TControl(self));
//TaEcriture_Modif
end;

procedure TDMModifEcriture.DataModuleDestroy(Sender: TObject);
begin
DMListeEcriture.Destroy;
FermerTouteTable('',TControl(self));
DMModifEcriture:=nil;
end;


Procedure InitialiseTInfosDMModifEcriture(var InfosDMModifEcriture:TInfosDMModifEcriture);
begin
InfosDMModifEcriture.Compte:='';
InfosDMModifEcriture.Libelle:='';
InfosDMModifEcriture.Qt1:=0;
InfosDMModifEcriture.Qt2:=0;
InfosDMModifEcriture.Debit:=0;
InfosDMModifEcriture.Credit:=0;
InfosDMModifEcriture.retour:=false;
end;


Procedure TEcriture.RecuperationComplementLigne(CompteSaisie:string;Forcer:boolean);
var
Infosplancpt:TInfosplancpt;
ComplementTmp:TComplementLigne_obj;
Begin
try//except
   DeFiltrageDataSet(dmrech_obj.TaPlanCpt_Obj);
   Infosplancpt:=Infos_TInfosplancpt(dmrech_obj.TaPlanCpt_Obj,'compte',[CompteSaisie]);
   Initialise_complementLigne_Obj(ComplementTmp);

   if ((Fjournal in [1,2])and(not empty(FComplementLigne_Old.CodeTvaCompl))) then
     begin//si journal d'achat ou de vente, gérer la tva
       ComplementTmp.CodeTvaCompl:=Infosplancpt.TvaCode;
       if ComplementTmp.CodeTvaCompl=FComplementLigne.CodeTvaCompl then
         ComplementTmp:=FComplementLigne
       else
           begin
               if not empty(ComplementTmp.CodeTvaCompl)then
                 begin
                 ComplementTmp.TvaType:=Infosplancpt.TvaType;
                 ComplementTmp.TvaTaux:=Infosplancpt.taux;
                   if empty(ComplementTmp.TvaType)then
                   ComplementTmp.TvaType:='D';/////// ????? A Revoir ?????? //////////////
                 end
               else
                 ComplementTmp.TvaType:='';

              if ComplementTmp.TvaType='D'then
                  ComplementTmp.TvaDate:=datetostr_lgr(fDate)//date par défaut
              else ComplementTmp.TvaDate:='';

                 if empty(ComplementTmp.CodeTvaCompl)then
                   begin
                   ComplementTmp.TvaTaux:=0;
                   ComplementTmp.MontantTVA:=0;
                   end
                 else
                   begin
                   DeFiltrageDataSet(dmrech_obj.TaTvaCode_Obj);
                   if ComplementTmp.TvaTaux=0 then
                     ComplementTmp.TvaTaux:=Infos_TInfosTvaCode(dmrech_obj.TaTvaCode_Obj,'TvaCode',[ComplementTmp.CodeTvaCompl]).Taux_Supp;
                   ComplementTmp.MontantTva:=arrondi(abs(fdebit-fcredit)*ComplementTmp.TvaTaux/100,2);//à remplir lors de l'enregistrement du debit ou crédit
                   end;
           end;//si code différent, récupérer les parametres de ce code
     end;//fin si journal d'achat ou de vente, gérer la tva
if not forcer then ComplementLigne:=ComplementTmp //on le passe dans la propriété pour gérer l'écrit
else
  FComplementLigne:=ComplementTmp;//sinon, on l'écrit directement sans contrôle.
except
 raise;
end;//fin except
end;



end.
