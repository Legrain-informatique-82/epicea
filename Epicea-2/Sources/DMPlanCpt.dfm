�
 TDMPLAN 0�J  TPF0TDMPlanDMPlanOldCreateOrder	OnCreateDMPlanCreate	OnDestroyDMPlanDestroyLeftbTop�Height.Width TTable
TaEcritureDatabaseNameDossierReadOnly		TableNameEcriture.DBLeft� Top  TTable
TaPlanCpteDatabaseNameProgramConstraintsFromDictionary  ReadOnly		TableNamePlanCPTE.dbLeft$Top  TDataSource
DaPlanCpteDataSet
TaPlanCpteLeftlTop  TTable
TaParamCptDatabaseNameProgramReadOnly		TableNameParamCpt.DBLeft$TopL  TDataSource
DaParamCptDataSet
TaParamCptLeftlTopL  TTable	TaPlanCpt	AfterOpenTaPlanCptAfterOpenBeforeInsertTaPlanCptBeforeInsertAfterInsertTaPlanCptAfterInsert
BeforeEditTaPlanCptBeforeEdit	AfterEditTaPlanCptAfterEdit
BeforePostTaPlanCptBeforePost	AfterPostTaPlanCptAfterPostBeforeCancelTaPlanCptBeforeCancelBeforeDeleteTaPlanCptBeforeDeleteAfterDeleteTaPlanCptAfterDeleteDatabaseNameDossierFiltered		TableName
PlanCpt.DBLeft$Top�   TDataSource	DaPlanCptDataSet	TaPlanCptLeftlTop�   TTableTaParamCptAideCptDatabaseNameProgram	TableNameParamCpt.DBLeft� Top�   TDataSourceDaParamCptAideCptDataSetTaParamCptAideCptLeft� TopL  TTableTaCompteDatabaseNameDossier	TableName
PlanCpt.DBLeft� Top  TDataSourceDaCompteDataSetTaCompteLeftTopL  TTableTaPlanBO
BeforeOpenTaPlanBOBeforeOpen	AfterOpenTaPlanBOAfterOpen
AfterCloseTaPlanBOAfterCloseBeforeInsertTaPlanBOBeforeInsert
BeforeEditTaPlanBOBeforeEdit
BeforePostTaPlanBOBeforePost	AfterPostTaPlanBOAfterPostBeforeDeleteTaPlanCptBeforeDeleteAfterDeleteTaPlanBOAfterDeleteOnCalcFieldsTaPlanBOCalcFieldsDatabaseNameDossier	TableName
PlanCpt.DBLeft(Top�  TStringFieldTaPlanBOCompte	FieldNameCompteReadOnly	Size  TStringFieldTaPlanBOLibelle	FieldNameLibelleReadOnly	Sized  TFloatFieldTaPlanBODebit_Deb	FieldName	Debit_Debcurrency	  TFloatFieldTaPlanBOCredit_Deb	FieldName
Credit_Debcurrency	  TFloatFieldTaPlanBOQt1_Deb	FieldNameQt1_Deb  TFloatFieldTaPlanBOQt2_Deb	FieldNameQt2_Deb  TBooleanFieldTaPlanBOOuverture	FieldKindfkCalculated	FieldName	Ouverture
Calculated	  TCurrencyFieldTaPlanBODebit_Deb_Calc	FieldKindfkCalculated	FieldNameDebit_Deb_Calc
Calculated	  TCurrencyFieldTaPlanBOCredit_Deb_Calc	FieldKindfkCalculated	FieldNameCredit_Deb_Calc
Calculated	  TStringFieldTaPlanBOUn1	FieldNameUn1Size  TStringFieldTaPlanBOUn2	FieldNameUn2Size  TBooleanFieldTaPlanBOPlanSaisie	FieldName
PlanSaisie  TStringFieldTaPlanBOTvaCode	FieldNameTvaCodeSize  TStringFieldTaPlanBOTvaType	FieldNameTvaTypeSize  TBooleanFieldTaPlanBOTvaDebit	FieldNameTvaDebit  TBooleanFieldTaPlanBOSensCredit	FieldName
SensCredit  TBooleanFieldTaPlanBOCollectif	FieldName	Collectif  TBooleanFieldTaPlanBOCentraliser	FieldNameCentraliser  TBooleanFieldTaPlanBOTiers	FieldNameTiers  TBooleanFieldTaPlanBORapprochement	FieldNameRapprochement  TBooleanFieldTaPlanBOImmobilisation	FieldNameImmobilisation  TBooleanFieldTaPlanBOImmoAmort	FieldName	ImmoAmort  TBooleanFieldTaPlanBOImmoDegressif	FieldNameImmoDegressif  TBooleanFieldTaPlanBOEmprunt	FieldNameEmprunt  TBooleanFieldTaPlanBOAbandonne	FieldName	Abandonne  TStringFieldTaPlanBOQui	FieldNameQuiSize
  TDateTimeFieldTaPlanBOQuand	FieldNameQuand  TIntegerFieldTaPlanBOID_Affichage	FieldNameID_Affichage  TStringFieldTaPlanBOJBanque	FieldNameJBanqueSize  TBooleanFieldTaPlanBOpointable	FieldName	pointable  TFloatFieldTaPlanBOTaux	FieldNameTaux  TStringFieldTaPlanBODiv	FieldNameDivSize�    TDataSourceDaPlanBODataSetTaPlanBOLeftxTop�   TQueryQuCompteUtiliseOuvClot
BeforeOpen QuCompteUtiliseOuvClotBeforeOpen	AfterOpenQuCompteUtiliseOuvClotAfterOpenDatabaseNameDossierFiltered	SQL.Stringsselect distinct P.compte from	PlanCpt PwhereP.Pointable='true'or P.Immobilisation = 'true'+or P.Compte in (select Compte from TvaCode)or P.Compte like('28%')or P.Compte like('139%')or P.Compte like('44586')or P.Compte like('44587') Left�Top  TDataSourceDaCompteGenereDataSetTaCompteGenerLeft�TopL  TTableTaCompteGenerDatabaseNameDossier	TableName
PlanCpt.DBLeft�Top�  TStringFieldTaCompteGenerCompte	FieldNameCompteSize  TStringFieldTaCompteGenerLibelle	FieldNameLibelleSized  TFloatFieldTaCompteGenerDebit_Deb	FieldName	Debit_Deb  TFloatFieldTaCompteGenerCredit_Deb	FieldName
Credit_Deb  TStringFieldTaCompteGenerUn1	FieldNameUn1Size  TStringFieldTaCompteGenerUn2	FieldNameUn2Size  TFloatFieldTaCompteGenerQt1_Deb	FieldNameQt1_Deb  TFloatFieldTaCompteGenerQt2_Deb	FieldNameQt2_Deb  TBooleanFieldTaCompteGenerPlanSaisie	FieldName
PlanSaisie  TStringFieldTaCompteGenerTvaCode	FieldNameTvaCodeSize  TStringFieldTaCompteGenerTvaType	FieldNameTvaTypeSize  TBooleanFieldTaCompteGenerTvaDebit	FieldNameTvaDebit  TBooleanFieldTaCompteGenerSensCredit	FieldName
SensCredit  TBooleanFieldTaCompteGenerCollectif	FieldName	Collectif  TBooleanFieldTaCompteGenerCentraliser	FieldNameCentraliser  TBooleanFieldTaCompteGenerTiers	FieldNameTiers  TBooleanFieldTaCompteGenerRapprochement	FieldNameRapprochement  TBooleanFieldTaCompteGenerImmobilisation	FieldNameImmobilisation  TBooleanFieldTaCompteGenerImmoAmort	FieldName	ImmoAmort  TBooleanFieldTaCompteGenerImmoDegressif	FieldNameImmoDegressif  TBooleanFieldTaCompteGenerEmprunt	FieldNameEmprunt  TBooleanFieldTaCompteGenerAbandonne	FieldName	Abandonne  TStringFieldTaCompteGenerQui	FieldNameQuiSize
  TDateTimeFieldTaCompteGenerQuand	FieldNameQuand  TIntegerFieldTaCompteGenerID_Affichage	FieldNameID_Affichage  TStringFieldTaCompteGenerJBanque	FieldNameJBanqueSize  TBooleanFieldTaCompteGenerPointable	FieldName	Pointable  TFloatFieldTaCompteGenerTaux	FieldNameTaux  TStringFieldTaCompteGenerDiv	FieldNameDivSize�    TTableTaPlanCptTrans1DatabaseNameDossierFiltered		TableName
PlanCpt.DBLeft,Top  TTableTaPlanCptTrans2DatabaseNameDossierFiltered		TableName
PlanCpt.DBLeft|Top  TDataSourceDaPlanCptTrans1DataSetTaPlanCptTrans1Left�Top  TDataSourceDaPlanCptTrans2DataSetTaPlanCptTrans2Left�Top  TQueryQuMAJBalAutoBalManuDatabaseNameExerciceSQL.Stringsupdate ::dossier::planCpt PlZ	set Pl.Debit_deb = (select Bal.Debit_report from Balance Bal where pl.compte=Bal.compte),W	Pl.Credit_deb = (select Bal.Credit_report from Balance Bal where pl.compte=Bal.compte):where Pl.compte in (select Bal.compte from balance.db Bal)7           and pl.Debit_deb <> 0 and Pl.Credit_deb <> 0  Left4Top  TQueryQuPrepareMAJBalManuBalAuto
BeforeOpen$QuPrepareMAJBalManuBalAutoBeforeOpenDatabaseNameDossierFiltered	OnFilterRecord&QuPrepareMAJBalManuBalAutoFilterRecordSQL.Strings-select pl.compte, pl.Debit_Deb, pl.credit_debfrom
PlanCpt pl,where (pl.debit_deb > 0 or pl.credit_deb >0),and substring(pl.compte from 1 for 1) <> '6'and(substring(pl.compte from 1 for 1) <> '7' Left@Top�   TTableTaBalanceUpdateDatabaseNameExercice	TableName
Balance.DBLeft� Top  TTableTaPlanUpdateDatabaseNameDossierFilter
compte < 6Filtered		TableName
PlanCpt.DBLeft<Top  TQueryQuMAJBalManuBlAutoDatabaseNameExerciceSQL.StringsEINSERT INTO Balance (compte,Debit_Report,Credit_Report, Debit_Base,  }                    Credit_Base, Debit_Total, Credit_Total, Qt1_Report, Qt2_Report, Qt1_Base, Qt2_Base, Qt1_Total, Qt2_Total)2values(:cpte,:Debit_Rep,:Credit_Rep, :Debit_Bas,  M                    :Credit_Bas, :Debit_Tot, :Credit_Tot, :Qt1_Rep, :Qt2_Rep,<                    :Qt1_Bas, :Qt2_Bas, :Qt1_Tot, :Qt2_Tot); Left@TopL	ParamDataDataTypeftStringNamecpte	ParamType	ptUnknown DataType
ftCurrencyName	Debit_Rep	ParamType	ptUnknown DataType
ftCurrencyName
Credit_Rep	ParamType	ptUnknown DataType
ftCurrencyName	Debit_Bas	ParamType	ptUnknown DataType
ftCurrencyName
Credit_Bas	ParamType	ptUnknown DataType
ftCurrencyName	Debit_Tot	ParamType	ptUnknown DataType
ftCurrencyName
Credit_Tot	ParamType	ptUnknown DataType
ftCurrencyNameQt1_Rep	ParamType	ptUnknown DataType
ftCurrencyNameQt2_Rep	ParamType	ptUnknown DataType
ftCurrencyNameQt1_Bas	ParamType	ptUnknown DataType
ftCurrencyNameQt2_Bas	ParamType	ptUnknown DataType
ftCurrencyNameQt1_Tot	ParamType	ptUnknown DataType
ftCurrencyNameQt2_Tot	ParamType	ptUnknown    TQuery
QuCptAmortDatabaseNameProgramSQL.Stringsselect Rac1 from ParamCpt whereFamille = :Famiand Regime = :Regi,and (Rac2 like (:CptGenere) or (Rac2='139')) Left�Top� 	ParamDataDataType	ftIntegerNameFami	ParamType	ptUnknown DataTypeftStringNameRegi	ParamType	ptUnknown DataTypeftStringName	CptGenere	ParamType	ptUnknown    TTable
TaCptImmosBeforeInsertTaCptImmosBeforeInsert
BeforeEditTaCptImmosBeforeEdit	AfterEditTaCptImmosAfterEdit
BeforePostTaCptImmosBeforePostBeforeDeleteTaPlanCptBeforeDeleteDatabaseNameDossierFilterImmobilisation=VraiFiltered		TableName
PlanCpt.DBLefthTop�  TStringFieldTaCptImmosCompte	FieldNameCompteSize  TStringFieldTaCptImmosLibelle	FieldNameLibelleSized  TFloatFieldTaCptImmosDebit_Deb	FieldName	Debit_Deb  TFloatFieldTaCptImmosCredit_Deb	FieldName
Credit_Deb  TStringFieldTaCptImmosUn1	FieldNameUn1Size  TStringFieldTaCptImmosUn2	FieldNameUn2Size  TFloatFieldTaCptImmosQt1_Deb	FieldNameQt1_Deb  TFloatFieldTaCptImmosQt2_Deb	FieldNameQt2_Deb  TBooleanFieldTaCptImmosPlanSaisie	FieldName
PlanSaisie  TStringFieldTaCptImmosTvaCode	FieldNameTvaCodeSize  TStringFieldTaCptImmosTvaType	FieldNameTvaTypeSize  TBooleanFieldTaCptImmosTvaDebit	FieldNameTvaDebit  TBooleanFieldTaCptImmosSensCredit	FieldName
SensCredit  TBooleanFieldTaCptImmosCollectif	FieldName	Collectif  TBooleanFieldTaCptImmosCentraliser	FieldNameCentraliser  TBooleanFieldTaCptImmosTiers	FieldNameTiers  TBooleanFieldTaCptImmosRapprochement	FieldNameRapprochement  TBooleanFieldTaCptImmosImmobilisation	FieldNameImmobilisation  TBooleanFieldTaCptImmosImmoAmort	FieldName	ImmoAmort  TBooleanFieldTaCptImmosImmoDegressif	FieldNameImmoDegressif  TBooleanFieldTaCptImmosEmprunt	FieldNameEmprunt  TBooleanFieldTaCptImmosAbandonne	FieldName	Abandonne  TStringFieldTaCptImmosQui	FieldNameQuiSize
  TDateTimeFieldTaCptImmosQuand	FieldNameQuand  TIntegerFieldTaCptImmosID_Affichage	FieldNameID_Affichage  TStringFieldTaCptImmosJBanque	FieldNameJBanqueSize  TStringFieldTaCptImmosNumImmo	FieldKindfkCalculated	FieldNameNumImmoSize2
Calculated	  TBooleanFieldTaCptImmospointable	FieldName	pointable   TDataSource
DaCptImmosDataSet
TaCptImmosLeft�Top�   TTableTaPlanMaintDatabaseNameDossier	TableName
plancpt.DBLeft(Top�   TTableTaCompteListeUtilDatabaseNameDossierFiltered	OnFilterRecordTaCompteListeUtilFilterRecord	TableName
PlanCpt.DBLeft8Top  TDataSourceDaCompteListeUtilDataSetTaCompteListeUtilLeft`TopL  TTableTaPlanBOCalcOnCalcFieldsTaPlanBOCalcCalcFieldsDatabaseNameDossier	TableName
plancpt.DBLeftTop�  TStringFieldTaPlanBOCalcCompte	FieldNameCompteSize  TStringFieldTaPlanBOCalcLibelle	FieldNameLibelleSized  TFloatFieldTaPlanBOCalcDebit_Deb	FieldName	Debit_Deb  TFloatFieldTaPlanBOCalcCredit_Deb	FieldName
Credit_Deb  TBooleanFieldTaPlanBOCalcOuverture	FieldKindfkCalculated	FieldName	Ouverture
Calculated	  TCurrencyFieldTaPlanBOCalcDebit_Deb_Calc	FieldKindfkCalculated	FieldNameDebit_Deb_Calc
Calculated	  TCurrencyFieldTaPlanBOCalcCredit_Deb_Calc	FieldKindfkCalculated	FieldNameCredit_Deb_Calc
Calculated	   TTableTaPlanMaintSDatabaseNameDossier	TableName
plancpt.DBLeftlTop�   TTableTabilanDatabaseNameProgram	TableName	PBilan.DBLeft� Top�   TQueryQuPlanCptEditionDatabaseNameDossierLeft Top�  TQueryQuGrandLivreCgEditionOnCalcFieldsQuGrandLivreCgEditionCalcFieldsDatabaseNameDossierLeft� Top� TIntegerFieldQuGrandLivreCgEditionID	FieldNameIDOriginEDITION2."EcritureTriees.DB".ID  TIntegerFieldQuGrandLivreCgEditionID_Piece	FieldNameID_PieceOrigin%EDITION2."EcritureTriees.DB".ID_Piece  TStringFieldQuGrandLivreCgEditionContreP	FieldKindfkCalculated	FieldNameContreP
Calculated	  TStringFieldQuGrandLivreCgEditionTypeLigne	FieldName	TypeLigneOrigin&EDITION2."EcritureTriees.DB".TypeLigneSize  TSmallintFieldQuGrandLivreCgEditionID_Ligne	FieldNameID_LigneOrigin%EDITION2."EcritureTriees.DB".ID_Ligne  
TDateFieldQuGrandLivreCgEditionDate	FieldNameDateOrigin!EDITION2."EcritureTriees.DB".Date  TStringFieldQuGrandLivreCgEditionCompte	FieldNameCompteOrigin#EDITION2."EcritureTriees.DB".CompteSize  TStringFieldQuGrandLivreCgEditionTiers	FieldNameTiersOrigin"EDITION2."EcritureTriees.DB".TiersSize  TStringFieldQuGrandLivreCgEditionLibelle	FieldNameLibelleOrigin$EDITION2."EcritureTriees.DB".LibelleSized  TFloatFieldQuGrandLivreCgEditionQt1	FieldNameQt1Origin EDITION2."EcritureTriees.DB".Qt1  TFloatFieldQuGrandLivreCgEditionQt2	FieldNameQt2Origin EDITION2."EcritureTriees.DB".Qt2  TCurrencyField QuGrandLivreCgEditionDebitSaisie	FieldNameDebitSaisieOrigin(EDITION2."EcritureTriees.DB".DebitSaisie  TCurrencyField!QuGrandLivreCgEditionCreditSaisie	FieldNameCreditSaisieOrigin)EDITION2."EcritureTriees.DB".CreditSaisie  TIntegerFieldQuGrandLivreCgEditionID_Devise	FieldName	ID_DeviseOrigin&EDITION2."EcritureTriees.DB".ID_Devise  TCurrencyFieldQuGrandLivreCgEditionDebit	FieldNameDebitOrigin"EDITION2."EcritureTriees.DB".Debit  TCurrencyFieldQuGrandLivreCgEditionCredit	FieldNameCreditOrigin#EDITION2."EcritureTriees.DB".Credit  TStringFieldQuGrandLivreCgEditionTvaCode	FieldNameTvaCodeOrigin$EDITION2."EcritureTriees.DB".TvaCodeSize  TStringFieldQuGrandLivreCgEditionTvaType	FieldNameTvaTypeOrigin$EDITION2."EcritureTriees.DB".TvaTypeSize  TFloatFieldQuGrandLivreCgEditionTvaTaux	FieldNameTvaTauxOrigin$EDITION2."EcritureTriees.DB".TvaTaux  
TDateFieldQuGrandLivreCgEditionTvaDate	FieldNameTvaDateOrigin$EDITION2."EcritureTriees.DB".TvaDate  TStringField"QuGrandLivreCgEditionRapprochement	FieldNameRapprochementOrigin*EDITION2."EcritureTriees.DB".RapprochementSize  
TDateFieldQuGrandLivreCgEditionValidation	FieldName
ValidationOrigin'EDITION2."EcritureTriees.DB".Validation  TStringFieldQuGrandLivreCgEditionQui	FieldNameQuiOrigin EDITION2."EcritureTriees.DB".QuiSize
  TDateTimeFieldQuGrandLivreCgEditionQuand	FieldNameQuandOrigin"EDITION2."EcritureTriees.DB".Quand  TStringFieldQuGrandLivreCgEditionNum_Cheque	FieldName
Num_ChequeOrigin'EDITION2."EcritureTriees.DB".Num_ChequeSize2  TStringFieldQuGrandLivreCgEditionTable_Gen	FieldName	Table_GenOrigin&EDITION2."EcritureTriees.DB".Table_GenSize2  TStringFieldQuGrandLivreCgEditionChamp_Gen	FieldName	Champ_GenOrigin&EDITION2."EcritureTriees.DB".Champ_GenSize2  TStringField"QuGrandLivreCgEditionVal_Champ_Gen	FieldNameVal_Champ_GenOrigin*EDITION2."EcritureTriees.DB".Val_Champ_GenSized  TFloatFieldQuGrandLivreCgEditionID_GESTCO	FieldName	ID_GESTCOOrigin&EDITION2."EcritureTriees.DB".ID_GESTCO  TStringField QuGrandLivreCgEditionCODE_GESTCO	FieldNameCODE_GESTCOOrigin(EDITION2."EcritureTriees.DB".CODE_GESTCOSize2  TCurrencyField QuGrandLivreCgEditionMontant_Tva	FieldNameMontant_TvaOrigin(EDITION2."EcritureTriees.DB".Montant_Tva  TIntegerField QuGrandLivreCgEditionID_GESTANAL	FieldNameID_GESTANALOrigin(EDITION2."EcritureTriees.DB".ID_GESTANAL  TStringField"QuGrandLivreCgEditionCODE_GESTANAL	FieldNameCODE_GESTANALOrigin*EDITION2."EcritureTriees.DB".CODE_GESTANALSize2  TIntegerFieldQuGrandLivreCgEditionID_1	FieldNameID_1OriginEDITION2."ecrituretriees.DB".ID  TIntegerFieldQuGrandLivreCgEditionJournal	FieldNameJournalOriginEDITION2."ecrituretriees.DB".ID  TStringFieldQuGrandLivreCgEditionReference	FieldName	ReferenceOriginEDITION2."ecrituretriees.DB".IDSize	  
TDateFieldQuGrandLivreCgEditionDate_1	FieldNameDate_1OriginEDITION2."ecrituretriees.DB".ID  TStringFieldQuGrandLivreCgEditionLibelle_1	FieldName	Libelle_1OriginEDITION2."ecrituretriees.DB".IDSized  TSmallintFieldQuGrandLivreCgEditionTypePiece	FieldName	TypePieceOriginEDITION2."ecrituretriees.DB".ID  TStringFieldQuGrandLivreCgEditionCompte_1	FieldNameCompte_1OriginEDITION2."ecrituretriees.DB".IDSize  TIntegerField QuGrandLivreCgEditionID_Devise_1	FieldNameID_Devise_1OriginEDITION2."ecrituretriees.DB".ID  
TDateField!QuGrandLivreCgEditionValidation_1	FieldNameValidation_1OriginEDITION2."ecrituretriees.DB".ID  TStringFieldQuGrandLivreCgEditionQui_1	FieldNameQui_1OriginEDITION2."ecrituretriees.DB".IDSize
  TDateTimeFieldQuGrandLivreCgEditionQuand_1	FieldNameQuand_1OriginEDITION2."ecrituretriees.DB".ID  TStringField!QuGrandLivreCgEditionNum_Cheque_1	FieldNameNum_Cheque_1OriginEDITION2."ecrituretriees.DB".IDSize2  TFloatField QuGrandLivreCgEditionID_GESTCO_1	FieldNameID_GESTCO_1OriginEDITION2."ecrituretriees.DB".ID  TStringField"QuGrandLivreCgEditionCODE_GESTCO_1	FieldNameCODE_GESTCO_1OriginEDITION2."ecrituretriees.DB".IDSize2  TStringField QuGrandLivreCgEditionTable_Gen_1	FieldNameTable_Gen_1OriginEDITION2."ecrituretriees.DB".IDSize2  TStringField QuGrandLivreCgEditionChamp_Gen_1	FieldNameChamp_Gen_1OriginEDITION2."ecrituretriees.DB".IDSize2  TStringField$QuGrandLivreCgEditionVal_Champ_Gen_1	FieldNameVal_Champ_Gen_1OriginEDITION2."ecrituretriees.DB".IDSized  TCurrencyFieldQuGrandLivreCgEditionprix	FieldKindfkCalculated	FieldNameprix
Calculated	  TStringField#QuGrandLivreCgEditionReferencePiece	FieldKindfkCalculated	FieldNameReferencePiece
Calculated	   TQueryQuListeValRuptDatabaseNameDossierSQL.Strings  Left� Top�  TQueryQuSousTotal1DatabaseNameDossierLeft�Top�  TQueryQuTotalGDatabaseNameDossierSQL.Strings  Left`Top�  TQueryQuSousTotal3DatabaseNameDossierLeft`Top�  TQueryQuSousTotal2DatabaseNameDossierSQL.Strings  LeftTop�  TQueryQuReportDatabaseNameDossierLeftTop�  TQueryQuBalanceEditionDatabaseNameExerciceSQL.Stringsselect * from balance Left� Top� TStringFieldQuBalanceEditionCompte	FieldNameCompteOriginEXERCICE."balance.DB".CompteSize  TFloatFieldQuBalanceEditionDebit_Report	FieldNameDebit_ReportOrigin"EXERCICE."balance.DB".Debit_Report  TFloatFieldQuBalanceEditionCredit_Report	FieldNameCredit_ReportOrigin#EXERCICE."balance.DB".Credit_Report  TCurrencyFieldQuBalanceEditionReportDebit	FieldKindfkCalculated	FieldNameReportDebit
Calculated	  TCurrencyFieldQuBalanceEditionReportCredit	FieldKindfkCalculated	FieldNameReportCredit
Calculated	   TQuery	QuPlanCptDatabaseNameDossierLeft0Toph   