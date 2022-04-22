unit DBGrid_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids,extctrls,db,PanelAide_PM;

type
  TMyCustomGrid = Class(TCustomGrid)
  public
  Property Row;
  Property Col;
  end;

    TMyControl = class(TControl)
    public
    property Font;
    property Color;
    end;

    TMyCustomControl = class(TCustomControl)
    public
    property Canvas;
    end;
  TDBGrid_PM = class(TDBGrid)
  private
    { Déclarations privées }
    FTypeColorBord : TColor;
    FTypeColorFocalisation : TColor;
    Color1: TColor;
    FPolicePlus:boolean;
    LastCol,LastRow:Integer;
    FTPanelAide:TPanelAide_PM;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    Procedure CWPaint(var Message:TWMPaint);message WM_PAINT;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure EcritText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
      Property Row;
      Property Col;
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
      Procedure DrawDataCell(const Rect: TRect;Field: TField; State: TGridDrawState);override;
      procedure KeyUp(var Key: Word; Shift: TShiftState);override;
      procedure KeyDown(var Key: Word; Shift: TShiftState);override;
  published
    { Déclarations publiées }
    Property ColorBordure : TColor read FTypeColorBord Write FTypeColorBord Default clWindow;
    Property ColorFocalisation : TColor read FTypeColorFocalisation Write FTypeColorFocalisation Default clWindow;
    Property PolicePlus : Boolean read FPolicePlus write FPolicePlus;
    Property AideTable : TPanelAide_PM read FTPanelAide write FTPanelAide;
  end;

procedure Register;

implementation

var
  DrawBitmap: TBitmap;

procedure Register;
begin
  RegisterComponents('PBMA', [TDBGrid_PM]);
end;

constructor TDBGrid_PM.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
     FTypeColorFocalisation:=clWindow;
     FTypeColorBord:=clWindow;
end;

destructor TDBGrid_PM.Destroy;
begin
     inherited;
end;

