unit E2_ConfirmImport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,LibZoneSaisie, RXCtrls, Grids, DBGrids, RXDBCtrl,
  ExRxDBGrid, GrDBGrid,LibSQL,LibRessourceString,E2_Librairie_Obj, RXSlider,
  ComCtrls,LibFichRep, Menus,GR_Librairie_Obj,DMConstantes,
  DMInitTablesEpi,
  LibGestionParamXML,
  E2_RechercheBD;

Const
Max_Et_Value=10; // Correspond au Nombre total de ligne dans module d'import
C_BtnCompBal_Caption1='Balance Module';
C_BtnCompBal_Caption2='Résultats Module';

type
  TConfirmImport = class(TForm)
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    PaFond: TPanel;
    PaListeImport: TPanel;
    PaSousGrille: TPanel;
    PaListe: TPanel;
    PaPTitre: TPanel;
    PaResultImport: TPanel;
    RxSliderImport: TRxSlider;
    PaListeVisu: TPanel;
    ListViewResult: TListView;
    PaListeRappImport: TPanel;
    RxChBImports: TRxCheckListBox;
    BtnCompBal: TButton;
    PaGrille: TPanel;
    DBCompareBalance: TGrDBGrid;
    PopupMenu1: TPopupMenu;
    Importer1: TMenuItem;
    Annuler1: TMenuItem;
    vidertables1: TMenuItem;
    ChViderTable: TCheckBox;
    BtnVerouillage: TButton;
    ForcerFinImport1: TMenuItem;
    Imprimer1: TMenuItem;
    BtnVerifier: TButton;
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaListeRappImportClick(Sender: TObject);
    procedure InitIndicateurAvancement;
    procedure PaSousGrilleResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);

    procedure BtnCompBalImmosClick(Sender: TObject);
    procedure BtnCompBalImmosClickInv(Sender: TObject);

    procedure BtnCompBalStockClick(Sender: TObject);
    procedure BtnCompBalStockClickInv(Sender: TObject);

    procedure BtnCompBalCaRepClick(Sender: TObject);
    procedure BtnCompBalCaRepClickInv(Sender: TObject);

    procedure BtnCompBalChAPayerClick(Sender: TObject);
    procedure BtnCompBalChAPayerClickInv(Sender: TObject);

    procedure BtnCompBalPrARecevClick(Sender: TObject);
    procedure BtnCompBalPrARecevClickInv(Sender: TObject);

    procedure BtnCompBalChCAClick(Sender: TObject);
    procedure BtnCompBalChCAClickInv(Sender: TObject);

    procedure BtnCompBalPrCAClick(Sender: TObject);
    procedure BtnCompBalPrCAClickInv(Sender: TObject);

    procedure BtnCompBalProvisClick(Sender: TObject);
    procedure BtnCompBalProvisClickInv(Sender: TObject);

    procedure RxChBImportsClickCheck(Sender: TObject);
    procedure DBCompareBalanceDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Importer1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure vidertables1Click(Sender: TObject);
    procedure BtnCompBalClick(Sender: TObject);
    procedure BtnVerouillageClick(Sender: TObject);
    procedure DBCompareBalanceDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ForcerFinImport1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure BtnVerifierClick(Sender: TObject);
  private
    { Déclarations privées }
         EncoreErreurImport : Boolean;
         RepImportDejaValide: Boolean;
  public
    { Déclarations publiques }
  end;

var
  ConfirmImport: TConfirmImport;
  Vider_La_Table:boolean;

implementation

uses  DMPointages2, DMStocks, DMBaseDonnee, E2_InitTableEpi,
  DMChargesAPayer, DMChargesCA, DMProvision, DMChargesRepartir, DMPiece,
  DMTTVA, DMImmosOuverture,DMImportation, DMPlanCpt, DMTVA, DMJournaux,
  DMTier, E2_Main, DMDiocEtatBalance, DMRecherche, E2_VisuListeView,E2_Decl_Records,
  E2_Stocks_Isa, DB;

{$R *.DFM}

procedure TConfirmImport.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnCompBal,BtnVerifier,BtnVerouillage],PaBtn,120,0);
ChViderTable.Left:=BtnCompBal.Left+BtnVerouillage.Width + BtnCompBal.Width+20;
end;

procedure TConfirmImport.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TConfirmImport.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TConfirmImport.BtnEnregistrerClick(Sender: TObject);
var
ListeFichier:TStringList;
i:integer;
ImportPossible,AffichMessage:Boolean;
NotifyEvent:TNotifyEvent;
StrTmp:String;
ParamDMStocks:TParamDMStocks;
ParamDMChargeRepartir:TParamDMChargeRepartir;
ParamDMProvision:TParamDMProvision;
ParamDMChargeCA:TParamDMChargeCA;
ParamDMChargeAPayer:TParamDMChargeAPayer;

//ResultChoisirRep:TResultChoisirRep;
//ParamChoixRep:TParamChoixRep;
begin
if not RepImportDejaValide then
 begin
   E.RepertoireImportCourante := E.RepertoireImportationEpiDos;
   RepImportDejaValide:=ChoisirRepImportation(E.RepertoireImportCourante,'Epicéa2 DOS');
   if RepImportDejaValide then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
//  ParamChoixRep.RepDefaut := IncludeTrailingPathDelimiter(E.RepertoireImportEPI_DOS);
//  ParamChoixRep.TitreForm :='Emplacement du dossier à importer.';
//  ResultChoisirRep:=ChoisirRepertoire(ParamChoixRep);
//  if ResultChoisirRep.Retour then
//   begin
//    E.RepertoireImportEPI_DOS := IncludeTrailingPathDelimiter(ResultChoisirRep.RepChoisi);
//    RepImportDejaValide := true;
////    showmessage(E.RepertoireImportEPI_DOS);
//   end
//   else
//   begin
//    MessageDlg('Importation abandonnée !', mtWarning, [mbOK], 0);
//    abort;
//   end;
 end;
