unit E2_BalanceNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, ExtCtrls, StdCtrls, Mask,
  ToolEdit, CurrEdit, RXCtrls,DB, DBCtrls,registry,Gr_Librairie_obj, RXSplit,
  Buttons,LibSQL,E2_Librairie_obj,LibDates, ComCtrls,LibZoneSaisie,
  Menus, TeEngine, Series, TeeProcs, Chart,E2_Decl_Records,dbtables, DBChart,DMDiocEtatBalance
  //,LibConvertisseur
  ,DMPointages2,E2_LibInfosTable,LibRessourceString,DMConstantes, DiversProjets,
  jpeg,
  Lib_chaine,
  DMCorrection,
  LibGestionParamXML,
  E2_GesPlanCpt_PM,
  editions,
  LibChoixCompte,
  E2_Recherche,
   Gauges;

type
  TParamAfficheBalance = record
   CompteACherche:String;
   end;

  TMyCustGrid = class(TCustomGrid)
  end;

  TBalanceNew = class(TForm)
    Patitre: TPanel;
    PaGrilleBal: TPanel;
    PaGrilleDetail: TPanel;
    PaBas: TPanel;
    PaSolde: TPanel;
    PaLibelle: TPanel;
    PaReport: TPanel;
    PaMouv: TPanel;
    PaSoldeFin: TPanel;
    PaCptIntit: TPanel;
    GrDBGridDetail: TGrDBGrid;
    CurEdTotDebReport: TCurrencyEdit;
    CurEdTotCreReport: TCurrencyEdit;
    RxLabTotaux: TRxLabel;
    RxLabSolde: TRxLabel;
    CurEdSoldeReport: TCurrencyEdit;
    CurEdSoldeCreReport: TCurrencyEdit;
    CurEdTotDebBase: TCurrencyEdit;
    CurEdTotCreBase: TCurrencyEdit;
    CurEdSoldeDebBase: TCurrencyEdit;
    CurEdSoldeCreBase: TCurrencyEdit;
    CurEdTotDebGen: TCurrencyEdit;
    CurEdTotCreGen: TCurrencyEdit;
    CurEdSoldeDebGen: TCurrencyEdit;
    CurEdSoldeCreGen: TCurrencyEdit;
    RxSplitter1: TRxSplitter;
    PaSelectCpt: TPanel;
    RxSBClose: TRxSpeedButton;
    RxSBValider: TRxSpeedButton;
    RxSBInverse: TRxSpeedButton;
    RxSBAnnuleSel: TRxSpeedButton;
    CheckBox1: TCheckBox;
    Panel2: TPanel;
    GrDBGridBal: TGrDBGrid;
    Panel1: TPanel;
    Panel3: TPanel;
    BtnClasse1: TSpeedButton;
    BtnClasse2: TSpeedButton;
    BtnClasse3: TSpeedButton;
    BtnClasse4: TSpeedButton;
    BtnClasse5: TSpeedButton;
    BtnClasse6: TSpeedButton;
    BtnClasse7: TSpeedButton;
    BtnClasse8: TSpeedButton;
    BtnClasse9: TSpeedButton;
    Label1: TLabel;
    EditDebutPer: TDateEdit;
    EditFinPer: TDateEdit;
    RxSBValidePeriode: TRxSpeedButton;
    PopupMenu1: TPopupMenu;
    DtailsF71: TMenuItem;
    Masquerdtailscompte1: TMenuItem;
    EdRech: TEdit;
    PageControl1: TPageControl;
    PaTTabSheet: TPanel;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    DBText1: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    LaDebit: TLabel;
    LaCredit: TLabel;
    LaDate: TLabel;
    CurMontantTransDeb: TCurrencyEdit;
    EdCompte: TEdit;
    CurMontantTransCre: TCurrencyEdit;
    DateOD: TDateEdit;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DBChart1: TDBChart;
    Imprimer1: TMenuItem;
    TbSMAJBalance: TTabSheet;
    Panel4: TPanel;
    RxSBRecalculBalOuverture: TRxSpeedButton;
    RxSBRecalculBalExercice: TRxSpeedButton;
    RxSBRecalaculBalTotale: TRxSpeedButton;
    RxLabTitre: TRxLabel;
    ImEnTete: TImage;
    RxSpeedButton3: TRxSpeedButton;
    RxSpeedButton4: TRxSpeedButton;
    RxSpeedButton5: TRxSpeedButton;
    RxSpeedButton6: TRxSpeedButton;
    RxSpeedButton7: TRxSpeedButton;
    RxSpeedButton8: TRxSpeedButton;
    RxSpeedButton9: TRxSpeedButton;
    RxSpeedButton10: TRxSpeedButton;
    RxSpeedButton11: TRxSpeedButton;
    RxSpeedButton12: TRxSpeedButton;
    RxSpeedButton13: TRxSpeedButton;
    RxSpeedButton14: TRxSpeedButton;
    RxSpeedButton15: TRxSpeedButton;
    RxSpeedButton16: TRxSpeedButton;
    RxSpeedButton17: TRxSpeedButton;
    RxSpeedButton18: TRxSpeedButton;
    RxSpeedButton19: TRxSpeedButton;
    ShapeCalendrier: TShape;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBDetail: TRxSpeedButton;
    Label2: TLabel;
    RxSBDetailPointage: TRxSpeedButton;
    Rglements1: TMenuItem;
    DtailsPointages1: TMenuItem;
    ExportationBalance1: TMenuItem;
    RxSBPlanCpt: TRxSpeedButton;
    ImprimerGrandLivre1: TMenuItem;
    ModifierPice1: TMenuItem;
    TiRecupSoldeBalance: TTimer;
    Timer1: TTimer;
    Timer2: TTimer;
    Gauge1: TGauge;
    Aide1: TMenuItem;
    RxChListCpt: TListView;
    RxSBCreeOD: TButton;
    RxSBCreeVoirOD: TButton;
    Calculatrice1: TMenuItem;
    Balance1: TMenuItem;
    BalanceCerfaLiasse1: TMenuItem;
    Panel5: TPanel;
    Label6: TLabel;
    EdLibelle: TEdit;
    LaResultat: TLabel;
    EdResultat: TCurrencyEdit;
    laComplResultat: TLabel;
    procedure GrDBGridBalDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GrDBGridBalMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure PaGrilleBalResize(Sender: TObject);
    procedure RxSBDetailClick(Sender: TObject);
    procedure RxSBDetailMouseEnter(Sender: TObject);
    procedure RxSBDetailMouseLeave(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    Procedure initialiseTableEvent;
    procedure FormDestroy(Sender: TObject);
    procedure GrDBGridDetailDblClick(Sender: TObject);
    procedure PaCptIntitClick(Sender: TObject);
    procedure RxSBCloseClick(Sender: TObject);
    procedure PaSelectCptResize(Sender: TObject);
    procedure RxChListCptDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure RxSBValiderClick(Sender: TObject);
    procedure RxSBAnnuleSelClick(Sender: TObject);
    procedure RxSBInverseClick(Sender: TObject);
    procedure RxSBValidePeriodeClick(Sender: TObject);
    Procedure InitTotaux(ListeFiltre:TstringList;ChampFiltre:String);
    procedure EditFinPerKeyPress(Sender: TObject; var Key: Char);
    procedure EditDebutPerAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure EditFinPerAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure PaGrilleDetailResize(Sender: TObject);
    procedure RxSBCreeODClick(Sender: TObject);
    procedure CurMontantTransDebDblClick(Sender: TObject);
    procedure CurMontantTransCreDblClick(Sender: TObject);
    procedure EdCompteDblClick(Sender: TObject);
    procedure CurMontantTransDebChange(Sender: TObject);
    procedure CurMontantTransCreChange(Sender: TObject);
    function CtrlSaisie(Valeur:string;Champ:Tcomponent;focus:boolean=false):TExceptLGR;
    procedure RxSBCreeVoirODClick(Sender: TObject);
    procedure GrDBGridBalTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure Imprimer1Click(Sender: TObject);
    procedure RxSBRecalculBalExerciceClick(Sender: TObject);

    Procedure CalcSolde;
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure RxSpeedButton15Click(Sender: TObject);
    procedure RxSpeedButton16Click(Sender: TObject);
    procedure RxSpeedButton17Click(Sender: TObject);
    procedure RxSpeedButton18Click(Sender: TObject);
    procedure RxSpeedButton19Click(Sender: TObject);
    procedure EdRechChange(Sender: TObject);
    procedure EditDebutPerExit(Sender: TObject);
    procedure EditFinPerExit(Sender: TObject);
    procedure GrDBGridBalColEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function CreationOD_avecObjet(TableEnCours:TTable;ODModif:string):TStringList;
    procedure EditDebutPerEnter(Sender: TObject);
    procedure EditFinPerEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxSBDetailPointageClick(Sender: TObject);
    procedure Rglements1Click(Sender: TObject);
    procedure DtailsPointages1Click(Sender: TObject);
    Procedure InitBalanceNew(Type_Utilisation:Integer);
    procedure RxSBPlanCptClick(Sender: TObject);
    procedure RxSBPlanCptMouseLeave(Sender: TObject);
    procedure RxSBPlanCptMouseEnter(Sender: TObject);
    procedure ImprimerGrandLivre1Click(Sender: TObject);
    procedure ModifierPice1Click(Sender: TObject);
    procedure TiRecupSoldeBalanceTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure RxChListCptColumnClick(Sender: TObject; Column: TListColumn);
    procedure RxChListCptCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure RxChListCptKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxChListCptDblClick(Sender: TObject);
    procedure DateODExit(Sender: TObject);
    procedure EdCompteExit(Sender: TObject);
    procedure CurMontantTransDebExit(Sender: TObject);
    procedure CurMontantTransCreExit(Sender: TObject);
    procedure DaBalancePourODAutoDataChange(Sender: TObject;
      Field: TField);
    procedure PageControl2Change(Sender: TObject);
    procedure DateODAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure GestionDernierPositionnement(Repositionnement : boolean = false);
    procedure Calculatrice1Click(Sender: TObject);
    procedure Balance1Click(Sender: TObject);
    procedure BalanceCerfaLiasse1Click(Sender: TObject);
    procedure RxSBGrapheClick(Sender: TObject);
    procedure EdLibelleExit(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    SavePlaceMaitre:string;
    SavePlaceDetail:string;
//    SavePlaceDetail:TBookMark;
  end;

var
  BalanceNew: TBalanceNew;
  ordretri:integer;
  ListeCpt:TStringList;
//  ListeTmp:TStringList;
  ListeLibelle:TStringList;

  Function BalanceAffiche(ParamAfficheBalance:TParamAfficheBalance):Boolean;

implementation

uses
DMBalances,DMEcriture, E2_Main, E2_DetailEcr, E2_AideCompte,DMPiece,
  DMImportation,DMBaseDonnee, E2_Pointages2, DMJournaux,
  E2_SaisieReglement, E2_AffectReglement,DMRecherche, DMPlanCpt,
  //UQReport,
  DMExports, DMXMLs, E2_SaisieP_3, E2_BalanceNewT, AnalyseGraphique,
  E2_ChoixReglementAuto;

{$R *.DFM}

Function BalanceAffiche(ParamAfficheBalance:TParamAfficheBalance):Boolean;
Begin
try
   result:=false;
   if BalanceNew = nil then BalanceNew:=TBalanceNew.Create(application);
   BalanceNew.GestionDernierPositionnement;
//   BalanceNew.SavePlaceMaitre:=BalanceNew.GrDBGridBal.DataSource.DataSet.findfield('Compte').AsString;
//   BalanceNew.SavePlaceDetail:=BalanceNew.GrDBGridDetail.DataSource.DataSet.findfield('id').AsString;

   BalanceNew.Show;
//   BalanceNew.EdCompte.Text:=ParamAffichPlan.CompteASelectionner;
except
abort;
end;
End;

Procedure TBalanceNew.InitBalanceNew(Type_Utilisation:Integer);
Begin
  case Type_Utilisation of

    CT_DEVELOPPEMENT:Begin
                     End;

    CT_DISTRIBUTION:Begin
                      // Traitement du menu spécifique pour COGERE
//                      VisibleItemMenu([ExportationBalance1],(E.TypeClient = CL_Cogere));
//                      EnableItemMenu([ExportationBalance1],(E.TypeClient = CL_Cogere));
                    End;

  else showmessage('Le type de l''exécutable n''est pas défini !');
  end;

End;

procedure TBalanceNew.GrDBGridBalDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  holdColor: TColor;
  RectLine:TRect;
begin
  holdColor := GrDBGridBal.Canvas.Brush.Color; {store the original color}
//if
//  if Column.FieldName = 'Compte' then  begin
//      GrDBGridBal.Canvas.Brush.Color := clGray;
//      GrDBGridBal.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      GrDBGridBal.Canvas.Brush.Color := holdColor;
//    end;
//  if Column.FieldName = 'Intitule' then  begin
//      GrDBGridBal.Canvas.Brush.Color := clGray;
//      GrDBGridBal.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      GrDBGridBal.Canvas.Brush.Color := holdColor;
//    end;


//  if Column.FieldName = 'TDebRep' then  begin
//      GrDBGridBal.Canvas.Brush.Color := $005959FF;//$00808040;
//      GrDBGridBal.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      GrDBGridBal.Canvas.Brush.Color := holdColor;
//    end;
//  if Column.FieldName = 'Debit_Base' then  begin
//      GrDBGridBal.Canvas.Brush.Color := $005959FF;//$00808040;
//      GrDBGridBal.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      GrDBGridBal.Canvas.Brush.Color := holdColor;
//    end;
//  if Column.FieldName = 'TDebTot' then  begin
//      GrDBGridBal.Canvas.Brush.Color := $005959FF;//$00808040;//$005959FF
//      GrDBGridBal.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      GrDBGridBal.Canvas.Brush.Color := holdColor;
//    end;
//  if Column.FieldName = 'TCreRep' then  begin
//      GrDBGridBal.Canvas.Brush.Color := $00808040;
//      GrDBGridBal.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      GrDBGridBal.Canvas.Brush.Color := holdColor;
//    end;
//  if Column.FieldName = 'Credit_Base' then  begin
//      GrDBGridBal.Canvas.Brush.Color := $00808040;
//      GrDBGridBal.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      GrDBGridBal.Canvas.Brush.Color := holdColor;
//    end;
//  if Column.FieldName = 'TCreTot' then  begin
//      GrDBGridBal.Canvas.Brush.Color := $00808040;
//      GrDBGridBal.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//      GrDBGridBal.Canvas.Brush.Color := holdColor;
//    end;


//GrDBGridBal.
//GrDBGridBal.GridLineWidth
//     LastRow:=Row;
    GrDBGridBal.Canvas.Pen.Color:=Clred;
    GrDBGridBal.Canvas.Pen.Width:=2;
////    Canvas.Font.Size:=font.size+1;
    GrDBGridBal.Canvas.Font.Size:=font.size;
//    Canvas.Font.Color:=Font.color;
    RectLine:=(TMyCustGrid(GrDBGridBal)).Boxrect(0,GrDBGridBal.Row,GrDBGridBal.VisibleColCount,GrDBGridBal.Row);
    GrDBGridBal.Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Bottom-2),point(RectLine.Left+1,RectLine.Bottom-2)]);
