unit CSDBGrid;
{
  Copyright (c) 1999 - 2000 Inprise Corporation
  Written by Anders Ohlsson and John F. Kaster

  Anders Ohlsson
    - created the TClientDataSetGrid component
    - wrote the arrow drawing for the columns

  John Kaster
    - implemented SortGrid
    - overrode the default TitleClick() procedure
    - added TitleSort, ArrowShade, ArrowHighlight, ArrowColor
    - added ConfigureColumns & persistence for the columns with ConfigFile
      property
    - Adopted a suggestion from Ruud Bijvank for making sure the drawn arrow
      is not drawn over the title of the column.

  Usage:
  - Click on the column to change the listing order to that column only.
  - Click on an indexed column to reverse the listing order of that column
    only.
  - Shift-Click on a non-indexed column to ADD it to the listing order.
  - Shift-Click on an indexed column to cycle its listing order through
    descending, and off.

  Description:

  This component is a descendant of TDBGrid, and can be used with any TDataset
  descendant.  If the dataset used in the grid is a TClientDataSet or
  descendant, the "sorting" feature of the grid can be enabled to work
  automatically with any dataset.

  History:
    Sep 21 2000
    - fixed bug with dgIndicator being off causing the arrow to be drawn
      in the wrong column
    - changed the column click logic when multiple columns are in use to
      toggle a column as ascending, descending, off, ascending, descending,
      off. This only is used with Shift-Clicking.

}
{ TODO -ojfk : Draw "ordering" arrows for existing active index when data is
first activated }
{ TODO -ojfk :
Embed a small number inside the index indicator arrow so the order of multiple
fields is known. Only do this when there is more than one field in the index }
{ TODO -ojfk : Support using graphic arrows instead of having to draw them }
{ TODO -ojfk : Fix bug with lingering arrows being drawn in the last column of
the grid after the last column is no longer in the index }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, db, DBGrids;

type
  TArrowType = (atNone, atDown, atUp);

  TClientDataSetGrid = class(TDBGrid)
  private
    { Private declarations }
    FArrow : array of TArrowType;
    FArrowHighlight: TColor;
    FArrowShade: TColor;
    FTitleSort: boolean;
    FConfigFile: string;
    FArrowColor: TColor;
    procedure SetArrow(Index : Integer; Value : TArrowType);
    function GetArrow(Index : Integer) : TArrowType;
    procedure SetConfigFile(const Value: string);
  protected
    { Protected declarations }
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure TitleClick(Column : TColumn); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Arrow[Index : Integer] : TArrowType read GetArrow write SetArrow;
    procedure GetAvailableColumns( ColumnList : TStrings; const VisibleOnly : boolean = True );
    procedure GetActiveColumns( ColumnList : TStrings );
    procedure SaveSettings( FileName : string = '' );
    procedure LoadSettings( FileName : string = '' );
    function FindFieldColumn( Value : TField ) : integer;
    procedure ConfigureColumns;
  published
    { Published declarations }
    property ConfigFile : string read FConfigFile write SetConfigFile;
    property ArrowShade : TColor read FArrowShade write FArrowShade
      default clBtnShadow;
    property ArrowHighlight : TColor read FArrowHighlight write FArrowHighlight
      default clWhite;
    property ArrowColor : TColor read FArrowColor write FArrowColor;
    property TitleSort : boolean read FTitleSort write FTitleSort default True;
  end;

procedure SortGrid( Column : TColumn; const IndexName : string = 'SortGrid' );
procedure ListFieldNames( List : TStrings; const FieldNames : string );
procedure ListIntersect( OldList, NewList : TStrings );
function SemiText( const List : TStrings ) : string;

procedure Register;

implementation

uses DBClient, fGridCols;

function GetIndexDef( cds : TDataSet; const sName : string ) : TIndexDef;
var
  Indices : TIndexDefs;
  Index : integer;
