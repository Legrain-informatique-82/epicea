unit IBRecherche;   //

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IBDataBase,
  db,
  IBQuery,
  IBCustomDataSet,
  AD_Librairie,
  LibZoneSaisie,
  AD_PresentationWeb_,
  FM_INIT_COLOR,
  DMIBRecherche,
  Dialogs, OleCtrls, SHDocVw, C_WebBroser, C_PaTools, StdCtrls, RXCtrls,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, ExtCtrls, Menus, ComCtrls;


Const

 C_HTMLIBRechHTML = 'IBRech.html';
 C_FormCaption = 'Modèle : ';

type

  TIBRech = class(TT_INIT_COLOR)
    PaPTitre: TPanel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnValider: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Imprimerstockcourant1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    PaBas: TPanel;
    LaNomChampRech: TLabel;
    LaValRech: TLabel;
    CBChampRech: TComboBox;
    edRecherche: TEdit;
    TCRech: TTabControl;
    PaGrille: TPanel;
    DBRech: TGrDBGrid;
    procedure FormShow(Sender: TObject);
    procedure CPaTools1SBHtmlClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Insrer1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure TCRechChange(Sender: TObject);
    procedure AffecteCBChampRech;
    procedure CBChampRechSelect(Sender: TObject);
    procedure edRechercheKeyPress(Sender: TObject; var Key: Char);
    procedure TCRechChanging(Sender: TObject; var AllowChange: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    FIBRechLgrForm:TIBRechLgr;
  end;

TParamIBRech = class(TParamForm)
  private

  protected

  public
    FIBRech:TIBRech;
    FDMIBRech:TDMIBRech;
    FIBRechLgr:TIBRechLgr;
    Fsql:TStringList;

    HTMLIBRechHTML:String;
    IBDB:TIBDataBase;
    constructor Create(AOwner :TComponent);
    destructor Destroy; override;
//    Function IBRechAffiche(ParamIB:TParamIBRech):Boolean;
    Function IBRechAffiche:Boolean;
  published

end;

//var
//  IBRech: TIBRech;
//  ParamIBRech:TParamIBRech;


implementation

{$R *.dfm}

constructor TParamIBRech.Create(AOwner :TComponent);
Begin
 try
  inherited create(Aowner);
  FormCaption :=C_FormCaption;
  HTMLIBRechHTML := C_HTMLIBRechHTML;
  if FIBRech = nil then FIBRech:=TIBRech.Create(Application.MainForm);
  if FDMIBRech = nil then FDMIBRech:=TDMIBRech.Create(Application.MainForm);
  if FIBRechLgr = nil then FIBRechLgr:=TIBRechLgr.Create(Application.MainForm);
  FIBRechLgr.FDbGrid :=FIBRech.DBRech;
  Fsql:=TStringList.Create;
  Fsql.Clear;
 except
  MessageDlg('Erreur lors de la création de ParamIBRech', mtError, [mbOK], 0);
 end;
end;

destructor TParamIBRech.Destroy;
Begin
  try
    Fsql.Free;
    FIBRech.FIBRechLgrForm := nil;

    if FIBRech <> nil then FreeAndNil(FIBRech);
    if FDMIBRech <> nil then FreeAndNil(FDMIBRech);
    if FIBRechLgr <> nil then FreeAndNil(FIBRechLgr);
    inherited Destroy;
  except
    MessageDlg('Erreur lors de la destruction de ParamIBRech', mtError, [mbOK], 0);
  end;
End;

Function TParamIBRech.IBRechAffiche:Boolean;
Begin
try
  FIBRech.TCRech.Tabs.Clear;
  FIBRech.TCRech.Tabs.AddStrings(FIBRechLgr.FListeRech);
  FIBRech.FIBRechLgrForm :=FIBRechLgr;
  FormShowModal := True;
  FormAffiche(result,FIBRech);
except
 MessageDlg('Erreur sur : ParamIBRech.IBRechAffiche', mtError, [mbOK], 0);
end;
End;


procedure TIBRech.FormShow(Sender: TObject);
begin
inherited;
AffecteCBChampRech;
CBChampRechSelect(CBChampRech);
TCRechChange(TCRech);
//CPaTools1.SBHtml.Down := false;
//CPaTools1.SBHtml.GroupIndex := 0;
//C_WebBrowser1.WebBrowser1.Navigate(PAramUtil.RepertoireApplication +'Annexes\ADTypeCivilite.html');
end;

procedure TIBRech.CPaTools1SBHtmlClick(Sender: TObject);
begin
//  CPaTools1.SBHtmlClick(Sender);
  AD_PresentationWEBAffiche(PAramUtil.RepertoireAideWeb + 'ADTypeCivilite.html');
//  C_WebBrowser1.WebBrowser1.Navigate(PAramUtil.RepertoireApplication +'Annexes\ADTypeCivilite.html');

end;

procedure TIBRech.FormCreate(Sender: TObject);
begin
  inherited;
  TypeInitForm := ValTypeInitForm;
end;

procedure TIBRech.BtnAnnulerClick(Sender: TObject);
var
ch:Word;
begin
  inherited;
  ch:=VK_ESCAPE;
  self.KeyDown(ch,[]);
end;

procedure TIBRech.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE then
   modalResult:= mrCancel;

if activeControl = edRecherche then
 begin
  if key = VK_DoWN then
   begin
    DBRech.DataSource.DataSet.Next;
    key:=0;
   end;
  if key = VK_UP then
   begin
    DBRech.DataSource.DataSet.Prior;
    key:=0;
   end;


  if key = VK_NEXT then
   begin
    DBRech.DataSource.DataSet.MoveBy(10);
    key:=0;
   end;
  if key = VK_PRIOR then
   begin
    DBRech.DataSource.DataSet.MoveBy(-10);
    key:=0;
   end;
 end;
 if ((ssCtrl in Shift) and (key=VK_RETURN))then
  BtnValider.Click;
end;

procedure TIBRech.BtnFermerClick(Sender: TObject);
begin
  inherited;
  self.ModalResult := mrCancel;
end;

procedure TIBRech.BtnValiderClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
//MsgNonFini;
end;

procedure TIBRech.BtnModifierClick(Sender: TObject);
begin
  inherited;
MsgNonFini;
end;

procedure TIBRech.BtnInsererClick(Sender: TObject);
begin
  inherited;
MsgNonFini;
end;


procedure TIBRech.BtnSupprimerClick(Sender: TObject);
begin
  inherited;
MsgNonFini;
end;

procedure TIBRech.BtnImprimerClick(Sender: TObject);
begin
  inherited;
MsgNonFini;
end;

procedure TIBRech.Enregister1Click(Sender: TObject);
begin
  inherited;
  BtnClick(BtnValider);
end;

procedure TIBRech.Modifier1Click(Sender: TObject);
begin
  inherited;
  BtnClick(BtnModifier);
end;

procedure TIBRech.Insrer1Click(Sender: TObject);
begin
  inherited;
  BtnClick(BtnInserer);
end;

procedure TIBRech.Supprimer1Click(Sender: TObject);
begin
  inherited;
  BtnClick(BtnSupprimer);
end;

procedure TIBRech.Imprimer1Click(Sender: TObject);
begin
  inherited;
  BtnClick(BtnImprimer);
end;

procedure TIBRech.TCRechChange(Sender: TObject);
var
i,LargeurCol:Integer;
begin
 inherited;
 FIBRechLgrForm.ActiverRech(TCRech.Tabs[TCRech.TabIndex],BtnModifier);
 LargeurCol:=DBRech.Width div DBRech.ColCount;
 for i:=0 to DBRech.ColCount - 1 do
  begin
   DBRech.ColWidths[i]:=LargeurCol;
  end; 
 AffecteCBChampRech;
// CBChampRech.Items.Clear;
// CBChampRech.Items:=FIBRechLgrForm.FListeChamp;
end;

procedure TIBRech.AffecteCBChampRech;
var
i:Integer;
Begin
 CBChampRech.Items.Clear;
 for i:=0 to DBRech.ColCount - 2 do
  begin
   CBChampRech.Items.Add(DBRech.Columns.Items[i].Title.Caption);
  end;
 if CBChampRech.Items.Count > 0 then
  CBChampRech.ItemIndex := 0;
End;


procedure TIBRech.CBChampRechSelect(Sender: TObject);
begin
  inherited;
  edRecherche.Text := '';
  edRecherche.SetFocus;
end;

procedure TIBRech.edRechercheKeyPress(Sender: TObject; var Key: Char);
var
i:Integer;
NomChamp:string;
begin
  inherited;
  if key = #13 then
   begin
    NomChamp:=DBRech.Columns.Items[CBChampRech.ItemIndex].FieldName;
//    DBRech.DataSource.DataSet.Locate(NomChamp,edRecherche.Text,[])
    if not TIBCustomDataSet(DBRech.DataSource.DataSet).LocateNext(NomChamp,edRecherche.Text,[loCaseInsensitive,loPartialKey]) then
      begin
        DBRech.DataSource.DataSet.First;
        TIBCustomDataSet(DBRech.DataSource.DataSet).Locate(NomChamp,edRecherche.Text,[loCaseInsensitive,loPartialKey]);
      end;
//    DBRech.DataSource.DataSet.FindNext
//    MessageDlg('enter', mtInformation, [mbOK], 0);
   end;
end;

procedure TIBRech.TCRechChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  TIBQuery(FIBRechLgrForm.FListeRech.Objects[TCRech.TabIndex]).Close;
  TIBQuery(FIBRechLgrForm.FListeRech.Objects[TCRech.TabIndex]).Open;
end;

end.
