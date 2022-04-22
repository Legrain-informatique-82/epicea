unit E2_ReglementSurListe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, ExtCtrls, StdCtrls, Mask, ToolEdit, CurrEdit, Grids, DBGrids,
  RXDBCtrl, ExRxDBGrid, GrDBGrid,E2_Librairie_Obj,LibSQL,LibZoneSaisie,
  E2_Decl_Records,GR_Librairie_Obj,registry, GrGrid, Menus,db,
  LibRessourceString,LibDates,DMConstantes,E2_ReglementSurListe2, jpeg,
  LibGestionParamXML,
  E2_SaisieP_3,
  Ecriture_isa,
  Lib_chaine,
  DBTables,
  LibChoixCompte,
  Editions;


type
  TReglementSurListe = class(TForm)
    PaGrille: TPanel;
    GrDBPointage: TGrDBGrid;
    PaBas: TPanel;
    LaInfoResteDC: TLabel;
    LaInfoRestePartiel: TLabel;
    Panel7: TPanel;
    paEntete: TPanel;
    Label6: TLabel;
    Label2: TLabel;
    EdCompte: TEdit;
    EdLibelle: TEdit;
    PaTools: TPanel;
    PopupMenuPointage: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
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
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaCumul1: TPanel;
    Panel6: TPanel;
    GrGrid3: TGrGrid;
    EdPlusTiersEntete: TEdit;
    PaTools1: TPanel;
    PaTools2: TPanel;
    RxSBdettes: TRxSpeedButton;
    RxSBCreances: TRxSpeedButton;
    RxSBTous: TRxSpeedButton;
    RxSBTiers: TRxSpeedButton;
    RxSBDC: TRxSpeedButton;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    RxSpeedButton1: TRxSpeedButton;
    Toutdpointer1: TMenuItem;
    LaValidation: TLabel;
    PaTools3: TPanel;
    RxSBAchatVentes: TRxSpeedButton;
    RxSBToutesPieces: TRxSpeedButton;
    Timer1: TTimer;
    Timer2: TTimer;
    Modifierpice1: TMenuItem;
    riparTiers1: TMenuItem;
    Relancedestiers1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    GrGrid4: TGrGrid;
    Comptesdentteuniquement1: TMenuItem;
    Touscomptes1: TMenuItem;
    procedure PaGrilleResize(Sender: TObject);
    procedure PaToolsResize(Sender: TObject);
    procedure RxSBTousClick(Sender: TObject);
    procedure RxSBdettesClick(Sender: TObject);
    procedure RxSBCreancesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure GrDBPointageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure EdCompteEnter(Sender: TObject);
    procedure GestionFiltrageParamCpt;
    procedure TaCompteFilterRecordComptePointable(DataSet: TDataSet; var Accept: Boolean);
    procedure EdCompteExit(Sender: TObject);
    Procedure FormatePanelTitreGrille(InfoReste:TInfoResteDCSurCompte);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure GestionBoutonsSpeed;
    procedure FormActivate(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure GrDBPointageExit(Sender: TObject);
    procedure GrDBPointageEnter(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure EdCompteKeyPress(Sender: TObject; var Key: Char);
    procedure GestionDuLibelleSurPlusAutomatique;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pmAutomatique1Click(Sender: TObject);
    procedure DtailPointages1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure pmTriparDate1Click(Sender: TObject);
    procedure pmTriparMontant1Click(Sender: TObject);
    procedure PaTools1Resize(Sender: TObject);
    procedure PaTools2Resize(Sender: TObject);
    procedure GestionAffichage(Sender: TObject);
    procedure RxSBTiersClick(Sender: TObject);
    procedure RxSBDCClick(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    function RecupSensDeSelectionEnCours(var TiersEnCours:string):string;
    procedure TaResteDCBeforePost_PourReglementSurListe(DataSet: TDataSet);
    procedure Toutdpointer1Click(Sender: TObject);
    procedure TaResteDCAfterPost_PourReglementSurListe(DataSet: TDataSet);
    Procedure InitialiseTable_A_Nil;
    procedure GrDBPointageDblClick(Sender: TObject);
    procedure PaTools3Resize(Sender: TObject);
    procedure RxSBAchatVentesClick(Sender: TObject);
    procedure RxSBToutesPiecesClick(Sender: TObject);
    procedure CalculSolde(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Modifierpice1Click(Sender: TObject);
    procedure GrDBPointageTitleClick(Column: TColumn);
    procedure riparTiers1Click(Sender: TObject);
    procedure Relancedestiers1Click(Sender: TObject);
    procedure Touscomptes1Click(Sender: TObject);
    procedure Comptesdentteuniquement1Click(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure Calculatrice1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    TitreForm,SousTitreForm,SousTitre1,SousTitre2:String;
  end;

var
  ReglementSurListe: TReglementSurListe;
  DC:TDernierValide;
  CodeTmp:string;
  MessDerSub:boolean;
  InfoResteDCSurCompte:TInfoResteDCSurCompte;
  PlusDefautEntete,PlusAutomatiqueEntete:boolean;
  ID_EnCours:integer;

implementation

uses E2_Main, DMPointages2, E2_AideCompte, DMRecherche,
  DMPlanCpt,E2_LibInfosTable,DMParamEnt, E2_DetailEcr, DMEcriture,
  E2_VisuPointage;

{$R *.DFM}



procedure TReglementSurListe.PaToolsResize(Sender: TObject);
begin
PaTools1Resize(PaTools1);
PaTools3Resize(PaTools3);
PaTools2Resize(PaTools2);
end;

procedure TReglementSurListe.RxSBTousClick(Sender: TObject);
begin
  try
  EdCompte.Enabled:=false;
  EdLibelle.Enabled:=false;
  edcompte.text:='';
  edlibelle.text:='';
  label6.visible:=false;
  Label2.visible:=label6.visible;
  SousTitre2:='[ Tous les tiers ]';
  GestionAffichage(Sender);
  finally
    //GestionBoutonsSpeed;
  end;//fin du try finally
end;

procedure TReglementSurListe.RxSBdettesClick(Sender: TObject);
begin
if edcompte.enabled then
  Begin//si
   edcompte.setfocus;
   if not empty(DC.DernierCpt)then
     edcompte.text:=DC.DernierCpt;
  End;//fin si
SousTitre1:='[ '+RxSBdettes.Caption + ' ]';
GestionAffichage(sender);
//GestionBoutonsSpeed;
end;

procedure TReglementSurListe.RxSBCreancesClick(Sender: TObject);
begin
if edcompte.enabled then
  Begin//si
    edcompte.setfocus;
  if not empty(DC.DernierCpt)then
    edcompte.text:=DC.DernierCpt;
  End;//fin si
SousTitre1:='[ '+ RxSBCreances.Caption + ' ]';
GestionAffichage(sender);
//GestionBoutonsSpeed;
end;

procedure TReglementSurListe.FormCreate(Sender: TObject);
Var
	Registre :TRegistry;
Begin
 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
 Registre:= TRegistry.Create;
 if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(self);
   try
	   with Registre do
           begin
	      RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
            try
              EdCompte.Text:='';
              RxSBdettes.AllowAllUp:=true;
              RxSBCreances.AllowAllUp:=true;
              RxSBDC.AllowAllUp:=true;
              RxSBTous.AllowAllUp:=true;
              RxSBTiers.AllowAllUp:=true;
              RxSBAchatVentes.AllowAllUp:=true;
              RxSBToutesPieces.AllowAllUp:=true;

              RxSBdettes.down:=ReadBool('RxSBdettes');
              RxSBCreances.down:=ReadBool('RxSBCreances');
              RxSBDC.down:=ReadBool('RxSBDC');
              RxSBTous.down:=ReadBool('RxSBTous');
              RxSBTiers.down:=ReadBool('RxSBTiers');
              RxSBAchatVentes.down:=ReadBool('RxSBAchatVentes');
              RxSBToutesPieces.down:=ReadBool('RxSBToutesPieces');
              
              DC.DernierLibelle:=ReadString('LibelleDC');
              DC.DernierCpt:=ReadString('NumCptDC');
              PlusDefautEntete:=ReadBool('PlusDefautEntete'); // PB
              PlusAutomatiqueEntete:=ReadBool('PlusAutoEntete'); // PB
            except
              RxSBdettes.down:=false;
              RxSBCreances.down:=false;
              RxSBDC.down:=true;
              RxSBTous.down:=true;
              RxSBTiers.down:=false;
              RxSBAchatVentes.down:=True;
              RxSBToutesPieces.down:=false;
              
              DC.DernierCpt:='';
              DC.DernierLibelle:='';
              PlusDefautEntete:=E.PlanAuxT;// PB
              if PlusDefautEntete then PlusAutomatiqueEntete:=true;// PB
            end;
         end;
   finally
     Registre.Free;
     RxSBdettes.AllowAllUp:=false;
     RxSBCreances.AllowAllUp:=false;
     RxSBDC.AllowAllUp:=false;
     RxSBTous.AllowAllUp:=false;
     RxSBTiers.AllowAllUp:=false;
     RxSBAchatVentes.AllowAllUp:=false;
     RxSBToutesPieces.AllowAllUp:=false;
   end;
   RxSBDC.tag:=0;
   RxSBdettes.tag:=1;
   RxSBCreances.tag:=2;
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        InitialiseFormPosDefaut(self);
	//Left:= 30; Top:= 70; Width:= screen.Width-60; Height:= screen.Height-top-30;
    end;
 MessDerSub:=true;
end;

procedure TReglementSurListe.BtnEnregistrerClick(Sender: TObject);
var
ListeReglement,listeARegler:Tlist;
TvaSurE:boolean;
coord:trect;
sens,i,rang:integer;
begin
//récupérer la liste des lignes à régler
try//finally
rang := GrDBPointage.DataSource.DataSet.findfield('id').AsInteger;
      listeARegler:=tlist.Create;
      ListeReglement:=tlist.Create;
   try//except
      GrDBPointage.DataSource.DataSet.DisableControls;
      DMPointage2.TaResteDC.DisableControls;
      TableGerePost(DMPointage2.TaResteDC);
      DMPointage2.TaResteDC.BeforePost:=DMPointage2.TaResteDCBeforePost;
      //ID_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').asinteger;
      TvaSurE:=false;
      sens:=0;
      with  DMPointage2 do
        begin//début du with
           TaResteDC.first;
           while not(TaResteDC.eof) do
             Begin//tant que
                if not VerifFNumeric(TaResteDCMontant).VideOUZero then
                   begin//si montant rempli
                      FiltrageDataSet(DMRech.TaEcritureRech,'TvaType=''E'' and id_Piece = '+TaResteDCID_Piece.asstring);
                      if DMRech.TaEcritureRech.recordcount>0 then
                        TvaSurE:=TaResteDCID_Ecriture.asinteger<>DMRech.TaEcritureRech.FindField('ID').asinteger;
                      if TaResteDCSens.asstring[1]='D'then
                        sens:=-1;
                      if TaResteDCSens.asstring[1]='C'then
                        sens:=1;
                      ListEcriture_A_Regler_Add_Insert(ListeARegler,[TaResteDCID_Ecriture.asinteger,TaResteDCTiers.asstring,TaResteDCMontant.ascurrency,sens,'5121',TvaSurE],true,false,-1);
                   DeFiltrageDataSet(DMRech.TaEcritureRech);
                   end;//fin si montant rempli
                TaResteDC.next;
             End;//fin du while DMPointage2.TaResteDC.
           //puis, envoyer la fenêtre des réglements sur liste
           GrDBPointage.DataSource.DataSet.Locate('id',ID_EnCours,[]);
           ListeReglement:=ReglementSurListe_Creation(coord,false,true,true,ListeARegler);
           //si lettrage en cours, compléter le lettrage avec les nouveaux réglements
           //sinon, créer un nouveau lettrage pour chaque nouveaux réglement
           if ListeReglement<>nil then
                Lettrage_Sur_Liste_Affich(false,DMPointage2.TaResteDC,ListeReglement,false,false,DMPointage2.LettrageEnCours)
              else
                abort;
        end;//fin du with
   except
     //
   end;
finally
for i:=0 to ListeReglement.Count-1 do
   begin
       if TEcriture_Isa(ListeReglement.Items[i]).piece.trame<>nil then
         TEcriture_Isa(ListeReglement.Items[i]).piece.trame.free;
       TEcriture_Isa(ListeReglement.Items[i]).piece.free;
       TEcriture_Isa(ListeReglement.Items[i]).free;
   end;
ListeReglement.Clear;
//Initialise_TList(ListeReglement);
DMPointage2.TaResteDC.BeforePost:=TaResteDCBeforePost_PourReglementSurListe;
//if listeARegler<>nil then listeARegler.free;
//if ListeReglement<>nil then ListeReglement.free;
ChangementEtatGrille(nil);
GrDBPointage.DataSource.DataSet.Locate('id',rang,[]);
//calculsolde(nil);
//ChangementEtatGrille(DMPointage2.TaResteDC);
//GrDBPointage.DataSource.DataSet.Locate('id',ID_EnCours,[]);
//GrDBPointage.DataSource.DataSet.EnableControls;
end;
end;

procedure TReglementSurListe.GrDBPointageKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//if ((key = VK_INSERT) or (key=VK_SPACE)) then
if (key = VK_INSERT) then
 begin
  BtnInserer.Click;
  key:=0;
 end;
if key = VK_DELETE then
 BtnSupprimer.Click;
//if key=vk_return then
// begin
//   if BtnEnregistrer.Enabled=false then
//     BtnEnregistrer.Enabled:=not VerifFNumeric(GrDBPointage.DataSource.DataSet.FindField('Montant')).VideOUZero;
//   Enregister1.Enabled:=BtnEnregistrer.enabled;
//   LaValidation.visible:=BtnEnregistrer.enabled;
// end;
end;

procedure TReglementSurListe.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TReglementSurListe.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TReglementSurListe.BtnModifierClick(Sender: TObject);
begin
if ((activeControl = GrDBPointage) or (activeControl = BtnModifier)) then
 if GrDBPointage.DataSource.DataSet.State <> dsEdit then
  GrDBPointage.DataSource.DataSet.Edit;
end;

procedure TReglementSurListe.BtnSupprimerClick(Sender: TObject);
begin
  try
    DMPointage2.TaResteDC.DisableControls;
    ID_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').AsInteger;
    DMPointage2.DaResteDC.OnStateChange:=nil;
    DMPointage2.SuppressionLettrage_Enreg_Courant(GrDBPointage.DataSource.DataSet);
    //GrDBPointage.DataSource.DataSet.Next;
  finally
    DMPointage2.DaResteDC.OnStateChange:=ChangementEtatGrille;
    ChangementEtatGrille(nil);
//    calculsolde(nil);
//    ChangementEtatGrille(DMPointage2.TaResteDC);
  end;//fin finally
end;

procedure TReglementSurListe.BtnFermerClick(Sender: TObject);
begin
Self.Close;
end;

procedure TReglementSurListe.BtnInsererClick(Sender: TObject);
var
IdTmp:integer;
begin
try
if empty(DMPointage2.LettrageEnCours) then
 begin
  DMPointage2.LettrageEnCours:='A';
 end;
//DMPointage2.TaResteDC.DisableControls;
//IdTmp:=GrDBPointage.DataSource.DataSet.findfield('ID').AsInteger;
DMPointage2.LettrageEnregCourant(GrDBPointage.DataSource.DataSet,DMPointage2.LettrageEnCours,0);
//GrDBPointage.DataSource.DataSet.Locate('ID',IDTmp,[]);
GrDBPointage.DataSource.DataSet.Next;
finally
ChangementEtatGrille(nil);
//calculsolde(nil);
end;//fin du try finally
end;

procedure TReglementSurListe.Aide1Click(Sender: TObject);
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
    if EdPlusTiersEntete.text='+' then
      Recherche_:=1
    else
      Recherche_:=0;
    AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],true,MessDerSub,false,true,true,true,recherche_);
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

procedure TReglementSurListe.EdCompteEnter(Sender: TObject);
begin
CodeTmp:=EdCompte.Text;
end;

procedure TReglementSurListe.GestionFiltrageParamCpt;
var
ListeCpt:TStringList;
begin
   try
   ListeCpt:=TStringList.Create;
   if AideCompte=nil then AideCompte:=TAideCompte.Create(Application.MainForm);
   if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);

   //ListeCpt:=DMPlan.FiltrageParamCPT(42,e.Regime);
   DMPlan.TaCompte.OnFilterRecord:=TaCompteFilterRecordComptePointable;
   AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
   finally
   Initialise_TStringlist(ListeCpt,self);
   end;//fin du try finally
End;



procedure TReglementSurListe.TaCompteFilterRecordComptePointable(DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
  if DataSet.Name <> 'quLibelle' then
   begin
     try
       accept:=((DataSet.findField('Pointable').AsBoolean) and not (DataSet.findField('collectif').asboolean) and ((length(DataSet.FindField('Compte').AsString) > 2)));
     except
       accept:=false;
     end;
   end;
  end;
end;


procedure TReglementSurListe.EdCompteExit(Sender: TObject);
begin
GestionAffichage(Sender);
end;


Procedure TReglementSurListe.FormatePanelTitreGrille(InfoReste:TInfoResteDCSurCompte);
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

procedure TReglementSurListe.PaGrilleResize(Sender: TObject);
begin
WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);
FormateTailleColonne(GrDBPointage,20,[2,2,2,4,2,2,2,2]);

Panel6.Width:=RenvoiTailleColonne(GrDBPointage,[0,1,2,3,4,5])+10;
GrGrid3.ColWidths[0]:=GrDBPointage.ColWidths[6];
GrGrid3.ColWidths[1]:=GrDBPointage.ColWidths[7];
GrGrid3.ColWidths[2]:=GrDBPointage.ColWidths[8];

Panel2.Width:=RenvoiTailleColonne(GrDBPointage,[0,1,2,3,4,5])+10;
GrGrid4.ColWidths[0]:=GrDBPointage.ColWidths[6];
GrGrid4.ColWidths[1]:=GrDBPointage.ColWidths[7];
GrGrid4.ColWidths[2]:=GrDBPointage.ColWidths[8];
end;

procedure TReglementSurListe.FormShow(Sender: TObject);
var
Valide:boolean;
begin
ReadOnlyWinControl([TControl(GrDBPointage.Columns[0]),
                    TControl(GrDBPointage.Columns[1]),
                    TControl(GrDBPointage.Columns[2]),
                    TControl(GrDBPointage.Columns[3]),
                    TControl(GrDBPointage.Columns[4]),
                    TControl(GrDBPointage.Columns[5])],TRue);
//if rxsbTous.Down then
//  Begin//si  rxsbTous.Down
//    rxsbTousclick(nil);
//  End//fin si rxsbTous.Down
//else
//  Begin//si rxsbTiers.Down
//    rxsbTiersclick(nil);
//  End;//fin si rxsbTiers.Down

end;

procedure TReglementSurListe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
try
WinSuivPrec(Handle,key,[GrDBPointage,GrDBPointage.InplaceEditor]);
if key = VK_ESCAPE then
   begin //si échappe
   DMPointage2.TaResteDC.DisableControls;
      if ActiveControl = EdCompte then
      self.close;
     if ((ActiveControl = GrDBPointage) or (ActiveControl = BtnAnnuler)) then
        begin//si on est sur la grille ou le bouton annuler
         if GrDBPointage.DataSource.DataSet.State in [dsEdit] then
          begin//si modification
           GrDBPointage.DataSource.DataSet.Cancel;
           key:=0;
          end//fin si modification
           else
          begin //si en consultation
           if edcompte.enabled then
             begin
               EdCompte.SetFocus;
               key:=0;
             end
           else
             self.close;
          end;//fin si en consultation
        end;//fin si on est sur la grille ou le bouton annuler
   end;//fin si échappe
finally
  GrDBPointage.DataSource.DataSet.EnableControls;
end;
end;

procedure TReglementSurListe.FormDestroy(Sender: TObject);
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
              WriteBool('RxSBdettes',RxSBdettes.down);
              WriteBool('RxSBCreances',RxSBCreances.down);
              WriteBool('RxSBDC',RxSBDC.down);
              WriteBool('RxSBTous',RxSBTous.down);
              WriteBool('RxSBTiers',RxSBTiers.down);
              WriteBool('RxSBAchatVentes',RxSBAchatVentes.down);
              WriteBool('RxSBToutesPieces',RxSBToutesPieces.down);

              WriteString('NumCptDC',DC.DernierCpt);
              WriteString('LibelleDC',DC.DernierLibelle);
              WriteBool('PlusDefautEntete',PlusDefautEntete); // PB
              WriteBool('PlusAutoEntete',PlusAutomatiqueEntete); // PB
            except
              PlusDefautEntete:=E.PlanAuxT; // PB
              CloseKey
            end;
         end;
   finally
		Registre.Free;
   end;
LibGestionParamXML.DestroyForm(Self,E.User);
if DMPointage2<>nil then DMPointage2.Free;
ReglementSurListe:=Nil;
end;


procedure TReglementSurListe.GestionBoutonsSpeed;
begin
if RxSBDettes.Down=true then
  begin
  RxSBDettes.Font.Color:=clRed;
  RxSBCreances.Font.Color:=clWindowText;
  RxSBDC.Font.Color:=clWindowText;
  end;
if RxSBCreances.down then
  begin
  RxSBCreances.Font.Color:=clRed;
  RxSBDettes.Font.Color:=clWindowText;
  RxSBDC.Font.Color:=clWindowText;
  end;
if RxSBDC.down then
  begin
  RxSBDC.Font.Color:=clRed;
  RxSBDettes.Font.Color:=clWindowText;
  RxSBCreances.Font.Color:=clWindowText;
  end;
  //////
if RxSBTiers.down then
  begin
  RxSBTiers.Font.Color:=clRed;
  RxSBTous.Font.Color:=clWindowText;
  end;
if RxSBTous.down then
  begin
  RxSBTous.Font.Color:=clRed;
  RxSBTiers.Font.Color:=clWindowText;
  end;
end;


procedure TReglementSurListe.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);

GrDBPointage.ParamColor:=true;
GrDBPointage.Param:=ParamUtil.CouleurDBGrid;
GrDBPointage.UpDateColor;

GrGrid3.ParamColor:=true;
GrGrid3.Param:=ParamUtil.CouleurDBGrid;
GrGrid3.DessineContourLigne:=false;
GrGrid3.UpDateColor;

GrGrid4.ParamColor:=true;
GrGrid4.Param:=ParamUtil.CouleurDBGrid;
GrGrid4.DessineContourLigne:=false;
GrGrid4.UpDateColor;

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

if rxsbTous.Down then
  Begin//si  rxsbTous.Down
    rxsbTousclick(nil);
  End//fin si rxsbTous.Down
else
  Begin//si rxsbTiers.Down
    rxsbTiersclick(nil);
  End;//fin si rxsbTiers.Down

//if RxSBdettes.Down then
//  begin
//    RxSBdettesClick(nil);
//  end
//else
// if RxSBCreances.Down then
//    begin
//     RxSBCreancesClick(nil);
//    end
//  else
//  if RxSBDC.Down then
//     begin
//       RxSBDCClick(nil);
//     end;


GestionDuLibelleSurPlusAutomatique;
DMPointage2.TaResteDC.AfterPost:=TaResteDCAfterPost_PourReglementSurListe;
DMPointage2.TaResteDC.BeforePost:=TaResteDCBeforePost_PourReglementSurListe;

DMPointage2.DaResteDC.OnStateChange:=ChangementEtatGrille;
//GestionAffichage(sender);
//ChangementEtatGrille(DMPointage2.TaResteDC);
//si on veut lettrer automatiquement tous ceux auquels on attribut un montant
DMPointage2.ForceLettrage:='A';
DMPointage2.LettrageEnCours:='A';
ChangementEtatGrille(nil);
//CalculSolde(nil);
end;


procedure TReglementSurListe.ChangementEtatGrille(Sender: TObject);
var
ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
idcourant:integer;
begin
Self.Caption :=TitreForm+' - '+SousTitreForm+' - '+ EtatDataSetString(DMPointage2.TaResteDC)+' - '+ SousTitre1+' - '+ SousTitre2;
   case DMPointage2.TaResteDC.state of
   dsBrowse: begin
               try
               GrDBPointage.Options := [dgediting,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               if GrDBPointage.InplaceEditor <> nil then
                  GrDBPointage.EditorMode:=false;
               GrDBPointage.TitreColor(true);
               EnableWinControl([BtnAnnuler,BtnFermer,BtnImprimer],true);
               BtnModifier.Enabled:=GrDBPointage.datasource.DataSet.recordcount>0;
               BtnSupprimer.Enabled:=GrDBPointage.datasource.DataSet.recordcount>0;
               //BtnEnregistrer.Enabled:=false;
                finally
                  calculsolde(nil);
                end;
             end;

   dsEdit:   begin
               GrDBPointage.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               GrDBPointage.SetFocus;
               GrDBPointage.TitreColor(true);
               EnableWinControl([BtnAnnuler,BtnFermer,BtnImprimer],true);
               EnableWinControl([BtnModifier,BtnSupprimer],false);
             end;

   dsInsert: begin
               GrDBPointage.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               GrDBPointage.SetFocus;
               GrDBPointage.TitreColor(true);
               EnableWinControl([BtnAnnuler,BtnFermer,BtnImprimer],true);
               EnableWinControl([BtnModifier,BtnSupprimer],false);
             end;
   end;//fin du case.state
LaValidation.visible:=BtnEnregistrer.enabled;
Enregister1.Enabled:=BtnEnregistrer.enabled;
Insrer1.Enabled:=BtnInserer.enabled;
modifier1.Enabled:=BtnModifier.enabled;
Supprimer1.Enabled:=BtnSupprimer.enabled;
Annuler1.Enabled:=BtnAnnuler.enabled;
Fermer1.Enabled:=BtnFermer.enabled;
end;


procedure TReglementSurListe.GrDBPointageExit(Sender: TObject);
var
CanClose:boolean;
begin
  try
  if ((activecontrol = EdCompte))then
   Begin
    if DMPointage2.RecupListeLettre_surDataset(GrDBPointage.DataSource.DataSet,true).Result then
     begin
      if Application.MessageBox(PChar('Voulez-Vous Valider le lettrage en cours '),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
        begin
        if not DMPointage2.Gestion_Annulation_Lettrage(GrDBPointage.DataSource.DataSet,'*','',false) then
          begin
             //CanClose:=true;
             GestionAffichage(nil);
          end
        else
          begin
            DMPointage2.SuppressionLettrage_Tous_ApresGestionDesPointages(GrDBPointage.DataSource.DataSet,nil);
            GestionAffichage(nil);
          end;
        end
      else
        BtnEnregistrerClick(BtnEnregistrer);
     end;
   End;
  except
    GrDBPointage.setfocus;
    abort;
  end;
end;

procedure TReglementSurListe.GrDBPointageEnter(Sender: TObject);
begin
GrDBPointage.SelectedIndex:=8;
end;

procedure TReglementSurListe.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TReglementSurListe.EdCompteKeyPress(Sender: TObject;
  var Key: Char);
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
end;

procedure TReglementSurListe.GestionDuLibelleSurPlusAutomatique;
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

procedure TReglementSurListe.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
CanClose:=true;
if DMPointage2.RecupListeLettre_surDataset(GrDBPointage.DataSource.DataSet,true).Result then
 begin
  self.WindowState:=wsNormal;
  self.BringToFront;
//  if DMPointage2.Gestion_Annulation_Lettrage(GrDBPointage.DataSource.DataSet,'%','Voulez-vous annuler le réglement en cours ?',true) then
if Application.MessageBox(Pchar('Voulez-vous annuler le réglement en cours ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
    begin //
       DMPointage2.Gestion_Annulation_Lettrage(GrDBPointage.DataSource.DataSet,'%','',false);
    end
  else
    abort;  
 end;
except
   canclose:=false;
end;
if CanClose then
  begin
     InitialiseTable_A_Nil; { isa  le  29/01/04 }
     DMPointage2.TaResteDC.BeforePost:=DMPointage2.TaResteDCBeforePost;
     DMPointage2.TaResteDC.AfterPost:=DMPointage2.TaResteDCAfterPost;
  end
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);
 end;
end;

procedure TReglementSurListe.pmAutomatique1Click(Sender: TObject);
begin
//if not DMPointage2.RecupListeLettre_surDataset(GrDBPointage.DataSource.DataSet,false).Result then
////if empty(DMPointage2.LettrageEnCours) then
// begin
//   DMPointage2.LettrageEnCours:='*';
//   DMPointage2.LettrageAutomatique(GrDBPointage.DataSource.DataSet,EdCompte.Text,0,E.DatExoFin);
//   ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
//   DMPointage2.LettrageEnCours:='';
// end
// else
// begin
//  Showmessage('Vous devez d''abord valider le lettrage en cours !');
// end;

end;

procedure TReglementSurListe.DtailPointages1Click(Sender: TObject);
var
ParamAffichPointage:TParamAffichPointage;
begin
ID_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').asinteger;
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
ChangementEtatGrille(nil);
//CalculSolde(nil);
// ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
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

procedure TReglementSurListe.Visualisation1Click(Sender: TObject);
begin
try
DMPointage2.TaResteDC.DisableControls;
ID_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').asinteger;
if ActiveControl = GrDBPointage then
begin//si on est sur la grille
//if copy(EdCompte.Text,1,1)='+'then
if copy(GrDBPointage.DataSource.dataset.findfield('Tiers').asstring,1,1)='+' then
  begin//si tiers
     if DetailEcritureTiers(GrDBPointage.DataSource.dataset.findfield('Tiers').asstring,false) then
       case DetailEcr.Tag of
          1:begin
            if DMEcritures.QueryEcrTiers.Locate('ID_Piece',DMPointage2.TaResteDC.findfield('ID_Piece').AsInteger,[]) then
              PieceEcritureTiers;
            end;
       end;//fin du case
  end//fin si tiers
else
  Begin//si compte pointable
     if DetailEcritureCompte(GrDBPointage.DataSource.dataset.findfield('Tiers').asstring,true,true) then
       case DetailEcr.Tag of
          1:begin
            if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMPointage2.TaResteDC.findfield('ID_Piece').AsInteger,[]) then
              PieceEcritureCompte;
            end;
       end;//fin du case
  End;//fin si compte pointable
end;//fin si on est sur la grille
if ActiveControl = EdCompte then
  DetailEcritureTiers(GrDBPointage.DataSource.dataset.findfield('Tiers').asstring,true);

finally
ChangementEtatGrille(nil);
//calculsolde(nil);
//ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
//  GrDBPointage.DataSource.dataset.EnableControls;
end;
end;

procedure TReglementSurListe.pmTriparDate1Click(Sender: TObject);
begin
//  DMPointage2.TaResteDC.IndexFieldNames:='Tiers;Date;Reference';
  DMPointage2.TaResteDC.IndexName:='DateSeule'
end;

procedure TReglementSurListe.pmTriparMontant1Click(Sender: TObject);
begin
//  DMPointage2.TaResteDC.IndexFieldNames:='Tiers;Reste;Date;Reference';
  DMPointage2.TaResteDC.IndexName:='ResteSeule'
end;

procedure TReglementSurListe.PaTools1Resize(Sender: TObject);
begin
PaTools1.Width:=(PaTools.Width div 25)*10;
FormateTailleBouttonAvecEspace([RxSBdettes,RxSBCreances,RxSBDC],PaTools1,90,0,5);
end;

procedure TReglementSurListe.PaTools2Resize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([RxSBTous,RxSBTiers],PaTools2,90,0,5);
end;



procedure TReglementSurListe.GestionAffichage(Sender: TObject);
var
ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
Rechercher:integer;
CodeJounaux:tstringlist;
ListeExclu:array [0..1]of string;
filtre:string;
Begin
try//finally
ListeExclu[0]:='';
filtre:='';
Initialise_TStringlist(DMPointage2.ListeDettesAffich,ReglementSurListe,false);
if RxSBAchatVentes.Down then
  begin
    ListeExclu[0]:='3';
    ListeExclu[1]:='4';
    DMPointage2.ListeDettesAffich.Add('3');
    DMPointage2.ListeDettesAffich.Add('4');
//    filtre:='upper(typeLigne)=''X''';
  end;
 DMPointage2.TaResteDC.DisableControls;
 ID_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').asinteger;
  try //except
    MessDerSub:=false;
    GestionFiltrageParamCpt;
  if EdPlusTiersEntete.text='+' then
    Rechercher:=1
  else
    Rechercher:=0;
     //début du case edcompte.enabled
     case ord(edcompte.Enabled) of
      0:Begin//si pas enabled
//        InfoResteDCSurCompte.DataSetResult.Free;
          if RxSBdettes.down then
            Begin//si RxSBdettes
               DMPointage2.TypeDettes:='C';
               InfoResteDCSurCompte:=RecupDetteCreance(filtre,'*','C',ListeExclu,0,e.DatExoFin,0,0,nil,False);
            End;//fin si RxSBdettes
          if RxSBCreances.down then
            Begin//si RxSBCreances
               DMPointage2.TypeDettes:='D';
               InfoResteDCSurCompte:=RecupDetteCreance(filtre,'*','D',ListeExclu,0,e.DatExoFin,0,0,nil,False);
            End;//fin si RxSBCreances
          if RxSBDC.down then
            Begin//si RxSBDC
               DMPointage2.TypeDettes:='';
               InfoResteDCSurCompte:=RecupDetteCreance(filtre,'*','',ListeExclu,0,e.DatExoFin,0,0,nil,False);
            End;//fin si RxSBDC
          FormatePanelTitreGrille(InfoResteDCSurCompte);
          if DMPointage2.TaResteDC.RecordCount>0 then
            GrDBPointage.setfocus;
        End;//fin si pas enabled
      1:Begin//si enabled
//        InfoResteDCSurCompte.DataSetResult.Free;
       if AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],false,MessDerSub,false,true,true,true,Rechercher) then
          begin
          if RxSBdettes.down then
            Begin//si RxSBdettes
               DMPointage2.TypeDettes:='C';
               InfoResteDCSurCompte:=RecupDetteCreance(filtre,edCompte.Text,'C',ListeExclu,0,e.DatExoFin,0,0,nil,False);
               DC.DernierCpt:=edcompte.text;
               if copy(edcompte.text,1,1)='+' then
                 edlibelle.text:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[edcompte.text]).Nom
               else
                 edlibelle.text:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'compte',[edcompte.text]).Libelle;
               DC.DernierLibelle:=edlibelle.text;
            End;//fin si RxSBdettes
          if RxSBCreances.down then
            Begin//si RxSBCreances
               DMPointage2.TypeDettes:='D';
               InfoResteDCSurCompte:=RecupDetteCreance(filtre,edCompte.Text,'D',ListeExclu,0,e.DatExoFin,0,0,nil,False);
               DC.DernierCpt:=edcompte.text;
               if copy(edcompte.text,1,1)='+' then
                 edlibelle.text:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[edcompte.text]).Nom
               else
                 edlibelle.text:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'compte',[edcompte.text]).Libelle;
               DC.DernierLibelle:=edlibelle.text;
            End;//fin si RxSBCreances
          if RxSBDC.down then
            Begin//si RxSBDC
               DMPointage2.TypeDettes:='';
               InfoResteDCSurCompte:=RecupDetteCreance(filtre,edCompte.Text,'',ListeExclu,0,e.DatExoFin,0,0,nil,False);
               DC.DernierCpt:=edcompte.text;
               if copy(edcompte.text,1,1)='+' then
                 edlibelle.text:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[edcompte.text]).Nom
               else
                 edlibelle.text:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'compte',[edcompte.text]).Libelle;
               DC.DernierLibelle:=edlibelle.text;
            End;//fin si RxSBDC
          FormatePanelTitreGrille(InfoResteDCSurCompte);
          if DMPointage2.TaResteDC.RecordCount>0 then
            GrDBPointage.setfocus;
          end//fin si aide compte valide
       else
          Begin//si aide compte pas valide
             //showmessage('Ce compte n''est pas valide dans ce context');
             abort;
          End;//fin si aide compte pas valide
              DMPointage2.LettrageEnCours:='A';
              DMPointage2.ForceLettrage:='A';

         ///Gestion du plus
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
        End;//fin si enabled
     end;//fin du case edcompte.enabled
  except
     if edcompte.enabled then
       edCompte.SetFocus
     else
       GrDBPointage.setfocus;
  end;
