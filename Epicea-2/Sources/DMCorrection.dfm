object DMcorrections: TDMcorrections
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 207
  Height = 440
  Width = 433
  object QuCorrectionDossier: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      '')
    Left = 168
    Top = 16
  end
  object QuCorrectionInsert: TQuery
    DatabaseName = 'Dossier'
    Left = 48
    Top = 96
  end
  object QucorrectionMaxID: TQuery
    DatabaseName = 'Dossier'
    Left = 48
    Top = 16
  end
  object QuCorrectionPointage: TQuery
    DatabaseName = 'Dossier'
    Left = 160
    Top = 96
  end
  object TaCorrection: TTable
    DatabaseName = 'Dossier'
    Filtered = True
    TableName = 'Ecriture.DB'
    Left = 32
    Top = 168
  end
  object QuCorrectionExo: TQuery
    DatabaseName = 'Exercice'
    Left = 272
    Top = 16
  end
  object QuCorrectionProgram: TQuery
    DatabaseName = 'Program'
    Left = 256
    Top = 72
  end
  object UpdateSQL1: TUpdateSQL
    Left = 248
    Top = 160
  end
  object dbCorrection: TDatabase
    DatabaseName = 'ExoCourant'
    DriverName = 'STANDARD'
    HandleShared = True
    LoginPrompt = False
    Params.Strings = (
      'PATH='
      'ENABLE BCD='
      'DEFAULT DRIVER='
      'ALIASNAME=')
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 40
    Top = 243
  end
  object TaCorrectionExoCourant: TTable
    DatabaseName = 'Exercice'
    Filtered = True
    TableName = 'Balance.DB'
    Left = 176
    Top = 256
  end
  object TaCorrectionExo: TTable
    DatabaseName = 'Exercice'
    TableName = 'Balance.DB'
    Left = 144
    Top = 192
  end
  object QuCorrectionUpdate: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      '')
    Left = 40
    Top = 344
  end
end
