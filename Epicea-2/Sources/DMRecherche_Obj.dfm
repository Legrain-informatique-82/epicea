object DMRech_Obj: TDMRech_Obj
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 598
  Top = 317
  Height = 260
  Width = 391
  object TaTiers_Obj: TTable
    DatabaseName = 'Dossier'
    TableName = 'Tiers.DB'
    Left = 180
    Top = 12
  end
  object TaTvaCode_Obj: TTable
    DatabaseName = 'Dossier'
    TableName = 'TvaCode.DB'
    Left = 64
    Top = 26
  end
  object TaPlanCpt_Obj: TTable
    DatabaseName = 'Dossier'
    TableName = 'plancpt.DB'
    Left = 288
    Top = 28
  end
  object Ta_InfosDiverses: TTable
    DatabaseName = 'Dossier'
    TableName = 'plancpt.DB'
    Left = 128
    Top = 128
  end
  object TaParamcpt_Obj: TTable
    DatabaseName = 'Program'
    TableName = 'ParamCpt.DB'
    Left = 232
    Top = 144
  end
end
