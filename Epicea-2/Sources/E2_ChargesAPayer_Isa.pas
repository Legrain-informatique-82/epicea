unit E2_ChargesAPayer_Isa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db, Gr_MiseAJourBalance,
  DBTables, E2_AideCompte, LibSQL, Menus, Buttons, DBCtrls,registry,
  RXDBCtrl, ExRxDBGrid,AideMontant2,DMTVA,
  RXCtrls,
  GrDBGrid,
  LibZoneSaisie,
  E2_AssistantClotureDef,
  DMEcriture,
  LibRessourceString,
  E2_Decl_Records,
  Mask,
  ToolEdit,
  E2_Cloture_Def,
  GrGrid,
  E2_LibInfosTable,
  DMConstantes,
  Editions,
  LibGestionParamXML,
  Lib_Chaine,
  ObjetEdition,
  DMPiece,
  jpeg;

type
  TChargesAPayer_Isa = class(TForm)
    Patitre: TPanel;
    SBPAP: TRxSpeedButton;
    SBCAP: TRxSpeedButton;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaBas: TPanel;
    PaLabel: TPanel;
    PaGrille: TPanel;
    DBGridChAPayer: TGrDBGrid;
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
    RxSpeedButton3: TRxSpeedButton;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSpeedButton4: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    Label6: TLabel;
    Label5: TLabel;
    NumCpt: TEdit;
    EdLibelle: TEdit;
    EdDate: TDateEdit;
    PaCumul1: TPanel;
    Panel7: TPanel;
    GrGrid1: TGrGrid;
    RxSBImport: TRxSpeedButton;
    ListedesChargesetProduits1: TMenuItem;
    Imprimerlachargescourante1: TMenuItem;
    RxMAJ_Balance: TRxSpeedButton;
    Exporter1: TMenuItem;
    procedure AideEnLigne(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure SBPAPClick(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure DBGridChAPayerColExit(Sender: TObject);
    procedure DBGridChAPayerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure GestionBoutonsSpeed;
    procedure NumCptExit(Sender: TObject);
    procedure InitialisationCaption(tab_bis:integer);
    procedure EnregistrementAutomatique;
    procedure PatitreResize(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure TraitementAideTVA;
    procedure AppelAideCompte(Grille:boolean);
    procedure DBGridChAPayerColEnter(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Aideenligne1Click(Sender: TObject);
    procedure NumCptKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridChAPayerEnter(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure NumCptEnter(Sender: TObject);
    procedure SBCAPClick(Sender: TObject);
    procedure NumCptChange(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure RxSpeedButton3Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure PaToolsResize(Sender: TObject);
    Procedure PositionTotaux;
    procedure RxSBImportClick(Sender: TObject);
    Procedure GereAccesEcran;
    procedure ListedesChargesetProduits1Click(Sender: TObject);
    procedure Imprimerlachargescourante1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    Procedure GestionInitDM(AffichePreListe:boolean=true);
    procedure FormDeactivate(Sender: TObject);
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
  ChargesAPayer_Isa: TChargesAPayer_Isa;
  LastSize:integer;
//  SpeedButtonDown:TComponentName;
//  CompteParDefaut:string;
  MessDerSub,CptValidePourBaseRegistre:boolean;
  Charges,Produits:TDernierValide;
  //  DernierCptValide,DernierLibValide:string;
  DernierSBValide:TComponentName;
  FlagChargesAPayerCourant:boolean;
implementation

uses DMChargesAPayer,DMPlanCpt, E2_Main,E2_Recherche,
  {UQReport,} E2_AideAssist, DMAide, DMRecherche, DMImportation,
  LibClassObjetSenders,DMCorrection,DMExports, ImportDll;

{$R *.DFM}


//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.AideEnLigne(Sender: TObject);
var
   result:boolean;
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

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.EnregistrementAutomatique;
begin
if DMChargeAPayer.TaChAPayer.State in [dsinsert,dsEdit] then
  try
  TableGerePost(DMChargeAPayer.TaChAPayer);
  except
  abort;
  end;//fin du try
end;

//******************* TChargesAPayer_Isa.InitialisationCaption *************************

//************************************************************************************

procedure TChargesAPayer_Isa.InitialisationCaption(tab_bis:integer);
begin
 // Le premier chiffre du tag représente : 1 = ouverture
   Case tab_bis Of
          1,11,12: Begin
                  EdDate.text := DateToStr(E.DatExoDebut);
                  if SBCAP.Down then
                   begin
                     RxLabTitre.Caption:='Ouverture : Charges à payer';
                     RxSBImport.Hint:='Importer les Charges à payer d''Epicéa-2 DOS';
                   end
                    else
                     begin
                      RxLabTitre.Caption:='Ouverture : Produits à recevoir';
                      RxSBImport.Hint:='Importer les Produits à recevoir d''Epicéa-2 DOS';
                     end;
//                  Patitre.Color:=$00E8FFFF;
               Patitre.Color:=$00ADEBFF;
               PaTools.Color:=$00ADEBFF;
             End;
 // Le premier chiffre du tag représente : 2 = cloture
          2,21,22: Begin
                  EdDate.text := DateToStr(E.DatExoFin);
                  if SBCAP.Down then
                  RxLabTitre.Caption:='Clôture : Charges à payer'
                  else RxLabTitre.Caption:='Clôture : Produits à recevoir';
//                  Patitre.Color:=$00A4A4FF;
              Patitre.Color:=$0033CCFF;
              PaTools.Color:=$0033CCFF;
             End;
   End;
end;


//******************* TChargesAPayer_Isa.GestionBoutonsSpeed *************************

//************************************************************************************

procedure TChargesAPayer_Isa.GestionBoutonsSpeed;
begin
if SBCAP.Down=true then
    begin
    SBCAP.Font.Color:=clRed;
    SBPAP.Font.Color:=clWindowText;
    end
    else
    begin
    SBPAP.Font.Color:=clRed;
    SBCAP.Font.Color:=clWindowText;
    end;
end;

//******************* TChargesAPayer_Isa.changementEtatBoutons *************************

//************************************************************************************

procedure TChargesAPayer_Isa.changementEtatBoutons(Sender: TObject);
var
TotauxGeneric:TTotauxGeneric;
begin
  case DMChargeAPayer.TaChAPayer.state of
   dsBrowse: begin
               NumCpt.Enabled:=true;
               BtnInserer.Enabled := True;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := Not(DMChargeAPayer.TaChAPayer.RecordCount = 0);
               BtnSupprimer.Enabled := Not(DMChargeAPayer.TaChAPayer.RecordCount = 0);
               BtnImprimer.Enabled:=true;
               SBCAP.Enabled := True;
               SBPAP.Enabled := True;

               FiltrageDataSet(DMRech.TaChargeAPayerRech,DBGridChAPayer.DataSource.DataSet.Filter);
               TotauxGeneric:=SommeTotauxGeneric(['MontantHT','TVA'],DMRech.TaChargeAPayerRech);
               GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
               GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
               DeFiltrageDataSet(DMRech.TaChargeAPayerRech);
             end;

   dsEdit:   begin
               NumCpt.Enabled:=False;
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := True;
               BtnModifier.Enabled := false;
               BtnSupprimer.Enabled := false;
               BtnImprimer.Enabled:=false;
               SBCAP.Enabled := False;
               SBPAP.Enabled := False;
             end;

   dsInsert: begin
               EnableWinControl([NumCpt,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
//               NumCpt.Enabled:=False;
               SBCAP.Enabled := False;
               SBPAP.Enabled := False;
             end;
   end;//fin du case.state$
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;

   ChangementEtatGrille(DMChargeAPayer.TaChAPayer);
end;


//******************* TChargesAPayer_Isa.ChangementEtatGrille *************************

//************************************************************************************

procedure TChargesAPayer_Isa.ChangementEtatGrille(Sender: TObject);
begin

DBGridChAPayer.OnColExit:=nil;

case self.tag of
   11,21:SousTitre2Form:='[ Charges ]';
   12,22:SousTitre2Form:='[ Produits ]';
end;
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMChargeAPayer.TaChAPayer)+' - '+ SousTitre2Form;

   case DMChargeAPayer.TaChAPayer.state of
   dsBrowse: begin
               DBGridChAPayer.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               if activeControl <> NumCpt then DBGridChAPayer.SetFocus;
               if DBGridChAPayer.InplaceEditor <> nil then
                  DBGridChAPayer.EditorMode:=false;
               DBGridChAPayer.TitreColor(true);
             end;

   dsEdit:   begin
               DBGridChAPayer.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               if activeControl <> NumCpt then DBGridChAPayer.SetFocus;
               DBGridChAPayer.TitreColor(true);
             end;

   dsInsert: begin
               DBGridChAPayer.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
//               DBGridChAPayer.SelectedIndex := 1;
               if activeControl <> NumCpt then DBGridChAPayer.SetFocus;
               DBGridChAPayer.TitreColor(true);
             end;
   end;//fin du case.state
DBGridChAPayer.OnColExit:= DBGridChAPayerColExit;
end;




//****************************************************************************//
// Gestion de la création de la fenêtre.                                      //
//****************************************************************************//

procedure TChargesAPayer_Isa.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);

 if DMChargeAPayer=nil then
 DMChargeAPayer:=TDMChargeAPayer.Create(self);

 DBGridChAPayer.FSauteColReadOnly:=true;
 Registre:= TRegistry.Create;
 FlagChargesAPayerCourant:=false;
 //RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
   try
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              SBCAP.down:=ReadBool('SBCAP');
              SBPAP.down:=ReadBool('SBPAP');
              charges.DernierCpt:=ReadString('NumCptCharges');
              charges.DernierLibelle:=ReadString('label4charges');
              Produits.DernierCpt:=ReadString('NumCptProduits');
              Produits.DernierLibelle:=ReadString('label4Produits');
//              NumCpt.Text:=ReadString('NumCpt');
//              EdLibelle.text:=ReadString('label4');
            except
              SBCAP.down:=true;
              SBPAP.down:=false;
              charges.DernierCpt:='';
              charges.DernierLibelle:='';
              Produits.DernierCpt:='';
              Produits.DernierLibelle:='';
//              NumCpt.Text:='';
//              EdLibelle.text:='';

            end;
         end;
   finally
		Registre.Free;
   end;
     SBCAP.Tag:=1;
     SBPAP.Tag:=2;
     if SBCAP.Down then
       begin
//         SpeedButtonDown:=SBCAP.Name;
         NumCpt.Text:=charges.DernierCpt;
         EdLibelle.text:=charges.DernierLibelle;
       end
     else
       begin
//         SpeedButtonDown:=SBPAP.Name;
         NumCpt.Text:=produits.DernierCpt;
         EdLibelle.text:=produits.DernierLibelle;
       end;
     if empty(NumCpt.Text)or(not DMPlan.CompteExistePCU(NumCpt.Text)) then
        if SBCAP.Down then
           begin
            NumCpt.Text:=DM_C_CompteChargeAPayerDefaut;
            EdLibelle.text:='Fournisseurs. Factures non par';
            charges.DernierCpt:=NumCpt.Text;
            charges.DernierLibelle:=EdLibelle.text;
            end
           else
            begin
            NumCpt.Text:=DM_C_CompteProduitARecevoirDefaut;
            EdLibelle.text:='Clients - factures à établir';
            Produits.DernierCpt:=NumCpt.Text;
            Produits.DernierLibelle:=EdLibelle.text;
            end;
//DernierLibValide:=EdLibelle.text;
//DernierCptValide:=NumCpt.Text;

    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
 LastSize:=0;
 MessDerSub:=true;
end;

//****************************************************************************//
// Gestion du click sur le bouton Insérer.                                    //
//****************************************************************************//
procedure TChargesAPayer_Isa.BtnInsererClick(Sender: TObject);
begin
 TableAjoute(DMChargeAPayer.TaChAPayer);
end;

//****************************************************************************//
// Gestion des touches dans la fenêtre.                                       //
//****************************************************************************//

procedure TChargesAPayer_Isa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   Texte: String;
begin
FlagChargesAPayerCourant:=(ssCtrl in Shift);
WinSuivPrec(Handle,key,[DBGridChAPayer,DBGridChAPayer.InplaceEditor]);
     // Si appui sur la touche ESC
if DMChargeAPayer <> nil then
 begin
     If ((Key = VK_ESCAPE) and (self.Visible)) Then
     Begin
       If DMChargeAPayer.TaChAPayer.State = dsBrowse Then
          begin
            if DBGridChAPayer.Focused then Self.Close;
//            if NumCpt.Focused then
//               begin
//               NumCpt.OnExit:=nil;
//               DBGridChAPayer.SetFocus;
//               NumCpt.OnExit:=NumCptExit;
//               end;
          end;

       // Si l'utilisateur est en mode Insertion
       If DMChargeAPayer.TaChAPayer.State = dsInsert Then
          Begin
               Case self.tag Of
                    1,11,21: Texte := 'Annuler la création de cette charge à payer ?';
                    2,12,22: Texte := 'Annuler la création de ce produit à recevoir ?';
               End; // Fin du Case

               If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMChargeAPayer.TaChAPayer.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End; // Fin utilisateur est en mode Insertion

       // Si l'utilisateur est en mode Modification
       If DMChargeAPayer.TaChAPayer.State = dsEdit Then
          Begin
               Case self.tag Of
                    1,11,21: Texte := 'Annuler les modifications de cette charge à payer ?';
                    2,12,22: Texte := 'Annuler les modifications de ce produit à recevoir ?';
               End; // Fin du Case

               If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMChargeAPayer.TaChAPayer.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End; // Fin utilisateur est en mode Modification
     End; // Fin appui sur la touche ESC

if key=VK_ESCAPE then
 begin
//    NumCpt.Text:=DernierCptValide;
//    SpeedButtonDown:=DernierSBValide;
    if DernierSBValide='SBCAP'then
      begin
        SBCAP.Down:=true;
        tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBCAP.tag));
        numcpt.Text:=charges.DernierCpt;
        EdLibelle.text:=charges.DernierLibelle;
      end
    else
      begin
        SBPAP.Down:=true;
        tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBPAP.tag));
        numcpt.Text:=Produits.DernierCpt;
        EdLibelle.text:=Produits.DernierLibelle;
      end;
    GestionBoutonsSpeed;
    InitialisationCaption(self.tag);
    DMChargeAPayer.GestionFiltrageAideCompte(numcpt);
    DMChargeAPayer.FiltreVide;
    DMChargeAPayer.tag:=self.Tag;
    if self.visible then
    DBGridChAPayer.SetFocus;
    key:=0;
 end;
end;
end;

Procedure TChargesAPayer_Isa.InitialiseTable_A_Nil;
Begin
     //DMChargeAPayer.DataChAPayer.OnStateChange:=nil;
     if DMChargeAPayer<>nil then
       InitDatasetEvent_A_Nil_Sur_Form([DMChargeAPayer.DataChAPayer]);
End;

//****************************************************************************//
// Libération de la mémoire.                                                  //
//****************************************************************************//

procedure TChargesAPayer_Isa.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin

      Registre:= TRegistry.Create;

      try
        InitialiseTable_A_Nil;
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;

            OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, True);
              MessDerSub:=false;
//            if CptValidePourBaseRegistre then
            begin
              WriteBool('SBCAP',SBCAP.down);
              WriteBool('SBPAP',SBPAP.down);
              WriteString('NumCptCharges',charges.DernierCpt);
              WriteString('label4charges',charges.DernierLibelle);
              WriteString('NumCptProduits',Produits.DernierCpt);
              WriteString('label4Produits',Produits.DernierLibelle);
            end;
            CloseKey;
         end;
      finally
         Registre.Free;
      end;
//   End;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     if DMChargeAPayer<>nil then
       DMChargeAPayer.Free;
     ChargesAPayer_Isa := Nil;
end;

//****************************************************************************//
// Gestion du click sur le bouton Fermer.                                     //
//****************************************************************************//

procedure TChargesAPayer_Isa.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;

//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//

procedure TChargesAPayer_Isa.BtnEnregistrerClick(Sender: TObject);
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

procedure TChargesAPayer_Isa.BtnModifierClick(Sender: TObject);
begin
DMChargeAPayer.TaChAPayer.Edit;
end;

//****************************************************************************//
// Gestion du click sur le bouton Supprimer.                                  //
//****************************************************************************//

procedure TChargesAPayer_Isa.BtnSupprimerClick(Sender: TObject);
begin
   try
   TableGereDelete(DMChargeAPayer.TaChAPayer);
   except
      abort;
   end;
end;

//****************************************************************************//
// Gestion du click sur le SpeedBouton Produit à Recevoir.                    //
//****************************************************************************//

procedure TChargesAPayer_Isa.SBPAPClick(Sender: TObject);
//var
//CptObl:boolean;
begin
 if ((not empty(numcpt.Text))and(SBPAP.Down=false)) then
    begin
      Charges.DernierCpt:=numcpt.Text;
      Charges.DernierLibelle:=EdLibelle.text;
    end;

        SBPAP.Down:=true;
        GestionBoutonsSpeed;
        // Initialisation des Captions
        InitialisationCaption(self.tag);
        numcpt.Text:=Produits.DernierCpt;
        EdLibelle.Text:=Produits.DernierLibelle;
//        numcpt.setfocus;
        DMChargeAPayer.FiltreVide;
        Self.tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBPAP.tag));
        DMChargeAPayer.tag:=self.Tag;
        //DMChargeAPayer.QuandQuoi:=DMChargeAPayer.tag;
        Self.quand:=strtoint_lgr(copy(inttostr(tag),1,1))-1;
        Self.quoi:=SBPAP.tag;
        DMChargeAPayer.GestionFiltrageAideCompte(numcpt);
       GestionInitDM(false);
       if not empty(DMChargeAPayer.CompteChargeOuProduit) then
         begin
           numcpt.Text:=DMChargeAPayer.CompteChargeOuProduit;
           EdLibelle.Text:=dmplan.LibelleDuNumCptPCU(numcpt.Text);
         end;
       numcpt.setfocus;