finally
ChangementEtatGrille(nil);
DMPointage2.TaResteDC.EnableControls;
GrDBPointage.DataSource.DataSet.Locate('id',ID_EnCours,[]);
//  CalculSolde(nil);
//  GestionBoutonsSpeed;
//  ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
//  GrDBPointage.DataSource.DataSet.First;
//  GrDBPointage.DataSource.DataSet.Locate('id',ID_EnCours,[]);
//  GrDBPointage.DataSource.DataSet.EnableControls;
end;
End;


procedure TReglementSurListe.RxSBTiersClick(Sender: TObject);
begin
EdCompte.enabled:=true;
EdLibelle.enabled:=true;
label6.visible:=true;
Label2.visible:=label6.visible;
if rxsbdettes.Down then
  Begin//si
    if not empty(DC.DernierCpt)then
      edcompte.text:=DC.DernierCpt;
  End;//fin si
if rxsbCreances.Down then
  Begin//si
    if not empty(DC.DernierCpt)then
      edcompte.text:=DC.DernierCpt;
  End;//fin si
if rxsbDC.Down then
  Begin//si
    if not empty(DC.DernierCpt)then
      edcompte.text:=DC.DernierCpt;
  End;//fin si
if edcompte.CanFocus then edcompte.SetFocus;
SousTitre2:='[ '+ EdCompte.Text + ' ]';
//GestionAffichage(sender);
end;

