unit CustomStaticText_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,extctrls;

type
    TMyCustomControl = class(TCustomControl)
    public
    property Canvas;
    end;

  TCustomStaticText_PM = class(TStaticText)
  private
    { Déclarations privées }
    STCanvas:TCanvas;
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
//      procedure KeyPress(var Key: Char); override;
      procedure KeyDown(var Key: Word; Shift: TShiftState);override;
  published
    { Déclarations publiées }
    Property ColorBordure : TColor read FTypeColorBord Write FTypeColorBord Default clWindow;
    Property ColorFocalisation : TColor read FTypeColorFocalisation Write FTypeColorFocalisation Default clWindow;
    Property PolicePlus : Boolean read FPolicePlus write FPolicePlus;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PBMA', [TCustomStaticText_PM]);
end;

constructor TCustomStaticText_PM.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
     FTypeColorFocalisation:=clWindow;
     FTypeColorBord:=clWindow;
end;

destructor TCustomStaticText_PM.Destroy;
begin
     inherited;
     STCanvas.Free;
end;

procedure TCustomStaticText_PM.KeyDown(var Key: Word; Shift: TShiftState);
begin
case Key of
 VK_UP:begin
         TControl(Owner).Perform(WM_NEXTDLGCTL, -1, 0);
         key:=0;
       end;
 VK_DOWN:begin
           TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
           key:=0;
         end;
 end;
inherited KeyDown(Key,Shift);

end;
procedure TCustomStaticText_PM.CMEnter(var Message: TCMEnter);
Begin
     inherited;
     if STCanvas=nil then begin
     STCanvas:=TCanvas.Create;
     STCanvas.Handle:=Handle;
     end;
     Color1 := Color;
     Color := ColorFocalisation;
     STCanvas.Pen.Color:=ColorBordure;
     STCanvas.Pen.Width:=2;
     STCanvas.Rectangle(1,1,Width-1,Height-1);
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

procedure TCustomStaticText_PM.CMExit(var Message: TCMExit);
begin
     inherited;
     Color :=  Color1;
     refresh;
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

procedure TCustomStaticText_PM.CWPaint(var Message: TWMPaint);
Begin
     inherited;
     if focused then
      begin
     if STCanvas=nil then begin
     STCanvas:=TCanvas.Create;
     STCanvas.Handle:=Handle;
     end;
     STCanvas.Pen.Color:=ColorBordure;
     STCanvas.Pen.Width:=2;
     STCanvas.Rectangle(1,1,Width-1,Height-1);
//       if (parent is TPanel) then
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
      end;
end;

end.
