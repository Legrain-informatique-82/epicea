unit GrGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,GrDBGrid,Lib1,db;

//Const
 // um_ValidateInput=wm_user+100;

type

      TMyCustomControl = class(TCustomControl)
    public

    property Canvas;

    end;
  TgridSupprLigneEvent=procedure (sender:TObject;Arow:integer;var NewRow:integer)of object;
  TGridNewLigneEvent=procedure (sender:TObject;Arow:integer) of object;
  TGridBeforeKeyDownEvent=procedure (Sender: TObject; var Key: Word;
  Shift: TShiftState)of object;
  TGridRowValidateEvent=procedure (Sender:TObject;var Valide:boolean;var Action:boolean;LastCol:integer)of object;
  TGridRowEnterEvent=procedure (sender:TObject;NewRow:integer)of object;
  TGridColEnterEvent=procedure (OldColonne,NewColonne:integer)of object;
  TGridColExitEvent=procedure (NewColonne:integer)of object;
  TGridClickEvent = procedure (Colonne,Ligne: Integer) of object;
  TGridBeforeColExitEvent=procedure (NewColonne:integer)of object;
  TGrGrid = class(TStringGrid)
  private
    { Déclarations privées }
    FLastCol:Integer;
    FLastRow:Integer;
    FFirstCol:integer;
    FfirstRow:integer;
    FDisplayBool:Boolean;
    FColonnesBool:TListInt;
    FListeValeurListeBool:TList;
    FOnColEnter: TGridColEnterEvent;
    FOnBeforeColExit:TGridBeforeColExitEvent;
    FOnColExit: TGridColExitEvent;
    FOnBeforeNewLigne:TGridNewLigneEvent;
    FOnNewLigne : TGridNewLigneEvent;
    FOnBeforeSupprLigne:TgridSupprLigneEvent;
    FOnSupprLigne : TgridSupprLigneEvent;
    FOnCellClick: TGridClickEvent;
    FOnRowEnter: TGridRowEnterEvent;
    FOnRowExit:  TNotifyEvent;
    FOnRowValidate: TGridRowValidateEvent;
    FOnBeforeKeyDown:TGridBeforeKeyDownEvent;
    ListAux:TListBool;
    FRowValue:string;
    FChamp:TListChamp;
    FNumDecimal:integer;
    FValidation:boolean;
    FAjoutAuto:boolean;
    FEtatGrille:TDataSetState;
    Function NombreLigneVide:integer;
    Function DrawCaseCocher(ACol, ARow: Longint):Boolean;
    Function ColBooleenne(ACol:integer):integer;

  protected
    { Déclarations protégées }
    procedure DoExit; override;
    procedure DoEnter;override;
    function CreateEditor: TInplaceEdit; override;

   procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
   procedure SetCheckBoxSize;
   function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure ColEnter(OldColonne,NewColonne:integer); dynamic;
    procedure ColExit(NewColonne:integer); dynamic;
    procedure RowEnter(NewRow:integer); dynamic;
    procedure RowExit; dynamic;
    procedure RowValidate(var valide:boolean); dynamic;
    procedure CellClick(Colonne,Ligne: Integer); dynamic;
    procedure GetFirstCol;

  public
    { Déclarations publiques }
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        procedure Loaded; override;
        procedure AjouteLigne;
        Procedure InsertLigne(rang:integer);
        procedure GenereLigne(Insert:boolean;NewRow:integer);
        Procedure SupprimeLigne(Rang:integer);
        Procedure AllerCellule(ACol,Arow:integer);
        Function ValeurCellule(ACol,Arow:integer):String;
        Function LastCelluleActive:integer;
        Function LastRow(ARow:Integer):Boolean;
        Function LastCol(ACol:Integer):Boolean;
        function firstCol(Acol:integer):boolean;
        function FirstRow(ARow:integer):boolean;
        procedure KeyDown(var Key: Word; Shift: TShiftState); override;
        procedure KeyPress(var Key: Char); override;
        function LigneVide(ARow:integer):boolean;
        procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
        X, Y: Integer); override;
        property Canvas;
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure setListBool(L:TlistInt);
        property  ListeValeurListeBool:TList read FListeValeurListeBool write FListeValeurListeBool;
        property  Champ:TListChamp read FChamp write FChamp;
        property EtatGrille:TDataSetState read FEtatGrille write FEtatGrille;

