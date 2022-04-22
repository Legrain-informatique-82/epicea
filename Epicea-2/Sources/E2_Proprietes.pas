unit E2_Proprietes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, db,
  RXCtrls, StdCtrls, LibZoneSaisie,Gr_Librairie_Obj,E2_Librairie_Obj,DMDevises,E2_Decl_Records,
  GrDBGrid,LibFichRep, RXSpin, LibGestionParamXML, jpeg,GR_MultDos, Buttons,FileUtil,ShellAPI,
  Menus, IdBaseComponent, IdComponent, DMMessagesLGR, IdTCPConnection,
  IdTCPClient, IdFTP,E2_LibInfosTable, GrGrid,ShellCtrls,DialogEx, Mask,
  ToolEdit;


  const
RepImportation:String ='R�pertoire d''importation';
RepExportBalance:String ='R�pertoire exportation balance';
RepExportLiasse:String ='R�pertoire exportation liasse';
RepExportGeneral:String ='R�pertoire exportation g�n�ral';
RepRelanceTiers:String ='R�pertoire relance tiers';
RepParamFTP:String ='Param�tres FTP';
RepDoubleSauvegarde:String ='R�pertoire de la double sauvegarde';
CompteReglementDef:String ='Compte de r�glement par d�faut';
TexteRajoutSauvegarde:String ='Texte � ajouter au nom de la sauvegarde';
comptePointableCaisseEnregistreuse:String ='Compte pointable pour importation caisse';
tauxTvaCaisseEnregistreuse:String ='Taux de tva pour importation caisse';
ExtensionFEC = 'Extension pour fichier FEC';
SeparateurFEC = 'Separateur pour fichier FEC';
DatePieceFEC = 'DatePiece dans dateEcriture pour fichier FEC';

