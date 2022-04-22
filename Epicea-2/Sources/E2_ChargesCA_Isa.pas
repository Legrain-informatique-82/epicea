unit E2_ChargesCA_Isa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db,
  DBTables, E2_AideCompte, LibSQL, Menus, Buttons, Gr_MiseAJourBalance,
  RXDBCtrl, ExRxDBGrid,registry, RXCtrls, GrDBGrid,LibZoneSaisie,E2_AssistantClotureDef,DMEcriture,
  LibRessourceString,E2_Decl_Records, Mask, ToolEdit,LibDates,E2_Cloture_Def,
  GrGrid,DMConstantes,
  jpeg,
  lib_chaine,
  LibGestionParamXML,
  ObjetEdition,
  editions;


type

  TParamAffichageChargeCA = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   end;


    TChargeCA_Isa = class(TForm)
    Patitre: TPanel;
    SBProduit: TRxSpeedButton;
    SBCharges: TRxSpeedButton;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaBas: TPanel;
    PaGrille: TPanel;
    DBGridChargesCA: TGrDBGrid;
    BtnAnnuler: TButton;
    BtnImprimer: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSpeedButton4: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    Panel1: TPanel;
    Label6: TLabel;
    Label5: TLabel;
    EdCompte: TEdit;
    EdLibelle: TEdit;
    EdDate: TDateEdit;
    RxSpeedButton3: TRxSpeedButton;
    PaCumul1: TPanel;
    Panel7: TPanel;
    GrGrid1: TGrGrid;
    RxSBImport: TRxSpeedButton;
    Imprimerdecomptecourant1: TMenuItem;
    RxMAJ_Balance: TRxSpeedButton;
    Exporter1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSupprimerClick(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SBChargesClick(Sender: TObject);
    procedure DBGridChargesCAColExit(Sender: TObject);
    procedure DBGridChargesCAKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure GestionBoutonsSpeed;
    procedure InitialisationCaption(tab_bis:integer);
    Procedure EnregistrementAutomatique;
    procedure PatitreResize(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure DBGridChargesCAColEnter(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure Aideenligne1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure PaToolsResize(Sender: TObject);
    Procedure PositionTotaux;
    procedure SBProduitClick(Sender: TObject);
    procedure RxSBImportClick(Sender: TObject);
    Procedure GereAccesEcran;
    Procedure GestionInitDM;
    procedure Imprimerdecomptecourant1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure RxMAJ_BalanceClick(Sender: TObject);
    procedure RxMAJ_BalanceMouseEnter(Sender: TObject);
    procedure RxMAJ_BalanceMouseLeave(Sender: TObject);
    procedure RxMAJ_BalanceMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
    QuandQuoi:Integer;
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm,SousTitre2Form:String;
    Quoi,Quand:Integer;
  end;

var
  ChargeCA_Isa: TChargeCA_Isa;
  CompteFiltrePCA: String;
  IndiceTable: Integer;
  CompteCourant: String;
  LastSize:integer;
  FlagChargeCACourant:boolean;

  Function ChargeCAAffiche(ParamAffichageChargeCA:TParamAffichageChargeCA):Boolean;

implementation

uses E2_RepriseChargesCA,DMChargesCA, E2_Main,E2_Recherche, E2_AideAssist,
  DMAide,
  //UQReport,
  DMChargesRepartir, DMPlanCpt, DMRecherche,
  DMImportation, LibClassObjetSenders,DMCorrection,DMExports, ImportDll;


{$R *.DFM}
Function ChargeCAAffiche(ParamAffichageChargeCA:TParamAffichageChargeCA):Boolean;
var
ParamDMChargeCA:TParamDMChargeCA;
Begin
// if (ChargeCA_Isa = nil) then ChargeCA_Isa:=TChargeCA_Isa.Create(Application.MainForm);
// if ((ParamAffichageChargeCA.Quand <> ChargeCA_Isa.Quand) and (ChargeCA_Isa.Visible=true)) then
//   ChargeCA_Isa.Close;
// ChargeCA_Isa.Quand:=ParamAffichageChargeCA.Quand;
// if not empty(ParamAffichageChargeCA.TitreForm) then
//   ChargeCA_Isa.TitreForm:=ParamAffichageChargeCA.TitreForm;
// ChargeCA_Isa.SousTitreForm:=ParamAffichageChargeCA.SousTitreForm;
//
// ParamDMStocks.StocksDataStateChange := ChargeCA_Isa.changementEtatBoutons;
// ParamDMStocks.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
// ParamDMStocks.Quand := ChargeCA_Isa.Quand;
//
//   case ChargeCA_Isa.Quand of
//      C_Ouverture:Begin
//                   InitialiseDMStocks(ParamDMStocks);
//                  End;
//
//      C_Cloture:Begin
//                  if InitialiseDMStocks(ParamDMStocks).ResteStocksOuvertureAReprendre then
//                   begin
//                    if MessageDlg('Tous vos Stocks d''Ouverture n''ont pas été repris !!!'+
//                                   RetourChariotDouble+
//                                   'Voulez-Vous faire la reprise maintenant ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
//                     begin
//                      try
//                        Main.RepriseStoks1Click(Main.RepriseStoks1);
//                      except
//                        ParamAfficheStock.Affiche := false;
//                        MessageDlg('Une erreur s''est produite lors de la reprise de vos stocks '+#13+#10+'d''ouverture !', mtError, [mbOK], 0);
//                      end;
//                     end
//                    else
//                     begin
//                      ParamAfficheStock.Affiche := false;
//                     end;
////                    Messagedlg('Opération impossible !!! Tous vos Stocks d''Ouverture n''ont pas été repris !!!',MtWarning,[mbok],0);
//                   end;
//
//                End;
//   end;
//
// if ParamAffichageChargeCA.Affiche then
//  begin
//   ChargeCA_Isa.DBGridChargesCA.DataSource := DMChargeCA.DataPCA;
//   if AideCompte=nil then
//   AideCompte:=TAideCompte.Create(Application.MainForm);
//
//   if ParamAffichageChargeCA.AffichageModal then
//     ChargeCA_Isa.ShowModal
//    else
//     ChargeCA_Isa.Show;
//  end;
End;

procedure TChargeCA_Isa.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except;
end;
end;


procedure TChargeCA_Isa.ChangementEtatGrille(Sender: TObject);
begin

DBGridChargesCA.OnColExit:=nil;

case self.tag of
   11,21:SousTitre2Form:='[ Charges ]';
   12,22:SousTitre2Form:='[ Produits ]';
end;
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMChargeCA.TaPCA)+' - '+ SousTitre2Form;

   case DMChargeCA.TaPCA.state of
   dsBrowse: begin
               DBGridChargesCA .Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
//               DBGridChargesCA.SelectedIndex := 1;
               DBGridChargesCA.TitreColor(true);
               DBGridChargesCA.SetFocus;
               if DBGridChargesCA.InplaceEditor <> nil then
                  DBGridChargesCA.EditorMode:=false;
             end;

   dsEdit:   begin
               DBGridChargesCA.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBGridChargesCA.SetFocus;
               DBGridChargesCA.TitreColor(true);
             end;

   dsInsert: begin
               DBGridChargesCA.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               //DBGridChargesCA.SelectedIndex := 0;
               DBGridChargesCA.SetFocus;
               DBGridChargesCA.TitreColor(true);
             end;
   end;//fin du case.state
DBGridChargesCA.OnColExit:=DBGridChargesCAColExit;
     PaGrille.Realign;
     PaGrilleResize(PaGrille);

end;


procedure TChargeCA_Isa.changementEtatBoutons(Sender: TObject);
begin
  case DMChargeCA.TaPCA.state of
   dsBrowse: begin
               // Bouton Barre de menu
               EnableWinControl([BtnInserer,BtnModifier,BtnImprimer],True);
               EnableWinControl([BtnEnregistrer],false);
               BtnSupprimer.Enabled:=(DMChargeCA.TaPCA.RecordCount>0);
               //Pop menu
               EnableItemMenu([Insrer1,Modifier1,Imprimer1],true);
               EnableItemMenu([Enregister1],false);
               Supprimer1.Enabled:=BtnSupprimer.Enabled;
               //Autre Bouton
               SBProduit.Enabled := True;
               SBCharges.Enabled := True;

               FiltrageDataSet(DMRech.TaPCARech,DBGridChargesCA.DataSource.DataSet.Filter);
               GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',SommeTotauxGeneric(['MontantHT'],DMRech.TaPCARech).Total1);
               DeFiltrageDataSet(DMRech.TaPCARech);
             end;

   dsEdit:   begin
               // Bouton Barre de menu
               EnableWinControl([BtnEnregistrer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               //Pop menu
               EnableItemMenu([Enregister1],true);
               EnableItemMenu([Insrer1,Modifier1,Supprimer1,Imprimer1],False);
               //Autre Bouton
               SBProduit.Enabled := False;
               SBCharges.Enabled := False;
             end;

   dsInsert: begin
               // Bouton Barre de menu
               //EnableWinControl([BtnAnnuler,],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               //Pop menu
              // EnableItemMenu([Annuler1,Fermer1],true);
               EnableItemMenu([Insrer1,Modifier1,Supprimer1,Imprimer1],False);
               //Autre Bouton
               SBProduit.Enabled := False;
               SBCharges.Enabled := False;
             end;
   end;//fin du case.state$
   ChangementEtatGrille(DMChargeCA.TaPCA);
end;

//****************************************************************************//
// Gestion de la création de la fenêtre.                                      //
//****************************************************************************//
procedure TChargeCA_Isa.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin

 if DMChargeCA=nil then
 DMChargeCA:=TDMChargeCA.Create(self);

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);

 //RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
FlagChargeCACourant:=false;
 Registre:= TRegistry.Create;
 try
  with Registre do
    begin
     RootKey := HKEY_LOCAL_MACHINE;
     OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
       try
        SBCharges.down:=ReadBool('SBCharges');
        SBProduit.down:=ReadBool('SBProduit');
        EdDate.Text:=ReadString('label4');
       except
        SBCharges.down:=true;
        SBProduit.down:=false;
        EdDate.Text:= DateToStr(E.DatExoDebut);
        //EdDate.Text:=JourPrecedent(E.DatExoDebut,1).DateStr;
       end;
    end;
   finally
    Registre.Free;
   end;
 SBCharges.Tag:=1;
 SBProduit.Tag:=2;
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
 LastSize:=0;
end;
//****************************************************************************//

procedure TChargeCA_Isa.GestionBoutonsSpeed;
begin
if SBCharges.Down=true then
    begin
    EdCompte.Text:=  DM_C_CompteChargeConstateeDAvance;
    EdLibelle.Text := DMPlan.LibelleDuNumCptPCU(EdCompte.Text);
    DMChargeCA.CompteDeChargeOuDeProduit:= EdCompte.Text;
    DMChargeCA.LibelleCompteDeChargeOuDeProduit:= EdLibelle.Text;
    SBCharges.Font.Color:=clRed;
    SBProduit.Font.Color:=clWindowText;
    end
    else
    begin
    EdCompte.Text:=  DM_C_CompteProduitConstateDAvance;
    EdLibelle.Text := DMPlan.LibelleDuNumCptPCU(EdCompte.Text);
    DMChargeCA.CompteDeChargeOuDeProduit:= EdCompte.Text;
    DMChargeCA.LibelleCompteDeChargeOuDeProduit:= EdLibelle.Text;

    SBProduit.Font.Color:=clRed;
    SBCharges.Font.Color:=clWindowText;
    end;
end;



procedure TChargeCA_Isa.InitialisationCaption(tab_bis:integer);
begin
 // Le premier chiffre du tag représente : 1 = ouverture
 Case tab_bis Of
   1,11,12 : Begin
              ChangementEtatGrille(DBGridChargesCA);
              EdDate.Text:= DateToStr(E.DatExoDebut);
              Patitre.Color:=$00ADEBFF;

              if SBCharges.Down then
               begin
                RxLabTitre.Caption:='Ouverture : Charges constatés d''avance';
                RxSBImport.Hint:='Importer les Charges constatés d''avance d''Epicéa-2 DOS';
               end
                else
                 begin
                   RxLabTitre.Caption:='Ouverture : Produits constatés d''avance';
                   RxSBImport.Hint:='Importer les Produits constatés d''avance d''Epicéa-2 DOS';
                 end;
            End;
  // Le premier chiffre du tag représente : 2 = cloture
   2,21,22 : Begin
              ChangementEtatGrille(DBGridChargesCA);
              EdDate.Text:=DateToStr(E.DatExoFin);
              Patitre.Color:=$0033CCFF;

              if SBCharges.Down then
              RxLabTitre.Caption:='Clôture : Charges constatés d''avance'
              else RxLabTitre.Caption:='Clôture : Produits constatés d''avance';
            End;
   End;
end;


//****************************************************************************//
// Click sur le bouton Insérer.                                               //
//****************************************************************************//
procedure TChargeCA_Isa.BtnInsererClick(Sender: TObject);
begin
TableAjoute(DMChargeCA.TaPCA);
end;
//****************************************************************************//



//****************************************************************************//
// Gestion des touches.                                                       //
//****************************************************************************//
procedure TChargeCA_Isa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   Texte: String;
begin
FlagChargeCACourant:=(ssCtrl in Shift);
   If Key = VK_ESCAPE Then
     Begin

       If DMChargeCA.TaPCA.State = dsBrowse Then
          begin
            if DBGridChargesCA.Focused then Self.Close else DBGridChargesCA.SetFocus;
          end;

       If DMChargeCA.TaPCA.State = dsInsert Then
          Begin
               Case self.tag Of
                    11,21: Texte := 'Annuler la création de cette charge constatée d''avance ?';
                    12,22: Texte := 'Annuler la création de ce produit constaté d''avance ?';
               End; // Fin du Case

               If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                 DMChargeCA.TaPCA.Cancel;
                 Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End; // Fin utilisateur est en mode Insertion

          // Si l'utilisateur est en mode Modification
          If DMChargeCA.TaPCA.State = dsEdit Then
          Begin
               Case self.tag Of
                    11,21: Texte := 'Annuler la modification de cette charge constatée d''avance ?';
                    12,22: Texte := 'Annuler la modification de ce produit constaté d''avance ?';
               End; // Fin du Case

               If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                 DMChargeCA.TaPCA.Cancel;
                 Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End; // Fin utilisateur est en mode Modification
     End; // Fin appui sur la touche ESCAPE
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la suppression d'un produit constaté d'avance.                  //
//****************************************************************************//
procedure TChargeCA_Isa.BtnSupprimerClick(Sender: TObject);
begin
   try
   TableGereDelete(DMChargeCA.TaPCA);
   except
   abort;
   end;
end;
//****************************************************************************//


//****************************************************************************//
// Libération de la mémoire.                                                  //
//****************************************************************************//
Procedure TChargeCA_Isa.InitialiseTable_A_Nil;
Begin
     //DMChargeCA.DataPCA.OnStateChange:=nil;
     if DMChargeCA <> nil then
     InitDatasetEvent_A_Nil_Sur_Form([DMChargeCA.DataPCA]);
End;

procedure TChargeCA_Isa.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
      try

      Registre:= TRegistry.Create;

       InitialiseTable_A_Nil;
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;
            OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, True);
            WriteBool('SBCharges',SBCharges.down);
            WriteBool('SBProduit',SBProduit.down);
            WriteString('label4',EdDate.Text);
            CloseKey;
         end;
      finally
         Registre.Free;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     if DMChargeCA <> nil then
       DMChargeCA.Free;
     ChargeCA_Isa :=nil;
      end;
//   End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Fermer.                                     //
//****************************************************************************//
procedure TChargeCA_Isa.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de l'évènement OnClose de la fenêtre.                              //
//****************************************************************************//
procedure TChargeCA_Isa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//     DMChargeCA.EffaceBookmark;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TChargeCA_Isa.BtnEnregistrerClick(Sender: TObject);
begin
  try
     EnregistrementAutomatique;
  except
  abort;
  end;//fin du try
end;

//****************************************************************************//
// Gestion du click sur le bouton Modifier.                                   //
//****************************************************************************//
procedure TChargeCA_Isa.BtnModifierClick(Sender: TObject);
begin
DMChargeCA.TaPCA.Edit;
end;
procedure TChargeCA_Isa.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
end;


//****************************************************************************//
// Gestion du click sur le Speed Boutom Charges.                              //
//****************************************************************************//
procedure TChargeCA_Isa.SBChargesClick(Sender: TObject);
begin

// if (sender is TRxSpeedButton) then
//    (sender as TRxSpeedButton).Down:=true;
      SBCharges.down:=true;
// Initialisation des SpeedsBoutons
     GestionBoutonsSpeed;
     // Initialisation des Captions
     InitialisationCaption(self.tag);
     tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBCharges.tag));
     DMChargeCA.tag:=self.Tag;
     quand:=strtoint_lgr(copy(inttostr(tag),1,1))-1;
     DMChargeCA.FiltrageAffichageGrille(self.tag);
     quoi:=SBCharges.tag;


     DMChargeCA.DataPCA.OnStateChange(DMChargeCA.TaPCA);
     Mark := Nil;
