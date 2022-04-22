unit RequeteSql;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid, ExtCtrls, DB,
  DBTables, Tabs, Animate, RXSplit, RXCtrls, StdCtrls, DBIndex, Buttons,ShellAPI,
  Menus;

type
  TEditeurRequeteSql = class(TForm)
    Panel1: TPanel;
    Notebook1: TNotebook;
    rxDBGrid2: TRxDBGrid;
    Panel7: TPanel;
    Label2: TLabel;
    DBIndexCombo1: TDBIndexCombo;
    Panel2: TPanel;
    SQLMemo: TMemo;
    Panel3: TPanel;
    RunSQL: TRxSpeedButton;
    Panel4: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    rxSplitter2: TRxSplitter;
    Panel9: TPanel;
    QueryAnimation: TAnimatedImage;
    TabSet1: TTabSet;
    Query1: TQuery;
    Database1: TDatabase;
    Session1: TSession;
    DataSource1: TDataSource;
    Panel8: TPanel;
    OpenDialog1: TOpenDialog;
    RadioGroup1: TRadioGroup;
    OpenSql: TRxSpeedButton;
    BitBtn1: TBitBtn;
    GrDBGrid1: TGrDBGrid;
    PriorSQL: TRxSpeedButton;
    NextSQL: TRxSpeedButton;
    OpenDialog2: TOpenDialog;
    BitBtn2: TBitBtn;
    PopupSQLMenu: TPopupMenu;
    Undo1: TMenuItem;
    N2: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N3: TMenuItem;
    SelectAll1: TMenuItem;
    N4: TMenuItem;
    Saveas1: TMenuItem;
    Load1: TMenuItem;
    PriorSQLItem: TMenuItem;
    NextSQLItem: TMenuItem;
    Runquery1: TMenuItem;
    SaveDialog1: TSaveDialog;
    BitBtn3: TBitBtn;
    Extraction1: TMenuItem;
    Effacerlhistorique1: TMenuItem;
    procedure RunSQLClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OpenSqlClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure NavigateSQLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Effacerlhistorique1Click(Sender: TObject);
  private
    { Déclarations privées }
    FSQLHistoryIndex: Integer;
    FSQLHistory: TStrings;
    SQLHistoryCapacity:integer;
        procedure UpdateSQLHistory;
            procedure EnableSQLHistoryItems;
  public
    { Déclarations publiques }
  end;

var
  EditeurRequeteSql: TEditeurRequeteSql;

implementation

uses DMConstantes, E2_Librairie_Obj, LibSQL, LibFichRep;

{$R *.dfm}

procedure TEditeurRequeteSql.RunSQLClick(Sender: TObject);
begin
query1.close;
query1.SQL.Clear;
query1.SQL.Text:=SQLMemo.Lines.Text;
UpdateSQLHistory;
query1.ExecSQL;
end;

procedure TEditeurRequeteSql.RadioGroup1Click(Sender: TObject);
begin
Query1.close;
query1.SQL.Clear;
 case RadioGroup1.ItemIndex of
   0:begin
       Query1.DatabaseName:=DM_C_NomAliasProgram;
     end;
   1:begin
       Query1.DatabaseName:=DM_C_NomAliasDossier;
     end;
   2:begin
       Query1.DatabaseName:=DM_C_NomAliasExercice;
     end;
   end;
end;

procedure TEditeurRequeteSql.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
Query1.Close;
end;

procedure TEditeurRequeteSql.OpenSqlClick(Sender: TObject);
begin
query1.close;
query1.SQL.Clear;
query1.SQL.Text:=SQLMemo.Lines.Text;
UpdateSQLHistory;
query1.Open;
end;

procedure TEditeurRequeteSql.BitBtn1Click(Sender: TObject);
var
ResultChoisirRep:TResultChoisirRep;
ParamChoixRep:TParamChoixRep;
requete:TQuery;
begin
  ParamChoixRep.RepDefaut := IncludeTrailingPathDelimiter(E.RepertoireExportDossier);
  ParamChoixRep.TitreForm :='Emplacement de l''extraction';
  ResultChoisirRep:=ChoisirRepertoire(ParamChoixRep);
  if ResultChoisirRep.Retour then
   begin
     requete:=TQuery.Create(self);
     //GrDBGrid1.ExportToFile(IncludeTrailingPathDelimiter(ResultChoisirRep.RepChoisi)+'Extraction.txt',';');
     ChampTableVersListeEx(CloneDataSet(Query1,requete),';',false).SaveToFile(IncludeTrailingPathDelimiter(ResultChoisirRep.RepChoisi)+'Extraction.txt');
     ShellExecute(handle, 'explore', Pchar(IncludeTrailingPathDelimiter(ResultChoisirRep.RepChoisi)), NiL, NiL, SW_SHOWNORMAL);
     requete.free;
   end;
end;

