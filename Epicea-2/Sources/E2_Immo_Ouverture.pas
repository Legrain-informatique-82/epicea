{//////// le 29-04-03  Modif_Isa
j'ai modifier tout ce qui comporte la fonction 'Amortissable'
///////}
unit E2_Immo_Ouverture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,
  DBGrids,
  RXDBCtrl,
  ExRxDBGrid,
  GrDBGrid,
  RXSplit,
  LibRessourceString,
  ExtCtrls,
  StdCtrls,
  DBCtrls,
  ComCtrls,
  Mask,
  RXCtrls,
  ToolEdit,
  Buttons,
  dbtables,
  LibZoneSaisie,
  DMImmosOuverture,
  DMImmos,
  E2_Librairie_Obj,
  registry,
  DB,
  E2_Decl_Records,
  {Gr_AideDate,}
  Gr_Librairie_Obj,
  Menus,
  DMPlanCpt,
  E2_AideCompte,
  LibDates,
  PickDate,
  LibSQL,
  DMBalances,
  DMConstantes,
  E2_LibInfosTable,
  jpeg,
  LibGestionParamXML,
  E2_Recherche,
  Editions,
  DMCorrection,
  LibImport,
  InputQueryFrm_F,
  LibChoixCompte;

type



  TParamAfficheImmo_Ouverture = Record
   typeImmos:TtypeImmos;
   Compte:String;
   LibImmo:String;
   Affiche:Boolean;
   Locate:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   TypePresentation:integer;
  end;

  TImmo_Ouverture = class(TForm)
    PaGrille: TPanel;
    PaCptImmo: TPanel;
    PaDetails: TPanel;
    PaDetailEnTete: TPanel;
    RxSplitter1: TRxSplitter;
    PaDetailCorp: TPanel;
    Pabas: TPanel;
    PaEnteteDescrip: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Libelle: TDBEdit;
    Sous_code: TDBEdit;
    PaDescription: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label20: TLabel;
    ValeurAcquis: TDBEdit;
    DureeAmo: TDBEdit;
    Deduc_Invest: TDBEdit;
    rgTypeAmo: TDBRadioGroup;
    PaComplement: TPanel;
    Panel5: TPanel;
    PaGrilleCpt: TPanel;
    GrDBGrid1: TGrDBGrid;
    PaCptIntit: TPanel;
    Panel2: TPanel;
    PaGrilleEnTete: TPanel;
    GrDBGrid2: TGrDBGrid;
    PaCumul: TPanel;
    GrDBGrid4: TGrDBGrid;
    PaSelectCpt: TPanel;
    RxSBClose: TRxSpeedButton;
    RxSBValider: TRxSpeedButton;
    RxSBInverse: TRxSpeedButton;
    RxSBAnnuleSel: TRxSpeedButton;
    RxChListCpt: TListBox;
    CheckBox1: TCheckBox;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Compte: TDBEdit;
    Code: TDBEdit;
    DateAcquis: TDBDateEdit;
    Date_Mise: TDBDateEdit;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Precdant1: TMenuItem;
    Suivant1: TMenuItem;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImmo: TRxSpeedButton;
    RxSBSubventions: TRxSpeedButton;
    Panel1: TPanel;
    PaInfoComp: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Val_Reelle_Acq: TDBEdit;
    Val_Venale: TDBEdit;
    Date_Reelle_Acq: TDBDateEdit;
    PaSitouverture: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Amo_Eco: TDBEdit;
    Amo_Derog: TDBEdit;
    VNC: TDBEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    Label8: TLabel;
    PaListAmort: TPanel;
    Panel7: TPanel;
    PaList: TPanel;
    LstAmort: TListBox;
    RxSBImport: TRxSpeedButton;
    RxSplitter2: TRxSplitter;
    Button1: TButton;
    TiFiltrageImmosSurCpt: TTimer;
    TiCompteImmos: TTimer;
    ImprimerComptecourant1: TMenuItem;
    Imprimer1: TMenuItem;
    RxMAJ_Balance: TRxSpeedButton;
    Exporter1: TMenuItem;
    Label5: TLabel;
    ReportReprise: TDBEdit;
    Modificationparticulire1: TMenuItem;
    procedure RxSBImmoMouseEnter(Sender: TObject);
    procedure RxSBImmoMouseLeave(Sender: TObject);
    procedure Patitre2Resize(Sender: TObject);
    procedure RxSBImmoClick(Sender: TObject);
    procedure RxSBSubventionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
//    Procedure ReactualiseQuery;
    procedure CompteExit(Sender: TObject);
    procedure Sous_codeExit(Sender: TObject);
    procedure CodeExit(Sender: TObject);
    procedure LibelleExit(Sender: TObject);
    procedure ValeurAcquisExit(Sender: TObject);
    procedure DureeAmoExit(Sender: TObject);
    procedure Deduc_InvestExit(Sender: TObject);
    procedure Val_Reelle_AcqExit(Sender: TObject);
    procedure Val_VenaleExit(Sender: TObject);
    procedure Amo_EcoExit(Sender: TObject);
    procedure Amo_DerogExit(Sender: TObject);
    procedure DateAcquisExit(Sender: TObject);
    procedure Date_MiseExit(Sender: TObject);
    procedure Date_Reelle_AcqExit(Sender: TObject);
    procedure Enregistre;
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure changementEtatBoutons(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure PaEnteteDescripExit(Sender: TObject);
    procedure EtatInitial;
    procedure rgTypeAmoClick(Sender: TObject);
    procedure PaGrilleEnTeteResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleCptResize(Sender: TObject);
    procedure LstAmortExit(Sender: TObject);
    procedure LstAmortClick(Sender: TObject);
    Procedure ChoixValide;
    procedure LstAmortKeyPress(Sender: TObject; var Key: Char);
    procedure rgTypeAmoExit(Sender: TObject);
    procedure LstAmortKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaComplementResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaSitouvertureResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RxSBImportClick(Sender: TObject);
    procedure PaDescriptionExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PabasClick(Sender: TObject);
    procedure TiFiltrageImmosSurCptTimer(Sender: TObject);
    procedure TiCompteImmosTimer(Sender: TObject);
    procedure QuCptUtiliseImmos_OuvertureAfterScroll(DataSet: TDataSet);
    procedure ValeurAcquisKeyPress(Sender: TObject; var Key: Char);

    Procedure GestionInitDM;
    Procedure GereAccesEcran;
    procedure ImprimerComptecourant1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure QuCptUtiliseImmos_OuvertureBeforeScroll(
        DataSet: TDataSet);
    procedure rgTypeAmoChange(Sender: TObject);
    procedure RxMAJ_BalanceClick(Sender: TObject);
    procedure RxMAJ_BalanceMouseEnter(Sender: TObject);
    procedure RxMAJ_BalanceMouseLeave(Sender: TObject);
    procedure RxMAJ_BalanceMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormDeactivate(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure PaDetailEnTeteResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Deduc_InvestKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LibelleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ReportRepriseExit(Sender: TObject);
    procedure ReportRepriseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VNCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VNCDblClick(Sender: TObject);
    procedure modifDureeAmort_TypeAmort;
    procedure DureeAmoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Modificationparticulire1Click(Sender: TObject);
    procedure Date_MiseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure modifDeduc_investissement;
    procedure ModifLibelle;
    procedure ModifDateAmortissement;
    procedure modifReportRepriseDeduction;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    typeImmos:TtypeImmos;
  end;

  Function AfficheImmo_Ouverture(ParamAfficheImmo_Ouverture:TParamAfficheImmo_Ouverture):Boolean;

var
  Immo_Ouverture: TImmo_Ouverture;
  LastLibImmo,LastCode,LastSousCode:string;
  MessDerSub:boolean;
  FlagCompteCourant:Boolean;

implementation

uses E2_Division, E2_Rebut, E2_PlusMoinsValues, E2_Amo3Ans, E2_ListeAcquis,
  E2_DetailAcquis, E2_CessionsImmo, E2_Main, DMImportation, DMRecherche,lib_chaine,
  LibClassObjetSenders,DMExports;

{$R *.DFM}

Function AfficheImmo_Ouverture(ParamAfficheImmo_Ouverture:TParamAfficheImmo_Ouverture):Boolean;
var
ParamDMImmos_Ouverture:TParamDMImmos_Ouverture;
Begin
try//finally
try//except
 if (Immo_Ouverture = nil) then Immo_Ouverture:=TImmo_Ouverture.Create(Application.MainForm);
 if ((ParamAfficheImmo_Ouverture.Quand <> Immo_Ouverture.Quand) and (Immo_Ouverture.Visible=true)) then
   Immo_Ouverture.Close;
 Immo_Ouverture.Quand:=ParamAfficheImmo_Ouverture.Quand;
 Immo_Ouverture.Tag:=ParamAfficheImmo_Ouverture.TypePresentation;
 if not empty(ParamAfficheImmo_Ouverture.TitreForm) then
   Immo_Ouverture.TitreForm:=ParamAfficheImmo_Ouverture.TitreForm;
 Immo_Ouverture.SousTitreForm:=ParamAfficheImmo_Ouverture.SousTitreForm;

//if E.TypeClient = CL_COGERE then
if VerifSiBalanceVerrouillee(0,0).retour then
  begin
   MessageDlg('Attention, la balance d''ouverture est verrouillée, il n''y aura pas '+#13+#10+'de mise à jour de la balance. ', mtWarning, [mbOK], 0); 
   ParamAfficheImmo_Ouverture.AffichageModal:=true;
   E.TypeMAJBalance := MAJ_Report;
  end;

 ParamDMImmos_Ouverture.ImmosDataStateChange := Immo_Ouverture.changementEtatBoutons;
 ParamDMImmos_Ouverture.ImmosBeforeScroll:=Immo_Ouverture.QuCptUtiliseImmos_OuvertureBeforeScroll;
 ParamDMImmos_Ouverture.ImmosAfterScroll:=Immo_Ouverture.QuCptUtiliseImmos_OuvertureAfterScroll;
 ParamDMImmos_Ouverture.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos_Ouverture.Quand := Immo_Ouverture.Quand;

 if ParamAfficheImmo_Ouverture.typeImmos<>C_NonIndique then
   Immo_Ouverture.typeImmos:=ParamAfficheImmo_Ouverture.typeImmos;

 ParamDMImmos_Ouverture.typeImmos:=Immo_Ouverture.typeImmos;
   case Immo_Ouverture.Quand of
      C_Ouverture:Begin
                   if not InitialiseDMImmos_Ouverture(ParamDMImmos_Ouverture).retour then abort;
                  End;
   end;

 if ParamAfficheImmo_Ouverture.Affiche then
  begin
     //Grille des comptes d'emprunts utilisés
     Immo_Ouverture.GrDBGrid1.DataSource := DMImmos_Ouverture.DaCptUtiliseImmos_Ouverture;
     //Grille des emprunts existants pour le compte sélectionné
     Immo_Ouverture.GrDBGrid2.DataSource := DMImmos_Ouverture.daRecupImmosSurCpt;
     //differentes zones de description de l'emprunt selectionné
     Immo_Ouverture.Compte.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Code.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Sous_code.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Libelle.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.DateAcquis.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Date_Mise.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Deduc_Invest.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.rgTypeAmo.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.ValeurAcquis.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.DureeAmo.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Date_Reelle_Acq.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Val_Reelle_Acq.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Val_Venale.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Amo_Eco.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.Amo_Derog.DataSource := DMImmos_Ouverture.daDetailImmo;
     Immo_Ouverture.VNC.DataSource := DMImmos_Ouverture.daDetailImmo;

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);
     if ParamAfficheImmo_Ouverture.AffichageModal then
       Immo_Ouverture.ShowModal
      else
       Immo_Ouverture.Show;
  End;
if ParamAfficheImmo_Ouverture.Locate then
  begin
   if Immo_Ouverture.GrDBGrid1.DataSource.DataSet <> nil then
       Immo_Ouverture.GrDBGrid1.DataSource.DataSet.Locate('Compte',ParamAfficheImmo_Ouverture.Compte,[]);
   if Immo_Ouverture.GrDBGrid2.DataSource.DataSet <> nil then
       Immo_Ouverture.GrDBGrid2.DataSource.DataSet.Locate('Immobilisation',ParamAfficheImmo_Ouverture.LibImmo,[]);
  end;
except
   result:=false;
end; //fin except
finally
  E.TypeMAJBalance := MAJ_Normal;
end;//fin finally
End;


Procedure TImmo_Ouverture.GestionInitDM;
var
ParamDMImmos_Ouverture:TParamDMImmos_Ouverture;
Begin
try
 ParamDMImmos_Ouverture.ImmosDataStateChange := changementEtatBoutons;
 ParamDMImmos_Ouverture.ImmosBeforeScroll:=Immo_Ouverture.QuCptUtiliseImmos_OuvertureBeforeScroll;
 ParamDMImmos_Ouverture.ImmosAfterScroll:=QuCptUtiliseImmos_OuvertureAfterScroll;
 ParamDMImmos_Ouverture.Quand := Quand;
 ParamDMImmos_Ouverture.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos_Ouverture.typeImmos:=typeImmos;
 if not InitialiseDMImmos_Ouverture(ParamDMImmos_Ouverture).retour then abort;
 QuCptUtiliseImmos_OuvertureAfterScroll(nil);
except
  MessageDlg('Problème rencontré lors de l''initialisation du datamodule des '+#13+#10+'immobilisations', mtWarning, [mbOK], 0);
end;
End;


Procedure TImmo_Ouverture.GereAccesEcran;
begin
     //Grille des comptes d'immos utilisées
     GrDBGrid1.ReadOnly := not E.AccesOuverture;
     GrDBGrid1.FSauteColReadOnly := not GrDBGrid1.ReadOnly;
     //Grille des immos existantes pour le compte sélectionné
     GrDBGrid2.ReadOnly := not E.AccesOuverture;
     GrDBGrid2.FSauteColReadOnly := not GrDBGrid2.ReadOnly;

  case Quand of
     C_Ouverture:Begin
                     //differentes zones de description de l'emprunt selectionné
                     Compte.ReadOnly := not E.AccesOuverture;
                     Code.ReadOnly := not E.AccesOuverture;
                     Sous_code.ReadOnly := not E.AccesOuverture;
                     Libelle.ReadOnly := not E.AccesOuverture;
                     DateAcquis.ReadOnly := not E.AccesOuverture;
                     Date_Mise.ReadOnly := not E.AccesOuverture;
                     Deduc_Invest.ReadOnly := not E.AccesOuverture;
                     rgTypeAmo.ReadOnly := not E.AccesOuverture;
                     ValeurAcquis.ReadOnly := not E.AccesOuverture;
                     DureeAmo.ReadOnly := not E.AccesOuverture;
                     Date_Reelle_Acq.ReadOnly:= not E.AccesOuverture;
                     Val_Reelle_Acq.ReadOnly := not E.AccesOuverture;
                     Val_Venale.ReadOnly := not E.AccesOuverture;
                     Amo_Eco.ReadOnly := not E.AccesOuverture;
                     Amo_Derog.ReadOnly := not E.AccesOuverture;
                     VNC.ReadOnly := not E.AccesOuverture;

                    EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesOuverture);
                    EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesOuverture);
                 End;
  end;
DMImmos_Ouverture.GestionAccesEmprunts;
end;



//Procedure TImmo_Ouverture.ReactualiseQuery;
//Begin
////  TiFiltrageImmosSurCpt.Enabled:=true;
//End;

procedure TImmo_Ouverture.RxSBImmoMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clREd;
(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TImmo_Ouverture.RxSBImmoMouseLeave(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
(Sender as TRxSpeedButton).Font.Style:=[];
end;

procedure TImmo_Ouverture.Patitre2Resize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([RxSBImmo,RxSBSubventions],PaTools,90,0,5);
end;

procedure TImmo_Ouverture.RxSBImmoClick(Sender: TObject);
begin
if not RxSBImmo.Down then //si pas immos
  begin
    RxSBSubventions.down:=true;
    typeImmos:=C_sub;
    RxSBSubventions.Click;
  end
else
  begin
   if RxSBSubventions.down=true then
      Begin //si les 2 sont enfoncés
      typeImmos:=C_toutes;
      //DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.close;
//      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring:='%';
//      DMImmos_Ouverture.QuRecupImmosSurCpt.ParamByName('Cpt').asstring:=DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureCompte.asstring;
      End
   else
      Begin //si seulement immos
      typeImmos:=C_Immo;
//      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring:='2%';
//      DMImmos_Ouverture.QuRecupImmosSurCpt.ParamByName('Cpt').asstring:=DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureCompte.asstring;
      End;
  end;    
GestionInitDM;      
//ReactualiseQuery;
end;

procedure TImmo_Ouverture.RxSBSubventionsClick(Sender: TObject);
begin
if not RxSBSubventions.Down then
 begin //si sub n'est pas enfoncé
   RxSBImmo.down:=true;
   typeImmos:=C_immo;
   RxSBImmo.Click;
 end //fin si sub n'est pas enfoncé
else //si sub est enfoncé
   begin
   if RxSBImmo.down=true then
      Begin //si les 2 sont enfoncés
      typeImmos:=C_Toutes;
//      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring:='%';
//      DMImmos_Ouverture.QuRecupImmosSurCpt.ParamByName('Cpt').asstring:=DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureCompte.asstring;
      End
   else
      Begin //si seulement sub
      typeImmos:=C_sub;
//      DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring:='131%';
//      DMImmos_Ouverture.QuRecupImmosSurCpt.ParamByName('Cpt').asstring:=DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureCompte.asstring;
      End;
  end;
GestionInitDM;
//ReactualiseQuery;
//QuCptUtiliseImmos_OuvertureAfterScroll(QuCptUtiliseImmos_Ouverture);
end;

procedure TImmo_Ouverture.FormCreate(Sender: TObject);
var
dateDeb,DateEnd:tdate;
Registre :TRegistry;
Begin
 Registre:= TRegistry.Create;
  try
      if DataModuleImmos=nil then
        DataModuleImmos:=TDataModuleImmos.Create(self);
       if DMImmos_Ouverture=nil then DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);
      FlagCompteCourant:=false;
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
   try
     with Registre do
       begin
       RootKey := HKEY_LOCAL_MACHINE;
       OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, false);
          try
            RxSBImmo.down:=ReadBool('RxSBImmo');
            RxSBSubventions.down:=ReadBool('RxSBSubventions');
          except
            RxSBImmo.down:=true;
            RxSBSubventions.down:=true;
          end;
       end;//fin du with
   finally
     Registre.Free;
     if ((RxSBImmo.down)and(RxSBSubventions.down)) then
       typeImmos:=C_toutes
     else
       if RxSBImmo.down then typeImmos:=C_Immo
       else
         if RxSBSubventions.down then typeImmos:=C_Sub;
   end;
MessDerSub:=true;
PaDetailEnTeteResize(PaDetailEnTete);
end;



procedure TImmo_Ouverture.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
KeyTmp:char;
begin
FlagcompteCourant:=(ssCtrl in Shift);
if (key = VK_RETURN)then
 WinSuivPrec(Handle,key,[LstAmort,RxChListCpt])
else
 WinSuivPrec(Handle,key,[LstAmort,GrDBGrid1,GrDBGrid2,RxChListCpt]);
     If Key = VK_ESCAPE Then
     Begin
     if not PaListAmort.Visible then
      begin
       If DMImmos_Ouverture.taDetailImmo.State = dsBrowse Then
          begin
             Self.Close ;
          end;

      If DMImmos_Ouverture.taDetailImmo.State = dsInsert Then
          Begin
            if not empty(compte.Field.asstring) then
              begin//si commencé à remplir
               If Messagedlg('Annuler la création de cette immobilisation ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DMImmos_Ouverture.taDetailImmo.Cancel;
                    compte.SetFocus;
               End
               Else
               Begin
                    Abort;
               End;
              end//fin si commencé à remplir
            else
              begin
                DMImmos_Ouverture.taDetailImmo.Cancel;
                compte.SetFocus;
              end;
          End;


          If DMImmos_Ouverture.taDetailImmo.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMImmos_Ouverture.taDetailImmo.Cancel;
                    compte.SetFocus;
               End
               Else
               Begin
                    Abort;
               End
          End;
     End
     else
      PaListAmort.Visible:=false;
    end;
end;






Procedure TImmo_Ouverture.InitialiseTable_A_Nil;
Begin
//  DMImmos_Ouverture.daDetailImmo.OnStateChange:=nil;
if DMImmos_Ouverture<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMImmos_Ouverture.daDetailImmo,DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture]);
End;

procedure TImmo_Ouverture.FormDestroy(Sender: TObject);
Var
  Registre :TRegistry;
Begin

  Registre:= TRegistry.Create;
  try
    InitialiseTable_A_Nil;
     with Registre do begin
        RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, True);
        begin
          WriteBool('RxSBImmo',RxSBImmo.down);
          WriteBool('RxSBSubventions',RxSBSubventions.down);
        end;
        CloseKey;
     end;
  finally
     Registre.Free;
  end;
