unit CreationTrameDioc;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs;

procedure CreateTableTrameDioc(Path : String);

implementation

procedure CreateTableTrameDioc(Path : String);
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
            TableName := 'Trame.DB';
            open;
            if RecordCount = 0 then
            begin
              AppendRecord(['5','REC_ORD','Recettes Ordinaires','Prêtres','B1','5120','',True,'0','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['6','SERVICES','Services','Services','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['7','REC_EXC','Recettes exceptionnelles','Recettes ordinaires','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['8','QUETES','Quêtes impérées','Recettes Exceptionnelles','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['10','DEP_ENER','Dépenses d''énergie','','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['11','DEP_CULTE','Dépenses de culte','','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['12','FORMATION','Formation des prêtres et des laïcs','Quêtes impérées','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['13','PRETRES','Prêtres','Prêtres','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['16','IMM_MAT','Dépenses immobilier et matériel','Formation des prêtres et des laïcs','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['17','PASTORAL','Pastorale','Pastorale','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['18','ADMIN','Administration','','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
              AppendRecord(['19','DEP_DIV','Dépenses diverses','Formation des prêtres et des laïcs','B1','5120','',True,'','4','LGR','01/01/1980 00:00:00']);
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
