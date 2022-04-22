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
unit CreationReglementReleve;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, GrGrid, StdCtrls, RXCtrls, jpeg, ExtCtrls, RXSplit,
  DBGrids, RXDBCtrl, ExRxDBGrid, E2_Librairie_Obj,GrDBGrid,
  DmImportReleves,E2_Decl_Records,Gr_Librairie_Obj, Mask, DBCtrls,DB, Menus,
  ToolEdit, ComCtrls, ImgList, CSDBGrid;

type




  TCreationReglementReleves = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    Panel1: TPanel;
    Label6: TLabel;
    RxSpeedButton3: TRxSpeedButton;
    EdBanque: TEdit;
    EdLibelle: TEdit;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnCreerReglement: TButton;
    BtnInserer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaGrille: TPanel;
    PaReleve: TPanel;
    PaCumul1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel7: TPanel;
    Label4: TLabel;
    PaTools: TPanel;
    RxSpeedButton4: TRxSpeedButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Panel14: TPanel;
    Panel15: TPanel;
    GrMouvementReleve: TGrGrid;
    EdDateFinReleve: TDateEdit;
    Label9: TLabel;
    Panel16: TPanel;
    Panel17: TPanel;
    GrSoldeReleve: TGrGrid;
    GrCochesReleve: TGrGrid;
    N3: TMenuItem;
    Supprimerlalignederelev1: TMenuItem;
    ImageList1: TImageList;
    N4: TMenuItem;
    CreerReglement1: TMenuItem;
    DBGridReleve: TGrDBGrid;
    CBEnCours: TCheckBox;
    CbAbandon: TCheckBox;
    Abandonnertoutesleslignes1: TMenuItem;
    EdSuppl: TDBEdit;
    Rechercher1: TMenuItem;
    Label1: TLabel;
    cbMarquage: TCheckBox;
    RxLabMArqueCourante: TRxLabel;
    BtnSupprimer: TButton;
    checkUneLigne: TCheckBox;
    ChAfficheChoix: TCheckBox;
 //   Procedure DaRappBancStateChange(Sender: TObject);
    Procedure initTotaux;
    Procedure initTotauxCoches(changeEtat:boolean=false);
    procedure FormCreate(Sender: TObject);
    procedure EdBanqueKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Aide1Click(Sender: TObject);
    procedure RSEcritureResize(Sender: TObject);
