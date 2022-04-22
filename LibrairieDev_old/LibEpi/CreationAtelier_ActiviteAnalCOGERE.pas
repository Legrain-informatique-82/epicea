unit CreationAtelier_ActiviteAnalCOGERE;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs;

procedure CreateTableAtelier_ActiviteAnalCOGERE(Path : String);

implementation

procedure CreateTableAtelier_ActiviteAnalCOGERE(Path : String);
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
            TableName := 'TA_Atelier_Activite.DB';
            open;
            if RecordCount = 0 then
            begin
            AppendRecord(['1','11','1']);
            AppendRecord(['2','11','1']);
            AppendRecord(['3','12','1']);
            AppendRecord(['4','11','1']);
            AppendRecord(['5','11','1']);
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


 