//    GrDBGridBal.Canvas.Polyline([Point(RectLine.Left,RectLine.Top),Point(RectLine.Right,RectLine.Top),Point(RectLine.Right,RectLine.Bottom),point(RectLine.Left,RectLine.Bottom)]);

//begin
//case DataCol of
//   0:GrDBGridBal.Color:=clred;
//   1: ;
//   else GrDBGridBal.Color:=clWindow;
//end;
end;

procedure TBalanceNew.GrDBGridBalMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  z: word;
  TempBookmark: TBookMark;
begin
if ssctrl in shift then
 begin
  GrDBGridBal.Datasource.Dataset.DisableControls;
  with GrDBGridBal.SelectedRows do
  if Count > 0 then
  begin
    TempBookmark:= GrDBGridBal.Datasource.Dataset.GetBookmark;
    for z:= 0 to Count - 1 do
    begin
      if IndexOf(Items[z]) > -1 then
      begin
        GrDBGridBal.Datasource.Dataset.Bookmark:= Items[z];
        showmessage(GrDBGridBal.Datasource.Dataset.Fields[0].AsString);
      end;
    end;
  end;
  GrDBGridBal.Datasource.Dataset.GotoBookmark(TempBookmark);
  GrDBGridBal.Datasource.Dataset.FreeBookmark(TempBookmark);
  GrDBGridBal.Datasource.Dataset.EnableControls;
  end;
end;

procedure TBalanceNew.FormActivate(Sender: TObject);
Var
AnneeCivile:Boolean;
begin

Initialiser_ShortCut_Main(true);

{**** à enlever dès que possible en l'arrangeant au préalable *******isa le 26/11/02}
TabSheet1.TabVisible:=true;
TabSheet2.TabVisible:=true;
TabSheet3.TabVisible:=false;
TbSMAJBalance.TabVisible:=false;
if sender<>nil then PageControl2.ActivePage:=PageControl2.Pages[TabSheet2.PageIndex];
{***********  isa le 26/11/02}

initialiseTableEvent;

RxSBAnnuleSelClick(RxSBAnnuleSel);

GrDBGridBal.ParamColor:=true;
GrDBGridBal.Param:=ParamUtil.CouleurDBGrid;
GrDBGridBal.UpDateColor;
GrDBGridBal.FSauteColReadOnly:=false;

GrDBGridDetail.ParamColor:=true;
GrDBGridDetail.Param:=ParamUtil.CouleurDBGrid;
GrDBGridDetail.UpDateColor;
GrDBGridDetail.FSauteColReadOnly:=false;

PaLibelle.Color:=GrDBGridBal.Color;
PaSolde.Color:=GrDBGridBal.Color;
RxChListCpt.Color:=GrDBGridBal.Color;
RxChListCpt.Font.Color:=GrDBGridBal.Font.Color;
Patitre.visible:=Main.AfficheTitre;


case RxSBDetail.Tag of
  1:Begin
     PaGrilleDetail.Visible:=true;
     PaGrilleBal.Align:=AlTop;
     RxSBDetail.Caption:='M&asquer détails compte';
    End;

  2:Begin
     PaGrilleDetail.Visible:=false;
     PaGrilleBal.Align:=alClient;
     RxSBDetail.Caption:='&Afficher détails compte';
    End;
end;
PaReport.caption:='Solde Report au '+ DateInfos(EditDebutPer.Date).DateStr;
PaMouv.Caption:='Mouv. du ' + DateInfos(EditDebutPer.Date).DateStr + ' au ' + DateInfos(EditFinPer.Date).DateStr;
PaMouv.Hint:=PaMouv.Caption;
PaSoldeFin.Caption:='Solde Fin au ' + DateInfos(EditFinPer.Date).DateStr;
CouleurFond([EditDebutPer,EditFinPer],ParamUtil.CouleurDBGrid.GrilleColorFond);
if ((ActiveControl = EditDebutPer) or (ActiveControl = EditFinPer)) then
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,nil,0,0);

Self.Caption :=TitreForm+' - '+SousTitreForm;

TableRefreshSurClose(DMDiocEtatBal.TaBalanceaffich,'Compte');

AnneeCivile:= ((DateInfos(E.DatExoDebut).JourStr = '01') and (DateInfos(E.DatExoDebut).MoisStr = '01')
               and
                (DateInfos(E.DatExoFin).JourStr = '31') and (DateInfos(E.DatExoFin).MoisStr = '12'));
EnableRxButton([RxSpeedButton3,
                RxSpeedButton4,
                RxSpeedButton5,
                RxSpeedButton6,
                RxSpeedButton7,
                RxSpeedButton8,
                RxSpeedButton9,
                RxSpeedButton10,
                RxSpeedButton11,
                RxSpeedButton12,
                RxSpeedButton13,
                RxSpeedButton14,
                RxSpeedButton15,
                RxSpeedButton16,
                RxSpeedButton17,
                RxSpeedButton18
                ],AnneeCivile);
Timer2.Enabled:=true;
      GestionDernierPositionnement(true);
      GestionDernierPositionnement;

//   if BalanceNew.GrDBGridBal.DataSource.DataSet.locate('compte',BalanceNew.SavePlaceMaitre,[loCaseInsensitive,loPartialKey])then
//      BalanceNew.GrDBGridDetail.DataSource.DataSet.Locate('id',strtoint_lgr(BalanceNew.SavePlaceDetail),[loCaseInsensitive,loPartialKey]);
//   BalanceNew.SavePlaceMaitre:=BalanceNew.GrDBGridBal.DataSource.DataSet.findfield('Compte').AsString;
//   BalanceNew.SavePlaceDetail:=BalanceNew.GrDBGridDetail.DataSource.DataSet.findfield('id').AsString;

//  GrDBGridDetail.DataSource.DataSet.GotoBookmark(SavePlaceDetail);
end;

procedure TBalanceNew.PaGrilleBalResize(Sender: TObject);
begin
GrDBGridBal.ColWidths[1]:=(GrDBGridBal.Width) div 10;
GrDBGridBal.ColWidths[2]:=(GrDBGridBal.Width) div 6;
GrDBGridBal.ColWidths[3]:=(GrDBGridBal.Width) div 9;
GrDBGridBal.ColWidths[4]:=(GrDBGridBal.Width) div 9;
GrDBGridBal.ColWidths[5]:=(GrDBGridBal.Width) div 9;
GrDBGridBal.ColWidths[6]:=(GrDBGridBal.Width) div 9;
GrDBGridBal.ColWidths[7]:=(GrDBGridBal.Width) div 9;
GrDBGridBal.ColWidths[8]:=(GrDBGridBal.Width) div 9;

// Colonnes 1 et 2
PaCptIntit.Width:=GrDBGridBal.ColWidths[0]+GrDBGridBal.ColWidths[1]+GrDBGridBal.ColWidths[2]+7;
RxLabTotaux.Width:=PaCptIntit.Width;
RxLabSolde.Width:=PaCptIntit.Width;
PaSelectCpt.Width:=PaCptIntit.Width-10;

// Colonnes 3 et 4
PaReport.Left:=PaCptIntit.Width;
PaReport.Width:=GrDBGridBal.ColWidths[3]+GrDBGridBal.ColWidths[4]+2;

CurEdTotDebReport.Left:=PaReport.Left;
CurEdTotDebReport.Width:=GrDBGridBal.ColWidths[3]+1;

CurEdSoldeReport.Left:=CurEdTotDebReport.Left;
CurEdSoldeReport.Width:=CurEdTotDebReport.Width;

CurEdTotCreReport.Left:=CurEdTotDebReport.Left+GrDBGridBal.ColWidths[3];
CurEdTotCreReport.Width:=GrDBGridBal.ColWidths[4]+2;

CurEdSoldeCreReport.Left:=CurEdTotDebReport.Left+GrDBGridBal.ColWidths[3];
CurEdSoldeCreReport.Width:=GrDBGridBal.ColWidths[4]+2;

// Colonnes 5 et 6
PaMouv.Left:=PaCptIntit.Width+PaReport.Width;
PaMouv.Width:=GrDBGridBal.ColWidths[5]+GrDBGridBal.ColWidths[6]+2;

CurEdTotDebBase.Left:=PaMouv.Left;
CurEdTotDebBase.Width:=GrDBGridBal.ColWidths[5]+1;

