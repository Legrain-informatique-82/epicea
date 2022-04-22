{
TExDBGrid Version 2.4

Copyright (©) 1999 & 2000 by GJL Software
Updated 17th April 2000 (17/04/2000)

Email:         ExDBGrid@gjl-software.co.uk
Home Page:     http://www.gjl-software.co.uk

Description:   ExDBGrid is an Enhanced DBGrid Component that has plenty of new
               features:

               It has the following new Public Properties:
               Canvas, Col, Row, FixedCols, FixedRows, TopRow, SelectedRows,
               Datalink, ColCount, RowCount, ColWidths, GridLineWidth,
               InplaceEdit, TitleOffset, OnColumnResize, OptWidth (making the
               'Grid' automatically size itself so that no white space is left
               at the right), VisibleRowCount, VisibleColCount, GridHeight,
               GridWidth, LeftCol and ExportGrid.

               It has the following new Published Properties:
               ScrollBars, EditColor, DefaultRowHeight, RowSizingAllowed,
               DisplayImages, DisplayMemo, DisplayBoolean, GridAutoSize
               (making the columns automatically resize so that they are as wide
               as the row with the widest entry), GridAutoWidth (making the
               columns automatically resize so that no white space is left at
               the right), FullSizeMemo, Cells3D (when False, the Grid has a
               Flat look and feel - also the 3D Cells can be any color),
               CellHints (when True and Columns are not wide enough for the
               DisplayText, moving the mouse over a cell shows the text in a
               hint window), RowColor1, RowColor2, UseRowColors (using the
               properties RowColor1 and RowColor2), MultiLineTitles, TitleCheck
               (which places a marker in the top left of the grid and enables
               the grid popup menu when clicked), BackgroundPicture,
               UseBackgroundPicture, ExportDelimiter, AllowAutoAppend,
               DrawFocusRect, EnterAsTab, HighlightColor, ImageHighlightColor,
               HighlightFontColor, ReportCaption, HotTrack, HotTrackColor,
               LockedCols, LockedFont, LockedColor, FlatCheckBox,
               FlatCheckBoxType, MemoViewType and ShowMemoEllipsis.

               It has the following new Methods:
               MoveToRow and CellRect (which is extremely useful if you want to
               drop other controls on the grid i.e. pop a dropdown list over a
               cell when the user enters it).

               It has the following new Events:
               OnColumnResize, OnMouseDown, OnMouseUp, OnMouseMove, OnColEnter,
               OnRightClick and OnApplyCellAttribute (useful when you want to
               change the colour of an individual cell, based on the value in
               that cell or some other particular condition).

               In addition, it also has the following Features:
               Design Time and Run Time viewing of images, including JPEG
               support, Flat look and feel, Grid Printing, Grid Exporting,
               Enhanced Scrollbar Tracking, Selecting and UnSelecting all
               records, Column Customizing and Drag and Drop implementation.

               It also has popup viewers and Inplace Editors for Graphic/Memo
               Fields. To use these and the Checkbox, simply click on the Fields
               or use the Spacebar, F2 or Enter Keys.

*PLEASE NOTE*  Before making any bug reports please first verify you are
               using the latest version by checking my home page. And if
               you do report a bug, please, if applicable, include a code
               sample.

               Any suggested enhancements would also be appreciated.

Notes:         I cannot support modified versions of this code. So if you
               encounter a possible bug while using a modified version,
               always first revert back to the original code before making
               an attempt to contact me.

Thanks To:     Del Geist -           Mail: drgeist@ris.net
               Alberto Doria -       Mail: adoria@arsed.it
               Sergey Pjatakov -     Mail: psg@slav.ucom.dp.ua
               Martin Sedlak -       Mail: sedma@pobox.sk
               Jim Story -           Mail: jhstory@compuserve.com
               Pierre du Parte -     Mail: pierre@finalfiler.com

This notice may not be removed from or altered in any source distribution.

You are free to use the ExDBGrid Component Suite in compiled form for any
purpose. However, use in commercial or shareware applications requires
registration (see the Registration Documentation for information).

GJL Software products in source code or object form (including but not limited
to .PAS, .DCU, .OBJ), in whole or in part, modified or unmodified, may not be
redistributed for profit or as part of another commercial or shareware software
package without express written permission from me.

This component is provided 'as-is', without any express or implied warranty.
In no event shall the author be held liable for any damages arising from the
use of this component.
}

unit ExDBGrid;

interface

uses
    ShellAPI, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    Grids, DBGrids, DB, DBTables, BDE, StdCtrls, ClipBrd, Menus, dbctrls, UnitReport, Jpeg,variants,
    extctrls;