//SpeedButtonDown:=(sender as TRxSpeedButton).Name;
ChangementEtatGrille(DBGridChAPayer);
GereAccesEcran;

end;

//****************************************************************************//
// Contrôler la saisie dans la grille.                                        //
//****************************************************************************//

procedure TChargesAPayer_Isa.DBGridChAPayerColExit(Sender: TObject);
var
controleSaisie:TErreurSaisie;
begin
      if DBGridChAPayer.DataSource.State in [dsinsert,dsEdit] then
      begin // si table en insertion ou modif
      controleSaisie:=DMChargeAPayer.CtrlSaisieChargesAPayer(DBGridChAPayer.SelectedField);
      if controleSaisie.Retour=false then
           case controleSaisie.CodeErreur of
           8100:begin
                  //Focus sur compte2
                  DMChargeAPayer.LaisserPasser:=false;
//                  if ((not empty(DBGridChAPayer.DataSource.DataSet.Fields[8].asstring))and(controleSaisie.CodeErreur<>8101))then
//                    begin
//                    if application.MessageBox(Pchar('Ce compte n''est pas cohérent dans ce context, voulez-vous continuer'),'Erreur de saisie',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mrno then
//                      Begin//si
//                        DBGridChAPayer.DataSource.DataSet.Fields[8].FocusControl;//isa 5-11-02
//                        abort;
//                      End//fin si
//                    else
//                      DMChargeAPayer.LaisserPasser:=true;
//                    end
//                  else
//                    Begin//si
                      DBGridChAPayer.DataSource.DataSet.Fields[8].FocusControl;//isa 5-11-02
                      abort;
