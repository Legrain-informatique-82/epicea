unit E2_ReglementSurListe2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls,  Buttons,  CurrEdit,ToolEdit,Mask,RXCtrls,GrGrid,
  ExtCtrls,  Grids,
  DMEcriture,
  DMPiece,
  gr_Librairie_obj,
  LibZoneSaisie,
  LibRessourceString,
  Ecriture_Isa,
  Piece,
  DMRecherche,
  DMImportation,
  DMBaseDonnee,
  LibSQL,
  Lib1,
  db,
  E2_ChoixReglementAuto,
  E2_Decl_Records,
  DMTTVA,
  DMConstantes,
  LibGestionParamXML,
  lib_chaine,
  jpeg;

type


  TReglementSurListe2 = class(TForm)
    Patitre: TPanel;
    PaGrille: TPanel;
    PaBas: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    GrGrid1: TGrGrid;
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnModifier: TButton;
    BtnInserer: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
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
    procedure Calculatrice1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PaBtnResize(Sender: TObject);
    procedure BtnFermerEnter(Sender: TObject);
    procedure BtnFermerExit(Sender: TObject);
    procedure PaCumul1Resize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrGrid1ColExit(OldColonne, LastRow: Integer);
    function CtrlSaisieReglementSurListe(Grille:TGrGrid):TErreurSaisie;
    procedure GrGrid1DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GrGrid1RowEnter(sender: TObject; NewRow: Integer);
    procedure GrGrid1RowValidate(Sender: TObject; var Valide,
      Action: Boolean; LastCol: Integer);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure GrGrid1BeforeSupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    procedure GrGrid1SupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  TiersEnCours:string;

  end;

var
  ReglementSurListe2: TReglementSurListe2;

  ListeReference:tstringlist;

  procedure AffichageListeReglement(ListeReglement:TList;Var Grille:TGrGrid);
  procedure CreationPieceEcritureSurReglementSurListe(var Piece:TPiece;Var Ecriture:TEcriture_Isa;var ReglementSurListe:tlist);
  Procedure RecupListePourReglementSurListe(ReferenceUnique,DetailTiers:boolean;Liste_A_Regler:TList;var ListeReglementSurListe:TList);
  procedure ListEcriture_A_Regler_Add_Insert(var Liste:Tlist;Valeur:array of const;Add,Remplace:boolean;Rang:integer);
  function ReglementSurListe_Creation(Coordonnees:Trect;Affich:boolean;ReferenceUnique,DetailTiers:boolean;Liste_A_Regler:TList):TList;
  function Ecriture_A_Regler(IDEcriture:integer):TEcriture_A_Regler;
implementation
{$R *.DFM}
Uses E2_Librairie_obj,
//Gr_Calculatrice,
E2_Main, DMJournaux,
   E2_LibInfosTable,DMBalances, DMPlanCpt,E2_AideModel,E2_AideCompte,LibDates;


//Function TReglementSurListe2.CalculLeft (colcourante : integer) : integer;
//Var
//   i : integer;
//Begin
//  Result := 2;
//  for  i:=0 to (colcourante - 1) do
//    begin
//      result := Result + GrGrid1.ColWidths[i]
//    end;
//  Result := Result + GrGrid1.Left + 11;
//End;


procedure TReglementSurListe2.Calculatrice1Click(Sender: TObject);
begin
  AfficheCalculatrice(nil);
end;

procedure TReglementSurListe2.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TReglementSurListe2.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(Self,E.USer);
  ReglementSurListe2:=nil;
end;

procedure TReglementSurListe2.pmMenu1Click(Sender: TObject);
begin
  PopupMenu1.Popup(Left + 50, Top + 50);
end;



procedure TReglementSurListe2.FormShow(Sender: TObject);
begin
  GrGrid1 .SetFocus;
  PaGrilleResize(PaGrille);
end;



procedure TReglementSurListe2.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
GrGrid1.ParamColor:=true;
GrGrid1.Param:=ParamUtil.CouleurDBGrid;
GrGrid1.UpDateColor;
PaBtnResize(PaBtn);
//  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,PaBtn.height + 1);
//  if activecontrol.ClassNameIs('TButton') then BtnFermerEnter(activecontrol);
//  FormShow(self);
end;

procedure TReglementSurListe2.PaGrilleResize(Sender: TObject);
begin
  WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
//  PositionTotaux;
end;



procedure TReglementSurListe2.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  canclose:=true;
end;

procedure TReglementSurListe2.PaBtnResize(Sender: TObject);
begin
  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,PaBtn.height + 1);
end;

procedure TReglementSurListe2.BtnFermerEnter(Sender: TObject);
begin
  BouttonDiminue(sender as TButton);
end;

procedure TReglementSurListe2.BtnFermerExit(Sender: TObject);
begin
  BouttonAgrandit(sender as TButton);
  PaBtnResize(PaBtn);
//  FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,PaBtn.height + 1);
end;

procedure TReglementSurListe2.PaCumul1Resize(Sender: TObject);
begin
//  PositionTotaux;
end;

procedure TReglementSurListe2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;
end;

function ReglementSurListe_Creation(Coordonnees:Trect;Affich:boolean;ReferenceUnique,DetailTiers:boolean;Liste_A_Regler:TList):TList;
var
i:integer;
Begin
result:=Tlist.Create;
RecupListePourReglementSurListe(ReferenceUnique,DetailTiers,Liste_A_Regler,result);
if (ReglementSurListe2 = nil) then ReglementSurListe2:=TReglementSurListe2.Create(Application.MainForm);
if Affich then
  begin
    if result<>nil then
      begin
        //initialiser la fenêtre d'affichage des réglements sur liste et
        //afficher les lignes de réglement
        AffichageListeReglement(result,ReglementSurListe2.GrGrid1);
        if not(ReglementSurListe2.ShowModal=mrok)then
          begin
//          for i:=0 to result.Count-1 do
//            Begin
              Initialise_TList(result,ReglementSurListe2);{ isa  le  06/08/04 }
//              TEcriture_Isa(result.Items[i]).free;
//            End;
//          result:=nil;
          end
        else
          begin//si validation des réglements sur liste
            //creer chaque piece et écriture et les enregistrer
          if result<>nil then
             begin
               CreationPieceEcritureSurReglementSurListe(DMImport.Piece_Import,DMImport.Ecriture_Import,result);
             end;
          end;
      end;
  end//fin si affich
else
 if result<>nil then
    begin
       CreationPieceEcritureSurReglementSurListe(DMImport.Piece_Import,DMImport.Ecriture_Import,result);
     end;
End;

Procedure RecupListePourReglementSurListe(ReferenceUnique,DetailTiers:boolean;Liste_A_Regler:TList;var ListeReglementSurListe:TList);
var
reglement:tEcriture_Isa;
ObjPiece:tpiece;
MontantTotal:currency;
Journal:TInfosModel;
InfosTiers:TInfosTiers;
ReferenceTmp,LibelleTmp,CompteReglement:string;
TiersCourant:string;
i:integer;
AffichChoix:Boolean;
DateAPrendre:Tdatetime;

typeTvaE,SupprOD:boolean;
mess:TMessageLGR;
compteAppelant:Tstringlist;
Begin
typeTvaE:=false;
SupprOD:=false;
AffichChoix:=true;
       DMImport.VerifCreationPieceEcriture;
DMImport.Piece_Import.NouvellePiece(false);

//regarder si typeTvaE dans une des pièces appelantes
if Liste_A_Regler.count<>0 then
  begin
  i:=0;
  while ((i<Liste_A_Regler.count)and(typeTvaE=false)) do
    Begin//début for Liste_A_Regler
      typeTvaE:=PEcriture_A_Regler(Liste_A_Regler.Items[i]).TvaSurE;
      inc(i);
    End;//fin for Liste_A_Regler
  end;

