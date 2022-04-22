{***************************************************************
 *
 * Unit Name: E2_Tiers
 * Purpose  :
 * Author   : Assemat
 * History  :
 *
 ****************************************************************}

unit E2_Tiers;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  StdCtrls,
  gr_Librairie_obj,
  Buttons,
  ExtCtrls,
  DBCtrls,
  Db,
  DBTables,
  Mask,
  ShellAPI,
  DBClient,
  LibSQL,
  DMEcriture,
  DMTier,
  LibZoneSaisie,
  E2_Recherche,
  LibRessourceString,
  GrDBGrid,
  LibClassObjetSenders,
  DMPointages2,
  E2_Decl_Records,
  DMConstantes, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, ToolEdit, CurrEdit,
  RXCtrls,
  E2_VisuListeView,
  ComCtrls,
  jpeg,
  LibGestionParamXML,
  FM_INIT_COLOR,
  lib_chaine,
  ChoixPeriode,
  E2_Patientez,
  editions,
  LibChoixCompte;

type

  TTiers = class(TT_INIT_COLOR)
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Panel5: TPanel;
    Panel4: TPanel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel3: TRxLabel;
    CurrencyEdit1: TCurrencyEdit;
    CurrencyEdit2: TCurrencyEdit;
    CurrencyEdit3: TCurrencyEdit;
    BtnDetail: TButton;
    PaFd6: TPanel;
    PaFd: TPanel;
    Label10: TLabel;
    SpeedButton2: TSpeedButton;
    CheckBox1: TDBCheckBox;
    Ednom: TDBEdit;
    EdCode: TDBEdit;
    ComboEdit1: TRxDBComboEdit;
    EdType: TEdit;
    ComboEdit2: TRxDBComboEdit;
    PaFd2: TPanel;
    SpeedButton1: TRxSpeedButton;
    EdAdresse1: TDBEdit;
    EdAdresse2: TDBEdit;
    EdPoste: TDBEdit;
    EdVille: TDBEdit;
    EdPays: TDBEdit;
    EdMel: TDBEdit;
    MaskEdit1: TDBEdit;
    MaskEdit2: TDBEdit;
    MaskEdit3: TDBEdit;
    PaFd3: TPanel;
    Patitre: TPanel;
    ScrollBox1: TScrollBox;
    PaFd7: TPanel;
    Label1: TLabel;
    EdAdr1Liv: TDBEdit;
    EdAdr2Liv: TDBEdit;
    EdPosteLiv: TDBEdit;
    EdVilleLiv: TDBEdit;
    EdPaysLiv: TDBEdit;
    RxSpeedButton1: TRxSpeedButton;
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
    PaGrilleGrille: TPanel;
    DBGridTiers: TGrDBGrid;
    LbAcif: TRxLabel;
    LbJBanque: TRxLabel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    Pointages1: TMenuItem;
    DtailsPointages1: TMenuItem;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    BtnPointages: TButton;
    BtnDetailPointage: TButton;
    RxSBTous: TRxSpeedButton;
    RxSBAPointer: TRxSpeedButton;
    RxSBPointable: TRxSpeedButton;
    RxSBTousPointe: TRxSpeedButton;
    PaPTitre: TPanel;
    DtailPointagessurpriode1: TMenuItem;
    LbCode: TLabel;
    LbNom: TLabel;
    LbType: TLabel;
    LbCompte: TLabel;
    LbAdresse: TLabel;
    LbPoste: TLabel;
    LbVille: TLabel;
    LbPays: TLabel;
    LbTel1: TLabel;
    LbTel2: TLabel;
    LbTelecopie: TLabel;
    LbMel: TLabel;
    LbAdresseLiv: TLabel;
    LbPosteLiv: TLabel;
    LbVilleLiv: TLabel;
    LbPaysLiv: TLabel;
    TextListBox1: TTextListBox;
    RxSBPointageAuto: TRxSpeedButton;
    Exporter1: TMenuItem;

    procedure Calculatrice1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    Procedure initialiseTableEvent;
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pmMenu1Click(Sender: TObject);
    procedure EdCodeExit(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure EdnomExit(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure EdPosteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnInsererClick(Sender: TObject);
    Function CompareValeur(ValeurA : array of variant; ValeurB : array of variant): Boolean;
    procedure DBGridTiersDblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure taTiersAfterScroll(DataSet: TDataSet);
    procedure ComboEdit1Exit(Sender: TObject);
    procedure ComboEdit1Exit2(Sender: TObject);
    procedure ComboEdit1ButtonClick(Sender: TObject);
    procedure TextListBox1Exit(Sender: TObject);
    procedure TextListBox1Enter(Sender: TObject);
    procedure TextListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboEdit2ButtonClick(Sender: TObject);
    procedure ComboEdit2Enter(Sender: TObject);
    procedure TextListBox1Click(Sender: TObject);
    procedure TextListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TextListBox1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure daTiersStateChange(Sender: TObject);
    procedure ComboEdit1Change(Sender: TObject);
    procedure ComboEdit2Change(Sender: TObject);
    procedure ComboEdit2Exit(Sender: TObject);
    procedure CptCollectif(CptBase:string);
    procedure BtnDetailClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure EdCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdnomChange(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure ComboEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure Panel5Resize(Sender: TObject);
    procedure PaGrilleGrilleResize(Sender: TObject);
    procedure ActiveChanged;override;
    Procedure GestionRxLabelExit;
    Procedure GestionRxLabelEnter;
    procedure CheckBox1Exit(Sender: TObject);
    procedure CheckBox1Enter(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure Pointages1Click(Sender: TObject);
    procedure DtailsPointages1Click(Sender: TObject);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure AfterScroll_Grille_Tiers(Dataset: TDataset);
    procedure DBGridTiersColExit(Sender: TObject);
    procedure RxSBImportClick(Sender: TObject);
    Procedure BtnValider(Sender: TObject); // Evènement branché lors de l'appel de VisuListeView
    Procedure DetailCompteVisuListeView(Sender: TObject);
    procedure RxSBTousClick(Sender: TObject);
    procedure RxSBAPointerClick(Sender: TObject);
    procedure RxSBPointableClick(Sender: TObject);
    procedure RxSBTousPointeClick(Sender: TObject);
    procedure EdnomKeyPress(Sender: TObject; var Key: Char);
    procedure DtailPointagessurpriode1Click(Sender: TObject); // Evènement branché lors de l'appel de VisuListeView
    Procedure InitLabelWinControl;
    procedure RxSBPointageAutoClick(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);

  private
    { Déclarations privées }
     EtatFiltreAideCompte,EtatFiltreParamCpt,EtatFiltreParamCptAideCpt:TEtatFiltre;
  public
    { Déclarations publiques }
    CodeTiersTemp : string;
    NomTiersTemp : string;
    TypeCompteTemp : string;
    CompteTemp : string;
    MessCompteValideDsContexte:Boolean;
    TitreForm,SousTitreForm:String;
  end;

var
  Tiers: TTiers;

  Codebon, NomBon, TypeBon, CompteBon : boolean;
  RemonteVersType : Boolean;
  RemonteVersCode : Boolean;
  RemonteVersNom : Boolean;
  RemonteVersCompte : Boolean;

  Quitok : boolean;

  Champ : TWinControl;
  MessCptOblig:boolean;
  NouveauOk : Boolean;
  ListeAux:TStrings;
NomChange:boolean;
LastControl:TWincontrol;
ListeCaractereCorrect:Tstringlist;

Function AideTiersAfficheEnSaisie(CodeTiers:String):TInfosTiersSaisie;

implementation
{$R *.DFM}
Uses E2_Librairie_obj,
//Gr_Calculatrice,
E2_AideAssist,E2_Main, E2_AideCompte,
  E2_GesPlanCpt_PM,
  //UQReport,
  E2_Pointages2, E2_VisuPointage, DMImportation,
  DMPlanCpt, DMRecherche, DMBalances,DMExports, ImportDll;

const
CType :Array [0..2] of String =
    	('C', 'F', 'D');


Function AideTiersAfficheEnSaisie(CodeTiers:String):TInfosTiersSaisie;
Begin
 if (Tiers = nil) then Tiers:=TTiers.Create(Application.MainForm);
 if Tiers.Visible then Tiers.Close;
 Tiers.Tag:=0;
 Tiers.BorderStyle:=bsToolWindow;
 Tiers.CodeTiersTemp:=Str_StringAcceptSQL(CodeTiers,ListeCaractereCorrect);
 result.Retour:=(Tiers.showModal=mrOk);
 if Result.retour then
  Begin
   Result.CodeTiers:=Tiers.EdCode.Text;
   Result.Compte :=Tiers.ComboEdit2.Text;
   Result.Tiers :=Tiers.Ednom.Text;
   Result.TypeTiers :=Tiers.ComboEdit1.Text;
  End;
End;

procedure TTiers.ActiveChanged;
Begin
inherited;
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
//LastZoneEdit:=ActiveControl;
End;
//****************************************************************************//
// Aide En Ligne.                                                             //
//****************************************************************************//
procedure TTiers.AideEnLigne(Sender: TObject);
var
   result:boolean;
begin

//     if ((AideAssist <> nil) and (AideAssist.Visible)) Then
//        Result := AideAssist.taAssist.FindKey([self.name,ActiveControl.name]);
//     If Not Result Then AideAssist.taAssist.FindKey(['Vide','Vide']);
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
//     BtnEnregistrer.Enabled := ActiveBouton([EdCode,EdNom,ComboType,ComboCompte]);

end;
//****************************************************************************//
// Fonction qui permet de comparer des valeurs                                //
//****************************************************************************//
Function TTiers.CompareValeur(ValeurA : array of variant; ValeurB : array of variant): Boolean;
var
i:integer;
Begin
    Result := True;
    for I := 0 to High(ValeurA) do
    begin
         If ValeurA[i] <> ValeurB[i] Then Result := False;
    end;
End;

//****************************************************************************//
// Calculatrice Click                                                         //
//****************************************************************************//
procedure TTiers.Calculatrice1Click(Sender: TObject);
begin
	AfficheCalculatrice(nil);
end;

//****************************************************************************//
// Initialisation à la création de la fenêtre.                                //
//****************************************************************************//
procedure TTiers.FormCreate(Sender: TObject);
begin
//Tiers.PaGrilleGrille.OnResize(Tiers.PaGrilleGrille);
inherited;
  try
    TypeInitForm := C_MODELE_COLOREPI;
    LibGestionParamXML.InitialiseForm(E.User,Self);
  except
    Position:=poScreenCenter;
    InitialiseFormPosDefaut(self);
  end;
   // Creation de la fenêtre qui permet de sélectionner les comptes de stock
   If (AideCompte = Nil) Then AideCompte := TAideCompte.Create(self);
   ListeAux:=TStringList.Create;
   { isa  le  21/04/04 }
   ListeCaractereCorrect:=TStringList.Create;
   ListeCaractereCorrect.clear;
   ListeCaractereCorrect:=DM_C_ListeCaractereCorrect_SQL;
   { isa  le  21/04/04 }
   ListeAux.Add(Item0Liste1);
   ListeAux.Add(Item1Liste1);
   ListeAux.Add(Item2Liste1);
   ListeAux.Add(Item3Liste1);
   ListeAux.Add(Item4Liste1);
   ListeAux.Add(Item5Liste1);
   Ednom.Hint:=HintEdnom;
   BtnDetailPointage.Caption := 'Détail Pointage'+RetourChariotSimple+ '[Ctrl+F5]';
   CaptionMultiLigne(BtnDetailPointage);

end;


Procedure TTiers.InitialiseTable_A_Nil;
Begin
if tiers<>nil then
 InitDatasetEvent_A_Nil_Sur_Form([Tiers.DBGridTiers.DataSource.DataSet,Tiers.DBGridTiers.DataSource]);

if dmtiers <>nil then
 InitDatasetEvent_A_Nil_Sur_Form([DMTiers.TaTiersGest,DMTiers.daTiersGest,dmtiers.QuTiers_Compte_Pointable,dmtiers.DaTiers_Compte_Pointable]);
end;

Procedure TTiers.initialiseTableEvent;
Begin
// DMTiers.daTiersGest.OnStateChange:=nil;
// DMTiers.TaTiersGest.AfterScroll:=nil;
// DMTiers.TaTiersGest.OnCalcFields:=nil;
//
// DBGridTiers.DataSource.OnStateChange:=nil;
// DBGridTiers.DataSource.DataSet.AfterScroll:=nil;
End;
//****************************************************************************//
// detruit la fenêtre pour libérer l'espace mémoire et garde dans la base de  //
// registre la position de la fenêtre pour l'afficher au même endroit lors de //
// sa prochaine activation.                                                   //
//****************************************************************************//
procedure TTiers.FormDestroy(Sender: TObject);
begin
if self.tag in [1,2] then
 LibGestionParamXML.DestroyForm(Self,E.USer);
 InitialiseTable_A_Nil;
 if ListeCaractereCorrect<>nil then
   //FreeAndNil(ListeCaractereCorrect);
   LibereObjet(Tobject(ListeCaractereCorrect),Self);
 LibereObjet(Tobject(ListeAux),Self);

 Tiers:=nil;
end;

//****************************************************************************//
// Fermeture de la fenêtre lors de l'appui sur la touche ESC.                 //
// Permet aussi la gestion des touches.                                       //
//****************************************************************************//
procedure TTiers.FormKeyPress(Sender: TObject; var Key: Char);
begin
case self.tag of
   0,1:Begin
        // Si utilisateur appuie sur ENTER et utilisateur dans grille
        If (key = #13) and (ActiveControl = DBGridTiers) Then
        Begin
             key:= #0;
             ednom.SetFocus;
        End; // Fin utilisateur appuie sur ENTER et utilisateur dans grille

       End;

   2:// ici 
end;
end;

//****************************************************************************//
// pop menu                                                                   //
//****************************************************************************//
procedure TTiers.pmMenu1Click(Sender: TObject);
begin

end;

//****************************************************************************//
// Gestion de l'affichage de la fenêtre.                                      //
//****************************************************************************//
procedure TTiers.FormShow(Sender: TObject);
Var
   cpt : string;
   i : integer;
   Colonne:Tcolumn;
begin
//if LibClassObjetSender = nil then
// LibClassObjetSender:=TLibClassObjetSender.Create(Application.MainForm);
// LibClassObjetSender.InitPanelResize(PaGrilleGrille);
//PaGrilleGrille.OnResize:=LibClassObjetSender.SenderOnPanelResize;
RxSBPointageAuto.Visible:=Tiers.Tag=2;
if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(application.MainForm);
     // Si l'utilisateur vient de la saisie des pièces
     If Tiers.Tag = 0 Then
     Begin
      DMTiers.Tag:=self.tag;
      DMTiers.TaTiersGest.OnCalcFields:=nil;

      RxSBTous.Visible:=False;
      RxSBAPointer.Visible:=False;
      RxSBPointable.Visible:=False;
      RxSBTousPointe.Visible:=False;
      // Sauve l'état des filtre en cours pour les 3 table relative à l'aideCompte
      TableSauveEtatFiltre(DMPlan.TaParamCpt,EtatFiltreAideCompte);
      TableSauveEtatFiltre(DMPlan.TaParamCptAideCpt,EtatFiltreParamCptAideCpt);
      TableSauveEtatFiltre(DMPlan.TaCompte,EtatFiltreParamCpt);

     VisibleControl([ScrollBox1,BtnModifier,BtnSupprimer,BtnImprimer,BtnDetail,BtnPointages,BtnDetailPointage],False);
     VisibleControl([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnFermer],True);

//     ScrollBox1.Visible:=false;

//     BtnAnnuler.Visible:=true;
//     BtnEnregistrer.Visible:=true;
//     BtnInserer.Visible:=true;
//     BtnModifier.Visible := False;
//     BtnSupprimer.Visible := False;
//     BtnFermer.Visible:=true;
//     BtnImprimer.Visible := False;
//     BtnDetail.Visible := False;

     Insrer1.Enabled:=true;
     EnableItemMenu([Modifier1,Supprimer1,Insrer1],true);

       CheckBox1.Visible := False;
       DBGridTiers.Visible := False;
       DBGridTiers.ReadOnly:=true;
       DBGridTiers.AllowAutoAppend:=false;
       PaFd6.Visible:=true;
       Panel5.Visible := False;
       Panel4.Visible := False;
       PaFd3.Visible := False;
       PaFd2.Visible := False;
       SpeedButton2.Visible:=true;
       Tiers.Width := 405;
       Tiers.Height:=245;
       EdCode.Enabled:=true;

       DMTiers.daTiersGest.OnStateChange:=daTiersStateChange;
       daTiersStateChange(DMTiers.TaTiersGest);

       BtnInserer.Click;
//       Ednom.field.AsString:=NomTiersTemp;
       EdCode.Field.AsString := CodeTiersTemp;
//       BtnInserer.Enabled:= False;
//       BtnEnregistrer.Enabled:=true;
//       ComboEdit2.Field.AsString:=self.CompteTemp;
//       ComboEdit2.OnButtonClick:=nil;
//       ComboEdit2.OnEnter:=nil;
//       DMTiers.TaTiersGest.Insert;
       Ednom.SetFocus;
//       GestionRxLabelEnter;
       PaBtnResize(PaBtn);
       PaTools.Visible:=false;
     End; // Fin utilisateur vient de la saisie des pièces

     // Si l'utilisateur vient de la gestion des Tiers
     If Tiers.Tag = 1 Then
     Begin
      PaPTitre.Caption :='Liste des tiers';

       PaTools.Visible:=true;
      RxSBTous.Visible:=False;
      RxSBAPointer.Visible:=False;
      RxSBPointable.Visible:=False;
      RxSBTousPointe.Visible:=False;
       //RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
     DMTiers.Tag:=self.tag;
     DMTiers.TaTiersGest.OnCalcFields:=nil;
     dmtiers.TaTiersGest.Close;
     GrDbGridInitColonne(DBGridTiers,dmtiers.DaTiersGest,  //isa le 17-10-02
     dmtiers.TaTiersGest,
     ['Tiers','Nom','Compte','Type','Actif'],
     ['Tiers','Nom','Compte','Type','Actif'],
     E.FormatMonnaie,E.EditFormat);
     dmtiers.TaTiersGest.Open;
     PaGrilleGrilleResize(PaGrilleGrille);
     ScrollBox1.Visible:=false;
     BtnAnnuler.Visible:=true;
     BtnEnregistrer.Visible:=true;
     BtnInserer.Visible:=true;
     BtnModifier.Visible:=true;
     BtnSupprimer.Visible:=true;
     BtnFermer.Visible:=true;
     BtnImprimer.Visible:=true;
     BtnDetail.Visible:=false;
     BtnPointages.Visible:=false;
     BtnDetailPointage.Visible:=false;
     EnableItemMenu([Modifier1,Supprimer1,Insrer1],true);
     Insrer1.Enabled:=true;
     // Nettoyage des zones de saisies
       SpeedButton2.Visible:=false;
       PaFd6.Visible:=true;
       Panel5.Visible := True;
       Panel4.Visible := True;
       PaFd3.Visible := True;
       PaFd2.Visible := True;
       CheckBox1.Visible := True;
       BtnInserer.Visible := True;
       DBGridTiers.Visible := True;
       DBGridTiers.ReadOnly:=true;
       DBGridTiers.AllowAutoAppend:=false;
//       InitialiseForm(E.User,Self);
//       Tiers.Width := 800;
//       Tiers.Height:=600;
       DBGridTiers.SetFocus;

       ComboEdit2.OnButtonClick:=ComboEdit2ButtonClick;
       ComboEdit2.OnEnter:=ComboEdit2Enter;

       DMTiers.daTiersGest.OnStateChange:=daTiersStateChange;
       daTiersStateChange(DMTiers.TaTiersGest);

//       DMTiers.TaTiersGest.AfterScroll:=taTiersAfterScroll;
//       DMTiers.TaTiersGest.AfterScroll(DMTiers.TaTiersGest);

       PaBtnResize(PaBtn);
//       BtnEnregistrer.Enabled := True;
//       BtnAnnuler.Enabled := True;
       try
         LibGestionParamXML.InitialiseForm(E.User,Self);
       except
         Position:=poScreenCenter;
         InitialiseFormPosDefaut(self);
       end;
     End; // Fin utilisateur vient de la gestion des Tiers

     // Si l'utilisateur va vers l'écran de pointage
     If Tiers.Tag = 2 Then
     Begin
      DMTiers.Tag:=self.tag;
      RxSBImport.Visible:=false;
      RxSBTous.Visible:=true;
      RxSBAPointer.Visible:=true;
      RxSBPointable.Visible:=true;
      RxSBTousPointe.Visible:=true;
      PaTools.Visible:=true;

      dmtiers.QuTiers_Compte_Pointable.Close;
//     GrDbGridInitColonne(DBGridTiers,dmtiers.DaTiers_Compte_Pointable,  //isa le 17-10-02
//     dmtiers.QuTiers_Compte_Pointable,
//     ['Tiers','Nom','Compte','Type','Actif','À Pointer','Part. Pointée','Pointée','Solde compte','Solde reste'],
//     ['Tiers','Nom','Compte','Type','Actif','NbLigneNonPointe','NbLignePartiPointe','NbLigneTotalementPointe','SoldeCompte','SoldeReste'],
//     E.FormatMonnaie,E.EditFormat);

     GrDbGridInitColonne(DBGridTiers,dmtiers.DaTiers_Compte_Pointable,  //isa le 17-10-02
     dmtiers.QuTiers_Compte_Pointable,
//     ['Tiers','Nom','Compte','Type','Actif','À Pointer','Part. Pointée','Pointée','Solde reste'],
//     ['Tiers','Nom','Compte','Type','Actif','NbLigneNonPointe','NbLignePartiPointe','NbLigneTotalementPointe','SoldeReste'],

//     ['Tiers','Nom','Compte','Type','À Pointer','Part. Pointée','Pointée','Solde reste'],
//     ['Tiers','Nom','Compte','Type','NbLigneNonPointe','NbLignePartiPointe','NbLigneTotalementPointe','SoldeReste'],

//     ['Tiers','Nom','Compte','Type','Solde','Reste'],
//     ['Tiers','Nom','Compte','Type','Solde','TotReste'],
//     E.FormatMonnaie,E.EditFormat);
     ['Tiers','Nom','Compte','Type','Solde'],      { isa  le  25/03/04 }
     ['Tiers','Nom','Compte','Type','Solde'],
     E.FormatMonnaie,E.EditFormat);

     PaGrilleGrilleResize(PaGrilleGrille);
     ScrollBox1.Visible:=false;
     EnableItemMenu([Modifier1,Supprimer1,Insrer1],false);
     BtnAnnuler.Visible:=true;
     BtnEnregistrer.Visible:=true;
     BtnInserer.Visible:=False;
     BtnModifier.Visible:=False;
     BtnSupprimer.Visible:=false;
     BtnFermer.Visible:=true;
     BtnImprimer.Visible:=false;
     BtnDetail.Visible:=true;
     BtnPointages.Visible:=True;
     BtnDetailPointage.Visible:=True;

     Insrer1.Enabled:=false;

     // Nettoyage des zones de saisies
       SpeedButton2.Visible:=false;
       PaFd6.Visible:=false;
       Panel5.Visible := True;
       Panel4.Visible := True;
       CheckBox1.Visible := True;
       DBGridTiers.Visible := True;
       DBGridTiers.ReadOnly:=false;
       DBGridTiers.AllowAutoAppend:=false;
//       InitialiseForm(E.User,Self);
//       Tiers.Width := 800;
//       Tiers.Height:=600;
       DBGridTiers.SetFocus;
//       DMTiers.TaTiersGest.Close;
//       DMTiers.TaTiersGest.Open;
//       DMTiers.TaTiersGest.AfterScroll:=taTiersAfterScroll;
//       DMTiers.TaTiersGest.AfterScroll(DMTiers.QuTiers_Compte_Pointable);
       //DMTiers.TaTiersGest.AfterScroll(DMTiers.TaTiersGest);//isa

       RxSBTous.Click;

       PaBtnResize(PaBtn);
       try
         LibGestionParamXML.InitialiseForm(E.User,Self);
       except
         Position:=poScreenCenter;
         InitialiseFormPosDefaut(self);
       end;
//       BtnEnregistrer.Enabled := True;
//       BtnAnnuler.Enabled := True;
     End; // Fin utilisateur va vers l'écran de pointage
PaGrilleGrilleResize(PaGrilleGrille);
DBGridTiers.DataSource.DataSet.AfterScroll:=AfterScroll_Grille_Tiers;
AfterScroll_Grille_Tiers(DBGridTiers.DataSource.DataSet);
end;

//****************************************************************************//
//**                       Evènement OnExit                                 **//
//****************************************************************************//
// Gestion de la sortie du code du Tiers                                      //
//****************************************************************************//

procedure TTiers.EdCodeExit(Sender: TObject);
begin
try
   Ed_Modele_FM_INIT_COLORExit(Sender);
   if not DMTiers.CtrlSaisieTiers(edCode.Field).Retour then
    begin
    edCode.Field.FocusControl;
    end
    else
//     GestionRxLabelExit;
except
    edCode.Field.FocusControl;
end;
//If ValExistedos('Tiers.db','Tiers','+' + EdCode.text) Then
// Begin
//  EdCode.Tag := 0;
//  Erreur('Reference','Doublon');
//  Edcode.Text := '';
//  Edcode.SetFocus;
// End;
//     If ((ActiveControl.Name <> 'BtnAnnuler') And (ActiveControl.Name <> 'BtnFermer') And (ActiveControl.Name <> 'DBGridTiers')) then
//     Begin
//          // Si le code du tiers est renseigné
//          If edcode.tag = 1 Then
//          Begin
//               // Si le code Tiers existe déjà dans la table des Tiers
//               If ValExistedos('Tiers.db','Tiers','+' + EdCode.text) Then
//               Begin
//                    EdCode.Tag := 0;
//                    Erreur('Reference','Doublon');
//                    Edcode.Text := '';
//                    Edcode.SetFocus;
//               End
//          End
//          Else
//          // Si le code du Tiers n'est pas renseigné
//          Begin
//               Messagedlg('Le code du Tiers est obligatoire',mtwarning,[mbok], 0);
//               Edcode.setfocus;
//          end;
//     End;

end;

//****************************************************************************//
// Permet la gestion de la sortie de la rubrique Nom du Tiers                 //
//****************************************************************************//
procedure TTiers.EdnomExit(Sender: TObject);
var
   codetmp : string;
   typetmp : string;
   i : integer;
begin
Ed_Modele_FM_INIT_COLORExit(Sender);
//If ((ActiveControl.Name <> 'BtnAnnuler') And (ActiveControl.Name <> 'BtnFermer') And (ActiveControl.Name <> 'DBGridTiers')) then
//Begin
//If not(empty(EdNom.Text)) Then
// Begin
//  if ((DMTiers.DaTiersGest.State = dsInsert) and (empty(EdCode.Text))) then
//   begin
//     // Proposer en fonction du nom saisie un code Tiers
//     codetmp := concat('+',copy(ednom.text,1,7));
//     if valexistedos('Tiers.db','Tiers',codetmp) then
//     begin
//          i := 2;
//          codetmp := concat('+', copy(ednom.text,1,7-length(inttostr(i))),inttostr(i));
//          While valexistedos('Tiers.db','Tiers',codetmp) do
//          begin
//               i := i+ 1;
//               codetmp:=concat('+', copy(ednom.text,1,7-length(inttostr(i))),inttostr(i));
//          end;
//     End;
//     edcode.Field.AsString:=(UpperCase((COPY(codetmp,2,7))));
////     edcode.Text := (UpperCase((COPY(codetmp,2,7))));
//   end;
// end;
if NomChange=true then
 begin
  try
     if not DMTiers.CtrlSaisieTiers(edNom.Field).Retour then
      begin
        edNom.SetFocus;
        //Field.FocusControl;
        abort;
      end
      else
      begin
       if EdCode.canfocus then
         EdCode.SetFocus;{ isa  le  26/09/03 }
       //EdCode.Field.FocusControl;{ isa  le  26/09/03 }
//       GestionRxLabelExit;
      end;
  except
      edNom.SetFocus;
      abort;
  //    edNom.Field.FocusControl;
  end;
 end
 else
 begin
//  GestionRxLabelExit;
 end;

//if not DMTiers.CtrlSaisieTiers(edNom.Field).Retour then edNom.SetFocus else NomChange:=False;
//GestionRxLabelExit;
// else
// // Si le nom du Tiers n' pas été renseigné par l'utilisateur
// Begin
//      NomBon := False;
//      Messagedlg('La Saisie du nom est obligatoire',mtwarning,[mbok],0);
//      Ednom.SetFocus;
// end;
//end;
//     EdNom.Color := ClWindow;

//     // Si l'utilisateur ne clique pas sur le bouton Fermer ni sur le bouton Annuler
//     If ((ActiveControl.Name <> 'BtnAnnuler') And (ActiveControl.Name <> 'BtnFermer') And (ActiveControl.Name <> 'DBGridTiers')) then
//     Begin
//          // Si un nom a été saisi par l'utilisateur
//          If EdNom.Text <> '' Then
//          Begin
//               NomBon := True;
//               // Si l'utilisateur n'est pas en modification
//               If Not(ModificationOK) Then
//               Begin
//                    // Proposer en fonction du nom saisie un code Tiers
//                    codetmp := concat('+',copy(ednom.text,1,7));
//                    if valexistedos('Tiers.db','Tiers',codetmp) then
//                    begin
//                         i := 2;
//                         codetmp := concat('+', copy(ednom.text,1,7-length(inttostr(i))),inttostr(i));
//                         While valexistedos('Tiers.db','Tiers',codetmp) do
//                         begin
//                              i := i+ 1;
//                              codetmp:=concat('+', copy(ednom.text,1,7-length(inttostr(i))),inttostr(i));
//                         end;
//                    End;
//                    edcode.Text := (UpperCase((COPY(codetmp,2,7))));
//               End;
//          End  //Fin nom saisie par utilisateur
//
//          Else
//          // Si le nom du Tiers n' pas été renseigné par l'utilisateur
//          Begin
//               NomBon := False;
//               Messagedlg('La Saisie du nom est obligatoire',mtwarning,[mbok],0);
//               Ednom.SetFocus;
//          end;
//     End;
//
end;

//****************************************************************************//
//******                Evènements OnKeyPress                            *****//
//****************************************************************************//
// Autorise l'utilisateur à ne saisir que des numériques dans le code postal  //
//****************************************************************************//
procedure TTiers.EdPosteKeyPress(Sender: TObject; var Key: Char);
begin
     if (not (Key in ['0'..'9'])) and (key <> #8) Then
        abort;
end;

//****************************************************************************//
// permet de fermer la fenêtre.                                               //
//****************************************************************************//
procedure TTiers.BtnFermerClick(Sender: TObject);
begin
if formstate = [fsmodal] then ModalResult:=mrCancel
else self.close;
//case self.tag of
//   0:modalresult:=mrCancel;
//   1,2:Self.Close;
//end;
end;

//****************************************************************************//
//Permet la gestion de l'annulation.                                          //
//****************************************************************************//
procedure TTiers.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;
//****************************************************************************//
// Gestion de la fermeture de la fenêtre                                      //
//****************************************************************************//
procedure TTiers.FormClose(Sender: TObject; var Action: TCloseAction);
var
   typetmp,tel1,tel2,telecopie : string;
   ActifTmp : boolean;
begin
//BtnAnnulerClick(BtnAnnuler);
end;

//****************************************************************************//
// Gestion des touches dans la form                                           //
//****************************************************************************//
procedure TTiers.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   codetmp : string;
   i : integer;
   ch:word;
begin
if Shift=[] then WinSuivPrec(Handle,key,[DBGridTiers,EdType]);
If (DBGridTiers.Visible) Then
     begin
        If ((Key = VK_TAB) and (Shift = [ssCtrl]) and (Not(DBGridTiers.Focused))) Then
         begin
           LastControl:=ActiveControl;
           DBGridTiers.SetFocus;
           exit;
         end;

        If ((Key = VK_TAB) and (Shift = [ssCtrl]) and (DBGridTiers.Focused)) Then
         begin
           if LastControl<>nil then LastControl.SetFocus;
         end;
      end;

if (KEY = VK_ESCAPE) then
   begin
   case DMTiers.TaTiersGest.State of
      dsinsert:Begin
//                 if self.tag=0 then self.close;
                 If Messagedlg('Voulez-vous annuler la création de ce Tiers',mtconfirmation,[mbyes,mbno],0) = mryes Then
                   begin
                    DMTiers.TaTiersGest.Cancel;
                    if formstate = [fsmodal] then ModalResult:=mrCancel;
//                    if self.tag=0 then ModalResult:=mrCancel;
                    exit;
                   End
                   Else
                   Begin
                    exit;
                   End;
               End;

      dsEdit:Begin
                 If Messagedlg('Voulez-vous annuler les modification de ce Tiers',mtconfirmation,[mbyes,mbno],0) = mryes Then
                   begin
                    DMTiers.TaTiersGest.Cancel;
                    Exit;
                   End
                   Else
                   Begin
                    Exit;
                   End;
             End;

      dsBrowse:Begin
                 if activeControl <> DBGridTiers then
                  begin
                   ch:=VK_Tab;
                   self.KeyDown(ch,[ssCtrl]);
                  end
                  else self.close;

               End;

   end;

//   if BtnEnregistrer.Enabled = true then
//    BtnAnnulerClick(BtnAnnuler)
//    else
//    BtnFermerClick(BtnFermer);
   end;
if DMTiers.DaTiersGest.State in [dsBrowse] then
if ((key=VK_INSERT) and (Shift=[ssCtrl])) then BtnInserer.Click;
if ((key=VK_INSERT) and (Shift=[])) then key:=0;
end;

//****************************************************************************//
// Gestion du click sur le bouton Insérer                                     //
//****************************************************************************//
procedure TTiers.BtnInsererClick(Sender: TObject);
begin

case self.tag of
   0,1:Begin
       EdNom.SetFocus;
       DMTiers.TaTiersGest.Insert;
       End;
   2:// ici l'appel de pointage;
end;
end;

//****************************************************************************//
// Se placer dans les champs de saisie quand l'utilisateur double clique      //
// sur l'enregistrement courant de la grille                                  //
//****************************************************************************//
procedure TTiers.DBGridTiersDblClick(Sender: TObject);
begin
  case self.tag of
//     0,1:EdNom.SetFocus;
     0..2:BtnDetailClick(BtnDetail);// ici l'appel de pointage;
  end;

end;

//****************************************************************************//
procedure TTiers.SpeedButton1Click(Sender: TObject);
var
adresse : array [0..255] of Char ;
MailTo:string;
begin
StrPCopy(adresse,'mailto: '+ EdMel.text);
ShellExecute(Handle, 'open', adresse, nil, nil, SW_SHOWNORMAL);
end;

//****************************************************************************//
procedure TTiers.taTiersAfterScroll(DataSet: TDataSet);
var
typeT:char;
begin
//ComboEdit1.Enabled:=not DetailEcritureTiers(DataSet.FindField('Tiers').AsString,false);
//ComboEdit1.TabStop:=ComboEdit1.Enabled;
//ComboEdit2.Enabled:=ComboEdit1.Enabled;
//ComboEdit2.TabStop:=ComboEdit1.Enabled;
//EdType.Enabled:=ComboEdit1.Enabled;


// PB le 26/02/04 ComboEdit1.ReadOnly:=DetailEcritureTiers(DataSet.FindField('Tiers').AsString,false);
if dataset.State in [dsInsert] then
 ComboEdit1.ReadOnly:=false
 else
   begin
    DeFiltrageDataSet(DMRech.TaEcritureRech);
    ComboEdit1.ReadOnly:=GrLocate(DMRech.TaEcritureRech,'Tiers',[DataSet.FindField('Tiers').AsString]);
   end;

//ComboEdit1.TabStop:=ComboEdit1.Enabled;
ComboEdit2.ReadOnly:=ComboEdit1.ReadOnly;
if ComboEdit1.ReadOnly then
   begin
    ComboEdit1.OnButtonClick:=nil;
    ComboEdit1.OnChange:=nil;
    ComboEdit1.OnExit:=ComboEdit1Exit2;
    ComboEdit1.OnKeyPress:=nil;
    ComboEdit1.ClickKey:=ShortCut(0,[]);

    ComboEdit2.OnButtonClick:=nil;
    ComboEdit2.OnEnter:=nil;
    ComboEdit2.OnExit:=nil;
    ComboEdit2.OnKeyPress:=nil;
    ComboEdit2.ClickKey:=ShortCut(0,[]);
//    ShortCut(112,[]);
   end
   else
   Begin
    ComboEdit1.OnButtonClick:=ComboEdit1ButtonClick;
    ComboEdit1.OnChange:=ComboEdit1Change;
    ComboEdit1.OnExit:=ComboEdit1Exit;
    ComboEdit1.OnKeyPress:=ComboEdit1KeyPress;
    ComboEdit1.ClickKey:=ShortCut(112,[]);

    ComboEdit2.OnButtonClick:=ComboEdit2ButtonClick;
    ComboEdit2.OnEnter:=ComboEdit2Enter;
    ComboEdit2.OnExit:=ComboEdit2Exit;
    ComboEdit2.OnKeyPress:=ComboEdit2KeyPress;
    ComboEdit2.ClickKey:=ShortCut(112,[]);
   End;



//ComboEdit2.TabStop:=ComboEdit1.Enabled;
//EdType.Enabled:=ComboEdit1.Enabled;
//Query1.Active:=false;
//Query1.ParamByName('CODET').AsString:=taTiersTiers.AsString;
//Query1.Active:=true;
//
//if CurrencyEdit3.Value < 0
//then begin
//     RxLabel3.font.Color:=clGreen;
//     RxLabel3.Caption:='Solde Créditeur : '
//     end
//else begin
//     RxLabel3.font.Color:=clRed;
//     RxLabel3.Caption:='Solde Débiteur : ';
//     end;
//if CurrencyEdit3.Value = 0 then
//   begin
//   RxLabel3.font.Color:=clWindowText;
//   RxLabel3.Caption:='Solde Nul : ';
//   end;
//CurrencyEdit3.Value:=Abs(CurrencyEdit3.Value);
end;

//****************************************************************************//
procedure TTiers.ComboEdit1Exit(Sender: TObject);
begin
  try
    if empty(comboEdit1.Text) then
       begin
       TextListBox1.Visible:=true;
       Ed_Modele_FM_INIT_COLORExit(Sender);
       TextListBox1.SetFocus;
       end;
    if not ((ActiveControl=ComboEdit2) or (ActiveControl=TextListBox1)) then
       case DMTiers.CtrlSaisieTiers(ComboEdit1.Field).CodeErreur of
          0: ;
          3101,3102:Begin
                     Ed_Modele_FM_INIT_COLORExit(Sender);
                     ComboEdit2.SetFocus;
                    end;
          3140..3146:begin
                      Ed_Modele_FM_INIT_COLORExit(Sender);
                      ComboEdit2.SetFocus;
                      ComboEdit2ButtonClick(ComboEdit2);
                    end;
          3147:abort;
       end;
  Finally
   Ed_Modele_FM_INIT_COLORExit(Sender);
   //GestionRxLabelExit;
  end;
//if not DMTiers.CtrlSaisie(ComboEdit1.Field).Retour then ComboEdit1.SetFocus;
//if not (empty(comboEdit2.Text)) then
//   begin
//   ComboEdit2Enter(ComboEdit2);
//   if ((not AideCompteExiste(ComboEdit2.Text,nil)) or (DMPlan.PossedeFils(ComboEdit2.Text))) then
//    begin
//    end;
//   end;
end;

procedure TTiers.ComboEdit1Exit2(Sender: TObject);
begin
  Ed_Modele_FM_INIT_COLORExit(Sender);
end;

//****************************************************************************//
procedure TTiers.ComboEdit1ButtonClick(Sender: TObject);
begin
TextListBox1.Visible:=true;
TextListBox1.SetFocus;
end;

//****************************************************************************//
procedure TTiers.TextListBox1Exit(Sender: TObject);
begin
   TextListBox1.Visible:=false;
   Tiers.KeyPreview:=true;
end;

//****************************************************************************//
procedure TTiers.TextListBox1Enter(Sender: TObject);
begin
if ComboEdit1.Text='C' then {Client}
   begin
     TextListBox1.ItemIndex:=0;
   end;

if ComboEdit1.Text='F' then {Fournisseur}
   begin
     TextListBox1.ItemIndex:=1;
   end;

if ComboEdit1.Text='D' then {Client & Fournisseur}
   begin
     TextListBox1.ItemIndex:=2;
   end;

if ComboEdit1.Text='P' then {Personnel}
   begin
     TextListBox1.ItemIndex:=3;
   end;

if ComboEdit1.Text='O' then {Organisme Sociaux}
   begin
     TextListBox1.ItemIndex:=4;
   end;

if ComboEdit1.Text='A' then {Associés}
   begin
     TextListBox1.ItemIndex:=5;
   end;

if ComboEdit1.Text='T' then {Associés}
   begin
     TextListBox1.ItemIndex:=6;
   end;

if empty(ComboEdit1.Text) then
   begin
     TextListBox1.ItemIndex:=0;
   end;
Tiers.KeyPreview:=false;
end;

//****************************************************************************//
procedure TTiers.TextListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
KeyP:string;
begin
case key of
   VK_ESCAPE:begin
              key:=VK_CANCEL;
              ComboEdit1.SetFocus;
             end;
   VK_RETURN:begin
              key:=VK_CANCEL;
              keyP:=copy(TextListBox1.Items[TextListBox1.ItemIndex],1,1);
              ComboEdit1KeyPress(ComboEdit1,keyP[1]);
              ComboEdit1.SetFocus;
             end;
    VK_UP:begin
            key:=VK_CANCEL;
            if TextListBox1.ItemIndex>0 then
             TextListBox1.ItemIndex:=TextListBox1.ItemIndex-1;
          end;
    VK_DOWN:begin
            key:=VK_CANCEL;
            if (TextListBox1.ItemIndex < (TextListBox1.Items.Count-1)) then
               TextListBox1.ItemIndex:=TextListBox1.ItemIndex+1;
            end;
    else begin
         keyP:=chr(key);
         ComboEdit1KeyPress(ComboEdit1,keyP[1]);
         ComboEdit1.SetFocus;
         end;
end;
end;

//****************************************************************************//
procedure TTiers.ComboEdit1KeyPress(Sender: TObject; var Key: Char);
begin
if ((ord(key) in [49..55,67,68,70,80,65,79,99,100,102,112,97,111,84,116]) and (DMTiers.TaTiersGest.State=dsBrowse))
   then DMTiers.TaTiersGest.Edit;
case ord(key) of
   49..55:begin
            EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-49],5,30);
            ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-49],1,1);
          end;
   67:begin
       EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-67],5,30);{C}
       ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-67],1,1);{C}
      end;
   68:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-66],5,30);{D}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-66],1,1);{D}
      end;
   69:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-66],5,30);{E}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-66],1,1);{E}
      end;
   70:begin
       EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-69],5,30);{F}
       ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-69],1,1);{F}
      end;
   80:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-76],5,30);{P}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-76],1,1);{P}
      end;
   65:begin
       EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-59],5,30);{A}
       ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-59],1,1);{A}
      end;
   79:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-74],5,30);{O}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-74],1,1);{O}
      end;
   84:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-77],5,30);{T}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-77],1,1);{T}
       end;

   99:begin
       EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-99],5,30);{c}
       ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-99],1,1);{c}
      end;
   100:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-98],5,30);{d}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-98],1,1);{d}
       end;
   102:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-101],5,30);{f}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-101],1,1);{f}
       end;
   112:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-109],5,30);{p}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-109],1,1);{p}
       end;
   97:begin
       EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-92],5,30);{a}
       ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-92],1,1);{a}
      end;
   111:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-107],5,30);{o}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-107],1,1);{o}
       end;
   116:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(key)-110],5,30);{t}
        ComboEdit1.Field.AsString:=copy(TextListBox1.Items.Strings[ord(key)-110],1,1);{t}
       end;
