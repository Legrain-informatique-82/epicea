unit GrGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,Lib1,db,
  GrDBGrid,
  GR_Librairie_Obj,
  Lib_chaine,
  E2_Decl_Records;
//  LibDeclRecord_Obj;

//unit GrGrid;
//
//interface
//
//uses
//  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
//  Grids,Lib1,db,E2_Decl_Records,GrDBGrid,GR_Librairie_Obj,Lib_chaine;

type

      TMyCustomControl = class(TCustomControl)
    public

    property Canvas;

    end;
  TgridSupprLigneEvent=procedure (sender:TObject;Arow:integer;var NewRow:integer)of object;
  TGridNewLigneEvent=procedure (sender:TObject;Arow:integer) of object;
  TGridStateChange=procedure (EtatGrille:TDataSetState) of object;
  TGridRowValidateEvent=procedure (Sender:TObject;var Valide:boolean;var Action:boolean;LastCol:integer)of object;
  TGridRowEnterEvent=procedure (sender:TObject;NewRow:integer)of object;
  TGridRowExitEvent=procedure (sender:TObject;LastRow:integer)of object;
  TGridColEnterEvent=procedure (OldColonne,NewColonne,NewRow:integer)of object;
  TGridColExitEvent=procedure (OldColonne,LastRow:integer)of object;
  TGridClickEvent = procedure (Colonne,Ligne: Integer) of object;
  TGridBeforeColExitEvent=procedure (NewColonne:integer)of object;

  TGrGrid = class(TStringGrid)
  private
    { Déclarations privées }
    FLastCol:Integer;
    FLastRow:Integer;
    FOldRow:integer;
    FNewRow:integer;
    FOldColonne:integer;
    FNewColonne:integer;
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
    FOnRowExit:  TGridRowExitEvent;
    FOnRowValidate: TGridRowValidateEvent;
    FOnStateChange : TGridStateChange;
    FOnChange:TNotifyEvent;
    ListAux:TListBool;
    FRowValue:string;
    FChamp:TListChamp;
//    FChamp_Readonly:TListBool;
    FChamp_Readonly:TBits;
    FNumDecimal:integer;
    FAcceptNegatif:boolean;
    FValidation:boolean;
    FAjoutAuto:boolean;
    FEtatGrille:TDataSetState;
    FDessineContourLigne:boolean;
    FInplaceEditColor:TColor;
    FInplaceEditColorFont:TColor;
    FParamColor:boolean;
    FParam:TVarColorGrid;
    Function NombreLigneVide:integer;
    Function DrawCaseCocher(ACol, ARow: Longint):Boolean;
    Function ColBooleenne(ACol:integer):integer;

  protected
    { Déclarations protégées }
    procedure DoExit; override;
    procedure DoEnter;override;
    function CompareStrings(const S1, S2: string;CaseSensitive:boolean=false): Integer;
   procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
   procedure SetCheckBoxSize;
