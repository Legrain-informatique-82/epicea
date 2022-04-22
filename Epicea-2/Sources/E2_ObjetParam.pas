{***************************************************************
 *
 * Unit Name: E2_ObjetParam
 * Purpose  :
 * Author   :  JS
 * History  :
 *
 ****************************************************************}

// Objet
// Fonction qui sont liées à la table Paramcpt.db (Correspond à PPCO)
// Tout est commenté
unit E2_ObjetParam;

interface
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, DB,
  Forms, DBTables;

Type
TObjetParam = Class(TControl)
	Private
   TaParam :TTable;

   Public
   Constructor Create(Owner :TComponent); override;
	Destructor Destroy; override;

End;

Var
	ObjetParam :TObjetParam;

	Function ExisteRacine(Famille :Integer; Compte :String) :Boolean;
   Function FieldParam(Champ :String) :TField;

implementation
//Uses Gr_Librairie_obj, E2_Librairie_obj,E2_Main, DMBaseDonnee;


//******************************************************************************
Function ExisteRacine(Famille :Integer; Compte :String) :Boolean;
// Recherche dans la table par famille et par compte en réduisant la
// longueur de compte tant qu'il n'y a pas de correspondance dans compte
// Retourne faux si pas de résultats
Begin
//	if (ObjetParam = Nil) then
//   	ObjetParam:= TObjetParam.Create(Application.MainForm);
//
//   Result:= False;
//   with ObjetParam.taParam do begin
//   	IndexName:= 'Rac1_';
//
//      While Not Result And Not Empty(Compte) do Begin
//			Result:= FindKey([E.Regime, Famille, Compte]);
//      	Compte:= Copy(Compte, 1, Length(Compte) -1)
//      End;
//	End;
End;

//******************************************************************************
Function FieldParam(Champ :String) :TField;
// Raccourci de commande Delphi
Begin
//   Result:= ObjetParam.taParam.FindField(Champ);
End;

//******************************************************************************
Constructor TObjetParam.Create(Owner :TComponent);
// Constructeur avec ouverture de la table
Begin
//	Inherited Create(Owner);
//
//   taParam:= TTable.Create(Self);
//   with taParam do begin
//   	Name:= 'taRaram';
//   	DatabaseName:= DMBD.dbNameProg.DatabaseName;
//      IndexName:= 'Rac1_';
//      TableName:= 'ParamCpt.Db';
//      ReadOnly:= True;
//
//   	Open;
//   end;
End;

//******************************************************************************
Destructor TObjetParam.Destroy;
// Destructeur et fermeture de la table
Begin
//	taParam.Close;
//   ObjetParam:= Nil;
//   Inherited Destroy;
End;


end.
