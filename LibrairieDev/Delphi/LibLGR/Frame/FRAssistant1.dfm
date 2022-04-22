object FRAssistant: TFRAssistant
  Left = 0
  Top = 0
  Width = 435
  Height = 63
  Align = alBottom
  TabOrder = 0
  object PaBtn: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 63
    Align = alClient
    TabOrder = 0
    DesignSize = (
      435
      63)
    object BtnPrecedent: TButton
      Left = 4
      Top = 23
      Width = 123
      Height = 25
      Anchors = []
      Caption = '... Pr'#233'c'#233'dent '
      Enabled = False
      TabOrder = 0
      OnClick = Etape1
    end
    object BtnSuivant: TButton
      Left = 164
      Top = 23
      Width = 123
      Height = 25
      Anchors = []
      Caption = 'D'#233'marrer'
      TabOrder = 1
      OnClick = Etape0
    end
    object BtnAnnuler: TButton
      Left = 316
      Top = 23
      Width = 123
      Height = 25
      Anchors = []
      Caption = 'Annuler'
      TabOrder = 2
      OnClick = BtnAnnulerClick
    end
  end
end
