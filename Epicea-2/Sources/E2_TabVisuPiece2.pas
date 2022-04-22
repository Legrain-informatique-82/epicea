{***************************************************************
 *
 * Unit Name: E2_TabVisuPiece2
 * Purpose  :
 * Author   : BP
 * History  :
 *
 ****************************************************************}

unit E2_TabVisuPiece2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Gr_Librairie_Obj,  Buttons, Db, DBTables, Mask, DBCtrls,
  Grids, DBGrids, ComCtrls, ExtCtrls, RXDBCtrl, ExRxDBGrid, GrDBGrid,LibZoneSaisie,
  DMTva, RXCtrls, GrGrid,E2_Decl_Records,DMPlanCpt,E2_LibInfosTable,DMConstantes,
  LibGestionParamXML,
  lib_chaine,
  DMJournaux,
  E2_SaisieP_3,
  jpeg;


type
  TTabVisuPiece2 = class(TForm)
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    pmDevise1: TMenuItem;
    pmFranc1: TMenuItem;
    pmEuro1: TMenuItem;
    pmSaisie1: TMenuItem;
    pmVisuP: TMenuItem;
    pmChamp2: TMenuItem;
    pmChamp3: TMenuItem;
    pmChamp4: TMenuItem;
    pmChamp5: TMenuItem;
    pmChamp6: TMenuItem;
    pmChamp7: TMenuItem;
    N3: TMenuItem;
    pmTableauTva1: TMenuItem;
    pmRglement1: TMenuItem;
    Patitre: TPanel;
    PaTabControl: TPanel;
    TabDetails: TTabControl;
    PaLabel: TPanel;
    PaGrille: TPanel;
    GrDBVisuEcriture: TGrDBGrid;
    PaBas: TPanel;
    LaDateTva: TLabel;
    DBCodeTva: TDBText;
    DBTypeTva: TDBText;
    DBDateTva: TDBText;
    LaTypeTva: TLabel;
    LaCodeTva: TLabel;
    PaBtn: TPanel;
    BtnModifier: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    BtnDetail: TButton;
    Imprimer1: TMenuItem;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaCumul1: TPanel;
    Panel6: TPanel;
    PaCumul2: TPanel;
    Panel7: TPanel;
    GrDBGrid1: TGrDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    GrGrid2: TGrGrid;
    GrGrid1: TGrGrid;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    Dtailpointages1: TMenuItem;
    LabTauxTva: TLabel;
    LabMontantTva: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    Shape1: TShape;
    Shape2: TShape;
    Modifierpice1: TMenuItem;
    BtnValider: TButton;
    Valider: TMenuItem;
    Exporter1: TMenuItem;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabDetailsChange(Sender: TObject);
    procedure pmRglement1Click(Sender: TObject);
    procedure pmTableauTva1Click(Sender: TObject);
    procedure Modification1Click(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TaEcritureVisuAfterScroll(DataSet: TDataSet);
    procedure TaPieceVisuAfterScroll(DataSet: TDataSet);
    procedure Visualisation1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnModifierEnter(Sender: TObject);
    procedure BtnModifierExit(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure DBCodeTvaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxSpeedButton1Click(Sender: TObject);
    Procedure CalcSolde;
    procedure GrGrid2DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrDBVisuEcritureEnter(Sender: TObject);
    procedure Dtailpointages1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Modifierpice1Click(Sender: TObject);

    procedure InitModifiable;
    procedure BtnValiderClick(Sender: TObject);
    procedure ValiderClick(Sender: TObject);
    procedure Exporter1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  AppellantDetailEcr:Boolean;
  Modifiable:boolean;
  end;

var
  TabVisuPiece2: TTabVisuPiece2;
  ListeID : TStrings;
  GrilleActive:TWincontrol;
  PeriodeTabVisu:TPeriode;

implementation
{$R *.DFM}
Uses E2_Librairie_obj, E2_Main, Registry,
	E2_AideModel,
  //Gr_Calculatrice,
  DMPiece,DMEcriture,LibSQL,
        DMRecherche,DMPointages2,LibRessourceString, E2_DetailEcr;


Procedure TTabVisuPiece2.CalcSolde;
var
TotauxListeAcquis:TTotauxGeneric;
Begin

TotauxListeAcquis:=SommeTotauxGeneric(['Debit','Credit'],DMEcritures.TaEcritureVisu);

DMEcritures.TaEcritureVisu.EnableControls;

GrGrid2.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total1);
GrGrid2.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total2);

