{***************************************************************
 *
 * Unit Name: UEtatChargeAPayer
 * Purpose  :
 * Author   :   Selection : 4 ds UQReport
 * History  :
 *
 ****************************************************************}

unit UEtatChargeAPayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, E2_ChargesAPayer_Isa, E2_DepensesEntreprise,
  DMChargesAPayer, ExtDlgs;

type
  TFEtatChargeAPayer = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRSubDetail1: TQRSubDetail;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    LabTitre: TQRLabel;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRLabel8: TQRLabel;
    NoCpt: TQRLabel;
    QRLabel9: TQRLabel;
    LabDate: TQRLabel;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    Lab4: TQRLabel;
    Dlg: TOpenPictureDialog;
    Image1: TQRImage;
    QRSysData2: TQRSysData;
    QRBand4: TQRBand;
    QRShape18: TQRShape;
    lab1: TQRLabel;
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
  FEtatChargeAPayer: TFEtatChargeAPayer;

implementation

uses UQReport, DMDepenses;

{$R *.DFM}
procedure TFEtatChargeAPayer.visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;


procedure TFEtatChargeAPayer.imprimer;
begin
  QuickRep1.print;
end;

procedure TFEtatChargeAPayer.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  if FPrint.SelectionEtat = 4 then
  begin
    NoCpt.caption := ChargesAPayer_Isa.NumCpt.text;
    //LabDate.caption := (voir sur e2_chargesAPayer_isa ce qui est prévu...) ;
    Lab4.Caption := ChargesAPayer_Isa.EdLibelle.Text;
    QRShape17.Width := (QRShape17.Width) + (Lab4.Width);
    if ChargesAPayer_Isa.SBCAP.Down = true then
    begin
      LabTitre.caption := 'Ouverture : Charges à Payer';
      lab1.Caption := 'Charges à Payer' ;
      self.Caption := 'Etat - Charges à Payer';
    end;
    if ChargesAPayer_Isa.SBPAP.Down = true then
    begin
      LabTitre.Caption := 'Ouverture : Produits à Recevoir';
      lab1.Caption := 'Produits à Recevoir';
      self.Caption := 'Etat - Produits à Recevoir';
    end; // pour les champs db : DMChargeAPayer.TaChAPayer
    quickrep1.DataSet := ChargesAPayer_Isa.DBGridChAPayer.DataSource.DataSet;
    QRSubDetail1.DataSet := ChargesAPayer_Isa.DBGridChAPayer.DataSource.DataSet;
    QRDBText1.DataSet := ChargesAPayer_Isa.DBGridChAPayer.DataSource.DataSet;
    QRDBText2.DataSet := ChargesAPayer_Isa.DBGridChAPayer.DataSource.DataSet;
    QRDBText3.DataSet := ChargesAPayer_Isa.DBGridChAPayer.DataSource.DataSet;
    QRDBText4.DataSet := ChargesAPayer_Isa.DBGridChAPayer.DataSource.DataSet;
    QRDBText5.DataSet := ChargesAPayer_Isa.DBGridChAPayer.DataSource.DataSet;
    QRDBText6.DataSet := ChargesAPayer_Isa.DBGridChAPayer.DataSource.DataSet; 
  end;
  if FPrint.SelectionEtat = 9 then
  begin
    LabDate.caption := DepensesEntreprise.Label4.caption;
    NoCpt.Caption := DepensesEntreprise.NumCpt.Text;
    LabTitre.caption := DepensesEntreprise.Caption;
    Lab4.Caption := DepensesEntreprise.Label2.Caption;
    QRShape17.Width := (QRShape17.Width) + (Lab4.Width);
    if LabTitre.Caption = 'Dépenses de l''Entreprise' then
    begin
      lab1.Caption := 'Dépenses de l''Entreprise';
      self.Caption := 'Etat - Dépenses de l''Entreprise';
      LabTitre.Left := 453;
      LabTitre.Width := 234;
    end;
    if LabTitre.Caption = 'Dépenses du Privé' then
    begin
      lab1.Caption := 'Dépenses du Privé';
      self.Caption := 'Etat - Dépenses du Privé';
      LabTitre.Left := 485;
      LabTitre.Width := 176;
    end;
    // pour les champs db :DMDepenseEnt.TaDepense...
    quickrep1.DataSet := DepensesEntreprise.DBGridDepense.DataSource.DataSet;
    QRSubDetail1.DataSet := DepensesEntreprise.DBGridDepense.DataSource.DataSet;
    QRDBText1.DataSet := DepensesEntreprise.DBGridDepense.DataSource.DataSet;
    QRDBText2.DataSet := DepensesEntreprise.DBGridDepense.DataSource.DataSet;
    QRDBText3.DataSet := DepensesEntreprise.DBGridDepense.DataSource.DataSet;
    QRDBText4.DataSet := DepensesEntreprise.DBGridDepense.DataSource.DataSet;
    QRDBText5.DataSet := DepensesEntreprise.DBGridDepense.DataSource.DataSet;
    QRDBText6.DataSet := DepensesEntreprise.DBGridDepense.DataSource.DataSet;

  end;
end;


end.