LibGestionParamXML.Destroyform(self,E.User);
if DMImmos_Ouverture<>nil then DMImmos_Ouverture.Free;
if DataModuleImmos<>nil then  DataModuleImmos.Free;
Immo_Ouverture:=nil;
end;


procedure TImmo_Ouverture.FormActivate(Sender: TObject);
begin
initialisationMAJ_Balance(RxMAJ_Balance);
Initialiser_ShortCut_Main(true);
GestionInitDM;
EtatInitial;

Patitre.visible:=Main.AfficheTitre;

GrDBGrid1.ParamColor:=true;
GrDBGrid1.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid1.UpDateColor;

GrDBGrid2.ParamColor:=true;
GrDBGrid2.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid2.UpDateColor;
GrDBGrid2.FSauteColReadOnly := false;

GrDBGrid4.ParamColor:=true;
GrDBGrid4.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid4.UpDateColor;

//    ReactualiseQuery;
    if (DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.RecordCount=0) then
      Compte.SetFocus
    else
      GrDBGrid1.SetFocus;
GereAccesEcran;
end;


procedure TImmo_Ouverture.CompteExit(Sender: TObject);
var
valide:TExceptLGR;
//retourEdit:TRetourCtrlSaisieImmo;
Infosplancpt:TInfosplancpt;
begin
if Compte.Field<>nil then
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Compte.Field);
if valide.Retour=false then
  Begin
     compte.SetFocus;
     abort;
     
  End;
