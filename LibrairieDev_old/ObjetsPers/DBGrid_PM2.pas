unit DBGrid_PM2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids,dbctrls,stdctrls,db;

type
  TInplaceBoolean = class(TInplaceEdit)
    constructor Create (Aowner: TComponent); override;
  end;

  TDBGrid_PM2 = class(TCustomDBGrid)
  private
    { Déclarations privées }
    ChkBox:TCheckBox;
    BChkF:TBitmap;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    property Canvas;
    property SelectedRows;
    constructor Create (Aowner: TComponent); override;
    destructor Destroy; override;
    Procedure DrawDataCell(const Rect: TRect;Field: TField; State: TGridDrawState);override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    Function CreateEditor:TInplaceEdit;override;
  published
    { Déclarations publiées }
    property Align;
    property BorderStyle;
    property Color;
    property Columns stored False; //StoreColumns;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property ImeMode;
    property ImeName;
    property Options;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;  { obsolete }
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnTitleClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PBMA', [TDBGrid_PM2]);
end;

constructor TInplaceBoolean.Create (Aowner: TComponent);
begin
//
end;

constructor TDBGrid_PM2.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
     ChkBox:=TCheckBox.Create(self);
     ChkBox.Visible:=false;
     ChkBox.Parent:=Self;
     BChkF:=TBitmap.Create;
     BChkF.LoadFromFile('C:\Philippe\Composant\Check1.bmp');
//     BChkF.Transparent:=true;
     //ChkBox.BringToFront;
//     FTypeColorFocalisation:=clWindow;
//     FTypeColorBord:=clWindow;
end;

destructor TDBGrid_PM2.Destroy;
begin
     inherited;
end;

Function TDBGrid_PM2.CreateEditor:TInplaceEdit;
begin
if (Columns.Items[col-1].Field.DataType = ftBoolean) then
     begin
     end;
//     else
//inherited;
//
end;

Procedure TDBGrid_PM2.DrawDataCell(const Rect: TRect;Field: TField; State: TGridDrawState);
//var
//Bip:TBitmap;
begin
//Bip.Assign(
//  if (gdFocused in State) then
//  begin
//     if (Field.DataType = ftBoolean) then
//     begin
////     ChkBox:=TCheckBox.Create(self);
////     ChkBox.Visible:=false;
////     ChkBox.Parent:=Self;
////     ChkBox.BringToFront;
//
//       ChkBox.Left := Rect.Left;// + Left + 1;
////       beep;
//       ChkBox.Top := Rect.Top;// + top + 1;
//       ChkBox.Width := Rect.Right - Rect.Left{ - 1};
//       ChkBox.Height := Rect.Bottom - Rect.Top{ - 1};
//       ChkBox.Visible := True;
//
//       ChkBox.PaintTo(Canvas.Handle,Rect.Left,Rect.Top);
////       ChkBox.Visible := False;
//
//     end;
//     end
//     else
//     begin
//       ChkBox.Visible := False;
//       ChkBox.Left := Rect.Left;// + Left + 1;
////       beep;
//       ChkBox.Top := Rect.Top;// + top + 1;
//       ChkBox.Width := Rect.Right - Rect.Left{ - 1};
//       ChkBox.Height := Rect.Bottom - Rect.Top{ - 1};
////       ChkBox.Visible := True;
//
//       ChkBox.PaintTo(Canvas.Handle,Rect.Left,Rect.Top);
//     end;
////
end;
procedure TDBGrid_PM2.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
begin
// inherited DrawCell(Acol,Arow,ARect,AState);
 if (gdFocused in AState) then
  begin
     if (Columns.Items[Acol-1].Field.DataType = ftBoolean) then
     begin
//     ChkBox:=TCheckBox.Create(self);
//     ChkBox.Visible:=false;
//     ChkBox.Parent:=Self;
//     ChkBox.BringToFront;

       ChkBox.Left := ARect.Left;// + Left + 1;
//       beep;
       ChkBox.Top := ARect.Top;// + top + 1;
       ChkBox.Width := ARect.Right - ARect.Left + 1;
       ChkBox.Height := ARect.Bottom - ARect.Top + 1;
       ChkBox.Visible := True;
       ChkBox.SetFocus;

       ChkBox.PaintTo(Canvas.Handle,ARect.Left,ARect.Top);
//       ChkBox.Visible := False;

     end;
     end
     else
     begin
     if (Columns.Items[Acol].Field.DataType = ftBoolean) then
     Canvas.Draw(ARect.Left,ARect.Top,BChkF)
     else
     begin
     inherited DrawCell(Acol,Arow,ARect,AState);
     
     end;
     end;
//
end;

end.
