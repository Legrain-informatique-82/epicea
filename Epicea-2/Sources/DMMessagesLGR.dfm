object DMMessageLGR: TDMMessageLGR
  OldCreateOrder = False
  Left = 1590
  Top = 763
  Height = 274
  Width = 329
  object TaMessageLGR: TTable
    BeforeDelete = TaMessageLGRBeforeDelete
    DatabaseName = 'Program'
    Filter = 
      'ecran = '#39'GestionSauvegarde'#39' and composant is null and cle='#39'Recup' +
      'FTP'#39
    Filtered = True
    FieldDefs = <
      item
        Name = 'ID_Message'
        DataType = ftInteger
      end
      item
        Name = 'Ecran'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Composant'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Cle'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'MessageLGR'
        DataType = ftMemo
        Size = 1
      end
      item
        Name = 'Titre'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Afficher'
        DataType = ftBoolean
      end
      item
        Name = 'Divers'
        DataType = ftString
        Size = 255
      end>
    IndexDefs = <
      item
        Name = 'TaMessageLGRIndex1'
        Fields = 'ID_Message'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'EcranCompCle'
        Fields = 'Ecran;Composant;Cle'
        Options = [ixDescending]
      end>
    IndexName = 'EcranCompCle'
    StoreDefs = True
    TableName = 'MessageLGR.DB'
    Left = 48
    Top = 32
  end
  object DaMessageLGR: TDataSource
    DataSet = TaMessageLGR
    Left = 48
    Top = 112
  end
end
