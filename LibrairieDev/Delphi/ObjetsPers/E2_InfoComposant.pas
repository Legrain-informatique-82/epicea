unit E2_InfoComposant;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid,
  Gr_Librairie_Obj,dbTables,Lib_chaine,LibSQL,E2_Decl_records;

type
  TInfoComposant = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    ListBox3: TListBox;
    Panel2: TPanel;
    Panel3: TPanel;
    ListBox2: TListBox;
    ListBox4: TListBox;
    LaNbComposant: TLabel;
    GrDBGrid1: TGrDBGrid;
    DaReference: TDataSource;
    ComboBox1: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure ListBox3Click_Maint(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  Maintenance:boolean;
  NomMaint:string;
  end;

var
  InfoComposant: TInfoComposant;
  RefermeTable:boolean;
implementation

uses
LibZoneSaisie;
{$R *.DFM}

procedure TInfoComposant.FormActivate(Sender: TObject);
var
i:integer;
begin
//ListBox1.Items.Add('Liste des Fenêtres');
RefermeTable:=false;
ListBox1.Items.Clear;
ListBox3.Items.Clear;
for i:=0 to screen.FormCount - 1 do
 begin
 ListBox1.Items.AddObject(screen.Forms[i].Name,screen.Forms[i]);
 end;
//ListBox1.Items.Add('Liste des Modules');

for i:=0 to screen.DataModuleCount - 1 do
 begin
  ListBox3.Items.AddObject(screen.DataModules[i].Name,screen.DataModules[i]);
 end;
end;

procedure TInfoComposant.ListBox1Click(Sender: TObject);
var
i:integer;
begin
ListBox2.Clear;
i:=0;
for i:=0 to (ListBox1.Items.Objects[ListBox1.ItemIndex] as TCustomForm).ComponentCount - 1 do
 Begin
   ListBox2.items.AddObject((ListBox1.Items.Objects[ListBox1.ItemIndex] as TCustomForm).Components[i].name,(ListBox1.Items.Objects[ListBox1.ItemIndex] as TCustomForm).Components[i]);
 //  if StrIComp(PChar(form.Components[i].Name),PChar(Comp))=0 then Composant:=form.Components[i];
 End;
LaNbComposant.Caption:='Nombre de composants : '+inttostr((ListBox1.Items.Objects[ListBox1.ItemIndex] as TCustomForm).ComponentCount);

//if DataM <> nil then
//   for i:=0 to DataM.ComponentCount - 1 do
//    Begin
//     if StrIComp(PChar(DataM.Components[i].Name),PChar(Comp))=0 then Composant:=DataM.Components[i];
//    End;
//ListBox2.Items.Clear;
//if form <> nil then
//   for i:=0 to form.ComponentCount - 1 do
//    Begin
//     if StrIComp(PChar(form.Components[i].Name),PChar(Comp))=0 then Composant:=form.Components[i];
//    End;
//if DataM <> nil then
//   for i:=0 to DataM.ComponentCount - 1 do
//    Begin
//     if StrIComp(PChar(DataM.Components[i].Name),PChar(Comp))=0 then Composant:=DataM.Components[i];
//    End;
end;

procedure TInfoComposant.ListBox3Click(Sender: TObject);
var
i:integer;
begin
ListBox2.Clear;
i:=0;
for i:=0 to (ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).ComponentCount - 1 do
 Begin
   ListBox2.items.AddObject((ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i].name,(ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i]);
   if ComboBox1.Items.IndexOf((ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i].ClassName) = -1 then
        ComboBox1.Items.Add((ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i].ClassName);

 End;
LaNbComposant.Caption:='Nombre de composants : '+inttostr((ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).ComponentCount);
end;

procedure TInfoComposant.ListBox3Click_Maint(Sender: TObject);
var
i:integer;
begin
ListBox2.Clear;
i:=0;
for i:=0 to (ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).ComponentCount - 1 do
 Begin
  if Maintenance then
   begin
    if str_fini_par((ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i].name,NomMaint) then
     ListBox2.items.AddObject((ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i].name,(ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i]);
   end
   else
   begin
     ListBox2.items.AddObject((ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i].name,(ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).Components[i]);
   end;
 End;
LaNbComposant.Caption:='Nombre de composants : '+inttostr((ListBox3.Items.Objects[ListBox3.ItemIndex] as TDataModule).ComponentCount);
end;

procedure TInfoComposant.ListBox2Click(Sender: TObject);
begin
if RefermeTable then
 begin
  if GrDBGrid1.DataSource.DataSet.Active then
  GrDBGrid1.DataSource.DataSet.Close;
 end;
RefermeTable:=false;
GrDBGrid1.Visible:=false;
ListBox4.Visible:=true;
if ListBox2.ItemIndex > -1 then
ListBox4.Items:=AfficheInfoComposant('',(ListBox2.Items.Objects[ListBox2.ItemIndex] as TComponent),False)

end;

procedure TInfoComposant.ListBox2DblClick(Sender: TObject);
var
OldOpen:Boolean;
ExecFunction:TExecFDataSet;
TablePrincipale:TDataSet;
begin
case RecupClassTypeComponent((ListBox2.Items.Objects[ListBox2.ItemIndex] as TComponent)) of
   GTDataSource:GrDBGrid1.DataSource:=(ListBox2.Items.Objects[ListBox2.ItemIndex] as TDataSource);
   GTQuery:begin
             GrDBGrid1.DataSource:=DaReference;
             OldOpen:=(ListBox2.Items.Objects[ListBox2.ItemIndex] as TQuery).Active;
             DaReference.DataSet:=(ListBox2.Items.Objects[ListBox2.ItemIndex] as TQuery);
             AffecteEvenement((ListBox2.Items.Objects[ListBox2.ItemIndex] as TQuery),DaReference.DataSet);
           end;
   GTable:begin
             GrDBGrid1.DataSource:=DaReference;
             DaReference.DataSet:=(ListBox2.Items.Objects[ListBox2.ItemIndex] as TTable);
             OldOpen:=(ListBox2.Items.Objects[ListBox2.ItemIndex] as TTable).Active;
             if (ListBox2.Items.Objects[ListBox2.ItemIndex] as TTable).Name = 'TaPlanMaint' then
              begin
               if (ListBox2.Items.Objects[ListBox2.ItemIndex] as TTable).Owner is TdataModule then
                 begin
//                   Showmessage(((ListBox2.Items.Objects[ListBox2.ItemIndex] as TTable).Owner as TdataModule).Name);
                   if ((ListBox2.Items.Objects[ListBox2.ItemIndex] as TTable).Owner as TdataModule).MethodAddress('NomTablePrincipale') <> nil then
                    begin
                     @ExecFunction:=((ListBox2.Items.Objects[ListBox2.ItemIndex] as TTable).Owner as TdataModule).MethodAddress('NomTablePrincipale');
                     TablePrincipale:=ExecFunction;
                     AffecteEvenement((TablePrincipale as TTable),DaReference.DataSet);
                    end;
                 end;
              end;
          end;
end;
if not DaReference.DataSet.Active then
 begin
   if Messagedlg('La source de données est fermée !! Voulez-vous l''activer ?',mtConfirmation,[mbyes,mbno],0)=mryes then
    begin
     RefermeTable:=true;
     DaReference.DataSet.Open;
    end;
 end
 else
 Begin
  DaReference.DataSet.Refresh;
 End;

GrDBGrid1.Visible:=true;
GrDBGrid1.SetFocus;
ListBox4.Visible:=false;


end;

procedure TInfoComposant.ComboBox1Click(Sender: TObject);
Var
NomClasse:string;
i:integer;
begin
//ListBox2.MultiSelect:=true;
NomClasse:=ComboBox1.Items[ComboBox1.ItemIndex];
for i:=0 to ListBox2.Items.Count - 1 do
   ListBox2.Selected[i]:= ListBox2.items.Objects[i].ClassName = NomClasse;
end;

end.
