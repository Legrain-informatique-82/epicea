object Calcul_Resultat: TCalcul_Resultat
  Left = 565
  Top = 284
  Width = 300
  Height = 390
  Caption = 'R'#233'sultat'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 14
    Top = 20
    Width = 259
    Height = 89
    AutoSize = False
    Caption = 
      'Vous avez un solde  sur le compte..............'#13#10'Que voulez-vous' +
      ' en faire ?'
    Color = 10085887
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object PaBtn: TPanel
    Left = 0
    Top = 311
    Width = 284
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12246236
    TabOrder = 0
    object BtnAnnuler: TButton
      Left = 40
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnAnnulerClick
    end
    object BtnEnregistrer: TButton
      Left = 161
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Valider [F3]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnEnregistrerClick
    end
  end
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 284
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
    TabOrder = 1
    object ImEnTete: TImage
      Left = 7
      Top = 7
      Width = 270
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
      Left = 42
      Top = 8
      Width = 80
      Height = 24
      Alignment = taCenter
      Caption = 'R'#233'sultat'
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
  object Panel4: TPanel
    Left = 0
    Top = 28
    Width = 284
    Height = 283
    Align = alClient
    TabOrder = 2
    object Label4: TLabel
      Left = 10
      Top = 254
      Width = 246
      Height = 26
      Caption = 
        'Les b'#233'n'#233'fices sont affect'#233's au compte 120'#13#10'Les pertes sont affec' +
        't'#233'es au compte 129'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 10
      Top = 235
      Width = 95
      Height = 13
      Caption = 'R'#232'gle g'#233'n'#233'rale :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Panel1: TPanel
      Left = 1
      Top = -1
      Width = 288
      Height = 117
      BevelInner = bvLowered
      BorderWidth = 1
      Color = 12246236
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object TLabel
        Left = 66
        Top = 15
        Width = 7
        Height = 20
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 14
        Top = 20
        Width = 259
        Height = 89
        AutoSize = False
        Caption = 'Le r'#233'sultat de l'#39'exercice est '#233'gal '#224' :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label12: TLabel
        Left = 188
        Top = 60
        Width = 27
        Height = 13
        Caption = 'Cr'#233'dit'
        Transparent = True
      end
      object Label11: TLabel
        Left = 84
        Top = 60
        Width = 25
        Height = 13
        Caption = 'D'#233'bit'
        Transparent = True
      end
      object Shape3: TShape
        Left = 139
        Top = 62
        Width = 1
        Height = 39
      end
      object Shape4: TShape
        Left = 25
        Top = 75
        Width = 231
        Height = 1
      end
      object SoldeDebit1: TCurrencyEdit
        Left = 26
        Top = 80
        Width = 109
        Height = 21
        TabStop = False
        AutoSize = False
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object SoldeCredit1: TCurrencyEdit
        Left = 144
        Top = 80
        Width = 109
        Height = 21
        TabStop = False
        AutoSize = False
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object PaSoldeFin1: TPanel
        Left = 3
        Top = 3
        Width = 282
        Height = 14
        Align = alTop
        Caption = 'Calcul du r'#233'sultat'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 115
      Width = 288
      Height = 117
      BevelInner = bvLowered
      BorderWidth = 1
      Color = 12246236
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      object TLabel
        Left = 66
        Top = 15
        Width = 7
        Height = 20
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 14
        Top = 20
        Width = 259
        Height = 89
        AutoSize = False
        Caption = 
          'Indiquez le compte dans lequel vous voulez '#13#10'que ce r'#233'sultat soi' +
          't enregistr'#233' :'
        Color = 10085887
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Libelle: TLabel
        Left = 47
        Top = 91
        Width = 3
        Height = 13
        Layout = tlCenter
      end
      object PaSoldeFin3: TPanel
        Left = 3
        Top = 3
        Width = 282
        Height = 14
        Align = alTop
        Caption = 'Compte de r'#233'sultat'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object EdCompte: TEdit
        Left = 77
        Top = 64
        Width = 121
        Height = 19
        TabOrder = 1
        OnChange = EdCompteChange
        OnExit = EdCompteExit
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 213
    Top = 24
    object pmMenu1: TMenuItem
      Caption = 'Menu'
    end
    object MenuItem1: TMenuItem
      Caption = 'Aide en li&gne'
      ShortCut = 16496
    end
    object MenuItem2: TMenuItem
      Caption = '&Aide'
      ShortCut = 112
      OnClick = MenuItem2Click
    end
    object Visualisation1: TMenuItem
      Caption = '&Visualisation'
      ShortCut = 118
    end
    object Calculatrice1: TMenuItem
      Caption = '&Calculatrice'
      ShortCut = 123
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object Enregister1: TMenuItem
      Caption = '&Enregister'
      ShortCut = 114
      OnClick = BtnEnregistrerClick
    end
    object MenuItem8: TMenuItem
      Caption = '&Annuler'
      ShortCut = 16449
      OnClick = BtnAnnulerClick
    end
  end
end
