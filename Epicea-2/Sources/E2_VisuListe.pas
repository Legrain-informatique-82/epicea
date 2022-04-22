unit E2_VisuListe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, ExtCtrls, StdCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid,
  GrDBGrid, Menus,E2_Librairie_Obj,LibZoneSaisie,Gr_Librairie_Obj,DMConstantes,
  LibGestionParamXML, jpeg;

type
  TVisuListe = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTitrePetit: TPanel;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
    BtnEnregistrer: TButton;
    PaGrille: TPanel;
    GrDBVisu: TGrDBGrid;
    PopupMenu1: TPopupMenu;
    Rglements1: TMenuItem;
    DtailsPointages1: TMenuItem;
    DtailsF71: TMenuItem;
    Imprimer1: TMenuItem;
    Enregister1: TMenuItem;
    Calculatrice1: TMenuItem;
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure DtailsF71Click(Sender: TObject);
    procedure DtailsPointages1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    DateDebut,DateFin:TDate;
  end;

var
  VisuListe: TVisuListe;

implementation

{$R *.dfm}

procedure TVisuListe.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TVisuListe.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
  PaBtnResize(PaBtn);
//  FormateTailleBoutton([BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;
procedure TVisuListe.BtnEnregistrerClick(Sender: TObject);
begin
ModalResult:=mrok;
end;

procedure TVisuListe.BtnFermerClick(Sender: TObject);
begin
if Self.FormState=[fsmodal] then
  ModalResult:=mrCancel
else
  Self.Close;
end;

procedure TVisuListe.BtnImprimerClick(Sender: TObject);
begin
GrDBVisu.ReportCaption:=VisuListe.PaTitrePetit.Caption;
GrDBVisu.GridPreview;
end;

procedure TVisuListe.DtailsF71Click(Sender: TObject);
begin
// if @BtnDetail.OnClick <> nil then
  BtnDetail.Click;
end;

procedure TVisuListe.DtailsPointages1Click(Sender: TObject);
begin
//
end;

procedure TVisuListe.FormActivate(Sender: TObject);
begin
  GrDBVisu.ParamColor:=true;
  GrDBVisu.Param:=ParamUtil.CouleurDBGrid;
  GrDBVisu.UpDateColor;
end;

procedure TVisuListe.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 BtnDetail.OnClick:=nil;
 PaGrille.OnResize:=nil;
 canclose:=true;
end;

procedure TVisuListe.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TVisuListe.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
VisuListe:=nil;
end;

procedure TVisuListe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[GrDBVisu]);
  if Key = VK_ESCAPE then
   begin
      Key:= 0;
      Self.Close;
   end;
end;

procedure TVisuListe.FormShow(Sender: TObject);
begin
  GrDBVisu.setfocus;
  if @PaGrille.OnResize <> nil then
  PaGrille.OnResize(pagrille);
end;

procedure TVisuListe.Imprimer1Click(Sender: TObject);
begin
BtnImprimer.Click;
end;

procedure TVisuListe.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnEnregistrer,BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;

procedure TVisuListe.PaGrilleResize(Sender: TObject);
begin
//
end;

procedure TVisuListe.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