//   Function ColRow(ACol, ARow: Longint) :Boolean;
   function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure ColEnter(OldColonne,NewColonne,NewRow:integer); dynamic;
    procedure ColExit(OldColonne,LastRow:integer); dynamic;
    procedure RowEnter(NewRow:integer); dynamic;
    procedure RowExit(FRow:integer); dynamic;
    procedure RowValidate(var valide:boolean); dynamic;
    procedure CellClick(Colonne,Ligne: Integer); dynamic;
    procedure GetFirstCol;

  public
    { Déclarations publiques }
        FFormatMonnaie:string;
        TextADroite:Boolean;
        JustifieChampCurr:Boolean;
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        procedure Loaded; override;
        function CreateEditor: TInplaceEdit; override;
        procedure AjouteLigne;
        Procedure InsertLigne(rang:integer);
        function Find(const S: string;const Col:integer;var Index: Integer): Boolean;
        function FindSorted(const S: string;const Col:integer;var Index: Integer): Boolean;
        procedure GenereLigne(Insert:boolean;NewRow,NewColonne:integer);
        Procedure SupprimeLigne(Rang:integer);
        Procedure AllerCellule(ACol,Arow:integer);
        Function ValeurCellule(ACol,Arow:integer):String;
        Function LastCelluleActive:integer;
        Function LastRow(ARow:Integer):Boolean;
        Function LastCol(ACol:Integer):Boolean;
        property OldColonne:integer read FOldColonne write FOldColonne;
        property NewColonne:integer read FNewColonne write FNewColonne;
        property OldRow:integer read FOldRow write FOldRow;
        property NewRow:integer read FNewRow write FNewRow;
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
        property Champ_Readonly:tbits read FChamp_Readonly write FChamp_Readonly;
        property EtatGrille:TDataSetState read FEtatGrille write FEtatGrille;
        Function ColRow(ACol, ARow: Longint) :Boolean;
        function RechercheLigneVide:integer;
        Procedure StateChange(Grille:TGrGrid);
        Procedure Change(Grille:TGrGrid);
        property InplaceEditor;
        property DessineContourLigne:boolean read FDessineContourLigne write FDessineContourLigne;
        property InplaceEditColor:TColor read FInplaceEditColor write FInplaceEditColor;
        property InplaceEditColorFont:TColor read FInplaceEditColorFont write FInplaceEditColorFont;
        property ParamColor:boolean read FParamColor write FParamColor default false;
        property Param:TVarColorGrid read FParam write FParam;
        Procedure TitreColor(Enter:boolean);
        Procedure UpDateColor;
        Procedure UpDateColorSansRepaint;
        Procedure cellsGr(ACol,ARow:integer;Valeur:string);
        Procedure ShowEditor;
        property AcceptNegatif:boolean read FAcceptNegatif write FAcceptNegatif ;

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
    property  OnRowExit:TGridRowExitEvent read FOnRowExit write FOnRowExit;
    property  OnRowValidate:TGridRowValidateEvent read FOnRowValidate write FOnRowValidate;
    Property  OnStateChange : TGridStateChange read FOnStateChange write FOnStateChange;
    property  OnChange :TNotifyEvent read FOnChange write FOnChange;
    property  ColonnesBool:TListInt read FColonnesBool write setListBool;
    property  AjoutAuto:boolean read FAjoutAuto write FAjoutAuto;
//    property OnBeforeKeyDown:TGridBeforeKeyDownEvent read FOnBeforeKeyDown write FOnBeforeKeyDown;
  end;

procedure Register;

implementation

var
GCheckWidth, GCheckHeight: Integer;
Inverse:boolean;
holdColor:TColor;
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
  holdColor:=clWindow;
  DessineContourLigne:=true;
FChamp_Readonly:=tbits.Create;
TextADroite:=True;
JustifieChampCurr:=true;

//  holdColor:=Canvas.Brush.Color;
End;

destructor TGrGrid.Destroy;
Begin
  inherited;
ListAux.Free;
FChamp.Free;
FChamp_Readonly.Free;
End;



procedure TGrGrid.Loaded;
Begin
inherited ;//loaded;
FChamp:=TListChamp.Create;
FEtatGrille:=dsBrowse;
FLastRow:=Row;
if FParamColor then
   Begin
//     HighlightColor:=Param.CelActiveColorFond;
//     HighlightFontColor:=Param.CelActiveColorFont;
     // Param.CelActiveContour;
     InplaceEditColor:=Param.CelActiveSAisieColorFond;
     InplaceEditColorFont:=Param.CelActiveSAisieColorFont;
     FixedColor:=Param.CelFixeColorFond;
//     TitleFont.Color:=Param.CelFixeColorFont;
     Color:=Param.GrilleColorFond;
     Font.Color:=Param.GrilleColorFont;

   end
   else
   begin
    InplaceEditColor:=clWindow;
    InplaceEditColorFont:=clWindowText;
   end;
End;

function TGrGrid.RechercheLigneVide:integer;
var
i:integer;
Begin
result:=-1;
   for i:=1 to RowCount-1 do
   begin
      if LigneVide(i) then
      result:=i;
   end;
End;

procedure TGrGrid.setListBool(L:TlistInt);
Begin
 FColonnesBool:=L;
End;

