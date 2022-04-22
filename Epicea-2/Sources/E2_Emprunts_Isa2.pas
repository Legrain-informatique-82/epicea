unit E2_Emprunts_Isa2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Mask, DBCtrls, ExtCtrls,E2_Librairie_obj,
  Gr_Librairie_obj,
  LibSQL,
   DMEmprunt,
   Buttons,
   GrDBGrid,
  LibZoneSaisie,
  Menus,
  DMEcriture,
  LibRessourceString,
  E2_Graphes,
  LibGestionParamXML,
  FM_INIT_COLOR,
  E2_Decl_Records, RXDBCtrl, ExRxDBGrid, RXCtrls, Grids, DBGrids, GrGrid,DMrecherche,DMConstantes,
  jpeg;

type

  TParamAfficheEmprunts = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   end;

  TEmprunt_Isa = class(TT_INIT_COLOR)
    Patitre: TPanel;
    PaGrille: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaBas: TPanel;
    Label1: TLabel;
    ComboCompte: TComboBox;
    DBEmprunt: TGrDBGrid;
    RxSpeedButton1: TRxSpeedButton;
    RxLaMenu: TRxLabel;
    BtnImprimer: TButton;
    BtnAnnuler: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    MenuItem3: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    MenuItem8: TMenuItem;
    Fermer1: TMenuItem;
    Shape2: TShape;
    Shape3: TShape;
    N2: TMenuItem;
    Suivant1: TMenuItem;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    TiShowHint: TTimer;
    RxLabTitre: TRxLabel;
    ImEnTete: TImage;
    RxSpeedButton2: TRxSpeedButton;
    Prcdent1: TMenuItem;
    Panel2: TPanel;
    PaCumul1: TPanel;
    PaTotal: TPanel;
    GrGrid1: TGrGrid;
    Imprimerempruntcourant1: TMenuItem;
    RxMAJ_Balance: TRxSpeedButton;
    Exporter1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AideEnLigne(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure DBEmpruntColExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Aide1Click(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure ComboCompteEnter(Sender: TObject);
    procedure ComboCompteClick(Sender: TObject);
    procedure ComboCompteKeyPress(Sender: TObject; var Key: Char);
    procedure DBEmpruntKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboCompteExit(Sender: TObject);
    procedure ChangementEtatGrille;
    procedure changementEtatBoutons(Sender: TObject);
    procedure EnregistrementAutomatique;
    procedure FormActivate(Sender: TObject);
    procedure RemplissageComboCompte;
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure PatitreResize(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure DBEmpruntMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Visualisation1Click(Sender: TObject);
    procedure RxSBInfoVersionClick(Sender: TObject);
    procedure RxSBGrapheClick(Sender: TObject);
    procedure TiShowHintTimer(Sender: TObject);
    procedure RxSBInfoVersionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RxSBInfoVersionMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RxSpeedButton2Click(Sender: TObject);
    Procedure PositionTotaux;
//    procedure DBEmpruntDrawColumnCell(Sender: TObject; const Rect: TRect;
//      DataCol: Integer; Column: TColumn; State: TGridDrawState);
//    procedure DBEmpruntShowEditor(Sender: TObject; Field: TField;
//      var AllowEdit: Boolean);
//    procedure DBEmpruntEnter(Sender: TObject);
    Procedure GestionInitDM;
    Procedure GereAccesEcran;
    procedure Imprimerempruntcourant1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure RxMAJ_BalanceClick(Sender: TObject);
    procedure RxMAJ_BalanceMouseEnter(Sender: TObject);
    procedure RxMAJ_BalanceMouseLeave(Sender: TObject);
    procedure RxMAJ_BalanceMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormDeactivate(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
  end;

var

  Emprunt_Isa: TEmprunt_Isa;
  Mark : TBookMark;
  Selection : String;
  CpteTmp: String;
  LastSize:integer;

  Aide : THintWindow;
  C:TPoint;
  rec:TRect;
  IndexShowHint:Integer;
  TabShowHint:array[0..10] of TControl;
  FlagEmpruntCourant:boolean;
  
      Function EmpruntsAffiche(ParamAfficheEmprunts:TParamAfficheEmprunts):Boolean;

implementation

Uses E2_AideCompte, E2_AideAssist,
  E2_Main, E2_Recherche, DMAide,
  //UQReport,
  LibClassObjetSenders,DMCorrection,DMExports, ImportDll;

{$R *.DFM}


Function EmpruntsAffiche(ParamAfficheEmprunts:TParamAfficheEmprunts):Boolean;
var
ParamDMEmprunts:TParamDMEmprunts;
Begin
 if (Emprunt_Isa = nil) then Emprunt_Isa:=TEmprunt_Isa.Create(Application.MainForm);
 if ((ParamAfficheEmprunts.Quand <> Emprunt_Isa.Quand) and (Emprunt_Isa.Visible=true)) then
   Emprunt_Isa.Close;
 Emprunt_Isa.Quand:=ParamAfficheEmprunts.Quand;
 if not empty(ParamAfficheEmprunts.TitreForm) then
   Emprunt_Isa.TitreForm:=ParamAfficheEmprunts.TitreForm;
 Emprunt_Isa.SousTitreForm:=ParamAfficheEmprunts.SousTitreForm;

 ParamDMEmprunts.EmpruntsDataStateChange := Emprunt_Isa.changementEtatBoutons;
 ParamDMEmprunts.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMEmprunts.Quand := Emprunt_Isa.Quand;

   case Emprunt_Isa.Quand of
      C_Ouverture:Begin
                   InitialiseDMEmprunts(ParamDMEmprunts);
                  End;
   end;

 if ParamAfficheEmprunts.Affiche then
  begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);
     if ParamAfficheEmprunts.AffichageModal then
       Emprunt_Isa.ShowModal
     else
       Emprunt_Isa.Show;
     Emprunt_Isa.DBEmprunt.DataSource := DMEmprunts.DAEmprunts;
  End;
End;


//****************************************************************************//
// Proc�dure AideEnLigne.                                                     //
//****************************************************************************//
procedure TEmprunt_Isa.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
result:=false;
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except
end;
end;
//****************************************************************************//


//****************************************************************************//
// Initialisation � la cr�ation de la fen�tre.                                //
//****************************************************************************//
procedure TEmprunt_Isa.FormCreate(Sender: TObject);
begin
inherited;
TypeInitForm:=C_MODELE_COLOREPI;
if DMEmprunts = nil then
      DMEmprunts:=TDMEmprunts.Create(application.MainForm);

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
    LastSize:=0;
    Patitre.Color:=$00ADEBFF;
    RxSpeedButton1.Hint:='Saisie des Stocks � l''ouverture.'+HintRaccourciCtrlS;
    RxSBGraphe.Hint:=RxSBGraphe.Hint+HintRaccourciAucun;
    BtnAnnuler.Hint:=BtnAnnuler.Hint+HintRaccourciEsc;
    BtnEnregistrer.Hint:=BtnEnregistrer.Hint+HintRaccourciF3;
    BtnInserer.Hint:=BtnInserer.Hint+HintRaccourciF6;
    BtnModifier.Hint:=BtnModifier.Hint+HintRaccourciF8;
    BtnSupprimer.Hint:=BtnSupprimer.Hint+HintRaccourciF10;
    BtnFermer.Hint:=BtnFermer.Hint+HintRaccourciEsc;
    BtnImprimer.Hint:=BtnImprimer.Hint+HintRaccourciF11;
    IndexShowHint:=1;
//    TabShowHint[0]:=RxSpeedButton2;
    TabShowHint[1]:=RxSpeedButton1;
    TabShowHint[2]:=RxSBGraphe;
    TabShowHint[3]:=DBEmprunt;
    TabShowHint[4]:=BtnAnnuler;
    TabShowHint[5]:=BtnEnregistrer;
    TabShowHint[6]:=BtnInserer;
    TabShowHint[7]:=BtnModifier;
    TabShowHint[8]:=BtnSupprimer;
    TabShowHint[9]:=BtnFermer;
    TabShowHint[10]:=BtnImprimer;
    DBEmprunt.FSauteColReadOnly:=true;

    FlagEmpruntCourant:=false;
// DBEmprunt.MesExitInEdit:='Annuler la modification de cet emprunt ?';
// DBEmprunt.MesExitInInsert:='Annuler la cr�ation de cet emprunt ?'
end;

//****************************************************************************//
// Lib�ration de  m�moire.                                                    //
//****************************************************************************//
Procedure TEmprunt_Isa.InitialiseTable_A_Nil;
Begin
    // DMEmprunts.dAEmprunts.OnStateChange:=nil;
 if DMEmprunts<>nil then
    InitDatasetEvent_A_Nil_Sur_Form([DMEmprunts.dAEmprunts]);
End;

procedure TEmprunt_Isa.FormDestroy(Sender: TObject);
begin
       InitialiseTable_A_Nil;
  	LibGestionParamXML.DestroyForm(Self,E.USer);
   if DMEmprunts <> nil then
     begin
       DMEmprunts.Free;
     end;
        Emprunt_Isa := Nil; 
end;
//****************************************************************************//

//****************************************************************************//
// Initialisation � l'affichage de la fen�tre.                                //
//****************************************************************************//
procedure TEmprunt_Isa.FormShow(Sender: TObject);
begin
    Mark := Nil;
    DBEmprunt.setFocus;
end;
//****************************************************************************//


//****************************************************************************//
// Permet l'affichage du Menu.                                                //
//****************************************************************************//
procedure TEmprunt_Isa.pmMenu1Click(Sender: TObject);
begin
     PopupMenu1.Popup(Left + 50, Top + 50);
end;
//****************************************************************************//

//****************************************************************************//
// Permet d'ins�rer un nouveau Stock.                                         //
//****************************************************************************//
procedure TEmprunt_Isa.BtnInsererClick(Sender: TObject);
begin
TableAjoute(DBEmprunt.DataSource.DataSet);
end;
//****************************************************************************//


//****************************************************************************//
// Permet de quitter la fen�tre des Stocks et fermer la table des stocks.     //
//****************************************************************************//
procedure TEmprunt_Isa.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;
//****************************************************************************//



//****************************************************************************//
// Permet de se placer en modification sur le compte courant.                 //
//****************************************************************************//
procedure TEmprunt_Isa.BtnModifierClick(Sender: TObject);
begin
 DBEmprunt.DataSource.DataSet.Edit;
end;
//****************************************************************************//




//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TEmprunt_Isa.BtnEnregistrerClick(Sender: TObject);
begin
  try
     EnregistrementAutomatique;
  except
  abort;
  end;//fin du try
end;
//****************************************************************************//





//****************************************************************************//
// Permet de contr�ler la saisie de l'utilisateur dans les diff�rentes        //
// colonnes de la grille.                                                     //
//****************************************************************************//
procedure TEmprunt_Isa.DBEmpruntColExit(Sender: TObject);
var
ControlSaisie:TExceptLGR;
begin
if DBEmprunt.DataSource.State in [dsinsert,dsEdit] then
 begin// si table en insertion ou modif
 ControlSaisie:=DMEmprunts.CtrlSaisieEmprunt(DBEmprunt.SelectedField);
   if  ControlSaisie.Retour=false then
    case  ControlSaisie.NumErreur of
   1000,1001:begin
             abort;
             end;
        2000:begin//champ compte vide pas autoris�
             abort;
             end;
        2001:begin //champ pas valide
             abort;
             end;//fin champ compte pas valide
//        4000:MessageSilencieux('Messagerie Epic�a-2','Le capital restant d� est obligatoire !',Main.PaMessageSilencieux,100,400,300,100,self);
   4001,5001:begin
             abort;
             end;
    end;//fin du case
    if DBEmprunt.SelectedIndex=0 then
      begin
        BtnEnregistrer.Enabled:=true;
        Enregister1.Enabled:=true;
      end;
 end;//fin si table en insertion ou modif
end;
//****************************************************************************//




//****************************************************************************//
// Gestion des touches alphanum�riques.                                       //
//****************************************************************************//
procedure TEmprunt_Isa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
FlagEmpruntCourant:=(ssCtrl in Shift);
WinSuivPrec(Handle,key,[DBEmprunt,DBEmprunt.InplaceEditor]);
//MessageSilencieuxEfface(Main.PaMessageSilencieux,self,Main);
     If Key = VK_ESCAPE Then
     Begin
       If DBEmprunt.DataSource.DataSet.State = dsBrowse Then
          begin
            if DBEmprunt.Focused then Self.Close else DBEmprunt.SetFocus;
          end;

      If DBEmprunt.DataSource.DataSet.State = dsInsert Then
          Begin
               If Messagedlg('Annuler la cr�ation de cet emprunt ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               Begin
                    DBEmprunt.DataSource.DataSet.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;

          If DBEmprunt.DataSource.DataSet.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cet emprunt ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                    DBEmprunt.DataSource.DataSet.Cancel;
                    Abort;
               End
               Else
               Begin
                    Abort;
               End
          End;
     End;

end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click dans l'aide.                                              //
//****************************************************************************//
procedure TEmprunt_Isa.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBEmprunt Then
  begin
   case DBEmprunt.DataSource.State of
      dsinsert,dsedit:case DBEmprunt.SelectedIndex of
                         1:begin
                            AideCompte.FiltrageAideCompte(22);
                            DBEmprunt.EditorMode:=true;
                            AideCompte.InitialiseCompte;
                            AideCompteAffiche(DBEmprunt.InplaceEditor,True,False,True,True,0);
                            DBEmprunt.DataSource.DataSet.Fields[2].AsString:=DBEmprunt.InplaceEditor.Text;
                           end;
                         2: ;
                      end;
      dsbrowse:case DBEmprunt.SelectedIndex of
                  0:Rechercher(DBEmprunt,DBEmprunt.DataSource.DataSet,['Code_emp','Compte_emp','Designation_Emp','Actif'],['Code Emprunt','Compte','D�signation',''],'',0);
                  1:Rechercher(DBEmprunt,DBEmprunt.DataSource.DataSet,['Compte_emp','Code_emp','Designation_Emp','Actif'],['Compte','Code Emprunt','D�signation',''],'',0);
                  2:Rechercher(DBEmprunt,DBEmprunt.DataSource.DataSet,['Designation_Emp','Code_emp','Compte_emp','Actif'],['D�signation','Code Emprunt','Compte',''],'',0);
               end;
   end;
 end;

end;
//****************************************************************************//


//****************************************************************************//
// Permet de supprimer le stock s�lectionn� par l'utilisateur.                //
//****************************************************************************//
procedure TEmprunt_Isa.BtnSupprimerClick(Sender: TObject);
begin
   try
    TableGereDelete(DBEmprunt.DataSource.DataSet);
   except
   abort;
   end;
end;
//****************************************************************************//

procedure TEmprunt_Isa.changementEtatBoutons(Sender: TObject);
var
TotauxGeneric:TTotauxGeneric;
begin
  case  DBEmprunt.DataSource.DataSet.state of
   dsBrowse: begin
               BtnInserer.Enabled := True;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := Not( DBEmprunt.DataSource.DataSet.RecordCount = 0);
               BtnSupprimer.Enabled := Not( DBEmprunt.DataSource.DataSet.RecordCount = 0);
               BtnImprimer.Enabled:=true;
               Modifier1.ShortCut:=ShortCut(VK_F2,[]);

               FiltrageDataSet(DMRech.TaEmpruntsRech,DBEmprunt.DataSource.DataSet.Filter);
               TotauxGeneric:=SommeTotauxGeneric(['CapiTotal_Emp','CapiResteDu_Emp'],DMRech.TaEmpruntsRech);
               GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total1);
               GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxGeneric.Total2);
               DeFiltrageDataSet(DMRech.TaEmpruntsRech);

             end;

   dsEdit:   begin
               EnableWinControl([BtnAnnuler,BtnEnregistrer,BtnFermer],True);
               EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               Modifier1.ShortCut:=0;
//               ComboCompte.Enabled := False;
             end;

   dsInsert: begin
               EnableWinControl([BtnAnnuler,BtnFermer],True);
               EnableWinControl([BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
               Modifier1.ShortCut:=0;

//               ComboCompte.Enabled := False;
             end;
   end;//fin du case.state

   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
   ChangementEtatGrille;
end;


procedure TEmprunt_Isa.ChangementEtatGrille;
begin
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DBEmprunt.DataSource.DataSet);
   case  DBEmprunt.DataSource.DataSet.state of
   dsBrowse: begin
               DBEmprunt.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBEmprunt.SetFocus;
               if DBEmprunt.InplaceEditor <> nil then
                  DBEmprunt.EditorMode:=false;
               DBEmprunt.TitreColor(true);
             end;

   dsEdit:   begin
               DBEmprunt.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBEmprunt.SetFocus;
               DBEmprunt.TitreColor(true);
             end;

   dsInsert: begin
               DBEmprunt.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBEmprunt.SetFocus;
               DBEmprunt.TitreColor(true);
             end;
   end;//fin du case.state
end;

procedure TEmprunt_Isa.RemplissageComboCompte;
var
cpt:integer;
i:integer;
Begin
  If ComboCompte.Items.IndexOf(Copy(CpteTmp,1,4)) = -1 Then
  Begin
       ComboCompte.Items.Add(Copy(CpteTmp,1,4));
       ComboCompte.Sorted := True;
       combocompte.Refresh;
       combocompte.ItemIndex:=0;
//       ComboCompteChange(self);
  End;
  for i:=0 to combocompte.items.Count-1 do
       begin
       if combocompte.Items.Strings[i]=Copy(CpteTmp,1,4) then
       combocompte.ItemIndex:=i;
//       ComboCompteChange(self);
       end;
end;


procedure TEmprunt_Isa.EnregistrementAutomatique;
begin
  try
  TableGerePost(DBEmprunt.DataSource.DataSet);
  except
  abort;
  end;//fin du try
end;

//****************************************************************************//
// Gestion de l'entr�e dans la combo des comptes.                             //
//****************************************************************************//
procedure TEmprunt_Isa.ComboCompteEnter(Sender: TObject);
begin
     ComboCompte.Color := clAqua;
     ComboCompte.DroppedDown := True;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click dans la combo des comptes.                                //
//****************************************************************************//
procedure TEmprunt_Isa.ComboCompteClick(Sender: TObject);
begin
     Selection := ComboCompte.Text;
     DBEmprunt.DataSource.DataSet.Filtered := False;
     If Selection = ' < Tous > ' Then
        Begin
        DBEmprunt.DataSource.DataSet.Filter := '';
        End
     Else
        Begin
        DBEmprunt.DataSource.DataSet.Filter := CreeFiltreET(['Compte_Emp'],[Selection+'*']);
        End;
        DBEmprunt.DataSource.DataSet.Filtered := True;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches dans la combo des comptes.                             //
//****************************************************************************//
procedure TEmprunt_Isa.ComboCompteKeyPress(Sender: TObject; var Key: Char);
begin
     If key = #13 then
     Begin
          Key := #0;
          DBEmprunt.SelectedIndex := 0;
          DBEmprunt.SetFocus;
     End;
end;
//****************************************************************************//




//****************************************************************************//
// Gestion des touches dans la grille.                                        //
//****************************************************************************//
procedure TEmprunt_Isa.DBEmpruntKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if DBEmprunt.DataSource.DataSet.State in [dsBrowse] then
if ((key=VK_INSERT) and (Shift=[ssCtrl])) then BtnInserer.Click;
if ((key=VK_INSERT) and (Shift=[])) then key:=0;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la sortie de la combo des comptes.                              //
//****************************************************************************//
procedure TEmprunt_Isa.ComboCompteExit(Sender: TObject);
begin
     ComboCompte.Color := ClWindow;
     DBEmprunt.DataSource.DataSet.Last;
     DBEmprunt.SelectedIndex := 0;
     DBEmprunt.SetFocus;
     DBEmprunt.DataSource.DataSet.First;
end;
//****************************************************************************//




procedure TEmprunt_Isa.FormActivate(Sender: TObject);
begin
  ColorPaTitre:=$00EAFAFF;

  inherited;
initialisationMAJ_Balance(RxMAJ_Balance);
GestionInitDM;
 Initialiser_ShortCut_Main(true);
// Patitre.visible:=Main.AfficheTitre;
 DBEmprunt.ParamColor:=true;
 DBEmprunt.Param:=ParamUtil.CouleurDBGrid;
 DBEmprunt.UpDateColor;
// CouleurFond([PaTools,PaBtn,PaBas],ParamUtil.CouleurPanelCorps);

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.DessineContourLigne:=false;
  GrGrid1.UpDateColor;
  GrGrid1.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

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

case DBEmprunt.DataSource.DataSet.State of
   dsbrowse:begin
             //DBEmprunt.DataSource.OnStateChange:=changementEtatBoutons;
//             DBEmprunt.DataSource.OnStateChange(DBEmprunt.DataSource.DataSet);
             DBEmprunt.SelectedIndex:=0;
             DBEmprunt.SetFocus;
            end;
   dsInsert,dsEdit:begin
            end;
end;
GereAccesEcran;
end;

procedure TEmprunt_Isa.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(DBEmprunt,13,[2,2,4,2,2]);
PositionTotaux;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TEmprunt_Isa.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TEmprunt_Isa.FormResize(Sender: TObject);
begin
if self.Width < 450 then
     if LastSize > self.Width
       then
           begin
          LastSize:=self.Width;
//           self.Width:=450;
           abort;
           end;
LastSize:=self.Width;
end;

procedure TEmprunt_Isa.Image2Click(Sender: TObject);
var
CanCLose:Boolean;
begin
CanClose:=false;
if main.Monofenetrage then FormCloseQuery(self,CanCLose);
if canclose then //self.hide;
begin
self.ModalResult:=mrOk;
Main.Stoks1Click(Main.Stoks1);
end;
end;

procedure TEmprunt_Isa.PatitreResize(Sender: TObject);
begin
//RxSpeedButton1.top:=13;
RxSpeedButton1.Left:=Patitre.Width-105;
//RxSpeedButton1.Height:=Patitre.Height-24;
RxLaMenu.top:=53;
RxLaMenu.left:=Patitre.Width-104;
Patitre.Font.Size:=(Patitre.Width div 40)-1;
end;

procedure TEmprunt_Isa.MenuItem1Click(Sender: TObject);
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

procedure TEmprunt_Isa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try//finally
    try//except
    canclose:=true;
    if DMEmprunts <> nil then
     begin
      // Si l'utilisateur est en mode Insertion
         If DBEmprunt.DataSource.DataSet.State = dsInsert Then
         Begin
            if self.WindowState <> wsNormal then
              self.WindowState:=wsNormal;
            if screen.ActiveForm <> self then
              self.BringToFront;
              If BtnEnregistrer.Enabled Then
              Begin
                   If Messagedlg('Voulez-vous enregistrer le nouvel emprunt ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                     begin
                       EnregistrementAutomatique;
                      end
                      else
                       begin
                       DBEmprunt.DataSource.DataSet.Cancel;
                       end;
              End
              Else
              Begin
                   If Messagedlg('Voulez-vous annuler la cr�ation de cet emprunt ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                    begin
                      DBEmprunt.DataSource.DataSet.Cancel;
                    end
                   Else
                     begin
                      canclose:=false;
                      end;
              End;
         End; // Fin utilisateur est en mode Insertion

         // Si l'utilisateur est en mode Modification
         If DBEmprunt.DataSource.DataSet.State = dsEdit Then
         Begin
            if self.WindowState <> wsNormal then
              self.WindowState:=wsNormal;
            if screen.ActiveForm <> self then
              self.BringToFront;
              If Messagedlg('Voulez-vous enregistrer les modifications de cet emprunt ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
               begin
                EnregistrementAutomatique;
                 end
                 else
                 begin
                  DBEmprunt.DataSource.DataSet.Cancel;
                 end;
         End; // Fin utilisateur est en mode Modification
         CanClose:=DBEmprunt.DataSource.DataSet.State = dsBrowse;
      end;
    except
       CanClose:=false;
    end;
finally
  if CanClose=false then
   begin
     if AideCompte=nil then
       AideCompte:=TAideCompte.Create(self);
   end
 else InitialiseTable_A_Nil;{ isa  le  29/01/04 }
end;//fin du try finally
end;

procedure TEmprunt_Isa.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TEmprunt_Isa.BtnImprimerClick(Sender: TObject);
begin
//MessageDlg(EditionUlterieure, mtInformation, [mbOK], 0);
if FlagEmpruntCourant then
  EditionEmpruntOuvertureL(C_EditionSimple,DMEmprunts.TaEmprunts.findfield('id').asinteger,DMEmprunts.TaEmprunts.findfield('compte_emp').asstring,nil)
else
  EditionEmpruntOuvertureL(C_EditionSimple,0,nil,nil);
FlagEmpruntCourant:=false;
end;

procedure TEmprunt_Isa.DBEmpruntMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
//var
////    Pt: TPoint;
//    Can:TCanvas;
//    Rect:TRect;
//    Colo:TColor;
begin
// A garder
//if ((DBEmprunt.MouseCoord(x,y).X > 0) and (DBEmprunt.MouseCoord(x,y).Y>0)) then
// begin
////cellAttribute(Columns[MouseCoord(Pt.x,Pt.y).X].Field,can,[]);
//REct:=DBEmprunt.CellRect(DBEmprunt.MouseCoord(x,y).X,DBEmprunt.MouseCoord(x,y).Y);
//DBEmprunt.Canvas.brush.color:=clYellow;
////Colo:=DBEmprunt.Canvas.Pixels[rect.Left+1,REct.Top+1];
//DBEmprunt.Canvas.FrameRect(rect);
////FloodFill(rect.Left+1,REct.Top+1,colo,fsSurface);
////Rectangle(rect.Left,REct.Top,Rect.Right,Rect.Bottom);
////GrDBGridExemple.Canvas.TextOut(X,Y,'eeeeeee');
//end;

end;

procedure TEmprunt_Isa.Visualisation1Click(Sender: TObject);
begin
if DBEmprunt.SelectedIndex = 1 then
 begin
  if DBEmprunt.InplaceEditor <> nil then
   begin
      if DBEmprunt.InplaceEditor.Visible then
        DetailEcritureCompte(DBEmprunt.InplaceEditor.Text,true,False)
         else
         DetailEcritureCompte(DBEmprunt.DataSource.DataSet.FindField('Compte_emp').AsString,true,False);
   end
   else
    DetailEcritureCompte(DBEmprunt.DataSource.DataSet.FindField('Compte_emp').AsString,true,False);
 end
 else DetailEcritureCompte(DBEmprunt.DataSource.DataSet.FindField('Compte_emp').AsString,true,False);

end;


procedure TEmprunt_Isa.RxSBInfoVersionClick(Sender: TObject);
begin
Showmessage(Emprunt_IsaRxSBInfoVersionWarning+numVersion.messageVersion);
end;

procedure TEmprunt_Isa.RxSBGrapheClick(Sender: TObject);
begin
AfficheGraphe(DBEmprunt.DataSource.DataSet,'ID','Compte_Emp','CapiResteDu_Emp','Capital Restant D� � l''ouverture');
end;

procedure TEmprunt_Isa.TiShowHintTimer(Sender: TObject);
begin
if aide = nil then
 Aide:=THintWindow.Create(self);
 Aide.Canvas.Brush.Color:=clInfoBk;
 Aide.Color:=clInfoBk;
 C:=TabShowHint[IndexShowHint].ClientOrigin;
 Rec:=Aide.CalcHintRect(length(TabShowHint[IndexShowHint].hint)*5,RxSpeedButton1.hint,@(TabShowHint[IndexShowHint].hint));
 rec.Left:=C.x+20;
 Rec.Top:=C.y+20;
 Rec.Right:=Rec.Right + C.x+20;
 Rec.Bottom:=Rec.Bottom + C.y+20;
 Aide.ActivateHint(Rec,TabShowHint[IndexShowHint].hint);
 inc(IndexShowHint);
 if IndexShowHint > 10 then IndexShowHint:=1;

end;


procedure TEmprunt_Isa.RxSBInfoVersionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if Button = mbLeft then
begin
  TiShowHint.Enabled:=false;
  Aide.ReleaseHandle;
end;

end;

procedure TEmprunt_Isa.RxSBInfoVersionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
TiShowHint.Enabled:=true;
TiShowHintTimer(TiShowHint);
end;

procedure TEmprunt_Isa.RxSpeedButton2Click(Sender: TObject);
begin
Main.Immobilisations1Click(Main.Immobilisations1);
end;

Procedure TEmprunt_Isa.PositionTotaux;
Begin
   PaTotal.Width:=RenvoiTailleColonne(DBEmprunt,[0,1,2,3])+10;
   GrGrid1.ColWidths[0]:=RenvoiTailleColonne(DBEmprunt,[4]);
   GrGrid1.ColWidths[1]:=RenvoiTailleColonne(DBEmprunt,[5]);
End;

Procedure TEmprunt_Isa.GestionInitDM;
var
ParamDMEmprunts:TParamDMEmprunts;
Begin
 ParamDMEmprunts.EmpruntsDataStateChange := changementEtatBoutons;
 ParamDMEmprunts.Quand := Quand;
 ParamDMEmprunts.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 InitialiseDMEmprunts(ParamDMEmprunts);
End;


Procedure TEmprunt_Isa.GereAccesEcran;
begin
  case Quand of
     C_Ouverture:Begin
                  DBEmprunt.ReadOnly := not E.AccesOuverture;
                  DBEmprunt.FSauteColReadOnly := not DBEmprunt.ReadOnly;
                  EnableWinControl([BtnInserer,BtnModifier,BtnSupprimer],E.AccesOuverture);
                  EnableItemMenu([Insrer1,Modifier1,Supprimer1],E.AccesOuverture);
                 End;
  end;
DMEmprunts.GestionAccesEmprunts;
end;

procedure TEmprunt_Isa.Imprimerempruntcourant1Click(Sender: TObject);
begin
FlagEmpruntCourant:=true;
BtnImprimer.Click;
end;

procedure TEmprunt_Isa.PopupMenu1Popup(Sender: TObject);
begin
Imprimerempruntcourant1.Caption := 'Imprimer l''emprunt : '+ DBEmprunt.DataSource.DataSet.findField('Code_emp').AsString;
end;

procedure TEmprunt_Isa.RxMAJ_BalanceClick(Sender: TObject);
begin
Activation_Desactivation_MAJ_Balance;
initialisationMAJ_Balance(RxMAJ_Balance);
end;


procedure TEmprunt_Isa.RxMAJ_BalanceMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clREd;
(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TEmprunt_Isa.RxMAJ_BalanceMouseLeave(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
(Sender as TRxSpeedButton).Font.Style:=[];
end;

procedure TEmprunt_Isa.RxMAJ_BalanceMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TEmprunt_Isa.FormDeactivate(Sender: TObject);
begin
e.TypeMAJBalance:=MAJ_Normal;
initialisationMAJ_Balance(RxMAJ_Balance);
end;

procedure TEmprunt_Isa.Exporter1Click(Sender: TObject);
begin
  inherited;
ExportDonnees(DBEmprunt.DataSource.DataSet,E.RepertoireExportDossier,'Emp_Ouv_'+E.NomDossier + E.NomExo + '.Txt');
end;

procedure TEmprunt_Isa.Calculatrice1Click(Sender: TObject);
begin
if DBEmprunt.Col in [3,4] then
  AfficheCalculatrice(DBEmprunt)
else
  AfficheCalculatrice(nil);
end;

end.