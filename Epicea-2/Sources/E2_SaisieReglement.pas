{***************************************************************
 *
 * Unit Name: E2_SaisieRegnmt
 * Purpose  :
 * Author   :  JS
 * History  :
 *
 ****************************************************************}

// Gestion de l'écran de saisie des règlements pour un achat-vente
// tout est commenté
unit E2_SaisieReglement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Gr_Librairie_Obj, Buttons, ComCtrls, Grids, ExtCtrls,  GrGrid,
  Lib1,
  ObjReglement,
  Db,
  DBTables,
  Piece,
  DMPiece,
  LibSql,
  PickDate,
  LibRessourceString,
  RXCtrls,
  registry,
  E2_Recherche,
  LibZoneSaisie,
  E2_Decl_Records,
  LibDates,
  DMJournaux,
  DBGrids,
  DMImportation,
  referencement,
  DMConstantes,
  ecriture_isa,
  LibGestionParamXML,
  lib_chaine,
  Variants,
  jpeg,E2_LibInfosTable;


type
  TParamAfficheSaisieReglement = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   Quand:Integer;
   TitreForm:String;
   SousTitreForm:String;
   end;


  TSaisieReglements = class(TForm)
    paGrille: TPanel;
    hcCompte: THeaderControl;
    Patitre: TPanel;
    PaButtons: TPanel;
    ObjReglement1: TObjReglement;
    PopupMenuReglement: TPopupMenu;
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
    grReglement: TGrGrid;
    PaBtnHaut: TPanel;
    SBReglement: TRxSpeedButton;
    SBAutres: TRxSpeedButton;
    PaBtnBas: TPanel;
    SBAucun: TRxSpeedButton;
    SBPointables: TRxSpeedButton;
    SBDejaPointes: TRxSpeedButton;
    PaLibelle: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure grReglementEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EtatInitial;
    function CtrlSaisiePieceReglement(edit:TCustomEdit;Acol,CelluleSuivante:integer):TErreurSaisie;
    function CtrlSaisiePieceReglementPourPointageDirect(edit:TCustomEdit;Acol,CelluleSuivante:integer):TErreurSaisie;
    procedure FormActivate(Sender: TObject);
    procedure GestionFiltrageParamCpt;
    procedure AffichagePieceReglementExistante(Ligne:integer;Reference:string;InfoResteDCSurCompte:TInfoResteDCSurCompte);
    //function RecupInfosPointageSurRef(Reference,tiers:string;sens:boolean;FiltrerReste:boolean):TPointage;
    procedure GrReglementColExit(OldColonne,LastRow: Integer);
    procedure GrReglementRowValidate(Sender: TObject; var Valide,
      Action: Boolean; LastCol: Integer);
    procedure GrReglementSupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    Procedure AfficheLigneBas(Row :Integer;Calcul:boolean);
    procedure GrReglementColEnter(OldColonne, NewColonne,NewRow: Integer);
    function  CalculResteARegler(Infos:TPointage;MontantPiece:currency):currency;
    procedure PrepaAffichageSurOption(Option:integer;InitGrille:boolean);
    procedure SBAucunClick(Sender: TObject);
    procedure GrReglementBeforeColExit(NewColonne: Integer);
    procedure GrReglementKeyPress(Sender: TObject; var Key: Char);
    procedure GrReglementBeforeNewLigne(sender: TObject; Arow: Integer);
    procedure Annuler1Click(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Aideenligne1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure GrReglementBeforeSupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    procedure paGrilleResize(Sender: TObject);
    procedure GrReglementRowEnter(sender: TObject; NewRow: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function RecupOptionSurClickButton:integer;
    function ListReglementIndexOf(valeur:string;valeurRech:integer):integer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    Procedure InitPaLibelle;
    procedure FormShow(Sender: TObject);
    procedure grReglementKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); //PB
    function CalculTotalColonneImputation:currency;
    function CalculResteInitial:currency;
    procedure grReglementChange(Sender: TObject);
    procedure grReglementSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure grReglementStateChange(EtatGrille: TDataSetState);
//    procedure EnregistrementReglement(fenetreAppelante:TComponent;var ListePointage:Tstringlist);

  private
    { Déclarations privées }


  public
    { Déclarations publiques }
    ListeReglement:TStringList;
    listeNewReference:TStringList;
    ResteARegler:currency;

ListeReglementPointable:TStringList;
EtatGrille:TDataSetState;
LastLibEcriture:string;
RefSupp:string;
Option:integer;
MessDerSub:boolean;
DerniereRef:string;
ligneCurr:integer;
lignecourante:string;
boutonEnabled:boolean;
ModifReglement:boolean;

end;

var
SaisieReglements:TSaisieReglements;
DernierCompteSaisi:string;
//

procedure ListReglementAdd_Insert(Valeur:array of const;Add:boolean;Rang:integer;var Liste:Tstringlist);
procedure VisuListeShowMessage(Liste:Tstringlist;indexRang:integer;const indexChamp:array of integer);
Function SaisieReglementAffiche(ParamAfficheSaisieReglement:TParamAfficheSaisieReglement):boolean;

implementation
{$R *.DFM}
Uses E2_Librairie_obj,
  //Gr_Calculatrice,
  E2_AideCompte, E2_AideModel, E2_Main,
	{Gr_AideDate , E2_AideLibelle,E2_SaisieP,}E2_SaisieP_3, DMEcriture,
         DMPlanCpt, DMPointages2, DMRecherche, DMTTVA, E2_DetailEcr;

const
	CColWidths :Array[1..8] of Integer = (65,81,65,220,81,0,65,65);

//******************************************************************************



//******************************************************************************
procedure TSaisieReglements.Calculatrice1Click(Sender: TObject);

begin
	AfficheCalculatrice(nil);
end;

//******************************************************************************
procedure TSaisieReglements.Fermer1Click(Sender: TObject);
begin
 Self.Close;
end;

//******************************************************************************
procedure TSaisieReglements.FormCreate(Sender: TObject);
// Initialisation de la grille et de l'écran
Var
Registre :TRegistry;
i :Integer;
begin
    try
        if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(self); 
  	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
	//Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
//parametres grille
//SaisieReglements.ModalResult:=mrnone;
MessDerSub:=true;

//ObjReglement1.Piece:=saisieP.Piece1;
grReglement.AjoutAuto:=true;
grReglement.ColCount:=9;
grReglement.Align:=alClient;
//grReglement.Options:=[goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,goEditing, goTabs,goAlwaysShowEditor];
grReglement.Options:=[goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,goEditing, goTabs,goDrawFocusSelected];
grReglement.PopupMenu:=PopupMenuReglement;
grReglement.RowCount:=2;
grReglement.NumDecimal:=2;
grReglement.Champ.Add(Grtous);
grReglement.Champ.Add(Grcompte);
grReglement.Champ.Add(Grtous);
grReglement.Champ.Add(Grdate);
grReglement.Champ.Add(Grtous);
grReglement.Champ.Add(Grcurr);
grReglement.Champ.Add(Grcurr);
grReglement.Champ.Add(Grcurr);
grReglement.Champ.Add(Grcurr);
grReglement.FFormatMonnaie:=E.FormatMonnaie;
for i:=1 to GrReglement.ColCount-1 do
Begin
GrReglement.ColWidths[i]:=CColWidths[i]
End;

// parametres divers
ListeReglement:=TstringList.Create;
listeNewReference:=TstringList.Create;
ListeReglementPointable:=TstringList.Create;

Registre:= TRegistry.Create;
   try
      with Registre do
      begin
         RootKey := HKEY_LOCAL_MACHINE;

    OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, false);
       try

       ///****Pour les besoins de DENIS (Cogerer), on se position par défaut sur nouveau
       //***réglement, sinon on a la possibilité de récupérer la dernière position
//         SBReglement.Down:=ReadBool('SBReglement');
//         SBAutres.Down:=ReadBool('SBAutres');
//         SBPointables.down:=ReadBool('SBPointables');
//         SBDejaPointes.down:=ReadBool('SBDejaPointes');
//         SBAucun.down:=ReadBool('SBAucun');
         SBDejaPointes.down:=false;
         SBPointables.down:=false;
         SBAucun.down:=true;
         SBReglement.Down:=true;
         SBAutres.Down:=false;
       except
         SBDejaPointes.down:=false;
         SBPointables.down:=false;
         SBAucun.down:=true;
         SBReglement.Down:=true;
         SBAutres.Down:=false;
       end;
    end;
   finally
	Registre.Free;
   end;

option:=RecupOptionSurClickButton;

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
end;

//******************************************************************************
procedure TSaisieReglements.FormDestroy(Sender: TObject);
Var
Registre :TRegistry;
i:integer;
begin
   Registre:= TRegistry.Create;
   try
      with Registre do begin
         RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + E.User+ '\' + self.Name, True);
         WriteBool('SBReglement',SBReglement.down);
         WriteBool('SBAutres',SBAutres.down);
         WriteBool('SBAucun',SBAucun.down);
         WriteBool('SBPointables',SBPointables.down);
         WriteBool('SBDejaPointes',SBDejaPointes.down);
         CloseKey;
      end;
   finally
      Registre.Free;
   end;
   Initialise_TStringlist(ListeReglementPointable,self);
   Initialise_TStringlist(ListeReglement,self);
   Initialise_TStringlist(listeNewReference,self);
   LibGestionParamXML.DestroyForm(Self,E.USer);
   SaisieReglements:=nil;
end;

//******************************************************************************
procedure TSaisieReglements.pmMenu1Click(Sender: TObject);
begin

	PopupMenuReglement.Popup(Left + 50, Top + 50);
end;




//******************* TSaisieReglement.Aide1Click ******************************
procedure TSaisieReglements.Aide1Click(Sender: TObject);
// GEstion du F1
var
i:integer;
RefSelect:string;
trouve:boolean;
Date:TDateTime;
begin
try
   case grReglement.Col of
      1:begin//si colonne compte
        //filtrer aidecompte suivant les paramètres nécessaire
//        AideCompte.FiltrageAideCompte(101);
        GestionFiltrageParamCpt;
        //les comptes doivent être filtrés en fonction des comptes pointables
        AideCompteDansContexte(GrReglement.Cells[1,ligneCurr],GrReglement,['rac1'],true,MessDerSub,false,true,true,true,0);
        if not empty(GrReglement.Cells[1,ligneCurr])then
          GrReglement.EtatGrille:=dsedit;
        end;//fin si colonne compte
//      2:begin//si colonne Référence
//        //Récupérer la listes des réglements pointables et,ou pointés avec la pièce appelante
//        //suivant l'option d'affichage choisie
//        GrReglement.OnColExit:=nil;
//        GrReglement.OnColEnter:=nil;
//        PrepaAffichageSurOption(option,false);
//        //filtrer TaPieceReglTmp en fonction de la liste de références récupérées
//        with ObjReglement1 do
//           begin //début du with ObjReglement1
//           if TaPieceReglTmp.Active=false then
//           TaPieceReglTmp.open;
//           TaPieceReglTmp.Filtered:=false;
//           TaPieceReglTmp.Filter:=CreeFiltreOU('Reference',[ListeReglementPointable]);
//           TaPieceReglTmp.Filtered:=true;
//
//           Rechercher(GrReglement,TaPieceReglTmp,['Reference','Compte','Libelle'],['Références','Compte','Libellé'],'',0);
//           trouve:=false;
//           RefSelect:='';
//           RefSelect:=TaPieceReglTmp.FindField('Reference').asstring;
//             if not empty(RefSelect)then
//               i:=GrReglement.Cols[2].IndexOf(RefSelect);
////              for i:=0 to GrReglement.RowCount-1 do
////              Begin
//                 if i<>-1 then
//                   trouve:=true;
////              End;
//
//           end;//fin du with ObjReglement1
//           if trouve then
//           GrReglement.row:=i
//           else
//              Begin
//              if ((not empty(GrReglement.Cells[2,LigneCurr]))and (not empty(GrReglement.Cells[5,LigneCurr]))and (GrReglement.Cells[5,LigneCurr]<>'0'))then
//              GrReglement.GenereLigne(false,GrReglement.rowcount,1);
//              GrReglement.Cells[2,LigneCurr]:=RefSelect;
//              CtrlSaisiePieceReglement(grReglement.InplaceEditor,2,2);
//              End;
//        GrReglement.OnColExit:=GrReglementColExit;
//        GrReglement.OnColEnter:=GrReglementColEnter;
//        end;//fin si colonne Référence
      3:begin//si colonne Date
          if (ListeReglement.Objects[ligneCurr]as TReglementList).CompteModifiable then
          begin//si pièce modifiable
             if not verifnumeric(grreglement.cells[3,lignecurr]).videouZero then
               Date:=StrToDate_Lgr(grreglement.cells[3,lignecurr])
             else
               Date:=now;
             if grReglement.InplaceEditor<>nil then
               begin
               if grReglement.InplaceEditor.visible then
                 begin
                  if not VerifNumeric(grReglement.InplaceEditor.Text).VideOUZero then
                    Date:=StrToDate_Lgr(grReglement.InplaceEditor.Text);
                  if PopupDate(Date,grReglement.InplaceEditor) then
                    grReglement.InplaceEditor.Text:=datetostr(Date);
                 end
               else
                if PopupDate(Date,grReglement) then
                  grReglement.cells[3,lignecurr]:=datetostr(Date);
               end
             else
                if PopupDate(Date,grReglement) then
                  grReglement.cells[3,lignecurr]:=datetostr(Date);
             grReglement.EtatGrille:=dsedit;
          end;//fin si pièce modifiable
        end; //fin si colonne Date
      4:begin //si colonne Libelle
