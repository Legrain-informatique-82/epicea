{***************************************************************
 *
 * Unit Name: E2_ListeAcquis
 * Purpose  :
 * Author   :  Blanchard
 * History  :
 *
 ****************************************************************}

unit E2_ListeAcquis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, Gr_Librairie_obj, E2_DetailAcquis, StdCtrls,
  Buttons,E2_Decl_Records,E2_Librairie_Obj, RXDBCtrl, ExRxDBGrid, GrDBGrid,
  RXCtrls, GrGrid,LibZoneSaisie, Menus, LibSQL, DMEcriture,E2_Recherche,DMConstantes,
  LibGestionParamXML, jpeg,LibRessourceString;

type
  TListeAcquis = class(TForm)
    PaGrille: TPanel;
    grdListeAcquis: TGrDBGrid;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaCumul: TPanel;
    Panel1: TPanel;
    GrGrid2: TGrGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
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
    PaBas: TPanel;
    Acquisitionspciale1: TMenuItem;
    procedure grdListeAcquisTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdListeAcquisDblClick(Sender: TObject);
    procedure grdListeAcquisKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaCumulResize(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure DemandeAffichageAcquisition(Speciale:boolean=false);
    procedure Acquisitionspciale1Click(Sender: TObject);
  private

  public
    
  end;

const
	csWidth = 460;		//Largeur de base de la feuille
   csHeight = 237;   //Hauteur de base de la feuille
var
  ListeAcquis: TListeAcquis;

implementation

uses DMImmos, E2_ListeImmos, E2_AideCompte, E2_Main;

{$R *.DFM}

procedure TListeAcquis.grdListeAcquisTitleClick(Column: TColumn);
var s, ordre : string;
 Colonne1 : string ;
begin
Colonne1:='';
// Trie les enregs suivant la colonne (ordre croissant et décroissant à chaque click)
   if Colonne1 <> Column.FieldName then begin
       Colonne1 := Column.FieldName;
      ordre := '';
	end
   else begin
   	ordre := ' desc';
      Colonne1 := '';
   end;
      s := 'Order by E."' + Column.FieldName + '"' + ordre;
      with DataModuleImmos.qryListeAcquis do
      DataModuleImmos.Filtrage_qryListeAcquis_SurTag(tag,true,SQL.Count-1,s);
end;

procedure TListeAcquis.FormCreate(Sender: TObject);
begin
	Left:= 0; Top:= 0; Width:= csWidth; Height:= csHeight;
    try
       if DataModuleImmos=nil then
        DataModuleImmos:=TDataModuleImmos.Create(self);

	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
end;

procedure TListeAcquis.FormDestroy(Sender: TObject);
begin
	LibGestionParamXML.DestroyForm(Self,E.User);
        if DataModuleImmos<>nil then  DataModuleImmos.Free;
        ListeAcquis := Nil;
end;

procedure TListeAcquis.grdListeAcquisDblClick(Sender: TObject);
begin
//appel demande affiche detailacquis
DemandeAffichageAcquisition;
end;


procedure TListeAcquis.DemandeAffichageAcquisition(Speciale:boolean);
var
ParamAffichageDetailAcquis:TParamAffichageDetailAcquis;
begin
try
if tag in [C_ACQUISITION_Terminee,C_ACQUISITION_En_Cours,C_ACQUISITION_Simple] then
  Begin
  //regarder si l'Ecriture séléctionnée fait partie d'une pièce dans laquelle il y de
  //l'immobilisation en cours. si oui, on remonte les immobilisations en cours déjà décrites
  //pour que l'utilisateur puisse en relier avec la nouvelle immo terminée à décrire

//  DataModuleImmos.Tag:=1;//  { isa  le  29/01/04 }  remplacé par typepresentation
//  DataModuleImmos.TaImmosEnCours.Close;
//  DataModuleImmos.TaImmosEnCours.open;
  if copy(DataModuleImmos.qryListeAcquisCompte.Asstring,1,2)='23'then
   tag:=C_ACQUISITION_En_Cours
   else
     Begin
        if DataModuleImmos.RetourneSiPieceContientdesImmosEnCours(DataModuleImmos.qryListeAcquisID.AsInteger,DataModuleImmos.qryListeAcquis.Database) then
          tag:=C_ACQUISITION_Terminee
        else
          tag:=C_ACQUISITION_Simple;
     End;
  End;
ParamAffichageDetailAcquis.AffichageModal := true;
ParamAffichageDetailAcquis.Affiche := true;
ParamAffichageDetailAcquis.Quand := C_Mouvement;
ParamAffichageDetailAcquis.TitreForm :='Saisie des paramètres de l"acquisition';
ParamAffichageDetailAcquis.SousTitreForm := CMouvement;
ParamAffichageDetailAcquis.QuiAppel:=F_DetailAcquis;
ParamAffichageDetailAcquis.TypePresentation:=tag;
ParamAffichageDetailAcquis.Maintenance:=Speciale;
//   Case tag of
//      C_ACQUISITION_Terminee,C_ACQUISITION_En_Cours,C_ACQUISITION_Simple:
//      begin
//         if DetailAcquis = Nil then DetailAcquis := TDetailAcquis.Create(Self);
//         DetailAcquis.tag:=self.Tag;
//         DataModuleImmos.TaImmosEnCours.filtered:=true;
//         DetailAcquis.showmodal;
//      end;
   //end;//fin du case tag

if not DetailAcquisAffiche(ParamAffichageDetailAcquis) then abort ;
finally
DataModuleImmos.Filtrage_qryListeAcquis_SurTag(tag,false,-1,'');
  if DataModuleImmos.qryListeAcquis.RecordCount=0 then self.close;
end;
end;


procedure TListeAcquis.grdListeAcquisKeyPress(Sender: TObject;
  var Key: Char);
begin
	If Key = #13 then begin
      Key := #0;
      grdListeAcquisDblClick(Sender);
   end;
end;

procedure TListeAcquis.FormActivate(Sender: TObject);
var
TotauxListeAcquis:TTotauxGeneric;
begin
   //DMImmos.DataModuleImmos.tbPMV.Open;
   Initialiser_ShortCut_Main(true);
grdListeAcquis.ParamColor:=true;
grdListeAcquis.Param:=ParamUtil.CouleurDBGrid;
grdListeAcquis.UpDateColor;
grdListeAcquis.Refresh;

GrGrid2.ParamColor:=true;
GrGrid2.Param:=ParamUtil.CouleurDBGrid;
GrGrid2.DessineContourLigne:=false;
GrGrid2.UpDateColor;
GrGrid2.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

TotauxListeAcquis:=SommeTotauxGeneric(['Debit','Credit'],DataModuleImmos.qryListeAcquis);
DataModuleImmos.qryListeAcquis.First;
DataModuleImmos.qryListeAcquis.EnableControls;

GrGrid2.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total1);
GrGrid2.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total2);