type
    TCellAttribute = procedure(Sender: TObject; Field: TField; Canvas: TCanvas; State: TGridDrawState) of object;

    TExportDelimiter = (Pipe, Comma, Quote);
    TFlatCheckBoxType = (Normal, Bold);
    TMemoViewType = (WordWrapOn, ScrollBarsOn);

    TExDBGrid = class(TDBGrid)
    private
        FNewDefaultRowHeight: Integer;
        FRowSizingAllowed: Boolean;
        FOnApplyCellAttribute: TCellAttribute;
        FOnMouseDown: TMouseEvent;
        FOnMouseUp: TMouseEvent;
        FOnMouseMove: TMouseMoveEvent;
        FOnColEnter: TNotifyEvent;
        FRowHeight: Integer;
        FDisplayImages: Boolean;
        FDisplayMemo: Boolean;
        FDisplayBool: Boolean;
        FGridAutoSize: Boolean;
        FGridAutoWidth: Boolean;
        FOnRightClick: TNotifyEvent;
        FFullSizeMemo: Boolean;
        FCells3D: Boolean;
        FCellHints: Boolean;
        FHintWnd: THintWindow;
        FRowColor1: TColor;
        FRowColor2: TColor;
        FUseRowColors: Boolean;
        FMultiLineTitles: Boolean;
        FExDBGridPopUpMenu: TPopUpMenu;
        FTitleCheck: Boolean;
        FBackgroundPicture: TBitmap;
        FUseBackgroundPicture: Boolean;
        FExportDelimiter: TExportDelimiter;
        FAllowAutoAppend: Boolean;
        FDrawFocusRect: Boolean;
        FEnterAsTab: Boolean;
        FHighlightColor: TColor;
        FImageHighlightColor: TColor;
        FHighlightFontColor: TColor;
        FReportCaption: string;
        FHotTrack: Boolean;
        FHotTrackColor: TColor;
        FOrigColor: TColor;
        FLockedCols: Integer;
        FLockedFont: TFont;
        FLockedColor: TColor;
        FFlatCheckBox: Boolean;
        FFlatCheckBoxType: TFlatCheckBoxType;
        FMemoViewType: TMemoViewType;
        FShowMemoEllipsis: Boolean;
        function AcquireFocus: Boolean;
        function GetTitleOffset: Byte;
        procedure UpdateTitlesHeight;
        procedure SetRowSizingAllowed(Value: Boolean);
        procedure SetDisplayImages(Value: Boolean);
        procedure SetDisplayMemo(Value: Boolean);
        procedure SetDisplayBool(Value: Boolean);
        procedure SetGridAutoSize(Value: Boolean);
        procedure SetGridAutoWidth(Value: Boolean);
        procedure SetFullSizeMemo(Value: Boolean);
        procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
        procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
        procedure SetCells3D(Value: Boolean);
        procedure SetCellHints(Value: Boolean);
        procedure SetRowColor1(Value: TColor);
        procedure SetRowColor2(Value: TColor);
        procedure SetUseRowColors(Value: Boolean);
        procedure SetMultiLineTitles(Value: Boolean);
        procedure MnuAutoSizeClick(Sender: TObject);
        procedure MnuAutoWidthClick(Sender: TObject);
        procedure MnuDisplayBooleanClick(Sender: TObject);
        procedure MnuDisplayImagesClick(Sender: TObject);
        procedure MnuDisplayMemoClick(Sender: TObject);
        procedure MnuShowMemoEllipsisClick(Sender: TObject);
        procedure MnuFullSizeMemoClick(Sender: TObject);
        procedure MnuAllowRowSizingClick(Sender: TObject);
        procedure MnuCellHintsClick(Sender: TObject);
        procedure MnuMultiLineTitlesClick(Sender: TObject);
        procedure MnuUseRowColors(Sender: TObject);
        procedure MnuPrintGrid(Sender: TObject);
        procedure MnuPrintDataSet(Sender: TObject);
        procedure MnuExportGrid(Sender: TObject);
        procedure MnuCustomize(Sender: TObject);
        procedure MnuSelectAll(Sender: TObject);
        procedure MnuUnSelectAll(Sender: TObject);
        procedure FExDBGridPopUpMenuPopup(Sender: TObject);
        procedure SetTitleCheck(Value: Boolean);
        procedure SetBackgroundPicture(Value: TBitmap);
        procedure PictureChanged(Sender: TObject);
        procedure SetUseBackgroundPicture(Value: Boolean);
        procedure DrawBackground;
        procedure SetAllowAutoAppend(Value: Boolean);
        procedure SetDrawFocusRect(Value: Boolean);
        procedure SetHighlightColor(Value: TColor);
        procedure SetImageHighlightColor(Value: TColor);
        procedure SetHighlightFontColor(Value: TColor);
        procedure SetHotTrackColor(Value: TColor);
        procedure SetLockedCols(Value: Integer);
        procedure SetLockedColor(Value: TColor);
        procedure SetLockedFont(Value: TFont);
        procedure LockedChanged;
        procedure SetFlatCheckBox(Value: Boolean);
        procedure SetFlatCheckBoxType(Value: TFlatCheckBoxType);
        procedure SetMemoViewType(Value: TMemoViewType);
        procedure SetShowMemoEllipsis(Value: Boolean);
    protected
        FOnColResize: TNotifyEvent;
        FEditColor: TColor;
        FInplaceEdit: TInplaceEdit;
        function CreateEditor: TInplaceEdit; override;
        function GetDefaultRowHeight: Integer;
        function GetOptWidth: Integer;
        function CalcHintRect(MaxWidth: Integer; const AHint: string; HintWnd: THintWindow): TRect;
        procedure DoHint(X, Y: Integer);
        procedure SetDefaultRowHeight(Value: Integer);
        procedure LayoutChanged; override;
        procedure RowHeightsChanged; override;
        procedure CellClick(Column: TColumn); override;
        procedure DblClick; override;
        procedure DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState); override;
        procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
        procedure ColWidthsChanged; override;
        procedure SetCheckBoxSize;
        procedure ApplyCellAttribute(Field: TField; Canvas: TCanvas; State: TGridDrawState);
        procedure CellAttribute(Field: TField; Canvas: TCanvas; State: TGridDrawState); dynamic;
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
        procedure ColEnter; override;
        procedure WMSize(var Message: TWMSize); message WM_SIZE;
        procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
        procedure KeyDown(var Key: Word; Shift: TShiftState); override;
        procedure KeyUp(var Key: Word; Shift: TShiftState); override;
        procedure KeyPress(var Key: Char); override;
        procedure TitleClick(Column: TColumn); override;
        procedure Paint; override;
        procedure Loaded; override;
        procedure CreateWnd; override;
        procedure SetColumnAttributes; override;
        procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    public
        DBMemo: TDBMemo;
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        property Canvas;
        property Col;
        property Row;
        property FixedCols;
        property FixedRows;
        property TopRow;
        property SelectedRows;
        property Datalink;
        property ColCount;
        property RowCount;
        property ColWidths;
        property GridLineWidth;
        property InplaceEdit: TInplaceEdit read FInplaceEdit;
        property TitleOffset: Byte read GetTitleOffset;
        property OnColumnResize: TNotifyEvent read FOnColResize write FOnColResize;
        property OptWidth: Integer read GetOptWidth;
        property VisibleRowCount;
        property VisibleColCount;
        property GridHeight;
        property GridWidth;
        property LeftCol;
        function CellRect(ACol, ARow: Longint): TRect;
        procedure MoveToRow(NewRow: Integer);
        procedure WMHScroll(var Msg: TWMHScroll); message wm_HScroll;
        procedure WMVScroll(var Msg: TWMVScroll); message wm_VScroll;
        procedure CMMouseEnter(var Msg: TMessage); message cm_MouseEnter;
        procedure CMMouseLeave(var Msg: TMessage); message cm_MouseLeave;
        procedure WMMouseMove(var Msg: TWMMouseMove); message wm_MouseMove;
        procedure OnKeyDBMemo(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure OnDBExit(Sender: TObject);
        procedure ExportGrid(ExpFileName: string); virtual;
        procedure ExportToFile(ExpFileName: string; Delimiter: Char);
        procedure GridPreview;
        procedure DataSetPreview;
    published
        property ScrollBars;
        property DefaultDrawing default False;
        property EditColor: TColor read FEditColor write FEditColor;
        property DefaultRowHeight: Integer read GetDefaultRowHeight write SetDefaultRowHeight;
        property RowSizingAllowed: Boolean read FRowSizingAllowed write SetRowSizingAllowed default False;
        property OnApplyCellAttribute: TCellAttribute read FOnApplyCellAttribute write FOnApplyCellAttribute;
        property OnMouseDown read FOnMouseDown write FOnMouseDown;
        property OnMouseUp read FOnMouseUp write FOnMouseUp;
        property OnMouseMove read FOnMouseMove write FOnMouseMove;
        property OnColEnter: TNotifyEvent read FOnColEnter write FOnColEnter;
        property DisplayImages: Boolean read FDisplayImages write SetDisplayImages default True;
        property DisplayMemo: Boolean read FDisplayMemo write SetDisplayMemo default True;
        property DisplayBoolean: Boolean read FDisplayBool write SetDisplayBool default True;
        property GridAutoSize: Boolean read FGridAutoSize write SetGridAutoSize default False;
        property GridAutoWidth: Boolean read FGridAutoWidth write SetGridAutoWidth default False;
        property FullSizeMemo: Boolean read FFullSizeMemo write SetFullSizeMemo default False;
        property OnRightClick: TNotifyEvent read FOnRightClick write FOnRightClick;
        property Cells3D: Boolean read FCells3D write SetCells3D default False;
        property CellHints: Boolean read FCellHints write SetCellHints default False;
        property RowColor1: TColor read FRowColor1 write SetRowColor1;
        property RowColor2: TColor read FRowColor2 write SetRowColor2;
        property UseRowColors: Boolean read FUseRowColors write SetUseRowColors default False;
        property MultiLineTitles: Boolean read FMultiLineTitles write SetMultiLineTitles default False;
        property TitleCheck: Boolean read FTitleCheck write SetTitleCheck default False;
        property BackgroundPicture: TBitmap read FBackgroundPicture write SetBackgroundPicture;
        property UseBackgroundPicture: Boolean read FUseBackgroundPicture write SetUseBackgroundPicture default False;
        property ExportDelimiter: TExportDelimiter read FExportDelimiter write FExportDelimiter default Pipe;
        property AllowAutoAppend: Boolean read FAllowAutoAppend write SetAllowAutoAppend default True;
        property DrawFocusRect: Boolean read FDrawFocusRect write SetDrawFocusRect default False;
        property EnterAsTab: Boolean read FEnterAsTab write FEnterAsTab default False;
        property HighlightColor: TColor read FHighlightColor write SetHighlightColor;
        property ImageHighlightColor: TColor read FImageHighlightColor write SetImageHighlightColor;
        property HighlightFontColor: TColor read FHighlightFontColor write SetHighlightFontColor;
        property ReportCaption: string read FReportCaption write FReportCaption;
        property HotTrack: Boolean read FHotTrack write FHotTrack default False;
        property HotTrackColor: TColor read FHotTrackColor write SetHotTrackColor;
        property LockedCols: Integer read FLockedCols write SetLockedCols;
        property LockedFont: TFont read FLockedFont write SetLockedFont;
        property LockedColor: TColor read FLockedColor write SetLockedColor;
        property FlatCheckBox: Boolean read FFlatCheckBox write SetFlatCheckBox default True;
        property FlatCheckBoxType: TFlatCheckBoxType read FFlatCheckBoxType write SetFlatCheckBoxType default Normal;
        property MemoViewType: TMemoViewType read FMemoViewType write SetMemoViewType default WordWrapOn;
        property ShowMemoEllipsis: Boolean read FShowMemoEllipsis write SetShowMemoEllipsis default False;
    end;

    TInplaceEditCracker = class(TInplaceEdit)
    public
        property Color;
    end;

    TExDBGridMod = class(TCustomGrid)
    public
        property Options;
        property RowHeights;
    end;

procedure Register;

implementation

uses ExDBGridCtls, ExColSelect;

var
    GCheckWidth, GCheckHeight: Integer;
    gk: Word;
    BkBmp: TBitmap;

function Max(X, Y: Integer): Integer;
begin
    Result := Y;
    if X > Y then Result := X;
end;

constructor TExDBGrid.Create(AOwner: TComponent);
var
    i: Integer;
    NewItem: TMenuItem;
begin
    inherited Create(AOwner);

    DataSource := Datalink.DataSource;
    DefaultDrawing := False;
    ControlStyle := ControlStyle + [csAcceptsControls, csDisplayDragImage, csFramed, csOpaque];
    BorderStyle := bsNone;
    SetCheckBoxSize;
    EditColor := clWindow;
    FRowheight := 17;
    FRowSizingAllowed := False;
    FDisplayImages := True;
    FDisplayMemo := True;
    FDisplayBool := True;
    GridAutoSize := False;
    GridAutoWidth := False;
    FullSizeMemo := False;
    Cells3D := False;
    CellHints := False;
    RowColor1 := cl3DLight;
    RowColor2 := clTeal;
    UseRowColors := False;
    MultiLineTitles := False;
    TitleCheck := False;
    FBackGroundPicture := TBitmap.Create;
    FBackGroundPicture.OnChange := PictureChanged;
    UseBackgroundPicture := False;
    BkBmp := nil;
    FExportDelimiter := Pipe;
    FAllowAutoAppend := True;
    FDrawFocusRect := False;
    FHighlightColor := clNavy;
    FImageHighlightColor := clWindow;
    FHighlightFontColor := clWhite;
    FHotTrackColor := clNavy;
    FLockedCols := 0;
    FLockedFont := TFont.Create;
    FLockedColor := clGray;
    FEnterAsTab := False;
    FFlatCheckBox := True;
    FFlatCheckBoxType := Normal;
    FMemoViewType := WordWrapOn;
    FShowMemoEllipsis := False;

    FExDBGridPopUpMenu := TPopUpMenu.Create(Self);
    FExDBGridPopUpMenu.OnPopup := FExDBGridPopUpMenuPopup;
    if not (csDesigning in ComponentState) then
        begin
            for i := 0 to 23 do
                begin
                    NewItem := TMenuItem.Create(TExDBGrid(Self));
                    case i of
                        0:
                            begin
                                NewItem.OnClick := MnuAutoSizeClick;
                                NewItem.Caption := 'Auto Size';
                                NewItem.Checked := False;
                            end;
                        1:
                            begin
                                NewItem.OnClick := MnuAutoWidthClick;
                                NewItem.Caption := 'Auto Width';
                                NewItem.Checked := False;
                            end;
                        2:
                            begin
                                NewItem.Caption := '-';
                                NewItem.Checked := False;
                            end;
                        3:
                            begin
                                NewItem.OnClick := MnuDisplayBooleanClick;
                                NewItem.Caption := 'Display Boolean';
                                NewItem.Checked := False;
                            end;
                        4:
                            begin
                                NewItem.OnClick := MnuDisplayImagesClick;
                                NewItem.Caption := 'Display Images';
                                NewItem.Checked := False;
                            end;
                        5:
                            begin
                                NewItem.OnClick := MnuDisplayMemoClick;
                                NewItem.Caption := 'Display Memo';
                                NewItem.Checked := False;
                            end;
                        6:
                            begin
                                NewItem.Caption := '-';
                                NewItem.Checked := False;
                            end;
                        7:
                            begin
                                NewItem.OnClick := MnuShowMemoEllipsisClick;
                                NewItem.Caption := 'Show Memo Ellipsis';
                                NewItem.Checked := False;
                            end;
                        8:
                            begin
                                NewItem.OnClick := MnuFullSizeMemoClick;
                                NewItem.Caption := 'Full Size Memo';
                                NewItem.Checked := False;
                            end;
                        9:
                            begin
                                NewItem.Caption := '-';
                                NewItem.Checked := False;
                            end;
                        10:
                            begin
                                NewItem.OnClick := MnuAllowRowSizingClick;
                                NewItem.Caption := 'Allow Row Sizing';
                                NewItem.Checked := False;
                            end;
                        11:
                            begin
                                NewItem.OnClick := MnuCellHintsClick;
                                NewItem.Caption := 'Cell Hints';
                                NewItem.Checked := False;
                            end;
                        12:
                            begin
                                NewItem.OnClick := MnuMultiLineTitlesClick;
                                NewItem.Caption := 'Multi Line Titles';
                                NewItem.Checked := False;
                            end;
                        13:
                            begin
                                NewItem.OnClick := MnuUseRowColors;
                                NewItem.Caption := 'Use Row Colors';
                                NewItem.Checked := False;
                            end;
                        14:
                            begin
                                NewItem.Caption := '-';
                                NewItem.Checked := False;
                            end;
                        15:
                            begin
                                NewItem.OnClick := MnuPrintGrid;
                                NewItem.Caption := 'Print Grid';
                                NewItem.Checked := False;
                            end;
                        16:
                            begin
                                NewItem.OnClick := MnuPrintDataSet;
                                NewItem.Caption := 'Print DataSet';
                                NewItem.Checked := False;
                            end;
                        17:
                            begin
                                NewItem.Caption := '-';
                                NewItem.Checked := False;
                            end;
                        18:
                            begin
                                NewItem.OnClick := MnuExportGrid;
                                NewItem.Caption := 'Export Grid';
                                NewItem.Checked := False;
                            end;
                        19:
                            begin
                                NewItem.Caption := '-';
                                NewItem.Checked := False;
                            end;
                        20:
                            begin
                                NewItem.OnClick := MnuSelectAll;
                                NewItem.Caption := 'Select All';
                                NewItem.Checked := False;
                            end;
                        21:
                            begin
                                NewItem.OnClick := MnuUnSelectAll;
                                NewItem.Caption := 'UnSelect All';
                                NewItem.Checked := False;
                            end;
                        22:
                            begin
                                NewItem.Caption := '-';
                                NewItem.Checked := False;
                            end;
                        23:
                            begin
                                NewItem.OnClick := MnuCustomize;
                                NewItem.Caption := 'Customize';
                                NewItem.Checked := False;
                            end;
                    end;
                    FExDBGridPopUpMenu.Items.Add(NewItem);
                end;
        end;
end;

{ BEGIN PRIVATE }

function TExDBGrid.AcquireFocus: Boolean;
begin
    Result := True;
    if FAcquireFocus and CanFocus and not (csDesigning in ComponentState) then
        begin
            SetFocus;
            Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
        end;
end;

function TExDBGrid.GetTitleOffset: Byte;
begin
    Result := 0;
    if dgTitles in Options then
        Inc(Result);
end;

procedure TExDBGrid.UpdateTitlesHeight;
var
    i, MaxHeight: Integer;
    RRect: TRect;
begin
    if FMultiLineTitles then
        begin
            if (dgTitles in Options) then
                begin
                    MaxHeight := 0;
                    for i := 0 to Columns.Count - 1 do
                        begin
                            RRect := CellRect(0, 0);
                            RRect.Right := Columns[i].Width - 1;
                            RRect.Left := 0;

                            Canvas.Font := Columns[i].Title.Font;
                            MaxHeight := Max(MaxHeight, DrawText(Canvas.Handle,
                                PChar(Columns[i].Title.Caption),
                                Length(Columns[i].Title.Caption),
                                RRect,
                                DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK));
                        end;

                    if (MaxHeight <> 0) then
                        begin
                            if (dgRowLines in Options) then
                                Inc(MaxHeight, 3)
                            else
                                Inc(MaxHeight, 2);

                            RowHeights[0] := MaxHeight;
                            if RowHeights[0] < 17 then
                                RowHeights[0] := 17;
                        end;
                end;
        end
    else
        begin
            if RowHeights[0] <> 17 then
                RowHeights[0] := 17;
        end;
end;

procedure TExDBGrid.SetRowSizingAllowed(Value: Boolean);
begin
    if Value <> FRowSizingAllowed then
        begin
            FRowSizingAllowed := Value;
            if FRowSizingAllowed then
                TExDBGridMod(Self).Options := TExDBGridMod(Self).Options + [goRowSizing, goColSizing, goThumbTracking, goTabs, goColMoving, goRowMoving, goDrawFocusSelected]
            else
                TExDBGridMod(Self).Options := TExDBGridMod(Self).Options + [goColSizing, goThumbTracking, goTabs, goColMoving, goRowMoving, goDrawFocusSelected] - [goRowSizing];
        end
end;

procedure TExDBGrid.SetDisplayImages(value: Boolean);
begin
    if FDisplayImages <> value then
        begin
            FDisplayImages := value;
            ColEnter;
            invalidate;
        end;
end;

procedure TExDBGrid.SetDisplayMemo(value: Boolean);
begin
    if FDisplayMemo <> value then
        begin
            FDisplayMemo := value;

            if FDisplayMemo = False then
                begin
                    if FFullSizeMemo = True then
                        begin
                            SetFullSizeMemo(False);
                            FFullSizeMemo := True;
                        end;
                end
            else
                begin
                    if FFullSizeMemo = True then
                        begin
                            SetFullSizeMemo(True);
                        end;
                end;

            ColEnter;
            invalidate;
        end;
end;

procedure TExDBGrid.SetDisplayBool(value: Boolean);
begin
    if FDisplayBool <> value then
        begin
            FDisplayBool := value;
            ColEnter;
            invalidate;
        end;
end;

procedure TExDBGrid.SetGridAutoSize(value: Boolean);
var
    RowNo: Integer;
    ColNo: Integer;
    WidthNew: Integer;
    WidthMax: Integer;
    TmpDS: TDataSource;
begin
    FGridAutoSize := value;

    if FGridAutoSize = True then
        begin
            FGridAutoWidth := False;
        end;

    if not (csDesigning in ComponentState) then
        begin
            if Columns.State <> csCustomized then
                begin
                    if FGridAutoSize = True then
                        begin
                            if (Datalink <> nil) and (Datalink.Active) then
                                begin
                                    Datalink.DataSet.DisableControls;

                                    Columns.RestoreDefaults;

                                    for ColNo := 0 to (ColCount - 2) do
                                        begin
                                            WidthMax := 0;
                                            WidthNew := 0;
                                            Datalink.DataSet.First;

                                            for RowNo := 0 to (RowCount - 1) do
                                                begin
                                                    if Fields[ColNo].Value <> Null then
                                                        begin
                                                            if FFullSizeMemo = False then
                                                                begin
                                                                    WidthNew := Canvas.TextWidth(Fields[ColNo].DisplayText);
                                                                end
                                                            else
                                                                begin
                                                                    if Fields[ColNo] is TMemoField then
                                                                        begin
                                                                            WidthNew := Canvas.TextWidth(Fields[ColNo].Value);
                                                                        end
                                                                    else
                                                                        begin
                                                                            WidthNew := Canvas.TextWidth(Fields[ColNo].DisplayText);
                                                                        end;
                                                                end;
                                                        end;

                                                    if WidthNew > WidthMax then
                                                        WidthMax := WidthNew;

                                                    Datalink.DataSet.Next;
                                                end;

                                            try
                                                Columns[ColNo].Width := (WidthMax + (GridLineWidth + 5))
                                            except
                                            end;
                                        end;

                                    Datalink.DataSet.First;

                                    Datalink.DataSet.EnableControls;
                                end;
                            invalidate;
                        end
                    else
                        begin
                            if (Datalink <> nil) and (Datalink.Active) then
                                begin
                                    Datalink.DataSet.DisableControls;

                                    TmpDS := TExDBGrid(Self).DataSource;
                                    TExDBGrid(Self).DataSource := nil;
                                    TExDBGrid(Self).DataSource := TmpDS;
                                    Columns.RestoreDefaults;

                                    Datalink.DataSet.EnableControls;
                                end;
                        end;
                end;
        end;
end;

procedure TExDBGrid.SetGridAutoWidth(Value: Boolean);
var
    Available, Remaining, i, w: Integer;
    Total: Integer;
    FColumnSize: array[0..255] of Integer;
begin
    FGridAutoWidth := value;

    if FGridAutoWidth = True then
        begin
            FGridAutoSize := False;
        end;

    if not (csDesigning in ComponentState) then
        begin
            if Columns.State <> csCustomized then
                begin
                    if FGridAutoWidth = True then
                        begin
                            if (Datalink <> nil) and (Datalink.Active) then
                                begin
                                    Datalink.DataSet.DisableControls;

                                    Columns.RestoreDefaults;

                                    Total := TExDBGrid(Self).ClientWidth;
                                    Remaining := TExDBGrid(Self).Colcount - TExDBGrid(Self).Fixedcols;

                                    w := Total div Remaining;

                                    for i := 0 to Remaining - 1 do
                                        begin
                                            FColumnSize[i] := w;
                                            Dec(Total, w);
                                        end;
                                    FColumnSize[Remaining] := Total;

                                    with TExDBGrid(Self) do
                                        begin
                                            Available := ClientWidth;
                                            for i := 0 to FixedCols - 1 do
                                                Dec(Available, ColWidths[i] + GridlineWidth);

                                            for i := FixedCols to ColCount - 2 do
                                                begin
                                                    ColWidths[i] := FColumnSize[i - 1] - GridlineWidth;
                                                    Dec(Available, FColumnSize[i - 1]);
                                                end;
                                            ColWidths[ColCount - 1] := Available;
                                        end;

                                    invalidate;

                                    Datalink.DataSet.EnableControls;
                                end;
                            invalidate;
                        end
                    else
                        begin
                            if (Datalink <> nil) and (Datalink.Active) then
                                begin
                                    Datalink.DataSet.DisableControls;

                                    if FGridAutoSize = False then
                                        begin
                                            SetGridAutoSize(True);
                                            SetGridAutoSize(False);
                                        end
                                    else
                                        begin
                                            SetGridAutoSize(FGridAutoSize);
                                        end;

                                    Datalink.DataSet.EnableControls;
                                end;
                        end;
                end;
        end;
end;

procedure TExDBGrid.SetFullSizeMemo(value: Boolean);
begin
    FFullSizeMemo := value;

    if not (csDesigning in ComponentState) then
        begin
            if Columns.State <> csCustomized then
                begin
                    if (Datalink <> nil) and (Datalink.Active) then
                        begin
                            Datalink.DataSet.DisableControls;

                            if FFullSizeMemo = True then
                                FDisplayMemo := True;

                            if FGridAutoSize = False then
                                begin
                                    SetGridAutoSize(True);
                                    SetGridAutoSize(False);
                                end
                            else
                                begin
                                    SetGridAutoSize(FGridAutoSize);
                                end;

                            Datalink.DataSet.EnableControls;
                        end;
                end;
        end;
end;

procedure TExDBGrid.WMRButtonDown(var Message: TWMRButtonDown);
begin
    try
        SetFocus;
        inherited;

        if Assigned(FOnRightClick) then
            FOnRightClick(Self);
    except
    end;
end;

procedure TExDBGrid.WMLButtonDown(var Message: TWMLButtonDown);
begin
    try
        SetFocus;
        inherited;
    except
    end;
end;

procedure TExDBGrid.SetCells3D(Value: Boolean);
begin
    if FCells3D <> Value then
        begin
            FCells3D := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetCellHints(Value: Boolean);
begin
    if FCellHints <> Value then
        begin
            FCellHints := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetRowColor1(Value: TColor);
begin
    if FRowColor1 <> Value then
        begin
            FRowColor1 := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetRowColor2(Value: TColor);
begin
    if FRowColor2 <> Value then
        begin
            FRowColor2 := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetUseRowColors(Value: Boolean);
begin
    if FUseRowColors <> Value then
        begin
            FUseRowColors := Value;

            if FUseRowColors = True then
                begin
                    FUseBackgroundPicture := False;
                end;

            invalidate;
        end;
end;

procedure TExDBGrid.SetMultiLineTitles(Value: Boolean);
begin
    if FMultiLineTitles <> Value then
        begin
            FMultiLineTitles := Value;
            invalidate;
        end;

    UpdateTitlesHeight;
end;

procedure TExDBGrid.MnuAutoSizeClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[0].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).GridAutoSize := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[0].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).GridAutoSize := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[0].Checked := False;
        end;