//else
//  Begin
//    Infosplancpt:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[Compte.Field.AsString]);
//    RgTypeAmo.OnClick:=nil;
//     if ((not DataModuleImmos.Amortissable(Compte.Field.AsString).Amortissable)and(RgTypeAmo.DataSource.State=dsinsert)) then
//       Begin
//        Amo_Derog.Enabled:=false;
//        Amo_Eco.Enabled:=false;
//        RgTypeAmo.ItemIndex:=2;
//       End
//     else
//       Begin
//         if DMImmos_Ouverture.taDetailImmo.State=dsinsert then
//            begin
//              Amo_Derog.Enabled:=true;
//              Amo_Eco.Enabled:=true;
//              if Infosplancpt.ImmoDegressif then
//                RgTypeAmo.ItemIndex:=1
//              else
//                RgTypeAmo.ItemIndex:=0;
//            end;
//       End;
//    RgTypeAmo.onclick:=RgTypeAmoClick;
//    DMImmos_Ouverture.DernierCompteSaisie:=compte.Field.asstring;
//  End;
Amo_Derog.Enabled:=RgTypeAmo.ItemIndex<>2;
Amo_Eco.Enabled:=RgTypeAmo.ItemIndex<>2;
end;
end;

procedure TImmo_Ouverture.Sous_codeExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Sous_code.Field);
if valide.Retour=false then
  Begin
     Sous_code.SetFocus;
     abort;
  End;
end;

procedure TImmo_Ouverture.CodeExit(Sender: TObject);
var
valide:TExceptLGR;
begin
if not empty(Code.Field.asstring)then
  while length(Code.Field.asstring)<3 do
    Code.Field.asstring:='0'+Code.Field.asstring;
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Code.Field);
if valide.Retour=false then
  Begin
     code.SetFocus;
     abort;
  End;
end;

procedure TImmo_Ouverture.LibelleExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Libelle.Field);
if valide.Retour=false then
  Begin
    //
  End;
end;

procedure TImmo_Ouverture.ValeurAcquisExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(ValeurAcquis.Field);
if valide.Retour=false then
  Begin
    ValeurAcquis.SetFocus;
    abort;
  End;
end;

procedure TImmo_Ouverture.DureeAmoExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(DureeAmo.Field);
if valide.Retour=false then
  Begin
//    if ActiveControl<>rgTypeAmo then
//      begin
        DureeAmo.SetFocus;
        abort;
//      end;
  End;
BtnEnregistrer.Enabled := not((VerifNumeric(DureeAmo.text).VideOUZero)and(rgTypeAmo.ItemIndex<>2));
Enregister1.Enabled:=BtnEnregistrer.Enabled;
end;

procedure TImmo_Ouverture.Deduc_InvestExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
Reprise:currency;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Deduc_Invest.Field);
if valide.Retour=false then
  Begin
     Deduc_Invest.SetFocus;
     abort;
  End;

end;


procedure TImmo_Ouverture.Val_Reelle_AcqExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Val_Reelle_Acq.Field);
if valide.Retour=false then
  Begin
     //
  End;
end;

procedure TImmo_Ouverture.Val_VenaleExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Val_Venale.Field);
if valide.Retour=false then
  Begin
     //
  End;
end;

procedure TImmo_Ouverture.Amo_EcoExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide.retour:=true;
if not empty(Amo_Eco.Text) then
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Amo_Eco.Field);
if valide.Retour=false then
  Begin
     Amo_Eco.SetFocus;
     abort;
  End;
end;

procedure TImmo_Ouverture.Amo_DerogExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Amo_Derog.Field);
if valide.Retour=false then
  Begin
     Amo_Derog.SetFocus;
     abort;
  End;
end;

procedure TImmo_Ouverture.DateAcquisExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
try
DateAcquis.EditText:=dateInfos_Str(DateAcquis.EditText);
if ((DMImmos_Ouverture.DerniereDateSaisie>0)and(DateAcquis.Field.dataset.state in [dsinsert,dsedit])) then
  DateAcquis.Field.AsDateTime:=AnneeDefaut_SurDerniereDateSaisie(0,e.DatExoDebut-1,DMImmos_Ouverture.DerniereDateSaisie,DateAcquis.EditText).Date_;
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(DateAcquis.Field);
except
  valide.retour:=false;
end;
if valide.Retour=false then
  Begin
     DateAcquis.SetFocus;
     abort;
  End
else
  Begin//si
     DateAcquis.Date:=DateAcquis.Field.AsDateTime;
     DMImmos_Ouverture.DerniereDateSaisie:=DateAcquis.Date;
  End;//fin si
end;


procedure TImmo_Ouverture.Date_MiseExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
try
Date_Mise.EditText:=dateInfos_Str(Date_Mise.EditText);
if ((DMImmos_Ouverture.DerniereDateSaisie>0)and(Date_Mise.Field.dataset.state in [dsinsert,dsedit])) then
  Date_Mise.Field.AsDateTime:=AnneeDefaut_SurDerniereDateSaisie(0,e.DatExoDebut-1,DMImmos_Ouverture.DerniereDateSaisie,Date_Mise.EditText).Date_;
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Date_Mise.Field);
except
  valide.retour:=false;
