�
 TDMLIASSEFISC 0  TPF0TDMLiasseFiscDMLiasseFiscOldCreateOrder	OnCreateDMLiasseFiscCreate	OnDestroyDMLiasseFiscDestroyLeftaTopHeight� Width� TQueryQuPBilanDatabaseNameProgramSQL.Stringsselect * from PBilan where!  (( SoldeReport = :NomZoneLiasse$or SoldeReportDebit = :NomZoneLiasse%or SoldeReportCredit = :NomZoneLiasse"or SoldeMouvement = :NomZoneLiasse'or SoldeMouvementDebit = :NomZoneLiasse(or SoldeMouvementCredit = :NomZoneLiasseor SoldeFin = :NomZoneLiasse!or SoldeFinDebit = :NomZoneLiasse#or SoldeFinCredit = :NomZoneLiasse)and (Regime = 'I')) Left�Top	ParamDataDataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown DataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown DataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown DataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown DataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown DataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown DataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown DataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown DataTypeftStringNameNomZoneLiasse	ParamType	ptUnknown   TStringFieldQuPBilancompte	FieldNamecompteOrigin"balance.DB".CompteSize   TTableTaPBilanDatabaseNameProgramIndexFieldNamesCompte	TableName	PBilan.DBLeftXTop  TDataSource
DaQuPBilanDataSetQuPBilanLeft�TopP  TQuery
QuParamLiaDatabaseNameProgramSQL.Stringsselect * from ParamLiawhere type =:TypeDocLiasseorder by ID_Ligne Left�Top	ParamDataDataTypeftStringNameTypeDocLiasse	ParamType	ptUnknown    TTableTaBalanceCptPourZoneBilanBeforeInsert%TaBalanceCptPourZoneBilanBeforeInsert
BeforeEdit#TaBalanceCptPourZoneBilanBeforeEditOnCalcFields#TaBalanceCptPourZoneBilanCalcFieldsDatabaseNameExerciceFiltered		TableName
Balance.DBLeft<Top TStringFieldTaBalanceCptPourZoneBilanCompte	FieldNameCompteSize  TStringField TaBalanceCptPourZoneBilanLibelle	FieldKindfkLookup	FieldNameLibelleLookupDataSet	TaPlanCptLookupKeyFieldsCompteLookupResultFieldLibelle	KeyFieldsCompteLookup	  TCurrencyField&TaBalanceCptPourZoneBilanSoldeFinDebit	FieldKindfkCalculated	FieldNameSoldeFinDebit
Calculated	  TCurrencyField'TaBalanceCptPourZoneBilanSoldeFinCredit	FieldKindfkCalculated	FieldNameSoldeFinCredit
Calculated	   TDataSourceDaBalanceCptPourZoneBilanDataSetTaBalanceCptPourZoneBilanLeft<TopH  TTable	TaPlanCptDatabaseNamedossierMasterSourceDaBalanceCptPourZoneBilan	TableName
plancpt.DBLeft� Top  TDataSource	DaPlanCptDataSet	TaPlanCptLeft� TopH  TTableTaPBilan_BicDatabaseNameProgramIndexFieldNamesCompte	TableNamePBilan_Bic.DBLeft�Top`  TTabletaPBilanOuvertureDatabaseNameProgram	TableNamePBilanOuverture.DBLeft Topp   