published
    { Déclarations publiées }
    property NumDecimal:integer read FNumDecimal write FNumDecimal;
    property OnColEnter: TGridColEnterEvent read FOnColEnter write FOnColEnter;
    property OnColExit:TGridColExitEvent read  FOnColExit write FOnColExit;
    property OnBeforeColExit:TGridBeforeColExitEvent read FOnBeforeColExit write FOnBeforeColExit;
    property OnBeforeNewLigne:TGridNewLigneEvent read FOnBeforeNewLigne write FOnBeforeNewLigne;
    property OnNewLigne : TGridNewLigneEvent read FOnNewLigne write FOnNewLigne;
    property OnBeforeSupprLigne:TgridSupprLigneEvent read FOnBeforeSupprLigne write FOnBeforeSupprLigne;
    property OnSupprLigne : TgridSupprLigneEvent read FOnSupprLigne write FOnSupprLigne;
    property OnCellClick: TGridClickEvent read FOnCellClick write FOnCellClick;
    property OnRowEnter:TGridRowEnterEvent read FOnRowEnter write FOnRowEnter;
    property  OnRowExit:TNotifyEvent read FOnRowExit write FOnRowExit;
    property  OnRowValidate:TGridRowValidateEvent read FOnRowValidate write FOnRowValidate;
    property ColonnesBool:TListInt read FColonnesBool write setListBool;
    property  AjoutAuto:boolean read FAjoutAuto write FAjoutAuto;
    property OnBeforeKeyDown:TGridBeforeKeyDownEvent read FOnBeforeKeyDown write FOnBeforeKeyDown;
  end;

procedure Register;

implementation

var
    GCheckWidth, GCheckHeight: Integer;
Inverse:boolean;
procedure Register;
begin
  RegisterComponents('Epicea', [TGrGrid]);
end;

constructor TGrGrid.Create(AOwner: TComponent);
Begin
  inherited create(AOwner);
  SetCheckBoxSize;
  Inverse:=true;
  FColonnesBool:=TListInt.Create;
  ListeValeurListeBool:=TList.Create;
  ListAux:=TListBool.Create;
End;

destructor TGrGrid.Destroy;
Begin
  inherited;
ListAux.Free;
FChamp.Free;
End;



procedure TGrGrid.Loaded;
Begin
inherited loaded;
FChamp:=TListChamp.Create;

End;

 procedure TGrGrid.setListBool(L:TlistInt);
 Begin
 FColonnesBool:=L;
 End;

function TGrGrid.SelectCell(ACol, ARow: Longint): Boolean;
var
validate:boolean;
NewRow:integer;
Begin
FLastCol:=Col;
FLastRow:=row;
inherited SelectCell(ACol, ARow);
   
   if col <> ACol then
     Begin
         colExit(ACol);
         ColEnter(FLastCol,ACol);
     End;
   if FLastRow <> arow then
     Begin
       if fvalidation=false then
       begin
         RowValidate(validate);
         FValidation:=true;
       end;
       rowexit;
         if FLastRow <> arow then
           rowenter(Arow)
           else
           rowenter(FLastRow);
     Fvalidation:=false;
     End;
End;

procedure TGrGrid.CellClick(Colonne,Ligne: Integer);
begin
  if Assigned(FOnCellClick) then FOnCellClick(Colonne,Ligne);
  if ((Colonne = FLastCol) and (Ligne=FLastRow)) then
   DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);
end;

Function TGrGrid.NombreLigneVide:integer;
var
i:integer;
Begin
Result:=0;
for i:=0 to RowCount-1 do
    Begin
     if LigneVide(i) then inc(result);
    End;
End;

procedure TGrGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
ARow,Acol:integer;
validate:boolean;
Begin
FValidation:=false;
validate:=true;
Arow:=row;
Acol:=col;
if assigned(FOnBeforeKeyDown) then FOnBeforeKeyDown(self,key,shift);
if ((key=vk_tab) and (col=6)) then
   key:=vk_return;
if key= vk_Up then
    Begin
     if (row>1) then
      if LastRow(row)then
         if LigneVide(row) then
         begin
           fvalidation:=true;
         end;
     End;
 inherited KeyDown(key,shift);
 case key of
 vk_return:Begin
          if (LastCol(acol)) then
              begin
              fvalidation:=true;
              RowValidate(validate);
              if validate  then
                begin                
                if ((FAjoutAuto) and (not LigneVide(Arow))and (LastRow(Arow))) then
                GenereLigne(false,Arow+1);
                end;
              end;
           End;
   
 vk_down:Begin
          if FValidation=false then
          begin
          fvalidation:=true;
          RowValidate(validate);
          end;
          if (LastRow(Arow))and (not LigneVide(Arow)) then
            begin
             if validate  then
               begin
               if FAjoutAuto then
               GenereLigne(false,Arow+1);
               end;
            end;
         End;
 vk_Up  :Begin
         RowValidate(validate);
         if validate then
            begin
            if (row+1>1) then
             if LastRow(row+1)then
                if LigneVide(row+1) then
                begin
                  SupprimeLigne(row+1);
                end;
            end;
         End;