end;
//if key = #8 then
//   if ComboEdit1.SelLength < length(ComboEdit1.Text) then
//      key:=#0;
end;

Procedure TTiers.DetailCompteVisuListeView(Sender: TObject);
var
CptCourant:String;
Begin
CptCourant:=VisuListeView.ItemCourantValeurCol(0);
if CptCourant<>'' then
  DetailEcritureCompte(CptCourant,true,true);
End;

// Procedure de validation d'un compte dans visulisteView : BtnValidation
Procedure TTiers.BtnValider(Sender: TObject);
var
CptCourant:String;
Begin
//ModalResult:=mrok
CptCourant:=E2_VisuListeView.VisuListeView.ItemCourantValeurCol(0);
if DMPlan.CompteValideDansParamContexte(CptCourant,true,['Rac1','Rac2','Rac3','Rac4','Rac5'],nil) then
 begin
//   MessCompteValideDsContexte:=false;
   if DMPlan.CompteExistePCU(CptCourant) then //alors s'il existe
          begin
               // Il faudrait conserver ce controle, mais une erreur se produit et ça ne marche pas !!!!
//              if DMPlan.PossedeFils(CptCourant) then
//                 Begin
//                     E2_VisuListeView.VisuListeView.LAstItemSelected:=E2_VisuListeView.VisuListeView.ItemCourantViewList('',false);
//                     if MessageDlg('Vous n''utilisez pas la dernière subdivision !'+#10#13 + 'Confirmez-vous votre choix ?', mtConfirmation,[mbYes,mbNo],0) = mrYes then
////                      if Question('AideCompte', 'Subdivision') then
//                      begin
//                        E2_VisuListeView.VisuListeView.ModalResult:=mrok;
////                        showmessage('Vous devez utiliser la dernière subdivision à partir de cet écran !!');
////                        ComboEdit2.SetFocus;
//                      end
//                      else
//                      Begin
//                        abort;
////                        ComboEdit2.SetFocus;
////                        abort;
//                      End;
//                   end;
          E2_VisuListeView.VisuListeView.ModalResult:=mrok;
          end;
