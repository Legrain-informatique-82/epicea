unit ObjetPiece;

interface
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, DB, DBTables,
  EpiceaControl, AideTrame;

Type
TPiece = class(TControl)
private
	taPieceLecture :TTable;
   ID_Piece :LongInt;

	procedure UpdateRecordPiece(DataSet: TDataSet; UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
	procedure UpdateErrorPiece(DataSet: TDataSet; E: EDatabaseError; UpdateKind: TUpdateKind;
					var UpdateAction: TUpdateAction);

protected
	procedure TableBeforePost(DataSet: TDataSet);

public
	taPiece, taEcriture :TTable;

   Constructor Create(Owner :TComponent); override;
	Destructor Destroy; override;

   Function GetDonneePiece(Champ :String) :String;
   Function GetID_Piece(Reference :String) :LongInt;
end;

TSaisiePiece = class(TPiece)
private
	OldTrame, OldDevise :LongInt;

protected

public

   Constructor Create(Owner :TComponent); override;
	Destructor Destroy; override;

	Function NouvellePiece :Boolean;
   Function NouvelleReference(CodeJournal :String) :String;
   Function Enregistrer :Boolean;
   Function ValidePiece :Boolean;
	Procedure Annuler;
   Procedure InsertLigne(Ligne :LongInt);
	Procedure Modif_Piece(Champ :String; Donnees :Variant);
   Procedure Modif_Ecriture(Grid :TGrid);
end;

Var
	frmAideTrame: TfrmAideTrame;


implementation
Uses Main, Librairie, AideCompte;

procedure TPiece.TableBeforePost(DataSet: TDataSet);
begin
	with DataSet do
   if (FindField('Qui') <> Nil) then begin
   	FindField('Qui').AsString:= NomUtilisateur;
      FindField('Quand').asDateTime:= Now;
   end;
end;
procedure TPiece.UpdateRecordPiece(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
	if (DataSet = taEcriture) then Begin
		if (UpdateKind = ukInsert) And (taEcriture.FindField('ID_Piece').AsInteger = 0) then
   	Begin
      	with taEcriture do begin
	      	Edit;
				FindField('ID_Piece').asInteger:= ID_Piece;
      	   Post;
	      end;
   	End;
   End;

	UpdateAction:= uaApplied;
end;

procedure TPiece.UpdateErrorPiece(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction);
begin

end;

Function TPiece.GetID_Piece(Reference :String) :LongInt;
Begin
   with taPieceLecture do begin
		if Not (IndexName = 'Reference_') then IndexName:= 'Reference_';

		if FindKey([Reference]) then Result:= FindField('ID').asInteger
      Else Result:= 0;
   End;
End;

Constructor TPiece.Create(Owner :TComponent);
Begin
	Inherited Create(Owner);

  	taPieceLecture:= TTable.Create(Owner);
   with taPieceLecture do begin
   	Name:= 'taPieceLecture';
   	DatabaseName:= 'dbDonnees';
      IndexFieldNames:= 'ID';
      TableName:= 'Piece.Db';
      ReadOnly:= True;

      Open;
   end;

	taPiece:= TTable.Create(Owner);
   with taPiece do begin
   	Name:= 'taPiece';
   	DatabaseName:= 'dbDonnees';
      IndexFieldNames:= 'ID';
      TableName:= 'Piece.Db';
      CachedUpdates:= True;
   	BeforePost:= TableBeforePost;
      OnUpdateRecord:= UpdateRecordPiece;
   	OnUpdateError:= UpdateErrorPiece;

      Open;
   end;

  	taEcriture:= TTable.Create(Owner);
   with taEcriture do begin
   	Name:= 'taEcriture';
   	DatabaseName:= 'dbDonnees';
      IndexFieldNames:= 'ID_Piece;ID_Ligne';
      TableName:= 'Ecriture.Db';
      CachedUpdates:= True;
   	BeforePost:= TableBeforePost;
		OnUpdateRecord:= UpdateRecordPiece;
   	OnUpdateError:= UpdateErrorPiece;

      Open;
   end;
End;

Destructor TPiece.Destroy;
Begin
	taPiece.Close; TaPiece.Destroy;
   TaEcriture.Close; taEcriture.Destroy;
	Inherited Destroy;
End;

Function TPiece.GetDonneePiece(Champ :String) :String;
Begin
	Result:= taPiece.FindField(Champ).AsString;
End;

Constructor TSaisiePiece.Create(Owner :TComponent);
Begin
	Inherited Create(Owner);
	frmAideTrame:= TfrmAideTrame.Create(Owner);
End;

Destructor TSaisiePiece.Destroy;
Begin
	Annuler;

	frmAideTrame.Destroy;
	Inherited Destroy;
End;

Function TSaisiePiece.NouvellePiece :Boolean;
Begin
	Annuler;
   
	with taPiece do begin
	   ID_Piece:= 0;
   	Insert;

      FindField('TypePiece').AsInteger:= 0;
      FindField('Journal').AsInteger:= OldTrame;
      FindField('ID_Devise').AsInteger:= OldDevise;
   end;
   Result:= True;
End;

Function TSaisiePiece.NouvelleReference(CodeJournal :String) :String;
Var Value:Double;
Begin
	Result:= CodeJournal + AnneeSaisie + '00001';

   with taPieceLecture do begin
		if Not (IndexName = 'Reference_') then IndexName:= 'Reference_';

		FindNearest([CodeJournal + AnneeSaisie + '99999']);
      if Not Eof Then Begin
      	if (Copy(FindField('Reference').AsString, 1, 4) > (CodeJournal + AnneeSaisie)) then
            Prior;

	      if Not Bof And (Copy(FindField('Reference').AsString, 1, 4) = (CodeJournal + AnneeSaisie)) then
   	   Begin
				Value:= StrToFloat1(Copy(FindField('Reference').AsString, 5, 5)) + 1;
				Result:= CodeJournal + AnneeSaisie + FormatFloat('00000', Value);
	      End;
      End;
   End;
End;

Function TSaisiePiece.Enregistrer :Boolean;
Begin
	Result:= False;

   if (taEcriture.State in dsModif) then taEcriture.Post;
   if (taPiece.State in dsModif) then taPiece.Post;

   if (ValidePiece) then Begin
	   OldTrame:= taPiece.FindField('Journal').AsInteger;
		OldDevise:= taPiece.FindField('ID_Devise').AsInteger;

		frmMain.dbNameDonnees.StartTransaction;
   	try
	   	TaPiece.ApplyUpdates;
         {   if (Id_Piece = 0) then
         	ID_Piece:= GetID_Piece(taPiece.FindField('Reference').asString);}
   	   taEcriture.ApplyUpdates;
         frmMain.dbNameDonnees.Commit;
      except
         frmMain.dbNameDonnees.Rollback;
         Raise;
      end;
      TaPiece.CommitUpdates;
      taEcriture.CommitUpdates;
   End;

End;

function TSaisiePiece.ValidePiece: Boolean;
begin
	Result:= True;
end;


Procedure TSaisiePiece.Annuler;
Begin
	TaEcriture.CancelUpdates;
   TaPiece.CancelUpdates;
End;

Procedure TSaisiePiece.InsertLigne(Ligne :LongInt);
Begin
	with taEcriture do begin
      Insert;
		FindField('ID_Piece').Assign(TaPiece.FindField('ID'));
      FindField('ID_Ligne').AsInteger:= Ligne;

      FindField('Date').Assign(TaPiece.FindField('Date'));
      FindField('TypeLigne').AsString:= 'C';
   end;
End;

Procedure TSaisiePiece.Modif_Piece(Champ :String; Donnees :Variant);
Begin
	with taPiece do begin
   	if not (State in dsModif) then Edit;

      FindField(Champ).Value:= Donnees;
   end;
End;

Procedure TSaisiePiece.Modif_Ecriture(Grid :TGrid);
Begin
	with taEcriture do begin
		if (Grid.Row <> FindField('ID_Ligne').AsInteger) then Begin
  	      if (State in dsModif) then Post;

         FindKey([ID_Piece, Grid.Row]);
      End;

      if Not (State in dsModif) then Edit;

      case Grid.Col of
        0: FindField('Compte').AsString:= grid.Cell;
        1: FindField('Libelle').AsString:= grid.Cell;
        2: FindField('Qt1').AsString:= grid.Cell;
        3: FindField('Qt2').AsString:= grid.Cell;

        4: FindField('DebitSaisie').AsString:= grid.Cell;
        5: FindField('CreditSaisie').AsString:= grid.Cell;
      end;
   end;
End;

end.
