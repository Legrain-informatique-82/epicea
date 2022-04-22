unit Button_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,extctrls;

type
    TMyCustomControl = class(TCustomControl)
    public
    property Canvas;
    end;

  TButton_PM = class(TButton)
  private
    { Déclarations privées }
    FTypeColorBord : TColor;
    FTypeColorFocalisation : TColor;
    Color1: TColor;
    FPolicePlus:boolean;
    { Déclarations privées }
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    Procedure CWPaint(var Message:TWMPaint);message WM_PAINT;
  protected
    { Déclarations protégées }
      constructor Create (Aowner: TComponent); override;
      destructor Destroy; override;
//      procedure KeyDown(var Key: Word; Shift: TShiftState);override;
      procedure CreateWnd;override;
  public
    { Déclarations publiques }
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
  RegisterComponents('PBMA', [TButton_PM]);
end;

constructor TButton_PM.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
     FTypeColorFocalisation:=clWindow;
     FTypeColorBord:=clWindow;
end;

destructor TButton_PM.Destroy;
begin
     inherited;
end;

procedure TButton_PM.CreateWnd;
begin
inherited createWnd;
//Text:='';
if ((parent is TForm) and (ColorFocalisation=clWindow)) then FTypeColorFocalisation:=clWindow;
if ((parent is TForm) and (FTypeColorBord=clWindow)) then FTypeColorBord:=(parent as TForm).color;
end;

//procedure TMaskEdit_PM.KeyDown(var Key: Word; Shift: TShiftState);
//begin
//case Key of
// VK_UP:begin
//         TControl(Owner).Perform(WM_NEXTDLGCTL, -1, 0);
//         key:=0;
//       end;
// VK_DOWN:begin
//           TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
//           key:=0;
//         end;
// end;
//inherited KeyDown(Key,Shift);
//end;

procedure TButton_PM.CMEnter(var Message: TCMEnter);
Begin
     inherited;
     Color1 := Color;
     Color := ColorFocalisation;
     if (parent is TPanel) then begin
               TMyCustomControl(Parent).Canvas.Pen.Color:=ColorBordure;
               TMyCustomControl(Parent).Canvas.Pen.Width:=5;
               TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
               if FPolicePlus then Font.Size:=Font.size+3;
     end;
     if (parent is TForm) then begin
               (parent as TForm).Canvas.Pen.Color:=ColorBordure;
               (parent as TForm).Canvas.Pen.Width:=5;
               (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
               if FPolicePlus then Font.Size:=Font.size+3;
     end;
end;

procedure TButton_PM.CMExit(var Message: TCMExit);
begin
     inherited;
     Color :=  Color1;
     if (parent is TPanel) then begin
               TMyCustomControl(Parent).Canvas.Pen.Color:=TMyCustomControl(Parent).Color;
               TMyCustomControl(Parent).Canvas.Pen.Width:=5;
               TMyCustomControl(Parent).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
               if FPolicePlus then Font.Size:=Font.size-3;
     end;
     if (parent is TForm) then begin
               (parent as TForm).Canvas.Pen.Color:=(parent as TForm).Color;
               (parent as TForm).Canvas.Pen.Width:=5;
               (parent as TForm).Canvas.Rectangle(left-1,top-1,left+Width+1,top+Height+1);
               if FPolicePlus then Font.Size:=Font.size-3;
     end;
End;

procedure TButton_PM.CWPaint(var Message: TWMPaint);
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
      end;

end;
end.
