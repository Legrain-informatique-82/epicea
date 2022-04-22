object BalanceComparative: TBalanceComparative
  Left = 290
  Top = 86
  Width = 662
  Height = 623
  Caption = 'Balances Comparatives'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = PaBtnResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 646
    Height = 28
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 6
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
    object ImEnTete: TImage
      Left = 7
      Top = 7
      Width = 632
      Height = 14
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
      Left = 34
      Top = 8
      Width = 379
      Height = 24
      Alignment = taCenter
      Caption = 'S'#233'lectionnez les exercices '#224' comparer...'
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
  object PaTitrePetit: TPanel
    Left = 0
    Top = 28
    Width = 646
    Height = 14
    Align = alTop
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6974005
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object PaBas: TPanel
    Left = 0
    Top = 42
    Width = 646
    Height = 543
    Align = alClient
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 2
    object PaDateDeb: TPanel
      Left = 1
      Top = 1
      Width = 644
      Height = 541
      Align = alClient
      Color = 12441823
      TabOrder = 0
      object PaBtn: TPanel
        Left = 1
        Top = 444
        Width = 642
        Height = 36
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvNone
        Color = 12441823
        TabOrder = 0
        OnResize = PaBtnResize
        object BtnEnregistrer: TButton
          Left = 318
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
          TabOrder = 0
          OnClick = BtnEnregistrerClick
        end
        object BtnAnnuler: TButton
          Left = 180
          Top = 0
          Width = 90
          Height = 37
          Caption = 'Annuler [Escp]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = BtnAnnulerClick
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 480
        Width = 642
        Height = 60
        Align = alBottom
        BevelOuter = bvLowered
        Color = 12441823
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 1
        Top = 1
        Width = 642
        Height = 343
        Align = alClient
        TabOrder = 2
        object GroupSelect1: TGroupBox
          Left = 1
          Top = 1
          Width = 216
          Height = 341
          Align = alLeft
          Caption = 'Premier Exercice s'#233'lectionn'#233
          Color = 10085887
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 3
            Top = 99
            Width = 205
            Height = 30
            AutoSize = False
            Caption = 'D'#233'but P'#233'riode :'
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
          object Label2: TLabel
            Left = 3
            Top = 134
            Width = 205
            Height = 30
            AutoSize = False
            Caption = 'Fin P'#233'riode :'
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
          object Label7: TLabel
            Left = 16
            Top = 32
            Width = 110
            Height = 13
            Caption = 'Liste des exercices'
          end
          object Combo1: TComboBox
            Left = 16
            Top = 48
            Width = 145
            Height = 21
            ItemHeight = 13
            TabOrder = 0
            OnKeyDown = Combo1KeyDown
            OnSelect = Combo1Select
          end
          object MemoInfDof1: TRichEdit
            Left = 2
            Top = 196
            Width = 212
            Height = 143
            TabStop = False
            Align = alBottom
            BorderStyle = bsNone
            Color = clInfoBk
            Enabled = False
            ReadOnly = True
            TabOrder = 3
          end
          object EditDebutPer1: TDateEdit
            Left = 110
            Top = 108
            Width = 98
            Height = 21
            ClickKey = 112
            Ctl3D = False
            DialogTitle = 'D'#233'but P'#233'riode'
            NumGlyphs = 2
            ParentCtl3D = False
            TabOrder = 1
            OnAcceptDate = EditDebutPer1AcceptDate
            OnExit = EditDebutPer1Exit
          end
          object EditFinPer1: TDateEdit
            Left = 110
            Top = 144
            Width = 98
            Height = 21
            ClickKey = 112
            Ctl3D = False
            DialogTitle = 'Fin P'#233'riode'
            NumGlyphs = 2
            ParentCtl3D = False
            TabOrder = 2
            OnAcceptDate = EditFinPer1AcceptDate
            OnExit = EditFinPer1Exit
          end
        end
        object GroupSelect3: TGroupBox
          Left = 433
          Top = 1
          Width = 208
          Height = 341
          Align = alClient
          Caption = 'Troisi'#232'me Exercice s'#233'lectionn'#233
          Color = 10085887
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 2
          object Label3: TLabel
            Left = 3
            Top = 99
            Width = 205
            Height = 30
            AutoSize = False
            Caption = 'D'#233'but P'#233'riode :'
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
          object Label4: TLabel
            Left = 3
            Top = 134
            Width = 205
            Height = 30
            AutoSize = False
            Caption = 'Fin P'#233'riode :'
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
          object Label9: TLabel
            Left = 16
            Top = 32
            Width = 110
            Height = 13
            Caption = 'Liste des exercices'
          end
          object Combo3: TComboBox
            Left = 16
            Top = 48
            Width = 145
            Height = 21
            ItemHeight = 13
            TabOrder = 0
            OnKeyDown = Combo1KeyDown
            OnSelect = Combo3Select
          end
          object MemoInfDof3: TRichEdit
            Left = 2
            Top = 196
            Width = 204
            Height = 143
            TabStop = False
            Align = alBottom
            BorderStyle = bsNone
            Color = clInfoBk
            Enabled = False
            ReadOnly = True
            TabOrder = 3
          end
          object EditDebutPer3: TDateEdit
            Left = 110
            Top = 108
            Width = 98
            Height = 21
            ClickKey = 112
            Ctl3D = False
            DialogTitle = 'D'#233'but P'#233'riode'
            NumGlyphs = 2
            ParentCtl3D = False
            TabOrder = 1
            OnAcceptDate = EditDebutPer3AcceptDate
            OnExit = EditDebutPer3Exit
          end
          object EditFinPer3: TDateEdit
            Left = 110
            Top = 144
            Width = 98
            Height = 21
            ClickKey = 112
            Ctl3D = False
            DialogTitle = 'Fin P'#233'riode'
            NumGlyphs = 2
            ParentCtl3D = False
            TabOrder = 2
            OnAcceptDate = EditFinPer3AcceptDate
            OnExit = EditFinPer3Exit
          end
        end
        object GroupSelect2: TGroupBox
          Left = 217
          Top = 1
          Width = 216
          Height = 341
          Align = alLeft
          Caption = 'Deuxi'#232'me Exercice s'#233'lectionn'#233
          Color = 10085887
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 1
          object Label5: TLabel
            Left = 3
            Top = 99
            Width = 205
            Height = 30
            AutoSize = False
            Caption = 'D'#233'but P'#233'riode :'
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
            Left = 3
            Top = 134
            Width = 205
            Height = 30
            AutoSize = False
            Caption = 'Fin P'#233'riode :'
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
          object Label8: TLabel
            Left = 16
            Top = 32
            Width = 110
            Height = 13
            Caption = 'Liste des exercices'
          end
          object Combo2: TComboBox
            Left = 16
            Top = 48
            Width = 145
            Height = 21
            ItemHeight = 13
            TabOrder = 0
            OnKeyDown = Combo1KeyDown
            OnSelect = Combo2Select
          end
          object MemoInfDof2: TRichEdit
            Left = 2
            Top = 196
            Width = 212
            Height = 143
            TabStop = False
            Align = alBottom
            BorderStyle = bsNone
            Color = clInfoBk
            Enabled = False
            ReadOnly = True
            TabOrder = 3
          end
          object EditDebutPer2: TDateEdit
            Left = 110
            Top = 108
            Width = 98
            Height = 21
            ClickKey = 112
            Ctl3D = False
            DialogTitle = 'D'#233'but P'#233'riode'
            NumGlyphs = 2
            ParentCtl3D = False
            TabOrder = 1
            OnAcceptDate = EditDebutPer2AcceptDate
            OnExit = EditDebutPer2Exit
          end
          object EditFinPer2: TDateEdit
            Left = 110
            Top = 144
            Width = 98
            Height = 21
            ClickKey = 112
            Ctl3D = False
            DialogTitle = 'Fin P'#233'riode'
            NumGlyphs = 2
            ParentCtl3D = False
            TabOrder = 2
            OnAcceptDate = EditFinPer2AcceptDate
            OnExit = EditFinPer2Exit
          end
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 344
        Width = 642
        Height = 100
        Align = alBottom
        TabOrder = 3
        object groupeReport: TRadioGroup
          Left = 289
          Top = 1
          Width = 184
          Height = 98
          Align = alLeft
          Caption = 'Gestion des reports'
          Color = 10085887
          ItemIndex = 0
          Items.Strings = (
            'Sans les reports'
            'Avec les reports')
          ParentColor = False
          TabOrder = 1
        end
        object cb1a5: TRadioGroup
          Left = 1
          Top = 1
          Width = 288
          Height = 98
          Align = alLeft
          Caption = 'Selection des comptes'
          Color = 10085887
          ItemIndex = 0
          Items.Strings = (
            'comptes de 1 '#224' 5'
            'comptes 6 et 7'
            'Tous')
          ParentColor = False
          TabOrder = 0
        end
        object GroupBox1: TGroupBox
          Left = 473
          Top = 1
          Width = 168
          Height = 98
          Align = alClient
          Caption = 'Variation du compte'
          Color = 10085887
          ParentColor = False
          TabOrder = 2
          object GroupVariation: TCheckBox
            Left = 16
            Top = 40
            Width = 129
            Height = 17
            Caption = 'En valeur absolue'
            TabOrder = 0
          end
        end
      end
    end
  end
end