TotauxListeAcquis.Total3:=0;
TotauxListeAcquis.Total4:=0;
if (TotauxListeAcquis.Total1 - TotauxListeAcquis.Total2) > 0 then
   TotauxListeAcquis.Total3:=TotauxListeAcquis.Total1 - TotauxListeAcquis.Total2
    else
   TotauxListeAcquis.Total4:=TotauxListeAcquis.Total2 - TotauxListeAcquis.Total1;

GrGrid1.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total3);
GrGrid1.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', TotauxListeAcquis.Total4);

End;

procedure TTabVisuPiece2.Calculatrice1Click(Sender: TObject);
begin
  try
    self.Visible:=false;
    formstyle:=fsnormal;
    self.Visible:=true;
    AfficheCalculatrice(nil);

  finally
    self.Visible:=false;
    //formstyle:=fsnormal;
    formstyle:=fsStayOnTop;
    self.Visible:=true;
  end;
end;

procedure TTabVisuPiece2.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;

procedure TTabVisuPiece2.FormCreate(Sender: TObject);
begin
AppellantDetailEcr:=false;
Modifiable:=false;
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
   ListeID:=TStringList.Create;


end;

procedure TTabVisuPiece2.FormShow(Sender: TObject);
var
ref:string;
i:integer;
begin
InitModifiable;
DMpieces.TaPieceVisu.open;
DMEcritures.TaEcritureVisu.open;
DMEcritures.TaEcritureVisu.AfterScroll:=TaEcritureVisuAfterScroll;
TaEcritureVisuAfterScroll(DMEcritures.TaEcritureVisu);
if self.tag<>0 then
  begin
//  paGrilleResize(PaGrille);
  ref:=IntToStr(self.tag);
  i:=ListeID.IndexOf(ref);
  if  i < 0 then
    begin
       DMpieces.TaPieceVisu.AfterScroll:=nil;
       FiltrageDataSet(DMpieces.TaPieceVisu,'id='+inttostr_lgr(self.tag));
       DMpieces.TaPieceVisu.Locate('ID',self.tag,[]);
       DMpieces.TaPieceVisu.AfterScroll:=TaPieceVisuAfterScroll;
       ListeID.Insert(0,ref);
       TabDetails.Tabs.Insert(0,DMpieces.TaPieceVisu.FieldByName('Reference').AsString);
       TabDetails.TabIndex:=0;
    end
    else
    begin
     TabDetails.TabIndex:=i;
     FiltrageDataSet(DMpieces.TaPieceVisu,'id='+inttostr_lgr(self.tag));
     DMpieces.TaPieceVisu.Locate('ID',self.tag,[]);
    end;

    GrDBGrid1.Columns.Items[2].Title.Caption:='Compte';
    if not empty(DMPieces.TaPieceVisu.FindField('Compte').AsString) then
      if DMPieces.TaPieceVisu.FindField('Compte').AsString[1] = '+' then
          GrDBGrid1.Columns.Items[2].Title.Caption:='Tiers';
  end;
    self.tag:=0;
end;

Procedure TTabVisuPiece2.InitialiseTable_A_Nil;
Begin
 if DMEcritures<>nil then
   DMEcritures.TaEcritureVisu.AfterScroll:=nil;
 if DMPieces<>nil then
   DMPieces.TaPieceVisu.AfterScroll:=nil;
// InitDatasetEvent_A_Nil_Sur_Form([DMPieces.TaPieceVisu,DMEcritures.TaEcritureVisu]);
End;

procedure TTabVisuPiece2.FormDestroy(Sender: TObject);
begin
InitialiseTable_A_Nil;
ListeID.Free;
LibGestionParamXML.DestroyForm(Self,E.USer);
TabVisuPiece2:=nil;
end;

procedure TTabVisuPiece2.pmMenu1Click(Sender: TObject);
begin
 PopupMenu1.Popup(Left + 50, Top + 50);
end;