if AffichChoix then
 begin
 compteAppelant:=tstringlist.Create;
 compteAppelant.Duplicates:=dupIgnore;
 for i:=0 to Liste_A_Regler.count-1 do
   begin
     MontantTotal:=MontantTotal+PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
     compteAppelant.Add(PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_);
   end;
   if DateDsIntervale(e.DatExoDebut,now,e.DatExoFin,mess) then
     DateAPrendre:=now
   else
     Begin
       if Now<e.DatExoDebut then
         DateAPrendre:=e.DatExoDebut
       else
         DateAPrendre:=e.DatExoFin;
     End;
   CompteReglement:='';
   ReferenceTmp:='';
   LibelleTmp:='';
    case ChoixReglementAffiche(compteAppelant,DateAPrendre,CompteReglement,ReferenceTmp,LibelleTmp,MontantTotal,typeTvaE,SupprOD) of
       0:abort ;
       1:begin
          REferenceUnique:=false;
          DetailTiers:=true;
         end;
       3:begin
          REferenceUnique:=true;
          DetailTiers:=false;
         end;
       2:begin
          REferenceUnique:=true;
          DetailTiers:=true;
         end;
    end;
 end;
if (ReglementSurListe2 = nil) then ReglementSurListe2:=TReglementSurListe2.Create(Application.MainForm);
TiersCourant:='';
//si date aujourd'hui supérieure ou égale à prochaine déclaration ou
//si prochaine déclaration hors exercice courant
Reglement:=tEcriture_Isa.Create(application.MainForm);
       DMImport.VerifCreationPieceEcriture;
DMImport.Piece_Import.NouvellePiece(false);
ObjPiece:=TPiece.Create(application.MainForm);
ObjPiece.trame:=TTrame.Create(application.MainForm);
ObjPiece.NouvellePiece(false);
ObjPiece.TablePiece:=DMImport.Piece_Import.TablePiece;
ObjPiece.CodeExo:=DMImport.Piece_Import.CodeExo;
ObjPiece.SuppDerniereDeclTva:=SupprOD;
ListeReference:=TStringList.Create;
if ListeReglementSurListe=nil then
  ListeReglementSurListe:=TList.Create;
  for i:=0 to Liste_A_Regler.Count-1 do
     begin //début de la boucle for  Liste_A_Regler.count
     if ReferenceUnique then
       Begin //si ReferenceUnique on ne crée qu'une seule référence pour toutes les lignes de réglement
       MontantTotal:=0;
       //récupérer le journal en fonction du compte de réglement
       Journal:=Infos_TInfosModel(DMrech.TaModelRech,'Compte',[CompteReglement]);
       if empty(Journal.Journal)then
       Journal.Journal:='OD';
       //à partir du journal créer la nouvelle et unique référence
       if empty(ReferenceTmp)then
         ReferenceTmp:=gestionDerniereReference(Journal.Journal,ObjPiece,ListeReference);
         if DetailTiers then
           Begin
//             { isa  le  05/08/04 ??}
                 if reglement.Piece=nil then //je detruis ces objets que s'il ne sont pas rentrés
                                     // dans une liste que je libérerai pas la suite
                   Reglement.Destroy;
//             { isa  le  05/08/04 }
             Reglement:=tEcriture_Isa.Create(application.MainForm);
             ObjPiece.Reference:=ReferenceTmp;
             if ListeReference.IndexOf(ObjPiece.Reference)=-1 then
               ListeReference.Add(ObjPiece.Reference);
             if journal.ID_journal=0 then
             ObjPiece.IDJournal:=3
             else
             ObjPiece.IDJournal:=journal.ID_journal;
             ObjPiece.journal:=Journal.Journal;
             if PEcriture_A_Regler(Liste_A_Regler.Items[i])^.TvaSurE then
               ObjPiece.TypeTvaE:=true;
             //reglement.ListeContrepartie.Add(PEcriture_A_Regler(Liste_A_Regler.Items[i]));
             AssignListeContrepartie(Liste_A_Regler,reglement.ListeContrepartie,i);
             reglement.SoldeEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
             reglement.SensEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Sens;
             ObjPiece.Montant:=ObjPiece.Montant+PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
             //piece.Compte:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.CompteReglement;
             ObjPiece.Compte:=CompteReglement;
             if empty(LibelleTmp)then
               ObjPiece.Libelle:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[ObjPiece.Compte]).Libelle
             else
               ObjPiece.Libelle:=LibelleTmp;
             if copy(PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_,1,1)='+' then
               begin
               reglement.TiersEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_;
               InfosTiers:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[reglement.tiersecriture]);
               reglement.CompteEcriture:=InfosTiers.Compte;
               //reglement.LibelleEcriture:=InfosTiers.Nom;
               reglement.LibelleEcriture:=LibelleTmp;
               end
             else
               begin
               reglement.TiersEcriture:='';
               reglement.CompteEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_;
               //reglement.LibelleEcriture:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[reglement.CompteEcriture]).Libelle;
               reglement.LibelleEcriture:=LibelleTmp;
               end;
             DeFiltrageDataSet(DMRech.TaEcritureRech);
             reglement.FirstIDEcriture:=DMImport.Ecriture_Import.NewIDEcriture(dmrech.TaEcritureRech,'ID');
             ObjPiece.DateSaisie:=DateAPrendre;
//             reglement.Piece:=piece;
             if reglement.Piece=nil then
               reglement.Piece:=TPiece.Create(application.MainForm);
             CopieContenuPiece(ObjPiece,reglement.Piece,false);
             //remplir la liste des réglements
//             if Type_version_execution=CT_DEVELOPPEMENT then AfficheInfoComposant('',reglement,true);
             ListeReglementSurListe.Add(reglement);
             //ObjPiece.ListeEcritures.AddObject('',reglement);
           End
         else
           Begin
             if TiersCourant<>PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_ then
               begin //si le tiers change on crée un nouveau réglement avec la même référence
                 //remplir la liste des réglements que au moment d'un changement de tiers
                 if ((reglement<>nil)and(ObjPiece<>nil)) then
                   begin
                   if not empty(ObjPiece.Reference)then
                     begin
//             if Type_version_execution=CT_DEVELOPPEMENT then AfficheInfoComposant('',reglement,true);
                     ListeReglementSurListe.Add(reglement);
                     //ObjPiece.ListeEcritures.AddObject('',reglement);
                     end;
                   end;
//                 { isa  le  05/08/04 ??}
                 if reglement.Piece=nil then //je detruis ces objets que s'il ne sont pas rentrés
                                    // dans une liste que je libérerai pas la suite
                   Reglement.Destroy;
//                 { isa  le  05/08/04 }
                 Reglement:=TEcriture_Isa.Create(application.MainForm);

                 if journal.ID_journal=0 then
                 ObjPiece.IDJournal:=3
                 else
                 ObjPiece.IDJournal:=journal.ID_Journal;
                 ObjPiece.journal:=Journal.Journal;
                 ObjPiece.Reference:=ReferenceTmp;
                 if ListeReference.IndexOf(ObjPiece.Reference)=-1 then
                   ListeReference.Add(ObjPiece.Reference);
                 reglement.SensEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Sens;
                 //ObjPiece.Compte:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.CompteReglement;
                 ObjPiece.Compte:=CompteReglement;
                 if empty(LibelleTmp)then
                   ObjPiece.Libelle:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[ObjPiece.Compte]).Libelle
                 else
                   ObjPiece.Libelle:=LibelleTmp;