C_Validate:TSysCharSet=[#45,#95, #48..#57, #65..#90, #97..#122,#8];
  type

  TMyCustGrid = class(TCustomGrid)
  end;
  TPgProperty = class(TForm)
    PaBas: TPanel;
    ColorDialog: TColorDialog;
    Button3: TButton;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaFond: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GrDBGridExemple: TGrDBGrid;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    ShapeContourLigne: TShape;
    ShapeContourCellule: TShape;
    RxLaCelActiveCouleurTexte: TRxLabel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    ImVoyant: TImage;
    RxSpeedButton3: TRxSpeedButton;
    RxSpeedButton4: TRxSpeedButton;
    RxSpeedButton5: TRxSpeedButton;
    RxSpeedButton6: TRxSpeedButton;
    RxSpeedButton7: TRxSpeedButton;
    RxSpeedButton8: TRxSpeedButton;
    RxSpeedButton9: TRxSpeedButton;
    RxSpeedButton10: TRxSpeedButton;
    Shape1: TShape;
    RxSpeedButton11: TRxSpeedButton;
    RxSpeedButton12: TRxSpeedButton;
    EdInplaceEdit: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    TabSheet2: TTabSheet;
    ChBParamTitre: TCheckBox;
    ChBParameAfficheSigleDevise: TCheckBox;
    RGGestAffich: TRadioGroup;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    TbShIcone: TTabSheet;
    ChBoxIcoMenuDemarrer: TCheckBox;
    ChBoxIcoBureau: TCheckBox;
    ChBoxIcoMenuDemarrerProg: TCheckBox;
    BtnIcoBureau: TButton;
    BtnIcoMenuDemarrer: TButton;
    BtnIcoMenuDemarrerProg: TButton;
    TabSheet3: TTabSheet;
    ChBoxAssistant: TCheckBox;
    RxSpinDelaiAssistant: TRxSpinEdit;
    LaDelai: TLabel;
    RxSBNbDos: TRxSpinEdit;
    Label1: TLabel;
    TabSheet4: TTabSheet;
    RxEditionRemise: TRxLabel;
    ChBxRxEditionRemise: TCheckBox;
    RxLabAffichIDPiece: TRxLabel;
    ChbxAffIDPiece: TCheckBox;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Valider1: TMenuItem;
    Rinitialiser1: TMenuItem;
    Accsauserveur1: TMenuItem;
    TabMessage: TTabSheet;
    GrDBGrid1: TGrDBGrid;
    PopupMenuMessage: TPopupMenu;
    Enregistre1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    TabSheet5: TTabSheet;
    Label8: TLabel;
    EditFileName: TEdit;
    BtnParcourir: TButton;
    Label9: TLabel;
    EditServeur: TEdit;
    Label10: TLabel;
    EditLogin: TEdit;
    Label11: TLabel;
    EditPassWord: TEdit;
    Label12: TLabel;
    EditEffacer: TEdit;
    Label13: TLabel;
    EditAuto: TEdit;
    BtnValider: TButton;
    BtnReinit: TButton;
    CbPrevenir: TCheckBox;
    BtnServeur: TButton;
    Button13: TButton;
    IdFTP1: TIdFTP;
    TabSheetParametres: TTabSheet;
    PaGrille: TPanel;
    PaBtn: TPanel;
    GrGrid1: TGrGrid;
    BtnValiderPropriete: TButton;
    BtnReinitialiserParametreGeneraux: TButton;
    cbSaut: TCheckBox;
    Label2: TLabel;
    EdRepDest: TEdit;
    BtnMAJRepDest: TButton;
    RGGestFocus: TRadioGroup;
    SauvegardeFermeture: TTabSheet;
    Label3: TLabel;
    PaCptIntit: TPanel;
    PaLecteurs: TPanel;
    Label4: TLabel;
    cbAutoriserSauvegardeFermeture: TRadioGroup;
    EdCheminSauvegardeFermeture: TDirectoryEdit;
    Label5: TLabel;
    EdCheminSauvegardeFermetureCloud: TDirectoryEdit;
    Label6: TLabel;
    procedure GrDBGridExempleColEnter(Sender: TObject);
    procedure GrDBGridExempleColExit(Sender: TObject);
    procedure GrDBGridExempleDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure RxLabel1Click(Sender: TObject);
    procedure RxLabel2Click(Sender: TObject);
    procedure RxLabel3Click(Sender: TObject);
    procedure RxLabel4Click(Sender: TObject);
    procedure RxLabel5Click(Sender: TObject);
    procedure RxLabel6Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxSpeedButton1MouseEnter(Sender: TObject);
    procedure RxSpeedButton1MouseLeave(Sender: TObject);
    procedure RxLabel7Click(Sender: TObject);
    procedure RxLabel8Click(Sender: TObject);
    procedure RxLabel9Click(Sender: TObject);
    procedure RxLabel10Click(Sender: TObject);
    procedure GrDBGridExempleMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ChBParamTitreClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ChBParameAfficheSigleDeviseClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure RGGestAffichClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChBoxIcoBureauClick(Sender: TObject);
    procedure ChBoxIcoMenuDemarrerClick(Sender: TObject);
    procedure ChBoxIcoMenuDemarrerProgClick(Sender: TObject);
    procedure BtnIcoBureauClick(Sender: TObject);
    procedure BtnIcoMenuDemarrerClick(Sender: TObject);
    procedure BtnIcoMenuDemarrerProgClick(Sender: TObject);
    procedure ChBoxAssistantClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChbxAffIDPieceClick(Sender: TObject);
    procedure ChBxRxEditionRemiseClick(Sender: TObject);
    procedure BtnReinitClick(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);

    procedure AfficherParamFtp;
    procedure AfficherParamSauvegardeFermeture;
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnParcourirClick(Sender: TObject);
    procedure BtnServeurClick(Sender: TObject);
    procedure Valider1Click(Sender: TObject);
    procedure Rinitialiser1Click(Sender: TObject);
    procedure EditFileNameChange(Sender: TObject);
    procedure GestionEtatBoutons(changement:boolean);
    procedure EditServeurChange(Sender: TObject);
    procedure EditLoginChange(Sender: TObject);
    procedure EditPassWordChange(Sender: TObject);
    procedure EditEffacerChange(Sender: TObject);
    procedure EditAutoChange(Sender: TObject);
    procedure initChangeEdit(null:boolean);
    procedure Button8Click(Sender: TObject);
    procedure CbPrevenirClick(Sender: TObject);
    procedure Annuler1Click(Sender: TObject);
    procedure Enregistre1Click(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure GrDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControl1Change(Sender: TObject);
    procedure Accsauserveur1Click(Sender: TObject);
    procedure AfficherParametresGeneraux;
    procedure ReinitialiseParametreDossierDefaut(param:String='');
    procedure BtnValiderProprieteClick(Sender: TObject);
    procedure GrGrid1BeforeSupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    procedure BtnReinitialiserParametreGenerauxClick(Sender: TObject);
    procedure GestionEtatBoutonsParametreGeneraux(changement:boolean);
    procedure GrGrid1Change(Sender: TObject);
    procedure TabSheetParametresHide(Sender: TObject);
    procedure Rinitialiserparamtrecourant1Click(Sender: TObject);
    procedure GrGrid1KeyPress(Sender: TObject; var Key: Char);
    function ValidateInput(Key: Char):boolean;
    procedure ValidationTemporaire;
    procedure cbSautClick(Sender: TObject);
    procedure EdRepDestChange(Sender: TObject);
    procedure BtnMAJRepDestClick(Sender: TObject);
    procedure TabMessageResize(Sender: TObject);
    procedure GrDBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure cbAutoriserSauvegardeFermetureClick(Sender: TObject);
    procedure EdCheminSauvegardeFermetureChange(Sender: TObject);
    procedure EdCheminSauvegardeFermetureAfterDialog(Sender: TObject;
      var Name: String; var Action: Boolean);
    procedure EdCheminSauvegardeFermetureCloudAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure EdCheminSauvegardeFermetureCloudChange(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  MessageLGR:TMessageLGR;

  end;

var
  PgProperty: TPgProperty;
  ColorGridTmp:TVarColorGrid;
      function EssaiConnection:boolean;

implementation

uses DMAide,LibRessourceString,lib_chaine,LibSQL, E2_Main, DMXMLs,
  DMRecherche, Lib1, DMConstantes, DiversProjets;
{$R *.DFM}

procedure TPgProperty.GrDBGridExempleColEnter(Sender: TObject);
begin
GrDBGridExemple.Columns[GrDBGridExemple.SelectedIndex].Title.Font.Style:=[fsbold];
if GrDBGridExemple.DataSource.State in [dsedit,dsInsert] then
GrDBGridExemple.Columns[GrDBGridExemple.SelectedIndex].Title.Font.Style:=GrDBGridExemple.Columns[GrDBGridExemple.SelectedIndex].Title.Font.Style+[fsItalic];
GrDBGridExemple.Columns[GrDBGridExemple.SelectedIndex].Title.Font.Color:=clRed;
end;

procedure TPgProperty.GrDBGridExempleColExit(Sender: TObject);
begin
GrDBGridExemple.Columns[GrDBGridExemple.SelectedIndex].Title.Font.Style:=[];
GrDBGridExemple.Columns[GrDBGridExemple.SelectedIndex].Title.Font.Color:=clWindowText;
end;

procedure TPgProperty.GrDBGridExempleDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  RectLine:TRect;
begin
    GrDBGridExemple.Canvas.Pen.Color:=ParamUtil.CouleurDBGrid.LigneContour;
//    GrDBGridExemple.Canvas.Pen.Color:=clgreen;
    GrDBGridExemple.Canvas.Pen.Width:=2;
    RectLine:=(TMyCustGrid(GrDBGridExemple)).Boxrect(0,GrDBGridExemple.Row,GrDBGridExemple.ColCount,GrDBGridExemple.Row);
    GrDBGridExemple.Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Bottom-1),point(RectLine.Left+1,RectLine.Bottom-1),Point(RectLine.Left+1,RectLine.Top+1)]);
    RectLine:=GrDBGridExemple.CellRect(GrDBGridExemple.Col,GrDBGridExemple.Row);
//    DBEmprunt.Canvas.Polyline([Point(RectLine.Left+1,0),Point(RectLine.Left+1,RectLine.Top+1)]);
//    GrDBGridExemple.Canvas.Pen.Color:=$0000E600;Main.ContourCelActive;
    GrDBGridExemple.Canvas.Pen.Color:=ParamUtil.CouleurDBGrid.CelActiveContour;
    GrDBGridExemple.Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+2),Point(RectLine.Right-1,RectLine.Top+2),Point(RectLine.Right-1,RectLine.Bottom-2),point(RectLine.Left+1,RectLine.Bottom-2),Point(RectLine.Left+1,RectLine.Top+2)]);
end;