procedure TTabVisuPiece2.TabDetailsChange(Sender: TObject);
begin
  with TabDetails do
  begin
    if TabIndex <> -1 then
     begin
      DMpieces.TaPieceVisu.AfterScroll:=nil;
      FiltrageDataSet(DMpieces.TaPieceVisu,'id='+ListeID.Strings[TabIndex]);
      DMpieces.TaPieceVisu.Locate('ID',strtoint_lgr(ListeID.Strings[TabIndex]),[]);
      DBDateTva.Visible:=DMEcritures.TaEcritureVisu.FindField('TvaType').AsString = 'D';
      DMpieces.TaPieceVisu.AfterScroll:=TaPieceVisuAfterScroll;

      GrDBGrid1.Columns.Items[2].Title.Caption:='Compte';
      if not empty(DMPieces.TaPieceVisu.FindField('Compte').AsString) then
      if DMPieces.TaPieceVisu.FindField('Compte').AsString[1] = '+' then
          GrDBGrid1.Columns.Items[2].Title.Caption:='Tiers';
      CalcSolde;
     end;
  end;

end;

procedure TTabVisuPiece2.pmRglement1Click(Sender: TObject);
Var
ParamAffichPointage:TParamAffichPointage;
//SavePlace: TBookmark;
begin
  try
    self.Visible:=false;
    formstyle:=fsnormal;
    self.Visible:=true;
    Initialise_TParamAffichPointage(ParamAffichPointage);
    if not empty(GrDBVisuEcriture.DataSource.DataSet.FindField('Tiers').asstring)then
      ParamAffichPointage.CptTiers:=GrDBVisuEcriture.DataSource.DataSet.FindField('Tiers').asstring
    else
      if dmplan.CptEstPointable(GrDBVisuEcriture.DataSource.DataSet.FindField('Compte').asstring)then
        ParamAffichPointage.CptTiers:=GrDBVisuEcriture.DataSource.DataSet.FindField('Compte').asstring;
    if not empty(ParamAffichPointage.CptTiers) then
      begin                                         
         ParamAffichPointage.ALettrer:=true;
         ParamAffichPointage.DateDeb:=0;
         ParamAffichPointage.DateFin:=E.DatExoFin;
         ParamAffichPointage.ID_Ecriture_Appelant:=GrDBVisuEcriture.DataSource.DataSet.FindField('id').AsInteger;
         ParamAffichPointage.ID_Reste_Appelant:=0;
         ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;

         if not VeriffNumeric(GrDBVisuEcriture.DataSource.DataSet.FindField('debitSaisie')).VideOUZero then
           begin
             ParamAffichPointage.SensAppelant:='D';
             ParamAffichPointage.Montant_Appelant:=GrDBVisuEcriture.DataSource.DataSet.FindField('debitsaisie').ascurrency;
           end
         else
           begin
             ParamAffichPointage.SensAppelant:='C';
             ParamAffichPointage.Montant_Appelant:=GrDBVisuEcriture.DataSource.DataSet.FindField('Creditsaisie').ascurrency;
           end;
         ParamAffichPointage.Reference:=GrDBGrid1.DataSource.DataSet.FindField('Reference').AsString;
         GestionAffichagePointageSurRef(true,true,ParamAffichPointage,not e.ExerciceCloture);
      end
    else
       ShowMessage('Attention !'+RetourChariotDouble+'Seules les lignes d''écritures concernant un compte pointables peuvent être pointées !');
  finally
    //formstyle:=fsnormal;
    formstyle:=fsStayOnTop;
    self.Visible:=true;
  end;//fin du finally
end;

procedure TTabVisuPiece2.pmTableauTva1Click(Sender: TObject);
begin
//	if (FVisuTva = Nil) Then
//   	FVisuTva:= TVisuTva.Create(Self);
//
//
//   FPiece.TvaDeclaration;
//   FVisuTva.Affiche(FPiece);
end;

procedure TTabVisuPiece2.Modification1Click(Sender: TObject);
var
Validation:boolean;
begin
//   if SaisiePiece = Nil then SaisiePiece:= TSaisiePiece.Create(Self);
//   SaisiePiece.tag:=0;
//   SaisiePiece.edReference.Text:=DBEdit1.Text;
//   Validation:=true;
//   SaisiePiece.edReferenceValidation(SaisiePiece.edReference,Validation);
//   SaisiePiece.show;
end;

