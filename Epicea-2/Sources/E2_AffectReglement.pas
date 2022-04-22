unit E2_AffectReglement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, Grids, DBGrids,
  RXDBCtrl, ExRxDBGrid, GrDBGrid,E2_Librairie_Obj,LibSQL,LibZoneSaisie,
  E2_Decl_Records,GR_Librairie_Obj,Menus,db, GrGrid,registry,DMParamEnt,
  E2_LibInfosTable,DMRecherche,LibRessourceString,LibDates,DMConstantes,
  LibGestionParamXML,
  jpeg;


type
  TAffectReglement = class(TForm)
    PaGrille: TPanel;
    PaBas: TPanel;
    LaInfoResteDC: TLabel;
    LaInfoRestePartiel: TLabel;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    Panel7: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    RxSpeedButton1: TRxSpeedButton;
    paEntete: TPanel;
    Label6: TLabel;
    Label2: TLabel;
    EdCompte: TEdit;
    EdLibelle: TEdit;
    PopupMenuPointage: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    pmAutomatique1: TMenuItem;
    DtailPointages1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    pmTouteslescritures1: TMenuItem;
    pmTriparDate1: TMenuItem;
    pmTriparMontant1: TMenuItem;
    N3: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    GrDBAffectReg: TGrDBGrid;
    EdPlusTiersEntete: TEdit;
    GrGrid3: TGrGrid;
    Panel5: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    GrGrid1: TGrGrid;
    Panel6: TPanel;
    GrGrid2: TGrGrid;
    Panel4: TPanel;
    Toutdpointer1: TMenuItem;
    PaTools: TPanel;
    RxSBToutesPieces: TRxSpeedButton;
    RxSBAchatVentes: TRxSpeedButton;
    procedure PaBtnResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure paEnteteResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrDBAffectRegKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure pmAutomatique1Click(Sender: TObject);
    procedure DtailPointages1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure pmTriparDate1Click(Sender: TObject);
    procedure pmTriparMontant1Click(Sender: TObject);
    procedure GestionFiltrageParamCpt;
    procedure FormCreate(Sender: TObject);
   Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure GestionDuLibelleSurPlusAutomatique;
    procedure ChangementEtatGrille(Sender: TObject);
    Procedure FormatePanelTitreGrille(InfoReste:TInfoResteDCSurCompte);
    procedure GrDBAffectRegEnter(Sender: TObject);
    procedure GrDBAffectRegExit(Sender: TObject);
    procedure Toutdpointer1Click(Sender: TObject);
    procedure GrGrid2DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RxSBAchatVentesClick(Sender: TObject);
    procedure RxSBToutesPiecesClick(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);

    
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
   MontantARegler:currency;
   MontantReglement:currency;
   Sensreglement:integer;
   //ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
  end;

var
  AffectReglement: TAffectReglement;
  PlusDefautEntete,PlusAutomatiqueEntete:boolean;
  DernierCpt,DernierLibelle:string;
  MessDerSub:boolean;
  

  
implementation

uses E2_Main,DMPointages2, E2_AideCompte, E2_DetailEcr, DMEcriture,
  DMPlanCpt, E2_VisuPointage;

{$R *.DFM}

procedure TAffectReglement.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TAffectReglement.PaGrilleResize(Sender: TObject);
begin
  
  WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);
  FormateTailleColonne(GrDBAffectReg,17,[2,4,2,2,2,2,2]);

Panel3.Width:=RenvoiTailleColonne(GrDBAffectReg,[0,1,2,3])+10;
GrGrid1.ColWidths[0]:=GrDBAffectReg.ColWidths[4];
GrGrid1.ColWidths[1]:=GrDBAffectReg.ColWidths[5];
GrGrid1.ColWidths[2]:=GrDBAffectReg.ColWidths[6];
GrGrid1.ColWidths[3]:=GrDBAffectReg.ColWidths[7];

Panel4.Width:=RenvoiTailleColonne(GrDBAffectReg,[0,1,2,3])+10;
GrGrid2.ColWidths[0]:=GrDBAffectReg.ColWidths[4];
GrGrid2.ColWidths[1]:=GrDBAffectReg.ColWidths[5];
GrGrid2.ColWidths[2]:=GrDBAffectReg.ColWidths[6];
//GrGrid2.ColWidths[3]:=GrDBAffectReg.ColWidths[7];


