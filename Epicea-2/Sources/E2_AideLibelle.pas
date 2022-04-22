{***************************************************************
 *
 * Unit Name: E2_AideLibelle
 * Purpose  :
 * Author   : BP
 * History  :
 *
 ****************************************************************}

//   TAF
// Tout est commenté
unit E2_AideLibelle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables, Menus, DBCtrls, Buttons, ExtCtrls,
  ComCtrls;

type
  TAideLibelle = class(TForm)
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    AjouterCode1: TMenuItem;
    Supprimer1: TMenuItem;
    Modifier1: TMenuItem;
    N2: TMenuItem;
    Fermer1: TMenuItem;
    DataSource1: TDataSource;
    Table1: TTable;
    Query1: TQuery;
    Btn_OK: TBitBtn;
    Btn_Annul: TBitBtn;
    ListBox1: TListBox;
    ListBox2: TListBox;
    StatusBar1: TStatusBar;
  procedure FormCreate(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  procedure pmMenu1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  AideLibelle: TAideLibelle;
{Aide Libelle}
Function AideLibelleAffiche(Control :TWinControl;Compte :String) :Boolean;
Function AideLibelleValide(Libelle, Compte :String; Control :TWinControl) :Boolean;


implementation
Uses Gr_Librairie_obj, E2_Librairie_obj, E2_AideCompte;
{$R *.DFM}

//******************************************************************************
Function AideLibelleAffiche(Control :TWinControl; Compte :String) :Boolean;
// Affichage de l'écran d'aide des libellés
Begin
   if (AideLibelle=nil) then AideLibelle:=TAideLibelle.Create(application.mainForm);
   if control <> nil then
      begin
      AideLibelle.Query1.SQL.Clear;
       if (Control is TCustomEdit) then
          AideLibelle.Query1.SQL.Add('select Libelle from Piece.DB where Libelle <>'''' group by Libelle');
       if (Control is TStringGrid) then
        begin
          with TStringGrid(Control) do compte:=Cells[0, Row];
          AideLibelle.Query1.SQL.add('select Libelle from Ecriture.DB where Libelle <>'''' and Compte='''+Compte+''' group by Libelle');
          showmessage(AideLibelle.Query1.text);
        end;
      AideLibelle.Query1.open;
      end;
   Result:= (AideLibelle.showmodal=mrok);
//

   if result then
      begin
   if Not Empty(Compte) And (Control <> Nil) then Begin
   	if (Control is TCustomEdit) then
            TCustomEdit(Control).text:= AideLibelle.ListBox2.items[AideLibelle.ListBox2.ItemIndex]
         Else if (Control is TStringGrid) then
         with TStringGrid(Control) do Cells[Col, Row]:=AideLibelle.ListBox2.items[AideLibelle.ListBox2.ItemIndex];
   End;
   end;
End;

//******************************************************************************
Function AideLibelleValide(Libelle, Compte :String; Control :TWinControl) :Boolean;
// Contrôle si le libellé n'est pas vide
Begin
	Result:= True;

   if Empty(Libelle) And Not Empty(Compte) And (Control <> Nil) then Begin
   	if (Control is TCustomEdit) then
            TCustomEdit(Control).text:= AideCompteLibelle(Compte)
         Else if (Control is TStringGrid) then
         with TStringGrid(Control) do Cells[Col, Row]:= AideCompteLibelle(Compte);
   End;
End;

//PB
//******************************************************************************
procedure TAideLibelle.FormCreate(Sender: TObject);
// Initialisation de l'écran et ouverture de la table Model

begin
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
    end;
//   Table1.Open;
end;

//PB
//******************************************************************************
procedure TAideLibelle.FormDestroy(Sender: TObject);
// Fermeture de l'écran et fermeture de la table Model
begin
//	Table1.Close;
	Query1.close;
   DestroyForm(Self,E.user);
   AideLibelle:=nil;
end;

//******************************************************************************
procedure TAideLibelle.pmMenu1Click(Sender: TObject);
// Touche de fonction F11, appelle le pop_up menu
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

//PB
//******************************************************************************
procedure TAideLibelle.FormShow(Sender: TObject);
var
i:integer ;
//Remplit les deux tableaux de choix de libellé
begin
	ListBox1.Clear;
	ListBox2.Clear;
   Query1.Last;
//   Query1.MoveBy(-10);
   i:=1;
   while ((i<=10) and (not Query1.BOF)) do
   	begin
      	ListBox1.Items.Add(intToStr(i-1));
      	ListBox2.Items.Add(Query1['Libelle']);
      	Query1.Prior;
			i:=i+1;
   	end;
	ListBox1.ItemIndex:=0;
   ListBox2.ItemIndex:=0;
end;

procedure TAideLibelle.ListBox1Click(Sender: TObject);
begin
ListBox2.ItemIndex:=ListBox1.ItemIndex;
end;

end.
