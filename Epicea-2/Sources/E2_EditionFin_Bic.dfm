object EditionFin_Bic: TEditionFin_Bic
  Left = 437
  Top = 113
  Width = 1193
  Height = 700
  Caption = 'Editions de fin d'#39'exercice'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  PopupMenu = PopupMenu1
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = PaBtnResize
  PixelsPerInch = 96
  TextHeight = 13
  object PCLiasseFiscale: TPageControl
    Left = 0
    Top = 26
    Width = 1050
    Height = 600
    ActivePage = TbShDoc2053
    Align = alClient
    TabOrder = 0
    TabStop = False
    OnChange = PCLiasseFiscaleChange
    object TbShDoc2050: TTabSheet
      Caption = 'Bilan - Actif  N'#176' 2050'
      ImageIndex = 4
      object GrGrid3: TGrGrid
        Left = 0
        Top = 14
        Width = 767
        Height = 432
        Align = alClient
        ColCount = 4
        FixedCols = 0
        RowCount = 39
        TabOrder = 0
        OnDblClick = BtnDetailClick
        NumDecimal = 0
        AjoutAuto = False
        ColWidths = (
          250
          33
          92
          98)
        RowHeights = (
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24)
      end
      object Panel8: TPanel
        Left = 0
        Top = 14
        Width = 767
        Height = 432
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        Caption = 'PaGrGrandLivre'
        TabOrder = 1
        object GrBilanActif_Bic: TGrGrid
          Left = 3
          Top = 3
          Width = 757
          Height = 422
          Align = alClient
          ColCount = 8
          FixedCols = 0
          RowCount = 30
          TabOrder = 0
          OnDblClick = BtnDetailClick
          NumDecimal = 0
          AjoutAuto = False
          ColWidths = (
            250
            80
            30
            80
            30
            80
            80
            80)
          RowHeights = (
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24)
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 767
        Height = 14
        Align = alTop
        Caption = 'Bilan - Actif  N'#176' 2050'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
    end
    object TbShDoc2051: TTabSheet
      Caption = 'Bilan - Passif N'#176' 2051'
      ImageIndex = 5
      object Panel10: TPanel
        Left = 0
        Top = 14
        Width = 767
        Height = 432
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        Caption = 'PaGrGrandLivre'
        TabOrder = 0
        object GrBilanPassif_Bic: TGrGrid
          Left = 3
          Top = 3
          Width = 757
          Height = 422
          Align = alClient
          ColCount = 6
          FixedCols = 0
          RowCount = 17
          TabOrder = 0
          OnDblClick = BtnDetailClick
          NumDecimal = 0
          AjoutAuto = False
          ColWidths = (
            250
            30
            80
            30
            80
            80)
          RowHeights = (
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24)
        end
      end
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 767
        Height = 14
        Align = alTop
        Caption = 'Bilan - Passif N'#176' 2051'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
    object TbShDoc2052: TTabSheet
      Caption = 'Compte de R'#233'sultats - 2052'
      ImageIndex = 6
      object Panel11: TPanel
        Left = 0
        Top = 14
        Width = 767
        Height = 432
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        Caption = 'PaGrGrandLivre'
        TabOrder = 0
        object GrCptResultat_Bic: TGrGrid
          Left = 3
          Top = 3
          Width = 757
          Height = 422
          Align = alClient
          ColCount = 8
          FixedCols = 0
          RowCount = 41
          TabOrder = 0
          OnDblClick = BtnDetailClick
          NumDecimal = 0
          AjoutAuto = False
          ColWidths = (
            250
            33
            92
            34
            80
            34
            80
            78)
          RowHeights = (
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24)
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 0
        Width = 767
        Height = 14
        Align = alTop
        Caption = 'Compte de R'#233'sultats - 2052'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
    object TbShDoc2053: TTabSheet
      Caption = 'Compte de R'#233'sultats - 2053'
      ImageIndex = 7
      object Panel14: TPanel
        Left = 0
        Top = 14
        Width = 1042
        Height = 558
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        Caption = 'PaGrGrandLivre'
        TabOrder = 0
        object GrCptResultatBis_Bic: TGrGrid
          Left = 3
          Top = 3
          Width = 1032
          Height = 548
          Align = alClient
          ColCount = 9
          FixedCols = 0
          RowCount = 33
          TabOrder = 0
          OnDblClick = BtnDetailClick
          NumDecimal = 0
          AjoutAuto = False
          ColWidths = (
            250
            30
            80
            90
            30
            80
            30
            80
            80)
          RowHeights = (
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24)
        end
      end
      object Panel15: TPanel
        Left = 0
        Top = 0
        Width = 1042
        Height = 14
        Align = alTop
        Caption = 'Compte de R'#233'sultats - 2053'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
  end
  object PaModifZone: TPanel
    Left = 1050
    Top = 26
    Width = 127
    Height = 600
    Align = alRight
    Anchors = [akTop, akBottom]
    TabOrder = 1
    Visible = False
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 125
      Height = 14
      Align = alTop
      Caption = 'Bilan - Actif  N'#176' 2144'
      Color = 7396351
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6974005
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object PaGrilleCpt: TPanel
      Left = 1
      Top = 15
      Width = 125
      Height = 418
      Align = alClient
      TabOrder = 1
      object GrGrid1: TGrGrid
        Left = 1
        Top = 1
        Width = 123
        Height = 416
        Align = alClient
        RowCount = 2
        TabOrder = 0
        NumDecimal = 0
        AjoutAuto = False
        ColWidths = (
          64
          139
          27
          25
          23)
      end
    end
    object PaDetailZone: TPanel
      Left = 1
      Top = 459
      Width = 125
      Height = 140
      Align = alBottom
      TabOrder = 2
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 123
        Height = 14
        Align = alTop
        Caption = 'Bilan - Actif  N'#176' 2144'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object PaDetail: TPanel
        Left = 1
        Top = 15
        Width = 123
        Height = 124
        Align = alClient
        TabOrder = 1
        object GrGrid2: TGrGrid
          Left = 1
          Top = 1
          Width = 121
          Height = 122
          Align = alClient
          ColCount = 4
          RowCount = 2
          TabOrder = 0
          NumDecimal = 0
          AjoutAuto = False
          ColWidths = (
            64
            68
            73
            66)
          RowHeights = (
            40
            24)
        end
      end
    end
    object PaOutils: TPanel
      Left = 1
      Top = 433
      Width = 125
      Height = 26
      Align = alBottom
      TabOrder = 3
      object SBAjouter: TSpeedButton
        Left = 104
        Top = 0
        Width = 73
        Height = 25
        Caption = 'Ajouter'
      end
      object SBEnlever: TSpeedButton
        Left = 16
        Top = 1
        Width = 73
        Height = 25
        Caption = 'Enlever'
        OnClick = SBEnleverClick
      end
      object SBFermer: TSpeedButton
        Left = 216
        Top = 0
        Width = 73
        Height = 25
        Caption = 'Fermer'
        OnClick = SBFermerClick
      end
    end
  end
  object PaTools: TPanel
    Left = 0
    Top = 0
    Width = 1177
    Height = 26
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 12441823
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    object RxSBInfoVersion: TRxSpeedButton
      Left = 2
      Top = 2
      Width = 25
      Height = 22
      Cursor = crHelp
      Hint = 'Infos Version'
      Caption = '?'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object RxSBGraphe: TRxSpeedButton
      Left = 27
      Top = 2
      Width = 25
      Height = 22
      Cursor = crHandPoint
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        D6090000424DD609000000000000360400002800000050000000120000000100
        080000000000A005000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
        A400000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070700000000
        00000000000000000000000007070707F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
        0707070700000000000000000000000000000000070707070000000000000000
        0000000000000000070707070007070707F807070707F807070707F807070707
        F807070707F707070707F707070707F7070707070007070707F807070707F807
        070707F8070707070007070707F807070707F807070707F80707070700070707
        07F807070707F807070707F807070707F807070707F707070707F707070707F7
        070707070007070707F807070707F807070707F8070707070007070707F80707
        0707F807070707F8070707070007070707F807070707F807070707F807070707
        F807070707F707070707F707070707F7070707070007070707F807070707F807
        070707F8070707070007070707F807070707F807070707F80707070700000707
        07F807070707F807070707F807070707F8F8070707F707070707F707070707F7
        070707070000070707F807070707F807070707F8070707070000070707F80707
        0707F807070707F8070707070007070707F807070707F807070707F807070707
        F807070707F707070707F707070707F7070707070007070707F807070707F807
        070707F8070707070007070707F807070707F807070707F80707070700070707
        07F807070707F807070707F807070707F807070707F707070707F707070707F7
        070707070007070707F807070707F807070707F8070707070007070707F80707
        0707F807070707F8070707070007070707F807070707F807070707F807070707
        F807070707F707070707F707070707F7070707070007070707F807070707F807
        070707F8070707070007070707F807070707F807070707F80707070700000707
        07F807070707F807070707F807070707F8F8070707F707070707F707070707F7
        070707070000070707F807070707F807070707F8070707070000070707F80707
        0707F807070707F8070707070007070707F807070707F807070707F807070707
        F807070707F707070707F707070707F7070707070007070707F807070707F807
        070707F8070707070007070707F807070707F807070707F80707070700070707
        07F807070707F807070707F807070707F807070707F707070707F707070707F7
        070707070007070707F807070707F807070707F8070707070007070707F80707
        0707F807070707F8070707070007070707F807070707F807070707F807070707
        F807070707F707070707F707070707F7070707070007070707F807070707F807
        070707F8070707070007070707F807070707F807070707F80707070700000707
        07F807070707F807070707F807070707F8F8070707F707070707F707070707F7
        070707070000070707F807070707F807070707F8070707070000070707F80707
        0707F807070707F8070707070007070707F807070707F807070707F807070707
        F807070707F707070707F707070707F7070707070007070707F807070707F807
        070707F8070707070007070707F807070707F807070707F80707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707070707070707
        0707070707070707070707070707070707070707070707070707}
      NumGlyphs = 4
      ParentFont = False
      Transparent = True
    end
    object RxSBDetailPointage: TRxSpeedButton
      Left = 372
      Top = 2
      Width = 145
      Height = 22
      Caption = 'D'#233'tail Pointages'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object CBEditionCentime: TCheckBox
      Left = 64
      Top = 5
      Width = 129
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Edition avec centimes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object PaBtn: TPanel
    Left = 0
    Top = 626
    Width = 1177
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 3
    OnResize = PaBtnResize
    object BtnCalculer: TButton
      Left = 1
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Calculer [F3]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnCalculerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnModifier: TButton
      Left = 98
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Modifier [F2]'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtnModifierClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnImprimerDetail: TButton
      Left = 195
      Top = 0
      Width = 142
      Height = 37
      Caption = 'Imprimer [F8]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BtnImprimerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnFermer: TButton
      Left = 341
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
      TabOrder = 3
      OnClick = BtnFermerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnImprimer: TButton
      Left = 438
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
      TabOrder = 4
      OnClick = BtnImprimerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnDetail: TButton
      Left = 527
      Top = 0
      Width = 93
      Height = 37
      Caption = 'D'#233'tails ... [F7]'
      TabOrder = 5
      OnClick = BtnDetailClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnEditionRepartition: TButton
      Left = 619
      Top = -1
      Width = 190
      Height = 37
      Caption = 'Editions d'#233'taill'#233'es Comparatives'
      TabOrder = 6
      OnClick = BtnEditionRepartitionClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 214
    Top = 244
    object pmMenu1: TMenuItem
      Caption = 'Menu'
    end
    object Aideenligne1: TMenuItem
      Caption = 'Aide en li&gne'
      Enabled = False
      ShortCut = 16496
      Visible = False
    end
    object Aide1: TMenuItem
      Caption = '&Aide'
      ShortCut = 112
    end
    object Visualisation1: TMenuItem
      Caption = '&Visualisation'
      ShortCut = 118
      OnClick = BtnDetailClick
    end
    object Imprimer1: TMenuItem
      Caption = 'Im&primer'
      ShortCut = 122
      OnClick = Imprimer1Click
    end
    object ImprimerDetail1: TMenuItem
      Caption = 'I&mprimer'
      ShortCut = 119
      OnClick = ImprimerDetail1Click
    end
    object Calculatrice1: TMenuItem
      Caption = '&Calculatrice'
      ShortCut = 123
      OnClick = Calculatrice1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Enregister1: TMenuItem
      Caption = '&Calculer'
      ShortCut = 114
      OnClick = BtnCalculerClick
    end
    object Modifier1: TMenuItem
      Caption = '&Modifier'
      ShortCut = 113
    end
    object Annuler1: TMenuItem
      Caption = '&Annuler'
      ShortCut = 16449
    end
    object Fermer1: TMenuItem
      Caption = '&Fermer'
      ShortCut = 16499
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Prcdent1: TMenuItem
      Caption = '<<< &Pr'#233'c'#233'dent'
      ShortCut = 16464
    end
    object Suivant1: TMenuItem
      Caption = 'S&uivant >>>'
      ShortCut = 16467
    end
  end
end