vk_Insert:if shift = [ssCtrl] then
          begin
          RowValidate(validate);
           if validate then
              begin
              if (NombreLigneVide =0) then
                 if FAjoutAuto then
                 GenereLigne(true,row+1);
              end;
          end;

  end;//fin du case
End;


procedure TGrGrid.KeyPress(var Key: Char);
Begin
inherited keypress(key);
End;


procedure TGrGrid.AjouteLigne;
Begin
RowCount:=RowCount+1;
row:=RowCount-1;
End;


procedure TGrGrid.GenereLigne(Insert:boolean;NewRow:integer);
Begin
   if Assigned(FOnBeforeNewLigne) then FOnBeforeNewLigne(Self,NewRow);
      if ((LastRow(NewRow)) and (not insert)) then
          AjouteLigne
        else
          InsertLigne(NewRow);
     Repaint;
    try
    if Assigned(FOnNewLigne) then FOnNewLigne(Self,NewRow);
    except
    SupprimeLigne(newrow);
    Repaint;
    end;//fin du try
End;

Procedure TGrGrid.InsertLigne(rang:integer);
var
i:integer;
Begin
AjouteLigne;
for i:=RowCount-1 Downto Rang do
    Begin
      Rows[i]:=Rows[i-1];
    End;
    Rows[Rang].Clear;
//rowexit;
Row:=Rang;
//rowEnter;
End;

Procedure TGrGrid.SupprimeLigne(Rang:integer);
var
i:integer;
NewRang:integer;
Begin
NewRang:=rang;
if Assigned(FOnBeforeSupprLigne) then FOnBeforeSupprLigne(Self,rang,NewRang);
for i:=Rang to RowCount-1 do
    Begin
      Rows[i]:=Rows[i+1];
    End;
if rowcount-1<2 then
rows[row].Clear
else
RowCount:=RowCount-1;
if NewRang<rowcount-1 then
Row:=NewRang;
if Assigned(FOnSupprLigne) then FOnSupprLigne(Self,rang,NewRang);
End;

Procedure TGrGrid.AllerCellule(ACol,Arow:integer);
Begin
Row:=Arow;
Col:=Acol;
End;

Function TGrGrid.ValeurCellule(ACol,Arow:integer):String;
Begin
result:=cells[ACol,ARow];
End;

Function TGrGrid.LastCelluleActive:integer;
Begin

End;
Function TGrGrid.LastRow(ARow:Integer):Boolean;
Begin
result:=(RowCount - 1) = ARow;
End;

Function TGrGrid.LastCol(ACol:Integer):Boolean;
Begin
result:=(ColCount - 1) = ACol;
End;


function TGrGrid.firstCol(Acol:integer):boolean;
Begin
result:= 0+fixedcols = ACol;
End;

procedure TGrGrid.GetFirstCol;
Begin
FFirstCol:=fixedcols;
End;


function TGrGrid.FirstRow(ARow:integer):boolean;
Begin
 result:=0+FixedRows = ARow;
End;



function TGrGrid.LigneVide(ARow:integer):boolean;
var
i:integer;
Begin
result:=true;
 for i:=1 to colcount-1 do
 Begin
 result:=trim(cells[i,Arow])='';
 if not result then Break;
// if (ColBooleenne(i)<>-1) then
//    result:=DrawCaseCocher(i,Arow);
// if result then Break;
 End;
End;


procedure TGrGrid.ColEnter(OldColonne,NewColonne:integer);
begin
//FLastCol:=ACol;
//FLastRow
if (ColBooleenne(FLastCol)<>-1) then
   begin
   options:=options - [goAlwaysShowEditor,goEditing];
//   DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);
//   result:=true;
//   options:=options;
   end
   else
   Begin
   options:=options + [goAlwaysShowEditor,goEditing];
//   result:=true;
   End;
  if Assigned(FOnColEnter) then FOnColEnter(OldColonne,NewColonne);
end;

procedure TGrGrid.ColExit(NewColonne:integer);
begin
   if assigned(FOnBeforeColExit) then FOnBeforeColExit(newColonne);

   if Assigned(FOnColExit) then FOnColExit(NewColonne);
end;

procedure TGrGrid.RowEnter(NewRow:integer);
Begin
 FRowValue:=rows[Flastrow].text;
 if Assigned(FOnRowEnter) then FOnRowEnter(Self,NewRow);
End;


procedure TGrGrid.RowExit;
Begin
 if Assigned(FOnRowexit) then FOnRowexit(Self);
End;



procedure TGrGrid.RowValidate(var valide:boolean);
var
GAction:boolean;
begin
GAction:=true;
if Assigned(FOnRowValidate) then FOnRowValidate(self,valide,GAction,col);
end;


procedure TGrGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
        X, Y: Integer);
