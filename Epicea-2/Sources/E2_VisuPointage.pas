unit E2_VisuPointage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Db,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, StdCtrls, ExtCtrls,DMPointages2,
  RXSplit,LibZoneSaisie, Menus,E2_Librairie_Obj,LibSQL,Gr_Librairie_Obj,
  LibGestionParamXML, LibRessourceString,DMConstantes;

type
  TVisuPointage = class(TForm)
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaCentre: TPanel;
    PaGrille: TPanel;
    PaDetail: TPanel;
    PaSubDetail: TPanel;
    PaGrilleDetail: TPanel;
    GrDBDetail: TGrDBGrid;
    GrDBEcritures: TGrDBGrid;
    RxSplitter1: TRxSplitter;
    PaIfosLeft: TPanel;
    PaPTitre: TPanel;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Toutdpointer1: TMenuItem;
    pmAutomatique1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure PaCentreResize(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure GrDBEcrituresEnter(Sender: TObject);
    procedure GrDBEcrituresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Visualisation1Click(Sender: TObject);
    procedure Toutdpointer1Click(Sender: TObject);
    procedure Insrer1Click(Sender: TObject);
    procedure pmAutomatique1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GrDBEcrituresDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure GrDBEcrituresDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
      Procedure GereAccesEcran;
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  VisuPointage: TVisuPointage;
  ActiveControlTmp:TWinControl;

implementation

uses E2_Main, E2_DetailEcr, DMEcriture;

{$R *.DFM}

procedure TVisuPointage.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);

GrDBEcritures.ParamColor:=true;
GrDBEcritures.Param:=ParamUtil.CouleurDBGrid;
GrDBEcritures.UpDateColor;

GrDBDetail.ParamColor:=true;
GrDBDetail.Param:=ParamUtil.CouleurDBGrid;
GrDBDetail.UpDateColor;
GereAccesEcran;
end;

procedure TVisuPointage.PaCentreResize(Sender: TObject);
begin
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);

FormateTailleColonne(GrDBEcritures,22,[2,4,2,2,2,2,2,2]);

FormateTailleColonne(GrDBDetail,20,[2,4,2,2,2,2,2]);

end;

procedure TVisuPointage.BtnSupprimerClick(Sender: TObject);
begin
if ActiveControlTmp <> nil then
 begin
   if ((ActiveControlTmp = GrDBEcritures)and(not VerifFNumeric(GrDBEcritures.DataSource.DataSet.findfield('Imputation')).VideOUZero)) then
    begin
    DMPointage2.SuppressionTousPointage_SurID_Appelant(GrDBEcritures.DataSource.DataSet.findfield('ID_Ecriture').AsInteger,GrDBEcritures.DataSource.DataSet.findfield('Reference').AsString,true);
    GrDBEcritures.DataSource.DataSet.Refresh;
    GrDBDetail.DataSource.DataSet.Refresh;
    end;

   if ((ActiveControlTmp = GrDBDetail)and(GrDBDetail.datasource.dataset.RecordCount>0)) then
    begin
     DMPointage2.SuppressionPointage(GrDBDetail.DataSource.DataSet,true);
     GrDBEcritures.DataSource.DataSet.Refresh;
     GrDBDetail.DataSource.DataSet.Refresh;
    end;
 end;

end;

procedure TVisuPointage.GrDBEcrituresEnter(Sender: TObject);
begin
ActiveControlTmp:=ActiveControl;
end;

procedure TVisuPointage.GrDBEcrituresKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key = VK_DELETE then
 BtnSupprimer.Click;
end;

procedure TVisuPointage.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;

procedure TVisuPointage.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TVisuPointage.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TVisuPointage.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TVisuPointage.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[GrDBEcritures,GrDBDetail]);
if key = VK_ESCAPE then
 begin
  self.close;
 end;
end;

procedure TVisuPointage.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  DMPointage2.TaResteDC.Refresh;
  CanClose:=true;
end;

procedure TVisuPointage.Visualisation1Click(Sender: TObject);
var
Compte:string;
begin
if ActiveControl = GrDBEcritures then
  compte:=GrDBEcritures.DataSource.DataSet.findfield('Tiers').asstring
else
if ActiveControl = GrDBDetail then
  compte:=GrDBDetail.DataSource.DataSet.findfield('Tiers').asstring;
if copy(compte,1,1)='+'then
  begin//si tiers
     if DetailEcritureTiers(compte,false) then
       case DetailEcr.Tag of
          1:begin
             if ActiveControl = GrDBEcritures then
              begin
                if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMPointage2.TaVisuResteDC.findfield('ID_Piece').AsInteger,[]) then
                PieceEcritureTiers;
              end;
             if ActiveControl = GrDBDetail then
              begin
                if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMEcritures.ID_Piece_Avec_Id_Ecriture(DMPointage2.TaVisuPointage.findfield('ID_Ecriture').AsInteger),[]) then
                PieceEcritureTiers;
              end;
            end;
       end;//fin du case
  end//fin si tiers
