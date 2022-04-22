{***************************************************************
 *
 * Unit Name: E2_GenerCpt
 * Purpose  :
 * Author   :  Assemat
 * History  :
 *
 ****************************************************************}

unit E2_GenerCpt_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj, Buttons, Grids, DBGrids,
  ExtCtrls, Db, DBTables, RXDBCtrl, ExRxDBGrid, GrDBGrid,E2_AideTva,LibZoneSaisie,
  RXCtrls,E2_Decl_Records,DMConstantes,
  LibRessourceString,
  LibGestionParamXML, jpeg;

type
  TParamGenerCptAffiche = record
  Affiche:Boolean;
  DataSourceGrille:TDataSource;
  CompteGenerateur:String;
  end;

  TGenerCpt_PM = class(TForm)
    PaGrille: TPanel;
    GrilleCptGene: TGrDBGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    MenuItem1: TMenuItem;
    Aide1: TMenuItem;
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
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    procedure AideEnLigne(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GrilleCptGeneColEnter(Sender: TObject);
    procedure GrilleCptGeneColExit(Sender: TObject);
    procedure BtFermerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChangementEtatGrille;
    procedure changementEtatBoutons(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PaGrilleResize(Sender: TObject);
    procedure TaPlanCptAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    CompteGenere : String;
  end;


var
  GenerCpt_PM: TGenerCpt_PM;
  Function GenerCptAffiche(ParamGenerCptAffiche:TParamGenerCptAffiche):Boolean;

implementation
{$R *.DFM}
Uses E2_Librairie_obj,
  //Gr_Calculatrice,
  LibSQL, DMPlanCpt,
  E2_Main, DMAide, E2_AideAssist;



Function GenerCptAffiche(ParamGenerCptAffiche:TParamGenerCptAffiche):Boolean;
Begin
   if (GenerCpt_PM = nil) then GenerCpt_PM:=TGenerCpt_PM.Create(Application.MainForm);
   if ParamGenerCptAffiche.Affiche then
    begin
     GenerCpt_PM.GrilleCptGene.DataSource:=ParamGenerCptAffiche.DataSourceGrille;
     GenerCpt_PM.CompteGenere:=ParamGenerCptAffiche.CompteGenerateur;
     GenerCpt_PM.Showmodal;
    end;

End;


//****************************************************************************//
// Procédure AideEnLigne.                                                     //
//****************************************************************************//
procedure TGenerCpt_PM.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except
end;
end;
//****************************************************************************//


procedure TGenerCpt_PM.Calculatrice1Click(Sender: TObject);
begin
	AfficheCalculatrice(nil);
end;


procedure TGenerCpt_PM.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;


Procedure TGenerCpt_PM.InitialiseTable_A_Nil;
Begin
if DMPlan<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMPlan.DaCompteGenere,DMPlan.TaCompteGener]);
End;

procedure TGenerCpt_PM.FormDestroy(Sender: TObject);
begin
  InitialiseTable_A_Nil;
  LibGestionParamXML.DestroyForm(Self,E.USer);
  GenerCpt_PM:=nil;
end;


procedure TGenerCpt_PM.pmMenu1Click(Sender: TObject);
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

// Gestion de l'activation de la fenêtre
procedure TGenerCpt_PM.FormActivate(Sender: TObject);
begin
try
 if main <> nil then
  begin
   Initialiser_ShortCut_Main(true);
   Patitre.visible:=Main.AfficheTitre;
  end;
    GrilleCptGene.ParamColor:=true;
    if paramUtil <> nil then
      GrilleCptGene.Param:=ParamUtil.CouleurDBGrid;
    GrilleCptGene.UpDateColor;
  //  GrilleCptGene.FSauteColReadOnly:=true;
  //  GrilleCptGene.SelectedIndex:=1;
    GrilleCptGene.DataSource.OnStateChange:=changementEtatBoutons;
    DMPlan.TaCompteGener.AfterScroll:=TaPlanCptAfterScroll;
  case DMPlan.DaCompteGenere.State of
     dsBrowse:begin
                DMPlan.TaCompteGener.AfterScroll(DMPlan.TaCompteGener);
              end;
     dsInsert,dsEdit: ;
  end;
    GrilleCptGene.FirstColActivable;
  //  GrilleCptGene.SetFocus;
    GrilleCptGene.DataSource.DataSet.Edit;
  //  GrilleCptGeneColEnter(GrilleCptGene);
except
 showmessage(ErrInterne+'GenerCpt_PM.FormActivate');
end;
end;

