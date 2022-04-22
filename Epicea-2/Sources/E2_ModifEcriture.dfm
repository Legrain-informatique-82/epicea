object ModifEcriture: TModifEcriture
  Left = 271
  Top = 248
  Width = 775
  Height = 485
  Caption = 'Modification Ecriture'
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 767
    Height = 65
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 12
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
    object ImEnTete: TImage
      Left = 13
      Top = 13
      Width = 741
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
      Width = 251
      Height = 24
      Alignment = taCenter
      Caption = 'Modification des Ecritures'
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
  object PaGrille: TPanel
    Left = 0
    Top = 65
    Width = 767
    Height = 218
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 1
    OnResize = PaGrilleResize
    object GrGrid1: TGrGrid
      Left = 3
      Top = 3
      Width = 757
      Height = 208
      Align = alClient
      ColCount = 8
      RowCount = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnDrawCell = GrGrid1DrawCell
      NumDecimal = 2
      OnColExit = GrGrid1ColExit
      OnRowEnter = GrGrid1RowEnter
      OnRowExit = GrGrid1RowExit
      OnChange = GrGrid1Change
      AjoutAuto = False
      ColWidths = (
        0
        64
        64
        64
        64
        64
        64
        64)
    end
  end
  object PaBtn: TPanel
    Left = 0
    Top = 325
    Width = 767
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = PaBtnResize
    object BtnEnregistrer: TButton
      Left = 342
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Enregistrer [F3]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = BtnEnregistrerClick
    end
    object BtnFermer: TButton
      Left = 521
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Fermer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      OnClick = BtnFermerClick
    end
    object BtnImprimer: TButton
      Left = 610
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
      TabOrder = 2
      OnClick = BtnImprimerClick
    end
    object BtnAnnuler: TButton
      Left = 164
      Top = -1
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
      TabOrder = 3
      OnClick = BtnAnnulerClick
    end
    object BtnInserer: TButton
      Left = 253
      Top = -1
      Width = 90
      Height = 37
      Caption = 'Ins'#233'rer [F6]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BtnInsererClick
    end
    object BtnSupprimer: TButton
      Left = 431
      Top = -1
      Width = 90
      Height = 37
      Caption = 'Supprimer [F10]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BtnSupprimerClick
    end
  end
  object PaBas: TPanel
    Left = 0
    Top = 361
    Width = 767
    Height = 90
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 3
    object Panel1: TPanel
      Left = 1
      Top = 17
      Width = 400
      Height = 72
      Align = alLeft
      BevelInner = bvLowered
      TabOrder = 0
      object Label17: TLabel
        Left = 2
        Top = 2
        Width = 396
        Height = 68
        Align = alClient
        AutoSize = False
        Caption = ' Tva ligne : '
        Color = 10085887
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label5: TLabel
        Left = 8
        Top = 30
        Width = 68
        Height = 13
        Caption = 'Code Tva  :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label6: TLabel
        Left = 8
        Top = 46
        Width = 63
        Height = 13
        Caption = 'Type Tva :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object LaCode: TLabel
        Left = 81
        Top = 30
        Width = 24
        Height = 13
        Caption = #163#163#163#163
        Color = 10085887
        ParentColor = False
      end
      object LaType: TLabel
        Left = 81
        Top = 46
        Width = 24
        Height = 13
        Caption = #163#163#163#163
        Color = 10085887
        ParentColor = False
      end
      object Label7: TLabel
        Left = 112
        Top = 30
        Width = 66
        Height = 13
        Caption = 'Date Tva  :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object LaDateTva: TLabel
        Left = 185
        Top = 31
        Width = 24
        Height = 13
        Caption = #163#163#163#163
        Color = 10085887
        ParentColor = False
      end
      object Label8: TLabel
        Left = 112
        Top = 46
        Width = 63
        Height = 13
        Caption = 'Taux Tva :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object LaTaux: TLabel
        Left = 185
        Top = 47
        Width = 24
        Height = 13
        Caption = #163#163#163#163
        Color = 10085887
        ParentColor = False
      end
      object Label2: TLabel
        Left = 8
        Top = 65
        Width = 84
        Height = 13
        Caption = 'Compte Plan  :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object LaComptePlan: TLabel
        Left = 105
        Top = 65
        Width = 24
        Height = 13
        Caption = #163#163#163#163
        Color = 10085887
        ParentColor = False
        Visible = False
      end
      object Label11: TLabel
        Left = 216
        Top = 65
        Width = 41
        Height = 13
        Caption = 'Tiers  :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object LaTiers: TLabel
        Left = 271
        Top = 65
        Width = 24
        Height = 13
        Caption = #163#163#163#163
        Color = 10085887
        ParentColor = False
        Visible = False
      end
    end
    object Panel3: TPanel
      Left = 401
      Top = 17
      Width = 365
      Height = 72
      Align = alClient
      BevelInner = bvLowered
      Caption = 'Panel3'
      TabOrder = 1
      object Label3: TLabel
        Left = 2
        Top = 2
        Width = 361
        Height = 68
        Align = alClient
        AutoSize = False
        Caption = '  Infos compl'#233'mentaires : '
        Color = 10085887
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object LaDecrite: TLabel
        Left = 212
        Top = 52
        Width = 20
        Height = 13
        Caption = 'Non'
        Color = 10085887
        ParentColor = False
      end
      object LaDeclaree: TLabel
        Left = 212
        Top = 38
        Width = 20
        Height = 13
        Caption = 'Non'
        Color = 10085887
        ParentColor = False
      end
      object LaPointee: TLabel
        Left = 212
        Top = 23
        Width = 20
        Height = 13
        Caption = 'Non'
        Color = 10085887
        ParentColor = False
      end
      object Label12: TLabel
        Left = 11
        Top = 52
        Width = 189
        Height = 13
        Caption = 'D'#233'crite dans les immobilisations :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label10: TLabel
        Left = 11
        Top = 37
        Width = 93
        Height = 13
        Caption = 'Ligne d'#233'clar'#233'e :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label1: TLabel
        Left = 11
        Top = 22
        Width = 90
        Height = 13
        Caption = 'Ligne point'#233'e  :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 765
      Height = 16
      Align = alTop
      BevelOuter = bvLowered
      Caption = ' Infos ligne:'
      Color = 7396351
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6974005
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label19: TLabel
        Left = 188
        Top = 1
        Width = 60
        Height = 13
        Caption = '                    '
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object PaCumul1: TPanel
    Left = 0
    Top = 304
    Width = 767
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 4
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 200
      Height = 21
      Align = alLeft
      Alignment = taRightJustify
      BevelOuter = bvNone
      Caption = 'Montant '#233'criture initiale :'
      Color = 12441823
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object GrGrid3: TGrGrid
      Left = 200
      Top = 0
      Width = 567
      Height = 21
      Align = alClient
      ColCount = 3
      Ctl3D = False
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentCtl3D = False
      TabOrder = 1
      NumDecimal = 2
      AjoutAuto = False
    end
  end
  object PaCumul2: TPanel
    Left = 0
    Top = 283
    Width = 767
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 5
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 200
      Height = 21
      Align = alLeft
      Alignment = taRightJustify
      BevelOuter = bvNone
      Caption = 'Totaux : '
      Color = 12441823
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      object Gauge1: TGauge
        Left = 1
        Top = 4
        Width = 150
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        MaxValue = 1000
        ParentFont = False
        Progress = 0
        Visible = False
      end
    end
    object GrGrid2: TGrGrid
      Left = 200
      Top = 0
      Width = 567
      Height = 21
      Align = alClient
      ColCount = 3
      Ctl3D = False
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentCtl3D = False
      TabOrder = 1
      OnDrawCell = GrGrid2DrawCell
      NumDecimal = 2
      AjoutAuto = False
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 477
    Top = 88
    object pmMenu1: TMenuItem
      Caption = 'Menu'
    end
    object Aide1: TMenuItem
      Caption = '&Aide'
      ShortCut = 112
      OnClick = Aide1Click
    end
    object AidesaisiemontantRestant: TMenuItem
      Caption = 'Aide saisie montant Restant'
      ShortCut = 16496
      OnClick = MontantRestantClick
    end
    object infoscomplmentaires1: TMenuItem
      Caption = 'infos compl'#233'mentaires'
      ShortCut = 16502
      OnClick = infoscomplmentaires1Click
    end
    object Visualisation1: TMenuItem
      Caption = '&Visualisation'
      ShortCut = 118
    end
    object Imprimer1: TMenuItem
      Caption = 'Im&primer'
      ShortCut = 122
    end
    object Calculatrice1: TMenuItem
      Caption = '&Calculatrice'
      ShortCut = 123
      OnClick = Calculatrice1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Complmentligne1: TMenuItem
      Caption = 'Compl'#233'ment ligne'
      ShortCut = 119
      OnClick = Complmentligne1Click
    end
    object Enregister1: TMenuItem
      Caption = '&Enregister'
      ShortCut = 114
      OnClick = BtnEnregistrerClick
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
