�
 TE2_REGMNTLISTE 0�  TPF0TE2_RegmntListeE2_RegmntListeLeftTop� Width�Height�CaptionR�glements sur listeFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight TDBGridDBGrid1Left|Top� Width� Height� ColorclWhite
DataSource
DaPointageFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicator
dgRowLinesdgRowSelectdgConfirmDeletedgCancelOnExitdgMultiSelect 
ParentFontTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.StylefsBold 
OnKeyPressDBGrid1KeyPressColumns	AlignmenttaCenter	FieldName	Id_CreditTitle.AlignmenttaCenter 	AlignmenttaCenterButtonStylecbsNone	FieldNameSUM OF MontantTitle.AlignmenttaCenterTitle.CaptionCompte    TDBComboBoxDBComboBox1Left0Top�WidthaHeightStylecsDropDownList	DataFieldCompte
DataSourceDataCompteBanc
ItemHeightReadOnly	Sorted	TabOrder  TPanelPanel1LeftTopWidth�Height)TabOrder TSpeedButtonSpeedButton1LeftTopWidth� Height
GroupIndexDown	CaptionDettesOnClickSpeedButton1Click  TSpeedButtonSpeedButton2TagLeftTopWidth� Height
GroupIndexCaptionCr�ancesOnClickSpeedButton2Click   TButtonButton1LeftHTopWidthKHeight)CaptionButton1TabOrder  TEditEdTotalLeft�Top�WidthyHeightTabOrder  TListBoxListeCompteLeft(Top$Width� Height[CursorcrHandPointBorderStylebsNoneColorclAquaIntegralHeight	
ItemHeightTabOrderOnClickListeCompteClickOnMouseMoveListeCompteMouseMove  	TCheckBox	CheckBox1Left� Top�WidthaHeightCaption	CheckBox1TabOrder  TTable
TaEcritureFilterTypeLigne='X' and Credit <>'0'Filtered	DatabaseNameExerciceIndexFieldNamesID_Piece;TypeLigne;ID_Ligne	TableNameEcriture.DBLeft�Top� TIntegerFieldTaEcritureID	FieldNameID  TIntegerFieldTaEcritureID_Piece	FieldNameID_Piece  TStringFieldTaEcritureTypeLigne	FieldName	TypeLigneSize  TSmallintFieldTaEcritureID_Ligne	FieldNameID_Ligne  
TDateFieldTaEcritureDate	FieldNameDate  TStringFieldTaEcritureCompte	FieldNameCompteSize  TStringFieldTaEcritureTiers	FieldNameTiersSize  TStringFieldTaEcritureLibelle	FieldNameLibelleSize  TFloatFieldTaEcritureQt1	FieldNameQt1  TFloatFieldTaEcritureQt2	FieldNameQt2  TFloatFieldTaEcritureDebitSaisie	FieldNameDebitSaisie  TFloatFieldTaEcritureCreditSaisie	FieldNameCreditSaisie  TIntegerFieldTaEcritureID_Devise	FieldName	ID_Devise  TFloatFieldTaEcritureDebit	FieldNameDebit  TFloatFieldTaEcritureCredit	FieldNameCreditVisible  TStringFieldTaEcritureTvaCode	FieldNameTvaCodeSize  TStringFieldTaEcritureTvaType	FieldNameTvaTypeSize  TFloatFieldTaEcritureTvaTaux	FieldNameTvaTaux  
TDateFieldTaEcritureTvaDate	FieldNameTvaDate  TStringFieldTaEcritureRapprochement	FieldNameRapprochementSize  
TDateFieldTaEcritureValidation	FieldName
Validation  TStringFieldTaEcritureQui	FieldNameQuiSize
  TDateTimeFieldTaEcritureQuand	FieldNameQuand   TDataSource
DaEcritureDataSet
TaEcritureLeft�Top�  TDataSourceDataCompteBancDataSetTaTiersLeft8Top�  TTableTaTiersDatabaseNameDossier	TableNameTiers.DBLeftxTop�  TQuery
QuPointageDatabaseNameExerciceSQL.Strings?select "Pointage.db"."Id_Credit", Sum("Pointage.db"."Montant") from Pointage.db"group by "Pointage.db"."Id_Credit" Left0Top� TIntegerFieldQuPointageId_Credit	FieldName	Id_Credit  TFloatFieldQuPointageSUMOFMontant	FieldNameSUM OF Montant   TDataSource
DaPointageDataSet
QuPointageLeftTop�  TDataSourceDaPieceDataSetQuPieceLeft@Top�  TQueryQuPieceDatabaseNameExerciceSQL.Stringsselect * from Piece.db where K"Piece.db"."Id" in (select "Ecriture.db"."Id_Piece" from Ecriture.db where G"Ecriture.db"."TypeLigne" = 'X' and "Ecriture.db"."Credit" is not null) LefttTop� TIntegerField	QuPieceId	FieldNameId  TIntegerFieldQuPieceJournal	FieldNameJournal  TStringFieldQuPieceReference	FieldName	ReferenceSize	  
TDateFieldQuPieceDate	FieldNameDate  TStringFieldQuPieceLibelle	FieldNameLibelleSize  TSmallintFieldQuPieceTypePiece	FieldName	TypePiece  TStringFieldQuPieceCompte	FieldNameCompteSize  TIntegerFieldQuPieceID_Devise	FieldName	ID_Devise  
TDateFieldQuPieceValidation	FieldName
Validation  TStringField
QuPieceQui	FieldNameQuiSize
  TDateTimeFieldQuPieceQuand	FieldNameQuand   TQueryQuPointage2DatabaseNameExerciceSQL.Strings>select "Pointage.db"."Id_Debit", Sum("Pointage.db"."Montant") from Pointage.db!group by "Pointage.db"."Id_Debit" LefthTop� TIntegerFieldQuPointage2Id_Debit	FieldNameId_Debit  TFloatFieldQuPointage2SUMOFMontant	FieldNameSUM OF Montant    