Panel5.Width:=RenvoiTailleColonne(GrDBAffectReg,[0,1,2,3])+10;
GrGrid3.ColWidths[0]:=GrDBAffectReg.ColWidths[5];
GrGrid3.ColWidths[1]:=GrDBAffectReg.ColWidths[6];
end;

procedure TAffectReglement.paEnteteResize(Sender: TObject);
begin
if ((paEntete.Width > 500) and (paEntete.Width < 730))then
 begin
  Label2.Width:=paEntete.Width - (Label2.left+10);
  EdLibelle.Width := Label2.Width -70;
 end;
end;

procedure TAffectReglement.FormActivate(Sender: TObject);
begin
  GestionDuLibelleSurPlusAutomatique;
  DMPointage2.TaAffectReglement.BeforePost:=DMPointage2.TaAffectReglementBeforePost_PourAffectReglement;
  DMPointage2.TaAffectReglement.AfterPost:=DMPointage2.TaAffectReglementAfterPost_PourAffectReglement;
  DMPointage2.DaAffectReglement.OnStateChange:=ChangementEtatGrille;
  ChangementEtatGrille(DMPointage2.TaAffectReglement);

  Initialiser_ShortCut_Main(true);
  GrDBAffectReg.ParamColor:=true;
  GrDBAffectReg.Param:=ParamUtil.CouleurDBGrid;
  GrDBAffectReg.UpDateColor;
  GrDBAffectReg.DataSource.DataSet.Refresh;

GrGrid1.ParamColor:=true;
GrGrid1.Param:=ParamUtil.CouleurDBGrid;
GrGrid1.DessineContourLigne:=false;
GrGrid1.UpDateColor;

GrGrid2.ParamColor:=true;
GrGrid2.Param:=ParamUtil.CouleurDBGrid;
GrGrid2.DessineContourLigne:=false;
GrGrid2.UpDateColor;

GrGrid3.ParamColor:=true;
GrGrid3.Param:=ParamUtil.CouleurDBGrid;
GrGrid3.DessineContourLigne:=false;
GrGrid3.UpDateColor;

    if copy(edcompte.text,1,1)='+'then
      Begin//si
       EdPlusTiersEntete.Text:='+';
       PlusDefautEntete:=True;
       EdLibelle.text:=Infos_TInfostiers(dmrech.TaTiersRech,'tiers',[edcompte.text]).Nom;
      End//fin si
    else
      Begin//si
       EdPlusTiersEntete.Text:='';
       PlusDefautEntete:=false;
       edlibelle.text:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[edcompte.text]).Libelle;
      End;//fin si
//si on veut lettrer automatiquement tous ceux auquels on attribut un montant
//DMPointage2.ForceLettrage:='A';
//DMPointage2.LettrageEnCours:='A';

end;

procedure TAffectReglement.FormShow(Sender: TObject);
var
TailleTmp:integer;
begin
  try
    if RxSBAchatVentes.Down then
      RxSBAchatVentesClick(RxSBAchatVentes)
    else
      RxSBToutesPiecesClick(RxSBToutesPieces);
    ReadOnlyWinControl([TControl(GrDBAffectReg.Columns[0]),
                        TControl(GrDBAffectReg.Columns[1]),
                        TControl(GrDBAffectReg.Columns[2]),
                        TControl(GrDBAffectReg.Columns[3]),
                        TControl(GrDBAffectReg.Columns[4]),
                        TControl(GrDBAffectReg.Columns[5])],TRue);
    GrDBAffectReg.SetFocus;
    GrDBAffectReg.SelectedIndex:=7;
    TailleTmp:=AffectReglement.Width;
    if FormEtat(AffectReglement)=0 then
      AffectReglement.Width:=AffectReglement.Width-1;
    AffectReglement.Width:=TailleTmp;
    PaGrilleResize(pagrille);
  except

  end;  
end;

procedure TAffectReglement.BtnEnregistrerClick(Sender: TObject);
begin
if GrDBAffectReg.DataSource.State in [dsinsert,dsedit] then TableGerePost(GrDBAffectReg.DataSource.DataSet);
  if BtnEnregistrer.Enabled then
    begin
      ModalResult:=mrOk;
    end
  else
    ModalResult:=mrnone;
end;

procedure TAffectReglement.Enregister1Click(Sender: TObject);
begin
  BtnEnregistrer.Click;
end;

