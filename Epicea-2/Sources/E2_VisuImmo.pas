{//////// le 29-04-03  Modif_Isa
j'ai modifier  la fonction QuCptUtiliseImmosAfterOpen
///////}
unit E2_VisuImmo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, RXSplit, ExtCtrls,
  StdCtrls, DBCtrls, ComCtrls, Mask, RXCtrls, ToolEdit, Buttons,
  LibZoneSaisie,dmimmos,E2_Librairie_Obj,registry,DB,E2_Decl_Records, Menus,Gr_Librairie_Obj
  ,DMEcriture,E2_Cloture_Def,LibSQL,DMConstantes, GrGrid,dbtables, jpeg,
  LibGestionParamXML, Lib_chaine,
  E2_Recherche,
  LibRessourceString,DiversProjets,
  E2_LibInfosTable;

Const
si_rebut6:string='and ((rebut=true and Terminee=false )or(((Immos.Ecriture_Cession <>0))and(not (compte like(''131%''))))) GROUP BY Immos.Compte, PlanCpt.Libelle';
si_rebut8:string='where ((rebut=true and Terminee=false) or(((Ecriture_Cession <>0 ) and (not (compte like(''131%''))))))';
si_not_rebut:string=' and ((Terminee=false) or ((Terminee=true) and (Cession_Dans_Annee=true)))  GROUP BY Immos.Compte, PlanCpt.Libelle';

type

  TParamAfficheImmos = Record
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


  TVisuImmo = class(TForm)
    PaGrille: TPanel;
    PaCptImmo: TPanel;
    PaDetails: TPanel;
    PaDetailEnTete: TPanel;
    RxSplitter1: TRxSplitter;
    Pabas: TPanel;
    PaGrilleCpt: TPanel;
    GrDBGrid1: TGrDBGrid;
    PaCptIntit: TPanel;
    PaIntitListeImmos: TPanel;
    PaGrilleEnTete: TPanel;
    GrDBGrid2: TGrDBGrid;
    PaCumul: TPanel;
    PaSelectCpt: TPanel;
    RxSBClose: TRxSpeedButton;
    RxSBValider: TRxSpeedButton;
    RxSBInverse: TRxSpeedButton;
    RxSBAnnuleSel: TRxSpeedButton;
    RxChListCpt: TListBox;
    CheckBox1: TCheckBox;
    PaPeriode: TPanel;
    Label5: TLabel;
    Label8: TLabel;
    RxSBValidePeriode: TRxSpeedButton;
    Panel8: TPanel;
    BtnClasse1: TSpeedButton;
    BtnClasse2: TSpeedButton;
    BtnClasse3: TSpeedButton;
    BtnClasse4: TSpeedButton;
    BtnClasse5: TSpeedButton;
    BtnClasse6: TSpeedButton;
    BtnClasse7: TSpeedButton;
    BtnClasse8: TSpeedButton;
    BtnClasse9: TSpeedButton;
    EditDebutPer: TDateEdit;
    EditFinPer: TDateEdit;
    PopupMenuImmo: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Diviser1: TMenuItem;
    Acquisition1: TMenuItem;
    Cession1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    PaBtn: TPanel;
    RxSBRebut: TRxSpeedButton;
    RxSBCession: TRxSpeedButton;
    RxSBDivision: TRxSpeedButton;
    RxSBAcquisition: TRxSpeedButton;
    RxSBAmo_An: TRxSpeedButton;
    RxSBPlusValues: TRxSpeedButton;
    GrDBGrid4: TGrDBGrid;
    Panel4: TPanel;
    Amortissementsur5annes1: TMenuItem;
    Values1: TMenuItem;
    Miseaurebut1: TMenuItem;
    Panel2: TPanel;
    Panel3: TPanel;
    Choix_amortissement1: TMenuItem;
    TiRecupImmosSurCpt: TTimer;
    GrGrid3: TGrGrid;
    Btn_Historique_immos: TRxLabel;
    RxLabTitre2: TRxLabel;
    Modificationspciale1: TMenuItem;
    terminer1: TMenuItem;
    PaToolsType: TPanel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    PaToolsAnnee: TPanel;
    CBExercice: TCheckBox;
    CBToutesAnnees: TCheckBox;
    CBSubventions: TCheckBox;
    CBImmos: TCheckBox;
    CbCessionExo: TCheckBox;
    procedure RxSBImmoMouseEnter(Sender: TObject);
    procedure RxSBImmoMouseLeave(Sender: TObject);
    procedure PaBitBtnResize(Sender: TObject);
//    procedure RxSBImmoClick(Sender: TObject);
//    procedure RxSBSubventionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxSBDivisionClick(Sender: TObject);
    procedure RxSBRebutClick(Sender: TObject);
    procedure RxSBCessionClick(Sender: TObject);
    procedure RxSBPlusValuesClick(Sender: TObject);
    procedure RxSBAmo_AnClick(Sender: TObject);
    procedure RxSBAcquisitionClick(Sender: TObject);
   // procedure RxSBToutesClick(Sender: TObject);
    //procedure RxSBExerciceClick(Sender: TObject);
    //procedure RxSBImmoCedeClick(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure EditDebutPerAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure EditFinPerAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure RxSBValidePeriodeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GrDBGrid2DblClick(Sender: TObject);
    procedure ChangementEtatBoutons(Sender:Tobject);
    procedure QuCptUtiliseImmosAfterScroll(DataSet: TDataSet);
    procedure QuRecupImmosSurCptAfterScroll(  DataSet: TDataSet);
    procedure Supprimer1Click(Sender: TObject);
    procedure PaGrilleCptResize(Sender: TObject);
    procedure PaToolsResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleEnTeteResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure EditDebutPerEnter(Sender: TObject);
    procedure EditDebutPerExit(Sender: TObject);
    procedure EditFinPerEnter(Sender: TObject);
    procedure EditFinPerExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EtatInitial;
    procedure FormShow(Sender: TObject);
    procedure PositionTotaux;
    procedure QuCptUtiliseImmosAfterOpen(DataSet: TDataSet);
    procedure Aide1Click(Sender: TObject);
    procedure Choix_amortissement1Click(Sender: TObject);
    procedure TiRecupImmosSurCptTimer(Sender: TObject);
    Procedure initialiseTableEvent;
    Procedure GestionInitDM;
    Procedure GereAccesEcran;
    procedure Btn_Historique_immosClick(Sender: TObject);
    procedure DemandeAffichageAcquisition(Speciale:boolean=false);
    procedure Modificationspciale1Click(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure terminer1Click(Sender: TObject);
    procedure CbCessionExoClick(Sender: TObject);
    procedure CBToutesAnneesClick(Sender: TObject);
    procedure CBExerciceClick(Sender: TObject);
    procedure CBImmosClick(Sender: TObject);
    procedure CBSubventionsClick(Sender: TObject);
    procedure PaToolsTypeResize(Sender: TObject);
    procedure PaToolsAnneeResize(Sender: TObject);
    procedure GestionCheckbox(Refresh:boolean);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    TitreForm,SousTitreForm:String;
    Quand:Integer;
  end;

Function AfficheImmos(ParamAfficheImmos:TParamAfficheImmos):Boolean;


var
  VisuImmo: TVisuImmo;
  filtre:TFiltre;

implementation

uses E2_Division, E2_Rebut, E2_PlusMoinsValues, E2_Amo3Ans, E2_ListeAcquis,
  E2_DetailAcquis, E2_CessionsImmo, E2_Main, E2_ChoixAmortissement,
  DMRecherche, E2_AideCompte, LibClassObjetSenders,LibDates;

{$R *.DFM}


Function AfficheImmos(ParamAfficheImmos:TParamAfficheImmos):Boolean;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise � z�ro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 if (VisuImmo = nil) then VisuImmo:=TVisuImmo.Create(Application.MainForm);
 if ((ParamAfficheImmos.Quand <> VisuImmo.Quand) and (VisuImmo.Visible=true)) then
   VisuImmo.Close;
 VisuImmo.Quand:=ParamAfficheImmos.Quand;
 VisuImmo.Tag:=ParamAfficheImmos.TypePresentation;
 if not empty(ParamAfficheImmos.TitreForm) then
   VisuImmo.TitreForm:=ParamAfficheImmos.TitreForm;
 VisuImmo.SousTitreForm:=ParamAfficheImmos.SousTitreForm;
 ParamDMImmos.QuiAppel:=F_VisuImmo;
  if (VisuImmo.CBImmos.state=cbChecked) and (VisuImmo.CBSubventions.state=cbChecked) then
  ParamDMImmos.typeImmos:=C_Toutes
  else
    if VisuImmo.CBImmos.state=cbChecked then
      ParamDMImmos.typeImmos:=C_Immo
    else
        ParamDMImmos.typeImmos:=C_Sub;

  if ((VisuImmo.CBExercice.state=cbChecked)and(VisuImmo.CbCessionExo.state<>cbChecked)) then
     Begin
     ParamDMImmos.TypePresentation:=C_IMMOS;
     VisuImmo.RxLabTitre.Caption:='Visualisation des immobilisations de l''exercice';
     VisuImmo.RxLabTitre2.Caption:=VisuImmo.CBExercice.Caption;

       if VisuImmo.EditDebutPer.Date>e.DatExoDebut then
         ParamDMImmos.Periode.DateDeb:=VisuImmo.EditDebutPer.Date
       else
         ParamDMImmos.Periode.DateDeb:=e.DatExoDebut;
       if VisuImmo.EditFinPer.date<e.DatExoFin then
         ParamDMImmos.Periode.DateFin:=VisuImmo.EditFinPer.date
       else
         ParamDMImmos.Periode.DateFin:=e.DatExoFin;
     End
  else
     Begin
       ParamDMImmos.TypePresentation:=c_immos;
       VisuImmo.RxLabTitre.Caption:='Visualisation de toutes les immobilisations';
       VisuImmo.RxLabTitre2.Caption:=VisuImmo.CBToutesAnnees.Caption;
       VisuImmo.EditDebutPer.Enabled:=false;
       VisuImmo.EditFinPer.Enabled:=false;

       VisuImmo.RxSBValidePeriode.Enabled:=false;
       ParamDMImmos.Periode.DateDeb:=strtodate('01/01/1900');
       ParamDMImmos.Periode.DateFin:=strtodate('01/01/2900');
     End;
  if VisuImmo.CbCessionExo.state=cbChecked then
     begin
     ParamDMImmos.TypePresentation:=C_CESSION_EXO;
     VisuImmo.RxLabTitre.Caption:='Visualisation des Cessions de l''exercice';
     VisuImmo.RxLabTitre2.Caption:=VisuImmo.CbCessionExo.Caption;
     //VisuImmo.CBToutesAnnees.Enabled:=false;
     end ;
//   else
//     begin
//     VisuImmo.CBToutesAnnees.Enabled:=true;
//     end;

     VisuImmo.Tag:=ParamDMImmos.TypePresentation;
     ParamDMImmos.tag:=VisuImmo.Tag;
     
ParamDMImmos.ImmosDataStateChange:= VisuImmo.changementEtatBoutons;
ParamDMImmos.CptImmosAfterScroll:= VisuImmo.QuCptUtiliseImmosAfterScroll;
ParamDMImmos.CptImmosAfterOpen:= VisuImmo.QuCptUtiliseImmosAfterOpen;
ParamDMImmos.ImmosAfterScroll:= VisuImmo.QuRecupImmosSurCptAfterScroll;

 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.Quand := VisuImmo.Quand;

// if ParamAfficheImmos.typeImmos<>C_NonIndique then
//   VisuImmo.typeImmos:=ParamAfficheImmos.typeImmos;
//
// ParamDMImmos.typeImmos:=VisuImmo.typeImmos;
   if not InitialiseDMImmos(ParamDMImmos).retour then abort;

 if ParamAfficheImmos.Affiche then
  begin
     //Grille des comptes d'immobilisations utilis�s
     VisuImmo.GrDBGrid1.DataSource := DataModuleImmos.DaCptUtiliseImmos;
     //Grille des immobilisations pour le compte s�lectionn�
     VisuImmo.GrDBGrid2.DataSource := DataModuleImmos.daRecupImmosSurCpt;
     //Grille des totaux
     VisuImmo.GrDBGrid4.DataSource :=DataModuleImmos.dsTotalCumulImmosSurCpt;
     VisuImmo.Btn_Historique_immos.Visible:=e.TypeClient=cl_isa;
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);
  TMenuItem(VisuImmo.FindComponent('Modificationspciale1')).Visible:= ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));

     if ParamAfficheImmos.AffichageModal then
       VisuImmo.ShowModal
      else
       VisuImmo.Show;
  End;
