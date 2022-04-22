unit Edit_PM;

interface

uses
  Windows,Messages,SysUtils,Classes,Graphics,Controls,Forms,Dialogs,
  StdCtrls,Buttons,TypInfo,extctrls;
//  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,PBDate,
//  StdCtrls, Edit_PM, Menus, ExtCtrls, InterBase, DBTables, Db;


type
    TMyCustomControl = class(TCustomControl)
    public
    property Canvas;
    end;
  TTypeDevise = (Frs,Euro,Lire,Livre,Dollars,Mark);
  TTypeDonnees = (Texte,Entier,Date,Monetaire,Decimal);
//  TTypeColorBord = (ClRed,clBlack);
  TEdit_PM = class(TEdit)
  private
    { Déclarations privées }
    FPosChar:integer;
    FTypeColorBord : TColor;
    FTypeColorFocalisation : TColor;
    FTypeDonnees:TTypeDonnees;
    FTypeDevise:TTypeDevise;
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
      procedure KeyPress(var Key: Char); override;
      procedure KeyDown(var Key: Word; Shift: TShiftState);override;
      procedure CreateWnd;override;
//      procedure KeyUp(var Key: Word; Shift: TShiftState);override;

  published
    { Déclarations publiées }
    Property ColorBordure : TColor read FTypeColorBord Write FTypeColorBord Default clWindow;
    Property ColorFocalisation : TColor read FTypeColorFocalisation Write FTypeColorFocalisation Default clWindow;
    Property TypeDevise : TTypeDevise read FTypeDevise Write FTypeDevise;
    Property TypeDonnees : TTypeDonnees read FTypeDonnees Write FTypeDonnees;
    Property PolicePlus : Boolean read FPolicePlus write FPolicePlus;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PBMA', [TEdit_PM]);
end;

constructor TEDit_PM.Create(Aowner: TComponent);
begin
     inherited create(AOwner);
     FTypeColorFocalisation:=clWindow;
     FTypeColorBord:=clWindow;
end;

destructor TEdit_PM.Destroy;
begin
     inherited;
end;

procedure TEdit_PM.CreateWnd;
begin
inherited createWnd;
Text:='';
autoselect:=false;
if ((parent is TForm) and (ColorFocalisation=clWindow)) then FTypeColorFocalisation:=clWindow;
if ((parent is TForm) and (FTypeColorBord=clWindow)) then FTypeColorBord:=(parent as TForm).color;
end;

procedure TEdit_PM.KeyPress(var Key: Char);
var
T:string;
PosC:Integer;
TextLong:boolean;
begin
inherited KeyPress(key);
if Key = #8 then begin
   if length(text)>0 then begin
      PosC:=SelStart;
      T:=text;
     if sellength > 0 then begin
                  Delete(t,selStart+1,sellength);
                   TextLong:=true;
                   end
         else begin
              if SelStart>0 then Delete(t,selStart,1);
              TextLong:=false;
              end;
      Text:=T;
      if TextLong then SelStart:=PosC else SelStart:=PosC-1;
      end;
   Key := #0;
   end;
If (Key = #13) then
        Begin
   	  TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
   	  key:= #0;
        end
        else
        begin
        case TypeDonnees of
             Entier:if not( Key in ['0'..'9']) then
                    begin
                    key:=#0;
                    beep;
                    end;
             Monetaire :begin
                         if not( Key in ['0'..'9',Decimalseparator]) then
                          begin
                          key:=#0;
                          beep;
                          end;
                          if (Key in [DecimalSeparator]) then
                             if Pos(DecimalSeparator,text)>0 then
                                begin
                                key:=#0;
                                beep;
                                end;
//                         Posc:=SelStart;
                         if Pos('Frs',text) = 0 then text:=text+'  Frs';
                        end;
        end;

     end;
end;

//procedure TEdit_PM.KeyUp(var Key: Word; Shift: TShiftState);
//begin
//inherited KeyUp(Key,Shift);
//end;

procedure TEdit_PM.KeyDown(var Key: Word; Shift: TShiftState);
begin
inherited KeyDown(Key,Shift);
case Key of
 VK_UP:begin
         TControl(Owner).Perform(WM_NEXTDLGCTL, -1, 0);
         key:=0;
       end;
 VK_DOWN:begin
           TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
           key:=0;
         end;
 VK_RIGHT:begin
           if TypeDonnees in [Monetaire] then
            if SelStart > length(text)-6 then
               begin
               key:=0;
               beep;
               end;
          end;
 VK_END:if TypeDonnees in [Monetaire] then
        begin
          key:=0;
          SelStart:=length(text)-5;
        end;
 VK_DELETE:if TypeDonnees in [Monetaire] then
           begin
          if SelStart> length(text)-6 then
               begin
               key:=0;
               beep;
               end;
        end;
 end;
end;

procedure TEdit_PM.CMEnter(var Message: TCMEnter);
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
case TypeDonnees of
     Monetaire :if length(text)=0 then
                begin
                 if Pos('Frs',text) = 0 then
                   text:=text+'  Frs';
//                SelStart:=0;
                end;
     end;
//FPosChar:=SelStart;
end;

procedure TEdit_PM.CMExit(var Message: TCMExit);
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

procedure TEdit_PM.CWPaint(var Message: TWMPaint);
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
case TypeDonnees of
     Monetaire :if length(text)=0 then
                begin
                 if Pos('Frs',text) = 0 then
                   text:=text+'  Frs';
//                SelStart:=0;
                end;
     end;

end;
end.
