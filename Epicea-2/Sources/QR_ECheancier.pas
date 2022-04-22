unit QR_ECheancier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls;

type
  TQREcheancier = class(TForm)
    QuickRep1: TQuickRep;
    PageHeaderBand1: TQRBand;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRExpr2: TQRExpr;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  QREcheancier: TQREcheancier;

implementation

{$R *.DFM}
uses DMReport;//E2_DescEmp;

procedure TQREcheancier.FormCreate(Sender: TObject);
begin
QuickRep1.Show;
end;

procedure TQREcheancier.FormDestroy(Sender: TObject);
begin
QREcheancier:=nil;
end;

end.