else
  Begin//si compte pointable
     if DetailEcritureCompte(compte,false,false) then
       case DetailEcr.Tag of
          1:begin
             if ActiveControl = GrDBEcritures then
              begin
                if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMPointage2.TaVisuResteDC.findfield('ID_Piece').AsInteger,[]) then
                PieceEcritureCompte;
              end;
             if ActiveControl = GrDBDetail then
              begin
                if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMEcritures.ID_Piece_Avec_Id_Ecriture(DMPointage2.TaVisuPointage.findfield('ID_Ecriture').AsInteger),[]) then
                PieceEcritureCompte;
              end;
            end;
       end;//fin du case
  End;//fin si compte pointable
end;

procedure TVisuPointage.Toutdpointer1Click(Sender: TObject);
var
idcourant:integer;
begin
if ActiveControlTmp <> nil then
 begin
   if (ActiveControlTmp = GrDBEcritures) then
    begin

    GrDBEcritures.DataSource.DataSet.DisableControls;
    idcourant:=GrDBEcritures.DataSource.DataSet.findfield('ID_Ecriture').asinteger;
    GrDBEcritures.DataSource.DataSet.first;
//    if Messagedlg('Êtes-Vous sûr de vouloir supprimer tous ces pointages ?',MtConfirmation,[mbyes,mbno],0) = mrYes then
    if Application.MessageBox(Pchar('Attention, vous avez demandé la suppression des pointages de toutes les pièces de cette liste,'+
       retourchariotsimple+'confirmez-vous votre demande ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
     if Application.MessageBox(Pchar('Pour commencer la suppression des pointages de TOUTES les pièces de cette liste,'+
        retourchariotsimple+ 'cliquez sur "OUI", sinon cliquez sur "NON"'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
        begin//si confirme la suppression
          while not GrDBEcritures.DataSource.DataSet.eof do
            Begin//si
              //if application.me
              DMPointage2.SuppressionTousPointage_SurID_Appelant(GrDBEcritures.DataSource.DataSet.findfield('ID_Ecriture').AsInteger,GrDBEcritures.DataSource.DataSet.findfield('Reference').AsString,false);
              GrDBEcritures.DataSource.DataSet.Refresh;
              GrDBDetail.DataSource.DataSet.Refresh;
              GrDBEcritures.DataSource.DataSet.next;
            End;//fin si
        end;//si confirme la suppression
    end;
    GrLocate(GrDBEcritures.DataSource.DataSet,'id_Ecriture',[idcourant]);
    GrDBEcritures.DataSource.DataSet.EnableControls;
   if ((ActiveControlTmp = GrDBDetail)and(GrDBDetail.datasource.dataset.RecordCount>0)) then
    begin
     DMPointage2.SuppressionPointage(GrDBDetail.DataSource.DataSet,true);
     GrDBEcritures.DataSource.DataSet.Refresh;
     GrDBDetail.DataSource.DataSet.Refresh;
    end;
 end;
end;

procedure TVisuPointage.Insrer1Click(Sender: TObject);
begin
//if empty(DMPointage2.LettrageEnCours) then
// begin
//  DMPointage2.LettrageEnCours:='A';
// end;
//DMPointage2.LettrageEnregCourant(GrDBEcritures.DataSource.DataSet,DMPointage2.LettrageEnCours,0);
//GrDBEcritures.DataSource.DataSet.Next;

end;

procedure TVisuPointage.pmAutomatique1Click(Sender: TObject);
//var
//   ListeLettres:tstringlist;
//   i:integer;

begin
//if not DMPointage2.RecupListeLettre_surDataset(GrDBEcritures.DataSource.DataSet,false).Result then
// begin
//   DMPointage2.LettrageEnCours:='*';
//   DMPointage2.LettrageAutomatique(GrDBEcritures.DataSource.DataSet,GrDBEcritures.DataSource.DataSet.findfield('Tiers').asstring,0,E.DatExoFin);
//   DMPointage2.LettrageEnCours:='';
// end
// else
// begin
//  Showmessage('Vous devez d''abord valider le lettrage en cours !');
// end;

end;

procedure TVisuPointage.FormDeactivate(Sender: TObject);
begin
DMPointage2.TaResteDC.Refresh;
end;

procedure TVisuPointage.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TVisuPointage.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
VisuPointage:=Nil;
end;

procedure TVisuPointage.GrDBEcrituresDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
//
end;

procedure TVisuPointage.GrDBEcrituresDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  holdColor: TColor;
begin
try
   if Column.Field.DataSet.FindField('Imputation').AsCurrency <> 0 then
    begin
         holdColor:=GrDBEcritures.Canvas.Brush.Color;
         GrDBEcritures.Canvas.Brush.Color :=clSilver;//$00808040;
         GrDBEcritures.DefaultDrawColumnCell(Rect, DataCol, Column, State);
         GrDBEcritures.Canvas.Brush.Color := holdColor;
    end
except
//RxLabTitre.Caption:='Erreur d''affichage grille dans Visu Pointage';
end;

end;


Procedure TVisuPointage.GereAccesEcran;
begin
EnableWinControl([BtnSupprimer],not E.ExerciceCloture);
EnableItemMenu([Supprimer1,Toutdpointer1],not E.ExerciceCloture);
end;


procedure TVisuPointage.Calculatrice1Click(Sender: TObject);
begin
AfficheCalculatrice(nil);
end;

end.