procedure TAffectReglement.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:=true;
if ((DMPointage2.ListeID_Appelant<>nil)and(ModalResult in [MrCancel,MrNone])) then
  begin
  if ((DMPointage2.ListeID_Appelant.Count>0)and(DMPointage2.ListResteAffect_IndexOf(['false'],[4],DMPointage2.ListeID_Appelant)<>-1)) then
    If Application.messagebox(PChar('Voulez-vous annuler les modifications en cours ?' ),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDNo then
      CanClose:=false;
end;
if canclose then
  begin
  InitialiseTable_A_Nil;{ isa  le  29/01/04 }
  DMPointage2.TaAffectReglement.BeforePost:=nil;
  DMPointage2.DaAffectReglement.OnStateChange:=nil;
  end;
end;

procedure TAffectReglement.BtnSupprimerClick(Sender: TObject);
begin
  DMPointage2.SuppressionLettrage_Enreg_Courant(GrDBAffectReg.DataSource.DataSet);
  GrDBAffectReg.DataSource.DataSet.Next;
end;

procedure TAffectReglement.BtnInsererClick(Sender: TObject);
var
Montant:currency;
begin
Montant:=AffectReglement.MontantARegler-(DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation+DMPointage2.TotalImputation_IDReste(GrDBAffectReg.DataSource.DataSet.findfield('ID').asinteger,dmpointage2.IDEcritureAppelanteLoc));
  if Montant>0 then
    begin
      //calculer la valeur total imputable
      DMPointage2.LettrageEnregCourant(GrDBAffectReg.DataSource.DataSet,DMPointage2.LettrageEnCours,Montant);
    end;
  GrDBAffectReg.DataSource.DataSet.Next;
end;

procedure TAffectReglement.Supprimer1Click(Sender: TObject);
begin
  BtnSupprimer.Click;
end;

procedure TAffectReglement.BtnModifierClick(Sender: TObject);
begin
  if ((activeControl = GrDBAffectReg) or (activeControl = BtnModifier)) then
    if GrDBAffectReg.DataSource.DataSet.State <> dsEdit then
         GrDBAffectReg.DataSource.DataSet.Edit;
  GrDBAffectReg.SetFocus;
end;

procedure TAffectReglement.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
  ch:=VK_ESCAPE;
  self.KeyDown(ch,[]);
end;

procedure TAffectReglement.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then
 begin
  if ActiveControl = GrDBAffectReg then
   begin
    if GrDBAffectReg.DataSource.DataSet.State = dsEdit then
     begin
       GrDBAffectReg.DataSource.DataSet.Cancel;
       key:=0;
     end
     else
       begin
         ModalResult:=mrCancel;
       end;
   end
  else
   GrDBAffectReg.SetFocus;
 end;
end;

procedure TAffectReglement.GrDBAffectRegKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ((key = VK_INSERT) or (key = VK_SPACE)) then
   begin
    BtnInserer.Click;
    key:=0;
   end;
  if key = VK_DELETE then BtnSupprimer.Click;
end;

procedure TAffectReglement.BtnImprimerClick(Sender: TObject);
begin
  GrDBAffectReg.GridPreview;
end;

procedure TAffectReglement.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TAffectReglement.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;









procedure TAffectReglement.BtnFermerClick(Sender: TObject);
begin
self.close;
end;

procedure TAffectReglement.Aide1Click(Sender: TObject);
begin
//si on est sur l'entete de la pièce
///////////////////
 If activecontrol = edCompte Then
  //Afficher aidecompte filtré
  begin
    MessDerSub:=false;
    GestionFiltrageParamCpt;
    if EdPlusTiersEntete.text='+' then
      AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],true,MessDerSub,false,true,true,true,1)
    else
      AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],true,MessDerSub,false,true,true,true,0);
    MessDerSub:=true;
    if copy(edcompte.text,1,1)='+'then
      Begin//si
       EdPlusTiersEntete.Text:='+';
       PlusDefautEntete:=True;
//       PlusAutomatiqueEntete:=True;
      End//fin si
    else
      Begin//si
       EdPlusTiersEntete.Text:='';
       PlusDefautEntete:=false;
//       PlusAutomatiqueEntete:=True;
      End;//fin si
   GestionDuLibelleSurPlusAutomatique;
  end;//fin si activecontrol = edCompte
///////////////////

end;

procedure TAffectReglement.pmAutomatique1Click(Sender: TObject);
begin
if not DMPointage2.RecupListeLettre_surDataset(GrDBAffectReg.DataSource.DataSet,false).Result then
 begin
   DMPointage2.LettrageEnCours:='*';
   DMPointage2.LettrageAutomatique(GrDBAffectReg.DataSource.DataSet,EdCompte.Text,0,E.DatExoFin);