//        AideLibelleAffiche(grReglement, grReglement.Cells[1,LigneCurr]);
        end; //fin si colonne Libelle
      5://si colonne Montant
        AfficheCalculatrice(grReglement);
      6:begin //si colonne Autres pointages
        //afficher les pièces pointées avec le réglement

        end; //fin si colonne Autres pointages
   end;//fin du case col de la grille
finally
if ObjReglement1.TaPieceReglTmp<>nil then
ObjReglement1.TaPieceReglTmp.close;
end;//fin du try finally
end;

//******************* TSaisieReglement.AfficheLigneBas *************************
Procedure TSaisieReglements.AfficheLigneBas(Row :Integer;Calcul:boolean);
// Affiche les totaux de bas page
Begin

   hcCompte.Sections[0].Text:= 'Réglé par : ' +grReglement.Cells[1,Row]+'   '+ DMPlan.LibelleDuNumCptPCU(grReglement.Cells[1,Row]);

   if Calcul then
   begin
   ResteARegler:=0;
   with ObjReglement1.Piece do
   ResteARegler:=CalculResteARegler(InfosPointage,MontantPourReglement);
   end;

     hcCompte.Sections[1].Text:= SaisieReglementhcCompteLibelleCompte + Format('%13.2n', [ResteARegler])

End;

//******************************************************************************
procedure TSaisieReglements.grReglementEnter(Sender: TObject);
begin

	AfficheLigneBas(1,true);
        //GrReglement.setfocus;
        GrReglementRowEnter(GrReglement,1);
    //    GrReglement.col:=1;
     //   GrReglement.NewColonne:=1;
end;


//******************************************************************************
procedure TSaisieReglements.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
// A voir
begin

	if (Key=VK_ESCAPE) then
	begin
   	Key:= 0;
        Annuler1Click(self)
	//ModalResult:= mrCancel;
        end;
        if (Key=VK_F3) and (Shift = []) then
	begin
   	Key:= 0;
        Enregister1Click(self);
//        ModalResult:= mrOk;
        end;

end;



procedure ListReglementAdd_Insert(Valeur:array of const;Add:boolean;Rang:integer;var Liste:Tstringlist);
var
i:integer;
retourboolean:TRetourBool;
NewReglement:TReglementList;
RetourTranstypage:TTypeTranstypage;
conteneur:TVerrouillage;
Begin
//if rang<>-1 then
//  NewReglement:=TReglementList(liste.Objects[rang])
//else
  NewReglement:=TReglementList.Create(SaisieReglements);
  SaisieReglements.ObjReglement1.Piece.InitialiseInfosVerrouillage(conteneur);
       for i:=0 to high(valeur)do
       begin
       RetourTranstypage:=VTypeTranstypage(valeur[i],valeur[i].vtype);
           if  RetourTranstypage.retour then
           begin
              case i mod 26 of
              0:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.Vide:=retourboolean.valeur;
                end;
              1:NewReglement.IDPiece:=StrToInt_Lgr(RetourTranstypage.valeur);
              2:NewReglement.Reference:=RetourTranstypage.valeur;
              3:NewReglement.IDJournal:=StrToInt_Lgr(RetourTranstypage.valeur);
              4:NewReglement.Journal:=RetourTranstypage.valeur;
              5:NewReglement.ID_Org:=StrToInt_Lgr(RetourTranstypage.valeur);
              6:NewReglement.IDContrepartie:=StrToInt_Lgr(RetourTranstypage.valeur);
              7:NewReglement.ID_Tmp:=StrToInt_Lgr(RetourTranstypage.valeur);
              8:NewReglement.Tiers:=RetourTranstypage.valeur;
              9:NewReglement.Compte:=RetourTranstypage.valeur;
             10:NewReglement.Libelle:=RetourTranstypage.valeur;
             11:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.Sens:=retourboolean.valeur;
                end;
             12:NewReglement.montant:=StrToCurr_Lgr(RetourTranstypage.valeur);
             13:NewReglement.Imputation:=StrToCurr_Lgr(RetourTranstypage.valeur);
             14:NewReglement.date:=RetourTranstypage.valeur;
             15:NewReglement.TvaDate:=RetourTranstypage.valeur;
             16:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.Pointee:=retourboolean.valeur;
                end;
             17:NewReglement.NbLignePointee:=StrToInt_Lgr(RetourTranstypage.valeur);
             18:NewReglement.Reste:=StrToCurr_Lgr(RetourTranstypage.valeur);
             19:NewReglement.ResteAAfficher:=StrToCurr_Lgr(RetourTranstypage.valeur);
             20:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.SensReste:=retourboolean.valeur;
                end;
             21:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.Modifiable:=retourboolean.valeur;
                end;
             22:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.PieceModifiee:=retourboolean.valeur;
                end;
             23:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.CompteModifiable:=retourboolean.valeur;
                end;
             24:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                conteneur.PieceVerrouillee:=retourboolean.valeur;
                NewReglement.InfosVerrouillage:=conteneur;
                end;
             25:NewReglement.ResteInitial:=StrToCurr_Lgr(RetourTranstypage.valeur);
             end;//fin du case

           end//fin si RetourTranstypage.retour=true
           else
           Begin
           showmessage('Problème lors du remplissage de la liste ');
           abort;
           End;
       end;
    if Add then
    begin
    rang:=Liste.Count;
    Liste.Addobject(inttostr(Rang),NewReglement);
    end
    else
      if rang<>-1 then
      begin
        if rang<=Liste.count-1  then Liste.delete(rang);
        Liste.Insertobject(rang,inttostr(Rang),NewReglement);
      end;
with SaisieReglements do
//VisuListeShowMessage(ListeReglement,Rang,[16,19]);
End;



procedure TSaisieReglements.EtatInitial;
var
i:integer;
Begin
Initialise_TStringlist(ListeReglement,SaisieReglements,false);
Initialise_TStringlist(listeNewReference,SaisieReglements,false);
Initialise_TStringlist(ListeReglementPointable,SaisieReglements,false);

ModifReglement:=false;
for i:=0 to GrReglement.rowcount-1 do
GrReglement.Rows[i].Clear;
GrReglement.RowCount:=2;
GrReglement.OnColenter:=nil;
GrReglement.col:=1;
GrReglement.OnColenter:=GrReglementColEnter;
EtatGrille:=dsinsert;

SBDejaPointes.Enabled:=true;
SBPointables.Enabled:=true;
SBAucun.Enabled:=true;
SBReglement.Enabled:=true;
SBAutres.Enabled:=true;
boutonEnabled:=false;

//rajoute deux lignes vides dans la liste des réglements
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,0,0,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true,false,0],true,-1,ListeReglement);
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,1,0,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true,false,0],true,-1,ListeReglement);
ResteARegler:=0;
if ObjReglement1.Piece.InfosPointage.infosPointage.Pointee then
    ResteARegler:=ObjReglement1.Piece.InfosPointage.InfosReste.Reste
else
    ResteARegler:=ObjReglement1.Piece.MontantPourReglement;
AfficheLigneBas(LigneCurr,false);

End;


function TSaisieReglements.CtrlSaisiePieceReglement(edit:TCustomEdit;Acol,CelluleSuivante:integer):TErreurSaisie;
var
conteneurVerrou:TVerrouillage;
Pointage:TPointage;
IDPieceTmp,rang:integer;
RefTmp,JournalTmp,CompteTmp,IDJournalTmp:string;
regl,ResteTmp:currency;
tab:variant;
DateDefaut:boolean;
sens:string;
InfoResteDCSurCompte:TInfoResteDCSurCompte;
messagetmp1,messagetmp2:string;
Begin
ObjReglement1.Piece.InitialiseInfosPointage(Pointage);
JournalTmp:='';
CompteTmp:='';
IDPieceTmp:=0;
result.CodeErreur:=0;
result.retour:=true;
DateDefaut:=false;
DeFiltrageDataSet(DMRech.TaTiersRech);
   if EtatGrille in [dsinsert,dsedit] then
      Begin//si grille en insert ou modification
      if ((ligneCourante<>GrReglement.Rows[ligneCurr].text)and (not boutonEnabled)) then
         begin
           SBDejaPointes.Enabled:=false;
           SBPointables.Enabled:=false;
           SBAucun.Enabled:=false;
           SBReglement.Enabled:=false;
           SBAutres.Enabled:=false;
           boutonEnabled:=true;
         end;
//         if not GrReglement.lignevide(lignecurr)then
//            begin
                case Acol of
                1:begin//si colonne 1
                  //Vérifier si compte dans contexte et si compte rempli
                  //si compte rempli et correct, créer la nouvelle référence
                    if (ListeReglement.Objects[ligneCurr]as TReglementList).Comptemodifiable then
                       begin
                         if ((trim((ListeReglement.Objects[ligneCurr]as TReglementList).Compte)<>trim(edit.text))or(empty((ListeReglement.Objects[ligneCurr]as TReglementList).Compte))) then
                            begin // si modification du compte

     //                       if not(option in [31,32,33]) then
     //                         begin//si different de journal d'OD
                               if AideModelCompteJournalBanque(edit.text) then
                                Begin
                                 if AideModelAfficheJournauxBanque(edit,False) then
                                          Begin
                                            GrReglement.Cells[1,ligneCurr]:=edit.text;
                                          End
                                            else
                                          Begin
                                          result.retour:=false;
                                          result.CodeErreur:=1001;
                                          End;
                                End
                                else
                                Begin