end;

procedure TExDBGrid.MnuAutoWidthClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[1].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).GridAutoWidth := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[1].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).GridAutoWidth := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[1].Checked := False;
        end;
end;

procedure TExDBGrid.MnuDisplayBooleanClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[3].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).DisplayBoolean := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[3].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).DisplayBoolean := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[3].Checked := False;
        end;
end;

procedure TExDBGrid.MnuDisplayImagesClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[4].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).DisplayImages := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[4].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).DisplayImages := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[4].Checked := False;
        end;
end;

procedure TExDBGrid.MnuDisplayMemoClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[5].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).DisplayMemo := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[5].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).DisplayMemo := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[5].Checked := False;
        end;
end;

procedure TExDBGrid.MnuShowMemoEllipsisClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[7].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).ShowMemoEllipsis := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[7].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).ShowMemoEllipsis := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[7].Checked := False;
        end;
end;

procedure TExDBGrid.MnuFullSizeMemoClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[8].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).FullSizeMemo := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[8].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).FullSizeMemo := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[8].Checked := False;
        end;
end;

procedure TExDBGrid.MnuAllowRowSizingClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[10].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).RowSizingAllowed := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[10].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).RowSizingAllowed := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[10].Checked := False;
        end;