procedure TDBGrid_PM.CMEnter(var Message: TCMEnter);
Begin
     inherited;
     Color1 := Color;
     Color := ColorFocalisation;
     if (parent is TPanel) then begin
               TMyCustomControl(Parent).Canvas.Pen.Color:=ColorBordure;
               TMyCustomControl(Parent).Canvas.Pen.Width:=5;
               TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
     end;
     if (parent is TForm) then begin
               (parent as TForm).Canvas.Pen.Color:=ColorBordure;
               (parent as TForm).Canvas.Pen.Width:=5;
               (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
     end;
LastCol:=Col;
LastRow:=Row;
if editorMode then
if InplaceEditor <> nil then
  if InplaceEditor.Visible then
  begin
  TMyControl(InplaceEditor).Font.size:=font.size+2;
  TMyControl(InplaceEditor).Color:=ColorFocalisation;
  InplaceEditor.Deselect;
  end;

end;

procedure TDBGrid_PM.CMExit(var Message: TCMExit);
var
i:integer;
coul:TColor;
begin
     inherited;
     Color :=  Color1;
     if (parent is TPanel) then begin
               TMyCustomControl(Parent).Canvas.Pen.Color:=TMyCustomControl(Parent).Color;
               TMyCustomControl(Parent).Canvas.Pen.Width:=5;
               TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
     end;
     if (parent is TForm) then begin
               (parent as TForm).Canvas.Pen.Color:=(parent as TForm).Color;
               (parent as TForm).Canvas.Pen.Width:=5;
               (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
     end;
End;

procedure TDBGrid_PM.CWPaint(var Message: TWMPaint);
var
i:integer;
Coul:TColor;
ARect,Rect:TRect;
Begin
     inherited;

     if focused then
      begin
       if (parent is TPanel) then
        begin
         TMyCustomControl(Parent).Canvas.Pen.Color:=ColorBordure;
         TMyCustomControl(Parent).Canvas.Pen.Width:=5;
         TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
        end;
       if (parent is TForm) then
        begin
         (parent as TForm).Canvas.Pen.Color:=ColorBordure;
         (parent as TForm).Canvas.Pen.Width:=5;
         (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
        end;
      end
       else
 if dgAlwaysShowSelection in options then
   begin
   ARect:=Boxrect(1,Row,VisibleColCount,Row);
   Canvas.Pen.Color:=ColorBordure;
   Canvas.Pen.Width:=1;
   Canvas.Font.Size:=font.size;
   Canvas.Font.Color:=Font.color;
   canvas.Brush.Color:=color;
   Canvas.FillRect(cellRect(col,Row));
//   Canvas.PenPos:=(Point(cellRect(Col,Row).Left,cellRect(Col,Row).Top+1));
//   Canvas.LineTo(cellRect(Col,Row).Right,cellRect(Col,Row).Top+1);
//   Canvas.PenPos:=(Point(cellRect(Col,Row).Left,cellRect(Col,Row).Bottom-2));
//   Canvas.LineTo(cellRect(Col,Row).Right,cellRect(Col,Row).Bottom-2);
    Canvas.Polyline([Point(ARect.Left+1,ARect.Top+1),Point(ARect.Right-1,ARect.Top+1),Point(ARect.Right-1,ARect.Bottom-2),point(ARect.Left+1,ARect.Bottom-2)]);
//   Canvas.TextOut(cellRect(Col,Row).left+2,cellRect(Col,Row).top+2,getEdittext(Col,Row));
   if Columns.Items[col-1].Field.DataType <> ftBoolean then
    begin {4}
    Canvas.TextOut(cellRect(Col,Row).left+2,cellRect(Col,Row).top+2,getEdittext(Col,Row));
    end   {4}
    else
    begin  {5}
    if (Columns.Items[col-1].Field as TBooleanField).DisplayValues='' then
     begin
//   Canvas.FillRect(cellRect(col,Row));
     rect:=CellRect(Col,Row);   {6}
     Canvas.pen.Width:=1;
     Canvas.pen.Color:=clBlue;
     Canvas.Polyline([Point(Rect.left+2,Rect.Bottom-4),Point(Rect.Left+2,Rect.Top+2),Point(Rect.left+17,Rect.Top+3)]);
     Canvas.pen.Color:=clBlue;
     Canvas.Polyline([Point(Rect.left+3,Rect.Bottom-5),Point(Rect.Left+3,Rect.Top+3),Point(Rect.left+18,Rect.Top+4)]);
     Canvas.pen.Color:=clWhite;
     Canvas.Polyline([Point(Rect.left+17,Rect.Top+2),Point(Rect.left+17,Rect.Bottom-4),Point(Rect.left+2,Rect.Bottom-4)]);
     Canvas.pen.Color:=clsilver;
     Canvas.Polyline([Point(Rect.left+18,Rect.Top+3),Point(Rect.left+18,Rect.Bottom-3),Point(Rect.left+3,Rect.Bottom-3)]);
     if Columns.Items[col-1].Field.AsBoolean then
      begin  {7}
      Canvas.pen.Color:=clFuchsia;
      Canvas.pen.Width:=2;
      Canvas.Polyline([Point(Rect.Left+4,Rect.Top+8),Point(Rect.left+6,Rect.Bottom-2)]);
      Canvas.Polyline([Point(Rect.left+6,Rect.Bottom-2),point(Rect.Left+12,Rect.Top+4)]);
      Canvas.Polyline([point(Rect.Left+12,Rect.Top+4),point(Rect.Left+16,Rect.Top+4)]);
      end;   {7}
     end  {6}
     else Canvas.TextOut(cellRect(Col,Row).left+2,cellRect(Col,Row).top+2,getEdittext(Col,Row));
    end;  {5}
   end;
//if editorMode then
//if InplaceEditor <> nil then
//  if InplaceEditor.Visible then
//  begin
//  TMyControl(InplaceEditor).Font.size:=font.size+2;
////  TMyControl(InplaceEditor).Color:=ColorFocalisation;
////  InplaceEditor.Deselect;
//  ShowCaret(InplaceEditor.Handle);
////  beep;
//  end;
end;

Procedure TDBGrid_PM.DrawDataCell(const Rect: TRect;Field: TField; State: TGridDrawState);
var
Rec:TRect;
begin
inherited DrawDataCell(Rect,Field,state);

//if editorMode then
//if InplaceEditor <> nil then
//  if InplaceEditor.Visible then
//  begin
//  TMyControl(InplaceEditor).Font.size:=font.size+2;
////  TMyControl(InplaceEditor).Color:=ColorFocalisation;
////  InplaceEditor.Deselect;
//  ShowCaret(InplaceEditor.Handle);
////  beep;
//  end;
////DefaultDrawColumnCell(Rect,col,Columns.Items[col],state);
//    Rec:=Boxrect(1,Row,VisibleColCount,Row);
//    if ((Rec.Top = rect.Top) and (Rec.left=Rect.Left)) then
//    Canvas.Pen.Color:=clRed else Canvas.Pen.Color:=clAqua;
//if focused then begin
//    canvas.Brush.Color:=ColorFocalisation;
//    Canvas.Font.Size:=font.size;
//    Canvas.Font.Color:=Font.color;
//    Canvas.Pen.Color:=ColorBordure;
//    Canvas.Pen.Width:=1;
////    Canvas.Font.Size:=font.size+1;
//    Canvas.Font.Size:=font.size;
//    Canvas.Font.Color:=Font.color;
//    Canvas.Polyline([Point(Rec.Left+1,Rec.Top+1),Point(Rec.Right-1,Rec.Top+1),Point(Rec.Right-1,Rec.Bottom-2),point(Rec.Left+1,Rec.Bottom-2)]);
//    end
//    else
//    begin
//    canvas.Brush.Color:=color;
//    Canvas.Font.Size:=font.size;
//    Canvas.Font.Color:=Font.color;
//    Canvas.Pen.Color:=ColorBordure;
//    Canvas.Pen.Width:=1;
//    Canvas.Polyline([Point(Rec.Left+1,Rec.Top+1),Point(Rec.Right-1,Rec.Top+1),Point(Rec.Right-1,Rec.Bottom-2),point(Rec.Left+1,Rec.Bottom-2)]);
//    end;
end;

procedure TDBGrid_PM.EcritText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);
function Max(X, Y: Integer): Integer;
begin
  Result := Y;
  if X > Y then Result := X;
end;
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
var
  B, R: TRect;
  I, Left: Integer;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    ExtTextOut(ACanvas.Handle, Left, ARect.Top + DY, ETO_OPAQUE or
      ETO_CLIPPED, @ARect, PChar(Text), Length(Text), nil);
  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
//        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        DrawText(Handle, PChar(Text), Length(Text), R, AlignFlags[Alignment]);
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

procedure TDBGrid_PM.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
Hdc,i:integer;
Rect:TRect;
Coul:TColor;
begin
inherited DrawCell(Acol,Arow,ARect,AState);
if focused then
 begin  {1}
//DefaultDrawColumnCell(ARect,Acol,Columns.Items[Acol],Astate);
 if ((Acol=Col) and (ARow=Row)) then
  begin  {2}
  if not (dgRowSelect in options) then
   begin   {3}
   if ((ARow=Row) and (DefaultRowHeight=RowHeights[Arow])) then RowHeights[Arow]:=RowHeights[ARow];
   if ((LastRow<>Row) and (LastRow<VisibleRowCount)) then RowHeights[Lastrow]:=DefaultRowHeight;
   LastRow:=Row;
   Canvas.Pen.Color:=ColorBordure;
   Canvas.Pen.Width:=1;
   Canvas.Font.Size:=font.size;
//     Canvas.Font.Size:=font.size+1;
   Canvas.Font.Color:=Font.color;
   canvas.Brush.Color:=ColorFocalisation;
//   DefaultDrawColumnCell(ARect,Acol,Columns.Items[Acol],Astate);
   Canvas.Rectangle(cellRect(Col,Row).Left+1,cellRect(Col,Row).Top+1,cellRect(Col,Row).Right-1,cellRect(Col,Row).Bottom-1);
   Canvas.Polyline([Point(cellRect(Col,Row).Left+1,cellRect(Col,Row).Top+1),Point(cellRect(Col,Row).Right-1,cellRect(Col,Row).Top+1),Point(cellRect(Col,Row).Right-1,cellRect(Col,Row).Bottom-1),point(cellRect(Col,Row).Left+1,cellRect(Col,Row).Bottom-1)]);
//   Ecrittext(Canvas,Rect,2,2,getEdittext(Col,Row),Columns.Items[Acol-1].Alignment);
   if Columns.Items[Acol-1].Field.DataType <> ftBoolean then
    begin {4}
    Canvas.TextOut(cellRect(Col,Row).left+2,cellRect(Col,Row).top+2,getEdittext(Col,Row));
    end   {4}
    else
    begin  {5}
    if (Columns.Items[Acol-1].Field as TBooleanField).DisplayValues='' then
     begin   {6}
     Canvas.pen.Width:=1;
     Canvas.pen.Color:=clBlue;
     Canvas.Polyline([Point(ARect.left+3,ARect.Bottom-4),Point(ARect.Left+3,ARect.Top+3),Point(ARect.left+17,ARect.Top+3)]);
     Canvas.pen.Color:=clBlue;
     Canvas.Polyline([Point(ARect.left+4,ARect.Bottom-5),Point(ARect.Left+4,ARect.Top+4),Point(ARect.left+18,ARect.Top+4)]);
     Canvas.pen.Color:=clWhite;
     Canvas.Polyline([Point(ARect.left+17,ARect.Top+3),Point(ARect.left+17,ARect.Bottom-5),Point(ARect.left+3,ARect.Bottom-5)]);
     Canvas.pen.Color:=clsilver;
     Canvas.Polyline([Point(ARect.left+18,ARect.Top+4),Point(ARect.left+18,ARect.Bottom-4),Point(ARect.left+4,ARect.Bottom-4)]);
     if Columns.Items[Acol-1].Field.AsBoolean then
      begin  {7}
      Canvas.pen.Color:=clFuchsia;
      Canvas.pen.Width:=2;
      Canvas.Polyline([Point(ARect.Left+4,ARect.Top+8),Point(ARect.left+6,ARect.Bottom-2)]);
      Canvas.Polyline([Point(ARect.left+6,ARect.Bottom-2),point(ARect.Left+12,ARect.Top+4)]);
      Canvas.Polyline([point(ARect.Left+12,ARect.Top+4),point(ARect.Left+16,ARect.Top+4)]);
      end;   {7}
     end  {6}
     else Canvas.TextOut(cellRect(Col,Row).left+2,cellRect(Col,Row).top+2,getEdittext(Col,Row));
    end;  {5}
   end
   else
   begin   {8}
   if ((ARow=Row) and (DefaultRowHeight=RowHeights[Arow])) then RowHeights[Arow]:=RowHeights[ARow];
   if ((LastRow<>Row) and (LastRow<VisibleRowCount)) then RowHeights[Lastrow]:=DefaultRowHeight;
   LastRow:=Row;
   Canvas.Pen.Color:=ColorBordure;
   Canvas.Pen.Width:=1;
//    Canvas.Font.Size:=font.size+1;
   Canvas.Font.Size:=font.size;
   Canvas.Font.Color:=Font.color;
   Rect:=Boxrect(1,Row,VisibleColCount,Row);
   Canvas.Polyline([Point(Rect.Left+1,Rect.Top+1),Point(Rect.Right-1,Rect.Top+1),Point(Rect.Right-1,Rect.Bottom-2),point(Rect.Left+1,Rect.Bottom-2)]);
   Canvas.Pen.Color:=ColorBordure;
   Canvas.Pen.Width:=1;
//   Canvas.Font.Size:=font.size+1;
   Canvas.Font.Size:=font.size;
   Canvas.Font.Color:=Font.color;
   canvas.Brush.Color:=ColorFocalisation;
//     DefaultDrawColumnCell(ARect,Acol,Columns.Items[Acol],Astate);
   Canvas.Rectangle(cellRect(Col,Row).Left+1,cellRect(Col,Row).Top+1,cellRect(Col,Row).Right-1,cellRect(Col,Row).Bottom-1);
   Canvas.Polyline([Point(cellRect(Col,Row).Left+1,cellRect(Col,Row).Top+1),Point(cellRect(Col,Row).Right-1,cellRect(Col,Row).Top+1),Point(cellRect(Col,Row).Right-1,cellRect(Col,Row).Bottom-1),point(cellRect(Col,Row).Left+1,cellRect(Col,Row).Bottom-1)]);
//     Ecrittext(Canvas,Rect,2,2,getEdittext(Col,Row),Columns.Items[Acol-1].Alignment);
   if Columns.Items[Acol-1].Field.DataType <> ftBoolean then
    begin  {9}
    Canvas.TextOut(cellRect(Col,Row).left+2,cellRect(Col,Row).top+2,getEdittext(Col,Row));
    end    {9}
    else
    begin  {10}
    if (Columns.Items[Acol-1].Field as TBooleanField).DisplayValues='' then
     begin  {11}
     Brush.Color:=clWindow;
     Canvas.FillRect(ARect);
     Canvas.pen.Width:=1;
     Canvas.pen.Color:=clBlue;
     Canvas.Polyline([Point(ARect.left+1,ARect.Bottom-1),Point(ARect.Left+1,ARect.Top+1),Point(ARect.left+17,ARect.Top+1)]);
     Canvas.pen.Color:=clBlue;
     Canvas.Polyline([Point(ARect.left+2,ARect.Bottom-2),Point(ARect.Left+2,ARect.Top+2),Point(ARect.left+18,ARect.Top+2)]);
     Canvas.pen.Color:=clWhite;
     Canvas.Polyline([Point(ARect.left+17,ARect.Top+1),Point(ARect.left+17,ARect.Bottom-2),Point(ARect.left+1,ARect.Bottom-2)]);
     Canvas.pen.Color:=clSilver;
     Canvas.Polyline([Point(ARect.left+18,ARect.Top+2),Point(ARect.left+18,ARect.Bottom-1),Point(ARect.left+2,ARect.Bottom-1)]);
     if Columns.Items[Acol-1].Field.AsBoolean then
      begin  {12}
      Canvas.Polyline([Point(ARect.Left+4,ARect.Top+8),Point(ARect.left+6,ARect.Bottom-2)]);
      Canvas.Polyline([Point(ARect.left+6,ARect.Bottom-2),point(ARect.Left+12,ARect.Top+4)]);
      Canvas.Polyline([point(ARect.Left+12,ARect.Top+4),point(ARect.Left+16,ARect.Top+4)]);
      end;   {12}
     end {11}
     else Canvas.TextOut(cellRect(Col,Row).left+2,cellRect(Col,Row).top+2,getEdittext(Col,Row));
    end;  {10}
   end;  {3}
  end;    {2}
 end    {1}
 else
 begin  {13}
 if dgRowSelect in options then
    begin   {14}
     LastRow:=Row;
    Canvas.Pen.Color:=ColorBordure;
    Canvas.Pen.Width:=1;
//    Canvas.Font.Size:=font.size+1;
    Canvas.Font.Size:=font.size;
    Canvas.Font.Color:=Font.color;
    Rect:=Boxrect(1,Row,VisibleColCount,Row);
    Canvas.Polyline([Point(Rect.Left+1,Rect.Top+1),Point(Rect.Right-1,Rect.Top+1),Point(Rect.Right-1,Rect.Bottom-2),point(Rect.Left+1,Rect.Bottom-2)]);
    end;   {14}
 end;   {13}

if editorMode then
if InplaceEditor <> nil then
  if InplaceEditor.Visible then
  begin
  TMyControl(InplaceEditor).Font.size:=font.size+2;
  TMyControl(InplaceEditor).Color:=ColorFocalisation;
  InplaceEditor.Deselect;
  end;
end;

procedure TDBGrid_PM.KeyUp(var Key: Word; Shift: TShiftState);
var
Rect:TRect;
begin
inherited KeyUp(Key,Shift);
if editorMode then
    if InplaceEditor <> nil then
    if InplaceEditor.Visible then begin
                               if Key = VK_RETURN then
                               InplaceEditor.Deselect;
                               TMyControl(InplaceEditor).Font.size:=font.size+2;
                            end;

end;
procedure TDBGrid_PM.KeyDown(var Key: Word; Shift: TShiftState);
//var
//KeyTmp:Word;
//i,TotalLargeur,k:integer;
//auxtmp:string;
begin
//if Ismasked then KeyTmp:=Key;
inherited KeyDown(Key,Shift);
//if Ismasked then Key:=Keytmp;
case Key of
// VK_UP:begin
//         TControl(Owner).Perform(WM_NEXTDLGCTL, -1, 0);
//         key:=0;
//       end;
// VK_DOWN,VK_RETURN:begin
//           TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
//           key:=0;
//         end;
 VK_F1:begin
         if FTPanelAide <> nil then FTPanelAide.loaded;
       end;
 end;
end;
end.
