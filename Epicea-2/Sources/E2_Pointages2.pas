unit E2_Pointages2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DMPointages2,
  Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, StdCtrls, Mask, ToolEdit,
  CurrEdit, RXCtrls, ExtCtrls, Menus,db,E2_Librairie_Obj,LibSQL,LibZoneSaisie,
  E2_Decl_Records,GR_Librairie_Obj,dbtables, GrGrid,E2_LibInfosTable,
  LibRessourceString,LibDates,DMParamEnt,Registry,DMConstantes, LibGestionParamXML, jpeg;

type
  TPointages2 = class(TForm)
    PaGrille: TPanel;
    paEntete: TPanel;
    EdCompte: TEdit;
    EdLibelle: TEdit;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    PaBas: TPanel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    GrDBPointage: TGrDBGrid;
    PopupMenuPointage: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    pmTouteslescritures1: TMenuItem;
    pmAutomatique1: TMenuItem;
    pmTriparDate1: TMenuItem;
    pmTriparMontant1: TMenuItem;
    pmRglement1: TMenuItem;
    N3: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    Label6: TLabel;
    Label2: TLabel;
    Panel7: TPanel;
    LaInfoResteDC: TLabel;
    LaInfoRestePartiel: TLabel;
    PaCumul1: TPanel;
    Panel6: TPanel;
    GrGrid3: TGrGrid;
    PaCumul2: TPanel;
    Panel1: TPanel;
    GrGrid2: TGrGrid;
    modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    DtailPointages1: TMenuItem;
    Toutdpointer1: TMenuItem;
    EdPlusTiersEntete: TEdit;
    outpointer1: TMenuItem;
    Button1: TButton;
    Pointageautomatiquejusqusolde01: TMenuItem;
    procedure EdCompteEnter(Sender: TObject);
    procedure GestionFiltrageParamCpt;
    procedure TaCompteFilterRecordComptePointable(DataSet: TDataSet; var Accept: Boolean);
    procedure EdCompteExit(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdCompteKeyPress(Sender: TObject; var Key: Char);
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure paEnteteResize(Sender: TObject);
    procedure GrDBPointageColExit(Sender: TObject);
    procedure GrDBPointageDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    Procedure FormatePanelTitreGrille(InfoReste:TInfoResteDCSurCompte);
    procedure BtnEnregistrerClick(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure EtatInitial;
    procedure GrDBPointageColEnter(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure pmTriparDate1Click(Sender: TObject);
    procedure pmTriparMontant1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pmAutomatique1Click(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure GrDBPointageEnter(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GrDBPointageExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure pmRglement1Click(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure Insrer1Click(Sender: TObject);
    procedure DtailPointages1Click(Sender: TObject);
    procedure GrDBPointageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Toutdpointer1Click(Sender: TObject);
    procedure GestionDuLibelleSurPlusAutomatique;
    procedure GrDBPointageKeyPress(Sender: TObject; var Key: Char);
    procedure outpointer1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Pointageautomatiquejusqusolde01Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Pointages2: TPointages2;
  CodeTmp:string;
  MessDerSub:boolean;
  InfoResteDCSurCompte:TInfoResteDCSurCompte;
  PlusDefautEntete,PlusAutomatiqueEntete:boolean;


implementation

uses E2_AideCompte, DMPlanCpt, E2_Main, E2_DetailEcr, DMEcriture,
  E2_SaisieReglement, DMJournaux, E2_AffectReglement, E2_VisuPointage,
  DMRecherche;

{$R *.DFM}

procedure TPointages2.EdCompteEnter(Sender: TObject);
begin
CodeTmp:=EdCompte.Text;
end;

procedure TPointages2.GestionFiltrageParamCpt;
var
ListeCpt:TStringList;
begin
   try
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);
   if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);

   ListeCpt:=TStringList.Create;
  // ListeCpt:=DMPlan.FiltrageParamCPT(24,e.Regime);
   ListeCpt:=DMPlan.FiltrageParamCPT(42,e.Regime);
   DMPlan.TaCompte.OnFilterRecord:=TaCompteFilterRecordComptePointable;
   AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
//   aidecompte.InitialiseCompte;
   finally
   if ListeCpt<>nil then
   ListeCpt.Free;
   end;//fin du try finally
End;

procedure TPointages2.TaCompteFilterRecordComptePointable(DataSet: TDataSet; var Accept: Boolean);

begin
if not((csDestroying)in dataset.ComponentState) then
  begin
  if DataSet.Name <> 'quLibelle' then
   begin
     try
      accept:=((length(DataSet.findField('Compte').AsString)>2) and (DataSet.findField('Pointable').AsBoolean=true))
     except
       accept:=false;
     end;
   end;
  end;
end;

procedure TPointages2.EdCompteExit(Sender: TObject);
var
ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
Recherche_:integer;
begin
    MessDerSub:=false;
    GestionFiltrageParamCpt;
    if EdPlusTiersEntete.text='+' then
      Recherche_:=1
    else
      Recherche_:=0;
   if AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],false,MessDerSub,false,true,true,true,recherche_) then
   begin
     InfoResteDCSurCompte:=RecupDetteCreance('',edCompte.Text,'',[''],0,e.DatExoFin,0,0,nil,false);
     FormatePanelTitreGrille(InfoResteDCSurCompte);
     ResteDCInfoLettrageEnCours:=DMPointage2.CalculLettrageEnCours(nil,EdCompte.Text,DMPointage2.LettrageEnCours,0,'');
     if ResteDCInfoLettrageEnCours.SoldeResteAuDebit then
     GrGrid3.cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', ResteDCInfoLettrageEnCours.SoldeReste)
     else
     GrGrid3.cells[0,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', ResteDCInfoLettrageEnCours.SoldeReste);
     if copy(edcompte.text,1,1)='+' then
       edlibelle.text:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[edcompte.text]).Nom
     else
       edlibelle.text:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'compte',[edcompte.text]).Libelle;
   end
   else
   edCompte.SetFocus;

GestionDuLibelleSurPlusAutomatique;

end;

procedure TPointages2.Aide1Click(Sender: TObject);
var
recherche_:integer;
begin
//si on est sur l'entete de la pièce
///////////////////
 If activecontrol = edCompte Then
  //Afficher aidecompte filtré
  begin
    MessDerSub:=false;
    GestionFiltrageParamCpt;
    //if copy(edCompte.text,1,1)='+' then
    if EdPlusTiersEntete.Text='+'then
      Recherche_:=1
    else
      Recherche_:=0;
    AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],true,MessDerSub,false,true,true,true,recherche_);
    MessDerSub:=true;