end;

procedure TExDBGrid.MnuCellHintsClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[11].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).CellHints := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[11].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).CellHints := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[11].Checked := False;
        end;
end;

procedure TExDBGrid.MnuMultiLineTitlesClick(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[12].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).MultiLineTitles := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[12].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).MultiLineTitles := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[12].Checked := False;
        end;
end;

procedure TExDBGrid.MnuUseRowColors(Sender: TObject);
begin
    if FExDBGridPopUpMenu.Items[13].Checked = False then
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).UseRowColors := True;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[13].Checked := True;
        end
    else
        begin
            Datalink.DataSet.DisableControls;
            TExDBGrid(Self).UseRowColors := False;
            Datalink.DataSet.EnableControls;
            FExDBGridPopUpMenu.Items[13].Checked := False;
        end;
end;

procedure TExDBGrid.MnuPrintGrid(Sender: TObject);
begin
    TExDBGrid(Self).GridPreview;
    TExDBGrid(Self).DataSource.DataSet.First;
end;

procedure TExDBGrid.MnuPrintDataSet(Sender: TObject);
begin
    TExDBGrid(Self).DataSetPreview;
    TExDBGrid(Self).DataSource.DataSet.First;
end;

procedure TExDBGrid.MnuExportGrid(Sender: TObject);
begin
    TExDBGrid(Self).ExportGrid('');
    TExDBGrid(Self).DataSource.DataSet.First;
end;

procedure TExDBGrid.MnuCustomize(Sender: TObject);
begin
    Application.CreateForm(TExColSelectFrm, ExColSelectFrm);
    ExColSelectFrm.ExDBGrid := TExDBGrid(Self);
    ExColSelectFrm.DataSource := DataSource;
    ExColSelectFrm.ShowModal;
    ExColSelectFrm.Release;
end;

procedure TExDBGrid.MnuSelectAll(Sender: TObject);
begin
    if not (dgMultiSelect in Options) then
        Options := Options + [dgMultiSelect];

    with TExDBGrid(Self).DataSource.DataSet do
        begin
            DisableControls;
            First;
            while not EOF do
                begin
                    SelectedRows.CurrentRowSelected := True;
                    Next;
                end;
            EnableControls;
        end;

    if FRowSizingAllowed = True then
        TExDBGridMod(Self).Options := TExDBGridMod(Self).Options + [goRowSizing];
end;

procedure TExDBGrid.MnuUnSelectAll(Sender: TObject);
begin
    if dgMultiSelect in Options then
        Options := Options - [dgMultiSelect];

    with TExDBGrid(Self).DataSource.DataSet do
        begin
            First;
        end;

    if FRowSizingAllowed = True then
        TExDBGridMod(Self).Options := TExDBGridMod(Self).Options + [goRowSizing];
end;

procedure TExDBGrid.FExDBGridPopUpMenuPopup(Sender: TObject);
begin
    FExDBGridPopUpMenu.Items[0].Checked := TExDBGrid(Self).GridAutoSize;
    FExDBGridPopUpMenu.Items[1].Checked := TExDBGrid(Self).GridAutoWidth;
    FExDBGridPopUpMenu.Items[3].Checked := TExDBGrid(Self).DisplayBoolean;
    FExDBGridPopUpMenu.Items[4].Checked := TExDBGrid(Self).DisplayImages;
    FExDBGridPopUpMenu.Items[5].Checked := TExDBGrid(Self).DisplayMemo;
    FExDBGridPopUpMenu.Items[7].Checked := TExDBGrid(Self).ShowMemoEllipsis;
    FExDBGridPopUpMenu.Items[8].Checked := TExDBGrid(Self).FullSizeMemo;
    FExDBGridPopUpMenu.Items[10].Checked := TExDBGrid(Self).RowSizingAllowed;
    FExDBGridPopUpMenu.Items[11].Checked := TExDBGrid(Self).CellHints;
    FExDBGridPopUpMenu.Items[12].Checked := TExDBGrid(Self).MultiLineTitles;
    FExDBGridPopUpMenu.Items[13].Checked := TExDBGrid(Self).UseRowColors;
end;

procedure TExDBGrid.SetTitleCheck(Value: Boolean);
begin
    if FTitleCheck <> Value then
        begin
            FTitleCheck := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetBackgroundPicture(Value: TBitmap);
begin
    FBackGroundPicture.Assign(Value);

    if (csDesigning in ComponentState) then
        begin
            Refresh;
        end;
end;

procedure TExDBGrid.PictureChanged(Sender: TObject);
begin
    if Assigned(BKBmp) then
        begin
            BkBmp.Free;
            BkBmp := nil;
        end;
end;

procedure TExDBGrid.SetUseBackgroundPicture(Value: Boolean);
begin
    if FUseBackgroundPicture <> Value then
        begin
            FUseBackgroundPicture := Value;

            if FUseBackgroundPicture = True then
                begin
                    FUseRowColors := False;
                end;

            invalidate;
        end;

    if (csDesigning in ComponentState) then
        begin
            Refresh;
        end;
end;

procedure TExDBGrid.DrawBackground;
begin
    if FUseBackgroundPicture = True then
        begin
            if BkBmp = nil then
                begin
                    BkBmp := TBitmap.Create;
                    BkBmp.Assign(FBackgroundPicture);
                end;
        end
    else
        begin
            if Assigned(BKBmp) then
                begin
                    BkBmp.Free;
                    BkBmp := nil;
                end;
        end;
end;

procedure TExDBGrid.SetAllowAutoAppend(Value: Boolean);
begin
    if FAllowAutoAppend <> Value then
        begin
            FAllowAutoAppend := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetDrawFocusRect(Value: Boolean);
begin
    if FDrawFocusRect <> Value then
        begin
            FDrawFocusRect := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetHighlightColor(Value: TColor);
begin
    if FHighlightColor <> Value then
        begin
            FHighlightColor := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetImageHighlightColor(Value: TColor);
begin
    if FImageHighlightColor <> Value then
        begin
            FImageHighlightColor := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetHighlightFontColor(Value: TColor);
begin
    if FHighlightFontColor <> Value then
        begin
            FHighlightFontColor := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetHotTrackColor(Value: TColor);
begin
    if FHotTrackColor <> Value then
        begin
            FHotTrackColor := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetLockedCols(Value: Integer);
begin
    if FLockedCols <> Value then
        begin
            FLockedCols := Value;
            LockedChanged;
            invalidate;
        end;
end;

procedure TExDBGrid.SetLockedColor(Value: TColor);
begin
    if FLockedColor <> Value then
        begin
            FLockedColor := Value;
            LockedChanged;
            invalidate;
        end;
end;

procedure TExDBGrid.SetLockedFont(Value: TFont);
begin
    if FLockedFont <> Value then
        begin
            FLockedFont.Assign(Value);
            LockedChanged;
            invalidate;
        end;
end;

procedure TExDBGrid.LockedChanged;
var
    i: integer;
begin
    if (Datalink <> nil) and (Datalink.Active) then
        with TExDBGrid(Self) do
            begin
                if FLockedCols = 0 then
                    begin
                        FixedCols := FLockedCols + IndicatorOffset;
                        for i := 0 to FLockedCols - 1 do
                            with Columns[i] do
                                begin
                                    Font := TExDBGrid(Self).Font;
                                    Color := TExDBGrid(Self).Color;
                                end;
                    end
                else
                    if FLockedCols < (ColCount - 1) - IndicatorOffset then
                        begin
                            FixedCols := FLockedCols + IndicatorOffset;
                            for i := 0 to FLockedCols - 1 do
                                with Columns[i] do
                                    begin
                                        Font := LockedFont;
                                        Color := LockedColor;
                                    end;
                        end;
            end;
end;

procedure TExDBGrid.SetFlatCheckBox(Value: Boolean);
begin
    if FFlatCheckBox <> Value then
        begin
            FFlatCheckBox := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetFlatCheckBoxType(Value: TFlatCheckBoxType);
begin
    if FFlatCheckBoxType <> Value then
        begin
            FFlatCheckBoxType := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetMemoViewType(Value: TMemoViewType);
begin
    if FMemoViewType <> Value then
        begin
            FMemoViewType := Value;
            invalidate;
        end;
end;

procedure TExDBGrid.SetShowMemoEllipsis(Value: Boolean);
begin
    if FShowMemoEllipsis <> Value then
        begin
            FShowMemoEllipsis := Value;
            invalidate;
        end;
end;

{ END PRIVATE }

{ BEGIN PROTECTED }

function TExDBGrid.CreateEditor: TInplaceEdit;
begin
    Result := inherited CreateEditor;

    TInplaceEditCracker(Result).Color := FEditColor;
    FInplaceEdit := Result;
end;

function TExDBGrid.GetDefaultRowHeight: Integer;
begin
    Result := inherited DefaultRowHeight;
end;

function TExDBGrid.GetOptWidth: Integer;
var
    Loop: Integer;
begin
    Result := GetSystemMetrics(sm_CXVScroll);

    if BorderStyle = bsSingle then
        Inc(Result, 2 * GetSystemMetrics(sm_CXBorder));

    for Loop := 0 to Pred(ColCount) do
        Inc(Result, Succ(ColWidths[Loop]));

    if Parent is TForm then
        begin
            if Result > TForm(Parent).ClientWidth then
                Result := TForm(Parent).ClientWidth;
        end
    else
        if Result > Parent.Width then
            Result := Parent.Width;
end;

function TExDBGrid.CalcHintRect(MaxWidth: Integer;
    const AHint: string; HintWnd: THintWindow): TRect;
begin
    Result := HintWnd.CalcHintRect(Screen.Width, AHint, nil)
end;

procedure TExDBGrid.DoHint(X, Y: Integer);
const
    TextOffset = 2;
var
    Col, Row, LogCol, LogRow: Longint;
    R, OldR: TRect;
    Pt: TPoint;
    GPt: TGridCoord;
    OldActive: Integer;
    Text: string;
