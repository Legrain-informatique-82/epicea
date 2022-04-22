unit UEtatVerse;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls,DMDiocEtatVersements,E2_Librairie_Obj;

type
  TFEtatVers = class(TQuickRep)
    QRBand5: TQRBand;
    QRLabel8: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRLabel5: TQRLabel;
    QRLaPeriode: TQRLabel;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRDBText1: TQRLabel;
    QRDBText2: TQRLabel;
    QRDBText6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRBand1: TQRBand;
    QRLabel12: TQRLabel;
    QRTotal: TQRLabel;
    procedure FEtatVersNeedData(Sender: TObject; var MoreData: Boolean);
    procedure FEtatVersBeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  FEtatVers: TFEtatVers;
  CurrentItem:Integer;

implementation

uses E2_EtatVerse;

{$R *.DFM}

procedure TFEtatVers.FEtatVersBeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
CurrentItem:=1;
PrintReport:=EtatVerse.GrEtatVerse.RowCount > 1;
end;

procedure TFEtatVers.FEtatVersNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
   if CurrentItem <  EtatVerse.GrEtatVerse.RowCount then
    begin
      QRDBText1.Caption := EtatVerse.GrEtatVerse.Cells[1,CurrentItem];
      QRDBText2.Caption := EtatVerse.GrEtatVerse.Cells[2,CurrentItem];
      QRDBText6.Caption := EtatVerse.GrEtatVerse.Cells[3,CurrentItem];
//      QRDBText6.Caption := FormatCurr('# ##0.00 '+ E.DeviseSigle,StrToCurr(EtatVerse.GrEtatVerse.Cells[3,CurrentItem]));
    end;
   Inc(CurrentItem);
   MoreData := CurrentItem <= EtatVerse.GrEtatVerse.RowCount;
end;


end.
