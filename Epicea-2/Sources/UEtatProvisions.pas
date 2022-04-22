unit UEtatProvisions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, ExtDlgs, quickrpt, ExtCtrls, DMProvision, E2_Provisions_Isa;

type
  TFEtatProvisions = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    Image1: TQRImage;
    Dlg: TOpenPictureDialog;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel8: TQRLabel;
    NoCpt: TQRLabel;
    Lab4: TQRLabel;
    QRLabel9: TQRLabel;
    LabDate: TQRLabel;
    QRShape17: TQRShape;
    QRBand2: TQRBand;
    QRShape1: TQRShape;
    QRShape4: TQRShape;
    QRSubDetail1: TQRSubDetail;
    QRShape5: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRBand3: TQRBand;
    QRShape14: TQRShape;
    QRSysData1: TQRSysData;
    LabTitre: TQRLabel;
    QRSysData2: TQRSysData;
    QRBand5: TQRBand;
    QRShape21: TQRShape;
    lab10: TQRLabel;
    lab11: TQRLabel;
    QRGroup1: TQRGroup;
    QRBand4: TQRBand;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRExpr1: TQRExpr;
    QRLabel7: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
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
  FEtatProvisions: TFEtatProvisions;

implementation

{$R *.DFM}
procedure TFEtatProvisions.visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;


procedure TFEtatProvisions.imprimer;
begin
  QuickRep1.print;
end;

procedure TFEtatProvisions.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  LabDate.Caption := Provisions_Isa.EdDate.Text;
  Lab4.Caption :=  Provisions_Isa.EdLibelle.Text;
  NoCpt.Caption := Provisions_Isa.NumCpt.Text;
  Case Provisions_Isa.Tag Of
  // Si fenêtre d'ouverture
    1: Begin
         LabTitre.Caption := 'Ouverture';
         lab10.Caption := 'Ouverture';
         QRShape1.Left := 120;
         QRShape4.Left := 120;
         QRShape5.Left := 120;
         QRShape1.width := 459;
         QRShape4.width := 459;
         QRShape5.width := 459;
         QRShape15.Width := 395;
         QRShape7.Enabled := false;
         QRShape10.Enabled := false;
         QRShape9.Enabled := false;
         QRShape13.Enabled := false;
         QRLabel2.Enabled := false;
         QRDBText1.Enabled := false;
         QRLabel6.Enabled := false;
         QRDBText5.Enabled := false;
         QRExpr3.Enabled := false;
         QRShape19.Enabled := false;
       end;
  // Si fenêtre de clôture
    2: Begin
         LabTitre.Caption := 'Clôture';
         lab10.Caption := 'Clôture';
         QRShape1.Left := 40;
         QRShape4.Left := 40;
         QRShape5.Left := 40;
         QRShape1.width := 641;
         QRShape4.width := 641;
         QRShape5.width := 641;
         Qrshape15.Width := 497;
         QRShape7.Enabled := true;
         QRShape10.Enabled := true;
         QRShape9.Enabled := true;
         QRShape13.Enabled := true;
         QRLabel2.Enabled := true;
         QRDBText1.Enabled := true;
         QRLabel6.Enabled := true;
         QRDBText5.Enabled := true;
         QRExpr3.Enabled := true;
         QRShape19.Enabled := true;
       end;
  end;
end;

end.
