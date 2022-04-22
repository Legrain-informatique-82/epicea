{
Original Design By (©) Li Software '99
Updated 17th April 2000 (17/04/2000) by GJL Software
}

unit UnitReport;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    Db, StdCtrls, Buttons, ExtCtrls, grids, dbgrids, Quickrpt, Qrctrls, Qrprntr,
    Qrextra, printers;

procedure ShowReportByDataSet(DSet: TDataSet; cap: string);
procedure ShowReportByGrid(Grid: TDBGrid; cap: string);

implementation

function GetAl(F: TField): TAlignment;
begin
    Result := taLeftJustify;
    case F.DataType of
        ftUnknown, ftString: Result := taLeftJustify;
        ftAutoInc, ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD, ftBytes:
            Result := taRightJustify;
        ftBoolean, ftDate, ftTime, ftDateTime:
            Result := taCenter;
    end;
end;

procedure SetPages(b: TQRBand);
begin
    with TQRSysData(b.AddPrintable(TQRSysData)) do
        begin
            Data := qrsPageNumber;
            AutoSize := False;
            Left := 0;
            Top := 0;
            Width := b.Width;
            Text := 'Page: ';
            Alignment := taCenter;
        end;
end;

procedure SetTitle(b: TQRBand; Cap: string);
begin
    with TQRLabel(b.AddPrintable(TQRLabel)) do
        begin
            AutoSize := False;
            Left := 0;
            Width := b.Width;
            Caption := Cap;
            Size.Top := 1;
            Font.Style := [fsBold];
            Font.Color := clBlack;
            Font.Size := 14;
            Alignment := taCenter;
            AutoStretch := True;
        end;
end;

function SetReport(aForm: TForm; DSet: TDataSet; cap: string): TQuickRep;
var
    aReport: TQuickRep;
begin
    aReport := TQuickRep.Create(Application);
    with aReport do
        begin
            Parent := aForm;
            Font.Name := 'Tahoma';
            Font.Charset := ANSI_CHARSET;
            ReportTitle := cap;
            Font.Size := 8;
            DataSet := DSet;
        end;
    Result := aReport;
end;

procedure Get2Cmpnts(var DSet: TDataSet; var Grid: TDBGrid; IsDS: Boolean; Cmpnt: TComponent);
begin
    Grid := nil;
    if IsDS then
        DSet := TDataSet(Cmpnt)
    else
        begin
            Grid := TDBGrid(Cmpnt);
            DSet := Grid.DataSource.DataSet;
        end;
end;

procedure SetColTitle(cBands: TQRBand; x, i: Integer; Cmpnt: TComponent; IsDS: Boolean);
var
    DSet: TDataSet;
    Grid: TDBGrid;
begin
    Get2Cmpnts(DSet, Grid, IsDS, Cmpnt);
    with TQRLabel(cBands.AddPrintable(TQRLabel)) do
        begin
            Size.Left := x;
            Size.Top := 0;
            AutoSize := false;
            Size.Width := Dset.Fields[i].DisplayWidth;
            AutoStretch := True;
            Alignment := GetAl(Dset.Fields[i]);
            Caption := Dset.Fields[i].DisplayLabel;
        end;
end;

procedure SetDetail(aBands: TQRBand; x, i: Integer; Cmpnt: TComponent; IsDS: Boolean);
var
    DSet: TDataSet;
    Grid: TDBGrid;
begin
    Get2Cmpnts(DSet, Grid, IsDS, Cmpnt);
    with TQRDBText(aBands.AddPrintable(TQRDBText)) do
        begin
            DataSet := DSet;
            AutoSize := false;
            AutoStretch := True;
            if IsDS then
                begin
                    Size.Left := x;
                    Size.Top := 0;
                    DataField := DSet.Fields[i].FieldName;
                    Size.Width := Dset.Fields[i].DisplayWidth;
                    Alignment := GetAl(Dset.Fields[i]);
                end
            else
                begin
                    Top := 1;
                    Left := x;
                    Width := Grid.Columns[i].Width;
                    Alignment := Grid.Columns[i].Alignment;
                    DataField := Grid.Columns[i].FieldName;
//                    Frame.AnyFrame;
//                    Frame.DrawBottom:=true;
//                    Frame.DrawLeft:=true;
//                    Frame.DrawRight:=true;
//                    Frame.DrawTop:=true;
                    if (Grid.Columns[i].Font.Name = 'Wingdings') or
                        (Grid.Columns[i].Font.Name = 'Symbol') then
                        begin
                            Font.Name := Grid.Columns[i].Font.Name;
                            Font.Charset := SYMBOL_CHARSET;
                        end;
                end;
        end;
