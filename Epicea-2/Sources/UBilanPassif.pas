unit UBilanPassif;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TFBilanPassif = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel217: TQRLabel;
    QRDetail: TQRBand;
    QRCol3: TQRLabel;
    QRCol1: TQRLabel;
    QRCol4: TQRLabel;
    QRCol2: TQRLabel;
    QRLibelle: TQRLabel;
    QRShLibelle: TQRShape;
    Procedure InitQRLabel(Valeur:String);
    procedure FBilanActifBeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
    procedure FBilanActifNeedData(Sender: TObject; var MoreData: Boolean);
  private

  public

  end;

var
  FBilanPassif: TFBilanPassif;
  CurrentItem:Integer;

implementation

uses  E2_EditionFin;

{$R *.DFM}
Procedure TFBilanPassif.InitQRLabel(Valeur:String);
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


procedure TFBilanPassif.FBilanActifBeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
CurrentItem:=1;
PrintReport:=EditionFin.GrBilanPassif.RowCount > 1;
//InitQRLabel('0');
end;

procedure TFBilanPassif.FBilanActifNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
   if CurrentItem <  EditionFin.GrBilanPassif.RowCount then
    begin
      if ((UpperCase(copy(EditionFin.GrBilanPassif.Cells[0,CurrentItem],1,5)) = 'TOTAL') or (CurrentItem = EditionFin.GrBilanPassif.RowCount-1)) then
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
      QRLibelle.Caption := EditionFin.GrBilanPassif.Cells[0,CurrentItem];
      if (CurrentItem = 1) then
       begin
        QRCol2.Frame.DrawTop:=true;
        QRCol2.Frame.DrawBottom:=false;
//        QRCol1.Frame.DrawLeft:=false;
//        QRCol1.Frame.DrawRight:=false;
       end;
      if (CurrentItem > 1) then
       begin
        QRCol2.Frame.DrawTop:=false;
        QRCol2.Frame.DrawBottom:=false;
        QRCol1.Frame.DrawLeft:=false;
        QRCol1.Frame.DrawRight:=false;
       end;
      if (CurrentItem = (EditionFin.GrBilanPassif.RowCount-1)) then
       begin
        QRCol2.Frame.DrawTop:=false;
        QRCol2.Frame.DrawBottom:=true;
        QRCol4.Frame.DrawBottom:=True;
        QRCol3.Frame.DrawBottom:=True;
//        QRCol1.Frame.DrawLeft:=false;
//        QRCol1.Frame.DrawRight:=false;
//        QRCol1.Frame.DrawTop:=false;
       end;

//      QRCol1.Visible:=CurrentItem = 1;
      QRCol1.Caption := EditionFin.GrBilanPassif.Cells[1,CurrentItem];
      QRCol2.Caption := EditionFin.GrBilanPassif.Cells[2,CurrentItem];
      QRCol3.Caption := EditionFin.GrBilanPassif.Cells[3,CurrentItem];
      QRCol4.Caption := EditionFin.GrBilanPassif.Cells[4,CurrentItem];
//      QRDBText6.Caption := FormatCurr('# ##0.00 '+ E.DeviseSigle,StrToCurr(EtatVerse.GrEtatVerse.Cells[3,CurrentItem]));
    end;
   Inc(CurrentItem);
   MoreData := CurrentItem <= EditionFin.GrBilanPassif.RowCount;

end;

end.
