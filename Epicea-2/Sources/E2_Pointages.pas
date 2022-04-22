unit E2_Pointages;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Gr_Librairie_Obj, E2_Librairie_Obj, Buttons, LibZoneSaisie,
  ExtCtrls, GrGrid, LibSQL, Grids,Lib1,db, DBTables,DMPointages,ObjReglement,
  DBGrids,DMTier, RXCtrls, Mask, ToolEdit, CurrEdit,E2_Decl_Records,DmPiece,DMPointages2,
  jpeg;

type
TTypeCompte = (tcTous, tcComptable, tcTiers);


  TPointages = class(TForm)
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
    PaBtn: TPanel;
    BtnAnnuler: TButton;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    BtnImprimer: TButton;
    PaBas: TPanel;
    PaGrille: TPanel;
    paEntete: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    EdCompte: TEdit;
    Patitre: TPanel;
    LaSignePointer: TLabel;
    LaSigneReste: TLabel;
    GrPointage: TGrGrid;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    RxSpeedButton2: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    N3: TMenuItem;
    Prcdent1: TMenuItem;
    Suivant1: TMenuItem;
    EdLibelle: TEdit;
    Panel2: TPanel;
    LaTotalReste: TCurrencyEdit;
    laTotalPointer: TCurrencyEdit;
    PointageList1: TPointageList;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure Annuler1Click(Sender: TObject);
    procedure grPointageDblClick(Sender: TObject);
    procedure Enregister1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Aide1Click(Sender: TObject);
    procedure Visualisation1Click(Sender: TObject);
    procedure pmRglement1Click(Sender: TObject);
    procedure pmTriparDate1Click(Sender: TObject);
    procedure pmTriparMontant1Click(Sender: TObject);
    procedure pmTouteslescritures1Click(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
    procedure GestionFiltrageParamCpt;
    procedure Aideenligne1Click(Sender: TObject);
    procedure EtatInitial;
    procedure EdCompteExit(Sender: TObject);
    procedure EdCompteEnter(Sender: TObject);
    Procedure PositionLabel;
    procedure GrPointageRowEnter(sender: TObject; NewRow: Integer);
    procedure GrPointageEnter(Sender: TObject);
    procedure GrPointageRowValidate(Sender: TObject; var Valide,
      Action: Boolean; LastCol: Integer);
    procedure Imprimer1Click(Sender: TObject);
    procedure ChangementEtatBoutonsMenu(Etat:Tdatasetstate);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnFermerEnter(Sender: TObject);
    procedure BtnFermerExit(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    function LettreAutorise(OldLettre,LettreCourante,NewLettre:string):TErreurSaisie;
    procedure GrPointageColEnter(OldColonne, NewColonne, NewRow: Integer);
    procedure GrPointageColExit(OldColonne, LastRow: Integer);
    function CtrlSaisiePointage(Champ:string;Acol,CelluleSuivante,Ligne:integer):TErreurSaisie;
    function CalculTotalPointerSurSens(sens:boolean;valeur:currency;var Total:currency;var SensTotal:boolean):Currency;
    procedure FormActivate(Sender: TObject);
//    procedure Enregistrement;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrPointageKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GrPointageCellClick(Colonne, Ligne: Integer);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure GrPointageBeforeSupprLigne(sender: TObject; Arow: Integer;
      var NewRow: Integer);
    procedure PatitreResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure EdCompteKeyPress(Sender: TObject; var Key: Char);
    procedure TaCompteFilterRecordComptePointable(DataSet: TDataSet; var Accept: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Pointages: TPointages;
  CodeTmp:string;
  LigneCurr:integer;
  MessDerSub:boolean;
  TotalPointer:currency;
  ListePointages,ListeIDPointages:tstringlist;
//ListeLettres,ListeMaitres,ListeEsclaves:tstringlist;
  LettreTmp,LettreCurr,OldImputation:string;
  EtatPointage:tdatasetstate;
  supprODDeclaration:boolean;

Function KeyPressMontant(var Key: Char; Text :String; SelStart :Integer) :Boolean;
Function KeyPressCompte(var Key: Char; Text :String; TypeCompte :TTypeCompte; SelStart :Integer) :Boolean;
Function KeyPressDate(var Key: Char; Control :TWinControl) :Boolean;
procedure ListPointageAdd_Insert(Valeur:array of const;Add:boolean;Rang:integer;var Liste:Tstringlist);

implementation
{$R *.DFM}

Uses
  //Gr_Calculatrice,
  E2_Main, E2_AideCompte, DMBaseDonnee,
  DMPlanCpt;

const
	CTitreCol1 :Array [3..7] of String =
    ('Débit', 'Crédit', 'Reste', '', 'Montant');
	CTitreCol2 :Array [0..7] of String =
    ('Date', 'Référence', 'Libelle', 'Créance', 'Dette', 'à pointer', 'Let.', 'pointé');
	CColWidths :Array [0..7] of integer =
    (56, 74, 218, 90, 90, 104, 30, 90);


//******************************************************************************
procedure TPointages.Calculatrice1Click(Sender: TObject);
// F11
begin
	AfficheCalculatrice(ActiveControl);
end;

//******************************************************************************
procedure TPointages.Fermer1Click(Sender: TObject);
// Fermeture
begin
BtnFermerClick(sender);
end;

//******************************************************************************
procedure TPointages.FormCreate(Sender: TObject);
// Initialisation d'écran
Var i :integer;
begin
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
	Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
//   laNom.Color:= clWindow;
   laTotalReste.Color:= clWindow;
   laTotalPointer.Color:= clWindow;
//   LaSignePointer.Color:=clwindow;
//   LaSigneReste.Color:=clwindow;
   MessDerSub:=true;

//parametres grille
GrPointage.AjoutAuto:=false;
GrPointage.ColCount:=10;
GrPointage.Align:=alClient;
//GrPointage.Options:=[goFixedVertLine, goFixedHorzLine, goVertLine,goTabs,goHorzLine,goEditing,goAlwaysShowEditor];
GrPointage.Options:=[goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,goEditing, goTabs,goDrawFocusSelected];
GrPointage.RowCount:=2;
GrPointage.NumDecimal:=2;
GrPointage.Rows[0].CommaText:='," ",Date,Référence,Libellé,Créance,Dette,Sens,Reste,Let.,Imputation';

GrPointage.Champ.Add(Grtous);
GrPointage.Champ.Add(GrDate);
GrPointage.Champ.Add(Grtous);
GrPointage.Champ.Add(Grtous);
GrPointage.Champ.Add(Grcurr);
GrPointage.Champ.Add(Grcurr);
GrPointage.Champ.Add(Grtous);
GrPointage.Champ.Add(Grcurr);
GrPointage.Champ.Add(Grtous);
GrPointage.Champ.Add(Grcurr);

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);

if ListePointages=nil then
ListePointages:=TstringList.Create;
//if ListeLettres=nil then
//ListeLettres:=TstringList.Create;
//if ListeMaitres=nil then
//ListeMaitres:=TstringList.Create;
//if ListeEsclaves=nil then
//ListeEsclaves:=TstringList.Create;


end;

//******************************************************************************
procedure TPointages.FormDestroy(Sender: TObject);
// Destruction de l'écran
begin
  DestroyForm(Self,E.USer);
//  if ListePointages<>nil then
//    ListePointages.Free;
//if ListeLettres<>nil then
//ListeLettres.Free;
//if ListeMaitres<>nil then
//ListeMaitres.Free;
//if ListeEsclaves<>nil then
//ListeEsclaves.Free;
//if ListeIDPointages<>nil then
// ListeIDPointages.free;
// Pointages:=nil;

end;

//******************************************************************************

//******************************************************************************
procedure TPointages.PaGrilleResize(Sender: TObject);
// Redimensionne l'écran
begin
//765
grPointage.ColWidths[0]:=10;
grPointage.ColWidths[1]:=(grPointage.Width) div 9;
grPointage.ColWidths[2]:=(grPointage.Width) div 9;
grPointage.ColWidths[3]:=(grPointage.Width) div 3;
grPointage.ColWidths[4]:=(grPointage.Width) div 11;
grPointage.ColWidths[5]:=(grPointage.Width) div 11;
grPointage.ColWidths[6]:=(grPointage.Width) div 33;
grPointage.ColWidths[7]:=(grPointage.Width) div 11;
grPointage.ColWidths[8]:=(grPointage.Width) div 33;
grPointage.ColWidths[9]:=(grPointage.Width) div 11;
PositionLabel;
end;

//******************************************************************************
Procedure TPointages.PositionLabel;
// Gestion de la position des labes des totaux / aux colonnes
Var
	Rect,Rect1,Rect2 :TRect;
begin
	Rect:= grPointage.CellRect(7, 0);
	LaTotalReste.Left:= Rect.Left+5;
        LaTotalReste.Width:= Rect.Right-Rect.Left;
//        Rect1:=grPointage.CellRect(6, 0);
//        Rect2:=grPointage.CellRect(8, 0);
        LaSigneReste.Left:=LaTotalReste.Left-15;
//        LaSigneReste.Left:= (Rect1.right-(Rect2.Right-Rect2.Left))+5;
//        LaSigneReste.Width:=(Rect2.Right-Rect2.Left)-6;


	Rect:= grPointage.CellRect(9, 0);
	laTotalPointer.Left:= Rect.Left+5;
        laTotalPointer.Width:= Rect.Right-Rect.Left;
//        Rect1:=grPointage.CellRect(8, 0);
        LaSignePointer.Left:= laTotalPointer.Left-15;
//        LaSignePointer.Left:= Rect1.Left+5;
//        LaSignePointer.Width:= (Rect1.Right-Rect1.Left)-6;

End;





procedure TPointages.Annuler1Click(Sender: TObject);
// Rollback
begin
BtnAnnulerClick(sender); 
end;

//******************************************************************************
procedure TPointages.grPointageDblClick(Sender: TObject);
// Recopîe la dernière lettre saisie (pendant le lettrage)
begin
 if empty(GrPointage.Cells[8,LigneCurr])then
   GrPointage.Cells[8,LigneCurr]:=LettreCurr
 else
   Begin
     if GrPointage.Cells[8,LigneCurr]=LettreCurr then
        GrPointage.Cells[8,LigneCurr]:='';
   End;
end;

//******************************************************************************
procedure TPointages.Enregister1Click(Sender: TObject);
// Commit
begin
BtnEnregistrerClick(sender);
end;

//******************************************************************************
procedure TPointages.FormKeyPress(Sender: TObject; var Key: Char);
// Fermeture sur #27
begin
	if (Key = #27) then Self.Close;
end;


//******************************************************************************
procedure TPointages.Aide1Click(Sender: TObject);
// F1
begin
//si on est sur l'entete de la pièce
///////////////////
 If activecontrol = edCompte Then
  //Afficher aidecompte filtré
  begin
    MessDerSub:=false;
    GestionFiltrageParamCpt;
    AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],true,MessDerSub,false,true,true,true,1);
    MessDerSub:=true;
  end;//fin si activecontrol = edCompte