function TGrGrid.SelectCell(ACol, ARow: Longint): Boolean;
var
validate:boolean;
NewRow:integer;
ColFAit:boolean;
Begin
ColFait:=false;
try
FLastCol:=Col;
FLastRow:=row;
FOldRow:=row;
Foldcolonne:=Flastcol;
Fnewcolonne:=acol;
FNewRow:=Arow;
result:=true;
inherited SelectCell(ACol, ARow);
      if FLastRow <> ARow then
        Begin
          if FEtatGrille in [dsedit,dsInsert] then
          RowValidate(validate);
          rowexit(FlastRow);
          if Flastcol <> ACol then
            Begin
                colExit(Flastcol,FLastRow);
                ColFait:=true;
            End;
          rowenter(ARow);
//DrawCell(ACol,ARow,CellRect(ACol,ARow),[]);
        End;
      if Flastcol <> ACol then
        Begin
         if not ColFait then colExit(Flastcol,FLastRow);
             ColEnter(Flastcol,ACol,ARow);
        End;

     //if ((Col = FLastCol) and (Row=FLastRow)) then
     // DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);
//      DrawCell(ACol,ARow,CellRect(ACol,ARow),[]);
if champ_readonly.Size>0 then
  if champ_readonly.bits[acol] then
    result:=false;
repaint;
//DrawCell(ACol,ARow,CellRect(ACol,ARow),[]);
//inherited SelectCell(ACol, ARow);
//repaint;
//update;
//DrawCell(ACol,ARow,CellRect(ACol,ARow),[]);

except
row:=FLastrow;
col:=fOldcolonne;
Fnewcolonne:=col;
Fnewrow:=row;
abort;
end;
//NewRow:=Row;
//ColRow(ACol, ARow);
//   if col <> ACol then
//     Begin
//         colExit(Col);
//         ColEnter(FLastCol,ACol,ARow);
//     End;
//   if FLastRow <> arow then
//     Begin
//       if fvalidation=false then
//       begin
//         RowValidate(validate);
//         FValidation:=true;
//       end;
//       rowexit;
//       rowenter(Arow);
//
//     Fvalidation:=false;
//     End;

End;

Procedure TGrGrid.Change(Grille:TGrGrid);
begin
   try
   if Assigned(FOnChange) then FOnChange(Grille);
   except
    abort;
   end;
end;



Procedure TGrGrid.StateChange(Grille:TGrGrid);
begin
if Assigned(FOnStateChange) then FOnStateChange(FEtatGrille);
end;

//******************************************************************************
Function TGrGrid.ColRow(ACol, ARow: Longint) :Boolean;
var
validate:boolean;
begin
FLastCol:=Col;
FLastRow:=row;
	if ((ACol <> Col) Or (aRow <> Row))
   	And (ACol < ColCount) And (ARow < RowCount) then Begin
      inherited MoveColRow(ACol, ARow, True, true);
      ShowEditor;
      Click;
      Result:= True;
//       if col <> ACol then
//         Begin
//             colExit(FLastCol);
//             ColEnter(FLastCol,ACol,ARow);
//         End;
//       if FLastRow <> arow then
//         Begin
//           if fvalidation=false then
//           begin
//             RowValidate(validate);
//             FValidation:=true;
//           end;
//           rowexit;
//           rowenter(FLastRow);
//
//         Fvalidation:=false;
//         End;
   End
   Else Result:= False;
end;


//******************************************************************************

procedure TGrGrid.CellClick(Colonne,Ligne: Integer);
//Colonne = Col = colonne cliqué -> ok
//Ligne = row = Ligne cliqué -> ok
var
validate:boolean;
NewRow:integer;
ColFait:boolean;
begin

ColFait:=false;
//showmessage('DebutCellclick');
   try
     if Assigned(FOnCellClick) then FOnCellClick(Colonne,Ligne);
        if (rowcount>2) then
//             if LastRow(Arow)then
                if LigneVide(rowcount-1) then
                begin
                  SupprimeLigne(rowcount-1);
//                  suppr:=true;
                end;