//                                  AideCompte.FiltrageAideCompte(101);
                                  GestionFiltrageParamCpt;
                                  //les comptes doivent être filtrés en fonction des comptes pointables
                                  result.retour:=not DMPlan.CptEstCollectif(GrReglement.Cells[1,ligneCurr]);
                                  if not result.retour then
                                    result.CodeErreur:=1002;
                                  if result.retour then
                                    begin
                                    result.retour:=AideCompteDansContexte(GrReglement.Cells[1,ligneCurr],GrReglement,['rac1'],false,MessDerSub,true,true,true,true,0);
                                    if not result.retour then
                                      result.CodeErreur:=1002;
                                    end;
                                End;
                                if edit.Text=ObjReglement1.Piece.Tiers then
                                  Begin
                                    result.retour:=false;
                                    result.CodeErreur:=1002;
                                  End;
     //                         end;//fin si different de journal d'OD
                                 if result.retour then
                                    Begin //si compte correct,
                                    //créer la nouvelle référence
                                    //Récupérer le code journal en fonction du compte séléctionné
                                    if not empty((ListeReglement.Objects[ligneCurr]as TReglementList).Reference) then
                                    begin
     //                                 if  (ListeReglement.Objects[ligneCurr]as TReglementList).Reference<>grReglement.Cells[2,ligneCurr] then
     //                                 Begin
                                      rang:=ListeReglementPointable.IndexOf((ListeReglement.Objects[ligneCurr]as TReglementList).Reference);
                                        if rang<>-1 then
                                          ListeReglementPointable.delete(rang);
     //                                 End;
                                    end;
                                    if not empty(GrReglement.Cells[1,ligneCurr])then
                                    JournalTmp:=ObjReglement1.RenvoieInfoSurTableDiverse( GrReglement.Cells[1,ligneCurr],
                                    ObjReglement1.Piece.TableJournal,'Compte','Journal');
                                    if empty(JournalTmp)then
                                    JournalTmp:='OD';
                                    GrReglement.Cells[2,ligneCurr]:=gestionDerniereReference(journalTmp,ObjReglement1.Piece,ListeReglementPointable);
                                    ListeReglementPointable.Add(GrReglement.Cells[2,ligneCurr]);
                                    End //fin si compte correct,
                                else
                                    Begin //si compte pas correct
                                    if result.CodeErreur=1002 then
                                       Application.MessageBox(Pchar('Ce compte n''est pas cohérent dans ce context.'),'Erreur de saisie',0)
                                    else
                                       Application.MessageBox(Pchar('La saisie du compte est obligatoire !!!'),'Erreur de saisie',0);
                                    End; //fin si compte pas correct
                            if ((not empty(GrReglement.Cells[1,ligneCurr]))and (result.retour)) then
                               begin //si après vérif et réparation le compte est rempli
                               ModifReglement:=true;
                               if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                                 if trim((ListeReglement.Objects[ligneCurr]as TReglementList).compte)<>trim(GrReglement.Cells[1,ligneCurr]) then
                                   (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).Vide:=false;

                               (ListeReglement.Objects[ligneCurr]as TReglementList).Compte:=edit.text;
                                   if copy(edit.text,1,1)='+'then
                                     Begin
                                      if not empty(RenvoieInfoSurTableDiverse(edit.text,DMRech.TaTiersRech,'Tiers',['Compte'],Tab))then
                                        begin
                                        (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieCompte:=tab[0];
                                        (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieTiers:=edit.text;
                                        end
                                      else
                                        Begin //
                                        Application.MessageBox(Pchar('Problème lors de la récupération du compte comptable lié au tiers en cours!!!'),'Erreur de saisie',0);
                                        result.CodeErreur:=2003;
                                        result.retour:=false;
                                        End;
                                     End
                                    else
                                     Begin
                                       (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieCompte:=edit.text;
                                       (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieTiers:='';
                                     End;
                               IDJournalTmp:=ObjReglement1.RenvoieInfoSurTableDiverse(JournalTmp,ObjReglement1.Piece.TableJournal,'Journal','ID_Journal');
                               if not empty(IDJournalTmp)then
                               (ListeReglement.Objects[ligneCurr]as TReglementList).IDJournal:=StrToInt_Lgr(IDJournalTmp)
                               else
                               abort;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).Journal:=JournalTmp;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).Reference:=GrReglement.Cells[2,ligneCurr];
                               (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Tmp:=ligneCurr;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).Sens:=ObjReglement1.piece.SensPourReglement;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).tiers:=ObjReglement1.piece.tiers;
                              end;//fin si après vérif et réparation le compte est rempli
                            end;//fin si modification du compte
           //              end;//fin du with
                        end;
                  AfficheLigneBas(ligneCurr,true);      
                 end;//fin si colonne 1
           2:Begin //si champ reference
                  //vérifier si la référence existe, si oui, récupérer son reste à pointer
                  //s'il y a un reste afficher la pièce de réglement
      //           with (ListeReglement.Objects[ligneCurr]as TReglementList) do
      //             begin
                  if (ListeReglement.Objects[ligneCurr]as TReglementList).Comptemodifiable then
                  begin//si compte modifiable
                   if ((trim((ListeReglement.Objects[ligneCurr]as TReglementList).Reference)<>trim(edit.text))or(empty((ListeReglement.Objects[ligneCurr]as TReglementList).Reference))) then
                     begin // si modification de la référence
                     if not empty(GrReglement.cells[1,ligneCurr])then
                     JournalTmp:=ObjReglement1.RenvoieInfoSurTableDiverse(GrReglement.cells[1,ligneCurr],
                     ObjReglement1.Piece.TableJournal,'Compte','Journal');
                     if empty(JournalTmp)then
                     JournalTmp:='OD';
                     if not empty((ListeReglement.Objects[ligneCurr]as TReglementList).Reference) then
                     begin
                       if  (ListeReglement.Objects[ligneCurr]as TReglementList).Reference<>grReglement.Cells[2,ligneCurr] then
                       Begin
                       rang:=ListeReglementPointable.IndexOf((ListeReglement.Objects[ligneCurr]as TReglementList).Reference);
                         if rang<>-1 then
                           ListeReglementPointable.delete(rang);
                       End;
                     end;
                      if not empty(edit.text)then
                        Begin//si la référence est remplie
                          if not ObjReglement1.Piece.RechercheReference(ObjReglement1.Piece.TablePiece,edit.text,'Reference','ID',IDPieceTmp)then
                           begin //si la référence n'existe pas
                           //je récupère une nouvelle référence
                             RefTmp:=gestionDerniereReference(journalTmp,ObjReglement1.Piece,ListeReglementPointable);
                            if edit.text<>RefTmp then
                             Begin //si référence pas correct
                             Application.MessageBox(Pchar('Cette référence n''est pas cohérente dans ce contexte !!!'),'Erreur de saisie',0);
                             result.CodeErreur:=2002;
                             result.retour:=false;
                             End //fin si référence pas correct
                             else
                             Begin//si la référence est correct et c'est une nouvelle référence
                             //je vide tous les champs sauf la référence
                             CompteTmp:=GrReglement.Cells[1,ligneCurr];
                             GrReglement.Rows[ligneCurr].Clear;
                             GrReglement.Cells[1,ligneCurr]:=CompteTmp;
                             GrReglement.Cells[2,ligneCurr]:=RefTmp;
                             (ListeReglement.Objects[ligneCurr]as TReglementList).Compte:=CompteTmp;
                              if copy(compteTmp,1,1)='+'then
                                Begin
                                 if not empty(RenvoieInfoSurTableDiverse(compteTmp,DMRech.TaTiersRech,'Tiers',['Compte'],Tab))then
                                   begin
                                   (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieCompte:=tab[0];
                                   (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieTiers:=CompteTmp;
                                   end
                                 else
                                   Begin //
                                   Application.MessageBox(Pchar('Problème lors de la récupération du compte comptable lié au tiers en cours!!!'),'Erreur de saisie',0);
                                   result.CodeErreur:=2003;
                                   result.retour:=false;
                                   End;
                                End
                               else
                                Begin
                                  (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieCompte:=CompteTmp;
                                  (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieTiers:='';
                                End;
                             (ListeReglement.Objects[ligneCurr]as TReglementList).Reference:=RefTmp;
                             (ListeReglement.Objects[ligneCurr]as TReglementList).IDJournal:=StrToInt_Lgr(ObjReglement1.RenvoieInfoSurTableDiverse(JournalTmp,
                               ObjReglement1.Piece.TableJournal,'Journal','ID_Journal'));
                               (ListeReglement.Objects[ligneCurr]as TReglementList).Journal:=JournalTmp;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Tmp:=ligneCurr;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).Sens:=ObjReglement1.piece.SensPourReglement;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).tiers:=ObjReglement1.piece.tiers;
                              ModifReglement:=true;
                             End;//fin si la référence est correct
                           End //fin si la référence n'existe pas
                           else
                           Begin //si la référence existe
                           //si elle fait partie des références pointables
                           //calculer le reste à pointer de cette pièce et s'il y a un reste
                           //afficher la pièce, sinon envoyer message
                             if (ListeReglementPointable.IndexOf(edit.text)<>-1) then
                                begin //si la piece fait partie de la liste des réglements pointables
                                   rang:=ListReglementIndexOf(edit.text,2);
                                   if rang<>-1 then
                                   GrReglement.Row:=rang //si la référence est déjà editée
                                   else
                                   begin//si la référence n'est pas dans la grille
                                    //  DMPointage.RecupPiecePointableSurTiers_Et_Journal_PourReglement(ObjReglement1.Piece.Tiers,StrToInt_Lgr(copy(inttostr(option),1,1)),strtoint(copy(inttostr(option),2,1)),ObjReglement1.Piece.IDContrepartie,ObjReglement1.Piece.Sens,ObjReglement1.Piece.SensPourReglement);
                                    if ObjReglement1.piece.Sens then
                                    sens:='C'
                                    else
                                    sens:='D';
                                    case StrToInt_Lgr(copy(inttostr(option),1,1)) of
                                     4:InfoResteDCSurCompte:=RecupPointagePourReglement(ObjReglement1.Piece.compte,sens,'',['4'],0,0,Option,ObjReglement1.Piece.IDContrepartie);
                                     3:InfoResteDCSurCompte:=RecupPointagePourReglement(ObjReglement1.Piece.compte,sens,'',['3'],0,0,Option,ObjReglement1.Piece.IDContrepartie);
                                    end;//fin du case

                                      if DMPointage2.TaResteDCReglement.RecordCount<>0 then
                                        if DMPointage2.TaResteDCReglement.Locate('Reference',edit.text,[])then
                                           AffichagePieceReglementExistante(ligneCurr,edit.text,InfoResteDCSurCompte)
                                      else
                                      Begin//si ce n'est pas un réglement pointable
                                      Application.MessageBox(Pchar('Cette référence n''est pas cohérente dans ce contexte !!!'),'Erreur de saisie',0);
                                      result.CodeErreur:=2002;
                                      result.retour:=false;
                                      End;//fin si ce n'est pas un réglement pointable
                                   end;//fin si la référence n'est pas dans la grille
                                end//fin si la piece fait partie de la liste des réglements pointables
                                else
                                Begin //si la piece ne fait pas partie de la liste des réglements pointables
                                  Application.MessageBox(Pchar('Cette référence n''est pas cohérente dans ce contexte !!!'),'Erreur de saisie',0);
                                  result.CodeErreur:=2002;
                                  result.retour:=false;
                                End;//fin si la piece ne fait pas partie de la liste des réglements pointables
                           End; //fin si la référence existe
                        end //fin si la référence est remplie
                        else
                          Begin //si référence pas remplie
                          if CelluleSuivante<>1 then
                              begin //si la CelluleSuivante est différente de la colonne compte
                              // re-remplir par défaut avec nouvelle référence
          //                    Messagebox(0,Pchar('La référence est obligatoire !!!'),'Erreur de saisie',0);
                              //recréer une nouvelle référence
                              RefTmp:=gestionDerniereReference(journalTmp,ObjReglement1.Piece,ListeReglementPointable);

                              CompteTmp:=GrReglement.Cells[1,ligneCurr];
                              GrReglement.Rows[ligneCurr].Clear;
                              GrReglement.Cells[1,ligneCurr]:=CompteTmp;
                              GrReglement.Cells[2,ligneCurr]:=RefTmp;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).Compte:=CompteTmp;
                              ModifReglement:=true;
                              if copy(compteTmp,1,1)='+'then
                                Begin
                                 if not empty(RenvoieInfoSurTableDiverse(compteTmp,DMRech.TaTiersRech,'Tiers',['Compte'],Tab))then
                                   begin
                                   (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieCompte:=tab[0];
                                   (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieTiers:=CompteTmp;
                                   end
                                 else
                                   Begin //
                                   Application.MessageBox(Pchar('Problème lors de la récupération du compte comptable lié au tiers en cours!!!'),'Erreur de saisie',0);
                                   result.CodeErreur:=2003;
                                   result.retour:=false;
                                   End;
                                End
                               else
                                Begin
                                  (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieCompte:=CompteTmp;
                                  (ListeReglement.Objects[ligneCurr]as TReglementList).ContrePartieTiers:='';
                                End;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).Reference:=RefTmp;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).IDJournal:=StrToInt_Lgr(ObjReglement1.RenvoieInfoSurTableDiverse(JournalTmp,
                                   ObjReglement1.Piece.TableJournal,'Journal','ID_Journal'));
                              (ListeReglement.Objects[ligneCurr]as TReglementList).Journal:=JournalTmp;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Tmp:=GrReglement.row;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).Sens:=ObjReglement1.piece.SensPourReglement;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).tiers:=ObjReglement1.piece.tiers;
                              end; //fin si la CelluleSuivante est différente de la colonne compte
                          End; //fin si référence pas remplie
                      if not empty(GrReglement.Cells[2,ligneCurr])then
                      begin
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            if trim((ListeReglement.Objects[ligneCurr]as TReglementList).reference)<>trim(GrReglement.Cells[2,ligneCurr]) then
                              (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                      ListeReglementPointable.add(GrReglement.Cells[2,ligneCurr]);
                      ModifReglement:=true;
                      end;
                     end;//fin si modification de la référence
      //             end;//fin du with
                  end;//fin si compte modifiable
                  End; //fin si champ reference
                3:Begin//si champ date
                  //si rempli,vérifier si date correspond à l'exercice en cours
      //           with (ListeReglement.Objects[ligneCurr]as TReglementList) do
      //             begin
                   if ((trim((ListeReglement.Objects[ligneCurr]as TReglementList).date)<>trim(edit.text))or(empty((ListeReglement.Objects[ligneCurr]as TReglementList).date))) then
                     begin // si modification de la date
                     if empty(edit.text)then
                     begin
                       edit.text:=datetostr(ObjReglement1.Piece.datesaisie);
                       DateDefaut:=true;
                     end;
                     edit.text:=AnneeDefaut(DMPieces.Piece1.DateDebutExo,DMPieces.Piece1.DateFinExo,edit.Text).DateStr;
                       if DateValide(edit.text) then
                         Begin //si la date est remplie
                           if not (ObjReglement1.Piece.VerifDateSaisie(StrToDate_Lgr(edit.text)))then
                             Begin //si référence pas correct
                             Application.MessageBox(Pchar('La date doit faire partie de l''exercice en cours !!!'),'Erreur de saisie',0);
                             result.CodeErreur:=3002;
                             result.retour:=false;
                             End; //fin si compte pas correct
                         End //fin si la date est remplie
                       else
                         Begin //si pas remplie
                         // remplir par défaut avec date de la pièce appelante
                         //edit.text:=datetostr(ObjReglement1.Piece.datesaisie);
                             Application.MessageBox(Pchar('La date doit faire partie de l''exercice en cours !!!'),'Erreur de saisie',0);
                             result.CodeErreur:=3002;
                             result.retour:=false;
                         End; //fin si pas remplie
                       if result.retour then
                         Begin
                         GrReglement.Cells[3,ligneCurr]:=edit.text;
                            //recupérer les nouvelles infos verrouillage en fonction de la nouvelle date
                            ObjReglement1.Piece.InitialiseInfosVerrouillage(conteneurVerrou);
                            conteneurVerrou:=ObjReglement1.Piece.RetourneInfosVerrouillageSurPiece(nil,(ListeReglement.Objects[ligneCurr]as TReglementList).IDPiece,StrToDate_Lgr(GrReglement.Cells[3,ligneCurr]));
                            if conteneurVerrou.PeriodeVerrouillee then
                              begin //si pièce verrouillée
                               if DateDefaut then
                                begin
                                  edit.text:=datetostr(e.DateDebutDeclarationTVA);
                                  if e.DateDebutDeclarationTVA<e.DatExoDebut then
                                    edit.text:=datetostr(e.DatExoDebut);
                                  if e.DateDebutDeclarationTVA>e.DatExoDebut then
                                    edit.text:=datetostr(e.DatExofin);
                                  GrReglement.Cells[3,ligneCurr]:=edit.text;
                                  ObjReglement1.Piece.InitialiseInfosVerrouillage(conteneurVerrou);
                                  conteneurVerrou:=ObjReglement1.Piece.RetourneInfosVerrouillageSurPiece(nil,(ListeReglement.Objects[ligneCurr]as TReglementList).IDPiece,StrToDate_Lgr(GrReglement.Cells[3,ligneCurr]));
                                end
                               else
                                begin//si date saisie par l'utilisateur
                                messagetmp2:='voulez-vous la conserver ?';
                                messagetmp1:='Cette date fait partie d''une période de TVA déclarée.';
                                if conteneurVerrou.PeriodeDeverrouillable then
                                    messagetmp1:='Cette date fait partie d''une période de TVA déclarée, si vous la conservez vous devrez supprimer la dernière déclaration TVA avant de pouvoir pointer ce réglement avec la pièce d''origine puisque celle-ci comporte de la TVA sur encaissement!! '
                                else
                                    messagetmp1:='Cette date fait partie d''une période de TVA déclarée non modifiable, si vous la conservez vous ne pourrez pas la pointer avec la pièce d''origine puisque celle-ci comporte de la TVA sur encaissement!! ';
                                 if Application.MessageBox(Pchar(messagetmp1+messagetmp2),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                                   abort
                                 else
                                   Begin//si on veut la conserver
                                     grReglement.Cells[8,lignecurr]:='0';
                                     ObjReglement1.Piece.InitialiseInfosVerrouillage(conteneurVerrou);
                                     conteneurVerrou:=ObjReglement1.Piece.RetourneInfosVerrouillageSurPiece(nil,(ListeReglement.Objects[ligneCurr]as TReglementList).IDPiece,StrToDate_Lgr(GrReglement.Cells[3,ligneCurr]));
                                   End;//fin si on veut la conserver
                                end;//fin si date saisie par l'utilisateur
                              end;//fin si pièce verrouillée
                          (ListeReglement.Objects[ligneCurr]as TReglementList).InfosVerrouillage:=conteneurVerrou;
                         End;
//                       if ((not VerifNumeric(GrReglement.Cells[3,ligneCurr]).VideOUZero)and(result.retour)) then
                       if ((DateValide(GrReglement.Cells[3,ligneCurr]))and(result.retour)) then
                       begin
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            if trim((ListeReglement.Objects[ligneCurr]as TReglementList).date)<>trim(GrReglement.Cells[3,ligneCurr]) then
                              (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                       if ((strtodate_lgr(GrReglement.Cells[3,ligneCurr])<e.DatExoDebut)and(DMPieces.Piece1.AnneePiece.PieceAnterieure=false))then
                          GrReglement.Cells[3,ligneCurr]:=datetostr_lgr(e.DatExoDebut);
                       if strtodate_lgr(GrReglement.Cells[3,ligneCurr])>e.DatExoFin then
                          GrReglement.Cells[3,ligneCurr]:=datetostr_lgr(e.DatExoFin);
                       (ListeReglement.Objects[ligneCurr]as TReglementList).Date:=GrReglement.Cells[3,ligneCurr];
                       ModifReglement:=true;
                       end;
                     end;//fin si modification de la date
                  End;//fin si champ date
                4:begin//si champ libelle
                   if ((trim((ListeReglement.Objects[ligneCurr]as TReglementList).Libelle)<>trim(edit.text))or(empty((ListeReglement.Objects[ligneCurr]as TReglementList).Libelle))) then
                     begin // si modification du libelle
                       if ((empty(edit.text))or (trim(edit.text)='*' ))then //si champ libelle vide
                          begin//ou rempli avec une *
                          //GrReglement.Cells[4,ligneCurr]:=RenvoieInfoSurTableDiverse(GrReglement.Cells[1,ligneCurr],ObjReglement1.Piece.TablePlan,'Compte',['Libelle'],Tab);
                          if empty(GrReglement.Cells[4,ligneCurr])then
                          GrReglement.Cells[4,ligneCurr]:=ObjReglement1.Piece.Libelle;
                          LastLibEcriture:=GrReglement.Cells[4,ligneCurr];
                          end
                       else
                          Begin //si champ libelle rempli
                          // if LastLibEcriture=edit.text then
                          //GrReglement.Cells[4,ligneCurr]:=RenvoieInfoSurTableDiverse(GrReglement.Cells[1,ligneCurr],ObjReglement1.Piece.TablePlan,'Compte',['Libelle'],Tab);
                          if empty(GrReglement.Cells[4,ligneCurr])then
                          GrReglement.Cells[4,ligneCurr]:=ObjReglement1.Piece.Libelle;
                          LastLibEcriture:=GrReglement.Cells[4,ligneCurr];
                          End;//fin si champ libelle rempli
                       if empty(GrReglement.Cells[4,ligneCurr]) then
                         Begin //si libelle vide
                         Application.MessageBox(Pchar('La saisie du Libellé est obligatoire !!!'),'Erreur de saisie',0);
                         result.CodeErreur:=4001;
                         result.retour:=false;
                         End; //fin si libelle vide
                       if ((not empty(GrReglement.Cells[4,ligneCurr]))and(result.retour)) then
                       begin
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            if trim((ListeReglement.Objects[ligneCurr]as TReglementList).Libelle)<>trim(GrReglement.Cells[4,ligneCurr]) then
                              (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                       (ListeReglement.Objects[ligneCurr]as TReglementList).Libelle:=GrReglement.Cells[4,ligneCurr];
                       ModifReglement:=true;
                       end;
                     end;//fin si modification du libelle
                  End;//fin si champ libelle
                5:Begin//si champ Debit ou Crédit
                   if (((ListeReglement.Objects[ligneCurr]as TReglementList).montant<>StrToCurr_Lgr(edit.Text))or(VerifNumeric(edit.text).VideOUZero)) then
                   begin//si changement de montant
                        GrReglement.Cells[8,ligneCurr]:='0';
                        if empty(GrReglement.Cells[6,ligneCurr]) then GrReglement.Cells[6,ligneCurr]:='0';
                        (ListeReglement.Objects[ligneCurr]as TReglementList).Imputation:=0;
                        GrReglement.Cells[7,ligneCurr]:=currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).montant - StrToCurr_Lgr(GrReglement.Cells[8,ligneCurr]) -StrToCurr_Lgr(GrReglement.Cells[6,ligneCurr]));
                        (ListeReglement.Objects[ligneCurr]as TReglementList).ResteAAfficher:=StrToCurr_Lgr(GrReglement.Cells[7,ligneCurr]);
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org=-1 then
                             (ListeReglement.Objects[ligneCurr]as TReglementList).Reste:=StrToCurr_Lgr(GrReglement.Cells[5,ligneCurr])-StrToCurr_Lgr(GrReglement.Cells[6,ligneCurr])-StrToCurr_Lgr(GrReglement.Cells[8,ligneCurr]);
                        ModifReglement:=true;

                   ResteTmp:=(ListeReglement.Objects[ligneCurr]as TReglementList).Reste+(ListeReglement.Objects[ligneCurr]as TReglementList).Imputation;

                   ResteARegler:=CalculResteARegler(ObjReglement1.Piece.InfosPointage,ObjReglement1.Piece.MontantPourReglement);

                   if ((VerifNumeric(edit.text).VideOUZero)and(ResteARegler>0)) then
                    begin
                     GrReglement.Cells[5,ligneCurr]:=currtostr(ResteARegler);
                     edit.text:=GrReglement.Cells[5,ligneCurr];
                    end;
                    
                   if VerifNumeric(edit.text).VideOUZero then
                   Begin //si champ vide
                       Application.MessageBox(Pchar('Vous devez Saisir le montant du réglement!!!'),'Erreur de saisie',0);
                       result.CodeErreur:=5001;
                       result.retour:=false;
                   End
                   else //fin si champ vide
                        with (ListeReglement.Objects[ligneCurr]as TReglementList) do
                        begin
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            begin
                            if currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).montant)<>trim(GrReglement.Cells[5,ligneCurr]) then
                              PieceModifiee:=true;
                            end;
                        (ListeReglement.Objects[ligneCurr]as TReglementList).montant:=StrToCurr_Lgr(edit.text);
                           if pointee then
                           GrReglement.Cells[6,ligneCurr]:=currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).montant-(ListeReglement.Objects[ligneCurr]as TReglementList).reste)
                           else
                           GrReglement.Cells[6,ligneCurr]:='0';
                        GrReglement.Cells[8,ligneCurr]:='0';
                        (ListeReglement.Objects[ligneCurr]as TReglementList).Imputation:=0;
                        GrReglement.Cells[7,ligneCurr]:=currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).montant - StrToCurr_Lgr(GrReglement.Cells[8,ligneCurr]) -StrToCurr_Lgr(GrReglement.Cells[6,ligneCurr]));
                        ResteAAfficher:=StrToCurr_Lgr(GrReglement.Cells[7,ligneCurr]);
                        ResteTmp:=(ListeReglement.Objects[ligneCurr]as TReglementList).Reste;
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org=-1 then
                             (ListeReglement.Objects[ligneCurr]as TReglementList).Reste:=StrToCurr_Lgr(GrReglement.Cells[5,ligneCurr])-StrToCurr_Lgr(GrReglement.Cells[6,ligneCurr])-StrToCurr_Lgr(GrReglement.Cells[8,ligneCurr]);
                        ResteTmp:=(ListeReglement.Objects[ligneCurr]as TReglementList).Reste;
                        ModifReglement:=true;
                        end;
                   end;//fin si changement de montant
                  End;//fin si champ Debit ou Crédit
                8:Begin//si champ Imputation
                  //vérifier si imputation n'est pas supérieur au montant du débit ou crédit
                  //et si elle n'est pas supérieur au reste à pointer de la pièce appelante ou
                  // de cette pièce de réglement elle-même.
                      if ((currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).Imputation)<>edit.text)or((ListeReglement.Objects[ligneCurr]as TReglementList).Imputation=0)) then
                        begin // si modification de l'Imputation
                        if VerifNumeric(edit.text).VideOUZero then
                        GrReglement.Cellsgr(8,ligneCurr,'0');
                           with ObjReglement1.Piece do
                              Begin//si le champ est rempli
                              ResteTmp:=(ListeReglement.Objects[ligneCurr]as TReglementList).Reste+(ListeReglement.Objects[ligneCurr]as TReglementList).Imputation;
                              ResteARegler:=CalculResteARegler(InfosPointage,ObjReglement1.Piece.MontantPourReglement);
                              if not empty(GrReglement.Cells[5,ligneCurr])then
                              regl:=StrToCurr_Lgr(GrReglement.Cells[5,ligneCurr])
                              else
                              regl:=0;
                              if ResteARegler<0then
                                begin//on vérifie s'il ne dépasse pas le montant qu'il reste à régler
                                Application.MessageBox(Pchar('Ce montant est supérieur au reste à régler !!!'),'Erreur de saisie',0);
                                result.CodeErreur:=8001;
                                result.retour:=false;
                                end //fin on vérifie s'il ne dépasse pas le montant qu'il reste à régler
                                else
                                  if regl<StrToCurr_Lgr(GrReglement.Cells[8,ligneCurr]) then
                                    begin//on vérifie s'il ne dépasse pas le montant du réglement lui-même
                                    Application.MessageBox(Pchar('Ce montant est supérieur au montant du réglement !!!'),'Erreur de saisie',0);
                                    result.CodeErreur:=8002;
                                    result.retour:=false;
                                    end//fin on vérifie s'il ne dépasse pas le montant du réglement lui-même
                                    else
                                      if (ListeReglement.Objects[ligneCurr]as TReglementList).Pointee then
                                      begin //si le réglement est déjà pointee
                                            if ResteTmp<StrToCurr_Lgr(GrReglement.Cells[8,ligneCurr])then
                                             Begin //on vérifie s'il ne dépasse pas le reste à pointer du réglement lui-même
                                             Application.MessageBox(Pchar('Ce montant est supérieur à la valeur restant à pointer sur ce réglement!!!'),'Erreur de saisie',0);
                                             result.CodeErreur:=8003;
                                             result.retour:=false;
                                             End;//fin on vérifie s'il ne dépasse pas le reste à pointer du réglement lui-même
                                      End;//fin si le réglement est déjà pointee
                              End;//fin si le champ est rempli
                              if result.CodeErreur=0 then
                                 begin
                                 if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                                   if currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).Imputation)<>trim(GrReglement.Cells[8,ligneCurr]) then
                                     (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                                 GrReglement.Cells[7,ligneCurr]:=currtostr(StrToCurr_Lgr(GrReglement.Cells[5,ligneCurr]) - StrToCurr_Lgr(GrReglement.Cells[8,ligneCurr]) -StrToCurr_Lgr(GrReglement.Cells[6,ligneCurr]));
                                 (ListeReglement.Objects[ligneCurr]as TReglementList).Imputation:=StrToCurr_Lgr(GrReglement.Cells[8,ligneCurr]);
                                 (ListeReglement.Objects[ligneCurr]as TReglementList).ResteAAfficher:=StrToCurr_Lgr(GrReglement.Cells[7,ligneCurr]);

                                 (ListeReglement.Objects[ligneCurr]as TReglementList).Reste:=restetmp-(ListeReglement.Objects[ligneCurr]as TReglementList).Imputation;
                                restetmp:=(ListeReglement.Objects[ligneCurr]as TReglementList).Reste;
                                 AfficheLigneBas(ligneCurr,true);
                                 ModifReglement:=true;           
                                 end;
                        end;//fin si modification de l'Imputation
                  end;//fin si champ Imputation
                End; //fin du case Acol
      End; //fin etatpiece in [dsinsert,dsbrowse]
end;

// 27/07/02
// Cette fonction effectue les controles lors de l'appel de saisie des règlements
// ailleurs que dans saisie pièce, pour pointer automatique le règlement en cours avec la ou les pièces appelante
function TSaisieReglements.CtrlSaisiePieceReglementPourPointageDirect(edit:TCustomEdit;Acol,CelluleSuivante:integer):TErreurSaisie;
Begin
//
End;



procedure TSaisieReglements.FormActivate(Sender: TObject);
//var
//QueryTmp:TQuery;
//conteneur:TPointage;
begin
//try
Initialiser_ShortCut_Main(true);
//etatinitial;
//ligneCurr:=1;
//if ListeReglementPointable=nil then ListeReglementPointable.Create;
//DisposeTStringlist(ListeReglementPointable);
//if ListeReglement=nil then ListeReglement.Create;
//DisposeTStringlist(ListeReglement);

//grReglement.ParamColor:=true;
//grReglement.Param:=ParamUtil.CouleurDBGrid;
//grReglement.UpDateColor;
//
//Patitre.visible:=Main.AfficheTitre;
//
//QueryTmp:=TQuery.create(self);
//QueryTmp.DataBaseName:=DMPointage2.TaPointage.DatabaseName;
//QueryTmp.sql.Clear;
//
//
//DMPieces.Piece1.InitialiseInfosPointage(conteneur);
//conteneur.infosPointage:=DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr(DMPieces.Piece1.IDContrepartie),DMPieces.Piece1.Sens,true,false,-1);
//if not empty(DMPieces.Piece1.tiers)then
//  conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(DMPieces.Piece1.IDContrepartie,DMPieces.Piece1.Tiers)
//else
//  conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(DMPieces.Piece1.IDContrepartie,DMPieces.Piece1.compte);
//DMPieces.Piece1.InfosPointage:=conteneur;
//
////  ObjReglement1.Piece:=DMPieces.Piece1;
//
//     dmpointage2.QuSumPointageCredit.close;
//     dmpointage2.QuSumPointageCredit.open;
//     dmpointage2.QuSumPointageDebit.close;
//     dmpointage2.QuSumPointageDebit.open;
//  //Initialise la grille en fonction de l'option d'affichage récupérée
//
//  PrepaAffichageSurOption(option,true);
//  InitPaLibelle;
//  ////***Récupérer les paramètres de la pièce appelante pour afficher le reste à régler
//  //et autres informations
//
//
//  if ObjReglement1.Piece.SensPourReglement then
//  grReglement.Rows[0].CommaText:=SaisieReglementGrReglementCommaTextCredit
//  else
//  grReglement.Rows[0].CommaText:=SaisieReglementGrReglementCommaTextDebit;
//  DerniereRef:='';
//  AfficheLigneBas(lignecurr,true);
//  GrReglement.setfocus;
//finally
//  if QueryTmp<>nil then
//  Begin
////  QueryTmp.free;
//  QueryTmp:=nil;
//  End;
//end;
end;


procedure TSaisieReglements.GestionFiltrageParamCpt;
var
listeCpt:Tstringlist;
begin
if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
listeCpt:=TStringlist.Create;
DMPlan.TaCompte.OnFilterRecord:= DMPlan.TaCompteFilterRecord;
//ListeCpt:=DMPlan.FiltrageParamCPT(101,e.Regime);
ListeCpt:=DMPlan.FiltrageParamCPT(28,e.Regime);  { isa  le  29/06/05 }
AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
Initialise_TStringlist(listeCpt,self);
End;


procedure TSaisieReglements.AffichagePieceReglementExistante(Ligne:integer;Reference:string;InfoResteDCSurCompte:TInfoResteDCSurCompte);
var
Imputation:currency;
i:integer;
conteneur:TPointage;
reste:currency;
InfosVerrouillage:TVerrouillage;
tab:variant;
Begin
  try
  conteneur:=ObjReglement1.piece.InfosPointage;
  conteneur.InfosReste.ResteInitial:=0;
     if ligne=-1 then
        begin//si on veut travailler sur plusieurs pieces de réglements trouvées
          DMPointage2.TaResteDCReglement.first;
           i:=1;
          GrReglement.RowCount:=DMPointage2.TaResteDCReglement.RecordCount+1;
           while not(DMPointage2.TaResteDCReglement.eof)do
              begin //début du while
              ObjReglement1.Piece.InitialiseInfosVerrouillage(InfosVerrouillage);
              InfosVerrouillage:=ObjReglement1.Piece.RetourneInfosVerrouillageSurPiece(nil,DMPointage2.TaResteDCReglement.findfield('ID_Piece').AsInteger,DMPointage2.TaResteDCReglement.findfield('Date').AsDateTime);
              GrReglement.Cells[1,i]:=DMPointage2.TaResteDCReglement.findfield('ComptePiece').AsString;
              GrReglement.Cells[2,i]:=DMPointage2.TaResteDCReglement.findfield('Reference').AsString;
              GrReglement.Cells[3,i]:=DMPointage2.TaResteDCReglement.findfield('Date').AsString;
              GrReglement.Cells[4,i]:=DMPointage2.TaResteDCReglement.findfield('Libelle').AsString;
              GrReglement.Cells[5,i]:=DMPointage2.TaResteDCReglement.findfield('TotalReglement').AsString;
              GrReglement.Cells[6,i]:=DMPointage2.TaResteDCReglement.findfield('AutrePointage').AsString;
              GrReglement.Cells[7,i]:=DMPointage2.TaResteDCReglement.findfield('Reste').AsString;
              Imputation:=DMPointage2.TaResteDCReglement.findfield('Imputation').AsCurrency;
              GrReglement.Cells[8,i]:=currtostr(Imputation);
              conteneur.InfosReste.ResteInitial:=conteneur.InfosReste.ResteInitial+imputation;
              ListReglementAdd_Insert([false,DMPointage2.TaResteDCReglement.findfield('Id_Piece').AsString,
              DMPointage2.TaResteDCReglement.findfield('Reference').AsString,RenvoieInfoSurTableDiverse(copy(DMPointage2.TaResteDCReglement.findfield('Reference').AsString,1,2),DMJournal.TaJournal,'Journal',['ID_Journal'],tab),
              copy(DMPointage2.TaResteDCReglement.findfield('Reference').AsString,1,2),0,
              DMPointage2.TaResteDCReglement.findfield('ID_Ecriture').AsString,i,ObjReglement1.piece.tiers,DMPointage2.TaResteDCReglement.findfield('ComptePiece').AsString,
              DMPointage2.TaResteDCReglement.findfield('Libelle').AsString,(DMPointage2.TaResteDCReglement.findfield('Sens').Asstring='C'),
              DMPointage2.TaResteDCReglement.findfield('TotalReglement').AsString,Imputation,DMPointage2.TaResteDCReglement.findfield('Date').AsString,
              DMPointage2.TaResteDCReglement.findfield('Date').AsString,(InfoResteDCSurCompte.NBLignePointee<>0),
              InfoResteDCSurCompte.NBLignePointee,
              DMPointage2.TaResteDCReglement.findfield('Reste').AsCurrency,
              DMPointage2.TaResteDCReglement.findfield('Reste').AsCurrency,
              (DMPointage2.TaResteDCReglement.findfield('Sens').Asstring='C'),
              ((VerifFNumeric(DMPointage2.TaResteDCReglement.findfield('AutrePointage')).VideOUZero)and(not InfosVerrouillage.PieceVerrouillee)and(not ObjReglement1.Piece.InfosVerrouillage.PieceVerrouillee)),
              false,false,InfosVerrouillage.PieceVerrouillee,imputation],false,i,ListeReglement);
              (ListeReglement.Objects[i]as TReglementList).InfosVerrouillage:=InfosVerrouillage;
              ListeReglementPointable.Add(DMPointage2.TaResteDCReglement.findfield('Reference').AsString);
              inc(i);
              DMPointage2.TaResteDCReglement.next;
                         end;//fin du while
            GrReglement.row:=1;
            lignecurr:=GrReglement.row;
            AfficheLigneBas(lignecurr,true);
       //     GrReglement.col:=1;
         //   GrReglement.NewColonne:=1;
        end; //fin si on veut travailler sur plusieurs pieces de réglements trouvées
        
//////////**************** A conserver si on gére le f1 sur reference ******************
//     else
//        Begin//si on rajoute une seule ligne
//          if DMPointage.QuLigneBanqueTiersEnCours.Locate('Reference',reference,[])then
//             begin//si on trouve la reference dans la query
//              DMPieces.Piece1.InitialiseInfosVerrouillage(InfosVerrouillage);
//              InfosVerrouillage:=DMPieces.Piece1.RetourneInfosVerrouillageSurPiece(nil,DMPointage.QuLigneBanqueTiersEnCoursId_Piece.AsInteger,DMPointage.QuLigneBanqueTiersEnCoursDate.AsDateTime);
//              GrReglement.Cells[1,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursComptePiece.AsString;
//              GrReglement.Cells[2,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursReference.AsString;
//              GrReglement.Cells[3,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursDate.AsString;
//              GrReglement.Cells[4,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursLibelle.AsString;
//              GrReglement.Cells[5,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursTotalReglement.AsString;
//              GrReglement.Cells[6,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursPointages.AsString;
//              GrReglement.Cells[7,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursResteAPointer.AsString;
//              if VerifFNumeric(DMPointage.QuLigneBanqueTiersEnCoursMontantImputationCredit).VideOUZero then
//              Imputation:=DMPointage.QuLigneBanqueTiersEnCoursMontantImputationDebit.AsCurrency
//              else
//              Imputation:=DMPointage.QuLigneBanqueTiersEnCoursMontantImputationCredit.AsCurrency;
//              GrReglement.Cells[8,Ligne]:=currtostr(Imputation);
//              conteneur.InfosReste.ResteInitial:=conteneur.InfosReste.ResteInitial+imputation;
//              ListReglementAdd_Insert([false,DMPointage.QuLigneBanqueTiersEnCoursId_Piece.AsString,
//              DMPointage.QuLigneBanqueTiersEnCoursReference.AsString,DMPointage.QuLigneBanqueTiersEnCoursJournal.AsString,
//              copy(DMPointage.QuLigneBanqueTiersEnCoursReference.AsString,1,2),0,
//              DMPointage.QuLigneBanqueTiersEnCoursID.AsString,Ligne,ObjReglement1.piece.tiers,DMPointage.QuLigneBanqueTiersEnCoursComptePiece.AsString,
//              DMPointage.QuLigneBanqueTiersEnCoursLibelle.AsString,DMPointage.QueryRecupPointageSensReglement.AsBoolean,
//              DMPointage.QuLigneBanqueTiersEnCoursTotalReglement.AsString,Imputation,DMPointage.QuLigneBanqueTiersEnCoursDate.AsString,
//              DMPointage.QuLigneBanqueTiersEnCoursDate.AsString,DMPointage.QuLigneBanqueTiersEnCoursPointee.AsBoolean,
//              DMPointage.QuLigneBanqueTiersEnCoursNbLignePointee.AsInteger,
//              DMPointage.QuLigneBanqueTiersEnCoursPointages.AsCurrency+Imputation,
//              DMPointage.QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency,
//              DMPointage.QueryRecupPointageSensReglement.AsBoolean,
//              not(DMPointage.QuLigneBanqueTiersEnCoursPointee.AsBoolean),
//              false,false,InfosVerrouillage.PieceVerrouillee,imputation],true,Ligne,ListeReglement);
//              ListeReglementPointable.Add(DMPointage.QuLigneBanqueTiersEnCoursReference.AsString);
//              (ListeReglement.Objects[ligne]as TReglementList).InfosVerrouillage:=InfosVerrouillage;
//              GrReglement.row:=Ligne;
//              lignecurr:=GrReglement.row;
//     //         GrReglement.col:=1;
//     //         GrReglement.NewColonne:=1;
//             End//fin si on trouve la reference dans la query
//          else
//             abort;
//        end;//fin si on rajoute une seule ligne
   ObjReglement1.piece.InfosPointage:=conteneur;
  except
  showmessage('Problème lors de la récupération des réglements existants !!');
  abort;
  end;//fin du try
End;



procedure TSaisieReglements.GrReglementColExit(OldColonne,LastRow: Integer);
var
ctrlSaisieReglement:TErreurSaisie;
InplaceTmp:TInplaceEdit;
begin
try//finally
InplaceTmp:=TInplaceEdit.Create(self);
if GrReglement.EtatGrille in [dsinsert,dsEdit] then
  begin
   if not GrReglement.LigneVide(lignecurr)then
   begin
   if GrReglement.inplaceEditor<>nil then
     begin
       if GrReglement.inplaceEditor.Visible then
         InplaceTmp.Text:=GrReglement.inplaceEditor.Text
       else
         InplaceTmp.Text:=GrReglement.cells[GrReglement.OldColonne,LastRow];
     end
   else
     InplaceTmp.Text:=GrReglement.cells[GrReglement.OldColonne,LastRow];
   ctrlSaisieReglement:=CtrlSaisiePieceReglement(InplaceTmp,GrReglement.OldColonne,GrReglement.NewColonne);
        if  ctrlSaisieReglement.retour=false then
          case ctrlSaisieReglement.CodeErreur of
          1001,1002:begin //compte vide
               abort;
               end;
          2002,2003:begin //Référence pas correct
               abort;
               end;
          3002:begin //erreur de date
               abort;
               end;
          4001:begin //Libelle vide
               abort;
               end;
          5001:begin //Montant vide
               abort;
               end;
     8001,8002,
          8003:begin //Imputation pas correcte
               abort;
               end;
          end;//fin du case codeErreur
   //si le réglement existe déjà et que son montant à changé, on récupère les nouvelles
   //infos pointages
    if OldColonne in [1] then
      DernierCompteSaisi := GrReglement.cells[GrReglement.OldColonne,LastRow];
   end;//fin si ligne pas vide
 end;//fin si grille en insertion ou edition
finally
LibereObjet(TObject(InplaceTmp),Self);
end;//fin du try finally
end;

procedure TSaisieReglements.GrReglementRowValidate(Sender: TObject;
  var Valide, Action: Boolean; LastCol: Integer);
var
ctrlSaisieReglement:TErreurSaisie;
i:integer;
InplaceTmp:TInplaceEdit;
begin
try
InplaceTmp:=TInplaceEdit.Create(self);
for i:=1 to GrReglement.ColCount-1 do
if not GrReglement.lignevide(lignecurr)then
   begin
      begin//début boucle for
      if ((GrReglement.col = i)and(GrReglement.InplaceEditor<>nil)) then
        begin
          if GrReglement.inplaceEditor.Visible then
            InplaceTmp.Text:=GrReglement.inplaceEditor.Text
          else
            InplaceTmp.Text:=GrReglement.cells[i,ligneCurr];
        end
       else
        InplaceTmp.Text:=GrReglement.cells[i,ligneCurr];
      ctrlSaisieReglement:=CtrlSaisiePieceReglement(InplaceTmp,i,i+1);
         if  ctrlSaisieReglement.retour=false then
           case ctrlSaisieReglement.CodeErreur of
           1001,1002:begin //compte vide
                abort;
                end;
           2002,2003:begin //Référence pas correct
                abort;
                end;
           3002:begin //erreur de date
                abort;
                end;
           4001:begin //Libelle vide
                abort;
                end;
           5001:begin //Montant vide
                abort;
                end;
      8001,8002,
           8003:begin //Imputation pas correcte
                abort;
                end;
           end;//fin du case codeErreur
      end;//fin de la boucle for
    MessDerSub:=true;
   end;//fin si ligne pas vide
finally
LibereObjet(TObject(InplaceTmp),Self);
end;
end;

procedure TSaisieReglements.GrReglementSupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
var
QueryTmp:TQuery;
conteneur:TPointage;
begin
  try
  QueryTmp:=TQuery.Create(self);
  QueryTmp.DatabaseName:=ObjReglement1.TableEcriture.DatabaseName;
     //recalcul les infos pointages de la pièce appelante
     ObjReglement1.piece.InitialiseInfosPointage(conteneur);
     conteneur.infosPointage:=DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr(ObjReglement1.piece.IDContrepartie),ObjReglement1.piece.Sens,true,false,-1);
       if conteneur.infosPointage.Pointee then
         begin
         if not empty(ObjReglement1.piece.tiers)then
         conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(ObjReglement1.piece.IDContrepartie,ObjReglement1.piece.Tiers)
         else
         conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(ObjReglement1.piece.IDContrepartie,ObjReglement1.piece.compte);
         end
       else
         begin
           conteneur.InfosReste.reste:=ObjReglement1.piece.MontantPourReglement;
           conteneur.InfosReste.resteInitial:=0;
         end;
     conteneur.InfosReste.ResteInitial:=CalculResteInitial;
     ObjReglement1.piece.InfosPointage:=conteneur;
  //Raffraichir l'affichage du reste à pointer de la pièce initiale
  AfficheLigneBas(NewRow,true);
  finally