GestionDuLibelleSurPlusAutomatique;
  end;//fin si activecontrol = edCompte
///////////////////
end;

procedure TPointages2.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin
if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(self); 
 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
 Registre:= TRegistry.Create;

   try
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              PlusDefautEntete:=ReadBool('PlusDefautEntete'); // PB
              PlusAutomatiqueEntete:=ReadBool('PlusAutoEntete'); // PB
            except
              PlusDefautEntete:=E.PlanAuxT;// PB
              if PlusDefautEntete then PlusAutomatiqueEntete:=true;// PB
            end;
         end;
   finally
     Registre.Free;
   end;
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
 MessDerSub:=true;
end;

procedure TPointages2.EdCompteKeyPress(Sender: TObject; var Key: Char);
begin
 if key in [#97..#122,#231..#233,#224,#249] then
 key:=uppercase(key)[1];
 if key = #43 then // + pour rajouter le plus
   Begin
    if empty(EdCompte.Text) and E.PlanAuxT then
     begin
       key:=#0;
       EdCompte.Text:='+';
       EdCompte.SelStart:=length(EdCompte.Text);
       PlusDefautEntete:=true;
       PlusAutomatiqueEntete:=true;
       EdPlusTiersEntete.Text:='+';
     end
     else
     begin
      if PlusAutomatiqueEntete then
       if copy(EdCompte.text,1,1)<>'+' then
        begin
         key:=#0;
         EdCompte.text:='+'+EdCompte.text;
         EdCompte.SelStart:=length(EdCompte.Text);
        end;
     end;
   End;

 // PB
 if key = #46 then // . pour enlever le + par défaut
   Begin
    if not empty(EdPlusTiersEntete.Text) then
     begin
       EdPlusTiersEntete.Text:='';
       key:=#0;
       EdCompte.Text:='';
       EdCompte.SelStart:=length(EdCompte.Text);
       PlusDefautEntete:=False;
       PlusAutomatiqueEntete:=False;
     end
     else
     Begin
       EdPlusTiersEntete.Text:='+';
       key:=#0;
       EdCompte.Text:='+';
       PlusDefautEntete:=True;
       PlusAutomatiqueEntete:=True;
       EdCompte.SelStart:=length(EdCompte.Text);
     End;

   End;
  if key in [#65..#90,#97..#122] then
   Begin
    if E.PlanAuxT then
     begin
       if copy(EdCompte.Text,1,1) <> '+' then
       EdCompte.Text:='+'+EdCompte.Text;
       EdCompte.SelStart:=length(EdCompte.Text);
       PlusDefautEntete:=true;
       PlusAutomatiqueEntete:=true;
       EdPlusTiersEntete.Text:='+';
     end;
    end;

  if ((key = #8) and (PlusAutomatiqueEntete) and (EdCompte.SelStart = 1)) then
   begin
       EdPlusTiersEntete.Text:='';
       key:=#0;
       EdCompte.Text:='';
       EdCompte.SelStart:=length(EdCompte.Text);
       PlusDefautEntete:=False;
       PlusAutomatiqueEntete:=False;
   end;
GestionDuLibelleSurPlusAutomatique;
if key in [#13,#27] then
  key:=#0;
end;

procedure TPointages2.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TPointages2.PaGrilleResize(Sender: TObject);
begin
WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);
FormateTailleColonne(GrDBPointage,20,[2,4,2,2,2,1,2,1,2]);

GrGrid2.ColWidths[0]:=GrDBPointage.ColWidths[9];
GrGrid2.ColWidths[1]:=GrDBPointage.ColWidths[9];

Panel1.Width:=RenvoiTailleColonne(GrDBPointage,[0,1,2,3,4,5,6,7,8])-(GrDBPointage.ColWidths[9] div 2);

GrGrid3.ColWidths[0]:=GrDBPointage.ColWidths[7];
GrGrid3.ColWidths[1]:=GrDBPointage.ColWidths[8];
GrGrid3.ColWidths[2]:=GrDBPointage.ColWidths[9];

Panel6.Width:=RenvoiTailleColonne(GrDBPointage,[0,1,2,3,4,5,6])+10;

end;

procedure TPointages2.FormShow(Sender: TObject);
var
Valide:boolean;
begin
try//finally
GrDBPointage.DataSource.DataSet.DisableControls;
//idPointage_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').asinteger;
ReadOnlyWinControl([TControl(GrDBPointage.Columns[0]),
                    TControl(GrDBPointage.Columns[1]),
                    TControl(GrDBPointage.Columns[2]),
                    TControl(GrDBPointage.Columns[3]),
                    TControl(GrDBPointage.Columns[4]),
                    TControl(GrDBPointage.Columns[5]),
                    TControl(GrDBPointage.Columns[6])],TRue);
EdCompte.SetFocus;
//DMPointage2.TaResteDC.OnFilterRecord:=TaResteDCFilterRecordPourPointage;
if empty(EdCompte.Text) then
 begin
   InfoResteDCSurCompte:=RecupDetteCreance('','+*','',[''],0,e.DatExoFin,0,0,nil,False);
   FormatePanelTitreGrille(InfoResteDCSurCompte);
 end
   else
   begin
     GestionFiltrageParamCpt;
     valide:=AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],false,MessDerSub,true,true,true,true,1);
     if valide then
     begin
       valide:=DMPlan.CptEstPointable(edcompte.text);
       if not valide then
        begin
         InfoResteDCSurCompte:=RecupDetteCreance('','+*','',[''],0,e.DatExoFin,0,0,nil,False);
         FormatePanelTitreGrille(InfoResteDCSurCompte);
        end
       else
        begin
         InfoResteDCSurCompte:=RecupDetteCreance('',EdCompte.Text,'',[''],0,e.DatExoFin,0,0,nil,False);
         FormatePanelTitreGrille(InfoResteDCSurCompte);
         GrDBPointage.SetFocus;
        end;
     end;
   end;
finally
  GrDBPointage.DataSource.DataSet.EnableControls;

//  GrDBPointage.DataSource.DataSet.locate('id',idPointage_EnCours,[]);
end;   
end;

procedure TPointages2.paEnteteResize(Sender: TObject);
begin
if ((paEntete.Width > 500) and (paEntete.Width < 730))then
 begin
  Label2.Width:=paEntete.Width - (Label2.left+10);
  EdLibelle.Width := Label2.Width -70;
 end;

end;

procedure TPointages2.GrDBPointageColExit(Sender: TObject);
var
RetourCtrlPointage:TErreurSaisie;
i:integer;
begin
   RetourCtrlPointage:=DMPointage2.CtrlSaisiePointage(GrDBPointage.SelectedField);
   if not RetourCtrlPointage.retour then
   case RetourCtrlPointage.CodeErreur of
     1101,1102:abort;
//      : ;
   end;
end;

procedure TPointages2.GrDBPointageDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  holdColor: TColor;
begin
if Column.Field.DataSet.FindField('Sens').AsString = 'C' then
 begin
      holdColor:=GrDBPointage.Canvas.Brush.Color;
      GrDBPointage.Canvas.Brush.Color :=$00B6FDB0;//$00808040;
      GrDBPointage.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      GrDBPointage.Canvas.Brush.Color := holdColor;
 end
 else
 begin
      holdColor:=GrDBPointage.Canvas.Brush.Color;
      GrDBPointage.Canvas.Brush.Color :=$00E4CAFF;//$005959FF;//$00808040;
      GrDBPointage.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      GrDBPointage.Canvas.Brush.Color := holdColor;
 end;
if not empty(Column.Field.DataSet.FindField('Lettre').AsString) then
 begin
      if DataCol in [7..8] then
      begin
        holdColor:=GrDBPointage.Canvas.Brush.Color;
        GrDBPointage.Canvas.Brush.Color :=$00D1D0C9;
        GrDBPointage.DefaultDrawColumnCell(Rect, DataCol, Column, State);
        GrDBPointage.Canvas.Brush.Color := holdColor;
      end;
 end;

end;

procedure TPointages2.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
GrDBPointage.ParamColor:=true;
GrDBPointage.Param:=ParamUtil.CouleurDBGrid;
GrDBPointage.UpDateColor;

GrGrid2.ParamColor:=true;
GrGrid2.Param:=ParamUtil.CouleurDBGrid;
GrGrid2.DessineContourLigne:=false;
GrGrid2.UpDateColor;

GrGrid3.ParamColor:=true;
GrGrid3.Param:=ParamUtil.CouleurDBGrid;
GrGrid3.DessineContourLigne:=false;
GrGrid3.UpDateColor;

DMPointage2.DaResteDC.OnStateChange:=ChangementEtatGrille;
EdCompteExit(EdCompte);
EtatInitial;
GrDBPointage.DataSource.DataSet.Close;
GrDBPointage.DataSource.DataSet.open;
DMPointage2.ForceLettrage:='';
if copy(edcompte.text,1,1)='+' then
  edlibelle.text:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[edcompte.text]).Nom
else
  edlibelle.text:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'compte',[edcompte.text]).Libelle;