try
//  Vider_La_Table:=ChViderTable.Checked;//isa le 29/08/03 pour vider les tables à importer quand on ne veut pas importer
  //le plan comptable
  if DMImport.DaResultImport <> nil then
     if DMImport.DaResultImport.DataSet = DMImport.TaResultImport then
          DMImport.DaResultImport.DataSet := nil;
  DBCompareBalance.OnDrawColumnCell:=nil;
  BtnCompBal.Caption := C_BtnCompBal_Caption1;
  BtnCompBal.Enabled := False;
  InitIndicateurAvancement;
  ImportPossible:=False;
  for i:=0 to RxChBImports.Items.Count -1 do
   if RxChBImports.Checked[i] then ImportPossible:=true;

    AffichMessage:=(ImportPossible and (BtnEnregistrer.Tag=1) and RxChBImports.Checked[0]);
    if AffichMessage then
      if Messagedlg(PChar('Attention !!!'+
                          RetourChariotDouble+
                          'L''importation de l''ouverture d''Epicéa-2 DOS '+
                          RetourChariotDouble+
                          'va écraser toutes les données présentes dans votre dossier.'+
                          RetourChariotDouble+
                          'Êtes-Vous sûr de vouloir continuer ?'
                          ),mtconfirmation, [mbno,mbyes],0) = mrno then abort;

    if DMImport = nil then DMImport:=TDMImport.Create(Application.MainForm);

    // Importation du plan comptable
   if RxChBImports.Checked[0] then
    begin
  //    RxSliderImport.Value := 9;
      case BtnEnregistrer.Tag of
         1:Begin
            Screen.Cursor := crHourGlass;
            if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
            DMPlan.TaPlanMaintS.Open;
            DMImport.Import_Plan_Entier(DMPlan.TaPlanMaintS,TRue);
           // Vider_La_Table:=false;
            DMPlan.GestionDesComptesObligatoireDsPlanCpt(true);
            //rajout des taux par défaut
            DMPlan.MiseAJourTauxParDefaut;
            GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMPlan.TaPlanMaintS,
                             ['Compte','Libellé','Un1','Un2','Code Tva','Sens Crédit','Coll.','Rapp.','Immo.','Pointable'],
                             ['Compte','Libelle','Un1','Un2','TvaCode','TvaDebit','Collectif','Rapprochement','Immobilisation','Pointable']
                             ,E.FormatMonnaie,E.EditFormat);

            ListViewResult.Items.Clear;
            DMImport.AffichRapportImport(nil,ListViewResult);
            PaResultImport.Caption := 'Résultat de l''importation du Plan Comptable';
            //DMImport.AffichRapportImport(ListeFichier,ListViewResult);
            //ChampTableVersVarListe('Compte',DMPlan.TaPlanMaintS,DMImport.ListeFiltreCompteBilanOuverture);
            BtnEnregistrer.Tag :=2;
            Screen.Cursor := crDefault;
            FormateTailleColonne(DBCompareBalance,22,[2,6,1,1,2,2,2,1,1,1]);
           End;
         2:Begin
            // Importation des codes Tva
            Screen.Cursor := crHourGlass;
            if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(Application.MainForm);
            DMTVACode.TaTvaCode.Open;
            DMImport.Import_CodeTva(DMTVACode.TaTvaCode,TRue);
            GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMTVACode.TaTvaCode,
                             ['Classe','Code Tva','Libellé','Compte','Taux Mini','Taux Maxi'],
                             ['Classe','TvaCode','Libelle','Compte','Taux_inf','Taux_supp']
                             ,E.FormatMonnaie,E.EditFormat);
            DMTVACode.TaTvaCode.EnableControls;
            ListViewResult.Items.Clear;
            DMImport.AffichRapportImport(nil,ListViewResult);
            PaResultImport.Caption := 'Résultat de l''importation des Codes TVA';
            BtnEnregistrer.Tag :=3;
            Screen.Cursor := crDefault;
            FormateTailleColonne(DBCompareBalance,14,[1,2,2,5,1,1]);
           End;
         3:Begin
            // Importation des Journaux
            Screen.Cursor := crHourGlass;
            if DMJournal = nil then DMJournal:=TDMJournal.Create(Application.MainForm);
            DMJournal.TaJournal.Open;
            DMImport.Import_Journaux(DMJournal.TaJournal,TRue);
            GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMJournal.TaJournal,
                             ['Journal','Code Journal','Compte','Libellé court','Libellé'],
                             ['Journal','Code','Compte','Libelle_model','Libelle']
                             ,E.FormatMonnaie,E.EditFormat);
            DMJournal.TaJournal.EnableControls;
            ListViewResult.Items.Clear;
            DMImport.AffichRapportImport(nil,ListViewResult);
            PaResultImport.Caption := 'Résultat de l''importation des Journaux';
            BtnEnregistrer.Tag :=1;
            RxChBImports.Checked[0] := False;
            Screen.Cursor := crDefault;
            DBCompareBalance.ColWidths[1]:=(DBCompareBalance.Width) div 11;
            DBCompareBalance.ColWidths[2]:=(DBCompareBalance.Width) div 11;
            DBCompareBalance.ColWidths[3]:=(DBCompareBalance.Width) div 11;
            DBCompareBalance.ColWidths[4]:=((DBCompareBalance.Width) div 11)*2;
            DBCompareBalance.ColWidths[5]:=((DBCompareBalance.Width) div 11)*5;
           End;
      end;


    end;
  //  // Importation des Tiers !
   if ((RxChBImports.Checked[1]) and (RxSliderImport.Value = 9)) then
    begin
      Screen.Cursor := crHourGlass;
      if DMTiers = nil then DMTiers:=TDMTiers.Create(Application.MainForm);
      DMTiers.Tag := 1; // Initialisation du tag pour les tiers
      DMTiers.TaTiersGest.AfterScroll := nil;
      DMTiers.daTiersGest.OnStateChange := nil;
      DMImport.Import_Tiers(DMTiers.TaTiersGest,True);
      GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMTiers.TaTiersGest,
                       ['Tiers','Nom','Compte','Type'],
                       ['Tiers','Nom','Compte','Type']
                       ,E.FormatMonnaie,E.EditFormat);
      DMTiers.TaTiersGest.EnableControls;
      ListViewResult.Items.Clear;
      DMImport.AffichRapportImport(nil,ListViewResult);
      PaResultImport.Caption := 'Résultat de l''importation du Plan Auxiliaire';
      RxChBImports.Checked[1] := False;
      Screen.Cursor := crDefault;
      DBCompareBalance.ColWidths[1]:=((DBCompareBalance.Width) div 13)*2;
      DBCompareBalance.ColWidths[2]:=((DBCompareBalance.Width) div 13)*6;
      DBCompareBalance.ColWidths[3]:=((DBCompareBalance.Width) div 13)*2;
      DBCompareBalance.ColWidths[4]:=((DBCompareBalance.Width) div 13);
      Screen.Cursor := crHourGlass;
      DMImport.Import_Trame(nil,true,'');
      Screen.Cursor := crDefault;
    end;



  //  // Importation des immo ouverture !
   if ((RxChBImports.Checked[2]) and (RxSliderImport.Value = 8)) then
    begin
      Screen.Cursor := crHourGlass;
      if DMImmos_Ouverture = nil then DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);
      DMImmos_Ouverture.taDetailImmo.MasterFields := ''; // PB
      DMImmos_Ouverture.taDetailImmo.MasterSource :=nil; // PB
      DMImport.Import_Immo(DMImmos_Ouverture.taDetailImmo,True);
      GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImmos_Ouverture.taDetailImmo,
                       ['Compte','Code','Sous Code','Libellé','Date Achat','Valeur à Amortir','Type'],
                       ['Compte','Code','Sous_Code','Libelle','Date_Achat','Valeur_a_Amortir','Type_Amt']
                       ,E.FormatMonnaie,E.EditFormat);
      ListViewResult.Items.Clear;
      DMImport.AffichRapportImport(nil,ListViewResult);
      PaResultImport.Caption := 'Résultat de l''importation des Immobilisations d''ouverture';
      BtnCompBal.Enabled := true;
      BtnCompBal.OnClick:=BtnCompBalImmosClick;
      RxChBImports.Checked[2] := False;
      Screen.Cursor := crDefault;
      FormateTailleColonne(DBCompareBalance,27,[3,2,2,7,4,4,4]);
      ReEnableControls(DMImmos_Ouverture.taDetailImmo);
    end;

  //  // Importation des stocks d'ouverture !
   if ((RxChBImports.Checked[3]) and (RxSliderImport.Value = 7)) then
    begin
     ParamDMStocks.StocksDataStateChange := nil;
     ParamDMStocks.Quand := C_Ouverture;
     ParamDMStocks.GEstInterfaceEvent := nil;
     InitialiseDMStocks(ParamDMStocks);
     Screen.Cursor := crHourGlass;
     DMImport.Import_Stocks(DMStock.TaStock,True);

  //    if DMStock = nil then DMStock:=TDMStock.Create(Application.MainForm);
  //    DMStock.Tag := 1; // Initialisation du tag pour les stocks à l'ouverture
  //    DMImport.Import_Stocks(DMStock.TaStock,True);
  //    ChampTableVersVarListe('Compte',DMStock.TaStock,DMImport.ListeFiltreCompteBilanOuverture);
  //    DMStock.TaStock.EnableControls;