LibereObjet(TObject(QueryTmp),Self);
//  if QueryTmp<>nil then
//    QueryTmp.Free
  end;//fin du try finally
end;

procedure TSaisieReglements.GrReglementColEnter(OldColonne,NewColonne,NewRow: Integer);
var
conteneur:integer;
resteTmp:currency;
begin
ligneCourante:=GrReglement.Rows[NewRow].text;
lignecurr:=newrow;
Modif.ModifAutomatique:=false;
   if ((GrReglement.NewColonne in [6,7])or (((GrReglement.NewColonne=5)and(not((ListeReglement.Objects[NewRow]as TReglementList).Modifiable)))))then //si colonne Autres pointages ou reste à pointer
      begin // si colonne (pointee ou reste) ou (Montant Réglement,et colonne non modifiable)
      GrReglement.OnColEnter:=nil;
      GrReglement.OnColExit:=nil;
      case GrReglement.newcolonne of
         5..7:begin
                if GrReglement.col<GrReglement.newcolonne then
                  begin
                  GrReglement.oldcolonne:=8;
                  GrReglement.Col:=8;
                  end
                else
                 begin
                  if not((ListeReglement.Objects[NewRow]as TReglementList).Modifiable)then
                    Begin
                    GrReglement.oldcolonne:=4;
                    GrReglement.Col:=4;
                    End
                  else
                    Begin
                    GrReglement.oldcolonne:=5;
                    GrReglement.Col:=5;
                    End;
                 end;
              end;
         8:begin
             if not((ListeReglement.Objects[NewRow]as TReglementList).Modifiable)then
               Begin
               GrReglement.oldcolonne:=4;
               GrReglement.Col:=4;
               End
             else
               Begin
               GrReglement.oldcolonne:=5;
               GrReglement.Col:=5;
               End;
           end;
      end;
      GrReglement.OnColEnter:=GrReglementColEnter;
      GrReglement.OnColExit:=GrReglementColExit;
      //lignecurr:=newrow;
      abort;
      end;

  case GrReglement.col of
  8:Begin
     AfficheLigneBas(NewRow,true);
      if VerifNumeric(grreglement.Cells[8,NewRow]).VideOUZero then
         begin
         grReglement.EtatGrille:=dsedit;
         resteTmp:=(ListeReglement.Objects[NewRow]as TReglementList).Reste;
         if not VerifNumeric(grReglement.Cells[5,NewRow]).VideOUZero then
           begin
           modif.ModifAutomatique:=true;
             if (ListeReglement.Objects[NewRow]as TReglementList).Reste<ResteARegler then
               grreglement.Cellsgr(8,NewRow,currtostr((ListeReglement.Objects[NewRow]as TReglementList).Reste))
             else
               grreglement.Cellsgr(8,NewRow,currtostr(ResteARegler));
           modif.ModifAutomatique:=true;
           GrReglement.Cellsgr(7,NewRow,currtostr((ListeReglement.Objects[NewRow]as TReglementList).montant - StrToCurr_Lgr(GrReglement.Cells[8,NewRow]) -StrToCurr_Lgr(GrReglement.Cells[6,NewRow])));
           end
         else
             grreglement.Cellsgr(8,NewRow,'');
         end;
    End;