procedure TReglementSurListe.RxSBDCClick(Sender: TObject);
begin
if edcompte.enabled then
  Begin//si
    edcompte.setfocus;
  if not empty(DC.DernierCpt)then
    edcompte.text:=DC.DernierCpt;
  End;//fin si
SousTitre1:='[ '+ RxSBDC.Caption + ' ]';
GestionAffichage(sender);
//GestionBoutonsSpeed;
end;

procedure TReglementSurListe.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TReglementSurListe.TaResteDCBeforePost_PourReglementSurListe(DataSet: TDataSet);
var
RetourCtrlPointage:TErreurSaisie;
retoursens,TiersEnCours_:string;
Begin
try//finally
try//except
RetourCtrlPointage.retour:=true;
//ID_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').asinteger;
//if ((DMPointage2.ForceLettrage=DMPointage2.LettrageEnCours) and not empty(DMPointage2.ForceLettrage)) then
if not empty(DMPointage2.ForceLettrage) then
 begin
  if ((DataSet.State = dsEdit)and (not verifFnumeric(Dataset.FindField('Montant')).VideOUZero)) then
       Dataset.FindField('Lettre').AsString := DMPointage2.ForceLettrage;
 end;
RetourCtrlPointage.retour:=true;

if not empty(Dataset.FindField('Lettre').AsString) then
begin
retoursens:=RecupSensDeSelectionEnCours(TiersEnCours_);
if not ((empty(retoursens)or(retoursens=DataSet.findfield('sens').asstring)))then
 begin
   RetourCtrlPointage.retour:=false;
   showmessage('Vous ne pouvez pas régler en même temps des écritures de sens opposé !');