end;

Procedure TPointages2.FormatePanelTitreGrille(InfoReste:TInfoResteDCSurCompte);
Begin

case InfoReste.NBLignePartiellementPointee of
  0,1:LaInfoRestePartiel.Caption:=IntToStr(InfoReste.NBLignePartiellementPointee) + ' ligne d''écritures partiellement pointée pour'+ InfoReste.MessageCpt;
else
 begin
   LaInfoRestePartiel.Caption:=IntToStr(InfoReste.NBLignePartiellementPointee) + ' lignes d''écritures partiellement pointée pour'+ InfoReste.MessageCpt;
 end;
end;

case InfoReste.NBLignePointee of
  0,1:LaInfoResteDC.Caption:=IntToStr(InfoReste.NBLignePointee) + ' ligne d''écritures entièrement pointée pour'+ InfoReste.MessageCpt;
else
 begin
   LaInfoResteDC.Caption:=IntToStr(InfoReste.NBLignePointee) + ' lignes d''écritures entièrement pointée pour'+ InfoReste.MessageCpt;
 end;
end;

case InfoReste.NBLigneResteAPointer of
   0,1:Begin
         Panel7.Caption:=IntToStr(InfoReste.NBLigneResteAPointer) + ' ligne d''écritures reste à pointer pour'+ InfoReste.MessageCpt;
       End;
   else
    begin
       Panel7.Caption:=IntToStr(InfoReste.NBLigneResteAPointer) + ' lignes d''écritures reste à pointer pour'+ InfoReste.MessageCpt;
    end;
