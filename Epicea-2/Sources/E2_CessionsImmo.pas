unit E2_CessionsImmo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Dmimmos,
  Grids, DBGrids, RXDBCtrl,db,dbtables ,ExRxDBGrid, GrDBGrid, StdCtrls,
  ExtCtrls,Gr_Librairie_Obj, Menus,E2_Decl_Records,E2_Librairie_Obj,
  RXCtrls,LibZoneSaisie, GrGrid,LibSQL,DMEcriture,DMConstantes,
  LibGestionParamXML,
  DMCorrection,
  lib_chaine,
  jpeg;

type

  TParamAffichageCession=record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   QuiAppel:TTypeFenetre;
   TypePresentation:integer; {C_CESSION}
  end;

  TCessionsImmo = class(TForm)
    PaGrListeCessions: TPanel;
    PaGrListeImmos: TPanel;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    GrCessions: TGrDBGrid;
    GrImmosACeder: TGrDBGrid;
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
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaCptIntit: TPanel;
    Panel1: TPanel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    PaCumul2: TPanel;
    Panel7: TPanel;
    GrGrid2: TGrGrid;
    PaCumul1: TPanel;
    Panel3: TPanel;
    GrGrid1: TGrGrid;
    TiFiltrageImmosSurCession: TTimer;
    Procedure CalcSolde;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure GrImmosACederColExit(Sender: TObject);
    procedure GrImmosACederCellClick(Column: TColumn);
    procedure GrImmosACederDblClick(Sender: TObject);
    procedure enregistre;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure changementEtatBoutons(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure PaGrListeCessionsResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure GrCessionsDblClick(Sender: TObject);
    procedure EtatInitial;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Reinitialisation_Immos_SurAnnulation;
    Procedure PositionTotaux;
    procedure BtnImprimerClick(Sender: TObject);
    procedure TiFiltrageImmosSurCessionTimer(Sender: TObject);
    Procedure GestionInitDM;
    Procedure GereAccesEcran;
    procedure FormShow(Sender: TObject);
    procedure GrImmosACederKeyPress(Sender: TObject; var Key: Char);
    procedure GrImmosACederKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrImmosACederColEnter(Sender: TObject);
    procedure GrImmosACederEnter(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    TitreForm,SousTitreForm:String;
    Quand:Integer;
    { Déclarations publiques }
    
  end;

var
  CessionsImmo: TCessionsImmo;
  
  Function CessionAffiche(ParamAffichageCession:TParamAffichageCession):boolean;

implementation

uses DMPiece, E2_Main, DMImmo_Clot, LibClassObjetSenders, E2_AideCompte;

{$R *.DFM}


Function CessionAffiche(ParamAffichageCession:TParamAffichageCession):boolean;
var
ParamDMImmos:TParamDMImmos;
Begin
try
 if (CessionsImmo = nil) then CessionsImmo:=TCessionsImmo.Create(Application.MainForm);
 if ((ParamAffichageCession.Quand <> CessionsImmo.Quand) and (CessionsImmo.Visible=true)) then
   CessionsImmo.Close;
 CessionsImmo.Quand:=ParamAffichageCession.Quand;
 ////
 CessionsImmo.Tag:=ParamAffichageCession.TypePresentation;
// {C_ACQUISITION_Terminee,C_ACQUISITION_En_Cours,C_ACQUISITION_Simple}
// {C_DESCRIPTION_terminee,C_DESCRIPTION_Simple,C_DESCRIPTION_En_Cours}
 ///
 if not empty(ParamAffichageCession.TitreForm) then
   CessionsImmo.TitreForm:=ParamAffichageCession.TitreForm;
 CessionsImmo.SousTitreForm:=ParamAffichageCession.SousTitreForm;

 ///etatinitial(mise à zéro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 // ParamDMImmos.ImmoCourante:=ParamAffichageCession.ImmoCourante;
 ParamDMImmos.ImmosDataStateChange := CessionsImmo.changementEtatBoutons;
 ParamDMImmos.ImmosAfterScroll:=nil;
 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.TypePresentation:=ParamAffichageCession.TypePresentation;
 ParamDMImmos.Quand := CessionsImmo.Quand;
 ParamDMImmos.QuiAppel:=ParamAffichageCession.QuiAppel;
   case CessionsImmo.Quand of
      C_mouvement:Begin
                   if not InitialiseDMImmos(ParamDMImmos).retour then abort;
                  End;
   end;
 if ParamAffichageCession.Affiche then
  begin
     //differentes zones de description de l'immo selectionnée
     CessionsImmo.GrCessions.DataSource:=DataModuleImmos.dsListeAcquis;
     CessionsImmo.GrImmosACeder.DataSource:=DataModuleImmos.DaImmos_A_Ceder;

   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);

     if ParamAffichageCession.AffichageModal then
       CessionsImmo.ShowModal
      else
       CessionsImmo.Show;
  End;
except
  result:=false;
end;
End;

Procedure TCessionsImmo.GestionInitDM;
var
ParamDMImmos:TParamDMImmos;
Begin
try
///etatinitial(mise à zéro)
Initialise_ParamDMimmos(ParamDMImmos);
////fin etatInitial

 ParamDMImmos.QuiAppel:=F_Cession;
 ParamDMImmos.TypePresentation:=Tag;

 ParamDMImmos.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ParamDMImmos.ImmosDataStateChange := changementEtatBoutons;
 ParamDMImmos.ImmosAfterScroll:=nil;
 ParamDMImmos.Quand := CessionsImmo.Quand;
 ParamDMImmos.TypePresentation:=tag;
// ParamDMImmos.ImmoCourante := CessionsImmo.ImmoCourante;

 if not InitialiseDMImmos(ParamDMImmos).retour then abort;
except
  MessageDlg('Problème rencontré lors de l''initialisation du DataModule'+#13+#10+'des immobilisations', mtWarning, [mbOK], 0);
end;
End;

Procedure TCessionsImmo.GereAccesEcran;
begin
  case Quand of
     C_Mouvement:Begin
                   GrImmosACeder.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                   GrImmosACeder.FSauteColReadOnly := not GrImmosACeder.ReadOnly;
                   GrCessions.ReadOnly := ((not E.AccesCloture)or(DataModuleImmos.verrouillage));
                   GrCessions.FSauteColReadOnly := not GrCessions.ReadOnly;
                   EnableWinControl([BtnModifier,BtnEnregistrer], not E.AccesCloture);
                   EnableItemMenu([Modifier1,Enregister1],not E.AccesCloture);
                 End;  end;
DataModuleImmos.GestionAccesImmos;
end;



Procedure TCessionsImmo.CalcSolde;
var
TotauxListeAcquis:TTotauxGeneric;
DatasetTmp:TDataSet;
Begin
  try
  DatasetTmp:=CloneDataSet(DataModuleImmos.qryListeAcquis,nil);
  TotauxListeAcquis:=SommeTotauxGeneric(['Debit','Credit'],DatasetTmp);

  GrGrid1.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total1);
  GrGrid1.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total2);

  DatasetTmp:=CloneDataSet(DataModuleImmos.taImmos_A_Ceder,nil);
  TotauxListeAcquis:=SommeTotauxGeneric(['Valeur_a_Amortir','Mt_Cession'],DatasetTmp);
  GrGrid2.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total1);
  GrGrid2.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total2);
  finally
    DatasetTmp.free;
  end;