procedure TGenerCpt_PM.changementEtatBoutons(Sender: TObject);
begin
  case  GrilleCptGene.DataSource.DataSet.State of
   dsBrowse: begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := true;
               BtnSupprimer.Enabled := False;
               BtnImprimer.Enabled:=true;
             end;

   dsEdit:   begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := True;
               BtnModifier.Enabled := false;
               BtnSupprimer.Enabled := False;
               BtnImprimer.Enabled:=false;
             end;

   dsInsert: begin
               BtnInserer.Enabled := False;
               BtnEnregistrer.Enabled := False;
               BtnModifier.Enabled := False;
               BtnSupprimer.Enabled := False;
               BtnImprimer.Enabled:=false;
             end;
   end;//fin du case.state$
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
//   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   Imprimer1.Enabled:=BtnImprimer.Enabled;
   ChangementEtatGrille;
end;


procedure TGenerCpt_PM.ChangementEtatGrille;
begin
   case  GrilleCptGene.DataSource.DataSet.State of
   dsBrowse: begin
               GrilleCptGeneColEnter(GrilleCptGene);
               GrilleCptGene.SetFocus;
               if GrilleCptGene.InplaceEditor <> nil then
                  GrilleCptGene.EditorMode:=false;
               GrilleCptGene.TitreColor(true);
               self.caption:='Comptes Générés à partir du compte : '+CompteGenere+' - Consultation';
             end;

   dsEdit:   begin
               GrilleCptGeneColEnter(GrilleCptGene);
               GrilleCptGene.SetFocus;
               GrilleCptGene.TitreColor(true);
               self.caption:='Comptes Générés à partir du compte : '+CompteGenere+' - Modification';
             end;

   dsInsert: begin
               GrilleCptGene.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               GrilleCptGene.SetFocus;
               GrilleCptGene.TitreColor(true);
               self.caption:='Comptes Générés à partir du compte : '+CompteGenere+' - Insertion';
             end;
   end;//fin du case.state
end;

// Gestion de l'entrée dans les différentes colonnes
procedure TGenerCpt_PM.GrilleCptGeneColEnter(Sender: TObject);
begin
case GrilleCptGene.DataSource.DataSet.State  of
  dsBrowse:Begin
             GrilleCptGene.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
             case GrilleCptGene.SelectedIndex of
                0:begin
//                   messagedlg('Vous ne pouvez pas modifier le numéro de compte', mtwarning, [mbok],0);
                   GrilleCptGene.SelectedIndex:=1;
                  end;
           End;
           end;
  dsEdit:Begin
          case GrilleCptGene.SelectedIndex of
             0:begin
                messagedlg('Vous ne pouvez pas modifier le numéro de compte', mtwarning, [mbok],0);
                GrilleCptGene.SelectedIndex:=1;
               end;
             1..4:GrilleCptGene.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
             5..10:GrilleCptGene.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
          end;
         End;
end;
end;

// Permet de gérer la sortie des colonnes
procedure TGenerCpt_PM.GrilleCptGeneColExit(Sender: TObject);
var
RetCre:TErreurSaisie;
begin
GrilleCptGene.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
 if GrilleCptGene.DataSource.DataSet.State in [dsEdit] then
 begin
  retCre:=DMPlan.ModificationCpt(GrilleCptGene.SelectedField);
  if not retCre.Retour then
   begin
    case retCre.CodeErreur of
       1000:begin
                  GrilleCptGene.SelectedIndex:=1;
                  abort;
                 end;
       4001,4002:begin
                   GrilleCptGene.EditorMode:=true;
                   if not AideTvaAffiche(GrilleCptGene,DMPlan.DaCompteGenere.dataset.findfield('compte').AsString) then
                      begin
                        abort;
                      end;
                 end;
  end;
  end;
  end;
end;

// Fermeture de la fenêtre quand l'utilisateur clique sur le bouton Fermer
procedure TGenerCpt_PM.BtFermerClick(Sender: TObject);
begin
     Self.Close;
end;

procedure TGenerCpt_PM.FormCreate(Sender: TObject);
begin
GrilleCptGene.FSauteColReadOnly:=true;
    try
	LibGestionParamXML.InitialiseForm(E.USer,Self);
        ScreenAjuste_OldDef_DefinitionCourant(ParamUtil.OldScreenWidth,ParamUtil.OldScreenHeight,self);
    except
        Position:=poDesigned;
        InitialiseFormPosDefaut(self);
        ScreenAjuste_OldDef_DefinitionCourant(ParamUtil.OldScreenWidth,ParamUtil.OldScreenHeight,self);
//	Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
end;

procedure TGenerCpt_PM.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TGenerCpt_PM.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TGenerCpt_PM.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
canclose:=true;
if GrilleCptGene.DataSource.State = dsEdit then
  TableGerePost(GrilleCptGene.DataSource.dataset);
GrilleCptGene.DataSource.OnStateChange:=nil;
GrilleCptGene.OnColEnter:=nil;
InitialiseTable_A_Nil;{ isa  le  29/01/04 }
except
//  canclose:=false
end;
end;