GereAccesEcran;

end;
//****************************************************************************//

procedure TChargeCA_Isa.DBGridChargesCAColExit(Sender: TObject);
var
controleSaisie:TErreurSaisie;
begin
      if DBGridChargesCA.DataSource.State in [dsinsert,dsEdit] then
      begin// si table en insertion ou modif
      controleSaisie:=DMChargeCA.CtrlSaisieChargesCA(DBGridChargesCA.SelectedField);
       if controleSaisie.Retour=false then
           case controleSaisie.CodeErreur of
           8100:begin
                  //Focus sur compte2
                  DMChargeCA.LaisserPasser:=false;
                  DBGridChargesCA.DataSource.DataSet.Fields[8].FocusControl;//isa 5-11-02
                  abort;
                end;
           8101,8200:begin
                  //focus sur compte2
                  DBGridChargesCA.DataSource.DataSet.Fields[8].FocusControl;
                  abort;//champ code emprunt
                end;
           5100:begin
                  //focus sur MontantHT
                  DBGridChargesCA.DataSource.DataSet.Fields[5].FocusControl;
                  abort;//champ code emprunt
                end;
           end;//fin du case
      if DBGridChargesCA.SelectedField.FieldNo=9 then //Si compte2
        begin
         BtnEnregistrer.Enabled:=true;
         Enregister1.Enabled:=true;
        end;
      end;//fin si table en insertion ou modif