begin
    GPt := MouseCoord(X, Y);
    Col := GPt.X;
    Row := GPt.Y;
    LogCol := Col;
    LogRow := Row;

    if dgTitles in Options then
        Dec(LogRow);

    if dgIndicator in Options then
        Dec(LogCol);

    Text := '';

    if (DataLink.Active) and (LogCol >= 0) and (LogRow >= 0) then
        begin
            OldActive := DataLink.ActiveRecord;
            try
                Datalink.ActiveRecord := LogRow;

                if not (Columns[LogCol].Field is TMemoField) then
                    Text := Columns[LogCol].Field.DisplayText
                else
                    begin
                        Text := Columns[LogCol].Field.AsString;
                    end;
            finally
                Datalink.ActiveRecord := OldActive
            end
        end;

    Canvas.Font := Font;

    if (Text <> '') and not EditorMode and
        (Canvas.TextWidth(Text) + TextOffset > ColWidths[Col]) and
        not (csDesigning in ComponentState) then
        begin
            if not Assigned(FHintWnd) then
                begin
                    FHintWnd := HintWindowClass.Create(Self);
                    FHintWnd.Color := Application.HintColor;
                end;
            Hint := Text;
            R := CalcHintRect(Screen.Width, Hint, FHintWnd);

            Pt := ClientToScreen(CellRect(Col, Row).TopLeft);
            Dec(Pt.X);
            Dec(Pt.Y);
            OffsetRect(R, Pt.X, Pt.Y);
            if R.Right > Screen.Width then
                OffsetRect(R, Screen.Width - R.Right, 0);
            if R.Bottom > Screen.Height then
                OffsetRect(R, Screen.Height - R.Bottom, 0);

            GetWindowRect(FHintWnd.Handle, OldR);
            if not IsWindowVisible(FHintWnd.Handle) or
                not ((R.Left = OldR.Left) and (R.Top = OldR.Top)) then
                FHintWnd.ActivateHint(R, Hint)
        end
    else
        if Assigned(FHintWnd) then
            FHintWnd.ReleaseHandle
end;

procedure TExDBGrid.SetDefaultRowHeight(Value: Integer);
begin
    if Value = 0 then
        Value := inherited DefaultRowHeight;

    inherited DefaultRowHeight := Value;

    FNewDefaultRowHeight := Value;

    if dgTitles in Options then
        begin
            Canvas.Font := TitleFont;
            RowHeights[0] := Canvas.TextHeight('Wg') + 4;
        end;
end;

procedure TExDBGrid.LayoutChanged;
begin
    inherited;

    SetDefaultRowHeight(FNewDefaultRowHeight);

    if FMultiLineTitles then
        begin
            UpdateTitlesHeight;
        end;
end;

procedure TExDBGrid.RowHeightsChanged;
var
    i, ThisHasChanged, Def: Integer;
begin
    ThisHasChanged := -1;
    Def := DefaultRowHeight;

    for i := Ord(dgTitles in Options) to RowCount do
        if RowHeights[i] <> Def then
            begin
                ThisHasChanged := i;
                Break;
            end;

    if ThisHasChanged <> -1 then
        begin
            SetDefaultRowHeight(RowHeights[ThisHasChanged]);
            RecreateWnd;
        end;

    if not (dgAlwaysShowEditor in TExDBGrid(Self).Options) then
        begin
            inherited;
        end;
end;

procedure TExDBGrid.CellClick(Column: TColumn);
begin
    if not (csDesigning in ComponentState) then
        begin
            if not ReadOnly and Datalink.Active and not Datalink.Readonly then
                begin
                    BeginUpdate;

                    if (FDisplayBool) then
                        begin
                            if (Datalink <> nil) and (Datalink.Active) and Assigned(Column.Field) and (Column.Field.DataType = ftBoolean) and (CanEditModify = True) then
                                begin
                                    try
                                        if Column.Field.AsBoolean = True then
                                            Column.Field.AsBoolean := False
                                        else
                                            if Column.Field.AsBoolean = False then
                                                Column.Field.AsBoolean := True;
                                    except
                                        Column.Field.Value := NULL;
                                    end;
                                end;
                        end;

                    inherited CellClick(Column);

                    EndUpdate;
                end;
        end;
end;

procedure TExDBGrid.DblClick;
begin
    if not (csDesigning in ComponentState) then
        begin
            if not ReadOnly and Datalink.Active and not Datalink.Readonly then
                begin
                    BeginUpdate;

                    if (Datalink <> nil) and (Datalink.Active) and Assigned(SelectedField) and (not (SelectedField is TMemoField) and (SelectedField is TBlobField)) then
                        begin
                            Application.CreateForm(TExDBGridCtlsForm, ExDBGridCtlsForm);
                            ExDBGridCtlsForm.BlobCaption := Format('Field: %s', [SelectedField.DisplayLabel]);
                            ExDBGridCtlsForm.BlobField := SelectedField;
                            ExDBGridCtlsForm.DataSource := DataSource;
                            ExDBGridCtlsForm.ShowModal;
                            ExDBGridCtlsForm.Release;
                        end;

                    if (Datalink <> nil) and Datalink.Active and Assigned(SelectedField) and (SelectedField is TMemoField) then
                        begin
                            Application.CreateForm(TExDBGridCtlsForm, ExDBGridCtlsForm);
                            ExDBGridCtlsForm.BlobCaption := Format('Field: %s', [SelectedField.DisplayLabel]);
                            ExDBGridCtlsForm.BlobField := SelectedField;
                            ExDBGridCtlsForm.DataSource := DataSource;
                            ExDBGridCtlsForm.ShowModal;
                            ExDBGridCtlsForm.Release;
                        end;

                    EndUpdate;
                end;

            inherited DblClick;
        end;
end;

procedure TExDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
    style: UINT;
    TmpRect: TRect;
    FactorX, FactorY: Double;
    TmpWidth, TmpHeight: Integer;
    CWidth, CHeight: Integer;
    BWidth, BHeight: Integer;
    vAlignment: TAlignment;
    I: Integer;
    w, h: Integer;
    Photo: TJPEGImage;
    Image1: TImage;
    FField: TBlobField;
    MS: TBlobStream;
    MemSize: LongInt;
    Buffer: Pointer;
    TempInfo: Boolean;
    Region, OldClipRegion: HRgn;
    ClipRegionExists: Boolean;
