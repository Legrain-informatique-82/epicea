object Utilisation_Deductions: TUtilisation_Deductions
  Left = 269
  Top = 235
  Width = 870
  Height = 640
  ActiveControl = DBUtilisationDeductions
  Caption = 'Utilisation_Deductions'
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
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 65
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 12
    Color = 15269887
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
    object ImEnTete: TImage
      Left = 13
      Top = 13
      Width = 836
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
      Left = 128
      Top = 39
      Width = 464
      Height = 24
      Alignment = taCenter
      Caption = 'Utilisations des d'#233'ductions pour investissements'
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
    Width = 862
    Height = 26
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 15269887
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
      OnClick = RxSBInfoVersionClick
    end
  end
  object PaBas: TPanel
    Left = 0
    Top = 559
    Width = 862
    Height = 47
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 2
  end
  object PaBtn: TPanel
    Left = 0
    Top = 523
    Width = 862
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 3
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
      TabOrder = 6
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
      OnClick = BtnEnregistrerClick
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
      OnClick = BtnModifierClick
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
      OnClick = BtnInsererClick
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
      OnClick = BtnSupprimerClick
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
      TabOrder = 4
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
      OnClick = BtnImprimerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
  end
  object PaCumul1: TPanel
    Left = 0
    Top = 489
    Width = 862
    Height = 17
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'PaCumul1'
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 4
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 289
      Height = 17
      Align = alLeft
      Alignment = taRightJustify
      BevelOuter = bvNone
      Caption = 'Totaux :  '
      Color = 12441823
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object GrGridTotaux: TGrGrid
      Left = 289
      Top = 0
      Width = 573
      Height = 17
      TabStop = False
      Align = alClient
      Ctl3D = False
      Enabled = False
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 1
      NumDecimal = 2
      AjoutAuto = False
      ColWidths = (
        64
        64
        64
        64
        64)
    end
  end
  object PaGrille: TPanel
    Left = 0
    Top = 91
    Width = 862
    Height = 398
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 5
    OnResize = PaGrilleResize
    object DBUtilisationDeductions: TGrDBGrid
      Left = 3
      Top = 44
      Width = 852
      Height = 347
      Align = alClient
      BorderStyle = bsNone
      DataSource = DMDeduction.DataUtilisation_deduc
      DefaultDrawing = True
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBUtilisationDeductionsCellClick
      OnColExit = DBUtilisationDeductionsColExit
      OnKeyDown = DBUtilisationDeductionsKeyDown
      OnKeyPress = DBUtilisationDeductionsKeyPress
      ScrollBars = ssHorizontal
      EditColor = clWindow
      DefaultRowHeight = 17
      GridAutoSize = True
      FullSizeMemo = True
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
      LockedColor = clBtnFace
      ShowMemoEllipsis = True
      NumDecimal = 2
      Columns = <
        item
          Expanded = False
          FieldName = 'Exercice'
          PickList.Strings = (
            'N'
            'N-1'
            'N-2'
            'N-3'
            'N-4')
          Title.Caption = 'exercice'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Mt_immo'
          Title.Caption = 'Immobilisation'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Mt_social'
          Title.Caption = 'Part sociale'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Mt_stocks'
          Title.Caption = 'Stocks'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TotalUtilise'
          Title.Caption = 'Total utilis'#233
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Reinteg_except'
          Title.Caption = 'R'#233'int'#233'g. exceptionnelle'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Libelle_Reinteg'
          Title.Caption = 'Libell'#233
          Width = 200
          Visible = True
        end>
    end
    object PaLabel: TPanel
      Left = 3
      Top = 3
      Width = 852
      Height = 41
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 1
      object PaTitreG: TPanel
        Left = 1
        Top = 1
        Width = 850
        Height = 39
        Align = alClient
        BevelOuter = bvNone
        Color = 12441823
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object Label1: TLabel
          Left = 20
          Top = 17
          Width = 71
          Height = 13
          Caption = '&D'#233'duction : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LaLibelleDeduction: TLabel
          Left = 94
          Top = 17
          Width = 80
          Height = 13
          Caption = 'Libell'#233' d'#233'duction'
        end
        object Label3: TLabel
          Left = 318
          Top = 17
          Width = 146
          Height = 13
          Caption = 'Pratiqu'#233'e sur l'#39'exercice : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LaExerciceDeduction: TLabel
          Left = 472
          Top = 17
          Width = 41
          Height = 13
          Caption = 'Exercice'
        end
        object Label2: TLabel
          Left = 622
          Top = 17
          Width = 93
          Height = 13
          Caption = 'Montant initial : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LaMontantInitial: TLabel
          Left = 718
          Top = 17
          Width = 6
          Height = 13
          Caption = '0'
        end
      end
    end
  end
  object PaReste: TPanel
    Left = 0
    Top = 506
    Width = 862
    Height = 17
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'PaCumul1'
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 6
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 289
      Height = 17
      Align = alLeft
      Alignment = taRightJustify
      BevelOuter = bvNone
      Caption = 'Reste '#224' utiliser :  '
      Color = 12441823
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object GrGridReste: TGrGrid
      Left = 289
      Top = 0
      Width = 573
      Height = 17
      TabStop = False
      Align = alClient
      ColCount = 2
      Ctl3D = False
      Enabled = False
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 1
      NumDecimal = 2
      AjoutAuto = False
      ColWidths = (
        64
        64)
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 301
    Top = 216
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
      OnClick = Aide1Click
    end
    object Visualisation1: TMenuItem
      Caption = '&Visualisation'
      ShortCut = 118
    end
    object Imprimer1: TMenuItem
      Caption = '&Imprimer'
      ShortCut = 122
      OnClick = BtnImprimerClick
    end
    object Exporter1: TMenuItem
      Caption = 'Exporter'
      ShortCut = 16453
      OnClick = Exporter1Click
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
      ShortCut = 117
      OnClick = BtnInsererClick
    end
    object Supprimer1: TMenuItem
      Caption = '&Supprimer'
      ShortCut = 121
      OnClick = BtnSupprimerClick
    end
    object Annuler1: TMenuItem
      Caption = '&Annuler'
      ShortCut = 16449
      OnClick = BtnAnnulerClick
    end
    object Fermer1: TMenuItem
      Caption = '&Fermer'
      ShortCut = 16499
      OnClick = BtnFermerClick
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