//                    End;//fin si
                end;
      8101,8200:begin
                  //Focus sur compte2
                  DBGridChAPayer.DataSource.DataSet.Fields[8].FocusControl;//isa 5-11-02
                  abort;
                end;
           5100:begin
                  //focus sur MontantHT
                  DBGridChAPayer.DataSource.DataSet.Fields[5].FocusControl;//isa 5-11-02
                  abort;
                end;
           end;//fin du case
      //if DBGridChAPayer.SelectedIndex=1 then
      if DBGridChAPayer.SelectedField.FieldNo = 9 then //si compte2
        begin
          BtnEnregistrer.Enabled:=true;
          Enregister1.Enabled:=true;
        end;
      end;//fin si table en insertion ou modif
end;

//****************************************************************************//
// Gestion des touches dans la grille.                                        //
//****************************************************************************//

procedure TChargesAPayer_Isa.DBGridChAPayerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if DMChargeAPayer.TaChAPayer.State in [dsBrowse] then
 if not DBGridChAPayer.ReadOnly then
  if ((key=VK_INSERT) and (Shift=[ssCtrl])) then BtnInserer.Click;
if ((key=VK_INSERT) and (Shift=[])) then key:=0;
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.FormActivate(Sender: TObject);
begin
DMChargeAPayer.DataChAPayer.OnStateChange:=changementEtatBoutons;
Initialiser_ShortCut_Main(true);
initialisationMAJ_Balance(RxMAJ_Balance);
Patitre.visible:=Main.AfficheTitre;
if PaTitre.Visible then
 begin
  SBCAP.Parent:=PaTitre;
  SBCAP.Top:=22;
  SBCAP.Width:=185;
  SBCAP.Height:=21;

  SBPAP.Parent:=PaTitre;
  SBPAP.Top:=22;
  SBPAP.Width:=185;
  SBPAP.Height:=21;
 end
 else
 begin
  SBCAP.Parent:=PaTools;
  SBCAP.Top:=2;
  SBCAP.Width:=185;
  SBCAP.Height:=22;
  if RxSBImport.Visible then
     SBCAP.Left:=77+69
     else
     SBCAP.Left:=52+69;

  SBPAP.Parent:=PaTools;
  SBPAP.Top:=2;
  SBPAP.Width:=185;
  SBPAP.Height:=22;
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

   if SBCAP.Down then
     begin
       tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBCAP.tag));
       quoi:=SBCAP.Tag;
     end
   else
     begin
       tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBPAP.tag));
       quoi:=SBPAP.Tag;
     end;
   DMChargeAPayer.Tag:=tag;