begin
  Result := nil;
  Indices := nil;
  if cds is TClientDataSet then
    Indices := TClientDataSet( cds ).IndexDefs;
    { TODO : why isn't PSGetIndexDefs working? }
    // Indices := IProviderSupport( TClientDataSet( cds ) ).PSGetIndexDefs;
  if Assigned( Indices ) then
  begin
    Index := Indices.IndexOf( sName );
    if Index <> -1 then
      Result := Indices[ Index ]
    else
      Result := nil;
  end;
end; { GetIndexDef() }

procedure ListFieldNames( List : TStrings; const FieldNames : string );
var
  Pos: Integer;
begin
  Pos := 1;
  while Pos <= Length(FieldNames) do
    List.Add(ExtractFieldName(FieldNames, Pos));
end; { ListFieldNames() }

procedure ListIntersect( OldList, NewList : TStrings );
var
  Pos: Integer;
begin
  Pos := OldList.Count - 1;
  while Pos > -1 do
  begin
    if NewList.IndexOf( OldList[ Pos ] ) = -1 then
      OldList.Delete( Pos );
    Dec( Pos );
  end; { while }
end; { ListIntersect() }

function SemiText( const List : TStrings ) : string;
var
  i, j : integer;
begin
  j := List.Count - 1;
  if j >= 0 then
  begin
    Result := List[ 0 ];
    for i := 1 to j do
      Result := Result + ';' + List[ i ];
  end
  else
    Result := '';

end; { SemiText() }

procedure SortGrid( Column : TColumn; const IndexName : string = 'SortGrid' );
var
  Shifted : boolean;
  { TODO -ojfk : Make TDataset using Interface }
  cds : TClientDataSet;
  KeyState : TKeyboardState;
  ShiftState : TShiftState;

  procedure SetIndexField( const FieldNames : string; Shifty : boolean;
    ColIndex : integer );
  var
    ccDB : TClientDataSetGrid;
    i, j,
    AscField,
    ColOffset : integer;
    DescList,
    FieldList,
    NewList : TStringList;
    IndexDef : TIndexDef;
    FieldName,
    AllFields,
    DescFields : string;
    IdxOpts   : TIndexOptions;
  begin
    FieldList := nil;
    NewList := nil;
    DescList := TStringList.Create;
    if Column.Grid is TClientDataSetGrid then
      ccDB := TClientDataSetGrid( Column.Grid )
    else
      ccDB := nil;
    try
      FieldList := TStringList.Create;
      NewList := TStringList.Create;
      ListFieldNames( NewList, FieldNames );
      IndexDef := GetIndexDef( cds, IndexName );
      IdxOpts := [];
      if Assigned( IndexDef ) then
      begin
        ListFieldNames( FieldList, IndexDef.Fields );
        if ( ixDescending in IndexDef.Options ) then
          DescList.Assign( FieldList ) { All fields descending }
        else if ( IndexDef.DescFields <> '' ) then
          ListFieldNames( DescList, IndexDef.DescFields ); { Some fields descending }

        if Shifty then { Additive index }
          IdxOpts  := IndexDef.Options
        else { Only retain fields currently in index }
        begin
          if Assigned( ccDB ) then { Clear sort orders }
            for i := 0 to ccDB.Columns.Count - 1 do
              ccDB.Arrow[ i ] := atNone;
          ListIntersect( FieldList, NewList );
          ListIntersect( DescList, NewList );
        end;

        cds.DeleteIndex( IndexName );
        cds.IndexDefs.Update;

      end; { Index exists }

      Include( IdxOpts, ixCaseInsensitive );
      for j := NewList.Count - 1 downto 0 do
      begin

        FieldName := NewList[ j ];

        AscField := FieldList.IndexOf( FieldName );
        if AscField <> -1 then
        begin
          i := DescList.IndexOf( FieldName );
          if i <> -1 then
          begin
            DescList.Delete( i );
            if Shifty then
              FieldList.Delete( AscField );
          end
          else
            DescList.Add( FieldName );
        end { Field already exists in index }
        else
          FieldList.Add( FieldName );

      end; { Processing each new field }

      if DescList.Count > 0 then
        Include( IdxOpts, ixDescending )
      else
        Exclude( IdxOpts, ixDescending );

      if dgIndicator in TDBGrid(Column.Grid ).Options then
        ColOffset := 1
      else
        ColOffset := 0;

      DescFields := SemiText( DescList );
      AllFields := SemiText( FieldList );
      cds.AddIndex( IndexName, AllFields, IdxOpts, DescFields );
      cds.IndexDefs.Update;
      cds.IndexName := IndexName;
      // Work-around for nested dataset bug when assigning indexes in Delphi 5
      if Assigned(cds.DataSetField) then
        with (cds.DataSetField.Dataset as TClientDataset) do
          GotoBookmark(GetBookmark);
      if Assigned( ccDB ) then
        if ( Pos( FieldNames, DescFields ) > 0 ) then
          ccDB.Arrow[ Column.Index + ColOffset ] := atDown
        else if ( Pos( FieldNames, AllFields ) > 0 ) then
          ccDB.Arrow[ Column.Index + ColOffset ] := atUp
        else
          ccDB.Arrow[ Column.Index + ColOffset ] := atNone;
    finally
      DescList.Free;
      FieldList.Free;
      NewList.Free;
    end; { finally }
  end; { AddFieldName() }

begin

  if Assigned( Column ) and Assigned( Column.Field )
    and Assigned( Column.Field.DataSet )
    and ( Column.Field.Dataset is TClientDataset ) then
  begin
    GetKeyboardState( KeyState );
    ShiftState := KeyboardStateToShiftState(KeyState);
    Shifted := ssShift in ShiftState;
    { TODO -ojfk : Use an indexdef interface }
    cds := ( Column.Field.Dataset as TClientDataset );
    case Column.Field.FieldKind of
    fkData, fkInternalCalc : SetIndexField( Column.FieldName, Shifted,
      Column.Index );
    fkLookup : SetIndexField( Column.Field.KeyFields, Shifted, Column.Index );
    // fkCalculated, fkAggregate : // can't do anything with these
    end;
  end; { Can do something with it }
end; { SortGrid() }

{ TClientDataSetGrid }

constructor TClientDataSetGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetLength(FArrow,256);
  FTitleSort := True;
  FArrowShade := clBtnShadow;
  FArrowHighlight := clWhite;
end;

destructor TClientDataSetGrid.Destroy;
begin
  FArrow := nil;
  if FConfigFile <> '' then
    SaveSettings( FConfigFile );
  inherited Destroy;
end;

procedure TClientDataSetGrid.SetArrow(Index : Integer; Value : TArrowType);
begin
  FArrow[Index] := Value;
  Invalidate;
end;

function TClientDataSetGrid.GetArrow(Index : Integer) : TArrowType;
begin
  Result := FArrow[Index];
  Invalidate;
end;

procedure TClientDataSetGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState:
TGridDrawState);
var
  OldPenColor : TColor;
  Base, Tip,
  TipTop      : Integer;
  Col : TColumn;