end;
if valide.Retour=false then
  Begin
     Date_Mise.SetFocus;
     abort;
  End
else
  Begin//si
     Date_Mise.Date:=Date_Mise.Field.AsDateTime;
     DMImmos_Ouverture.DerniereDateSaisie:=Date_Mise.Date;
  End;//fin si
end;

procedure TImmo_Ouverture.Date_Reelle_AcqExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(Date_Reelle_Acq.Field);
if valide.Retour=false then
  Begin
     //
  End;
end;


procedure TImmo_Ouverture.Enregistre;

begin
//vérifier que tout soit bien rempli avant de poster
try
  try
  DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.AfterScroll:=nil;

      if DMImmos_Ouverture.taDetailImmo.State in [dsinsert,dsedit]then
      begin //si table en insertion ou modification
        TableGereStartTransaction(DMImmos_Ouverture.taDetailImmo);
        TableGerePost(DMImmos_Ouverture.taDetailImmo);
      end;//fin si table en insertion ou modification
  except
//      showmessage('Problème rencontré lors de l''enregistrement de l''immobilisation');
      TableGereRollBack(DMImmos_Ouverture.taDetailImmo);
      TableGereRollBack(DMBalance.TaBalance);
      abort;
  end;//fin du try except
finally
  DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.AfterScroll:=QuCptUtiliseImmos_OuvertureAfterScroll;
 DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
end;//fin du try finally
end;


procedure TImmo_Ouverture.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TImmo_Ouverture.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TImmo_Ouverture.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TImmo_Ouverture.BtnEnregistrerClick(Sender: TObject);
begin
  try
    try
       Enregistre;
       compte.SetFocus;
    except
      TableGereRollBack(DMImmos_Ouverture.taDetailImmo);
      TableGereRollBack(DMBalance.TaBalance);
      changementEtatBoutons(self);
      abort;
    end;//fin du try
  finally

  end;//fin du try finally
end;

procedure TImmo_Ouverture.BtnInsererClick(Sender: TObject);
begin
if DMImmos_Ouverture.taDetailImmo.state in [dsinsert,dsedit] then DMImmos_Ouverture.taDetailImmo.cancel;
DMImmos_Ouverture.taDetailImmo.Insert;
if ActiveControl=compte then
  compte.SelLength:=length(compte.Text);
changementEtatBoutons(self);
end;

procedure TImmo_Ouverture.BtnModifierClick(Sender: TObject);
begin
DMImmos_Ouverture.taDetailImmo.Edit;
changementEtatBoutons(self);
end;

procedure TImmo_Ouverture.BtnSupprimerClick(Sender: TObject);
begin
try
   if (ActiveControl<>GrDBGrid1)then
   begin
      try
        TableGereStartTransaction(DMImmos_Ouverture.taDetailImmo);
//         if MessageDlg('Êtes-vous sûr de vouloir supprimer cette immobilisation ?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
//         if application.MessageBox(Pchar('Êtes-vous sûr de vouloir supprimer cette immobilisation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
          GrDBGrid2.SetFocus; // PB le 10/09/03, sinon, on perd l'entourage rouge car
                             // ensuite on rend false
                            // le tab du bouton Supprimer dans ChangementEtatBoutons
           TableGereDelete(DMImmos_Ouverture.taDetailImmo);
//         else
//           abort;
//         if DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.RecordCount=0 then
//           DMImmos_Ouverture.taDetailImmo.append;
         changementEtatBoutons(self);
      except
         TableGereRollBack(DMImmos_Ouverture.taDetailImmo);
         TableGereRollBack(DMBalance.TaBalance);
         abort;
      end;
   end;
finally
  DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
end;
end;

procedure TImmo_Ouverture.BtnFermerClick(Sender: TObject);
begin
BtnAnnulerClick(self);
Self.Close;
end;

procedure TImmo_Ouverture.BtnImprimerClick(Sender: TObject);
var listecpt:TResultStrList;
requete : TQuery;
begin
try
listecpt.Liste:=nil;
ListeCpt.result:=true;
requete := TQuery.Create(self);
   if RxSBImmo.Down then
     begin
       showmessage('Impression des immobilisations');
       if FlagCompteCourant then
       begin
         EditionDesImmosOuvertureL(C_EditionSimple,true,Compte.Text,nil,'Immobilisations')
       end
       else
       begin
          requete.close;
          requete.SQL.clear;
          requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
          requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
          requete.SQL.Add(' where I.compte like(''2%'')');
          requete.Open;
          listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
          if ((listecpt.Result)and(listecpt.liste<>nil)) then
            EditionDesImmosOuvertureL(C_EditionSimple,true,listecpt.Liste,nil,'Immobilisations');
       end;

     end;
   if RxSBSubventions.Down then
     begin
       showmessage('Impression des subventions');
       if FlagCompteCourant then
         EditionDesImmosOuvertureL(C_EditionSimple,true,Compte.Text,nil,'Subventions')
       else
       begin
          requete.close;
          requete.SQL.clear;
          requete.SQL.Add(' select distinct(I.compte),P.libelle,(P.immoAmort)as Amortissable,(P.immoDegressif)as Degressif from "'+e.RepertoireDossier+'immos" I');
          requete.SQL.Add(' Join "'+e.RepertoireDossier+'plancpt" P on(P.compte = I.compte)');
          requete.SQL.Add(' where I.compte like(''13%'')and I.compte not like(''139%'')');
          requete.Open;
          listecpt:=ChoixCompteAffich('Sélectionnez les comptes...',requete,['compte','libelle','Amortissable','Degressif']);
          if ((listecpt.Result)and(listecpt.liste<>nil)) then
            EditionDesImmosOuvertureL(C_EditionSimple,false,listecpt.Liste,nil,'Subventions');
       end;
     end;
FlagCompteCourant:=False;
finally
   requete.close;
   requete.Free;
end;
end;


procedure TImmo_Ouverture.changementEtatBoutons(Sender: TObject);
var
i:integer;
begin
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMImmos_Ouverture.taDetailImmo);
  case DMImmos_Ouverture.taDetailImmo.state of
   dsBrowse: begin
               BtnInserer.Enabled := true;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := DMImmos_Ouverture.taDetailImmo.RecordCount<>0;
               BtnSupprimer.Enabled :=DMImmos_Ouverture.taDetailImmo.RecordCount<>0;
               BtnImprimer.Enabled:=true;
               Compte.ReadOnly:=true;
               code.ReadOnly:=true;
               sous_code.ReadOnly:=true;
               Init_TabStop_Controls([code,Sous_code,Libelle,DateAcquis,
               Date_Mise,Deduc_Invest,ValeurAcquis,DureeAmo,rgTypeAmo,Amo_Eco,
               Amo_Derog,btnAnnuler,BtnFermer,BtnEnregistrer,BtnImprimer,
               BtnInserer,BtnModifier,BtnSupprimer],false);
           End; // Fin du case sur le Tag de la fenêtre
   dsEdit:   begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := not((VerifNumeric(DureeAmo.text).VideOUZero)and(rgTypeAmo.ItemIndex<>2));
               BtnModifier.Enabled :=false;
               BtnSupprimer.Enabled := false;
               BtnImprimer.Enabled:=false;
               Compte.ReadOnly:=false;
               code.ReadOnly:=false;
               sous_code.ReadOnly:=false;
               Init_TabStop_Controls([code,Sous_code,Libelle,DateAcquis,
               Date_Mise,Deduc_Invest,ValeurAcquis,DureeAmo,rgTypeAmo,Amo_Eco,
               Amo_Derog,btnAnnuler,BtnFermer,BtnEnregistrer,BtnImprimer,
               BtnInserer,BtnModifier,BtnSupprimer],true);
               if ((activecontrol = GrDBGrid1) or (activecontrol =GrDBGrid2)) then
               Compte.SetFocus
               else
                  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
             End; // Fin du case sur le Tag de la fenêtre
   dsInsert: begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := not((VerifNumeric(DureeAmo.text).VideOUZero)and(rgTypeAmo.ItemIndex<>2));
               BtnModifier.Enabled := False;
               BtnSupprimer.Enabled := False;
               BtnImprimer.Enabled:=false;
               Compte.ReadOnly:=false;
               code.ReadOnly:=false;
               sous_code.ReadOnly:=false;
               Init_TabStop_Controls([code,Sous_code,Libelle,DateAcquis,
               Date_Mise,Deduc_Invest,ValeurAcquis,DureeAmo,rgTypeAmo,Amo_Eco,
               Amo_Derog,btnAnnuler,BtnFermer,BtnEnregistrer,BtnImprimer,
               BtnInserer,BtnModifier,BtnSupprimer],true);
               Compte.SetFocus;
               End; // Fin du case sur le Tag de la fenêtre
   end;//fin du case.state$
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
//DureeAmo.Enabled:=rgTypeAmo.ItemIndex<>2;
//Amo_Eco.Enabled:=rgTypeAmo.ItemIndex<>2;;
//Amo_Derog.Enabled:=((rgTypeAmo.ItemIndex<>2)and(e.Derogatoire));
GereAccesEcran;
end;


