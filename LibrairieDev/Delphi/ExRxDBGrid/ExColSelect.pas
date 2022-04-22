{
TExDBGrid Version 2.4

Copyright (©) 1999 & 2000 by GJL Software
Updated 17th April 2000 (17/04/2000)

Email:         ExDBGrid@gjl-software.co.uk
Home Page:     http://www.gjl-software.co.uk
}

unit ExColSelect;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Db, DbTables, Checklst, ExDBGrid, ExRxDBGrid;

type
    TExColSelectFrm = class(TForm)
        ColList: TCheckListBox;
        procedure FormActivate(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure FormKeyPress(Sender: TObject; var Key: Char);
        procedure ColListKeyPress(Sender: TObject; var Key: Char);
        procedure ColListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
        procedure FormCreate(Sender: TObject);
    private
        { Private declarations }
        FDataSource: TDataSource;
        FExDBGrid: TExDBGrid;
        FExRxDBGrid: TExRxDBGrid;
    public
        { Public declarations }
        property DataSource: TDataSource read FDataSource write FDataSource;
        property ExDBGrid: TExDBGrid read FExDBGrid write FExDBGrid;
        property ExRxDBGrid: TExRxDBGrid read FExRxDBGrid write FExRxDBGrid;
    end;

var
    ExColSelectFrm: TExColSelectFrm;
    ColumnUpdate: Boolean;
    ExCheckWidth,
        ExCheckHeight: Integer;

implementation

{$R *.DFM}

procedure TExColSelectFrm.FormActivate(Sender: TObject);
var
    i, j: Integer;
begin
    ColumnUpdate := True;

    if ExDBGrid <> nil then
        begin
            with ExDBGrid do
                try
                    if not (Assigned(DataSource) and
                        Assigned(DataSource.DataSet)) then exit;

                    for i := 0 to DataSource.DataSet.FieldCount - 1 do
                        begin
                            j := ColList.Items.Add(DataSource.DataSet.Fields[i].FieldName);
                            ColList.Checked[j] := DataSource.DataSet.Fields[i].Visible;
                        end;
                finally
                    //
                end;

            if ColList.Items.Count > 0 then
                ColList.ItemIndex := 0;
        end
    else
        if ExRxDBGrid <> nil then
            begin
                with ExRxDBGrid do
                    try
                        if not (Assigned(DataSource) and
                            Assigned(DataSource.DataSet)) then exit;

                        for i := 0 to DataSource.DataSet.FieldCount - 1 do
                            begin
                                j := ColList.Items.Add(DataSource.DataSet.Fields[i].FieldName);
                                ColList.Checked[j] := DataSource.DataSet.Fields[i].Visible;
                            end;
                    finally
                        //
                    end;

                if ColList.Items.Count > 0 then
                    ColList.ItemIndex := 0;
            end;
end;

procedure TExColSelectFrm.FormClose(Sender: TObject;
    var Action: TCloseAction);
var
    i: Integer;
    ContinueUpdate: Boolean;
begin
    ContinueUpdate := False;

    if ColumnUpdate then
        begin
            for i := 0 to ColList.Items.Count - 1 do
                begin
                    if ColList.Checked[i] = True then
                        begin
                            ContinueUpdate := True;
                        end;
                end;

            if ContinueUpdate = True then
                begin
                    for i := 0 to ColList.Items.Count - 1 do
                        begin
                            with DataSource.DataSet.Fields[i] do
                                begin
                                    Visible := ColList.Checked[i];
                                end;
                        end;
                end
            else
                begin
                    MessageDlg('You Cannot Hide All The Columns.', mtWarning, [mbOk], 0);
                end;
        end;
end;

procedure TExColSelectFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #27 then
        begin
            ExColSelectFrm.ModalResult := mrCancel;
            ColumnUpdate := False;
        end;
end;

procedure TExColSelectFrm.ColListKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #27 then
        begin
            ExColSelectFrm.ModalResult := mrCancel;
            ColumnUpdate := False;
        end;
end;

procedure TExColSelectFrm.ColListDrawItem(Control: TWinControl;
    Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
    DrawRect: TRect;
begin
    with TCheckListBox(Control).Canvas do
        begin
            FillRect(Rect);

            //LIST ITEMS

            TextRect(Rect, Rect.Left + 4, Rect.Top + 1, TCheckListBox(Control).Items.Strings[Index]);

            //Top
            Pen.Color := clWindow;
            MoveTo(Rect.Left, Rect.Top);
            LineTo(Rect.Right, Rect.Top);
            //Left
            {Pen.Color := clWhite;
            MoveTo(Rect.Left, Rect.Top + 1);
            LineTo(Rect.Left, Rect.Bottom - 1);}
            //Bottom
            Pen.Color := clBtnShadow;
            MoveTo(Rect.Left, Rect.Bottom - 1);
            LineTo(Rect.Right, Rect.Bottom - 1);
            //Right
            Pen.Color := clBtnShadow;
            MoveTo(Rect.Right - 1, Rect.Top);
            LineTo(Rect.Right - 1, Rect.Bottom - 1);

            //CHECK ITEMS

            DrawRect := Rect;
            DrawRect.Right := Rect.Left;
            DrawRect.Left := DrawRect.Right - (ExCheckWidth + 2);
            DrawRect.Top := Rect.Top;
            DrawRect.Bottom := Rect.Bottom;

            //Top
            Pen.Color := clWindow;
            MoveTo(DrawRect.Left, DrawRect.Top);
            LineTo(DrawRect.Right, DrawRect.Top);
            //Left
            Pen.Color := clWindow;
            MoveTo(DrawRect.Left, DrawRect.Top + 1);
            LineTo(DrawRect.Left, DrawRect.Bottom - 1);
            //Bottom
            Pen.Color := clBtnShadow;
            MoveTo(DrawRect.Left, DrawRect.Bottom - 1);
            LineTo(DrawRect.Right, DrawRect.Bottom - 1);
            //Right
            {Pen.Color := clBtnShadow;
            MoveTo(DrawRect.Right - 1, DrawRect.Top);
            LineTo(DrawRect.Right - 1, DrawRect.Bottom - 1);}
        end;

    if (odSelected in State) then
        begin
            TCheckListBox(Control).Canvas.FrameRect(Rect);
        end;
end;

procedure TExColSelectFrm.FormCreate(Sender: TObject);
begin
    with TBitmap.Create do
        try
            Handle := LoadBitmap(0, PChar(32759));
            ExCheckWidth := Width div 4;
            ExCheckHeight := Height div 3;
        finally
            Free;
        end;
end;

end.

