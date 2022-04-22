{***************************************************************
 *
 * Unit Name: UEtatTiersDetail
 *
 *         voir pour les tables echeance, restedc...qui sont vides !
 *
 *
 ****************************************************************}

unit UEtatTiersDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, UEtatTiers, qrprntr, Db, DBTables,
  StdCtrls, Buttons, ExtDlgs, Menus, Registry;  

type
  TFEtatTiersDetail = class(TForm)
    QRepDetail: TQuickRep;
    QRBand1: TQRBand;
    shcadretitre: TQRShape;
    QRLabel1: TQRLabel;
    shTitre: TQRShape;
    Image1: TQRImage;
    ltitre: TQRLabel;
    QRShape1: TQRShape;
    QRLabel2: TQRLabel;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    QRShape10: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape11: TQRShape;
    QRLabel6: TQRLabel;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape27: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    fax: TQRLabel;
    QRShape37: TQRShape;
    BColDetail: TQRBand;
    QRShape43: TQRShape;
    QRLabel10: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRShape46: TQRShape;
    QRShape47: TQRShape;
    QRShape48: TQRShape;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRShape55: TQRShape;
    BDetail: TQRBand;
    QRShape15: TQRShape;
    dbCompte: TQRDBText;
    dbRef: TQRDBText;
    dbDate: TQRDBText;
    dbEcheance: TQRDBText;
    QRShape19: TQRShape;
    QRShape21: TQRShape;
    QRShape24: TQRShape;
    QRShape26: TQRShape;
    QRShape28: TQRShape;
    dbTVAType: TQRDBText;
    dbTVATaux: TQRDBText;
    dbDebit: TQRDBText;
    dbCredit: TQRDBText;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRBand3: TQRBand;
    QRShape23: TQRShape;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    coche: TQRImage;
    NonCoche: TQRImage;
    QRLabel7: TQRLabel;
    dbTVACode: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    dbRegleD: TQRDBText;
    dbReste: TQRDBText;
    dbRegleC: TQRDBText;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    t1: TQRLabel;
    t2: TQRLabel;
    t3: TQRLabel;
    t4: TQRLabel;
    t5: TQRLabel;
    t6: TQRLabel;
    t7: TQRLabel;
    t8: TQRLabel;
    t9: TQRLabel;
    t10: TQRLabel;
    t11: TQRLabel;
    t12: TQRLabel;
    t13: TQRLabel;
    t14: TQRLabel;
    t15: TQRLabel;
    t17: TQRLabel;
    t18: TQRLabel;
    t16: TQRLabel;
    tel: TQRLabel;
    labmail: TQRLabel;
    procedure QRepDetailBeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
    procedure visualiser;
    procedure imprimer;
    procedure SelectionDetail;
    procedure QRepDetailAfterPreview(Sender: TObject);
    procedure QRepDetailAfterPrint(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    valeurPiece: string;
  end;

var
  FEtatTiersDetail: TFEtatTiersDetail;
implementation

{$R *.DFM}

// 
procedure TFEtatTiersDetail.visualiser;
begin
  QRepDetail.PrintIfEmpty:=true;
  QRepDetail.preview;
end;

procedure TFEtatTiersDetail.imprimer;
begin
  QRepDetail.print;
end;

procedure TFEtatTiersDetail.SelectionDetail;
begin
//*************** en-tête ******************************
//  FEtatTiers.chercherTiers(FEtatTiers.tiers);
  FEtatTiers.chercherDansTable('Dossier','Tiers.DB','Tiers',FEtatTiers.tiers);
//  dbTTiers.DataSet := FEtatTiers.QCherche;
  t1.Caption := FEtatTiers.QCherche.fieldbyname('Tiers').asstring;
//  dbTNom.DataSet := FEtatTiers.QCherche;
  t2.Caption := FEtatTiers.QCherche.fieldbyname('Nom').asstring;
//  dbTCompte.DataSet := FEtatTiers.QCherche;
  t3.Caption := FEtatTiers.QCherche.fieldbyname('Type').asstring;
//  dbTType.DataSet := FEtatTiers.QCherche;
  t4.Caption := FEtatTiers.QCherche.fieldbyname('Compte').asstring;
  if FEtatTiers.QCherche.FieldByName('Actif').AsString = 'Faux' then
  begin
    coche.Enabled := false;
    nonCoche.Enabled := true;
    nonCoche.Top := 216;
    nonCoche.Left := 88;
  end
  else
  begin
    coche.Enabled := true;
    nonCoche.Enabled := false;
  end;
//  adr1.DataSet := FEtatTiers.QTiers;
  t5.Caption := FEtatTiers.QCherche.fieldbyname('Adresse1').asstring;
//  adr2.DataSet := FEtatTiers.QTiers;
  t6.Caption := FEtatTiers.QCherche.fieldbyname('Adresse2').asstring;
//  cp.DataSet := FEtatTiers.QTiers;
  t7.Caption := FEtatTiers.QCherche.fieldbyname('Poste').asstring;
//  ville.DataSet := FEtatTiers.QTiers;
  t8.Caption := FEtatTiers.QCherche.fieldbyname('Ville').asstring;
//  pays.DataSet := FEtatTiers.QTiers;
  t9.Caption := FEtatTiers.QCherche.fieldbyname('Pays').asstring;
//  tel1.DataSet := FEtatTiers.QTiers;
  t10.Caption := FEtatTiers.QCherche.fieldbyname('Telephone1').asstring;
//  tel2.DataSet := FEtatTiers.QTiers;
  t11.Caption := FEtatTiers.QCherche.fieldbyname('Telephone2').asstring;
//  telcop.DataSet := FEtatTiers.QTiers;
  t12.Caption := FEtatTiers.QCherche.fieldbyname('Telecopie').asstring;
//  mail.DataSet := FEtatTiers.QTiers;
  t13.Caption := FEtatTiers.QCherche.fieldbyname('Mel').asstring;
  if t13.Width > 145 then
  begin
    labmail.Caption := '';
    t13.Left := 264;
    t13.Width := 185;
  end
  else
  begin
    labmail.Caption := 'Mail';
    t13.Left := 296;
    t13.Width := 145;
  end;
//  adr1livr.DataSet := FEtatTiers.QTiers;
  t14.Caption := FEtatTiers.QCherche.fieldbyname('Livr_Adr1').asstring;
//  adr2livr.DataSet := FEtatTiers.QTiers;
  t15.Caption := FEtatTiers.QCherche.fieldbyname('Livr_Adr2').asstring;
//  cplivr.DataSet := FEtatTiers.QTiers;
  t16.Caption := FEtatTiers.QCherche.fieldbyname('Livr_Poste').asstring;
//  villelivr.DataSet := FEtatTiers.QTiers;
  t17.Caption := FEtatTiers.QCherche.fieldbyname('Livr_Ville').asstring;
//  payslivr.DataSet := FEtatTiers.QTiers;
  t18.Caption := FEtatTiers.QCherche.fieldbyname('Livr_Pays').asstring;
//*******************************************
  shcadretitre.Height := 57;
  shTitre.Top := 104;
  lTitre.Caption := ''; 
  if FEtatTiers.QCherche.FieldByName('Adresse2').AsString = '' then
    t5.Top := 339
  else
    t5.Top := 315;
  t5.left := 8;
  if FEtatTiers.QCherche.FieldByName('Livr_Adr2').AsString = '' then
    t14.Top := 339
  else
    t14.Top := 315;
  t14.Left := 488;
  if FEtatTiers.QCherche.FieldByName('Telephone1').AsString = '' then
    tel.caption := ''
  else
    tel.caption := 'Tél.';
  if FEtatTiers.QCherche.FieldByName('Telecopie').AsString = '' then
    fax.caption := ''
  else
    fax.caption := 'Fax';
  FEtatTiers.QCherche.Close;
  FEtatTiers.QCherche.Free;
//************ détail **********************
  FEtatTiers.chercherDansTable('Exercice','Ecriture.DB','Tiers',FEtatTiers.tiers);
  FEtatTiers.FiltrerTable;
  dbRef.DataSet := FEtatTiers.TaPiece;
  dbTVACode.DataSet := FEtatTiers.QCherche;
  dbTVAType.DataSet := FEtatTiers.QCherche;
  dbTVATaux.DataSet := FEtatTiers.QCherche;
  dbDebit.DataSet := FEtatTiers.QCherche;
  dbCredit.DataSet := FEtatTiers.QCherche;
  valeurPiece := FEtatTiers.QCherche.fieldbyname('ID_Piece').asstring;
  FEtatTiers.QCherche.Close;
  FEtatTiers.QCherche.Free;
  FEtatTiers.chercherDansTable('Exercice','Echeance.DB','ID',valeurPiece);
  dbEcheance.DataSet := FEtatTiers.QCherche;
  FEtatTiers.QCherche.Close;
  FEtatTiers.QCherche.Free;
  FEtatTiers.chercherDansTable('Exercice','ResteDC.DB','Tiers',FEtatTiers.tiers);
  dbRegleD.DataSet := FEtatTiers.QCherche;
  dbRegleC.DataSet := FEtatTiers.QCherche;
  dbReste.DataSet := FEtatTiers.QCherche;
  FEtatTiers.QCherche.Close;
  FEtatTiers.QCherche.Free;
end;

procedure TFEtatTiersDetail.QRepDetailBeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  selectionDetail;
end;

procedure TFEtatTiersDetail.QRepDetailAfterPreview(Sender: TObject);
begin
//showmessage('After Preview');
//  FEtatTiers.QTiers.close;
//  FEtatTiers.QTiers.Free;
//  FEtatTiers.QEcriture.Close;
//  FEtatTiers.QEcriture.Free;
//  FEtatTiers.QEcheance.Close;
//  FEtatTiers.QEcheance.Free;
//  FEtatTiers.QReste.Close;
//  FEtatTiers.QReste.Free;
end;

procedure TFEtatTiersDetail.QRepDetailAfterPrint(Sender: TObject);
begin
//showmessage('after print');
end;

end.
