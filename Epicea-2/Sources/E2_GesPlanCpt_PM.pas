{***************************************************************
 *
 * Unit Name: E2_GesPlanCpt
 * Purpose  :
 * Author   : Assemat, BP
 * History  :
 *
 ****************************************************************}

//****************************************************************************//
//*****  Permet la cr�ation, la consultation et la modification          *****//
//*****                      des comptes                                 *****//
//****************************************************************************//


unit E2_GesPlanCpt_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj, Buttons, Db, DBTables,
  Mask, DBCtrls, ExtCtrls, Grids,ShellAPI,
  DBGrids,Registry, RXDBCtrl, ExRxDBGrid, ToolEdit, E2_AideTva,
  GrDBGrid,LibZoneSaisie, RXCtrls,LibRessourceString,E2_Decl_Records,
  E2_CptImmos,E2_LibInfosTable,CurrEdit,Lib_chaine,ZoneDeSaisie,LibFichRep,E2_REcherche,DiversProjets,
  E2_GestPlanSaisie,
  LibChoixCompte,
  jpeg,
  LibGestionParamXML,
  editions;

type
  TPAramAffichPlan = record
   CompteASelectionner:String;
  end;
  TPlanCpt_PM = class(TForm)
    Patitre: TPanel;
    PaBas: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    BtnClasse1: TSpeedButton;
    BtnClasse2: TSpeedButton;
    BtnClasse3: TSpeedButton;
    BtnClasse4: TSpeedButton;
    BtnClasse5: TSpeedButton;
    BtnClasse6: TSpeedButton;
    BtnClasse7: TSpeedButton;
    BtnClasse8: TSpeedButton;
    BtnClasse9: TSpeedButton;
    PaGrille: TPanel;
    DBGrid1: TGrDBGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnJournal: TButton;
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
    MenuItem1: TMenuItem;
    Journal1: TMenuItem;
    Label4: TLabel;
    RxCheckListBox1: TRxCheckListBox;
    RxSBET: TRxSpeedButton;
    RxSBOU: TRxSpeedButton;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    EdCompte: TRxCalcEdit;
    Visualisationsurpriode1: TMenuItem;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    TauxTVApardfaut1: TMenuItem;
    RxSBPlanCpt: TRxSpeedButton;
    Balance1: TMenuItem;
    RxSBPlanSaisie: TRxSpeedButton;
    PlandeSaisie1: TMenuItem;
    RxSBTvaDebit: TRxSpeedButton;
    Exporter1: TMenuItem;
    procedure BtnFermerClick(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    Procedure initialiseTableEvent;
    procedure FormDestroy(Sender: TObject);
    procedure DaPlanCptUpdateData(Sender: TObject);
    procedure DaPlanCptStateChange(Sender: TObject);
    procedure BtnClasse1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdCompteChange(Sender: TObject);
    procedure EdCompteExit(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Menu2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdCompteKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnModifierClick(Sender: TObject);
    Function CalculLeft (colcourante : integer) : integer;
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Voircritures1Click(Sender: TObject);
    procedure EnabledSButton(Actif:boolean);
    procedure FormDeactivate(Sender: TObject);
    Procedure DeplacementGrille(VersDroite:boolean; var Key: Word);
    Procedure InitBouttonCreationJournaux(DataSet: TDataSet);
    procedure BtnJournalClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure TaPlanCptAfterScroll(DataSet: TDataSet);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RxCheckListBox1ClickCheck(Sender: TObject);
    procedure TaPlanCptFilterRecord(DataSet: TDataSet;
              var Accept: Boolean);
    Function CalculIndexPredicat:String;
    procedure RxSBOUClick(Sender: TObject);
    procedure RxSBETClick(Sender: TObject);
    procedure RxCheckListBox1Exit(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Visualisationsurpriode1Click(Sender: TObject);
    procedure TauxTVApardfaut1Click(Sender: TObject);
    procedure PaBtnClick(Sender: TObject);
    procedure RxSBPlanCptClick(Sender: TObject);
    procedure RxSBPlanSaisieClick(Sender: TObject);
    procedure PlandeSaisie1Click(Sender: TObject);
    procedure RxSBTvaDebitClick(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { D�clarations priv�es }
    procedure MouseMoveMessage(var Msg: TMsg; var Handled: Boolean);

  public
    { D�clarations publiques }
    EnDemandeCreation:Boolean;
    CompteACreer,TitreForm,SousTitreForm:String;
//    tvaTaux:real;
//    OldtvaTaux:real;
//    tvaCode:string;
//    filtreTaux:boolean;
  protected
  end;

// Variables globales.
var
  PlanCpt_PM: TPlanCpt_PM;

  
  cpt,Compte, ChaineRecherche : String;
  Libelle : string;
  DemandeCreationPoste:boolean;
  //Total du compte affich�
  TotalCpt:currency;

  IndexPredicat:Integer;

  Function PlanCptAffiche(PAramAffichPlan:TPAramAffichPlan):Boolean;
  Function CreationCompteAffiche(CompteACreer:String;Affiche:Boolean):boolean;
implementation

{$R *.DFM}

Uses E2_Librairie_obj,
  //Gr_Calculatrice,
  E2_AideAssist,LibSQL,
  E2_TabVisuPiece2, DMPlanCpt,E2_PlanOrg,DMEcriture, E2_Main, DMAide,
  E2_CreationJournal, DMRecherche, E2_AideCompte, DMConstantes,
  DMBaseDonnee, DMInitTablesEpi, E2_InitTableEpi,
  DMImportation,
  E2_BalanceNew,
  E2_VisuListeView,
  DMExports, ImportDll, E2_ChangementTva, LibChoixCompteCoche, Gr_MultDos;

Function PlanCptAffiche(PAramAffichPlan:TPAramAffichPlan):Boolean;
Begin
try
   result:=false;
   if PlanCpt_PM = nil then PlanCpt_PM:=TPlanCpt_PM.Create(application);
   PlanCpt_PM.Show;
   PlanCpt_PM.EdCompte.Text:=ParamAffichPlan.CompteASelectionner;
except
abort;
end;
End;

Function CreationCompteAffiche(CompteACreer:String;Affiche:Boolean):boolean;
var
EtatFiche:TEtatFiche;
OldFiltre:TEtatFiltre;
Begin
try
   result:=false;
   if PlanCpt_PM = nil then PlanCpt_PM:=TPlanCpt_PM.Create(application);
   SauveEtatFiche(EtatFiche,PlanCpt_PM);
   PlanCpt_PM.EnDemandeCreation:=true;
   DMPlan.EnDemandeCreation:=true;
   PlanCpt_PM.CompteACreer:=CompteACreer;
   PlanCpt_PM.PaBas.Visible:=false;
   PlanCpt_PM.Height:=(Screen.Height div 4)+20;
   PlanCpt_PM.WindowState:=wsNormal;
   PlanCpt_PM.Position:=poScreenCenter;
   TableSauveEtatFiltre(DMPlan.TaCompte,OldFiltre);
//   FiltrageDataSet(DMPlan.TaPlanCpt,'Compte = ''''');
   //DMPlan.TaPlanCpt.Filter:='Compte = ''''';
   //DMPlan.TaPlanCpt.Filtered:=true;
   PlanCpt_PM.TitreForm:='Plan Comptable';
   PlanCpt_PM.SousTitreForm:=CMethode;
    if PlanCpt_PM.ShowModal = mrOk then
     begin
      result:=true;
     end;
   PlanCpt_PM.PaBas.Visible:=true;
   RestaureEtatFiche(EtatFiche,PlanCpt_PM);
   TableRestoreEtatFiltre(DMPlan.TaCompte,OldFiltre);
   DMPlan.EnDemandeCreation:=false;
except;
  PlanCpt_PM.PaBas.Visible:=true;
  PlanCpt_PM.EnDemandeCreation:=false;
  RestaureEtatFiche(EtatFiche,PlanCpt_PM);
  TableRestoreEtatFiltre(DMPlan.TaCompte,OldFiltre);
  DMPlan.EnDemandeCreation:=false;

end;
//
End;

procedure TPlanCpt_PM.MouseMoveMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.message = WM_NCMOUSEMOVE  then
  begin
//   if PaMessage.Visible then PaMessage.Visible:=false;
//   application.OnMessage:=nil;
end;
end;

procedure TPlanCpt_PM.AideEnLigne(Sender: TObject);
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
// initialisation � la cr�ation de la fen�tre
//****************************************************************************//
procedure TPlanCpt_PM.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin
if DMPlan = nil then DMPlan:=TDMPlan.Create(application.MainForm);
//RxSBImport.Visible := ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));

EnDemandeCreation:=false;
OuvreTables('',[DMPlan.TaPlanCpt]);
//CreationForm(TDMPlan,DMPlan);
case e.TypeDossier of
  VerAgricole:begin
               DBGrid1.ReadOnly:=false;
              end;
  VerDiocese:begin
               DBGrid1.ReadOnly:=false;
              end;
end;


  	Registre:= TRegistry.Create;

   try
	   with Registre do begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, False);

         Try
            BtnClasse1.down:=ReadBool('C1');
            BtnClasse2.down:=ReadBool('C2');
            BtnClasse3.down:=ReadBool('C3');
            BtnClasse4.down:=ReadBool('C4');
            BtnClasse5.down:=ReadBool('C5');
            BtnClasse6.down:=ReadBool('C6');
            BtnClasse7.down:=ReadBool('C7');
            BtnClasse8.down:=ReadBool('C8');
            BtnClasse9.down:=ReadBool('C9');

         Except
            BtnClasse1.down:=true;
            BtnClasse2.down:=true;
            BtnClasse3.down:=true;
            BtnClasse4.down:=true;
            BtnClasse5.down:=true;
            BtnClasse6.down:=true;
            BtnClasse7.down:=true;
            BtnClasse8.down:=true;
            BtnClasse9.down:=true;
         	{}
         End;
      end;
   finally
		Registre.Free;
   end;
     ChaineRecherche := '';
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
//        Position:=poDesigned;
//	Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
        InitialiseFormPosDefaut(self);
        ScreenAjuste_OldDef_DefinitionCourant(ParamUtil.OldScreenWidth,ParamUtil.OldScreenHeight,self);
    end;
     DBGrid1.DataSource:=DMPlan.DaPlanCpt;
     DBGrid1.FSauteColReadOnly:=true;
     Btnclasse9.click;
//ConstruitPopMenu(self.PopupMenu.Items.Count,'Modifier Const Pos',self.PopupMenu.Items,self,DMConst.BtnMAJPosConstClick);
end;


//****************************************************************************//
// Fermeture de la fen�tre
//****************************************************************************//
procedure TPlanCpt_PM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//If DMPlan.DaPlanCpt.State in [dsEdit,dsInsert] Then
//   begin
//   if Messagedlg(PChar('Voulez-vous enregistrer les modifications en cours ?'),mtconfirmation, [mbno,mbyes],0) = mrYes then
//    begin
//      DMPlan.TaplanCpt.Post;
//      DMPlan.TaplanCpt.FlushBuffers;
//    end
//      else
//      DMPlan.TaplanCpt.Cancel;
//   end;
end;

//****************************************************************************//
// Initialisations lors de l'activation de la fen�tre
//****************************************************************************//
procedure TPlanCpt_PM.FormActivate(Sender: TObject);
begin
//ShellExecute(Handle, 'open', 'C:\Philippe\AppliOne\fenetrederoule.html', nil, nil, SW_SHOWNORMAL);
//C|/Philippe/AppliOne/fenetrederoule.html
//application.OnMessage:=MouseMoveMessage;
//screen.OnActiveControlChange:=AideEnLigne;
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;
DBGrid1.ParamColor:=true;
DBGrid1.Param:=ParamUtil.CouleurDBGrid;
DBGrid1.UpDateColor;

  if not DMPlan.TaPlanCpt.Active then DMPlan.TaPlanCpt.Open;
//  DMPlanInitListeCompteJournaux;
initialiseTableEvent;
DBGrid1.AllowAutoAppend:=true;
if EnDemandeCreation then
 begin
    DBGrid1.AllowAutoAppend:=false;
    DMPlan.TaPlanCpt.Insert;
    DMPlan.TaPlanCpt.FindField('Compte').AsString:=CompteACreer;
    DMPlan.InitialiseInsertionCompte(CompteACreer,DMPlan.TaPlanCpt);
 end;

case DMPlan.DaPlanCpt.State of
   dsBrowse:begin
              DMPlan.TaPlanCpt.AfterScroll(DMPlan.TaPlanCpt);
              DMPlan.DaPlanCpt.OnStateChange(DMPlan.DaPlanCpt);
              TableRefresh(DMPlan.TaPlanCpt,'Compte');
            end;
   dsInsert,dsEdit: ;
end;

end;


Procedure TPlanCpt_PM.InitialiseTable_A_Nil;
Begin
if DMPlan<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMPlan.TaPlanCpt,DMPlan.DaPlanCpt]);
End;

Procedure TPlanCpt_PM.initialiseTableEvent;
Begin
  DMPlan.DaPlanCpt.OnUpdateData:=DaPlanCptUpdateData;
  DMPlan.DaPlanCpt.OnStateChange:=DaPlanCptStateChange;
  DMPlan.TaPlanCpt.AfterScroll:=TaPlanCptAfterScroll;
End;
//****************************************************************************//
// Destruction de la Form
//****************************************************************************//
procedure TPlanCpt_PM.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
        InitialiseTable_A_Nil;
//	if self.WindowState = wsnormal then
        Begin
          Registre:= TRegistry.Create;

         try
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;

            OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, True);
            WriteBool('C1',BtnClasse1.down);
            WriteBool('C2',BtnClasse2.down);
            WriteBool('C3',BtnClasse3.down);
            WriteBool('C4',BtnClasse4.down);
            WriteBool('C5',BtnClasse5.down);
            WriteBool('C6',BtnClasse6.down);
            WriteBool('C7',BtnClasse7.down);
            WriteBool('C8',BtnClasse8.down);
            WriteBool('C9',BtnClasse9.down);
            CloseKey;
         end;
      finally
         Registre.Free;
      end;
   End;
     LibGestionParamXML.DestroyForm(Self,E.USer);
     PlanCpt_PM:=nil;
