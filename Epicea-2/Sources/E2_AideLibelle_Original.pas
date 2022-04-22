//   TAF
// Tout est commenté
unit E2_AideLibelle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables;

type
  TAideLibelle = class(TForm)
  procedure FormCreate(Sender: TObject);
  procedure FormDestroy(Sender: TObject);

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
Uses Gr_Librairie, E2_Librairie, E2_AideCompte;
{$R *.DFM}

//******************************************************************************
Function AideLibelleAffiche(Control :TWinControl; Compte :String) :Boolean;
// Affichage de l'écran d'aide des libellés
Begin
   if (AideLibelle=nil) then AideLibelle:=TAideLibelle.Create(application.mainForm);

   if Not Empty(Compte) And (Control <> Nil) then Begin
   	if (Control is TCustomEdit) then
            TCustomEdit(Control).text:= AideCompteLibelle(Compte)
         Else if (Control is TStringGrid) then
         with TStringGrid(Control) do Cells[Col, Row]:=
         	AideCompteLibelle(Compte);
   End;

   Result:= (AideLibelle.showmodal=mrok);
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
	InitialiseForm(Self);

//   taModel.Open;
end;

//PB
//******************************************************************************
procedure TAideLibelle.FormDestroy(Sender: TObject);
// Fermeture de l'écran et fermeture de la table Model
begin
//	taModel.Close;
   DestroyForm(Self);
end;

end.