end;

End;


procedure TPointages2.BtnEnregistrerClick(Sender: TObject);
var
ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
begin
if GrDBPointage.DataSource.State in [dsinsert,dsedit] then TableGerePost(GrDBPointage.DataSource.DataSet);
if DMPointage2.ValiderPointages(nil,edCompte.Text,true) then
 begin
   ChangementEtatGrille(DMPointage2.TaResteDC);
   InfoResteDCSurCompte:=RecupDetteCreance('',edCompte.Text,'',[''],0,e.DatExoFin,0,0,nil,False);
   FormatePanelTitreGrille(InfoResteDCSurCompte);
   if InfoResteDCSurCompte.NBLigneResteAPointer = 0 then
   EdCompte.SetFocus
   else
   GrDBPointage.Focused;
   EtatInitial;
 end
 else
 begin
   EtatInitial;
 end;
end;

Procedure TPointages2.InitialiseTable_A_Nil;
Begin
  //DMPointage2.DaResteDC.OnStateChange:=nil;
if DMPointage2<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMPointage2.DaResteDC]);
End;

procedure TPointages2.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
try
 Registre:= TRegistry.Create;

   try
      InitialiseTable_A_Nil;
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              WriteBool('PlusDefautEntete',PlusDefautEntete); // PB
              WriteBool('PlusAutoEntete',PlusAutomatiqueEntete); // PB
            except
              PlusDefautEntete:=E.PlanAuxT; // PB
              CloseKey;
            end;
         end;
   finally
		Registre.Free;
   end;
LibGestionParamXML.DestroyForm(Self,E.User);
if DMPointage2<>nil then DMPointage2.Free;
finally
Pointages2:=Nil;
end;
end;


procedure TPointages2.EtatInitial;
Begin
ChangementEtatGrille(GrDBPointage.datasource.DataSet);
DMPointage2.supprODDeclaration:=false;
end;


procedure TPointages2.GrDBPointageColEnter(Sender: TObject);
begin
if GrDBPointage.SelectedIndex = 8 then
if empty(GrDBPointage.DataSource.DataSet.FindField('Lettre').AsString) then
GrDBPointage.SelectedIndex:=7;
end;

procedure TPointages2.ChangementEtatGrille(Sender: TObject);
var
ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
begin
   case DMPointage2.TaResteDC.state of
   dsBrowse: begin
               GrDBPointage.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