//          else
//          Begin
//          showmessage('Vous devez saisir un compte du plan comptable valide !!');
//          ComboEdit2.SetFocus;
//          abort;
//          End;
end;
End;

//****************************************************************************//
procedure TTiers.ComboEdit2ButtonClick(Sender: TObject);
var
key,ValCptTmp:string;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
 RetourViewListe:TRetourViewListe;
 Compte:String;
begin
try
 case self.tag of
    0:Begin
       try
        List1:=TStringList.Create;

        TextListBox1.Visible:=false;
        ComboEdit2Enter(ComboEdit2);

        if not empty(ComboEdit2.Text) then
        DMPlan.FiltrageAideCompte(96,nil,DMTiers.TaTiersGestFilterRecordAideCompte);
    Initialise_TParamAffichage(ParamAffichage);

        ParamAffichage.EventButtonValiderClick:=Tiers.BtnValider;
        ParamAffichage.EventButtonDetailClick:=Tiers.DetailCompteVisuListeView;

        List1:=ChampTableVersListeEx(['Compte','Libelle'],DMPlan.TaCompte,';',true);
        ReEnableControls(DMPlan.TaCompte);
        ParamAffichage.AffichModal := true;
        ParamAffichage.Titre:='Aide Compte';
        ParamAffichage.GestionAffichForm.Caption := 'Aide Compte';
        //Compte:=
        RetourViewListe:=AfficheVisuListView(ParamAffichage,['Compte','Libellé'],
                                           [200,250],
                                           [List1],
                                           [taLeftJustify,taLeftJustify],
                                           [1..2],
                                           [0],[0]);
                                           //ItemCourantValeurRow
        ParamAffichage.EventButtonValiderClick:=nil;
        ParamAffichage.EventButtonDetailClick:=nil;
        if RetourViewListe.Retour then
        begin
         List1:=RetourViewListe.VisuListeView.ItemCourantValeurRow;
