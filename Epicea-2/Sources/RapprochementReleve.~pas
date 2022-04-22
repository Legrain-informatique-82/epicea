unit RapprochementReleve;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, GrGrid, StdCtrls, RXCtrls, jpeg, ExtCtrls, RXSplit,
  DBGrids, RXDBCtrl, ExRxDBGrid, E2_Librairie_Obj,GrDBGrid,
  DmImportReleves,E2_Decl_Records,Gr_Librairie_Obj, Mask, DBCtrls,DB, Menus,
  ToolEdit, ComCtrls, ImgList;

type




  TRapprochementReleves = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    Panel1: TPanel;
    Label6: TLabel;
    Label5: TLabel;
    RxSpeedButton3: TRxSpeedButton;
    RxLabMArqueCourante: TRxLabel;
    EdBanque: TEdit;
    EdLibelle: TEdit;
    PaBas: TPanel;
    Label1: TLabel;
    CBoxListeMarque: TComboBox;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaGrille: TPanel;
    PaEcritures: TPanel;
    PaReleve: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    GrMouvementEcriture: TGrGrid;
    PaCumul1: TPanel;
    PaCptIntit: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel7: TPanel;
    Panel11: TPanel;
    Label4: TLabel;
    PaTools: TPanel;
    RxSpeedButton4: TRxSpeedButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Marquageautomatique1: TMenuItem;
    Panel14: TPanel;
    Panel15: TPanel;
    GrMouvementReleve: TGrGrid;
    RSEcriture: TRxSplitter;
    Label7: TLabel;
    EdReference: TEdit;
    EdSuppl: TEdit;
    CBNonMarques: TCheckBox;
    CBMarques: TCheckBox;
    CbTous: TCheckBox;
    BtnMarquageAuto: TButton;
    EdDateFinReleve: TDateEdit;
    Label9: TLabel;
    LVReleve: TListView;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    GrSoldeCompte: TGrGrid;
    GrCochesEcriture: TGrGrid;
    GrSoldeReleve: TGrGrid;
    GrCochesReleve: TGrGrid;
    N2: TMenuItem;
    outcocher1: TMenuItem;
    outdcocher1: TMenuItem;
    BtnMarquesReleve: TRxSpeedButton;
    BtnMarquesEnCours: TRxSpeedButton;
    LvRapprochement: TListView;
    N3: TMenuItem;
    Supprimerlalignederelev1: TMenuItem;
    ImageList1: TImageList;
 //   Procedure DaRappBancStateChange(Sender: TObject);
    Procedure initTotaux;
    Procedure initTotauxCoches(changeEtat:boolean=false);
    Procedure InitComboListMarque();
    procedure EdBanqueExit(Sender: TObject);
    procedure CBoxListeMarqueChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdBanqueEnter(Sender: TObject);
    procedure EdBanqueKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    Function DeMarquageEnCours(AfficheMessage:boolean):TExceptLGR;
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure RSEcritureResize(Sender: TObject);
//    procedure initGrReleve;
    procedure initLVReleve;
//    procedure initGrGridRappBanc;
    procedure initLVRapprochement;
    procedure Marquageautomatique1Click(Sender: TObject);
    procedure StateChangePartiel(EtatGrille: TDataSetState);
    procedure GrGridRappBancStateChange(EtatGrille: TDataSetState);
    procedure PaEcrituresResize(Sender: TObject);
    procedure PaReleveResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    Function SommeColonneChampRempli(ListeView:TListView;Col,RowDeb,RowFin,ChampRempli:Integer):Variant;
    Function SommeColonneChecked(ListeView:TListView;Col,RowDeb,RowFin:integer):Variant;
    procedure CBNonMarquesClick(Sender: TObject);
    procedure CBMarquesClick(Sender: TObject);
    procedure CbTousClick(Sender: TObject);
    procedure GestionBoutons;
    procedure PaBtnResize(Sender: TObject);
    procedure Crationrglement1Click(Sender: TObject);
    procedure GestionEcran;
    procedure InitLisViewAvecListe(ListView:TListView;TabTitreColonne:array of string;ListeValeur:TStringList);
    procedure LVReleveResize(Sender: TObject);
    procedure LVRapprochement_oldResize(Sender: TObject);
    function RechercheMarquageAutoEcriture(marque:string):TListItem ;
    function RechercheMarquageAutoReleve(marque:string):TListItem ;
    procedure LVRapprochement_oldSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure LVReleveSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure SelectedMarquageAutoEcriture(marque:string) ;
    procedure SelectMarquageAutoReleve(Selected:boolean);
    procedure SelectMarquageAutoEcriture(Selected:boolean);
    procedure LVReleveCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormShow(Sender: TObject);
    function MarquageItemsEcritureDelete(item:TListItem;Marque:string):boolean;
    function MarquageItemsReleveDelete(item:TListItem;Marque:string):boolean;
    procedure LVRapprochement_oldDblClick(Sender: TObject);
    procedure LVReleveDblClick(Sender: TObject);
    procedure LVReleveChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure LVRapprochement_oldChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);

    procedure outcocher1Click(Sender: TObject);
    procedure outdcocher1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure LVRapprochement_oldCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LVRapprochement_oldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LVReleveKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnMarquesReleveClick(Sender: TObject);
    procedure BtnMarquesEnCoursClick(Sender: TObject);
    procedure BtnMarquesReleveMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BtnMarquesReleveMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BtnMarquesEnCoursMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BtnMarquesEnCoursMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LvRapprochementMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LVReleveMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Supprimerlalignederelev1Click(Sender: TObject);
    procedure LvRapprochementColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure LvRapprochementCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure LVReleveCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure GestionDesColumnsRapprochement(Columns:TListColumns;Column:TListColumn);
    procedure GestionDesColumnsReleve(Columns:TListColumns;Column:TListColumn);
    procedure Visualisation1Click(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
      procedure LvRapprochementChecked(item:TListItem);
      procedure LvReleveChecked(item:TListItem);
    procedure LVReleveMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LvRapprochementMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure LVReleveColumnClick(Sender: TObject; Column: TListColumn);
    procedure CreerReglement1Click(Sender: TObject);
  private
    { Déclarations privées }
        MarqueCourante,marqueSelected : string;

         Procedure InitLibelle(NumAffichage:Integer;DateDeb,DateFin:Tdate);
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    TypeAffichage:integer;
     ChampMarquageEcriture,ChampMarquageReleve:integer;
     ChampMarquageControleEcriture,ChampMarquageControleReleve:integer;
     ChampDebitReleve,ChampCreditReleve:integer;
     ChampDebitRappr,ChampCreditRappr:integer;
     ChampIdReleve,ChampIdRapp:integer;
     Direct:boolean;
     TabStr,TabCurr,TabDate : set of Byte;
  end;


var
  RapprochementReleves: TRapprochementReleves;
  typeRapprochement:TtypeRapprochement;
  OrdreTriRapprochement,OrdreTriReleve:integer;
  lignesReleves,LignesRapprochement:TStringlist;
  OldColorEcriture,OldColorReleve:Tcolor;
  itemLvRapprochementCoche,itemLvReleveCoche:boolean;
  function RapprochementRelevesAffiche(ParamAfficheReleve:TParamAfficheReleve):integer;



implementation

uses   LibZoneSaisie, DMRecherche,
   LibSQL,  DMPlanCpt, DMPiece,
  E2_AideCompte, E2_AideModel,Registry, LibGestionParamXML, DMConstantes,
  E2_Main, InputQueryFrm_F, lib_chaine, Lib1, ImportReleve,
  DMRapprochementBancaire, DMEcriture, E2_DetailEcr;

{$R *.DFM}


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
procedure TRapprochementReleves.FormCreate(Sender: TObject);
Var
 Registre :TRegistry;
begin
  if DMImportReleve = nil then
    DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
  TitreForm := 'Rapprochement Bancaire';
  //SousTitreForm := CEcriture;
  try
    LibGestionParamXML.InitialiseForm(E.User,Self);
  except
    InitialiseFormPosDefaut(self);
  end;

  OldColorReleve:=LVReleve.Canvas.Brush.Color;
  OldColorEcriture:=LVRapprochement.Canvas.Brush.Color;
end;

function RapprochementRelevesAffiche(ParamAfficheReleve:TParamAfficheReleve):integer;
var
k:integer;
begin
 if (RapprochementReleves = nil) then RapprochementReleves:=TRapprochementReleves.Create(application.MainForm);
 RapprochementReleves.EdBanque.OnExit:=nil;
 RapprochementReleves.TitreForm:='Pointage des relevés importés';
 RapprochementReleves.Caption:=RapprochementReleves.TitreForm;
 DMImportReleve.listeMarqueEnCours.Clear;
DMImportReleve.ToutesMarques:=false;
DMImportReleve.MarqueCourante:=ParamAfficheReleve.Marque;
RapprochementReleves.BtnMarquesReleve.Caption:= str_getstringelement(RapprochementReleves.BtnMarquesReleve.Caption,1,':') + ' : '+ParamAfficheReleve.Marque;
RapprochementReleves.BtnMarquesEnCours.Caption:= str_getstringelement(RapprochementReleves.BtnMarquesEnCours.Caption,1,':') + ' : '+ParamAfficheReleve.Marque;
// RapprochementReleves.TitreForm:=ParamAfficheReleve.Titre;
 RapprochementReleves.Direct:=ParamAfficheReleve.Direct;
 RapprochementReleves.EdDateFinReleve.Date:=ParamAfficheReleve.DateFinReleve;
 RapprochementReleves.MarqueCourante:=ParamAfficheReleve.Marque;
 RapprochementReleves.EdBanque.Text:=ParamAfficheReleve.Journal;
 RapprochementReleves.EdLibelle.Text:=ParamAfficheReleve.libelleJournal;
 RapprochementReleves.RxLabMArqueCourante.Caption:=ParamAfficheReleve.Marque;


RapprochementReleves.GrSoldeCompte.ParamColor:=true;
RapprochementReleves.GrSoldeCompte.Param:=ParamUtil.CouleurDBGrid;
RapprochementReleves.GrSoldeCompte.DessineContourLigne:=false;
RapprochementReleves.GrSoldeCompte.UpDateColor;

RapprochementReleves.GrMouvementEcriture.ParamColor:=true;
RapprochementReleves.GrMouvementEcriture.Param:=ParamUtil.CouleurDBGrid;
RapprochementReleves.GrMouvementEcriture.DessineContourLigne:=false;
RapprochementReleves.GrMouvementEcriture.UpDateColor;

RapprochementReleves.GrMouvementReleve.ParamColor:=true;
RapprochementReleves.GrMouvementReleve.Param:=ParamUtil.CouleurDBGrid;
RapprochementReleves.GrMouvementReleve.DessineContourLigne:=false;
RapprochementReleves.GrMouvementReleve.UpDateColor;

RapprochementReleves.GrSoldeReleve.ParamColor:=true;
RapprochementReleves.GrSoldeReleve.Param:=ParamUtil.CouleurDBGrid;
RapprochementReleves.GrSoldeReleve.DessineContourLigne:=false;
RapprochementReleves.GrSoldeReleve.UpDateColor;

RapprochementReleves.GrCochesEcriture.ParamColor:=true;
RapprochementReleves.GrCochesEcriture.Param:=ParamUtil.CouleurDBGrid;
RapprochementReleves.GrCochesEcriture.DessineContourLigne:=false;
RapprochementReleves.GrCochesEcriture.UpDateColor;

RapprochementReleves.GrCochesReleve.ParamColor:=true;
RapprochementReleves.GrCochesReleve.Param:=ParamUtil.CouleurDBGrid;
RapprochementReleves.GrCochesReleve.DessineContourLigne:=false;
RapprochementReleves.GrCochesReleve.UpDateColor;


result:=0;
if DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(application.MainForm);
if RapprochementReleves.Direct then
RapprochementReleves.Show
else
result:=RapprochementReleves.ShowModal;

RapprochementReleves.EdBanque.OnExit:=RapprochementReleves.EdBanqueExit;
end;



Procedure TRapprochementReleves.InitComboListMarque();
Var
I:Integer;
Begin
I:=CBoxListeMarque.ItemIndex;
CBoxListeMarque.Clear;
CBoxListeMarque.Items.Assign(DMImportReleve.ListeMarque(EdBanque.Text));
CBoxListeMarque.Items.Insert(0,' Toutes les marques ...');
if ((I < 0) or (I > CBoxListeMarque.Items.Count)) then
CBoxListeMarque.ItemIndex := 0
else
CBoxListeMarque.ItemIndex := I;
End;



Procedure TRapprochementReleves.initTotaux;
var
SoldeDebit,SoldeCredit:Currency;
TotauxRappBanc:TTotauxRappBanc;
Begin
//ecriture
TotauxRappBanc.TotalMvtCompteDebit:=SommeColonneChampRempli(LVRapprochement,ChampDebitRappr,0,LVRapprochement.Items.Count-1,ChampMarquageEcriture);
TotauxRappBanc.TotalMvtCompteCredit:=SommeColonneChampRempli(LVRapprochement,ChampCreditRappr,0,LVRapprochement.Items.Count-1,ChampMarquageEcriture);

SoldeDebit:=TotauxRappBanc.TotalMvtCompteDebit ;
SoldeCredit:=TotauxRappBanc.TotalMvtCompteCredit;
DetermineSolde(SoldeDebit,SoldeCredit);
GrMouvementEcriture.Cells[0,0]:=e.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteDebit);
GrMouvementEcriture.Cells[1,0]:=e.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteCredit);
GrSoldeCompte.Cells[0,0]:=e.FormatCurrSansDevise(SoldeDebit);
GrSoldeCompte.Cells[1,0]:=e.FormatCurrSansDevise(SoldeCredit);