end;

//****************************************************************************//
                  // GESTION DES TOUCHES KeyUp, KeyDown, F1 //
//****************************************************************************//
procedure TChargeCA_Isa.DBGridChargesCAKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if DMChargeCA.DataPCA.State in [dsBrowse] then
 if not DBGridChargesCA.ReadOnly then
   if ((key=VK_INSERT) and (Shift=[ssCtrl])) then BtnInserer.Click;
if ((key=VK_INSERT) and (Shift=[])) then key:=0;
end;


procedure TChargeCA_Isa.EnregistrementAutomatique;
begin
if DMChargeCA.TaPCA.State in [dsinsert,dsEdit] then
  try
  TableGerePost(DMChargeCA.TaPCA);
  except
  abort;
  end;//fin du try
end;

procedure TChargeCA_Isa.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
initialisationMAJ_Balance(RxMAJ_Balance);
if PaTitre.Visible then
 begin
  SBCharges.Parent:=PaTitre;
  SBCharges.Top:=22;
  SBCharges.Width:=185;
  SBCharges.Height:=21;

  SBProduit.Parent:=PaTitre;
  SBProduit.Top:=22;
  SBProduit.Width:=185;
  SBProduit.Height:=21;
 end
 else
 begin
  SBCharges.Parent:=PaTools;
  SBCharges.Top:=2;
  SBCharges.Width:=185;
  SBCharges.Height:=22;
  if RxSBImport.Visible then
     SBCharges.Left:=77+69
     else
     SBCharges.Left:=52+69;

  SBProduit.Parent:=PaTools;
  SBProduit.Top:=2;
  SBProduit.Width:=185;
  SBProduit.Height:=22;
 end;
