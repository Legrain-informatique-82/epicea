{***************************************************************
 *
 * Unit Name: E2_RegmntListe2
 * Purpose  :
 * Author   :  BP
 * History  :
 *
 ****************************************************************}

unit E2_RegmntListe2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, DBCtrls, checklst, Grids, DBGrids, Mask, ComCtrls,
  Buttons, ExtCtrls, EpiceaControl, Gr_Librairie;

type
  TE2_RegmntListe = class(TForm)
    TaEcriture: TTable;
    DaEcriture: TDataSource;
    DBGrid1: TDBGrid;
    DBComboBox1: TDBComboBox;
    DataCompteBanc: TDataSource;
    TaTiers: TTable;
    TaEcritureID: TIntegerField;
    TaEcritureID_Piece: TIntegerField;
    TaEcritureTypeLigne: TStringField;
    TaEcritureID_Ligne: TSmallintField;
    TaEcritureDate: TDateField;
    TaEcritureCompte: TStringField;
    TaEcritureTiers: TStringField;
    TaEcritureLibelle: TStringField;
    TaEcritureQt1: TFloatField;
    TaEcritureQt2: TFloatField;
    TaEcritureDebitSaisie: TFloatField;
    TaEcritureCreditSaisie: TFloatField;
    TaEcritureID_Devise: TIntegerField;
    TaEcritureDebit: TFloatField;
    TaEcritureCredit: TFloatField;
    TaEcritureTvaCode: TStringField;
    TaEcritureTvaType: TStringField;
    TaEcritureTvaTaux: TFloatField;
    TaEcritureTvaDate: TDateField;
    TaEcritureRapprochement: TStringField;
    TaEcritureValidation: TDateField;
    TaEcritureQui: TStringField;
    TaEcritureQuand: TDateTimeField;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListeCompte: TListBox;
    QuPointage: TQuery;
    DaPointage: TDataSource;
    Button1: TButton;
    QuPointageId_Credit: TIntegerField;
    QuPointageSUMOFMontant: TFloatField;
    DaPiece: TDataSource;
    QuPiece: TQuery;
    QuPieceId: TIntegerField;
    QuPieceJournal: TIntegerField;
    QuPieceReference: TStringField;
    QuPieceDate: TDateField;
    QuPieceLibelle: TStringField;
    QuPieceTypePiece: TSmallintField;
    QuPieceCompte: TStringField;
    QuPieceID_Devise: TIntegerField;
    QuPieceValidation: TDateField;
    QuPieceQui: TStringField;
    QuPieceQuand: TDateTimeField;
    EdTotal: TEdit;
    QuPointage2: TQuery;
    QuPointage2Id_Debit: TIntegerField;
    QuPointage2SUMOFMontant: TFloatField;
    CheckBox1: TCheckBox;
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure ListeCompteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListeCompteClick(Sender: TObject);
    procedure toto_sur_titi_pour_button1;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GrDetCreSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure GrDetCreClick(Sender: TObject);
    procedure GrDetCreDblClick(Sender: TObject);
    procedure GrDetCreKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrDetCreGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GrDetCreSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure SpeedButton1Click(Sender: TObject);
    procedure RempliGrille1;
    procedure RempliGrille2;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  E2_RegmntListe: TE2_RegmntListe;

implementation

uses LibSQL;
{$R *.DFM}

procedure TE2_RegmntListe.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin

//if Key=gkEditMode then DBGrid1.s

end;

procedure TE2_RegmntListe.ListeCompteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     ListeCompte.ItemIndex:=Y div ListeCompte.ItemHeight;
end;

procedure TE2_RegmntListe.ListeCompteClick(Sender: TObject);
var
i:integer;
begin
for i:=1 to GrDetCre.RowCount-1 do begin
		if GrDetCre.Cells[1,i] <> ListeCompte.Items[ListeCompte.ItemIndex] then
									GrDetCre.Rows[i].Clear;
//                           GrDetCre.Rows[i].
                           end;
