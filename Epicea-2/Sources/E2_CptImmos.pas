unit E2_CptImmos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DMplanCpt,
  Menus, StdCtrls, RXCtrls, ExtCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid,
  GrDBGrid,db,LibZoneSaisie,DMEcriture,GR_Librairie_Obj,E2_Librairie_Obj,LibSQL
  ,DMConstantes, LibGestionParamXML, jpeg;

type
  TCptImmos = class(TForm)
    PaGrille: TPanel;
    GrCptImmo: TGrDBGrid;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
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
    procedure GrCptImmoColExit(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnImprimerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  CptImmos: TCptImmos;

  function GestCompteImmosAffiche(cpt:string):boolean;

implementation

uses E2_Main;

{$R *.DFM}
function GestCompteImmosAffiche(cpt:string):boolean;
Begin
  if CptImmos = nil then CptImmos:=TCptImmos.Create(Application.MainForm); 
  OuvreTables('',[DMPlan.TaCptImmos]);
  DMPlan.TaCptImmos.Filter:='Immobilisation=Vrai';
  DMPlan.TaCptImmos.Filtered:=true;
  CptImmos.ShowModal;
End;


procedure TCptImmos.GrCptImmoColExit(Sender: TObject);
begin
  if DMPlan.daCptImmos.State in [dsEdit] then
  begin
   DMPlan.ModificationCpt(GrCptImmo.SelectedField);
  end;
end;

procedure TCptImmos.BtnInsererClick(Sender: TObject);
begin
  DMPlan.TaCptImmos.Insert;
end;

procedure TCptImmos.PaGrilleResize(Sender: TObject);
begin
  FormateTailleColonne(GrCptImmo,8,[1,3,1,1,2]);
  WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TCptImmos.BtnAnnulerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TCptImmos.BtnAnnulerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
end;

procedure TCptImmos.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TCptImmos.BtnModifierClick(Sender: TObject);
begin
  DMPlan.TaCptImmos.Edit;
end;

procedure TCptImmos.BtnSupprimerClick(Sender: TObject);
begin
  TableGereDelete(DMPlan.TaCptImmos);
end;

procedure TCptImmos.BtnFermerClick(Sender: TObject);
begin
  self.close;
end;

procedure TCptImmos.BtnEnregistrerClick(Sender: TObject);
begin
  TableGerePost(DMPlan.TaCptImmos);  
end;

procedure TCptImmos.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TCptImmos.MenuItem8Click(Sender: TObject);
begin
  if DMPlan.TaCptImmos.State in [dsEdit] then
  DMPlan.TaCptImmos.Cancel;
end;

procedure TCptImmos.Visualisation1Click(Sender: TObject);
begin
  DetailEcritureCompte(DMPlan.TaCptImmos.FindField('Compte').AsString,true,False);
end;

procedure TCptImmos.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TCptImmos.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(self,E.User);
  CptImmos:=nil;
end;

procedure TCptImmos.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
//DMPlan.TaCompte.OnFilterRecord:=nil;
end;

procedure TCptImmos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[GrCptImmo]);
if key = VK_ESCAPE then
   begin //si échappe
//     if ((ActiveControl = GrCptImmo) or (ActiveControl = BtnAnnuler)) then
//        begin//si on est sur la grille ou le bouton annuler
         if GrCptImmo.DataSource.DataSet.State in [dsEdit,dsinsert] then
            begin//si modification
             GrCptImmo.DataSource.DataSet.Cancel;
             key:=0;
            end//fin si modification
         else
            begin //si en consultation
               self.close;
            end;//fin si en consultation
//        end;//fin si on est sur la grille ou le bouton annuler
   end;//fin si échappe
end;

procedure TCptImmos.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
canclose:=true;
end;

procedure TCptImmos.BtnImprimerClick(Sender: TObject);
begin
GrCptImmo.ReportCaption:='Plan des comptes d''immobilisation';
GrCptImmo.GridPreview;
end;

end.
