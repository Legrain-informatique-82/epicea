{***************************************************************
 *
 * Unit Name: E2_Logo
 * Purpose  :
 * Author   : JS
 * History  :
 *
 ****************************************************************}

// Affichage du logo au démarage
// Tout est commenté
unit E2_Logo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RXCtrls, RxGIF, Gauges;

type
  TLogo = class(TForm)
    imFond: TImage;
    TimFermeture: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    RxLabel1: TRxLabel;
    BtnAnnuler: TButton;
    BtnSortir: TButton;
    Gauge1: TGauge;
    procedure FormShow(Sender: TObject);
    procedure TimFermetureTimer(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnSortirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Logo: TLogo;
  Haut,Gauche:integer;
implementation

{$R *.DFM}

procedure TLogo.FormShow(Sender: TObject);
begin
if self.tag=1 then
begin
// PaAuRevoir.Height:=0;
 BtnSortir.SetFocus;
 Haut:=0;
 Gauche:=0;

end;
end;

procedure TLogo.TimFermetureTimer(Sender: TObject);
var
Hand : integer;
    region1, region2 : hRgn;
    rect : TRect;
begin
//PaAuRevoir.Height:=PaAuRevoir.Height+30;
//inc(Fin,);
//if PaAuRevoir.Height >=300 then
  Hand:=self.Handle;
  getwindowrect(Hand, rect);
  region2 := createRectRgn(0,0, rect.Right - rect.Left, rect.Bottom - rect.top);
  region1 := createRectRgn(0,0, 350, (Haut+1)*3);
  combineRgn(region2, region2, region1, RGN_DIFF);
  setWindowRgn(Hand, region2, true);
inc(Gauche);
inc(Haut);
if Haut > 100 then
  application.Terminate;
end;

procedure TLogo.BtnAnnulerClick(Sender: TObject);
begin
  TimFermeture.Enabled:=false;
  Haut:=0;
  Gauche:=0;
  BtnAnnuler.Visible:=false;
  Self.close;
end;

procedure TLogo.BtnSortirClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLogo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_RETURN then
 begin
  BtnSortirClick(BtnSortir);
 end;
if key = VK_ESCAPE then
 begin
  case self.tag of
     0:Begin
      key:=0;
      Application.Terminate;
      End;
     1:Begin
       BtnAnnulerClick(BtnAnnuler);
       key:=0;
      End;
  end;
 end;

end;

procedure TLogo.FormDestroy(Sender: TObject);
begin
Logo := nil;
end;

end.
