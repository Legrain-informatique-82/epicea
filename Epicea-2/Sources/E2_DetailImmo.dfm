�
 TDETAILIMMO 0�  TPF0TDetailImmo
DetailImmoLeft� Top� Width�Height�CaptionD�tail d'une ImmobilisationFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TPanelPanel1Left Top)Width�Height� AlignalClient
BevelInner	bvLoweredBorderWidthTabOrder TLabelLabel1Left8TopWidth^HeightCaptionDate d'Acquisition :   TLabelLabel2LeftTop'Width~HeightCaptionDate de Mise en Service :   TLabelLabel3Left� TopWidtheHeightCaptionValeur d'Acquisition :   TLabelLabel4Left� Top'WidthuHeightCaptionDur�e d'Amortissement :   TLabelLabel7Left^Top� Width� HeightCaptionD�duction sur Investissement :   TLabelLabel20Left�Top'WidthHeightCaptionmois  TLabelLabel6Left8Top� Width� HeightCaption'Reprise D�duction sur Investissement :   TDBEditVal_AcqLeft]Top
WidthXHeightTabStop	DataField
Valeur_Org
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder   TDBEditDate_MeSLeft� Top#WidthAHeightTabStop	DataFieldDate_Mise_en_Service
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder  TDBEdit	Duree_AmtLeft]Top#Width!HeightTabStop	DataField	Duree_Amt
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder  TDBEditDeduc_InvestLeft� Top� WidthYHeightTabStop	DataFieldMt_Deduc_Invest
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder  TDBEditDate_AcqLeft� Top
Width@HeightTabStop	DataFieldDate_Org
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder  TDBRadioGroupDBRadioGroup1Left� Top@Width� Height9CaptionType d'Amortissement 	DataFieldType_Amt
DataSourceDataModuleImmos.daDetailImmoItems.StringsLin�aire	D�gressif ReadOnly	TabOrderValues.StringsLD   TDBEditRepr_Deduc_InvestLeft� Top� WidthYHeightTabStop	DataFieldReprise_deduc_invest
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder   TPanelPanel2Left Top� Width�Height[AlignalBottom
BevelInner	bvLoweredBorderWidthTabOrder TLabelLabel9LeftTop
Width=HeightCaption
SITUATION Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsUnderline 
ParentFont  TLabelLabel10Left� TopWidth� HeightCaptionAmortissement Economique :   TLabelLabel11Left� Top(Width� HeightCaptionAmortissement D�rogatoire :   TLabelLabel13Left� Top@WidthyHeightCaptionValeur Nette Comptable :   TDBEditAmo_EcoLeft0TopWidthYHeightTabStop	DataField	Amort_Eco
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder   TDBEdit	Amo_DerogLeft0Top$WidthYHeightTabStop	DataFieldAmort_Derog
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder  TDBEditVNCLeft0Top<WidthYHeightTabStop	DataFieldValeur_Nette
DataSourceDataModuleImmos.daDetailImmoReadOnly	TabOrder   TPanelPanel3Left Top<Width�Height`AlignalBottom
BevelInner	bvLoweredBorderWidthTabOrder TLabelLabel14LeftTopWidthkHeightCaptionINFORMATIONS COMPLEMENTAIRESFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsUnderline 
ParentFontWordWrap	  TLabelLabel15Left� TopWidthHeightCaptionDate R�elle d'Acquisition :   TLabelLabel16Left� Top(Width� HeightCaptionValeur R�elle d'Acquisition :   TLabelLabel17Left� Top@WidthKHeightCaptionValeur V�nale :   TDBEditDate_Reelle_AcqLeft0TopWidthAHeight	DataField
Date_Achat
DataSourceDataModuleImmos.daDetailImmoTabOrder   TDBEditVal_Reelle_AcqLeft0Top$WidthYHeight	DataField
Valeur_Org
DataSourceDataModuleImmos.daDetailImmoTabOrder  TDBEdit
Val_VenaleLeft0Top<WidthYHeight	DataFieldValeur_Venale
DataSourceDataModuleImmos.daDetailImmoTabOrder   TPanelPanel4Left Top Width�Height)AlignalTop
BevelInner	bvLoweredBorderWidthTabOrder  TLabelLabel18Left� TopWidthHeightCaption-  TLabelLabel19LeftqTopWidthHeightCaption-  TDBEditDBEdit1Left� TopWidth� HeightColorclAqua	DataFieldLibelle
DataSourceDataModuleImmos.daDetailImmoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder  TDBEditCodeLeftxTopWidth!Height	DataFieldCode
DataSourceDataModuleImmos.daDetailImmoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder  TDBEdit	Sous_codeLeft� TopWidthHeight	DataField	Sous_Code
DataSourceDataModuleImmos.daDetailImmoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder  TDBRichEditCompteLeft TopWidthMHeight	AlignmenttaRightJustify	DataFieldCompte
DataSourceDataModuleImmos.daDetailImmoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder WantReturnsOnEnterCompteEnter    