//               GrDBPointage.SetFocus;
               if GrDBPointage.InplaceEditor <> nil then
                  GrDBPointage.EditorMode:=false;
               GrDBPointage.TitreColor(true);
               ResteDCInfoLettrageEnCours:=DMPointage2.CalculLettrageEnCours(nil,EdCompte.Text,DMPointage2.LettrageEnCours,0,'');

               GrGrid2.cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', ResteDCInfoLettrageEnCours.TotalMontantImputationSensD);
               GrGrid2.cells[1,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', ResteDCInfoLettrageEnCours.TotalMontantImputationSensC);

               ResteDCInfoLettrageEnCours:=DMPointage2.CalculLettrageEnCours(nil,EdCompte.Text,'*',0,'');

               if ResteDCInfoLettrageEnCours.SoldeTotalImputationAuDebit then
               GrGrid3.cells[2,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', ResteDCInfoLettrageEnCours.SoldeTotalImputation)
               else
               GrGrid3.cells[2,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', ResteDCInfoLettrageEnCours.SoldeTotalImputation);
               BtnEnregistrer.Enabled:=ResteDCInfoLettrageEnCours.Equilibre;

//               Case Self.Tag Of
//               1 : self.caption:='Stocks - Ouverture - Consultation';
//               2 : self.caption:='Stocks - Clôture - Consultation';
//               End; // Fin du case sur le Tag de la fenêtre


             end;

   dsEdit:   begin
               GrDBPointage.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               GrDBPointage.SetFocus;
               GrDBPointage.TitreColor(true);
//               Case Self.Tag Of
//               1 : self.caption:='Stocks - Ouverture - Modification';
//               2 : self.caption:='Stocks - Clôture - Modification';
//               End; // Fin du case sur le Tag de la fenêtre
             end;

   dsInsert: begin
               GrDBPointage.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               GrDBPointage.SetFocus;
               GrDBPointage.TitreColor(true);
//               Case Self.Tag Of
//               1 : self.caption:='Stocks - Ouverture - Insertion';
//               2 : self.caption:='Stocks - Clôture - Insertion';
//               End; // Fin du case sur le Tag de la fenêtre
             end;
   end;//fin du case.state
Panel1.Caption:='Totaux lettrage en cours { '+DMPointage2.LettrageEnCours+' } : ';
end;

procedure TPointages2.pmTriparDate1Click(Sender: TObject);
var
BookMark:TBookMark;
begin
//  TableDisableControlBookMark(DMPointage2.TaResteDC,BookMark);
  DMPointage2.TaResteDC.IndexFieldNames:='Tiers;Date;Reference';
//  TableEnableControlBookMark(DMPointage2.TaResteDC,BookMark);
end;

procedure TPointages2.pmTriparMontant1Click(Sender: TObject);
var
BookMark:TBookMark;
begin
//  TableDisableControlBookMark(DMPointage2.TaResteDC,BookMark);
  DMPointage2.TaResteDC.IndexFieldNames:='Tiers;Reste;Date;Reference';
//  TableEnableControlBookMark(DMPointage2.TaResteDC,BookMark);
end;

procedure TPointages2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
try
WinSuivPrec(Handle,key,[GrDBPointage,GrDBPointage.InplaceEditor]);
if key = VK_ESCAPE then
   begin //si échappe
   GrDBPointage.DataSource.DataSet.DisableControls;
   if ActiveControl = EdCompte then
    self.close;
   if ((ActiveControl = Pointages2.GrDBPointage) or (ActiveControl = Pointages2.BtnAnnuler)) then
    begin
     if GrDBPointage.DataSource.DataSet.State in [dsEdit] then
      begin
       GrDBPointage.DataSource.DataSet.Cancel;
       key:=0;
      end
       else
      begin
       Pointages2.EdCompte.SetFocus;
       key:=0;
      end;
    end;
   end;
finally
  GrDBPointage.DataSource.DataSet.EnableControls;
end;
end;

procedure TPointages2.pmAutomatique1Click(Sender: TObject);
var
   ListeLettres:tstringlist;
   i:integer;

begin





if not DMPointage2.RecupListeLettre_surDataset(GrDBPointage.DataSource.DataSet,false).Result then
//if empty(DMPointage2.LettrageEnCours) then
 begin


   DMPointage2.LettrageEnCours:='*';
   DMPointage2.LettrageAutomatique(GrDBPointage.DataSource.DataSet,EdCompte.Text,0,E.DatExoFin);
//   DMPointage2.LettrageAutomatique(GrDBPointage.DataSource.DataSet,EdCompte.Text,E.DatExoDebut,E.DatExoFin);
   ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
   DMPointage2.LettrageEnCours:='';
 end
 else
 begin
  Showmessage('Vous devez d''abord valider le lettrage en cours !');
 end;
 ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
end;

procedure TPointages2.Enregister1Click(Sender: TObject);
begin
BtnEnregistrer.Click;
end;

procedure TPointages2.GrDBPointageEnter(Sender: TObject);
begin
GrDBPointage.SelectedIndex:=7;
end;

procedure TPointages2.Visualisation1Click(Sender: TObject);
var
idPointage_EnCours:integer;
begin
try
idPointage_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').asinteger;
GrDBPointage.DataSource.dataset.DisableControls;

if ActiveControl = GrDBPointage then
begin//si on est sur la grille
if copy(EdCompte.Text,1,1)='+'then
  begin//si tiers
     if DetailEcritureTiers(EdCompte.Text,False) then
       case DetailEcr.Tag of
          1:begin
            if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMPointage2.TaResteDC.findfield('ID_Piece').AsInteger,[]) then
              PieceEcritureTiers;
            end;
       end;//fin du case
  end//fin si tiers
else
  Begin//si compte pointable
     if DetailEcritureCompte(EdCompte.Text,true,true) then
       case DetailEcr.Tag of
          1:begin
            if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMPointage2.TaResteDC.findfield('ID_Piece').AsInteger,[]) then
              PieceEcritureCompte;
            end;
       end;//fin du case
  End;//fin si compte pointable
end;//fin si on est sur la grille
if ActiveControl = EdCompte then
  DetailEcritureTiers(EdCompte.Text,true);
finally
  GrDBPointage.DataSource.dataset.EnableControls;
  GrDBPointage.DataSource.DataSet.locate('id',idPointage_EnCours,[]);
end;
end;

procedure TPointages2.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
canclose:=true;
if ((DMPointage2.RecupListeLettre_surDataset(GrDBPointage.DataSource.DataSet,true).Result)or(GrDBPointage.DataSource.DataSet.State in [dsinsert,dsedit])) then
 begin
  self.BringToFront;
  self.WindowState:=wsNormal;
  if not DMPointage2.Gestion_Annulation_Lettrage(GrDBPointage.DataSource.DataSet,'%','',true) then
   begin
    if BtnEnregistrer.Enabled then
     begin
      BtnEnregistrer.Click;
     end
    else
     begin
      showmessage('Vous devez équilibrer votre lettrage pour pouvoir le valider');
      GrDBPointage.SetFocus;
      canClose:=false;
     end;
   end
 end;
except
  canclose:=false;
end;
if CanClose then  InitialiseTable_A_Nil { isa  le  29/01/04 }
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);
 end;
