unit MainMenu_PM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;

type
  TRxMenuStyle = (msStandard, msOwnerDraw {$IFDEF WIN32}, msBtnLowered,
    msBtnRaised {$ENDIF});
  TMainMenu_PM = class(TMainMenu)
  private
    { Déclarations privées }
    FStyle: TRxMenuStyle;
    FTypeColorBord : TColor;
    FTypeColorFocalisation : TColor;
    Procedure CWINITM(var Message:TWMINITMENU);message WM_DRAWITEM;
//    procedure SetStyle(Value: TRxMenuStyle);
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
//    procedure WmMeasureItem(var msg:TWmMeasureItem);message wm_MeasureItem;
      constructor Create (Aowner: TComponent); override;
//      procedure WndProc(var Mes: TMessage); override;
      destructor Destroy; override;
  published
    { Déclarations publiées }
    Property ColorBordure : TColor read FTypeColorBord Write FTypeColorBord Default clWindow;
    Property ColorFocalisation : TColor read FTypeColorFocalisation Write FTypeColorFocalisation Default clWindow;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PBMA', [TMainMenu_PM]);
end;

constructor TMainMenu_PM.Create(Aowner: TComponent);
var
rec:TRect;
msg:TMessage;
begin
     inherited create(AOwner);

//     msg.Msg:=WM_INITMENU;
//     msg.LParam:=handle;
//     Dispatch(msg);
     //     rec:=CreationControl.BoundsRect;

//     rec:=Bounds(0,0,50,25);
//     DrawFrameControl(Handle,rec,0,0);
//     beep;
end;

//procedure TMainMenu_PM.WndProc(var Mes: TMessage);
//begin
//inherited WndProc(mes);;
//case Mes.Msg of
//     WM_DRAWITEM:beep;
//     end;
//end;
destructor TMainMenu_PM.Destroy;
begin
     inherited;
end;
//procedure TMainMenu_PM.WmMeasureItem(var msg:TWmMeasureItem);
Procedure TMainMenu_PM.CWINITM(var Message:TWMINITMENU);
begin
beep;
end;
end.