procedure TPgProperty.RxLabel1Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  ColorGridTmp.LigneContour:=ColorDialog.color;
  ShapeContourLigne.Pen.Color:=ColorGridTmp.LigneContour;
  GrDBGridExemple.Param:=ColorGridTmp;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.RxLabel2Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  ColorGridTmp.CelActiveContour:=ColorDialog.color;
  ShapeContourCellule.Pen.Color:=ColorGridTmp.CelActiveContour;
  GrDBGridExemple.Param:=ColorGridTmp;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.RxLabel3Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  ColorGridTmp.CelActiveColorFond:=ColorDialog.color;
  GrDBGridExemple.Param:=ColorGridTmp;
  ShapeContourCellule.Brush.Color:=ColorGridTmp.CelActiveColorFond;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.RxLabel4Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  ColorGridTmp.CelActiveColorFont:=ColorDialog.color;
  GrDBGridExemple.Param:=ColorGridTmp;
  RxLaCelActiveCouleurTexte.Font.Color:=ColorGridTmp.CelActiveColorFont;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.RxLabel5Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  EdInplaceEdit.Visible:=true;
  EdInplaceEdit.SetFocus;
  ColorGridTmp.CelActiveSAisieColorFond:=ColorDialog.color;
  GrDBGridExemple.Param:=ColorGridTmp;
  EdInplaceEdit.Color:=ColorGridTmp.CelActiveSAisieColorFond;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.RxLabel6Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  EdInplaceEdit.Visible:=true;
  EdInplaceEdit.SetFocus;
  ColorGridTmp.CelActiveSAisieColorFont:=ColorDialog.color;
  GrDBGridExemple.param:=ColorGridTmp;
  EdInplaceEdit.Font.Color:=ColorGridTmp.CelActiveSAisieColorFont;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_RETURN then
   if EdInplaceEdit.Visible then
        EdInplaceEdit.Visible:=false;
if (key = VK_RETURN)then
 WinSuivPrec(Handle,key,[GrDBGridExemple]);        
end;

procedure TPgProperty.RxSpeedButton1MouseEnter(Sender: TObject);
begin
ImVoyant.Top:=(sender as TControl).Top+7;
ImVoyant.left:=(sender as TControl).left-23;
ImVoyant.Visible:=true;
end;

procedure TPgProperty.RxSpeedButton1MouseLeave(Sender: TObject);
begin
ImVoyant.Visible:=false;
end;

procedure TPgProperty.RxLabel7Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  ColorGridTmp.CelFixeColorFond:=ColorDialog.color;
  GrDBGridExemple.param:=ColorGridTmp;
  GrDBGridExemple.UpDateColor;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.RxLabel8Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  ColorGridTmp.CelFixeColorFont:=ColorDialog.color;
  GrDBGridExemple.param:=ColorGridTmp;
  GrDBGridExemple.UpDateColor;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.RxLabel9Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  ColorGridTmp.GrilleColorFond:=ColorDialog.color;
  GrDBGridExemple.param:=ColorGridTmp;
  ShapeContourLigne.Brush.Color:=ColorGridTmp.GrilleColorFond;
  GrDBGridExemple.UpDateColor;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.RxLabel10Click(Sender: TObject);
begin
if ColorDialog.Execute then
 begin
  ColorGridTmp.GrilleColorFont:=ColorDialog.color;
  GrDBGridExemple.param:=ColorGridTmp;
  GrDBGridExemple.UpDateColor;
  GrDBGridExemple.Repaint;
  Button1.Enabled:=true;
 end;
end;

procedure TPgProperty.GrDBGridExempleMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
//var
////    Pt: TPoint;
//    Can:TCanvas;
//    Rect:TRect;
begin
//Can:=TCanvas.Create;
//can.Font.Color:=clred;
////Columns[MouseCoord(Pt.x,Pt.y).X].Field
//if ((GrDBGridExemple.MouseCoord(x,y).X > 0) and (GrDBGridExemple.MouseCoord(x,y).Y>0)) then
// begin
////cellAttribute(Columns[MouseCoord(Pt.x,Pt.y).X].Field,can,[]);
//REct:=GrDBGridExemple.CellRect(GrDBGridExemple.MouseCoord(x,y).X,GrDBGridExemple.MouseCoord(x,y).Y);
//GrDBGridExemple.Canvas.brush.color:=clREd;
//GrDBGridExemple.Canvas.FloodFill(rect.Left+1,REct.Top+1,clblack,fsBorder);
////Rectangle(rect.Left,REct.Top,Rect.Right,Rect.Bottom);
////GrDBGridExemple.Canvas.TextOut(X,Y,'eeeeeee');
//end;
////showmessage(GrDBGridExemple.Columns[GrDBGridExemple.MouseCoord(x,y).X-1].Field.AsString);
//can.free;
end;

procedure TPgProperty.Button1Click(Sender: TObject);
var
ListeCouleurDBGrid:TStringList;
i:integer;
begin
  ListeCouleurDBGrid:=TStringList.Create;
  for i:=0 to 10 do
      begin
       ListeCouleurDBGrid.Add('');
       case i of
          0:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.LigneContour);
          1:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.CelActiveContour);
          2:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.CelActiveColorFond);
          3:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.CelActiveColorFont);
          4:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.CelActiveSAisieColorFont);
          5:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.CelActiveSAisieColorFond);
          6:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.CelFixeColorFond);
          7:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.CelFixeColorFont);
          8:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.GrilleColorFond);
          9:ListeCouleurDBGrid.Strings[i]:=ColorToString(ColorGridTmp.GrilleColorFont);
       end;
      ListeCouleurDBGrid.SaveToFile(E.RepertoireProgram+ 'Datadb.dat');
      end;
  ListeCouleurDBGrid.Free;
  Button1.Enabled:=false;
  ParamUtil.CouleurDBGrid:=ColorGridTmp;
end;