///////////////////
end;

//******************************************************************************
procedure TPointages.Visualisation1Click(Sender: TObject);
// F7 affichage de la pièce de la ligne en cours
begin
//
end;

//******************************************************************************
procedure TPointages.pmRglement1Click(Sender: TObject);
// Affiche les pointages de la ligne
begin
//
end;

//******************************************************************************
procedure TPointages.pmTriparDate1Click(Sender: TObject);
// Change l'ordre d'affichage dans la grille
begin
//
end;

//******************************************************************************
procedure TPointages.pmTriparMontant1Click(Sender: TObject);
// Change l'ordre d'affichage dans la grille
begin
//
end;

//******************************************************************************
procedure TPointages.pmTouteslescritures1Click(Sender: TObject);
// Affiche toutes les lignes du cptes
begin
//
end;


//******************************************************************************
procedure TPointages.pmMenu1Click(Sender: TObject);
// Popmenu
begin
PopupMenuPointage.Popup(Left + 50, Top + 50);
end;

procedure TPointages.GestionFiltrageParamCpt;
var
ListeCpt:TStringList;
begin
   try
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Pointages);

   ListeCpt:=TStringList.Create;
  // ListeCpt:=DMPlan.FiltrageParamCPT(24,e.Regime);
   ListeCpt:=DMPlan.FiltrageParamCPT(42,e.Regime);
   DMPlan.TaCompte.OnFilterRecord:=TaCompteFilterRecordComptePointable;
   AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
   aidecompte.InitialiseCompte;
   finally
   if ListeCpt<>nil then
   ListeCpt.Free;
   end;//fin du try finally
End;


//******************************************************************************
Function KeyPressMontant(var Key: Char; Text :String; SelStart :Integer) :Boolean;
Var
	AutoriseDecimal :Boolean;
 	p :Integer;
Begin
	if (key = '.') then key:= DecimalSeparator;

	p:= Pos(DecimalSeparator, Text) -1;
   AutoriseDecimal:= (p = -1){ Or (p = SelStart)};

   if not (Key in [#0..#31, '0'..'9',
   	ThousandSeparator]) And
      ((Key <> '-') or (SelStart > 0))
      And ((Key <> DecimalSeparator) or Not AutoriseDecimal) then Begin
		messagebeep(0);
		Key:= #0;
      Result:= False;
	End
	Else Result:= True;
End;

//******************************************************************************
Function KeyPressDate(var Key: Char; Control :TWinControl) :Boolean;
Var
	dt :TDateTime;
