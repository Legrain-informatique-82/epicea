object U_ChoixParametreFEC: TU_ChoixParametreFEC
  Left = 793
  Top = 450
  Width = 529
  Height = 273
  Caption = 'U_ChoixParametreFEC'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PaBas: TPanel
    Left = 0
    Top = 42
    Width = 513
    Height = 193
    Align = alClient
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 0
    object PaDateDeb: TPanel
      Left = 1
      Top = 1
      Width = 511
      Height = 191
      Align = alClient
      Color = 12441823
      TabOrder = 0
      object LaRepertoire: TLabel
        Left = 16
        Top = 24
        Width = 94
        Height = 13
        Caption = 'Choix du s'#233'parateur'
      end
      object Label1: TLabel
        Left = 16
        Top = 59
        Width = 93
        Height = 13
        Caption = 'Choix de l'#39'extension'
      end
      object PaBtn: TPanel
        Left = 1
        Top = 154
        Width = 509
        Height = 36
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvNone
        Color = 12441823
        TabOrder = 0
        object BtnEnregistrer: TButton
          Left = 158
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
          Left = 44
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
      object CheckBoxDatePiece: TCheckBox
        Left = 16
        Top = 101
        Width = 257
        Height = 21
        Caption = 'Copier "PieceDate" dans "EcritureDate"'
        TabOrder = 1
      end
      object CbSeparteur: TComboBox
        Left = 128
        Top = 24
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = 'Choisir le s'#233'parteur'
        Items.Strings = (
          ';'
          'Tab'
          '|')
      end
      object CbExtension: TComboBox
        Left = 128
        Top = 56
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Text = 'Choisir l'#39'extension'
        Items.Strings = (
          '.csv'
          '.txt')
      end
      object btnSauverParam: TButton
        Left = 342
        Top = 40
        Width = 123
        Height = 25
        Caption = 'Sauver les param'#232'tres'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnSauverParamClick
      end
    end
  end
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 513
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
      Width = 499
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
      Top = 4
      Width = 361
      Height = 24
      Alignment = taCenter
      Caption = 'S'#233'lectionnez les param'#232'tres du FEC...'
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
    Width = 513
    Height = 14
    Align = alTop
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