//     Main.Monofenetrage :=true;
//     Main.Stoks1Click(Main.Stoks1);
//     Main.Monofenetrage := ParamUtil.MonoFenetre;
     ListViewResult.Items.Clear;
     DMImport.AffichRapportImport(nil,ListViewResult);
     PaResultImport.Caption := 'Résultat de l''importation des Stocks';
     RxChBImports.Checked[3] := False;
     Screen.Cursor := crDefault;
     BtnCompBal.Enabled := true;
     BtnCompBal.OnClick:=BtnCompBalStockClick;
     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMStock.TaStock,
                      ['Compte','Désignation','Quantité','Prix Unitaire','Décote','Montant Total HT'],
                      ['Compte','Designation','Qte','Prix_Unitaire','Decote','MontantTotalHT']
                      ,E.FormatMonnaie,E.EditFormat);
     FormateTailleColonne(DBCompareBalance,14,[2,3,1,2,2,2]);
     ReEnableControls(DMStock.TaStock);
    end;
  //
  //  // Importation des Charges à répartir
   if ((RxChBImports.Checked[4]) and (RxSliderImport.Value = 6)) then
    begin
     ParamDMChargeRepartir.ChargeARepartirDataStateChange := nil;
     ParamDMChargeRepartir.Quand := C_Ouverture;
     ParamDMChargeRepartir.GEstInterfaceEvent := nil;
     InitialiseDMChargeARepartir(ParamDMChargeRepartir);
     Screen.Cursor := crHourGlass;

     DMImport.Import_ChARepartir(DMChargeRepartir.TaCar,True);

  //    if DMChargeRepartir = nil then DMChargeRepartir:=TDMChargeRepartir.Create(Application.MainForm);
  //    DMChargeRepartir.Tag := 1; // Initialisation du tag pour les Charges à répartir à l'ouverture
  //    DMImport.Import_ChARepartir(DMChargeRepartir.TaCar,False);
  //    ChampTableVersVarListe('Compte',DMChargeRepartir.TaCar,DMImport.ListeFiltreCompteBilanOuverture);
  //    DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);

//     Main.Monofenetrage :=true;
//     Main.Chargesrpartir1Click(Main.Chargesrpartir1);
//     Main.Monofenetrage := ParamUtil.MonoFenetre;

     ListViewResult.Items.Clear;
     DMImport.AffichRapportImport(nil,ListViewResult);
     PaResultImport.Caption := 'Résultat de l''importation des Charges à Répartir';
     RxChBImports.Checked[4] := False;
     Screen.Cursor := crDefault;
     BtnCompBal.Enabled := true;
     BtnCompBal.OnClick:=BtnCompBalCaRepClick;
     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeRepartir.TaCar,
        ['Compte','Désignation','Mt total Charge','Mt Bilan Ouverture'],
        ['Compte','Designation','MtTotalCharge','MtBilanOuverture']
        ,E.FormatMonnaie,E.EditFormat);
     FormateTailleColonne(DBCompareBalance,11,[2,4,2,2]);
     ReEnableControls(DMChargeRepartir.TaCar);
    end;
  //
  //  // Importation des Charges A Payer
   if ((RxChBImports.Checked[5]) and (RxSliderImport.Value = 5)) then
    begin
//    if DMChargeAPayer = nil then DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);
  //  DMImport.Import_ChAPayer(DMChargeAPayer.TaChAPayer);

//     Main.Monofenetrage :=true;
//     Main.Chargespayeretproduitsrecevoir1Click(Main.Chargespayeretproduitsrecevoir1);
//     Main.Monofenetrage := ParamUtil.MonoFenetre;

     ParamDMChargeAPayer.ChargeAPayerDataStateChange := nil;
     ParamDMChargeAPayer.Compte :=C_StrVide;
     ParamDMChargeAPayer.GEstInterfaceEvent :=nil;
     ParamDMChargeAPayer.Quand := C_Ouverture;
     ParamDMChargeAPayer.Quoi := C_ChargesAPayer;

     InitialiseDMChargeAPayer(ParamDMChargeAPayer);
     Screen.Cursor := crHourGlass;

     DMImport.Import_ChAPayer(DMChargeAPayer.TaChAPayer,true);

     StrTmp:='C';
     FiltrageDataSet(DMChargeAPayer.TaChAPayer,CreeFiltreET(['Sens','DateSaisie'],[StrTmp,datetostr(E.DatExoDebut-1)]));
     ListViewResult.Items.Clear;
     DMImport.AffichRapportImport(nil,ListViewResult);
     PaResultImport.Caption := 'Résultat de l''importation des Charges à Payer';
     RxChBImports.Checked[5] := False;
     Screen.Cursor := crDefault;
     BtnCompBal.Enabled := true;
     BtnCompBal.OnClick:=BtnCompBalChAPayerClick;
     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeAPayer.TaChAPayer,
         ['Compte','Désignation','Quantité','Montant HT','Montant Tva'],
         ['Compte2','Libelle2','Qte','MontantHT','TVA']
        ,E.FormatMonnaie,E.EditFormat);
     DBCompareBalance.ColWidths[1]:=(DBCompareBalance.Width) div 9;
     DBCompareBalance.ColWidths[2]:=(DBCompareBalance.Width) div 3;
     DBCompareBalance.ColWidths[3]:=(DBCompareBalance.Width) div 13;
     DBCompareBalance.ColWidths[4]:=(DBCompareBalance.Width) div 5;
     DBCompareBalance.ColWidths[5]:=(DBCompareBalance.Width) div 10;