procedure TImmo_Ouverture.Aide1Click(Sender: TObject);
var
Controlcourant:TDBEdit;
AmortOuverture:TAmortImmo;
inplaceTmp:TInplaceEdit;
begin
// Recherche
//if ActiveControl = GrDBGrid2 then
// begin
//  case GrDBGrid2.DataSource.DataSet.State of
//     dsInsert:Begin
//
//              End;
//     dsEdit:Begin
//
//            End;
//     dsBrowse:Begin
//                case GrDBGrid2.SelectedIndex of
//                      0:RechercherQu(GrDBGrid2,DMImmos_Ouverture.QuRecupImmosSurCpt,['Libelle'],['Libelle'],'',0,'Immos');
////                      1:RechercherQu(GrDBGrid2,DMImmos_Ouverture.QuRecupImmosSurCpt,['Designation','Compte','Actif','Date_Saisie'],['Désignation','Compte','',''],'',0);
//                end;
//
//            End;
//  end;
//
// end;


 If activecontrol = Compte Then
  //Afficher aidecompte filtré
  begin
    inplaceTmp:=TInplaceEdit.Create(self);
    MessDerSub:=false;
    //DMImmos_Ouverture.FiltrageAideCompte(36);
    DMImmos_Ouverture.GestionFiltrageAideCompte(DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('Cpt').asstring);
    inplaceTmp.Text:=Compte.field.asstring;
    AideCompteDansContexte(inplaceTmp.Text,inplaceTmp,['Rac1'],true,MessDerSub,false,true,false,false,0);
    if not (DMImmos_Ouverture.taDetailImmo.State in [dsinsert,dsedit,dsinactive]) then
       DMImmos_Ouverture.taDetailImmo.Append;
    compte.Field.AsString:=inplaceTmp.Text;
    compte.Text:=inplaceTmp.Text;
    MessDerSub:=true;
    inplaceTmp.Free;
  end;//fin si activecontrol = edCompte
//*********************

 If activecontrol = DateAcquis Then
  //Afficher aidedate filtré
  begin
    DateAcquis.DoClick;
  end;//fin si activecontrol = DateAcquis
  //*************************
 If ActiveControl=Date_Mise  Then
  //Afficher aidedate filtré
  begin
  Date_Mise.DoClick;
  end;//fin si activecontrol = Date_Mise
  //*************************
 If ActiveControl=Date_Reelle_Acq  Then
  //Afficher aidedate filtré
  begin
    Date_Reelle_Acq.DoClick;
  end;//fin si activecontrol = Date_Reelle_Acq
  //*************************
 If ActiveControl=Amo_Eco  Then
  //Afficher amortissement minimum et maximum
  begin
     AmortOuverture:=DMImmos_Ouverture.CalculerAmortAnneeSurImmo(DMImmos_Ouverture.taDetailImmo,-1);
     LstAmort.Clear;
     LstAmort.Items.Add('Mini: '+currtostr(AmortOuverture.Mini));
//     LstAmort.Items.Add('Maxi: '+currtostr(AmortOuverture.Maxi));
     LstAmort.ItemIndex:=0;
     PaListAmort.Top:=PaGrille.Top+PaDetailCorp.Top+PaComplement.Top+Amo_Eco.Top+8;
     PaListAmort.Left:=PaDetails.left+Label10.left+PaSitouverture.left+Amo_Eco.Left;

     PaListAmort.Visible:=true;
     LstAmort.SetFocus;
  end;//fin si activecontrol = Date_Reelle_Acq
  //*************************
  //
end;

procedure TImmo_Ouverture.PaEnteteDescripExit(Sender: TObject);
var
i:integer;
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
//si pas complètement remplie, empêcher de sortir

try//finally
  try
   if (activecontrol<>btnannuler) then
      for i:=1 to 6 do
        Begin
          if not (i in [2,3])then
             begin
             valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(DMImmos_Ouverture.taDetailImmo.Fields[i]);
             end;
        if valide.Retour=false then
            abort;
        End;
  except
    DMImmos_Ouverture.taDetailImmo.Fields[i].FocusControl;
    abort;
  end;
finally
DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
end;//fin du try finally
end;


procedure TImmo_Ouverture.EtatInitial;
Begin
compteTmp:='';
CodeTmp:='';
SousCodeTmp:='';
LibelleTmp:='';
DMImmos_Ouverture.DerniereDateSaisie:=e.DatExoDebut-1;
DMImmos_Ouverture.DernierCompteSaisie:='';
  if tag=1 then
    Begin
     VisibleControl([PaSitouverture,PaInfoComp],true);
    End
  else
    Begin
     VisibleControl([PaInfoComp],true);
     VisibleControl([PaSitouverture],false);
    End;
//RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
End;

procedure TImmo_Ouverture.rgTypeAmoClick(Sender: TObject);
begin
//if ((not DataModuleImmos.Amortissable(compte.field.AsString).devenirAmortissable)and(rgTypeAmo.DataSource.State=dsinsert))then
DMImmos_Ouverture.TypechoisiPourCompte.choisi:=true;
if ((not DataModuleImmos.Amortissable(compte.field.AsString).devenirAmortissable)or(ValeurAcquis.Field.AsCurrency=0)) then
  begin
    rgTypeAmo.ItemIndex:=2;
  end;
if rgTypeAmo.ItemIndex=2 then
  begin
//  DureeAmo.field.AsString:='';
  DureeAmo.text:='';
  Amo_Eco.field.AsCurrency:=0;
  Amo_Derog.field.AsCurrency:=0;
//  Amo_EcoExit(amo_eco);
  end
else
  DureeAmo.text:=DureeAmo.field.AsString;
end;

procedure TImmo_Ouverture.PaGrilleEnTeteResize(Sender: TObject);
begin
   WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);

   FormateTailleColonne(GrDBGrid2,31,[6,4,5,5,5,5]);

   Panel1.Width:=RenvoiTailleColonne(GrDBGrid2,[0,1,2])+10;
   GrDBGrid4.ColWidths[0]:=RenvoiTailleColonne(GrDBGrid2,[3]);
   GrDBGrid4.ColWidths[1]:=RenvoiTailleColonne(GrDBGrid2,[4]);
   GrDBGrid4.ColWidths[2]:=RenvoiTailleColonne(GrDBGrid2,[5]);
end;

procedure TImmo_Ouverture.PaBtnResize(Sender: TObject);
begin
   FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TImmo_Ouverture.PaGrilleCptResize(Sender: TObject);
begin
   FormateTailleColonne(GrDBGrid1,6,[2,3]);
end;

procedure TImmo_Ouverture.LstAmortExit(Sender: TObject);
begin
 Amo_Eco.SetFocus;
PaListAmort.Visible:=false;
// LstAmort.Visible:=false;

end;

procedure TImmo_Ouverture.LstAmortClick(Sender: TObject);
begin
ChoixValide;
Amo_Eco.SetFocus;
end;

Procedure TImmo_Ouverture.ChoixValide;
begin
if DMImmos_Ouverture.taDetailImmo.State = dsbrowse then
     begin
       DMImmos_Ouverture.taDetailImmo.edit;
       changementEtatBoutons(self);
    end;
    Amo_Eco.field.Asstring:=copy(LstAmort.Items.Strings[LstAmort.ItemIndex],6,length(LstAmort.Items.Strings[LstAmort.ItemIndex])-5);
    Amo_Eco.SetFocus;
end;


procedure TImmo_Ouverture.LstAmortKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
  ChoixValide;
end;

procedure TImmo_Ouverture.rgTypeAmoExit(Sender: TObject);
var
Valide:TExceptLGR;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(rgTypeAmo.Field);
if valide.Retour=false then
  Begin
     rgTypeAmo.SetFocus;
     abort;
  End;
if ((rgTypeAmo.ItemIndex<>2)and(VerifNumeric(DureeAmo.Text).VideOUZero))then
  DureeAmo.SetFocus
else
  if DureeAmo.DataSource.DataSet.State in [dsinsert,dsedit] then
    DureeAmo.field.AsString:=DureeAmo.Text;
//BtnEnregistrer.Enabled := not((VerifNumeric(DureeAmo.text).VideOUZero)and(rgTypeAmo.ItemIndex<>2));
end;



procedure TImmo_Ouverture.LstAmortKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
   VK_ESCAPE:begin
              key:=VK_CANCEL;
              Amo_Eco.SetFocus;
             end;
//   VK_RETURN:begin
//              key:=VK_CANCEL;
//              keyP:=copy(TextListBox1.Items[TextListBox1.ItemIndex],1,1);
//              ComboEdit1KeyPress(ComboEdit1,keyP[1]);
//              ComboEdit1.SetFocus;
//             end;
    VK_UP:begin
            key:=VK_CANCEL;
            if LstAmort.ItemIndex>0 then
             LstAmort.ItemIndex:=LstAmort.ItemIndex-1;
          end;
    VK_DOWN:begin
            key:=VK_CANCEL;
            if (LstAmort.ItemIndex < (LstAmort.Items.Count-1)) then
               LstAmort.ItemIndex:=LstAmort.ItemIndex+1;
            end;
