unit PiecesPointables;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Gr_Librairie_Obj, Buttons, ComCtrls, Grids, ExtCtrls,  GrGrid,
  Lib1,ObjReglement, Db, DBTables,Piece,DMPiece,LibSql,PickDate,
  LibRessourceString, RXCtrls,registry,E2_Recherche,
  LibZoneSaisie,E2_Decl_Records,referencement, jpeg;

type
  TPiecePointable = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaLibelle: TPanel;
    paGrille: TPanel;
    hcCompte: THeaderControl;
    grPiecePointable: TGrGrid;
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
    ObjReglement1: TObjReglement;
    PaBtnBas: TPanel;
    SBPointables: TRxSpeedButton;
    SBDejaPointes: TRxSpeedButton;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure grPiecePointableEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EtatInitial;
    function CtrlSaisiePieceReglement(edit:TCustomEdit;Acol,CelluleSuivante:integer):TErreurSaisie;
    procedure FormActivate(Sender: TObject);
    procedure GestionFiltrageParamCpt;
    procedure AffichagePieceReglementExistante(Ligne:integer;Reference:string);
    //function RecupInfosPointageSurRef(Reference,tiers:string;sens:boolean;FiltrerReste:boolean):TPointage;
    procedure grPiecePointableColExit(OldColonne,LastRow: Integer);
    procedure grPiecePointableRowValidate(Sender: TObject; var Valide,
      Action: Boolean; LastCol: Integer);
    procedure grPiecePointableSupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    Procedure AfficheLigneBas(Row :Integer;Calcul:boolean);
    procedure grPiecePointableColEnter(OldColonne, NewColonne,NewRow: Integer);
    function  CalculResteARegler(Infos:TPointage;MontantPiece:currency):currency;
    procedure PrepaAffichageSurOption(Option:integer;InitGrille:boolean);
    procedure SBAucunClick(Sender: TObject);
    procedure grPiecePointableBeforeColExit(NewColonne: Integer);
    procedure grPiecePointableKeyPress(Sender: TObject; var Key: Char);
    procedure grPiecePointableBeforeNewLigne(sender: TObject; Arow: Integer);
    procedure Annuler1Click(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Aideenligne1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure grPiecePointableBeforeSupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    function gestionDerniereReference(Journal:string):string;
    procedure paGrilleResize(Sender: TObject);
    procedure grPiecePointableRowEnter(sender: TObject; NewRow: Integer);
    procedure grPiecePointableCellClick(Colonne, Ligne: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function RecupOptionSurClickButton:integer;
    function ListReglementIndexOf(valeur:string;valeurRech:integer):integer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    Procedure InitPaLibelle;
    procedure FormShow(Sender: TObject);
    procedure grPiecePointableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); //PB

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    ListeReglement:TStringList;
    listeNewReference:TStringList;
    ResteARegler:currency;
  end;

var
  PiecePointable: TPiecePointable;
ListeReglementPointable:TStringList;
EtatGrille:TDataSetState;
LastLibEcriture:string;
RefSupp:string;
Option:integer;
//SpeedButtonDown:TComponentName;
MessDerSub:boolean;
DerniereRef:string;
ligneCurr:integer;
//CelluleSelect:integer;
lignecourante:string;
boutonEnabled:boolean;

procedure ListReglementAdd_Insert(Valeur:array of const;Add:boolean;Rang:integer;var Liste:Tstringlist);
procedure VisuListeShowMessage(Liste:Tstringlist;indexRang:integer;const indexChamp:array of integer);


implementation
{$R *.DFM}
Uses E2_Librairie_obj, Gr_Calculatrice, E2_AideCompte, E2_AideModel, E2_Main,
	 E2_AideLibelle{,E2_SaisieP},E2_SaisieP_3, DMEcriture,
         DMPlanCpt,DMTier,  DMPointages, DMRecherche;

const
	CColWidths :Array[1..8] of Integer = (65,81,65,220,81,65,65,65);

//******************************************************************************



//******************************************************************************
procedure TPiecePointable.Calculatrice1Click(Sender: TObject);

begin
	AfficheCalculatrice(ActiveControl);
end;

//******************************************************************************
procedure TPiecePointable.Fermer1Click(Sender: TObject);
begin
 Self.Close;
end;

//******************************************************************************
procedure TPiecePointable.FormCreate(Sender: TObject);
// Initialisation de la grille et de l'écran
Var
Registre :TRegistry;
i :Integer;
begin
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
	Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
//parametres grille
//SaisieReglements.ModalResult:=mrnone;
MessDerSub:=true;

//ObjReglement1.Piece:=saisieP.Piece1;
grPiecePointable.AjoutAuto:=true;
grPiecePointable.ColCount:=9;
grPiecePointable.Align:=alClient;
//grPiecePointable.Options:=[goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,goEditing, goTabs,goAlwaysShowEditor];
grPiecePointable.Options:=[goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,goEditing, goTabs,goDrawFocusSelected];
grPiecePointable.PopupMenu:=PopupMenuReglement;
grPiecePointable.RowCount:=2;
grPiecePointable.NumDecimal:=2;
grPiecePointable.Champ.Add(Grtous);
grPiecePointable.Champ.Add(Grcompte);
grPiecePointable.Champ.Add(Grtous);
grPiecePointable.Champ.Add(Grdate);
grPiecePointable.Champ.Add(Grtous);
grPiecePointable.Champ.Add(Grcurr);
grPiecePointable.Champ.Add(Grcurr);
grPiecePointable.Champ.Add(Grcurr);
grPiecePointable.Champ.Add(Grcurr);
for i:=1 to grPiecePointable.ColCount-1 do
Begin
grPiecePointable.ColWidths[i]:=CColWidths[i]
End;

// parametres divers
if listereglement=nil then
ListeReglement:=TstringList.Create;
if listeNewReference=nil then
listeNewReference:=TstringList.Create;
Registre:= TRegistry.Create;
   try
      with Registre do
      begin
         RootKey := HKEY_LOCAL_MACHINE;

    OpenKey('\SOFTWARE\LGR\Epicea2\' + self.Name, false);
       try
//         SBReglement.Down:=ReadBool('SBReglement');
//         SBAutres.Down:=ReadBool('SBAutres');
         SBPointables.down:=ReadBool('SBPointables');
         SBDejaPointes.down:=ReadBool('SBDejaPointes');
//         SBAucun.down:=ReadBool('SBAucun');

       except
         SBDejaPointes.down:=false;
         SBPointables.down:=false;
//         SBAucun.down:=true;
//         SBReglement.Down:=true;
//         SBAutres.Down:=false;

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
procedure TPiecePointable.FormDestroy(Sender: TObject);
Var
Registre :TRegistry;
begin
   Registre:= TRegistry.Create;
   try
      with Registre do begin
         RootKey := HKEY_LOCAL_MACHINE;

         OpenKey('\SOFTWARE\LGR\Epicea2\' + self.Name, True);
//         WriteBool('SBReglement',SBReglement.down);
//         WriteBool('SBAutres',SBAutres.down);
//         WriteBool('SBAucun',SBAucun.down);
         WriteBool('SBPointables',SBPointables.down);
         WriteBool('SBDejaPointes',SBDejaPointes.down);

         CloseKey;
      end;
   finally
      Registre.Free;
   end;
   DestroyForm(Self,E.User);
   PiecePointable:=nil;
   ListeReglementPointable.free;
   ListeReglement.free;
   listeNewReference.free;
end;

//******************************************************************************
procedure TPiecePointable.pmMenu1Click(Sender: TObject);
begin

	PopupMenuReglement.Popup(Left + 50, Top + 50);
end;




//******************* TSaisieReglement.Aide1Click ******************************
procedure TPiecePointable.Aide1Click(Sender: TObject);
// GEstion du F1
var
i:integer;
RefSelect:string;
trouve:boolean;
Date:TDateTime;
begin
try
   case grPiecePointable.Col of
      1:begin//si colonne compte
        //filtrer aidecompte suivant les paramètres nécessaire
        GestionFiltrageParamCpt;
        //les comptes doivent être filtrés en fonction des comptes pointables
        AideCompteDansContexte(grPiecePointable.Cells[1,ligneCurr],grPiecePointable,['rac1'],true,MessDerSub,false,true,true,false,1);
        if not empty(grPiecePointable.Cells[1,ligneCurr])then
        end;//fin si colonne compte
      2:begin//si colonne Référence
        //Récupérer la listes des réglements pointables et,ou pointés avec la pièce appelante
        //suivant l'option d'affichage choisie
        grPiecePointable.OnColExit:=nil;
        grPiecePointable.OnColEnter:=nil;
        PrepaAffichageSurOption(option,false);
        //filtrer TaPieceReglTmp en fonction de la liste de références récupérées
        with ObjReglement1 do
           begin //début du with ObjReglement1
           if TaPieceReglTmp.Active=false then
           TaPieceReglTmp.open;
           TaPieceReglTmp.Filtered:=false;
           TaPieceReglTmp.Filter:=CreeFiltreOU('Reference',[ListeReglementPointable]);
           TaPieceReglTmp.Filtered:=true;

           Rechercher(grPiecePointable,TaPieceReglTmp,['Reference','Compte','Libelle'],['Références','Compte','Libellé'],'',0);
           trouve:=false;
           RefSelect:='';
           RefSelect:=TaPieceReglTmp.FindField('Reference').asstring;
             if not empty(RefSelect)then
               i:=grPiecePointable.Cols[2].IndexOf(RefSelect);
//              for i:=0 to grPiecePointable.RowCount-1 do
//              Begin
                 if i<>-1 then
                   trouve:=true;
//              End;

           end;//fin du with ObjReglement1
           if trouve then
           grPiecePointable.row:=i
           else
              Begin
              if ((not empty(grPiecePointable.Cells[2,LigneCurr]))and (not empty(grPiecePointable.Cells[5,LigneCurr]))and (grPiecePointable.Cells[5,LigneCurr]<>'0'))then
              grPiecePointable.GenereLigne(false,grPiecePointable.rowcount,1);
              grPiecePointable.Cells[2,LigneCurr]:=RefSelect;
              CtrlSaisiePieceReglement(grPiecePointable.InplaceEditor,2,2);
              End;
        grPiecePointable.OnColExit:=grPiecePointableColExit;
        grPiecePointable.OnColEnter:=grPiecePointableColEnter;
        end;//fin si colonne Référence
      3:begin//si colonne Date
          if not empty(grPiecePointable.InplaceEditor.Text) then
          Date:=strtodate(grPiecePointable.InplaceEditor.Text)
          else
          Date:=now;
             if PopupDate(Date,grPiecePointable.InplaceEditor) then
             grPiecePointable.InplaceEditor.Text:=datetostr(Date);
//        AideDateAffiche(grPiecePointable);
        end; //fin si colonne Date
      4:begin //si colonne Libelle
        AideLibelleAffiche(grPiecePointable, grPiecePointable.Cells[1,LigneCurr]);
        end; //fin si colonne Libelle
      5://si colonne Montant
        AfficheCalculatrice(grPiecePointable);
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
Procedure TPiecePointable.AfficheLigneBas(Row :Integer;Calcul:boolean);
// Affiche les totaux de bas page
Begin

   hcCompte.Sections[0].Text:= 'Compte : ' + AideCompteLibelle(grPiecePointable.Cells[1,Row]);

   if Calcul then
   begin
   ResteARegler:=0;
   with ObjReglement1.Piece do
   ResteARegler:=CalculResteARegler(InfosPointage,MontantPourReglement);
   end;

     hcCompte.Sections[1].Text:= SaisieReglementhcCompteLibelleCompte + Format('%13.2n', [ResteARegler])

End;

//******************************************************************************
procedure TPiecePointable.grPiecePointableEnter(Sender: TObject);
begin

	AfficheLigneBas(1,true);
        //grPiecePointable.setfocus;
        grPiecePointableRowEnter(grPiecePointable,1);
    //    grPiecePointable.col:=1;
     //   grPiecePointable.NewColonne:=1;
end;


//******************************************************************************
procedure TPiecePointable.FormKeyDown(Sender: TObject; var Key: Word;
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
Begin
NewReglement:=TReglementList.Create(PiecePointable);
       for i:=0 to high(valeur)do
       begin
       RetourTranstypage:=VTypeTranstypage(valeur[i],valeur[i].vtype);
           if  RetourTranstypage.retour then
           begin
              case i mod 24 of
              0:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.Vide:=retourboolean.valeur;
                end;
              1:NewReglement.IDPiece:=strtoint(RetourTranstypage.valeur);
              2:NewReglement.Reference:=RetourTranstypage.valeur;
              3:NewReglement.IDJournal:=strtoint(RetourTranstypage.valeur);
              4:NewReglement.Journal:=RetourTranstypage.valeur;
              5:NewReglement.ID_Org:=strtoint(RetourTranstypage.valeur);
              6:NewReglement.IDContrepartie:=strtoint(RetourTranstypage.valeur);
              7:NewReglement.ID_Tmp:=strtoint(RetourTranstypage.valeur);
              8:NewReglement.Tiers:=RetourTranstypage.valeur;
              9:NewReglement.Compte:=RetourTranstypage.valeur;
             10:NewReglement.Libelle:=RetourTranstypage.valeur;
             11:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.Sens:=retourboolean.valeur;
                end;
             12:NewReglement.montant:=strtocurr(RetourTranstypage.valeur);
             13:NewReglement.Imputation:=strtocurr(RetourTranstypage.valeur);
             14:NewReglement.date:=RetourTranstypage.valeur;
             15:NewReglement.TvaDate:=RetourTranstypage.valeur;
             16:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewReglement.Pointee:=retourboolean.valeur;
                end;
             17:NewReglement.NbLignePointee:=strtoint(RetourTranstypage.valeur);
             18:NewReglement.Reste:=strtocurr(RetourTranstypage.valeur);
             19:NewReglement.ResteAAfficher:=strtocurr(RetourTranstypage.valeur);
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
      Liste.Insertobject(rang,inttostr(Rang),NewReglement);
with PiecePointable do
//VisuListeShowMessage(ListeReglement,Rang,[16,19]);
End;



procedure TPiecePointable.EtatInitial;
Begin
grPiecePointable.RowCount:=2;
grPiecePointable.Rows[1].Clear;
EtatGrille:=dsinsert;
ListeReglement.Clear;
listeNewReference.clear;
if ListeReglementPointable<>nil then
ListeReglementPointable.Clear;
//CelluleSelect:=-1;

SBDejaPointes.Enabled:=true;
SBPointables.Enabled:=true;
//SBAucun.Enabled:=true;
//SBReglement.Enabled:=true;
//SBAutres.Enabled:=true;

boutonEnabled:=false;

//rajoute deux lignes vides dans la liste des réglements
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,0,0,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true],true,-1,ListeReglement);
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,1,0,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true],true,-1,ListeReglement);
ResteARegler:=0;
if ObjReglement1.Piece.InfosPointage.infosPointage.Pointee then
    ResteARegler:=ObjReglement1.Piece.InfosPointage.InfosReste.Reste
