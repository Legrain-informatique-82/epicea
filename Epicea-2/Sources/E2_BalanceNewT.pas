unit E2_BalanceNewT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, ExtCtrls, StdCtrls, Mask,
  ToolEdit, CurrEdit, RXCtrls,DB, DBCtrls,registry,Gr_Librairie_obj, RXSplit,
  Buttons,LibSQL,E2_Librairie_obj,LibDates, ComCtrls,LibZoneSaisie,
  Menus, TeEngine,ActnList, Series, TeeProcs, Chart,E2_Decl_Records,dbtables, DBChart,
 // LibConvertisseur,
  DMPointages2,
  DMConstantes,
  jpeg,
  E2_LibInfosTable,
  LibRessourceString,
  E2_SaisieP_3,
  lib_chaine,
  E2_Recherche,
  LibChoixCompte,
  LibGestionParamXML,
  E2_GesPlanCpt_PM,
  editions, Gauges;

type
  TMyCustGrid = class(TCustomGrid)
  end;
  TBalanceNewT = class(TForm)
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
    RxSBCreeOD: TButton;
    RxSBCreeVoirOD: TButton;
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
    DtailsPointages1: TMenuItem;
    RxSBPlanCpt: TRxSpeedButton;
    PlanComptable1: TMenuItem;
    ImprimerGrandLivre1: TMenuItem;
    Rglements1: TMenuItem;
    ModifierPice1: TMenuItem;
    Aide1: TMenuItem;
    RxChListCpt: TListView;
    RxSBClose: TRxSpeedButton;
    RxSBDetailPointage: TRxSpeedButton;
    Exporterbalancedestiers1: TMenuItem;
    Timer2: TTimer;
    Gauge1: TGauge;
    Calculatrice1: TMenuItem;
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
    procedure DtailsPointages1Click(Sender: TObject);
    procedure RxSBPlanCptClick(Sender: TObject);
    procedure ImprimerGrandLivre1Click(Sender: TObject);
    Procedure initialiseTableEvent;
    procedure Rglements1Click(Sender: TObject);
    procedure ModifierPice1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure RxChListCptColumnClick(Sender: TObject; Column: TListColumn);
    procedure RxChListCptCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure RxSBDetailPointageClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Exporterbalancedestiers1Click(Sender: TObject);
    procedure GestionDernierPositionnement(Repositionnement : boolean = false);
    function CtrlSaisie(Valeur:string;Champ:Tcomponent;Focus:boolean):TExceptLGR;
    procedure PageControl2Change(Sender: TObject);
    procedure DaBalancePourODAutoDataChange(Sender: TObject;
      Field: TField);
    procedure Timer2Timer(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure RxChListCptDblClick(Sender: TObject);
//    procedure BtnSupplClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    SavePlaceMaitre:string;
    SavePlaceDetail:string;    
  end;

var
  BalanceNewT: TBalanceNewT;
  ordretri:integer;
  ListeCpt:TStringList;
  ListeTmp:TStringList;
  ListeLibelle:TStringList;
  ListeCompteCollectif:TStringList;
implementation

uses
DMBalances,DMEcriture, E2_Main, E2_DetailEcr, E2_AideCompte,DMPiece,
  DMImportation,DMBaseDonnee, DMDiocEtatBalanceT, DMRecherche,DMCorrection;
{$R *.DFM}

procedure TBalanceNewT.GrDBGridBalDrawColumnCell(Sender: TObject;
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

procedure TBalanceNewT.GrDBGridBalMouseDown(Sender: TObject;
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


procedure TBalanceNewT.FormActivate(Sender: TObject);
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
     RxSBDetail.Caption:='M&asquer détails Tiers';
    End;

  2:Begin
     PaGrilleDetail.Visible:=false;
     PaGrilleBal.Align:=alClient;
     RxSBDetail.Caption:='&Afficher détails Tiers';
    End;
end;
PaReport.caption:='Solde Report au '+ DateInfos(EditDebutPer.Date).DateStr;
PaMouv.Caption:='Totaux Mouvements du ' + DateInfos(EditDebutPer.Date).DateStr + ' au ' + DateInfos(EditFinPer.Date).DateStr;
PaMouv.Hint:=PaMouv.Caption;
PaSoldeFin.Caption:='Solde Fin au ' + DateInfos(EditFinPer.Date).DateStr;
CouleurFond([EditDebutPer,EditFinPer],ParamUtil.CouleurDBGrid.GrilleColorFond);
if ((ActiveControl = EditDebutPer) or (ActiveControl = EditFinPer)) then
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,nil,0,0);

Self.Caption :=TitreForm+' - '+SousTitreForm;
//GrDBGridBal.fFSortFieldName:=GrDBGridBal.Columns[1].Field.FieldName;
TableRefreshSurClose(DMDiocEtatBalT.TaBalanceaffichT,'Tiers');

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
end;

procedure TBalanceNewT.PaGrilleBalResize(Sender: TObject);
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

procedure TBalanceNewT.RxSBDetailClick(Sender: TObject);
begin
//showmessage(floattostr(DMBalance.QuSumBalanceSoldebase.AsCurrency));
if PaGrilleDetail.Visible
   then
       begin
       RxSBDetail.Tag:=2;
       PaGrilleDetail.Visible:=false;
       PaGrilleBal.Align:=alClient;
       RxSBDetail.Caption:='&Afficher détails Tiers';
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
       RxSBDetail.Caption:='M&asquer détails Tiers';
       end;
Masquerdtailscompte1.Caption:=RxSBDetail.Caption;
end;

procedure TBalanceNewT.RxSBDetailMouseEnter(Sender: TObject);
begin
RxSBDetail.Font.Color:=clREd;
RxSBDetail.Font.Style:=[fsBold];
end;

procedure TBalanceNewT.RxSBDetailMouseLeave(Sender: TObject);
begin
RxSBDetail.Font.Color:=clWindowText;
RxSBDetail.Font.Style:=[];
end;

procedure TBalanceNewT.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
Var
Registre :TRegistry;
begin
if Main.Monofenetrage then
 begin
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
    end;
 end;
//if self.ModalResult = mrok then DestroyForm(self,E.USer);
if PaSelectCpt.Visible then PaSelectCpt.Visible:=false;
CanClose:=true;

if CanClose then InitialiseTable_A_Nil{ isa  le  29/01/04 }
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;

end;

procedure TBalanceNewT.FormCreate(Sender: TObject);
Var
 Registre :TRegistry;
begin
 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);

	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
   Registre:= TRegistry.Create;
   try
     with Registre do
     begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
      try
      RxSBDetail.Tag:=ReadInteger('Detail');
      except
      RxSBDetail.Tag:=1;
      end;
   end;
  finally
  Registre.Free;
end;
case RxSBDetail.Tag of
  1: ;
  2: ;
else RxSBDetail.Tag:=2;
end;
ListeCpt:=TStringList.Create;
Listetmp:=TStringList.Create;
ListeLibelle:=TStringList.Create;
ListeCompteCollectif:=TStringList.Create;
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
//DMBalance.QuCalculSurPeriode(EditDebutPer.Date,EditFinPer.Date);
end;

Procedure TBalanceNewT.InitialiseTable_A_Nil;
Begin
if DMDiocEtatBalT<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMDiocEtatBalT.TaBalanceaffichT]);
End;