//                 ObjPiece.Libelle:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[piece.Compte]).Libelle;
                 if copy(PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_,1,1)='+' then
                   begin
                   reglement.TiersEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_;
                   InfosTiers:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[reglement.tiersecriture]);
                   reglement.CompteEcriture:=InfosTiers.Compte;
                   //reglement.LibelleEcriture:=InfosTiers.Nom;
                   reglement.LibelleEcriture:=LibelleTmp;
                   end
                 else
                   begin
                   reglement.TiersEcriture:='';
                   reglement.CompteEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_;
                   //reglement.LibelleEcriture:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[reglement.CompteEcriture]).Libelle;
                   reglement.LibelleEcriture:=LibelleTmp;
                   end;
                 DeFiltrageDataSet(DMRech.TaEcritureRech);
                 reglement.FirstIDEcriture:=DMImport.Ecriture_Import.NewIDEcriture(dmrech.TaEcritureRech,'ID');
                 TiersCourant:=reglement.TiersEcriture;
                 ObjPiece.DateSaisie:=DateAPrendre;
//                 reglement.Piece:=ObjPiece;
               end;//fin si le tiers change
             if PEcriture_A_Regler(Liste_A_Regler.Items[i])^.TvaSurE then
               ObjPiece.TypeTvaE:=true;
             AssignListeContrepartie(Liste_A_Regler,reglement.ListeContrepartie,i);
//             reglement.ListeContrepartie.Add(PEcriture_A_Regler(Liste_A_Regler.Items[i]));
             reglement.SoldeEcriture:=reglement.SoldeEcriture+PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
             ObjPiece.Montant:=ObjPiece.Montant+PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
             if reglement.Piece=nil then
               reglement.Piece:=TPiece.Create(application.MainForm);
                 CopieContenuPiece(ObjPiece,reglement.Piece,false);
           End;
       End //fin si ReferenceUnique
     else
       Begin//si plusieurs références
         if DetailTiers then//si on détaille, pour chaque ligne_A_Regler on crée une nouvelle référence
           Begin
//             { isa  le  05/08/04 ??}
                 if reglement.Piece=nil then //je detruis ces objets que s'il ne sont pas rentrés
                   begin                  // dans une liste que je libérerai pas la suite
                       if ObjPiece.Trame<> nil then
                         ObjPiece.Trame.destroy;
                       ObjPiece.Destroy;
                       Reglement.Destroy;
                   end;
//             { isa  le  05/08/04 }
             Reglement:=TEcriture_Isa.Create(application.MainForm);
             ObjPiece:=TPiece.Create(application.MainForm);
//             ObjPiece.trame:=TTrame.Create(application.MainForm);
             ObjPiece.NouvellePiece(false);
             ObjPiece.SuppDerniereDeclTva:=SupprOD;
             ObjPiece.TablePiece:=DMImport.Piece_Import.TablePiece;
             ObjPiece.CodeExo:=DMImport.Piece_Import.CodeExo;
             //récupérer le journal en fonction du compte de réglement
             Journal:=Infos_TInfosModel(DMrech.TaModelRech,'Compte',[CompteReglement]);
             if empty(Journal.Journal)then
             Journal.Journal:='OD';
             //à partir du journal créer la nouvelle référence
             //ReferenceTmp:=DMImport.Piece_Import.NewReference(dmrech.TaPieceRech,'Reference',Journal.Journal,E.ExerciceSaisie,piece.Reference);
             ReferenceTmp:=gestionDerniereReference(Journal.Journal,ObjPiece,ListeReference);
             ObjPiece.Reference:=ReferenceTmp;
             if ListeReference.IndexOf(ObjPiece.Reference)=-1 then
               ListeReference.Add(ObjPiece.Reference);
             if journal.ID_journal=0 then
             ObjPiece.IDJournal:=3
             else
             ObjPiece.IDJournal:=journal.ID_journal;
             ObjPiece.journal:=Journal.Journal;
             if PEcriture_A_Regler(Liste_A_Regler.Items[i])^.TvaSurE then
               ObjPiece.TypeTvaE:=true;
             AssignListeContrepartie(Liste_A_Regler,reglement.ListeContrepartie,i);
             //reglement.ListeContrepartie.Add(PEcriture_A_Regler(Liste_A_Regler.Items[i]));
             reglement.SoldeEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
             ObjPiece.Montant:=ObjPiece.Montant+PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
             reglement.SensEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Sens;
             //piece.Compte:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.CompteReglement;
             ObjPiece.Compte:=CompteReglement;
             ObjPiece.Libelle:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[ObjPiece.Compte]).Libelle;
             if copy(PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_,1,1)='+' then
               begin
               reglement.TiersEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_;
               InfosTiers:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[reglement.tiersecriture]);
               reglement.CompteEcriture:=InfosTiers.Compte;
               reglement.LibelleEcriture:=InfosTiers.Nom;
               end
             else
               begin
               reglement.TiersEcriture:='';
               reglement.CompteEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_;
               reglement.LibelleEcriture:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[reglement.CompteEcriture]).Libelle;
               end;
             DeFiltrageDataSet(DMRech.TaEcritureRech);
             reglement.FirstIDEcriture:=DMImport.Ecriture_Import.NewIDEcriture(dmrech.TaEcritureRech,'ID');
             if reglement.Piece=nil then
               reglement.Piece:=TPiece.Create(application.MainForm);
             ObjPiece.DateSaisie:=DateAPrendre;
             CopieContenuPiece(ObjPiece,reglement.Piece,false);
//             reglement.Piece:=piece;
             //remplir la liste des réglements
//             if Type_version_execution=CT_DEVELOPPEMENT then AfficheInfoComposant('',reglement,true);
             ListeReglementSurListe.Add(reglement);
             //ObjPiece.ListeEcritures.AddObject('',reglement);
           End //fin si on détaille
         else
           Begin//si on ne détaille pas, on crée une nouvelle référence à chaque changement de tiers
             if TiersCourant<>PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_ then
               begin //si le tiers change on crée un nouveau réglement avec la même référence
                 //remplir la liste des réglements que au moment d'un changement de tiers
                 if ((reglement<>nil)and(ObjPiece<>nil)) then
                   begin
                   if not empty(ObjPiece.Reference) then
                     begin
//             if Type_version_execution=CT_DEVELOPPEMENT then AfficheInfoComposant('',reglement,true);
                     ListeReglementSurListe.Add(reglement);
                     //ObjPiece.ListeEcritures.AddObject('',reglement);
                     end;
                   end;
//                 { isa  le  05/08/04 ??}
                 if reglement.Piece=nil then //je detruis ces objets que s'il ne sont pas rentrés
                   begin                  // dans une liste que je libérerai pas la suite
                       if ObjPiece.Trame<> nil then
                         ObjPiece.Trame.destroy;
                       ObjPiece.Destroy;
                       Reglement.Destroy;
                   end;
//                 { isa  le  05/08/04 }
                 Reglement:=TEcriture_Isa.Create(application.MainForm);
                 ObjPiece:=TPiece.Create(application.MainForm);
                 ObjPiece.NouvellePiece(false);
                 ObjPiece.TablePiece:=DMImport.Piece_Import.TablePiece;
                 ObjPiece.CodeExo:=DMImport.Piece_Import.CodeExo;
                 ObjPiece.SuppDerniereDeclTva:=SupprOD;
                 //récupérer le journal en fonction du compte de réglement
                 Journal:=Infos_TInfosModel(DMrech.TaModelRech,'Compte',[CompteReglement]);
                 if empty(Journal.Journal)then
                 Journal.Journal:='OD';
                 //à partir du journal créer la nouvelle référence
                 //ReferenceTmp:=DMImport.Piece_Import.NewReference(dmrech.TaPieceRech,'Reference',Journal.Journal,E.ExerciceSaisie,piece.Reference);
                 ReferenceTmp:=gestionDerniereReference(Journal.Journal,ObjPiece,ListeReference);
                 ObjPiece.Reference:=ReferenceTmp;
                 if ListeReference.IndexOf(ObjPiece.Reference)=-1 then
                   ListeReference.Add(ObjPiece.Reference);
                 if journal.ID_journal=0 then
                 ObjPiece.IDJournal:=3
                 else
                 ObjPiece.IDJournal:=journal.ID_journal;
                 ObjPiece.journal:=Journal.Journal;
                 reglement.SensEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Sens;
                 //ObjPiece.Compte:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.CompteReglement;
                 ObjPiece.Compte:=CompteReglement;
                 ObjPiece.Libelle:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[ObjPiece.Compte]).Libelle;
                 if copy(PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_,1,1)='+' then
                   begin
                   reglement.TiersEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_;
                   InfosTiers:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[reglement.tiersecriture]);
                   reglement.CompteEcriture:=InfosTiers.Compte;
                   reglement.LibelleEcriture:=InfosTiers.Nom;
                   end
                 else
                   begin
                   reglement.TiersEcriture:='';
                   reglement.CompteEcriture:=PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Tiers_;
                   reglement.LibelleEcriture:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[reglement.CompteEcriture]).Libelle;
                   end;
                 DeFiltrageDataSet(DMRech.TaEcritureRech);
                 reglement.FirstIDEcriture:=DMImport.Ecriture_Import.NewIDEcriture(dmrech.TaEcritureRech,'ID');
                 TiersCourant:=reglement.TiersEcriture;
                 ObjPiece.DateSaisie:=DateAPrendre;
