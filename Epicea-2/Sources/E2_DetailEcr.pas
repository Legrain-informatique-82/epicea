unit E2_DetailEcr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls,  Buttons,DMEcriture,DMPiece,
  editions,
  ExtCtrls, Grids, DBGrids, ExRxDBGrid,db,gr_Librairie_obj,
  GrDBGrid,LibZoneSaisie, CurrEdit, RXDBCtrl, ToolEdit, Mask, RXCtrls,
  GrGrid,DMPointages2,E2_Decl_Records,E2_LibInfosTable,LibRessourceString,
  E2_SaisieP_3,
  lib_chaine,
  LibSQL,DMConstantes, LibGestionParamXML, jpeg;

type
  TDetailEcr = class(TForm)
    Patitre: TPanel;
    PaGrille: TPanel;
    GrDbDetail: TGrDBGrid;
    PaBtn: TPanel;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Fermer1: TMenuItem;
    PaBas: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaCumul1: TPanel;
    Panel7: TPanel;
    GrGrid1: TGrGrid;
    PaCumul2: TPanel;
    Panel2: TPanel;
    GrGrid2: TGrGrid;
    PaCumul3: TPanel;
    Panel3: TPanel;
    GrGrid3: TGrGrid;
    Rglements1: TMenuItem;
    ALettrer1: TMenuItem;
    Modifierpice1: TMenuItem;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure GrDbDetailTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure FormShow(Sender: TObject);
    procedure GrDbDetailDblClick(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    Function CalculLeft (colcourante : integer) : integer;
    procedure FormActivate(Sender: TObject);
    Procedure PositionTotaux;
    procedure PaGrilleResize(Sender: TObject);
    procedure GrDbDetailKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnFermerEnter(Sender: TObject);
    procedure BtnFermerExit(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure PaCumul1Resize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Rglements1Click(Sender: TObject);
    procedure ALettrer1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Modifierpice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    PeriodeEcr:TPeriode;
  TiersEnCours:string;
  CompteEnCours:string;
  AppellantVisuPiece:Boolean;
  end;

var
  DetailEcr: TDetailEcr;

implementation
{$R *.DFM}
Uses E2_Librairie_obj,
  //Gr_Calculatrice,
  E2_Main, DMJournaux,
  E2_SaisieReglement, E2_AffectReglement, DMRecherche, E2_TabVisuPiece2;

Procedure TDetailEcr.PositionTotaux;
Begin
  case self.tag of
     1..3:begin
           Panel7.Width:=RenvoiTailleColonne(GrDbDetail,[0,1,2,3,4,5])+10;
           GrGrid1.ColWidths[0]:=RenvoiTailleColonne(GrDbDetail,[6]);
           GrGrid1.ColWidths[1]:=RenvoiTailleColonne(GrDbDetail,[7]);

           Panel2.Width:=RenvoiTailleColonne(GrDbDetail,[0,1,2,3,4,5])+10;
           GrGrid2.ColWidths[0]:=RenvoiTailleColonne(GrDbDetail,[6]);
           GrGrid2.ColWidths[1]:=RenvoiTailleColonne(GrDbDetail,[7]);

           Panel3.Width:=RenvoiTailleColonne(GrDbDetail,[0,1,2,3,4,5])+10;
           GrGrid3.ColWidths[0]:=RenvoiTailleColonne(GrDbDetail,[6]);
           GrGrid3.ColWidths[1]:=RenvoiTailleColonne(GrDbDetail,[7]);
          end;
     4:Begin
           Panel7.Width:=RenvoiTailleColonne(GrDbDetail,[0,1,2,3,4,5,6,7])+10;
           GrGrid1.ColWidths[0]:=RenvoiTailleColonne(GrDbDetail,[8]);
           GrGrid1.ColWidths[1]:=RenvoiTailleColonne(GrDbDetail,[9]);

           Panel2.Width:=RenvoiTailleColonne(GrDbDetail,[0,1,2,3,4,5,6,7])+10;
           GrGrid2.ColWidths[0]:=RenvoiTailleColonne(GrDbDetail,[8]);
           GrGrid2.ColWidths[1]:=RenvoiTailleColonne(GrDbDetail,[9]);

           Panel3.Width:=RenvoiTailleColonne(GrDbDetail,[0,1,2,3,4,5,6,7])+10;
           GrGrid3.ColWidths[0]:=RenvoiTailleColonne(GrDbDetail,[8]);
           GrGrid3.ColWidths[1]:=RenvoiTailleColonne(GrDbDetail,[9]);
       End;
  end; // Fin du case
End;

Function TDetailEcr.CalculLeft (colcourante : integer) : integer;
Var
   i : integer;
Begin
  Result := 2;
  for  i:=0 to (colcourante - 1) do
    begin
      result := Result + GrDbDetail.Columns[i].width
    end;
  Result := Result + GrDbDetail.Left + 11;
End;

procedure TDetailEcr.Calculatrice1Click(Sender: TObject);
begin
  AfficheCalculatrice(nil);
end;

procedure TDetailEcr.Fermer1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TDetailEcr.FormCreate(Sender: TObject);
begin
AppellantVisuPiece := false;
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TDetailEcr.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(Self,E.USer);
  DetailEcr:=nil;
end;

procedure TDetailEcr.pmMenu1Click(Sender: TObject);
begin
  PopupMenu1.Popup(Left + 50, Top + 50);
end;

procedure TDetailEcr.GrDbDetailTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
//GrDbDetail.SortDesc:=Not GrDbDetail.SortDesc;
//GrDbDetail.SortFieldName:=Field.FieldName;
end;

procedure TDetailEcr.FormShow(Sender: TObject);
begin
  GrDbDetail.SetFocus;
  PaGrilleResize(PaGrille);
end;

procedure TDetailEcr.GrDbDetailDblClick(Sender: TObject);
begin
try
 case self.Tag of
    1:PieceEcritureTiers;
    2:PieceEcritureCompte;
    3:PieceEcritureCompteTva;
    4:PieceEcritureJournal;
 end;
finally
end;
end;

procedure TDetailEcr.Visualisation1Click(Sender: TObject);
begin
  GrDbDetailDblClick(sender);
end;

procedure TDetailEcr.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
  RxLabTitre.Caption:=self.caption;

  GrDbDetail.ParamColor:=true;
  GrDbDetail.Param:=ParamUtil.CouleurDBGrid;
  GrDbDetail.UpDateColor;

  GrGrid1.ParamColor:=true;
  GrGrid1.Param:=ParamUtil.CouleurDBGrid;
  GrGrid1.DessineContourLigne:=false;
  GrGrid1.UpDateColor;
  GrGrid1.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

  GrGrid2.ParamColor:=true;
  GrGrid2.Param:=ParamUtil.CouleurDBGrid;
  GrGrid2.DessineContourLigne:=false;
  GrGrid2.UpDateColor;
  GrGrid2.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;

  GrGrid3.ParamColor:=true;
  GrGrid3.Param:=ParamUtil.CouleurDBGrid;
  GrGrid3.DessineContourLigne:=false;
  GrGrid3.UpDateColor;
  GrGrid3.FixedColor:=ParamUtil.CouleurDBGrid.GrilleColorFond;
  
  FormateTailleBoutton([BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,PaBtn.height + 1);
  if activecontrol.ClassNameIs('TButton') then BtnFermerEnter(activecontrol);
    FormShow(self);
  
 //screen.OnActiveControlChange:=AideEnLigne;
  //FormShow(DetailEcr);
  //TotDebit.Caption:=Currtostr(DBSumList1.SumCollection[0].SumValue);
end;

procedure TDetailEcr.PaGrilleResize(Sender: TObject);
begin
  case self.tag of
     1..4:FormateTailleColonne(GrDbDetail,21,[3,5,3,1,1,3,3]);
//     4:FormateTailleColonne(GrDbDetail,27,[3,3,3,5,3,1,1,3,3]);
  end;
  WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
  PositionTotaux;
end;

procedure TDetailEcr.GrDbDetailKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_DOWN then
   if ((GrDbDetail.DataSource.DataSet.EOF) or
    (GrDbDetail.DataSource.DataSet.RecNo=(GrDbDetail.DataSource.DataSet.RecordCount)))
    then abort;
//if key = VK_RETURN then Visualisation1Click(Visualisation1);
end;

procedure TDetailEcr.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  canclose:=true;
end;

procedure TDetailEcr.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;

procedure TDetailEcr.BtnFermerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TDetailEcr.BtnFermerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
  PaBtnResize(PaBtn);
//  FormateTailleBoutton([BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,0);
end;

procedure TDetailEcr.BtnImprimerClick(Sender: TObject);
var
LigneEdition,ListeCpt:TStringList;
periodeLocRetour:boolean;
begin
   LigneEdition:=TStringList.Create;
   periodeLocRetour:=PeriodeEcr.Retour;
   PeriodeEcr.Retour:=false;
  if GrDbDetail.DataSource.DataSet.RecordCount > 0 then
   Begin
   if not empty(TiersEnCours) then
    EditionEcritureL(0,C_TypeEditionLigneComplet,PeriodeEcr,TiersEnCours,nil,nil,e.SautDePageAutomatique)
   else
   if not empty(CompteEnCours) then
    EditionEcritureL(0,C_TypeEditionLigneComplet,PeriodeEcr,CompteEnCours,nil,nil,e.SautDePageAutomatique);
//     GrDbDetail.ReportCaption:=RxLabTitre.Caption;
//     GrDbDetail.GridPreview;
   End
   else
   Begin
     Application.Messagebox(Pchar('Aucune ligne d''écriture pour le compte'),'Attention',MB_OK);
   End;
   PeriodeEcr.Retour:=periodeLocRetour;
end;

procedure TDetailEcr.PaCumul1Resize(Sender: TObject);
begin
  PositionTotaux;
end;

procedure TDetailEcr.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[GrDbDetail]);
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;
end;

procedure TDetailEcr.Rglements1Click(Sender: TObject);
Var
ParamAffichPointage:TParamAffichPointage;
SavePlace: TBookmark;
begin
  try
//    TableDisableControlBookMark(GrDbDetail.DataSource.DataSet,BookMark);
    if not empty(TiersEnCours) then
      begin
         Initialise_TParamAffichPointage(ParamAffichPointage);
         ParamAffichPointage.ALettrer:=true;
         ParamAffichPointage.CptTiers:=TiersEnCours;
         ParamAffichPointage.DateDeb:=0;
         ParamAffichPointage.DateFin:=E.DatExoFin;
         ParamAffichPointage.ID_Ecriture_Appelant:=GrDbDetail.DataSource.DataSet.FindField('ID').AsInteger;
         ParamAffichPointage.ID_Reste_Appelant:=0;
         ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;

         if not VerifFNumeric(GrDbDetail.DataSource.DataSet.FindField('debitSaisie')).VideOUZero then
           begin
             ParamAffichPointage.SensAppelant:='D';
             ParamAffichPointage.Montant_Appelant:=GrDbDetail.DataSource.DataSet.FindField('debitSaisie').ascurrency;
           end
         else
           begin
             ParamAffichPointage.SensAppelant:='C';
             ParamAffichPointage.Montant_Appelant:=GrDbDetail.DataSource.DataSet.FindField('CreditSaisie').ascurrency;
           end;
         ParamAffichPointage.Reference:=GrDbDetail.DataSource.DataSet.FindField('Reference').AsString;
         GestionAffichagePointageSurRef(true,true,ParamAffichPointage,not e.ExerciceCloture);
      end;
  finally
    //SavePlace := DMEcritures.DataQueryEcr.DataSet.GetBookmark;
    DMEcritures.DataQueryEcr.DataSet.Close;
    DMEcritures.DataQueryEcr.DataSet.open;
    DMEcritures.DataQueryEcr.DataSet.GotoBookmark(SavePlace);
    DMEcritures.DataQueryEcr.DataSet.FreeBookmark(SavePlace);
  end;//fin du finally
end;

procedure TDetailEcr.ALettrer1Click(Sender: TObject);
begin
  DetailPointageAffich(TiersEnCours,DMEcritures.DataQueryEcr.DataSet['ID'],0,true,true);
end;

procedure TDetailEcr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if TabVisuPiece2 <> nil then
    begin
      TabVisuPiece2.AppellantDetailEcr := false;
    end;

if AppellantVisuPiece then
 begin
   AppellantVisuPiece :=false;
   if TabVisuPiece2 <> nil then
    begin
      if TabVisuPiece2.CanFocus then
       TabVisuPiece2.SetFocus;
      TabVisuPiece2.AppellantDetailEcr := false;
    end;
 end;

end;

procedure TDetailEcr.Modifierpice1Click(Sender: TObject);
begin
showmessage(VersionUlterieur);
end;

end.
