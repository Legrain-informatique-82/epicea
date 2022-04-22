
{*****************************************************************************
 * Unit Name : UQReport                                                      *
 *                                                                           *
 * ---------    UEtatTiers --> FEtatTiers                                    *      *
 *                        --> FEtatTiersDetail                               *                     *
 * Selection : 2 ds UQReport                                                 *
 *                                                                           *
 * FPrint.RGChoixListe.ItemIndex(0) =  tous                                  *
 * FPrint.RGChoixListe.ItemIndex(1) =  clients                               *
 * FPrint.RGChoixListe.ItemIndex(2) =  fournisseurs                          *
 * FPrint.RGChoixListe.ItemIndex(3) =  Personnel                             *
 * FPrint.RGChoixListe.ItemIndex(4) =  associés                              *
 * FPrint.RGChoixListe.ItemIndex(5) =  Débiteurs/Créditeurs Divers           *
 * FPrint.RGChoixListe.ItemIndex(6) =  Etat/Caisses Sociales                 *       *
 * FPrint.RGChoixListe.ItemIndex(7) =  détail                                *
 *                                                                           *
 *****************************************************************************}

unit UQReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,Db, DBTables, Registry, RXCtrls, ExtDlgs,
  Menus,LibSql, ImgList;

type
  TFPrint = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    RGChoixListe: TRadioGroup;
    Panel1: TPanel;
    BtnFermer: TButton;
    BitBtnPrint: TBitBtn;
    BitBtnVisu: TBitBtn;
    BitBtnLogo: TBitBtn;
    P6: TPanel;
    P4: TPanel;
    RBtnLogTous: TRadioButton;
    RBtnSupprTous: TRadioButton;
    P7: TPanel;
    P5: TPanel;
    RBtnLogUn: TRadioButton;
    P1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    P2: TPanel;
    P3: TPanel;
    CBxTous: TCheckBox;
    CBxUn: TCheckBox;
    SpdBtnInitTous: TRxSpeedButton;
    BtnFermerlogo: TButton;
    SpdAutre: TSpeedButton;
    RBtnAutreUn: TRadioButton;
    Dlg: TOpenPictureDialog;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Visualiser1: TMenuItem;
    Imprimer1: TMenuItem;
//*********************  test de fonction (testée mais pas utilisée...)  *******
    function CreateControl(ControlClass: TControlClass;
                      const ControlName: string): TControl;
//******************************************************************************
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnVisuClick(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure BitBtnLogoClick(Sender: TObject);
    procedure ChoixCreate(Selection:integer);
    procedure ChoixVisu(Selection:integer);
    procedure ChoixPrint(Selection:integer);
    procedure choixcledetail(selection:integer);
    procedure initCaption(Selection: integer);
    procedure initBtnLogo(Selection: integer;Affichage: integer);
    procedure GererInitCbxUn;
    procedure InitImage(Selection: integer;chemin: string);
    procedure imageAcces(vrai:boolean);
    procedure chargerLogoDlg;
    procedure EnregistrerTousCheminLogo;
    procedure EnregistrerTousAffichLogo;
    function ExisteTous:boolean;
    procedure LireTousCheminLogo;
    procedure LireTousAffichLogo;
    procedure EnregistrerUnAffichLogo;
    function ExisteUn:boolean;
    procedure LireUnAffichLogo;
    procedure EnregistrerAutreChemin;
    procedure EnregistrerAffichAutreChemin;
    function ExisteAutre:boolean;
    function Difference:boolean;
    procedure LireAutreChemin;
    procedure LireAffichAutreChemin;
    procedure EffacerLogoDefaut;
    procedure EffacerAffichDetail;
    procedure desactiver;
    procedure reactiver;
    procedure supprtous;
    procedure tousOui;
    procedure tousNon;
    procedure AutreOui;
    procedure AutreNon;
    procedure autrerien;
    procedure DetailRien;
    procedure SpdBtnInitTousClick(Sender: TObject);
    procedure CBxTousClick(Sender: TObject);
    procedure RBtnLogTousClick(Sender: TObject);
    procedure RBtnSupprTousClick(Sender: TObject);
    procedure CBxUnClick(Sender: TObject);
    procedure RBtnLogUnClick(Sender: TObject);
    procedure RBtnAutreUnClick(Sender: TObject);
    procedure SpdAutreClick(Sender: TObject);
    procedure BtnFermerlogoClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);

    { Déclarations privées }
  public
    { Déclarations publiques }
    SelectionEtat: integer;
    registre : TRegistry;
    cheminLogo,autrechemin,nomcle: string;
    casAffichage: integer;
    afficherTous,afficherUn,afficherAutre,
    Logo,Autre,verif: boolean;
  end;

var
  FPrint: TFPrint;