//                 reglement.Piece:=piece;
               end;//fin si le tiers change
                 if reglement.Piece=nil then
                   reglement.Piece:=TPiece.Create(application.MainForm);
                 if PEcriture_A_Regler(Liste_A_Regler.Items[i])^.TvaSurE then
                   ObjPiece.TypeTvaE:=true;
                 AssignListeContrepartie(Liste_A_Regler,reglement.ListeContrepartie,i);
                 //reglement.ListeContrepartie.Add(PEcriture_A_Regler(Liste_A_Regler.Items[i]));
                 reglement.SoldeEcriture:=reglement.SoldeEcriture+PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
                 ObjPiece.Montant:=ObjPiece.Montant+PEcriture_A_Regler(Liste_A_Regler.Items[i])^.Montant;
                 CopieContenuPiece(ObjPiece,reglement.Piece,false);
           End;//fin si on ne détaille pas
       End;//fin si plusieurs références
     end;//fin de la boucle for  Liste_A_Regler.count
if ((reglement<>nil)and(not DetailTiers)) then
  begin
//             if Type_version_execution=CT_DEVELOPPEMENT then AfficheInfoComposant('',reglement,true);
    ListeReglementSurListe.Add(reglement);
    //ObjPiece.ListeEcritures.AddObject('',reglement);
  end;
if ObjPiece.Trame<>nil then ObjPiece.Trame.Destroy;
if ObjPiece<>nil then ObjPiece.Destroy;
//if Reglement<>nil then Reglement.Destroy; //je ne détruit pas le réglement car il est intégré aux listes
//qui seront elles mêmes libérées
End;


//Cette procedure permet de créer un objet pièce et ecriture en fonction d'un record representant un réglement sur liste
// en vue de les enregistrer par ailleurs
procedure CreationPieceEcritureSurReglementSurListe(var Piece:TPiece;Var Ecriture:TEcriture_Isa;var ReglementSurListe:tlist);
var
OD:string;
ListeOd:TStringList;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
i,x,j:integer;
referenceCourante:string;
ValPieceAutoGen:TValPieceAutoGenere;
TypeLigne:string[1];
VarPEcriture_A_Regler:PEcriture_A_Regler;
ListeTmp:Tlist;
Begin
ListeTmp:=Tlist.Create;
Initialise_TList(ListeTmp,ReglementSurListe2,false);
if (ReglementSurListe2 = nil) then ReglementSurListe2:=TReglementSurListe2.Create(Application.MainForm);
try
TableGereStartTransaction(DMImport.TaPiece_Import);
try
if ReglementSurListe<>nil then
  Begin//si la liste n'est pas vide
      piece.initialiseValPieceAutoGen(ValPieceAutoGen);
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

      ValPieceAutoGen.Val_Champ_Gen:='Mes pièces de réglements';
      ValPieceAutoGen:=ValAutoPieceGenere(nil);
      referenceCourante:='';
      listeFactice:=nil;
      j:=0;
     for i:=0 to ReglementSurListe.count-1 do
     begin//début boucle for ListeReglement.count
           if referenceCourante<>TEcriture_Isa(ReglementSurListe.Items[i]).piece.reference then
           begin//si la référence a changé, on enregistre celle en cours puis
           // on crée une nouvelle pièce
           if not empty(SourcePiece.Reference) then
             begin//si la pièce n'est pas vide, on l'enregistre
               //on fini de remplir la ligne de tiers avec le montant total de la piece
             DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
             TEcriture_Isa(ReglementSurListe.Items[i-1]).piece.Reference:=DMImport.Piece_Import.Reference;
               case TEcriture_Isa(ReglementSurListe.Items[i-1]).SensEcriture of
                 -1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[x])^.Ligne.Debit:=SourcePiece.TotalPiece;
                  0:abort;
                  1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[x])^.Ligne.Credit:=SourcePiece.TotalPiece;
               end;//fin du case sens
             ListeOd:=TStringList.Create;
             DMImport.Ecriture_Import.TiersEcriture:=TEcriture_Isa(ReglementSurListe.Items[i-1]).TiersEcriture;
             DMImport.Ecriture_Import.CompteEcriture:=TEcriture_Isa(ReglementSurListe.Items[i-1]).CompteEcriture;
//             DMImport.Ecriture_Import.ListeContrepartie:=TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeContrepartie;
             //AssignListeEX(TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeContrepartie,DMImport.Ecriture_Import.ListeContrepartie,VarPEcriture_A_Regler);
            // AssignListeContrepartie(TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeContrepartie,DMImport.Ecriture_Import.ListeContrepartie);
             //DMImport.Ecriture_Import.ListeEcriturePiece:=TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeEcriturePiece;
             DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);

             DMImport.EnregistrementPiece(false,nil,ListeOd,ReglementSurListe);
//             if Type_version_execution=CT_DEVELOPPEMENT then AfficheInfoComposant('',TEcriture_Isa(ReglementSurListe.Items[i-1]),true);
//             TEcriture_Isa(ReglementSurListe.Items[i-1]).piece:=DMImport.Piece_Import;
             CopieContenuPiece(DMImport.Piece_Import,TEcriture_Isa(ReglementSurListe.Items[i-1]).piece,false);
