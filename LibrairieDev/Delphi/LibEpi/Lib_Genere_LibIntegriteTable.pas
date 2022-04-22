unit Lib_Genere_LibIntegriteTable;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
     Controls, Dialogs,dbTables,db,LibSQL;

Const
C_ChampManque = 2;
C_ChampNom = 4;
C_ChampType = 8;
C_ChampTaille = 16;
C_ChampNum = 32;
C_ChampRequis = 64;
C_ChampPrecision = 128;
C_ChampTrop = 256;

 Procedure Cree_LibIntegriteTable(ListeTable:array of TStringList;DataBase:array of TDataBase);
 Function VerifIntegriteTable(Table:TTable):Integer;

implementation

Function DefNOMTableNOMChampType:TFieldDef;
begin
//  Result.DataType:=;
//  Result.FieldNo:=0;
//  Result.Name:='NomChamp';
//  Result.Precision:=0;
//  Result.Required:=false;
//  Result.Size:=0;
end;

Function CompareNOMTableNOMChampType(FieldDefCompare:TFieldDef):integer;
Begin
  result:=0;
  if FieldDefCompare.DataType <> DefNOMTableNOMChampType.DataType then result:=result+C_ChampType;
  if FieldDefCompare.FieldNo <> DefNOMTableNOMChampType.FieldNo then result:=result+C_ChampNum;
  if FieldDefCompare.Name <> DefNOMTableNOMChampType.Name then result:=result+C_ChampNom;
  if FieldDefCompare.Precision <> DefNOMTableNOMChampType.Precision then result:=result+C_ChampPrecision;
  if FieldDefCompare.Required <> DefNOMTableNOMChampType.Required then result:=result+C_ChampRequis;
  if FieldDefCompare.Size <> DefNOMTableNOMChampType.Size then result:=result+C_ChampTaille;
End;

Function VerifIntegriteTable(Table:TTable):Integer;
var
i:integer;
Begin
for i:=0 to Table.FieldDefs.Count-1 do
 begin
   case i of
     0:Begin
         if Table.FieldDefs[i].DataType <> ftString then
           result:=result + C_ChampType;
       End;

     1: ;
   else ;

   end;
 end;
End;

Procedure Cree_LibIntegriteTable(ListeTable:array of TStringList;DataBase:array of TDataBase);
var
i,j:integer;
TexteResult:TStringList;
Table:TTable;
Begin
Table:=TTable.Create(nil);
TexteResult:=TStringList.Create;
TexteResult.Add('unit LibIntegriteTable;');
TexteResult.Add('');
TexteResult.Add('interface');
TexteResult.Add('');
TexteResult.Add('Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,');
TexteResult.Add('Controls, Dialogs,dbTables,db;');
TexteResult.Add('');
TexteResult.Add('Const');
TexteResult.Add('');
TexteResult.Add(' C_ChampManque = 2;');
TexteResult.Add(' C_ChampNom = 4;');
TexteResult.Add(' C_ChampType = 8;');
TexteResult.Add(' C_ChampTaille = 16;');
TexteResult.Add(' C_ChampNum = 32;');
TexteResult.Add(' C_ChampRequis = 64;');
TexteResult.Add(' C_ChampPrecision = 128;');
TexteResult.Add(' C_ChampTrop = 256;');
TexteResult.Add('');

TexteResult.Add('Type');
TexteResult.Add('');
for i:=0 to High(ListeTable) do
 Begin
 Table.Close;
 Table.DatabaseName:=DataBase[i].DatabaseName;
  for j:=0 to ListeTable[i].Count-1 do
   begin
    try
     Table.Close;
     Table.TableName:=ListeTable[i].Strings[j];
     Table.Open;
//     CreeTypeInfos(TexteResult,Table);
    except
     Table.Close;
    end;
   end;
 End;

for i:=0 to High(ListeTable) do
 Begin
 Table.Close;
 Table.DatabaseName:=DataBase[i].DatabaseName;

  for j:=0 to ListeTable[i].Count-1 do
   begin
    try
     Table.Close;
     Table.TableName:=ListeTable[i].Strings[j];
     Table.Open;
//     Cree_Proc_Initialise_TypeInfos(TexteResult,Table,false);
//     Cree_Proc_Remplit_TypeInfos(TexteResult,Table,false);
//     Cree_Function_Infos_TypeInfos(TexteResult,Table,false);
    except
     Table.Close;
    end;
   end;
 End;

TexteResult.Add('implementation');
TexteResult.Add('');
TexteResult.Add('Uses');
TexteResult.Add('  LibSQL;');

for i:=0 to High(ListeTable) do
 Begin
 Table.Close;
 Table.DatabaseName:=DataBase[i].DatabaseName;
  for j:=0 to ListeTable[i].Count-1 do
   begin
    try
     Table.Close;
     Table.TableName:=ListeTable[i].Strings[j];
     Table.Open;
//     Cree_Proc_Initialise_TypeInfos(TexteResult,Table,True);
//     Cree_Proc_Remplit_TypeInfos(TexteResult,Table,True);
//     Cree_Function_Infos_TypeInfos(TexteResult,Table,True);
    except
     Table.Close;
    end;
   end;
 End;

TexteResult.Add('');
TexteResult.Add('End.');
TexteResult.SaveToFile('C:\Js\Epicea-2\Sources\E2_LibIntegriteTableTmp.pas');
showmessage('Ok');
TexteResult.Free;
End;

end.