procedure TPgProperty.FormActivate(Sender: TObject);
begin
  ColorGridTmp:=ParamUtil.CouleurDBGrid;
  ShapeContourLigne.Pen.Color:=ParamUtil.CouleurDBGrid.LigneContour;
  ShapeContourCellule.Pen.Color:=ParamUtil.CouleurDBGrid.CelActiveContour;
  ShapeContourCellule.Brush.Color:=ParamUtil.CouleurDBGrid.CelActiveColorFond;
  RxLaCelActiveCouleurTexte.Font.Color:=ParamUtil.CouleurDBGrid.CelActiveColorFont;
  EdInplaceEdit.Color:=ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond;
  EdInplaceEdit.Font.Color:=ParamUtil.CouleurDBGrid.CelActiveSAisieColorFont;
  GrDBGridExemple.ParamColor:=true;
  GrDBGridExemple.Param:=ParamUtil.CouleurDBGrid;
  GrDBGridExemple.UpDateColor;
  ChBParamTitre.Checked:=Main.AfficheTitre;

  ChBoxIcoBureau.Checked:=ParamUtil.IcoBureau;
  ChBoxIcoMenuDemarrer.Checked:=ParamUtil.IcoMenuDemarrer;
  ChBoxIcoMenuDemarrerProg.Checked:=ParamUtil.IcoMenuProgramme;

  if Main.MonoFenetrage then
  RGGestAffich.ItemIndex:=0
  else
  RGGestAffich.ItemIndex:=1;


  if not ParamUtil.FocusDesactive then
  RGGestFocus.ItemIndex:=0
  else
  RGGestFocus.ItemIndex:=1;


  ChBoxAssistant.Checked := ParamUtil.AssistantAffichageAuto;
  RxSpinDelaiAssistant.Enabled := ParamUtil.AssistantAffichageAuto;
  RxSpinDelaiAssistant.AsInteger := ParamUtil.AssistantDelaiAffichage;
  RxSBNbDos.AsInteger := ParamUtil.MaxDosMenu;

  ChbxAffIDPiece.Checked := ParamUtil.AffichIDPiece;
  ChBxRxEditionRemise.Checked := E.RemiseAuto;
  AfficherParamFtp;
  AfficherParametresGeneraux;
  AfficherParamSauvegardeFermeture;
  GestionEtatBoutons(false);

end;

procedure TPgProperty.Button4Click(Sender: TObject);
begin
//Button1.Click;
self.close;
end;

procedure TPgProperty.Button2Click(Sender: TObject);
begin
FormActivate(self);
//self.close;
end;

procedure TPgProperty.ChBParamTitreClick(Sender: TObject);
begin
if ChBParamTitre.Checked then
   Begin
    Main.AfficheTitre:=true;
    ParamUtil.AfficheTitre := true;
    Patitre.Visible:=true;
    Patitre.Align:=alTop;
   End
    else
   Begin
    Main.AfficheTitre:=False;
    ParamUtil.AfficheTitre := False;
    Patitre.Visible:=False;
   End;
Button6.Enabled:=true;
end;

procedure TPgProperty.Button3Click(Sender: TObject);
begin
close;
end;

procedure TPgProperty.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
TabSheetParametresHide(TabSheetParametres);
tablegereCancel(DMMessageLGR.TaMessageLGR);
canclose:=true;
end;

procedure TPgProperty.ChBParameAfficheSigleDeviseClick(Sender: TObject);
begin
if ChBParameAfficheSigleDevise.Checked then
   Begin
   E.DeviseSigle:=DeviseSigle(E.Devise);
   E.FormatMonnaie:=',0.00 '+E.DeviseSigle+';-,0.00 '+E.DeviseSigle+';,0.00 '+E.DeviseSigle;
   End
    else
   Begin
   E.DeviseSigle:='';
   E.FormatMonnaie:=',0.00 '+E.DeviseSigle+';-,0.00 '+E.DeviseSigle+';,0.00 '+E.DeviseSigle;
   End;
Button6.Enabled:=true;
end;

procedure TPgProperty.Button6Click(Sender: TObject);
var
i:integer;
begin
Main.AfficheTitre:=ChBParamTitre.Checked;
ParamUtil.MaxDosMenu := RxSBNbDos.AsInteger;

Gr_MultDos.AjoutMenu(Main.Multidossier);
  case RGGestAffich.ItemIndex of
   0:Begin
      for i:=0 to screen.FormCount-1 do
        Begin
         if ((APPlication.MainForm <> screen.Forms[i]) and (self <> screen.Forms[i])) then
                    if screen.Forms[i].Visible then screen.Forms[i].Hide;
        End;
      main.Monofenetrage:=true;
     End;
   1:Begin
      main.Monofenetrage:=false;
     End;
  end;
  case RGGestFocus.ItemIndex of
   0:Begin
      ParamUtil.FocusDesactive:=false;
     End;
   1:Begin
      ParamUtil.FocusDesactive:=true;
     End;
  end;

Button6.Enabled:=false;
end;

procedure TPgProperty.RGGestAffichClick(Sender: TObject);
begin
Button6.Enabled:=true;
end;

procedure TPgProperty.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
      GrGrid1.ParamColor:=true;
      GrGrid1.Param:=ParamUtil.CouleurDBGrid;
      GrGrid1.DessineContourLigne:=false;
      GrGrid1.UpDateColor;
  except
      Position:=poScreenCenter;
  end;
end;

procedure TPgProperty.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
PgProperty:=nil;
end;

procedure TPgProperty.ChBoxIcoBureauClick(Sender: TObject);
begin
ParamUtil.IcoBureau:=ChBoxIcoBureau.Checked;

end;

procedure TPgProperty.ChBoxIcoMenuDemarrerClick(Sender: TObject);
begin
ParamUtil.IcoMenuDemarrer:=ChBoxIcoMenuDemarrer.Checked
end;

procedure TPgProperty.ChBoxIcoMenuDemarrerProgClick(Sender: TObject);
begin
ParamUtil.IcoMenuProgramme:=ChBoxIcoMenuDemarrerProg.Checked;
end;

procedure TPgProperty.BtnIcoBureauClick(Sender: TObject);
begin
    CreateShortcut(Application.ExeName,_DESKTOP ,'');
end;

procedure TPgProperty.BtnIcoMenuDemarrerClick(Sender: TObject);
begin
    CreateShortcut(Application.ExeName,_STARTMENU,'');
end;

procedure TPgProperty.BtnIcoMenuDemarrerProgClick(Sender: TObject);
begin
    CreateShortcut(Application.ExeName,_STARTMENU,'Programmes');
end;

procedure TPgProperty.ChBoxAssistantClick(Sender: TObject);
begin
ParamUtil.AssistantAffichageAuto := ChBoxAssistant.Checked;
RxSpinDelaiAssistant.Enabled := ParamUtil.AssistantAffichageAuto;
ParamUtil.AssistantDelaiAffichage := RxSpinDelaiAssistant.AsInteger;
end;

procedure TPgProperty.FormShow(Sender: TObject);
begin
Button6.Enabled := true;
PageControl1.ActivePage:=TabSheet5;
AfficherParamFtp;
end;