//     FormateTailleColonne(DBCompareBalance,13,[2,4,2,2]);
     ReEnableControls(DMChargeAPayer.TaChAPayer);
    end;
  //
  //  // Importation des Produits A Recevoir
   if ((RxChBImports.Checked[6]) and (RxSliderImport.Value = 4)) then
    begin
  //  if DMChargeAPayer = nil then DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);
  //  DMChargeAPayer.Tag := 12; // Initialisation du tag pour les Produits A Recevoir à l'ouverture
  //  DMImport.Import_PrARecevoir(DMChargeAPayer.TaChAPayer);

//     Main.Monofenetrage :=true;
//     Main.Chargespayeretproduitsrecevoir1Click(Main.Chargespayeretproduitsrecevoir1);

     ParamDMChargeAPayer.ChargeAPayerDataStateChange := nil;
     ParamDMChargeAPayer.Compte :=C_StrVide;
     ParamDMChargeAPayer.GEstInterfaceEvent :=nil;
     ParamDMChargeAPayer.Quand := C_Ouverture;
     ParamDMChargeAPayer.Quoi := C_ProduitsARecevoir;
     Screen.Cursor := crHourGlass;

     InitialiseDMChargeAPayer(ParamDMChargeAPayer);

     DMImport.Import_PrARecevoir(DMChargeAPayer.TaChAPayer,true);

     StrTmp:='D';
     FiltrageDataSet(DMChargeAPayer.TaChAPayer,CreeFiltreET(['Sens','DateSaisie'],[StrTmp,datetostr(E.DatExoDebut-1)]));
     Main.Monofenetrage := ParamUtil.MonoFenetre;
     ListViewResult.Items.Clear;
     DMImport.AffichRapportImport(nil,ListViewResult);
     PaResultImport.Caption := 'Résultat de l''importation des Produits à Recevoir';
     RxChBImports.Checked[6] := False;
     Screen.Cursor := crDefault;
     BtnCompBal.Enabled := true;
     BtnCompBal.OnClick:=BtnCompBalPrARecevClick;
     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeAPayer.TaChAPayer,
         ['Compte','Désignation','Quantité','Montant HT','Montant Tva'],
         ['Compte2','Libelle2','Qte','MontantHT','TVA']
        ,E.FormatMonnaie,E.EditFormat);
     DBCompareBalance.ColWidths[1]:=(DBCompareBalance.Width) div 9;
     DBCompareBalance.ColWidths[2]:=(DBCompareBalance.Width) div 3;
     DBCompareBalance.ColWidths[3]:=(DBCompareBalance.Width) div 13;
     DBCompareBalance.ColWidths[4]:=(DBCompareBalance.Width) div 5;
     DBCompareBalance.ColWidths[5]:=(DBCompareBalance.Width) div 10;
//     FormateTailleColonne(DBCompareBalance,13,[2,4,2,2]);
     ReEnableControls(DMChargeAPayer.TaChAPayer);
    end;
  //
  //
  //  // Importation des Charges Constatées d'avances
   if ((RxChBImports.Checked[7]) and (RxSliderImport.Value = 3)) then
    begin
  //  if DMChargeCA = nil then DMChargeCA:=TDMChargeCA.Create(Application.MainForm);
  //  DMChargeCA.Tag := 11; // Initialisation du tag pour les Charges Constatées d'avances à l'ouverture
  //  DMImport.Import_ChCAvance(DMChargeCA.TaPCA);

//     Main.Monofenetrage :=true;
//     Main.Chargesetproduitsconstatsdavance1Click(Main.Chargesetproduitsconstatsdavance1);

     ParamDMChargeCA.ChargeCADataStateChange := nil;
     ParamDMChargeCA.GEstInterfaceEvent := nil;
     ParamDMChargeCA.Quand := C_Ouverture;
     ParamDMChargeCA.Quoi := C_ChargeCA;
     InitialiseDMChargeCA(ParamDMChargeCA);
     Screen.Cursor := crHourGlass;

     DMImport.Import_ChCAvance(DMChargeCA.TaPCA,true);

     StrTmp:='D';
     FiltrageDataSet(DMChargeCA.TaPCA,CreeFiltreET(['Sens','DateSaisie'],[StrTmp,datetostr(E.DatExoDebut-1)]));
     Main.Monofenetrage := ParamUtil.MonoFenetre;
     ListViewResult.Items.Clear;
     DMImport.AffichRapportImport(nil,ListViewResult);
     PaResultImport.Caption := 'Résultat de l''importation des Charges constatées d''Avances';
     RxChBImports.Checked[7] := False;
     Screen.Cursor := crDefault;
     BtnCompBal.Enabled := true;
     BtnCompBal.OnClick:=BtnCompBalChCAClick;
     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeCA.TaPCA,
        ['Compte','Désignation','Quantité','Montant HT'],
        ['Compte2','Libelle2','Qte','MontantHT']
        ,E.FormatMonnaie,E.EditFormat);
     FormateTailleColonne(DBCompareBalance,13,[2,4,2,2]);
     ReEnableControls(DMChargeCA.TaPCA);
    end;
  //
  //  // Importation des Produits Constatées d'avances
   if ((RxChBImports.Checked[8]) and (RxSliderImport.Value = 2)) then
    begin
  //  if DMChargeCA = nil then DMChargeCA:=TDMChargeCA.Create(Application.MainForm);
  //  DMChargeCA.Tag := 12; // Initialisation du tag pour les Produits Constatées d'avances à l'ouverture
  //  DMImport.Import_PrCAvance(DMChargeCA.TaPCA);

//     Main.Monofenetrage :=true;
//     Main.Chargesetproduitsconstatsdavance1Click(Main.Chargesetproduitsconstatsdavance1);

     ParamDMChargeCA.ChargeCADataStateChange := nil;
     ParamDMChargeCA.GEstInterfaceEvent := nil;
     ParamDMChargeCA.Quand := C_Ouverture;
     ParamDMChargeCA.Quoi := C_ProduitCA;
     InitialiseDMChargeCA(ParamDMChargeCA);
     Screen.Cursor := crHourGlass;
     DMImport.Import_PrCAvance(DMChargeCA.TaPCA,true);

     StrTmp:='C';
     FiltrageDataSet(DMChargeCA.TaPCA,CreeFiltreET(['Sens','DateSaisie'],[StrTmp,datetostr(E.DatExoDebut-1)]));
     Main.Monofenetrage := ParamUtil.MonoFenetre;
     ListViewResult.Items.Clear;
     DMImport.AffichRapportImport(nil,ListViewResult);
     PaResultImport.Caption := 'Résultat de l''importation des Produits constatées d''Avances';
     RxChBImports.Checked[8] := False;
     Screen.Cursor := crDefault;
     BtnCompBal.Enabled := true;
     BtnCompBal.OnClick:=BtnCompBalPrCAClick;
     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeCA.TaPCA,
        ['Compte','Désignation','Quantité','Montant HT'],
        ['Compte2','Libelle2','Qte','MontantHT']
        ,E.FormatMonnaie,E.EditFormat);
     FormateTailleColonne(DBCompareBalance,13,[2,4,2,2]);
     ReEnableControls(DMChargeCA.TaPCA);
    end;
  //
  //  // Importation des Provisions
   if ((RxChBImports.Checked[9]) and (RxSliderImport.Value = 1)) then
    begin
     ParamDMProvision.ProvisionDataStateChange := nil;
     ParamDMProvision.Quand := C_Ouverture;
     ParamDMProvision.GEstInterfaceEvent := nil;
     InitialiseDMProvision(ParamDMProvision);
     Screen.Cursor := crHourGlass;

     DMImport.Import_Provision(DMProvisions.TaProvision,True);

  //  if DMProvisions = nil then DMProvisions:=TDMProvisions.Create(Application.MainForm);
  //  DMProvisions.Tag := 1; // Initialisation du tag pour les Provisions à l'ouverture
  //  DMImport.Import_Provision(DMProvisions.TaProvision);

