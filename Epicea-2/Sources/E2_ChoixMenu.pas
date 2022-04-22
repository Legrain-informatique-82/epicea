{***************************************************************
 *
 * Unit Name: E2_ChoixMenu
 * Purpose  :
 * Author   : PB
 * History  :
 *
 ****************************************************************}

unit E2_ChoixMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, checklst, ComCtrls,Menus, ExtCtrls;

type
  TChMenu = class(TForm)
    CheckListBox1: TCheckListBox;
    TreeView1: TTreeView;
    ImageList1: TImageList;
    Edit1: TEdit;
    Button4: TButton;
    MenuDef: TButton;
    procedure FormShow(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Edit1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CheckListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure MenuDefClick(Sender: TObject);
  private
    { Déclarations privées }
    procedure InitMenuListe;
  public
    { Déclarations publiques }
  end;


  TListe= ^AEnr;

  	AEnr = Record
  	ItemIDL:TTreeNode;
   Deplace:boolean;
   HandelM:integer;
   Nom : String[30];
   end;

function ChercheNoeud(Noeud : TTreeNode):Integer;

var
  ChMenu: TChMenu;
  Liste: TList;
  Enreg : TListe;
implementation

uses E2_Main, GestRes;

{$R *.DFM}


procedure TChMenu.CheckListBox1ClickCheck(Sender: TObject);

var
Numenu:integer;
begin

  Numenu:=CheckListBox1.ItemIndex;

case Numenu of
   4: if CheckListBox1.State[numenu] = cbGrayed then
   	CheckListBox1.State[Numenu] := cbGrayed;

{   	TreeView1.Items.addChild(TreeView1.Items[0],CheckListBox1.Items[1]);
{   : ;}
end;

end;




procedure TChMenu.TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  AnItem, ItemSelectionne: TTreeNode;
  AttachMode: TNodeAttachMode;
  HT: THitTests;
begin

  if TreeView1.Selected = nil then Exit;
  HT := TreeView1.GetHitTestInfoAt(X, Y);
  AnItem := TreeView1.GetNodeAt(X, Y);
  ItemSelectionne:=TreeView1.Selected;
if ItemSelectionne.Level > 0 then begin
  if ((HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) and (AnItem.Count>0)) then
  begin
    if (htOnItem in HT) or (htOnIcon in HT) then AttachMode := naAddChildFirst
    else if htNowhere in HT then AttachMode := naAdd
    else if htOnIndent in HT then AttachMode := naInsert
    else AttachMode := naInsert;	//BR à voir
    TreeView1.Selected.MoveTo(AnItem, AttachMode);
    Enreg:=Liste.Items[ChercheNoeud(ItemSelectionne)];
    Enreg^.Deplace:=true;
  end;
	if ((HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) and (AnItem.Count=0) and (AnItem.level>0)) then
		begin
			TreeView1.Selected.MoveTo(AnItem, NaInsert);
    Enreg:=Liste.Items[ChercheNoeud(ItemSelectionne)];
	Enreg^.Deplace:=true;
      end;
  if ((HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) and (AnItem.Count=0)and (AnItem.level=0)) then
  begin
    if (htOnItem in HT) or (htOnIcon in HT) then AttachMode := naAddChildFirst
    else AttachMode := naInsert;	//BR à voir

    TreeView1.Selected.MoveTo(AnItem, AttachMode);
    Enreg:=Liste.Items[ChercheNoeud(ItemSelectionne)];
    Enreg^.Deplace:=true;
  end;
end

else
beep
end;
//******************* TChMenu.TreeView1DragOver *************************
procedure TChMenu.TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
Accept := ((Source is TTreeView) or (Source is TCheckListBox));
end;

procedure TChMenu.Edit1Change(Sender: TObject);
begin
if Edit1.Text='111' then CheckListBox1.Enabled:=true;
end;

procedure TChMenu.Button4Click(Sender: TObject);
var
   i:integer;
   NoeudEnCours,PereNoeud:TTreeNode;
   NouvItem, OldItem, Perenouv,PereAnc : TMenuItem;
   //Change : boolean;
begin
   for i:=0 to Liste.Count-1 do begin
      Enreg:=Liste.items[i];
      if Enreg^.Deplace = True then begin
         OldItem:=Main.Menu.FindItem(Enreg^.HandelM,fkHandle);
         PereAnc:=OldItem.Parent;
         NouvItem:=NewItem(OldItem.caption,OldItem.ShortCut,OldItem.Checked,OldItem.Enabled,
				OldItem.Onclick,OldItem.helpcontext,OldItem.Name);
         NoeudEnCours:=Enreg^.ItemIDL;
         PereNoeud:=NoeudEnCours.Parent;
         Enreg:=Liste.Items[ChercheNoeud(PereNoeud)];
         PereNouv:=Main.Menu.FindItem(Enreg^.HandelM,fkHandle);
         PereAnc.Delete(OldItem.MenuIndex);
         PereNouv.Insert(NoeudEnCours.Index,NouvItem);
      end;
   end;
   WriteComponentResfile('PMenu.res',Main.Menu);
end;
//******************* TChMenu.CheckListBox1DrawItem *************************
procedure TChMenu.CheckListBox1DrawItem(Control: TWinControl;
	Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
	if CheckListBox1.State[Index] = cbGrayed then CheckListBox1.State[Index] := cbGrayed;
end;
//******************* TChMenu.CheckListBox1MouseDown *************************
procedure TChMenu.CheckListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
Numenu:integer;
begin

  Numenu:=CheckListBox1.ItemIndex;

case Numenu of
   4: if CheckListBox1.State[numenu] = cbGrayed then begin
   	//CheckListBox1.State[Numenu] := cbGrayed;
   	if CheckListBox1.State[numenu] = cbGrayed then beep
      end;

{   	TreeView1.Items.addChild(TreeView1.Items[0],CheckListBox1.Items[1]);
{   : ;}
end;

end;

procedure TChMenu.FormDestroy(Sender: TObject);
begin
Liste.Free;
ChMenu:=nil;
Beep;
end;

function ChercheNoeud(Noeud : TTreeNode):Integer;
var
	i : integer;
begin
	i:=-1;
	repeat
   i:=i+1;
   Enreg:=Liste.Items[i];
   until Enreg^.ItemIDL = Noeud;
result:=i;
end;

procedure TChMenu.InitMenuListe;
//*******************************************************************
// Renvoi vrai si l'item en cours est un père
Function MenuItemPere(ItemEnCours : TMenuItem):boolean;
begin
if ItemEnCours.Count>0 then result:=true else result:=false;
end;
//*******************************************************************
// Passe du père vers le fils
Function PereVersFils(ItemEnCours : TMenuItem):TMenuItem;
begin
result:=ItemEnCours.Items[0];
end;
//*******************************************************************
// Passe du fils vers le père
Function FilsVersPere(ItemEnCours : TMenuItem):TMenuItem;
begin
result:=ItemEnCours.Parent;
end;
//*******************************************************************
// Renvoi vrai si dernier élément du menu
function DernierFils(ItemEnCours : TMenuItem):boolean;
Begin
if ItemEnCours.Parent.count - 1 = ItemEnCours.MenuIndex then
		result:=true else result:=false;
end;
//*******************************************************************
// Passe au frère suivant s'il existe, sinon ne bouge pas
Function FrereSuivant(ItemEnCours : TMenuItem):TMenuItem;
begin
if not DernierFils(ItemEnCours) then
		result:=ItemEnCours.Parent.Items[ItemEnCours.MenuIndex+1]
else
		result:=ItemEnCours;
end;
//*******************************************************************
// Parcours la partie de menu situé sous le menu principal
function ParcoursMenu(ItemEnCours : TMenuItem ;var niveau : Integer; MainItem : TMenuItem ):TMenuItem;

begin
if not DernierFils(ItemEnCours) then begin
	if MenuItemPere(ItemEnCours) then begin
		ItemEnCours:=PereVersFils(ItemEnCours);
		niveau:=niveau + 1
   end
   else begin
		ItemEnCours:=FrereSuivant(ItemEnCours)
   end
end
else begin
	if MenuItemPere(ItemEnCours) then begin
		ItemEnCours:=PereVersFils(ItemEnCours);
		niveau:=niveau + 1
   end
   else begin
   	while (DernierFils(ItemEnCours) and (ItemEnCours <> MainItem)) do begin
			ItemEnCours:=FilsVersPere(ItemEnCours);
      	niveau:=niveau - 1;
      end;
      if (not DernierFils(ItemEnCours) and (ItemEnCours <> MainItem)) then begin
      	ItemEnCours:=FrereSuivant(ItemEnCours)
      end
   end;
end;
if ItemEnCOurs=FrereSuivant(MainItem) then result:=MainItem else
result:=ItemEnCours;
end;
//*******************************************************************
// Rempli une Treeview avec l'arborescence d'un menu
var
  Noeud: TTreeNode;
  i,j,n:integer;
  k:TMenuItem;
//  MenuEnCours:TMainMenu;
begin
TreeView1.Items.clear;
n:=Main.Menu.Items.Count-1;

Liste:=TList.Create;

for j:=0 to n do begin

	k:=Main.Menu.Items[j];
   noeud:=TreeView1.Items.add(nil,k.Caption);
   Noeud.ImageIndex:=1;

   i:=0;


	repeat
   new(Enreg);
   Enreg^.ItemIDL:=TreeView1.Items.GetNode(Noeud.ItemId);
	Enreg^.Deplace:=false;
   Enreg^.Nom:=Noeud.Text;
   Enreg^.HandelM:=k.Handle;
	Liste.add(Enreg);

   k:=ParcoursMenu(k,i,Main.Menu.Items[j]);




   if k<> Main.Menu.Items[j] then

   begin
   if  i > Noeud.level then begin
		Noeud:=TreeView1.Items.addchild(Noeud,k.Caption);
      if MenuItemPere(k) then begin
//      			Noeud.ImageIndex:=1;
            	Noeud.DropTarget:=true;
            end else begin
//            	Noeud.ImageIndex:=2;
               Noeud.DropTarget:=false;
               end;
      end
   else
		if i = Noeud.level then begin
      	Noeud:=TreeView1.Items.add(Noeud,k.Caption);
      if MenuItemPere(k) then begin
//      			Noeud.ImageIndex:=1;
            	Noeud.DropTarget:=true;
            end else begin
//            	Noeud.ImageIndex:=2;
               Noeud.DropTarget:=false;
               end;
         end
   	else
   		if i < Noeud.Level then
         begin
   			while i < Noeud.level do Noeud := Noeud.parent;
         	Noeud:=TreeView1.Items.add(Noeud,k.Caption);
      if MenuItemPere(k) then begin
//      			Noeud.ImageIndex:=1;
            	Noeud.DropTarget:=true;
            end else begin
//            	Noeud.ImageIndex:=2;
               Noeud.DropTarget:=false;
               end;
         end;
	end;

   until k = Main.Menu.Items[j];
   end;
end;



procedure TChMenu.Formshow(Sender: TObject);
var
  i:integer;

begin
top:=Main.top + 44 ;
left:=Main.left + 4;
Height:=Main.Height-50;
Width:=Main.Width-8;
color:=Main.color;
CheckListBox1.Enabled:=false;
for i:=0 to 5 do begin
		CheckListBox1.Items.add('Option '+ IntToStr(i));
//		CheckListBox1.Items:=false;
		if (i mod 2 = 0) then CheckListBox1.State[i] := cbGrayed;
	end;
InitMenuListe;
end;

procedure TChMenu.FormDeactivate(Sender: TObject);
begin

ChMenu.free;
end;

procedure TChMenu.MenuDefClick(Sender: TObject);
begin
{Liste.Free;
main.Menu.free;
MenuP := TMainMenu.create(Main);
ReadComponentResFile('MOrg',MenuP );
MenuP:=CopyMenu(Main.MenuMain,MenuP,'MenuP');
Main.Menu:=MenuP;

InitMenuListe;}
end;

end.
