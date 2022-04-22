
unit UEtatTiers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, qrprntr, Qrctrls, StdCtrls, Buttons,
  ExtDlgs, Db, DBTables, Menus, Registry,E2_Main;
type
  TFEtatTiers = class(TForm)
    QuickRep1: TQuickRep;
    Dlg: TOpenPictureDialog;
    QRBand3: TQRBand;
    QRShape23: TQRShape;
    QRSysData1: TQRSysData;                   
    QRSysData2: TQRSysData;                  
    BListe: TQRBand;
    shColListe: TQRShape;
    l2: TQRLabel;
    l3: TQRLabel;
    l5: TQRLabel;
    l10: TQRLabel;
    l4: TQRLabel;
    l6: TQRLabel;
    l7: TQRLabel;
    l8: TQRLabel;
    sh9: TQRShape;
    sh10: TQRShape;
    sh11: TQRShape;                                 
    sh27: TQRShape;                              
    sh4: TQRShape;
    sh26: TQRShape;
    sh12: TQRShape;
    DataSource1: TDataSource;
    Table1: TTable;
    Table1Tiers: TStringField;
    Table1Nom: TStringField;
    Table1Compte: TStringField;
    Table1Type: TStringField;
    Table1SensCredit: TBooleanField;
    Table1Rapprochement: TBooleanField;
    Table1TvaDebit: TBooleanField;
    Table1Abandonne: TBooleanField;
    Table1Debit_Deb: TFloatField;
    Table1Credit_Deb: TFloatField;
    Table1Adresse1: TStringField;                            
    Table1Adresse2: TStringField;
    Table1Poste: TStringField;
    Table1Ville: TStringField;                             
    Table1Pays: TStringField;
    Table1Livr_Adr1: TStringField;
    Table1Livr_Adr2: TStringField;
    Table1Livr_Poste: TStringField;
    Table1Livr_Ville: TStringField;
    Table1Livr_Pays: TStringField;
    Table1Telephone1: TStringField;
    Table1Telephone2: TStringField;
    Table1Telecopie: TStringField;
    Table1Mel: TStringField;
    Table1Qui: TStringField;
    Table1Quand: TDateTimeField;
    Table1Actif: TBooleanField;
    BitBtnVisu: TButton;                                   
    BitBtnPrint: TButton;                              
    BDetailListe: TQRBand;
    DBTiers: TQRDBText;
    DBNom: TQRDBText;
    DBCompte: TQRDBText;
    sh13: TQRShape;
    sh14: TQRShape;
    sh15: TQRShape;
    sh16: TQRShape;
    sh24: TQRShape;
    DBT1: TQRDBText;
    DBT2: TQRDBText;
    DBT3: TQRDBText;
    DBT4: TQRDBText;
    DBT5: TQRDBText;                                  
    sh25: TQRShape;                                    
    DBT6: TQRDBText;
    DBT7: TQRDBText;
    DBT8: TQRDBText;
    DBT9: TQRDBText;
    DBT10: TQRDBText;
    DBT11: TQRDBText;
    DBT12: TQRDBText;
    DBT13: TQRDBText;
    DBT14: TQRDBText;
    sh28: TQRShape;
    DBType: TQRDBText;
    QTriC: TQuery;
    QTriF: TQuery;
    lfax: TQRLabel;
    RGChoixListe: TRadioGroup;
    lTel: TQRLabel;                                          
    QRShape6: TQRShape;
    QRShape7: TQRShape;                                 
    QRShape9: TQRShape;
    QRBand2: TQRBand;
    cadreTitre: TQRShape;
    QRLabel7: TQRLabel;
    labTitreListe: TQRLabel;
    ligneTitre: TQRShape;
    Image1: TQRImage;
    TaPiece: TTable;
    TaPieceID: TIntegerField;
    TaPieceReference: TStringField;
    TaPieceDate: TDateField;
    TaPieceTypePiece: TSmallintField;
    TaPieceCompte: TStringField;                         
    ImageForm: TImage;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    RGLogo: TRadioGroup;
    coche: TQRImage;
    NonCoche: TQRImage;
    QRBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRImage1: TQRImage;
    QRImage2: TQRImage;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;                                
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    procedure visualiser;
    procedure imprimer;
    procedure QuickRep1BeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);                                
    procedure SelectionListe;                                
    procedure GenererListe(sender: Tobject);
    procedure chercherEcheance(id:string);
    procedure chercherTypesTiers;
    procedure chercherDansTable(nomBase,table,champ,valeur:string);
    procedure FiltrerTable;