//     Main.Monofenetrage :=true;
//     Main.Provisions1Click(Main.Provisions1);
//     FiltrageDataSet(DMProvisions.TaProvision,CreeFiltreET(['DateSaisie'],[datetostr(E.DatExoDebut-1)]));
//     Main.Monofenetrage := ParamUtil.MonoFenetre;

     ListViewResult.Items.Clear;
     DMImport.AffichRapportImport(nil,ListViewResult);
     PaResultImport.Caption := 'Résultat de l''importation des Provisions';
     RxChBImports.Checked[9] := False;
     Screen.Cursor := crDefault;
     BtnCompBal.Enabled := true;
     BtnCompBal.OnClick:=BtnCompBalProvisClick;
     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMProvisions.TaProvision,
                         ['Désignation','Mt total Provision','Mt Bilan Ouverture'],
                         ['Designation','MtTotalProvision','MtBilanOuverture']
                         ,E.FormatMonnaie,E.EditFormat);
     FormateTailleColonne(DBCompareBalance,9,[4,2,2]);
     ReEnableControls(DMProvisions.TaProvision);
   end;


  //
Finally
  InitIndicateurAvancement;
  Screen.Cursor := crDefault;
end;
end;


procedure TConfirmImport.FormCreate(Sender: TObject);
begin
//E.RepertoireImportEPI_DOS := 'C:\Cedi';
RxSliderImport.Value := Max_Et_Value; // Utilisé pour le controle d'avancement d'importation général
RxSliderImport.MaxValue := Max_Et_Value; // Correspond au Nombre total de ligne dans module d'import
BtnEnregistrer.Tag := 1; // Utilisé pour le controle d'avancement
                         //d'importation de plan, codeTva, journaux
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
    end;
end;

procedure TConfirmImport.PaListeRappImportClick(Sender: TObject);
var
Liste:TStringList;
begin
Liste:=TStringList.Create;
ListViewResult.Items.Clear;

Liste:=ListeFic('*.txt',CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS),1,False,False);
DMImport.AffichRapportImport(Liste,ListViewResult);
Initialise_TStringlist(liste,self);
end;

procedure TConfirmImport.InitIndicateurAvancement;
var
i:integer;
Begin
for i:=0 to (RxChBImports.Items.Count-1) do
 if RxChBImports.Checked[i] then
  begin
    RxSliderImport.Value := (RxChBImports.Items.Count-i);
    exit;
  end;
End;

procedure TConfirmImport.PaSousGrilleResize(Sender: TObject);
begin
  try
    WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
  except

  end;
end;

procedure TConfirmImport.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);

DBCompareBalance.ParamColor:=true;
DBCompareBalance.Param:=ParamUtil.CouleurDBGrid;
DBCompareBalance.UpDateColor;
end;

