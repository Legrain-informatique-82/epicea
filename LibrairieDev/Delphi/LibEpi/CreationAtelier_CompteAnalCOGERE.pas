unit CreationAtelier_CompteAnalCOGERE;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs;

procedure CreateTableAtelier_CompteAnalCOGERE(Path : String);

implementation

procedure CreateTableAtelier_CompteAnalCOGERE(Path : String);
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
            TableName := 'TA_Compte_Atelier.DB';
            open;
            if RecordCount = 0 then
            begin
              AppendRecord(['6021','5','Charges de mécanisation','1']);
              AppendRecord(['6023','5','Charges de mécanisation','1']);
              AppendRecord(['6024','2','Charges diverses','1']);
              AppendRecord(['6025','2','Charges diverses','1']);
              AppendRecord(['60321','5','Charges de mécanisation','1']);
              AppendRecord(['60323','5','Charges de mécanisation','1']);
              AppendRecord(['60324','2','Charges diverses','1']);
              AppendRecord(['60325','2','Charges diverses','1']);
              AppendRecord(['6058','2','Charges diverses','1']);
              AppendRecord(['6061','2','Charges diverses','1']);
              AppendRecord(['6062','2','Charges diverses','1']);
              AppendRecord(['6063','2','Charges diverses','1']);
              AppendRecord(['6064','2','Charges diverses','1']);
              AppendRecord(['6066','5','Charges de mécanisation','1']);
              AppendRecord(['609','2','Charges diverses','1']);
              AppendRecord(['6122','5','Charges de mécanisation','1']);
              AppendRecord(['6125','1','Batiment et foncier','1']);
              AppendRecord(['6131','1','Batiment et foncier','1']);
              AppendRecord(['6132','5','Charges de mécanisation','1']);
              AppendRecord(['6151','1','Batiment et foncier','1']);
              AppendRecord(['6153','1','Batiment et foncier','1']);
              AppendRecord(['6154','1','Batiment et foncier','1']);
              AppendRecord(['6155','5','Charges de mécanisation','1']);
              AppendRecord(['6156','1','Batiment et foncier','1']);
              AppendRecord(['6161','2','Charges diverses','1']);
              AppendRecord(['6168','2','Charges diverses','1']);
              AppendRecord(['617','2','Charges diverses','1']);
              AppendRecord(['6181','2','Charges diverses','1']);
              AppendRecord(['6183','2','Charges diverses','1']);
              AppendRecord(['621','4','Main d''oeuvre','1']);
              AppendRecord(['6226','2','Charges diverses','1']);
              AppendRecord(['6228','2','Charges diverses','1']);
              AppendRecord(['623','2','Charges diverses','1']);
              AppendRecord(['6251','2','Charges diverses','1']);
              AppendRecord(['6256','2','Charges diverses','1']);
              AppendRecord(['6257','2','Charges diverses','1']);
              AppendRecord(['626','2','Charges diverses','1']);
              AppendRecord(['627','2','Charges diverses','1']);
              AppendRecord(['6272','2','Charges diverses','1']);
              AppendRecord(['6278','2','Charges diverses','1']);
              AppendRecord(['6286','2','Charges diverses','1']);
              AppendRecord(['6352','1','Batiment et foncier','1']);
              AppendRecord(['6353','1','Batiment et foncier','1']);
              AppendRecord(['6357','2','Charges diverses','1']);
              AppendRecord(['6358','2','Charges diverses','1']);
              AppendRecord(['6378','2','Charges diverses','1']);
              AppendRecord(['6411','4','Main d''oeuvre','1']);
              AppendRecord(['6412','4','Main d''oeuvre','1']);
              AppendRecord(['6413','4','Main d''oeuvre','1']);
              AppendRecord(['6451','4','Main d''oeuvre','1']);
              AppendRecord(['646','4','Main d''oeuvre','1']);
              AppendRecord(['6460','4','Main d''oeuvre','1']);
              AppendRecord(['648','4','Main d''oeuvre','1']);
              AppendRecord(['6611','1','Batiment et foncier','1']);
              AppendRecord(['6612','2','Charges diverses','1']);
              AppendRecord(['6613','2','Charges diverses','1']);
              AppendRecord(['6614','2','Charges diverses','1']);
              AppendRecord(['6615','2','Charges diverses','1']);
              AppendRecord(['6616','2','Charges diverses','1']);
              AppendRecord(['6618','2','Charges diverses','1']);
              AppendRecord(['665','2','Charges diverses','1']);
              AppendRecord(['666','2','Charges diverses','1']);
              AppendRecord(['668','2','Charges diverses','1']);
              AppendRecord(['6712','2','Charges diverses','1']);
              AppendRecord(['6714','2','Charges diverses','1']);
              AppendRecord(['6718','2','Charges diverses','1']);
              AppendRecord(['675','2','Charges diverses','1']);
              AppendRecord(['6751','2','Charges diverses','1']);
              AppendRecord(['6752','2','Charges diverses','1']);
              AppendRecord(['6754','2','Charges diverses','1']);
              AppendRecord(['6756','2','Charges diverses','1']);
              AppendRecord(['68111','2','Charges diverses','1']);
              AppendRecord(['681111','2','Charges diverses','1']);
              AppendRecord(['681115','2','Charges diverses','1']);
              AppendRecord(['68112','1','Batiment et foncier','1']);
              AppendRecord(['681121','1','Batiment et foncier','1']);
              AppendRecord(['681122','1','Batiment et foncier','1']);
              AppendRecord(['681123','1','Batiment et foncier','1']);
              AppendRecord(['681124','5','Charges de mécanisation','1']);
              AppendRecord(['681125','5','Charges de mécanisation','1']);
              AppendRecord(['68174','3','Eléments divers','1']);
              AppendRecord(['7090','2','Charges diverses','1']);
              AppendRecord(['722','3','Eléments divers','1']);
              AppendRecord(['7423','5','Charges de mécanisation','1']);
              AppendRecord(['7424','1','Batiment et foncier','1']);
              AppendRecord(['7440','3','Eléments divers','1']);
              AppendRecord(['7450','3','Eléments divers','1']);
              AppendRecord(['76','3','Eléments divers','1']);
              AppendRecord(['761','3','Eléments divers','1']);
              AppendRecord(['7611','3','Eléments divers','1']);
              AppendRecord(['7612','3','Eléments divers','1']);
              AppendRecord(['762','3','Eléments divers','1']);
              AppendRecord(['763','3','Eléments divers','1']);
              AppendRecord(['764','3','Eléments divers','1']);
              AppendRecord(['765','3','Eléments divers','1']);
              AppendRecord(['766','3','Eléments divers','1']);
              AppendRecord(['768','3','Eléments divers','1']);
              AppendRecord(['771','2','Charges diverses','1']);
              AppendRecord(['775','3','Eléments divers','1']);
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



 