end;
end;



//Calcul le total de la colonne des Imputations
function TSaisieReglements.CalculTotalColonneImputation:currency;
var
i:integer;
Begin
result:=0;
   for i:=1 to GrReglement.RowCount-1 do
   begin
     if not empty(GrReglement.cells[8,i])then
     result:=result+StrToCurr_Lgr(GrReglement.cells[8,i]);
   end;
End;



function TSaisieReglements.CalculResteARegler(Infos:TPointage;MontantPiece:currency):currency;

//Début du corp de la procédure calcul du reste à régler
var
TotalColonne:currency;
conteneur:TPointage;
Begin
TotalColonne:=0;
     //si la pièce est déjà en partie pointée, on récupère le reste pour calculer le reste A Régler
       TotalColonne:=CalculTotalColonneImputation;
       if infos.infosPointage.Pointee then
         result:=MontantPiece-(MontantPiece-Infos.InfosReste.Reste-Infos.InfosReste.ResteInitial)-TotalColonne
       else
         result:=MontantPiece-TotalColonne;
End;


procedure TSaisieReglements.PrepaAffichageSurOption(Option:integer;InitGrille:boolean);
var
conteneur:TPointage;
sens:string;
InfoResteDCSurCompte:TInfoResteDCSurCompte;
i:integer;
Begin
//if ListeReglementPointable<>nil then
Initialise_TStringlist(ListeReglementPointable,SaisieReglements,false);

