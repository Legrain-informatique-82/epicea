�
 TDMBALANCE 0C  TPF0
TDMBalance	DMBalanceOldCreateOrder	OnCreateDMBalanceCreate	OnDestroyDMBalanceDestroyLeftTopHeightbWidth� TTable	TaBalanceAfterInsertTaBalanceAfterInsertDatabaseNameExercice	TableName
Balance.DBLeftTop  TStringFieldTaBalanceCompte	FieldNameCompteSize  TStringFieldTaBalanceTiers	FieldNameTiersSize  TFloatFieldTaBalanceDebit_Report	FieldNameDebit_Report  TFloatFieldTaBalanceCredit_Report	FieldNameCredit_Report  TFloatFieldTaBalanceDebit_Base	FieldName
Debit_Base  TFloatFieldTaBalanceCredit_Base	FieldNameCredit_Base  TFloatFieldTaBalanceDebit_Total	FieldNameDebit_Total  TFloatFieldTaBalanceCredit_Total	FieldNameCredit_Total  TFloatFieldTaBalanceQt1_Report	FieldName
Qt1_Report  TFloatFieldTaBalanceQt2_Report	FieldName
Qt2_Report  TFloatFieldTaBalanceQt1_Base	FieldNameQt1_Base  TFloatFieldTaBalanceQt2_Base	FieldNameQt2_Base  TFloatFieldTaBalanceQt1_Total	FieldName	Qt1_Total  TFloatFieldTaBalanceQt2_Total	FieldName	Qt2_Total  TFloatFieldTaBalanceTotalDeb	FieldKindfkCalculated	FieldNameTotalDeb
Calculated	  TFloatFieldTaBalanceTotalCred	FieldKindfkCalculated	FieldName	TotalCred
Calculated	   TQueryQueryEcritureDatabaseNameDossierSQL.Strings2select compte, sum(DebitSaisie), sum(CreditSaisie)from Ecriture.db)where "Ecriture.db"."Date" >= :DateDebExogroup by compte  Left`Top(	ParamDataDataTypeftDateName
DateDebExo	ParamType	ptUnknown   TStringFieldQueryEcriturecompte	FieldNamecompteSize  TFloatFieldQueryEcritureSUMOFDebitSaisie	FieldNameSUM OF DebitSaisie  TFloatFieldQueryEcritureSUMOFCreditSaisie	FieldNameSUM OF CreditSaisie   TQuery
QueryRecupDatabaseNameExerciceSQL.StringsFSelect Compte,((Debit_Report+Debit_Base)-(Credit_Report+Credit_Base)) 	as Total,9((Qt1_Report+Qt1_Base)-(Qt2_Report+Qt2_Base)) as QtTotal from Balance.db Awhere ((Debit_Report+Debit_Base)-(Credit_Report+Credit_Base)) <>0Pand  substring(Compte from 1 for 1)<>'6' and substring(Compte from 1 for 1)<>'7' Left0Top�  TStringFieldQueryRecupCompte	FieldNameCompteSize  TFloatFieldQueryRecupTotal	FieldNameTotal  TFloatFieldQueryRecupQtTotal	FieldNameQtTotal   TQueryQuMAJBalanceN1DatabaseNameExoN1SQL.Strings!delete from ::ExoN1::Balance B_N1where /(B_N1.Debit_Base=0 or B_N1.Debit_Base is null) 5and (B_N1.Credit_Base=0 or B_N1.Credit_Base is null)  LeftTop�   TTableTaMAJBalanceN1DatabaseNameExercice	TableName
Balance.DBLeft�Top�   TQueryQuCalcEquilibreBalanceDatabaseNameExerciceSQL.StringsBselect  sum(Bal.debit_report + bal.debit_Base) as Debit_totalCpt, �sum(Bal.credit_report + (bal.Credit_Base)) as Credit_totalCpt,sum((Bal.credit_report + bal.Credit_Base)-(Bal.debit_report + bal.debit_Base))as Resultat1_5from Balance Bal9where ((bal.compte like('1%'))or(bal.compte like('2%'))orJ(bal.compte like('3%'))or(bal.compte like('4%'))or(bal.compte like('5%'))) Left� Top�  TFloatField!QuCalcEquilibreBalanceResultat1_5	FieldNameResultat1_5   TQueryQuDeleteReportN1DatabaseNameExoN1SQL.Strings 	 LeftTop�   TTable
TaBalanceTDatabaseNameExercice	TableNameBalanceTiers.DBLeft� TopL  TTableTaMAJBalanceTiersN1DatabaseNameExercice	TableNameBalanceTiers.DBLeft�Top�   TQueryQuSoldeCompteDatabaseNameExerciceSQL.Strings  LeftpTop    