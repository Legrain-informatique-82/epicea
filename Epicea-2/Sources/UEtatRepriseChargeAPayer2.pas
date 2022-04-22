{***************************************************************
 *
 * Unit Name: UEtatRepriseChargeAPayer2
 *
 * Selection : 8 ds UQReport
 *
 *
 ****************************************************************}

unit UEtatRepriseChargeAPayer2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, E2_RepriseChargeAPayer2_Isa, ExtDlgs;

type
  TFEtatRepriseChargeAPayer2 = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    LabFeuille: TQRLabel;
    QRBand4: TQRBand;
    QRShape13: TQRShape;
    QRSysData1: TQRSysData;
    Image1: TQRImage;
    QRSysData2: TQRSysData;
    QRSubDetail1: TQRSubDetail;
    QRShape18: TQRShape;
    DBCompte: TQRDBText;
    DBLib: TQRDBText;
    DBDebit: TQRDBText;
    DBCredit: TQRDBText;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape14: TQRShape;
    QRGroup1: TQRGroup;
    QRShape6: TQRShape;
    QRLabel6: TQRLabel;
    QRShape8: TQRShape;
    QRLabel7: TQRLabel;
    QRShape9: TQRShape;
    QRLabel8: TQRLabel;
    QRShape10: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel10: TQRLabel;
    G1Date: TQRDBText;
    QRShape3: TQRShape;
    QRLabel11: TQRLabel;
    G1Ref: TQRDBText;
    G1Lib: TQRDBText;
    QRBand2: TQRBand;
    QRShape4: TQRShape;
    QRLabel3: TQRLabel;
    labfeuilpage: TQRLabel;
    procedure QuickRep1BeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
    procedure Visualiser;
    procedure Imprimer;
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FEtatRepriseChargeAPayer2: TFEtatRepriseChargeAPayer2;
  premier: boolean;
implementation

uses  DMDepenses, DMPiece, DMEcriture, UQReport;

{$R *.DFM}


procedure TFEtatRepriseChargeAPayer2.QuickRep1BeforePrint(
  Sender: TQuickRep; var PrintReport: Boolean);
begin
  quickrep1.DataSet := RepriseChargeAPayer2_Isa.DBGrid1.DataSource.DataSet;
  G1Ref.DataSet := RepriseChargeAPayer2_Isa.DBGrid1.DataSource.DataSet;
  G1Lib.DataSet := RepriseChargeAPayer2_Isa.DBGrid1.DataSource.DataSet;
  G1Date.DataSet := RepriseChargeAPayer2_Isa.DBGrid1.DataSource.DataSet;
  if  (RepriseChargeAPayer2_Isa.SBCCA.Visible = true)and(RepriseChargeAPayer2_Isa.SBPCA.Visible = true)then
  begin
    if RepriseChargeAPayer2_Isa.SBCCA.Down = True then
    begin
      labFeuille.Caption := RepriseChargeAPayer2_Isa.SBCCA.Caption;
      labfeuilpage.Caption := RepriseChargeAPayer2_Isa.SBCCA.Caption;
    end
    else
    begin
      labFeuille.Caption := RepriseChargeAPayer2_Isa.SBPCA.Caption;
      labfeuilpage.Caption := RepriseChargeAPayer2_Isa.SBPCA.Caption;
    end;
  end
  else
  begin
    labFeuille.Caption := RepriseChargeAPayer2_Isa.Caption;
    labfeuilpage.Caption := RepriseChargeAPayer2_Isa.Caption;
  end;
  premier := true;
end;

procedure TFEtatRepriseChargeAPayer2.visualiser;
begin
  QuickRep1.PrintIfEmpty := true;
  QuickRep1.preview;
end;

procedure TFEtatRepriseChargeAPayer2.imprimer;
begin
  QuickRep1.print;
end;


procedure TFEtatRepriseChargeAPayer2.QRGroup1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if premier = true then
    printband := false
  else
    printband := true;
  premier := false;
end;

end.