// DMChargeAPayer.QuandQuoi:=DMChargeAPayer.tag;
   quand:=strtoint_lgr(copy(inttostr(tag),1,1))-1;
  InitialisationCaption(self.tag);
  GestionBoutonsSpeed;
GestionInitDM(false);

Numcpt.Text:=DMChargeAPayer.CompteChargeOuProduit;
if not NumCpt.Focused then
  if (DMChargeAPayer.TaChAPayer.State in [dsbrowse]) then
     begin
     DMChargeAPayer.FiltrageAffichageGrille(self.tag,Numcpt.Text);
     DMChargeAPayer.DataChAPayer.OnStateChange(DMChargeAPayer.TaChAPayer);
   end;

 DBGridChAPayer.ParamColor:=true;
 DBGridChAPayer.Param:=ParamUtil.CouleurDBGrid;
 DBGridChAPayer.UpDateColor;

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.DessineContourLigne:=false;
  GrGrid1.UpDateColor;
  GrGrid1.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

  CouleurFond([PaLabel,PaTools,PaBtn,PaBas],ParamUtil.CouleurPanelCorps);

 case strtoint_lgr(copy(inttostr(ChargesAPayer_Isa.Tag),1,1)) of
   1:Begin//si ouverture, champ reprise boolean
//      GrDbGridInitColonne(DBGridChAPayer,DMChargeAPayer.DataChAPayer,DMChargeAPayer.TaChAPayer,
//         ['Reprise','Compte','Désignation','Quantité','Montant HT','Montant Tva'],
//         ['Reprise','Compte2','Libelle2','Qte','MontantHT','TVA']
//         ,E.FormatMonnaie,E.EditFormat);
      GrDbGridInitColonne(DBGridChAPayer,DMChargeAPayer.DataChAPayer,DMChargeAPayer.TaChAPayer,
         ['Compte','Désignation','Quantité','Montant HT','Montant Tva'],
         ['Compte2','Libelle2','Qte','MontantHT','TVA']
         ,E.FormatMonnaie,E.EditFormat);
     // RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
     End;//fin si ouverture, champ reprise boolean
   2:Begin//si cloture, champ reprise devient valeur référence
//      GrDbGridInitColonne(DBGridChAPayer,DMChargeAPayer.DaTaChAPayer,DMChargeAPayer.TaChAPayer,
//         ['Référence','Compte','Désignation','Quantité','Montant HT','Montant Tva'],
//         ['Reference','Compte2','Libelle2','Qte','MontantHT','TVA']
//         ,E.FormatMonnaie,E.EditFormat);
      GrDbGridInitColonne(DBGridChAPayer,DMChargeAPayer.DaTaChAPayer,DMChargeAPayer.TaChAPayer,
         ['Compte','Désignation','Quantité','Montant HT','Montant Tva'],
         ['Compte2','Libelle2','Qte','MontantHT','TVA']
         ,E.FormatMonnaie,E.EditFormat);
      RxSBImport.Visible := False;
     End;//fin si ouverture, champ reprise devient valeur référence
 end;//fin du case tag
//if Type_version_execution=CT_DEVELOPPEMENT then DMChargeAPayer.AfficheListe:=true;

GereAccesEcran;
PaGrilleResize(PaGrille);

end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.NumCptExit(Sender: TObject);
var
Infosplancpt:TInfosplancpt;
begin
try
DMChargeAPayer.GestionFiltrageAideCompte(numcpt);
if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
  begin
    NumCpt.SetFocus;
    abort;
  end
else
 if VerifSiCompteSaisieDsBO(NumCpt.text,true,DMChargeAPayer.TaChAPayer,self.Tag in [1,11,12]) then
  begin
    NumCpt.SetFocus;
    abort;
  end
 else
 if activecontrol <> BtnFermer then
    begin
      DMChargeAPayer.FiltrageAffichageGrille(self.Tag,Numcpt.Text);
      DMChargeAPayer.DataChAPayer.OnStateChange(DMChargeAPayer.TaChAPayer);
      DeFiltrageDataSet(DMRech.TaPlanCptRech);
      Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[numcpt.text]);

      PaGrilleResize(PaGrille);
      if Infosplancpt.ResultInfos then
      EdLibelle.text:=Infosplancpt.Libelle;
    end;
MessDerSub:=true;
if SBCAP.Down then
  Begin
    if not empty(EdLibelle.text)then
    charges.DernierLibelle:=EdLibelle.text;
     if not empty(NumCpt.Text)then
    charges.DernierCpt:=NumCpt.Text;
  End
  else
  Begin
    if not empty(EdLibelle.text)then
    Produits.DernierLibelle:=EdLibelle.text;
    if not empty(NumCpt.Text)then
    Produits.DernierCpt:=NumCpt.Text;
  End;
except
  raise;
  GereAccesEcran;
end;
DMChargeAPayer.CompteChargeOuProduit:=NumCpt.text;
GereAccesEcran;
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.PatitreResize(Sender: TObject);
begin
//RxSpeedButton1.top:=12;
RxSpeedButton1.Left:=Patitre.Width-104;
//RxSpeedButton1.Height:=Patitre.Height-24;

//SBPAP.top:=12;
SBPAP.Left:=Patitre.Width-287;
//SBPAP.Height:=Patitre.Height-24;
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.RxSpeedButton2Click(Sender: TObject);
begin
case self.tag of
   1,11,12:Main.Cetpconstatsdavance1Click(Main.Cetpconstatsdavance1);
   2,21,22:Main.Chargesetproduitsconstatsdavance2Click(Main.Chargesetproduitsconstatsdavance2);
