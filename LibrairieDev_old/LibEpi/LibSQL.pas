{***************************************************************
 *
 * Unit Name: LibSQL
 *
 *

 ****************************************************************}

unit LibSQL;

interface


uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls,Db, DBTables,
    dialogs,Forms,Lib_chaine,LibRessourceString,Gr_Librairie_Obj,E2_Decl_Records
    ,DBIProcs, DBITypes, TStringlistLGR,
    Variants,SimpleDS,sqlExpr,
    FileUtil;

//Const
//RetourChariotDouble = #10#13#10#13;
//RetourChariotSimple = #10#13;
// C_ParamFTP = 'ParamFTP.txt';
//connexionInvalide = 'Vos paramètres de connexion ne sont pas valides (login ou mot de passe)'+
//                     retourchariotsimple+'ou vous n''êtes pas connecté à internet';
Type

  //TTabValeur=array[0..2] of string;
  TTabValeur=variant;

//  TParamFTP= record
//  Source:string;
//  Dest:string;
//  Fichier:string;
//  Serveur:string;
//  Login :string;
//  PassWord :string;
//  Effacer : string;
//  Auto : string;
//  Prevenir:string[1];
//end;

////////////////////////////////////////////////////////////////////////////////
   procedure AjouterChampDsTable(base:TDatabase;Table:TTable;nomTable,ChampDest,
                                     ChampSource,DataType,valeur,Filtre:string);
   procedure SupprimerChampDsTable(base:TDatabase;Table:TTable;nomTable,ChampDest,
                                     ChampSource,DataType,valeur,Filtre:string);
   procedure MettreAJourChampDsTable(base:TDatabase;Table:TTable;nomTable,ChampDest,
                                     ChampSource,DataType,valeur,Filtre:string);
////////////////////////////////////////////////////////////////////////////////
   procedure SupprimerTable(base:TDatabase;Table:TTable);overload;
   procedure SupprimerTable(NomBase:string;NomTable:string);overload;
   procedure CreerTable(base:TDatabase;Table:TTable;nomTable:string);
   procedure viderTable(Table: TTable);
////////////////////////////////////////////////////////////////////////////////
   procedure ListerChampsTable(table:TTable);{affiche le nomChamp et son type}
   procedure limiteVue(Base:TDatabase;champ:string;table:TTable;mini,maxi:variant);
   function RetrouverTypeChamp(fieldtype: TFieldType):string;
   function RetrouverTypeChampPascal(fieldtype: TFieldType):string;
   function CasType(fieldtype:TFieldType):integer;
   function VerifierVide(Base:TDataBase;table:TTable;nomChamp:string):boolean;
   function RechercheInfo(Base:TDatabase;nomTable,nomChamp,Valeurchamp,
                                                    champRetour: string):string;
   function RenvoieInfoSurTableDiverse(valeur:string;TableRech:ttable;ChRech:string;
              const ChRecup:array of string;var ValeurRecup:variant):string;

   ////////////////////////////////////////////////////////////////////////////////
Procedure TableRefresh(DataSet:TDataSet;ChampId:string);

Procedure TableRefreshSurClose(DataSet:TDataSet;ChampId:string);

Function CreeFiltreOU(Champ : string ; const Val : array of const):string;
Function CreeFiltreET(const Champ : array of const ; const Val : array of const):string;
Function CreeFiltreETPlage(const Champ : array of const ; const Val : array of const):string;
Procedure InitChampAfterInsert(Valeur : array of const ; DataSet:TDataset);
Procedure OuvrirTouteTable(MessErreur:string;Controle:TControl);
Procedure OuvreTables(MessErreur:string;DataSet : array of TDataset);
Procedure FermerTouteTable(MessErreur:string;Controle:TControl);
Procedure ExecuteProcInit(NomProc:string);
Function ConstruitRequeteInsert(Table:TTable):String;
Procedure ImportTable(Valeurs:array of const;DataSet:TDataSet);
Function SommeTotauxGeneric(Champs :array of string;DataSet:TDataSet):TTotauxGeneric;
Function SommeTotauxGenericQuery(Champs :array of string;DataSet:TDataSet):TTotauxGeneric;
Function ChampTableVersListe(Champ :string;DAtaSet:TDataset):TStringList;
Function ChampTableVersListeLGR(Champ :string;DAtaSet:TDataset):TStringlistLGR1;overload
Function ChampTableVersListeEx(const Champ :array of string;DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean=false):TStringList;overload;
Function ChampTableVersListeEx(DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean=false):TStringList;overload;
Function ChampTableVersListeExLGR(DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean=false):TStringListLGR1;

Function ChampTableVersVarListe(Champ :string;DAtaSet:TDataset;var Liste:TStringList):boolean;
Function ChampTableVersVarListeEx(const Champ :array of string;DAtaSet:TDataset;var Liste:TStringList;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean=false):boolean;
Function ChampTableVersListeEx(const Champ :TStringList;DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean=false):TStringList;overload;
Function SQL_ChangeAliasDsRequete(Query:TQuery;NomAliasDsQuery,NomNewAlias:string):string;
Procedure AffichevaleurDsTable(mess:string;Dataset:TDataset);
Function CloneDataSet(DataSetOrg:TDataSet;DataSetVar:TDataSet):TDataSet;
Procedure FormateMonnaieField(DataSet:TDataset;FormatMonnaie,EditFormat:string);
Procedure FormateValidCharCurrField(DataSet:TDataset;FieldChars:TFieldChars);
Procedure FormateValidCharFloatField(DataSet:TDataset;FieldChars:TFieldChars);
Procedure TableDisableControlBookMark(DAtaSet:TDataset;var Bookmark:TBookMark);
Procedure TableEnableControlBookMark(DAtaSet:TDataset;var Bookmark:TBookMark);
Function DataSetRechercher(DataSetRech:TDataSet;Filtre:String;Filtree:Boolean):TDataSet;
Function GrLocate(DataSet:TDataSet;Champ:string;const Valeur:array of variant):Boolean;
Procedure TableSauveEtatFiltre(Table:TDataSet;Var EtatFiltre:TEtatFiltre);
//Procedure TableSauveEtatFiltreSimpleDataset(Table:TDataSet;Var EtatFiltre:TEtatFiltre);
Procedure QuerySauveEtatFiltre(Query:TQuery;Var EtatFiltre:TEtatFiltre);
Procedure TableRestoreEtatFiltre(Table:TDataSet;Var EtatFiltre:TEtatFiltre);
Procedure QueryRestoreEtatFiltre(Query:TQuery;Var EtatFiltre:TEtatFiltre);
Procedure TableAjoute(Table:TDataSet);
Function FiltrageDataSet(DataSet:TDataSet;Filtre:String):Boolean;
Function DeFiltrageDataSet(DataSet:TDataSet):Boolean;
Procedure TableGereRollBack(Dataset:Tdataset);
Procedure TableGereCommit(Dataset:Tdataset);
Procedure TableGereStartTransaction(dataset:Tdataset);
Function MaxId_Query(Table:TTable;NomChampId:string):Integer;
Function MaxId_QueryPostgre(Table:TSimpleDataSet;NomChampId:string):Integer;
Function MinId_QueryPostgre(Table:TSimpleDataSet;NomChampId:string):Integer;
Function MinId_Query(Table:TTable;NomChampId:string):Integer;
Function AffectValeurAChamp(Field:TField;Valeur:Variant):Boolean;
Procedure TableGerePost(Dataset:Tdataset);
Procedure TableGereInsert(Dataset:Tdataset);
Procedure TableGereEdit(Dataset:Tdataset);
Procedure TableGereDelete(Dataset:Tdataset);
Function EtatDataSetString(DataSet:TDataSet):String;overload
Function EtatDataSetString(State:TDataSetState):String;overload;
Function NBRecord_Str(DataSet:TDataSet):String;
procedure TableCreatePassWord(ADatabase, ATable:string; PassWord:DbiName);
Function AffecteEvenement(ObjetSource,ObjetDestination:TObject):Boolean;
procedure ReEnableControls (DataSet: TDataSet);

procedure InitDatasetEvent_A_Nil_Sur_Form(Dataset:array of Tcomponent);
Function TableDuplique(DataSet : TDataSet;RepSource,NomCopy,RepCopy:String;Ecrase:Boolean):Boolean;
procedure CopierStructure(Source,Cible: string);
Function TableRestaure(DataSet : TDataSet;NomTable,AliasSource:String;Ecrase:Boolean):Boolean;
function PrecisionFloat(Valeur:string;Var key:Char;Precision:integer=2):string;
Procedure TableGereClose(Dataset:Tdataset);
Procedure TableGereCancel(Dataset:Tdataset);
Procedure TableGereOpen(Dataset:Tdataset);

Function NomChampVersListeEx(DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean):TStringList;


//Function LitFichierParamFTP(FileName:string;Var ParamFTP:TParamFTP;AfficheMessage:boolean;
//         nomDossier,ServeurFTP:String;ParamFTP_Entreprise:TParamFTP;RepertoireDossier:string):boolean;
//procedure EcritFichierParamFTP(ParamFTP,ParamFTP_Entreprise:TParamFTP);
//procedure InitParamFTP(Var ParamFTP:TParamFTP;nomDossier,ServeurFTP:String);

implementation
uses     DMRecherche_Obj, LibFichRep, E2_Librairie_Obj, LibDates;{ isa  le  17/08/04 }

procedure TableCreatePassWord(ADatabase, ATable:string; PassWord:DbiName);
 var
   ADB       :TDataBase;
   SaveKC    : Boolean;
   PdxStruct : CRTblDesc;
 begin

 with TTable.Create(nil) do
   try
    DatabaseName := ADatabase;
     TableName := ATable;
     Exclusive := True;
     Open;
     ADB := DAtabase;
     SaveKC := ADB.KeepConnection;
     ADB.KeepConnection := True;
     try
      Close;
       FillChar(PdxStruct,SizeOF(PdxStruct),0);
       StrPCopy(PdxStruct.szTblName,ATable);
       PdxStruct.bPack := False;
//       PdxStruct.bProtected:= TRUE;
       PdxStruct.bProtected:= false;
       {Esta es la clave que se pondrá en la tabla}
//       PdxStruct.szPassword:=PassWord;
       Check(DbiDoRestructure(ADB.Handle,1,
         @PdxStruct,nil,nil,nil,False));
     finally
      ADB.KeepConnection := SaveKC;
     end;
   finally
    Free;
   end;
 end;


procedure viderTable(Table: TTable);
var
OldOpen:Boolean;
begin
Table.DisableControls;
OldOpen:=Table.Active;
if OldOpen then Table.Close;
Table.EmptyTable;
if OldOpen then Table.Open;
Table.EnableControls;
end;

