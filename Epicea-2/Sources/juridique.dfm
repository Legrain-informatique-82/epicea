object InfosJuridiques: TInfosJuridiques
  Left = 644
  Top = 374
  Width = 495
  Height = 251
  Caption = 'InfosJuridiques'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RxLabNomSoc: TRxLabel
    Left = 0
    Top = 57
    Width = 476
    Height = 30
    AutoSize = False
    Caption = 'Num'#233'ro Siret :'
    Color = 10085887
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Layout = tlBottom
    ParentColor = False
    ParentFont = False
    ShadowColor = clHighlightText
    ShadowSize = 0
  end
  object RxLabel1: TRxLabel
    Left = 0
    Top = 90
    Width = 476
    Height = 30
    AutoSize = False
    Caption = 'Tva intracommunautaire :'
    Color = 10085887
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Layout = tlBottom
    ParentColor = False
    ParentFont = False
    ShadowColor = clHighlightText
    ShadowSize = 0
  end
  object RxLabel2: TRxLabel
    Left = 0
    Top = 123
    Width = 476
    Height = 30
    AutoSize = False
    Caption = 'Sigle mon'#233'taire :'
    Color = 10085887
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Layout = tlBottom
    ParentColor = False
    ParentFont = False
    ShadowColor = clHighlightText
    ShadowSize = 0
  end
  object PaBtn: TPanel
    Left = 0
    Top = 158
    Width = 479
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 0
    object BtnAnnuler: TButton
      Left = 129
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
    end
    object BtnEnregistrer: TButton
      Left = 234
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
      TabOrder = 1
      OnClick = BtnEnregistrerClick
    end
  end
  object PaBas: TPanel
    Left = 0
    Top = 194
    Width = 479
    Height = 19
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 1
  end
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 479
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
      Width = 453
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
      Width = 341
      Height = 24
      Alignment = taCenter
      Caption = 'Infos compl'#233'mentaires et juridiques'
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
  object DBEdit1: TDBEdit
    Left = 152
    Top = 61
    Width = 300
    Height = 21
    DataField = 'siret'
    DataSource = DMParamEntreprise.DaInfosJuridique
    TabOrder = 3
  end
  object DBEdit2: TDBEdit
    Left = 152
    Top = 94
    Width = 300
    Height = 21
    DataField = 'tva_intra'
    DataSource = DMParamEntreprise.DaInfosJuridique
    TabOrder = 4
  end
  object DBEdit3: TDBEdit
    Left = 152
    Top = 135
    Width = 73
    Height = 21
    DataField = 'devise'
    DataSource = DMParamEntreprise.DaInfosJuridique
    TabOrder = 5
  end
end
