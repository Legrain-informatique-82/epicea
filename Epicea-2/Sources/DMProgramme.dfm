�
 TDMPROG 0  TPF0TDMProgDMProgOldCreateOrder	OnCreateDMProgCreate	OnDestroyDataModuleDestroyLeft\Top�HeightWidth� TTable	TaGestDosDatabaseNameProgramMasterFields
Id_DossierMasterSource	daGestDosReadOnly		TableNameGestDossier.DBLeft� Topp TIntegerFieldTaGestDosID_Dossier	FieldName
ID_Dossier  TIntegerFieldTaGestDosID_Table	FieldNameID_Table  TStringFieldTaGestDosNom_Dossier	FieldNameNom_DossierReadOnly	Size�   TStringFieldTaGestDosDir_Dossier	FieldNameDir_DossierSize�   TStringFieldTaGestDosNom_Exo	FieldNameNom_ExoSize�   TStringFieldTaGestDosDir_Exo	FieldNameDir_ExoSize�   TDateTimeFieldTaGestDosAnnee_Dossier	FieldNameAnnee_Dossier  TDateTimeFieldTaGestDosDateUtil	FieldNameDateUtil  TBooleanFieldTaGestDosCloture	FieldNameCloture  TStringFieldTaGestDosEXO_BASE	FieldNameEXO_BASESize  TStringFieldTaGestDosEXO_SAISIE	FieldName
EXO_SAISIESize  
TDateFieldTaGestDosDATE_DEB_EXO	FieldNameDATE_DEB_EXO  
TDateFieldTaGestDosDATE_FIN_EXO	FieldNameDATE_FIN_EXO  TStringFieldTaGestDosDESIGNATION_DOSSIER	FieldNameDESIGNATION_DOSSIERSized   TQueryQuery1DatabaseNameProgramSQL.StringsVselect Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIERlfrom GestDossier.db group by Id_Dossier,Nom_Dossier,ID_Table,Nom_Exo,Dir_Dossier,Dir_Exo,DESIGNATION_DOSSIERorder by Nom_Dossier; Left�Topp  TTableTaGestDossierConsultDatabaseNameProgram	TableNameGestDossier.DBLeft4Top  TDataSourceDaGestDossierConsultDataSetTaGestDossierConsultLeft(Topx  TDataSourceDataSource1DataSet	TaGestDosLeft Topp  TTableTaGestDosModif
BeforePostTaGestDosModifBeforePost	AfterPostTaGestDosModifAfterPostDatabaseNameProgram	TableNameGestDossier.DBLeft� Top  TDataSourceDataSource2DataSet	TaGestDosLeft$Top$  TDataSource	daGestDosDataSetQuery1LeftPTopp  TQueryQuGestDossierMenu
BeforeOpenQuGestDossierMenuBeforeOpen
AfterCloseQuGestDossierMenuAfterCloseDatabaseNameProgramFiltered	OnFilterRecordQuGestDossierMenuFilterRecordSQL.Strings3select ID_Dossier,ID_Table,Nom_Dossier,Dir_Dossier,6       Nom_Exo,Dir_Exo,Annee_Dossier,DateUtil,Cloture,4       EXO_BASE,EXO_SAISIE,DATE_DEB_EXO,DATE_FIN_EXO  from GestDossier where cloture = falseorder by DateUtil desc Left�Top   TQueryQuGEstDossierDatabaseNameProgramLeft Topp  TTable
TaGDossierDatabaseNameDossier	TableNameGDossier.DBLeft8Top�  TIntegerFieldTaGDossierID_Dossier	FieldName
ID_Dossier  TIntegerFieldTaGDossierID_Table	FieldNameID_Table  TStringFieldTaGDossierNom_Dossier	FieldNameNom_DossierSize�   TStringFieldTaGDossierDir_Dossier	FieldNameDir_DossierSize�   TStringFieldTaGDossierNom_Exo	FieldNameNom_ExoSize�   TStringFieldTaGDossierDir_Exo	FieldNameDir_ExoSize�   TDateTimeFieldTaGDossierAnnee_Dossier	FieldNameAnnee_Dossier  TDateTimeFieldTaGDossierDateUtil	FieldNameDateUtil  TBooleanFieldTaGDossierCloture	FieldNameCloture  TStringFieldTaGDossierEXO_BASE	FieldNameEXO_BASESize  TStringFieldTaGDossierEXO_SAISIE	FieldName
EXO_SAISIESize  
TDateFieldTaGDossierDATE_DEB_EXO	FieldNameDATE_DEB_EXO  
TDateFieldTaGDossierDATE_FIN_EXO	FieldNameDATE_FIN_EXO  TStringFieldTaGDossierDESIGNATION_DOSSIER	FieldNameDESIGNATION_DOSSIERSized   TQueryQuGestDossierMenuDossierDatabaseNameProgramSQL.Strings(select  max(DateUtil) DateU, Nom_Dossier from GestDossier group by  Nom_Dossierorder by DateU desc Left� Top�   TQueryQuGestDossierMenuExerciceDatabaseNameProgramSQL.Stringsselect        ID_Table,       Nom_Dossier,       Dir_Dossier,       Nom_Exo,       DATE_DEB_EXO from GestDossier where cloture = false%order by Nom_Dossier,Date_Deb_Exo asc Left�Top�    