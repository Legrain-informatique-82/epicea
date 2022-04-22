unit CreationConstAnalCOGERE;

interface

uses SysUtils,Windows, Classes, Graphics, Forms, Controls,
     StdCtrls, DBTables, DB, ExtCtrls, Dialogs;

procedure CreateTableConstAnalCOGERE(Path : String);
procedure CreateTableActiviteAnalCOGERE(Path : String);

implementation

procedure CreateTableConstAnalCOGERE(Path : String);
var
  table: TTable;
  query: TQuery;
  DBAux:TDataBase;
  NotExist:boolean;
  max:integer;
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
      query := TQuery.Create(Application);
      table := TTable.Create(Application);
      Try
        with table do
          begin
            DataBaseName := 'Tmp';
            TableName := 'AtelierDefaut.DB';
            open;
            if RecordCount = 0 then
            begin
              AppendRecord(['1','AGRI','Activités agritourisme',Nil,Nil,'0','U;']);
              AppendRecord(['2','APIC','Apiculture',Nil,Nil,'9','U;']);
              AppendRecord(['3','AQUA','Aquaculture',Nil,Nil,'9','U;']);
              AppendRecord(['4','ARMA','Armagnac',Nil,Nil,'6','Ha;']);
              AppendRecord(['5','AROM','Plantes aromatiques',Nil,Nil,'2','Ha;']);
              AppendRecord(['6','ASPE','Asperges en production',Nil,Nil,'4','Ha;']);
              AppendRecord(['7','ASPO','Asperges en non production',Nil,Nil,'4','Ha;']);
              AppendRecord(['8','AUT1','Autruches reproduction',Nil,Nil,'9','U;']);
              AppendRecord(['9','AUT2','Autruches viande',Nil,Nil,'9','U;']);
              AppendRecord(['10','AVOI','Avoine',Nil,Nil,'1','Ha;']);
              AppendRecord(['11','BAFO','Batiment et foncier',Nil,Nil,'CS',';']);
              AppendRecord(['12','BIOA','Productions animales bio',Nil,Nil,'8','U;']);
              AppendRecord(['13','BIOC','Productions cultures bio',Nil,Nil,'1','U;']);
              AppendRecord(['14','BIOG','Productions générales bio',Nil,Nil,'0','U;']);
              AppendRecord(['15','BLE','Blé',Nil,Nil,'1','Ha;']);
              AppendRecord(['16','BOIS','Sylviculture',Nil,Nil,'7','Ha;']);
              AppendRecord(['17','BONE','Bovin viande naisseur engraisseur',Nil,Nil,'8','U;']);
              AppendRecord(['18','BOVE','Bovin viande engraisseur',Nil,Nil,'8','U;']);
              AppendRecord(['19','BOVL','Bovins-lait',Nil,Nil,'8','U;']);
              AppendRecord(['20','BOVN','Bovin viande naisseur',Nil,Nil,'8','U;']);
              AppendRecord(['21','BOVV','Bovins-viandes',Nil,Nil,'8','U;']);
              AppendRecord(['22','C-EG','Canards élevés gavés',Nil,Nil,'9','U;']);
              AppendRecord(['23','C-EL','Canards élevés',Nil,Nil,'9','U;']);
              AppendRecord(['24','C-GA','Canards gavés',Nil,Nil,'9','U;']);
              AppendRecord(['25','C-RO','Canards à rotir',Nil,Nil,'9','U;']);
              AppendRecord(['26','C-SA','Canards sauvages',Nil,Nil,'9','U;']);
              AppendRecord(['27','CACA','Cacahuètes',Nil,Nil,'2','Ha;']);
              AppendRecord(['28','CAIL','Cailles',Nil,Nil,'9','U;']);
              AppendRecord(['29','CAMP','Camping',Nil,Nil,'0','U;']);
              AppendRecord(['30','CANE','Canes reproductrices',Nil,Nil,'9','U;']);
              AppendRecord(['31','CAPR','Caprins',Nil,Nil,'8','U;']);
              AppendRecord(['32','CARO','Carottes',Nil,Nil,'4','Ha;']);
              AppendRecord(['33','CEDE','Elevage canards 1 à 15 jours',Nil,Nil,'9','U;']);
              AppendRecord(['34','CHAP','Chapons',Nil,Nil,'9','U;']);
              AppendRecord(['35','CHBR','Choux brocolis',Nil,Nil,'4','Ha;']);
              AppendRecord(['36','CHFL','Choux fleur',Nil,Nil,'4','Ha;']);
              AppendRecord(['37','COLZ','Colza',Nil,Nil,'2','Ha;']);
              AppendRecord(['38','CONF','Confits à la ferme',Nil,Nil,'0','U;']);
              AppendRecord(['39','CONS','Toutes conserves sauf canards / oies',Nil,Nil,'0','U;']);
              AppendRecord(['40','COQU','Coquelets',Nil,Nil,'9','U;']);
              AppendRecord(['41','DI-C','Dindes claustration',Nil,Nil,'9','U;']);
              AppendRecord(['42','DIND','Dindes',Nil,Nil,'9','U;']);
              AppendRecord(['43','DIVE','Charges diverses',Nil,Nil,'CS',';']);
              AppendRecord(['44','ELEM','Eléments divers',Nil,Nil,'EE',';']);
              AppendRecord(['45','EQUE','Centre équestre',Nil,Nil,'0','U;']);
              AppendRecord(['46','EQUI','Equins',Nil,Nil,'9','U;']);
              AppendRecord(['47','ESCO','Escurgeons',Nil,Nil,'1','Ha;']);
              AppendRecord(['48','ETAG','Travaux agricoles',Nil,Nil,'0','U;']);
              AppendRecord(['49','ETFO','Travaux forestiers',Nil,Nil,'0','U;']);
              AppendRecord(['50','FEIJ','Feijoas',Nil,Nil,'5','Ha;']);
              AppendRecord(['51','FERM','Ferme auberge',Nil,Nil,'0','U;']);
              AppendRecord(['52','FEVE','Fèves',Nil,Nil,'4','Ha;']);
              AppendRecord(['53','FL-P','Fleurs en prestation',Nil,Nil,'0','U;']);
              AppendRecord(['54','FLEU','Fleurs',Nil,Nil,'7','Ha;']);
              AppendRecord(['55','FRAI','Fraises',Nil,Nil,'4','Ha;']);
              AppendRecord(['56','FROM','Fromages',Nil,Nil,'8','U;']);
              AppendRecord(['57','FRUI','Cultures fruitières en production',Nil,Nil,'5','Ha;']);
              AppendRecord(['58','FRUO','Cultures fruitières en non production',Nil,Nil,'5','Ha;']);
              AppendRecord(['59','GIBI','Gibier',Nil,Nil,'9','U;']);
              AppendRecord(['60','GITE','Gite rural',Nil,Nil,'0','U;']);
              AppendRecord(['61','HA-V','Haricots verts',Nil,Nil,'4','Ha;']);
              AppendRecord(['62','HORT','Horticulture',Nil,Nil,'7','Ha;']);
              AppendRecord(['63','JACH','Jachère',Nil,Nil,'3','Ha;']);
              AppendRecord(['64','KIWI','Kiwis en production',Nil,Nil,'5','Ha;']);
              AppendRecord(['65','KIWO','Kiwis en non production',Nil,Nil,'5','Ha;']);
              AppendRecord(['66','LAPI','Lapins',Nil,Nil,'9','U;']);
              AppendRecord(['67','LEGU','Légumes',Nil,Nil,'4','Ha;']);
              AppendRecord(['68','LIN-','Lin',Nil,Nil,'2','Ha;']);
              AppendRecord(['69','LOCA','Location',Nil,Nil,'0','U;']);
              AppendRecord(['70','LOMB','Lombriculture',Nil,Nil,'9','U;']);
              AppendRecord(['71','MA2C','Maïs conso deuxième recolte',Nil,Nil,'1','Ha;']);
              AppendRecord(['72','MA2I','Maïs conso irrigué deuxième recolte',Nil,Nil,'1','Ha;']);
              AppendRecord(['73','MA2S','Maïs semences deuxième recolte',Nil,Nil,'1','Ha;']);
              AppendRecord(['74','M--O','Main d''oeuvre',Nil,Nil,'CS',';']);
              AppendRecord(['75','MA-A','Maïs amidon',Nil,Nil,'1','Ha;']);
              AppendRecord(['76','MA-C','Maïs consommation',Nil,Nil,'1','Ha;']);
              AppendRecord(['77','MA-D','Maïs doux',Nil,Nil,'1','Ha;']);
              AppendRecord(['78','MA-F','Maïs fourrager',Nil,Nil,'3','Ha;']);
              AppendRecord(['79','MA-S','Maïs semences',Nil,Nil,'1','Ha;']);
              AppendRecord(['80','MACB','Maïs bio',Nil,Nil,'1','U;']);
              AppendRecord(['81','MARA','Machaichage',Nil,Nil,'4','Ha;']);
              AppendRecord(['82','MECA','Charges de mécanisation',Nil,Nil,'CS',';']);
              AppendRecord(['83','MEDI','Plantes médicinales',Nil,Nil,'2','Ha;']);
              AppendRecord(['84','MELO','Melon',Nil,Nil,'4','Ha;']);
              AppendRecord(['85','MI-C','Maïs conso irrigué',Nil,Nil,'1','Ha;']);
              AppendRecord(['86','NONA','Production non analysable (animaux)',Nil,Nil,'8','U;']);
              AppendRecord(['87','NONC','Productions non analysable (cultures)',Nil,Nil,'1','U;']);
              AppendRecord(['88','NONG','Production non analysable général',Nil,Nil,'0','U;']);
              AppendRecord(['89','O-EG','Oies élevées gavées',Nil,Nil,'9','U;']);
              AppendRecord(['90','O-EL','Oies élevées',Nil,Nil,'9','U;']);
              AppendRecord(['91','O-GA','Oies gavées',Nil,Nil,'9','U;']);
              AppendRecord(['92','O-RE','Oies reproductrices',Nil,Nil,'9','U;']);
              AppendRecord(['93','OEUF','Oeufs',Nil,Nil,'9','U;']);
              AppendRecord(['94','ORGE','Orge',Nil,Nil,'1','Ha;']);
              AppendRecord(['95','OSIE','Osier',Nil,Nil,'7','Ha;']);
              AppendRecord(['96','OVIN','Ovins',Nil,Nil,'8','U;']);
              AppendRecord(['97','P-DT','Pommes de terre',Nil,Nil,'2','Ha;']);
              AppendRecord(['98','P-EL','Porcs engraisseurs',Nil,Nil,'8','U;']);
              AppendRecord(['99','P-EN','Porcs éleveurs naisseurs',Nil,Nil,'8','U;']);
              AppendRecord(['100','P-NE','Porcs naisseurs engraisseurs',Nil,Nil,'8','U;']);
              AppendRecord(['101','PARC','Parcours',Nil,Nil,'3','Ha;']);
              AppendRecord(['102','PECH','Pêches',Nil,Nil,'5','Ha;']);
              AppendRecord(['103','PEPI','Pépinières',Nil,Nil,'7','Ha;']);
              AppendRecord(['104','PEUP','Peupliers',Nil,Nil,'7','Ha;']);
              AppendRecord(['105','PI-B','Pintades bio',Nil,Nil,'9','U;']);
              AppendRecord(['106','PI-C','Pintades claustrastion',Nil,Nil,'9','U;']);
              AppendRecord(['107','PIGE','Pigeons',Nil,Nil,'9','U;']);
              AppendRecord(['108','PINT','Pintades',Nil,Nil,'9','U;']);
              AppendRecord(['109','PO-B','Poulets bio',Nil,Nil,'9','U;']);
              AppendRecord(['110','PO-C','Poulet claustration',Nil,Nil,'9','U;']);
              AppendRecord(['111','PO-F','Poulet fermier',Nil,Nil,'9','U;']);
              AppendRecord(['112','PO-L','Poulet label',Nil,Nil,'9','U;']);
              AppendRecord(['113','POIR','Poires',Nil,Nil,'5','Ha;']);
              AppendRecord(['114','POIS','Pois',Nil,Nil,'2','Ha;']);
              AppendRecord(['115','PR-A','Prairies artificielles',Nil,Nil,'3','Ha;']);
              AppendRecord(['116','PR-C','Prestation canes',Nil,Nil,'0','U;']);
              AppendRecord(['117','PR-N','Prairies naturelles',Nil,Nil,'3','Ha;']);
              AppendRecord(['118','PR-P','Prairies permanentes',Nil,Nil,'3','Ha;']);
              AppendRecord(['119','PR-V','Veaux en prestation',Nil,Nil,'0','U;']);
              AppendRecord(['120','PRCC','Prestation à façon conserves',Nil,Nil,'0','U;']);
              AppendRecord(['121','PRCD','Prestation à façon canards démar',Nil,Nil,'0','U;']);
              AppendRecord(['122','PRCE','Prestation à façon canards élevés',Nil,Nil,'0','U;']);
              AppendRecord(['123','PRCG','Prestation à façon canards gavés',Nil,Nil,'0','U;']);
              AppendRecord(['124','PRCH','Prestation à façon chapons',Nil,Nil,'0','U;']);
              AppendRecord(['125','PRCO','Prestations coquelets',Nil,Nil,'0','U;']);
              AppendRecord(['126','PRDI','Prestation à façon dindes',Nil,Nil,'0','U;']);
              AppendRecord(['127','PRPO','Prestation à façon poulets',Nil,Nil,'0','U;']);
              AppendRecord(['128','PRPR','Porcs en prestation',Nil,Nil,'0','U;']);
              AppendRecord(['129','PRUN','Pruniers',Nil,Nil,'5','Ha;']);
              AppendRecord(['130','PT-B','Pommes de terre bio',Nil,Nil,'2','Ha;']);
              AppendRecord(['131','SALA','Salade',Nil,Nil,'4','Ha;']);
              AppendRecord(['132','SAUG','Sauge',Nil,Nil,'2','Ha;']);
              AppendRecord(['133','SE-B','Semences de base toutes céréales',Nil,Nil,'1','Ha;']);
              AppendRecord(['134','SEIG','Seigle',Nil,Nil,'1','Ha;']);
              AppendRecord(['135','SOJA','Soja',Nil,Nil,'2','Ha;']);
              AppendRecord(['136','SORG','Sorgho',Nil,Nil,'1','Ha;']);
              AppendRecord(['137','TABA','Tabac',Nil,Nil,'2','Ha;']);
              AppendRecord(['138','TAHO','Tables d''hôtes',Nil,Nil,'0','U;']);
              AppendRecord(['139','TAU1','Taurillon léger 9 - 12 mois',Nil,Nil,'8','U;']);
              AppendRecord(['140','TAU2','Taurillon lourd 12 - 18 mois',Nil,Nil,'8','U;']);
              AppendRecord(['141','TAU3','Taurillon lourd > 18 mois',Nil,Nil,'8','U;']);
              AppendRecord(['142','TOUR','Tournesol',Nil,Nil,'2','Ha;']);
              AppendRecord(['143','TRAS','Prestation transport tout type',Nil,Nil,'0','U;']);
              AppendRecord(['144','TRIT','Triticale',Nil,Nil,'1','Ha;']);
              AppendRecord(['145','VE-B','Veau en batterie',Nil,Nil,'8','U;']);
              AppendRecord(['146','VIGN','Vignes en production',Nil,Nil,'6','Ha;']);
              AppendRecord(['147','VIGO','Vignes en non production',Nil,Nil,'6','Ha;']);
              AppendRecord(['148','VIPA','Vins de pays',Nil,Nil,'6','Ha;']);
              AppendRecord(['149','VISO','Vins du sud ouest',Nil,Nil,'6','Ha;']);
              AppendRecord(['150','VITA','Vins de table',Nil,Nil,'6','Ha;']);
              AppendRecord(['151','WBLA','Bordeaux blancs secs',Nil,Nil,'6','Ha;']);
              AppendRecord(['152','WBX2','Bordeaux rouge génériques',Nil,Nil,'6','Ha;']);
              AppendRecord(['153','WCOT','Autres bordeaux rouges',Nil,Nil,'6','Ha;']);
              AppendRecord(['154','WLIQ','Bordeaux blancs liquoreux',Nil,Nil,'6','Ha;']);
              AppendRecord(['155','VINIF','Vinification',Nil,Nil,'6','Hl;']);
              AppendRecord(['156','MISE','Mise en bouteilles',Nil,Nil,'6','Blle;']);
              AppendRecord(['157','STOCK','Elevage du vin',Nil,Nil,'6','Hl;']);
              AppendRecord(['158','COMMER','Commercialisation',Nil,Nil,'6','Hl;']);
            flushBuffers;
            end
            else
            begin
              Query.DataBaseName := 'Tmp';
                begin
                    max:=0;
                    Query.SQL.Clear;
                    Query.SQL.add('select max(id)as maxid from atelierDefaut ');
                    Query.open;
                    if Query.RecordCount<>0 then max:=query.findfield('maxid').AsInteger+1;

                    Query.SQL.Clear;
                    Query.SQL.add('select code_atelier from atelierDefaut where code_atelier = ''VINIF''');
                    Query.open;
                    if Query.RecordCount=0 then
                      begin
                          inc(max);
                          Query.SQL.Clear;
                          Query.SQL.Add('insert into AtelierDefaut.DB values('+inttostr(max)+',''VINIF'',''Vinification'',Null,null,''6'',''Hl'')');
                          Query.ExecSQL;
                      end;
                    Query.SQL.Clear;
                    Query.SQL.add('select code_atelier from atelierDefaut where code_atelier = ''MISE''');
                    Query.open;
                    if Query.RecordCount=0 then
                      begin
                          inc(max);
                          Query.SQL.Clear;
                          Query.SQL.Add('insert into AtelierDefaut.DB values('+inttostr(max)+',''MISE'',''Mise en bouteilles'',Null,null,''6'',''Blle'')');
                          Query.ExecSQL;
                      end;

                    Query.SQL.Clear;
                    Query.SQL.add('select code_atelier from atelierDefaut where code_atelier = ''STOCK''');
                    Query.open;
                    if Query.RecordCount=0 then
                      begin
                          inc(max);
                          Query.SQL.Clear;
                          Query.SQL.Add('insert into AtelierDefaut.DB values('+inttostr(max)+',''STOCK'',''Elevage du vin'',Null,null,''6'',''Hl'')');
                          Query.ExecSQL;
                      end;
                    Query.SQL.Clear;
                    Query.SQL.add('select code_atelier from atelierDefaut where code_atelier = ''COMMER''');
                    Query.open;
                    if Query.RecordCount=0 then
                      begin
                          inc(max);
                          Query.SQL.Clear;
                          Query.SQL.Add('insert into AtelierDefaut.DB values('+inttostr(max)+',''COMMER'',''Commercialisation'',Null,null,''6'',''Hl'')');
                          Query.ExecSQL;
                      end;

                    Query.SQL.Clear; //MA2C
                    Query.SQL.add('select code_atelier from atelierDefaut where code_atelier = ''MA2C''');
                    Query.open;
                    if Query.RecordCount=0 then
                      begin
                          inc(max);
                          Query.SQL.Clear;
                          Query.SQL.Add('insert into AtelierDefaut.DB values('+inttostr(max)+',''MA2C'',''Maïs conso deuxième recolte'',Null,null,''1'',''Ha'')');
                          Query.ExecSQL;
                      end;

                    Query.SQL.Clear; //MA2I
                    Query.SQL.add('select code_atelier from atelierDefaut where code_atelier = ''MA2I''');
                    Query.open;
                    if Query.RecordCount=0 then
                      begin
                          inc(max);
                          Query.SQL.Clear;
                          Query.SQL.Add('insert into AtelierDefaut.DB values('+inttostr(max)+',''MA2I'',''Maïs conso irrigué deuxième recolte'',Null,null,''1'',''Ha'')');
                          Query.ExecSQL;
                      end;

                    Query.SQL.Clear; //MA2S
                    Query.SQL.add('select code_atelier from atelierDefaut where code_atelier = ''MA2S''');
                    Query.open;
                    if Query.RecordCount=0 then
                      begin
                          inc(max);
                          Query.SQL.Clear;
                          Query.SQL.Add('insert into AtelierDefaut.DB values('+inttostr(max)+',''MA2S'',''Maïs semences deuxième recolte'',Null,null,''1'',''Ha'')');
                          Query.ExecSQL;
                      end;
                end;
            end;
          end
      except
        Application.MessageBox('Erreur lors de l''initialisation de la table de référence analytique !','Attention',MB_OK+MB_ICONSTOP);
      end;
  except
        Application.MessageBox('Erreur lors de l''initialisation de la table de référence analytique !','Attention',MB_OK+MB_ICONSTOP);
  end;
Table.Close;
Query.close;
Query.free;
Table.Free;
DBAux.Close;
DBAux.Free;
End;


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