//     TaEcriture.DisableControls;
//     TaEcriture.Filtered:=false;
//     if ListeCompte.ItemIndex > 0 then
//     Begin
//          TaEcriture.Filter := CreeFiltreOU('Compte',[ListeCompte.items[ListeCompte.itemindex]]);
//          Case ListeCompte.tag Of
//          0:Titre:='Créances';
//          1:Titre:='Dettes';
//          end; // Fin du Case
//    End
//    Else
//    Begin
//         Case ListeCompte.tag Of
//         0:begin
//                TaEcriture.Filter :=CreeFiltreOU('Compte',['41*']);
//                Titre:='Créances';
//           end;
//
//         1:begin
//                TaEcriture.Filter := CreeFiltreOU('Compte',['40*','42*','43*','44*','45*']);
//                Titre:='Dettes';
//           end;
//        End; // Fin du Case
//    End;
//
//    Label1.Caption:='Comptes Collectifs ' + Titre + ' : ' + ListeCompte.items[ListeCompte.itemindex];
//    TaEcriture.Filtered:=true;
//    TaEcriture.EnableControls;
//    ListeCompte.Visible:=false;
//    DBGrid1.SetFocus;
//
end;
procedure TE2_RegmntListe.toto_sur_titi_pour_button1;
var
i:integer;
begin
i:=GetWindowLong(button1.Handle,GWL_STYLE );
//SetWindowLong (button1.Handle,GWL_STYLE , i or BS_MULTILINE);
SetWindowLong (button1.Handle,GWL_STYLE , i or BS_TOP);
i:=GetWindowLong(CheckBox1.Handle,GWL_STYLE );
//SetWindowLong (button1.Handle,GWL_STYLE , i or BS_MULTILINE);
SetWindowLong (CheckBox1.Handle,GWL_STYLE , i or BS_PUSHLIKE);

Button1.Caption:='toto'#13#10'titi';
end;

procedure TE2_RegmntListe.FormCreate(Sender: TObject);
begin
toto_sur_titi_pour_button1;
end;

procedure TE2_RegmntListe.RempliGrille1;
var
i:integer;
Champ:string;
begin
//GrDetCre.Invalidate;
TaEcriture.First;
ListeCompte.Clear;
ListeCompte.Items.Add(' < Tous > ');
i:=1;
GrDetCre.RowCount:=TaEcriture.RecordCount+1;
if SpeedButton1.Down then Champ:='Id_Credit' else Champ:='Id_Debit';
while not TaEcriture.Eof do begin
  		if QuPiece.Locate('Id',TaEcritureID_Piece.Value,[])then begin
      //Piece pour lesquelles un règlement existe
		if QuPointage.Locate('Id_Credit',TaEcritureID.Value,[]) then begin
      //Reglement partiel
      	if (TaEcritureCredit.Value > QuPointageSUMOFMontant.Value) then begin
                   GrDetCre.Cells[1,i]:=QuPieceCompte.Value;
                   if ListeCompte.Items.IndexOf(QuPieceCompte.Value) = -1 then
								ListeCompte.Items.Add(QuPieceCompte.Value);
                   GrdetCre.Cells[2,i]:=QuPieceReference.Value;
                   GrdetCre.Cells[3,i]:=QuPieceLibelle.Value;
                   GrdetCre.Cells[4,i]:=TaEcritureCredit.AsString;
                   GrdetCre.Cells[5,i]:=QuPointageSUMOFMontant.AsString;
      				 GrdetCre.Cells[6,i]:='0.00';
				       inc(i);
                   TaEcriture.Next;
                  end;
      //Reglement complet
      	if (TaEcritureCredit.Value = QuPointageSUMOFMontant.Value) then begin
//         			inc(i);
				      TaEcriture.Next;
                  end;
                  end
      //Piece non réglée
      else begin //ajout ds grille
      GrDetCre.Cells[1,i]:=QuPieceCompte.Value;
      if ListeCompte.Items.IndexOf(QuPieceCompte.Value) = -1 then
			ListeCompte.Items.Add(QuPieceCompte.Value);
      GrdetCre.Cells[2,i]:=QuPieceReference.Value;
      GrdetCre.Cells[3,i]:=QuPieceLibelle.Value;
      GrdetCre.Cells[4,i]:=TaEcritureCredit.AsString;
      GrdetCre.Cells[5,i]:='0.00';
      GrdetCre.Cells[6,i]:='0.00';
      TaEcriture.Next;
		inc(i);
      end;
      end else
      begin
      TaEcriture.Next;
		//inc(i);
      end;

      end;
