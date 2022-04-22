{***************************************************************
 *
 * Unit Name: GestRes
 * Purpose  :
 * Author   :  BP
 * History  :
 *
 ****************************************************************}

unit GestRes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Menus,E2_Main;

function OuvreResMenu( NomFic : string ; var Composant:TMainMenu):boolean;
function CopyMenu(MenuOrg : TMainMenu ;MenuP:TMainMenu; NomNewMenu:string):TMainMenu;

implementation

const
   Repert_defaut='C:\Philippe\GestMenu\';

function OuvreResMenu( NomFic : string ; var Composant : TMainMenu):boolean;
var
   Repert_EnCours:string;
begin
GetDir(0,Repert_EnCours);
If (Repert_defaut <> Repert_EnCours )then
		if FileExists(Repert_EnCours+'\PMenu.res') then begin
			ReadComponentResFile(Repert_EnCours+'\PMenu.res',Composant );
			result:=true;
         end
   	else result:=false
   else
   if FileExists(Repert_defaut+'PMenu.res') then begin
         ReadComponentResFile(Repert_defaut+'PMenu.res',Composant );
   result:=true;
	end
   	else result:=false;
end;

function CopyMenu(MenuOrg : TMainMenu ;MenuP:TMainMenu; NomNewMenu:string):TMainMenu;
var
   i:integer;
   ComposantM,ComposantF:TComponent;
   MItem,OrgItem:TMenuItem;
begin
	for i:=1 to MenuP.componentcount-1 do begin
      ComposantM:=MenuP.Components[i];
      ComposantF:=Main.FindComponent(ComposantM.Name);
      OrgItem:=(ComposantF as TMenuItem);
      MItem:=(ComposantM as TMenuItem);
      MItem.OnClick:=OrgItem.OnClick;
   end;
   result:=MenuP;
end;
end.