//*******************************************//*  test...
    procedure BitBtnVisuClick(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure initBtnLogo(selection: integer);
//    procedure GererLogo;
    procedure chargerLogo;
    procedure dechargerLogo;                              
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
//    procedure RGLogoClick(Sender: TObject);              
//    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BDetailListeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
//*******************************************//*

  private                                                    
    { Déclarations privées }
  public
    { Déclarations publiques }                            
    tiers: string;
    QTypeTiers,QCherche, QEcheance, QReste : TQuery;
    choix: integer;
    TabLogo: array[1..20] of string;  // chemin
    logoCharge: array[1..20] of boolean;
  end;

var
  FEtatTiers: TFEtatTiers;
  itemindex,i,imax,selectionEtat {** test} : integer;
  actif: boolean;
  vartable : TTable;
  varQuery: TQuery;                          
implementation


uses
 UEtatTiersDetail, UQReport;
  {UEtatTrame,ModuleTrame, UEtatTiers, UEtatTiersDetail, UEtatChargesRepartir,
//  UEtatChargeAPayer,
//  UEtatRepriseChargeARepartir, UEtatCPConstatesAvance,UEtatRepriseChargeCA,
//  UEtatRepriseChargeAPayer2, UEtatProvisions, UEtatDepensesEnt, UEtatProvisions,
//  UEtatBalance;


//  uses UQReport;   **** à remettre

{$R *.DFM}

//*************** pour tester ***********************************************//*
procedure TFEtatTiers.BitBtnPrintClick(Sender: TObject);
begin
//  case FPrint.RGChoixListe.ItemIndex of        ** à remettre                                                //*
  case RGChoixListe.ItemIndex of
   0,1,2:
    begin// listing
      imprimer;;
    end;
   3:
    begin// détail
      tiers := '+ASSEMAT';
      FEtatTiersDetail.imprimer;;
    end;
 end;
end;
//******************************************************************************

procedure TFEtatTiers.BitBtnVisuClick(Sender: TObject); //*  test...
begin
// case FPrint.RGChoixListe.ItemIndex of ** à remettre
  case RGChoixListe.ItemIndex of
   0,1,2:
    begin// listing
      visualiser;
    end;
   3:
    begin// détail
      tiers := '+ASSEMAT';
      FEtatTiersDetail.visualiser;
    end;
 end;
end;

//******************************************************************************
Function CreeFiltreOU(Champ : string ; const Val : array of const):string ;
var
I,J:integer;
begin
case Val[0].VType of

	vtAnsiString : Result:=Champ + '=''' + string(Val[0].VAnsiString)+'''';
   vtString     : Result:=Champ + '=''' + Val[0].VString^+'''';
	vtObject     : if (Val[0].VObject is TStringList) then
                         if ((Val[0].VObject as TStringList).count) > 0 then
                            begin
   			    Result:=Champ + '=''' + (Val[0].VObject as TStringList).Strings[0]+'''';
                            for J:=1 to (((Val[0].VObject as TStringList).count)-1) do
         		    	Result:=Result + ' or ' + Champ + '=''' + (Val[0].VObject as TStringList).Strings[J]+'''';
			    end
                            else result:=Champ + '=''''';
	vtInteger    : Result:=Champ + '=''' + IntToStr(Val[0].VInteger) +'''';
   end;

for I := 1 to High(Val) do begin
    case Val[I].VType of
        vtAnsiString : Result:=Result + ' or ' + Champ + '='''+ string(Val[I].VAnsiString)+'''';
        vtString     : Result:=Result + ' or ' + Champ + '='''+ Val[I].VString^+'''';
	     vtObject	   : begin
                            if (Val[I].VObject is TStringList) then
                             if ((Val[0].VObject as TStringList).count) > 0 then
                               begin
                               for J:=1 to (((Val[I].VObject as TStringList).count)-1) do
         		           Result:=Result + ' or ' + Champ + '=''' + (Val[I].VObject as TStringList).Strings[J]+'''';
                               end
                               else result:=Champ + '=''''';
                            end;
             vtInteger    : Result:=Champ + '=''' + IntToStr(Val[I].VInteger) +'''';
              end;
   end;
end;

//***************************************************** //* test  //*

procedure TFEtatTiers.visualiser;
begin
  QuickRep1.PrintIfEmpty:=true;
  QuickRep1.preview;
end;

procedure TFEtatTiers.imprimer;
begin
  QuickRep1.print;
end;


procedure TFEtatTiers.BDetailListeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  case RGChoixListe.ItemIndex of
    0:
    begin
      if vartable.fieldbyname('Actif').asstring = 'Vrai' then
      begin
        coche.Top := 11;
        coche.Enabled := true;
        noncoche.Top:= 39;
        noncoche.Enabled := false;
      end;
      if vartable.FieldByName('Actif').asstring = 'Faux' then
      begin
        coche.Top := 39;
        coche.Enabled := false;
        noncoche.Top:= 11;
        noncoche.Enabled := true;
      end;
    end;
    1..6:
    begin
      if varQuery.fieldbyname('Actif').asstring = 'Vrai' then
      begin
        coche.Top := 11;
        coche.Enabled := true;
        noncoche.Top:= 39;
        noncoche.Enabled := false;
      end;
      if varQuery.FieldByName('Actif').asstring = 'Faux' then
      begin
        coche.Top := 39;
        coche.Enabled := false;
        noncoche.Top:= 11;
        noncoche.Enabled := true;
      end;
    end;
  end;
end;

procedure TFEtatTiers.GenererListe(sender: Tobject);
begin
  if sender <> nil then
  begin
    if sender.ClassType = TTable then
    begin
      vartable := table1;
      QuickRep1.DataSet := table1;
      dbtiers.Dataset := table1;
      dbnom.Dataset := table1;
      dbtype.Dataset := table1;
      dbcompte.Dataset := table1;
      //**** adresse *******
      dbt1.Dataset := table1;
      dbt2.Dataset := table1;
      dbt3.Dataset := table1;
      dbt4.Dataset := table1;
      dbt5.Dataset := table1;
      //**** livraison *****
      dbt6.Dataset := table1;
      dbt7.Dataset := table1;
      dbt8.Dataset := table1;
      dbt9.Dataset := table1;
      dbt10.Dataset := table1;
      //**** contact *******
      dbt11.Dataset := table1;
      dbt12.Dataset := table1;
      dbt13.Dataset := table1;
      dbt14.Dataset := table1;
    end;
    if sender.ClassType = TQuery then
    begin
      case  RGChoixListe.ItemIndex  of
        1: varQuery := QTriC;
        2: varQuery := QTriF;
  //      3: VarQuery := QTriP;
  //      4: VarQuery := QTriA;
  //      5: VarQuery := QTriD;
  //      6: VarQuery := QTriE;
      end;
      QuickRep1.DataSet := varQuery;
      dbtiers.Dataset := varQuery;
      dbnom.Dataset := varQuery;
      dbtype.Dataset := varQuery;
      dbcompte.Dataset := varQuery;
      //**** adresse *******
      dbt1.Dataset := varQuery;
      dbt2.Dataset := varQuery;
      dbt3.Dataset := varQuery;
      dbt4.Dataset := varQuery;
      dbt5.Dataset := varQuery;
      //**** livraison *****
      dbt6.Dataset := varQuery;
      dbt7.Dataset := varQuery;
      dbt8.Dataset := varQuery;
      dbt9.Dataset := varQuery;
      dbt10.Dataset := varQuery;
      //**** contact *******
      dbt11.Dataset := varQuery;
      dbt12.Dataset := varQuery;
      dbt13.Dataset := varQuery;
      dbt14.Dataset := varQuery;
    end;
  end;
end;


procedure TFEtatTiers.SelectionListe;
begin
//  case FPrint.RGChoixListe.ItemIndex of          ** à remettre
case RGChoixListe.ItemIndex of
    0: // liste tiers : tous les enrg de la table tiers
    begin
      cadretitre.Height := 57;
      ligneTitre.Top := 104;
      labTitreListe.Caption := '';
      genererListe(Table1);
 //     listecomplete;
    end;
    1: // liste clients : type 'C'
    begin
      cadretitre.Height := 85;
      ligneTitre.Top := 130;
      labTitreListe.Caption := '- Clients -';
      labTitreListe.Left := 566;
      genererListe(QTriC);
    end;
    2: // liste fournisseurs : type 'F'
    begin
      cadretitre.Height := 85;
      ligneTitre.Top := 130;
      labTitreListe.Caption := '- Fournisseurs -';
      labTitreListe.Left := 534;
      genererListe(QTriF);
    end;
  end;
end;

procedure TFEtatTiers.QuickRep1BeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
//  Tiers.taTiers.Locate('Tiers',(Tiers.DBGridTiers.Fields[0].asstring),[]);
// tiers := taTiers.fieldbyname('Tiers').asstring;
  SelectionListe;
end;

procedure TFEtatTiers.chercherTypesTiers;
var
  typeTiers: Char;
begin
  QTypeTiers := TQuery.create(nil);
  QTypeTiers.DatabaseName := 'Dossier';
  QTypeTiers.sql.Add('Select Distinct Type from Tiers.DB ');
  if not QTypeTiers.Prepared then
    QTypeTiers.Prepare;
  QTypeTiers.open;
  QTypeTiers.First;
  while not QTypeTiers.EOF do
  begin
    typeTiers := (QTypeTiers.fields[0].asstring)[1];
    case typeTiers of
      'C':
      begin
        RGChoixListe.Items.Add('Clients');
        RGChoixListe.ComponentIndex := 1;
      end;
      'F':
      begin                                          //i...
        RGChoixListe.Items.Add('Fournisseurs');
        RGChoixListe.ComponentIndex := 2;        // prévoir pour les case...
      end;
    end;
    QTypeTiers.next;
  end;
  RGChoixListe.Items.Add('Détail');
  RGChoixListe.ComponentIndex := RGChoixListe.ComponentCount;
end;

procedure TFEtatTiers.chercherDansTable(nomBase,table,champ,valeur:string);
begin
  QCherche := TQuery.create(nil);
  QCherche.DatabaseName := nomBase;
  with QCherche do
  begin
    sql.Add('Select * from '+table+' where '+champ+' = ''' + valeur + '''');
    if not QCherche.Prepared then
      QCherche.Prepare;
    open;
  end;
end;

procedure TFEtatTiers.chercherEcheance(id:string);
begin
  QEcheance := TQuery.create(nil);
  QEcheance.DatabaseName := 'Exercice';
  with QEcheance do
  begin
    sql.Add('Select Date from Echeance.DB where ID_Ecriture = ''' + id + '''');
    if not QEcheance.Prepared then
      QEcheance.Prepare;
    open;
  end;
end;

procedure TFEtatTiers.FiltrerTable;
var
  liste :TStringList;
begin
  liste := TStringList.Create;
//  chercherDansTable('Exercice','Ecriture.DB','Tiers',tiers);
  QCherche.first;
  while not QCherche.EOF do
  begin
    liste.add (QCherche.fieldbyname('ID_Piece').asstring);
    QCherche.next;
  end;
  TaPiece.Filtered := false;
  TaPiece.Filter := CreeFiltreOu('ID',[liste]);
  TaPiece.Filtered := true;
  liste.Free;
end;

procedure TFEtatTiers.FormActivate(Sender: TObject);
//var
// registre : TRegistry;
begin
Initialiser_ShortCut_Main(true);  
//   registre := TRegistry.create;
//   try
//     with registre do
//     begin
//       RootKey := HKEY_LOCAL_MACHINE;
//       openKey('\SOFTWARE\LGR\Epicea2\' + self.Name, false);
//       try
//         test := readString('cheminLogo2');
//       except
//         test := '';
//       end;
//     end;
//   finally
//     registre.Free;
//   end;
end;

//******************mettre ds uqreport *********************************
procedure TFEtatTiers.initBtnLogo(Selection: integer);
begin
  if (logoCharge[selection] = false)  then
  begin
    bitBtn1.Caption := '   Charger Logo';
    bitbtn1.Glyph.LoadFromFile('C:\01_nadine\images\Cristaux vides.bmp');
    FEtatTiers.image1.Enabled := false;
  end
  else               // mettre image avec appli...
  begin
    bitBtn1.Caption := '    Sortir Logo';
    bitbtn1.Glyph.LoadFromFile('C:\01_nadine\images\Cristaux bleus.bmp');
    FEtatTiers.image1.Picture.LoadFromFile(TabLogo[2]);
    FEtatTiersDetail.image1.Picture.LoadFromFile(TabLogo[2]);
    FEtatTiers.image1.Enabled := true;
    FEtatTiersDetail.image1.Enabled := true;
  end;
end;
//******************mettre ds uqreport *********************************
procedure TFEtatTiers.chargerLogo;
begin
  case SelectionEtat of
  2:begin// FEtatTiers
      if FEtatTiers.dlg.execute then
      begin
        FEtatTiers.image1.Picture.LoadFromFile(FEtatTiers.dlg.filename);
        FEtatTiers.Image1.Enabled := true;
        logoCharge[SelectionEtat] := true;
//        showmessage(logoCharge[SelectionEtat] + ' chargerLogo');
        TabLogo[SelectionEtat] := FEtatTiers.dlg.FileName;
//        test :=FEtatTiers.dlg.FileName;
        FEtatTiersDetail.Image1.Picture.LoadFromFile(TabLogo[2]);
        FEtatTiersDetail.Image1.Enabled := true;
        initBtnLogo(2);
      end;
    end;
  end;
end;
//******************mettre ds uqreport *********************************
procedure TFEtatTiers.dechargerLogo;
begin
  case SelectionEtat of
  2:begin// FEtatTiers
      FEtatTiers.Image1.Enabled := false;
      FEtatTiersDetail.Image1.Enabled := false;
      logoCharge[SelectionEtat] := false;
      TabLogo[SelectionEtat] := '';
//      test := '';
      initBtnLogo(SelectionEtat);
    end;
  end;
end;
//******************mettre ds uqreport *********************************
procedure TFEtatTiers.BitBtn1Click(Sender: TObject);
begin
  RGChoixListe.Font.Color := clGray;
  RGChoixListe.Color := clInactiveBorder;
  BitBtnVisu.Enabled := false;
  BitBtnPrint.Enabled := false;
  RGLogo.Visible := true;
  RGLogo.ItemIndex := -1;
end;


//***************** test registre ********************************************
//****************************************************************************
procedure TFEtatTiers.FormCreate(Sender: TObject);
begin
  selectionEtat := 2; // test
  QuickRep1.Hide;
  chercherTypesTiers;
  initBtnLogo(SelectionEtat);//test
  actif := false;
end;


//**************** create *************
//// var: registre : TRegistry;
////   registre := TRegistry.create;
////   try
////     with registre do
////     begin
////       RootKey := HKEY_LOCAL_MACHINE;
////       openKey('\SOFTWARE\LGR\Epicea2\' + self.Name, false);
////       try
////         test := readString('cheminLogo2');
////       except
////         test := '';
////       end;
////     end;
////   finally
////     registre.Free;
////   end;

 //********** destroy**************
//// var: registre : TRegistry;
////begin
////   registre := TRegistry.create;
////   try
////     with registre do
////     begin
////       RootKey := HKEY_LOCAL_MACHINE;
////       openKey('\SOFTWARE\LGR\Epicea2\' + self.Name, false);
////       writeString('cheminLogo2',test);
////       closeKey;
////     end;
////   finally
////     registre.Free;
////   end;


procedure TFEtatTiers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// voir pour logo si etat en cours...
end;




end.