//DMPointage2.DaResteDC.OnStateChange:=nil;
end;

procedure TPointages2.GrDBPointageExit(Sender: TObject);
var
CanClose:boolean;
begin
if ((activecontrol = EdCompte))then
 Begin
  if DMPointage2.RecupListeLettre_surDataset(GrDBPointage.DataSource.DataSet,true).Result then
   begin
    if not DMPointage2.Gestion_Annulation_Lettrage(GrDBPointage.DataSource.DataSet,'%','',true) then
     begin
      if BtnEnregistrer.Enabled then
       begin
        BtnEnregistrer.Click;
       end
      else
       begin
        showmessage('Vous devez équilibrer votre lettrage pour pouvoir le valider');
        GrDBPointage.SetFocus;
       end;
     end
      else
      DMPointage2.SuppressionLettrage_Tous_ApresGestionDesPointages(GrDBPointage.DataSource.DataSet,nil);

   end;
//  if not self.CloseQuery then GrDBPointage.SetFocus;
 End;

end;

procedure TPointages2.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);

end;

procedure TPointages2.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;

procedure TPointages2.BtnModifierClick(Sender: TObject);
begin
if ((activeControl = GrDBPointage) or (activeControl = BtnModifier)) then
 if GrDBPointage.DataSource.DataSet.State <> dsEdit then
  GrDBPointage.DataSource.DataSet.Edit;
end;

procedure TPointages2.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TPointages2.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TPointages2.pmRglement1Click(Sender: TObject);
Var
InfosJournal:TInfosModel;
BookMark:TBookMark;
ID_Reste_Appelant:integer;
ParamAffichPointage:TParamAffichPointage;
begin
 if ActiveControl = GrDBPointage then
  begin
   Initialise_TParamAffichPointage(ParamAffichPointage);
   ParamAffichPointage.ALettrer:=true;
   ParamAffichPointage.CptTiers:=EdCompte.Text;
   ParamAffichPointage.DateDeb:=0;
   ParamAffichPointage.DateFin:=E.DatExoFin;
   ParamAffichPointage.ID_Ecriture_Appelant:=GrDBPointage.DataSource.DataSet.FindField('ID_Ecriture').AsInteger;
   ParamAffichPointage.ID_Reste_Appelant:=GrDBPointage.DataSource.DataSet.FindField('ID').AsInteger;
   ParamAffichPointage.Reste_Appelant:=Infos_TInfosResteDC(DMRech.TaResteDCRech,'ID_Ecriture',[ParamAffichPointage.ID_Ecriture_Appelant]).Reste;

   if not VerifNumeric(GrDBPointage.DataSource.DataSet['debit']).VideOUZero then
     begin
       ParamAffichPointage.SensAppelant:='D';
       ParamAffichPointage.Montant_Appelant:=GrDBPointage.DataSource.DataSet.FindField('debit').ascurrency;
     end
   else
     begin
       ParamAffichPointage.SensAppelant:='C';
       ParamAffichPointage.Montant_Appelant:=GrDBPointage.DataSource.DataSet.FindField('Credit').ascurrency;
     end;

   ParamAffichPointage.Reference:=GrDBPointage.DataSource.DataSet.FindField('Reference').AsString;
   GestionAffichagePointageSurRef(false,false,ParamAffichPointage,not e.ExerciceCloture);
   TTable(GrDBPointage.DataSource.DataSet).locate('ID',ParamAffichPointage.ID_Reste_Appelant,[]);
  end;
 if ActiveControl <> GrDBPointage then
  begin
    GrDBPointage.SetFocus;
  end;