end;
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.RxSpeedButton1Click(Sender: TObject);
begin
case self.tag of
   1,11,12:Main.Provisions1Click(Main.Provisions1);
   2,21,22:Main.Chargesrpartir2Click(Main.Chargesrpartir2);
end;
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.PaGrilleResize(Sender: TObject);
begin
//DBGridChAPayer.ColWidths[1]:=(DBGridChAPayer.Width) div 8;
//DBGridChAPayer.ColWidths[2]:=(DBGridChAPayer.Width) div 9;
//DBGridChAPayer.ColWidths[3]:=(DBGridChAPayer.Width) div 3;
//DBGridChAPayer.ColWidths[4]:=(DBGridChAPayer.Width) div 13;
//DBGridChAPayer.ColWidths[5]:=(DBGridChAPayer.Width) div 5;
//DBGridChAPayer.ColWidths[6]:=(DBGridChAPayer.Width) div 10;

DBGridChAPayer.ColWidths[1]:=(DBGridChAPayer.Width) div 9;
DBGridChAPayer.ColWidths[2]:=(DBGridChAPayer.Width) div 3;
DBGridChAPayer.ColWidths[3]:=(DBGridChAPayer.Width) div 13;
DBGridChAPayer.ColWidths[4]:=(DBGridChAPayer.Width) div 5;
DBGridChAPayer.ColWidths[5]:=(DBGridChAPayer.Width) div 10;

PositionTotaux;

try
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
except
  Main.Shape1.Free;
  Main.Shape2.Free;
end;

end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.FormResize(Sender: TObject);
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

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBGridChAPayer Then
  begin
   case DBGridChAPayer.DataSource.State of
      dsinsert,dsedit:case self.tag of
             1,11,12:case DBGridChAPayer.SelectedField.FieldNo of
                       9:AppelAideCompte(true);
                       11:begin
                         if  DBGridChAPayer.SelectedField.ReadOnly=false then
                             TraitementAideTVA
                             else
                             showmessage('Ce Compte n''attends pas de TVA');
                         end;
                     end;

             2,21,22:case DBGridChAPayer.SelectedField.FieldNo of
                        9:AppelAideCompte(true);
                        11:begin
                         if  DBGridChAPayer.SelectedField.ReadOnly=false then
                             TraitementAideTVA
                             else
                             showmessage('Ce Compte n''attends pas de TVA');
                         end;
                     end;
               end;

      dsbrowse:case self.tag of
                  1,11,12:  case DBGridChAPayer.SelectedField.FieldNo of
                            14:Rechercher(DBGridChAPayer,DMChargeAPayer.TaChAPayer,['Reference','Compte2','Libelle2','DateSaisie','ID','Compte'],['Références','Compte','Libellé','Date Saisie','',''],'',0);
                            9:Rechercher(DBGridChAPayer,DMChargeAPayer.TaChAPayer,['Compte2','Libelle2','Reference','DateSaisie','ID','Compte'],['Compte','Libelle','Références','Date Saisie','',''],'',0);
                            10:Rechercher(DBGridChAPayer,DMChargeAPayer.TaChAPayer,['Libelle2','Compte2','Reference','DateSaisie','ID','Compte'],['Libellé','Compte','Références','Date Saisie','',''],'',0);
                            end;

                  2,21,22:  case DBGridChAPayer.SelectedField.FieldNo of
                            14:Rechercher(DBGridChAPayer,DMChargeAPayer.TaChAPayer,['Reference','Compte2','Libelle2','DateSaisie','ID','Compte'],['Références','Compte','Libellé','Date Saisie','',''],'',0);
                            9:Rechercher(DBGridChAPayer,DMChargeAPayer.TaChAPayer,['Compte2','Libelle2','Reference','DateSaisie','ID','Compte'],['Compte','Libellé','Références','Date Saisie','',''],'',0);
                            10:Rechercher(DBGridChAPayer,DMChargeAPayer.TaChAPayer,['Libelle2','Compte2','Reference','DateSaisie','Compte2','ID','Compte'],['Libellé','Références','Compte','Date Saisie','',''],'',0);
                            end;
               end;
   end;
 end;
 If activecontrol = NumCpt Then
  begin
   case DMChargeAPayer.DataChAPayer.State of
      dsbrowse:case self.tag of
                  1,11,12: AppelAideCompte(false);

                  2,21,22: AppelAideCompte(false);
               end;//fin du case tag
   end;//fin du case state
 end;//fin si activecontrol = numcpt
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.TraitementAideTVA;
var
resultat:TAideMontantTTC2RetFunction;
//Enregistrement:TEnregistrementComplet;
RetourTva:TRecupMiniMaxTva;
Infosplancpt:TInfosplancpt;
InplaceTmp:TInplaceEdit;
begin
DeFiltrageDataSet(DMRech.TaPlanCptRech);
Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[DBGridChAPayer.datasource.DataSet.Fields[8].AsString]);
// Enregistrement:=DmPlanRecupEnregistrementComplet(DBGridChAPayer.Columns[1].Field.AsString);
       if Infosplancpt.ResultInfos then
         begin//si le compte a été trouvé
            if not(empty(Infosplancpt.TvaCode))then
            RetourTva:=FTvaRecupMiniMaxTva(Infosplancpt.TvaCode);
         end;//fin si le compte a été trouvé
try
 InplaceTmp:=TInplaceEdit.Create(self);
 IF DBGridChAPayer.InplaceEditor<>nil then
   begin
     if DBGridChAPayer.InplaceEditor.Visible then
       InplaceTmp.Text:=DBGridChAPayer.InplaceEditor.Text;
   end;
 if empty(InplaceTmp.text)then InplaceTmp.text:='0';
    if DBGridChAPayer.SelectedField.FieldNo = 6 then
       begin
       if empty(DBGridChAPayer.datasource.DataSet.Fields[10].Asstring)then
         DBGridChAPayer.datasource.DataSet.Fields[10].Asinteger:=0;
            case retourtva.CodeRetour of
              1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,StrToFloat_Lgr(InplaceTmp.text),DBGridChAPayer.datasource.DataSet.Fields[10].asfloat],3,True,[InplaceTmp],[4],E.DeviseSigle[1]);
              2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,StrToFloat_Lgr(InplaceTmp.text),DBGridChAPayer.datasource.DataSet.Fields[10].asfloat],3,True,[InplaceTmp],[4],E.DeviseSigle[1]);
             12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,StrToFloat_Lgr(InplaceTmp.text),DBGridChAPayer.datasource.DataSet.Fields[10].asfloat,retourtva.Taux_Supp,0,StrToFloat_Lgr(InplaceTmp.text),DBGridChAPayer.datasource.DataSet.Fields[10].asfloat],3,True,[InplaceTmp],[4],E.DeviseSigle[1]);
            end;//fin du case retourTva
       end;//fin si champ 6
    if DBGridChAPayer.SelectedField.FieldNo = 11 then
       begin
       if empty(DBGridChAPayer.datasource.DataSet.Fields[5].Asstring)then
       DBGridChAPayer.datasource.DataSet.Fields[5].Ascurrency:=0;
         case retourtva.CodeRetour of
            1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridChAPayer.datasource.DataSet.Fields[5].asfloat,StrToFloat_Lgr(InplaceTmp.text)],3,True,[InplaceTmp],[4],E.DeviseSigle[1]);
            2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,DBGridChAPayer.datasource.DataSet.Fields[5].asfloat,StrToFloat_Lgr(InplaceTmp.text)],3,True,[InplaceTmp],[4],E.DeviseSigle[1]);
           12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridChAPayer.datasource.DataSet.Fields[5].asfloat,StrToFloat_Lgr(InplaceTmp.text),retourtva.Taux_Supp,0,DBGridChAPayer.datasource.DataSet.Fields[5].asfloat,StrToFloat_Lgr(InplaceTmp.text)],3,True,[InplaceTmp],[4],E.DeviseSigle[1]);
         end;//fin du case retourTva
       end;//fin si champ 11