procedure TGenerCpt_PM.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(GrilleCptGene,22,[2,6,1,1,2,2,2,1,1,1,1]);
  try
   if main <> nil then
    WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
  except

  end;
end;

procedure TGenerCpt_PM.TaPlanCptAfterScroll(DataSet: TDataSet);
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
             for i:=1 to GrilleCptGene.Columns.Count - 1 do
                 begin
                  GrilleCptGene.Columns[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(GrilleCptGene.Columns[i].FieldName) = - 1);
                 end;
            DMPlan.CompteAJournal:=((DMPlan.ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'],nil)));
            end;

   dsEdit:begin
            DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
            for i:=1 to GrilleCptGene.Columns.Count - 1 do
                begin
                 GrilleCptGene.Columns[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(GrilleCptGene.Columns[i].FieldName) = - 1);
                end;
           DMPlan.CompteAJournal:=((DMPlan.ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'],nil)));
            end;
   dsInsert:begin
            DataSet.FindField('Compte').ReadOnly:=False;
            if not empty(CptTmp) then
            begin
              DMPlan.ChampObligatoire(CptTmp,DMPlan.ListeChampOblig);
              for i:=1 to GrilleCptGene.Columns.Count - 1 do
                  begin
                   GrilleCptGene.Columns[i].ReadOnly:=(DMPlan.ListeChampOblig.IndexOf(GrilleCptGene.Columns[i].FieldName) = - 1);
                  end;
             DMPlan.CompteAJournal:=((DMPlan.ListeCompteJournaux.IndexOf(CptTmp) <> -1)  and (DMPlan.CompteValideDansParamContexte(CptTmp,false,['Rac1'],nil)));
             end;
            end;
 end;
end;

procedure TGenerCpt_PM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If ((key = VK_ESCAPE) and (not(DMPlan.DaCompteGenere.State in [dsEdit,dsInsert]))) Then
 begin
   Self.Close;
   key:=0;
 end;
end;

procedure TGenerCpt_PM.FormShow(Sender: TObject);
begin
GrilleCptGene.OnColEnter:=GrilleCptGeneColEnter;
end;

procedure TGenerCpt_PM.BtnEnregistrerClick(Sender: TObject);
begin
if DMPlan.DaCompteGenere.State in [dsEdit,dsInsert] then
TableGerePost(DMPlan.DaCompteGenere.DataSet)
else
self.Close;
end;

procedure TGenerCpt_PM.BtnModifierClick(Sender: TObject);
begin
DMPlan.DaCompteGenere.DataSet.Edit;
end;

procedure TGenerCpt_PM.BtnImprimerClick(Sender: TObject);
begin
GrilleCptGene.ReportCaption:='Comptes Générés à partir du compte : '+CompteGenere;
GrilleCptGene.GridPreview;
end;

procedure TGenerCpt_PM.Aide1Click(Sender: TObject);
begin
 If activecontrol = GrilleCptGene Then
  begin
   case GrilleCptGene.DataSource.State of
      dsbrowse:begin
//                   case DBGrid1.SelectedIndex of
//                        0:Rechercher(DBGrid1,DMProvisions.TaProvision,['Designation','DateSaisie','ID','Compte'],['Désignation','','',''],'',0);
//                    end;
//                  2:case DBProv.SelectedIndex of
//                      0:Rechercher(DBGrid1,DMProvisions.TaProvision,['Reference','Designation','ID','DateSaisie','Compte'],['Réference','Désignation','','',''],'',0);
//                      1:Rechercher(DBGrid1,DMProvisions.TaProvision,['Designation','Reference','DateSaisie','ID','Compte'],['Désignation','Réference','','',''],'',0);
//                    end;
               end;
//   dsInsert:case DBGrid1.SelectedIndex of
//             0:begin
//                if PlanOrgCompte(cpt) then
//                         DMPlan.TaPlanCpt.findField('Compte').asstring := cpt;
//               end;
//               4:AideTvaAffiche(DBGrid1.Fields[4],DBGrid1.Fields[0].AsString);
//            end;
      dsedit:begin
             case GrilleCptGene.SelectedIndex of
               4:AideTvaAffiche(GrilleCptGene.Fields[4],GrilleCptGene.Fields[0].AsString);
             end;
//                  2:case DBProv.SelectedIndex of
//                      0:Rechercher(DBGrid1,DMProvisions.TaProvision,['Reference','Designation','ID','DateSaisie','Compte'],['Réference','Désignation','','',''],'',0);
//                      1:Rechercher(DBGrid1,DMProvisions.TaProvision,['Designation','Reference','DateSaisie','ID','Compte'],['Désignation','Réference','','',''],'',0);
//                    end;
               end;
  end;
 end;

end;

end.
