unit Lib_Genere_LibInfosTable;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
     Controls, Dialogs,dbTables,db,LibSQL;

Procedure Cree_LibInfosTable(ListeTable:array of TStringList;DataBase:array of TDataBase);
Function CreeTypeInfos(Var TexteResult:TStringList; Table:TTable):boolean;
Function Cree_Proc_Initialise_TypeInfos(Var TexteResult:TStringList; Table:TTable;EnteteCorps:boolean):boolean;
Function Cree_Proc_Remplit_TypeInfos(Var TexteResult:TStringList; Table:TTable;EnteteCorps:boolean):boolean;
Function Cree_Function_Infos_TypeInfos(Var TexteResult:TStringList; Table:TTable;EnteteCorps:boolean):boolean;
function StrValFonctionTypeChamp(fieldtype: TFieldType):string;
FUNCTION TraiteMotReserve(NomChamp,TexteAjoute:String):string;
implementation

function StrValFonctionTypeChamp(fieldtype: TFieldType):string;
begin
  case FieldType of
    ftUnknown :    result := '''''';// champ inconnu ou non déterminé
    ftString :    result := '''''';//  caractère ou chaîne
    ftSmallInt :  result := '0';// entier sur 16 bits
    ftInteger :   result := '0';// entier sur 32 bits
    ftWord :      result := '0';// entier non signé sur 16 bits
    ftFloat :     result := '0.00';// numérique à virgule flottante
    ftCurrency :  result := '0';// monétaire
    ftDate :      result := '0';// date
    ftTime :      result := '0';// heure
    ftDateTime :  result := '0';// date et heure
    ftBytes :     result := '0'; //nbre fixe d'octets (stokage binaire)
    ftVarBytes :  result := '0'; //Nombre variable d'octets (stockage binaire)
    ftAutoInc :   result := '0';// compteur auto. (entier sur 32 bits)
    ftBlob :      result := '''''';// blob (Binary Large OBject)
    ftMemo :      result := '''''';// mémo texte
    ftFmtMemo :   result := '''''';// mémo texte formaté
    ftBCD :       result := '0'; //Décimal Codé Binaire
    ftBoolean :   result := 'false'; // booléen
    ftGraphic :   result := ''; // bitmap
    ftParadoxOle :result := '';// OLE Paradox
    ftDBaseOle :  result := ''; // OLE dBase
    ftTypedBinary:result := '';// binaire typé
    ftCursor :    result := '';// curseur de sortie d'une procédure stockée
                                      // Oracle (TParam uniquement)
  end;
end;

FUNCTION TraiteMotReserve(NomChamp,TexteAjoute:String):string;
Begin
result:=NomChamp;
if UpperCase(NomChamp)='TYPE' then result:=NomChamp+TexteAjoute;
if UpperCase(NomChamp)='DIV' then result:=NomChamp+TexteAjoute;

End;


Procedure Cree_LibInfosTable(ListeTable:array of TStringList;DataBase:array of TDataBase);
var
i,j:integer;
TexteResult:TStringList;
Table:TTable;
Begin
Table:=TTable.Create(nil);
TexteResult:=TStringList.Create;
TexteResult.Add('unit LibInfosTable;');
TexteResult.Add('');
TexteResult.Add('interface');
TexteResult.Add('');
TexteResult.Add('Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,');
TexteResult.Add('Controls, Dialogs,dbTables,db;');
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
     CreeTypeInfos(TexteResult,Table);
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
     Cree_Proc_Initialise_TypeInfos(TexteResult,Table,false);
     Cree_Proc_Remplit_TypeInfos(TexteResult,Table,false);
     Cree_Function_Infos_TypeInfos(TexteResult,Table,false);
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
     Cree_Proc_Initialise_TypeInfos(TexteResult,Table,True);
     Cree_Proc_Remplit_TypeInfos(TexteResult,Table,True);
     Cree_Function_Infos_TypeInfos(TexteResult,Table,True);
    except
     Table.Close;
    end;
   end;
 End;

TexteResult.Add('');
TexteResult.Add('End.');
TexteResult.SaveToFile('C:\Projet\Epicea-2\Sources\E2_LibInfosTableTmp.pas');
showmessage('Ok');
TexteResult.Free;
End;


