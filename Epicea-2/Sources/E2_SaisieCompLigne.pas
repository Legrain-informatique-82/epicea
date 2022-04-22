{***************************************************************
 *
 * Unit Name: E2_SaisieCompLigne
 * Purpose  :
 * Author   : JS
 * History  :
 *
 ****************************************************************}

// Gere la saisie complémentaire d'une ligne d'écriture
// Tout est commenté
unit E2_SaisieCompLigne;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie, EpiceaControl, Buttons, DBTables, E2_ObjetPiece;

type
  TSaisieCompLigne = class(TForm)
    PopupMenu1: TPopupMenu;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Fermer1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edTvaCode: TText;
    edTvaType: TText;
    edTvaDate: TDate;
    edTvaTaux: TMontant;
    lbTvaType: TListBox;
    btFermer: TBitBtn;
    pmMenu1: TMenuItem;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure edTvaCodeValidation(Sender: TObject; var Valide: Boolean);
    procedure edTvaCodeChange(Sender: TObject);
    procedure lbTvaTypeExit(Sender: TObject);
    procedure lbTvaTypeDblClick(Sender: TObject);
    procedure lbTvaTypeKeyPress(Sender: TObject; var Key: Char);
    procedure edTvaTypeValidation(Sender: TObject; var Valide: Boolean);
    procedure lbTvaTypeEnter(Sender: TObject);
    procedure edTvaTauxValidation(Sender: TObject; var Valide: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edTvaDateValidation(Sender: TObject; var Valide: Boolean);
    procedure Enregister1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btFermerClick(Sender: TObject);
    procedure pmMenu1Click(Sender: TObject);
  private
    { Déclarations privées }
    FCompte :String;
    FLigne :Integer;
    FTypeLigne :String[1];
    FEtatModif :Boolean;

    Procedure TypeValide;
    Procedure SetTvaType(aType :String);
    Procedure SetTvaDate(dDate :TDateTime);
    Procedure SetTvaTaux(Taux : Currency);

  public
    { Déclarations publiques }
    FTaEcriture :TTable;
    FPiece :TPieceSaisie;

    Procedure Actualise;
  end;

implementation
{$R *.DFM}
Uses E2_Librairie, E2_AideTva, Gr_AideDate;

//******************************************************************************
procedure TSaisieCompLigne.Calculatrice1Click(Sender: TObject);
// Affiche calculatrice F12
begin
	AfficheCalculatrice(ActiveControl);
end;

//******************************************************************************
procedure TSaisieCompLigne.Fermer1Click(Sender: TObject);
// Fermeture de l'écran
begin
	Self.Close;
end;

//******************************************************************************
Procedure TSaisieCompLigne.Actualise;
// Initialise l'écran avec les valeurs de la ligne d'écriture
Begin
   FCompte:= FTaEcriture.FindField('Compte').asString;
   FLigne:= FTaEcriture.FindField('ID_Ligne').asInteger;
   FTypeLigne:= FTaEcriture.FindField('TypeLigne').asString;
   FEtatModif:= (FPiece <> Nil) And (FTypeLigne = 'H');

	edTvaCode.Text:= FTaEcriture.FindField('TvaCode').AsString;
	edTvaCodeChange(edTvaCode);
   edTvaType.Text:= FTaEcriture.FindField('TvaType').AsString;
   edTvaDate.asDate:= FTaEcriture.FindField('TvaDate').AsDateTime;
   edTvaTaux.asMontant:= FTaEcriture.FindField('TvaTaux').AsCurrency;

   If (Screen.ActiveForm = Self) then Begin
	   if (FEtatModif) then 	ActiveControl:= edTvaCode
   	Else						   ActiveControl:= btFermer;
   End;
End;

//******************************************************************************
procedure TSaisieCompLigne.Aide1Click(Sender: TObject);
// Gestion de F1 suivant la zone active
begin
	if (ActiveControl = edTvaTaux) then
   	AfficheCalculatrice(ActiveControl)
   Else if (ActiveControl = edTvaCode) then
   	AideTvaAffiche(edTvaCode, FCompte)
   Else if (ActiveControl = edTvaType) then Begin
   	lbTvaType.Visible:= true;
      lbTvaType.SetFocus
   End
   Else if (ActiveControl = edTvaDate) then
   	AideDateAffiche(edTvaDate)
end;

//******************************************************************************
procedure TSaisieCompLigne.edTvaCodeValidation(Sender: TObject;
  var Valide: Boolean);
// Contrôle code de TVA
begin
	Valide:= AideTvaExiste(edTvaCode.Text, FCompte, edTvaCode);

   if  Valide then Begin
   	If (FEtatModif) then
			FPiece.EcritureModifier(FPiece.PieceID, FTypeLigne, FLigne,
         	'TvaCode', edTvaCode.Text);

   	if Empty(edTvaCode.Text) then Begin {Pas de code}
      	SetTvaType('');
         SetTvaDate(0);
         SetTvaTaux(0);

         ControlInactif(edTvaType, btFermer);
         ControlInactif(edTvaDate, btFermer);
         ControlInactif(edTvaTaux, btFermer);
      End
      Else if AideTvaField('Classe').asString = 'C' then Begin {Tva Acquisition}
      	edTvaTaux.Enabled:= True;
			if (edTvaTaux.asMontant < AideTvaField('Taux_Inf').asCurrency)
         And (edTvaTaux.asMontant > AideTvaField('Taux_Supp').asCurrency) Then
         	SetTvaTaux(AideTvaField('Taux_Supp').asCurrency)
      End
      Else Begin
      	SetTvaTaux(0);
         ControlInactif(edTvaTaux, btFermer);
      End;
   End;
end;

//******************************************************************************
procedure TSaisieCompLigne.edTvaCodeChange(Sender: TObject);
// Change la propriété enable des autres zones suivant le code TVA
begin
   edTvaCode.Enabled:= FEtatModif;
   edTvaType.Enabled:= FEtatModif And Not Empty(edTvaCode.Text);
   edTvaDate.Enabled:= edTvaType.Enabled;
   edTvaTaux.Enabled:= False;
end;

//******************************************************************************
procedure TSaisieCompLigne.lbTvaTypeExit(Sender: TObject);
// Jacques n'en est pas fier, ne pas commenter
// Gere la sortie de la liste des types de TVA
begin
	lbTvaType.Visible:= False;
   if Not (AideTvaTypeValide(edTvaCode.Text, edTvaType.Text)) then Begin
   	Refocusing:= edTvaType;
      edTvaType.Focused;
   End;
end;

//******************************************************************************
procedure TSaisieCompLigne.lbTvaTypeDblClick(Sender: TObject);
// Valide le type TVA
begin
	TypeValide;
end;

//******************************************************************************
procedure TSaisieCompLigne.lbTvaTypeKeyPress(Sender: TObject;
  var Key: Char);
// Valide le type TVA avec #13
begin
	if (Key = #013) then Begin
		TypeValide;
   	Key:= #0;
   End;
end;

//******************************************************************************
Procedure TSaisieCompLigne.TypeValide;
// Sélection le type TVA et valide
Begin
	if (lbTvaType.ItemIndex >= 0) then Begin
		SetTvaType(Copy(lbTvaType.Items.Strings[lbTvaType.ItemIndex],1, 1));
   	Perform(WM_NEXTDLGCTL, 0, 0);
   End;
End;

//******************************************************************************
procedure TSaisieCompLigne.edTvaTypeValidation(Sender: TObject;
  var Valide: Boolean);
// Contrôle la validité du type TVA
begin
   if Not AideTvaTypeValide(edTvaCode.Text, edTvaType.Text) then Begin
		Refocusing:= lbTvaType;
   	lbTvaType.Visible:= true;
      lbTvaType.SetFocus;
   End
   Else If (FEtatModif) then
      	FPiece.EcritureModifier(FPiece.PieceID, FTypeLigne, FLigne,
         	'TvaType', edTvaType.Text);
end;

//******************************************************************************
procedure TSaisieCompLigne.lbTvaTypeEnter(Sender: TObject);
// Gestion du focus
begin
	if (Refocusing = Sender) then Refocusing:= Nil;
end;

//******************************************************************************
procedure TSaisieCompLigne.edTvaTauxValidation(Sender: TObject;
  var Valide: Boolean);
// Contrôle du taux TVA
begin
	Valide:= AideTvaTauxValide(edTvaCode.Text, edTvaTaux.asMontant);
   if (Valide) And (FEtatModif) then
	  	FPiece.EcritureModifier(FPiece.PieceID, FTypeLigne, FLigne,
      	'TvaTaux', edTvaTaux.asMontant);
end;

//******************************************************************************
procedure TSaisieCompLigne.FormCreate(Sender: TObject);
// Init. de l'écran
begin
	InitialiseForm(Self);
end;

//******************************************************************************
procedure TSaisieCompLigne.FormDestroy(Sender: TObject);
// Destruction
begin
	DestroyForm(Self);
//   SaisieCompLigne:=nil;
end;

//******************************************************************************
procedure TSaisieCompLigne.edTvaDateValidation(Sender: TObject;
  var Valide: Boolean);
// Contrôle de la date de la TVA
begin
	If (FEtatModif) then
   	FPiece.EcritureModifier(FPiece.PieceID, FTypeLigne, FLigne,
      	'TvaDate', edTvaDate.asDate);
end;

//******************************************************************************
procedure TSaisieCompLigne.Enregister1Click(Sender: TObject);
// Fermeture par F3
begin
	Close;
end;

//******************************************************************************
Procedure TSaisieCompLigne.SetTvaType(aType :String);
// Modif le type TVA dans la ligne d'écriture
Begin
	edTvaType.Text:= aType;
	If (FEtatModif) then
   	FPiece.EcritureModifier(FPiece.PieceID, FTypeLigne, FLigne,
      	'TvaType', edTvaType.Text);
End;

//******************************************************************************
Procedure TSaisieCompLigne.SetTvaDate(dDate :TDateTime);
// Modif la date TVA dans la ligne d'écriture
Begin
	edTvaDate.asDate:= dDate;
	If (FEtatModif) then
   	FPiece.EcritureModifier(FPiece.PieceID, FTypeLigne, FLigne,
      	'TvaDate', edTvaDate.asDate);
End;

//******************************************************************************
Procedure TSaisieCompLigne.SetTvaTaux(Taux : Currency);
// Modifie le taux TVA dans la ligne d'écriture
Begin
	edTvaTaux.asMontant:= Taux;
	If (FEtatModif) then
   	FPiece.EcritureModifier(FPiece.PieceID, FTypeLigne, FLigne,
      	'TvaTaux', edTvaTaux.asMontant);
End;

//******************************************************************************
procedure TSaisieCompLigne.FormKeyPress(Sender: TObject; var Key: Char);
// Fermeture sur #27
begin
	if (Key = #27) then Close;
end;

//******************************************************************************
procedure TSaisieCompLigne.btFermerClick(Sender: TObject);
// Fermeture
begin
	Close;
end;

//******************************************************************************
procedure TSaisieCompLigne.pmMenu1Click(Sender: TObject);
// F11
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

end.