//      if FLastRow <> Ligne then
//        Begin
////          if fvalidation=false then
////          begin
//
////            RowValidate(validate);
////            FValidation:=true;
////          end;
//          if FEtatGrille in [dsedit,dsInsert] then RowValidate(validate);
//          rowexit(FlastRow);
//          if Flastcol <> Colonne then
//            Begin
//                colExit(Flastcol,FLastRow);
//                ColFait:=true;
//            End;
//          rowenter(Ligne);
//
////        Fvalidation:=false;
//        End;
//      if Flastcol <> Colonne then
//        Begin
//         if not ColFait then colExit(Flastcol,FLastRow);
//             ColEnter(Flastcol,Colonne,Ligne);
//        End;
//     if ((Colonne = FLastCol) and (Ligne=FLastRow)) then
//      DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);
//repaint;
   except
//   col:=FLastCol;
//   row:=FLastRow;
//  showmessage('AbortCellclick');
   DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);
    abort;
   end;
end;

Function TGrGrid.NombreLigneVide:integer;
var
i:integer;
Begin
Result:=0;
for i:=1 to RowCount-1 do
    Begin
     if LigneVide(i) then inc(result);
    End;
End;

procedure TGrGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
ARow,Acol:integer;
validate,suppr,insert:boolean;
Begin
try
insert:=false;
suppr:=false;
validate:=true;
Arow:=row;
Acol:=col;
if ((key=vk_tab) and (LastCol(col)) and (LastRow(Row))) then
   key:=vk_return;

 inherited KeyDown(key,shift);
 FOldColonne:=flastcol;
 FNewColonne:=col;
 Fnewrow:=row;
 FOldRow:=ARow;
//////////////////////
if SsCtrl in Shift
   then
   case key of
   vk_end:begin
            cellclick(col,row);
            abort;
          end;
   vk_home:begin
            if (row+1>1) then
             if LastRow(Arow)then
                if LigneVide(Arow) then
                begin
                  SupprimeLigne(Arow);
                  suppr:=true;
                end;
          end;
   vk_delete:begin
            SupprimeLigne(row);
            end;
   end;

   if Row <> arow then
     Begin
       //
     End;
 /////////////////////////
 case key of
 vk_return,VK_TAB:Begin
          if (LastCol(acol)) then
              begin
              if FEtatGrille in [dsinsert,dsedit]then
              RowValidate(validate);
              if validate  then
                begin
                if ((FAjoutAuto) and (not LigneVide(Arow))and (LastRow(Arow))) then
                begin
                GenereLigne(false,Arow+1,1);
                insert:=true;
                end;
                end;
              end;
           End;

 vk_down:Begin
          if FEtatGrille in [dsinsert,dsedit]then
          begin
          RowValidate(validate);
          end;
          if Fetatgrille=dsbrowse then
          begin//si etat dsbrowse
          if (LastRow(Arow))and (not LigneVide(Arow) and (NombreLigneVide<>1)) then
            begin//si derniere ligne et pas vide
               if FAjoutAuto then
               begin
               GenereLigne(false,Arow+1,1);
               row:=rowcount-1;
               insert:=true;
               end;
            end;//si derniere ligne et pas vide
          end;//fin si etat dsbrowse
         End;
 vk_Up,vk_home,vk_prior:Begin
            if FetatGrille in [dsinsert,dsEdit]then
                RowValidate(validate);
//                click;
            if (row+1>2) then
             if LastRow(Arow)then
                if LigneVide(Arow) then
                begin
                  SupprimeLigne(Arow);
                  suppr:=true;
                end;
         end;

  end;//fin du case
if shift = [ssCtrl] then
        if key=vk_Insert then
          begin
          if FetatGrille in [dsinsert,dsEdit]then
          RowValidate(validate);
//           if validate then
              begin
              if (NombreLigneVide =0) then
                 if FAjoutAuto then
                  begin
                 GenereLigne(true,row,1);
                 insert:=true;
                 end;

              end;
          end;
   if ((Row <> arow) or (col <> ACol)) then
     Begin
      if (Row <> arow) then
          if  ((not insert) and (not suppr)) then rowexit(arow);
     End;
except
abort;
end;
End;


procedure TGrGrid.KeyPress(var Key: Char);
Begin
inherited keypress(key);
if true then
   begin
//   if key=#32 then
   end;
End;



procedure TGrGrid.AjouteLigne;
Begin
RowCount:=RowCount+1;
End;