procedure TTabVisuPiece2.PaGrilleResize(Sender: TObject);
begin
FormateTailleColonne(GrDBGrid1,18,[4,2,2,2,6]);
FormateTailleColonne(GrDBVisuEcriture,21,[3,3,5,1,1,3,3]);

WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);

Panel7.Width:=RenvoiTailleColonne(GrDBVisuEcriture,[0,1,2,3,4,5])+10;
GrGrid2.ColWidths[0]:=RenvoiTailleColonne(GrDBVisuEcriture,[6]);
GrGrid2.ColWidths[1]:=RenvoiTailleColonne(GrDBVisuEcriture,[7]);

Panel6.Width:=Panel7.Width;
GrGrid1.ColWidths[0]:=GrGrid2.ColWidths[0];
GrGrid1.ColWidths[1]:=GrGrid2.ColWidths[1];
end;

procedure TTabVisuPiece2.FormActivate(Sender: TObject);
begin
InitModifiable;
Initialiser_ShortCut_Main(true);
GrDBVisuEcriture.ParamColor:=true;
GrDBVisuEcriture.Param:=ParamUtil.CouleurDBGrid;
GrDBVisuEcriture.UpDateColor;

GrDBGrid1.ParamColor:=true;
GrDBGrid1.Param:=ParamUtil.CouleurDBGrid;
GrDBGrid1.UpDateColor;

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

Formshow(self);
PaBtnResize(PaBtn);
//FormateTailleBoutton([BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,PaBtn.height + 1);
if activecontrol.ClassNameIs('TButton') then BtnModifierEnter(activecontrol);

Patitre.visible:=Main.AfficheTitre;

calcSolde;
//SetTextAlign(GrGrid2.Canvas.Handle,TA_Right);
//showmessage(GrGrid2.Objects[0,0].ClassName);
//TLabel(GrGrid2.Objects[0,0]).Alignment:=taRightJustify;
end;

procedure TTabVisuPiece2.TaEcritureVisuAfterScroll(DataSet: TDataSet);
begin
if TabDetails.TabIndex > -1 then
 begin
//   TabDetails.Tabs[TabDetails.TabIndex]:=DMPieces.TaPieceVisu.FindField('Reference').AsString;
   DBDateTva.Visible:=DMEcritures.TaEcritureVisu.FindField('TvaType').AsString = 'D';
 end;
end;

procedure TTabVisuPiece2.TaPieceVisuAfterScroll(DataSet: TDataSet);
begin

if TabDetails.TabIndex > -1 then
 begin
   TabDetails.Tabs[TabDetails.TabIndex]:=DMPieces.TaPieceVisu.FindField('Reference').AsString;
//   DBDateTva.Visible:=DMEcritures.TaEcritureVisu.FindField('TvaType').AsString = 'D';
   ListeID[TabDetails.TabIndex]:=DMPieces.TaPieceVisu.FindField('ID').AsString;
 end;
    GrDBGrid1.Columns.Items[2].Title.Caption:='Compte';
    if not empty(DMPieces.TaPieceVisu.FindField('Compte').AsString) then
      if DMPieces.TaPieceVisu.FindField('Compte').AsString[1] = '+' then
          GrDBGrid1.Columns.Items[2].Title.Caption:='Tiers';
CalcSolde;

end;

procedure TTabVisuPiece2.Visualisation1Click(Sender: TObject);
begin
if ((activeControl = GrDBGrid1) or (GrilleActive = GrDBGrid1)) then
 begin
   case GrDBGrid1.SelectedIndex of
      2:Begin
          if not empty(DMPieces.TaPieceVisu.FindField('Compte').AsString) then
          begin
            if DMPieces.TaPieceVisu.FindField('Compte').AsString[1] <> '+' then
              DetailEcritureCompte(DMPieces.TaPieceVisu.FindField('Compte').AsString,true,false)
              else
               DetailEcritureTiers(DMPieces.TaPieceVisu.FindField('Compte').AsString,true);
          end;
        End;
      else GrDBGrid1.SetFocus;
//      1: ;
   end;
 end
 else
