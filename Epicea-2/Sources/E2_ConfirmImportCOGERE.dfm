object ConfirmImportCOGERE: TConfirmImportCOGERE
  Left = 104
  Top = 0
  Width = 757
  Height = 560
  Caption = 'Importation Dossier SIEA DOS'
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
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline FRAssistant1: TFRAssistant
    Left = 0
    Top = 472
    Width = 741
    Height = 50
    Align = alBottom
    TabOrder = 0
    inherited PaBtn: TPanel
      Width = 741
      Height = 50
      OnClick = FRAssistant1PaBtnClick
      inherited BtnPrecedent: TButton
        Left = 164
      end
      inherited BtnSuivant: TButton
        Left = 332
        OnClick = FRAssistant1BtnSuivantClick
      end
      inherited BtnAnnuler: TButton
        Left = 500
      end
    end
  end
  object PaFond: TPanel
    Left = 0
    Top = 0
    Width = 741
    Height = 472
    Align = alClient
    TabOrder = 1
    object PaListeImport: TPanel
      Left = 1
      Top = 1
      Width = 256
      Height = 470
      Align = alLeft
      BevelOuter = bvNone
      BorderWidth = 2
      BorderStyle = bsSingle
      TabOrder = 0
      object PaListe: TPanel
        Left = 2
        Top = 16
        Width = 248
        Height = 89
        Align = alTop
        TabOrder = 0
        object RxChBImports: TRxCheckListBox
          Left = 25
          Top = 1
          Width = 222
          Height = 87
          Align = alClient
          ExtendedSelect = False
          ItemHeight = 26
          Style = lbOwnerDrawVariable
          TabOrder = 0
          OnClickCheck = RxChBImportsClickCheck
          InternalVersion = 202
          Strings = (
            'Mise '#224' jour du plan comptable'
            1
            True
            'Immobilisations'
            1
            True
            'Balance d'#39'Ouverture'
            1
            True)
        end
        object RxSliderImport: TRxSlider
          Left = 1
          Top = 1
          Width = 24
          Height = 87
          Align = alLeft
          BevelStyle = bvRaised
          Color = 7396351
          Enabled = False
          ImageVThumb.Data = {
            06020000424D0602000000000000760000002800000020000000190000000100
            04000000000090010000C40E0000C40E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            33333FFF3333333333330003333333333333777FFF3FFFFF33330B0003000003
            33337F777F777773F333000E00BFBFB03333777F773333F7F333000E0BFBF000
            3333777F7F3337773F33000E0FBFBFBF0333777F7F3333FF7FFF000E0BFBF000
            0003777F7F3337777773000E0FBFBFBFBFB0777F7F33FFFFFFF7000E0BF00000
            0003777F7FF777777773000000BFB03333337777773FF7333333333333000333
            3333333333777333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            33333333333333333333}
          Increment = 1
          MinValue = 1
          MaxValue = 3
          NumThumbStates = 1
          Orientation = soVertical
          EdgeSize = 0
          Options = []
          ParentColor = False
          TabOrder = 1
          Value = 3
          UserImages = {04}
        end
      end
      object PaPTitre: TPanel
        Left = 2
        Top = 2
        Width = 248
        Height = 14
        Align = alTop
        Caption = 'Liste des modules d'#39'importation'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object PaListeVisu: TPanel
        Left = 2
        Top = 105
        Width = 248
        Height = 359
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        TabOrder = 2
        object ListViewResult: TListView
          Left = 2
          Top = 16
          Width = 240
          Height = 337
          Align = alClient
          Columns = <
            item
              Caption = 'Rapport d'#39'importation'
              Width = 300
            end>
          TabOrder = 0
          ViewStyle = vsReport
        end
        object PaListeRappImport: TPanel
          Left = 2
          Top = 2
          Width = 240
          Height = 14
          Cursor = crHandPoint
          Align = alTop
          Caption = 'Liste des rapports d'#39'importation'
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
    object PaSousGrille: TPanel
      Left = 257
      Top = 1
      Width = 483
      Height = 470
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 2
      BorderStyle = bsSingle
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      object PaResultImport: TPanel
        Left = 3
        Top = 3
        Width = 475
        Height = 14
        Align = alTop
        Caption = 'R'#233'sultat'
        Color = 7396351
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6974005
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object PaGrille: TPanel
        Left = 3
        Top = 17
        Width = 475
        Height = 448
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        object DBCompareBalance: TGrDBGrid
          Left = 3
          Top = 3
          Width = 467
          Height = 440
          Align = alClient
          BorderStyle = bsNone
          Ctl3D = True
          DataSource = DMImport.DaResultImport
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          ScrollBars = ssHorizontal
          EditColor = clWindow
          DefaultRowHeight = 20
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
          LockedColor = clGray
          FlatCheckBoxType = Bold
          NumDecimal = 2
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 351
    Top = 205
    object Suppressiontotaledudossier1: TMenuItem
      Caption = 'Suppression du dossier'
      ShortCut = 16505
      OnClick = Suppressiontotaledudossier1Click
    end
  end
end