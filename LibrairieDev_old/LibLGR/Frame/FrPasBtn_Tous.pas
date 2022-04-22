unit FrPasBtn_Tous;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls,LibZoneSaisie;

Type
  TFrame2 = class(TFrame)
    PaBas: TPanel;
    LaFiltre: TLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Panel1: TPanel;
    Label1: TLabel;
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

procedure TFrame2.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TFrame2.BtnFermerClick(Sender: TObject);
var
WinControl:TWincontrol;
begin
WinControl:=self.Parent;
while not (WinControl is TForm) do
 WinControl:=WinControl.Parent;
(WinControl as TForm).Close;
end;

procedure TFrame2.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TFrame2.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TFrame2.BtnAnnulerClick(Sender: TObject);
begin
BtnFermerClick(BtnFermer);
end;

end.