ChangementEtatGrille(GrDBPointage.DataSource.DataSet);  
//InfosJournal:=DMJournal.InfosJournal_Reference(DMPointage2.TaResteDC.findfield('Reference').AsString);
////InfosJournal:=Infos_TInfosJournal(DMJournal.TaJournalRech,'Reference',[DMPointage2.TaResteDC.findfield('Reference').AsString]);
//if InfosJournal.ResultInfos then
// case InfosJournal.ID_Journal of
//    // Achat
//    1:Begin
//       if SaisieReglements=nil then
//       SaisieReglements:=TSaisieReglements.Create(self);
//       SaisieReglements.ShowModal;
//
//       if SaisieReglements.ModalResult in [mrok,mrYes]then
//       begin
//
//       // Ici le code de créaion du règlement et de son pointage !!!
//
//
//      //   if ListeReglementRecup=nil then
//      //   ListeReglementRecup:=TStringList.Create;
//      // ListeReglementRecup:=SaisieReglements.ListeReglement;
//      // DMPieces.Piece1.Reglement:=true;
//      // BtnEnregistrerClick(self);
//       end;
//
//      End;
//
//    // Vente
//    2:Begin
//       if SaisieReglements=nil then
//       SaisieReglements:=TSaisieReglements.Create(self);
//       SaisieReglements.ShowModal;
//
//       if SaisieReglements.ModalResult in [mrok,mrYes]then
//       begin
//
//       // Ici le code de créaion du règlement et de son pointage !!!
//
//
//      //   if ListeReglementRecup=nil then
//      //   ListeReglementRecup:=TStringList.Create;
//      // ListeReglementRecup:=SaisieReglements.ListeReglement;
//      // DMPieces.Piece1.Reglement:=true;
//      // BtnEnregistrerClick(self);
//       end;
//
//      End;
//
//    // OD
//    3:Begin
//
//      End;
//
//    // Banque
//    4:Begin
//      ID_Reste_Appelant:=0;
//      ID_Reste_Appelant:=GrDBPointage.DataSource.DataSet.FindField('ID').AsInteger;
////      TableDisableControlBookMark(DMPointage2.TaResteDC,BookMark);
//      if AffectReglementAffiche(DMPointage2.TaResteDC,true,'','A','',0,E.DatExoDebut,E.DatExoFin,nil) then
//       begin
//         DMPointage2.DaResteDC.OnStateChange:=ChangementEtatGrille;
//         EdCompteExit(EdCompte);
//         ChangementEtatGrille(DMPointage2.TaResteDC);
//         if TTable(GrDBPointage.DataSource.DataSet).locate('ID',ID_Reste_Appelant,[]) then
//          begin
//            DMPointage2.LettrageEnregCourant(DMPointage2.TaResteDC,'A',0);
//          end;
//       end
//       else
//       begin
//         DMPointage2.DaResteDC.OnStateChange:=ChangementEtatGrille;
//         EdCompteExit(EdCompte);
//         ChangementEtatGrille(DMPointage2.TaResteDC);
//         TTable(GrDBPointage.DataSource.DataSet).locate('ID',ID_Reste_Appelant,[])
////         DMPointage2.ForceLettrage:='';
//       end;
//
////       if AffectReglement = nil then
////       AffectReglement:=TAffectReglement.Create(self);
////
////       AffectReglement.EdCompte.Text:=DMPointage2.TaResteDC.findfield('Tiers').AsString;
////
////      if not VerifFNumeric(DMPointage2.TaResteDC.findfield('Debit')).VideOUZero then
////      begin
////       RecupDetteCreance(AffectReglement.EdCompte.Text,'','C',E.DatExoDebut,E.DatExoFin,0,DMPointage2.TaResteDC.findfield('Reste').AsCurrency,nil);
////       DMPointage2.LettrageEnCours:='A';
////       DMPointage2.ForceLettrage:='A';
////       AffectReglement.ShowModal;
////       if AffectReglement.ModalResult in [mrCancel] then
////        Begin
////          DMPointage2.Gestion_Annulation_Lettrage(DMPointage2.TaResteDC,DMPointage2.LettrageEnCours,'',false);
////          DMPointage2.LettrageEnCours:='';
////          DMPointage2.ForceLettrage:='';
////        End;
////      end
////      else
////      if not VerifFNumeric(DMPointage2.TaResteDC.findfield('Credit')).VideOUZero then
////       begin
////       RecupDetteCreance(AffectReglement.EdCompte.Text,'','D',E.DatExoDebut,E.DatExoFin,0,DMPointage2.TaResteDC.findfield('Reste').AsCurrency,nil);
////       DMPointage2.LettrageEnCours:='A';
////       DMPointage2.ForceLettrage:='A';
////       AffectReglement.ShowModal;
////       end;
////         DMPointage2.DaResteDC.OnStateChange:=ChangementEtatGrille;
////         EdCompteExit(EdCompte);
////         ChangementEtatGrille(DMPointage2.TaResteDC);
////         DMPointage2.ForceLettrage:='';
////
//      End;
//
// end;
//
//
end;

procedure TPointages2.BtnSupprimerClick(Sender: TObject);
begin
DMPointage2.SuppressionLettrage_Enreg_Courant(GrDBPointage.DataSource.DataSet);
GrDBPointage.DataSource.DataSet.Next;
end;

procedure TPointages2.Supprimer1Click(Sender: TObject);
begin
BtnSupprimer.Click;
end;

procedure TPointages2.BtnInsererClick(Sender: TObject);
begin
if empty(DMPointage2.LettrageEnCours) then
 begin
  DMPointage2.LettrageEnCours:='a';
 end;
DMPointage2.LettrageEnregCourant(GrDBPointage.DataSource.DataSet,DMPointage2.LettrageEnCours,0);
GrDBPointage.DataSource.DataSet.Next;
end;

procedure TPointages2.Insrer1Click(Sender: TObject);
begin
BtnInserer.Click;
end;

procedure TPointages2.DtailPointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
if activeControl = GrDBPointage then
 begin
     if not VerifFNumeric(GrDBPointage.DataSource.DataSet.FindField('Debit')).VideOUZero then
     begin
      if GrDBPointage.DataSource.DataSet.FindField('Debit').AsCurrency > GrDBPointage.DataSource.DataSet.FindField('Reste').AsCurrency then
        DetailPointageAffich(EdCompte.Text,GrDBPointage.DataSource.DataSet.FindField('ID_Ecriture').AsString,0,true,true)
       else
         showmessage('Cette ligne n''est pas du tout pointée !');

     end
     else
     if not VerifFNumeric(GrDBPointage.DataSource.DataSet.FindField('Credit')).VideOUZero then
     begin
      if GrDBPointage.DataSource.DataSet.FindField('Credit').AsCurrency > GrDBPointage.DataSource.DataSet.FindField('Reste').AsCurrency then
        DetailPointageAffich(EdCompte.Text,GrDBPointage.DataSource.DataSet.FindField('ID_Ecriture').AsString,0,true,true)
        else
      showmessage('Cette ligne n''est pas du tout pointée !');

     end;
  ChangementEtatGrille(GrDBPointage.DataSource.DataSet);   
 end;