GrDetCre.RowCount:=i;
GrDetCre.Col:=6;
ListeCompte.Sorted:=true;
//PostMessage(GrDetCre.Handle,WM_KEYUP,VK_F2,VK_F2);
//GrDetCre.e
//GrDetCre.Refresh;
end;

procedure TE2_RegmntListe.RempliGrille2;
var
i:integer;
begin
//GrDetCre.Invalidate;
TaEcriture.First;
ListeCompte.Clear;
ListeCompte.Items.Add(' < Tous > ');
i:=1;
GrDetCre.RowCount:=TaEcriture.RecordCount+1;
while not TaEcriture.Eof do begin
  		if QuPiece.Locate('Id',TaEcritureID_Piece.Value,[])then begin
      //Piece pour lesquelles un règlement existe
		if QuPointage2.Locate('Id_Debit',TaEcritureID.Value,[]) then begin
      //Reglement partiel
      	if (TaEcritureCredit.Value > QuPointage2SUMOFMontant.Value) then begin
                   GrDetCre.Cells[1,i]:=QuPieceCompte.Value;
                   if ListeCompte.Items.IndexOf(QuPieceCompte.Value) = -1 then
								ListeCompte.Items.Add(QuPieceCompte.Value);
                   GrdetCre.Cells[2,i]:=QuPieceReference.Value;
                   GrdetCre.Cells[3,i]:=QuPieceLibelle.Value;
                   GrdetCre.Cells[4,i]:=TaEcritureDebit.AsString;
                   GrdetCre.Cells[5,i]:=QuPointage2SUMOFMontant.AsString;
      				 GrdetCre.Cells[6,i]:='0.00';
				       inc(i);
                   TaEcriture.Next;
                  end;
      //Reglement complet
      	if (TaEcritureDebit.Value = QuPointage2SUMOFMontant.Value) then begin
//         			inc(i);
				      TaEcriture.Next;
                  end;
                  end
      //Piece non réglée
      else begin //ajout ds grille
      GrDetCre.Cells[1,i]:=QuPieceCompte.Value;
      if ListeCompte.Items.IndexOf(QuPieceCompte.Value) = -1 then
			ListeCompte.Items.Add(QuPieceCompte.Value);
      GrdetCre.Cells[2,i]:=QuPieceReference.Value;
      GrdetCre.Cells[3,i]:=QuPieceLibelle.Value;
      GrdetCre.Cells[4,i]:=TaEcritureDebit.AsString;
      GrdetCre.Cells[5,i]:='0.00';
      GrdetCre.Cells[6,i]:='0.00';
      TaEcriture.Next;
		inc(i);
      end;
      end else
      begin
      TaEcriture.Next;
		//inc(i);
      end;

      end;
GrDetCre.RowCount:=i;
GrDetCre.Col:=6;
ListeCompte.Sorted:=true;
//PostMessage(GrDetCre.Handle,WM_KEYUP,VK_F2,VK_F2);
//GrDetCre.e
//GrDetCre.Refresh;
end;

procedure TE2_RegmntListe.FormShow(Sender: TObject);
begin
TaEcriture.Open;
//RempliGrille;
SpeedButton1Click(SpeedButton1);
end;

procedure TE2_RegmntListe.GrDetCreSelectCell(Sender: TObject; Col,
  Row: Integer; var CanSelect: Boolean);
var
i:integer;
begin
//if Col = 6 then GrDetCre.EditorMode:=true else GrDetCre.EditorMode:=false;
//beep;
if col <> 6 then begin
			GrDetCre.Col:=6;
         end
 else	begin
 	PostMessage(GrDetCre.Handle,WM_KEYDOWN,VK_F2,VK_F2);
//   canselect:=true;
//   GrDetCre.SelStart:=1;
//   GrDetCre.SelLength:=2;
//	GrDetCre.SelectAll;
   end;

EdTotal.Text:='0';
for i:= 1 to GrDetCre.RowCount-1 do
         		EdTotal.Text:=CurrToStr(StrToCurr(GrDetCre.cells[6,i])+StrToCurr(EdTotal.Text));
//GrDetCre.Row:=
//(GrDetCre.Objects[5,Row] as TEdit).ReadOnly:=true;
//CanSelect:= col = 6;
end;

procedure TE2_RegmntListe.GrDetCreClick(Sender: TObject);
begin
GrDetCre.Col:=6;
end;