//    procedure initGrReleve;
    procedure initLVReleve;
    Procedure InitialiseTable_A_Nil;

    procedure StateChangePartiel(EtatGrille: TDataSetState);
    procedure GrGridRappBancStateChange(EtatGrille: TDataSetState);
    Function SommeColonneChampRempli(DBGridReleve:TGrDbGrid;Col,RowDeb,RowFin,ChampRempli:Integer):Variant;
    Function SommeColonneChecked(DBGridReleve:TGrDbGrid;Col,RowDeb,RowFin:integer):Variant;

    procedure GestionBoutons;
    procedure PaBtnResize(Sender: TObject);

    procedure GestionEcran;

    procedure FormShow(Sender: TObject);

    procedure GestionDesColumnsReleve(Columns:TListColumns;Column:TListColumn);

    procedure BtnImprimerClick(Sender: TObject);

    procedure BtnInsererClick(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure Supprimerlalignederelev1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure CreerReglement1Click(Sender: TObject);
    Function DeAffectationEnCours(AfficheMessage:boolean):TExceptLGR;
    procedure GestionFiltrageParamCpt;
    procedure CBEnCoursClick(Sender: TObject);
    procedure CbAbandonClick(Sender: TObject);
    Function RechercherAffectationEnCours():integer;
    procedure Abandonnertoutesleslignes1Click(Sender: TObject);
    procedure DBGridReleveColExit(Sender: TObject);
    procedure DataReleveStateChange(Sender: TObject);
    procedure DBGridReleveTitleClick(Column: TColumn);
    procedure Rechercher1Click(Sender: TObject);
    procedure cbMarquageClick(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGridReleveKeyPress(Sender: TObject; var Key: Char);
    procedure initialiseTitleCpt();
  private
    { Déclarations privées }
        MarqueCourante,marqueSelected : string;
        cptEstTiers:boolean;

         Procedure InitLibelle(NumAffichage:Integer;DateDeb,DateFin:Tdate);
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    TypeAffichage:integer;
     ChampCompteReleve:integer;
     ChampDebitReleve,ChampCreditReleve:integer;
     ChampIdReleve:integer;
     Direct:boolean;
     TabStr,TabCurr,TabDate : set of Byte;

  end;


var
  CreationReglementReleves: TCreationReglementReleves;
  typeRapprochement:TtypeRapprochement;
  OrdreTriRapprochement,OrdreTriReleve:integer;
  lignesReleves,LignesRapprochement:TStringlist;
  OldColorEcriture,OldColorReleve:Tcolor;
  itemLvReleveCoche:boolean;
  liste:TstringList;

  function CreationReglementRelevesAffiche(ParamAfficheReleve:TParamAfficheReleve):integer;


implementation

uses   LibZoneSaisie, DMRecherche,
   LibSQL,  DMPlanCpt, DMPiece,
  E2_AideCompte, E2_AideModel,Registry, LibGestionParamXML, DMConstantes,
  E2_Main, InputQueryFrm_F, lib_chaine, Lib1, ImportReleve,
  DMRapprochementBancaire, DMEcriture, E2_DetailEcr, DMPointages2,
  E2_LibInfosTable,DBTables, E2_Recherche, DBClient;

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
procedure TCreationReglementReleves.FormCreate(Sender: TObject);
Var
 Registre :TRegistry;
begin
  if DMImportReleve = nil then
    DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
  TitreForm := 'Création réglement sur relevé';
  liste:=Tstringlist.create;
  try
    LibGestionParamXML.InitialiseForm(E.User,Self);
  except
    InitialiseFormPosDefaut(self);
  end;
   cptEstTiers:=true;
  OldColorReleve:=DBGridReleve.Canvas.Brush.Color;

end;

function CreationReglementRelevesAffiche(ParamAfficheReleve:TParamAfficheReleve):integer;
var
k:integer;
begin
if (CreationReglementReleves <> nil) then
begin
   CreationReglementReleves.Destroy;
   CreationReglementReleves:=nil;
end;
 if (CreationReglementReleves = nil) then CreationReglementReleves:=TCreationReglementReleves.Create(application.MainForm);
 CreationReglementReleves.EdBanque.OnExit:=nil;
 CreationReglementReleves.TitreForm:='Création des réglements sur relevé';
 CreationReglementReleves.Caption:=CreationReglementReleves.TitreForm;
 DMImportReleve.listeMarqueEnCours.Clear;
  DMImportReleve.ToutesMarques:=false;
  DMImportReleve.MarqueCourante:=ParamAfficheReleve.Marque;
// CreationReglementReleves.TitreForm:=ParamAfficheReleve.Titre;
 CreationReglementReleves.Direct:=ParamAfficheReleve.Direct;
 CreationReglementReleves.EdDateFinReleve.Date:=ParamAfficheReleve.DateFinReleve;
 CreationReglementReleves.MarqueCourante:=ParamAfficheReleve.Marque;
 CreationReglementReleves.EdBanque.Text:=ParamAfficheReleve.Journal;

 CreationReglementReleves.EdLibelle.Text:=ParamAfficheReleve.libelleJournal;


CreationReglementReleves.GrMouvementReleve.ParamColor:=true;
CreationReglementReleves.GrMouvementReleve.Param:=ParamUtil.CouleurDBGrid;
CreationReglementReleves.GrMouvementReleve.DessineContourLigne:=false;
CreationReglementReleves.GrMouvementReleve.UpDateColor;

CreationReglementReleves.GrSoldeReleve.ParamColor:=true;
CreationReglementReleves.GrSoldeReleve.Param:=ParamUtil.CouleurDBGrid;
CreationReglementReleves.GrSoldeReleve.DessineContourLigne:=false;
CreationReglementReleves.GrSoldeReleve.UpDateColor;

CreationReglementReleves.GrCochesReleve.ParamColor:=true;
CreationReglementReleves.GrCochesReleve.Param:=ParamUtil.CouleurDBGrid;
CreationReglementReleves.GrCochesReleve.DessineContourLigne:=false;
CreationReglementReleves.GrCochesReleve.UpDateColor;

DMImportReleve.CompteReglement:=ParamAfficheReleve.Journal;
DMImportReleve.tiersCourant:='';
CreationReglementReleves.ChampCompteReleve:=6;
CreationReglementReleves.ChampDebitReleve:=2;
CreationReglementReleves.ChampCreditReleve:=3;
result:=0;
//SetLength(FArrow,256);
//  FArrowShade := clBtnShadow;
//  FArrowHighlight := clWhite;
for k:=1 to CreationReglementReleves.DBGridReleve.ColCount-2 do
  liste.Add(CreationReglementReleves.DBGridReleve.Columns.Items[k].FieldName);

if DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(application.MainForm);
if CreationReglementReleves.Direct then
CreationReglementReleves.Show
else
result:=CreationReglementReleves.ShowModal;

end;


Procedure TCreationReglementReleves.initTotaux;
var
SoldeDebit,SoldeCredit:Currency;
TotauxRappBanc:TTotauxRappBanc;
Begin
//releve
case typeRapprochement of
C_abandonne:begin
SoldeDebit:=0;
SoldeCredit:=0;
GrMouvementReleve.Cells[0,0]:=e.FormatCurrSansDevise(0);
GrMouvementReleve.Cells[1,0]:=e.FormatCurrSansDevise(0);
GrSoldeReleve.Cells[0,0]:=e.FormatCurrSansDevise(SoldeDebit);
GrSoldeReleve.Cells[1,0]:=e.FormatCurrSansDevise(SoldeCredit);
end;
C_EnCoursRapp:begin
TotauxRappBanc.TotalMvtCompteDebit:=SommeColonneChampRempli(DBGridReleve,ChampDebitReleve,0,DBGridReleve.RowCount-1,ChampCompteReleve);
TotauxRappBanc.TotalMvtCompteCredit:=SommeColonneChampRempli(DBGridReleve,ChampCreditReleve,0,DBGridReleve.RowCount-1,ChampCompteReleve);
SoldeDebit:=TotauxRappBanc.TotalMvtCompteDebit ;
SoldeCredit:=TotauxRappBanc.TotalMvtCompteCredit;
DetermineSolde(SoldeDebit,SoldeCredit);
GrMouvementReleve.Cells[0,0]:=e.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteDebit);
GrMouvementReleve.Cells[1,0]:=e.FormatCurrSansDevise(TotauxRappBanc.TotalMvtCompteCredit);
GrSoldeReleve.Cells[0,0]:=e.FormatCurrSansDevise(SoldeDebit);
GrSoldeReleve.Cells[1,0]:=e.FormatCurrSansDevise(SoldeCredit);
end;
end;
initTotauxCoches;
End;

Procedure TCreationReglementReleves.initTotauxCoches(changeEtat:boolean);
var
SoldeDebit,SoldeCredit:Currency;
TotauxRappBanc:TTotauxRappBanc;
Begin

//releve
SoldeDebit:=SommeColonneChecked(DBGridReleve,ChampDebitReleve,0,DBGridReleve.RowCount-1);
SoldeCredit:=SommeColonneChecked(DBGridReleve,ChampCreditReleve,0,DBGridReleve.RowCount-1);
DetermineSolde(SoldeDebit,SoldeCredit);
GrCochesReleve.Cells[0,0]:=e.FormatCurrSansDevise(SoldeDebit);
GrCochesReleve.Cells[1,0]:=e.FormatCurrSansDevise(SoldeCredit);
if (BtnCreerReglement.Enabled=false)and((SoldeDebit+SoldeCredit<>0)or(DMImportReleve.ListeMarquageReleveEnCours.Count<>0)) then
  StateChangePartiel(dsedit);
End;

Procedure TCreationReglementReleves.InitLibelle(NumAffichage:Integer;DateDeb,DateFin:Tdate);
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

procedure TCreationReglementReleves.EdBanqueKeyPress(Sender: TObject;
  var Key: Char);
begin
if key = #13 then
 begin
  key := #9;
 end;
end;

procedure TCreationReglementReleves.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TCreationReglementReleves.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TCreationReglementReleves.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TCreationReglementReleves.BtnModifierClick(Sender: TObject);
begin
  TableGereEdit(DMImportReleve.TaReleveReglement );
end;

procedure TCreationReglementReleves.BtnFermerClick(Sender: TObject);
begin
self.ModalResult:=mrOk;
self.close;
end;

procedure TCreationReglementReleves.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
retour:integer;
begin
if DMImportReleve <> nil then
 begin
   typeRapprochement:=C_EnCoursRapp;
   CBEnCours.Checked:=true;
     //s'il y a des marquages en cours, demander si on veut les valider
   if (RechercherAffectationEnCours>0)then
     begin
        self.WindowState:=wsNormal;
        self.BringToFront;
        canclose:= application.MessageBox(Pchar('Voulez-vous annuler les affectations en cours ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes;
        if canclose then
          begin
           if DeAffectationEnCours(true).retour then
             canclose:=true
           else
             canclose:=false;
          end
           else canclose:=false;
     End; // Fin utilisateur est en mode Modification
  end;//fin si DMRappBanc <> nil
if CanClose then
  begin
    InitialiseTable_A_Nil;
    DMImportReleve.ListeMarquageEcritureEnCours.Clear;
    DMImportReleve.ListeMarquageReleveEnCours.Clear;
    DMImportReleve.ListeMarquageAuto.Clear;
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
//CreationReglementReleves.Destroy;
end;

Procedure TCreationReglementReleves.InitialiseTable_A_Nil;
Begin
if DMRappBanc<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMImportReleve.DaEcr_RappBanc,DMImportReleve.TaEcr_RappBanc,DMImportReleve.DaReleve,DMImportReleve.TaReleve
  ,DMImportReleve.DaComptesBancaires,DMImportReleve.DataReleve,DMImportReleve.TaEcrTemp,DMImportReleve.TaReleveTemp,DMImportReleve.TaComptesBancaire,DMImportReleve.TaCompteBancaireTemp
  ,DMImportReleve.TaReleveReglement]);
End;

procedure TCreationReglementReleves.FormDestroy(Sender: TObject);
begin

//  LibGestionParamXML.DestroyForm(Self,E.USer);

  if DMImportReleve <> nil then
    DMImportReleve.Destroy;
  CreationReglementReleves := nil;
end;

procedure TCreationReglementReleves.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if(DBGridReleve<>nil)then
WinSuivPrec(Handle,key,[DBGridReleve,DBGridReleve.InplaceEditor]);
     If Key = VK_ESCAPE Then
     Begin
         if ((DBGridReleve.Focused)) and (direct )then
            begin
              EdBanque.SetFocus ;
            end
            else Self.Close;
     End;
end;


procedure TCreationReglementReleves.Aide1Click(Sender: TObject);
begin

if (activeControl = DBGridReleve)and(DBGridReleve.SelectedField.FieldName='cptTiers') then
 begin
    MessDerSub:=false;
//    GestionFiltrageParamCpt;
    DMPieces.GestionFiltrageParamCptSurCompte(EdBanque.Text);
    DBGridReleve.EditorMode:=true;
    if(cptEstTiers)then
      AideCompteDansContexte(DBGridReleve.InplaceEditor.Text,DBGridReleve.InplaceEditor,['Rac1'],true,MessDerSub,false,true,true,true,1)
    else
      AideCompteDansContexte(DBGridReleve.InplaceEditor.Text,DBGridReleve.InplaceEditor,['Rac1'],true,MessDerSub,false,true,true,true,0);

    if(DBGridReleve.InplaceEditor.Text<>'')then
    begin
      TableGereEdit(DBGridReleve.DataSource.DataSet);
      DBGridReleve.Fields[ChampCompteReleve].AsString:= DBGridReleve.InplaceEditor.Text;
      //TableGerePost(DBGridReleve.DataSource.DataSet);
     // DBGridReleve.SelectedField.AsString:= DBGridReleve.InplaceEditor.Text;
      //cptEstTiers:=str_commence_par(DBGridReleve.InplaceEditor.Text,'+');
     // initialiseTitleCpt;
    end;
  //AideModelAfficheJournauxBanque(EdBanque,True);
 end;
end;

procedure TCreationReglementReleves.RSEcritureResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([CBEnCours,CbAbandon],PaTools,90,0,5);

WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);
FormateTailleColonne(DBGridReleve,20,[1,2,2,2,5,5,3]);