if Patitre.visible then
 begin
  N2.Visible:=true;
  Prcdent1.Visible:=true;
  Suivant1.Visible:=true;
  Prcdent1.Enabled:=true;
  Suivant1.Enabled:=true;
 end
 else
 begin
  N2.Visible:=false;
  Prcdent1.Visible:=false;
  Suivant1.Visible:=false;
  Prcdent1.Enabled:=false;
  Suivant1.Enabled:=false;
 end;

  if SBCharges.Down then
    begin
      tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBCharges.Tag));
      quoi:=SBCharges.Tag;
    end
    else
    begin
      tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBProduit.Tag));
      quoi:=SBProduit.Tag;
    end;
 DMChargeCA.tag:=self.Tag;
 quand:=strtoint_lgr(copy(inttostr(tag),1,1))-1;
 case strtoint_lgr(copy(inttostr(ChargeCA_Isa.Tag),1,1)) of
   1:Begin//si ouverture, champ reprise boolean
//      GrDbGridInitColonne(DBGridChargesCA,DMChargeCA.DataPCA,DMChargeCA.TaPCA,
//         ['Reprise','Compte','Désignation','Quantité','Montant HT'],
//         ['Reprise','Compte2','Libelle2','Qte','MontantHT']
//         ,E.FormatMonnaie,E.EditFormat);
      GrDbGridInitColonne(DBGridChargesCA,DMChargeCA.DataPCA,DMChargeCA.TaPCA,
         ['Compte','Désignation','Quantité','Montant HT'],
         ['Compte2','Libelle2','Qte','MontantHT']
         ,E.FormatMonnaie,E.EditFormat);
     // RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
     End;//fin si ouverture, champ reprise boolean
   2:Begin//si clôture, champ reprise devient valeur référence
