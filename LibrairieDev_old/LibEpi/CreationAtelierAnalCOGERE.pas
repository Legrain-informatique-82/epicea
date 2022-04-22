unit CreationAtelierAnalCOGERE;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs;

procedure CreateTableATelierAnalCOGERE(Path : String);

implementation

procedure CreateTableATelierAnalCOGERE(Path : String);
var
  table: TTable;
  DBAux:TDataBase;
Begin
  Try
      DBAux:=TDataBase.Create(Application);
      DBAux.DatabaseName:='Tmp';
      DBAux.Params.Add('PATH=' + Path);
      DBAux.Params.Add('ENABLE BCD=FALSE');
      DBAux.Params.Add('DEFAULT DRIVER=PARADOX');
      DBAux.TransIsolation:=tiDirtyRead;
      DBAux.DriverName:='Standard';
      DBAux.open;
      table := TTable.Create(Application);
      Try
        with table do
          begin
            DataBaseName := 'Tmp';
            TableName := 'TA_Atelier.DB';
            open;
            if RecordCount = 0 then
            begin
            AppendRecord(['1','BAFO','Batiment et foncier',NIL,NIL,'11','CS']);
            AppendRecord(['2','DIVE','Charges diverses',NIL,NIL,'11','CS']);
            AppendRecord(['3','ELEM','Eléments divers',NIL,NIL,'12','EE']);
            AppendRecord(['4','M--O','Main d''oeuvre',NIL,NIL,'11','CS']);
            AppendRecord(['5','MECA','Charges de mécanisation',NIL,NIL,'11','CS']);
            flushBuffers;
            end;
          end
      except
        Application.MessageBox('Erreur lors de l''initialisation de la table de référence analytique !','Attention',MB_OK+MB_ICONSTOP);
      end;
  except
        Application.MessageBox('Erreur lors de l''initialisation de la table de référence analytique !','Attention',MB_OK+MB_ICONSTOP);
  end;
Table.Close;
Table.Free;
DBAux.Close;
DBAux.Free;
End;

end.

