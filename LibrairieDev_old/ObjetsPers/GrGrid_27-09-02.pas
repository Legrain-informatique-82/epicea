unit GrGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,Lib1,db,E2_Decl_Records,GrDBGrid,GR_Librairie_Obj;

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
FChamp_Readonly:TBits;
//    FChamp_Readonly:TListBool;
    FNumDecimal:integer;
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
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        procedure Loaded; override;
        function CreateEditor: TInplaceEdit; override;
        procedure AjouteLigne;
        Procedure InsertLigne(rang:integer);
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
        property Champ_Readonly:TBits read FChamp_Readonly write FChamp_Readonly;
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
        Procedure cellsGr(ACol,ARow:integer;Valeur:string);
        Procedure ShowEditor;


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
  FChamp_Readonly:=TBits.Create;

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
if Champ_Readonly.Size > 0 then
if  (Champ_Readonly.Bits[ACol] ) then
    result:=false;
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
  if key = Vk_Space then
  if Cols[col].Objects[0] <> nil then
    if (Cols[col].Objects[0] is TBits) then
     begin
      DrawCell(Col,Row,CellrEct(col,row),[gdSelected]);
      key:=0;
     end;

  //FValidation:=false;
  insert:=false;
  suppr:=false;
  validate:=true;
  Arow:=row;
  Acol:=col;
  //if assigned(FOnBeforeKeyDown) then FOnBeforeKeyDown(self,key,shift);
  if ((key=vk_tab) and (LastCol(col)) and (LastRow(Row))) then
    key:=vk_return;
  //if ((key=vk_return)) then
  //   key:=vk_tab;
  //if key= vk_Up then
  //    Begin
  //     if (row>1) then
  //      if LastRow(row)then
  //         if LigneVide(row) then
  //         begin
  ////           fvalidation:=true;
  //         end;
  //     End;

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
  //            if FetatGrille in [dsinsert,dsEdit]then
  //                RowValidate(validate);
             if (row+1>1) then
              if LastRow(Arow)then
                 if LigneVide(Arow) then
                 begin
                   SupprimeLigne(Arow);
                   suppr:=true;
                 end;
  //            cellclick(col,row);
  //            abort;
           end;
    vk_delete:begin
             SupprimeLigne(row);
             end;
    end;

    if Row <> arow then
      Begin
  ////       if fvalidation=false then
  ////       begin
  //         RowValidate(validate);
  ////         FValidation:=true;
  ////       end;
  //      rowexit;
  //       rowenter(row);
  //
  ////     Fvalidation:=false;
      End;


  //   if col <> ACol then
  //     Begin
  //         colExit(Acol,arow);
  ////         ColEnter(Acol,Col,Row);
  //     End;
  /////////////////////////
  case key of
  vk_return,VK_TAB:Begin
           if (LastCol(acol)) then
               begin
  //              fvalidation:=true;
               if FEtatGrille in [dsinsert,dsedit]then
               RowValidate(validate);
               if validate  then
                 begin
                 if ((FAjoutAuto) and (not LigneVide(Arow))and (LastRow(Arow))) then
                 begin
                 //col:=1;
                 GenereLigne(false,Arow+1,1);
                 insert:=true;
                 end;
                 end;
               end;
            End;

  vk_down:Begin
           if FEtatGrille in [dsinsert,dsedit]then
           begin
           //if FValidation=false then
  //          begin
  //          fvalidation:=true;
           RowValidate(validate);
  //          end;
           end;
           if Fetatgrille=dsbrowse then
           begin//si etat dsbrowse
           if (LastRow(Arow))and (not LigneVide(Arow) and (NombreLigneVide<>1)) then
             begin//si derniere ligne et pas vide
                if FAjoutAuto then
                begin
                GenereLigne(false,Arow+1,1);
                row:=rowcount-1;
                //col:=1;
                insert:=true;
                end;
                //else
                //rowexit;
             end;//si derniere ligne et pas vide
             //else
             //  if not(LastRow(Arow))then
             //  rowexit;
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
  //                else
  //                if FetatGrille in [dsinsert,dsEdit]then
  //                RowValidate(validate);
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
                  //col:=1;
                  insert:=true;
                  end;

               end;
           end;
    if ((Row <> arow) or (col <> ACol)) then
      Begin
  //       if fvalidation=false then
  //       begin
  //          if FetatGrille in [dsinsert,dsEdit]then
  //         RowValidate(validate);
  //         FValidation:=true;
  //       end;
       if (Row <> arow) then
           if  ((not insert) and (not suppr)) then rowexit(arow);
  //      if col <> ACol then
  //         Begin
  //             if insert then colExit(Acol,arow);
  //         End;
       // if ((not insert) and (not suppr)) then rowenter(row);
  //      if (Row <> arow) then
  //          if not suppr then rowenter(row);
  //      if col <> ACol then
  //         Begin
  //             ColEnter(Acol,Col,Row);
  //         End;
  //     Fvalidation:=false;
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
//row:=RowCount-1;
//col:=1;
//FEtatGrille:=dsInsert;
//StateChange(self);
End;