begin
    Image1 := nil;
    Photo := nil;
    MS := nil;

    BeginUpdate;

    I := 0;

    with Canvas do
        begin
            Lock;

            TmpRect := Rect;

            FillRect(Rect);

            if FUseRowColors = True then
                begin
                    if (not (gdSelected in State)) and (not (gdFixed in State)) then
                        begin
                            Canvas.Brush.Style := bsSolid;
                            if ((Rect.Top div (Rect.Bottom - Rect.Top + 1)) mod 2) = 0 then
                                Canvas.Brush.Color := FRowColor1
                            else
                                Canvas.Brush.Color := FRowColor2;

                            FillRect(Rect);
                        end;
                end
            else
                begin
                    if FUseBackgroundPicture = True then
                        if (not (gdSelected in State)) and (not (gdFixed in State)) then
                            if Assigned(BKBmp) then
                                begin
                                    begin
                                        w := Rect.Right - Rect.Left;
                                        h := Rect.Bottom - Rect.Top;
                                        BitBlt(TExDBGrid(Self).Canvas.Handle, Rect.Left, Rect.Top, w, h,
                                            BkBmp.Canvas.Handle, Rect.Left, Rect.Top, SRCCOPY);
                                        Brush.Style := bsClear;
                                    end;
                                end;
                end;

            if (gdFocused in State) and (not (gdFixed in State)) then
                begin
                    Brush.Color := FHighlightColor;
                    Font.Color := FHighlightFontColor;

                    FillRect(Rect);
                end;

            if (gdSelected in State) and (not (gdFixed in State)) then
                begin
                    Brush.Color := FHighlightColor;
                    Font.Color := FHighlightFontColor;

                    FillRect(Rect);
                end;

            if (not (gdSelected in State)) and (not (gdFixed in State)) then
                begin
                    if (not (gdFixed in State)) and (Column <> nil) and (Column.Field <> nil) then
                        ApplyCellAttribute(Column.Field, Canvas, State);
                end;

            if not (Column.Field is TMemoField) and (Column.Field is TBlobField) then
                begin
                    if (FDisplayImages) then
                        begin
                            if (gdFocused in State) or (gdSelected in State) then
                                begin
                                    Brush.Color := FImageHighlightColor;
                                    Font.Color := TExDBGrid(Self).Font.Color;

                                    FillRect(Rect);
                                end;

                            try
                                try
                                    if Assigned(Column.Field) then
                                        begin
                                            FField := Column.Field as TBlobField;
                                            try
                                                Image1 := TImage.Create(TExDBGrid(Self));
                                                with Image1 do
                                                    begin
                                                        AutoSize := True;
                                                        Center := True;
                                                        Stretch := False;
                                                    end;

                                                Image1.Picture.Assign(FField);
                                            except
                                                try
                                                    Photo := TJPEGImage.Create;

                                                    if Assigned(Image1) then
                                                        begin
                                                            Image1.Free;
                                                            Image1 := nil;
                                                        end;

                                                    MS := TBlobStream.Create(FField, bmRead);
                                                    Photo.LoadFromStream(MS);

                                                    Image1 := TImage.Create(TExDBGrid(Self));
                                                    with Image1 do
                                                        begin
                                                            AutoSize := True;
                                                            Center := True;
                                                            Stretch := False;
                                                        end;

                                                    Image1.Picture.Assign(Photo);
                                                finally
                                                    if Assigned(Photo) then
                                                        Photo.Free;

                                                    if Assigned(MS) then
                                                        MS.Free;
                                                end;
                                            end;
                                        end;

                                    CWidth := Rect.Right - Rect.Left + 1 - 1;
                                    CHeight := Rect.Bottom - Rect.Top + 1 - 1;

                                    BWidth := Image1.Width;
                                    BHeight := Image1.Height;

                                    try
                                        if BWidth = 0 then
                                            FactorX := 0
                                        else
                                            FactorX := CWidth / BWidth;

                                        if BHeight = 0 then
                                            FactorY := 0
                                        else
                                            FactorY := CHeight / BHeight;
                                    except
                                        FactorX := 1;
                                        FactorY := 1;
                                    end;

                                    if FactorY < FactorX then
                                        begin
                                            TmpWidth := Round(BWidth * FactorY);
                                            TmpHeight := CHeight;
                                        end
                                    else
                                        begin
                                            TmpHeight := Round(BHeight * FactorX);
                                            TmpWidth := CWidth;
                                        end;

                                    SetRect(TmpRect, 0, 0, TmpWidth, TmpHeight);
                                    OffsetRect(TmpRect, Rect.Left + ((CWidth - TmpWidth) div 2), Rect.Top + ((CHeight - TmpHeight) div 2));

                                    try
                                        TempInfo := Image1.Picture.Graphic is TJPEGImage;

                                        if TempInfo then
                                            StretchDraw(TmpRect, TJPEGImage(Image1.Picture.Graphic))
                                        else
                                            StretchDraw(TmpRect, Image1.Picture.Graphic);
                                    except
                                        if (gdSelected in State) and (not (gdFixed in State)) then
                                            begin
                                                Brush.Color := FHighlightColor;
                                                Font.Color := FHighlightFontColor;

                                                FillRect(Rect);
                                            end;

                                        SetTextAlign(Canvas.Handle, TA_CENTER);
                                        I := (Rect.Right + Rect.Left) div 2;
                                        TextRect(Rect, I, Rect.Top + 2, Column.Field.DisplayText);
                                        SetTextAlign(Canvas.Handle, TA_LEFT);
                                    end;
                                except
                                    if (gdSelected in State) and (not (gdFixed in State)) then
                                        begin
                                            Brush.Color := FHighlightColor;
                                            Font.Color := FHighlightFontColor;

                                            FillRect(Rect);
                                        end;

                                    SetTextAlign(Canvas.Handle, TA_CENTER);
                                    I := (Rect.Right + Rect.Left) div 2;
                                    TextRect(Rect, I, Rect.Top + 2, Column.Field.DisplayText);
                                    SetTextAlign(Canvas.Handle, TA_LEFT);
                                end;
                            finally
                                if Assigned(Image1) then
                                    Image1.Free;
                            end;
                        end
                    else
                        begin
                            SetTextAlign(Canvas.Handle, TA_CENTER);
                            I := (Rect.Right + Rect.Left) div 2;
                            TextRect(Rect, I, Rect.Top + 2, Column.Field.DisplayText);
                            SetTextAlign(Canvas.Handle, TA_LEFT);
                        end;
                end
            else
                if Column.Field is TMemoField then
                    begin
                        if (FDisplayMemo) then
                            begin
                                try
                                    FillRect(Rect);
                                    TmpRect := Rect;
                                    Inc(TmpRect.Top, 2);
                                    Inc(TmpRect.Left, 2);

                                    if FShowMemoEllipsis then
                                        DrawText(Canvas.Handle, PChar(Column.Field.AsString), Length(Column.Field.AsString), TmpRect, DT_SINGLELINE or DT_END_ELLIPSIS or DT_NOPREFIX or DT_LEFT)
                                    else
                                        DrawText(Canvas.Handle, PChar(Column.Field.AsString), Length(Column.Field.AsString), TmpRect, DT_WORDBREAK or DT_NOPREFIX or DT_LEFT);

                                    if (gdFocused in State) then
                                        begin
                                            if DBMemo = nil then
                                                DBMemo := TDBMemo.Create(TExDBGrid(Self));

                                            with DBMemo do
                                                begin
                                                    Visible := False;
                                                    BorderStyle := bsNone;
                                                    ControlStyle := ControlStyle + [csOpaque];
                                                    Parent := TExDBGrid(Self);
                                                    DataSource := nil;
                                                    DataField := '';
                                                    OnKeyDown := OnKeyDBMemo;
                                                    OnExit := OnDBExit;
                                                    Top := TmpRect.Top - 2;
                                                    Left := TmpRect.Left - 2;
                                                    Height := (TmpRect.Bottom - TmpRect.Top + 2);
                                                    Width := (TmpRect.Right - TmpRect.Left + 2);
                                                    ParentFont := True;
                                                    ParentColor := False;
                                                    Color := TExDBGrid(Self).EditColor;
                                                    if FMemoViewType = WordWrapOn then
                                                        begin
                                                            ScrollBars := ssNone;
                                                            WordWrap := True;
                                                        end
                                                    else
                                                        if FMemoViewType = ScrollBarsOn then
                                                            begin
                                                                WordWrap := False;
                                                                ScrollBars := ssBoth;
                                                            end;
                                                    Self.SetFocus;
                                                end;
                                        end;
                                finally
                                end;
                            end
                        else
                            begin
                                SetTextAlign(Canvas.Handle, TA_CENTER);
                                I := (Rect.Right + Rect.Left) div 2;
                                TextRect(Rect, I, Rect.Top + 2, Column.Field.DisplayText);
                                SetTextAlign(Canvas.Handle, TA_LEFT);
                            end;
                    end
                else
                    if Column.Field is TBooleanField then
                        begin
                            if (FDisplayBool) then
                                begin
                                    FillRect(Rect);

                                    if FFlatCheckBox then
                                        if FFlatCheckBoxType = Normal then
                                            begin
                                                ClipRegionExists := False;
                                                OldClipRegion := CreateRectRgn(0, 0, 0, 0);
                                                ClipRegionExists := GetClipRgn(Handle, OldClipRegion) = 1;
                                            end;

                                    TmpRect := Rect;
                                    TmpRect.Left := Rect.Left + (Rect.Right - Rect.Left - GCheckWidth) div 2;
                                    TmpRect.Right := TmpRect.Left + GCheckWidth;
                                    TmpRect.Top := Rect.Top + (Rect.Bottom - Rect.Top - GCheckWidth) div 2;
                                    TmpRect.Bottom := TmpRect.Top + GCheckHeight;

                                    if FFlatCheckBox then
                                        if FFlatCheckBoxType = Normal then
                                            begin
                                                Region := CreateRectRgnIndirect(TmpRect);
                                                ExtSelectClipRgn(Handle, Region, RGN_AND);
                                                DeleteObject(Region);
                                                InflateRect(TmpRect, 1, 1);
                                            end;

                                    Style := DFCS_CHECKED;

                                    if Column.Field.AsBoolean = True then
                                        style := DFCS_CHECKED
                                    else
                                        if Column.Field.AsBoolean = False then
                                            style := DFCS_BUTTONCHECK;

                                    if FFlatCheckBox then
                                        DrawFrameControl(Canvas.Handle, TmpRect, DFC_BUTTON, style or DFCS_FLAT)
                                    else
                                        DrawFrameControl(Canvas.Handle, TmpRect, DFC_BUTTON, style);

                                    if FFlatCheckBox then
                                        if FFlatCheckBoxType = Normal then
                                            begin
                                                if ClipRegionExists then
                                                    SelectClipRgn(Handle, OldClipRegion)
                                                else
                                                    SelectClipRgn(Handle, 0);

                                                DeleteObject(OldClipRegion);
                                                InflateRect(TmpRect, -1, -1);
                                                Brush.Color := clGray;
                                                FrameRect(TmpRect);
                                            end;
                                end
                            else
                                begin
                                    vAlignment := Column.Field.Alignment;

                                    case vAlignment of
                                        taRightJustify:
                                            begin
                                                SetTextAlign(Canvas.Handle, TA_RIGHT);
                                                I := Rect.Right - 2;
                                            end;

                                        taLeftJustify:
                                            begin
                                                SetTextAlign(Canvas.Handle, TA_LEFT);
                                                I := Rect.Left + 2;
                                            end;

                                        taCenter:
                                            begin
                                                SetTextAlign(Canvas.Handle, TA_CENTER);
                                                I := (Rect.Right + Rect.Left) div 2;
                                            end;
                                    end;
                                    TextRect(Rect, I, Rect.Top + 2, Column.Field.DisplayText);
                                    SetTextAlign(Canvas.Handle, TA_LEFT);
                                end;
                        end
                    else
                        begin
                            vAlignment := Column.Field.Alignment;

                            case vAlignment of
                                taRightJustify:
                                    begin
                                        SetTextAlign(Canvas.Handle, TA_RIGHT);
                                        I := Rect.Right - 2;
                                    end;

                                taLeftJustify:
                                    begin
                                        SetTextAlign(Canvas.Handle, TA_LEFT);
                                        I := Rect.Left + 2;
                                    end;

                                taCenter:
                                    begin
                                        SetTextAlign(Canvas.Handle, TA_CENTER);
                                        I := (Rect.Right + Rect.Left) div 2;
                                    end;
                            end;
                            TextRect(Rect, I, Rect.Top + 2, Column.Field.DisplayText);
                            SetTextAlign(Canvas.Handle, TA_LEFT);
                        end;

            if FCells3D = False then
                if FDrawFocusRect then
                    if (dgAlwaysShowSelection in Options) then
                        begin
                            if (gdSelected in State) then
                                if not (dgRowSelect in Options) then
                                    Canvas.DrawFocusRect(Rect);
                        end
                    else
                        begin
                            if (gdFocused in State) then
                                begin
                                    if not (dgRowSelect in Options) then
                                        Canvas.DrawFocusRect(Rect);
                                end
                            else
                                begin
                                    if (not (gdFocused in State)) and (gdSelected in State) then
                                        if not (dgRowSelect in Options) then
                                            begin
                                                Canvas.Brush.Color := clYellow;
                                                Canvas.FrameRect(Rect);
                                            end;
                                end;
                        end;

            Unlock;
        end;

    inherited DrawColumnCell(Rect, DataCol, Column, State);

    EndUpdate;
end;

procedure TExDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
const
    AlignFlags: array[TAlignment] of Integer =
        (DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_END_ELLIPSIS,
        DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_END_ELLIPSIS,
        DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_END_ELLIPSIS);
var
    TitleText: string;
    TmpCol, i, j: LongInt;
    TmpRect: TRect;
