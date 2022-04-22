object Frame2: TFrame2
  Left = 0
  Top = 0
  Width = 725
  Height = 340
  TabOrder = 0
  object PaBas: TPanel
    Left = 0
    Top = 256
    Width = 725
    Height = 84
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 0
    object LaFiltre: TLabel
      Left = 45
      Top = 8
      Width = 5
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 37
      Width = 723
      Height = 46
      Align = alClient
      BevelOuter = bvLowered
      Color = 12441823
      TabOrder = 1
      object Label1: TLabel
        Left = 45
        Top = 8
        Width = 5
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object PaBtn: TPanel
      Left = 1
      Top = 1
      Width = 723
      Height = 36
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvNone
      Color = 12441823
      TabOrder = 0
      OnResize = PaBtnResize
      object BtnAnnuler: TButton
        Left = 71
        Top = 0
        Width = 90
        Height = 37
        Caption = 'Annuler [Esc]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = BtnAnnulerClick
        OnEnter = BtnAnnulerEnter
        OnExit = BtnAnnulerExit
      end
      object BtnEnregistrer: TButton
        Left = 160
        Top = 0
        Width = 90
        Height = 37
        Caption = 'Enregistrer [F3]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnEnter = BtnAnnulerEnter
        OnExit = BtnAnnulerExit
      end
      object BtnModifier: TButton
        Left = 249
        Top = 0
        Width = 90
        Height = 37
        Caption = 'Modifier [F2]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnEnter = BtnAnnulerEnter
        OnExit = BtnAnnulerExit
      end
      object BtnInserer: TButton
        Left = 338
        Top = 0
        Width = 90
        Height = 37
        Caption = 'Ins'#233'rer [F6]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnEnter = BtnAnnulerEnter
        OnExit = BtnAnnulerExit
      end
      object BtnSupprimer: TButton
        Left = 427
        Top = 0
        Width = 90
        Height = 37
        Caption = 'Supprimer [F10]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnEnter = BtnAnnulerEnter
        OnExit = BtnAnnulerExit
      end
      object BtnFermer: TButton
        Left = 516
        Top = 0
        Width = 90
        Height = 37
        Caption = 'Fermer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = BtnFermerClick
        OnEnter = BtnAnnulerEnter
        OnExit = BtnAnnulerExit
      end
      object BtnImprimer: TButton
        Left = 605
        Top = 0
        Width = 90
        Height = 37
        Caption = 'Imprimer [F11]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnEnter = BtnAnnulerEnter
        OnExit = BtnAnnulerExit
      end
    end
  end
end