procedure TGrGrid.GenereLigne(Insert:boolean;NewRow,NewColonne:integer);
var
ColAux,RowAux:integer;
Begin
//ColAux:=col;
RowAux:=row;
   if Assigned(FOnBeforeNewLigne) then FOnBeforeNewLigne(Self,NewRow);
      if ((LastRow(NewRow)) and (not insert)) then
          AjouteLigne
        else
          InsertLigne(NewRow);
//     Repaint;
     col:=NewColonne;
    try
    if Assigned(FOnNewLigne) then FOnNewLigne(Self,NewRow);
    rowexit(RowAux);
    except
    SupprimeLigne(newrow);
//    Repaint;
    end;//fin du try
End;

Procedure TGrGrid.InsertLigne(rang:integer);
var
i:integer;
Begin
AjouteLigne;
//FEtatGrille:=dsInsert;
//StateChange(self);
for i:=RowCount-1 Downto Rang do
    Begin
      Rows[i]:=Rows[i-1];
    End;
    Rows[Rang].Clear;
//rowexit;
Row:=Rang;
//col:=1;
//Cells[0,rang]:='*';
//rowEnter;
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
 if ((Champ_Readonly.Bits[i-1] ) and (i<colcount)and (i > FixedCols)) then
begin
  if NewColonne < OldColonne then
  begin
   dec(i);
   NewColonne:=i;
   col:=i;
   end
   else
   begin
   inc(i);
//   SelectCell(i,NewRow);
//   NewColonne:=i;
//  MoveColRow(i,row,false,false);
  col:=i;
  end;
end
else
begin
// SelectCell
// col:=i;
end;
//if i <> NewColonne then
// begin
//  col:=i;
//  NewColonne:=i;
// end;
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
   case champ.items[OldColonne] of
   GrCompte:Begin
            End;
      GrNum:Begin
            End;
     GrCurr:Begin
             if InplaceEditor <> nil then
              if InplaceEditor.Visible then
               begin
                cells[OldColonne,LastRow]:=QueDesChiffres(InplaceEditor.Text);
               end;
             cells[OldColonne,LastRow]:=QueDesChiffres(cells[OldColonne,LastRow]);
//             cells[OldColonne,LastRow]:=CurrToStr(StrTocurr(cells[OldColonne,LastRow]));

            End;
     GrDate:Begin
            End;
     GrBool:Begin

            End;
   end;
   if assigned(FOnBeforeColExit) then FOnBeforeColExit(OldColonne);

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
//if lignevide(FLastRow) {and (FEtatGrille=dsInsert) }then
//   begin
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
   case champ.items[Col] of
   GrCompte:Begin
            End;
      GrNum:Begin
            End;
     GrCurr:Begin
             if InplaceEditor <> nil then
              if InplaceEditor.Visible then
               begin
                cells[Col,FRow]:=QueDesChiffres(InplaceEditor.Text);
                cells[Col,FRow]:=CurrToStr(StrTocurr(cells[Col,FRow]));
               end;
             cells[Col,FRow]:=QueDesChiffres(cells[Col,FRow]);
             cells[Col,FRow]:=CurrToStr(StrTocurr(cells[Col,FRow]));
            End;
     GrDate:Begin
            End;
     GrBool:Begin

            End;
   end;
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
  RectLine:TRect;
RowTmp,ColTmp:integer;
Begin

//if Acol <> 4 then
RowTmp:=FLAstRow;
//if ((gdFocused in AState) and (gdSelected in AState)) then
//    if not (gdFixed in AState) then
//        begin
//    Canvas.Brush.Color:=clRed;
////    DrawCell(col,row,REctLine,AState);
////    Canvas.Brush.Color := holdColor;
//    end
//    else Canvas.Brush.Color:=holdColor;
//if acol = 2 then
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
//   HideEditor;
//if (FDisplayBool) then


//if ((true) and (ColBooleenne(Acol)<>-1) and (ARow>0)) then
//if true then

if ((false) and (ARow>0) and (ACol >0)) then
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
 if Cols[ACol].Objects[0] <> nil then
   if (Cols[ACol].Objects[0] is TBits) then
     if (Cols[ACol].Objects[0] as TBits).Bits[ARow] then
      begin
         if InplaceEditor <> nil then
          begin
            InplaceEditor.hide;
            InplaceEditor.Update;
          end;
         style :=DFCS_CHECKED;
      end
     else
      begin
         style := DFCS_BUTTONCHECK;{Case non cochée}
         if InplaceEditor <> nil then
          begin
            InplaceEditor.hide;
            InplaceEditor.Update;
          end;
      end;   

//     if FFlatCheckBox then
     DrawFrameControl(Canvas.Handle, TmpRect, DFC_BUTTON, style + DFCS_FLAT+DFCS_PUSHED);
//     else
//         DrawFrameControl(Canvas.Handle, TmpRect, DFC_BUTTON , style);

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


end.

