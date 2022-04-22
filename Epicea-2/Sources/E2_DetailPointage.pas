unit E2_DetailPointage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, ExtCtrls,LibZoneSaisie,
  StdCtrls, Menus,E2_Librairie_Obj,Gr_Librairie_Obj,LibGestionParamXML, DMConstantes;

type
  TDetailPointage = class(TForm)
    PaGrille: TPanel;
    GrDBDetailPointages: TGrDBGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
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
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure GrDBDetailPointagesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Procedure GereAccesEcran;
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  TiersCourant:String;
  end;

var
  DetailPointage: TDetailPointage;
implementation

uses DMPointages2, E2_DetailEcr, DMEcriture, E2_Main;
{$R *.DFM}

procedure TDetailPointage.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(GrDBDetailPointages,20,[2,2,6,3,3,3]);
end;

procedure TDetailPointage.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TDetailPointage.BtnSupprimerClick(Sender: TObject);
begin
DMPointage2.SuppressionPointage(DMPointage2.QuPointageAffich,true);
PaGrilleResize(PaGrille);
GrDBDetailPointages.SetFocus;
end;

procedure TDetailPointage.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TDetailPointage.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TDetailPointage.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then
 begin
  self.close;
 end;

end;

procedure TDetailPointage.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
end;

procedure TDetailPointage.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TDetailPointage.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TDetailPointage.Visualisation1Click(Sender: TObject);
var
continue:boolean;
begin
if copy(TiersCourant,1,1)<>'+' then continue:=DetailEcritureCompte(TiersCourant,False)
else continue:=DetailEcritureTiers(TiersCourant,False);

case GrDBDetailPointages.SelectedField.Index of
   4..9:begin
           if continue then
             begin
                 case DetailEcr.Tag of
                    1:begin
                      if DMEcritures.QueryEcrTiers.Locate('ID',GrDBDetailPointages.dataSource.dataset.findField('ID_Debit').asinteger,[]) then
                        PieceEcritureTiers;
                      end;
                    2:begin
                      if DMEcritures.QueryEcrCompte.Locate('ID_Piece',GrDBDetailPointages.dataSource.dataset.findField('id_pieceDebit').asinteger,[]) then
                        PieceEcritureCompte;
                      end;
                 end;//fin du DetailEcr.Tag
             end;//fin continue
        end;//fin case  4..9
 11..16:begin
           if continue then
             begin
                 case DetailEcr.Tag of
                    1:begin
                      if DMEcritures.QueryEcrTiers.Locate('ID',GrDBDetailPointages.dataSource.dataset.findField('ID_Credit').asinteger,[]) then
                        PieceEcritureTiers;
                      end;
                    2:begin
                      if DMEcritures.QueryEcrCompte.Locate('ID_Piece',GrDBDetailPointages.dataSource.dataset.findField('id_pieceCredit').asinteger,[]) then
                        PieceEcritureCompte;
                      end;
                 end;//fin DetailEcr.Tag
             end;//fin continue
        end;//fin case  4..9
end;//fin case index
end;

procedure TDetailPointage.GrDBDetailPointagesDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  holdColor: TColor;
begin
case DataCol of
//   0..2: begin
//           holdColor:=GrDBDetailPointages.Canvas.Brush.Color;
//           GrDBDetailPointages.Canvas.Brush.Color :=$00E4CAFF;//$005959FF;//$00808040;
//           GrDBDetailPointages.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//           GrDBDetailPointages.Canvas.Brush.Color := holdColor;
//         end;
//   3: begin
//      if Column.Field.DataSet.FindField('EcrDebitSaisie').AsCurrency = Column.Field.DataSet.FindField('PoMontantPointage').AsCurrency then
//        begin
//           holdColor:=GrDBDetailPointages.Canvas.Brush.Color;
//           GrDBDetailPointages.Canvas.Brush.Color :=$00E4CAFF;//$005959FF;//$00808040;
//           GrDBDetailPointages.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//           GrDBDetailPointages.Canvas.Brush.Color := holdColor;
//        end
//        else
//        begin
//           holdColor:=GrDBDetailPointages.Canvas.Brush.Color;
//           GrDBDetailPointages.Canvas.Brush.Color :=clRed;//$005959FF;//$00808040;
//           GrDBDetailPointages.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//           GrDBDetailPointages.Canvas.Brush.Color := holdColor;
//        end;
//     end;
   5:Begin
        holdColor:=GrDBDetailPointages.Canvas.Brush.Color;
        GrDBDetailPointages.Canvas.Brush.Color :=$00D1D0C9;
        GrDBDetailPointages.DefaultDrawColumnCell(Rect, DataCol, Column, State);
        GrDBDetailPointages.Canvas.Brush.Color := holdColor;
     End;
//
//   5..7:Begin
//          holdColor:=GrDBDetailPointages.Canvas.Brush.Color;
//          GrDBDetailPointages.Canvas.Brush.Color :=$00B6FDB0;//$00808040;
//          GrDBDetailPointages.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//          GrDBDetailPointages.Canvas.Brush.Color := holdColor;
//        End;
//   8: begin
//      if Column.Field.DataSet.FindField('EcrCreditSaisie').AsCurrency = Column.Field.DataSet.FindField('PoMontantPointage').AsCurrency then
//        begin
//           holdColor:=GrDBDetailPointages.Canvas.Brush.Color;
//           GrDBDetailPointages.Canvas.Brush.Color :=$00B6FDB0;//$005959FF;//$00808040;
//           GrDBDetailPointages.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//           GrDBDetailPointages.Canvas.Brush.Color := holdColor;
//        end
//        else
//        begin
//           holdColor:=GrDBDetailPointages.Canvas.Brush.Color;
//           GrDBDetailPointages.Canvas.Brush.Color :=clLime;//$005959FF;//$00808040;
//           GrDBDetailPointages.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//           GrDBDetailPointages.Canvas.Brush.Color := holdColor;
//        end;
//     end;

end;


end;

procedure TDetailPointage.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
GrDBDetailPointages.ParamColor:=true;
GrDBDetailPointages.Param:=ParamUtil.CouleurDBGrid;
GrDBDetailPointages.UpDateColor;

PaGrilleResize(PaGrille);
GereAccesEcran;
end;

procedure TDetailPointage.FormShow(Sender: TObject);
begin
GrDBDetailPointages.SelectedIndex:=0;
end;

procedure TDetailPointage.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TDetailPointage.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
DetailPointage:=Nil;
end;


Procedure TDetailPointage.GereAccesEcran;
begin
EnableWinControl([BtnSupprimer],not E.ExerciceCloture);
EnableItemMenu([Supprimer1],not E.ExerciceCloture);
end;

procedure TDetailPointage.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
