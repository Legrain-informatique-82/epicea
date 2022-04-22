{//////// le 29-04-03  Modif_Isa
j'ai modifier tout ce qui comporte la variable 'Gestionimmo' et tout ce qui se rapporte à
la suppression d'une immos ou d'une cession  à la suite d'une suppression de pièce ou d'écriture
///////}
unit E2_SaisieP_3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,  Piece, ExtCtrls, Mask, ToolEdit,PickDate, Grids,registry,
  GrGrid, DBGrids,Lib1,LibSQL,LibDates, Db, DBTables,Menus,DMPlanCpt,{DMTier,}
  AideMontant2,E2_SaisieReglement, Ecriture_Isa,LibZoneSaisie,
  RXCtrls,DMParamEnt,LibRessourceString,DMEcriture,E2_Decl_Records,
  ComCtrls, ToolWin,DMImportation,ModuleTrame, RXSplit, CurrEdit,E2_LibInfosTable,
  DMTTVA,DMConstantes,Gr_Librairie_Obj,Variants, jpeg,LibGestionParamXML, DiversProjets,
  lib_chaine,
  DMImmo_Clot,
  ActnMan,
  E2_GesPlanCpt_PM,
  DMBaseDonnee,
  DMRecherche_Obj,
  E2_Patientez,
  E2_ModifEcriture,
  DMModifEcritures,
  ActnColorMaps, Gauges,Gr_Calculatrice;
  //

type

TParamAffichPiece=record
    Affiche:Boolean;
    AffichageModal:Boolean;
    TitreForm:String;
    SousTitreForm:String;
    Reference:string;
    Anterieur:TPieceAnterieure;
end;

PIdentifiant= ^Identifiant_Obj;
PPointage=^Tpointage;


  TsaisieP_3 = class(TForm)
    Patitre: TPanel;
    PaEnTete: TPanel;
    LaJournal: TLabel;
    LaReference: TLabel;
    LaCompte: TLabel;
    LaDate: TLabel;
    LaLibelle: TLabel;
    EdPlusTiersEntete: TEdit;
    PaGrille: TPanel;
    PopupMenuPiece: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    PaLivraison: TPanel;
    EdDateLivraison: TDateEdit;
    EdDateEcheance: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Visualisation1: TMenuItem;
    ImPrimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    PopupMenuEcriture: TPopupMenu;
    MenuItem6: TMenuItem;
    MenuItem13: TMenuItem;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnImprimer: TButton;
    Supprimer2: TMenuItem;
    Aideenligne2: TMenuItem;
    Aide2: TMenuItem;
    Visualisation2: TMenuItem;
    ImPrimer2: TMenuItem;
    Calculatrice2: TMenuItem;
    Enregister2: TMenuItem;
    Insrer2: TMenuItem;
    Modifier2: TMenuItem;
    Annuler2: TMenuItem;
    Fermer2: TMenuItem;
    ComplmentLigne1: TMenuItem;
    Rglement1: TMenuItem;
    GrGrid1: TGrGrid;
    PaGrilleTete: TPanel;
    GrEnTete: TGrGrid;
    PaBas: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    N2: TMenuItem;
    HistoriquePices1: TMenuItem;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    N3: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    N4: TMenuItem;
    Prcdent2: TMenuItem;
    Suivant2: TMenuItem;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    BtnFermer: TButton;
    EnregitrerTrame1: TMenuItem;
    PiecesPointables1: TMenuItem;
    PaCumul1: TPanel;
    Panel6: TPanel;
    PaCumul2: TPanel;
    Panel7: TPanel;
    GrGrid2: TGrGrid;
    GrGrid3: TGrGrid;
    PaInfoTetePiece: TPanel;
    PaInfoCorpsPiece: TPanel;
    RxSplitter1: TRxSplitter;
    Panel8: TPanel;
    Label6: TLabel;
    LaLibCptEnCours: TLabel;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Panel9: TPanel;
    Label10: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    Label11: TLabel;
    Label12: TLabel;
    LaLibCptEntete: TLabel;
    LaCompteEnCours: TLabel;
    EdCreditSoldeCreditCptEnTete: TCurrencyEdit;
    EdCreditSoldeDebitCptEnTete: TCurrencyEdit;
    EdCreditSoldeDebitCptCorps: TCurrencyEdit;
    EdCreditSoldeCreditCptCorps: TCurrencyEdit;
    LaCptEntete: TLabel;
    EdPlusTiersCorps: TEdit;
    Rglement2: TMenuItem;
    Piecespointables2: TMenuItem;
    LaCptCorps: TLabel;
    EnregitrerlaTrame1: TMenuItem;
    Maintenance1: TMenuItem;
    PaSelectCpt: TPanel;
    RxSBClose: TRxSpeedButton;
    RxSBValider: TRxSpeedButton;
    RxSBInverse: TRxSpeedButton;
    RxSBAnnuleSel: TRxSpeedButton;
    EdRech: TEdit;
    CheckBox1: TCheckBox;
    RxSBSuppr: TRxSpeedButton;
    BtnRecherchePiece: TButton;
    XPColorMap1: TXPColorMap;
    Modiferligneecriture1: TMenuItem;
    Gauge1: TGauge;
    Infossupplmentaires2: TMenuItem;
    TiRecupInfosPointages: TTimer;
    ModifierEcriture1: TMenuItem;
    BtnAnnulerControle: TButton;
    RxSBPlanCpt: TRxSpeedButton;
    TiInfosEntete: TTimer;
    TiInfosCorps: TTimer;
    Label5: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    RxChListCpt: TListView;
    Label20: TLabel;
    LaResteAPointer: TLabel;
    procedure PaBtnResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GrGrid1ColEnter(OldColonne,NewColonne,NewRow:integer);
    procedure BtnFermerClick(Sender: TObject);
    procedure GrGrid1NewLigne(Sender: TObject;ARow:integer);
    procedure GrGrid1SupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    procedure BtnAnnulerControleClick(Sender: TObject);
    procedure AfficherEcritureSurPieceExistante(LigneCourante:integer=-1);
    procedure Aide1Click(Sender: TObject);
    procedure EtatInitial(Col:integer;Partiel:boolean;Fermeture:boolean=false);
    procedure ChangementEtatBoutonsMenu;
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnInsererGrilleClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnSupprimerGrilleClick(Sender: TObject);
    procedure gestionSuppression(ligne:integer);
    function CtrlSaisiePieceEcriture(Champ:string;FRow,Acol:integer;ColonneSuivante:integer;var Action:boolean):TErreurSaisie;
    procedure GrGrid1ColExit(OldColonne,LastRow: Integer);
    procedure GrGrid1RowValidate(Sender:TObject;var Valide:boolean;var Action:boolean;LastCol:integer);
    procedure GrGrid1RowEnter(Sender: TObject;NewRow:integer);
    function LigneBlocPrincipal(LignCourante:integer):TBlocLigne_Obj;
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    function GenereLigneTva(ParamTVA:TRecupParamTva_obj;NewLigne:integer;MontantDefaut:currency):boolean;
    procedure GrGrid1KeyDown(Sender: TObject; var Key: Word;
                Shift: TShiftState);
    function RecupParametreTVA(CodeTva:string):TRecupParamTva_obj;
    procedure FormActivate(Sender: TObject);
    function RecupParamLigne(LCourante:integer;TypeL:Char;Cpt:string;List:boolean;Tiers:string=''):TParamLigne_obj;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GrGrid1BeforeNewLigne(sender: TObject; Arow: Integer);
    procedure GrGrid1Enter(Sender: TObject);
    function RecupTypeLigneSurCompte(FLigne:integer):Char;
//    procedure EnregistrementComplet(Reglement:boolean;ListeReglement:tstringlist);
    procedure EnregistrementComplet(Reglement:boolean);
    procedure GrGrid1Exit(Sender: TObject);
    procedure GrGrid1BeforeSupprLigne(sender: TObject; Arow: Integer;
                  var NewRow: Integer);
    Function RecupNumLigneTVA(TvaCompte:string):integer;
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnImprimerGrilleClick(Sender: TObject);
    procedure GrGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure CompLigneClick(Sender: TObject);
    procedure EdDateEcheanceExit(Sender: TObject);
    procedure EdDateLivraisonExit(Sender: TObject);
    procedure EdDateLivraisonAcceptDate(Sender: TObject;
                 var ADate: TDateTime; var Action: Boolean);
    procedure Rglement1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure ImPrimer1Click(Sender: TObject);
    procedure PreparationEnregistrementComplet(Gauge:TGauge=nil);
    procedure Calculatrice1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RecupInfosComplementLigne(PourAffichage:boolean;var ComplementLigne:TComplementLigne_obj;CodeTva:string;typeL:Char;Cpt:string;HT:currency;Forcage:boolean=false);
    procedure PaGrilleResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnAnnulerGrilleClick(Sender: TObject);
    procedure BtnModifierGrilleClick(Sender: TObject);
    procedure PaGrilleEnter(Sender: TObject);
    procedure GrGrid1Change(Sender: TObject);
    procedure GrGrid1StateChange(EtatGrille: TDataSetState);
    procedure EdDateLivraisonEnter(Sender: TObject);
    procedure EdDateEcheanceEnter(Sender: TObject);
    procedure TraitementPourGerer_ModifPiece_et_TVA(Traitement:integer;var Act:boolean;Messagetmp:string;Datetmp:tdatetime;DateLivraison:boolean);
    procedure GrGrid1CellClick(Colonne, Ligne: Integer);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure EdPlusTiersEnteteKeyPress(Sender: TObject; var Key: Char);
    procedure Visualisation2Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    function VerifReferenceDansExercice(reference:string):boolean;
    procedure GrEnTeteColExit(OldColonne, LastRow: Integer);
    procedure GrEnTeteEnter(Sender: TObject);
    function CtrlSaisiePieceEnteteGrille(var EditCourant:string;Acol:integer;CtrlSuivant:twincontrol):TErreurSaisie;
    procedure GrEnTeteColEnter(OldColonne, NewColonne, NewRow: Integer);
    procedure GrEnTeteSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure GrEnTeteKeyPress(Sender: TObject; var Key: Char);
    procedure GrEnTeteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrEnTeteExit(Sender: TObject);
    procedure PaGrilleTeteResize(Sender: TObject);
    procedure PaGrilleTeteEnter(Sender: TObject);
    procedure PatitreResize(Sender: TObject);
    Procedure ChargeTrame;
    procedure EnregitrerTrame1Click(Sender: TObject);
    procedure EnregistrementTrame;
    function RecupCelluleValide(Ligne,Cellule:integer):integer;
    function RecupererParametresLignes(Rang:integer):integer;
    procedure EdDateEcheanceAcceptDate(Sender: TObject;
      var ADate: TDateTime; var Action: Boolean);
    procedure CalculSolde;
    procedure GrEnTeteChange(Sender: TObject);
    procedure GrEnTeteStateChange(EtatGrille: TDataSetState);
    function VerificationTvaAvantEnregistrement(Gauge:Tgauge=nil):boolean;
    procedure PaBasResize(Sender: TObject);
    Procedure GestionInfoEntete(Cpt:string);
    Procedure GestionInfoCorps(Cpt:string);
    procedure GrGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
//    procedure EnregistrementReglement(listeReglements:Tstringlist;fenetreAppelante:TComponent;var ListePointage:Tstringlist);
    procedure EnregistrementReglement(fenetreAppelante:TComponent;var ListePointage:Tstringlist);
    procedure Piecespointables2Click(Sender: TObject);
    procedure PiecesPointables1Click(Sender: TObject);
    procedure GestionDuPlusSurEntete(cpt,journal:string);
    procedure GestionDuPlusSurCorps(cpt:string);
    function Verif_Si_Piece_Liee_Aux_Immos(Piece:Tpiece;Ecriture:integer):TExceptLGR;
    procedure PaSelectCptResize(Sender: TObject);
    procedure RxSBCloseClick(Sender: TObject);
    procedure EdRechChange(Sender: TObject);
    procedure RxSBValiderClick(Sender: TObject);
    procedure RxSBInverseClick(Sender: TObject);
    procedure RxSBAnnuleSelClick(Sender: TObject);
    procedure RxSBSupprClick(Sender: TObject);
    procedure GestionDesUnites;
    procedure BtnRecherchePieceClick(Sender: TObject);
    procedure RxChListCptClick(Sender: TObject);
    procedure RxChListCptKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxChListCptDblClick(Sender: TObject);
    procedure Modiferligneecriture1Click(Sender: TObject);
    procedure Infossupplmentaires1Click(Sender: TObject);
    procedure TiRecupInfosPointagesTimer(Sender: TObject);
    procedure ModifierEcriture1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RxSBPlanCptClick(Sender: TObject);
    procedure TiInfosEnteteTimer(Sender: TObject);
    procedure TiInfosCorpsTimer(Sender: TObject);
    procedure RxChListCptColumnClick(Sender: TObject; Column: TListColumn);
    procedure RxChListCptCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure Calculatrice2Click(Sender: TObject);
    procedure GrGrid1RowExit(sender: TObject; LastRow: Integer);


  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    PlusAutomatiqueEntete,PlusAutomatiqueCorps:boolean;
    PlusDefautEntete,PlusDefautCorps:boolean;
    ParametreCompteEntete:TParametreCompte_Obj;
    ParametreCompteEcriture:TParametreCompte_Obj;
    lastParamLigne:TParamLigne_Obj;
    varParamLigneObj:TParamLigneObj;
    FindPieceExit:boolean;
    TitreForm, SousTitreForm : String;
    ListePointages:TStringList;
    ListeReference:TStringList;
    TabStr,TabCurr,TabDate : set of Byte;
  end;

var
  saisieP_3: TsaisieP_3;
  DernierLibelle:string;
  Liste1,Liste2:TListBool;
  JournalTmp,JournalRegistre,CodeTrameTmp:string;
  DateAchatRegistre,DateVentesRegistre,DateBanqueRegistre,DateODRegistre,
  DerniereDateSaisieRegistre:TDateTime;
  DateAchatRegistreAnt_,DateVentesRegistreAnt_,DateBanqueRegistreAnt_,DateODRegistreAnt_
  ,DerniereDateSaisieRegistreAnt_:TDateTime;
  TypeDerniereDateSaisieRegistre,TypeDerniereDateSaisieRegistreAnt_:integer;
  IDTrameRegistre:integer;
  ReferenceTmp:string;
  CompteEnteteTmp:string;
  CompteTmp,DernierCompteSaisi:string;
  LibelleTmp:string;
  DatePieceTmp,DateEcheancetmp,DateLivraisonTmp:string;
  GRCompteTmp:string;
  GRDebitTmp:string;
  GRCreditTmp:string;
  LigneCurr:integer;
  CelluleSelect:integer;
  RecIdentifiant:Pidentifiant;
  Creation:TCreation_Obj;
  Modif:TModif_Obj;
  MessDerSub:boolean;
  ContrepartieCree:boolean;
  Devise:char;
//  ListeCptExclusEnTete:TStringList;// PB
//  ListeCptExclusCorps:TStringList;// PB
  notToucheKeyDownKeyUp:boolean;
  messagetmp:boolean;
  Gestionimmos:TSuppressionImmos;
  ValiderPointageEnCours:boolean;
  

    function EtatDuDataset(Etat:TDataSetState):string;
    function EcritureDuComplementLigne(var Ligne:TComplementLigne_Obj;Valeur:array of const;
            NbMAJ:array of integer;var infosVerrouillage:TVerrouillage;GererTva,Messagetmp:boolean;TypeTva:string):boolean;
    Function AffichePieceExistante(ParamAffichPiece:TParamAffichPiece):boolean;
    function ModificationPieceExistante(Reference:string;fenetreAppelante:string):TExceptLGR;


implementation



uses DMPiece,DMJournaux,E2_AideModel,E2_Librairie_obj,E2_AideCompte,{Gr_Librairie_Obj,}
DMTva,E2_CompLigne,ObjReglement, E2_Main,DMBalances,DMClotures,E2_InfosTrame,
  //PiecesPointables,
  DMImmos, DMDiocEtatBalance, DMDiocEtatBalanceT,
  DMPointages2, E2_AffectReglement, DMRecherche, StrUtils,
  E2_ReglementSurListe, E2_DetailEcr, E2_TabVisuPiece2, E2_BalanceNew,
  E2_BalanceNewT, LibChoixCompte, InputQueryFrm_F;
{$R *.DFM}
//function CustomSortFloatProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
//begin
//result := 0;
//if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
// result :=-1;
//if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
// result :=1;
//end;
//
//function CustomSortFloatProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
//begin
//result := 0;
//if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
// result :=-1;
//if StrToFloat(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToFloat(TListItem(Item2).SubItems.Strings[ParamSort]) then
// result :=1;
//result:=-result;
//end;

function CustomSortDateProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
end;

function CustomSortDateProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
result:=-result;
end;

function CustomSortCurrProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToCurr_Lgr(QueDesChiffres(TListItem(Item1).SubItems.Strings[ParamSort])) <
   StrToCurr_Lgr(QueDesChiffres(TListItem(Item2).SubItems.Strings[ParamSort])) then
 result :=-1;
if StrToCurr_Lgr(QueDesChiffres(TListItem(Item1).SubItems.Strings[ParamSort])) >
   StrToCurr_Lgr(QueDesChiffres(TListItem(Item2).SubItems.Strings[ParamSort])) then
 result :=1;
end;

function CustomSortCurrProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToCurr_Lgr(QueDesChiffres(TListItem(Item1).SubItems.Strings[ParamSort])) <
   StrToCurr_Lgr(QueDesChiffres(TListItem(Item2).SubItems.Strings[ParamSort])) then
 result :=-1;
if StrToCurr_Lgr(QueDesChiffres(TListItem(Item1).SubItems.Strings[ParamSort])) >
   StrToCurr_Lgr(QueDesChiffres(TListItem(Item2).SubItems.Strings[ParamSort])) then
 result :=1;
result:=-result;
end;

procedure TsaisieP_3.FormCreate(Sender: TObject);
//Var
//  Registre :TRegistry;

begin
    try
       if DataModuleImmos=nil then
        DataModuleImmos:=TDataModuleImmos.Create(self);
       if DMPieces=nil then DMPieces:=TDMPieces.Create(self);
       if DMEcritures=nil then DMEcritures:=TDMEcritures.Create(self);
       if DMBalance=nil then DMBalance:=TDMBalance.Create(self);
       if AideCompte=nil then AideCompte:=TAideCompte.Create(self);

	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
 if not empty(e.DeviseSigle) then
  Devise:=e.DeviseSigle[1];
FormateMonnaie([EdCreditSoldeDebitCptEnTete,EdCreditSoldeCreditCptEnTete,EdCreditSoldeDebitCptCorps,EdCreditSoldeCreditCptCorps],E.FormatMonnaie);
MessDerSub:=true;
DMPieces.Piece1.ICompteTiers:=0;
DMPieces.Piece1.ILibTiers:=1;
DMPieces.Piece1.IndexCompte:=0;
DMPieces.Piece1.ILibTaPlan:=1;
DMPieces.Piece1.IndexJournal:=4;
DMPieces.Piece1.IRefTaPiece:=2;
//parametres grille En tête
//GrEnTete.Rows[0].CommaText:='Type pièce,Référence,Compte,Date de la pièce,Libellé de la pièce';
GrEnTete.ParamColor:=true;
GrEnTete.Param:=ParamUtil.CouleurDBGrid;
GrEnTete.UpDateColor;
GrEnTete.TextADroite:=false;

GrEnTete.cells[0,0]:='Type pièce';
GrEnTete.cells[1,0]:='  Numéro';
GrEnTete.cells[2,0]:='  Compte';
GrEnTete.cells[3,0]:='  Date pièce';
GrEnTete.cells[4,0]:='  Libellé de la pièce';
GrEnTete.DessineContourLigne:=false;
GrEnTete.Champ.Add(GrTous);
GrEnTete.Champ.Add(Grtous);
GrEnTete.Champ.Add(Grcompte);
GrEnTete.Champ.Add(GrDate);
GrEnTete.Champ.Add(Grtous);
//parametres grille
grgrid1.TextADroite:=false;
grgrid1.AjoutAuto:=false;
GrGrid1.ColCount:=7;
GrGrid1.Align:=alClient;
//GrGrid1.Options:=[goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,goEditing, goTabs,goDrawFocusSelected];
GrGrid1.Options:=[goVertLine, goHorzLine,goEditing, goTabs,goDrawFocusSelected];
GrGrid1.RowCount:=2;
GrGrid1.NumDecimal:=2;
//GrGrid1.Rows[0].CommaText:='," ",Compte,Libellé,Qté1,Qté2,Débit..(Charges),Crédit..(Produits)';
Grgrid1.cells[1,0]:='Compte';
Grgrid1.cells[2,0]:='Désignation';
Grgrid1.cells[3,0]:='Qté1';
Grgrid1.cells[4,0]:='Qté2';
Grgrid1.cells[5,0]:='Débit    (Charges)';
Grgrid1.cells[6,0]:='Crédit    (Produits)';
Grgrid1.Champ.Add(Grtous);
Grgrid1.Champ.Add(Grcompte);
Grgrid1.Champ.Add(Grtous);
Grgrid1.Champ.Add(Grcurr);
Grgrid1.Champ.Add(Grcurr);
Grgrid1.Champ.Add(Grcurr);
Grgrid1.Champ.Add(Grcurr);
// parametres Ecriture_Isa
//DMEcritures.Ecriture_Isa1.Piece:=DMPieces.Piece1;
CopieContenuPiece(DMPieces.Piece1,DMEcritures.Ecriture_Isa1.Piece);
DMEcritures.Ecriture_Isa1.TableEcriture:=DMEcritures.TaEcriture;
DMEcritures.Ecriture_Isa1.TableTVA:=DMTVACode.TaTvaCode;
DMEcritures.Ecriture_Isa1.TablePlan:=DMPlan.TaPlanCpt;
Grgrid1.FFormatMonnaie:=E.FormatMonnaie;
// parametres divers
//DMEcritures.Ecriture_Isa1.ListIdentifiant:=TList.Create;

PlusAutomatiqueEntete:=true;

//ListeCptExclusEnTete:=TStringList.Create;// PB
//ListeCptExclusCorps:=TStringList.Create;// PB

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);

Gestionimmos.ImmosASupprimer:=TStringList.Create;
Gestionimmos.CessionsASupprimer:=TStringList.Create;
InitialiseSuppressionImmo(Gestionimmos);

ListePointages:=tstringlist.Create;
Initialise_TStringlist(ListePointages,saisieP_3,false);

ListeReference:=TStringList.Create;
Initialise_TStringlist(ListeReference,saisieP_3,false);
end;

Procedure TsaisieP_3.InitialiseTable_A_Nil;
Begin
if DMPieces <> nil then
DMPieces.Piece1.OnStateChange:=nil;
End;

procedure TsaisieP_3.FormDestroy(Sender: TObject);
Var
  Registre :TRegistry;
begin
    Registre:= TRegistry.Create;
      try
       try
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;
            OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, True);
            begin
              if not empty(journalRegistre)then
                 WriteString('Edjournal',JournalRegistre)
              else
                 if  e.TypeDossier<>Verdiocese then
                   WriteString('Edjournal','AC');
              if dmpieces<>nil then
                Writeinteger('idtrameRegistre',dmpieces.Piece1.Trame.IDTrame);
              WriteBool('PlusDefautEntete',PlusDefautEntete); // PB
              WriteBool('PlusAutoEntete',PlusAutomatiqueEntete); // PB
              WriteBool('PlusDefautCorps',PlusDefautCorps); // PB
              WriteBool('PlusAutoCorps',PlusAutomatiqueCorps); // PB
              //****si pièce antérieure
              Writeinteger('TypeDerniereDateSaisieRegistreAnt_',TypeDerniereDateSaisieRegistreAnt_);
              WriteDate('DerniereDateSaisieRegistreAnt_',DerniereDateSaisieRegistreAnt_);
              WriteDate('DateAchatRegistreAnt_',DateAchatRegistreAnt_);
              WriteDate('DateVentesRegistreAnt_',DateVentesRegistreAnt_);
              WriteDate('DateBanqueRegistreAnt_',DateBanqueRegistreAnt_);
              WriteDate('DateODRegistreAnt_',DateODRegistreAnt_);

              //***si pièce année courante
              Writeinteger('TypeDerniereDateSaisieRegistre',TypeDerniereDateSaisieRegistre);
              WriteDate('DerniereDateSaisieRegistre',DerniereDateSaisieRegistre);
              WriteDate('DateAchatRegistre',DateAchatRegistre);
              WriteDate('DateVentesRegistre',DateVentesRegistre);
              WriteDate('DateBanqueRegistre',DateBanqueRegistre);
              WriteDate('DateODRegistre',DateODRegistre);
            end;
            CloseKey;
         end;
       except

       PlusDefautEntete:=E.PlanAuxT; // PB
       PlusDefautcorps:=E.PlanAuxT; // isa
       end;
      finally
         Registre.Free;
         DMPlan.TaCompte.OnFilterRecord:=nil;
      end;
InitialiseTable_A_Nil;
Initialise_TStringlist(Gestionimmos.ImmosASupprimer,self);
//if Gestionimmos.ImmosASupprimer<>nil then
//  begin
//  Gestionimmos.ImmosASupprimer.Free;
//  Gestionimmos.ImmosASupprimer:=nil;
//  end;
Initialise_TStringlist(Gestionimmos.CessionsASupprimer,self);
//if Gestionimmos.CessionsASupprimer<>nil then
//  begin
//  Gestionimmos.CessionsASupprimer.Free;
//  Gestionimmos.CessionsASupprimer:=nil;
//  end;
LibGestionParamXML.DestroyForm(Self,E.User);
if DataModuleImmos<>nil then  DataModuleImmos.Free;
//Initialise_TStringlist(ListeReference);
//Initialise_TStringlist(ListePointages);
LibereObjet(Tobject(ListeReference),Self);
LibereObjet(Tobject(ListePointages),Self);
//LibereObjet(Tobject(ListeReglementRecup));
SaisieP_3:=nil;
end;

procedure TsaisieP_3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if PaSelectCpt.Visible then PaSelectCpt.Visible:=false;
   
end;



//************************ EtatInitial *********************
procedure TsaisieP_3.EtatInitial(Col:integer;Partiel:boolean;Fermeture:boolean);
var
//conteneurVerrou:TVerrouillage;
i,newcol:integer;
InfosModel:TInfosModel;
Begin
Maintenance1.Visible:=((e.TypeClient=cl_isa)or(Type_version_execution=ct_developpement));
saisieP_3.GrGrid1.AcceptNegatif:=true;
ParamUtil.TypeMaintenanceSpeciale:='';
if ParamUtil.TypeMaintenanceSpeciale='pointage_'+IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82) then
  BtnAnnulerControle.Caption:='Contrôle désactivé'
else
  BtnAnnulerControle.Caption:='Contrôle activé';
if fermeture then
begin
  DMPieces.Piece1.NouvellePiece(false);
  dmpieces.Piece1.Trame.NouvelleTrame(false);
  TableGereRollBack(DMPieces.Piece1.TablePiece);
  TableGereRollBack(DMBalance.TaBalance);
  InitialiseSuppressionImmo(Gestionimmos);
        if DMPointage2<>nil then
          if DMPointage2.ListeID_Appelant<>nil then
            begin
              DMPointage2.ListeID_Appelant.Free;
              DMPointage2.ListeID_Appelant:=nil;
            end;
end
else
    begin
         if PaSelectCpt.Visible then
            begin
               PaSelectCpt.Visible:=false;
            end;

        //pour gérer la suppression de pièces autogénérées { isa  le  09/09/03 }

        BtnAnnulerControle.Visible:=((e.TypeClient=cl_isa)or((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')));
        DMPieces.Piece1.SuppressionParticulieres := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
        GrGrid1.Options:=GrGrid1.Options+[goediting];
        { isa  le  09/09/03 }


        //initialisation de tous les edits et de la grille
        TableGereRollBack(DMPieces.Piece1.TablePiece);
        TableGereRollBack(DMBalance.TaBalance);


        DMTmTVA.MAJ_DateDeclarationTVA(E.DateDebutDeclarationTVA,E.DatefinDeclarationTVA);
        grentete.cells[0,0]:='Type pièce ';
        Initialise_TInfosModel(infosmodel);
        InitialiseModifObj(modif);
        journaltmp:='';
        InitialiseSuppressionImmo(Gestionimmos);
        //IDTrameRegistre:=0;
        if not empty(GrEntete.Cells[0,1])then
          JournalRegistre:=GrEntete.Cells[0,1];
        if DMPieces.Piece1.Trame.TableTrame.Locate('ID',DMPieces.Piece1.Trame.IDTrame,[])then
          begin
            if DMPieces.Piece1.Trame.TableTrame.findfield('Journal').asstring=dmpieces.piece1.Journal then
              Begin
                if DMPieces.Piece1.Trame.IDTrame<>0 then
                   idtrameRegistre:=DMPieces.Piece1.Trame.IDTrame
                else
                   idtrameRegistre:=0;
              End
            else
              begin
                dmpieces.Piece1.Trame.NouvelleTrame(false);
                idtrameRegistre:=0;
              end;
          end
        else
          begin
            dmpieces.Piece1.Trame.NouvelleTrame(false);
            idtrameRegistre:=0;
          end;


             InfosModel:=Infos_TInfosModel(dmrech.TaModelRech,'Code',[JournalRegistre]);
             PaTools.caption:='Type pièce : '+InfosModel.journal+' - '+InfosModel.Libelle_Model;

        LibelleTmp:='';
        if not partiel then
          begin
            if GrEnTete.InplaceEditor <> nil then
                 GrEnTete.InplaceEditor.Text:='';
            for i:=0 to GrEnTete.ColCount-1 do
            GrEnTete.cells[i,1]:='';
          end;
        GrEnTete.cells[1,1]:='';
        //***nouvelle piece***
        DMPieces.Piece1.NouvellePiece(partiel);

        GrEntete.Refresh;
        EdDateEcheance.Clear;
        EdDateLivraison.Clear;
        GrGrid1.Options:=GrGrid1.Options+[goediting];
        FindPieceExit:=false;
        ContrepartieCree:=false;

        if DMPieces.Piece1.AnneePiece.PieceAnterieure then
          Begin
             GrEnTete.Cells[3,1]:=datetostr(DerniereDateSaisieRegistreAnt_);
             if strtodate_lgr(GrEnTete.Cells[3,1])<e.DatExoDebut then GrEnTete.Cells[3,1]:=datetostr_lgr(e.DatExoDebut-1);
          End
        else
          Begin
             if DerniereDateSaisieRegistre>=e.DateDebutDeclarationTVA then
               GrEnTete.Cells[3,1]:=datetostr(DerniereDateSaisieRegistre)
             else
               GrEnTete.Cells[3,1]:=datetostr(e.DateDebutDeclarationTVA);
          if strtodate_lgr(GrEnTete.Cells[3,1])<e.DatExoDebut then
            GrEnTete.Cells[3,1]:=datetostr_lgr(e.DatExoDebut);
          if strtodate_lgr(GrEnTete.Cells[3,1])>e.DatExoFin then
            GrEnTete.Cells[3,1]:=datetostr_lgr(e.DatExoFin);
          End;
        DMPieces.Piece1.DateSaisie:=StrToDate_Lgr(GrEnTete.Cells[3,1]);
        DatePieceTmp:=GrEnTete.Cells[3,1];

        EdDateEcheance.Text:=GrEnTete.Cells[3,1];
        DMPieces.Piece1.DateEcheance:=EdDateEcheance.Date;
        DateEcheancetmp:=GrEnTete.Cells[3,1];

        EdDateLivraison.Text:=GrEnTete.Cells[3,1];
        DMPieces.Piece1.DateLivraison:=EdDateLivraison.Date;
        DateLivraisonTmp:=GrEnTete.Cells[3,1];

        ///////////
        grgrid1.OnRowEnter:=nil;
        grgrid1.OnColEnter:=nil;
        GrGrid1.OnColExit:=nil;
        GrGrid1.OnRowValidate:=nil;
        grgrid1.OnSupprLigne:=nil;
        grgrid1.OnBeforeSupprLigne:=nil;


        if grGrid1.RowCount>2 then
         Begin
          for i:=1 to grGrid1.RowCount-1 do grGrid1.Rows[i].Clear;
          grGrid1.RowCount:=2
         End
        else
          grGrid1.Rows[1].Clear;
        grGrid1.Row:=1;
        newcol:=RecupCelluleValide(1,1);
        if newcol<>-1 then
          grGrid1.col:=newcol;
        ligneCurr:=grGrid1.Row;
        grgrid1.EtatGrille:=dsbrowse;
        GrGrid1.Rows[1].Text:='';
        CelluleSelect:=-1;


        ValiderPointageEnCours:=false;
        GrEnTete.OnColEnter:=nil;
        GrEnTete.OnColExit:=nil;
                   if col=0 then
                   GrEnTete.Col:=0;
                   if self.visible then
                   GrEnTete.SetFocus;
                   WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);

        grgrid1.OnRowEnter:=GrGrid1RowEnter;
        grgrid1.OnColEnter:=GrGrid1ColEnter;
        GrGrid1.OnColExit:=GrGrid1ColExit;
        GrGrid1.OnRowValidate:=GrGrid1RowValidate;
        grgrid1.OnSupprLigne:=GrGrid1SupprLigne;
        grgrid1.OnBeforeSupprLigne:=GrGrid1BeforeSupprLigne;
        GrGrid1StateChange(grgrid1.EtatGrille);
        GrEnTete.OnColEnter:=GrEnTeteColEnter;
        GrEnTete.OnColExit:=GrEnTeteColExit;
        CalculSolde;
        grgrid1.cells[1,0]:=' Compte';
        //////////////////////////
        if DMPointage2<>nil then
          if DMPointage2.ListeID_Appelant<>nil then
            begin
              DMPointage2.ListeID_Appelant.Free;
              DMPointage2.ListeID_Appelant:=nil;
            end;
        DMEcritures.Ecriture_Isa1.InitialiseParamCompte_Obj(ParametreCompteEcriture);
        GestionInfoCorps(grgrid1.Cells[1,grgrid1.row]);
        GestionInfoEntete(DMPieces.Piece1.compte);
        GestionDesUnites;
    end;//si initialisation normale

End;

///////// *****************ENTETE DE LA PIECE ***********************/////////////////
///////////////////////////////////////////////////////////////////////////

procedure TsaisieP_3.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TsaisieP_3.Aide1Click(Sender: TObject);
var
Date:TDateTime;
MontantTVA:TRetourMontantTva;
ParamTva:TRecupParamTva_obj;
tab:variant;
Compte,libelle:string;
valide:boolean;
debitAvant,creditAvant,DebitApres,CreditApres,montantTmp:currency;
ModifiableTmp:boolean;
TTC,Taux,MtTVA:Tedit;
Index:integer;
EditTmp:TInplaceEdit;
begin
valide:=true;
debitAvant:=0;
creditAvant:=0;
DebitApres:=0;
CreditApres:=0;
montantTmp:=0;
Compte:='';
libelle:='';
ModifiableTmp:=false;
if not empty(GrGrid1.Cells[5,ligneCurr])then
   debitAvant:=StrToCurr_Lgr(GrGrid1.Cells[5,ligneCurr]);
if not empty(GrGrid1.Cells[6,ligneCurr])then
   creditavant:=StrToCurr_Lgr(GrGrid1.Cells[6,ligneCurr]);
if not empty(GrGrid1.Cells[1,ligneCurr])then
   Compte:=GrGrid1.Cells[1,ligneCurr];
if DMPieces.Piece1.PieceModifiable then
begin
If activecontrol = GrGrid1 Then
  begin //si on est sur la grille
   case GrGrid1.col of
      1:Begin
        //Afficher aidecompte filtré en fonction du journal
        DMPieces.GestionFiltrageParamCptSurCompte(DMPieces.Piece1.Compte);
        MessDerSub:=false;

        if DMPieces.Piece1.IDJournal in [1,2,3]  then
          begin
            if AideCompteDansContexte(GrGrid1.Cells[1,ligneCurr],GrGrid1,['Rac1'],true,MessDerSub,false,true,true,true,0) then
             begin
               if GrGrid1.Cells[1,ligneCurr]<>Compte then
                  begin//si piece modifiée
 // if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
  if (not Gestionimmos.supprimerImmos)and (not Gestionimmos.supprimerCessions) and (DMPieces.Piece1.EtatPiece=dsEdit) then
      begin
         if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,ligneCurr).retour= false then
            begin
              GrGrid1.Cells[1,ligneCurr]:=compte;
              abort;
            end;
      end;
                  if DMPieces.Piece1.EtatPiece=dsedit then
                     begin //si piece existante
                       if ((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false)) then
                         Begin //si modification de la pièce pas encore activée
                            if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                               begin
                                 if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                                    ModifiableTmp:=true;
                               end
                            else
                               ModifiableTmp:=true;
                          if ModifiableTmp then //si on veut quand même la modifier
                               DMPieces.Piece1.Modifier_EnAttente:=true
                            else
                              //si on ne veut pas la modifier
                               GrGrid1.Cells[1,Lignecurr]:=Compte;
                         End;//fin si modification de la pièce pas encore activée
                     end; //fin si piece existante
//                  GrGrid1RowValidate(grgrid1,valide,valide,5);
                  end;//fin si piece modifiée

              if not empty(grgrid1.Cells[1,ligneCurr]) then
                begin
                 if ((not empty(grgrid1.Cells[1,ligneCurr]))and(grgrid1.Cells[1,ligneCurr][1] <> '+')) then
                 begin
                  LaCompteEnCours.Caption:=DMPlan.LibelleDuNumCptPCU(grgrid1.Cells[1,ligneCurr]);
                    if DMPlan.PossedeFils(grgrid1.Cells[1,ligneCurr]) then
                         LaCompteEnCours.Font.Color:=clblack
                         else
                         LaCompteEnCours.Font.Color:=clGreen;
                   end
                  else
                   Begin
                     LaCompteEnCours.Caption:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[grgrid1.Cells[1,ligneCurr]]).Nom;
//                     LaCompteEnCours.Caption:=DMTiers.LibelleDuTiers(grgrid1.Cells[1,ligneCurr]);
                     LaCompteEnCours.Font.Color:=clGreen;
                   End;
                end
                 else LaCompteEnCours.Caption:='';
              end;
            DMPieces.CptExclusDeContexte(GrGrid1.Cells[1,ligneCurr],2);
          end;
        if DMPieces.Piece1.IDJournal in [4]  then //journal de banque
          begin
           if EdPlusTiersCorps.text='+' then
             Index:=1
           else
             Index:=0;
            if AideCompteDansContexte(GrGrid1.Cells[1,ligneCurr],GrGrid1,['Rac1'],true,MessDerSub,false,true,true,true,Index) then
             begin
              if not empty(grgrid1.Cells[1,ligneCurr]) then
                begin
                  if DMPieces.Piece1.EtatPiece=dsedit then
                     begin //si piece existante
                       if ((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false)) then
                         Begin //si modification de la pièce pas encore activée
                            if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                               begin
                                 if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                                    ModifiableTmp:=true;
                               end
                            else
                               ModifiableTmp:=true;
                          if ModifiableTmp then //si on veut quand même la modifier
                               DMPieces.Piece1.Modifier_EnAttente:=true
                            else
                              //si on ne veut pas la modifier
                               GrGrid1.Cells[1,Lignecurr]:=Compte;
                         End;//fin si modification de la pièce pas encore activée
                     end; //fin si piece existante

                 if ((not empty(grgrid1.Cells[1,ligneCurr]))and(grgrid1.Cells[1,ligneCurr][1] <> '+')) then
                 begin
                  LaCompteEnCours.Caption:=DMPlan.LibelleDuNumCptPCU(grgrid1.Cells[1,ligneCurr]);
                    if DMPlan.PossedeFils(grgrid1.Cells[1,ligneCurr]) then
                         LaCompteEnCours.Font.Color:=clblack
                         else
                         LaCompteEnCours.Font.Color:=clGreen;
                   end
                  else
                   Begin
                     LaCompteEnCours.Caption:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[grgrid1.Cells[1,ligneCurr]]).Nom;
//                     LaCompteEnCours.Caption:=DMTiers.LibelleDuTiers(grgrid1.Cells[1,ligneCurr]);
                     LaCompteEnCours.Font.Color:=clGreen;
                   End;
                end
                 else LaCompteEnCours.Caption:='';
              end;
          end;

        MessDerSub:=true;
        End;
      5:with Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne do
          begin //si colonne 5 et début with ListIdentifiant
          try
          TTC:=TEdit.Create(self);
          Taux:=TEdit.Create(self);
          MtTVA:=TEdit.Create(self);
          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne<>'T' then
             begin//si typeligne H,X,B
               //si OD, donc ligne H mais compte TVA
               if copy(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Compte,1,2)='44'then
                 Begin
                    with TVA do
                    begin //debut with Ligne.TVA
                    //récupère les totaux des lignes de hors taxes fonctionnant avec cette ligne de tva
                    MontantTVA:=DMEcritures.Ecriture_Isa1.VerifMontantTVA_SurListe(DMEcritures.Ecriture_Isa1.ListIdentifiant,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.debit,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Credit,0,0,'',-1,false);
                    ParamTva.CodeTva:='';
                    ParamTva.TauxMin:=0;
                    ParamTva.TauxMax:=0;
                    //récupère le codetva de la ligne tva en cours
                    ParamTva.CodeTva:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA.CodeTva;
                    //récupère les taux de la ligne tva en cours
                    ParamTva:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA;
                    case MontantTVA.SensCredit of
                     C_SensSoldeDebit:if paramtva.TauxMin=paramtva.TauxMax then
                                        AideMontantAffiche([paramtva.TauxMin,0,0,MontantTVA.RetourMontantMini_extended],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal)
                                        else
                                        AideMontantAffiche([paramtva.TauxMin,0,0,MontantTVA.RetourMontantMini_extended,paramtva.TauxMax,0,0,MontantTVA.RetourMontantMaxi_extended],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal);
                     C_SensSoldeCredit,
                     C_SensSoldeNul:   if paramtva.TauxMin=paramtva.TauxMax then
                                        AideMontantAffiche([paramtva.TauxMin,0,0,0],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal)
                                        else
                                        AideMontantAffiche([paramtva.TauxMin,0,0,0,paramtva.TauxMax,0,0,0],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal);
                    end;//fin du case senscredit
                    end;//fin with Ligne.TVA
                 End
               else
               if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA.Retour then
                   begin
                     with TVA do
                     begin //debut with Ligne.TVA
                     if not empty(grgrid1.cells[5,ligneCurr])then montantTmp:=StrToFloat_Lgr(grgrid1.cells[5,ligneCurr]);
                        if (TauxMin=TauxMax) then
                        AideMontantAffiche([TauxMin,0,montantTmp,0],2,true,[grgrid1,TTC,Taux,MtTVA],[2,3,1,4],Devise,DMPieces.Piece1.IDJournal)
                        else
                        AideMontantAffiche([TauxMin,0,montantTmp,0,TauxMax,0,montantTmp,0],2,true,[grgrid1,TTC,Taux,MtTVA],[2,3,1,4],Devise,DMPieces.Piece1.IDJournal);
                     end; //fin with Ligne.TVA
                   end
                 else
                   showmessage('Ce compte n''attend pas de TVA');
             end;//fin si typeligne H,X,B
          if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='T')and (not empty(grgrid1.Cells[1,ligneCurr]))) then
             Begin //si typeligne T , récupération des totaux des lignes fonctionnant avec ce compte tva
               with TVA do
               begin //debut with Ligne.TVA
               //récupère les totaux des lignes de hors taxes fonctionnant avec cette ligne de tva
               MontantTVA:=DMEcritures.Ecriture_Isa1.VerifMontantTVA_SurListe(DMEcritures.Ecriture_Isa1.ListIdentifiant,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.debit,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Credit,0,0,'',-1,false);
               ParamTva.CodeTva:='';
               ParamTva.TauxMin:=0;
               ParamTva.TauxMax:=0;
               //récupère le codetva de la ligne tva en cours
               ParamTva.CodeTva:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA.CodeTva;
               //récupère les taux de la ligne tva en cours
               ParamTva:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA;
               case MontantTVA.SensCredit of
                C_SensSoldeDebit:if paramtva.TauxMin=paramtva.TauxMax then
                                   AideMontantAffiche([paramtva.TauxMin,0,0,MontantTVA.RetourMontantMini_extended],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal)
                                   else
                                   AideMontantAffiche([paramtva.TauxMin,0,0,MontantTVA.RetourMontantMini_extended,paramtva.TauxMax,0,0,MontantTVA.RetourMontantMaxi_extended],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal);
                C_SensSoldeCredit,
                C_SensSoldeNul:   if paramtva.TauxMin=paramtva.TauxMax then
                                   AideMontantAffiche([paramtva.TauxMin,0,0,0],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal)
                                   else
                                   AideMontantAffiche([paramtva.TauxMin,0,0,0,paramtva.TauxMax,0,0,0],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal);
               end;//fin du case senscredit
               end;//fin with Ligne.TVA
             End//fin si typeligne T
           else
             Begin //si ligne autre que T
                //récupérer nouveau taux et nouveau montant tva dans le complément ligne
                  if not empty(MtTVA.Text)then
                    Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Complement.MontantTva:=StrToCurr_Lgr(quedeschiffres(MtTVA.Text));
                  if not empty(taux.Text)then
                    Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Complement.TvaTaux:=StrToCurr_Lgr(QueDesChiffres(taux.Text));
             End;//fin si ligne autre que T
        if not empty(GrGrid1.Cells[5,ligneCurr]) then
          DebitApres:=StrToCurr_Lgr(GrGrid1.Cells[5,ligneCurr])
        else
          DebitApres:=0;
          if DebitApres<>DebitAvant then
             begin//si piece modifiée
             if DMPieces.Piece1.EtatPiece=dsedit then
                begin //si piece existante
                  if ((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false)) then
                    Begin //si modification de la pièce pas encore activée
                         if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                            begin
                              if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                                 ModifiableTmp:=true;
                            end
                         else
                            ModifiableTmp:=true;
                       if ModifiableTmp then //si on veut quand même la modifier
                          DMPieces.Piece1.Modifier_EnAttente:=true
                       else
                         //si on ne veut pas la modifier
                          GrGrid1.Cells[5,Lignecurr]:=e.FormatCurrSansDevise(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Debit);
                    End;//fin si modification de la pièce pas encore activée
                end; //fin si piece existante
             GrGrid1RowValidate(grgrid1,valide,valide,5);
             end;//fin si piece modifiée
          finally
            TTC.free;
            Taux.free;
            MtTVA.free;
            GrGrid1Change(nil);
          end;//fin du try finally
          end;//fin si colonne 5 et fin with ListIdentifiant
      6:with Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne do
          begin //si colonne 5 et début with ListIdentifiant
            try
            TTC:=TEdit.Create(self);
            Taux:=TEdit.Create(self);
            MtTVA:=TEdit.Create(self);
            if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne<>'T' then
               begin//si typeligne H,X,B
                 if copy(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Compte,1,2)='44'then
                   Begin//si OD, donc ligne H mais compte TVA
                      with TVA do
                      begin //debut with Ligne.TVA
                      //récupère les totaux des lignes de hors taxes fonctionnant avec cette ligne de tva
                      MontantTVA:=DMEcritures.Ecriture_Isa1.VerifMontantTVA_SurListe(DMEcritures.Ecriture_Isa1.ListIdentifiant,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.debit,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.credit,0,0,'',1,false);
                      ParamTva.CodeTva:='';
                      ParamTva.TauxMin:=0;
                      ParamTva.TauxMax:=0;
                      //récupère le codetva de la ligne tva en cours
                      ParamTva.CodeTva:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA.CodeTva;
                      //récupère les taux de la ligne tva en cours
                      ParamTva:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA;
                     case MontantTVA.SensCredit of
                       C_SensSoldeCredit:if paramtva.TauxMin=paramtva.TauxMax then
                                          AideMontantAffiche([paramtva.TauxMin,0,0,MontantTVA.RetourMontantMini_extended],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal)
                                          else
                                          AideMontantAffiche([paramtva.TauxMin,0,0,MontantTVA.RetourMontantMini_extended,paramtva.TauxMax,0,0,MontantTVA.RetourMontantMaxi_extended],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal);
                       C_SensSoldeDebit,
                       C_SensSoldeNul:   if paramtva.TauxMin=paramtva.TauxMax then
                                          AideMontantAffiche([paramtva.TauxMin,0,0,0],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal)
                                          else
                                          AideMontantAffiche([paramtva.TauxMin,0,0,0,paramtva.TauxMax,0,0,0],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal);
                      end;//fin du case senscredit
                      end;//fin with Ligne.TVA
                   end//fin si OD, donc ligne H mais compte TVA
                 else
  //               if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA.Retour then
  //                 begin
  //                    with Ligne.TVA do
  //                    begin //debut with Ligne.TVA
  //                       if not empty(grgrid1.cells[6,ligneCurr])then montantTmp:=StrToFloat_Lgr(grgrid1.cells[6,ligneCurr]);
  //                       if (TauxMin=TauxMax) then
  //                       AideMontantAffiche([TauxMin,0,montantTmp,0],2,true,[grgrid1],[2],Devise,DMPieces.Piece1.IDJournal)
  //                       else
  //                       AideMontantAffiche([TauxMin,0,montantTmp,0,TauxMax,0,montantTmp,0],2,true,[grgrid1],[2],Devise,DMPieces.Piece1.IDJournal);
  //                    end; //fin with Ligne.TVA
  //                 end
  //               else
  //                 showmessage('Ce compte n''attend pas de TVA');
                 if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA.Retour then
                     begin
                       with TVA do
                       begin //debut with Ligne.TVA
                       if not empty(grgrid1.cells[6,ligneCurr])then montantTmp:=StrToFloat_Lgr(grgrid1.cells[6,ligneCurr]);
                          if (TauxMin=TauxMax) then
                          AideMontantAffiche([TauxMin,0,montantTmp,0],2,true,[grgrid1,TTC,Taux,MtTVA],[2,3,1,4],Devise,DMPieces.Piece1.IDJournal)
                          else
                          AideMontantAffiche([TauxMin,0,montantTmp,0,TauxMax,0,montantTmp,0],2,true,[grgrid1,TTC,Taux,MtTVA],[2,3,1,4],Devise,DMPieces.Piece1.IDJournal);
                       end; //fin with Ligne.TVA
                     end
                   else
                     showmessage('Ce compte n''attend pas de TVA');
               end;//fin si typeligne H,X,B
            if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='T')and (not empty(grgrid1.Cells[1,ligneCurr]))) then
               Begin //si typeligne T , récupération des totaux des lignes fonctionnant avec ce compte tva
                 with TVA do
                 begin //debut with Ligne.TVA
                 //récupère les totaux des lignes de hors taxes fonctionnant avec cette ligne de tva
                 MontantTVA:=DMEcritures.Ecriture_Isa1.VerifMontantTVA_SurListe(DMEcritures.Ecriture_Isa1.ListIdentifiant,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.debit,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.credit,0,0,'',1,false);
                 ParamTva.CodeTva:='';
                 ParamTva.TauxMin:=0;
                 ParamTva.TauxMax:=0;
                 //récupère le codetva de la ligne tva en cours
                 ParamTva.CodeTva:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA.CodeTva;
                 //récupère les taux de la ligne tva en cours
                 ParamTva:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA;
                case MontantTVA.SensCredit of
                  C_SensSoldeCredit:if paramtva.TauxMin=paramtva.TauxMax then
                                     AideMontantAffiche([paramtva.TauxMin,0,0,MontantTVA.RetourMontantMini_extended],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal)
                                     else
                                     AideMontantAffiche([paramtva.TauxMin,0,0,MontantTVA.RetourMontantMini_extended,paramtva.TauxMax,0,0,MontantTVA.RetourMontantMaxi_extended],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal);
                  C_SensSoldeDebit,
                  C_SensSoldeNul:   if paramtva.TauxMin=paramtva.TauxMax then
                                     AideMontantAffiche([paramtva.TauxMin,0,0,0],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal)
                                     else
                                     AideMontantAffiche([paramtva.TauxMin,0,0,0,paramtva.TauxMax,0,0,0],4,true,[grgrid1],[4],Devise,DMPieces.Piece1.IDJournal);
                 end;//fin du case senscredit
                 end;//fin with Ligne.TVA
               End//fin si typeligne T
             else
               Begin //si ligne autre que T
                  //récupérer nouveau taux et nouveau montant tva dans le complément ligne
                    if not empty(MtTVA.Text)then
                      Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Complement.MontantTva:=StrToCurr_Lgr(quedeschiffres(MtTVA.Text));
                    if not empty(taux.Text)then
                      Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Complement.TvaTaux:=StrToCurr_Lgr(QueDesChiffres(taux.Text));
               End;//fin si ligne autre que T
  //          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Credit<>credit then
          if not empty(GrGrid1.Cells[6,ligneCurr]) then
            CreditApres:=StrToCurr_Lgr(GrGrid1.Cells[6,ligneCurr])
          else
            CreditApres:=0;
            if CreditApres<>CreditAvant then
               begin//si piece modifiée
               if DMPieces.Piece1.EtatPiece=dsedit then
                  begin //si piece existante
                    if ((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false)) then
                      Begin //si modification de la pièce pas encore activée
                           if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                              begin
                                if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                                   ModifiableTmp:=true;
                              end
                           else
                              ModifiableTmp:=true;
                         if ModifiableTmp then //si on veut quand même la modifier                        //si on veut quand même la modifier
                            DMPieces.Piece1.Modifier_EnAttente:=true
                         else
                           //si on ne veut pas la modifier
                            GrGrid1.Cells[6,Lignecurr]:=e.FormatCurrSansDevise(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Credit);
                      End;//fin si modification de la pièce pas encore activée
                  end; //fin si piece existante
               GrGrid1RowValidate(grgrid1,valide,valide,6);
               GrGrid1Change(nil);
               end;//fin si piece modifiée
            finally
              TTC.free;
              Taux.free;
              MtTVA.free;
            end;//fin du try finally
          end;//fin si colonne 5 et fin with ListIdentifiant
   end;//fin du case etatpiece
 end; //fin si on est sur la grille
end;
///////////////////

//si on est sur l'entete de la pièce
 If activecontrol = GrEnTete Then
  begin
  case GrEnTete.col of
     0:begin // Journal
         try
         EditTmp:=TInplaceEdit.Create(self);
         if GrEnTete.InplaceEditor.visible then
           EditTmp.Text:=GrEnTete.InplaceEditor.Text
         else
           EditTmp.Text:=GrEnTete.cells[0,1];
         EtatInitial(0,false);
         dmpieces.piece1.Journal:='';
         if not AideTrameExiste(EditTmp,true,GrEnTete,dmpieces.piece1).retour then abort;
         if JournalTmp<>EditTmp.Text then
           begin
             GrEnTete.Cells[1,1]:='';
             GrEnTete.cells[0,1]:=EditTmp.Text;
             //journaltmp:=EditTmp.Text;
             GrEnTete.InplaceEditor.Text:=EditTmp.Text;
             grentete.col:=1;
           end;

         finally
           if GrEnTete.InplaceEditor.Visible then
             GrEnTete.InplaceEditor.text:=EditTmp.text;
           GrEnTete.Cells[0,1]:=EditTmp.Text;
           journaltmp:=GrEnTete.Cells[0,1];
           EditTmp.free;
           EditTmp:=nil;
         end;
       end;//fin si activecontrol = edJournal
     1:begin
         BtnRecherchePiece.click;
       end;
   end;//fin du case colonne
   end;
if DMPieces.Piece1.PieceModifiable then
begin
   case GrEnTete.col of
     2:begin //Compte
         if DMPieces.Piece1.IDJournal in [1,2]  then
         begin//si journal achat ou vente
           try //finally
           EditTmp:=TInplaceEdit.Create(self);
           if GrEnTete.InplaceEditor.visible then
           EditTmp.Text:=GrEnTete.InplaceEditor.Text
           else
           EditTmp.Text:=GrEnTete.cells[2,1];
           compte:=EditTmp.Text;
           DMPieces.GestionFiltrageParamCpt;
           MessDerSub:=false;
           if empty(EditTmp.Text) then //PB
           begin
           if not empty(EdPlusTiersEntete.Text)then
             AideCompteDansContexte(EditTmp.Text,EditTmp,['Rac1'],true,MessDerSub,false,true,true,true,1)
           else
             AideCompteDansContexte(EditTmp.Text,EditTmp,['Rac1'],true,MessDerSub,false,true,true,true,0);
           DMPieces.CptExclusDeContexte(EditTmp.Text,1);
           end
           else
           Begin
           if not empty(EdPlusTiersEntete.Text)then
             AideCompteDansContexte(EditTmp.Text,EditTmp,['Rac1'],true,MessDerSub,false,true,true,true,1)
           else
             AideCompteDansContexte(EditTmp.Text,EditTmp,['Rac1'],true,MessDerSub,false,true,true,true,0);
           End;
           MessDerSub:=true;
//           if compte<>EditTmp.Text then
             GrEnTete.Change(GrEnTete);
         GestionDuPlusSurEntete(EditTmp.Text,dmpieces.Piece1.Journal);
         finally
           if GrEnTete.InplaceEditor.Visible then
             GrEnTete.InplaceEditor.text:=EditTmp.text;
           GrEnTete.Cells[2,1]:=EditTmp.Text;
           GrEnTete.cellsGr(GrEnTete.col,1,EditTmp.Text);
           EditTmp.free;
           EditTmp:=nil;
         end;
         end;//fin si journal achat ou vente
       end;//fin si activecontrol = edCompte
     3:begin
          try
           //
         finally
         end;
       end;//
     4:Begin
         try
           //
         finally
         end;
       End;

  end;//fin du case colonne

  end;
///////////////////
if DMPieces.Piece1.PieceModifiable then
begin
   If activecontrol = EdDateEcheance Then
  begin
  if not empty(EdDateEcheance.text) then
  Date:=StrToDate_Lgr(EdDateEcheance.text);
     if PopupDate(Date,EdDateEcheance) then
      begin
        EdDateEcheance.text:=datetostr(Date);
        DMPieces.Piece1.DateEcheance:=Date;
      end;
  end;//fin si activecontrol = EdDate
///////////////////
If activecontrol = EdDateLivraison Then
  begin
  if not empty(EdDateLivraison.text) then
  Date:=StrToDate_Lgr(EdDateLivraison.text);
     if PopupDate(Date,EdDateLivraison) then
      begin
        EdDateLivraison.text:=datetostr(Date);
        DMPieces.Piece1.DateLivraison:=Date;
      end;
  end;//fin si activecontrol = EdDate
end;  
//fin si on est sur l'entete de la pièce
///////////////////
end;




///////////*******GESTION DES BOUTONS *****************///////////////////
/////////////////////////////////////////////////////////////////////////

procedure TsaisieP_3.ChangementEtatBoutonsMenu;
Begin
//changement d'état des boutons et menu après chaque changemement d'étatPiece
case DMPieces.Piece1.EtatPiece of
dsbrowse:case grgrid1.EtatGrille of
          dsbrowse:Begin
                   if activecontrol=grgrid1 then
                     begin
                     EnableWinControl([BtnAnnuler,BtnInserer,BtnFermer,BtnImprimer],true);
                     EnableWinControl([BtnEnregistrer],False);
                     BtnModifier.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     BtnSupprimer.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     end
                   else
                     Begin
                     EnableWinControl([BtnAnnuler,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],true);
                     EnableWinControl([BtnEnregistrer],False);
                     End;
                   //Pop menu grille
                   if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Imprimer2,Calculatrice2,Insrer2,
                       Annuler2,Fermer2],true);
                       EnableItemMenu([Enregister2,Rglement1],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End
                   else
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Imprimer2,Calculatrice2,Insrer2,
                       Annuler2,Fermer2,ComplmentLigne1,Rglement1],true);
                       EnableItemMenu([Enregister2],false);
                     End;
                   modifier2.Enabled:=BtnModifier.Enabled;
                   Supprimer2.Enabled:=BtnSupprimer.Enabled;
                   //Pop menu Piece
                   EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Imprimer1,Calculatrice1,Insrer1,
                   Annuler1,Fermer1],true);
                   EnableItemMenu([Enregister1],false);
                   modifier1.Enabled:=BtnModifier.Enabled;
                   Supprimer1.Enabled:=BtnSupprimer.Enabled;
                   End;
         end;//fin du case etatgrille
dsinsert:case grgrid1.EtatGrille of
          dsbrowse:Begin
                   if activecontrol=grgrid1 then
                     begin //si dans la grille
                     EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnFermer],true);
                     EnableWinControl([BtnImprimer],False);
                     BtnModifier.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     BtnSupprimer.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     end//fin si dans la grille
                   else
                     Begin //si dans l'entête ou ailleurs
                     EnableWinControl([BtnAnnuler,BtnFermer],true);
                     EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
                     End; //fin si dans l'entête ou ailleurs
                   BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not((grgrid1.rowcount-1=1)and(not grgrid1.LigneVide(1)))));
                   BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not grgrid1.LigneVide(1)));
                   //Pop menu grille
                   if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,Insrer2,
                       Annuler2,Fermer2],true);
                       EnableItemMenu([Imprimer2,Rglement1],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End
                   else
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,Insrer2,
                       Annuler2,Fermer2,Rglement1],true);
                       EnableItemMenu([Imprimer2],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End;
                   modifier2.Enabled:=BtnModifier.Enabled;
                   Supprimer2.Enabled:=BtnSupprimer.Enabled;
                   Enregister2.Enabled:=BtnEnregistrer.Enabled;
                   //Pop menu Piece
                   EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Calculatrice1,
                   Annuler1,Fermer1],true);
                   EnableItemMenu([Insrer1,modifier1,Supprimer1,Imprimer1],false);
                   Enregister1.Enabled:=BtnEnregistrer.Enabled;
                   End;
          dsinsert:Begin
                     EnableWinControl([BtnAnnuler,BtnFermer],true);
                     EnableWinControl([BtnInserer,BtnModifier,BtnImprimer],False);
                     BtnSupprimer.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     //BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not((grgrid1.rowcount-1=1)and(not grgrid1.LigneVide(1)))));
                     BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not grgrid1.LigneVide(1)));
                   //Pop menu grille
                   if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,
                       Annuler2,Fermer2],true);
                       EnableItemMenu([Insrer2,modifier2,Imprimer2,Rglement1],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End
                   else
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,
                       Annuler2,Fermer2,Rglement1],true);
                       EnableItemMenu([Insrer2,modifier2,Imprimer2],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End;
                   Supprimer2.Enabled:=BtnSupprimer.Enabled;
                   Enregister2.Enabled:=BtnEnregistrer.Enabled;
                   End;
          dsedit:  Begin
                     EnableWinControl([BtnAnnuler,BtnFermer],true);
                     EnableWinControl([BtnInserer,BtnModifier,BtnImprimer],False);
                     BtnSupprimer.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                   //  BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not((grgrid1.rowcount-1=1)and(not grgrid1.LigneVide(1)))));
                     BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not grgrid1.LigneVide(1)));
                   //Pop menu grille
                   if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,
                       Annuler2,Fermer2],true);
                       EnableItemMenu([Insrer2,modifier2,Imprimer2,Rglement1],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End
                   else
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,
                       Annuler2,Fermer2,Rglement1],true);
                       EnableItemMenu([Insrer2,modifier2,Imprimer2],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End;
                   Supprimer2.Enabled:=BtnSupprimer.Enabled;
                   Enregister2.Enabled:=BtnEnregistrer.Enabled;
                   End;
         end;//fin du case etatGrille
dsedit: case grgrid1.EtatGrille of
         dsbrowse:Begin
                   if activecontrol=grgrid1 then
                     begin
                     EnableWinControl([BtnAnnuler,BtnInserer,BtnFermer,BtnImprimer],true);
                     BtnModifier.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     BtnSupprimer.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     end
                   else
                     Begin
                     EnableWinControl([BtnAnnuler,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],true);
                     EnableWinControl([BtnModifier],False);
                     End;
                   //BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not((grgrid1.rowcount-1=1)and(not grgrid1.LigneVide(1)))));
                     BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not grgrid1.LigneVide(1)));
                   //Pop menu grille
                   if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Imprimer2,Calculatrice2,Insrer2,
                       Annuler2,Fermer2],true);
                       EnableItemMenu([Rglement1],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End
                   else
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Imprimer2,Calculatrice2,Insrer2,
                       Annuler2,Fermer2,Rglement1],true);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End;
                   modifier2.Enabled:=BtnModifier.Enabled;
                   Supprimer2.Enabled:=BtnSupprimer.Enabled;
                   Enregister2.Enabled:=BtnEnregistrer.Enabled;
                   //Pop menu Piece
                   EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Imprimer1,Calculatrice1,Insrer1,
                   Supprimer1,Annuler1,Fermer1],true);
                   EnableItemMenu([modifier1],false);
                   Enregister1.Enabled:=BtnEnregistrer.Enabled;
                  End;
         dsinsert:Begin
                     EnableWinControl([BtnAnnuler,BtnFermer],true);
                     EnableWinControl([BtnInserer,BtnModifier,BtnImprimer],False);
                     BtnSupprimer.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     //BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not((grgrid1.rowcount-1=1)and(not grgrid1.LigneVide(1)))));
                     BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not grgrid1.LigneVide(1)));
                   //Pop menu grille
                   if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,
                       Annuler2,Fermer2],true);
                       EnableItemMenu([Insrer2,modifier2,Imprimer2,Rglement1],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End
                   else
                     Begin
                       EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,
                       Annuler2,Fermer2,Rglement1],true);
                       EnableItemMenu([Insrer2,modifier2,Imprimer2],false);
                       ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End;
                   Supprimer2.Enabled:=BtnSupprimer.Enabled;
                   Enregister2.Enabled:=BtnEnregistrer.Enabled;
                  end;
         dsedit:  Begin
                     EnableWinControl([BtnAnnuler,BtnFermer],true);
                     EnableWinControl([BtnInserer,BtnModifier,BtnImprimer],False);
                     BtnSupprimer.Enabled:=((not grgrid1.rowcount<=2) and (not grgrid1.LigneVide(1)));
                     //BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not((grgrid1.rowcount-1=1)and(not grgrid1.LigneVide(1)))));
                     BtnEnregistrer.Enabled:=((not grgrid1.rowcount<=1)and(not grgrid1.LigneVide(1)));
                   //Pop menu grille
                   if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                     Begin
                        EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,
                        Annuler2,Fermer2],true);
                        EnableItemMenu([Insrer2,modifier2,Imprimer2,Rglement1],false);
                        ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End
                   else
                     Begin
                        EnableItemMenu([Aideenligne2,Aide2,Visualisation2,Calculatrice2,
                        Annuler2,Fermer2,Rglement1],true);
                        EnableItemMenu([Insrer2,modifier2,Imprimer2],false);
                        ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
                     End;
                   Supprimer2.Enabled:=BtnSupprimer.Enabled;
                   Enregister2.Enabled:=BtnEnregistrer.Enabled;
                  End;
        end;//fin du case etatGrille
end;//fin du case etatpiece
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDuDataset(DMPieces.Piece1.EtatPiece);
 RxLabTitre.Caption:=Self.Caption;
Insrer2.Enabled:=BtnInserer.Enabled;
Annuler2.Enabled:=BtnAnnuler.Enabled;
Fermer2.Enabled:=BtnFermer.Enabled;
Enregister2.Enabled:=BtnEnregistrer.Enabled;
//ComplmentLigne1.Enabled:=DMPieces.Piece1.TVA_A_Gerer;
modifier2.Enabled:=BtnModifier.Enabled;
Supprimer2.Enabled:=BtnSupprimer.Enabled;

Enregister1.Enabled:=BtnEnregistrer.Enabled;
Insrer1.Enabled:=BtnInserer.Enabled;
Annuler1.Enabled:=BtnAnnuler.Enabled;
Fermer1.Enabled:=BtnFermer.Enabled;
modifier1.Enabled:=BtnModifier.Enabled;
Supprimer1.Enabled:=BtnSupprimer.Enabled;

End;



procedure TsaisieP_3.BtnInsererClick(Sender: TObject);
Begin
if DMPieces.Piece1.EtatPiece in [dsinsert,dsedit] then
  Begin
  if Application.MessageBox(Pchar(' Voulez-vous enregistrer cette pièce ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
    BtnEnregistrer.Click
    else
//    BtnAnnulerClick(btnannuler);
    EtatInitial(0,false);
  End;
End;

procedure TsaisieP_3.BtnInsererGrilleClick(Sender: TObject);
var
//ParamLign:TBlocLigne_Obj;
ILigneVide:integer;
Bool1,Bool2:boolean;
Begin
ILigneVide:=GrGrid1.RechercheLigneVide;
   if ILigneVide > 0 then
      begin
        GrGrid1ColExit(grgrid1.col,ligneCurr);
        GrGrid1RowValidate(grgrid1,Bool1,Bool2,grgrid1.col);
        GrGrid1.Row:=ILigneVide;
        GrGrid1RowEnter(GrGrid1,GrGrid1.Row);
       end
       else
       begin
       if not DMEcritures.Ecriture_Isa1.RecherchePremiereLigneTva(ILigneVide) then
         ILigneVide:=GrGrid1.rowcount;
       Creation.TypeLigne:='V';
       creation.NumLigne:=ILigneVide;
       GrGrid1.GenereLigne(true,ILigneVide,1);
       end;
GrGrid1.setfocus;
GrGrid1StateChange(GrGrid1.EtatGrille);
End;

procedure TsaisieP_3.BtnEnregistrerClick(Sender: TObject);
begin
//Vérifier les interactions entre lignes et
//Enregistre les infos dans la vraie table
try//finally
  GestionGauge(100,gauge1,1000,gauge1.MinValue,'Validation de la pièce',e.TypeClient=cl_isa);
    try
      if not VerificationTvaAvantEnregistrement(gauge1) then abort;
       if (GrGrid1.LigneVide(1))then
         begin
           showmessage('La pièce est vide, vous devez la compléter.');
           abort;
         end;
       EnregistrementComplet(DMPieces.Piece1.Reglement);
  GestionGauge(gauge1.MaxValue-(gauge1.PercentDone*10),gauge1,-1,-1,'',e.TypeClient=cl_isa);

       if ((DMPieces.Piece1.IDJournal in [4])and(E.RemiseAuto)and (str_position_caseInsensitive('Remise',dmpieces.Piece1.libelle)<>0) and
          (Application.MessageBox(Pchar('Voulez-vous imprimer la remise ?'),'Confirmation',MB_ICONINFORMATION +MB_YESNO+MB_DEFBUTTON1)=mryes)) then
          EditionDesRemisesL(C_EditionSimple,false,dmpieces.Piece1.Reference,nil);
       EtatInitial(0,false);
    except
    //grgrid1.SetFocus;
    GrGrid1StateChange(grgrid1.EtatGrille);
    abort;
    end;
  if RxChListCpt.Items.Count <>0 then
    //vider liste pour quelle soit recréer si besoin en étant raffraîchit
    RxChListCpt.Items.Clear;
ModalResult:=mrok;
finally
  GestionGauge(0,gauge1,0,0,'',false);
end;//fin finally
end;

procedure TsaisieP_3.BtnModifierClick(Sender: TObject);
begin
GrEnTete.CreateEditor;
GrEnTete.ShowEditor;
end;


procedure TsaisieP_3.BtnModifierGrilleClick(Sender: TObject);
begin
  GrGrid1.EtatGrille:=dsedit;
  GrGrid1StateChange(GrGrid1.EtatGrille);
  if GrGrid1.InplaceEditor = nil then
   GrGrid1.CreateEditor;
  GrGrid1.ShowEditor;
end;

procedure TsaisieP_3.BtnSupprimerGrilleClick(Sender: TObject);
begin
  gestionSuppression(ligneCurr);
end;


procedure TsaisieP_3.gestionSuppression(ligne:integer);
var
FRow:integer;
Begin
   if grgrid1.RowCount-1=1 then
   begin
   FRow:=1;
   GrGrid1BeforeSupprLigne(self,FRow,FRow);
   GrGrid1SupprLigne(self,FRow,FRow);
   DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
      if not empty(grgrid1.Rows[1].Text)then
      grgrid1.Rows[1].Clear;
   GrGrid1RowEnter(grgrid1,FRow);
   end
   else
   grgrid1.SupprimeLigne(ligne);

   GestionInfoCorps(grgrid1.Cells[1,grgrid1.row]);
End;


procedure TsaisieP_3.BtnSupprimerClick(Sender: TObject);
var
GererTva,SupprOD:boolean;
begin
//si on est sur l'entête
GererTva:=false;
SupprOD:=false;
try{finally}
  try
  //regarder si Pièce décrite dans les immos
  //si oui, vérifier si amortissable
  TableGereStartTransaction(DMPieces.Piece1.TablePiece);
  if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,-1).retour= false then abort;
if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
   Begin
      //si piece non modifiable
     showmessage('Cette pièce n''est pas modifiable ');
     abort;
   End
else
  Begin
    if Application.MessageBox(Pchar('Voulez-vous réellement supprimer cette pièce ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
      abort;
  End;

   TableGereStartTransaction(DMPieces.Piece1.TablePiece);
   
   if ((DMPieces.Piece1.IDJournal in [1,2,4,3])and(((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)))then
   Begin //si piece de vente ou d'achat ou de banque
     if ((((DMPieces.Piece1.InfosVerrouillage.PieceVerrouillee)))or(((DMPieces.Piece1.InfosPointage.infosPointage.TvaSurE)and(DMPieces.Piece1.InfosVerrouillage.PeriodeVerrouillee)))) then
       Begin
          GererTva:=true;
          SupprOD:=((DMPieces.Piece1.InfosVerrouillage.Deverrouillable)and(DMPieces.Piece1.InfosVerrouillage.PeriodeDeverrouillable));
       End;
     if GererTva then
        Begin //si on doit gerer la tva
          if not SupprOD then
            Begin //si on ne peut pas modifier l'entête
                Application.MessageBox(Pchar('Attention, cette pièce est verrouillée et non déverrouillable, Vous ne pouvez pas la supprimer ?'),'Attention',MB_ICONEXCLAMATION +MB_OK);
                if not (ParamUtil.TypeMaintenanceSpeciale='pointage_'+IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82))then
                begin
                abort;
                end;
            End//fin  si on ne peut pas modifier l'entête
          else
            Begin //si on peut modifier l'entête, on deverrouille la période déclarée
              if Application.MessageBox(Pchar('Attention, cette pièce est verrouillée, si vous la supprimez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! Voulez-vous la supprimer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                 //************on doit supprimer la dernière déclaration et déverrouiller la période
                  if not (DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false)).retour then
                    if not (ParamUtil.TypeMaintenanceSpeciale='pointage_'+IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82))then
                     abort;
                 end
                 else
                  begin
                    abort;
                  end;
            End; //fin si on peut modifier l'entête, on deverrouille la période déclarée
        End;//fin si on doit gerer la tva
   end;//fin si piece de vente ou d'achat ou de banque
if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
  begin
    if Application.MessageBox(Pchar('Attention,si vous choisissez de supprimer cette pièce, les pointages associés seront supprimés, Confirmez-vous votre choix !'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
      abort;
  end;
    if Gestionimmos.supprimerImmos then
      begin
      DataModuleImmos.taDetailImmo.Open;  { isa  le  18/07/05 }
//      DataModuleImmos.TableImmos.Open;
         while Gestionimmos.ImmosASupprimer.Count<>0 do
         begin
         DeFiltrageDataSet(DMRech.TaImmosRech);
         DataModuleImmos.SuppressionImmo(DMRech.TaImmosRech,StrToInt_Lgr(Gestionimmos.ImmosASupprimer.Strings[0]),true,false);
         Gestionimmos.ImmosASupprimer.Delete(0);
         end;
           if not DMImmo_Clo.SuppressionPieceDeDotationAmortissement(Gestionimmos.reference) then abort;
            //DMPieces.SuppressionOD(Gestionimmos.reference);
      end;
    if Gestionimmos.supprimerCessions then
      begin
      DataModuleImmos.TableImmos.Open;
         while Gestionimmos.CessionsASupprimer.Count<>0 do
         begin
         DeFiltrageDataSet(DMRech.TaImmosRech);
         DataModuleImmos.SuppressionImmo(DMRech.TaImmosRech,StrToInt_Lgr(Gestionimmos.CessionsASupprimer.Strings[0]),false,false);
         Gestionimmos.CessionsASupprimer.Delete(0);
         end;
         if not empty(Gestionimmos.reference) then
            DMPieces.SuppressionOD(Gestionimmos.reference);
      DataModuleImmos.TableImmos.close;
      end;

       DMPieces.SuppressionPieceEcriture(DMPieces.Piece1.Reference,DMPieces.Piece1);
       TableGereCommit(DMPieces.Piece1.TablePiece);
       TableGereCommit(DMBalance.TaBalance);
       EtatInitial(0,false);
  except
     TableGereRollBack(DMPieces.Piece1.TablePiece);
     TableGereRollBack(DMBalance.TaBalance);
  end;
finally
  if RxChListCpt.Items.Count <>0 then
    //vider liste pour quelle soit recréer si besoin en étant raffraîchit
    RxChListCpt.Items.Clear;
end;//fin du try finally
end;

procedure TsaisieP_3.BtnFermerClick(Sender: TObject);
begin
BtnFermer.SetFocus;
  if BtnFermer.Enabled then
  begin
  //avant de fermer, si en modification ou insertion demander si on veut enregistrer
  self.Close;
  end;
end;


procedure TsaisieP_3.BtnAnnulerControleClick(Sender: TObject);
begin
if e.TypeClient=cl_isa then
  ParamUtil.TypeMaintenanceSpeciale:=InputBox('Saisir le mot de passe','','pointage_'+IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82))
else
  ParamUtil.TypeMaintenanceSpeciale:=InputBox('Saisir le mot de passe','','********');
if ParamUtil.TypeMaintenanceSpeciale='pointage_'+IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82) then
  BtnAnnulerControle.Caption:='Contrôle désactivé'
else
  BtnAnnulerControle.Caption:='Contrôle activé';
end;

////////////////////////////////////////////////////////////////////////////
/////////////*********GESTION DE LA GRILLE ***********///////////////////////
////////////////////////////////////////////////////////////////////////////


procedure TsaisieP_3.GrGrid1NewLigne(Sender: TObject;ARow:integer);
var
ParamLign:TParamLigne_Obj;
//i:integer;
begin
DMEcritures.Ecriture_Isa1.InitialiseParamLigne_Obj(lastParamLigne);
DMEcritures.Ecriture_Isa1.InitialiseParamLigne_Obj(ParamLign);

if arow>1 then
  begin
  ParamLign.Ligne:=LigneBlocPrincipal(arow-1);
  Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[arow-1])^.Ligne.Ligne:=ParamLign.Ligne;
  //réinitialise les variables
  ParamLign.Ligne.Appartient:=false;
  ParamLign.Ligne.Derniere:=false;
  end;
ParamLign.Ligne:=LigneBlocPrincipal(arow);
if DMEcritures.Ecriture_Isa1.ListIdentifiant.Count-1<Arow  then { isa  le  25/09/2007}
 DMEcritures.Ecriture_Isa1.ListIdentifiantadd_insert([0,0,0,'','','','','',0,0,false,'T',False,False,true,true,true,False,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);

Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.Ligne:=ParamLign.Ligne;
   try
      try
      if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TypeLigne='T' then
         begin //si ligne créée est du type T
         ParamLign.TVA:=RecupParametreTVA(creation.CodeTva);
         
//         ParamLign.TVA.Compte:=creation.CompteTva;
//         ParamLign.TVA.Libelle:=creation.LibelleTva;
//         ParamLign.TVA.sensCredit:=creation.SensCredit;

         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TVA:=ParamLign.TVA;
         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.sensCredit:=creation.SensCredit;
//         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TVA.CodeTva:=Creation.CodeTva;
//         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TVA.Compte:=creation.CompteTva;
//         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TVA.Libelle:=creation.LibelleTva;

         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TVA.sensCredit:=creation.SensCredit;
         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.Compte:=creation.CompteTva;
          if not GenereLigneTva(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TVA,Arow,creation.MontantDefaut)then
            abort;
         end;//fin si ligne créée est du type T
      finally
      DMEcritures.Ecriture_Isa1.InitialiseCreationLigne_obj(creation);
//      grgrid1.OnRowEnter:=GrGrid1RowEnter;
//      GrGrid1RowEnter(self,grgrid1.row);
      end;//fin du try finally
   except
   grgrid1.SupprimeLigne(lignecurr);//supprime ligne dans grille
   showmessage('Problème à la création d''une ligne TVA'+ Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TypeLigne+' & '+Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TVA.Compte);
   abort;
   end;//fin du try except

end;

procedure TsaisieP_3.GrGrid1SupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
var
Ligne:TBlocLigne_obj;
i:integer;
//rang,
Newcol:integer;
begin
grgrid1.OnColEnter:=nil;
  try
  if DMEcritures.Ecriture_Isa1.ListIdentifiant.Count>=GrGrid1.RowCount then
    begin
      Newcol:=RecupCelluleValide(grgrid1.row,1);
      if Newcol<>-1 then
        grgrid1.NewColonne:=Newcol
      else
        grgrid1.NewColonne:=1;
      grgrid1.col:=grgrid1.NewColonne;
    end;
    if ((DMEcritures.Ecriture_Isa1.ListIdentifiant.Count < GrGrid1.RowCount)and(GrGrid1.RowCount=2)) then
   //   rajouter une nouvelle ligne vierge
     begin
     DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
     grgrid1.col:=1;
     grgrid1.NewColonne:=1;
     end;
  if modif.NewRow<>-1 then //s'il y a une ligne à modifier, on se positionne dessus
   Begin
    if modif.ASupprimer then
     begin
      GrGrid1.SupprimeLigne(modif.NewRow);
      modif.NewRow:=-1;
      modif.ASupprimer:=false;
      modif.SupprAutomatique:=false;
     end;
   End;

   for i:=1 to DMEcritures.Ecriture_Isa1.ListIdentifiant.Count-1 do
   Begin
   Ligne:=LigneBlocPrincipal(i);
   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Ligne.Appartient:=Ligne.Appartient;
   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Ligne.Derniere:=Ligne.Derniere;
   End;
     CalculSolde;
     if DMPieces.Piece1.Modifier_EnAttente then DMPieces.Piece1.Modifier_Confirmer:=true; 
   except
   abort;
   end;//fin du try
grgrid1.OnColEnter:=GrGrid1ColEnter;   
end;

procedure TsaisieP_3.AfficherEcritureSurPieceExistante(LigneCourante:integer);
var
i:integer;
//Tab:variant;
Begin
if ligneCourante=-1 then
begin
  GestionGauge(100,gauge1,-1,0,'Chargement de la pièce',e.TypeClient=cl_isa);

if grGrid1.RowCount>2 then
 Begin
  for i:=1 to grGrid1.RowCount-1 do grGrid1.Rows[i].Clear;
 End;
grGrid1.RowCount:=2;
   i:=1;
   for i:=1 to DMEcritures.Ecriture_Isa1.ListIdentifiant.count-1 do
     begin
     if i>1 then GrGrid1.AjouteLigne;
  GestionGauge((800 div DMEcritures.Ecriture_Isa1.ListIdentifiant.count-1),gauge1,-1,-1,'Chargement des lignes',e.TypeClient=cl_isa);

       if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Typeligne<>'V' then
          begin//si ce n'est pas une ligne vide, alors on remplie la grille
          if not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Tiers) then
            Comptetmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Tiers
          else
            Comptetmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.compte;
          GrGrid1.Cells[1,i]:=Comptetmp;
          GrGrid1.Cells[2,i]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Libelle;
          GrGrid1.Cells[3,i]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Qt1;
          GrGrid1.Cells[4,i]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Qt2;
          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Debit<>0 then
            GrGrid1.Cells[5,i]:=FormatCurr('0.00',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Debit);
          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Credit<>0 then
            GrGrid1.Cells[6,i]:=FormatCurr('0.00',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Credit);
          RecupParamLigne(i,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Typeligne,Comptetmp,true);
          end;//fin si ce n'est pas une ligne vide, alors on remplie la grille
     end;
end
else
   if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Typeligne<>'V' then
      begin//si ce n'est pas une ligne vide, alors on remplie la grille
  GestionGauge(800,gauge1,-1,-1,'Chargement des lignes',e.TypeClient=cl_isa);
          if not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Tiers) then
            Comptetmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Tiers
          else
            Comptetmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.compte;
          GrGrid1.Cells[1,ligneCourante]:=Comptetmp;
          GrGrid1.Cells[2,ligneCourante]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Libelle;
          GrGrid1.Cells[3,ligneCourante]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Qt1;
          GrGrid1.Cells[4,ligneCourante]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Qt2;
          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Debit<>0 then
            GrGrid1.Cells[5,ligneCourante]:=FormatCurr('0.00',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Debit);
          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Credit<>0 then
            GrGrid1.Cells[6,ligneCourante]:=FormatCurr('0.00',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Credit);
          RecupParamLigne(ligneCourante,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCourante])^.Ligne.Typeligne,Comptetmp,true);
      end;//fin si ce n'est pas une ligne vide, alors on remplie la grille
 CalculSolde;
End;


procedure TsaisieP_3.GrGrid1ColEnter(OldColonne,NewColonne,NewRow:integer);
var
NewCol:integer;
begin
  try
  grgrid1.oncolenter:=nil;
  grgrid1.OnColExit:=nil;
  grgrid1.OnRowEnter:=nil;
  NewCol:=RecupCelluleValide(newrow,grgrid1.NewColonne);
    if NewCol<>-1 then
      begin
      grgrid1.row:=newrow;
      grgrid1.col:=newcol;
      grgrid1.OldColonne:=newcol;
      abort;
      end;
//   if ((grgrid1.Col=5)and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[newrow])^.Ligne.TypeLigne='T')and(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[newrow])^.Ligne.D)then
  finally
    grgrid1.oncolenter:=GrGrid1ColEnter;
    grgrid1.OnColExit:=GrGrid1ColExit;
    grgrid1.OnRowEnter:=GrGrid1RowEnter;
  end;//fin du try finally
end;



function TsaisieP_3.CtrlSaisiePieceEcriture(Champ:string;FRow,Acol:integer;ColonneSuivante:integer;var Action:boolean):TErreurSaisie;
var
Tab:variant;
Ligne:TBlocLigne_Obj;
vide:boolean;
i:integer;
InfosPiece_SurTypeLigne:TInfosPiece_SurTypeLigne;
Index:integer;
Begin
result.CodeErreur:=0;
result.retour:=true;
vide:=false;
initialiseInfosPiece_SurTypeLigne(InfosPiece_SurTypeLigne);
   if DMPieces.Piece1.EtatPiece in [dsinsert,dsedit,dsbrowse] then
      Begin
          case Acol of
          1:begin//si colonne compte
             case  DMPieces.Piece1.IDJournal of
             1,2:Begin //si journal d'Achat ou de vente
                  case ord(RecupTypeLigneSurCompte(FRow))of
                  84,116:Begin //si typeligne  T
                           if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne<>'T'then
                              begin
                                result.CodeErreur:=10011;
                                result.retour:=false;
                              end;
                         end;//fin si typeligne  T
                   72,104:Begin //si typeligne H
                           //aidecompte filtré en fonction du code journal
                        if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne<>'H'then
                           Begin//si typeligne a changé
                             action:=true;
                             if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne<>'V'then
                               Begin
                                 //probleme voir si message, puis récupérer les nouveaux parametres lignes
                                DMPieces.GestionFiltrageParamCptSurCompte(DMPieces.Piece1.Compte);
                                if ((AideCompteDansContexte(GrGrid1.Cells[1,FRow],GrGrid1,['Rac1'],false,MessDerSub,true,true,true,true,0)=true) and (not Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[GrGrid1.Cells[1,FRow]]).Collectif)and(DMPlan.CptEstPointable(GrGrid1.Cells[1,FRow]))and (DMPieces.CptExclusDeContexte(GrGrid1.Cells[1,ligneCurr],2)=false)) then
                                   Begin
                                   if ord(RecupTypeLigneSurCompte(FRow))in [84,116]then
                                      begin
                                        result.CodeErreur:=10011;
                                        result.retour:=false;
                                        exit;
                                      end;
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complement);
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte:=grgrid1.cells[1,FRow];
//                                   RecupParamLigne(FRow,'H',grgrid1.cells[1,FRow],true);
                                   RecupParamLigne(FRow,'H',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte,true);
                                   //recupérer le CodeTva par défaut du nouveau compte pour remplir le complémentTmp
                                   RenvoieInfoSurTableDiverse(grgrid1.Cells[1,FRow],DMPieces.Piece1.TablePlan,'Compte',['TvaCode'],Tab);
                                   InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(Frow,DMEcritures.Ecriture_Isa1.ListIdentifiant);
                                   //RecupInfosComplementLigne(false,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp,Tab[0],'H',grgrid1.Cells[1,FRow],InfosPiece_SurTypeLigne.Solde);
                                   End //fin si compte dans contexte
                                else
                                   Begin //si compte pas rempli ou pas correct
                                   result.CodeErreur:=1001;
                                   result.retour:=false;
                                   End; //fin si compte pas rempli ou pas correct
                               End
                             else
                               Begin
                                 //sinon récupérer les nouveaux parametres ligne
                                DMPieces.GestionFiltrageParamCptSurCompte(DMPieces.Piece1.Compte);
                                if ((AideCompteDansContexte(GrGrid1.Cells[1,FRow],GrGrid1,['Rac1'],false,MessDerSub,true,true,true,true,0)=true)and (not Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[GrGrid1.Cells[1,FRow]]).Collectif) and (not DMPieces.CptExclusDeContexte(GrGrid1.Cells[1,ligneCurr],2))) then //PB
                                   Begin
                                   if ord(RecupTypeLigneSurCompte(FRow))in [84,116]then
                                      begin
                                        result.CodeErreur:=10011;
                                        result.retour:=false;
                                        exit;
                                      end;
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complement);
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte:=grgrid1.cells[1,FRow];
//                                   RecupParamLigne(FRow,'H',grgrid1.cells[1,FRow],true);
                                   RecupParamLigne(FRow,'H',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte,true);

//                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte:=grgrid1.cells[1,FRow];
                                   //recupérer le CodeTva par défaut du nouveau compte pour remplir le complémentTmp
                                   RenvoieInfoSurTableDiverse(grgrid1.Cells[1,FRow],DMPieces.Piece1.TablePlan,'Compte',['TvaCode'],Tab);
                                   InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(Frow,DMEcritures.Ecriture_Isa1.ListIdentifiant);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.Complement;
                                   //RecupInfosComplementLigne(false,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp,Tab[0],'H',grgrid1.Cells[1,FRow],InfosPiece_SurTypeLigne.Solde);
                                   End //fin si compte dans contexte
                                else
                                   Begin //si compte pas rempli ou pas correct
                                   //Messagebox(0,Pchar('La saisie du compte est obligatoire !!!'),'Erreur de saisie',0);
                                   result.CodeErreur:=1001;
                                   result.retour:=false;
                                   End; //fin si compte pas rempli ou pas correct
                               End;
                           End //fin si typeligne a changé
                           else
                           begin//si typeligne pas changé
                           if ((PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Compte<>GrGrid1.Cells[1,FRow])or((not empty(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.tiers))and(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.tiers<>GrGrid1.Cells[1,FRow])))then
                             begin//si compte a changé
                             action:=true;
                             DMPieces.GestionFiltrageParamCptSurCompte(DMPieces.Piece1.Compte);
                             if ((AideCompteDansContexte(GrGrid1.Cells[1,FRow],GrGrid1,['Rac1'],false,MessDerSub,true,true,true,true,0)=true)and (not Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[GrGrid1.Cells[1,FRow]]).Collectif) and (not DMPieces.CptExclusDeContexte(GrGrid1.Cells[1,ligneCurr],2))) then //PB
                                Begin
                                   if ord(RecupTypeLigneSurCompte(FRow))in [84,116]then
                                      begin
                                        result.CodeErreur:=10011;
                                        result.retour:=false;
                                        exit;
                                      end;
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complement);
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte:=grgrid1.cells[1,FRow];
//                                   RecupParamLigne(FRow,'H',grgrid1.cells[1,FRow],true);
                                   RecupParamLigne(FRow,'H',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte,true);
                                   //recupérer le CodeTva par défaut du nouveau compte pour remplir le complémentTmp
                                   RenvoieInfoSurTableDiverse(grgrid1.Cells[1,FRow],DMPieces.Piece1.TablePlan,'Compte',['TvaCode'],Tab);
                                   InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(Frow,DMEcritures.Ecriture_Isa1.ListIdentifiant);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.Complement;
                                   RecupInfosComplementLigne(false,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp,Tab[0],'H',grgrid1.Cells[1,FRow],InfosPiece_SurTypeLigne.Solde);
                                End //fin si compte dans contexte
                             else
                                Begin //si compte pas rempli ou pas correct
                                //Application.MessageBox(Pchar('La saisie du compte est obligatoire !!!'),'Erreur de saisie',0);
                                result.CodeErreur:=1001;
                                result.retour:=false;
                                End; //fin si compte pas rempli ou pas correct
                             end//fin si compte a changé
                           else
                             Action:=false;//si pas de changement
                           end;//fin si typeligne pas changé
                          if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne<>'H'then
                            begin
                            PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne:='H';
                            PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.ID_Ord:=gestionDernierIDEcriture(dmecritures.Ecriture_Isa1);
                            end;
                          End;//fin si typeligne H
                  86,118:Begin//si typeligne V
                           //Remplacer la ligne de la liste par une ligne vide
                           if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne='H'then
                             Begin//si changement de type de ligne
                             i:=1;
                             while ((i<=grgrid1.RowCount-1)and(not vide)) do
                               begin
                                 if ((grgrid1.LigneVide(i))and(i<>lignecurr))then
                                   vide:=true;
                               inc(i);
                               end;
                             if vide then
                               gestionSuppression(Lignecurr)
                             else
//                             Ligne:=LigneBlocPrincipal(LigneCurr);
//                             if not ((ligne.Appartient)and(ligne.Derniere))then
                               if lignecurr=1 then
                                 gestionSuppression(LigneCurr)
                                 else
                                   Begin
                                     DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],false,true,FRow);
                                     grgrid1.Rows[lignecurr].Clear;
                                   End;
                             end;//fin si changement de type de ligne
                         End;//fin si typeligne V
                  end;//fin du case
                 end; //fin si journal d'Achat ou de vente
               4,3:Begin //si journal de Banque
                 if ((EdPlusTiersCorps.text='+')and(DMPieces.Piece1.IDJournal=4)) then
                   Index:=1
                 else
                   Index:=0;
                  case ord(RecupTypeLigneSurCompte(FRow))of
                  72,104:Begin //si typeligne H
                           //aidecompte filtré en fonction du code journal
                           if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne<>'H'then
                           Begin//si typeligne a changé
                              action:=true;
                              if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne<>'V'then
                                Begin
                                  //probleme voir si message, puis récupérer les nouveaux parametres lignes
                                 DMPieces.GestionFiltrageParamCptSurCompte(DMPieces.Piece1.Compte);
                                 if ((AideCompteDansContexte(GrGrid1.Cells[1,FRow],GrGrid1,['Rac1'],false,MessDerSub,true,true,true,true,Index)=true)and (not Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[GrGrid1.Cells[1,FRow]]).Collectif)) then
                                    Begin
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complement);
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte:=grgrid1.cells[1,FRow];
//                                   RecupParamLigne(FRow,'H',grgrid1.cells[1,FRow],true);
                                   RecupParamLigne(FRow,'H',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte,true);
                                   //recupérer le CodeTva par défaut du nouveau compte pour remplir le complémentTmp
                                   RenvoieInfoSurTableDiverse(grgrid1.Cells[1,FRow],DMPieces.Piece1.TablePlan,'Compte',['TvaCode'],Tab);
                                   InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(Frow,DMEcritures.Ecriture_Isa1.ListIdentifiant);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.Complement;
                                   //RecupInfosComplementLigne(false,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp,Tab[0],'H',grgrid1.Cells[1,FRow],InfosPiece_SurTypeLigne.Solde);
                                    if ((not empty(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.tva.CodeTva))and(copy(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.compte,1,2)<>'44')) then
                                       if Application.MessageBox(Pchar('Attention, ce compte attend de la TVA qui n''est pas gérée dans les opérations diverses, voulez-vous continuer !'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrno then
                                            begin
                                              result.CodeErreur:=1010;
                                              result.retour:=false;
                                            end;
                                    End //fin si compte dans contexte
                                 else
                                    Begin //si compte pas rempli ou pas correct
                                    //Messagebox(0,Pchar('La saisie du compte est obligatoire !!!'),'Erreur de saisie',0);
                                    result.CodeErreur:=1001;
                                    result.retour:=false;
                                    End; //fin si compte pas rempli ou pas correct
                                End
                              else
                                Begin
                                  //sinon récupérer les nouveaux parametres ligne
                                 DMPieces.GestionFiltrageParamCptSurCompte(DMPieces.Piece1.Compte);
                                 if ((AideCompteDansContexte(GrGrid1.Cells[1,FRow],GrGrid1,['Rac1'],false,MessDerSub,true,true,true,true,Index)=true)and (not Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[GrGrid1.Cells[1,FRow]]).Collectif)) then
                                    Begin
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complement);
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte:=grgrid1.cells[1,FRow];
//                                   RecupParamLigne(FRow,'H',grgrid1.cells[1,FRow],true);
                                   RecupParamLigne(FRow,'H',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte,true);
                                   //recupérer le CodeTva par défaut du nouveau compte pour remplir le complémentTmp
                                   RenvoieInfoSurTableDiverse(grgrid1.Cells[1,FRow],DMPieces.Piece1.TablePlan,'Compte',['TvaCode'],Tab);
                                   InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(Frow,DMEcritures.Ecriture_Isa1.ListIdentifiant);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.Complement;
                                   //RecupInfosComplementLigne(false,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp,Tab[0],'H',grgrid1.Cells[1,FRow],InfosPiece_SurTypeLigne.Solde);
                                    if ((not empty(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.tva.CodeTva))and(copy(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.compte,1,2)<>'44')) then
                                       if Application.MessageBox(Pchar('Attention, ce compte attend de la TVA qui n''est pas gérée dans les opérations diverses, voulez-vous continuer !'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrno then
                                            begin
                                              result.CodeErreur:=1010;
                                              result.retour:=false;
                                            end;
                                     End //fin si compte dans contexte
                                 else
                                    Begin //si compte pas rempli ou pas correct
                                    //Messagebox(0,Pchar('La saisie du compte est obligatoire !!!'),'Erreur de saisie',0);
                                    result.CodeErreur:=1001;
                                    result.retour:=false;
                                    End; //fin si compte pas rempli ou pas correct
                                End;
                           End //fin si typeligne a changé
                           else
                           begin//si typeligne pas changé
                           if ((PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Compte<>GrGrid1.Cells[1,FRow])or((not empty(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.tiers))and(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.tiers<>GrGrid1.Cells[1,FRow])))then
                             begin//si compte a changé
                                action:=true;
                                DMPieces.GestionFiltrageParamCptSurCompte(DMPieces.Piece1.Compte);
                                if ((AideCompteDansContexte(GrGrid1.Cells[1,FRow],GrGrid1,['Rac1'],false,MessDerSub,true,true,true,true,Index)=true)and (not Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[GrGrid1.Cells[1,FRow]]).Collectif)) then
                                   Begin
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complement);
                                   DMEcritures.Ecriture_Isa1.InitialiseComplement_Obj(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte:=grgrid1.cells[1,FRow];
//                                   RecupParamLigne(FRow,'H',grgrid1.cells[1,FRow],true);
                                   RecupParamLigne(FRow,'H',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.compte,true);
                                   //recupérer le CodeTva par défaut du nouveau compte pour remplir le complémentTmp
                                   RenvoieInfoSurTableDiverse(grgrid1.Cells[1,FRow],DMPieces.Piece1.TablePlan,'Compte',['TvaCode'],Tab);
                                   InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(Frow,DMEcritures.Ecriture_Isa1.ListIdentifiant);
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.Complement;
                                   //RecupInfosComplementLigne(false,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[FRow])^.Ligne.complementTmp,Tab[0],'H',grgrid1.Cells[1,FRow],InfosPiece_SurTypeLigne.solde);
                                    if ((not empty(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.tva.CodeTva))and(copy(PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.compte,1,2)<>'44')) then
                                       if Application.MessageBox(Pchar('Attention, ce compte attend de la TVA qui n''est pas gérée dans les opérations diverses, voulez-vous continuer !'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mrno then
                                            begin
                                              result.CodeErreur:=1010;
                                              result.retour:=false;
                                            end;
                                   End //fin si compte dans contexte
                                else
                                   Begin //si compte pas rempli ou pas correct
                                   //Application.MessageBox(Pchar('La saisie du compte est obligatoire !!!'),'Erreur de saisie',0);
                                   result.CodeErreur:=1001;
                                   result.retour:=false;
                                   End; //fin si compte pas rempli ou pas correct
                             end//fin si compte a changé
                           else
                             Action:=false;//si pas de changement
                           end;//fin si typeligne pas changé
                           if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne<>'H'then
                            begin
                            PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne:='H';
                            PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.ID_Ord:=gestionDernierIDEcriture(dmecritures.Ecriture_Isa1);
                            end;
                          End;//fin si typeligne H
                  86,118:Begin//si typeligne V
                           //Remplacer la ligne de la liste par une ligne vide
                           if PIdentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne='H'then
                             Begin//si changement de type de ligne
                             i:=1;
                             while ((i<=grgrid1.RowCount-1)and(not vide)) do
                               begin
                                 if ((grgrid1.LigneVide(i))and(i<>lignecurr))then
                                   vide:=true;
                               inc(i);
                               end;
                             if vide then
                               gestionSuppression(Lignecurr)
                             else
                               if lignecurr=1 then
                                 gestionSuppression(LigneCurr)
                                 else
                                   Begin
                                     DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],false,true,FRow);
                                     grgrid1.Rows[lignecurr].Clear;
                                   End;
                             end;//fin si changement de type de ligne
                         End;//fin si typeligne V
                  end;//fin du case
                 end; //fin si journal de Banque
               end;//fin du Case DMPieces.Piece1.IDJournal
          GestionInfoCorps(grgrid1.Cells[1,grgrid1.row]);
          end;//fin si colonne compte
          2: if ((trim(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Libelle)<>trim(champ))or(empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Libelle))) then
          case ord(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne)of //champ libelle
      72,104,88,122:Begin //si typeligne H ou X
                    if ((not empty(grgrid1.Cells[1,FRow]))or (ColonneSuivante<>1))then
                       begin //si compte rempli
                         //Si Libellé vide, remplie par défaut
                         if empty(champ)then //si champ libelle vide
                            begin
                              if not empty(DMPieces.Piece1.DernierLibelleSaisi)then
                                 grgrid1.Cells[Acol,FRow]:=DMPieces.Piece1.DernierLibelleSaisi
                              else
                               begin
                               if copy(grgrid1.Cells[1,FRow],1,1)='+' then
                                  grgrid1.Cells[Acol,FRow]:=Infos_TInfosTiers(DMRech.TaTiersRech,'Tiers',[grgrid1.Cells[1,FRow]]).Nom
                               else
                                  grgrid1.Cells[Acol,FRow]:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[grgrid1.Cells[1,FRow]]).Libelle;
                               end;
                            dmpieces.Piece1.DernierLibelleSaisi:=grgrid1.Cells[Acol,FRow];
                            end
                         else
                            Begin //si champ libelle rempli
                              if trim(champ)='*' then
                                 Begin//si champ libelle rempli avec une *
                                   if copy(grgrid1.Cells[1,FRow],1,1)='+' then
                                  grgrid1.Cells[Acol,FRow]:=Infos_TInfosTiers(DMRech.TaTiersRech,'Tiers',[grgrid1.Cells[1,FRow]]).Nom
                               else
                                  grgrid1.Cells[Acol,FRow]:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[grgrid1.Cells[1,FRow]]).Libelle;
                                 End //fin si champ libelle rempli avec une *
                            End;//fin si champ libelle rempli
                         if empty(grgrid1.Cells[Acol,FRow]) then
                           Begin //si libelle vide
                           Application.MessageBox(Pchar('La saisie du Libellé est obligatoire !!!'),'Erreur de saisie',0);
                           result.CodeErreur:=2001;
                           result.retour:=false;
                           End //fin si libelle vide
                         else
                           DMPieces.Piece1.DernierLibelleSaisi:=grgrid1.Cells[Acol,FRow];
                         end; //fin si compte rempli
                    if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Libelle=grgrid1.Cells[Acol,FRow]    then
                      action:=false
                    else
                      action:=true;
                    Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Libelle:=grgrid1.Cells[Acol,FRow];
                    End;//fin si champ libelle
             84,116:Begin
                     if empty(champ)then //si champ libelle vide
                       begin
                          if not empty(dmpieces.Piece1.DernierLibelleSaisi) then
                            grgrid1.Cells[Acol,FRow]:=dmpieces.Piece1.DernierLibelleSaisi
                          else
                          if not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TVA.Libelle) then
                             grgrid1.Cells[Acol,FRow]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TVA.Libelle
                             else
                             grgrid1.Cells[Acol,FRow]:=RenvoieInfoSurTableDiverse(grgrid1.Cells[1,FRow],DMPieces.Piece1.TablePlan,'Compte',['Libelle'],Tab);
                       dmpieces.Piece1.DernierLibelleSaisi:=grgrid1.Cells[Acol,FRow];
                       end
                    else //si champ libelle rempli
                       if trim(champ)='*' then
                          Begin //si champ libelle rempli avec *
                          if not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TVA.Libelle) then
                             grgrid1.Cells[Acol,FRow]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TVA.Libelle
                             else
                             grgrid1.Cells[Acol,FRow]:=RenvoieInfoSurTableDiverse(grgrid1.Cells[1,FRow],DMPieces.Piece1.TablePlan,'Compte',['Libelle'],Tab);
                          End;//fin si champ libelle rempli avec *
                    if empty(grgrid1.Cells[Acol,FRow]) then
                      Begin
                      Application.MessageBox(Pchar('La saisie du Libellé est obligatoire !!!'),'Erreur de saisie',0);
                      result.CodeErreur:=2001;
                      result.retour:=false;
                      End
                    else
                      DMPieces.Piece1.DernierLibelleSaisi:=grgrid1.Cells[Acol,FRow];
                    if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Libelle=grgrid1.Cells[Acol,FRow]    then
                      action:=false
                    else
                      action:=true;
                    Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Libelle:=grgrid1.Cells[Acol,FRow];
                    End;//fin si champ libelle
             end;//fin du case typeligne
          3:Begin
             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Qt1=grgrid1.Cells[Acol,FRow] then
               action:=false
             else
               action:=true;
             Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Qt1:=grgrid1.Cells[Acol,FRow];
            End;
          4:Begin
             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Qt2=grgrid1.Cells[Acol,FRow] then
               action:=false
             else
               action:=true;
             Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Qt2:=grgrid1.Cells[Acol,FRow];
            End;
          5:Begin//si champ Debit
            if not VerifNumeric(champ).Vide then
               champ:=currtostr(StrToCurr_Lgr(champ))
             else
               champ:='0';
            if ((currtostr(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Debit)<>champ)or(champ='0'))then
               begin//le champ debit a changé
                 case ord(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne)of //champ libelle
          72,104,84,116,
          88,120:Begin //si typeligne H ou X ou T
                  if not VerifNumeric(champ).VideOUZero then //PB
                    begin //si champ rempli
                    if not VerifNumeric(grgrid1.Cells[6,FRow]).VideOUZero then  //PB
                        Begin //si champ suivant rempli
                        Application.MessageBox(Pchar('Vous ne pouvez pas Saisir un montant en Débit et en Crédit, vous devez choisir un sens !!!'),'Erreur de saisie',0);
                        result.CodeErreur:=5001;
                        result.retour:=false;
                        End //fin si champ suivant rempli
                    end; //fin si champ rempli
                 if not VerifNumeric(grgrid1.Cells[5,FRow]).VideOUZero then
                   begin
                     Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Debit:=StrToCurr_Lgr(grgrid1.Cells[5,FRow]);
                     Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Complement.MontantTva:=arrondi(((arrondi(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Complement.TvaTaux,2)*Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Debit))/100,2);
                   end
                 else
                   begin
                     Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Debit:=0;

                     grgrid1.Cells[5,FRow]:='';
                     if VerifNumeric(grgrid1.Cells[6,FRow]).VideOUZero then
                       Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Complement.MontantTva:=0;
                   end;
                 end;//fin si typeligne H ou X ou T
                 end;//fin du case type
               action:=true;
               end//fin le champ debit a changé
               else
                 action:=false;
             End;//fin si champ Debit
          6:Begin//si champ Credit
             if not VerifNumeric(champ).Vide then
               champ:=currtostr(StrToCurr_Lgr(champ))
             else
               champ:='0';
               if ((currtostr(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Credit)<>champ)or(champ='0'))then
                 begin//le champ credit a changé
                 case ord(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne)of
          72,104,84,116,
          88,120:Begin //si typeligne H ou X ou T
                  if VerifNumeric(champ).VideOUZero then //PB
                     begin //si Credit vide
                    if ((VerifNumeric(grgrid1.Cells[5,FRow]).VideOUZero and (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.TypeLigne<>'T')))then  //PB
                         Begin //si Debit vide
                           if DMPieces.Piece1.Defaut then
                              begin
                              result.CodeErreur:=6001;//les 2 champs sont vides
                              result.retour:=false;
                              end;
                         End; //fin si Debit vide
                     end //fin si Credit vide
                   else
                  if not VerifNumeric(champ).VideOUZero then //PB
                     Begin //si Credit rempli
                     if not VerifNumeric(grgrid1.Cells[5,FRow]).VideOUZero then  //PB
                       Begin
                       Application.MessageBox(Pchar('Vous ne pouvez pas Saisir un montant en Débit et en Crédit, vous devez choisir un sens !!!'),'Erreur de saisie',0);
                       result.CodeErreur:=6002;//les 2 champs sont remplis
                       result.retour:=false;
                       End;
                     End;
                 if not VerifNumeric(grgrid1.Cells[6,FRow]).VideOUZero then
                   begin
                     Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Credit:=StrToCurr_Lgr(grgrid1.Cells[6,FRow]);
                     Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Complement.MontantTva:=arrondi(((arrondi(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Complement.TvaTaux,2)*Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Credit))/100,2);
                   end
                 else
                   begin
                     Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Credit:=0;
                     grgrid1.Cells[6,FRow]:='';
                     if VerifNumeric(grgrid1.Cells[5,FRow]).VideOUZero then
                       Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[FRow])^.Ligne.Complement.MontantTva:=0;
                   end;
                 end; //si typeligne H ou X ou T
                 end;//fin du case type
               action:=true;
               end//fin le champ credit a changé
             else
               action:=false;
            End;//fin si champ Credit
          end;//fin du case Acol
      if action then
         if DMPieces.Piece1.Modifier_EnAttente then
           begin
             DMPieces.Piece1.Modifier_Confirmer:=true;
             DMPieces.Piece1.Modifier_EnAttente:=false;
           end;
      End;//fin etatpiece in [dsinsert,dsbrowse]
End;



procedure TsaisieP_3.GrGrid1ColExit(OldColonne,LastRow: Integer);
var
ctrlSaisieEcriture:TErreurSaisie;
//contenuTmp:string;
newcol:integer;
act:boolean;
begin
newcol:=-1;
act:=true;
try


//si champ compte a changé, initialiser et récupérer les parametres de la ligne
//puis réécrire le type de ligne dans la listesligne
if DMPieces.Piece1.EtatPiece in [dsinsert,dsEdit] then
  Begin //si etatpiece in [dsinsert,dsEdit]
  ctrlSaisieEcriture:=CtrlSaisiePieceEcriture(grgrid1.Cells[grGrid1.OldColonne,LastRow],LastRow,grGrid1.OldColonne,grgrid1.newcolonne,act);
     if  ctrlSaisieEcriture.retour=false then
       case ctrlSaisieEcriture.CodeErreur of
       1000:begin //Problème sur typeLigne
            showmessage('Le typeLigne est erroné');
            abort;
            end;
      10011:begin
            showmessage('Dans les journaux d''achats ou de ventes, la Tva se génère automatiquement, '+#10#13#10#13+'Vous ne pouvez pas saisir de compte de Tva directement');
            abort;
            end;
       1001,1010:begin //compte vide ou typeligne T pas gardée
              showmessage('Le compte '+grgrid1.Cells[grGrid1.OldColonne,LastRow]+' n''est pas cohérent dans ce contexte');
              abort;
            end;
          6001:Begin //les 2 champs sont vides
                 if e.TypeDossier<>VerDiocese then
                   begin //si type version autre
                      try
                      grgrid1.oncolenter:=nil;
                      grgrid1.OnColExit:=nil;
                      grgrid1.OnRowEnter:=nil;

                      newcol:=RecupCelluleValide(lignecurr,5);
                      if newcol=-1 then
                        newcol:=5;
                        grgrid1.row:=lignecurr;
                        grgrid1.col:=newcol;
                        grgrid1.OldColonne:=newcol;
                        //abort;
                      finally
                        grgrid1.oncolenter:=GrGrid1ColEnter;
                        grgrid1.OnColExit:=GrGrid1ColExit;
                        grgrid1.OnRowEnter:=GrGrid1RowEnter;
                      end;//fin du try finally
                   end//fin si type version autre
                   else
                   begin
                   Application.MessageBox(Pchar('Vous devez obligatoirement saisir un montant au Débit ou au Crédit !!!'),'Erreur de saisie',0);
                   grgrid1.SetFocus;
                 abort;
                   end;
               End;
       end;//fin du case codeErreur
  End;//Fin si etatpiece in [dsinsert,dsEdit]
if (grgrid1.OldColonne in [1]) then
begin
   if not empty(grgrid1.Cells[grGrid1.OldColonne,LastRow]) then
     begin
      if grgrid1.Cells[grGrid1.OldColonne,LastRow][1] <> '+' then
        begin
         LaCompteEnCours.Caption:=DMPlan.LibelleDuNumCptPCU(grgrid1.Cells[grGrid1.OldColonne,LastRow]);
         if LaCompteEnCours.Caption='' then
          begin
            LaCompteEnCours.Caption:='Compte inexistant dans votre plan comptable';
            LaCompteEnCours.Font.Color:=clRed;
          end
          else
          Begin
           if DMPlan.PossedeFils(grgrid1.Cells[grGrid1.OldColonne,LastRow]) then
                LaCompteEnCours.Font.Color:=clblack
                else
                LaCompteEnCours.Font.Color:=clGreen;
          End;
        end
        else
        Begin
          LaCompteEnCours.Caption:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[grgrid1.Cells[grGrid1.OldColonne,LastRow]]).Nom;
//          LaCompteEnCours.Caption:=DMTiers.LibelleDuTiers(grgrid1.Cells[grGrid1.OldColonne,LastRow]);
         if LaCompteEnCours.Caption='' then
          begin
            LaCompteEnCours.Caption:='Compte inexistant dans votre plan auxiliaire';
            LaCompteEnCours.Font.Color:=clRed;
          end
          else
          Begin
            LaCompteEnCours.Font.Color:=clGreen;
          End;
        End;

      end
       else LaCompteEnCours.Caption:='';
DernierCompteSaisi:=GrGrid1.Cells[grGrid1.OldColonne,LastRow];
end;

//gérer l'affichage des quantités
if ((grgrid1.col=3)and(not empty(grgrid1.cells[3,lignecurr]))) then                                                                                                                                                                                                                                                                                                                                             
  Begin
    grgrid1.cells[3,lignecurr]:=StrToStr_Lgr(DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.cells[3,lignecurr],
    (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Debit<Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Credit),
    ParametreCompteEcriture.ParamCpt.SensCredit,true,abs((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Debit-Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Credit))),'0');
  end;

if ((grgrid1.col=4)and(not empty(grgrid1.cells[4,lignecurr]))) then
  Begin
    grgrid1.cells[4,lignecurr]:=StrToStr_Lgr(DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.cells[4,lignecurr],
    (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Debit<Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Credit),
    ParametreCompteEcriture.ParamCpt.SensCredit,true,abs((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Debit-Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Credit))),'0');
  end;
//gérer l'affichage des quantités
if (grgrid1.col=5) or (grgrid1.col=6) then
  Begin
    grgrid1.cells[3,lignecurr]:=StrToStr_Lgr(DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.cells[3,lignecurr],
    (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Debit<Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Credit),
    ParametreCompteEcriture.ParamCpt.SensCredit,true,abs((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Debit-Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Credit))),'0');
    grgrid1.cells[4,lignecurr]:=StrToStr_Lgr(DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.cells[4,lignecurr],
    (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Debit<Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Credit),
    ParametreCompteEcriture.ParamCpt.SensCredit,true,abs((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Debit-Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.Credit))),'0');
  end;

except
DMPieces.Piece1.Modifier_EnAttente:=false;
abort;
end;
end;


procedure TsaisieP_3.GrGrid1RowValidate(Sender:TObject;var Valide:boolean;var Action:boolean;LastCol:integer);
var
ctrlSaisieEcriture:TErreurSaisie;
i,newcol:integer;
SensCredit:boolean;
ErreurListe:TerreurListe;
TauxPlan:real;
InfosPiece_SurTypeLigne:TInfosPiece_SurTypeLigne;
begin
try

valide:=true;
Action:=true;
SensCredit:=false;
newcol:=-1;
TauxPlan:=0;
initialiseInfosPiece_SurTypeLigne(InfosPiece_SurTypeLigne);
  if DMPieces.Piece1.EtatPiece in [dsinsert,dsEdit] then
  if not grgrid1.LigneVide(ligneCurr) then
    for i:=1 to grgrid1.ColCount-1 do
     Begin
     ctrlSaisieEcriture:=CtrlSaisiePieceEcriture(grgrid1.Cells[i,ligneCurr],ligneCurr,i,i+1,Action);
        if  ctrlSaisieEcriture.retour=false then
          case ctrlSaisieEcriture.CodeErreur of
          1001,1010:begin //compte vide
               showmessage('Le compte '+grgrid1.Cells[i,ligneCurr]+' n''est pas cohérent dans ce contexte');
               grgrid1.SetFocus;
               abort;
               end;
      10011:begin
            showmessage('Dans les journaux d''achats ou de ventes, la Tva se génère automatiquement, '+#10#13#10#13+'Vous ne pouvez pas saisir de compte de Tva directement');
            abort;
            end;               
          2001:Begin
               grgrid1.SetFocus;
               abort;
               End;
          5001:Begin
               grgrid1.SetFocus;
               abort;
               End;
          6001:Begin //les 2 champs sont vides
                 if e.TypeDossier<>VerDiocese then
                   begin //si type version autre
                      try
                      grgrid1.oncolenter:=nil;
                      grgrid1.OnColExit:=nil;
                      grgrid1.OnRowEnter:=nil;
                      
                      newcol:=RecupCelluleValide(lignecurr,5);
                      if newcol=-1 then
                        newcol:=5;
                        grgrid1.row:=lignecurr;
                        grgrid1.col:=newcol;
                        grgrid1.OldColonne:=newcol;
                        abort;
                      finally
                        grgrid1.oncolenter:=GrGrid1ColEnter;
                        grgrid1.OnColExit:=GrGrid1ColExit;
                        grgrid1.OnRowEnter:=GrGrid1RowEnter;
                      end;//fin du try finally
                   end//fin si type version autre
                   else
                   begin
                   Application.MessageBox(Pchar('Vous devez obligatoirement saisir un montant au Débit ou au Crédit !!!'),'Erreur de saisie',0);
                   grgrid1.SetFocus;
                 abort;
                   end;
               End;
          6002:Begin //les 2 champs sont remplis
               grgrid1.SetFocus;
               abort;
               End;
          end;//fin du case codeErreur
     end;
   try
   if ((valide)and(not grgrid1.LigneVide(ligneCurr))) then
     Begin //si valide
        if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne in ['T','H','X'])and (not(grgrid1.LigneVide(ligneCurr)))) then
        begin//si type H, T ou X
          try
          //Vérifier la liste par rapport à la grille
          ErreurListe:=DMEcritures.Ecriture_Isa1.Verif_Liste_Grille_SurLigne(ligneCurr,DMEcritures.Ecriture_Isa1.ListIdentifiant,GrGrid1);
          if ErreurListe.Retour=false then
            if ((ErreurListe.CodeErreur<>3001)and(ErreurListe.CodeErreur<>3002)) then
               abort;
         except
          showmessage('Problème à l''enregistrement de la ligne ');
            if creation.Acreer then
            begin
            DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(creation.NumLigne);
            grgrid1.SupprimeLigne(creation.NumLigne);
            DMEcritures.Ecriture_Isa1.InitialiseCreationLigne_obj(creation);
            end;
          abort;
          end;//fin du try        
       end;//fin type H, T ou X
   //si validation, regarder s'il s'agit d'une modification, si oui, gérer la modif par
   //rapport aux lignes tva
   if ((valide)and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne in ['H'])) then
     with Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne do
     Begin //si valide et ligne H
      //if action then //enlever le 26-06-03 par isa car autrement il ne se déclenche pas si montant n'a pas changé
       DMEcritures.Ecriture_Isa1.ModificationSuppressionLigneTva('H',modif,GrGrid1);
       CalculSolde;
       if ((modif.ASupprimer)and (modif.NewRow<>-1)) then
       //si on doit supprimer la ligne tva et que
       // NewRow(Ligne à supprimer) est rempli, Suppression de la ligne TVA
       begin
       modif.ASupprimer:=false;
       grgrid1.SupprimeLigne(Modif.NewRow)
       end
       else //si on ne doit pas supprimer la ligne tva et que
         // NewRow(Ligne à modifier) est rempli, positionnement sur la ligne TVA
         if ((modif.ASupprimer=false)and (modif.NewRow<>-1)) then
         begin
         grgrid1.OnRowValidate:=nil;
         grgrid1.row:=modif.NewRow;
         GrGrid1RowEnter(grgrid1,grgrid1.row);
         modif.NewRow:=-1;
         abort;
         end;
     end
     else
       if ((valide)and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='T'))then
         begin
           DMEcritures.Ecriture_Isa1.ModificationSuppressionLigneTva('T',modif,GrGrid1);
           CalculSolde;
           DMEcritures.Ecriture_Isa1.ModificationLigneHorsTaxesSurProrataTva(lignecurr,GrGrid1,false);
         end;

   modif.NewRow:=-1;
   MessDerSub:=true;
   if valide then
    Begin
     CalculSolde;
    End;

     End //fin si valide
   finally
   grgrid1.OnRowValidate:=GrGrid1RowValidate;
   end;//fin du try finally
except
DMPieces.Piece1.Modifier_EnAttente:=false;
abort;
end;
//showmessage('annulLigneRowValidate');
end;


procedure TsaisieP_3.GrGrid1RowEnter(Sender: TObject;NewRow:integer);
var
NewCol:integer;
begin
GestionInfoCorps(grgrid1.Cells[1,NewRow]);
DMEcritures.Ecriture_Isa1.InitialiseParamCompte_obj(ParametreCompteEcriture);
modif.ASupprimer:=false;
modif.NewRow:=-1;
modif.SupprAutomatique:=false;
NewCol:=-1;
GRCompteTmp:='';
GRDebitTmp:='';
GRCreditTmp:='';
LigneCurr:=NewRow;



if not grgrid1.LigneVide(ligneCurr)then
Begin
lastParamLigne.TVA:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA;
lastParamLigne.init:=true;
End;
/////récupération des valeurs contenues dans la ligne en y entrant pour comparaison en sortant
if ((not grgrid1.LigneVide(LigneCurr))and (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.TypeLigne<>'T')) then
   begin //si ligne pas vide et pas T

   GRCompteTmp:=grgrid1.Cells[1,LigneCurr];
   GRDebitTmp:=grgrid1.Cells[5,LigneCurr];
   GRCreditTmp:=grgrid1.Cells[6,LigneCurr]
   end;

if not grgrid1.LigneVide(LigneCurr) then
   begin //si ligne pas vide
     RecupererParametresLignes(ligneCurr);
   end;//fin si ligne rempli
GestionDesUnites;
  try
    grgrid1.OnColEnter:=nil;
    grgrid1.OnColExit:=nil;
    grgrid1.OnRowEnter:=nil;
    if((grgrid1.col=grgrid1.NewColonne)and(grgrid1.row<>NewRow)) then
      newcol:=RecupCelluleValide(NewRow,grgrid1.NewColonne);
    if newcol<>-1 then
      begin
      grgrid1.NewColonne:=newcol;
      if grgrid1.row<=grgrid1.rowcount-1 then
        begin
        grgrid1.col:=newcol;
        grgrid1.row:=newrow;
        end;
      end;
  finally
    grgrid1.Repaint;
    grgrid1.OnColEnter:=GrGrid1ColEnter;
    grgrid1.OnColExit:=GrGrid1ColExit;
    grgrid1.OnRowEnter:=GrGrid1RowEnter;
  end;//fin du try finally
end;


function TsaisieP_3.LigneBlocPrincipal(LignCourante:integer):TBlocLigne_obj;
var
LigneSuivante,PremiereTVA:integer;
Begin
result.Appartient:=true;
result.Derniere:=false;
    if DMEcritures.Ecriture_Isa1.RecherchePremiereLigneTva(PremiereTVA) then
        begin
        result.Appartient:= PremiereTVA>LignCourante;
        LigneSuivante:= LignCourante+1;
        if (result.Appartient)then
            result.Derniere:=LigneSuivante=PremiereTVA
         else
            result.Derniere:=LignCourante=grgrid1.RowCount-1;
        End
        else
        result.Derniere:=LignCourante=grgrid1.RowCount-1;
End;




function TsaisieP_3.GenereLigneTva(ParamTVA:TRecupParamTva_obj;NewLigne:integer;MontantDefaut:currency):boolean;
Begin //boucle sur bloc hors taxes
GrGrid1.OnColExit:=nil;
GrGrid1.OnColenter:=nil;
  grgrid1.Cells[1,NewLigne]:=ParamTVA.Compte;
  grgrid1.Cells[2,NewLigne]:=DMPieces.Piece1.Libelle;
  if ParamTVA.sensCredit then
    begin
      GrGrid1.cells[6,newligne]:=e.FormatCurrSansDevise(MontantDefaut);
      GrGrid1.col:=6;
    end
    else
      GrGrid1.cells[5,newligne]:=e.FormatCurrSansDevise(MontantDefaut);
  result:=true;
  if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[NewLigne])^.Ligne.TypeLigne='T')and(copy(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[NewLigne])^.Ligne.TVA.CodeTva,1,1)='V'))then
    GrGrid1.col:=2;
  GrGrid1.OnColExit:=GrGrid1ColExit;
  GrGrid1.OnColenter:=GrGrid1ColEnter;
  GestionDesUnites;
  CalculSolde;
End;


function TsaisieP_3.RecupParametreTVA(CodeTva:string):TRecupParamTva_obj;
var
RecupMiniMaxTva:TRecupMiniMaxTva;
Begin //boucle sur bloc hors taxes
result.Retour:=true;
RecupMiniMaxTva:=FTvaRecupMiniMaxTva(CodeTva);
result.Compte:=RecupMiniMaxTva.Compte;
result.CodeTva:=RecupMiniMaxTva.TvaCode;
result.Libelle:=RecupMiniMaxTva.Libelle;
result.TauxMin:=RecupMiniMaxTva.Taux_Inf;
result.TauxMax:=RecupMiniMaxTva.Taux_Supp;
result.Compte:=RecupMiniMaxTva.Compte;

//result:=DMEcritures.Ecriture_Isa1.MinMaxTva(DMTVACode.TaTvaCode,'TvaCode',CodeTva,'Taux_Inf','Taux_Supp','TvaCode','Compte','Libelle');
   if empty(result.Compte) then
   result.retour:=false;
end;


procedure TsaisieP_3.GrGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
ctrlSaisieEcriture:TErreurSaisie;
PremiereTva,i,ColRemplie:integer;
validation,Act,Possibilite_Affectation:boolean;
ParamLign:TBlocLigne_obj;
NewCol:integer;
vide:boolean;
begin
if ((key = vk_up)or(key = vk_down)) then
  begin
    if (grgrid1.col in [5]) then
      begin
           if not empty(grgrid1.cells[5,lignecurr]) then grgrid1.cells[5,lignecurr] :=e.FormatCurrSansDevise(StrToCurr_Lgr(grgrid1.cells[5,lignecurr]));
      end;
    if (grgrid1.col in [6]) then
      begin
          if not empty(grgrid1.cells[6,lignecurr]) then grgrid1.cells[6,lignecurr] :=e.FormatCurrSansDevise(StrToCurr_Lgr(grgrid1.cells[6,lignecurr]));
      end;
  end;


if key=45 then key:=0;
//if ((DMEcritures.Ecriture_Isa1.ListIdentifiant.Count>2)and (not grgrid1.LigneVide(2)))then
// Possibilite_Affectation:=false
//else
  Possibilite_Affectation:=e.Possibilite_Affectation;
DMEcritures.Ecriture_Isa1.InitialiseCreationLigne_obj(creation);
validation:=true;
Act:=false;
ColRemplie:=-1;
NewCol:=-1;
vide:=false;
if ((grgrid1.col=5) and (not empty(grgrid1.cells[5,LigneCurr]))and (grgrid1.cells[5,LigneCurr]<>'0')) then
ColRemplie:=5;
if ((grgrid1.col=6) and (not empty(grgrid1.cells[6,LigneCurr]))and (grgrid1.cells[6,LigneCurr]<>'0')) then
ColRemplie:=6;
if ((grgrid1.col=5) and (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.TypeLigne='T')) then
ColRemplie:=5;
if ((grgrid1.col=6) and (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.TypeLigne='T')) then
ColRemplie:=6;
if ((grgrid1.col=2) and (not empty(grgrid1.cells[2,LigneCurr]))and (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.TypeLigne='T')and(copy(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.tva.CodeTva,1,1)='V')) then
ColRemplie:=2;
if Possibilite_Affectation then
  Possibilite_Affectation:=((((key=vk_return)or((key=vk_down)and(notToucheKeyDownKeyUp=false))or(key=vk_tab)))and(colremplie in [5,6]));
try
  //Si pièce de banque, affichage des pièces d'achat ou vente pointables avec
if ((Possibilite_Affectation)and(DMPieces.Piece1.IDJournal in [4])and(((dmplan.CptEstPointable(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Compte)))or(not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Tiers)))) then
Begin
  GrGrid1RowValidate(self,Validation,Act,grgrid1.col);
  Rglement1Click(nil);
End;
except
  //
end;

///
//modification spéciale d'un montant tva sur Ventes avec borne mini et maxi
if ((((key=107))or(key=109))and(Shift=[ssCtrl])and (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.TypeLigne='T')and(copy(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.tva.CodeTva,1,1)='V'))then
  Begin
    GrGrid1RowValidate(self,Validation,Act,grgrid1.col);
    if key=107 then//+1 sur le montant tva
      Begin
        if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.SensCredit then
          begin
            Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Credit:=DMEcritures.Ecriture_Isa1.Recup_MontantTva_Valide(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Credit,0.01,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.tva).MontantTva;
            grgrid1.cells[6,LigneCurr]:=e.FormatCurrSansDevise(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Credit);
          end
        else
          Begin
            Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Debit:=DMEcritures.Ecriture_Isa1.Recup_MontantTva_Valide(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Debit,0.01,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.tva).MontantTva;
            grgrid1.cells[5,LigneCurr]:=e.FormatCurrSansDevise(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Debit);
          End;
      End;
    if key=109 then//-1 sur le montant tva
      Begin
        if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.SensCredit then
          begin
            Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Credit:=DMEcritures.Ecriture_Isa1.Recup_MontantTva_Valide(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Credit,-0.01,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.tva).MontantTva;
            grgrid1.cells[6,LigneCurr]:=e.FormatCurrSansDevise(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Credit);
          end
        else
          Begin
            Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Debit:=DMEcritures.Ecriture_Isa1.Recup_MontantTva_Valide(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Debit,-0.01,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.tva).MontantTva;
            grgrid1.cells[5,LigneCurr]:=e.FormatCurrSansDevise(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.Debit);
          End;
      End;
  GrGrid1RowValidate(self,Validation,Act,grgrid1.col);{ isa  le  23/01/04 }    
  key:=vk_cancel;
  End;

//si possibilité de validation, transforme la key en vk_down pour gérer la génération des lignes
if (((key=Vk_return)or(key=Vk_Tab))and ((grgrid1.col=ColRemplie)or(grgrid1.col=6))) then
begin
 key:=vk_down;
 notToucheKeyDownKeyUp:=true;
 GrGrid1.KeyDown(key,shift);
 abort;
end;
if ((key in [Vk_return,vk_tab])and (grgrid1.LigneVide(LigneCurr)))then
begin
 key:=vk_down;
 notToucheKeyDownKeyUp:=true;
 GrGrid1.KeyDown(key,shift);
 abort;
end;
if DMPieces.Piece1.IDJournal in [1,2]then
   begin
   if (key=vk_down)then
      begin//si appuie sur (entree et on est sur 1ere colonne) ou (Vk_down )
      creation:=DMPieces.RecherchePossibiliteCreationLigne(ParametreCompteEcriture,-1);
      ParamLign:=LigneBlocPrincipal(LigneCurr);
         if ((GrGrid1.LigneVide(LigneCurr)) and (DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('H','',2)<>-1)) then
              Begin//et ligne courante vide + pas la premiere ligne
                if ((not creation.Existe)and (creation.Acreer))then
                   begin //s'il y a une ligne tva à créer qui n'existe pas déjà, on déclenche la
                     GrGrid1.OnKeyDown:=nil;//on annule la touche à travers (vk_cancel)
                     key:=vk_cancel;
                     GrGrid1.KeyDown(key,shift);
                     GrGrid1.OnKeyDown:=GrGrid1KeyDown;
                     Creation.TypeLigne:='T';
                     creation.NumLigne:=LigneCurr+1;
                     if ((DMPieces.Piece1.PieceModifiable)or(DMPieces.Piece1.SuppressionParticulieres)) then
                     GrGrid1.GenereLigne(true,LigneCurr+1,5);//génération d'une ligne
                   end //fin s'il y a une ligne tva à créer qui n'existe pas déjà
                else
                   if not grgrid1.LigneVide(LigneCurr+1) then
                     begin //si ligne pas vide
                          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr+1])^.Ligne.TypeLigne='T' then
                            NewCol:=2;
                          if NewCol=-1 then
                              begin//si prochaine ligne n'est pas une ligne TVA 'V'
                              if not notToucheKeyDownKeyUp then
                                 begin //si touche keydown
                                   NewCol:=RecupCelluleValide(LigneCurr+1,grgrid1.col);
                                 end//fin si touche keydown
                              else
                                 Begin //si touche valider
                                   if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr+1])^.Ligne.TypeLigne='T' then
                                     NewCol:=2;
                                   if newcol=-1 then
                                     newcol:=1;
                                 End;//fin si touche valider
                              end;//fin si prochaine ligne n'est pas une ligne TVA 'V'
                     end//fin si ligne pas vide
                   else
                     NewCol:=1;
             End//fin ligne courante vide + pas la premiere ligne
             else
             Begin//ligne courante pas vide ou pas la première
               if not(GrGrid1.LigneVide(LigneCurr))then
               Begin //ligne courante pas vide
                 if ParamLign.Appartient then
                 begin //si ligne H, on crée une ligne V vide
                   if ((ParamLign.Derniere) and (GrGrid1.RechercheLigneVide=-1)) then
                   begin
                     //if ((grgrid1.LastRow(grgrid1.row))or(DMPieces.Piece1.Defaut))then
                        //begin
                        GrGrid1.OnKeyDown:=nil;//on annule la touche à travers (vk_cancel)
                        key:=vk_cancel;
                        GrGrid1.KeyDown(key,shift);
                        GrGrid1.OnKeyDown:=GrGrid1KeyDown;
                        GrGrid1RowValidate(self,Validation,Act,grgrid1.col);
                        //if faut récupérer à nouveau la position de la ligne
                        ParamLign:=LigneBlocPrincipal(LigneCurr);
                        if ((ParamLign.Derniere) and (GrGrid1.RechercheLigneVide=-1)) then
                           //if ((grgrid1.LastRow(grgrid1.row))or(DMPieces.Piece1.Defaut))then
                             // begin
                                Creation.TypeLigne:='V';
                                creation.NumLigne:=LigneCurr+1;
                                if ((DMPieces.Piece1.PieceModifiable)or(DMPieces.Piece1.SuppressionParticulieres)) then
                                   GrGrid1.GenereLigne(true,LigneCurr+1,1);
                             // end;
                        //end;
                   end
                   else
                     if (ParamLign.Derniere) then
                       begin
                         grgrid1.row:=GrGrid1.rechercheLigneVide;
                         GrGrid1RowEnter(grgrid1,LigneCurr);
                         abort;
                       end
                     else
                       Begin
                         if not grgrid1.LigneVide(LigneCurr+1) then
                           begin //si ligne pas vide
                          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr+1])^.Ligne.TypeLigne='T' then
                            NewCol:=2;
                          if NewCol=-1 then
                              begin//si prochaine ligne n'est pas une ligne TVA 'V'
                              if not notToucheKeyDownKeyUp then
                                 begin //si touche keydown
                                   NewCol:=RecupCelluleValide(LigneCurr+1,grgrid1.col);
                                 end//fin si touche keydown
                              else
                                 Begin //si touche valider
                                   if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr+1])^.Ligne.TypeLigne='T' then
                                     NewCol:=2;
                                   if newcol=-1 then
                                     newcol:=1;
                                 End;//fin si touche valider
                              end;//fin si prochaine ligne n'est pas une ligne TVA 'V'
                           end//fin si ligne pas vide
                         else
                           NewCol:=1;
                    end;
                 end //fin si ligne H
                 else
                 Begin //si ligne T
                   if ParamLign.Derniere then
                    begin//si derniere ligne T
                      if ((not(creation.Existe)) and (creation.Acreer))then
                      begin //s'il y a une nouvelle ligne tva à créer
                      creation.TypeLigne:='T';
                      creation.NumLigne:=LigneCurr+1;
                      if ((DMPieces.Piece1.PieceModifiable)or(DMPieces.Piece1.SuppressionParticulieres)) then
                         GrGrid1.GenereLigne(true,LigneCurr+1,5);
                      end
                      else
                      if not(creation.Acreer)then
                      Begin //s'il n'y a pas de ligne tva à créer
                       i:=0;
                       repeat
                        inc(i);
                       until ((grgrid1.LigneVide(i))or(grgrid1.LastRow(i)));
                         if grgrid1.LigneVide(i) then
                          begin //on cherche la première ligne vide ou
                          GrGrid1RowValidate(self,Validation,Act,grgrid1.col);
                          grgrid1.row:=i;
                          grgrid1.col:=1;
                          GrGrid1RowEnter(grgrid1,i);
                          abort;
                          end;
                      End;//fin s'il n'y a pas de ligne tva à créer
                    end//fin si derniere ligne T
                   else
                    Begin//si pas derniere ligne T
                      GrGrid1RowValidate(self,Validation,Act,grgrid1.col);
                      if not grgrid1.LigneVide(LigneCurr+1) then
                        begin //si ligne pas vide
                          if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr+1])^.Ligne.TypeLigne='T' then
                            NewCol:=2;
                          if NewCol=-1 then
                              begin//si prochaine ligne n'est pas une ligne TVA 'V'
                              if not notToucheKeyDownKeyUp then
                                 begin //si touche keydown
                                   NewCol:=RecupCelluleValide(LigneCurr+1,grgrid1.col);
                                 end//fin si touche keydown
                              else
                                 Begin //si touche valider
                                   if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr+1])^.Ligne.TypeLigne='T' then
                                     NewCol:=2;
                                   if newcol=-1 then
                                     newcol:=1;
                                 End;//fin si touche valider
                              end;//fin si prochaine ligne n'est pas une ligne TVA 'V'
                        end//fin si ligne pas vide
                      else
                        NewCol:=1;
                    End;//fin si pas derniere ligne T
                 End;//fin si ligne T
               End;// fin ligne courante pas vide
             End;//fin ligne courante pas vide + pas la première
      end;//fin si appuie sur (entree et on est sur 1ere colonne) ou (Vk_down )
   end //fin si journal d'achat ou de vente
   else
   Begin//si autre journal
   if (key=vk_down)then
      begin//si appuie sur (entree et on est sur 1ere colonne) ou (Vk_down )
       if ((GrGrid1.RechercheLigneVide=-1)and(grgrid1.LastRow(grgrid1.row))) then
          begin//si pas de ligne vide trouvée
                 GrGrid1.OnKeyDown:=nil;//on annule la touche à travers (vk_cancel)
                 key:=vk_cancel;
                 GrGrid1.KeyDown(key,shift);
                 GrGrid1.OnKeyDown:=GrGrid1KeyDown;
                 GrGrid1RowValidate(self,Validation,Act,grgrid1.col);
                    Creation.TypeLigne:='V';
                    creation.NumLigne:=grgrid1.rowcount;
                         if ((DMPieces.Piece1.PieceModifiable)or(DMPieces.Piece1.SuppressionParticulieres)) then
                    GrGrid1.GenereLigne(true,grgrid1.rowcount,1);
          end//fin si pas de ligne vide trouvée
       else
          Begin//si ligne vide trouvée
            NewCol:=RecupCelluleValide(LigneCurr+1,grgrid1.col);
          End;//fin si ligne vide trouvée
      end;//fin si appuie sur (entree et on est sur 1ere colonne) ou (Vk_down )
   End;// fin si autre journal
   if (key=vk_UP)then
      begin//si UP
        If lignecurr>1 then
          Begin //si ligne courante >1
          GrGrid1RowValidate(self,Validation,Act,grgrid1.col);
             if not grgrid1.LigneVide(LigneCurr-1) then
               begin //si ligne pas vide
                    if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr-1])^.Ligne.TypeLigne='T' then
                      NewCol:=2;
                    if NewCol=-1 then
                        begin//si prochaine ligne n'est pas une ligne TVA 'V'
                           NewCol:=RecupCelluleValide(LigneCurr-1,grgrid1.col);
                        end;//fin si prochaine ligne n'est pas une ligne TVA 'V'
               end//fin si ligne pas vide
             else
               NewCol:=1;
          End;//fin si ligne courante >1
      end;//fin si UP
if NewCol<>-1 then
  Begin// si changement de colonne
    try
       grgrid1.OnColEnter:=nil;
       grgrid1.OnColExit:=nil;
       grgrid1.col:=newcol;
       grgrid1.OldColonne:=newcol;
    finally
       grgrid1.OnColEnter:=grgrid1colenter;
       grgrid1.OnColExit:=grgrid1colexit;
    end;//fin du try finally
  end;//fin si changement de colonne
notToucheKeyDownKeyUp:=false;
end;




procedure TsaisieP_3.FormActivate(Sender: TObject);
Var
  Registre :TRegistry;
  valide:boolean;
//  ID:integer;
  //DateDefaut:tdateTime;
begin
if WindowState=wsMinimized then WindowState:=wsNormal;
Initialiser_ShortCut_Main(true);
//Modiferligneecriture1.Visible:=e.TypeClient=cl_isa;
//Modiferligneecriture1.enabled:=e.TypeClient=cl_isa;
ModifierEcriture1.Enabled:=e.TypeClient=cl_isa;
GenereDMDossier;
   Registre:= TRegistry.Create;

     try
             with Registre do
             begin
             RootKey := HKEY_LOCAL_MACHINE;
             OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, false);
                try

                  JournalRegistre:=ReadString('Edjournal');
                  IDTrameRegistre:=readinteger('IDTrameRegistre');
                  PlusDefautEntete:=ReadBool('PlusDefautEntete'); // PB
                  PlusAutomatiqueEntete:=ReadBool('PlusAutoEntete'); // PB
                  PlusDefautCorps:=ReadBool('PlusDefautCorps'); // isa
                  PlusAutomatiqueCorps:=ReadBool('PlusAutoCorps'); // isa
                  //******si piece antérieure
                  DerniereDateSaisieRegistreAnt_:=ReadDate('DerniereDateSaisieRegistreAnt_');
                  TypeDerniereDateSaisieRegistreAnt_:=readinteger('TypeDerniereDateSaisieRegistreAnt_');
                  DateAchatRegistreAnt_:=ReadDate('DateAchatRegistreAnt_');
                  DateVentesRegistreAnt_:=ReadDate('DateVentesRegistreAnt_');
                  DateBanqueRegistreAnt_:=ReadDate('DateBanqueRegistreAnt_');
                  DateODRegistreAnt_:=ReadDate('DateODRegistreAnt_');

                  InitDateDefaut(E.DatExoDebut-1,DerniereDateSaisieRegistreAnt_);

                  //****si pièce courante
                  DerniereDateSaisieRegistre:=ReadDate('DerniereDateSaisieRegistre');
                  TypeDerniereDateSaisieRegistre:=readinteger('TypeDerniereDateSaisieRegistre');
                  DateAchatRegistre:=ReadDate('DateAchatRegistre');
                  DateVentesRegistre:=ReadDate('DateVentesRegistre');
                  DateBanqueRegistre:=ReadDate('DateBanqueRegistre');
                  DateODRegistre:=ReadDate('DateODRegistre');

                  InitDateDefaut(now,DerniereDateSaisieRegistre);
                  if CompareDate(DerniereDateSaisieRegistre,E.DatExoDebut) = 1 then
                  DerniereDateSaisieRegistre:=E.DatExoDebut
                  else
                    if CompareDate(DerniereDateSaisieRegistre,E.DatExoFin) = -1 then
                      DerniereDateSaisieRegistre:=E.DatExoFin;
                except
                  PlusDefautEntete:=E.PlanAuxT;// PB
                  PlusDefautcorps:=E.PlanAuxT;// PB
                  if e.TypeDossier<>Verdiocese then
                    JournalRegistre:='AC'
                  else
                    JournalRegistre:='';
                  IDTrameRegistre:=0;
                  if PlusDefautEntete then PlusAutomatiqueEntete:=true;// PB
                  if PlusDefautcorps then PlusAutomatiqueCorps:=true;//isa
                  //****si pièce antérieure
                  DerniereDateSaisieRegistreAnt_:=E.DatExoDebut-1;
                  TypeDerniereDateSaisieRegistreAnt_:=1;
                  DateAchatRegistreAnt_:=DerniereDateSaisieRegistreAnt_;
                  DateVentesRegistreAnt_:=DerniereDateSaisieRegistreAnt_;
                  DateBanqueRegistreAnt_:=DerniereDateSaisieRegistreAnt_;
                  DateODRegistreAnt_:=DerniereDateSaisieRegistreAnt_;
                  //****si pièce courante
                  InitDateDefaut(now,DerniereDateSaisieRegistre);
                  if CompareDate(DerniereDateSaisieRegistre,E.DatExoDebut) = 1 then
                  DerniereDateSaisieRegistre:=E.DatExoDebut;
                  if CompareDate(DerniereDateSaisieRegistre,E.DatExoFin) = -1 then
                  DerniereDateSaisieRegistre:=E.DatExoFin;
                  TypeDerniereDateSaisieRegistre:=1;
                  DateAchatRegistre:=DerniereDateSaisieRegistre;
                  DateVentesRegistre:=DerniereDateSaisieRegistre;
                  DateBanqueRegistre:=DerniereDateSaisieRegistre;
                  DateODRegistre:=DerniereDateSaisieRegistre;
                end;
             end;
     finally
        Registre.Free;
     end;

 // if ((ParamUtil.maintenance)or(Type_version_execution =CT_DEVELOPPEMENT)) then
//  if not DMPieces.Piece1.AnneePiece.PieceAnterieure then
//    Panel2.OnClick:=Panel2Click
//  else
//    Panel2.OnClick:=nil;
  if not DMPieces.Piece1.AnneePiece.PieceAnterieure then
    BtnRecherchePiece.OnClick:=BtnRecherchePieceClick
  else
    BtnRecherchePiece.OnClick:=nil;
  RxSBSuppr.Visible:=((e.TypeClient=cl_isa)or(((ParamUtil.maintenance)or(Type_version_execution =CT_DEVELOPPEMENT))));
  GrEnTete.ParamColor:=true;
  GrEnTete.Param:=ParamUtil.CouleurDBGrid;
  GrEnTete.UpDateColor;

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.UpDateColor;

  GrGrid2.ParamColor:=true;
  GrGrid2.Param:=ParamUtil.CouleurDBGrid;
  GrGrid2.DessineContourLigne:=false;
  GrGrid2.UpDateColor;

  GrGrid3.ParamColor:=true;
  GrGrid3.Param:=ParamUtil.CouleurDBGrid;
  GrGrid3.DessineContourLigne:=false;
  GrGrid3.UpDateColor;

  DMPieces.Piece1.FiltrageTablePieceSurPieceAnterieure(DMPieces.Piece1.AnneePiece.PieceAnterieure);
  if DMPieces.Piece1.AnneePiece.PieceAnterieure then
   begin
     DMPieces.Piece1.DateDebutExo:=StrToDate('01/01/1899');
     DMPieces.Piece1.DateFinExo:=E.DatExoDebut-1;
     DMPieces.Piece1.CodeExo:=E.ExerciceSaisie;
     end
   else
    begin
     DMPieces.Piece1.DateDebutExo:=E.DatExoDebut;
     DMPieces.Piece1.DateFinExo:=E.DatExoFin;
     DMPieces.Piece1.CodeExo:=E.ExerciceSaisie;
    end;

//  case self.tag of  { isa  le  02/06/04 }
  if DMPieces.Piece1.AnneePiece.PieceAnterieure=false then
     Begin // Saisie de l'année en cours
        Patitre.Color:=$0070DBFF;
        RxSpeedButton2.Visible:=false;
        self.Caption:='Saisie des pièces de l''année en cours';
     End
  else
     Begin // Saisie de l'année antérieure
        Patitre.Color:=$00ADEBFF;
        RxSpeedButton2.Visible:=true;
        self.Caption:='Ouverture : Saisie des pièces de l''année antérieure';
     End;
        RxLabTitre.Caption:=self.Caption;

  if PlusDefautEntete then
   begin
    PlusAutomatiqueEntete:=true;// PB
    EdPlusTiersEntete.Text:='+';
    GrEnTete.cells[2,0]:='  Tiers';
   end
    else
   begin
    PlusAutomatiqueEntete:=False;// PB
    EdPlusTiersEntete.Text:='';
    GrEnTete.cells[2,0]:='  Compte';
   end;

  if e.TypeDossier=VerDiocese then
  Begin
    EdDateLivraison.Visible:=false;
    EdDateEcheance.Visible:=false;
    label1.Visible:=false;
    label2.Visible:=false;
    PaLivraison.Caption:='Epicea-2  DIOCESE';
  End;
   //que je déclenche en revenant dans saisiepiece si pièce en cours de saisie

if not (DMPieces.Piece1.EtatPiece in [dsinsert,dsedit])then
  begin
           //DMPlan.TaCompte.OnFilterRecord:=nil;
   valide:=true;//variable servant uniquement pour la procédure rowvalidate
//if not ((fsmodal in saisieP_3.FormState)and(dmpieces.Piece1.EtatPiece in [dsedit]))then
  EtatInitial(0,false);
   ///à ne gérer que si pièce de banque
//  if PlusDefautCorps then
//   begin
//    PlusAutomatiqueCorps:=true;// isa
//    EdPlusTiersCorps.Text:='+';
//    grgrid1.cells[1,0]:='  Tiers';
//   end
//    else
//   begin
//    PlusAutomatiqueCorps:=False;// isa
//    EdPlusTiersCorps.Text:='';
//    grgrid1.cells[1,0]:='  Compte';
//   end;


  if ((grgrid1.RowCount>2)or(not grgrid1.LigneVide(2)))then
   GrGrid1RowValidate(grgrid1,valide,valide,1);
  if ((not empty(DMPieces.Piece1.Reference))and(DMPieces.Piece1.EtatPiece<>dsedit)) then
  //   if DMPieces.Piece1.RechercheReference(dmpieces.Piece1.TablePiece,DMPieces.Piece1.Reference,'Reference','ID',ID)then
     if DMPieces.VerifReference(DMPieces.Piece1.Reference,DMPieces.Piece1,false).Retour=false then
        Begin
          showmessage('La référence n''est plus valide, elle va être automatiquement remplacée !!!');
          if DMPieces.Piece1.AnneePiece.PieceAnterieure then
          DMPieces.Piece1.Reference:=DMPieces.Piece1.NewReference(DMPieces.Piece1.TablePiece,'Reference',DMPieces.Piece1.journal,DMPieces.Piece1.AnneePiece.ExoAnterieure,DMPieces.Piece1.Reference)
          else
          DMPieces.Piece1.Reference:=DMPieces.Piece1.NewReference(DMPieces.Piece1.TablePiece,'Reference',DMPieces.Piece1.journal,DMPieces.Piece1.CodeExo,DMPieces.Piece1.Reference);
          GrEnTete.Cells[1,1]:=DMPieces.Piece1.Reference;
        End;
      
  end;//fin si nouvelle pièce
end;



function TsaisieP_3.RecupParamLigne(LCourante:integer;TypeL:Char;Cpt:string;List:boolean;Tiers:string):TParamLigne_obj;
var
//ParamLign:TParamLigne;
//paramCpt:TParametreCompte_obj;
tab:variant;
InfosPiece_SurTypeLigne:tInfosPiece_SurTypeLigne;
//requete:TQuery;
//ParamAffichCompte:TParamAffichCompte;
TauxIntra:string;
Begin
DMEcritures.Ecriture_Isa1.InitialiseParamLigne_obj(result);
//InitialiseParamCompte;
if not empty(tiers)then
  ParametreCompteEcriture:=DMPieces.RecupParametreCompte(Tiers,'')
else
  ParametreCompteEcriture:=DMPieces.RecupParametreCompte(Cpt,'');
   if ParametreCompteEcriture.retour then
      if ((List) and (LCourante<>-1)) then
       with Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LCourante])^.Ligne do
        Begin //si récupération directement dans la liste
          if empty(ParametreCompteEcriture.ParamCpt.Un1) then
              ChampQt1.readOnly:=true
          else
              ChampQt1.readOnly:=false;
          result.ChampQt1.readOnly:=ChampQt1.readOnly;
          if empty(ParametreCompteEcriture.ParamCpt.Un2) then
              ChampQt2.readOnly:=true
          else
              ChampQt2.readOnly:=false;
          result.ChampQt2.readOnly:=ChampQt2.readOnly;
          GestionDesUnites;
          if ParametreCompteEcriture.ParamCpt.SensCredit=C_true then
          SensCredit:=true
          else
          Begin
            if ParametreCompteEcriture.ParamCpt.SensCredit=C_false then
              SensCredit:=false
            else
              Begin
                if DMPlan.TypeCompteCrediteur(Cpt)then
                  SensCredit:=true
                else
                  SensCredit:=false;
              End;
          End;
          result.SensCredit:=SensCredit;
          if ParametreCompteEcriture.Choix then
            Begin
             if ParametreCompteEcriture.Tiers.ResultInfos then
               Begin
                 Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LCourante])^.Ligne.Compte:=ParametreCompteEcriture.Tiers.Compte;
                 Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LCourante])^.Ligne.Tiers:=ParametreCompteEcriture.Tiers.Tiers;
               End;
            End
          else
            Begin
              Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LCourante])^.Ligne.Compte:=ParametreCompteEcriture.ParamCpt.Compte;
              Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LCourante])^.Ligne.Tiers:='';
            End;
          if not Complement.rempli then
          begin
              if not empty(ParametreCompteEcriture.ParamCpt.TvaCode) then
              begin
              result.TVA:=RecupParametreTVA(ParametreCompteEcriture.ParamCpt.TvaCode);
              end
              else
               begin
                 RenvoieInfoSurTableDiverse(cpt,DMTVACode.TaTvaCode,'Compte',['TvaCode'],Tab);
                 if not empty(tab[0])then
                   result.TVA:=RecupParametreTVA(tab[0]);
               end;
          InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(LCourante,DMEcritures.Ecriture_Isa1.ListIdentifiant);
          RecupInfosComplementLigne(false,complement,result.TVA.CodeTva,TypeL,cpt,InfosPiece_SurTypeLigne.solde);

          end
          else
          Begin
          result.TVA.Retour:=true;
          result.TVA.CodeTva:=Complement.CodeTvaCompl;
          RenvoieInfoSurTableDiverse(Complement.CodeTvaCompl,DMTVACode.TaTvaCode,'TvaCode',['Taux_Inf','Taux_Supp','Compte','Libelle'],tab);
          if not empty(Complement.CodeTvaCompl)then
           begin//si code tva rempli
           if uppercase(Complement.CodeTvaCompl)[1] in ['C','E','L','N','F','M'] then
             begin
             result.TVA.TauxMin:=Complement.TvaTaux;
             result.TVA.TauxMax:=Complement.TvaTaux;
             end
           else
             Begin
             if not empty(tab[0])then
               result.TVA.TauxMin:=tab[0];
             if not empty(tab[1])then
               result.TVA.TauxMax:=tab[1];
             result.TVA.Compte:=tab[2];
             result.TVA.Libelle:=tab[3];
             result.TVA.sensCredit:=result.SensCredit;
             End;
           end;//fin si code tva rempli
          End;
        TVA.Retour:=result.TVA.Retour;
        TVA.CodeTva:=result.TVA.CodeTva;
        TVA.TauxMin:=result.TVA.TauxMin;
        TVA.TauxMax:=result.TVA.TauxMax;
        TVA.Compte:=result.TVA.Compte;
        TVA.Libelle:=result.TVA.Libelle;
        TVA.sensCredit:=result.TVA.sensCredit;
        End //fin récupération directement dans la liste
        else
        if list=false then
        with Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LCourante])^.Ligne do
        Begin //si récupération dans une variable
          if empty(ParametreCompteEcriture.ParamCpt.Un1) then
          result.ChampQt1.readOnly:=true
          else
          result.ChampQt1.readOnly:=false;
          if empty(ParametreCompteEcriture.ParamCpt.Un2) then
          result.ChampQt2.readOnly:=true
          else
          result.ChampQt2.readOnly:=false;
          if ParametreCompteEcriture.ParamCpt.sensCredit=C_true then
          result.SensCredit:=true
          else
          result.SensCredit:=false;
          if ParametreCompteEcriture.Choix then
            Begin
             if ParametreCompteEcriture.Tiers.ResultInfos then
               Begin
                 result.Compte:=ParametreCompteEcriture.Tiers.Compte;
                 result.Tiers:=ParametreCompteEcriture.Tiers.Tiers;
               End;
            End
          else
            Begin
              result.Compte:=ParametreCompteEcriture.ParamCpt.Compte;
              result.Tiers:='';
            End;
          if not Complement.rempli then
          begin
              if not empty(ParametreCompteEcriture.ParamCpt.TvaCode) then
              result.TVA:=RecupParametreTVA(ParametreCompteEcriture.ParamCpt.TvaCode)
              else
               begin
                 RenvoieInfoSurTableDiverse(cpt,DMTVACode.TaTvaCode,'Compte',['TvaCode'],Tab);
                 if not empty(tab[0])then
                   result.TVA:=RecupParametreTVA(tab[0]);
               end;
          InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(LCourante,DMEcritures.Ecriture_Isa1.ListIdentifiant);
          RecupInfosComplementLigne(false,complement,result.TVA.CodeTva,TypeL,cpt,InfosPiece_SurTypeLigne.solde);
          end
          else
          Begin
          result.TVA.Retour:=true;
          result.TVA.CodeTva:=Complement.CodeTvaCompl;
          RenvoieInfoSurTableDiverse(Complement.CodeTvaCompl,DMTVACode.TaTvaCode,'TvaCode',['Taux_Inf','Taux_Supp','Compte','Libelle'],tab);
          if not empty(Complement.CodeTvaCompl)then
           begin//si code tva rempli
           if UpperCase(Complement.CodeTvaCompl)[1]in ['C','E','L','N','F','M'] then
             begin
             result.TVA.TauxMin:=Complement.TvaTaux;
             result.TVA.TauxMax:=Complement.TvaTaux;
             end
           else
             Begin
             result.TVA.TauxMin:=tab[0];
             result.TVA.TauxMax:=tab[1];
             result.TVA.Compte:=tab[2];
             result.TVA.Libelle:=tab[3];
             result.TVA.sensCredit:=result.SensCredit;
             End;
           end;//fin si code tva rempli
          End;
        End; //fin récupération dans variable
//        if LCourante<>0 then
//        result.TypeLigne:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LCourante])^.Ligne.TypeLigne;
End;



procedure TsaisieP_3.GrGrid1BeforeNewLigne(sender: TObject; Arow: Integer);
var
messages:boolean;
//i:integer;
begin
messages:=true;
try
  if e.TypeDossier=VerDiocese then
    begin
    messages:=false;
    abort;
    end;
  if creation.TypeLigne in ['V'] then
  Begin //si ligne créée du type H ou X, alors on rempli listidentifiant uniquement
   if DMEcritures.Ecriture_Isa1.ListIdentifiant.Count-1<LigneCurr then //en ajoutant une ligne à la fin de la liste
   DMEcritures.Ecriture_Isa1.ListIdentifiantadd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1)
   else //sinon, on insert une ligne et on gère le décalage dans la table
   DMEcritures.Ecriture_Isa1.ListIdentifiantadd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],false,false,ARow);
  End //fin si ligne créée du type H ou X,
  else
  Begin //si autre ligne
     if creation.TypeLigne='T' then
     begin //si ligne créée est du type T           //IDEM
//      if DMEcritures.Ecriture_Isa1.ListIdentifiant.Count-1<LigneCurr  then
      if DMEcritures.Ecriture_Isa1.ListIdentifiant.Count-1<Arow  then { isa  le  29/03/04 }
       DMEcritures.Ecriture_Isa1.ListIdentifiantadd_insert([0,0,0,'','','','','',0,0,false,'T',False,False,true,true,true,False,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1)
       else                                         //IDEM
       DMEcritures.Ecriture_Isa1.ListIdentifiantadd_insert([0,0,0,'','','','','',0,0,false,'T',False,False,true,true,true,False,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],false,false,ARow);
     end;//fin si ligne créée est du type T
  End;//fin si autre ligne
except
if messages then
  showmessage('Problème rencontré avant la création d''une nouvelle ligne !!');
abort;
end;//fin du try except
end;


procedure TsaisieP_3.GrGrid1Enter(Sender: TObject);
var
newcol:integer;
begin
GRCompteTmp:='';
GRDebitTmp:='';
GRCreditTmp:='';
LigneCurr:=grgrid1.Row;
grgrid1.EtatGrille:=dsbrowse;
ChangementEtatBoutonsMenu;
if not empty(grgrid1.Cells[1,LigneCurr]) then
  begin
   if ((not empty(grgrid1.Cells[1,ligneCurr]))and(grgrid1.Cells[1,ligneCurr][1] <> '+')) then
     begin
      LaCompteEnCours.Caption:=DMPlan.LibelleDuNumCptPCU(grgrid1.Cells[1,LigneCurr]);
      if DMPlan.PossedeFils(grgrid1.Cells[1,LigneCurr]) then
           LaCompteEnCours.Font.Color:=clblack
           else
           LaCompteEnCours.Font.Color:=clGreen;
     end
     else
     Begin
       LaCompteEnCours.Caption:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[grgrid1.Cells[1,LigneCurr]]).Nom;
//       LaCompteEnCours.Caption:=DMTiers.LibelleDuTiers(grgrid1.Cells[1,LigneCurr]);
       LaCompteEnCours.Font.Color:=clGreen;
     End;
   end
    else LaCompteEnCours.Caption:='';
GrGrid1RowEnter(GrGrid1,LigneCurr);{ isa  le  14/06/04 }
//if not grgrid1.LigneVide(ligneCurr)then
//Begin
//lastParamLigne.TVA:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TVA;
//lastParamLigne.init:=true;
//End;
//Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.LigneCourante:=grgrid1.Rows[LigneCurr].text;
///////récupération des valeurs contenues dans la ligne en y entrant pour comparaison en sortant
//if ((not grgrid1.LigneVide(LigneCurr))and (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[LigneCurr])^.Ligne.TypeLigne<>'T')) then
//   begin //si ligne pas vide et pas T
//
// //  showmessage('Row Enter: '+Pidentifiant(ListIdentifiant.items[NewRow])^.LigneCourante+' '+inttostr(NewRow));
//   GRCompteTmp:=grgrid1.Cells[1,LigneCurr];
//   GRDebitTmp:=grgrid1.Cells[5,LigneCurr];
//   GRCreditTmp:=grgrid1.Cells[6,LigneCurr]
//   end;
//
modif.ASupprimer:=false;
modif.NewRow:=-1;
//modif.SupprAutomatique:=false;
newcol:=RecupCelluleValide(1,1);
if newcol<>-1 then
  grgrid1.Col:=newcol
else
  grgrid1.Col:=1;
end;




function TsaisieP_3.RecupTypeLigneSurCompte(FLigne:integer):Char;
begin
result:='V';
  if not empty(GrGrid1.Cells[1,FLigne]) then
    begin//si compte rempli
       if (FTvaCompteDeTva(GrGrid1.Cells[1,FLigne])and(dmpieces.piece1.IDJournal in [1,2]))then
         result:='T'
       else
         result:='H';
    end//fin si compte rempli
  else
    Begin
      //changer le typeligne par 'V'
      result:='V';
    End;
end;


Procedure TsaisieP_3.PreparationEnregistrementComplet(Gauge:TGauge);
var
tableTemp:TTable;
ctrlSaisieLigne:TErreurLigne;
//conteneurVerrou:TVerrouillage;
TotalPiece:TInfosPiece_SurTypeLigne;
//SensCredit:boolean;
//rang,
i,j:integer;
//tab:variant;
//messageTmp:string;
infosTvaPiece:TInfosPiece_SurTypeLigne;
begin
try
initialiseInfosPiece_SurTypeLigne(infosTvaPiece);
tableTemp:=ttable.Create(self);
tableTemp.DatabaseName:= DMEcritures.Ecriture_Isa1.TableEcriture.DatabaseName;
tableTemp.tableName:= DMEcritures.Ecriture_Isa1.TableEcriture.tableName;
tableTemp.Open;
  try
     TableGereStartTransaction(tableTemp);
     if contrepartiecree then
       begin
         DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],false,true,0);
         contrepartieCree:=false;
       end;
     if (not contrepartieCree) then
     begin //si la contrepartie n'est pas déjà créée
        TotalPiece:=DMEcritures.Ecriture_Isa1.InfosPiece_SurTypeLigne(['H','T'],DMEcritures.Ecriture_Isa1.ListIdentifiant,'',0,false,false,-1);
        if dmpieces.piece1.idjournal<>3 then
        begin //si ce n'est pas une OD
        if TotalPiece.SensSoldeCredit<>C_SensSoldeNul then
          begin
           if TotalPiece.SensSoldeCredit=C_SensSoldeCredit then
           DMPieces.Piece1.Sens:=false
           else
           DMPieces.Piece1.Sens:=true;
          end
        else
          begin
          showmessage('La pièce a un solde nul !');
          abort;
          end;
        end//fin si ce n'est pas une OD
        else
        Begin //si c'est une OD
          if TotalPiece.SensSoldeCredit<>C_SensSoldeNul then
            begin
            showmessage('La pièce n''est pas équilibrée !');
            abort;
            end;
        End;//fin si c'est une OD
      DMPieces.Piece1.Montant:=TotalPiece.Solde;
     end;//fin si la contrepartie n'est pas déjà créée

     ////////s'il y a une ligne de contrepartie à créer
     if ((not (creation.Acreer))and((DMPieces.Piece1.Modifier_Confirmer)or (((not DMPieces.Piece1.Modifier_Confirmer)and(DMPieces.Piece1.EtatPiece=dsinsert))))and(not ContrepartieCree)) then
     Begin //si acreer=false et edcompte pas vide et pièce modifier

        if not empty(DMPieces.Piece1.Compte)then
         begin
         //Insérer ligne de contrepartie dans la liste
         ContrepartieCree:=true;
         DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],false,true,0);
         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[0])^.Ligne.TypeLigne:='X';
         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[0])^.Ligne.Compte:=DMPieces.Piece1.Compteplan;
         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[0])^.Ligne.tiers:=DMPieces.Piece1.Tiers;
         if DMPieces.Piece1.sens then
         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[0])^.Ligne.Credit:=DMPieces.Piece1.Montant
         else
         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[0])^.Ligne.Debit:=DMPieces.Piece1.Montant;
         Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[0])^.Ligne.Libelle:=DMPieces.Piece1.Libelle;
         infosTvaPiece:=DMEcritures.Ecriture_Isa1.InfosPiece_SurTypeLigne(['T'],DMEcritures.Ecriture_Isa1.ListIdentifiant,'',0,true,true,-1);
         if infosTvaPiece.NbLigne<>0 then
           Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[0])^.Ligne.Complement.MontantTva:=infosTvaPiece.Solde;
         end
         else
         begin
       //  DMPieces.Piece1.IDContrepartie:=DMEcritures.Ecriture_Isa1.FirstIDEcriture;
         ContrepartieCree:=true;
         end;
     End;//fin si acreer=false et edcompte pas vide et pièce modifier (Ligne contrepartie à créer)
     //////////////////////////////
     ////////vérifier interaction entre lignes

       if ((DMPieces.Piece1.IDjournal in [1,2,3,4])and((DMPieces.Piece1.Modifier_Confirmer)or(DMPieces.Piece1.EtatPiece=dsinsert))) then
           begin //si journal [1,2,4]
           for i:=0 to DMEcritures.Ecriture_Isa1.ListIdentifiant.Count-1 do
                Begin//Début du for sur count ListIdentifiant
  GestionGauge((100 div DMEcritures.Ecriture_Isa1.ListIdentifiant.Count-1),Gauge,1000,0,'contrôle des lignes d''écritures',e.TypeClient=cl_isa);
                ctrlSaisieLigne.CodeErreur:=0;
                ctrlSaisieLigne.Retour:=true;
                if ((DMPieces.Piece1.IDjournal in [3,4])and(((i=0)or(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[i])^.Ligne.TypeLigne='X')))) then
                  ctrlSaisieLigne:=DMEcritures.Ecriture_Isa1.InteractionLigne_SurListe(DMEcritures.Ecriture_Isa1.ListIdentifiant,i,DMPieces.Piece1.IDJournal)
                else
                 if DMPieces.Piece1.IDjournal in [1,2] then
                    ctrlSaisieLigne:=DMEcritures.Ecriture_Isa1.InteractionLigne_SurListe(DMEcritures.Ecriture_Isa1.ListIdentifiant,i,DMPieces.Piece1.IDJournal);
                if ctrlSaisieLigne.Retour=false then
                    case ctrlSaisieLigne.CodeErreur of
                    12000:begin
                            if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                              abort;
                          end;
                    12001:Begin
                           Messagedlg(ctrlSaisieLigne.MessageErreur.MessageErreur,MtConfirmation,[mbok],0);
                           abort;
                          End;
                     3001,
                    12008:Begin
                           Messagedlg(ctrlSaisieLigne.MessageErreur.MessageErreur,MtConfirmation,[mbok],0);
                           abort;
                          End;
                     3002,
                    12009:Begin
                           Messagedlg(ctrlSaisieLigne.MessageErreur.MessageErreur,MtConfirmation,[mbok],0);
                           abort;
                          End;
                    120062,
                    120072:Begin
                          if ((ParamUtil.maintenance)and (ParamUtil.TypeMaintenance='MaintS')) then
                           begin
                           if Application.MessageBox(PChar(ctrlSaisieLigne.MessageErreur.MessageQuestion),'Erreur de TVA',MB_YESNO + MB_DEFBUTTON2) = IDno then
                             Begin
                               if ctrlSaisieLigne.Modif.NewRow<>-1 then
                                  begin
                                    grgrid1.Row:=ctrlSaisieLigne.Modif.NewRow;
                                    grgrid1.col:=5;
                                  end;
                               abort;
                             end;
                           end
                           else
                           begin
                           Messagedlg(ctrlSaisieLigne.MessageErreur.MessageErreur,MtConfirmation,[mbok],0);
                              if ctrlSaisieLigne.Modif.NewRow<>-1 then
                              begin
                                grgrid1.Row:=ctrlSaisieLigne.Modif.NewRow;
                                grgrid1.col:=5;
                              end;
                           abort;
                           end;
                          End;
                    120061,
                    120071,
                    120060,
                    120070:Begin
                           if Application.MessageBox(PChar(ctrlSaisieLigne.MessageErreur.MessageErreur),'Erreur de TVA',MB_YESNO + MB_DEFBUTTON2) = IDno then
                             Begin
                              if ctrlSaisieLigne.Modif.NewRow<>-1 then
                              begin
                                grgrid1.Row:=ctrlSaisieLigne.Modif.NewRow;
                                grgrid1.col:=5;
                              end;
                              abort;
                             End;
                          End;
                    end;//fin du case ctrlSaisieLigne
                End;//fin du for sur count ListIdentifiant
           end;//fin si journal [1,2,4]
  except
  contrepartieCree:=false;
  DMPieces.Piece1.IDContrepartie:=-1;
  GrGrid1RowEnter(grgrid1,grgrid1.row);
  abort;
  end;//fin du try except

finally
  if tableTemp<>nil then
  begin
  tableTemp.close;
  tableTemp.free;
  TableTemp:=nil;
  end;
end;//fin du try finally
end;




procedure TsaisieP_3.EnregistrementComplet(Reglement:boolean);
var
TableTemp:Ttable;
//ContrePartie:TParametreCompte_obj;
//LignCPartie:TParamLigne_obj;
//cptTiers,Cpt:string;
i,ID_Temp:integer;
SuppressionPiece:boolean;
ListeTmp:TStringList;
ValPieceAutoGenere_Tmp:TValPieceAutoGenere;
key:word;
//Tab,tabTmp:variant;
//PieceReglement:TPiece;
//EcritureReglement:TEcriture_Isa;
//idtmp,rang,IDPointage:integer;
begin
try
ListeTmp:=TStringList.Create;
ID_Temp:=-1;
tableTemp:=ttable.Create(self);
tableTemp.DatabaseName:= DMEcritures.Ecriture_Isa1.TableEcriture.DatabaseName;
tableTemp.tableName:= DMEcritures.Ecriture_Isa1.TableEcriture.tableName;
tableTemp.Open;
    try
        //necessaire pour générer la ligne tva si elle n'existe pas
        key:=vk_down;
        GrGrid1.KeyDown(key,[]);
    except
    end;
//SensCredit:=false;
SuppressionPiece:=false;

//  try
   if DMPieces.Piece1.EtatPiece in [dsedit,dsinsert]  then
   Begin //si DMPieces.Piece1.EtatPiece in [dsedit,dsinsert]
     TableGereStartTransaction(tabletemp);
       try
GestionGauge(100,gauge1,gauge1.MaxValue,0,'Contrôle de la pièce',e.TypeClient=cl_isa);
       PreparationEnregistrementComplet(gauge1);
       except
         GrEnTete.Cells[1,1]:=DMPieces.Piece1.Reference;
         DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(0);
         DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],False,false,0);
         grgrid1.setfocus;
         abort;
       end;//fin du try except
   try
      ///// ??????  Attention, on ne supprime la piece que s'il y eu des modification dessus
     if ((DMPieces.Piece1.EtatPiece =dsedit) and (DMPieces.Piece1.Modifier_Confirmer)) then
        begin
         DMPieces.Piece1.Suppression_Pour_Modif:=true;
         if not DMPieces.Piece1.PieceModifiable then
            begin
             ValPieceAutoGenere_Tmp:=DMPieces.Piece1.ValPieceAutoGen;
             ValPieceAutoGenere_Tmp.Val_Champ_Gen:=str_getstringelement(ValPieceAutoGenere_Tmp.Val_Champ_Gen,1,';')+';'+TypeClientToStr(e.TypeClient)+'_'+e.User;
             DMPieces.Piece1.ValPieceAutoGen:=ValPieceAutoGenere_Tmp;
            end;
GestionGauge(100,gauge1,-1,-1,'Suppression avant Ré-enregistrement',e.TypeClient=cl_isa);
         DMPieces.SuppressionPieceEcriture(DMPieces.Piece1.Reference,DMPieces.Piece1);
         SuppressionPiece:=true;
        end;
       //si etatpiece=dsedit,on corrige les identifiants écriture en fonction des ID_Org
       if ((((DMPieces.Piece1.Modifier_Confirmer)and (DMPieces.Piece1.EtatPiece=dsedit)))or(DMPieces.Piece1.EtatPiece=dsinsert)) then
       begin //si la pièce est à modifier
GestionGauge(100,gauge1,gauge1.MaxValue,0,'Ecriture de la pièce',e.TypeClient=cl_isa);
       DMPieces.EnvoiePieceEcriture_SurListe(DMEcritures.Ecriture_Isa1.ListIdentifiant,DMEcritures.Ecriture_Isa1,0,0,false,DMPieces.Piece1.EtatPiece,SuppressionPiece);
       end; //fin si la pièce est à modifier
       if ValiderPointageEnCours then
         begin
           //pour chaque ecriture dont les infos pointages sont renseignés, lettrer l'écriture
  GestionGauge(100,gauge1,gauge1.MaxValue,gauge1.MinValue,'lettrage des pointages',e.TypeClient=cl_isa);
           for i:=0 to DMEcritures.Ecriture_Isa1.ListIdentifiant.count-1 do
             Begin//début boucle for
                dmpointage2.TaAffectReglement.Refresh;
                defiltrageDataset(dmpointage2.TaAffectReglement);
                if ((not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.infosPointages.infosPointage.Lettre))and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.infosPointages.infosPointage.MontantPointage<>0)) then
                  begin
                    if dmpointage2.TaAffectReglement.locate('ID_ecriture',Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.ID_Ord,[]) then
                       DMPointage2.LettrageEnregCourant(dmpointage2.TaAffectReglement,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.infosPointages.infosPointage.Lettre,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.infosPointages.infosPointage.MontantPointage);
                  end;
             End;//fin boucle for
           if DMPointage2.ListeID_Appelant<>nil then
             for i:=0 to DMPointage2.ListeID_Appelant.count-1 do
               Begin//si
                 if dmpointage2.TaAffectReglement.locate('ID',PListeResteAffect(dmpointage2.ListeID_Appelant.items[i])^.ID_Reste,[]) then
                   Begin//si
                     If ListeTmp.IndexOf(dmpointage2.TaAffectReglement.findfield('ID').asstring)=-1 then
                       begin
                         //calculer le total des imputations sur cet id reste
                         DMPointage2.LettrageEnregCourant(dmpointage2.TaAffectReglement,PListeResteAffect(dmpointage2.ListeID_Appelant.items[i])^.Lettre,DMPointage2.TotalImputation_IDReste(dmpointage2.TaAffectReglement.findfield('ID').asinteger,-1));
                         ListeTmp.Add(dmpointage2.TaAffectReglement.findfield('ID').asstring);
                       end;
                   End;//fin si
               End;//fin si
GestionGauge(100,gauge1,gauge1.MaxValue,0,'Enregistrement des pointages',e.TypeClient=cl_isa);
           DMPointage2.ValiderPointages(DMPointage2.TaAffectReglement,DMPieces.Piece1.compte,true);
         end;

       if Reglement then
       Begin //s'il y a eu réglement de cette pièce
        if SaisieReglements.ListeReglement<>nil then
          EnregistrementReglement(saisieP_3,ListePointages);
//          EnregistrementReglement(ListeReglement,saisieP_3,ListePointages);
        ListePointages.Clear;
       End;//fin s'il y a eu réglement de cette pièce

    if Gestionimmos.supprimerImmos then
      begin
  GestionGauge(100,gauge1,gauge1.MaxValue,gauge1.MinValue,'Gestion des Immobilisations',e.TypeClient=cl_isa);
      DataModuleImmos.taDetailImmo.Open;
         while Gestionimmos.ImmosASupprimer.Count<>0 do
         begin
         DeFiltrageDataSet(DMRech.TaImmosRech);
         DataModuleImmos.SuppressionImmo(DMRech.TaImmosRech,StrToInt_Lgr(Gestionimmos.ImmosASupprimer.Strings[0]),true,false);
         Gestionimmos.ImmosASupprimer.Delete(0);
         end;
         if not empty(Gestionimmos.reference) then
            DMPieces.SuppressionOD(Gestionimmos.reference);
      end;
    if Gestionimmos.supprimerCessions then
      begin
  GestionGauge(100,gauge1,gauge1.MaxValue,gauge1.MinValue,'Gestion des Immobilisations',e.TypeClient=cl_isa);
      DataModuleImmos.TableImmos.Open;
         while Gestionimmos.CessionsASupprimer.Count<>0 do
         begin
         DeFiltrageDataSet(DMRech.TaImmosRech);
         DataModuleImmos.SuppressionImmo(DMRech.TaImmosRech,StrToInt_Lgr(Gestionimmos.CessionsASupprimer.Strings[0]),false,false);
         Gestionimmos.CessionsASupprimer.Delete(0);
         end;
         if not empty(Gestionimmos.reference) then
            DMPieces.SuppressionOD(Gestionimmos.reference);
      DataModuleImmos.TableImmos.close;
      end;
       TableGereCommit(tableTemp);
       TableGereCommit(DMBalance.TaBalance);
       SuppressionPiece:=false;

   except
     TableGereRollBack(tableTemp);
     TableGereRollBack(DMBalance.TaBalance);
     GrEnTete.Cells[1,1]:=DMPieces.Piece1.Reference;
     tableTemp.Refresh;
     DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(0);
     DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],False,false,0);
  //   showmessage('Problème lors de l''Enregistrement complet de la piece !!!');
     grgrid1.setfocus;
     abort;
   end;//fin du try
end;//fin si DMPieces.Piece1.EtatPiece in [dsedit,dsinsert]
finally
   if  ListeTmp<>nil then
   begin
   ListeTmp.free;
   ListeTmp:=nil;
   end;

   if  tableTemp<>nil then
   Begin
   tableTemp.free;
   TableTemp:=nil;
   End;
end;//fin du try finally
End;





procedure TsaisieP_3.GrGrid1Exit(Sender: TObject);
begin
//if ((activecontrol <> GrEnTete) and (activecontrol <> EdDateLivraison)
//and (activecontrol <> EdDateEcheance)and (activecontrol <> PaLivraison))then// PB
if ((activecontrol <> BtnAnnuler) and(activecontrol <>BtnFermer)) then
  begin
  VerificationTvaAvantEnregistrement;
  GrGrid1.EtatGrille:=dsbrowse;
  GrGrid1StateChange(GrGrid1.EtatGrille);
  end;
end;


procedure TsaisieP_3.GrGrid1BeforeSupprLigne(sender: TObject; Arow: Integer;
  var NewRow: Integer);
var
sensLigneTva,i:integer;
SupprOD,GererTva:boolean;
conteneurVerrou:TVerrouillage;
TvaCompteTmp,Messages:String;
InfosLignePieceH:TInfosPiece_SurTypeLigne;
MontantTVA:TRetourMontantTva;
ParamTVA:TRecupParamTva_obj;
ModifiableTmp:boolean;
rangAModifier:integer;
tvaExceptionnelle:boolean;
begin
try
ModifiableTmp:=false;
tvaExceptionnelle:=false;
//regarder si Pièce décrite dans les immos
//si oui, vérifier si amortissable
  try
  TableGereStartTransaction(DMPieces.Piece1.TablePiece);
  if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,Arow).retour= false then abort;
  if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
     Begin
        //si piece non modifiable
       messages:='Cette pièce n''est pas modifiable ';
       showmessage(messages);
       abort;
     End;
  if DMEcritures.Ecriture_Isa1.ListIdentifiant.count>arow then
    Begin
//?? TvaCompteTmp:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[Arow])^.Ligne.TVA.Compte;
     TvaCompteTmp:=Infos_TInfosTvaCode(DMRech.TaTvaCodeRech,'TvaCode',[Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[Arow])^.Ligne.Complement.CodeTvaCompl]).Compte;
     //showmessage('annulLigneSupprLigne');
     supprOD:=false;
     GererTva:=false;
     { isa  le  21/10/03 }
//        if ((DMPieces.Piece1.IDJournal in [1,2])and(((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)))then
        if ((DMPieces.Piece1.IDJournal in [1,2,3,4])and(((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)))then
        Begin //si piece de vente ou d'achat
         if not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.Complement.CodeTvaCompl)then
           tvaExceptionnelle:=uppercase(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.Complement.CodeTvaCompl)[1] in['C','E','L','N','F','M'];
          if ((((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TypeLigne = 'H')and ((not tvaExceptionnelle)or
          (not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.Complement.CodeTvaCompl)))))or(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TypeLigne = 'T'))then
             Begin //si ligne hors taxe attendant de la tva ou ligne Tva
                if DMPieces.Piece1.InfosVerrouillage.PieceVerrouillee then
                   Begin
                      GererTva:=true;
                      SupprOD:=DMPieces.Piece1.InfosVerrouillage.Deverrouillable;
                   End;
             if GererTva then
                Begin //si on doit gerer la tva
                  if not SupprOD then
                    Begin //si on ne peut pas modifier la ligne
                        messages:='Attention, cette pièce est verrouillée et non déverrouillable, Vous ne pouvez pas la supprimer ?';
                        Application.MessageBox(Pchar(messages),'Attention',MB_ICONEXCLAMATION +MB_OK);
                        begin
                        abort;
                        end;
                    End//fin  si on ne peut pas modifier la ligne
                  else
                    Begin //si on peut modifier la ligne, on deverrouille la période déclarée
                      messages:='Attention, cette pièce est verrouillée, si vous la supprimez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! Voulez-vous la supprimer ?';
                      if Application.MessageBox(Pchar(messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                         begin
                         if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                           abort;
                         conteneurVerrou:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,DMPieces.Piece1.DateSaisie);
                         DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                         end
                         else
                          begin
                            abort;
                          end;
                    End; //fin si on peut modifier la ligne, on deverrouille la période déclarée
                End;//fin si on doit gerer la tva
             End;//fin si ligne hors taxe attendant de la tva ou ligne Tva
        End; //fin si piece de vente ou d'achat et piece existante
     supprOD:=false;
     GererTva:=false;
        if ((DMPieces.Piece1.IDJournal in [4])and(((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)))then
        Begin //si piece de banque
           if ((DMPieces.Piece1.InfosVerrouillage.PeriodeVerrouillee)and(DMPieces.Piece1.InfosPointage.infosPointage.TvaSurE)) then
              Begin
                 GererTva:=true;
                 SupprOD:=DMPieces.Piece1.InfosVerrouillage.PeriodeDeverrouillable;
              End;
        if GererTva then
           Begin //si on doit gerer la tva
             if not SupprOD then
               Begin //si on ne peut pas modifier la ligne
                   messages:='Attention, cette pièce est verrouillée et non déverrouillable, Vous ne pouvez pas la supprimer ?';
                   Application.MessageBox(Pchar(messages),'Attention',MB_ICONEXCLAMATION +MB_OK);
                   begin
                   abort;
                   end;
               End//fin  si on ne peut pas modifier la ligne
             else
               Begin //si on peut modifier la ligne, on deverrouille la période déclarée
                 messages:='Attention, cette pièce est verrouillée, si vous la supprimez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! Voulez-vous la supprimer ?';
                 if Application.MessageBox(Pchar(messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                    begin
                    if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                      abort;
                    conteneurVerrou:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,DMPieces.Piece1.DateSaisie);
                    DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                    end
                    else
                     begin
                       abort;
                     end;
               End; //fin si on peut modifier la ligne, on deverrouille la période déclarée
           End;//fin si on doit gerer la tva
        End; //fin si piece de banque

        if DMPieces.Piece1.EtatPiece in [dsEdit] then
          Begin //si etatpiece in [dsEdit]
              if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (not(grgrid1.LigneVide(Arow)))) then
                begin //si piece.modifier=false
                   if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                      begin
                        messages:=SuppressionDesPointages;
                        if Application.MessageBox(Pchar(messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                           begin
                           ModifiableTmp:=true;
                           end;
                      end
                   else
                      ModifiableTmp:=true;
                 if ModifiableTmp then //si on veut quand même la modifier
                   DMPieces.Piece1.Modifier_EnAttente:=true
                 else
                   Begin //remettre les anciens paramètres tva s'ils avaient été changés
                   abort;
                   End;
                end;
          end;
     if ((empty(messages))and(not modif.SupprAutomatique)and(not(grgrid1.LigneVide(Arow)))) then
       begin
         messages:='Attention, voulez-vous réellement supprimer cette ligne ?';
         if Application.MessageBox(Pchar(messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
            begin
              abort;
            end;
       end;
        if DMPieces.Piece1.IDJournal in [1,2] then
            begin
               if ((not(grgrid1.LigneVide(Arow)))and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TypeLigne in ['H','X'])) then
               Begin //si la ligne n'est pas vide et que s'est une ligne H ou X
                 if not empty (TvaCompteTmp) then
                   Begin //si la ligne a des parametre TVA
  //                 showmessage(TvaCompteTmp);
                   InfosLignePieceH:=DMEcritures.Ecriture_Isa1.InfosPiece_SurTypeLigne(['H'],DMEcritures.Ecriture_Isa1.ListIdentifiant,TvaCompteTmp,0,true,false,-1);
                   if ((DMEcritures.Ecriture_Isa1.ExistenceIdemParamTVA(TvaCompteTmp,Arow))and(InfosLignePieceH.Solde<>0)) then
                      begin //s'il existe une autre ligne avec les mêmes parametre TVA
                        ParamTVA:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TVA;
                        rangAModifier:=DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf(TvaCompteTmp,'',4);//récup avant suppression
                        DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(Arow);//supprime ligne dans listIdentifiant
                        Modif.NewRow:=DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf(TvaCompteTmp,'',4);
                           if ((rangAModifier<>-1)and(Modif.NewRow<>-1)) then
                             Begin //si on a trouvé la ligne tva correspondante
                             // on regarde si son montant et son sens son correct
                             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Modif.NewRow])^.Ligne.SensCredit then
                             sensLigneTva:=1
                             else
                             sensLigneTva:=-1;
                               MontantTVA:=DMEcritures.Ecriture_Isa1.VerifMontantTVA_SurListe(DMEcritures.Ecriture_Isa1.ListIdentifiant,ParamTVA,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[modif.NewRow])^.Ligne.Debit,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[modif.NewRow])^.Ligne.Credit,0,0,'',sensLigneTva,false);
                               if ((not montantTva.retour)or(MontantTVA.FourchetteModifier)) then
                                 begin
  //                               Application.MessageBox(Pchar('Vous supprimez une ligne comprenant une part de TVA, vous devez modifier la ligne TVA '+Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[modif.NewRow])^.Ligne.Compte+' !!!'),'Avertissement',0);
                                  if montantTva.SensCreditReel=0 then
                                    Begin
//                                      DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(Arow);//supprime ligne dans listIdentifiant
                                      Modif.ASupprimer:=true;
                                      modif.SupprAutomatique:=true;
                                      Modif.NewRow:=DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf(TvaCompteTmp,'',4);
                                    End
                                  else
                                  begin
                                   if montantTva.SensCreditReel=1 then
                                     begin
                                     Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Modif.NewRow])^.Ligne.SensCredit:=true;
                                     end
                                   else
                                     begin
                                     Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Modif.NewRow])^.Ligne.SensCredit:=false;
                                     end;
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Modif.NewRow])^.Ligne.tva.MontantMini:=montantTva.RetourMontantMini;
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Modif.NewRow])^.Ligne.tva.MontantMaxi:=montantTva.RetourMontantMaxi;
                                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Modif.NewRow])^.Ligne.tva.MontantReel:=montantTva.retourMontantReel;
                                   DMEcritures.Ecriture_Isa1.CorrectionLigneTva(rangAModifier,Modif.NewRow,'T',true,grgrid1);
                                  end;
                                 end
                               else
                                 modif.NewRow:=-1
                             End;
                      end//fin s'il existe une autre ligne avec les mêmes parametre TVA
                    else
                      Begin//s'il n'existe pas une autre ligne avec les mêmes parametre TVA
                      //si on trouve la ligne de Tva correspondante
                      DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(Arow);//supprime ligne dans listIdentifiant
                      Modif.ASupprimer:=true;
                      modif.SupprAutomatique:=true;
                      Modif.NewRow:=DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf(TvaCompteTmp,'',4);
                      End;//fin s'il n'existe pas une autre ligne avec les mêmes parametre TVA
                   End//fin si la ligne a des parametre TVA
                 else
                    DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(Arow);//supprime ligne dans listIdentifiant
               End //fin si la ligne n'est pas vide et que s'est une ligne H ou X
               else
               if ((not(grgrid1.LigneVide(Arow)))and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Arow])^.Ligne.TypeLigne in ['T'])) then
                 begin
                   DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(Arow);//supprime ligne dans listIdentifiant
                   Modif.ASupprimer:=false;
                   Modif.NewRow:=-1;
                 end
              else
               DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(Arow);//supprime ligne dans listIdentifiant
          end
          else
          DMEcritures.Ecriture_Isa1.ListIdentifiant.Delete(Arow);//supprime ligne dans listIdentifiant
          if Modif.NewRow=-1 then
            begin //s'il n'y a pas de ligne a supprimer
  //            ligneCurr:=1;
  //            grgrid1.Row:=lignecurr;

            end;//fin s'il n'y a pas de ligne a supprimer
    End;
  except
  Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[Arow])^.Ligne.Complement:=lastParamLigne.Complement;
  Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[Arow])^.Ligne.TVA:=lastParamLigne.TVA;
  Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[Arow])^.Ligne.init:=lastParamLigne.init;
  abort;
  end;//fin du try except;
finally
//
end;//fin du try finally
end;


Function TsaisieP_3.RecupNumLigneTVA(TvaCompte:string):integer;
var
i:integer;
Begin
result:=-1;
i:=1;
while ((result=-1)and (i<=grgrid1.RowCount-1))do
   begin
     if grgrid1.Cells[1,i]=TvaCompte then
      //si on trouve la ligne de Tva correspondante
     result:=i;
      //fin si on trouve la ligne de Tva correspondante
     inc(i);
   end;
End;




procedure TsaisieP_3.BtnImprimerClick(Sender: TObject);
begin
//si on est dans l'entête                                
//                                    and(E.RemiseAuto)
if DMPieces.Piece1.AnneePiece.PieceAnterieure then e.PeriodeAutreImpression.Retour :=true;
if e.PeriodeAutreImpression.Retour then
  begin
    e.PeriodeAutreImpression.DateDeb:=0;
    e.PeriodeAutreImpression.DateFin:=e.DatExoFin;
  end;
if ((DMPieces.Piece1.IDJournal in [4])and (str_position_caseInsensitive('Remise',dmpieces.Piece1.libelle)<>0) and
    (Application.MessageBox(Pchar('Voulez-vous imprimer sous forme de remise ?'),'Confirmation',MB_ICONINFORMATION +MB_YESNO+MB_DEFBUTTON1)=mryes)) then
  EditionDesRemisesL(C_EditionSimple,false,dmpieces.Piece1.Reference,nil)
else
  EditionDesPiecesL(C_EditionSimple,false,dmpieces.Piece1.Reference,nil);
//GrGrid1StateChange(grgrid1.EtatGrille);
end;

procedure TsaisieP_3.BtnImprimerGrilleClick(Sender: TObject);
begin
//si on est dans la grille

//GrGrid1StateChange(grgrid1.EtatGrille);
end;

procedure TsaisieP_3.GrGrid1KeyPress(Sender: TObject; var Key: Char);
//var
//Shift: TShiftState;
//KeyTmp:Word;
begin
if (key=#42)and(grgrid1.col in [1]) then //reprendre dernier compte saisie
  begin
    grgrid1.InplaceEditor.Text:=DernierCompteSaisi;
    grgrid1.Cells[1,lignecurr]:=DernierCompteSaisi;
    grgrid1.InplaceEditor.SelStart:=grgrid1.InplaceEditor.SelLength;
    grgrid1.InplaceEditor.SelectAll;
  end;
if ((((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='V'))or(grgrid1.Cells[1,lignecurr]=''))and(grgrid1.col in [2,3,4,5,6])) then
  key:=#0;
if ((grgrid1.col in [1,3,4])and (not(key in [#9,#13]))) then
begin //si colonne compte Qt1 ou Qt2
  if DMEcritures.Ecriture_Isa1.ListIdentifiant.Count>LigneCurr then
     begin //on ne fait le traitement que si la ligne est valide dans la liste
     if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.ChampCompte.readOnly)and (grgrid1.col=1)) then
     key:=#0;
     if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.ChampQt1.readOnly)and (grgrid1.col=3)) then
     key:=#0;
     if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[lignecurr])^.Ligne.ChampQt2.readOnly)and (grgrid1.col=4)) then
     key:=#0;
     end;//fin on ne fait le traitement que si la ligne est valide dans la liste
end;//fin si colonne compte Qt1 ou Qt2
if DMPieces.Piece1.IDJournal=4 then
  begin //si journal de banque
    case grgrid1.col of
    1:begin
         if key in [#97..#122,#231..#233,#224,#249] then
           key:=uppercase(key)[1];
           if ((key = #43)and(length(grgrid1.InplaceEditor.Text)<=1))  then // +
             Begin
              if empty(grgrid1.InplaceEditor.Text) and E.PlanAuxT then
               begin
                 key:=#0;
                 grgrid1.InplaceEditor.Text:='+';
                 grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.Text);
                 PlusDefautCorps:=true;
                 PlusAutomatiqueCorps:=true;
                 grgrid1.cells[1,0]:='  Tiers';
                 EdPlusTiersCorps.Text:='+';
           //      if PlusDefautCorps then
               end
               else
               begin
                if PlusAutomatiqueCorps then
                 if copy(grgrid1.InplaceEditor.text,1,1)<>'+' then
                  begin
                   key:=#0;
                   grgrid1.InplaceEditor.text:='+'+grgrid1.InplaceEditor.text;
                   grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.Text);
                  end;
               end;
             End;

           // PB
           if ((key = #46)and(length(grgrid1.InplaceEditor.Text)<=1)) then // . pour enlever le + par défaut
             Begin
              if not empty(EdPlusTiersCorps.Text) then
               begin
                 grgrid1.cells[1,0]:='  Compte';
                 EdPlusTiersCorps.Text:='';
                 key:=#0;
                 grgrid1.InplaceEditor.Text:='';
                 grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.Text);
                 PlusDefautCorps:=False;
                 PlusAutomatiqueCorps:=False;
               end
               else
               Begin
                 grgrid1.cells[1,0]:='  Tiers';
                 EdPlusTiersCorps.Text:='+';
                 key:=#0;
                 grgrid1.InplaceEditor.Text:='+';
                 PlusDefautCorps:=True;
                 PlusAutomatiqueCorps:=True;
                 grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.Text);
               End;

             End;
            if key in [#65..#90,#97..#122] then
             Begin
              if E.PlanAuxT then
               begin
                 if copy(grgrid1.InplaceEditor.Text,1,1) <> '+' then
                 grgrid1.InplaceEditor.Text:='+'+grgrid1.InplaceEditor.Text;
                 grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.Text);
                 grgrid1.cells[1,0]:='  Tiers';
                 PlusDefautCorps:=true;
                 PlusAutomatiqueCorps:=true;
                 EdPlusTiersCorps.Text:='+';
               end;
              end;

            if ((key = #8) and (PlusAutomatiqueCorps) and (grgrid1.InplaceEditor.SelStart = 1)) then
             begin
                 grgrid1.cells[1,0]:='  Compte';
                 EdPlusTiersCorps.Text:='';
                 key:=#0;
                 grgrid1.InplaceEditor.Text:='';
                 grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.Text);
                 PlusDefautCorps:=False;
                 PlusAutomatiqueCorps:=False;
             end;
      end;//fin si colonne compte
    end;//fin du case colonne
  end;//fin si journal de banque

//if grgrid1.col=3 then
//  Begin
//     if grgrid1.InplaceEditor.Visible then      //
//      begin
//        if length(grgrid1.InplaceEditor.Text)<=1 then
//          begin
//           if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.SensCredit then
//             if not str_commence_par(grgrid1.InplaceEditor.Text,'-') then
//               grgrid1.InplaceEditor.Text:='-'+grgrid1.InplaceEditor.Text;
//             grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.Text);
//          end
//        else
//        if grgrid1.InplaceEditor.SelLength=length(grgrid1.InplaceEditor.Text) then
//          begin
//           if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.SensCredit then
//             grgrid1.InplaceEditor.Text:='-'+key;
//           grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.Text);
//          end;
//      end;
//  end;
end;


function EtatDuDataset(Etat:TDataSetState):string;
Begin
  case Etat of
  dsinsert:result:='Insertion';
  dsBrowse:result:='Consultation';
  dsedit:result:='Modification';
  dsInactive:result:='Inactive';
  end;//fin du case Etat
End;


procedure TsaisieP_3.CompLigneClick(Sender: TObject);
var
val,act:boolean;
LastComplement:TComplementLigne_obj;
InfosPiece_SurTypeLigne:tInfosPiece_SurTypeLigne;
begin
//try
if ((DMPieces.Piece1.IDJournal in [1,2])and(DMPieces.Piece1.TVA_A_Gerer))  then
   begin//si journal d'achat ou de vente
    If activecontrol = grgrid1 Then
      begin//si focus sur la grille
             if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='H')and(not(DMPlan.CptEstPointable(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Compte)))) then
               begin //si ligne H
                  with Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne do
                    begin
                      LastComplement:=Complement;
                      InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(ligneCurr,DMEcritures.Ecriture_Isa1.ListIdentifiant);
                      RecupInfosComplementLigne(true,Complement,TVA.CodeTva,TypeLigne,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Compte,InfosPiece_SurTypeLigne.solde);
                      if LastComplement.CodeTvaCompl<>complement.CodeTvaCompl then
                        RecupererParametresLignes(ligneCurr);
                    end;//fin du with
                  GrGrid1RowValidate(grgrid1,val,act,1);
                  DMEcritures.Ecriture_Isa1.ModificationSuppressionLigneTva('H',modif,GrGrid1);
                  CalculSolde;
                  if ((modif.ASupprimer)and (modif.NewRow<>-1)) then
                  //si on doit supprimer la ligne tva et que
                  // NewRow(Ligne à supprimer) est rempli, Suppression de la ligne TVA
                  begin
                  modif.ASupprimer:=false;
                  grgrid1.SupprimeLigne(Modif.NewRow)
                  end
                  else //si on ne doit pas supprimer la ligne tva et que
                    // NewRow(Ligne à modifier) est rempli, positionnement sur la ligne TVA
                    if ((modif.ASupprimer=false)and (modif.NewRow<>-1)) then
                    begin
                    grgrid1.OnRowValidate:=nil;
                    grgrid1.row:=modif.NewRow;
                    GrGrid1RowEnter(grgrid1,grgrid1.row);
                    modif.NewRow:=-1;
                    abort;
                    end;
                   modif.NewRow:=-1;
                 DMEcritures.Ecriture_Isa1.ModificationSuppressionLigneTva('H',modif,GrGrid1);
                 CalculSolde;
                end;//fin si ligne H
      end; //fin si focus sur la grille
   end;//fin si journal d'achat ou de vente
end;



procedure TsaisieP_3.RecupInfosComplementLigne(PourAffichage:boolean;var ComplementLigne:TComplementLigne_obj;CodeTva:string;typeL:Char;Cpt:string;HT:currency;Forcage:boolean);
//procedure utilisant une constante 'D' pour Debit et 'E' pour Encaissement
var
CodeTvaTmp,TvaTypeTmp,TvaDateTmp:string;
TvaTauxTmp:real;
MontantTvaTmp:currency;
//MontantTVA:TRetourMontantTva;
//paramTva:TRecupParamTva_obj;
tab:variant;
complementTmp:TComplementLigne_obj;
Verrouillage:TVerrouillage;
gerer:boolean;
CompteTvaTmp:string;
ModifiableTmp:boolean;
Infosplancpt:TInfosplancpt;
TauxIntra:string;
begin
gerer:=false;
ModifiableTmp:=false;

  if PourAffichage then
  begin//si récupération pour afficher la fenêtre du complément ligne
     if not ComplementLigne.rempli then
       begin //si le complément ligne n'est pas rempli
//       récupération des parametres par défaut du compte et de la piece
       CodeTvaTmp:=CodeTva;
          if((not empty(CodeTvaTmp))and(not empty(grgrid1.Cells[1,ligneCurr])))then //si parametre tva rempli, récupération du type dans la table CODETVA
          begin
            //RenvoieInfoSurTableDiverse(grgrid1.Cells[1,ligneCurr],DMEcritures.Ecriture_Isa1.TablePlan,'Compte',['TvaType','Taux'],tab);
            defiltrageDataset(DMRech_Obj.TaPlanCpt_Obj);
            Infosplancpt:=Infos_TInfosplancpt(DMRech_Obj.TaPlanCpt_Obj,'compte',[grgrid1.Cells[1,ligneCurr]]);
            TvaTypeTmp:=Infosplancpt.TvaType;
            TvaTauxTmp:=Infosplancpt.taux;
//            TvaTypeTmp:=tab[0];
//            TvaTauxTmp:=tab[1];
            if empty(TvaTypeTmp)then
            TvaTypeTmp:='D';/////// ????? A Revoir ?????? //////////////
          end
          else
          TvaTypeTmp:='';
//       if tvatypeTmp='D' then
       TvaDateTmp:=EdDateLivraison.Text;//date par défaut
//       else
//       TvaDateTmp:='';
       if empty(CodeTvaTmp)then
         begin
         TvaTauxTmp:=0;
         MontantTvaTmp:=0;
         end
       else
         begin
         defiltrageDataset(DMRech_Obj.TaTvaCode_Obj);
         if ((TvaTauxTmp=0)or(DM_C_ListeCTVAVente.IndexOf(copy(CodeTvaTmp,1,1))=0)) then
           TvaTauxTmp:=Infos_TInfosTvaCode(DMRech_Obj.TaTvaCode_Obj,'TvaCode',[CodeTvaTmp]).Taux_Supp;
           //TvaTauxTmp:=StrToFloat_Lgr(RenvoieInfoSurTableDiverse(CodeTvaTmp,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Taux_supp'],tab));
           //isa le 26-06-03
           //TvaTauxTmp:=StrToFloat_Lgr(RenvoieInfoSurTableDiverse(CodeTvaTmp,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Taux_Inf'],tab));
         MontantTvaTmp:=arrondi(HT*TvaTauxTmp/100,2);//à remplir lors de l'enregistrement du debit ou crédit
         end;
       end //fin si le complément ligne n'est pas rempli
     else
       begin //si le complément ligne est déjà rempli
       CodeTvaTmp:=ComplementLigne.CodeTvaCompl;
       TvaTypeTmp:=ComplementLigne.TvaType;
       TvaDateTmp:=ComplementLigne.TvaDate;
       TvaTauxTmp:=ComplementLigne.TvaTaux;
       MontantTvaTmp:=ComplementLigne.MontantTva;
       end; //fin si le complément ligne est déjà rempli

       if not ComplementLigne.rempli then
       Begin
       DMPieces.Piece1.InitialiseInfosVerrouillage(Verrouillage);

       EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,(DMPieces.Piece1.EtatPiece<>dsedit),false,TvaTypeTmp);
       End;
       complementTmp:=ComplementLigne;

     //affichage de la fenêtre de complément ligne avec infos par défaut
     if ComplementLigneAffiche(1,TypeL,Cpt,datetostr(DMPieces.Piece1.DateSaisie),CodeTvaTmp,TvaTypeTmp,TvaDateTmp,HT,TvaTauxTmp,MontantTvaTmp)then
      begin //si retour de la fenêtre du complement ligne ok
      DMPieces.Piece1.InitialiseInfosVerrouillage(Verrouillage);
//
//       if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
       if (not Gestionimmos.supprimerImmos)and (not Gestionimmos.supprimerCessions) and (DMPieces.Piece1.EtatPiece=dsEdit) then
        begin
           if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,-1).retour= false then abort;
        end;
//
      if (DateValide(TvaDateTmp))then
        Verrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,StrToDate_Lgr(TvaDateTmp))
      else
        Verrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,0);
      if not empty(CodeTvaTmp)then
        gerer:=not((empty(complementTmp.CodeTvaCompl))and(uppercase(CodeTvaTmp)[1]in ['C','E','L','N','F','M']));
      if ((gerer)and(not empty(complementTmp.CodeTvaCompl)))then
        gerer:=not((empty(CodeTvaTmp))and(uppercase(complementTmp.CodeTvaCompl)[1]in ['C','E','L','N','F','M']));
      if ((complementTmp.CodeTvaCompl<>CodeTvaTmp)or(complementTmp.TvaDate<>TvaDateTmp)or
      (complementTmp.TvaTaux<>TvaTauxTmp)or(complementTmp.MontantTva<>MontantTvaTmp)or(complementTmp.TvaType<>TvaTypeTmp))then
        begin //s'il y a une modif dans complement ligne
          if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and(DMPieces.Piece1.etatpiece=dsedit)) then
           begin //si piece en edit et pas encore modifiée
             if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                begin
                  if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                     ModifiableTmp:=true;
                end
             else
                ModifiableTmp:=true;
           if ModifiableTmp then //si on veut quand même la modifier
             Begin //si on veut quand même modifier
                   if EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,gerer,true,TvaTypeTmp)then
                     DMPieces.Piece1.Modifier_EnAttente:=true;
             End; //fin si on veut quand même modifier
           end  //fin si piece en edit et pas encore modifiée
           else
               EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,gerer,true,TvaTypeTmp);
        end;//fin s'il y a une modif dans complement ligne
      end; //fi  si retour de la fenêtre du complement ligne ok
  end //fin si récupération pour afficher la fenêtre du complément ligne
  else
  begin //si juste récupération du complément pour enregistrement
  if ((not complementLigne.rempli)or(forcage)) then
    begin //si complément n'est pas rempli, on récupère les parmètres TVA du compte directement
        if forcage then
          begin //si le complément ligne est déjà rempli
             complementTmp.CodeTvaCompl:=ComplementLigne.CodeTvaCompl;
             complementTmp.TvaType:=ComplementLigne.TvaType;
             complementTmp.TvaDate:=ComplementLigne.TvaDate;
             complementTmp.TvaTaux:=ComplementLigne.TvaTaux;
             complementTmp.MontantTva:=ComplementLigne.MontantTva;
          end //fin si le complément ligne est déjà rempli
        else
          begin
          complementTmp.CodeTvaCompl:=CodeTva;
             if((not empty(complementTmp.CodeTvaCompl))and(not empty(grgrid1.Cells[1,ligneCurr])))then //si parametre tva rempli, récupération du type dans la table CODETVA
             begin
              DeFiltrageDataSet(dmrech_obj.TaPlanCpt_Obj);
            // RenvoieInfoSurTableDiverse(grgrid1.Cells[1,ligneCurr],DMEcritures.Ecriture_Isa1.TablePlan,'Compte',['TvaType','Taux'],tab);
             Infosplancpt:=Infos_TInfosplancpt(dmrech_obj.TaPlanCpt_Obj,'compte',[grgrid1.Cells[1,ligneCurr]]);
             complementTmp.TvaType:=Infosplancpt.TvaType;
      //       complementTmp.TvaType:=tab[0];
      //       try
      //         if not empty(tab[1])then
      //           complementTmp.TvaTaux:=tab[1]
      //         else
      //           complementTmp.TvaTaux:=0;
                complementTmp.TvaTaux:=Infosplancpt.taux;
                while (complementTmp.TvaTaux=0)and(uppercase(CodeTva)[1] in ['C','M'] ) do
                begin
                      TauxIntra:='5.5';
                      MyInputQuery_Chiffre(self,'Taux de Tva intra-communautaire','Ce compte est paramétré avec le code tva C1 ou M1'+RetourChariotSimple+
                      '(Tva sur acquisition intracommunautaire)'+RetourChariotSimple+'Merci d''indiquer le taux de tva lié à cette acquisition :',
                      TauxIntra,'',[#48..#57,DecimalSeparator],0,100,true);
                      complementTmp.TvaTaux:=StrToFloat_Lgr(TauxIntra);
                end;
      //       except

      //       end;
               if empty(complementTmp.TvaType)then
               complementTmp.TvaType:='D';/////// ????? A Revoir ?????? //////////////
             end
             else
             complementTmp.TvaType:='';

          if complementTmp.TvaType='D'then
              complementTmp.TvaDate:=EdDateLivraison.Text//date par défaut
          else complementTmp.TvaDate:='';

             if empty(complementTmp.CodeTvaCompl)then
               begin
               complementTmp.TvaTaux:=0;
               complementTmp.MontantTVA:=0;
               end
             else
               begin
               DeFiltrageDataSet(dmrech_obj.TaTvaCode_Obj);
               //if tab[1]=0 then
        //       if RenvoieInfoSurTableDiverse(grgrid1.Cells[1,ligneCurr],DMEcritures.Ecriture_Isa1.TablePlan,'Compte',['Taux'],tab)='0'then
      //           complementTmp.TvaTaux:=StrToFloat_Lgr(RenvoieInfoSurTableDiverse(complementTmp.CodeTvaCompl,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Taux_Supp'],tab));
      //         if Infos_TInfosplancpt(DMEcritures.Ecriture_Isa1.TablePlan,'compte',[grgrid1.Cells[1,ligneCurr]]).taux=0 then

               //si taux pas rempli ou tva sur vente, on récupère le mini et le maxi dans la table des codes tva.
               if ((complementTmp.TvaTaux=0)or(DM_C_ListeCTVAVente.IndexOf(copy(complementTmp.CodeTvaCompl,1,1))=0)) then
                 complementTmp.TvaTaux:=Infos_TInfosTvaCode(dmrech_obj.TaTvaCode_Obj,'TvaCode',[complementTmp.CodeTvaCompl]).Taux_Supp;
               complementTmp.MontantTva:=arrondi(HT*complementTmp.TvaTaux/100,2);//à remplir lors de l'enregistrement du debit ou crédit
               end;
          end;

    //EcritureDuComplementLigne(ComplementLigne,[complementTmp.CodeTvaCompl,complementTmp.TvaDate,complementTmp.TvaType,complementTmp.TvaTaux,complementTmp.MontantTva,true],[1,2,3,4,5,6],Verrouillage,false,true,complementTmp.TvaType);
    if not EcritureDuComplementLigne(ComplementLigne,[complementTmp.CodeTvaCompl,complementTmp.TvaDate,complementTmp.TvaType,complementTmp.TvaTaux,complementTmp.MontantTva,true],[1,2,3,4,5,6],Verrouillage,(dmpieces.piece1.etatpiece<>dsedit),true,complementTmp.TvaType)then
      abort
    else
      complementLigne.rempli:=true;
    //CompteTvaTmp:=RenvoieInfoSurTableDiverse(complementTmp.CodeTvaCompl,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Compte'],tab);
    DeFiltrageDataSet(dmrech_obj.TaTvaCode_Obj);
    CompteTvaTmp:=Infos_TInfosTvaCode(dmrech_obj.TaTvaCode_Obj,'TvaCode',[complementTmp.CodeTvaCompl]).Compte;
    if ((not empty (CompteTvaTmp))and (not empty(complementTmp.CodeTvaCompl)))then
       begin //si code tva intracommunautaire
         complementTmp.TvaDate:='';
          while ((complementTmp.TvaTaux=0)and(empty(CompteTvaTmp))) do
          begin //début du while tvataux=0 and code='C'ou 'E' ou 'L' ou 'N' ou 'F' ou 'M'
          Application.MessageBox(Pchar('Vous devez saisir un taux de tva pour Le type de TVA employé avec le compte : '+cpt+' !!!'),'Avertissement',0);
          CodeTvaTmp:=complementTmp.CodeTvaCompl;
          TvaTypeTmp:=complementTmp.TvaType;
          TvaDateTmp:=complementTmp.TvaDate;
          TvaTauxTmp:=complementTmp.TvaTaux;
             if ComplementLigneAffiche(1,TypeL,Cpt,datetostr(DMPieces.Piece1.DateSaisie),CodeTvaTmp,TvaTypeTmp,TvaDateTmp,HT,TvaTauxTmp,MontantTvaTmp)then
                 begin
                 if TvaDateTmp<>complementTmp.TvaDate then
                    EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,true,true,TvaTypeTmp)
                 else
                    //EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,false,true,TvaTypeTmp);
                    EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,(dmpieces.piece1.etatpiece<>dsedit),true,TvaTypeTmp);
           //          showmessage(Complement.CodeTvaCompl+','+Complement.TvaType+','+Complement.TvaDate+','+currtostr(Complement.TvaTaux));
                 end;
          //CompteTvaTmp:=RenvoieInfoSurTableDiverse(CodeTvaTmp,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Compte'],tab);
          DeFiltrageDataSet(dmrech_obj.TaTvaCode_Obj);
          CompteTvaTmp:=Infos_TInfosTvaCode(DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',[CodeTvaTmp]).Compte;
          end; //fin du while tvataux=0 code='C'ou 'E' ou 'L' ou 'N' ou 'F' ou 'M'
       end; //fin si code tva intracommunautaire
    end;//fin si complément n'est pas rempli,
  end;//fin si juste récupération du complément pour enregistrement
//  end;//fin du with
end;
//procedure TsaisieP_3.RecupInfosComplementLigne(PourAffichage:boolean;var ComplementLigne:TComplementLigne_obj;CodeTva:string;typeL:Char;Cpt:string;HT:currency;Forcage:boolean);
//
////procedure utilisant une constante 'D' pour Debit et 'E' pour Encaissement
//var
//CodeTvaTmp,TvaTypeTmp,TvaDateTmp:string;
//TvaTauxTmp:real;
//MontantTvaTmp:currency;
////MontantTVA:TRetourMontantTva;
////paramTva:TRecupParamTva_obj;
//tab:variant;
//complementTmp:TComplementLigne_obj;
//Verrouillage:TVerrouillage;
//gerer:boolean;
//CompteTvaTmp:string;
//ModifiableTmp:boolean;
//begin
//gerer:=false;
//ModifiableTmp:=false;
//
//  if PourAffichage then
//  begin//si récupération pour afficher la fenêtre du complément ligne
//     if not ComplementLigne.rempli then
//       begin //si le complément ligne n'est pas rempli
////       récupération des parametres par défaut du compte et de la piece
//       CodeTvaTmp:=CodeTva;
//          if((not empty(CodeTvaTmp))and(not empty(grgrid1.Cells[1,ligneCurr])))then //si parametre tva rempli, récupération du type dans la table CODETVA
//          begin
//            RenvoieInfoSurTableDiverse(grgrid1.Cells[1,ligneCurr],DMEcritures.Ecriture_Isa1.TablePlan,'Compte',['TvaType','Taux'],tab);
//            TvaTypeTmp:=tab[0];
//            TvaTauxTmp:=tab[1];
//            if empty(TvaTypeTmp)then
//            TvaTypeTmp:='D';/////// ????? A Revoir ?????? //////////////
//          end
//          else
//          TvaTypeTmp:='';
////       if tvatypeTmp='D' then
//       TvaDateTmp:=EdDateLivraison.Text;//date par défaut
////       else
////       TvaDateTmp:='';
//       if empty(CodeTvaTmp)then
//         begin
//         TvaTauxTmp:=0;
//         MontantTvaTmp:=0;
//         end
//       else
//         begin
//         if tab[1]=0 then
//           TvaTauxTmp:=strtofloat(RenvoieInfoSurTableDiverse(CodeTvaTmp,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Taux_supp'],tab));
//           //isa le 26-06-03
//           //TvaTauxTmp:=strtofloat(RenvoieInfoSurTableDiverse(CodeTvaTmp,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Taux_Inf'],tab));
//         MontantTvaTmp:=arrondi(HT*TvaTauxTmp/100,2);//à remplir lors de l'enregistrement du debit ou crédit
//         end;
//       end //fin si le complément ligne n'est pas rempli
//     else
//       begin //si le complément ligne est déjà rempli
//       CodeTvaTmp:=ComplementLigne.CodeTvaCompl;
//       TvaTypeTmp:=ComplementLigne.TvaType;
//       TvaDateTmp:=ComplementLigne.TvaDate;
//       TvaTauxTmp:=ComplementLigne.TvaTaux;
//       MontantTvaTmp:=ComplementLigne.MontantTva;
//       end; //fin si le complément ligne est déjà rempli
//
//       if not ComplementLigne.rempli then
//       Begin
//       DMPieces.Piece1.InitialiseInfosVerrouillage(Verrouillage);
//
//       EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,(DMPieces.Piece1.EtatPiece<>dsedit),false,TvaTypeTmp);
//       End;
//       complementTmp:=ComplementLigne;
//
//     //affichage de la fenêtre de complément ligne avec infos par défaut
//     if ComplementLigneAffiche(1,TypeL,Cpt,datetostr(DMPieces.Piece1.DateSaisie),CodeTvaTmp,TvaTypeTmp,TvaDateTmp,HT,TvaTauxTmp,MontantTvaTmp)then
//      begin //si retour de la fenêtre du complement ligne ok
//      DMPieces.Piece1.InitialiseInfosVerrouillage(Verrouillage);
////
//       if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
//        begin
//           if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,-1).retour= false then abort;
//        end;
////
//      if (DateValide(TvaDateTmp))then
//        Verrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,strtodate(TvaDateTmp))
//      else
//        Verrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,0);
//      if not empty(CodeTvaTmp)then
//        gerer:=not((empty(complementTmp.CodeTvaCompl))and(uppercase(CodeTvaTmp)[1]in ['C','E','L','N','F','M']));
//      if ((gerer)and(not empty(complementTmp.CodeTvaCompl)))then
//        gerer:=not((empty(CodeTvaTmp))and(uppercase(complementTmp.CodeTvaCompl)[1]in ['C','E','L','N','F','M']));
//      if ((complementTmp.CodeTvaCompl<>CodeTvaTmp)or(complementTmp.TvaDate<>TvaDateTmp)or
//      (complementTmp.TvaTaux<>TvaTauxTmp)or(complementTmp.MontantTva<>MontantTvaTmp)or(complementTmp.TvaType<>TvaTypeTmp))then
//        begin //s'il y a une modif dans complement ligne
//          if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and(DMPieces.Piece1.etatpiece=dsedit)) then
//           begin //si piece en edit et pas encore modifiée
//             if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
//                begin
//                  if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
//                     ModifiableTmp:=true;
//                end
//             else
//                ModifiableTmp:=true;
//           if ModifiableTmp then //si on veut quand même la modifier
//             Begin //si on veut quand même modifier
//                   if EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,gerer,true,TvaTypeTmp)then
//                     DMPieces.Piece1.Modifier_EnAttente:=true;
//             End; //fin si on veut quand même modifier
//           end  //fin si piece en edit et pas encore modifiée
//           else
//               EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,gerer,true,TvaTypeTmp);
//        end;//fin s'il y a une modif dans complement ligne
//      end; //fi  si retour de la fenêtre du complement ligne ok
//  end //fin si récupération pour afficher la fenêtre du complément ligne
//  else 
//  begin //si juste récupération du complément pour enregistrement
//  if ((not complementLigne.rempli)or(forcage)) then
//    begin //si complément n'est pas rempli, on récupère les parmètres TVA du compte directement
//    complementTmp.CodeTvaCompl:=CodeTva;
//       if((not empty(complementTmp.CodeTvaCompl))and(not empty(grgrid1.Cells[1,ligneCurr])))then //si parametre tva rempli, récupération du type dans la table CODETVA
//       begin
//       RenvoieInfoSurTableDiverse(grgrid1.Cells[1,ligneCurr],DMEcritures.Ecriture_Isa1.TablePlan,'Compte',['TvaType','Taux'],tab);
//       complementTmp.TvaType:=tab[0];
//       try
//         if not empty(tab[1])then
//           complementTmp.TvaTaux:=tab[1]
//         else
//           complementTmp.TvaTaux:=0;
//       except
//
//       end;
//         if empty(complementTmp.TvaType)then
//         complementTmp.TvaType:='D';/////// ????? A Revoir ?????? //////////////
//       end
//       else
//       complementTmp.TvaType:='';
////    if complementTmp.TvaType='D'then
//    complementTmp.TvaDate:=EdDateLivraison.Text;//date par défaut
////    else complementTmp.TvaDate:='';
//
//       if empty(complementTmp.CodeTvaCompl)then
//         begin
//         complementTmp.TvaTaux:=0;
//         complementTmp.MontantTVA:=0;
//         end
//       else
//         begin
//         //if tab[1]=0 then
//         if RenvoieInfoSurTableDiverse(grgrid1.Cells[1,ligneCurr],DMEcritures.Ecriture_Isa1.TablePlan,'Compte',['Taux'],tab)='0'then
//           //complementTmp.TvaTaux:=strtofloat(RenvoieInfoSurTableDiverse(complementTmp.CodeTvaCompl,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Taux_Inf'],tab));
//         complementTmp.TvaTaux:=strtofloat(RenvoieInfoSurTableDiverse(complementTmp.CodeTvaCompl,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Taux_Supp'],tab));
//         complementTmp.MontantTva:=arrondi(HT*complementTmp.TvaTaux/100,2);//à remplir lors de l'enregistrement du debit ou crédit
//         end;
//    //EcritureDuComplementLigne(ComplementLigne,[complementTmp.CodeTvaCompl,complementTmp.TvaDate,complementTmp.TvaType,complementTmp.TvaTaux,complementTmp.MontantTva,true],[1,2,3,4,5,6],Verrouillage,false,true,complementTmp.TvaType);
//    if not EcritureDuComplementLigne(ComplementLigne,[complementTmp.CodeTvaCompl,complementTmp.TvaDate,complementTmp.TvaType,complementTmp.TvaTaux,complementTmp.MontantTva,true],[1,2,3,4,5,6],Verrouillage,(dmpieces.piece1.etatpiece<>dsedit),true,complementTmp.TvaType)then
//      abort
//    else
//      complementLigne.rempli:=true;
//    CompteTvaTmp:=RenvoieInfoSurTableDiverse(complementTmp.CodeTvaCompl,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Compte'],tab);
//    if ((not empty (CompteTvaTmp))and (not empty(complementTmp.CodeTvaCompl)))then
//       begin //si code tva intracommunautaire
//       complementTmp.TvaDate:='';
//          while ((complementTmp.TvaTaux=0)and(empty(CompteTvaTmp))) do
//          begin //début du while tvataux=0 and code='C'ou 'E' ou 'L' ou 'N'
//          Application.MessageBox(Pchar('Vous devez saisir un taux de tva pour Le type de TVA employé avec le compte : '+cpt+' !!!'),'Avertissement',0);
//          CodeTvaTmp:=complementTmp.CodeTvaCompl;
//          TvaTypeTmp:=complementTmp.TvaType;
//          TvaDateTmp:=complementTmp.TvaDate;
//          TvaTauxTmp:=complementTmp.TvaTaux;
//             if ComplementLigneAffiche(1,TypeL,Cpt,datetostr(DMPieces.Piece1.DateSaisie),CodeTvaTmp,TvaTypeTmp,TvaDateTmp,HT,TvaTauxTmp,MontantTvaTmp)then
//                 begin
//                 if TvaDateTmp<>complementTmp.TvaDate then
//                    EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,true,true,TvaTypeTmp)
//                 else
//                    //EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,false,true,TvaTypeTmp);
//                    EcritureDuComplementLigne(ComplementLigne,[CodeTvaTmp,TvaDateTmp,TvaTypeTmp,TvaTauxTmp,MontantTvaTmp,true],[1,2,3,4,5,6],Verrouillage,(dmpieces.piece1.etatpiece<>dsedit),true,TvaTypeTmp);
//           //          showmessage(Complement.CodeTvaCompl+','+Complement.TvaType+','+Complement.TvaDate+','+currtostr(Complement.TvaTaux));
//                 end;
//          CompteTvaTmp:=RenvoieInfoSurTableDiverse(CodeTvaTmp,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Compte'],tab);
//          end; //fin du while tvataux=0 code='C'ou 'E' ou 'L' ou 'N'
//       end; //fin si code tva intracommunautaire
//    end;//fin si complément n'est pas rempli,
//  end;//fin si juste récupération du complément pour enregistrement
////  end;//fin du with
//end;


procedure TsaisieP_3.EdDateEcheanceExit(Sender: TObject);
var
Valide: TErreurSaisie;
Adate:TDateTime;
begin
valide.retour:=true;
valide.CodeErreur:=0;
ADate:=EdDateEcheance.date;
EdDateEcheanceAcceptDate(EdDateEcheance,ADate,valide.retour);
if not valide.retour then
   begin
   EdDateEcheance.SetFocus;
   abort;
   end
else
  begin
    DMPieces.Piece1.DateEcheance:=EdDateEcheance.date;
   if DMPieces.Piece1.Modifier_EnAttente then
     begin
       DMPieces.Piece1.Modifier_Confirmer:=true;
       DMPieces.Piece1.Modifier_EnAttente:=false;
     end;
  end;

end;



procedure TsaisieP_3.EdDateLivraisonExit(Sender: TObject);
var
Valide: TErreurSaisie;
Adate:TDateTime;
begin
valide.retour:=true;
valide.CodeErreur:=0;
ADate:=EdDateLivraison.date;
EdDateLivraisonAcceptDate(eddateLivraison,ADate,valide.retour);
if not valide.retour then
   begin
   EdDateLivraison.SetFocus;
   abort;
   end
else
  begin
    DMPieces.Piece1.DateLivraison:=eddatelivraison.Date;
   if DMPieces.Piece1.Modifier_EnAttente then
     begin
       DMPieces.Piece1.Modifier_Confirmer:=true;
       DMPieces.Piece1.Modifier_EnAttente:=false;
     end;
  end;
end;



procedure TsaisieP_3.EdDateLivraisonAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
var
i,rangTva,rangHT_D:integer;
verrouillage:TVerrouillage;
messagetmp1,messagetmp2:string;
begin
messagetmp2:='Voulez-vous la conserver ?';
if datetostr(Adate)<>DateLivraisonTmp then
   begin //si la date est modifiée
//  TableGereStartTransaction(DMPieces.Piece1.TablePiece);
//if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
if (not Gestionimmos.supprimerImmos)and (not Gestionimmos.supprimerCessions) and (DMPieces.Piece1.EtatPiece=dsEdit) then
 begin
    if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,-1).retour= false then action:=false;
 end;
   if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
      Begin
        action:=false; //si piece non modifiable
        showmessage('Cette pièce n''est pas modifiable ');
      End
   else
      Begin//si piece modifiable
        //recupérer infos verrouillage sur nouvelle date
        DMPieces.Piece1.InitialiseInfosVerrouillage(Verrouillage);
        verrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,Adate);
        if ((verrouillage.PieceVerrouillee)and(DMPieces.Piece1.IDJournal in [1,2,3,4])) then
            Begin//si pièce verrouillee
              if not verrouillage.Deverrouillable then
                begin//si non déverrouillable
                  Application.MessageBox(Pchar('Attention, cette pièce est verrouillée et non déverrouillable, Vous ne pouvez pas la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_OK);
                  action:=false;
                end//fin si non déverrouillable
              else
                Begin//si deverrouillable
                   TraitementPourGerer_ModifPiece_et_TVA(3,action,'Attention, cette pièce est verrouillée, si vous la modifiez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! '+messagetmp2,Adate,(Sender <>nil) );
                End;//fin si deverrouillable
            End//fin si pièce verrouillee
        else
           if ((verrouillage.PeriodeVerrouillee)and(DMPieces.Piece1.IDJournal in [1,2,3,4])) then
             Begin //si la nouvelle date fait partie d'une période verrouillée et que l'on est dans un journal de vente ou d'achat
               rangTva:=DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('T','',2);
               rangHT_D:= DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('D','',24);
               if ((not verrouillage.Deverrouillable)or(not verrouillage.PeriodeDeverrouillable)) then
                  begin //si non deverrouillable
                  if ((rangTva<>-1)and(rangHT_D<>-1)) then
                    Begin //s'il y a des lignes de tva ou des lignes hors taxes attendant de la TVA
                     //Traitement prochaine déclaration
                     ADate:=E.DateDebutDeclarationTVA;
                     if (DMPieces.Piece1.IDJournal in [1,2,3]) then
                       messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée et non déverrouillable, si vous la conservez,les lignes de TVA enregistrées avec cette date seront déclarées dans la prochaine déclaration ! '
                     else
                       messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée et non déverrouillable, si vous la conservez,Vous ne pourrez pas pointer cette pièce avec une pièce comportant de la Tva sur Encaissement ! ';
                     if not empty(messagetmp1) then
                       TraitementPourGerer_ModifPiece_et_TVA(2,action,messagetmp1+messagetmp2,ADATE,(Sender <>nil) )
                     else
                       TraitementPourGerer_ModifPiece_et_TVA(2,action,'',ADATE,(Sender <>nil) );
                    End //fin s'il y a des lignes de tva ou des lignes hors taxes attendant de la TVA
                  else
                    Begin //s'il n'y a pas de TVA
                    //on ne fait que le traitement pour gerer les modif sur la pièce
                     TraitementPourGerer_ModifPiece_et_TVA(1,action,'',Adate,(Sender <>nil) );
                     if (DMPieces.Piece1.IDJournal in [1,2,3]) then
                       messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée, si vous la conservez, la date de Livraison sera remplacée par celle de la prochaine déclaration ainsi que les nouvelles lignes de Hors Taxes attendant de la TVA ! '
                     else
                       messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée et non déverrouillable, si vous la conservez,Vous ne pourrez pas pointer cette pièce avec une pièce comportant de la Tva sur Encaissement ! ';
                     if not empty(messagetmp1)then
                     begin
                        if ((action)and (Application.MessageBox(Pchar(messagetmp1+messagetmp2),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno)) then
                          Begin
                           action:=false;
                          End
                        else
                          ADate:=E.DateDebutDeclarationTVA;
                     end;
                    End; //fin s'il n'y a pas de TVA
                  end //fin si non deverrouillable
               else
                  Begin //si deverrouillable
                  if ((rangTva<>-1)and(rangHT_D<>-1)) then
                    Begin //s'il y a des lignes de tva ou des lignes hors taxes attendant de la TVA
                     //Traitement prochaine déclaration
                     if (DMPieces.Piece1.IDJournal in [1,2,3]) then
//                        messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée, si vous la conservez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! '
                        messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée, si vous la conservez, la date de Livraison sera remplacée par celle de la prochaine déclaration ainsi que les nouvelles lignes de Hors Taxes attendant de la TVA ! '
                     else
                       messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée , si vous la conservez,Vous devrez supprimer la dernière déclaration de TVA avant de pouvoir pointer cette pièce avec une pièce comportant de la Tva sur Encaissement ! ';
                     if not empty(messagetmp1)then
                       TraitementPourGerer_ModifPiece_et_TVA(2,action,messagetmp1+messagetmp2,Adate,(Sender <>nil) )
                     else
                       TraitementPourGerer_ModifPiece_et_TVA(2,action,'',Adate,(Sender <>nil) );
                     If not empty(messagetmp1) then
                        if ((action) and (Application.MessageBox(Pchar(messagetmp1+messagetmp2),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno)) then
                        Begin
                         action:=false;
                        End;                       
                    End //fin s'il y a des lignes de tva ou des lignes hors taxes attendant de la TVA
                  else
                    Begin //s'il n'y a pas de TVA en D
                    //on ne fait que le traitement pour gerer les modif sur la pièce
                     //if (DMPieces.Piece1.IDJournal in [1,2,3]) then
//  isa le 26-05-03      messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée, en la conservant, Vous devrez supprimer la dernière déclaration TVA pour créer de nouvelles lignes de Hors Taxes attendant de la TVA !'
                     //else
                       //messagetmp1:='Attention, cette date fait partie d''une période de TVA déclarée , si vous la conservez,Vous devrez supprimer la dernière déclaration de TVA avant de pouvoir pointer cette pièce avec une pièce comportant de la Tva sur Encaissement ! ';
                     TraitementPourGerer_ModifPiece_et_TVA(1,action,'',Adate,(Sender <>nil) );
                     If not empty(messagetmp1) then
                        if ((action) and (Application.MessageBox(Pchar(messagetmp1+messagetmp2),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno)) then
                        Begin
                         action:=false;
                        End;
                    End; //fin s'il n'y a pas de TVA en D
                  End; //fin si deverrouillable
             end//fin si la nouvelle date fait partie d'une période verrouillée et que l'on est dans un journal de vente ou d'achat
           else
             begin //si nouvelle correct ou journal different d'achat ou vente
             //on ne fait que le traitement pour gerer les modif sur la pièce
              TraitementPourGerer_ModifPiece_et_TVA(1,action,'',Adate,(Sender <>nil) );
             end; //fin si nouvelle correct ou journal <> d'achat ou vente
            if action then
              begin
               DMPieces.Piece1.Modifier_EnAttente:=true;
               DMPieces.Piece1.DateLivraison:=ADate;
               dateLivraisontmp:=datetostr(ADate);
              end
            else
              begin
              EdDateLivraison.text:=dateLivraisontmp;
              ADate:=StrToDate_Lgr(dateLivraisontmp);
              end;
//         else
//           Begin//si pièce antérieure
//            if verrouillage.PieceVerrouillee then
//              Begin
//                action:=false; //si piece non modifiable
//                showmessage('Cette pièce est verrouillée, elle n''est pas modifiable ');
//              End;
//           End;//fin si pièce antérieure
      End;//fin si piece modifiable
   End;//fin si pièce modifiée
end;


procedure TsaisieP_3.Rglement1Click(Sender: TObject);
var
//totalDebit,TotalCredit,
MontantAPointer:currency;
tableEcritureTemp:TTable;
QueryTmp:TQuery;
conteneur:TPointage;
ListeTmp:TStringList;
TabIDSupprime:array[0..2] of integer;
ParamAffichPointage:TParamAffichPointage;
PointagesEnCours:TResultStrList;
infosLigne:TInfosPiece_SurTypeLigne;
InfoResteDCSurCompte:TInfoResteDCSurCompte;
SensRecherche:string;
validationTmp:boolean;
rang,i:integer;
ParamAfficheSaisieReglement:TParamAfficheSaisieReglement;
begin
  try//début try finally
    QueryTmp:=TQuery.create(self);
    QueryTmp.DataBaseName:=DM_C_NomAliasDossier;
    QueryTmp.name:='Rglement1Click';
//    QueryTmp.DataBaseName:=DMPointage2.TaPointage.DatabaseName;
    QueryTmp.sql.Clear;
    try //début try except
     //avant il faut récupérer infos pointage de la pièce ainsi que son sens, le tiers
     with DMPieces.Piece1 do
        begin// début du with DMPieces.Piece1
              ListeTmp:=TStringList.Create;
             if ActiveControl=GrGrid1 then
                GrGrid1Exit(self);
             PreparationEnregistrementComplet;

              TabIDSupprime[0]:=-1;
              TabIDSupprime[1]:=-1;
              TabIDSupprime[2]:=-1;

         if ((DMPieces.Piece1.IDJournal in [1,2])and (DMPlan.CptEstPointable(DMPieces.Piece1.compte)) and (not GrGrid1.LigneVide(1))) then
           Begin //si on est sur une pièce d'achat ou de vente
              //initialise query Pointage temporaire

              if copy(currtostr(DMPieces.Piece1.Montant),1,1)='-'then
                 DMPieces.Piece1.SensPourReglement:=Not DMPieces.Piece1.Sens
              else
                 DMPieces.Piece1.SensPourReglement:=DMPieces.Piece1.Sens;
              DMPieces.Piece1.MontantPourReglement:=abs(DMPieces.Piece1.Montant);
               //InitialiseInfosPointage(conteneur);
               if Modifier_Confirmer then
                  Begin//si piece modifiée, on supprime ses pointages
                   if DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr(IDContrepartie),Sens,true,false,-1).NbLignePointee<>0 then
                     begin
                     ListeTmp.AddObject('',DMPieces.Piece1);
                     DMPointage2.SupprimePointageSurEcriture(QueryTmp,ListeTmp,0);
                     end;
                  End;//fin si piece modifiée, on supprime ses pointages
//               else
//                  Begin
                  //sinon, on récupère les infos pointages
//                  InitialiseInfosPointage(conteneur);
//                  conteneur.infosPointage:=DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr(IDContrepartie),Sens,true,false,-1);
//                    if conteneur.infosPointage.Pointee then
//                      if not empty(DMPieces.Piece1.tiers)then
//                      conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(IDContrepartie,DMPieces.Piece1.Tiers)
//                      else
//                      conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(IDContrepartie,DMPieces.Piece1.compte);
//                  InfosPointage:=conteneur;
//                  End;
//               if not empty(DMPieces.Piece1.tiers)then
//               conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(IDContrepartie,DMPieces.Piece1.Tiers)
//               else
//               conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(IDContrepartie,DMPieces.Piece1.compte);
//               InfosPointage:=conteneur;
               if  DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('E','',24)<>-1 then
               DMPieces.Piece1.TypeTvaE:=true;
               ///

//               if SaisieReglements=nil then
//               SaisieReglements:=TSaisieReglements.Create(self);
//               SaisieReglements.ShowModal;
//              if SaisieReglements.ModalResult in [mrok,mrYes]then


               // !!! finir de remplir "ParamAfficheSaisieReglement" !!!
               if SaisieReglementAffiche(ParamAfficheSaisieReglement) then
                begin
                    DMPieces.Piece1.Reglement:=true;
                    BtnEnregistrerClick(self);
                end;
           End; //si on est sur une pièce d'achat ou de vente
         //PB //si on est sur une pièce de règlement
         if ((DMPieces.Piece1.IDJournal in [4])and (DMPlan.CptEstPointable(grgrid1.Cells[1,grgrid1.Row]))and (not GrGrid1.LigneVide(1))) then
           Begin //si on est sur une pièce de règlement
            PointagesEnCours.Liste:=TStringList.Create;
            PointagesEnCours:=DMPointage2.RecupListeLettre_surDataset(DMPointage2.TaAffectReglement,false);
            if PointagesEnCours.result then
               begin
                 if PointagesEnCours.Liste.Count>1 then
                   if ((PointagesEnCours.Liste[0]<>'A')and (PointagesEnCours.Liste[0]<>'V'))then
                     begin
                       Showmessage('Un lettrage est déjà en cours, vous devez le valider !!!');
                       abort;
                     end;
               end;
            if AffectReglement = nil then
              AffectReglement:=TAffectReglement.Create(Application.MainForm);
               if Modifier_Confirmer then
                  Begin//si piece modifiée, on supprime ses pointages
                   if DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ID_Ord),Sens,true,false,-1).NbLignePointee<>0 then
                     begin
                       ListeTmp.AddObject('',DMPieces.Piece1);
                       DMPointage2.SupprimePointageSurEcriture(QueryTmp,ListeTmp,0);
                     end;
                  End;//fin si piece modifiée, on supprime ses pointages
            infosLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(lignecurr,DMEcritures.Ecriture_Isa1.ListIdentifiant);
            InitialiseInfosPointage(conteneur);
            conteneur.infosPointage:=DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ID_Ord),Sens,true,false,-1);
            if not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ligne.tiers)then
              conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ID_Ord,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ligne.tiers)
            else
              conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ID_Ord,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ligne.compte);
            if conteneur.infosPointage.Pointee then
              MontantAPointer:=conteneur.InfosReste.Reste
            else
            //si suppression des pointages le reste n'est pas encore modifier donc on prend
            //le solde de l'écriture
              MontantAPointer:=infosLigne.Solde;
            AffectReglement.EdCompte.Text:=grgrid1.Cells[1,grgrid1.Row];
            DMPointage2.LettrageEnCours:='A';
            DMPointage2.ForceLettrage:='A';
            Initialise_TParamAffichPointage(ParamAffichPointage);
            ParamAffichPointage.ALettrer:=true;
            ParamAffichPointage.CptTiers:=AffectReglement.EdCompte.Text;
            ParamAffichPointage.DateDeb:=0;
            ParamAffichPointage.DateFin:=E.DatExoFin;
            ParamAffichPointage.ID_Ecriture_Appelant:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ID_ord;
//            ParamAffichPointage.ID_Ecriture_Appelant:=0;
            ParamAffichPointage.ID_Reste_Appelant:=-1;
            ParamAffichPointage.Reference:=DMPieces.Piece1.Reference;
            ParamAffichPointage.Montant_Appelant:=infosLigne.Solde;
            ParamAffichPointage.Reste_Appelant:=MontantAPointer;
            case infosLigne.SensSoldeCredit of
             1:begin
                 ParamAffichPointage.SensAppelant:='C';
                 SensRecherche:='D';
               end;
            -1:begin
                 ParamAffichPointage.SensAppelant:='D';
                 SensRecherche:='C';
               end;
             0:begin
                 showmessage('Vous devez d''abord indiquer le montant du règlement !');
                 abort;
               end;
            end;//fin du case sens ligne
//            InfoResteDCSurCompte:=RecupDetteCreance(AffectReglement.EdCompte.Text,SensRecherche,['4','3'],ParamAffichPointage.DateDeb,ParamAffichPointage.DateFin,0,0,nil,false);
            InfoResteDCSurCompte:=RecupDetteCreance('',AffectReglement.EdCompte.Text,SensRecherche,['4'],ParamAffichPointage.DateDeb,ParamAffichPointage.DateFin,0,0,nil,false);
            if ((InfoResteDCSurCompte.NBLignePointee=0)and(InfoResteDCSurCompte.NBLigneResteAPointer=0)) then
              Begin//si
                if sender<>nil then
                  showmessage('Il n''y a pas de ligne pointable pour '+ InfoResteDCSurCompte.MessageCpt);
                abort;
              End;//fin si
            validationTmp:=AffectReglementAffiche(DMPointage2.TaResteDC,false,true,ParamAffichPointage.CptTiers,'A',ParamAffichPointage.SensAppelant,MontantAPointer,0,0,nil,ParamAffichPointage);
//            if validationTmp then
             //récupérer l'idPointé avec le montant total imputé
               begin
                 //Modifier le lettrage validé par A* pour ne pas le supprimé
                 //sur échap dans l'écran AffectReglement si on le rappelle pour un autre tiers
                 DMPointage2.TaAffectReglement.Refresh;
                 DMPointage2.TaAffectReglement.first;
                 while ((DMPointage2.TaAffectReglement.Locate('Lettre',DMPointage2.LettrageEnCours,[]))and(not empty(DMPointage2.LettrageEnCours))) do
                   begin
                   if DMPointage2.ListeID_Appelant<>nil then
                     Begin//si liste appelant existe
                       rang:=DMPointage2.ListResteAffect_IndexOf([inttostr(ParamAffichPointage.ID_Ecriture_Appelant),DMPointage2.TaAffectReglement.FindField('ID').Asstring],[1,2],DMPointage2.ListeID_Appelant);
                       if rang<>-1 then
                         Begin//si
                           PListeResteAffect(DMPointage2.ListeID_Appelant.Items[rang])^.Validation:=true;
                         End;//fin si
                     End;//fin si liste appelant existe
                     DMPointage2.ModifLettrageEnregCourant(DMPointage2.TaAffectReglement,'');
                     DMPointage2.TaAffectReglement.first;
                   end;//fin du while DMPointage2.TaAffectReglement
                 if ((not empty (DMPointage2.LettrageEnCours))or(MontantAPointer=0))then
                   Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.infosPointages.infosPointage.Lettre:=DMPointage2.LettrageEnCours;
                 Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.infosPointages.infosPointage.MontantPointage:=MontantAPointer;
               end;
            if ((validationTmp)or(DMPointage2.ListeID_Appelant.count=0)) then
              ValiderPointageEnCours:=validationTmp;
              if DMPointage2.ListeID_Appelant<>nil then
                Begin//si liste appelant existe
                  for rang:=0 to DMPointage2.ListeID_Appelant.count-1 do
                    Begin//si
                      if not (PListeResteAffect(DMPointage2.ListeID_Appelant.Items[rang])^.Validation) then
                        DMPointage2.ListeID_Appelant.Delete(rang);
                    End;//fin si
                End;//fin si liste appelant existe
            DMPointage2.SuppressionLettrage_Tous_ApresGestionDesPointages(DMPointage2.TaAffectReglement,nil);
           end;//fin si on est sur une pièce de règlement
        end;//fin du with piece
     except
     //showmessage('Problème lors de la demande d''affichage des réglements');

     if ((tableEcritureTemp <> nil) and (tableEcritureTemp.Active)) then
     TableGereRollBack(tableEcritureTemp);
     TableGereRollBack(DMBalance.TaBalance);
     abort;
     end;//fin du try except

  finally
LibereObjet(TObject(QueryTmp),Self);
Initialise_TStringlist(PointagesEnCours.Liste,Self);
//  PointagesEnCours.Liste.free;
Initialise_TStringlist(ListeTmp,Self);
//  if ListeTmp<>nil then
//  Begin
////  ListeTmp.Free;
//  ListeTmp:=nil;
//  End;
//  if QueryTmp<>nil then
//  Begin
//  QueryTmp.free;
//  QueryTmp:=nil;
//  End;

LibereObjet(TObject(tableEcritureTemp),Self);
//  if tableEcritureTemp<>nil then
//  Begin
//  tableEcritureTemp.free;
//  tableEcritureTemp:=nil;
//  End;
  if InfoResteDCSurCompte.DataSetResult<>nil then InfoResteDCSurCompte.DataSetResult.free;
  InfoResteDCSurCompte.DataSetResult:=nil;
  end;//fin du try finally
end;



procedure TsaisieP_3.Supprimer1Click(Sender: TObject);
begin
//Supprimer la pièce
  if DMPieces.Piece1.EtatPiece = dsedit then
  begin
  DMPieces.SuppressionPieceEcriture(DMPieces.Piece1.Reference,DMPieces.Piece1);
  etatinitial(0,false);
//  DMPieces.Piece1.NouvellePiece;
//       GrEnTete.SetFocus;
//       GrEnTete.col:=0;
//       GrEnTete.InplaceEditor.Focused;

  end;
end;

procedure TsaisieP_3.BtnAnnulerClick(Sender: TObject);
begin
//si on est sur l'entete de la pièce
   if ((DMPieces.Piece1.EtatPiece = dsinsert)and(not empty(DMPieces.piece1.Libelle))and(not empty(DMPieces.piece1.Compte)))
   or ((DMPieces.Piece1.EtatPiece =dsedit)and ((DMPieces.Piece1.Modifier_Confirmer)or(DMPieces.Piece1.Modifier_EnAttente)))then
     Begin
       if Messagedlg(PChar('Voulez-vous annuler les modifications de cette pièce !'),mtconfirmation, [mbyes,mbno],0) = mryes then
           Begin
           TableGereRollBack(DMPieces.Piece1.TablePiece);
           TableGereRollBack(DMBalance.TaBalance);
           if ValiderPointageEnCours then
             begin
               DMPointage2.Gestion_Annulation_Lettrage(DMPointage2.TaResteDC,'V','',false);
               ValiderPointageEnCours:=false;
             end;
           EtatInitial(0,false);
           End;
       //si on ne veut pas annuler, on ne fait rien
     End
   else
     begin
        EtatInitial(0,false);
//        if GrEnTete.Col=0 then
//           self.close;
     end;
end;
procedure TsaisieP_3.BtnAnnulerGrilleClick(Sender: TObject);
begin
//si on est sur la grille
btnAnnuler.SetFocus;
GrEnTete.SetFocus;
GrEnTete.Col:=0;
GrEnTete.InplaceEditor.Focused;
GestionInfoCorps(grgrid1.Cells[1,grgrid1.row]);
end;

procedure TsaisieP_3.Visualisation1Click(Sender: TObject);
var
Index:integer;
 PeriodeAutre_Tmp:TPeriode;
begin // PB
try//finally
    PeriodeAutre_Tmp:=E.PeriodeAutre;
    E.AutrePeriode:=True;
    E.PeriodeAutre.Retour:=true;
    if DMPieces.Piece1.AnneePiece.PieceAnterieure then
      begin
        E.PeriodeAutre.DateDeb := StrToDAte_lgr('01/01/1970');
        E.PeriodeAutre.DateFin := E.DatExoDebut-1;
      end
    else
      begin
        E.PeriodeAutre.DateDeb := e.DatExoDebut;
        E.PeriodeAutre.DateFin := E.DatExoFin;
      end;
    DMPieces.VisuPeriode:=E.PeriodeAutre;

 case GrEnTete.Col of
    0:if AideModelExiste(GrEnTete.InplaceEditor,true).retour then //journal
      DetailEcritureJournal(AideModelJournal(AideModelIDJournal),true)
       else showmessage('Vous devez sélectionner un journal !');
 2..4:Begin//compte
      index:=0;
       if DMPieces.Piece1.IDJournal in [1,2,3,4]  then
         begin//si toutes pièces confondues
           DMPieces.GestionFiltrageParamCpt;
           MessDerSub:=false;
           if copy(GrEnTete.cells[2,1],1,1)='+' then Index:=1;
             if AideCompteDansContexte(GrEnTete.cells[2,1],GrEntete,['Rac1'],false,MessDerSub,false,true,true,true,Index) then
                if length(GrEnTete.cells[2,1]) > 0 then
                  begin//si pas vide
                    if Index=0 then
                       begin
                       DetailEcritureCompte(GrEnTete.cells[2,1],true,true);
                       end
                    else
                       Begin
                       DetailEcritureTiers(GrEnTete.cells[2,1],true);
                       End;
                  end;//fin si pas vide
         MessDerSub:=true;
         End;//fin si toutes pièces confondues
      end;//fin si compte ou libelle ou date
 end;//fin du case col      
  Finally
    E.PeriodeAutre:=PeriodeAutre_Tmp;
    E.AutrePeriode:=PeriodeAutre_Tmp.Retour;
  end;
end;

procedure TsaisieP_3.ImPrimer1Click(Sender: TObject);
begin
//
end;

procedure TsaisieP_3.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

procedure TsaisieP_3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try//except
 CanClose:=true;
if DMPieces <>nil then
  begin //si dmpieces existe
//   if ((DMPieces.Piece1.EtatPiece = dsinsert)or (((DMPieces.Piece1.EtatPiece =dsedit)and ((DMPieces.Piece1.Modifier_Confirmer)or(DMPieces.Piece1.Modifier_EnAttente)))))  then
   if ((DMPieces.Piece1.EtatPiece = dsinsert)and(not empty(DMPieces.piece1.Libelle))and(not empty(DMPieces.piece1.Compte)))
   or ((DMPieces.Piece1.EtatPiece =dsedit)and ((DMPieces.Piece1.Modifier_Confirmer)or(DMPieces.Piece1.Modifier_EnAttente)))then
     Begin
        self.WindowState:=wsNormal;
        //self.BringToFront;
       if Messagedlg(PChar('Voulez-vous enregistrer les modifications de cette pièce !'),mtconfirmation, [mbyes,mbno],0) = mryes then
           Begin
           BtnEnregistrerClick(self);
           //self.Close;
           EtatInitial(0,false,true);
           End
         else
           EtatInitial(0,false,true);
       //si on ne veut pas enregistre,
     End
   else
     EtatInitial(0,false,true);
  end;//fin si dmpieces existe
except
  canclose:=false;
end;
if canclose then
begin
InitialiseTable_A_Nil; { isa  le  29/01/04 }
end;
end;

procedure TsaisieP_3.FormShow(Sender: TObject);
begin
// EtatInitial(0);
if not ((fsModal in saisieP_3.FormState)and(DmPieces.piece1.EtatPiece in [dsedit])) then
    begin
       DMPieces.Piece1.NouvellePiece(false);
       DmPieces.piece1.EtatPiece:=dsbrowse;
    end;
DMPieces.Piece1.OnStateChange:=GrEnTete.OnStateChange;
if WindowState=wsMinimized then WindowState:=wsNormal;

ValiderPointageEnCours:=false;
GrEnTete.SetFocus;
GrEnTete.col:=0;
end;

procedure TsaisieP_3.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then WinSuivPrec(Handle,key,[grgrid1,GrEnTete,RxChListCpt]);
 If Key = VK_ESCAPE Then
 Begin
   if PaSelectCpt.Visible then PaSelectCpt.Visible:=false;  
   if (((GrEnTete.InplaceEditor.Focused)or(GrEnTete.Focused)) and (DMPieces.Piece1.EtatPiece=dsbrowse)) then
     Begin//si
       //si une affectation a été faite, l'annuler
       if ValiderPointageEnCours then
         begin
           if ((DMPieces.Piece1.EtatPiece=dsedit)and(Application.MessageBox(Pchar('Voulez-vous annuler les lettrages en cours ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes)) then
             begin
               DMPointage2.Gestion_Annulation_Lettrage(DMPointage2.TaResteDC,'V','',false);
               ValiderPointageEnCours:=false;
             end
           else
             if DMPieces.Piece1.EtatPiece=dsedit then
               abort;
         end;
       self.close;
     End//fin si
   else
     begin
       if ((activecontrol<>nil)and(activecontrol.Parent=PaGrilleTete)) then
         begin
         //si une affectation a été faite, l'annuler
         if ValiderPointageEnCours then
           begin
           if ((DMPieces.Piece1.EtatPiece=dsedit)and(Application.MessageBox(Pchar('Voulez-vous annuler les lettrages en cours ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes)) then
             begin
               DMPointage2.Gestion_Annulation_Lettrage(DMPointage2.TaResteDC,'V','',false);
               ValiderPointageEnCours:=false;
             end
           else
             if DMPieces.Piece1.EtatPiece=dsedit then
               abort;
           end;
         BtnAnnulerClick(BtnAnnuler);
         end
       else
         BtnAnnulerGrilleClick(BtnAnnuler);
     end;
 end;
end;




procedure TsaisieP_3.PaGrilleResize(Sender: TObject);
begin
GrGrid1.ColWidths[0]:=10;
GrGrid1.ColWidths[1]:=(GrGrid1.Width) div 6;
GrGrid1.ColWidths[2]:=(GrGrid1.Width) div 3;
GrGrid1.ColWidths[3]:=(GrGrid1.Width) div 21;
GrGrid1.ColWidths[4]:=(GrGrid1.Width) div 21;
GrGrid1.ColWidths[5]:=(GrGrid1.Width) div 6;
GrGrid1.ColWidths[6]:=(GrGrid1.Width) div 6;

Panel7.Width:=GrGrid1.ColWidths[0]+GrGrid1.ColWidths[1]+GrGrid1.ColWidths[2]+GrGrid1.ColWidths[3]+GrGrid1.ColWidths[4]+10;
Panel6.Width:=Panel7.Width;
Gauge1.width:=Panel7.Width-50;
PaSelectCpt.Width:=Panel2.Width div 3;

GrGrid2.ColWidths[0]:=GrGrid1.ColWidths[5];
GrGrid2.ColWidths[1]:=GrGrid1.ColWidths[6];

GrGrid3.ColWidths[0]:=GrGrid1.ColWidths[5];
GrGrid3.ColWidths[1]:=GrGrid1.ColWidths[6];


end;

procedure TsaisieP_3.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TsaisieP_3.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;


procedure TsaisieP_3.PaGrilleEnter(Sender: TObject);
begin
PopupMenu:=PopupMenuEcriture;
BtnAnnuler.OnClick:=BtnAnnulerGrilleClick;
BtnInserer.OnClick:=BtnInsererGrilleClick;
btnmodifier.OnClick:=BtnModifierGrilleClick;
BtnSupprimer.OnClick:=BtnSupprimerGrilleClick;
end;

procedure TsaisieP_3.GrGrid1Change(Sender: TObject);
var
SupprOD,GererTva:boolean;
conteneurVerrou:TVerrouillage;
//messagetmp:string;
newcol:integer;
ModifiableTmp:boolean;
startlenght_tmp:integer;
begin
try
ModifiableTmp:=false;
if ((grgrid1.col in [1]) and (grgrid1.InplaceEditor <> nil)) then
begin
 if grgrid1.InplaceEditor.Visible then
  begin
   if not empty(grgrid1.InplaceEditor.Text) then
     begin
      if grgrid1.InplaceEditor.Text[1] <> '+' then
        begin
         LaCompteEnCours.Caption:=DMPlan.LibelleDuNumCptPCU(grgrid1.InplaceEditor.Text);
         if LaCompteEnCours.Caption='' then
          begin
            LaCompteEnCours.Caption:='Compte inexistant dans votre plan comptable';
            LaCompteEnCours.Font.Color:=clRed;
          end
          else
          Begin
           if DMPlan.PossedeFils(grgrid1.InplaceEditor.Text) then
                LaCompteEnCours.Font.Color:=clblack
                else
                LaCompteEnCours.Font.Color:=clGreen;
          End;
        end
        else
        Begin
          LaCompteEnCours.Caption:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[grgrid1.InplaceEditor.Text]).Nom;
//          LaCompteEnCours.Caption:=DMTiers.LibelleDuTiers(grgrid1.InplaceEditor.Text);
         if LaCompteEnCours.Caption='' then
          begin
            LaCompteEnCours.Caption:='Compte inexistant dans votre plan auxiliaire';
            LaCompteEnCours.Font.Color:=clRed;
          end
          else
          Begin
            LaCompteEnCours.Font.Color:=clGreen;
          End;
        End;

      end
       else LaCompteEnCours.Caption:='';
   end;
end;



//regarder si Pièce décrite dans les immos
//si oui, vérifier si amortissable
   try

//  TableGereStartTransaction(DMPieces.Piece1.TablePiece);
//  if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
   if (not Gestionimmos.supprimerImmos)and (not Gestionimmos.supprimerCessions) and (DMPieces.Piece1.EtatPiece=dsEdit) then
      begin
    if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,ligneCurr).retour= false then abort;
      end;
supprOD:=false;
GererTva:=false;
   if ((((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='V'))or(grgrid1.Cells[1,lignecurr]=''))and(grgrid1.col in [2,3,4,5,6])) then
     abort;
   if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='T')and(grgrid1.col in [1,3,4])) then
     abort;
   if ((DMPieces.Piece1.IDJournal in [1,2,3,4])and(((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)))then
   Begin //si piece de vente ou d'achat ou de banque
     if ((((DMPieces.Piece1.InfosVerrouillage.PieceVerrouillee)))or(((DMPieces.Piece1.InfosPointage.infosPointage.TvaSurE)and(DMPieces.Piece1.InfosVerrouillage.PeriodeVerrouillee)))) then
        Begin
           GererTva:=true;
//           SupprOD:=((DMPieces.Piece1.InfosVerrouillage.Deverrouillable)and(DMPieces.Piece1.InfosVerrouillage.PeriodeDeverrouillable));
           SupprOD:=DMPieces.Piece1.InfosVerrouillage.Deverrouillable;
        End;
     if GererTva then
        Begin //si on doit gerer la tva
          if not SupprOD then
            Begin //si on ne peut pas modifier la ligne
                Application.MessageBox(Pchar('Attention, cette pièce est verrouillée et non déverrouillable, Vous ne pouvez pas la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_OK);
                begin
                if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.ID_Tmp=0)and(dmpieces.Piece1.EtatPiece=dsedit)) then
                  Begin
                  grgrid1.Rows[ligneCurr].Text:='';
                  newcol:=RecupCelluleValide(lignecurr,1);
                  if newcol<>-1 then
                    grgrid1.Col:=newcol;
                  End;
                abort;
                end;
            End//fin  si on ne peut pas modifier la ligne
          else
            Begin //si on peut modifier la ligne, on deverrouille la période déclarée
              if Application.MessageBox(Pchar('Attention, cette pièce est verrouillée, si vous la modifiez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! Voulez-vous la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                 if not (DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false)).retour then
                   abort;
                 conteneurVerrou:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,DMPieces.Piece1.DateSaisie);
                 DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                 end
                 else
                  begin
                    if ((not(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.ID_Tmp<>0))and(dmpieces.Piece1.EtatPiece=dsedit)) then
                      begin
                      grgrid1.Rows[ligneCurr].Text:='';
                      newcol:=RecupCelluleValide(lignecurr,1);
                      if newcol<>-1 then
                      end;
                    abort;
                  end;
            End; //fin si on peut modifier la ligne, on deverrouille la période déclarée
        End;//fin si on doit gerer la tva
   End; //fin si piece de vente ou d'achat et piece existante


    if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
      begin
          if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
             begin
               if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                  ModifiableTmp:=true;
             end
          else
             ModifiableTmp:=true;
        if ModifiableTmp then //si on veut quand même la modifier
           DMPieces.Piece1.Modifier_EnAttente:=true
        else
           abort;
      end;


if ((grgrid1.col in [3]) and (grgrid1.InplaceEditor <> nil)) then
begin// si colonne Débit
// if grgrid1.InplaceEditor.Visible then
  begin//si InplaceEditor.Visible
  if strtoCurr_lgr(grgrid1.cells[5,lignecurr])>0 then
     begin
       grgrid1.cells[3,lignecurr]:=DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.InplaceEditor.text,false,ParametreCompteEcriture.ParamCpt.SensCredit,true,StrToFloat_Lgr( grgrid1.cells[5,lignecurr]));
       grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.text);
     end;
  if strtoCurr_lgr(grgrid1.cells[6,lignecurr])>0 then
     begin
       grgrid1.cells[3,lignecurr]:=DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.InplaceEditor.text,True,ParametreCompteEcriture.ParamCpt.SensCredit,true,StrToFloat_Lgr(grgrid1.cells[6,lignecurr]));
       grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.text);
     end;
  end;
end;// si colonne Débit

if ((grgrid1.col in [4]) and (grgrid1.InplaceEditor <> nil)) then
begin// si colonne Débit
// if grgrid1.InplaceEditor.Visible then
  begin//si InplaceEditor.Visible
  if strtoCurr_lgr(grgrid1.cells[5,lignecurr])>0 then
     begin
       grgrid1.cells[4,lignecurr]:=DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.InplaceEditor.text,false,ParametreCompteEcriture.ParamCpt.SensCredit,true,StrToFloat_Lgr(grgrid1.cells[5,lignecurr]));
       grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.text);
     end;
  if strtoCurr_lgr(grgrid1.cells[6,lignecurr])>0 then
     begin
       grgrid1.cells[4,lignecurr]:=DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.InplaceEditor.text,True,ParametreCompteEcriture.ParamCpt.SensCredit,true,StrToFloat_Lgr(grgrid1.cells[6,lignecurr]));
       grgrid1.InplaceEditor.SelStart:=length(grgrid1.InplaceEditor.text);
     end;
  end;
end;// si colonne Débit

if ((grgrid1.col in [1,5,6]) and (grgrid1.InplaceEditor <> nil)) then
begin// si colonne Débit
// if grgrid1.InplaceEditor.Visible then
  begin//si InplaceEditor.Visible
//   if not empty(grgrid1.InplaceEditor.Text) then
     begin
        if grgrid1.col in [1]then
          begin
              grgrid1.cells[3,lignecurr]:=DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.cells[3,lignecurr],(grgrid1.cells[5,lignecurr]<grgrid1.cells[6,lignecurr]),0,true,abs(StrToFloat_Lgr(grgrid1.cells[5,lignecurr])-StrToFloat_Lgr(grgrid1.cells[6,lignecurr])));
              grgrid1.cells[4,lignecurr]:=DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.cells[4,lignecurr],(grgrid1.cells[5,lignecurr]<grgrid1.cells[6,lignecurr]),0,true,abs(StrToFloat_Lgr(grgrid1.cells[5,lignecurr])-StrToFloat_Lgr(grgrid1.cells[6,lignecurr])));       //récupérer le sens du compte par défaut
          end
        else
          begin
              grgrid1.cells[3,lignecurr]:=DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.cells[3,lignecurr],(grgrid1.cells[5,lignecurr]<grgrid1.cells[6,lignecurr]),ParametreCompteEcriture.ParamCpt.SensCredit,true,abs(StrToFloat_Lgr(grgrid1.cells[5,lignecurr])-StrToFloat_Lgr(grgrid1.cells[6,lignecurr])));
              grgrid1.cells[4,lignecurr]:=DMEcritures.Ecriture_Isa1.GestionDesQuantites(grgrid1.cells[1,lignecurr],grgrid1.cells[4,lignecurr],(grgrid1.cells[5,lignecurr]<grgrid1.cells[6,lignecurr]),ParametreCompteEcriture.ParamCpt.SensCredit,true,abs(StrToFloat_Lgr(grgrid1.cells[5,lignecurr])-StrToFloat_Lgr(grgrid1.cells[6,lignecurr])));       //récupérer le sens du compte par défaut
          end;
     end;
   end;//fin si InplaceEditor.Visible
end;// si colonne Débit

except
       case grgrid1.col of
       1:if not empty(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Tiers)then
           grgrid1.Cells[grgrid1.col,ligneCurr]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.tiers
         else
           grgrid1.Cells[grgrid1.col,ligneCurr]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Compte;
       2:grgrid1.Cells[grgrid1.col,ligneCurr]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.libelle;
       3:grgrid1.Cells[grgrid1.col,ligneCurr]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Qt1;
       4:grgrid1.Cells[grgrid1.col,ligneCurr]:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.qt2;
       5:if not (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='V') then
           grgrid1.Cells[grgrid1.col,ligneCurr]:=e.FormatCurrSansDevise(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Debit)
         else
           grgrid1.Cells[grgrid1.col,ligneCurr]:='';
       6:if not (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.TypeLigne='V') then
           grgrid1.Cells[grgrid1.col,ligneCurr]:=e.FormatCurrSansDevise(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.Credit);
         else
           grgrid1.Cells[grgrid1.col,ligneCurr]:='';
       end;//fin du case
    abort;
   end;//fin du try except
finally
// if ListeASupprimer<>nil then
//   ListeASupprimer.Free;

end;//fin du try finally
end;

procedure TsaisieP_3.GrGrid1StateChange(EtatGrille: TDataSetState);
begin
ChangementEtatBoutonsMenu;
  case EtatGrille of
  dsbrowse:Panel1.Caption:='Corps de la pièce - En consultation';
  dsinsert:Panel1.Caption:='Corps de la pièce - En insertion';
  dsEdit:Panel1.Caption:='Corps de la pièce - En modification';
  end;//fin du case
end;


procedure TsaisieP_3.EdDateLivraisonEnter(Sender: TObject);
begin
DateLivraisontmp:=EdDateLivraison.text;
end;

procedure TsaisieP_3.EdDateEcheanceEnter(Sender: TObject);
begin
DateEcheancetmp:=EdDateEcheance.text;
end;

procedure TsaisieP_3.TraitementPourGerer_ModifPiece_et_TVA(Traitement:integer;var Act:boolean;Messagetmp:string;Datetmp:tdatetime;DateLivraison:boolean);
var
i:integer;
conteneurVerrou:TVerrouillage;
ModifiableTmp:boolean;
retour:integer;
begin
ModifiableTmp:=false;
   //si piece pas encore modifiéé, alors prevenir de la suppression des pointages associés
      if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
      begin
      case Traitement of //début du case traitement 1
  1,2,3,4:begin //si traitement 1,2,3,4
        if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
         begin
           if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
              ModifiableTmp:=true;
         end
        else
           ModifiableTmp:=true;
           
        if ModifiableTmp then
          begin
         // Act:=true;
          case traitement of //début du traitement 2
         2,3,4:begin //si traitement =2 ou 3
               if not empty(Messagetmp)then
                 if Application.MessageBox(Pchar(Messagetmp),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                    begin
                    if traitement in [3,4] then
                      Begin
                         if not (DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false)).retour then
                           Act:=false;
                         conteneurVerrou:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,DMPieces.Piece1.DateSaisie);
                         DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                      End;
                    end
                    else
                    Act:=false;
             end;//fin si traitement =2 ou 3
          end;//fin du case traitement 2
          if act then
          Begin
          DMPieces.Piece1.Modifier_EnAttente:=true;
          if ((not grgrid1.rowcount<=1)and(DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('D','',24)<>-1)and (traitement<>4)and(not((grgrid1.rowcount-1=1)and(grgrid1.LigneVide(1))))) then
            begin
            if ((not empty(dmpieces.Piece1.Trame.CodeTrame))and(not DateLivraison)) then
              begin
              for i:=1 to grgrid1.RowCount-1 do
                begin
                conteneurVerrou:=DMPieces.Piece1.InfosVerrouillage;
                if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TypeLigne='H')and(not empty (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TVA.CodeTva))) then
                    EcritureDuComplementLigne(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Complement,[datetostr(Datetmp)],[2],conteneurVerrou,false,false,'');
                DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                end;
              end
            else
              retour:=Application.MessageBox(Pchar(Mettre_A_Jour_Date_Livraison1),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1);
              if retour=mrno then retour:=Application.MessageBox(Pchar(Mettre_A_Jour_Date_Livraison2),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1);
              if retour=mryes then
              for i:=1 to grgrid1.RowCount-1 do
                begin
                conteneurVerrou:=DMPieces.Piece1.InfosVerrouillage;
                if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TypeLigne='H')and(not empty (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TVA.CodeTva))) then
                    EcritureDuComplementLigne(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Complement,[datetostr(Datetmp)],[2],conteneurVerrou,false,false,'');
                DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                end;
            end;
          End;
          end
          else
          Act:=false;
        end;//fin si traitement 1,2,3,4
      end;//fin du case traitement 1
      end
      else
      if (((DMPieces.Piece1.Modifier_Confirmer)or(DMPieces.Piece1.Modifier_EnAttente))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
      Begin//si la piece est déjà modifiée
          case traitement of //début du traitement 2
         2,3,4:begin //si traitement =2 ou 3
               if not empty(Messagetmp)then
                  if Application.MessageBox(Pchar(Messagetmp),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                     begin
                       //act:=true;
                     if traitement in [3,4] then
                       Begin
                       //supprimer l'OD de déclaration et les lignes de la période déclarée et déverrouiller la période
                          if not (DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false)).retour then
                            abort;
                          conteneurVerrou:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,DMPieces.Piece1.DateSaisie);
                          DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                       End;
                     end
                     else
                     Act:=false;
             end;//fin si traitement =2 ou 3
          end;//fin du case traitement 2
      if act then
      begin
      //si lignes déjà créées, on demande si mise à jour
      if ((not grgrid1.rowcount<=1)and(DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('D','',24)<>-1)and(traitement<>4)and(not((grgrid1.rowcount-1=1)and(grgrid1.LigneVide(1))))) then
        begin
            if ((not empty(dmpieces.Piece1.Trame.CodeTrame))and(not DateLivraison)) then
              begin
              for i:=1 to grgrid1.RowCount-1 do
                begin
                conteneurVerrou:=DMPieces.Piece1.InfosVerrouillage;
                if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TypeLigne='H')and(not empty (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TVA.CodeTva))) then
                    EcritureDuComplementLigne(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Complement,[datetostr(Datetmp)],[2],conteneurVerrou,false,false,'');
                DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                end;
              end
            else
        retour:=Application.MessageBox(Pchar(Mettre_A_Jour_Date_Livraison1),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1);
        if retour=mrno then retour:=Application.MessageBox(Pchar(Mettre_A_Jour_Date_Livraison2),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1);
         if retour=mryes then
          for i:=1 to grgrid1.RowCount-1 do
             begin
             conteneurVerrou:=DMPieces.Piece1.InfosVerrouillage;
             if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TypeLigne='H')and(not empty (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TVA.CodeTva))) then
                 EcritureDuComplementLigne(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Complement,[datetostr(Datetmp)],[2],conteneurVerrou,false,false,'');
             DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
             end;
        end;
      end;
      End//si la piece est déjà modifiée
      else
      if DMPieces.Piece1.EtatPiece=dsinsert then
          begin //si piece nouvelle
          case traitement of //début du traitement 2
         2,3,4:begin //si traitement =2 ou 3
               if not empty(Messagetmp)then
                  if Application.MessageBox(Pchar(Messagetmp),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                     begin
                       //act:=true;
                     if traitement in [3,4] then
                       Begin
                       //supprimer l'OD de déclaration et les lignes de la période déclarée et déverrouiller la période
                          if not (DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false)).retour then
                            abort;
                          conteneurVerrou:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,DMPieces.Piece1.DateSaisie);
                          DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                       End;
                     end
                     else
                     Act:=false;
             end;//fin si traitement =2 ou 3
          end;//fin du case traitement 2
          if act then
          begin
          //si lignes déjà créées, on demande si mise à jour
          if ((not grgrid1.rowcount<=1)and(DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('D','',24)<>-1)and(traitement<>4)and(not((grgrid1.rowcount-1=1)and(grgrid1.LigneVide(1))))) then
            begin
            if ((not empty(dmpieces.Piece1.Trame.CodeTrame))and(not DateLivraison)) then
              begin
              for i:=1 to grgrid1.RowCount-1 do
                begin
                conteneurVerrou:=DMPieces.Piece1.InfosVerrouillage;
                if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TypeLigne='H')and(not empty (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TVA.CodeTva))) then
                    EcritureDuComplementLigne(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Complement,[datetostr(Datetmp)],[2],conteneurVerrou,false,false,'');
                DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                end;
              end
            else
              retour:=Application.MessageBox(Pchar(Mettre_A_Jour_Date_Livraison1),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1);
              if retour=mrno then retour:=Application.MessageBox(Pchar(Mettre_A_Jour_Date_Livraison2),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1);
              if retour=mryes then
              for i:=1 to grgrid1.RowCount-1 do
                begin
                conteneurVerrou:=DMPieces.Piece1.InfosVerrouillage;
                if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TypeLigne='H')and(not empty (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.TVA.CodeTva))) then
                    EcritureDuComplementLigne(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Complement,[datetostr(Datetmp)],[2],conteneurVerrou,false,false,'');
                DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                end;
            end;
          end;
          end;//fin si piece nouvelle
end;


function EcritureDuComplementLigne(var Ligne:TComplementLigne_Obj;Valeur:array of const;
            NbMAJ:array of integer;var infosVerrouillage:TVerrouillage;GererTva,Messagetmp:boolean;TypeTva:string):boolean;
var
i:integer;
RetourTranstypage:TTypeTranstypage;
retourboolean:TRetourBool;
//Action:boolean;
DateTmp:tdatetime;
conteneur:TVerrouillage;
Begin
result:=true;
DateTmp:=0;
  if ((gerertva)and ((infosVerrouillage.PieceVerrouillee)or(infosVerrouillage.PeriodeVerrouillee))) then
     Begin // si vérif nécessaire
       if infosVerrouillage.PieceVerrouillee then
         Begin//si Piece Verrouillee
           if not infosVerrouillage.Deverrouillable then
             Begin//si non déverrouillable
                if messagetmp then
                  Begin//si
                    Application.MessageBox(Pchar('Attention, cette pièce est verrouillée et non déverrouillable, Vous ne pouvez pas la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_OK);
                    result:=false;
                  End;//fin si
             End//fin si non déverrouillable
           else
             Begin//si déverrouillable
                if messagetmp then
                  Begin//si
                   if Application.MessageBox(Pchar('Attention, les modifications apportées à cette pièce entraînent la modification de la dernière déclaration de tva , si vous continuez, la dernière OD de déclaration TVA sera supprimer ! Voulez-vous continuer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                      Begin
                        result:=false;
                      End
                   else
                     begin//suppression de l'OD de déclaration
                       if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                         begin
                           result:=false;
                           showmessage('Problème lors de la suppression de la dernière déclaration de TVA');
                         end
                       else
                         begin
                           DMPieces.Piece1.Modifier_EnAttente:=true;
                           DMPieces.Piece1.Modifier_confirmer:=true;
                         end;
                       if not empty(ligne.TvaDate) then
                         conteneur:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,StrToDate_Lgr(ligne.TvaDate))
                       else
                         conteneur:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,0);
                     end;//fin suppression de l'OD de déclaration
                  End;//fin si
             End;//fin si déverrouillable
         End//fin si Piece Verrouillee
       else
         if ((TypeTva='D')and(infosVerrouillage.PeriodeVerrouillee)) then
           Begin//si Periode Verrouillee
//             if not infosVerrouillage.PeriodeDeverrouillable then
//               Begin//si période non déverrouillable, on propose la prochaine déclaration
                 if messagetmp then //si message ok
                   if Application.MessageBox(Pchar('Attention, les modifications apportées à cette pièce entraînent la modification d''une déclaration de tva, si vous continuer, la ligne de TVA enregistrée sera déclarée dans la prochaine déclaration ! Voulez-vous continuer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                     Begin
                       result:=false;
                     End
                   else
                     begin
                       DateTmp:=E.DateDebutDeclarationTVA;
                     end;
//               End//fin si  Periode non Deverrouillable
//             else
//               Begin//si Periode Deverrouillable
//                 if (messagetmp) then
//                   if Application.MessageBox(Pchar('Attention, les modifications apportées à cette pièce entraînent la modification de la dernière déclaration de tva , si vous continuez, la dernière OD de déclaration TVA sera supprimer ! Voulez-vous continuer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
//                      Begin
//                        result:=false;
//                      End
//                   else
//                     begin//suppression de l'OD de déclaration
//                       if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
//                         begin
//                           result:=false;
//                           showmessage('Problème lors de la suppression de la dernière déclaration de TVA');
//                         end;
//                       if not empty(ligne.TvaDate) then
//                         conteneur:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,StrToDate_Lgr(ligne.TvaDate))
//                       else
//                         conteneur:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,0);
//                     end;//fin suppression de l'OD de déclaration
//               End;//fin si Periode Deverrouillable
           End;//fin si Periode Verrouillee
     End;//fin si vérif nécessaire

if result then
   begin //si tout est correct, on peut prend en compte les modifs
     for i:=0 to high(valeur) do
       begin //début boucle sur les valeurs du complement ligne
       RetourTranstypage:=VTypeTranstypage(valeur[i],valeur[i].vtype);
           if  RetourTranstypage.retour then
             Begin //si transtypage correct
               case NbMAJ[i] of //case sur les champs du complement ligne à mettre à jour
                1:ligne.CodeTvaCompl:=RetourTranstypage.valeur;
                2:begin
                  if DateTmp=0 then ligne.TvaDate:=RetourTranstypage.valeur;
                  if ((DateTmp<>0)and(not empty(RetourTranstypage.valeur))) then
                    ligne.TvaDate:=datetostr(datetmp)
                  else
                      Begin
                        if not empty(RetourTranstypage.valeur)then
                          begin
                            if ((TypeTva='D')and(GererTva)and(DMPieces.Piece1.AnneePiece.PieceAnterieure=false)) then
                              Begin//si TypeTva='D'
                                conteneur:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,StrToDate_Lgr(RetourTranstypage.valeur));
                                if conteneur.PeriodeVerrouillee then
                                  Begin//si PeriodeVerrouillee
                                    if conteneur.PeriodeDeverrouillable then
                                      begin//si PeriodeDeverrouillable
//                                      if Application.MessageBox(Pchar('Attention, la date de livraison de cette ligne entre dans une période de Tva déclarée, si vous la conservez, la dernière OD de déclaration TVA sera supprimée ! Voulez-vous la remplacer par la date de début de la prochaine période déclarable ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                                      Application.MessageBox(Pchar('Attention, la date de livraison de cette ligne entre dans une période de Tva déclarée, elle est obligatoirement remplacée par la date de début de la prochaine période déclarable !!!'),'Attention',MB_ICONEXCLAMATION +MB_OK);
                                         ligne.TvaDate:=datetostr(e.DateDebutDeclarationTVA);
                                          if StrToDate_Lgr(ligne.TvaDate)<dmpieces.Piece1.DateSaisie then
                                             ligne.TvaDate:=datetostr(dmpieces.Piece1.DateSaisie);
//                                      else
//                                        Begin//si suppression de l'OD de déclaration
//                                           if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
//                                             begin
//                                               result:=false;
//                                               showmessage('Problème lors de la suppression de la dernière déclaration de TVA');
//                                             end;
//                                        End;//fin si suppression de l'OD de déclaration
                                      end//fin si PeriodeDeverrouillable
                                    else
                                      Begin//si Periode non Deverrouillable

                                      End;//fin si Periode non Deverrouillable
                                  End;//fin si PeriodeVerrouillee
                              End//fin si TypeTva='D'
                            else
                              ligne.TvaDate:=RetourTranstypage.valeur
                          end
                        else
                          ligne.TvaDate:='';
                      End;
                  end;
                3:begin  //pour gérer les pièces réglées directement par le compte d'entête
                    if ((RetourTranstypage.valeur='E') and ((copy(dmpieces.Piece1.ComptePlan,1,3)='472')or (((not DMPlan.CptEstPointable(dmpieces.Piece1.ComptePlan))and(empty(dmpieces.Piece1.tiers))))))then
                      ligne.TvaType:='D'
                    else
                      ligne.TvaType:=RetourTranstypage.valeur;
                    if ((ligne.TvaType='')and(ligne.CodeTvaCompl<>'')) then ligne.TvaType:='D';
                  if ((ligne.TvaType='D')and(ligne.TvaDate='')) then
                  if(DMPieces.Piece1.AnneePiece.PieceAnterieure=false)then ligne.TvaDate:=datetostr(e.DateDebutDeclarationTVA)
                  else ligne.TvaDate:=datetostr(dmpieces.Piece1.DateSaisie);
                  if StrToDate_Lgr(ligne.TvaDate)<dmpieces.Piece1.DateSaisie then
                       ligne.TvaDate:=datetostr(dmpieces.Piece1.DateSaisie);
                  end;
                4:begin
                    if not empty(RetourTranstypage.valeur)then
                    ligne.TvaTaux:=StrToCurr_Lgr(RetourTranstypage.valeur)
                    else
                    ligne.TvaTaux:=0;
                  end;
                5:begin
                    if not empty(RetourTranstypage.valeur)then
                    ligne.MontantTva:=StrToCurr_Lgr(RetourTranstypage.valeur)
                    else
                    ligne.MontantTva:=0;
                  end;
                6:begin
                  retourboolean:=strtobool(RetourTranstypage.valeur);
                  if retourboolean.retour then
                  Ligne.rempli:=retourboolean.valeur;
                  end;
               end;//fin du case sur les champs du complement ligne à mettre à jour
             End;//fin si transtypage correct
       end;//fin de boucle sur les valeurs du complement ligne
   end;//fin si tout est correct, on peut prend en compte les modifs
End;


procedure TsaisieP_3.GrGrid1CellClick(Colonne, Ligne: Integer);
var
NewCol:integer;
begin
  try
  grgrid1.oncolenter:=nil;
  grgrid1.OnColExit:=nil;
  grgrid1.OnRowEnter:=nil;
  NewCol:=RecupCelluleValide(Ligne,Colonne);
    if NewCol<>-1 then
      begin
      grgrid1.row:=Ligne;
      grgrid1.col:=newcol;
      grgrid1.OldColonne:=newcol;
      abort;
      end;
  finally
    grgrid1.oncolenter:=GrGrid1ColEnter;
    grgrid1.OnColExit:=GrGrid1ColExit;
    grgrid1.OnRowEnter:=GrGrid1RowEnter;
  end;//fin du try finally
end;

procedure TsaisieP_3.RxSpeedButton2Click(Sender: TObject);
begin
//if self.tag = 1 then Main.Pices1Click(Main.Pices1);

if self.tag = 2 then Main.Stoks1Click(Main.Stoks1);


end;

procedure TsaisieP_3.RxSpeedButton1Click(Sender: TObject);
begin
//if self.tag = 1 then Main.btPointageClick(Main.btPointage);
//if self.tag = 2 then Main.DettetCreancesClick(Main.DettetCreances);
end;

procedure TsaisieP_3.EdPlusTiersEnteteKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in [#8,#43]) then key:=#0; //PB
end;

procedure TsaisieP_3.Visualisation2Click(Sender: TObject);
begin // PB
if GrGrid1.Col = 1 then
 begin
  if GrGrid1.InplaceEditor <> nil then
   begin
      if GrGrid1.InplaceEditor.Visible then
       begin
          if length(GrGrid1.InplaceEditor.Text) > 0 then
           begin
             if copy(GrGrid1.InplaceEditor.Text,1,1)='+' then
             DetailEcritureTiers(GrGrid1.InplaceEditor.Text,true)
             else
             DetailEcritureCompte(GrGrid1.InplaceEditor.Text,true,true);
           end
           else DetailEcritureCompte(GrGrid1.InplaceEditor.Text,true,true);
       end
         else
       begin
          if length(GrGrid1.Rows[GrGrid1.row].Strings[1]) > 0 then
           begin
             if copy(GrGrid1.Rows[GrGrid1.row].Strings[1],1,1)='+' then
             DetailEcritureTiers(GrGrid1.Rows[GrGrid1.row].Strings[1],true)
             else
             DetailEcritureCompte(GrGrid1.Rows[GrGrid1.row].Strings[1],true,true);
           end
           else DetailEcritureCompte(GrGrid1.Rows[GrGrid1.row].Strings[1],true,true);
       end;
   end
   else
    begin
       if length(GrGrid1.Rows[GrGrid1.row].Strings[1]) > 0 then
        begin
          if copy(GrGrid1.Rows[GrGrid1.row].Strings[1],1,1)='+' then
          DetailEcritureTiers(GrGrid1.Rows[GrGrid1.row].Strings[1],true)
          else
          DetailEcritureCompte(GrGrid1.Rows[GrGrid1.row].Strings[1],true,true);
        end
        else DetailEcritureCompte(GrGrid1.Rows[GrGrid1.row].Strings[1],true,true);
    end;
 end
 else
 begin
    if length(GrGrid1.Rows[GrGrid1.row].Strings[1]) > 0 then
     begin
       if copy(GrGrid1.Rows[GrGrid1.row].Strings[1],1,1)='+' then
       DetailEcritureTiers(GrGrid1.Rows[GrGrid1.row].Strings[1],true)
       else
       DetailEcritureCompte(GrGrid1.Rows[GrGrid1.row].Strings[1],true,true);
     end
     else DetailEcritureCompte(GrGrid1.Rows[GrGrid1.row].Strings[1],true,true);
 end;
end;


procedure TsaisieP_3.RxSBInfoVersionClick(Sender: TObject);
begin
//Showmessage(saisieP_2RxSBInfoVersionWarning+NumVersion);
end;


function TsaisieP_3.VerifReferenceDansExercice(reference:string):boolean;
Begin
 if DMPieces.Piece1.AnneePiece.PieceAnterieure then
    result:=copy(reference,3,2)<e.ExerciceSaisie
 else
   result:=copy(reference,3,2)=e.ExerciceSaisie;
End;

procedure TsaisieP_3.GrEnTeteColExit(OldColonne, LastRow: Integer);
var
valide:TErreurSaisie;
//Act:boolean;
//datePiece:tdatetime;
inplaceTemp:string;
begin
  case GrEnTete.Col of
     0:begin //colonne journal
         try//finally
//         inplaceTemp.Create(self);
         if GrEnTete.InplaceEditor.visible then
           inplaceTemp:=GrEnTete.InplaceEditor.Text
         else
           inplaceTemp:=GrEnTete.cells[0,1];
//         inplaceTemp.Tag:=0;
         Valide:= CtrlSaisiePieceEnteteGrille(inplaceTemp,0,nil);
         If valide.retour then
            valide.retour:=not empty(GrEnTete.cells[0,1]);
         if valide.retour then
            begin
            if journaltmp<>GrEnTete.cells[0,1] then
            begin
             if DMPieces.Piece1.AnneePiece.PieceAnterieure then
               begin//si pièce antérieure
                case DMPieces.Piece1.IDJournal of
                  1:GrEnTete.cells[3,1]:=DateToStr(DateAchatRegistreant_);
                  2:GrEnTete.cells[3,1]:=DateToStr(DateVentesRegistreAnt_);
                  3:GrEnTete.cells[3,1]:=DateToStr(DateODRegistreAnt_);
                  4:GrEnTete.cells[3,1]:=DateToStr(DateBanqueRegistreAnt_);
                end;//fin du case sur idjournal
                if strtodate_lgr(GrEnTete.Cells[3,1])<e.DatExoDebut then GrEnTete.Cells[3,1]:=datetostr_lgr(e.DatExoDebut-1);
                DMPieces.Piece1.DateSaisie:=StrToDate_Lgr(GrEnTete.cells[3,1]);
                TypeDerniereDateSaisieRegistreAnt_:=DMPieces.Piece1.IDJournal;
                DerniereDateSaisieRegistreAnt_:=DMPieces.Piece1.DateSaisie;
               end//fin si pièce antérieure
             else
               begin//si pièce année courante
                case DMPieces.Piece1.IDJournal of
                  1:GrEnTete.cells[3,1]:=DateToStr(DateAchatRegistre);
                  2:GrEnTete.cells[3,1]:=DateToStr(DateVentesRegistre);
                  3:GrEnTete.cells[3,1]:=DateToStr(DateODRegistre);
                  4:GrEnTete.cells[3,1]:=DateToStr(DateBanqueRegistre);
                end;//fin du case sur idjournal

                if strtodate_lgr(GrEnTete.Cells[3,1])<e.DatExoDebut then
                  GrEnTete.Cells[3,1]:=datetostr_lgr(e.DatExoDebut);
                if strtodate_lgr(GrEnTete.Cells[3,1])>e.DatExoFin then
                  GrEnTete.Cells[3,1]:=datetostr_lgr(e.DatExoFin);

                DMPieces.Piece1.DateSaisie:=StrToDate_Lgr(GrEnTete.cells[3,1]);
                TypeDerniereDateSaisieRegistre:=DMPieces.Piece1.IDJournal;
                DerniereDateSaisieRegistre:=DMPieces.Piece1.DateSaisie;
               end;//fin si pièce année courante
              DatePieceTmp:=GrEnTete.Cells[3,1];

              EdDateEcheance.Text:=GrEnTete.Cells[3,1];
              DMPieces.Piece1.DateEcheance:=EdDateEcheance.Date;
              DateEcheancetmp:=GrEnTete.Cells[3,1];

              EdDateLivraison.Text:=GrEnTete.Cells[3,1];
              DMPieces.Piece1.DateLivraison:=EdDateLivraison.Date;
              DateLivraisonTmp:=GrEnTete.Cells[3,1];
            end;
            JournalTmp:=GrEnTete.cells[0,1];
  //        //Initialisation Reference
            GrEnTete.Cells[1,1]:=DMPieces.Piece1.Reference;
            ReferenceTmp:=GrEnTete.Cells[1,1];
            if DMPieces.Piece1.IDJournal=4 then
              begin
                if PlusDefautCorps then
                 begin
                  PlusAutomatiqueCorps:=true;// isa
                  EdPlusTiersCorps.Text:='+';
                  grgrid1.cells[1,0]:=' Tiers';
                 end
                  else
                 begin
                  PlusAutomatiqueCorps:=False;// isa
                  EdPlusTiersCorps.Text:='';
                  grgrid1.cells[1,0]:=' Compte';
                 end;
              end
            else
              Begin//si
                grgrid1.cells[1,0]:=' Compte';
              End;//fin si
            end
         else
           abort;
         finally
//           inplaceTemp.free;
         end;//fin du try finally
       end;
  end;//fin du case GrEnTete.Col
//  if GrEnTete.EtatGrille in [dsinsert,dsedit] then
//   begin

      case GrEnTete.Col of
         1:begin //colonne reference
             try
             if GrEnTete.InplaceEditor.visible then
               inplaceTemp:=GrEnTete.InplaceEditor.Text
             else
               inplaceTemp:=GrEnTete.cells[1,1];
             Valide:= CtrlSaisiePieceEnteteGrille(inplaceTemp,1,nil);
             if valide.retour then
               begin
               // ConstruitPopMenu(0,GrEnTete.cells[1,1],HistoriquePices1,self,nil);
                GrGrid1StateChange(grgrid1.EtatGrille);
               end
             else
               begin
                 abort;
               end;
             finally
//                inplaceTemp.free;
             end;
           end;
          2:begin//colonne compte
             try//finally
             if GrEnTete.InplaceEditor.visible then
               inplaceTemp:=GrEnTete.InplaceEditor.Text
             else
               inplaceTemp:=GrEnTete.cells[2,1];
             Valide:=CtrlSaisiePieceEnteteGrille(inplaceTemp,2,nil);

             if valide.retour then
                Begin
                GestionInfoEntete(inplaceTemp);
                if ((empty(GrEnTete.Cells[4,1]))and(not empty(DMPieces.Piece1.Compte))) then
                  begin//si libelle vide
                     if copy(DMPieces.Piece1.Compte,1,1)='+' then
                     DMPieces.Piece1.InitLibelle(DMPieces.Piece1.TableTiers,DMPieces.Piece1.ICompteTiers,DMPieces.Piece1.ILibTiers,true)
                     else
                     DMPieces.Piece1.InitLibelle(DMPieces.Piece1.TablePlan,DMPieces.Piece1.IndexCompte,DMPieces.Piece1.ILibTaPlan,true);
                  GrEnTete.cellsGr(4,1,Dmpieces.Piece1.Libelle);
                  end;//fin si libelle vide
                End
             else
               begin
                 case valide.CodeErreur of
                   30010:showmessage('le compte : '+inplaceTemp+' n''est pas cohérent dans ce contexte');
                   30011:showmessage('le compte : '+inplaceTemp+' fait déjà partie de la pièce');
                   30012:showmessage('le compte : '+inplaceTemp+' n''est pas pointable');
                 end;//fin du case valide.CodeErreur
                 abort;
               end;
            finally
//               inplaceTemp.free;
            end;//fin du try finally
            end;
          3:Begin//colonne date piece
              try
//              inplaceTemp.Create(self);
              if GrEnTete.InplaceEditor.visible then
                inplaceTemp:=GrEnTete.InplaceEditor.Text
              else
                inplaceTemp:=GrEnTete.cells[3,1];
//              inplaceTemp.Tag:=3;
              Valide:= CtrlSaisiePieceEnteteGrille(inplaceTemp,3,nil);
              if not valide.retour then  //si date valide
                abort
                else
                  begin
                  GrEnTete.cells[3,1]:=inplaceTemp;
                  DMPieces.Piece1.DateSaisie:=StrToDate_Lgr(inplaceTemp);
                  if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                    begin
                      DerniereDateSaisieRegistreAnt_:=DMPieces.Piece1.DateSaisie;
                      TypeDerniereDateSaisieRegistreAnt_:=DMPieces.Piece1.IDJournal;
                      case TypeDerniereDateSaisieRegistreAnt_ of
                        1:DateAchatRegistreAnt_:=DMPieces.Piece1.DateSaisie;
                        2:DateVentesRegistreAnt_:=DMPieces.Piece1.DateSaisie;
                        3:DateODRegistreAnt_:=DMPieces.Piece1.DateSaisie;
                        4:DateBanqueRegistreAnt_:=DMPieces.Piece1.DateSaisie;
                      end;//fin du case TypeDerniereDateSaisieRegistre
                    end
                  else
                    begin
                      DerniereDateSaisieRegistre:=DMPieces.Piece1.DateSaisie;
                      TypeDerniereDateSaisieRegistre:=DMPieces.Piece1.IDJournal;
                      case TypeDerniereDateSaisieRegistre of
                        1:DateAchatRegistre:=DMPieces.Piece1.DateSaisie;
                        2:DateVentesRegistre:=DMPieces.Piece1.DateSaisie;
                        3:DateODRegistre:=DMPieces.Piece1.DateSaisie;
                        4:DateBanqueRegistre:=DMPieces.Piece1.DateSaisie;
                      end;//fin du case TypeDerniereDateSaisieRegistre
                    end;
                  end;
              finally
//                inplaceTemp.free;
              end;//fin du try finally
            End;
       4:begin //si libelle
           try
//            inplaceTemp.Create(self);
           if GrEnTete.InplaceEditor.visible then
             inplaceTemp:=GrEnTete.InplaceEditor.Text
           else
             inplaceTemp:=GrEnTete.cells[4,1];
//            inplaceTemp.Tag:=4;
            Valide:= CtrlSaisiePieceEnteteGrille(inplaceTemp,4,nil);
            if not valide.retour then
              begin
                abort;
              end;
           finally
//             inplaceTemp.free;
           end;//fin du try finally
         end;//fin si libelle
      end;//fin du case
//   end;//fin si GrEnTete.EtatGrille in [dsinsert,dsbrowse]
end;

procedure TsaisieP_3.GrEnTeteEnter(Sender: TObject);
begin
GrEnTeteColEnter(1,1,1);
GrEnTete.Options:=GrEnTete.Options+[goEditing];
if GrEnTete.InplaceEditor = nil then
GrEnTete.CreateEditor;
GrEnTete.ShowEditor;
EdDateLivraison.Enabled:=false;
EdDateEcheance.Enabled:=false;
end;

function TsaisieP_3.CtrlSaisiePieceEnteteGrille(var EditCourant:string;Acol:integer;CtrlSuivant:twincontrol):TErreurSaisie;
var
FindID,IDContrePartie,rangTva,rangHT_D,rangHT_E,IDJournalTemp,IDTrameTemp,A:integer;
RecordPiece:TRecordPiece;
CompteTemp,JournalTemp,CodeJournalTemp,ReferenceTemp,LibelleTemp:string;
tab:variant;
InplaceJournal,InplaceGeneral:TInplaceEdit;
conteneur:TPointage;
DPiecetmp:Tdatetime;
conteneurDateLivraisonTmp,mess:string;
ModifiableTmp,TrameAChargerTemp:boolean;
QueryTmp:TQuery;
InfosModel:TInfosModel;
InfosPiece_SurTypeLigne:TInfosPiece_SurTypeLigne;
i:integer;
ValPieceAutoGenere_Tmp:TValPieceAutoGenere;
Begin
InplaceJournal:=TInplaceEdit.Create(self);
InplaceGeneral:=TInplaceEdit.Create(self);
FindID:=0;
IDContrePartie:=-1;
result.CodeErreur:=0;
result.retour:=true;
CompteTemp:='';
ReferenceTemp:='';
LibelleTemp:='';
CodeJournalTemp:='';
JournalTemp:='';
IDJournalTemp:=0;
ModifiableTmp:=false;
try//finally
try//except
if ((ActiveControl<>btnFermer)or(Acol=0)) then
   Begin
      case Acol of
      0:Begin //si edit journal
           try
               JournalTemp:=EditCourant;//sert à conserver la saisie du nouveau
               //journal avant etatinitial
               //if (((journalTmp <> EditCourant))or(((not empty(dmpieces.Piece1.Trame.CodeTrame)) and (dmpieces.Piece1.Trame.CodeTrame <> EditCourant)))) then
               { isa  le  05/01/04 }
               if not empty(EditCourant)then
                 begin
                   InplaceGeneral.Text:=EditCourant;
                   DMPieces.Piece1.Journal:='';
                   if not AideTrameExiste(InplaceGeneral,false,GrEntete,dmpieces.Piece1).retour then
                     abort;
                   EditCourant:=InplaceGeneral.Text;
                   JournalTemp:=DMPieces.Piece1.Journal;
                 end;
               { isa  le  05/01/04 }
               if ((dmpieces.Piece1.Trame.TrameACharger)or (not((((not empty(EditCourant))and(journalTmp = EditCourant)))or(((not empty(dmpieces.Piece1.Trame.CodeTrame)) )and (dmpieces.Piece1.Trame.CodeTrame = EditCourant))))) then
                 begin /////// Attention, journaltmp sert à savoir si le journal a changé ////////
                  //if ((empty(dmpieces.Piece1.Trame.CodeTrame))and(journalTmp=AideModelCode(piece.IDJournal))) then
                  if not dmpieces.Piece1.Trame.TrameACharger then
                    EtatInitial(0,false);
                  EditCourant:=JournalTemp;
                  GrEnTete.cells[0,1]:=JournalTemp;

                 if empty(EditCourant)then
                    begin
                      GrEnTete.cells[0,1]:=journalRegistre;
                      EditCourant:=journalRegistre;
                      InplaceGeneral.Text:=GrEnTete.cells[0,1];
                      AideModelExiste(InplaceGeneral,false);
                      GrEnTete.cells[0,1]:=InplaceGeneral.Text;
                      EditCourant:=InplaceGeneral.Text;
                    end;
               InplaceGeneral.Text:=EditCourant;
               if not empty(dmpieces.Piece1.Trame.codetrame)then
                 InplaceJournal.text:=dmpieces.Piece1.Trame.codetrame
               else
                 InplaceJournal.text:=InplaceGeneral.Text;
               result.retour:=AideTrameExiste(InplaceJournal,false,grentete,dmpieces.piece1).retour;//PB
               EditCourant:=InplaceJournal.Text;
               if result.retour then
               begin //si journal correct
               GrEnTete.cells[0,1]:=EditCourant;
               JournalTmp:=GrEnTete.cells[0,1];
                 if JournalTemp<>EditCourant then GrEnTete.cells[1,1]:=''
                 else
                 if not DMPieces.Piece1.RechercheReference(DMPieces.Piece1.TablePiece,GrEnTete.cells[1,1],'Reference','ID', FindID)then
                    Begin
                    if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                      ReferenceTmp:=DMPieces.Piece1.NewReference(dmPieces.TaPiece,'Reference',DMPieces.Piece1.Journal,DMPieces.Piece1.AnneePiece.ExoAnterieure,GrEnTete.cells[1,1])
                      else
                      ReferenceTmp:=DMPieces.Piece1.NewReference(dmPieces.TaPiece,'Reference',DMPieces.Piece1.Journal,DMPieces.Piece1.CodeExo,GrEnTete.cells[1,1]);
                    DMPieces.Piece1.Reference:=ReferenceTmp;
                    End;
               //affecte la nouvelle référence dans le champ edReference
//      {}     EdReference.Text:=DMPieces.Piece1.NewReference(dmPieces.TaPiece,'Reference',DMPieces.Piece1.Journal,DMPieces.Piece1.CodeExo);
//               DMPieces.Piece1.Reference:=EdReference.Text; //
               If DMPieces.Piece1.EtatPiece in [dsbrowse,dsinsert] then
               Begin
                 if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                 DMPieces.Piece1.Reference:=DMPieces.Piece1.NewReference(dmPieces.TaPiece,'Reference',DMPieces.Piece1.Journal,DMPieces.Piece1.AnneePiece.ExoAnterieure,DMPieces.Piece1.Reference)
                 else
                 DMPieces.Piece1.Reference:=DMPieces.Piece1.NewReference(dmPieces.TaPiece,'Reference',DMPieces.Piece1.Journal,DMPieces.Piece1.CodeExo,DMPieces.Piece1.Reference);
               end;

//               DMPieces.Piece1.IDJournal:=DMPieces.Piece1.RenvoieIDJournal(EditCourant);
                  if DMPieces.Piece1.IDJournal in [3,4]  then
                     Begin //si journal de banque ou d'OD
                     If DMPieces.Piece1.IDJournal =4 then //si journal de banque
                        begin//afficher le compte correspondant directement
                        //dans edcompte et rendre edcompte inactif
                        DMPieces.Piece1.compte:=RenvoieInfoSurTableDiverse(DMPieces.Piece1.Journal,DMPieces.Piece1.TableJournal,'Journal',['Compte'],tab);
                           if not empty(DMPieces.Piece1.compte)then
                           Begin
                             GrEnTete.cells[2,1]:=DMPieces.Piece1.compte;
//                             GestionDuPlusSurEntete(DMPieces.Piece1.compte,dmpieces.Piece1.Journal);
                           End
                           else
                           begin
                           result.retour:=false;
                           result.CodeErreur:=1001;
                           Application.MessageBox(Pchar('Ce journal de Banque n''est pas correct car il n''a pas de compte prédéfini, !!!'),'Erreur de saisie',0);
                           end;
                        end //fin si journal de banque
                     else
                        Begin //si journal d'OD
//                          edcompte.Enabled:=false;
                        End; //Fin si journal d'OD
                     End //fin si journal de banque ou d'OD
                  else
                  ParametreCompteEntete:=DMPieces.RecupParametreCompte(DMPieces.Piece1.compte,'');
                  if copy(DMPieces.Piece1.Compte,1,1)='+'then
                  begin
                  DMPieces.Piece1.ComptePlan:=ParametreCompteEntete.ParamCpt.Compte;
                  DMPieces.Piece1.Tiers:=ParametreCompteEntete.Tiers.Tiers;
                  end
                  else
                  Begin
                  DMPieces.Piece1.ComptePlan:=DMPieces.Piece1.Compte;
                  End;
               If DMPieces.Piece1.EtatPiece in [dsbrowse] then
                  DMPieces.Piece1.EtatPiece:=dsinsert;
               If ((DMPieces.Piece1.trame.IDTrame<>0)and(DMPieces.Piece1.trame.TrameACharger)) then
                 Begin//s'il s'agit d'une trame, récupérer les lignes de cette trame
                    ChargeTrame;
//                    dmpieces.Piece1.trame.TrameACharger:=false;
                 End
               else
                 begin
                   Initialise_TInfosModel(infosmodel);
                   InfosModel:=Infos_TInfosModel(dmrech.TaModelRech,'Journal',[DMPieces.Piece1.journal]);
                   PaTools.caption:='Type pièce : '+DMPieces.Piece1.journal+' - '+InfosModel.Libelle_Model;
                 end;
               if DMPieces.Piece1.IDJournal in [4] then
                 Begin
                   Grgrid1.cells[5,0]:='Débit    (Décaissement)';
                   Grgrid1.cells[6,0]:='Crédit    (Encaissement)';
                 End
               else
                 Begin
                   Grgrid1.cells[5,0]:='Débit    (Charges)';
                   Grgrid1.cells[6,0]:='Crédit    (Produits)';
                 End;
               End //fin si journal correct
               else
               begin //si journal pas correct
               result.retour:=false;
               result.CodeErreur:=1001;
               Application.MessageBox(Pchar('La saisie d''un journal est obligatoire !!!'),'Erreur de saisie',0);
               end;//fin si journal pas correct
             end//fin si journal a changé
             else
               //if not empty(dmpieces.Piece1.Trame.CodeTrame) then
                 Begin//si journal a changé, mais ne nécessite pas de changement
               If DMPieces.Piece1.EtatPiece in [dsbrowse] then
                  DMPieces.Piece1.EtatPiece:=dsinsert;
                    GrEnTete.cells[0,1]:=journaltmp;
                   if empty(GrEnTete.cells[1,1])then
                     begin
                       if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                       DMPieces.Piece1.Reference:=DMPieces.Piece1.NewReference(dmPieces.TaPiece,'Reference',DMPieces.Piece1.Journal,DMPieces.Piece1.AnneePiece.ExoAnterieure,DMPieces.Piece1.Reference)
                       else
                       DMPieces.Piece1.Reference:=DMPieces.Piece1.NewReference(dmPieces.TaPiece,'Reference',DMPieces.Piece1.Journal,DMPieces.Piece1.CodeExo,DMPieces.Piece1.Reference);
                     end;
                 End;//fin si journal a changé, mais ne nécessite pas de changement
           finally
             GestionDuPlusSurEntete(DMPieces.Piece1.compte,dmpieces.Piece1.Journal);
             GestionInfoEntete(DMPieces.Piece1.compte);
           end;//fin du try finally
        if DMPieces.Piece1.Modifier_EnAttente then
          begin
            DMPieces.Piece1.Modifier_Confirmer:=true;
            DMPieces.Piece1.Modifier_EnAttente:=false;
          end;
        End;//fin si edit journal
      end;
   end;
if DMPieces.Piece1.EtatPiece in [dsinsert,dsEdit] then
   Begin
      case Acol of
      1:Begin//si edit reference
        try //finally
            QueryTmp:=TQuery.create(self);
            QueryTmp.DataBaseName:=DMPointage2.TaPointage.DatabaseName;
            QueryTmp.Name:='CtrlSaisiePieceEnteteGrille';
//        EdReference.OnExit:=nil;
            try //except
               if (empty(EditCourant)or(not VerifReferenceDansExercice(EditCourant))or(DMPieces.Piece1.Reference<>EditCourant) or (ReferenceTmp<>EditCourant)) then
               begin//s'il y a eu un changement de reférence
                 if ((not (VerifReferenceDansExercice(EditCourant)))and(not empty(EditCourant)))then
                   Begin
                     result.retour:=false;
                     showmessage('Cette référence n''est pas correcte ! ');
                     abort;
                   End;
                   FindPieceExit:=false;
                   CodeJournalTemp:=GrEnTete.Cells[0,1];
                   JournalTemp:=DMPieces.Piece1.Journal;
                   IDJournalTemp:=DMPieces.Piece1.IDJournal;
                   ReferenceTemp:=editcourant;
                   compteTemp:=GrEnTete.Cells[2,1];
                   LibelleTemp:=GrEnTete.Cells[4,1];
                   GrEnTete.cells[2,1]:='';
                   GrEnTete.cells[3,1]:='';
                   GrEnTete.cells[4,1]:='';
                   DMPieces.Piece1.Trame.IDTrame:=0;
                   etatinitial(1,false);
                     if not DMPieces.Piece1.RechercheReference(DMPieces.Piece1.TablePiece,EditCourant,'Reference','ID', FindID)then
                      begin //si la référence n'existe pas
                          etatinitial(1,false);//vide les edits et la grille + initialise la table temp
                          GrEnTete.Cells[0,1]:=CodeJournalTemp;
                          //GrEnTete.Cells[2,1]:=compteTemp;
                          //GrEnTete.Cells[4,1]:=LibelleTemp;
                          DMPieces.Piece1.Journal:=JournalTemp;
                          DMPieces.Piece1.IDJournal:=IDJournalTemp;
//                          ParametreCompteEntete:=RecupParametreCompte(DMPieces.Piece1.compte,'');
//                          if copy(DMPieces.Piece1.Compte,1,1)='+'then
//                          begin
//                          DMPieces.Piece1.ComptePlan:=ParametreCompteEntete.ParamCpt.Compte;
//                          DMPieces.Piece1.Tiers:=ParametreCompteEntete.Tiers.Tiers;
//                          end
//                          else
//                          Begin
//                          DMPieces.Piece1.ComptePlan:=DMPieces.Piece1.Compte;
//                          End;
                          if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                            begin
                               if EditCourant<>DMPieces.Piece1.NewReference(DMPieces.Piece1.TablePiece,'Reference',DMPieces.Piece1.journal,DMPieces.Piece1.AnneePiece.ExoAnterieure,ReferenceTemp)then
                                  //si la référence n'est pas la nouvelle référence trouvée
                                  EditCourant:=DMPieces.Piece1.NewReference(DMPieces.Piece1.TablePiece,'Reference',DMPieces.Piece1.journal,DMPieces.Piece1.AnneePiece.ExoAnterieure,ReferenceTemp);
                                  //GrEnTete.Cells[1,1]:=EditCourant.text;
                            end //si la référence n'est pas la nouvelle référence trouvée
                          else
                            begin
                               if EditCourant<>DMPieces.Piece1.NewReference(DMPieces.Piece1.TablePiece,'Reference',DMPieces.Piece1.journal,DMPieces.Piece1.CodeExo,ReferenceTemp)then
                                  //si la référence n'est pas la nouvelle référence trouvée
                                  EditCourant:=DMPieces.Piece1.NewReference(DMPieces.Piece1.TablePiece,'Reference',DMPieces.Piece1.journal,DMPieces.Piece1.CodeExo,ReferenceTemp);
                                  //GrEnTete.Cells[1,1]:=EditCourant.text;
                            end; //si la référence n'est pas la nouvelle référence trouvée
                          GrEnTete.Cells[1,1]:=EditCourant;
                          DMPieces.Piece1.Reference:=GrEnTete.Cells[1,1];
                          DMPieces.Piece1.FirstIDPiece:=DMPieces.Piece1.NewIDPiece(DMPieces.Piece1.TablePiece,'ID',not DMPieces.Piece1.AnneePiece.PieceAnterieure);
                          DMPieces.Piece1.EtatPiece:=dsinsert;
                      end //fin si la référence n'existe pas
                      else //si la référence existe déjà
                        if FindPieceExit=false then
                          Begin //si on n'a pas déjà vérifié ce champ et remontée la pièce
                          grGrid1.Row:=1;
                          GrGrid1.Rows[1].clear;
                          DMPieces.Piece1NewPiece(self);
                          DMPieces.Piece1.IDJournal:=IDJournalTemp;
                          GrEnTete.Cells[0,1]:=CodeJournalTemp;
                          GrEnTete.Cells[1,1]:=ReferenceTemp;
                          GrGrid1StateChange(grgrid1.EtatGrille);
                      //  verifie le code journal par rapport à la référence demandée
                      //  si # alors je change le code journal en fonction de la nouvelle référence
                                                         //
  GestionGauge(100,gauge1,1000,0,'Chargement de la pièce',e.TypeClient=cl_isa);
                          RecordPiece:=DMPieces.RecupPieceExistante(EditCourant);
                             if RecordPiece.IDJournal<>DMPieces.Piece1.IDJournal then
                               GrEnTete.Cells[0,1]:=DMPieces.Piece1.RenvoieCodeJournal(RecordPiece.IDJournal);
                           //  Récupère l'entête de la piece
                           DMPieces.Piece1.IDJournal:=RecordPiece.IDJournal;
                           DMPieces.Piece1.Journal:=RecordPiece.Journal;
                             if DMPieces.Piece1.IDJournal<>3 then
                             GrEnTete.Cells[2,1]:=RecordPiece.Compte;
                             GestionDuPlusSurEntete(RecordPiece.Compte,dmpieces.Piece1.Journal);
                             GrEnTete.Cells[3,1]:=datetostr(RecordPiece.date);
                             { isa  le  05/05/04 }
                             EdDateEcheance.Text:=RecordPiece.Echeance;
                             //EdDateEcheance.Text:=GrEnTete.Cells[3,1];
                             EdDateLivraison.Text:=datetostr(RecordPiece.validation);

                            DatePieceTmp:=GrEnTete.Cells[3,1];
                            DateEcheancetmp:=EdDateEcheance.Text;
                            DateLivraisonTmp:=EdDateLivraison.Text;

                             DMPieces.Piece1.DateLivraison:=RecordPiece.validation;
                             DMPieces.Piece1.DateEcheance:=RecordPiece.quand;
                             GrEnTete.cellsGr(4,1,RecordPiece.Libelle);
                             LibelleTmp:=GrEnTete.Cells[4,1];

                             DMPieces.Piece1.FirstIDPiece:=RecordPiece.ID;
                             DMPieces.Piece1.LastIDPiece:=RecordPiece.ID;
                             DMPieces.Piece1.Reference:=RecordPiece.Reference;
                             DMPieces.Piece1.Libelle:=GrEnTete.Cells[4,1];
                             DMPieces.Piece1.Compte:=GrEnTete.Cells[2,1];
                             DMPieces.Piece1.DateSaisie:=RecordPiece.date;
                             DMPieces.Piece1.PieceModifiable:=NOT RecordPiece.AutoGeneree;

                             DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGenere_Tmp);
                             ValPieceAutoGenere_Tmp.Table_Gen:=RecordPiece.Table_Gen;
                             ValPieceAutoGenere_Tmp.Champ_Gen:=RecordPiece.Champ_Gen;
                             ValPieceAutoGenere_Tmp.Val_Champ_Gen:=RecordPiece.Val_Champ_Gen;

              //               if RecordPiece.AutoGeneree then
//                               ValPieceAutoGenere_Tmp.Val_Champ_Gen:=str_getstringelement(ValPieceAutoGenere_Tmp.Val_Champ_Gen,1,';')+';'+e.TypeClientToStr(e.TypeClient)+'_'+e.User;

                             DMPieces.Piece1.ValPieceAutoGen:=ValPieceAutoGenere_Tmp;
                             
                             if e.TypeDossier=Verdiocese then
                               //rechercher si etat de versement
                               DMPieces.Piece1.PieceModifiable:=not DMPieces.Piece1.RetourneInfosEtatVersementSurPiece(RecordPiece.ID,RecordPiece.Date).PieceVerrouillee;
                             if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
                              begin
                               GrGrid1.Options:=GrGrid1.Options-[goediting];
                              end;
                             if copy(DMPieces.Piece1.Compte,1,1)='+'then
                             begin
                             ParametreCompteEntete:=DMPieces.RecupParametreCompte(GrEnTete.Cells[2,1],'');
                             DMPieces.Piece1.ComptePlan:=ParametreCompteEntete.ParamCpt.Compte;
                             DMPieces.Piece1.Tiers:=DMPieces.Piece1.Compte;
                             end
                             else
                             Begin
                             DMPieces.Piece1.ComptePlan:=DMPieces.Piece1.Compte;
                             End;
                      //  Récupère les ecritures de la piece existante à partir de l'ID récupérée
                          //IDContrePartie:=DMPieces.Piece1.IDContrepartie;
                          DMEcritures.Ecriture_Isa1.RecupEcritureSurPieceExistante(FindID,'ID_Piece','TypeLigne',DMPieces.Piece1);
                          //DMPieces.Piece1.IDContrepartie:=IDContrePartie;
                          FindPieceExit:=true;
                          ////////
                          grgrid1.OnRowEnter:=nil;
                          grgrid1.OnColEnter:=nil;
                          grgrid1.OnColExit:=nil;
                          grgrid1.OnRowValidate:=nil;
                          DMPieces.Piece1.EtatPiece:=dsEdit;
                          AfficherEcritureSurPieceExistante;
                          ///Récupérer infos sur le verrouillage de la pièce et de la période
                          rangTva:=DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('T','',2);
                          rangHT_D:= DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('D','',24);
                          rangHT_E:= DMEcritures.Ecriture_Isa1.ListIdentifiantIndexOf('E','',24);
//  { isa  le  03/02/05 mis dans timer}
//  if e.TypeClient=cl_isa then TiRecupInfosPointages.Interval:=50
//  else TiRecupInfosPointages.Interval:=50;
//    TiRecupInfosPointages.Enabled:=true;
                         GestionGauge(100,gauge1,-1,-1,'Récupération des informations sur les pointages associés',e.TypeClient=cl_isa);
                          QueryTmp.sql.Clear;
                              DMPieces.Piece1.InitialiseInfosPointage(conteneur);
                              //recupérer les infos pointages sur liste des contreparties
                              if DMPieces.Piece1.ListeContrePartieTiers<>nil then
                                begin
                                  A:=0;
                                  while ((conteneur.infosPointage.Pointee=false) and (a<DMPieces.Piece1.ListeContrePartieTiers.count))do
                                    begin
                                       conteneur.infosPointage:=DMPointage2.FiltragePointageSurEcriture(QueryTmp,DMPieces.Piece1.ListeContrePartieTiers.Strings[a],DMPieces.Piece1.Sens,true,false,-1);
                                    inc(a);
                                    end;
                                end;
                               //vérifier si les pointages de la pièces ne vont pas engendrer la suppression d'une déclaration tva
                                if conteneur.infosPointage.Pointee then
                                  if not empty(DMPieces.Piece1.tiers)then
                                  conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(DMPieces.Piece1.IDContrepartie,DMPieces.Piece1.Tiers)
                                  else
                                  conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(DMPieces.Piece1.IDContrepartie,DMPieces.Piece1.compte);
                               DMPieces.Piece1.InfosPointage:=conteneur;
                               //changé par isa le 19/08/03 ***
//                               DMPieces.Piece1.InfosVerrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,recordpiece.ID,recordpiece.Validation);
                               if Type_version_execution=ct_distribution then
                                 DMPieces.Piece1.InfosVerrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,recordpiece.ID,recordpiece.date);
                               grgrid1.row:=1;
                          End; //fin si on n'a pas déjà vérifié ce champ et remontée la pièce
                     GestionDuPlusSurEntete(DMPieces.Piece1.compte,dmpieces.Piece1.Journal);
                     GestionInfoEntete(DMPieces.Piece1.compte);
                     ReferenceTmp:=editcourant;
                  end;//fin s'il y a eu un changement de reférence
               except
               result.CodeErreur:=2001;
               result.retour:=false;
               end;//fin du try
        finally

        LibereObjet(TObject(QueryTmp),Self);
//        if QueryTmp<>nil then
//          begin
//          QueryTmp.close;
//          QueryTmp.free;
//          end;
        grgrid1.OnRowEnter:=GrGrid1RowEnter;
        grgrid1.OnColEnter:=GrGrid1ColEnter;
        grgrid1.OnColExit:=GrGrid1ColExit;
        grgrid1.OnRowValidate:=GrGrid1RowValidate;
          GestionGauge(0,gauge1,0,0,'',false);
        end;//fin du try finally
        if DMPieces.Piece1.Modifier_EnAttente then
          begin
            DMPieces.Piece1.Modifier_Confirmer:=true;
            DMPieces.Piece1.Modifier_EnAttente:=false;
          end;
        End;//fin si edit reference
      2:Begin//si edit compte
         //Suivant le journal, on filtre aidecompte(OD=Tous;AC ou VT=Tiers)
         try
         InplaceGeneral.Text:=editcourant;
         case DMPieces.Piece1.IDJournal of
          1,2:begin //si journal d'achat ou de vente
              DMPieces.GestionFiltrageParamCpt;
                //if empty(EdPlusTiersEntete.Text) then //PB
                if ((not empty(InplaceGeneral.Text) and (copy(InplaceGeneral.Text,1,1)<>'+'))or(empty(EdPlusTiersEntete.Text))) then { isa  le  27/01/04 }
                  begin//si compte comptable
                    result.retour:= AideCompteDansContexte(InplaceGeneral.Text,InplaceGeneral,['Rac1'],false,MessDerSub,false,true,true,true,0);
                    if Result.retour then Result.retour:=not DMPieces.CptExclusDeContexte(InplaceGeneral.Text,1)
                    else Result.CodeErreur:=30010;//pas dans contexte
                    if Result.retour then
                    if copy(InplaceGeneral.Text,1,1)='4'then
                      begin
                      Result.retour:=DMPlan.CptEstPointable(InplaceGeneral.Text);
                        if not result.retour then Result.CodeErreur:=30012;//compte non pointable
                      end
                    else Result.CodeErreur:=30011;//compte exclus
                  end //fin si compte comptable
                else
                  Begin//si compte de tiers
                    result.retour:= AideCompteDansContexte(InplaceGeneral.Text,InplaceGeneral,['Rac1'],false,MessDerSub,false,true,true,true,1);
                    if not result.retour then Result.CodeErreur:=30010;//pas dans contexte
                  End;//fin si compte de tiers
              editcourant:=InplaceGeneral.Text;
              end; //fin si journal d'achat ou de vente
            3:begin //si journal OD
                if not empty(EditCourant)then
                  begin//si compte rempli
                  DMPieces.GestionFiltrageParamCpt;
                  if empty(EdPlusTiersEntete.Text) then //PB
                    begin//si compte de  tiers
                      result.retour:= AideCompteDansContexte(InplaceGeneral.Text,InplaceGeneral,['Rac1'],false,MessDerSub,true,true,true,true,0);
                      if Result.retour then Result.retour:=not DMPieces.CptExclusDeContexte(InplaceGeneral.Text,1)
                      else Result.CodeErreur:=30010;//pas dans contexte
                      if not result.retour then Result.CodeErreur:=30011;//compte exclus
                    end//fin si compte de  tiers
                  else
                    Begin //si compte comptable
                      result.retour:= AideCompteDansContexte(InplaceGeneral.Text,InplaceGeneral,['Rac1'],false,MessDerSub,true,true,true,true,1);
                      if not result.retour then Result.CodeErreur:=30010;//pas dans contexte
                    End;//fin si compte comptable
//                  result.retour:= AideCompteDansContexte(EdCompte.Text,EdCompte,['Rac1'],true,MessDerSub,true,true,true,true,0); PB
                  end;//fin si compte rempli
              editcourant:=InplaceGeneral.Text;
              end; //fin si journal OD
            4:begin //si journal de banque
               if empty(EditCourant)then
               begin
                 InplaceGeneral.Text:=RenvoieInfoSurTableDiverse(DMPieces.Piece1.Journal,DMPieces.Piece1.TableJournal,'Journal',['Compte'],tab);
                 EditCourant:=InplaceGeneral.Text;
               end;
               result.retour:=EditCourant=RenvoieInfoSurTableDiverse(DMPieces.Piece1.Journal,DMPieces.Piece1.TableJournal,'Journal',['Compte'],tab);
              end; //fin si journal de banque
         end;//fin du case
         if ((empty(InplaceGeneral.Text))and(DMPieces.Piece1.IDJournal<>3))then
           begin
             result.retour:=false;
             Result.CodeErreur:=30010;//pas dans contexte
           end;
         if result.retour then
           begin

             GrEnTete.Cells[2,1]:=InplaceGeneral.Text;
             DMPieces.Piece1.Compte:=GrEnTete.Cells[2,1];
             GestionDuPlusSurEntete(DMPieces.Piece1.compte,dmpieces.Piece1.Journal);
           if ((CompteEnteteTmp<>DMPieces.Piece1.Compte)and((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and(DMPieces.Piece1.EtatPiece=dsedit)) then
             begin
               if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                  begin
                    if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                       ModifiableTmp:=true;
                  end
               else
                  ModifiableTmp:=true;
             if ModifiableTmp then //si on veut quand même la modifier
                begin
                  DMPieces.Piece1.Modifier_EnAttente:=true;
                  ParametreCompteEntete:=DMPieces.RecupParametreCompte(EditCourant,'');
                  if copy(DMPieces.Piece1.Compte,1,1)='+'then
                    begin
                    DMPieces.Piece1.ComptePlan:=ParametreCompteEntete.ParamCpt.Compte;
                    DMPieces.Piece1.Tiers:=ParametreCompteEntete.Tiers.Tiers;
                    end
                  else
                    DMPieces.Piece1.ComptePlan:=DMPieces.Piece1.Compte;
                end
                else
                begin
                EditCourant:=CompteEnteteTmp;
                DMPieces.Piece1.Compte:=EditCourant;
                GrEnTete.cells[2,1]:=EditCourant;
                GestionDuPlusSurEntete(EditCourant,dmpieces.Piece1.Journal);
                end;
             end
             else
             Begin
             ParametreCompteEntete:=DMPieces.RecupParametreCompte(EditCourant,'');
             if copy(DMPieces.Piece1.Compte,1,1)='+'then
               begin
               DMPieces.Piece1.ComptePlan:=ParametreCompteEntete.ParamCpt.Compte;
               DMPieces.Piece1.Tiers:=ParametreCompteEntete.Tiers.Tiers;
               end
             else
               begin
                 DMPieces.Piece1.ComptePlan:=DMPieces.Piece1.Compte;
                 DMPieces.Piece1.Tiers:='';
               end;
             End;
               { isa  le  03/08/04 morceau ajouté après la version du 13-01-04 sert à vérifier la cohérence des compléménts ligne}
               {en fonction du compte d'entête. si compte de banque, la pièce est automatiquement réglée d'où modification du type tva}
                //provoque le changement de certains taux de tva lors d'un simplement changement de tiers ou compte d'entête ??

                   if CompteEnteteTmp<>GrEnTete.Cells[2,1]then
                    begin
                     for i:=1 to DMEcritures.Ecriture_Isa1.ListIdentifiant.count-1 do
                       begin
                         if not(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.Ligne.Typeligne in ['V','T']) then
                            begin//si ce n'est pas une ligne vide, alors on remplie la grille
                             with Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.Items[i])^ do
                               begin
                                   InfosPiece_SurTypeLigne:=DMEcritures.Ecriture_Isa1.RecupSens_Et_SoldeSurEcritureListe(i,DMEcritures.Ecriture_Isa1.ListIdentifiant);
                                   RecupInfosComplementLigne(false,Ligne.complement,Ligne.TVA.CodeTva,'H',grgrid1.Cells[1,i],InfosPiece_SurTypeLigne.Solde,true);
                               end;
                            end;//fin si ce n'est pas une ligne vide, alors on remplie la grille
                       end;
                    end;
                 /////////////////////////////////
           end
           else
           begin
             result.retour:=false;
        //   result.CodeErreur:=3001;
           end;
         finally
           GestionDuPlusSurEntete(DMPieces.Piece1.Compte,dmpieces.Piece1.Journal);
         end;//fin du try finally
        if DMPieces.Piece1.Modifier_EnAttente then
          begin
            DMPieces.Piece1.Modifier_Confirmer:=true;
            DMPieces.Piece1.Modifier_EnAttente:=false;
          end;
        End;//fin si edit compte
      3:Begin //si editDate
        InplaceGeneral.Text:=editcourant;
        InplaceGeneral.Text:=AnneeDefaut(DMPieces.Piece1.DateDebutExo,DMPieces.Piece1.DateFinExo,InplaceGeneral.Text).DateStr;
        if not empty(InplaceGeneral.Text)then
           begin //si la date est remplie
           if DateValide(InplaceGeneral.Text)then
             begin //si la date est valide
              InplaceGeneral.Text:=DateToStr(StrToDate_Lgr(InplaceGeneral.Text));
              if not DMPieces.Piece1.AnneePiece.PieceAnterieure then
                 begin //si saisie pièce année en cours
                 if not DMPieces.Piece1.VerifDateSaisie(StrToDate_Lgr(InplaceGeneral.Text))then
                   Begin
                     result.retour:=false;
                     result.CodeErreur:=4003;
                     Application.MessageBox(Pchar('La date saisie doit faire partie de l''exercice en cours '),'Erreur de saisie',0);
                   End;
                 end //fin si saisie pièce année en cours
              else
               begin
                 result.retour:=StrToDate_Lgr(InplaceGeneral.Text)<E.DatExoDebut;
                 if not result.retour then
                   Begin
                     result.CodeErreur:=4004;
                     Application.MessageBox(Pchar('La date saisie doit être antérieure à la date du début de l''exercice en cours.'),'Erreur de saisie',0);
                   End;
               end;//fin si saisie pièce année antérieure
               if ((result.retour)and(DatePieceTmp<>EditCourant)and(DatePiecetmp=EdDateLivraison.Text))then
                   begin //si la date de la pièce est modifiée
                      DMPieces.Piece1.DateSaisie:=StrToDate_Lgr(InplaceGeneral.Text);
                      DPiecetmp:=DMPieces.Piece1.DateSaisie;
                      conteneurDateLivraisonTmp:=DateLivraisontmp;
                      EdDateLivraisonAcceptDate(nil,DPiecetmp,result.retour);
                      if result.retour then
                        Begin
                        EdDateLivraison.Text:=datetostr(DMPieces.Piece1.DateLivraison);
                        DateLivraisontmp:=EdDateLivraison.text;
                        if DatePiecetmp=EdDateEcheance.Text then
                          begin
                            EdDateEcheance.Text:=datetostr(DMPieces.Piece1.DateSaisie);
                            DateEcheancetmp:=EdDateEcheance.Text;
                          end;
                        DatePiecetmp:=datetostr(DMPieces.Piece1.DateSaisie);
                        End
                      else
                        begin
                        InplaceGeneral.Text:=datetostr(DPiecetmp);
                        DateLivraisontmp:=conteneurDateLivraisonTmp;
                        DMPieces.Piece1.DateSaisie:=DPiecetmp;
                        DatePiecetmp:=datetostr(DPiecetmp);
                        GrEnTete.Cells[3,1]:=InplaceGeneral.Text;
                        abort;
                        end;
                  if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and(DMPieces.Piece1.EtatPiece=dsedit)) then
                     begin //si date à changée et piece existante pas encore modifiée
                       GrEnTeteChange(GrEnTete);
                       DMPieces.Piece1.Modifier_EnAttente:=true;
                     end;
                   end;//fin si la date de la pièce est modifiée
             end//fin si la date est valide
             else
             Begin //si la date n'est pas valide
                 result.retour:=false;
                 result.CodeErreur:=4002;
                 Application.MessageBox(Pchar('Cette date n''est pas valide.'),'Erreur de saisie',0);
             End;//fin si la date n'est pas valide
           end //fin si la date est remplie
        else
           Begin //si la date est vide
             result.retour:=false;
             result.CodeErreur:=4001;
             Application.MessageBox(Pchar('Vous devez saisir une date de pièce, !!!'),'Erreur de saisie',0);
           End;//fin si la date est vide
        editcourant:=InplaceGeneral.Text;
        if DMPieces.Piece1.Modifier_EnAttente then
          begin
            DMPieces.Piece1.Modifier_Confirmer:=true;
            DMPieces.Piece1.Modifier_EnAttente:=false;
          end;
        End;//fin si editDate
      4:Begin //si editLibelle
         if ((DMPieces.Piece1.Libelle<>editcourant)or(empty(editcourant))) then
            begin
           try
            InplaceGeneral.Text:=editcourant;
             if empty(InplaceGeneral.Text) then
               begin
                  if copy(DMPieces.Piece1.Compte,1,1)='+' then
                  DMPieces.Piece1.InitLibelle(DMPieces.Piece1.TableTiers,DMPieces.Piece1.ICompteTiers,DMPieces.Piece1.ILibTiers,true)
                  else
                  DMPieces.Piece1.InitLibelle(DMPieces.Piece1.TablePlan,DMPieces.Piece1.IndexCompte,DMPieces.Piece1.ILibTaPlan,true);
               InplaceGeneral.Text:=DMPieces.Piece1.Libelle;
               end
               else
               //si le libelle est rempli avec *
                 if ((trim(InplaceGeneral.Text)='*')and(not empty(DMPieces.Piece1.Compte))) then
                    Begin //si champ libelle rempli avec *
                      if copy(DMPieces.Piece1.Compte,1,1)='+' then
                      DMPieces.Piece1.InitLibelle(DMPieces.Piece1.TableTiers,DMPieces.Piece1.ICompteTiers,DMPieces.Piece1.ILibTiers,false)
                      else
                      DMPieces.Piece1.InitLibelle(DMPieces.Piece1.TablePlan,DMPieces.Piece1.IndexCompte,DMPieces.Piece1.ILibTaPlan,false);
                      InplaceGeneral.Text:=DMPieces.Piece1.Libelle;
                    End;//fin si champ libelle rempli avec *
             result.retour:=not empty(InplaceGeneral.Text);

             if result.retour then
             Begin
             if ((LibelleTmp<>InplaceGeneral.Text)and((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and(DMPieces.Piece1.EtatPiece=dsedit)) then
               begin //si date à changée et piece existante pas encore modifiée
                 if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                    begin
                      if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                         ModifiableTmp:=true;
                    end
                 else
                    ModifiableTmp:=true;
               if ModifiableTmp then //si on veut quand même la modifier
                  begin //si on veut quand même la modifier
                    DMPieces.Piece1.Modifier_EnAttente:=true;
                  end
                  else
                  Begin
                    InplaceGeneral.Text:=LibelleTmp;
                    DMPieces.Piece1.Libelle:=InplaceGeneral.Text;
                  End;
               end;
             End;
          finally
          end;//fin du try finally
          if result.retour then
            begin
            DMPieces.Piece1.Libelle:=InplaceGeneral.Text;
            DMPieces.Piece1.DernierLibelleSaisi:=DMPieces.Piece1.Libelle;
            GrEnTete.cellsGr(4,1,InplaceGeneral.Text);
            end
            else
            Application.MessageBox(Pchar('La saisie du Libellé est obligatoire !!!'),'Erreur de saisie',0);
          editcourant:=InplaceGeneral.Text;
          end;//si libellé a changé
        if DMPieces.Piece1.Modifier_EnAttente then
          begin
            DMPieces.Piece1.Modifier_Confirmer:=true;
            DMPieces.Piece1.Modifier_EnAttente:=false;
          end;
        End;//fin editLibelle
      6:begin //si editLivraison
          DMPieces.Piece1.DateLivraison:=strtodate_lgr(EdDateLivraison.text,DMPieces.Piece1.DateSaisie);
        end;//fin si editLivraison
      7:begin //si editEcheance
           DMPieces.Piece1.DateEcheance:=strtodate_lgr(EdDateEcheance.text,DMPieces.Piece1.DateSaisie);
        end;//fin si editEcheance
      end;//fin du case
   End;//fin etatpiece in [dsinsert,dsEdit]
except
  DMPieces.Piece1.Modifier_EnAttente:=false;
  result.retour:=false;
//  abort;
end;//fin du try except
finally
if InplaceJournal<>nil then
  InplaceJournal.free;
if InplaceGeneral<>nil then
  InplaceGeneral.free;
end;//fin du try finally
End;



procedure TsaisieP_3.GrEnTeteColEnter(OldColonne, NewColonne,
  NewRow: Integer);
var
NewCol:integer;
begin
  try
  GrEnTete.oncolenter:=nil;
  GrEnTete.OnColExit:=nil;
  newcol:=-1;
  if ((DMPieces.Piece1.IDJournal in [3,4])and(GrEnTete.newcolonne=2)) then
    if GrEnTete.OldColonne<GrEnTete.newcolonne then
      NewCol:=3
    else
      newcol:=1;
    if NewCol<>-1 then
      begin
      GrEnTete.row:=newrow;
      GrEnTete.col:=newcol;
      GrEnTete.OldColonne:=newcol;
      abort;
      end;
  finally
    GrEnTete.oncolenter:=GrEnTeteColEnter;
    GrEnTete.OnColExit:=GrEnTeteColExit;
    JournalTmp:=GrEnTete.Cells[0,1];
    ReferenceTmp:=GrEnTete.Cells[1,1];
    CompteEnteteTmp:=GrEnTete.Cells[2,1];
    DatePiecetmp:=GrEnTete.Cells[3,1];
    LibelleTmp:=GrEnTete.Cells[4,1];
  end;//fin du try finally
end;

procedure TsaisieP_3.GrEnTeteSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
//PlusDefautEntete:=false;
//PlusAutomatiqueEntete:=false;
if acol=1 then
 if FindPieceExit then FindPieceExit:=false;
case ACol of
   2:begin
      if PlusDefautEntete then
      if PlusAutomatiqueEntete then
         if length(GrEnTete.InplaceEditor.Text) > 0 then
          begin
            if copy(GrEnTete.InplaceEditor.text,1,1)<>'+' then
             begin
              GrEnTete.InplaceEditor.text:='+'+GrEnTete.InplaceEditor.text;
              GrEnTete.InplaceEditor.SelStart:=length(GrEnTete.InplaceEditor.Text);
             end;
          end
          else
          Begin
              GrEnTete.InplaceEditor.text:='+'+GrEnTete.InplaceEditor.text;
              GrEnTete.InplaceEditor.SelStart:=length(GrEnTete.InplaceEditor.Text);
          End;
     end;
end;

end;

procedure TsaisieP_3.GrEnTeteKeyPress(Sender: TObject; var Key: Char);
var
FindID,RefTmp:integer;
LastRef,NewRef:string;
trouve:boolean;
NouvelleRef:string;
begin
case grEntete.Col of
   0:  Begin//si journal
         if key in [#97..#122,#231..#233,#224,#249] then
           key:=uppercase(key)[1];
       End;//fin si journal
   1:begin//   colonne reference
         if ((not (key in [#8,#9,#13,#45,#43]))and (grEntete.InplaceEditor.SelLength=0)and(length(GrEnTete.InplaceEditor.text)>=9)) then
           key:=#0;
     if DMPieces.Piece1.EtatPiece=dsedit then
         if not (key in [#9,#13,#45,#43]) then
           key:=#0;

       if key ='+' then
         begin
         key:=#0;
           if length(GrEnTete.InplaceEditor.text)=9 then
             begin
             trouve:=false;
             LastRef:=GrEnTete.InplaceEditor.text;
             RefTmp:=StrToInt_Lgr(copy(LastRef,3,length(LastRef)-2));
             while not trouve do
                begin
                inc(RefTmp);
                NewRef:=inttostr(RefTmp);
                while length(NewRef)<7 do
                  NewRef:='0'+NewRef;
                NewRef:=copy(LastRef,1,2)+NewRef;
                    if DMPieces.Piece1.AnneePiece.PieceAnterieure then
                       NouvelleRef:=DMPieces.Piece1.NewReference(DMPieces.Piece1.TablePiece,'Reference',DMPieces.Piece1.journal,DMPieces.Piece1.AnneePiece.ExoAnterieure,'')
                    else
                       NouvelleRef:=DMPieces.Piece1.NewReference(DMPieces.Piece1.TablePiece,'Reference',DMPieces.Piece1.journal,DMPieces.Piece1.CodeExo,'');
                    if NewRef<NouvelleRef then
                     //si nouvelle ref recherchée <= nouvelle reference réelle
                     trouve:=DMPieces.Piece1.RechercheReference(DMPieces.Piece1.TablePiece,NewRef,'Reference','ID',FindID)
                    else
                    break;//sinon on sort de la boucle, et on ne fait rien
                end;//fin du while not trouve
             if trouve then
              begin
              GrEnTete.InplaceEditor.text:=NewRef;
              end
              else
                 if NewRef=NouvelleRef then
                   GrEnTete.InplaceEditor.text:=NewRef;
             GrEnTete.InplaceEditor.SelStart:=length(GrEnTete.InplaceEditor.text);
             end;
         end;

       if key ='-' then
         begin //si décrémentation des references
         key:=#0;
           if length(GrEnTete.InplaceEditor.text)=9 then
             begin
             trouve:=false;
             LastRef:=GrEnTete.InplaceEditor.text;
             RefTmp:=StrToInt_Lgr(copy(LastRef,5,length(LastRef)-2));
             if RefTmp-1>0 then
                begin //si RefTmp-1>0
                    while not trouve do
                    begin //début du while
                       inc(RefTmp,-1);
                       if RefTmp>0 then
                         begin
                         NewRef:=inttostr(RefTmp);
                           while length(NewRef)<5 do
                           NewRef:='0'+NewRef;
                         NewRef:=copy(LastRef,1,4)+NewRef;
                         trouve:=DMPieces.Piece1.RechercheReference(DMPieces.Piece1.TablePiece,NewRef,'Reference','ID',FindID);
                         end
                         else
                         break;
                    end;//fin du while
                end;//si RefTmp-1>0
                  if trouve then
                   begin
                    grEntete.InplaceEditor.text:=NewRef;
                   end
                    else
                    grEntete.InplaceEditor.text:=LastRef;
                  grEntete.InplaceEditor.SelStart:=length(grEntete.InplaceEditor.text);
               DMPieces.Piece1.Reference:=grEntete.InplaceEditor.text;
             end;
         end;//fin si décrémentation des references

       //on regarde sur les 2 premiers caractères s'ils correspondent à un début de référence
       //sinon on annule le caractère tapé.
       if ((grEntete.InplaceEditor.SelLength=0) and not(key in [#8,#9,#13,#43,#45,#46])) then
       Begin
          case grEntete.InplaceEditor.SelStart of
          0:Begin
               if  key in [#48..#57] then
               key:=#0
               else
               if not DMPieces.Piece1.TableJournal.Locate('Journal',key,[loCaseInsensitive, loPartialKey])then
                 key:=#0;
            End;
          1:Begin
            if not DMPieces.Piece1.TableJournal.Locate('Journal',copy(grEntete.InplaceEditor.Text,1,1)+key,[loCaseInsensitive, loPartialKey])then
              key:=#0;
            End;
          else
             if not (key in [#48..#57]) then
                key:=#0;
          end;//fin du case
       End;
     end;//fin colonne reference
   2:begin //colonne compte
       // PB
       if DMPieces.Piece1.IDJournal in [3,4] then
         if not (key in [#9,#13]) then
           key:=#0;
       if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
          Begin
             //si piece non modifiable
            if not (key in [#13,#9])then
              begin
                showmessage('Cette pièce n''est pas modifiable ');
                key :=#0;
              end;
          End;

       if ((key = #43)and(length(grEntete.InplaceEditor.Text)<=1)) then // +
         Begin
          if empty(grEntete.InplaceEditor.Text) and E.PlanAuxT then
           begin
             key:=#0;
             grEntete.InplaceEditor.Text:='+';
             grEntete.InplaceEditor.SelStart:=length(grEntete.InplaceEditor.Text);
             PlusDefautEntete:=true;
             PlusAutomatiqueEntete:=true;
             GrEnTete.cells[2,0]:='  Tiers';
             EdPlusTiersEntete.Text:='+';
           end
           else
           begin
            if PlusAutomatiqueEntete then
             if copy(grEntete.InplaceEditor.text,1,1)<>'+' then
              begin
               key:=#0;
               grEntete.InplaceEditor.text:='+'+grEntete.InplaceEditor.text;
               grEntete.InplaceEditor.SelStart:=length(grEntete.InplaceEditor.Text);
              end;
           end;
         End;

       // PB
       if ((key = #46)and(length(grEntete.InplaceEditor.Text)<=1)) then // . pour enlever le + par défaut
         Begin
          if not empty(EdPlusTiersEntete.Text) then
           begin
             GrEnTete.cells[2,0]:='  Compte';
             EdPlusTiersEntete.Text:='';
             key:=#0;
             grEntete.InplaceEditor.Text:='';
             grEntete.InplaceEditor.SelStart:=length(grEntete.InplaceEditor.Text);
             PlusDefautEntete:=False;
             PlusAutomatiqueEntete:=False;
           end
           else
           Begin
             GrEnTete.cells[2,0]:='  Tiers';
             EdPlusTiersEntete.Text:='+';
             key:=#0;
             grEntete.InplaceEditor.Text:='+';
             PlusDefautEntete:=True;
             PlusAutomatiqueEntete:=True;
             grEntete.InplaceEditor.SelStart:=length(grEntete.InplaceEditor.Text);
           End;

         End;
        if key in [#65..#90,#97..#122] then
         Begin
          if E.PlanAuxT then
           begin
             if copy(grEntete.InplaceEditor.Text,1,1) <> '+' then
             grEntete.InplaceEditor.Text:='+'+grEntete.InplaceEditor.Text;
             grEntete.InplaceEditor.SelStart:=length(grEntete.InplaceEditor.Text);
             GrEnTete.cells[2,0]:='  Tiers';
             PlusDefautEntete:=true;
             PlusAutomatiqueEntete:=true;
             EdPlusTiersEntete.Text:='+';
           end;
          end;

        if ((key = #8) and (PlusAutomatiqueEntete) and (grEntete.InplaceEditor.SelStart = 1)) then
         begin
             GrEnTete.cells[2,0]:='  Compte';
             EdPlusTiersEntete.Text:='';
             key:=#0;
             grEntete.InplaceEditor.Text:='';
             grEntete.InplaceEditor.SelStart:=length(grEntete.InplaceEditor.Text);
             PlusDefautEntete:=False;
             PlusAutomatiqueEntete:=False;
         end;
         GestionInfoEntete(DMPieces.Piece1.compte);

     end;//fin colonne compte
 3:begin //colonne compte
       // PB
       if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
          Begin
             //si piece non modifiable
            if not (key in [#13,#9])then
              begin
                showmessage('Cette pièce n''est pas modifiable ');
                key :=#0;
              end;
          End;
   end;
 4:begin //colonne Libelle
       if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
          Begin
             //si piece non modifiable
            if not (key in [#13,#9])then
              begin
                showmessage('Cette pièce n''est pas modifiable ');
                key :=#0;
              end;
          End;
   end;
end;
end;

procedure TsaisieP_3.GrEnTeteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
keytmp:char;
begin
if key=45 then key:=0;
case grEntete.col of
     0:if key = VK_RETURN then
        if empty(GrEnTete.InplaceEditor.text) then key:=VK_RIGHT;
     1:if DMPieces.Piece1.EtatPiece=dsedit then
         if not (key in [9,13,109,107,33..40]) then
           key:=0;
     2:if DMPieces.Piece1.IDJournal in [3,4] then
         if not (key in [9,13,33..40]) then
           key:=0;
     4: if key = VK_RETURN then
         if grEntete.InplaceEditor.Visible then
         begin
           grEntete.InplaceEditor.Hide;
           GrEnTete.InplaceEditor.ValidateEdit;
           grEntete.Repaint;
           grEntete.Refresh;
         end
         else
          GrGrid1.SetFocus;
      end;

if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
 begin
   case grEntete.col of
     2,3,4:if ((key<> VK_LEFT) and (key<>VK_RIGHT) and (key<>VK_RETURN)and (key<>VK_ESCAPE)and (key<>VK_TAB)) then
           begin
             //si piece non modifiable
            showmessage('Cette pièce n''est pas modifiable ');
            key :=0;
           End;
       1:if (((Shift =[ssshift]) or (Shift=[ssctrl]))and ((key=Vk_Delete) or (key=vk_insert)))then
         key:=0;
   end;
 end;

if key = VK_UP then
  begin
   keytmp:='-';
   GrEnTeteKeyPress(sender,keytmp);
  end;
if key = VK_DOWN then
  begin
   keytmp:='+';
   GrEnTeteKeyPress(sender,keytmp);
  end;

end;

procedure TsaisieP_3.GrEnTeteExit(Sender: TObject);
var
i:integer;
valide:TErreurSaisie;
editortmp:string;
InplaceTmp:TInplaceEdit;
begin
   try
   InplaceTmp:=TInplaceEdit.Create(self);
   GrEnTete.Options:=GrEnTete.Options-[goEditing];
   GrEnTete.Refresh;
   valide.retour:=true;
   valide.CodeErreur:=0;
   i:=0;
   try
   if ((ActiveControl<>BtnAnnuler)and(ActiveControl<>BtnAnnulerControle)and(ActiveControl<>BtnRecherchePiece)and(ActiveControl<>RxChListCpt)and(ActiveControl<>Btnfermer)) then
      begin
         while ((valide.retour)and(i<GrEnTete.colcount ))do
           Begin
            InplaceTmp.tag:=i;
            if ((GrEnTete.Col=i)and(GrEnTete.InplaceEditor.visible)) then
              InplaceTmp.Text:=GrEnTete.InplaceEditor.Text
            else
              InplaceTmp.Text:=GrEnTete.cells[i,1];
              editortmp:=InplaceTmp.Text;
            valide:=CtrlSaisiePieceEnteteGrille(editortmp,i,nil);
            if not valide.retour then
              Begin
               GrEnTete.setfocus;
              End
              else
              GrEnTete.cells[i,1]:=editortmp;
            inc(i);
           End;
      GestionInfoCorps(grgrid1.Cells[1,grgrid1.row]);
EdDateLivraison.Enabled:=true;
EdDateEcheance.Enabled:=true;

      end;
   except
     GrEnTete.setfocus;
   end;

   finally
     InplaceTmp.Free;
   end;//fin du try finally
end;

procedure TsaisieP_3.PaGrilleTeteResize(Sender: TObject);
begin
GrEnTete.ColWidths[4]:=GrEnTete.Width-GrEnTete.ColWidths[3]-GrEnTete.ColWidths[2]-GrEnTete.ColWidths[1]-GrEnTete.ColWidths[0]-10;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TsaisieP_3.PaGrilleTeteEnter(Sender: TObject);
begin
PopupMenu:=PopupMenuPiece;
BtnAnnuler.OnClick:=BtnAnnulerClick;
BtnInserer.OnClick:=BtnInsererClick;
btnmodifier.OnClick:=BtnModifierClick;
BtnSupprimer.OnClick:=BtnSupprimerClick;
end;

procedure TsaisieP_3.PatitreResize(Sender: TObject);
begin
RxSpeedButton1.Left:=Patitre.Width-104;
end;

Procedure TsaisieP_3.ChargeTrame;
Begin
    grGrid1.Row:=1;
    grentete.cells[0,0]:='Trame ';
    PaTools.caption:= 'Trame de saisie : '+DMPieces.Piece1.trame.CodeTrame+' _ '+DMPieces.piece1.Trame.LibelleTrame;
    GrGrid1.Rows[1].clear;
    GrGrid1StateChange(grgrid1.EtatGrille);
//  verifie le code journal par rapport à la référence demandée
//  si # alors je change le code journal en fonction de la nouvelle référence
//    RecordPiece:=DMPieces.RecupPieceExistante(EditCourant.Text);
//       if RecordPiece.Journal<>DMPieces.Piece1.IDJournal then
//         GrEnTete.Cells[0,1]:=DMPieces.Piece1.RenvoieCodeJournal(RecordPiece.Journal);
     //  Récupère l'entête de la piece
       if DMPieces.Piece1.IDJournal<>3 then
       GrEnTete.Cells[2,1]:=DMPieces.Piece1.Compte;
       GestionDuPlusSurEntete(DMPieces.Piece1.Compte,dmpieces.Piece1.Journal);
//       GrEnTete.Cells[3,1]:=datetostr(RecordPiece.date);
       EdDateEcheance.Text:=GrEnTete.Cells[3,1];
       EdDateLivraison.Text:=GrEnTete.Cells[3,1];

      DatePieceTmp:=GrEnTete.Cells[3,1];
      DateEcheancetmp:=EdDateEcheance.Text;
      DateLivraisonTmp:=EdDateLivraison.Text;
      if not empty(GrEnTete.Cells[3,1])then
       begin
         DMPieces.Piece1.DateLivraison:=StrToDate_Lgr(GrEnTete.Cells[3,1]);
         DMPieces.Piece1.DateEcheance:=StrToDate_Lgr(GrEnTete.Cells[3,1]);
       end;
       GrEnTete.cellsGr(4,1,DMPieces.Piece1.Libelle);
       LibelleTmp:=GrEnTete.Cells[4,1];
//       DMPieces.Piece1.IDJournal:=DMPieces.Piece1.RenvoieIDJournal(GrEnTete.Cells[0,1]);
//       DMPieces.Piece1.FirstIDPiece:=RecordPiece.ID;
       DMPieces.Piece1.Libelle:=GrEnTete.Cells[4,1];
       DMPieces.Piece1.Compte:=GrEnTete.Cells[2,1];
//       DMPieces.Piece1.PieceModifiable:=NOT RecordPiece.AutoGeneree;
       if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
        begin
         GrGrid1.Options:=GrGrid1.Options-[goediting];
        end;
       if copy(DMPieces.Piece1.Compte,1,1)='+'then
       begin
       ParametreCompteEntete:=DMPieces.RecupParametreCompte(GrEnTete.Cells[2,1],'');
       DMPieces.Piece1.ComptePlan:=ParametreCompteEntete.ParamCpt.Compte;
       DMPieces.Piece1.Tiers:=DMPieces.Piece1.Compte;
       end
       else
       Begin
       DMPieces.Piece1.ComptePlan:=DMPieces.Piece1.Compte;
       End;
//  Récupère les ecritures de la piece existante à partir de l'ID Trame récupérée
    DMEcritures.Ecriture_Isa1.RecupEcritureSurTrame(DMPieces.Piece1.trame.IDTrame);
    FindPieceExit:=true;
    ////////
    grgrid1.OnRowEnter:=nil;
    grgrid1.OnColEnter:=nil;
    grgrid1.OnColExit:=nil;
    grgrid1.OnRowValidate:=nil;

    AfficherEcritureSurPieceExistante;
    ///Récupérer infos sur le verrouillage de la pièce et de la période
//    rangTva:=ListIdentifiantIndexOf('T','',2);
//    rangHT_D:= ListIdentifiantIndexOf('D','',24);
//    rangHT_E:= ListIdentifiantIndexOf('E','',24);

//    DMPieces.Piece1.InfosVerrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,recordpiece.ID,recordpiece.Validation);
    grgrid1.row:=1;
    DMPieces.Piece1.EtatPiece:=dsinsert;
    dmpieces.Piece1.Trame.TrameACharger:=false;
end;

procedure TsaisieP_3.EnregitrerTrame1Click(Sender: TObject);
begin
//Enregistrer la trame en demandant avant si on conserve les montants
    try
       GrGrid1Exit(grgrid1);
//       if (GrGrid1.LigneVide(1))then
//         begin
//           showmessage('La pièce est vide, vous devez la complèter.');
//           abort;
//         end;
// afficher la fenêtre pour saisir le code trame et le libelle trame
//ainsi que pour mentionner si on garde les montants
      if not CreationTrameAffiche(dmpieces.piece1.Libelle) then
        abort;
       EnregistrementTrame;
       if Application.MessageBox(Pchar('Voulez-vous enregistrer cette pièce !'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
         begin
           BtnEnregistrerClick(self);
         end
       else
         Begin
           EtatInitial(0,false);
         End;
    except
    GrGrid1StateChange(grgrid1.EtatGrille);
    abort;
    end;
end;

procedure TsaisieP_3.EnregistrementTrame;
Begin
  //créer les IDTrame et IDTrame_Ligne
  //récupérer les infos déjà connue
  try
    TableGereStartTransaction(dmtrame.TaTrame_Obj);
    //faire des vérif avant enregistrement de la trame
    //
    if DMTrame.VerifExistenceTrame(['Code'],[DMTrame.Trame1.CodeTrame])then
      begin
        If DMTrame.TaTrame_Obj.Locate('Code',DMTrame.Trame1.CodeTrame,[]) then
          begin
            TableGereDelete(DMTrame.TaTrame_Obj);
          end;
      end;
    dmtrame.Trame1.IDTrame:=dmtrame.Trame1.NewID(dmtrame.TaTrame_Obj,'ID');
    DMTrame.EnvoieTrame_TrameLigne_SurListe(dmecritures.Ecriture_Isa1.ListIdentifiant,dmecritures.Ecriture_Isa1);
    TableGereCommit(dmtrame.TaTrame_Obj);
    TableGereCommit(DMBalance.TaBalance);
  except
    TableGereRollBack(dmtrame.TaTrame_Obj);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;//fin du try except
End;

function TsaisieP_3.RecupCelluleValide(Ligne,Cellule:integer):integer;
var
colonnevalide,vide:boolean;
NouvelleColonne:integer;
resultat:integer;
begin
result:=-1;
colonnevalide:=false;
NouvelleColonne:=Cellule;
if not grgrid1.LigneVide(ligne)then
   begin
   while not colonnevalide do
      begin
      resultat:=-1;
         case NouvelleColonne of
         1:begin // si colonne 1
           if e.TypeDossier=VerDiocese then
             begin //si type version Diocese
             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit then
               resultat:=6
             else
               resultat:=5;
             result:=resultat;
             end
             else
             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TypeLigne='T' then
               begin
                  resultat:=2;
                  result:=resultat;
               end
             else
               colonnevalide:=true;
           end;//fin si colonne
         2:begin // si colonne 2
           if e.TypeDossier=VerDiocese then
             begin //si type version Diocese
             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit then
               resultat:=6
             else
               resultat:=5;
             result:=resultat;
             end
             else
               colonnevalide:=true;
           end;//fin si colonne 2
         3:begin // si colonne 3
           if e.TypeDossier=VerDiocese then
             begin //si type version Diocese
             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit then
               resultat:=6
             else
               resultat:=5;
             result:=resultat;
             end
             else
             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.ChampQt1.readOnly then
               begin
                   if grGrid1.col<=Cellule then
                     resultat:=4
                   else
                     resultat:=2;
               result:=resultat;
               end
             else
               colonnevalide:=true;
           end;//fin si colonne 3
         4:begin  //si colonne 4
//           if e.TypeDossier=VerDiocese then
//             begin //si type version Diocese
//             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit then
//               resultat:=6
//             else
//               resultat:=5;
//             result:=resultat;
//             end
//             else
             if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.ChampQt2.readOnly then
               begin
                 if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit then
                    begin
                      if grGrid1.col<=Cellule then
                        resultat:=6
                      else
                        resultat:=3;
                    end
                 else
                    Begin
                      if grGrid1.col<=Cellule then
                        resultat:=5
                        else
                        resultat:=2;
                    End;
               result:=resultat;
               end
             else
               colonnevalide:=true;
           end;//fin si colonne 4
         5:begin //si colonne 5
//             if e.TypeDossier=VerDiocese then
//               begin //si type version Diocese
//                 if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit then
//                    begin //si credit par défaut
//                      if grGrid1.col<=Cellule then
//                        resultat:=6
//                      else
//                        resultat:=4;
//                    result:=resultat;
//                    end
//                 else
//                    colonnevalide:=true;
//               end//fin si type version Diocese
//             else
//               Begin //si type version autre
//                 if ((((vide)and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit)))or(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.credit<>0)or((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TypeLigne='T')and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit)))then
                if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TypeLigne='T')
                and(copy(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TVA.CodeTva,1,1)='V'))then
                  begin
                  resultat:=2;
                  result:=resultat;
                  end;
                if resultat=-1 then
                   begin
                      vide:=((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.Debit=0)and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.credit=0));
                      if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.credit<>0)or
                          ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TypeLigne='T')
                          and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit)
                          and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.Debit=0)))then
                         begin //si credit par défaut
                           if grGrid1.col<=Cellule then
                               resultat:=6
                           else
                               resultat:=4;
                             //colonnevalide:=true;
                         result:=resultat;
                         end//fin si credit par défaut
                      else
                        if (Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit)
                          and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.Debit=0) then
                             begin
                                  if (grGrid1.col<Cellule) then  resultat:= 6
                                  else
                                    begin
                                      resultat:=5;
                                      colonnevalide:=true;
                                    end;
                                  result:=resultat;
                             end
                             else
                                Begin
                                  colonnevalide:=true;


                                End;
                   end;
//               End;//fin si type version autre
           end;//fin si colonne 5
         6:begin //si colonne 5
             if e.TypeDossier=VerDiocese then
               begin //si type version Diocese
                 if not Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit then
                    begin //si Debit par défaut
                      resultat:=5;
                      result:=resultat;
                    end
                 else
                    colonnevalide:=true;
               end//fin si type version Diocese
             else
               Begin //si type version autre
  //              if ((((vide)and(not Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit)))or(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.Debit<>0)or((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TypeLigne='T')and(not Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit)))then
                if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TypeLigne='T')and(copy(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TVA.CodeTva,1,1)='V'))then
                  begin
                  resultat:=2;
                  result:=resultat;
                  end;
                if resultat=-1 then
                   begin
                      vide:=((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.Debit=0)and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.credit=0));
                      if ((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.Debit<>0)or((Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.TypeLigne='T')and(not Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.SensCredit)and(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ligne])^.Ligne.credit=0)))then
                          begin //si Debit par défaut
                                resultat:=5;
                                result:=resultat;
                          end//fin si Debit par défaut
                       else
                          colonnevalide:=true;
                   end;
               End;//fin si type version autre
           end;//fin si colonne 5

         else//si autre nouvelle colonne
            colonnevalide:=true;
         end;//fin du case
      if result<>-1 then
        NouvelleColonne:=result;
      end;//fin du while
   end;//fin si ligne pas vide
end;


function TsaisieP_3.RecupererParametresLignes(Rang:integer):integer;
var
ligneTmp:TParamLigne_obj;
compte:string;
begin
  try //except
     if not empty(GrGrid1.Cells[1,Rang]) then
     begin //si compte rempli
        case ord(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Rang])^.Ligne.TypeLigne) of
  {H}   72,104:Begin
//               compte:=grgrid1.cells[1,Rang];
               compte:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Rang])^.Ligne.compte;
               RecupParamLigne(Rang,'H',compte,true,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Rang])^.Ligne.tiers);
               End;
  {T}   84,116:Begin
//               compte:=grgrid1.cells[1,Rang];
               compte:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Rang])^.Ligne.compte;
               ligneTmp:=RecupParamLigne(Rang,'T',compte,false,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Rang])^.Ligne.tiers);
                  with Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Rang])^ do
                  begin
                  Ligne.ChampQt1.readOnly:=true;
                  Ligne.ChampQt2.readOnly:=true;
                  Ligne.TVA.Retour:=ligneTmp.TVA.Retour;
                  Ligne.TVA.TauxMin:=ligneTmp.TVA.TauxMin;
                  Ligne.TVA.TauxMax:=ligneTmp.TVA.TauxMax;
                   if CelluleSelect=-1 then
                      begin //s'il n'y a pas de cellule sélectionnée
                       if ((((empty(grgrid1.Cells[5,Rang]))or(grgrid1.Cells[5,Rang]='0')))and (((empty(grgrid1.Cells[6,Rang]))or(grgrid1.Cells[6,Rang]='0')))) then
                          begin //si les 2 champs (Débit, Crédit) sont vides
                             if Ligne.TVA.sensCredit then
                             result:=6
                             else
                             result:=5;
                          end //fin si les 2 champs (Débit, Crédit) sont vides
                          else
                          Begin
                            if ((empty(grgrid1.Cells[6,Rang]))or(grgrid1.Cells[6,Rang]='0'))then
                            result:=5;
                            if ((empty(grgrid1.Cells[5,Rang]))or(grgrid1.Cells[5,Rang]='0'))then
                            result:=6;
                          End;
                      end;//fin s'il n'y a pas de cellule sélectionnée
                  end;//fin du with Pidentifiant(ListIdentifiant.items[NewRow])^
            //   grgrid1.col:=newcol;
               End;
  {X}   88,122:Begin
                //aide compte doit être filtré pour accepter les comptes de tiers
//                compte:=grgrid1.cells[1,Rang];
                compte:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Rang])^.Ligne.compte;
                RecupParamLigne(Rang,'X',compte,true,Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Rang])^.Ligne.tiers);
              End;
        end;//fin du case typeligne
     end;//fin si compte rempli
  except
    abort;
  end;//fin du try except
end;

procedure TsaisieP_3.EdDateEcheanceAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
var
//ModifiableTmp:boolean;
verrouillage:TVerrouillage;
begin
//ModifiableTmp:=false;
if datetostr(ADate)<>DateEcheancetmp then
   begin //si la date est modifiée
   if ((not DMPieces.Piece1.PieceModifiable)and(not DMPieces.Piece1.SuppressionParticulieres)) then
      Begin
        action:=false; //si piece non modifiable
        showmessage('Cette pièce n''est pas modifiable ');
      End
   else
     begin
        DMPieces.Piece1.InitialiseInfosVerrouillage(Verrouillage);
        verrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,0);
        if ((verrouillage.PieceVerrouillee)and(DMPieces.Piece1.IDJournal in [1,2,3,4])) then
            Begin//si pièce verrouillee
              if not verrouillage.Deverrouillable then
                begin//si non déverrouillable
                  Application.MessageBox(Pchar('Attention, cette pièce est verrouillée et non déverrouillable, Vous ne pouvez pas la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_OK);
                  action:=false;
                end//fin si non déverrouillable
              else
                Begin//si deverrouillable
                   TraitementPourGerer_ModifPiece_et_TVA(4,action,'Attention, cette pièce est verrouillée, si vous la modifiez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! Voulez-vous la modifier ?',Adate,(Sender <>nil) );
                End;//fin si deverrouillable
            //ModifiableTmp:=action;
            End//fin si pièce verrouillee
        else
            if ((DateEcheancetmp<>datetostr(ADate))and((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false)))then
               begin //si piece modifiable et modifiée
                   if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                      begin
                        if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                           action:=false;
                      end;
//                   else
//                      ModifiableTmp:=true;
//                 if ModifiableTmp then //si on veut quand même la modifier
//                    begin
               end;//fin si piece modifiable et modifiée
     end;
      if action then
        begin
         DMPieces.Piece1.Modifier_EnAttente:=true;
         DMPieces.Piece1.DateEcheance:=ADate;
         DateEcheancetmp:=datetostr(ADate);
        end
      else
       begin
          EdDateEcheance.Text:=DateEcheancetmp;
          ADate:=StrToDate_Lgr(DateEcheancetmp);
       end;
   end;//fin si date modifiée
end;


procedure TsaisieP_3.CalculSolde;
var
SoldePieceEnCours:currency;
Begin
     GrGrid2.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', SommeColonne(GrGrid1,5,1,GrGrid1.RowCount-1));
     GrGrid2.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', SommeColonne(GrGrid1,6,1,GrGrid1.RowCount-1));
     SoldePieceEnCours:=SommeColonne(GrGrid1,6,1,GrGrid1.RowCount-1) - SommeColonne(GrGrid1,5,1,GrGrid1.RowCount-1);

     GrGrid3.Cells[1,0]:='';
     GrGrid3.Cells[0,0]:='';
     if SoldePieceEnCours > 0 then
      GrGrid3.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', abs(SoldePieceEnCours))
      else
      GrGrid3.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', abs(SoldePieceEnCours));

     GrGrid3.ColWidths[0]:=GrGrid1.ColWidths[5];
     GrGrid3.ColWidths[1]:=GrGrid1.ColWidths[6];
     GrGrid3.Font.Size:=12;
     GrGrid3.Font.Style :=[fsBold];
End;

procedure TsaisieP_3.GrEnTeteChange(Sender: TObject);
var
SupprOD,GererTva:boolean;
conteneurVerrou:TVerrouillage;
ModifiableTmp:boolean;
begin
if not (grentete.col=0)then
  begin
     try//finally
       try//except
        ModifiableTmp:=false;
        GererTva:=false;
        SupprOD:=false;


        if ((DMPieces.Piece1.IDJournal in [1,2,3,4])and(((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)))then
        Begin //si piece de vente ou d'achat
          if ((((DMPieces.Piece1.InfosVerrouillage.PieceVerrouillee)))or(((DMPieces.Piece1.InfosPointage.infosPointage.TvaSurE)and(DMPieces.Piece1.InfosVerrouillage.PeriodeVerrouillee)))) then
                  Begin
                     GererTva:=true;
                     case grentete.col of
                       2,4:SupprOD:=DMPieces.Piece1.InfosVerrouillage.Deverrouillable;
                       //3:SupprOD:=((DMPieces.Piece1.InfosVerrouillage.Deverrouillable)and(DMPieces.Piece1.InfosVerrouillage.PeriodeDeverrouillable));
                       3:SupprOD:=false;
                     end;//fin du case "grentete.col"
                  End;
                    if GererTva then
                       Begin //si on doit gerer la tva
                         if not SupprOD then
                           Begin //si on ne peut pas modifier l'entête
                               Application.MessageBox(Pchar('Attention, cette pièce est verrouillée et non déverrouillable, Vous ne pouvez pas la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_OK);
                               begin
                               abort;
                               end;
                           End//fin  si on ne peut pas modifier l'entête
                         else
                           Begin //si on peut modifier l'entête, on deverrouille la période déclarée
                             if Application.MessageBox(Pchar('Attention, cette pièce est verrouillée, si vous la modifiez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! Voulez-vous la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                                begin
                                //************on doit supprimer la dernière déclaration et déverrouiller la période
                                 if not (DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false)).retour then
                                   abort;
                                 conteneurVerrou:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,DMPieces.Piece1.DateSaisie);
                                 DMPieces.Piece1.InfosVerrouillage:=conteneurVerrou;
                                end
                                else
                                 begin
                                   abort;
                                 end;
                           End; //fin si on peut modifier l'entête, on deverrouille la période déclarée
                       End;//fin si on doit gerer la tva
        End; //fin si piece de vente ou d'achat et piece existante
//       if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
       if (not Gestionimmos.supprimerImmos)and (not Gestionimmos.supprimerCessions) and (DMPieces.Piece1.EtatPiece=dsEdit) then
        begin
          if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,-1).retour= false then abort;
        end;
         if (((DMPieces.Piece1.Modifier_Confirmer=false)and(DMPieces.Piece1.Modifier_EnAttente=false))and (DMPieces.Piece1.EtatPiece=dsEdit)) then
           begin
               if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
                  begin
                    if Application.MessageBox(Pchar(SuppressionDesPointages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                       ModifiableTmp:=true;
                  end
               else
                  ModifiableTmp:=true;
             if ModifiableTmp then //si on veut quand même la modifier
                DMPieces.Piece1.Modifier_EnAttente:=true
             else
                abort;
           end;
           if GrEnTete.col=2 then GestionDuPlusSurEntete(GrEnTete.Cells[2,1],dmpieces.Piece1.Journal);
         except
            case GrEnTete.col of
            0:GrEnTete.Cells[0,1]:=journaltmp;
            1:GrEnTete.Cells[1,1]:=DMPieces.Piece1.reference;
            2:GrEnTete.Cells[2,1]:=DMPieces.Piece1.compte;
            3:GrEnTete.Cells[3,1]:=datetostr(DMPieces.Piece1.DateSaisie);
            4:GrEnTete.Cells[4,1]:=DMPieces.Piece1.Libelle;
            end;//fin du case
            GestionDuPlusSurEntete(DMPieces.Piece1.Compte,dmpieces.Piece1.Journal);
         abort;
        end;//fin du try except
     finally
        //
     end;//fin du try finally
  end;//fin si pas colonne journal
end;
procedure TsaisieP_3.GrEnTeteStateChange(EtatGrille: TDataSetState);
begin
ChangementEtatBoutonsMenu;
case EtatGrille of
dsbrowse:Panel2.Caption:='En tête pièce - Consultation';
dsinsert:Panel2.Caption:='En tête pièce - Insertion';
dsEdit:Panel2.Caption:='En tête pièce - Modification';
end;//fin du case
end;


function TsaisieP_3.VerificationTvaAvantEnregistrement(Gauge:Tgauge):boolean;
var
Act,Validation:boolean;
//keyTmp:word;
ligne,i,LigneTmp:integer;
begin
try
Act:=true;
result:=true;
Validation:=true;
LigneTmp:=ligneCurr;
try//finally
EdDateLivraisonexit(nil);
EdDateEcheanceexit(nil);
try//except
  GrGrid1RowValidate(self,validation,Act,grgrid1.col);
  grentetecolexit(grentete.col,1);
except
  grentete.setfocus;
  abort;
end;
try
GestionGauge(100,gauge,1000,0,'',e.TypeClient=cl_isa);
for i:=1 to grgrid1.RowCount-1 do
begin
  ligneCurr:=i;
  GrGrid1RowValidate(self,validation,Act,grgrid1.col);
end;
except
  GrGrid1.setfocus;
  abort;
end;
finally
 ligneCurr:=LigneTmp;
end;
if result then
  begin
    GestionGauge(100,gauge,-1,-1,'Contrôle TVA',e.TypeClient=cl_isa);
    DMEcritures.Ecriture_Isa1.ModificationSuppressionLigneTva('T',modif,GrGrid1);

    CalculSolde;
     if ((modif.ASupprimer)and (modif.NewRow<>-1)) then
     //si on doit supprimer la ligne tva et que
     // NewRow(Ligne à supprimer) est rempli, Suppression de la ligne TVA
     begin
     modif.ASupprimer:=false;
     grgrid1.SupprimeLigne(Modif.NewRow);
     Modif.NewRow:=-1;
     end;

if DMPieces.Piece1.IDJournal in [1,2]then
   begin //si journal 1 ou 2
      /////////créer les lignes tva manquantes s'il y a lieu
      creation.acreer:=true;
      while creation.acreer do
      begin
      creation:=DMPieces.RecherchePossibiliteCreationLigne(ParametreCompteEcriture,-1);
      if ((not creation.Existe)and (creation.Acreer))then
         begin //s'il y a une ligne tva à créer qui n'existe pas déjà, on déclenche la
           GestionGauge(100,gauge1,-1,-1,'Correction TVA',e.TypeClient=cl_isa);
           creation.TypeLigne:='T';
//           //rechercher 1ere ligne de Tva
//           if not DMEcritures.Ecriture_Isa1.RecherchePremiereLigneTva(ligne) then {isa le 25/09/2007}
              ligne:=grgrid1.rowcount;  {isa le 25/09/2007}
           if Application.MessageBox(Pchar('Attention, Le compte '+creation.CompteConcerne+' attend de la TVA, voulez-vous garder les paramètres Tva et créer la ligne de TVA '),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
             begin
             creation.NumLigne:=ligne;
//             GrGrid1.GenereLigne(true,ligne,5);//génération d'une ligne
             GrGrid1.GenereLigne(false,ligne,-1);//génération d'une ligne   {isa le 25/09/2007}
             GrGrid1RowEnter(grgrid1,ligne);
             grgrid1.SetFocus;
             abort;
             end
           else
             Begin
               Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[creation.NumLigneConcernee])^.ligne.Complement.CodeTvaCompl:='';
               Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[creation.NumLigneConcernee])^.ligne.Complement.TvaType:='';
               Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[creation.NumLigneConcernee])^.ligne.Complement.TvaTaux:=0;
               Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[creation.NumLigneConcernee])^.ligne.Complement.TvaDate:='';
               Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[creation.NumLigneConcernee])^.ligne.Complement.MontantTva:=0;
               Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[creation.NumLigneConcernee])^.ligne.Complement.rempli:=true;
             End;
         end; //fin s'il y a une ligne tva à créer qui n'existe pas déjà
     end;//fin du while creation acréer
   end;//fin si journal 1 ou 2
end
else
  abort;
except
  result:=false;
  GrGrid1.setfocus;
end;
end;

procedure TsaisieP_3.PaBasResize(Sender: TObject);
begin
PaInfoCorpsPiece.Width:=PaBas.Width div 2;
end;

Procedure TsaisieP_3.GestionInfoCorps(Cpt:string);
Begin
//if Type_version_execution=ct_developpement then
//if e.TypeClient=cl_isa then
begin
  TiInfosCorps.Enabled:=true;
end;
End;

Procedure TsaisieP_3.GestionInfoEntete(Cpt:string);
Begin
//if e.TypeClient=cl_isa then
begin
 TiInfosEntete.Enabled:=true;
end;
End;

procedure TsaisieP_3.GrGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
//PlusDefautEntete:=false;
//PlusAutomatiqueEntete:=false;
if DMPieces.Piece1.IDJournal=4 then
case ACol of
   1:begin
      if PlusDefautCorps then
      if PlusAutomatiqueCorps then
         if length(GrGrid1.InplaceEditor.Text) > 0 then
          begin
            if copy(GrGrid1.InplaceEditor.text,1,1)<>'+' then
             begin
              GrGrid1.InplaceEditor.text:='+'+GrGrid1.InplaceEditor.text;
              GrGrid1.InplaceEditor.SelStart:=length(GrGrid1.InplaceEditor.Text);
             end;
          end
          else
          Begin
              GrGrid1.InplaceEditor.text:='+'+GrGrid1.InplaceEditor.text;
              GrGrid1.InplaceEditor.SelStart:=length(GrGrid1.InplaceEditor.Text);
          End;
     end;
end;
end;

procedure TsaisieP_3.EnregistrementReglement(fenetreAppelante:TComponent;var ListePointage:Tstringlist);
var
rang:integer;
PieceReglement:TPiece;
EcritureReglement:TEcriture_Isa;
QueryTmp:TQuery;
tab:variant;
IDPointage:integer;
TotalDebit,TotalCredit:currency;
begin
try//finally
QueryTmp:=TQuery.create(fenetreAppelante);
QueryTmp.DataBaseName:=DM_C_NomAliasDossier;
QueryTmp.Name:='EnregistrementReglement';
//QueryTmp.DataBaseName:=DMPointage2.TaPointage.DatabaseName;
totaldebit:=0;
totalcredit:=0;
  GestionGauge(100,gauge1,-1,-1,'Enregistrement du réglement',e.TypeClient=cl_isa);

   for rang:=1 to SaisieReglements.ListeReglement.Count-1 do
   Begin// début boucle sur la liste des réglements éventuels
     if not(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).vide then
       begin//si la ligne de réglement n'est pas vide
       PieceReglement:=TPiece.Create(fenetreAppelante);
       PieceReglement.NouvellePiece(false);
       EcritureReglement:=TEcriture_Isa.Create(fenetreAppelante);
       EcritureReglement.Piece:=PieceReglement;
         if (SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ID_Org<>-1 then
         Begin//si le réglement existe déjà ,on ne crée pas la pièce de réglement
         //si l'imputation a été modifiée, on supprime le pointage et on le recré
           if (SaisieReglements.ListeReglement.Objects[rang]as TReglementList).PieceModifiee then
           Begin//si la pièce a été modifiée
//            DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr((listeReglements.Objects[rang]as TReglementList).IDContrepartie),
//            not DMPieces.Piece1.SensPourReglement,false,true,DMPieces.Piece1.IDContrepartie);
            DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).IDContrepartie),
            not DMPieces.Piece1.SensPourReglement,true,true,DMPieces.Piece1.IDContrepartie);
            IF QueryTmp.Recordcount<>0 then
            DMPointage2.SupprimePointageSurEcriture(QueryTmp,SaisieReglements.ListeReglement,rang);
            if (SaisieReglements.ListeReglement.Objects[rang]as TReglementList).imputation<>0then
               begin//s'il y a une imputation
               Tab:=VarArrayCreate([0,4],varVariant);
               //récupérer tous les paramétres nécessaire pour créer le pointage
               //et recréer le reste de chaque idEcriture du pointage
                 if DMPieces.Piece1.SensPourReglement then
                   begin //si la pièce appelante est au crédit
                   tab[0]:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).IDContrepartie;
                   tab[1]:=DMPieces.Piece1.IDContrepartie;
                   tab[2]:=DMPieces.Piece1.DateSaisie;;
                   tab[4]:=StrToDate_Lgr((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).TvaDate)
                   end //fin si la pièce appelante est au crédit
                 else
                   Begin //si la pièce appelante est au débit
                   tab[0]:=DMPieces.Piece1.IDContrepartie;
                   tab[1]:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).IDContrepartie;
                   tab[2]:=StrToDate_Lgr((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Date);
                   tab[4]:=DMPieces.Piece1.DateSaisie;
                   End;//fin si la pièce appelante est au débit
               tab[3]:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).imputation;
               if not empty(DMPieces.Piece1.tiers)then
               IDPointage:=CreationPointageSurIDEcriture(tab,DMPieces.Piece1.Tiers,true).Id_Piece
               else
               IDPointage:=CreationPointageSurIDEcriture(tab,DMPieces.Piece1.compteplan,true).Id_Piece;
               if IDPointage<>-1 then
                  ListePointages.Add(inttostr(IDPointage));
               Tab:=Unassigned;
               end;//fin s'il y a une imputation
           End;//fin si la pièce a été modifiée
         End//fin si le réglement existe déjà
         else
         Begin //si le réglement n'existe pas, on doit créer la pièce de réglement
         //et ses écritures, puis créer le pointages et le reste de chaque ligne d'écriture créées
         //1)Récupérer tous les paramètres pièce et écriture de chaque réglement, puis
         //créer les lignes d'écriture dans table temporaire
         (PieceReglement as Tpiece).CodeExo:=DMPieces.Piece1.CodeExo;
         (PieceReglement as Tpiece).DateDebutExo:=DMPieces.Piece1.DateDebutExo;
         (PieceReglement as Tpiece).DateFinExo:=DMPieces.Piece1.DateFinExo;
         (PieceReglement as Tpiece).FirstIDPiece:=(PieceReglement as Tpiece).NewIDPiece(DMPieces.TaPiece,'ID',true);
         (PieceReglement as Tpiece).Reference:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Reference;
         (PieceReglement as Tpiece).Libelle:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Libelle;
         if not empty((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Date)then
         (PieceReglement as Tpiece).DateSaisie:=StrToDate_Lgr((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Date)
         else
         (PieceReglement as Tpiece).DateSaisie:=DMPieces.Piece1.DateSaisie;
         (PieceReglement as Tpiece).DateLivraison:=(PieceReglement as Tpiece).DateSaisie;
         (PieceReglement as Tpiece).DateEcheance:=(PieceReglement as Tpiece).DateSaisie;
         (PieceReglement as Tpiece).IDJournal:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).IDJournal;
         (PieceReglement as Tpiece).Journal:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Journal;
         (PieceReglement as Tpiece).Sens:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Sens;
         (PieceReglement as Tpiece).Montant:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).montant;
           (PieceReglement as Tpiece).Compte:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ContrePartieCompte;
         (PieceReglement as Tpiece).ContrePartieTiers:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ContrePartieTiers;
           (PieceReglement as Tpiece).ComptePlan:=DMPieces.Piece1.ComptePlan;
         (PieceReglement as Tpiece).Tiers:=DMPieces.Piece1.Tiers;
         (PieceReglement as Tpiece).IDContrepartie:=EcritureReglement.NewIDEcriture(DMEcritures.TaEcriture,'ID');
         if (PieceReglement as Tpiece).Sens then
            begin
            TotalDebit:=0;
            TotalCredit:=(PieceReglement as Tpiece).Montant;
            end
         else
            Begin
            TotalDebit:=(PieceReglement as Tpiece).Montant;
            TotalCredit:=0;
            End;
         (EcritureReglement as TEcriture_Isa).FirstIDEcriture:=(PieceReglement as Tpiece).IDContrepartie+1;
         (EcritureReglement as TEcriture_Isa).CompteEcriture:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ContrePartieCompte;
         (EcritureReglement as TEcriture_Isa).TiersEcriture:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ContrePartieTiers;
         //2)déclencher la création réelle de la pièce et ses écritures + MAJ Balance
         DMPieces.EnvoiePieceEcriture_SurListe(nil,EcritureReglement,TotalDebit,TotalCredit,true,dsinsert,false);
         //3)Déclencher la création du pointage et le reste de chaque ligne d'écriture
         if (SaisieReglements.ListeReglement.Objects[rang]as TReglementList).imputation<>0then
            begin //s'il y a une imputation
            Tab:=VarArrayCreate([0,4],varVariant);
            //récupérer tous les paramétres nécessaire pour créer le pointage
            //et recréer le reste de chaque idEcriture du pointage
              if (PieceReglement as Tpiece).Sens then
                begin //si la pièce appelante est au crédit
                tab[0]:=(PieceReglement as Tpiece).IDContrepartie;
                tab[1]:=DMPieces.Piece1.IDContrepartie;
                tab[2]:=DMPieces.Piece1.DateSaisie;
                tab[4]:=(PieceReglement as Tpiece).DateSaisie;
                end //fin si la pièce appelante est au crédit
              else
                Begin //si la pièce appelante est au débit
                tab[0]:=DMPieces.Piece1.IDContrepartie;
                tab[1]:=(PieceReglement as Tpiece).IDContrepartie;
                tab[2]:=(PieceReglement as Tpiece).DateSaisie;
                tab[4]:=DMPieces.Piece1.DateSaisie;
                End;//fin si la pièce appelante est au débit
            tab[3]:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Imputation;

            if not empty((PieceReglement as Tpiece).Tiers) then
            IDPointage:=CreationPointageSurIDEcriture(tab,(PieceReglement as Tpiece).Tiers,true).Id_Piece
            else
            IDPointage:=CreationPointageSurIDEcriture(tab,(PieceReglement as Tpiece).Compteplan,true).Id_Piece;
            if IDPointage<>-1 then
            ListePointage.Add(inttostr(IDPointage));
            Tab:=Unassigned;
            end;//fin s'il y a une imputation
         End;
       if PieceReglement.trame<>nil then
         PieceReglement.trame.Destroy;
       PieceReglement.Destroy;
       EcritureReglement.Destroy;
       end;//fin si la ligne de réglement n'est pas vide
   End;// fin boucle sur la liste des réglements éventuels
finally
  LibereObjet(TObject(QueryTmp),Self);
  for rang:=0 to SaisieReglements.ListeReglement.Count-1 do
    begin
    if SaisieReglements.ListeReglement.Objects[rang]<>nil then
       begin
         SaisieReglements.ListeReglement.Objects[rang].Free;
         SaisieReglements.ListeReglement.Objects[rang]:=nil;
       end;
    end;
    SaisieReglements.ListeReglement.clear;
  //
end;//fin du try finally
end;






procedure TsaisieP_3.Piecespointables2Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
  try//finally
    with DMPieces.Piece1 do
      begin// début du with DMPieces.Piece1
          if ((ActiveControl = Grentete)and(dmplan.CptEstPointable(DMPieces.Piece1.Compte))) then
           begin//si compte pointable
             Initialise_TParamAffichPointage(ParamAffichPointage);
             ParamAffichPointage.CptTiers:=DMPieces.Piece1.Compte;
             ParamAffichPointage.ALettrer:=false;
             ParamAffichPointage.DateDeb:=0;
             ParamAffichPointage.DateFin:=E.DatExoFin;
             GestionAffichagePointageSurCompte(ParamAffichPointage,not e.ExerciceCloture);
           end;//fin si cpt pointable
      end;//fin du with DMPieces.Piece1
  finally
  //
  end;//fin du try finally
end;

procedure TsaisieP_3.PiecesPointables1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
  try//finally
    with DMPieces.Piece1 do
      begin// début du with DMPieces.Piece1
          if ((ActiveControl = GrGrid1)and(dmplan.CptEstPointable(GrGrid1.cells[1,lignecurr]))) then
           begin
             Initialise_TParamAffichPointage(ParamAffichPointage);
             ParamAffichPointage.CptTiers:=GrGrid1.cells[1,lignecurr];
             ParamAffichPointage.ID_Ecriture_Appelant:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[grgrid1.Row])^.ID_ord;
             ParamAffichPointage.ID_Reste_Appelant:=-1;
             DetailPointageAffich(ParamAffichPointage.CptTiers,IntTOStr(ParamAffichPointage.ID_Ecriture_Appelant),0,true,false);
          end;//fin si compte
      end;//fin du with DMPieces.Piece1
  finally
  //
  end;//fin du try finally
end;


procedure TsaisieP_3.GestionDuPlusSurEntete(cpt,journal:string);
begin
if ((copy(journal,1,1)='A') or (copy(journal,1,1)='V'))then
   begin
    if not empty(cpt)then
      begin //si cpt rempli
//if cpt='+'then //isa le 22/08/03 car certain code tiers importé comportent des + ou . à l'interieur
       if copy(cpt,1,1)='+'then
         Begin//si
            PlusDefautEntete:=true;
            EdPlusTiersEntete.Text:='+';
            GrEnTete.cells[2,0]:='  Tiers';
         End//fin si
       else
         Begin//si
            PlusDefautEntete:=false;
            EdPlusTiersEntete.Text:='';
            GrEnTete.cells[2,0]:='  Compte';
         End;//fin si
       PlusAutomatiqueEntete:=PlusDefautEntete;
      end //fin si cpt rempli
    else
      Begin//si cpt pas encore rempli
        if EdPlusTiersEntete.Text='+'then GrEnTete.cells[2,0]:='  Tiers'
        else GrEnTete.cells[2,0]:='  Compte';
      End;//fin si cpt pas encore rempli
   end;
if (copy(journal,1,1)='B')then
   begin
     GrEnTete.cells[2,0]:='  Banque';
   end;
if (copy(journal,1,1)='C')then
   begin
     GrEnTete.cells[2,0]:='  Caisse';
   end;
if (copy(journal,1,1)='O')then
   begin
     GrEnTete.cells[2,0]:='  Compte';
   end;
end;

procedure TsaisieP_3.GestionDuPlusSurCorps(cpt:string);
begin
  if copy(cpt,1,1)='+'then
    Begin//si
       PlusDefautCorps:=true;
       EdPlusTiersCorps.Text:='+';
       GrGrid1.cells[1,lignecurr]:='  Tiers';
    End//fin si
  else
    Begin//si
       PlusDefautCorps:=false;
       EdPlusTiersCorps.Text:='';
       GrGrid1.cells[1,lignecurr]:='  Compte';
    End;//fin si
  PlusAutomatiqueCorps:=PlusDefautCorps;
end;


function TsaisieP_3.Verif_Si_Piece_Liee_Aux_Immos(Piece:Tpiece;Ecriture:integer):TExceptLGR;
var
Messages:string;
SuppressionImmos,SuppressionCessions:TErreurSaisie;
Begin
result.retour:=True;
SuppressionImmos.retour:=true;
SuppressionCessions.retour:=true;
//if (((piece.Modifier_Confirmer=false)and(piece.Modifier_EnAttente=false))and (piece.EtatPiece=dsEdit)) then
if (not Gestionimmos.supprimerImmos)and (not Gestionimmos.supprimerCessions) and (DMPieces.Piece1.EtatPiece=dsEdit) then
 begin
  if Ecriture=-1 then
    Begin//travailler sur la pièce en cours de modification
       SuppressionImmos:=DataModuleImmos.VerifSiPieceDecriteDansLesImmos(piece.FirstIDPiece,Gestionimmos.ImmosASupprimer);
       if SuppressionImmos.retour then
         SuppressionCessions:=DataModuleImmos.VerifSiPieceDecriteDansLesCessions(Piece.FirstIDPiece,Gestionimmos.CessionsASupprimer);
       if ((not SuppressionImmos.retour)or(not (SuppressionCessions.retour))) then
         begin
         if not SuppressionImmos.retour then
           case SuppressionImmos.CodeErreur of
           0: Messages:=('Attention, une ou plusieurs écritures de cette pièce sont décrites dans la gestion des immobilisations, si vous la supprimez, la ou les immobilisations concernées seront également supprimées, Confirmez-vous votre choix !');
           1: if VerificationSiPieceDeDotation(Gestionimmos.reference) then
                Messages:=('Attention, une ou plusieurs écritures de cette pièce sont décrites dans la gestion des immobilisations, si vous la supprimez, la ou les immobilisations concernées et la pièce de dotation seront également supprimées, Confirmez-vous votre choix !')
              else
                Messages:=('Attention, une ou plusieurs écritures de cette pièce sont décrites dans la gestion des immobilisations, si vous la supprimez, la ou les immobilisations concernées seront également supprimées, Confirmez-vous votre choix !');
           end;//fin du case
       if not SuppressionCessions.retour then
         begin
           case SuppressionImmos.CodeErreur of
           0: Messages:=('Attention, une ou plusieurs éritures de cette pièce sont liées à une cession dans la gestion des immobilisations, si vous la supprimez, la ou les Cessions concernées seront également supprimées, Confirmez-vous votre choix !');
           1: if VerificationSiPieceDeDotation(Gestionimmos.reference) then
                Messages:=('Attention, une ou plusieurs écritures de cette pièce sont liées à une cession dans la gestion des immobilisations, si vous la supprimez, la ou les Cessions concernées et la pièce de dotation seront également supprimées, Confirmez-vous votre choix !')
              else
                Messages:=('Attention, une ou plusieurs écritures de cette pièce sont liées à une cession dans la gestion des immobilisations, si vous la supprimez, la ou les Cessions concernées seront également supprimées, Confirmez-vous votre choix !');
           end;//fin du case
         end;
         end;
    End//fin travailler sur la pièce en cours de modification
  else
    Begin//travailler sur l'écriture en cours de modification
         SuppressionImmos:=DataModuleImmos.VerifSiEcritureDecriteDansLesImmos(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ecriture])^.ID_Ord,DMPieces.Piece1.FirstIDPiece,Gestionimmos.ImmosASupprimer);
         if SuppressionImmos.retour then
         SuppressionCessions:=DataModuleImmos.VerifSiEcritureDecriteDansLesCessions(Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[Ecriture])^.ID_Ord,DMPieces.Piece1.FirstIDPiece,Gestionimmos.CessionsASupprimer);
         if ((((not SuppressionImmos.retour)and(not Gestionimmos.supprimerImmos)))or(((not SuppressionCessions.retour)and(not Gestionimmos.supprimerCessions)))) then
           begin
            if ((not SuppressionImmos.retour)and(not Gestionimmos.supprimerImmos)) then
             begin//si SuppressionImmos
               case SuppressionImmos.CodeErreur of
               0: Messages:=('Attention, cette écriture est décrite dans la gestion des immobilisations, si vous la supprimez, la ou les immobilisations concernées seront également supprimées, Confirmez-vous votre choix !');
               1: if VerificationSiPieceDeDotation(Gestionimmos.reference) then
                    Messages:=('Attention, cette écriture est décrite dans la gestion des immobilisations, si vous la supprimez, la ou les immobilisations concernées et la pièce de dotation seront également supprimées, Confirmez-vous votre choix !')
                  else
                    Messages:=('Attention, cette écriture est décrite dans la gestion des immobilisations, si vous la supprimez, la ou les immobilisations concernées seront également supprimées, Confirmez-vous votre choix !');
               end;//fin du case
             end;//fin si SuppressionImmos
            if ((not SuppressionCessions.retour)and(not Gestionimmos.supprimerCessions)) then
             begin //si SuppressionCessions
               case SuppressionImmos.CodeErreur of
               0: Messages:=('Attention, cette écriture est liée à une cession dans la gestion des immobilisations, si vous la supprimez, la ou les cessions concernées seront également supprimées, Confirmez-vous votre choix !');
               1: if VerificationSiPieceDeDotation(Gestionimmos.reference) then
                    Messages:=('Attention, cette écriture est liée à une cession dans la gestion des immobilisations, si vous la supprimez, la ou les cessions concernées et la pièce de dotation seront également supprimées, Confirmez-vous votre choix !')
                  else
                    Messages:=('Attention, cette écriture est liée à une cession dans la gestion des immobilisations, si vous la supprimez, la ou les cessions concernées seront également supprimées, Confirmez-vous votre choix !');
               end;//fin du case
             end;//fin si SuppressionCessions
           End;
    end;//fin travailler sur l'écriture en cours de modification
   if ((not SuppressionImmos.retour)or(not (SuppressionCessions.retour))) then
    begin
     if Application.MessageBox(Pchar(Messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
       begin//si confirmation de la suppression
          if not (SuppressionImmos.retour) then//s'il s'agit d'une immos à supprimer
            Gestionimmos.supprimerImmos:=true
          else //s'il s'agit d'une cession à supprimer
            Gestionimmos.supprimerCessions:=true;
       end//fin si confirmation de la suppression
     else
       begin
         result.retour:=false;
         Gestionimmos.supprimerImmos:=false;
         Gestionimmos.supprimerCessions:=false
       end;
    end;
 End;
end;



Function AffichePieceExistante(ParamAffichPiece:TParamAffichPiece):boolean;
var
//conteneur:TPieceAnterieure;
InfosModel:TInfosModel;
Begin
try
//try
//showmessage('Disponible dans la prochaine version');
if e.ExerciceCloture then
  begin//si exo cloturé
     raise ExceptLGR.Create('Cet exercice est clôturé, vous ne pouvez pas modifier cette pièce.',0,true,mtError);
  end;//fin si exo cloturé
    result:=true;
    if saisieP_3=nil then saisieP_3:=TsaisieP_3.Create(application.mainform);

//    if  ((((DMPieces.Piece1.EtatPiece in [dsedit,dsinsert])and(DMPieces.Piece1.Modifier_Confirmer)))or(DMPieces.Piece1.EtatPiece in [dsinsert]))then
   if ((DMPieces.Piece1.EtatPiece = dsinsert)and(not empty(DMPieces.piece1.Libelle))and(not empty(DMPieces.piece1.Compte)))
   or ((DMPieces.Piece1.EtatPiece =dsedit)and ((DMPieces.Piece1.Modifier_Confirmer)or(DMPieces.Piece1.Modifier_EnAttente)))then
      begin
      if MessageDlg('Une pièce est actuellement en cours de modification, voulez-vous annuler ces modififcations ?',mtWarning,[mbYes,mbNo],0)=mrno then
        abort
      else
        Begin
           saisieP_3.EtatInitial(1,false);
           TableGereRollBack(DMPieces.Piece1.TablePiece);
           TableGereRollBack(dmbalance.TaBalance);
        end;
      end;
    DeFiltrageDataSet(dmrech.TaModelRech);
    InfosModel:=Infos_TInfosModel(dmrech.TaModelRech,'Journal',[copy(ParamAffichPiece.Reference,1,2)]);
    if InfosModel.ResultInfos=false then
      raise ExceptLGR.Create('La pièce : '+ParamAffichPiece.Reference +'n''existe pas',0,true,mtError);
    if ParamAffichPiece.AffichageModal then
       begin
       if saisieP_3.WindowState=wsMinimized then saisieP_3.WindowState:=wsNormal;
       saisieP_3.close;
       end;

    saisieP_3.TitreForm:= ParamAffichPiece.TitreForm;
    saisieP_3.SousTitreForm:= ParamAffichPiece.SousTitreForm;

    saisieP_3.EtatInitial(0,false);
    DMPieces.Piece1.EtatPiece:=dsbrowse;
    DMPieces.Piece1.Modifier_Confirmer:=false;
    DMPieces.Piece1.Modifier_EnAttente:=false;


//    conteneur.ExoAnterieure:=e.ExerciceSaisie;
//    conteneur.PieceAnterieure:=false;
//    DMPieces.piece1.AnneePiece:=conteneur;
    DMPieces.piece1.AnneePiece:=ParamAffichPiece.Anterieur;
    ReferenceTmp:='';
    //DMPieces.Piece1.NouvellePiece(false);
    DMPieces.Piece1.Reference:=ParamAffichPiece.reference;
    DMPieces.Piece1.IDJournal:=InfosModel.ID_Journal;
    DMPieces.Piece1.Journal:=InfosModel.Journal;
    DMPieces.Piece1.EtatPiece:=dsedit;            
    saisieP_3.GrEnTete.cells[0,1]:=InfosModel.Code;
    saisieP_3.GrEnTete.cells[1,1]:=ParamAffichPiece.reference;
    if not saisieP_3.CtrlSaisiePieceEnteteGrille(ParamAffichPiece.reference,1,saisieP_3.GrEnTete).retour then
      abort;
    JournalTmp:=saisieP_3.GrEnTete.cells[0,1];

    if ((ParamAffichPiece.Affiche)and(not empty(ParamAffichPiece.Reference))) then
      begin
          if ParamAffichPiece.AffichageModal then
             begin
               result:=saisieP_3.ShowModal=Mrok
             end
          else
             saisieP_3.Show;
      end;
except
  result:=false;
  abort;
end;
End;

procedure TsaisieP_3.PaSelectCptResize(Sender: TObject);
begin
RxChListCpt.Width:=PaSelectCpt.Width-8;
EdRech.Width:=PaSelectCpt.Width-8;
RxSBClose.Width:=PaSelectCpt.Width;
RxSBAnnuleSel.Width:=PaSelectCpt.Width;
RxSBSuppr.Width:=PaSelectCpt.Width;
RxSBValider.Width:=PaSelectCpt.Width div 2;
RxSBInverse.Left:=RxSBValider.Width-1;
RxSBInverse.Width:=PaSelectCpt.Width-RxSBInverse.Left;
end;

procedure TsaisieP_3.RxSBCloseClick(Sender: TObject);
begin
PaSelectCpt.Visible:=false;
RxChListCpt.clear;
end;

procedure TsaisieP_3.EdRechChange(Sender: TObject);
var
i:integer;
begin
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.Items[i].Selected:=Pos(EdRech.Text,RxChListCpt.Items[i].Caption) > 0;
   End;
end;


procedure TsaisieP_3.RxSBValiderClick(Sender: TObject);
var
ParamAffichPiece:TParamAffichPiece;
i:integer;
begin
ParamAffichPiece.TitreForm:=str_remplacesouschaine(Main.mnSaisiePiece.Caption,'&','');
ParamAffichPiece.SousTitreForm:=CMouvement;
ParamAffichPiece.AffichageModal:=false;
ParamAffichPiece.Affiche:=true;
ParamAffichPiece.Anterieur:=DMPieces.Piece1.AnneePiece;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
   DeFiltrageDataSet(dmrech.TaModelRech);
    if RxChListCpt.items[i].Selected then
      begin
        ParamAffichPiece.Reference:=RxChListCpt.items[i].caption;
        AffichePieceExistante(ParamAffichPiece);
        GrEnTeteColEnter(1,1,1);
        exit;
      end;
   End;
if CheckBox1.Checked then
 begin
  GrEnTete.SetFocus;
  PaSelectCpt.Visible:=false;
 end
 else
 begin
  GrEnTete.SetFocus;
 end;
end;

procedure TsaisieP_3.RxSBInverseClick(Sender: TObject);
var
i:integer;
begin
DMDiocEtatBal.ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    DeFiltrageDataSet(dmrech.TaModelRech);
    RxChListCpt.items[i].Selected:=not RxChListCpt.items[i].Selected;
   End;
end;

procedure TsaisieP_3.RxSBAnnuleSelClick(Sender: TObject);
var
i:integer;
begin
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.items[i].Selected:=false;
   End;
end;

procedure TsaisieP_3.RxSBSupprClick(Sender: TObject);
var
i:integer;
Modifier,Confirmation,Action:boolean;
begin
try//finally
try//except
Modifier:=false;
Action:=true;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    Confirmation:=not(Type_version_execution=CT_DEVELOPPEMENT);
    if RxChListCpt.items[i].Selected then
      begin
      if confirmation then
        Action:=Application.MessageBox(Pchar('Etes-vous sûr de vouloir supprimer la piece '+ListeReference.Strings[i]),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
      if Action then
        begin
          DMPieces.Piece1.EtatPiece:=dsEdit;
          DeFiltrageDataSet(dmrech.TaPieceRech);
          DMPieces.Piece1.FirstIDPiece:=Infos_TInfosPiece(dmrech.TaPieceRech,'reference',[RxChListCpt.items[i].Caption]).ID;
          if Verif_Si_Piece_Liee_Aux_Immos(DMPieces.Piece1,-1).retour= false then abort;
          if Gestionimmos.supprimerImmos then
            begin
            DataModuleImmos.taDetailImmo.Open;  { isa  le  18/07/05 }
      //      DataModuleImmos.TableImmos.Open;
               while Gestionimmos.ImmosASupprimer.Count<>0 do
               begin
               DeFiltrageDataSet(DMRech.TaImmosRech);
               DataModuleImmos.SuppressionImmo(DMRech.TaImmosRech,StrToInt_Lgr(Gestionimmos.ImmosASupprimer.Strings[0]),true,false);
               Gestionimmos.ImmosASupprimer.Delete(0);
               end;
                 if not DMImmo_Clo.SuppressionPieceDeDotationAmortissement(Gestionimmos.reference) then abort;
                  //DMPieces.SuppressionOD(Gestionimmos.reference);
            end;
          if Gestionimmos.supprimerCessions then
            begin
            DataModuleImmos.TableImmos.Open;
               while Gestionimmos.CessionsASupprimer.Count<>0 do
               begin
               DeFiltrageDataSet(DMRech.TaImmosRech);
               DataModuleImmos.SuppressionImmo(DMRech.TaImmosRech,StrToInt_Lgr(Gestionimmos.CessionsASupprimer.Strings[0]),false,false);
               Gestionimmos.CessionsASupprimer.Delete(0);
               end;
               if not empty(Gestionimmos.reference) then
                  DMPieces.SuppressionOD(Gestionimmos.reference);
            DataModuleImmos.TableImmos.close;
            end;

          EtatInitial(0,false);

          DMPieces.SuppressionPieceEcriture(RxChListCpt.items[i].Caption,dmpieces.Piece1);
          TableGereCommit(DMPieces.TaPiece);
          TableGereCommit(DMBalance.TaBalance);
          Modifier:=true;
        end;
      end;  
   End;
if CheckBox1.Checked then
 begin
  GrEnTete.SetFocus;
  PaSelectCpt.Visible:=false;
 end
 else
 begin
  GrEnTete.SetFocus;
 end;
except
if Modifier then
  Begin
  TableGereRollBack(DMPieces.TaPiece);
  TableGereRollBack(DMBalance.TaBalance);
  end;
end;
finally
if Modifier then
  Begin
   RxChListCpt.Clear;
  end;
end;
end;

procedure TsaisieP_3.GestionDesUnites;
begin
if empty(ParametreCompteEcriture.ParamCpt.Un1) then
    GrGrid1.cells[3,0]:=''
else
    GrGrid1.cells[3,0]:=ParametreCompteEcriture.ParamCpt.Un1;
if empty(ParametreCompteEcriture.ParamCpt.Un2) then
    GrGrid1.cells[4,0]:=''
else
    GrGrid1.cells[4,0]:=ParametreCompteEcriture.ParamCpt.Un2;
end;



procedure TsaisieP_3.BtnRecherchePieceClick(Sender: TObject);
var
ListeTmp:Tstringlist;
Requete:TQuery;
montantDebit,MontantCredit:currency;
begin
try//finally
Requete:=Tquery.Create(self);
Requete.DatabaseName:=DM_C_NomAliasDossier;
Requete.name:='BtnRecherchePieceClick';
if not PaSelectCpt.Visible then
   Begin
    if RxChListCpt.Items.Count <>0 then
       RxChListCpt.Items.clear;
         ListeTmp:=Tstringlist.Create;
         Requete.sql.Clear;
         Requete.sql.Add('select Piece.journal,Piece.Reference,Piece.Compte,Piece.Libelle,Piece."Date",'+
            ' sum(Ecriture.debitSaisie)as Montantdebit,sum(Ecriture.creditSaisie)as Montantcredit from Ecriture e join piece p on p.id=e.id_piece'+
            ' where Piece."Date" between :DateDeb and :DateFin and Ecriture.typeLigne<>''X'' ');

//         Requete.sql.Add('select Piece.journal,Piece.Reference,Piece.Compte,Piece.Libelle,Piece."Date",'+
//            ' sum(Ecriture.debitSaisie)as Montantdebit,sum(Ecriture.creditSaisie)as Montantcredit from Piece,Ecriture '+
//            ' where Piece."Date" between :DateDeb and :DateFin and Ecriture.id_piece=Piece.id ');
         if ((DMPieces.Piece1.idJournal>0)and(activecontrol=grentete)) then
            begin
            Requete.sql.Add(' and substring(reference from 1 for 2)='''+DMPieces.Piece1.Journal+'''');
            Requete.sql.Add(' and Journal='''+inttostr(DMPieces.Piece1.idJournal)+'''');
            end;
         Requete.sql.Add(' group by Piece.journal,Piece.reference,Piece.Compte,Piece.Libelle,Piece."Date"');
         Requete.sql.Add('order by journal,reference,Piece."date"');
         if DMPieces.Piece1.AnneePiece.PieceAnterieure then
           begin
             Requete.ParamByName('DateDeb').AsDate:=0;
             Requete.ParamByName('DateFin').AsDate:=e.DatExoDebut-1;
           end
         else
           begin
             Requete.ParamByName('DateDeb').AsDate:=e.DatExoDebut;
             Requete.ParamByName('DateFin').AsDate:=e.DatExoFin;
           end;

         Requete.Open;
         Initialise_TStringlist(ListeReference,saisieP_3,false);
//         ListeReference.Clear;
         RxChListCpt.Tag:=1;
         Requete.first;
         while not Requete.eof do
             Begin
             montantDebit:=(Requete.findfield('Montantdebit').AsCurrency);
             MontantCredit:=(Requete.findfield('Montantcredit').AsCurrency);
             DetermineSolde(montantDebit,MontantCredit);
              ListeTmp.Add(Requete.findfield('Reference').AsString+';'+Requete.findfield('Compte').AsString+';'+
                 Requete.findfield('Libelle').AsString+';'+Requete.findfield('Date').AsString+';'+e.FormatCurr(montantDebit)+';'+e.FormatCurr(MontantCredit)+';');
              //RxChListCpt.Items.Add(Requete.findfield('Reference').AsString+' - '+Requete.findfield('Compte').AsString+' - '+Requete.findfield('Libelle').AsString);
              ListeReference.Add(Requete.findfield('Reference').AsString);
              Requete.Next;
             End;
      ordretri:=1;

      TabStr:=[0,1,2,3];
      TabCurr:=[5,6];
      TabDate:=[4];
      InitLisViewAvecListe(RxChListCpt,['Référence','Compte','Libellé','Date','Debit','Credit'],ListeTmp,true).free;
//       Requete.free;
       //End;
   End;

PaSelectCpt.Top:=PaGrille.top+5;
PaSelectCpt.Width:=(Panel2.Width div 10)*4;
//EdRech.Visible:=true;
RxChListCpt.Width:=PaSelectCpt.Width;
PaSelectCpt.Height:=(PaGrille.Height)*10 div 12;
RxChListCpt.Height:=PaSelectCpt.Height-91;// 298;
RxSBValider.Top:=PaSelectCpt.Height-69;
EdRech.top:=RxSBValider.Top-25;
EdRech.Width:=PaSelectCpt.Width-2;
CheckBox1.Top:=RxSBValider.Top+5;
RxSBInverse.Top:=PaSelectCpt.Height-69;
RxSBAnnuleSel.Top:=PaSelectCpt.Height-47;
RxSBSuppr.Top:=PaSelectCpt.Height-22;
PaSelectCpt.Left:=16;
PaSelectCpt.Visible:=not PaSelectCpt.Visible;
if RxChListCpt.CanFocus then
begin
  RxChListCpt.SetFocus;
  if RxChListCpt.Items.Count <>0 then
  begin
    RxChListCpt.ItemFocused:=RxChListCpt.Items[RxChListCpt.Items.Count-1];
    RxChListCpt.Items[RxChListCpt.Items.Count-1].Selected:=true;
    RxChListCpt.Items[RxChListCpt.Items.Count-1].MakeVisible(true);
  end;
end;

finally
  LibereObjet(TObject(Requete),Self);
end;//fin du try finally
end;

procedure TsaisieP_3.RxChListCptClick(Sender: TObject);
begin
RxSBValider.Click;
end;

procedure TsaisieP_3.RxChListCptKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_RETURN then RxSBValider.Click;
end;

procedure TsaisieP_3.RxChListCptDblClick(Sender: TObject);
begin
RxSBValider.Click;
end;



function ModificationPieceExistante(Reference:string;fenetreAppelante:string):TExceptLGR;
var
ParamAffichPiece:TParamAffichPiece;
begin
ParamAffichPiece.TitreForm:=str_remplacesouschaine(Main.mnSaisiePiece.Caption,'&','');
ParamAffichPiece.SousTitreForm:=CMouvement;
ParamAffichPiece.AffichageModal:=true;
ParamAffichPiece.Affiche:=true;
ParamAffichPiece.Anterieur:=DMPieces.Piece1.AnneePiece;
ParamAffichPiece.Reference:=Reference;
if AffichePieceExistante(ParamAffichPiece)then
  begin
    if fenetreAppelante ='saisieP_3' then
      begin
        saisieP_3.GrEnTeteColEnter(1,1,1);
      end;
    if fenetreAppelante ='BalanceNew' then
      BalanceNew.InitTotaux(DMDiocEtatBal.ListeFiltreAffich,'Compte');
    if fenetreAppelante ='BalanceNewT' then
      BalanceNewT.InitTotaux(DMDiocEtatBalT.ListeFiltreAffich,'Tiers');
    if fenetreAppelante ='ReglementSurListe' then
      ReglementSurListe.FormActivate(ReglementSurListe);
    if fenetreAppelante ='DetailEcr' then
      DetailEcr.GrDbDetail.DataSource.DataSet.refresh;
    if fenetreAppelante ='TabVisuPiece2' then
      begin
        TabVisuPiece2.GrDBGrid1.DataSource.DataSet.refresh;
        TabVisuPiece2.GrDBVisuEcriture.DataSource.DataSet.refresh;
      end;
  end;
end;


////gérer l'affichage des quantités
//function GestionQuantites():string;
//if ((grgrid1.col=3)and(not empty(grgrid1.cells[3,lignecurr]))) then
//  Begin
//     if Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.Ligne.SensCredit then
//       begin
//         if not str_commence_par(grgrid1.cells[3,lignecurr],'-') then
//           grgrid1.cells[3,lignecurr]:='-'+grgrid1.cells[3,lignecurr];
//       end
//     else
//       Begin
//         if str_commence_par(grgrid1.cells[3,lignecurr],'-') then
//           grgrid1.cells[3,lignecurr]:=str_Suppr_N_Car_AGauche(grgrid1.cells[3,lignecurr],1);
//       end;
//  end;

procedure TsaisieP_3.Modiferligneecriture1Click(Sender: TObject);
var
ParamAffichPiece:TParamAffichPiece;
i:integer;
ParamAfficheModifEcriture:TParamAfficheModifEcriture;
Retour:TinfosDMModifEcriture;
Result:TexceptLgr;
begin
try
Initialise_ExceptLGR(result,GestMessageLGR);
//if e.TypeClient=CL_Isa then
  begin
      if ((DMPieces.Piece1.Modifier_Confirmer)or(DMPieces.Piece1.Modifier_EnAttente)) then   raise ExceptLGR.Create('La pièce est déjà en modification',result.NumErreur,true,mtError,Result);
      ParamAffichPiece.Anterieur:=dmpieces.piece1.AnneePiece;
      ParamAfficheModifEcriture.AffichageModal:=true;
      ParamAfficheModifEcriture.Affiche:=true;
      ParamAfficheModifEcriture.SousTitreForm:='Modification de l''écriture';
      ParamAfficheModifEcriture.TitreForm:='Modification des écritures';
      ParamAfficheModifEcriture.PieceEnCours:=-1;
      ParamAfficheModifEcriture.ecritureEnCours:=Pidentifiant(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[ligneCurr])^.ID_Tmp;
      retour:=ModifEcritureAffiche(ParamAfficheModifEcriture);
      if retour.retour then
        Begin
          ParamAffichPiece.TitreForm:=str_remplacesouschaine(Main.mnSaisiePiece.Caption,'&','');
          ParamAffichPiece.SousTitreForm:=CMouvement;
          ParamAffichPiece.AffichageModal:=false;
          ParamAffichPiece.Affiche:=true;
          ParamAffichPiece.Reference:=dmpieces.piece1.reference;
          AffichePieceExistante(ParamAffichPiece);
          GrEnTeteColEnter(1,1,1);
        end;
  end;
except
end;
end;

procedure TsaisieP_3.Infossupplmentaires1Click(Sender: TObject);
begin
AfficheInfoComposant('Pièce en cours',DMPieces.Piece1,true);
end;

procedure TsaisieP_3.TiRecupInfosPointagesTimer(Sender: TObject);
var
conteneur:TPointage;
QueryTmp:Tquery;
a:integer;
begin
try//finally                                                                             
  GestionGauge(100,gauge1,-1,-1,'Récupération des informations sur les pointages associés',e.TypeClient=cl_isa);
QueryTmp:=TQuery.create(self);
QueryTmp.DataBaseName:=DMPointage2.TaPointage.DatabaseName;
QueryTmp.Name:='CtrlSaisiePieceEnteteGrille';
QueryTmp.sql.Clear;
DMPieces.Piece1.InitialiseInfosPointage(conteneur);
//recupérer les infos pointages sur liste des contreparties
if DMPieces.Piece1.ListeContrePartieTiers<>nil then
  begin
    A:=0;
    while ((conteneur.infosPointage.Pointee=false) and (a<DMPieces.Piece1.ListeContrePartieTiers.count))do
      begin
         conteneur.infosPointage:=DMPointage2.FiltragePointageSurEcriture(QueryTmp,DMPieces.Piece1.ListeContrePartieTiers.Strings[a],DMPieces.Piece1.Sens,true,false,-1);
      inc(a);
      end;
  end;
 //vérifier si les pointages de la pièces ne vont pas engendrer la suppression d'une déclaration tva
  if conteneur.infosPointage.Pointee then
    if not empty(DMPieces.Piece1.tiers)then
    conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(DMPieces.Piece1.IDContrepartie,DMPieces.Piece1.Tiers)
    else
    conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(DMPieces.Piece1.IDContrepartie,DMPieces.Piece1.compte);
 DMPieces.Piece1.InfosPointage:=conteneur;
 //changé par isa le 19/08/03 ***
//                               DMPieces.Piece1.InfosVerrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,recordpiece.ID,recordpiece.Validation);
 if Type_version_execution=ct_distribution then
   DMPieces.Piece1.InfosVerrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(DMPieces.Piece1,DMPieces.Piece1.FirstIDPiece,DMPieces.Piece1.DateSaisie);
//   showmessage('fini');
finally
TiRecupInfosPointages.Enabled:=false;
libereobjet(Tobject(QueryTmp),Self);
  GestionGauge(0,gauge1,0,0,'',false);
end;//fin du finally
end;

procedure TsaisieP_3.ModifierEcriture1Click(Sender: TObject);
var
//ParamAffichPiece:TParamAffichPiece;
//i:integer;
//ParamAfficheModifEcriture:TParamAfficheModifEcriture;
//Retour:TinfosDMModifEcriture;
result:Texceptlgr;
begin
try
Initialise_ExceptLGR(result,GestMessageLGR);
if e.TypeClient=CL_Isa then
  begin
      if ((DMPieces.Piece1.Modifier_Confirmer)or(DMPieces.Piece1.Modifier_EnAttente)) then   raise ExceptLGR.Create('La pièce est déjà en modification',result.NumErreur,true,mtError,Result);
      showmessage('à implémenter');
      //ParamAfficheModifEcriture.AffichageModal:=true;
      //ParamAfficheModifEcriture.Affiche:=true;
      //ParamAfficheModifEcriture.SousTitreForm:='Modification de l''entête';
      //ParamAfficheModifEcriture.TitreForm:='Modification des écritures';
      //ParamAfficheModifEcriture.PieceEnCours:=DMPieces.Piece1.FirstIDPiece;
      //ParamAfficheModifEcriture.ecritureEnCours:=-1;
      //retour:=ModifEcritureAffiche(ParamAfficheModifEcriture);
      //if retour.retour then
      //  Begin
      //    ParamAffichPiece.TitreForm:=str_remplacesouschaine(Main.mnSaisiePiece.Caption,'&','');
      //    ParamAffichPiece.SousTitreForm:=CMouvement;
      //    ParamAffichPiece.AffichageModal:=false;
      //    ParamAffichPiece.Affiche:=true;
      //    ParamAffichPiece.Reference:=ListeReference.Strings[i];
      //    AffichePieceExistante(ParamAffichPiece);
      //    GrEnTeteColEnter(1,1,1);
      //  end;
  end;
except
end;
end;

procedure TsaisieP_3.FormDeactivate(Sender: TObject);
begin
ParamUtil.TypeMaintenanceSpeciale:='';
if ParamUtil.TypeMaintenanceSpeciale='pointage_'+IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82) then
  BtnAnnulerControle.Caption:='Contrôle désactivé'
else
  BtnAnnulerControle.Caption:='Contrôle activé';
end;

procedure TsaisieP_3.RxSBPlanCptClick(Sender: TObject);
var
PAramAffichPlan:TPAramAffichPlan;
begin
if activecontrol=GrEnTete then
  PAramAffichPlan.CompteASelectionner := DMPieces.Piece1.ComptePlan
else
  if activecontrol=GrGrid1 then
    PAramAffichPlan.CompteASelectionner := GrGrid1.Cells[1,lignecurr];
PlanCptAffiche(PAramAffichPlan);
end;

procedure TsaisieP_3.TiInfosEnteteTimer(Sender: TObject);
var
Totaux:TTotauxBalance;
SoldePieceEnCours:currency;
Begin
try//finally
//if Type_version_execution=ct_developpement then
//if e.TypeClient=cl_isa then
begin
LaCptEntete.Caption:='';
LaLibCptEntete.Caption:='';
EdCreditSoldeDebitCptEnTete.Value:=0;
EdCreditSoldeCreditCptEnTete.Value:=0;
cpt:=dmpieces.piece1.Compte;
if not empty(cpt) then
 begin
  LaCptEntete.Caption:=cpt;
  if TypeCptTiers(cpt) then
   begin
    Totaux:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(E.DatExoDebut,e.DatExoFin,cpt);
    LaLibCptEntete.Caption:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[cpt]).Nom;
   end
  else
   begin
    Totaux:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,e.DatExoFin,cpt);
    LaLibCptEntete.Caption:=DMPlan.LibelleDuNumCptPCU(Cpt);
   end;
  if Totaux.SoldeDebitCreditFin then
   EdCreditSoldeDebitCptEnTete.Value:=Totaux.SoldeFin
  else
   EdCreditSoldeCreditCptEnTete.Value:=Totaux.SoldeFin;
 end;
SoldePieceEnCours:=SommeColonne(GrGrid1,6,1,GrGrid1.RowCount-1) - SommeColonne(GrGrid1,5,1,GrGrid1.RowCount-1);

if DMPieces.Piece1.InfosPointage.infosPointage.Pointee then
  LaResteAPointer.caption:=e.FormatCurr(DMPieces.Piece1.InfosPointage.InfosReste.Reste)
else
  LaResteAPointer.caption:=e.FormatCurr(abs(SoldePieceEnCours));
end;
finally
TiInfosEntete.Enabled:=false;
end;
end;

procedure TsaisieP_3.TiInfosCorpsTimer(Sender: TObject);
var
Totaux:TTotauxBalance;
Begin
try//finally
//if Type_version_execution=ct_developpement then
//if e.TypeClient=cl_isa then
begin
LaCptCorps.Caption:='';
LaCompteEnCours.Caption:='';
EdCreditSoldeDebitCptCorps.Value:=0;
EdCreditSoldeCreditCptCorps.Value:=0;
Cpt:=grgrid1.cells[1,ligneCurr];
if not empty(cpt) then
 begin
  LaCptCorps.Caption:=cpt;
  if TypeCptTiers(cpt) then
   begin
    Totaux:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(E.DatExoDebut,e.DatExoFin,cpt);
    LaCompteEnCours.Caption:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[cpt]).Nom;
    LaCompteEnCours.Font.Color:=clGreen;
   end
  else
   begin
    Totaux:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,e.DatExoFin,cpt);
    LaCompteEnCours.Caption:=DMPlan.LibelleDuNumCptPCU(Cpt);
    if DMPlan.PossedeFils(cpt) then
     LaCompteEnCours.Font.Color:=clblack
    else
     LaCompteEnCours.Font.Color:=clGreen;
   end;
  if not Totaux.SoldeDebitCreditFin then
   EdCreditSoldeCreditCptCorps.Value:=Totaux.SoldeFin
  else
   EdCreditSoldeDebitCptCorps.Value:=Totaux.SoldeFin;
 end
 else
 begin
  EdCreditSoldeCreditCptCorps.Value:=0;
  EdCreditSoldeDebitCptCorps.Value:=0;
  LaCompteEnCours.Caption:='';
 end;
end;
finally
  TiInfosCorps.Enabled:=false;
end;
end;

procedure TsaisieP_3.RxChListCptColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTri:=-OrdreTri;
  if Column.Index in TabDate  then
   begin
      if OrdreTri > 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortDateProcAsc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortDateProcAsc, -1);
        end;
      if OrdreTri < 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortDateProcDesc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortDateProcDesc, -1)
        end;
  end
else
  if (Column.Index in TabCurr)  then
   begin
      if OrdreTri > 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortCurrProcAsc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortCurrProcAsc, -1);
        end;
      if OrdreTri < 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortCurrProcDesc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortCurrProcDesc, -1)
        end;
  end
else
  begin
      if Column.Index > 0 then
      (sender as TListView).CustomSort(nil, Column.Index-1)
      else
      (sender as TListView).CustomSort(nil, -1)
  end;
end;

procedure TsaisieP_3.RxChListCptCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

procedure TsaisieP_3.Calculatrice2Click(Sender: TObject);
var
validation,Act:boolean;
begin
validation:=true;
Act:=true ;
AfficheCalculatrice(GrGrid1);
GrGrid1Change(GrGrid1);
GrGrid1ColExit(GrGrid1.Col,GrGrid1.Row);
  GrGrid1RowValidate(self,Validation,Act,grgrid1.col);
end;

procedure TsaisieP_3.GrGrid1RowExit(sender: TObject; LastRow: Integer);
begin
if (grgrid1.col in [5]) then
begin
if not empty(grgrid1.cells[5,lignecurr]) then grgrid1.cells[5,lignecurr] :=e.FormatCurrSansDevise(StrToCurr_Lgr(grgrid1.cells[5,lignecurr]));
end;
if (grgrid1.col in [6]) then
begin
if not empty(grgrid1.cells[6,lignecurr]) then grgrid1.cells[6,lignecurr] :=e.FormatCurrSansDevise(StrToCurr_Lgr(grgrid1.cells[6,lignecurr]));
end;
end;

end.