//    end;
//    else //si editeur mode =false
//    begin
//    if currtostr(DBGridChAPayer.Columns[4].Field.Ascurrency)='' then
//    DBGridChAPayer.Columns[4].Field.Ascurrency:=0;
//    if inttostr(DBGridChAPayer.Columns[5].Field.asinteger)='' then
//    DBGridChAPayer.Columns[5].Field.asinteger:=0;
////        case retourtva.CodeRetour of
////            1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
////            2:resultat:=AideMontantAffiche([0,retourtva.Taux_Supp,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
////           12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,retourtva.Taux_Supp,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
////         end;//fin du case retourTva
//    end;
// end // fin si editeur deja crée
// else
// begin //si editeur pas crée
// if currtostr(DBGridChAPayer.Columns[4].Field.Ascurrency)='' then
// DBGridChAPayer.Columns[4].Field.Ascurrency:=0;
// if inttostr(DBGridChAPayer.Columns[5].Field.asinteger)='' then
// DBGridChAPayer.Columns[5].Field.asinteger:=0;
////         case retourtva.CodeRetour of
////            1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
////            2:resultat:=AideMontantAffiche([0,retourtva.Taux_Supp,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
////           12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,retourtva.Taux_Supp,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
////         end;//fin du case retourTva
// end;

if resultat.Retour then
  begin
  DBGridChAPayer.datasource.DataSet.Fields[5].AsCurrency:=resultat.HT;
  DBGridChAPayer.datasource.DataSet.Fields[10].AsCurrency:=resultat.TVA;
  end;
finally
 inplacetmp.free;
 inplacetmp:=nil;
end;//fin du try finally
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.AppelAideCompte(Grille:boolean);
begin
if grille then
   begin
   if DBGridChAPayer.SelectedField.FieldNo = 9 then
         begin //si colonne 1 (compte) selectionnée
         DMChargeAPayer.GestionFiltrageAideCompte(DBGridChAPayer);
         MessDerSub:=false;
         AideCompteDansContexte(DBGridChAPayer.datasource.DataSet.Fields[8].AsString,DBGridChAPayer.datasource.DataSet.Fields[8],['Rac1','Rac2','Rac3','Rac4','Rac5'],true,MessDerSub,false,true,false,true,0);
         MessDerSub:=true;

//         DBGridChAPayer.EditorMode:=true;
//         AideCompte.InitialiseCompte;
//         AideCompteAffiche(DBGridChAPayer.InplaceEditor);
//         DBGridChAPayer.Columns[1].Field.AsString:=DBGridChAPayer.InplaceEditor.Text;
         end;// fin si colonne compte selectionnée
   end
else
   begin
   DMChargeAPayer.GestionFiltrageAideCompte(numcpt);
   MessDerSub:=false;
   AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],true,MessDerSub,false,true,false,true,0);
   MessDerSub:=true;
//   AideCompte.InitialiseCompte;
//   AideCompteAffiche(NumCpt);
   end;
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.DBGridChAPayerColEnter(Sender: TObject);
begin
if  DBGridChAPayer.DataSource.State in [dsinsert,dsedit] then
   if  DBGridChAPayer.SelectedField.FieldNo in [5,11] then
       begin
         DMChargeAPayer.RecupInfoApresVerif(false);
         if ((DBGridChAPayer.SelectedField.FieldNo=11) and DBGridChAPayer.SelectedField.ReadOnly) then
            Begin

            End;

       end;
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.BtnImprimerClick(Sender: TObject);
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
                         EditionChargeAPayer(C_EditionSimple,C_Ouverture,nil,nil,Site);

                                       End;

                   C_IMP_NORMAL:Begin
                                 if FlagChargesAPayerCourant then
                                 EditionChargesAPayerL(C_EditionSimple,C_Ouverture,quoi,nil,DMChargeAPayer.TaChAPayer.FindField('Compte').AsString,DMChargeAPayer.TaChAPayer.FindField('Compte2').AsString,Site)
                                 else
                                 EditionChargesAPayerL(C_EditionSimple,C_Ouverture,quoi,nil,nil,nil,Site);
                                 FlagChargesAPayerCourant:=False;
                                End;

                   C_IMP_MOZiLLA_WEB:Begin

                                     End;

                   else showmessage('Type_Edition non défini');
                 end;
             end;
   C_Cloture:begin
                case E.Type_Edition of
                   C_IMP_MOZiLLA_LOCAL:Begin
                         EditionChargeAPayer(C_EditionSimple,C_Cloture,DMChargeAPayer.TaChAPayer,nil,Site);
                                       End;

                   C_IMP_NORMAL:Begin
                                 if FlagChargesAPayerCourant then
                                 EditionChargesAPayerL(C_EditionSimple,C_Cloture,quoi,nil,DMChargeAPayer.TaChAPayer.FindField('Compte').AsString,DMChargeAPayer.TaChAPayer.FindField('Compte2').AsString,Site)
                                 else
                                 EditionChargesAPayerL(C_EditionSimple,C_Cloture,quoi,nil,nil,nil,Site);
                                 FlagChargesAPayerCourant:=False;
                                End;

                   C_IMP_MOZiLLA_WEB:Begin

                                     End;

                   else showmessage('Type_Edition non défini');
                   end;
              end;
//
end;
//case self.tag of
//   11,12:EditionChargeAPayer(C_EditionSimple,C_Ouverture,nil,nil,Site);
//   21,22:EditionChargeAPayer(C_EditionSimple,C_Cloture,nil,nil,Site);
//end;

end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

