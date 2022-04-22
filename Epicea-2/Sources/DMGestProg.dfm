object DMGestProgr: TDMGestProgr
  OldCreateOrder = False
  Left = 591
  Top = 311
  Height = 315
  Width = 410
  object TaGestProg: TTable
    DatabaseName = 'Program'
    TableName = 'GestProg.DB'
    Left = 152
    Top = 80
  end
  object DaGestProg: TDataSource
    DataSet = TaGestProg
    Left = 88
    Top = 80
  end
end