CurEdSoldeDebBase.Left:=CurEdTotDebBase.Left;
CurEdSoldeDebBase.Width:=CurEdTotDebBase.Width;

CurEdTotCreBase.Left:=CurEdSoldeDebBase.Left+GrDBGridBal.ColWidths[5];
CurEdTotCreBase.Width:=GrDBGridBal.ColWidths[6]+2;

CurEdSoldeCreBase.Left:=CurEdTotCreBase.Left;//+GrDBGridBal.ColWidths[5];
CurEdSoldeCreBase.Width:=GrDBGridBal.ColWidths[6]+2;

// Colonnes 7 et 8
PaSoldeFin.Left:=PaCptIntit.Width+PaReport.Width+PaMouv.Width;
PaSoldeFin.Width:=GrDBGridBal.ColWidths[7]+GrDBGridBal.ColWidths[8]+2;

CurEdTotDebGen.Left:=PaSoldeFin.Left;
CurEdTotDebGen.Width:=GrDBGridBal.ColWidths[7]+1;

CurEdSoldeDebGen.Left:=CurEdTotDebGen.Left;
CurEdSoldeDebGen.Width:=CurEdTotDebGen.Width;

CurEdTotCreGen.Left:=CurEdTotDebGen.Left+GrDBGridBal.ColWidths[7];
CurEdTotCreGen.Width:=GrDBGridBal.ColWidths[8]+2;

CurEdSoldeCreGen.Left:=CurEdTotDebGen.Left+GrDBGridBal.ColWidths[7];
CurEdSoldeCreGen.Width:=GrDBGridBal.ColWidths[8]+2;

WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);

//BtnAnnuler.Left:=(PaBtn.Width-630) div 2;
//BtnEnregistrer.Left:=BtnAnnuler.Left +89;
//BtnInserer.Left:=BtnAnnuler.Left+178;
//BtnModifier.Left:=BtnAnnuler.Left+267;
//BtnSupprimer.Left:=BtnAnnuler.Left+356;
//BtnFermer.Left:=BtnAnnuler.Left+445;
//BtnImprimer.left:=BtnAnnuler.Left+534;

end;

procedure TBalanceNew.RxSBDetailClick(Sender: TObject);
begin
//showmessage(floattostr(DMBalance.QuSumBalanceSoldebase.AsCurrency));
if PaGrilleDetail.Visible
   then
       begin
       RxSBDetail.Tag:=2;
       PaGrilleDetail.Visible:=false;
       PaGrilleBal.Align:=alClient;
       RxSBDetail.Caption:='&Afficher détails compte';
       end
   else
       begin
       RxSBDetail.Tag:=1;
       PaGrilleBal.Align:=AlTop;
       PaGrilleBal.Height:=192;
       PaGrilleDetail.Visible:=true;
       PaGrilleDetail.Align:=alClient;
       RxSplitter1.Top:=241;
       RxSplitter1.Align:=AlTop;
       RxSBDetail.Caption:='M&asquer détails compte';
       end;
Masquerdtailscompte1.Caption:=RxSBDetail.Caption;
end;

procedure TBalanceNew.RxSBDetailMouseEnter(Sender: TObject);
begin
RxSBDetail.Font.Color:=clREd;
RxSBDetail.Font.Style:=[fsBold];
end;

procedure TBalanceNew.RxSBDetailMouseLeave(Sender: TObject);
begin
RxSBDetail.Font.Color:=clWindowText;
RxSBDetail.Font.Style:=[];
end;

procedure TBalanceNew.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
//Var
//Registre :TRegistry;
begin
// PB le 28/09/03if Main.Monofenetrage then
// begin
//    Registre:= TRegistry.Create;
//    try
//       with Registre do begin
//          RootKey := HKEY_LOCAL_MACHINE;
//          OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, True);
//          begin
//            WriteInteger('Detail',RxSBDetail.tag);
//          end;
//          CloseKey;
//       end;
//    finally
//       LibGestionParamXML.DestroyForm(Self,e.User);
//       Registre.Free;
//    end;
// end;


DMXml.ModifieVarEcran(E.User,self.Name,'Detail',IntToSTr(RxSBDetail.tag));
LibGestionParamXML.DestroyForm(Self,e.User);

//if self.ModalResult = mrok then LibGestionParamXML.DestroyForm(self,E.USer);
if PaSelectCpt.Visible then PaSelectCpt.Visible:=false;
CanClose:=true;

if CanClose then
 begin
  InitialiseTable_A_Nil{ isa  le  29/01/04 }
 end
else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);
 end;

end;

procedure TBalanceNew.FormCreate(Sender: TObject);
//Var
// Registre :TRegistry;
begin

  if AideCompte=nil then AideCompte:=TAideCompte.Create(self);
  if DMPieces=nil then DMPieces:=TDMPieces.Create(self);
  if DMEcritures=nil then DMEcritures:=TDMEcritures.Create(self);
  if DMDiocEtatBal = nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);

  try
   LibGestionParamXML.InitialiseForm(E.User,Self);
  except
   Position:=poDesigned;
   InitialiseFormPosDefaut(self);
  end;
  try
   RxSBDetail.Tag:=StrToInt_lgr(DMXml.RetourneValItemVarEcran(E.User,Self.name,'Detail'));
  except
   RxSBDetail.Tag:=1;
  end;

//   Registre:= TRegistry.Create;
//   try
//     with Registre do
//     begin
//      RootKey := HKEY_LOCAL_MACHINE;
//      OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
//      try
//      RxSBDetail.Tag:=ReadInteger('Detail');
//      except
//      RxSBDetail.Tag:=1;
//      end;
//   end;
//  finally
//  Registre.Free;
//end;
case RxSBDetail.Tag of
  1: ;
  2: ;
else RxSBDetail.Tag:=2;
end;
ListeCpt:=TStringList.Create;
//Listetmp:=TStringList.Create;
ListeLibelle:=TStringList.Create;
EditDebutPer.Date:=E.DatExoDebut;
EditFinPer.Date:=E.DatExoFin;
DateOD.Date:=now;
if (strtodate(DateOD.Text)<E.DatExoDebut)then
DateOD.Text:=datetostr(E.DatExoDebut);
if (strtodate(DateOD.Text)>E.DatExoFin) then
DateOD.Text:=datetostr(E.DatExoFin);

CurEdTotDebReport.DisplayFormat:=E.FormatMonnaie;
CurEdSoldeReport.DisplayFormat:=E.FormatMonnaie;
CurEdTotCreReport.DisplayFormat:=E.FormatMonnaie;
CurEdSoldeCreReport.DisplayFormat:=E.FormatMonnaie;
CurEdTotDebBase.DisplayFormat:=E.FormatMonnaie;
CurEdSoldeDebBase.DisplayFormat:=E.FormatMonnaie;
CurEdTotCreBase.DisplayFormat:=E.FormatMonnaie;
CurEdSoldeCreBase.DisplayFormat:=E.FormatMonnaie;
CurEdTotDebGen.DisplayFormat:=E.FormatMonnaie;
CurEdSoldeDebGen.DisplayFormat:=E.FormatMonnaie;
CurEdTotCreGen.DisplayFormat:=E.FormatMonnaie;
CurEdSoldeCreGen.DisplayFormat:=E.FormatMonnaie;
CurMontantTransDeb.DisplayFormat:=E.FormatMonnaie;
CurMontantTransCre.DisplayFormat:=E.FormatMonnaie;

InitBalanceNew(Type_version_execution);
//DMBalance.QuCalculSurPeriode(EditDebutPer.Date,EditFinPer.Date);
end;

Procedure TBalanceNew.InitialiseTable_A_Nil;
Begin
if(DMDiocEtatBal<>nil)then
    InitDatasetEvent_A_Nil_Sur_Form([DMDiocEtatBal.TaBalanceaffich]);
if(DMBalance<>nil)then
    InitDatasetEvent_A_Nil_Sur_Form([DMBalance.TaBalance]);
End;

Procedure TBalanceNew.initialiseTableEvent;
Begin
//   DMBalance.QueryEcriture.AfterScroll -> A initialiser au besoin, pour cause de rapidité
//DMDiocEtatBal.TaBalanceAffich.AfterScroll:=TaBalanceAfterScroll;
End;

procedure TBalanceNew.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
InitialiseTable_A_Nil;
 Registre:= TRegistry.Create;
 try
    with Registre do begin
       RootKey := HKEY_LOCAL_MACHINE;
       OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, True);
       begin
         WriteInteger('Detail',RxSBDetail.tag);
       end;
       CloseKey;
    end;
 finally
    LibGestionParamXML.DestroyForm(Self,e.User);
    Registre.Free;
    BalanceNew:=nil;
    ListeCpt.Free;
//    Listetmp.Free;
    ListeLibelle.Free;
 end;
end;

procedure TBalanceNew.GrDBGridDetailDblClick(Sender: TObject);
begin
try
GestionDernierPositionnement;
//   BalanceNew.SavePlaceMaitre:=BalanceNew.GrDBGridBal.DataSource.DataSet.findfield('Compte').AsString;
//   BalanceNew.SavePlaceDetail:=BalanceNew.GrDBGridDetail.DataSource.DataSet.findfield('id').AsString;

//SavePlaceDetail := GrDBGridDetail.DataSource.DataSet.GetBookmark;
GrDBGridBal.DataSource.DataSet.DisableControls;
GrDBGridDetail.DataSource.DataSet.DisableControls;

if activecontrol=GrDBGridBal then
 begin
      { isa  le  09/03/05 }
//      DetailEcritureCompte(DMDiocEtatBal.TaBalanceaffichCompte.AsString,true,((paramutil.maintenance)and(paramutil.TypeMaintenance='MaintS')));
            DetailEcritureCompte(DMDiocEtatBal.TaBalanceaffichCompte.AsString,true,true);
//    case GrDBGridBal.SelectedIndex of
//      2,3:DetailEcritureCompte(DMDiocEtatBal.TaBalanceaffichCompte.AsString,true,false);
//      4,5,6,7:DetailEcritureCompte(DMDiocEtatBal.TaBalanceaffichCompte.AsString,true,false);
//    end;//fin du case
 end
else
if activecontrol=GrDBGridDetail then
    begin
        case GrDBGridDetail.SelectedIndex of
           0..2,4..6:if DetailEcritureCompte(DMDiocEtatBal.TaBalanceaffichCompte.AsString,False,False) then
        //   0..2,4..6:if DetailEcritureCompte(DMBalance.QuBalanceAffich.FindField('Compte').AsString,False) then
                       case DetailEcr.Tag of
                          1:begin
                            if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMEcritures.TaEcritureBal.findfield('ID_Piece').AsInteger,[]) then
                              PieceEcritureTiers;
                            end;
                          2:begin
                            if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMEcritures.TaEcritureBal.findfield('ID_Piece').AsInteger,[]) then
                              PieceEcritureCompte;
                            end;
                       end;
           3:DetailEcritureTiers(DMEcritures.TaEcritureBal.FindField('Tiers').AsString,True);
        end;//fin du case GrDBGridDetail
    end;
finally
ReEnableControls(GrDBGridBal.DataSource.DataSet);
ReEnableControls(GrDBGridDetail.DataSource.DataSet);
end;
end;

procedure TBalanceNew.PaCptIntitClick(Sender: TObject);
var
i:integer;
Mark:TBookmark;
ListeTmp:Tstringlist;
filtre:TEtatFiltre;
S:String;
begin
try//finally
TableSauveEtatFiltre(DMDiocEtatBal.TaBalanceCalc,filtre);
if not PaSelectCpt.Visible then
   Begin
    RxChListCpt.Items.Clear;