implementation
//   UEtatDepensesEnt,
uses
//UEtatTrame,
UEtatTiers, UEtatTiersDetail,{ UEtatChargesRepartir,} UEtatChargeAPayer,
  UEtatRepriseChargeARepartir, UEtatCPConstatesAvance,UEtatRepriseChargeCA,
  UEtatRepriseChargeAPayer2, UEtatProvisions,  UEtatBalance,
  UEtatEmprunt,
//  UEtatStock,
  E2_ChargeRepartir_Isa, E2_ChargesAPayer_Isa,
  E2_ChargesCA_Isa, E2_RepriseChargesCA, E2_RepriseChargeAPayer2_Isa,
  E2_Provisions_Isa, E2_Balancenew, E2_Emprunts_Isa2, E2_Stocks_Isa, E2_Tiers,
  E2_Main, UEtatBalanceNew,DMRecherche,DMDiocEtatBalance;

{$R *.DFM}

//*********************  test de fonction (pas utilisée...)  *******************
function TFPrint.CreateControl(ControlClass: TControlClass;
                                 const ControlName: string): TControl;
begin
  if controlclass = nil then
  begin
    Result := ControlClass.Create(FPrint);
    with Result do
    begin
      Parent := FPrint;
      Name := ControlName;
    end;
  end;
end;
//******************************************************************************

procedure TFPrint.FormCreate(Sender: TObject);
begin
  Label1.Caption:='Impression';
  bitbtnvisu.Caption := 'Visualiser [F9]';
  bitbtnvisu.TabOrder := 1;
  bitbtnPrint.Caption := 'Imprimer [F11]';
  bitbtnPrint.TabOrder := 0;
  bitbtnlogo.TabOrder := 3;
  btnfermer.TabOrder := 4;
end;

procedure TFPrint.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
  initcaption(SelectionEtat);
  if difference = true then
    spdbtninittous.transparent := false;
  LireTousCheminLogo;
  gererInitCbxUn;
   p1.Visible := false;
   p2.Visible := false;
   p3.Visible := false;
   p4.Visible := false;
   p5.Visible := false;
   p6.Visible := false;
   p7.Visible := false;
  case selectionEtat of
    2:begin
//     FEtatTiers.chercherTypesTiers;
//     RGChoixListe.Visible := true;
     end;
    12:begin
     RGChoixListe.Visible := true;
     end;
    1,3..11:begin
     RGChoixListe.Visible := false;
     end;
  end;
end;


procedure TFPrint.FormDeactivate(Sender: TObject);
begin
//  case selectionetat of
////    3: ChargeARepartir_Isa.OnDeactivate := ChargeARepartir_Isa.formDeactivate;
////    4,9: ChargesAPayer_Isa.OnDeactivate :=ChargesAPayer_Isa.formDeactivate; // idem dépenses entreprise
//   // 5: libre
//    6: ChargeCA_Isa.OnDeactivate := ChargeCA_Isa.formDeactivate;
//    7,11: RepriseChargeCA.OnDeactivate := RepriseChargeCA.formDeactivate; // idem repriseChargeAPayer
//    10:Provisions_Isa.OnDeactivate := Provisions_Isa.formDeactivate; // mettre btn sur E2_Provisions_Isa...
////    13:Emprunt_Isa.OnDeactivate := Emprunt_Isa.formDeactivate;
////    14:stocks.OnDeactivate := stocks.formDeactivate;
//  end;

end;

procedure TFPrint.BtnFermerClick(Sender: TObject);
begin
  close;
end;

procedure TFPrint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  selectionEtat := 0;
end;

//*****************************************************************************
procedure TFPrint.BitBtnVisuClick(Sender: TObject);
begin
  ChoixVisu(SelectionEtat);
end;

procedure TFPrint.BitBtnPrintClick(Sender: TObject);
begin
  Choixprint(SelectionEtat);
end;

procedure TFPrint.BitBtnLogoClick(Sender: TObject);
begin
  RGChoixListe.Font.Color := clGray;
  RGChoixListe.Color := clInactiveBorder;
  BitBtnVisu.Enabled := false;
  BitBtnPrint.Enabled := false;
  ChoixCreate(SelectionEtat);
   p1.Visible := true;
   p2.Visible := true;
   p3.Visible := true;
   p4.Visible := true;
   p5.Visible := true;
   p6.Visible := true;
   p7.Visible := true;
   fprint.Height := 283;
   btnFermerLogo.Visible := true;
   btnFermer.Cancel := false;
end;

//************** procedures d'init.choix ***************************************

procedure TFPrint.ChoixCreate(Selection:integer);
begin
  case Selection of
  1:begin
//    if FEtatTrame = nil then
//       FEtatTrame := TFEtatTrame.Create(self);
   end;
  2:begin
//    if FEtatTiers = nil then
//       FEtatTiers := TFEtatTiers.Create(self);
    end;
  3:begin