procedure TEditeurRequeteSql.FormDestroy(Sender: TObject);
begin
EditeurRequeteSql:=nil;
Query1.free;
FSQLHistory.free;
end;

procedure TEditeurRequeteSql.FormHide(Sender: TObject);
begin
Query1.sql.clear;
Query1.Close;
end;


procedure TEditeurRequeteSql.NavigateSQLClick(Sender: TObject);
var
  NewSQL: Boolean;
begin
  if (FSQLHistory = nil) or (FSQLHistory.Count = 0) then Exit;
  NewSQL := False;
  if Sender = PriorSQL then begin
    if FSQLHistoryIndex > 0 then Dec(FSQLHistoryIndex)
    else if FSQLHistoryIndex = -1 then begin
      UpdateSQLHistory;
      FSQLHistoryIndex := FSQLHistory.Count - 1;
    end;
  end
  else if Sender = NextSQL then begin
    if FSQLHistoryIndex = -1 then UpdateSQLHistory;
    if FSQLHistoryIndex < FSQLHistory.Count - 1 then
      Inc(FSQLHistoryIndex)
    else begin
      NewSQL := True;
    end;
  end;
  if NewSQL then begin
    FSQLHistoryIndex := -1;
    SQLMemo.Clear;
    SQLMemo.Modified := False;
  end
  else begin
    SQLMemo.Lines.Assign(TStrings(FSQLHistory.Objects[FSQLHistoryIndex]));
    SQLMemo.Modified := False;
  end;
  EnableSQLHistoryItems;
end;


procedure TEditeurRequeteSql.UpdateSQLHistory;
begin
  if (SQLMemo.Modified) and (SQLMemo.Lines.Count > 0) then begin
    while ((FSQLHistory.Count >= SQLHistoryCapacity)and (FSQLHistory.Count>0)) do
      if FSQLHistory.Count > 0 then FSQLHistory.Delete(0);
    if (SQLHistoryCapacity > 0) then begin
      FSQLHistoryIndex := FSQLHistory.AddObject('',
        TStringList.Create);
      TStrings(FSQLHistory.Objects[FSQLHistoryIndex]).Assign(SQLMemo.Lines);
      SQLMemo.Modified := False;
    end;
  end;
  EnableSQLHistoryItems;
end;

procedure TEditeurRequeteSql.EnableSQLHistoryItems;
begin
  PriorSQL.Enabled := ((FSQLHistoryIndex > 0) or (FSQLHistoryIndex = -1)) and
    (FSQLHistory.Count > 0);
//  PriorSQLItem.Enabled := PriorSQL.Enabled;
  NextSQL.Enabled := (FSQLHistoryIndex <> -1);
//  NextSQLItem.Enabled := NextSQL.Enabled;
end;

procedure TEditeurRequeteSql.FormCreate(Sender: TObject);
begin
SQLHistoryCapacity:=20;
  FSQLHistory := TStringList.Create;
end;

procedure TEditeurRequeteSql.BitBtn2Click(Sender: TObject);
begin
   if OpenDialog2.Execute then begin
       OpenDialog2.InitialDir := ExtractFilePath(OpenDialog2.FileName);
       SQLMemo.Lines.LoadFromFile(OpenDialog2.FileName);
       SQLMemo.Modified := True;
       UpdateSQLHistory;
     end;
end;

procedure TEditeurRequeteSql.Undo1Click(Sender: TObject);
begin
  case TMenuItem(Sender).Tag of
    1: if SQLMemo.Perform(EM_CANUNDO, 0, 0) <> 0 then
         SQLMemo.Perform(EM_UNDO, 0, 0);
    2: SQLMemo.CutToClipboard;
    3: SQLMemo.CopyToClipboard;
    4: SQLMemo.PasteFromClipboard;
    5: SQLMemo.SelectAll;
    6: if SaveDialog1.Execute then begin
         SaveDialog1.InitialDir := ExtractFilePath(SaveDialog1.FileName);
         SQLMemo.Lines.SaveToFile(SaveDialog1.FileName);
       end;
    7: if OpenDialog2.Execute then begin
         OpenDialog2.InitialDir := ExtractFilePath(OpenDialog2.FileName);
         SQLMemo.Lines.LoadFromFile(OpenDialog2.FileName);
         SQLMemo.Modified := True;
         UpdateSQLHistory;
       end;
    8: RunSQLClick(Sender);
    9: NavigateSQLClick(PriorSQL);
   10: NavigateSQLClick(NextSQL);
  end;
end;


procedure TEditeurRequeteSql.BitBtn3Click(Sender: TObject);
begin
     if SaveDialog1.Execute then begin
         SaveDialog1.InitialDir := ExtractFilePath(SaveDialog1.FileName);
         SQLMemo.Lines.SaveToFile(SaveDialog1.FileName);
       end;
end;

procedure TEditeurRequeteSql.Effacerlhistorique1Click(Sender: TObject);
begin
//
FSQLHistory.Clear;
SQLMemo.Clear;
end;

end.


