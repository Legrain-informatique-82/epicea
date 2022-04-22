{***************************************************************
 *
 * Unit Name: E2_AideTrame
 * Purpose  :
 * Author   :  JS
 * History  :
 *
 ****************************************************************}

unit E2_AideTrame;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Gr_Librairie_obj, DBGrids,
  Db, DBTables, Menus,E2_Librairie_Obj;

type
  TAideTrame = class(TForm)
    Panel1: TPanel;
    rbCode: TRadioButton;
    rbLibelle: TRadioButton;
    btOk: TBitBtn;
    btAnnuler: TBitBtn;
    taTrame: TTable;
    dsTrame: TDataSource;
    grTrame: TDBGrid;
    taTrameID: TAutoIncField;
    taTrameCode: TStringField;
    taTrameJournal: TStringField;
    taTrameCompte: TStringField;
    taTrameCompte_Reglement: TStringField;
    taTrameMinimun: TBooleanField;
    taTrameQui: TStringField;
    taTrameQuand: TDateTimeField;
    taTrameID_Journal: TIntegerField;
    PopupMenu1: TPopupMenu;
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
    taTrameLibelle_Trame: TStringField;
    taTrameLibelle: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grTrameDblClick(Sender: TObject);
    procedure rdIndex(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure grTrameKeyPress(Sender: TObject; var Key: Char);
    procedure btOkClick(Sender: TObject);
  private
    { Déclarations private }
    FRecherche :String;
  public
    { Déclarations public }
  end;

Var
	AideTrame: TAideTrame;
	Function AfficheTrame(Edit :TCustomEdit) :Boolean;
   Function ExisteTrame(Edit :TCustomEdit; AfficheAide :Boolean) :Boolean;
	Function FieldTrame(Champ :String) :TField;
	Function CodeJournal :String;
	Function GetCode_Journal(ID :LongInt) :String;
	Function GetID_Journal :LongInt;

implementation

{$R *.DFM}

Function AfficheTrame(Edit :TCustomEdit) :Boolean;
Begin
	with AideTrame do begin
      if Not Empty(Edit.Text) then ExisteTrame(Edit, False);

		FRecherche:= '';
		ActiveControl:= grTrame;
      Result:= (ShowModal = mrOk);
      if Result then Edit.Text:= TaTrameCode.Value;
   end;
End;

Function ExisteTrame(Edit :TCustomEdit; AfficheAide :Boolean) :Boolean;
Begin
	with AideTrame do begin
      if Length(Edit.Text) = 1 then Begin
         if (UpperCase(Edit.Text) = 'A') then Edit.Text:= 'Achat'
         else if (UpperCase(Edit.Text) = 'V') then Edit.Text:= 'Vente'
         Else if (UpperCase(Edit.Text) = 'O') then Edit.Text:= 'OD'
      End;

      rdIndex(rbCode);
      Result:= taTrame.FindKey([Edit.Text]);

      if Not Result And AfficheAide then
         Result:= AfficheTrame(Edit);
   End;
End;

Function FieldTrame(Champ :String) :TField;
Begin
	Result:= AideTrame.taTrame.FindField(Champ);
End;

Function CodeJournal() :String;
Begin
	Result:= AideTrame.taTrameJournal.Value;
End;

Function GetCode_Journal(ID :LongInt) :String;
Begin
	with AideTrame.taTrame do begin
		IndexFieldNames:='ID';
		if (FindKey([ID])) then
      		Result:= FindField('Code').asString
      Else	Result:= '';
      IndexName:= 'Code_';
   end;
End;

Function GetID_Journal :LongInt;
Begin
	with AideTrame do begin
      if (taTrameID_Journal.AsInteger = 0) then
         Result:= taTrameID.AsInteger
      Else Result:= taTrameID_Journal.AsInteger;
   end;
End;

procedure TAideTrame.FormCreate(Sender: TObject);
begin
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
    end;

   taTrame.Open;
end;

procedure TAideTrame.FormDestroy(Sender: TObject);
begin
	taTrame.Close;
   DestroyForm(Self,E.USer);
   AideTrame:=nil;
end;

procedure TAideTrame.grTrameDblClick(Sender: TObject);
begin
	ModalResult:= mrOk;
end;

procedure TAideTrame.rdIndex(Sender: TObject);
begin
	FRecherche:= '';

	if (Sender = rbCode) then Begin
   	taTrame.indexName:= 'Code_';
      if Not rbCode.Checked then rbCode.Checked:= True;
   End
   Else	Begin
   	taTrame.indexName:= 'Libelle_';
      if Not rbLibelle.Checked then rbLibelle.Checked:= True;
   End;
end;

procedure TAideTrame.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	Action:= caHide;
end;

procedure TAideTrame.FormKeyPress(Sender: TObject; var Key: Char);
begin
	if (Key >= #32) then Begin
	   FRecherche:= UpperCase(FRecherche + Key);
      Key:= #0
   End
   Else if (Key = #08) then Begin
		FRecherche:= Copy(FRecherche, 1, Length(FRecherche) -1);
      Key:= #0
   End;

   if Not Empty(FRecherche) or (Key = #08) then Begin
  	   taTrame.FindNearest([FRecherche]);
   End
end;

procedure TAideTrame.grTrameKeyPress(Sender: TObject; var Key: Char);
begin
	if (Key = #13) then btOkClick(btOk);
end;

procedure TAideTrame.btOkClick(Sender: TObject);
begin
	ModalResult:= mrOk;
end;

end.
