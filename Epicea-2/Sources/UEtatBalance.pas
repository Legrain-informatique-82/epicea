{***************************************************************
 *
 * Unit Name: UEtatBalance : 
 *                             1.de l'exercice (N)
 *                             2. de l'ouverture (N+1)
 *                             3. générale (N)+(N+1)
 *                             4.d'une période (N-1)
 ****************************************************************}

unit UEtatBalance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, ExtDlgs, DMBalances, DMPlanCpt;

type
  TFEtatBalance = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    Image1: TQRImage;
    Dlg: TOpenPictureDialog;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRBand2: TQRBand;
    QRSysData1: TQRSysData;
    Recap: TQRBand;
    QRSysData2: TQRSysData;
    labtitre: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    DBDate1: TQRDBText;
    DBDate2: TQRDBText;
    QRLabel3: TQRLabel;
    Date1: TQRDBText;
    QRLabel8: TQRLabel;
    Date2: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    SubDetail1: TQRSubDetail;
    DBCpt: TQRDBText;
    QRShape1: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRBand3: TQRBand;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    DExpr1: TQRExpr;
    CExpr1: TQRExpr;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    DExpr2: TQRExpr;
    CExpr2: TQRExpr;
    DExpr3: TQRExpr;
    CExpr3: TQRExpr;
    QRGroup1: TQRGroup;
    QRBand4: TQRBand;
    QRLabel31: TQRLabel;
    QRShape10: TQRShape;
    QRLabel30: TQRLabel;
    QRShape4: TQRShape;
    QRLabel29: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel28: TQRLabel;
    QRShape7: TQRShape;
    QRShape5: TQRShape;
    QRLabel27: TQRLabel;
    QRLabel16: TQRLabel;
    QRShape8: TQRShape;
    QRLabel26: TQRLabel;
    QRShape6: TQRShape;
    QRLabel19: TQRLabel;
    QRLabel25: TQRLabel;
    QRShape9: TQRShape;
    QRLabel24: TQRLabel;
    QRShape24: TQRShape;
    Exprlib: TQRExpr;
    ExprClasse: TQRExpr;
    Deb1: TQRExpr;
    Cred1: TQRExpr;
    Deb2: TQRExpr;
    Cred2: TQRExpr;
    Deb3: TQRExpr;
    Cred3: TQRExpr;
    QRBand5: TQRBand;
    QRLabel11: TQRLabel;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    TExpr1: TQRExpr;
    TExpr2: TQRExpr;
    TExpr3: TQRExpr;
    TExpr4: TQRExpr;
    TExpr5: TQRExpr;
    TExpr6: TQRExpr;
    procedure QuickRep1BeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
    procedure Imprimer;
    procedure Visualiser;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FEtatBalance: TFEtatBalance;
  bal: integer; //choix de la balance à présenter
implementation

{$R *.DFM}
procedure TFEtatBalance.Visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;

procedure TFEtatBalance.Imprimer;
begin
  QuickRep1.Print;
end;