//             ReglementSurListe.Items[i-1]:=DMImport.Ecriture_Import;
             Initialise_TList(ListeTmp,ReglementSurListe2,false);
             AssignListeContrepartie(TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeContrepartie,ListeTmp);
             CopieContenuEcriture_Isa(DMImport.Ecriture_Import,ReglementSurListe.Items[i-1],false);
             AssignListeContrepartie(ListeTmp,TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeContrepartie);
             end;//fin si la pièce n'est pas vide, on l'enregistre
       DMImport.VerifCreationPieceEcriture;
           DMImport.Piece_Import.NouvellePiece(false);
           SourcePiece.IDJournal:=TEcriture_Isa(ReglementSurListe.Items[i]).piece.IDJournal;
           SourcePiece.Date:=TEcriture_Isa(ReglementSurListe.Items[i]).piece.DateSaisie;
           SourcePiece.Validation:=SourcePiece.Date;
           SourcePiece.Libelle:=TEcriture_Isa(ReglementSurListe.Items[i]).piece.Libelle;
           if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
           DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
           
           DMImport.Ecriture_Import.ListeEcriturePiece.Clear;
           DMImport.Ecriture_Import.firstidecriture:=TEcriture_Isa(ReglementSurListe.Items[i]).firstidecriture;
           if SourcePiece.IDJournal<>3 then
             begin
                SourcePiece.Compte:=TEcriture_Isa(ReglementSurListe.Items[i]).piece.Compte;
                TypeLigne:='X';
                x:=0;
             end
           else
             Begin
                //on crée une ligne vide pour remplacer la ligne de contrepartie
                DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['V'],true,false,-1);
                TypeLigne:='H';
                x:=1;
             End;
           SourcePiece.Journal:=TEcriture_Isa(ReglementSurListe.Items[i]).piece.journal;
           SourcePiece.Reference:=TEcriture_Isa(ReglementSurListe.Items[i]).piece.Reference;
           referenceCourante:=SourcePiece.Reference;
           SourcePiece.TotalPiece:=0;
           with TEcriture_Isa(ReglementSurListe.Items[i])do
             begin//début du whith
               case TEcriture_Isa(ReglementSurListe.Items[i]).SensEcriture of
                 -1:begin
                      //remplissage de la ligne de banque sans le montant total que l'on rajoutera avant l'enregistrement
                      DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,[TypeLigne,TEcriture_Isa(ReglementSurListe.Items[i]).piece.Compte,TEcriture_Isa(ReglementSurListe.Items[i]).piece.Tiers,TEcriture_Isa(ReglementSurListe.Items[i]).piece.Libelle,0,0,0,0,'','',0,'',''],true,false,-1);
                      //remplissage de la ligne de réglement
                      DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TEcriture_Isa(ReglementSurListe.Items[i]).CompteEcriture,TEcriture_Isa(ReglementSurListe.Items[i]).TiersEcriture,LibelleEcriture,0,0,TEcriture_Isa(ReglementSurListe.Items[i]).SoldeEcriture,0,'','',0,'',''],true,false,-1);
                    end;
                  0:abort;
                  1:begin
                      //remplissage de la ligne de banque sans le montant total que l'on rajoutera avant l'enregistrement
                      DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,[TypeLigne,TEcriture_Isa(ReglementSurListe.Items[i]).piece.Compte,TEcriture_Isa(ReglementSurListe.Items[i]).piece.Tiers,TEcriture_Isa(ReglementSurListe.Items[i]).piece.Libelle,0,0,0,0,'','',0,'',''],true,false,-1);
                      //remplissage de la ligne de réglement
                      DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TEcriture_Isa(ReglementSurListe.Items[i]).CompteEcriture,TEcriture_Isa(ReglementSurListe.Items[i]).TiersEcriture,LibelleEcriture,0,0,-TEcriture_Isa(ReglementSurListe.Items[i]).SoldeEcriture,0,'','',0,'',''],true,false,-1);
                    end;
               end;//fin du case sens
             end;//fin du with
           SourcePiece.TotalPiece:=SourcePiece.TotalPiece+TEcriture_Isa(ReglementSurListe.Items[i]).SoldeEcriture;
           end//fin si la référence a changé, on enregistre celle en cours puis
           // on crée une nouvelle pièce
           else
           begin//si la référence n'a pas changé, on continue à créer les lignes de réglement
             case TEcriture_Isa(ReglementSurListe.Items[i]).SensEcriture of
               -1:DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TEcriture_Isa(ReglementSurListe.Items[i]).CompteEcriture,TEcriture_Isa(ReglementSurListe.Items[i]).Tiersecriture,TEcriture_Isa(ReglementSurListe.Items[i]).LibelleEcriture,0,0,TEcriture_Isa(ReglementSurListe.Items[i]).SoldeEcriture,0,'','',0,'',''],true,false,-1);
                0:abort;
                1:DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TEcriture_Isa(ReglementSurListe.Items[i]).CompteEcriture,TEcriture_Isa(ReglementSurListe.Items[i]).TiersEcriture,TEcriture_Isa(ReglementSurListe.Items[i]).LibelleEcriture,0,0,-TEcriture_Isa(ReglementSurListe.Items[i]).SoldeEcriture,0,'','',0,'',''],true,false,-1);
             end;//fin du case sens
           SourcePiece.TotalPiece:=SourcePiece.TotalPiece+TEcriture_Isa(ReglementSurListe.Items[i]).SoldeEcriture;
           end;//fin si la référence n'a pas changé
     end;//fin de la boucle for ListeReglement.count
  if not empty(SourcePiece.Reference) then
    begin//si la pièce n'est pas vide, on l'enregistre
        //on fini de remplir la ligne de tiers avec le montant total de la piece
      DMImport.Ecriture_Import.TiersEcriture:=TEcriture_Isa(ReglementSurListe.Items[i-1]).TiersEcriture;
      DMImport.Ecriture_Import.CompteEcriture:=TEcriture_Isa(ReglementSurListe.Items[i-1]).CompteEcriture;
      //AssignListeContrepartie(TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeContrepartie,DMImport.Ecriture_Import.ListeContrepartie);
     // AssignListeEX(TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeContrepartie,DMImport.Ecriture_Import.ListeContrepartie,VarPEcriture_A_Regler);
//      DMImport.Ecriture_Import.ListeContrepartie:=TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeContrepartie;
      //DMImport.Ecriture_Import.ListeEcriturePiece:=TEcriture_Isa(ReglementSurListe.Items[i-1]).ListeEcriturePiece;
      DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
      TEcriture_Isa(ReglementSurListe.Items[i-1]).piece.Reference:=DMImport.Piece_Import.Reference;
        case TEcriture_Isa(ReglementSurListe.Items[i-1]).SensEcriture of
          -1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[x])^.Ligne.Debit:=SourcePiece.TotalPiece;
           0:abort;
           1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[x])^.Ligne.Credit:=SourcePiece.TotalPiece;
        end;//fin du case sens
      ListeOd:=TStringList.Create;
      DMImport.EnregistrementPiece(false,nil,ListeOd,ReglementSurListe);
//      if Type_version_execution=CT_DEVELOPPEMENT then AfficheInfoComposant('',TEcriture_Isa(ReglementSurListe.Items[i-1]),true);
      for i:=0 to ReglementSurListe.count-1 do
         begin
           CopieContenuPiece(DMImport.Piece_Import,TEcriture_Isa(ReglementSurListe.Items[i]).piece,false);
//           TEcriture_Isa(ReglementSurListe.Items[i]).piece:=DMImport.Piece_Import;
             Initialise_TList(ListeTmp,ReglementSurListe2,false);
             AssignListeContrepartie(TEcriture_Isa(ReglementSurListe.Items[i]).ListeContrepartie,ListeTmp);
             CopieContenuEcriture_Isa(DMImport.Ecriture_Import,ReglementSurListe.Items[i],false);
             AssignListeContrepartie(ListeTmp,TEcriture_Isa(ReglementSurListe.Items[i]).ListeContrepartie);
//           ReglementSurListe.Items[i]:=DMImport.Ecriture_Import;
         end;
    end;//fin si la pièce n'est pas vide, on l'enregistre
  End;//fin si la liste n'est pas vide
  except
    if DMImport.messageTmp then
      showmessage('Problème lors de l''enregistrement d''une pièce');
    TableGereRollBack(DMImport.TaPiece_Import);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;//fin du try except
finally
Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,ReglementSurListe2,false);
Initialise_TList(ListeTmp,ReglementSurListe2);
//if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//  Begin
//     DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//     DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//  End;
end;//fin du try finally
End;



