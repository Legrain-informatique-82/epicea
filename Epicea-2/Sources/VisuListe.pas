unit VisuListe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, StdCtrls,
  RXCtrls, jpeg, ExtCtrls;

type
  TForm1 = class(TForm)
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
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TVisuListe.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TVisuListe.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
  FormateTailleBoutton([BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;
end.