else
    ResteARegler:=ObjReglement1.Piece.MontantPourReglement;
AfficheLigneBas(LigneCurr,false);
End;


function TPiecePointable.CtrlSaisiePieceReglement(edit:TCustomEdit;Acol,CelluleSuivante:integer):TErreurSaisie;
var
Pointage:TPointage;
IDPieceTmp,rang:integer;
RefTmp,JournalTmp,CompteTmp,IDJournalTmp:string;
regl,ResteTmp:currency;
tab:variant;
Begin
ObjReglement1.Piece.InitialiseInfosPointage(Pointage);
JournalTmp:='';
CompteTmp:='';
IDPieceTmp:=0;
result.CodeErreur:=0;
result.retour:=true;
DeFiltrageDataSet(DMRech.TaTiersRech);
   if EtatGrille in [dsinsert,dsedit] then
      Begin//si grille en insert ou modification
      if ((ligneCourante<>grPiecePointable.Rows[ligneCurr].text)and (not boutonEnabled)) then
         begin
           SBDejaPointes.Enabled:=false;
           SBPointables.Enabled:=false;
//           SBAucun.Enabled:=false;
//           SBReglement.Enabled:=false;
//           SBAutres.Enabled:=false;

           boutonEnabled:=true;
         end;
//         if not grPiecePointable.lignevide(lignecurr)then
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
                                       grPiecePointable.Cells[1,ligneCurr]:=edit.text;
                                     End
                                       else
                                     Begin
                                     result.retour:=false;