end;

//****************************************************************************//
//*****                         Fonctions                                 *****//
//****************************************************************************//
Procedure TPlanCpt_PM.InitBouttonCreationJournaux(DataSet: TDataSet);
begin
BtnJournal.Enabled:=DMplan.CompteAJournal;
Journal1.Enabled:=BtnJournal.Enabled;
//
end;

procedure TPlanCpt_PM.EnabledSButton(Actif:boolean);
var
i:integer;
begin
for i:=1 to 9 do (FindComponent('BtnClasse'+inttostr(i)) as TSpeedButton).Enabled:=Actif;
end;

//****************************************************************************//
// Gere le d�placement horizontal dans la grille
//****************************************************************************//
Procedure TPlanCpt_PM.DeplacementGrille(VersDroite:boolean; var Key: Word);
var
Gauche,droite,i:integer;
begin
//Gauche:=0;
//Droite:=10;
//if VersDroite then
//   begin
//     i:=DBGrid1.SelectedIndex+1;
//     if i > 10 then i:=10;
//     if i<10 then
//     while ((i<Droite) and (DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) =-1))
//         do inc(i);
//     if (DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) <> -1) then
//      i:=DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName);
////   i:=i+1;
//   end
//   else
//   begin
////     if i=0 then i:=i+1;
//     i:=DBGrid1.SelectedIndex;
//     if i>0 then i:=i-1;
//     while ((DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) =-1) and (i>Gauche))
//         do Dec(i);
//     if (DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) <> -1) then
//      i:=DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName);
////   i:=i-1;
//   end;
//DBGrid1.SelectedIndex:=i;
//key:=VK_CANCEL;
end;
//****************************************************************************//
// Fonction qui permet de calculer le Left du StaticText courant
//****************************************************************************//
Function TPlanCpt_PM.CalculLeft (colcourante : integer) : integer;
Var
   i : integer;