if activeControl = EdCompte then
 begin
   ParamAffichPointage.CptTiers:=EdCompte.Text;
   ParamAffichPointage.DateDeb:=0;
   ParamAffichPointage.DateFin:=E.DatExoFin;
//  DetailPointageAffich(EdCompte.Text,EdCompte.Text,2,true)
   if DMPointage2.InitTableVisuPointage(ParamAffichPointage.CptTiers,0,ParamAffichPointage.DateDeb,ParamAffichPointage.DateFin,'') then
    begin
      if VisuPointage = nil then
      VisuPointage:=TVisuPointage.Create(Application.MainForm);
      VisuPointage.show;
    end
    else
    begin
     Showmessage('Aucune écritures pour le tiers : '+ParamAffichPointage.CptTiers+' ,'+RetourChariotDouble+'dans la période du '+DateInfos(ParamAffichPointage.DateDeb).DateStr+' au '+DateInfos(ParamAffichPointage.DateFin).DateStr+' !');
    end;
 end;
end;

procedure TPointages2.GrDBPointageKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_INSERT then
 begin
  key:=0;
  BtnInserer.Click;
 end;
if key=VK_SPACE then
  Begin
    key:=0;
    if not empty(GrDBPointage.DataSource.DataSet.FindField('Lettre').asstring) then
      BtnSupprimer.Click
    else
      BtnInserer.Click;
  End;
if key = VK_DELETE then
 begin
  key:=0;
  BtnSupprimer.Click;
 end;
end;

procedure TPointages2.Toutdpointer1Click(Sender: TObject);
begin
  try
//    if empty(DMPointage2.LettrageEnCours) then
//      DMPointage2.LettrageEnCours:='A';
    DMPointage2.Gestion_Annulation_Lettrage(GrDBPointage.DataSource.DataSet,'%','',false);
  finally
    ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
  end;//fin finally
end;


procedure TPointages2.GestionDuLibelleSurPlusAutomatique;
begin
if copy(edCompte.Text,1,1)='+' then EdPlusTiersEntete.text:='+'
else EdPlusTiersEntete.text:='';
 if EdPlusTiersEntete.text='+' then
   Begin//si
     Label6.caption:='Tiers';
   End//fin si
 else
   Begin//si
     Label6.caption:='Compte';
   End;//fin si
end;


procedure TPointages2.GrDBPointageKeyPress(Sender: TObject; var Key: Char);
begin
if key=#32 then key:=#0;
end;

procedure TPointages2.outpointer1Click(Sender: TObject);
begin
  try //finally
  try//except
  TableGereStartTransaction(GrDBPointage.DataSource.DataSet);
    if empty(DMPointage2.LettrageEnCours) then
      DMPointage2.LettrageEnCours:='A';
      GrDBPointage.DataSource.DataSet.first;
    while (not GrDBPointage.DataSource.DataSet.Eof)do
    begin
    TableGereEdit(GrDBPointage.DataSource.DataSet);
      GrDBPointage.DataSource.DataSet.findfield('lettre').AsString:=DMPointage2.LettrageEnCours;
      GrDBPointage.DataSource.DataSet.findfield('Montant').AsCurrency:=GrDBPointage.DataSource.DataSet.findfield('debit').AsCurrency+
      GrDBPointage.DataSource.DataSet.findfield('Credit').AsCurrency;
    TableGerePost(GrDBPointage.DataSource.DataSet);
      GrDBPointage.DataSource.DataSet.next;
    end;
     //BtnEnregistrer.Click;
     Except
        TableGereRollBack(GrDBPointage.DataSource.DataSet);
     end;
  finally
    TableGereCommit(GrDBPointage.DataSource.DataSet);
    ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
  end;//fin finally
end;



procedure TPointages2.Button1Click(Sender: TObject);
var
mess:string;
begin
mess:='La colonne solde vous donne le solde progressif des restes à pointer (colonne reste).'+RetourChariotSimple+
'Avant même de commencer le lettrage (pointage), les lignes avec un solde à 0 vous permettent de voir à quels moments votre pointage sera équilibré.'+RetourChariotSimple+
'Attention !!! lorsque vous avez plusieurs pages d''écritures à pointer (lettrer), la colonne solde (progressif) peut être faussée si vous utilisez l’ascenseur pour vous déplacer dans la liste.'+RetourChariotDouble+
'Utilisez plutôt les touches "Flèche bas" /  "Flèche haut" ou "Pages suivante" / "Pages précédente" de votre clavier. ';
showmessage(mess);
end;

procedure TPointages2.Pointageautomatiquejusqusolde01Click(
  Sender: TObject);
var
   ListeLettres:tstringlist;
   i:integer;

begin
if not DMPointage2.RecupListeLettre_surDataset(GrDBPointage.DataSource.DataSet,false).Result then
 begin
   DMPointage2.LettrageEnCours:='*';
   DMPointage2.LettrageAutomatiqueSurSoldeFin(GrDBPointage.DataSource.DataSet,EdCompte.Text,0,E.DatExoFin);
   ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
   DMPointage2.LettrageEnCours:='';
 end
 else
 begin
  Showmessage('Vous devez d''abord valider le lettrage en cours !');
 end;
 ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
end;


end.
