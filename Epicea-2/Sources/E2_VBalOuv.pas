unit E2_VBalOuv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, gr_Librairie_obj, Buttons,DMBalances, Grids,
  AdvGrid, Mask, ToolEdit, CurrEdit, ComCtrls, RXSplit, ExtCtrls, RXCtrls;

type
  TVBalOuv = class(TForm)
    Panel2: TPanel;
    Panel5: TPanel;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Patitre: TPanel;
    Panel3: TPanel;
    AdvStringGrid1: TAdvStringGrid;
    RxSplitter1: TRxSplitter;
    Panel4: TPanel;
    Panel6: TPanel;
    Button1: TButton;
    CurrencyEdit1: TCurrencyEdit;
    GridBal: TAdvStringGrid;
    Panel7: TPanel;
    LaEmprunts: TRxLabel;
    Shape1: TShape;
    LaStocks: TRxLabel;
    LaChPayer: TRxLabel;
    LaPRecevoir: TRxLabel;
    LabChRepartir: TRxLabel;
    LaChConstatees: TRxLabel;
    LaPConstates: TRxLabel;
    LaProvisions: TRxLabel;
    procedure Calculatrice1Click(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pmMenu1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AdvStringGrid1CanEditCell(Sender: TObject; aRow,
      aCol: Integer; var canedit: Boolean);
    procedure AdvStringGrid1CheckBoxClick(Sender: TObject; aCol,
      aRow: Integer; state: Boolean);
    procedure LaEmpruntsClick(Sender: TObject);
    procedure PositionShape(sender: TObject);
    procedure LabGras(sender: TObject);
    procedure LabNonGras(sender: TObject);
    Procedure ChangePatitre(sender:TObject);
    Procedure FormateListe(var Liste:TStringList;colTot,ITotal,ISomme:integer);
    procedure LaStocksClick(Sender: TObject);
    procedure LaPRecevoirClick(Sender: TObject);
    procedure LaChPayerClick(Sender: TObject);
    procedure LabChRepartirClick(Sender: TObject);
    procedure LaChConstateesClick(Sender: TObject);
    procedure LaPConstatesClick(Sender: TObject);
    procedure LaProvisionsClick(Sender: TObject);
    procedure AdvStringGrid1ContractNode(Sender: TObject; arow,
      arowreal: Integer);
    procedure AdvStringGrid1ExpandNode(Sender: TObject; arow,
      arowreal: Integer);
    procedure AdvStringGrid1GetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure initGrille(sender : TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  VBalOuv: TVBalOuv;
  ListeTotaux,ListeIndex:TstringList;
  NombreCol,ColASomme,IndexTotal,IndexSomme:integer;
implementation
{$R *.DFM}
Uses E2_Librairie_obj, Gr_Calculatrice {DMOuverture{, DMdtock};

procedure TVBalOuv.Calculatrice1Click(Sender: TObject);
begin
	AfficheCalculatrice(ActiveControl);
end;

procedure TVBalOuv.Fermer1Click(Sender: TObject);
begin
	Self.Close;
end;

procedure TVBalOuv.FormCreate(Sender: TObject);
begin
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poDesigned;
	Left:= 0; Top:= 70; Width:= screen.Width; Height:= screen.Height-top;
    end;
   ListeTotaux:=TstringList.Create;
   ListeIndex:=TstringList.Create;
   LaEmpruntsClick(LaEmprunts);
//   LaStocksclick(LaStocks);
//   AdvStringGrid1.AutoSize:=true;
end;

procedure TVBalOuv.FormDestroy(Sender: TObject);
begin
  	DestroyForm(Self,);
   ListeTotaux.Free;
   ListeIndex.free;
end;

procedure TVBalOuv.FormKeyPress(Sender: TObject; var Key: Char);
begin
	if Key = #27 then begin
   	Key:= #0;
      Self.Close;
   end;
end;

procedure TVBalOuv.pmMenu1Click(Sender: TObject);
begin
	PopupMenu1.Popup(Left + 50, Top + 50);
end;

procedure TVBalOuv.Button1Click(Sender: TObject);
begin
DMBalance.MiseAJourBalanceEntiere;
end;

procedure TVBalOuv.AdvStringGrid1CanEditCell(Sender: TObject; aRow,
  aCol: Integer; var canedit: Boolean);
begin
if aCol = NombreCol+1 then
   begin
    if AdvStringGrid1.HasCheckBox(aCol,aRow) then
   canedit:=true
   else canedit:=false;
   end
else canedit:=false;
end;

procedure TVBalOuv.AdvStringGrid1CheckBoxClick(Sender: TObject; aCol,
  aRow: Integer; state: Boolean);
var
i:integer;
Etat:boolean;
Total:Currency;
begin
Total:=0;
CurrencyEdit1.Value:=0;
Etat:=true;
i:=ARow;
while AdvStringGrid1.HasCheckBox(NombreCol+1,i) do
      begin
       AdvStringGrid1.GetCheckBoxState(aCol,i,etat);
         if etat then
         Total:=Total+AdvStringGrid1.CellToReal(ColASomme,i);
       dec(i);
      end;
i:=ARow;
inc(i);
while AdvStringGrid1.HasCheckBox(NombreCol+1,i) do
      begin
       AdvStringGrid1.GetCheckBoxState(aCol,i,etat);
        if etat then
        Total:=Total+AdvStringGrid1.CellToReal(ColASomme,i);
       inc(i);
      end;
AdvStringGrid1.Cells[ColASomme,i]:=CurrToStr(Total);
//for i:=1 to AdvStringGrid1.Cols[1].Count - 1 do
//   begin
//   AdvStringGrid1.GetCheckBoxState(aCol,i,etat);
//    if etat then
//       CurrencyEdit1.Value:=CurrencyEdit1.Value+AdvStringGrid1.CellToReal(4,i);
//    end;
end;

procedure TVBalOuv.LabGras(sender: TObject);
begin
(sender as TRxLabel).Font.Style:=(sender as TRxLabel).Font.Style + [fsBold];
(sender as TRxLabel).Cursor:=crHandPoint;
end;

procedure TVBalOuv.LabNonGras(sender: TObject);
begin
(sender as TRxLabel).Font.Style:=(sender as TRxLabel).Font.Style - [fsBold];
(sender as TRxLabel).Cursor:=crDefault;
end;

Procedure TVBalOuv.ChangePatitre(sender:TObject);
var
Titre:string;
i:integer;
begin
Titre:=(sender as TRxLabel).caption;
i:=pos(#$D#$A,Titre);
if i > 0 then
   begin
   delete(Titre,i,2);
   insert(' ',Titre,i);
   end;
Patitre.Caption:=Titre;
end;

procedure TVBalOuv.PositionShape(sender: TObject);
begin
With (sender as TRxLabel)
     do begin
     Shape1.Left:=7;
     Shape1.top:=Top-5;
     Shape1.Height:=Height+8;
     Shape1.Width:=Width+9;
     end;
end;

procedure TVBalOuv.initGrille(sender : TObject);
var
i,j:integer;
begin
//AdvStringGrid1.RemoveRows(1,AdvStringGrid1.RowCount-1);
//AdvStringGrid1.RowHeaders.Clear;
//AdvStringGrid1.ClearCols(1,AdvStringGrid1.ColCount-1);
//AdvStringGrid1.ColCount:=NombreCol+2;
for j:=1 to AdvStringGrid1.RowCount-1 do
    for i:=1 to AdvStringGrid1.ColCount-1 do
      if AdvStringGrid1.HasCheckBox(i,j) then AdvStringGrid1.RemoveCheckBox(i,j);
AdvStringGrid1.ClearRows(1,AdvStringGrid1.RowCount-1);
//AdvStringGrid1.RemoveRows(1,AdvStringGrid1.RowCount);
AdvStringGrid1.RowHeaders.Clear;
//AdvStringGrid1.
AdvStringGrid1.ClearCols(1,AdvStringGrid1.ColCount-1);
// showmessage(inttostr(AdvStringGrid1.RowCount));
//AdvStringGrid1.ColCount:=NombreCol+2;
end;

Procedure TVBalOuv.FormateListe(var Liste:TStringList;colTot,ITotal,ISomme:integer);
var
i,j,k,l,m:integer;
ListeAux:TStringList;
TotalCpt:currency;
begin
ListeAux:=TStringList.create;
ListeAux.Clear;
ListeAux.add(Liste.Strings[0]);
if Liste.Count>1 then
  begin
   j:=0;
   TotalCpt:=0;
   for i:=1 to Liste.Count -1 do
       begin
        inc(j);
        if TotalCpt=0 then
           begin
           ListeTotaux.Add(Liste.Strings[i]);
           ListeIndex.add(inttostr(j));
           end;
        ListeAux.Add(Liste.Strings[i]);
        TotalCpt:=strtocurr(GetStringElement(Liste[i],coltot,';'))+TotalCpt;
        if i < Liste.Count-1 then
          begin
           if GetStringElement(ListeAux[j],1,';') <> GetStringElement(Liste[i+1],1,';') then
              begin
               ListeTotaux.Add('');
               Listeaux.Add('');
               l:=ListeTotaux.Count-1;
               m:=Listeaux.Count-1;
               for k:=1 to NombreCol-1 do
                begin
//                if k = 1 then then ListeTotaux.Add(GetStringElement(Liste[i],1,';');
                if k = 1 then
                   begin
                   ListeTotaux[l]:=ListeTotaux[l]+GetStringElement(Liste[i],1,';')+';';
                   Listeaux[m]:=Listeaux[m]+GetStringElement(Liste[i],1,';')+';';
                   end;
                if k = ITotal then
                   begin
                   ListeTotaux[l]:=ListeTotaux[l]+'Total du Compte;';
                   Listeaux[m]:=Listeaux[m]+'Total du Compte;';
                   end;
                if k = ISomme-1 then
                   begin
                   ListeTotaux[l]:=ListeTotaux[l]+CurrToStr(TotalCpt)+';';
                   Listeaux[m]:=Listeaux[m]+CurrToStr(TotalCpt)+';';
                   end;
                if ((k<>ITotal) and (k <> ISomme-1) and (k<>1)) then
                   begin
                   ListeTotaux[l]:=ListeTotaux[l]+';';
                   Listeaux[m]:=Listeaux[m]+';';
                   end;
//                ListeTotaux.Add(GetStringElement(Liste[i],1,';')+';;'+'Total du Compte'+';'+CurrToStr(TotalCpt)+';;');
//                ListeAux.Add(GetStringElement(Liste[i],1,';')+';;'+'Total du Compte'+';'+CurrToStr(TotalCpt)+';;');
                end;
                TotalCpt:=0;
                inc(j);
                ListeIndex.add(inttostr(j));
              end;
           end
           else
           begin
               ListeTotaux.Add('');
               Listeaux.Add('');
               l:=ListeTotaux.Count-1;
               m:=Listeaux.Count-1;
               for k:=1 to NombreCol-1 do
                begin
                if k = 1 then
                   begin
                   ListeTotaux[l]:=ListeTotaux[l]+GetStringElement(Liste[i],1,';')+';';
                   Listeaux[m]:=Listeaux[m]+GetStringElement(Liste[i],1,';')+';';
                   end;
                if k = ITotal then
                   begin
                   ListeTotaux[l]:=ListeTotaux[l]+'Total du Compte;';
                   Listeaux[m]:=Listeaux[m]+'Total du Compte;';
                   end;
                if k = ISomme then
                   begin
                   ListeTotaux[l]:=ListeTotaux[l]+CurrToStr(TotalCpt)+';';
                   Listeaux[m]:=Listeaux[m]+CurrToStr(TotalCpt)+';';
                   end;
                if ((k<>ITotal) and (k <> ISomme) and (k<>1)) then
                   begin
                   ListeTotaux[l]:=ListeTotaux[l]+';';
                   Listeaux[m]:=Listeaux[m]+';';
                   end;
//                ListeTotaux.Add(GetStringElement(Liste[i],1,';')+';;'+'Total du Compte'+';'+CurrToStr(TotalCpt)+';;');
//                ListeAux.Add(GetStringElement(Liste[i],1,';')+';;'+'Total du Compte'+';'+CurrToStr(TotalCpt)+';;');
                end;
//             ListeTotaux.Add(GetStringElement(Liste[i],1,';')+';;'+'Total du Compte'+';'+CurrToStr(TotalCpt)+';;');
//             ListeAux.Add(GetStringElement(Liste[i],1,';')+';;'+'Total du Compte'+';'+CurrToStr(TotalCpt)+';;');
             TotalCpt:=0;
             inc(j);
             ListeIndex.add(inttostr(j));
           end;
       end;
  end;
Liste:=ListeAux;
end;

procedure TVBalOuv.LaEmpruntsClick(Sender: TObject);
var
i,j,CompteurCpt:integer;
NumCompteNode:string;
ListeDonnees,ListeBal:TStringList;
begin
//PositionShape(sender);
//ChangePatitre(sender);
//ListeDonnees:=TStringList.Create;
//ListeDonnees.Clear;
//ListeBal:=TStringList.Create;
//ListeBal.clear;
//
//NombreCol:=0;
//IndexTotal:=3;
//IndexSomme:=5;
//
//ListeDonnees:=DMOpen.ValeurChampTableOuv(NombreCol,ColASomme);
//FormateListe(ListeDonnees,ColASomme,IndexTotal,IndexSomme);
//initGrille(AdvStringGrid1);
//CompteurCpt:=0;
//ListeBal.Sorted:=true;
//ListeBal.Duplicates:=dupIgnore;
//AdvStringGrid1.RowCount:=ListeDonnees.Count+1;
//AdvStringGrid1.ColumnSize.Stretch:=true;
////AdvStringGrid1.AutoSize:=true;
//for j:=0 to ListeDonnees.Count -1  do
//    begin
//    if j > 0 then ListeBal.Add(trim(GetStringElement(ListeDonnees.strings[j],1,';')));
//     AdvStringGrid1.RowCount:=AdvStringGrid1.RowCount+1;
//         for i:=1 to NombreCol do
//             begin
//             AdvStringGrid1.Cells[i,j]:=GetStringElement(ListeDonnees.strings[j],i,';');
//             end;
//         if j > 0 then
//           begin
//            if GetStringElement(ListeDonnees.strings[j],IndexTotal,';')<>'Total du Compte' then
//              begin
//              AdvStringGrid1.AddCheckBox(NombreCol+1,j,true,false);
//              inc(CompteurCpt);
//              end
//              else
//              begin
//               AdvStringGrid1.AddNode(j-CompteurCpt,CompteurCpt+1);
////               AdvStringGrid1.ArrowColor
//               CompteurCpt:=0;
//              end;
//           end;
//   end;
//ListeDonnees.clear;
//ListeDonnees:=ValeurBalance(ListeBal,['Compte','Debit_Report']);
//GridBal.Cells[1,0]:='Compte';
//GridBal.Cells[2,0]:='Débit report';
//for i:=0 to ListeDonnees.Count-1 do
//    begin
//     GridBal.Cells[1,i+1]:=GetStringElement(ListeDonnees.strings[i],1,';');
//     GridBal.Cells[2,i+1]:=GetStringElement(ListeDonnees.strings[i],2,';');
//    end;
//ListeDonnees.Free;
//ListeBal.Free;
//AdvStringGrid1.AutoSize:=true;
////AdvStringGrid1.RowCount:=AdvStringGrid1.RowCount-2;
end;

procedure TVBalOuv.LaStocksClick(Sender: TObject);
var
i,j,CompteurCpt:integer;
NumCompteNode:string;
ListeDonnees,ListeBal:TStringList;
begin
//PositionShape(sender);
//ChangePatitre(sender);
//ListeDonnees:=TStringList.Create;
//ListeDonnees.Clear;
//ListeBal:=TStringList.Create;
//ListeBal.clear;
//NombreCol:=0;
//IndexTotal:=2;
//IndexSomme:=7;
//ListeDonnees:=DMStock.ValeurChampTableOuv(NombreCol,ColASomme);;
//FormateListe(ListeDonnees,ColASomme,IndexTotal,IndexSomme);
//initGrille(AdvStringGrid1);
//CompteurCpt:=0;
//ListeBal.Sorted:=true;
//ListeBal.Duplicates:=dupIgnore;
//AdvStringGrid1.RowCount:=ListeDonnees.Count+1;
//AdvStringGrid1.ColumnSize.Stretch:=true;
//for j:=0 to ListeDonnees.Count -1  do
//    begin
//    if j > 0 then ListeBal.Add(trim(GetStringElement(ListeDonnees.strings[j],1,';')));
////     AdvStringGrid1.RowCount:=AdvStringGrid1.RowCount+1;
//         for i:=1 to NombreCol do
//             begin
//             AdvStringGrid1.Cells[i,j]:=GetStringElement(ListeDonnees.strings[j],i,';');
//             end;
//         if j > 0 then
//           begin
//            if GetStringElement(ListeDonnees.strings[j],IndexTotal,';')<>'Total du Compte' then
//              begin
//              AdvStringGrid1.AddCheckBox(NombreCol+1,j,true,false);
//              inc(CompteurCpt);
//              end
//              else
//              begin
//               AdvStringGrid1.AddNode(j-CompteurCpt,CompteurCpt+1);
////               AdvStringGrid1.ArrowColor
//               CompteurCpt:=0;
//              end;
//           end;
//   end;
//ListeDonnees.clear;
//ListeDonnees:=ValeurBalance(ListeBal,['Compte','Debit_Report']);
//GridBal.Cells[1,0]:='Compte';
//GridBal.Cells[2,0]:='Débit report';
//for i:=0 to ListeDonnees.Count-1 do
//    begin
//     GridBal.Cells[1,i+1]:=GetStringElement(ListeDonnees.strings[i],1,';');
//     GridBal.Cells[2,i+1]:=GetStringElement(ListeDonnees.strings[i],2,';');
//    end;
//ListeDonnees.Free;
//ListeBal.Free;
//AdvStringGrid1.AutoSize:=true;
////AdvStringGrid1.RowCount:=AdvStringGrid1.RowCount-2;
end;


procedure TVBalOuv.LaPRecevoirClick(Sender: TObject);
begin
PositionShape(sender);
ChangePatitre(sender);
end;

procedure TVBalOuv.LaChPayerClick(Sender: TObject);
begin
PositionShape(sender);
ChangePatitre(sender);
end;

procedure TVBalOuv.LabChRepartirClick(Sender: TObject);
begin
PositionShape(sender);
ChangePatitre(sender);
end;

procedure TVBalOuv.LaChConstateesClick(Sender: TObject);
begin
PositionShape(sender);
ChangePatitre(sender);
end;

procedure TVBalOuv.LaPConstatesClick(Sender: TObject);
begin
PositionShape(sender);
ChangePatitre(sender);
end;

procedure TVBalOuv.LaProvisionsClick(Sender: TObject);
begin
PositionShape(sender);
ChangePatitre(sender);
end;

procedure TVBalOuv.AdvStringGrid1ContractNode(Sender: TObject; arow,
  arowreal: Integer);
var
i,j:integer;
begin
j:=arowreal;
for i:=1 to NombreCol do
//AdvStringGrid1.Rows[arowreal].Strings[i]:=GetStringElement(ListeTotaux.Strings[1],i,';');
AdvStringGrid1.Rows[arow].Strings[i]:=GetStringElement(ListeTotaux.Strings[ListeIndex.indexof(inttostr(j))+1],i,';');
AdvStringGrid1.RemoveCheckBox(NombreCol+1,j);
//showmessage(AdvStringGrid1.Rows[1].Text);
//showmessage(AdvStringGrid1.Rows[AdvStringGrid1.DisplRowIndex(4)].Text);
//AdvStringGrid1.MoveRow(7,1);
//showmessage(inttostr(arow));
//showmessage(inttostr(arowreal));
end;

procedure TVBalOuv.AdvStringGrid1ExpandNode(Sender: TObject; arow,
  arowreal: Integer);
var
i,j:integer;
begin
j:=arowreal;
for i:=1 to NombreCol do
AdvStringGrid1.Rows[arow].Strings[i]:=GetStringElement(ListeTotaux.Strings[ListeIndex.indexof(inttostr(j))],i,';');
AdvStringGrid1.AddCheckBox(NombreCol+1,j,true,false);
//AdvStringGrid1.SwapRows(arowReal,2);
//showmessage(inttostr(arow));
//showmessage(inttostr(arowreal));
//AdvStringGrid1.ExpandNode(arow);
end;

procedure TVBalOuv.AdvStringGrid1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
if arow <> 0 then
if not AdvStringGrid1.HasCheckBox(NombreCol+1,Arow) then
  begin
   ABrush.Color:=clAqua;
   AFont.Color:=clRed;
  end;
end;

end.