//         if List1.Count > 0 then
//        ShowMessage(List1.Strings[0]+' - '+List1.Strings[1]);
        ComboEdit2.Text:=RetourViewListe.VisuListeView.ItemCourantValeurCol(0);
//        ShowMessage(Compte);

//        List1.Free; { isa  le  27/01/04 }

//        if DMPlan.CompteValideDansParamContexte(ComboEdit2.Text,MessCompteValideDsContexte,['Rac1','Rac2','Rac3','Rac4','Rac5'],nil) then
//         begin
//           MessCompteValideDsContexte:=false;
//           if DMPlan.CompteExistePCU(ComboEdit2.Text) then //alors s'il existe
//                  begin
//                      if DMPlan.PossedeFils(ComboEdit2.Text) then
//                         Begin
//                              if Question('AideCompte', 'Subdivision') then
//                              begin
//                                showmessage('Vous devez utiliser la dernière subdivision à partir de cet écran !!');
//                                ComboEdit2.SetFocus;
//                                abort;
//                              end
//                              else
//                              Begin
//                                ComboEdit2.SetFocus;
//                                abort;
//                              End;
//                           end;
//                  end
//                  else
//                  Begin
//                  showmessage('Vous devez saisir un compte du plan comptable valide !!');
//                  ComboEdit2.SetFocus;
//                  abort;
//                  End;
           ValCptTmp:=ComboEdit2.Text;
           if DMTiers.TaTiersGest.State=dsBrowse
              then DMTiers.TaTiersGest.Edit;
           ComboEdit2.Text:=ValCptTmp;
           if empty(ComboEdit1.Text) then
               begin
                   key:=ComboEdit2.Text[1]+ComboEdit2.Text[2];
                   case strtoint_lgr(key) of
                      40:key:='f';
                      41:key:='c';
                      42:key:='p';
                      43:key:='o';
                      45:key:='a';
                      46:key:='d';
                      47:key:='t';
                   end;
                   ComboEdit1KeyPress(comboEdit1,key[1]);
               end;
         end
         else
         Begin
         showmessage('Ce compte n''est pas valide dans ce contexte !!');
         ComboEdit2.SetFocus;
         abort;
         End;
       Finally

       end;
     End;

    1:Begin
        TextListBox1.Visible:=false;

