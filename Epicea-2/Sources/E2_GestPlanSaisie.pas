unit E2_GestPlanSaisie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Db,
  DMPlanCpt,
  LibSql,
  LibZoneSaisie,
  E2_Librairie_Obj,
  FM_INIT_COLOR,
  E2_Decl_Records,
  E2_Recherche,
  Editions,
  LibRessourceString,
  Dialogs, StdCtrls, RXCtrls, jpeg, ExtCtrls, Grids, DBGrids, RXDBCtrl,
  ExRxDBGrid, GrDBGrid, Menus;

type
  TPAramAffichPlanSaisie = record
   CompteASelectionner:String;
   TypeChamp:Integer;
  end;

  TGestPlanSaisie = class(TT_INIT_COLOR)
    PaGrille: TPanel;
    GrDBPlanSaisie: TGrDBGrid;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBImport: TRxSpeedButton;
    RxSBMarquerTousListe: TRxSpeedButton;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Visualisationsurpriode1: TMenuItem;
    Balance1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    MenuItem1: TMenuItem;
    Journal1: TMenuItem;
    TauxTVApardfaut1: TMenuItem;
    RxSBDeMarquerTousListe: TRxSpeedButton;
    procedure GrDBPlanSaisieShowEditor(Sender: TObject; Field: TField;
      var AllowEdit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure RxSBMarquerTousListeClick(Sender: TObject);
    procedure RxSBDeMarquerTousListeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Aide1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
  private
    { Déclarations privées }
    TypeChamp:Integer;
  public
    { Déclarations publiques }
  end;

var
  GestPlanSaisie: TGestPlanSaisie;

  Function PlanSaisieAffiche(PAramAffichPlanSaisie:TPAramAffichPlanSaisie):Boolean;

implementation

uses E2_Main;

{$R *.dfm}

Function PlanSaisieAffiche(PAramAffichPlanSaisie:TPAramAffichPlanSaisie):Boolean;
Begin
try
   result:=false;
   if GestPlanSaisie = nil then GestPlanSaisie:=TGestPlanSaisie.Create(application);
   GestPlanSaisie.TypeChamp := PAramAffichPlanSaisie.TypeChamp;
   case GestPlanSaisie.TypeChamp of
     C_Plan_Update_Plan_Saisie:Begin
                                GestPlanSaisie.Caption := 'Gestion du Plan de Saisie';
                                GestPlanSaisie.RxLabTitre.Caption := GestPlanSaisie.Caption;
                                GestPlanSaisie.RxSBMarquerTousListe.Caption := 'Cocher Tous les '+
                                                                                #13 +
                                                                               'comptes de la Liste ';
                                GestPlanSaisie.RxSBDeMarquerTousListe.Caption := 'Décocher Tous les '+
                                                                                  #13 +
                                                                                 'comptes de la Liste ';
                                GestPlanSaisie.GrDBPlanSaisie.Columns[2].Title.Caption := 'Plan de Saisie';
                                GestPlanSaisie.GrDBPlanSaisie.Columns[2].FieldName := 'PlanSaisie';
                               end;
     C_Plan_Update_Plan_TvaDebit:Begin
                                  GestPlanSaisie.Caption := 'Gestion des types de Tva';
                                  GestPlanSaisie.RxLabTitre.Caption := GestPlanSaisie.Caption;
                                  GestPlanSaisie.RxSBMarquerTousListe.Caption := 'Cocher Tva Débit pour les comptes '+
                                                                                  #13 +
                                                                                 'de vente de la Liste avec Code TVA';
                                  GestPlanSaisie.RxSBDeMarquerTousListe.Caption := 'Décocher Tva Débit pour les comptes '+
                                                                                    #13 +
                                                                                   'de vente de la Liste avec Code TVA';
                                GestPlanSaisie.GrDBPlanSaisie.Columns[2].Title.Caption := 'Tva Débit';
                                GestPlanSaisie.GrDBPlanSaisie.Columns[2].FieldName := 'TvaDebit';
                               end;
   else MessageDlg('PlanSaisieAffiche : TypeMarquage non défini !', mtError, [mbOK], 0);
   end;
case DMPlan.TaPlanCpt.State of
  dsInsert: GestPlanSaisie.GrDBPlanSaisie.ReadOnly := False;
  dsEdit:GestPlanSaisie.GrDBPlanSaisie.ReadOnly := False ;
  dsBrowse:GestPlanSaisie.GrDBPlanSaisie.ReadOnly := true ;
else MessageDlg('PlanSaisieAffiche : TaPlanCpt.State non défini !', mtError, [mbOK], 0);;
end;

   GestPlanSaisie.ShowModal;
//   GestPlanSaisie.EdCompte.Text:=ParamAffichPlan.CompteASelectionner;
except
abort;
end;
End;

procedure TGestPlanSaisie.GrDBPlanSaisieShowEditor(Sender: TObject;
  Field: TField; var AllowEdit: Boolean);
begin
AllowEdit:=false;
end;

procedure TGestPlanSaisie.FormCreate(Sender: TObject);
begin
inherited;
TypeInitForm:=C_MODELE_COLOREPI;
end;

procedure TGestPlanSaisie.Modifier1Click(Sender: TObject);
begin
BtnModifier.Click;
end;

procedure TGestPlanSaisie.BtnModifierClick(Sender: TObject);
begin
case TypeChamp of
  C_Plan_Update_Plan_Saisie:Begin
                              if DMPlan.TaPlanCpt.Active then // A faire en premier !!!!!!!!!!!!!!
                               if (DMPlan.TaPlanCpt.State in [dsBrowse]) then
                                begin
                                 DMPlan.MarquerCompteBooleenPlan(DMPlan.TaPlanCpt.findfield('Compte').AsString,C_Plan_Update_Plan_Saisie,ord((DMPlan.TaPlanCpt.findfield('PlanSaisie').asBoolean)));
                                 TableRefresh(DMPlan.TaPlanCpt,'Compte');

//                                 DMPlan.taplancpt.Next;
                                end; // Fin de A faire en premier !!!!!!!!!!!!!!

                              if DMPlan.TaPlanCpt.Active then
                               if (DMPlan.TaPlanCpt.State in [dsEdit,dsInsert]) then
                                begin
                                 DMPlan.TaPlanCpt.Edit;
                                 DMPlan.TaPlanCpt.FindField('PlanSaisie').AsBoolean := not DMPlan.TaPlanCpt.FindField('PlanSaisie').AsBoolean;
                                 TableGerePost(DMPlan.TaPlanCpt);
                                 GestPlanSaisie.GrDBPlanSaisie.ReadOnly := true ;
                              //   DMPlan.taplancpt.Next;
                                end;
                            end;
  C_Plan_Update_Plan_TvaDebit:Begin
                              if DMPlan.TaPlanCpt.Active then // A faire en premier !!!!!!!!!!!!!!
                               if (DMPlan.TaPlanCpt.State in [dsBrowse]) then
                                begin
                                 DMPlan.MarquerCompteBooleenPlan(DMPlan.TaPlanCpt.findfield('Compte').AsString,C_Plan_Update_Plan_TvaDebit,ord((DMPlan.TaPlanCpt.findfield('TvaDebit').asBoolean)));
                                 TableRefresh(DMPlan.TaPlanCpt,'Compte');
//                                 DMPlan.taplancpt.Next;
                                end; // Fin de A faire en premier !!!!!!!!!!!!!!

                              if DMPlan.TaPlanCpt.Active then
                               if (DMPlan.TaPlanCpt.State in [dsEdit,dsInsert]) then
                                begin
                                 DMPlan.TaPlanCpt.Edit;
                                 DMPlan.TaPlanCpt.FindField('TvaDebit').AsBoolean := not DMPlan.TaPlanCpt.FindField('TvaDebit').AsBoolean;
                                 TableGerePost(DMPlan.TaPlanCpt);
                                 GestPlanSaisie.GrDBPlanSaisie.ReadOnly := true ;
                              //   DMPlan.taplancpt.Next;
                                end;
                            end;
else MessageDlg('TGestPlanSaisie.BtnModifierClick : TypeMarquage non défini !', mtError, [mbOK], 0);
end;

end;

procedure TGestPlanSaisie.FormDestroy(Sender: TObject);
begin
GestPlanSaisie:=nil;
end;

procedure TGestPlanSaisie.BtnImprimerClick(Sender: TObject);
var
Site:TEditLien;
NomMenuSiteWeb:TFileStream;
begin
EditionPlanCptL(C_EditionSimple,GrDBPlanSaisie.DataSource.DataSet,nil,NomMenuSiteWeb,Site);
end;

procedure TGestPlanSaisie.Enregister1Click(Sender: TObject);
begin
BtnEnregistrer.Click;
end;

procedure TGestPlanSaisie.BtnEnregistrerClick(Sender: TObject);
begin
//if DMPlan.TaPlanCpt.Active then
// if (DMPlan.TaPlanCpt.State in [dsEdit]) then
//  begin
////   TableGerePost(DMPlan.TaPlanCpt);
////   DMPlan.taplancpt.Next;
//  end;
if DMPlan.TaPlanCpt.Active then
 if (DMPlan.TaPlanCpt.State in [dsEdit,dsInsert]) then
  begin
   TableGerePost(DMPlan.TaPlanCpt);
   DMPlan.taplancpt.Next;
  end;
end;

procedure TGestPlanSaisie.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TGestPlanSaisie.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ((Key = VK_SPACE) and (GestPlanSaisie.GrDBPlanSaisie.ReadOnly))then
 Begin
  BtnModifier.Click;
 End;

WinSuivPrec(Handle,key,[GrDBPlanSaisie]);
 If (key = VK_ESCAPE) then
 Begin
      if ActiveControl <> GrDBPlanSaisie then
        GrDBPlanSaisie.SetFocus
        else
      if ((DMPlan.DaPlanCpt.State in [dsEdit,dsInsert])) Then
      begin

         end
         else
         Begin
           Self.Close
         End;
      end;
end;

procedure TGestPlanSaisie.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TGestPlanSaisie.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(GrDBPlanSaisie,11,[2,6,2]);
  try
    WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
  except

  end;
end;

procedure TGestPlanSaisie.FormActivate(Sender: TObject);
begin
inherited;
PaGrilleResize(PaGrille);
end;

procedure TGestPlanSaisie.BtnFermerClick(Sender: TObject);
begin
self.Close;
end;

procedure TGestPlanSaisie.RxSBMarquerTousListeClick(Sender: TObject);
begin
  inherited;
  DMPlan.MarquerListeBooleenPlan(GrDBPlanSaisie.DataSource.DataSet,TypeChamp,C_Cocher);
end;

procedure TGestPlanSaisie.RxSBDeMarquerTousListeClick(Sender: TObject);
begin
  inherited;
  DMPlan.MarquerListeBooleenPlan(GrDBPlanSaisie.DataSource.DataSet,TypeChamp,C_DeCocher);
end;

procedure TGestPlanSaisie.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  GestPlanSaisie.Release;
end;

procedure TGestPlanSaisie.Aide1Click(Sender: TObject);
begin
  inherited;
 If activecontrol = GrDBPlanSaisie Then
  begin
   case GrDBPlanSaisie.DataSource.State of
      dsbrowse:begin
                   case GrDBPlanSaisie.SelectedIndex of
                    0:Rechercher(GrDBPlanSaisie,GrDBPlanSaisie.DataSource.DataSet,
                               ['Compte','Libelle','TvaCode','Taux','Pointable','Collectif','Immobilisation'],
                               ['Compte','Libellé','Code TVA','Taux','','',''],'',0);

                    else
                     Rechercher(GrDBPlanSaisie,GrDBPlanSaisie.DataSource.DataSet,
                                   ['Libelle','Compte','TvaCode','Taux','Pointable','Collectif','Immobilisation'],
                                   ['Libellé','Compte','Code TVA','Taux','','',''],'',0);
                    end;
               end;
  end;
 end;

end;

procedure TGestPlanSaisie.Imprimer1Click(Sender: TObject);
begin
  inherited;
BtnImprimer.Click;

end;

end.