Begin
// if col <> 4 then
//   inherited MouseUp(Button, Shift,X, Y)
//    else
//    Begin
//     InplaceEditor.Hide;
//    End;
inherited MouseUp(Button, Shift,X, Y);
//   DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);

cellclick(col,row);
if (Lignevide(rowcount-1) and (not lastrow(row))) then SupprimeLigne(rowcount-1);

End;

procedure TGrGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
inherited MouseDown(Button,Shift,X,Y);
//DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);

//cellclick(col,row);
// if col <> 4 then
//   inherited MouseDown(Button,Shift,X,Y)
//    else
//    Begin
//     InplaceEditor.Hide;
//    End;

End;

procedure TGrGrid.DoExit;
Begin
inherited DoExit;
if rowcount-1>1 then
  if Lignevide(rowcount-1)  then SupprimeLigne(rowcount-1);
End;

procedure TGrGrid.DoEnter;
Begin
inherited doEnter;
  FRowValue:=rows[row].text;
End;

function TGrGrid.CreateEditor: TInplaceEdit;
begin
    Result :=TGrInplaceEdit.Create(self) ;

    TGrInplaceEdit(Result).NumDecimal:=NumDecimal;
//    TGrInplaceEdit(Result).DateDef:=DateDef;
end;

Function TGrGrid.ColBooleenne(ACol:integer):integer;
var
j:integer;
Begin
result:=-1;
for j:=0 to ColonnesBool.Count -1 do
    Begin
    if ACol=ColonnesBool.items[j] then begin
                                  result:=j;
                                  break;
                                  end;
    End;
End;

Function TGrGrid.DrawCaseCocher(ACol, ARow: Longint):Boolean;
var
i,j:integer;
Begin
i:=ColBooleenne(Acol);
result:=false;
if ((ColonnesBool.Count > 0) and (i <> -1)) then
   begin
        ListAux:=ListeValeurListeBool.items[i];
        if ARow <= ListAux.Count then
            result:=ListAux.Items[ARow-1];
   end;
End;


procedure TGrGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
TmpRect:TRect;
style: UINT;
Region, OldClipRegion: HRgn;
ClipRegionExists: Boolean;

Begin
//if Acol <> 4 then
   inherited DrawCell(ACol, ARow, ARect, AState);
//   HideEditor;
//if (FDisplayBool) then
if ((true) and (ColBooleenne(Acol)<>-1) and (ARow>0)) then
//if ((true) and (ARow>0)) then
 begin
     Canvas.FillRect(ARect);

//     if FFlatCheckBox then
//         if FFlatCheckBoxType = Normal then
//             begin
//                 ClipRegionExists := False;
//                 OldClipRegion := CreateRectRgn(0, 0, 0, 0);
//                 ClipRegionExists := GetClipRgn(Handle, OldClipRegion) = 1;
//             end;

     TmpRect := ARect;
     TmpRect.Left := ARect.Left + (ARect.Right - ARect.Left - GCheckWidth) div 2;
     TmpRect.Right := TmpRect.Left + GCheckWidth;
     TmpRect.Top := ARect.Top + (ARect.Bottom - ARect.Top - GCheckWidth) div 2;
     TmpRect.Bottom := TmpRect.Top + GCheckHeight;

//     if FFlatCheckBox then
//         if FFlatCheckBoxType = Normal then
//             begin
                 Region := CreateRectRgnIndirect(TmpRect);
                 ExtSelectClipRgn(Handle, Region, RGN_AND);
                 DeleteObject(Region);
                 InflateRect(TmpRect, 1, 1);
//             end;

//     Style := DFCS_CHECKED;
//     Inverse:= not Inverse;
     if DrawCaseCocher(ACol,Arow) then
         style :=DFCS_CHECKED
     else
         style := DFCS_BUTTONCHECK;{Case non cochée}

//     if FFlatCheckBox then
         DrawFrameControl(Canvas.Handle, TmpRect, DFC_BUTTON, style or DFCS_FLAT);
//     else
//         DrawFrameControl(Canvas.Handle, TmpRect, DFC_BUTTON, style);

//     if FFlatCheckBox then
//         if FFlatCheckBoxType = Normal then
//             begin
                 if ClipRegionExists then
                     SelectClipRgn(Handle, OldClipRegion)
                 else
                     SelectClipRgn(Handle, 0);

                 DeleteObject(OldClipRegion);
                 InflateRect(TmpRect, -1, -1);
                 Brush.Color := clGray;
                 canvas.FrameRect(TmpRect);
//             end;
 end;
End;


procedure TGrGrid.SetCheckBoxSize;
begin
    with TBitmap.Create do
        try
            Handle := LoadBitmap(0, PChar(32759));
            GCheckWidth := Width div 4;
            GCheckHeight := Height div 3;
        finally
            Free;
        end;
end;



end.