except
  result:=false;
end;
End;

Procedure TVisuImmo.GestionInitDM;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise � z�ro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 ParamDMImmos.QuiAppel:=F_VisuImmo;
 ParamDMImmos.TypePresentation:=VisuImmo.Tag;
 ParamDMImmos.Tag:=VisuImmo.Tag;

ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
ParamDMImmos.ImmosDataStateChange:=VisuImmo.changementEtatBoutons;
ParamDMImmos.CptImmosAfterScroll:=VisuImmo.QuCptUtiliseImmosAfterScroll;
ParamDMImmos.CptImmosAfterOpen:=VisuImmo.QuCptUtiliseImmosAfterOpen;
ParamDMImmos.ImmosAfterScroll:=VisuImmo.QuRecupImmosSurCptAfterScroll;
ParamDMImmos.Quand := VisuImmo.Quand;


  if (VisuImmo.CBImmos.state=cbChecked) and (VisuImmo.CBSubventions.state=cbChecked) then
  ParamDMImmos.typeImmos:=C_Toutes
  else
    if VisuImmo.CBImmos.state=cbChecked  then
      ParamDMImmos.typeImmos:=C_Immo
    else
        ParamDMImmos.typeImmos:=C_Sub;

  if ((VisuImmo.CBExercice.state=cbChecked)and( VisuImmo.CbCessionExo.state<>cbChecked)) then
     Begin
     ParamDMImmos.TypePresentation:=C_IMMOS;
     VisuImmo.RxLabTitre.Caption:='Visualisation des immobilisations de l''exercice';
     VisuImmo.RxLabTitre2.Caption:=VisuImmo.CBExercice.Caption;

       if VisuImmo.EditDebutPer.Date>e.DatExoDebut then
         ParamDMImmos.Periode.DateDeb:=VisuImmo.EditDebutPer.Date
       else
         ParamDMImmos.Periode.DateDeb:=e.DatExoDebut;
       if VisuImmo.EditFinPer.date<e.DatExoFin then
         ParamDMImmos.Periode.DateFin:=VisuImmo.EditFinPer.date
       else
         ParamDMImmos.Periode.DateFin:=e.DatExoFin;
     End
  else
     Begin
       ParamDMImmos.TypePresentation:=c_immos;
       VisuImmo.RxLabTitre.Caption:='Visualisation de toutes les immobilisations';
       VisuImmo.RxLabTitre2.Caption:=VisuImmo.CBToutesAnnees.Caption;
       VisuImmo.EditDebutPer.Enabled:=false;
       VisuImmo.EditFinPer.Enabled:=false;

       VisuImmo.RxSBValidePeriode.Enabled:=false;
       ParamDMImmos.Periode.DateDeb:=strtodate('01/01/1900');
       ParamDMImmos.Periode.DateFin:=strtodate('01/01/2900');
     End;
  if VisuImmo.CbCessionExo.state=cbChecked then
     begin
     ParamDMImmos.TypePresentation:=C_CESSION_EXO;
     VisuImmo.RxLabTitre.Caption:='Visualisation des Cessions de l''exercice';
     VisuImmo.RxLabTitre2.Caption:=VisuImmo.CbCessionExo.Caption;
    // VisuImmo.CBToutesAnnees.Enabled:=false;
     end;
//   else
//     begin
//     VisuImmo.CBToutesAnnees.Enabled:=true;
//     end;

     VisuImmo.Tag:=ParamDMImmos.TypePresentation;
     ParamDMImmos.tag:=VisuImmo.Tag;


 if not InitialiseDMImmos(ParamDMImmos).retour then abort;