function TGrGrid.FindSorted(const S: string;const Col:integer;var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := RowCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareStrings(Cells[Col,I], S);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
end;

function TGrGrid.Find(const S: string;const Col:integer;var Index: Integer): Boolean;
var
 I,C: Integer;
begin
  Result := False;
  for i:=0 to RowCount-1 do
  begin
    C := CompareStrings(Cells[Col,I], S);
    if C = 0 then
      begin
        Result := True;
        Index:= I;
      end;
  end;
end;

procedure TGrGrid.GenereLigne(Insert:boolean;NewRow,NewColonne:integer);
var
ColAux,RowAux:integer;
Begin
RowAux:=row;
   if Assigned(FOnBeforeNewLigne) then FOnBeforeNewLigne(Self,NewRow);
      if (LastRow(NewRow)or(NewRow>=Rowcount)) and (not insert) then {isa le 25/09/2007}
          AjouteLigne
        else
          InsertLigne(NewRow);
//     col:=NewColonne; {isa le 25/09/2007}
    if NewColonne<>-1 then {isa le 25/09/2007}
      col:=NewColonne;

    try
    if Assigned(FOnNewLigne) then FOnNewLigne(Self,NewRow);
    rowexit(RowAux);
    except
    SupprimeLigne(newrow);
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
Row:=Rang;
End;

Procedure TGrGrid.SupprimeLigne(Rang:integer);
var
i:integer;
NewRang:integer;
Begin
try
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
FEtatGrille:=dsBrowse;
StateChange(self);
NewRang:=row;
if Assigned(FOnSupprLigne) then FOnSupprLigne(Self,rang,NewRang);
//rowenter(Row);
except
end;
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


procedure TGrGrid.ColEnter(OldColonne,NewColonne,NewRow:integer);
// OldColonne -> OK ( Indice colonne d'ou l'on viens)
// NewColonne=col -> OK ( Indice colonne ou l'on arrive)
// NewRow=row -> OK ( Indice ligne ou l'on arrive)
var
i:integer;
begin
try
FLastCol:=OldColonne;
i:=NewColonne;
if Champ_Readonly.Size > 0 then
 if ((Champ_Readonly.bits[i] ) and (i<colcount-1)and (i > FixedCols)) then
begin
  if NewColonne < OldColonne then
  begin
   dec(i);
   end
   else
   begin
   inc(i);
  end;
end;
if i <> NewColonne then
 begin
  col:=i;
  NewColonne:=i;
 end;

//FLastRow
//col:=NewColonne;
//if (ColBooleenne(FLastCol)<>-1) then
//   begin
//   options:=options - [goAlwaysShowEditor,goEditing];
////   DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);
////   result:=true;
////   options:=options;
//   end
//   else
//   Begin
//   options:=options + [goAlwaysShowEditor,goEditing];
////   result:=true;
//   End;

  if Assigned(FOnColEnter) then FOnColEnter(OldColonne,FOldColonne,NewRow);

except
col:=FOldcolonne;
abort;
end;
end;

procedure TGrGrid.ColExit(OldColonne,LastRow:integer);
// BeforeColExit
// OldColonne = Colonne d'ou l'on viens -> Ok
// col = colonne ou l'on va -> Ok
// row = Ligne ou l'on va -> Ok

// BeforeColExit
// OldColonne = Colonne d'ou l'on viens ->
// LastRow = Ligne d'ou l'on viens -> ok
// col = colonne ou l'on va ->  Ok
// row = Ligne ou l'on va -> Ok

begin
try

   if assigned(FOnBeforeColExit) then FOnBeforeColExit(OldColonne);
//        Canvas.TextRect(ARect,I-2,ARect.Top+2,cells[ACol,ARow]);
//   case champ.items[OldColonne] of
//   GrCompte:Begin
//            if length(text)>0 then
//             begin
//              if text[1]<>'+' then
//                 if not (key  in [#8,#9,#13,#43,#48..#57]) then
//                 key:=#0;
//             end
//             else
//              if not (key  in [#8,#9,#13,#43,#48..#57]) then
//              key:=#0;
//            End;
//      GrNum:Begin
//            if not(key in [#9,#8,#13,#48..#57,DecimalSeparator])then
//              key:=#0;
//            End;
//     GrCurr:Begin
//             if Key in ['.', ','] then Key := DecimalSeparator;
//             if not(key in [#9,#8,#13,#43,#45,#48..#57,DecimalSeparator])then
//              key:=#0;
//
//             if (Key in [#32..#255]) and not IsValidChar(Key) then
////             if (Key in [#32..#255]) and not IsValidFloat(EditText,texteAux) then
//                begin
//                Key := #0;
//                end
//                else
//                if Key = #27 then
//                   begin
//                   Reset;
//                   Key := #0;
//                   end;
//
//            End;
//     GrDate:Begin
//              Cells[OldColonne,LastRow]:=
//              KeyPressDate(key);
//            End;
//     GrBool:Begin
//
//            End;
//   end;

   if Assigned(FOnColExit) then FOnColExit(OldColonne,LastRow);
except;
col:=OldColonne;
abort;
end;
end;

procedure TGrGrid.RowEnter(NewRow:integer);
// Row = NewRow = Ligne ou l'on rentre -> ok
// Col = Colonne ou l'on est -> ok
Begin
try
   FEtatGrille:=dsBrowse;
   StateChange(self);
//   end;
if (lignevide(NewRow) and lastRow(NewRow)) then
   begin
   FEtatGrille:=dsInsert;
   StateChange(self);
   end
   else
   begin
   FEtatGrille:=dsBrowse;
   StateChange(self);
   end;

FLastRow:=NewRow;
 FRowValue:=rows[Flastrow].text;
// Repaint;
 if Assigned(FOnRowEnter) then FOnRowEnter(Self,NewRow);
// Repaint;
//  update;
except
abort;
end;
End;


procedure TGrGrid.RowExit(FRow:integer);
// Row = Ligne ou l'on va rentrer -> ok
// Col = Colonne ou l'on est -> ok
var
GAction:boolean;
Begin
try
GAction:=true;
 if Assigned(FOnRowexit) then FOnRowexit(Self,FRow);
// if (row+1>1) then
//  if LastRow(row+1)then
//     if LigneVide(row+1) then
//     begin
//       SupprimeLigne(row+1);
////       suppr:=true;
//     end
// if FEtatGrille in [dsedit,dsInsert] then RowValidate(GAction);
except
abort
end;

End;



procedure TGrGrid.RowValidate(var valide:boolean);
var
GAction:boolean;
LastState:TDataSetState;
begin
LastState:=FEtatGrille;
   try
   GAction:=true;
   if Assigned(FOnRowValidate) then FOnRowValidate(self,valide,GAction,col);
//   if not LigneVide(row) then
//   begin
     FEtatGrille:=dsbrowse;
     StateChange(self);
//   end;
   except
   FEtatGrille:=LastState;
   GAction:=false;
//   StateChange(self);
//   row:=FLastrow;
//   col:=FLastcol;
   abort;
   //
   end;
end;


procedure TGrGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
        X, Y: Integer);