//   Dataset.findfield('lettre').AsString:='';
//   Dataset.findfield('Montant').asstring:='';
 end;
//if ((RetourCtrlPointage.retour)and(not empty(TiersEnCours_)))then
//  Begin//si
//    if ((TiersEnCours_<>Dataset.findfield('Tiers').AsString)and(retoursens='C'))then
//      Begin//si
//       if e.TypeClient<>cl_isa then
//       begin
//         RetourCtrlPointage.retour:=false;
//         showmessage('Vous ne pouvez pas régler en une seule pièce des dettes concernant plusieurs tiers !');
//       end;
//      End;//fin si
//  End;//fin si
if RetourCtrlPointage.retour then
  Begin//si retour ok
   RetourCtrlPointage:=DMPointage2.CtrlSaisiePointage(Dataset.Fields[12]);
   if not RetourCtrlPointage.retour then
     case RetourCtrlPointage.CodeErreur of
       1101:abort;
       1202:abort;
     End;//fin du case
  end//fin si retour ok
else
  abort;  
end;
except
  Dataset.findfield('lettre').AsString:='';
  Dataset.findfield('Montant').AsString:='';
  abort;
end;
finally
//
end;
end;


function TReglementSurListe.RecupSensDeSelectionEnCours(var TiersEnCours:string):string;
Begin//si
  filtragedataset(dmrech.TaResteDCRech,'Lettre <> ''''');
  if dmrech.TaResteDCRech.recordcount >0 then
    begin
      result:=dmrech.TaResteDCRech.findfield('Sens').asstring;
      TiersEnCours:=dmrech.TaResteDCRech.findfield('Tiers').asstring;
    end
  else
    begin
      result:='';
      TiersEnCours:='';
    end;
  DeFiltrageDataSet(dmrech.TaResteDCRech);  
End;//fin si

procedure TReglementSurListe.Toutdpointer1Click(Sender: TObject);
begin
  try
    DMPointage2.TaResteDC.DisableControls;
    ID_EnCours:=GrDBPointage.DataSource.DataSet.findfield('id').asinteger;
    if empty(DMPointage2.LettrageEnCours) then
      DMPointage2.LettrageEnCours:='A';
    DMPointage2.Gestion_Annulation_Lettrage(GrDBPointage.DataSource.DataSet,DMPointage2.LettrageEnCours,'',false);
  finally
ChangementEtatGrille(nil);
//  calculsolde(nil);
//    ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
  end;//fin finally
end;


procedure TReglementSurListe.TaResteDCAfterPost_PourReglementSurListe(DataSet: TDataSet);
begin
//if GrDBPointage.DataSource.DataSet.Locate('id',ID_EnCours,[])then
  //GrDBPointage.DataSource.DataSet.next;
end;


Procedure TReglementSurListe.InitialiseTable_A_Nil;
Begin
   if ReglementSurListe <>nil then
InitDatasetEvent_A_Nil_Sur_Form([ReglementSurListe.GrDBPointage.DataSource]);
End;

procedure TReglementSurListe.GrDBPointageDblClick(Sender: TObject);
begin
Visualisation1Click(Visualisation1);
end;

procedure TReglementSurListe.PaTools3Resize(Sender: TObject);
begin
PaTools3.Width:=(PaTools.Width div 25)*8;
FormateTailleBouttonAvecEspace([RxSBAchatVentes,RxSBToutesPieces],PaTools3,90,0,5);
end;

procedure TReglementSurListe.RxSBAchatVentesClick(Sender: TObject);
begin
SousTitre1:='[ '+ RxSBAchatVentes.Caption + ' ]';
GestionAffichage(sender);
end;

procedure TReglementSurListe.RxSBToutesPiecesClick(Sender: TObject);
begin
SousTitre1:='[ '+ RxSBToutesPieces.Caption + ' ]';
GestionAffichage(sender);
end;


procedure TReglementSurListe.CalculSolde(Sender: TObject);
Begin
timer1.Enabled:=true;
end;

procedure TReglementSurListe.Timer1Timer(Sender: TObject);
var
SoldeDebit,SoldeCredit:currency;
SoldeDebitReste,SoldeCreditReste:currency;
begin
try//finally
timer1.Enabled:=false;

DMPointage2.QuSoldeCreances.SQL.Clear;
DMPointage2.QuSoldeCreances.SQL.Add('select sum(reste)as resteDebit,sum(Montant)as MontantDebit from resteDc ');
if not empty(DMPointage2.tarestedc.Filter) then
  DMPointage2.QuSoldeCreances.SQL.Add(' where sens=''D'' and '+DMPointage2.FiltrePourSolde);
DMPointage2.QuSoldeCreances.open;

DMPointage2.QuSoldeDettes.SQL.Clear;
DMPointage2.QuSoldeDettes.SQL.Add('select sum(reste)as resteCredit,sum(Montant)as MontantCredit from resteDc ');
if not empty(DMPointage2.tarestedc.Filter) then
  DMPointage2.QuSoldeDettes.SQL.Add(' where sens=''C'' and '+DMPointage2.FiltrePourSolde);
DMPointage2.QuSoldeDettes.open;
//
SoldeDebit:=0;
SoldeCredit:=0;
SoldeDebitReste:=0;
SoldeCreditReste:=0;

GrGrid3.cells[0,0]:='';
GrGrid3.cells[1,0]:='';

GrGrid4.cells[0,0]:='';
GrGrid4.cells[1,0]:='';

          if (RxSBdettes.down) then
            Begin//si RxSBdettes
               if DMPointage2.QuSoldeDettes.recordcount<>0 then
                begin
                  SoldeCredit:=DMPointage2.QuSoldeDettes.findfield('MontantCredit').ascurrency;
                  GrGrid3.cells[1,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ',DMPointage2.QuSoldeDettes.findfield('resteCredit').ascurrency );
                  SoldeCreditReste:=DMPointage2.QuSoldeDettes.findfield('resteCredit').ascurrency;
                end;
            End;//fin si RxSBdettes
          if (RxSBCreances.down) then
            Begin//si RxSBCreances
                if DMPointage2.QuSoldeCreances.recordcount<>0 then
                begin
                  SoldeDebit:=DMPointage2.QuSoldeCreances.findfield('MontantDebit').ascurrency ;
                  GrGrid3.cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ',DMPointage2.QuSoldeCreances.findfield('resteDebit').ascurrency);
                  SoldeDebitReste:=DMPointage2.QuSoldeCreances.findfield('resteDebit').ascurrency;
                end;
            End;//fin si RxSBCreances
          if RxSBDC.down then
            Begin//si RxSBDC
                if DMPointage2.QuSoldeCreances.recordcount<>0 then
                begin
                  SoldeDebit:=DMPointage2.QuSoldeCreances.findfield('MontantDebit').ascurrency ;
                  GrGrid3.cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ',DMPointage2.QuSoldeCreances.findfield('resteDebit').ascurrency);
                  SoldeDebitReste:=DMPointage2.QuSoldeCreances.findfield('resteDebit').ascurrency;
                end;
               if DMPointage2.QuSoldeDettes.recordcount<>0 then
                begin
                  SoldeCredit:=DMPointage2.QuSoldeDettes.findfield('MontantCredit').ascurrency;
                  GrGrid3.cells[1,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ',DMPointage2.QuSoldeDettes.findfield('resteCredit').ascurrency );
                  SoldeCreditReste:=DMPointage2.QuSoldeDettes.findfield('resteCredit').ascurrency;
                end;
            End;//fin si RxSBDC
BtnEnregistrer.Enabled:=((SoldeDebit<>0) or (SoldeCredit<>0));
   Enregister1.Enabled:=BtnEnregistrer.enabled;
   LaValidation.visible:=BtnEnregistrer.enabled;
EnableWinControl([Twincontrol(RxSBCreances),Twincontrol(RxSBdettes),Twincontrol(RxSBDC),Twincontrol(RxSBTous),Twincontrol(RxSBTiers),Twincontrol(RxSBAchatVentes),Twincontrol(RxSBToutesPieces)],not BtnEnregistrer.enabled);

DetermineSolde(SoldeDebit,SoldeCredit);
GrGrid3.cells[2,0]:='';
if (SoldeDebit)>0 then
  GrGrid3.cells[2,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ',SoldeDebit )
else
  if (SoldeCredit)>0 then
  GrGrid3.cells[2,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ',SoldeCredit);

DetermineSolde(SoldeDebitReste,SoldeCreditReste);
GrGrid4.cells[2,0]:='';
if SoldeDebitReste>0 then
  GrGrid4.Cells[0,0]:='D '+FormatFloat(E.FormatMonnaie + ';; ',SoldeDebitReste );
if SoldeCreditReste>0 then
GrGrid4.Cells[1,0]:='C '+FormatFloat(E.FormatMonnaie + ';; ',SoldeCreditReste);

//ChangementEtatGrille(GrDBPointage.DataSource.DataSet);
GestionBoutonsSpeed;
//if ID_EnCours<>-1 then
//GrDBPointage.DataSource.DataSet.locate('id',ID_EnCours,[]);
//ID_EnCours:=-1;
finally
timer2.Enabled:=true;
end;//fin du try finally
end;

procedure TReglementSurListe.Timer2Timer(Sender: TObject);
begin
timer2.Enabled:=false;
//ReEnableControls(DMPointage2.TaResteDC);
end;

procedure TReglementSurListe.Modifierpice1Click(Sender: TObject);
begin
showmessage(VersionUlterieur);
end;

procedure TReglementSurListe.GrDBPointageTitleClick(Column: TColumn);
begin
//if e.TypeClient=cl_isa then
  begin
    case Column.Index of
    0:begin
       DMPointage2.TaResteDC.IndexName:='DateSeule';
       GestionAffichage(nil);
      end;
    1:begin
       DMPointage2.TaResteDC.IndexName:='Date_';
       GestionAffichage(nil);
      end;
    5,6:begin
       DMPointage2.TaResteDC.IndexName:='ResteSeule';
       GestionAffichage(nil);
      end;
    end;//fin du case
  end;
end;

procedure TReglementSurListe.riparTiers1Click(Sender: TObject);
begin
  DMPointage2.TaResteDC.IndexName:='Date_'
end;

procedure TReglementSurListe.Relancedestiers1Click(Sender: TObject);
begin
if not empty(Edcompte.text) then
  EditionDetteCreanceL_affineeEcheance(C_EditionSimple,true,Edcompte.text,nil,e.SautDePageAutomatique,true,false,DMPointage2.ListeDettesAffich,DMPointage2.TypeDettes)
else
  EditionDetteCreanceL_affineeEcheance(C_EditionSimple,true,nil,nil,e.SautDePageAutomatique,true,false,DMPointage2.ListeDettesAffich,DMPointage2.TypeDettes)
end;

procedure TReglementSurListe.Touscomptes1Click(Sender: TObject);
var
ListeCpt:TResultStrList;
Requete : TQuery;
rang:integer;
Filtre:string;
begin
if not empty(Edcompte.text) then
  EditionDetteCreanceL_affinee(C_EditionSimple,true,Edcompte.text,nil,e.SautDePageAutomatique,false,true,DMPointage2.ListeDettesAffich,DMPointage2.TypeDettes)
else
  begin
  try
    requete := TQuery.Create(self);
    //pour récupérer les types de tiers
    ListeCpt.Liste:=TStringList.Create;
    ListeCpt.result:=true;
    requete.DatabaseName :=DMRech.TaTiersRech.DatabaseName;
    requete.SQL.Add(' select distinct type,compte from tiers T');
    requete.Open;
    requete.First;
    Filtre:='';
    listecpt:=ChoixCompteAffich('Sélectionnez les types de tiers ...',requete,['type','compte'],true);
    if(ListeCpt.Result) and (ListeCpt.Liste.Count>0)then
      filtre:=' where '+CreeFiltreOU('type',[ListeCpt.Liste]);
    requete.close;
    requete.SQL.Clear;


    requete.DatabaseName := DMRech.TaTiersRech.DatabaseName;
    requete.SQL.Add(' select Tiers,compte,nom,type from tiers T');

    requete.SQL.Add(filtre);

    requete.SQL.Add(' union all');
    requete.SQL.Add(' select P.compte,P.compte,P.Libelle,'''' from plancpt P where');
    requete.SQL.Add(' P.pointable=true and P.compte not in');
    requete.SQL.Add(' (select T2.compte from tiers T2 where T2.compte=P.compte)');
    requete.SQL.Add(' order by compte,tiers');
      requete.Open;
      ListeCpt.Liste:=TStringList.Create;
      ListeCpt.result:=true;
      DeFiltrageDataSet(requete);
      listecpt:=ChoixCompteAffich('Sélectionnez les tiers...',requete,['Tiers','compte','nom','type'],true);
      requete.first;
      if (ListeCpt.Result)and (ListeCpt.Liste.count>1) then
          begin //si la liste contient plus d'un tiers, on inverse les champs pour rentrer dans la configuration de l'edition
              while not requete.Eof do
              begin
                rang:=ListeCpt.Liste.IndexOf(requete.findfield('Tiers').AsString);
                if rang>-1 then
                  ListeCpt.Liste.Strings[rang]:=requete.findfield('compte').AsString+';'+ListeCpt.Liste.Strings[rang]+';'+requete.findfield('nom').AsString;
                requete.next;
              end;
          end ;
  if ListeCpt.Result then
    EditionDetteCreanceL_affinee(C_EditionSimple,True,ListeCpt.Liste,nil,e.SautDePageAutomatique,false,true,DMPointage2.ListeDettesAffich,DMPointage2.TypeDettes);