//    if FEtatChargesRepartir = nil then
//       FEtatChargesRepartir := TFEtatChargesRepartir.Create(self);
    end;
  4,9:begin  // idem dépenses entreprise
       if  FEtatChargeAPayer = nil then
          FEtatChargeAPayer := TFEtatChargeAPayer.Create(self);
     end;
  5:begin
      if FEtatRepriseChargeARepartir = nil then
          FEtatRepriseChargeARepartir := TFEtatRepriseChargeARepartir.create(self);
     end;
  6: begin
      if FEtatCPConstatesAvance = nil then
          FEtatCPConstatesAvance:= TFEtatCPConstatesAvance.Create(self);
     end;
  7,11:begin  // idem repriseChargeAPayer
        if FEtatRepriseChargeCA = nil then
             FEtatRepriseChargeCA := TFEtatRepriseChargeCA.create(self);
     end;
  8: begin
       if FEtatRepriseChargeAPayer2 = nil then
            FEtatRepriseChargeAPayer2 := TFEtatRepriseChargeAPayer2.create(self);
     end;
  10:begin
       if FEtatProvisions = nil then
             FEtatProvisions := TFEtatProvisions.create(self);
     end;
  12:begin
      if FEtatBalanceNew= nil then
            FEtatBalanceNew := TFEtatBalanceNew.create(self);
      if BalanceNew <> nil then
       if BalanceNew.Visible then
        begin
          FEtatBalanceNew.DateDebPeriode:=BalanceNew.EditDebutPer.Date;
          FEtatBalanceNew.DateFinPeriode:=BalanceNew.EditFinPer.Date;
          FiltrageDataSet(DMRech.TaBalanceRech,DMDiocEtatBal.TaBalanceaffich.Filter);
          DMRech.TaBalanceRech.First;
          FEtatBalanceNew.CompteDeb:=DMRech.TaBalanceRech.findField('Compte').AsString;
          DMRech.TaBalanceRech.Last;
          FEtatBalanceNew.CompteFin:=DMRech.TaBalanceRech.findField('Compte').AsString;;
        end;
     end;
  13: begin
       if FEtatEmprunt = nil then
             FEtatEmprunt := TFEtatEmprunt.create(self);
      end;
  14:begin
//   if FEtatStock = nil then
//        FEtatStock := TFEtatStock.create(self);
   end;
  end;
end;

//******************************************************************************

procedure TFPrint.ChoixVisu(Selection:integer);
begin
  ChoixCreate(Selection);
  case Selection of
//  1: FEtatTrame.Visualiser;
//  2:// FEtatTiers.Visualiser;
//  3: FEtatChargesRepartir.visualiser;
  4,9: FEtatChargeAPayer.visualiser; // idem dépenses entreprise
 // 5: libre
  6: FEtatCPConstatesAvance.visualiser;
  7,11: FEtatRepriseChargeCA.visualiser; // idem repriseChargeAPayer
  8: FEtatRepriseChargeAPayer2.visualiser;
  10:FEtatProvisions.visualiser; // mettre btn sur E2_Provisions_Isa...
  12:FEtatBalanceNew.visualiser; //mettre btn sur E2_Balance...
  13:FEtatEmprunt.visualiser;
//  14:FEtatStock.visualiser;
  end;
end;

//******************************************************************************

procedure TFPrint.ChoixPrint(Selection:integer);
begin
  ChoixCreate(Selection);
  case Selection of
//  1: FEtatTrame.imprimer;
//  2: FEtatTiers.imprimer;
//  3: FEtatChargesRepartir.imprimer;
  4,9: FEtatChargeAPayer.imprimer; // idem 'DepensesEntreprise'
//  5: libre
  6: FEtatCPConstatesAvance.imprimer;
  7,11: FEtatRepriseChargeCA.imprimer;//idem 'repriseChargeAPayer'
  8: FEtatRepriseChargeAPayer2.imprimer;
  10:FEtatProvisions.imprimer;// mettre btn sur E2_Provisions_Isa...
  12:FEtatBalance.imprimer;//mettre btn sur E2_Balance...
  13:FEtatEmprunt.imprimer;
//  14:FEtatStock.imprimer;
  end;
end;

//******************************************************************************

procedure TFPrint.choixcledetail(selection:integer);
begin
  case Selection of
  1: nomcle := 'FEtatTrame';
  2: nomcle := 'FEtatTiers';
  3: nomcle := 'FEtatChargesRepartir';
  4: nomcle := 'FEtatChargeAPayer';
//  5: libre
  6: nomcle := 'FEtatCPConstatesAvance';
  7: nomcle := 'FEtatRepriseChargeCA';
  8: nomcle := 'FEtatRepriseChargeAPayer2';
  9: nomcle := 'FEtatDepenseEntreprise';
  10:nomcle := 'FEtatProvisions';
  11: nomcle := 'FEtatRepriseChargeAPayer';
  12:nomcle := 'FEtatBalance';
  13:nomcle := 'FEtatEmprunt';