//****************************************************************************//
// Gestion de la fermeture de la fenêtre.                                     //
//****************************************************************************//
procedure TChargesAPayer_Isa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   Texte: String;
begin
try
canclose:=true;
if DMChargeAPayer <> nil then
 begin
     // Si l'utilisateur est en mode Insertion
     If DMChargeAPayer.TaChAPayer.State = dsInsert Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If BtnEnregistrer.Enabled Then
          Begin
               Case self.tag Of
                    11,21: Texte := 'Voulez-vous enregistrer cette charge à payer ?';
                    12,22: Texte := 'Voulez-vous enregistrer ce produit à recevoir ?';
               End; // Fin du Case
               If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
                  begin
                   TableGerePost(DMChargeAPayer.TaChAPayer);
                   canclose:=true;
                 end
                 else
                 begin
                  DMChargeAPayer.TaChAPayer.Cancel;
                   canclose:=true;
                 end;
          End
          Else
          Begin
               Case self.tag Of
                    11,21: Texte := 'Voulez-vous annuler la création de cette charge à payer ?';
                    12,22: Texte := 'Voulez-vous annuler la création de ce produit à recevoir ?';
               End; // Fin du Case
               If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
                  DMChargeAPayer.TaChAPayer.Cancel;
                  canclose:=true;
                end
               Else
                begin
                  canclose:=false;
                end;
          End;
     End; // Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DMChargeAPayer.TaChAPayer.State = dsEdit Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          Case self.tag Of
               11,21: Texte := 'Voulez-vous enregistrer les modifications de cette charge à payer ?';
               12,22: Texte := 'Voulez-vous enregistrer les modifications de ce produit à recevoir ?';
          End; // Fin du Case

          If Messagedlg(Texte,MtConfirmation,[mbyes,mbno],0) = mryes Then
           begin
             TableGerePost(DMChargeAPayer.TaChAPayer);
             canclose:=true;
           end
           else
             begin
                  DMChargeAPayer.TaChAPayer.Cancel;
                   canclose:=true;
             end;

     End; // Fin utilisateur est en mode Modification

     If Self.Tag in [2,21,22] Then
     begin
     FiltrageDataSet(DMChargeAPayer.TaChAPayer,'DateSaisie = '''+DateTimeToStr(E.DatExoFin)+''' And Reference = ''''');
       if DMChargeAPayer.TaChAPayer.RecordCount>0 then
       begin
         try
         DMChargeAPayer.CreationODChargeAPayerCloture;
         canclose:=true;
         except
           showmessage('Problème à la création des OD ');
//           canclose:=true;
           abort;
         end;
        DMChargeAPayer.DemandeAffichageReprise;
        self.tag:=0; // initialisation du tag sinon plusieurs passage
        canclose:=true;
       end;
   end;//fin si ecran de clôture
 end;
if not empty(NumCpt.Text) then
 begin
  if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.create(application.MainForm);
  DMChargeAPayer.GestionFiltrageAideCompte(NumCpt);
  MessDerSub:=false;
  if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,false,true,false,true,0)= false then
    begin
    if SBCAP.Down then
       Begin
         if not empty(EdLibelle.text)then
         charges.DernierLibelle:=EdLibelle.text;
         if not empty(NumCpt.Text)then
         charges.DernierCpt:=NumCpt.Text;
       End
       else
       Begin
         if not empty(EdLibelle.text)then
         Produits.DernierLibelle:=EdLibelle.text;
         if not empty(NumCpt.Text)then
         Produits.DernierCpt:=NumCpt.Text;
       End;
    end;
 end
else
 begin
 if SBCAP.Down then
   Begin
     if not empty(EdLibelle.text)then
     charges.DernierLibelle:=EdLibelle.text;
     if not empty(NumCpt.Text)then
     charges.DernierCpt:=NumCpt.Text;
   End
   else
   Begin
     if not empty(EdLibelle.text)then
     Produits.DernierLibelle:=EdLibelle.text;
     if not empty(NumCpt.Text)then
     Produits.DernierCpt:=NumCpt.Text;
   End;
 end;
except
  canclose:=false;
end;

if CanClose then
 begin
   InitialiseTable_A_Nil; { isa  le  29/01/04 }
//   DMChargeAPayer.dataChAPayer.OnStateChange:=nil;
 end
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;

AssistantClotRafraichit(4);
  try
//    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
//      begin
//      if Cloture_Def.EtapeSuivante>=3 then
//        Cloture_Def.EtapeSuivante:=2;
//      end;
  except
    //
  end;
end;

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.Aideenligne1Click(Sender: TObject);
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

//****************************************************************************//

//****************************************************************************//