GrReglement.OnColExit:=nil;
GrReglement.OnRowValidate:=nil;
  GrReglement.RowCount:=2;
  GrReglement.Rows[1].Clear;

  for i:=0 to ListeReglement.count-1 do
    begin
    if ListeReglement.Objects[i]<>nil then
       begin
         ListeReglement.Objects[i].Free;
         ListeReglement.Objects[i]:=nil;
       end;
//    ListeReglement.clear;
    end;
  initialise_Tstringlist(ListeReglement,SaisieReglements,false);

  conteneur:=ObjReglement1.piece.InfosPointage;
  conteneur.InfosReste.ResteInitial:=0;
  ObjReglement1.piece.InfosPointage:=conteneur;
  //rajoute deux lignes vides dans la liste des réglements
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,0,0,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true,false,0],true,-1,ListeReglement);
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,1,0,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true,false,0],true,-1,ListeReglement);
if ObjReglement1.piece.Sens then
sens:='C'
else
sens:='D';
  case option of
41,31:Begin //affichage vide
      End;//fin affichage vide
   42:Begin //récupérer tous les réglements concernant le tiers courant et qui soient encore pointables
        InfoResteDCSurCompte:=RecupPointagePourReglement(ObjReglement1.Piece.compte,sens,'',['4'],0,0,Option,ObjReglement1.Piece.IDContrepartie);
      End;//fin récupérer tous les réglements concernant le tiers courant et qui soient encore pointables
   43:Begin //récupérer tous les réglements concernant le tiers courant et déjà pointés
        InfoResteDCSurCompte:=RecupPointagePourReglement(ObjReglement1.Piece.compte,sens,'',['4'],0,0,Option,ObjReglement1.Piece.IDContrepartie);
      End;//fin récupérer tous les réglements concernant le tiers courant et déjà pointés
   32:Begin //récupérer toutes les OD concernant le tiers courant et qui soient encore pointables
//        InfoResteDCSurCompte:=RecupPointagePourReglement(ObjReglement1.Piece.compte,sens,'',['1','2','3'],0,0,Option,ObjReglement1.Piece.IDContrepartie);
        InfoResteDCSurCompte:=RecupPointagePourReglement(ObjReglement1.Piece.compte,sens,'',['3'],0,0,Option,ObjReglement1.Piece.IDContrepartie);
      End;//fin récupérer toutes les OD concernant le tiers courant et qui soient encore pointables
   33:Begin //récupérer toutes les OD concernant le tiers courant et déjà pointés
//        InfoResteDCSurCompte:=RecupPointagePourReglement(ObjReglement1.Piece.compte,sens,'',['1','2','3'],0,0,Option,ObjReglement1.Piece.IDContrepartie);
        InfoResteDCSurCompte:=RecupPointagePourReglement(ObjReglement1.Piece.compte,sens,'',['3'],0,0,Option,ObjReglement1.Piece.IDContrepartie);
      End;//fin récupérer toutes les OD concernant le tiers courant et déjà pointés
  end;//fin du case Option
if ((DMPointage2.TaResteDCReglement.RecordCount<>0)and(InitGrille)) then
   Begin
      //afficher les lignes et récupérer les infos dans listeReglement
       ListeReglementPointable.Clear;
       if option in [42,43,32,33] then
       AffichagePieceReglementExistante(-1,'',InfoResteDCSurCompte);
   End;

GrReglement.OnColExit:=GrReglementColExit;
GrReglement.OnRowValidate:=GrReglementRowValidate;
ligneCourante:=GrReglement.Rows[LigneCurr].text;
End;


procedure TSaisieReglements.SBAucunClick(Sender: TObject);
begin
//PaLibelle.Color:=clRed;

//if ((Sender as TRxSpeedButton).Name<>SpeedButtonDown) then
     begin
//      (Sender as TRxSpeedButton).Down:=true;
//      if length(inttostr(option))=2then
//      delete(inttostr(option),2,1);
//      option:=inttostr(option)+inttostr((sender as Trxspeedbutton).Tag);
        option:=RecupOptionSurClickButton;
//      SpeedButtonDown:=(sender as TRxSpeedButton).Name;
      //Initialise la grille en fonction de l'option d'affichage récupérée
      PrepaAffichageSurOption(option,true);
      InitPaLibelle;
      AfficheLigneBas(lignecurr,true);
//      PaLibelle.Color:=$00808040;
     end;
end;

procedure TSaisieReglements.GrReglementBeforeColExit(NewColonne: Integer);
begin
if not GrReglement.lignevide(lignecurr)then
   begin
     if GrReglement.Champ.Items[GrReglement.oldcolonne] = Grcurr then
     begin
       if empty(GrReglement.Cells[GrReglement.oldcolonne,LigneCurr])then
         GrReglement.Cells[GrReglement.oldcolonne,LigneCurr]:='0';
     end;
   end;
end;

procedure TSaisieReglements.GrReglementKeyPress(Sender: TObject;
  var Key: Char);
var
IndexTmp:integer;
LastRef,NewRef:string;
trouve:boolean;
KeyTmp:word;
begin

////si piece existante (OD) sans compte de contrepartie fixe, pas de modif possible
//à part l'imputation

if GrReglement.col=2 then
   Begin
   if key<>#13 then
      key:=#0;
   end;
if ((GrReglement.col in [1,3,4,5,6,7])and((ListeReglement.Objects[ligneCurr]as TReglementList).CompteModifiable=false)) then
   Begin
   if key<>#13 then
      key:=#0;
   end;

if ((GrReglement.col=1)and(key='*')) then
   Begin
      GrReglement.cells[1,ligneCurr]:=DernierCompteSaisi;
      key:=#0;
   End;



end;

procedure TSaisieReglements.GrReglementBeforeNewLigne(sender: TObject;
  Arow: Integer);
begin
//rajoute une ligne vide dans la liste des réglements
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,0,Arow,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true,false,0],false,Arow,ListeReglement);

//GrReglement.col:=1;
//GrReglement.NewColonne:=1;
end;

procedure TSaisieReglements.Annuler1Click(Sender: TObject);
begin
////
ModalResult:= mrCancel;
end;

procedure TSaisieReglements.Modifier1Click(Sender: TObject);
begin
////
end;

procedure TSaisieReglements.Supprimer1Click(Sender: TObject);
begin
GrReglement.SupprimeLigne(ligneCurr);
AfficheLigneBas(ligneCurr,true);
end;

procedure TSaisieReglements.Aideenligne1Click(Sender: TObject);
begin
////
end;