Begin
     Result := 2;
     for  i:=0 to (colcourante - 1) do
     begin
          result := Result + DBGrid1.Columns[i].width
     end;
     Result := Result + DBgrid1.Left + 11;
End;

//****************************************************************************//
// Impression du plan
//****************************************************************************//
procedure TPlanCpt_PM.BtnImprimerClick(Sender: TObject);
var
Site:TEditLien;
NomMenuSiteWeb:TFileStream;
ListeCpt:TResultStrList;
ParamAffichCompte:TParamAffichCompte;
i,j:integer;
begin
try
Screen.Cursor := crSQLWait;
    ListeCpt.Liste:=TStringList.Create;
    ListeCpt.result:=true;
    InitialiseParamAffichCompte(ParamAffichCompte);
    ParamAffichCompte.Titre:= 'S�lectionnez les comptes...';
    ParamAffichCompte.Tiers:=false;
    ParamAffichCompte.Dataset:=DBGrid1.DataSource.DataSet;

    j:=1;
    for i:=1 to 9 do
      begin
        if(FindComponent('BtnClasse'+inttostr(i)) as TSpeedButton).Down=false then
             inc(j);
      end;
    setlength(ParamAffichCompte.ListeClasse,j);
    j:=0;
    for i:=1 to 9 do
      begin
        if(FindComponent('BtnClasse'+inttostr(i)) as TSpeedButton).Down=false then
          begin
             inc(j);
             ParamAffichCompte.ListeClasse[j]:=i;
          end;
      end;
    ParamAffichCompte.ListeChamps.Add('compte');
    ParamAffichCompte.ListeChamps.Add('Libelle');
    ParamAffichCompte.ListeChamps.Add('collectif');
    ParamAffichCompte.ListeChamps.Add('pointable');
    ParamAffichCompte.ListeChamps.Add('tvaCode');
    ParamAffichCompte.FiltreNbChiffre := 3;
    ParamAffichCompte.EventButtonAjouterClick:=nil;
    ParamAffichCompte.EventButtonSupprimerClick:=nil;

    listecpt:=ChoixCompteAffich(ParamAffichCompte);
    if ListeCpt.Result then
      EditionPlanCptL(C_EditionSimple,nil,ListeCpt.Liste,NomMenuSiteWeb,Site);
finally
Screen.Cursor := crDefault;
end;

end;

//****************************************************************************//
//*****                      Ev�nement OnEnter                           *****//
//****************************************************************************//
// Permet la gestion du changement de colonne.
procedure TPlanCpt_PM.DBGrid1ColEnter(Sender: TObject);
begin

//self.Caption:=BoolToStr(DBGrid1.Columns[DBGrid1.SelectedIndex].ReadOnly);
case DBGrid1.DataSource.DataSet.State  of
  dsBrowse:Begin
             DBGrid1.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
           End;

  dsEdit:Begin
          case DBGrid1.SelectedIndex of
             0:begin
                messagedlg('Vous ne pouvez pas modifier le num�ro de compte', mtwarning, [mbok],0);
                DBGrid1.SelectedIndex:=1;
               end;
             1..4:begin
                   DBGrid1.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
                  if dbgrid1.InplaceEditor <> nil then
                   if dbgrid1.InplaceEditor.Visible then
                     begin
                       dbgrid1.InplaceEditor.SelLength:=0;
                       dbgrid1.InplaceEditor.SelStart:=0;
//                       dbgrid1.InplaceEditor.SelStart:=length(dbgrid1.InplaceEditor.text);
                     end;
                  end;
             5..10:DBGrid1.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
          end;
         End;
  dsInsert:Begin
          case DBGrid1.SelectedIndex of
             0..4:begin
                   DBGrid1.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