//releve
TotauxRappBanc.TotalMvtCompteDebit:=SommeColonneChampRempli(LVReleve,ChampDebitReleve,0,LVReleve.Items.Count-1,ChampMarquageReleve);
TotauxRappBanc.TotalMvtCompteCredit:=SommeColonneChampRempli(LVReleve,ChampCreditReleve,0,LVReleve.Items.Count-1,ChampMarquageReleve);
SoldeDebit:=TotauxRappBanc.TotalMvtCompteDebit ;
SoldeCredit:=TotauxRappBanc.TotalMvtCompteCredit;
DetermineSolde(SoldeDebit,SoldeCredit);
GrMouvementReleve.Cells[0,0]:=e.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteDebit);
GrMouvementReleve.Cells[1,0]:=e.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteCredit);
GrSoldeReleve.Cells[0,0]:=e.FormatCurrSansDevise(SoldeDebit);
GrSoldeReleve.Cells[1,0]:=e.FormatCurrSansDevise(SoldeCredit);

initTotauxCoches;
End;

Procedure TRapprochementReleves.initTotauxCoches(changeEtat:boolean);
var
SoldeDebit,SoldeCredit:Currency;
TotauxRappBanc:TTotauxRappBanc;
Begin
//ecriture
SoldeDebit:=SommeColonneChecked(LVRapprochement,ChampDebitRappr,0,LVRapprochement.Items.Count-1);
SoldeCredit:=SommeColonneChecked(LVRapprochement,ChampCreditRappr,0,LVRapprochement.Items.Count-1);
DetermineSolde(SoldeDebit,SoldeCredit);
GrCochesEcriture.Cells[0,0]:=e.FormatCurrSansDevise(SoldeDebit);
GrCochesEcriture.Cells[1,0]:=e.FormatCurrSansDevise(SoldeCredit);
if (SoldeDebit+SoldeCredit<>0)or(DMImportReleve.ListeMarquageEcritureEnCours.Count<>0) then
  StateChangePartiel(dsedit) else StateChangePartiel(dsBrowse);
//releve
SoldeDebit:=SommeColonneChecked(LVReleve,ChampDebitReleve,0,LVReleve.Items.Count-1);
SoldeCredit:=SommeColonneChecked(LVReleve,ChampCreditReleve,0,LVReleve.Items.Count-1);
DetermineSolde(SoldeDebit,SoldeCredit);
GrCochesReleve.Cells[0,0]:=e.FormatCurrSansDevise(SoldeDebit);
GrCochesReleve.Cells[1,0]:=e.FormatCurrSansDevise(SoldeCredit);
if (BtnEnregistrer.Enabled=false)and((SoldeDebit+SoldeCredit<>0)or(DMImportReleve.ListeMarquageReleveEnCours.Count<>0)) then
  StateChangePartiel(dsedit);
End;

Procedure TRapprochementReleves.InitLibelle(NumAffichage:Integer;DateDeb,DateFin:Tdate);
Begin
TypeAffichage:=NumAffichage;
case NumAffichage of
  0:Begin
//      DBGridRappBanc.ReportCaption := 'Non Marqués';
//      Panel10.Caption := 'Mouvements du '+datetostr(DateDeb)+' au '+datetostr(DateFin)+' :  ';
//      Panel8.Caption := 'Solde ( votre compta.) au '+datetostr(DateFin)+' :  ';
//      Panel5.Caption := 'Mouvements non marqués au '+datetostr(DateFin)+' : ';
//      Panel7.Caption := 'Solde sur le relevé de banque au '+datetostr(DateFin)+' :  ';
//      VisibleControl([Panel8,GrGrid4,Panel5,Panel7,GrGrid3,GrGrid1],True);
//      VisibleControl([Panel10,GrGrid5],false);
    End;

  1:Begin
      // initialisation des libellés des Panels
//      DBGridRappBanc.ReportCaption := 'Déjà Marqués';
//      Panel10.Caption := 'Total des mouvements marqués : ';
//      Panel8.Caption := 'Solde des mouvements marqués : ';
//      Panel5.Caption := C_StrVide;
//      Panel7.Caption := C_StrVide;
//      VisibleControl([Panel5,Panel7,GrGrid3,GrGrid1],false);
//      VisibleControl([Panel10,Panel8,GrGrid4,GrGrid5],true);

    End;

  2:Begin
//      DBGridRappBanc.ReportCaption := 'Tous';
//      Panel10.Caption := 'Mouvements du '+datetostr(DateDeb)+' au '+datetostr(DateFin)+' :  ';
//      Panel8.Caption := 'Solde ( votre compta.) au '+datetostr(DateFin)+' :  ';
//      Panel5.Caption := 'Mouvements non marqués au '+datetostr(DateFin)+' : ';
//      Panel7.Caption := 'Solde sur le relevé de banque au '+datetostr(DateFin)+' :  ';
//      VisibleControl([Panel5,Panel7,GrGrid3,GrGrid1],True);
//      VisibleControl([Panel10,Panel8,GrGrid4,GrGrid5],True);
    End;

  3:Begin
//      DBGridRappBanc.ReportCaption := 'Marquage en cours ...';
//      Panel10.Caption := 'Mouvements du '+datetostr(DateDeb)+' au '+datetostr(DateFin)+' :  ';
//      Panel8.Caption := 'Solde ( votre compta.) au '+datetostr(DateFin)+' :  ';
//      Panel5.Caption := 'Mouvements non marqués au '+datetostr(DateFin)+' : ';
//      Panel7.Caption := 'Solde sur le relevé de banque au '+datetostr(DateFin)+' :  ';
//      VisibleControl([Panel5,Panel7,GrGrid3,GrGrid1],True);
//      VisibleControl([Panel10,Panel8,GrGrid4,GrGrid5],True);
    End;

else showmessage('RappBanc.InitLibelle : Cas inconnu !');
end;

End;

procedure TRapprochementReleves.EdBanqueExit(Sender: TObject);
var
MessDerSub:boolean;
begin
if ((ActiveControl<>btnAnnuler)and(ActiveControl<>btnFermer)and(ActiveControl<>BtnMarquageAuto))then
begin
  DMPlan.TaCompte.OnFilterRecord:=DMPlan.TaCompteFilterRecord;
  DMPieces.GestionFiltrageParamCpt(3);
  if ((not AideCompteDansContexte(EdBanque.Text,EdBanque,['Rac1'],false,MessDerSub,true,true,false,true,0))
  and(not AideModelAfficheJournauxBanque(EdBanque,False))) then
    begin
       EdBanque.SetFocus;
       abort;
    end
   else
   begin
     DeFiltrageDataSet(DMrech.TaModelRech);
     if GrLocate(DMrech.TaModelRech,'Compte',[EdBanque.text]) then
       begin
            EdLibelle.Text:=DMrech.TaModelRech.findField('Journal').AsString + ' : '+
                            DMrech.TaModelRech.findField('Libelle_Model').AsString;
       end
     else
       Begin
          MessageDlg('Le Compte : '+EdBanque.text+' n''est pas lié à un journal bancaire', mtError, [mbOK], 0);
          EdLibelle.Text:=DMPlan.LibelleDuNumCptPCU(EdBanque.text);
       end;
     InitComboListMarque;

     GestionBoutons;
     initTotaux;

     if LVRapprochement.CanFocus then
     LVRapprochement.SetFocus;
   end;