//                                     result.CodeErreur:=
                                     End;
                           End
                           else
                           Begin
                             GestionFiltrageParamCpt;
                             //les comptes doivent être filtrés en fonction des comptes pointables
                             result.retour:=AideCompteDansContexte(grPiecePointable.Cells[1,ligneCurr],grPiecePointable,['rac1'],false,MessDerSub,true,true,true,false,1);
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
//                                 if  (ListeReglement.Objects[ligneCurr]as TReglementList).Reference<>grPiecePointable.Cells[2,ligneCurr] then
//                                 Begin
                                 rang:=ListeReglementPointable.IndexOf((ListeReglement.Objects[ligneCurr]as TReglementList).Reference);
                                   if rang<>-1 then
                                     ListeReglementPointable.delete(rang);
//                                 End;
                               end;
                               if not empty(grPiecePointable.Cells[1,ligneCurr])then
                               JournalTmp:=ObjReglement1.RenvoieInfoSurTableDiverse( grPiecePointable.Cells[1,ligneCurr],
                               ObjReglement1.Piece.TableJournal,'Compte','Journal');
                               if empty(JournalTmp)then
                               JournalTmp:='OD';
                               grPiecePointable.Cells[2,ligneCurr]:=gestionDerniereReference(journalTmp);
                               ListeReglementPointable.Add(grPiecePointable.Cells[2,ligneCurr]);
                               End //fin si compte correct,
                           else
                               Begin //si compte pas correct
                               if result.CodeErreur=1002 then
                                  Application.MessageBox(Pchar('Ce compte n''est pas cohérent dans ce context.'),'Erreur de saisie',0)
                               else
                                  Application.MessageBox(Pchar('La saisie du compte est obligatoire !!!'),'Erreur de saisie',0);
                               End; //fin si compte pas correct
                       if ((not empty(grPiecePointable.Cells[1,ligneCurr]))and (result.retour)) then
                          begin //si après vérif et réparation le compte est rempli
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            if trim((ListeReglement.Objects[ligneCurr]as TReglementList).compte)<>trim(grPiecePointable.Cells[1,ligneCurr]) then
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
                          (ListeReglement.Objects[ligneCurr]as TReglementList).IDJournal:=strtoint(IDJournalTmp)
                          else
                          abort;
                          (ListeReglement.Objects[ligneCurr]as TReglementList).Journal:=JournalTmp;
                          (ListeReglement.Objects[ligneCurr]as TReglementList).Reference:=grPiecePointable.Cells[2,ligneCurr];
                          (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Tmp:=ligneCurr;
                          (ListeReglement.Objects[ligneCurr]as TReglementList).Sens:=ObjReglement1.piece.SensPourReglement;
                          (ListeReglement.Objects[ligneCurr]as TReglementList).tiers:=ObjReglement1.piece.tiers;
                         end;//fin si après vérif et réparation le compte est rempli
                       end;//fin si modification du compte
      //              end;//fin du with
                  end;
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
                     if not empty(grPiecePointable.cells[1,ligneCurr])then
                     JournalTmp:=ObjReglement1.RenvoieInfoSurTableDiverse(grPiecePointable.cells[1,ligneCurr],
                     ObjReglement1.Piece.TableJournal,'Compte','Journal');
                     if empty(JournalTmp)then
                     JournalTmp:='OD';
                     if not empty((ListeReglement.Objects[ligneCurr]as TReglementList).Reference) then
                     begin
                       if  (ListeReglement.Objects[ligneCurr]as TReglementList).Reference<>grPiecePointable.Cells[2,ligneCurr] then
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
                             RefTmp:=gestionDerniereReference(journalTmp);
                            if edit.text<>RefTmp then
                             Begin //si référence pas correct
                             Application.MessageBox(Pchar('Cette référence n''est pas cohérente dans ce context !!!'),'Erreur de saisie',0);
                             result.CodeErreur:=2002;
                             result.retour:=false;
                             End //fin si référence pas correct
                             else
                             Begin//si la référence est correct et c'est une nouvelle référence
                             //je vide tous les champs sauf la référence
                             CompteTmp:=grPiecePointable.Cells[1,ligneCurr];
                             grPiecePointable.Rows[ligneCurr].Clear;
                             grPiecePointable.Cells[1,ligneCurr]:=CompteTmp;
                             grPiecePointable.Cells[2,ligneCurr]:=RefTmp;
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
                             (ListeReglement.Objects[ligneCurr]as TReglementList).IDJournal:=strtoint(ObjReglement1.RenvoieInfoSurTableDiverse(JournalTmp,
                               ObjReglement1.Piece.TableJournal,'Journal','ID_Journal'));
                               (ListeReglement.Objects[ligneCurr]as TReglementList).Journal:=JournalTmp;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Tmp:=ligneCurr;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).Sens:=ObjReglement1.piece.SensPourReglement;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).tiers:=ObjReglement1.piece.tiers;
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
                                   grPiecePointable.Row:=rang //si la référence est déjà editée
                                   else
                                   begin//si la référence n'est pas dans la grille
                                      DMPointage.RecupPiecePointableSurTiers_Et_Journal_PourReglement(ObjReglement1.Piece.Tiers,ObjReglement1.Piece.IDJournal,option,ObjReglement1.Piece.IDContrepartie,ObjReglement1.Piece.Sens,ObjReglement1.Piece.SensPourReglement);
                                      if DMPointage.QuLigneBanqueTiersEnCours.RecordCount<>0 then
                                        if dmpointage.QuLigneBanqueTiersEnCours.Locate('Reference',edit.text,[])then
                                           AffichagePieceReglementExistante(ligneCurr,edit.text)
                                      else
                                      Begin//si ce n'est pas un réglement pointable
                                      Application.MessageBox(Pchar('Cette référence n''est pas cohérente dans ce context !!!'),'Erreur de saisie',0);
                                      result.CodeErreur:=2002;
                                      result.retour:=false;
                                      End;//fin si ce n'est pas un réglement pointable
                                   end;//fin si la référence n'est pas dans la grille
                                end//fin si la piece fait partie de la liste des réglements pointables
                                else
                                Begin //si la piece ne fait pas partie de la liste des réglements pointables
                                  Application.MessageBox(Pchar('Cette référence n''est pas cohérente dans ce context !!!'),'Erreur de saisie',0);
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
                              RefTmp:=gestionDerniereReference(journalTmp);

                              CompteTmp:=grPiecePointable.Cells[1,ligneCurr];
                              grPiecePointable.Rows[ligneCurr].Clear;
                              grPiecePointable.Cells[1,ligneCurr]:=CompteTmp;
                              grPiecePointable.Cells[2,ligneCurr]:=RefTmp;
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
                              (ListeReglement.Objects[ligneCurr]as TReglementList).IDJournal:=strtoint(ObjReglement1.RenvoieInfoSurTableDiverse(JournalTmp,
                                   ObjReglement1.Piece.TableJournal,'Journal','ID_Journal'));
                              (ListeReglement.Objects[ligneCurr]as TReglementList).Journal:=JournalTmp;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Tmp:=grPiecePointable.row;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).Sens:=ObjReglement1.piece.SensPourReglement;
                               (ListeReglement.Objects[ligneCurr]as TReglementList).tiers:=ObjReglement1.piece.tiers;
                              end; //fin si la CelluleSuivante est différente de la colonne compte
                          End; //fin si référence pas remplie
                      if not empty(grPiecePointable.Cells[2,ligneCurr])then
                      begin
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            if trim((ListeReglement.Objects[ligneCurr]as TReglementList).reference)<>trim(grPiecePointable.Cells[2,ligneCurr]) then
                              (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                      ListeReglementPointable.add(grPiecePointable.Cells[2,ligneCurr]);
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
                       if not empty(edit.text)then
                         Begin //si la date est remplie
                           if not (ObjReglement1.Piece.VerifDateSaisie(strtodate(edit.text)))then
                             Begin //si référence pas correct
                             Application.MessageBox(Pchar('La date doit faire partie de l''exercice en cours !!!'),'Erreur de saisie',0);
                             result.CodeErreur:=3002;
                             result.retour:=false;
                             End; //fin si compte pas correct
                         End //fin si la date est remplie
                       else
                         Begin //si pas remplie
                         // remplir par défaut avec date de la pièce appelante
                         grPiecePointable.Cells[3,ligneCurr]:=datetostr(ObjReglement1.Piece.datesaisie);
                         End; //fin si pas remplie
                       if not empty(grPiecePointable.Cells[3,ligneCurr]) then
                       begin
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            if trim((ListeReglement.Objects[ligneCurr]as TReglementList).date)<>trim(grPiecePointable.Cells[3,ligneCurr]) then
                              (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                       (ListeReglement.Objects[ligneCurr]as TReglementList).Date:=grPiecePointable.Cells[3,ligneCurr];
                       end;
                     end;//fin si modification de la date
          //         end;//fin du with
                  End;//fin si champ date
                4:begin//si champ libelle
                    //Si Libellé vide, remplie par défaut
      //           with (ListeReglement.Objects[ligneCurr]as TReglementList) do
      //             begin

                   if ((trim((ListeReglement.Objects[ligneCurr]as TReglementList).Libelle)<>trim(edit.text))or(empty((ListeReglement.Objects[ligneCurr]as TReglementList).Libelle))) then
                     begin // si modification du libelle
                       if ((empty(edit.text))or (trim(edit.text)='*' ))then //si champ libelle vide
                          begin//ou rempli avec une *
                        // grPiecePointable.Cells[4,ligneCurr]:=RenvoieInfoSurTableDiverse(grPiecePointable.Cells[1,ligneCurr],saisieP.piece1.TablePlan,'Compte',['Libelle'],Tab);
                          grPiecePointable.Cells[4,ligneCurr]:=RenvoieInfoSurTableDiverse(grPiecePointable.Cells[1,ligneCurr],DMPieces.piece1.TablePlan,'Compte',['Libelle'],Tab);
                          if empty(grPiecePointable.Cells[4,ligneCurr])then
                          //grPiecePointable.Cells[4,ligneCurr]:=saisieP.Piece1.Libelle;
                          grPiecePointable.Cells[4,ligneCurr]:=DMPieces.Piece1.Libelle;
                          LastLibEcriture:=grPiecePointable.Cells[4,ligneCurr];
                          end
                       else
                          Begin //si champ libelle rempli
                           if LastLibEcriture=edit.text then
                          //grPiecePointable.Cells[4,ligneCurr]:=RenvoieInfoSurTableDiverse(grPiecePointable.Cells[1,ligneCurr],saisieP.piece1.TablePlan,'Compte',['Libelle'],Tab);
                          grPiecePointable.Cells[4,ligneCurr]:=RenvoieInfoSurTableDiverse(grPiecePointable.Cells[1,ligneCurr],DMPieces.piece1.TablePlan,'Compte',['Libelle'],Tab);
                          if empty(grPiecePointable.Cells[4,ligneCurr])then
                          //grPiecePointable.Cells[4,ligneCurr]:=saisieP.Piece1.Libelle;
                          grPiecePointable.Cells[4,ligneCurr]:=DMPieces.Piece1.Libelle;
                          LastLibEcriture:=grPiecePointable.Cells[4,ligneCurr];
                          End;//fin si champ libelle rempli
                       if empty(grPiecePointable.Cells[4,ligneCurr]) then
                         Begin //si libelle vide
                         Application.MessageBox(Pchar('La saisie du Libellé est obligatoire !!!'),'Erreur de saisie',0);
                         result.CodeErreur:=4001;
                         result.retour:=false;
                         End; //fin si libelle vide
                       if not empty(grPiecePointable.Cells[4,ligneCurr]) then
                       begin
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            if trim((ListeReglement.Objects[ligneCurr]as TReglementList).Libelle)<>trim(grPiecePointable.Cells[4,ligneCurr]) then
                              (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                       (ListeReglement.Objects[ligneCurr]as TReglementList).Libelle:=grPiecePointable.Cells[4,ligneCurr];
                       end;
                     end;//fin si modification du libelle
      //             end;//fin du with
                  End;//fin si champ libelle
                5:Begin//si champ Debit ou Crédit
      //           with (ListeReglement.Objects[ligneCurr]as TReglementList) do
      //             begin

                   if ((empty(edit.text))or(edit.text='0')) then
                   Begin //si champ vide
                       Application.MessageBox(Pchar('Vous devez Saisir le montant du réglement!!!'),'Erreur de saisie',0);
                       result.CodeErreur:=5001;
                       result.retour:=false;
                   End
                   else //fin si champ vide
                   if (((ListeReglement.Objects[ligneCurr]as TReglementList).montant<>strtocurr(edit.text))or((ListeReglement.Objects[ligneCurr]as TReglementList).montant=0)) then
                     begin // si modification du Débit ou Crédit
                        with (ListeReglement.Objects[ligneCurr]as TReglementList) do
                        begin
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org<>-1 then
                            begin
                            if currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).montant)<>trim(grPiecePointable.Cells[5,ligneCurr]) then
                              PieceModifiee:=true;
                            end;
                        (ListeReglement.Objects[ligneCurr]as TReglementList).montant:=strtocurr(edit.text);
                  //VisuListeShowMessage(ListeReglement,grPiecePointable.row,[21]);
                           if pointee then
                           grPiecePointable.Cells[6,ligneCurr]:=currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).montant-(ListeReglement.Objects[ligneCurr]as TReglementList).reste)
                           else
                           grPiecePointable.Cells[6,ligneCurr]:='0';
                        if empty(grPiecePointable.Cells[8,ligneCurr])then
                        grPiecePointable.Cells[8,ligneCurr]:='0';
                        grPiecePointable.Cells[7,ligneCurr]:=currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).montant - strtocurr(grPiecePointable.Cells[8,ligneCurr]) -strtocurr(grPiecePointable.Cells[6,ligneCurr]));
                        ResteAAfficher:=strtocurr(grPiecePointable.Cells[7,ligneCurr]);
                          if (ListeReglement.Objects[ligneCurr]as TReglementList).ID_Org=-1 then
                             (ListeReglement.Objects[ligneCurr]as TReglementList).Reste:=strtocurr(grPiecePointable.Cells[5,ligneCurr])-strtocurr(grPiecePointable.Cells[6,ligneCurr])-strtocurr(grPiecePointable.Cells[8,ligneCurr]);
                        end;
                     end;//fin si modification du Débit ou Crédit
      //             end;//fin du with
                  End;//fin si champ Debit ou Crédit
                8:Begin//si champ Imputation
                  //vérifier si imputation n'est pas supérieur au montant du débit ou crédit
                  //et si elle n'est pas supérieur au reste à pointer de la pièce appelante ou
                  // de cette pièce de réglement elle-même.
      //           with (ListeReglement.Objects[ligneCurr]as TReglementList) do
      //             begin

                   if empty(edit.text)then
                   grPiecePointable.Cells[8,ligneCurr]:='0';
                   if (((ListeReglement.Objects[ligneCurr]as TReglementList).Imputation<>strtocurr(grPiecePointable.Cells[8,ligneCurr]))or((ListeReglement.Objects[ligneCurr]as TReglementList).Imputation=0)) then
                     begin // si modification de l'Imputation
                        with ObjReglement1.Piece do
                           Begin//si le champ est rempli
                           //VisuListeShowMessage(ListeReglement,grPiecePointable.row,[11,16,19]);
                           ResteTmp:=(ListeReglement.Objects[ligneCurr]as TReglementList).Reste+(ListeReglement.Objects[ligneCurr]as TReglementList).Imputation;
                           //(ListeReglement.Objects[ligneCurr]as TReglementList).Reste:=(ListeReglement.Objects[ligneCurr]as TReglementList).Reste+(ListeReglement.Objects[ligneCurr]as TReglementList).Imputation;
                           ResteARegler:=CalculResteARegler(InfosPointage,ObjReglement1.Piece.MontantPourReglement);
                           if not empty(grPiecePointable.Cells[5,ligneCurr])then
                           regl:=strtocurr(grPiecePointable.Cells[5,ligneCurr])
                           else
                           regl:=0;
                           if ResteARegler<0then
                             begin//on vérifie s'il ne dépasse pas le montant qu'il reste à régler
                             Application.MessageBox(Pchar('Ce montant est supérieur au reste à régler !!!'),'Erreur de saisie',0);
                             result.CodeErreur:=8001;
                             result.retour:=false;
                             end //fin on vérifie s'il ne dépasse pas le montant qu'il reste à régler
                             else
                               if regl<strtocurr(grPiecePointable.Cells[8,ligneCurr]) then
                                 begin//on vérifie s'il ne dépasse pas le montant du réglement lui-même
                                 Application.MessageBox(Pchar('Ce montant est supérieur au montant du réglement !!!'),'Erreur de saisie',0);
                                 result.CodeErreur:=8002;
                                 result.retour:=false;
                                 end//fin on vérifie s'il ne dépasse pas le montant du réglement lui-même
                                 else
                                   if (ListeReglement.Objects[ligneCurr]as TReglementList).Pointee then
                                   begin //si le réglement est déjà pointee
                                       //if (ListeReglement.Objects[ligneCurr]as TReglementList).Reste<strtocurr(grPiecePointable.Cells[8,ligneCurr])then
                                         if ResteTmp<strtocurr(grPiecePointable.Cells[8,ligneCurr])then
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
                                if currtostr((ListeReglement.Objects[ligneCurr]as TReglementList).Imputation)<>trim(grPiecePointable.Cells[8,ligneCurr]) then
                                  (ListeReglement.Objects[ligneCurr]as TReglementList).PieceModifiee:=true;
                              grPiecePointable.Cells[7,ligneCurr]:=currtostr(strtocurr(grPiecePointable.Cells[5,ligneCurr]) - strtocurr(grPiecePointable.Cells[8,ligneCurr]) -strtocurr(grPiecePointable.Cells[6,ligneCurr]));
                              (ListeReglement.Objects[ligneCurr]as TReglementList).Imputation:=strtocurr(grPiecePointable.Cells[8,ligneCurr]);
                              (ListeReglement.Objects[ligneCurr]as TReglementList).ResteAAfficher:=strtocurr(grPiecePointable.Cells[7,ligneCurr]);

                              //(ListeReglement.Objects[ligneCurr]as TReglementList).Reste:=(ListeReglement.Objects[ligneCurr]as TReglementList).Reste-(ListeReglement.Objects[ligneCurr]as TReglementList).Imputation;
                              (ListeReglement.Objects[ligneCurr]as TReglementList).Reste:=restetmp-(ListeReglement.Objects[ligneCurr]as TReglementList).Imputation;
                             //  VisuListeShowMessage(ListeReglement,grPiecePointable.row,[11,16,19]);
                              AfficheLigneBas(ligneCurr,true);
                              end;
                     end;//fin si modification de l'Imputation
      //             end;//fin du with
                  end;//fin si champ Imputation
                End; //fin du case Acol
    //     end;//fin si ligne pas vide
      End; //fin etatpiece in [dsinsert,dsbrowse]
