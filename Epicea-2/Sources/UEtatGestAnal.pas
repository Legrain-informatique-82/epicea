unit UEtatGestAnal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls,DMDiocEtatGestionAnalytique;

type
  TFEtatGestAnal = class(TQuickRep)
    QRBand5: TQRBand;
    QRLabel8: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand4: TQRBand;
    QRLabel5: TQRLabel;
    QRLaPeriode: TQRLabel;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRBand1: TQRBand;
    QRLabel12: TQRLabel;
    QRTotal: TQRLabel;
  private

  public

  end;

var
  FEtatGestAnal: TFEtatGestAnal;

implementation

{$R *.DFM}

end.