//        if AideCompte <> nil then
//        if AideCompte.Visible then AideCompte.SetFocus;

        ComboEdit2Enter(ComboEdit2);
        if not empty(ComboEdit2.Text) then
        DMPlan.FiltrageAideCompte(96,nil,DMTiers.TaTiersGestFilterRecordAideCompte);
        if AideCompteDansContexte(ComboEdit2.Text,ComboEdit2,['Rac1','Rac2','Rac3','Rac4','Rac5'],true,MessDerSub,False,true,false,true,0)=true then
         begin
           ValCptTmp:=ComboEdit2.Text;
           if DMTiers.TaTiersGest.State=dsBrowse
              then DMTiers.TaTiersGest.Edit;
           ComboEdit2.Text:=ValCptTmp;
        //if AideCompteDansContexte(ComboEdit2.Text,ComboEdit2,['Rac1'],true,
        //if AideCompteAffiche(ComboEdit2) then
           if empty(ComboEdit1.Text) then
               begin
                   key:=ComboEdit2.Text[1]+ComboEdit2.Text[2];
                   case strtoint_lgr(key) of
                      40:key:='f';
                      41:key:='c';
                      42:key:='p';
                      43:key:='o';
                      45:key:='a';
                      46:key:='d';
                      47:key:='t';
                   end;
                   ComboEdit1KeyPress(comboEdit1,key[1]);
               end;
         end;
     End;

 end;// Fin du Case
Finally
end;
end;

//****************************************************************************//
procedure TTiers.CptCollectif(CptBase:string);
var
ListeCpt:TStringList;
Cpt:string;
begin
case length(CptBase) of
   1:DMPlan.FiltrageAideCompte(96,nil,DMTiers.TaTiersGestFilterRecordAideCompte);
   2:DMPlan.FiltrageAideCompteSurCompte(96,CptBase,nil,DMTiers.TaTiersGestFilterRecordAideCompte);
end;


//ListeCpt:=TStringList.Create;
//ListeCpt.Sorted:=true;
//ListeCpt.Duplicates:=dupIgnore;
//AideCompteFiltreTaCompte(CreeFiltreET(['compte','collectif'],[CptBase+'*','true']),true);
////AideCompte.taCompte.Filtered := False;
////AideCompte.taCompte.Filter :=CreeFiltreET(['compte','collectif'],[CptBase+'*','true']);
////AideCompte.taCompte.Filtered := True;
//DMPlan.TaCompte.First;
//while not DMPlan.taCompte.EOF do
//      begin
//       Cpt:=DMPlan.taCompte.FindField('Compte').AsString;
//       ListeCpt.Add(Cpt);
//       while ((length(cpt)>1) and (DMPlan.PossedePerePCU(Cpt))) do
//             begin
//               cpt:=copy(cpt,1,length(cpt)-1);
//               ListeCpt.Add(Cpt);
//             end;
//       DMPlan.taCompte.Next;
//       end;
//AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
////AideCompte.taCompte.Filter := CreeFiltreOU('compte',[ListeCpt]);
//ListeCpt.Free;
end;
//****************************************************************************//
procedure TTiers.ComboEdit2Enter(Sender: TObject);
begin
MessCompteValideDsContexte:=false;
if ComboEdit1.Text='F' then {Fournisseur}
   begin
    CptCollectif('40');
   end;

if ComboEdit1.Text='D' then {Client & Fournisseur}
   begin
    CptCollectif('46');
   end;

if ComboEdit1.Text='C' then {Client}
   begin
    CptCollectif('41');
   end;
if ComboEdit1.Text='P' then {Personnel}
   begin
    CptCollectif('42');
   end;

if ComboEdit1.Text='O' then {Organisme Sociaux}
   begin
    CptCollectif('43');
   end;

if ComboEdit1.Text='E' then {Associés}
   begin
    CptCollectif('44');
   end;

if ComboEdit1.Text='A' then {Associés}
   begin
    CptCollectif('45');
   end;

if ComboEdit1.Text='T' then {Tous}
   begin
    CptCollectif('4');
   end;

if empty(ComboEdit1.Text) then
   begin
    CptCollectif('4');
   end;
Ed_Modele_FM_INIT_COLOREnter(Sender);
//GestionRxLabelEnter;
end;

//****************************************************************************//
procedure TTiers.TextListBox1Click(Sender: TObject);
var
key:word;
begin
Key:=VK_RETURN;
TextListBox1KeyDown(sender,key,[]);
end;

//****************************************************************************//
procedure TTiers.TextListBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
TextListBox1.ItemIndex:=Y div TextListBox1.ItemHeight;
end;

//****************************************************************************//
procedure TTiers.TextListBox1KeyPress(Sender: TObject; var Key: Char);
var
keyP:word;
begin
keyP:=ord(key);
if key in[#49..#55] then TextListBox1KeyDown(sender,keyP,[]);
end;

//****************************************************************************//
procedure TTiers.SpeedButton2Click(Sender: TObject);
begin
if SpeedButton2.Caption = ' + ' then
   begin
 Tiers.Height:=600;
 PaFd3.Visible := True;
 PaFd2.Visible := True;
 SpeedButton2.Caption := ' - '
   end
   else
   begin
 if not(Ednom.Focused or EdCode.Focused or TextListBox1.Focused or EdType.Focused or ComboEdit1.Focused or ComboEdit2.Focused) then
    EdNom.SetFocus;
 Tiers.Height:=245;
 PaFd3.Visible := False;
 PaFd2.Visible := False;
 SpeedButton2.Caption := ' + '
   end;
end;

//****************************************************************************//
procedure TTiers.daTiersStateChange(Sender: TObject);
var
typeT:char;
begin
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMTiers.DaTiersGest.DataSet);
case DMTiers.DaTiersGest.State of
   dsInsert:begin
             // Bouton Barre de menu
             EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
             EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
             //Pop menu
             EnableItemMenu([Annuler1,Enregister1,Fermer1],true);
             EnableItemMenu([Insrer1,Modifier1,Supprimer1,Imprimer1],False);
             // Autre controle
             CheckBox1.Field.AsBoolean:= True;
//             Ed_Modele_FM_INIT_COLORExit(ActiveControl as TObject);
             Ednom.SetFocus;
             EdCode.Enabled:=true;
             EdCode.TabOrder:=1;
             EdCode.TabStop:=true;
             EdCode.Field.ReadOnly:=false;
             EdType.Text:='';
          end;
   dsbrowse:begin
             // Bouton Barre de menu
             EnableWinControl([BtnAnnuler,BtnInserer,BtnModifier,BtnFermer,BtnImprimer],True);
             BtnSupprimer.Enabled:=(DMTiers.TaTiersGest.RecordCount>0);
             BtnEnregistrer.Enabled := False;
             //Pop menu
             EnableItemMenu([Annuler1,Insrer1,Modifier1,Fermer1,Imprimer1],true);
             Enregister1.Enabled:=False;
             Supprimer1.Enabled:=BtnSupprimer.Enabled;
             // Autre controle
             EdCode.Enabled:=false;
             EdCode.Field.ReadOnly:=true;
             NomChange:=False;
          end;
   dsEdit:begin
             // Bouton Barre de menu
             EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnSupprimer,BtnFermer],True);
             EnableWinControl([BtnInserer,BtnModifier,BtnImprimer],False);
             //Pop menu
             EnableItemMenu([Annuler1,Enregister1,Supprimer1,Fermer1],true);
             EnableItemMenu([Insrer1,Modifier1,Imprimer1],False);
             // Autre controle
             EdCode.Enabled:=false;
             EdCode.Field.ReadOnly:=true
          end;
