unit UEtatStock;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, ExtDlgs, E2_Stocks_Isa, TeEngine,
  Series, TeeProcs, Chart, DBChart, TeeFunci, QrTee;

type
  TFEtatStock = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel1: TQRLabel;
    lab2: TQRLabel;
    Image1: TQRImage;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
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
    QRShape16: TQRShape;
    QRBand5: TQRBand;
    QRShape17: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
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
  FEtatStock: TFEtatStock;

implementation

{$R *.DFM}
procedure TFEtatStock.visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;


procedure TFEtatStock.imprimer;
begin
  QuickRep1.print;
end;

procedure TFEtatStock.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  if Stocks.Tag = 1 then
    lab2.Caption := 'Ouverture';
  if Stocks.Tag = 2 then
    lab2.Caption := 'Clôture';
end;

end.
