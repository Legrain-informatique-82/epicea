object DMDeduction: TDMDeduction
  OldCreateOrder = False
  OnCreate = DMDeductionCreate
  OnDestroy = DMDeductionDestroy
  Left = 520
  Top = 324
  Height = 268
  Width = 409
  object TaDeduction: TTable
    BeforeInsert = TaDeductionBeforeInsert
    AfterInsert = TaDeductionAfterInsert
    BeforeEdit = TaDeductionBeforeEdit
    BeforePost = TaDeductionBeforePost
    AfterPost = TaDeductionAfterPost
    BeforeDelete = TaDeductionBeforeDelete
    AfterDelete = TaDeductionAfterDelete
    OnCalcFields = TaDeductionCalcFields
    OnDeleteError = TaDeductionDeleteError
    OnPostError = TaDeductionPostError
    DatabaseName = 'Exercice'
    OnFilterRecord = TaDeductionFilterRecord
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'Libelle'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Mt_N'
        DataType = ftCurrency
      end
      item
        Name = 'Mt_N1'
        DataType = ftCurrency
      end
      item
        Name = 'Mt_N2'
        DataType = ftCurrency
      end
      item
        Name = 'Mt_N3'
        DataType = ftCurrency
      end
      item
        Name = 'Mt_N4'
        DataType = ftCurrency
      end
      item
        Name = 'Mt_N5'
        DataType = ftCurrency
      end
      item
        Name = 'Reste'
        DataType = ftCurrency
      end
      item
        Name = 'Divers_Str'
        DataType = ftString
        Size = 255
      end>
    IndexDefs = <
      item
        Name = 'TaDeductionIndex1'
        Fields = 'ID'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'Exercice'
        Fields = 'Mt_N;Mt_N1;Mt_N2;Mt_N3;Mt_N4;Mt_N5'
        Options = [ixCaseInsensitive]
      end>
    StoreDefs = True
    TableName = 'Ta_deduction.db'
    Left = 24
    Top = 8
    object TaDeductionID: TIntegerField
      FieldName = 'ID'
    end
    object TaDeductionLibelle: TStringField
      FieldName = 'Libelle'
      Size = 100
    end
    object TaDeductionMt_N: TCurrencyField
      FieldName = 'Mt_N'
    end
    object TaDeductionMt_N1: TCurrencyField
      FieldName = 'Mt_N1'
    end
    object TaDeductionMt_N2: TCurrencyField
      FieldName = 'Mt_N2'
    end
    object TaDeductionMt_N3: TCurrencyField
      FieldName = 'Mt_N3'
    end
    object TaDeductionMt_N4: TCurrencyField
      FieldName = 'Mt_N4'
    end
    object TaDeductionMt_N5: TCurrencyField
      FieldName = 'Mt_N5'
    end
    object TaDeductionResteCalcule: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ResteCalcule'
      Calculated = True
    end
    object TaDeductionDivers_Str: TStringField
      FieldName = 'Divers_Str'
      Size = 255
    end
  end
  object DataDeduction: TDataSource
    DataSet = TaDeduction
    Left = 112
    Top = 8
  end
  object TaUtilisation_deduc: TTable
    BeforeInsert = TaUtilisation_deducBeforeInsert
    AfterInsert = TaUtilisation_deducAfterInsert
    BeforeEdit = TaUtilisation_deducBeforeEdit
    AfterEdit = TaUtilisation_deducAfterEdit
    BeforePost = TaUtilisation_deducBeforePost
    AfterPost = TaUtilisation_deducAfterPost
    BeforeDelete = TaUtilisation_deducBeforeDelete
    AfterDelete = TaUtilisation_deducAfterDelete
    OnCalcFields = TaUtilisation_deducCalcFields
    OnDeleteError = TaUtilisation_deducDeleteError
    OnPostError = TaUtilisation_deducPostError
    DatabaseName = 'Exercice'
    DefaultIndex = False
    TableName = 'Ta_utilisation_deduc.db'
    Left = 48
    Top = 80
    object TaUtilisation_deducID: TIntegerField
      FieldName = 'ID'
    end
    object TaUtilisation_deducID_deduction: TIntegerField
      FieldName = 'ID_deduction'
    end
    object TaUtilisation_deducid_immo: TIntegerField
      FieldName = 'id_immo'
    end
    object TaUtilisation_deducExercice: TStringField
      FieldName = 'Exercice'
      Size = 3
    end
    object TaUtilisation_deducMt_immo: TCurrencyField
      FieldName = 'Mt_immo'
    end
    object TaUtilisation_deducMt_social: TCurrencyField
      FieldName = 'Mt_social'
    end
    object TaUtilisation_deducMt_stocks: TCurrencyField
      FieldName = 'Mt_stocks'
    end
    object TaUtilisation_deducReinteg_except: TCurrencyField
      FieldName = 'Reinteg_except'
    end
    object TaUtilisation_deducDivers_Str: TStringField
      FieldName = 'Divers_Str'
      Size = 255
    end
    object TaUtilisation_deducTotalUtilise: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotalUtilise'
      Calculated = True
    end
    object TaUtilisation_deducLibelle_Reinteg: TStringField
      FieldName = 'Libelle_Reinteg'
      Size = 100
    end
  end
  object DataUtilisation_deduc: TDataSource
    DataSet = TaUtilisation_deduc
    Left = 160
    Top = 80
  end
  object QuDeductionEdition: TQuery
    DatabaseName = 'Exercice'
    SQL.Strings = (
      
        'select cast('#39'N'#39'as varchar(3))as Exo,D.libelle,sum(Mt_N) as monta' +
        'nt,Exercice, mt_immo,mt_social,mt_stocks,'
      'reinteg_except'
      'from ta_deduction D'
      'left join ta_utilisation_deduc U'
      'on (U.id_deduction=D.id) '
      
        'group by D.libelle,Exercice, mt_immo,mt_social,mt_stocks,reinteg' +
        '_except'
      'having sum(Mt_N) is not null and sum(Mt_N)<>0'
      'union'
      
        'select cast('#39'N-1'#39'as varchar(3))as Exo,D.libelle,sum(Mt_N1) as mo' +
        'ntant,Exercice, mt_immo,mt_social,mt_stocks,'
      'reinteg_except'
      'from ta_deduction D'
      'left join ta_utilisation_deduc U'
      'on (U.id_deduction=D.id)'
      
        'group by D.libelle,Exercice, mt_immo,mt_social,mt_stocks,reinteg' +
        '_except'
      'having sum(Mt_N1) is not null and sum(Mt_N1)<>0'
      'union'
      
        'select cast('#39'N-2'#39'as varchar(3)),D.libelle,sum(Mt_N2) as montant,' +
        'Exercice, mt_immo,mt_social,mt_stocks,'
      'reinteg_except'
      'from ta_deduction D'
      'left join ta_utilisation_deduc U'
      'on (U.id_deduction=D.id)'
      
        'group by D.libelle,Exercice, mt_immo,mt_social,mt_stocks,reinteg' +
        '_except'
      'having sum(Mt_N2) is not null and sum(Mt_N2)<>0'
      'union'
      
        'select cast('#39'N-3'#39'as varchar(3)),D.libelle,sum(Mt_N3) as montant,' +
        'Exercice, mt_immo,mt_social,mt_stocks,'
      'reinteg_except'
      'from ta_deduction D'
      'left join ta_utilisation_deduc U'
      'on (U.id_deduction=D.id)'
      
        'group by D.libelle,Exercice, mt_immo,mt_social,mt_stocks,reinteg' +
        '_except'
      'having sum(Mt_N3) is not null and sum(Mt_N3)<>0'
      'union'
      
        'select cast('#39'N-4'#39'as varchar(3)),D.libelle,sum(Mt_N4) as montant,' +
        'Exercice, mt_immo,mt_social,mt_stocks,'
      'reinteg_except'
      'from ta_deduction D'
      'left join ta_utilisation_deduc U'
      'on (U.id_deduction=D.id)'
      
        'group by D.libelle,Exercice, mt_immo,mt_social,mt_stocks,reinteg' +
        '_except'
      'having sum(Mt_N4) is not null and sum(Mt_N4)<>0'
      'union'
      
        'select cast('#39'N-5'#39'as varchar(3)),D.libelle,sum(Mt_N5) as montant,' +
        'Exercice, mt_immo,mt_social,mt_stocks,'
      'reinteg_except'
      'from ta_deduction D'
      'left join ta_utilisation_deduc U'
      'on (U.id_deduction=D.id)'
      
        'group by D.libelle,Exercice, mt_immo,mt_social,mt_stocks,reinteg' +
        '_except'
      'having sum(Mt_N5) is not null and sum(Mt_N5)<>0'
      'order by Exo desc, exercice desc'
      '')
    Left = 256
    Top = 8
  end
  object QuEditionAmort_A_Reinteg: TQuery
    DatabaseName = 'Dossier'
    Left = 112
    Top = 160
  end
end
