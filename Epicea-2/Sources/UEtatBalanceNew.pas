unit UEtatBalanceNew;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls,LibDates,E2_Librairie_Obj,DMDiocEtatBalance,DMEcriture;

type
  TFEtatBalanceNew = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabPeriode: TQRLabel;
    QRLabCptSel: TQRLabel;
    QRBand2: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRShape3: TQRShape;
    QRBand3: TQRBand;
    QRExpr1: TQRExpr;
    QRBand6: TQRBand;
    QRDBText15: TQRDBText;
    QRShape17: TQRShape;
    QRDBText16: TQRDBText;
    QRShape18: TQRShape;
    QRDBText17: TQRDBText;
    QRShape19: TQRShape;
    QRDBText18: TQRDBText;
    QRShape20: TQRShape;
    QRDBText19: TQRDBText;
    QRShape21: TQRShape;
    QRDBText20: TQRDBText;
    QRShape22: TQRShape;
    QRDBText21: TQRDBText;
    QRShape23: TQRShape;
    QRDBText22: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRBand4: TQRBand;
    QRShape2: TQRShape;
    QRLabel31: TQRLabel;
    QRShape10: TQRShape;
    QRLabel30: TQRLabel;
    QRShape4: TQRShape;
    QRLabel29: TQRLabel;
    QRLabRepDeb: TQRLabel;
    QRLabel28: TQRLabel;
    QRShape7: TQRShape;
    QRShape5: TQRShape;
    QRLabel27: TQRLabel;
    QRLabMouv: TQRLabel;
    QRShape8: TQRShape;
    QRLabel26: TQRLabel;
    QRShape6: TQRShape;
    QRLabFin: TQRLabel;
    QRLabel25: TQRLabel;
    QRShape9: TQRShape;
    QRLabel24: TQRLabel;
    procedure visualiser;
    procedure FEtatBalanceNewBeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
    procedure SubDetail1NeedData(Sender: TObject; var MoreData: Boolean);
  private

  public
   TypeBalance:integer;
   DateDebPeriode,DateFinPeriode:TDate;
   CompteDeb,CompteFin:String;
  end;

var
  FEtatBalanceNew: TFEtatBalanceNew;


implementation

{$R *.DFM}

procedure TFEtatBalanceNew.visualiser;
begin
  FEtatBalanceNew.PrintIfEmpty:=true;
  FEtatBalanceNew.preview;
end;
procedure TFEtatBalanceNew.FEtatBalanceNewBeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
if DateDebPeriode=0 then
 begin
   DateDebPeriode:=E.DatExoDebut;
   DateFinPeriode:=E.DatExoFin;
 end;
QRLabPeriode.Caption:='Période du : '+DateInfos(DateDebPeriode).DateStr+' au '+DateInfos(DateFinPeriode).DateStr;
QRLabCptSel.Caption:='Du compte '+CompteDeb+' au compte '+CompteFin;
QRLabRepDeb.Caption:='Solde Report au :'+DateInfos(DateDebPeriode).DateStr;
QRLabMouv.Caption:='Totaux des Mvts du '+DateInfos(DateDebPeriode).DateStr+' au '+DateInfos(DateFinPeriode).DateStr;
QRLabFin.Caption:='Solde Fin au :'+DateInfos(DateFinPeriode).DateStr;
end;

procedure TFEtatBalanceNew.SubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
//MoreData:=true;
end;

end.
