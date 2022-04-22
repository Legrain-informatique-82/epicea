unit QR_emprunts;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls,E2_DescEmp;

type
  TQuickReport1 = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    TitleBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel8: TQRLabel;
    procedure QuickReport1BeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
    procedure QuickReport1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickReport1Preview(Sender: TObject);
  private

  public

  end;

var
  QuickReport1: TQuickReport1;
   CurrentItem : Integer;

implementation

{$R *.DFM}

procedure TQuickReport1.QuickReport1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
   CurrentItem := 0;
   PrintReport:=E2_DescEmp.DescEmp.ListBox2.Items.Count > 0;
end;

procedure TQuickReport1.QuickReport1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
//   if CurrentItem <  E2_DescEmp.DescEmp.ListBox2.Items.Count then
//   QRLabel1.Caption := E2_DescEmp.DescEmp.ListBox2.Items[CurrentItem];
//   Inc(CurrentItem);
//   MoreData := CurrentItem <= E2_DescEmp.DescEmp.ListBox2.Items.Count;

end;

procedure TQuickReport1.QuickReport1Preview(Sender: TObject);
begin
//   while CurrentItem <  E2_DescEmp.DescEmp.ListBox2.Items.Count do begin
//   QRLabel1.Caption := E2_DescEmp.DescEmp.ListBox2.Items[CurrentItem];
//   Inc(CurrentItem);
//	beep;
//   end;

end;

end.
{
var
   CurrentItem : Integer;
   SomeStringList : TStringList;

procedure TForm1.QuickRep1BeforePrint(Sender: TQuickRep;
var 
   PrintReport: Boolean);
begin
   CurrentItem := 0;
   PrintReport := SomeStringList.Count > 0;
end;

procedure TForm1.QuickRep1NeedData(Sender: TObject; var MoreData; Boolean);
begin
   if CurrentItem <  SomeStringList.Count then
   QRLabel1.Caption := SomeStringList[CurrentItem];
   Inc(CurrentItem);
   MoreData := CurrentItem <= SomeStringList.Count;

end;

}
