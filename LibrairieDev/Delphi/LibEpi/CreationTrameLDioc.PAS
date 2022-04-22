unit CreationTrameLDioc;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs,Variants;

procedure CreateTableTrameLDioc(Path : String);

implementation

procedure CreateTableTrameLDioc(Path : String);
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
            TableName := 'TrameL.DB';
            open;
            if RecordCount = 0 then
            begin
               AppendRecord(['2','5','1','7542','Quête paroissale',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['3','5','2','750','Cierges et lumignons',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['4','5','3','7545','Dons Divers',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['5','5','4','75451','Troncs',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['6','5','5','7560','Cotisations catéchismes',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['7','5','6','7071','Librairie',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['8','5','7','7072','Imprimerie, journaux',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['9','5','8','7421','Traitement des prêtres',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['10','5','9','7510','Participation du diocèse',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['11','6','1','754311','Casuel Maraige',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['12','6','2','754312','Casuel Baptême',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['13','6','3','754313','Casuel Obsèques',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['14','6','4','75431','Messes à célébrer',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['15','7','1','7088','Kermesse, loto et voyages',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['16','7','2','7084','Prestations de service',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['17','7','3','7640','Produits financiers',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['18','7','4','741','Subventions',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['19','7','5','7710','Remboursement d''assurance',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['20','7','6','772','Produits divers',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['21','7','7','752','Revenus des immeubles',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['22','7','8','7914','Remboursement alimentation',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['23','7','9','7545219','Quêtes chantiers paroissiaux',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['24','8','1','7545211','Missions d''Afrique',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['25','8','2','7545212','Communications Sociales',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['26','8','3','7545213','Enseignement Catholique',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['27','8','4','7545214','Séminaires',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['28','8','5','7545215','Lieux Saints',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['29','8','6','7545216','Journée mondiale des Vocations',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['30','8','7','7545217','Facultés Catholiques de Lyon',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['31','8','8','7545218','Denier de St Pierre',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['32','8','9','7545219','Chantier Diocésain',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['33','8','10','7545221','Mali',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['34','8','11','7545222','Catéchèse',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['35','8','12','7545223','Journée mondiale des missions',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['36','8','13','7545224','Secours catholique',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['37','8','14','7545225','Action Catholique',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['38','8','15','7545226','Séminaires',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['39','8','16','7545227','Pax Christi',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['40','8','17','7545228','Messe à célébrer',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['41','8','18','7545229','Binages et Trinages',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['42','8','19','7545231','Confirmations',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['43','8','20','7545232','Pastorales des Jeunes',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['44','8','21','7545233','Retraites des prêtres',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['45','8','22','7545234','Malades de Lourdes',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['46','8','23','7545235','OEuvre des campagnes',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['47','8','24','7545236','CCFD',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['48','16','1','6063','Fournitures d''entretien',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['49','16','2','6120','Redevance de crédit bail ( copieur )',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['50','16','3','613','Locations',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['51','16','4','614','Charges locatives',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['52','16','5','6152','Entretien des bâtiments',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['53','16','6','6153','Entretien des parcs',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['54','16','7','6156','Maintenance',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['55','16','8','6161','Assurance incendie vol',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['56','16','9','6227','Frais d''acte et contentieux',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['57','16','10','6351','Taxes foncières',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['58','16','11','6352','Autres impôts locaux',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['59','16','12','2183','Mobilier, matériel ...',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['60','10','1','606110','Electricité',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['61','10','2','606111','Eau',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['62','10','3','606112','Gaz',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['63','10','4','606113','Fuel',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['64','11','1','60635','Cierges et lumignons',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['65','11','2','60270','Lingerie, vestiaire',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['66','11','3','606351','Fleurs',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['67','11','4','606360','Petit matériel',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['68','11','5','606361','Hosties',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['69','11','6','6238','Dons aux oeuvres ( pourboires ... )',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['70','12','1','61851','Formations des prêtres',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['71','12','2','61852','Formation de laïcs',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['72','12','3','61853','Frais de colloques, sessions, conférences',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['73','12','4','6228','Indemnités prédicateurs',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['74','13','1','6421','Traitements des prêtres, diacres, religieux(ses)',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['75','13','2','60610','Alimentation',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['76','13','3','6251','Déplacements',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['77','13','4','62281','Indemnités aux prêtres extérieurs',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['78','17','1','6071','Librairie',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['79','17','2','6072','Imprimés, journaux et registres',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['80','17','3','6073','Annuaires et ordos',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['81','17','4','6164','Assurances responsabilités civile',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['82','17','5','6410','Rémunération du personnel',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['83','17','6','6450','Charges sociales',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['84','17','7','6250','Déplacement, missions et réceptions',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['85','17','8','6573','Subventions aux mouvements',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['86','18','1','6064','Fournitures administratives',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['87','18','2','6182','Abonnements',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['88','18','3','6231','Annonces et insertions',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['89','18','4','6236','Frais de collecte',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['90','18','5','6261','Timbres et affranchissements',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['91','18','6','6262','Téléphone',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['92','18','7','6512','Redevance télé',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['93','18','8','6580','Charges diverses de gestion courante',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['94','19','1','6226','Honoraires de conseils',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['95','19','2','6370','Autres impôts',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['96','19','3','6516','Droits d''auteurs (SACEM ...)',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['97','19','4','6278','Autres services bancaires',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['98','19','5','6611','Intérêts des emprunts (agios ...)',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['99','19','6','6710','Charges exceptionnelles',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
               AppendRecord(['100','19','7','6581','Evénements organisés par la paroisse',0,0,0,0,'',NULL,'','LGR','01/01/1980 00:00:00','H']);
            flushBuffers;
            end;
          end;
      except
        Application.MessageBox('Erreur lors de l''initialisation du plan comptable Diocèse','Attention',MB_OK+MB_ICONSTOP);
      end;
  except
        Application.MessageBox('Erreur lors de l''initialisation du plan comptable Diocèse','Attention',MB_OK+MB_ICONSTOP);
  end;
Table.Close;
Table.Free;
DBAux.Close;
DBAux.Free;
End;

end.
