object E2_ComptesBancaires: TE2_ComptesBancaires
  Left = 581
  Top = 257
  Width = 904
  Height = 440
  ActiveControl = grComptesBancaires
  Caption = 'S'#233'lection d'#39'un compte bancaire'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 888
    Height = 65
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
    TabOrder = 0
    object ImEnTete: TImage
      Left = 13
      Top = 13
      Width = 862
      Height = 39
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
      Left = 104
      Top = 39
      Width = 297
      Height = 24
      Alignment = taCenter
      Caption = 'Gestion des comptes bancaires'
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
  object PaTools: TPanel
    Left = 0
    Top = 65
    Width = 888
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
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 91
    Width = 888
    Height = 14
    Align = alTop
    Caption = 'Liste des comptes bancaires'
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6974005
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object PaBas: TPanel
    Left = 0
    Top = 361
    Width = 888
    Height = 41
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 3
  end
  object PaBtn: TPanel
    Left = 0
    Top = 325
    Width = 888
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 4
    OnResize = PaBtnResize
    object BtnAnnuler: TButton
      Left = 81
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Annuler [Esc]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
      OnClick = BtnAnnulerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnEnregistrer: TButton
      Left = 170
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
      TabOrder = 1
      OnClick = BtnEnregistrerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnModifier: TButton
      Left = 259
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
      OnClick = BtnModifierClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnSupprimer: TButton
      Left = 435
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
      OnClick = BtnSupprimerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
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
      ModalResult = 1
      ParentFont = False
      TabOrder = 4
      OnClick = BtnFermerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnInserer: TButton
      Left = 348
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
      TabOrder = 5
      OnClick = BtnInsererClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
  end
  object PaGrille: TPanel
    Left = 0
    Top = 105
    Width = 888
    Height = 220
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 5
    OnResize = PaGrilleResize
    object grComptesBancaires: TGrDBGrid
      Left = 3
      Top = 3
      Width = 878
      Height = 210
      Align = alClient
      BorderStyle = bsNone
      DataSource = DMImportReleve.DaComptesBancaires
      DefaultDrawing = True
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnColEnter = grComptesBancairesColEnter
      OnColExit = grComptesBancairesColExit
      OnDblClick = grComptesBancairesDblClick
      OnKeyPress = grComptesBancairesKeyPress
      ScrollBars = ssHorizontal
      EditColor = clWindow
      DefaultRowHeight = 20
      RowColor1 = cl3DLight
      RowColor2 = clTeal
      AllowAutoAppend = False
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
      Columns = <
        item
          Expanded = False
          FieldName = 'codeBancaire'
          Title.Caption = 'Infos bancaire'
          Width = 10
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'journal'
          Title.Caption = 'Journal de banque'
          Width = 10
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'login'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'password'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'site'
          Width = 50
          Visible = True
        end>
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 197
    Top = 148
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
      Enabled = False
      ShortCut = 118
    end
    object Imprimer1: TMenuItem
      Caption = '&Imprimer'
      Enabled = False
      ShortCut = 122
      Visible = False
    end
    object Exporter1: TMenuItem
      Caption = 'Exporter'
      Enabled = False
      ShortCut = 16453
    end
    object Calculatrice1: TMenuItem
      Caption = '&Calculatrice'
      Enabled = False
      ShortCut = 123
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Enregister1: TMenuItem
      Caption = '&Enregister'
      ShortCut = 114
      OnClick = BtnEnregistrerClick
    end
    object Modifier1: TMenuItem
      Caption = '&Modifier'
      ShortCut = 113
      OnClick = BtnModifierClick
    end
    object Insrer1: TMenuItem
      Caption = '&Ins'#233'rer'
      Enabled = False
      ShortCut = 117
      Visible = False
    end
    object Supprimer1: TMenuItem
      Caption = '&Supprimer'
      ShortCut = 121
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
  end
end