end;

procedure TPiecePointable.FormActivate(Sender: TObject);
begin
DMPlan.TaCompte.OnFilterRecord:=nil;
////ObjReglement1.Piece:=saisieP.Piece1;
//ObjReglement1.Piece:=DMPieces.Piece1;
//ligneCurr:=1;
//etatinitial;
//   dmpointage.QuSumPointeCredit.close;
//   dmpointage.QuSumPointeCredit.open;
//   dmpointage.QuSumPointeDebit.close;
//   dmpointage.QuSumPointeDebit.open;
////Initialise la grille en fonction de l'option d'affichage récupérée
//PrepaAffichageSurOption(option,true);
//InitPaLibelle;
//////***Récupérer les paramètres de la pièce appelante pour afficher le reste à régler
////et autres informations
//
//
//if ObjReglement1.Piece.SensPourReglement then
//grPiecePointable.Rows[0].CommaText:=SaisieReglementgrPiecePointableCommaTextCredit
//else
//grPiecePointable.Rows[0].CommaText:=SaisieReglementgrPiecePointableCommaTextDebit;
//DerniereRef:='';
//AfficheLigneBas(lignecurr,true);
//grPiecePointable.setfocus;
end;


procedure TPiecePointable.GestionFiltrageParamCpt;
var
ListeCpt:TStringList;
filtre:string;
filtrer:boolean;
begin
ListeCpt:=TStringList.Create;
ListeCpt:=DMPlan.FiltrageParamCPT(28,e.Regime);
aidecompte.InitialiseCompte;
ListeCpt.Free;
End;


