object FRPasBtn: TFRPasBtn
  Left = 0
  Top = 0
  Width = 687
  Height = 240
  TabOrder = 0
  object PaBtn: TPanel
    Left = 0
    Top = 204
    Width = 687
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 0
    object BtnEnregistrer: TButton
      Left = 220
      Top = -1
      Width = 90
      Height = 37
      Caption = 'Valider [F3]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      Visible = False
    end
    object BtnFermer: TButton
      Left = 309
      Top = -1
      Width = 90
      Height = 37
      Caption = 'Fermer [F4]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object BtnImprimer: TButton
      Left = 398
      Top = -1
      Width = 90
      Height = 37
      Caption = 'Imprimer [F11]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object BtnDetail: TButton
      Left = 487
      Top = -1
      Width = 90
      Height = 37
      Caption = 'Visualisation [F7]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
end