//      GrDbGridInitColonne(DBGridChargesCA,DMChargeCA.DataPCA,DMChargeCA.TaPCA,
//         ['Référence','Compte','Désignation','Quantité','Montant HT'],
//         ['Reference','Compte2','Libelle2','Qte','MontantHT']
//         ,E.FormatMonnaie,E.EditFormat);
      GrDbGridInitColonne(DBGridChargesCA,DMChargeCA.DataPCA,DMChargeCA.TaPCA,
         ['Compte','Désignation','Quantité','Montant HT'],
         ['Compte2','Libelle2','Qte','MontantHT']
         ,E.FormatMonnaie,E.EditFormat);
      RxSBImport.Visible := False;
     End;//fin si clôture, champ reprise devient valeur référence
 end;//fin du case tag
PaGrilleResize(PaGrille);
  // Initialisation des Captions
  InitialisationCaption(self.tag);
  GestionBoutonsSpeed;
case DMChargeCA.DataPCA.state of
   dsedit,dsinsert: begin
                    end;
   dsbrowse:begin
             DMChargeCA.FiltrageAffichageGrille(self.tag);
            end;
end;
  DBGridChargesCA.ParamColor:=true;
  DBGridChargesCA.Param:=ParamUtil.CouleurDBGrid;
  DBGridChargesCA.UpDateColor;
  CouleurFond([Panel1,PaTools,PaBtn,PaBas],ParamUtil.CouleurPanelCorps);

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.DessineContourLigne:=false;
  GrGrid1.UpDateColor;
  GrGrid1.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

  DMChargeCA.DataPCA.OnStateChange:=changementEtatBoutons;
  DMChargeCA.DataPCA.OnStateChange(DMChargeCA.TaPCA);
  GestionInitDM;
GereAccesEcran;
end;



procedure TChargeCA_Isa.PatitreResize(Sender: TObject);
begin
//RxSpeedButton1.top:=13;
RxSpeedButton1.Left:=Patitre.Width-104;
//RxSpeedButton1.Height:=Patitre.Height-24;

//SBProduit.top:=12;
SBProduit.Left:=Patitre.Width-287;
//SBProduit.Height:=Patitre.Height-24;
end;

procedure TChargeCA_Isa.RxSpeedButton2Click(Sender: TObject);
begin
 Case Self.Tag Of
      1,11,12 : begin
           Self.Tag:=1;
           Main.Chargesrpartir1Click(Main.Chargesrpartir1);
          end;
      2,21,22 : begin
           Self.Tag:=2;
            Main.StoksdeFin1Click(Main.StoksdeFin1);
          end;
 End; // Fin du Case
end;

procedure TChargeCA_Isa.RxSpeedButton1Click(Sender: TObject);
begin
 Case Self.Tag Of
      1,11,12 : begin
           Self.Tag:=1;
              Main.Cetprecevoir1Click(Main.Cetprecevoir1);
          end;
      2,21,22 : begin
           Self.Tag:=2;
              Main.Chargespayeretproduitsrecevoir3Click(Main.Chargespayeretproduitsrecevoir3);
          end;
 End; // Fin du Case


end;