//  14:nomcle := 'FEtatStock';
  end;
end;

//******************************************************************************
procedure TFPrint.initCaption(Selection: integer);
begin
  case Selection of
    1: self.Caption := 'Etat - Trames de Saisie';
    2: self.Caption := 'Etat - Tiers';
    3: self.Caption := 'Etat - Charges à Répartir';
    4,11: self.Caption := 'Etat - Charges à Payer et Produits à Recevoir';
//    5: self.Caption := libre;
    6,7: self.Caption := 'Etat - Charges et Produits Constatés d''Avance';
    8: self.Caption := 'Etat - Opérations diverses';
    9: self.Caption := 'Etat - Dépenses de l''Entreprise et du Privé';
    10:self.Caption := 'Etat - Provisions';
    12:self.Caption := 'Etat - Balances';
    13:self.Caption := 'Etat - Emprunts';
    14:self.Caption := 'Etat - Stocks';
  end;
end;

//******************        gestion du logo       ******************************
procedure TFPrint.initBtnLogo(Selection: integer;Affichage: integer);
begin
  bitbtnlogo.Glyph := nil;
  ImageList1.GetBitmap(Affichage,bitBtnlogo.Glyph);
  bitBtnlogo.Caption := ' Gerer Logo ';
end;

//******************************************************************************
procedure TFPrint.GererInitCbxUn;
var
  i,mem : integer;
begin
  mem := selectionetat;
  desactiver;
  if cbxtous.checked = true then
  begin
    affichertous := true;
    afficherun := true;
    initbtnlogo(selectionetat,1);
  end
  else
  begin
    affichertous := false;
    afficherun := false;
    afficherautre := false;
    initbtnlogo(selectionetat,0);
  end;
  reactiver;
  for i := 1 to 14 do
  begin
    selectionetat := i;
    if existeun then
      enregistrerunaffichlogo;
    if existeautre then
      enregistreraffichautrechemin;
  end;
  selectionetat := mem;
  enregistrertousaffichlogo;
end;

//******************************************************************************
function TFPrint.Difference:boolean;
var
  i,mem : integer;
begin
  mem := selectionetat;
  result := false;
  for i := 1 to 14 do
  begin
    selectionetat := i;
    if existeautre = true then
    begin
      lireaffichautrechemin;
      if afficherautre = true then
      begin
        result := true;
        selectionetat := mem;
        exit;
      end;
    end
    else
      afficherautre := false;
  end;
  selectionetat := mem;
end;

//******************************************************************************
procedure TFPrint.InitImage(Selection: integer;chemin: string);
begin
  choixCreate(Selection);
  case Selection of
//   1 : FEtatTrame.image1.Picture.LoadFromFile(chemin);
   2 : begin
//  FEtatTiers.image1.Picture.LoadFromFile(chemin);
//  FEtatTiersDetail.Image1.Picture.LoadFromFile(chemin);
       end;
//   3 : FEtatChargesRepartir.image1.Picture.LoadFromFile(chemin);
  4 :  FEtatChargeAPayer.image1.Picture.LoadFromFile(chemin);
  // 5 :
   6 : FEtatCPConstatesAvance.image1.Picture.LoadFromFile(chemin);
   7 : FEtatRepriseChargeCA.image1.Picture.LoadFromFile(chemin);
   8 : FEtatRepriseChargeAPayer2.image1.Picture.LoadFromFile(chemin);
   9 : FEtatChargeAPayer.image1.Picture.LoadFromFile(chemin);
   10: FEtatProvisions.image1.Picture.LoadFromFile(chemin);
   11: FEtatRepriseChargeCA.image1.Picture.LoadFromFile(chemin);
   12: FEtatBalance.image1.Picture.LoadFromFile(chemin);
   13: FEtatEmprunt.image1.Picture.LoadFromFile(chemin);
//   14: FEtatStock.Image1.Picture.LoadFromFile(chemin);
  end;
end;

//******************************************************************************

procedure TFPrint.imageAcces(vrai:boolean);
begin
  choixcreate(selectionetat);
  case SelectionEtat of
//  1: FEtatTrame.Image1.Enabled := vrai;
  2:begin// FEtatTiers
//      FEtatTiers.Image1.Enabled := vrai;
//      FEtatTiersDetail.Image1.Enabled := vrai;
    end;
//  3: FEtatChargesRepartir.Image1.Enabled := vrai;
  4,9: FEtatChargeAPayer.Image1.Enabled := vrai;
//  5:
  6: FEtatCPConstatesAvance.Image1.Enabled := vrai;
  7,11: FEtatRepriseChargeCA.Image1.Enabled := vrai;
  8: FEtatRepriseChargeAPayer2.Image1.Enabled := vrai;
  10:FEtatProvisions.Image1.Enabled := vrai;
  12:FEtatBalance.Image1.Enabled := vrai;
  13:FEtatEmprunt.Image1.Enabled := vrai;