procedure TConfirmImport.BtnCompBalImmosClick(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
   DMImport.ListeFiltreCompteBilanOuverture.clear;
   ChampTableVersVarListe('Compte',DMImmos_Ouverture.taDetailImmo,DMImport.ListeFiltreCompteBilanOuverture);
   DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                    ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                    ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalImmosClickInv;
   BtnCompBal.Caption := C_BtnCompBal_Caption2;
   PaResultImport.Caption :='Comparaison compte d''immos Balance Win / Balance DOS';
   FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
End;

procedure TConfirmImport.BtnCompBalImmosClickInv(Sender: TObject);
begin
    DBCompareBalance.OnDrawColumnCell:=nil;
    GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImmos_Ouverture.taDetailImmo,
                     ['Compte','Code','Sous Code','Libellé','Date Achat','Valeur à Amortir','Type'],
                     ['Compte','Code','Sous_Code','Libelle','Date_Achat','Valeur_a_Amortir','TypeA']
                     ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalImmosClick;
   BtnCompBal.Caption := C_BtnCompBal_Caption1;
   PaResultImport.Caption := 'Résultat de l''importation des Immobilisations';
   FormateTailleColonne(DBCompareBalance,27,[3,2,2,7,4,4,4]);
   ReEnableControls(DMImmos_Ouverture.taDetailImmo);
end;

procedure TConfirmImport.BtnCompBalStockClick(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
   DMImport.ListeFiltreCompteBilanOuverture.clear;
   ChampTableVersVarListe('Compte',DMStock.TaStock,DMImport.ListeFiltreCompteBilanOuverture);
   DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                    ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                    ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalStockClickInv;
   BtnCompBal.Caption := C_BtnCompBal_Caption2;
   PaResultImport.Caption :='Comparaison des Stocks Balance Win / Balance DOS';
   FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
End;

procedure TConfirmImport.BtnCompBalStockClickInv(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=nil;
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMStock.TaStock,
                    ['Compte','Désignation','Quantité','Prix Unitaire','Décote','Montant Total HT'],
                    ['Compte','Designation','Qte','Prix_Unitaire','Decote','MontantTotalHT']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalStockClick;
   BtnCompBal.Caption := C_BtnCompBal_Caption1;
   PaResultImport.Caption := 'Résultat de l''importation des Stocks';
   FormateTailleColonne(DBCompareBalance,14,[2,2,1,2,2,2]);
   ReEnableControls(DMStock.TaStock);
End;

procedure TConfirmImport.BtnCompBalCaRepClick(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
   DMImport.ListeFiltreCompteBilanOuverture.clear;
   ChampTableVersVarListe('Compte',DMChargeRepartir.TaCar,DMImport.ListeFiltreCompteBilanOuverture);
   DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                    ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                    ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalCaRepClickInv;
   BtnCompBal.Caption := C_BtnCompBal_Caption2;
   PaResultImport.Caption :='Comparaison Charges à répartir Balance Win / Balance DOS';
   FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
End;

procedure TConfirmImport.BtnCompBalCaRepClickInv(Sender: TObject);
Begin
//     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeRepartir.TaCar,
//        ['Compte','Désignation','Mt total Charge','Mt Bilan Ouverture'],
//        ['Compte','Designation','MtTotalCharge','MtBilanOuverture']
//        ,E.FormatMonnaie,E.EditFormat);
//     FormateTailleColonne(DBCompareBalance,11,[2,4,2,2]);

   DBCompareBalance.OnDrawColumnCell:=nil;
     GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeRepartir.TaCar,
        ['Compte','Désignation','Mt total Charge','Mt Bilan Ouverture'],
        ['Compte','Designation','MtTotalCharge','MtBilanOuverture']
        ,E.FormatMonnaie,E.EditFormat);
//   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeRepartir.TaCar,
//                    ['Compte','Désignation','Quantité','Prix Unitaire','Décote','Montant Total HT'],
//                    ['Compte','Designation','Qte','Prix_Unitaire','Decote','MontantTotalHT']
//                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalCaRepClick;
   BtnCompBal.Caption := C_BtnCompBal_Caption1;
   PaResultImport.Caption := 'Résultat de l''importation des Charges à Répartir';
   FormateTailleColonne(DBCompareBalance,11,[2,4,2,2]);
   ReEnableControls(DMChargeRepartir.TaCar);
End;

procedure TConfirmImport.BtnCompBalChAPayerClick(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
   DMImport.ListeFiltreCompteBilanOuverture.clear;
   ChampTableVersVarListe('Compte',DMChargeAPayer.TaChAPayer,DMImport.ListeFiltreCompteBilanOuverture);
   DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                    ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                    ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalChAPayerClickInv;
   BtnCompBal.Caption := C_BtnCompBal_Caption2;
   PaResultImport.Caption :='Comparaison Charges à Payer Balance Win / Balance DOS';
   FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
End;

procedure TConfirmImport.BtnCompBalChAPayerClickInv(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=nil;
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeAPayer.TaChAPayer,
       ['Compte','Désignation','Quantité','Montant HT','Montant Tva'],
       ['Compte2','Libelle2','Qte','MontantHT','TVA']
      ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalChAPayerClick;
   BtnCompBal.Caption := C_BtnCompBal_Caption1;
   PaResultImport.Caption := 'Résultat de l''importation des Charges à Payer';
   DBCompareBalance.ColWidths[1]:=(DBCompareBalance.Width) div 9;
   DBCompareBalance.ColWidths[2]:=(DBCompareBalance.Width) div 3;
   DBCompareBalance.ColWidths[3]:=(DBCompareBalance.Width) div 13;
   DBCompareBalance.ColWidths[4]:=(DBCompareBalance.Width) div 5;
   DBCompareBalance.ColWidths[5]:=(DBCompareBalance.Width) div 10;
   ReEnableControls(DMChargeAPayer.TaChAPayer);
End;

procedure TConfirmImport.BtnCompBalPrARecevClick(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
   DMImport.ListeFiltreCompteBilanOuverture.clear;
   ChampTableVersVarListe('Compte',DMChargeAPayer.TaChAPayer,DMImport.ListeFiltreCompteBilanOuverture);
   DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                    ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                    ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalPrARecevClickInv;
   BtnCompBal.Caption := C_BtnCompBal_Caption2;
   PaResultImport.Caption :='Comparaison Produits à Recevoir Balance Win / Balance DOS';
   FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
End;

procedure TConfirmImport.BtnCompBalPrARecevClickInv(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=nil;
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeAPayer.TaChAPayer,
       ['Compte','Désignation','Quantité','Montant HT','Montant Tva'],
       ['Compte2','Libelle2','Qte','MontantHT','TVA']
      ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalPrARecevClick;
   BtnCompBal.Caption := C_BtnCompBal_Caption1;
   PaResultImport.Caption := 'Résultat de l''importation des Produits à Recevoir';
   DBCompareBalance.ColWidths[1]:=(DBCompareBalance.Width) div 9;
   DBCompareBalance.ColWidths[2]:=(DBCompareBalance.Width) div 3;
   DBCompareBalance.ColWidths[3]:=(DBCompareBalance.Width) div 13;
   DBCompareBalance.ColWidths[4]:=(DBCompareBalance.Width) div 5;
   DBCompareBalance.ColWidths[5]:=(DBCompareBalance.Width) div 10;
   ReEnableControls(DMChargeAPayer.TaChAPayer);
End;

procedure TConfirmImport.BtnCompBalChCAClick(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
   DMImport.ListeFiltreCompteBilanOuverture.clear;
   ChampTableVersVarListe('Compte',DMChargeCA.TaPCA,DMImport.ListeFiltreCompteBilanOuverture);
   DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                    ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                    ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalChCAClickInv;
   BtnCompBal.Caption := C_BtnCompBal_Caption2;
   PaResultImport.Caption :='Comparaison Charges à répartir Balance Win / Balance DOS';
   FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
End;

procedure TConfirmImport.BtnCompBalChCAClickInv(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=nil;
   BtnCompBal.OnClick:=BtnCompBalChCAClick;
   BtnCompBal.Caption := C_BtnCompBal_Caption1;
   PaResultImport.Caption := 'Résultat de l''importation des Charges constatées d''Avances';
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeCA.TaPCA,
      ['Compte','Désignation','Quantité','Montant HT'],
      ['Compte2','Libelle2','Qte','MontantHT']
      ,E.FormatMonnaie,E.EditFormat);
   FormateTailleColonne(DBCompareBalance,13,[2,4,2,2]);
   ReEnableControls(DMChargeCA.TaPCA);
End;

procedure TConfirmImport.BtnCompBalPrCAClick(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
   DMImport.ListeFiltreCompteBilanOuverture.clear;
   ChampTableVersVarListe('Compte',DMChargeCA.TaPCA,DMImport.ListeFiltreCompteBilanOuverture);
   DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                    ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                    ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalPrCAClickInv;
   BtnCompBal.Caption := C_BtnCompBal_Caption2;
   PaResultImport.Caption :='Comparaison Charges à répartir Balance Win / Balance DOS';
   FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
End;

procedure TConfirmImport.BtnCompBalPrCAClickInv(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=nil;
   BtnCompBal.OnClick:=BtnCompBalPrCAClick;
   BtnCompBal.Caption := C_BtnCompBal_Caption1;
   PaResultImport.Caption := 'Résultat de l''importation des Charges constatées d''Avances';
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMChargeCA.TaPCA,
      ['Compte','Désignation','Quantité','Montant HT'],
      ['Compte2','Libelle2','Qte','MontantHT']
      ,E.FormatMonnaie,E.EditFormat);
   FormateTailleColonne(DBCompareBalance,13,[2,4,2,2]);
   ReEnableControls(DMChargeCA.TaPCA);
End;

procedure TConfirmImport.BtnCompBalProvisClick(Sender: TObject);
Begin
   DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
   DMImport.ListeFiltreCompteBilanOuverture.clear;
   ChampTableVersVarListe('Compte',DMProvisions.TaProvision,DMImport.ListeFiltreCompteBilanOuverture);
   DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
   GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                    ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                    ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                    ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalProvisClickInv;
   BtnCompBal.Caption := C_BtnCompBal_Caption2;
   PaResultImport.Caption :='Comparaison compte de Provisions Balance Win / Balance DOS';
   FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
End;

procedure TConfirmImport.BtnCompBalProvisClickInv(Sender: TObject);
Begin
    DBCompareBalance.OnDrawColumnCell:=nil;
    FiltrageDataSet(DMProvisions.TaProvision,CreeFiltreET(['DateSaisie'],[datetostr(E.DatExoDebut-1)]));
    GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMProvisions.TaProvision,
                        ['Désignation','Mt total Provision','Mt Bilan Ouverture'],
                        ['Designation','MtTotalProvision','MtBilanOuverture']
                        ,E.FormatMonnaie,E.EditFormat);
   BtnCompBal.OnClick :=BtnCompBalProvisClick;
   BtnCompBal.Caption := C_BtnCompBal_Caption1;
   PaResultImport.Caption := 'Résultat de l''importation des Provisions';
   FormateTailleColonne(DBCompareBalance,9,[4,2,2]);
   ReEnableControls(DMProvisions.TaProvision);
End;

procedure TConfirmImport.RxChBImportsClickCheck(Sender: TObject);
begin
 InitIndicateurAvancement;
end;

procedure TConfirmImport.DBCompareBalanceDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  holdColor: TColor;
begin
try
   if ((Column.Field.DataSet.FindField('SoldeDebitReport').AsCurrency <> Column.Field.DataSet.FindField('SoldeDebitBalImport').AsCurrency) or
      (Column.Field.DataSet.FindField('SoldeCreditReport').AsCurrency <> Column.Field.DataSet.FindField('SoldeCreditBalImport').AsCurrency)) then
    begin
         holdColor:=DBCompareBalance.Canvas.Brush.Color;
         DBCompareBalance.Canvas.Brush.Color :=clSilver;//$00808040;
         DBCompareBalance.DefaultDrawColumnCell(Rect, DataCol, Column, State);
         DBCompareBalance.Canvas.Brush.Color := holdColor;
//         EncoreErreurImport := True;
//         if EncoreErreurImport then
//          begin
//           if BtnVerouillage.Tag < 3 then
//            begin
//             BtnVerouillage.Tag := 1;
//             BtnVerouillage.Caption :='Vérifier Import';
//            end;
//          end
//         else
//          begin
//           if BtnVerouillage.Tag = 1 then
//            begin
//              BtnVerouillage.Tag := 2;
//              BtnVerouillage.Caption :='Vérouiller Import(1/2)';
//            end;
//           if BtnVerouillage.Tag = 2 then
//            begin
//              BtnVerouillage.Tag := 3;
//              BtnVerouillage.Caption :='Vérouiller Import(2/2)';
//            end;
//          end;
    end
except
end;

end;

procedure TConfirmImport.Importer1Click(Sender: TObject);
begin
BtnEnregistrer.Click;
end;

procedure TConfirmImport.FormDestroy(Sender: TObject);
begin
     LibGestionParamXML.DestroyForm(Self,E.USer);
     ConfirmImport := nil;
end;

procedure TConfirmImport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[nil]);
   If Key = VK_ESCAPE Then
     Begin
         Self.Close ;
     end;
end;

procedure TConfirmImport.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TConfirmImport.vidertables1Click(Sender: TObject);
begin
//  InitDataBase(DMBD.dbNameProg,DMBD.dbNameDossier,DMBD.dbNameExo,true);
end;

procedure TConfirmImport.BtnCompBalClick(Sender: TObject);
begin
//
end;

{-----------------------------------------------------------------------------
  Procedure: TConfirmImport.BtnVerouillageClick
  Author:    Blanc Philippe
  Date:      09-sept.-2003
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TConfirmImport.BtnVerouillageClick(Sender: TObject);
begin
if MessageDlg('Confirmez le verrouillage des ànouveaux '+#13+#10+'que vous venez d''importer !', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
 begin
    Screen.Cursor := crHourGlass;
    if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
    InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaPlanBO,DMPlan.DaPlanBO]);
    DMImport.Import_BalanceOuverture(DMPlan.TaPlanBO,true);
    DMPlan.TaPlanBO.Refresh;
    DMDiocEtatBal.Balance_Maj_BO_Vers_Balance(DMRech.TaPlanCptRech);
//    InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaPlanBO,DMPlan.DaPlanBO]);
//    DMImport.Import_BalanceOuverture(DMPlan.TaPlanBO,true);
    DMPlan.TaPlanBO.Refresh;
    Vider_La_Table:=false;
//    GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMPlan.TaPlanBO,
//                     ['Compte','Libellé','Un1','Un2','Code Tva','Sens Crédit','Coll.','Rapp.','Immo.','Pointable'],
//                     ['Compte','Libelle','Un1','Un2','TvaCode','TvaDebit','Collectif','Rapprochement','Immobilisation','Pointable']
//                     ,E.FormatMonnaie,E.EditFormat);

    ListViewResult.Items.Clear;
    DMImport.AffichRapportImport(nil,ListViewResult);
    PaResultImport.Caption := 'Résultat de l''importation du Bilan d''Ouverture';
    //DMImport.AffichRapportImport(ListeFichier,ListViewResult);
    //ChampTableVersVarListe('Compte',DMPlan.TaPlanMaintS,DMImport.ListeFiltreCompteBilanOuverture);
    Screen.Cursor := crDefault;
 end;

//   // comparaison Bal Win / Bal Dos
//case BtnVerouillage.Tag of
//
//   0:Begin
//      BtnVerouillage.Caption :='Vérifier Import';
//      BtnVerouillage.Tag := 1;
//      BtnVerouillage.Click;
//     End;
//
//   1:Begin
//    // Verifier Import
//       EncoreErreurImport := False;
//       BtnVerouillage.Tag := 2;
//       BtnVerouillage.Caption :='Vérouiller Import';
//       DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
//       DMImport.ListeFiltreCompteBilanOuverture.clear;
//       DMPlan.TaPlanBO.Open;
//       ChampTableVersVarListe('Compte',DMPlan.TaPlanBO,DMImport.ListeFiltreCompteBilanOuverture);
//       DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
//       GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
//                        ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
//                        ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
//                        ,E.FormatMonnaie,E.EditFormat);
//    //   BtnCompBal.OnClick :=BtnCompBalStockClickInv;
//    //   BtnCompBal.Caption := C_BtnCompBal_Caption2;
//       PaResultImport.Caption :='Comparaison Balance Win / Balance DOS';
//       FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
////       if EncoreErreurImport then
////        begin
////          BtnVerouillage.Tag := 1;
////          BtnVerouillage.Caption :='Vérifier Import';
////        end
////       else
////        begin
////          BtnVerouillage.Tag := 2;
////          BtnVerouillage.Caption :='Vérouiller Import';
////        end;
//     End;
//
//   2:Begin
//   // Importation du Bilan d'Ouverture
//   // Vérouiller Import
//    if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
//    InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaPlanBO,DMPlan.DaPlanBO]);
//    DMImport.Import_BalanceOuverture(DMPlan.TaPlanBO,true);
//    DMPlan.TaPlanBO.Refresh;
//    Vider_La_Table:=false;
////    GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMPlan.TaPlanBO,
////                     ['Compte','Libellé','Un1','Un2','Code Tva','Sens Crédit','Coll.','Rapp.','Immo.','Pointable'],
////                     ['Compte','Libelle','Un1','Un2','TvaCode','TvaDebit','Collectif','Rapprochement','Immobilisation','Pointable']
////                     ,E.FormatMonnaie,E.EditFormat);
//
//    ListViewResult.Items.Clear;
//    DMImport.AffichRapportImport(nil,ListViewResult);
//    PaResultImport.Caption := 'Résultat de l''importation du Bilan d''Ouverture';
//    //DMImport.AffichRapportImport(ListeFichier,ListViewResult);
//    //ChampTableVersVarListe('Compte',DMPlan.TaPlanMaintS,DMImport.ListeFiltreCompteBilanOuverture);
//    BtnVerouillage.Tag :=3;
//    Screen.Cursor := crDefault;
////    FormateTailleColonne(DBCompareBalance,22,[2,6,1,1,2,2,2,1,1,1]);
//     End;
//
//   3:Begin
//   // Mise à jour de la balance avec le Bilan d'Ouverture importé dans PlanCpt
//   // Vérouiller Import
//    if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
//    DMDiocEtatBal.Balance_Maj_BO_Vers_Balance(DMRech.TaPlanCptRech);
////    InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaPlanBO,DMPlan.DaPlanBO]);
////    DMImport.Import_BalanceOuverture(DMPlan.TaPlanBO,true);
//    DMPlan.TaPlanBO.Refresh;
//    Vider_La_Table:=false;
////    GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMPlan.TaPlanBO,
////                     ['Compte','Libellé','Un1','Un2','Code Tva','Sens Crédit','Coll.','Rapp.','Immo.','Pointable'],
////                     ['Compte','Libelle','Un1','Un2','TvaCode','TvaDebit','Collectif','Rapprochement','Immobilisation','Pointable']
////                     ,E.FormatMonnaie,E.EditFormat);
//
//    ListViewResult.Items.Clear;
//    DMImport.AffichRapportImport(nil,ListViewResult);
//    PaResultImport.Caption := 'Résultat de l''importation du Bilan d''Ouverture';
//    //DMImport.AffichRapportImport(ListeFichier,ListViewResult);
//    //ChampTableVersVarListe('Compte',DMPlan.TaPlanMaintS,DMImport.ListeFiltreCompteBilanOuverture);
//    BtnVerouillage.Tag :=4;
//    Screen.Cursor := crDefault;
////    FormateTailleColonne(DBCompareBalance,22,[2,6,1,1,2,2,2,1,1,1]);
//     End;
//end;



end;

procedure TConfirmImport.DBCompareBalanceDblClick(Sender: TObject);
Var
ParamRechercheBD:TParamRechercheBD;
begin
ParamRechercheBD.CompteDep := DMImport.daResultImport.DataSet.findfield('Compte').AsString;
ParamRechercheBD.Ouverture := true;
RechercheBDAffiche(ParamRechercheBD);
end;

procedure TConfirmImport.FormShow(Sender: TObject);
begin
 EncoreErreurImport := True;
 RepImportDejaValide:=False;
end;

procedure TConfirmImport.ForcerFinImport1Click(Sender: TObject);
begin
//  BtnVerouillage.Tag := 2;
//  BtnVerouillage.Caption :='Vérouiller Import';
//  BtnVerouillage.Refresh;
   if not BtnVerouillage.Enabled then
    begin
     if MessageDlg('ATTENTION,'+#13+#10+'Vos ànouveaux ne correspondent pas à votre balance,'+#13+#10+'Confirmez vous l''accès au verrouillage ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
       BtnVerouillage.Enabled := true;
    end;
end;

procedure TConfirmImport.Imprimer1Click(Sender: TObject);
var
fichier:Tstringlist;
ParametreEdition:TParametreEdition;
begin
if activecontrol=ListViewResult then
 begin
    VisuListeView.ParamEdition.AffichDefaut:=true;
    VisuListeView.ParamEdition.Titre:='Rapport d''importation';
    VisuListeView.ParamEdition.TitrePetit:='Rejet d''importation';
    //VisuListeView.TabTitreColonne_Ecran:=['Rapport'];
    //VisuListeView.LargeurCol_Ecran:=[700];
    //VisuListeView.TabList_Ecran:=[];
    //VisuListeView.RemplitParametreEdition(ParametreEdition);
   // VisuListeView.ImprimerListe;
 end;
if activecontrol=DBCompareBalance then
 begin
    DBCompareBalance.ReportCaption := PaResultImport.Caption;
    DBCompareBalance.GridPreview;
 end;
end;

procedure TConfirmImport.BtnVerifierClick(Sender: TObject);
var
i:integer;
begin
try
     // Verifier Import
       Screen.Cursor := crHourGlass;
       EncoreErreurImport := False;
//       BtnVerouillage.Tag := 2;
//       BtnVerouillage.Caption :='vérrouiller Import';
       DBCompareBalance.OnDrawColumnCell:=DBCompareBalanceDrawColumnCell;
       DMImport.ListeFiltreCompteBilanOuverture.clear;
       DMPlan.TaPlanBO.Open;
       ChampTableVersVarListe('Compte',DMPlan.TaPlanBO,DMImport.ListeFiltreCompteBilanOuverture);
       DMImport.InitDataSetResultImport(C_IMPORT_EPIDOS);
       GrDbGridInitColonne(DBCompareBalance,DMImport.DaResultImport,DMImport.TaResultImport,
                        ['Compte','Libellé','Solde Débit Rep. Win','Solde Crédit Rep. Win','Solde Débit Rep. DOS','Solde Crédit Rep. DOS'],
                        ['Compte','Libelle','SoldeDebitReport','SoldeCreditReport','SoldeDebitBalImport','SoldeCreditBalImport']
                        ,E.FormatMonnaie,E.EditFormat);
    //   BtnCompBal.OnClick :=BtnCompBalStockClickInv;
    //   BtnCompBal.Caption := C_BtnCompBal_Caption2;
       PaResultImport.Caption :='Comparaison Balance Win / Balance DOS';
       FormateTailleColonne(DBCompareBalance,16,[2,4,2,2,2,2]);
       DBCompareBalance.DataSource.DataSet.DisableControls;
       DBCompareBalance.DataSource.DataSet.First;
       while not DBCompareBalance.DataSource.DataSet.Eof do
        begin
        if not EncoreErreurImport then
         EncoreErreurImport :=  ((DBCompareBalance.DataSource.DataSet.FindField('SoldeDebitReport').AsCurrency <> DBCompareBalance.DataSource.DataSet.FindField('SoldeDebitBalImport').AsCurrency) or
            (DBCompareBalance.DataSource.DataSet.FindField('SoldeCreditReport').AsCurrency <> DBCompareBalance.DataSource.DataSet.FindField('SoldeCreditBalImport').AsCurrency));
         DBCompareBalance.DataSource.DataSet.Next;
        end;
finally
  DBCompareBalance.DataSource.DataSet.First;
  DBCompareBalance.DataSource.DataSet.EnableControls;
  Screen.Cursor := crDefault;
  BtnVerouillage.Enabled :=not EncoreErreurImport;
end;
end;

end.