procedure ListEcriture_A_Regler_Add_Insert(var Liste:Tlist;Valeur:array of const;Add,Remplace:boolean;Rang:integer);
var
i,rangTmp:integer;
typeligne:Char;
retourboolean:TRetourBool;
RetourTranstypage:TTypeTranstypage;
Ecriture_A_Regler:PEcriture_A_Regler;
Begin
if Liste=nil then Liste:=TList.Create;
new(Ecriture_A_Regler);
   for i:=0 to high(valeur)do
   begin//Début boucle
   RetourTranstypage:=VTypeTranstypage(valeur[i],valeur[i].vtype);
       if  RetourTranstypage.retour then
       begin //si RetourTranstypage.retour=true
           case i mod 6 of
           0:Ecriture_A_Regler^.ID_Ecriture:=StrToInt_Lgr(RetourTranstypage.valeur);
           1:Ecriture_A_Regler^.Tiers_:=RetourTranstypage.valeur;
           2:Ecriture_A_Regler^.Montant:=StrToCurr_Lgr(RetourTranstypage.valeur);
           3:Ecriture_A_Regler^.Sens:=StrToInt_Lgr(RetourTranstypage.valeur);
           4:Ecriture_A_Regler^.CompteReglement:=RetourTranstypage.valeur;
           5:begin
              retourboolean:=strtobool(RetourTranstypage.valeur);
              if retourboolean.retour then
              Ecriture_A_Regler^.TvaSurE:=retourboolean.valeur;
              end;
          end;//fin du case
       end;// fin si RetourTranstypage.retour=true
   end;//fin de boucle

   if Add then
     Liste.Add(Ecriture_A_Regler)
   else
   if ((rang<>-1)and(remplace)) then
     Begin
     Liste.delete(rang);
     Liste.Insert(rang,Ecriture_A_Regler)
     End
     else
       if ((rang<>-1)and(not remplace)) then
       begin
       Liste.Insert(rang,Ecriture_A_Regler);
       end;
End;


procedure AffichageListeReglement(ListeReglement:TList;Var Grille:TGrGrid);
var
i,j,rangGrille:integer;
//objetreglement:Treglement_Liste;
ReferenceCourante:string;
Begin
if (ReglementSurListe2 = nil) then ReglementSurListe2:=TReglementSurListe2.Create(Application.MainForm);
  try
    if ListeReglement<>nil then
      Begin
        case TEcriture_Isa(ListeReglement.Items[0]).SensEcriture of
        -1:GrGridInitColonne(Grille,['Référence','Compte','Date','Libellé','Décaissement'],[grtous,grtous,grcompte,grdate,grtous,grcurr],[True,true,True,True,false,true],E.FormatMonnaie,E.EditFormat);
         1:GrGridInitColonne(Grille,['Référence','Compte','Date','Libellé','Encaissement'],[grtous,grtous,grcompte,grdate,grtous,grcurr],[True,true,True,True,false,true],E.FormatMonnaie,E.EditFormat);
        end;//fin du case
        FormateTailleColonne_GrGrid(Grille,14,[2,2,2,4,2]);
        j:=Grille.Fixedcols;
        i:=0 ;
        rangGrille:=Grille.FixedRows;
        if ListeReglement.Count>0 then
        begin //si liste réglement remplie
          while i<=ListeReglement.Count-1 do
            Begin
               if Grille.RowCount-1<rangGrille then
                 grille.AjouteLigne;
               //if ((ReferenceCourante<>TEcriture_Isa(ListeReglement.Items[i]).piece.Reference)and(i>0)) then
               if ReferenceCourante<>TEcriture_Isa(ListeReglement.Items[i]).piece.Reference then
                 Begin
                   Grille.Cells[j,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i]).piece.Reference;
                   Grille.Cells[j+1,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i]).piece.Compte;
                   Grille.Cells[j+2,rangGrille]:=datetostr(TEcriture_Isa(ListeReglement.Items[i]).piece.DateSaisie);
                   Grille.Cells[j+3,rangGrille]:='Total de la pièce :';
                   Grille.Cells[j+4,rangGrille]:=FormatFloat(E.FormatMonnaie + ';; ',TEcriture_Isa(ListeReglement.Items[i]).piece.Montant);

                   grille.Objects[0,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i]).Piece;
                   ReferenceCourante:=TEcriture_Isa(ListeReglement.Items[i]).piece.Reference;
                   //dec(i);
                 End
               else
                 Begin
                   if empty(TEcriture_Isa(ListeReglement.Items[i]).TiersEcriture) then
                     Grille.Cells[j+1,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i]).CompteEcriture
                   else
                     Grille.Cells[j+1,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i]).TiersEcriture;
                //   Grille.Cells[j+2,rangGrille]:=datetostr(TEcriture_Isa(ListeReglement.Items[i]).DateEcriture);
                   Grille.Cells[j+3,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i]).LibelleEcriture;
                   Grille.Cells[j+4,rangGrille]:=FormatFloat(E.FormatMonnaie + ';; ',TEcriture_Isa(ListeReglement.Items[i]).SoldeEcriture);

                   grille.Objects[0,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i]);
                 ReferenceCourante:=TEcriture_Isa(ListeReglement.Items[i]).piece.Reference;
                 inc(i);
                 End;
               //ReferenceCourante:=TEcriture_Isa(ListeReglement.Items[i]).piece.Reference;
            inc(rangGrille);
            End;//fin du while
//               if not empty(TEcriture_Isa(ListeReglement.Items[i-1]).piece.Reference) then
//                 grille.AjouteLigne;
//                 Grille.Cells[j,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i-1]).piece.Reference;
//                 Grille.Cells[j+1,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i-1]).piece.Compte;
//                 Grille.Cells[j+2,rangGrille]:=datetostr(TEcriture_Isa(ListeReglement.Items[i-1]).piece.DateSaisie);
//                 Grille.Cells[j+3,rangGrille]:='Total de la pièce :';
//                 Grille.Cells[j+4,rangGrille]:=FormatFloat(E.FormatMonnaie + ';; ',TEcriture_Isa(ListeReglement.Items[i-1]).piece.Montant);
//
//                 grille.Objects[0,rangGrille]:=TEcriture_Isa(ListeReglement.Items[i-1]).Piece;
        end;//fin si liste réglement remplie
      End;
  except
     abort;
  end;//fin du try except
End;



procedure TReglementSurListe2.GrGrid1ColExit(OldColonne, LastRow: Integer);
var
valide:TErreurSaisie;
begin
valide.retour:=true;
valide.CodeErreur:=0;
if GrGrid1.EtatGrille = dsedit then
  valide:=CtrlSaisieReglementSurListe(grgrid1);
if not valide.retour then
  abort;
end;