procedure TPgProperty.ChbxAffIDPieceClick(Sender: TObject);
begin
ParamUtil.AffichIDPiece:=ChbxAffIDPiece.Checked;
end;

procedure TPgProperty.ChBxRxEditionRemiseClick(Sender: TObject);
begin
e.RemiseAuto:=ChBxRxEditionRemise.Checked;
end;

procedure TPgProperty.BtnReinitClick(Sender: TObject);
begin
//vider le fichier texte des param�tres FTP
if Application.MessageBox(Pchar('Etes-vous s�r de vouloir r�initialiser vos param�tres FTP ?'),
  'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
   InitParamFTP(E.paramftp,e.NomDossier,DM_C_ServeurFTP);
   EcritFichierParamFTP(E.paramftp,e.ParamFTP);
AfficherParamFtp;
//GestionEtatBoutons(true);
end;

procedure TPgProperty.BtnValiderClick(Sender: TObject);
begin
InitParamFTP(E.paramftp,e.NomDossier,DM_C_ServeurFTP);
e.ParamFTP.Fichier:=EditFileName.Text;
e.ParamFTP.Serveur:= EditServeur.Text;
e.ParamFTP.Login:= EditLogin.Text;
e.ParamFTP.PassWord:= EditPassWord.Text;
e.ParamFTP.Effacer:= EditEffacer.Text;
e.ParamFTP.Dest:=EdRepDest.Text;
if MessageLGR<>nil then
  begin
    MessageLGR.Afficher:=not CbPrevenir.Checked;
    if MessageLGR.Id_Message<>-1 then DM_EcritMessageLGR(MessageLGR);
  end;
//e.ParamFTP.Prevenir:=str_bool2str_LGR(CbPrevenir.Checked,'1','0');
EcritFichierParamFTP(E.paramftp,e.ParamFTP);
if EssaiConnection then
  GestionEtatBoutons(false);
end;


procedure TPgProperty.AfficherParamFtp;
begin
initChangeEdit(true);
if not FileExists(e.ParamFTP.Fichier)then E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;
LitFichierParamFTP(e.ParamFTP.Fichier,e.ParamFTP,false,e.NomDossier,DM_C_ServeurFTP,e.ParamFTP,e.RepertoireDossier);
EditFileName.Text:=e.ParamFTP.Fichier;
EditServeur.Text:=e.ParamFTP.Serveur;
EditLogin.Text:=e.ParamFTP.Login;
EditPassWord.Text:=e.ParamFTP.PassWord;
EditEffacer.Text:=e.ParamFTP.Effacer;
EditAuto.Text:=e.ParamFTP.Auto;
EdRepDest.Text:=e.ParamFTP.Dest;
MessageLGR:=DM_LitMessageLGR('GestSauvegarde','','EnvoieFTP');
if MessageLGR<>nil then
  CbPrevenir.Checked:=not MessageLGR.Afficher
else
  CbPrevenir.Checked:=false;
GestionEtatBoutons(false);
EnableWinControl([EditFileName,EditServeur,EditAuto,BtnParcourir,EditEffacer],((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')));
initChangeEdit(false);
end;

procedure TPgProperty.AfficherParamSauvegardeFermeture;
begin
EdCheminSauvegardeFermeture.Text:=E.RepertoireSauvegardeFermture;
EdCheminSauvegardeFermetureCloud.Text:=E.RepertoireSauvegardeFermtureCloud;
//MessageLGR:=DM_LitMessageLGR('Main','','SauvegardeFermeture');
//if MessageLGR<>nil then
//  cbAfficherMessage.Checked:=MessageLGR.Afficher
//else
//  cbAfficherMessage.Checked:=true;

//cbAfficherMessage.ItemIndex:= BoolToInt(e.AfficherMessageSauvegardeFermeture);
cbAutoriserSauvegardeFermeture.ItemIndex:=BoolToInt(e.AutoriserSauvegardeFermeture);
//if(e.AutoriserSauvegardeFermeture)then
//cbAutoriserSauvegardeFermeture.State:=cbChecked
//else
//cbAutoriserSauvegardeFermeture.State:=cbunChecked;
end;

procedure TPgProperty.initChangeEdit(null:boolean);
begin
if null then
  begin
      EditFileName.OnChange:=nil;
      EditServeur.OnChange:=nil;
      EditLogin.OnChange:=nil;
      EditPassWord.OnChange:=nil;
      EditEffacer.OnChange:=nil;
      EditAuto.OnChange:=nil;
  end
else
  begin
      EditFileName.OnChange:=EditFileNameChange;
      EditServeur.OnChange:=EditServeurChange;
      EditLogin.OnChange:=EditLoginChange;
      EditPassWord.OnChange:=EditPassWordChange;
      EditEffacer.OnChange:=EditEffacerChange;
      EditAuto.OnChange:=EditAutoChange;
  end;
end;

procedure TPgProperty.BtnAnnulerClick(Sender: TObject);
begin
AfficherParamFtp;
end;

procedure TPgProperty.BtnParcourirClick(Sender: TObject);
var
rep,filename:string;
begin
rep:=ExtractFileDir(e.ParamFTP.Fichier);

  OpenDialog1.DefaultExt:='txt';
  OpenDialog1.FileName := ExtractFileName(e.ParamFTP.Fichier);
  OpenDialog1.InitialDir := rep;
  OpenDialog1.Title := 'Param�tres FTP';
  if OpenDialog1.Execute then EditFileName.Text:= OpenDialog1.FileName
  else abort;
end;

procedure TPgProperty.BtnServeurClick(Sender: TObject);
var
connection:boolean;
begin
if LitFichierParamFTP(e.ParamFTP.Fichier,e.ParamFTP,true,e.NomDossier,DM_C_ServeurFTP,e.ParamFTP,e.RepertoireDossier) then
    begin
      if EssaiConnection then
        ShellExecute(handle,'open','IEXPLORE.EXE', pchar('ftp://'+e.ParamFTP.Login+':'+
           e.ParamFTP.PassWord+'@'+e.ParamFTP.Serveur+'/'+e.ParamFTP.Dest),
            NiL, SW_SHOWNORMAL)
    end;
end;


function EssaiConnection:boolean;
begin
result:=false;
  if PgProperty=nil then PgProperty:=TPgProperty.Create(application.MainForm);
  PgProperty.IdFTP1.Host:=e.ParamFTP.Serveur;
  PgProperty.IdFTP1.Password:=e.ParamFTP.PassWord;
  PgProperty.IdFTP1.Username:=e.ParamFTP.Login;
  try
  PgProperty.IdFTP1.Connect();
  result:=true;
  PgProperty.IdFTP1.Quit;
  except
     application.MessageBox(Pansichar(connexionInvalide),'Adresse FTP invalide',MB_ICONWARNING);
     result:=false;
  end;
end;

procedure TPgProperty.Valider1Click(Sender: TObject);
begin
if PageControl1.TabIndex=TabSheet5.TabIndex then BtnValider.Click;
if PageControl1.TabIndex=TabSheetParametres.TabIndex then BtnValiderPropriete.Click;
end;

procedure TPgProperty.Rinitialiser1Click(Sender: TObject);
begin
if PageControl1.TabIndex=TabSheet5.TabIndex then BtnReinit.Click;
if PageControl1.TabIndex=TabSheetParametres.TabIndex then BtnReinitialiserParametreGeneraux.Click;
end;

procedure TPgProperty.EditFileNameChange(Sender: TObject);
begin
e.RepertoireSauvegardeFermture:=EdCheminSauvegardeFermeture.Text;
end;


procedure TPgProperty.GestionEtatBoutons(changement:boolean);
begin
BtnValider.Enabled:=changement;
BtnReinit.Enabled:=not changement;
BtnServeur.Enabled:=not changement;
CbPrevenir.Enabled:=((MessageLGR<>nil)and(MessageLGR.Id_Message<>-1)); 
//popup
Valider1.Enabled:=BtnValider.Enabled;
Rinitialiser1.Enabled:=BtnReinit.Enabled;
Accsauserveur1.Enabled:=BtnServeur.Enabled;
EdRepDest.Enabled:=((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
end;

procedure TPgProperty.EditServeurChange(Sender: TObject);
begin
GestionEtatBoutons(true);
end;

procedure TPgProperty.EditLoginChange(Sender: TObject);
begin
GestionEtatBoutons(true);
end;

procedure TPgProperty.EditPassWordChange(Sender: TObject);
begin
GestionEtatBoutons(true);
end;

procedure TPgProperty.EditEffacerChange(Sender: TObject);
begin
GestionEtatBoutons(true);
end;

procedure TPgProperty.EditAutoChange(Sender: TObject);
begin
GestionEtatBoutons(true);
end;

procedure TPgProperty.Button8Click(Sender: TObject);
begin
   ShellExecute(handle, 'open', 'http://sauvepi.monftp-1.net', NiL, NiL, SW_SHOWNORMAL);
end;

procedure TPgProperty.CbPrevenirClick(Sender: TObject);
begin
  GestionEtatBoutons(true);
if MessageLGR<>nil then
  begin
    MessageLGR.Afficher:=not CbPrevenir.Checked;
    if MessageLGR.Id_Message<>-1 then DM_EcritMessageLGR(MessageLGR);
  end;
//  e.ParamFTP.Prevenir:=str_bool2str_LGR(CbPrevenir.Checked,'1','0');
end;

procedure TPgProperty.Annuler1Click(Sender: TObject);
begin
tablegereCancel(DMMessageLGR.TaMessageLGR);
end;

procedure TPgProperty.Enregistre1Click(Sender: TObject);
begin
TableGerePost(DMMessageLGR.TaMessageLGR);
end;

procedure TPgProperty.Modifier1Click(Sender: TObject);
begin
TableGereEdit(DMMessageLGR.TaMessageLGR);
end;

procedure TPgProperty.Supprimer1Click(Sender: TObject);
begin
TableGereDelete(DMMessageLGR.TaMessageLGR);
end;

procedure TPgProperty.PopupMenu1Popup(Sender: TObject);
begin
if PageControl1.TabIndex=TabSheet5.TabIndex then
 begin
//    Rinitialiserparamtrecourant1.Visible:=false;
    Accsauserveur1.Visible:=true;
 end
else
if PageControl1.TabIndex=TabSheetParametres.TabIndex then
 begin
//     Rinitialiserparamtrecourant1.Visible:=true;
     Accsauserveur1.Visible:=false;
 end
 else
  abort;
end;

procedure TPgProperty.GrDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ((key=Vk_down) and (GrDBGrid1.row=GrDBGrid1.RowCount-1)) then abort;

end;

procedure TPgProperty.PageControl1Change(Sender: TObject);
begin
if PageControl1.TabIndex=TabMessage.TabIndex then
  GrDBGrid1.SetFocus;
if PageControl1.TabIndex = TabSheetParametres.TabIndex then
  AfficherParametresGeneraux;
if PageControl1.TabIndex =SauvegardeFermeture.TabIndex then
 AfficherParamSauvegardeFermeture;
TabMessageResize(TabMessage);
end;

procedure TPgProperty.Accsauserveur1Click(Sender: TObject);
begin
if PageControl1.TabIndex=TabSheet5.TabIndex then BtnServeur.Click;
end;


procedure TPgProperty.AfficherParametresGeneraux;
var
liste : TStringList;
i:integer;
separateur:String;
begin

separateur:=#135;

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.UpDateColor;

GrGrid1.RowCount:=2;

GrGrid1.Rows[0].Clear;
GrGrid1.Rows[1].Clear;

liste:=TStringList.Create;
GrGrid1.ColCount:=4;
GrGrid1.ColWidths[0]:=0;
GrGrid1.ColWidths[1]:=0;
GrGrid1.ColWidths[2]:=300;
GrGrid1.ColWidths[3]:=300;

liste.Add('D'+separateur+CXML_RepImportation+separateur+RepImportation+separateur+E.RepertoireImportation);
liste.Add('D'+separateur+CXML_RepExportationBalance+separateur+RepExportBalance+separateur+E.RepertoireExportBalance);
liste.Add('D'+separateur+CXML_RepExportationLiasse+separateur+RepExportLiasse+separateur+E.RepertoireExportLiasse);
liste.Add('D'+separateur+CXML_RepExportationDossier+separateur+RepExportGeneral+separateur+E.RepertoireExportDossier);
liste.Add('D'+separateur+CXML_RepRelanceTiers+separateur+RepRelanceTiers+separateur+E.RepertoireRelanceTiers);
liste.Add('D'+separateur+CXML_ParamFTP+separateur+RepParamFTP+separateur+E.ParamFTP.Fichier);
liste.Add('D'+separateur+CXML_RepDblSauvegarde+separateur+RepDoubleSauvegarde+separateur+E.RepertoireDblSauvegarde);
liste.Add('D'+separateur+CXML_CompteBanqueDefaut+separateur+CompteReglementDef+separateur+E.CompteBanqueDefaut);
liste.Add('P'+separateur+CXML_NomSauvegarde+separateur+TexteRajoutSauvegarde+separateur+E.NomSauvegarde);
liste.Add('D'+separateur+CXML_ComptePointableCaisseEnregistreuse+separateur+comptePointableCaisseEnregistreuse+separateur+E.ComptePointableCaisseEnregistreuse);
liste.Add('D'+separateur+CXML_TauxTvaCaisseEnregistreuse+separateur+tauxTvaCaisseEnregistreuse+separateur+E.TauxTvaCaisseEnregistreuse);
liste.Add('D'+separateur+CXML_ExtensionFEC+separateur+ExtensionFEC+separateur+E.ExtensionFEC);
liste.Add('D'+separateur+CXML_SeparateurFEC+separateur+SeparateurFEC+separateur+E.SeparateurFEC);
liste.Add('D'+separateur+CXML_DatePieceFEC+separateur+DatePieceFEC+separateur+BoolToStr(E.DatePieceFEC));



GrGrid1.RowCount := liste.Count+1;
for i:=0 to liste.Count-1 do
  begin
    GrGrid1.cellsGr(0,i+1,GetStringElement(liste.Strings[i],1,separateur[1]));
    GrGrid1.cellsGr(1,i+1,GetStringElement(liste.Strings[i],2,separateur[1]));
    GrGrid1.cellsGr(2,i+1,GetStringElement(liste.Strings[i],3,separateur[1]));
    GrGrid1.cellsGr(3,i+1,GetStringElement(liste.Strings[i],4,separateur[1]));
  end;
liste.Free;
if(e.SautDePageAutomatique)then
cbSaut.State:=cbChecked
else
cbSaut.State:=cbunChecked;
BtnValiderPropriete.Enabled:=false;
TabSheetParametres.PopupMenu:=PopupMenu1;
End;
//

procedure TPgProperty.BtnValiderProprieteClick(Sender: TObject);
var
i:integer;
begin
for i:=0 to GrGrid1.RowCount-1 do
  begin
     if not empty(GrGrid1.Cells[0,i+1])then
       if(GrGrid1.Cells[0,i+1]='P')then
          DMXml.ModifieItemProgramme(GrGrid1.Cells[1,i+1],GrGrid1.Cells[3,i+1]);
       if(GrGrid1.Cells[0,i+1]='D')then
         DMXml.ModifieVarDos(E.NomDossier,GrGrid1.Cells[1,i+1],GrGrid1.Cells[3,i+1]);
       if(GrGrid1.Cells[0,i+1]='E')then
         DMXml.ModifieVarExo(E.NomDossier,E.NomExo,GrGrid1.Cells[1,i+1],GrGrid1.Cells[3,i+1]);
  end;
DMXml.ModifieItemProgramme('SautDePageAutomatique',str_bool2str_LGR(E.SautDePageAutomatique ,'Oui','Non'));
RecupXmlDossier(E.NomDossier);
AfficherParametresGeneraux;
end;

procedure TPgProperty.ValidationTemporaire;
begin
E.RepertoireImportation:=GrGrid1.Cells[3,1];
E.RepertoireExportBalance:=GrGrid1.Cells[3,2];
E.RepertoireExportLiasse:=GrGrid1.Cells[3,3];
E.RepertoireExportDossier:=GrGrid1.Cells[3,4];
E.RepertoireRelanceTiers:=GrGrid1.Cells[3,5];
E.ParamFTP.Fichier:=GrGrid1.Cells[3,6];
E.RepertoireDblSauvegarde:=GrGrid1.Cells[3,7];
E.CompteBanqueDefaut:=GrGrid1.Cells[3,8];
E.NomSauvegarde:=GrGrid1.Cells[3,9];
E.ComptePointableCaisseEnregistreuse:=GrGrid1.Cells[3,10];
E.TauxTvaCaisseEnregistreuse:=GrGrid1.Cells[3,11];

E.ExtensionFEC:=GrGrid1.Cells[3,12];
E.SeparateurFEC:=GrGrid1.Cells[3,13];
E.DatePieceFEC:=StrToBool_Lgr(GrGrid1.Cells[3,14],false);
E.SautDePageAutomatique:=cbSaut.State=cbChecked;
end;

procedure TPgProperty.ReinitialiseParametreDossierDefaut(param:String);
begin
          // Importation En G�n�ral
         if (param='')or(param=CXML_RepImportation) then
           E.RepertoireImportation := E.RepertoireDossier + C_RepImportation;

         // Repertoire Exportation Balance
         if (param='')or(param=CXML_RepExportationBalance) then
           E.RepertoireExportBalance := E.RepertoireProgram + C_RepExportation;

          // fichier de param�tres FTP
         if (param='')or(param=CXML_ParamFTP) then
           E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;

          // Repertoire Exportation Relance des tiers
         if (param='')or(param=CXML_RepRelanceTiers) then
           E.RepertoireRelanceTiers := E.RepertoireDossier + C_RepExportation;

         // Repertoire Exportation liasse
         if (param='')or(param=CXML_RepExportationLiasse) then
           E.RepertoireExportLiasse := E.RepertoireProgram + C_RepExportationLiasse;

         // Repertoire Exportation Dossier
         if (param='')or(param=CXML_RepExportationDossier) then
           E.RepertoireExportDossier := E.RepertoireDossier + C_RepExportation;

         // Compte de banque par d�faut
         if (param='')or(param=CXML_CompteBanqueDefaut) and(str_recherchesouschaine(Uppercase(E.RepertoireProgram),'LGR\EPICEA').retour=true)then
           E.CompteBanqueDefaut := Infos_TInfosModel(DMRech.TaModelRech,'journal',['B1']).Compte;

         if (param='')or(param=CXML_NomSauvegarde) then
           E.NomSauvegarde :='';

         if (param='')or(param=CXML_RepDblSauvegarde) then
           E.RepertoireDblSauvegarde := '';

         // Compte pointable caisse enregistreuse par d�faut
         if (param='')or(param=CXML_ComptePointableCaisseEnregistreuse) then
           E.ComptePointableCaisseEnregistreuse := '411';

         // taux tva caisse enregistreuse par d�faut
         if (param='')or(param=CXML_TauxTvaCaisseEnregistreuse)then
           E.TauxTvaCaisseEnregistreuse := '19.6';

         if (param='')or(param=CXML_ExtensionFEC)then
           E.ExtensionFEC := '.csv';
         if (param='')or(param=CXML_SeparateurFEC)then
           E.SeparateurFEC := '|';
         if (param='')or(param=CXML_DatePieceFEC)then
           E.DatePieceFEC := false;
end;


procedure TPgProperty.GrGrid1BeforeSupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
begin
abort;
end;

procedure TPgProperty.BtnReinitialiserParametreGenerauxClick(Sender: TObject);
begin
ValidationTemporaire;
ReinitialiseParametreDossierDefaut(GrGrid1.Cells[1,grgrid1.Row]);
if Application.MessageBox(PChar('Etes-vous s�r de vouloir r�cup�rer le param�tre par d�faut ?'+
   RetourChariotSimple+'Ceci va remplacer votre param�tre !!!'),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON2) = IDNo then
   begin
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_RepImportation)then
       E.RepertoireImportation:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_RepExportationBalance)then
       E.RepertoireExportBalance:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_RepExportationLiasse)then
       E.RepertoireExportLiasse:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_RepExportationDossier)then
       E.RepertoireExportDossier:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_RepRelanceTiers)then
       E.RepertoireRelanceTiers:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_ParamFTP)then
       E.ParamFTP.Fichier:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_RepDblSauvegarde)then
       E.RepertoireDblSauvegarde:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_CompteBanqueDefaut)then
       E.CompteBanqueDefaut:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_NomSauvegarde)then
       E.NomSauvegarde:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_ComptePointableCaisseEnregistreuse)then
       E.ComptePointableCaisseEnregistreuse:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_TauxTvaCaisseEnregistreuse)then
       E.TauxTvaCaisseEnregistreuse:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_ExtensionFEC)then
       E.ExtensionFEC:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_SeparateurFEC)then
       E.SeparateurFEC:=RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]);
     if(GrGrid1.Cells[1,grgrid1.Row]=CXML_DatePieceFEC)then
       E.DatePieceFEC:=StrToBool_Lgr(RecupXmlDossierValeur(E.NomDossier,GrGrid1.Cells[1,grgrid1.Row]),false);
     //RecupXmlDossier(E.NomDossier);
   end;
