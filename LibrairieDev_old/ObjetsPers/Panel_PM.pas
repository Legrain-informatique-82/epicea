unit Panel_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
    TMyCustomControl = class(TCustomControl)
    public
    property Canvas;
    end;

  TPanel_PM = class(TPanel)
  private
    { Déclarations privées }
    FTypeColorBord : TColor;
    FTypeColorFocalisation : TColor;
    Color1: TColor;
    FPolicePlus:boolean;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    Procedure CWPaint(var Message:TWMPaint);message WM_PAINT;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
      procedure KeyDown(var Key: Word; Shift: TShiftState);override;
  published
    { Déclarations publiées }
    Property ColorBordure : TColor read FTypeColorBord Write FTypeColorBord Default clWindow;
    Property ColorFocalisation : TColor read FTypeColorFocalisation Write FTypeColorFocalisation Default clWindow;
    Property PolicePlus : Boolean read FPolicePlus write FPolicePlus;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PBMA', [TPanel_PM]);
end;

constructor TPanel_PM.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
     FTypeColorFocalisation:=clWindow;
     FTypeColorBord:=clWindow;
end;

destructor TPanel_PM.Destroy;
begin
     inherited;
end;

procedure TPanel_PM.KeyDown(var Key: Word; Shift: TShiftState);
begin
//beep;
inherited KeyDown(Key,Shift);
//case Key of
// VK_LEFT:begin
//         TControl(Owner).Perform(WM_NEXTDLGCTL, -1, 0);
//         key:=0;
//       end;
// VK_RIGHT:begin
//           TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
//           key:=0;
//         end;
// end;
end;

procedure TPanel_PM.CMEnter(var Message: TCMEnter);
Begin
     inherited;
     Color1 := Color;
     Color := ColorFocalisation;
     Canvas.pen.Color:=ColorBordure;
     Canvas.Pen.Width:=5;
     Canvas.Rectangle(0,0,Width,Height);
//     if (parent is TPanel) then begin
//               TMyCustomControl(Parent).Canvas.Pen.Color:=ColorBordure;
//               TMyCustomControl(Parent).Canvas.Pen.Width:=5;
//               TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
//               if FPolicePlus then Font.Size:=Font.size+3;
//     end;
//     if (parent is TForm) then begin
//               (parent as TForm).Canvas.Pen.Color:=ColorBordure;
//               (parent as TForm).Canvas.Pen.Width:=5;
//               (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
//               if FPolicePlus then Font.Size:=Font.size+3;
//     end;
end;

procedure TPanel_PM.CMExit(var Message: TCMExit);
begin
     inherited;
     Color :=  Color1;
     Refresh;
//     Canvas.pen.Color:=(parent as TForm).Color;
//     Canvas.Pen.Width:=5;
//     Canvas.Rectangle(0,0,Width,Height);
//     if (parent is TPanel) then begin
//               TMyCustomControl(Parent).Canvas.Pen.Color:=TMyCustomControl(Parent).Color;
//               TMyCustomControl(Parent).Canvas.Pen.Width:=5;
//               TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
//               if FPolicePlus then Font.Size:=Font.size-3;
//     end;
//     if (parent is TForm) then begin
//               (parent as TForm).Canvas.Pen.Color:=(parent as TForm).Color;
//               (parent as TForm).Canvas.Pen.Width:=5;
//               (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
//               if FPolicePlus then Font.Size:=Font.size-3;
//     end;
End;

procedure TPanel_PM.CWPaint(var Message: TWMPaint);
Begin
     inherited;
     if focused then
      begin
     Canvas.pen.Color:=ColorBordure;
     Canvas.Pen.Width:=5;
     Canvas.Rectangle(0,0,Width,Height);
//     Canvas.Rectangle(left+1,top+1,left+Width+1,top+Height+1);
//   Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
//   //  if (parent is TPanel) then
//        begin
//         TMyCustomControl(Parent).Canvas.Pen.Color:=ColorBordure;
//         TMyCustomControl(Parent).Canvas.Pen.Width:=5;
//         TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
//        end;
//       if (parent is TForm) then
//        begin
//         (parent as TForm).Canvas.Pen.Color:=ColorBordure;
//         (parent as TForm).Canvas.Pen.Width:=5;
//         (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
//        end;
//
 end;
end;

end.
