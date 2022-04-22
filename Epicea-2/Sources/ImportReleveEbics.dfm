object ImportationReleveEbics: TImportationReleveEbics
  Left = 442
  Top = 261
  Width = 1229
  Height = 732
  Caption = 'ImportationReleveEbics'
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
    Width = 1213
    Height = 54
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
      Width = 1187
      Height = 28
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
      Left = 60
      Top = 29
      Width = 338
      Height = 24
      Alignment = taCenter
      Caption = 'Importation des relev'#233's de comptes'
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
    Top = 54
    Width = 1213
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
    TabOrder = 0
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 80
    Width = 1213
    Height = 614
    Align = alClient
    TabOrder = 1
    object PaBtn: TPanel
      Left = 1
      Top = 577
      Width = 1211
      Height = 36
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvNone
      Color = 12246236
      TabOrder = 3
      OnResize = PaBtnResize
      object RxLabel1: TRxLabel
        Left = 1
        Top = 1
        Width = 1209
        Height = 34
        Align = alClient
        Caption = 
          'Si vous souhaitez importer une ligne, vous devez la cocher.'#13#10' Au' +
          ' contraire,si vous souhaitez la refuser, vous devez la d'#233'cocher.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMenuHighlight
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 1211
      Height = 43
      Align = alTop
      TabOrder = 0
      object Label9: TLabel
        Left = 408
        Top = 6
        Width = 209
        Height = 30
        AutoSize = False
        Caption = 'date d'#233'but relev'#233' : '
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlBottom
      end
      object Label1: TLabel
        Left = 624
        Top = 6
        Width = 197
        Height = 30
        AutoSize = False
        Caption = 'date fin relev'#233' : '
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlBottom
      end
      object Label6: TLabel
        Left = 12
        Top = 6
        Width = 389
        Height = 30
        AutoSize = False
        Caption = '&Compte Bancaire : '
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlBottom
      end
      object BtnCharger: TButton
        Left = 1055
        Top = 10
        Width = 122
        Height = 25
        Cursor = crHandPoint
        Caption = '&Charger'
        Enabled = False
        TabOrder = 0
        OnClick = BtnChargerClick
      end
      object EdDateDebutReleve: TDateEdit
        Tag = 6
        Left = 522
        Top = 13
        Width = 90
        Height = 21
        CheckOnExit = True
        ClickKey = 112
        DefaultToday = True
        DialogTitle = 'Selectionner une Date'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GlyphKind = gkCustom
        Glyph.Data = {
          76050000424D760500000000000036000000280000001C0000000C0000000100
          2000000000004005000000000000000000000000000000000000FF00FFFFFF00
          FF00FF00FF808080800080808080808080008080808080808000808080808080
          800080808080808080008080808080808000FF00FFFFFF00FF00FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF00FF00FFFFFF00FF000000000000000000800000000000
          0000800000808000000000000080800000000000000000000000800000808080
          8000FF00FF808080800080808080808080008080808080808000808080808080
          800080808080808080008080808080808000808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFF00
          FF00FFFFFFFFFFFFFF00FFFFFFFFFF00FF00FFFFFFFFFFFFFF00FFFFFFFFFF00
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FFFFFF0000000000000000000000
          0000FFFFFF00000000000000000000000000C0C0C0FFFFFFFF00800000808080
          8000FF00FF8080808000FFFFFF80808080008080808080808000FF00FF808080
          80008080808080808000FF00FFFFFFFFFF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00000000FFFFFFFF00FFFFFFC0C0C0C000FFFFFFC0C0C0
          C000000000FFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFF00
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FF00FFFFFF00FF00808080FFFFFF
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FFFFFFFFFFFFFF00000000FFFFFF
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00000000FFFFFFFF00800000808080
          8000FF00FF8080808000FFFFFFFFFF00FF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00808080FFFF00FF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00000000FFFFFFFF00FFFFFF0000000000000000000000
          0000C0C0C0FFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFF00
          FF00808080FFFFFFFF00FF00FF80808080008080808080808000FF00FFFFFF00
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FFFFFF0000000000000000FFFFFF
          FF00FFFFFF0000000000FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00800000808080
          8000FF00FF8080808000FFFFFF8080808000808080FFFFFFFF00FF00FF808080
          8000FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00000000FFFFFFFF00FFFFFF0000000000000000000000
          0000000000FFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFF00
          FF00808080FFFF00FF00FF00FF80808080008080808080808000808080FFFF00
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FFFFFFFFFFFFFF00FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00800000808080
          8000FF00FF8080808000FFFFFFFFFF00FF00FF00FFFFFF00FF00FF00FFFFFF00
          FF00FF00FFFFFF00FF00FF00FFFFFF00FF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFC0C0C0C000C0C0C0C0C0C0C000C0C0C0C0C0C0C000C0C0C0C0C0C0
          C000C0C0C0FFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFF
          FF00808080FFFFFFFF00FF00FFFFFF00FF000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF00FFFFFF00
          FF00FF00FF808080800080808080808080008080808080808000808080808080
          800080808080808080008080808080808000808080FFFF00FF00}
        NumGlyphs = 2
        ParentFont = False
        Weekends = [Sun, Sat]
        YearDigits = dyFour
        TabOrder = 1
        Text = '01/01/2015'
      end
      object EdDateFinReleve: TDateEdit
        Tag = 6
        Left = 718
        Top = 13
        Width = 90
        Height = 21
        CheckOnExit = True
        ClickKey = 112
        DefaultToday = True
        DialogTitle = 'Selectionner une Date'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GlyphKind = gkCustom
        Glyph.Data = {
          76050000424D760500000000000036000000280000001C0000000C0000000100
          2000000000004005000000000000000000000000000000000000FF00FFFFFF00
          FF00FF00FF808080800080808080808080008080808080808000808080808080
          800080808080808080008080808080808000FF00FFFFFF00FF00FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF00FF00FFFFFF00FF000000000000000000800000000000
          0000800000808000000000000080800000000000000000000000800000808080
          8000FF00FF808080800080808080808080008080808080808000808080808080
          800080808080808080008080808080808000808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFF00
          FF00FFFFFFFFFFFFFF00FFFFFFFFFF00FF00FFFFFFFFFFFFFF00FFFFFFFFFF00
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FFFFFF0000000000000000000000
          0000FFFFFF00000000000000000000000000C0C0C0FFFFFFFF00800000808080
          8000FF00FF8080808000FFFFFF80808080008080808080808000FF00FF808080
          80008080808080808000FF00FFFFFFFFFF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00000000FFFFFFFF00FFFFFFC0C0C0C000FFFFFFC0C0C0
          C000000000FFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFF00
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FF00FFFFFF00FF00808080FFFFFF
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FFFFFFFFFFFFFF00000000FFFFFF
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00000000FFFFFFFF00800000808080
          8000FF00FF8080808000FFFFFFFFFF00FF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00808080FFFF00FF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00000000FFFFFFFF00FFFFFF0000000000000000000000
          0000C0C0C0FFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFF00
          FF00808080FFFFFFFF00FF00FF80808080008080808080808000FF00FFFFFF00
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FFFFFF0000000000000000FFFFFF
          FF00FFFFFF0000000000FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00800000808080
          8000FF00FF8080808000FFFFFF8080808000808080FFFFFFFF00FF00FF808080
          8000FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFFFFFFFFF00000000FFFFFFFF00FFFFFF0000000000000000000000
          0000000000FFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFF00
          FF00808080FFFF00FF00FF00FF80808080008080808080808000808080FFFF00
          FF00808080FFFFFFFF00FF00FFFFFF00FF00FFFFFFFFFFFFFF00FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00800000808080
          8000FF00FF8080808000FFFFFFFFFF00FF00FF00FFFFFF00FF00FF00FFFFFF00
          FF00FF00FFFFFF00FF00FF00FFFFFF00FF00808080FFFFFFFF00FF00FFFFFF00
          FF00FFFFFFC0C0C0C000C0C0C0C0C0C0C000C0C0C0C0C0C0C000C0C0C0C0C0C0
          C000C0C0C0FFFFFFFF008000008080808000FF00FF8080808000FFFFFFFFFFFF
          FF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFF
          FF00808080FFFFFFFF00FF00FFFFFF00FF000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF00FFFFFF00
          FF00FF00FF808080800080808080808080008080808080808000808080808080
          800080808080808080008080808080808000808080FFFF00FF00}
        NumGlyphs = 2
        ParentFont = False
        Weekends = [Sun, Sat]
        YearDigits = dyFour
        TabOrder = 2
        Text = '01/01/2015'
      end
      object chDejaReleve: TCheckBox
        Left = 840
        Top = 10
        Width = 97
        Height = 25
        Caption = 'D'#233'j'#224' relev'#233
        Color = 10085887
        ParentColor = False
        TabOrder = 3
      end
      object cbCompteBancaire: TComboBox
        Left = 125
        Top = 13
        Width = 244
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Text = 'Choisir un compte bancaire'
        OnChange = cbCompteBancaireChange
        OnSelect = cbCompteBancaireSelect
      end
      object cbDejaImporte: TCheckBox
        Left = 944
        Top = 10
        Width = 97
        Height = 25
        Caption = 'D'#233'j'#224' import'#233
        Color = 10085887
        ParentColor = False
        TabOrder = 5
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 530
      Width = 1211
      Height = 47
      Align = alBottom
      TabOrder = 2
      OnResize = Panel3Resize
      object PaBtnRefus: TPanel
        Left = 1
        Top = 1
        Width = 488
        Height = 45
        Align = alLeft
        TabOrder = 0
        object BtnTTDecocher: TButton
          Left = 318
          Top = 6
          Width = 122
          Height = 25
          Caption = '&Tout d'#233'cocher'
          TabOrder = 0
          OnClick = BtnTTDecocherClick
        end
        object BtnTTCocher: TButton
          Left = 166
          Top = 6
          Width = 122
          Height = 25
          Caption = 'Tout &cocher'
          TabOrder = 1
          OnClick = BtnTTCocherClick
        end
        object BtnDoublon: TButton
          Left = 14
          Top = 6
          Width = 122
          Height = 25
          Caption = '&D'#233'cocher les doublons'
          TabOrder = 2
          OnClick = BtnDoublonClick
        end
      end
      object PaBtnSupp: TPanel
        Left = 489
        Top = 1
        Width = 721
        Height = 45
        Align = alClient
        TabOrder = 1
        object BtnEnregistrer: TButton
          Left = 145
          Top = 4
          Width = 90
          Height = 37
          Caption = 'Importer [F3]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = BtnEnregistrerClick
        end
        object BtnAnnuler: TButton
          Left = 55
          Top = 4
          Width = 90
          Height = 37
          Caption = 'Annuler'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BtnAnnulerClick
        end
        object BtnCreerReglement: TButton
          Left = 237
          Top = 5
          Width = 160
          Height = 37
          Caption = '&Creation r'#233'glements sur relev'#233
          TabOrder = 2
          OnClick = BtnCreerReglementClick
        end
      end
    end
    object PaEcritures: TPanel
      Left = 1
      Top = 44
      Width = 1211
      Height = 486
      Align = alClient
      Caption = 'PaEcritures'
      TabOrder = 1
      OnResize = PaEcrituresResize
      object PaCptIntit: TPanel
        Left = 1
        Top = 1
        Width = 1209
        Height = 14
        Cursor = crHandPoint
        Align = alTop
        BorderWidth = 2
        Caption = 'Mouvements du relev'#233' '#224' importer'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object Panel5: TPanel
        Left = 1
        Top = 363
        Width = 1209
        Height = 122
        Align = alBottom
        BevelOuter = bvLowered
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 2
        object Label4: TLabel
          Left = 369
          Top = 21
          Width = 92
          Height = 13
          Caption = 'Info suppl'#233'mentaire'
        end
        object Panel11: TPanel
          Left = 1
          Top = 1
          Width = 1207
          Height = 14
          Cursor = crHandPoint
          Align = alTop
          BorderWidth = 2
          Caption = 'Infos suppl'#233'mentaires sur la ligne s'#233'lectionn'#233'e'
          Color = 7396351
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6974005
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object BtnGestionCompte: TButton
          Left = 816
          Top = 19
          Width = 177
          Height = 25
          Cursor = crHandPoint
          Hint = 
            'Vous permet d'#39'acc'#233'der '#224' l'#39#233'cran de param'#232'trage de vos comptes ba' +
            'ncaires'#13#10'et ainsi, de pouvoir affecter un journal de banque '#224' un' +
            ' de vos comptes bancaires.'
          Caption = '&Gestion des comptes bancaires'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BtnGestionCompteClick
        end
        object MemoComplement: TMemo
          Left = 472
          Top = 16
          Width = 329
          Height = 89
          Lines.Strings = (
            'MemoComplement')
          TabOrder = 2
        end
      end
      object Panel9: TPanel
        Left = 1
        Top = 346
        Width = 1209
        Height = 17
        Align = alBottom
        BevelOuter = bvNone
        Color = 12441823
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 3
        object PaSoldeCompte: TPanel
          Left = 0
          Top = 0
          Width = 241
          Height = 17
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = 'Solde '#224' importer :  '
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
        object GrSoldeCompte: TGrGrid
          Left = 241
          Top = 0
          Width = 968
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
        end
      end
      object LVReleve: TListView
        Left = 1
        Top = 15
        Width = 1209
        Height = 280
        Hint = 
          'Les lignes coch'#233'es seront import'#233'es.'#13#10'Si vous souhaitez importer' +
          ' ou refuser une ligne, vous la coch'#233'e ou la d'#233'coch'#233'e.'
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'Accept'#233
            MaxWidth = 20
            Width = 20
          end
          item
            Caption = 'Doublon'
            Width = 55
          end
          item
            Caption = 'Banque'
          end
          item
            Caption = 'Guichet'
          end
          item
            Caption = 'Compte'
            Width = 100
          end
          item
            Caption = 'Date'
            Width = 70
          end
          item
            Alignment = taRightJustify
            Caption = 'Encaissement'
            Width = 100
          end
          item
            Alignment = taRightJustify
            Caption = 'D'#233'caissement'
            Width = 100
          end
          item
            Caption = 'D'#233'signation'
            Width = 300
          end
          item
            Caption = 'R'#233'f'#233'rence'
            Width = 100
          end>
        GridLines = True
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        ShowHint = True
        SortType = stData
        TabOrder = 0
        ViewStyle = vsReport
        OnChange = LVReleveChange
        OnColumnClick = LVReleveColumnClick
        OnCompare = LVReleveCompare
        OnSelectItem = LVReleveSelectItem
      end
      object Panel7: TPanel
        Left = 1
        Top = 329
        Width = 1209
        Height = 17
        Align = alBottom
        BevelOuter = bvNone
        Color = 12441823
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 4
        object PaMouvCompte: TPanel
          Left = 0
          Top = 0
          Width = 241
          Height = 17
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = 'Mouvements '#224' importer :  '
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
        object GrMouvCompte: TGrGrid
          Left = 241
          Top = 0
          Width = 968
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
        end
      end
      object Panel4: TPanel
        Left = 1
        Top = 312
        Width = 1209
        Height = 17
        Align = alBottom
        BevelOuter = bvNone
        Color = 12441823
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 5
        object PaSoldeReleve: TPanel
          Left = 0
          Top = 0
          Width = 241
          Height = 17
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = 'Solde du relev'#233' :  '
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
        object GrSoldeReleve: TGrGrid
          Left = 241
          Top = 0
          Width = 968
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
        end
      end
      object Panel12: TPanel
        Left = 1
        Top = 295
        Width = 1209
        Height = 17
        Align = alBottom
        BevelOuter = bvNone
        Color = 12441823
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 6
        object PaMouvReleve: TPanel
          Left = 0
          Top = 0
          Width = 241
          Height = 17
          Align = alLeft
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = 'Mouvements du relev'#233' :  '
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
        object GrMouvReleve: TGrGrid
          Left = 241
          Top = 0
          Width = 968
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
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 273
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
      OnClick = BtnAnnulerClick
    end
    object Fermer1: TMenuItem
      Caption = '&Fermer'
      ShortCut = 16499
    end
  end
end