//    if RxChListCpt.Items.Count =0 then
//       Begin
         ListeCpt.Clear;
         ListeTmp:=Tstringlist.Create;
         ListeTmp.Clear;
         RxChListCpt.Tag:=1;
         defiltrageDataset(DMDiocEtatBal.TaBalanceCalc);
         DMDiocEtatBal.TaBalanceCalc.DisableControls;
         Mark:=DMDiocEtatBal.TaBalanceCalc.GetBookmark;
         DMDiocEtatBal.TaBalanceCalc.First;
         for i:=0 to DMDiocEtatBal.TaBalanceCalc.RecordCount-1 do
             Begin
              //S:=StringOfChar('-', 12-length(DMDiocEtatBal.TaBalanceCalc.findfield('Compte').AsString));
              ListeTmp.Add(DMDiocEtatBal.TaBalanceCalc.findfield('Compte').AsString+';'+DMDiocEtatBal.TaBalanceCalc.findfield('ComptePlanCpt').AsString+';');
              //RxChListCpt.Items.Add(DMDiocEtatBal.TaBalanceCalc.findfield('Compte').AsString+s+DMDiocEtatBal.TaBalanceCalc.findfield('ComptePlanCpt').AsString);
              ListeCpt.Add(DMDiocEtatBal.TaBalanceCalc.findfield('Compte').AsString);
              ListeLibelle.Add(DMDiocEtatBal.TaBalanceCalc.findfield('ComptePlanCpt').AsString);
              DMDiocEtatBal.TaBalanceCalc.Next;
             End;
         DMDiocEtatBal.TaBalanceCalc.GotoBookmark(Mark);
         DMDiocEtatBal.TaBalanceCalc.FreeBookmark(Mark);
         DMDiocEtatBal.TaBalanceCalc.EnableControls;
      ordretri:=1;
      InitLisViewAvecListe(RxChListCpt,['Compte','Libellé'],ListeTmp,true).Free;
       End;
//   End;

PaSelectCpt.Top:=PaGrilleBal.top+18;
PaSelectCpt.Width:=PaCptIntit.Width-10;
EdRech.Visible:=false;
RxChListCpt.Width:=PaSelectCpt.Width;
PaSelectCpt.Height:=PaGrilleBal.Height;
RxChListCpt.Height:=PaSelectCpt.Height-69;// 298;
RxSBValider.Top:=PaSelectCpt.Height-47;
CheckBox1.Top:=RxSBValider.Top+5;
RxSBInverse.Top:=PaSelectCpt.Height-47;
RxSBAnnuleSel.Top:=PaSelectCpt.Height-22;
PaSelectCpt.Left:=16;
PaSelectCpt.Visible:=not PaSelectCpt.Visible;
if RxChListCpt.CanFocus then
RxChListCpt.SetFocus;
finally
  TableRestoreEtatFiltre(DMDiocEtatBal.TaBalanceCalc,filtre);
end;
end;

procedure TBalanceNew.RxSBCloseClick(Sender: TObject);
begin
PaSelectCpt.Visible:=false;
end;

procedure TBalanceNew.PaSelectCptResize(Sender: TObject);
begin
RxChListCpt.Width:=PaSelectCpt.Width-8;
EdRech.Width:=PaSelectCpt.Width-8;
RxSBClose.Width:=PaSelectCpt.Width;
RxSBAnnuleSel.Width:=PaSelectCpt.Width;
RxSBValider.Width:=PaSelectCpt.Width div 2;
RxSBInverse.Left:=RxSBValider.Width-1;
RxSBInverse.Width:=PaSelectCpt.Width-RxSBInverse.Left;
end;

procedure TBalanceNew.RxChListCptDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
//RxChListCpt.Canvas.FillRect(Rect);
//case strtoint(RxChListCpt.Items.Strings[i][1]) of
//  1:RxChListCpt.Canvas.Brush.Color:=clblue;
//  2:RxChListCpt.Canvas.Brush.Color:=clblue ;
//  3:RxChListCpt.Canvas.Brush.Color:=clblue ;
//  4:RxChListCpt.Canvas.Brush.Color:=clblue ;
//  5:RxChListCpt.Canvas.Brush.Color:=clblue ;
//  6:RxChListCpt.Canvas.Brush.Color:=clblue ;
//  7:RxChListCpt.Canvas.Brush.Color:=clblue ;
//  8:RxChListCpt.Canvas.Brush.Color:=clblue ;
//  9:RxChListCpt.Canvas.Brush.Color:=clblue ;
//end;

end;

procedure TBalanceNew.RxSBValiderClick(Sender: TObject);
var
i:integer;
begin
DMDiocEtatBal.ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    if RxChListCpt.items[i].Selected then
      DMDiocEtatBal.ListeFiltreAffich.Add(RxChListCpt.items[i].SubItems[0])
   End;
if DMDiocEtatBal.ListeFiltreAffich.Count > 0 then
   begin
     InitTotaux(DMDiocEtatBal.ListeFiltreAffich,'compte');
  end;
if CheckBox1.Checked then
 begin
  GrDBGridBal.SetFocus;
  PaSelectCpt.Visible:=false;
 end
 else
 begin
  GrDBGridBal.SetFocus;
 end;
end;

procedure TBalanceNew.RxSBAnnuleSelClick(Sender: TObject);
var
i:integer;
begin
DMDiocEtatBal.ListeFiltreAffich.Clear;
//DeFiltrageDataSet(DMDiocEtatBal.TaBalanceaffich);
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.items[i].Selected:=false;
   End;
InitTotaux(nil,'');
end;

procedure TBalanceNew.RxSBInverseClick(Sender: TObject);
var
i:integer;
begin
DMDiocEtatBal.ListeFiltreAffich.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.items[i].Selected:=not RxChListCpt.items[i].Selected;
    if RxChListCpt.items[i].Selected then
     DMDiocEtatBal.ListeFiltreAffich.Add(ListeCpt.Strings[i]);
   End;
InitTotaux(DMDiocEtatBal.ListeFiltreAffich,'Compte');
end;

procedure TBalanceNew.RxSBValidePeriodeClick(Sender: TObject);
begin
   try
     if EditDebutPer.Date < E.DatExoDebut then EditDebutPer.Date:=E.DatExoDebut;
     if EditFinPer.Date > E.DatExoFin then EditFinPer.Date:=E.DatExoFin;
     if EditDebutPer.Date > EditFinPer.Date then EditDebutPer.Date:=EditFinPer.Date;
     EditDebutPer.Refresh;
     EditFinPer.Refresh;
     PaReport.caption:='Solde Report au '+ DateInfos(EditDebutPer.Date).DateStr;
     PaMouv.Caption:='Mouv. du ' + DateInfos(EditDebutPer.Date).DateStr + ' au ' + DateInfos(EditFinPer.Date).DateStr;
     PaMouv.Hint:=PaMouv.Caption;
     PaSoldeFin.Caption:='Solde Fin au ' + DateInfos(EditFinPer.Date).DateStr;
   except

   end;

InitTotaux(nil,'');

ShapeCalendrier.Left:=round((EditDebutPer.Date-E.DatExoDebut)*1.1561643835616438356164383561644)+1;
ShapeCalendrier.Width:=round((EditFinPer.Date - EditDebutPer.Date)*1.1561643835616438356164383561644)+1;
end;

Procedure TBalanceNew.InitTotaux(ListeFiltre:TstringList;ChampFiltre:String);
var
TotauxBalance:TTotauxBalance;
BookMark:TBookmark;
RDebit,RCredit:currency;
libelleDate:string;
libelleSelection:string;
begin
if ListeFiltre = nil then DMDiocEtatBal.ListeFiltreAffich.Clear;
TableDisableControlBookMark(DMDiocEtatBal.TaBalanceaffich,BookMark);

TotauxBalance:=DMDiocEtatBal.SommeTotauxBalance(EditDebutPer.Date,EditFinPer.Date,ListeFiltre,ChampFiltre);
DMEcritures.TaEcritureBal.Filter:=CreeFiltreETPlage(['Date'],[dateInfos(EditDebutPer.Date).DateStr,dateInfos(EditFinPer.date).DateStr]);
DMEcritures.TaEcritureBal.Filtered:=true;

CurEdTotDebReport.Value:=TotauxBalance.TotalSoldeDebitReport;
CurEdTotCreReport.Value:=TotauxBalance.TotalSoldeCreditReport;
CurEdTotDebBase.Value:=TotauxBalance.TotalDebitBase;
CurEdTotCreBase.Value:=TotauxBalance.TotalCreditBase;
CurEdTotDebGen.Value:=TotauxBalance.TotalSoldeDebitTotal;
CurEdTotCreGen.Value:=TotauxBalance.TotalSoldeCreditTotal;
if TotauxBalance.SoldeDebitCreditReport then
 begin
   CurEdSoldeReport.Value:=TotauxBalance.SoldeReport;
   CurEdSoldeCreReport.Value:=0;
 end
 else
 begin
  CurEdSoldeCreReport.Value:=abs(TotauxBalance.SoldeReport);
  CurEdSoldeReport.Value:=0;
 end;
if TotauxBalance.SoldeDebitCreditBase then
 begin
   CurEdSoldeDebBase.Value:=TotauxBalance.SoldeBase;
   CurEdSoldeCreBase.Value:=0;
 end
 else
 begin
  CurEdSoldeCreBase.Value:=abs(TotauxBalance.SoldeBase);
  CurEdSoldeDebBase.Value:=0;
 end;
if TotauxBalance.SoldeDebitCreditFin then
 begin
   CurEdSoldeDebGen.Value:=TotauxBalance.SoldeFin;
   CurEdSoldeCreGen.Value:=0;
 end
 else
 begin
  CurEdSoldeCreGen.Value:=abs(TotauxBalance.SoldeFin);
  CurEdSoldeDebGen.Value:=0;
 end;

if CurEdSoldeDebGen.value<>0 then
  begin
    CurEdSoldeDebGen.color:=clYellow;
    CurEdSoldeDebGen.font.Style:=[fsbold];
    CurEdSoldeDebGen.font.Size:=9;
  end
else
  Begin
    CurEdSoldeDebGen.Color:=CurEdTotDebGen.Color;
    CurEdSoldeDebGen.font.Style:=CurEdTotDebGen.font.Style;
    CurEdSoldeDebGen.font.Size:=CurEdTotDebGen.font.Size;
  end;
if CurEdSoldeCreGen.value<>0 then
  begin
    CurEdSoldeCreGen.color:=clYellow;
    CurEdSoldeCreGen.font.Style:=[fsbold];
    CurEdSoldeCreGen.font.Size:=9;
  end
else
  Begin
    CurEdSoldeCreGen.Color:=CurEdTotCreGen.Color;
    CurEdSoldeCreGen.font.Style:=CurEdTotCreGen.font.Style;
    CurEdSoldeCreGen.font.Size:=CurEdTotCreGen.font.Size;
  end;
if CurEdSoldeDebBase.value<>0 then
  begin
    CurEdSoldeDebBase.color:=clYellow;
    CurEdSoldeDebBase.font.Style:=[fsbold];
    CurEdSoldeDebBase.font.Size:=9;
  end
else
  Begin
    CurEdSoldeDebBase.color:=CurEdTotDebBase.color;
    CurEdSoldeDebBase.font.Style:=CurEdTotDebBase.font.Style;
    CurEdSoldeDebBase.font.Size:=CurEdTotDebBase.font.Size;
  end;
if CurEdSoldeCreBase.value<>0 then
  begin
    CurEdSoldeCreBase.color:=clYellow;
    CurEdSoldeCreBase.font.Style:=[fsbold];
    CurEdSoldeCreBase.font.Size:=9;
  end
else
  Begin
    CurEdSoldeCreBase.color:=CurEdTotCreBase.color;
    CurEdSoldeCreBase.font.Style:=CurEdTotCreBase.font.Style;
    CurEdSoldeCreBase.font.Size:=CurEdTotCreBase.font.Size;
  end;