// Grilles d'en bas

Panel15.Width:=RenvoiTailleColonne(DBGridReleve,[0,1,2,3,4])+1;
GrMouvementReleve.ColWidths[0]:=DBGridReleve.Columns[4].Width;
GrMouvementReleve.ColWidths[1]:=DBGridReleve.Columns[5].Width;

Panel17.Width:=RenvoiTailleColonne(DBGridReleve,[0,1,2,3,4])+1;
GrSoldeReleve.ColWidths[0]:=DBGridReleve.Columns[4].Width;
GrSoldeReleve.ColWidths[1]:=DBGridReleve.Columns[5].Width;

Panel4.Width:=RenvoiTailleColonne(DBGridReleve,[0,1,2,3,4])+1;
GrCochesReleve.ColWidths[0]:=DBGridReleve.Columns[4].Width;
GrCochesReleve.ColWidths[1]:=DBGridReleve.Columns[5].Width;

end;

procedure TCreationReglementReleves.initLVReleve;
begin
ChampCompteReleve:=6;
ChampDebitReleve:=2;
ChampCreditReleve:=3;
DBGridReleve.DataSource.OnStateChange:=CreationReglementReleves.DataReleveStateChange;

end;

//procedure TCreationReglementReleves.initLVReleve;
//var
//LigneReleve:TLigneReleve;
//begin
//try
//LVReleve.OnChange:=nil;
//LVReleve.OnChanging:=nil;
//ChampMarquageReleve:=4;
//ChampDebitReleve:=1;
//ChampCreditReleve:=2;
//ChampIdReleve:=5;
//lignesReleves.clear;
//LVReleve.clear;
//DMImportReleve.QuReleve.first;
//while(not DMImportReleve.QuReleve.Eof)do
//begin
//   LigneReleve:=TLigneReleve.Create(self);
//   LigneReleve.IDENTIFIANT:=DMImportReleve.QuReleve.findfield('id').AsInteger;
//   LigneReleve.COMPTE:=DMImportReleve.QuReleve.findfield('compte').AsString;
//   LigneReleve.DATEOP:=DMImportReleve.QuReleve.findfield('dateOp').AsDateTime;
//   LigneReleve.DEBIT:=DMImportReleve.QuReleve.findfield('debit').AsCurrency;
//   LigneReleve.CREDIT:=DMImportReleve.QuReleve.findfield('credit').AsCurrency;
//   LigneReleve.DESIGNATION:=DMImportReleve.QuReleve.findfield('designation').AsString;
//   LigneReleve.SUPPLEMENT:=DMImportReleve.QuReleve.findfield('supplement').AsString;
//   LigneReleve.REFERENCE:=DMImportReleve.QuReleve.findfield('reference').AsString;
//   LigneReleve.MARQUE:=DMImportReleve.QuReleve.findfield('marque').AsString;
//   LigneReleve.RAPPROCHEMENT:=DMImportReleve.QuReleve.findfield('Rapprochement').AsString;
//   LigneReleve.ID_ECRITURE:=DMImportReleve.QuReleve.findfield('id_ecriture').AsInteger;
//   LigneReleve.CPTTIERS:=DMImportReleve.QuReleve.findfield('CptTiers').AsString;
//   lignesReleves.AddObject(
//                           e.FormatCurrSansDevise(DMImportReleve.QuReleve.findfield('debit').AsCurrency)+';'+
//                           e.FormatCurrSansDevise(DMImportReleve.QuReleve.findfield('credit').AsCurrency)+';'+
//                           DMImportReleve.QuReleve.findfield('dateOp').AsString+';'+
//                           DMImportReleve.QuReleve.findfield('Designation').AsString+';'+
//                           DMImportReleve.QuReleve.findfield('CptTiers').AsString+';'+
//                           DMImportReleve.QuReleve.findfield('id').AsString+';'+
//                           DMImportReleve.QuReleve.findfield('id_ecriture').AsString+';'
//                           ,LigneReleve);
//   DMImportReleve.QuReleve.next;
//end;
//OrdreTriReleve:=1;
//
//TabStr:=[0,4,5,6,7];
//TabCurr:=[1,2];
//TabDate:=[3];
//InitLisViewAvecListe(LVReleve, ['A','debit','credit','dateOp','Libelle','cpt/Tiers','id','id_ecriture'],lignesReleves);
//finally
//  if LVReleve.Items.Count>0 then
//    begin
//      LVReleve.Items[0].Selected:=true;
//      LVReleve.Items[0].Focused:=true;
//    end;
//  RSEcritureResize(RSEcriture);
//  LVReleve.OnChange:=LVReleveChange;
//end;
////GrReleveRowEnter(GrReleve,1);
//end;