Begin
   try
   cellclick(col,row);
   inherited MouseUp(Button, Shift,X, Y);
//   //   DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);
//
//
//      if (Lignevide(rowcount-1) and (not lastrow(row))) then SupprimeLigne(rowcount-1);
   except
//   cellclick(Flastcol,FlastRow);
////   abort;
   end;
End;

procedure TGrGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
inherited MouseDown(Button,Shift,X,Y);
//DrawCell(FLastCol,FLastRow,CellRect(FLastCol,FLastRow),[]);

cellclick(col,row);
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
inherited ;//doEnter;
  FRowValue:=rows[row].text;
End;

function TGrGrid.CreateEditor: TInplaceEdit;
begin
    Result :=TGrInplaceEdit.Create(self) ;

    TGrInplaceEdit(Result).NumDecimal:=NumDecimal;
    TGrInplaceEdit(Result).AcceptNegatif:=AcceptNegatif;
   if FParamColor then
      begin
       InplaceEditColor:=Param.CelActiveSAisieColorFond;
       InplaceEditColorFont:=Param.CelActiveSAisieColorFont;
       TGrInplaceEdit(Result).Color := InplaceEditColor;
       TGrInplaceEdit(Result).Font.Color:=InplaceEditColorFont;
      end
    else
      Begin
       TGrInplaceEdit(Result).Color := clwhite;
       TGrInplaceEdit(Result).Font.Color:=clblack;
      End;

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
if ((ColonnesBool.Count > 0) and (i <> -1) and (i<ListeValeurListeBool.Count)) then
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
  RectLine:TRect;