end;

function BadType(DataType: TFieldType): Boolean;
begin
    Result := (DataType in
        [ftVarBytes, ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle,
        ftDBaseOle, ftTypedBinary, ftCursor]);
end;

procedure SetOrient(x, i: Integer; bBands: TQRBand);
var
    DSet: TDataSet;
    aReport: TQuickRep;
begin
    aReport := TQuickRep(bBands.Parent);
    DSet := aReport.DataSet;
    if ((x + Dset.Fields[i].DisplayWidth) > bBands.Size.Width) and
        (aReport.Page.Orientation = poPortrait) then
        aReport.Page.Orientation := poLandscape;
end;

procedure SetDSLabels(aBands, bBands, cBands: TQRBand; DSet: TDataSet);
var
    x, i: Integer;
begin
    x := 1;
    for i := 0 to DSet.FieldCount - 1 do
        begin
            if (Dset.Fields[i].DisplayWidth = 0) or
                (not Dset.Fields[i].Visible) or BadType(Dset.Fields[i].DataType) then continue;
            SetOrient(x, i, bBands);
            if (x + Dset.Fields[i].DisplayWidth) > bBands.Size.Width then break;
            SetDetail(aBands, x, i, DSet, True);
            SetColTitle(cBands, x, i, DSet, True);
            x := x + Dset.Fields[i].DisplayWidth + 3;
        end;
end;

procedure SetGridLabels(aBands, bBands, cBands: TQRBand; Grid: TDBGrid);
var
    i, x: Integer;
begin
    x := 1;
    for i := 0 to Grid.Columns.Count - 1 do
        begin
            if (Grid.Columns[i].Width = 0) or BadType(Grid.Columns[i].Field.DataType) then continue;
            SetOrient(x, i, bBands);
            if (x + Grid.Columns[i].Width) > bBands.Width then break;
            SetDetail(aBands, x, i, Grid, False);
            with TQRLabel(cBands.AddPrintable(TQRLabel)) do
                begin
                    Left := x;
                    Top := 1;
                    AutoSize := false;
                    Width := Grid.Columns[i].Width;
                    Alignment := Grid.Columns[i].Title.Alignment;
//                    Alignment := taCenter;
                    Caption := Grid.Columns[i].Title.Caption;
//                    Caption := Grid.Datasource.Dataset.FieldByName(Grid.Columns[i].FieldName).DisplayLabel;
                    x := x + Grid.Columns[i].Width + 3;
                end;
        end;
end;

procedure ShowReport(Cmpnt: TComponent; cap: string; IsDS: Boolean);
var
    DSet: TDataSet;
    Grid: TDBGrid;
    aForm: TForm;
    aReport: TQuickRep;
    cBands, bBands, aBands, dBands: TQRBand;
begin
    Get2Cmpnts(DSet, Grid, IsDS, Cmpnt);

    aForm := TForm.Create(Application);
    aReport := SetReport(aForm, DSet, Cap);

    aBands := TQRBand.Create(aReport);
    aBands.Parent := aReport;
    aBands.BandType := rbDetail;
    aBands.Size.Height := 4;

    cBands := TQRBand.Create(aReport);
    cBands.Parent := aReport;
    cBands.BandType := rbColumnHeader;
    cBands.Frame.DrawBottom := true;
    cBands.Size.Height := 5;
    cBands.Font.Style := [fsBold];
    cBands.Font.Color := clBlack;

    bBands := TQRBand.Create(aReport);
    bBands.Parent := aReport;
    bBands.BandType := rbPageHeader;
    bBands.Frame.DrawBottom := true;
    bBands.Frame.DrawTop := true;
    bBands.Size.Height := 8;

    dBands := TQRBand.Create(aReport);
    dBands.Parent := aReport;
    dBands.BandType := rbPageFooter;
    if IsDS then
        SetDSLabels(aBands, bBands, cBands, DSet)
    else
        SetGridLabels(aBands, bBands, cBands, Grid);
    SetTitle(bBands, cap);
    SetPages(dBands);
    aReport.Preview;
end;

procedure ShowReportByDataSet(DSet: TDataSet; cap: string);
begin
    ShowReport(DSet, cap, True);
end;

procedure ShowReportByGrid(Grid: TDBGrid; cap: string);
begin
    ShowReport(Grid, cap, False);
end;

end.