procedure TCreationReglementReleves.GrGridRappBancStateChange(
  EtatGrille: TDataSetState);
begin
StateChangePartiel(EtatGrille);
  case EtatGrille of
     dsBrowse:Begin
               initTotaux;
              End;
     dsEdit:Begin

            End;
  end;
  ChangementEtatGrille(DBGridReleve);
end;

procedure TCreationReglementReleves.StateChangePartiel(EtatGrille: TDataSetState);
begin
  case EtatGrille of
     dsBrowse:Begin
               EnableWinControl([BtnAnnuler,BtnFermer,BtnInserer],True);
//               BtnEnregistrer.Enabled:=false;
               BtnSupprimer.Enabled := (DMImportReleve.TaReleveReglement.RecordCount <> 0);
               BtnImprimer.Enabled := true;
              End;
     dsEdit:Begin
//               BtnEnregistrer.Enabled:=true;
               EnableWinControl([BtnAnnuler,BtnFermer,BtnInserer],True);
               EnableWinControl([BtnImprimer],true);
            End;
  end;
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;

   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(EtatGrille);

end;

procedure TCreationReglementReleves.DataReleveStateChange(Sender: TObject);
begin
  case DBGridReleve.DataSource.State of
     dsBrowse:Begin
               EnableWinControl([BtnAnnuler,BtnFermer,BtnInserer],True);