procedure TChargeCA_Isa.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TChargeCA_Isa.PaGrilleResize(Sender: TObject);
begin
//FormateTailleColonne(DBGridChargesCA,13,[2,2,4,2,2]);
FormateTailleColonne(DBGridChargesCA,13,[2,4,2,2]);
PositionTotaux;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TChargeCA_Isa.FormResize(Sender: TObject);
begin
if self.Width < 450 then
     if LastSize > self.Width
       then
           begin
          LastSize:=self.Width;
           abort;
           end;
LastSize:=self.Width;
end;

procedure TChargeCA_Isa.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBGridChargesCA Then
  begin
   case DBGridChargesCA.DataSource.State of
      dsedit,dsInsert:case self.tag of
                  1,11,12:case DBGridChargesCA.SelectedField.FieldNo of
                            9:begin //si colonne 1 (compte) selectionnée
                                DMChargeCA.GestionFiltrageAideCompte(DBGridChargesCA);
                                DBGridChargesCA.EditorMode:=true;
                                AideCompteAffiche(DBGridChargesCA.InplaceEditor,True,False,True,True,0);
                                DBGridChargesCA.DataSource.DataSet.Fields[8].AsString:=DBGridChargesCA.InplaceEditor.Text;
                              end;// fin si colonne compte selectionnée
                           end;
                  2,21,22:case DBGridChargesCA.SelectedField.FieldNo of
                            9:begin //si colonne 1 (compte) selectionnée
                                DMChargeCA.GestionFiltrageAideCompte(DBGridChargesCA);
                                DBGridChargesCA.EditorMode:=true;
                                AideCompteAffiche(DBGridChargesCA.InplaceEditor,True,False,True,True,0);
                                DBGridChargesCA.DataSource.DataSet.Fields[8].AsString:=DBGridChargesCA.InplaceEditor.Text;
                              end;// fin si colonne compte selectionnée
                           end;
                      end;
      dsbrowse:case self.tag of
                  1,11,12:case DBGridChargesCA.SelectedField.FieldNo of
                            13:Rechercher(DBGridChargesCA,DMChargeCA.TaPCA,['Reference','Compte2','Libelle2','DateSaisie','ID','Compte'],['Références','Compte','Libellé','Date Saisie','',''],'',0);
                            9:Rechercher(DBGridChargesCA,DMChargeCA.TaPCA,['Compte2','Libelle2','Reference','DateSaisie','ID','Compte'],['Compte','Libelle','Références','Date Saisie','',''],'',0);
                            10:Rechercher(DBGridChargesCA,DMChargeCA.TaPCA,['Libelle2','Compte2','Reference','DateSaisie','ID','Compte'],['Libellé','Compte','Références','Date Saisie','',''],'',0);
                           end;
                  2,21,22:case DBGridChargesCA.SelectedField.FieldNo of
                            13:Rechercher(DBGridChargesCA,DMChargeCA.TaPCA,['Reference','Compte2','Libelle2','DateSaisie','ID','Compte'],['Références','Compte','Libellé','Date Saisie','',''],'',0);
                            9:Rechercher(DBGridChargesCA,DMChargeCA.TaPCA,['Libelle2','Compte2','Reference','DateSaisie','ID','Compte'],['Libellé','Compte','Références','Date Saisie','',''],'',0);
                            10:Rechercher(DBGridChargesCA,DMChargeCA.TaPCA,['Libelle2','Compte2','Reference','DateSaisie','Compte','ID','Compte'],['Libellé','Compte','Références','Date Saisie','',''],'',0);
                           end;
               end;
   end;
 end;
end;

procedure TChargeCA_Isa.FormDeactivate(Sender: TObject);
begin
if self.tag in [2,21,22] Then self.tag:=2;
if self.tag in [1,11,12] Then self.tag:=1;
e.TypeMAJBalance:=MAJ_Normal;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargeCA_Isa.DBGridChargesCAColEnter(Sender: TObject);
begin
if  DBGridChargesCA.DataSource.State in [dsinsert,dsedit] then
   if  DBGridChargesCA.SelectedField.FieldNo =5 then
     DMChargeCA.RecupInfoApresVerif(false);
end;


procedure TChargeCA_Isa.BtnImprimerClick(Sender: TObject);
var
Site:TEditLien;
//ObjPrn:TObjetEdition;
ListeValeur:TStringList;
i:integer;
begin
case Quand of
   C_Ouverture:begin
               case E.Type_Edition of
                   C_IMP_MOZiLLA_LOCAL:Begin
                         EditionChargeCA(C_EditionSimple,C_Ouverture,nil,nil,Site);

                                       End;

                   C_IMP_NORMAL:Begin
                                 if FlagChargeCACourant then
                                 EditionChargeCAL(C_EditionSimple,C_Ouverture,quoi,nil,DMChargeCA.TaPCA.FindField('Compte').AsString,DMChargeCA.TaPCA.FindField('Compte2').AsString,Site)
                                 else
                                 EditionChargeCAL(C_EditionSimple,C_Ouverture,quoi,nil,nil,nil,Site);
                                 FlagChargeCACourant:=False;
                                End;

                   C_IMP_MOZiLLA_WEB:Begin

                                     End;

                   else showmessage('Type_Edition non défini');
                 end;
             end;
   C_Cloture:begin
                case E.Type_Edition of
                   C_IMP_MOZiLLA_LOCAL:Begin
                         EditionChargeCA(C_EditionSimple,C_Cloture,DMChargeCA.TaPCA,nil,Site);
                                       End;

                   C_IMP_NORMAL:Begin
                                 if FlagChargeCACourant then
                                 EditionChargeCAL(C_EditionSimple,C_Cloture,quoi,nil,DMChargeCA.TaPCA.FindField('Compte').AsString,DMChargeCA.TaPCA.FindField('Compte2').AsString,Site)
                                 else
                                 EditionChargeCAL(C_EditionSimple,C_Cloture,quoi,nil,nil,nil,Site);
                                 FlagChargeCACourant:=False;
                                End;

                   C_IMP_MOZiLLA_WEB:Begin

                                     End;

                   else showmessage('Type_Edition non défini');
                   end;
              end;