//   DMPointage2.LettrageAutomatique(GrDBAffectReg.DataSource.DataSet,EdCompte.Text,E.DatExoDebut,E.DatExoFin);
   ChangementEtatGrille(GrDBAffectReg.DataSource.DataSet);
   DMPointage2.LettrageEnCours:='';
 end
 else
 begin
  Showmessage('Vous devez d''abord valider le lettrage en cours !');
 end;
ChangementEtatGrille(GrDBAffectReg.DataSource.DataSet); 
end;

procedure TAffectReglement.DtailPointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
if activeControl = GrDBAffectReg then
 begin
 
     if not VerifFNumeric(GrDBAffectReg.DataSource.DataSet.FindField('Debit')).VideOUZero then
     begin
      if GrDBAffectReg.DataSource.DataSet.FindField('Debit').AsCurrency > GrDBAffectReg.DataSource.DataSet.FindField('Reste').AsCurrency then
        DetailPointageAffich(EdCompte.Text,GrDBAffectReg.DataSource.DataSet.FindField('ID_Ecriture').AsString,0,true,true)
       else
         showmessage('Cette ligne n''est pas du tout pointée !');

     end
     else
     if not VerifFNumeric(GrDBAffectReg.DataSource.DataSet.FindField('Credit')).VideOUZero then
     begin
      if GrDBAffectReg.DataSource.DataSet.FindField('Credit').AsCurrency > GrDBAffectReg.DataSource.DataSet.FindField('Reste').AsCurrency then
        DetailPointageAffich(EdCompte.Text,GrDBAffectReg.DataSource.DataSet.FindField('ID_Ecriture').AsString,0,true,true)
        else
      showmessage('Cette ligne n''est pas du tout pointée !');
     end;
 ChangementEtatGrille(GrDBAffectReg.DataSource.DataSet);
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

procedure TAffectReglement.Visualisation1Click(Sender: TObject);
begin
if ActiveControl = GrDBAffectReg then
begin//si on est sur la grille
if copy(EdCompte.Text,1,1)='+'then
  begin//si tiers
     if DetailEcritureTiers(EdCompte.Text,false) then
       case DetailEcr.Tag of
          1:begin
              if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMPointage2.TaAffectReglement.findfield('ID_Piece').AsInteger,[]) then
                PieceEcritureTiers;
            end;
       end;//fin du case
  end//fin si tiers
else
  Begin//si compte pointable
     if DetailEcritureCompte(EdCompte.Text,true,false) then
       case DetailEcr.Tag of
          2:begin
              if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMPointage2.TaAffectReglement.findfield('ID_Piece').AsInteger,[]) then
                PieceEcritureCompte;
            end;
       end;//fin du case
  End;//fin si compte pointable
end;//fin si on est sur la grille
if ActiveControl = EdCompte then
  DetailEcritureTiers(EdCompte.Text,true);
ChangementEtatGrille(GrDBAffectReg.DataSource.DataSet);  
end;

procedure TAffectReglement.pmTriparDate1Click(Sender: TObject);
begin
  DMPointage2.TaAffectReglement.IndexFieldNames:='Tiers;Date;Reference';
end;

procedure TAffectReglement.pmTriparMontant1Click(Sender: TObject);
begin
  DMPointage2.TaAffectReglement.IndexFieldNames:='Tiers;Reste;Date;Reference';
end;


procedure TAffectReglement.GestionFiltrageParamCpt;
var
ListeCpt:TStringList;
begin
   try
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);
   if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);

   ListeCpt:=TStringList.Create;
   ListeCpt:=DMPlan.FiltrageParamCPT(42,e.Regime);
   DMPlan.TaCompte.OnFilterRecord:=DMPointage2.TaCompteFilterRecordComptePointable;
   AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
   finally
   if ListeCpt<>nil then
   ListeCpt.Free;
   end;//fin du try finally
End;

procedure TAffectReglement.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin
 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
 Registre:= TRegistry.Create;

   try
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              DernierCpt:=ReadString('edcompte');
              DernierLibelle:=ReadString('EdLibelle');
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

Procedure TAffectReglement.InitialiseTable_A_Nil;
Begin
  //DMPointage2.TaAffectReglement.BeforePost:=nil;
//  DMPointage2.DaAffectReglement.OnStateChange:=nil;
  if DMPointage2<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMPointage2.taAffectReglement,DMPointage2.DaAffectReglement]);