AfficherParametresGeneraux;
GestionEtatBoutonsParametreGeneraux(true);
end;


procedure TPgProperty.GestionEtatBoutonsParametreGeneraux(changement:boolean);
begin
 BtnValiderPropriete.Enabled := changement;
 BtnReinitialiserParametreGeneraux.Enabled := changement;
// BtnReinitialiserParametreGeneraux.Enabled := (VersionMaintenance and changement);
end;



procedure TPgProperty.GrGrid1Change(Sender: TObject);
begin
GestionEtatBoutonsParametreGeneraux(true);
end;

procedure TPgProperty.TabSheetParametresHide(Sender: TObject);
begin
if BtnValiderPropriete.Enabled then
  if application.MessageBox(PChar('Voulez-vous valider la modification de vos param�tres g�n�raux ?'),'Validation',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON2) = IDyes then
      BtnValiderPropriete.Click
  else RecupXmlDossier(E.NomDossier);    
end;

procedure TPgProperty.Rinitialiserparamtrecourant1Click(Sender: TObject);
begin
if PageControl1.TabIndex=TabSheetParametres.TabIndex then
  begin
    ReinitialiseParametreDossierDefaut(GrGrid1.Cells[1,grgrid1.Row]);
    if Application.MessageBox(PChar('Etes-vous s�r de vouloir r�cup�rer ce param�tre par d�faut ?'),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON2) = IDNo then
       begin
         RecupXmlDossier(E.NomDossier);
       end;
    AfficherParametresGeneraux;
    GestionEtatBoutonsParametreGeneraux(true);
  end;