//               BtnEnregistrer.Enabled:=false;
               BtnSupprimer.Enabled := (DMImportReleve.TaReleveReglement.RecordCount <> 0);
               BtnImprimer.Enabled := true;
              End;
     dsEdit:Begin
//               BtnEnregistrer.Enabled:=true;
               EnableWinControl([BtnAnnuler,BtnFermer,BtnInserer],True);
               EnableWinControl([BtnImprimer],true);
            End;
  end;
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;

   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DBGridReleve.DataSource.State);
initTotaux;
end;


Function TCreationReglementReleves.SommeColonneChampRempli(DBGridReleve:TGrDbGrid;Col,RowDeb,RowFin,ChampRempli:Integer):Variant;
Var
i:Integer;
Total:Extended;
Requete:TQuery;
Begin
try
Total:=0;
Requete:=TQuery.Create(self);
Requete.DatabaseName:=DM_C_NomAliasDossier;
requete.sql.Clear;
requete.SQL.Add('select Abandon,dateOp,Debit,Credit,designation,cptTiers,id_ecriture,marque,Rapprochement from ta_releveBancaire');
requete.OnFilterRecord:=DMImportReleve.TaReleveReglement_FilterRecord_CptRempli;
requete.Filtered:=true;
requete.Open;
requete.First;

while (not requete.eof)do
 Begin
   try                   ////
   if (not empty(requete.Fields[ChampRempli].AsString)
     and (not empty(requete.Fields[col].AsString))) then
         Total:=Total+requete.Fields[col].AsCurrency;
   requete.next;
  except
  end;
 End;
Result:=Total;
finally
//
end;
End;


Function TCreationReglementReleves.SommeColonneChecked(DBGridReleve:TGrDbGrid;Col,RowDeb,RowFin:integer):Variant;
Var
i:Integer;
Total:Extended;
Begin
Total:=0;
for i:=RowDeb to RowFin do
 Begin
   try                ////
//   if ListeView.Items[i].Checked then
//         Total:=Total+StrToCurr_Lgr(ListeView.Items[i].SubItems[col]);
  except
  end;
 End;
Result:=Total;
//
End;