end;
end;


procedure TRapprochementReleves.CBoxListeMarqueChange(Sender: TObject);
Begin

if CBoxListeMarque.ItemIndex > 0 then
 begin
   FiltrageDataSet(DMImportReleve.QuEcr_RappBanc,'Compte = '''+EdBanque.text+''' and marqueReleve = '''+CBoxListeMarque.Items[CBoxListeMarque.ItemIndex]+'''');
   FiltrageDataSet(DMImportReleve.QuReleve,'Compte = '''+EdBanque.text+''' and marque = '''+CBoxListeMarque.Items[CBoxListeMarque.ItemIndex]+'''');
   CBMarques.state:=cbchecked;
 end
 else
   begin
     FiltrageDataSet(DMImportReleve.QuEcr_RappBanc,'Compte = '''+EdBanque.text+'''');
     FiltrageDataSet(DMImportReleve.QuReleve,'Compte = '''+EdBanque.text+'''');
   end;
initLVReleve;
initLVRapprochement;
GrGridRappBancStateChange(dsBrowse);

end;


procedure TRapprochementReleves.EdBanqueEnter(Sender: TObject);
begin
FiltrageDataSet(DMImportReleve.QuEcr_RappBanc,'ID = -1');
FiltrageDataSet(DMImportReleve.QuReleve,'ID = -1');
initLVReleve;
initLVRapprochement;

end;

procedure TRapprochementReleves.EdBanqueKeyPress(Sender: TObject;
  var Key: Char);
begin
if key = #13 then
 begin
  key := #9;
 end;
end;

procedure TRapprochementReleves.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TRapprochementReleves.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TRapprochementReleves.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TRapprochementReleves.BtnEnregistrerClick(Sender: TObject);
var
valide:boolean;
i:integer;
begin
try
valide:=true;
while DMImportReleve.ListeMarquageEcritureEnCours.Count>0 do
  begin
     //modifier le marquage réel de ces écritures pour les marquer avec la lettre en cours
     DMImportReleve.MarquageEcriture('Rapprochement',MarqueCourante,StrToInt_Lgr(DMImportReleve.ListeMarquageEcritureEnCours.Strings[0]),true);
     DMRappBanc.ListeMarquageEnCours.Add(DMImportReleve.ListeMarquageEcritureEnCours.Strings[0]);
     DMImportReleve.ListeMarquageEcritureEnCours.Delete(0);
  end;
while DMImportReleve.ListeMarquageReleveEnCours.Count>0 do
  begin
     //modifier le marquage réel de ces écritures pour les marquer avec la lettre en cours
     DMImportReleve.MarquageReleve('Rapprochement',MarqueCourante,StrToInt_Lgr(DMImportReleve.ListeMarquageReleveEnCours.Strings[0]),true);
     DMImportReleve.ListeMarquageReleveEnCours.Delete(0);
  end;
DMImportReleve.ListeMarquageAuto.Clear;
DMImportReleve.listeMarqueEnCours.clear;
GestionBoutons;
except;
end;

end;

procedure TRapprochementReleves.BtnModifierClick(Sender: TObject);
begin
  TableGereEdit(DMImportReleve.TaEcr_RappBanc);
  TableGereEdit(DMImportReleve.TaReleve );
end;

procedure TRapprochementReleves.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TRapprochementReleves.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
retour:integer;
begin
if DMImportReleve <> nil then
 begin
     //s'il y a des marquages en cours, demander si on veut les valider
     if (BtnInserer.Enabled=true)and (BtnEnregistrer.Enabled=false)then
     begin
        self.WindowState:=wsNormal;
        self.BringToFront;
        canclose:= application.MessageBox(Pchar('Voulez-vous annuler les pointages en cours ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes;
        if canclose then BtnInserer.Enabled:=false;
     end;
     If (BtnEnregistrer.Enabled=true)  or(DMImportReleve.ListeMarquageEcritureEnCours.Count<>0)or(DMImportReleve.ListeMarquageReleveEnCours.Count<>0) Then
     Begin
        self.WindowState:=wsNormal;
        self.BringToFront;
        retour:= application.MessageBox(Pchar('Voulez-vous enregistrer les marquages en cours ?'),'Suppression',MB_ICONWARNING +MB_YESNOCANCEL+MB_DEFBUTTON3);
        if retour=mryes then
         begin
           BtnEnregistrerClick(BtnEnregistrer);
           canclose:=true;
          end
          else
        if retour=mrno then
           begin
           //Effacer les rapprochements en cours à partir de la liste "ListeMarquageEnCours"
           if DeMarquageEnCours(true).retour then
             canclose:=true
           else
             canclose:=false;
           end
           else canclose:=false;
     End; // Fin utilisateur est en mode Modification
  end;//fin si DMRappBanc <> nil
if CanClose then
  begin
    DMImportReleve.ListeMarquageEcritureEnCours.Clear;
    DMImportReleve.ListeMarquageReleveEnCours.Clear;
    DMImportReleve.ListeMarquageAuto.Clear;
    EdBanqueEnter(EdBanque);
  end
 else
 begin
    if DMImportReleve=nil then
   DMImportReleve:=TDMImportReleve.Create(self);

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);
//   abort;
 end;
ModalResult:=mrOk; 
end;

Function TRapprochementReleves.DeMarquageEnCours(AfficheMessage:boolean):TExceptLGR;
var
EtatFiltreEcr,EtatFiltreReleve:TEtatFiltre;
i:integer;
Begin
  try//try finally
    try//try except
      Initialise_ExceptLGR(result);
      result.retour:=true;
      //table Ecriture

      DMImportReleve.TaEcrTemp.Open;

      TableGereStartTransaction(DMImportReleve.TaEcrTemp);

      DeFiltrageDataSet(DMImportReleve.TaEcrTemp);
      DMImportReleve.TaEcrTemp.Filtered := true;
      DMImportReleve.TaEcrTemp.OnFilterRecord:=DMImportReleve.TaEcr_FilterRecord_DemarquageEnCours;
      DMImportReleve.TaEcrTemp.Refresh;
      DMImportReleve.TaEcrTemp.First;
      while DMImportReleve.TaEcrTemp.RecordCount<>0 do
        Begin
          TableGereEdit(DMImportReleve.TaEcrTemp);
          DMImportReleve.TaEcrTemp.FindField('Rapprochement').asstring:=C_StrVide;
          DMImportReleve.TaEcrTemp.FindField('marqueReleve').asstring:=C_StrVide;
          TableGerePost(DMImportReleve.TaEcrTemp);
          i:=DMImportReleve.ListeMarquageEcritureEnCours.IndexOf(DMImportReleve.TaEcrTemp.findfield('id').AsString);
          if i<>-1 then DMImportReleve.ListeMarquageEcritureEnCours.Delete(i);
          DMImportReleve.TaEcrTemp.first;
        End;
      //table releve

      DMImportReleve.TaReleveTemp.Open;
      DeFiltrageDataSet(DMImportReleve.TaReleveTemp);
      DMImportReleve.TaReleveTemp.Filtered := true;
      DMImportReleve.TaReleveTemp.OnFilterRecord:=DMImportReleve.TaReleve_FilterRecord_DemarquageEnCours;
      DMImportReleve.TaReleveTemp.Refresh;
      DMImportReleve.TaReleveTemp.First;
      while DMImportReleve.TaReleveTemp.RecordCount<>0 do
        Begin
          TableGereEdit(DMImportReleve.TaReleveTemp);
          DMImportReleve.TaReleveTemp.FindField('marque').asstring:=C_StrVide;
          DMImportReleve.TaReleveTemp.FindField('Rapprochement').asstring:=C_StrVide;
          TableGerePost(DMImportReleve.TaReleveTemp);
          i:=DMImportReleve.ListeMarquageReleveEnCours.IndexOf(DMImportReleve.TaReleveTemp.findfield('id').AsString);
          if i<>-1 then DMImportReleve.ListeMarquageReleveEnCours.Delete(i);
          DMImportReleve.TaReleveTemp.first;
        End;
      TableGereCommit(DMImportReleve.TaReleveTemp);
        DMImportReleve.ListeMarquageEcritureEnCours.Clear;
        DMImportReleve.ListeMarquageReleveEnCours.Clear;
        DMImportReleve.ListeMarquageAuto.Clear;
    except
       TableGereRollBack(DMImportReleve.TaReleveTemp);
       result.retour:=false;
       raise ExceptLGR.Create('Erreur lors de la suppression des marquages en cours !',1001,AfficheMessage,mtError,result);
    end;//fin du try except
  finally
    DeFiltrageDataSet(DMImportReleve.TaReleveTemp);
    DeFiltrageDataSet(DMImportReleve.TaEcrTemp);
    gestionBoutons;
  end;//fin du try finally
End;


procedure TRapprochementReleves.FormActivate(Sender: TObject);
begin
//self.OnCloseQuery:=FormCloseQuery;
//Initialiser_ShortCut_Main(true);
//PaEcritures.Width:=PaReleve.Width-20;
//GestionEcran;
end;

procedure TRapprochementReleves.FormDestroy(Sender: TObject);
Var
 Registre :TRegistry;
begin
 Registre:= TRegistry.Create;
   try
    with Registre do
    begin
       RootKey := HKEY_LOCAL_MACHINE;

       OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
     try
       WriteString('Banque',EdBanque.Text);
       WriteString('Marque',MarqueCourante);
     except
       CloseKey
     end;
  end;
   finally
    Registre.Free;
   end;

  LibGestionParamXML.DestroyForm(Self,E.USer);

  if DMImportReleve <> nil then
    DMImportReleve.Destroy;
  RapprochementReleves := nil;
end;

procedure TRapprochementReleves.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[LVRapprochement,LVReleve]);
     If Key = VK_ESCAPE Then
     Begin
         if ((LVRapprochement.Focused)or(LVReleve.Focused)) and (direct )then
            begin
              EdBanque.SetFocus ;
            end
            else Self.Close;
     End;
end;


procedure TRapprochementReleves.BtnInsererClick(Sender: TObject);
var
valide:boolean;
MontantReleveDebit,MontantReleveCredit,MontantRapprochementDebit,MontantRapprochementCredit:currency;
i:integer;
MarqueAuto:string;
begin
MontantReleveDebit:=0;
MontantRapprochementDebit:=0;
MontantReleveCredit:=0;
MontantRapprochementCredit:=0;

MarqueAuto:=DMImportReleve.MaxMarque(MarqueCourante);
valide:=true;
try
LVReleve.OnChange:=nil;
LvRapprochement.OnChange:=nil;
for i:=0 to LVReleve.Items.Count-1 do
begin
  if (LVReleve.Items[i].Checked)and(empty(TLigneReleve(LVReleve.Items[i].SubItems.Objects[0]).MARQUE))then
    begin
       if TLigneReleve(LVReleve.Items[i].SubItems.Objects[0]).DEBIT<>0 then
         MontantReleveDebit:=MontantReleveDebit+TLigneReleve(LVReleve.Items[i].SubItems.Objects[0]).DEBIT
       else
         MontantReleveCredit:=MontantReleveCredit+TLigneReleve(LVReleve.Items[i].SubItems.Objects[0]).CREDIT;
    end;
end;
for i:=0 to LVRapprochement.Items.Count-1 do
begin
  if (LVRapprochement.Items[i].Checked)and(empty(TLigneRapprochement(LVRapprochement.Items[i].SubItems.Objects[0]).MARQUE))then
    begin
       if TLigneRapprochement(LVRapprochement.Items[i].SubItems.Objects[0]).DEBIT<>0 then
         MontantRapprochementDebit:=MontantRapprochementDebit+TLigneRapprochement(LVRapprochement.Items[i].SubItems.Objects[0]).DEBIT
       else
         MontantRapprochementCredit:=MontantRapprochementCredit+TLigneRapprochement(LVRapprochement.Items[i].SubItems.Objects[0]).CREDIT;
    end;
end;
DetermineSolde(MontantReleveDebit,MontantReleveCredit);
DetermineSolde(MontantRapprochementDebit,MontantRapprochementCredit);
if (MontantReleveDebit<>MontantRapprochementDebit)or(MontantReleveCredit<>MontantRapprochementCredit) then
begin
  showmessage('La somme des montants à rapprocher n''est pas équilibrée');
  exit;
end;

MarqueAuto:=DMImportReleve.MaxMarque(MarqueCourante);
i:=0;
while i<=LVReleve.Items.Count-1 do
begin
  if (LVReleve.Items[i].Checked)and(empty(TLigneReleve(LVReleve.Items[i].SubItems.Objects[0]).MARQUE))
  then
    begin
       DMImportReleve.MarquageReleve('marque',MarqueAuto,strtoint(LVReleve.Items[i].SubItems.Strings[ChampIdReleve]),true);
       if MarquageItemsReleveDelete(LVReleve.Items[i],MarqueAuto) then dec(i);
    end;
  inc(i);
end;
i:=0;
while i<=LVRapprochement.Items.Count-1 do
begin
  if (LVRapprochement.Items[i].Checked)and(empty(TLigneRapprochement(LVRapprochement.Items[i].SubItems.Objects[0]).MARQUE))
  then
    begin
       DMImportReleve.MarquageEcriture('marqueReleve',MarqueAuto,strtoint(LVRapprochement.Items[i].SubItems.Strings[ChampIdRapp]),true);
       if MarquageItemsEcritureDelete(LVRapprochement.Items[i],MarqueAuto) then Dec(i);
    end;
  inc(i);
end;
finally
  initTotaux;
  LVReleve.OnChange:=LVReleveChange;
LvRapprochement.OnChange:=LVRapprochement_oldChange;
end;
end;

procedure TRapprochementReleves.BtnSupprimerClick(Sender: TObject);
var
valide:boolean;
ListItem:TListItem;
i,idEnCours:integer;
//marqueEnCours:string;
begin
valide:=true;
try
     ListItem:=RechercheMarquageAutoEcriture(marqueSelected);
     while (ListItem<>nil) do
        begin
           DMImportReleve.MarquageEcriture('marqueReleve',C_StrVide,strtoint(ListItem.SubItems[ChampIdRapp]),true);
           DMImportReleve.MarquageEcriture('Rapprochement',C_StrVide,strtoint(ListItem.SubItems[ChampIdRapp]),true);
           MarquageItemsEcritureDelete(ListItem,C_StrVide);
           ListItem:=RechercheMarquageAutoEcriture(marqueSelected);
        end;
     ListItem:=RechercheMarquageAutoReleve(marqueSelected);
     while (ListItem<>nil) do
        begin
           DMImportReleve.MarquageReleve('marque',C_StrVide,strtoint(ListItem.SubItems[ChampIdReleve]),true);
           DMImportReleve.MarquageReleve('Rapprochement',C_StrVide,strtoint(ListItem.SubItems[ChampIdReleve]),true);
           MarquageItemsReleveDelete(ListItem,C_StrVide);
           ListItem:=RechercheMarquageAutoReleve(marqueSelected);
        end;
finally
  InitComboListMarque;
  LVReleve.Repaint;
  LVRapprochement.Repaint;
  initTotauxCoches(true);
  initTotaux;
end;
end;

procedure TRapprochementReleves.Aide1Click(Sender: TObject);
begin
if activeControl = EdBanque then
 begin
  AideModelAfficheJournauxBanque(EdBanque,True);
 end;
end;

procedure TRapprochementReleves.RSEcritureResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([CBNonMarques,CBMarques,CbTous],PaTools,90,0,5);

WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);


// Grilles d'en bas
Panel13.Width:=RenvoiTailleColonneListView(LVRapprochement,[0,1])+1;
GrSoldeCompte.ColWidths[0]:=LVRapprochement.Column[2].Width;
GrSoldeCompte.ColWidths[1]:=LVRapprochement.Column[3].Width;

Panel8.Width:=RenvoiTailleColonneListView(LVRapprochement,[0,1])+1;
GrMouvementEcriture.ColWidths[0]:=LVRapprochement.Column[2].Width;
GrMouvementEcriture.ColWidths[1]:=LVRapprochement.Column[3].Width;

Panel10.Width:=RenvoiTailleColonneListView(LVRapprochement,[0,1])+1;
GrCochesEcriture.ColWidths[0]:=LVRapprochement.Column[2].Width;
GrCochesEcriture.ColWidths[1]:=LVRapprochement.Column[3].Width;

Panel15.Width:=RenvoiTailleColonneListView(LVReleve,[0,1])+1;
GrMouvementReleve.ColWidths[0]:=LVReleve.Column[2].Width;
GrMouvementReleve.ColWidths[1]:=LVReleve.Column[3].Width;

Panel17.Width:=RenvoiTailleColonneListView(LVReleve,[0,1])+1;
GrSoldeReleve.ColWidths[0]:=LVReleve.Column[2].Width;
GrSoldeReleve.ColWidths[1]:=LVReleve.Column[3].Width;

Panel4.Width:=RenvoiTailleColonneListView(LVReleve,[0,1])+1;
GrCochesReleve.ColWidths[0]:=LVReleve.Column[2].Width;
GrCochesReleve.ColWidths[1]:=LVReleve.Column[3].Width;

end;


procedure TRapprochementReleves.initLVRapprochement;
var
LigneRapprochement:TLigneRapprochement;
begin
try
LVRapprochement.OnChange:=nil;
LVRapprochement.OnChanging:=nil;
ChampMarquageEcriture:=0;
ChampDebitRappr:=1;
ChampCreditRappr:=2;
ChampIdRapp:=5;
LVRapprochement.clear;
LignesRapprochement.clear;
 DMImportReleve.QuEcr_RappBanc.first;
while(not DMImportReleve.QuEcr_RappBanc.Eof)do
begin
   LigneRapprochement:=TLigneRapprochement.Create(self);
   LigneRapprochement.IDENTIFIANT:=DMImportReleve.QuEcr_RappBanc.findfield('id').AsInteger;
   LigneRapprochement.COMPTE:=DMImportReleve.QuEcr_RappBanc.findfield('compte').AsString;
   LigneRapprochement.DATEOP:=DMImportReleve.QuEcr_RappBanc.findfield('Date').AsDateTime;
   LigneRapprochement.DEBIT:=DMImportReleve.QuEcr_RappBanc.findfield('DebitSaisie').AsCurrency;
   LigneRapprochement.CREDIT:=DMImportReleve.QuEcr_RappBanc.findfield('CreditSaisie').AsCurrency;
   LigneRapprochement.DESIGNATION:=DMImportReleve.QuEcr_RappBanc.findfield('Libelle').AsString;
   LigneRapprochement.REFERENCE:=DMImportReleve.QuEcr_RappBanc.findfield('reference').AsString;
   LigneRapprochement.MARQUE:=DMImportReleve.QuEcr_RappBanc.findfield('MarqueReleve').AsString;
   LigneRapprochement.RAPPROCHEMENT:=DMImportReleve.QuEcr_RappBanc.findfield('Rapprochement').AsString;
   LignesRapprochement.AddObject(
                           DMImportReleve.QuEcr_RappBanc.findfield('MarqueReleve').AsString+';'+
                           e.FormatCurrSansDevise(DMImportReleve.QuEcr_RappBanc.findfield('DebitSaisie').AsCurrency)+';'+
                           e.FormatCurrSansDevise(DMImportReleve.QuEcr_RappBanc.findfield('CreditSaisie').AsCurrency)+';'+
                           DMImportReleve.QuEcr_RappBanc.findfield('Date').AsString+';'+
                           DMImportReleve.QuEcr_RappBanc.findfield('Libelle').AsString+';'+
                           DMImportReleve.QuEcr_RappBanc.findfield('id').AsString+';'
                           ,LigneRapprochement);
   DMImportReleve.QuEcr_RappBanc.next;
end;
OrdreTriRapprochement:=1;


TabStr:=[0,1,5,6];
TabCurr:=[2,3];
TabDate:=[4];
InitLisViewAvecListe(LVRapprochement, ['P','marque','debit','credit','dateOp','Libelle','id'],LignesRapprochement);
finally
  if LVRapprochement.Items.Count>0 then
    begin
       LVRapprochement.Items[0].Selected:=true;
      LVRapprochement.Items[0].Focused:=true;
    end;

  RSEcritureResize(RSEcriture);
  LVRapprochement.OnChange:=LVRapprochement_oldChange;
end;
//GrReleveRowEnter(GrReleve,1);
end;

procedure TRapprochementReleves.initLVReleve;
var
LigneReleve:TLigneReleve;
begin
try
LVReleve.OnChange:=nil;
LVReleve.OnChanging:=nil;
ChampMarquageReleve:=0;
ChampDebitReleve:=1;
ChampCreditReleve:=2;
ChampIdReleve:=5;
lignesReleves.clear;
LVReleve.clear;
DMImportReleve.QuReleve.first;
while(not DMImportReleve.QuReleve.Eof)do
begin
   LigneReleve:=TLigneReleve.Create(self);
   LigneReleve.IDENTIFIANT:=DMImportReleve.QuReleve.findfield('id').AsInteger;
   LigneReleve.COMPTE:=DMImportReleve.QuReleve.findfield('compte').AsString;
   LigneReleve.DATEOP:=DMImportReleve.QuReleve.findfield('dateOp').AsDateTime;
   LigneReleve.DEBIT:=DMImportReleve.QuReleve.findfield('debit').AsCurrency;
   LigneReleve.CREDIT:=DMImportReleve.QuReleve.findfield('credit').AsCurrency;
   LigneReleve.DESIGNATION:=DMImportReleve.QuReleve.findfield('designation').AsString;
   LigneReleve.SUPPLEMENT:=DMImportReleve.QuReleve.findfield('supplement').AsString;
   LigneReleve.REFERENCE:=DMImportReleve.QuReleve.findfield('reference').AsString;
   LigneReleve.MARQUE:=DMImportReleve.QuReleve.findfield('marque').AsString;
   LigneReleve.RAPPROCHEMENT:=DMImportReleve.QuReleve.findfield('Rapprochement').AsString;
   lignesReleves.AddObject(
                           LigneReleve.MARQUE+';'+
                           e.FormatCurrSansDevise(DMImportReleve.QuReleve.findfield('debit').AsCurrency)+';'+
                           e.FormatCurrSansDevise(DMImportReleve.QuReleve.findfield('credit').AsCurrency)+';'+
                           DMImportReleve.QuReleve.findfield('dateOp').AsString+';'+
                           DMImportReleve.QuReleve.findfield('Designation').AsString+';'+
                           DMImportReleve.QuReleve.findfield('id').AsString+';'
                           ,LigneReleve);
   DMImportReleve.QuReleve.next;
end;
OrdreTriReleve:=1;

TabStr:=[0,1,5,6];
TabCurr:=[2,3];
TabDate:=[4];
InitLisViewAvecListe(LVReleve, ['P','marque','debit','credit','dateOp','Libelle','id'],lignesReleves);
finally
  if LVReleve.Items.Count>0 then
    begin
      LVReleve.Items[0].Selected:=true;
      LVReleve.Items[0].Focused:=true;
    end;
  RSEcritureResize(RSEcriture);
  LVReleve.OnChange:=LVReleveChange;
end;
//GrReleveRowEnter(GrReleve,1);
end;

//procedure TRapprochementReleves.Marquageautomatique1Click(Sender: TObject);
//var
//i,j:integer;
//trouveReleve:boolean;
//begin
//    //
//    while i<=LVReleve.Items.Count-1 do
//    begin
//       trouveReleve:=false;
//       while (j<= LVRapprochement.Items.Count-1) and (not trouve)do
//       begin
//
//       inc(j);
//       end;
//       inc(i);
//    end;
//end;



procedure TRapprochementReleves.Marquageautomatique1Click(Sender: TObject);
var
i,j,idEcr,idReleve:integer;
//marqueReleve:TMarquageReleve;
trouveReleve:boolean;
result:boolean;
MarqueAuto:string;
begin
Try//finally
Try//except
//travail sur les débit
LVReleve.OnChange:=nil;
LvRapprochement.OnChange:=nil;
MarqueCourante:=RxLabMArqueCourante.Caption;
MarqueAuto:=DMImportReleve.MaxMarque(MarqueCourante);
  if(direct)then
  result:=MyInputQuery(self,'Changement de la marque courante','Indiquer la marque que vous souhaitez affecter au rapprochement bancaire',
      MarqueCourante,'',[ #33..#38, #40..#58, #60..#126],8)
  else result:=true;
  if result then
    begin
       DMImportReleve.ListeMarquageAuto.Clear;

       RxLabMArqueCourante.Caption:=MarqueCourante;
       i:=0;

        while i<= LVReleve.Items.Count-1 do
          begin
            trouveReleve:=false;
            TableGereStartTransaction(DMImportReleve.TaEcr_RappBanc);
             if(LVReleve.Items[i].SubItems[ChampMarquageReleve]='') and (StrToCurr_Lgr(LVReleve.Items[i].SubItems[ChampDebitReleve])>0)then
               begin
                j:=1;
                 while (j<=LVRapprochement.Items.Count-1)and(not trouveReleve) do
                   begin
                     if (LVRapprochement.Items[j].SubItems[ChampDebitRappr]=LVReleve.Items[i].SubItems[ChampDebitReleve])
                       and (LVRapprochement.Items[j].SubItems[ChampMarquageEcriture]='') then
                     begin
                        MarqueAuto:=DMImportReleve.MaxMarque(MarqueCourante);
                        //marquage des 2 côtés avec marque courante
                        LVRapprochement.Items[j].SubItems[ChampMarquageEcriture]:=MarqueAuto;
                        LVReleve.Items[i].SubItems[ChampMarquageReleve]:=MarqueAuto;
                        //marquer dans les tables en fonction des identifiants respectifs
                        idEcr:=StrToIntDef(LVRapprochement.Items[j].SubItems[ChampIdRapp],-1);
                        idReleve:=StrToIntDef(LVReleve.Items[i].SubItems[ChampIdReleve],-1);
                        DMImportReleve.MarquageEcriture('marqueReleve',MarqueAuto,idEcr);
                        DMImportReleve.MarquageReleve('marque',MarqueAuto,idReleve);
                        trouveReleve:=true;
                     end;
                     inc(j);
                   end;
               end;
             if(LVReleve.Items[i].SubItems[ChampMarquageReleve]='') and (StrToCurr_Lgr(LVReleve.Items[i].SubItems[ChampCreditReleve])>0)then
               begin
                j:=0;
                 while (j<=LVRapprochement.Items.Count-1)and(not trouveReleve) do
                   begin
                     if (LVRapprochement.Items[j].SubItems[ChampCreditRappr]=LVReleve.Items[i].SubItems[ChampCreditReleve])
                       and (LVRapprochement.Items[j].SubItems[ChampMarquageEcriture]='') then
                     begin
                         MarqueAuto:=DMImportReleve.MaxMarque(MarqueCourante);;
                        //marquage des 2 côtés avec marque courante
                        LVRapprochement.Items[j].SubItems[ChampMarquageEcriture]:=MarqueAuto;
                        LVReleve.Items[i].SubItems[ChampMarquageReleve]:=MarqueAuto;
                        //marquer dans les tables en fonction des identifiants respectifs
                        idEcr:=StrToIntDef(LVRapprochement.Items[j].SubItems[ChampIdRapp],-1);
                        idReleve:=StrToIntDef(LVReleve.Items[i].SubItems[ChampIdReleve],-1);
                        DMImportReleve.MarquageEcriture('marqueReleve',MarqueAuto,idEcr);
                        DMImportReleve.MarquageReleve('marque',MarqueAuto,idReleve);
                        trouveReleve:=true;
                     end;
                     inc(j);
                   end;
               end;
               inc(i);
          end;
    end;
except
   Showmessage('Le marquage automatique n''a pas pu s''effectué !!!');
   TableGereRollBack(DMImportReleve.TaEcr_RappBanc);
end;
finally
   TableGereCommit(DMImportReleve.TaEcr_RappBanc);
   DMImportReleve.QuEcr_RappBanc.Close;
   DMImportReleve.QuEcr_RappBanc.open;
   DMImportReleve.QuReleve.Close;
   DMImportReleve.QuReleve.open;
GestionBoutons;
GrGridRappBancStateChange(dsBrowse);
CbTous.State:=cbchecked;
LVReleve.OnChange:=LVReleveChange;
LvRapprochement.OnChange:=LVRapprochement_oldChange;
end;
end;

procedure TRapprochementReleves.GrGridRappBancStateChange(
  EtatGrille: TDataSetState);
begin
StateChangePartiel(EtatGrille);
  case EtatGrille of
     dsBrowse:Begin
               MarqueCourante:=DMImportReleve.MarqueCourante;
               RxLabMArqueCourante.Caption:=MarqueCourante;
               initTotaux;
               InitComboListMarque;
              End;
     dsEdit:Begin

            End;
  end;
end;

procedure TRapprochementReleves.StateChangePartiel(EtatGrille: TDataSetState);
begin
  case EtatGrille of
     dsBrowse:Begin
               EnableWinControl([BtnAnnuler,BtnFermer],True);
               BtnEnregistrer.Enabled:=false;
               BtnInserer.Enabled:=false;
               BtnInserer.Enabled := false;
               BtnSupprimer.Enabled := (DMImportReleve.QuEcr_RappBanc.RecordCount <> 0) or (DMImportReleve.QuReleve.RecordCount <> 0);
               BtnImprimer.Enabled := true;
              End;
     dsEdit:Begin
               BtnEnregistrer.Enabled:=(DMImportReleve.ListeMarquageEcritureEnCours.Count<>0)or(DMImportReleve.ListeMarquageReleveEnCours.Count<>0);
               EnableWinControl([BtnAnnuler,BtnFermer,BtnInserer],True);
               BtnInserer.Enabled := true;
               EnableWinControl([BtnImprimer],true);
            End;
  end;
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(EtatGrille);
   
end;

procedure TRapprochementReleves.PaEcrituresResize(Sender: TObject);
begin
RSEcritureResize(RSEcriture);
end;

procedure TRapprochementReleves.PaReleveResize(Sender: TObject);
begin
RSEcritureResize(RSEcriture);
end;

procedure TRapprochementReleves.PaGrilleResize(Sender: TObject);
begin
RSEcritureResize(RSEcriture);
end;


Function TRapprochementReleves.SommeColonneChampRempli(ListeView:TListView;Col,RowDeb,RowFin,ChampRempli:Integer):Variant;
Var
i:Integer;
Total:Extended;
Begin
Total:=0;
for i:=RowDeb to RowFin do
 Begin
   try                ////
   if (not empty(ListeView.Items[i].SubItems[ChampRempli])
     and (not empty(ListeView.Items[i].SubItems[col]))) then
         Total:=Total+StrToCurr_Lgr(ListeView.Items[i].SubItems[col]);
  except
  end;
 End;
Result:=Total;
//
End;


Function TRapprochementReleves.SommeColonneChecked(ListeView:TListView;Col,RowDeb,RowFin:integer):Variant;
Var
i:Integer;
Total:Extended;
Begin
Total:=0;
for i:=RowDeb to RowFin do
 Begin
   try                ////
   if ListeView.Items[i].Checked then
         Total:=Total+StrToCurr_Lgr(ListeView.Items[i].SubItems[col]);
  except
  end;
 End;
Result:=Total;
//
End;
//procedure TRapprochementReleves.initMarquageAuto;
//var
//i,rang:integer;
//Marquage:TMarquageReleve;
//begin
//try
//GrReleve.OnChange:=nil;
//GrGridRappBanc.OnChange:=nil;
//  for i:=0 to DMImportReleve.ListeMarquageAuto.Count-1 do
//  begin
//      Marquage:=TMarquageReleve(DMImportReleve.ListeMarquageAuto.Objects[i]);
//      if Marquage<>nil then
//      begin
//        rang:=-1;
//        if GrGridRappBanc.Find(inttostr(Marquage.IdEcriture),0,rang) then
//             GrGridRappBanc.cellsGr(1,rang,Marquage.Marque);
//        rang:=-1;
//        if GrReleve.Find(inttostr(Marquage.IdReleve),0,rang) then
//             GrReleve.cellsGr(1,rang,Marquage.Marque);
//      end;
//  end;
//GrReleveRowEnter(GrReleve,1);
//finally
//   GrReleve.OnChange:=GrReleveChange;
//   GrGridRappBanc.OnChange:=GrReleveChange;
//end;
//end;

//procedure TRapprochementReleves.initMarquageAuto;
//var
//i,rang:integer;
//Item:TListItem;
//Marquage:TMarquageReleve;
//begin
//try
////GrReleve.OnChange:=nil;
////GrGridRappBanc.OnChange:=nil;
//  for i:=0 to DMImportReleve.ListeMarquageAuto.Count-1 do
//  begin
//      Marquage:=TMarquageReleve(DMImportReleve.ListeMarquageAuto.Objects[i]);
//      if Marquage<>nil then
//      begin
//        //rang:=-1;
//        Item:= LVRapprochement.FindCaption(5,inttostr(Marquage.IdEcriture),false,true,true) ;
//        if item<>nil then
//          LVRapprochement.Items[Item.Index].SubItems.ValueFromIndex[1]:=Marquage.Marque;
//        //if GrGridRappBanc.Find(inttostr(Marquage.IdEcriture),0,rang) then
//             //GrGridRappBanc.cellsGr(1,rang,Marquage.Marque);
//        //rang:=-1;
//        Item:= LVReleve.FindCaption(5,inttostr(Marquage.IdReleve),false,true,true) ;
//         if item<>nil then
//          LVReleve.Items[Item.Index].SubItems.ValueFromIndex[1]:=Marquage.Marque;
////        if GrReleve.Find(inttostr(Marquage.IdReleve),0,rang) then
////             GrReleve.cellsGr(1,rang,Marquage.Marque);
//      end;
//  end;
////GrReleveRowEnter(GrReleve,1);
//finally
////   GrReleve.OnChange:=GrReleveChange;
////   GrGridRappBanc.OnChange:=GrReleveChange;
//end;
//end;


procedure TRapprochementReleves.CBNonMarquesClick(Sender: TObject);
begin
try//finally
LvRapprochement.OnChange:=nil;
LVReleve.OnChange:=nil;
if (CBNonMarques.State = cbchecked) then
begin
typeRapprochement:=C_NonMarques;
CBMarques.state:=cbunchecked;
CbTous.state:=cbunchecked;
GestionBoutons;
end
else
if (CBNonMarques.state=cbunchecked)and (CBMarques.state=cbunchecked)and(CbTous.state=cbunchecked)then
   CBNonMarques.state:=cbchecked;
finally
LvRapprochement.OnChange:=LVRapprochement_oldChange;
LVReleve.OnChange:=LVReleveChange;
end;
end;

procedure TRapprochementReleves.CBMarquesClick(Sender: TObject);
begin
try//finally
LvRapprochement.OnChange:=nil;
LVReleve.OnChange:=nil;
if (CBMarques.State = cbchecked) then
begin
typeRapprochement:=C_Marques;
CBNonMarques.state:=cbunchecked;
CbTous.state:=cbunchecked;
GestionBoutons;
end
else
if (CBNonMarques.state=cbunchecked)and (CBMarques.state=cbunchecked)and(CbTous.state=cbunchecked)then
   CBMarques.state:=cbchecked;
finally
LvRapprochement.OnChange:=LVRapprochement_oldChange;
LVReleve.OnChange:=LVReleveChange;
end;
end;



procedure TRapprochementReleves.CbTousClick(Sender: TObject);
begin
try//finally
LvRapprochement.OnChange:=nil;
LVReleve.OnChange:=nil;
if (CbTous.State = cbchecked) then
begin
typeRapprochement:=C_TousRapp;
CBNonMarques.state:=cbunchecked;
CBMarques.state:=cbunchecked;
GestionBoutons;
end
else
if (CBNonMarques.state=cbunchecked)and (CBMarques.state=cbunchecked)and(CbTous.state=cbunchecked)then
   CbTous.state:=cbchecked;
finally
LvRapprochement.OnChange:=LVRapprochement_oldChange;
LVReleve.OnChange:=LVReleveChange;
end;
end;


Procedure TRapprochementReleves.GestionBoutons;
begin
try//finally
LvRapprochement.OnChange:=nil;
LVReleve.OnChange:=nil;
DMImportReleve.RefreshQuery(EdBanque.Text);
InitComboListMarque;
FiltrageDataSet(DMImportReleve.QuEcr_RappBanc,'Compte = '''+EdBanque.text+'''');
FiltrageDataSet(DMImportReleve.QuReleve,'Compte = '''+EdBanque.text+'''');
InitLibelle(2,e.DatExoDebut,e.DatExoFin);
DMImportReleve.DateFinReleve:=EdDateFinReleve.Date;
    case typeRapprochement of
      C_TousRapp:begin
            DMImportReleve.QuEcr_RappBanc.OnFilterRecord:=DMImportReleve.TaEcr_FilterRecord_Tous;
            DMImportReleve.QuReleve.OnFilterRecord:=DMImportReleve.TaReleve_FilterRecord_Tous;
//            initMarquageAuto;
        end;
      C_EnCoursRapp:begin

        end;
      C_NonMarques:begin
            DMImportReleve.QuEcr_RappBanc.OnFilterRecord:=DMImportReleve.TaEcr_FilterRecord_NonMarque;
            DMImportReleve.QuReleve.OnFilterRecord:=DMImportReleve.TaReleve_FilterRecord_NonMarque;
        end;
      C_Marques:begin
              CBoxListeMarqueChange(CBoxListeMarque);
              DMImportReleve.QuEcr_RappBanc.OnFilterRecord:=DMImportReleve.TaEcr_FilterRecord_Marque;
              DMImportReleve.QuReleve.OnFilterRecord:=DMImportReleve.TaReleve_FilterRecord_Marque;
//              initMarquageAuto;
        end;
    end;//fin case
initLVReleve;
initLVRapprochement;
GrGridRappBancStateChange(dsBrowse);
finally
LvRapprochement.OnChange:=LVRapprochement_oldChange;
LVReleve.OnChange:=LVReleveChange;
end;
end;
procedure TRapprochementReleves.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TRapprochementReleves.Crationrglement1Click(Sender: TObject);
begin
//à partir d'une liste sélectionnée, créer un réglement sur le journal correspondant

end;

procedure TRapprochementReleves.GestionEcran;
begin
EdBanque.Enabled:=direct;
EdLibelle.Enabled:=direct;
EdDateFinReleve.Enabled:=direct;
if(EdBanque.Enabled)then EdBanque.SetFocus
else if(EdDateFinReleve.Enabled)then EdDateFinReleve.SetFocus
else
  begin
    EdBanqueExit(EdBanque);
  end;
end;

procedure TRapprochementReleves.InitLisViewAvecListe(ListView:TListView;TabTitreColonne:array of string;ListeValeur:TStringList);
var
j,k, NbString:integer;
Begin

//   for i:=0 to high(TabList) do
//    begin
     for j:=0 to ListeValeur.Count-1 do
      begin
        ListView.Items.Add.Caption:=str_getstringelement((ListeValeur).Strings[j],1,';');
        NbString := Str_Count_Str(';',(ListeValeur).Strings[j]);
        for k:=1 to NbString do
         begin
         if k = 1 then
           begin
               ListView.Items[ListView.Items.Count-1].SubItems.AddObject(str_getstringelement((ListeValeur).Strings[j],k,';'),
                  ListeValeur.Objects[j]);
           end
          else
           ListView.Items[ListView.Items.Count-1].SubItems.Add(str_getstringelement((ListeValeur).Strings[j],k,';'));
         end;
      end;
End;



procedure TRapprochementReleves.LVReleveResize(Sender: TObject);
begin
lvReleve.Column[6].Width:=0;
RSEcritureResize(RSEcriture);
end;

procedure TRapprochementReleves.LVRapprochement_oldResize(Sender: TObject);
begin
LVRapprochement.Column[6].Width:=0;
RSEcritureResize(RSEcriture);
end;



function TRapprochementReleves.RechercheMarquageAutoEcriture(marque:string):TListItem ;
var
i:integer;
ListItem:TListItem;
trouve:boolean;
begin
  i:=0;
  result:=nil;
  trouve:=empty(marque);
  while (i<=LVRapprochement.items.Count-1)and (trouve=false) do
   begin
     ListItem:=LVRapprochement.Items[i];
     if (ListItem.SubItems[ChampMarquageEcriture]=marque) then result:=ListItem;
     trouve:=result<>nil;
     inc(i);
   end;
end;

function TRapprochementReleves.RechercheMarquageAutoReleve(marque:string):TListItem ;
var
i:integer;
ListItem:TListItem;
trouve:boolean;
begin
  i:=0;
  trouve:=empty(marque);
  result:=nil;
  while (i<=LVReleve.items.Count-1)and (trouve=false) do
   begin
     ListItem:=LVReleve.Items[i];
     if (ListItem.SubItems[ChampMarquageReleve]=marque)then result:=ListItem;
     trouve:=result<>nil;
     inc(i);
   end;
end;

procedure TRapprochementReleves.SelectMarquageAutoEcriture(Selected:boolean);
var
i:integer;
begin
  i:=0;
  while (i<=LVRapprochement.items.Count-1)do
   begin
     LVRapprochement.Items[i].Selected:=Selected;
     inc(i);
   end;
end;

procedure TRapprochementReleves.SelectMarquageAutoReleve(Selected:boolean);
var
i:integer;
begin
  i:=0;
  while (i<=LVReleve.items.Count-1) do
   begin
     LVReleve.Items[i].Update;
     inc(i);
   end;
end;

procedure TRapprochementReleves.SelectedMarquageAutoEcriture(marque:string) ;
var
i:integer;
begin
  i:=0;
  while (i<=LVRapprochement.items.Count-1)and(not empty(marque)) do
   begin
     if (LVRapprochement.Items[i].SubItems[ChampMarquageEcriture]=marque)
       then LVRapprochement.Items[i].Selected:=true;
     inc(i);
   end;
end;





procedure TRapprochementReleves.LVRapprochement_oldSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
ListItem:TListItem;
differente:boolean;
begin
try
LVRapprochement.OnSelectItem:=nil;
LVRapprochement.OnChange:=nil;
differente:=marqueSelected<>Item.SubItems[ChampMarquageEcriture];
marqueSelected:=Item.SubItems[ChampMarquageEcriture];
if (selected)and (differente)
//and (not empty(marqueSelected))
then
  begin
  LVRapprochement.Repaint;
  LVReleve.Repaint;

  end;
finally
 LVRapprochement.OnSelectItem:=LVRapprochement_oldSelectItem;
 EdReference.Text:= TLigneRapprochement(item.SubItems.Objects[0]).REFERENCE;
 LVRapprochement.OnChange:=LVRapprochement_oldChange;
end;
end;

procedure TRapprochementReleves.LVReleveSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
ListItem:TListItem;
differente:boolean;
begin
try
LVReleve.OnSelectItem:=nil;
LVReleve.OnChange:=nil;
differente:=marqueSelected<>Item.SubItems[ChampMarquageReleve];
marqueSelected:=Item.SubItems[ChampMarquageReleve];
if (selected)and (differente)
//and (not empty(marque))
then
  begin
  LVRapprochement.Repaint;
  LVReleve.Repaint;
  end;
finally
 LVReleve.OnSelectItem:=LVReleveSelectItem;
 EdSuppl.Text:= TLigneReleve(item.SubItems.Objects[0]).SUPPLEMENT;
LVReleve.OnChange:=LVReleveChange; 
end;
end;

procedure TRapprochementReleves.LVReleveCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if (item.SubItems[ChampMarquageReleve]=marqueSelected) and (not empty(marqueSelected)) then
    begin
      Item.Selected:=false;
      LVReleve.Canvas.Brush.Color:=$00B6FDB0;
    end
  else
    LVReleve.Canvas.Brush.Color:=OldColorReleve;
Item.ImageIndex:=-1;    
end;

procedure TRapprochementReleves.FormShow(Sender: TObject);
begin
try
CbTous.OnClick:=nil;
CBNonMarques.OnClick:=nil;
CBMarques.OnClick:=nil;
typeRapprochement:=C_TousRapp;
CBNonMarques.state:=cbunchecked;
CBMarques.state:=cbunchecked;
CbTous.State:=cbChecked;
PaReleve.SetFocus;
//GestionBoutons;
self.OnCloseQuery:=FormCloseQuery;
Initialiser_ShortCut_Main(true);
PaEcritures.Width:=(pagrille.Width-3) div 2;
GestionEcran;

GestionDesColumnsRapprochement( LvRapprochement.Columns,LvRapprochement.Columns.Items[4]);
GestionDesColumnsReleve( LVReleve.Columns,LVReleve.Columns.Items[4]);
finally
 CbTous.OnClick:=CbTousClick;
 CBNonMarques.OnClick:=CBNonMarquesClick;
 CBMarques.OnClick:=CBMarquesClick;
end;
end;


function TRapprochementReleves.MarquageItemsEcritureDelete(item:TListItem;Marque:string):boolean;
var
position:integer;
begin
result:=false;
position:=item.Index;
if(Marque=C_StrVide)then
  begin
     if typeRapprochement = C_Marques then
         begin
           LVRapprochement.Items[item.Index].Delete;
           if position>=LVRapprochement.Items.Count then position:=LVRapprochement.Items.Count-1;
           if (position<= LVRapprochement.Items.Count-1)and (position>0) then
             LVRapprochement.Items[position].Selected:=true;
           result:=true;
         end
       else
       begin
         LVRapprochement.Items[item.Index].SubItems.Strings[ChampMarquageEcriture]:=Marque;
         TLigneRapprochement(LVRapprochement.Items[item.Index].SubItems.Objects[0]).MARQUE:=Marque;
         TLigneRapprochement(LVRapprochement.Items[item.Index].SubItems.Objects[0]).RAPPROCHEMENT:=MarqueCourante;
         LVRapprochement.Items[item.Index].Checked:=false;
       end;
  end
else
  begin
       if(typeRapprochement = C_NonMarques) then
         begin
           LVRapprochement.Items[item.Index].Delete;
           if position>=LVRapprochement.Items.Count then position:=LVRapprochement.Items.Count-1;
           if (position<= LVRapprochement.Items.Count-1)and (position>0) then
             LVRapprochement.Items[position].Selected:=true;
           result:=true;
         end
       else
       begin
         LVRapprochement.Items[item.Index].SubItems.Strings[ChampMarquageEcriture]:=Marque;
         TLigneRapprochement(LVRapprochement.Items[item.Index].SubItems.Objects[0]).MARQUE:=Marque;
         TLigneRapprochement(LVRapprochement.Items[item.Index].SubItems.Objects[0]).RAPPROCHEMENT:=MarqueCourante;
         LVRapprochement.Items[item.Index].Checked:=false;
       end;
  end;
end;

function TRapprochementReleves.MarquageItemsReleveDelete(item:TListItem;Marque:string):boolean;
var
position:integer;
begin
result:=false;
position:=item.Index;
if(Marque=C_StrVide)then
  begin
     if typeRapprochement = C_Marques then
         begin
           LVReleve.Items[item.Index].Delete;
           if position>=LVReleve.Items.Count then position:=LVReleve.Items.Count-1;
           if (position<= LVReleve.Items.Count-1)and (position>0) then
             LVReleve.Items[position].Selected:=true;
           result:=true;
         end
       else
       begin
         LVReleve.Items[item.Index].SubItems.Strings[ChampMarquageReleve]:=Marque;
         TLigneReleve(LVReleve.Items[item.Index].SubItems.Objects[0]).MARQUE:=Marque;
         LVReleve.Items[item.Index].Checked:=false;
       end;
  end
else
  begin
       if(typeRapprochement = C_NonMarques) then
         begin
           LVReleve.Items[item.Index].Delete;
           if position>=LVReleve.Items.Count then position:=LVReleve.Items.Count-1;
           if (position<= LVReleve.Items.Count-1)and (position>0) then
             LVReleve.Items[position].Selected:=true;
           result:=true;
         end
       else
       begin
         LVReleve.Items[item.Index].SubItems.Strings[ChampMarquageReleve]:=Marque;
         TLigneReleve(LVReleve.Items[item.Index].SubItems.Objects[0]).MARQUE:=Marque;
         LVReleve.Items[item.Index].Checked:=false;
       end;
  end;
end;

procedure TRapprochementReleves.LVRapprochement_oldDblClick(Sender: TObject);
begin
if TLigneRapprochement(LvRapprochement.ItemFocused.SubItems.Objects[0]).MARQUE='' then
   begin
     LvRapprochement.ItemFocused.Checked:=not LvRapprochement.ItemFocused.Checked;
     LvRapprochementChecked(LvRapprochement.ItemFocused);
   end;  
end;

procedure TRapprochementReleves.LVReleveDblClick(Sender: TObject);
begin
if (empty(TLigneReleve( LVReleve.ItemFocused.SubItems.Objects[0]).MARQUE))then
  begin
     LVReleve.ItemFocused.Checked:=not LVReleve.ItemFocused.Checked;
     LvReleveChecked(LVReleve.ItemFocused);
  end;
end;

procedure TRapprochementReleves.LVReleveChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
//initTotauxCoches(true);
end;

procedure TRapprochementReleves.LVRapprochement_oldChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
//initTotauxCoches(true);
end;




procedure TRapprochementReleves.outcocher1Click(Sender: TObject);
var
  I: Integer;
begin
try
LVReleve.OnChange:=nil;
LVRapprochement.OnChange:=nil;
  if ActiveControl=LVReleve then
  begin
    for I := 0 to LVReleve.Items.Count - 1 do
      if (TLigneReleve(LVReleve.Items[I].SubItems.Objects[0]).MARQUE='')then LVReleve.Items[I].Checked := True;
  end;
  if ActiveControl=LVRapprochement then
  begin
    for I := 0 to LVRapprochement.Items.Count - 1 do
      if (TLigneRapprochement(LVRapprochement.Items[I].SubItems.Objects[0]).MARQUE='')then LVRapprochement.Items[I].Checked := True;
  end;
finally
  LVReleve.OnChange:=LVReleveChange;
  LVRapprochement.OnChange:=LVRapprochement_oldChange;
initTotauxCoches(true);
end;
end;

procedure TRapprochementReleves.outdcocher1Click(Sender: TObject);
var
i:integer;
begin
try
LVReleve.OnChange:=nil;
LVRapprochement.OnChange:=nil;
if ActiveControl=LVReleve then
begin
  for I := 0 to LVReleve.Items.Count - 1 do
    LVReleve.Items[I].Checked := false;
end;
if ActiveControl=LVRapprochement then
begin
  for I := 0 to LVRapprochement.Items.Count - 1 do
    LVRapprochement.Items[I].Checked := false;
end;
finally
  LVReleve.OnChange:=LVReleveChange;
  LVRapprochement.OnChange:=LVRapprochement_oldChange;
initTotauxCoches(true);
end;
end;

procedure TRapprochementReleves.PopupMenu1Popup(Sender: TObject);
var
visible:boolean;
begin
Supprimer1.Caption:='Supprimer la marque : '+marqueSelected;
visible:=(ActiveControl=LVReleve);
  if visible then visible:=(LVReleve.ItemFocused<>nil)and (TLigneReleve(LVReleve.ItemFocused.SubItems.Objects[0])<>nil)
    and (TLigneReleve(LVReleve.ItemFocused.SubItems.Objects[0]).MARQUE='');
Supprimerlalignederelev1.Visible:=visible;
Visualisation1.Visible:=ActiveControl=LvRapprochement;
Imprimer1.Enabled:=ActiveControl=LVReleve;
end;

procedure TRapprochementReleves.LVRapprochement_oldCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if (item.SubItems[ChampMarquageEcriture]=marqueSelected) and (not empty(marqueSelected)) then
    begin
      Item.Selected:=false;
      LVRapprochement.Canvas.Brush.Color:=$00B6FDB0;
      end
  else
    LVRapprochement.Canvas.Brush.Color:=OldColorEcriture;
Item.ImageIndex:=-1;
end;

procedure TRapprochementReleves.LVRapprochement_oldKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
item:TListItem;
begin
if key=VK_SPACE then
  begin
    item:= LVRapprochement.GetNextItem(nil,sdAll,[isSelected]);
    while item<>nil do
      begin
        item.Checked:=not item.Checked;
        item:= LVRapprochement.GetNextItem(item,sdAll,[isSelected]);
      end;
initTotauxCoches(true);
Key:=0;
  end;
end;

procedure TRapprochementReleves.LVReleveKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
item:TListItem;
begin
if key=VK_SPACE then
  begin
    item:= LVReleve.GetNextItem(nil,sdAll,[isSelected]);
    while item<>nil do
      begin
        item.Checked:=not item.Checked;
        item:= LVReleve.GetNextItem(item,sdAll,[isSelected]);
      end;
initTotauxCoches(true);
Key:=0;
  end;
end;

procedure TRapprochementReleves.BtnMarquesReleveClick(Sender: TObject);
begin
DMImportReleve.ToutesMarques:=true;
InitComboListMarque();
GestionBoutons;
end;

procedure TRapprochementReleves.BtnMarquesEnCoursClick(Sender: TObject);
begin
DMImportReleve.ToutesMarques:=false;
InitComboListMarque();
GestionBoutons;
end;

procedure TRapprochementReleves.BtnMarquesReleveMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
BoutonRXAgrandit(BtnMarquesReleve);
end;

procedure TRapprochementReleves.BtnMarquesReleveMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
BoutonRXDiminue(BtnMarquesReleve);
end;

procedure TRapprochementReleves.BtnMarquesEnCoursMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
BoutonRXAgrandit(BtnMarquesEnCours);
end;

procedure TRapprochementReleves.BtnMarquesEnCoursMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
BoutonRXDiminue(BtnMarquesEnCours);
end;

procedure TRapprochementReleves.LvRapprochementMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
item:TListItem;
begin
item:=LvRapprochement.GetItemAt(x,y);
if item<>nil then
  begin
      if itemLvRapprochementCoche<>item.Checked then LvRapprochementChecked(item);
  end;
end;

procedure TRapprochementReleves.LVReleveMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
item:TListItem;
begin
item:=LVReleve.GetItemAt(x,y);
if item<>nil then
  begin
      if itemLvReleveCoche<>item.Checked then LvReleveChecked(item);
  end;
end;

procedure TRapprochementReleves.Supprimerlalignederelev1Click(
  Sender: TObject);
var
item:TListItem;
begin
try
LVReleve.OnSelectItem:=nil;
LVReleve.OnChange:=nil;
if Application.MessageBox(Pchar('Confirmez-vous la suppression des lignes du rélevé sélectionnées ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
  begin
       item:=LVReleve.GetNextItem(nil,sdAll,[isSelected]);
       while (item<>nil)and(TLigneReleve(item.SubItems.Objects[0]).MARQUE='') do
         begin
           DMImportReleve.DeleteLigneReleve(TLigneReleve(item.SubItems.Objects[0]).IDENTIFIANT);
           LVReleve.Items[item.Index].Delete;
           item:=LVReleve.GetNextItem(nil,sdAll,[isSelected]);
         end;
  end;
finally
LVReleve.OnSelectItem:=LVReleveSelectItem;
LVReleve.OnChange:=LVReleveChange;
initTotaux;
end;
end;


procedure TRapprochementReleves.LvRapprochementColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTriRapprochement:=-OrdreTriRapprochement;
if Sender<>nil then
  GestionDesColumnsRapprochement((Sender as TListView).Columns,Column);
  if Column.Index in TabDate  then
   begin
      if OrdreTriRapprochement > 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortDateProcAsc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortDateProcAsc, -1);
        end;
      if OrdreTriRapprochement < 0 then
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
      if OrdreTriRapprochement > 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortCurrProcAsc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortCurrProcAsc, -1);
        end;
      if OrdreTriRapprochement < 0 then
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


procedure TRapprochementReleves.LvRapprochementCompare(Sender: TObject;
  Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTriRapprochement*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTriRapprochement*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

procedure TRapprochementReleves.LVReleveCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTriReleve*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTriReleve*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;


procedure TRapprochementReleves.GestionDesColumnsRapprochement(Columns:TListColumns;Column:TListColumn);
var
i:integer;
begin
  for i := 0 to Columns.Count - 1 do
      Columns[i].ImageIndex := -1;

  if OrdreTriRapprochement>0 then
  Column.ImageIndex:=0
  else  Column.ImageIndex:=1
end;

procedure TRapprochementReleves.GestionDesColumnsReleve(Columns:TListColumns;Column:TListColumn);
var
i:integer;
begin
  for i := 0 to Columns.Count - 1 do
      Columns[i].ImageIndex := -1;

  if OrdreTriReleve>0 then
  Column.ImageIndex:=0
  else  Column.ImageIndex:=1
end;

procedure TRapprochementReleves.Visualisation1Click(Sender: TObject);
var
PeriodeAutre_Tmp:TPeriode;
cpt:string;
Begin
try
OnActivate:=nil;
EdBanque.OnExit:=nil;
e.PeriodeAutreImpression.Retour:=true;
E.PeriodeAutreImpression.DateDeb:=0;
E.PeriodeAutreImpression.DateFin:=e.DatExoFin;
PeriodeAutre_Tmp:=E.PeriodeAutre;
e.AutrePeriode:=true;
E.PeriodeAutre:=E.PeriodeAutreImpression;
  Begin
    if (LvRapprochement.ItemFocused<>nil)and (DMImportReleve.TaEcr_RappBanc.Locate('id',
        TLigneRapprochement(LvRapprochement.ItemFocused.SubItems.Objects[0]).IDENTIFIANT,[])) then
      begin
        if not empty(DMImportReleve.TaEcr_RappBanc.findfield('Tiers').asstring)then
          begin//si tiers
             if DetailEcritureTiers(DMImportReleve.TaEcr_RappBanc.findfield('Tiers').asstring,false) then
               case DetailEcr.Tag of
                  1:begin
                    if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMImportReleve.TaEcr_RappBanc.findfield('ID_Piece').AsInteger,[]) then
                      PieceEcritureTiers;
                    end;
               end;//fin du case
          end//fin si tiers
        else
          Begin//si compte pointable
             if DetailEcritureCompte(DMImportReleve.TaEcr_RappBanc.findfield('compte').asstring,false,false) then
               case DetailEcr.Tag of
                  2:begin
                    if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMImportReleve.TaEcr_RappBanc.findfield('ID_Piece').AsInteger,[]) then
                      PieceEcritureCompte;
                    end;
               end;//fin du case
          End;//fin si compte pointable
      end;
  end;
Finally
    E.PeriodeAutre:=PeriodeAutre_Tmp;
    E.AutrePeriode:=PeriodeAutre_Tmp.Retour;
    OnActivate:=FormActivate;
    EdBanque.OnExit:=EdBanqueExit;
end;
end;


procedure TRapprochementReleves.BtnImprimerClick(Sender: TObject);
begin
   EditionEtatPointageReleveL(EdBanque.Text,C_EditionSimple,typeRapprochement,DMImportReleve.QuReleve);
end;

procedure TRapprochementReleves.LvRapprochementChecked(item:TListItem);
begin
  if item<>nil then
  begin
      if TLigneRapprochement(item.SubItems.Objects[0]).MARQUE<>'' then
        begin
          item.Checked:=false;
        end;
//      item.focused:=item.Checked;
//      item.Selected:=item.Checked;
     initTotauxCoches(true);
  end;
end;

procedure TRapprochementReleves.LvReleveChecked(item:TListItem);
begin
  if item<>nil then
  begin
      if TLigneReleve(item.SubItems.Objects[0]).MARQUE<>'' then
        begin
          item.Checked:=false;
        end;
//      item.focused:=item.Checked;
//      item.Selected:=item.Checked;
      initTotauxCoches(true);
  end;
end;


procedure TRapprochementReleves.LVReleveMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
item:Tlistitem;
begin
item:=LVReleve.GetItemAt(x,y);
if item<>nil then
  itemLvReleveCoche:=item.Checked;
end;

procedure TRapprochementReleves.LvRapprochementMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
item:Tlistitem;
begin
item:=LvRapprochement.GetItemAt(x,y);
if item<>nil then
  itemLvRapprochementCoche:=item.Checked;
end;

procedure TRapprochementReleves.LVReleveColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTriReleve:=-OrdreTriReleve;
if Sender<>nil then
  GestionDesColumnsReleve((Sender as TListView).Columns,Column);
  if Column.Index in TabDate  then
   begin
      if OrdreTriReleve > 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortDateProcAsc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortDateProcAsc, -1);
        end;
      if OrdreTriReleve < 0 then
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
      if OrdreTriReleve > 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortCurrProcAsc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortCurrProcAsc, -1);
        end;
      if OrdreTriReleve < 0 then
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


procedure TRapprochementReleves.CreerReglement1Click(Sender: TObject);
begin
GestionBoutons;
end;





Initialization
  lignesReleves:=TStringList.create;
  LignesRapprochement:=TStringList.create;



Finalization
  lignesReleves.free;
  LignesRapprochement.free;
end.

