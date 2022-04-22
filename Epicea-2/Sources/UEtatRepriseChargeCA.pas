{***************************************************************
 *
 * Unit Name: UEtatRepriseChargeCA
 *
 * Selection : 7 ds UQReport pour 'reprise chargeCA'
 *             et 'reprise charge à payer et
 *                 produits à recevoir'...
 ****************************************************************}

unit UEtatRepriseChargeCA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, ExtDlgs;

type
  TFEtatRepriseChargeCA = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    QRBand2: TQRBand;
    QRShape2: TQRShape;
    QRSubDetail1: TQRSubDetail;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel3: TQRLabel;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRLabel4: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRLabel5: TQRLabel;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRLabel6: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand3: TQRBand;
    QRShape14: TQRShape;
    QRSysData1: TQRSysData;
    QRLabel7: TQRLabel;
    LabCouP: TQRLabel;
    LabConst: TQRLabel;
    QRShape15: TQRShape;
    QRLabel8: TQRLabel;
    LabDate: TQRLabel;
    QRLabel11: TQRLabel;
    LabTVA: TQRLabel;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    Dlg: TOpenPictureDialog;
    Image1: TQRImage;
    QRSysData2: TQRSysData;
    QRBand4: TQRBand;
    QRShape18: TQRShape;
    QRLabel9: TQRLabel;
    lab10: TQRLabel;
    lab12: TQRLabel;
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
  FEtatRepriseChargeCA: TFEtatRepriseChargeCA;

implementation

uses E2_RepriseChargesCA, DMChargesCA, DMChargesAPayer,
  E2_RepriseChargeAPayer_Isa, UQReport;
                                                     
{$R *.DFM}


procedure TFEtatRepriseChargeCA.visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;

procedure TFEtatRepriseChargeCA.imprimer;
begin
  QuickRep1.print;
end;

procedure TFEtatRepriseChargeCA.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  if FPrint.SelectionEtat = 7 then  //repriseChargesCA
  begin
    if RepriseChargeCA.Caption = 'Reprise des Charges Constatées d''Avance' then
    begin
      LabCouP.caption := 'Charges';
      lab10.caption := 'Charges';
      LabConst.caption := 'Constatées d''avance';
      lab12.caption := 'Constatées d''avance';
//      LabConst.Left := 438;
    end;
    if RepriseChargeCA.Caption = 'Reprise des Produits Constatés d''Avance' then
    begin
      LabCouP.caption := 'Produits';
      lab10.caption := 'Produits';
      LabConst.caption := 'Constatés d''avance';
      lab12.caption := 'Constatés d''avance';
//      LabConst.Left := 438;
    end;
    LabDate.caption:= RepriseChargeCA.Label3.Caption;
    LabTVA.caption:=  RepriseChargeCA.Label4.Caption;
    quickrep1.DataSet := RepriseChargeCA.DBGrid1.DataSource.DataSet;
    QRSubDetail1.DataSet := RepriseChargeCA.DBGrid1.DataSource.DataSet;
    QRDBText1.DataSet := RepriseChargeCA.DBGrid1.DataSource.DataSet;
    QRDBText2.DataSet := RepriseChargeCA.DBGrid1.DataSource.DataSet;
    QRDBText3.DataSet := RepriseChargeCA.DBGrid1.DataSource.DataSet;
    QRDBText4.DataSet := RepriseChargeCA.DBGrid1.DataSource.DataSet;
    QRDBText5.DataSet := RepriseChargeCA.DBGrid1.DataSource.DataSet;
    QRDBText6.DataSet := RepriseChargeCA.DBGrid1.DataSource.DataSet;
  end;
  if FPrint.SelectionEtat = 11 then  //repriseChargeAPayer
  begin
    if RepriseChargeAPayer_Isa.Caption = 'Reprise des Produits à Recevoir' then
    begin
      LabCouP.caption := 'Produits';
      lab10.Caption := 'Produits';
      LabConst.caption := 'A Recevoir';
      lab12.Caption := 'A Recevoir';
//      LabConst.Left := 486;
    end;
    if RepriseChargeAPayer_Isa.Caption = 'Reprise des Charges à Payer' then
    begin
      LabCouP.caption := 'Charges';
      lab10.caption := 'Charges';
      LabConst.caption := 'A Payer';
      lab12.caption := 'A Payer';
//      LabConst.Left := 494;
    end;
    LabDate.caption:= RepriseChargeAPayer_Isa.Label3.Caption;
    LabTVA.caption:=  RepriseChargeAPayer_Isa.Label4.Caption;
    quickrep1.DataSet := RepriseChargeAPayer_Isa.DBGrid1.DataSource.DataSet;
    QRSubDetail1.DataSet := RepriseChargeAPayer_Isa.DBGrid1.DataSource.DataSet;
    QRDBText1.DataSet := RepriseChargeAPayer_Isa.DBGrid1.DataSource.DataSet;
    QRDBText2.DataSet := RepriseChargeAPayer_Isa.DBGrid1.DataSource.DataSet;
    QRDBText3.DataSet := RepriseChargeAPayer_Isa.DBGrid1.DataSource.DataSet;
    QRDBText4.DataSet := RepriseChargeAPayer_Isa.DBGrid1.DataSource.DataSet;
    QRDBText5.DataSet := RepriseChargeAPayer_Isa.DBGrid1.DataSource.DataSet;
    QRDBText6.DataSet := RepriseChargeAPayer_Isa.DBGrid1.DataSource.DataSet;
  end;
end;

end.
