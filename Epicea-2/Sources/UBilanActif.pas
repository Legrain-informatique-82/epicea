unit UBilanActif;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TFBilanActif = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel217: TQRLabel;
    QRDetail: TQRBand;
    QRCol2: TQRLabel;
    QRCol1: TQRLabel;
    QRCol4: TQRLabel;
    QRCol3: TQRLabel;
    QRCol5: TQRLabel;
    QRCol6: TQRLabel;
    QRLibelle: TQRLabel;
    Procedure InitQRLabel(Valeur:String);
    procedure FBilanActifBeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
    procedure FBilanActifNeedData(Sender: TObject; var MoreData: Boolean);
  private

  public

  end;

var
  FBilanActif: TFBilanActif;
  CurrentItem:Integer;

implementation

uses  E2_EditionFin;

{$R *.DFM}
Procedure TFBilanActif.InitQRLabel(Valeur:String);
var
i,j:integer;
NomQRLabel:String;
Begin
 for i:=65 to 90 do
  begin
   for j:=65 to 90 do
    begin
     NomQRLabel:=chr(i)+chr(j) + '_MOA';
     if FindComponent(NomQRLabel) <> nil then
        (FindComponent(NomQRLabel) as TQRLabel).Caption:=Valeur;
    end;
  end;
End;


procedure TFBilanActif.FBilanActifBeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
CurrentItem:=1;
PrintReport:=EditionFin.GrBilanActif.RowCount > 1;
//InitQRLabel('0');
end;

procedure TFBilanActif.FBilanActifNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
   if CurrentItem <  EditionFin.GrBilanActif.RowCount then
    begin
      if ((UpperCase(copy(EditionFin.GrBilanActif.Cells[0,CurrentItem],1,5)) = 'TOTAL') or (CurrentItem = EditionFin.GrBilanActif.RowCount-1)) then
       begin
//        QRLabel1.Color:=clYellow;
//        QRLabel2.Color:=clYellow;
//        QRLabel2.Alignment:=taRightJustify;
//        QRLabel3.Color:=clYellow;
//        QRLabel3.Alignment:=taRightJustify;
//        QRBand3.Color:=clYellow;
       end
       else
       begin
//        QRLabel1.Color:=clWhite;
//        QRLabel2.Color:=clWhite;
//        QRLabel2.Alignment:=taLeftJustify;
//        QRLabel3.Color:=clWhite;
//        QRLabel3.Alignment:=taLeftJustify;
//        QRBand3.Color:=clWhite;
       end;
      QRLibelle.Caption := EditionFin.GrBilanActif.Cells[0,CurrentItem];
      QRCol1.Caption := EditionFin.GrBilanActif.Cells[1,CurrentItem];
      QRCol2.Caption := EditionFin.GrBilanActif.Cells[2,CurrentItem];
      QRCol3.Caption := EditionFin.GrBilanActif.Cells[3,CurrentItem];
      QRCol4.Caption := EditionFin.GrBilanActif.Cells[4,CurrentItem];
      QRCol5.Caption := EditionFin.GrBilanActif.Cells[5,CurrentItem];
      QRCol6.Caption := EditionFin.GrBilanActif.Cells[6,CurrentItem];
//      QRDBText6.Caption := FormatCurr('# ##0.00 '+ E.DeviseSigle,StrToCurr(EtatVerse.GrEtatVerse.Cells[3,CurrentItem]));
    end;
   Inc(CurrentItem);
   MoreData := CurrentItem <= EditionFin.GrBilanActif.RowCount;

end;

end.
