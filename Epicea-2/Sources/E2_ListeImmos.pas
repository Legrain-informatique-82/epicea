{***************************************************************
 *
 * Unit Name: E2_ListeImmos
 * Purpose  :
 * Author   : Blanchard
 * History  :
 *
 ****************************************************************}

unit E2_ListeImmos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, Gr_Librairie_obj, DMImmos, StdCtrls, Buttons,
  ExtCtrls,E2_Decl_Records,E2_Librairie_Obj;

type
  TListeImmos = class(TForm)
    Compte: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    PaGrille: TPanel;
    grListeImmos: TDBGrid;
    btOK: TBitBtn;
    btFermer: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grListeImmosDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grListeImmosKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure grListeImmosTitleClick(Column: TColumn);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

const
	csWidth = 647;		//Largeur de base de la feuille
   csHeight = 371;   //Hauteur de base de la feuille
var
	ListeImmos: TListeImmos;

implementation

uses E2_DetailImmo, E2_Rebut, E2_Division, E2_Main;

{$R *.DFM}

procedure TListeImmos.FormCreate(Sender: TObject);
begin
	Left:= 0; Top:= 0; Width:= csWidth; Height:= csHeight;
	if DataModuleImmos = Nil then DataModuleImmos := TDataModuleImmos.Create(Self);
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
    end;
//   DataModuleImmos.QuRecupImmosSurCpt.Open;
end;

procedure TListeImmos.FormDestroy(Sender: TObject);
begin
	DestroyForm(Self,E.User);
//   DataModuleImmos.QuRecupImmosSurCpt.close;
   ListeImmos := Nil;
end;

procedure TListeImmos.grListeImmosDblClick(Sender: TObject);
begin
//Ouvre fen�tre d�tail immo, Rebut, ou Division, selon le tag (Constantes d�finies dans DMImmos)
   Case ListeImmos.Tag of
   	C_IMMOS,
        C_ACQUIS_EXO :begin
                        if DetailImmo = Nil then
                            DetailImmo := TDetailImmo.Create(Self);
                        DetailImmo.Show;
                       end;
	 C_DIVISION : begin
                       if Division = Nil then
                           Division := TDivision.Create(Self);
                       Close;
                       Division.Show;
                      end;
          C_REBUT,
          C_CESSION : begin
                         if Rebut = Nil then
                             Rebut := TRebut.Create(Self);
                         Close;
                         Rebut.Tag := Tag;
                         Rebut.Show;
                      end;
   end;//fin du case.tag
end;

procedure TListeImmos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if DetailImmo <> Nil then DetailImmo.Close;
   if Rebut <> Nil then Rebut.Close;
end;

procedure TListeImmos.grListeImmosKeyPress(Sender: TObject; var Key: Char);
begin
	if Key = #13 then grListeImmosDblClick(Sender);
end;

procedure TListeImmos.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
//	DataModuleImmos.QuRecupImmosSurCpt.close;
   Self.Caption := 'Liste des Immobilisations';
   if tag = C_ACQUIS_EXO then Self.Caption := 'Liste des Acquisitions de l''exercice';
   if tag = C_CESSION_EXO then Self.Caption := 'Liste des Cessions';
   DataModuleImmos.Filtrage_QuRecupImmosSurCpt_SurTag(tag,false,-1,'','%',strtodate('01/01/1900'),now);
   grListeImmos.SetFocus;
end;

procedure TListeImmos.btOKClick(Sender: TObject);
begin
	grListeImmosDblClick(Sender);
end;

procedure TListeImmos.grListeImmosTitleClick(Column: TColumn);
const Colonne : string = '';
var s, ordre : string;
begin
//// Trie les enregs suivant la colonne (ordre croissant et d�croissant � chaque click)
////   if Column.Field.Calculated then exit;
//   if Colonne <> Column.FieldName then begin
//      Colonne := Column.FieldName;
//      ordre := ', Immobilisation';
//	end
//   else begin
//   	ordre := ' desc, Immobilisation';
//      Colonne := '';
//   end;
//      if Column.FieldName = 'TypeA' then s := 'Order by Type_Amt' + ordre
//      else s := 'Order by ' + Column.FieldName + ordre;
//    with DataModuleImmos.QuRecupImmosSurCpt do
//    DataModuleImmos.Filtrage_QuRecupImmosSurCpt_SurTag(tag,true,SQL.Count-1,s,'%',strtodate('01/01/1900'),now);
end;

end.