end;

end;

procedure TTiers.ComboEdit1Change(Sender: TObject);
begin
if ComboEdit1.Field <> nil then
if length(ComboEdit1.Field.AsString)=1 then
case ord(ComboEdit1.Field.AsString[1]) of
   67:begin
       EdType.Text:=copy(TextListBox1.Items.Strings[ord(ComboEdit1.Field.AsString[1])-67],5,30);{C}
      end;
   68:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(ComboEdit1.Field.AsString[1])-66],5,30);{D}
      end;
   70:begin
       EdType.Text:=copy(TextListBox1.Items.Strings[ord(ComboEdit1.Field.AsString[1])-69],5,30);{F}
      end;
   80:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(ComboEdit1.Field.AsString[1])-76],5,30);{P}
      end;
   65:begin
       EdType.Text:=copy(TextListBox1.Items.Strings[ord(ComboEdit1.Field.AsString[1])-59],5,30);{A}
      end;
   79:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(ComboEdit1.Field.AsString[1])-74],5,30);{O}
      end;
   69:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(ComboEdit1.Field.AsString[1])-66],5,30);{E}
      end;
   84:begin
        EdType.Text:=copy(TextListBox1.Items.Strings[ord(ComboEdit1.Field.AsString[1])-77],5,30);{T}
      end;
end;
end;

procedure TTiers.ComboEdit2Change(Sender: TObject);
begin
//BtnEnregistrer.Enabled:=(((VerifZoneSaisie([Ednom,EdCode,ComboEdit1,ComboEdit2])=nil)
//                          and (taTiers.State <> dsInsert) and (ComboEdit2.Text<> taTiers.FindField('Compte').AsString))
//                          or ((VerifZoneSaisie([Ednom,EdCode,ComboEdit1,ComboEdit2])=nil)
//                          and (taTiers.State = dsInsert){and (not(TaTiers.locate(EdCode.Text)))}));
end;

procedure TTiers.ComboEdit2Exit(Sender: TObject);
begin
MessCompteValideDsContexte:=true;
case self.tag of
   -1:ComboEdit2ButtonClick(ComboEdit2);
   0,1:Begin
      if not ((ActiveControl=ComboEdit1) or (ActiveControl=TextListBox1)) then
         case DMTiers.CtrlSaisieTiers(ComboEdit2.Field).CodeErreur of
            0: ;
            2000:ComboEdit1.SetFocus;
            2001,2002:ComboEdit2.SetFocus;
            2003:begin
                  ComboEdit2.SetFocus;
                  ComboEdit2ButtonClick(ComboEdit2);
                 end;
         end;
     End;
end;
Ed_Modele_FM_INIT_COLORExit(Sender);
///GestionRxLabelExit;
//if AideCompteDansContexte(ComboEdit2.Text,ComboEdit2,['Rac1','Rac2','Rac3','Rac4','Rac5'],MessDerSub,true,true,false,true,0)=false then
//begin
//end;
//if empty(ComboEdit2.Text)
//   then AideCompteAffiche(ComboEdit2)
//   else
//   begin
//    if DMPlan.taCompte.Locate('Compte',ComboEdit2.Text,[]) then
//       begin
//        if DMPlan.PossedeFils(ComboEdit2.Text) then
//           begin
//              if not Question('AideCompte', 'Subdivision') then AideCompteAffiche(ComboEdit2);
//           end;
//       end
//       else
//        begin
//        if MessageDlg('ATTENTION !'+#13+#10+'Le type de Tiers : '+ComboEdit1.Text+' ne correspond pas avec le compte : '+ComboEdit2.Text+' .'+#13+#10+'Confirmez-vous votre choix ?',mtWarning,[mbYes,mbNo],0) = mrno then begin
////           if Tatiers.State = dsInsert then AideCompteAffiche(ComboEdit2)
////              else ComboEdit2.Text := taTiersCompte.AsString;
//           end;
//       end;
//   end;

end;

procedure TTiers.BtnDetailClick(Sender: TObject);
begin
if activecontrol= ComboEdit2 then
  DetailEcritureCompte(DMTiers.TaTiersGestCompte.AsString,true,true)
else
  if activecontrol=DBGridTiers then
    Begin//si
     case self.tag of
        1:begin
            if copy(DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring,1,1)='+' then
              DetailEcritureTiers(DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring,true)
            else
              DetailEcritureCompte(DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring,true,true);
          end ;
        2:begin
           if DBGridTiers.SelectedIndex = 2 then
             begin
               DetailEcritureCompte(DBGridTiers.DataSource.DataSet.findfield('Compte').asstring,true,true);
             end
           else
             begin
               if copy(DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring,1,1)='+' then
                 DetailEcritureTiers(DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring,true)
               else
                 DetailEcritureCompte(DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring,true,true);
             end;
          end;
     end;
    End;//fin si
end;

procedure TTiers.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TTiers.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TTiers.EdCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if DMTiers.TaTiersGest.State = dsInsert then
     If ((Key = VK_RETURN) and (Shift = [ssCtrl]) and (EdCode.Focused)) Then
     Begin
          edcode.Field.AsString:='+'+DMTiers.GenerCodeTiers(EdNom.Field.AsString);
          edcode.SelectAll;
     End;
end;

procedure TTiers.EdnomChange(Sender: TObject);
begin
if Ednom.Field<>nil then
   if Ednom.Field.DataSet.State in [dsEdit,dsInsert] then NomChange:=true;
end;

procedure TTiers.Panel3Resize(Sender: TObject);
begin
if PaFd3.Height>250 then
   begin
   RxSpeedButton1.Visible:=true;
   ScrollBox1.Visible:=true;
//   ScrollBox1.top:=EdPaysLiv.Top+30;
   end
    else
    begin
   RxSpeedButton1.Visible:=true;
    ScrollBox1.Visible:=false;
    end;
end;

procedure TTiers.RxSpeedButton1Click(Sender: TObject);
begin
if self.tag=1 then
 ScrollBox1.Visible:=not ScrollBox1.Visible;

end;

procedure TTiers.BtnEnregistrerClick(Sender: TObject);
begin
  case self.tag of
     0:Begin
        try
         if DMTiers.TaTiersGest.State in [DsInsert] then
          begin
           TableGerePost(DMTiers.TaTiersGest);
          end;
          modalResult:=mrOk;
        except
         abort;
        end;
  //      showmessage('Création  d''un tiers à partir de cet écran lors de la prochaine mises à jour.');
       End;
     1:Begin
        try
         if DMTiers.TaTiersGest.State in [dsEdit,DsInsert] then
          begin
           TableGerePost(DMTiers.TaTiersGest);
          end;
         EdNom.SetFocus;
        except
         abort;
        end;
       End;
  end;
end;

procedure TTiers.BtnSupprimerClick(Sender: TObject);
begin
if DMTiers.TaTiersGest.State in [dsBrowse] then
 begin
  TableGereDelete(DMTiers.TaTiersGest);
 end;
end;

procedure TTiers.BtnModifierClick(Sender: TObject);
begin
case self.tag of
   0,1:Begin
         if DMTiers.TaTiersGest.State in [dsBrowse] then
            begin
             if ((not ActiveControl.ClassNameIs('TDBEdit')) and (not ActiveControl.ClassNameIs('TRxDBComboEdit')) and (not ActiveControl.ClassNameIs('TTextListBox'))) then
                Ednom.SetFocus;
             DMTiers.TaTiersGest.Edit;
            end;
     End;

   2:Begin
     End;

end;
end;

procedure TTiers.BtnImprimerClick(Sender: TObject);
var
ListeCpt:TResultStrList;
EtatFiltre:TEtatFiltre;
requete : TQuery;
Filtre:string;
begin
  case self.tag of
     0:Begin

       End;

     1:Begin
          try
            ListeCpt.Liste:=TStringList.Create;
            ListeCpt.result:=true;
            requete := TQuery.Create(self);
            requete.DatabaseName :=DMRech.TaTiersRech.DatabaseName;
            requete.SQL.Add(' select distinct type,compte from tiers T');
            requete.Open;
            requete.First;
            Filtre:='';
            listecpt:=ChoixCompteAffich('Sélectionnez les types de tiers ...',requete,['type','compte'],true);
            if(ListeCpt.Result) and (ListeCpt.Liste.Count>0)then
              filtre:=' where '+CreeFiltreOU('type',[ListeCpt.Liste]);

            ListeCpt.Liste:=TStringList.Create;
            ListeCpt.result:=true;

            requete.close;
            requete.Free;
            //TableSauveEtatFiltre(DMDiocEtatBal.TaBalanceCalc,EtatFiltre);
            requete := TQuery.Create(self);
            requete.DatabaseName :=DMRech.TaTiersRech.DatabaseName;
            requete.SQL.Add(' select Tiers,compte,nom,type from tiers T');
            requete.SQL.Add(filtre);
            requete.Open;

            listecpt:=ChoixCompteAffich('Sélectionnez les tiers ...',requete,['Tiers','compte','nom','type'],true);
            if ListeCpt.Result then
              EditionPlanAuxL(C_EditionSimple,nil,ListeCpt.Liste);
          finally
             requete.close;
             requete.Free;
          end;
      End;
  end;
end;

procedure TTiers.PaBtnResize(Sender: TObject);
begin
case self.tag of
   0:Begin
     FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnFermer],PaBtn,90,0);
    End;

   1:Begin
     FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
    End;

   2:Begin
     FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnFermer,BtnDetail,BtnPointages,BtnDetailPointage],PaBtn,90,0);
//     FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnFermer,BtnImprimer,BtnDetail,BtnPointages,BtnDetailPointage],PaBtn,90,0);
    End;
end;

end;

procedure TTiers.Enregister1Click(Sender: TObject);
begin
if DMTiers.TaTiersGest.State in [dsInsert,dsEdit] then
 begin
   TableGerePost(DMTiers.TaTiersGest);
 end;
end;

procedure TTiers.Aide1Click(Sender: TObject);
begin
if ((ActiveControl=ComboEdit2) and (ComboEdit2.ReadOnly=false)) then
   ComboEdit2ButtonClick(ComboEdit2);
if ((ActiveControl=ComboEdit1) and (ComboEdit1.ReadOnly=false)) then
   ComboEdit1ButtonClick(ComboEdit1);
if DMTiers.TaTiersGest.State = dsBrowse then
 begin
   if ActiveControl=MaskEdit1 then
      Rechercher(MaskEdit1,DMTiers.TaTiersGest,['Telephone1','Nom','Tiers','Compte','Ville'],['Téléphone','Nom','Tiers','Compte','Ville'],'',0);
   if ActiveControl=Ednom then
      Rechercher(Ednom,DMTiers.TaTiersGest,['Nom','Tiers','Compte','Ville'],['Nom','Tiers','Compte','Ville'],'',0);
   if ActiveControl=DBGridTiers then
    begin
      case self.Tag of
         1:Rechercher(DBGridTiers,DMTiers.TaTiersGest,['Tiers','Nom','Compte','Ville'],['Tiers','Nom','Compte','Ville'],'',0);
         2:RechercherQu(DBGridTiers,DMTiers.QuTiers_Compte_Pointable,['Tiers','Nom','Compte'],['Tiers','Nom','Compte'],'',0,'Tiers');
      end;
    end;
 end;                                   