if CurEdSoldeReport.value<>0 then
  begin
    CurEdSoldeReport.color:=clYellow;
    CurEdSoldeReport.font.Style:=[fsbold];
    CurEdSoldeReport.font.Size:=9;
  end
else
  Begin
    CurEdSoldeReport.color:=CurEdTotDebReport.color;
    CurEdSoldeReport.font.Style:=CurEdTotDebReport.font.Style;
    CurEdSoldeReport.font.Size:=CurEdTotDebReport.font.Size;
  end;
if CurEdSoldeCreReport.value<>0 then
  begin
    CurEdSoldeCreReport.color:=clYellow;
    CurEdSoldeCreReport.font.Style:=[fsbold];
    CurEdSoldeCreReport.font.Size:=9;
  end
else
  Begin
    CurEdSoldeCreReport.color:=CurEdTotCreReport.color;
    CurEdSoldeCreReport.font.Style:=CurEdTotCreReport.font.Style;
    CurEdSoldeCreReport.font.Size:=CurEdTotCreReport.font.Size;
  end;
DMDiocEtatBal.ResultatExercice(RDebit,RCredit,EditDebutPer.Date,EditFinPer.date,DMDiocEtatBal.ListeFiltreAffich);
libelledate:='';
libelleSelection:='';
if(EditDebutPer.Date<>e.DatExoDebut)or(EditFinPer.date<>e.DatExoFin)then
    libelledate:='Pour la période du '+RetourChariotSimple+EditDebutPer.Text+' au '+EditFinPer.Text+RetourChariotSimple;
if(DMDiocEtatBal.ListeFiltreAffich<>nil)and(DMDiocEtatBal.ListeFiltreAffich.Count>0)
  then libelleSelection:='Sur une sélection de compte';
EdResultat.Visible:=true ;
LaResultat.Visible:=true;
laComplResultat.visible:=true;

if(rdebit<>0)then
  begin
    EdResultat.Value:=rDebit;
    LaResultat.Caption:='Résultat négatif';
  end
else
if(RCredit<>0)then
  begin
    EdResultat.Value:=RCredit ;
    LaResultat.Caption:='Résultat positif';
  end
else
  begin
        EdResultat.Visible:=false ;
        LaResultat.Visible:=false;
        laComplResultat.visible:=false;
  end;
laComplResultat.Caption:=libelledate+libelleSelection;
TableEnableControlBookMark(DMDiocEtatBal.TaBalanceaffich,BookMark);
end;

procedure TBalanceNew.EditFinPerKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
   Begin
   try
     if EditDebutPer.Date < E.DatExoDebut then EditDebutPer.Date:=E.DatExoDebut;
     if EditFinPer.Date > E.DatExoFin then EditFinPer.Date:=E.DatExoFin;
     RxSBValidePeriode.Click;
   except

   end;


   End;

end;

procedure TBalanceNew.EditDebutPerAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
if ADate < E.DatExoDebut then ADate:=E.DatExoDebut;
end;

procedure TBalanceNew.EditFinPerAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
if ADate > E.DatExoFin then ADate:=E.DatExoFin;
end;

procedure TBalanceNew.PaGrilleDetailResize(Sender: TObject);
begin
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
FormateTailleColonne(GrDBGridDetail,30,[4,4,3,4,6,4,4]);
end;

procedure TBalanceNew.RxSBCreeODClick(Sender: TObject);
var
ListeOd:tstringlist;
OD:string;
begin
try
if not CtrlSaisie(EdCompte.Text,EdCompte,true).retour then abort;
if not CtrlSaisie(dateod.Text,DateOD,true).retour then abort;
if not CtrlSaisie(CurMontantTransDeb.Text,CurMontantTransDeb,true).retour then abort;
if not CtrlSaisie(CurMontantTransCre.Text,CurMontantTransCre,true).retour then abort;

if CurMontantTransCre.Value = 0 then
   begin
    if VerifZoneSaisie([CurMontantTransDeb,EdCompte],true)<> nil then
     Begin
     showmessage('Informations incomplètes pour créer cette Opération Diverse');
     Abort;
     End;
   end;

     ListeOd:=CreationOD_avecObjet(nil,'');
     if (sender as TButton).Name='RxSBCreeVoirOD' then
       Begin
       DMPieces.AffichageFeuilleReprise(0,ListeOd,nil,'Affichage de l''OD de Transfert','','',false);
       End;
     Initialise_TStringlist(ListeOd,self);
     BalanceNew.SavePlaceMaitre:=EdCompte.Text;
     FormActivate(nil);
     GrDBGridBal.SetFocus;
     VideZoneSaisieTxt([CurMontantTransDeb,CurMontantTransCre,EdCompte]);
     MessDerSub:=true;
     CurMontantTransDeb.Value:= GrDBGridBal.DataSource.DataSet.findfield('Solde_Debit_Total_Calc').AsCurrency;
     CurMontantTransCre.Value:= GrDBGridBal.DataSource.DataSet.findfield('Solde_Credit_Total_Calc').AsCurrency;
  except

  end;
end;

procedure TBalanceNew.CurMontantTransDebDblClick(Sender: TObject);
begin
//if not VerifFNumeric(DMBalance.QuBalanceAffich.FindField('debit_Base')).VideOUZero
// then
// begin
//  CurMontantTransDeb.Value:=DMBalance.QuBalanceAffich.FindField('debit_Base').AsCurrency;
// end
// else CurMontantTransDeb.Value:=0;

if not VerifFNumeric(DMDiocEtatBal.TaBalanceaffich.FindField('Solde_Debit_Total_Calc')).VideOUZero
 then
 begin
  CurMontantTransDeb.Value:=DMDiocEtatBal.TaBalanceaffich.FindField('Solde_Debit_Total_Calc').AsCurrency;
 end
 else CurMontantTransDeb.Value:=0;
end;

procedure TBalanceNew.CurMontantTransCreDblClick(Sender: TObject);
begin

//if not VerifFNumeric(DMBalance.QuBalanceAffich.FindField('credit_Base')).VideOUZero
// then
// begin
//  CurMontantTransCre.Value:=DMBalance.QuBalanceAffich.FindField('credit_Base').AsCurrency;
// end
// else CurMontantTransCre.Value:=0;

if not VerifFNumeric(DMDiocEtatBal.TaBalanceaffich.FindField('Solde_Credit_Total_Calc')).VideOUZero
 then
 begin
  CurMontantTransCre.Value:=DMDiocEtatBal.TaBalanceaffich.FindField('Solde_Credit_Total_Calc').AsCurrency;
 end
 else CurMontantTransCre.Value:=0;
end;

procedure TBalanceNew.EdCompteDblClick(Sender: TObject);
begin
DMPieces.GestionFiltrageParamCptSurCompte('',3);
AideCompteDansContexte(EdCompte.Text,EdCompte,['Rac1'],true,MessDerSub,false,true,false,true,0);
end;


function TBalanceNew.CtrlSaisie(Valeur:string;Champ:Tcomponent;Focus:boolean):TExceptLGR;
begin
    result.retour:=true;
    result.NumErreur:=0;
//if ((ActiveControl=TabSheet1)or (ActiveControl.Parent=TabSheet1)) then
  begin
    try
      if champ.Name ='EdCompte' then
        begin
          DMPieces.GestionFiltrageParamCptSurCompte('',3);
          if not ((AideCompteDansContexte(Valeur,EdCompte,['Rac1'],false,MessDerSub,false,true,false,true,0)=true)
            and (not Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Valeur]).Collectif)) then
            begin
              result.retour:=false;
              result.NumErreur:=1000;
              if (focus) or (not str_Empty(valeur)) then
                 begin
                   showmessage('Ce compte n''est pas cohérent dans ce contexte');
                   EdCompte.SetFocus;
                   abort;
                 end;
            end;
        end;

      if champ.Name='CurMontantTransDeb' then
        begin
           if str_Empty_Numeric(valeur)then
             if str_Empty_Numeric(CurMontantTransCre.Text) then
               begin
                  if focus then showmessage('Vous devez indiquer un montant à transférer !');
                  result.retour:=false;
                  result.NumErreur:=2000;
                  abort;
               end;
        end;

      if champ.Name='CurMontantTransCre' then
        begin
           if str_Empty_Numeric(valeur)then
             if str_Empty_Numeric(CurMontantTransDeb.Text) then
               begin
                  if focus then showmessage('Vous devez indiquer un montant à transférer !');
                  result.retour:=false;
                  result.NumErreur:=3000;
                  abort;
               end;
        end;

      if champ.Name='DateOD' then
        begin
            if DateInfos(StrToDate_Lgr(valeur)).Vide then
               begin
                  if focus then showmessage('Vous devez saisir une date pour cette Opération Diverse');
                  result.retour:=false;
                  result.NumErreur:=4000;
                  abort;
               end;
            if (StrToDate_Lgr(valeur)<E.DatExoDebut) or (StrToDate_Lgr(valeur)>E.DatExoFin) then
            begin
                if focus then
                  begin
                    showmessage('la date doit faire partie de l''exercice');
                  end;
                if (StrToDate_Lgr(valeur)<E.DatExoDebut) then DateOD.Date:=e.DatExoDebut;
                if (StrToDate_Lgr(valeur)>E.DatExoFin) then DateOD.Date:=e.DatExoFin;
                result.retour:=false;
                result.NumErreur:=4001;
                abort;
            end;
        end;
      except
        if (champ<>nil) and (champ is TWinControl) and (focus) then
          if (Champ as TWinControl).CanFocus then
            (Champ as TWinControl).SetFocus;
      end;
  end;
end;


procedure TBalanceNew.CurMontantTransDebChange(Sender: TObject);
begin
if CurMontantTransDeb.Value <> 0 then
 CurMontantTransCre.Value:=0;
end;

procedure TBalanceNew.CurMontantTransCreChange(Sender: TObject);
begin
if CurMontantTransCre.Value <> 0 then
CurMontantTransDeb.Value:=0;
end;

procedure TBalanceNew.RxSBCreeVoirODClick(Sender: TObject);
begin
RxSBCreeODClick(sender);
end;


procedure TBalanceNew.GrDBGridBalTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
if ACol=1 then
   Begin
      PaCptIntitClick(PaCptIntit);
   End;
end;

procedure TBalanceNew.Imprimer1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
requete : TQuery;
ParamAffichCompte:TParamAffichCompte;
begin
if activeControl <> GrDBGridDetail then
 begin
 ListeCpt.Liste:=TStringList.Create;
     if DMDiocEtatBal.ListeFiltreAffich.Count >0 then
       EditionBalanceL(C_EditionSimple,true,DMDiocEtatBal.ListeFiltreAffich,nil)
     else
       begin
        try
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

        listecpt:=ChoixCompteAffich(ParamAffichCompte);

        if (ListeCpt.Liste<>nil) then
          begin
            EditionBalanceL(C_EditionSimple,true,listecpt.Liste,nil,ListeCpt.Regrouper);
          end;

        finally
          requete.close;
          requete.free;
        end;
       end;
   RxSBValidePeriodeClick(RxSBValidePeriode);
 end
 else
 Begin
   EditionEcritureL(0,C_TypeEditionLigneComplet,false,DMDiocEtatBal.TaBalanceaffich.findfield('Compte').AsString,nil,nil,e.SautDePageAutomatique);
 End;
end;

procedure TBalanceNew.RxSBRecalculBalExerciceClick(Sender: TObject);
begin
// Ne pas mettre DMBalance.QueryEcriture.AfterScroll dans
// initialiseTableEvent pour cause de vitesse
DMBalance.MiseAJourBalanceEntiere;
RxSBValidePeriodeClick(RxSBValidePeriode);
DMBalance.QueryEcriture.AfterScroll:=nil;