//                  if dbgrid1.InplaceEditor <> nil then
//                   if dbgrid1.InplaceEditor.Visible then
//                     begin
//                       dbgrid1.InplaceEditor.SelLength:=0;
//                       dbgrid1.InplaceEditor.SelStart:=0;
////                       dbgrid1.InplaceEditor.SelStart:=length(dbgrid1.InplaceEditor.text);
//                     end;
                  end;
             5..10:DBGrid1.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
          end;
         End;
end;
//if DBGrid1.SelectedField.DataType <> ftBoolean then
//DBGrid1.Options:=DBGrid1.Options+[dgAlwaysShowEditor]
//else DBGrid1.Options:=DBGrid1.Options-[dgAlwaysShowEditor];


//  If DMPlan.DaPlanCpt.State in [dsEdit] Then
//     if DBGrid1.SelectedIndex = 0 then
//     begin
//      messagedlg('Vous ne pouvez pas modifier le num�ro de compte', mtwarning, [mbok],0);
//      DBGrid1.SelectedIndex:=1;
//     end;
end;

//****************************************************************************//
//*****                      Ev�nement OnChange                          *****//
//****************************************************************************//
// Permet de s�lectionner dans la DBGrid le compte saise par l'utilisateur.
//****************************************************************************//
procedure TPlanCpt_PM.EdCompteChange(Sender: TObject);
var
   cpte: string;
begin
     cpte := copy(edcompte.text,1,1);
     if cpte<>'' then
     if strtoint_lgr(cpte) in [1..9] then
       if ((cpte=(FindComponent('BtnClasse'+cpte) as TSpeedButton).Caption) and ((FindComponent('BtnClasse'+cpte) as TSpeedButton).Down=false)) then
       (FindComponent('BtnClasse'+cpte) as TSpeedButton).Down:=true;
     Btnclasse9.click;
//     DMPlan.TaPlanCpt.Locate('Compte',edcompte.text,[loPartialKey]);
     DMPlan.TaPlanCpt.FindNearest([edcompte.text]);
     DMPlan.TaPlanCpt.AfterScroll(DMPlan.TaPlanCpt);
     If EdCompte.Text = '' Then ChaineRecherche := '';

end;

//****************************************************************************//
// Permet d'afficher dans le titre de la fen�tre l'�tat du composant table
//****************************************************************************//
procedure TPlanCpt_PM.DaPlanCptUpdateData(Sender: TObject);
begin
if EnDemandeCreation then
 DemandeCreationPoste:=true;
//
end;

procedure TPlanCpt_PM.DaPlanCptStateChange(Sender: TObject);
var
  Title: string;
 CptTmp:string;
 i:integer;
begin
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMPlan.daPlanCpt.DataSet)+NBRecord_Str(DMPlan.daPlanCpt.DataSet);
  CptTmp:=DMPlan.daPlanCpt.dataset.Fields[0].AsString;
  DMPlan.CompteAJournal:=false;

     case DMPlan.daPlanCpt.State of
          dsBrowse: begin
                    if EnDemandeCreation then
                     begin
                       if DemandeCreationPoste then
                        self.ModalResult := MrOk
                        else
                        self.ModalResult := mrCancel;
                       DemandeCreationPoste:=false;
                     end;
                    Title := 'Consultation des Comptes';
                    dbgrid1.SetFocus;
                    EdCompte.Enabled:=true;
                    //Boutons de la form
                    BtnInserer.enabled := true;
                    BtnSupprimer.enabled := true;
                    BtnEnregistrer.enabled := false;
                    BtnModifier.Enabled := True;
                    //PopUp Menu
                    Insrer1.Enabled:=true;
                    Supprimer1.Enabled:=true;
//                    Enregister1.Enabled:=false;
                    Modifier1.Enabled:=true;
                    Visualisation1.Enabled:=true;
                    EnabledSButton(true);
                    dbgrid1.Options :=[dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];

                    dbgrid1.SetFocus;
                    if dbgrid1.InplaceEditor <> nil then
                       dbgrid1.EditorMode:=false;
                    dbgrid1.TitreColor(true);
                    if not EnDemandeCreation then
                    DMPlanInitListeCompteJournaux;

                    end;
          dsEdit: begin
                  Title := 'Modification d''un Compte';
                  EdCompte.OnChange:=nil;
                  EdCompte.text:='';
                  EdCompte.OnChange:=EdCompteChange;
                  EdCompte.Enabled:=false;
                  EnabledSButton(false);
                  Compte := DMPlan.TaPlanCpt.Fields[0].asstring;


                  BtnModifier.Enabled := False;
                  btninserer.enabled := false;
                  btnsupprimer.enabled := false;
                  btnenregistrer.enabled := true;
                  //PopUp Menu
                  Insrer1.Enabled:=False;
                  Supprimer1.Enabled:=False;
