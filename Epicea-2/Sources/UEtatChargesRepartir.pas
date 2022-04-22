{***************************************************************
 *
 * Unit Name: UEtatChargesRepartir
 * Purpose  :
 * Author   :    Selection : 3 ds UQReport
 * History  :
 *
 ****************************************************************}

unit UEtatChargesRepartir;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls,E2_ChargeRepartir_Isa, LibSQL,
  Gr_MiseAJourBalance,DMChargesRepartir,
  ExtDlgs;

type
  TFEtatChargesRepartir = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRShape2: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape9: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRBand2: TQRBand;
    QRSubDetail1: TQRSubDetail;
    QRBand3: TQRBand;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRSysData1: TQRSysData;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    Image1: TQRImage;
    Dlg: TOpenPictureDialog;
    QRSysData2: TQRSysData;
    QRBand4: TQRBand;
    QRShape17: TQRShape;
    QRLabel11: TQRLabel;
    lab12: TQRLabel;
    procedure Visualiser;
    procedure Imprimer;
    procedure QuickRep1BeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FEtatChargesRepartir: TFEtatChargesRepartir;

implementation

{$R *.DFM}
procedure TFEtatChargesRepartir.Visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;

procedure TFEtatChargesRepartir.Imprimer;
begin
  QuickRep1.print;
end;


procedure TFEtatChargesRepartir.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
   lab12.Caption := ChargeARepartir_Isa.EdDate.Text;;
end;

end.