end;



Procedure TBalanceNew.CalcSolde;
var
DateDebTrim,DateFinTrim,DateDebTrimPrec,DateFinTrimPrec:TDate;
begin
RxSBValidePeriodeClick(RxSBValidePeriode);
End;


procedure TBalanceNew.RxSpeedButton3Click(Sender: TObject);
var
i,mois,DerJour:integer;
begin
for i:=3 to 14 do
 Begin
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=1;
 End;
TRxSpeedButton(sender).AllowAllUp:=false;
if not TRxSpeedButton(sender).Down then TRxSpeedButton(sender).Down:=true;
for i:=3 to 14 do
 Begin
  if TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).down then
      mois:=i-2;
 End;

for i:=15 to 18 do
 Begin
TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).AllowAllUp:=true;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=2;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).Down:=false;
 End;
case mois of
   1..9:begin
          EditDebutPer.text:='01/0'+inttostr(mois)+'/'+DateInfos(E.DatExoDebut).AnStr;
          DerJour:=GetNbDayOfMonth(mois,DateInfos(E.DatExoDebut).an);
          EditFinPer.text:=Inttostr(DerJour)+'/0'+inttostr(mois)+'/'+DateInfos(E.DatExoDebut).AnStr;
          if mois in [4,8] then
//            GrEtatVerse.Cells[4,0]:='Solde du mois d'''+MoisStr(StrToDAte(EditDebutPer.text))
           else
//            GrEtatVerse.Cells[4,0]:='Solde du mois de '+MoisStr(StrToDAte(EditFinPer.text));
        end;
   10..12:begin
           EditDebutPer.text:='01/'+inttostr(mois)+'/'+DateInfos(E.DatExoDebut).AnStr;
           DerJour:=GetNbDayOfMonth(mois,DateInfos(E.DatExoDebut).an);
           EditFinPer.text:=Inttostr(DerJour)+'/'+inttostr(mois)+'/'+DateInfos(E.DatExoDebut).AnStr;
          if mois = 10 then
//            GrEtatVerse.Cells[4,0]:='Solde du mois d'''+MoisStr(StrToDAte(EditDebutPer.text))
           else
//            GrEtatVerse.Cells[4,0]:='Solde du mois de '+MoisStr(StrToDAte(EditFinPer.text));
          end;
end;

//GrDBEtatAnal.Columns[2].Title.Caption:='Solde du mois de '+MoisStr(StrToDAte(LaDateDeb.Caption));
CalcSolde;
end;

procedure TBalanceNew.RxSpeedButton15Click(Sender: TObject);
begin
if RxSpeedButton15.Down then
 Begin
  RxSpeedButton3.GroupIndex:=3;
  RxSpeedButton4.GroupIndex:=4;
  RxSpeedButton5.GroupIndex:=5;
  RxSpeedButton6.GroupIndex:=1;
  RxSpeedButton7.GroupIndex:=1;
  RxSpeedButton8.GroupIndex:=1;
  RxSpeedButton9.GroupIndex:=1;
  RxSpeedButton10.GroupIndex:=1;
  RxSpeedButton11.GroupIndex:=1;
  RxSpeedButton12.GroupIndex:=1;
  RxSpeedButton13.GroupIndex:=1;
  RxSpeedButton14.GroupIndex:=1;
  RxSpeedButton14.AllowAllUp:=true;

  RxSpeedButton3.down:=true;
  RxSpeedButton4.down:=true;
  RxSpeedButton5.down:=true;
  RxSpeedButton6.down:=False;
  RxSpeedButton7.down:=False;
  RxSpeedButton8.down:=False;
  RxSpeedButton9.down:=False;
  RxSpeedButton10.down:=False;
  RxSpeedButton11.down:=False;
  RxSpeedButton12.down:=False;
  RxSpeedButton13.down:=False;
  RxSpeedButton14.down:=False;

  RxSpeedButton15.AllowAllUp:=false;
  RxSpeedButton15.GroupIndex:=2;
  RxSpeedButton16.GroupIndex:=2;
  RxSpeedButton17.GroupIndex:=2;
  RxSpeedButton18.GroupIndex:=2;

  RxSpeedButton16.down:=False;
  RxSpeedButton17.down:=False;
  RxSpeedButton18.down:=False;
  RxSpeedButton15.down:=true;

  EditDebutPer.Date:=StrToDate('01/01/'+DateInfos(E.DatExoDebut).AnStr);
  EditFinPer.Date:=StrToDate('31/03/'+DateInfos(E.DatExoFin).AnStr);

//  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/03/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton15.Caption;
 End;
CalcSolde;

end;

procedure TBalanceNew.RxSpeedButton16Click(Sender: TObject);
begin
if RxSpeedButton16.Down then
 Begin
  RxSpeedButton3.GroupIndex:=1;
  RxSpeedButton4.GroupIndex:=1;
  RxSpeedButton5.GroupIndex:=1;
  RxSpeedButton6.GroupIndex:=6;
  RxSpeedButton7.GroupIndex:=7;
  RxSpeedButton8.GroupIndex:=8;
  RxSpeedButton9.GroupIndex:=1;
  RxSpeedButton10.GroupIndex:=1;
  RxSpeedButton11.GroupIndex:=1;
  RxSpeedButton12.GroupIndex:=1;
  RxSpeedButton13.GroupIndex:=1;
  RxSpeedButton14.GroupIndex:=1;
  RxSpeedButton14.AllowAllUp:=true;

  RxSpeedButton3.down:=False;
  RxSpeedButton4.down:=False;
  RxSpeedButton5.down:=False;
  RxSpeedButton6.down:=true;
  RxSpeedButton7.down:=true;
  RxSpeedButton8.down:=true;
  RxSpeedButton9.down:=False;
  RxSpeedButton10.down:=False;
  RxSpeedButton11.down:=False;
  RxSpeedButton12.down:=False;
  RxSpeedButton13.down:=False;
  RxSpeedButton14.down:=False;

  RxSpeedButton15.GroupIndex:=2;
  RxSpeedButton16.GroupIndex:=2;
  RxSpeedButton17.GroupIndex:=2;
  RxSpeedButton18.GroupIndex:=2;
  RxSpeedButton15.AllowAllUp:=false;
  RxSpeedButton17.down:=False;
  RxSpeedButton18.down:=False;
  RxSpeedButton15.down:=False;
  RxSpeedButton16.down:=True;

  EditDebutPer.Date:=StrToDate('01/04/'+DateInfos(E.DatExoDebut).AnStr);
  EditFinPer.Date:=StrToDate('30/06/'+DateInfos(E.DatExoFin).AnStr);

//  LaDateDeb.Caption:='01/04/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='30/06/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton16.Caption;
 End;
CalcSolde;


end;

procedure TBalanceNew.RxSpeedButton17Click(Sender: TObject);
begin
if RxSpeedButton17.Down then
 Begin
  RxSpeedButton3.GroupIndex:=1;
  RxSpeedButton4.GroupIndex:=1;
  RxSpeedButton5.GroupIndex:=1;
  RxSpeedButton6.GroupIndex:=1;
  RxSpeedButton7.GroupIndex:=1;
  RxSpeedButton8.GroupIndex:=1;
  RxSpeedButton9.GroupIndex:=9;
  RxSpeedButton10.GroupIndex:=10;
  RxSpeedButton11.GroupIndex:=11;
  RxSpeedButton12.GroupIndex:=1;
  RxSpeedButton13.GroupIndex:=1;
  RxSpeedButton14.GroupIndex:=1;
  RxSpeedButton14.AllowAllUp:=true;

  RxSpeedButton3.down:=False;
  RxSpeedButton4.down:=False;
  RxSpeedButton5.down:=False;
  RxSpeedButton6.down:=False;
  RxSpeedButton7.down:=False;
  RxSpeedButton8.down:=False;
  RxSpeedButton9.down:=true;
  RxSpeedButton10.down:=true;
  RxSpeedButton11.down:=true;
  RxSpeedButton12.down:=False;
  RxSpeedButton13.down:=False;
  RxSpeedButton14.down:=False;

  RxSpeedButton15.GroupIndex:=2;
  RxSpeedButton16.GroupIndex:=2;
  RxSpeedButton17.GroupIndex:=2;
  RxSpeedButton18.GroupIndex:=2;
  RxSpeedButton15.AllowAllUp:=false;

  RxSpeedButton18.down:=False;
  RxSpeedButton15.down:=False;
  RxSpeedButton16.down:=False;
  RxSpeedButton17.down:=true;

  EditDebutPer.Date:=StrToDate('01/07/'+DateInfos(E.DatExoDebut).AnStr);
  EditFinPer.Date:=StrToDate('30/09/'+DateInfos(E.DatExoFin).AnStr);
//  LaDateDeb.Caption:='01/07/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='30/09/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton17.Caption;
 End;
CalcSolde;

end;

procedure TBalanceNew.RxSpeedButton18Click(Sender: TObject);
begin
if RxSpeedButton18.Down then
 Begin
  RxSpeedButton3.GroupIndex:=1;
  RxSpeedButton4.GroupIndex:=1;
  RxSpeedButton5.GroupIndex:=1;
  RxSpeedButton6.GroupIndex:=1;
  RxSpeedButton7.GroupIndex:=1;
  RxSpeedButton8.GroupIndex:=1;
  RxSpeedButton9.GroupIndex:=1;
  RxSpeedButton10.GroupIndex:=1;
  RxSpeedButton11.GroupIndex:=1;
  RxSpeedButton12.GroupIndex:=12;
  RxSpeedButton13.GroupIndex:=13;
  RxSpeedButton14.GroupIndex:=14;
  RxSpeedButton11.AllowAllUp:=true;

  RxSpeedButton3.down:=False;
  RxSpeedButton4.down:=False;
  RxSpeedButton5.down:=False;
  RxSpeedButton6.down:=False;
  RxSpeedButton7.down:=False;
  RxSpeedButton8.down:=False;
  RxSpeedButton9.down:=False;
  RxSpeedButton10.down:=False;
  RxSpeedButton11.down:=False;
  RxSpeedButton12.down:=True;
  RxSpeedButton13.down:=True;
  RxSpeedButton14.down:=True;

  RxSpeedButton15.GroupIndex:=2;
  RxSpeedButton16.GroupIndex:=2;
  RxSpeedButton17.GroupIndex:=2;
  RxSpeedButton18.GroupIndex:=2;
  RxSpeedButton15.AllowAllUp:=false;

  RxSpeedButton15.down:=False;
  RxSpeedButton16.down:=False;
  RxSpeedButton17.down:=False;
  RxSpeedButton18.down:=True;

  EditDebutPer.Date:=StrToDate('01/10/'+DateInfos(E.DatExoDebut).AnStr);
  EditFinPer.Date:=StrToDate('31/12/'+DateInfos(E.DatExoFin).AnStr);
//  LaDateDeb.Caption:='01/10/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton18.Caption;
 End;
CalcSolde;


end;

procedure TBalanceNew.RxSpeedButton19Click(Sender: TObject);
var
i,mois,DerJour:integer;
begin
for i:=3 to 18 do
 Begin
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=i;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).Down:=true;
 End;
  EditDebutPer.Date:=E.DatExoDebut;
  EditFinPer.Date:=E.DatExoFin;
//  EditDebutPer.Date:=StrToDate('01/01/'+DateInfos(Now).AnStr);
//  EditFinPer.Date:=StrToDate('31/12/'+DateInfos(Now).AnStr);
//  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+LaDateDeb.Caption + ' au '+LaDateFin.Caption;
CalcSolde;
end;

procedure TBalanceNew.EdRechChange(Sender: TObject);
var
i:integer;
begin
//ListeTmp.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.Items[i].Selected:=Pos(EdRech.Text,RxChListCpt.Items[i].Caption) > 0;
   End;
