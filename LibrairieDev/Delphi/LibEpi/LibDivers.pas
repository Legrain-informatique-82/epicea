unit LibDivers;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls,Db, DBTables,
   Gr_Librairie, dialogs,UString;

type
  TTraitement = procedure(base:TDatabase;Table:TTable;nomTable,ChampDest,
                                     ChampSource,DataType,valeur,Filtre:string);
var
  traitement:TTraitement;

   procedure CadreTransaction(base:TDatabase;Table:TTable;nomTable,ChampDest,
              ChampSource,DataType,valeur,Filtre:string;Traitement:TTraitement);
   procedure MiseAJourCacheBase(Database:TDatabase;Q:TQuery);
   function CreateControl(ControlClass: TControlClass;
                                 const ControlName: string): TControl;

implementation


procedure CadreTransaction(base:TDatabase;Table:TTable;nomTable,ChampDest,
               ChampSource,DataType,valeur,Filtre:string;Traitement:TTraitement);
var
  gere: boolean;
  temp : TTable;
begin
  gere := false;
  temp := TTable.Create(nil);
  temp.DatabaseName := base.DatabaseName;
  temp.TableName := nomtable;
  temp.open;
  if (temp.Database.InTransaction) then
    gere := true
  else
  begin
    (temp.Database.StartTransaction);
  end;
  temp.close;
 try
////////////////////////////////////////////////////////////////////////////////
  traitement(base,temp,nomtable,champdest,champsource,DataType,valeur,Filtre);
////////////////////////////////////////////////////////////////////////////////
  temp.open;
   if gere = false then temp.Database.Commit;
 except
   if (temp.Database.InTransaction) then (temp.Database.Rollback);
   raise;
 end;
end;

procedure MiseAJourCacheBase(Database:TDatabase;Q:TQuery);
begin
  Database.StartTransaction;
  try
    Q.ApplyUpdates;
    Database.Commit;
  except
    Database.Rollback;
    Raise;
  end;
  Q.CommitUpdates;
end;


function CreateControl(ControlClass: TControlClass;
                                 const ControlName: string): TControl;
begin
  if controlclass = nil then
  begin
    Result := ControlClass.Create(FPrint);
    with Result do
    begin
      Parent := FPrint;
      Name := ControlName;
    end;
  end;
end;

end.
 