except
  MessageDlg('Probl�me rencontr� lors de l''initialisation du datamodule des '+#13+#10+'immobilisations', mtWarning, [mbOK], 0);
end;
End;


Procedure TVisuImmo.GereAccesEcran;
begin
  case Quand of
     C_Mouvement:Begin
                     //differentes zones de description de l'immo selectionn�e
                     //Grille des comptes d'immobilisations utilis�s
                     GrDBGrid1.ReadOnly := true;
                     GrDBGrid1.FSauteColReadOnly := not GrDBGrid1.ReadOnly;
                     //Grille des immobilisations pour le compte s�lectionn�
                     GrDBGrid2.ReadOnly := true;
                     GrDBGrid2.FSauteColReadOnly := not GrDBGrid2.ReadOnly;
                     //Grille des totaux
                     GrDBGrid4.ReadOnly := true;
                     GrDBGrid4.FSauteColReadOnly := not GrDBGrid4.ReadOnly;
                 End;
  end;
DataModuleImmos.GestionAccesImmos;
end;

procedure TVisuImmo.RxSBImmoMouseEnter(Sender: TObject);
begin
(Sender as TRxSpeedButton).Font.Color:=clRed;
//(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TVisuImmo.RxSBImmoMouseLeave(Sender: TObject);
begin
if (sender is TRxSpeedButton) then
(Sender as TRxSpeedButton).Font.Color:=clWindowText;
//(Sender as TRxSpeedButton).Font.Style:=[fsBold];
end;

procedure TVisuImmo.PaBitBtnResize(Sender: TObject);
begin
//FormateTailleBoutton([RxSBImmo,RxSBSubventions,RxSBExercice,RxSBToutes,RxSBImmoCede],PaBitBtn,90,0);
end;





procedure TVisuImmo.FormCreate(Sender: TObject);
var
dateDeb,DateEnd:tdate;
Registre :TRegistry;
Begin
  try
       if DataModuleImmos=nil then
        DataModuleImmos:=TDataModuleImmos.Create(self);

      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
 Registre:= TRegistry.Create;
   try
     with Registre do
       begin
       RootKey := HKEY_LOCAL_MACHINE;
       OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, false);
          try
//            CBExercice.AllowAllUp:=true;

            if ReadBool('CBImmos') then CBImmos.state:= cbChecked;
            if ReadBool('CBSubventions') then CBSubventions.state:= cbChecked;
            if ReadBool('CBExercice') then CBExercice.state:= cbChecked;
            if ReadBool('CBToutesAnnees') then CBToutesAnnees.state:= cbChecked;
            if ReadBool('CbCessionExo') then CbCessionExo.state:= cbChecked;

//            EditDebutPer.text:=ReadString('EditDebutPer');
//            EditFinPer.text:=ReadString('EditFinPer');
           // RxSBExercice.AllowAllUp:=false;
//              abort;
          except
            //RxSBExercice.AllowAllUp:=true;
            CBImmos.state:=cbChecked;
            CBSubventions.state:=cbChecked;
            CBExercice.state:=cbUnchecked;
            CBToutesAnnees.state:=cbChecked;
            CbCessionExo.state:=cbUnchecked;
            //RxSBExercice.AllowAllUp:=false;
          end;
       end;//fin du with
   finally
     Registre.Free;
   end;
            EditDebutPer.date:=e.DatExoDebut;
            EditFinPer.date:=e.DatExoFin;

//if CbCessionExo.state=cbChecked then
//  CBToutesAnnees.Enabled:=false
//else
//  CBToutesAnnees.Enabled:=true;

end;

procedure TVisuImmo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then
begin
if EditDebutPer.PopupVisible then
  WinSuivPrec(Handle,key,[GrDBGrid1,GrDBGrid2,EditDebutPer,EditFinPer,RxChListCpt])
else
  if not ((EditDebutPer.PopupVisible) or (EditFinPer.PopupVisible)) then
    WinSuivPrec(Handle,key,[GrDBGrid1,GrDBGrid2,RxChListCpt])
  else
    WinSuivPrec(Handle,key,[GrDBGrid1,GrDBGrid2,EditFinPer,EditDebutPer,RxChListCpt]);
end;
if not ((EditDebutPer.PopupVisible) or (EditFinPer.PopupVisible)) then
  begin
    If Key = VK_ESCAPE Then
      self.close;
  end;
end;

procedure TVisuImmo.RxSBDivisionClick(Sender: TObject);
var
ParamAfficheDivision:TParamAffichageDivision;
begin
try
DataModuleImmos.Compte_DernierCree:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
DataModuleImmos.ID_DernierCree:=DataModuleImmos.QuRecupImmosSurCptid.AsInteger;
if DataModuleImmos.QuCptUtiliseImmos.RecordCount<>0 then
  Begin
  RxSBImmoMouseLeave(sender);
  ParamAfficheDivision.AffichageModal := true;
  ParamAfficheDivision.Affiche := true;
  ParamAfficheDivision.Quand := C_Mouvement;
  ParamAfficheDivision.TitreForm :='Division d"une immobilisation';
  ParamAfficheDivision.SousTitreForm := CMouvement;
  ParamAfficheDivision.QuiAppel:=F_Division;
  ParamAfficheDivision.ImmoCourante:=DataModuleImmos.QuRecupImmosSurCptID.AsInteger;
  if not DivisionAffiche(ParamAfficheDivision) then abort;
  End;