procedure SupprimerTable(base:TDatabase;Table:TTable);
var
TableTmp:TTable;
begin
try
TableTmp:=TTable.Create(nil);
  with Tabletmp do
  begin
    Active := False;
    DatabaseName := Base.Databasename;
    Tabletmp.TableName := table.TableName;
    DeleteTable;
  end;
except
   if(FileExists(IncludeTrailingPathDelimiter(base.Directory)+table.TableName))then
     raise;
end;
end;

procedure SupprimerTable(NomBase:string;NomTable:string);
var
TableTmp:TTable;
begin
TableTmp:=TTable.Create(nil);
  with Tabletmp do
  begin
    Active := False;
    DatabaseName := NomBase;
    Tabletmp.TableName := NomTable;
    DeleteTable;
  end;
end;

procedure CreerTable(base:TDatabase;Table:TTable;nomTable:string);
begin
  with Table do
  begin
    Active := False;
    DatabaseName := base.databasename;
    TableName := nomtable;
    { description des champs }
    with FieldDefs do
    begin
      Clear;
    {liste éventuelle des champs...}
  //    Add(nomchamp1, ftInteger, 0, True);
  //    Add(nomchamp2, ftString, 30, False);
    end;
    {description des index }
    with IndexDefs do
    begin
      Clear;
      { Le premier index n'a pas de nom: il s'agit d'une clé primaire Paradox }
  //    Add('', nomchamp1, [ixPrimary, ixUnique]);
  //    Add('champ2Indx', nomchamp2, [ixCaseInsensitive]);
    end;
    CreateTable;
  end;
end;

procedure ListerChampsTable(table:TTable);
var
   i: Integer;
   Info: String;
begin
  info := '';
   Info := 'Les champs de la table ' + table.Name +
           ' sont:'#13#10#13#10;
   for i := 0 to Table.FieldCount - 1 do
      Info := Info +Table.Fields[i].FieldName+' / '+RetrouverTypeChamp(Table.Fields[i].DataType) + #13#10;
   table.close;
   ShowMessage(Info);
end;


function RetrouverTypeChamp(fieldtype: TFieldType):string;
begin
  case FieldType of
    ftUnknown :    result := 'String';// champ inconnu ou non déterminé
    ftString :    result := 'String';//  caractère ou chaîne
    ftSmallInt :  result := 'Integer';// entier sur 16 bits
    ftInteger :   result := 'Integer';// entier sur 32 bits
    ftWord :      result := 'Integer';// entier non signé sur 16 bits
    ftFloat :     result := 'Float';// numérique à virgule flottante
    ftCurrency :  result := 'Currency';// monétaire
    ftDate :      result := 'DateTime';// date
    ftTime :      result := 'DateTime';// heure
    ftDateTime :  result := 'DateTime';// date et heure
    ftBytes :     result := 'Integer'; //nbre fixe d'octets (stokage binaire)
    ftVarBytes :  result := 'Integer'; //Nombre variable d'octets (stockage binaire)
    ftAutoInc :   result := 'Integer';// compteur auto. (entier sur 32 bits)
    ftBlob :      result := 'Variant';// blob (Binary Large OBject)
    ftMemo :      result := 'Variant';// mémo texte
    ftFmtMemo :   result := 'Variant';// mémo texte formaté
    ftBCD :       result := 'Integer'; //Décimal Codé Binaire
    ftBoolean :   result := 'boolean'; // booléen
    ftGraphic :   result := 'String'; // bitmap
    ftParadoxOle :result := 'String';// OLE Paradox
    ftDBaseOle :  result := 'String'; // OLE dBase
    ftTypedBinary:result := 'String';// binaire typé
    ftCursor :    result := 'String';// curseur de sortie d'une procédure stockée
                                      // Oracle (TParam uniquement)
  end;
end;

function RetrouverTypeChampPascal(fieldtype: TFieldType):string;
begin
  case FieldType of
    ftUnknown :    result := 'String';// champ inconnu ou non déterminé
    ftString :    result := 'String';//  caractère ou chaîne
    ftSmallInt :  result := 'Integer';// entier sur 16 bits
    ftInteger :   result := 'Integer';// entier sur 32 bits
    ftWord :      result := 'Integer';// entier non signé sur 16 bits
    ftFloat :     result := 'currency';// numérique à virgule flottante
    ftCurrency :  result := 'Currency';// monétaire
    ftDate :      result := 'TDate';// date
    ftTime :      result := 'TTime';// heure
    ftDateTime :  result := 'TDateTime';// date et heure
    ftBytes :     result := 'Integer'; //nbre fixe d'octets (stokage binaire)
    ftVarBytes :  result := 'Integer'; //Nombre variable d'octets (stockage binaire)
    ftAutoInc :   result := 'Integer';// compteur auto. (entier sur 32 bits)
    ftBlob :      result := 'variant';// blob (Binary Large OBject)
    ftMemo :      result := 'variant';// mémo texte
    ftFmtMemo :   result := 'variant';// mémo texte formaté
    ftBCD :       result := 'Integer'; //Décimal Codé Binaire
    ftBoolean :   result := 'boolean'; // booléen
    ftGraphic :   result := 'String'; // bitmap
    ftParadoxOle :result := 'String';// OLE Paradox
    ftDBaseOle :  result := 'String'; // OLE dBase
    ftTypedBinary:result := 'String';// binaire typé
    ftCursor :    result := 'String';// curseur de sortie d'une procédure stockée
                                      // Oracle (TParam uniquement)
  end;
end;

function RechercheInfo(Base:TDataBase;nomTable,nomChamp,Valeurchamp,champRetour: string):string;
var
  QTable : TQuery;
  libelle : string;
begin
  libelle := '';
  QTable := TQuery.create(nil);
  try
  with  QTable do
  begin
//    database.AliasName := base.AliasName;
    DatabaseName := Base.Databasename;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM '+ nomTable );
    Sql.Add (' WHERE '+ nomChamp +'= ' + '''' +  valeurChamp + '''');
    Open;
    libelle := Findfield(champRetour).asString;
    close;
  end;
  finally
    QTable.free;
  end;
  result := libelle;
end;

procedure AjouterChampDsTable(base:TDatabase;Table:TTable;nomTable,ChampDest,
                                     ChampSource,DataType,valeur,Filtre:string);
var
  Q: TQuery;
begin
  Q := TQuery.Create(nil);
  try
    begin
    try
      with Q do
      begin
        DatabaseName := Base.Databasename;
        close;
        SQL.clear;
        SQL.Add('ALTER TABLE '+nomtable+' ADD '+champdest+' '+DataType+' ');
        if not Q.Prepared then
          Q.Prepare;
          execSQL;
      end;
    except
      //if (Q.Database.InTransaction) then (Q.Database.Rollback);
      TableGereRollBack(Q);
      raise;
    end;
  end;
  finally
    Q.free;
  end;
end;

function VerifierVide(Base:TDataBase;table:TTable;nomChamp:string):boolean;
var
  temp:TTable;
begin
  result := false;
  temp := TTable.Create(nil);
  with temp do
  begin
    DatabaseName := Base.Databasename;
    tablename := table.tableName;
    close;
    open;
    first;
    try
    begin
      while not temp.EOF do
      begin
        if (temp.fieldbyname(nomchamp).asString<>'') then
        begin
          result := false;
          temp.free;
          exit;
        end
        else
          result := true;
        temp.next ;
      end;
    end;
    except
      showmessage('problème à la lecture de la table : '+temp.TableName);
      temp.free;
    end;
    free;
  end;
end;



function CasType(fieldtype:TFieldType):integer;
begin
  result := 0;{initialisé à unknown...}
  case FieldType of
    ftUnknown,ftString,ftBoolean,ftGraphic,ftParadoxOle,ftDBaseOle,ftTypedBinary,
    ftCursor                           : result := 0;
    ftSmallInt,ftInteger,ftWord,ftFloat,ftCurrency,ftBytes,ftVarBytes,ftAutoInc,
    ftBCD                              : result := 1;
    ftDate,ftTime,ftDateTime           : result := 2;
    ftBlob,ftMemo,ftFmtMemo            : result := 3;
  end;
end;

procedure MettreAJourChampDsTable(base:TDatabase;Table:TTable;nomTable,ChampDest,
                                  ChampSource,DataType,valeur,Filtre:string);
var
  Q: TQuery;
begin
  Q := TQuery.Create(nil);
  try
    with Q do
    begin
      DatabaseName := Base.Databasename;
      close;
      SQL.clear;
      SQL.Add(' UPDATE '+nomTable);
      try
        if ChampSource = '' then
        begin
          try
            SQL.Add(' SET '+ChampDest+' = '''+valeur+'''');
          except
            SQL.Add(' SET '+ChampDest+' = '+valeur);
          end;
        end
        else
          SQL.Add(' SET '+ChampDest+' = '+ChampSource);
        if Filtre <> '' then
          SQL.Add(' WHERE '+Filtre);
        if not Q.Prepared then
          Q.Prepare;
        execSQL;
      except
        showmessage('problème de mise à jour');
        //if (Q.Database.InTransaction) then (Q.Database.Rollback);
        TableGereRollBack(Q);
        raise;
      end;
    end;
  finally
    Q.Free;
  end;
end;


procedure SupprimerChampDsTable(base:TDatabase;Table:TTable;nomTable,ChampDest,
                                   champSource,DataType,valeur,Filtre:string);
var
  Q : TQuery;
begin
  Q := TQuery.Create(nil);
  try
  begin
    try
      with Q do
      begin
        DatabaseName := Base.Databasename;
        close;
        SQL.clear;
        SQL.Add('ALTER TABLE '+nomtable+' DROP '+champSource);
        if not Q.Prepared then
          Q.Prepare;
          execSQL;
      end;
    except
      //if (Q.Database.InTransaction) then (Q.Database.Rollback);
      TableGereRollBack(Q);
      raise;
    end;
  end;
  finally
    Q.Free;
  end;
end;


procedure limiteVue(Base:TDataBase;champ:string;table:TTable;mini,maxi:variant);
begin
  with table do
  begin
    DatabaseName := Base.Databasename;
    close;
    open;
    setRangeStart;
    fieldbyname(champ).asvariant := mini;
    setRangeEnd;
    fieldbyname(champ).asvariant := maxi;
    applyRange;
  end;
end;

function RenvoieInfoSurTableDiverse(valeur:string;TableRech:ttable;ChRech:string;const ChRecup:array of string;var ValeurRecup:variant):string;
var
//tableTmp:ttable;
i:integer;
Begin
ValeurRecup:=VarArrayCreate([0,high(chrecup)],varvariant);
////
DMRech_Obj.Ta_InfosDiverses.Close;
DMRech_Obj.Ta_InfosDiverses.Filter:='';
DMRech_Obj.Ta_InfosDiverses.filtered:=false;
////
DMRech_Obj.Ta_InfosDiverses.DatabaseName:= TableRech.DatabaseName;
DMRech_Obj.Ta_InfosDiverses.tableName:= TableRech.tableName;
DMRech_Obj.Ta_InfosDiverses.Open;
DMRech_Obj.Ta_InfosDiverses.first;
   if DMRech_Obj.Ta_InfosDiverses.locate(ChRech,valeur,[])then
   begin
      for i:=0 to high(chrecup)do
         ValeurRecup[i]:=DMRech_Obj.Ta_InfosDiverses.FindField(ChRecup[i]).asstring;
   result:=DMRech_Obj.Ta_InfosDiverses.FindField(ChRecup[0]).asstring;
   end;
DMRech_Obj.Ta_InfosDiverses.close;
//LibereObjet(Tobject(tableTmp));
//tableTmp.free;
//showmessage('RenvoieInfoSurTableDiverse');
End;




Procedure TableRefresh(DataSet:TDataSet;ChampId:string);
var
typeComponent:Integer;
idtmp:variant;
begin
typeComponent:=RecupClassTypeComponent(DataSet);
  if ( typeComponent<>  GTable)and(typeComponent <>GSimpleDataset) then
   begin
    ShowMessage('Procedure TableRefresh : Le DataSet n''est pas du type Table!');
    SysUtils.Abort;
   end;
  if(typeComponent=GTable)then
  If not DataSet.Active then DataSet.Open;
  IDTmp:=0;
  if (DataSet.RecordCount > 0)and(not empty(ChampId)) then
    IDTmp:=DataSet.FindField(ChampId).AsVariant;
  DataSet.DisableControls;
  if(typeComponent=GSimpleDataset)then (DataSet as tsimpleDataset).ApplyUpdates(-1);
  DataSet.Refresh;
  DataSet.Locate(ChampId,IDtmp,[]);
  DataSet.EnableControls;
end;

Procedure TableRefreshSurClose(DataSet:TDataSet;ChampId:string);
var
//IDTmp:Integer;
idtmp:variant;
begin
  if RecupClassTypeComponent(DataSet) <>  GTable then
   begin
    ShowMessage('Procedure TableRefresh : Le DataSet n''est pas du type Table!');
    SysUtils.Abort;
   end;
  IDTmp:=0;
   if (DataSet.RecordCount > 0)and(not empty(ChampId)) then
    IDTmp:=DataSet.FindField(ChampId).AsVariant;
  DataSet.DisableControls;
  DataSet.Close;
  DataSet.Open;
  DataSet.Locate(ChampId,IDtmp,[]);
  DataSet.EnableControls;
end;

Function CreeFiltreOU(Champ : string ; const Val : array of const):string ;
var
I,J:integer;
begin
case Val[0].VType of

	vtAnsiString : Result:=Champ + '=''' + string(Val[0].VAnsiString)+'''';
   vtString     : Result:=Champ + '=''' + Val[0].VString^+'''';
	vtObject     : if (Val[0].VObject is TStringList) then
                         if ((Val[0].VObject as TStringList).count) > 0 then
                            begin
   			    Result:=Champ + '=''' + (Val[0].VObject as TStringList).Strings[0]+'''';
                            for J:=1 to (((Val[0].VObject as TStringList).count)-1) do
         		    	Result:=Result + ' or ' + Champ + '=''' + (Val[0].VObject as TStringList).Strings[J]+'''';
			    end
                            else result:=Champ + '=''''';
	vtInteger    : Result:=Champ + '=''' + IntToStr(Val[0].VInteger) +'''';
   end;

for I := 1 to High(Val) do begin
    case Val[I].VType of
        vtAnsiString : Result:=Result + ' or ' + Champ + '='''+ string(Val[I].VAnsiString)+'''';
        vtString     : Result:=Result + ' or ' + Champ + '='''+ Val[I].VString^+'''';
	     vtObject	   : begin
                            if (Val[I].VObject is TStringList) then
                             if ((Val[0].VObject as TStringList).count) > 0 then
                               begin
                               for J:=1 to (((Val[I].VObject as TStringList).count)-1) do
         		           Result:=Result + ' or ' + Champ + '=''' + (Val[I].VObject as TStringList).Strings[J]+'''';
                               end
                               else result:=Champ + '=''''';
                            end;
             vtInteger    : Result:=Result + ' or ' + Champ +  '=''' + IntToStr(Val[I].VInteger) +'''';
              end;
   end;
end;

//****************************************************************************//
Function CreeFiltreET(const Champ : array of const ; const Val : array of const):string;
var
I,J:integer;
begin
if Champ[0].VType <> Val[0].VType then result:='-1'
else begin
case Champ[0].VType of
	vtAnsiString : if Val[0].VType <> vtBoolean then
                       Result:=string(Champ[0].VAnsiString) + '=''' + string(Val[0].VAnsiString)+''''
                       else
                       Result := string(Champ[0].VAnsiString) + '=' + str_bool2str_FR(Val[0].VBoolean)+'';

	vtString : if Val[0].VType <> vtBoolean then
                           Result:=Champ[0].VString^ + '=''' + Val[0].VString^+''''
                           else
                           Result := Champ[0].VString^ + '=' + str_bool2str_FR(Val[0].VBoolean)+'';

	vtObject     : if (Val[0].VObject is TStringList) then  
                   if ((Val[0].VObject as TStringList).count) > 0 then
                      begin
                        Result:=(Champ[0].VObject as TStringList).Strings[0] + '=''' + (Val[0].VObject as TStringList).Strings[0]+'''';
                        for J:=1 to (((Val[0].VObject as TStringList).count)-1) do
                          Result:=Result + ' and ' + (Champ[0].VObject as TStringList).Strings[j] + '=''' + (Val[0].VObject as TStringList).Strings[J]+'''';
                      end
                    else result:=(Champ[0].VObject as TStringList).Strings[0] + '=''''';
end;//fin du case
for I := 1 to High(Champ) do begin
    case Champ[I].VType of
        vtAnsiString : if Val[I].VType <> vtBoolean then
                       Result:=Result + ' and ' + string(Champ[I].VAnsiString) + '='''+ string(Val[I].VAnsiString)+''''
                       else
                       Result := Result + ' and ' + string(Champ[I].VAnsiString) + '=' + str_bool2str_FR(Val[I].VBoolean)+'';

        vtString : if Val[I].VType <> vtBoolean then
                   Result:=Result + ' and ' + Champ[I].VString^ + '='''+ Val[I].VString^+''''
                   else
                   Result := Result + ' and '+Champ[I].VString^ + '='+ str_bool2str_FR(Val[I].VBoolean)+'';
	     vtObject	   : begin
                        if (Val[I].VObject is TStringList) then
                          if ((Val[0].VObject as TStringList).count) > 0 then
                             begin
                                 for J:=1 to (((Val[I].VObject as TStringList).count)-1) do
         		                        Result:=Result + ' and ' + (Champ[I].VObject as TStringList).Strings[j] + '=''' + (Val[I].VObject as TStringList).Strings[J]+'''';
                             end
                        else result:=(Champ[I].VObject as TStringList).Strings[0] + '=''''';
                     end;
    end;
    end;
end;
end;

//****************************************************************************//
Function CreeFiltreETPlage(const Champ : array of const ; const Val : array of const):string;
var
I:integer;
begin
if Champ[0].VType <> Val[0].VType then result:='-1'
else begin
case Champ[0].VType of
	vtAnsiString : Result:=string(Champ[0].VAnsiString) + '>=''' + string(Val[0].VAnsiString)+ ''' And '+string(Champ[0].VAnsiString) + '<=''' + string(Val[1].VAnsiString)+'''';
   end;
for I := 1 to High(Champ) do begin
    case Champ[I].VType of
        vtAnsiString : Result:=Result + ' and ' + string(Champ[I].VAnsiString) + '>=''' + string(Val[I+I].VAnsiString)+ ''' And '+string(Champ[I].VAnsiString) + '<=''' + string(Val[I+I+1].VAnsiString)+'''';
//        vtAnsiString : Result:=Result + ' and ' + string(Champ[I].VAnsiString) + '='''+ string(Val[I].VAnsiString)+'''';
    end;
    end;
end;
end;


//****************************************************************************//

Procedure InitChampAfterInsert(Valeur : array of const ; DataSet:TDataset);
var
I:integer;
begin
Try
If Dataset.State = dsInsert then
  begin
   for i:=0 to Dataset.FieldCount-1 do
    begin
     if ((i <= High(Valeur)) and (DataSet.Fields[i].ReadOnly=false)) then
      Begin
        case DataSet.Fields[i].DataType of
       ftUnknown :Begin
                   if valeur[i].VVariant <> nil
                   then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
                  End;
       ftString:Begin
                  if valeur[i].VVariant <> nil
                  then DataSet.Fields[i].AsString:=string(valeur[i].VAnsiString);
                End;
       ftBoolean:Begin
                  if valeur[i].VVariant <> nil
                  then DataSet.Fields[i].AsBoolean:=valeur[i].VBoolean
                  else
                  DataSet.Fields[i].AsBoolean:=false;
                 End;
       ftGraphic:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
                 End;
       ftParadoxOle:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
                    End;
       ftDBaseOle:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
                  End;
       ftTypedBinary:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
                     End;
       ftCursor:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
                End;
       ftSmallInt:Begin
                  if valeur[i].VVariant <> nil then
                  DataSet.Fields[i].AsInteger:=valeur[i].VInteger
                  else
                  DataSet.Fields[i].AsInteger:=0;
                  End;
       ftInteger:Begin
                  if valeur[i].VVariant <> nil then DataSet.Fields[i].AsInteger:=valeur[i].VInteger
                  else
                  DataSet.Fields[i].AsInteger:=0;
                 End;
       ftWord:Begin
                  if valeur[i].VVariant <> nil then DataSet.Fields[i].AsInteger:=valeur[i].VInteger
                  else
                  DataSet.Fields[i].AsInteger:=0;
              End;
       ftFloat:Begin
//                  if valeur[i].VVariant <> nil then DataSet.Fields[i].AsFloat:=valeur[i].VExtended^
                  if valeur[i].VVariant <> nil then DataSet.Fields[i].AsCurrency:=valeur[i].VCurrency^
                  else
                  DataSet.Fields[i].AsCurrency:=0.00;
               End;
       ftCurrency:Begin
                  if valeur[i].VVariant <> nil then DataSet.Fields[i].AsCurrency:=valeur[i].VCurrency^
                  else
                  DataSet.Fields[i].AsCurrency:=0.00;
                  End;
       ftBytes:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
               End;
       ftVarBytes:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
                  End;
       ftAutoInc:Begin
                 End;
       ftBCD:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
             End;
       ftDate:Begin
                  if valeur[i].VVariant <> nil then DataSet.Fields[i].AsDateTime:=StrToDate(string(valeur[i].VAnsiString));
              End;
       ftTime:Begin
                  if valeur[i].VVariant <> nil then DataSet.Fields[i].AsDateTime:=StrToTime(string(valeur[i].VAnsiString));
              End;
       ftDateTime:Begin
                  if valeur[i].VVariant <> nil then DataSet.Fields[i].AsDateTime:=valeur[i].VExtended^;
                  //StrToDateTime(string(valeur[i].VAnsiString));
                  End;
       ftBlob:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
              End;
       ftMemo:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
              End;
       ftFmtMemo:Begin
                   if valeur[i].VVariant <> nil then showmessage('Le Champ'+ DataSet.Fields[i].FieldName + ' de la table '+ DataSet.DataSource.Name+'n''est peut-être pas bien initialisé !');
                 End;
        end;
      End;
    end;
  end
  else
  ShowMessage(ErrInterne+'La fonction InitChampAfterInsert à échouée car '+RetourChariotDouble+Dataset.Name+RetourChariotDouble+' n''est pas en mode Insertion.');
except
  ShowMessage(ErrInterne+'La fonction InitChampAfterInsert à échouée sur le champ : '+RetourChariotDouble+DataSet.Fields[i].FieldName+RetourChariotDouble+'.');
    SysUtils.Abort;
end;
end;

//****************************************************************************//
//****************************************************************************//
//******************* OuvrirTouteTable ***************************************
//****************************************************************************//
//****************************************************************************//
// Ouvre toutes les tables contenues dans le controle conteneur
// MessErreur : paramètre qui rajoute une ligne au message d'erreur
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
Procedure OuvrirTouteTable(MessErreur:string;Controle:TControl);
var
i:integer;
messageErreur:string;
begin
  try
  For i:=0 to Controle.ComponentCount -1  do
      if Controle.Components[i].ClassNameis('TTable') then
      begin
        if not (Controle.Components[i] as TTable).Active then
         (Controle.Components[i] as TTable).Open ;
      end
      else
      if Controle.Components[i].ClassNameis('TDataset') then
      begin
        if not (Controle.Components[i] as TDataset).Active then
         (Controle.Components[i] as TDataset).Open ;
      end;
  except
  on E : EDatabaseError do
     begin
        messageErreur:=E.Message+ #13#10+'Erreur à l''ouverture de la table : ' + #13#10#13#10+UpperCase(Controle.Components[i].Name)+
          #13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(Controle.Name)+#10#13+'Nom Dossier : '+E2_Librairie_Obj.e.NomDossier+#10#13+'Le : '+dateInfos(now).DateStrFormat;
        if  Type_version_execution=CT_DEVELOPPEMENT then
          Application.MessageBox(Pchar(messageErreur),'Attention',MB_ICONWARNING +MB_OK);
        AjouterFichierTexte(E2_Librairie_Obj.E.RepertoireProgram+'Error.txt',messageErreur);
     end;
  end;
end;

//****************************************************************************//
//****************************************************************************//
//******************* OuvreTables ***************************************
//****************************************************************************//
//****************************************************************************//
// Ouvre toutes les tables contenues dans le tableau DataSet
// MessErreur : paramètre qui rajoute une ligne au message d'erreur
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
Procedure OuvreTables(MessErreur:string;DataSet : array of TDataset);
var
i:integer;
begin
  try
  For i:=0 to high(DataSet) do
       if DataSet[i].ClassNameis('TTable') then
       begin
         (DataSet[i] as TTable).Filter:='';
         (DataSet[i] as TTable).Filtered:=false;
         (DataSet[i] as TTable).OnFilterRecord:=nil;
         if not (DataSet[i] as TTable).Active then
          (DataSet[i] as TTable).Open ;
       end;
  except
     begin
//     Application.MessageBox(Pchar(MessErreur+ #13#10+'Erreur à l''ouverture de la table : ' + #13#10#13#10+UpperCase(DataSet[i].Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(DataSet[i].Owner.Name)),'Attention',MB_ICONWARNING +MB_OK);
     end;
  end;
end;
//****************************************************************************//
//****************************************************************************//
//******************* FermerTouteTable ***************************************
//****************************************************************************//
//****************************************************************************//
// Ferme toutes les tables contenues dans le controle conteneur
// MessErreur : paramètre qui rajoute une ligne au message d'erreur
//****************************************************************************//
//****************************************************************************//
//****************************************************************************//
Procedure FermerTouteTable(MessErreur:string;Controle:TControl);
var
i:integer;
begin
  try
  For i:=0 to Controle.ComponentCount -1
      do if Controle.Components[i].ClassNameis('TTable') then
       begin
         case (Controle.Components[i] as TTable).State of
            dsEdit:Begin
                     Application.MessageBox(Pchar(MessErreur+ #13#10+'La table : ' + #13#10#13#10+UpperCase(Controle.Components[i].Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(Controle.Name)+ #13#10#13#10+'est en modification.'),'Attention',MB_ICONWARNING +MB_OK);
                   End;

            dsInsert:Begin
                       Application.MessageBox(Pchar(MessErreur+ #13#10+'La table : ' + #13#10#13#10+UpperCase(Controle.Components[i].Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(Controle.Name)+ #13#10#13#10+'est en insertion.'),'Attention',MB_ICONWARNING +MB_OK);
                     End;

            dsBrowse:(Controle.Components[i] as TTable).close ;
         end;
       end;
  except
     begin
     Application.MessageBox(Pchar(MessErreur+ #13#10+'Erreur à la fermeture de la table : ' + #13#10#13#10+UpperCase(Controle.Components[i].Name)+#13#10#13#10+'Dans le module : '+ #13#10#13#10+UpperCase(Controle.Name)),'Attention',MB_ICONWARNING +MB_OK);
     end;
  end;
end;

Procedure ExecuteProcInit(NomProc:string);
var
i:integer;
//EstExclu:boolean;
ExecProcedure:TProcedure;
Begin

for i:=0 to screen.FormCount-1 do
    Begin
    try
    if screen.Forms[i].MethodAddress(NomProc) <> nil then
     begin
      @ExecProcedure:=screen.Forms[i].MethodAddress(NomProc);
      ExecProcedure;
     end;
    except
     ShowMessage(ErrInterne+'sur la fenêtre : '+screen.Forms[i].Caption);
    End;
    end;
End;


Function ConstruitRequeteInsert(Table:TTable):String;
Begin
//
End;

Procedure ImportTable(Valeurs:array of const;DataSet:TDataSet);
Begin
  If not (Dataset.State <> dsBrowse) then
   begin
     DataSet.Open;
     DataSet.Insert;
     try
       DataSet.SetFields(Valeurs);
//       InitChampAfterInsert(Valeurs,DataSet);  // PB le 06/05/03
       TableGerePost(DataSet);
     except
       DataSet.Cancel;
       SysUtils.Abort;
     end;
  end
  else
  begin
   showmessage('Erreur Importation : Le dataset d''importation est en mode : '+ EtatdataSetString(Dataset));
    SysUtils.Abort;
  end;
//DataSet.InsertRecord(Valeurs);
End;

Function SommeTotauxGeneric(Champs :array of string;DataSet:TDataSet):TTotauxGeneric;
var
i:integer;
OldOpen:boolean;
Begin
i:=high(Champs);
//if i > 0 then
 Begin
 DataSet.DisableControls;
 OldOpen:=DataSet.Active;
 if not OldOpen then DataSet.Open;
 InitialiseTotauxGeneric(result);
 DataSet.First;
 while not DataSet.EOF do
   begin
     for i := 0 to high(Champs) do
      Begin
        case i of
           0:result.Total1:=result.Total1 + DataSet.FindField(Champs[i]).AsCurrency;
           1:result.Total2:=result.Total2 + DataSet.FindField(Champs[i]).AsCurrency;
           2:result.Total3:=result.Total3 + DataSet.FindField(Champs[i]).AsCurrency;
           3:result.Total4:=result.Total4 + DataSet.FindField(Champs[i]).AsCurrency;
           4:result.Total5:=result.Total5 + DataSet.FindField(Champs[i]).AsCurrency;
           5:result.Total6:=result.Total6 + DataSet.FindField(Champs[i]).AsCurrency;
           6:result.Total7:=result.Total7 + DataSet.FindField(Champs[i]).AsCurrency;
           7:result.Total8:=result.Total8 + DataSet.FindField(Champs[i]).AsCurrency;
           8:result.Total9:=result.Total9 + DataSet.FindField(Champs[i]).AsCurrency;
           9:result.Total10:=result.Total10 + DataSet.FindField(Champs[i]).AsCurrency;
        end;
      End;
     DataSet.Next;
   end;
 DataSet.First;
 DataSet.Active:=OldOpen;
 End;

End;

Function SommeTotauxGenericQuery(Champs :array of string;DataSet:TDataSet):TTotauxGeneric;
var
i:integer;
OldOpen:boolean;
Begin
i:=high(Champs);
//if i > 0 then
 Begin
// DataSet.DisableControls;
 OldOpen:=DataSet.Active;
 if not OldOpen then DataSet.Open;
 InitialiseTotauxGeneric(result);
 DataSet.First;
 while not DataSet.EOF do
   begin
     for i := 0 to high(Champs) do
      Begin
        case i of
           0:result.Total1:=result.Total1 + DataSet.FindField(Champs[i]).AsCurrency;
           1:result.Total2:=result.Total2 + DataSet.FindField(Champs[i]).AsCurrency;
           2:result.Total3:=result.Total3 + DataSet.FindField(Champs[i]).AsCurrency;
           3:result.Total4:=result.Total4 + DataSet.FindField(Champs[i]).AsCurrency;
           4:result.Total5:=result.Total5 + DataSet.FindField(Champs[i]).AsCurrency;
           5:result.Total6:=result.Total6 + DataSet.FindField(Champs[i]).AsCurrency;
           6:result.Total7:=result.Total7 + DataSet.FindField(Champs[i]).AsCurrency;
           7:result.Total8:=result.Total8 + DataSet.FindField(Champs[i]).AsCurrency;
           8:result.Total9:=result.Total9 + DataSet.FindField(Champs[i]).AsCurrency;
           9:result.Total10:=result.Total10 + DataSet.FindField(Champs[i]).AsCurrency;
        end;
      End;
     DataSet.Next;
   end;
 DataSet.First;
 DataSet.Active:=OldOpen;
 End;

End;

Function ChampTableVersListeLGR(Champ :string;DAtaSet:TDataset):TStringlistLGR1;
var
liste:TStringlist;
i:integer;
begin
liste:=ChampTableVersListe(Champ,DAtaSet);
result:=TStringlistLGR1.Create;
for i:=0 to liste.Count-1 do
 result.add(liste.Strings[i]);
end;


Function ChampTableVersListe(Champ :string;DAtaSet:TDataset):TStringList;
Begin
  try
//    if result = nil then
    result:=TSTringList.Create;
    result.Clear;
    DataSet.DisableControls;
    if not DataSet.Active then DataSet.Open;
    DataSet.First;
     while not DataSet.EOF do
       begin
         result.Add(DataSet.FindField(Champ).AsString);
         DataSet.Next;
       end;
  except
     if dataset = nil then showmessage('ChampTableVersListe : le dataSet est nil!');
     if empty(Champ) then showmessage('ChampTableVersListe : Valeur champ est vide!');
  end;
  DataSet.EnableControls;
End;

Function ChampTableVersListeEx(const Champ :array of string;DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean):TStringList;
var
i:integer;
StringTmp:String;
Begin
//if result<>nil then
result:=TSTringList.Create;
result.Clear;
DataSet.DisableControls;
if not DataSet.Active then DataSet.Open;

if AvecChamps then
  begin //si on veut les noms de champs dans l'export
    for i:=0 to DataSet.FieldCount-1 do
     begin
     if i>0 then
       StringTmp:=StringTmp + Separateur + GereLibelle(DataSet.Fields[i].FieldName,separateur)
     else
       StringTmp:=DataSet.Fields[i].FieldName;
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     result.Add(StringTmp);
     StringTmp:='';
  end;

 DataSet.First;
 while not DataSet.EOF do
   begin
    if (DataSet.FieldCount<>0) and (not AvecChamps)then
        StringTmp:=GereLibelle(DataSet.FindField(DataSet.Fields[0].FieldName).AsString,Separateur);
    for i:=0 to high(champ) do
     begin
       if i>0 then
         StringTmp:=StringTmp + Separateur + GereLibelle(DataSet.FindField(Champ[i]).AsString,Separateur)
       else
         StringTmp:=GereLibelle(DataSet.FindField(Champ[i]).AsString,Separateur);
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     result.Add(StringTmp);
     DataSet.Next;
   end;
End;

Function NomChampVersListeEx(DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean):TStringList;
var
i:integer;
StringTmp:String;
Begin
//if result<>nil then
result:=TSTringList.Create;
result.Clear;
DataSet.DisableControls;
if not DataSet.Active then DataSet.Open;

    for i:=0 to DataSet.FieldCount-1 do
     begin
         if i>0 then
           StringTmp:=StringTmp + Separateur + GereLibelle(DataSet.Fields[i].FieldName,separateur)
         else
           StringTmp:=DataSet.Fields[i].FieldName;
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     result.Add(StringTmp);
     StringTmp:='';

end;


Function ChampTableVersListeEx(const Champ :TStringList;DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean):TStringList;
var
i:integer;
StringTmp:String;
Begin
//if result<>nil then
result:=TSTringList.Create;
result.Clear;
DataSet.DisableControls;
if not DataSet.Active then DataSet.Open;

if AvecChamps then
  begin //si on veut les noms de champs dans l'export
    for i:=0 to champ.Count-1 do
     begin
     if i>0 then
       StringTmp:=StringTmp + Separateur + GereLibelle(Champ[i],Separateur)
     else
       StringTmp:=Champ[i];
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     result.Add(StringTmp);
     StringTmp:='';
  end;

 DataSet.First;
 while not DataSet.EOF do
   begin
    if (DataSet.FieldCount<>0) and (not AvecChamps)then
      StringTmp:=GereLibelle(DataSet.FindField(DataSet.Fields[0].FieldName).AsString,Separateur)+ Separateur;
    for i:=0 to champ.Count-1 do
     begin
       if i>0 then
       StringTmp:=StringTmp + Separateur + GereLibelle(DataSet.FindField(Champ[i]).AsString,Separateur)
     else
       StringTmp:=GereLibelle(DataSet.FindField(Champ[i]).AsString,Separateur);
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     result.Add(StringTmp);
     DataSet.Next;
   end;
End;

Function ChampTableVersListeExLGR(DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean=false):TStringListLGR1;
var
liste:TStringlist;
i:integer;
begin
liste:=ChampTableVersListeEx(DAtaSet,Separateur,SeparateurFin,AvecChamps);
result:=TStringlistLGR1.Create;
for i:=0 to liste.Count-1 do
 result.add(liste.Strings[i]);
end;


Function ChampTableVersListeEx(DAtaSet:TDataset;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean):TStringList;
var
i:integer;
StringTmp:String;
Begin
result:=TSTringList.Create;
result.Clear;
DataSet.DisableControls;
if not DataSet.Active then DataSet.Open;

if AvecChamps then
  begin //si on veut les noms de champs dans l'export
    for i:=0 to DataSet.FieldCount-1 do
     begin
     if i>0 then
       StringTmp:=StringTmp + Separateur + GereLibelle(DataSet.Fields[i].FieldName,Separateur)
     else
       StringTmp:=GereLibelle(DataSet.Fields[i].FieldName,Separateur);
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     result.Add(StringTmp);
     StringTmp:='';
  end;

 DataSet.First;

 while not DataSet.EOF do
   begin
    if (DataSet.FieldCount<>0) and (not AvecChamps)then
      StringTmp:=GereLibelle(DataSet.FindField(DataSet.Fields[0].FieldName).AsString,Separateur)+ Separateur;
    for i:=0 to DataSet.FieldCount-1 do
     begin
       if i>0 then
         StringTmp:=StringTmp + Separateur + GereLibelle(DataSet.FindField(DataSet.Fields[i].FieldName).AsString,Separateur)
       else
         StringTmp:=GereLibelle(DataSet.FindField(DataSet.Fields[i].FieldName).AsString,Separateur);
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     result.Add(StringTmp);
     DataSet.Next;
   end;
End;


Function ChampTableVersVarListe(Champ :string;DAtaSet:TDataset;var Liste:TStringList):boolean;
Begin
if Liste = nil then
 begin
   showmessage('ChampTableVersVarListe : La liste n''est pas créée !');
    SysUtils.Abort;
 end;
DataSet.DisableControls;
if not DataSet.Active then DataSet.Open;
DataSet.First;
 while not DataSet.EOF do
   begin
     Liste.Add(DataSet.FindField(Champ).AsString);
     DataSet.Next;
   end;
End;

Function ChampTableVersVarListeEx(const Champ :array of string;DAtaSet:TDataset;var Liste:TStringList;Separateur:String;SeparateurFin:Boolean;AvecChamps:boolean):boolean;
var
i:integer;
StringTmp:String;
Begin
if Liste = nil then
 begin
   showmessage('ChampTableVersVarListe : La liste n''est pas créée !');
    SysUtils.Abort;
 end;
if AvecChamps then
  begin //si on veut les noms de champs dans l'export
    for i:=0 to high(Champ) do
     begin
     if i>0 then
       StringTmp:=StringTmp + Separateur + GereLibelle(Champ[i],separateur)
     else
       StringTmp:=Champ[i];
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     Liste.Add(StringTmp);
     StringTmp:='';
  end;
DataSet.DisableControls;
if not DataSet.Active then DataSet.Open;
 DataSet.First;
 while not DataSet.EOF do
   begin


    StringTmp:=GereLibelle(DataSet.FindField(Champ[0]).AsString,Separateur);
    for i:=1 to high(Champ) do
     begin
     StringTmp:=StringTmp + Separateur + GereLibelle(DataSet.FindField(Champ[i]).AsString,Separateur);
     end;
     if SeparateurFin then StringTmp:=StringTmp + Separateur;
     Liste.Add(StringTmp);
     DataSet.Next;
   end;
End;

Function SQL_ChangeAliasDsRequete(Query:TQuery;NomAliasDsQuery,NomNewAlias:string):string;
Begin
result:=str_remplacesouschaine(Query.SQL.Text,NomAliasDsQuery,NomNewAlias);
End;

Procedure AffichevaleurDsTable(mess:string;Dataset:TDataset);
var
i:integer;
MEssAux:string;
Begin
messAux:=Mess+RetourChariotDouble;
for i:=0 to DataSet.FieldCount-1 do
 begin
 messAux:=messAux+DataSet.Fields[i].DisplayLabel+' : '+DataSet.Fields[i].AsString+RetourChariotDouble;
 end;
showmessage(messAux);
End;

// Attention, Pour un clonage parfait, passer un dataset existant dans DataSetVar
// N'utilser le DataSet du result si aucun effet sur le DataSetOrg
// Car en fait, on pointe sur le DataSetOrg !!!!!!!!!!!!!!
Function CloneDataSet(DataSetOrg:TDataSet;DataSetVar:TDataSet):TDataSet;
var
//TableTmp:TTable;
QueryTmp:TQuery;
i:integer;
param:Tparam;
begin
result := nil;
case RecupClassTypeComponent(DataSetOrg) of
   GTQuery:Begin
             QueryTmp:=TQuery.Create(DataSetOrg.Owner);
             QueryTmp.sql:=(DataSetOrg as TQuery).SQL;
             QueryTmp.Databasename:=(DataSetOrg as TQuery).DatabaseName;
             if (DataSetOrg as TQuery).DataSource <> nil then
              QueryTmp.DataSource:=(DataSetOrg as TQuery).DataSource;
             for i:=0 to (DataSetOrg as TQuery).ParamCount - 1 do
              Begin
               QueryTmp.Params[i].Value:=(DataSetOrg as TQuery).Params[i].Value;
              End;
             QueryTmp.Filter:=(DataSetOrg as TQuery).Filter;
             QueryTmp.Filtered:=(DataSetOrg as TQuery).Filtered;
             if @(DataSetOrg as TQuery).OnFilterRecord <> nil then
                 QueryTmp.OnFilterRecord:=(DataSetOrg as TQuery).OnFilterRecord;
               try
                 begin
                 QueryTmp.Open;
                 result :=QueryTmp;
//                 .Locate(ChampRecherche,ValeurChampRecherche,[loCaseInsensitive]);
                 end;
               except
                 result := nil;
               end;
//             QueryTmp.Close;
//             QueryTmp.Free;
//             QueryTmp:=nil;
           End;
   GTable:Begin
             result:=TTable.Create(DataSetOrg.Owner);
             TTable(result).TableName:=(DataSetOrg as TTable).TableName;
             if DataSetVar <> nil then
                 begin
                  if TTable(DataSetVar).Active then
                            TTable(DataSetVar).Close;
                  TTable(DataSetVar).TableName:=(DataSetOrg as TTable).TableName;
                 end;
             TTable(result).Databasename:=(DataSetOrg as TTable).DatabaseName;
             if DataSetVar <> nil then TTable(DataSetVar).Databasename:=(DataSetOrg as TTable).DatabaseName;
             TTable(result).Filter:=(DataSetOrg as TTable).Filter;
             if DataSetVar <> nil then TTable(DataSetVar).Filter:=(DataSetOrg as TTable).Filter;
             TTable(result).Filtered:=(DataSetOrg as TTable).Filtered;
             if DataSetVar <> nil then TTable(DataSetVar).Filtered:=(DataSetOrg as TTable).Filtered;
             TTable(result).IndexFieldNames:=(DataSetOrg as TTable).IndexFieldNames;
             if DataSetVar <> nil then TTable(DataSetVar).IndexFieldNames:=(DataSetOrg as TTable).IndexFieldNames;
             if @(DataSetOrg as TTable).OnFilterRecord <> nil then
                 TTable(result).OnFilterRecord:=(DataSetOrg as TTable).OnFilterRecord;
             if DataSetVar <> nil then
              if @(DataSetOrg as TTable).OnFilterRecord <> nil then
               TTable(DataSetVar).OnFilterRecord:=(DataSetOrg as TTable).OnFilterRecord;
               try
                 begin
                 if DataSetVar <> nil then DataSetVar.Open;
                 TTable(result).Open;
//                 TableTmp.Filtered:=false;
//                 result :=TableTmp;
                 //.Locate(ChampRecherche,ValeurChampRecherche,[loCaseInsensitive]);
                 end;
               except
                if result <> nil then
                result.Free;
                 result := nil;
               end;
//             TableTmp.Close;
//             TableTmp.Free;
//             TableTmp:=nil;
           End;

end;
//result.Free;
End;

Procedure FormateMonnaieField(DataSet:TDataset;FormatMonnaie,EditFormat:string);
var
i:integer;
Begin
try
 for i:=0 to Dataset.FieldCount-1 do
  begin
  if RecupClassTypeComponent(Dataset.Fields[i]) = GTFieldCurr then
   begin
     TCurrencyField(Dataset.Fields[i]).DisplayFormat:=FormatMonnaie;
     TCurrencyField(Dataset.Fields[i]).EditFormat:=EditFormat;
   end;
  end;
 except
  showmessage('FormateMonnaieField : Erreur lors du formatage de la monnaie');
 end;
End;

Procedure FormateValidCharCurrField(DataSet:TDataset;FieldChars:TFieldChars);
var
i:integer;
Begin
try
 for i:=0 to Dataset.FieldCount-1 do
  begin
  if RecupClassTypeComponent(Dataset.Fields[i]) = GTFieldCurr then
   begin
     TCurrencyField(Dataset.Fields[i]).ValidChars:=FieldChars;
   end;
  end;
 except
  showmessage('FormateValidCharCurrField : Erreur lors du validChar');
 end;
End;

Procedure FormateValidCharFloatField(DataSet:TDataset;FieldChars:TFieldChars);
var
i:integer;
Begin
try
 for i:=0 to Dataset.FieldCount-1 do
  begin
  if RecupClassTypeComponent(Dataset.Fields[i]) = GTFieldFloat then
   begin
     TFloatField(Dataset.Fields[i]).ValidChars:=FieldChars;
   end;
  end;
 except
  showmessage('FormateValidCharFloatField : Erreur lors du validChar');
 end;
End;

Procedure TableDisableControlBookMark(DAtaSet:TDataset;var Bookmark:TBookMark);
Begin
 try
  if BookMark = nil then
  BookMark:=DAtaSet.GetBookmark;
  DAtaSet.DisableControls;
 except
 DAtaSet.EnableControls;
 end;
End;

Procedure TableEnableControlBookMark(DAtaSet:TDataset;var Bookmark:TBookMark);
Begin
try
  if BookMark <> nil then
   begin
     DAtaSet.GotoBookmark(BookMArk);
     DAtaSet.FreeBookmark(BookMark);
     BookMark:=nil;
   end;
   DAtaSet.EnableControls;
except
 DAtaSet.EnableControls;
end;
End;

// Retourne un DataSet utilisable pour la recherche dans la table DataSetRech
// Si on veut modifier une propriété, par ex, le filtre,
// A débugger avant utilisation !!!!!!!!!!!!!!!!!!!!!!!!
Function DataSetRechercher(DataSetRech:TDataSet;Filtre:String;Filtree:Boolean):TDataSet;
Begin
try
  ProtectObjetNil([DataSetRech]);
  DataSetRech.Close;
  case RecupClassTypeComponent(DataSetRech) of
     GTQuery:Begin
             end;
     GTable:Begin
               result:=TTable.Create(DataSetRech.Owner);
               CloneDataSet(DataSetRech,result);
               TTable(result).Filter:=Filtre;
               TTable(result).Filtered:=Filtree;
             End;
  end;
except

 showmessage(ErrInterne+'Erreur à la création de la table de recherche !');
end;
//
End;

{-----------------------------------------------------------------------------
  Procedure: GrLocate
  Author:    Blanc Philippe
  Date:      09-sept.-2003
  Arguments: DataSet:TDataSet; Champ:string; const Valeur:array of variant
  Result:    Boolean
-----------------------------------------------------------------------------}
Function GrLocate(DataSet:TDataSet;Champ:string;const Valeur:array of variant):Boolean;
var
ValTmp:Variant;
begin
 result:=false;
 if not DataSet.Active then DataSet.Open else
 begin
 if(dataset is TSimpleDataSet)then
   (DataSet as TSimpleDataSet).ApplyUpdates(-1);
 DataSet.Refresh;
 end;
 try
 if Str_Count_Str(';',Champ) > 0 then

  result:=DataSet.locate(Champ,VarArrayOf(Valeur),[loCaseInsensitive])
  else
   begin
    ValTmp:=Valeur[0];
    result:=DataSet.locate(Champ,ValTmp,[loCaseInsensitive]);
   end;
 except
   showmessage('GrLocate : Erreur lors de la recherche');
 end;
end;

Procedure TableSauveEtatFiltre(Table:TDataSet;Var EtatFiltre:TEtatFiltre);
Begin
 try
  EtatFiltre.Filtre:=Table.Filter;
  EtatFiltre.Filtree:=Table.Filtered;

  EtatFiltre.OnFilterRecord := Table.OnFilterRecord;
 except
   showmessage('TableSauveEtatFiltre : Erreur lors de la sauvegarde du filtre');
 end;
End;

//Procedure TableSauveEtatFiltreSimpleDataset(Table:TDataSet;Var EtatFiltre:TEtatFiltre);
//Begin
// try
//  EtatFiltre.Filtre:=Table.Filter;
//  EtatFiltre.Filtree:=Table.Filtered;
//
//  EtatFiltre.OnFilterRecord := Table.OnFilterRecord;
// except
//   showmessage('TableSauveEtatFiltre : Erreur lors de la sauvegarde du filtre');
// end;
//End;

Procedure QuerySauveEtatFiltre(Query:TQuery;Var EtatFiltre:TEtatFiltre);
Begin
 try
  EtatFiltre.Filtre:=Query.Filter;
  EtatFiltre.Filtree:=Query.Filtered;

  EtatFiltre.OnFilterRecord := Query.OnFilterRecord;
 except
   showmessage('QuerySauveEtatFiltre : Erreur lors de la sauvegarde du filtre');
 end;
End;

Procedure TableRestoreEtatFiltre(Table:TDataSet;Var EtatFiltre:TEtatFiltre);
Begin
 try
  Table.Filter:=EtatFiltre.Filtre;
  Table.Filtered:=EtatFiltre.Filtree;

  Table.OnFilterRecord :=EtatFiltre.OnFilterRecord;
 except
   showmessage('TableRestoreEtatFiltre : Erreur lors de la restitution du filtre');
 end;
End;

Procedure QueryRestoreEtatFiltre(Query:TQuery;Var EtatFiltre:TEtatFiltre);
Begin
 try
  Query.Filter:=EtatFiltre.Filtre;
  Query.Filtered:=EtatFiltre.Filtree;

  Query.OnFilterRecord :=EtatFiltre.OnFilterRecord;
 except
   showmessage('QueryRestoreEtatFiltre : Erreur lors de la restitution du filtre');
 end;
End;


Procedure TableAjoute(Table:TDataSet);
Begin
  try
   Table.DisableControls;
   Table.Next;
   If Table.EOF then
    begin
     Table.EnableControls;
     Table.Append;
    end
    else
    begin
     Table.Prior;
     Table.EnableControls;
     Table.Insert;
    end;
  except
   showmessage('TableAjoute : Erreur lors de l''ajout d''un enregistrement');
   Table.EnableControls;
  end;
End;

Function FiltrageDataSet(DataSet:TDataSet;Filtre:String):Boolean;
Begin
 try
   result:=true;
   DataSet.DisableControls;
   DeFiltrageDataSet(DataSet);
   if(DataSet is TSimpleDataSet)then (DataSet as TSimpleDataSet).ApplyUpdates(-1);
   DataSet.Filter:=Filtre;
   DataSet.Filtered:=true;
   DataSet.Open;
   DataSet.EnableControls;
 except

  showmessage('FiltrageDataSet : Erreur lors du filtrage sur : '+DataSet.Name+
               RetourChariotDouble+'DataSet.Filtre : '+DataSet.Filter+
               RetourChariotDouble+'Filtre : '+Filtre);
  DataSet.EnableControls;
  result:=false;
 end;
End;

Function DeFiltrageDataSet(DataSet:TDataSet):Boolean;
var
NomDataSet:String;
Begin
 try
   result:=true;
   NomDataSet:='Inconnu !';
   NomDataSet:=TTable(DataSet).Name;
   DataSet.DisableControls;
//   if DataSet.Active then DataSet.close;
   DataSet.Filter:='';
   DataSet.Filtered:=False;
   if not DataSet.Active then
   DataSet.Open;
   DataSet.EnableControls;
 except
  showmessage('DefiltrageDataSet : Erreur lors du défiltrage de : '+NomDataSet);
  DataSet.EnableControls;
  result:=false;
 end;
End;

Procedure TableGereRollBack(Dataset:Tdataset);
Begin
 try
  if (Dataset is Ttable) then
    begin
      if (dataset as TTable).Database<>nil then
          if (Dataset as Ttable).Database.InTransaction then
           begin
            (Dataset as Ttable).Database.Rollback;
    //        (Dataset as Ttable).FlushBuffers;
            //showmessage('Rollback table   '+(dataset as TTable).TableName);
           end;
    end;
 except
  showmessage('TableGereRollBack : Erreur lors du RollBack sur la table :'+(Dataset as Ttable).TableName);
    SysUtils.Abort;
 end;
End;

Procedure TableGereCommit(Dataset:Tdataset);
Begin
 try
  if (Dataset is Ttable) then
    begin
      if (dataset as TTable).Database<>nil then
          if (Dataset as Ttable).Database.InTransaction then
           begin
            (Dataset as Ttable).Database.Commit;
            (Dataset as Ttable).FlushBuffers;
            //showmessage('Commit table   '+(dataset as TTable).TableName);
           end;
    end;
 except
  showmessage('TableGereCommit : Erreur lors du Commit sur la table :'+(Dataset as Ttable).TableName);
    SysUtils.Abort;
 end;
End;


Function MaxId_QueryPostgre(Table:TSimpleDataSet;NomChampId:string):Integer;
Var
QueryMaxID:TSQLQuery;
ConditionWhere:String;
Begin
 try
  Result:=0;
  QueryMaxID:=TSQLQuery.Create(nil);
  QueryMaxID.SQLConnection:=Table.Connection;
  ConditionWhere:='';
  ConditionWhere:=str_apres(NomChampID,';');
  NomChampID:=str_avant(NomChampID,';');
  QueryMaxID.SQL.Add('Select max('+NomChampId+') as NewID from '+Table.DataSet.CommandText+'  '+ConditionWhere);
  QueryMaxID.Open;

     if QueryMaxID.FindField('NewID').AsInteger > 0 then   { isa  le  18/07/05 }
     result:=QueryMaxID.FindField('NewID').AsInteger+1
     else
     Result:=1;
 except
  QueryMaxID.Close;
  QueryMaxID.Free;
  showmessage('Problème dans la table '+Table.DataSet.CommandText+' lors de la generation de l''ID !');
    SysUtils.Abort;
 end;//fin du try
 QueryMaxID.Close;
 QueryMaxID.Free;
//
End;


Function MinId_QueryPostgre(Table:TSimpleDataSet;NomChampId:string):Integer;
Var
QueryMinID:TSQLQuery;
ConditionWhere:String;
Begin
 try
  Result:=-1;
  QueryMinID:=TSQLQuery.Create(nil);
  QueryMinID.SQLConnection:=Table.Connection;
  ConditionWhere:='';
  ConditionWhere:=str_apres(NomChampID,';');
  NomChampID:=str_avant(NomChampID,';');
  QueryMinID.SQL.Add('Select min('+NomChampId+') as NewID from '+Table.DataSet.CommandText);
  QueryMinID.SQL.Add(ConditionWhere);
  QueryMinID.Open;
     if QueryMinID.FindField('NewID').AsInteger < 0 then
     result:=QueryMinID.FindField('NewID').AsInteger-1
     else
     Result:=-1;
 except
  QueryMinID.Close;
  QueryMinID.Free;
  showmessage('Problème dans la table '+Table.DataSet.CommandText+' lors de la generation de l''ID !');
    SysUtils.Abort;
 end;//fin du try
 QueryMinID.Close;
 QueryMinID.Free;
//
End;

Function MaxId_Query(Table:TTable;NomChampId:string):Integer;
Var
QueryMaxID:TQuery;
ConditionWhere:String;
Begin
 try
  Result:=0;
  QueryMaxID:=TQuery.Create(nil);
  QueryMaxID.DatabaseName:=Table.DatabaseName;
  ConditionWhere:='';
  ConditionWhere:=str_apres(NomChampID,';');
  NomChampID:=str_avant(NomChampID,';');
  QueryMaxID.SQL.Add('Select max('+NomChampId+') as NewID from '+Table.TableName);
  QueryMaxID.SQL.Add(ConditionWhere);
  QueryMaxID.Open;
//     if QueryMaxID.FindField('NewID').AsInteger <> 0 then
     if QueryMaxID.FindField('NewID').AsInteger > 0 then   { isa  le  18/07/05 }
     result:=QueryMaxID.FindField('NewID').AsInteger+1
     else
     Result:=1;
 except
  QueryMaxID.Close;
  QueryMaxID.Free;
  showmessage('Problème dans la table '+Table.TableName+' lors de la generation de l''ID !');
    SysUtils.Abort;
 end;//fin du try
 QueryMaxID.Close;
 QueryMaxID.Free;
//
End;

Function MinId_Query(Table:TTable;NomChampId:string):Integer;
Var
QueryMinID:TQuery;
ConditionWhere:String;
Begin
 try
  Result:=-1;
  QueryMinID:=TQuery.Create(nil);
  QueryMinID.DatabaseName:=Table.DatabaseName;
  ConditionWhere:='';
  ConditionWhere:=str_apres(NomChampID,';');
  NomChampID:=str_avant(NomChampID,';');
  QueryMinID.SQL.Add('Select min('+NomChampId+') as NewID from '+Table.TableName);
  QueryMinID.SQL.Add(ConditionWhere);
  QueryMinID.Open;
     if QueryMinID.FindField('NewID').AsInteger < 0 then
     result:=QueryMinID.FindField('NewID').AsInteger-1
     else
     Result:=-1;
 except
  QueryMinID.Close;
  QueryMinID.Free;
  showmessage('Problème dans la table '+Table.TableName+' lors de la generation de l''ID !');
    SysUtils.Abort;
 end;//fin du try
 QueryMinID.Close;
 QueryMinID.Free;
//
End;





Procedure TableGereStartTransaction(dataset:Tdataset);
Begin
 try
   if (dataset is TTable)then
     begin
       if (dataset as TTable).Database<>nil then
           if not (dataset as TTable).Database.InTransaction then
            begin
              (dataset as TTable).Database.TransIsolation:=tiDirtyRead;
              (dataset as TTable).Database.StartTransaction;
              //showmessage('start transaction table   '+(dataset as TTable).TableName);
            end;
     end;
 except
    showmessage('TableGereStartTransaction : Erreur lors du StartTransaction de la table :'+(dataset as TTable).TableName);
    SysUtils.Abort;
 end;
End;

Function AffectValeurAChamp(Field:TField;Valeur:Variant):Boolean;
Begin
try
case Field.DataSet.State of
   dsInsert:Begin
              if not Field.ReadOnly then
              Field.AsVariant:=Valeur;
            End;
   dsEdit:Begin
              if not Field.ReadOnly then
              Field.AsVariant:=Valeur;
          End;
   else
   begin
    showmessage('Erreur : AffectValeurAChamp : La table' + Field.DataSet.Name + 'n''est pas en mode edition ou insertion !');
   end;
end;
except
showmessage('Erreur : AffectValeurAChamp lors de l''affectation');
end;

End;


Procedure TableGerePost(Dataset:Tdataset);
Begin
  try
   if Dataset.State in [dsinsert,dsedit] then
     begin
     Dataset.post;
     if (Dataset is Ttable) then
       (Dataset as Ttable).FlushBuffers;
     if (Dataset is TSimpleDataset) then
       (Dataset as TSimpleDataset).ApplyUpdates(-1);
     end;
  except
     //showmessage('TableGerePost: Erreur lors du Post du dataset :'+Dataset.Name);
    SysUtils.Abort;
  end;
End;



Procedure TableGereInsert(Dataset:Tdataset);
Begin
  try
   if not (Dataset.State in [dsinsert,dsedit]) then
     begin
       Dataset.insert;
     end;
  except
     //showmessage('TableGerePost: Erreur lors du Post du dataset :'+Dataset.Name);
    SysUtils.Abort;
  end;
End;

Procedure TableGereEdit(Dataset:Tdataset);
Begin
  try
   if not (Dataset.State in [dsinsert,dsedit]) then
     begin
       Dataset.Edit;
     end;
  except
     //showmessage('TableGerePost: Erreur lors du Post du dataset :'+Dataset.Name);
    SysUtils.Abort;
  end;
End;


Procedure TableGereDelete(Dataset:Tdataset);
Begin
  try
   Dataset.delete;
   if (Dataset is Ttable) then
     (Dataset as Ttable).FlushBuffers;
  except
     //showmessage('TableGereDelete: Erreur lors d''un delete du dataset :'+Dataset.Name);
    SysUtils.Abort;
  end;
End;

Function EtatDataSetString(DataSet:TDataSet):String;
Begin
result:='Inconnu';
case DataSet.State of
   dsInactive:result:='Inactive' ;
   dsBrowse:result:='Consultation';
   dsEdit:result:='Modification';
   dsInsert:result:='Insertion';
   dsFilter:result:='Filtrée';
end;
End;

Function EtatDataSetString(State:TDataSetState):String;
Begin
result:='Inconnu';
case State of
   dsInactive:result:='Inactive' ;
   dsBrowse:result:='Consultation';
   dsEdit:result:='Modification';
   dsInsert:result:='Insertion';
   dsFilter:result:='Filtrée';
end;
End;

Function NBRecord_Str(DataSet:TDataSet):String;
Begin
result:='';
try
 if ((dataset<>nil)and(dataset.state in [dsbrowse]))then
   result:=' - '+Str_SingulierToPluriel(DataSet.RecordCount,'enregistrement')+'.';
except
 result:='';
end;
End;

Function AffecteEvenement(ObjetSource,ObjetDestination:TObject):Boolean;
Begin
result:=true;
 try
  if ObjetSource.ClassNameIs('TTable') then
   Begin
      TDataSet(ObjetDestination).BeforeOpen:=TDataSet(ObjetSource).BeforeOpen;
      TDataSet(ObjetDestination).AfterOpen:=TDataSet(ObjetSource).AfterOpen;
      TDataSet(ObjetDestination).BeforeClose:=TDataSet(ObjetSource).BeforeClose;
      TDataSet(ObjetDestination).AfterClose:=TDataSet(ObjetSource).AfterClose;
      TDataSet(ObjetDestination).BeforeInsert:=TDataSet(ObjetSource).BeforeInsert;
      TDataSet(ObjetDestination).AfterInsert:=TDataSet(ObjetSource).AfterInsert;
      TDataSet(ObjetDestination).BeforeEdit:=TDataSet(ObjetSource).BeforeEdit;
      TDataSet(ObjetDestination).AfterEdit:=TDataSet(ObjetSource).AfterEdit;
      TDataSet(ObjetDestination).BeforePost:=TDataSet(ObjetSource).BeforePost;
      TDataSet(ObjetDestination).AfterPost:=TDataSet(ObjetSource).AfterPost;
      TDataSet(ObjetDestination).BeforeCancel:=TDataSet(ObjetSource).BeforeCancel;
      TDataSet(ObjetDestination).AfterCancel:=TDataSet(ObjetSource).AfterCancel;
      TDataSet(ObjetDestination).BeforeDelete:=TDataSet(ObjetSource).BeforeDelete;
      TDataSet(ObjetDestination).AfterDelete:=TDataSet(ObjetSource).AfterDelete;
      TDataSet(ObjetDestination).BeforeScroll:=TDataSet(ObjetSource).BeforeScroll;
      TDataSet(ObjetDestination).AfterScroll:=TDataSet(ObjetSource).AfterScroll;
      TDataSet(ObjetDestination).OnCalcFields:=TDataSet(ObjetSource).OnCalcFields;
      TDataSet(ObjetDestination).OnDeleteError:=TDataSet(ObjetSource).OnDeleteError;
      TDataSet(ObjetDestination).OnEditError:=TDataSet(ObjetSource).OnEditError;
      TDataSet(ObjetDestination).OnFilterRecord:=TDataSet(ObjetSource).OnFilterRecord;
      TDataSet(ObjetDestination).OnNewRecord:=TDataSet(ObjetSource).OnNewRecord;
      TDataSet(ObjetDestination).OnPostError:=TDataSet(ObjetSource).OnPostError;
//      TDataSet(ObjetDestination).OnServerYield:=TDataSet(ObjetSource).OnServerYield;
//      TDataSet(ObjetDestination).OnUpdateError:=TDataSet(ObjetSource).OnUpdateError;
//      TDataSet(ObjetDestination).OnUpdateRecord:=TDataSet(ObjetSource).OnUpdateRecord;
   End;

  if ObjetSource.ClassNameIs('TDataSource') then
   Begin
  //    property OnStateChange: TNotifyEvent read FOnStateChange write FOnStateChange;
  //    property OnDataChange: TDataChangeEvent read FOnDataChange write FOnDataChange;
  //    property OnUpdateData: TNotifyEvent read FOnUpdateData write FOnUpdateData;
   End;

  if ObjetSource.ClassNameIs('TDataSet') then
   Begin

   End;
 except
  result:=false;
 end;
End;

procedure ReEnableControls (DataSet: TDataSet);
begin
while DataSet.ControlsDisabled do
DataSet.EnableControls;
end;


procedure InitDatasetEvent_A_Nil_Sur_Form(Dataset:array of Tcomponent);
var
i:integer;
Begin
try
for i:=0 to high(dataset) do
  Begin
     try
     case RecupClassTypeComponent(dataset[i]) of
       GTDataSource:Begin
                      Tdatasource(dataset[i]).OnStateChange := nil;
                    End;
       GTable:Begin
                 TTable(dataset[i]).AfterScroll := nil;
              End;
       GTQuery:Begin
                 TQuery(dataset[i]).AfterScroll := nil;
               End;
     end;//fin du case
     except
        showmessage('Erreur Interne : InitDatasetEvent_A_Nil sur le Dataset : '+dataset[i].Name+' sur le datamodule : '+dataset[i].Owner.Name);
     end;
  End;
except
   //
end;
End;

Function TableDuplique(DataSet : TDataSet;RepSource,NomCopy,RepCopy:String;Ecrase:Boolean):Boolean;
Begin
result:=true;
  try
    if (DataSet is TTable) then
     begin
        CopierStructure(IncludeTrailingPathDelimiter(RepSource)+(DataSet as TTable).TableName,RepCopy+NomCopy);
      With TTable.Create(Application) do
       try
        DatabaseName := (DataSet as TTable).DatabaseName;
        TableName :=RepCopy+NomCopy;
        open;
        BatchMove((DataSet as TTable),batAppend); 
       Finally
        close;
        Free;
       end;
     end;
  except
    result:=false;
  end;
End;



Function TableRestaure(DataSet : TDataSet;NomTable,AliasSource:String;Ecrase:Boolean):Boolean;
var
TableTemp:TTable;
Begin
  try
    if (DataSet is TTable) then
     begin
      TableTemp:=TTable.Create(Application);
       try
        TableTemp.DatabaseName := AliasSource;
        TableTemp.TableName :=NomTable;
        (DataSet as TTable).close;
        (DataSet as TTable).EmptyTable;
        (DataSet as TTable).open;
        TableTemp.open;
        (DataSet as TTable).BatchMove(TableTemp,batAppend); //
//        (DataSet as TTable).BatchMove(TableTemp,batCopy	);
        tablegerecommit(DataSet); //
       except
          result:=false;
       end;
     end;
  Finally
    TableTemp.close;
    TableTemp.Free;
  end;

End;

//******************* CopierStructure *************************
//Copie la structure d'une table
procedure CopierStructure(Source,Cible: string);
begin
     with TTable.Create(Application) do
     try
        TableName := Source;
        Open;
        FieldDefs.Update;
        IndexDefs.Update;
        Close;
        TableName := Cible;
        CreateTable
     finally
        Free
     end
end;


function PrecisionFloat(Valeur:string;Var key:Char;Precision:integer):string;
var
valeurDecimal:string;
Begin
try
 result:=valeur;
 if (key in ['0'..'9',DecimalSeparator]) then
   begin
       valeurDecimal:=valeur;
       if pos(decimalseparator,valeurdecimal)<>0 then
           begin
           if length(copy(valeurdecimal,pos(decimalseparator,valeurdecimal)+1,length(valeurdecimal)))>=2 then
             key:=#0;
           valeurDecimal:=copy(valeurdecimal,pos(decimalseparator,valeurdecimal),4) ;
           result:=(floattostr(int(strtofloat_lgr(valeur)))+valeurDecimal);
       end;
   end;
 except
  showmessage('PrecisionFloat : Erreur lors du formatage du Float');
 end;
End;


Procedure TableGereClose(Dataset:Tdataset);
Begin
  try
   if Dataset<>nil then
   if (Dataset.State in [dsinsert,dsedit]) then
     Dataset.cancel;
   Dataset.Close;
  except
     //showmessage('TableGerePost: Erreur lors du Post du dataset :'+Dataset.Name);
    SysUtils.Abort;
  end;
End;


Procedure TableGereOpen(Dataset:Tdataset);
Begin
  try
   if Dataset<>nil then
   if (Dataset.State in [dsInactive]) then
     Dataset.Open;
  except
     //showmessage('TableGerePost: Erreur lors du Post du dataset :'+Dataset.Name);
    SysUtils.Abort;
  end;
End;

Procedure TableGereCancel(Dataset:Tdataset);
Begin
  try
   if Dataset<>nil then
   if (Dataset.State in [dsinsert,dsedit]) then
     Dataset.cancel;
  except
     //showmessage('TableGerePost: Erreur lors du Post du dataset :'+Dataset.Name);
    SysUtils.Abort;
  end;
End;

//procedure InitParamFTP(Var ParamFTP:TParamFTP;nomDossier,ServeurFTP:String);
//begin
//  ParamFTP.Source:='';
//  ParamFTP.Dest:='/sauvegarde_epicea/'+NomDossier;
//  ParamFTP.Serveur:=ServeurFTP;
//  ParamFTP.Login:='';
//  ParamFTP.PassWord:='';
//  ParamFTP.Effacer:='o';
//  ParamFTP.Auto:='a';
//  ParamFTP.Prevenir:='0';
//end;
//
//procedure EcritFichierParamFTP(ParamFTP,ParamFTP_Entreprise:TParamFTP);
//var
//text:TextFile;
//begin
//  try //finally
//      try//except
//        if (ParamFTP.Fichier=EmptyStr) then ParamFTP.Fichier:=ParamFTP_Entreprise.Fichier;
//        if not FileExists(ParamFTP.Fichier)then
//          begin
//             AjouterFichierTexte(ParamFTP.Fichier,'');
//             if not FileExists(ParamFTP.Fichier)then SysUtils.Abort;;
//          end;
//        AssignFile(text,ParamFTP.Fichier);
//        Rewrite(text);
//        Writeln(text,ParamFTP.Source);
//        Writeln(text,ParamFTP.Dest);
//        Writeln(text,ParamFTP.Login);
//        Writeln(text,ParamFTP.PassWord);
//        Writeln(text,ParamFTP.Serveur);
//        Writeln(text,ParamFTP.Effacer);
//        Writeln(text,ParamFTP.Auto);
//        if (ParamFTP.prevenir=EmptyStr)then ParamFTP.prevenir:='0';
//        if not(ord(ParamFTP.prevenir[1]) in [49,50])then ParamFTP.prevenir:='0';
//        Writeln(text,ParamFTP.prevenir);
//      except
//        showmessage('Le fichier '+ParamFTP.Fichier+' n''existe pas');
//      end;
//  finally
//    CloseFile(text);
//  end;
//end;
//
//Function LitFichierParamFTP(FileName:string;Var ParamFTP:TParamFTP;AfficheMessage:boolean;
//         nomDossier,ServeurFTP:String;ParamFTP_Entreprise:TParamFTP;RepertoireDossier:string):boolean;
//var
//text:TextFile;
//Begin
//  try //finally
//      try//except
//        result:=true;
//        InitParamFTP(ParamFTP,nomDossier,ServeurFTP);
//        if (filename=EmptyStr)then filename:=ParamFTP_Entreprise.Fichier;
//        if not FileExists(FileName)then
//          begin
//             ParamFTP_Entreprise.Fichier := RepertoireDossier + C_ParamFTP;
//             FileName:=ParamFTP_Entreprise.Fichier;
//             if not FileExists(FileName)then
//               begin
//                 AjouterFichierTexte(filename,'');
//                 if not FileExists(FileName)then SysUtils.Abort;
//                 EcritFichierParamFTP(ParamFTP,ParamFTP_Entreprise);
//               end;
//          end;
//        AssignFile(text,filename);
//        Reset(text);
//        Readln(text,ParamFTP.Source);
//        Readln(text,ParamFTP.Dest);
//        Readln(text,ParamFTP.Login);
//        Readln(text,ParamFTP.PassWord);
//        Readln(text,ParamFTP.Serveur);
//        Readln(text,ParamFTP.Effacer);
//        Readln(text,ParamFTP.Auto);
//        Readln(text,ParamFTP.prevenir);
//        if(ParamFTP.Dest='/')then ParamFTP.Dest:='sauvegarde_epicea/'+nomDossier;
//        result:=not ((ParamFTP.Login=EmptyStr) or (ParamFTP.Serveur=EmptyStr) or (ParamFTP.PassWord=EmptyStr));
//        if (not result and AfficheMessage) then
//          //MessageBox(PansiChar(connexionInvalide),Parent,pAnsiChar('Adresse FTP invalide'),MB_ICONWARNING);
//          showmessage(connexionInvalide);
//      except
//        showmessage('Le fichier '+FileName+' n''existe pas');
//      end;
//  finally
//    CloseFile(text);
//  end;
//end;

end.
