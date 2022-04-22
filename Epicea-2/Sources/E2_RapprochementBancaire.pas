// Penser à pouvoir afficher un relevé suivant des dates !!!!!!!!!!!!!!!!!!!!!!!
unit E2_RapprochementBancaire;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, GrGrid, StdCtrls, DBGrids, RXDBCtrl, ExRxDBGrid,
  GrDBGrid, Mask, ToolEdit, RXCtrls, Menus,E2_AideModel,DMRecherche,LibSQL,E2_Decl_Records
  ,E2_Librairie_Obj,LibZoneSaisie,db,GR_Librairie_Obj,Registry,DMConstantes,
  LibDAtes,
  LibFichRep,
  DMPlanCpt,
  LibRessourceString,
  jpeg,LibGestionParamXML, editions;

type
  TRappBanc = class(TForm)
    Patitre: TPanel;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSpeedButton4: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    Panel1: TPanel;
    PaGrille: TPanel;
    DBGridRappBanc: TGrDBGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
    PaCumul1: TPanel;
    Panel7: TPanel;
    ImEnTete: TImage;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    RxSBNonMarque: TRxSpeedButton;
    RxSBDejaMarque: TRxSpeedButton;
    RxSBTous: TRxSpeedButton;
    Panel2: TPanel;
    PaRepDebutCompta: TPanel;
    GrGrid6: TGrGrid;
    RxSBEnCours: TRxSpeedButton;
    GrGrid1: TGrGrid;
    Panel4: TPanel;
    Panel5: TPanel;
    GrGrid3: TGrGrid;
    Panel6: TPanel;
    Panel8: TPanel;
    GrGrid4: TGrGrid;
    Panel9: TPanel;
    Panel10: TPanel;
    GrGrid5: TGrGrid;
    Label1: TLabel;
    CBoxListeMarque: TComboBox;
    Panel3: TPanel;
    PaRepDebut: TPanel;
    GrGrid2: TGrGrid;
    Listelignesenrelation1: TMenuItem;
    N2: TMenuItem;
    PaBtnSupp: TPanel;
    BtnGestionReleve: TButton;
    BtnImportation: TButton;
    PaEdit: TPanel;
    RxSpeedButton3: TRxSpeedButton;
    Label6: TLabel;
    EdBanque: TEdit;
    EdLibelle: TEdit;
    Label5: TLabel;
    RxLabMArqueCourante: TEdit;
    BtnGestionReglement: TButton;
    BtnImportantEbics: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure EdBanqueExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure initTotaux;
    Procedure initTotaux2;
    Procedure initTotauxDejaMarque;
    procedure RxSBNonMarqueClick(Sender: TObject);
    procedure RxSBDejaMarqueClick(Sender: TObject);
    procedure RxSBTousClick(Sender: TObject);
    procedure RxSBEnCoursClick(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure DBGridRappBancEnter(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure EdBanqueKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    Procedure DaRappBancStateChange(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdBanqueEnter(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnImprimerClick(Sender: TObject);
    Procedure InitComboListMarque;
    procedure CBoxListeMarqueChange(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridRappBancKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridRappBancKeyPress(Sender: TObject; var Key: Char);
    Function DeMarquageEnCours(AfficheMessage:boolean):TExceptLGR;
    procedure Visualisation1Click(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormShow(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure BtnGestionReleveClick(Sender: TObject);
    procedure BtnImportationClick(Sender: TObject);
    function ValideJournalBancaire:boolean;
    procedure RxLabMArqueCouranteExit(Sender: TObject);
    procedure Listelignesenrelation1Click(Sender: TObject);
    procedure BtnGestionReglementClick(Sender: TObject);
    procedure BtnImportantEbicsClick(Sender: TObject);
  private
    { Déclarations privées }
    MarqueCourante : string;
//    TotauxReport:TTotauxBalance;
//    TotauxCompte:TTotauxCompte;
    Procedure InitLibelle(NumAffichage:Integer;DateDeb,DateFin:Tdate);
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    TypeAffichage:integer;
  end;

var
  RappBanc: TRappBanc;

implementation

uses DMRapprochementBancaire, DMDiocEtatBalance, E2_Main, E2_AideCompte,
  E2_DetailEcr, DMEcriture, DMPiece, RapprochementReleve, ImportReleve,
  InputQueryFrm_F, DmImportReleves, CreationReglementReleve,
  ImportReleveEbics, DiversProjets;
{$R *.DFM}

procedure TRappBanc.FormCreate(Sender: TObject);
Var
 Registre :TRegistry;
begin
  if DMRappBanc = nil then
    DMRappBanc:=TDMRappBanc.Create(Application.MainForm);
if DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
  TitreForm := 'Rapprochement Bancaire';
  SousTitreForm := CEcriture;
  try
    LibGestionParamXML.InitialiseForm(E.User,Self);
  except
    InitialiseFormPosDefaut(self);
  end;

  Registre:= TRegistry.Create;
  try
    with Registre do
    begin
       RootKey := HKEY_LOCAL_MACHINE;
       OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
     try
       EdLibelle.Text:=C_StrVide;
       EdBanque.Text:=ReadString('Banque');
       MarqueCourante := ReadString('Marque');
       if empty(MarqueCourante) then
         MarqueCourante := C_MarqueDefaut;
       RxLabMArqueCourante.Text:=MarqueCourante;
       DMRappBanc.MarqueCourante:=MarqueCourante;
     except
       EdBanque.Text:=C_StrVide;
       EdLibelle.Text:=C_StrVide;
       MarqueCourante := C_MarqueDefaut;
       RxLabMArqueCourante.Text:=MarqueCourante;
       DMRappBanc.MarqueCourante:=MarqueCourante;
     end;
    end;
  finally
    Registre.Free;
  end;
  DMRappBanc.DaEcr_RappBanc.OnStateChange:=DaRappBancStateChange;
  DBGridRappBanc.ReportCaption := C_StrVide;
end;

procedure TRappBanc.Aide1Click(Sender: TObject);
begin
if activeControl = EdBanque then
 begin
  AideModelAfficheJournauxBanque(EdBanque,True);
 end;
end;

procedure TRappBanc.EdBanqueExit(Sender: TObject);
begin
if ((ActiveControl<>btnAnnuler)and(ActiveControl<>btnFermer)and(ActiveControl<>BtnGestionReglement)
and(ActiveControl<>BtnGestionReleve)and(ActiveControl<>BtnImportation)and(ActiveControl<>BtnImportantEbics))then
begin
     if not ValideJournalBancaire then
     begin
       EdBanque.SetFocus;
       abort;
     end;
     initTotaux;
     FiltrageDataSet(DMRappBanc.TaEcr_RappBanc,'Compte = '''+EdBanque.text+'''');
     InitComboListMarque;

     if RxSBNonMarque.Down then RxSBNonMarqueClick(nil);
     if RxSBDejaMarque.down then RxSBDejaMarqueClick(nil);
     if RxSBTous.down then RxSBTousClick(nil);
     if RxSBEnCours.down then RxSBEnCoursClick(nil);

     if DBGridRappBanc.CanFocus then
     DBGridRappBanc.SetFocus;
end;
end;

procedure TRappBanc.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);

DBGridRappBanc.ParamColor:=true;
DBGridRappBanc.Param:=ParamUtil.CouleurDBGrid;
DBGridRappBanc.UpDateColor;

GrGrid1.ParamColor:=true;
GrGrid1.Param:=ParamUtil.CouleurDBGrid;
GrGrid1.DessineContourLigne:=false;
GrGrid1.UpDateColor;

GrGrid2.ParamColor:=true;
GrGrid2.Param:=ParamUtil.CouleurDBGrid;
GrGrid2.DessineContourLigne:=false;
GrGrid2.UpDateColor;

GrGrid3.ParamColor:=true;
GrGrid3.Param:=ParamUtil.CouleurDBGrid;
GrGrid3.DessineContourLigne:=false;
GrGrid3.UpDateColor;

GrGrid4.ParamColor:=true;
GrGrid4.Param:=ParamUtil.CouleurDBGrid;
GrGrid4.DessineContourLigne:=false;
GrGrid4.UpDateColor;

GrGrid5.ParamColor:=true;
GrGrid5.Param:=ParamUtil.CouleurDBGrid;
GrGrid5.DessineContourLigne:=false;
GrGrid5.UpDateColor;

PaRepDebut.Caption := 'Solde sur votre relevé de banque au : '+ DAteinfos(E.DatExoDebut).DateStr +'  ';
PaRepDebutCompta.Caption := 'Solde sur votre compta. au : '+ DAteinfos(E.DatExoDebut).DateStr +'  ';
     PaGrilleResize(PaGrille);
end;

Procedure TRappBanc.initTotaux;
var
SoldeDebit,SoldeCredit:Currency;
TotauxRappBanc:TTotauxRappBanc;
Debut,Fin:TTime;
Begin
     Debut:=Time;
GrGrid2.cells[0,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
GrGrid2.cells[1,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
DeFiltrageDataSet(DMrech.TaModelRech);
if GrLocate(DMrech.TaModelRech,'Compte',[EdBanque.text]) then
 begin
    TotauxRappBanc:=CalculTotauxRappBanc(EdBanque.Text,C_CalculerTout,e.DatExoDebut,e.DatExoFin);

    GrGrid6.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReportDebit);
    GrGrid6.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReportCredit);

    GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReportReleveBanqueDebit);
    GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReportReleveBanqueCredit);

    GrGrid5.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteDebit);
    GrGrid5.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteCredit);

    GrGrid4.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeCompteDebit);
    GrGrid4.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeCompteCredit);
 end
 else
 begin

 end;
     Fin:=Time;
//     AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'Débuggage.txt','"initTotaux"  Debut : '+TimeToStr(Debut)+' - Fin : '+TimeToStr(Fin)+' Temp : '+timetostr(Fin-Debut));
End;

Procedure TRappBanc.initTotaux2;
var
SoldeReleveBanqueDebit,SoldeReleveBanqueCredit:Currency;
TotauxRappBanc:TTotauxRappBanc;
Debut,Fin:TTime;
Begin
     Debut:=Time;

    TotauxRappBanc:=CalculTotauxRappBanc(EdBanque.Text,C_CalculerSoldeReleveBanque,e.DatExoDebut,e.DatExoFin);

   GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteNonMarqueDebit);
   GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteNonMarqueCredit);

   GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReleveBanqueDebit);
   GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReleveBanqueCredit);
     Fin:=Time;
//     AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'//Débuggage.txt','"initTotaux2"  Debut : '+TimeToStr(Debut)+' - Fin : '+TimeToStr(Fin)+' Temp : '+timetostr(Fin-Debut));

End;

Procedure TRappBanc.initTotauxDejaMarque;
var
SoldeDebit,SoldeCredit:Currency;
TotauxRappBanc:TTotauxRappBanc;
TotauxGeneric:TTotauxGeneric;
bookmark:TBookmark;
Debut,Fin:TTime;
Begin
     Debut:=Time;
InitLibelle(1,e.DatExoDebut,e.DatExoFin);

GrGrid2.cells[0,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
GrGrid2.cells[1,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
DeFiltrageDataSet(DMrech.TaModelRech);
if GrLocate(DMrech.TaModelRech,'Compte',[EdBanque.text]) then
 begin
    TotauxRappBanc:=CalculTotauxRappBanc(EdBanque.Text,C_CalculerTout,e.DatExoDebut,e.DatExoFin);

    GrGrid6.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReportDebit);
    GrGrid6.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReportCredit);

    GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReportReleveBanqueDebit);
    GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeReportReleveBanqueCredit);

    TableDisableControlBookMark(DBGridRappBanc.DataSource.DataSet,bookmark);
    TotauxGeneric:=SommeTotauxGenericQuery(['DebitSaisie','CreditSaisie'],DBGridRappBanc.DataSource.DataSet);
    TableEnableControlBookMark(DBGridRappBanc.DataSource.DataSet,bookmark);

    TotauxRappBanc.TotalMvtCompteDebit:=TotauxGeneric.Total1;
    TotauxRappBanc.TotalMvtCompteCredit:=TotauxGeneric.Total2;

    TotauxRappBanc.SoldeCompteDebit:=TotauxRappBanc.TotalMvtCompteDebit;
    TotauxRappBanc.SoldeCompteCredit:=TotauxRappBanc.TotalMvtCompteCredit;
    DetermineSolde(TotauxRappBanc.SoldeCompteDebit,TotauxRappBanc.SoldeCompteCredit);

    GrGrid5.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteDebit);
    GrGrid5.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.TotalMvtCompteCredit);

    GrGrid4.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeCompteDebit);
    GrGrid4.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxRappBanc.SoldeCompteCredit);
 end
 else
 begin

 end;
     Fin:=Time;
//     AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'//Débuggage.txt','"initTotauxDejaMarque"  Debut : '+TimeToStr(Debut)+' - Fin : '+TimeToStr(Fin)+' Temp : '+timetostr(Fin-Debut));
End;

procedure TRappBanc.RxSBNonMarqueClick(Sender: TObject);
begin
FiltrageDataSet(DMRappBanc.TaEcr_RappBanc,'Compte = '''+EdBanque.text+'''');
DMRappBanc.TaEcr_RappBanc.OnFilterRecord:=DMRappBanc.TaEcr_RappBancFilterRecord_NonMarque;
InitLibelle(0,e.DatExoDebut,e.DatExoFin);
DaRappBancStateChange(DMRappBanc.DaEcr_RappBanc);
end;

procedure TRappBanc.RxSBDejaMarqueClick(Sender: TObject);
begin
if RxSBDejaMarque.Down=false then
  RxSBDejaMarque.Down:=true;
CBoxListeMarqueChange(CBoxListeMarque);

DMRappBanc.TaEcr_RappBanc.OnFilterRecord:=DMRappBanc.TaEcr_RappBancFilterRecord_Marque;
DaRappBancStateChange(DMRappBanc.DaEcr_RappBanc);
initTotauxDejaMarque;
end;

procedure TRappBanc.RxSBTousClick(Sender: TObject);
begin
FiltrageDataSet(DMRappBanc.TaEcr_RappBanc,'Compte = '''+EdBanque.text+'''');
DMRappBanc.TaEcr_RappBanc.OnFilterRecord:=DMRappBanc.TaEcr_RappBancFilterRecord_Tous;
InitLibelle(2,e.DatExoDebut,e.DatExoFin);
//InitComboListMarque;
DaRappBancStateChange(DMRappBanc.DaEcr_RappBanc);
end;

procedure TRappBanc.RxSBEnCoursClick(Sender: TObject);
begin
FiltrageDataSet(DMRappBanc.TaEcr_RappBanc,'Compte = '''+EdBanque.text+'''');
DMRappBanc.TaEcr_RappBanc.OnFilterRecord:=DMRappBanc.TaEcr_RappBancFilterRecord_EnCours;
InitLibelle(3,e.DatExoDebut,e.DatExoFin);
//InitComboListMarque;
DaRappBancStateChange(DMRappBanc.DaEcr_RappBanc);
end;

procedure TRappBanc.PaGrilleResize(Sender: TObject);
begin
BtnImportantEbics.Enabled:=(e.TypeClient=CL_Cogere); //and (e.TypeUtilisateur=U_Comptable);
FormateTailleBouttonAvecEspace([RxSBNonMarque,RxSBDejaMarque,RxSBTous,RxSBEnCours],PaTools,90,0,5);
FormateTailleBouttonAvecEspace([BtnImportantEbics,BtnImportation,BtnGestionReglement,BtnGestionReleve],PaBtnSupp,170,0,5);

WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);
FormateTailleColonne(DBGridRappBanc,15,[2,2,4,2,2,2]);

// Solde report
PaRepDebut.Width:=RenvoiTailleColonne(DBGridRappBanc,[0,1,2,3])+10;
GrGrid2.ColWidths[0]:=DBGridRappBanc.ColWidths[4];
GrGrid2.ColWidths[1]:=DBGridRappBanc.ColWidths[5];

PaRepDebutCompta.Width:=RenvoiTailleColonne(DBGridRappBanc,[0,1,2,3])+10;
GrGrid6.ColWidths[0]:=DBGridRappBanc.ColWidths[4];
GrGrid6.ColWidths[1]:=DBGridRappBanc.ColWidths[5];

// Grilles d'en bas
Panel10.Width:=RenvoiTailleColonne(DBGridRappBanc,[0,1,2,3])+10;
GrGrid5.ColWidths[0]:=DBGridRappBanc.ColWidths[4];
GrGrid5.ColWidths[1]:=DBGridRappBanc.ColWidths[5];

Panel8.Width:=RenvoiTailleColonne(DBGridRappBanc,[0,1,2,3])+10;
GrGrid4.ColWidths[0]:=DBGridRappBanc.ColWidths[4];
GrGrid4.ColWidths[1]:=DBGridRappBanc.ColWidths[5];

Panel5.Width:=RenvoiTailleColonne(DBGridRappBanc,[0,1,2,3])+10;
GrGrid3.ColWidths[0]:=DBGridRappBanc.ColWidths[4];
GrGrid3.ColWidths[1]:=DBGridRappBanc.ColWidths[5];

Panel7.Width:=RenvoiTailleColonne(DBGridRappBanc,[0,1,2,3])+10;
GrGrid1.ColWidths[0]:=DBGridRappBanc.ColWidths[4];
GrGrid1.ColWidths[1]:=DBGridRappBanc.ColWidths[5];
end;

procedure TRappBanc.DBGridRappBancEnter(Sender: TObject);
begin
DBGridRappBanc.SelectedIndex := DBGridRappBanc.ColCount;
end;

procedure TRappBanc.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TRappBanc.EdBanqueKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
 begin
  key := #9;
  //DBGridRappBanc.SetFocus;
 end;
end;

procedure TRappBanc.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TRappBanc.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

Procedure TRappBanc.DaRappBancStateChange(Sender: TObject);
var
Debut,Fin:TTime;
begin
     Debut:=Time;

ChangementEtatGrille(DBGridRappBanc);
  case DMRappBanc.DaEcr_RappBanc.State of
     dsBrowse:Begin
               MarqueCourante:=DMRappBanc.MarqueCourante;
               RxLabMArqueCourante.Text:=MarqueCourante;
               if RxSBDejaMarque.Down then
                 initTotauxDejaMarque
               else
                 begin
                   initTotaux;
                   initTotaux2;
                 end;
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               BtnInserer.Enabled := (DMRappBanc.TaEcr_RappBanc.RecordCount <> 0);
               BtnModifier.Enabled := (DMRappBanc.TaEcr_RappBanc.RecordCount <> 0);
               BtnSupprimer.Enabled := (DMRappBanc.TaEcr_RappBanc.RecordCount <> 0);
               BtnImprimer.Enabled := true;
               InitComboListMarque;
              End;
     dsEdit:Begin
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
            End;
  end;
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
// Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMPlan.daPlanCpt.DataSet)+NBRecord_Str(DMPlan.daPlanCpt.DataSet);
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMRappBanc.DaEcr_RappBanc.DataSet)+NBRecord_Str(DMRappBanc.DaEcr_RappBanc.DataSet);
     Fin:=Time;
     //AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'Débuggage.txt','"DaRappBancStateChange"  Debut : '+TimeToStr(Debut)+' - Fin : '+TimeToStr(Fin)+' Temp : '+timetostr(Fin-Debut));
     PaGrilleResize(PaGrille);
end;

procedure TRappBanc.BtnInsererClick(Sender: TObject);
begin
if empty(DMRappBanc.TaEcr_RappBanc.FindField('Rapprochement').AsString) then
 begin
   DMRappBanc.TaEcr_RappBanc.Edit;
   DMRappBanc.TaEcr_RappBanc.FindField('Rapprochement').AsString := MarqueCourante;
   TableGerePost(DMRappBanc.TaEcr_RappBanc);
    DMRappBanc.TaEcr_RappBanc.Next;
 end
 else
 begin
        DMRappBanc.TaEcr_RappBanc.Next;
 end;
end;

procedure TRappBanc.BtnSupprimerClick(Sender: TObject);
var
retour:boolean;
begin
if not empty(DMRappBanc.TaEcr_RappBanc.FindField('Rapprochement').AsString) then
 begin
//   retour:=DMImportReleve.GestionRelationMarqueRapprochement(DMRappBanc.TaEcr_RappBanc.FindField('marqueReleve').AsString,
//     DMRappBanc.TaEcr_RappBanc.FindField('Rapprochement').AsString,DMRappBanc.GererReleveDirect,DMRappBanc.TaEcr_RappBanc.FindField('id').AsInteger);
//   if  retour then
//     begin
      DMRappBanc.TaEcr_RappBanc.Edit;
      DMRappBanc.TaEcr_RappBanc.FindField('Rapprochement').AsString := C_StrVide;
      DMRappBanc.TaEcr_RappBanc.FindField('marqueReleve').AsString := C_StrVide;
      TableGerePost(DMRappBanc.TaEcr_RappBanc);
//   end
//   else abort;
//   DMRappBanc.TaEcr_RappBanc.next;
 end
 else
 begin
   DMRappBanc.TaEcr_RappBanc.Next;
 end;
DMRappBanc.GererReleveDirect:=false;
end;

procedure TRappBanc.BtnModifierClick(Sender: TObject);
begin
  if DMRappBanc.TaEcr_RappBanc.State = dsBrowse then
    DMRappBanc.TaEcr_RappBanc.Edit;
end;

procedure TRappBanc.BtnEnregistrerClick(Sender: TObject);
begin
  if DMRappBanc.TaEcr_RappBanc.State = dsEdit then
     TableGerePost(DMRappBanc.TaEcr_RappBanc);
  DMRappBanc.ListeMarquageEnCours.clear;
  DMRappBanc.TaEcr_RappBanc.Refresh;
end;

procedure TRappBanc.FormDestroy(Sender: TObject);
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
      // WriteString('Banque',EdBanque.Text);
       WriteString('Marque',MarqueCourante);
     except
       CloseKey
     end;
  end;
   finally
    Registre.Free;
   end;
  InitialiseTable_A_Nil;
  LibGestionParamXML.DestroyForm(Self,E.USer);

  if DMRappBanc <> nil then
    DMRappBanc.Free;
  RappBanc := nil;
end;

procedure TRappBanc.EdBanqueEnter(Sender: TObject);
begin
FiltrageDataSet(DMRappBanc.TaEcr_RappBanc,'ID = -1');
end;

procedure TRappBanc.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TRappBanc.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if DMRappBanc <> nil then
 begin
     // Si l'utilisateur est en mode Modification
     If DBGridRappBanc.DataSource.DataSet.State = dsEdit Then
     Begin
        self.WindowState:=wsNormal;
        self.BringToFront;
        if application.MessageBox(Pchar('Voulez-vous enregistrer le marquage en cours ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
         begin
           BtnEnregistrerClick(BtnEnregistrer);
           canclose:=true;
          end
          else
           begin
             canclose:=true;
           end;
     End; // Fin utilisateur est en mode Modification

     //s'il y a des marquages en cours, demander si on veut les valider
     If DMRappBanc.ListeMarquageEnCours.Count<>0 Then
     Begin
        self.WindowState:=wsNormal;
        self.BringToFront;
        if application.MessageBox(Pchar('Voulez-vous enregistrer les marquages en cours ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
         begin
           BtnEnregistrerClick(BtnEnregistrer);
           canclose:=true;
          end
          else
           begin
           //Effacer les rapprochements en cours à partir de la liste "ListeMarquageEnCours"
           if DeMarquageEnCours(true).retour then
             canclose:=true
           else
             canclose:=false;
           end;
     End; // Fin utilisateur est en mode Modification
  end;//fin si DMRappBanc <> nil
if CanClose then
  DMRappBanc.ListeMarquageEnCours.Clear
 else
 begin
    if DMRappBanc=nil then
   DMRappBanc:=TDMRappBanc.Create(self);

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);
//   abort;
 end;
end;

procedure TRappBanc.BtnImprimerClick(Sender: TObject);
var
Site:TEditLien;
begin
  EditionEtatRapprochementL(EdBanque.Text,C_EditionSimple,TypeAffichage,DBGridRappBanc.DataSource.DataSet)
end;

Procedure TRappBanc.InitComboListMarque;
Var
I:Integer;
Begin
I:=CBoxListeMarque.ItemIndex;
CBoxListeMarque.Clear;
CBoxListeMarque.Items.Assign(DMRappBanc.ListeMarque(EdBanque.Text));
CBoxListeMarque.Items.Insert(0,' Toutes les marques ...');
if ((I < 0) or (I > CBoxListeMarque.Items.Count)) then
CBoxListeMarque.ItemIndex := 0
else
CBoxListeMarque.ItemIndex := I;
End;


procedure TRappBanc.CBoxListeMarqueChange(Sender: TObject);
var
Debut,Fin:TTime;
Begin
     Debut:=Time;
if CBoxListeMarque.ItemIndex > 0 then
 begin
   DMRappBanc.marqueSpecifique:=CBoxListeMarque.Items[CBoxListeMarque.ItemIndex];
   FiltrageDataSet(DMRappBanc.TaEcr_RappBanc,'Compte = '''+EdBanque.text+''' and Rapprochement = '''+DMRappBanc.marqueSpecifique+'''');
   if not RxSBDejaMarque.down then
     RxSBDejaMarque.Click;
 end
 else
   begin
     FiltrageDataSet(DMRappBanc.TaEcr_RappBanc,'Compte = '''+EdBanque.text+'''');
     DMRappBanc.marqueSpecifique:='';
   end;
initTotauxDejaMarque;
     Fin:=Time;
//     AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'//Débuggage.txt','"CBoxListeMarqueChange"  Debut : '+TimeToStr(Debut)+' - Fin : '+TimeToStr(Fin)+' Temp : '+timetostr(Fin-Debut));
end;

procedure TRappBanc.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TRappBanc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[DBGridRappBanc,DBGridRappBanc.InplaceEditor]);
     If Key = VK_ESCAPE Then
     Begin

       If DBGridRappBanc.DataSource.State = dsBrowse Then
          begin
            if DBGridRappBanc.Focused then edbanque.SetFocus
              else
            if edbanque.Focused then Self.Close;
          end;

      If DBGridRappBanc.DataSource.State = dsInsert Then
          Begin
               If Messagedlg('Annuler le rapprochement bancaire en cours ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DBGridRappBanc.DataSource.dataset.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;


          If DBGridRappBanc.DataSource.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de ce rapprochement bancaire ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DBGridRappBanc.DataSource.dataset.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
     End;
end;

procedure TRappBanc.DBGridRappBancKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_INSERT then
 begin
  key:=0;
  BtnInserer.Click;
 end;
if key=VK_SPACE then
  Begin
    key:=0;
    if not empty(DBGridRappBanc.DataSource.DataSet.FindField('Rapprochement').asstring) then
      BtnSupprimer.Click
    else
      BtnInserer.Click;
  End;
if key = VK_DELETE then
 begin
  key:=0;
  BtnSupprimer.Click;
 end;
end;

procedure TRappBanc.DBGridRappBancKeyPress(Sender: TObject; var Key: Char);
begin
if key=#32 then key:=#0;
end;


Function TRappBanc.DeMarquageEnCours(AfficheMessage:boolean):TExceptLGR;
var
EtatFiltre:TEtatFiltre;
Begin
  try//try finally
    try//try except
Initialise_ExceptLGR(result);
      result.retour:=true;
      DMRappBanc.TaEcr_RappBanc.DisableControls;
      TableSauveEtatFiltre(DMRappBanc.TaEcr_RappBanc,EtatFiltre);
      DeFiltrageDataSet(DMRappBanc.TaEcr_RappBanc);
      DMRappBanc.TaEcr_RappBanc.Filtered := true;
      DMRappBanc.TaEcr_RappBanc.OnFilterRecord:=DMRappBanc.TaEcr_RappBancFilterRecord_DemarquageEnCours;
      DMRappBanc.TaEcr_RappBanc.Refresh;
      DMRappBanc.TaEcr_RappBanc.First;
      while DMRappBanc.TaEcr_RappBanc.RecordCount<>0 do
        Begin
          DMRappBanc.GererReleveDirect:=true;
          BtnSupprimerClick(nil);
          DMRappBanc.TaEcr_RappBanc.first;
        End;
    except
       raise ExceptLGR.Create('Erreur lors de la suppression des marquages en cours !',1001,AfficheMessage,mtError,result);
       result.retour:=false;
    end;//fin du try except
  finally
    TableRestoreEtatFiltre(DMRappBanc.TaEcr_RappBanc,EtatFiltre);
    ReEnableControls(DMRappBanc.TaEcr_RappBanc);
    DMRappBanc.GererReleveDirect:=false;
//    DMRappBanc.TaEcr_RappBanc.OnFilterRecord:=Event;
  end;//fin du try finally
End;

Procedure TRappBanc.InitLibelle(NumAffichage:Integer;DateDeb,DateFin:Tdate);
var
Debut,Fin:TTime;
Begin
     Debut:=Time;
TypeAffichage:=NumAffichage;
case NumAffichage of
  0:Begin
      DBGridRappBanc.ReportCaption := 'Non Marqués';
      Panel10.Caption := 'Mouvements du '+datetostr(DateDeb)+' au '+datetostr(DateFin)+' :  ';
      Panel8.Caption := 'Solde ( votre compta.) au '+datetostr(DateFin)+' :  ';
      Panel5.Caption := 'Mouvements non marqués au '+datetostr(DateFin)+' : ';
      Panel7.Caption := 'Solde sur le relevé de banque au '+datetostr(DateFin)+' :  ';
      VisibleControl([Panel8,GrGrid4,Panel5,Panel7,GrGrid3,GrGrid1],True);
      VisibleControl([Panel10,GrGrid5],false);
    End;

  1:Begin
      // initialisation des libellés des Panels
      DBGridRappBanc.ReportCaption := 'Déjà Marqués';
      Panel10.Caption := 'Total des mouvements marqués : ';
      Panel8.Caption := 'Solde des mouvements marqués : ';
      Panel5.Caption := C_StrVide;
      Panel7.Caption := C_StrVide;
      VisibleControl([Panel5,Panel7,GrGrid3,GrGrid1],false);
      VisibleControl([Panel10,Panel8,GrGrid4,GrGrid5],true);

    End;

  2:Begin
      DBGridRappBanc.ReportCaption := 'Tous';
      Panel10.Caption := 'Mouvements du '+datetostr(DateDeb)+' au '+datetostr(DateFin)+' :  ';
      Panel8.Caption := 'Solde ( votre compta.) au '+datetostr(DateFin)+' :  ';
      Panel5.Caption := 'Mouvements non marqués au '+datetostr(DateFin)+' : ';
      Panel7.Caption := 'Solde sur le relevé de banque au '+datetostr(DateFin)+' :  ';
      VisibleControl([Panel5,Panel7,GrGrid3,GrGrid1],True);
      VisibleControl([Panel10,Panel8,GrGrid4,GrGrid5],True);
    End;

  3:Begin
      DBGridRappBanc.ReportCaption := 'Marquage en cours ...';
      Panel10.Caption := 'Mouvements du '+datetostr(DateDeb)+' au '+datetostr(DateFin)+' :  ';
      Panel8.Caption := 'Solde ( votre compta.) au '+datetostr(DateFin)+' :  ';
      Panel5.Caption := 'Mouvements non marqués au '+datetostr(DateFin)+' : ';
      Panel7.Caption := 'Solde sur le relevé de banque au '+datetostr(DateFin)+' :  ';
      VisibleControl([Panel5,Panel7,GrGrid3,GrGrid1],True);
      VisibleControl([Panel10,Panel8,GrGrid4,GrGrid5],True);
    End;

else showmessage('RappBanc.InitLibelle : Cas inconnu !');
end;
     Fin:=Time;
//     AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'//Débuggage.txt','"InitLibelle"  Debut : '+TimeToStr(Debut)+' - Fin : '+TimeToStr(Fin)+' Temp : '+timetostr(Fin-Debut));

End;

procedure TRappBanc.Visualisation1Click(Sender: TObject);
var
PeriodeAutre_Tmp:TPeriode;
cpt:string;
Begin
try

e.PeriodeAutreImpression.Retour:=true;
E.PeriodeAutreImpression.DateDeb:=0;
E.PeriodeAutreImpression.DateFin:=e.DatExoFin;
PeriodeAutre_Tmp:=E.PeriodeAutre;
e.AutrePeriode:=true;
E.PeriodeAutre:=E.PeriodeAutreImpression;
if ActiveControl=EdBanque then
  Begin
    //
  end
else
  Begin
    if not empty(DMRappBanc.TaEcr_RappBanc.findfield('Tiers').asstring)then
      begin//si tiers
         if DetailEcritureTiers(DMRappBanc.TaEcr_RappBanc.findfield('Tiers').asstring,false) then
           case DetailEcr.Tag of
              1:begin
                if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMRappBanc.TaEcr_RappBanc.findfield('ID_Piece').AsInteger,[]) then
                  PieceEcritureTiers;
                end;
           end;//fin du case
      end//fin si tiers
    else
      Begin//si compte pointable
         if DetailEcritureCompte(DMRappBanc.TaEcr_RappBanc.findfield('compte').asstring,false,false) then
           case DetailEcr.Tag of
              2:begin
                if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMRappBanc.TaEcr_RappBanc.findfield('ID_Piece').AsInteger,[]) then
                  PieceEcritureCompte;
                end;
           end;//fin du case
      End;//fin si compte pointable
  end;
Finally
    E.PeriodeAutre:=PeriodeAutre_Tmp;
    E.AutrePeriode:=PeriodeAutre_Tmp.Retour;
end;
end;

Procedure TRappBanc.InitialiseTable_A_Nil;
Begin
if DMRappBanc<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMRappBanc.DaEcr_RappBanc,DMRappBanc.TaEcr_RappBanc]);
End;
procedure TRappBanc.FormShow(Sender: TObject);
begin
if EdBanque.CanFocus then EdBanque.SetFocus;
end;

procedure TRappBanc.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

procedure TRappBanc.BtnGestionReleveClick(Sender: TObject);
var
ParamAfficheReleve:TParamAfficheReleve;
result:integer;
datefin:Tdate;
legende:Tlabel;
begin
if  DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
if not ValideJournalBancaire then EdBanque.SetFocus
else
  begin
      datefin:=now;
      legende:=Tlabel.create(self);
      legende.Caption:='Indiquer la marque de rapprochement bancaire à utiliser'+RetourChariotSimple+'dans l''écran de rapprochement des relevés.';
      //InputQuery(legende.Caption,legende.Caption,marquecourante);
      if not MyInputQuery_Date(self,'Date de fin de relevé','Indiquer la date de fin du relevé.',
          datefin,'',[#0]) then exit;
      if not MyInputQuery(self,'Marque de rapprochement bancaire',legende.Caption,
          marquecourante,'',[ #33..#38, #40..#58, #60..#126],8) then exit;

      RxLabMArqueCourante.Text:=MarqueCourante;
      DMRappBanc.MarqueCourante:=MarqueCourante;
      ParamAfficheReleve.Titre:='';
      ParamAfficheReleve.Direct:=false;
      ParamAfficheReleve.DateFinReleve:=datefin;
      ParamAfficheReleve.Marque:=MarqueCourante;
      ParamAfficheReleve.journal:=EdBanque.Text;
      ParamAfficheReleve.libelleJournal:=EdLibelle.Text;
      result :=RapprochementRelevesAffiche(ParamAfficheReleve);
      if result=mrok then
        begin
          EdBanque.SetFocus;
          DBGridRappBanc.SetFocus;
//          EdBanqueExit(EdBanque)
        end
//      else
//        EdBanque.SetFocus;
  end;
end;

procedure TRappBanc.BtnImportationClick(Sender: TObject);
begin
//if()then
//begin
if  DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
if  ImportationReleve=nil then ImportationReleve:=TImportationReleve.Create(self);
    ImportationReleve.ShowModal;
//end
//else
//begin
//if  ImportationReleveEbics=nil then ImportationReleveEbics:=TImportationReleveEbics.Create(self);
//    ImportationReleveEbics.ShowModal;
//end;


end;


function TRappBanc.ValideJournalBancaire:boolean;
begin
result:=true;
  try
    DMPlan.TaCompte.OnFilterRecord:=DMPlan.TaCompteFilterRecord;
    DMPieces.GestionFiltrageParamCpt(3);
    //if (not AideCompteDansContexte(EdBanque.Text,EdBanque,['Rac1'],false,MessDerSub,true,true,false,true,0)) and (not AideModelAfficheJournauxBanque(EdBanque,False))then
   if (not AideCompteExiste(EdBanque.Text,nil)) then
     begin
       if (not AideModelAfficheJournauxBanque(EdBanque,False))then
          begin
             result:=false;
          end
     end ;
if result then
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
     end;
  except
    result:=false;
  end;
end;


procedure TRappBanc.RxLabMArqueCouranteExit(Sender: TObject);
begin
marquecourante:=RxLabMArqueCourante.Text;
end;

procedure TRappBanc.Listelignesenrelation1Click(Sender: TObject);
begin
DMImportReleve.AffichageListeRelation(DMRappBanc.TaEcr_RappBanc.FindField('MarqueReleve').AsString,
DMRappBanc.TaEcr_RappBanc.FindField('Rapprochement').AsString,
DMRappBanc.TaEcr_RappBanc.FindField('id').Asinteger);
end;

procedure TRappBanc.BtnGestionReglementClick(Sender: TObject);
var
ParamAfficheReleve:TParamAfficheReleve;
result:integer;
datefin:Tdate;
legende:Tlabel;
begin
if  DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
if not ValideJournalBancaire then
  EdBanque.SetFocus
else
  begin
      datefin:=now;
 //     legende:=Tlabel.create(self);
//      legende.Caption:='Indiquer la marque de rapprochement bancaire à utiliser'+RetourChariotSimple+'dans l''écran de rapprochement des relevés.';
      //InputQuery(legende.Caption,legende.Caption,marquecourante);
      if not MyInputQuery_Date(self,'Date de fin de relevé','Indiquer la date de fin du relevé.',
          datefin,'',[#0]) then exit;
//      if not MyInputQuery(self,'Marque de rapprochement bancaire',legende.Caption,
//          marquecourante,'',[ #33..#38, #40..#58, #60..#126],8) then exit;

      RxLabMArqueCourante.Text:=MarqueCourante;
      DMRappBanc.MarqueCourante:=MarqueCourante;
      ParamAfficheReleve.Titre:='';
      ParamAfficheReleve.Direct:=false;
      ParamAfficheReleve.DateFinReleve:=datefin;
      ParamAfficheReleve.Marque:=MarqueCourante;
      ParamAfficheReleve.journal:=EdBanque.Text;
      ParamAfficheReleve.libelleJournal:=EdLibelle.Text;
      result :=CreationReglementRelevesAffiche(ParamAfficheReleve);
      if result=mrok then
        begin
          EdBanque.SetFocus;
          DBGridRappBanc.SetFocus;
//          EdBanqueExit(EdBanque)
        end
//      else
//        EdBanque.SetFocus;
  end;
end;

procedure TRappBanc.BtnImportantEbicsClick(Sender: TObject);
begin
if  DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
if  ImportationReleveEbics=nil then ImportationReleveEbics:=TImportationReleveEbics.Create(self);
    ImportationReleveEbics.ShowModal;
end;

end.