procedure TPiecePointable.AffichagePieceReglementExistante(Ligne:integer;Reference:string);
var
Imputation:currency;
i:integer;
conteneur:TPointage;
reste:currency;
Begin
  try
  conteneur:=ObjReglement1.piece.InfosPointage;
  conteneur.InfosReste.ResteInitial:=conteneur.InfosReste.Reste;
     if ligne=-1 then
        begin//si on veut travailler sur plusieurs pieces de réglements trouvées
          DMPointage.QuLigneBanqueTiersEnCours.first;
           i:=1;
          grPiecePointable.RowCount:=DMPointage.QuLigneBanqueTiersEnCours.RecordCount+1;
           while not(DMPointage.QuLigneBanqueTiersEnCours.eof)do
              begin //début du while

              grPiecePointable.Cells[1,i]:=DMPointage.QuLigneBanqueTiersEnCoursComptePiece.AsString;
              grPiecePointable.Cells[2,i]:=DMPointage.QuLigneBanqueTiersEnCoursReference.AsString;
              grPiecePointable.Cells[3,i]:=DMPointage.QuLigneBanqueTiersEnCoursDate.AsString;
              grPiecePointable.Cells[4,i]:=DMPointage.QuLigneBanqueTiersEnCoursLibelle.AsString;
              grPiecePointable.Cells[5,i]:=DMPointage.QuLigneBanqueTiersEnCoursTotalReglement.AsString;
              grPiecePointable.Cells[6,i]:=DMPointage.QuLigneBanqueTiersEnCoursPointages.AsString;
              grPiecePointable.Cells[7,i]:=DMPointage.QuLigneBanqueTiersEnCoursResteAPointer.AsString;
              if VerifFNumeric(DMPointage.QuLigneBanqueTiersEnCoursMontantImputationCredit).VideOUZero then
              Imputation:=DMPointage.QuLigneBanqueTiersEnCoursMontantImputationDebit.AsCurrency
              else
              Imputation:=DMPointage.QuLigneBanqueTiersEnCoursMontantImputationCredit.AsCurrency;
              grPiecePointable.Cells[8,i]:=currtostr(Imputation);
              conteneur.InfosReste.ResteInitial:=conteneur.InfosReste.ResteInitial+imputation;
              ListReglementAdd_Insert([false,DMPointage.QuLigneBanqueTiersEnCoursId_Piece.AsString,
              DMPointage.QuLigneBanqueTiersEnCoursReference.AsString,DMPointage.QuLigneBanqueTiersEnCoursJournal.AsString,
              copy(DMPointage.QuLigneBanqueTiersEnCoursReference.AsString,1,2),0,
              DMPointage.QuLigneBanqueTiersEnCoursID.AsString,i,ObjReglement1.piece.tiers,DMPointage.QuLigneBanqueTiersEnCoursComptePiece.AsString,
              DMPointage.QuLigneBanqueTiersEnCoursLibelle.AsString,DMPointage.QueryRecupPointageSensReglement.AsBoolean,
              DMPointage.QuLigneBanqueTiersEnCoursTotalReglement.AsString,Imputation,DMPointage.QuLigneBanqueTiersEnCoursDate.AsString,
              DMPointage.QuLigneBanqueTiersEnCoursDate.AsString,DMPointage.QuLigneBanqueTiersEnCoursPointee.AsBoolean,
              DMPointage.QuLigneBanqueTiersEnCoursNbLignePointee.AsInteger,
              DMPointage.QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency,
              DMPointage.QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency,
              DMPointage.QueryRecupPointageSensReglement.AsBoolean,
              not(DMPointage.QuLigneBanqueTiersEnCoursPointee.AsBoolean),
              false,false],false,i,ListeReglement);
              ListeReglementPointable.Add(DMPointage.QuLigneBanqueTiersEnCoursReference.AsString);
              inc(i);
              DMPointage.QuLigneBanqueTiersEnCours.next;
                         end;//fin du while
            grPiecePointable.row:=1;
            lignecurr:=grPiecePointable.row;
       //     grPiecePointable.col:=1;
         //   grPiecePointable.NewColonne:=1;
        end //fin si on veut travailler sur plusieurs pieces de réglements trouvées
     else
        Begin//si on rajoute une seule ligne
          if DMPointage.QuLigneBanqueTiersEnCours.Locate('Reference',reference,[])then
             begin//si on trouve la reference dans la query
              grPiecePointable.Cells[1,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursComptePiece.AsString;
              grPiecePointable.Cells[2,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursReference.AsString;
              grPiecePointable.Cells[3,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursDate.AsString;
              grPiecePointable.Cells[4,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursLibelle.AsString;
              grPiecePointable.Cells[5,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursTotalReglement.AsString;
              grPiecePointable.Cells[6,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursPointages.AsString;
              grPiecePointable.Cells[7,Ligne]:=DMPointage.QuLigneBanqueTiersEnCoursResteAPointer.AsString;
              if VerifFNumeric(DMPointage.QuLigneBanqueTiersEnCoursMontantImputationCredit).VideOUZero then
              Imputation:=DMPointage.QuLigneBanqueTiersEnCoursMontantImputationDebit.AsCurrency
              else
              Imputation:=DMPointage.QuLigneBanqueTiersEnCoursMontantImputationCredit.AsCurrency;
              grPiecePointable.Cells[8,Ligne]:=currtostr(Imputation);
              conteneur.InfosReste.ResteInitial:=conteneur.InfosReste.ResteInitial+imputation;
              ListReglementAdd_Insert([false,DMPointage.QuLigneBanqueTiersEnCoursId_Piece.AsString,
              DMPointage.QuLigneBanqueTiersEnCoursReference.AsString,DMPointage.QuLigneBanqueTiersEnCoursJournal.AsString,
              copy(DMPointage.QuLigneBanqueTiersEnCoursReference.AsString,1,2),0,
              DMPointage.QuLigneBanqueTiersEnCoursID.AsString,Ligne,ObjReglement1.piece.tiers,DMPointage.QuLigneBanqueTiersEnCoursComptePiece.AsString,
              DMPointage.QuLigneBanqueTiersEnCoursLibelle.AsString,DMPointage.QueryRecupPointageSensReglement.AsBoolean,
              DMPointage.QuLigneBanqueTiersEnCoursTotalReglement.AsString,Imputation,DMPointage.QuLigneBanqueTiersEnCoursDate.AsString,
              DMPointage.QuLigneBanqueTiersEnCoursDate.AsString,DMPointage.QuLigneBanqueTiersEnCoursPointee.AsBoolean,
              DMPointage.QuLigneBanqueTiersEnCoursNbLignePointee.AsInteger,
              DMPointage.QuLigneBanqueTiersEnCoursPointages.AsCurrency+Imputation,
              DMPointage.QuLigneBanqueTiersEnCoursResteAPointer.AsCurrency,
              DMPointage.QueryRecupPointageSensReglement.AsBoolean,
              not(DMPointage.QuLigneBanqueTiersEnCoursPointee.AsBoolean),
              false,false],true,Ligne,ListeReglement);
              ListeReglementPointable.Add(DMPointage.QuLigneBanqueTiersEnCoursReference.AsString);

              grPiecePointable.row:=Ligne;
              lignecurr:=grPiecePointable.row;
     //         grPiecePointable.col:=1;
     //         grPiecePointable.NewColonne:=1;
             End//fin si on trouve la reference dans la query
          else
             abort;
        end;//fin si on rajoute une seule ligne
   ObjReglement1.piece.InfosPointage:=conteneur;
  except
  showmessage('Problème lors de la récupération des réglements existants !!');
  abort;
  end;//fin du try
End;



procedure TPiecePointable.grPiecePointableColExit(OldColonne,LastRow: Integer);
var
ctrlSaisieReglement:TErreurSaisie;
begin
   if not grPiecePointable.LigneVide(lignecurr)then
   begin
     ctrlSaisieReglement:=CtrlSaisiePieceReglement(grPiecePointable.inplaceEditor,grPiecePointable.OldColonne,grPiecePointable.NewColonne);
//     ctrlSaisieReglement:=CtrlSaisiePieceReglement(grPiecePointable.cells[grPiecePointable.OldColonne,LastRow],grPiecePointable.OldColonne,grPiecePointable.NewColonne);
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
   end;//fin si ligne pas vide
end;

procedure TPiecePointable.grPiecePointableRowValidate(Sender: TObject;
  var Valide, Action: Boolean; LastCol: Integer);
var
ctrlSaisieReglement:TErreurSaisie;
i:integer;
InplaceTmp:TInplaceEdit;
begin
try
InplaceTmp:=TInplaceEdit.Create(self);
for i:=1 to grPiecePointable.ColCount-1 do
if not grPiecePointable.lignevide(lignecurr)then
   begin
      begin//début boucle for
//      if grPiecePointable.col+1 = i then
//        InplaceTmp.Text:=grPiecePointable.InplaceEditor.Text
//       else
        InplaceTmp.Text:=grPiecePointable.cells[i,ligneCurr];
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
InplaceTmp.Free;
end;
end;

procedure TPiecePointable.grPiecePointableSupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
begin
//grPiecePointable.col:=1;
//grPiecePointable.NewColonne:=1;
//Raffraichir l'affichage du reste à pointer de la pièce initiale
AfficheLigneBas(NewRow,true);
end;

procedure TPiecePointable.grPiecePointableColEnter(OldColonne,NewColonne,NewRow: Integer);
begin
ligneCourante:=grPiecePointable.Rows[NewRow].text;
   if ((grPiecePointable.NewColonne in [6,7])or (((grPiecePointable.NewColonne=5)and(not((ListeReglement.Objects[NewRow]as TReglementList).Modifiable)))))then //si colonne Autres pointages ou reste à pointer
      begin // si colonne (pointee ou reste) ou (Montant Réglement,et colonne non modifiable)
      grPiecePointable.OnColEnter:=nil;
      grPiecePointable.OnColExit:=nil;
      case grPiecePointable.newcolonne of
         5..7:begin
           grPiecePointable.oldcolonne:=8;
           grPiecePointable.Col:=8;
           end;
         8:begin
           grPiecePointable.oldcolonne:=5;
           grPiecePointable.Col:=5;
           end;
      end;
      grPiecePointable.OnColEnter:=grPiecePointableColEnter;
      grPiecePointable.OnColExit:=grPiecePointableColExit;
      abort;
      end;
end;


function TPiecePointable.CalculResteARegler(Infos:TPointage;MontantPiece:currency):currency;
     //Calcul le total de la colonne des Imputations
     function CalculTotalColonneImputation:currency;
     var
     i:integer;
     Begin
     result:=0;
        for i:=1 to grPiecePointable.RowCount-1 do
        begin
          if not empty(grPiecePointable.cells[8,i])then
          result:=result+StrToCurr(grPiecePointable.cells[8,i]);
        end;
     End;
//Début du corp de la procédure calcul du reste à régler
Begin
   if infos.infosPointage.Pointee then
   //si la pièce est déjà en partie pointée, on récupère le reste pour calculer le reste A Régler
     result:=infos.InfosReste.ResteInitial - CalculTotalColonneImputation
   else
   //si la pièce n'est pas pointée, on se sert du total de la pièce pour calculer le reste à régler
     result:=MontantPiece - CalculTotalColonneImputation;
End;


procedure TPiecePointable.PrepaAffichageSurOption(Option:integer;InitGrille:boolean);
//var
//i:integer;
//Pointee:boolean;
//NbLignePointees:integer;
//Imputation:currency;
Begin
if ListeReglementPointable=nil then
ListeReglementPointable:=TStringList.Create;

grPiecePointable.OnColExit:=nil;
grPiecePointable.OnRowValidate:=nil;
  grPiecePointable.RowCount:=2;
  grPiecePointable.Rows[1].Clear;
  ListeReglement.Clear;
  //rajoute deux lignes vides dans la liste des réglements
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,0,0,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true],true,-1,ListeReglement);
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,1,0,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true],true,-1,ListeReglement);
   DMPointage.RecupPiecePointableSurTiers_Et_Journal_PourPieceAchat_Vente(ObjReglement1.Piece.Tiers,option,ObjReglement1.Piece.IDContrepartie,ObjReglement1.Piece.Sens,ObjReglement1.Piece.SensPourReglement);
//  case option of
//   2:Begin //récupérer tous les réglements concernant le tiers courant et qui soient encore pointables
//       DMPointage.RecupPiecePointableSurTiers_Et_Journal_PourPieceAchat_Vente(ObjReglement1.Piece.Tiers,2,ObjReglement1.Piece.IDContrepartie,ObjReglement1.Piece.Sens,ObjReglement1.Piece.SensPourReglement);
//      End;//fin récupérer tous les réglements concernant le tiers courant et qui soient encore pointables
//   3:Begin //récupérer tous les réglements concernant le tiers courant et déjà pointés
//       DMPointage.RecupPiecePointableSurTiers_Et_Journal_PourPieceAchat_Vente(ObjReglement1.Piece.Tiers,3,ObjReglement1.Piece.IDContrepartie,ObjReglement1.Piece.Sens,ObjReglement1.Piece.SensPourReglement);
//      End;//fin récupérer tous les réglements concernant le tiers courant et déjà pointés
//  end;//fin du case Option

if ((DMPointage.QuLigneBanqueTiersEnCours.RecordCount<>0)and(InitGrille)) then
   Begin
      //afficher les lignes et récupérer les infos dans listeReglement
       ListeReglementPointable.Clear;
       if option in [2,3] then
       AffichagePieceReglementExistante(-1,'');
   End;

grPiecePointable.OnColExit:=grPiecePointableColExit;
grPiecePointable.OnRowValidate:=grPiecePointableRowValidate;
ligneCourante:=grPiecePointable.Rows[LigneCurr].text;
End;


procedure TPiecePointable.SBAucunClick(Sender: TObject);
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

//      PaLibelle.Color:=$00808040;
     end;
end;

procedure TPiecePointable.grPiecePointableBeforeColExit(NewColonne: Integer);
begin
if not grPiecePointable.lignevide(lignecurr)then
   begin
     if grPiecePointable.Champ.Items[grPiecePointable.oldcolonne] = Grcurr then
     begin
       if empty(grPiecePointable.Cells[grPiecePointable.oldcolonne,LigneCurr])then
         grPiecePointable.Cells[grPiecePointable.oldcolonne,LigneCurr]:='0';
     end;
   end;
end;

procedure TPiecePointable.grPiecePointableKeyPress(Sender: TObject;
  var Key: Char);
var
IndexTmp:integer;
LastRef,NewRef:string;
trouve:boolean;
KeyTmp:word;
begin
   
////si piece existante (OD) sans compte de contrepartie fixe, pas de modif possible
//à part l'imputation

if grPiecePointable.col=2 then
   Begin
   if key<>#13 then
      key:=#0;
   end;
if ((grPiecePointable.col in [1,3,4,5,6,7])and((ListeReglement.Objects[ligneCurr]as TReglementList).CompteModifiable=false)) then
   Begin
   if key<>#13 then
      key:=#0;
   end;

if ((grPiecePointable.col=2)and(key='+')) then
   Begin
   key:=#0;
//      if key ='+' then
//        begin
//        if not empty(grPiecePointable.Cells[2,grPiecePointable.row])then
//           begin
//           key:=#0;
//           ListeReglementPointable.Sorted:=true;
//           IndexTmp:=-1;
//           IndexTmp:=ListeReglementPointable.IndexOf(grPiecePointable.Cells[2,grPiecePointable.row]);
//           if IndexTmp<>-1 then
//             grPiecePointable.Cells[2,grPiecePointable.row]:=ListeReglementPointable.Strings[IndexTmp+1];
//           end
//        else
//           Begin
//
//           End;




////      if key ='-' then
////        begin //si décrémentation des references
////        key:=#0;
////        trouve:=false;
////        LastRef:=Edreference.text;
////        RefTmp:=strtoint(copy(LastRef,3,length(LastRef)-2));
////        if RefTmp-1>0 then
////           begin //si RefTmp-1>0
////               while not trouve do
////               begin //début du while
////                  inc(RefTmp,-1);
////                  if RefTmp>0 then
////                    begin
////                    NewRef:=inttostr(RefTmp);
////                      while length(NewRef)<7 do
////                      NewRef:='0'+NewRef;
////                    NewRef:=copy(LastRef,1,2)+NewRef;
////                    trouve:=piece1.RechercheReference(piece1.TablePiece,NewRef,'Reference','ID',FindID);
////                    end
////                    else
////                    break;
////               end;//fin du while
////           end;//si RefTmp-1>0
////             if trouve then
////               Edreference.text:=NewRef
////               else
////               Edreference.text:=LastRef;
////             Edreference.SelStart:=length(Edreference.text);
////          piece1.Reference:=Edreference.text;
////          end;//fin si décrémentation des references
////      piece1.Reference:=Edreference.text;
   End;



end;

procedure TPiecePointable.grPiecePointableBeforeNewLigne(sender: TObject;
  Arow: Integer);
begin
//rajoute une ligne vide dans la liste des réglements
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,0,Arow,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true],false,Arow,ListeReglement);