procedure TSaisieReglements.Visualisation1Click(Sender: TObject);
var
affich:boolean;
begin
try
affich:=grReglement.col<>2;
if length(grReglement.Cells[1,grReglement.Row]) > 0 then
 begin
   if copy(grReglement.Cells[1,grReglement.Row],1,1)<>'+' then
      begin
        if DetailEcritureCompte(grReglement.Cells[1,grReglement.Row],affich,true)then
        case grReglement.col of
          2:  Begin//si
                 case DetailEcr.Tag of
                    2:begin
                        if DMEcritures.QueryEcrCompte.Locate('ID_Piece',(ListeReglement.Objects[grReglement.Row]as TReglementList).IDPiece,[]) then
                          PieceEcritureCompte;
                      end;
                 end;//fin du case
              End;//fin si
        end;//fin du case col
      end
   else
      Begin
        if DetailEcritureTiers(grReglement.Cells[1,grReglement.Row],affich)then
        case grReglement.col of
          2:  Begin//si
                 case DetailEcr.Tag of
                    1:begin
                        if DMEcritures.QueryEcrTiers.Locate('ID_Piece',(ListeReglement.Objects[grReglement.Row]as TReglementList).IDPiece,[]) then
                          PieceEcritureTiers;
                      end;
                 end;//fin du case
              End;//fin si
        end;//fin du case col
      End;
 end;
finally
  //
end;
end;

procedure TSaisieReglements.Imprimer1Click(Sender: TObject);
begin
/////
end;

procedure TSaisieReglements.Enregister1Click(Sender: TObject);
var
Valide:boolean;
begin
Valide:=true;
grReglementRowValidate(grReglement,Valide,Valide,1);
ModalResult:= mrOk;
end;

procedure TSaisieReglements.GrReglementBeforeSupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
var
rang:integer;
QueryTmp:TQuery;
conteneur:TPointage;
begin
RefSupp:='';
rang:=-1;
     try //except
     if (((((ListeReglement.Objects[Arow]as TReglementList).InfosVerrouillage.PieceVerrouillee)and(not (ListeReglement.Objects[Arow]as TReglementList).InfosVerrouillage.Deverrouillable)))or(not (ListeReglement.Objects[Arow]as TReglementList).Modifiable)) then
       begin
         showmessage('Cette pièce n''est pas supprimable dans ce contexte');
         abort; //si pièce verrouillée ou non modifiable, on ne peut pas la supprimer
       end
     else
     Begin
        if not (ListeReglement.Objects[Arow]as TReglementList).Vide then
        begin
        if Application.MessageBox(Pchar('Attention, si vous choisissez de Supprimer cette pièce, les pointages associés seront supprimés, Confirmez-vous votre choix !'),'Suppression Pièce',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
          begin
          RefSupp:=DMPieces.SuppressionPieceEcriture(GrReglement.cells[2,Arow],ObjReglement1.Piece);
          RefSupp:=GrReglement.cells[2,Arow];
          end
          else
          abort;
        end;

     ListeReglement.Delete(Arow);
     rang:=ListeReglementPointable.IndexOf(RefSupp);
     if rang<>-1 then
     //corrige la liste des réglements pointables avec la pièce appelante en vue de l'affichage
     //de la fenêtre de recherche
     ListeReglementPointable.Delete(rang);

     rang:=listeNewReference.IndexOf(grreglement.cells[2,arow]);
     if rang<>-1 then
     listeNewReference.Delete(rang);

     if ((arow=1)and (arow=GrReglement.RowCount-1))then
     //rajoute une ligne vide dans la liste des réglements
        ListReglementAdd_Insert([true,-1,'',-1,'',-1,0,Arow,'','','',false,
        0,0,'','',false,0,0,0,false,true,false,true,false,0],false,Arow,ListeReglement);
     End;
   except
    abort;
   end;//fin du try except
end;


procedure VisuListeShowMessage(Liste:Tstringlist;indexRang:integer;const indexChamp:array of integer);
var
i:integer;
begin
  for i:=0 to high(indexChamp)do
  Begin
      case indexChamp[i] of
      0:showmessage(booltostr((Liste.Objects[indexRang]as TReglementList). Vide));
      1:showmessage(inttostr((Liste.Objects[indexRang]as TReglementList).IDPiece));
      2:showmessage((Liste.Objects[indexRang]as TReglementList).Reference);
      3:showmessage(inttostr((Liste.Objects[indexRang]as TReglementList).IDJournal));
      4:showmessage(inttostr((Liste.Objects[indexRang]as TReglementList).ID_Org));
      5:showmessage(inttostr((Liste.Objects[indexRang]as TReglementList).ID_Tmp));
      6:showmessage((Liste.Objects[indexRang]as TReglementList).Tiers);
      7:showmessage((Liste.Objects[indexRang]as TReglementList).Compte);
      8:showmessage((Liste.Objects[indexRang]as TReglementList).Libelle);
      9:showmessage(booltostr((Liste.Objects[indexRang]as TReglementList).Sens));
     10:showmessage(currtostr((Liste.Objects[indexRang]as TReglementList).montant));
     11:showmessage(currtostr((Liste.Objects[indexRang]as TReglementList).Imputation));
     12:showmessage((Liste.Objects[indexRang]as TReglementList).date);
     13:showmessage((Liste.Objects[indexRang]as TReglementList).TvaDate);
     14:showmessage(booltostr((Liste.Objects[indexRang]as TReglementList).Pointee));
     15:showmessage(inttostr((Liste.Objects[indexRang]as TReglementList).NbLignePointee));
     16:showmessage(currtostr((Liste.Objects[indexRang]as TReglementList).Reste));
     17:showmessage(booltostr((Liste.Objects[indexRang]as TReglementList).SensReste));
     18:showmessage(booltostr((Liste.Objects[indexRang]as TReglementList).Modifiable));
     19:showmessage(currtostr((Liste.Objects[indexRang]as TReglementList).ResteAAfficher));
     20:showmessage(booltostr((Liste.Objects[indexRang]as TReglementList).PieceModifiee));
     21:showmessage(inttostr((Liste.Objects[indexRang]as TReglementList).IDContrepartie));
     end;//fin du case
  End;

end;


//function TSaisieReglements.gestionDerniereReference(Journal:string;Piece:Tpiece;ListeReference:Tstringlist):string;
//Var
//valeurtmp:TReference;
//ValeurNew:string;
//begin
//// PB 27/07/02
//ValeurNew:= Piece.NewReference(Piece.TablePiece,'Reference',Journal,E.ExerciceSaisie,Piece.Reference);
////ValeurNew:= ObjReglement1.Piece.NewReference(ObjReglement1.Piece.TablePiece,'Reference',Journal,ObjReglement1.Piece.CodeExo,ObjReglement1.Piece.Reference);
//if ListeReference.Count<>0 then
//begin
//  if ListeReference.IndexOf(ValeurNew)<>-1 then
//  begin
//    valeurtmp:=MaxReferenceDansListe(journal,1,2,ListeReference);
//    if valeurtmp.retour then
//      begin
////  PB 27/07/02
////      valeurtmp:=New_Reference_Epicea(valeurtmp.Reference,Journal,ObjReglement1.Piece.CodeExo);
//      valeurtmp:=New_Reference_Epicea(valeurtmp.Reference,Journal,E.ExerciceSaisie);
//      if valeurtmp.retour then
//         result:= valeurtmp.Reference;
//      end;
//  end
//  else
//  result:=ValeurNew;
//end
//else
//result:=ValeurNew;
//
//end;


procedure TSaisieReglements.paGrilleResize(Sender: TObject);
begin
GrReglement.ColWidths[0]:=10;
GrReglement.ColWidths[1]:=(GrReglement.Width) div 9;
GrReglement.ColWidths[2]:=(GrReglement.Width) div 9;
GrReglement.ColWidths[3]:=(GrReglement.Width) div 12;
GrReglement.ColWidths[4]:=(GrReglement.Width) div 3;
GrReglement.ColWidths[5]:=(GrReglement.Width) div 12;
//GrReglement.ColWidths[6]:=0;
GrReglement.ColWidths[6]:=(GrReglement.Width) div 12;
GrReglement.ColWidths[7]:=(GrReglement.Width) div 12;
GrReglement.ColWidths[8]:=(GrReglement.Width) div 12;
end;

procedure TSaisieReglements.GrReglementRowEnter(sender: TObject;
  NewRow: Integer);
begin
try
ligneCurr:=NewRow;
ligneCourante:=GrReglement.Rows[NewRow].text;
  if (GrReglement.Oldcolonne=GrReglement.NewColonne) then
    begin
      GrReglementColEnter(GrReglement.oldcolonne,GrReglement.NewColonne,NewRow);
    end;
AfficheLigneBas(NewRow,true);
except

end;
end;

procedure TSaisieReglements.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//if DMPointage2.QueryRecupPointage.Active=true then
//   DMPointage2.QueryRecupPointage.close;
//if dmpointage2.QuLigneBanqueTiersEnCours.Active=true then
//   dmpointage2.QuLigneBanqueTiersEnCours.close;

if dmpointage2.QuSumPointageCredit.Active=true then
   dmpointage2.QuSumPointageCredit.close;
if dmpointage2.QuSumPointageDebit.Active=true then
   dmpointage2.QuSumPointageDebit.close;
if grReglement.InplaceEditor <> nil
 then grReglement.InplaceEditor.Hide;
end;



function TSaisieReglements.RecupOptionSurClickButton:integer;
Begin
result:=0;
  if SBReglement.Down then
     Begin
        if SBAucun.Down then
          result:=41
          else
          if SBPointables.Down then
             result:=42
            else
              if SBDejaPointes.Down then
                 result:=43;
     End
  else
    if SBAutres.Down then
     Begin
        if SBAucun.Down then
          result:=31
          else
          if SBPointables.Down then
             result:=32
            else
              if SBDejaPointes.Down then
                 result:=33;
     End;
if result=0 then
result:=41; 
End;


function TSaisieReglements.ListReglementIndexOf(valeur:string;valeurRech:integer):integer;
var
i:integer;
Begin
result:=-1;
i:=0;
   while i<= ListeReglement.Count-1 do
   begin
     case valeurRech of
     2: if (ListeReglement.Objects[i]as TReglementList).Reference=valeur then
        begin
        result:=i;
        i:=ListeReglement.Count-1;
        end;
     end;//fin du case
   inc(i);
   end;
end;

procedure TSaisieReglements.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
i:integer;
begin
CanClose:=true;
if ((ModifReglement)and(self.ModalResult<>mrok)) then
  Begin//si modification ou création d'un réglement
    If Application.messagebox(PChar('Voulez-vous annuler les modifications en cours ?' ),'Attention',MB_ICONWARNING+MB_YESNO + MB_DEFBUTTON1) = IDNo then
      canclose:=false
    else
      ModifReglement:=false;
  End;//fin si modification ou création d'un réglement
if CanClose then
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);
 end;
end;

Procedure TSaisieReglements.InitPaLibelle;
begin
PaLibelle.Caption:='';
if SBReglement.Down
  then
     PaLibelle.Caption:=SBReglement.Caption+' '
  else
     PaLibelle.Caption:=SBAutres.Caption+' ';
if SBAucun.Down then PaLibelle.Caption:=PaLibelle.Caption + SBAucun.Caption;
if SBPointables.Down then PaLibelle.Caption:=PaLibelle.Caption + SBPointables.Caption;
if SBDejaPointes.Down then PaLibelle.Caption:=PaLibelle.Caption + SBDejaPointes.Caption;
end;


procedure TSaisieReglements.FormShow(Sender: TObject);
//var
//QueryTmp:TQuery;
//conteneur:TPointage;
begin
//try
//  ObjReglement1.Piece:=DMPieces.Piece1;
  CopieContenuPiece(DMPieces.Piece1,ObjReglement1.Piece);
  ligneCurr:=1;
  etatinitial;
  

grReglement.ParamColor:=true;
grReglement.Param:=ParamUtil.CouleurDBGrid;
grReglement.UpDateColor;

Patitre.visible:=Main.AfficheTitre;

     dmpointage2.QuSumPointageCredit.close;
     dmpointage2.QuSumPointageCredit.open;
     dmpointage2.QuSumPointageDebit.close;
     dmpointage2.QuSumPointageDebit.open;
  //Initialise la grille en fonction de l'option d'affichage récupérée

  PrepaAffichageSurOption(option,true);
  InitPaLibelle;
  ////***Récupérer les paramètres de la pièce appelante pour afficher le reste à régler
  //et autres informations


  if ObjReglement1.Piece.SensPourReglement then
  grReglement.Rows[0].CommaText:=SaisieReglementGrReglementCommaTextCredit
  else
  grReglement.Rows[0].CommaText:=SaisieReglementGrReglementCommaTextDebit;
  DerniereRef:='';
  AfficheLigneBas(lignecurr,true);
  GrReglement.setfocus;
  DernierCompteSaisi:=E.CompteBanqueDefaut;
  grReglement.Cells[1,lignecurr]:=DernierCompteSaisi;
  GrReglement.EtatGrille:=dsInsert;
  GrReglement.Col:=1;
end;

procedure TSaisieReglements.grReglementKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ((shift=[ssShift,ssCtrl])or(key=46)) then
  key:=0;
end;


function TSaisieReglements.CalculResteInitial:currency;
var
i:integer;
Begin
result:=0;
   for i:=1 to ListeReglement.Count-1 do
   begin
     if (ListeReglement.Objects[i]as TReglementList).ResteInitial<>0 then
       result:=result+(ListeReglement.Objects[i]as TReglementList).ResteInitial;
   end;
End;

