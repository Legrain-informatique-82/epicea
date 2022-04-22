object RegulTVA: TRegulTVA
  Left = 301
  Top = 323
  Width = 870
  Height = 386
  Caption = 'R'#233'gularisation TVA'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
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
    Width = 862
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
      Width = 848
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
      Width = 334
      Height = 24
      Alignment = taCenter
      Caption = 'S'#233'lectionnez les r'#233'gularisations  ...'
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
    Width = 862
    Height = 14
    Align = alTop
    Caption = 
      'Liste des r'#233'gularisations TVA '#224' prendre en compte dans la d'#233'clar' +
      'ation'
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6974005
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object PaBtn: TPanel
    Left = 0
    Top = 280
    Width = 862
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 2
    OnClick = PaBtnClick
    OnResize = PaBtnResize
    object BtnImprimer: TButton
      Left = 551
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
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnEnregistrer: TButton
      Left = 372
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
      TabOrder = 1
      OnClick = BtnEnregistrerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnDetail: TButton
      Left = 640
      Top = -1
      Width = 90
      Height = 37
      Caption = 'Visualisation [F7]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = DtailsF71Click
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnAnnuler: TButton
      Left = 232
      Top = -1
      Width = 90
      Height = 37
      Caption = 'Annuler [Esc]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnAnnulerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
  end
  object PaGrille: TPanel
    Left = 0
    Top = 42
    Width = 862
    Height = 238
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 3
    OnResize = PaGrilleResize
    object ListViewResult: TListView
      Left = 3
      Top = 3
      Width = 852
      Height = 228
      Align = alClient
      Checkboxes = True
      Columns = <
        item
          Caption = 'Prise'
          Width = 20
        end
        item
          Caption = 'Code tva'
          Width = 80
        end
        item
          Caption = 'Compte tva'
          Width = 80
        end
        item
          Caption = 'D'#233'clar'#233
          Width = 80
        end
        item
          Caption = 'En attente'
          Width = 80
        end
        item
          Caption = 'Total'
          Width = 80
        end
        item
          Caption = 'Solde balance'
          Width = 80
        end
        item
          Caption = 'Diff'#233'rence'
          Width = 80
        end
        item
          Caption = 'Justifi'#233
          Width = 40
        end
        item
          Caption = 'Type'
          MaxWidth = 40
          MinWidth = 1
          Width = 40
        end>
      MultiSelect = True
      RowSelect = True
      PopupMenu = PopupMenu1
      SortType = stData
      TabOrder = 0
      ViewStyle = vsReport
      OnColumnClick = ListViewResultColumnClick
      OnCompare = ListViewResultCompare
      OnDblClick = DtailsF71Click
      OnKeyPress = ListViewResultKeyPress
    end
  end
  object PaBas: TPanel
    Left = 0
    Top = 316
    Width = 862
    Height = 36
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 4
    object RxLabel1: TRxLabel
      Left = 1
      Top = 1
      Width = 78
      Height = 34
      Align = alLeft
      Caption = 'Recherche sur :'
      Layout = tlCenter
    end
    object Panel1: TPanel
      Left = 79
      Top = 1
      Width = 782
      Height = 34
      Align = alClient
      TabOrder = 0
      object Panel3: TPanel
        Left = 186
        Top = 1
        Width = 595
        Height = 32
        Align = alClient
        Caption = 'Panel3'
        TabOrder = 0
        object HeadChoixColonneRech: THeaderControl
          Left = 1
          Top = 15
          Width = 593
          Height = 16
          Align = alClient
          Sections = <
            item
              ImageIndex = -1
              Style = hsOwnerDraw
              Text = 'fezffez'
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end>
          OnSectionClick = HeadChoixColonneRechSectionClick
        end
        object Panel4: TPanel
          Left = 1
          Top = 1
          Width = 593
          Height = 14
          Align = alTop
          Caption = 'Choisissez votre colonne de recherche'
          Color = 7396351
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6974005
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 1
        Width = 185
        Height = 32
        Align = alLeft
        TabOrder = 1
        object RxLabColRech: TRxLabel
          Left = 1
          Top = 1
          Width = 183
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'colonne1 : '
          Layout = tlCenter
        end
        object PaRecherche: TPanel
          Left = 1
          Top = 14
          Width = 183
          Height = 17
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          BorderWidth = 1
          Color = clWindow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 293
    Top = 137
    object DtailsF71: TMenuItem
      Caption = 'Visualisation'
      ShortCut = 118
      OnClick = DtailsF71Click
    end
    object Imprimer1: TMenuItem
      Caption = '&Imprimer'
      ShortCut = 122
      OnClick = BtnImprimerClick
    end
    object Imprimerlaselection1: TMenuItem
      Caption = 'Imprimer la selection'
      ShortCut = 16506
      OnClick = Imprimerlaselection1Click
    end
    object Enregister1: TMenuItem
      Caption = 'Valider'
      ShortCut = 114
      Visible = False
      OnClick = BtnEnregistrerClick
    end
    object Exporter1: TMenuItem
      Caption = 'Exporter'
      ShortCut = 16453
      OnClick = Exporter1Click
    end
  end
end