Procedure TCreationReglementReleves.GestionBoutons;
begin
try//finally
TableGereClose(DMImportReleve.TaReleveReglement);
FiltrageDataSet(DMImportReleve.TaReleveReglement,'Compte = '''+EdBanque.text+'''');
InitLibelle(2,e.DatExoDebut,e.DatExoFin);
DMImportReleve.DateFinReleve:=EdDateFinReleve.Date;
DMImportReleve.TaReleveReglement.OnFilterRecord:=DMImportReleve.TaReleveReglement_FilterRecord_EnCours ;
    case typeRapprochement of
      C_abandonne:begin
            DBGridReleve.Columns[5].ReadOnly:=true;
            CreerReglement1.Enabled:=false;
            Insrer1.Enabled:=false;
            Supprimer1.Enabled:=false;
            Supprimerlalignederelev1.Caption:='Déplacer vers "règlements en cours"';
            Abandonnertoutesleslignes1.Caption:='Tout déplacer vers "règlements en cours"';
            DMImportReleve.TaReleveReglement.OnFilterRecord:=DMImportReleve.TaReleveReglement_FilterRecord_Abandonne;
            Panel2.Caption:='Lignes abandonnées';
        end;
      C_EnCoursRapp:begin
      DBGridReleve.Columns[5].ReadOnly:=false;
            CreerReglement1.Enabled:=true;
            Insrer1.Enabled:=true;
            Supprimer1.Enabled:=true;
            Supprimerlalignederelev1.Caption:='Abandonner le réglement séléctionné';
            Abandonnertoutesleslignes1.Caption:='Abandonner les réglements du relevé';
            DMImportReleve.TaReleveReglement.OnFilterRecord:=DMImportReleve.TaReleveReglement_FilterRecord_EnCours;
            Panel2.Caption:='Lignes du relevé importé';

        end;
    end;//fin case
DMImportReleve.TaReleveReglement.Open;
BtnSupprimer.Caption:=Supprimerlalignederelev1.Caption;
initLVReleve;
GrGridRappBancStateChange(dsBrowse);
ChangementEtatGrille(DBGridReleve);
finally


end;
end;
procedure TCreationReglementReleves.PaBtnResize(Sender: TObject);
begin
BtnSupprimer.Left:=PaBtn.Left+5;
FormateTailleBoutton([BtnAnnuler,BtnCreerReglement,BtnInserer,BtnFermer,BtnImprimer],PaBtn,110,0);

end;


procedure TCreationReglementReleves.GestionEcran;
begin
EdBanque.Enabled:=false;
EdLibelle.Enabled:=false;
EdDateFinReleve.Enabled:=false;
DBGridReleve.SetFocus;
checkUneLigne.Checked:=true;
ChangementEtatGrille(DBGridReleve);
end;







procedure TCreationReglementReleves.FormShow(Sender: TObject);
begin
try
typeRapprochement:=C_EnCoursRapp;
PaReleve.SetFocus;
GestionBoutons;
self.OnCloseQuery:=FormCloseQuery;
Initialiser_ShortCut_Main(true);
//GestionEcran;
cptEstTiers:=true;
initialiseTitleCpt;
finally

end;
end;



procedure TCreationReglementReleves.GestionDesColumnsReleve(Columns:TListColumns;Column:TListColumn);
var
i:integer;
begin
  for i := 0 to Columns.Count - 1 do
      Columns[i].ImageIndex := -1;

  if OrdreTriReleve>0 then
  Column.ImageIndex:=0
  else  Column.ImageIndex:=1
end;


procedure TCreationReglementReleves.BtnImprimerClick(Sender: TObject);
begin
   EditionEtatPointageReleveL(EdBanque.Text,C_EditionSimple,typeRapprochement,DMImportReleve.QuReleve);
end;




procedure TCreationReglementReleves.BtnInsererClick(Sender: TObject);
begin
//prendre le compteTiers courant pour l'affecter à la ligne courante.
TableGereEdit(DBGridReleve.DataSource.DataSet);
DBGridReleve.Fields[ChampCompteReleve].AsString:=DMImportReleve.tiersCourant;
TableGerePost(DBGridReleve.DataSource.DataSet);
DBGridReleve.DataSource.DataSet.Next;
end;

procedure TCreationReglementReleves.PaGrilleResize(Sender: TObject);
begin
RSEcritureResize(nil);
end;

//procedure TCreationReglementReleves.Supprimerlalignederelev1Click(
//  Sender: TObject);
//var
//  x: word;
//  TempBookmark: TBookMark;
//begin
//  DBGridReleve.Datasource.Dataset.DisableControls;
////  with DBGridReleve.SelectedRows do
////  if Count > 0 then
//  begin
////    TempBookmark:= DBGridReleve.Datasource.Dataset.GetBookmark;
////    for x:= 0 to Count - 1 do
//    begin
////      if IndexOf(Items[x]) > -1 then
//      begin
//
////        DBGridReleve.Datasource.Dataset.Bookmark:= Items[x];
//        TableGereEdit(DBGridReleve.DataSource.DataSet);
//        if(typeRapprochement=C_abandonne)then DBGridReleve.Fields[0].AsBoolean:=false
//        else DBGridReleve.Fields[0].AsBoolean:=true;
//        TableGerePost(DBGridReleve.DataSource.DataSet);
//        //showmessage(DBGridReleve.Datasource.Dataset.Fields[5].AsString);
//      end;
//    end;
////    DBGridReleve.Datasource.Dataset.GotoBookmark(TempBookmark);
////    DBGridReleve.Datasource.Dataset.FreeBookmark(TempBookmark);
//  end;
//  DBGridReleve.Datasource.Dataset.EnableControls;
//
//
//
//end;
procedure TCreationReglementReleves.Supprimerlalignederelev1Click(
  Sender: TObject);
  var i:integer;
begin
  DBGridReleve.Datasource.Dataset.DisableControls;
for i:=0 to  DBGridReleve.SelectedRows.Count-1 do
  begin
         //GotoBookmark(Pointer(DBGridReleve.SelectedRows.Items[i]));
         DBGridReleve.Datasource.Dataset.Bookmark:=DBGridReleve.SelectedRows.Items[i];
        TableGereEdit(DBGridReleve.DataSource.DataSet);
        if(typeRapprochement=C_abandonne)then DBGridReleve.Fields[0].AsBoolean:=false
        else DBGridReleve.Fields[0].AsBoolean:=true;
        TableGerePost(DBGridReleve.DataSource.DataSet);
        //showmessage(DBGridReleve.Datasource.Dataset.Fields[5].AsString);

  end;
  DBGridReleve.Datasource.Dataset.EnableControls;



end;

procedure TCreationReglementReleves.Supprimer1Click(Sender: TObject);
begin
TableGereEdit(DBGridReleve.DataSource.DataSet);
DBGridReleve.Fields[ChampCompteReleve].AsString:='';
TableGerePost(DBGridReleve.DataSource.DataSet);
end;

procedure TCreationReglementReleves.CreerReglement1Click(Sender: TObject);
begin
//afficher un petit écran pour saisir la date, le libellé de la pièce de réglement
//puis, sur valider, renvoyer ces infos et déclencher la création du réglement.
if(checkUneLigne.State=cbChecked)then
   DMImportReleve.CreationReglementUneLigne(DBGridReleve,cbMarquage.State=cbChecked,ChAfficheChoix.State=cbChecked)
else
  DMImportReleve.CreationReglement(DBGridReleve,cbMarquage.State=cbChecked,ChAfficheChoix.State=cbChecked);

  //self.ModalResult:=mrOk;
//GestionBoutons;
//initLVReleve;
end;


Function TCreationReglementReleves.DeAffectationEnCours(AfficheMessage:boolean):TExceptLGR;
var
EtatFiltreEcr,EtatFiltreReleve:TEtatFiltre;
i:integer;
Begin
  try//try finally
    try//try except
      Initialise_ExceptLGR(result);
      result.retour:=true;
      TableGereStartTransaction(DMImportReleve.TaReleveTemp);
      //table releve
      DMImportReleve.TaReleveTemp.Open;
      DeFiltrageDataSet(DMImportReleve.TaReleveTemp);
      DMImportReleve.TaReleveTemp.Filtered := true;
      DMImportReleve.TaReleveTemp.OnFilterRecord:=DMImportReleve.TaReleveReglement_FilterRecord_AnnuleAffectation;
      DMImportReleve.TaReleveTemp.Refresh;
      DMImportReleve.TaReleveTemp.First;
      while DMImportReleve.TaReleveTemp.RecordCount<>0 do
        Begin
          TableGereEdit(DMImportReleve.TaReleveTemp);
          DMImportReleve.TaReleveTemp.FindField('cptTiers').asstring:=C_StrVide;
          TableGerePost(DMImportReleve.TaReleveTemp);
          DMImportReleve.TaReleveTemp.first;
        End;
      TableGereCommit(DMImportReleve.TaReleveTemp);
    except
       TableGereRollBack(DMImportReleve.TaReleveTemp);
       result.retour:=false;
       raise ExceptLGR.Create('Erreur lors de la suppression des affectations en cours !',1001,AfficheMessage,mtError,result);
    end;//fin du try except
  finally
    DeFiltrageDataSet(DMImportReleve.TaReleveTemp);
    gestionBoutons;
  end;//fin du try finally
End;

Function TCreationReglementReleves.RechercherAffectationEnCours():integer;
Begin
  try//try finally
    try//try except
      result:=0;
      //table releve
      DMImportReleve.TaReleveTemp.Open;
      DeFiltrageDataSet(DMImportReleve.TaReleveTemp);
      DMImportReleve.TaReleveTemp.Filtered := true;
      DMImportReleve.TaReleveTemp.OnFilterRecord:=DMImportReleve.TaReleveReglement_FilterRecord_AnnuleAffectation;
      DMImportReleve.TaReleveTemp.Refresh;
      DMImportReleve.TaReleveTemp.First;
      result:=DMImportReleve.TaReleveTemp.RecordCount;
    except
    end;//fin du try except
  finally
    DeFiltrageDataSet(DMImportReleve.TaReleveTemp);
    gestionBoutons;
  end;//fin du try finally
End;

procedure TCreationReglementReleves.GestionFiltrageParamCpt;
var
ListeCpt:TStringList;
begin
   try
   ListeCpt:=TStringList.Create;
   if AideCompte=nil then AideCompte:=TAideCompte.Create(self);
   if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);

   //ListeCpt:=DMPlan.FiltrageParamCPT(42,e.Regime);
   DMPlan.TaCompte.OnFilterRecord:=DMPointage2.TaCompteFilterRecordComptePointable;
   AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
   finally
   Initialise_TStringlist(ListeCpt,self);
   end;//fin du try finally
End;

procedure TCreationReglementReleves.CBEnCoursClick(Sender: TObject);
begin
try//finally
if (CBEnCours.State = cbchecked) then
begin
typeRapprochement:=C_EnCoursRapp;
CbAbandon.state:=cbunchecked;
GestionBoutons;
end
else
if (CBEnCours.state=cbunchecked)and(CbAbandon.state=cbunchecked)then
   CBEnCours.state:=cbchecked;
finally

end;

end;

procedure TCreationReglementReleves.CbAbandonClick(Sender: TObject);
begin
try//finally
if (CbAbandon.State = cbchecked) then
begin
typeRapprochement:=C_abandonne;
CBEnCours.state:=cbunchecked;
GestionBoutons;
end
else
if (CBEnCours.state=cbunchecked)and(CbAbandon.state=cbunchecked)then
   CbAbandon.state:=cbchecked;
finally
end;
end;

procedure TCreationReglementReleves.Abandonnertoutesleslignes1Click(
  Sender: TObject);
begin
DBGridReleve.DataSource.DataSet.First;
while (not DBGridReleve.DataSource.DataSet.Eof)do
  begin
      TableGereEdit(DBGridReleve.DataSource.DataSet);
      if(typeRapprochement=C_abandonne)then DBGridReleve.Fields[0].AsBoolean:=false
      else DBGridReleve.Fields[0].AsBoolean:=true;
      TableGerePost(DBGridReleve.DataSource.DataSet);
  end;
end;

procedure TCreationReglementReleves.DBGridReleveColExit(Sender: TObject);
var
controleSaisie:TErreurSaisie;
begin
try
controleSaisie:=DMImportReleve.CtrlSaisieReleveBancaire(DBGridReleve.SelectedField);
if controleSaisie.Retour=false then
  abort;
if(DBGridReleve.SelectedField.FieldName='cptTiers')then initTotaux;
except
   DBGridReleve.SelectedField.FocusControl;
   abort;
end;
end;

procedure TCreationReglementReleves.DBGridReleveTitleClick(
  Column: TColumn);
var
nomIndex:string;
begin
    case Column.Index of
    1:begin
           nomIndex:='compteDate';
      end;
    2,3:begin
           nomIndex:='compteMontant';
      end;    //designation_
    4:begin
           nomIndex:='designation_';
      end;
    5:begin
           nomIndex:='cptTiers_';
      end;
    end;//fin du case
if nomIndex<>'' then
   begin
     (DBGridReleve.DataSource.DataSet as TTAble).IndexName:=nomIndex;
     (DBGridReleve.DataSource.DataSet as TTAble).Refresh;
   end;
end;

procedure TCreationReglementReleves.Rechercher1Click(Sender: TObject);
var
champRecherche:string;
begin
if(DBGridReleve.DataSource.DataSet.State in [dsbrowse])then
  begin
    champRecherche:='';
    MyInputQuery_Combo(self,'Sélection du champ de recherche','Indiquer le champ sur lequel vous souhaitez effectuer une recherche',
           champRecherche,liste,'',[ ],8);
    if LowerCase(champRecherche) ='dateop' then
      Rechercher(DBGridReleve,DMImportReleve.TaReleveReglement,['dateOP','designation','cptTiers','compte','abandon',
      'id_ecriture','marque','Rapprochement'],
        ['date op','libellé','compte/tiers'],'',0);
    if LowerCase(champRecherche) ='debit' then
        Rechercher(DBGridReleve,DMImportReleve.TaReleveReglement,['debit','credit','designation','cptTiers','compte','abandon',
      'id_ecriture','marque','Rapprochement','DateOP'],
        ['Débit','Crédit','libellé','compte/tiers'],'',0);
     if LowerCase(champRecherche) ='credit' then
        Rechercher(DBGridReleve,DMImportReleve.TaReleveReglement,['credit','debit','designation','cptTiers','compte','abandon',
      'id_ecriture','marque','Rapprochement','DateOP'],
        ['Crédit','Débit','libellé','compte/tiers'],'',0);
    if LowerCase(champRecherche) ='designation' then
       Rechercher(DBGridReleve,DMImportReleve.TaReleveReglement,['designation','cptTiers','compte','abandon',
      'id_ecriture','marque','Rapprochement','DateOP'],
        ['libellé','compte/tiers'],'',0);
    if LowerCase(champRecherche) ='cpttiers' then
       Rechercher(DBGridReleve,DMImportReleve.TaReleveReglement,['cptTiers','designation','compte','abandon',
      'id_ecriture','marque','Rapprochement','DateOP'],
        ['compte/tiers','libellé'],'',0);
  end;
end;


procedure TCreationReglementReleves.cbMarquageClick(Sender: TObject);
var
legende:Tlabel;
begin
if(cbMarquage.State = cbchecked)then
  begin
      if(RxLabMArqueCourante.Caption='')then
        begin
            legende:=Tlabel.create(self);
            legende.Caption:='Indiquer la marque de rapprochement bancaire à utiliser.';
            if not MyInputQuery(self,'Marque de rapprochement bancaire',legende.Caption,
                marquecourante,'',[ #33..#38, #40..#58, #60..#126],8) then exit;
            RxLabMArqueCourante.Caption:=MarqueCourante;
        end;
  end
else RxLabMArqueCourante.Caption:='';
end;

procedure TCreationReglementReleves.ChangementEtatGrille(Sender: TObject);
begin

DBGridReleve.OnColExit:=nil;

   case DMImportReleve.TaReleveReglement.state of
   dsBrowse: begin
                                                                                                                           //,dgMultiSelect
               DBGridReleve.Options := [dgEditing,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgCancelOnExit,dgMultiSelect];
               //DBGridReleve.SetFocus;
               if DBGridReleve.InplaceEditor <> nil then
                  DBGridReleve.EditorMode:=false;
               DBGridReleve.TitreColor(true);
             end;

   dsEdit:   begin                      
               DBGridReleve.Options := [dgEditing,dgalwaysshoweditor,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgCancelOnExit];
               //DBGridReleve.SetFocus;
               DBGridReleve.TitreColor(true);
             end;

   dsInsert: begin
               DBGridReleve.Options := [dgEditing,dgalwaysshoweditor,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgCancelOnExit];
               //DBGridReleve.SetFocus;
               DBGridReleve.TitreColor(true);
             end;
   end;//fin du case.state
DBGridReleve.OnColExit:= DBGridReleveColExit;
end;

procedure TCreationReglementReleves.FormActivate(Sender: TObject);
begin
 DBGridReleve.ParamColor:=true;
 DBGridReleve.Param:=ParamUtil.CouleurDBGrid;
 DBGridReleve.UpDateColor;
 GestionEcran;
end;

procedure TCreationReglementReleves.DBGridReleveKeyPress(Sender: TObject;
  var Key: Char);
begin

if(DBGridReleve.SelectedField.FieldName='cptTiers')then
  begin
       key:=uppercase(key)[1];
      if (DBGridReleve.InplaceEditor<>nil)and not(str_commence_par(DBGridReleve.InplaceEditor.Text,'+')) then
        begin
            if empty(DBGridReleve.InplaceEditor.Text)and (key='.')then
                  begin
                    key:=#0;
                    cptEstTiers:=not cptEstTiers;
                    initialiseTitleCpt;
                  end
            else
              if(cptEstTiers)then
                begin
                   DBGridReleve.InplaceEditor.text:='+'+str_souschaine(DBGridReleve.InplaceEditor.text,DBGridReleve.InplaceEditor.SelStart,DBGridReleve.InplaceEditor.SelStart)
                     +key+str_souschaine(DBGridReleve.InplaceEditor.text,DBGridReleve.InplaceEditor.SelStart+2,DBGridReleve.InplaceEditor.SelLength) ;
                   DBGridReleve.InplaceEditor.SelStart:=length(DBGridReleve.InplaceEditor.Text);
                   key:=#0;

                end;
        end;
  end;
end;

procedure TCreationReglementReleves.initialiseTitleCpt();
begin
if(cptEstTiers)then
DBGridReleve.Columns[6].Title.Caption:='Tiers'
else
DBGridReleve.Columns[6].Title.Caption:='Compte';
end;

Initialization
  lignesReleves:=TStringList.create;
  LignesRapprochement:=TStringList.create;



Finalization
  lignesReleves.free;
  LignesRapprochement.free;
end.

