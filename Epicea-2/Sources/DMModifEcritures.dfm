object DMModifEcriture: TDMModifEcriture
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 565
  Top = 398
  Height = 150
  Width = 238
  object TaEcriture_Modif: TTable
    DatabaseName = 'Dossier'
    TableName = 'Ecriture.DB'
    Left = 88
    Top = 64
  end
  object QuEcriture_Modif: TQuery
    DatabaseName = 'Dossier'
    Left = 32
    Top = 8
  end
  object DaEcriture_Modif: TDataSource
    DataSet = TaEcriture_Modif
    Left = 144
    Top = 8
  end
end