end;

procedure TBalanceNew.EditDebutPerExit(Sender: TObject);
begin
   try
     if EditDebutPer.Date < E.DatExoDebut then EditDebutPer.Date:=E.DatExoDebut;
     if EditFinPer.Date > E.DatExoFin then EditFinPer.Date:=E.DatExoFin;
     if EditDebutPer.Date > EditFinPer.Date then EditFinPer.Date:=EditDebutPer.Date;
     RxSBValidePeriode.Click;
   except

   end;
    CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label1,clWindowText,0);
end;

procedure TBalanceNew.EditFinPerExit(Sender: TObject);
begin
   try
     if EditDebutPer.Date < E.DatExoDebut then EditDebutPer.Date:=E.DatExoDebut;
     if EditFinPer.Date > E.DatExoFin then EditFinPer.Date:=E.DatExoFin;
     if EditDebutPer.Date > EditFinPer.Date then EditDebutPer.Date:=EditFinPer.Date;
     RxSBValidePeriode.Click;
   except

   end;
CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label2,clWindowText,0);
end;

procedure TBalanceNew.GrDBGridBalColEnter(Sender: TObject);
begin
//Convertis;
end;

procedure TBalanceNew.FormShow(Sender: TObject);
begin
initialiseTableEvent;                           //or(e.TypeClient=CL_Saisie_Cogere)
BalanceNew.BalanceCerfaLiasse1.Visible:=(e.TypeClient=CL_Cogere);
end;



function TBalanceNew.CreationOD_avecObjet(TableEnCours:TTable;ODModif:string):TStringList;
var
OD:string;
ListeOd:TStringList;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
tab:variant;
ValPieceAutoGen:TValPieceAutoGenere;
compteTvaTemp:string;
Begin
   try
     try
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(nil);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=DateOD.Date;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=EdLibelle.Text;
       //'Transfert du Compte ' + DBText1.Field.AsString+ ' vers le ' + EdCompte.Text;
       SourcePiece.Compte:=DBText1.Field.AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       //remplissage de 2 lignes pour l'OD
       if CurMontantTransCre.Value> CurMontantTransDeb.Value then
          begin
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DBText1.Field.AsString,'','',0,0,-CurMontantTransCre.Value,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',EdCompte.text,'','',0,0,CurMontantTransCre.Value,0,'','',0,'',''],true,false,-1);
          end
       else
          begin
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',DBText1.Field.AsString,'','',0,0,CurMontantTransDeb.Value,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',EdCompte.text,'','',0,0,-CurMontantTransDeb.Value,0,'','',0,'',''],true,false,-1);
          end;


       DMImport.RecupPieceEcriture_SurRecords(true,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
       ListeOd.Add(SourcePiece.Reference);
       result:=ListeOd;

     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,BalanceNew,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;

procedure TBalanceNew.EditDebutPerEnter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label1,clRed,0);
end;

procedure TBalanceNew.EditFinPerEnter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label2,clRed,0);
end;

procedure TBalanceNew.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then WinSuivPrec(Handle,key,[GrDBGridBal,GrDBGridDetail,RxChListCpt]);
if key=vk_escape then
 if PaSelectCpt.Visible then
    begin
   PaSelectCpt.Visible:=false;
   key:=0;
    end
   else self.close;

end;

procedure TBalanceNew.RxSBDetailPointageClick(Sender: TObject);
begin
Main.BalanceTiers1.Click;
end;

procedure TBalanceNew.Rglements1Click(Sender: TObject);
Var
InfosJournal:TInfosModel;
ParamAffichPointage:TParamAffichPointage;
begin
 if ActiveControl = GrDBGridDetail then
  begin
  GestionDernierPositionnement;
//   BalanceNew.SavePlaceMaitre:=BalanceNew.GrDBGridBal.DataSource.DataSet.findfield('Compte').AsString;
//   BalanceNew.SavePlaceDetail:=BalanceNew.GrDBGridDetail.DataSource.DataSet.findfield('id').AsString;
//    SavePlaceDetail := GrDBGridDetail.DataSource.DataSet.GetBookmark;
    case GrDBGridDetail.SelectedIndex of
       1:Begin
           if not empty(GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString) then
           begin
             Initialise_TParamAffichPointage(ParamAffichPointage);
             ParamAffichPointage.ALettrer:=false;
             ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString;
             ParamAffichPointage.DateDeb:=0;
             ParamAffichPointage.DateFin:=E.DatExoFin;
             ParamAffichPointage.ID_Ecriture_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('ID').AsInteger;
             ParamAffichPointage.ID_Reste_Appelant:=0;
             ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;

             if not VerifFNumeric(GrDBGridDetail.DataSource.DataSet.findField('debitSaisie')).VideOUZero then
               begin
                 ParamAffichPointage.SensAppelant:='D';
                 ParamAffichPointage.Montant_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('debitSaisie').ascurrency;
               end
             else
               begin
                 ParamAffichPointage.SensAppelant:='C';
                 ParamAffichPointage.Montant_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('CreditSaisie').ascurrency;
               end;
             ParamAffichPointage.Reference:=GrDBGridDetail.DataSource.DataSet.FindField('Reference').AsString;
             GestionAffichagePointageSurRef(true,true,ParamAffichPointage,not e.ExerciceCloture);
           end
           else
           begin
             ShowMessage('Attention !'+RetourChariotDouble+'Seules les lignes d''écritures concernant un compte pointables peuvent être pointées !');
           end;

         End;
       2,3:Begin
          ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findfield('Tiers').AsString;
          ParamAffichPointage.DateDeb:=0;
          ParamAffichPointage.DateFin:=E.DatExoFin;
          ParamAffichPointage.ALettrer:=True;
          GestionAffichagePointageSurCompte(ParamAffichPointage,not e.ExerciceCloture);
         End;

       else
        Begin
           if not empty(GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString) then
           begin
             Initialise_TParamAffichPointage(ParamAffichPointage);
             ParamAffichPointage.ALettrer:=true;
             ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString;
             ParamAffichPointage.DateDeb:=0;
             ParamAffichPointage.DateFin:=E.DatExoFin;
             ParamAffichPointage.ID_Ecriture_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('ID').AsInteger;
             ParamAffichPointage.ID_Reste_Appelant:=0;
             ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;

             if not VerifFNumeric(GrDBGridDetail.DataSource.DataSet.findField('debitSaisie')).VideOUZero then
               begin
                 ParamAffichPointage.SensAppelant:='D';
                 ParamAffichPointage.Montant_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('debitSaisie').ascurrency;
               end
             else
               begin
                 ParamAffichPointage.SensAppelant:='C';
                 ParamAffichPointage.Montant_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('CreditSaisie').ascurrency;
               end;
             ParamAffichPointage.Reference:=GrDBGridDetail.DataSource.DataSet.FindField('Reference').AsString;
             GestionAffichagePointageSurRef(true,true,ParamAffichPointage,not e.ExerciceCloture);
           end
           else
           begin
             ShowMessage('Attention !'+RetourChariotDouble+'Seules les lignes d''écritures concernant un compte pointables peuvent être pointées !');
           end;
        End;
    end; // Fin du case
    GestionDernierPositionnement(true);
//   if BalanceNew.GrDBGridBal.DataSource.DataSet.locate('compte',BalanceNew.SavePlaceMaitre,[loCaseInsensitive,loPartialKey])then
//      BalanceNew.GrDBGridDetail.DataSource.DataSet.Locate('id',strtoint_lgr(BalanceNew.SavePlaceDetail),[loCaseInsensitive,loPartialKey]);
//    GrDBGridDetail.DataSource.DataSet.GotoBookmark(SavePlaceDetail);
  end; // Fin du : if ActiveControl = GrDBGridDetail then
end;

procedure TBalanceNew.DtailsPointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
if activecontrol=GrDBGridDetail then
  Begin//si
  GestionDernierPositionnement;
//   BalanceNew.SavePlaceMaitre:=BalanceNew.GrDBGridBal.DataSource.DataSet.findfield('Compte').AsString;
//   BalanceNew.SavePlaceDetail:=BalanceNew.GrDBGridDetail.DataSource.DataSet.findfield('id').AsString;
//    SavePlaceDetail := GrDBGridDetail.DataSource.DataSet.GetBookmark;
    if ((not empty(GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString))or(dmplan.CptEstPointable(GrDBGridDetail.DataSource.DataSet.findField('Compte').AsString))) then
    begin
//      case GrDBGridDetail.SelectedIndex of       //*** enlever sur demande de denis bugzilla N° 106 **//
//        2,3:begin                                                //{ isa  le  24/06/05 }
//           Initialise_TParamAffichPointage(ParamAffichPointage);
//           ParamAffichPointage.ALettrer:=false;
//           if not empty(GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString)then
//             ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString
//           else
//             ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findField('Compte').AsString;
//           ParamAffichPointage.DateDeb:=0;
//           ParamAffichPointage.DateFin:=E.DatExoFin;
//           ParamAffichPointage.ID_Ecriture_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('ID').AsInteger;
//           ParamAffichPointage.ID_Reste_Appelant:=0;
//           ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;
//           ParamAffichPointage.Reference:=GrDBGridDetail.DataSource.DataSet.FindField('Reference').AsString;
//           GestionAffichagePointageSurCompte(ParamAffichPointage,not e.ExerciceCloture);
//          end;
//
//      else
//       begin
       Initialise_TParamAffichPointage(ParamAffichPointage);
        if not empty(GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString)then
          ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString
        else
          ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findField('Compte').AsString;
        ParamAffichPointage.ID_Ecriture_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('ID').AsInteger;
        DetailPointageAffich(ParamAffichPointage.CptTiers,inttostr(ParamAffichPointage.ID_Ecriture_Appelant),0,true,true);
//       end;
//      end; // Fin du Case
    end
    else
    begin
      ShowMessage('Attention !'+RetourChariotDouble+'Seules les lignes d''écritures concernant un compte pointables peuvent être pointées !');
    end;
    GestionDernierPositionnement(true);
//   if BalanceNew.GrDBGridBal.DataSource.DataSet.locate('compte',BalanceNew.SavePlaceMaitre,[loCaseInsensitive,loPartialKey])then
//      BalanceNew.GrDBGridDetail.DataSource.DataSet.Locate('id',strtoint_lgr(BalanceNew.SavePlaceDetail),[loCaseInsensitive,loPartialKey]);
//    GrDBGridDetail.DataSource.DataSet.GotoBookmark(SavePlaceDetail);
  End;//fin si

end;


procedure TBalanceNew.RxSBPlanCptClick(Sender: TObject);
var
PAramAffichPlan:TPAramAffichPlan;
begin
PAramAffichPlan.CompteASelectionner := GrDBGridBal.DataSource.DataSet.findField('Compte').AsString;
PlanCptAffiche(PAramAffichPlan);
end;

procedure TBalanceNew.RxSBPlanCptMouseLeave(Sender: TObject);
begin
(Sender As TRxSpeedButton).Font.Color:=clWindowText;
(Sender As TRxSpeedButton).Font.Style:=[];

end;

procedure TBalanceNew.RxSBPlanCptMouseEnter(Sender: TObject);
begin
(Sender As TRxSpeedButton).Font.Color:=clREd;
(Sender As TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TBalanceNew.ImprimerGrandLivre1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
requete : TQuery;
begin
if activeControl <> GrDBGridDetail then
 begin
     if DMDiocEtatBal.ListeFiltreAffich.Count >0 then
      EditionEcritureL(0,C_TypeEditionLigneComplet,true,DMDiocEtatBal.ListeFiltreAffich,nil,nil,e.SautDePageAutomatique)
     else
      begin
        try
        ListeCpt.Liste:=TStringList.Create;
        ListeCpt.result:=true;
        requete := TQuery.Create(self);
        requete.DatabaseName :=DMDiocEtatBal.TaBalanceCalc.DatabaseName;
        requete.SQL.Add(' select * from balance b');
        requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = B.compte)');
        requete.Open;
        listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Collectif','Pointable']);
        if ListeCpt.Result then
          EditionEcritureL(0,C_TypeEditionLigneComplet,false,ListeCpt.Liste,nil,nil,e.SautDePageAutomatique);
        finally
          requete.close;
          requete.free;
        end;
      end;