procedure TFEtatBalance.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  Case bal of
    1:    //exercice (N)
    begin
      QRLabel2.Caption := 'de l''Exercice';
      QRLabel2.Left := 534;
      // report début
      QRLabel13.left :=297;
      QRLabel29.left :=281;
      QRLabel28.left :=361;
      Deb1.left :=270;
      Cred1.left :=347;
      DExpr1.left :=270;
      CExpr1.left :=347;
      TExpr1.left :=270;
      TExpr2.left :=347;
      QRShape4.Enabled :=true;
      QRShape16.Enabled :=true;
      QRShape18.Enabled :=true;
      QRShape7.Enabled :=true;
      QRShape11.Enabled :=true;
      QRShape21.Enabled :=true;
      TExpr1.Enabled :=true;
      TExpr2.Enabled :=true;
      // mouvement
      QRLabel16.enabled :=true;
      QRLabel27.enabled :=true;
      QRLabel26.enabled :=true;
      Deb2.enabled :=true;
      Cred2.enabled :=true;
      DExpr2.enabled :=true;
      CExpr2.enabled :=true;
      QRShape5.Enabled :=true;
      QRShape15.Enabled :=true;
      QRShape19.Enabled :=true;
      QRShape8.Enabled :=true;
      QRShape12.Enabled :=true;
      QRShape22.Enabled :=true;
      TExpr3.Enabled :=true;
      TExpr4.Enabled :=true;
       // solde fin
      QRLabel19.enabled :=true;
      QRLabel25.enabled :=true;
      QRLabel24.enabled :=true;
      Deb3.enabled :=true;
      Cred3.enabled :=true;
      DExpr3.enabled :=true;
      CExpr3.enabled :=true;
      QRShape9.Enabled :=true;
      QRShape13.Enabled :=true;
      QRShape23.Enabled :=true;
      QRShape8.Enabled :=true;
      QRShape12.Enabled :=true;
      QRShape22.Enabled :=true;
      TExpr5.Enabled :=true;
      TExpr6.Enabled :=true;
    end;
    2:    //ouverture (N+1)
    begin
      QRLabel2.Caption := 'd''Ouverture';
      QRLabel2.Left := 542;
      // report début
      QRLabel13.left :=609;
      QRLabel29.left :=585;
      QRLabel28.left :=657;
      Deb1.left :=575;
      Cred1.left :=649;
      DExpr1.left :=575;
      CExpr1.left :=649;
      TExpr1.left :=575;
      TExpr2.left :=649;
      QRShape4.Enabled :=false;
      QRShape16.Enabled :=false;
      QRShape18.Enabled :=false;
      QRShape7.Enabled :=false;
      QRShape11.Enabled :=false;
      QRShape21.Enabled :=false;
      TExpr1.Enabled :=true;
      TExpr2.Enabled :=true;
      // mouvement
      QRLabel16.enabled :=false;
      QRLabel27.enabled :=false;
      QRLabel26.enabled :=false;
      Deb2.enabled :=false;
      Cred2.enabled :=false;
      DExpr2.enabled :=false;
      CExpr2.enabled :=false;
      TExpr3.Enabled :=false;
      TExpr4.Enabled :=false;
      QRShape5.Enabled :=false;
      QRShape15.Enabled :=false;
      QRShape19.Enabled :=false;
      QRShape8.Enabled :=false;
      QRShape12.Enabled :=false;
      QRShape22.Enabled :=false;
       // solde fin
      QRLabel19.enabled :=false;
      QRLabel25.enabled :=false;
      QRLabel24.enabled :=false;
      Deb3.enabled :=false;
      Cred3.enabled :=false;
      DExpr3.enabled :=false;
      CExpr3.enabled :=false;
      TExpr5.Enabled :=false;
      TExpr6.Enabled :=false;
      QRShape9.Enabled :=true;
      QRShape13.Enabled :=true;
      QRShape23.Enabled :=true;
      QRShape6.Enabled :=true;
      QRShape14.Enabled :=true;
      QRShape20.Enabled :=true;
    end;
    3:    //générale (N)+(N+1)
    begin
      QRLabel2.Caption := 'Générale';
      QRLabel2.Left := 542;
      // report début
      QRLabel13.left :=297;
      QRLabel29.left :=281;
      QRLabel28.left :=361;
      Deb1.left :=270;
      Cred1.left :=347;
      DExpr1.left :=270;
      CExpr1.left :=347;
      TExpr1.left :=270;
      TExpr2.left :=347;
      QRShape4.Enabled :=true;
      QRShape16.Enabled :=true;
      QRShape18.Enabled :=true;
      QRShape7.Enabled :=true;
      QRShape11.Enabled :=true;
      QRShape21.Enabled :=true;
      TExpr1.Enabled :=true;
      TExpr2.Enabled :=true;
      // mouvement
      QRLabel16.enabled :=true;
      QRLabel27.enabled :=true;
      QRLabel26.enabled :=true;
      Deb2.enabled :=true;
      Cred2.enabled :=true;
      DExpr2.enabled :=true;
      CExpr2.enabled :=true;
      QRShape5.Enabled :=true;
      QRShape15.Enabled :=true;
      QRShape19.Enabled :=true;
      QRShape8.Enabled :=true;
      QRShape12.Enabled :=true;
      QRShape22.Enabled :=true;
      TExpr3.Enabled :=true;
      TExpr4.Enabled :=true;
       // solde fin
      QRLabel19.enabled :=true;
      QRLabel25.enabled :=true;
      QRLabel24.enabled :=true;
      Deb3.enabled :=true;
      Cred3.enabled :=true;
      DExpr3.enabled :=true;
      CExpr3.enabled :=true;
      TExpr5.Enabled :=true;
      TExpr6.Enabled :=true;
      QRShape9.Enabled :=true;
      QRShape13.Enabled :=true;
      QRShape23.Enabled :=true;
      QRShape8.Enabled :=true;
      QRShape12.Enabled :=true;
      QRShape22.Enabled :=true;
    end;
    4:    //période (N-1)
    begin
      QRLabel2.Caption := 'd''une Période';
      QRLabel2.Left := 526;
      // report début
      QRLabel13.enabled :=false;
      QRLabel29.enabled :=false;
      QRLabel28.enabled :=false;
      Deb1.enabled :=false;
      Cred1.enabled :=false;
      DExpr1.enabled :=false;
      CExpr1.enabled :=false;
      TExpr1.Enabled :=false;
      TExpr2.Enabled :=false;
      QRShape4.Enabled :=false;
      QRShape16.Enabled :=false;
      QRShape18.Enabled :=false;
      QRShape7.Enabled :=false;
      QRShape11.Enabled :=false;
      QRShape21.Enabled :=false;
      // mouvement
      QRLabel16.enabled :=true;
      QRLabel27.enabled :=true;
      QRLabel26.enabled :=true;
      Deb2.enabled :=true;
      Cred2.enabled :=true;
      DExpr2.enabled :=true;
      CExpr2.enabled :=true;
      TExpr3.Enabled :=true;
      TExpr4.Enabled :=true;
      QRShape5.Enabled :=true;
      QRShape15.Enabled :=true;
      QRShape19.Enabled :=true;
      QRShape8.Enabled :=true;
      QRShape12.Enabled :=true;
      QRShape22.Enabled :=true;
       // solde fin
      QRLabel19.enabled :=true;
      QRLabel25.enabled :=true;
      QRLabel24.enabled :=true;
      Deb3.enabled :=true;
      Cred3.enabled :=true;
      DExpr3.enabled :=true;
      CExpr3.enabled :=true;
      TExpr5.Enabled :=true;
      TExpr6.Enabled :=true;
      QRShape9.Enabled :=true;
      QRShape13.Enabled :=true;
      QRShape23.Enabled :=true;
      QRShape8.Enabled :=true;
      QRShape12.Enabled :=true;
      QRShape22.Enabled :=true;
    end;
  end;
end;

end.