if ((activeControl = GrDBVisuEcriture) or (GrilleActive = GrDBVisuEcriture)) then
 begin
    if not empty(DMEcritures.TaEcritureVisu.FindField('Compte').AsString) then
    begin
      if DMEcritures.TaEcritureVisu.FindField('Compte').AsString[1] <> '+' then
         DetailEcritureCompte(DMEcritures.TaEcritureVisu.FindField('Compte').AsString,true,False)
         else
          DetailEcritureTiers(DMEcritures.TaEcritureVisu.FindField('Compte').AsString,true);
    end
    else GrDBVisuEcriture.SetFocus;
//     DetailEcritureCompte(DMEcritures.TaEcritureVisu.FindField('Compte').AsString,true)
 end;
//if activeControl = DBEdit2 then
// begin
//   if not empty(DBEdit2.Text) then
//      if DBEdit2.Text[1] <> '+' then
//         DetailEcritureCompte(DMPieces.TaPieceVisu.FindField('Compte').AsString,true)
//         else
//          DetailEcritureTiers(DMPieces.TaPieceVisu.FindField('Compte').AsString,true);
// end
// else
//if ((activeControl = DBEdit5) or (activeControl = DBEdit1)) then
// begin
//  DetailEcritureJournal(DMPieces.TaPieceVisu.findField('Journal').AsInteger,true);
// end
// else
//  begin
//   if FTvaCompteDeTva(DMEcritures.TaEcritureVisu.FindField('Compte').AsString) then
//     DetailEcritureCompte(DMEcritures.TaEcritureVisu.FindField('Compte').AsString,true)
//   else
//     DetailEcritureCompteTVA(DMEcritures.TaEcritureVisu.FindField('Compte').AsString,FTvaRecupCodeTva(DMEcritures.TaEcritureVisu.FindField('Compte').AsString),true);
//  end;
GrDBGrid1.DataSource.DataSet.refresh;
GrDBVisuEcriture.DataSource.DataSet.refresh;
end;

procedure TTabVisuPiece2.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
canclose:=true;
InitialiseTable_A_Nil;{ isa  le  29/01/04 }
end;

procedure TTabVisuPiece2.PaBtnResize(Sender: TObject);
begin
BtnValider.Visible:=Modifiable;
if Modifiable then
  FormateTailleBoutton([BtnFermer,BtnValider,BtnImprimer,BtnDetail],PaBtn,90,PaBtn.height + 1)
else
  FormateTailleBoutton([BtnFermer,BtnImprimer,BtnDetail],PaBtn,90,PaBtn.height + 1);
end;

procedure TTabVisuPiece2.BtnModifierEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TTabVisuPiece2.BtnModifierExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);

end;

procedure TTabVisuPiece2.FormDeactivate(Sender: TObject);
begin
if activecontrol.ClassNameIs('TButton') then BtnModifierExit(activecontrol);
Modifiable:=false;
end;

procedure TTabVisuPiece2.BtnImprimerClick(Sender: TObject);
begin
  try
    self.Visible:=false;
    formstyle:=fsnormal;
    self.Visible:=true;
    EditionDesPiecesL(C_EditionSimple,false,DMPieces.TaPieceVisu.FindField('Reference').asstring,nil,0,e.DatExoFin);

  finally
    self.Visible:=false;
    //formstyle:=fsnormal;
    formstyle:=fsStayOnTop;           
    self.Visible:=true;
  end;
end;

procedure TTabVisuPiece2.DBCodeTvaClick(Sender: TObject);
begin
DetailEcritureCompteTVA(FTvaRecupCompteTva(DBCodeTva.Field.AsString),DBCodeTva.Field.AsString,true);
end;

procedure TTabVisuPiece2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if shift = [SsCtrl] then
 Begin
 case key of
    Vk_RIGHT:begin
              if TabDetails.TabIndex < (TabDetails.Tabs.Count-1) then
                 TabDetails.TabIndex:=TabDetails.TabIndex+1
              else TabDetails.TabIndex:=0;
               TabDetailsChange(TabDetails);
             end;
    VK_LEFT:begin
              if TabDetails.TabIndex > 0 then
              TabDetails.TabIndex:=TabDetails.TabIndex-1
              else TabDetails.TabIndex:=TabDetails.Tabs.Count-1;
              TabDetailsChange(TabDetails);
            end;
 end;

 End;
