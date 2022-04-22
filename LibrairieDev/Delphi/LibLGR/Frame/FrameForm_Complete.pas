unit FrameForm_Complete;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RXCtrls, jpeg, ExtCtrls, Grids, DBGrids, RXDBCtrl,
  ExRxDBGrid, GrDBGrid,LibZoneSaisie;

type
  TFrame3 = class(TFrame)
    PaFond: TPanel;
    PaGrille: TPanel;
    GrDBVisu: TGrDBGrid;
    PaTitrePetit: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBas: TPanel;
    LaFiltre: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    procedure PaBtnResize(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.dfm}

procedure TFrame3.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TFrame3.BtnFermerClick(Sender: TObject);
var
WinControl:TWincontrol;
begin
WinControl:=self.Parent;
while not (WinControl is TForm) do
 WinControl:=WinControl.Parent;
(WinControl as TForm).Close;
end;

procedure TFrame3.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TFrame3.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TFrame3.BtnAnnulerClick(Sender: TObject);
begin
BtnFermerClick(BtnFermer);
end;

end.