//    else begin
//         keyP:=chr(key);
//         ComboEdit1KeyPress(ComboEdit1,keyP[1]);
//         ComboEdit1.SetFocus;
//         end;
end;

end;

procedure TImmo_Ouverture.PaComplementResize(Sender: TObject);
begin
//if PaListAmort.Visible then
//  begin
//     PaListAmort.Top:=PaGrille.Top+PaDetailCorp.Top+PaComplement.Top+Amo_Eco.Top+8;
//     PaListAmort.Left:=PaDetails.left+Label10.left+PaComplement.left+Amo_Eco.Left+Amo_Eco.Width+PaSitouverture.left+PaInfoComp.width;
////     PaListAmort.Left:=PaDetails.left+Label10.left+PaComplement.left+Amo_Eco.Left+Amo_Eco.Width;
//  end;

end;

procedure TImmo_Ouverture.FormResize(Sender: TObject);
begin
if PaListAmort.Visible then
  begin
     PaListAmort.Top:=PaGrille.Top+PaDetailCorp.Top+PaComplement.Top+Amo_Eco.Top+8;
     PaListAmort.Left:=PaDetails.left+Label10.left+PaSitouverture.left+Amo_Eco.Left;
//     PaListAmort.Left:=PaDetails.left+Label10.left+PaComplement.left+Amo_Eco.Left+Amo_Eco.Width;
  end;

//PaBtn.Top:=self.Height - PaBtn.Height - Pabas.Height;
end;

procedure TImmo_Ouverture.PaSitouvertureResize(Sender: TObject);
begin
if PaListAmort.Visible then
  begin
     PaListAmort.Top:=PaGrille.Top+PaDetailCorp.Top+PaComplement.Top+Amo_Eco.Top+8;
     PaListAmort.Left:=PaDetails.left+Label10.left+PaSitouverture.left+Amo_Eco.Left;
//     PaListAmort.Left:=PaDetails.left+Label10.left+PaComplement.left+Amo_Eco.Left+Amo_Eco.Width;
  end;
end;

procedure TImmo_Ouverture.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if DMImmos_Ouverture <> nil then
 begin
  // Si l'utilisateur est en mode Insertion
     If DMImmos_Ouverture.taDetailImmo.State = dsInsert Then
     Begin
          If BtnEnregistrer.Enabled Then
          Begin
               self.WindowState:=wsNormal;
               self.BringToFront;
//               If Messagedlg('Voulez-vous enregistrer cette nouvelle immobilisation ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                if application.MessageBox(Pchar('Voulez-vous enregistrer cette nouvelle immobilisation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                 begin
                   BtnEnregistrerClick(btnenregistrer);
                   canclose:=true;
                  end
                  else
                   begin
                   DMImmos_Ouverture.taDetailImmo.Cancel;
                   canclose:=true;
                   end;
          End
          Else
          Begin
               self.WindowState:=wsNormal;
               self.BringToFront;
//               If Messagedlg('Voulez-vous annuler la création cette immobilisation ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                if application.MessageBox(Pchar('Voulez-vous annuler la création cette immobilisation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
                begin
                  DMImmos_Ouverture.taDetailImmo.Cancel;
                  canclose:=true;
                end
               Else
                 begin
                  canclose:=false;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DMImmos_Ouverture.taDetailImmo.State = dsEdit Then
     Begin
               self.WindowState:=wsNormal;
               self.BringToFront;
//          If Messagedlg('Voulez-vous enregistrer les modifications de cette immobilisation ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
           if application.MessageBox(Pchar('Voulez-vous enregistrer les modifications de cette immobilisation ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes then
           begin
            BtnEnregistrerClick(btnenregistrer);
            canclose:=true;
             end
             else
             begin
              DMImmos_Ouverture.taDetailImmo.Cancel;
             end;
     End; // Fin utilisateur est en mode Modification
    ReEnableControls(DMImmos_Ouverture.taDetailImmo);

  end;//fin si DMImmos_Ouverture <> nil
if CanClose then
begin
  InitialiseTable_A_Nil;
  Initialiser_ShortCut_Main(false);
end
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);
 end;
end;


procedure TImmo_Ouverture.RxSBImportClick(Sender: TObject);
begin
  DMImmos_Ouverture.taDetailImmo.DisableControls;
  DMImport.Import_Immo(DMImmos_Ouverture.taDetailImmo,true);
  changementEtatBoutons(DMImmos_Ouverture.taDetailImmo);
  DMImmos_Ouverture.taDetailImmo.EnableControls;
end;

procedure TImmo_Ouverture.PaDescriptionExit(Sender: TObject);
var
i:integer;
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
//si pas complètement remplie, empêcher de sortir

try//finally
  try
   if (activecontrol<>btnannuler) then
      for i:=7 to 26 do
        Begin
          if not (i in [10,16])then
             begin
             valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(DMImmos_Ouverture.taDetailImmo.Fields[i]);
             end;
        if valide.Retour=false then
            abort;
        End;
  except
    DMImmos_Ouverture.taDetailImmo.Fields[i].FocusControl;
    abort;
  end;
finally
DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
end;//fin du try finally
end;

procedure TImmo_Ouverture.Button1Click(Sender: TObject);
begin
try
 showmessage('Pour Iporter les immo d''ouverture, vous devez aller dans le menu prévu à cet effet !');
//  DMImmos_Ouverture.taDetailImmo.DisableControls;
//  DMImport.Import_Immo_SIEA2I(DMImmos_Ouverture.taDetailImmo,true);
//  changementEtatBoutons(DMImmos_Ouverture.taDetailImmo);
//  DMImmos_Ouverture.taDetailImmo.EnableControls;
finally
 //
end;
end;

procedure TImmo_Ouverture.PabasClick(Sender: TObject);
begin
ReEnableControls(GrDBGrid1.DataSource.DataSet);
ReEnableControls(GrDBGrid2.DataSource.DataSet);
end;

procedure TImmo_Ouverture.TiFiltrageImmosSurCptTimer(Sender: TObject);
begin
  try
    DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.DisableControls;
    DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.active:=false;
    DMImmos_Ouverture.taDetailImmo.MasterSource :=DMImmos_Ouverture.daRecupImmosSurCpt; // PB
    DMImmos_Ouverture.taDetailImmo.MasterFields := 'ID'; // PB
    DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.Open;
    DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.EnableControls;
  finally
    TiFiltrageImmosSurCpt.Enabled:=false;
    ReEnableControls(DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture);
    ReEnableControls(DMImmos_Ouverture.QuRecupImmosSurCpt);
  end;
end;

procedure TImmo_Ouverture.TiCompteImmosTimer(Sender: TObject);
begin
  try
    DMImmos_Ouverture.QuRecupImmosSurCpt.DisableControls;
    if DMImmos_Ouverture.taDetailImmo.State in [dsedit,dsinsert] then
      QuCptUtiliseImmos_OuvertureBeforeScroll(DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture);
    DMImmos_Ouverture.Filtrage_QuRecupImmosSurCpt_SurCpt(DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureCompte.asstring,DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture.ParamByName('DateFin').asdate);

    DMImmos_Ouverture.qryTotalCumulImmos.DisableControls;
    DMImmos_Ouverture.qryTotalCumulImmos.ParamByName('Cpt').asstring:=DMImmos_Ouverture.QuCptUtiliseImmos_OuvertureCompte.AsString;
    DMImmos_Ouverture.qryTotalCumulImmos.ParamByName('DateAchat').AsDate:=e.DatExoDebut-1;
    DMImmos_Ouverture.qryTotalCumulImmos.ParamByName('DateDeb').asdate:=e.DatExoDebut;
    DMImmos_Ouverture.qryTotalCumulImmos.Active:=false;
    DMImmos_Ouverture.qryTotalCumulImmos.Open;
    DMImmos_Ouverture.qryTotalCumulImmos.EnableControls;

    DMImmos_Ouverture.QuRecupImmosSurCpt.EnableControls;
  finally
    TiCompteImmos.Enabled:=false;
    ReEnableControls(DMImmos_Ouverture.QuCptUtiliseImmos_Ouverture);
    ReEnableControls(DMImmos_Ouverture.QuRecupImmosSurCpt);
//    TiFiltrageImmosSurCpt.enabled:=true;
  end;
end;


procedure TImmo_Ouverture.QuCptUtiliseImmos_OuvertureAfterScroll(
  DataSet: TDataSet);
begin
      TiCompteImmos.Enabled:=true;
//  TiFiltrageImmosSurCpt.Enabled:=true;
end;

procedure TImmo_Ouverture.ValeurAcquisKeyPress(Sender: TObject;
  var Key: Char);
begin
str_QueDesChiffresCurr_Char((sender as TDBEdit).Text,key,(sender as TDBEdit).SelStart);
end;

procedure TImmo_Ouverture.ImprimerComptecourant1Click(Sender: TObject);
begin
FlagCompteCourant:=true;
BtnImprimer.Click;
end;

procedure TImmo_Ouverture.PopupMenu1Popup(Sender: TObject);
begin
ImprimerComptecourant1.Caption := 'Imprimer le compte : '+ compte.Text;
end;


procedure TImmo_Ouverture.QuCptUtiliseImmos_OuvertureBeforeScroll(
  DataSet: TDataSet);
begin
try
//si dataset en insertion ou modif, poster
if Compte.DataSource.DataSet.State in [dsinsert,dsedit]then
  Begin
      If DMImmos_Ouverture.taDetailImmo.State = dsInsert Then
          Begin
            if not empty(compte.Field.asstring) then
              begin//si commencé à remplir
               If Messagedlg('Annuler la création de cette immobilisation ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DMImmos_Ouverture.taDetailImmo.Cancel;
               End
               Else
               Begin
                    Abort;
               End;
              end//fin si commencé à remplir
            else
              begin
                DMImmos_Ouverture.taDetailImmo.Cancel;
              end;
          End;


          If DMImmos_Ouverture.taDetailImmo.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DMImmos_Ouverture.taDetailImmo.Cancel;
               End
               Else
               Begin
                    Abort;
               End
          End;
      PaListAmort.Visible:=false;
  end;
except
  compte.SetFocus;
  abort;
end;
end;


procedure TImmo_Ouverture.rgTypeAmoChange(Sender: TObject);
begin
BtnEnregistrer.Enabled := not((VerifNumeric(DureeAmo.text).VideOUZero)and(rgTypeAmo.ItemIndex<>2));
Enregister1.Enabled:=BtnEnregistrer.Enabled;
//if(not DureeAmo.ReadOnly)then
  DureeAmo.ReadOnly:=rgTypeAmo.ItemIndex=2;
//DureeAmo.Enabled:=rgTypeAmo.ItemIndex<>2;
Amo_Eco.Enabled:=rgTypeAmo.ItemIndex<>2;;
Amo_Derog.Enabled:=((rgTypeAmo.ItemIndex<>2)and(e.Derogatoire));
end;

procedure TImmo_Ouverture.RxMAJ_BalanceClick(Sender: TObject);
begin
Activation_Desactivation_MAJ_Balance;
initialisationMAJ_Balance(RxMAJ_Balance);
end;



procedure TImmo_Ouverture.RxMAJ_BalanceMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clREd;
(Sender as TRxSpeedButton).Font.Style:=[fsBold];  
end;

procedure TImmo_Ouverture.RxMAJ_BalanceMouseLeave(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
(Sender as TRxSpeedButton).Font.Style:=[];
end;

procedure TImmo_Ouverture.RxMAJ_BalanceMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TImmo_Ouverture.FormDeactivate(Sender: TObject);
begin
e.TypeMAJBalance:=MAJ_Normal;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TImmo_Ouverture.Exporter1Click(Sender: TObject);
begin
if RxSBImmo.Down then
   begin
     if FlagCompteCourant then
       EditionDesImmosOuvertureL(C_Exportation,true,Compte.Text,nil,'Immobilisations')
     else
       EditionDesImmosOuvertureL(C_Exportation,'2*',true,nil,'Immobilisations');
   end;
 if RxSBSubventions.Down then
   begin
     if FlagCompteCourant then
       EditionDesImmosOuvertureL(C_Exportation,true,Compte.Text,nil,'Subventions')
     else
       EditionDesImmosOuvertureL(C_Exportation,'131*',false,nil,'Subventions');
   end;
FlagCompteCourant:=False;
end;


procedure TImmo_Ouverture.Calculatrice1Click(Sender: TObject);
begin
if (ActiveControl = ValeurAcquis)or(ActiveControl = Deduc_Invest) then
  AfficheCalculatrice(ActiveControl)
else
  AfficheCalculatrice(nil);  
end;

procedure TImmo_Ouverture.PaDetailEnTeteResize(Sender: TObject);
begin
   WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur,true);

   FormateTailleColonne(GrDBGrid2,31,[6,4,5,5,5,5]);

   Panel1.Width:=RenvoiTailleColonne(GrDBGrid2,[0,1,2])+10;
   GrDBGrid4.ColWidths[0]:=RenvoiTailleColonne(GrDBGrid2,[3]);
   GrDBGrid4.ColWidths[1]:=RenvoiTailleColonne(GrDBGrid2,[4]);
   GrDBGrid4.ColWidths[2]:=RenvoiTailleColonne(GrDBGrid2,[5]);
end;

procedure TImmo_Ouverture.FormShow(Sender: TObject);
begin
PaDetailEnTeteResize(PaDetailEnTete);
end;


procedure TImmo_Ouverture.Deduc_InvestKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Shift = [ssCtrl]) and (key=VK_f2) and not(E.AccesOuverture)then
     modifDeduc_investissement;
end;

procedure TImmo_Ouverture.LibelleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Shift = [ssCtrl]) and (key=VK_f2) and not(E.AccesOuverture)then
      ModifLibelle;