//  RxSBValidePeriodeClick(RxSBValidePeriode);
 end
end;

procedure TBalanceNew.ModifierPice1Click(Sender: TObject);
begin
try
GestionDernierPositionnement;
ModificationPieceExistante(GrDBGridDetail.DataSource.DataSet.findField('Reference').AsString,self.Name);
RxSBValidePeriode.Click;
finally
GestionDernierPositionnement(true);
////   if BalanceNew.GrDBGridBal.DataSource.DataSet.locate('compte',BalanceNew.SavePlaceMaitre,[loCaseInsensitive,loPartialKey])then
//      BalanceNew.GrDBGridBal.DataSource.DataSet.locate('compte',BalanceNew.SavePlaceMaitre,[loCaseInsensitive,loPartialKey]);
//      BalanceNew.GrDBGridDetail.DataSource.DataSet.Locate('id',strtoint_lgr(BalanceNew.SavePlaceDetail),[loCaseInsensitive,loPartialKey]);
////    GrDBGridDetail.DataSource.DataSet.GotoBookmark(SavePlaceDetail);
end;
end;

procedure TBalanceNew.TiRecupSoldeBalanceTimer(Sender: TObject);
begin
if DMDiocEtatBal.ListeFiltreAffich.Count=0 then
begin
if CurEdSoldeDebBase.value<>0 then
  begin
    CurEdSoldeDebBase.color:=clYellow;
    CurEdSoldeDebBase.font.Style:=[fsbold];
    CurEdSoldeDebBase.font.Size:=9;
  end;
if CurEdSoldeCreBase.value<>0 then
  begin
    CurEdSoldeCreBase.color:=clYellow;
    CurEdSoldeCreBase.font.Style:=[fsbold];
    CurEdSoldeCreBase.font.Size:=9;
  end;
end;
Timer1.Enabled:=true;
TiRecupSoldeBalance.Enabled:=false;
end;

procedure TBalanceNew.Timer1Timer(Sender: TObject);
begin

if DMDiocEtatBal.ListeFiltreAffich.Count=0 then
begin
CurEdSoldeDebBase.color:=CurEdTotDebBase.color;
CurEdSoldeDebBase.font.Style:=CurEdTotDebBase.font.Style;
CurEdSoldeDebBase.font.Size:=CurEdTotDebBase.font.Size;

CurEdSoldeCreBase.color:=CurEdTotCreBase.color;
CurEdSoldeCreBase.font.Style:=CurEdTotCreBase.font.Style;
CurEdSoldeCreBase.font.Size:=CurEdTotCreBase.font.Size;
end;

TiRecupSoldeBalance.Enabled:=true;
Timer1.Enabled:=false;
end;

procedure TBalanceNew.FormDeactivate(Sender: TObject);
begin
GestionDernierPositionnement;
//   BalanceNew.SavePlaceMaitre:=BalanceNew.GrDBGridBal.DataSource.DataSet.findfield('Compte').AsString;
//   BalanceNew.SavePlaceDetail:=BalanceNew.GrDBGridDetail.DataSource.DataSet.findfield('id').AsString;
Timer1.Enabled:=false;
Timer2.Enabled:=false;
TiRecupSoldeBalance.Enabled:=false;
PaSelectCpt.Visible:=false;
GrDBGridBal.DataSource.OnDataChange:=nil;
end;

procedure TBalanceNew.Timer2Timer(Sender: TObject);
var
ListeRetour:Tstringlist;
begin
try
ListeRetour:=TStringList.Create;
if DMDiocEtatBal.ListeFiltreAffich.Count=0 then
  begin
    if not ControleBalanceCpt(nil,ListeRetour) then
      Begin
         GestionGauge(10,gauge1,30,0);
         TbSMAJBalance.TabVisible:=true;
         PageControl2.ActivePage:=PageControl2.Pages[TbSMAJBalance.PageIndex];
         DMcorrection.CorrectionDeLaBalance(true,false);
//         GestionGauge(10);
//         DMcorrection.CorrectionDeLaBalanceDesTiers(true,false);
         GestionGauge(10);
         DMcorrection.CorrectionDeLaBalanceDesMouvements(true,false);
         GestionGauge(10);
         TbSMAJBalance.TabVisible:=false;
         PageControl2.ActivePage:=PageControl2.Pages[TabSheet2.PageIndex];
         InitTotaux(DMDiocEtatBal.ListeFiltreAffich,'compte');
         GestionGauge(0,gauge1,0,0,'',false);
      end;
  end;//fin si liste non filtrée
finally
Initialise_TStringlist(ListeRetour,self);
TiRecupSoldeBalance.Enabled:=true;
Timer2.Enabled:=false;
end;
end;

procedure TBalanceNew.Aide1Click(Sender: TObject);
begin

if ActiveControl=GrDBGridBal then
  case GrDBGridBal.SelectedIndex of                     //
         0:Rechercher_AvecJointure(GrDBGridBal,GrDBGridBal.DataSource.DataSet,
                    ['join "'+IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Plancpt" P  on (compte=P.compte)'],
                    [],
                    ['Compte','P.Libelle'],       //
                    ['Compte','Libellé'],'',0);
  end;//fin case
end;

procedure TBalanceNew.RxChListCptColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTri:=-OrdreTri;
if Column.Index > 0 then
 RxChListCpt.CustomSort(nil, Column.Index-1)
else
 RxChListCpt.CustomSort(nil, Column.Index)
end;

procedure TBalanceNew.RxChListCptCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

procedure TBalanceNew.PopupMenu1Popup(Sender: TObject);
begin
if activeControl=RxChListCpt then abort;
end;

procedure TBalanceNew.RxChListCptKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_RETURN then RxSBValider.Click;
end;

procedure TBalanceNew.RxChListCptDblClick(Sender: TObject);
begin
RxSBValider.Click;
end;

procedure TBalanceNew.DateODExit(Sender: TObject);
begin
CtrlSaisie(DateToStr_Lgr(dateod.date),DateOD,true);
end;

procedure TBalanceNew.EdCompteExit(Sender: TObject);
begin
if not str_Empty(EdCompte.Text) then CtrlSaisie(EdCompte.Text,EdCompte);
EdLibelle.Text:='Transfert du Compte ' + DBText1.Field.AsString+ ' vers le ' + EdCompte.Text;
end;

procedure TBalanceNew.CurMontantTransDebExit(Sender: TObject);
begin
CtrlSaisie(CurMontantTransDeb.Text,CurMontantTransDeb);
end;

procedure TBalanceNew.CurMontantTransCreExit(Sender: TObject);
begin
CtrlSaisie(CurMontantTransCre.Text,CurMontantTransCre);
end;


procedure TBalanceNew.DaBalancePourODAutoDataChange(Sender: TObject;
  Field: TField);
begin
  CurMontantTransDeb.Value:= GrDBGridBal.DataSource.DataSet.findfield('Solde_Debit_Total_Calc').AsCurrency;
  CurMontantTransCre.Value:= GrDBGridBal.DataSource.DataSet.findfield('Solde_Credit_Total_Calc').AsCurrency;
  EdLibelle.text:='';
  EdLibelleExit(nil);
end;

procedure TBalanceNew.PageControl2Change(Sender: TObject);
begin
if (PageControl2.ActivePageIndex=TabSheet1.TabIndex) and (GrDBGridBal.DataSource<>nil) then
  begin
    DateOD.Date:=now;
    if (DateOD.Date<E.DatExoDebut) then DateOD.Date:=e.DatExoDebut;
    if (DateOD.Date>E.DatExoFin) then DateOD.Date:=e.DatExoFin;
    GrDBGridBal.DataSource.OnDataChange:=DaBalancePourODAutoDataChange;
    GrDBGridBal.DataSource.OnDataChange(GrDBGridBal.DataSource,GrDBGridBal.DataSource.DataSet.Fields[0]);
  end
else
  GrDBGridBal.DataSource.OnDataChange:=nil;
end;

procedure TBalanceNew.DateODAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
CtrlSaisie(dateod.Text,DateOD,true);
end;


procedure TBalanceNew.GestionDernierPositionnement(Repositionnement : boolean);
begin
  if Repositionnement then
    begin
       if BalanceNew.GrDBGridBal.DataSource.DataSet.locate('compte',BalanceNew.SavePlaceMaitre,[loCaseInsensitive,loPartialKey])then
          BalanceNew.GrDBGridDetail.DataSource.DataSet.Locate('id',strtoint_lgr(BalanceNew.SavePlaceDetail),[loCaseInsensitive,loPartialKey]);
    end
  else
    begin
       BalanceNew.SavePlaceMaitre:=BalanceNew.GrDBGridBal.DataSource.DataSet.findfield('Compte').AsString;
       BalanceNew.SavePlaceDetail:=BalanceNew.GrDBGridDetail.DataSource.DataSet.findfield('id').AsString;
    end;
end;
procedure TBalanceNew.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

procedure TBalanceNew.Balance1Click(Sender: TObject);
begin
if ((GrDBGridBal.DataSource.DataSet.Filtered) and ((not empty(GrDBGridBal.DataSource.DataSet.Filter)or(DMDiocEtatBal.ListeFiltreAffich.count<>0)))) then
 begin
//   showmessage(GrDBGridBal.DataSource.DataSet.Filter);
   if MessageDlg('La balance est filtrée, vous risquez de ne pas exporter toutes '+#13+#10+'les informations !'+#13+#10+''+#13+#10+'Êtes vous sûr de vouloir continuer ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
      case e.TypeClient of
        CL_cogere:ExportBalanceCOGEREFiscal(GrDBGridBal.DataSource.DataSet);
         else ExportBalanceNormale(GrDBGridBal.DataSource.DataSet);
      end;//fin du case
 end
 else
  begin
      case e.TypeClient of
         cl_cogere:ExportBalanceCOGEREFiscal(GrDBGridBal.DataSource.DataSet);
         else ExportBalanceNormale(GrDBGridBal.DataSource.DataSet);
      end;//fin du case
  end;
end;

procedure TBalanceNew.BalanceCerfaLiasse1Click(Sender: TObject);
begin
if ((GrDBGridBal.DataSource.DataSet.Filtered) and ((not empty(GrDBGridBal.DataSource.DataSet.Filter)or(DMDiocEtatBal.ListeFiltreAffich.count<>0)))) then
 begin
   if MessageDlg('La balance est filtrée, vous risquez de ne pas exporter toutes '+#13+#10+'les informations !'+#13+#10+''+#13+#10+'Êtes vous sûr de vouloir continuer ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
      case e.TypeClient of
         cl_cogere:ExportBalanceCOGEREFiscal_Liasse(GrDBGridBal.DataSource.DataSet);
      end;//fin du case
 end
 else
  begin
      case e.TypeClient of
         cl_cogere:ExportBalanceCOGEREFiscal_Liasse(GrDBGridBal.DataSource.DataSet);
      end;//fin du case
  end;
end;

procedure TBalanceNew.RxSBGrapheClick(Sender: TObject);
begin
//if (Analyses=nil)then Analyses:=TAnalyses.Create(application.MainForm);
//Analyses.Show;
end;

procedure TBalanceNew.EdLibelleExit(Sender: TObject);
begin
if(EdLibelle.text='')then
  EdLibelle.text:='Transfert du Compte ' + DBText1.Field.AsString+ ' vers le ' + EdCompte.Text;
end;

end.