finally
VisuImmo.FormActivate(visuImmo);
DataModuleImmos.ReactualiseQuery;
DataModuleImmos.QuCptUtiliseImmos.locate('compte',DataModuleImmos.Compte_DernierCree,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',DataModuleImmos.ID_DernierCree,[]);
end;
end;

procedure TVisuImmo.RxSBRebutClick(Sender: TObject);
var
ParamAfficheRebut:TParamAffichageRebut;
begin
try
DataModuleImmos.Compte_DernierCree:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
DataModuleImmos.ID_DernierCree:=DataModuleImmos.QuRecupImmosSurCptid.AsInteger;
if DataModuleImmos.QuCptUtiliseImmos.RecordCount<>0 then
  Begin
  RxSBImmoMouseLeave(sender);
  ParamAfficheRebut.AffichageModal := true;
  ParamAfficheRebut.Affiche := true;
  ParamAfficheRebut.Quand := C_Mouvement;
  ParamAfficheRebut.TitreForm :='Mise au rebut';
  ParamAfficheRebut.SousTitreForm := CMouvement;
  ParamAfficheRebut.QuiAppel:=F_Rebut;
  ParamAfficheRebut.ImmoCourante:=DataModuleImmos.QuRecupImmosSurCptID.AsInteger;
  if not RebutAffiche(ParamAfficheRebut) then abort;
  End;
finally
VisuImmo.FormActivate(visuImmo);
DataModuleImmos.ReactualiseQuery;
DataModuleImmos.QuCptUtiliseImmos.locate('compte',DataModuleImmos.Compte_DernierCree,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',DataModuleImmos.ID_DernierCree,[]);
end;
end;

procedure TVisuImmo.RxSBCessionClick(Sender: TObject);
var
ParamAffichageCession:TParamAffichageCession;
begin
try
DataModuleImmos.Compte_DernierCree:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
DataModuleImmos.ID_DernierCree:=DataModuleImmos.QuRecupImmosSurCptid.AsInteger;
if DataModuleImmos.QuCptUtiliseImmos.RecordCount<>0 then
  Begin
  DataModuleImmos.Filtrage_qryListeAcquis_SurTag(C_Cession,false,-1,'');
  if DataModuleImmos.qryListeAcquis.RecordCount<>0 then
     begin //s'il y a des �criture de cessions, alors on ouvre la fen�tre
       RxSBImmoMouseLeave(sender);
       ParamAffichageCession.AffichageModal:=true;
       ParamAffichageCession.Affiche:=true;
       ParamAffichageCession.Quand := C_Mouvement;
       ParamAffichageCession.TitreForm :='Cessions des Immobilisations';
       ParamAffichageCession.SousTitreForm := CMouvement;
       ParamAffichageCession.QuiAppel:=F_Cession;
       ParamAffichageCession.TypePresentation:=C_CESSION;
       if not CessionAffiche(ParamAffichageCession) then abort;
     end;
  end;
finally
VisuImmo.FormActivate(visuImmo);
DataModuleImmos.ReactualiseQuery;
DataModuleImmos.QuCptUtiliseImmos.locate('compte',DataModuleImmos.Compte_DernierCree,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',DataModuleImmos.ID_DernierCree,[]);
end;
end;

procedure TVisuImmo.RxSBPlusValuesClick(Sender: TObject);
begin
try
DataModuleImmos.Compte_DernierCree:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
DataModuleImmos.ID_DernierCree:=DataModuleImmos.QuRecupImmosSurCptid.AsInteger;

 if PlusMoinsValues = Nil then PlusMoinsValues := TPlusMoinsValues.Create(Application.MainForm);
 RxSBImmoMouseLeave(sender);
 //Main.AffichageForm(Main.Monofenetrage,PlusMoinsValues);//isa le 22-01-03
 Main.AffichageForm(true,PlusMoinsValues);

finally
VisuImmo.FormActivate(visuImmo);
DataModuleImmos.ReactualiseQuery;
DataModuleImmos.QuCptUtiliseImmos.locate('compte',DataModuleImmos.Compte_DernierCree,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',DataModuleImmos.ID_DernierCree,[]);
end;
end;

procedure TVisuImmo.RxSBAmo_AnClick(Sender: TObject);
begin
try
DataModuleImmos.Compte_DernierCree:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
DataModuleImmos.ID_DernierCree:=DataModuleImmos.QuRecupImmosSurCptid.AsInteger;

  if Amort5Ans = Nil then Amort5Ans := TAmort5Ans.Create(Self);
  RxSBImmoMouseLeave(sender);
  //Main.AffichageForm(Main.Monofenetrage,Amort5Ans);//isa le 22-01-03
  Amort5Ans.Tag:=C_ImmoCourante;
  Amort5Ans.RxSBImmoEnCours.down:=true;
  Main.AffichageForm(true,Amort5Ans);

finally
VisuImmo.FormActivate(visuImmo);
DataModuleImmos.ReactualiseQuery;
DataModuleImmos.QuCptUtiliseImmos.locate('compte',DataModuleImmos.Compte_DernierCree,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',DataModuleImmos.ID_DernierCree,[]);
end;
end;

procedure TVisuImmo.RxSBAcquisitionClick(Sender: TObject);
begin
try
DataModuleImmos.Compte_DernierCree:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
DataModuleImmos.ID_DernierCree:=DataModuleImmos.QuRecupImmosSurCptid.AsInteger;
   DataModuleImmos.Filtrage_qryListeAcquis_SurTag(C_ACQUISITION_Terminee,false,-1,'');
   if DataModuleImmos.qryListeAcquis.RecordCount<>0 then
      begin
      if ListeAcquis = Nil then ListeAcquis := TListeAcquis.Create(Self);
      ListeAcquis.tag:=C_ACQUISITION_Terminee;
      RxSBImmoMouseLeave(sender);
      //Main.AffichageForm(Main.Monofenetrage,ListeAcquis);//isa le 22-01-03
      Main.AffichageForm(true,ListeAcquis);
      end;
finally
VisuImmo.FormActivate(visuImmo);
DataModuleImmos.ReactualiseQuery;
DataModuleImmos.QuCptUtiliseImmos.locate('compte',DataModuleImmos.Compte_DernierCree,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',DataModuleImmos.ID_DernierCree,[]);
end;
end;







Procedure TVisuImmo.InitialiseTable_A_Nil;
Begin
  if DataModuleImmos<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DataModuleImmos.QuRecupImmosSurCpt,DataModuleImmos.QuCptUtiliseImmos,DataModuleImmos.daDetailImmo]);
End;

procedure TVisuImmo.FormDestroy(Sender: TObject);
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
          if CBImmos.state = cbchecked then WriteBool('CBImmos',true)
          else WriteBool('CBImmos',false);
           if CBSubventions.state = cbchecked then WriteBool('CBSubventions',true)
           else WriteBool('CBSubventions',false);
            if CBExercice.state = cbchecked then WriteBool('CBExercice',true)
            else WriteBool('CBExercice',false);
             if CBToutesAnnees.state = cbchecked then WriteBool('CBToutesAnnees',true)
              else WriteBool('CBToutesAnnees',false);
              if CbCessionExo.state = cbchecked then WriteBool('CbCessionExo',true)
               else WriteBool('CbCessionExo',false);


          WriteString('EditDebutPer',EditDebutPer.Text);
          WriteString('EditFinPer',EditFinPer.text);
        end;
        CloseKey;
     end;
  finally
     Registre.Free;
LibGestionParamXML.DestroyForm(self,E.User);
if DataModuleImmos<>nil then
  if not((csDestroying)in DataModuleImmos.ComponentState) then DataModuleImmos.Free;
// if not (DataModuleImmos.ComponentState = csDestroying ) then DataModuleImmos.Free;
VisuImmo:=nil;
  end;
end;

procedure TVisuImmo.EditDebutPerAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
   Action:=((Adate>=E.DatExoDebut) and (Adate<=e.DatExoFin));
   if not action then
     showmessage('Cette date doit faire partie de l''exercice ');
end;

procedure TVisuImmo.EditFinPerAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
   Action:=((Adate>=E.DatExoDebut) and (Adate<=e.DatExoFin));
   if not action then
     showmessage('Cette date doit faire partie de l''exercice ');
end;

procedure TVisuImmo.RxSBValidePeriodeClick(Sender: TObject);
begin
   if ((editDebutPer.Enabled)and (EditFinPer.Enabled)) then
     Begin
       DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateDebut').asdate:=EditDebutPer.Date;
       DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate:=EditFinPer.date;
     DataModuleImmos.ReactualiseQuery;
     End;
end;

procedure TVisuImmo.FormActivate(Sender: TObject);
begin
GestionInitDM;
GereAccesEcran;
PaGrilleEnTeteResize(GrDBGrid2);
  TMenuItem(VisuImmo.FindComponent('Modificationspciale1')).Visible:= e.TypeClient=CL_Isa;
end;

procedure TVisuImmo.GrDBGrid2DblClick(Sender: TObject);
begin
//appel affichage immos
DemandeAffichageAcquisition;
end;


procedure TVisuImmo.DemandeAffichageAcquisition(Speciale:boolean);
var
ParamAffichageDetailAcquis:TParamAffichageDetailAcquis;
begin
try//finally
///
//if not e.ExerciceCloture then
//  begin
      DataModuleImmos.Compte_DernierCree:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
      DataModuleImmos.ID_DernierCree:=DataModuleImmos.QuRecupImmosSurCptid.AsInteger;
        if DataModuleImmos.QuRecupImmosSurCptAchat_Dans_Annee.AsBoolean then
          Begin//si immos dans l'ann�e
//          DataModuleImmos.Tag:=2;
                //if DetailAcquis = Nil then DetailAcquis := TDetailAcquis.Create(Self);
              //Begin
//              DataModuleImmos.TaImmosEnCours.close;
//              DataModuleImmos.TaImmosEnCours.open;
              filtragedataset(DataModuleImmos.TaImmosEnCours,'compte=''23*'' and Terminee=vrai and compteTerminee ='''+DataModuleImmos.taDetailImmo.FindField('Compte').Asstring+'''  and codeTerminee ='''+DataModuleImmos.taDetailImmo.FindField('Code').Asstring+'''  and SouscodeTerminee = '''+DataModuleImmos.taDetailImmo.FindField('Sous_Code').Asstring+''' and Rebut=faux');
              if copy(DataModuleImmos.QuRecupImmosSurCptCompte.asstring,1,2)='23'then
                Begin
                  ParamAffichageDetailAcquis.TypePresentation:=C_DESCRIPTION_En_Cours;
                End
              else
                if DataModuleImmos.TaImmosEnCours.RecordCount<>0 then
                  Begin
                    ParamAffichageDetailAcquis.TypePresentation:=C_DESCRIPTION_Terminee ;
                  End
                else
                  Begin
                    ParamAffichageDetailAcquis.TypePresentation:=C_DESCRIPTION_Simple;
                  End;
              filtragedataset(DataModuleImmos.TaImmosEnCours,'compte=''23*''');
              ParamAffichageDetailAcquis.AffichageModal := true;
              ParamAffichageDetailAcquis.Affiche := true;
              ParamAffichageDetailAcquis.Quand := C_Mouvement;
              ParamAffichageDetailAcquis.TitreForm :='Saisie des param�tres de l"acquisition';
              ParamAffichageDetailAcquis.SousTitreForm := CMouvement;
              ParamAffichageDetailAcquis.QuiAppel:=F_DetailAcquis;
              ParamAffichageDetailAcquis.Maintenance:=Speciale;
              if not DetailAcquisAffiche(ParamAffichageDetailAcquis) then abort;
              //DetailAcquis.ShowModal;
              //End;
          End//si immos dans l'ann�e
        else
          begin
            showmessage('Cette immobilisation ne fait pas partie de l''ann�e, vous ne pouvez pas la modifier');

          end;
//  end
//else
//   showmessage('Cette fonctionnalit� n"est pas disponible � partir d"un exercice cl�tur�');
finally
VisuImmo.FormActivate(visuImmo);
DataModuleImmos.ReactualiseQuery;
DataModuleImmos.QuCptUtiliseImmos.locate('compte',DataModuleImmos.Compte_DernierCree,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',DataModuleImmos.ID_DernierCree,[]);
end;

end;


procedure TVisuImmo.ChangementEtatBoutons(Sender:Tobject);
var
accesEcran:boolean;
Begin
//pour la cog�r�
accesEcran:=((e.AccesCloture)and(not e.ExerciceCloture));
//EnableWinControl([Twincontrol(RxSBImmo),Twincontrol(RxSBSubventions),Twincontrol(RxSBExercice),Twincontrol(RxSBToutes),Twincontrol(RxSBImmoCede),Twincontrol(RxSBDivision),Twincontrol(RxSBPlusValues),Twincontrol(RxSBAmo_An),Twincontrol(RxSBAcquisition),Twincontrol(RxSBCession),Twincontrol(RxSBRebut)],false);
 Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DataModuleImmos.daRecupImmosSurCpt.DataSet);
 // RxSBRebut.Enabled:=((DataModuleImmos.taDetailImmoRebut.AsBoolean=false)and(VerifFNumeric(DataModuleImmos.taDetailImmoDate_Cession).VideOUZero)and(DataModuleImmos.taDetailImmoCession_dans_Annee.AsBoolean=false)and(DataModuleImmos.taDetailImmo.RecordCount<>0));
 RxSBRebut.Enabled:=((accesEcran)and (((DataModuleImmos.taDetailImmoRebut.AsBoolean=false)and (DataModuleImmos.taDetailImmoTerminee.AsBoolean=false)and(DataModuleImmos.taDetailImmoCession_dans_Annee.AsBoolean=false)and(DataModuleImmos.taDetailImmo.RecordCount<>0))));
 DataModuleImmos.Filtrage_qryListeAcquis_SurTag(C_Cession,false,-1,'');
 RxSBCession.Enabled:=((accesEcran)and (DataModuleImmos.qryListeAcquis.RecordCount<>0));

 RxSBDivision.Enabled:=((accesEcran)and(((not DataModuleImmos.taDetailImmoRebut.AsBoolean)and(not DataModuleImmos.taDetailImmoCession_dans_Annee.AsBoolean)and(DataModuleImmos.taDetailImmo.RecordCount<>0))));

 DataModuleImmos.Filtrage_qryListeAcquis_SurTag(C_ACQUISITION_Terminee,false,-1,'');
 RxSBAcquisition.Enabled:=((accesEcran)and(((DataModuleImmos.qryListeAcquis.RecordCount<>0)and(CbCessionExo.state=cbunChecked))));

 RxSBAmo_An.Enabled:=((accesEcran)and(DataModuleImmos.taDetailImmo.RecordCount<>0));
// RxSBAmo_An.Enabled:=false;
 RxSBPlusValues.Enabled:=((accesEcran)and(DataModuleImmos.taDetailImmo.RecordCount<>0));

Diviser1.Enabled:=RxSBDivision.Enabled;
Values1.Enabled:=RxSBPlusValues.Enabled;
Amortissementsur5annes1.Enabled:=RxSBAmo_An.Enabled;
Acquisition1.Enabled:=RxSBAcquisition.Enabled;
Cession1.Enabled:=RxSBCession.Enabled;
Miseaurebut1.Enabled:=RxSBRebut.Enabled;
Supprimer1.Enabled:=accesEcran;
Choix_amortissement1.Enabled:=accesEcran;
 if DataModuleImmos.QuRecupImmosSurCpt.Active then
   caption:=caption+' - '+inttostr(DataModuleImmos.QuRecupImmosSurCpt.RecordCount)+' immobilisations';
end;

procedure TVisuImmo.QuCptUtiliseImmosAfterScroll(DataSet: TDataSet);
begin
   DataModuleImmos.QuRecupImmosSurCpt.DisableControls;
   //DataModuleImmos.Filtrage_QuRecupImmosSurCpt_SurTag(self.Tag,false,-1,'',DataModuleImmos.QuCptUtiliseImmosCompte.asstring,strtodate('01/01/1900'),DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate);
   DataModuleImmos.Filtrage_QuRecupImmosSurCpt_SurTag(self.Tag,false,-1,'',DataModuleImmos.QuCptUtiliseImmosCompte.asstring,DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateDebut').asdate,DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate);
   DataModuleImmos.QuRecupImmosSurCpt.EnableControls;

   DataModuleImmos.qryTotalCumulImmosSurCpt.DisableControls;
//   DataModuleImmos.qryTotalCumulImmosSurCpt.ParamByName('Compte').asstring:=DataModuleImmos.QuCptUtiliseImmosCompte.AsString;
//   DataModuleImmos.qryTotalCumulImmosSurCpt.Active:=false;
//   DataModuleImmos.qryTotalCumulImmosSurCpt.Open;
   DataModuleImmos.qryTotalCumulImmosSurCpt.Active:=false;
   DataModuleImmos.qryTotalCumulImmosSurCpt.Prepare;
   DataModuleImmos.qryTotalCumulImmosSurCpt.open;
   PaIntitListeImmos.Caption:='Liste des immobilisations pour le compte : '+DataModuleImmos.QuRecupImmosSurCpt.findfield('Compte').AsString;
   DataModuleImmos.qryTotalCumulImmosSurCpt.EnableControls;
//   ChangementEtatBoutons(DataSet);
end;



procedure TVisuImmo.QuRecupImmosSurCptAfterScroll(  DataSet: TDataSet);
Begin
  //ChangementEtatBoutons(dataset);
  //j'active le timer
  TiRecupImmosSurCpt.Enabled:=true;
End;

procedure TVisuImmo.Supprimer1Click(Sender: TObject);
var
Compte_Depart:string;
id_DepartCpt:integer;
begin
Compte_Depart:=DataModuleImmos.QuCptUtiliseImmosCompte.Asstring;
id_DepartCpt:=DataModuleImmos.QuRecupImmosSurCptID.AsInteger;
   if ActiveControl=GrDBGrid2 then
   begin
     //gestion Suppression d'une immobilisation ou suppression de la cession
     if CbCessionExo.state=cbChecked then
       DataModuleImmos.SuppressionImmo(DataModuleImmos.taDetailImmo,DataModuleImmos.QuRecupImmosSurCptID.asinteger,false,true)
     else
       DataModuleImmos.SuppressionImmo(DataModuleImmos.taDetailImmo,DataModuleImmos.QuRecupImmosSurCptID.asinteger,true,true);
   end;

DataModuleImmos.QuCptUtiliseImmos.locate('compte',Compte_Depart,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',id_DepartCpt,[]);
end;

procedure TVisuImmo.PaGrilleCptResize(Sender: TObject);
begin
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
  FormateTailleColonne(GrDBGrid1,36,[3,6,5,5,5,5,5]);
end;

procedure TVisuImmo.PaToolsResize(Sender: TObject);
begin
  //FormateTailleBoutton([RxSBImmo,RxSBSubventions,RxSBExercice,RxSBToutes,RxSBImmoCede],PaTools,100,0);
end;

procedure TVisuImmo.PaBtnResize(Sender: TObject);
begin
  FormateTailleBouttonAvecEspace([RxSBDivision,RxSBPlusValues,RxSBAmo_An,RxSBAcquisition,RxSBCession,RxSBRebut],PaBtn,(PaBtn.Width div 6),PaBtn.Height-1,5);
end;

procedure TVisuImmo.PaGrilleEnTeteResize(Sender: TObject);
begin
   case self.tag of
   C_CESSION_EXO:FormateTailleColonne(GrDBGrid2,45,[8,5,1,5,5,5,5,5,5]);
   C_IMMOS:FormateTailleColonne(GrDBGrid2,45,[8,5,5,5,5,5,5,3,1]);
   end;//fin du case
   positiontotaux;
end;

procedure TVisuImmo.PaGrilleResize(Sender: TObject);
begin
   WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TVisuImmo.Visualisation1Click(Sender: TObject);
begin
 if not empty(DataModuleImmos.QuCptUtiliseImmos.findfield('compte').ASString) then
   DetailEcritureCompte(DataModuleImmos.QuCptUtiliseImmos.findfield('compte').ASString,true,False)
end;

procedure TVisuImmo.EditDebutPerEnter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label5,clRed,0);
end;

procedure TVisuImmo.EditDebutPerExit(Sender: TObject);
begin
CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label5,clWindowText,0);
end;

procedure TVisuImmo.EditFinPerEnter(Sender: TObject);
begin
CouleurActivecontrolLabel(ParamUtil.CouleurDBGrid.CelActiveSAisieColorFond,Label8,clRed,0);
end;

procedure TVisuImmo.EditFinPerExit(Sender: TObject);
begin
CouleurDeActivecontrolLabel(lastZoneEdit,ParamUtil.CouleurDBGrid.GrilleColorFond,Label8,clWindowText,0);
end;

procedure TVisuImmo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
  if canclose then
    begin
    InitialiseTable_A_Nil;{ isa  le  29/01/04 }
    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
      begin
        if ((Cloture_Def.EtapeSuivante>=7)or(Cloture_Def.EtapeSuivante>=8)) then  { isa  le  09/09/03 }
          Cloture_Def.EtapeSuivante:=Cloture_Def.EtapeSuivante-1;
      end;
    end;
  except
    //
  end;
end;


procedure TVisuImmo.EtatInitial;
var
i:integer;
Begin
//suivant le tag on red�finit toutes les colonnes
   case self.tag of
   C_CESSION_EXO:
        Begin
          GrDbGridInitColonne(GrDBGrid2,DataModuleImmos.daRecupImmosSurCpt,DataModuleImmos.QuRecupImmosSurCpt,
            ['Immobilisation','Date d"acquis.','T.','Date cession','Valeur d''acquis.','Mt.Cession','Amort.Exercice','Amort.Cumul�','+/- Value'],
            ['Immobilisation','Date_mise_en_service','type_Amt','Date_Cession','Valeur_a_amortir','Mt_Cession','choix','cumul','PlusValue']
            ,E.FormatMonnaie,E.EditFormat);
          GrDbGridInitColonne(GrDBGrid4,DataModuleImmos.dsTotalCumulImmosSurCpt,DataModuleImmos.qryTotalCumulImmosSurCpt,
            ['','','',''],
            ['valeur_a_amortir','MtCession','Exercice','cumul']
            ,E.FormatMonnaie,E.EditFormat);
        GrDBGrid2.Columns[6].Color:=$0099E5FF;
        End;
   C_IMMOS:
        Begin
          GrDbGridInitColonne(GrDBGrid2,DataModuleImmos.daRecupImmosSurCpt,DataModuleImmos.QuRecupImmosSurCpt,
            ['Immobilisation','Date d"acquis.','Valeur d''acquis.','Amort.ant�rieur','Amort.Exercice','Amort.Cumul�','Valeur nette','Type A.',''],
            ['Immobilisation','Date_mise_en_service','Valeur_a_amortir','report','choix','cumul','valeur_nette','typeA','situation']
            ,E.FormatMonnaie,E.EditFormat);
          GrDbGridInitColonne(GrDBGrid4,DataModuleImmos.dsTotalCumulImmosSurCpt,DataModuleImmos.qryTotalCumulImmosSurCpt,
            ['','','','',''],
            ['valeur_a_amortir','Report','Exercice','cumul','valeur_nette']
            ,E.FormatMonnaie,E.EditFormat);
        GrDBGrid2.Columns[4].Color:=$0099E5FF;
        GrDBGrid2.Columns[6].Color:=$0099E5FF;
        End;
   end;//fin du case
PaGrilleEnTeteResize(GrDBGrid2);
End;

procedure TVisuImmo.FormShow(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);

//initialiseTableEvent;
//DataModuleImmos.daDetailImmo.OnStateChange(DataModuleImmos.taDetailImmo);

CouleurFond([EditDebutPer,EditFinPer],ParamUtil.CouleurDBGrid.GrilleColorFond);

  Patitre.visible:=Main.AfficheTitre;

  GrDBGrid1.ParamColor:=true;
  GrDBGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrDBGrid1.UpDateColor;

  GrDBGrid2.ParamColor:=true;
  GrDBGrid2.Param:=ParamUtil.CouleurDBGrid;
  GrDBGrid2.UpDateColor;

  GrGrid3.ParamColor:=true;
  GrGrid3.Param:=ParamUtil.CouleurDBGrid;
  GrGrid3.DessineContourLigne:=false;
  GrGrid3.UpDateColor;

  GrDBGrid4.HighlightColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;
  GrDBGrid4.HighlightFontColor:=ParamUtil.CouleurDBGrid.GrilleColorFont;
  GrDBGrid4.Color:=ParamUtil.CouleurDBGrid.GrilleColorFond;
EtatInitial;  
end;


procedure TVisuImmo.PositionTotaux;
Begin//si
   //fonctionne avec la grille 2
   case self.tag of
   C_CESSION_EXO:
        Begin
          Panel4.Width:=RenvoiTailleColonne(GrDBGrid2,[0,1,2,3,4])+8;
          GrDBGrid4.ColWidths[0]:=RenvoiTailleColonne(GrDBGrid2,[5]);
          GrDBGrid4.ColWidths[1]:=RenvoiTailleColonne(GrDBGrid2,[6]);
          GrDBGrid4.ColWidths[2]:=RenvoiTailleColonne(GrDBGrid2,[7]);
          GrDBGrid4.ColWidths[3]:=RenvoiTailleColonne(GrDBGrid2,[8]);
          //GrDBGrid4.ColWidths[4]:=RenvoiTailleColonne(GrDBGrid2,[9]);
        End;
   C_IMMOS:
        Begin
          Panel4.Width:=RenvoiTailleColonne(GrDBGrid2,[0,1,2])+8;
          GrDBGrid4.ColWidths[0]:=RenvoiTailleColonne(GrDBGrid2,[3]);
          GrDBGrid4.ColWidths[1]:=RenvoiTailleColonne(GrDBGrid2,[4]);
          GrDBGrid4.ColWidths[2]:=RenvoiTailleColonne(GrDBGrid2,[5]);
          GrDBGrid4.ColWidths[3]:=RenvoiTailleColonne(GrDBGrid2,[6]);
          GrDBGrid4.ColWidths[4]:=RenvoiTailleColonne(GrDBGrid2,[7]);
        End;
   end;//fin du case


   //fonctionne avec la grille 1
   Panel3.Width:=RenvoiTailleColonne(GrDBGrid1,[0,1,2])+5;
   GrGrid3.ColWidths[0]:=RenvoiTailleColonne(GrDBGrid1,[3]);
   GrGrid3.ColWidths[1]:=RenvoiTailleColonne(GrDBGrid1,[4]);
   GrGrid3.ColWidths[2]:=RenvoiTailleColonne(GrDBGrid1,[5]);
   GrGrid3.ColWidths[3]:=RenvoiTailleColonne(GrDBGrid1,[6]);
   GrGrid3.ColWidths[4]:=RenvoiTailleColonne(GrDBGrid1,[7]);

End;//fin si


procedure TVisuImmo.QuCptUtiliseImmosAfterOpen(DataSet: TDataSet);
var
Totaux:TTotauxGeneric;
begin
  try
  DataModuleImmos.QuCptUtiliseImmos.AfterScroll:=nil;
  Totaux:=SommeTotauxGenericQuery(['Valeur_a_amortir','report','exercice','Cumul','Valeur_nette'],DataModuleImmos.QuCptUtiliseImmos);
  if GrGrid3<>nil then
    begin
      GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total1);
      GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total2);
      GrGrid3.cells[2,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total3);
      GrGrid3.cells[3,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total4);
      GrGrid3.cells[4,0]:=FormatFloat(E.FormatMonnaie + ';; ', Totaux.Total5);
    end;
  finally
    DataModuleImmos.QuCptUtiliseImmos.AfterScroll:=QuCptUtiliseImmosAfterScroll;
  End;
end;

procedure TVisuImmo.Aide1Click(Sender: TObject);
begin
if activeControl=GrDBGrid1 then
  Begin
   RechercherQu(GrDBGrid1,GrDBGrid1.DataSource.DataSet,['Compte','Libelle'],['Compte','Libelle'],'',0,'Immos.db');
  end;
if ActiveControl=EditDebutPer then
  EditDebutPer.DoClick;
if ActiveControl=EditFinPer then
  EditFinPer.DoClick;
end;


procedure TVisuImmo.Choix_amortissement1Click(Sender: TObject);
var
ParamAffichageChoixAmortissement:TParamAffichageChoixAmortissement;
begin
try
DataModuleImmos.Compte_DernierCree:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
DataModuleImmos.ID_DernierCree:=DataModuleImmos.QuRecupImmosSurCptid.AsInteger;
if((DataModuleImmos.taDetailImmoCession_dans_Annee.AsBoolean)or(DataModuleImmos.taDetailImmoRebut.AsBoolean))then
  if ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'))then
  begin
      if Application.MessageBox(Pchar('Cette immobilisation a �t� c�d�e.'+#13+#10+
      'Etes-vous s�r de vouloir la modifier ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
         abort;
  end
  else
  begin
    showmessage('Cette immobilisation a �t� c�d�e, vous ne pouvez pas la modifier');
    abort;
  end;
if DataModuleImmos.taDetailImmo.state <>dsbrowse then abort;
if DataModuleImmos.QuCptUtiliseImmos.RecordCount<>0 then
  Begin
  RxSBImmoMouseLeave(sender);
  ParamAffichageChoixAmortissement.AffichageModal := true;
  ParamAffichageChoixAmortissement.Affiche := true;
  ParamAffichageChoixAmortissement.Quand := C_Mouvement;
  ParamAffichageChoixAmortissement.TypePresentation:=0;
  ParamAffichageChoixAmortissement.TitreForm :='Choix des amortissements';
  ParamAffichageChoixAmortissement.SousTitreForm := CMouvement;
  ParamAffichageChoixAmortissement.QuiAppel:=F_ChoixAmortissement;
  ParamAffichageChoixAmortissement.ImmoCourante:=DataModuleImmos.taDetailImmoID.AsInteger;
  if not ChoixAmortissementAffiche(ParamAffichageChoixAmortissement) then abort;
  End;
finally
VisuImmo.FormActivate(visuImmo);
DataModuleImmos.ReactualiseQuery;
DataModuleImmos.QuCptUtiliseImmos.locate('compte',DataModuleImmos.Compte_DernierCree,[]);
DataModuleImmos.QuRecupImmosSurCpt.Locate('id',DataModuleImmos.ID_DernierCree,[]);
end;

//if ChoixAmortissement.ModalResult in [mrok,mrYes]then
//   begin
//     if not empty(DataModuleImmos.taDetailImmoChoix.asstring) then
//        DataModuleImmos.choix.Complementchoix:=DataModuleImmos.taDetailImmoChoix.AsCurrency
//     else
//        DataModuleImmos.choix.Complementchoix:=DataModuleImmos.taDetailImmoMini.AsCurrency;
//     if DataModuleImmos.taDetailImmo.State=dsbrowse then
//        DataModuleImmos.taDetailImmo.edit;
//   end;
end;

procedure TVisuImmo.TiRecupImmosSurCptTimer(Sender: TObject);
begin
ChangementEtatBoutons(GrDBGrid2.DataSource.DataSet);
terminer1.Visible:=((str_commence_par(GrDBGrid2.DataSource.DataSet.FindField('compte').AsString,'23')
  //and(GrDBGrid2.DataSource.DataSet.FindField('EnCours').AsBoolean=true)
  and(GrDBGrid2.DataSource.DataSet.FindField('Situation').AsString<>'R')
  and( GrDBGrid2.DataSource.DataSet.FindField('Situation').AsString <>'C')));
TiRecupImmosSurCpt.Enabled:=false;
end;


Procedure TVisuImmo.initialiseTableEvent;
Begin
DataModuleImmos.daDetailImmo.OnStateChange:=changementEtatBoutons;
DataModuleImmos.QuCptUtiliseImmos.AfterScroll:=QuCptUtiliseImmosAfterScroll;
DataModuleImmos.QuCptUtiliseImmos.AfterOpen:=QuCptUtiliseImmosAfterOpen;
DataModuleImmos.QuRecupImmosSurCpt.AfterScroll:=QuRecupImmosSurCptAfterScroll;
end;

procedure TVisuImmo.Btn_Historique_immosClick(Sender: TObject);
begin
AffichInfoImmos;
end;

procedure TVisuImmo.Modificationspciale1Click(Sender: TObject);
begin
//appel affichage immos
if ActiveControl=GrDBGrid2 then
  DemandeAffichageAcquisition(true);
end;

procedure TVisuImmo.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

procedure TVisuImmo.terminer1Click(Sender: TObject);
var
compte:string;
idimmos:integer;
begin
try
      compte:=GrDBGrid1.DataSource.DataSet.FindField('compte').AsString;
      idimmos:=GrDBGrid2.DataSource.DataSet.FindField('id').AsInteger;
      GrDBGrid1.DataSource.DataSet.DisableControls;
      GrDBGrid2.DataSource.DataSet.DisableControls;

      Initialise_TInfosImmos(ImmosEnCours);

      ImmosEnCours.Ecriture_Cession:=GrDBGrid2.DataSource.DataSet.FindField('Ecriture_Cession').AsInteger;
      ImmosEnCours.Mt_Cession:=GrDBGrid2.DataSource.DataSet.FindField('Mt_Cession').AsCurrency;
      ImmosEnCours.Date_Cession:=GrDBGrid2.DataSource.DataSet.FindField('Date_Cession').AsDateTime;
      ImmosEnCours.Rebut:=GrDBGrid2.DataSource.DataSet.FindField('Rebut').Asboolean;
      ImmosEnCours.Cession_dans_Annee:=GrDBGrid2.DataSource.DataSet.FindField('Cession_dans_Annee').Asboolean;

      ImmosEnCours.Terminee:=GrDBGrid2.DataSource.DataSet.FindField('Terminee').Asboolean;
      ImmosEnCours.EnCours:=GrDBGrid2.DataSource.DataSet.FindField('EnCours').Asboolean;
      ImmosEnCours.CodeTerminee:=GrDBGrid2.DataSource.DataSet.FindField('CodeTerminee').AsString;
      ImmosEnCours.CompteTerminee:=GrDBGrid2.DataSource.DataSet.FindField('CompteTerminee').AsString;

      try
          FiltrageDataSet(DMRech.TaImmosRech,'id = '''+GrDBGrid2.DataSource.DataSet.findfield('id').AsString+'''');
          if DataModuleImmos.ImmosTerminee(ImmosEnCours) then
          begin
              //result:=((ImmoEnCours.Ecriture_Cession=0)and(ImmoEnCours.Mt_Cession=0)and(ImmoEnCours.Terminee=true)) ;
              DataModuleImmos.InitialisationImmoEnCours(DMRech.TaImmosRech,false);
          end
          else
          begin
              DataModuleImmos.InitialisationImmoEnCours(DMRech.TaImmosRech,true);
          end;
      except
      end;
finally
    DataModuleImmos.taDetailImmo.Refresh;
    ChangementEtatBoutons(GrDBGrid2.DataSource.DataSet);
    GrDBGrid1.DataSource.DataSet.locate('compte',compte,[]);
    GrDBGrid2.DataSource.DataSet.Locate('id',idimmos,[]);
    GrDBGrid1.DataSource.DataSet.EnableControls;
    GrDBGrid2.DataSource.DataSet.EnableControls;
end;
end;

procedure TVisuImmo.CbCessionExoClick(Sender: TObject);
begin
if(CbCessionExo.state=cbchecked)then
begin
 CBExercice.State:=cbunchecked ;
 CBToutesAnnees.State:=cbunchecked;
end
else
if(CBExercice.State=cbunchecked)and (CBToutesAnnees.State=cbunchecked)and (CbCessionExo.state=cbunchecked) then
  CbCessionExo.State:=cbchecked;
GestionCheckbox(true);
EtatInitial;
PaGrilleEnTeteResize(GrDBGrid2);
end;

procedure TVisuImmo.CBToutesAnneesClick(Sender: TObject);
begin
if(CBToutesAnnees.state=cbchecked)then
begin
 CbCessionExo.State:=cbunchecked ;
 CBExercice.State:=cbunchecked;
end
else
if(CBExercice.State=cbunchecked)and (CBToutesAnnees.State=cbunchecked)and (CbCessionExo.state=cbunchecked) then
  CBToutesAnnees.State:=cbchecked;
GestionCheckbox(true);
EtatInitial;
PaGrilleEnTeteResize(GrDBGrid2);
end;

procedure TVisuImmo.CBImmosClick(Sender: TObject);
begin
if (CBSubventions.state=cbunchecked)and(CBImmos.state=cbunchecked) then
 begin //si sub n'est pas enfonc�
   CBSubventions.state:=cbchecked;
 end; //fin si sub n'est pas enfonc�

GestionCheckbox(true);
end;
procedure TVisuImmo.CBExerciceClick(Sender: TObject);
begin
if(CBExercice.state=cbchecked)then
begin
 CbCessionExo.State:=cbunchecked ;
 CBToutesAnnees.State:=cbunchecked;
end
else
if(CBExercice.State=cbunchecked)and (CBToutesAnnees.State=cbunchecked)and (CbCessionExo.state=cbunchecked) then
  CBExercice.State:=cbchecked;
GestionCheckbox(true);
EtatInitial;
PaGrilleEnTeteResize(GrDBGrid2);
end;
procedure TVisuImmo.CBSubventionsClick(Sender: TObject);
begin
if (CBSubventions.state=cbunchecked)and(CBImmos.state=cbunchecked) then
 begin //si sub n'est pas enfonc�
   CBImmos.state:=cbchecked;
 end; //fin si sub n'est pas enfonc�
GestionCheckbox(true);
end;

procedure TVisuImmo.PaToolsTypeResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([CBImmos,CBSubventions],PaToolsType,150,0,5);
end;

procedure TVisuImmo.PaToolsAnneeResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([CBToutesAnnees,CBExercice,CbCessionExo],PaToolsAnnee,150,0,5);
end;

procedure TVisuImmo.GestionCheckbox(Refresh:boolean);
begin
   if (CBImmos.state=cbchecked)and(CBSubventions.state=cbchecked) then
      Begin //si les 2 sont enfonc�s
      DataModuleImmos.QuCptUtiliseImmos.ParamByName('Cpt').asstring:='%';
      DataModuleImmos.QuRecupImmosSurCpt.ParamByName('Cpt').asstring:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
      End
   else
     if (CBSubventions.state=cbchecked)then
        Begin //si seulement sub
        DataModuleImmos.QuCptUtiliseImmos.ParamByName('Cpt').asstring:='131%';
        DataModuleImmos.QuRecupImmosSurCpt.ParamByName('Cpt').asstring:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
        End
     else
       if(CBImmos.state=cbchecked)then
          Begin //si seulement immos
          DataModuleImmos.QuCptUtiliseImmos.ParamByName('Cpt').asstring:='2%';
          DataModuleImmos.QuRecupImmosSurCpt.ParamByName('Cpt').asstring:=DataModuleImmos.QuCptUtiliseImmosCompte.asstring;
          End;

  if CBToutesAnnees.state=cbchecked then
    begin
      RxLabTitre.Caption:='Visualisation de toutes les immobilisations';
      RxLabTitre2.Caption:=CBToutesAnnees.Caption;
      self.tag:=c_immos;
      EditDebutPer.Enabled:=false;
      EditFinPer.Enabled:=false;
      RxSBValidePeriode.Enabled:=false;
      DataModuleImmos.QuCptUtiliseImmos.SQL.Strings[6] :=si_not_rebut;
      if DataModuleImmos.qryTotalCumulImmos.SQL.Count>7 then
      DataModuleImmos.qryTotalCumulImmos.SQL.Delete(7);
      DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateDebut').asdate:=strtodate('01/01/1900');
      DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate:=strtodate('01/01/2900');
//      CBExercice.state:=cbUnchecked;
//      CbCessionExo.state:=cbUnchecked;
    end;

  if CBExercice.state=cbchecked then
     begin
        RxLabTitre.Caption:='Visualisation des immobilisations de l''exercice';
        RxLabTitre2.Caption:=CBExercice.Caption;
        self.Tag:=C_IMMOS;
        EditDebutPer.Enabled:=true;
        EditFinPer.Enabled:=true;
        RxSBValidePeriode.Enabled:=true;
       DataModuleImmos.QuCptUtiliseImmos.SQL.Strings[6] :=si_not_rebut;
       if DataModuleImmos.qryTotalCumulImmos.SQL.Count>7 then
         DataModuleImmos.qryTotalCumulImmos.SQL.Delete(7);
         if EditDebutPer.Date>e.DatExoDebut then
           DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateDebut').asdate:=EditDebutPer.Date
         else
           DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateDebut').asdate:=e.DatExoDebut;
         if EditFinPer.date<e.DatExoFin then
           DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate:=EditFinPer.date
         else
           DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate:=e.DatExoFin;
//      CBToutesAnnees.state:=cbUnchecked;
//      CbCessionExo.state:=cbUnchecked;
    end;
    
if CbCessionExo.state=cbchecked then
   begin
   RxLabTitre.Caption:='Visualisation des Cessions de l''exercice';
   RxLabTitre2.Caption:=CbCessionExo.Caption;
   self.tag:=C_CESSION_EXO;
   DataModuleImmos.QuCptUtiliseImmos.SQL.Strings[6]:='';
   DataModuleImmos.QuCptUtiliseImmos.SQL.Strings[6] :=si_rebut6;
   if DataModuleImmos.qryTotalCumulImmos.SQL.Count<8 then
     DataModuleImmos.qryTotalCumulImmos.SQL.Add(si_rebut8);
//   CBToutesAnnees.Enabled:=false;
        EditDebutPer.Enabled:=true;
        EditFinPer.Enabled:=true;
        RxSBValidePeriode.Enabled:=true;
         if EditDebutPer.Date>e.DatExoDebut then
           DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateDebut').asdate:=EditDebutPer.Date
         else
           DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateDebut').asdate:=strtodate('01/01/1900');
         if EditFinPer.date<e.DatExoFin then
           DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate:=EditFinPer.date
         else
           DataModuleImmos.QuCptUtiliseImmos.ParamByName('DateFin').asdate:=e.DatExoFin;
//      CBToutesAnnees.state:=cbUnchecked;
//      CBExercice.state:=cbUnchecked;
   end;


DataModuleImmos.ReactualiseQuery;

end;
end.



