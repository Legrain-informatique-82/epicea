object IBRech: TIBRech
  Left = 305
  Top = 320
  Width = 749
  Height = 349
  ActiveControl = edRecherche
  Caption = 'Recherche'
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaPTitre: TPanel
    Left = 0
    Top = 26
    Width = 741
    Height = 14
    Align = alTop
    Caption = 'Recherche'
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6974005
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object PaTools: TPanel
    Left = 0
    Top = 0
    Width = 741
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
    TabOrder = 1
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
      Visible = False
    end
    object RxSBImport: TRxSpeedButton
      Left = 52
      Top = 2
      Width = 25
      Height = 22
      Cursor = crHandPoint
      Hint = 'Importer les stocks d'#39'Epic'#233'a-2 DOS'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
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
      ParentFont = False
      Transparent = True
      Visible = False
    end
  end
  object PaBtn: TPanel
    Left = 0
    Top = 242
    Width = 741
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 2
    object BtnAnnuler: TButton
      Left = 80
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      OnClick = BtnAnnulerClick
    end
    object BtnValider: TButton
      Left = 169
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Valider [F3]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = BtnValiderClick
    end
    object BtnModifier: TButton
      Left = 258
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      OnClick = BtnModifierClick
    end
    object BtnInserer: TButton
      Left = 347
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = BtnInsererClick
    end
    object BtnSupprimer: TButton
      Left = 436
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      OnClick = BtnSupprimerClick
    end
    object BtnFermer: TButton
      Left = 525
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = False
      OnClick = BtnFermerClick
    end
    object BtnImprimer: TButton
      Left = 614
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      TabStop = False
      OnClick = BtnImprimerClick
    end
  end
  object PaBas: TPanel
    Left = 0
    Top = 278
    Width = 741
    Height = 44
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 3
    TabStop = True
    object LaNomChampRech: TLabel
      Left = 232
      Top = 16
      Width = 82
      Height = 13
      Caption = 'Rechercher sur : '
    end
    object LaValRech: TLabel
      Left = 16
      Top = 16
      Width = 65
      Height = 13
      Caption = 'Rechercher : '
    end
    object CBChampRech: TComboBox
      Left = 320
      Top = 14
      Width = 145
      Height = 21
      Style = csDropDownList
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 1
      OnSelect = CBChampRechSelect
    end
    object edRecherche: TEdit
      Left = 87
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'edRecherche'
      OnKeyPress = edRechercheKeyPress
    end
  end
  object TCRech: TTabControl
    Left = 0
    Top = 40
    Width = 741
    Height = 202
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 4
    Tabs.Strings = (
      'ta1'
      'ta2'
      'ta3')
    TabIndex = 0
    TabStop = False
    OnChange = TCRechChange
    OnChanging = TCRechChanging
    object PaGrille: TPanel
      Left = 4
      Top = 27
      Width = 733
      Height = 171
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 2
      BorderStyle = bsSingle
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object DBRech: TGrDBGrid
        Left = 3
        Top = 3
        Width = 725
        Height = 163
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Ctl3D = True
        DataSource = DMIBRech.ds_Rech
        DefaultDrawing = True
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        ScrollBars = ssHorizontal
        EditColor = clWindow
        DefaultRowHeight = 20
        RowSizingAllowed = True
        RowColor1 = cl3DLight
        RowColor2 = clTeal
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
        NumDecimal = 2
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 107
    Top = 113
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
    end
    object Imprimer1: TMenuItem
      Caption = 'Im&primer'
      ShortCut = 122
      OnClick = Imprimer1Click
    end
    object Imprimerstockcourant1: TMenuItem
      Caption = 'Imprimer stock courant'
      ShortCut = 16506
    end
    object Calculatrice1: TMenuItem
      Caption = '&Calculatrice'
      ShortCut = 123
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Enregister1: TMenuItem
      Caption = '&Valider'
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
      OnClick = Insrer1Click
    end
    object Supprimer1: TMenuItem
      Caption = '&Supprimer'
      ShortCut = 121
      OnClick = Supprimer1Click
    end
    object Annuler1: TMenuItem
      Caption = '&Annuler'
      ShortCut = 16449
      OnClick = BtnAnnulerClick
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