RowTmp,ColTmp,I,L,lt:integer;
champCurr:boolean;
Begin
//if Acol <> 4 then
RowTmp:=FLAstRow;
champCurr:=false;
//if ((gdFocused in AState) and (gdSelected in AState)) then
//    if not (gdFixed in AState) then
//        begin
//    Canvas.Brush.Color:=clRed;
////    DrawCell(col,row,REctLine,AState);
////    Canvas.Brush.Color := holdColor;
//    end
//    else Canvas.Brush.Color:=holdColor;
    L:=ARect.Right - ARect.Left;
    lt:=Canvas.TextWidth(cells[ACol,ARow]);
    I:=L-lt+ARect.Left;
//    if cells[ACol,ARow] <> '' then
//             I:=L-lt;
    if not (gdFixed in AState) then
    begin
         if (gdSelected in AState) then
          begin
           if focused then
            begin
              Canvas.Brush.Color:=Param.CelActiveColorFond;
              Canvas.Font.Color:=Param.CelActiveColorFont;
            end
            else
            begin
             Canvas.Brush.Color:=Param.GrilleColorFond;
             Canvas.Font.Color:=clWindowText;
            end;
          end
          else
           begin
            Canvas.Brush.Color:=Param.GrilleColorFond;
             Canvas.Font.Color:=clWindowText;
           end;
    end;
inherited DrawCell(ACol, ARow, ARect, AState);

if ((ARow = 0) and (TextADroite)) then
  Canvas.TextRect(ARect,I-2,2,cells[ACol,ARow]);

if  ((Champ<>nil) and (Champ.Count>0))   then ChampCurr:=Champ.Items[Acol] = grcurr;
if((ARow > 0) and (ACol > 0) and (JustifieChampCurr) and ((Str_StrIsCurr(cells[ACol,ARow]))or(ChampCurr))) then
  Canvas.TextRect(ARect,I-2,ARect.Top+2,cells[ACol,ARow]);

//   HideEditor;
//if (FDisplayBool) then
if ((true) and (ColBooleenne(Acol)<>-1) and (ARow>0)) then
//if ((false) and (ARow>0) and (ACol >0)) then
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
//     if DrawCaseCocher(ACol,Arow) then
     if false then
      begin
         style :=DFCS_CHECKED;
      end
     else
         style := DFCS_BUTTONCHECK;{Case non cochée}

//     if FFlatCheckBox then
//     DrawFrameControl(Canvas.Handle, TmpRect, DFC_BUTTON, style or DFCS_FLAT);
//     else
         DrawFrameControl(Canvas.Handle, TmpRect, DFC_BUTTON, style);

//     if FFlatCheckBox then
//         if FFlatCheckBoxType = Normal then
//             begin
//?
//                 if ClipRegionExists then
//                     SelectClipRgn(Handle, OldClipRegion)
//                 else
//                     SelectClipRgn(Handle, 0);
//
//                 DeleteObject(OldClipRegion);
//                 InflateRect(TmpRect, -1, -1);
//                 Brush.Color := clGray;
//                 canvas.FrameRect(TmpRect);
//?
//             end;
 end;
if ((Arow=FLastRow) and (DessineContourLigne=true)) then
   begin
//   RowHeights[0]
    Canvas.Pen.Color:=Param.LigneContour;
    Canvas.Pen.Width:=2;
    RectLine:=Boxrect(1,FLastRow,ColCount,FLastRow);
//    Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Top+1),Point(RectLine.Right-1,RectLine.Bottom-1),point(RectLine.Left+1,RectLine.Bottom-1),Point(RectLine.Left+1,RectLine.Top+1)]);
    Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+1),
                     Point(RectLine.Right-1,RectLine.Top+1),
                     Point(RectLine.Right-1,RectLine.top+RowHeights[1]-1),
                     point(RectLine.Left+1,RectLine.Top+RowHeights[1]-1),