procedure TBalanceNewT.FormDestroy(Sender: TObject);
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
    BalanceNewT:=nil;
    ListeCpt.Free;
    Listetmp.Free;
    ListeCompteCollectif.free;
    ListeLibelle.Free;
 end;
end;

procedure TBalanceNewT.GrDBGridDetailDblClick(Sender: TObject);
begin
try//finally
GestionDernierPositionnement;
GrDBGridBal.DataSource.DataSet.DisableControls;
GrDBGridDetail.DataSource.DataSet.DisableControls;
if activecontrol=GrDBGridBal then
 begin
    DetailEcritureTiers(DMDiocEtatBalT.TaBalanceaffichTTiers.AsString,true,((paramutil.maintenance)and(paramutil.TypeMaintenance='MaintS')));
//    case GrDBGridBal.SelectedIndex of
//      2,3:DetailEcritureTiers(DMDiocEtatBalT.TaBalanceaffichTTiers.AsString,true,true);
//      4,5,6,7:DetailEcritureTiers(DMDiocEtatBalT.TaBalanceaffichTTiers.AsString,true,false);
//    end;//fin du case
 end
else
if activecontrol=GrDBGridDetail then
    begin
      case GrDBGridDetail.SelectedIndex of
         0..2,4..6:if DetailEcritureTiers(DMDiocEtatBalT.TaBalanceaffichTTiers.AsString,False,False) then
      //   0..2,4..6:if DetailEcritureCompte(DMBalance.QuBalanceAffich.FindField('Compte').AsString,False) then
                     case DetailEcr.Tag of
                        1:begin
                          if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMEcritures.TaEcritureBalT.findfield('ID_Piece').AsInteger,[]) then
                            PieceEcritureTiers;
                          end;
                        2:begin
                          if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMEcritures.TaEcritureBalT.findfield('ID_Piece').AsInteger,[]) then
                            PieceEcritureCompte;
                          end;
                     end;
         3:DetailEcritureTiers(DMEcritures.TaEcritureBalT.FindField('Tiers').AsString,True);
      end;
    end;
