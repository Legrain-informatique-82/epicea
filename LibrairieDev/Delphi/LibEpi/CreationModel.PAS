unit CreationModel;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs;

procedure CreateTableModel(Path : String);

implementation

procedure CreateTableModel(Path : String);
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
            TableName := 'Model.DB';
            open;
            if RecordCount = 0 then
            begin
              AppendRecord(['1','A','Achat','','AC','','5120',True,'','1','LGR','01/01/1980 00:00:00']);
              AppendRecord(['2','V','Vente','','VT','','5120',True,'','2','LGR','01/01/1980 00:00:00']);
              AppendRecord(['3','OD','Opérations Diverses','','OD','','5120',True,'','3','LGR','01/01/1980 00:00:00']);
              AppendRecord(['4','B0','Banque 5120','Prêtres','B0','5120','5120',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['5','B1','Banque 5121','Prêtres','B1','5121','5121',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['6','C0','Caisse 530','Services','C0','530','530',True,'','4','LGR','01/01/1980 00:00:00']);
            flushBuffers;
            end;
          end;
      except
        Application.MessageBox('Erreur lors de l''initialisation des Entêtes Trames Diocèse','Attention',MB_OK+MB_ICONSTOP);
      end;
  except
        Application.MessageBox('Erreur lors de l''initialisation des Entêtes Trames Diocèse','Attention',MB_OK+MB_ICONSTOP);
  end;
Table.Close;
Table.Free;
DBAux.Close;
DBAux.Free;
End;

end.