//  14:FEtatStock.Image1.Enabled := vrai;
  end;
end;

//******************************************************************************

procedure TFPrint.chargerLogoDlg;
begin
  case SelectionEtat of
  1: if dlg.execute then
//        FEtatTrame.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
  2:begin// FEtatTiers + FEtatTiersDetail
      if dlg.execute then
      begin
//        FEtatTiers.image1.Picture.LoadFromFile(dlg.filename);
//        FEtatTiersDetail.Image1.Picture.LoadFromFile(dlg.filename);
      end;
    end;
//  3:if dlg.execute then
//        FEtatChargesRepartir.image1.Picture.LoadFromFile(dlg.filename)
//      else
//      dlg.FileName := '';
  4:if dlg.execute then
      FEtatChargeAPayer.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
  5:begin //etat libre
// annulé...
    end;
  6:if dlg.execute then
      FEtatCPConstatesAvance.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
  7:if dlg.execute then
      FEtatRepriseChargeCA.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
  8:if dlg.execute then
      FEtatRepriseChargeAPayer2.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
  9:if dlg.execute then
      FEtatChargeAPayer.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
  10:if dlg.execute then
       FEtatProvisions.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
  11:if dlg.execute then
      FEtatRepriseChargeCA.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
  12:begin //balance +...
      if dlg.execute then
        FEtatBalance.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
     end;
  13:if dlg.execute then
      FEtatEmprunt.image1.Picture.LoadFromFile(dlg.filename)
      else
      dlg.FileName := '';
//  14:if Dlg.Execute then
//       FEtatStock.Image1.Picture.LoadFromFile(dlg.filename)
//      else
//      dlg.FileName := '';
  end;
  dlg.InitialDir := dlg.FileName;
  if logo = true then
    cheminlogo := dlg.FileName;
  if autre = true then
    autrechemin := dlg.FileName;
  logo := false;
  autre := false;
end;

//************************  registre : *****************************************

//******************* logo par défaut  *****************************************

procedure TFPrint.EnregistrerTousCheminLogo;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  NomDossier := 'testLogo';
  registre := TRegistry.create;
  try
  with registre do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    if openKey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\LogoDefaut', true)then
    begin
      writeString('LogoDefaut',cheminLogo);
      closeKey;
    end
    else
    begin
      showmessage('Problème d''enregistrement');
    end;
  end;
  finally
    registre.Free;
    cheminLogo :='';
  end;
end;

procedure TFPrint.EnregistrerTousAffichLogo;
var
  registre : TRegistry;
  NomDossier  : string; 
begin
  NomDossier := 'testLogo';
  registre := TRegistry.create;
  try
  with registre do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    if openKey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\LogoDefaut\AfficheTous', true)then
    begin
      writeBool('afficheTous',affichertous);
      closeKey;
    end
    else
    begin
      showmessage('Problème d''enregistrement');
    end;
  end;
  finally
    registre.Free;
  end;
end;

function TFPrint.ExisteTous:boolean;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  choixcledetail(selectionetat);
  result := false;
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      if keyexists('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\LogoDefaut') then
        result := true;
      registre.Free;
    end;
  except
    showmessage('Problème à la lecture du Registre.');
  end;
end;

procedure TFPrint.LireTousCheminLogo;
var
  registre : TRegistry;
  NomDossier  : string;    
  begin
  desactiver;
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  try
    with registre do
    begin
      if cbxtous.AllowGrayed = true then
        SpdBtnInitTous.transparent := false;       
      RootKey := HKEY_LOCAL_MACHINE;
      if openKey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\LogoDefaut', false) then
      begin
        cheminlogo := ReadString('LogoDefaut');
        closeKey;
        if cheminlogo <> '' then
        begin
          cbxtous.Enabled := true;
          choixcreate(selectionetat);
          initimage(selectionetat,cheminlogo); 
          liretousaffichlogo;
          if existeun then
            lireunaffichlogo
          else
            if existeautre then
              lireautrechemin;
        end
        else  //vide
        begin
          cbxtous.Enabled := false;
          affichertous := false; // pas d'affichage à regarder
          supprtous;
          detailrien;
          imageacces(false);
          effacerAffichdetail;
          initbtnlogo(selectionetat,0);
          if existeautre then
            lireautrechemin;  // on regarde si autre...
        end;
      end
      else   // pas de clef existante:
      begin
          cbxtous.Enabled := false;
          affichertous := false; // pas d'affichage à regarder
          supprtous;
          detailrien;
          imageacces(false);
          effacerAffichdetail;
          initbtnlogo(selectionetat,0);
          if existeautre then
            lireautrechemin;  // on regarde si autre...
      end;
    end
  except
  end;
  reactiver;
  registre.free;
  cheminlogo := '';
end;