begin
    if (gdFixed in AState) and (Ctl3D) and (ARow >= TitleOffset) and (ACol >= IndicatorOffset) then
        inherited DrawCell(ACol, ARow, ARect, AState - [gdFixed])
    else
        inherited DrawCell(ACol, ARow, ARect, AState);

    if (dgIndicator in Options) then
        TmpCol := ACol - 1
    else
        TmpCol := ACol;

    if (FCells3D = True) and ([dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines]) then
        begin
            with ARect do
                begin
                    if (Color = clWhite) or (Color = clWindow) then
                        Color := TExDBGrid(Self).FixedColor;

                    if FTitleCheck then
                        begin
                            if (ARow = 0) and (ACol = 0) and (dgIndicator in Options) and (dgTitles in Options) then
                                begin
                                    Canvas.Brush.Color := clBlack;
                                    i := (ARect.Bottom - ARect.Top - 7) div 2;
                                    j := (ARect.Right - ARect.Left - 7) div 2;
                                    Canvas.Polygon([Point(ARect.Left + j, ARect.Top + i),
                                        Point(ARect.Left + j + 7, ARect.Top + i),
                                            Point(ARect.Left + j + (7 div 2), ARect.Bottom - i)]);
                                end;
                        end;

                    if ARow = 0 then
                        begin
                            if dgTitles in Options then
                                begin
                                    if FMultiLineTitles then
                                        begin
                                            if TmpCol >= 0 then
                                                begin
                                                    if Assigned(Columns[TmpCol]) then
                                                        begin
                                                            TitleText := Columns[TmpCol].Title.Caption;
                                                            if TitleText <> '' then
                                                                begin
                                                                    Canvas.Font := Columns[TmpCol].Title.Font;
                                                                    Canvas.Brush.Color := Columns[TmpCol].Title.Color;

                                                                    TmpRect := ARect;
                                                                    Inc(TmpRect.Top, 2);
                                                                    Inc(TmpRect.Left, 2);
                                                                    Canvas.FillRect(TmpRect);
                                                                    DrawText(Canvas.Handle, PChar(TitleText), Length(TitleText), TmpRect, AlignFlags[Columns[TmpCol].Title.Alignment]);
                                                                end;
                                                        end;
                                                end;
                                        end;
                                end;
                        end;

                    Canvas.Pen.Color := clHighLightText;
                    Canvas.PolyLine([Point(Left, Bottom - 1), Point(Left, Top), Point(Right, Top)]);
                end;
        end
    else
        begin
            with ARect do
                begin
                    if (Color = clBtnFace) or (Color = clSilver) then
                        Color := clWindow;

                    if FTitleCheck then
                        begin
                            if (ARow = 0) and (ACol = 0) and (dgIndicator in Options) and (dgTitles in Options) then
                                begin
                                    Canvas.Brush.Color := clBlack;
                                    i := (ARect.Bottom - ARect.Top - 7) div 2;
                                    j := (ARect.Right - ARect.Left - 7) div 2;
                                    Canvas.Polygon([Point(ARect.Left + j, ARect.Top + i),
                                        Point(ARect.Left + j + 7, ARect.Top + i),
                                            Point(ARect.Left + j + (7 div 2), ARect.Bottom - i)]);
                                end;
                        end;

                    if ARow = 0 then
                        begin
                            if dgTitles in Options then
                                begin
                                    if FMultiLineTitles then
                                        begin
                                            if TmpCol >= 0 then
                                                begin
                                                    if Assigned(Columns[TmpCol]) then
                                                        begin
                                                            TitleText := Columns[TmpCol].Title.Caption;
                                                            if TitleText <> '' then
                                                                begin
                                                                    Canvas.Font := Columns[TmpCol].Title.Font;
                                                                    Canvas.Brush.Color := Columns[TmpCol].Title.Color;

                                                                    TmpRect := ARect;
                                                                    Inc(TmpRect.Top, 2);
                                                                    Inc(TmpRect.Left, 2);
                                                                    Canvas.FillRect(TmpRect);
                                                                    DrawText(Canvas.Handle, PChar(TitleText), Length(TitleText), TmpRect, AlignFlags[Columns[TmpCol].Title.Alignment]);
                                                                end;
                                                        end;
                                                end;
                                        end;

                                    Canvas.Pen.Color := TExDBGrid(Self).FixedColor;
                                    Canvas.PolyLine([Point(Left + 1, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Top)]);

                                    Canvas.Pen.Color := clBtnShadow;
                                    Canvas.PolyLine([Point(Left - 1, Bottom), Point(Right, Bottom), Point(Right, Top - 1)]);
                                end
                            else
                                begin
                                    Canvas.Pen.Color := TExDBGrid(Self).FixedColor;
                                    Canvas.PolyLine([Point(Left, Bottom), Point(Right, Bottom), Point(Right, Top - 1)]);
                                end;

                            if dgIndicator in Options then
                                begin
                                    if ACol = 0 then
                                        begin
                                            Canvas.Pen.Color := TExDBGrid(Self).FixedColor;
                                            Canvas.PolyLine([Point(Left + 1, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Top)]);

                                            Canvas.Pen.Color := clBtnShadow;
                                            Canvas.PolyLine([Point(Left - 1, Bottom), Point(Right, Bottom), Point(Right, Top - 1)]);
                                        end;
                                end;
                        end
                    else
                        if ARow > 0 then
                            begin
                                if dgIndicator in Options then
                                    begin
                                        if ACol = 0 then
                                            begin
                                                Canvas.Pen.Color := TExDBGrid(Self).FixedColor;
                                                Canvas.PolyLine([Point(Left + 1, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Top)]);

                                                Canvas.Pen.Color := clBtnShadow;
                                                Canvas.PolyLine([Point(Left - 1, Bottom), Point(Right, Bottom), Point(Right, Top - 1)]);
                                            end
                                        else
                                            begin
                                                Canvas.Pen.Color := TExDBGrid(Self).FixedColor;
                                                Canvas.PolyLine([Point(Left, Bottom), Point(Right, Bottom), Point(Right, Top - 1)]);
                                            end;
                                    end
                                else
                                    begin
                                        Canvas.Pen.Color := TExDBGrid(Self).FixedColor;
                                        Canvas.PolyLine([Point(Left, Bottom), Point(Right, Bottom), Point(Right, Top - 1)]);
                                    end;
                            end;
                end;
        end;
end;

procedure TExDBGrid.ColWidthsChanged;
begin
    inherited;
    try
        if Assigned(FOnColResize) then
            FOnColResize(TExDBGrid(Self));
    except
    end;
end;

procedure TExDBGrid.SetCheckBoxSize;
begin
    with TBitmap.Create do
        try
            Handle := LoadBitmap(0, PChar(32759));
            GCheckWidth := Width div 4;
            GCheckHeight := Height div 3;
        finally
            Free;
        end;
end;

procedure TExDBGrid.ApplyCellAttribute(Field: TField; Canvas: TCanvas; State: TGridDrawState);
begin
    if Assigned(FOnApplyCellAttribute) then
        FOnApplyCellAttribute(Self, Field, Canvas, State);
end;

procedure TExDBGrid.CellAttribute(Field: TField; Canvas: TCanvas; State: TGridDrawState);
begin
    ApplyCellAttribute(Field, Canvas, State);
end;

procedure TExDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    CursorPos: TPoint;
begin
    if Button = mbRight then
        begin
            if Assigned(PopupMenu) then
                if not Assigned(FOnRightClick) then
                    begin
                        GetCursorPos(CursorPos);
                        PopupMenu.PopupComponent := Self;
                        PopupMenu.Popup(CursorPos.X, CursorPos.Y);
                        Exit;
                    end;
        end;

    if not AcquireFocus then
        Exit;

    if Assigned(FOnMouseDown) then
        FOnMouseDown(Self, Button, Shift, X, Y);

    inherited MouseDown(Button, Shift, X, Y);
end;

procedure TExDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    Cell: TGridCoord;
    ACol, ARow: Longint;
    PopCoord: TPoint;
begin
    if Assigned(FOnMouseUp) then
        FOnMouseUp(Self, Button, Shift, X, Y);

    inherited MouseUp(Button, Shift, X, Y);

    if not (csDesigning in ComponentState) then
        begin
            Cell := MouseCoord(X, Y);
            ACol := Cell.X;
            ARow := Cell.Y;

            if (dgIndicator in Options) then
                Dec(ACol);

            if FTitleCheck then
                begin
                    if dgTitles in Options then
                        if dgIndicator in Options then
                            begin
                                if Datalink.Active then
                                    if ARow = 0 then
                                        if ACol = -1 then
                                            begin
                                                PopCoord := ClientToScreen(Point(X, Y));
                                                FExDBGridPopUpMenu.Popup(PopCoord.X, PopCoord.Y);
                                            end;
                            end;
                end;

            if (Cell.Y < TitleOffset) then
                LockedChanged;
        end;
end;

procedure TExDBGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FOnMouseMove) then
        FOnMouseMove(Self, Shift, X, Y);

    inherited MouseMove(Shift, X, Y);
end;

procedure TExDBGrid.ColEnter;
begin
    if Col <= FixedCols then
        begin
            LeftCol := FixedCols;
            Col := FixedCols;
        end;

    if not (csDesigning in ComponentState) then
        begin
            if not ReadOnly and Datalink.Active and not Datalink.Readonly then
                begin
                    with Columns[SelectedIndex] do
                        if (Field is TBooleanField) or
                            (Field is TBlobField) or
                            (Field is TMemoField) then
                            begin
                                if (goEditing in TExDBGridMod(Self).Options) then
                                    begin
                                        BeginUpdate;
                                        TExDBGridMod(Self).Options := TExDBGridMod(Self).Options - [goEditing];
                                        EndUpdate;
                                    end;
                            end
                        else
                            begin
                                if not (goEditing in TExDBGridMod(Self).Options) then
                                    begin
                                        BeginUpdate;
                                        TExDBGridMod(Self).Options := TExDBGridMod(Self).Options + [goEditing];
                                        EndUpdate;
                                    end;
                            end;

                    if TExDBGrid(Self).SelectedField.Lookup = True then
                        begin
                            TExDBGrid(Self).EditorMode := True;
                            keybd_event(VK_MENU, MapVirtualKey(VK_MENU, 0), 0, 0);
                            keybd_event(VK_DOWN, MapVirtualKey(VK_DOWN, 0), 0, 0);
                            keybd_event(VK_DOWN, 0, KEYEVENTF_KEYUP, 0);
                            keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0);
                        end;

                    if Assigned(FOnColEnter) then
                        FOnColEnter(Self);
                end
            else
                if ReadOnly or Datalink.Readonly then
                    begin
                        if (goEditing in TExDBGridMod(Self).Options) then
                            begin
                                BeginUpdate;
                                TExDBGridMod(Self).Options := TExDBGridMod(Self).Options - [goEditing];
                                EndUpdate;
                            end;

                        if Assigned(FOnColEnter) then
                            FOnColEnter(Self);
                    end;
        end;
end;

procedure TExDBGrid.WMSize(var Message: TWMSize);
begin
    try
        inherited;

        if (Datalink <> nil) and (Datalink.Active) then
            begin
                if FGridAutoSize then
                    begin
                        if Columns.State <> csCustomized then
                            SetGridAutoSize(FGridAutoSize);
                    end;

                if FGridAutoWidth then
                    begin
                        if Columns.State <> csCustomized then
                            SetGridAutoWidth(FGridAutoWidth);
                    end;

                ColEnter;
            end;
        invalidate;
    except
    end;
end;

procedure TExDBGrid.CMFontChanged(var Message: TMessage);
var
    h: Integer;
begin
    inherited;

    Canvas.Font.Assign(font);
    h := Canvas.TextHeight('Wg');

    if FRowHeight < h then
        SetDefaultRowHeight(h);

    if (csdesigning in componentstate) then
        invalidate;
end;

procedure TExDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
const
    vk_c = $43;
    vk_v = $56;
var
    h: THandle;
    r: Integer;