Function CreeTypeInfos(Var TexteResult:TStringList; Table:TTable):boolean;
var
i:integer;
Begin
TexteResult.Add('');
TexteResult.Add('TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+' = record');
for i:=0 to Table.FieldCount -1 do
 Begin
  TexteResult.Add('         '+TraiteMotReserve(Table.Fields[i].FieldName,copy(Table.tableName,1,length(Table.tableName)-3))+':'+RetrouverTypeChampPascal(Table.Fields[i].DataType)+';');
 End;
TexteResult.Add('         ResultInfos:Boolean;');
TexteResult.Add('end;');
TexteResult.Add('');

End;

//   procedure Intitialise_<NomType>(var <VarType>:<NomType>);

Function Cree_Proc_Initialise_TypeInfos(Var TexteResult:TStringList; Table:TTable;EnteteCorps:boolean):boolean;
var
i:integer;
Begin
if not EnteteCorps then
 begin
   TexteResult.Add('Procedure Initialise_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(var Infos'+copy(Table.tableName,1,length(Table.tableName)-3)+':TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+');');
 end
 else
  begin // Creation de l'entete et du corps
   TexteResult.Add('Procedure Initialise_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(var Infos'+copy(Table.tableName,1,length(Table.tableName)-3)+':TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+');');
   TexteResult.Add('Begin');
    for i:=0 to Table.FieldCount -1 do
     Begin
      TexteResult.Add('Infos'+copy(Table.tableName,1,length(Table.tableName)-3)+'.'+TraiteMotReserve(Table.Fields[i].FieldName,copy(Table.tableName,1,length(Table.tableName)-3))+':='+StrValFonctionTypeChamp(Table.Fields[i].DataType)+';');
     End;

   TexteResult.Add('end;');
  end;
End;

//   procedure Remplit_<NomType>(DataSet:TDataSet;Var <VarType>:<NomType>);
Function Cree_Proc_Remplit_TypeInfos(Var TexteResult:TStringList; Table:TTable;EnteteCorps:boolean):boolean;
var
i:integer;
Begin
if not EnteteCorps then
 begin
   TexteResult.Add('Procedure Remplit_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(DataSet:TDataSet;var Infos'+copy(Table.tableName,1,length(Table.tableName)-3)+':TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+');');
 end
 else
  begin // Creation de l'entete et du corps
   TexteResult.Add('Procedure Remplit_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(DataSet:TDataSet;var Infos'+copy(Table.tableName,1,length(Table.tableName)-3)+':TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+');');
   TexteResult.Add('Begin');
   TexteResult.Add('Initialise_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(Infos'+copy(Table.tableName,1,length(Table.tableName)-3)+');');
   for i:=0 to Table.FieldCount -1 do
     Begin
      TexteResult.Add('Infos'+copy(Table.tableName,1,length(Table.tableName)-3)+'.'+TraiteMotReserve(Table.Fields[i].FieldName,copy(Table.tableName,1,length(Table.tableName)-3))+':='+'DataSet.FindField('''+Table.Fields[i].FieldName+''').As'+RetrouverTypeChamp(Table.Fields[i].DataType)+';');
     End;
   TexteResult.Add('end;');
  end;
End;

// - Une Fonction de recherche par table qui retourne une var de type <NomType>
//
//   Function Infos_<NomType>(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):<NomType>;
//   begin
//    Intitialise_<NomType>(result);
//    result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
//    if result.ResultInfos then
//     Remplit_<NomType>(DataSet,result);
//   end;
Function Cree_Function_Infos_TypeInfos(Var TexteResult:TStringList; Table:TTable;EnteteCorps:boolean):boolean;
var
i:integer;
Begin
if not EnteteCorps then
 begin
   TexteResult.Add('Function Infos_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+';');
 end
 else
  begin // Creation de l'entete et du corps
   TexteResult.Add('Function Infos_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+';');
   TexteResult.Add('Begin');
   TexteResult.Add('Initialise_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(result);');
   TexteResult.Add('result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);');
   TexteResult.Add('if result.ResultInfos then');
   TexteResult.Add('Remplit_TInfos'+copy(Table.tableName,1,length(Table.tableName)-3)+'(DataSet,result);');
   TexteResult.Add('end;');
  end;
End;
end.
