object GestPlanSaisie: TGestPlanSaisie
  Left = 494
  Top = 301
  BorderStyle = bsToolWindow
  Caption = 'Gestion du Plan de Saisie'
  ClientHeight = 437
  ClientWidth = 705
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PaGrille: TPanel
    Left = 0
    Top = 75
    Width = 705
    Height = 326
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    OnResize = PaGrilleResize
    object GrDBPlanSaisie: TGrDBGrid
      Left = 3
      Top = 3
      Width = 695
      Height = 316
      Align = alClient
      BorderStyle = bsNone
      DataSource = DMPlan.DaPlanCpt
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnShowEditor = GrDBPlanSaisieShowEditor
      ScrollBars = ssHorizontal
      EditColor = clWindow
      DefaultRowHeight = 17
      CellHints = True
      RowColor1 = cl3DLight
      RowColor2 = clTeal
      AllowAutoAppend = False
      EnterAsTab = True
      HighlightColor = clNavy
      ImageHighlightColor = clWindow
      HighlightFontColor = clWhite
      HotTrackColor = clNavy
      LockedCols = 0
      LockedFont.Charset = DEFAULT_CHARSET
      LockedFont.Color = clWindowText
      LockedFont.Height = -11
      LockedFont.Name = 'MS Sans Serif'
      LockedFont.Style = []
      LockedColor = clGray
      NumDecimal = 0
      Columns = <
        item
          Expanded = False
          FieldName = 'Compte'
          ReadOnly = True
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Libelle'
          ReadOnly = True
          Title.Caption = 'Libell'#233
          Width = 166
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'PlanSaisie'
          Title.Alignment = taCenter
          Title.Caption = 'Plan de Saisie'
          Visible = True
        end>
    end
  end
  object PaTools: TPanel
    Left = 0
    Top = 41
    Width = 705
    Height = 34
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
    TabOrder = 1
    object RxSBInfoVersion: TRxSpeedButton
      Left = 2
      Top = 2
      Width = 25
      Height = 31
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
      Height = 31
      Cursor = crHandPoint
      Enabled = False
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
    object RxSBImport: TRxSpeedButton
      Left = 52
      Top = 2
      Width = 25
      Height = 31
      Cursor = crHandPoint
      Hint = 'Importer le plan comptable d'#39'Epic'#233'a-2 DOS'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
        FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
        00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
        F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
        00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
        F033777777777337F73309999990FFF0033377777777FFF77333099999000000
        3333777777777777333333399033333333333337773333333333333903333333
        3333333773333333333333303333333333333337333333333333}
      NumGlyphs = 2
      Transparent = True
      Visible = False
    end
    object RxSBMarquerTousListe: TRxSpeedButton
      Tag = 1
      Left = 77
      Top = 2
      Width = 188
      Height = 31
      Cursor = crHandPoint
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
      ShowHint = False
      Transparent = True
      OnClick = RxSBMarquerTousListeClick
    end
    object RxSBDeMarquerTousListe: TRxSpeedButton
      Tag = 1
      Left = 265
      Top = 2
      Width = 188
      Height = 31
      Cursor = crHandPoint
      Caption = 'D'#233'cocher Tous les '#13#10'comptes de la Liste'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
      ShowHint = False
      Transparent = True
      OnClick = RxSBDeMarquerTousListeClick
    end
  end
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 12
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    object ImEnTete: TImage
      Left = 13
      Top = 13
      Width = 679
      Height = 15
      Align = alClient
      Picture.Data = {
        0A544A504547496D616765D7040000FFD8FFE000104A46494600010200006400
        640000FFEC00114475636B7900010004000000500000FFEE000E41646F626500
        64C000000001FFDB008400020202020202020202020302020203040302020304
        0504040404040506050505050505060607070807070609090A0A09090C0C0C0C
        0C0C0C0C0C0C0C0C0C0C0C01030303050405090606090D0B090B0D0F0E0E0E0E
        0F0F0C0C0C0C0C0F0F0C0C0C0C0C0C0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
        0C0C0C0C0C0C0C0C0C0C0C0CFFC00011080028032003011100021101031101FF
        C4006B0001000301010100000000000000000000000304050208090101010101
        0101010100000000000000000003040502010708100100000505010000000000
        0000000000000181B1C102327203330442110100000701010000000000000000
        000000013181023203044171FFDA000C03010002110311003F00FBCEE3B50000
        0000000CA725A8000000000066726BCF746AE5ECCA3F5A6D939787D000000000
        51F4EB86DBC587A72A2DAE48199400000000050F576436DE2C5D39517D525667
        5000000000107A744375A2CFD38D54D7352615800000000153D5F13B31F5F955
        757AA8C6A80000000022E7EACA554B7E117BB26CF739700000000045CFD594AA
        8F46117BB26CF735700000000045CFD594AA96FC22F764D9EE72E00000000000
        0000000000000000000000000000F603FB2DF9200000000000CA725A80000000
        00066726BCF746AE5ECCA3F5A6D939787D00000000051F4EB86DBC587A72A2DA
        E48199400000000050F576436DE2C5D39517D5256675000000000107A744375A
        2CFD38D54D7352615800000000153D5F13B31F5F955757AA8C6A80000000022E
        7EACA554B7E117BB26CF739700000000045CFD594AA8F46117BB26CF73570000
        0000045CFD594AA96FC22F764D9EE72E00000000000000000000000000000000
        0000000F603FB2DF9200000000000CA725A8000000000066726BCF746AE5ECCA
        3F5A6D939787D00000000051F4EB86DBC587A72A2DAE48199400000000050F57
        6436DE2C5D39517D5256675000000000107A744375A2CFD38D54D73526158000
        00000153D5F13B31F5F955757AA8C6A80000000022E7EACA554B7E117BB26CF7
        39700000000045CFD594AA8F46117BB26CF735700000000045CFD594AA96FC22
        F764D9EE72E000000000000000000000000000000000000000F603FB2DF92000
        00000000CA725A8000000000066726BCF746AE5ECCA3F5A6D939787D00000000
        051F4EB86DBC587A72A2DAE48199400000000050F576436DE2C5D39517D52566
        75000000000107A744375A2CFD38D54D7352615800000000153D5F13B31F5F95
        5757AA8C6A80000000022E7EACA554B7E117BB26CF739700000000045CFD594A
        A8F46117BB26CF735700000000045CFD594AA96FC22F764D9EE72E0000000000
        00000000000000000000000000000F603FB2DF9200000000000CA725A8000000
        000066726BCF746AE5ECCA3F5A6D939787D00000000051F4EB86DBC587A72A2D
        AE48199400000000050F576436DE2C5D39517D5256675000000000107A744375
        A2CFD38D54D7352615800000000153D5F13B31F5F955757AA8C6A80000000022
        E7EACA554B7E117BB26CF739700000000045CFD594AA8F46117BB26CF7357000
        00000045CFD594AA96FC22F764D9EE72E0000000000000000000000000000000
        00000000FFD9}
      Stretch = True
      Transparent = True
    end
    object RxLabTitre: TRxLabel
      Left = 88
      Top = 15
      Width = 246
      Height = 24
      Alignment = taCenter
      Caption = 'Gestion du Plan de Saisie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      Layout = tlBottom
      ParentFont = False
      Transparent = True
    end
  end
  object PaBtn: TPanel
    Left = 0
    Top = 401
    Width = 705
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 3
    OnResize = PaBtnResize
    object BtnAnnuler: TButton
      Left = 32
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
      TabOrder = 3
      OnClick = BtnAnnulerClick
    end
    object BtnEnregistrer: TButton
      Left = 121
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
      OnClick = BtnEnregistrerClick
    end
    object BtnModifier: TButton
      Left = 210
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
      TabOrder = 1
      OnClick = BtnModifierClick
    end
    object BtnFermer: TButton
      Left = 299
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
      TabOrder = 2
      OnClick = BtnFermerClick
    end
    object BtnImprimer: TButton
      Left = 388
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
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 277
    Top = 152
    object pmMenu1: TMenuItem
      Caption = 'Menu'
    end
    object Aideenligne1: TMenuItem
      Caption = 'Aide en li&gne'
      ShortCut = 16496
    end
    object Aide1: TMenuItem
      Caption = '&Aide'
      ShortCut = 112
      OnClick = Aide1Click
    end
    object Visualisation1: TMenuItem
      Caption = '&Visualisation'
      ShortCut = 118
    end
    object Visualisationsurpriode1: TMenuItem
      Caption = 'Visualisation sur p'#233'riode'
      ShortCut = 16502
    end
    object Balance1: TMenuItem
      Caption = 'Balance'
      ShortCut = 16450
    end
    object Imprimer1: TMenuItem
      Caption = 'Im&primer'
      ShortCut = 122
      OnClick = Imprimer1Click
    end
    object Calculatrice1: TMenuItem
      Caption = '&Calculatrice'
      ShortCut = 123
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Enregister1: TMenuItem
      Caption = '&Enregister'
      ShortCut = 114
      OnClick = Enregister1Click
    end
    object Modifier1: TMenuItem
      Caption = '&Modifier'
      ShortCut = 113
      OnClick = Modifier1Click
    end
    object Insrer1: TMenuItem
      Caption = '&Ins'#233'rer'
      ShortCut = 117
    end
    object Supprimer1: TMenuItem
      Caption = '&Supprimer'
      ShortCut = 121
    end
    object Annuler1: TMenuItem
      Caption = '&Annuler'
      ShortCut = 16449
    end
    object Fermer1: TMenuItem
      Caption = '&Fermer'
      ShortCut = 16499
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object Journal1: TMenuItem
      Caption = 'Journal'
      ShortCut = 120
    end
    object TauxTVApardfaut1: TMenuItem
      Caption = 'Taux TVA par d'#233'faut'
      ShortCut = 119
    end
  end
end