end;

procedure TPgProperty.GrGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if(GrGrid1.Cells[2,GrGrid1.row]=TexteRajoutSauvegarde)then
    if(not ValidateInput(key))then key:=#0;
end;


function TPgProperty.ValidateInput(Key: Char):boolean;
begin
 If not(Key in C_Validate) Then
  Begin
    result:=false;
  end;
end;
procedure TPgProperty.cbSautClick(Sender: TObject);
begin
if(cbSaut.State=cbChecked<>E.SautDePageAutomatique)then
  GestionEtatBoutonsParametreGeneraux(true);
E.SautDePageAutomatique:=cbSaut.State=cbChecked;
end;

procedure TPgProperty.EdRepDestChange(Sender: TObject);
begin
GestionEtatBoutons(true);
end;

procedure TPgProperty.BtnMAJRepDestClick(Sender: TObject);
begin
EdRepDest.Text:='/sauvegarde_epicea/'+e.nomDossier;
BtnValider.Click;
end;

procedure TPgProperty.TabMessageResize(Sender: TObject);
begin
FormateTailleColonne(GrDBGrid1,21,[1,3,0,2,10,4]);
end;

procedure TPgProperty.GrDBGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//if (Button=mbLeft)then

end;



procedure TPgProperty.cbAutoriserSauvegardeFermetureClick(Sender: TObject);
begin
E.AutoriserSauvegardeFermeture:=cbAutoriserSauvegardeFermeture.ItemIndex=1;
DMXml.ModifieItemProgramme('AutoriserSauvegardeFermeture',str_bool2str_LGR(E.AutoriserSauvegardeFermeture ,'Oui','Non'));
end;



procedure TPgProperty.EdCheminSauvegardeFermetureChange(Sender: TObject);
begin
e.RepertoireSauvegardeFermture:=EdCheminSauvegardeFermeture.Text;
end;

procedure TPgProperty.EdCheminSauvegardeFermetureAfterDialog(
  Sender: TObject; var Name: String; var Action: Boolean);
begin
if(action)then
    e.RepertoireSauvegardeFermture:=EdCheminSauvegardeFermeture.DialogText;
end;

procedure TPgProperty.EdCheminSauvegardeFermetureCloudAfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
if(action)then
    e.RepertoireSauvegardeFermtureCloud:=EdCheminSauvegardeFermetureCloud.DialogText;
end;

procedure TPgProperty.EdCheminSauvegardeFermetureCloudChange(
  Sender: TObject);
begin
e.RepertoireSauvegardeFermtureCloud:=EdCheminSauvegardeFermetureCloud.Text;
end;

end.

