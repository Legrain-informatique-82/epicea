{***************************************************************
 *
 * Unit Name: emprunts
 * Purpose  :
 * Author   :
 * History  :
 *
 ****************************************************************}

unit emprunts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, ExtCtrls, DBCGrids, StdCtrls, DBCtrls,
  Mask, ToolEdit, RxLookup, RXCtrls, RXDBCtrl, SpeedBar, Menus, RxMenus,
  ComCtrls, EpiceaControl, RXSpin,DateUtil, Buttons, ExRxDBGrid, SDBEdit,dmouverture;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    Table1: TTable;
    DataSource1: TDataSource;
    RxMainMenu1: TRxMainMenu;
    Fichier1: TMenuItem;
    Quitter1: TMenuItem;
    Gestiondesemprunts1: TMenuItem;
    Supprimer: TMenuItem;
    Ajouter2: TMenuItem;
    Imprimer1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    RxSpeedButton2: TRxSpeedButton;
    DataSource2: TDataSource;
    Query1: TQuery;
    RxSpinEdit1: TRxSpinEdit;
    RxSpinEdit2: TRxSpinEdit;
    DateEdit1: TDateEdit;
    Label13: TLabel;
    DateEdit2: TDateEdit;
    RxSpeedButton3: TRxSpeedButton;
    Label14: TLabel;
    Table2: TTable;
    RxSpeedButton4: TRxSpeedButton;
    ExRxDBGrid2: TExRxDBGrid;
    SDBEdit2: TSDBEdit;
    SDBEdit3: TSDBEdit;
    SDBEdit4: TSDBEdit;
    SDBEdit5: TSDBEdit;
    SDBEdit1: TSDBEdit;
    SDBEdit6: TSDBEdit;
    SDBEdit7: TSDBEdit;
    SDBEdit8: TSDBEdit;
    SDBEdit9: TSDBEdit;
    SDBEdit10: TSDBEdit;
    SDBEdit11: TSDBEdit;
    SDBEdit12: TSDBEdit;
    SDBEdit13: TSDBEdit;
    Modifier1: TMenuItem;
    Combobox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ExRxDBGrid1: TExRxDBGrid;
    procedure FermerClick(Sender: TObject);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Ajouter2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure TabSheet1Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RxSpinEdit1Change(Sender: TObject);
    procedure RxSpinEdit2Change(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure DateEdit2Change(Sender: TObject);
    function StrContains(Str1, Str2: string): Boolean;
    procedure DBEdit12KeyPress(Sender: TObject; var Key: Char);
    function IsNumStr(const s: String): Boolean;
    procedure RxSpeedButton3Click(Sender: TObject);
Function Puiss(X,Y:Double):Extended;
    procedure RxSpeedButton4Click(Sender: TObject);
    procedure DataSource1StateChange(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure SDBEdit9Change(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure SupprimerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Combobox1Click(Sender: TObject);
    procedure Combobox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox3Click(Sender: TObject);
    procedure ComboBox4Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;
Const
InvalidDOSChars = ' -\*?/="<>|:,;+^';

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.DFM}

procedure TForm1.FermerClick(Sender: TObject);
begin
close;
end;

procedure TForm1.Table1AfterScroll(DataSet: TDataSet);
var
ValeurDeFiltre :string  ;
begin
ValeurDeFiltre:=ExRxDBGrid2.Fields[0].AsString ;
Query1.SQL.Clear;
Query1.Close;
Query1.SQL.Add('select * from echeancier where codeemprunt='''+ValeurDeFiltre+'''ORDER BY dateecheance');
Query1.Open;

end;

procedure TForm1.Ajouter2Click(Sender: TObject);
var
NouveauCodeEmprunt :integer  ;
begin
 if Query1.RecordCount <> 0 then
    begin
         Query1.SQL.Clear;
         Query1.Close;
         Query1.SQL.Add('select max(codeemprunt) as MaxCodeEmprunt from emprunts');
         Query1.Open;
         NouveauCodeEmprunt:=strtoint(Query1.findfield('MaxCodeEmprunt').AsString)+1;
    end
 else
    begin
         NouveauCodeEmprunt:=001;
    end;

PageControl1.ActivePage :=TTabSheet(PageControl1.Pages[0]);
TabSheet1.Enabled:=true;
TabSheet1.setfocus;
Table1.Append;
sDBEdit1.text:=inttostr(NouveauCodeEmprunt);
SDBEdit2.text:=Combobox1.Text;
DateEdit2.Text:=datetostr(now);
DateEdit1.Text:=datetostr(IncDate(strtodate(DateEdit2.Text),1,0 ,0));

sdbedit6.text:= datetostr(now);
sDBEdit12.text:=datetostr(IncDate(strtodate(sdbedit6.text),1,0 ,0));
sDBEdit11.text:='0';
sDBEdit13.text:='0';
sDBEdit7.text:='0';
sDBEdit8.text:='0';
sDBEdit9.text:='0';
end;

procedure TForm1.RxSpeedButton1Click(Sender: TObject);
begin
if (DateEdit1.Date) <= (DateEdit2.Date) then
     begin
     showmessage('La date de la premiere échéance ne peut pas précéder celle de création');
     Abort;
     end
else
    begin
     Form2.Show ;
     Table1.Post;
    end;
Table1.Refresh;
Table2.Refresh;
ExRxDBGrid1.Refresh;
end;

procedure TForm1.RxSpeedButton2Click(Sender: TObject);
begin
Table1.Cancel;
Table1.First;
abort;
end;

procedure TForm1.TabSheet1Enter(Sender: TObject);
begin
SDBEdit2.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
i:integer;
begin
     For i := 0 to PageControl1.PageCount - 1 do  PageControl1.Pages[i];
end;

procedure TForm1.RxSpinEdit1Change(Sender: TObject);
begin
sDBEdit8.text:=RxSpinEdit1.Text;
end;

procedure TForm1.RxSpinEdit2Change(Sender: TObject);
begin
sDBEdit9.text:=RxSpinEdit2.Text;
end;

procedure TForm1.DateEdit1Change(Sender: TObject);
begin
    sDBEdit12.text:=DateEdit1.Text;
    RxSpeedButton3.Enabled:=true;
end;

procedure TForm1.DateEdit2Change(Sender: TObject);
begin
sDBEdit12.text:=datetostr(IncDate(strtodate(DateEdit2.Text),1,0 ,0));
SDBEdit6.text:=DateEdit2.Text;
end;

Function TForm1.StrContains(Str1, Str2: string): Boolean;
var
i: Integer;
begin
  for i := 1 to Length(Str1) do
  begin
    if (Pos(Str1[i],Str2) <> 0) then
       begin
         Result := True;
         exit;
       end;
  end;
  Result := False;
end;
//******************* TForm1.DBEdit12KeyPress *************************

procedure TForm1.DBEdit12KeyPress(Sender: TObject; var Key: Char);
begin
if (StrContains(InvalidDosChars, Key)) then   Key:=#0;
if not (IsNumStr(key)) then Key:=#0;

end;

//---------------------------------------------------------------------------------------------
function TForm1.IsNumStr(const s: String): Boolean;
 const
   Numerique = ['0'..'9'];
var
   i: Integer;
begin
   result := False;
   if (Length(s) < 1) then exit;
   result := True;
   for i := 1 to Length(s) do
       result := result and (s[i] in Numerique);
end;
//******************* TForm1.RxSpeedButton3Click *************************
procedure TForm1.RxSpeedButton3Click(Sender: TObject);

begin
if (DateEdit1.Date) <= (DateEdit2.Date) then
     begin
     showmessage('La date de la première échéance ne peut pas précéder la création');
     Abort;
     end
else
    begin
 Form2.Show ;
 Table1.Post;
end;
Table1.Refresh;
Table2.Refresh;
ExRxDBGrid1.Refresh;

end;

Function TForm1.Puiss(X,Y:Double):Extended;
// Elevation De X à la puissance Y
Begin
  Puiss:=Exp(Y * LN(X));
end;

procedure TForm1.RxSpeedButton4Click(Sender: TObject);
var
Selection :string  ;
begin
 if table1.RecordCount <> 0 then
    begin
    Selection:=ExRxDBGrid2.Fields[0].AsString;
            If Messagedlg('Etes-vous sûr de supprimer cet emprunt ?',MtConfirmation,[mbyes,mbno],0) = mrno Then
            else
               begin
               Query1.SQL.Clear;
               Query1.Close;
               Query1.SQL.Add('delete from echeancier where codeemprunt='''+Selection+'''');
               Query1.ExecSQL;
               Table1.Delete;
               end;
    end;
end;

procedure TForm1.DataSource1StateChange(Sender: TObject);
begin
if Table1.State = dsinsert  then
    begin
    RxSpeedButton2.Enabled:=true;
    RxSpeedButton3.Enabled:=true;
    RxSpeedButton4.Enabled:=true;
    PageControl1.Pages[1].Enabled:=false;
    PageControl1.Pages[2].Enabled:=false;

    end;
if Table1.State = dsbrowse  then
    begin
    RxSpeedButton2.Enabled:=false;
    RxSpeedButton3.Enabled:=false;
    RxSpeedButton4.Enabled:=true;

    PageControl1.Pages[0].Enabled:=false;
    PageControl1.Pages[1].Enabled:=true;
    PageControl1.Pages[2].Enabled:=true;
    end;
if Table1.State = dsedit  then
    begin
    RxSpeedButton2.Enabled:=false;
    RxSpeedButton3.Enabled:=true;
    RxSpeedButton4.Enabled:=true;
    PageControl1.Pages[0].Enabled:=true;
    PageControl1.Pages[1].Enabled:=false;
    PageControl1.Pages[2].Enabled:=true;
   end;
end;

procedure TForm1.Imprimer1Click(Sender: TObject);
begin

if (PageControl1.Pages[2].Name) =(PageControl1.ActivePage.Name) then ExRxDBGrid1.GridPreview;
if (PageControl1.Pages[1].Name) =(PageControl1.ActivePage.Name) then
    begin
        ExRxDBGrid2.gridPreview;
        ExRxDBGrid1.GridPreview
    end;
end;

procedure TForm1.SDBEdit9Change(Sender: TObject);
begin
if length(sDBEdit9.Text)<> 0 then
label14.Caption:='Soit : '+ inttostr(strtoint(sDBEdit9.Text) div 12)+' Ans';
end;

procedure TForm1.Modifier1Click(Sender: TObject);
var
Selection :string  ;
begin
PageControl1.ActivePage :=TTabSheet(PageControl1.Pages[0]);
 if table1.RecordCount <> 0 then
    begin
    Selection:=SDBEdit1.Text;
               begin
               Query1.SQL.Clear;
               Query1.Close;
               Query1.SQL.Add('delete from echeancier where codeemprunt='''+Selection+'''');
               Query1.ExecSQL;
   end;
               Table1.edit;
end;
DateEdit2.Text:=datetostr((strtodate(SDBEdit6.Text)));
DateEdit1.Text:=datetostr((strtodate(SDBEdit12.Text)));

end;

procedure TForm1.Quitter1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.SupprimerClick(Sender: TObject);
begin
RxSpeedButton4Click(sender);
end;

procedure TForm1.FormShow(Sender: TObject);
var
j:integer;
begin
  // Rempli le Combo des comptes
 ComboBox1.Items.AddStrings(DmOpen.RempliCombo(DmOpen.TAEmprunts,2,15));
      combobox1.ItemIndex:=0;
      ComboBox1.Items.Delete(0) ;
      combobox1.ItemIndex :=0;

for j:=0 to Table1.RecordCount -1 do
    begin
    Combobox2.Items.Add(Table1.findfield('organisme').AsString);
    Table1.Next;
    end;
combobox2.ItemIndex :=0;

Combobox3.Items.Add('Mensualité constante');
Combobox3.Items.Add('Capital constant');
combobox3.ItemIndex :=0;

combobox4.Items.Add('Mensuel');
Combobox4.Items.Add('Timestriel');
Combobox4.Items.Add('Annuel');
combobox4.ItemIndex :=0;
end;

procedure TForm1.Combobox1Click(Sender: TObject);
begin
SDBEdit2.text:=Combobox1.Text;
SDBEdit3.text:=dmopen.TAEmprunts.FindField('designation_emp').AsString;
end;

procedure TForm1.Combobox1Change(Sender: TObject);
begin
SDBEdit2.text:=Combobox1.Text;
SDBEdit3.text:=dmopen.TAEmprunts.FindField('designation_emp').AsString;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

Table1.Close;
Table2.Close;
Query1.Close;
end;

procedure TForm1.ComboBox3Click(Sender: TObject);
begin
SDBEdit4.text:=combobox3.Text;
end;

procedure TForm1.ComboBox4Click(Sender: TObject);
begin
SDBEdit10.text:=ComboBox4.text;
end;



end.