procedure TE2_RegmntListe.GrDetCreDblClick(Sender: TObject);
begin
GrDetCre.Col:=6;
end;

procedure TE2_RegmntListe.GrDetCreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//StringGrid1.Cells[Col,Row]='')
if Key = VK_RETURN then  begin
	if ((GrDetCre.Col = 6) and (GrDetCre.cells[6,GrDetCre.Row-1] = '0.00')) then
   				GrDetCre.cells[6,GrDetCre.Row-1]:=CurrToStr(StrToCurr(GrDetCre.cells[4,GrDetCre.Row-1])-StrToCurr(GrDetCre.cells[5,GrDetCre.Row-1]));
//               if (GrDetCre.Row<GrDetCre.RowCount) then GrDetCre.Row:=GrDetCre.Row+1;
               end;
               
end;

procedure TE2_RegmntListe.GrDetCreGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
if ((value='') or (value='0') or (value='0.0')) then value:='0.00';
end;

procedure TE2_RegmntListe.GrDetCreSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
//if ((value='') or (value='0') or (value='0.0')) then value:='0.00';
end;

procedure TE2_RegmntListe.SpeedButton1Click(Sender: TObject);
begin
ListeCompte.Visible:=false;
TaEcriture.Filtered:=false;
//TaEcriture.Filter:=CreeFiltreEt(['TypeLigne','Debit'],[AnsiString('X'),AnsiString('0')]);
TaEcriture.Filter:=('TypeLigne=''X'' and Credit <>''0''');
//('Compte=''4*''and collectif=''true''');
TaEcriture.Filtered:=true;
QuPiece.Active:=false;
QuPiece.SQL.Clear;
QuPiece.SQL.Add('select * from Piece.db where "Piece.db"."Id" in ');
QuPiece.SQL.Add('(select "Ecriture.db"."Id_Piece" from Ecriture.db ');
QuPiece.SQL.Add('where "Ecriture.db"."TypeLigne" = ');
QuPiece.SQL.Add('''X''');
QuPiece.SQL.Add(' and "Ecriture.db"."Credit" is not null)');
QuPiece.Active:=true;
QuPointage.active:=false;
QuPointage.SQL.Clear;
QuPointage.SQL.add('select "Pointage.db"."Id_Credit", Sum("Pointage.db"."Montant") from Pointage.db group by "Pointage.db"."Id_Credit"');
QuPointage.Active:=true;
ListeCompte.Left:=SpeedButton1.Left+Panel1.Left;
RempliGrille1;
ListeCompte.Visible:=true;
ListeCompte.ItemIndex:=0;

end;

procedure TE2_RegmntListe.SpeedButton2Click(Sender: TObject);
begin
ListeCompte.Visible:=False;
TaEcriture.Filtered:=false;
//TaEcriture.Filter:=CreeFiltreEt(['TypeLigne','Debit'],[AnsiString('X'),AnsiString('0')]);
TaEcriture.Filter:=('TypeLigne=''X'' and Debit <>''0''');
//('Compte=''4*''and collectif=''true''');
TaEcriture.Filtered:=true;
QuPiece.Active:=false;
QuPiece.SQL.Clear;
QuPiece.SQL.Add('select * from Piece.db where "Piece.db"."Id" in ');
QuPiece.SQL.Add('(select "Ecriture.db"."Id_Piece" from Ecriture.db ');
QuPiece.SQL.Add('where "Ecriture.db"."TypeLigne" = ');
QuPiece.SQL.Add('''X''');
QuPiece.SQL.Add(' and "Ecriture.db"."Debit" is not null)');
QuPiece.Active:=true;
QuPointage2.active:=false;
QuPointage2.SQL.Clear;
QuPointage2.SQL.add('select "Pointage.db"."Id_Debit", Sum("Pointage.db"."Montant") from Pointage.db group by "Pointage.db"."Id_Debit"');
QuPointage2.Active:=true;
ListeCompte.Left:=SpeedButton2.Left+Panel1.Left;
RempliGrille2;
ListeCompte.Visible:=true;
ListeCompte.ItemIndex:=0;

end;

procedure TE2_RegmntListe.FormDestroy(Sender: TObject);
begin
DestroyForm(self);
E2_RegmntListe:=nil;
end;

end.
