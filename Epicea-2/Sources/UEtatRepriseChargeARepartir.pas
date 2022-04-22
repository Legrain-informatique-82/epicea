{***************************************************************
 *
 * Unit Name: UEtatRepriseChargeARepartir
 * Purpose  :
 * Author   :  Selection : 5 ds UQReport
 * History  :
 *
 ****************************************************************}

unit UEtatRepriseChargeARepartir;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, ExtDlgs;

type
  TFEtatRepriseChargeARepartir = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRSubDetail1: TQRSubDetail;
    QRBand2: TQRBand;
    QRShape8: TQRShape;
    QRSysData1: TQRSysData;
    QRShape9: TQRShape;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRBand3: TQRBand;
    QRShape10: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape7: TQRShape;
    QRDBText8: TQRDBText;
    QRShape20: TQRShape;
    Dlg: TOpenPictureDialog;
    Image1: TQRImage;
    QRSysData2: TQRSysData;
    procedure visualiser;
    procedure imprimer;
      
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FEtatRepriseChargeARepartir: TFEtatRepriseChargeARepartir;

implementation

{$R *.DFM}
procedure TFEtatRepriseChargeARepartir.visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;


procedure TFEtatRepriseChargeARepartir.imprimer;
begin
  QuickRep1.print;
end;


end.
