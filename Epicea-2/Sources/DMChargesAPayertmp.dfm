�
 TDMCHARGEAPAYER 0  TPF0TDMChargeAPayerDMChargeAPayerOnCreateDMChargeAPayerCreate	OnDestroyDMChargeAPayerDestroyLeft� Top� Height�Width TTable
TaChAPayerBeforeInsertTaChAPayerBeforeInsert
BeforeEditTaChAPayerBeforeEdit
BeforePostTaChAPayerBeforePost	AfterPostTaChAPayerAfterPostBeforeDeleteTaChAPayerBeforeDeleteAfterDeleteTaChAPayerAfterDeleteAfterScrollTaChAPayerAfterScrollOnCalcFieldsTaChAPayerCalcFieldsOnDeleteErrorTaChAPayerDeleteErrorOnPostErrorTaChAPayerPostErrorDatabaseNameExercice	IndexNamecpte	TableNameChargeAPayer.dbLeft Top, TIntegerFieldTaChAPayerID	FieldNameID  TStringFieldTaChAPayerCompte	FieldNameCompteSize  TStringFieldTaChAPayerLibelle	FieldNameLibelleSized  TStringFieldTaChAPayerSens	FieldNameSensSize  TFloatFieldTaChAPayerQte	FieldNameQte  TCurrencyFieldTaChAPayerMontantHT	FieldName	MontantHT  
TDateFieldTaChAPayerDateSaisie	FieldName
DateSaisie  
TDateFieldTaChAPayerDateExercice	FieldNameDateExercice  TStringFieldTaChAPayerCompte2	FieldNameCompte2Size  TStringFieldTaChAPayerLibelle2	FieldNameLibelle2Size  TCurrencyFieldTaChAPayerTVA	FieldNameTVA  TDateTimeFieldTaChAPayerDateSysteme	FieldNameDateSysteme  
TDateFieldTaChAPayerDate_Piece	FieldName
Date_Piece  TStringFieldTaChAPayerReference	FieldName	ReferenceSize	  TIntegerFieldTaChAPayerId_Piece	FieldNameId_Piece  TBooleanFieldTaChAPayerReprise	FieldNameReprise
Calculated	   TDataSourceDataChAPayerDataSet
TaChAPayerLeftpTop  TTableTaChAPayer2DatabaseNameExercice	TableNameChargeAPayer.dbLeft Topx TIntegerFieldTaChAPayer2ID	FieldNameID  TStringFieldTaChAPayer2Compte	FieldNameCompteSize  TStringFieldTaChAPayer2Libelle	FieldNameLibelleSized  TStringFieldTaChAPayer2Sens	FieldNameSensSize  TFloatFieldTaChAPayer2Qte	FieldNameQte  TCurrencyFieldTaChAPayer2MontantHT	FieldName	MontantHT  
TDateFieldTaChAPayer2DateSaisie	FieldName
DateSaisie  
TDateFieldTaChAPayer2DateExercice	FieldNameDateExercice  TStringFieldTaChAPayer2Compte2	FieldNameCompte2Size  TStringFieldTaChAPayer2Libelle2	FieldNameLibelle2Size  TCurrencyFieldTaChAPayer2TVA	FieldNameTVA  TDateTimeFieldTaChAPayer2DateSysteme	FieldNameDateSysteme  
TDateFieldTaChAPayer2Date_Piece	FieldName
Date_Piece  TStringFieldTaChAPayer2Reference	FieldName	ReferenceSize	  TIntegerFieldTaChAPayer2Id_Piece	FieldNameId_Piece   TDataSourceDataChAPayer2DataSetTaChAPayer2LeftpTopx  TDataSourceDataChAPayer3DataSetTaChAPayer3LeftTopx  TTableTaChAPayer3BeforeInsertTaChAPayer3BeforeInsert
BeforeEditTaChAPayer3BeforeEdit
BeforePostTaChAPayer3BeforePost	AfterPostTaChAPayer3AfterPostBeforeDeleteTaChAPayer3BeforeDeleteOnPostErrorTaChAPayer3PostErrorDatabaseNameExercice	TableNameChargeAPayer.dbLeftXTopx TIntegerFieldTaChAPayer3ID	FieldNameID  TStringFieldTaChAPayer3Compte	FieldNameCompteSize  TStringFieldTaChAPayer3Libelle	FieldNameLibelleSized  TStringFieldTaChAPayer3Sens	FieldNameSensSize  TFloatFieldTaChAPayer3Qte	FieldNameQte  TCurrencyFieldTaChAPayer3MontantHT	FieldName	MontantHT  
TDateFieldTaChAPayer3DateSaisie	FieldName
DateSaisie  
TDateFieldTaChAPayer3DateExercice	FieldNameDateExercice  TStringFieldTaChAPayer3Compte2	FieldNameCompte2Size  TStringFieldTaChAPayer3Libelle2	FieldNameLibelle2Size  TCurrencyFieldTaChAPayer3TVA	FieldNameTVA  TDateTimeFieldTaChAPayer3DateSysteme	FieldNameDateSysteme  
TDateFieldTaChAPayer3Date_Piece	FieldName
Date_Piece  TStringFieldTaChAPayer3Reference	FieldName	ReferenceSize	  TIntegerFieldTaChAPayer3Id_Piece	FieldNameId_Piece   TQueryQueryDesignationDatabaseNameExerciceSQL.StringsSelect ChargeAPayer.Id as Id, +           ChargeAPayer.Compte2 as Compte2,0           ChargeAPayer.Libelle2 as Designation,$           ChargeAPayer.Sens as SensFrom ChargeAPayer5Where Upper(ChargeAPayer.Libelle2) Like Upper((:mot)):            And Upper(ChargeAPayer.Sens) Like Upper((:Ss))%            And DateSaisie = (:dat)  Order by ChargeAPayer.Compte2; Params.Data
)     mot  0   Ss  0   dat 	 Z�
   Left� Top�  TIntegerFieldQueryDesignationId	FieldNameIdOrigin"ChargeAPayer.DB".ID  TStringFieldQueryDesignationCompte2	FieldNameCompte2Origin"ChargeAPayer.DB".Compte2Size  TStringFieldQueryDesignationDesignation	FieldNameDesignationOrigin"ChargeAPayer.DB".Libelle2Size  TStringFieldQueryDesignationSens	FieldNameSensOrigin"ChargeAPayer.DB".SensSize   TDataSourceDataDesignationDataSetQueryDesignationLeft Top�   TTableTaRechercheChAPayerDatabaseNameExercice	TableNameChargeAPayer.dbLeft0Top�   TTableTaChAPayerEcritureReferenceDatabaseNameExercice	TableNameChargeAPayer.dbLeft�Top   