//grPiecePointable.col:=1;
//grPiecePointable.NewColonne:=1;
end;

procedure TPiecePointable.Annuler1Click(Sender: TObject);
begin
////
ModalResult:= mrCancel;
end;

procedure TPiecePointable.Modifier1Click(Sender: TObject);
begin
////
end;

procedure TPiecePointable.Supprimer1Click(Sender: TObject);
begin
grPiecePointable.SupprimeLigne(ligneCurr);
AfficheLigneBas(ligneCurr,true);
end;

procedure TPiecePointable.Aideenligne1Click(Sender: TObject);
begin
////
end;

procedure TPiecePointable.Visualisation1Click(Sender: TObject);
begin
if length(grPiecePointable.Cells[1,grPiecePointable.Row]) > 0 then
 begin
  if copy(grPiecePointable.Cells[1,grPiecePointable.Row],1,1)<>'+' then
   begin
   DetailEcritureCompte(grPiecePointable.Cells[1,grPiecePointable.Row],true,False);
   end
   else
   Begin
   DetailEcritureTiers(grPiecePointable.Cells[1,grPiecePointable.Row],true);
   End;
  end;
end;

procedure TPiecePointable.Imprimer1Click(Sender: TObject);
begin
/////
end;

procedure TPiecePointable.Enregister1Click(Sender: TObject);
var
Valide:boolean;
begin
Valide:=true;
grPiecePointableRowValidate(grPiecePointable,Valide,Valide,1);
ModalResult:= mrOk;
end;

