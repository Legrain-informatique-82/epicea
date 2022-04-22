unit fGridCols;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ExtCtrls, db, DBGrids;

type
  TFormGridCols = class(TForm)
    Panel1: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    clbColumns: TCheckListBox;
    btnAll: TButton;
    btnNone: TButton;
    procedure btnAllClick(Sender: TObject);
    procedure btnNoneClick(Sender: TObject);
    procedure clbColumnsClickCheck(Sender: TObject);
  private
    FGrid: TDBGrid;
    { Private declarations }
    procedure SetAllColumns( Value : boolean );
    procedure SetGrid(const Value: TDBGrid);
  public
    { Public declarations }
    property Grid : TDBGrid read FGrid write SetGrid;
    procedure GetColumnList;
    procedure SetColumnList;
    function CountCheckState( State : TCheckBoxState ) : integer;
  end;

procedure GridColumnToggler( const AGrid : TDBGrid );
function FindFieldColumn( const Grid : TDBGrid; const Field : TField ) : integer;

function SetAllChecklistBox( Box : TCheckListBox; const Value : boolean ) : integer;
function GetGridColumns( const Grid : TDBGrid; Box : TCheckListBox ) : integer;
function SetGridColumns( Grid : TDBGrid; const Box : TCheckListBox ) : integer;
function CountCheckListState( Box : TCheckListBox; State : TCheckBoxState ) : integer;

var
  FormGridCols: TFormGridCols;

implementation

{$R *.DFM}

procedure GridColumnToggler( const AGrid : TDBGrid );
begin
  with TFormGridCols.Create( Application ) do
  try
    Grid := AGrid;
    if ShowModal = mrOk then
      SetColumnList;
  finally
    Free;
  end; { finally }
end; { GridColumnToggler() }

function FindFieldColumn( const Grid : TDBGrid; const Field : TField ) : integer;
var
  i : integer;
begin
  for i := 0 to Grid.Columns.Count - 1 do
    if Grid.Columns[ i ].Field = Field then
    begin
      Result := i;
      Exit;
    end;
  Result := -1;
end; { FindFieldColumn() }

function GetGridColumns( const Grid : TDBGrid; Box : TCheckListBox ) : integer;
var
  i, j, k : integer;
  Field : TField;
begin
  Box.Items.Clear;
  try
    Box.Items.BeginUpdate;
    if Assigned( Grid.DataSource.DataSet ) then
      for i := 0 to Grid.DataSource.DataSet.Fields.Count - 1 do
      begin
        Field := Grid.DataSource.DataSet.Fields[ i ];
        if Field.Visible then
        begin
          j := Box.Items.Add( Field.DisplayName );
          k := FindFieldColumn( Grid, Field );
          Box.Checked[ j ] := ( k >= 0 ) and Grid.Columns.Items[ k ].Visible;
          Box.Items.Objects[ j ] := Field;
        end; { Field should be listed }
      end; { for }
  finally
    Box.Items.EndUpdate;
  end; { finally }
  Result := Box.Items.Count;
end; { GetGridColumns() }

function SetAllChecklistBox( Box : TCheckListBox; const Value : boolean ) : integer;
var
  i : integer;
begin
  for i := 0 to Box.Items.Count - 1 do
    Box.Checked[ i ] := Value;
  Result := Box.Items.Count;
end;

function SetGridColumns( Grid : TDBGrid; const Box : TCheckListBox ) : integer;
var
  i, j : integer;
  Field : TField;

  procedure AddField(Field: TField; Depth: Integer );
  var
    I: Integer;
  begin
    Inc(Depth);
    Grid.Columns.Add.Field := Field;
    if Field.DataType in [ ftADT, ftArray ] then
    for I := 0 to ( Field as TObjectField ).Fields.Count - 1 do
      AddField( (Field as TObjectField).Fields[ I ], Depth);
  end;

begin
  Grid.Columns.BeginUpdate;
  try
    for i := 0 to Box.Items.Count - 1 do
    begin
      Field := TField( Box.Items.Objects[ i ] );
      j := FindFieldColumn( Grid, Field );
      if Box.Checked[ i ] then
      begin
        if j < 0 then
          AddField( Field, 0 )
        else
          Grid.Columns.Items[ j ].Visible := True; { Add the field }
      end
      else if j > 0 then
        Grid.Columns.Items[ j ].Visible := False;
    end; { for }
  finally
    Grid.Columns.EndUpdate;
  end; { finally }
  Result := Grid.Columns.Count;
end;

function CountCheckListState(Box : TCheckListBox; State: TCheckBoxState): integer;
var
  i : integer;
begin
  Result := 0;
  for i := 0 to Box.Items.Count - 1 do
    if Box.State[ i ] = State then
      Inc( Result );

end; { CountCheckState() }

{ TFormGridCols }
procedure TFormGridCols.btnAllClick(Sender: TObject);
begin
  SetAllColumns( True );
end;

procedure TFormGridCols.SetAllColumns(Value: boolean);
begin
  btnOk.Enabled := SetAllChecklistBox( clbColumns, Value ) > 0;
end;

procedure TFormGridCols.btnNoneClick(Sender: TObject);
begin
  SetAllCheckListBox( clbColumns, False );
  btnOk.Enabled := False;
end;

procedure TFormGridCols.GetColumnList;
begin
  btnOk.Enabled := GetGridColumns( Grid, clbColumns ) > 0;
end;

procedure TFormGridCols.SetColumnList;
begin
  SetGridColumns( Grid, clbColumns );
end;

procedure TFormGridCols.SetGrid(const Value: TDBGrid);
begin
  if FGrid <> Value then
  begin
    FGrid := Value;
    if Assigned( FGrid ) then
      GetColumnList
    else
    begin
      clbColumns.Items.Clear;
      btnOk.Enabled := False;
    end;
  end;
end;

procedure TFormGridCols.clbColumnsClickCheck(Sender: TObject);
begin
  btnOk.Enabled := CountCheckState( cbChecked ) > 0;
end;

function TFormGridCols.CountCheckState(State: TCheckBoxState): integer;
begin
  Result := CountCheckListState( clbColumns, State );
end;

end.