//                     Point(RectLine.Right-1,RectLine.Bottom-1),
//                     point(RectLine.Left+1,RectLine.Bottom-1),
                     Point(RectLine.Left+1,RectLine.Top+1)]);
 if col=Acol then
    begin
    RectLine:=CellRect(Col,Row);
//    DBEmprunt.Canvas.Polyline([Point(RectLine.Left+1,0),Point(RectLine.Left+1,RectLine.Top+1)]);
//    GrDBGridExemple.Canvas.Pen.Color:=$0000E600;Main.ContourCelActive;
    Canvas.Pen.Color:=Param.CelActiveContour;
    Canvas.Polyline([Point(RectLine.Left+1,RectLine.Top+2),Point(RectLine.Right-1,RectLine.Top+2),Point(RectLine.Right-1,RectLine.Bottom-2),point(RectLine.Left+1,RectLine.Bottom-2),Point(RectLine.Left+1,RectLine.Top+2)]);
   end;
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


Procedure TGrGrid.TitreColor(Enter:boolean);
begin
if FParamColor then
  if enter then
   begin
//    Columns[SelectedIndex].Title.Font.Style:=[fsbold];
//    Columns[SelectedIndex].Title.Font.Color:=clRed;
//    if DataSource <> nil then
//    if DataSource.State in [dsedit,dsInsert] then
//    Columns[SelectedIndex].Title.Font.Style:=Columns[SelectedIndex].Title.Font.Style+[fsItalic];
   end
   else
   begin
//    Columns[SelectedIndex].Title.Font.Style:=[];
//    Columns[SelectedIndex].Title.Font.Color:=param.CelFixeColorFont;
   end;
end;

Procedure TGrGrid.UpDateColorSansRepaint;
begin
if FParamColor then
   Begin
//     HighlightColor:=Param.CelActiveColorFond;
//     HighlightFontColor:=Param.CelActiveColorFont;
     // Param.CelActiveContour;
     InplaceEditColor:=Param.CelActiveSAisieColorFond;
     InplaceEditColorFont:=Param.CelActiveSAisieColorFont;
     FixedColor:=Param.CelFixeColorFond;
//     TitleFont.Color:=Param.CelFixeColorFont;
     Color:=Param.GrilleColorFond;
     Font.Color:=Param.GrilleColorFont;
   end
   else
   begin
    InplaceEditColor:=clWindow;
    InplaceEditColorFont:=clWindowText;
   end;


end;

Procedure TGrGrid.UpDateColor;
begin
if FParamColor then
   Begin
//     HighlightColor:=Param.CelActiveColorFond;
//     HighlightFontColor:=Param.CelActiveColorFont;
     // Param.CelActiveContour;
     InplaceEditColor:=Param.CelActiveSAisieColorFond;
     InplaceEditColorFont:=Param.CelActiveSAisieColorFont;
     FixedColor:=Param.CelFixeColorFond;
//     TitleFont.Color:=Param.CelFixeColorFont;
     Color:=Param.GrilleColorFond;
     Font.Color:=Param.GrilleColorFont;
   end
   else
   begin
    InplaceEditColor:=clWindow;
    InplaceEditColorFont:=clWindowText;
   end;
   refresh;
   Repaint;

end;

Procedure TGrGrid.cellsGr(ACol,ARow:integer;Valeur:string);
Begin
Try
if CompareStr(cells[ACol,ARow],Valeur) <> 0 then Change(self);
//if Champ.Items[Acol] = GrCurr then
// Begin
// if Arow >= FixedRows then
// if not empty(QueDesChiffres(Valeur)) then
//  Valeur:=FormatFloat(FFormatMonnaie + ';; ',StrToCurr(QueDesChiffres(Valeur)));
// End;

cells[ACol,ARow]:=Valeur;
except
abort;
end;
End;

Procedure TGrGrid.ShowEditor;
Begin
inherited;
End;

function TGrGrid.CompareStrings(const S1, S2: string;CaseSensitive:boolean): Integer;
begin
  if CaseSensitive then
    Result := AnsiCompareStr(S1, S2)
  else
    Result := AnsiCompareText(S1, S2);
end;
end.