TMenuItem(FindComponent('Acquisitionspciale1')).Visible:= ((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS'));
    if tag=C_ACQUISITION_Terminee then Self.Caption := 'Liste des Acquisitions';
    if tag=C_CESSION then Self.Caption := 'Liste des Cessions';
    DataModuleImmos.Filtrage_qryListeAcquis_SurTag(tag,false,-1,'');
    if DataModuleImmos.qryListeAcquis.RecordCount=0 then
      self.Close;
end;

procedure TListeAcquis.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_return then
  Begin
    grdListeAcquisDblClick(grdListeAcquis);
    key:=0;
  End;
if key=vk_escape then
  BtnFermerClick(sender);
end;

procedure TListeAcquis.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(grdListeAcquis,12,[2,2,3,2,2]);
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TListeAcquis.PaCumulResize(Sender: TObject);
begin
Panel1.Width:=RenvoiTailleColonne(grdListeAcquis,[0,1,2,3])+5;
GrGrid2.ColWidths[0]:=RenvoiTailleColonne(grdListeAcquis,[4]);
GrGrid2.ColWidths[1]:=RenvoiTailleColonne(grdListeAcquis,[5]);
end;

procedure TListeAcquis.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue (sender as TButton);
end;

procedure TListeAcquis.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit (sender as TButton);
end;

procedure TListeAcquis.BtnEnregistrerClick(Sender: TObject);
begin
if DataModuleImmos.qryListeAcquis.RecordCount<>0 then
  grdListeAcquisDblClick(Sender);
end;

procedure TListeAcquis.BtnFermerClick(Sender: TObject);
begin
close;
end;

procedure TListeAcquis.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TListeAcquis.Visualisation1Click(Sender: TObject);
begin
 if not empty(DataModuleImmos.qryListeAcquis.findfield('compte').ASString) then
   DetailEcritureCompte(DataModuleImmos.qryListeAcquis.findfield('compte').ASString,true,False)
end;

procedure TListeAcquis.Imprimer1Click(Sender: TObject);
begin
//
end;

procedure TListeAcquis.Aide1Click(Sender: TObject);
begin
// case grdListeAcquis.SelectedIndex of
//         0:Rechercher(grdListeAcquis,DataModuleImmos.qryListeAcquis,['Compte','Libelle'],['Compte','Libellé'],'',0);
//         1:Rechercher(grdListeAcquis,DataModuleImmos.qryListeAcquis,['Libelle','Compte'],['Libellé','Compte'],'',0);
// end;

end;

procedure TListeAcquis.BtnImprimerClick(Sender: TObject);
begin
grdListeAcquis.ReportCaption:='Liste des acquisitions en attente';
grdListeAcquis.GridPreview;
end;

procedure TListeAcquis.Acquisitionspciale1Click(Sender: TObject);
begin
//appel demande affiche detailacquis
DemandeAffichageAcquisition(true);
end;

end.