End;

procedure TAffectReglement.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
 Registre:= TRegistry.Create;

   try
     InitialiseTable_A_Nil;
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              WriteString('Edcompte',DernierCpt);
              WriteString('EdLibelle',DernierLibelle);
              WriteBool('PlusDefautEntete',PlusDefautEntete); // PB
              WriteBool('PlusAutoEntete',PlusAutomatiqueEntete); // PB
            except
              PlusDefautEntete:=E.PlanAuxT; // PB
              CloseKey
            end;
         end;
   finally
     Registre.Free;
     if DMPointage2 <> nil then
       LibereObjet(tobject(DMPointage2.ListeID_Appelant),DMPointage2);{ isa  le  02/12/04 }
//       if DMPointage2.ListeID_Appelant<>nil then DMPointage2.ListeID_Appelant.free;
   end;
LibGestionParamXML.DestroyForm(Self,E.User);
AffectReglement:=Nil;
end;


procedure TAffectReglement.GestionDuLibelleSurPlusAutomatique;
begin
 if EdPlusTiersEntete.text='+' then
   Begin//si
     Label6.caption:='Tiers';
   End//fin si
 else
   Begin//si
     Label6.caption:='Compte';
   End;//fin si
end;


procedure TAffectReglement.ChangementEtatGrille(Sender: TObject);
var
//ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
Sens:string;
begin
   case DMPointage2.TaAffectReglement.state of
   dsBrowse: begin
               GrDBAffectReg.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               if GrDBAffectReg.InplaceEditor <> nil then
                  GrDBAffectReg.EditorMode:=false;
               GrDBAffectReg.TitreColor(true);
               Sens:=DMPointage2.TaResteDCSens.asstring;
               DMPointage2.ResteDCInfoLettrageEnCours:=DMPointage2.CalculLettrageEnCours(DMPointage2.TaResteDC,EdCompte.Text,'*',0,Sens);

               GrGrid1.cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', DMPointage2.ResteDCInfoLettrageEnCours.TotalDebitMvt);
               GrGrid1.cells[1,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', DMPointage2.ResteDCInfoLettrageEnCours.TotalCreditMvt);
               if DMPointage2.ResteDCInfoLettrageEnCours.SoldeResteAuDebit then
                 GrGrid1.cells[2,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', DMPointage2.ResteDCInfoLettrageEnCours.SoldeReste)
               else
                 GrGrid1.cells[2,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', DMPointage2.ResteDCInfoLettrageEnCours.SoldeReste);
               if DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputationAuDebit then
                 GrGrid1.cells[3,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation)
               else
                 GrGrid1.cells[3,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation);

               case Sensreglement of
                1:begin//si Credit
                  GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',MontantReglement);
                  GrGrid2.cells[1,0]:='Reste à Pt.';
                  //FormatFloat(E.FormatMonnaie + ';; ',MontantReglement);
                  GrGrid2.cells[2,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ',MontantARegler-DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation);
                  //GrGrid2.cells[3,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ',ResteDCInfoLettrageEnCours.SoldeTotalImputation);
                  end;//fin si Credit
               -1:begin//si Debit
                  GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',MontantReglement);
                  GrGrid2.cells[1,0]:='Reste à Pt.';
                  //FormatFloat(E.FormatMonnaie + ';; ',0);
                  GrGrid2.cells[2,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ',MontantARegler-DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation);
                  //GrGrid2.cells[3,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ',ResteDCInfoLettrageEnCours.SoldeTotalImputation);
                  end;//fin si Debit
               end;//fin du case sensReglement

               if DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputationAuDebit then
               GrGrid3.cells[1,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ', DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation)
               else
               GrGrid3.cells[1,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ', DMPointage2.ResteDCInfoLettrageEnCours.SoldeTotalImputation);
             //BtnEnregistrer.Enabled:=ResteDCInfoLettrageEnCours.SoldeTotalImputation>0;
             end;

   dsEdit:   begin
   
               GrDBAffectReg.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               GrDBAffectReg.SetFocus;
               GrDBAffectReg.TitreColor(true);
             end;

   dsInsert: begin
               GrDBAffectReg.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               GrDBAffectReg.SetFocus;
               GrDBAffectReg.TitreColor(true);
             end;
   end;//fin du case.state

//FormatePanelTitreGrille(ResteDCInfoLettrageEnCours);
Panel3.Caption:='Totaux Selection en cours  : ';
end;



Procedure TAffectReglement.FormatePanelTitreGrille(InfoReste:TInfoResteDCSurCompte);
Begin
  case InfoReste.NBLignePartiellementPointee of
    0,1:LaInfoRestePartiel.Caption:=IntToStr(InfoReste.NBLignePartiellementPointee) + ' ligne d''écritures partiellement pointée pour'+ InfoReste.MessageCpt
    else
     LaInfoRestePartiel.Caption:=IntToStr(InfoReste.NBLignePartiellementPointee) + ' lignes d''écritures partiellement pointée pour'+ InfoReste.MessageCpt;
  end;//fin du case NBLignePartiellementPointee

  case InfoReste.NBLignePointee of
    0,1:LaInfoResteDC.Caption:=IntToStr(InfoReste.NBLignePointee) + ' ligne d''écritures entièrement pointée pour'+ InfoReste.MessageCpt;
    else
     LaInfoResteDC.Caption:=IntToStr(InfoReste.NBLignePointee) + ' lignes d''écritures entièrement pointée pour'+ InfoReste.MessageCpt;
  end;//fin du case NBLignePointee
End;

procedure TAffectReglement.GrDBAffectRegEnter(Sender: TObject);
begin
GrDBAffectReg.SelectedIndex:=8;
end;

procedure TAffectReglement.GrDBAffectRegExit(Sender: TObject);
var
CanClose:boolean;
begin
  try
  if ((activecontrol = EdCompte))then
   Begin
    if DMPointage2.RecupListeLettre_surDataset(GrDBAffectReg.DataSource.DataSet,true).Result then
     begin
      if not DMPointage2.Gestion_Annulation_Lettrage(GrDBAffectReg.DataSource.DataSet,'%','',true) then
       begin
        if BtnEnregistrer.Enabled then
         begin
          BtnEnregistrer.Click;
         end;
       end
        else
        DMPointage2.SuppressionLettrage_Tous_ApresGestionDesPointages(GrDBAffectReg.DataSource.DataSet,nil);

     end;
   End;
  except
    GrDBAffectReg.setfocus;
    abort;
  end;

end;

procedure TAffectReglement.Toutdpointer1Click(Sender: TObject);
begin
  try
    if empty(DMPointage2.LettrageEnCours) then
      begin
        DMPointage2.LettrageEnCours:='A';
        DMPointage2.forcelettrage:='A';
      end;
    DMPointage2.Gestion_Annulation_Lettrage(GrDBAffectReg.DataSource.DataSet,DMPointage2.LettrageEnCours,'',false);

  finally
    ChangementEtatGrille(GrDBAffectReg.DataSource.DataSet);
    DMPointage2.LettrageEnCours:='';
    DMPointage2.forcelettrage:='';
  end;//fin finally
end;


procedure TAffectReglement.GrGrid2DrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
var
HoldColor:TColor;
begin
if col = 1  then
 begin
      HoldColor:=grgrid2.Canvas.Brush.Color;
      grgrid2.Canvas.Brush.Color :=Panel4.Color;
      grgrid2.Canvas.FillRect(Rect);
      grgrid2.Canvas.TextOut(Rect.Left+1,1,'Reste à Pointer');
      grgrid2.Canvas.Brush.Color:=HoldColor;
 end;
end;

procedure TAffectReglement.RxSBAchatVentesClick(Sender: TObject);
begin
DMPointage2.FiltreDettesEtCreancesSurJournal(Tdataset(DMPointage2.TaAffectReglement),['3','4'],affectReglement.Sensreglement,AffectReglement.EdCompte.Text,affectReglement.MontantARegler);
 PaGrilleResize(pagrille);
 GrDBAffectReg.SelectedIndex:=7;
end;

procedure TAffectReglement.RxSBToutesPiecesClick(Sender: TObject);
begin
DMPointage2.FiltreDettesEtCreancesSurJournal(Tdataset(DMPointage2.TaAffectReglement),[''],affectReglement.Sensreglement,AffectReglement.EdCompte.Text,affectReglement.MontantARegler);
PaGrilleResize(pagrille);
GrDBAffectReg.SelectedIndex:=7;
end;


procedure TAffectReglement.Calculatrice1Click(Sender: TObject);
begin
if (ActiveControl=GrDBAffectReg) and (GrDBAffectReg.Col in [7])then
   AfficheCalculatrice(GrDBAffectReg)
else
   AfficheCalculatrice(nil);
end;

end.

