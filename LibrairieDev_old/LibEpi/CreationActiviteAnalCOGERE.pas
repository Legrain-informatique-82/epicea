unit CreationActiviteAnalCOGERE;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs;

procedure CreateTableActiviteAnalCOGERE(Path : String);

implementation

procedure CreateTableActiviteAnalCOGERE(Path : String);
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
            TableName := 'TA_Activite.DB';
            open;
            if RecordCount = 0 then
            begin
            AppendRecord(['1','0','Autres activités']);
            AppendRecord(['2','1','Céréales']);
            AppendRecord(['3','2','Plantes industrielles et plantes médicinales']);
            AppendRecord(['4','3','Plantes fourragères et jachère']);
            AppendRecord(['5','4','Cultures maraichères']);
            AppendRecord(['6','5','Cultures fruitiers']);
            AppendRecord(['7','6','Viticulture']);
            AppendRecord(['8','7','Cultures sylvicole et horticole']);
            AppendRecord(['9','8','Productions animales']);
            AppendRecord(['10','9','Autres animaux']);
            AppendRecord(['11','CS','Charges de structure']);
            AppendRecord(['12','EE','Elements exceptionnels']);
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
 