Begin
   if (key = #32) or (key = '.') then Begin
   	key:= DateSeparator;
      Result:= True;
   End
   Else if (Key In ['-', '+']) then Begin
   	if (Control is TCustomEdit) then
	   	dt:= StrToDate2(TCustomEdit(Control).Text)
      Else if (Control is TStringGrid) then
	   	dt:= StrToDate2(TgrGrid(Control).Cells[(TgrGrid(Control).col),(TgrGrid(Control).row)]);

      if (Dt = 0) then Dt:= SysUtils.Date
      Else if (Key = '-') then dt:= Dt -1
      Else						Dt:= Dt +1;


   	if (Control is TCustomEdit) then Begin
			TCustomEdit(Control).Text:= DateToStr(Dt);
	      TCustomEdit(Control).SelectAll;
      End
      Else if (Control is TgrGrid) then Begin
      	TgrGrid(Control).Cells[(TgrGrid(Control).col),(TgrGrid(Control).row)]:= DateToStr(Dt);
//         TGrid(Control).SelectAll;
      End;

      Key:= #0;
		Result:= False;
   End
	Else if not (Key in [#0..#31, '0'..'9', DateSeparator]) then Begin
		messagebeep(0);
      Key:= #0;
		Result:= False;
	End
	Else Result:= True;
End;

//******************************************************************************
Function KeyPressCompte(var Key: Char; Text :String; TypeCompte :TTypeCompte; SelStart :Integer) :Boolean;
Begin
   if not (Key in [#0..#31, '0'..'9', 'A'..'X', 'a'..'z'])
   	And ((Key <> '+') or (SelStart > 1) or (TypeCompte = tcComptable)) then Begin
		messagebeep(0);
		Key:= #0;
      Result:= False;
	End
	Else Begin
   	if (Key in ['a'..'z']) then Key:= Chr(Ord(Key) - 32);
   	Result:= True;
   End;
End;


procedure TPointages.Aideenligne1Click(Sender: TObject);
begin
WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);
end;


procedure TPointages.EtatInitial;
var
i:integer;
Begin
EdCompte.Clear;
edcompte.SetFocus;
GrPointage.OnRowValidate:=nil;
supprODDeclaration:=false;
for i:=1 to GrPointage.RowCount-1 do
GrPointage.Rows[i].Clear;
GrPointage.RowCount:=2;
GrPointage.row:=1;
LigneCurr:=1;
GrPointage.col:=8;
CodeTmp:='';
GrPointage.OnRowValidate:=GrPointageRowValidate;
grPointage.Repaint;
LettreTmp:='';
LettreCurr:='';
OldImputation:='';
LaTotalReste.Value:=0;
laTotalPointer.Value:=0;
LaSignePointer.Caption:='D';
LaSigneReste.Caption:='D';
EdLibelle.Text:='';
//laNom.caption:='';
TotalPointer:=0;
//ListePointages.Clear;
//ListeLettres.clear;
//if ((ListeMaitres<>nil)and(ListeMaitres.count<>0)) then
//ListeMaitres.clear;
//if ((ListeEsclaves<>nil)and(ListeEsclaves.count<>0)) then
//ListeEsclaves.clear;

//rajoute deux lignes vides dans la liste des réglements
ListPointageAdd_Insert(['','','',0,'',false,false,true,false],true,-1,ListePointages);
ListPointageAdd_Insert(['','','',0,'',false,false,true,false],true,-1,ListePointages);
EtatPointage:=dsbrowse;
ChangementEtatBoutonsMenu(EtatPointage);
End;


procedure TPointages.EdCompteExit(Sender: TObject);
var
Valide: boolean;
Tab:variant;
i:integer;
TotalReste:currency;
compteTmp:string;
conteneurVerrou:TVerrouillage;
begin
valide:=true;
TotalReste:=0;
GestionFiltrageParamCpt;
if ((activecontrol<>btnannuler)and(activecontrol<>btnfermer))then
if ((CodeTmp<>edcompte.Text) or (empty(edcompte.text)))then
   Begin
   valide:=AideCompteDansContexte(edCompte.Text,edCompte,['Rac1'],false,MessDerSub,true,true,true,true,1);
   if valide then
   begin
   valide:=DMPlan.CptEstPointable(edcompte.text);
   if not valide then
     showmessage('Ce compte n''est pas pointable');
   end;
      try
      if not valide then
        Edcompte.SetFocus
      else
        Begin //si valide
        GrPointage.OnEnter:=nil;
        GrPointage.OnRowEnter:=nil;
        compteTmp:=EdCompte.Text;
        EtatInitial;
        EdCompte.Text:=compteTmp;
          if copy(edcompte.text,1,1)='+'then
          EdLibelle.Text:=RenvoieInfoSurTableDiverse(Edcompte.Text,DMTiers.TaTiers,'Tiers',['Nom'],Tab)
// PB          laNom.Caption:=RenvoieInfoSurTableDiverse(Edcompte.Text,DMTiers.TaTiers,'Tiers',['Nom'],Tab)
          else
          EdLibelle.Text:=RenvoieInfoSurTableDiverse(Edcompte.Text,DMPlan.TaPlanCpt,'Compte',['Libelle'],Tab);
// PB          laNom.Caption:=RenvoieInfoSurTableDiverse(Edcompte.Text,DMPlan.TaPlanCpt,'Compte',['Libelle'],Tab);
          dmpieces.QuRecupPieceTvaTypeE.close;
          dmpieces.QuRecupPieceTvaTypeE.open;
          DMPointage.RecupPiecePointableSurTiers_Et_Journal_PourPointages(edcompte.Text,'(1,2,3,4)');

          if DMPointage.QuLigneBanqueTiersEnCours.RecordCount<>0 then
             Begin //s'il y a des lignes à pointer
             //affichage des lignes à pointer
             i:=1;
             DMPointage.QuLigneBanqueTiersEnCours.First;
             DMPointage.QueryRecupPointage.First;
                while not(DMPointage.QuLigneBanqueTiersEnCours.eof)do
                Begin//début du while not eof
                   if i>1 then
                   begin
                   GrPointage.AjouteLigne;
                   ListPointageAdd_Insert(['','','',0,'',false,false,true,false],true,-1,ListePointages);
                   end;
                   //récupérer les infos verrouillage
                   conteneurVerrou:=PointageList1.Piece.RetourneInfosVerrouillageSurPiece(nil,DMPointage.QueryRecupPointage.findfield('IDPiece').asinteger,DMPointage.QueryRecupPointage.findfield('Date').asdatetime);
                   (ListePointages.Objects[i]as TPointageList).InfosVerrouillage:=conteneurVerrou;

                   GrPointage.Cells[1,i]:=DMPointage.QueryRecupPointage.findfield('Date').asstring;
                   GrPointage.Cells[2,i]:=DMPointage.QueryRecupPointage.findfield('Reference').asstring;
                   GrPointage.Cells[3,i]:=DMPointage.QueryRecupPointage.findfield('Libelle').asstring;
                   GrPointage.Cells[4,i]:=DMPointage.QueryRecupPointage.findfield('DebitSaisie').asstring;
                   GrPointage.Cells[5,i]:=DMPointage.QueryRecupPointage.findfield('CreditSaisie').asstring;
                   if DMPointage.QueryRecupPointageSensReglement.AsBoolean then
                      GrPointage.Cells[6,i]:='C'
                   else
                      GrPointage.Cells[6,i]:='D';
                   (ListePointages.Objects[i]as TPointageList).Sens:=GrPointage.Cells[6,i];
                   GrPointage.Cells[7,i]:=DMPointage.QuLigneBanqueTiersEnCoursResteAPointer.AsString;
                   if DMPointage.QueryRecupPointage.findfield('TypeTvaE').asstring='E'then
                     (ListePointages.Objects[i]as TPointageList).TypeTvaE:=true;
                   (ListePointages.Objects[i]as TPointageList).IDEcriture:=DMPointage.QueryRecupPointage.findfield('ID').asinteger;
                   if not DMPointage.QueryRecupPointageSensReglement.AsBoolean then
                     TotalReste:=TotalReste-strtoCurr(GrPointage.Cells[7,i])
                   else
                     TotalReste:=TotalReste+strtoCurr(GrPointage.Cells[7,i]);
                   TotalReste:=ArrondiCentieme(TotalReste);

                   DMPointage.QueryRecupPointage.Next;
                   DMPointage.QuLigneBanqueTiersEnCours.Next;
                   inc(i);
                End;//fin du while not eof
                if copy(currtostr(TotalReste),1,1)='-'then
                  begin
                  LaSigneReste.Caption:='D';
                  LaTotalReste.Value:=TotalReste;
//  PB                LaTotalReste.Caption:=copy(currtostr(TotalReste),2,length(currtostr(TotalReste)));
                  end
                else
                  Begin
                  LaSigneReste.Caption:='C';
                  LaTotalReste.Value:=TotalReste;
                  End;
              GrPointage.SetFocus;
              GrPointage.Row:=1;
              lignecurr:=1;
             CodeTmp:=edcompte.text;
             End//fin s'il y a des lignes à pointer
          else
             begin
              if  ((ActiveControl <> btnAnnuler) and (ActiveControl <> BtnFermer)) then
                begin
                if copy(edcompte.text,1,1)='+' then
                   showmessage('Il n''y a pas de lignes à pointer sur le tiers '+edcompte.Text)
                else
                   showmessage('Il n''y a pas de lignes à pointer sur le compte '+edcompte.Text);
                edcompte.SetFocus;
                end;
             end;
        End;//fin si valide
      finally
        GrPointage.OnEnter:=GrPointageEnter;
        GrPointage.OnRowEnter:=GrPointageRowEnter;
      end;//fin du try finally
   End;
end;

procedure TPointages.EdCompteEnter(Sender: TObject);
begin
//CodeTmp:='';
CodeTmp:=EdCompte.Text;
end;

procedure TPointages.GrPointageRowEnter(sender: TObject; NewRow: Integer);
begin
LigneCurr:=NewRow;
//   try
//    if grPointage.col=GrPointage.NewColonne then
//      begin
//      GrPointageColExit(grPointage.col,lignecurr);
//      GrPointageColEnter(grPointage.col,GrPointage.NewColonne,NewRow);
//      end;
//   except
//     abort;
//   end;//fin du try except

end;

procedure TPointages.GrPointageEnter(Sender: TObject);
begin
GrPointage.Row:=1;
GrPointage.col:=8;
GrPointage.NewColonne:=8;
LigneCurr:=1;
GrPointageRowEnter(GrPointage,LigneCurr);
end;

procedure TPointages.GrPointageRowValidate(Sender: TObject; var Valide,
  Action: Boolean; LastCol: Integer);
var
SaisiePointage:TErreurSaisie;
i:integer;
begin
   try
   for i:=8 to GrPointage.ColCount-1 do
     begin//début boucle for
     SaisiePointage:=CtrlSaisiePointage(GrPointage.cells[i,grPointage.row],i,i+1,GrPointage.row);
        if  SaisiePointage.retour=false then
          case SaisiePointage.CodeErreur of
          8001:begin //compte vide
               abort;
               end;
          9001:begin //compte vide
               abort;
               end;
          end;//fin du case
     end;//fin boucle for
   except
     abort;
   end;//fin du try except
end;



procedure TPointages.Imprimer1Click(Sender: TObject);
begin
BtnImprimerClick(sender);
end;

procedure TPointages.ChangementEtatBoutonsMenu(Etat:Tdatasetstate);
Begin
//changement d'état des boutons et menu après chaque changemement d'étatPiece
  case Etat of
  dsbrowse:Begin//début etat=DsBrowse
            //Boutons
            EnableWinControl([BtnAnnuler,BtnFermer,BtnImprimer],true);
            EnableWinControl([BtnEnregistrer,BtnInserer,BtnSupprimer,BtnModifier],False);
            //Pop menu grille
            EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Imprimer1,Calculatrice1,
            Annuler1,Fermer1,pmTouteslescritures1,pmAutomatique1,pmTriparDate1,pmTriparMontant1,pmRglement1],true);
            EnableItemMenu([Enregister1],false);
            end;//fin etat=DsBrowse
  dsinsert:Begin//début etat=dsinsert
            //Boutons
            EnableWinControl([BtnEnregistrer,BtnAnnuler,BtnFermer,BtnImprimer],true);
            EnableWinControl([BtnInserer,BtnSupprimer,BtnModifier],False);
            //Pop menu grille
            EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Imprimer1,Calculatrice1,
            Enregister1,Annuler1,Fermer1,pmTouteslescritures1,pmAutomatique1,pmTriparDate1,pmTriparMontant1,pmRglement1],true);
            //EnableItemMenu([],false);
            end;//fin etat=dsinsert
  dsEdit:Begin//début etat=dsEdit
            //Boutons
            EnableWinControl([BtnEnregistrer,BtnAnnuler,BtnFermer,BtnImprimer],true);
            EnableWinControl([BtnInserer,BtnSupprimer,BtnModifier],False);
            //Pop menu grille
            EnableItemMenu([Aideenligne1,Aide1,Visualisation1,Imprimer1,Calculatrice1,
            Enregister1,Annuler1,Fermer1,pmTouteslescritures1,pmAutomatique1,pmTriparDate1,pmTriparMontant1,pmRglement1],true);
            //EnableItemMenu([],false);
            end;//fin etat=dsEdit
  end;//fin du case Etat