function TReglementSurListe2.CtrlSaisieReglementSurListe(Grille:TGrGrid):TErreurSaisie;
var
i,rang:integer;
infosModel:TInfosModel;
infosVerrouillage:TVerrouillage;
Begin
result.CodeErreur:=0;
result.retour:=true;
if GrGrid1.Objects[0,Grille.row].ClassType=tpiece then
  Begin //si on est sur la ligne de la pièce
    case Grille.Col of
          2:begin//si colonne compteReglement
            if tpiece(GrGrid1.Objects[0,Grille.row]).Compte<>Grille.InplaceEditor.Text then
              begin//si le compte a changé
                if AideModelCompteJournalBanque(Grille.InplaceEditor.Text) then
                   Begin//si le compte fait partie d'un journal
                    if not AideModelAfficheJournauxBanque(Grille.InplaceEditor,False) then
                      Begin//si le compte ne fait pas partie d'un journal de banque
                      result.retour:=false;
                      result.CodeErreur:=1001;
                      End;//fin si le compte ne fait pas partie d'un journal de banque
                   End//fin si le compte fait partie d'un journal
                else
                   Begin //sinon, verifier si le compte fait partie du contexte
                     //DMPlan.FiltrageAideCompte(101,nil,nil);
                     AideCompte.FiltrageAideCompte(101);
                     result.retour:=AideCompteDansContexte(Grille.InplaceEditor.Text,Grille,['rac1'],false,MessDerSub,true,true,true,true,2);
                     if not result.retour then
                       result.CodeErreur:=1002;
                   End;//fin sinon, verifier si le compte fait partie du contexte
                if result.retour then
                  Begin//si le compte est ok
                    Grille.InplaceEditor.Text:=Grille.Cells[Grille.Col,Grille.row];
                    Tpiece(Grille.Objects[0,Grille.row]).Compte:=Grille.InplaceEditor.Text;
                    //récupérer la nouvelle référence si nécessaire
                    infosModel:=Infos_TInfosModel(dmrech.TaModelRech,'Compte',[Tpiece(Grille.Objects[0,Grille.row]).Compte]);
                    if ((infosModel.Journal<>Tpiece(GrGrid1.Objects[0,Grille.row]).Journal)and(empty(infosModel.Journal))) then
                      Begin //si le journal a changé, on crée la nouvelle référence
                         infosModel.Journal:='OD';
                         infosModel.ID:=3;
                      end;//fin si le journal a changé, on crée la nouvelle référence
                    Tpiece(Grille.Objects[0,Grille.row]).Journal:=infosModel.Journal;
                    Tpiece(Grille.Objects[0,Grille.row]).IDJournal:=infosModel.ID;
                    rang:=ListeReference.IndexOf(Tpiece(Grille.Objects[0,Grille.row]).Reference);
                    if rang<>-1 then
                      ListeReference.Delete(rang);
                    Tpiece(Grille.Objects[0,Grille.row]).Reference:=gestionDerniereReference(infosModel.Journal,Tpiece(Grille.Objects[0,Grille.row]),ListeReference);
                    if ListeReference.IndexOf(Tpiece(Grille.Objects[0,Grille.row]).Reference)=-1 then
                      ListeReference.add(Tpiece(Grille.Objects[0,Grille.row]).Reference);
                    Grille.Cells[1,Grille.row]:=Tpiece(Grille.Objects[0,Grille.row]).Reference;
                  End;//fin si le compte est ok
              end;//fin si le compte a changé
            end;//fin si colonne compteReglement
          3:begin//si colonne DateReglement
              if datetostr(tpiece(GrGrid1.Objects[0,Grille.row]).DateSaisie)<>Grille.InplaceEditor.Text then
                begin //si la date a changé
                  Grille.InplaceEditor.Text:=AnneeDefaut(E.DatExoDebut,E.DatExoFin,Grille.InplaceEditor.Text).DateStr;
                    if not VerifNumeric(Grille.InplaceEditor.Text).VideOUZero then
                      Begin //si la date est remplie
                        if not (DMImport.Piece_Import.VerifDateSaisie(StrToDate_Lgr(Grille.InplaceEditor.Text)))then
                          Begin //si référence pas correct
                          Application.MessageBox(Pchar('La date doit faire partie de l''exercice en cours !!!'),'Erreur de saisie',0);
                          result.CodeErreur:=4002;
                          result.retour:=false;
                          End; //fin si compte pas correct
                        //récupérer infosverrouillage
                        if Tpiece(Grille.Objects[0,Grille.row]).TypeTvaE then
                          begin
                          infosVerrouillage:=DMImport.Piece_Import.RetourneInfosVerrouillageSurPiece(nil,0,StrToDate_Lgr(Grille.InplaceEditor.Text));
                          if infosVerrouillage.PeriodeVerrouillee then
                            begin//si periode verrouillée
                            if infosVerrouillage.PeriodeDeverrouillable then
                              Begin//si deverrouillable
                                if Application.MessageBox(PChar('Cette date fait partie d''une période de TVA déclarée. Si vous la conservez, la dernière déclaration Tva sera supprimer. Voulez-vous continuer ?'),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
                                   Begin//si
                                     //supprimer la dernière od de déclaration tva
                                     DMImport.Piece_Import.SuppDerniereDeclTva:=true;
                                   End//fin si
                                else
                                   begin
                                     result.CodeErreur:=4001;
                                     result.retour:=false;
                                   end;
                              End//fin si deverrouillable
                            else
                              Begin//si non deverrouillable
                                Application.MessageBox(Pchar('Cette date fait partie d''une période de TVA déclarée non déverrouillable !!!'),'Erreur de saisie',0);
                                result.CodeErreur:=4001;
                                result.retour:=false;
                              End;//fin si non deverrouillable
                            end;//fin si periode verrouillée
                          end;
                      End //fin si la date est remplie
                    else
                      Begin //si pas remplie
                      // remplir par défaut avec date de la pièce appelante
                      Grille.InplaceEditor.Text:=datetostr(now);
                      End; //fin si pas remplie
                 if result.retour then
                 Begin
                 Grille.Cells[Grille.Col,Grille.row]:=Grille.InplaceEditor.Text;
                 Tpiece(GrGrid1.Objects[0,Grille.row]).DateSaisie:=StrToDate_Lgr(Grille.InplaceEditor.Text);
                 End;
                end;//fin si la date a changé
            end;//fin si colonne DateReglement
          4:begin//si colonne Libelle
              if tpiece(GrGrid1.Objects[0,Grille.row]).Libelle<>Grille.InplaceEditor.Text then
                begin//si libellé a changé
                  if empty(Grille.InplaceEditor.Text)then
                    Begin
                      Grille.InplaceEditor.Text:=tpiece(GrGrid1.Objects[0,Grille.row]).Libelle;
                    End
                  else
                     if Grille.InplaceEditor.Text='*' then
                       Begin//si *
                         if copy(Grille.Cells[2,Grille.row],1,1)='+' then
                         Grille.InplaceEditor.Text:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[Grille.Cells[2,Grille.row]]).Nom
                       else
                         Grille.InplaceEditor.Text:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[Grille.Cells[2,Grille.row]]).Libelle;
                       end;//fin si *
                  Grille.Cells[Grille.Col,Grille.row]:=Grille.InplaceEditor.Text;
                  tpiece(GrGrid1.Objects[0,Grille.row]).Libelle:=Grille.InplaceEditor.Text;
                end;//fin si libellé a changé
            end;//fin si colonne Libelle
          end;//fin du case Acol
  End//fin si on est sur la ligne de la pièce
else
  if GrGrid1.Objects[0,Grille.row].ClassType=TEcriture_Isa then
    Begin// si on est sur une ligne de réglement
      case Grille.Col of
      3:begin//si colonne DateReglement
          if datetostr(TEcriture_Isa(GrGrid1.Objects[0,Grille.row]).DateEcriture)<>Grille.InplaceEditor.Text then
            begin//si la date a changé
              Grille.InplaceEditor.Text:=AnneeDefaut(E.DatExoDebut,E.DatExoFin,Grille.InplaceEditor.Text).DateStr;
                if not VerifNumeric(Grille.InplaceEditor.Text).VideOUZero then
                  Begin //si la date est remplie
                    if not (DMImport.Piece_Import.VerifDateSaisie(StrToDate_Lgr(Grille.InplaceEditor.Text)))then
                      Begin //si référence pas correct
                      Application.MessageBox(Pchar('La date doit faire partie de l''exercice en cours !!!'),'Erreur de saisie',0);
                      result.CodeErreur:=4002;
                      result.retour:=false;
                      End; //fin si compte pas correct
                  End //fin si la date est remplie
                else
                  Begin //si pas remplie
                  // remplir par défaut avec date de la pièce appelante
                  Grille.InplaceEditor.Text:=datetostr(now);
                  End; //fin si pas remplie
              if result.retour then
                begin
                Grille.Cells[Grille.Col,Grille.row]:=Grille.InplaceEditor.Text;
                TEcriture_Isa(GrGrid1.Objects[0,Grille.row]).DateEcriture:=StrToDate_Lgr(Grille.InplaceEditor.Text);
                end;
            end;//fin si la date a changé
        end;//fin si colonne DateReglement
      4:begin//si colonne Libelle
         if TEcriture_Isa(GrGrid1.Objects[0,Grille.row]).LibelleEcriture<>Grille.InplaceEditor.Text then
           begin //si libellé a changé
               if empty(Grille.InplaceEditor.Text)then
                 Begin
                   Grille.InplaceEditor.Text:=TEcriture_Isa(GrGrid1.Objects[0,Grille.row]).LibelleEcriture;
                 End
               else
                  if Grille.InplaceEditor.Text='*' then
                    Begin//si *
                      if copy(Grille.Cells[2,Grille.row],1,1)='+' then
                      Grille.InplaceEditor.Text:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[Grille.Cells[2,Grille.row]]).Nom
                    else
                      Grille.InplaceEditor.Text:=Infos_TInfosplancpt(DMrech.TaPlanCptRech,'Compte',[Grille.Cells[2,Grille.row]]).Libelle;
                    end;//fin si *
               Grille.Cells[Grille.Col,Grille.row]:=Grille.InplaceEditor.Text;
               TEcriture_Isa(GrGrid1.Objects[0,Grille.row]).LibelleEcriture:=Grille.InplaceEditor.Text;
           End;//sin si libellé a changé
        end;//fin si colonne Libelle
      end;//fin du case Acol
    End;//fin si on est sur une ligne de réglement
