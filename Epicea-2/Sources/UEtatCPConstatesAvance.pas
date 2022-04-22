{***************************************************************
 *
 * Unit Name: UEtatCPConstatesAvance
 * Purpose  :
 * Author   :  Selection : 6 ds UQReport
 * History  :
 *
 ****************************************************************}

unit UEtatCPConstatesAvance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, ExtDlgs;

type
  TFEtatCPConstatesAvance = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    LabCompte: TQRLabel;
    LabLib: TQRLabel;
    QRShape3: TQRShape;
    QRLabel4: TQRLabel;
    LabDate: TQRLabel;
    QRBand3: TQRBand;
    QRLabel10: TQRLabel;
    QRShape11: TQRShape;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRSubDetail1: TQRSubDetail;
    QRShape10: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRShape4: TQRShape;
    QRBand2: TQRBand;
    QRShape5: TQRShape;
    QRSysData1: TQRSysData;
    Image1: TQRImage;
    Dlg: TOpenPictureDialog;
    QRSysData2: TQRSysData;
    QRBand4: TQRBand;
    QRShape6: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    procedure visualiser;
    procedure imprimer;
    procedure QuickRep1BeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FEtatCPConstatesAvance: TFEtatCPConstatesAvance;

implementation

uses E2_ChargesCA_Isa,DMChargesCA;

{$R *.DFM}
procedure TFEtatCPConstatesAvance.visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;

procedure TFEtatCPConstatesAvance.imprimer;
begin
  QuickRep1.print;
end;

procedure TFEtatCPConstatesAvance.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  LabCompte.caption := ChargeCA_Isa.EdCompte.Text;
  LabLib.caption := ChargeCA_Isa.EdLibelle.Text;
  LabDate.caption := ChargeCA_Isa.EdDate.Text;
end;

end.
