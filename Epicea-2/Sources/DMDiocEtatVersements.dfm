�
 TDMDIOCETATVERSEMENT 0
  TPF0TDMDiocEtatVersementDMDiocEtatVersementOnCreateDMDiocEtatVersementCreate	OnDestroyDMDiocEtatVersementDestroyLeft�TopjHeight� Width% TTable
TaEcritureDatabaseNameDossier	TableNameEcriture.DBLeftTop  TDataSource
DaEcritureDataSet
QuEcritureLeftxTop  TQuery
QuEcritureFiltered	
BeforeOpenQuEcritureBeforeOpenOnCalcFieldsQuEcritureCalcFieldsOnFilterRecordQuEcritureFilterRecordDatabaseNameDossierSQL.Strings�select Ecr.Compte, sum (Ecr.DebitSaisie) as Debit, sum(Ecr.CreditSaisie) as Credit, sum(Ecr.debitSaisie-Ecr.CreditSaisie) as Soldefrom Ecriture Ecr&join  Piece P on (Ecr.ID_Piece = P.ID)where Ecr.Compte like (:RacCpt)/and P."Date" >=:DateDeb and P."Date" <=:DateFinand P.champ_Gen=''group by Ecr.Compte Params.Data
7     RacCpt  0   DateDeb 	 Z�
   DateFin 	 Z�
   LeftxTopX TStringFieldQuEcritureCompte	FieldNameCompteSize  TCurrencyFieldQuEcritureDebit	FieldNameDebit  TCurrencyFieldQuEcritureCredit	FieldNameCredit  TCurrencyFieldQuEcritureSolde	FieldNameSolde  TStringFieldQuEcritureLibelle	FieldNameLibelleLookupDataSetTaPlanLookupKeyFieldsCompteLookupResultFieldLibelle	KeyFieldsCompteSizedLookup	  TCurrencyFieldQuEcritureSoldeCalc	FieldName	SoldeCalc
Calculated	   TTableTaPlanDatabaseNameDossier	TableName
PlanCpt.DBLeftTopX  TQueryQuEcritureTrimPrecFiltered	OnFilterRecordQuEcritureTrimPrecFilterRecordDatabaseNameDossierSQL.Strings�select  Ecr.Compte, sum (Ecr.DebitSaisie) as Debit, sum(Ecr.CreditSaisie) as Credit, sum(Ecr.debitSaisie-Ecr.CreditSaisie) as Soldefrom Ecriture Ecr&join  Piece P on (Ecr.ID_Piece = P.ID)where Ecr.Compte like (:RacCpt)/and P."Date" >=:DateDeb and P."Date" <=:DateFinand P.champ_Gen=''group by Ecr.Compte Params.Data
7     RacCpt  0   DateDeb 	 Z�
   DateFin 	 Z�
   Left� TopX TStringFieldQuEcritureTrimPrecCompte	FieldNameCompteSize  TCurrencyFieldQuEcritureTrimPrecDebit	FieldNameDebit  TCurrencyFieldQuEcritureTrimPrecCredit	FieldNameCredit  TCurrencyFieldQuEcritureTrimPrecSolde	FieldNameSolde   TDataSourceDaEcritureTrimPrecDataSetQuEcritureTrimPrecLeft� Top   TQueryQuEtatDeVersementDatabaseNameDossierSQL.Stringsselect * from Piece0where Substring(Reference from 3 for 2)=:CodeExo9and SubString(Champ_Gen from 1 for 3)=:Valeur_champ_generorder by Piece."Date" Params.Data
/     CodeExo  0   Valeur_champ_gener  0   Left� Top�   TTableTaPiecesInfoDatabaseNameDossier	TableNamePiece.DBLeftHTop,   