//    EditionDetteCreanceL_affinee(C_EditionSimple,true,nil,nil,false,true,DMPointage2.ListeDettesAffich,DMPointage2.TypeDettes)
  finally
      Requete.Close;
      requete.free;
  end;
end;
end;

procedure TReglementSurListe.Comptesdentteuniquement1Click(
  Sender: TObject);
var
Site:TEditLien;
begin
if not empty(Edcompte.text) then
  EditionDetteCreanceL(C_EditionSimple,true,Edcompte.text,nil,e.SautDePageAutomatique,false,true,DMPointage2.ListeDettesAffich,DMPointage2.TypeDettes)
else
  EditionDetteCreanceL(C_EditionSimple,true,nil,nil,e.SautDePageAutomatique,false,true,DMPointage2.ListeDettesAffich,DMPointage2.TypeDettes)
end;

procedure TReglementSurListe.BtnImprimerClick(Sender: TObject);
begin
Touscomptes1.Click;
end;

procedure TReglementSurListe.Calculatrice1Click(Sender: TObject);
begin
if GrDBPointage.Col in [8] then
begin
  TableGereEdit(GrDBPointage.DataSource.DataSet);
  AfficheCalculatrice(GrDBPointage);
end
else
  AfficheCalculatrice(nil);
end;

end.
