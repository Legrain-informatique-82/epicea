unit E2_InitTableEpi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, checklst, RXCtrls,DBTables,DMBaseDonnee,Lib_Genere_LibInfosTable
  ,Lib_Genere_LibIntegriteTable;

type
  TInitTableEpi = class(TForm)
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    CheckListBox3: TCheckListBox;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel3: TRxLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ListBox1: TListBox;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    Procedure SelectionnerTableAvantImport(Sender:TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    dbProgramme,dbDossier,dbExercice:TDataBase;
  end;

var
  InitTableEpi: TInitTableEpi;

implementation

{$R *.DFM}

procedure TInitTableEpi.Button1Click(Sender: TObject);
var
i:integer;
TableTmp:TTable;
begin
TableTmp:=TTable.create(self);
TableTmp.DatabaseName:=dbProgramme.DatabaseName;
for i:=0 to CheckListBox1.Items.Count - 1 do
 Begin
  if CheckListBox1.Checked[i] then
   begin
    TableTmp.TableName:=CheckListBox1.Items[i];
    TableTmp.EmptyTable;
//    TableTmp.FlushBuffers;
   end;
 End;
TableTmp.Free;
showmessage('Les tables sélectionnées ont été vidées !');
end;

procedure TInitTableEpi.Button2Click(Sender: TObject);
var
i:integer;
TableTmp:TTable;
begin
TableTmp:=TTable.create(self);
TableTmp.DatabaseName:=dbDossier.DatabaseName;
for i:=0 to CheckListBox2.Items.Count - 1 do
 Begin
  if CheckListBox2.Checked[i] then
   begin
    TableTmp.TableName:=CheckListBox2.Items[i];
    TableTmp.EmptyTable;
//    TableTmp.FlushBuffers;
   end;
 End;
TableTmp.Free;
//showmessage('Les tables Dossier ont été vidées !');
end;

procedure TInitTableEpi.Button3Click(Sender: TObject);
var
i:integer;
TableTmp:TTable;
begin
TableTmp:=TTable.create(self);
TableTmp.DatabaseName:=dbExercice.DatabaseName;
for i:=0 to CheckListBox3.Items.Count - 1 do
 Begin
  if CheckListBox3.Checked[i] then
   begin
    TableTmp.TableName:=CheckListBox3.Items[i];
    TableTmp.EmptyTable;
//    TableTmp.FlushBuffers;
   end;
 End;
TableTmp.Free;
//showmessage('Les tables Exercices ont été vidées !');
end;

procedure TInitTableEpi.Button4Click(Sender: TObject);
var
i:integer;
begin
for i:=0 to CheckListBox3.Items.Count -1 do
   CheckListBox3.Checked[i]:=true;
end;

procedure TInitTableEpi.Button5Click(Sender: TObject);
var
i:integer;
begin

for i:=0 to CheckListBox2.Items.Count -1 do
   CheckListBox2.Checked[i]:=IndexTableEpicea(CheckListBox2.Items.Strings[i]) in [201..208,214,215,225];

end;

procedure TInitTableEpi.Button6Click(Sender: TObject);
begin
Cree_LibInfosTable([TStringList(CheckListBox1.Items),TStringList(CheckListBox2.Items),TStringList(CheckListBox3.Items)],[dbProgramme,dbDossier,dbExercice]);
end;

Procedure TInitTableEpi.SelectionnerTableAvantImport(Sender:TObject);
var
i:integer;
Begin
// LEs numeros du tableau indique les tables du dossier à vider
// 306 = table emprunts
// la 212 est exclus car c'est la table param_entreprise
for i:=0 to CheckListBox2.Items.Count -1 do
   CheckListBox2.Checked[i]:=((IndexTableEpicea(CheckListBox2.Items.Strings[i]) in [201..211])or
                              (IndexTableEpicea(CheckListBox2.Items.Strings[i]) in [213..225]) or
                              (IndexTableEpicea(CheckListBox2.Items.Strings[i]) = 306));
for i:=0 to CheckListBox3.Items.Count -1 do
  CheckListBox3.Checked[i]:=true;

Button2Click(Button2);
Button3Click(Button3);
End;

end.
