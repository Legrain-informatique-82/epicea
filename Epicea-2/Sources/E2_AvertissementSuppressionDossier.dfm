object AvertissementSuppressionDossier: TAvertissementSuppressionDossier
  Left = 342
  Top = 237
  BorderStyle = bsSingle
  Caption = 'Contenu du r'#233'pertoire qui va '#234'tre supprim'#233
  ClientHeight = 532
  ClientWidth = 508
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 508
    Height = 153
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
      Width = 494
      Height = 139
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
    object RxLabel2: TRxLabel
      Left = 16
      Top = 8
      Width = 110
      Height = 23
      Caption = 'Attention !!!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      Layout = tlBottom
      ParentFont = False
      Transparent = True
    end
    object RxLabel1: TRxLabel
      Left = 16
      Top = 40
      Width = 138
      Height = 24
      Caption = 'Le r'#233'pertoire :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      Layout = tlBottom
      ParentFont = False
      Transparent = True
    end
    object RxLaDir: TRxLabel
      Left = 16
      Top = 65
      Width = 75
      Height = 23
      Caption = 'Dossier'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      Layout = tlBottom
      ParentFont = False
      Transparent = True
    end
    object RxLabel4: TRxLabel
      Left = 16
      Top = 89
      Width = 192
      Height = 24
      Caption = 'et tout son contenu '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      Layout = tlBottom
      ParentFont = False
      Transparent = True
    end
    object RxLabel3: TRxLabel
      Left = 16
      Top = 116
      Width = 192
      Height = 23
      Caption = 'Vont '#234'tre supprim'#233's'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      Layout = tlBottom
      ParentFont = False
      Transparent = True
    end
  end
  object PaDateDeb: TPanel
    Left = 0
    Top = 153
    Width = 508
    Height = 195
    Align = alClient
    Color = 12441823
    TabOrder = 1
    object ShellListView1: TShellListView
      Left = 1
      Top = 1
      Width = 506
      Height = 193
      ObjectTypes = [otFolders, otNonFolders]
      Root = 'C:\Lgrdoss\EPICEA'
      Sorted = True
      Align = alClient
      ReadOnly = False
      HideSelection = False
      TabOrder = 0
    end
  end
  object PaBtn: TPanel
    Left = 0
    Top = 420
    Width = 508
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 2
    OnResize = PaBtnResize
    object BtnEnregistrer: TButton
      Left = 270
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Continuer [F3]'
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
    object BtnAnnuler: TButton
      Left = 156
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Annuler [Escp]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      OnClick = BtnAnnulerClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 348
    Width = 508
    Height = 72
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 3
    object RxLabTitre: TRxLabel
      Left = 16
      Top = 6
      Width = 344
      Height = 24
      Caption = 'Contenu du r'#233'pertoire '#224' supprimer :'
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
  object Panel2: TPanel
    Left = 0
    Top = 456
    Width = 508
    Height = 76
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 4
    object RxLabel5: TRxLabel
      Left = 16
      Top = 8
      Width = 139
      Height = 16
      Caption = 'Si vous avez un doute'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      Layout = tlBottom
      ParentFont = False
      Transparent = True
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 388
    Top = 12
    object Annuler1: TMenuItem
      Caption = '&Annuler'
      ShortCut = 16449
      OnClick = BtnAnnulerClick
    end
    object Valider1: TMenuItem
      Caption = '&Continuer'
      ShortCut = 114
      OnClick = BtnEnregistrerClick
    end
  end
end