end;

procedure TReglementSurListe2.GrGrid1DrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
var
  holdColor: TColor;
begin
//if grgrid1.Objects[0,row]is Tpiece then
// begin
//      grgrid1.Canvas.Brush.Color :=$00B6FDB0;//$00808040;
//      grgrid1.Canvas.FillRect(rect);
// end
// else
// if grgrid1.Objects[0,row]is TEcriture_Isa then
// begin
//      grgrid1.Canvas.Brush.Color :=$00E4CAFF;//$005959FF;//$00808040;
//      grgrid1.Canvas.FillRect(rect);
// end;

end;

procedure TReglementSurListe2.GrGrid1RowEnter(sender: TObject;
  NewRow: Integer);
begin
if GrGrid1.Objects[0,newrow].Classtype=tpiece then
  Begin //si on est sur la ligne de la pièce
     grgrid1.Champ_Readonly.bits[2]:=false;
     grgrid1.Champ_Readonly.bits[3]:=false;
     grgrid1.Champ_Readonly.bits[4]:=true;
  End//fin si on est sur la ligne de la pièce
else
  if GrGrid1.Objects[0,newrow].Classtype=TEcriture_Isa then
    Begin// si on est sur une ligne de réglement
     grgrid1.Champ_Readonly.bits[2]:=true;
     grgrid1.Champ_Readonly.bits[3]:=true;
     grgrid1.Champ_Readonly.bits[4]:=false;
    End;//fin si on est sur une ligne de réglement
end;

procedure TReglementSurListe2.GrGrid1RowValidate(Sender: TObject;
  var Valide, Action: Boolean; LastCol: Integer);
var
retourCtrl:TErreurSaisie;
begin
retourCtrl.retour:=true;
retourCtrl.CodeErreur:=0;
retourCtrl:=CtrlSaisieReglementSurListe(grgrid1);
if not retourCtrl.retour then
  abort;
end;

procedure TReglementSurListe2.BtnEnregistrerClick(Sender: TObject);
var
action,valide:boolean;
begin
ModalResult:=mrOk;
  try
    valide:=true;
    action:=true;
    GrGrid1RowValidate(grgrid1,valide,action,grgrid1.col);
    if not valide then
      begin
      ModalResult:=mrnone;
      abort;
      end;
  except
    abort;
  end;
end;

procedure TReglementSurListe2.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ModalResult:=mrcancel;
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TReglementSurListe2.BtnSupprimerClick(Sender: TObject);
begin
   try
//     if not GrGrid1.LigneVide(grgrid1.row) then
//       GrGrid1.SupprimeLigne(grgrid1.Row);
   except
      abort;
   end;
end;

procedure TReglementSurListe2.BtnFermerClick(Sender: TObject);
begin
ModalResult:=mrcancel;
Self.Close;
end;

procedure TReglementSurListe2.BtnImprimerClick(Sender: TObject);
begin
//if (FPrint = nil) then FPrint:=TFPrint.Create(self);
//FPrint.SelectionEtat := ;
//FPrint.show;

end;

procedure TReglementSurListe2.GrGrid1BeforeSupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
begin
  try
    if GrGrid1.Objects[0,GrGrid1.row].ClassType= tpiece then
      Begin
         if Application.MessageBox(Pchar('Voulez-vous réellement supprimer cette pièce !'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
           Begin
             if GrGrid1.Objects[0,grgrid1.row]<>nil then
             begin//si l'objet lié existe
                 tpiece(GrGrid1.Objects[0,grgrid1.row]).SuppressionObjetPiece(tpiece(GrGrid1.Objects[0,grgrid1.row]));
             end;//fin si l'objet lié existe
           end
         else
           abort;
      End
    else
      if GrGrid1.Objects[0,GrGrid1.row].ClassType= TEcriture_Isa then
      Begin
         if Application.MessageBox(Pchar('Voulez-vous réellement supprimer cette ligne !'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
           Begin
              TEcriture_Isa(GrGrid1.Objects[0,GrGrid1.row]).Free;
              GrGrid1.Objects[0,GrGrid1.row]:=nil;
           End
         else
             abort;
      End;
  except
    abort;
  end;
end;

procedure TReglementSurListe2.GrGrid1SupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
var
i,Nb:integer;
begin
//recalculer le total de la pièce
//si égale à 0, supprimer la pièce entière
GrGrid1.OnSupprLigne:=nil;
GrGrid1.OnBeforeSupprLigne:=nil;
if GrGrid1.Objects[0,GrGrid1.row].ClassType= TEcriture_Isa then
  Begin //si objet lié TEcriture_Isa
    if tpiece(GrGrid1.Objects[0,grgrid1.row]).CalculsoldePiece(tpiece(GrGrid1.Objects[0,grgrid1.row])).SensSolde=0 then
      Begin
        tpiece(GrGrid1.Objects[0,grgrid1.row]).SuppressionObjetPiece(tpiece(GrGrid1.Objects[0,grgrid1.row]));
      End;
  end;//fin si objet lié TEcriture_Isa
Nb:=grgrid1.RowCount-1;
i:=GrGrid1.FixedRows;
while i<= Nb do
  Begin
      if ((GrGrid1.Objects[0,i].ClassType = tpiece)or(GrGrid1.Objects[0,i].ClassType = TEcriture_Isa))  then
      else
        grgrid1.SupprimeLigne(i);
  inc(i);      
  End;
GrGrid1.OnSupprLigne:=GrGrid1SupprLigne;
GrGrid1.OnBeforeSupprLigne:=GrGrid1BeforeSupprLigne;
end;



function Ecriture_A_Regler(IDEcriture:integer):TEcriture_A_Regler;
var
infosDettesCreances:TInfosResteDC;
IDPiece:integer;
begin
  try
    initialise_TEcriture_A_Regler(result);
    infosDettesCreances:=Infos_TInfosResteDC(dmrech.TaResteDCRech,'ID_Ecriture',[IDEcriture]);
    result.ID_Ecriture:=IDEcriture;
    if infosDettesCreances.Reste<=0 then
      abort;
    result.Montant:=infosDettesCreances.Reste;
    if infosDettesCreances.Sens='D' then
    result.Sens:=-1
    else
    if infosDettesCreances.Sens='C' then
    result.Sens:=1;
    result.Tiers_:=infosDettesCreances.Tiers;
    //result.CompteReglement:='';

    FiltrageDataSet(DMRech.TaEcritureRech,'TvaType=''E'' and id_Piece = '+inttostr(infosDettesCreances.ID_Piece));
    if DMRech.TaEcritureRech.recordcount>0 then
      result.TvaSurE:=IDEcriture<>DMRech.TaEcritureRech.FindField('ID').asinteger;
    DeFiltrageDataSet(DMRech.TaEcritureRech);  
  except
    abort;
  end;
end;
end.