begin
  inherited;
  if ( gdFixed in AState ) and (FArrow[ACol] <> atNone) then
    with Canvas do
    begin
      OldPenColor := Pen.Color;
      if FArrow[ACol] = atUp then
      begin
        Base := 10;
        Tip := 4;
      end
      else
      begin
        Base := 4;
        Tip := 10;
      end;
      Col := Columns[ ACol - 1 ];
      if (ARect.right - ARect.Left)
        < ( Canvas.TextWidth( Col.Title.Caption ) + 15 ) then
        ColWidths[ ACol ] := ( Canvas.TextWidth( Col.Title.Caption ) + 15 );
      with ARect do
      begin
        { TODO Draw arrow with fill color }
        TipTop := ( Bottom - Top ) div 2 - 7;
        MoveTo(Right-10,TipTop+Base);
        Pen.Color := FArrowShade;
        LineTo(Right-7,TipTop+Tip);
        Pen.Color := FArrowHighlight;
        LineTo(Right-4,TipTop+Base);
        LineTo(Right-10,TipTop+Base);
      end;
      Pen.Color := OldPenColor;
    end;
end;

procedure Register;
begin
  RegisterComponents('CodeCentral', [TClientDataSetGrid]);
end;

procedure TClientDataSetGrid.TitleClick(Column: TColumn);
begin
  // Have to use OnTitleClick instead of FOnTitleClick because
  // FOnTitleClick is private and not visible to this component
  if Assigned(OnTitleClick) then OnTitleClick(Column);
  if FTitleSort then SortGrid(Column);
end;

procedure TClientDataSetGrid.SaveSettings( FileName : string);
begin
  if FileName = '' then
    FileName := FConfigFile;
  if ( FileName <> '' ) and Assigned( Columns ) then
    Columns.SaveToFile( FileName )
  else
    DeleteFile( FileName );
end;

procedure TClientDataSetGrid.LoadSettings( FileName : string );
begin
  if FileName = '' then
    FileName := FConfigFile;
  if FileExists( FileName ) then
    Columns.LoadFromFile( FileName )
  else
    Columns.RestoreDefaults;
end;

procedure TClientDataSetGrid.SetConfigFile(const Value: string);
begin
  FConfigFile := Value;
  if FileExists( Value ) then
    LoadSettings( Value );
end;

procedure TClientDataSetGrid.GetActiveColumns(ColumnList: TStrings);
var
  i : integer;
begin
  ColumnList.Clear;
  for i := 0 to Columns.Count - 1 do
  begin
    ColumnList.Add( Columns[ i ].Field.DisplayName );
    ColumnList.Objects[ i ] := Columns[ i ];
  end; { for each column }
end;

procedure TClientDataSetGrid.GetAvailableColumns(ColumnList: TStrings;
  const VisibleOnly: boolean);
var
  i : integer;
begin
  ColumnList.Clear;
  if Assigned( DataSource ) and Assigned( DataSource.DataSet ) then
    with DataSource.DataSet do
      for i := 0 to Fields.Count - 1 do
        if ( not VisibleOnly ) or ( Fields[ i ].Visible ) then
        begin
          ColumnList.Add( Columns[ i ].Field.DisplayName );
          ColumnList.Objects[ i ] := Fields[ i ];
        end;
end;

function TClientDataSetGrid.FindFieldColumn(Value: TField): integer;
begin
  Result := fGridCols.FindFieldColumn( Self, Value );
end;

procedure TClientDataSetGrid.ConfigureColumns;
begin
  GridColumnToggler( Self );
end;

end.