procedure TSaisieReglements.grReglementChange(Sender: TObject);
var
conteneurVerrou:TVerrouillage;
begin
  try//finally
     try //except
     if ObjReglement1.Piece.TypeTvaE then
        begin //si pièce appelante comporte de la tva sur encaissement
          case grReglement.Col of
          8:begin//si colonne imputation
            if (ListeReglement.Objects[LigneCurr]as TReglementList).InfosVerrouillage.PeriodeVerrouillee then
              begin //si pièce verrouillée
                if not (ListeReglement.Objects[LigneCurr]as TReglementList).InfosVerrouillage.PeriodeDeverrouillable then
                  Begin //si  non déverouillable
                    if not modif.ModifAutomatique then
                      showmessage('cette pièce fait partie d''une période de TVA déclarée et verrouillée, vous ne pouvez donc pas modifier l''imputation avec une pièce comprenant une part de TVA déclarable à l''encaissement !!');
                    abort;
                  End//fin si non déverrouillable
                else
                  Begin//si deverrouillable
                     if not modif.ModifAutomatique then
                       begin
                       if Application.MessageBox(Pchar('Attention, cette pièce fait partie d''une période de TVA déclarée , si vous la modifiez, la dernière déclaration de TVA sera annulée et l''OD de cette déclaration sera supprimée ! Voulez-vous la conserver ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
                         abort
                       else
                         begin
                          //supprimer l'OD de déclaration et les lignes de la période déclarée et déverrouiller la période
                          if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,true,false).retour then
                             abort;
                          conteneurVerrou:=ObjReglement1.Piece.RetourneInfosVerrouillageSurPiece(nil,(ListeReglement.Objects[LigneCurr]as TReglementList).IDPiece,StrToDate_Lgr(grReglement.cells[3,lignecurr]));
                        (ListeReglement.Objects[LigneCurr]as TReglementList).InfosVerrouillage:=conteneurVerrou;
                         end;
                       end
                     else
                       abort;
                  End;//fin si deverrouillable
              end;//fin si pièce verrouillée
            end;//fin si colonne imputation
          end;//fin du case col
        end;//fin si pièce appelante comporte de la tva sur encaissement
     except
      grReglement.Cells[8,lignecurr]:=currtostr((ListeReglement.Objects[LigneCurr]as TReglementList).Imputation);
      abort;
     end;//fin du try except
  finally
    Modif.ModifAutomatique:=false;
  end;//fin du try finally
end;


procedure TSaisieReglements.grReglementSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
//
end;

procedure TSaisieReglements.grReglementStateChange(
  EtatGrille: TDataSetState);
begin
//     if EtatGrille in [dsinsert,dsedit] then
//       Begin//si on rentre en insertion sur une nouvelle ligne
//         if grReglement.LigneVide(lignecurr) then
//           begin
//              grReglement.cells[grReglement.col,lignecurr]:='';
//              grReglement.col:=1;
////              abort;
//           end;
//       End;//fin si on rentre en insertion sur une nouvelle ligne
end;


//procedure TSaisieReglements.EnregistrementReglement(fenetreAppelante:TComponent;var ListePointage:Tstringlist);
//var
//rang:integer;
//PieceReglement:TPiece;
//EcritureReglement:TEcriture_Isa;
//QueryTmp:TQuery;
//tab:variant;
//IDPointage:integer;
//TotalDebit,TotalCredit:currency;
//begin
//QueryTmp:=TQuery.create(fenetreAppelante);
//QueryTmp.DataBaseName:=DMPointage2.TaPointage.DatabaseName;
//totaldebit:=0;
//totalcredit:=0;
//
//   for rang:=1 to SaisieReglements.ListeReglement.Count-1 do
//   Begin// début boucle sur la liste des réglements éventuels
//     if not(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).vide then
//       begin//si la ligne de réglement n'est pas vide
//       PieceReglement:=TPiece.Create(fenetreAppelante);
//       PieceReglement.NouvellePiece(false);
//       EcritureReglement:=TEcriture_Isa.Create(fenetreAppelante);
//       EcritureReglement.Piece:=PieceReglement;
//         if (SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ID_Org<>-1 then
//         Begin//si le réglement existe déjà ,on ne crée pas la pièce de réglement
//         //si l'imputation a été modifiée, on supprime le pointage et on le recré
//           if (SaisieReglements.ListeReglement.Objects[rang]as TReglementList).PieceModifiee then
//           Begin//si la pièce a été modifiée
////            DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr((listeReglements.Objects[rang]as TReglementList).IDContrepartie),
////            not DMPieces.Piece1.SensPourReglement,false,true,DMPieces.Piece1.IDContrepartie);
//            DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).IDContrepartie),
//            not DMPieces.Piece1.SensPourReglement,true,true,DMPieces.Piece1.IDContrepartie);
//            IF QueryTmp.Recordcount<>0 then
//            DMPointage2.SupprimePointageSurEcriture(QueryTmp,SaisieReglements.ListeReglement,rang);
//            if (SaisieReglements.ListeReglement.Objects[rang]as TReglementList).imputation<>0then
//               begin//s'il y a une imputation
//               Tab:=VarArrayCreate([0,4],varVariant);
//               //récupérer tous les paramétres nécessaire pour créer le pointage
//               //et recréer le reste de chaque idEcriture du pointage
//                 if DMPieces.Piece1.SensPourReglement then
//                   begin //si la pièce appelante est au crédit
//                   tab[0]:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).IDContrepartie;
//                   tab[1]:=DMPieces.Piece1.IDContrepartie;
//                   tab[2]:=DMPieces.Piece1.DateSaisie;;
//                   tab[4]:=StrToDate_Lgr((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).TvaDate)
//                   end //fin si la pièce appelante est au crédit
//                 else
//                   Begin //si la pièce appelante est au débit
//                   tab[0]:=DMPieces.Piece1.IDContrepartie;
//                   tab[1]:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).IDContrepartie;
//                   tab[2]:=StrToDate_Lgr((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Date);
//                   tab[4]:=DMPieces.Piece1.DateSaisie;
//                   End;//fin si la pièce appelante est au débit
//               tab[3]:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).imputation;
//               if not empty(DMPieces.Piece1.tiers)then
//               IDPointage:=CreationPointageSurIDEcriture(tab,DMPieces.Piece1.Tiers,true)
//               else
//               IDPointage:=CreationPointageSurIDEcriture(tab,DMPieces.Piece1.compteplan,true);
//               if IDPointage<>-1 then
//                  ListePointages.Add(inttostr(IDPointage));
//               Tab:=Unassigned;
//               end;//fin s'il y a une imputation
//           End;//fin si la pièce a été modifiée
//         End//fin si le réglement existe déjà
//         else
//         Begin //si le réglement n'existe pas, on doit créer la pièce de réglement
//         //et ses écritures, puis créer le pointages et le reste de chaque ligne d'écriture créées
//         //1)Récupérer tous les paramètres pièce et écriture de chaque réglement, puis
//         //créer les lignes d'écriture dans table temporaire
//         (PieceReglement as Tpiece).CodeExo:=DMPieces.Piece1.CodeExo;
//         (PieceReglement as Tpiece).DateDebutExo:=DMPieces.Piece1.DateDebutExo;
//         (PieceReglement as Tpiece).DateFinExo:=DMPieces.Piece1.DateFinExo;
//         (PieceReglement as Tpiece).FirstIDPiece:=(PieceReglement as Tpiece).NewIDPiece(DMPieces.TaPiece,'ID',true);
//         (PieceReglement as Tpiece).Reference:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Reference;
//         (PieceReglement as Tpiece).Libelle:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Libelle;
//         if not empty((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Date)then
//         (PieceReglement as Tpiece).DateSaisie:=StrToDate_Lgr((SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Date)
//         else
//         (PieceReglement as Tpiece).DateSaisie:=DMPieces.Piece1.DateSaisie;
//         (PieceReglement as Tpiece).DateLivraison:=(PieceReglement as Tpiece).DateSaisie;
//         (PieceReglement as Tpiece).DateEcheance:=(PieceReglement as Tpiece).DateSaisie;
//         (PieceReglement as Tpiece).IDJournal:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).IDJournal;
//         (PieceReglement as Tpiece).Journal:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Journal;
//         (PieceReglement as Tpiece).Sens:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Sens;
//         (PieceReglement as Tpiece).Montant:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).montant;
//           (PieceReglement as Tpiece).Compte:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ContrePartieCompte;
//         (PieceReglement as Tpiece).ContrePartieTiers:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ContrePartieTiers;
//           (PieceReglement as Tpiece).ComptePlan:=DMPieces.Piece1.ComptePlan;
//         (PieceReglement as Tpiece).Tiers:=DMPieces.Piece1.Tiers;
//         (PieceReglement as Tpiece).IDContrepartie:=EcritureReglement.NewIDEcriture(DMEcritures.TaEcriture,'ID');
//         if (PieceReglement as Tpiece).Sens then
//            begin
//            TotalDebit:=0;
//            TotalCredit:=(PieceReglement as Tpiece).Montant;
//            end
//         else
//            Begin
//            TotalDebit:=(PieceReglement as Tpiece).Montant;
//            TotalCredit:=0;
//            End;
//         (EcritureReglement as TEcriture_Isa).FirstIDEcriture:=(PieceReglement as Tpiece).IDContrepartie+1;
//         (EcritureReglement as TEcriture_Isa).CompteEcriture:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ContrePartieCompte;
//         (EcritureReglement as TEcriture_Isa).TiersEcriture:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).ContrePartieTiers;
//         //2)déclencher la création réelle de la pièce et ses écritures + MAJ Balance
//         DMPieces.EnvoiePieceEcriture_SurListe(nil,EcritureReglement,TotalDebit,TotalCredit,true,dsinsert,false);
//         //3)Déclencher la création du pointage et le reste de chaque ligne d'écriture
//         if (SaisieReglements.ListeReglement.Objects[rang]as TReglementList).imputation<>0then
//            begin //s'il y a une imputation
//            Tab:=VarArrayCreate([0,4],varVariant);
//            //récupérer tous les paramétres nécessaire pour créer le pointage
//            //et recréer le reste de chaque idEcriture du pointage
//              if (PieceReglement as Tpiece).Sens then
//                begin //si la pièce appelante est au crédit
//                tab[0]:=(PieceReglement as Tpiece).IDContrepartie;
//                tab[1]:=DMPieces.Piece1.IDContrepartie;
//                tab[2]:=DMPieces.Piece1.DateSaisie;
//                tab[4]:=(PieceReglement as Tpiece).DateSaisie;
//                end //fin si la pièce appelante est au crédit
//              else
//                Begin //si la pièce appelante est au débit
//                tab[0]:=DMPieces.Piece1.IDContrepartie;
//                tab[1]:=(PieceReglement as Tpiece).IDContrepartie;
//                tab[2]:=(PieceReglement as Tpiece).DateSaisie;
//                tab[4]:=DMPieces.Piece1.DateSaisie;
//                End;//fin si la pièce appelante est au débit
//            tab[3]:=(SaisieReglements.ListeReglement.Objects[rang]as TReglementList).Imputation;
//
//            if not empty((PieceReglement as Tpiece).Tiers) then
//            IDPointage:=CreationPointageSurIDEcriture(tab,(PieceReglement as Tpiece).Tiers,true)
//            else
//            IDPointage:=CreationPointageSurIDEcriture(tab,(PieceReglement as Tpiece).Compteplan,true);
//            if IDPointage<>-1 then
//            ListePointage.Add(inttostr(IDPointage));
//            Tab:=Unassigned;
//            end;//fin s'il y a une imputation
//         End;
//       PieceReglement.Destroy;
//       EcritureReglement.Destroy;
//       end;//fin si la ligne de réglement n'est pas vide
//   End;// fin boucle sur la liste des réglements éventuels
//end;



Function SaisieReglementAffiche(ParamAfficheSaisieReglement:TParamAfficheSaisieReglement):boolean;
var
QueryTmp:TQuery;
conteneur:TPointage;
continue:boolean;
begin
try//finally
if SaisieReglements=nil then
SaisieReglements:=TSaisieReglements.Create(application.MainForm);

QueryTmp:=TQuery.create(application.MainForm);
QueryTmp.DataBaseName:=DMPointage2.TaPointage.DatabaseName;
QueryTmp.sql.Clear;


DMPieces.Piece1.InitialiseInfosPointage(conteneur);
conteneur.infosPointage:=DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr(DMPieces.Piece1.IDContrepartie),DMPieces.Piece1.Sens,true,false,-1);
if not empty(DMPieces.Piece1.tiers)then
  conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(DMPieces.Piece1.IDContrepartie,DMPieces.Piece1.Tiers)
else
  conteneur.InfosReste:=DMPointage2.CalculResteSurIDEcriture(DMPieces.Piece1.IDContrepartie,DMPieces.Piece1.compte);
DMPieces.Piece1.InfosPointage:=conteneur;
continue:= true;
if DMPieces.Piece1.InfosPointage.infosPointage.NbLignePointee<>0 then
continue:= Application.MessageBox(Pchar('Cette pièce est déjà réglée avec '+inttostr(DMPieces.Piece1.InfosPointage.infosPointage.NbLignePointee)+
   ' ligne(s),'+RetourChariotDouble+'Il reste à régler : '+currtostr(DMPieces.Piece1.InfosPointage.InfosReste.Reste)+' '+e.DeviseSigle+RetourChariotDouble+
   'Voulez-vous saisir un autre règlement ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=Mryes;
if continue then
  begin
    result:=SaisieReglements.ShowModal=MrOk;
  end;
finally
LibereObjet(TObject(QueryTmp));
//SaisieReglements.Free;
end;
end;


end.