if Key = VK_ESCAPE then
  begin
    Key:= 0;
    TableGereRollBack(GrDBGrid1.DataSource.DataSet);
    TableGereRollBack(GrDBVisuEcriture.DataSource.DataSet);
    Self.Close;
  end;
end;

procedure TTabVisuPiece2.RxSpeedButton1Click(Sender: TObject);
var
i:integer;
REf,ID:string;
begin
  Ref:=TabDetails.Tabs[TabDetails.TabIndex];
  ID:=ListeID.Strings[TabDetails.TabIndex];
  ListeID.Clear;
  TabDetails.Tabs.Clear;
  ListeID.Insert(0,ID);
  DMpieces.TaPieceVisu.Locate('ID',strtoint_lgr(ID),[]);
  TabDetails.Tabs.Insert(0,DMpieces.TaPieceVisu.FieldByName('Reference').AsString);
  TabDetails.TabIndex:=0;
//
end;

procedure TTabVisuPiece2.GrGrid2DrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
  var
    S: string;
begin
//    SetTextAlign(GrGrid2.Canvas.Handle,TA_RIGHT);
//    S := GRGRid2.Cells[Col, Row];
//    ExtTextOut(GRGRid2.Canvas.Handle, Rect.Left + 2, Rect.Top + 2, ETO_CLIPPED or
//      ETO_OPAQUE , @Rect, PChar(S), Length(S), nil);
end;

procedure TTabVisuPiece2.GrDBVisuEcritureEnter(Sender: TObject);
begin
GrilleActive:=(sender as TWincontrol);
end;

procedure TTabVisuPiece2.Dtailpointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
try
    self.Visible:=false;
    formstyle:=fsnormal;
    self.Visible:=true;
if activecontrol=GrDBVisuEcriture then
  Begin//si
    if ((not empty(GrDBVisuEcriture.DataSource.DataSet.findField('Tiers').AsString))or(dmplan.CptEstPointable(GrDBVisuEcriture.DataSource.DataSet.findField('Compte').AsString))) then
    begin
//           Initialise_TParamAffichPointage(ParamAffichPointage);
//           ParamAffichPointage.ALettrer:=false;
//           if not empty(GrDBVisuEcriture.DataSource.DataSet.findField('Tiers').AsString)then
//             ParamAffichPointage.CptTiers:=GrDBVisuEcriture.DataSource.DataSet.findField('Tiers').AsString
//           else
//             ParamAffichPointage.CptTiers:=GrDBVisuEcriture.DataSource.DataSet.findField('Compte').AsString;
//           ParamAffichPointage.DateDeb:=0;
//           ParamAffichPointage.DateFin:=0;
//           ParamAffichPointage.ID_Ecriture_Appelant:=GrDBVisuEcriture.DataSource.DataSet.FindField('ID').AsInteger;
//           ParamAffichPointage.ID_Reste_Appelant:=0;
//           ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;
//           ParamAffichPointage.Reference:=GrDBGrid1.DataSource.DataSet.FindField('Reference').AsString;
//           GestionAffichagePointageSurCompte(ParamAffichPointage);

//       begin
       Initialise_TParamAffichPointage(ParamAffichPointage);
//        ParamAffichPointage.ALettrer:=false;
        if not empty(GrDBVisuEcriture.DataSource.DataSet.findField('Tiers').AsString)then
          ParamAffichPointage.CptTiers:=GrDBVisuEcriture.DataSource.DataSet.findField('Tiers').AsString
        else
          ParamAffichPointage.CptTiers:=GrDBVisuEcriture.DataSource.DataSet.findField('Compte').AsString;
        ParamAffichPointage.ID_Ecriture_Appelant:=GrDBVisuEcriture.DataSource.DataSet.FindField('ID').AsInteger;
        DetailPointageAffich(ParamAffichPointage.CptTiers,inttostr(ParamAffichPointage.ID_Ecriture_Appelant),0,true,true);
//       end;
    end
    else
    begin
      ShowMessage('Attention !'+RetourChariotDouble+'Seules les lignes d''écritures concernant un compte pointables peuvent être pointées !');
    end;
  End;//fin si
finally
    self.Visible:=false;
    //formstyle:=fsnormal;
    formstyle:=fsStayOnTop;
    self.Visible:=true;
end;
end;

