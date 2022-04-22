unit UString;

interface


Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,Controls, Dialogs,
      Forms,Registry, Db, DBTables, StdCtrls, Grids, menus;  

function RemplirADroite(ChaineARemplir,Caractere:string;
                                         LongueurFinale:integer):string;
function RemplirAGauche(ChaineARemplir:string;Caractere:char;
                                        LongueurFinale:integer): string;
function ChangeVirguleEnPoint(StFloat:String): String ;
function ViderAGauche(ChaineAVider:string;Caractere:char):string;
function RecordToStr(Enregistrement: TDataSet): String;

implementation

//****************************************************************
function RemplirADroite(ChaineARemplir,Caractere:string;
                        LongueurFinale:integer):string;
var
   i:integer;
begin
  Result:=ChaineARemplir;
  if Length(Result) > LongueurFinale then
    Result := Copy(Result,1,LongueurFinale)
  else
  begin
    for i:=1 to LongueurFinale-Length(ChaineARemplir)
      do Result := Result + Caractere;
  end;
end;
//******************************************************************************
//******************************************************************************
function RemplirAGauche(ChaineARemplir:string;Caractere:char;
                        LongueurFinale:integer):string;
var
   i:integer;
begin
  Result:=ChaineARemplir;
  if Length(Result) > LongueurFinale then
    Result := Copy(Result,1,LongueurFinale)
  else
  begin
    for i := LongueurFinale-Length(ChaineARemplir) downto 1
      do Result := Caractere + Result;
  end;
end;
//******************************************************************************
//******************************************************************************
function ChangeVirguleEnPoint(StFloat : String):String;// = decimalSeparator...
var
   i : Byte ;
begin
  if StFloat='' then
  begin
    Result:='0.0' ;
    exit ;
   end ;
  if Pos(',',StFloat)>0 then StFloat[Pos(',',StFloat)]:='.' ;
  i:=1 ;
  while i<=Length(StFloat) do
    if (StFloat[i]=Chr(160)) or (StFloat[i]=' ') then  delete(StFloat,i,1)
    else  inc(i) ;
  Result:=StFloat ;
end ;
//******************************************************************************
//******************************************************************************
function ViderAGauche(ChaineAVider:string;Caractere:char):string;
var
  i: integer;
begin
  i:=1;
  Result := ChaineAVider;
  while Copy(Result,i,1) = Caractere do Delete(Result,i,1);
end;

//******************************************************************************
//******************************************************************************
function RecordToStr(Enregistrement: TDataSet): String;
var
  i : Longint;
begin
  Result := '';
  for i := 0 to Enregistrement.FieldCount - 1 do
    Result := Result + '|' + Enregistrement.Fields[i].AsString;
end;
//******************************************************************************
//******************************************************************************

end.
 