end;

procedure TTiers.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if DMTiers <> nil then
 begin
  // Si l'utilisateur est en mode Insertion
     If DMTiers.TaTiersGest.State = dsInsert Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If BtnEnregistrer.Enabled Then
          Begin
               If Messagedlg('Voulez-vous enregistrer le nouveau Tiers ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
                   TableGerePost(DMTiers.TaTiersGest);
                   canclose:=true;
                   if formstate = [fsmodal] then ModalResult:=mrOk;
                  end
                  else
                   begin
                   DMTiers.TaTiersGest.Cancel;
                   canclose:=true;
                   if formstate = [fsmodal] then ModalResult:=mrCancel;
                   end;
          End
          Else
          Begin
               If Messagedlg('Voulez-vous annuler la création de ce Tiers ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
                  DMTiers.TaTiersGest.Cancel;
                  canclose:=true;
                  if formstate = [fsmodal] then ModalResult:=mrCancel;
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DMTiers.TaTiersGest.State = dsEdit Then
     Begin
       self.WindowState:=wsNormal;
       self.BringToFront;
          If Messagedlg('Voulez-vous enregistrer les modifications de ce Tiers ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
           begin
            TableGerePost(DMTiers.TaTiersGest);
            canclose:=true;
             end
             else
             begin
              DMTiers.TaTiersGest.Cancel;
             end;
     End; // Fin utilisateur est en mode Modification

  end;
if CanClose then
 begin
case self.tag of
   0:Begin
      TableRestoreEtatFiltre(DMPlan.TaParamCpt,EtatFiltreAideCompte);
      TableRestoreEtatFiltre(DMPlan.TaParamCptAideCpt,EtatFiltreParamCptAideCpt);
      TableRestoreEtatFiltre(DMPlan.TaCompte,EtatFiltreParamCpt);
     End;
   1: ;
end;
  InitialiseTable_A_Nil;
  LibGestionParamXML.DestroyForm(Self,E.USer);
 end
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;
//if aidecompte<>nil then
//aidecompte.DefiltrageAideCompte;

end;

procedure TTiers.FormActivate(Sender: TObject);
begin
inherited;
Initialiser_ShortCut_Main(true);
  case self.tag of
     0,1:Begin
    InitLabelWinControl;
//        CouleurFond([CheckBox1,Ednom,EdCode,ComboEdit1,ComboEdit2,EdAdresse1,EdAdresse2,EdPoste,
//                     EdVille,EdPays,MaskEdit1,MaskEdit2,MaskEdit3,EdMel,EdAdr1Liv,EdAdr2Liv,
//                     EdPosteLiv,EdVilleLiv,EdPaysLiv],ParamUtil.CouleurDBGrid.GrilleColorFond);

        //ShellExecute(Handle, 'open', 'C:\Philippe\AppliOne\fenetrereduite.html', nil, nil, SW_SHOWNORMAL);
  //      DMPlan.TaCompte.OnFilterRecord:=nil;
        //screen.OnActiveControlChange:=AideEnligne;
        //if self.tag=0 then
        //   WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
        DBGridTiers.ParamColor:=true;
        DBGridTiers.Param:=ParamUtil.CouleurDBGrid;
        DBGridTiers.UpDateColor;
        DMTiers.TaTiersGest.AfterScroll:=taTiersAfterScroll;
        DMTiers.TaTiersGest.AfterScroll(DMTiers.TaTiersGest);
        Patitre.visible:=Main.AfficheTitre;
      End;

     2:Begin
       if not DMTiers.QuTiers_Compte_Pointable.Active then
       DMTiers.QuTiers_Compte_Pointable.open;

       DMTiers.QuTiers_Compte_Pointable.Refresh;
        DBGridTiers.ParamColor:=true;
        DBGridTiers.Param:=ParamUtil.CouleurDBGrid;
        DBGridTiers.UpDateColor;
       End;
  end;

end;

procedure TTiers.ComboEdit2KeyPress(Sender: TObject; var Key: Char);
begin
if key > #33 then
if DMTiers.TaTiersGest.State=dsBrowse
   then DMTiers.TaTiersGest.Edit;
end;

procedure TTiers.Panel5Resize(Sender: TObject);
begin
   WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TTiers.PaGrilleGrilleResize(Sender: TObject);
begin
case self.tag of
   1:Begin
       DBGridTiers.ColWidths[1]:=((DBGridTiers.Width) div 13)*3;
       DBGridTiers.ColWidths[2]:=((DBGridTiers.Width) div 13)*5;
       DBGridTiers.ColWidths[3]:=((DBGridTiers.Width) div 13)*2;
       DBGridTiers.ColWidths[4]:=((DBGridTiers.Width) div 13);
       DBGridTiers.ColWidths[5]:=((DBGridTiers.Width) div 13);
     End;

   2:Begin
       FormateTailleColonne(DBGridTiers,21,[3,6,3,1,3]);
//       FormateTailleColonne(DBGridTiers,30,[3,6,3,1,3,3,3,3]);
//       FormateTailleColonne(DBGridTiers,30,[3,6,3,1,1,3,3,3,3,3]);
     End;

end;


//WinShape(ActiveControl,Main.Shape1,Main.shape2,Main.ContourCouleur);
end;

Procedure TTiers.GestionRxLabelExit;
Begin
CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,nil,0,0);
if lastZoneEdit = Ednom then
   WinRxLab(LbNom,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdCode then
   WinRxLab(LbCode,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = CheckBox1 then
   WinRxLab(LbAcif,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = ComboEdit1 then
   WinRxLab(LbType,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = ComboEdit2 then
   WinRxLab(LbCompte,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdAdresse1 then
   WinRxLab(LbAdresse,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdAdresse2 then
   WinRxLab(LbAdresse,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdPoste then
   WinRxLab(LbPoste,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdVille then
   WinRxLab(LbVille,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdPays then
   WinRxLab(LbPays,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = MaskEdit1 then
   WinRxLab(LbTel1,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = MaskEdit2 then
   WinRxLab(LbTel2,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = MaskEdit3 then
   WinRxLab(LbTelecopie,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdMel then
   WinRxLab(LbMel,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);

if LastZoneEdit = EdAdr1Liv then
   WinRxLab(LbAdresseLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdAdr2Liv then
   WinRxLab(LbAdresseLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdPosteLiv then
   WinRxLab(LbPosteLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdVilleLiv then
   WinRxLab(LbVilleLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
if LastZoneEdit = EdPaysLiv then
   WinRxLab(LbPaysLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOff);
End;

Procedure TTiers.GestionRxLabelEnter;
Begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,nil,0,0);
// initialise tous les labels à la couleur d'origine
WinRxLabTab([LbNom,LbCode,LbAcif,LbType,
             LbCompte,LbAdresse,LbPoste,
             LbVille,LbPays,LbTel1,
             LbTel2,LbTelecopie,LbMel,
             LbAdresseLiv,LbPosteLiv,LbVilleLiv,
             LbPaysLiv],ParamUtil.textColorOff,ParamUtil.ShadowColorOff);

if activeControl = Ednom then
   WinRxLab(LbNom,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdCode then
   WinRxLab(LbCode,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = CheckBox1 then
   WinRxLab(LbAcif,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = ComboEdit1 then
   WinRxLab(LbType,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = ComboEdit2 then
   WinRxLab(LbCompte,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdAdresse1 then
   WinRxLab(LbAdresse,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdAdresse2 then
   WinRxLab(LbAdresse,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdPoste then
   WinRxLab(LbPoste,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdVille then
   WinRxLab(LbVille,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdPays then
   WinRxLab(LbPays,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = MaskEdit1 then
   WinRxLab(LbTel1,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = MaskEdit2 then
   WinRxLab(LbTel2,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = MaskEdit3 then
   WinRxLab(LbTelecopie,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdMel then
   WinRxLab(LbMel,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);

if activeControl = EdAdr1Liv then
   WinRxLab(LbAdresseLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdAdr2Liv then
   WinRxLab(LbAdresseLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdPosteLiv then
   WinRxLab(LbPosteLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdVilleLiv then
   WinRxLab(LbVilleLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
if activeControl = EdPaysLiv then
   WinRxLab(LbPaysLiv,ParamUtil.textColorOff,ParamUtil.ShadowColorOn);
End;


procedure TTiers.CheckBox1Exit(Sender: TObject);
begin
//GestionRxLabelExit;
Ed_Modele_FM_INIT_COLORExit(Sender);
end;

procedure TTiers.CheckBox1Enter(Sender: TObject);
begin
Ed_Modele_FM_INIT_COLOREnter(Sender);
//GestionRxLabelEnter;
//Refresh;
//EdCode.Refresh;
end;

procedure TTiers.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(TiersRxSBInfoVersionWarning+numVersion.messageVersion);
DMTiers.clientdataset1.SaveToFile('TesteExp.xml',dfXMLUTF8);

end;

procedure TTiers.Pointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
TiersEnCours:string;
begin
try
   TiersEnCours:=DBGridTiers.DataSource.DataSet.findfield('Tiers').AsString;
   ParamAffichPointage.ALettrer:=True;
   ParamAffichPointage.CptTiers:=DBGridTiers.DataSource.DataSet.findfield('Tiers').AsString;
   ParamAffichPointage.DateDeb:=0;
   ParamAffichPointage.DateFin:=E.DatExoFin;
   GestionAffichagePointageSurCompte(ParamAffichPointage,not e.ExerciceCloture);
case self.tag of
   0,1:Begin

    End;

   2:Begin
       DMTiers.QuTiers_Compte_Pointable.close;
       DMTiers.QuTiers_Compte_Pointable.open;
     End;
end;
DBGridTiers.DataSource.DataSet.Locate('Tiers',TiersEnCours,[]);
except
  showmessage('problème à l"affichage des pointages');
  abort;
end;
end;

procedure TTiers.DtailsPointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
begin
Initialise_ParamAffichPeriode(ParamAffichPeriode);
periode.DateDeb:=e.DatExoDebut;
periode.DateFin:=E.DatExoFin;
periode:=ChoixPeriodeAffich(periode.DateDeb,E.DatExoFin,'',ParamAffichPeriode);

ParamAffichPointage.ALettrer:=false;
ParamAffichPointage.CptTiers:=DBGridTiers.DataSource.DataSet.findfield('Tiers').AsString;
ParamAffichPointage.DateDeb:=periode.DateDeb;
ParamAffichPointage.DateFin:=periode.DateFin;
GestionAffichagePointageSurCompte(ParamAffichPointage,not e.ExerciceCloture);
end;



procedure TTiers.MaskEdit1KeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then key:=#0;
end;


procedure TTiers.AfterScroll_Grille_Tiers(Dataset: TDataset);
var
ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
begin
if @DMTiers.TaTiersGest.AfterScroll<>nil then { isa  le  28/01/04 }
  taTiersAfterScroll(dataset);{ isa  le  28/01/04 }

//ResteDCInfoLettrageEnCours:=DMPointage2.CalculLettrageEnCours(nil,DBGridTiers.DataSource.DataSet.FindField('Tiers').asstring,'',0,'');
//CurrencyEdit1.Value:=ResteDCInfoLettrageEnCours.TotalDebitMvt;
//CurrencyEdit2.Value:=ResteDCInfoLettrageEnCours.TotalCreditMvt;
//CurrencyEdit3.Value:=ResteDCInfoLettrageEnCours.SoldeMvt;
//if ResteDCInfoLettrageEnCours.SoldeMvtAuDebit then
//  RxLabel3.Caption:='Solde débiteur :'
//else
//  RxLabel3.Caption:='Solde créditeur :'

end;
procedure TTiers.DBGridTiersColExit(Sender: TObject);
begin
//
end;

procedure TTiers.RxSBImportClick(Sender: TObject);
begin
  DMImport.Import_Tiers(DBGridTiers.DataSource.DataSet,True);
  daTiersStateChange(DBGridTiers.DataSource.DataSet);
end;



procedure TTiers.RxSBTousClick(Sender: TObject);
begin
  DMTiers.AffecteFilterRecord(C_TiersFilterRecordTous);
  PaPTitre.Caption :='Liste des comptes pointables ayant des écritures';
end;

procedure TTiers.RxSBAPointerClick(Sender: TObject);
begin
  DMTiers.AffecteFilterRecord( C_TiersFilterRecordResteAPointerNonNullTous);
  PaPTitre.Caption :='Liste des comptes à pointer';
end;

procedure TTiers.RxSBPointableClick(Sender: TObject);
begin
  DMTiers.AffecteFilterRecord(C_TiersFilterRecordResteAPointerNonNullPointable);
  PaPTitre.Caption :='Liste des comptes pointables ...';
end;

procedure TTiers.RxSBTousPointeClick(Sender: TObject);
begin
  DMTiers.AffecteFilterRecord(C_TiersFilterRecordNullTous);
  PaPTitre.Caption :='Liste des comptes qui n''ont pas d''écriture à pointer';
end;

procedure TTiers.EdnomKeyPress(Sender: TObject; var Key: Char);
var
j:integer;
Retour:TExceptLGR;
begin
Retour.retour:=true;
if ListeCaractereCorrect<>nil then
  if ListeCaractereCorrect.Count<>0 then
    begin
      for j:=0 to ListeCaractereCorrect.Count-1 do
        begin
          if Str_StringAcceptSQL(Key,ListeCaractereCorrect)<>key then
            begin
              MessageDlg('Le caractère : '+key+' n''est pas utilisable dans ce context !', mtWarning, [mbOK], 0);
              key:=#0;
            end;
        end;
    end;
end;


procedure TTiers.DtailPointagessurpriode1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
periode:TPeriode;
Requete:TQuery;
ParamAffichPeriode:TParamAffichPeriode;
begin
Initialise_ParamAffichPeriode(ParamAffichPeriode);
  try
      Requete:=TQuery.Create(self);
      Requete.SQL.Clear;
      Requete.SQL.Add('select min(ResteDC."Date") as DateDeb');
      Requete.SQL.Add('from "'+e.RepertoireDossier+'ResteDC" ');
      Requete.open;
      if ((requete.recordcount<>0)and(not empty(Requete.findfield('DateDeb').Asstring)))then
        periode.DateDeb:=Requete.findfield('DateDeb').AsDateTime
      else
        periode.DateDeb:=e.DatExoDebut;
      periode.DateFin:=E.DatExoFin;
      periode:=ChoixPeriodeAffich(periode.DateDeb,E.DatExoFin,'',ParamAffichPeriode);
  finally
  requete.close;
  requete.Free;
  end;
ParamAffichPointage.ALettrer:=false;
ParamAffichPointage.CptTiers:=DBGridTiers.DataSource.DataSet.findfield('Tiers').AsString;
ParamAffichPointage.DateDeb:=periode.DateDeb;
ParamAffichPointage.DateFin:=periode.DateFin;
GestionAffichagePointageSurCompte(ParamAffichPointage,not e.ExerciceCloture);

end;

Procedure TTiers.InitLabelWinControl;
Begin
AssocierLabelWinControl(LbNom,EdNom);
AssocierLabelWinControl(LbCode,EdCode);
AssocierLabelWinControl(LbType,ComboEdit1);
AssocierLabelWinControl(LbCompte,ComboEdit2);

AssocierLabelWinControl(LbAdresse,EdAdresse1);
AssocierLabelWinControl(LbAdresse,EdAdresse2);
AssocierLabelWinControl(LbPoste,EdPoste);
AssocierLabelWinControl(LbVille,EdVille);
AssocierLabelWinControl(LbPays,EdPays);
AssocierLabelWinControl(LbTel1,MaskEdit1);
AssocierLabelWinControl(LbTel2,MaskEdit2);
AssocierLabelWinControl(LbTelecopie,MaskEdit3);
AssocierLabelWinControl(LbMel,EdMel);

AssocierLabelWinControl(LbAdresseLiv,EdAdr1Liv);
AssocierLabelWinControl(LbAdresseLiv,EdAdr2Liv);
AssocierLabelWinControl(LbPosteLiv,EdPosteLiv);
AssocierLabelWinControl(LbVilleLiv,EdVilleLiv);
AssocierLabelWinControl(LbPaysLiv,EdPaysLiv);
End;


procedure TTiers.RxSBPointageAutoClick(Sender: TObject);
var
   ListeLettres:tstringlist;
   i:integer;
   TiersCourant,tiersListe:string;
ListeCpt:TResultStrList;
Requete : TQuery;
filtre:string;
ParamAffichCompte:TParamAffichCompte;
nbPointageRestant:integer;
begin
try//finally
PatienterAffich;
  DMTiers.AffecteFilterRecord(C_TiersFilterRecordResteAPointerNonNullPointable);
  PaPTitre.Caption :='Liste des comptes pointables ...';
if dmrech=nil then dmrech:=TDMRech.Create(self);
DBGridTiers.DataSource.DataSet.DisableControls;
TiersCourant:=DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring;
DeFiltrageDataSet(dmrech.TaResteDCRech);
if not DMPointage2.RecupListeLettre_surDataset(dmrech.TaResteDCRech,false).Result then
 begin

    try
        requete := TQuery.Create(self);
        requete.DatabaseName := DM_C_NomAliasDossier;

        requete.SQL.Add(' select distinct R.tiers,T.Nom, T.Compte, sum(cast(debit as numeric)-cast(credit as numeric)) as Solde, sum(Reste) as TotReste, T.Actif from resteDc R ');
        requete.SQL.Add(' join Tiers T on (T.tiers = R.Tiers) ');
        requete.SQL.Add(' where R."date"<= :Datefin ');
        requete.SQL.Add(' group by R.tiers,T.Nom, T.Compte, T.Actif ');
//        requete.SQL.Add(' having cast(sum(Reste) as numeric(15,2))>0 and ((cast(sum(debit-credit) as numeric(15,2))>0.001 and ');
//        requete.SQL.Add(' cast(sum(debit-credit) as numeric(15,2))<> cast(sum(Reste) as numeric(15,2)))or(cast(sum(debit-credit) as numeric(15,2))<0.001 ');
//        requete.SQL.Add(' and cast(sum(debit-credit)*-1 as numeric(15,2)) <> cast(sum(Reste) as numeric(15,2))))');

        requete.SQL.Add(' having sum(Reste)>0 and ((sum(debit-credit)>=0 and ');
        requete.SQL.Add(' sum(Reste)-sum(debit-credit)>=0.01 )or(sum(debit-credit)<=0 ');
        requete.SQL.Add(' and sum(Reste)-(sum(debit-credit)*-1) >0.01))');

        requete.SQL.Add(' union all ');

        requete.SQL.Add(' select distinct R.tiers,P.Libelle, P.Compte, sum(cast(debit as numeric)-cast(credit as numeric)) as Solde, sum(Reste) as TotReste, P.Abandonne from resteDc R ');
        requete.SQL.Add(' join Plancpt P on (P.Compte = R.Tiers) ');
        requete.SQL.Add(' where R."date"<= :Datefin ');
        requete.SQL.Add(' group by R.tiers,P.Libelle, P.Compte, P.Abandonne ');
//        requete.SQL.Add(' having cast(sum(Reste) as numeric(15,2))>0 and ((cast(sum(debit-credit) as numeric(15,2))>0 and ');
//        requete.SQL.Add(' cast(sum(debit-credit) as numeric(15,2))<> cast(sum(Reste) as numeric(15,2)))or(cast(sum(debit-credit) as numeric(15,2))<0 ');
//        requete.SQL.Add(' and cast(sum(debit-credit)*-1 as numeric(15,2)) <> cast(sum(Reste) as numeric(15,2))))');

        requete.SQL.Add(' having sum(Reste)>0 and ((sum(debit-credit)>=0 and ');
        requete.SQL.Add(' sum(Reste)-sum(debit-credit)>=0.01 )or(sum(debit-credit)<=0 ');
        requete.SQL.Add(' and sum(Reste)-(sum(debit-credit)*-1) >0.01))');

        requete.ParamByName('DateFin').AsDate:=e.DatExoFin;

        //requete.OnFilterRecord :=DMTiers.QuTiers_Compte_PointableFilterRecordResteAPointerNonNullPointable;
        requete.Open;

        ListeCpt.Liste:=TStringList.Create;
        ListeCpt.result:=true;

        InitialiseParamAffichCompte(ParamAffichCompte);
        ParamAffichCompte.Titre:= 'Sélectionnez les tiers ...';
        ParamAffichCompte.Tiers:=true;
        ParamAffichCompte.Dataset:=requete;

        //ParamAffichCompte.sautDePage:=e.SautDePageAutomatique;
        ParamAffichCompte.titreSautDePage:='Saut de page entre les collectifs';

        //EventButtonClick:=LibChoixComptes.BtnSupplTypeTiersClick;
        //ParamAffichCompte.ListeItemAction.AddObject('Sélection des types de tiers', @EventButtonClick);

        //ParamAffichCompte.EventButtonSupplementClick:=LibChoixComptes.BtnSupplClick;
        ParamAffichCompte.ListeChamps.Add('Tiers');
        ParamAffichCompte.ListeChamps.Add('nom');
        ParamAffichCompte.ListeChamps.Add('compte');
        ParamAffichCompte.ListeChamps.Add('Solde');
//        ParamAffichCompte.ListeChamps.Add('TotReste');

            listecpt:=ChoixCompteAffich(ParamAffichCompte);
        if ListeCpt.Result then
          begin
            for i:=0 to ListeCpt.Liste.Count-1 do
              Begin
        //       if DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring='+0026' then
        //         begin
//                     filtrageDataset(dmrech.TaResteDCRech,'Tiers = '''+DBGridTiers.DataSource.DataSet.findfield('Tiers').asstring+'''');
                     tiersListe:=str_getstringelement(ListeCpt.Liste.strings[i],1,';');
                     filtrageDataset(dmrech.TaResteDCRech,'Tiers = '''+tiersListe+'''');
                     DMPointage2.LettrageEnCours:='a';
                     nbPointageRestant:=1;
                     while nbPointageRestant<>0 do
                     begin
                        nbPointageRestant:= DMPointage2.LettrageAutomatique(dmrech.TaResteDCRech,tiersListe,0,E.DatExoFin,true);
                        DMPointage2.ValiderPointages(dmrech.TaResteDCRech,tiersListe,true);
                     end;
        //         end;
              DBGridTiers.DataSource.DataSet.next;
              end;
          end;
    finally
      Requete.Close;
      requete.free;
    end; 

 end
else
 begin
  Showmessage('Vous devez d''abord valider le lettrage en cours !');
 end;
finally
  DBGridTiers.DataSource.DataSet.close;
  DBGridTiers.DataSource.DataSet.open;
  DBGridTiers.DataSource.DataSet.locate('Tiers',TiersCourant,[]);
  DBGridTiers.DataSource.DataSet.EnableControls;
  Patienterfermer;
end;
end;

procedure TTiers.Exporter1Click(Sender: TObject);
begin
  inherited;
EditionPlanAuxL(c_Exportation,DBGridTiers.DataSource.DataSet,nil);
end;

end.
