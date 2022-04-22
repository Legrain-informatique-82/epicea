object DMImportReleve: TDMImportReleve
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 260
  Top = 209
  Height = 499
  Width = 764
  object QuEcr_RappBanc: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      'select ecriture .*,P.reference from ecriture '
      'left join piece P on P.id=ecriture.id_piece'
      
        'order by ecriture."date",marqueReleve desc,debitSaisie asc,credi' +
        'tSaisie asc ')
    Left = 144
    Top = 8
  end
  object DaEcr_RappBanc: TDataSource
    DataSet = QuEcr_RappBanc
    Left = 36
    Top = 12
  end
  object DaReleve: TDataSource
    DataSet = QuReleve
    Left = 320
    Top = 80
  end
  object QuListeMarque: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      'select distinct marque, min(R."dateOp") as DateDeb,'
      'max(R."dateOP") as DateFin'
      '    from Ta_releveBancaire R '
      'where compte=:Compte and marque <> '#39#39' '
      'and R.dateOp<=:DateFin'
      'and rapprochement=:rapprochement'
      'Group by marque;')
    Left = 24
    Top = 296
    ParamData = <
      item
        DataType = ftString
        Name = 'Compte'
        ParamType = ptInput
        Value = ''
      end
      item
        DataType = ftDate
        Name = 'DateFin'
        ParamType = ptInput
        Value = 0d
      end
      item
        DataType = ftString
        Name = 'rapprochement'
        ParamType = ptInput
        Value = ''
      end>
  end
  object QuReleve: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      'select * from ta_relevebancaire'
      'order by dateOp,marque desc,debit asc ,credit asc')
    Left = 416
    Top = 96
  end
  object TaEcr_RappBanc: TTable
    BeforeInsert = TaEcr_BeforeInsert
    BeforePost = TaEcr_BeforePost
    BeforeDelete = TaEcr_BeforeDelete
    DatabaseName = 'Dossier'
    TableName = 'Ecriture.DB'
    Left = 248
    Top = 8
  end
  object TaReleve: TTable
    BeforeInsert = TaReleveBeforeInsert
    BeforePost = TaReleveBeforePost
    BeforeDelete = TaReleveBeforeDelete
    DatabaseName = 'Dossier'
    TableName = 'Ta_ReleveBancaire.db'
    Left = 312
    Top = 152
    object TaReleveID: TIntegerField
      FieldName = 'ID'
    end
    object TaRelevecompte: TStringField
      FieldName = 'compte'
      Size = 8
    end
    object TaRelevedateOp: TDateField
      FieldName = 'dateOp'
    end
    object TaReleveDebit: TCurrencyField
      FieldName = 'Debit'
    end
    object TaReleveCredit: TCurrencyField
      FieldName = 'Credit'
    end
    object TaRelevedesignation: TStringField
      FieldName = 'designation'
      Size = 100
    end
    object TaRelevesupplement: TStringField
      FieldName = 'supplement'
      Size = 100
    end
    object TaRelevemarque: TStringField
      FieldName = 'marque'
      Size = 8
    end
    object TaReleveReference: TStringField
      FieldName = 'Reference'
      Size = 50
    end
    object TaRelevedivers: TStringField
      FieldName = 'divers'
      Size = 255
    end
    object TaReleverapprochement: TStringField
      FieldName = 'rapprochement'
      Size = 8
    end
    object TaReleveid_Ecriture: TIntegerField
      FieldName = 'id_Ecriture'
    end
    object TaRelevecptTiers: TStringField
      FieldName = 'cptTiers'
      Size = 8
    end
    object TaReleveAbandon: TBooleanField
      FieldName = 'Abandon'
    end
  end
  object TaEcrTemp: TTable
    DatabaseName = 'Dossier'
    TableName = 'Ecriture.DB'
    Left = 336
    Top = 16
  end
  object TaReleveTemp: TTable
    DatabaseName = 'Dossier'
    TableName = 'Ta_ReleveBancaire.db'
    Left = 216
    Top = 104
  end
  object TaComptesBancaire: TTable
    BeforePost = TaComptesBancaireBeforePost
    AfterPost = TaComptesBancaireAfterPost
    DatabaseName = 'Dossier'
    TableName = 'ComptesBancaire.db'
    Left = 48
    Top = 96
  end
  object DaComptesBancaires: TDataSource
    DataSet = TaComptesBancaire
    Left = 56
    Top = 152
  end
  object TaCompteBancaireTemp: TTable
    DatabaseName = 'Dossier'
    TableName = 'ComptesBancaire.db'
    Left = 120
    Top = 264
  end
  object QuMaxMarque: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      
        'select max(cast(marque as integer)) as maxMarque from ta_releveB' +
        'ancaire'
      'where rapprochement is null or Rapprochement=:Rapprochement')
    Left = 400
    Top = 224
    ParamData = <
      item
        DataType = ftString
        Name = 'rapprochement'
        ParamType = ptInput
        Value = ''
      end>
  end
  object DataReleve: TDataSource
    DataSet = TaReleveReglement
    Left = 416
    Top = 288
  end
  object TaReleveReglement: TTable
    BeforeInsert = TaReleveBeforeInsert
    BeforePost = TaReleveReglementBeforePost
    AfterPost = TaReleveReglementAfterPost
    BeforeDelete = TaReleveBeforeDelete
    DatabaseName = 'Dossier'
    TableName = 'Ta_ReleveBancaire.db'
    Left = 304
    Top = 288
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".ID'
    end
    object StringField1: TStringField
      FieldName = 'compte'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".compte'
      Size = 8
    end
    object DateField1: TDateField
      FieldName = 'dateOp'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".dateOp'
    end
    object CurrencyField1: TCurrencyField
      FieldName = 'Debit'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".Debit'
    end
    object CurrencyField2: TCurrencyField
      FieldName = 'Credit'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".Credit'
    end
    object StringField2: TStringField
      FieldName = 'designation'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".designation'
      Size = 100
    end
    object StringField3: TStringField
      FieldName = 'supplement'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".supplement'
      Size = 100
    end
    object StringField4: TStringField
      FieldName = 'marque'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".marque'
      Size = 8
    end
    object StringField5: TStringField
      FieldName = 'Reference'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".Reference'
      Size = 50
    end
    object StringField6: TStringField
      FieldName = 'divers'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".divers'
      Size = 255
    end
    object StringField7: TStringField
      FieldName = 'rapprochement'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".rapprochement'
      Size = 8
    end
    object IntegerField2: TIntegerField
      FieldName = 'id_Ecriture'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".id_Ecriture'
    end
    object StringField8: TStringField
      FieldName = 'cptTiers'
      Origin = 'DOSSIER CLIENT."ta_relevebancaire.DB".cptTiers'
      Size = 8
    end
    object BooleanField1: TBooleanField
      FieldName = 'Abandon'
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    MasterSource = DataReleve
    PacketRecords = 0
    Params = <>
    Left = 320
    Top = 232
  end
  object QuReleveEbics: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      'select * from Ta_releve_ebics')
    Left = 584
    Top = 24
  end
  object TaReleveEbics: TTable
    BeforePost = TaComptesBancaireBeforePost
    AfterPost = TaComptesBancaireAfterPost
    DatabaseName = 'Dossier'
    TableName = 'Ta_releve_ebics.db'
    Left = 600
    Top = 120
  end
  object TaReleveEbics_maxID: TTable
    DatabaseName = 'Dossier'
    TableName = 'Ta_releve_ebics.db'
    Left = 608
    Top = 192
  end
  object QuLigneComplementEbics: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      'select * from Ta_releve_ebics')
    Left = 592
    Top = 72
  end
  object TaComplementEbics: TTable
    BeforePost = TaComptesBancaireBeforePost
    AfterPost = TaComptesBancaireAfterPost
    DatabaseName = 'Dossier'
    TableName = 'Ta_complement_ebics.db'
    Left = 672
    Top = 8
  end
  object TaComplementEbics_maxID: TTable
    DatabaseName = 'Dossier'
    TableName = 'Ta_complement_ebics.db'
    Left = 616
    Top = 288
  end
  object TaReleveEbicsTraite: TTable
    DatabaseName = 'Dossier'
    TableName = 'Ta_releve_ebics.db'
    Left = 616
    Top = 248
  end
end
