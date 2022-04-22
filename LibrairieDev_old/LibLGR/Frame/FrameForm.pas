unit FrameForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RXCtrls, jpeg, ExtCtrls, Menus, StdCtrls, Grids, DBGrids,
  RXDBCtrl, ExRxDBGrid, GrDBGrid,LibZoneSaisie, ComCtrls;

type
  TFrame1 = class(TFrame)
    PaFond: TPanel;
    PaGrille: TPanel;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
    BtnEnregistrer: TButton;
    PopupMenu1: TPopupMenu;
    Rglements1: TMenuItem;
    DtailsPointages1: TMenuItem;
    DtailsF71: TMenuItem;
    Imprimer1: TMenuItem;
    Enregister1: TMenuItem;
    PaTitrePetit: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    ListView1: TListView;
    procedure BtnFermerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.dfm}

procedure TFrame1.BtnFermerClick(Sender: TObject);
var
WinControl:TWincontrol;
begin
WinControl:=self.Parent;
while not (WinControl is TForm) do
 WinControl:=WinControl.Parent;
(WinControl as TForm).Close;
end;

procedure TFrame1.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnEnregistrer,BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;

end.