finally
ReEnableControls(GrDBGridBal.DataSource.DataSet);
ReEnableControls(GrDBGridDetail.DataSource.DataSet);
//GestionDernierPositionnement(true);
end;
end;

procedure TBalanceNewT.PaCptIntitClick(Sender: TObject);
var
i:integer;
//Mark:TBookmark;
//S,s2:String;
ListeTmp:Tstringlist;
DatasetRech:Tquery;
begin
if not PaSelectCpt.Visible then
   Begin
    RxChListCpt.Items.Clear;
//    if RxChListCpt.Items.Count =0 then
//       Begin
         try
         ListeTmp:=Tstringlist.Create;
         DatasetRech:=TQuery.Create(application.MainForm);
         DatasetRech.DatabaseName:=DM_C_NomAliasDossier;
         DatasetRech.SQL.Add('select B.tiers,B.compte,T.Nom,T.Type from "'+e.RepertoireExercice+'\balanceTiers" B,Tiers T where B.tiers=T.tiers order by compte,tiers');
         DatasetRech.open;

         ListeCpt.Clear;
         ListeTmp.Clear;
         RxChListCpt.Tag:=1;
         DatasetRech.first;
         for i:=0 to DatasetRech.RecordCount-1 do
             Begin
              ListeTmp.Add(DatasetRech.findfield('TIERS').AsString+';'+DatasetRech.findfield('Nom').AsString+';'+DatasetRech.findfield('Compte').AsString+';'+DatasetRech.findfield('type').AsString+';');
              ListeCpt.Add(DatasetRech.findfield('TIERS').AsString);
              ListeLibelle.Add(DatasetRech.findfield('Nom').AsString);
              ListeCompteCollectif.Add(DatasetRech.findfield('Compte').AsString);
              DatasetRech.Next;
             End;
         finally
           DatasetRech.Free;
         end;
        ordretri:=1;
        InitLisViewAvecListe(RxChListCpt,['Tiers','Nom','Collectif','Type'],ListeTmp,true).Free;
//       End;
   End;

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
end;

procedure TBalanceNewT.RxSBCloseClick(Sender: TObject);
begin
PaSelectCpt.Visible:=false;
end;

procedure TBalanceNewT.PaSelectCptResize(Sender: TObject);
begin
RxChListCpt.Width:=PaSelectCpt.Width-8;
EdRech.Width:=PaSelectCpt.Width-8;
RxSBClose.Width:=PaSelectCpt.Width;
RxSBAnnuleSel.Width:=PaSelectCpt.Width;
RxSBValider.Width:=PaSelectCpt.Width div 2;
RxSBInverse.Left:=RxSBValider.Width-1;
RxSBInverse.Width:=PaSelectCpt.Width-RxSBInverse.Left;
end;