End;

procedure TCessionsImmo.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
//GestionInitDM;  pas besoin car l'écran est en showmodal { isa  le  02/02/04 }

//  DataModuleImmos.daImmos_A_Ceder.OnStateChange:=changementEtatBoutons;
//  DataModuleImmos.daImmos_A_Ceder.OnStateChange(DataModuleImmos.TaImmos_A_Ceder);

  GrCessions.ParamColor:=true;
  GrCessions.Param:=ParamUtil.CouleurDBGrid;
  GrCessions.UpDateColor;
  GrCessions.Refresh;

  GrImmosACeder.ParamColor:=true;
  GrImmosACeder.Param:=ParamUtil.CouleurDBGrid;
  GrImmosACeder.UpDateColor;
  GrImmosACeder.Refresh;

  CalcSolde;
GereAccesEcran;
end;

procedure TCessionsImmo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
KeyTmp:char;
Valide:TErreurSaisie;
visible:boolean;
begin
if key=vk_return then
  Begin
    GrCessionsDblClick(GrCessions);
    key:=0;
  End;
if Shift=[] then WinSuivPrec(Handle,key,[GrCessions,GrImmosACeder]);

   If Key = VK_ESCAPE Then
   Begin//si annulé ou échappe
     If DataModuleImmos.TaImmos_A_Ceder.State in [dsinactive,dsBrowse] Then
        begin//si en consultation
           if DataModuleImmos.ModificationImmo_A_Ceder then
             Begin//si modification constatée
                If Messagedlg('Annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mrno Then
                   abort
                else
                   Reinitialisation_Immos_SurAnnulation;
             End//fin si modification constatée
           else
             begin
                 visible:=PaGrListeImmos.visible;
                 EtatInitial;
                 changementEtatBoutons(DataModuleImmos.DaImmos_A_Ceder);
                 if not visible then
                   Self.Close ;
             end;
        end;//fin si en consultation

     If DataModuleImmos.TaImmos_A_Ceder.State = dsEdit Then
     Begin//si en modification
        If Messagedlg('Voulez-vous annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
          Begin //si on annule
            DataModuleImmos.TaImmos_A_Ceder.Cancel;
            //Reinitialisation_Immos_SurAnnulation;
            //changementEtatBoutons(DataModuleImmos.DaImmos_A_Ceder);
            //EtatInitial;
          end //fin on annule
        else
         abort;
     End;//fin si en modification
   End;//fin si annulé ou échappe
end;

procedure TCessionsImmo.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TCessionsImmo.BtnEnregistrerClick(Sender: TObject);
begin
try
enregistre;
except
  if GrImmosACeder.CanFocus then
    GrImmosACeder.SetFocus;
end;
end;


procedure TCessionsImmo.enregistre;
var
i:integer;
Begin
try//finally
  try//except
     if DataModuleImmos.TaImmos_A_Ceder.state in [dsedit,dsinsert] then
       Begin
         DataModuleImmos.TaImmos_A_Ceder.BeforePost:=DataModuleImmos.TaImmos_A_CederBeforePost_Simple;
         tablegerePost(DataModuleImmos.TaImmos_A_Ceder);
         DataModuleImmos.TaImmos_A_Ceder.BeforePost:=DataModuleImmos.TaImmos_A_CederBeforePost;
       end;
     if ((not (DataModuleImmos.TaImmos_A_Ceder.state in [dsedit,dsinsert]))and(DataModuleImmos.ListMtACeder.count<>0))then
      begin
         if not (DataModuleImmos.TaImmos_A_Ceder.state in [dsedit,dsinsert]) then
           DataModuleImmos.TaImmos_A_Ceder.Locate('id',StrToInt_Lgr(DataModuleImmos.ListMtACeder.strings[0]),[]);
         DataModuleImmos.TaImmos_A_Ceder.Edit;
      end;
     DataModuleImmos.InfosCession.Ecriture_Cession:=DataModuleImmos.qryListeAcquisID.Asinteger;
     TableGerePost(DataModuleImmos.TaImmos_A_Ceder);
  except
     DataModuleImmos.TaImmos_A_Ceder.cancel;
     Reinitialisation_Immos_SurAnnulation;
  end;//fin du try except
finally
  DataModuleImmos.TaImmos_A_Ceder.BeforePost:=DataModuleImmos.TaImmos_A_CederBeforePost;
  etatinitial;
end;//fin du try except
End;


procedure TCessionsImmo.FormCreate(Sender: TObject);
begin
  try
       if DataModuleImmos=nil then
        DataModuleImmos:=TDataModuleImmos.Create(self);
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

Procedure TCessionsImmo.InitialiseTable_A_Nil;
Begin
// DataModuleImmos.daImmos_A_Ceder.OnStateChange:=nil;
if DataModuleImmos<>nil then
 InitDatasetEvent_A_Nil_Sur_Form([DataModuleImmos.daImmos_A_Ceder]);
End;

procedure TCessionsImmo.FormDestroy(Sender: TObject);
begin
 InitialiseTable_A_Nil;
 LibGestionParamXML.DestroyForm(Self,E.User);
if DataModuleImmos<>nil then  DataModuleImmos.Free;
 CessionsImmo := Nil;
end;

procedure TCessionsImmo.GrImmosACederColExit(Sender: TObject);
var
Valide:TErreurSaisie;
begin
  if GrImmosACeder.DataSource.State=dsedit then
    begin
    Valide:=DataModuleImmos.CtrlSaisieCessions(GrImmosACeder.SelectedField);
    if Valide.Retour=false then
         case Valide.CodeErreur of
         22001:begin
                abort;//champ Montant Cession
               end;
         23001:begin
                abort;//champ Date Cession
               end;
         26001:begin
                abort;//champ A Céder
               end;
         end;//fin du case
    end;
end;

procedure TCessionsImmo.GrImmosACederCellClick(Column: TColumn);
begin
if column.Index = 8 then
GrImmosACederColExit(grimmosAceder);
end;

procedure TCessionsImmo.GrImmosACederDblClick(Sender: TObject);
begin
DataModuleImmos.TaImmos_A_Ceder.Edit;
DataModuleImmos.TaImmos_A_CederCession_dans_Annee.Value:=not DataModuleImmos.TaImmos_A_CederCession_dans_Annee.AsBoolean;
GrImmosACeder.SelectedIndex:=8;
GrImmosACederCellClick(GrImmosACeder.Columns[8]);
end;

procedure TCessionsImmo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
DataModuleImmos.TaImmos_A_Ceder.Close;
end;



procedure TCessionsImmo.changementEtatBoutons(Sender: TObject);
begin
  TiFiltrageImmosSurCession.Enabled:=true;
end;

procedure TCessionsImmo.BtnModifierClick(Sender: TObject);
begin
DataModuleImmos.TaImmos_A_Ceder.edit;
end;

procedure TCessionsImmo.BtnFermerClick(Sender: TObject);
begin
Self.Close;
end;

procedure TCessionsImmo.PaGrListeCessionsResize(Sender: TObject);
begin
FormateTailleColonne(GrCessions,12,[2,2,3,2,2]);
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
FormateTailleColonne(GrImmosACeder,20,[2,1,2,3,2,2,2,2,1]);
PositionTotaux;
end;

procedure TCessionsImmo.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TCessionsImmo.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue (sender as TButton);
end;

procedure TCessionsImmo.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit (sender as TButton);
end;

procedure TCessionsImmo.Visualisation1Click(Sender: TObject);
begin
if ActiveControl = GrCessions then
 Begin
   DetailEcritureCompte(DataModuleImmos.qryListeAcquis.findfield('compte').ASString,true,False);
 End;

if ActiveControl = GrImmosACeder then
 Begin
   DetailEcritureCompte(DataModuleImmos.taImmos_A_Ceder.findfield('compte').ASString,true,False);
 End;

end;

procedure TCessionsImmo.GrCessionsDblClick(Sender: TObject);
var
ID:integer;
begin
try
if DataModuleImmos.qryListeAcquis.recordcount=0 then abort;
ID:=DataModuleImmos.qryListeAcquisID.Asinteger;
FiltrageDataSet(DataModuleImmos.qryListeAcquis,'ID = '+inttostr(ID));
//tablegerepost(DataModuleImmos.TaImmos_A_Ceder);
if (DataModuleImmos.TaImmos_A_Ceder.State in [dsedit,dsinsert]) then abort;
//FiltrageDataSet(DataModuleImmos.TaImmos_A_Ceder,'((Ecriture_Cession =null)or(Ecriture_Cession =0)) and not compte =''131*'' and Date_Cession=null and rebut=faux');
//{ isa  le  26/01/04 }
//FiltrageDataSet(DataModuleImmos.TaImmos_A_Ceder,'((((Ecriture_Cession =null)or(Ecriture_Cession =0))and (cession_dans_annee=vrai))or(((Ecriture_Cession =null)or(Ecriture_Cession =0))and (Date_cession is null))) and not compte =''23*'' and not compte =''131*'' and rebut=faux ');PaGrListeImmos.Visible:=true;
{ isa  le  24/09/04 }
FiltrageDataSet(DataModuleImmos.TaImmos_A_Ceder,'((((Ecriture_Cession =null)or(Ecriture_Cession =0))and (cession_dans_annee=vrai))or(((Ecriture_Cession =null)or(Ecriture_Cession =0))and (Date_cession is null))) and not compte =''131*'' and rebut=faux and Terminee=faux and id<>-1');
PaGrListeImmos.Visible:=true;
PaCptIntit.Visible:=true;
PaCumul2.visible:=true;
if GrImmosACeder.CanFocus then
  begin
    GrImmosACeder.SetFocus;
    GrImmosACeder.col:= 9;
  end;
changementEtatBoutons(DataModuleImmos.DaImmos_A_Ceder);
PaGrListeCessionsResize(PaGrListeCessions);
CalcSolde;
except
  abort;
end;
end;


procedure TCessionsImmo.EtatInitial;
Begin//si
  Initialise_TInfosCession(DataModuleImmos.infosCession);
  DataModuleImmos.Filtrage_qryListeAcquis_SurTag(tag,false,-1,'');
  PaGrListeImmos.Visible:=false;
  if DataModuleImmos.ListMtACeder=nil then
  DataModuleImmos.ListMtACeder:=tstringlist.Create;
  DataModuleImmos.ListMtACeder.clear;
  PaCptIntit.Visible:=false;
  PaCumul2.visible:=false;
  GrCessions.SetFocus;
  DataModuleImmos.ModificationImmo_A_Ceder:=false;
  PositionTotaux;
  CalcSolde;
End;//fin si             


procedure TCessionsImmo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
canclose:=true;
  If DataModuleImmos.TaImmos_A_Ceder.State = dsBrowse Then
     begin//si en consultation
        if DataModuleImmos.ModificationImmo_A_Ceder then
          Begin//si modification constatée
            self.WindowState:=wsNormal;
            self.BringToFront;
             If Messagedlg('Annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mrno Then
                abort
             else
                DataModuleImmos.ModificationImmo_A_Ceder:=false;
          End;//fin si modification constatée
        EtatInitial;
     end;//fin si en consultation

  If DataModuleImmos.TaImmos_A_Ceder.State = dsEdit Then
  Begin
       if BtnEnregistrer.Enabled then
         Begin//si enregistrement possible
            self.WindowState:=wsNormal;
            self.BringToFront;
            If Messagedlg('Voulez-vous enregistrer les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
              Begin
                if not DataModuleImmos.CtrlSaisieCessions(DataModuleImmos.TaImmos_A_CederCession_dans_Annee).retour then
                   CanClose:=false
                else
                  begin
                    enregistre;
                    EtatInitial;
                  end;
              end//fin si on enregistre
            else
              begin
                Reinitialisation_Immos_SurAnnulation;
                DataModuleImmos.TaImmos_A_Ceder.Cancel;
                EtatInitial;
                CanClose:=true;
              end;
         End//fin si enregistrement possible
       else
         Begin//si pas d'enregistrement possible
          self.WindowState:=wsNormal;
          self.BringToFront;
            If Messagedlg('Voulez-vous annuler les modifications de cette immobilisation ?',Mtconfirmation,[mbyes,mbno],0) = mryes Then
              Begin //si on annule
                Reinitialisation_Immos_SurAnnulation;
                DataModuleImmos.TaImmos_A_Ceder.Cancel;
                EtatInitial;
              end //fin on annule
            else
             canclose:=false;
         End;//fin si pas d'enregistrement possible
  End;//fin si en modification
if canclose then InitialiseTable_A_Nil; { isa  le  29/01/04 }
except
  canclose:=false;
end;
end;



procedure TCessionsImmo.Reinitialisation_Immos_SurAnnulation;
var
i:integer;
Begin//si
   DataModuleImmos.TaImmos_A_Ceder.DisableControls;
   DataModuleImmos.TaImmos_A_Ceder.first;
   DataModuleImmos.TaImmos_A_Ceder.BeforePost:=nil;
//   while not (DataModuleImmos.TaImmos_A_Ceder.EOF)do
//     begin//
//        if DataModuleImmos.TaImmos_A_CederCession_dans_Annee.AsBoolean then
//          begin
//            DataModuleImmos.TaImmos_A_Ceder.edit;
//            DataModuleImmos.TaImmos_A_CederCession_dans_Annee.AsBoolean:=false;
//            DataModuleImmos.TaImmos_A_CederMt_Cession.AsCurrency:=0;
//          end;
//        DataModuleImmos.TaImmos_A_Ceder.post;
//        DataModuleImmos.TaImmos_A_Ceder.next;
//     end;//si du while DataModuleImmos.TaImmos_A_Ceder
     for i:=0 to DataModuleImmos.ListMtACeder.count-1 do
       begin
         if DataModuleImmos.TaImmos_A_Ceder.locate('id',DataModuleImmos.ListMtACeder.strings[i],[])then
           begin
             DataModuleImmos.TaImmos_A_Ceder.Edit;
             DataModuleImmos.InitialiserCession;
             tablegerePost(DataModuleImmos.TaImmos_A_Ceder);
           end;
       end;
//   CorrectionImmos_SurCession(e.DatExoDebut,e.DatExoFin,false);
   DataModuleImmos.TaImmos_A_Ceder.beforePost:=DataModuleImmos.TaImmos_A_CederbeforePost;
   DataModuleImmos.TaImmos_A_Ceder.Refresh;
   DataModuleImmos.TaImmos_A_Ceder.enableControls;
   DataModuleImmos.ModificationImmo_A_Ceder:=false;
End;//fin si


Procedure TCessionsImmo.PositionTotaux;
Begin
   Panel3.Width:=RenvoiTailleColonne(GrCessions,[0,1,2,3])+10;
   GrGrid1.ColWidths[0]:=RenvoiTailleColonne(GrCessions,[4]);
   GrGrid1.ColWidths[1]:=RenvoiTailleColonne(GrCessions,[5]);

   Panel7.Width:=RenvoiTailleColonne(GrImmosACeder,[0,1,2,3,4,5])+10;
   GrGrid2.ColWidths[0]:=RenvoiTailleColonne(GrImmosACeder,[6]);
   GrGrid2.ColWidths[1]:=RenvoiTailleColonne(GrImmosACeder,[7]);
End;

procedure TCessionsImmo.BtnImprimerClick(Sender: TObject);
begin
GrImmosACeder.ReportCaption:='Liste des immos à céder';
GrImmosACeder.GridPreview;
end;

procedure TCessionsImmo.TiFiltrageImmosSurCessionTimer(Sender: TObject);
begin
  try
      if PaGrListeImmos.Visible then
        Begin//si
          btnFermer.Enabled:=false;
        End//fin si
      else
        Begin//si
          btnFermer.Enabled:=true;
        End;//fin si
          case DataModuleImmos.TaImmos_A_Ceder.state of
           dsBrowse: begin
                       BtnInserer.Enabled := false;
                       BtnEnregistrer.Enabled := False;
                       BtnModifier.Enabled := DataModuleImmos.TaImmos_A_Ceder.RecordCount<>0;
                       BtnSupprimer.Enabled :=false;
                       BtnImprimer.Enabled:=true;
                       End; // Fin du case sur le Tag de la fenêtre
           dsEdit:   begin
                       BtnInserer.Enabled := False;
                       BtnEnregistrer.Enabled := True;
                       BtnModifier.Enabled :=false;
                       BtnSupprimer.Enabled := false;
                       BtnImprimer.Enabled:=false;
                       if not DataModuleImmos.ModificationImmo_A_Ceder then
                         DataModuleImmos.ModificationImmo_A_Ceder:=true;
                       End; // Fin du case sur le Tag de la fenêtre
           dsInsert: begin
                       BtnInserer.Enabled := False;
                       BtnEnregistrer.Enabled := False;
                       BtnModifier.Enabled := False;
                       BtnSupprimer.Enabled := False;
                       BtnImprimer.Enabled:=false;
                       if not DataModuleImmos.ModificationImmo_A_Ceder then
                         DataModuleImmos.ModificationImmo_A_Ceder:=true;
                       End; // Fin du case sur le Tag de la fenêtre
           end;//fin du case.state$

         //Pop-up Menu
         BtnEnregistrer.Enabled:=DataModuleImmos.ModificationImmo_A_Ceder;
         Fermer1.Enabled:=BtnFermer.Enabled;
         Insrer1.Enabled:=BtnInserer.Enabled;
         Enregister1.Enabled:=BtnEnregistrer.Enabled;
         Modifier1.Enabled:=BtnModifier.Enabled;
         Supprimer1.Enabled:=BtnSupprimer.Enabled;
         Imprimer1.Enabled:=BtnImprimer.Enabled;
  finally
    TiFiltrageImmosSurCession.Enabled:=false;
    ReEnableControls(DataModuleImmos.TaImmos_A_Ceder);
  end;

end;

procedure TCessionsImmo.FormShow(Sender: TObject);
begin
EtatInitial;
end;

procedure TCessionsImmo.GrImmosACederKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#32 then key:=#0;
end;

procedure TCessionsImmo.GrImmosACederKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SPACE then
      begin
        key:=0;
        GrImmosACederDblClick(GrImmosACeder);
      end;

end;

procedure TCessionsImmo.GrImmosACederColEnter(Sender: TObject);
begin
if GrImmosACeder.Col = 9 then
begin
   GrImmosACeder.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit];
   if GrImmosACeder.InplaceEditor <> nil then
                    GrImmosACeder.EditorMode:=false;
end
else
begin
   GrImmosACeder.Options:=[dgEditing, dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgAlwaysShowSelection,dgConfirmDelete,dgCancelOnExit];
   if GrImmosACeder.InplaceEditor <> nil then
                    GrImmosACeder.EditorMode:=true;
end;
end;

procedure TCessionsImmo.GrImmosACederEnter(Sender: TObject);
begin
GrImmosACeder.Col:=9;
GrImmosACeder.ColEnter;
end;

procedure TCessionsImmo.Calculatrice1Click(Sender: TObject);
begin
if(GrImmosACeder.col =7) then
begin
  TableGereEdit(GrImmosACeder.DataSource.DataSet);
  AfficheCalculatrice(GrImmosACeder);
end
else
  AfficheCalculatrice(nil);
end;

end.
