object AffectImmosCptCOGERE: TAffectImmosCptCOGERE
  Left = 338
  Top = 208
  Width = 782
  Height = 600
  Caption = 'Affectation Immo -> Compte'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaFond: TPanel
    Left = 0
    Top = 42
    Width = 774
    Height = 447
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    object PaGauche: TPanel
      Left = 3
      Top = 3
      Width = 422
      Height = 437
      Align = alLeft
      TabOrder = 0
      object PaGhaut: TPanel
        Left = 1
        Top = 1
        Width = 420
        Height = 128
        Align = alTop
        TabOrder = 0
        object PaTitre1: TPanel
          Left = 1
          Top = 1
          Width = 418
          Height = 14
          Align = alTop
          Caption = 'Liste des Codes / Comptes'
          Color = 7396351
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6974005
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object PaListeCodeCompte: TPanel
          Left = 1
          Top = 15
          Width = 418
          Height = 112
          Align = alClient
          TabOrder = 1
          object VLECodeCompte: TValueListEditor
            Left = 1
            Top = 1
            Width = 416
            Height = 110
            Align = alClient
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goThumbTracking]
            TabOrder = 0
            TitleCaptions.Strings = (
              'Code'
              'Compte par d'#233'faut')
            OnSelectCell = VLECodeCompteSelectCell
            ColWidths = (
              102
              308)
          end
        end
      end
      object PaListeImmo: TPanel
        Left = 1
        Top = 129
        Width = 420
        Height = 307
        Align = alClient
        TabOrder = 1
        object Panel1: TPanel
          Left = 1
          Top = 15
          Width = 418
          Height = 291
          Align = alClient
          TabOrder = 0
          object LVImmos: TListView
            Left = 1
            Top = 1
            Width = 416
            Height = 289
            Align = alClient
            Columns = <
              item
                Caption = 'Compte'
                Width = 100
              end
              item
                Caption = 'Balance D'#233'bit'
                Width = 70
              end
              item
                Alignment = taRightJustify
                Caption = 'Balance Cr'#233'dit'
                Width = 70
              end
              item
                Caption = 'Immo D'#233'bit'
                Width = 70
              end
              item
                Caption = 'Immo Cr'#233'dit'
                Width = 70
              end>
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object Panel2: TPanel
          Left = 1
          Top = 1
          Width = 418
          Height = 14
          Align = alTop
          Caption = 'Liste des immobilisations'
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
    end
    object PaCentre: TPanel
      Left = 425
      Top = 3
      Width = 342
      Height = 437
      Align = alClient
      TabOrder = 1
      object PaDroit: TPanel
        Left = 1
        Top = 15
        Width = 340
        Height = 421
        Align = alClient
        TabOrder = 0
        object GrListeImmos: TGrGrid
          Left = 1
          Top = 1
          Width = 338
          Height = 419
          Align = alClient
          ColCount = 4
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          TabOrder = 0
          OnDrawCell = GrListeImmosDrawCell
          NumDecimal = 0
          OnRowValidate = GrListeImmosRowValidate
          AjoutAuto = False
          ColWidths = (
            238
            106
            70
            126)
        end
      end
      object Patitre2: TPanel
        Left = 1
        Top = 1
        Width = 340
        Height = 14
        Align = alTop
        Caption = 'Liste des immobilisations'
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
  end
  object PaTitrePetit: TPanel
    Left = 0
    Top = 28
    Width = 774
    Height = 14
    Align = alTop
    Caption = 'Liste des ....'
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6974005
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 774
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
    TabOrder = 2
    object ImEnTete: TImage
      Left = 7
      Top = 7
      Width = 760
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
      Width = 269
      Height = 24
      Alignment = taCenter
      Caption = 'Affectation Immo -> Compte'
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
  object PaBtn: TPanel
    Left = 0
    Top = 489
    Width = 774
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 3
    object BtnFermer: TButton
      Left = 310
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Annuler [F4]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnFermerClick
    end
    object BtnImprimer: TButton
      Left = 399
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
      TabOrder = 1
      OnClick = BtnImprimerClick
    end
    object BtnDetail: TButton
      Left = 488
      Top = 0
      Width = 90
      Height = 37
      Caption = 'R'#233'affecter [F7]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BtnDetailClick
    end
    object BtnEnregistrer: TButton
      Left = 220
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
      TabOrder = 3
      OnClick = BtnEnregistrerClick
    end
    object BtnVerification: TButton
      Left = 577
      Top = 0
      Width = 90
      Height = 37
      Caption = 'V'#233'rification [F2]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BtnVerificationClick
    end
  end
  object PaBas: TPanel
    Left = 0
    Top = 525
    Width = 774
    Height = 41
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 4
  end
  object PopupMenu1: TPopupMenu
    Left = 566
    Top = 252
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
      Caption = '&Recalcul'
      ShortCut = 118
      OnClick = BtnDetailClick
    end
    object Imprimer1: TMenuItem
      Caption = 'Im&primer'
      ShortCut = 122
      OnClick = BtnImprimerClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Enregister1: TMenuItem
      Caption = '&Enregister'
      ShortCut = 114
      OnClick = BtnEnregistrerClick
    end
    object Verifier1: TMenuItem
      Caption = '&V'#233'rification'
      ShortCut = 113
      OnClick = BtnVerificationClick
    end
    object Annuler1: TMenuItem
      Caption = '&Annuler'
      ShortCut = 16449
    end
    object Fermer1: TMenuItem
      Caption = '&Fermer'
      ShortCut = 16499
      OnClick = BtnFermerClick
    end
  end
end