begin
    if FEnterAsTab then
        if Key = VK_RETURN then
            Key := VK_TAB;

    inherited KeyDown(Key, Shift);

    if not (csDesigning in ComponentState) then
        begin
            if not ReadOnly and Datalink.Active and not Datalink.Readonly then
                begin
                    BeginUpdate;

                    if Shift = [ssCtrl] then
                        begin
                            if key = vk_v then
                                Shift := [ssShift];
                            if (key = vk_c) or (key = vk_v) then
                                begin
                                    gk := Key;
                                    key := 0;
                                end;
                        end;

                    if (Key = 32) or (Key = VK_RETURN) then
                        begin
                            if Columns[SelectedIndex].Field is TBooleanField then
                                begin
                                    if (FDisplayBool) then
                                        begin
                                            if not Columns[SelectedIndex].Field.ReadOnly then
                                                CellClick(Columns[SelectedIndex]);
                                        end
                                    else
                                        begin
                                            if not (goEditing in TExDBGridMod(Self).Options) then
                                                begin
                                                    BeginUpdate;
                                                    TExDBGridMod(Self).Options := TExDBGridMod(Self).Options + [goEditing];
                                                    EndUpdate;
                                                end;
                                        end;
                                end;

                            if not (Columns[SelectedIndex].Field is TMemoField) and (Columns[SelectedIndex].Field is TBlobField) then
                                begin
                                    DblClick;
                                end;

                            if (FDisplayMemo) then
                                begin
                                    if not (FFullSizeMemo) then
                                        if Columns[SelectedIndex].Field is TMemoField then
                                            begin
                                                with DBMemo do
                                                    begin
                                                        Application.ProcessMessages;
                                                        DataSource := Datalink.DataSource;
                                                        DataField := Columns[SelectedIndex].FieldName;
                                                        Visible := True;
                                                        SetFocus;
                                                        Application.ProcessMessages;
                                                        h := Windows.GetFocus;
                                                        SendMessage(h, EM_SETSEL, 0, -1);
                                                        SendMessage(h, EM_SCROLLCARET, 0, 0);
                                                    end;
                                            end;
                                end
                            else
                                begin
                                    if Columns[SelectedIndex].Field is TMemoField then
                                        begin
                                            DblClick;
                                        end;
                                end;

                        end;

                    if (Key = VK_F2) then
                        begin
                            if Columns[SelectedIndex].Field is TBooleanField then
                                begin
                                    if (FDisplayBool) then
                                        begin
                                            if not Columns[SelectedIndex].Field.ReadOnly then
                                                CellClick(Columns[SelectedIndex]);
                                        end
                                    else
                                        begin
                                            if not (goEditing in TExDBGridMod(Self).Options) then
                                                begin
                                                    BeginUpdate;
                                                    TExDBGridMod(Self).Options := TExDBGridMod(Self).Options + [goEditing];
                                                    EndUpdate;
                                                end;
                                        end;
                                end;

                            if not (Columns[SelectedIndex].Field is TMemoField) and (Columns[SelectedIndex].Field is TBlobField) then
                                begin
                                    DblClick;
                                end;

                            if (FDisplayMemo) then
                                begin
                                    if not (FFullSizeMemo) then
                                        if Columns[SelectedIndex].Field is TMemoField then
                                            begin
                                                with DBMemo do
                                                    begin
                                                        Application.ProcessMessages;
                                                        DataSource := Datalink.DataSource;
                                                        DataField := Columns[SelectedIndex].FieldName;
                                                        Visible := True;
                                                        SetFocus;
                                                        Application.ProcessMessages;
                                                        h := Windows.GetFocus;
                                                        SendMessage(h, EM_SETSEL, Length(Columns[SelectedIndex].Field.Value), Length(Columns[SelectedIndex].Field.Value));
                                                        SendMessage(h, EM_SCROLLCARET, 0, 0);
                                                    end;
                                            end;
                                end
                            else
                                begin
                                    if Columns[SelectedIndex].Field is TMemoField then
                                        begin
                                            DblClick;
                                        end;
                                end;

                        end;

                    if FAllowAutoAppend = False then
                        begin
                            if (Key = VK_DOWN) then
                                begin
                                    Datalink.DataSet.Next;
                                    if Datalink.DataSet.EOF then
                                        Key := 0
                                    else
                                        Datalink.DataSet.Prior;
                                end;
                        end;

                    if FUseRowColors then
                        begin
                            if (Key = VK_DOWN) or (Key = VK_NEXT) then
                                begin
                                    if FAllowAutoAppend then
                                        r := TExDBGrid(Self).VisibleRowCount
                                    else
                                        r := TExDBGrid(Self).VisibleRowCount - 1;
                                end
                            else
                                if (Key = VK_UP) or (Key = VK_PRIOR) then
                                    r := 1
                                else
                                    r := 0;
                            if TExDBGrid(Self).Row = r then
                                TExDBGrid(Self).Invalidate;
                        end;

                    EndUpdate;
                end;
        end;
end;

procedure TExDBGrid.KeyUp(var Key: Word; Shift: TShiftState);
begin
    if FEnterAsTab then
        if Key = VK_RETURN then
            Key := VK_TAB;

    inherited KeyUp(Key, Shift);
end;

procedure TExDBGrid.KeyPress(var Key: Char);
const
    vk_c = $43;
    vk_v = $56;
begin
    if not EditorMode then
        if FEnterAsTab and (Key = #13) then
            Key := #9;

    inherited KeyPress(Key);

    if not (csDesigning in ComponentState) then
        begin
            if not ReadOnly and Datalink.Active and not Datalink.Readonly then
                begin
                    BeginUpdate;

                    if gk <> 0 then
                        begin
                            Key := chr(0);
                            if gk = vk_c then
                                ClipBoard.AsText := Columns[SelectedIndex].Field.AsString;
                            if gk = vk_v then
                                begin
                                    if (Datalink.DataSet.State = dsEdit) or (Datalink.DataSet.State = dsInsert) then
                                        Columns[SelectedIndex].Field.AsString := ClipBoard.AsText
                                    else
                                        MessageBeep(0);
                                end;
                            gk := 0;
                        end;

                    EndUpdate;
                end;
        end;
end;

procedure TExDBGrid.TitleClick(Column: TColumn);
begin
    inherited TitleClick(Column);
end;

procedure TExDBGrid.Paint;
begin
    DrawBackground;

    inherited;
end;

procedure TExDBGrid.Loaded;
begin
    DBMemo := nil;
    FOrigColor := Font.Color;

    inherited Loaded;
end;

procedure TExDBGrid.CreateWnd;
begin
    inherited CreateWnd;

    SetLockedCols(FLockedCols);
end;

procedure TExDBGrid.SetColumnAttributes;
begin
    inherited SetColumnAttributes;

    LockedChanged;
    invalidate;
end;

procedure TExDBGrid.Notification(AComponent: TComponent; AOperation: TOperation);
begin
    inherited Notification(AComponent, AOperation);
end;

{ END PROTECTED }

{ BEGIN PUBLIC }

function TExDBGrid.CellRect(ACol, ARow: Longint): TRect;
begin
    Result := inherited CellRect(ACol, ARow);
end;

procedure TExDBGrid.MoveToRow(NewRow: Integer);
var
    Mark: TBookmarkStr;
begin
    Mark := DataLink.DataSet.Bookmark;
    DataLink.ActiveRecord := NewRow;
    DbiSetToBookmark(TDBDataSet(DataLink.DataSet).Handle, Pointer(Mark));
    DataLink.DataSet.Resync([rmExact]);
end;

procedure TExDBGrid.WMHScroll(var Msg: TWMHScroll);
begin
    BeginUpdate;
    inherited;

    if Msg.ScrollCode = sb_ThumbTrack then
        Perform(wm_HScroll, MakeLong(sb_ThumbPosition, Msg.Pos), Msg.ScrollBar);
    EndUpdate;
end;

procedure TExDBGrid.WMVScroll(var Msg: TWMVScroll);
begin
    BeginUpdate;
    inherited;

    if Msg.ScrollCode = sb_ThumbTrack then
        Perform(wm_VScroll, MakeLong(sb_ThumbPosition, Msg.Pos), Msg.ScrollBar);
    EndUpdate;
end;

procedure TExDBGrid.CMMouseEnter(var Msg: TMessage);
var
    Pt: TPoint;
begin
    if FCellHints = True then
        begin
            GetCursorPos(Pt);
            Pt := ScreenToClient(Pt);
            DoHint(Pt.X, Pt.Y);
        end;

    if FHotTrack = True then
        begin
            Font.Color := FHotTrackColor;
        end;
end;

procedure TExDBGrid.CMMouseLeave(var Msg: TMessage);
begin
    inherited;

    if FCellHints = True then
        if Assigned(FHintWnd) then
            begin
                FHintWnd.Destroy;
                FHintWnd := nil;
            end;

    if FHotTrack = True then
        begin
            Font.Color := FOrigColor;
        end;
end;

procedure TExDBGrid.WMMouseMove(var Msg: TWMMouseMove);
begin
    inherited;

    if FCellHints = True then
        DoHint(Msg.XPos, Msg.YPos)
end;

procedure TExDBGrid.OnKeyDBMemo(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key = VK_ESCAPE then
        with DBMemo do
            begin
                Visible := False;
                DataSource := nil;
                DataField := '';
                Self.SetFocus;
            end;
end;

procedure TExDBGrid.OnDBExit(Sender: TObject);
begin
    if DBMemo.Visible then
        begin
            with DBMemo do
                begin
                    Visible := False;
                    DataSource := nil;
                    DataField := '';
                    Self.SetFocus;
                end;
        end;
end;

procedure TExDBGrid.ExportGrid(ExpFileName: string);
begin
    if ExpFileName = '' then
        ExpFileName := ExtractFilePath(Application.ExeName) + 'DataExport.Dat';

    if FExportDelimiter = Pipe then
        ExportToFile(ExpFileName, '|')
    else
        if FExportDelimiter = Comma then
            ExportToFile(ExpFileName, ',')
        else
            if FExportDelimiter = Quote then
                ExportToFile(ExpFileName, '"');

    MessageDlg('Exported To File: ' + ExtractFilePath(Application.ExeName) + 'DataExport.Dat', mtInformation, [mbOk], 0);
end;

procedure TExDBGrid.ExportToFile(ExpFileName: string; Delimiter: Char);
var
    slst: TStringList;
    strRow: string;
    j: Integer;
begin
    Datalink.DataSet.DisableControls;
    Datalink.DataSet.First;

    slst := TStringList.Create;
    try
        while not Datalink.DataSet.EOF do
            begin
                strRow := '';
                if dgIndicator in Options then
                    begin
                        for j := 0 to ColCount - 2 do
                            if strRow = '' then
                                begin
                                    strRow := TExDBGrid(Self).Columns[j].Field.DisplayText;
                                end
                            else
                                begin
                                    strRow := strRow + delimiter + TExDBGrid(Self).Columns[j].Field.DisplayText;
                                end;
                        slst.Add(strRow);
                    end
                else
                    begin
                        for j := 0 to ColCount - 1 do
                            if strRow = '' then
                                begin
                                    strRow := TExDBGrid(Self).Columns[j].Field.DisplayText;
                                end
                            else
                                begin
                                    strRow := strRow + delimiter + TExDBGrid(Self).Columns[j].Field.DisplayText;
                                end;
                        slst.Add(strRow);
                    end;
                Datalink.DataSet.Next;
            end;

        if (ExpFileName <> '') then
            slst.SaveToFile(ExpFileName);
    finally
        slst.Free;
    end;

    Datalink.DataSet.First;
    Datalink.DataSet.EnableControls;
end;

procedure TExDBGrid.GridPreview;
begin
    if ReportCaption <> '' then
        ShowReportByGrid(TExDBGrid(Self), ReportCaption)
    else
        ShowReportByGrid(TExDBGrid(Self), 'Data Printout');
end;

procedure TExDBGrid.DataSetPreview;
begin
    if ReportCaption <> '' then
        ShowReportByDataSet(TExDBGrid(Self).DataSource.DataSet, ReportCaption)
    else
        ShowReportByDataSet(TExDBGrid(Self).DataSource.DataSet, 'Data Printout');
end;

{ END PUBLIC }

destructor TExDBGrid.Destroy;
begin
    FExDBGridPopUpMenu.Free;

    FLockedFont.Free;
    FLockedFont := nil;

    if Assigned(DBMemo) then
        begin
            DBMemo.Free;
            DBMemo := nil;
        end;

    if Assigned(BkBmp) then
        begin
            BkBmp.Free;
            BkBmp := nil;
        end;

    if Assigned(FBackGroundPicture) then
        begin
            FBackGroundPicture.Free;
            FBackGroundPicture := nil;
        end;

    inherited Destroy;
end;

procedure Register;
begin
    RegisterComponents('GJL Software', [TExDBGrid]);
end;

end.

