�
 TDMDIOCETATGESTIONANAL 0s
  TPF0TDMDiocEtatGestionAnalDMDiocEtatGestionAnalOnCreateDMDiocEtatGestionAnalCreate	OnDestroyDMDiocEtatGestionAnalDestroyLeft�Top@HeightWidth> TQuery
QuEtatAnalBeforeInsertQuEtatAnalBeforeInsert
BeforeEditQuEtatAnalBeforeEditDatabaseNameDossierSQL.Strings�select Ecr.compte, sum(Ecr.creditSaisie) as Credit, sum(Ecr.debitSaisie) as Debit, sum(Ecr.debitSaisie - Ecr.CreditSaisie) as Soldefrom  Ecriture EcrwhereEEcr.ID_Piece in(select P1.ID from Piece P1 where P1.Val_Champ_gen='')and-Ecr."Date">=:DateDeb and Ecr."Date"<=:DateFingroup by Ecr.compte Params.Data
(     DateDeb 	 Z�
   DateFin 	 Z�
   LeftTop TStringFieldQuEtatAnalcompte	FieldNamecompteSize  TCurrencyFieldQuEtatAnalCredit	FieldNameCredit  TCurrencyFieldQuEtatAnalDebit	FieldNameDebit  TCurrencyFieldQuEtatAnalSolde	FieldNameSolde   TTableTaTrameDatabaseNameDossier	TableNameTrame.DBLefthTop TAutoIncField	TaTrameID	FieldNameID  TStringFieldTaTrameLibelle_Trame	FieldNameLibelle_TrameSized  TStringFieldTaTrameJournal	FieldNameJournalSize  TStringFieldTaTrameCompte	FieldNameCompteSize  TCurrencyFieldTaTrameSolde	FieldNameSolde
Calculated	  TStringFieldTaTrameCode	FieldNameCodeSize
   TDataSourceDaTrameDataSetTaTrameLefthTopX  TDataSource
DaEtatAnalAutoEditDataSet
QuEtatAnalLeftTop`  TTableTaTrameLFilterID=0Filtered	
BeforeOpenTaTrameLBeforeOpenOnCalcFieldsTaTrameLCalcFieldsDatabaseNameDossier	IndexName	_ID_TrameMasterFieldsIDMasterSourceDaTrameReadOnly		TableName	TrameL.DBLeft� Top TAutoIncField
TaTrameLID	FieldNameID  TIntegerFieldTaTrameLID_Trame	FieldNameID_Trame  TSmallintFieldTaTrameLLigne	FieldNameLigne  TStringFieldTaTrameLCompte	FieldNameCompteSize  TStringFieldTaTrameLLibelle	FieldNameLibelleSized  TCurrencyFieldTaTrameLSolde	FieldNameSolde
Calculated	   TDataSourceDaTrameLDataSetTaTrameLLeft� Top`  TQueryQuTotauxTrameDatabaseNameDossierSQL.Stringswselect sum(Ecr.creditSaisie) as Credit, sum(Ecr.debitSaisie) as Debit, sum(Ecr.debitSaisie - Ecr.CreditSaisie) as Soldefrom  Ecriture Ecr'join TrameL TL on(Ecr.compte=TL.compte)$join Trame T on (T.ID = TL.Id_Trame)whereEEcr.ID_Piece in(select P1.ID from Piece P1 where P1.Val_Champ_gen='')and-Ecr."Date">=:DateDeb and Ecr."Date"<=:DateFinandT.Code=:CodeTrame Params.Data
:     DateDeb 	 Z�
   DateFin 	 Z�
   	CodeTrame  0   LeftTop�  TCurrencyFieldQuTotauxTrameCredit	FieldNameCredit  TCurrencyFieldQuTotauxTrameDebit	FieldNameDebit  TCurrencyFieldQuTotauxTrameSolde	FieldNameSolde    