procedure TBalanceNewT.RxChListCptDrawItem(Control: TWinControl;
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

procedure TBalanceNewT.RxSBValiderClick(Sender: TObject);
var
i:integer;
begin
DMDiocEtatBalT.ListeFiltreAffich.Clear;
ListeTmp.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    if RxChListCpt.Items[i].Selected then
      DMDiocEtatBalT.ListeFiltreAffich.Add(RxChListCpt.items[i].SubItems[0]);
   End;
if DMDiocEtatBalT.ListeFiltreAffich.Count > 0 then
   begin
     InitTotaux(DMDiocEtatBalT.ListeFiltreAffich,'Tiers');
  end;
if CheckBox1.Checked then PaSelectCpt.Visible:=false;
end;

procedure TBalanceNewT.RxSBAnnuleSelClick(Sender: TObject);
var
i:integer;
begin
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.items[i].Selected:=false;
   End;
InitTotaux(nil,'');
end;

procedure TBalanceNewT.RxSBInverseClick(Sender: TObject);
var
i:integer;
begin
ListeTmp.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.items[i].Selected:=not RxChListCpt.items[i].Selected;
    if RxChListCpt.items[i].Selected then
     ListeTmp.Add(ListeCpt.Strings[i]);
   End;

InitTotaux(ListeTmp,'Tiers');
end;

procedure TBalanceNewT.RxSBValidePeriodeClick(Sender: TObject);
begin
   try
     if EditDebutPer.Date < E.DatExoDebut then EditDebutPer.Date:=E.DatExoDebut;
     if EditFinPer.Date > E.DatExoFin then EditFinPer.Date:=E.DatExoFin;
     if EditDebutPer.Date > EditFinPer.Date then EditDebutPer.Date:=EditFinPer.Date;
     EditDebutPer.Refresh;
     EditFinPer.Refresh;
     PaReport.caption:='Solde Report au '+ DateInfos(EditDebutPer.Date).DateStr;
     PaMouv.Caption:='Totaux Mouvements du ' + DateInfos(EditDebutPer.Date).DateStr + ' au ' + DateInfos(EditFinPer.Date).DateStr;
     PaMouv.Hint:=PaMouv.Caption;
     PaSoldeFin.Caption:='Solde Fin au ' + DateInfos(EditFinPer.Date).DateStr;
   except

   end;

InitTotaux(nil,'');

ShapeCalendrier.Left:=round((EditDebutPer.Date-E.DatExoDebut)*1.1561643835616438356164383561644)+1;
ShapeCalendrier.Width:=round((EditFinPer.Date - EditDebutPer.Date)*1.1561643835616438356164383561644)+1;
end;

Procedure TBalanceNewT.InitTotaux(ListeFiltre:TstringList;ChampFiltre:String);
var
TotauxBalance:TTotauxBalance;
BookMark:TBookmark;
TiersCourant:string;
begin
if ListeFiltre = nil then DMDiocEtatBalT.ListeFiltreAffich.Clear;
TiersCourant:= DMDiocEtatBalT.TaBalanceaffichT.findfield('Tiers').AsString;
//TableDisableControlBookMark(DMDiocEtatBalT.TaBalanceaffichT,BookMark);

TotauxBalance:=DMDiocEtatBalT.SommeTotauxBalanceT(EditDebutPer.Date,EditFinPer.Date,ListeFiltre,ChampFiltre);
DMEcritures.TaEcritureBalT.Filter:=CreeFiltreETPlage(['Date'],[dateInfos(EditDebutPer.Date).DateStr,dateInfos(EditFinPer.date).DateStr]);
DMEcritures.TaEcritureBalT.Filtered:=true;


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

DMDiocEtatBalT.TaBalanceaffichT.Locate('Tiers',TiersCourant,[]);
//TableEnableControlBookMark(DMDiocEtatBalT.TaBalanceaffichT,BookMark);
end;

procedure TBalanceNewT.EditFinPerKeyPress(Sender: TObject; var Key: Char);
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

procedure TBalanceNewT.EditDebutPerAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
if ADate < E.DatExoDebut then ADate:=E.DatExoDebut;
end;

procedure TBalanceNewT.EditFinPerAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
if ADate > E.DatExoFin then ADate:=E.DatExoFin;
end;

procedure TBalanceNewT.PaGrilleDetailResize(Sender: TObject);
begin
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
FormateTailleColonne(GrDBGridDetail,30,[4,4,3,4,6,4,4]);
end;

procedure TBalanceNewT.RxSBCreeODClick(Sender: TObject);
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
     SavePlaceMaitre:=EdCompte.Text;
     FormActivate(nil);
     GrDBGridBal.SetFocus;
     VideZoneSaisieTxt([CurMontantTransDeb,CurMontantTransCre,EdCompte]);
     MessDerSub:=true;
     CurMontantTransDeb.Value:= GrDBGridBal.DataSource.DataSet.findfield('Solde_Debit_Total_Calc').AsCurrency;
     CurMontantTransCre.Value:= GrDBGridBal.DataSource.DataSet.findfield('Solde_Credit_Total_Calc').AsCurrency;
  except

  end;
end;

procedure TBalanceNewT.CurMontantTransDebDblClick(Sender: TObject);
begin
//if not VerifFNumeric(DMBalance.QuBalanceAffich.FindField('debit_Base')).VideOUZero
// then
// begin
//  CurMontantTransDeb.Value:=DMBalance.QuBalanceAffich.FindField('debit_Base').AsCurrency;
// end
// else CurMontantTransDeb.Value:=0;

if not VerifFNumeric(DMDiocEtatBalT.TaBalanceaffichT.FindField('debit_Base_calc')).VideOUZero
 then
 begin
  CurMontantTransDeb.Value:=DMDiocEtatBalT.TaBalanceaffichT.FindField('debit_Base_calc').AsCurrency;
 end
 else CurMontantTransDeb.Value:=0;
end;

procedure TBalanceNewT.CurMontantTransCreDblClick(Sender: TObject);
begin

if not VerifFNumeric(DMDiocEtatBalT.TaBalanceaffichT.FindField('credit_Base_calc')).VideOUZero
 then
 begin
  CurMontantTransCre.Value:=DMDiocEtatBalT.TaBalanceaffichT.FindField('credit_Base_calc').AsCurrency;
 end
 else CurMontantTransCre.Value:=0;
end;

procedure TBalanceNewT.EdCompteDblClick(Sender: TObject);
var
MessDerSub:boolean;
begin
AideCompteFiltreTaCompte('',false);
AideCompteDansContexte(EdCompte.Text,EdCompte,[''],false,MessDerSub,false,false,true,true,1);
end;

procedure TBalanceNewT.CurMontantTransDebChange(Sender: TObject);
begin
if CurMontantTransDeb.Value <> 0 then
 CurMontantTransCre.Value:=0;
end;

procedure TBalanceNewT.CurMontantTransCreChange(Sender: TObject);
begin
if CurMontantTransCre.Value <> 0 then
CurMontantTransDeb.Value:=0;
end;

procedure TBalanceNewT.RxSBCreeVoirODClick(Sender: TObject);
begin
RxSBCreeODClick(sender);
end;


procedure TBalanceNewT.GrDBGridBalTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
if ACol=1 then
   Begin

     //PaCptIntitClick(PaCptIntit);
   End; 
end;

procedure TBalanceNewT.Imprimer1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
filtre:string;
ParamAffichCompte:TParamAffichCompte;
ContainedAction:TContainedAction;
  EventButtonClick:TNotifyEvent;
begin
if activeControl <> GrDBGridDetail then
 begin
  case E.Type_Edition of

    C_IMP_NORMAL:Begin
                 if DMDiocEtatBalT.ListeFiltreAffich.Count >0 then
                   EditionBalanceTiersL(C_EditionSimple,true,DMDiocEtatBalT.ListeFiltreAffich,nil,e.SautDePageAutomatique)
                 else
                   begin
                    try
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
                 End;

    else showmessage('Type_Edition non défini');
  end;


   RxSBValidePeriodeClick(RxSBValidePeriode);
 end
 else
 Begin
   EditionEcritureL(0,C_TypeEditionLigneComplet,false,DMDiocEtatBalT.TaBalanceaffichT.findfield('Tiers').AsString,nil,nil,e.SautDePageAutomatique);
//   GrDBGridDetail.ReportCaption:='Lignes d''écritures du compte : '+ DMDiocEtatBal.TaBalanceaffich.findfield('Compte').AsString+' - '+ DMDiocEtatBal.TaBalanceaffich.findfield('ComptePlanCpt').AsString+' .';
//   GrDBGridDetail.GridPreview;
 End;

//if activeControl <> GrDBGridDetail then
// begin
//   //GrDBGridBal.ReportCaption:='Balance des Tiers';
//   //GrDBGridBal.GridPreview;
//   EditionBalanceTiersL(C_EditionSimple,true,nil,nil,Site);
////   EditionBalanceTiers(C_EditionSimple,GrDBGridBal.DataSource.DataSet,nil,Site);
//   RxSBValidePeriodeClick(RxSBValidePeriode);
// end
// else
// Begin
//   GrDBGridDetail.ReportCaption:='Lignes d''écritures du Tiers : '+ DMDiocEtatBalT.TaBalanceaffichT.findfield('TIERS').AsString+' - '+ DMDiocEtatBalT.TaBalanceaffichT.findfield('LibTiers').AsString+' .';
//   GrDBGridDetail.GridPreview;
// End;

end;

procedure TBalanceNewT.RxSBRecalculBalExerciceClick(Sender: TObject);
begin
DMBalance.MiseAJourBalanceEntiere;
RxSBValidePeriodeClick(RxSBValidePeriode);
DMBalance.QueryEcriture.AfterScroll:=nil;
end;

Procedure TBalanceNewT.CalcSolde;
var
DateDebTrim,DateFinTrim,DateDebTrimPrec,DateFinTrimPrec:TDate;
begin
RxSBValidePeriodeClick(RxSBValidePeriode);
End;


procedure TBalanceNewT.RxSpeedButton3Click(Sender: TObject);
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

procedure TBalanceNewT.RxSpeedButton15Click(Sender: TObject);
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

  EditDebutPer.Date:=StrToDate('01/01/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('30/03/'+DateInfos(Now).AnStr);

//  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/03/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton15.Caption;
 End;
CalcSolde;

end;

procedure TBalanceNewT.RxSpeedButton16Click(Sender: TObject);
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

  EditDebutPer.Date:=StrToDate('01/04/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('30/06/'+DateInfos(Now).AnStr);

//  LaDateDeb.Caption:='01/04/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='30/06/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton16.Caption;
 End;
CalcSolde;


end;

procedure TBalanceNewT.RxSpeedButton17Click(Sender: TObject);
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

  EditDebutPer.Date:=StrToDate('01/07/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('30/09/'+DateInfos(Now).AnStr);
//  LaDateDeb.Caption:='01/07/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='30/09/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton17.Caption;
 End;
CalcSolde;

end;

procedure TBalanceNewT.RxSpeedButton18Click(Sender: TObject);
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

  EditDebutPer.Date:=StrToDate('01/10/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('31/12/'+DateInfos(Now).AnStr);
//  LaDateDeb.Caption:='01/10/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+RxSpeedButton18.Caption;
 End;
CalcSolde;


end;

procedure TBalanceNewT.RxSpeedButton19Click(Sender: TObject);
var
i,mois,DerJour:integer;
begin
for i:=3 to 18 do
 Begin
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).groupindex:=i;
  TRxSpeedButton(self.FindComponent('RxSpeedButton'+Inttostr(i))).Down:=true;
 End;
  EditDebutPer.Date:=StrToDate('01/01/'+DateInfos(Now).AnStr);
  EditFinPer.Date:=StrToDate('31/12/'+DateInfos(Now).AnStr);
//  LaDateDeb.Caption:='01/01/'+DateInfos(Now).AnStr;
//  LaDateFin.Caption:='31/12/'+DateInfos(Now).AnStr;
//  GrEtatVerse.Cells[4,0]:='Solde du '+LaDateDeb.Caption + ' au '+LaDateFin.Caption;
CalcSolde;
end;

procedure TBalanceNewT.EdRechChange(Sender: TObject);
var
i:integer;
begin
//ListeTmp.Clear;
for i:=0  to RxChListCpt.Items.Count-1 do
   Begin
    RxChListCpt.Items[i].Selected:=Pos(EdRech.Text,RxChListCpt.Items[i].Caption) > 0;
   End;
end;

procedure TBalanceNewT.EditDebutPerExit(Sender: TObject);
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

procedure TBalanceNewT.EditFinPerExit(Sender: TObject);
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

procedure TBalanceNewT.GrDBGridBalColEnter(Sender: TObject);
begin
//Convertis;
end;

procedure TBalanceNewT.FormShow(Sender: TObject);
begin
initialiseTableEvent;
end;



function TBalanceNewT.CreationOD_avecObjet(TableEnCours:TTable;ODModif:string):TStringList;
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
       SourcePiece.Libelle:='Transfert du Compte ' + DBText1.Field.AsString+ ' vers le ' + EdCompte.Text;
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
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,self,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;

procedure TBalanceNewT.EditDebutPerEnter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label1,clRed,0);
end;

procedure TBalanceNewT.EditFinPerEnter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label2,clRed,0);
end;

procedure TBalanceNewT.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TBalanceNewT.DtailsPointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
GestionDernierPositionnement;
 if ActiveControl = GrDBGridBal then
  begin
         Initialise_TParamAffichPointage(ParamAffichPointage);
        ParamAffichPointage.CptTiers:=GrDBGridBal.DataSource.DataSet.findField('Tiers').AsString ;
        ParamAffichPointage.ID_Ecriture_Appelant:=GrDBGridBal.DataSource.DataSet.FindField('ID').AsInteger;
        DetailPointageAffich(ParamAffichPointage.CptTiers,inttostr(ParamAffichPointage.ID_Ecriture_Appelant),0,true,true);

//    ParamAffichPointage.CptTiers:=GrDBGridBal.DataSource.DataSet.findfield('Tiers').AsString;
//    ParamAffichPointage.DateDeb:=0;
//    ParamAffichPointage.DateFin:=E.DatExoFin;
//    GestionAffichagePointageSurCompte(ParamAffichPointage,not e.ExerciceCloture);
  end;
 if ActiveControl = GrDBGridDetail then
  begin
       Initialise_TParamAffichPointage(ParamAffichPointage);
        ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findField('Tiers').AsString;
        ParamAffichPointage.ID_Ecriture_Appelant:=GrDBGridDetail.DataSource.DataSet.FindField('ID').AsInteger;
        DetailPointageAffich(ParamAffichPointage.CptTiers,inttostr(ParamAffichPointage.ID_Ecriture_Appelant),0,true,true);

//    case GrDBGridDetail.SelectedIndex of
//       2:Begin
//
//         End;
//
//       3:Begin
//          ParamAffichPointage.CptTiers:=GrDBGridDetail.DataSource.DataSet.findfield('Tiers').AsString;
//          ParamAffichPointage.DateDeb:=0;
//          ParamAffichPointage.DateFin:=E.DatExoFin;
//          GestionAffichagePointageSurCompte(ParamAffichPointage,not e.ExerciceCloture);
//         End;
//
//       else
//        Begin
//
//        End;
//    end; // Fin du case
  end; // Fin du : if ActiveControl = GrDBGridDetail then
GestionDernierPositionnement(true);
end;

procedure TBalanceNewT.RxSBPlanCptClick(Sender: TObject);
var
PAramAffichPlan:TPAramAffichPlan;
begin
PAramAffichPlan.CompteASelectionner := GrDBGridBal.DataSource.DataSet.findField('LibTiers').AsString;
PlanCptAffiche(PAramAffichPlan);
end;

procedure TBalanceNewT.ImprimerGrandLivre1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
filtre:string;
ParamAffichCompte:TParamAffichCompte;
  EventButtonClick:TNotifyEvent;
begin
if activeControl <> GrDBGridDetail then
 begin
     if DMDiocEtatBalT.ListeFiltreAffich.Count >0 then
      EditionEcritureL(0,C_TypeEditionLigneComplet,false,DMDiocEtatBalT.ListeFiltreAffich,nil,nil,e.SautDePageAutomatique)
     else
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
//            requete.DatabaseName := DMRech.TaBalanceTiersRech.DatabaseName;
//            requete.SQL.Add(' select BT.compte,Bt.tiers,T.nom,T.type from BalanceTiers bt');
//            requete.SQL.Add(' join "'+e.RepertoireDossier+'Tiers" T on (T.tiers=Bt.tiers)');
//    requete.SQL.Add(filtre);
//            requete.Open;
//            ListeCpt.Liste:=TStringList.Create;
//            ListeCpt.result:=true;
//            DeFiltrageDataSet(requete);
//
//            listecpt:=ChoixCompteAffich('Sélectionnez les tiers...',requete,['Tiers','compte','nom','type'],true);
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
              EditionEcritureL(0,C_TypeEditionLigneComplet,false,ListeCpt.Liste,nil,nil,ParamAffichCompte.sautDePage);
        finally
            Requete.Close;
            requete.free;
        end;
      end;
 end
end;


Procedure TBalanceNewT.initialiseTableEvent;
Begin
//   DMBalance.QueryEcriture.AfterScroll -> A initialiser au besoin, pour cause de rapidité
//DMDiocEtatBalT.TaBalanceAffichT.AfterScroll:=TaBalanceAfterScroll;
End;


procedure TBalanceNewT.Rglements1Click(Sender: TObject);
Var
InfosJournal:TInfosModel;
ParamAffichPointage:TParamAffichPointage;
//SavePlace:TBookMark;
begin
 if ActiveControl = GrDBGridDetail then
  begin
   // SavePlace := GrDBGridDetail.DataSource.DataSet.GetBookmark;
    GestionDernierPositionnement;
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
//    GrDBGridDetail.DataSource.DataSet.GotoBookmark(SavePlace);
//    GrDBGridDetail.DataSource.DataSet.FreeBookmark(SavePlace);
  end; // Fin du : if ActiveControl = GrDBGridDetail then


end;

procedure TBalanceNewT.ModifierPice1Click(Sender: TObject);
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

procedure TBalanceNewT.Aide1Click(Sender: TObject);
begin
if ActiveControl=GrDBGridBal then
  case GrDBGridBal.SelectedIndex of                     //
         0:Rechercher_AvecJointure(GrDBGridBal,GrDBGridBal.DataSource.DataSet,
                    ['join "'+IncludeTrailingPathDelimiter(e.RepertoireDossier)+'Tiers" T  on (Tiers=T.tiers)'],
                    [],
                    ['Tiers','T.Nom','compte'],       //
                    ['Tiers','Libellé tiers','compte'],'',0);
  end;//fin case

end;

procedure TBalanceNewT.RxChListCptColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTri:=-OrdreTri;
if Column.Index > 0 then
 RxChListCpt.CustomSort(nil, Column.Index-1)
else
 RxChListCpt.CustomSort(nil, Column.Index)
end;

procedure TBalanceNewT.RxChListCptCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTri*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTri*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

procedure TBalanceNewT.PopupMenu1Popup(Sender: TObject);
begin
if activeControl=RxChListCpt then abort;
end;

procedure TBalanceNewT.RxSBDetailPointageClick(Sender: TObject);
begin
Main.Balance2.Click;
end;

procedure TBalanceNewT.FormDeactivate(Sender: TObject);
begin
GestionDernierPositionnement;
Timer2.Enabled:=false;
PaSelectCpt.Visible:=false;
GrDBGridBal.DataSource.OnDataChange:=nil; 
end;

procedure TBalanceNewT.Exporterbalancedestiers1Click(Sender: TObject);
begin
if DMDiocEtatBalT.ListeFiltreAffich.Count >0 then
 EditionBalanceTiersL(c_exportation,true,DMDiocEtatBalT.ListeFiltreAffich,nil,false)
else
 EditionBalanceTiersL(c_exportation,true,Nil,nil,false);
end;


procedure TBalanceNewT.GestionDernierPositionnement(Repositionnement : boolean);
begin
  if Repositionnement then
    begin
       if BalanceNewT.GrDBGridBal.DataSource.DataSet.locate('Tiers',BalanceNewT.SavePlaceMaitre,[loCaseInsensitive,loPartialKey])then
          BalanceNewT.GrDBGridDetail.DataSource.DataSet.Locate('id',strtoint_lgr(BalanceNewT.SavePlaceDetail),[loCaseInsensitive,loPartialKey]);
    end
  else
    begin
       BalanceNewT.SavePlaceMaitre:=BalanceNewT.GrDBGridBal.DataSource.DataSet.findfield('Tiers').AsString;
       BalanceNewT.SavePlaceDetail:=BalanceNewT.GrDBGridDetail.DataSource.DataSet.findfield('id').AsString;
    end;
end;


function TBalanceNewT.CtrlSaisie(Valeur:string;Champ:Tcomponent;Focus:boolean):TExceptLGR;
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
procedure TBalanceNewT.DaBalancePourODAutoDataChange(Sender: TObject;
  Field: TField);
begin
  CurMontantTransDeb.Value:= GrDBGridBal.DataSource.DataSet.findfield('Solde_Debit_Total_Calc').AsCurrency;
  CurMontantTransCre.Value:= GrDBGridBal.DataSource.DataSet.findfield('Solde_Credit_Total_Calc').AsCurrency;
end;

procedure TBalanceNewT.PageControl2Change(Sender: TObject);
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

procedure TBalanceNewT.Timer2Timer(Sender: TObject);
var
ListeRetour:Tstringlist;
begin
try
ListeRetour:=TStringList.Create;
if DMDiocEtatBalT.ListeFiltreAffich.Count=0 then
  begin
    if not ControleBalanceTiers(nil,ListeRetour) then
      Begin
         GestionGauge(10,gauge1,30,0);
         TbSMAJBalance.TabVisible:=true;
         PageControl2.ActivePage:=PageControl2.Pages[TbSMAJBalance.PageIndex];
         DMcorrection.CorrectionDeLaBalanceDesTiers(true,false);
         GestionGauge(10);
         TbSMAJBalance.TabVisible:=false;
         PageControl2.ActivePage:=PageControl2.Pages[TabSheet2.PageIndex];
         InitTotaux(DMDiocEtatBalT.ListeFiltreAffich,'compte');
         GestionGauge(0,gauge1,0,0,'',false);
      end;
  end;//fin si liste non filtrée
finally
Initialise_TStringlist(ListeRetour,self);
Timer2.Enabled:=false;
end;
end;

procedure TBalanceNewT.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

//procedure TBalanceNewT.BtnSupplClick(Sender: TObject);
//var
//ListeCpt:TResultStrList;
//Requete : TQuery;
//filtre:string;
//ParamAffichCompte:TParamAffichCompte;
//ChoixCompte:TLibChoixComptes;
//begin
//try
//    requete := TQuery.Create(application.MainForm);
//    //pour récupérer les types de tiers
//    ListeCpt.Liste:=TStringList.Create;
//    ListeCpt.result:=true;
//    requete.DatabaseName :=DMRech.TaTiersRech.DatabaseName;
//    requete.SQL.Add(' select distinct type,compte from tiers T');
//    requete.Open;
//    requete.First;
//    Filtre:='';
//    ChoixCompte:=TLibChoixComptes.Create(Application.MainForm);
//                  InitialiseParamAffichCompte(ParamAffichCompte);
//                  ParamAffichCompte.Titre:= 'Sélectionnez les types de tiers ...';
//                  ParamAffichCompte.Tiers:=true;
//                  ParamAffichCompte.Dataset:=requete;
//                  ParamAffichCompte.ListeChamps.Add('type');
//                  ParamAffichCompte.ListeChamps.Add('compte');
//
//    listecpt:=ChoixCompte.ChoixCompteAffich(ParamAffichCompte);
//    if(ListeCpt.Result) and (ListeCpt.Liste.Count>0)then
//    begin
//      filtre:=CreeFiltreOU('type',[ListeCpt.Liste]);
//      LibChoixComptes.ParamAffichCompteObjet.Dataset.Filtered := false;
//      LibChoixComptes.ParamAffichCompteObjet.Dataset.Filter :=Filtre;
//      LibChoixComptes.ParamAffichCompteObjet.Dataset.Filtered := True;
//      LibChoixComptes.InitDataset(LibChoixComptes.ParamAffichCompteObjet.Dataset);
//    end;
//    ChoixCompte.Destroy;
//    requete.close;
//    requete.SQL.Clear;
//except
//end;
//end;




procedure TBalanceNewT.RxChListCptDblClick(Sender: TObject);
begin
RxSBValider.Click;
end;

end.
