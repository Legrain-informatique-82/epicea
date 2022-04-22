unit CreationModelAgri;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs;

procedure CreateTableModelAgri(Path : String);

implementation

procedure CreateTableModelAgri(Path : String);
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
              AppendRecord(['1','A','Achat','','AC','','5121',True,'','1','LGR','01/01/1980 00:00:00']);
              AppendRecord(['2','V','Vente','','VT','','5121',True,'','2','LGR','01/01/1980 00:00:00']);
              AppendRecord(['3','OD','Opérations Diverses','','OD','','5121',True,'','3','LGR','01/01/1980 00:00:00']);
//              AppendRecord(['4','B0','Banque 5120','','B0','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['4','B1','Banque 5121','','B1','5121','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['5','C0','Caisse 530','Services','C0','530','',True,'','4','LGR','01/01/1980 00:00:00']);
            flushBuffers;
            end;
          end;
      except
        Application.MessageBox('Erreur lors de la création des Journaux Agricole','Attention',MB_OK+MB_ICONSTOP);
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
