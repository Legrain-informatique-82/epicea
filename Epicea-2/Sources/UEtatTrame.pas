{***************************************************************
 *
 * Unit Name: UEtatTrame
 * Purpose  :
 * Author   :  Selection : 1 ds UQReport
 * History  :
 *
 ****************************************************************}

unit UEtatTrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt,ModuleTrame, qrprntr, Qrctrls, StdCtrls, Buttons,
  ExtDlgs;

type
  TFEtatTrame = class(TForm)
    QuickRep1: TQuickRep;
    QRBand4: TQRBand;
    SysData: TQRSysData;
    QRBand1: TQRBand;
    QRShape18: TQRShape;
    QRLabel14: TQRLabel;
    QRShape7: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    TBanque: TQRDBText;
    TJournal: TQRDBText;
    TLibelle: TQRDBText;
    TCode: TQRDBText;
    QRShape2: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape13: TQRShape;
    TOper: TQRLabel;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape12: TQRShape;
    QRShape3: TQRShape;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    Image1: TQRImage;
    QRSysData1: TQRSysData;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape21: TQRShape;
    QRShape17: TQRShape;
    QRShape33: TQRShape;
    QRShape32: TQRShape;
    QRShape31: TQRShape;
    QRBand3: TQRBand;
    Ligne: TQRDBText;
    Compte: TQRDBText;
    Libelle: TQRDBText;
    Montant: TQRDBText;
    QRShape30: TQRShape;
    QRShape28: TQRShape;
    QRShape27: TQRShape;
    QRShape23: TQRShape;
    QRLabel13: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape20: TQRShape;
    QRShape22: TQRShape;
    QRShape19: TQRShape;
    QRLabel10: TQRLabel;
    TVA: TQRDBText;
    TVAC: TQRDBText;
    TVATy: TQRDBText;
    TVAT: TQRDBText;
    QRShape26: TQRShape;
    QRShape25: TQRShape;
    QRShape24: TQRShape;
    procedure SelectionTrame;
    procedure QuickRep1BeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
    procedure visualiser;
    procedure imprimer;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
   // procedure visualiser;
  end;

var
  FEtatTrame: TFEtatTrame;
  currentItem,NbLigne,idTrame,i: integer;
implementation

uses //E2_Trame,
UQReport;

{$R *.DFM}


procedure TFEtatTrame.SelectionTrame;
begin
//  QRLabel14.caption:=Trame.Edit_PMNom.text;
//  if Trame.Edit_PMJournal.text='A' then
//    TOper.caption:= 'Achat';
//  if Trame.Edit_PMJournal.text='V' then
//    TOper.caption:='Vente';
//  if Trame.Edit_PMJournal.text='O' then
//    TOper.caption:='Opérations diverses';
//  if Trame.Edit_PMJournal.text='T' then
//    TOper.caption:='Règlement';
//  if Trame.ExDBGTrameL.Fields[0].AsString = '' then
//  begin
//      qrband2.enabled := false;
//      qrband3.Enabled := false;
//  end
//  else
//  begin
//      qrband2.enabled := true;
//      qrband3.Enabled := true;
//  end;
end;

procedure TFEtatTrame.visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;


procedure TFEtatTrame.imprimer;
begin
  QuickRep1.print;
end;

procedure TFEtatTrame.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  SelectionTrame;
end;



end.
