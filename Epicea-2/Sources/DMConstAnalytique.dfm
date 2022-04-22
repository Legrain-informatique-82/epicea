object DMConstAnal: TDMConstAnal
  OldCreateOrder = False
  Left = 554
  Top = 298
  Height = 264
  Width = 502
  object TaAtelierDefaut: TTable
    DatabaseName = 'Dossier'
    TableName = 'AtelierDefaut.DB'
    Left = 88
    Top = 80
    object TaAtelierDefautCode_Atelier: TStringField
      FieldName = 'Code_Atelier'
      Size = 50
    end
    object TaAtelierDefautlibelle_Atelier: TStringField
      FieldName = 'libelle_Atelier'
      Size = 100
    end
    object TaAtelierDefautCode_Activite: TStringField
      FieldName = 'Code_Activite'
      Size = 50
    end
    object TaAtelierDefautDivers: TStringField
      FieldName = 'Divers'
      Size = 255
    end
  end
  object DaAtelierDefaut: TDataSource
    DataSet = TaAtelierDefaut
    Left = 208
    Top = 80
  end
  object QuAtelierDefaut: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      'select * from atelierDefaut'
      'order by code_atelier')
    Left = 144
    Top = 144
  end
  object DaQuAtelierDefaut: TDataSource
    DataSet = QuAtelierDefaut
    Left = 232
    Top = 152
  end
  object TaAtelierDefaut2: TTable
    DatabaseName = 'Dossier'
    TableName = 'AtelierDefaut.DB'
    Left = 136
    Top = 24
    object StringField1: TStringField
      FieldName = 'Code_Atelier'
      Size = 50
    end
    object StringField2: TStringField
      FieldName = 'libelle_Atelier'
      Size = 100
    end
    object StringField3: TStringField
      FieldName = 'Code_Activite'
      Size = 50
    end
    object StringField4: TStringField
      FieldName = 'Divers'
      Size = 255
    end
  end
end