end;

procedure TImmo_Ouverture.ReportRepriseExit(Sender: TObject);
var
valide:TExceptLGR;
retourEdit:TRetourCtrlSaisieImmo;
begin
valide:=DMImmos_Ouverture.CtrlSaisieDescriptionAmort_Ouverture(ReportReprise.Field);
if valide.Retour=false then
  Begin
     ReportReprise.SetFocus;
     abort;
  End;
end;

procedure TImmo_Ouverture.ReportRepriseKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

   if (Shift = [ssCtrl]) and (key=VK_f2) and not(E.AccesOuverture)then
      modifReportRepriseDeduction;

end;


procedure TImmo_Ouverture.VNCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=VK_f4) then
      begin
         VNCDblClick(vnc);
      end;
end;

procedure TImmo_Ouverture.VNCDblClick(Sender: TObject);
var chiffre:String;
Requete : TQuery;
//rang : integer;
begin
chiffre:='0';
   if (E.AccesOuverture) then
      begin
      chiffre:=DMImmos_Ouverture.taDetailImmo.findfield('VNC_Ouverture').AsString;
       if(MyInputQuery_Chiffre(self,'Valeur nette comptable','Saisir le montant de la valeur nette comptable',
                    chiffre,'',[#48..#57,DecimalSeparator],0,DMImmos_Ouverture.taDetailImmo.findfield('Valeur_a_amortir').AsCurrency,true)) then
                begin
                  chiffre:=CurrToStr(arrondi(StrToCurr_Lgr(chiffre),2));
//                  if Application.MessageBox(Pchar('Confirmez-vous l''enregistrement de la valeur nette comptable'+
//                  RetourChariotSimple+'pour un montant de : '+chiffre+E.DeviseSigle),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                  begin
                      try//finally
                        TableGereEdit(DMImmos_Ouverture.taDetailImmo);
                        //DMImmos_Ouverture.taDetailImmoVNC_Ouverture.AsCurrency:=strtocurr(chiffre);
                        DMImmos_Ouverture.taDetailImmoAmort_Derog.AsCurrency:=0;
                        DMImmos_Ouverture.taDetailImmoAmort_Eco.AsCurrency:=DMImmos_Ouverture.taDetailImmoValeur_a_amortir.AsCurrency-
                          strtocurr(chiffre);
                      finally
                          //
                      end;
                  end;
                end;
      end;
end;


procedure TImmo_Ouverture.modifDureeAmort_TypeAmort;
var chiffre:String;
Requete : TQuery;
rang : integer;
typeAmort:string;
begin
chiffre:='0';
   if not(E.AccesOuverture)then
      begin
      rang:=DMImmos_Ouverture.taDetailImmo.findfield('id').AsInteger;
      if(DMImmos_Ouverture.taDetailImmo.findfield('Duree_Amt').AsCurrency<>0)then
        chiffre:=DMImmos_Ouverture.taDetailImmo.findfield('Duree_Amt').AsString;
       if(MyInputQuery(self,'Durée de l''amortissement','Saisir la durée de l''amortissement',
                    chiffre,'',[#48..#57,DecimalSeparator],5)) then
                begin
                  //chiffre:=CurrToStr(arrondi(StrToCurr_Lgr(chiffre),2));
                  if Application.MessageBox(Pchar('Confirmez-vous l''enregistrement de la durée de l''amortissement'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                  begin
                      try//finally
                      //enregistrer la durée de l'amortissement dans la table des immos
                       if(DMImmos_Ouverture.taDetailImmoType_Amt.AsString='N')then //part sociale
                           typeAmort:='L' else typeAmort:=DMImmos_Ouverture.taDetailImmoType_Amt.AsString;

                        Requete := TQuery.Create(application.MainForm);
                        Requete.close;
                        Requete.DatabaseName := DM_C_NomAliasDossier;
                        Requete.SQL.Clear;
                        Requete.SQL.Add('update immos set Duree_Amt = '''+chiffre+''' ,Type_Amt = '''+typeAmort+''' where id ='+IntToStr_Lgr(rang));
                        Requete.ExecSQL;
                        TableGereCommit(Requete);
                        DMImmos_Ouverture.taDetailImmo.Refresh;
                        Requete.close;
                      finally
                         DMImmos_Ouverture.taDetailImmo.Locate('id',rang,[]);
                         Requete.free;
                      end;
                  end;
                end;
      end;
end;
procedure TImmo_Ouverture.DureeAmoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if(Shift = [ssCtrl]) and (key=VK_f2)then
  modifDureeAmort_TypeAmort;
end;

procedure TImmo_Ouverture.Modificationparticulire1Click(Sender: TObject);
begin
if(ActiveControl=Libelle)then
begin
   ModifLibelle;
end;
if(ActiveControl=Deduc_Invest)then
begin
   modifDeduc_investissement;
end;
if(ActiveControl=Date_Mise)then
begin
   ModifDateAmortissement;
end;
if(ActiveControl=DureeAmo)then
begin
    modifDureeAmort_TypeAmort;
end;
end;

procedure TImmo_Ouverture.Date_MiseKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if(Shift = [ssCtrl]) and (key=VK_f2)then
   ModifDateAmortissement;
end;


procedure TImmo_Ouverture.modifDeduc_investissement;
var chiffre:String;
Requete : TQuery;
rang : integer;
Reprise:currency;
begin
chiffre:='0';
   if not(E.AccesOuverture)then
      begin
      rang:=DMImmos_Ouverture.taDetailImmo.findfield('id').AsInteger;
      if(DMImmos_Ouverture.taDetailImmo.findfield('Mt_deduc_invest').AsCurrency<>0)then
        chiffre:=DMImmos_Ouverture.taDetailImmo.findfield('Mt_deduc_invest').AsString;
       if(MyInputQuery_Chiffre(self,'Déduction pour investissement','Saisir le montant de la déduction pour investissement',
                    chiffre,'',[#48..#57,DecimalSeparator],0,DMImmos_Ouverture.taDetailImmo.findfield('Valeur_a_amortir').AsCurrency,true)) then
                begin
                  chiffre:=CurrToStr(arrondi(StrToCurr_Lgr(chiffre),2));
                  if Application.MessageBox(Pchar('Confirmez-vous l''enregistrement de la déduction pour investissement'+
                  RetourChariotSimple+'pour un montant de : '+chiffre+E.DeviseSigle),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                  begin
                      try//finally
                      //enregistrer la déduction dans la table des immos
                       if(str_commence_par(DMImmos_Ouverture.taDetailImmoCompte.AsString,'262'))then //part sociale
                           Reprise:=arrondi((StrToCurr_Lgr(chiffre)/10)*libdates.NbAnneReel(e.DatExoDebut-1,DMImmos_Ouverture.taDetailImmoDate_Achat.AsDateTime),2)
                       else //si immo normale
                           Reprise:=Arrondi(((DMImmos_Ouverture.taDetailImmoAmort_Eco.ascurrency+DMImmos_Ouverture.taDetailImmoAmort_Derog.ascurrency)
                             /DMImmos_Ouverture.taDetailImmoValeur_a_Amortir.ascurrency)*StrToCurr_Lgr(chiffre),2);

                        Requete := TQuery.Create(application.MainForm);
                        Requete.close;
                        Requete.DatabaseName := DM_C_NomAliasDossier;
                        Requete.SQL.Clear;         // deduc_invest = true and
                        Requete.SQL.Add('update immos set Mt_deduc_invest = '+chiffre+' ,Reprise_deduc_invest = '+CurrToStr(Reprise)+' where id ='+IntToStr_Lgr(rang));
                        Requete.ExecSQL;
                        TableGereCommit(Requete);
                        DMImmos_Ouverture.taDetailImmo.Refresh;
                        Requete.close;
                      finally
                         DMImmos_Ouverture.taDetailImmo.Locate('id',rang,[]);
                         Requete.free;
                      end;
                  end;
                end;
      end;
end;

procedure TImmo_Ouverture.ModifLibelle;
var Value:String;
Requete : TQuery;
rang : integer;
begin
   if not(E.AccesOuverture)then
      begin
      rang:=DMImmos_Ouverture.taDetailImmo.findfield('id').AsInteger;
      value:=DMImmos_Ouverture.taDetailImmo.findfield('libelle').AsString;
       if(MyInputQuery(self,'Libellé d''une immobilisation à l''ouverture','Saisir le nouveau libellé de l''immobilisation',
                    Value,'',[#0..#127],100)) then
                begin
                  if Application.MessageBox(Pchar('Confirmez-vous l''enregistrement du nouveau libellé :'+
                  RetourChariotSimple+Value),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                  begin
                      try//finally
                      //enregistrer la déduction dans la table des immos
                        Requete := TQuery.Create(application.MainForm);
                        Requete.close;
                        Requete.DatabaseName := DM_C_NomAliasDossier;
                        Requete.SQL.Clear;         // deduc_invest = true and
                        Requete.SQL.Add('update immos set libelle = '''+value+''' where id ='+IntToStr_Lgr(rang));
                        Requete.ExecSQL;
                        TableGereCommit(Requete);
                        DMImmos_Ouverture.taDetailImmo.Refresh;
                        Requete.close;
                      finally
                         DMImmos_Ouverture.taDetailImmo.Locate('id',rang,[]);
                         Requete.free;
                      end;
                  end;
                end;
      end;
end;

procedure TImmo_Ouverture.ModifDateAmortissement;
var Value:String;
Requete : TQuery;
rang : integer;
datefin:Tdate;
begin
   if not(E.AccesOuverture)then
      begin
      rang:=DMImmos_Ouverture.taDetailImmo.findfield('id').AsInteger;
      //value:=DMImmos_Ouverture.taDetailImmo.findfield('Date_Mise_en_Service').AsString;
      datefin:=DMImmos_Ouverture.taDetailImmo.findfield('Date_Mise_en_Service').AsDateTime;
       if(MyInputQuery_Date(self,'Date début d''amortissement ','Saisir la date de début d''amortissement',
                    datefin,'',[#0])) then
                begin
                  if Application.MessageBox(Pchar('Confirmez-vous l''enregistrement de la nouvelle date de début d''amortissement :'+
                  RetourChariotSimple+Value),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                  begin
                      try//finally
                      //enregistrer la déduction dans la table des immos
                      value:=DateToStr_Lgr(datefin);
                        Requete := TQuery.Create(application.MainForm);
                        Requete.close;
                        Requete.DatabaseName := DM_C_NomAliasDossier;
                        Requete.SQL.Clear;         // deduc_invest = true and
                        Requete.SQL.Add('update immos set Date_Mise_en_Service = cast('''+value+'''as date) where id ='+IntToStr_Lgr(rang));
                        Requete.ExecSQL;
                        TableGereCommit(Requete);
                        DMImmos_Ouverture.taDetailImmo.Refresh;
                        Requete.close;
                      finally
                         DMImmos_Ouverture.taDetailImmo.Locate('id',rang,[]);
                         Requete.free;
                      end;
                  end;
                end;
      end;
end;

procedure TImmo_Ouverture.modifReportRepriseDeduction;
var chiffre:String;
Requete : TQuery;
rang : integer;
Reprise:currency;
begin
//if DMImmos_Ouverture=nil then DMImmos_Ouverture := TDMImmos_Ouverture.Create(application.MainForm);
   if not(E.AccesOuverture)then
      begin
      rang:=DMImmos_Ouverture.taDetailImmo.findfield('id').AsInteger;
       if(str_commence_par(DMImmos_Ouverture.taDetailImmoCompte.AsString,'262'))then //part sociale
           Reprise:=Arrondi((DMImmos_Ouverture.taDetailImmoMt_Deduc_Invest.ascurrency/10)*libdates.NbAnneReel(e.DatExoDebut-1,DMImmos_Ouverture.taDetailImmoDate_Achat.AsDateTime),2)
       else //si immo normale
           Reprise:=Arrondi(((DMImmos_Ouverture.taDetailImmoAmort_Eco.ascurrency+DMImmos_Ouverture.taDetailImmoAmort_Derog.ascurrency)
             /DMImmos_Ouverture.taDetailImmoValeur_a_Amortir.ascurrency)*DMImmos_Ouverture.taDetailImmoMt_Deduc_Invest.ascurrency,2);
       chiffre:=CurrToStr(reprise);
       if(MyInputQuery_Chiffre(self,'Report reprise déduction pour investissement','Saisir le montant du report de la reprise de la déduction pour investissement',
                    chiffre,'',[#48..#57,DecimalSeparator],0,DMImmos_Ouverture.taDetailImmoMt_Deduc_Invest.ascurrency,true)) then
                begin
                reprise:=arrondi(StrToCurr_Lgr(chiffre),2);
                chiffre:=CurrToStr(reprise);
                  if Application.MessageBox(Pchar('Confirmez-vous l''enregistrement du report de la reprise de la déduction pour investissement'+
                  RetourChariotSimple+'pour un montant de : '+chiffre+E.DeviseSigle),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
                  begin
                      try//finally
                      //enregistrer le report de la reprise de la déduction dans la table des immos
                        Requete := TQuery.Create(application.MainForm);
                        Requete.close;
                        Requete.DatabaseName := DM_C_NomAliasDossier;
                        Requete.SQL.Clear;         // deduc_invest = true and
                        Requete.SQL.Add('update immos set Reprise_deduc_invest = '+chiffre+' where id ='+IntToStr_Lgr(rang));
                        Requete.ExecSQL;
                        TableGereCommit(Requete);
                        DMImmos_Ouverture.taDetailImmo.Refresh;
                        Requete.close;
                      finally
                         DMImmos_Ouverture.taDetailImmo.Locate('id',rang,[]);
                         Requete.free;
                      end;
                  end;
                end;
      end;
end;
end.