//
end;
//case self.tag of
//   11,12:EditionChargeCA(C_EditionSimple,C_Ouverture,nil,nil,Site);
//   21,22:EditionChargeCA(C_EditionSimple,C_Cloture,nil,nil,Site);
//end;
end;

procedure TChargeCA_Isa.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TChargeCA_Isa.Aideenligne1Click(Sender: TObject);
begin
if AideAssist = Nil then AideAssist:= TAideAssist.Create(Self);
if AideAssist.Visible then
     begin
      AideAssist.close;
      self.show;
     end
     else begin
      AideAssist.Show;
      self.show;
     end;
end;

procedure TChargeCA_Isa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   Texte: String;
begin
canclose:=true;
if DMChargeCA <> nil then
 begin
try
  // Si l'utilisateur est en mode Insertion
     If DMChargeCA.TaPCA.State = dsInsert Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If BtnEnregistrer.Enabled Then
          Begin
               Case self.tag Of
                    11,21: Texte := 'Voulez-vous enregistrer cette nouvelle charge constatée d''avance ?';
                    12,22: Texte := 'Voulez-vous enregistrer ce nouveau produit constaté d''avance ?';
               End; // Fin du Case
               If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
                  begin
                       TableGerePost(DMChargeCA.TaPCA);
                  end else
                  begin
                       DMChargeCA.TaPCA.Cancel;
                  end;
          End
          Else
          Begin
               Case self.tag Of
                    11,21: Texte := 'Voulez-vous annuler la création de cette charge constatée d''avance ?';
                    12,22: Texte := 'Voulez-vous annuler la création de ce produit constaté d''avance ?';
               End; // Fin du Case
               If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
                  DMChargeCA.TaPCA.Cancel;
                 end
               Else
                 begin
                   canclose:=false;
                 end;

          End;
     end;
     // Si l'utilisateur est en mode Modification
     If DMChargeCA.TaPCA.State = dsEdit Then
     Begin
       self.WindowState:=wsNormal;
       self.BringToFront;
          Case self.tag Of
               11,21: Texte := 'Voulez-vous enregistrer les modifications de cette charge constatée d''avance ?';
               12,22: Texte := 'Voulez-vous enregistrer les modifications de ce produit constaté d''avance ?';
          End; // Fin du Case

          If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
           begin
              TableGerePost(DMChargeCA.TaPCA);
           end
              else
               DMChargeCA.TaPCA.Cancel;
     End; // Fin utilisateur est en mode Modification

     If Self.Tag in [2,21,22] Then
      begin
       FiltrageDataSet(DMChargeCA.TaPCA2,'DateSaisie = '''+DateTimeToStr(E.DatExoFin)+''' And Reference = ''''');
       if DMChargeCA.TaPCA2.RecordCount>0 then
       begin
         try
         DMChargeCA.CreationODChargeCACloture;
         self.tag:=0;
         except
           showmessage('Problème à la création des OD ');
           abort;
         end;
        DMChargeCA.DemandeAffichageReprise;
       end;//fin si od à créer
      end;//fin si écran de clôture
except
  canclose:=false;
end;
if CanClose then
 begin
   InitialiseTable_A_Nil;{ isa  le  29/01/04 }
   //DMChargeCA.DataPCA.OnStateChange:=nil;
 end
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;
//if aidecompte<>nil then
//aidecompte.DefiltrageAideCompte;
AssistantClotRafraichit(3);
  try
//    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
//      Begin
//        if Cloture_Def.EtapeSuivante>=4 then
//          Cloture_Def.EtapeSuivante:=3;{ isa  le  16/09/03 }
//      end;
  except
    //
  end;
end;
end;
procedure TChargeCA_Isa.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TChargeCA_Isa.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TChargeCA_Isa.Visualisation1Click(Sender: TObject);
begin
if DBGridChargesCA.SelectedField.FieldNo = 9 then
 begin
  if DBGridChargesCA.InplaceEditor <> nil then
   begin
      if DBGridChargesCA.InplaceEditor.Visible then
        DetailEcritureCompte(DBGridChargesCA.InplaceEditor.Text,true,False)
         else
         DetailEcritureCompte(DMChargeCA.TaPCA.FindField('Compte2').AsString,true,False);
   end
   else
    DetailEcritureCompte(DMChargeCA.TaPCA.FindField('Compte2').AsString,true,False);
 end
 else DetailEcritureCompte(DMChargeCA.TaPCA.FindField('Compte2').AsString,true,False);

