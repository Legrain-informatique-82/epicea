unit ILibSQL;

interface

uses
 Messages, SysUtils, Classes,Dialogs,dbtables,db,
IBTable,IBQuery,Lib_Chaine;

Function MaxId_Query(Table:TIBTable;NomChampId:string):Integer;overload;
Function MaxId_Query(Table:TTable;NomChampId:string):Integer;overload;
Procedure TableIBGereModifTable(FlagTable:Boolean;NomTable:String);

implementation

Function MaxId_Query(Table:TIBTable;NomChampId:string):Integer;
Var
QueryMaxID:TIBQuery;
ConditionWhere:String;
Begin
 try
  Result:=0;
  QueryMaxID:=TIBQuery.Create(nil);
  QueryMaxID.Database:=Table.Database;
  ConditionWhere:='';
  ConditionWhere:=str_apres(NomChampID,';');
  NomChampID:=str_avant(NomChampID,';');
  QueryMaxID.SQL.Add('Select max('+NomChampId+') as NewID from '+Table.TableName);
  QueryMaxID.SQL.Add(ConditionWhere);
  QueryMaxID.Open;
     if QueryMaxID.FindField('NewID').AsInteger <> 0 then
     result:=QueryMaxID.FindField('NewID').AsInteger+1
     else
     Result:=1;
 except
  QueryMaxID.Close;
  QueryMaxID.Free;
  showmessage('Problème dans la table '+Table.TableName+' lors de la generation de l''ID !');
  abort;
 end;//fin du try
 QueryMaxID.Close;
 QueryMaxID.Free;
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
     if QueryMaxID.FindField('NewID').AsInteger <> 0 then
     result:=QueryMaxID.FindField('NewID').AsInteger+1
     else
     Result:=1;
 except
  QueryMaxID.Close;
  QueryMaxID.Free;
  showmessage('Problème dans la table '+Table.TableName+' lors de la generation de l''ID !');
  abort;
 end;//fin du try
 QueryMaxID.Close;
 QueryMaxID.Free;
//
End;

Procedure TableIBGereModifTable(FlagTable:Boolean;NomTable:String);
Begin
   if FlagTable then
     begin
      MessageDlg('La table '+NomTable+' ne peut pas être modifiée.', mtWarning, [mbOK], 0);
      abort;
     end;
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
 //TIBTable
 try
   if (dataset is TIBTable)then
     begin
       if (dataset as TIBTable).Database<>nil then
           if not (dataset as TIBTable).Transaction.InTransaction then
            begin
//              (dataset as TIBTable).Database.TransIsolation:=tiDirtyRead;
              (dataset as TIBTable).Transaction.StartTransaction;
              //showmessage('start transaction table   '+(dataset as TTable).TableName);
            end;
     end;
 except
    showmessage('TableGereStartTransaction : Erreur lors du StartTransaction de la table :'+(dataset as TIBTable).TableName);
    SysUtils.Abort;
 end;

 //TIBQuery
 try
   if (dataset is TIBQuery)then
     begin
       if (dataset as TIBQuery).Database<>nil then
           if not (dataset as TIBQuery).Transaction.InTransaction then
            begin
//              (dataset as TIBQuery).Database.TransIsolation:=tiDirtyRead;
              (dataset as TIBQuery).Transaction.StartTransaction;
              //showmessage('start transaction table   '+(dataset as TTable).TableName);
            end;
     end;
 except
    showmessage('TableGereStartTransaction : Erreur lors du StartTransaction de la table :'+(dataset as TIBQuery).Name);
    SysUtils.Abort;
 end;
End;

end.