//                  Enregister1.Enabled:=True;
                  Modifier1.Enabled:=False;
                  Visualisation1.Enabled:=False;


                  if DBGrid1.SelectedField.DataType = ftBoolean then
                    dbgrid1.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection]
                    else
                    dbgrid1.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
                  dbgrid1.SetFocus;
                  dbgrid1.TitreColor(true);
                  if dbgrid1.InplaceEditor <> nil then
                   if dbgrid1.InplaceEditor.Visible then
                     begin
                       dbgrid1.InplaceEditor.SelLength:=0;
                       dbgrid1.InplaceEditor.SelStart:=length(dbgrid1.InplaceEditor.text);
                     end;

                  DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
                  for i:=1 to DBGrid1.Columns.Count - 1 do
                      begin
                       DBGrid1.Columns[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) = - 1);
                      end;
                  DBGrid1.Columns[DBGrid1.Columns.Count - 1].ReadOnly:=DMPlan.PossedeEcriture(CptTmp);
                  DMPlan.CompteAJournal:=((DMPlan.ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'],nil)));
//                  DMPlan.daPlanCpt.DataSet.FindField('Compte').ReadOnly:=true;
                  end;
          dsInsert: begin
                    Title := 'Insertion d''un Compte';
                    EdCompte.Enabled:=false;
                    btnsupprimer.enabled := false;
                    btninserer.enabled := false;
                    btnenregistrer.enabled := true;
                    BtnModifier.Enabled := False;
                    //PopUp Menu
                    Insrer1.Enabled:=False;
                    Supprimer1.Enabled:=False;
//                    Enregister1.Enabled:=true;
                    Modifier1.Enabled:=False;
                    Visualisation1.Enabled:=False;

                  if DBGrid1.SelectedField.DataType = ftBoolean then
                    dbgrid1.Options := [dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection]
                    else
                    dbgrid1.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
                    dbgrid1.SetFocus;
                    dbgrid1.TitreColor(true);

//                    if not empty(CptTmp) then
                    begin
                      DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
                      for i:=1 to DBGrid1.Columns.Count - 1 do
                          begin
                           DBGrid1.Columns[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) = - 1);
                          end;
                     DMPlan.CompteAJournal:=((DMPlan.ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'],nil)));
                    end;
     end
     else
          Title := '';
     end; //Fin du Case
//     Caption := '- Gestion du plan Comptable - ' + Title;
end;

//****************************************************************************//
//*****                      Ev�nement OnExit                            *****//
//****************************************************************************//
// Permet de vider la zone de saisie du compte.
procedure TPlanCpt_PM.EdCompteExit(Sender: TObject);
begin
   EdCompte.OnChange:=nil;
   EdCompte.text := '';
   ChaineRecherche := '';
   EdCompte.OnChange:=EdCompteChange;
end;

//****************************************************************************//
// Permet de contr�ler la saisie de l'utilisateur dans les diff�rents champs de
// la grille.
//****************************************************************************//
procedure TPlanCpt_PM.DBGrid1ColExit(Sender: TObject);
var
RetCre:TErreurSaisie;
//Infosplancpt:TInfosplancpt;
begin
DBGrid1.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs,dgAlwaysShowSelection];
//DBGrid1.Options:=DBGrid1.Options-[dgAlwaysShowEditor];
if DMPlan.daPlanCpt.State in [dsInsert] then
begin
 retCre:=DMPlan.CreationCpt(DBGrid1.SelectedField);
 if ((retCre.Retour) and (DBGrid1.SelectedIndex=0)) then
    begin
       if DMPlan.DernierNumCptValideEnInsert <> DBGrid1.SelectedField.AsString then
        begin
          DMPlan.InitialiseInsertionCompte(DBGrid1.SelectedField.AsString,DBGrid1.DataSource.DataSet);
        end;
       DMPlan.DernierNumCptValideEnInsert:=DBGrid1.SelectedField.AsString;
       BtnJournal.Enabled:=DMplan.CompteValideDansParamContexte(DBGrid1.SelectedField.AsString,false,['Rac1'],nil);
       Journal1.Enabled:=BtnJournal.Enabled;
    end;
 if not retCre.Retour then
 begin
  BtnJournal.Enabled:=DMplan.CompteAJournal;
  Journal1.Enabled:=BtnJournal.Enabled;
   case retCre.CodeErreur of
      2000     :abort;
      1000,1001:begin
                 DBGrid1.SelectedIndex:=0;
                 abort;
                end;
      1002     :DMPlan.TaPlanCpt.Cancel;
      4001,4002     :begin
                 DBGrid1.EditorMode:=true;
                 if not AideTvaAffiche(DBGrid1.Fields[4],DBGrid1.Fields[0].AsString)
                 then abort;
                end;
   end;
 end;
end;

if DMPlan.DaPlanCpt.State in [dsEdit] then
begin
 retCre:=DMPlan.ModificationCpt(DBGrid1.SelectedField);
 if not retCre.Retour then
  begin
   case retCre.CodeErreur of
      1000:begin
                 DBGrid1.SelectedIndex:=1;
                 abort;
                end;
      4001,4002     :begin
                 DBGrid1.EditorMode:=true;
                 if not AideTvaAffiche(DBGrid1,DMPlan.DaPlanCpt.dataset.findfield('compte').AsString) then
                 abort;
                end;
   end;
  end;
end;
end;

//****************************************************************************//
//*****                      Ev�nement OnClick                           *****//
//****************************************************************************//
// Gestion des classes des comptes avec le clavier.
procedure TPlanCpt_PM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//if PaMessage.Visible then PaMessage.Visible:=false;
WinSuivPrec(Handle,key,[dbgrid1,dbgrid1.InplaceEditor]);
     If (key = VK_ESCAPE) then
     Begin
          if ActiveControl <> dbgrid1 then
            dbgrid1.SetFocus
            else
          if (not(DMPlan.DaPlanCpt.State in [dsEdit,dsInsert])) Then
          begin
             if (ChaineRecherche <> '') then
             begin
               EdCompte.OnChange:=nil;
               EdCompte.Text := '';
               ChaineRecherche := '';
               EdCompte.OnChange:=EdCompteChange;
               dbgrid1.selectedindex := 0;
               dbgrid1.setfocus;
             end
             else
             if not dbgrid1.DataSource.DataSet.BOF then
               begin
                dbgrid1.DataSource.DataSet.First;
               end
             else
             If ((ChaineRecherche = '') and dbgrid1.DataSource.DataSet.BOF) Then
             Begin
                  Self.Close
             End;
          end;
     End;

     if Shift = [ssCtrl] then
     begin
      if key in [97..105] then
         begin
          (FindComponent('BtnClasse'+inttostr(key-96)) as TSpeedButton).Down:=not (FindComponent('BtnClasse'+inttostr(key-96)) as TSpeedButton).Down;
          (FindComponent('BtnClasse'+inttostr(key-96)) as TSpeedButton).Click;
         end;
     end;
    if not empty(EdCompte.Text) then
     if key in [VK_DOWN,VK_RIGHT,VK_LEFT,VK_UP,VK_END,VK_HOME,VK_PRIOR,VK_NEXT] Then
     Begin
        EdCompte.OnChange:=nil;
        EdCompte.Text := '';
        ChaineRecherche := '';
        EdCompte.OnChange:=EdCompteChange;
     End;
end;

//****************************************************************************//
// Permet de se positionner sur le compte � atteindre lors de l'appui sur la touche
// Enter (Qd le Focus est positionn� ds EdCompte);
//****************************************************************************//
procedure TPlanCpt_PM.EdCompteKeyPress(Sender: TObject; var Key: Char);
begin
     if key = #13 then
     begin
      EdCompteExit(EdCompte);
     end;
if not (key in [#8,#48..#57]) then key:=#0;
end;

//****************************************************************************//
// Permet de se placer en modification sur le compte courant
//****************************************************************************//
procedure TPlanCpt_PM.BtnModifierClick(Sender: TObject);
begin
      if dbgrid1.SelectedIndex = 0 then dbgrid1.SelectedIndex:=1;
      dbgrid1.SetFocus;
     DMPlan.TaPlanCpt.Edit;
     DBGrid1ColEnter(DBGrid1);
end;

//****************************************************************************//
// Permet d'enregistrer les modifications d'un compte ou la cr�ation d'un compte
//****************************************************************************//
procedure TPlanCpt_PM.BtnEnregistrerClick(Sender: TObject);
begin
if DMPlan.TaPlanCpt.State in [dsEdit,dsInsert] then
 begin
   TableGerePost(DMPlan.TaPlanCpt);
   DMPlan.taplancpt.Next;
 end
 else
 self.close;
end;


//****************************************************************************//
// Permet de supprimer le compte s�lectionn� par l'utilisateur dans la DBGrid //
//****************************************************************************//
procedure TPlanCpt_PM.BtnSupprimerClick(Sender: TObject);
var
cptTmp:String;
begin
  cptTmp:=DMPlan.TaPlanCpt.FindField('Compte').AsString;
  TableGereDelete(DMPlan.TaPlanCpt);
  DMPlan.TaPlanCpt.Locate('Compte',CptTmp,[loPartialKey]);
  dbgrid1.SelectedIndex := 0;
  dbgrid1.SetFocus;
  Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMPlan.daPlanCpt.DataSet)+NBRecord_Str(DMPlan.daPlanCpt.DataSet);
end;


//****************************************************************************//
// Permet d'ins�rer un nouveau compte
//****************************************************************************//
procedure TPlanCpt_PM.BtnInsererClick(Sender: TObject);
begin
  dbgrid1.SelectedIndex:=0;
  dbgrid1.SetFocus;
  cpt:=DMPlan.TaPlanCpt.findfield('Compte').AsString;
  DMPlan.TaPlanCpt.Insert;
end;


//****************************************************************************//
// Permet d'afficher dans la DBGrid les comptes s�lectionn�s par l'utilisateur.
//****************************************************************************//
procedure TPlanCpt_PM.BtnClasse1Click(Sender: TObject);
var
V:array[1..9] of string[2];
i:integer;
begin
Screen.Cursor := crSQLWait;
 for i:=1 to 9 do V[i]:=inttostr(ord((FindComponent('BtnClasse'+inttostr(i)) as TSpeedButton).Down)*i)+'*';

  DMPlan.TaPlanCpt.Filtered := false;
  DMPlan.TaPlanCpt.Filter :=CreeFiltreOU('Compte',[v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9]]);
  DMPlan.TaPlanCpt.Filtered := True;
Screen.Cursor := crDefault;
end;


//****************************************************************************//
// Permet de quitter la fen�tre ''Gestion du plan Comptable'' et fermer la table TaPlanCpt.
//****************************************************************************//
procedure TPlanCpt_PM.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;

//****************************************************************************//
// Gestion des touches dans la DBGrid
//****************************************************************************//
procedure TPlanCpt_PM.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case DMPlan.DaPlanCpt.state of
   dsBrowse:case key of
            VK_UP,VK_PRIOR:if DMPlan.TaPlanCpt.BOF then
                   begin
                   DMPlan.TaPlanCpt.last;
                   key:=VK_CANCEL;
                   end;
            VK_DOWN,VK_NEXT:if DMPlan.TaPlanCpt.EOF then
                   begin
                    DMPlan.TaPlanCpt.first;
                    key:=VK_CANCEL;
                   end;
            VK_LEFT:begin
                     if DBGrid1.EditorMode = true then
                        begin
                         if DBGrid1.InplaceEditor.SelLength = 0 then
                            if DBGrid1.InplaceEditor.SelStart = 0 then
                                  DeplacementGrille(false,Key);
                        end
                        else DeplacementGrille(false,Key);
                    end;
            VK_RIGHT:begin
                     if DBGrid1.EditorMode = true then
                        begin
                         if DBGrid1.InplaceEditor.SelLength = 0 then
                            if DBGrid1.InplaceEditor.SelStart = length(DBGrid1.InplaceEditor.Text) then
                                  DeplacementGrille(true,Key);
                        end
                        else DeplacementGrille(true,Key);
                    end;
            end;

   dsEdit:case Key of
            VK_UP,VK_PRIOR:if DMPlan.TaPlanCpt.BOF then
                   begin
                   key:=0;
                   end;
            VK_ESCAPE:If Messagedlg('Voulez-vous annuler la modification de ce compte ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                        DMPlan.TaPlanCpt.Cancel
                        else
                        key:=0;
//            VK_F2:if DBGrid1.EditorMode then DBGrid1.InplaceEditor.Deselect;
          end;

   dsInsert:case Key of
            VK_ESCAPE:If Messagedlg('Voulez-vous annuler la cr�ation de ce compte ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                        DMPlan.TaPlanCpt.Cancel
                        else
                        begin
                        key:=0;
//                        abort;
                        end;
          end;
end;
if DMPlan.DaPlanCpt.State in [dsBrowse] then
if ((key=VK_INSERT) and (Shift=[ssCtrl])) then BtnInserer.Click;
if ((key=VK_INSERT) and (Shift=[])) then key:=0;

end;


//****************************************************************************//
//  Permet de se d�placer ds la grille lorsque l'utilisateur tape un num�ro de compte
//****************************************************************************//
procedure TPlanCpt_PM.FormKeyPress(Sender: TObject; var Key: Char);
begin
//if PaMessage.Visible then PaMessage.Visible:=false;
  If ((ActiveControl = DBGrid1) and (Not(DMPlan.DaPlanCpt.State In [dsInsert,dsEdit]))) Then
  Begin
       If (Key in ['0'..'9']) Then
       Begin
            ChaineRecherche := (ChaineRecherche + Key);
            EdCompte.Text := ChaineRecherche;
            Key := #0;
       End
       Else
       Begin
           If (Key = #08) Then
           Begin
//                EdCompte.Perform
//                KeyPress(EdCompte,Key);
                Delete(ChaineRecherche,Length(ChaineRecherche),1);
//                ChaineRecherche := Copy(ChaineRecherche,1,Length(ChaineRecherche));
            Key := #0;
                EdCompte.Text := ChaineRecherche;
           end;
       end;
  End;
end;

//****************************************************************************//
// Permet l'affichage du menu
//****************************************************************************//
procedure TPlanCpt_PM.Menu2Click(Sender: TObject);
begin
    PopupMenu1.Popup(Left + 50, Top + 50);
end;


//****************************************************************************//
//      Appel de la visualisation de la pi�ce                                 //
//****************************************************************************//
procedure TPlanCpt_PM.Voircritures1Click(Sender: TObject);
begin
DetailEcritureCompte(DMPlan.TaPlanCpt.FindField('Compte').AsString,true,true);
end;

//****************************************************************************//
procedure TPlanCpt_PM.FormDeactivate(Sender: TObject);
begin
DMPlan.DaPlanCpt.OnStateChange:=nil;
end;

//****************************************************************************//
procedure TPlanCpt_PM.BtnJournalClick(Sender: TObject);
begin
   if (CreationJournal = nil) then CreationJournal:=TCreationJournal.Create(self);
   CreationJournal.show;
end;

procedure TPlanCpt_PM.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TPlanCpt_PM.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TPlanCpt_PM.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TPlanCpt_PM.TaPlanCptAfterScroll(DataSet: TDataSet);
var
i:integer;
CptTmp:string;
begin
CptTmp:=DataSet.Fields[0].AsString;
DMPlan.CompteAJournal:=false;
case Dataset.State
 of
   dsBrowse:begin
             DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
             for i:=1 to DBGrid1.Columns.Count - 1 do
                 begin
                  DBGrid1.Columns[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) = - 1);
                 end;
            DBGrid1.Columns[DBGrid1.Columns.Count - 1].ReadOnly:=DMPlan.PossedeEcriture(CptTmp);
            DMPlan.CompteAJournal:=((DMPlan.ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'],nil)));
            BtnJournal.Enabled:=DMplan.CompteAJournal;
            Journal1.Enabled:=BtnJournal.Enabled;
            DataSet.FindField('Compte').ReadOnly:=true;

            end;

   dsEdit:begin
            DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
            for i:=1 to DBGrid1.Columns.Count - 1 do
                begin
                 DBGrid1.Columns[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) = - 1);
                end;
            DBGrid1.Columns[DBGrid1.Columns.Count - 1].ReadOnly:=DMPlan.PossedeEcriture(CptTmp);
            DMPlan.CompteAJournal:=((DMPlan.ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'],nil)));
            BtnJournal.Enabled:=DMplan.CompteAJournal;
            Journal1.Enabled:=BtnJournal.Enabled;
            DataSet.FindField('Compte').ReadOnly:=true;
            end;
   dsInsert:begin
            DataSet.FindField('Compte').ReadOnly:=False;
            if not empty(CptTmp) then
            begin
              DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
              for i:=1 to DBGrid1.Columns.Count - 1 do
                  begin
                   DBGrid1.Columns[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(DBGrid1.Columns[i].FieldName) = - 1);
                  end;
            DBGrid1.Columns[DBGrid1.Columns.Count - 1].ReadOnly:=DMPlan.PossedeEcritureSurPeriode(CptTmp,false);
//            DBGrid1.Columns[DBGrid1.Columns.Count - 1].ReadOnly:=DMPlan.PossedeEcriture(CptTmp);
            DMPlan.CompteAJournal:=((DMPlan.ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'],nil)));
            BtnJournal.Enabled:=DMplan.CompteAJournal;
            Journal1.Enabled:=BtnJournal.Enabled;
             end else
             InitChampAfterInsert([nil,nil,nil,nil,nil,nil,nil,nil,False,nil,nil,False,false,false,false,false,false,false,false,false,false,false,E.User,now,0,'',false,0,nil],Dataset);
            end;
 end;
end;


procedure TPlanCpt_PM.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(DBGrid1,22,[2,6,1,1,2,2,2,1,1,1,1]);
  try
    WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
  except

  end;
end;

procedure TPlanCpt_PM.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer,BtnJournal],PaBtn,90,0);
end;

procedure TPlanCpt_PM.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBGrid1 Then
  begin
   case DBGrid1.DataSource.State of
      dsbrowse:begin
                 Rechercher(DBGrid1,DMPlan.TaPlanCpt,
                               ['Libelle','Compte','TvaCode','Taux','Pointable','Collectif','Immobilisation'],
                               ['Libell�','Compte','Code TVA','Taux','Pointable','Collectif','Immobilisation'],'',0);
//                   case DBGrid1.SelectedIndex of
//                        0:Rechercher(DBGrid1,DMProvisions.TaProvision,['Designation','DateSaisie','ID','Compte'],['D�signation','','',''],'',0);
//                    end;
//                  2:case DBProv.SelectedIndex of
//                      0:Rechercher(DBGrid1,DMProvisions.TaProvision,['Reference','Designation','ID','DateSaisie','Compte'],['R�ference','D�signation','','',''],'',0);
//                      1:Rechercher(DBGrid1,DMProvisions.TaProvision,['Designation','Reference','DateSaisie','ID','Compte'],['D�signation','R�ference','','',''],'',0);
//                    end;
               end;
   dsInsert:case DBGrid1.SelectedIndex of
             0:begin
                if PlanOrgCompte(cpt) then
                         DMPlan.TaPlanCpt.findField('Compte').asstring := cpt;
               end;
               4:AideTvaAffiche(DBGrid1.Fields[4],DBGrid1.Fields[0].AsString);
            end;
      dsedit:begin
             case DBGrid1.SelectedIndex of
               4:AideTvaAffiche(DBGrid1.Fields[4],DBGrid1.Fields[0].AsString);
             end;
//                  2:case DBProv.SelectedIndex of
//                      0:Rechercher(DBGrid1,DMProvisions.TaProvision,['Reference','Designation','ID','DateSaisie','Compte'],['R�ference','D�signation','','',''],'',0);
//                      1:Rechercher(DBGrid1,DMProvisions.TaProvision,['Designation','Reference','DateSaisie','ID','Compte'],['D�signation','R�ference','','',''],'',0);
//                    end;
               end;
  end;
 end;

end;

procedure TPlanCpt_PM.FormShow(Sender: TObject);
begin
PaTitre.Visible:=Main.AfficheTitre;
end;

procedure TPlanCpt_PM.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if DMPlan <> nil then
 begin
  // Si l'utilisateur est en mode Insertion
     If DMPlan.TaPlanCpt.State = dsInsert Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If BtnEnregistrer.Enabled Then
          Begin
               If Messagedlg('Voulez-vous enregistrer ce nouveau compte ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                 begin
//                   self.BringToFront;

                   TableGerePost(DMPlan.TaPlanCpt);
                   canclose:=true;
                  end
                  else
                   begin
//                   DMStock.TaStock.BeforeCancel:=nil;
                   DMPlan.TaPlanCpt.Cancel;
//                   DMStock.TaStock.BeforeCancel:=DMStock.TaStockBeforeCancel;
                   canclose:=true;
                   end;
          End
          Else
          Begin
               If Messagedlg('Voulez-vous annuler la cr�ation de ce compte ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
//                   DMStock.TaStock.BeforeCancel:=nil;
                   DMPlan.TaPlanCpt.Cancel;
//                   DMStock.TaStock.BeforeCancel:=DMStock.TaStockBeforeCancel;
                  canclose:=true;
                end
               Else
                 begin
                  canclose:=false;
//                  self.BringToFront;
                  end;
          End;
     End; // Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DMPlan.TaPlanCpt.State = dsEdit Then
     Begin
       self.WindowState:=wsNormal;
       self.BringToFront;
          If Messagedlg('Voulez-vous enregistrer les modifications de ce compte ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
           begin
            TableGerePost(DMPlan.TaPlanCpt);
            canclose:=true;
             end
             else
             begin
//              DMStock.TaStock.BeforeCancel:=nil;
              DMPlan.TaPlanCpt.Cancel;
              canclose:=true;
//              DMStock.TaStock.BeforeCancel:=DMStock.TaStockBeforeCancel;
             end;
     End; // Fin utilisateur est en mode Modification
end;
if CanClose then
 begin
  InitialiseTable_A_Nil;{ isa  le  29/01/04 }
  EnDemandeCreation:=false;
  end;

//CanClose:=true;
end;

procedure TPlanCpt_PM.RxCheckListBox1ClickCheck(Sender: TObject);
begin
Screen.Cursor := crSQLWait;
  IndexPredicat:=strtoint_lgr(CalculIndexPredicat);
  DMPlan.TaPlanCpt.OnFilterRecord:=TaPlanCptFilterRecord;
Screen.Cursor := crDefault;
end;

procedure TPlanCpt_PM.TaPlanCptFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if not((csDestroying)in dataset.ComponentState) then
  Accept:=DMPlan.TaPlanCptPredicat(DataSet,IndexPredicat);
end;

Function TPlanCpt_PM.CalculIndexPredicat:string;
var
i:integer;
Begin
result:='';
for i:=0 to RxCheckListBox1.Items.Count-1 do
     Begin
      if RxCheckListBox1.Checked[i] then
       result:=result + Inttostr(i+1);
     End;
if empty(result) then result:='0';
End;

procedure TPlanCpt_PM.RxSBOUClick(Sender: TObject);
//var
//i:integer;
begin
if RxSBOU.Down then
 begin
  RxCheckListBox1.CheckKind:=ckRadioButtons;
//  for i:=0 to RxCheckListBox1.Items.Count-1 do
//  RxCheckListBox1.Checked[i]:=false;
  RxCheckListBox1ClickCheck(RxCheckListBox1);
 end;
end;

procedure TPlanCpt_PM.RxSBETClick(Sender: TObject);
var
i:integer;
begin
if RxSBET.Down then
 begin
  RxCheckListBox1.CheckKind:=ckCheckBoxes;
  for i:=0 to RxCheckListBox1.Items.Count-1 do
     RxCheckListBox1.Checked[i]:=false;
  RxCheckListBox1ClickCheck(RxCheckListBox1);
 end;
end;

procedure TPlanCpt_PM.RxCheckListBox1Exit(Sender: TObject);
begin
RxCheckListBox1.CheckedIndex:=-1;
end;

procedure TPlanCpt_PM.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(PlanCpt_PMRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TPlanCpt_PM.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
//if ((DBGrid1.Col = 2) and (key='<')) then;
end;

procedure TPlanCpt_PM.Visualisationsurpriode1Click(Sender: TObject);
begin
DetailEcritureCompte(DMPlan.TaPlanCpt.FindField('Compte').AsString,true,true,true);
end;

procedure TPlanCpt_PM.TauxTVApardfaut1Click(Sender: TObject);
var
TAuxDef:String;
InfosZoneSaisie:TInfosZoneSaisie;
RetourZoneSaisie:TRetourZoneSaisie;
begin
if DBGrid1.DataSource.DataSet.State in [dsEdit,dsInsert] then
 Begin
  InfosZoneSaisie.Affich := true;
  InfosZoneSaisie.CaptionForm := 'Infos compl�mentaire TVA';
  InfosZoneSaisie.CaptionLib := 'Taux de tva par d�faut pour le compte : '+RetourChariotSimple+DMPlan.TaPlanCpt.FindField('Compte').AsString+' - '+DMPlan.TaPlanCpt.FindField('Libelle').AsString;
  InfosZoneSaisie.ValeurDefaut := DMPlan.TaPlanCpt.FindField('Taux').AsCurrency;
  InfosZoneSaisie.FormatOnEditing := false;
  InfosZoneSaisie.BloquerBorne := false;
  RetourZoneSaisie:=AffichZoneSaisie(InfosZoneSaisie);
  if RetourZoneSaisie.Retour then
   begin
     DMPlan.TaPlanCpt.FindField('Taux').AsCurrency :=RetourZoneSaisie.MontantSaisieCurr;
   end;
 End;

end;

procedure TPlanCpt_PM.PaBtnClick(Sender: TObject);
//var
//i:integer;
begin
//DMPlan.Tabilan.Open;
//DMPlan.Tabilan.First;
//DMPlan.TaPlanCpte.Open;
//while not DMPlan.Tabilan.EOF do
//begin
// if DMPlan.TaPlanCpte.Locate('Compte',DMPlan.Tabilan.findfield('Compte').AsString,[]) then
//  begin
//   DMPlan.Tabilan.Edit;
//   DMPlan.Tabilan.FindField('Intitule').AsString := DMPlan.TaPlanCpte.findfield('Libelle').AsString;
//   TableGerePost(DMPlan.Tabilan);
//  end;
//  DMPlan.Tabilan.Next;
//end;

end;

procedure TPlanCpt_PM.RxSBPlanCptClick(Sender: TObject);
var
ParamAfficheBalance:TParamAfficheBalance;
begin
BalanceAffiche(ParamAfficheBalance);
end;

procedure TPlanCpt_PM.RxSBPlanSaisieClick(Sender: TObject);
Var
PAramAffichPlanSaisie:TPAramAffichPlanSaisie;
begin
if DMPlan.TaPlanCpt.State in [dsEdit,dsInsert] then
 begin
   TableGerePost(DMPlan.TaPlanCpt);
 end;
PAramAffichPlanSaisie.CompteASelectionner:='';
PAramAffichPlanSaisie.TypeChamp := C_Plan_Update_Plan_Saisie;
PlanSaisieAffiche(PAramAffichPlanSaisie);
end;

procedure TPlanCpt_PM.PlandeSaisie1Click(Sender: TObject);
begin
RxSBPlanSaisie.Click;
end;

procedure TPlanCpt_PM.RxSBTvaDebitClick(Sender: TObject);
Var
PAramAffichPlanSaisie:TPAramAffichPlanSaisie;
begin
if DMPlan.TaPlanCpt.State in [dsEdit,dsInsert] then
 begin
   TableGerePost(DMPlan.TaPlanCpt);
 end;

PAramAffichPlanSaisie.CompteASelectionner:='';
PAramAffichPlanSaisie.TypeChamp := C_Plan_Update_Plan_TvaDebit;
PlanSaisieAffiche(PAramAffichPlanSaisie);
end;

procedure TPlanCpt_PM.Exporter1Click(Sender: TObject);
begin
ExportDonnees(DBGrid1.DataSource.DataSet,E.RepertoireExportDossier,'PlanComptable_'+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TPlanCpt_PM.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.