end;

procedure TChargeCA_Isa.RxSpeedButton3Click(Sender: TObject);
begin
DetailEcritureCompte(EdCompte.Text,true,False);
end;

procedure TChargeCA_Isa.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(ChargeCA_IsaRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TChargeCA_Isa.PaToolsResize(Sender: TObject);
begin
if not PaTitre.Visible then
 begin
    SBProduit.Left:=PaTools.Width-188;
 end;
end;

Procedure TChargeCA_Isa.PositionTotaux;
Begin
//   Panel7.Width:=RenvoiTailleColonne(DBGridChargesCA,[0,1,2,3,4])+10;
//   GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBGridChargesCA,[5]);
   Panel7.Width:=RenvoiTailleColonne(DBGridChargesCA,[0,1,2,3])+10;
   GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBGridChargesCA,[4]);
End;
procedure TChargeCA_Isa.SBProduitClick(Sender: TObject);
begin
// if (sender is TRxSpeedButton) then
//    (sender as TRxSpeedButton).Down:=true;
      SBProduit.down:=true;
// Initialisation des SpeedsBoutons
     GestionBoutonsSpeed;
     // Initialisation des Captions
     InitialisationCaption(self.tag);
     tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBProduit.tag));
     DMChargeCA.tag:=self.Tag;
     quand:=strtoint_lgr(copy(inttostr(tag),1,1))-1;
     quoi:=SBProduit.tag;
     DMChargeCA.FiltrageAffichageGrille(self.tag);


     DMChargeCA.DataPCA.OnStateChange(DMChargeCA.TaPCA);
     Mark := Nil;
GereAccesEcran;
end;

procedure TChargeCA_Isa.RxSBImportClick(Sender: TObject);
begin
case tag of
   11:Begin
        DMChargeCA.TaPCA.DisableControls;
        DMImport.Import_ChCAvance(DMChargeCA.TaPCA,true);
        changementEtatBoutons(DMChargeCA.TaPCA);
        DMChargeCA.TaPCA.EnableControls;
      End;

   12:Begin
        DMChargeCA.TaPCA.DisableControls;
        DMImport.Import_PrCAvance(DMChargeCA.TaPCA,true);
        changementEtatBoutons(DMChargeCA.TaPCA);
        DMChargeCA.TaPCA.EnableControls;
      End;

   21,22:Begin

         End;

end;

end;

Procedure TChargeCA_Isa.GereAccesEcran;
begin
  case self.tag of
     11,12:Begin
                  DBGridChargesCA.ReadOnly := not E.AccesOuverture;
                  DBGridChargesCA.FSauteColReadOnly := not DBGridChargesCA.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesOuverture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesOuverture);
                 End;

     21,22:Begin
                  DBGridChargesCA.ReadOnly := not E.AccesCloture;
                  DBGridChargesCA.FSauteColReadOnly := not DBGridChargesCA.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesCloture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesCloture);
               End;
  end;
DMChargeCA.GestionAccesChargesCA;
end;

Procedure TChargeCA_Isa.GestionInitDM;
var
ParamDMChargeCA:TParamDMChargeCA;
Begin
 ParamDMChargeCA.ChargeCADataStateChange := changementEtatBoutons;
 ParamDMChargeCA.Quand := self.Quand;
 ParamDMChargeCA.Quoi := self.Quoi;
 ParamDMChargeCA.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 InitialiseDMChargeCA(ParamDMChargeCA);
End;

procedure TChargeCA_Isa.Imprimerdecomptecourant1Click(Sender: TObject);
begin
FlagChargeCACourant:=true;
BtnImprimer.Click;
end;

procedure TChargeCA_Isa.PopupMenu1Popup(Sender: TObject);
begin
Imprimerdecomptecourant1.Caption := 'Imprimer le compte : '+ DBGridChargesCA.DataSource.DataSet.findField('Compte').AsString;
end;

procedure TChargeCA_Isa.RxMAJ_BalanceClick(Sender: TObject);
begin
Activation_Desactivation_MAJ_Balance;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargeCA_Isa.RxMAJ_BalanceMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clREd;
(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TChargeCA_Isa.RxMAJ_BalanceMouseLeave(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
(Sender as TRxSpeedButton).Font.Style:=[];
end;

procedure TChargeCA_Isa.RxMAJ_BalanceMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargeCA_Isa.Exporter1Click(Sender: TObject);
var
nom:string;
begin
case self.tag of
   11:nom:='Ch_C_A_Ouv_';
   21:nom:='Ch_C_A_Clôt_';
   12:nom:='Prod_C_A_Ouv_';
   22:nom:='Prod_C_A_Clôt_';
end;
ExportDonnees(DBGridChargesCA.DataSource.DataSet,E.RepertoireExportDossier,nom+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TChargeCA_Isa.Calculatrice1Click(Sender: TObject);
begin
if DBGridChargesCA.Col in [4] then
  AfficheCalculatrice(DBGridChargesCA)
else
  AfficheCalculatrice(nil);
end;

end.