end;


procedure TPointages.BtnFermerClick(Sender: TObject);
begin
  if BtnFermer.Enabled then
  begin
  //avant de fermer, si en modification ou insertion demander si on veut enregistrer
  self.Close;
  end;
end;

procedure TPointages.BtnFermerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TPointages.BtnFermerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TPointages.BtnAnnulerClick(Sender: TObject);
var
comptetmp:string;
begin
//self.close;
//si Modification, demander si annuler les modifications
//puis initialiser la fenêtre
//sinon
//initialiser la fenêtre directement
try
if ActiveControl=GrPointage then
  Begin
    if ((EtatPointage in [dsinsert,dsedit])and(((not GrPointage.LigneVide(1))or(GrPointage.RowCount>2)))) then
     begin //si etatpointage en modification
       if BtnEnregistrer.Enabled then
          Begin
            if application.MessageBox(Pchar(' Voulez-vous enregistrer les pointages en cours ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
           // If Messagedlg('Voulez-vous enregistrer les pointages en cours ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
               BtnEnregistrerClick(btnenregistrer)
            else
               Begin
                 comptetmp:=edcompte.text;
                 etatinitial;
                 edcompte.setfocus;
                 edcompte.Text:=comptetmp;
               End;
          End
       else
          Begin
            if application.MessageBox(Pchar(' Voulez-vous annuler les pointages en cours ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes then
           // If Messagedlg('Voulez-vous annuler les pointages en cours ?',MtConfirmation,[mbno,mbyes],0) = mryes Then
                Begin
                 comptetmp:=edcompte.text;
                 etatinitial;
                 edcompte.setfocus;
                 edcompte.Text:=comptetmp;
                End
                else
                abort;
          End;
     end;//fin si etatpointage en modification
  End
else
  begin
   EdCompte.SetFocus;
   etatinitial;
  End;
except
  abort;
end;
end;

procedure TPointages.BtnEnregistrerClick(Sender: TObject);
var
valide,act:boolean;
i:integer;
ListeLettres:Tstringlist;
begin
try//finally
  try//except
  valide:=true;
  act:=true;
  GrPointageRowValidate(GrPointage,valide,act,GrPointage.oldcolonne);
  valide:=TotalPointer=0;  
  if valide then
    Begin
       if DMPointage.TaPointage.active=false then
           DMPointage.TaPointage.open;

       if ListeIDPointages=nil then
        ListeIDPointages:=tstringlist.Create;
        ListeIDPointages.Clear;
        ListeLettres:=tstringlist.Create;

       If not DMPointage.TaPointage.Database.InTransaction then
          Begin
            DMPointage.TaPointage.Database.StartTransaction;
            DMPointage.TaPointage.Database.TransIsolation:=tiDirtyRead;
          End;
       //si besoin, suppression de la dernière OD de déclaration
        if supprODDeclaration then
          Begin
            //Supprimer la dernière OD de déclaration
            //DMPieces.SuppressionOD();
          End;
         for i:=1 to GrPointage.RowCount-1 do
            begin
               if not empty(GrPointage.Cells[8,i]) then
                  begin
                    if ListeLettres.IndexOf(GrPointage.Cells[8,i])=-1 then
                       ListeLettres.Add(GrPointage.Cells[8,i]);
                  end;
            end;

      DMPointage2.EnregistrementPointages(ListePointages,ListeLettres,ListeIDPointages,EdCompte.Text,true);
      EtatInitial;
    End
  else
    Begin
     if totalPointer<>0 then
       showmessage('Les pointages ne sont pas équilibrés');
     GrPointage.SetFocus;
     abort;
    End;
    
  except
  abort;
  end;//fin du try except
finally
if ListeLettres<>nil then
  ListeLettres.Free
end;//fin du finally
end;

procedure TPointages.BtnImprimerClick(Sender: TObject);
begin
//Imprimer les pointages
end;


function TPointages.CtrlSaisiePointage(Champ:string;Acol,CelluleSuivante,Ligne:integer):TErreurSaisie;
var
Signe,calcul,Enregistrer:boolean;
Autorise:TErreurSaisie;
Begin
 calcul:=false;
 result.CodeErreur:=0;
 result.retour:=true;
 Enregistrer:=true;
// if GrPointage.OldRow<>ligne then
// beep;
try
   case Acol of
   8:Begin //si colonne lettrage
//   showmessage((ListePointages.Objects[LigneCurr]as TPointageList).lettre);
       if trim((ListePointages.Objects[GrPointage.OldRow]as TPointageList).lettre)<>trim(GrPointage.Cells[8,GrPointage.OldRow]) then
          begin //si modification de la lettre
            if not empty(GrPointage.Cells[8,GrPointage.OldRow]) then
               begin//si champ lettre non vide
                 Autorise:=LettreAutorise((ListePointages.Objects[GrPointage.OldRow]as TPointageList).lettre,LettreCurr,GrPointage.Cells[8,GrPointage.OldRow]);
                   if Autorise.retour then
                     begin
                       calcul:=true;
                       LettreCurr:=GrPointage.Cells[8,GrPointage.OldRow];
                     end
                   else
                     Begin
                       Enregistrer:=false;
                       if Autorise.CodeErreur=0 then
                         Application.MessageBox(Pchar('Vous devez équilibrer le pointage en cours avant de pouvoir saisir une nouvelle lettre !!!'),'Erreur de saisie',0);
                       result.CodeErreur:=8001;
                       result.retour:=false;
                       abort;
                     End;
                 if ((empty(GrPointage.Cells[9,GrPointage.OldRow]))or(GrPointage.Cells[9,GrPointage.OldRow]='0'))then
                   //si pas d'imputation
                   GrPointage.Cells[9,GrPointage.OldRow]:=GrPointage.Cells[7,GrPointage.OldRow];
                   //(ListePointages.Objects[LigneCurr]as TPointageList).Imputation:=GrPointage.cells[8,lignecurr];
               end //si champ lettre non vide
            else
                Begin//si champ lettre vide
                  GrPointage.Cells[9,GrPointage.OldRow]:='0';
                  //(ListePointages.Objects[LigneCurr]as TPointageList).Imputation:=GrPointage.cells[8,lignecurr];
                  calcul:=true;
                End;//fin si champ lettre  vide
            if ((calcul)and(GrPointage.Cells[9,GrPointage.OldRow]<>(ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation)) then
              begin//si calcul
               if (ListePointages.Objects[GrPointage.OldRow]as TPointageList).Sens='D'then
                 begin
                 if not empty((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation)then
                   // totalPointer:=strtocurr(laTotalPointer.Caption)+strtocurr((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation);
                   totalPointer:=totalPointer+strtocurr((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation);
                 if not empty(grpointage.cells[9,GrPointage.OldRow])then
                 laTotalPointer.Value:=CalculTotalPointerSurSens(false,strtocurr(grpointage.cells[9,GrPointage.OldRow]),totalpointer,Signe)
//                 laTotalPointer.Caption:=currtostr(CalculTotalPointerSurSens(false,strtocurr(grpointage.cells[9,GrPointage.OldRow]),totalpointer,Signe))
                 end
               else
                 begin
                 if not empty((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation)then
                    //totalPointer:=strtocurr(laTotalPointer.Caption)-strtocurr((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation);
                    totalPointer:=totalPointer-strtocurr((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation);
                 if not empty(grpointage.cells[9,GrPointage.OldRow])then
                 laTotalPointer.Value:=CalculTotalPointerSurSens(true,strtocurr(grpointage.cells[9,GrPointage.OldRow]),totalpointer,Signe);
//                 laTotalPointer.Caption:=currtostr(CalculTotalPointerSurSens(true,strtocurr(grpointage.cells[9,GrPointage.OldRow]),totalpointer,Signe));
                 end;
               if totalPointer=0 then
                  LaSignePointer.Caption:=''
               else
                  begin
                  if signe then
                  LaSignePointer.Caption:='C'
                  else
                  LaSignePointer.Caption:='D';
                  end;
              end;//fin si calcul
          if enregistrer then
             begin
             (ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation:=GrPointage.cells[9,GrPointage.OldRow];
             (ListePointages.Objects[GrPointage.OldRow]as TPointageList).Pointer:=GrPointage.cells[9,GrPointage.OldRow];
             (ListePointages.Objects[GrPointage.OldRow]as TPointageList).lettre:=GrPointage.cells[8,GrPointage.OldRow];
               if EtatPointage=dsbrowse then
                  EtatPointage:=dsedit;
               if ((EtatPointage=dsedit)and(totalPointer=0)) then
                  ChangementEtatBoutonsMenu(EtatPointage);
             end;
          end;//fin si modification de la lettre
     End;//fin si colonne lettrage
   9:Begin//si colonne Imputation
        if trim((ListePointages.Objects[GrPointage.OldRow]as TPointageList).imputation)<>trim(GrPointage.Cells[9,GrPointage.OldRow]) then
          Begin //si modification du champ
          if empty(GrPointage.cells[8,GrPointage.OldRow])then //si champ lettre vide alors
             GrPointage.cells[9,GrPointage.OldRow]:='0'   // vider l'imputation
             else
             begin//si champ lettre remplie
                if not empty(GrPointage.Cells[9,GrPointage.OldRow])then
                begin//si champ imputation remplie
                if strtocurr(GrPointage.Cells[9,GrPointage.OldRow])>strtocurr(GrPointage.cells[7,GrPointage.OldRow])then
                   Begin//si imputation supérieure au reste à pointer
                     enregistrer:=false;
                     Application.MessageBox(Pchar('L''imputation ne peut être supérieure au reste à pointer !!!'),'Erreur de saisie',0);
                     result.CodeErreur:=9001;
                     result.retour:=false;
                   End//fin si imputation supérieure au reste à pointer
                else
                   Begin //si imputation inférieur ou égale au reste à pointer
                     //on recalcul le totalPointé
                  if (ListePointages.Objects[GrPointage.OldRow]as TPointageList).Sens='D'then
                    begin
                    if not empty((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation)then
                       //totalPointer:=totalPointer+strtocurr((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation);
                       totalPointer:=totalPointer+strtocurr((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation);
                    if not empty(grpointage.cells[9,GrPointage.OldRow])then
                    laTotalPointer.Value:=CalculTotalPointerSurSens(false,strtocurr(grpointage.cells[9,GrPointage.OldRow]),totalpointer,Signe)
//                    laTotalPointer.Caption:=currtostr(CalculTotalPointerSurSens(false,strtocurr(grpointage.cells[9,GrPointage.OldRow]),totalpointer,Signe))
                    end
                  else
                    begin
                    if not empty((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation)then
                       totalPointer:=totalPointer-strtocurr((ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation);
                    if not empty(grpointage.cells[9,GrPointage.OldRow])then
                    laTotalPointer.value:=CalculTotalPointerSurSens(true,strtocurr(grpointage.cells[9,GrPointage.OldRow]),totalpointer,Signe);
//                    laTotalPointer.Caption:=currtostr(CalculTotalPointerSurSens(true,strtocurr(grpointage.cells[9,GrPointage.OldRow]),totalpointer,Signe));
                    end;
                  if totalPointer=0 then
                     LaSignePointer.Caption:=''
                  else
                     begin
                     if signe then
                     LaSignePointer.Caption:='C'
                     else
                     LaSignePointer.Caption:='D';
                     end;
                   if GrPointage.Cells[9,GrPointage.OldRow]='0' then
                        GrPointage.cells[8,GrPointage.OldRow]:='';
                   End;//fin si imputation inférieur ou égale au reste à pointer
                end//fin si champ imputation remplie
                else
                  begin
                  GrPointage.cells[9,GrPointage.OldRow]:='0';
                  GrPointage.cells[8,GrPointage.OldRow]:='';
                  end;
             end;//fin si champ lettre remplie
          if enregistrer then
             begin
             (ListePointages.Objects[GrPointage.OldRow]as TPointageList).Imputation:=GrPointage.cells[9,GrPointage.OldRow];
             (ListePointages.Objects[GrPointage.OldRow]as TPointageList).Pointer:=GrPointage.cells[9,GrPointage.OldRow];
             (ListePointages.Objects[GrPointage.OldRow]as TPointageList).lettre:=GrPointage.cells[8,GrPointage.OldRow];
               if EtatPointage=dsbrowse then
                  EtatPointage:=dsedit;
               if ((EtatPointage=dsedit)and(totalPointer=0)) then
                  ChangementEtatBoutonsMenu(EtatPointage);
             end;
          End;//fin si modification du champ
     End;//fin si colonne Imputation
   end;//fin du case Acol
except
 abort;
end;
End;


function TPointages.CalculTotalPointerSurSens(sens:boolean;valeur:currency;var Total:currency;var SensTotal:boolean):Currency;
var
i:integer;
Begin
result:=0;
for i:=1 to GrPointage.RowCount-1 do
  Begin
    if not empty(GrPointage.cells[9,i])then
       if (ListePointages.Objects[i]as TPointageList).Sens='D'then
          result:=result-strtocurr(GrPointage.cells[9,i])
       else
          result:=result+strtocurr(GrPointage.cells[9,i]);
  End;
  if copy(currtostr(result),1,1)='-'then
    Begin
      result:=strtocurr(copy(currtostr(result),2,length(currtostr(result))));
      SensTotal:=false;
    End
  else
    Begin
      SensTotal:=true;
    End;
  Total:=result;    
End;


function TPointages.LettreAutorise(OldLettre,LettreCourante,NewLettre:string):TErreurSaisie;
     //Calcul le total de la colonne des Imputations
     function CalculTotalColonneImputation:currency;
     var
     i:integer;
//     ListePointageLettre:Tstringlist;
     Begin
     result:=0;
//     ListePointageLettre:=Tstringlist.Create;
     if not empty(oldlettre) then
       Begin//si Oldlettre remplie
         //reverifier le solde pour cette lettre
         for i:=1 to GrPointage.RowCount-1 do
           Begin
              if GrPointage.cells[8,i]=oldlettre then
           //     ListePointageLettre.Add(currtostr(GrPointage.cells[9,i]));
                if (ListePointages.Objects[i]as TPointageList).Sens='D'then
                   result:=result-strtocurr(GrPointage.cells[9,i])
                else
                   result:=result+strtocurr(GrPointage.cells[9,i]);
           End;
       End //fin si Oldlettre remplie
       else
       Begin //si Oldlettre vide
         if ((not empty(LettreCourante))and(not empty(NewLettre))) then
           begin//si lettrecourante remplie et NewLettre remplie
           if LettreCourante<>NewLettre then
              for i:=1 to GrPointage.RowCount-1 do
              begin //début boucle for
                if ((not empty(GrPointage.cells[9,i]))and((GrPointage.cells[8,i])=LettreCourante))then
                   Begin //si imputation remplie et lettre de la cellule active=lettre
                   //regarder si imputation au débit ou au crédit
                   //puis calculer le totalPointer en fonction
                     if (ListePointages.Objects[i]as TPointageList).Sens='D'then
                        result:=result-strtocurr(GrPointage.cells[9,i])
                     else
                        result:=result+strtocurr(GrPointage.cells[9,i]);
                   End;//fin si imputation remplie et lettre de la cellule active=lettre
              end;//fin boucle for
           end;//fin si lettrecourante remplie et NewLettre remplie
       End;//fin si Oldlettre vide
     End;//fin du calcul de la colonne Imputation
//Début du corp de la procédure d'autorisation de changement de lettre
var
messages:string;
TypeE,PV,Deverrouillable:boolean;
i:integer;
Begin
result.retour:=true;
result.CodeErreur:=0;
messages:='';
TypeE:=false;
PV:=false;
Deverrouillable:=false;
 if CalculTotalColonneImputation<>0 then
    Begin
      result.retour:=false;
    End
 else
   Begin
     //rechercher dans les lignes lettrées avec lettre courante
     //si il y a du typeTvaE
     i:=0;
     while ((i<=GrPointage.RowCount-1)and(not TypeE)) do
        Begin
           if GrPointage.cells[8,i]=NewLettre then
             begin
             if (ListePointages.Objects[i]as TPointageList).TypeTvaE then
                TypeE:=true;
             end;
           inc(i);
        End;
     i:=0;
     while ((i<=GrPointage.RowCount-1)and(not PV)and(not deverrouillable)) do
        Begin
           if GrPointage.cells[8,i]=NewLettre then
             begin
               PV:=(ListePointages.Objects[i]as TPointageList).InfosVerrouillage.PeriodeVerrouillee;
               if PV Then
                 Deverrouillable:=(ListePointages.Objects[i]as TPointageList).InfosVerrouillage.Deverrouillable;
             end;
        inc(i);
        End;
   if typeE then
     begin
     if (ListePointages.Objects[lignecurr]as TPointageList).InfosVerrouillage.PeriodeVerrouillee then
        if (ListePointages.Objects[lignecurr]as TPointageList).InfosVerrouillage.Deverrouillable then
          begin
           if not supprODDeclaration then
             begin
             messages:='Cette pièce fait partie d''une période de TVA déclarée, si vous la pointez avec une pièce qui comporte de la TVA sur encaissement, l''OD de déclaration de TVA sera supprimée , confirmez-vous ce pointage ?';
             supprODDeclaration:=true;
             end;
          end
        else
          messages:='Cette pièce fait partie d''une période de TVA déclarée, si vous la pointez avec une pièce qui comporte de la TVA sur encaissement, cette part de TVA sera déclarée dans la période du   au    , confirmez-vous ce pointage ?';
     end
   else
     if PV then
       Begin
          if (ListePointages.Objects[lignecurr]as TPointageList).TypeTvaE then
            if deverrouillable then
              begin
              if not supprODDeclaration then
                begin
                messages:='Cette pièce comporte une part de TVA sur encaissement, si vous la pointez avec une pièce qui fait partie d''une période de TVA déclarée, l''OD de déclaration de TVA sera supprimée, confirmez-vous ce pointage ?';
                supprODDeclaration:=true;
                end;
              end
            else
               messages:='Cette pièce comporte une part de TVA sur encaissement, si vous la pointez avec une pièce qui fait partie d''une période de TVA déclarée, cette part de TVA sera déclarée dans la période du   au    , confirmez-vous ce pointage ?';
       End;
   if not empty(messages)then
     begin
     result.retour:=application.MessageBox(Pchar(messages),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON1)=mryes;
     result.CodeErreur:=1;
     if result.retour=false then
       supprODDeclaration:=false;
     end;
   End;
End;


procedure TPointages.GrPointageColEnter(OldColonne, NewColonne,
  NewRow: Integer);
begin
   try
     if GrPointage.NewColonne in [1,2,3,4,5,6,7] then
       Begin
         GrPointage.OnColEnter:=nil;
         GrPointage.OnColExit:=nil;
         GrPointage.NewColonne:=8;
         GrPointage.col:=8;
         GrPointage.row:=newrow;
         abort;
       End;
   finally
      GrPointage.OnColEnter:=GrPointageColEnter;
      GrPointage.OnColExit:=GrPointageColExit;
   end;//fin du try finally
end;

procedure TPointages.GrPointageColExit(OldColonne, LastRow: Integer);
var
valide:TErreurSaisie;
begin
valide:=CtrlSaisiePointage(GrPointage.cells[GrPointage.oldColonne,Lastrow],GrPointage.Oldcolonne,GrPointage.newcolonne,GrPointage.row);
   if  valide.retour=false then
   Begin
     case valide.CodeErreur of
     8001:begin //compte vide
          abort;
          end;
     9001:begin //Référence pas correct
          abort;
          end;
     end;//fin du case codeErreur
   End;
end;


procedure TPointages.FormActivate(Sender: TObject);
begin
DMPlan.TaCompte.OnFilterRecord:=nil;
EtatInitial;
Patitre.visible:=Main.AfficheTitre;

GrPointage.ParamColor:=true;
GrPointage.Param:=ParamUtil.CouleurDBGrid;
GrPointage.UpDateColor;

end;


procedure ListPointageAdd_Insert(Valeur:array of const;Add:boolean;Rang:integer;var Liste:Tstringlist);
var
i:integer;
retourboolean:TRetourBool;
NewPointage:TPointageList;
RetourTranstypage:TTypeTranstypage;
conteneurVerrou:TVerrouillage;
Begin
NewPointage:=TPointageList.Create(Pointages);
       for i:=0 to high(valeur)do
       begin
       RetourTranstypage:=VTypeTranstypage(valeur[i],valeur[i].vtype);
           if  RetourTranstypage.retour then
           begin
              case i mod 9 of
              0:NewPointage.Lettre:=RetourTranstypage.valeur;
              1:NewPointage.Imputation:=RetourTranstypage.valeur;
              2:NewPointage.Sens:=RetourTranstypage.valeur;
              3:NewPointage.IDEcriture:=strtoint(RetourTranstypage.valeur);
              4:NewPointage.Pointer:=RetourTranstypage.valeur;
              5:begin
                conteneurVerrou:=NewPointage.InfosVerrouillage;
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                  conteneurVerrou.PeriodeVerrouillee:=retourboolean.valeur;
                NewPointage.InfosVerrouillage:=conteneurVerrou;
                end;
              6:begin
                conteneurVerrou:=NewPointage.InfosVerrouillage;
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                  conteneurVerrou.PieceVerrouillee:=retourboolean.valeur;
                NewPointage.InfosVerrouillage:=conteneurVerrou;
                end;
              7:begin
                conteneurVerrou:=NewPointage.InfosVerrouillage;
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                  conteneurVerrou.Deverrouillable:=retourboolean.valeur;
                NewPointage.InfosVerrouillage:=conteneurVerrou;
                end;
              8:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                NewPointage.TypeTvaE:=retourboolean.valeur;
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
    Liste.Addobject(inttostr(Rang),NewPointage);
    end
    else
      if rang<>-1 then
      Liste.Insertobject(rang,inttostr(Rang),NewPointage);
End;



//procedure TPointages.Enregistrement;
//var
//i,j,rangMaitre,rangEsclave:integer;
//LettreCourante:string;
//NewPointage:TPointageList;
//ResteItemMaitre,ValeurAPointer:currency;
//RecordPointage:variant;
//listetemp,ListeLettres:tstringlist;
//IDPointage:integer;
//begin
////récupérer les différentes lettres
//   try//debut du try finally
//       try//début du try except
//       if DMPointage.TaPointage.active=false then
//           DMPointage.TaPointage.open;
//
//       if ListeIDPointages=nil then
//        ListeIDPointages:=tstringlist.Create;
//        ListeIDPointages.Clear;
//
//       if ListeLettres=nil then
//        ListeLettres:=tstringlist.Create;
//        ListeLettres.Clear;
//
//
//       If not DMPointage.TaPointage.Database.InTransaction then
//          Begin
//            DMPointage.TaPointage.Database.StartTransaction;
//            DMPointage.TaPointage.Database.TransIsolation:=tiDirtyRead;
//          End;
//       //si besoin, suppression de la dernière OD de déclaration
//        if supprODDeclaration then
//          Begin
//            //Supprimer la dernière OD de déclaration
//            //DMPieces.SuppressionOD();
//          End;
//         for i:=1 to GrPointage.RowCount-1 do
//            begin
//               if not empty(GrPointage.Cells[8,i]) then
//                  begin
//                    if ListeLettres.IndexOf(GrPointage.Cells[8,i])=-1 then
//                       ListeLettres.Add(GrPointage.Cells[8,i]);
//                  end;
//            end;
//         ListeLettres.Sorted:=true;
//         if ListeLettres.Count<>0 then
//            begin//s'il y au moins une lettre dans liste
//            NewPointage:=TPointageList.Create(Pointages);
//            //pour toutes ses lettres renouveler l'opération suivante
//            for i:=0 to ListeLettres.Count-1 do
//               Begin //début boucle pour listelettres
//               //récupérer dans listeMaitres les débits et dans listeEsclaves tous les crédits
//               //concernant la lettre en cours
//               LettreCourante:=ListeLettres.Strings[i];
////               ListeMaitres.Clear;
////               ListeEsclaves.Clear;
//
//               ListeMaitres.Duplicates:=dupAccept;
//               ListeEsclaves.Duplicates:=dupAccept;
//                 for j:=1 to GrPointage.RowCount-1 do
//                   Begin //début boucle for pour récupérer listeMaitres et Esclaves pour lettre courante
//                     if (ListePointages.Objects[j]as TPointageList).lettre=LettreCourante then
//                        Begin //si ligne correspond à lettre courante, récupérer le montant imputé et l'id Ecriture
//                           if (ListePointages.Objects[j]as TPointageList).sens='D' then
//                              Begin //si ligne au débit
//                                 NewPointage:=(ListePointages.Objects[j]as TPointageList);
//                                 ListeMaitres.Addobject((ListePointages.Objects[j]as TPointageList).Imputation,NewPointage);
//                              End//fin si ligne au débit
//                           else
//                              Begin//si ligne au crédit
//                                 NewPointage:=(ListePointages.Objects[j]as TPointageList);
//                                 ListeEsclaves.Addobject((ListePointages.Objects[j]as TPointageList).Imputation,NewPointage);
//                              End;//fin si ligne au crédit
//                        End;// fin si ligne correspond à lettre courante
//                   End;//fin boucle for pour récupérer listeMaitres et Esclaves pour lettre courante
//                TriListeInteger(ListeMaitres);
//                TriListeInteger(ListeEsclaves);
//                if ListeMaitres.Strings[0]<ListeEsclaves.Strings[0]then
//                  Begin //si montant le plus grand fait partie de la liste esclave, liste esclave devient listeMaitre
//                    if ListeTemp<>nil then
//                       ListeTemp:=tstringlist.Create;
//                    ListeTemp:=ListeEsclaves;
//                    ListeEsclaves:=ListeMaitres;
//                    ListeMaitres:=ListeTemp;
//                  End;//fin si montant le plus grand fait partie de la liste esclave
//
//               rangMaitre:=0;
//               //Button1Click(button1);
//               while rangMaitre<=ListeMaitres.count-1 do
//                  Begin //tant que pas fin listeMaitre faire
//                  rangEsclave:=0;
//                    ResteItemMaitre:=strtocurr(ListeMaitres.Strings[rangMaitre]);
//                       while  ResteItemMaitre>0 do
//                          Begin//tant que ResteItemMaitre >0
//                              if strtocurr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)>0 then
//                                 begin
//                                      if ResteItemMaitre>strtocurr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)then
//                                         ValeurAPointer:=strtocurr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)
//                                      else
//                                         ValeurAPointer:= ResteItemMaitre;
//                                    ResteItemMaitre:=ResteItemMaitre-strtocurr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer);
//                                    /////////********
//                                     RecordPointage:=VarArrayCreate([0,4],varVariant);
//                                     if (ListeMaitres.Objects[rangMaitre]as TPointageList).Sens='D'then
//                                        Begin
//                                         RecordPointage[0]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
//                                         RecordPointage[1]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).IDEcriture;
//                                        End
//                                     else
//                                        Begin
//                                         RecordPointage[0]:=(ListeEsclaves.Objects[rangEsclave]as TPointageList).IDEcriture;
//                                         RecordPointage[1]:=(ListeMaitres.Objects[rangMaitre]as TPointageList).IDEcriture;
//                                        End;
//                                     RecordPointage[2]:=now;
//                                     RecordPointage[3]:=ValeurAPointer;
//                                     RecordPointage[4]:=now;
//                      //             IDPointage:=DMPointage.CreationPointageSurIDEcriture(RecordPointage,edcompte.text,true);
//                                   if IDPointage<>-1 then
//                                      ListeIDPointages.Add(inttostr(IDPointage));
//                                  (ListeMaitres.Objects[rangMaitre]as TPointageList).Pointer:=currtostr(strtocurr((ListeMaitres.Objects[rangMaitre]as TPointageList).Pointer)-ValeurAPointer);
//                                  (ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer:=currtostr(strtocurr((ListeEsclaves.Objects[rangEsclave]as TPointageList).Pointer)-ValeurAPointer);
//                                  inc(rangEsclave);
//                                 end
//                              else
//                                 inc(rangEsclave);
//                          End;//fin tant que ResteItemMaitre >0
//                  inc(rangMaitre);
//                  End;//fin tant que pas fin listeMaitre faire
//               End;//fin boucle for pour listelettres
//            end;//fin s'il y au moins une lettre dans liste
//       if not DMPointage.TaPointage.Active then
//         DMPointage.TaPointage.open;
//       if DMPointage.TaPointage.Database.InTransaction then
//       DMPointage.TaPointage.Database.commit;
//       except
//              if not DMPointage.TaPointage.Active then
//         DMPointage.TaPointage.open;
//         if DMPointage.TaPointage.Database.InTransaction then
//         DMPointage.TaPointage.Database.Rollback;
//         showmessage('Problème à l''enregistrement des pointages');
//         abort;
//       end;//fin du try except
//   finally
//      if NewPointage<>nil then
//      NewPointage.free;
//      RecordPointage:=Unassigned;
//   end;//fin du try finally
//End;

procedure TPointages.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//if Shift=[] then WinSuivPrec(Handle,key,[GrPointage]);
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
   if ((Edcompte.Focused) and (EtatPointage=dsbrowse)) then
      self.close
   else
      BtnAnnuler.Click;
   end;
end;


//procedure TPointages.TriListeInteger(var Liste:tstringlist);
//var
//i,j,rangExchange:integer;
//valeurtmp:real;
//Begin
//rangExchange:=-1;
// for i:=0 to liste.Count-1 do
//    Begin
//      valeurtmp:=strtocurr(liste.Strings[i]);
//        for j:=i+1 to liste.Count-1 do
//           Begin
//              if valeurtmp<strtocurr(liste.Strings[j]) then
//                begin
//                valeurtmp:=strtocurr(liste.Strings[j]);
//                rangExchange:=j;
//                end;
//           End;
//    if rangExchange<>-1 then
//    liste.exchange(i,rangExchange);
//    rangExchange:=-1;
//    End;
//End;




procedure TPointages.GrPointageKeyPress(Sender: TObject; var Key: Char);
begin
if GrPointage.Col in [1..7]then
key:=#0;
end;

procedure TPointages.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
comptetmp:string;
begin
canclose:=true;
end;

procedure TPointages.GrPointageCellClick(Colonne, Ligne: Integer);
begin
  if GrPointage.oldcolonne=colonne then
    Begin
    GrPointageColExit(GrPointage.col,lignecurr);
    GrPointageColEnter(GrPointage.col,colonne,ligne);    
    End;
end;

procedure TPointages.RxSpeedButton2Click(Sender: TObject);
begin
Main.mnSaisiePieceClick(Main.mnSaisiePiece);
end;

procedure TPointages.RxSpeedButton1Click(Sender: TObject);
begin
Main.Pieces1Click(Main.Pieces1);
end;

procedure TPointages.GrPointageBeforeSupprLigne(sender: TObject;
  Arow: Integer; var NewRow: Integer);
begin
abort;
end;

procedure TPointages.PatitreResize(Sender: TObject);
begin
RxSpeedButton1.Left:=Patitre.Width-104;
end;

procedure TPointages.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
end;

procedure TPointages.EdCompteKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then EdCompteExit(EdCompte);
end;


procedure TPointages.TaCompteFilterRecordComptePointable(DataSet: TDataSet; var Accept: Boolean);
begin
 if length(DataSet['Compte'])>2 then
   accept:=DataSet['Pointable'];
end;

end.