procedure TTabVisuPiece2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   if DetailEcr <> nil then
    begin
      DetailEcr.AppellantVisuPiece:= false;
   end;

if AppellantDetailEcr then
 begin
   AppellantDetailEcr := false;
   if DetailEcr <> nil then
    begin
      if DetailEcr.CanFocus then
       DetailEcr.SetFocus;
      DetailEcr.AppellantVisuPiece:= false;
   end;
 end;
Modifiable:=false;
InitModifiable;
end;

procedure TTabVisuPiece2.Modifierpice1Click(Sender: TObject);
begin
  try
  Visible:=false;
  FormStyle:=fsNormal;
  Visible:=true;
  //showmessage(VersionUlterieur);
  ModificationPieceExistante(GrDBGrid1.DataSource.DataSet.findField('Reference').AsString,self.Name);
  GrDBGrid1.DataSource.DataSet.refresh;
  //GrDBVisuEcriture.DataSource.DataSet.refresh;
  finally
  Visible:=false;
    //formstyle:=fsnormal;
    formstyle:=fsStayOnTop;
  Visible:=true;
  end;
end;


procedure TTabVisuPiece2.InitModifiable;
var
rang : integer;
begin
  try
      DMEcritures.TaEcritureVisu.Close;
      DMpieces.TaPieceVisu.Close;
     if Modifiable then
       begin
          GrDBGrid1.ReadOnly:=false;
          (GrDBGrid1.DataSource.DataSet as TTable).ReadOnly:=false;
          GrDBVisuEcriture.ReadOnly:=false;
          (GrDBVisuEcriture.DataSource.DataSet as TTable).ReadOnly:=false;
          //traiter table pièce
          rang:=0;
          while rang<GrDBGrid1.DataSource.DataSet.FieldCount-1 do
            begin
              if GrDBGrid1.DataSource.DataSet.Fields[rang].FieldName='Libelle' then
                GrDBGrid1.DataSource.DataSet.Fields[rang].ReadOnly:=false
              else
                GrDBGrid1.DataSource.DataSet.Fields[rang].ReadOnly:=true;
            inc(rang);
            end;
          //traiter table ecriture
          rang:=0;
          while rang<GrDBVisuEcriture.DataSource.DataSet.FieldCount-1 do
            begin
              if GrDBVisuEcriture.DataSource.DataSet.Fields[rang].FieldName='Libelle' then
                GrDBVisuEcriture.DataSource.DataSet.Fields[rang].ReadOnly:=false
              else
                GrDBVisuEcriture.DataSource.DataSet.Fields[rang].ReadOnly:=true;
            inc(rang);
            end;
       end
     else
       begin
          GrDBGrid1.ReadOnly:=true;
          (GrDBGrid1.DataSource.DataSet as TTable).ReadOnly:=true;
          GrDBVisuEcriture.ReadOnly:=true;
          (GrDBVisuEcriture.DataSource.DataSet as TTable).ReadOnly:=true;
       end;
  except
    DMEcritures.TaEcritureVisu.Close;
    DMpieces.TaPieceVisu.Close;
    GrDBGrid1.ReadOnly:=true;
    (GrDBGrid1.DataSource.DataSet as TTable).ReadOnly:=true;
    GrDBVisuEcriture.ReadOnly:=true;
    (GrDBVisuEcriture.DataSource.DataSet as TTable).ReadOnly:=true;
  end;
end;

procedure TTabVisuPiece2.BtnValiderClick(Sender: TObject);
begin
TableGerePost(GrDBGrid1.DataSource.DataSet);
TableGerePost(GrDBVisuEcriture.DataSource.DataSet);
end;

procedure TTabVisuPiece2.ValiderClick(Sender: TObject);
begin
BtnValider.Click;
end;

procedure TTabVisuPiece2.Exporter1Click(Sender: TObject);
begin
  try
    self.Visible:=false;
    formstyle:=fsnormal;
    self.Visible:=true;
    EditionDesPiecesL(C_Exportation,false,DMPieces.TaPieceVisu.FindField('Reference').asstring,nil,0,e.DatExoFin);

  finally
    self.Visible:=false;
    //formstyle:=fsnormal;
    formstyle:=fsStayOnTop;
    self.Visible:=true;
  end;
end;

end.