procedure TChargesAPayer_Isa.NumCptKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (key in [#48..#57,#13,#8,#9,#27]) then key:=#0;

end;

procedure TChargesAPayer_Isa.DBGridChAPayerEnter(Sender: TObject);
begin
if SBCAP.Down then
  Begin
   if not empty(numcpt.Text)then
   charges.DernierCpt:=numcpt.Text;
   if not empty(EdLibelle.text)then
   charges.DernierLibelle:=EdLibelle.text;
   DernierSBValide:=SBCAP.Name;
  End
else
  Begin
   if not empty(numcpt.Text)then
   Produits.DernierCpt:=numcpt.Text;
   if not empty(EdLibelle.text)then
   Produits.DernierLibelle:=EdLibelle.text;
   DernierSBValide:=SBPAP.Name;
  End;
//DernierCptValide:=NumCpt.Text;
//DernierSBValide:=SpeedButtonDown;
end;

procedure TChargesAPayer_Isa.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TChargesAPayer_Isa.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TChargesAPayer_Isa.NumCptEnter(Sender: TObject);
begin
  EnableWinControl([BtnAnnuler,BtnFermer],True);
  EnableWinControl([BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
  //Pop menu
  EnableItemMenu([Annuler1,Fermer1],true);
  EnableItemMenu([Enregister1,Insrer1,Modifier1,Supprimer1,Imprimer1],False);
end;

procedure TChargesAPayer_Isa.SBCAPClick(Sender: TObject);
begin
 if ((not empty(numcpt.Text))and(SBCAP.Down=false)) then
   begin
     Produits.DernierCpt:=numcpt.Text;
     Produits.DernierLibelle:=EdLibelle.text;
   end;

 SBCAP.Down:=true;
 GestionBoutonsSpeed;
 // Initialisation des Captions
 InitialisationCaption(self.tag);

 numcpt.Text:=Charges.DernierCpt;
 EdLibelle.Text:=Charges.DernierLibelle;

 DMChargeAPayer.FiltreVide;
 tag:=strtoint_lgr((copy(inttostr(tag),1,1))+inttostr(SBCAP.tag));
 DMChargeAPayer.tag:=self.Tag;
// DMChargeAPayer.QuandQuoi:=DMChargeAPayer.tag;
 Self.quand:=strtoint_lgr(copy(inttostr(tag),1,1))-1;
 Self.quoi:=SBCAP.tag;
 DMChargeAPayer.GestionFiltrageAideCompte(numcpt);

 GestionInitDM(false);
       if not empty(DMChargeAPayer.CompteChargeOuProduit) then
         begin
           numcpt.Text:=DMChargeAPayer.CompteChargeOuProduit;
           EdLibelle.Text:=dmplan.LibelleDuNumCptPCU(numcpt.Text);
         end;
 numcpt.setfocus;
        // SpeedButtonDown:=(sender as TRxSpeedButton).Name;
ChangementEtatGrille(DBGridChAPayer);
GereAccesEcran;
end;

procedure TChargesAPayer_Isa.NumCptChange(Sender: TObject);
begin
DMChargeAPayer.CompteChargeOuProduit:=NumCpt.text;
end;

procedure TChargesAPayer_Isa.Visualisation1Click(Sender: TObject);
begin
if ActiveControl = DBGridChAPayer then
 begin
  if DBGridChAPayer.SelectedField.FieldNo =9 then
   begin
    if DBGridChAPayer.InplaceEditor <> nil then
     begin
        if DBGridChAPayer.InplaceEditor.Visible then
          DetailEcritureCompte(DBGridChAPayer.InplaceEditor.Text,true,False)
           else
           DetailEcritureCompte(DMChargeAPayer.TaChAPayer.FindField('Compte2').AsString,true,False);
     end
     else
      DetailEcritureCompte(DMChargeAPayer.TaChAPayer.FindField('Compte2').AsString,true,False);
   end
   else DetailEcritureCompte(DMChargeAPayer.TaChAPayer.FindField('Compte2').AsString,true,False);
  end;
if ActiveControl = NumCpt then
   Begin
     DetailEcritureCompte(NumCpt.text,true,False);
   End;

end;

procedure TChargesAPayer_Isa.RxSpeedButton3Click(Sender: TObject);
begin
DetailEcritureCompte(NumCpt.text,true,False);
end;

procedure TChargesAPayer_Isa.RxSBInfoVersionClick(Sender: TObject);
begin
 Showmessage(ChargesAPayer_IsaRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TChargesAPayer_Isa.PaToolsResize(Sender: TObject);
begin
if not PaTitre.Visible then
SBPAP.Left:=PaTools.Width-188;
end;

Procedure TChargesAPayer_Isa.PositionTotaux;
Begin
//   Panel7.Width:=RenvoiTailleColonne(DBGridChAPayer,[0,1,2,3,4])+10;
//   GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBGridChAPayer,[5]);
//   GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBGridChAPayer,[6]);

   Panel7.Width:=RenvoiTailleColonne(DBGridChAPayer,[0,1,2,3])+10;
   GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBGridChAPayer,[4]);
   GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBGridChAPayer,[5]);
End;

procedure TChargesAPayer_Isa.RxSBImportClick(Sender: TObject);
begin
case tag of
   11:Begin
        DMChargeAPayer.TaChAPayer.DisableControls;
        DMImport.Import_ChAPayer(DMChargeAPayer.TaChAPayer,True);
        changementEtatBoutons(DMChargeAPayer.TaChAPayer);
        DMChargeAPayer.TaChAPayer.EnableControls;
      End;

   12:Begin
        DMChargeAPayer.TaChAPayer.DisableControls;
        DMImport.Import_PrARecevoir(DMChargeAPayer.TaChAPayer,True);
        changementEtatBoutons(DMChargeAPayer.TaChAPayer);
        DMChargeAPayer.TaChAPayer.EnableControls;
      End;

   21,22:Begin

         End;

end;
end;

Procedure TChargesAPayer_Isa.GereAccesEcran;
begin
  case self.tag of
     11,12:Begin
                  DBGridChAPayer.ReadOnly := not E.AccesOuverture;
                  DBGridChAPayer.FSauteColReadOnly := not DBGridChAPayer.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesOuverture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesOuverture);
                 End;

     21,22:Begin
                  DBGridChAPayer.ReadOnly := not E.AccesCloture;
                  DBGridChAPayer.FSauteColReadOnly := not DBGridChAPayer.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesCloture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesCloture);
               End;
  end;
DMChargeAPayer.GestionAccesChargesAPayer;
//if DMChargeAPayer.AfficheListe then
//  ListedesChargesetProduits1.Click;
//DMChargeAPayer.AfficheListe:=false;  
end;

procedure TChargesAPayer_Isa.ListedesChargesetProduits1Click(
  Sender: TObject);
begin
//AffichChargesAPayerSurPeriode(DMChargeAPayer.Quand);
//if DMPieces.RetourViewListe.retour then
//   DMChargeAPayer.CompteChargeOuProduit:=DMPieces.RetourViewListe.VisuListeView.ItemCourantValeurCol(0);
GestionInitDM;
if not empty(DMChargeAPayer.CompteChargeOuProduit) then
  NumCpt.Text:=DMChargeAPayer.CompteChargeOuProduit
else
  DMChargeAPayer.CompteChargeOuProduit:=NumCpt.Text;
end;

procedure TChargesAPayer_Isa.Imprimerlachargescourante1Click(
  Sender: TObject);
begin
FlagChargesAPayerCourant:=true;
BtnImprimer.Click;
end;

procedure TChargesAPayer_Isa.PopupMenu1Popup(Sender: TObject);
begin
Imprimerlachargescourante1.Caption := 'Imprimer le compte : '+ DBGridChAPayer.DataSource.DataSet.findField('Compte').AsString;
end;


Procedure TChargesAPayer_Isa.GestionInitDM(AffichePreListe:boolean);
var
ParamDMChargeAPayer:TParamDMChargeAPayer;
Begin
 ParamDMChargeAPayer.ChargeAPayerDataStateChange := changementEtatBoutons;
 ParamDMChargeAPayer.Quand := self.Quand;
 ParamDMChargeAPayer.Quoi := self.Quoi;
 ParamDMChargeAPayer.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMChargeAPayer.Compte:=NumCpt.Text;
 ParamDMChargeAPayer.AfficheListe:=AffichePreListe;
 Numcpt.setfocus;
 InitialiseDMChargeAPayer(ParamDMChargeAPayer);
End;


procedure TChargesAPayer_Isa.FormDeactivate(Sender: TObject);
begin
e.TypeMAJBalance:=MAJ_Normal;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargesAPayer_Isa.RxMAJ_BalanceClick(Sender: TObject);
begin
Activation_Desactivation_MAJ_Balance;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargesAPayer_Isa.RxMAJ_BalanceMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clREd;
(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TChargesAPayer_Isa.RxMAJ_BalanceMouseLeave(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
(Sender as TRxSpeedButton).Font.Style:=[];
end;

procedure TChargesAPayer_Isa.RxMAJ_BalanceMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TChargesAPayer_Isa.Exporter1Click(Sender: TObject);
var
nom:string;
begin
case self.tag of
   11:nom:='Ch_A_Payer_Ouv_';
   21:nom:='Ch_A_Payer_Clôt_';
   12:nom:='Prod_A_Recevoir_Ouv_';
   22:nom:='Prod_A_Recevoir_Clôt_';
end;
ExportDonnees(DBGridChAPayer.DataSource.DataSet,E.RepertoireExportDossier,nom+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TChargesAPayer_Isa.Calculatrice1Click(Sender: TObject);
begin
if DBGridChAPayer.Col in [4,5] then
  AfficheCalculatrice(DBGridChAPayer)
else
  AfficheCalculatrice(nil);
end;

end.
