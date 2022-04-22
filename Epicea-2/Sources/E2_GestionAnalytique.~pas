{//////// le 29-04-03  Modif_Isa
j'ai modifier la fonction 'Supprimer1Click'
///////}
unit E2_GestionAnalytique;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ComCtrls, StdCtrls, ExtCtrls, Mask, DBCtrls, RXDBCtrl,
  ExRxDBGrid, GrDBGrid,LibSQL, GrGrid,Gr_Librairie_Obj,E2_Librairie_Obj,
  RXCtrls,LibZoneSaisie, Menus,db,DMConstantes,E2_LibInfosTable,E2_Recherche,dbtables,
  lib_chaine,
  DMDiocEtatBalance,DiversProjets,
  CalculResultat,
  RXSplit,DMEcriture,LibGestionParamXML, DMPlancpt,E2_Decl_Records,LibRessourceString;

const
GRANDLIVRE=1;
BALANCE=2;


type
  TGestionAnalytique = class(TForm)
    PageControl1: TPageControl;
    FenetreCreationActivite: TTabSheet;
    FenetreAffectCompte: TTabSheet;
    FenetreAffectEcriture: TTabSheet;
    FenetreResultat: TTabSheet;
    Panel7: TPanel;
    Pa_Atelier: TPanel;
    PaGrille_Activite: TPanel;
    GrDBActivite: TGrDBGrid;
    PaTitrePetit: TPanel;
    Panel2: TPanel;
    PaGrille_AffectCompte: TPanel;
    GrDB_AtelierCompte: TGrDBGrid;
    Panel10: TPanel;
    RSActiviteInverse: TRxSpeedButton;
    RSAtelierTous: TRxSpeedButton;
    RSAtelierAucun: TRxSpeedButton;
    RSAtelierInverse: TRxSpeedButton;
    ChLBActivite: TRxCheckListBox;
    ChLBAtelier: TRxCheckListBox;
    RSActiviteTous: TRxSpeedButton;
    RSActiviteAucun: TRxSpeedButton;
    PaGrilleAtelier: TPanel;
    GrDBAtelier: TGrDBGrid;
    Panel9: TPanel;
    Panel3: TPanel;
    PopupMenuActivite: TPopupMenu;
    MenuItem18: TMenuItem;
    Aideenligne3: TMenuItem;
    Aide3: TMenuItem;
    Visualisation3: TMenuItem;
    Visualisationsurpriode3: TMenuItem;
    Imprimer3: TMenuItem;
    Calculatrice3: TMenuItem;
    MenuItem25: TMenuItem;
    Enregister3: TMenuItem;
    Modifier3: TMenuItem;
    Insrer3: TMenuItem;
    Supprimer3: TMenuItem;
    Annuler3: TMenuItem;
    Fermer3: TMenuItem;
    MenuItem32: TMenuItem;
    Journal3: TMenuItem;
    PopupMenuAtelier: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Visualisationsurpriode1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    MenuItem1: TMenuItem;
    Journal1: TMenuItem;
    PaGrille_Compte: TPanel;
    GrDBComptes: TGrDBGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Affectationducompte1: TMenuItem;
    RSCompte: TRxSplitter;
    PaEcrDroit: TPanel;
    PaGrille_AffectEcriture: TPanel;
    GrDB_AtelierEcritures: TGrDBGrid;
    Panel1: TPanel;
    Panel4: TPanel;
    PaAffectation_def: TPanel;
    Gr_DBAffectation_def: TGrDBGrid;
    RSEcriture: TRxSplitter;
    PaToolsEcr: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBEcrToute: TRxSpeedButton;
    RxSBEcrAffecte: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    RxSBEcrNonAffecte: TRxSpeedButton;
    PaEcrGauche: TPanel;
    PaGrille_Ecriture: TPanel;
    GrDBEcritures: TGrDBGrid;
    PaGaucheBas: TPanel;
    RxSBAffecteToutesEcr: TRxSpeedButton;
    RxSBVideToutesEcr: TRxSpeedButton;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel11: TPanel;
    PaGrGrandLivre: TPanel;
    GrGrandLivre: TGrGrid;
    PaTitreResult: TPanel;
    TiFiltrageAffectationEcriture: TTimer;
    TiFiltrageAffectationCompte: TTimer;
    RxSBReAffecteToutesEcr: TRxSpeedButton;
    Panel12: TPanel;
    PaToolsCpt: TPanel;
    RxSBCptEcriture: TRxSpeedButton;
    Panel13: TPanel;
    RxSpeedButton3: TRxSpeedButton;
    RxSpeedButton4: TRxSpeedButton;
    RxSBCptTous: TRxSpeedButton;
    RxSBCptAffecte: TRxSpeedButton;
    RxSpeedButton8: TRxSpeedButton;
    RxSBCptNonAffecte: TRxSpeedButton;
    RxSBCptEcritureOuNon: TRxSpeedButton;
    PaBas: TPanel;
    LaFiltre: TLabel;
    Button6: TButton;
    BtnBalance: TButton;
    BtnGrandLivre: TButton;
    BtnExporter: TButton;
    PopupMenuResultat: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    cbClasse6: TCheckBox;
    cbClasse7: TCheckBox;
    Modifierlelibell1: TMenuItem;
    Modifierlelibell2: TMenuItem;
    Procedure InitChekBox;
    Procedure InitListeGestionAnal;
    procedure FormShow(Sender: TObject);
    procedure BtnGrandLivreClick(Sender: TObject);
    procedure BtnBalanceClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ChLBActiviteClickCheck(Sender: TObject);
    procedure GrGrandLivreDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RSActiviteTousClick(Sender: TObject);
    procedure RSActiviteAucunClick(Sender: TObject);
    procedure RSActiviteInverseClick(Sender: TObject);
    procedure RSAtelierTousClick(Sender: TObject);
    procedure RSAtelierAucunClick(Sender: TObject);
    procedure RSAtelierInverseClick(Sender: TObject);
    procedure BtnImprimerResultClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel7Resize(Sender: TObject);
    procedure GrDBAtelierKeyPress(Sender: TObject; var Key: Char);
    procedure DaActiviteStateChange(Sender: TObject);
    procedure DaAtelierStateChange(Sender: TObject);
    procedure DaEcriture_AnalStateChange(Sender: TObject);
    procedure DaAffect_AtelierEcritureStateChange(Sender: TObject);
    procedure DaAffect_AtelierCompteStateChange(Sender: TObject);
    procedure DaPlanAnalStateChange(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure Enregister3Click(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Modifier3Click(Sender: TObject);
    procedure Insrer3Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Supprimer3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Insrer1Click(Sender: TObject);
    procedure GrDBAtelierColExit(Sender: TObject);
    procedure GrDBActiviteColExit(Sender: TObject);
    procedure Aide3Click(Sender: TObject);
    procedure GrDBActiviteExit(Sender: TObject);
    procedure GrDBAtelierExit(Sender: TObject);
    procedure GrDB_AtelierEcrituresColExit(Sender: TObject);
    procedure GrDBEcrituresColExit(Sender: TObject);
    procedure GrDB_AtelierEcrituresExit(Sender: TObject);
    procedure GrDB_AtelierEcrituresKeyPress(Sender: TObject;
      var Key: Char);
    procedure GrDB_AtelierCompteKeyPress(Sender: TObject; var Key: Char);
    procedure Panel3Resize(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure Annuler1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure GrDB_AtelierCompteExit(Sender: TObject);
    procedure GrDB_AtelierCompteColExit(Sender: TObject);
    procedure Affectationducompte1Click(Sender: TObject);

    procedure TaEcriture_AnalAfterScroll_form(DataSet: TDataSet);
    procedure TaPlanAnalAfterScroll_form(DataSet: TDataSet);
    procedure RxSBEcrTouteClick(Sender: TObject);
    procedure RxSBEcrAffecteClick(Sender: TObject);
    procedure RxSBEcrNonAffecteClick(Sender: TObject);
    procedure PaToolsEcrResize(Sender: TObject);
    procedure RxSBCptTousClick(Sender: TObject);
    procedure RxSBCptAffecteClick(Sender: TObject);
    procedure RxSBCptNonAffecteClick(Sender: TObject);
    procedure PaGaucheBasResize(Sender: TObject);
    procedure RxSBAffecteToutesEcrClick(Sender: TObject);
    procedure RxSBVideToutesEcrClick(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure GrGrandLivreDblClick(Sender: TObject);
    procedure GrGrandLivreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrGrandLivreKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure ChangementEtat_RX_Bouton;
    procedure ToutReEnableControls;
    procedure GrDBComptesExit(Sender: TObject);
    procedure TiFiltrageAffectationEcritureTimer(Sender: TObject);
    procedure TiFiltrageAffectationCompteTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PaGaucheBasClick(Sender: TObject);

    procedure ChangementEtatTabSheet(Etat:TDataSetState);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure PaBtnResize(Sender: TObject);
    procedure RxSBReAffecteToutesEcrClick(Sender: TObject);
    procedure GrDBActiviteKeyPress(Sender: TObject; var Key: Char);
    procedure BtnImprimerClick(Sender: TObject);
    procedure PaToolsCptResize(Sender: TObject);
    procedure Panel13Resize(Sender: TObject);
    procedure RxSBCptEcritureClick(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure BtnExporterClick(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure cbClasse6Click(Sender: TObject);
    procedure Modifierlelibell1Click(Sender: TObject);
    procedure Modifierlelibell2Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    GrilleEnCours:TGrDBGrid;
    En_Modif:boolean;
  end;

var
  GestionAnalytique: TGestionAnalytique;
  CtrlEnfonce:Boolean;
  ListeID:TListInteger;
  Function CheckBoxCheckedAll(RxCheckListBox:TRxCheckListBox):boolean;
  Function CheckBoxdeCheckedAll(RxCheckListBox:TRxCheckListBox):boolean;
  Function CheckBoxInverseCheck(RxCheckListBox:TRxCheckListBox):boolean;

implementation

uses dmComptesA, dmComptesB, dmCdps ,DMGestionAnalytique, UEtatGestionAnal,
  E2_Main,DMAnalytique, E2_AideCompte, DMRecherche,DMConstAnalytique,
  E2_DetailEcr, InputQueryFrm_F;

{$R *.DFM}

Function CheckBoxCheckedAll(RxCheckListBox:TRxCheckListBox):boolean;
var
i:integer;
Begin
result:=true;
try
  for i:=0 to RxCheckListBox.Items.Count - 1 do
   begin
    RxCheckListBox.Checked[i]:=true;
   end;
except
 showmessage('Erreur sur : CheckBoxCheckedAll');
 result:=false;
end;
End;

Function CheckBoxdeCheckedAll(RxCheckListBox:TRxCheckListBox):boolean;
var
i:integer;
Begin
result:=true;
try
  for i:=0 to RxCheckListBox.Items.Count - 1 do
   begin
    RxCheckListBox.Checked[i]:=False;
   end;
except
 showmessage('Erreur sur : CheckBoxdeCheckedAll');
 result:=false;
end;
End;

Function CheckBoxInverseCheck(RxCheckListBox:TRxCheckListBox):boolean;
var
i:integer;
Begin
result:=true;
try
  for i:=0 to RxCheckListBox.Items.Count - 1 do
   begin
    RxCheckListBox.Checked[i]:=not RxCheckListBox.Checked[i];
   end;
except
 showmessage('Erreur sur : CheckBoxInverseCheck');
 result:=false;
end;

End;

//******************************************************************************
Procedure TGestionAnalytique.InitChekBox;
var
i,j,k,l:integer;
Begin
ChLBActivite.Clear;
//if not DMGestionAnal.TaCdp.Active then
//     DMGestionAnal.TaCdp.Open;
//if not DMAnalytiques.Ta_Activite.Active then
//     DMAnalytiques.Ta_Activite.Open;
ChLBAtelier.Clear;
//ChLBActivite.Items:=ChampTableVersListe('Cdp',DMGestionAnal.TaCdp);
ChLBActivite.Items:=ChampTableVersListe('Code_Activite',DMAnalytiques.Ta_Activite);
//DMGestionAnal.TaCdp.EnableControls;
DMAnalytiques.Ta_Activite.EnableControls;

{ isa  le  07/04/04 }
CheckBoxCheckedAll(ChLBActivite);
RSActiviteTousClick(nil);//RSActiviteTous
CheckBoxCheckedAll(ChLBAtelier);
{ isa  le  07/04/04 }


//// Initialisation des checkBox en fonction de la liste de DMGestionAnalytique
//for i:=0 to DMGestionAnal.ListeActiviteResult.count -1  do
// begin
//  j:=ChLBActivite.Items.IndexOf(DMGestionAnal.ListeActiviteResult.Strings[i]);
//  if j <> - 1 then
//    begin
//      ChLBActivite.Checked[j]:=true;
//      ChLBActivite.ItemIndex:=j;
//      ChLBActiviteClickCheck(ChLBActivite);
//      for k:=0 to DMGestionAnal.ListeAtelierResult.count -1  do
//       begin
//        l:=ChLBAtelier.Items.IndexOf(DMGestionAnal.ListeAtelierResult.Strings[k]);
//        if l <> - 1 then  ChLBAtelier.Checked[l]:=true;
//       end;
//    end;
// end;

// Initialisation des checkBox en fonction de la liste de DMGestionAnalytique
//for i:=0 to DMGestionAnal.ListeActiviteResult.count -1  do
// begin
//  j:=ChLBActivite.Items.IndexOf(DMGestionAnal.ListeActiviteResult.Strings[i]);
//  if j <> - 1 then
//    begin
//      ChLBActivite.Checked[j]:=true;
//      ChLBActivite.ItemIndex:=j;
//      ChLBActiviteClickCheck(ChLBActivite);
//      for k:=0 to DMGestionAnal.ListeAtelierResult.count -1  do
//       begin
//        l:=ChLBAtelier.Items.IndexOf(DMGestionAnal.ListeAtelierResult.Strings[k]);
//        if l <> - 1 then  ChLBAtelier.Checked[l]:=true;
//       end;
//    end;
// end;
End;

//******************************************************************************
Procedure TGestionAnalytique.InitListeGestionAnal;
var
i:integer;
Begin
//DMGestionAnal.ListeActiviteResult.Clear;
//DMGestionAnal.ListeAtelierResult.Clear;
//for i:=0 to ChLBActivite.Items.count -1  do
// if ChLBActivite.Checked[i] then
//   DMGestionAnal.ListeActiviteResult.Add(ChLBActivite.Items[i]);
//
//for i:=0 to ChLBAtelier.Items.count -1  do
// if ChLBAtelier.Checked[i] then
//   DMGestionAnal.ListeAtelierResult.Add(ChLBAtelier.Items[i]);

DMAnalytiques.ListeActiviteResult.Clear;
for i:=0 to ChLBActivite.Items.count -1  do
 if ChLBActivite.Checked[i] then
   DMAnalytiques.ListeActiviteResult.Add(ChLBActivite.Items[i]);

DMAnalytiques.ListeAtelierResult.Clear;
for i:=0 to ChLBAtelier.Items.count -1  do
 if ChLBAtelier.Checked[i] then
   DMAnalytiques.ListeAtelierResult.Add(ChLBAtelier.Items[i]);
cbClasse6Click(cbClasse6);
End;

//******************************************************************************
procedure TGestionAnalytique.FormShow(Sender: TObject);
begin
viderTable((GrDB_AtelierCompte.datasource.dataset as TTable));
viderTable((GrDB_AtelierEcritures.datasource.dataset as TTable));
DMAnalytiques.TaEcriture_Anal.AfterScroll:=TaEcriture_AnalAfterScroll_form;
DMAnalytiques.TaPlanAnal.AfterScroll:=TaPlanAnalAfterScroll_form;
if @DMAnalytiques.TaEcriture_Anal.OnFilterRecord=nil then
  DMAnalytiques.TaEcriture_Anal.OnFilterRecord:=DMAnalytiques.TaEcriture_AnalFilterRecord;
//DMAnalytiques.TaEcritureFilterRecord.OnFilterRecord:=DMAnalytiques.TaEcritureFilterRecordFilterRecord;
if e.ExerciceCloture then
  PageControl1.ActivePage:=FenetreResultat ;
//else
  PageControl1Change(nil);
end;


procedure TGestionAnalytique.BtnGrandLivreClick(Sender: TObject);
var
CompteTmp,AtelierTmp:String;
SousTotDebit,SousTotCredit:Currency;
TotDebit,TotCredit:Currency;
TotalAtelierCourantDebit,TotalAtelierCourantCredit:Currency;
SousTotQt1,SousTotQt2:Currency;
TotQt1,TotQt2,PU1,PU2,HTDebit,HTCredit:Currency;
TotalAtelierCourantQt1,TotalAtelierCourantQt2:Currency;
i,IndexTitre,IndexLigneAtelier:integer;
NB_Unite_Atelier:real;
begin
PaTitreResult.tag:=GRANDLIVRE;// paramètre pour impression
PaTitreResult.Caption := 'GRAND-LIVRE ANALYTIQUE';
GestionAnalytique.OnDblClick:= GestionAnalytique.GrGrandLivreDblClick;
DMAnalytiques.QuMontantEcrParAtelier.DisableControls;
DMAnalytiques.QuMontantEcrParAtelier.Close;
DMAnalytiques.QuMontantEcrParAtelier.Open;
InitListeGestionAnal;
GrGrandLivre.TextADroite := false;
for i:=1 to GrGrandLivre.RowCount-1 do
  GrGrandLivre.Rows[i].Clear;
ListeID.Clear;
IndexTitre := 0;
IndexLigneAtelier := 0;
GrGrandLivre.RowCount:=2;
ListeID.Add(0);
ListeID.Add(0);
CompteTmp:='';
AtelierTmp:='';
SousTotDebit:=0;
SousTotCredit:=0;
TotDebit:=0;
TotCredit:=0;
TotalAtelierCourantDebit:=0;
TotalAtelierCourantCredit:=0;

SousTotQt1:=0;
SousTotQt2:=0;
TotQt1:=0;
TotQt2:=0;
TotalAtelierCourantQt1:=0;
TotalAtelierCourantQt2:=0;

DMAnalytiques.QuMontantEcrParAtelier.First;
  AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString;
//  GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
  GrGrandLivre.Cells[0,IndexLigneAtelier] := 'Atelier :';
  GrGrandLivre.Cells[1,IndexLigneAtelier] := AtelierTmp;

//GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
GrGrandLivre.ColCount:= 9;
IndexTitre := GrGrandLivre.RowCount-1;
GrGrandLivre.ColWidths[0] := 90;
GrGrandLivre.ColWidths[1] :=90;
GrGrandLivre.ColWidths[2] := 125;
GrGrandLivre.ColWidths[3] := 80;
GrGrandLivre.ColWidths[4] := 80;
GrGrandLivre.ColWidths[5] := 60;
GrGrandLivre.ColWidths[6] := 80;
GrGrandLivre.ColWidths[7] := 60;
GrGrandLivre.ColWidths[8] := 80;

GrGrandLivre.Cells[0,IndexTitre] := 'Date';
GrGrandLivre.Cells[1,IndexTitre] := 'Compte';
GrGrandLivre.Cells[2,IndexTitre] := 'Désignation';
GrGrandLivre.Cells[3,IndexTitre] := 'Charges';
GrGrandLivre.Cells[4,IndexTitre] := 'Produits';
GrGrandLivre.Cells[5,IndexTitre] := 'Qté 1';
GrGrandLivre.Cells[6,IndexTitre] := 'PU 1';
GrGrandLivre.Cells[7,IndexTitre] := 'Qté 2';
GrGrandLivre.Cells[8,IndexTitre] := 'PU 2';

while not DMAnalytiques.QuMontantEcrParAtelier.EOF do
 begin
  GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
  ListeID.Add(DMAnalytiques.QuMontantEcrParAtelier.FindField('Id_Piece').AsInteger);
  CompteTmp:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Compte').AsString;
  GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Date').AsString;
  GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Compte').AsString;
  GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Libelle').AsString;
  SousTotDebit:=DMAnalytiques.QuMontantEcrParAtelier.FindField('MontantRepartiDebit').AsCurrency+SousTotDebit;
  GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',DMAnalytiques.QuMontantEcrParAtelier.FindField('MontantRepartiDebit').AsCurrency);
  SousTotCredit:=DMAnalytiques.QuMontantEcrParAtelier.FindField('MontantRepartiCredit').AsCurrency+SousTotCredit;
  GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',DMAnalytiques.QuMontantEcrParAtelier.FindField('MontantRepartiCredit').AsCurrency);
  SousTotQt1:=SousTotQt1+DMAnalytiques.QuMontantEcrParAtelier.FindField('Qt1Repartie').asfloat;
  SousTotQt2:=SousTotQt2+DMAnalytiques.QuMontantEcrParAtelier.FindField('Qt2Repartie').asfloat;

  htdebit:=DMAnalytiques.QuMontantEcrParAtelier.FindField('MontantRepartiDebit').AsCurrency;
  htCredit:=DMAnalytiques.QuMontantEcrParAtelier.FindField('MontantRepartiCredit').AsCurrency;

  Pu1:=GereDivision(DetermineSolde(htdebit,htCredit),DMAnalytiques.QuMontantEcrParAtelier.FindField('Qt1Repartie').asfloat);
  Pu2:=GereDivision(DetermineSolde(htdebit,htCredit),DMAnalytiques.QuMontantEcrParAtelier.FindField('Qt2Repartie').asfloat);

  GrGrandLivre.Cells[5,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(DMAnalytiques.QuMontantEcrParAtelier.FindField('Qt1Repartie').asfloat);
  GrGrandLivre.Cells[7,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(DMAnalytiques.QuMontantEcrParAtelier.FindField('Qt2Repartie').asfloat);

  GrGrandLivre.Cells[6,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(PU1);
  GrGrandLivre.Cells[8,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(PU2);
  NB_Unite_Atelier:=DMAnalytiques.QuMontantEcrParAtelier.FindField('NB_Unite_Atelier').Asfloat;
  //  ListeID.Add(DMAnalytiques.QuMontantEcrParAtelier.FindField('Id_Piece').AsInteger);
//  GrGrandLivre.Rows[GrGrandLivre.RowCount-1].Names(DMAnalytiques.QuMontantEcrParAtelier.FindField('ID').AsString);
  GrGrandLivre.Objects[1,GrGrandLivre.RowCount-1] :=GrGrandLivre.Rows[GrGrandLivre.RowCount-1];
  DMAnalytiques.QuMontantEcrParAtelier.Next;
  if ((compteTmp<>DMAnalytiques.QuMontantEcrParAtelier.FindField('Compte').AsString)or(AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString)) then
   begin
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    ListeID.Add(0);
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Total '+CompteTmp;
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',SousTotDebit);
    GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',SousTotCredit);
    GrGrandLivre.Cells[5,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(SousTotQt1);
    GrGrandLivre.Cells[7,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(SousTotQt2);

  htdebit:=SousTotDebit;
  htCredit:=SousTotCredit;

  Pu1:=GereDivision(DetermineSolde(htdebit,htCredit),SousTotQt1);
  Pu2:=GereDivision(DetermineSolde(htdebit,htCredit),SousTotQt2);
    GrGrandLivre.Cells[6,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(Pu1);
    GrGrandLivre.Cells[8,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(Pu2);

    TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
    TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
    TotDebit:=TotDebit+SousTotDebit;
    TotCredit:=TotCredit+SousTotCredit;

    TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
    TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
    TotQt1:=TotQt1+SousTotQt1;
    TotQt2:=TotQt2+SousTotQt2;

    SousTotDebit:=0;
    SousTotCredit:=0;
    SousTotQt1:=0;
    SousTotQt2:=0;
   end;
  if AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString then
   begin
    // Totaux de l'atelier avant changement d'atelier
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    ListeID.Add(0);
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Total Atelier :';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=AtelierTmp;
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantDebit);
    GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantCredit);

    // Affichage du solde
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+2;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Solde (ou marge) ';
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
    if TotalAtelierCourantDebit > TotalAtelierCourantCredit then
       GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantDebit-TotalAtelierCourantCredit)
     else
       GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantCredit-TotalAtelierCourantDebit);

    // Affichage Marge par unité
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Marge / Unité';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:='de Qté Atelier';
    if TotalAtelierCourantDebit > TotalAtelierCourantCredit then
       GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',GereDivision((TotalAtelierCourantDebit-TotalAtelierCourantCredit),NB_Unite_Atelier,(TotalAtelierCourantDebit-TotalAtelierCourantCredit)))
     else
       GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',GereDivision((TotalAtelierCourantCredit-TotalAtelierCourantDebit),NB_Unite_Atelier,(TotalAtelierCourantCredit-TotalAtelierCourantDebit)));

    TotalAtelierCourantDebit:=0;
    TotalAtelierCourantCredit:=0;
    TotalAtelierCourantQt1:=0;
    TotalAtelierCourantQt2:=0;


    // Nouvel Atelier
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    ListeID.Add(0);
    ListeID.Add(0);
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1] := 'Atelier :';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString;
    AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString;
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    ListeID.Add(0);
GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1] := 'Date';
GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1] := 'Compte';
GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1] := 'Désignation';
GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1] := 'Charges';
GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1] := 'Produits';
GrGrandLivre.Cells[5,GrGrandLivre.RowCount-1] := 'Qté 1';
GrGrandLivre.Cells[6,GrGrandLivre.RowCount-1] := 'PU 1';
GrGrandLivre.Cells[7,GrGrandLivre.RowCount-1] := 'Qté 2';
GrGrandLivre.Cells[8,GrGrandLivre.RowCount-1] := 'PU 2';

   end;
//  GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
 end;

 if not empty(CompteTmp) then
 begin
  TotDebit:=TotDebit+SousTotDebit;
  TotCredit:=TotCredit+SousTotCredit;
    TotQt1:=TotQt1+SousTotQt1;
    TotQt2:=TotQt2+SousTotQt2;
  GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
  ListeID.Add(0);
  GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Total '+CompteTmp;
  GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',SousTotDebit);
  GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',SousTotCredit);
  GrGrandLivre.Cells[5,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(SousTotQt1);
  GrGrandLivre.Cells[7,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(SousTotQt2);
  htdebit:=SousTotDebit;
  htCredit:=SousTotCredit;

  Pu1:=GereDivision(DetermineSolde(htdebit,htCredit),SousTotQt1);
  Pu2:=GereDivision(DetermineSolde(htdebit,htCredit),SousTotQt2);
    GrGrandLivre.Cells[6,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(Pu1);
    GrGrandLivre.Cells[8,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(Pu2);

 end;
    // Totaux du dernier atelier
    TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
    TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
    TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
    TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;

    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    ListeID.Add(0);
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Total Atelier :';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=AtelierTmp;
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantDebit);
    GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantCredit);

    // Affichage du solde
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+2;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Solde (ou marge) ';
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
    if TotalAtelierCourantDebit > TotalAtelierCourantCredit then
       GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantDebit-TotalAtelierCourantCredit)
     else
       GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantCredit-TotalAtelierCourantDebit);

    // Affichage Marge par unité
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Marge / Unité';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:='de Qté Atelier';
    if TotalAtelierCourantDebit > TotalAtelierCourantCredit then
       GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',GereDivision((TotalAtelierCourantDebit-TotalAtelierCourantCredit),NB_Unite_Atelier,(TotalAtelierCourantDebit-TotalAtelierCourantCredit)))
     else
       GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',GereDivision((TotalAtelierCourantCredit-TotalAtelierCourantDebit),NB_Unite_Atelier,(TotalAtelierCourantCredit-TotalAtelierCourantDebit)));

    TotalAtelierCourantDebit:=0;
    TotalAtelierCourantCredit:=0;
    TotalAtelierCourantQt1:=0;
    TotalAtelierCourantQt2:=0;

// Affichage du total général
GrGrandLivre.RowCount:=GrGrandLivre.RowCount+2;
GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Total ';
GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotDebit);
GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotCredit);

// Affichage du solde
GrGrandLivre.RowCount:=GrGrandLivre.RowCount+2;
GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Solde (ou marge) ';
GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
if TotDebit > TotCredit then
   GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotDebit-TotCredit)
 else
   GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotCredit-TotDebit);


DMAnalytiques.QuMontantEcrParAtelier.EnableControls;
end;

//******************************************************************************
//** Analytique du CompteB                                                    **
//******************************************************************************
procedure TGestionAnalytique.BtnBalanceClick(Sender: TObject);
var
CompteTmp,AtelierTmp:String;
SousTotDebit,SousTotCredit:Currency;
TotDebit,TotCredit:Currency;
TotalAtelierCourantDebit,TotalAtelierCourantCredit:Currency;
SousTotQt1,SousTotQt2:Currency;
TotQt1,TotQt2,PU1,PU2,HTDebit,HTCredit:Currency;
TotalAtelierCourantQt1,TotalAtelierCourantQt2:Currency;
i:integer;
IndexTitre,IndexLigneAtelier:integer;
NB_Unite_Atelier:real;
begin
PaTitreResult.tag:=BALANCE;// paramètre pour impression
PaTitreResult.Caption := 'BALANCE ANALYTIQUE';
GestionAnalytique.OnDblClick:= GestionAnalytique.GrGrandLivreDblClick;
DMAnalytiques.QuMontantEcrParAtelier.DisableControls;
DMAnalytiques.QuMontantEcrParAtelier.Close;
DMAnalytiques.QuMontantEcrParAtelier.Open;
InitListeGestionAnal;
GrGrandLivre.TextADroite := false;
for i:=1 to GrGrandLivre.RowCount-1 do
  GrGrandLivre.Rows[i].Clear;
IndexTitre := 0;
IndexLigneAtelier := 0;
GrGrandLivre.RowCount:=2;
CompteTmp:='';
AtelierTmp:='';
SousTotDebit:=0;
SousTotCredit:=0;
TotDebit:=0;
TotCredit:=0;
TotalAtelierCourantDebit:=0;
TotalAtelierCourantCredit:=0;

SousTotQt1:=0;
SousTotQt2:=0;
TotQt1:=0;
TotQt2:=0;
TotalAtelierCourantQt1:=0;
TotalAtelierCourantQt2:=0;


DMAnalytiques.QuMontantEcrParAtelier.First;
  AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString;
//  GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
  GrGrandLivre.Cells[0,IndexLigneAtelier] := 'Atelier :';
  GrGrandLivre.Cells[1,IndexLigneAtelier] := AtelierTmp;

//GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
IndexTitre := GrGrandLivre.RowCount-1;
GrGrandLivre.ColCount:= 8;
GrGrandLivre.ColWidths[0] := 96;
GrGrandLivre.ColWidths[1] := 150;
GrGrandLivre.ColWidths[2] := 100;
GrGrandLivre.ColWidths[3] := 100;
GrGrandLivre.ColWidths[4] := 60;
GrGrandLivre.ColWidths[5] := 60;
GrGrandLivre.ColWidths[6] := 60;
GrGrandLivre.ColWidths[7] := 60;

GrGrandLivre.Cells[0,IndexTitre] := 'Compte';
GrGrandLivre.Cells[1,IndexTitre] := 'Désignation';
GrGrandLivre.Cells[2,IndexTitre] := 'Total Charges';
GrGrandLivre.Cells[3,IndexTitre] := 'Total Produits';
GrGrandLivre.Cells[4,IndexTitre] := 'Qté 1';
GrGrandLivre.Cells[5,IndexTitre] := 'PU 1';
GrGrandLivre.Cells[6,IndexTitre] := 'Qté 2';
GrGrandLivre.Cells[7,IndexTitre] := 'PU 2';

while not DMAnalytiques.QuMontantEcrParAtelier.EOF do
 begin
  CompteTmp:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Compte').AsString;
  SousTotDebit:=DMAnalytiques.QuMontantEcrParAtelier.FindField('MontantRepartiDebit').AsCurrency+SousTotDebit;
  SousTotCredit:=DMAnalytiques.QuMontantEcrParAtelier.FindField('MontantRepartiCredit').AsCurrency+SousTotCredit;
  SousTotQt1:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Qt1Repartie').AsCurrency+SousTotQt1;
  SousTotQt2:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Qt2Repartie').AsCurrency+SousTotQt2;
  GrGrandLivre.Objects[1,GrGrandLivre.RowCount-1] :=GrGrandLivre.Rows[GrGrandLivre.RowCount-1];
  HTDebit:=SousTotDebit;
  HTCredit:=SousTotCredit;
  PU1:=GereDivision(DetermineSolde(HTDebit,HTCredit),SousTotQt1);
  PU2:=GereDivision(DetermineSolde(HTDebit,HTCredit),SousTotQt2);
  NB_Unite_Atelier:=DMAnalytiques.QuMontantEcrParAtelier.FindField('NB_Unite_Atelier').Asfloat;
  DMAnalytiques.QuMontantEcrParAtelier.Next;
  if ((compteTmp<>DMAnalytiques.QuMontantEcrParAtelier.FindField('Compte').AsString)or(AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString)) then
   begin
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:=CompteTmp;
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=DMPlan.LibelleDuNumCptPCU(CompteTmp);
    GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',SousTotDebit);
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',SousTotCredit);
    GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(SousTotQt1);
    GrGrandLivre.Cells[5,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(PU1);
    GrGrandLivre.Cells[6,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(SousTotQt2);
    GrGrandLivre.Cells[7,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(PU2);
    TotDebit:=TotDebit+SousTotDebit;
    TotCredit:=TotCredit+SousTotCredit;
    TotQt1:=TotQt1+SousTotQt1;
    TotQt2:=TotQt2+SousTotQt2;
    TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
    TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
    TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
    TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
    SousTotDebit:=0;
    SousTotCredit:=0;
    SousTotQt1:=0;
    SousTotQt2:=0;
   end;


  if AtelierTmp <> DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString then
   begin
    // Totaux de l'atelier avant changement d'atelier
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Total Atelier :';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=AtelierTmp;
    GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantDebit);
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantCredit);

    // Affichage du solde
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+2;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Solde (ou marge) ';
    GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);

    if TotalAtelierCourantDebit > TotalAtelierCourantCredit then
       GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantDebit-TotalAtelierCourantCredit)
     else
       GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantCredit-TotalAtelierCourantDebit);

    // Affichage Marge par unité
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Marge / Unité';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:='de Qté Atelier';
    if TotalAtelierCourantDebit > TotalAtelierCourantCredit then
       GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',GereDivision((TotalAtelierCourantDebit-TotalAtelierCourantCredit),NB_Unite_Atelier,(TotalAtelierCourantDebit-TotalAtelierCourantCredit)))
     else
       GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',GereDivision((TotalAtelierCourantCredit-TotalAtelierCourantDebit),NB_Unite_Atelier,(TotalAtelierCourantCredit-TotalAtelierCourantDebit)));

    TotalAtelierCourantDebit:=0;
    TotalAtelierCourantCredit:=0;
    TotalAtelierCourantQt1:=0;
    TotalAtelierCourantQt2:=0;


    // Nouvel Atelier
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1] := 'Atelier :';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString;
    AtelierTmp :=DMAnalytiques.QuMontantEcrParAtelier.FindField('Code_Atelier').AsString;
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;

    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Compte';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:='Désignation';
    GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:='Total Charges';
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:='Total Produits';
    GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:='Qté 1';
    GrGrandLivre.Cells[5,GrGrandLivre.RowCount-1] := 'PU 1';
    GrGrandLivre.Cells[6,GrGrandLivre.RowCount-1] := 'Qté 2';
    GrGrandLivre.Cells[7,GrGrandLivre.RowCount-1] := 'PU 2';
   end;
 end;

 if not empty(CompteTmp) then
 begin
    TotDebit:=TotDebit+SousTotDebit;
    TotCredit:=TotCredit+SousTotCredit;
    TotQt1:=TotQt1+SousTotQt1;
    TotQt2:=TotQt2+SousTotQt2;
  HTDebit:=SousTotDebit;
  HTCredit:=SousTotCredit;
  PU1:=GereDivision(DetermineSolde(HTDebit,HTCredit),SousTotQt1);
  PU2:=GereDivision(DetermineSolde(HTDebit,HTCredit),SousTotQt2);
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:=CompteTmp;
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=DMPlan.LibelleDuNumCptPCU(CompteTmp);
    GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',SousTotDebit);
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',SousTotCredit);
    GrGrandLivre.Cells[4,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(SousTotQt1);
    GrGrandLivre.Cells[5,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(PU1);
    GrGrandLivre.Cells[6,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(SousTotQt2);
    GrGrandLivre.Cells[7,GrGrandLivre.RowCount-1]:=E.FormatCurrSansDevise(PU2);
 end;
    // Totaux du dernier atelier
    TotalAtelierCourantDebit:=TotalAtelierCourantDebit+SousTotDebit;
    TotalAtelierCourantCredit:=TotalAtelierCourantCredit+SousTotCredit;
    TotalAtelierCourantQt1:=TotalAtelierCourantQt1+SousTotQt1;
    TotalAtelierCourantQt2:=TotalAtelierCourantQt2+SousTotQt2;
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Total Atelier :';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:=AtelierTmp;
    GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantDebit);
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantCredit);

    // Affichage du solde
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+2;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Solde (ou marge) ';
    GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
    GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);

    if TotalAtelierCourantDebit > TotalAtelierCourantCredit then
       GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantDebit-TotalAtelierCourantCredit)
     else
       GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotalAtelierCourantCredit-TotalAtelierCourantDebit);

    // Affichage Marge par unité
    GrGrandLivre.RowCount:=GrGrandLivre.RowCount+1;
    GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Marge / Unité';
    GrGrandLivre.Cells[1,GrGrandLivre.RowCount-1]:='de Qté Atelier';
    if TotalAtelierCourantDebit > TotalAtelierCourantCredit then
       GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',GereDivision((TotalAtelierCourantDebit-TotalAtelierCourantCredit),NB_Unite_Atelier,(TotalAtelierCourantDebit-TotalAtelierCourantCredit)))
     else
       GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',GereDivision((TotalAtelierCourantCredit-TotalAtelierCourantDebit),NB_Unite_Atelier,(TotalAtelierCourantCredit-TotalAtelierCourantDebit)));

    TotalAtelierCourantDebit:=0;
    TotalAtelierCourantCredit:=0;
    TotalAtelierCourantQt1:=0;
    TotalAtelierCourantQt2:=0;