procedure TPiecePointable.grPiecePointableBeforeSupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
var
rang:integer;
begin
try
RefSupp:='';
rang:=-1;
   if not (ListeReglement.Objects[Arow]as TReglementList).Vide then
   begin
   if Application.MessageBox(Pchar('Attention, si vous choisissez de Supprimer cette pièce, les pointages associés seront supprimés, Confirmez-vous votre choix !'),'Suppression Pièce',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
     begin
     RefSupp:=DMPieces.SuppressionPieceEcriture(grPiecePointable.cells[2,Arow],ObjReglement1.Piece);
     RefSupp:=grPiecePointable.cells[2,Arow];
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

rang:=listeNewReference.IndexOf(grPiecePointable.cells[2,arow]);
if rang<>-1 then
listeNewReference.Delete(rang);

if ((arow=1)and (arow=grPiecePointable.RowCount-1))then
//rajoute une ligne vide dans la liste des réglements
   ListReglementAdd_Insert([true,-1,'',-1,'',-1,0,Arow,'','','',false,
   0,0,'','',false,0,0,0,false,true,false,true],false,Arow,ListeReglement);
except
 abort;
end;
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


function TPiecePointable.gestionDerniereReference(Journal:string):string;
Var
valeurtmp:TReference;
ValeurNew:string;
begin
ValeurNew:= ObjReglement1.Piece.NewReference(ObjReglement1.Piece.TablePiece,'Reference',Journal,ObjReglement1.Piece.CodeExo,'');
if ListeReglementPointable.Count<>0 then
begin
  if ListeReglementPointable.IndexOf(ValeurNew)<>-1 then
  begin
    valeurtmp:=MaxReferenceDansListe(journal,1,2,ListeReglementPointable);
    if valeurtmp.retour then
      begin
      valeurtmp:=New_Reference_Epicea(valeurtmp.Reference,Journal,ObjReglement1.Piece.CodeExo);
      if valeurtmp.retour then
         result:= valeurtmp.Reference;
      end;
  end
  else
  result:=ValeurNew;
end
else
result:=ValeurNew;

end;


procedure TPiecePointable.paGrilleResize(Sender: TObject);
begin
grPiecePointable.ColWidths[0]:=10;
grPiecePointable.ColWidths[1]:=(grPiecePointable.Width) div 9;
grPiecePointable.ColWidths[2]:=(grPiecePointable.Width) div 9;
grPiecePointable.ColWidths[3]:=(grPiecePointable.Width) div 12;
grPiecePointable.ColWidths[4]:=(grPiecePointable.Width) div 3;
grPiecePointable.ColWidths[5]:=(grPiecePointable.Width) div 12;
grPiecePointable.ColWidths[6]:=(grPiecePointable.Width) div 12;
grPiecePointable.ColWidths[7]:=(grPiecePointable.Width) div 12;
grPiecePointable.ColWidths[8]:=(grPiecePointable.Width) div 12;
end;

procedure TPiecePointable.grPiecePointableRowEnter(sender: TObject;
  NewRow: Integer);
begin
ligneCurr:=NewRow;
ligneCourante:=grPiecePointable.Rows[NewRow].text;
  if (grPiecePointable.Oldcolonne=grPiecePointable.NewColonne) then
    begin
//    grPiecePointable.NewColonne:=1;
//    grPiecePointable.col:=grPiecePointable.NewColonne;
    grPiecePointableColEnter(grPiecePointable.oldcolonne,grPiecePointable.NewColonne,NewRow);
    end;
end;

procedure TPiecePointable.grPiecePointableCellClick(Colonne, Ligne: Integer);
begin
//CelluleSelect:=Colonne;
end;




procedure TPiecePointable.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if DMPointage.QueryRecupPointage.Active=true then
   DMPointage.QueryRecupPointage.close;
if dmpointage.QuLigneBanqueTiersEnCours.Active=true then
   dmpointage.QuLigneBanqueTiersEnCours.close;
if dmpointage.QuSumPointeCredit.Active=true then
   dmpointage.QuSumPointeCredit.close;
if dmpointage.QuSumPointeDebit.Active=true then
   dmpointage.QuSumPointeDebit.close;
if grPiecePointable.InplaceEditor <> nil
 then grPiecePointable.InplaceEditor.Hide;
end;



function TPiecePointable.RecupOptionSurClickButton:integer;
Begin
result:=0;
if SBPointables.Down then
   result:=2
else
  if SBDejaPointes.Down then
    result:=3;
if result=0 then
result:=2;
End;



function TPiecePointable.ListReglementIndexOf(valeur:string;valeurRech:integer):integer;
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

procedure TPiecePointable.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:=true;
end;

Procedure TPiecePointable.InitPaLibelle;
begin
PaLibelle.Caption:='Pièces ';
if SBPointables.Down then PaLibelle.Caption:=PaLibelle.Caption + SBPointables.Caption;
if SBDejaPointes.Down then PaLibelle.Caption:=PaLibelle.Caption + SBDejaPointes.Caption;
end;


procedure TPiecePointable.FormShow(Sender: TObject);
begin
//ObjReglement1.Piece:=saisieP.Piece1;
ObjReglement1.Piece:=DMPieces.Piece1;
ligneCurr:=1;
etatinitial;
   dmpointage.QuSumPointeCredit.close;
   dmpointage.QuSumPointeCredit.open;
   dmpointage.QuSumPointeDebit.close;
   dmpointage.QuSumPointeDebit.open;
//Initialise la grille en fonction de l'option d'affichage récupérée
PrepaAffichageSurOption(option,true);
InitPaLibelle;
////***Récupérer les paramètres de la pièce appelante pour afficher le reste à régler
//et autres informations


if ObjReglement1.Piece.SensPourReglement then
grPiecePointable.Rows[0].CommaText:=SaisieReglementGrReglementCommaTextCredit
else
grPiecePointable.Rows[0].CommaText:=SaisieReglementGrReglementCommaTextDebit;
DerniereRef:='';
AfficheLigneBas(lignecurr,true);
grPiecePointable.setfocus;
end;

procedure TPiecePointable.grPiecePointableKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if shift=[ssShift,ssCtrl] then key:=0;
end;
end.