procedure TFPrint.LireTousAffichLogo;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  desactiver;
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      openKey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\LogoDefaut\AfficheTous', false);
      affichertous := ReadBool('AfficheTous');
      closeKey;
    end
  except
    begin
      affichertous := false;
      initbtnlogo(selectionetat,0);
    end;
  end;
  registre.free;
  if affichertous = true then
  begin
    tousoui;
    choixCreate(selectionEtat);
    imageacces(true);
    initbtnlogo(selectionetat,1);
  end
  else // affichertous = false
  begin
    tousnon;
    initbtnlogo(selectionetat,0);
    imageacces(false);
  end ;
  reactiver;
end;

//******************** gestion pour un etat donné  *****************************

procedure TFPrint.EnregistrerUnAffichLogo;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  NomDossier := 'testLogo';
  registre := TRegistry.create;
  choixcledetail(selectionetat);
  try
  with registre do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    choixcledetail(i);
    openKey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AfficheDetail\'+nomcle, true);
    writeBool('AfficheUn',afficherUn);
    closeKey;
  end
  except
  begin
    showmessage('Problème d''enregistrement');
  end;
  end;
  registre.Free;
end;

function TFPrint.ExisteUn:boolean;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  choixcledetail(selectionetat);
  result := false;
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      if keyexists('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AfficheDetail\'+nomcle) then
      result := true;
      registre.Free;
    end;
  except
    showmessage('Problème à la lecture du Registre.');
  end;
end;

procedure TFPrint.LireUnAffichLogo;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  desactiver;
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  choixcreate(selectionetat);
  choixcledetail(selectionetat);
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      if openkey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AfficheDetail\'+nomcle,false) then
      begin
        afficherun := ReadBool('AfficheUn');
        closeKey;
        if afficherUn = true then
        begin
          desactiver;
          cbxun.checked := true;
          reactiver;
          imageacces(true);
          initbtnlogo(selectionetat,1);
          if verif = false then
            if spdbtninittous.Transparent = false then
              if existeautre then lireautrechemin;
        end
        else  //on affiche pas
        begin
          initbtnlogo(selectionetat,0);
          imageacces(false);
          cbxun.checked := false;
          if existeautre then
            lireautrechemin;
        end;
      end
      else  // pas de clef : gerer avec tous...
      begin
        imageacces(false);
        initbtnlogo(selectionetat,0);
        afficherun := affichertous;
        if afficherUn = true then
        begin
          imageacces(true);
          initbtnlogo(selectionetat,1);
        end
        else  //on affiche pas
        begin
          initbtnlogo(selectionetat,0);
          imageacces(false);
          cbxun.checked := false;
          if existeautre then
            lireautrechemin;
        end; 
      end;
    end;
  except
  begin
    afficherun := false;
    initbtnlogo(selectionetat,0);
    cbxun.checked := false;
  end;
  end;
  registre.Free;
  reactiver;
end;


procedure TFPrint.EnregistrerAutreChemin;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  NomDossier := 'testLogo';
  registre := TRegistry.create;
  choixcledetail(selectionetat);
  try
  with registre do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    choixcledetail(selectionetat);
    openKey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AutreLogo\'+nomcle, true);
    writeString(nomcle,autrechemin);
    closeKey;
  end
  except
    showmessage('Problème d''enregistrement');
  end;
  registre.Free;
  autrechemin := '';
end;

procedure TFPrint.EnregistrerAffichAutreChemin;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  NomDossier := 'testLogo';
  registre := TRegistry.create;
  choixcledetail(selectionetat);
  try
  with registre do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    choixcledetail(selectionetat);
    openKey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AutreLogo\Affiche\'+nomcle, true);
    writeBool('AfficheUn',afficherAutre);
    closeKey;
  end
  except
    showmessage('Problème d''enregistrement');
  end;
  registre.Free;
end;

function TFPrint.ExisteAutre:boolean;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  choixcledetail(selectionetat);
  result := false;
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      if keyexists('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AutreLogo\'+nomcle) then
        result := true;
      registre.Free;
    end;
  except
    showmessage('Problème à la lecture du Registre.');
  end;
end;

procedure TFPrint.LireAutreChemin;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  choixcreate(selectionetat);
  choixcledetail(selectionetat);
  desactiver;
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      if openkey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AutreLogo\'+nomcle,false) then
      begin
        autrechemin := ReadString(nomcle);
        closeKey;
        if autrechemin <>'' then
        begin
          initimage(selectionetat,autrechemin);
          lireaffichautrechemin;
        end
        else  // c'est vide !
        begin
          autrerien;
          initbtnlogo(selectionetat,0);
        end;
      end
      else  // pas de clef
      begin
        initbtnlogo(selectionetat,0);
        imageacces(false);
        autrerien;
      end;
    end;
  finally
  registre.Free;
  autrechemin := '';
  reactiver;
  end;
end;

procedure TFPrint.LireAffichAutreChemin;
var
  registre : TRegistry;
  NomDossier  : string;
begin
  desactiver;
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  choixcreate(selectionetat);
  choixcledetail(selectionetat);
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      if openkey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AutreLogo\Affiche\'+nomcle,false) then
      begin
        afficherautre := ReadBool('AfficheUn');
        closeKey;
        if afficherautre = true then
        begin
          imageacces(true);
          spdbtninittous.Transparent := false;
          autreoui;
          initbtnlogo(selectionetat,1);
        end
        else  //on affiche pas
        begin
          imageacces(false);        
          autrenon;
          initbtnlogo(selectionetat,0);
        end;
      end;
    end;
    except
    begin
      afficherautre := false;
      initbtnlogo(selectionetat,0);
    end;
    end;
  registre.Free;
  reactiver;
end;

procedure TFPrint.EffacerLogoDefaut;
var
  registre : TRegistry;
  NomDossier: string;
begin
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      deletekey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\LogoDefaut')
    end;
  finally
    registre.Free;
  end;
end;


procedure TFPrint.EffacerAffichDetail;
var
  registre : TRegistry;
  NomDossier: string;
begin
  registre := TRegistry.create;
  NomDossier := 'testLogo';
  try
    with registre do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      deletekey('\SOFTWARE\LGR\Epicea2\' + NomDossier + '\AfficheDetail');
    end;
  finally
    registre.Free;
  end;
end;


//******************  visuels des <> logos *************************

procedure TFPrint.desactiver;
begin
  cbxtous.OnClick := nil;
  rbtnlogtous.OnClick := nil;
  rbtnsupprtous.OnClick := nil;
  cbxun.OnClick := nil;
  rbtnlogun.OnClick := nil;
  rbtnautreun.OnClick := nil;
end;

procedure TFPrint.reactiver;
begin
  cbxtous.OnClick := cbxtousclick;
  rbtnlogtous.OnClick := rbtnlogtousclick;
  rbtnsupprtous.OnClick := rbtnsupprtousClick;
  cbxun.OnClick := cbxunClick;
  rbtnlogun.OnClick := rbtnlogunClick;
  rbtnautreun.OnClick := rbtnautreunClick;
end;

procedure TFPrint.supprtous;
begin
  desactiver;
  cbxtous.state := cbUnchecked;
  rbtnlogtous.checked := false;
  rbtnsupprtous.checked := true;
  reactiver;
end;

procedure TFPrint.tousOui;
begin
  desactiver;
  Rbtnlogtous.Checked := true;
  Rbtnlogun.Checked := true;
  rbtnsupprtous.checked := false;
  cbxtous.checked := true;
  cbxun.checked := true;
  reactiver;
end;

procedure TFPrint.tousnon;
begin
  desactiver;
  Rbtnlogtous.Checked := true;
  Rbtnlogun.Checked := true;
  rbtnsupprtous.checked := false;
  cbxtous.checked := false;
  cbxun.checked := false;
  reactiver;
end;

procedure TFPrint.AutreOui;
begin
  desactiver;
  RbtnAutreun.checked := true;
  cbxun.checked := true;
  reactiver;
end;

procedure TFPrint.AutreNon;
begin
  desactiver;
  RbtnAutreun.checked := true;
  cbxun.checked := false;
  reactiver;
end;

procedure TFPrint.autrerien;
begin
  desactiver;
  RbtnAutreun.checked := false;
  cbxun.checked := false;
  reactiver;
end;

procedure TFPrint.detailrien;
begin
  desactiver;
  RbtnLogun.checked := false;
  rbtnautreun.checked := false;
  cbxun.Checked := false;
  reactiver;
end;

//************* tous les etats *************************************************
procedure TFPrint.SpdBtnInitTousClick(Sender: TObject);
var
  i,mem : integer;
begin
  if spdbtninittous.Transparent = false then
  begin
    mem := selectionetat;
    for i := 1 to 14 do
    begin
      selectionetat := i;
      afficherautre := false;
      enregistreraffichautrechemin;
      lireaffichautrechemin;
      desactiver;
      if RBtnLogTous.Checked = true then
      begin
        RBtnLogun.Checked := true;
        verif := true;
        afficherun := true;
        enregistrerunaffichlogo;
        cbxun.checked := true;         
      end
      else
        rbtnlogun.Checked := false;
      reactiver;
      spdbtninittous.Transparent := true;
      cbxtous.AllowGrayed := false;
    end;
    selectionetat := mem;
    liretouscheminlogo;
    lireunaffichlogo;
  end;
end;

procedure TFPrint.CBxTousClick(Sender: TObject);
begin   
  if cbxtous.checked = true then
    affichertous := true
  else    // vbxtous.checked = false
    affichertous := false ;
  enregistrertousaffichlogo;
  gererinitcbxun;
  liretouscheminlogo;   
end;

procedure TFPrint.RBtnLogTousClick(Sender: TObject);
begin
  if RBtnLogTous.Checked = true then
  begin
    cbxtous.Enabled := true;
    rbtnlogun.Enabled := true;
    logo := true;
    chargerlogodlg;
    if cheminlogo <> '' then
    begin
      enregistrertouscheminlogo;
      affichertous := true;
      casaffichage := 1;
      enregistrertousaffichlogo;
      liretouscheminlogo;
      gererInitCbxUn;
    end
    else
    begin
      cbxtous.Enabled := false;
      rbtnlogun.Enabled := false;
      logo := false;
    end;
  end;
end;


procedure TFPrint.RBtnSupprTousClick(Sender: TObject);
begin
  cheminlogo :='';
  affichertous := false;
  casaffichage := 0;
  initbtnlogo(selectionEtat,casaffichage);
  effacerlogodefaut;
  effaceraffichdetail;
  rbtnlogun.Enabled := false;
  SpdBtnInitTous.transparent := true;
  supprtous;
  detailrien;
  imageacces(false);
  cbxtous.enabled := false;
  if existeautre then
    lireautrechemin;
end;

//****************** etat en cours *********************************************
  
procedure TFPrint.CBxUnClick(Sender: TObject);
begin
  if (rbtnautreun.checked = false) and (rbtnlogun.checked = false) then
  begin
    cbxun.state := cbunchecked;
    imageacces(false);
    initbtnlogo(selectionetat,0);
  end;
  if cbxun.state = cbChecked then
  begin
    if rbtnlogun.checked = true then
    begin
      afficherun := true;
      enregistrerunaffichlogo;
      
      liretouscheminlogo;
      lireunaffichlogo;

      desactiver;
      cbxun.state := cbchecked;
      rbtnautreun.checked := false;
      reactiver;
    end;
    if rbtnautreun.checked = true then
    begin
      cbxtous.AllowGrayed := true;
      afficherautre := true;
      enregistreraffichautrechemin;
      lireautrechemin;
      desactiver;
      cbxun.state := cbchecked;
      rbtnlogun.checked := false;
      reactiver;
    end;
    initbtnlogo(selectionetat,1);
    imageacces(true);
  end
  else
  begin  // on désaffiche :
    if rbtnautreun.checked = true then
    begin
      afficherautre := false;
      enregistreraffichautrechemin;
    end;
    initbtnlogo(selectionetat,0);
    imageacces(false);
  end
end;

procedure TFPrint.RBtnLogUnClick(Sender: TObject);
begin
  desactiver;
  if existetous = true then
     rbtnlogun.Enabled := true
  else
  begin
     rbtnlogun.Enabled := false;
     rbtnlogun.Checked := false;
     exit;
  end;
  verif := true;
  afficherun := true;
  afficherautre := false;
  enregistrerunaffichlogo;
  enregistreraffichautrechemin;
  if difference = true then
  begin
    spdbtninittous.transparent := false;
    cbxtous.AllowGrayed := true;
  end
  else
  begin
    spdbtninittous.transparent := true;
    cbxtous.AllowGrayed := false;
  end;
  liretouscheminlogo;
  lireunaffichlogo; 
  rbtnautreun.Checked := false;
  rbtnlogun.checked := true;
  reactiver;
end;
 
procedure TFPrint.RBtnAutreUnClick(Sender: TObject);
begin
  if existeautre then
  begin
    cbxtous.AllowGrayed := true;
    SpdBtnInitTous.transparent := false;
    afficherautre := true;
    enregistreraffichautrechemin;
    lireautrechemin;
    desactiver;
    rbtnautreun.Checked := true;
    reactiver;
    verif := false;
  end
  else
  begin
    rbtnautreun.checked := false;
    verif := true;
    if existetous then
    begin
      desactiver;
      rbtnlogun.checked := true;       
      reactiver;
    end;
  end;
end;

procedure TFPrint.SpdAutreClick(Sender: TObject);
begin
  autre := true;
  chargerlogodlg;
  if autrechemin <> '' then
  begin
    verif := false;
    enregistrerautrechemin;
    afficherautre := true;
    enregistreraffichautrechemin;
    lireautrechemin;
  end
  else
    autre := false;
end;

//******************************************************************************
procedure TFPrint.BtnFermerlogoClick(Sender: TObject);
begin
  Fprint.Height := 255;
  RGChoixListe.Font.Color := clwhite;
  RGChoixListe.Color := clblue;
  BitBtnVisu.Enabled := true;
  BitBtnPrint.Enabled := true;
   p1.Visible := false;
   p2.Visible := false;
   p3.Visible := false;
   p4.Visible := false;
   p5.Visible := false;
   p6.Visible := false;
   p7.Visible := false;
   btnFermerLogo.Visible := false;
   btnFermer.Cancel := true;
end;




end.