// Affichage du total général
GrGrandLivre.RowCount:=GrGrandLivre.RowCount+2;
GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Total ';
GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotDebit);
GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotCredit);
// Affichage du solde
GrGrandLivre.RowCount:=GrGrandLivre.RowCount+2;
GrGrandLivre.Cells[0,GrGrandLivre.RowCount-1]:='Solde (ou marge) ';
GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',0);
if TotDebit > TotCredit then
   GrGrandLivre.Cells[2,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotDebit-TotCredit) 
 else
   GrGrandLivre.Cells[3,GrGrandLivre.RowCount-1]:=FormatFloat(E.FormatMonnaie + ';; ',TotCredit-TotDebit);

DMAnalytiques.QuMontantEcrParAtelier.EnableControls;
end;

procedure TGestionAnalytique.FormDestroy(Sender: TObject);
begin
InitialiseTable_A_Nil;
ListeID.Free;
LibGestionParamXML.DestroyForm(Self,e.user);
DMAnalytiques.free;
GestionAnalytique:=nil;
end;

procedure TGestionAnalytique.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
canclose:=true;
if DMAnalytiques <> nil then
 begin
 if ((GrDBAtelier.DataSource.DataSet.State in [dsinsert,dsedit])or
    (GrDBActivite.DataSource.DataSet.State in [dsinsert,dsedit])or
    (GrDBComptes.DataSource.DataSet.State in [dsinsert,dsedit])or
    (GrDB_AtelierCompte.DataSource.DataSet.State in [dsinsert,dsedit])or
    (GrDBEcritures.DataSource.DataSet.State in [dsinsert,dsedit])or
    (GrDB_AtelierEcritures.DataSource.DataSet.State in [dsinsert,dsedit])) then
    begin
          self.WindowState:=wsNormal;
          self.BringToFront;
    end;
  ///// GrDBAtelier
  // Si l'utilisateur est en mode Insertion
     If GrDBAtelier.DataSource.DataSet.State = dsInsert Then
     Begin
          If Enregister1.Enabled Then
          Begin
                if application.MessageBox(Pchar('Voulez-vous enregistrer ce nouvel atelier ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                   Enregister1Click(Enregister1);
                  end
                  else
                   begin
                   GrDBAtelier.DataSource.DataSet.Cancel;
                   TableGereRollBack(GrDBAtelier.DataSource.DataSet);
                   end;
          End
          Else
          Begin
                if application.MessageBox(Pchar('Voulez-vous annuler la création de ce nouveau atelier ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                begin
                  GrDBAtelier.DataSource.DataSet.Cancel;
                  TableGereRollBack(GrDBAtelier.DataSource.DataSet);
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion
     // Si l'utilisateur est en mode Modification
     If GrDBAtelier.DataSource.DataSet.State = dsEdit Then
     Begin
         if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de cet atelier ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            Enregister1Click(Enregister1);
           end
         else
           begin
              GrDBAtelier.DataSource.DataSet.Cancel;
              TableGereRollBack(GrDBAtelier.DataSource.DataSet);
           end;
     End; // Fin utilisateur est en mode Modification

     /// GrDBActivite
  // Si l'utilisateur est en mode Insertion
     If GrDBActivite.DataSource.DataSet.State = dsInsert Then
     Begin
          If Enregister3.Enabled Then
          Begin
                if application.MessageBox(Pchar('Voulez-vous enregistrer cette nouvelle activite ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                   Enregister3Click(Enregister3);
                  end
                  else
                   begin
                   GrDBActivite.DataSource.DataSet.Cancel;
                   TableGereRollBack(GrDBActivite.DataSource.DataSet);
                   end;
          End
          Else
          Begin
                if application.MessageBox(Pchar('Voulez-vous annuler la création de cette nouvelle activite ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                begin
                  GrDBActivite.DataSource.DataSet.Cancel;
                  TableGereRollBack(GrDBActivite.DataSource.DataSet);
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion
     // Si l'utilisateur est en mode Modification
     If GrDBActivite.DataSource.DataSet.State = dsEdit Then
     Begin
           if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de cette activite ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            Enregister3Click(Enregister3);
             end
             else
             begin
              GrDBActivite.DataSource.DataSet.Cancel;
              TableGereRollBack(GrDBActivite.DataSource.DataSet);
             end;
     End; // Fin utilisateur est en mode Modification

  ///// GrDBComptes
  // Si l'utilisateur est en mode Insertion
     // Si l'utilisateur est en mode Modification
     If GrDBComptes.DataSource.DataSet.State = dsEdit Then
     Begin
           if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de ce compte ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            Enregister1Click(Enregister1);
             end
             else
             begin
              GrDBComptes.DataSource.DataSet.Cancel;
              TableGereRollBack(GrDBComptes.DataSource.DataSet);
             end;
     End; // Fin utilisateur est en mode Modification

  ///// GrDB_AtelierCompte
  // Si l'utilisateur est en mode Insertion
     If GrDB_AtelierCompte.DataSource.DataSet.State = dsInsert Then
     Begin
          If Enregister1.Enabled Then
          Begin
                if application.MessageBox(Pchar('Voulez-vous enregistrer cette nouvelle affectation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                   Enregister1Click(Enregister1);
                  end
                  else
                   begin
                   GrDB_AtelierCompte.DataSource.DataSet.Cancel;
                   TableGereRollBack(GrDB_AtelierCompte.DataSource.DataSet);
                   end;
          End
          Else
          Begin
                if application.MessageBox(Pchar('Voulez-vous annuler la création de cette nouvelle affectation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                begin
                  GrDB_AtelierCompte.DataSource.DataSet.Cancel;
                  TableGereRollBack(GrDB_AtelierCompte.DataSource.DataSet);
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion
     // Si l'utilisateur est en mode Modification
     If GrDB_AtelierCompte.DataSource.DataSet.State = dsEdit Then
     Begin
           if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de cette affectation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            Enregister1Click(Enregister1);
             end
             else
             begin
              GrDB_AtelierCompte.DataSource.DataSet.Cancel;
              TableGereRollBack(GrDB_AtelierCompte.DataSource.DataSet);
             end;
     End; // Fin utilisateur est en mode Modification

  ///// GrDBEcritures
     // Si l'utilisateur est en mode Modification
     If GrDBEcritures.DataSource.DataSet.State = dsEdit Then
     Begin
           if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de cette ligne d"écriture ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            Enregister1Click(Enregister1);
             end
             else
             begin
              GrDBEcritures.DataSource.DataSet.Cancel;
              TableGereRollBack(GrDBEcritures.DataSource.DataSet);
             end;
     End; // Fin utilisateur est en mode Modification

  ///// GrDB_AtelierEcritures
  // Si l'utilisateur est en mode Insertion
     If GrDB_AtelierEcritures.DataSource.DataSet.State = dsInsert Then
     Begin
          If Enregister1.Enabled Then
          Begin
                if application.MessageBox(Pchar('Voulez-vous enregistrer cette nouvelle affectation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                   Enregister1Click(Enregister1);
                  end
                  else
                   begin
                   GrDB_AtelierEcritures.DataSource.DataSet.Cancel;
                   TableGereRollBack(GrDB_AtelierEcritures.DataSource.DataSet);
                   end;
          End
          Else
          Begin
                if application.MessageBox(Pchar('Voulez-vous annuler la création de cette nouvelle affectation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                begin
                  GrDB_AtelierEcritures.DataSource.DataSet.Cancel;
                  TableGereRollBack(GrDB_AtelierEcritures.DataSource.DataSet);
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion
     // Si l'utilisateur est en mode Modification
     If GrDB_AtelierEcritures.DataSource.DataSet.State = dsEdit Then
     Begin
           if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de cette affectation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            Enregister1Click(Enregister1);
             end
             else
             begin
              GrDB_AtelierEcritures.DataSource.DataSet.Cancel;
              TableGereRollBack(GrDB_AtelierEcritures.DataSource.DataSet);
             end;
     End; // Fin utilisateur est en mode Modification

  end;//fin si DMAnalytiques <> nil
if CanClose then
begin
  InitialiseTable_A_Nil;{ isa  le  29/01/04 }
//  TTable(GrDBEcritures.DataSource.DataSet).IndexName:='';
end;
// else
// begin
//    if DMAnalytiques=nil then
//   DMAnalytiques:=DMAnalytiques.Create(self);
//
//   if AideCompte=nil then
//   AideCompte:=TAideCompte.Create(self);
// end;
except
  canclose:=false;
  self.WindowState:=wsNormal;
  self.BringToFront;
end;
end;

procedure TGestionAnalytique.FormActivate(Sender: TObject);
begin
 Initialiser_ShortCut_Main(true);
 LaFiltre.Visible:=false;
 GrDBAtelier.ParamColor:=true;
 GrDBAtelier.Param:=ParamUtil.CouleurDBGrid;
 GrDBAtelier.UpDateColor;

 GrDBActivite.ParamColor:=true;
 GrDBActivite.Param:=ParamUtil.CouleurDBGrid;
 GrDBActivite.UpDateColor;

 GrDBComptes.ParamColor:=true;
 GrDBComptes.Param:=ParamUtil.CouleurDBGrid;
 GrDBComptes.UpDateColor;

 GrDB_AtelierCompte.ParamColor:=true;
 GrDB_AtelierCompte.Param:=ParamUtil.CouleurDBGrid;
 GrDB_AtelierCompte.UpDateColor;

 GrDBEcritures.ParamColor:=true;
 GrDBEcritures.Param:=ParamUtil.CouleurDBGrid;
 GrDBEcritures.UpDateColor;

 GrDB_AtelierEcritures.ParamColor:=true;
 GrDB_AtelierEcritures.Param:=ParamUtil.CouleurDBGrid;
 GrDB_AtelierEcritures.UpDateColor;

 Gr_DBAffectation_def.ParamColor:=true;
 Gr_DBAffectation_def.Param:=ParamUtil.CouleurDBGrid;
 Gr_DBAffectation_def.UpDateColor;

 GrGrandLivre.ParamColor:=true;
 GrGrandLivre.Param:=ParamUtil.CouleurDBGrid;
 GrGrandLivre.DessineContourLigne:=false;
 GrGrandLivre.UpDateColor;

  if GrDBEcritures.DataSource.DataSet.State in [dsBrowse] then
   TableRefresh(GrDBEcritures.DataSource.DataSet,'ID');

  if GrDBComptes.DataSource.DataSet.State in [dsBrowse] then
   begin
     TableRefresh(GrDBComptes.DataSource.DataSet,'Compte');
   end;
   ChangementEtat_RX_Bouton;
InitListeGestionAnal;
end;

procedure TGestionAnalytique.PageControl1Change(Sender: TObject);
var
//GrilleEnCours:TGrDBGrid;
PageGrille:integer;
begin
try
LaFiltre.Caption:='';
// ToutReEnableControls;
if GrDBActivite.DataSource.State in [dsedit,dsinsert] then
  begin
    try
    Annuler1Click(Annuler1);
    except
    GrilleEnCours:=GrDBActivite;
    PageGrille:=0;
    abort;
    end;
    //TableGerePost(GrDBActivite.DataSource.DataSet);
  end;
if GrDBAtelier.DataSource.State in [dsedit,dsinsert] then
  begin
    try
    Annuler1Click(Annuler1);
    except
    GrilleEnCours:=GrDBAtelier;
    PageGrille:=0;
    abort;
    end;
    //TableGerePost(GrDBAtelier.DataSource.DataSet);
  end;
if GrDBComptes.DataSource.State in [dsedit,dsinsert] then
  begin
    try
    Annuler1Click(Annuler1);
    except
    GrilleEnCours:=GrDBComptes;
    PageGrille:=1;
    abort;
    end;
//    TableGerePost(GrDBComptes.DataSource.DataSet);
  end;
if GrDB_AtelierCompte.DataSource.State in [dsedit,dsinsert] then
  begin
    try
    Annuler1Click(Annuler1);
    except
    GrilleEnCours:=GrDB_AtelierCompte;
    PageGrille:=1;
    abort;
    end;
//    TableGerePost(GrDB_AtelierCompte.DataSource.DataSet);
  end;
if GrDBEcritures.DataSource.State in [dsedit,dsinsert] then
  begin
    try
    Annuler1Click(Annuler1);
    except
    GrilleEnCours:=GrDBEcritures;
    PageGrille:=2;
    abort;
    end;
//    TableGerePost(GrDBEcritures.DataSource.DataSet);
  end;
if GrDB_AtelierEcritures.DataSource.State in [dsedit,dsinsert] then
  begin
    try
    Annuler1Click(Annuler1);
    except
    GrilleEnCours:=GrDB_AtelierEcritures;
    PageGrille:=2;
    abort;
    end;
//    TableGerePost(GrDB_AtelierEcritures.DataSource.DataSet);
  end;
  case PageControl1.ActivePage.TabIndex of
     0:begin
        GrDBActivite.DataSource.OnStateChange:=DaActiviteStateChange;
        DaActiviteStateChange(GrDBActivite.DataSource.DataSet);
        GrDBAtelier.DataSource.OnStateChange:=DaAtelierStateChange;
        DaAtelierStateChange(GrDBAtelier.DataSource.DataSet);
        if sender <>nil then
          GrDBAtelier.DataSource.DataSet.first;
        GrDBAtelier.SetFocus;
       end;
     1:begin
        GrDBComptes.DataSource.OnStateChange:=DaPlanAnalStateChange;
        DaPlanAnalStateChange(GrDBComptes.DataSource.DataSet);
        GrDB_AtelierCompte.DataSource.OnStateChange:=DaAffect_AtelierCompteStateChange;
        DaAffect_AtelierCompteStateChange(GrDB_AtelierCompte.DataSource.DataSet);
        RxSBCptEcritureClick(RxSBCptEcriture);
        if sender <>nil then
          GrDBComptes.DataSource.DataSet.first;
        GrDBComptes.SetFocus;
       end;
     2:begin
        GrDBEcritures.DataSource.OnStateChange:=DaEcriture_AnalStateChange;
        DaEcriture_AnalStateChange(GrDBEcritures.DataSource.DataSet);
        GrDB_AtelierEcritures.DataSource.OnStateChange:=DaAffect_AtelierEcritureStateChange;
        DaAffect_AtelierEcritureStateChange(GrDB_AtelierEcritures.DataSource.DataSet);
        if sender <>nil then
          GrDBEcritures.DataSource.DataSet.first;
        GrDBEcritures.SetFocus;
       end;
     3:Begin
       InitChekBox;
       GrGrandLivre.SetFocus;
       End;
  end;
except
  if PageControl1.Pages[PageGrille]<>nil then
    PageControl1.ActivePage:=PageControl1.Pages[PageGrille];
  if GrilleEnCours.CanFocus then
    GrilleEnCours.SetFocus;
  abort;
end;
end;

procedure TGestionAnalytique.ChLBActiviteClickCheck(Sender: TObject);
var
i:integer;
begin
//******************************************************************************
//***************************** Vieux code *************************************
//******************************************************************************
//if ChLBActivite.Checked[ChLBActivite.ItemIndex] then
// begin
//   DMGestionAnal.TaCdp.Locate('Cdp',ChLBActivite.Items[ChLBActivite.ItemIndex],[]);
//   ChLBAtelier.Items.AddStrings(ChampTableVersListe('CompteA',DMGestionAnal.TaCompteA));
//   DMGestionAnal.TaCompteA.EnableControls;
// end
// else
// begin
//     DMGestionAnal.TaCdp.Locate('Cdp',ChLBActivite.Items[ChLBActivite.ItemIndex],[]);
//     if not DMGestionAnal.TaCompteA.Active then
//              DMGestionAnal.TaCompteA.Open;
//     DMGestionAnal.TaCompteA.First;
//     while not DMGestionAnal.TaCompteA.EOF do
//      begin
//        i:=ChLBAtelier.items.IndexOf(DMGestionAnal.TaCompteA.findField('CompteA').AsString);
//        if i <> -1 then
//          ChLBAtelier.items.delete(i);
//        DMGestionAnal.TaCompteA.Next;
//      end;
// end;
//******************************************************************************
//***************************** Fin Vieux code *********************************
//******************************************************************************

if ChLBActivite.Checked[ChLBActivite.ItemIndex] then
 begin
   FiltrageDataSet(DMRech.TaTA_AtelierRech,'Code_Activite = '''+ChLBActivite.Items[ChLBActivite.ItemIndex]+'''');
   ChLBAtelier.Items.AddStrings(ChampTableVersListe('Code_Atelier',DMRech.TaTA_AtelierRech));
   DeFiltrageDataSet(DMRech.TaTA_AtelierRech);
 end
 else
 begin
   FiltrageDataSet(DMRech.TaTA_AtelierRech,'Code_Activite = '''+ChLBActivite.Items[ChLBActivite.ItemIndex]+'''');
     DMRech.TaTA_AtelierRech.First;
     while not DMRech.TaTA_AtelierRech.EOF do
      begin
        i:=ChLBAtelier.items.IndexOf(DMRech.TaTA_AtelierRech.findField('Code_Atelier').AsString);
        if i <> -1 then
          ChLBAtelier.items.delete(i);
        DMRech.TaTA_AtelierRech.Next;
      end;
 end;
end;

procedure TGestionAnalytique.GrGrandLivreDrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
var
HoldColor:TColor;
begin
if row > 1 then
//if ((UpperCase(copy(GrGrandLivre.Cells[0,row],1,5)) = 'TOTAL') or (row = GrGrandLivre.RowCount-1)) then
if empty(GrGrandLivre.Cells[0,row]) then
 begin
  HoldColor:=GrGrandLivre.Brush.Color;
  GrGrandLivre.Canvas.Brush.Color :=clWhite;
//  GrGrandLivre.Canvas.Brush.Color :=cl3DLight;
  GrGrandLivre.Canvas.FillRect(Rect);
  GrGrandLivre.RowHeights[row] := 12;
  GrGrandLivre.Canvas.TextRect(Rect,Rect.BottomRight.x-4-GrGrandLivre.Canvas.TextWidth(GrGrandLivre.Cells[col,row]),Rect.TopLeft.y+3,GrGrandLivre.Cells[col,row]);
  GrGrandLivre.Brush.Color:=HoldColor;
 end;
  if (UpperCase(copy(GrGrandLivre.Cells[0,row],1,5)) = 'TOTAL')then
   begin
    HoldColor:=GrGrandLivre.Font.Color;
//    GrGrandLivre.Canvas.Font.Color :=clRed;
//    GrGrandLivre.Canvas.Font.Style :=[];
    GrGrandLivre.Canvas.Font.Style :=[fsItalic];
    GrGrandLivre.Canvas.FillRect(Rect);
    GrGrandLivre.Canvas.TextRect(Rect,Rect.BottomRight.x-4-GrGrandLivre.Canvas.TextWidth(GrGrandLivre.Cells[col,row]),Rect.TopLeft.y+3,GrGrandLivre.Cells[col,row]);
    GrGrandLivre.Canvas.Font.Style :=[];
    GrGrandLivre.Canvas.Font.Color:=HoldColor;
   end;
  if (UpperCase(copy(GrGrandLivre.Cells[0,row],1,7)) = 'ATELIER')then
   begin
    HoldColor:=GrGrandLivre.Brush.Color;
    GrGrandLivre.Canvas.Brush.Color :=$0070DBFF;
    GrGrandLivre.Canvas.Font.Style :=[fsBold];
    GrGrandLivre.Canvas.FillRect(Rect);
    GrGrandLivre.Canvas.TextRect(Rect,Rect.BottomRight.x-4-GrGrandLivre.Canvas.TextWidth(GrGrandLivre.Cells[col,row]),Rect.TopLeft.y+3,GrGrandLivre.Cells[col,row]);
    GrGrandLivre.Canvas.Font.Style :=[];
    GrGrandLivre.Brush.Color:=HoldColor;
   end;
  if (UpperCase(copy(GrGrandLivre.Cells[0,row],1,4)) = 'DATE')then
   begin
     HoldColor:=GrGrandLivre.Brush.Color;
     GrGrandLivre.Canvas.Brush.Color :=cl3DLight;
     GrGrandLivre.Canvas.FillRect(Rect);
     GrGrandLivre.RowHeights[row] := 16;
     GrGrandLivre.Canvas.TextRect(Rect,Rect.Left+2,Rect.TopLeft.y+3,GrGrandLivre.Cells[col,row]);
     GrGrandLivre.Brush.Color:=HoldColor;
   end;
  if (UpperCase(copy(GrGrandLivre.Cells[0,row],1,6)) = 'COMPTE')then
   begin
     HoldColor:=GrGrandLivre.Brush.Color;
     GrGrandLivre.Canvas.Brush.Color :=cl3DLight;
     GrGrandLivre.Canvas.FillRect(Rect);
     GrGrandLivre.RowHeights[row] := 16;
     GrGrandLivre.Canvas.TextRect(Rect,Rect.Left+2,Rect.TopLeft.y+3,GrGrandLivre.Cells[col,row]);
     GrGrandLivre.Brush.Color:=HoldColor;
   end;
//  if (UpperCase(copy(GrGrandLivre.Cells[0,row],1,13)) = 'TOTAL ATELIER')then
  if ((UpperCase(copy(GrGrandLivre.Cells[0,row],1,13)) = 'TOTAL ATELIER')or(UpperCase(copy(GrGrandLivre.Cells[0,row],1,5)) = 'MARGE'))then
   begin
    GrGrandLivre.Canvas.Font.Style :=[fsBold];
    GrGrandLivre.Canvas.FillRect(Rect);
    GrGrandLivre.Canvas.TextRect(Rect,Rect.BottomRight.x-4-GrGrandLivre.Canvas.TextWidth(GrGrandLivre.Cells[col,row]),Rect.TopLeft.y+3,GrGrandLivre.Cells[col,row]);
    GrGrandLivre.Canvas.Font.Style :=[];
   end;

//if col = 2  then
// begin
////      HoldColor:
//      grgrid1.Canvas.Brush.Color :=clyellow;
//      grgrid1.Canvas.FillRect(Rect);
// end
// else
// begin
//       grgrid1.Canvas.Brush.Color := clred;
//       grgrid1.Canvas.FillRect(Rect);
//  end;

end;

procedure TGestionAnalytique.RSActiviteTousClick(Sender: TObject);
var
i,j:integer;
begin
ChLBAtelier.Clear;
j:=ChLBActivite.ItemIndex;
CheckBoxCheckedAll(ChLBActivite);
for i:=0 to ChLBActivite.Items.Count -1 do
 begin
   ChLBActivite.ItemIndex:=i;
   ChLBActiviteClickCheck(ChLBActivite);
 end;
ChLBActivite.ItemIndex:=j;
end;

procedure TGestionAnalytique.RSActiviteAucunClick(Sender: TObject);
var
i,j:integer;
begin
j:=ChLBActivite.ItemIndex;
CheckBoxDeCheckedAll(ChLBActivite);
for i:=0 to ChLBActivite.Items.Count -1 do
 begin
   ChLBActivite.ItemIndex:=i;
   ChLBActiviteClickCheck(ChLBActivite);
 end;
ChLBActivite.ItemIndex:=j;
end;

procedure TGestionAnalytique.RSActiviteInverseClick(Sender: TObject);
var
i,j:integer;
begin
j:=ChLBActivite.ItemIndex;
CheckBoxInverseCheck(ChLBActivite);
//CheckBoxDeCheckedAll(ChLBActivite);
for i:=0 to ChLBActivite.Items.Count -1 do
 begin
   ChLBActivite.ItemIndex:=i;
   ChLBActiviteClickCheck(ChLBActivite);
 end;
ChLBActivite.ItemIndex:=j;
end;

procedure TGestionAnalytique.RSAtelierTousClick(Sender: TObject);
begin
CheckBoxCheckedAll(ChLBAtelier);
end;

procedure TGestionAnalytique.RSAtelierAucunClick(Sender: TObject);
begin
CheckBoxDeCheckedAll(ChLBAtelier);
end;

procedure TGestionAnalytique.RSAtelierInverseClick(Sender: TObject);
begin
CheckBoxInverseCheck(ChLBAtelier);
end;

procedure TGestionAnalytique.BtnImprimerResultClick(Sender: TObject);
var
BitMap:TBitMap;
begin
//BitMap:=TBitMap.Create;

//Button2.PaintTo(FEtatGestionAnal.QRImage1.Picture.Bitmap.Handle,0,0);

//GrGrandLivre.PaintTo(FEtatGestionAnal.QRImage1.Canvas.Handle,0,0);
//GrGrandLivre.PaintTo(Image1.Canvas.Handle,0,0);
//Image1.Picture.SaveToFile('GrTest1.bmp');
//FEtatGestionAnal.QRImage1.Picture.Bitmap.LoadFromFile('GrTest1.bmp');
   if FEtatGestionAnal = nil then FEtatGestionAnal:=TFEtatGestionAnal.Create(Application.MainForm);
FEtatGestionAnal.Preview;
//'GrTest1.bmp');
end;

procedure TGestionAnalytique.Button6Click(Sender: TObject);
var
TotauxBalance6_7:TTotauxBalance;
ListeCptResultat:TStringList;  { déclarer la liste }
CompteResult:TInfos_Piece;
begin
try
      ListeCptResultat:= TStringList.Create;  { construire l'objet liste }
      //gérer les comptes de 6 à 7
      ListeCptResultat.Add('6*');
      ListeCptResultat.Add('7*');
LaFiltre.Visible:=true;
      TotauxBalance6_7:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,ListeCptResultat,'Compte');

    if (TotauxBalance6_7.soldefin) <> 0 then
       begin //s'il y a un résultat à reporter
          CompteResult:=AffichResultat(Self,TotauxBalance6_7,false);
       end;
//not(TotauxBalance6_7.SoldeDebitCreditFin),TotauxBalance6_7.soldefin,CompteResult.Compte
//DMDiocEtatBal.ResultatExercice(Debit,credit,e.DatExoDebut,e.DatExoFin);
if  CompteResult.SensSolde=1 then
LaFiltre.Caption:='Résultat de l''année : '+e.FormatCurr(CompteResult.Total.Solde)+' (en Bénéfice) '
else
if  CompteResult.SensSolde=-1 then
  LaFiltre.Caption:='Résultat de l''année : '+e.FormatCurr(CompteResult.Total.Solde)+' (en Perte) '
 else
 if  CompteResult.SensSolde=0 then
    LaFiltre.Caption:='Résultat de l''année : '+e.FormatCurr(0);
finally
LibereObjet(TObject(ListeCptResultat),Self);
end;
end;

procedure TGestionAnalytique.FormCreate(Sender: TObject);
begin
if DMAnalytiques = nil then DMAnalytiques := TDMAnalytiques.Create(Application.MainForm);
    try
        CtrlEnfonce:=False;
        ListeID:=TListInteger.Create;
	LibGestionParamXML.InitialiseForm(E.USer,Self);
        DMAnalytiques.ProcHorsFenetre:=false;
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;

end;

procedure TGestionAnalytique.Panel7Resize(Sender: TObject);
begin
FormateTailleColonne(GrDBActivite,20,[4,8]);
FormateTailleColonne(GrDBAtelier,20,[3,3,3,3,3]);
//FormateTailleColonne(GrDBActivite_Atelier,10,[3,3,3]);

WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
FormateTailleBoutton([BtnAnnuler,BtnFermer,BtnImprimer,BtnExporter],PaBtn,90,0);

end;

procedure TGestionAnalytique.GrDBAtelierKeyPress(Sender: TObject;
  var Key: Char);
begin
if GrDBAtelier.SelectedIndex = 4 then
  Begin
    if key=#42 then
      key:=#0;
  End;
if GrDBAtelier.SelectedIndex in [0,4] then
  Begin
     key:=str_majusculeschar(key);
  End;


end;



///////// Changement d"état de toutes les grilles
procedure TGestionAnalytique.DaActiviteStateChange(Sender: TObject);
begin
  if ActiveControl=GrDBActivite then
    ChangementEtatGrille(GrDBActivite);
  ChangementEtatTabSheet(GrDBActivite.DataSource.State);
end;

procedure TGestionAnalytique.DaAtelierStateChange(Sender: TObject);
begin
  if ActiveControl=GrDBAtelier then
    ChangementEtatGrille(GrDBAtelier);
  ChangementEtatTabSheet(GrDBAtelier.DataSource.State);
end;

procedure TGestionAnalytique.DaEcriture_AnalStateChange(Sender: TObject);
begin
  if ActiveControl=GrDBEcritures then
    begin
      ChangementEtatGrille(GrDBEcritures);
    end;
  ChangementEtatTabSheet(GrDBEcritures.DataSource.State);
end;

procedure TGestionAnalytique.DaAffect_AtelierCompteStateChange(Sender: TObject);
begin
  if ActiveControl=GrDB_AtelierCompte then
    ChangementEtatGrille(GrDB_AtelierCompte);
  ChangementEtatTabSheet(GrDB_AtelierCompte.DataSource.State);
end;

procedure TGestionAnalytique.DaAffect_AtelierEcritureStateChange(Sender: TObject);
begin
  if ActiveControl=GrDB_AtelierEcritures then
    ChangementEtatGrille(GrDB_AtelierEcritures);
  ChangementEtatTabSheet(GrDB_AtelierEcritures.DataSource.State);
end;

procedure TGestionAnalytique.DaPlanAnalStateChange(Sender: TObject);
begin
  if ActiveControl=GrDBComptes then
    begin
      ChangementEtatGrille(GrDBComptes);
    end;
  ChangementEtatTabSheet(GrDBComptes.DataSource.State);
end;


procedure TGestionAnalytique.Aide1Click(Sender: TObject);
var
ActiviteTmp:TInfosTA_Activite;
Atelier:TInfosTA_Atelier;
begin
if PageControl1.ActivePage=FenetreCreationActivite then
  Begin
    case GrDBAtelier.SelectedIndex of
      0:begin//Code_Atelier
          if GrDBAtelier.DataSource.State =dsbrowse then
            Rechercher(GrDBAtelier,GrDBAtelier.DataSource.DataSet,['Code_atelier','Libelle_Atelier','Code_activite'],['Code atelier','Libellé atelier','Code activité'],'',0);
          if ((GrDBAtelier.DataSource.State in [dsedit,dsinsert])and((e.TypeClient=CL_Cogere))) then
            begin                                                             //or(e.TypeClient=CL_Saisie_Cogere)
              GrDBAtelier.EditorMode:=true;
              Atelier.ResultInfos:=true;
              if DMConstAnal = nil then DMConstAnal:=TDMConstAnal.Create(nil);
              Atelier:=AffichAteliersParDefaut(DMConstAnal.QuAtelierDefaut,DMConstAnal.DaQuAtelierDefaut,GrDBAtelier.InplaceEditor.Text);
              if Atelier.ResultInfos then
                 Begin
                   GrDBAtelier.DataSource.DataSet.Fields[1].AsString:=Atelier.Code_Atelier;
                   GrDBAtelier.DataSource.DataSet.Fields[2].AsString:=Atelier.Libelle_Atelier;
                   GrDBAtelier.DataSource.DataSet.Fields[3].AsString:='1';
                   GrDBAtelier.DataSource.DataSet.Fields[4].AsString:=Atelier.Unite_Atelier;
                   GrDBAtelier.DataSource.DataSet.Fields[6].AsString:=Atelier.Code_Activite;
                 End;
            end;
        end;
      1:begin//Libelle_Atelier
          if GrDBAtelier.DataSource.State =dsbrowse then
            Rechercher(GrDBAtelier,GrDBAtelier.DataSource.DataSet,['Libelle_Atelier','Code_atelier','Code_activite'],['Libellé atelier','Code atelier','Code activité'],'',0);
        end;
      2:Begin//NB_Unite_Atelier

        End;
      3:Begin//Unite_Atelier

        end;
      4:begin//Code_Activite
            //s'il y a des activités existantes, Remonter une liste d'Activités valides
           if GrDBActivite.DataSource.DataSet.RecordCount<>0 then
             begin
               ActiviteTmp.ResultInfos:=true;
               ActiviteTmp:=AffichActivitesExistantes(GrDBActivite.DataSource.DataSet,GrDBActivite.DataSource);
               if ActiviteTmp.ResultInfos then
                 Begin
                   if not(GrDBAtelier.DataSource.State in [dsinsert,dsedit])then
                     GrDBAtelier.DataSource.DataSet.Edit;
                   GrDBAtelier.DataSource.DataSet.Fields[5].Asinteger:=ActiviteTmp.ID_Activite;
                   GrDBAtelier.DataSource.DataSet.Fields[6].AsString:=ActiviteTmp.Code_Activite;
                 End;
             end
           else
             showmessage('Il n"y a pas d"activités existantes !');
        end;
    end;//fin du case
  End;//fin si PageControl1.ActivePage=FenetreCreationActivite
if PageControl1.ActivePage=FenetreAffectCompte then
  Begin
    case GrDBComptes.SelectedIndex of
      0:begin//Compte
          if GrDBComptes.DataSource.State =dsbrowse then
            Rechercher(GrDBComptes,GrDBComptes.DataSource.DataSet,['Compte','Libelle','CODE_GESTANAL'],['Compte','Libellé','Code Atelier'],'',0);
        end;
      1:begin//Libelle
          if GrDBComptes.DataSource.State =dsbrowse then
            Rechercher(GrDBComptes,GrDBComptes.DataSource.DataSet,['Libelle','Compte','CODE_GESTANAL'],['Libellé','Compte','Code Atelier'],'',0);
        end;
      2:begin//Code_Atelier
            //s'il y a des activités existantes, Remonter une liste d'Activités valides
           if GrDBAtelier.DataSource.DataSet.RecordCount<>0 then
             begin
               Atelier.ResultInfos:=true;
               Atelier:=AffichAteliersExistants(GrDBAtelier.DataSource.DataSet,GrDBAtelier.DataSource);
               if Atelier.ResultInfos then
                 Begin
                   if not(GrDBComptes.DataSource.State in [dsinsert,dsedit])then
                     GrDBComptes.DataSource.DataSet.Edit;
                   GrDBComptes.DataSource.DataSet.Findfield('ID_GESTANAL').Asinteger:=Atelier.ID_Atelier;
                   GrDBComptes.DataSource.DataSet.Findfield('CODE_GESTANAL').AsString:=Atelier.Code_Atelier;
                 End;
             end
           else
             showmessage('Il n"y a pas d"ateliers existants !');
        end;
    end;//fin du case
  End;//fin si PageControl1.ActivePage=FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then
  Begin
    try//finally                                                                           
    case GrDBEcritures.SelectedIndex of
      0:begin//Compte
          if GrDBEcritures.DataSource.State =dsbrowse then
            Rechercher(GrDBEcritures,GrDBEcritures.DataSource.DataSet,['Compte','Libelle','DebitSaisie','CreditSaisie','CODE_GESTANAL','Date'],['Compte','Libellé','Debit','Credit','Code atelier'],'',0);
        end;
      1:begin//Libelle
          if GrDBEcritures.DataSource.State =dsbrowse then
            Rechercher(GrDBEcritures,GrDBEcritures.DataSource.DataSet,['Libelle','Compte','DebitSaisie','CreditSaisie','CODE_GESTANAL','Date'],['Libellé','Compte','Debit','Credit','Code atelier'],'',0);
        end;
      3:begin//Code_Atelier
            //s'il y a des activités existantes, Remonter une liste d'Activités valides
           if GrDBAtelier.DataSource.DataSet.RecordCount<>0 then
             begin
               Atelier.ResultInfos:=true;
               Atelier:=AffichAteliersExistants(GrDBAtelier.DataSource.DataSet,GrDBAtelier.DataSource);
               if Atelier.ResultInfos then
                 Begin
                   if not(GrDBComptes.DataSource.State in [dsinsert,dsedit])then
                     GrDBEcritures.DataSource.DataSet.Edit;
                   GrDBEcritures.DataSource.DataSet.Findfield('ID_GESTANAL').Asinteger:=Atelier.ID_Atelier;
                   GrDBEcritures.DataSource.DataSet.Findfield('CODE_GESTANAL').AsString:=Atelier.Code_Atelier;
                 End;
             end
           else
             showmessage('Il n"y a pas d"ateliers existants !');
        end;
    end;//fin du case
    finally
    end;//fin finally
  End;//fin si PageControl1.ActivePage=FenetreAffectEcriture
end;

procedure TGestionAnalytique.Enregister1Click(Sender: TObject);
begin
///  FenetreCreationActivite
if PageControl1.ActivePage=FenetreCreationActivite then
Begin
TableGerePost(GrDBActivite.DataSource.DataSet);
if GrDBAtelier.CanFocus then GrDBAtelier.SetFocus;
TableGerePost(GrDBAtelier.DataSource.DataSet);
//else if GrDBActivite.canfocus then GrDBActivite.setfocus;
End;
///  FenetreAffectCompte
if PageControl1.ActivePage=FenetreAffectCompte then
Begin
TableGerePost(GrDB_AtelierCompte.DataSource.DataSet);
if GrDBComptes.CanFocus then GrDBComptes.SetFocus;
TableGerePost(GrDBComptes.DataSource.DataSet);
//else if GrDB_AtelierCompte.canfocus then GrDB_AtelierCompte.setfocus;
End;
///  FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then
Begin
TableGerePost(GrDB_AtelierEcritures.DataSource.DataSet);
if GrDBEcritures.CanFocus then GrDBEcritures.SetFocus;
TableGerePost(GrDBEcritures.DataSource.DataSet);
//else if GrDB_AtelierEcritures.canfocus then GrDB_AtelierEcritures.setfocus;
End;

///  FenetreResultat
if PageControl1.ActivePage=FenetreResultat then
//TableGerePost(GrDBActivite.DataSource.DataSet);

///  FenetreCreationActivite
//if PageControl1.ActivePage=FenetreCreationActivite then

end;


procedure TGestionAnalytique.Enregister3Click(Sender: TObject);
begin
Enregister1Click(Enregister1);
end;

procedure TGestionAnalytique.Modifier1Click(Sender: TObject);
begin
///  FenetreCreationActivite
if PageControl1.ActivePage=FenetreCreationActivite then
GrDBAtelier.DataSource.DataSet.Edit;
///  FenetreAffectCompte
if PageControl1.ActivePage=FenetreAffectCompte then
GrDBComptes.DataSource.DataSet.Edit;
///  FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then
GrDBEcritures.DataSource.DataSet.Edit;
///  FenetreResultat
if PageControl1.ActivePage=FenetreResultat then
//.DataSource.DataSet.Edit;

end;


procedure TGestionAnalytique.Modifier3Click(Sender: TObject);
begin

///  FenetreCreationActivite
if PageControl1.ActivePage=FenetreCreationActivite then
GrDBActivite.DataSource.DataSet.Edit;
///  FenetreAffectCompte
if PageControl1.ActivePage=FenetreAffectCompte then
GrDB_AtelierCompte.DataSource.DataSet.Edit;
///  FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then
GrDB_AtelierEcritures.DataSource.DataSet.Edit;
///  FenetreResultat
if PageControl1.ActivePage=FenetreResultat then
//.DataSource.DataSet.Edit;

end;


procedure TGestionAnalytique.Insrer3Click(Sender: TObject);
begin
///  FenetreCreationActivite
if PageControl1.ActivePage=FenetreCreationActivite then
  Begin
    GrDBActivite.DataSource.DataSet.insert;
    GrDBActivite.SetFocus;
  End;

///  FenetreAffectCompte
if PageControl1.ActivePage=FenetreAffectCompte then
  Begin
    GrDB_AtelierCompte.DataSource.DataSet.insert;
    GrDB_AtelierCompte.SetFocus;
  End;

///  FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then
  Begin
    GrDB_AtelierEcritures.DataSource.DataSet.insert;
    GrDB_AtelierEcritures.SetFocus;
  End;

///  FenetreResultat
if PageControl1.ActivePage=FenetreResultat then
//TableGerePost( .DataSource.DataSet);

end;

procedure TGestionAnalytique.Supprimer1Click(Sender: TObject);
begin
///  FenetreCreationActivite
if PageControl1.ActivePage=FenetreCreationActivite then
  begin
    if application.MessageBox(Pchar('Cette atelier va être supprimé, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      Begin
        TableGereDelete(GrDBAtelier.DataSource.DataSet);
//        GrDBAtelier.DataSource.OnStateChange(GrDBAtelier.DataSource.DataSet);
      end
    else
      abort;
  end;

///  FenetreAffectCompte
if PageControl1.ActivePage=FenetreAffectCompte then
   Begin
     if not(GrDBComptes.DataSource.state in [dsedit,dsinsert]) then
       GrDBComptes.DataSource.DataSet.edit;
     GrDBComptes.DataSource.DataSet.findfield('id_Gestanal').asstring:='';
     GrDBComptes.DataSource.DataSet.findfield('code_Gestanal').asstring:='';
     TableGerePost(GrDBComptes.DataSource.DataSet);
     if GrDBComptes.DataSource.DataSet.recordcount=0 then
       TaPlanAnalAfterScroll_form(GrDBComptes.DataSource.DataSet);
   End;
//   DMAnalytiques.GestionSuppressionRelation_Compte_Atelier(GrDBComptes.DataSource.DataSet.findfield('compte').asstring);
  // pas de suppression possible

///  FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then
   Begin
     if not(GrDBEcritures.DataSource.state in [dsedit,dsinsert]) then
       GrDBEcritures.DataSource.DataSet.edit;
     GrDBEcritures.DataSource.DataSet.findfield('id_Gestanal').asstring:='';
     GrDBEcritures.DataSource.DataSet.findfield('code_Gestanal').asstring:='';
     TableGerePost(GrDBEcritures.DataSource.DataSet);
     if GrDBEcritures.DataSource.DataSet.recordcount=0 then
       TaEcriture_AnalAfterScroll_form(GrDBEcritures.DataSource.DataSet);
   End;
  //DMAnalytiques.GestionSuppressionRelation_Ecriture_Atelier(GrDBEcritures.DataSource.DataSet.findfield('id').asinteger);
  // pas de suppression possible

///  FenetreResultat
//if PageControl1.ActivePage=FenetreResultat then
//TableGerePost(GrDBActivite.DataSource.DataSet);
PageControl1Change(nil);
end;


procedure TGestionAnalytique.Supprimer3Click(Sender: TObject);
begin
///  FenetreCreationActivite
if PageControl1.ActivePage=FenetreCreationActivite then
  Begin
    if application.MessageBox(Pchar('Cette activité va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      Begin
        TableGereDelete(GrDBActivite.DataSource.DataSet);
        GrDBActivite.DataSource.OnStateChange(GrDBActivite.DataSource.DataSet);
      end
    else
      abort;
  End;

///  FenetreAffectCompte
if PageControl1.ActivePage=FenetreAffectCompte then
  Begin
    if application.MessageBox(Pchar('Cette affectation va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      Begin
        TableGereDelete(GrDB_AtelierCompte.DataSource.DataSet);
        GrDB_AtelierCompte.DataSource.OnStateChange(GrDB_AtelierCompte.DataSource.DataSet);
      end
    else
      abort;
  End;

///  FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then
  Begin
    if application.MessageBox(Pchar('Cette affectation va être supprimée, voulez-vous continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
      Begin
        TableGereDelete(GrDB_AtelierEcritures.DataSource.DataSet);
        GrDB_AtelierEcritures.DataSource.OnStateChange(GrDB_AtelierEcritures.DataSource.DataSet);
      end
    else
      abort;
  End;

///  FenetreResultat
if PageControl1.ActivePage=FenetreResultat then
//TableGerePost( .DataSource.DataSet);

end;

procedure TGestionAnalytique.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
PageGrille:integer;
CanClose:boolean;
KeyTmp:Word;
ValeurEnCours:string;
begin
try
//if ((key = VK_RETURN)and(not (GrDB_AtelierEcritures.DataSource.State in [dsinsert,dsedit])))then
//WinSuivPrec(Handle,key,[GrDBAtelier,GrDBActivite,GrDBComptes,GrDB_AtelierCompte,GrDBEcritures,GrDB_AtelierEcritures]);
//else
// WinSuivPrec(Handle,key,[nil]);
  //If ((Key = VK_Tab) and (shift=[ssCtrl	])) Then
  If Key = VK_Tab Then
    Begin
      Key:=0;
      if ActiveControl=GrDBAtelier then GrDBActivite.SetFocus
      else if ActiveControl=GrDBActivite then
            begin
             if GrDBActivite.DataSource.State in [dsinsert,dsedit] then
               TableGerePost(GrDBActivite.DataSource.DataSet);
             GrDBAtelier.SetFocus;
            end;
      if ActiveControl=GrDBComptes then GrDB_AtelierCompte.SetFocus
      else if ActiveControl=GrDB_AtelierCompte then
            begin
             if GrDB_AtelierCompte.DataSource.State in [dsinsert,dsedit] then
               TableGerePost(GrDB_AtelierCompte.DataSource.DataSet);
             GrDBComptes.SetFocus;
            end;
      if ActiveControl=GrDBEcritures then GrDB_AtelierEcritures.SetFocus
      else if ActiveControl=GrDB_AtelierEcritures then
            begin
             if GrDB_AtelierEcritures.DataSource.State in [dsinsert,dsedit] then
               TableGerePost(GrDB_AtelierEcritures.DataSource.DataSet);
             GrDBEcritures.SetFocus;
            end;
    end;
  If Key = VK_ESCAPE Then
    Begin
     GrDB_AtelierCompte.OnExit:=nil;
     GrDB_AtelierEcritures.OnExit:=nil;
    //////  FenetreCreationActivite
//    if PageControl1.ActivePage=FenetreCreationActivite then
     Begin//si PageControl1.ActivePage=FenetreCreationActivite
       if PageControl1.ActivePage=FenetreResultat then
         canclose:=true;
       If ((not (GrDBAtelier.DataSource.DataSet.State in [dsinsert,dsedit]))and(not(GrDBActivite.DataSource.DataSet.State in [dsinsert,dsedit]))) Then
          begin
             if ActiveControl=GrDBAtelier then
               CanClose:=true
             else
               if GrDBAtelier.CanFocus then
                begin
                  GrilleEnCours:=GrDBAtelier;
                  canclose:=false;
                end;
          end
        else
           begin
             CanClose:=false;
             GrilleEnCours:=GrDBAtelier;
           end;
      ///// GrDBActivite
      If GrDBActivite.DataSource.DataSet.State = dsInsert Then
          Begin //si GrDBActivite = dsInsert
               If Messagedlg('Annuler la création de cette activité ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    GrDBActivite.DataSource.DataSet.Cancel;
                    //TableGereRollBack(GrDBActivite.DataSource.DataSet);
                    if GrDBActivite.CanFocus then
                      GrilleEnCours:=GrDBActivite;
               End
               Else
               Begin
                    Abort;
               End;
          End;//fin si GrDBActivite = dsInsert
          If GrDBActivite.DataSource.DataSet.State = dsEdit Then
            Begin//si GrDBActivite =dsEdit
               If Messagedlg('Annuler les modifications de cette activité ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    GrDBActivite.DataSource.DataSet.Cancel;
                    //TableGereRollBack(GrDBActivite.DataSource.DataSet);
//                    if GrDBActivite.CanFocus then
//                      GrilleEnCours:=GrDBActivite;
               End
               Else
               Begin
                    Abort;
               End
          End;//fin si GrDBActivite =dsEdit
      ///// GrDBAtelier
      If GrDBAtelier.DataSource.DataSet.State = dsInsert Then
          Begin// si GrDBAtelier = dsinsert
               If Messagedlg('Annuler la création de cet atelier ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    GrDBAtelier.DataSource.DataSet.Cancel;
                    TableGereRollBack(GrDBAtelier.DataSource.DataSet);
                    if GrDBAtelier.CanFocus then
                      GrilleEnCours:=GrDBAtelier;
               End
               Else
               Begin
                    Abort;
               End;
          End;//fin si GrDBAtelier = dsinsert
          If GrDBAtelier.DataSource.DataSet.State = dsEdit Then
          Begin//si GrDBAtelier = dsEdit
               If Messagedlg('Annuler les modifications de cet atelier ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    GrDBAtelier.DataSource.DataSet.Cancel;
                    TableGereRollBack(GrDBAtelier.DataSource.DataSet);
                    if GrDBAtelier.CanFocus then
                      GrilleEnCours:=GrDBAtelier;
               End
               Else
               Begin
                    Abort;
               End
          End;//fin si GrDBAtelier = dsEdit
      End;//fin si PageControl1.ActivePage=FenetreCreationActivite

    /////  FenetreAffectCompte
//    if PageControl1.ActivePage=FenetreAffectCompte then
      Begin//si PageControl1.ActivePage=FenetreAffectCompte
       If ((not (GrDBComptes.DataSource.DataSet.State in [dsinsert,dsedit]))and(not(GrDB_AtelierCompte.DataSource.DataSet.State in [dsinsert,dsedit]))) Then
          begin
             if ActiveControl=GrDBComptes then
               CanClose:=true
             else
              if GrDBComptes.CanFocus then
               begin
                 GrilleEnCours:=GrDBComptes;
                 canclose:=false;
               end;
          end
        else                           
           begin
             CanClose:=false;
             GrilleEnCours:=GrDBComptes;
           end;
      ///// GrDB_AtelierCompte
      If GrDB_AtelierCompte.DataSource.DataSet.State = dsInsert Then
          Begin //si GrDB_AtelierCompte = dsInsert
               If Messagedlg('Annuler la création de cette affectation ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    GrDB_AtelierCompte.DataSource.DataSet.Cancel;
                    //DMAnalytiques.nouvelleAffectation_Compte(GrDB_AtelierCompte.DataSource.DataSet)
               End
               Else
               Begin
                    Abort;
               End;
          End;//fin si GrDB_AtelierCompte = dsInsert
          If GrDB_AtelierCompte.DataSource.DataSet.State = dsEdit Then
            begin//GrDB_AtelierCompte =dsEdit
               If Messagedlg('Annuler les modifications de cette affectation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    GrDB_AtelierCompte.DataSource.DataSet.Cancel;
                    //DMAnalytiques.nouvelleAffectation_Compte(GrDB_AtelierCompte.DataSource.DataSet)
                End
               Else
               Begin
                    Abort;
               End;
            End;//fin si GrDB_AtelierCompte =dsEdit
      ///// GrDBComptes
          If GrDBComptes.DataSource.DataSet.State = dsEdit Then
          Begin//si GrDBComptes = dsEdit
               If Messagedlg('Annuler les modifications de ce Compte ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    GrDBComptes.DataSource.DataSet.Cancel;
                    DMAnalytiques.nouvelleAffectation_Compte(GrDB_AtelierCompte.DataSource.DataSet);
                    if GrDBComptes.CanFocus then
                      GrilleEnCours:=GrDBComptes;
               End
               Else
               Begin
                    DMAnalytiques.nouvelleAffectation_Compte(GrDB_AtelierCompte.DataSource.DataSet);
                    Abort;
               End;
          End;//fin si GrDBComptes = dsEdit
      End;//fin si PageControl1.ActivePage=FenetreAffectCompte

    /////  FenetreAffectEcriture
//    if PageControl1.ActivePage=FenetreAffectEcriture then
      Begin//si PageControl1.ActivePage=FenetreAffectEcriture
       If ((not(GrDBEcritures.DataSource.DataSet.State in [dsinsert,dsedit]))and(not(GrDB_AtelierEcritures.DataSource.DataSet.State in [dsinsert,dsedit]))) Then
          begin
             if ActiveControl=GrDBEcritures then
               CanClose:=true
             else
               if GrDBEcritures.CanFocus then
                 begin
                    GrilleEnCours:=GrDBEcritures;
                    CanClose:=false;
                 end;
          end
        else
          begin
           CanClose:=false;
           GrilleEnCours:=GrDBEcritures;
          end;
      ///// GrDB_AtelierEcritures
      If GrDB_AtelierEcritures.DataSource.DataSet.State = dsInsert Then
          Begin //si GrDB_AtelierEcritures = dsInsert
               If Messagedlg('Annuler la création de cette affectation ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    GrDB_AtelierEcritures.DataSource.DataSet.Cancel;
                    //DMAnalytiques.nouvelleAffectation_Ecriture(GrDB_AtelierEcritures.DataSource.DataSet)
               End
               Else
               Begin
                    Abort;
               End;
          End;//fin si GrDB_AtelierEcritures = dsInsert
          If GrDB_AtelierEcritures.DataSource.DataSet.State = dsEdit Then
          Begin//si GrDB_AtelierEcritures =dsEdit
               If Messagedlg('Annuler les modifications de cette affectation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    GrDB_AtelierEcritures.DataSource.DataSet.Cancel;
                    //DMAnalytiques.nouvelleAffectation_Ecriture(GrDB_AtelierEcritures.DataSource.DataSet)
               End
               Else
               Begin
                    Abort;
               End
          End;//fin si GrDB_AtelierEcritures =dsEdit
      ///// GrDBEcritures
          If GrDBEcritures.DataSource.DataSet.State = dsEdit Then
          Begin//si GrDBEcritures = dsEdit
               If Messagedlg('Annuler les modifications de cette ligne d"écriture ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
                 Begin
                      GrDBEcritures.DataSource.DataSet.Cancel;
                      DMAnalytiques.nouvelleAffectation_Ecriture(GrDB_AtelierEcritures.DataSource.DataSet);
                      if GrDBEcritures.CanFocus then
                        GrilleEnCours:=GrDBEcritures;
                 End
               Else
                 Begin
                      DMAnalytiques.nouvelleAffectation_Ecriture(GrDB_AtelierEcritures.DataSource.DataSet);
                      Abort;
                 End;
          End;//fin si GrDBEcritures = dsEdit
      End;//fin si PageControl1.ActivePage=FenetreAffectEcriture
      if CanClose=false then abort
        else self.close;
    end;//fin si echappe

  If ((Key = VK_up)or(Key = vk_down)) Then
    Begin
      if ActiveControl=GrDB_AtelierEcritures then
        begin
        if ((GrDB_AtelierEcritures.InplaceEditor<>nil)and(GrDB_AtelierEcritures.InplaceEditor.Visible)and(GrDB_AtelierEcritures.Col=1)) then
          ValeurEnCours:=GrDB_AtelierEcritures.InplaceEditor.Text
        else
          ValeurEnCours:=GrDB_AtelierEcritures.DataSource.DataSet.findfield('Code_atelier').asstring;
          If GrDB_AtelierEcritures.DataSource.DataSet.State in [dsInsert,dsedit]Then
              Begin //si GrDB_AtelierEcritures = dsInsert
                  if  empty(ValeurEnCours) then
                    GrDB_AtelierEcritures.DataSource.DataSet.Cancel
                  else
                    begin
                      GrDB_AtelierEcritures.DataSource.DataSet.findfield('Code_atelier').asstring:=ValeurEnCours;
                      GrDB_AtelierEcrituresColExit(GrDB_AtelierEcritures);
                      TableGerePost(GrDB_AtelierEcritures.DataSource.DataSet);
                    end;
              end;
        end;
      if ActiveControl=GrDB_AtelierCompte then
        begin
          If GrDB_AtelierCompte.DataSource.DataSet.State in [dsInsert,dsedit]Then
              Begin //si GrDB_AtelierEcritures = dsInsert
                if ((GrDB_AtelierCompte.InplaceEditor<>nil)and(GrDB_AtelierCompte.InplaceEditor.Visible)and(GrDB_AtelierCompte.Col=1)) then
                  ValeurEnCours:=GrDB_AtelierCompte.InplaceEditor.Text
                else
                  ValeurEnCours:=GrDB_AtelierCompte.DataSource.DataSet.findfield('Code_atelier').asstring;
                  if  empty(ValeurEnCours) then
                    GrDB_AtelierCompte.DataSource.DataSet.Cancel
                  else
                    begin
                      GrDB_AtelierCompte.DataSource.DataSet.findfield('Code_atelier').asstring:=ValeurEnCours;
                      GrDB_AtelierCompteColExit(GrDB_AtelierCompte);
                      TableGerePost(GrDB_AtelierCompte.DataSource.DataSet);
                    end;
              end;
        end;
    end;
//  If Key = VK_space Then
//     Begin
//        Key := vk_Tab;
//     End;

except
  if GrilleEnCours<>nil then
   begin
    if GrilleEnCours.CanFocus then
     GrilleEnCours.SetFocus;
   end;
     GrDB_AtelierCompte.OnExit:=GrDB_AtelierCompteExit;
     GrDB_AtelierEcritures.OnExit:=GrDB_AtelierEcrituresExit;
  abort;
end;
end;


procedure TGestionAnalytique.Insrer1Click(Sender: TObject);
begin
///  FenetreCreationActivite
if PageControl1.ActivePage=FenetreCreationActivite then
  begin
    GrDBAtelier.DataSource.DataSet.insert;
    if GrDBAtelier.CanFocus then GrDBAtelier.SetFocus;
  end;

///  FenetreAffectCompte
if PageControl1.ActivePage=FenetreAffectCompte then ;
  // pas d'insertion possible

///  FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then ;
  // pas d'insertion possible

///  FenetreResultat
if PageControl1.ActivePage=FenetreResultat then        ;
//TableGerePost(GrDBActivite.DataSource.DataSet);

end;

procedure TGestionAnalytique.GrDBAtelierColExit(Sender: TObject);
Var
CtrlSaisie:TExceptLGR;
begin
Try
Case GrDBAtelier.DataSource.State of
   dsInsert:Begin
               try
                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Atelier(GrDBAtelier.SelectedField);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
                0000:Begin
                        //abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
           1001,1000,1002:Begin
                        abort;
                     End;
                // Traitement Libelle_Atelier
                //*************************************************************************
                2000:Begin
                        //abort;
                     End;
                // Traitement NB_Unite_Atelier
                //*************************************************************************
                3000:Begin
                        //abort;
                     End;
                // Traitement Unite_Atelier
                //*************************************************************************
                4000:Begin
                        //abort;
                     End;
                // Traitement ID_Activite
                //*************************************************************************
                5000:Begin
                        //abort;
                     End;
                // Traitement Code_Activite
                //*************************************************************************
                6000:Begin
                       abort;
                     End;
                End; // Fin du case
               End; // Fin du try
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//               try
//                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Atelier(GrDBAtelier.SelectedField);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//                0000:Begin
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//                1000:Begin
//                        abort;
//                     End;
//                // Traitement Libelle_Atelier
//                //*************************************************************************
//                2000:Begin
//                        abort;
//                     End;
//                // Traitement NB_Unite_Atelier
//                //*************************************************************************
//                3000:Begin
//                        abort;
//                     End;
//                // Traitement Unite_Atelier
//                //*************************************************************************
//                4000:Begin
//                        abort;
//                     End;
//                // Traitement ID_Activite
//                //*************************************************************************
//                5000:Begin
//                        abort;
//                     End;
//                // Traitement Code_Activite
//                //*************************************************************************
//                6000:Begin
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
 abort;
End;
End;


procedure TGestionAnalytique.GrDBActiviteColExit(Sender: TObject);
Var
CtrlSaisie:TExceptLGR;
begin
Try
Case GrDBActivite.DataSource.State of
   dsInsert:Begin
               try
                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Activite(GrDBActivite.SelectedField);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Activite
                //*************************************************************************
                0000:Begin
//                        abort;
                     End;
                // Traitement Code_Activite
                //*************************************************************************
                1000,1001:Begin
                        abort;
                     End;
                // Traitement Libelle_Activite
                //*************************************************************************
                2000:Begin
//                        Messagebox(0,Pchar('Vous devez indiquer un libellé'),'Erreur de saisie',0);
//                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
            End; // Fin Begin du dsInsert
// Zone Edition
   dsEdit:Begin
               try
                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Activite(GrDBActivite.SelectedField);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Activite
                //*************************************************************************
                0000:Begin
//                        abort;
                     End;
                // Traitement Code_Activite
                //*************************************************************************
                1000,1001:Begin
                        abort;
                     End;
                // Traitement Libelle_Activite
                //*************************************************************************
                2000:Begin
//                        Messagebox(0,Pchar('Vous devez indiquer un libellé'),'Erreur de saisie',0);
//                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
abort;
End;
End;



procedure TGestionAnalytique.Aide3Click(Sender: TObject);
var
Atelier:TInfosTA_Atelier;
begin
//si PageControl1.ActivePage=FenetreCreationActivite
if PageControl1.ActivePage=FenetreCreationActivite then
  Begin
    if GrDBActivite.DataSource.State =dsbrowse then
      Begin
        case GrDBActivite.SelectedIndex of
          0:begin//Code_Activite
               Rechercher(GrDBActivite,GrDBActivite.DataSource.DataSet,['Code_activite','Libelle_Activite'],['Code activité','Libellé activité'],'',0);
            end;
          1:begin//Libelle_Activite
               Rechercher(GrDBActivite,GrDBActivite.DataSource.DataSet,['Libelle_Activite'],['Libellé activité'],'',0);
            end;
        end;//fin du case
      End;
  End;//fin si PageControl1.ActivePage=FenetreCreationActivite

//si PageControl1.ActivePage=FenetreAffectCompte
if PageControl1.ActivePage=FenetreAffectCompte then
  Begin
    if GrDB_AtelierCompte.DataSource.State =dsbrowse then
      Begin
        case GrDB_AtelierCompte.SelectedIndex of
          0:begin//Code_atelier
               Rechercher(GrDB_AtelierCompte,GrDB_AtelierCompte.DataSource.DataSet,['Code_atelier','Libelle'],['Code atelier','Libellé atelier'],'',0);
            end;
          1:begin//Libelle
               Rechercher(GrDB_AtelierCompte,GrDB_AtelierCompte.DataSource.DataSet,['Libelle'],['Libellé atelier'],'',0);
            end;
        end;//fin du case
      End;
    if GrDB_AtelierCompte.DataSource.State in [dsinsert,dsedit] then
      Begin
        case GrDB_AtelierCompte.SelectedIndex of
          0:begin//Code_Atelier
            //s'il y a des ateliers existants, Remonter une liste d'ateliers valides
           if GrDBAtelier.DataSource.DataSet.RecordCount<>0 then
             begin
               Atelier.ResultInfos:=true;
               Atelier:=AffichAteliersExistants(GrDBAtelier.DataSource.DataSet,GrDBAtelier.DataSource);
               if Atelier.ResultInfos then
                 begin
                   GrDB_AtelierCompte.DataSource.DataSet.Findfield('Code_Atelier').Asstring:=Atelier.Code_Atelier;
                   GrDB_AtelierCompte.DataSource.DataSet.Findfield('id_Atelier').Asinteger:=Atelier.ID_Atelier;
                 end;
             end
           else
             showmessage('Il n"y a pas d"ateliers existants !');
            end;
          1:begin//Libelle
               Rechercher(GrDB_AtelierCompte,GrDB_AtelierCompte.DataSource.DataSet,['Libelle'],['Libellé atelier'],'',0);
            end;
        end;//fin du case
      End;
  End;//fin si PageControl1.ActivePage=FenetreAffectCompte

///si PageControl1.ActivePage=FenetreAffectEcriture
if PageControl1.ActivePage=FenetreAffectEcriture then
  Begin
    if GrDB_AtelierEcritures.DataSource.State =dsbrowse then
      Begin
        case GrDB_AtelierEcritures.SelectedIndex of
          0:begin//Code_atelier
               Rechercher(GrDB_AtelierEcritures,GrDB_AtelierEcritures.DataSource.DataSet,['Code_atelier','Libelle'],['Code atelier','Libellé atelier'],'',0);
            end;
          1:begin//Libelle
               Rechercher(GrDB_AtelierEcritures,GrDB_AtelierEcritures.DataSource.DataSet,['Libelle'],['Libellé atelier'],'',0);
            end;
        end;//fin du case
      End;
    if GrDB_AtelierEcritures.DataSource.State in [dsinsert,dsedit] then
      Begin
        case GrDB_AtelierEcritures.SelectedIndex of
          0:begin//Code_Atelier
            //s'il y a des ateliers existants, Remonter une liste d'ateliers valides
           if GrDBAtelier.DataSource.DataSet.RecordCount<>0 then
             begin
               Atelier.ResultInfos:=true;
               Atelier:=AffichAteliersExistants(GrDBAtelier.DataSource.DataSet,GrDBAtelier.DataSource);
               if Atelier.ResultInfos then
                 begin
                   GrDB_AtelierEcritures.DataSource.DataSet.Findfield('Code_Atelier').Asstring:=Atelier.Code_Atelier;
                   GrDB_AtelierEcritures.DataSource.DataSet.Findfield('id_Atelier').Asinteger:=Atelier.ID_Atelier;
                 end;
             end
           else
             showmessage('Il n"y a pas d"ateliers existants !');
            end;
          1:begin//Libelle
               Rechercher(GrDB_AtelierCompte,GrDB_AtelierCompte.DataSource.DataSet,['Libelle'],['Libellé atelier'],'',0);
            end;
        end;//fin du case
      End;
  End;//fin si PageControl1.ActivePage=FenetreAffectEcriture
end;

procedure TGestionAnalytique.GrDBActiviteExit(Sender: TObject);
begin
try
 if GrDBActivite.DataSource.State in [dsinsert,dsedit] then
   TableGerePost(GrDBActivite.DataSource.DataSet);
except
  GrDBActivite.SetFocus;
  abort;
end;
end;

procedure TGestionAnalytique.GrDBAtelierExit(Sender: TObject);
begin
 if GrDBAtelier.DataSource.State in [dsinsert,dsedit] then
   TableGerePost(GrDBAtelier.DataSource.DataSet);
end;

procedure TGestionAnalytique.GrDB_AtelierEcrituresColExit(Sender: TObject);
Var
CtrlSaisie:TExceptLGR;
begin
Try
Case GrDB_AtelierEcritures.datasource.State of
   dsedit,
   dsInsert:Begin
               try
                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Affect_Atelier_PourEcriture(GrDB_AtelierEcritures.SelectedField);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
           1001,1000,1002:Begin
                        //abort;
                     End;
                // Traitement ID_Ligne
                //*************************************************************************
           2001,2000,2002:Begin
                        abort;
                     End;
                // Traitement Compte
                //*************************************************************************
           3001,3000,3002:Begin
                        abort;
                     End;
                // Traitement Libelle
                //*************************************************************************
                4000:Begin
                        //abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
                5000,5002:Begin
                        abort;
                     End;
                5001:begin//code non existant et <> de '*'
                       //afficher fenetre de création des ateliers

//                       MessageDlg('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités',mtError,[mbOK],0);
                       Application.Messagebox(Pchar('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités'),'Erreur de saisie',0);
                        abort;
                     end;
                // Traitement Ratio
                //*************************************************************************
                6000:Begin
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//               try
//                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Affect_Atelier(GrDB_AtelierEcritures.SelectedField);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//           0001,0000:Begin
//                        abort;
//                     End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//           1001,1000:Begin
//                        abort;
//                     End;
//                // Traitement Compte
//                //*************************************************************************
//           2001,2000:Begin
//                        abort;
//                     End;
//                // Traitement Libelle
//                //*************************************************************************
//                3000:Begin
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//           4001,4000:Begin
//                        abort;
//                     End;
//                // Traitement Ratio
//                //*************************************************************************
//                5000:Begin
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
abort;
End;
End;


procedure TGestionAnalytique.GrDBEcrituresColExit(Sender: TObject);
Var
CtrlSaisie:TExceptLGR;
begin
Try
Case GrDBEcritures.datasource.State of
   dsedit,
   dsInsert:Begin
               try
                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_EcritureAnal(GrDBEcritures.SelectedField);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_GESTANAL
                //*************************************************************************
           4001,4000:Begin
                        //abort;
                     End;
                // Traitement CODE_GESTANAL
                //*************************************************************************
           5001,5000:Begin
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//               try
//                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Affect_Atelier(GrDBEcritures.SelectedField);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_GESTANAL
//                //*************************************************************************
//           4001,4000:Begin
//                        //abort;
//                     End;
//                // Traitement CODE_GESTANAL
//                //*************************************************************************
//           5001,5000:Begin
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
abort;
End;
End;



procedure TGestionAnalytique.GrDB_AtelierEcrituresExit(Sender: TObject);
var
focusGrille:TGrDBGrid;
begin
try//except
   try//finally
      if GrDB_AtelierEcritures.DataSource.State in [dsinsert,dsedit] then
        begin
          focusGrille:=GrDB_AtelierEcritures;
          TableGerePost(GrDB_AtelierEcritures.DataSource.DataSet);
        end;
      if GrDBEcritures.DataSource.State in [dsinsert,dsedit] then
        begin
          focusGrille:=GrDBEcritures;
          TableGerePost(GrDBEcritures.DataSource.DataSet);
        end;
   finally
//     if focusgrille<>GrDB_AtelierEcritures then
//       begin
//       DMAnalytiques.IdEcritureEnModif:=0;
//       GrDBEcritures.DataSource.DataSet.Refresh;
//       end;
   end;
except
  if focusGrille<>nil then (focusGrille as TGrDBGrid).SetFocus;
  abort;
end;
end;

procedure TGestionAnalytique.GrDB_AtelierEcrituresKeyPress(Sender: TObject;
  var Key: Char);
begin
//if GrDB_AtelierEcritures.SelectedIndex = 1 then
//  Begin
//    if key=#42 then
//      key:=#0;
//  End;

end;

procedure TGestionAnalytique.GrDB_AtelierCompteKeyPress(Sender: TObject;
  var Key: Char);
begin
//if GrDB_AtelierEcritures.SelectedIndex = 1 then
//  Begin
//    if key=#42 then
//      key:=#0;
//  End;

end;

procedure TGestionAnalytique.Panel3Resize(Sender: TObject);
begin
FormateTailleColonne(GrDBEcritures,20,[3,9,3,3]);
FormateTailleColonne(GrDB_AtelierEcritures,20,[3,12,3]);
FormateTailleColonne(Gr_DBAffectation_def,20,[3,12,3]);

WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TGestionAnalytique.Panel2Resize(Sender: TObject);
begin
FormateTailleColonne(GrDBComptes,20,[3,12,3]);
FormateTailleColonne(GrDB_AtelierCompte,20,[3,12,3]);

WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TGestionAnalytique.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TGestionAnalytique.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TGestionAnalytique.Annuler1Click(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TGestionAnalytique.Fermer1Click(Sender: TObject);
begin
self.close;
end;

procedure TGestionAnalytique.GrDB_AtelierCompteExit(Sender: TObject);
var
focusGrille:TGrDBGrid;
begin
try//except
   try//finally
    if GrDB_AtelierCompte.DataSource.State in [dsinsert,dsedit] then
      begin
        focusGrille:=GrDB_AtelierCompte;
        TableGerePost(GrDB_AtelierCompte.DataSource.DataSet);
      end;
    if GrDBComptes.DataSource.State in [dsinsert,dsedit] then
      begin
        focusGrille:=GrDBComptes;
        TableGerePost(GrDBComptes.DataSource.DataSet);
      end;
   finally
//     if focusgrille<>GrDB_AtelierCompte then
//       begin
//          DMAnalytiques.CompteEnModif:='';
//          GrDBComptes.DataSource.DataSet.Refresh;
//       end;
   end;
except
  if focusGrille<>nil then (focusGrille as TGrDBGrid).SetFocus;
  abort;
end;
end;

procedure TGestionAnalytique.GrDB_AtelierCompteColExit(Sender: TObject);
Var
CtrlSaisie:TExceptLGR;
begin
Try
Case GrDB_AtelierCompte.datasource.State of
   dsedit,
   dsInsert:Begin
               try
                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Affect_Atelier_PourCompte(GrDB_AtelierCompte.SelectedField);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_Atelier
                //*************************************************************************
           1001,1000,1002:Begin
                        //abort;
                     End;
                // Traitement ID_Ligne
                //*************************************************************************
           2001,2000,2002:Begin
                        abort;
                     End;
                // Traitement Compte
                //*************************************************************************
           3001,3000,3002:Begin
                        abort;
                     End;
                // Traitement Libelle
                //*************************************************************************
                4000:Begin
                        //abort;
                     End;
                // Traitement Code_Atelier
                //*************************************************************************
                5000,5002:Begin
                        abort;
                     End;
                5001:begin//code non existant et <> de '*'
                       //afficher fenetre de création des ateliers
                        Application.Messagebox(Pchar('Cet atelier n"existe pas, vous devez d"abord le créer dans la fenêtre de création des ateliers et activités'),'Erreur de saisie',0);
                        abort;
                     end;
                // Traitement Ratio
                //*************************************************************************
                6000:Begin
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//               try
//                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Affect_Atelier(GrDB_AtelierCompte.SelectedField);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_Atelier
//                //*************************************************************************
//           0001,0000:Begin
//                        abort;
//                     End;
//                // Traitement ID_Ligne
//                //*************************************************************************
//           1001,1000:Begin
//                        abort;
//                     End;
//                // Traitement Compte
//                //*************************************************************************
//           2001,2000:Begin
//                        abort;
//                     End;
//                // Traitement Libelle
//                //*************************************************************************
//                3000:Begin
//                        abort;
//                     End;
//                // Traitement Code_Atelier
//                //*************************************************************************
//           4001,4000:Begin
//                        abort;
//                     End;
//                // Traitement Ratio
//                //*************************************************************************
//                5000:Begin
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
abort;
End;
End;


procedure TGestionAnalytique.Affectationducompte1Click(Sender: TObject);
begin
DMAnalytiques.AffecteLigneCourante;
end;


procedure TGestionAnalytique.TaEcriture_AnalAfterScroll_form(DataSet: TDataSet);
begin
  //j'active le timer
  TiFiltrageAffectationEcriture.Enabled:=true;

end;


procedure TGestionAnalytique.TaPlanAnalAfterScroll_form(DataSet: TDataSet);
begin
  //j'active le timer
  TiFiltrageAffectationCompte.Enabled:=true;

end;


procedure TGestionAnalytique.RxSBEcrTouteClick(Sender: TObject);
begin
DMAnalytiques.TaEcriture_Anal.OnFilterRecord :=DMAnalytiques.TaEcriture_AnalFilterRecord;
ChangementEtat_RX_Bouton;
end;

procedure TGestionAnalytique.RxSBEcrAffecteClick(Sender: TObject);
begin
DMAnalytiques.TaEcriture_Anal.OnFilterRecord :=DMAnalytiques.TaEcriture_AnalFilterRecordAffecte;
ChangementEtat_RX_Bouton;
end;

procedure TGestionAnalytique.RxSBEcrNonAffecteClick(Sender: TObject);
begin
DMAnalytiques.TaEcriture_Anal.OnFilterRecord :=DMAnalytiques.TaEcriture_AnalFilterRecordNonAffecte;
ChangementEtat_RX_Bouton;
end;

procedure TGestionAnalytique.PaToolsEcrResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([RxSBEcrToute,RxSBEcrAffecte,RxSBEcrNonAffecte],PaToolsEcr,90,0,5);
end;

procedure TGestionAnalytique.RxSBCptTousClick(Sender: TObject);
begin
DMAnalytiques.TaPlanAnalBeforeOpen(DMAnalytiques.TaPlanAnal);
if RxSBCptEcriture.Down then
  begin
    DMAnalytiques.TaPlanAnal.OnFilterRecord:=DMAnalytiques.TaPlanAnalFilterRecordEcriture;
    LaFiltre.Caption:='Tous les comptes qui possèdent des écritures.';
  end
else
  begin
    DMAnalytiques.TaPlanAnal.OnFilterRecord:=DMAnalytiques.TaPlanAnalFilterRecord;
    LaFiltre.Caption:='Tous les comptes.';
  end;
end;

procedure TGestionAnalytique.RxSBCptAffecteClick(Sender: TObject);
begin
DMAnalytiques.TaPlanAnalBeforeOpen(DMAnalytiques.TaPlanAnal);
if RxSBCptEcriture.Down then
  begin
    DMAnalytiques.TaPlanAnal.OnFilterRecord:=DMAnalytiques.TaPlanAnalFilterRecordAffecteUtilise;
    LaFiltre.Caption:='Tous les comptes déjà affèctés et qui possèdent des écritures.';
  end
else
  begin
    DMAnalytiques.TaPlanAnal.OnFilterRecord:=DMAnalytiques.TaPlanAnalFilterRecordAffecte;
    LaFiltre.Caption:='Tous les comptes déjà affèctés.';
  end;
end;

procedure TGestionAnalytique.RxSBCptNonAffecteClick(Sender: TObject);
begin
DMAnalytiques.TaPlanAnalBeforeOpen(DMAnalytiques.TaPlanAnal);
if RxSBCptEcriture.Down then
  begin
    DMAnalytiques.TaPlanAnal.OnFilterRecord:=DMAnalytiques.TaPlanAnalFilterRecordNonAffecteUtilise;
    LaFiltre.Caption:='Tous les comptes non affèctés et qui possèdent des écritures.';
  end
else
  begin
    DMAnalytiques.TaPlanAnal.OnFilterRecord:=DMAnalytiques.TaPlanAnalFilterRecordNonAffecte;
    LaFiltre.Caption:='Tous les comptes non affèctés.';
  end;
end;

procedure TGestionAnalytique.PaGaucheBasResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([RxSBAffecteToutesEcr,RxSBReAffecteToutesEcr,RxSBVideToutesEcr],PaGaucheBas,110,0,5);
end;

procedure TGestionAnalytique.RxSBAffecteToutesEcrClick(Sender: TObject);
begin
try
if  not (GrDB_AtelierEcritures.DataSource.DataSet.State in [dsinsert,dsedit])
and(not (GrDBEcritures.DataSource.DataSet.State in [dsinsert,dsedit])) then
if Application.MessageBox(Pchar('Etes-vous sûr de vouloir affecter toutes les lignes d''écriture vides '+#13+#10+'à partir de  l''affecter par défaut du compte ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
  if (RxSBEcrToute.down) then
    begin
      PaAffectation_def.Visible:=false;
      GrDBEcritures.DataSource :=nil;
      DMAnalytiques.DaAffect_Atelier_Ecriture.OnStateChange:=nil;
      DMAnalytiques.AffecteTouteLigne(true);//on n'affecte que celles qui sont vides
    end;

finally
  GrDBEcritures.DataSource :=DMAnalytiques.DaEcriture_Anal;
  PaAffectation_def.Visible:=true;
  DMAnalytiques.DaAffect_Atelier_Ecriture.OnStateChange:=DaAffect_AtelierEcritureStateChange;
end;
end;

procedure TGestionAnalytique.RxSBVideToutesEcrClick(Sender: TObject);
var
eventState1,eventState2:TNotifyEvent;
begin
try
if  not (GrDB_AtelierEcritures.DataSource.DataSet.State in [dsinsert,dsedit])and(not (GrDBEcritures.DataSource.DataSet.State in [dsinsert,dsedit])) then
begin
if Application.MessageBox(Pchar('Etes-vous sûr de vouloir supprimer l''affectation '+#13+#10+' de toutes les lignes d''écriture  ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
  if Application.MessageBox(Pchar('Toutes les affectations sont sur le point d''être supprimées '+#13+#10+' confirmez-vous cette action ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
      begin
      try
          eventState1:=GrDBEcritures.DataSource.OnStateChange;
          eventState2:=GrDB_AtelierEcritures.DataSource.OnStateChange;
          GrDB_AtelierEcritures.DataSource.DataSet.DisableControls;
          GrDBEcritures.DataSource.OnStateChange:=nil;
          GrDB_AtelierEcritures.DataSource.OnStateChange:=nil;
          PaAffectation_def.Visible:=false;
          GrDBEcritures.DataSource :=nil;
          if RxSBEcrAffecte.Down then
          DMAnalytiques.ViderTouteAffectationEcriture_SurSousSelection
          else
          if RxSBEcrToute.down then
            DMAnalytiques.ViderTouteAffectationEcriture;
      finally
      GrDBEcritures.DataSource :=DMAnalytiques.DaEcriture_Anal;
      ReEnableControls(GrDB_AtelierEcritures.DataSource.DataSet);
      GrDBEcritures.DataSource.OnStateChange:=eventState1;
      PaAffectation_def.Visible:=true;
      GrDB_AtelierEcritures.DataSource.OnStateChange:=eventState2;
      viderTable(TTable(GrDB_AtelierEcritures.DataSource.DataSet));
      end;
      end;
end;      
except
  showmessage('Problème à la réinitialisation de l''affectation des écritures');
  abort;
end;
end;

Procedure TGestionAnalytique.InitialiseTable_A_Nil;
Begin
if DMAnalytiques<>nil then
  begin
       DMAnalytiques.TaEcriture_Anal.OnFilterRecord :=nil;
       DMAnalytiques.TaPlanAnal.OnFilterRecord:=nil;
       InitDatasetEvent_A_Nil_Sur_Form([DMAnalytiques.TaEcriture_Anal,DMAnalytiques.TaPlanAnal,DMAnalytiques.DaActivite,
       DMAnalytiques.DaAtelier,DMAnalytiques.DaPlanAnal,DMAnalytiques.DaEcriture_Anal,DMAnalytiques.DaAffect_Atelier_Ecriture,DMAnalytiques.DaAffect_Atelier_compte]);
  end;
End;
procedure TGestionAnalytique.GrGrandLivreDblClick(Sender: TObject);
begin
if CtrlEnfonce then
 begin
   if (GrGrandLivre.Objects[1,GrGrandLivre.Row] <> nil) then
     if DetailEcritureCompte((GrGrandLivre.Objects[1,GrGrandLivre.Row] as TStrings).Strings[1],False,False) then
       if DMEcritures.QueryEcrCompte.Locate('ID_Piece',ListeID.Items[GrGrandLivre.Row],[]) then
          PieceEcritureCompte;
 end
 else
 begin
   if (GrGrandLivre.Objects[1,GrGrandLivre.Row] <> nil) then
     DetailEcritureCompte((GrGrandLivre.Objects[1,GrGrandLivre.Row] as TStrings).Strings[1],true,False);
 end;
end;

procedure TGestionAnalytique.GrGrandLivreKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
CtrlEnfonce:=(shift = [ssCtrl]);
end;

procedure TGestionAnalytique.GrGrandLivreKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
CtrlEnfonce:=(shift = [ssCtrl]);
end;


procedure TGestionAnalytique.ChangementEtat_RX_Bouton;
Begin
  RxSBVideToutesEcr.Enabled:=((not RxSBEcrNonAffecte.Down)and(GrDBEcritures.DataSource.DataSet.RecordCount>0));
  RxSBAffecteToutesEcr.Enabled:=((RxSBEcrToute.Down)and(GrDBEcritures.DataSource.DataSet.RecordCount>0));
  RxSBReAffecteToutesEcr.Enabled:=((RxSBEcrToute.Down)and(GrDBEcritures.DataSource.DataSet.RecordCount>0));
End;

procedure TGestionAnalytique.ToutReEnableControls;
begin
ReEnableControls(GrDBActivite.DataSource.DataSet);
ReEnableControls(GrDBAtelier.DataSource.DataSet);
ReEnableControls(GrDBComptes.DataSource.DataSet);
ReEnableControls(GrDB_AtelierCompte.DataSource.DataSet);
ReEnableControls(GrDBEcritures.DataSource.DataSet);
ReEnableControls(GrDB_AtelierEcritures.DataSource.DataSet);
ReEnableControls(Gr_DBAffectation_def.DataSource.DataSet);
end;


procedure TGestionAnalytique.GrDBComptesExit(Sender: TObject);
Var
CtrlSaisie:TExceptLGR;
begin
Try
Case GrDBComptes.datasource.State of
   dsedit,
   dsInsert:Begin
               try
                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_PlanAnal(GrDBEcritures.SelectedField);
               except
                case CtrlSaisie.NumErreur of
                // Traitement ID_GESTANAL
                //*************************************************************************
           2001,2000:Begin
                        //abort;
                     End;
                // Traitement CODE_GESTANAL
                //*************************************************************************
           3001,3000:Begin
                        abort;
                     End;
                End; // Fin du case
               End; // Fin du try
            End; // Fin Begin du dsInsert
//// Zone Edition
//   dsEdit:Begin
//               try
//                CtrlSaisie:=DMAnalytiques.CtrlSaisieTA_Affect_Atelier(GrDBEcritures.SelectedField);
//               except
//                case CtrlSaisie.NumErreur of
//                // Traitement ID_GESTANAL
//                //*************************************************************************
//           4001,4000:Begin
//                        //abort;
//                     End;
//                // Traitement CODE_GESTANAL
//                //*************************************************************************
//           5001,5000:Begin
//                        abort;
//                     End;
//                End; // Fin du case
//               End; // Fin du try
//            End; // Fin Begin du dsEdit
End; // Fin du Case

Except
abort;
End;
End;

procedure TGestionAnalytique.TiFiltrageAffectationEcritureTimer(Sender: TObject);
begin
try
if GrDBEcritures.canfocus then
begin
//if not empty(DMAnalytiques.TaEcriture_Anal.findfield('id').asstring) then
if gestionAnalytique.visible then
if GrDBEcritures.CanFocus then
  DMAnalytiques.TaEcriture_AnalCODE_GESTANAL.FocusControl;

DMAnalytiques.FiltrageTa_Affect_Atelier_SurEcritureCourante(DMAnalytiques.TaEcriture_Anal.findfield('id').asstring,DMAnalytiques.TaEcriture_Anal);


//if empty(DMAnalytiques.TaEcriture_Anal.findfield('CODE_GESTANAL').asstring) then
// begin
    if DMRech.TaTA_Compte_AtelierRech.Locate('Compte',DMAnalytiques.TaEcriture_Anal.findField('Compte').AsString,[]) then
     Begin
       FiltrageDataSet(DMAnalytiques.TA_Compte_Atelier_Lk,'Compte = '''+DMAnalytiques.TaEcriture_Anal.findField('Compte').AsString+'''');
       Gr_DBAffectation_def.Visible := true;
     End
    else
    begin
       if Gr_DBAffectation_def.Focused then GrDB_AtelierEcritures.SetFocus;
       PaAffectation_def.Caption := 'Aucun atelier par défaut pour le compte : '+DMAnalytiques.TaEcriture_Anal.findField('Compte').AsString;
       Gr_DBAffectation_def.Visible := False;
    end;
// End
//else
// begin
//     if Gr_DBAffectation_def.Focused then GrDB_AtelierEcritures.SetFocus;
//     Gr_DBAffectation_def.Visible := False;
// end;
end;
finally
TiFiltrageAffectationEcriture.Enabled:=false;
end;
end;

procedure TGestionAnalytique.TiFiltrageAffectationCompteTimer(
  Sender: TObject);
begin
try
if gestionAnalytique.visible then
  if GrDBComptes.CanFocus then
  DMAnalytiques.TaPlanAnalCODE_GESTANAL.FocusControl;
if not empty(DMAnalytiques.TaPlanAnal.findfield('Compte').asstring) then
  DMAnalytiques.FiltrageTa_Affect_Atelier_SurCompteCourant(DMAnalytiques.TaPlanAnal.findfield('Compte').asstring,DMAnalytiques.TaPlanAnal);
finally
  TiFiltrageAffectationCompte.Enabled:=false;
end;
end;

procedure TGestionAnalytique.FormKeyPress(Sender: TObject; var Key: Char);
begin
//if key=#32 then key:=#0;
end;

procedure TGestionAnalytique.PaGaucheBasClick(Sender: TObject);
begin
ReEnableControls(GrDB_AtelierEcritures.DataSource.DataSet);
ReEnableControls(GrDBEcritures.DataSource.DataSet);
ReEnableControls(GrDB_AtelierCompte.DataSource.DataSet);
ReEnableControls(GrDBComptes.DataSource.DataSet);
end;



procedure TGestionAnalytique.ChangementEtatTabSheet(Etat:TDataSetState);
var
activePage:Ttabsheet;
Begin
  En_Modif:=(etat in [dsinsert,dsedit]);
  RxSBEcrToute.Enabled:=not En_Modif;
  RxSBEcrAffecte.Enabled:=not En_Modif;
  RxSBEcrNonAffecte.Enabled:=not En_Modif;
End;
procedure TGestionAnalytique.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
AllowChange:=((not En_Modif)and(not e.ExerciceCloture));
if e.ExerciceCloture then showmessage(AccesEcranRefuse_General);
end;

procedure TGestionAnalytique.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnFermer,BtnImprimer,BtnExporter],PaBtn,90,0);
end;

procedure TGestionAnalytique.RxSBReAffecteToutesEcrClick(Sender: TObject);
begin
try
if  not (GrDB_AtelierEcritures.DataSource.DataSet.State in [dsinsert,dsedit])and(not (GrDBEcritures.DataSource.DataSet.State in [dsinsert,dsedit])) then
if Application.MessageBox(Pchar('Etes-vous sûr de vouloir affecter toutes les lignes d''écriture'+#13+#10+'à partir de  l''affecter par défaut du compte ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
    if (RxSBEcrToute.down) then
      begin
        PaAffectation_def.Visible:=false;
        GrDBEcritures.DataSource :=nil;
        DMAnalytiques.DaAffect_Atelier_Ecriture.OnStateChange:=nil;
        DMAnalytiques.AffecteTouteLigne(false);//on affecte toutes les lignes même celles déjà remplies
      end;

finally
  GrDBEcritures.DataSource :=DMAnalytiques.DaEcriture_Anal;
  PaAffectation_def.Visible:=true;
  DMAnalytiques.DaAffect_Atelier_Ecriture.OnStateChange:=DaAffect_AtelierEcritureStateChange;
end;
end;

procedure TGestionAnalytique.GrDBActiviteKeyPress(Sender: TObject;
  var Key: Char);
begin
if GrDBActivite.SelectedIndex in [0] then
  Begin
     key:=str_majusculeschar(key);
  End;
end;

procedure TGestionAnalytique.BtnImprimerClick(Sender: TObject);
begin
if(ActiveControl=GrDBAtelier)or((ActiveControl=GrDBActivite))then
begin
   if(ActiveControl=GrDBAtelier) then EditionAteliersL(C_EditionSimple,nil)
   else
   if(ActiveControl=GrDBActivite) then EditionActivitesL(C_EditionSimple,nil);
end
else
case PaTitreResult.tag of
  GRANDLIVRE:
  begin
    if application.MessageBox(Pchar('Voulez-vous imprimer par atelier plutôt que par activité ?'),'Confirmation',MB_ICONQUESTION +MB_YESNO+MB_DEFBUTTON1)=mryes then
      EditionGLivreAnalytiqueAtelierL(C_EditionSimple,True,nil,nil,nil)
    else
      EditionGLivreAnalytiqueActiviteL(C_EditionSimple,True,nil,nil,nil);
  end;
  BALANCE:
  begin
    if application.MessageBox(Pchar('Voulez-vous imprimer par atelier plutôt que par activité ?'),'Confirmation',MB_ICONQUESTION +MB_YESNO+MB_DEFBUTTON1)=mryes then
      EditionBalanceAnalytiqueAtelierL(C_EditionSimple,True,nil,nil,nil)
    else
      EditionBalanceAnalytiqueActiviteL(C_EditionSimple,True,nil,nil,nil);
  end;
end;
end;

procedure TGestionAnalytique.PaToolsCptResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([RxSBCptTous,RxSBCptAffecte,RxSBCptNonAffecte],PaToolsCpt,90,0,5);
FormateTailleBouttonAvecEspace([RxSBCptEcriture,RxSBCptEcritureOuNon],PaToolsCpt,90,0,5);
end;

procedure TGestionAnalytique.Panel13Resize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([RxSBCptTous,RxSBCptAffecte,RxSBCptNonAffecte],PaToolsCpt,90,0,5);
end;

procedure TGestionAnalytique.RxSBCptEcritureClick(Sender: TObject);
begin
if RxSBCptTous.Down then
  RxSBCptTousClick(RxSBCptTous);
if RxSBCptAffecte.Down then
  RxSBCptAffecteClick(RxSBCptAffecte);
if RxSBCptNonAffecte.Down then
  RxSBCptNonAffecteClick(RxSBCptNonAffecte);
end;



procedure TGestionAnalytique.Visualisation1Click(Sender: TObject);
begin
if ActiveControl=GrDBEcritures then
begin
    if DetailEcritureCompte(GrDBEcritures.DataSource.DataSet.findfield('Compte').asstring,False,False) then
      begin //si on trouve des pièces dans la période pour ce compte
       case DetailEcr.Tag of
          1:begin
            if DMEcritures.QueryEcrCompte.Locate('ID_Piece',GrDBEcritures.DataSource.DataSet.findfield('id_piece').asinteger,[]) then
              PieceEcritureTiers;
            end;
          2:begin
            if DMEcritures.QueryEcrCompte.Locate('ID_Piece',GrDBEcritures.DataSource.DataSet.findfield('id_piece').asinteger,[]) then
              PieceEcritureCompte;
            end;
       end;
      end;//fin si on trouve des pièces dans la période pour ce compte
end;
if ActiveControl=GrDBComptes then
begin
    DetailEcritureCompte(GrDBComptes.DataSource.DataSet.findfield('Compte').asstring,true,False);
end;
end;

procedure TGestionAnalytique.BtnExporterClick(Sender: TObject);
begin
case PaTitreResult.tag of
  GRANDLIVRE:EditionGLivreAnalytiqueAtelierL(C_EditionSimple,True,nil,nil,nil,1);
  BALANCE:EditionBalanceAnalytiqueAtelierL(C_EditionSimple,True,nil,nil,nil,1);
end;
end;

procedure TGestionAnalytique.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

procedure TGestionAnalytique.cbClasse6Click(Sender: TObject);
begin
DMAnalytiques.listeCompteResult.clear;
if(cbClasse6.Checked)then
  DMAnalytiques.listeCompteResult.Add('6');
if(cbClasse7.Checked)then
  DMAnalytiques.listeCompteResult.Add('7');
end;

procedure TGestionAnalytique.Modifierlelibell1Click(Sender: TObject);
var Value:String;
Requete : TQuery;
rang : integer;
begin
//modifier directement le libellé de l'atelier sans passer par le bouton enregister
  if(not e.ExerciceCloture)then
    begin
      rang:=DMAnalytiques.Ta_Atelier.findfield('ID_Atelier').AsInteger;
      value:=DMAnalytiques.Ta_Atelier.findfield('Libelle_Atelier').AsString;
       if(MyInputQuery(self,'Libellé de l''atelier','Saisir le nouveau libellé de l''atelier',
                     Value,'',[],100)) then
                begin
                  if Application.MessageBox(Pchar('Confirmez-vous l''enregistrement du nouveau libellé :'+
                  RetourChariotSimple+Value),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                  begin
                      try//finally
                      //enregistrer le libellé atelier dans la table
                        Requete := TQuery.Create(application.MainForm);
                        Requete.close;
                        Requete.DatabaseName := DM_C_NomAliasDossier;
                        Requete.SQL.Clear;         // deduc_invest = true and
                        value:=lib_chaine.Str_DoucleCar(value,'''') ;
                        Requete.SQL.Add('update TA_Atelier.db set Libelle_Atelier = '''+value+''' where ID_Atelier ='+IntToStr_Lgr(rang));
                        Requete.ExecSQL;
                        TableGereCommit(Requete);
                        DMAnalytiques.Ta_Atelier.Refresh;
                        Requete.close;
                      finally
                         DMAnalytiques.Ta_Atelier.Locate('ID_Atelier',rang,[]);
                         Requete.free;
                      end;
                  end;
    end;
end
    else Application.MessageBox(Pchar('l''exercice est clôturé, vous ne pouvez pas modifier ce libellé.'),'Attention',MB_ICONWARNING);

end;

procedure TGestionAnalytique.Modifierlelibell2Click(Sender: TObject);
var Value:String;
Requete : TQuery;
rang : integer;
begin
//modifier directement le libellé de l'atelier sans passer par le bouton enregister
  if(not e.ExerciceCloture)then
    begin
      rang:=DMAnalytiques.Ta_Activite.findfield('ID_Activite').AsInteger;
      value:=DMAnalytiques.Ta_Activite.findfield('Libelle_Activite').AsString;
       if(MyInputQuery(self,'Libellé de l''activité','Saisir le nouveau libellé de l''activité',
                     Value,'',[],100)) then
                begin
                  if Application.MessageBox(Pchar('Confirmez-vous l''enregistrement du nouveau libellé :'+
                  RetourChariotSimple+Value),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                  begin
                      try//finally
                      //enregistrer le libellé activité dans la table
                        Requete := TQuery.Create(application.MainForm);
                        Requete.close;
                        Requete.DatabaseName := DM_C_NomAliasDossier;
                        Requete.SQL.Clear;
                        value:=lib_chaine.Str_DoucleCar(value,'''') ;
                        Requete.SQL.Add('update Ta_Activite.db set Libelle_Activite = '''+value+''' where ID_Activite ='+IntToStr_Lgr(rang));
                        Requete.ExecSQL;
                        TableGereCommit(Requete);
                        DMAnalytiques.Ta_Activite.Refresh;
                        Requete.close;
                      finally
                         DMAnalytiques.Ta_Activite.Locate('ID_Activite',rang,[]);
                         Requete.free;
                      end;
                  end;
    end;
end
    else Application.MessageBox(Pchar('l''exercice est clôturé, vous ne pouvez pas modifier ce libellé.'),'Attention',MB_ICONWARNING);

end;

end.
