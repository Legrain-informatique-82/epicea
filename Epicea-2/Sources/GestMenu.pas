{***************************************************************
 *
 * Unit Name: GestMenu
 * Purpose  :
 * Author   :  BP
 * History  :
 *
 ****************************************************************}

unit GestMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,GestRes;

type
  TE2_GestMenu = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  E2_GestMenu: TE2_GestMenu;

implementation

{$R *.DFM}

procedure TE2_GestMenu.FormCreate(Sender: TObject);
var
	MenuCourant :TMainMenu;
begin
MenuCourant := TMainMenu.create(Self);
if OuvreResMenu('PMenu.res',MenuCourant) then Menu:=MenuCourant;
end;

end.
