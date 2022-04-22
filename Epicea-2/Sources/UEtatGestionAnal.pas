unit UEtatGestionAnal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TFEtatGestionAnal = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    procedure FEtatGestionAnalNeedData(Sender: TObject;
      var MoreData: Boolean);
    procedure FEtatGestionAnalBeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  FEtatGestionAnal: TFEtatGestionAnal;
  CurrentItem:Integer;

implementation

uses E2_GestionAnalytique;

{$R *.DFM}

procedure TFEtatGestionAnal.FEtatGestionAnalNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
   if CurrentItem <  GestionAnalytique.GrGrandLivre.RowCount then
    begin
      if ((UpperCase(copy(GestionAnalytique.GrGrandLivre.Cells[0,CurrentItem],1,5)) = 'TOTAL') or (CurrentItem = GestionAnalytique.GrGrandLivre.RowCount-1)) then
       begin
//        QRLabel1.Color:=clYellow;
//        QRLabel2.Color:=clYellow;
        QRLabel2.Alignment:=taRightJustify;
//        QRLabel3.Color:=clYellow;
        QRLabel3.Alignment:=taRightJustify;
        QRBand3.Color:=cl3DLight;
       end
       else
       begin
//        QRLabel1.Color:=clWhite;
//        QRLabel2.Color:=clWhite;
        QRLabel2.Alignment:=taLeftJustify;
//        QRLabel3.Color:=clWhite;
        QRLabel3.Alignment:=taLeftJustify;
        QRBand3.Color:=clWhite;
       end;
      QRLabel1.Caption := GestionAnalytique.GrGrandLivre.Cells[0,CurrentItem];
      QRLabel2.Caption := GestionAnalytique.GrGrandLivre.Cells[1,CurrentItem];
      QRLabel3.Caption := GestionAnalytique.GrGrandLivre.Cells[2,CurrentItem];
//      QRDBText6.Caption := FormatCurr('# ##0.00 '+ E.DeviseSigle,StrToCurr(EtatVerse.GrEtatVerse.Cells[3,CurrentItem]));
    end;
   Inc(CurrentItem);
   MoreData := CurrentItem <= GestionAnalytique.GrGrandLivre.RowCount;

end;

procedure TFEtatGestionAnal.FEtatGestionAnalBeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
CurrentItem:=1;
PrintReport:=GestionAnalytique.GrGrandLivre.RowCount > 1;

end;

end.
