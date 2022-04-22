object Main: TMain
  Left = 373
  Top = 215
  Width = 1231
  Height = 516
  Caption = 'Epicea-2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  Menu = MenuMain
  OldCreateOrder = True
  PopupMenu = PopupMenu1
  Position = poDefault
  WindowMenu = mnAffichage
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Shape2: TShape
    Left = 48
    Top = 16
    Width = 41
    Height = 25
    Brush.Color = clRed
    Shape = stRoundRect
  end
  object Shape1: TShape
    Left = 24
    Top = 8
    Width = 65
    Height = 33
    Brush.Style = bsClear
    Pen.Color = clRed
    Pen.Width = 2
    Shape = stRoundRect
  end
  object PaBtn: TPanel
    Left = 0
    Top = 296
    Width = 1215
    Height = 49
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 3
    OnClick = PaBtnClick
    OnResize = PaBtnResize
    object BtnPlanCpt: TRxSpeedButton
      Left = 71
      Top = 0
      Width = 90
      Height = 50
      Cursor = crHandPoint
      Caption = 'Plan'#13#10'Comptable'#13#10'[ F2 ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = True
      OnClick = BtnPlanCptClick
    end
    object BtnPlanAux: TRxSpeedButton
      Left = 160
      Top = 0
      Width = 90
      Height = 50
      Cursor = crHandPoint
      Caption = 'Plan'#13#10'Auxiliaire'#13#10'[ F3 ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = True
      OnClick = BtnPlanAuxClick
    end
    object BtnInserer: TRxSpeedButton
      Left = 249
      Top = 0
      Width = 90
      Height = 50
      Cursor = crHandPoint
      Caption = 'D'#233'marrer'#13#10'Ouverture'#13#10'[ F4 ]'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = True
    end
    object BtnPointages: TRxSpeedButton
      Left = 338
      Top = 0
      Width = 90
      Height = 50
      Cursor = crHandPoint
      Caption = 'Pointages'#13#10'[ F5 ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = True
      OnClick = BtnPointagesClick
    end
    object BtnSaisiePiece: TRxSpeedButton
      Left = 427
      Top = 0
      Width = 90
      Height = 50
      Cursor = crHandPoint
      Caption = 'Saisie des'#13#10'Pi'#232'ces'#13#10'[ F6 ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = True
      OnClick = BtnSaisiePieceClick
    end
    object BtnFermer: TRxSpeedButton
      Left = 516
      Top = 0
      Width = 90
      Height = 50
      Cursor = crHandPoint
      Caption = 'Visualisation'#13#10'des pi'#232'ces'#13#10'[ F7 ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = True
      OnClick = Pieces1Click
    end
    object BtnBalance: TRxSpeedButton
      Left = 605
      Top = 0
      Width = 90
      Height = 50
      Cursor = crHandPoint
      Caption = 'Balance '#13#10'[ F8 ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = True
      OnClick = BtnBalanceClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1215
    Height = 296
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Button3: TButton
      Left = 664
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 0
      Visible = False
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 620
      Top = 124
      Width = 147
      Height = 25
      Caption = 'Button4'
      TabOrder = 1
      Visible = False
      OnClick = Button4Click
    end
    object Button2: TButton
      Left = 667
      Top = 54
      Width = 75
      Height = 25
      Caption = 'Button2'
      TabOrder = 2
      Visible = False
    end
    object Button5: TButton
      Left = 6
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Quitter'
      TabOrder = 3
      OnClick = mnQuitterClick
    end
    object PaMenuGraph: TPanel
      Left = 2
      Top = 2
      Width = 1211
      Height = 292
      Align = alClient
      TabOrder = 4
      object Panel4: TPanel
        Left = 89
        Top = 28
        Width = 1121
        Height = 183
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 2
        Color = 14087679
        TabOrder = 1
        OnResize = Panel4Resize
        DesignSize = (
          1121
          183)
        object ListMenu: TListView
          Left = 2
          Top = 2
          Width = 1117
          Height = 179
          Align = alClient
          BorderStyle = bsNone
          Color = 11398143
          Columns = <>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HideSelection = False
          HotTrack = True
          IconOptions.AutoArrange = True
          Items.Data = {
            CE0000000500000000000000FFFFFFFFFFFFFFFF0000000000000000095072E9
            63E964656E7401000000FFFFFFFFFFFFFFFF0000000000000000264368617267
            65732065742070726F647569747320636F6E73746174E9732064276176616E63
            6502000000FFFFFFFFFFFFFFFF0000000000000000264368617267657320E020
            70617965722065742070726F647569747320E02072656365766F69720F000000
            FFFFFFFFFFFFFFFF00000000000000000853756976616E742000000000FFFFFF
            FFFFFFFFFF000000000000000000}
          LargeImages = ImageList3
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          TabOrder = 0
          OnClick = ListMenuDblClick
          OnKeyDown = ListMenuKeyDown
          OnKeyPress = ListMenuKeyPress
          OnMouseMove = ListMenuMouseMove
        end
        object EdDossierTransmis1: TEdit
          Left = 8
          Top = 134
          Width = 751
          Height = 24
          Anchors = [akLeft, akBottom]
          AutoSize = False
          BiDiMode = bdRightToLeftReadingOnly
          BorderStyle = bsNone
          Color = 11398143
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 2
          Text = 'Attention, dossier chez le comptable (ou une tierce personne),'
        end
        object EdDossierTransmis2: TEdit
          Left = 8
          Top = 158
          Width = 753
          Height = 24
          Anchors = [akLeft, akBottom]
          AutoSize = False
          BiDiMode = bdRightToLeftReadingOnly
          BorderStyle = bsNone
          Color = 11398143
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 1
          Text = 'ne pas le modifier !!!'
        end
        object EdExerciceEpure: TEdit
          Left = 3
          Top = -14
          Width = 753
          Height = 24
          Anchors = [akLeft, akBottom]
          AutoSize = False
          BiDiMode = bdRightToLeftReadingOnly
          BorderStyle = bsNone
          Color = 11398143
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 3
          Text = 'Attention !!! exercice '#233'pur'#233' !!!'
        end
        object Edit3: TEdit
          Left = 11
          Top = -126
          Width = 753
          Height = 24
          Anchors = [akLeft, akBottom]
          AutoSize = False
          BiDiMode = bdRightToLeftReadingOnly
          BorderStyle = bsNone
          Color = 11398143
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 4
          Text = 
            'Attention !!! ne pas oublier de remettre le marquage des dossier' +
            's !!!'
          Visible = False
        end
        object Button6: TButton
          Left = 517
          Top = 76
          Width = 75
          Height = 25
          Caption = 'Button6'
          TabOrder = 5
          Visible = False
        end
        object Button8: TButton
          Left = 560
          Top = 144
          Width = 75
          Height = 25
          Caption = 'Button8'
          TabOrder = 6
          Visible = False
          OnClick = Button8Click
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 28
        Width = 88
        Height = 183
        Align = alLeft
        BevelOuter = bvNone
        Color = 14087679
        TabOrder = 0
        object ImExit: TImage
          Left = 0
          Top = 0
          Width = 88
          Height = 32
          Cursor = crHandPoint
          Align = alTop
          AutoSize = True
          Center = True
          Picture.Data = {
            055449636F6E0000010001002020100001000400E80200001600000028000000
            2000000040000000010004000000000000020000000000000000000000000000
            0000000000000000000080000080000000808000800000008000800080800000
            80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
            FFFFFF0000000000000888887777700000000000000000000888888877777770
            0000000000000008888888887777777770000000000008888888888877777777
            7770000000008888888888887777777777770000000888888888888877777777
            7777700000088888888888887777777777777000008888888888999999977777
            7777770008888888889999999999977777777770088888888999999999999977
            7777777008888888999999999999999777777770888888899999999999999999
            777777778888888999999F9999F9999977777777888888999999FFF99FFF9999
            977777778888889999999FFFFFF999999777777788888899999999FFFF999999
            9777777777777799999999FFFF999999988888887777779999999FFFFFF99999
            98888888777777999999FFF99FFF9999988888887777777999999F9999F99999
            8888888877777779999999999999999988888888777777779999999999999998
            8888888807777777799999999999998888888880077777777799999999999888
            8888888000777777777799999998888888888800007777777777777788888888
            8888880000077777777777778888888888888000000077777777777788888888
            8888000000000777777777778888888888800000000000777777777788888888
            8800000000000000777777778888888800000000000000000077777788888800
            00000000FFE007FFFF8001FFFE00007FF800001FF000000FE0000007E0000007
            C000000380000001800000018000000100000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000080000001
            80000001C0000003C0000003E0000007F000000FF800001FFC00003FFF0000FF
            FFC003FF}
          Transparent = True
          OnClick = mnQuitterClick
        end
        object ImHelp: TImage
          Left = 0
          Top = 48
          Width = 88
          Height = 32
          Cursor = crHandPoint
          Align = alTop
          AutoSize = True
          Center = True
          Picture.Data = {
            055449636F6E0000010001002020100001000400E80200001600000028000000
            2000000040000000010004000000000000020000000000000000000000000000
            0000000000000000000080000080000000808000800000008000800080800000
            80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
            FFFFFF0000000000007777778888880000000000000000007777777788888888
            0000000000000007777777778888888888000000000007777777777788888888
            8880000000007777777777778888888888880000000077777777777788888888
            88888000000777777777777788888888888888000077777777777BBBBBBB8888
            8888880000777777777BBBBBBBBBBB88888888800777777777BBBBB999BBBBB8
            88888880077777777BBBBBB999BBBBBB8888888877777777BBBBBBBBBBBBBBBB
            8888888877777777BBBBBBB999BBBBBBB88888887777777BBBBBBBB999BBBBBB
            B88888887777777BBBBBBBB999BBBBBBB88888887777777BBBBBBBB9999BBBBB
            B88888888888888BBBBBBBBB9999BBBBB77777778888888BBBBBBBBBB9999BBB
            B77777778888888BBBBBB9BBBB999BBBB777777788888888BBBB999BBB999BBB
            B777777708888888BBBB9999BB999BBB77777777088888888BBBB9999999BBB7
            777777700888888888BBBB99999BBB777777777000888888888BBBBBBBBBB777
            777777700088888888888BBBBBB7777777777700000888888888888877777777
            7777700000008888888888887777777777777000000008888888888877777777
            7777000000000088888888887777777777700000000000088888888877777777
            7000000000000000088888887777777000000000000000000008888877777000
            00000000FFC003FFFF0000FFFE00003FF800001FF000000FF0000007E0000003
            C0000003C0000001800000018000000000000000000000000000000000000000
            0000000000000000000000000000000000000000800000008000000180000001
            C0000001C0000003E0000007F0000007F800000FFC00001FFE00007FFF8001FF
            FFE007FF}
          OnClick = ImHelpClick
        end
        object RxLabel1: TRxLabel
          Left = 0
          Top = 32
          Width = 88
          Height = 16
          Cursor = crHandPoint
          Align = alTop
          Alignment = taCenter
          Caption = 'Quitter'
          ShadowSize = 0
          Transparent = True
          OnClick = mnQuitterClick
        end
        object RxLabel2: TRxLabel
          Left = 0
          Top = 80
          Width = 88
          Height = 16
          Cursor = crHandPoint
          Align = alTop
          Alignment = taCenter
          Caption = 'Aide'
          Transparent = True
        end
        object Button7: TButton
          Left = 0
          Top = 0
          Width = 911
          Height = 21
          Caption = 'Button7'
          TabOrder = 0
          Visible = False
          OnClick = Button7Click
        end
      end
      object PaOutils: TPanel
        Left = 1
        Top = 211
        Width = 1209
        Height = 80
        Align = alBottom
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 2
        object ListeOutils: TListView
          Left = 0
          Top = 0
          Width = 1209
          Height = 80
          Align = alClient
          BorderStyle = bsNone
          Color = 14087679
          Columns = <>
          Items.Data = {
            240000000100000000000000FFFFFFFFFFFFFFFF0000000000000000074E6F75
            76656175}
          LargeImages = ImListOutils
          TabOrder = 0
          TabStop = False
          OnKeyDown = ListeOutilsKeyDown
          OnMouseMove = ListMenuMouseMove
        end
        object Button1: TButton
          Left = 289
          Top = 15
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 1
          OnClick = Button1Click
        end
        object Edit1: TEdit
          Left = 400
          Top = 16
          Width = 97
          Height = 24
          TabOrder = 2
          Visible = False
        end
        object Edit2: TEdit
          Left = 560
          Top = 16
          Width = 81
          Height = 24
          TabOrder = 3
          Visible = False
        end
      end
      object PaTitreMenu: TPanel
        Left = 1
        Top = 1
        Width = 1209
        Height = 27
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 'Menu G'#233'n'#233'ral'
        Color = 11398143
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object LabDossier: TLabel
          Left = 1120
          Top = 0
          Width = 89
          Height = 27
          Cursor = crHandPoint
          Align = alRight
          Alignment = taCenter
          Caption = 'LabDossier'
          Layout = tlCenter
          OnClick = Proprits2Click
        end
      end
    end
  end
  object BasMain: THeaderControl
    Left = 0
    Top = 442
    Width = 1215
    Height = 16
    Align = alBottom
    HotTrack = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Sections = <
      item
        ImageIndex = -1
        Text = '17/03/98 10:50'
        Width = 120
      end
      item
        ImageIndex = -1
        Text = 'Insertion'
        Width = 60
      end
      item
        ImageIndex = -1
        Text = 'Aide'
        Width = 500
      end
      item
        ImageIndex = -1
        Text = '17/03/98 10:50'
        Width = 120
      end
      item
        ImageIndex = -1
        Text = 'Insertion'
        Width = 60
      end
      item
        ImageIndex = -1
        Text = 'Aide'
        Width = 500
      end
      item
        ImageIndex = -1
        Text = '17/03/98 10:50'
        Width = 120
      end
      item
        ImageIndex = -1
        Text = 'Insertion'
        Width = 60
      end
      item
        ImageIndex = -1
        Text = 'Aide'
        Width = 500
      end
      item
        ImageIndex = -1
        Text = '17/03/98 10:50'
        Width = 120
      end
      item
        ImageIndex = -1
        Text = 'Insertion'
        Width = 60
      end
      item
        ImageIndex = -1
        Text = 'Aide'
        Width = 500
      end>
    OnSectionClick = BasMainSectionClick
    ParentFont = False
    Visible = False
  end
  object PaMessageSilencieux: TPanel
    Left = 100
    Top = 204
    Width = 301
    Height = 104
    BevelOuter = bvNone
    BevelWidth = 2
    BorderWidth = 1
    BorderStyle = bsSingle
    Caption = 'PaMessageSilencieux'
    Color = 12441823
    TabOrder = 1
    Visible = False
    OnMouseMove = PaMessageSilencieuxMouseMove
    object PaTitre: TPanel
      Left = 1
      Top = 1
      Width = 295
      Height = 19
      Align = alTop
      Caption = 'TitreMessage'
      Color = 3394815
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6974005
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnDblClick = PaTitreDblClick
      OnMouseDown = PaTitreMouseDown
    end
    object PaMessage: TPanel
      Left = 1
      Top = 20
      Width = 295
      Height = 79
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 2
      BorderStyle = bsSingle
      Caption = 'PaMessage'
      Color = 15399679
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object PaDate: TPanel
    Left = 0
    Top = 345
    Width = 1215
    Height = 97
    Align = alBottom
    BorderWidth = 5
    BorderStyle = bsSingle
    Caption = 'PaDate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -20
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 4
    object RxClock1: TRxClock
      Left = 1101
      Top = 6
      Width = 104
      Height = 81
      Cursor = crHandPoint
      AlarmEnabled = True
      AlarmHour = 23
      AlarmMinute = 59
      AlarmSecond = 59
      BevelInner = bvNone
      BevelOuter = bvNone
      ShowMode = scAnalog
      Align = alRight
      BorderWidth = 10
      BorderStyle = bsSingle
      Color = 11398143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 25600
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnAlarm = RxClock1Alarm
      OnClick = RxClock1Click
    end
    object Panel2: TPanel
      Left = 6
      Top = 6
      Width = 823
      Height = 81
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Caption = 'Mercredi 3 Janvier 2000'
      Color = 12441823
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnDblClick = Panel2DblClick
      OnResize = Panel2Resize
      object SpeedButton1: TRxSpeedButton
        Left = 103
        Top = 12
        Width = 281
        Height = 25
        Cursor = crHandPoint
        Flat = True
        Layout = blGlyphLeft
        ParentShowHint = True
        Spacing = 4
        Transparent = True
        OnMouseEnter = Panel2DblClick
        OnMouseLeave = Panel2DblClick
      end
      object Gauge1: TGauge
        Left = 7
        Top = 65
        Width = 450
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        MaxValue = 170
        ParentFont = False
        Progress = 0
        Visible = False
      end
    end
    object Panel5: TPanel
      Left = 829
      Top = 6
      Width = 272
      Height = 81
      Align = alRight
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = 12441823
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      TabOrder = 2
      object Panel6: TPanel
        Left = 2
        Top = 2
        Width = 268
        Height = 38
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = 12441823
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = Panel6Click
      end
      object Panel7: TPanel
        Left = 2
        Top = 40
        Width = 268
        Height = 39
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = 12441823
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = Panel7Click
      end
    end
  end
  object MenuMain: TMainMenu
    AutoHotkeys = maManual
    Left = 168
    Top = 144
    object mnDossiers: TMenuItem
      Caption = '&Dossiers'
      OnClick = mnMethodesClick
      object mnOuvrir: TMenuItem
        Caption = '&Ouvrir'
        Visible = False
        OnClick = mnOuvrirClick
      end
      object mnDemo: TMenuItem
        Caption = 'D'#233'&monstration'
        OnClick = mnDemoClick
      end
      object mnFermer: TMenuItem
        Caption = '&Fermer'
        Visible = False
        OnClick = mnFermerClick
      end
      object N1: TMenuItem
        Caption = '-'
        Visible = False
      end
      object mnQuitter: TMenuItem
        Caption = '&Quitter'
        OnClick = mnQuitterClick
      end
    end
    object mnMethodes: TMenuItem
      Caption = '&M'#233'thodes'
      OnClick = mnMethodesClick
      object PlanComptable1: TMenuItem
        Caption = 'Plan Comptable'
        ShortCut = 113
        OnClick = PlanComptable1Click
        OnDrawItem = PlanComptable1DrawItem
      end
      object PlanAuxiliaire1: TMenuItem
        Caption = 'Plan Auxiliaire'
        ShortCut = 114
        OnClick = PlanAuxiliaire1Click
      end
      object CodeTVA1: TMenuItem
        Caption = 'Code TVA'
        OnClick = CodeTVA1Click
      end
      object Modificationplanettrame1: TMenuItem
        Caption = 'Mise '#224' jour plan et trames'
        OnClick = Modificationplanettrame1Click
        object Modificationcodetva1: TMenuItem
          Caption = 'Changement des codes tva (plan et trames)'
          OnClick = Modificationcodetva1Click
        end
        object Modificationtauxtva1: TMenuItem
          Caption = 'Changement des taux tva (plan et trames)'
          OnClick = Modificationtauxtva1Click
        end
        object Misejourdestrames1: TMenuItem
          Caption = 'Mise '#224' jour des trames '#224' partir du plan comptable'
          OnClick = Misejourdestrames1Click
        end
      end
      object Journaux1: TMenuItem
        Caption = 'Journaux'
        OnClick = Journaux1Click
      end
      object TramesdeSaisie1: TMenuItem
        Caption = 'Trames de Saisie'
        Enabled = False
        Visible = False
        OnClick = TramesdeSaisie1Click
      end
      object mnEntreprise: TMenuItem
        Caption = '&Description Entreprise'
        OnClick = mnEntrepriseClick
      end
      object PlanComptabledebase1: TMenuItem
        Caption = 'Plan Comptable de base'
        OnClick = PlanComptabledebase1Click
      end
      object InformationsParoisse1: TMenuItem
        Caption = 'Informations Paroisse'
        Visible = False
        OnClick = InformationsParoisse1Click
      end
      object Proprits2: TMenuItem
        Caption = 'Propri'#233't'#233's dossier'
        OnClick = Proprits2Click
      end
    end
    object mnOuverture: TMenuItem
      Caption = '&Ouverture'
      OnClick = mnMethodesClick
      object AssistantOuverture1: TMenuItem
        Caption = 'Assistant Ouverture'
        Enabled = False
        OnClick = AssistantOuverture1Click
      end
      object Immobilisations1: TMenuItem
        Caption = 'Immobilisations'
        OnClick = Immobilisations1Click
      end
      object Emprunts1: TMenuItem
        Caption = 'Emprunts'
        OnClick = Emprunts1Click
      end
      object Stoks1: TMenuItem
        Caption = 'Stocks'
        OnClick = Stoks1Click
      end
      object DettetCreances: TMenuItem
        Caption = 'Dettes et Cr'#233'ances'
        OnClick = mnMethodesClick
        object SaisieAnneeAnterieur: TMenuItem
          Caption = 'Saisie pi'#232'ces ann'#233'e ant'#233'rieure'
          OnClick = SaisieAnneeAnterieurClick
        end
        object BalancedesTiers1: TMenuItem
          Caption = 'Balance des Tiers'
          Visible = False
          OnClick = DettetCreancesClick
        end
      end
      object Autressituationdedbut1: TMenuItem
        Caption = 'Autres situation de d'#233'but'
        OnClick = mnMethodesClick
        object Chargesrpartir1: TMenuItem
          Caption = 'Charges '#224' r'#233'partir'
          OnClick = Chargesrpartir1Click
        end
        object CEtPConstatsdavance1: TMenuItem
          Caption = 'Charges et produits constat'#233's d'#39'avance'
          OnClick = CEtPConstatsdavance1Click
        end
        object CEtPrecevoir1: TMenuItem
          Caption = 'Charges '#224' payer et produits '#224' recevoir'
          OnClick = CEtPrecevoir1Click
        end
        object Provisions1: TMenuItem
          Caption = 'Provisions'
          OnClick = Provisions1Click
        end
        object Bilandouverture1: TMenuItem
          Caption = 'Balance d'#39'ouverture'
          OnClick = Balance1Click
        end
      end
      object ChargesetProduitsAnneAntrieure1: TMenuItem
        Caption = 'Charges et Produits Ann'#233'e Ant'#233'rieure'
        OnClick = ChargesetProduitsAnneAntrieure1Click
      end
      object ValidationBalancedouverture1: TMenuItem
        Caption = 'Validation Balance d'#39'ouverture'
        Enabled = False
        Visible = False
        OnClick = ValidationBalancedouverture1Click
      end
      object ImportationOuverture1: TMenuItem
        Caption = 'Importation Ouverture'
        OnClick = mnMethodesClick
        object Epica2DOS1: TMenuItem
          Caption = 'Epic'#233'a-2 DOS'
          OnClick = Epica2DOS1Click
        end
        object SIEADOS1: TMenuItem
          Caption = 'SIEA DOS'
          OnClick = SIEADOS1Click
        end
      end
    end
    object mnEcritures: TMenuItem
      Caption = '&Ecritures'
      OnClick = mnMethodesClick
      object mnSaisiePiece: TMenuItem
        Caption = '&Saisie Piece'
        ShortCut = 117
        OnClick = mnSaisiePieceClick
      end
      object mnReglementSurListe: TMenuItem
        Caption = '&R'#232'glement sur liste'
        OnClick = Rglementsurliste1Click
      end
      object Pointages1: TMenuItem
        Caption = 'Pointages'
        ShortCut = 116
        OnClick = btPointageClick
      end
      object Rapprochementrelev1: TMenuItem
        Caption = 'Rapprochement relev'#233
        Visible = False
        OnClick = Rapprochementrelev1Click
      end
      object Rapprochementbancaire1: TMenuItem
        Caption = 'Rapprochement bancaire'
        OnClick = Rapprochementbancaire1Click
      end
      object Visualisation1: TMenuItem
        Caption = 'Visualisation'
        OnClick = mnMethodesClick
        object Pieces1: TMenuItem
          Caption = 'Pi'#232'ces'
          ShortCut = 118
          OnClick = Pieces1Click
        end
        object Balance2: TMenuItem
          Caption = 'Balance'
          ShortCut = 119
          OnClick = Balance2Click
        end
        object BalanceTiers1: TMenuItem
          Caption = 'Balance Tiers'
          ShortCut = 16503
          OnClick = BalanceTiers1Click
        end
      end
      object Transfertdefond1: TMenuItem
        Caption = 'Transfert de fond'
        Enabled = False
        Visible = False
        OnClick = Transfertdefond1Click
      end
      object TransfertdeSolde1: TMenuItem
        Caption = 'Transfert de Solde'
        Enabled = False
        Visible = False
        OnClick = TransfertdeSolde1Click
      end
      object RepriseStoks1: TMenuItem
        Caption = 'Reprise situation de d'#233'but'
        OnClick = mnMethodesClick
        object Stocks1: TMenuItem
          Caption = 'Stocks'
          OnClick = mnMethodesClick
          object Stocks2: TMenuItem
            Caption = 'Reprise des stocks'
            OnClick = RepriseStoks1Click
          end
          object Annulerreprise1: TMenuItem
            Caption = 'Annuler reprise des stocks'
            OnClick = Annulerreprise1Click
          end
        end
        object Chargesetproduitsconstatsdavances1: TMenuItem
          Caption = 'Charges et produits constat'#233's d'#39'avances'
          OnClick = Chargesetproduitsconstatsdavances1Click
        end
        object Chargespayeretproduitsrecevoir2: TMenuItem
          Caption = 'Charges '#224' payer et produits '#224' recevoir'
          OnClick = Chargespayeretproduitsrecevoir2Click
        end
      end
    end
    object Edition2: TMenuItem
      Caption = 'Edition'
      OnClick = mnMethodesClick
      object GrandLivre1: TMenuItem
        Caption = 'Grand Livre'
        OnClick = GrandLivre1Click
        object AvecSoldebanque1: TMenuItem
          Caption = 'Avec solde progressif'
          OnClick = AvecSoldebanque1Click
        end
        object avecquantits1: TMenuItem
          Caption = 'Avec quantit'#233's'
          OnClick = avecquantits1Click
        end
        object AvecPrixUnitaire1: TMenuItem
          Caption = 'Avec Prix Unitaire'
          OnClick = AvecPrixUnitaire1Click
        end
      end
      object GrandLivredesTiers1: TMenuItem
        Caption = 'Grand Livre des Tiers'
        OnClick = GrandLivredesTiers1Click
      end
      object Journaux2: TMenuItem
        Caption = 'Journaux'
        OnClick = Journaux2Click
        object dtaills1: TMenuItem
          Caption = 'd'#233'taill'#233's'
          OnClick = dtaills1Click
        end
        object Synthse1: TMenuItem
          Caption = 'Synth'#232'se'
          OnClick = Synthse1Click
        end
      end
      object SlectionJournal1: TMenuItem
        Caption = 'S'#233'lection Journal'
        OnClick = SlectionJournal1Click
      end
      object Journaldespices1: TMenuItem
        Caption = 'Journal des pi'#232'ces'
        OnClick = Journaldespices1Click
      end
      object Immobilisations6: TMenuItem
        Caption = 'Immobilisations'
        OnClick = Immobilisations6Click
        object Ouverture1: TMenuItem
          Caption = 'Ouverture'
          OnClick = Ouverture1Click
          object ableauxdesimmobillisations1: TMenuItem
            Caption = 'Tableaux des immobillisations'
            OnClick = ableauxdesimmobillisations1Click
            object Immobilisations7: TMenuItem
              Caption = 'Immobilisations'
              OnClick = Immobilisations7Click
            end
            object Subventions5: TMenuItem
              Caption = 'Subventions'
              OnClick = Subventions5Click
            end
          end
          object Synthesedutableaudesimmobilisations1: TMenuItem
            Caption = 'Synthese du tableau des immobilisations'
            OnClick = Synthesedutableaudesimmobilisations1Click
            object Immobilisations8: TMenuItem
              Caption = 'Immobilisations'
              OnClick = Immobilisations8Click
            end
            object Subventions6: TMenuItem
              Caption = 'Subventions'
              OnClick = Subventions6Click
            end
          end
        end
        object Cloture1: TMenuItem
          Caption = 'Cl'#244'ture'
          OnClick = Cloture1Click
          object TableauxdesAcquisitions: TMenuItem
            Caption = 'Tableaux des acquisitions'
            OnClick = TableauxdesAcquisitionsClick
            object Immobilisations9: TMenuItem
              Caption = 'Immobilisations'
              OnClick = Immobilisations9Click
            end
            object Subventions7: TMenuItem
              Caption = 'Subventions'
              OnClick = Subventions7Click
            end
          end
          object TableauxdesAmortissements: TMenuItem
            Caption = 'Tableaux des Amortissements'
            OnClick = TableauxdesAmortissementsClick
            object Immobilisations10: TMenuItem
              Caption = 'Immobilisations'
              OnClick = Immobilisations10Click
              object AvecDrogatoire1: TMenuItem
                Caption = 'Avec d'#233'tail du d'#233'rogatoire'
                OnClick = AvecDrogatoire1Click
              end
              object SansDrogatoire1: TMenuItem
                Caption = 'Sans d'#233'tail du d'#233'rogatoire'
                OnClick = SansDrogatoire1Click
              end
            end
            object Subventions8: TMenuItem
              Caption = 'Subventions'
              OnClick = Subventions8Click
              object AvecDrogatoire2: TMenuItem
                Caption = 'Avec d'#233'tail du d'#233'rogatoire'
                OnClick = AvecDrogatoire2Click
              end
              object SansDrogatoire2: TMenuItem
                Caption = 'Sans d'#233'tail du d'#233'rogatoire'
                OnClick = SansDrogatoire2Click
              end
            end
          end
          object Synthesedutableauxdesamortissements1: TMenuItem
            Caption = 'Synth'#232'se du tableaux des amortissements'
            OnClick = Synthesedutableauxdesamortissements1Click
            object Immobilisations11: TMenuItem
              Caption = 'Immobilisations'
              OnClick = Immobilisations11Click
              object Avecdtaildudrogatoire1: TMenuItem
                Caption = 'Avec d'#233'tail du d'#233'rogatoire'
                OnClick = Avecdtaildudrogatoire1Click
              end
              object Sansdtaildudrogatoire1: TMenuItem
                Caption = 'Sans d'#233'tail du d'#233'rogatoire'
                OnClick = Sansdtaildudrogatoire1Click
              end
            end
            object Subventions9: TMenuItem
              Caption = 'Subventions'
              OnClick = Subventions9Click
              object Avecdtaildudrogatoire2: TMenuItem
                Caption = 'Avec d'#233'tail du d'#233'rogatoire'
                OnClick = Avecdtaildudrogatoire2Click
              end
              object Sansdtaildudrogatoire2: TMenuItem
                Caption = 'Sans d'#233'tail du d'#233'rogatoire'
                OnClick = Sansdtaildudrogatoire2Click
              end
            end
          end
          object Synthesedeschoixdamortissements1: TMenuItem
            Caption = 'Synth'#233'se des choix d'#39'amortissements'
            OnClick = Synthesedeschoixdamortissements1Click
            object Immobilisations12: TMenuItem
              Caption = 'Immobilisations'
              OnClick = Immobilisations12Click
            end
            object Subventions10: TMenuItem
              Caption = 'Subventions'
              OnClick = Subventions10Click
            end
          end
          object PlusetMoinsvaluesfiscales1: TMenuItem
            Caption = 'Plus et Moins values fiscales'
            OnClick = PlusetMoinsvaluesfiscales1Click
            object Dtaille1: TMenuItem
              Caption = 'D'#233'taill'#233'e'
              OnClick = Dtaille1Click
            end
            object Synthse2: TMenuItem
              Caption = 'Synth'#232'se'
              OnClick = Synthse2Click
            end
            object Compte3chiffres1: TMenuItem
              Caption = 'Synth'#232'se compte '#224' 3 chiffres'
              OnClick = Compte3chiffres1Click
            end
          end
          object Plusetmoinsvaluescomptables2: TMenuItem
            Caption = 'Plus et moins values comptables'
            OnClick = Plusetmoinsvaluescomptables2Click
            object Dtaille2: TMenuItem
              Caption = 'D'#233'taill'#233'e'
              OnClick = Dtaille2Click
            end
            object Synthse3: TMenuItem
              Caption = 'Synth'#232'se'
              OnClick = Synthse3Click
            end
            object Synthsecompte3chiffres1: TMenuItem
              Caption = 'Synth'#232'se compte '#224' 3 chiffres'
              OnClick = Synthsecompte3chiffres1Click
            end
          end
          object Amortissementsur5ans1: TMenuItem
            Caption = 'Amortissement sur 5 ans'
            OnClick = Amortissementsur5ans1Click
            object immosSur5Ans1: TMenuItem
              Caption = 'Immobilisations'
              OnClick = immosSur5Ans1Click
            end
            object subventionSur5ans1: TMenuItem
              Caption = 'Subventions'
              OnClick = subventionSur5ans1Click
            end
          end
        end
      end
      object JournauxTVA1: TMenuItem
        Caption = 'Journaux TVA'
      end
      object EditionBalance1: TMenuItem
        Caption = 'Balance'
        OnClick = EditionBalance1Click
      end
      object EditionBalanceTiers2: TMenuItem
        Caption = 'Balance Tiers'
        OnClick = EditionBalanceTiers2Click
      end
      object Balancedouverture1: TMenuItem
        Caption = 'Balance d'#39'ouverture'
        OnClick = Balancedouverture1Click
      end
      object ChargesetProduitsN11: TMenuItem
        Caption = 'Charges et Produits N-1'
        OnClick = ChargesetProduitsN11Click
      end
      object DettesetCrances1: TMenuItem
        Caption = 'Dettes et Cr'#233'ances'
        OnClick = DettesetCrances1Click
        object avecprcision1: TMenuItem
          Caption = 'Avec choix de la p'#233'riode'
          OnClick = avecprcision1Click
        end
        object sansprcision1: TMenuItem
          Caption = 'Calcul rapide'
          OnClick = sansprcision1Click
        end
        object SurEcheance1: TMenuItem
          Caption = 'Sur Echeance'
          OnClick = SurEcheance1Click
        end
      end
      object Analytique2: TMenuItem
        Caption = 'Analytique'
        OnClick = mnMethodesClick
        object GrandlivredesAteliers1: TMenuItem
          Caption = 'Grand livre des Ateliers'
          OnClick = GrandlivredesAteliers1Click
        end
        object BalancedesAtelier1: TMenuItem
          Caption = 'Balance des Ateliers'
          OnClick = BalancedesAtelier1Click
        end
        object Grandlivredesactivits1: TMenuItem
          Caption = 'Grand livre des activit'#233's'
          OnClick = Grandlivredesactivits1Click
        end
        object Balancedesactivits1: TMenuItem
          Caption = 'Balance des activit'#233's'
          OnClick = Balancedesactivits1Click
        end
        object Listedesateliers1: TMenuItem
          Caption = 'Liste des ateliers'
          OnClick = Listedesateliers1Click
        end
        object Listedesactivits1: TMenuItem
          Caption = 'Liste des activit'#233's'
          OnClick = Listedesactivits1Click
        end
      end
      object VA1: TMenuItem
        Caption = 'TVA'
        OnClick = mnMethodesClick
        object EcrituresavecTVA1: TMenuItem
          Caption = 'Ecritures avec TVA'
          OnClick = EcrituresavecTVA1Click
        end
      end
      object Emprunts2: TMenuItem
        Caption = 'Emprunts'
        OnClick = Emprunts2Click
        object ableauMensueldeTresorerie1: TMenuItem
          Caption = 'Tableau Mensuel de Tresorerie'
          OnClick = ableauMensueldeTresorerie1Click
          object riparcodeemprunt1: TMenuItem
            Caption = 'Edition tri'#233'e pas code emprunt'
            OnClick = riparcodeemprunt1Click
          end
          object ripardatederalisation1: TMenuItem
            Caption = 'Edition tri'#233'e par date de r'#233'alisation'
            OnClick = ripardatederalisation1Click
          end
        end
        object Mouvementdelexercice1: TMenuItem
          Caption = 'Mouvement de l'#39'exercice'
          OnClick = Mouvementdelexercice1Click
        end
        object Rpartitiondesannuits1: TMenuItem
          Caption = 'R'#233'partition des annuit'#233's'
          OnClick = Rpartitiondesannuits1Click
        end
        object ableauprvisionnel1: TMenuItem
          Caption = 'Tableau pr'#233'visionnel'
          OnClick = ableauprvisionnel1Click
        end
        object ableaudesemprunstslongsterme1: TMenuItem
          Caption = 'Tableau des emprunsts'
          OnClick = ableaudesemprunstslongsterme1Click
        end
      end
      object rames1: TMenuItem
        Caption = 'Trames'
        OnClick = rames1Click
      end
      object DPI: TMenuItem
        Caption = 'D.P.I.'
        OnClick = DPIClick
        object DPIpratiques1: TMenuItem
          Caption = 'DPI pratiqu'#233'es'
          OnClick = DPIpratiques1Click
        end
        object UtilisationsdesDPI1: TMenuItem
          Caption = 'Utilisations des DPI'
          OnClick = UtilisationsdesDPI1Click
        end
        object RintgrationdesDPI1: TMenuItem
          Caption = 'R'#233'int'#233'gration des DPI'
          OnClick = RintgrationdesDPI1Click
        end
      end
      object Balancecomparative1: TMenuItem
        Caption = 'Balance comparative'
        OnClick = Balancecomparative1Click
      end
      object tableaudebord1: TMenuItem
        Caption = 'Tableau de bord'
        OnClick = tableaudebord1Click
      end
    end
    object mnGestion: TMenuItem
      Caption = '&Gestion'
      OnClick = mnMethodesClick
      object Edition1: TMenuItem
        Caption = 'Edition'
        Visible = False
      end
      object EtatdeVersement1: TMenuItem
        Caption = 'Etat de Versement'
        Visible = False
        OnClick = EtatdeVersement1Click
      end
      object Etatdegestionanalytique1: TMenuItem
        Caption = 'Etat de gestion analytique'
        Visible = False
        OnClick = Etatdegestionanalytique1Click
      end
      object Recherche1: TMenuItem
        Caption = 'Recherche'
        OnClick = Recherche1Click
      end
      object Analytique1: TMenuItem
        Caption = 'Analytique'
        OnClick = Analytique1Click
      end
      object TVA1: TMenuItem
        Caption = 'TVA'
        OnClick = mnMethodesClick
        object Nouvelledclaration1: TMenuItem
          Caption = 'Nouvelle d'#233'claration'
          OnClick = Nouvelledclaration1Click
        end
        object Anciennedclaration1: TMenuItem
          Caption = 'Ancienne d'#233'claration'
          OnClick = Anciennedclaration1Click
        end
        object Supprimerderniredclaration1: TMenuItem
          Caption = 'Supprimer derni'#232're d'#233'claration'
          OnClick = Supprimerderniredclaration1Click
        end
      end
      object Gestiondesemprunts1: TMenuItem
        Caption = 'Gestion des emprunts'
        OnClick = Gestiondesemprunts1Click
      end
      object Rsultats1: TMenuItem
        Caption = 'R'#233'sultats'
        OnClick = mnMethodesClick
        object EditionBilandouverture1: TMenuItem
          Caption = 'Edition Bilan d'#39'ouverture'
          OnClick = EditionBilandouverture1Click
        end
        object EditionFin1: TMenuItem
          Caption = 'Edition Fin'
          OnClick = EditionFin1Click
        end
      end
    end
    object mnImmobilisations: TMenuItem
      Caption = '&Immobilisations'
      OnClick = mnMethodesClick
      object mnMouvements: TMenuItem
        Caption = '&Mouvements'
        OnClick = mnMouvementsClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnFinExerciceImmo: TMenuItem
        Caption = '&Fin d'#39'exercice'
        OnClick = mnFinExerciceImmoClick
        object mnChoixAmortis: TMenuItem
          Caption = 'Choix des &amortissements'
          OnClick = mnChoixAmortisClick
        end
        object mnEditionsImmos: TMenuItem
          Caption = '&Editions'
          Visible = False
        end
        object mnChangeExercice: TMenuItem
          Caption = '&Changement d'#39'exercice'
          Visible = False
          OnClick = mnChangeExerciceClick
        end
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mnOuvertureImmo: TMenuItem
        Caption = '&Ouverture'
        OnClick = mnMethodesClick
        object mnPriodeAmortissement: TMenuItem
          Caption = '&P'#233'riode d'#39'amortissement'
          Visible = False
        end
        object mnPlanComptes: TMenuItem
          Caption = 'Plan des &comptes'
          OnClick = mnPlanComptesClick
        end
        object mnDescriptionOuverture: TMenuItem
          Caption = 'Description '#224' l'#39'&ouverture'
          OnClick = mnDescriptionOuvertureClick
        end
        object mnDescriptionPassageReel: TMenuItem
          Caption = 'Description si passage au &r'#233'el'
          Visible = False
          OnClick = mnDescriptionPassageReelClick
        end
      end
    end
    object mnCloture: TMenuItem
      Caption = '&Cl'#244'ture'
      OnClick = mnMethodesClick
      object Dotationamortissements1: TMenuItem
        Caption = 'Dotation aux amortissements'
        OnClick = mnMethodesClick
        object Genererlapiece1: TMenuItem
          Caption = 'G'#233'n'#233'rer la pi'#232'ce'
          OnClick = Genererlapiece1Click
        end
        object Supprimerlapiece1: TMenuItem
          Caption = 'Supprimer la pi'#232'ce'
          OnClick = Supprimerlapiece1Click
        end
        object Visualiserlapiece1: TMenuItem
          Caption = 'Visualiser la pi'#232'ce'
          OnClick = Visualiserlapiece1Click
        end
      end
      object StoksdeFin1: TMenuItem
        Caption = 'Stocks de Fin'
        OnClick = StoksdeFin1Click
      end
      object Autrescritures1: TMenuItem
        Caption = 'Autres '#233'critures d'#39'inventaire'
        OnClick = mnMethodesClick
        object Chargesrpartir2: TMenuItem
          Caption = 'Charges '#224' r'#233'partir'
          OnClick = Chargesrpartir2Click
        end
        object Chargesetproduitsconstatsdavance2: TMenuItem
          Caption = 'Charges et produits constat'#233's d'#39'avance'
          OnClick = Chargesetproduitsconstatsdavance2Click
        end
        object Chargespayeretproduitsrecevoir3: TMenuItem
          Caption = 'Charges '#224' payer et produits '#224' recevoir'
          OnClick = Chargespayeretproduitsrecevoir3Click
        end
        object Dpensedelentreprise1: TMenuItem
          Caption = 'D'#233'pense de l'#39'entreprise'
          Visible = False
          OnClick = Dpensedelentreprise1Click
        end
        object Provisions2: TMenuItem
          Caption = 'Provisions'
          OnClick = Provisions2Click
        end
      end
      object Verifavantcloture1: TMenuItem
        Caption = 'V'#233'rification des op'#233'rations de cl'#244'ture'
        OnClick = Verifavantcloture1Click
      end
      object Changementdexercice1: TMenuItem
        Caption = 'Changement d'#39'exercice'
        OnClick = Changementdexercice1Click
      end
      object SimulationVrouillageFin1: TMenuItem
        Caption = 'Simulation V'#233'rouillage Fin'
        OnClick = SimulationVrouillageFin1Click
      end
      object DductionDPI1: TMenuItem
        Caption = 'D'#233'ductions pour investissement (DPI)'
        OnClick = DductionDPI1Click
        object SaisiedesDPIetleursutilisations1: TMenuItem
          Caption = 'Saisie des DPI et leurs utilisations'
          OnClick = SaisiedesDPIetleursutilisations1Click
        end
        object RintgrationdesDPI2: TMenuItem
          Caption = 'R'#233'int'#233'gration des DPI ('#233'dition)'
          OnClick = RintgrationdesDPI2Click
        end
      end
    end
    object mnOutils: TMenuItem
      Caption = 'Ou&tils'
      OnClick = mnMethodesClick
      object Autresprogrammes1: TMenuItem
        Caption = 'Autres programmes'
        OnClick = Autresprogrammes1Click
        object CompteFTP1: TMenuItem
          Caption = 'Serveur FTP'
          OnClick = CompteFTP1Click
        end
        object InternetExplorer1: TMenuItem
          Caption = 'Internet Explorer'
          OnClick = InternetExplorer1Click
        end
        object Explorateurwindows1: TMenuItem
          Caption = 'Explorateur windows'
          OnClick = Explorateurwindows1Click
        end
        object Internet2: TMenuItem
          Caption = 'Internet'
          OnClick = Internet2Click
          object EMail2: TMenuItem
            Caption = 'E-Mail'
            OnClick = EMail2Click
          end
          object Web2: TMenuItem
            Caption = 'Web'
            OnClick = Web2Click
          end
          object News2: TMenuItem
            Caption = 'News'
            OnClick = News2Click
          end
        end
        object Rechercher2: TMenuItem
          Caption = 'Rechercher ....'
          OnClick = Rechercher2Click
        end
        object RepertoireSauvegardes1: TMenuItem
          Caption = 'R'#233'pertoire Sauvegardes'
          OnClick = RepertoireSauvegardes1Click
        end
        object LgrDoss2: TMenuItem
          Caption = 'LgrDoss'
          OnClick = LgrDoss2Click
        end
        object InsallerAdobeReader1: TMenuItem
          Caption = 'Installer Adobe Reader'
          OnClick = InsallerAdobeReader1Click
        end
      end
      object mnMessage: TMenuItem
        Caption = '&Message'
        Enabled = False
        Visible = False
        OnClick = mnMessageClick
      end
      object mnAfficheEspion: TMenuItem
        Caption = '&Affiche Espion'
        Checked = True
        Visible = False
        OnClick = mnAfficheEspionClick
      end
      object mnLectureTable: TMenuItem
        Caption = '&Lecture Table'
        Enabled = False
        Visible = False
        OnClick = mnLectureTableClick
      end
      object mnRequeteSql: TMenuItem
        Caption = '&Requ'#234'te SQL'
        Enabled = False
        Visible = False
        OnClick = mnRequeteSqlClick
      end
      object mnOptionsMenu: TMenuItem
        Caption = '&Options Menu'
        Enabled = False
        Visible = False
        OnClick = mnOptionsMenuClick
      end
      object OptionsLicence1: TMenuItem
        Caption = 'Options Licence'
        Enabled = False
        Visible = False
        OnClick = OptionsLicence1Click
      end
      object Proprits1: TMenuItem
        Caption = 'Propri'#233't'#233's'
        OnClick = Proprits1Click
      end
      object MenuPrincipal1: TMenuItem
        Caption = 'Menu Principal'
        Visible = False
        OnClick = MenuPrincipal1Click
      end
      object Bureau1: TMenuItem
        Caption = 'Bureau'
        OnClick = Bureau1Click
      end
      object AffichInfoComposant1: TMenuItem
        Caption = 'AffichInfoComposant'
        ShortCut = 24694
        Visible = False
        OnClick = AffichInfoComposant1Click
      end
      object AffichInfoObjet1: TMenuItem
        Caption = 'AffichInfoObjet'
        ShortCut = 24695
        Visible = False
        OnClick = AffichInfoObjet1Click
      end
      object VideTAble1: TMenuItem
        Caption = 'VideTAble'
        OnClick = VideTAble1Click
      end
      object Sauvegarde1: TMenuItem
        Caption = 'Sauvegarde ...'
        OnClick = Sauvegarde1Click
      end
      object ImportTrame1: TMenuItem
        Caption = 'Import Trame'
        OnClick = ImportTrame1Click
      end
      object ImportationE2FAC1: TMenuItem
        Caption = 'Importations'
        OnClick = ImportationE2FAC1Click
        object Importationcaisse1: TMenuItem
          Caption = 'Importation CAISSE'
          OnClick = Importationcaisse1Click
        end
        object ImportationE2Fac2: TMenuItem
          Caption = 'Importation FACTURE'
          OnClick = ImportationE2Fac2Click
        end
        object ImportationSARA2: TMenuItem
          Caption = 'Importation SARA'
          OnClick = ImportationSara2Click
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object Dernierrapporterreur1: TMenuItem
          Caption = 'Dernier rapport d'#39'erreurs pi'#232'ces'
          OnClick = Dernierrapporterreur1Click
        end
        object Dernierrapporterreurpointages1: TMenuItem
          Caption = 'Dernier rapport d'#39'erreur pointages'
          OnClick = Dernierrapporterreurpointages1Click
        end
        object EnvoierapportparEmail1: TMenuItem
          Caption = 'Envoie rapport par E-mail'
          OnClick = EnvoierapportparEmail1Click
        end
      end
      object Restauration1: TMenuItem
        Caption = 'Restauration'
        OnClick = Restauration1Click
      end
      object MaintenanceSpciale1: TMenuItem
        Caption = 'Maintenance Sp'#233'ciale'
        ShortCut = 24699
        Visible = False
        OnClick = MaintenanceSpciale1Click
      end
      object Priseenmainmaintenance1: TMenuItem
        Caption = 'PC Assistance'
        OnClick = Priseenmainmaintenance1Click
      end
      object ParamtresSystmes1: TMenuItem
        Caption = 'Param'#232'tres Syst'#232'mes'
        OnClick = mnMethodesClick
        object Choisiruneimprimante1: TMenuItem
          Caption = 'Choisir une imprimante'
          Visible = False
          OnClick = Choisiruneimprimante1Click
        end
        object LecteursRseaux1: TMenuItem
          Caption = 'Lecteurs R'#233'seaux'
          Visible = False
        end
        object Modem1: TMenuItem
          Caption = 'Modem'
          Visible = False
        end
        object Envoiehistoriquedansdossier1: TMenuItem
          Caption = 'Envoie historique dans dossier'
          OnClick = Envoiehistoriquedansdossier1Click
        end
        object EnvoiehistoriqueparEmail1: TMenuItem
          Caption = 'Envoie historique par Email'
          OnClick = EnvoiehistoriqueparEmail1Click
        end
        object Historique1: TMenuItem
          Caption = 'Historique'
          OnClick = Historique1Click
        end
        object Historiquecorrection1: TMenuItem
          Caption = 'Historique correction'
          OnClick = Historiquecorrection1Click
        end
        object Decimal1: TMenuItem
          Caption = 'Decimal "."'
          Visible = False
          OnClick = Decimal1Click
        end
        object Rgnrationdestables1: TMenuItem
          Caption = 'R'#233'g'#233'n'#233'ration des tables'
          OnClick = Rgnrationdestables1Click
        end
        object Requetesql1: TMenuItem
          Caption = 'Requete sql'
          OnClick = Requetesql1Click
        end
        object GestionduBDE1: TMenuItem
          Caption = 'Param'#232'trage du BDE'
          Visible = False
          OnClick = GestionduBDE1Click
        end
      end
      object Typeclient1: TMenuItem
        Caption = 'Type client'
        OnClick = Typeclient1Click
      end
      object Corrections1: TMenuItem
        Caption = 'Corrections g'#233'n'#233'rales'
        OnClick = Corrections1Click
      end
      object CrationDuFichierAffichResult1: TMenuItem
        Caption = 'Cr'#233'ation Du Fichier AffichResult'
        ShortCut = 24689
        Visible = False
        OnClick = CrationDuFichierAffichResult1Click
      end
      object ExportationDonnes1: TMenuItem
        Caption = 'Exportation Donn'#233'es'
        OnClick = ExportationDonnes1Click
        object BalanceAnalytique1: TMenuItem
          Caption = 'Balance Analytique'
          OnClick = BalanceAnalytique1Click
        end
        object Grandlivreanalytique1: TMenuItem
          Caption = 'Grand livre analytique'
          OnClick = Grandlivreanalytique1Click
        end
        object BalanceExport1: TMenuItem
          Caption = 'Balance'
          OnClick = BalanceExport1Click
        end
        object BalanceAvecSeparateur1: TMenuItem
          Caption = 'Balance avec s'#233'parateurs'
          OnClick = BalanceAvecSeparateur1Click
        end
        object BalanceCerfaLiasseAsc: TMenuItem
          Caption = 'Balance CerfaLiasse (.asc)'
          OnClick = BalanceCerfaLiasseAscClick
        end
        object BalanceCerfaLiasse1: TMenuItem
          Caption = 'Balance CerfaLiasse (.xls)'
          OnClick = BalanceCerfaLiasse1Click
        end
        object BalancedesTiers2: TMenuItem
          Caption = 'Balance des Tiers'
          OnClick = BalancedesTiers2Click
        end
        object Plancomptable2: TMenuItem
          Caption = 'Plan comptable'
          OnClick = Plancomptable2Click
        end
        object PlanAuxiliaire2: TMenuItem
          Caption = 'Plan Auxiliaire'
          OnClick = PlanAuxiliaire2Click
        end
        object GrandLivre2: TMenuItem
          Caption = 'Grand Livre'
          OnClick = GrandLivre2Click
          object avecsoldeprogressif1: TMenuItem
            Caption = 'avec solde progressif'
            OnClick = avecsoldeprogressif1Click
          end
          object avecquantit1: TMenuItem
            Caption = 'avec quantit'#233
            OnClick = avecquantit1Click
          end
          object normale1: TMenuItem
            Caption = 'avec prix unitaire'
            OnClick = normale1Click
          end
        end
        object GrandlivredesTiers2: TMenuItem
          Caption = 'Grand livre des Tiers'
          OnClick = GrandlivredesTiers2Click
        end
        object Journaux3: TMenuItem
          Caption = 'Journaux'
          OnClick = Journaux3Click
        end
        object Journaldespices2: TMenuItem
          Caption = 'Journal des pi'#232'ces'
          OnClick = Journaldespices2Click
        end
        object Exportationdescritures1: TMenuItem
          Caption = 'Exportation des '#233'critures'
          OnClick = Exportationdescritures1Click
        end
        object Liassefiscale2: TMenuItem
          Caption = 'Export. pour Analyse Economique'
          OnClick = Liassefiscale2Click
        end
      end
      object Epuration1: TMenuItem
        Caption = 'Epuration'
        OnClick = Epuration1Click
      end
      object Requeteisa1: TMenuItem
        Caption = 'Requete isa'
        Visible = False
        OnClick = Requeteisa1Click
      end
      object Calcul1: TMenuItem
        Caption = 'Essai'
        Visible = False
        OnClick = Calcul1Click
      end
      object Associationavecoutilrestauration1: TMenuItem
        Caption = 'Param'#232'trage MDCogere'
        OnClick = Associationavecoutilrestauration1Click
      end
    end
    object mnAffichage: TMenuItem
      Caption = '&Fen'#234'tres'
      Visible = False
      OnClick = mnMethodesClick
    end
    object mnAide: TMenuItem
      Caption = '&Aide'
      OnClick = mnMethodesClick
      object mnApropos: TMenuItem
        Caption = '&A Propos ...'
        OnClick = mnAproposClick
      end
      object InfosVersion1: TMenuItem
        Caption = 'Infos Version ...'
        Visible = False
        OnClick = InfosVersion1Click
      end
      object VosSuggestionsEMail1: TMenuItem
        Caption = 'Vos Suggestions (E-Mail)'
        OnClick = VosSuggestionsEMail1Click
      end
    end
    object N030920021: TMenuItem
      Caption = 'Version du En Instance'
      OnClick = N030920021Click
    end
  end
  object timHeure: TTimer
    OnTimer = timHeureTimer
    Left = 68
    Top = 188
  end
  object ImageList1: TImageList
    Left = 202
    Top = 213
    Bitmap = {
      494C010105000A00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      8000FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      8000FFFF0000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C00000000000000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000FFFF000000000000FFFF000000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000C0C0
      C00000000000000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00000000000000000000FFFF0000000000FFFFFF00FFFF
      FF000000000000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000000000000000000000000000C0C0
      C00000000000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF00000000000000FFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FF000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000FF0000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FF00000000000000000000000000000000000000C0C0
      C00000000000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF00000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF00000000000000000000000000000000000000000000FF
      FF0000000000FFFFFF00FFFFFF000000000000000000FF000000FF0000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000FF0000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFFFF000000
      000000000000FFFFFF00FFFFFF0000000000000000000000000000000000FF00
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FF000000000000000000000000000000000000000000000000000000C0C0
      C00000000000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000008000000080000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF00000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FF0000000000000000000000FFFFFF0000000000FFFFFF0000000000FF00
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFF0000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000FF000000FF00000000000000FFFFFF0000000000FF0000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C00000000000C0C0C00000000000C0C0C0000000FF000000FF000000FF00C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      80000000800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000FF00000000000000FF000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      FF00FFFFFF00FF000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFFFF00FFFFFF0000000000FFFFFF000000
      FF00FFFFFF00FF000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF00FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00802020000000000080800000C0A06000
      C0A0600040800000802020008080000000A0E0004060A00040C0E00040C0E000
      00000000000000000000000000000000C0A0600080202000C0A0600080800000
      808000004080200040800000C0A0600040C0E000006080000000000080E0E000
      00000000000000000000000000000000FFFF00008020200000000000C0A06000
      000060004080000000008000C0C060000000E00000A0E0000000000040C0E000
      0000000000000000000000000000000000000000802020000000000040800000
      000000004080000000008000408020000000E00040C0E0000000000040C0E000
      FFFF000000000000FFFF000000000000FFFFC007C007FC00FE3FC007C007FC00
      F81FC007C0072000F40FC007C0070000E007C007C00700008003C007C0070000
      4001C007C00700000000C007C00700000000C007C00700008001C007C0070000
      C003C007C007E000E00FC007C007F800F07FC007C007F000F8FFC007C007E001
      FFFFC007C007C403FFFFC007C007EC0700000000000000000000000000000000
      000000000000}
  end
  object ImageList2: TImageList
    Left = 26
    Top = 213
    Bitmap = {
      494C010105000A00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000008080
      8000000000000000000080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000000000000000000000000000000000000000000080808000FFFF
      FF00808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF0000000000000000000000000000000000808080008080
      8000808080000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080008080800000000000000000000000000000000000000000000000
      0000000000008080800080808000808080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF0080808000FFFFFF0080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000000000000000000000000000008080
      8000FFFFFF008080800080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0080808000000000000000000000000000000000000000
      00008080800000000000FFFFFF00FFFFFF008080800000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00808080008080800080808000808080008080800080808000808080000000
      000080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF0000000000FFFFFF0080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000000000000000000000000000000000
      0000808080000000000080808000FFFFFF000000000080808000808080000000
      000080808000FFFFFF0000000000808080000000000000000000000000008080
      800000000000FFFFFF0000000000000000000000000080808000808080008080
      800000000000000000000000000000000000000000000000000080808000FFFF
      FF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
      FF0080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000000000000080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000000000000000000000000000000000
      0000000000008080800000000000808080000000000000000000FFFFFF00FFFF
      FF00808080008080800080808000808080000000000000000000808080000000
      0000FFFFFF000000000000000000000000008080800000000000FFFFFF00FFFF
      FF0080808000808080000000000000000000000000000000000080808000FFFF
      FF0080808000808080008080800080808000808080008080800080808000FFFF
      FF0080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000000000000080808000808080000000000000000000000000000000
      000080808000FFFFFF0000000000000000000000000000000000000000008080
      8000808080008080800080808000000000008080800000000000000000000000
      000000000000FFFFFF00FFFFFF0080808000000000008080800000000000FFFF
      FF000000000000000000000000008080800000000000FFFFFF00000000000000
      000000000000FFFFFF008080800000000000000000000000000080808000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000000000000080808000FFFFFF00FFFFFF0000000000000000000000
      000080808000FFFFFF0000000000000000008080800080808000808080000000
      0000FFFFFF00FFFFFF0080808000808080000000000080808000000000000000
      0000808080008080800000000000808080008080800000000000FFFFFF000000
      000000000000000000008080800000000000FFFFFF0000000000000000000000
      000000000000808080000000000080808000000000000000000080808000FFFF
      FF00808080000000000080808000000000008080800000000000808080000000
      000080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000000000000080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000008080800080808000FFFFFF00FFFF
      FF00808080008080800080808000808080008080800080808000808080000000
      000000000000FFFFFF00FFFFFF00808080008080800080808000000000000000
      0000000000008080800000000000FFFFFF000000000000000000000000000000
      000080808000000000008080800080808000000000000000000080808000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000000000000080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000008080800080808000FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      80000000000000000000000000008080800080808000FFFFFF00808080000000
      00008080800000000000FFFFFF00000000000000000000000000000000008080
      8000000000008080800080808000FFFFFF00000000000000000080808000FFFF
      FF00808080000000000080808000000000008080800000000000808080000000
      000080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000000000000080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000008080800080808000FFFFFF000000
      0000000000000000000080808000808080008080800080808000808080000000
      0000808080000000000000000000808080000000000080808000808080008080
      800000000000FFFFFF0000000000000000000000000000000000808080000000
      00008080800080808000FFFFFF0000000000000000000000000080808000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000000000000080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000008080800080808000FFFFFF000000
      0000000000000000000000000000FFFFFF00FFFFFF0080808000FFFFFF008080
      800080808000FFFFFF0000000000808080000000000000000000FFFFFF008080
      8000808080008080800000000000000000000000000080808000000000008080
      800080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00808080000000000080808000000000008080800000000000808080000000
      000080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000000000000080808000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000008080800080808000FFFFFF000000
      0000000000000000000080808000808080008080800000000000FFFFFF000000
      0000FFFFFF008080800000000000808080000000000000000000000000000000
      000080808000FFFFFF0080808000000000008080800000000000808080008080
      8000FFFFFF00000000000000000000000000000000000000000080808000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF00000000008080800000000000FFFFFF000000000000000000000000000000
      000080808000FFFFFF0000000000000000008080800080808000808080000000
      0000000000000000000000000000FFFFFF0080808000FFFFFF00000000000000
      00000000000000000000FFFFFF00808080000000000000000000000000000000
      000000000000808080008080800080808000000000008080800080808000FFFF
      FF0000000000000000000000000000000000000000000000000080808000FFFF
      FF00808080000000000080808000000000008080800080808000808080000000
      000080808000FFFFFF000000000000000000000000000000000080808000FFFF
      FF008080800000000000FFFFFF00000000000000000000000000000000000000
      000080808000FFFFFF0000000000000000008080800080808000FFFFFF008080
      80008080800080808000808080008080800000000000FFFFFF00808080000000
      0000808080008080800000000000808080000000000000000000000000000000
      00000000000000000000FFFFFF00808080008080800080808000FFFFFF000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF0000000000000000000000000000000000808080008080
      800000000000FFFFFF0000000000000000000000000000000000000000000000
      000080808000FFFFFF00000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00808080000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      800000000000FFFFFF0000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00808080008080
      8000808080008080800000000000000000000000000080808000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00808080008080
      80008080800080808000FFFFFF00000000000000000080808000FFFFFF000000
      0000000000008080800000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000080808000FFFFFF008080
      80000000000080808000FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF008080
      8000FFFFFF0080808000FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00808080008080
      8000000000008080800080808000000000000000000080808000808080008080
      80008080800080808000FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00808080008080
      8000000000008080800080808000000000008080800080808000808080000000
      0000808080008080800000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0000000000FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF007B2908FDF52FDF75AEDEEFFA4DCD8CD8
      572E9D6B302F824B84DC00648094094E3CFA26CB93B4A3E2367F4A9D74B62EFB
      71274A7006D402960EB73C1107163233F499F8F8DDF56185FEEFCCFCDF7F7DA0
      8D44A80B3D838CC885A2402980E880BE7ABB89B9537801022B515DF5BDBB3FA2
      1E132ACDAF80326A81323A28E30A110880009D4DCC8732DA00003E88C7DFACF6
      24880248432C2518091231C25466655024C08FCA11F87D4F098054993BDE7777
      3F801B4578D120032188273A72030201019ADDBFB6D6CEBF03BEECE7ACCEA5F4
      000058E0E6E48988000092E4960D0083600659B7159BC19E0000BBCAC535F7B3
      FFFFF1292906527AFFFF101310428307FF3FE00BC003FC00FC1FCA83CBF39068
      F88FC513C5F30092F147CAA3CAF31E3CC3A3C553CCF31C528BD1CAA3CCF31E02
      15E8C553CCF31C163AF4CAA3CCF3180E5D7AC553CCF30018AEB9C803CC7310B2
      D743C003CCF3E178EB8FC003CCF3FAC0F47FC013C8F3F492F8FFCFF3C0F3E0F1
      FFFFD007C003C403FFFFE00FC007EC0700000000000000000000000000000000
      000000000000}
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'epi'
    Filter = 'Dossier Epicea|*.epi'
    Options = [ofHideReadOnly, ofNoChangeDir, ofShowHelp]
    Title = 'Ouverture Dossier'
    Left = 200
    Top = 303
  end
  object PopupMenu1: TPopupMenu
    Left = 104
    Top = 207
    object Aide1: TMenuItem
      Caption = 'Aide'
      OnClick = Aide1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MultiDossier1: TMenuItem
      Caption = 'Multi-Dossier'
      ShortCut = 123
      OnClick = MultiDossier1Click
    end
  end
  object ImageList3: TImageList
    BlendColor = 15399679
    BkColor = 15399679
    DrawingStyle = dsTransparent
    Height = 32
    Width = 32
    Left = 120
    Top = 315
    Bitmap = {
      494C010112001300040020002000FFFAEA00FF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000080000000A000000001002000000000000040
      010000000000000000000000000000000000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF04040202000402020404020204040202040402
      0200040202040402020404020204040202000402020404020204040202040402
      020004020204040202040402020404020200000000008080800000000000C0C0
      C000C0C0C00000000000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FF000000FF000000FF000000FF000000C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FFFFFF00FFFFFF00C0C0C00000000000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0020202000BFBFB000D0CFCF00CFCF
      C000CFCFC000CFC0C000C0C0BF00C0BFBF00C0BFBF00C0BFBF00BFBFB000BFB0
      B000B0B0AF00B0AFAF00B0AFAF00AFAFA000BFAFAF00AF6F6F00BFA09F00EFE0
      E000F0EFEF00D0AFB00090303000A05F5F00B07F8F00DFBFC000C0808F00D0AF
      AF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF04040202040402020404020200FEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFEFEFEFE00FEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FE00FEFEFEACACAEAEACACAEAE0404020200000000008080800000000000C0C0
      C000C0C0C000C0C0C00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF000000FFFFFF00FFFF
      FF00C0C0C000FF000000FF000000C0C0C000FFFFFF00FFFFFF0000000000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0020202000BFBFB000D0CFCF00CFCF
      C000CFC0C000C0C0BF00C0BFBF00C0BFBF00BFBFB000BFB0B000BFB0B000B0B0
      AF00B0AFAF00B0AFAF00AFAFA000AFA0A000BFAFAF00D0AFB000EFDFE000FFFF
      FF00FFFFFF00E0C0CF00BF7F8000C0909F00C08F9000B06F70009F3F4000D0A0
      A000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      80008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF040402
      0200040202E0E0E0E0E0E0E0E00404020200FEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFEFEFEFE00FEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FE00FDFDFDACACAEAEACACAEAE04040202000000000080808000808080008080
      8000C0C0C000C0C0C00000000000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000C0C0C000FFFF
      FF00FFFFFF00FF000000FF000000FF000000FFFFFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0020202000BFB0AF00CFCFC000CFC0
      C000CFC0C000C0BFBF00C0BFB000BFBFB000BFB0B000BFB0AF00B0B0AF00B0AF
      AF00AFAFA000AFAFA000AFA0A000A0A09F00B0AFAF00E0D0D000EFE0E000F0EF
      F000F0EFEF00EFE0E000E0D0DF00CFAFB000BF7F8F00EAFAFF00EAFAFF00D0BF
      BF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF04040202040402024D4DCB
      D500E0E0E0E0E0E0E0E0E0E0E00404020200C6C6C6C6C6C6C6C6C6C6C6C6C6C6
      C600C6C6C6C6C6C6C6C6C6C6C6C6C6C6C600C6C6C6C6C6C6C6C6C6C6C6FBFBFB
      FB00FDFDFDDBDBDBDDDBDBDBDD04040202000000000080808000808080000000
      0000FFFFFF00C0C0C000C0C0C00000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FFFFFF00FFFFFF00C0C0C000FF000000FF000000FFFF
      FF00FFFFFF00C0C0C000FF000000FF000000C0C0C000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0020202000BFB0AF00CFCFC000C0BF
      BF00C0BFBF00C0BFBF00BFBFB000BFB0B000BFB0B000B0B0AF00B0AFAF00AFAF
      A000AFAFA000AFA0A000AFA0A000A09F9F00C0AFAF00DFBFC000E0D0D000EFDF
      DF00D0CFCF00C0C0C000AFAFAF007F707000AF808F00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      80008080800080808000808080008080800080808000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF04040202000402020404020204040202040402
      0200040202040402020404020204040202000402020404020204040202040402
      02000402020404020204040202040402020004020204040202C6C6C6C6FDFDFD
      FD00FDFDFDDBDBDBDDDBDBDBDD0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00C0C0C000FFFFFF00C0C0C000C0C0C00000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FF000000FF000000FFFFFF00FF000000FF000000FF00
      0000FFFFFF00FFFFFF00FF000000FF000000FF000000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0020202000B0AFAF00BFB0AF00CFC0
      BF00C0BFBF00BFBFB000BFB0B000BFB0AF00B0AFAF00B0AFAF00B0AFAF00AFA0
      A000AFA0A000A0A09F00A0A09F00B0A0A000CFAFB000DFBFC000DFBFC000D0BF
      BF00B0B0B0008F808000705050007F7F7F00AF9FA000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      80008080800080808000808080008080800080808000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF0404020204040202E0E0E0E000E0E0E004040202FEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFEFEFEFE00FEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEACACAEAE00ACAEAE04040202C6C6C6C6FDFDFD
      FD00FDFDFDDBDBDBDDDBDBDBDD0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008000
      00000000FF0080000000800000008000000080000000800000000000FF000000
      FF000000FF000000FF0000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00503F3F00EAFAFF00EAFAFF00202020002020200020202000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFDFDFDFD00FEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEACACAEAE00ACAEAE04040202C6C6C6C6FDFDFD
      FD00FDFDFDDBDBDBDDDBDBDBDD0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0080000000800000000000FF000000
      FF000000FF000000FF0000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF004F40
      20004F402F004F402F0000000000000000004F402F004F402F004F402F002020
      200020202000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FEFEFEFEFEFEFE
      FE00FEFEFEFCFCFCFDFCFCFCFDFBFBFBFC00FCFCFCFCFCFCFCFCFCFCFCFCFCFC
      FC00FDFDFDFCFCFCFCFEFEFEFEDBDBDBDD00DBDBDD04040202C6C6C6C6FDFDFD
      FD00FDFDFDACACAEAEACACAEAE0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF008000000080000000800000000000FF000000
      FF000000FF000000FF0000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000000000004F40
      20004F401F004F4020004F402F004F402F004F402F004F402F004F402F004F40
      2F004F402F000000000020202000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800080808000808080008080800080808000808080008080
      8000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFDFDFDFD00FEFEFEFEFEFEFEFEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEDBDBDBDD00DBDBDD04040202C6C6C6C6FDFDFD
      FD00FDFDFDACACAEAEACACAEAE0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00CFCFC000CFC0BF00BFB0AF00B0AFAF000000
      00005F302F003F3010004F401F004F4020004F402F004F402F004F402F004F40
      2F004F402F004F402F004F402F0020202000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EAFAFF00EAFAFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000808080008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFDFDFDFD00FDFDFDFDFDFDFDFDFDFDFDFDFDFD
      FD00FDFDFDFDFDFDFDFDFDFDFDDBDBDBDD00DBDBDD040402024C4C4E4E4C4C4E
      4E004C4E4E4C4C4E4E4C4C4E4E0404020200EAFAFF00EAFAFF00EAFAFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C00000000000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00DFD0D000DFD0D000DFD0CF00D0CFCF00CFC0BF00C0BFBF00BFB0
      AF0000000000504F2000403F10004F401F004F401F004F4020004F4020004F40
      20004F402F004F402F004F402F0020202000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EAFAFF00EAFAFF00EAFAFF00808080000000
      000080808000FFFFFF00FFFFFF00808080008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFDFDFDFD00FDFEFEFDFDFDFDFDFDFDFDFDFDFD
      FD00FDFDFDFDFDFDFDFDFDFDFDDBDBDBDD00DBDBDD04040202FFFF3535CDCD24
      2000FCFEFEACACAEAE4C4C4E4E0404020200EAFAFF0080808000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00DFD0
      D000DFD0D000DFD0D000DFD0D000D0D0CF00D0D0CF00D0CFCF00CFCFC000C0BF
      BF00302020003F3F3F003F3010003F3010004F401F003F3F3F003F3F3F003F3F
      1F004F401F004F4020004F402F004F402F0020202000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EAFAFF00EAFAFF00EAFAFF00000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFDFDFDFD00FDFEFEFDFDFEFEFDFDFDFDFDFDFD
      FD00FDFDFDFDFDFDFDFDFDFDFDACACAEAE00ACAEAE04040202FFFF3535FFFF00
      0000FF0000FFFF0000FFFF000004040202000000000080808000000000000000
      0000C0C0C000FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF000000FF00
      0000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FF00
      0000FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00CFC0C000DFD0D000DFD0
      D000DFD0D000D0D0CF00D0D0CF00D0CFC000D0CFCF00CFC0C000D0CFC000CFC0
      C000BFBFB000B0B0AF003F3F3F003F3F3F003F3010003F3F3F008F8F80003F3F
      3F003F3F3F003F3010004F401F004F40200020202000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      80008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FEFEFEFEFEFEFE
      FE00FEFEFEFEFEFEFEFEFEFEFEFDFDFDFD00FDFDFDFDFDFDFDFDFDFDFDFDFDFD
      FD00FDFDFDFDFDFDFDFDFDFDFDACACAEAE00ACAEAE0404020204040202040402
      020004020204040202040402020404020200C0C0C000C0C0C000C0C0C000C0C0
      C00000000000FFFFFF00FFFFFF00C0C0C000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FF000000FF000000FF000000FF00
      0000C0C0C000FFFFFF00FFFFFF00FFFFFF0000000000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0020202000CFC0BF00DFD0D000DFD0
      D000DFD0CF00D0D0CF00D0D0CF00CFCFC000CFCFC000CFC0C000CFC0BF00CFC0
      BF00C0BFB000C0BFB000BFBFB000BFB0B000000000007F7F7F00A09F9F008F8F
      80008F8F80003F3F3F005F5F2F00504F1F0020202000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      80008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E0040402024C4C4E4E4C4C4E
      4E004C4E4E4C4C4E4E4C4C4E4E4C4C4E4E004C4E4E4C4C4E4E4C4C4E4E4C4C4E
      4E004C4E4E4C4C4E4E4C4C4E4E4C4C4E4E004C4E4E0404020280808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      0000C0C0C000C0C0C0008080800080808000808080008080800000000000EAFA
      FF00EAFAFF00202020002020200090908F00A09F9F00AFA0A000AFA0A000AFAF
      A000AFAFA000AFA0A000AFA0A000A09F9F00A09F9F00A09F9F009F9F90009F9F
      90009F9F90007FAFD00060CFFF0070CFF000BFEFEF00AFD0CF00BFDFDF00B0DF
      DF00AFDFDF00AFDFDF00A0DFDF00BFE0DF00AFCFCF00A0A0A000BF9F8F00EAFA
      FF00EAFAFF0000000000000000008F8F90009F9FA000A0AFAF00A0AFAF00A0AF
      AF00A0AFAF00A0A0AF00A0A0AF009FA0A000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00FFFFFF00FFFFFF0080808000808080008080
      80008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FCFCFEFEACACAE
      AE004C4E4EFFFF0000FFFF0000FFFF000000FF0000FFFF00004C4C4E4EFCFCFE
      FE00ACAEAE4C4C4E4EFCFCFEFEACACAEAE004C4E4E0404020280808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00C0C0C00080808000808080008080800000000000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF002020200020202000807F7F009F9F9000A09F
      9F00A09F9F00AFA0A000A0A09F00A09F9F009F9F90009F9F90009F9090009F90
      90009F90900070A0D00050C0F00090DFF000A0FFFF008FEFEF008FE0EF008FE0
      EF008FE0EF008FEFEF008FE0EF0090E0EF007FAFBF00D0D0D000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF0000000000000000007F7F8000909F9F009FA0
      A0009FA0A000A0A0AF009FA0A0009FA0A000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00FFFFFF00FFFFFF0080808000808080008080
      80008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E004040202FFFF0000FFFF00
      0000FF0000FFFF0000FFFF0000FFFF000000FF0000FFFF0000FFFF0000FFFF00
      0000FF0000FFFF0000FFFF0000FFFF000000FF00000404020280808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080808000808080000000000000000000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF002020200020202000807F
      7F0090908F009F9F9000A09F9F009F9F90009F9F90009F90900090908F009090
      8F0090908F0060A0CF0050C0EF00A0EFF0008FF0FF0080F0FF008FF0FF008FF0
      FF008FF0FF008FF0FF0090FFFF006FE0FF00A0BFC000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0040404000404040007F7F
      80008F909000909F9F009F9FA000909F9F00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E00404020204040202040402
      0200040202040402020404020204040202000402020404020204040202040402
      0200040202040402020404020204040202000402020404020280808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF009F9090009F90900090908F009090
      8F0090908F00609FB00070CFEF00A0EFFF007FE0FF0080EFFF0080EFFF007FEF
      FF0070E0FF006FDFF0005FCFE0006FAFC000DFE0E000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF004040
      400040404000707F7F008F8F900090909F00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E0E0E0E0E000E0E0E09494AEB26C6C8E925C5C7A
      7A00FFFFFFFFFFFFFFFFFFFFFFFAFAFEFE003C9AAEFFFFFFFFFFFFFFFFFFFFFF
      FF00808080808080808080808080808080008080808080808080808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000000
      FF000000FF0000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202E0E0E0E0E0E0E0E09494AEB2006C8E925C5C7A7AFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFF808080808080808000C0C0C0808080800C0C4E50FFFFFF
      FF00FFFFFFFFFFFFFF0C0C424680808080008080808080808080808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0080000000800000000000
      FF000000FF0000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF000402029494AEB26C6C8E92FFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF0080808080808080808080808080808000C0C0C080808080808080802C2C5A
      6200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000C42468080808080808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00800000008000000080000000800000000000
      FF000000FF0000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      800080808000808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EAFAFF00EAFAFF00EAFAFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF000402025C5C7A7AFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFF80808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C080808080808080
      80008080808080808080808080FFFFFFFF00FFFFFFFFFFFFFF0C0C4246040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF0080000000800000008000000080000000800000000000FF000000
      FF000000FF0000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      80008080800080808000808080008080800080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EAFAFF00EAFAFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF040402
      0200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008080808080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C080808080808080
      800080808080808080808080808080808000808080FFFFFFFFFFFFFFFFFFFFFF
      FF00FFFFFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      8000808080008080800080808000808080008080800080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EAFAFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF0404020204040202FFFFFF
      FF00FFFFFF1111464AC0C0C0C0C0C0C0C0008080808080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C080808080808080
      8000808080808080808080808080808080008080803C3C768224245E6EFFFFFF
      FF00FFFFFF040402020404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      800080808000808080008080800080808000808080008080800080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF040402
      0200E0E0E0E0E0E0E0C0C0C0C0C0C0C0C000C0C0C08080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C080808080808080
      800080808080808080808080808080808000FAFEFEFAFAFEFEE0E0E0E0E0E0E0
      E00004020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF04040202E0E0E0
      E000E0E0E0E0E0E0E0E0E0E0E0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C08080808080808080FAFAFEFE00E0E0E0E0E0E0E0E0E0E0E0E0E0E0
      E000E0E0E00404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00404040004040400040404000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF005052800080000002012030006E330002000000003E20300000006E330100
      000460003E20000000000000000000000000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF04040202E0E0E0E0E0E0E0
      E000E0E0E0E0E0E0E0E0E0E0E0E0E0E0E000E0E0E0E0E0E0E0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C07474CAD8C0C0C0C0C0C0C0
      C000FAFEFEFAFAFEFE9494E2EEE0E0E0E000E0E0E0E0E0E0E0E0E0E0E0E0E0E0
      E000E0E0E0E0E0E0E00404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF0000000000FFFFFF00FFFFFF00FFFFFF00404040004040
      4000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF04040202040402
      0200E0E0E0E0E0E0E0E0E0E0E0E0E0E0E000E0E0E0E0E0E0E0E0E0E0E0E0E0E0
      E000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0FAFAFE
      FE009CE6F2E0E0E0E0E0E0E0E0E0E0E0E000E0E0E0E0E0E0E0E0E0E0E0E0E0E0
      E0000402020404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00B0B0B0003F3F3F00DFDFDF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000040404000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF0080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0004020204040202E0E0E0E0E0E0E0E000E0E0E0E0E0E0E0E0E0E0E0E0E0E0
      E000E0E0E09494E2EEC0C0C0C0C0C0C0C000C0C0C0FAFAFEFE9C9CE6F2E0E0E0
      E000E0E0E0E0E0E0E0E0E0E0E0E0E0E0E000E0E0E0E0E0E0E004040202040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0040404000B0BFBF00AFB0B0003F3F3F003F3F3F00DFDFDF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004040400040404000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF0080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF040402020404020200E0E0E0E0E0E0E0E0E0E0E0E0E0E0
      E000E0E0E0E0E0E0E0E0E0E0E00404020200040202E0E0E0E0E0E0E0E0E0E0E0
      E000E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0000402020404020200EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF005061746852656E616D6545787465
      6E73202020002020200020202000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0040404000C0CFCF00C0CFCF00B0BFBF00AFB0B0003F3F3F003F3F3F00DFDF
      DF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006070700060707000EAFAFF00EAFA
      FF00404040004040400040404000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0004020204040202E0E0E0E0E0E0E0
      E000E0E0E0E0E0E0E00404020200EAFAFF00EAFAFF04040202E0E0E0E0E0E0E0
      E000E0E0E0E0E0E0E0040402020404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00E900537472526574546F42756657
      0000EB00537472526574546F5374725700001200506174684164644261636B73
      6C61736857009E005348517565727956616C756545784100C400537472436174
      42756666410029005061746846696E6446696C654E616D654100CD0053747243
      6D704E494100BB00534853657456616C756541001301776E737072696E746641
      00009500534847657456616C756541008B00534844656C6574654F727068616E
      4B657941000069005061746852656D6F766546696C6553706563410089005348
      44656C6574654B65794100008D00534844656C65746556616C7565410000F400
      537472546F496E7445785700540050617468EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF04040202040402
      0200E0E0E00404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF04040202E0E0E0
      E000E0E0E00404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF006563570024005061746843726561
      746546726F6D55726C5700008A00534844656C6574654B6579570000FB005572
      6C43616E6F6E6963616C697A65570000AD005348526567476574426F6F6C5553
      56616C7565570000A0005348526567436C6F736555534B657900A60053485265
      6744656C657465555356616C75655700B10053485265674F70656E55534B6579
      5700D3005374724475704100CF00537472436D704E570000EF00537472537472
      494100007C0050617468556E71756F7465537061636573570000660050617468
      52656D6F7665426C616E6B73570002004173736F6351756572794B6579570000
      B7005348526567536574555356616C756557EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0004020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF006C74657200008A02536574457272
      6F724D6F64650000050147657443757272656E744469726563746F7279410000
      4E0252657365744576656E740000630044697361626C655468726561644C6962
      7261727943616C6C7300DD014C6F61644C696272617279410000CB0149734261
      64436F64655074720000C701496E7465726C6F636B656445786368616E676500
      850147657454696D65466F726D61744100000B0147657444617465466F726D61
      74410000970046696C6554696D65546F4C6F63616C46696C6554696D65005302
      52746C556E77696E6400D1005374724370794E570000CB00537472436D704957
      0000070155726C476574506172745700AF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF26262727262627272626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF80808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00262727262627272626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627
      2700262727979796950202030351514A1C002627272626272700EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080808080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF002627
      2700262727979796950202030311514A1C002627272626272700EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF26262727020203036E6E6A
      68007B7875878783813535353951514A1C000203032626272726262727262627
      2700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF80808080008080808080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727020203032E6E6A
      68007B7875878783813535353911514A1C000203032626272726262727262627
      2700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF26262727000203036C6C69677B7B787582827F
      7B008783818787837F3B3B3B3951514A1C000203030202030302020303262627
      270026272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF808080808080808080808080008080808080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00262727000203032C6C69673B7B787582827F
      7B008783818787837F3B3B3B3911514A1C000203030202030302020303262627
      270026272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF26262727020203036C6C696700807D7A82827F7B878783818E8E8A
      87008783818888817E3434353D51514A1C000203032626272726262727262627
      2700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00808080808080808080808080808080008080808080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00262727020203032C6C696700807D7A82827F7B878783818E8E8A
      87008783818888817E3434353D11514A1C000203032626272726262727262627
      2700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627
      27002627276C6C69678787837F87878381008F8A878D8D7E788E8E8A878E8E7E
      7C008B5652A0A0686F38383FB33A3A2C45003D221D2727262600EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00808080808080808080808080808080008080808080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF002627
      27002627272C6C69678787837F87878381008F8A878D8D7E788E8E8A878E8E7E
      7C008B5652A0A0686F38383FB33A3A2C45003D221D2727262600EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF26262727252526267B7B78
      75008C87859393908C8E8E8A8790908C88009D898A8989382D8888453E909035
      35008F1E1BA9A97F847474B1FF222243E6003D174AABAB5D4FABAB6160C9C999
      9500EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF808080
      8000808080808080808080808080808080008080808080808080808080808080
      800080808080808080808080808080808000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727252526263B7B78
      75008C87859393908C8E8E8A8790908C88009D898A8989382D8888453E909035
      35008F1E1BA9A97F843474B1FF222243E6003D174AABAB5D4FABAB616089C999
      9500EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF02020303000102027B7B78759393908C999994
      9100999491999994919595918D9393908C009B8F8DA5A5575D9393292B95952F
      32009931349E9E36399D9D72707474ADF8001F45EB3E3E144A86861707DDDDB9
      B900EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF80808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      80008080800000F0C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00020303000102023B7B78759393908C999994
      9100999491999994919595918D9393908C009B8F8DA5A5575D9393292B95952F
      32009931349E9E36399D9D72703474ADF8001F45EB3E3E144A868617079DDDB9
      B900EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF262627272626272782827F7B0095918D9F9F9B97A1A19D999F9F9B
      97009D99959A9A95929595908E9595918D009A8A8A9F9F484EA9A9585C8F8F70
      730084444AA3A3424B9E9E2D309C9C6D6C0074B0FA40405DD76C6C171CD2D29D
      9800EAFAFFBFBFC1C1ADADAEAE00EAFAFF00EAFAFF00EAFAFF80808080808080
      80008080808080808080808080808080800080808080808080808080800000F0
      C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C000EAFAFF00EAFAFF00EAFAFF00808080008080
      80008080800080808000808080008080800080808000808080008080800000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF002627272626272782827F7B0095918D9F9F9B97A1A19D999F9F9B
      97009D99959A9A95929595908E9595918D009A8A8A9F9F484EA9A9585C8F8F70
      730084444AA3A3424B9E9E2D309C9C6D6C0074B0FA00405DD72C6C171C92D29D
      9800EAFAFF00BFC1C1ADADAEAE00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627
      270026272782827F7B9F9F9B97A5A59F9C00A59F9CAAAAA5A1A6A6A19DA5A59F
      9C009D99959C9C98949A9A95929A9A959200A6767A9393282BA9A96769C4C4CE
      CE00898586828253598A8A3F4188882020009E595AAAAA98BC888878808F8F42
      3C00EAFAFF8E8E9292A4A4A8A800EAFAFF00EAFAFF8080808080808080808080
      800080808080808080808080808080808000808080808080800000F0C00000F0
      C00000F0C00000F0C00000F0C0000000FF000000FF000000FF0000F0C00000F0
      C00000F0C00000F0C00000F0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C000EAFAFF00EAFAFF0080808000808080008080
      800080808000808080008080800080808000808080008080800000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF002627
      270026272782827F7B9F9F9B97A5A59F9C00A59F9CAAAAA5A1A6A6A19DA5A59F
      9C009D99959C9C98949A9A95929A9A959200A6767A9393282BA9A9676984C4CE
      CE00898586828253598A8A3F4188882020009E595AAAAA98BC888878808F8F42
      3C00EAFAFF008E9292A4A4A8A800EAFAFF00EAFAFF2626272726262727939390
      8C00A19D99AAAAA5A3AAAAA5A3AEAEA8A500AFAAA6AAAAA5A1A8A8A4A0A5A59F
      9C00A29D9BA1A19D999C9C9894A3A37F7D009A3E408D8D2120AEAE636AC4C4A9
      AF00C6C9C9A2A2A2A293939291A9A999980097474DA0A0393BC9C9ACAC979792
      9100898281A0A09E9EB5B5B8B800EAFAFF00EAFAFF8080808080808080808080
      8000808080808080808080808080808080008080800000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C0000000FF000000FF000000FF0000F0C00000F0
      C00000F0C00000F0C00000F0C00000F0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000EAFAFF0080808000808080008080
      8000808080008080800080808000808080008080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF0026272726262727939390
      8C00A19D99AAAAA5A3AAAAA5A3AEAEA8A500AFAAA6AAAAA5A1A8A8A4A0A5A59F
      9C00A29D9BA1A19D999C9C9894A3A37F7D009A3E408D8D2120AEAE636A84C4A9
      AF00C6C9C9A2A2A2A293939291A9A999980097474DA0A0393B89C9ACAC979792
      9100898281A0A09E9EB5B5B8B800EAFAFF002627279393908CA6A6A19EB1B1AC
      A800B7B2AEBCBCB6B3B8B8B3AFB3B3AEAB00B2ADA9ACACA7A4ACACA7A4A6A6A1
      9E00A6A19EA2A29D9BA1A19C9AC9C9A2A900B06369B8B8757DCBCB9BA4BBBB94
      9C00AAA6A6A8A8A2A491915C60A6A6A3A3009B7B809A9A363FA2A26C70B8B8BE
      BF00BAB9B9C9C9C7C7DEDEDDDD00EAFAFF008080808080808080808080808080
      80008080808080808080808080808080800000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C00000F0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080800080808000808080008080
      80008080800080808000808080008080800000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0002627279393908CA6A6A19EB1B1AC
      A800B7B2AEBCBCB6B3B8B8B3AFB3B3AEAB00B2ADA9ACACA7A4ACACA7A4A6A6A1
      9E00A6A19EA2A29D9BA1A19C9A89C9A2A900B06369B8B8757D8BCB9BA4BBBB94
      9C00AAA6A6A8A8A2A491915C60A6A6A3A3009B7B809A9A363FA2A26C70B8B8BE
      BF00BAB9B989C9C7C79EDEDDDD00EAFAFF00262727B2B2ADAAB8B8B3AFC9C9C3
      BE00C4BEBABEBEB9B5BABAB4B0B8B8B3AE00B2ADA9B1B1ACA8B2B2ADA9ABABA6
      A300A9A4A0A6A6A19DA6A6A19EB0B0A4A500CFACB2DBDBBEC6DBDBBEC5D0D0BB
      BE00B7B2B188888384767650567F7F797A00AC9EA09898525BA3A37C7FC7C7CC
      CC00D9D9D9D5D5D3D300EAFAFF00EAFAFF008080808080808080808080808080
      80008080808080808080808080808080800000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C0000000FF000000FF000000FF0000F0C00000F0
      C00000F0C00000F0C00000F0C00000F0C00000F0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080800080808000808080008080
      80008080800080808000808080008080800000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000262727B2B2ADAAB8B8B3AF89C9C3
      BE00C4BEBABEBEB9B5BABAB4B0B8B8B3AE00B2ADA9B1B1ACA8B2B2ADA9ABABA6
      A300A9A4A0A6A6A19DA6A6A19EB0B0A4A500CFACB29BDBBEC69BDBBEC590D0BB
      BE00B7B2B188888384367650563F7F797A00AC9EA09898525BA3A37C7F87C7CC
      CC00D9D9D995D5D3D300EAFAFF00EAFAFF00262727B8B8B3AFCECEC8C4C4C4BE
      BA00C4BEBAC2C2BCB9BEBEB9B5BCBCB7B300BAB4B1B7B7B2AEB3B3ADAAAFAFAA
      A600AFAAA6A9A9A4A0A8A8A4A0A1A19C9A00C3A8ADD9D9BEC4E4E4D3D6EAEADB
      DE00D4CBCDC1C1C0C0AAAAADAD7F7F757700AF878EBEBEB3B6CFCFCFCFC5C5B2
      B300DBD8D800EAFAFF00EAFAFF00EAFAFF008080808080808080808080808080
      800080808080808080808080800000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C0000000FF000000FF000000FF0000F0C00000F0
      C00000F0C00000F0C00000F0C00000F0C00000F0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080800080808000808080008080
      800080808000808080008080800000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000262727B8B8B3AF8ECEC8C484C4BE
      BA00C4BEBA82C2BCB9BEBEB9B5BCBCB7B300BAB4B1B7B7B2AEB3B3ADAAAFAFAA
      A600AFAAA6A9A9A4A0A8A8A4A0A1A19C9A00C3A8AD99D9BEC4A4E4D3D6AAEADB
      DE00D4CBCD81C1C0C0AAAAADAD3F7F757700AF878EBEBEB3B68FCFCFCF85C5B2
      B300DBD8D800EAFAFF00EAFAFF00EAFAFF00262727B8B8B3AFCECEC8C4C9C9C3
      C000C9C3C0C4C4BEBAC0C0BBB6BFBFBAB600BDB7B4B8B8B3AFB7B7B2AEB2B2AD
      AA00AFAAA6ADADA8A5AAAAA5A3A6A6A19E00B4A9A8E3E3D2D6EDEDE1E4F5F5EE
      F000F1E9EBEBEBE0E2E6E6D7DCCDCDAAB200B87E88C1C18D95D3D3BABDD5D5B9
      BA00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080808080808080808080808080
      800080808080808080808080800000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C0000000FF000000FF000000FF0000F0C00000F0
      C00000F0C00000F0C00000F0C00000F0C00000F0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080800080808000808080008080
      800080808000808080008080800000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000262727B8B8B3AF8ECEC8C489C9C3
      C000C9C3C084C4BEBA80C0BBB6BFBFBAB600BDB7B4B8B8B3AFB7B7B2AEB2B2AD
      AA00AFAAA6ADADA8A5AAAAA5A3A6A6A19E00B4A9A8A3E3D2D6ADEDE1E4B5F5EE
      F000F1E9EBABEBE0E2A6E6D7DC8DCDAAB200B87E8881C18D9593D3BABD95D5B9
      BA00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727BEBEB9B5D4D4CFCACFCFC9
      C500C9C3C0C5C5C0BCC4C4BEBAC4C4BEBA00BEB9B5BCBCB6B3BABAB4B0B5B5B0
      AD00B2ADAAB2B2ADA9AEAEA8A5ACACA7A400B9ABABD3D3AEB5EDEDDFE2FBFBF8
      F900FCFAFBE1E1C6CCBBBB7E81C6C6949800C28D97B2B2697599993F44D1D1A7
      A300EAFAFF00EAFAFF00EAFAFF00EAFAFF008080808080808080808080808080
      800080808080808080808080800000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C0000000FF000000FF000000FF000000FF0000F0
      C00000F0C00000F0C00000F0C00000F0C00000F0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080800080808000808080008080
      800080808000808080008080800000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF000000FF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000262727BEBEB9B594D4CFCA8FCFC9
      C500C9C3C085C5C0BC84C4BEBA84C4BEBA00BEB9B5BCBCB6B3BABAB4B0B5B5B0
      AD00B2ADAAB2B2ADA9AEAEA8A5ACACA7A400B9ABAB93D3AEB5ADEDDFE2BBFBF8
      F900FCFAFBA1E1C6CCBBBB7E8186C6949800C28D97B2B2697599993F4491D1A7
      A300EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727BEBEB9B5D4D4CFCACFCFC9
      C500CEC8C4C9C9C3C0C5C5C0BCC5C5BFBB00C5BFBBC1C1BBB8BEBEB9B5B9B9B4
      B000B6B0ADB2B2ADA9B2B2ADAAAEAEA8A500BAACABAAAA6E6DBEBEA19DE8E8E3
      E500F3EEEFD4D4ADB694943031A7A7595C00B17F89DCDCBCC2C2C2878DD5D5AE
      AE00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C00000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C00000F0C0000000FF000000FF000000FF000000
      FF0000F0C00000F0C00000F0C00000F0C00000F0C08080808080808080808080
      800080808080808080808080808080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF000000
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0080808000808080008080
      800080808000808080008080800080808000262727BEBEB9B594D4CFCA8FCFC9
      C500CEC8C489C9C3C085C5C0BC85C5BFBB00C5BFBB81C1BBB8BEBEB9B5B9B9B4
      B000B6B0ADB2B2ADA9B2B2ADAAAEAEA8A500BAACABAAAA6E6DBEBEA19DA8E8E3
      E500F3EEEF94D4ADB694943031A7A7595C00B17F899CDCBCC282C2878D95D5AE
      AE00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727C2C2BCB9DADAD4CFD1D1CA
      C600CFC9C5CECEC8C4C9C9C3C0C9C9C3BE00C8C2BDC2C2BCB9C1C1BBB7BDBDB7
      B400BAB4B1B7B7B2AEB3B3AEABB2B2ADAA00B2ADAAAEAEA6A3ACACA7A4B1B1AC
      AA00BCB3B1DADABFC7A9A9656F7B7B5A44003D343600EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C00000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C00000F0C00000F0C00000F0C00000F0C0000000FF000000FF000000
      FF000000FF0000F0C00000F0C00000F0C00000F0C08080808080808080808080
      800080808080808080808080808080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000FF000000
      FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0080808000808080008080
      80008080800080808000808080008080800026272782C2BCB99ADAD4CF91D1CA
      C600CFC9C58ECEC8C489C9C3C089C9C3BE00C8C2BD82C2BCB981C1BBB7BDBDB7
      B400BAB4B1B7B7B2AEB3B3AEABB2B2ADAA00B2ADAAAEAEA6A3ACACA7A4B1B1AC
      AA00BCB3B19ADABFC7A9A9656F3B7B5A44003D343600EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727C2C2BCB9D6D6D0CCD1D1CA
      C600D4CFCACFCFC9C5CECEC8C4C9C9C3BF00C9C3BEC3C3BEBAC4C4BEBABEBEB9
      B500BDB7B4BABAB4B1B8B8B3AFB3B3AEAB00B3AEABB2B2ADAAAEAEA8A5A8A8A4
      A0009F9B979393908C3B3B3B3951514A1C0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C00000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C0000000FF0000F0C00000F0C00000F0C00000F0C0000000FF000000
      FF000000FF0000F0C00000F0C00000F0C00000F0C08080808080808080808080
      800080808080808080808080808080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000FF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000
      FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0080808000808080008080
      80008080800080808000808080008080800026272782C2BCB996D6D0CC91D1CA
      C600D4CFCA8FCFC9C58ECEC8C489C9C3BF00C9C3BE83C3BEBA84C4BEBABEBEB9
      B500BDB7B4BABAB4B1B8B8B3AFB3B3AEAB00B3AEABB2B2ADAAAEAEA8A5A8A8A4
      A0009F9B979393908C3B3B3B3911514A1C0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727C9C9C3BEDBDBD5D0DADAD4
      CF00D6D0CBD4D4CFCACFCFC9C5D1D1CAC600CCC6C2CACAC3C0C6C6C1BDC4C4BE
      BA00C1BBB8BEBEB9B5BABAB4B0B8B8B3AF00B7B2AEB1B1ACA8A8A8A4A0A1A19D
      99009A95928C8C87853B3B3B3951514A1C0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000F0C00000F0C00000F0C00000F0
      C0000000FF000000FF000000FF0000F0C00000F0C00000F0C0000000FF000000
      FF000000FF0000F0C00000F0C00000F0C00000F0C08080808080808080808080
      800080808080808080808080808080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FF
      FF000000FF000000FF000000FF0000FFFF0000FFFF0000FFFF000000FF000000
      FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0080808000808080008080
      80008080800080808000808080008080800026272789C9C3BE9BDBD5D09ADAD4
      CF00D6D0CB94D4CFCA8FCFC9C591D1CAC600CCC6C28ACAC3C086C6C1BD84C4BE
      BA00C1BBB8BEBEB9B5BABAB4B0B8B8B3AF00B7B2AEB1B1ACA8A8A8A4A0A1A19D
      99009A95928C8C87853B3B3B3911514A1C0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727C9C9C3BEDBDBD5D0DBDBD5
      D000DAD4CFD6D6D0CBD6D6D0CBCECEC8C400CEC8C4CACAC3C0C9C9C3BEC8C8C2
      BD00C1BBB7C0C0BBB6BEBEB9B5BCBCB6B3000203037E7E7B78A1A19D998E8E8A
      87008E8A873B3B3B395E5E5A2A51514A1C0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFC0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000F0C00000F0C00000F0C00000F0
      C0000000FF000000FF000000FF000000FF0000F0C00000F0C0000000FF000000
      FF000000FF0000F0C00000F0C00000F0C0008080808080808080808080808080
      800080808080808080808080808080808000EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FF
      FF000000FF000000FF000000FF000000FF0000FFFF0000FFFF000000FF000000
      FF000000FF0000FFFF0000FFFF0000FFFF008080800080808000808080008080
      80008080800080808000808080008080800026272789C9C3BE9BDBD5D09BDBD5
      D000DAD4CF96D6D0CB96D6D0CB8ECEC8C400CEC8C48ACAC3C089C9C3BE88C8C2
      BD00C1BBB780C0BBB6BEBEB9B5BCBCB6B3000203033E7E7B78A1A19D998E8E8A
      87008E8A873B3B3B391E5E5A2A11514A1C0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727C9C9C3C0DBDBD5D0DBDBD5
      D000DBD5D0D6D6D0CCD6D6D0CBD1D1CAC600D3CEC9CECEC7C4D0D0CAC6C9C9C3
      C000BEB9B5B7B7B2AE3B3B3B393B3B3B39003833173B3B3B398E8E8A873B3B3B
      39003B3B393D3D37174C4C451A4B4B42230026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFC0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C00000F0C00000F0C00000F0
      C00000F0C0000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF0000F0C00000F0C00000F0C080808080008080808080808080808080808080
      8000808080808080808080808000EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FF
      FF0000FFFF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF0000FFFF0000FFFF0000FFFF00808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF0026272789C9C3C09BDBD5D09BDBD5
      D000DBD5D096D6D0CC96D6D0CB91D1CAC600D3CEC98ECEC7C490D0CAC689C9C3
      C000BEB9B5B7B7B2AE3B3B3B393B3B3B39003833173B3B3B398E8E8A873B3B3B
      39003B3B393D3D37170C4C451A0B4B42230026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0DBDBD5
      D000DBD5D0DBDBD5D0DBDBD5D0D6D6D0CC00D6D0CBD4D4CFCACECEC8C4C2C2BC
      B9003625243B3B3B393838331738383317004C451A3B3B3B393B3B3B393C3C38
      19004C451A4B4B42234A4A422A4A4A422A0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFCECECECEC0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C00000F0C00000F0
      C00000F0C00000F0C0000000FF000000FF000000FF000000FF000000FF0000F0
      C00000F0C00000F0C08080808080808080008080808080808080808080808080
      8000808080808080808080808000EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF0000FF
      FF0000FFFF0000FFFF000000FF000000FF000000FF000000FF000000FF0000FF
      FF0000FFFF0000FFFF0080808000808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF002627278ECEC8C49BDBD5D09BDBD5
      D000DBD5D09BDBD5D09BDBD5D096D6D0CC00D6D0CB94D4CFCA8ECEC8C482C2BC
      B9003625243B3B3B393838331738383317004C451A3B3B3B393B3B3B393C3C38
      19004C451A0B4B42230A4A422A0A4A422A0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0DBDBD5
      D000DBD5D0DBDBD5D0DBDBD5D0DADAD4CF00D4CFCAC9C9C3BEC2C2BCB9B8B8B3
      AF0000000055554F2444443E174C4C441A004B441E4B4B42224B4B42224A4A43
      25004C442B4A4A422A4A4A422A2626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFC0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C00000F0
      C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0
      C00000F0C0808080808080808080808080008080808080808080808080808080
      8000808080808080808080808000EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF002627278ECEC8C49BDBD5D09BDBD5
      D000DBD5D09BDBD5D09BDBD5D09ADAD4CF00D4CFCA89C9C3BE82C2BCB9B8B8B3
      AF0000000015554F2404443E170C4C441A004B441E0B4B42220B4B42220A4A43
      25004C442B0A4A422A0A4A422A2626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0DBDBD5
      D000DBD5D0DBDBD5D0D6D6D0CBCECEC8C400C9C3BEB8B8B3AFB2B2ADAA000000
      000058372B383833174848421B4B4B4222004A43284C4C442B4A4A422A4A4A42
      2A004A422A4A4A422A4C4C442B2626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFCECECECEC0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C00000F0C00000F0C00000F0C00000F0C00000F0C00000F0C0808080
      8000808080808080808080808080808080008080808080808080808080808080
      80008080808080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000EAFAFF00EAFAFF002627278ECEC8C49BDBD5D09BDBD5
      D000DBD5D09BDBD5D096D6D0CB8ECEC8C400C9C3BEB8B8B3AFB2B2ADAA000000
      000058372B383833170848421B0B4B4222004A43280C4C442B0A4A422A0A4A42
      2A004A422A0A4A422A0C4C442B2626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0DBDBD5
      D000D6D0CBCFCFC9C5CECEC8C4BEBEB9B500BCB6B30000000000000000494943
      21004C451A4B4B42234A4A422A4A4A422A004C442B4C4C442B4A4A422A4A4A42
      2A004A422A020203032626272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFCECECE
      CE00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080808080808080808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF002627278ECEC8C49BDBD5D09BDBD5
      D000D6D0CB8FCFC9C58ECEC8C4BEBEB9B500BCB6B30000000000000000094943
      21004C451A0B4B42230A4A422A0A4A422A004C442B0C4C442B0A4A422A0A4A42
      2A004A422A020203032626272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0CFCFC9
      C500CFC9C5BEBEB9B5B8B8B3AF3B3B3B39003B3B39494943214C4C451A4B4B42
      23004A422A4A4A422A0202030302020303004C442B4C4C442B4A4A422A262627
      270026272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080808080808080808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF002627278ECEC8C49BDBD5D08FCFC9
      C500CFC9C5BEBEB9B5B8B8B3AF3B3B3B39003B3B39094943210C4C451A0B4B42
      23004A422A0A4A422A0202030302020303004C442B0C4C442B0A4A422A262627
      270026272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CFCFC9C5CFCFC9C5BEBEB9
      B500B7B2AE3B3B3B393B3B3B3949494321004C451A4B4B42234A4A422A4A4A42
      2A00523E3A50503D3A00EAFAFF00EAFAFF00262727262627272626272700EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFFC0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080808080808080808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      8000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000EAFAFF00EAFAFF00EAFAFF00EAFAFF002627278FCFC9C58FCFC9C5BEBEB9
      B500B7B2AE3B3B3B393B3B3B3909494321004C451A0B4B42230A4A422A0A4A42
      2A00523E3A10503D3A00EAFAFF00EAFAFF00262727262627272626272700EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727BCBCB6B3B7B7B2AE3B3B3B
      39003B3B39393935194C4C451A4B4B4223004A422A4C4C442B02020303020203
      0300EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFFC0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080808080808080808080808080
      800080808080808080808080808080808000808080808080808080808000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      800080808000808080008080800080808000808080008080800080808000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727BCBCB6B3B7B7B2AE3B3B3B
      39003B3B39393935190C4C451A0B4B4223004A422A0C4C442B02020303020203
      0300EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF83838382838383825F5F56
      28004C451A4B4B42234C4C442B4A4A422A002627272626272700EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFFCECECECE00C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080808080808080808080808080
      80008080808080808080808080808080800080808000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      80008080800080808000808080008080800080808000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00838382838383821F5F56
      28004C451A0B4B42230C4C442B0A4A422A002627272626272700EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627274B4B42
      23004A422A4A4A422A020203030202030300EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFCECECECEC0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080808080808080808080808080
      8000808080808080808080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF002627270B4B42
      23004A422A0A4A422A020203030202030300EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627
      27002627272626272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00E5DBCFC0C0C0C0C0C0C0C0C0C0C0C0008080808080808080808080808080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF002627
      27002627272626272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF26262727262627272626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF45454444454544444545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF45454444454544444545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000808080008080800080808000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627
      27002627279797969502020303B8B8B58D002627272626272700EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      4400454444C2C2C2C303030202BBBBBDD5004544444545444400EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      440045444481818587030302026060BCDE004544444545444400EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF26262727020203036E6E6A
      68007B78758787838135353539E1E1CE4F000203032626272726262727262627
      2700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544444545444468686C
      6E0075787B81818587393939354F4F62E1000302024545444445454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544444545444468686C
      6E0075787B81818587393939356060BCDE000302024545444445454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF26262727000203036C6C69677B7B787582827F
      7B008783818787837F3B3B3B39E1E1CE4F000203030202030302020303262627
      270026272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF454544440045444467676A6C7575787B7B7B7E
      82008185877F7F83873939393B4F4F62E1000302020303020203030202454544
      440045444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF454544440045444467676A6C7575787B7B7B7E
      82008185877F7F83873939393B6060BCDE000302020303020203030202454544
      440045444400EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000808080008080
      8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000008080
      80008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF26262727020203036C6C696700807D7A7F7F8082757580838A8A88
      85008783818787837F35353539E1E1CE4F000203032626272726262727262627
      2700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF454544444545444467676A6C007A7D807B7B7E828181858787878B
      8E008185877F7F8387393939354F4F62E1000302024545444445454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF454544444545444467676A6C007A7D807F7F82858383868887878B
      8E008185877F7F8387393939356060BCDE000302024545444445454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800080808000000000008080
      800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000808080000000
      0000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627
      27002627276C6C69678787837F87878381008E8A877D7D8CAA6A6AB4CF55559A
      B2005B87966D6D7F8438384349D2D2C353002727272626272700EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      440045444467676A6C7F7F83878181858700878B8E88888C9087878B8E7D7D7D
      8100878388878783897A7A7479828283AE006A686D6969696DACACAEB0A3A3A3
      A500AAAAAAD8D8D7D800EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      440045444467676A6C7F7F83878181858700878B8E8A8A67547373544289897E
      77008F8B8780808386393939356060BCDE004544444545444400EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000000000080808000000000008080
      8000C0C0C000C0C0C000808080008080800080808000C0C0C000C0C0C0008080
      80008080800080808000C0C0C000C0C0C000FFFFFF0080808000808080000000
      0000000000000000000000000000000000000000000000000000000000008080
      800000000000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF26262727252526267B7B78
      75008C87859393908C8E8E8A8790908C880093908C79798BAE9494DAF58282E6
      FF0067D7FE5E5ECCF15050B5D66262AAB000396D7FA5A5C0C9CBCBD6D900EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF4545444444444444757578
      7B00858A8C8C8C8F9387878B8E88888C90008C8F9393939391A0A09281797976
      7E000000009999929B91918A948888818B00726F787777777DD6D6D5DCB7B7B6
      BB00BEBDC1BABAB7BA00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF4545444402020101757578
      7B00858A8C8C8C8F9387878B8E88888C90008C8F935F5F55510E0E05042C2C1A
      12004729196B6B4C3A7474574479799298005B565400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00C0C0C0000000
      000080808000C0C0C000C0C0C0008080800080808000C0C0C000C0C0C000C0C0
      C0008080800080808000C0C0C000C0C0C000C0C0C000FFFFFF00808080000000
      000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000808080000000
      000080808000000000008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF02020303000102027B7B78759393908C999994
      9100999491999994919595918D9393908C0095918D676798B67575CAECA0A0EC
      FE007BE5FF8282E8FF8282EAFF7E7EEAFF0077E5FF6C6CDAF55C5CCDE46969AC
      C200DEE1E200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF45454444004444447575787B8C8C8F93919196
      9900919699919196998D8D91958C8C8F930089A37AC3C38310BFBF650D767672
      7D00000000000000008888808D00000000008B87906868686DD3D3D3DAB4B4B3
      B800B9B8BCBEBEBCBF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF45454444004444447575787B8C8C8F93919196
      9900919699919196998D8D91958C8C8F93008D91955F5F554F00000000000000
      00000000020404040514140D0B2F2F1D13004B2D1C82826452AAAA9183C7C7B8
      B000EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000808080008080
      80000000000000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF262627272626272782827F7B0095918D9F9F9B97A1A19D999F9F9B
      97009D99959A9A95929595908E9595918D0095908E6464A0C95555C0EAA4A4EA
      F70089F2FF8787F1FF8888F1FF8989F1FF008BF3FF8E8EF6FF9090FBFF6C6CE1
      F800A0BAC100EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF45454444454544447B7B7E82008D919597979B9F99999DA197979B
      9F0095999D9292979A98989E9D8B8BC08C0026C8581C1CB63177777D0A8B8B79
      83006D697195958E998D8D859100000000000000005F5F5F62D7D7D8DCB5B5B4
      B800B5B4B6BDBDBBBC00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF45454444454544447B7B7E82008D919597979B9F99999DA197979B
      9F0095999D9292979A8E8E93958D8D9195008E93956060554F00000000080808
      080000000000000000000000000000000000000002060606071818100C333321
      17006B3C2300EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00C0C0C000808080008080
      80008080800000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627
      270026272782827F7B9F9F9B97A5A59F9C00A59F9CAAAAA5A1A6A6A19DA5A59F
      9C009D99959C9C98949A9A95929A9A9592009A95927373A5D25353C1F29696DE
      F300A4FEFD8B8BE9EB8D8DE6E88D8DE6E8008EE7E88F8FE8E88B8BE5E89595E7
      EF007AAFBAD7D7D3D200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF030302
      02000302027B7B7E8297979B9F9C9CA2A5009CA2A5A1A1A6AA9D9DA2A69C9CA2
      A50095999D9494989CA7A7C89BA4A4E69A0086E5971D1DC7584E4E9B0AA5A580
      3D00A7AFB2BEBEB7C192928B956868626D008E8C9275757677CECED0D1B5B5B5
      B600B7B7B6BABAB9B800EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      44004544447B7B7E8297979B9F9C9CA2A5009CA2A5A1A1A6AA9D9DA2A69C9CA2
      A50095999D9494989C9292979A9292979A0092979A5A5A4F4A37373839808080
      80003838381F1F1F1F0000000000000000000000000000000000000000000000
      000049241300EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000000000000C0C0C000C0C0C000808080008080
      8000808080008080800000000000EAFAFF00EAFAFF2626272726262727939390
      8C00A19D99AAAAA5A3AAAAA5A3AEAEA8A500AFAAA6AAAAA5A1A8A8A4A0A5A59F
      9C00A29D9BA1A19D999C9C98949C9C9894009C98947B7BA8D36565CDFC7777CF
      F400BBEBEAADADD7CFB9B9DFD8B1B1DFD900A8DCD9A9A9DCDCA7A7DDDABCBCE1
      DC00ABCCCCA0A0A4A3BBBB9D8E00EAFAFF00EAFAFF03030202030302028C8C8F
      9300999DA1A3A3A8AAA3A3A8AAA5A5ABAE00A6ABAFA1A1A6AAA0A0A4A89C9CA2
      A5009BA0A299999DA18282CC88C1C1EBA600ACF1B39C9CCC65AAAA9B1A1E1E98
      14002EA948838376856E6E667000000000007B797E61616464CFCFD2D2B8B8B9
      B800BBBCBAB6B6B4B300EAFAFF00EAFAFF00EAFAFF45454444454544448C8C8F
      9300999DA1A3A3A8AAA3A3A8AAA5A5ABAE00A6ABAFA1A1A6AAA0A0A4A89C9CA2
      A5009BA0A299999DA19494989C9494989C0094989C59594F4963636465515151
      520037373721212121323232325B5B5B5B00424242464646461E1E1E1E020202
      02004A251200EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00C0C0C000808080008080
      8000808080008080800000000000EAFAFF002627279393908CA6A6A19EB1B1AC
      A800B7B2AEBCBCB6B3B8B8B3AFB3B3AEAB00B2ADA9ACACA7A4ACACA7A4A6A6A1
      9E00A6A19EA2A29D9BA1A19C9A9C9C9894009C98948D8DAFD67F7FE0FF6666D7
      FB007DBFD1AFAFCDD19999DCEBBABAECF900D8FBF8CBCBE6CFCDCDF5EED5D5F8
      FC00BFD9EFA0A0CFE7BBBBAA9E00EAFAFF000302028C8C8F939E9EA3A6A8A8AD
      B100AEB3B7B3B3B9BCAFAFB4B8ABABB0B300A9AEB2A4A4A9ACA4A4A9AC9E9EA3
      A6009EA3A69B9BA0A26060B7793B3BD37200CCDC86FFFFC048E4E48E0E2F2F98
      260052725E979789978989808700000000000000005E5E6166C4C4C8CFB1B1B3
      B800BABCBCB4B4B3B300EAFAFF00EAFAFF004544448C8C8F939E9EA3A6A8A8AD
      B100AEB3B7B3B3B9BCAFAFB4B8ABABB0B300A9AEB2A4A4A9ACA4A4A9AC9E9EA3
      A6009EA3A69B9BA0A29A9A9FA19494989C0094989C58584E4B18181818757575
      75004B4B4B27272727999999994444444400101010373737374A4A4A4A0B0B0C
      0D004A241100EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000FF000000FF0000000000C0C0C000C0C0C000808080008080
      8000808080008080800000000000EAFAFF00262727B2B2ADAAB8B8B3AFC9C9C3
      BE00C4BEBABEBEB9B5BABAB4B0B8B8B3AE00B2ADA9B1B1ACA8B2B2ADA9ABABA6
      A300A9A4A0A6A6A19DA6A6A19EA1A19C9A00A59F9C9B9BB5D99090EFFF8484F7
      FF0083C5C4AAAAB7B94848A3CC8484CFE700D0E7E5B9B9D193D5D5E8D1D7D7ED
      F700C3C1D4B0B0D4EB9C9C979100EAFAFF00030202AAAAAFB2AFAFB4B8BEBEC4
      C900BAC0C4B5B5BABEB0B0B6BAAEAEB3B800A9AEB2A8A8ADB1A9A9AEB2A3A3A8
      AB00A0A5A99D9DA2A67E7EAA616767A62200D1A61BDEDE9706A8A88206898971
      66008D8497A9A99FA9939389907D7D757A008E8D945F5F6268B8B8BBC3ABABAE
      B200B4B4B6BBBBBABA9C9C979100EAFAFF00454444AAAAAFB2AFAFB4B8BEBEC4
      C900BAC0C4B5B5BABEB0B0B6BAAEAEB3B800A9AEB2A8A8ADB1A9A9AEB2A3A3A8
      AB00A0A5A99D9DA2A69E9EA3A69A9A9FA1009CA2A57171655A00000205020207
      0B00000003040405073636363700000000000000000000000000000000000001
      01004B261200EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000808080008080
      8000808080008080800000000000EAFAFF00262727B8B8B3AFCECEC8C4C4C4BE
      BA00C4BEBAC2C2BCB9BEBEB9B5BCBCB7B300BAB4B1B7B7B2AEB3B3ADAAAFAFAA
      A600AFAAA6A9A9A4A0A8A8A4A0A1A19C9A00A6A19E9494CAE1A2A2FFFF9393FF
      FF0094D0C6BCBCBBBB9292C8E5C3C3E2EE00CFE2E4BABAC8B4C4C4DEDCB4B4D4
      E700AFBBD6C5C5E6F3A8A8A6A200EAFAFF00454444AFAFB4B8C4C4CACEBABAC0
      C400BAC0C4B9B9BFC2B5B5BABEB3B3B8BC00B1B7BAAEAEB3B7AAAAB0B3A6A6AB
      AF00A6ABAFA0A0A5A9C3C3AD96EFEF861200758100161684000D0D6E0A595958
      6600000000A4A49AA68A8A818A0000000000908D956363666AB2B2B5BBA5A5A6
      AA00B3B2B5B6B6B5B6A8A8A6A200EAFAFF00454444AFAFB4B8C4C4CACEBABAC0
      C400BAC0C4B9B9BFC2B5B5BABEB3B3B8BC00B1B7BAAEAEB3B7AAAAB0B3A6A6AB
      AF00A6ABAFA0A0A5A9A0A0A4A89A9A9FA1009EA3A6DBDB8E38C2C28835878768
      32004B41281C1C1C160000000100000000000000000000000000000000000000
      00004B261200EAFAFF00EAFAFF00EAFAFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00808080008080
      8000808080008080800000000000EAFAFF00262727B8B8B3AFCECEC8C4C9C9C3
      C000C9C3C0C4C4BEBAC0C0BBB6BFBFBAB600BDB7B4B8B8B3AFB7B7B2AEB2B2AD
      AA00AFAAA6ADADA8A5AAAAA5A3A6A6A19E00A8A4A08787B5D0B6B6FFFFA1A1FF
      FF0099D5CCB5B5B9A55E5EB781AEAED8C100DAE2F28B8B8BCBBFBFD1EFD6D6E6
      E700A4A4B2DADADDE1C5C5B6AB00EAFAFF00454444AFAFB4B8C4C4CACEC0C0C6
      C900C0C6C9BABAC0C4B6B6BBC0B6B6BBBF00B4BABDAFAFB4B8AEAEB3B7AAAAAF
      B200A6ABAFA5A5AAADA5A5AAACAAAA9F88003A790D03036B002B2B5E0D60605A
      65000000000000000084847E87000000000000000063636668D2D2D3D7C2C2C4
      C600BFBEC000EAFAFF00EAFAFF00EAFAFF00454444AFAFB4B8C4C4CACEC0C0C6
      C900C0C6C9BABAC0C4B6B6BBC0B6B6BBBF00B4BABDAFAFB4B8AEAEB3B7AAAAAF
      B200A6ABAFA5A5AAADA3A3A8AA9E9EA3A600A0A4A8ADAD8B71E3E38A3CF3F38E
      2900F99424E5E59530BABA84387F7F643300443D261515151000000002000000
      000045200E00EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF008080
      8000808080008080800000000000EAFAFF00262727BEBEB9B5D4D4CFCACFCFC9
      C500C9C3C0C5C5C0BCC4C4BEBAC4C4BEBA00BEB9B5BCBCB6B3BABAB4B0B5B5B0
      AD00B2ADAAB2B2ADA9AEAEA8A5ACACA7A400ACA7A49797A0AC8F8FC3DBA6A6DF
      F300A6C2CBADADC2B51A1AB7869D9DDEBC00D6EAFF6D6D75CCB7B7CEF5D9D9F1
      F700859DC3D6D6DFEAC6C6BAAF00EAFAFF00454444B5B5BABECACACFD4C5C5CB
      CF00C0C6C9BCBCC1C5BABAC0C4BABAC0C400B5BABEB3B3B9BCB0B0B6BAADADB2
      B500AAAFB2A9A9AEB2A5A5ABAEA4A4A9AC00A8A6A28A8A825B7A7A6848575754
      5D00545158AEAEA7B3BFBFBAC39F9F9BA300B0B0B38D8D8D8EB0B0AFB1D4D4D4
      D400EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B5B5BABECACACFD4C5C5CB
      CF00C0C6C9BCBCC1C5BABAC0C4BABAC0C400B5BABEB3B3B9BCB0B0B6BAADADB2
      B500AAAFB2A9A9AEB2A5A5ABAEA4A4A9AC00A4A9ACA0A0A4A8A0A0A3A4A2A29E
      9A00B19480C2C28758EAEA8328F7F78E2200F99528DEDEB15EAFAF91506C6C60
      40006C442800EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000C0C0
      C000C0C0C0008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000FFFF
      FF00808080008080800000000000EAFAFF00262727BEBEB9B5D4D4CFCACFCFC9
      C500CEC8C4C9C9C3C0C5C5C0BCC5C5BFBB00C5BFBBC1C1BBB8BEBEB9B5B9B9B4
      B000B6B0ADB2B2ADA9B2B2ADAAAEAEA8A500B1ACA8ACACA7A49B9BA2A69A9AA1
      AD00939197C8C89A5CC3C3AF53DDDDB67000E0B77CC3C3A07DDCDCB179E8E8BE
      8100E9B479DBDBC095BBBB987E00EAFAFF00454444B5B5BABECACACFD4C5C5CB
      CF00C4CACEC0C0C6C9BCBCC1C5BBBBC1C500BBC1C5B8B8BEC1B5B5BABEB0B0B5
      B900ADB3B6A9A9AEB2AAAAAFB2A5A5ABAE00A8ADB1A4A4A9AC99999B9E7B7B79
      81008F8D95AFAFACB4A3A3A1A7606069AB00605F60D0D0CFCF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B5B5BABECACACFD4C5C5CB
      CF00C4CACEC0C0C6C9BCBCC1C5BBBBC1C500BBC1C5B8B8BEC1B5B5BABEB0B0B5
      B900ADB3B6A9A9AEB2AAAAAFB2A5A5ABAE00A8ADB1A4A4A9ACA0A0A4A89E9EA3
      A600979B9F8C8C8F934B4B48437777B4C9009F7658E6E6AC79F9F9A347D3D3A6
      8800A1675100EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000000
      0000C0C0C000C0C0C000808080000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000080808000FFFFFF00808080000000000000000000FFFF
      FF00FFFFFF00C0C0C00000000000000000000000000000000000C0C0C000C0C0
      C000FFFFFF008080800000000000EAFAFF00262727C2C2BCB9DADAD4CFD1D1CA
      C600CFC9C5CECEC8C4C9C9C3C0C9C9C3BE00C8C2BDC2C2BCB9C1C1BBB7BDBDB7
      B400BAB4B1B7B7B2AEB3B3AEABB2B2ADAA00B2ADAAAEAEA8A5ACACA7A4AAAAA5
      A3009C958EB3B36928C6C66110D3D3751300B45A0ADADA802CD6D67A29DADA86
      3A00E5974CC3C37F4AACAC887400EAFAFF00454444B9B9BFC2CFCFD5DAC6C6CD
      D100C5CBCFC4C4CACEC0C0C6C9BEBEC4C900BDC3C8B9B9BFC2B7B7BDC1B4B4BA
      BD00B1B7BAAEAEB3B7ABABB0B3AAAAAFB200AAAFB2A5A5ABAE99999DA07B7B7A
      7E009B999F90908E93444444424F4F62E10045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B9B9BFC2CFCFD5DAC6C6CD
      D100C5CBCFC4C4CACEC0C0C6C9BEBEC4C900BDC3C8B9B9BFC2B7B7BDC1B4B4BA
      BD00B1B7BAAEAEB3B7ABABB0B3AAAAAFB200AAAFB2A5A5ABAEA4A4A9ACA3A3A8
      AA00979B9F8D8D9195393939356060BCDE0045444400EAFAFF00EAFAFFDFDFC3
      B100B9937A00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0000000000C0C0C000C0C0C000808080000000000080808000FFFFFF00FFFF
      FF00FFFFFF008080800000000000FFFFFF00000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0008080800000000000EAFAFF00262727C2C2BCB9D6D6D0CCD1D1CA
      C600D4CFCACFCFC9C5CECEC8C4C9C9C3BF00C9C3BEC3C3BEBAC4C4BEBABEBEB9
      B500BDB7B4BABAB4B1B8B8B3AFB3B3AEAB00B3AEABB2B2ADAAAEAEA8A5A8A8A4
      A0009F9B979393908C3B3B3B39E1E1CE4F0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B9B9BFC2CCCCD2D6C6C6CD
      D100CACFD4C5C5CBCFC4C4CACEBFBFC5C900BEC4C9BABABFC3BABAC0C4B5B5BA
      BE00B4BABDB1B1B7BAAFAFB4B8ABABB0B300ABB0B3AAAAAFB2A5A5ABAEA0A0A4
      A800979B9F8C8C8F933939393B4F4F62E10045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B9B9BFC2CCCCD2D6C6C6CD
      D100CACFD4C5C5CBCFC4C4CACEBFBFC5C900BEC4C9BABABFC3BABAC0C4B5B5BA
      BE00B4BABDB1B1B7BAAFAFB4B8ABABB0B300ABB0B3AAAAAFB2A5A5ABAEA0A0A4
      A800979B9F8C8C8F933939393B6060BCDE0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000808080000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000EAFAFF00262727C9C9C3BEDBDBD5D0DADAD4
      CF00D6D0CBD4D4CFCACFCFC9C5D1D1CAC600CCC6C2CACAC3C0C6C6C1BDC4C4BE
      BA00C1BBB8BEBEB9B5BABAB4B0B8B8B3AF00B7B2AEB1B1ACA8A8A8A4A0A1A19D
      99009A95928C8C87853B3B3B39E1E1CE4F0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444BEBEC4C9D0D0D6DBCFCFD5
      DA00CBD1D6CACACFD4C5C5CBCFC6C6CDD100C2C8CCC0C0C7CABDBDC2C6BABAC0
      C400B8BEC1B5B5BABEB0B0B6BAAFAFB4B800AEB3B7A8A8ADB1A0A0A4A899999D
      A10092979A85858A8C3939393B4F4F62E10045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444BEBEC4C9D0D0D6DBCFCFD5
      DA00CBD1D6CACACFD4C5C5CBCFC6C6CDD100C2C8CCC0C0C7CABDBDC2C6BABAC0
      C400B8BEC1B5B5BABEB0B0B6BAAFAFB4B800AEB3B7A8A8ADB1A0A0A4A899999D
      A10092979A85858A8C3939393B6060BCDE0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000000000080808000FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727C9C9C3BEDBDBD5D0DBDBD5
      D000DAD4CFD6D6D0CBD6D6D0CBCECEC8C400CEC8C4CACAC3C0C9C9C3BEC8C8C2
      BD00C1BBB7C0C0BBB6BEBEB9B5BCBCB6B3000203037E7E7B78A1A19D998E8E8A
      87008E8A873B3B3B398686803CE1E1CE4F0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444BEBEC4C9D0D0D6DBD0D0D6
      DB00CFD5DACBCBD1D6CBCBD1D6C4C4CACE00C4CACEC0C0C7CABEBEC4C9BDBDC3
      C800B7BDC1B6B6BBC0B5B5BABEB3B3B9BC0003020278787B7E99999DA187878B
      8E00878B8E3939393B3C3C42864F4F62E10045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444BEBEC4C9D0D0D6DBD0D0D6
      DB00CFD5DACBCBD1D6CBCBD1D6C4C4CACE00C4CACEC0C0C7CABEBEC4C9BDBDC3
      C800B7BDC1B6B6BBC0B5B5BABEB3B3B9BC0003020278787B7E99999DA187878B
      8E00878B8E3939393B4040758D6060BCDE0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000FFFF
      FF00FFFFFF00FFFFFF00808080000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008080800000000000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727C9C9C3C0DBDBD5D0DBDBD5
      D000DBD5D0D6D6D0CCD6D6D0CBD1D1CAC600D3CEC9CECEC7C4D0D0CAC6C9C9C3
      C000BEB9B5B7B7B2AE3B3B3B393B3B3B3900A79A453B3B3B398E8E8A873B3B3B
      39003B3B39B6B6A545E1E1CB4FE0E0C6690026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C0C0C6C9D0D0D6DBD0D0D6
      DB00D0D6DBCCCCD2D6CBCBD1D6C6C6CDD100C9CED3C4C4CBCEC6C6CCD0C0C0C6
      C900B5BABEAEAEB3B73939393B3939393B004552A73939393B87878B8E393939
      3B0039393B454556B64F4F65E1696983E00045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C0C0C6C9D0D0D6DBD0D0D6
      DB00D0D6DBCCCCD2D6CBCBD1D6C6C6CDD100C9CED3C4C4CBCEC6C6CCD0C0C0C6
      C900B5BABEAEAEB3B73939393B3939393B004A93AD3939393B87878B8E393939
      3B0039393B4E4E9FB96060BFDE7B7BCBDC0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0DBDBD5
      D000DBD5D0DBDBD5D0DBDBD5D0D6D6D0CC00D6D0CBD4D4CFCACECEC8C4C2C2BC
      B9003625243B3B3B39A7A79A45A7A79A4500E1CB4F3B3B3B393B3B3B39B1B1A5
      4700E1CB4FE0E0C669DFDFC67EDFDFC67E0026272700EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCCCCD2D600CBD1D6CACACFD4C4C4CACEB9B9BF
      C2002435363939393B454552A7454552A7004F65E13939393B3939393B474753
      B1004F65E1696983E07E7E97DF7E7E97DF0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCCCCD2D600CBD1D6CACACFD4C4C4CACEB9B9BF
      C2002435363939393B4A4A93AD4A4A93AD0060BFDE3939393B3939393B4E4E9A
      B70060BFDE7B7BCBDC9090D1DC9090D1DC0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000000
      0000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0DBDBD5
      D000DBD5D0DBDBD5D0DBDBD5D0DADAD4CF00D4CFCAC9C9C3BEC2C2BCB9B8B8B3
      AF000000008E8E833CCCCCBB46E1E1CA4F00E1CB59E0E0C765E0E0C565DFDFC8
      6F00DFC67EDFDFC67EDFDFC67E2626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCFCFD5DA00CACFD4BEBEC4C9B9B9BFC2AFAFB4
      B8000000003C3C478E464657CC4F4F66E100596FE165657EE0656580E06F6F86
      DF007E97DF7E7E97DF7E7E97DF4545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCFCFD5DA00CACFD4BEBEC4C9B9B9BFC2AFAFB4
      B80000000041417F975353ABCC6161C1DD006CC3DD7575C9DD7575CBDC8080CA
      DC0090D1DC9090D1DC9090D1DC4545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0DBDBD5
      D000DBD5D0DBDBD5D0D6D6D0CBCECEC8C400C9C3BEB8B8B3AFB2B2ADAA000000
      000058372BA7A79A45D9D9C552E0E0C76500DFC979DFDFC67EDFDFC67EDFDFC6
      7E00DFC67EDFDFC67EDFDFC67E2626272700EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBCBCBD1D6C4C4CACE00BEC4C9AFAFB4B8AAAAAFB2000000
      00002B4C58454552A7525265D965657EE000798FDF7E7E97DF7E7E97DF7E7E97
      DF007E97DF7E7E97DF7E7E97DF4545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBCBCBD1D6C4C4CACE00BEC4C9AFAFB4B8AAAAAFB2000000
      00002B4C584A4A93AD6161B9D87575C9DD008BCEDB9090D1DC9090D1DC9090D1
      DC0090D1DC9090D1DC9090D1DC4545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0DBDBD5
      D000D6D0CBCFCFC9C5CECEC8C4BEBEB9B500BCB6B30000000000000000929288
      4300E1CB4FE0E0C669DFDFC67EDFDFC67E00DFC67EDFDFC67EDFDFC67EDFDFC6
      7E00DFC67E020203032626272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00CBD1D6C5C5CBCFC4C4CACEB5B5BABE00B3B9BC000000000000000043434D
      92004F65E1696983E07E7E97DF7E7E97DF007E97DF7E7E97DF7E7E97DF7E7E97
      DF007E97DF454544444545444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00CBD1D6C5C5CBCFC4C4CACEB5B5BABE00B3B9BC0000000000000000474782
      980060BFDE7B7BCBDC9090D1DC9090D1DC0090D1DC9090D1DC9090D1DC9090D1
      DC0090D1DC454544444545444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CECEC8C4DBDBD5D0CFCFC9
      C500CFC9C5BEBEB9B5B8B8B3AF3B3B3B39003B3B3992928843E1E1CB4FE0E0C6
      6900DFC67EDFDFC67E020203030202030300DFC67EDFDFC67EDFDFC67E262627
      270026272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBC5C5CB
      CF00C5CBCFB5B5BABEAFAFB4B83939393B0039393B43434D924F4F65E1696983
      E0007E97DF7E7E97DF4545444445454444007E97DF7E7E97DF7E7E97DF030302
      020045444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBC5C5CB
      CF00C5CBCFB5B5BABEAFAFB4B83939393B0039393B474782986060BFDE7B7BCB
      DC0090D1DC9090D1DC45454444454544440090D1DC9090D1DC9090D1DC030302
      020003020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727CFCFC9C5CFCFC9C5BEBEB9
      B500B7B2AE3B3B3B393B3B3B399292884300E1CB4FE0E0C669DFDFC67EDFDFC6
      7E00523E3A50503D3A00EAFAFF00EAFAFF00262727262627272626272700EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C5C5CBCFC5C5CBCFB5B5BA
      BE00AEB3B73939393B3939393B43434D92004F65E1696983E07E7E97DF7E7E97
      DF006171756666757700EAFAFF00EAFAFF00454444454544444545444400EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C5C5CBCFC5C5CBCFB5B5BA
      BE00AEB3B73939393B3939393B474782980060BFDE7B7BCBDC9090D1DC9090D1
      DC006171756666757700EAFAFF00EAFAFF00454444454544444545444400EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00262727BCBCB6B3B7B7B2AE3B3B3B
      39003B3B399D9D9244E1E1CB4FE0E0C66900DFC67EDFDFC67E02020303020203
      0300EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B3B3B9BCAEAEB3B7393939
      3B0039393B44444F9D4F4F65E1696983E0007E97DF7E7E97DF45454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B3B3B9BCAEAEB3B7393939
      3B0039393B48488BA56060BFDE7B7BCBDC0090D1DC9090D1DC45454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF83838382838383828E8E80
      3C00E1CB4FE0E0C669DFDFC67EDFDFC67E002627272626272700EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFB0B0B0B1B0B0B0B13C3C4A
      8E004F65E1696983E07E7E97DF7E7E97DF000302024545444400EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFB0B0B0B1B0B0B0B1414183
      960060BFDE7B7BCBDC9090D1DC9090D1DC004544444545444400EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF26262727E0E0C6
      6900DFC67EDFDFC67E020203030202030300EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF45454444696983
      E0007E97DF7E7E97DF454544444545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544447B7BCB
      DC0090D1DC9090D1DC454544444545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF262627
      27002627272626272700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      44004544444545444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      44004544444545444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF60605F5F0303020260605F5F00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF03030202030302020303020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF27272626272726262727262600EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF45454444454544444545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF60605F
      5F00605F5F818185870303020261619DE800605F5F60605F5F00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF030302
      02000302024747494A0303020284845E27000302020303020200EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF272726
      260027262695959697030302027C7C845A002726262727262600EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      4400454444C2C2C2C303030202A2A2C195004544444545444400EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF60605F5F0303020268686C
      6E0075787B818185873939393561619DE80003020260605F5F60605F5F60605F
      5F00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF030302020303020268686C
      6E0075787B8181858739393935CCCC8D45000302020303020203030202030302
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF272726260303020268686C
      6E0075787B81818587393939359191A800000302022727262627272626272726
      2600EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544444545444468686C
      6E0075787B81818587393939356767CB2E000302024545444445454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF60605F5F0003020267676A6C7575787B7B7B7E
      82008185877F7F83873939393B61619DE800030202030302020303020260605F
      5F00605F5F00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF030302020003020267676A6C7575787B7B7B7E
      82008185877F7F83873939393BCCCC8D45000302020303020203030202030302
      020003020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF272726260003020267676A6C7575787B79797C
      80007175776E6E72752F2F2F3155556200000201010303020203030202242423
      230027262600EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF454544440045444467676A6C7575787B7B7B7E
      82008185877F7F83873939393B6767CB2E000302020303020203030202454544
      440045444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF60605F5F0303020267676A6C007A7D807B7B7E828181858787878B
      8E008185877F7F83873939393561619DE80003020260605F5F60605F5F60605F
      5F00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF030302020303020267676A6C007A7D807B7B7E828181858787878B
      8E008185877F7F838739393935CCCC8D45000302020303020203030202030302
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF272726260303020267676A6C007A7D807B7B7E827F7F8385616164
      6600232425303031332222232237373D1D00212223272728291F1F20202C2C2C
      2D00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF454544444545444467676A6C007A7D807B7B7E82818185878B8B89
      86008E5F4280805D4D5858483E7070A248001414144545444445454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF60605F
      5F0003020267676A6C7F7F83878181858700878B8E88888C909090B0C362628E
      9E0075878E7F7F83873939393561619DE800605F5F60605F5F00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF030302
      020003020267676A6C7F7F83878181858700878B8E8C8C9A9D6F6FA5A5454588
      8700518B8A6161898A5D5D7776C4C48C470007080809090A0A00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF272726
      260003020267676A6C7F7F83878181858700878B8E8484888C61616466242425
      26004A4A4A5454494A50504849A2A27B7B0097717151514A4C69695F604E4E48
      4900787A7B00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      440045444467676A6C7F7F83878181858700878B8E88888C9087878B8E949484
      7200B15016DFDFA27AD6D69A70ABAB643A00874C2B6C6C4936B6B6ADA900EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF60605F5F02020101757578
      7B00858A8C8C8C8F9387878B8E88888C90008C8F9387878B8E8080BCE76E6ECB
      E90049B2D96A6AA6BD35356E80535398CF0060606000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0303020202020101757578
      7B00858A8C8C8C8F9387878B8E88888C90008C8F93B4B4D3D2A0A0D1D28D8DC6
      C80076B0B35B5B9FA04848919243438A88004D8A8960609291A5A5C5C5BDBDD2
      D200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF2727262602020101757578
      7B00858A8C8C8C8F9387878B8E88888C90008B8E926F6F727426262728484848
      4A00A17575A1A17A7A8E8E6F70BFBF8F8F00BF919199997777B9B98A8AC5C591
      9100514F5189898C8D00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF4545444444444444757578
      7B00858A8C8C8C8F9387878B8E88888C90008C8F9387878B8E87878B8E979787
      7500B1551DF1F1CFB1FFFFF3D5FFFFE3BE00FFD1A7E7E7AB7CC7C7804E9F9F5F
      3A00B3A49B00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF60605F5F000201017575787B8C8C8F93919196
      9900919699919196998D8D91958C8C8F93008D91958D8D91957C7CBFEB9E9EE6
      FB0079E2FF6E6EDBFF6D6DD7F76363CEF0005BB5D15B5BB6D1B9B9D9E3CFCFE6
      ED00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF03030202000201017575787B8C8C8F93919196
      9900919699919196998D8D91958C8C8F93008D9195A8A8B3B5CDCDF1F0C1C1EE
      F500C0EAEEB3B3E3EAA9A9D8E29494CAD2007AB9BD6767ABAE5E5E9FA04C4C90
      8F007C979700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF27272626002625257575787B8C8C8F93919196
      9900919699919196998D8D91958C8C8F930085898D535356583A3A393B56564C
      4D00A78080D3D39E9EE3E3BEBEE3E3C8C800E1C5C5E0E0BABAD7D7AAAAC2C295
      94005D51525F5F575889898B8D00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF45454444004444447575787B8C8C8F93919196
      9900919699919196998D8D91958C8C8F93008D91958D8D919588888C909C9C94
      8A00B2591CF0F0D1B6FFFFEBD1FFFFE1BF00FADEBCFFFFE3C0FFFFD89BFBFBAF
      63007C3B1400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF60605F5F60605F5F7B7B7E82008D919597979B9F99999DA197979B
      9F0095999D9292979A8E8E93958D8D9195008E93958D8D91955B5BBEE98E8ED8
      F00091EDFF8080E8FF8484E9FF8585EBFF0084ECFF8383ECFF7777E5FE6262D6
      F000A2CEDD00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF03030202030302027B7B7E82008D919597979B9F99999DA197979B
      9F0095999D9292979A8E8E93958D8D9195008E93959A9AA4A7CDCDE8E7C1C1EE
      ED00BEEEEEC1C1ECEFC3C3EBF0C1C1ECEE00B5E8F0B9B9E3F2A5A5DAEA5959A3
      A7003B757500EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF27272626272726267B7B7E82008D919597979B9F99999DA197979B
      9F0095999D9292979A8E8E93958D8D9195008A8F912D2D2D2E69695050A3A37B
      7B00BB8F8FE4E4CACAEEEEDBDBF5F5D6D700EFCFCFD3D3B0AFCECEA6A6CECE9D
      9D00C39392DADAA0A072726C6C00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF45454444030302027B7B7E82008D919597979B9F99999DA197979B
      9F0095999D9292979A8E8E93958D8D9195008E93958D8D91958C8C8F939D9D96
      8E00B45B1FF4F4DCC6FFFFF3D8BDBDD3CA004080FFFEFEDFBBFFFFCD7DFDFDBA
      7700743F2100EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF60605F
      5F000302027B7B7E8297979B9F9C9CA2A5009CA2A5A1A1A6AA9D9DA2A69C9CA2
      A50095999D9494989C9292979A9292979A0092979A9292979A5353B8EB7171CB
      EB00A7F6FD8787F2FF8B8BF1FF8B8BF2FF008BF3FC8B8BF0FE8F8FF4FF8E8EF5
      FF007ED9EDEAEAF1F300EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF030302
      02000302027B7B7E8297979B9F9C9CA2A5009CA2A5A1A1A6AA9D9DA2A69C9CA2
      A50095999D9494989C9292979A9292979A0092979AA1A1ABADC8C8E2E2C5C5EC
      EC00BBECECBEBEECECBFBFF1F0BFBFF0EF00C3F1F1C3C3EAF0C1C1E8F28787C5
      CF002D686700EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF272726
      26002726267B7B7E8297979B9F9C9CA2A5009CA2A5A1A1A6AA9D9DA2A69C9CA2
      A50095999D9494989C9292979A9292979A005C5F612A2A2A2B95957272BEBE8E
      8E00D8B2B2E2E2CFCFE3E3B9B9BABAB15200967E7BE5E5ACA990906868BBBB8C
      8C00D09B9BBABA93939595909100EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      44004544447B7B7E8297979B9F9C9CA2A5009CA2A5A1A1A6AA9D9DA2A69C9CA2
      A50095999D9494989C9292979A9292979A0092979A9292979A8D8D91959C9C8C
      7D00B75D21FCFCE8D6D4D4E6DC404080FF004080FF0000000000000000D4D499
      5F0084431100EAFAFF00EAFAFF00EAFAFF00EAFAFF60605F5F030302028C8C8F
      9300999DA1A3A3A8AAA3A3A8AAA5A5ABAE00A6ABAFA1A1A6AAA0A0A4A89C9CA2
      A5009BA0A299999DA19494989C9494989C0094989C8E8E93956868C1F25B5BC3
      F000B2F4F99696FFFF9393FEFF9191F4FC0080ADC99393F0F49797FFFF8F8FF5
      FF009CF3FDAEAED1DA00EAFAFF00EAFAFF00EAFAFF03030202030302028C8C8F
      9300999DA1A3A3A8AAA3A3A8AAA5A5ABAE00A6ABAFA1A1A6AAA0A0A4A89C9CA2
      A5009BA0A299999DA19494989C9494989C0094989C9E9EA9AAD0D0E8E8CFCFF1
      F100D0F5F2C7C7F5F0BDBDEDEBB8B8E7E700C2EEEDBFBFEDF1CBCBF2F9ACACDB
      E60035707200EAFAFF00EAFAFF00EAFAFF00EAFAFF27272626272726268C8C8F
      9300999DA1A3A3A8AAA3A3A8AAA5A5ABAE00A6ABAFA1A1A6AAA0A0A4A89C9CA2
      A5009BA0A299999DA19494989C9494989C002526275B5B595A8D8D7172CACA96
      9600CCB1B1CECEB0B1686859569191A80000272626D6D6CDC85E5E43419D9D75
      7600C896969E9E848494948C8DC1C1C3C300EAFAFF45454444454544448C8C8F
      9300999DA1A3A3A8AAA3A3A8AAA5A5ABAE00A6ABAFA1A1A6AAA0A0A4A89C9CA2
      A5009BA0A299999DA19494989C9494989C0094989C8E8E93958E8E9395A1A18F
      8000C16628F8F8F0E5404080FFB6B6D6D4004080FFA3A3CBCEC7C7945FC7C794
      5F00C7945FC7C7945FDCDCD1C800EAFAFF000302028C8C8F939E9EA3A6A8A8AD
      B100AEB3B7B3B3B9BCAFAFB4B8ABABB0B300A9AEB2A4A4A9ACA4A4A9AC9E9EA3
      A6009EA3A69B9BA0A29A9A9FA19494989C0094989C9494989C7C7CCAF75959C8
      F90096D9EFBFBFFAFBB5B5FDFDB7B7FBFD00AAE0F09999E5E7A5A5F8F79B9BF8
      FF00BCF9FF9F9FD9E300EAFAFF00EAFAFF000302028C8C8F939E9EA3A6A8A8AD
      B100AEB3B7B3B3B9BCAFAFB4B8ABABB0B300A9AEB2A4A4A9ACA4A4A9AC9E9EA3
      A6009EA3A69B9BA0A29A9A9FA19494989C0094989CA2A2ACAFCDCDE2E2C5C5EC
      EA00BED7E4BCBCC4DEC4C4ECEFBCBCF1F000C5F3F4BFBFF3F2C6C6F1F4A6A6D4
      E10037737600EAFAFF00EAFAFF00EAFAFF002726268C8C8F939E9EA3A6A8A8AD
      B100AEB3B7B3B3B9BCAFAFB4B8ABABB0B300A9AEB2A4A4A9ACA4A4A9AC9E9EA3
      A6009EA3A69B9BA0A29A9A9FA19494989C00616466A8A87F7FB0B08484C9C996
      9600B29D9DA2A290904F4F4B479191A8000027262600EAFAFF5F5F504C929273
      7300BC8F8FCECEA3A3DADABABAD5D5D6D6004544448C8C8F939E9EA3A6A8A8AD
      B100AEB3B7B3B3B9BCAFAFB4B8ABABB0B300A9AEB2A4A4A9ACA4A4A9AC9E9EA3
      A6009EA3A69B9BA0A29A9A9FA19494989C0094989C9494989C9292979AA7A794
      8300C56F32F9F9F6F4E9E9EFE9FFFFF7E300C6DAD7404080FFFFFFE8C8E9E9AF
      7A00CB9665C7C7945FC7C7945F000000C000030202AAAAAFB2AFAFB4B8BEBEC4
      C900BAC0C4B5B5BABEB0B0B6BAAEAEB3B800A9AEB2A8A8ADB1A9A9AEB2A3A3A8
      AB00A0A5A99D9DA2A69E9EA3A69A9A9FA1009CA2A59494989C8C8CD3F97575E0
      FF006AD3F57979D4F18585D6F19494DEF100C0ECF9898988B5B9B9DCDFC2C2FF
      FF00C8F6FFDCDCFBFDA2A2C5D000EAFAFF00030202AAAAAFB2AFAFB4B8BEBEC4
      C900BAC0C4B5B5BABEB0B0B6BAAEAEB3B800A9AEB2A8A8ADB1A9A9AEB2A3A3A8
      AB00A0A5A99D9DA2A69E9EA3A69A9A9FA1009CA2A5A1A1ACAFDBDBEBEBE2E2F7
      F400C1C6E3BABAAED7B8B8C2DEB8B8EAE800B6ECECBABAEEEEC2C2F4F4ACACE2
      E40037757500EAFAFF00EAFAFF00EAFAFF00272626AAAAAFB2AFAFB4B8BEBEC4
      C900BAC0C4B5B5BABEB0B0B6BAAEAEB3B800A9AEB2A8A8ADB1A9A9AEB2A3A3A8
      AB00A0A5A99D9DA2A69E9EA3A69A9A9FA100989EA067675859B9B99091CACA97
      9700A48989646456576F6F70729191A80000272626A6A6A6A63F3F3B39898969
      6A00BE8E8EC8C8A3A3D6D6C1C100EAFAFF00454444AAAAAFB2AFAFB4B8BEBEC4
      C900BAC0C4B5B5BABEB0B0B6BAAEAEB3B800A9AEB2A8A8ADB1A9A9AEB2A3A3A8
      AB00A0A5A99D9DA2A69E9EA3A69A9A9FA1009CA2A59494989C9292979AB4B48D
      6B00CB7B42FEFEFFFFFFFFFCF7FFFFF5EA00FEF4E4404080FFC1C1DEDCFFFFC7
      9A006D381200EAFAFFC7C7945F000000C000605F5FAFAFB4B8C4C4CACEBABAC0
      C400BAC0C4B9B9BFC2B5B5BABEB3B3B8BC00B1B7BAAEAEB3B7AAAAB0B3A6A6AB
      AF00A6ABAFA0A0A5A9A0A0A4A89A9A9FA1009EA3A69A9A9FA19C9CE1FA8989F3
      FF008AF1FF8484EEFF7F7FECFD7474E8F90078D9EF9999C2E2A9A9ABB9C2C2E0
      E700D5F4FEF4F4FCFEA6A6CED900EAFAFF00030202AFAFB4B8C4C4CACEBABAC0
      C400BAC0C4B9B9BFC2B5B5BABEB3B3B8BC00B1B7BAAEAEB3B7AAAAB0B3A6A6AB
      AF00A6ABAFA0A0A5A9A0A0A4A89A9A9FA1009EA3A6A6A6B0B2DBDBE8E9E3E3F5
      F600DBEAF5CBCBD1ECC8C8D9ECC8C8F1EF00C7F4F4C1C1F3F3C1C1F6F6A7A7E0
      DF0037747400EAFAFF00EAFAFF00EAFAFF00272626AFAFB4B8C4C4CACEBABAC0
      C400BAC0C4B9B9BFC2B5B5BABEB3B3B8BC00B1B7BAAEAEB3B7AAAAB0B3A6A6AB
      AF00A6ABAFA0A0A5A9A0A0A4A89A9A9FA1009094972C2C2D2DA3A38787CACA96
      9600B48A8A484842423838373737373F11000F0F0F3C3C3D3D4D4D43439A9A76
      7600CC9898C3C3B1B1B9B9B7B700EAFAFF00454444AFAFB4B8C4C4CACEBABAC0
      C400BAC0C4B9B9BFC2B5B5BABEB3B3B8BC00B1B7BAAEAEB3B7AAAAB0B3A6A6AB
      AF00A6ABAFA0A0A5A9A0A0A4A89A9A9FA1009EA3A69A9A9FA199999DA1ACAC81
      5900CF8653FFFFFFFFFEFEFFFFFEFEF9F500FFFAEBA8A8D4DB404080FFFBFBC5
      990073421E00EAFAFF00EAFAFF00EAFAFF00605F5FAFAFB4B8C4C4CACEC0C0C6
      C900C0C6C9BABAC0C4B6B6BBC0B6B6BBBF00B4BABDAFAFB4B8AEAEB3B7AAAAAF
      B200A6ABAFA5A5AAADA3A3A8AA9E9EA3A600A0A4A89E9EA3A6A4A4F0FA9797FF
      FF0097FEFF9696FEFF9E9EFFFF9E9EFFFF0092FFFF8A8ADFF471716AAB6D6DBD
      CD0087C2DAD4D4EBF9D6D6ECF300EAFAFF00030202AFAFB4B8C4C4CACEC0C0C6
      C900C0C6C9BABAC0C4B6B6BBC0B6B6BBBF00B4BABDAFAFB4B8AEAEB3B7AAAAAF
      B200A6ABAFA5A5AAADA3A3A8AA9E9EA3A600A0A4A8B3B3A7A1CCCC8969D2D299
      8300DBB8AADEDED0C9D7D7E6E1CDCDF2F400DDFDFFCBCBFBFDC2C2FCFCACACE9
      E90038757500EAFAFF00EAFAFF00EAFAFF00272626AFAFB4B8C4C4CACEC0C0C6
      C900C0C6C9BABAC0C4B6B6BBC0B6B6BBBF00B4BABDAFAFB4B8AEAEB3B7AAAAAF
      B200A6ABAFA5A5AAADA3A3A8AA9E9EA3A6009A9EA138383739B1B18585CACA95
      9500CD9A9AA3A37E7E4A4A434325252B2B002B2F304D4D43448D8D6E6EBBBB8C
      8C00DFB8B8EBEBD9D900EAFAFF00EAFAFF00454444AFAFB4B8C4C4CACEC0C0C6
      C900C0C6C9BABAC0C4B6B6BBC0B6B6BBBF00B4BABDAFAFB4B8AEAEB3B7AAAAAF
      B200A6ABAFA5A5AAADA3A3A8AA9E9EA3A600A0A4A89E9EA3A69A9A9FA1AEAE82
      5800CC814CF7F7F3F2FDFDFEFEFFFFFFFF00FFFFFFF3F3FAF5D1D1ECF0ECECBD
      960073462200EAFAFF00EAFAFF00EAFAFF00605F5FB5B5BABECACACFD4C5C5CB
      CF00C0C6C9BCBCC1C5BABAC0C4BABAC0C400B5BABEB3B3B9BCB0B0B6BAADADB2
      B500AAAFB2A9A9AEB2A5A5ABAEA4A4A9AC00A4A9ACA0A0A4A8A5A5E0F0AAAAFF
      FF009CFFFFA6A6FFFFACACE7F3A8A8E2F200A8E8F7A3A3EDF9A1A1E1F77474C8
      DC0091B0B900EAFAFF00EAFAFF00EAFAFF00030202B5B5BABECACACFD4C5C5CB
      CF00C0C6C9BCBCC1C5BABAC0C4BABAC0C400B5BABEB3B3B9BCB0B0B6BAADADB2
      B500AAAFB2A9A9AEB2A5A5ABAEA4A4A9AC00A4A9ACB2B2ACAAD3D39565CECE7D
      4200CB6E39CACA6836CACA6A3AC3C3795700CD947CCBCBB0A7D1D1D2D8ABABD9
      DC0037767600EAFAFF00EAFAFF00EAFAFF00272626B5B5BABECACACFD4C5C5CB
      CF00C0C6C9BCBCC1C5BABAC0C4BABAC0C400B5BABEB3B3B9BCB0B0B6BAADADB2
      B500AAAFB2A9A9AEB2A5A5ABAEA4A4A9AC00A3A8AB99999CA0C4C49B9BC8C8A8
      A900CC9F9FCACA9696B7B78B8BAAAA818100A68080ADAD8484C2C29292CDCDA8
      A800DCCDCDE4E4DDDE00EAFAFF00EAFAFF00454444B5B5BABECACACFD4C5C5CB
      CF00C0C6C9BCBCC1C5BABAC0C4BABAC0C400B5BABEB3B3B9BCB0B0B6BAADADB2
      B500AAAFB2A9A9AEB2A5A5ABAEA4A4A9AC00A4A9ACA0A0A4A89E9EA3A6B2B286
      5E00C55400BDBD5C15C6C67741CFCF936D00DDB396ECECCEBAF8F8EAE2E7E7BA
      980075492400EAFAFF00EAFAFF00EAFAFF00605F5FB5B5BABECACACFD4C5C5CB
      CF00C4CACEC0C0C6C9BCBCC1C5BBBBC1C500BBC1C5B8B8BEC1B5B5BABEB0B0B5
      B900ADB3B6A9A9AEB2AAAAAFB2A5A5ABAE00A8ADB1A4A4A9AC9696BED59797D2
      EB00A6DCEFA6A6D9E86060717B8686B2EA007C8797CBCBE6F5C4C4DFF35C5C5C
      B3008078A400EAFAFF00EAFAFF00EAFAFF00030202B5B5BABECACACFD4C5C5CB
      CF00C4CACEC0C0C6C9BCBCC1C5BBBBC1C500BBC1C5B8B8BEC1B5B5BABEB0B0B5
      B900ADB3B6A9A9AEB2AAAAAFB2A5A5ABAE00A8ADB1A4A4A9ACAFAFA69FD1D19C
      7000D49665D5D58F5CD5D5824ED4D4763E00CF6626CCCC541ACCCC4921B1B150
      3E00456B6E00EAFAFF00EAFAFF00EAFAFF00272626B5B5BABECACACFD4C5C5CB
      CF00C4CACEC0C0C6C9BCBCC1C5BBBBC1C500BBC1C5B8B8BEC1B5B5BABEB0B0B5
      B900ADB3B6A9A9AEB2AAAAAFB2A5A5ABAE00A8ADB1A4A4A9AC909090934C4C46
      4700CEA1A1D4D4A7A7D3D3A3A3CECE9C9C00D1A1A1DADAB2B2E6E6CACAEDEDDC
      DC00DCDBDB00EAFAFF00EAFAFF00EAFAFF00454444B5B5BABECACACFD4C5C5CB
      CF00C4CACEC0C0C6C9BCBCC1C5BBBBC1C500BBC1C5B8B8BEC1B5B5BABEB0B0B5
      B900ADB3B6A9A9AEB2AAAAAFB2A5A5ABAE00A8ADB1A4A4A9ACA0A0A4A8B7B79E
      8000DA873AD4D4751FCDCD6206C6C6540000C04D00C1C15300C6C66621C9C96B
      2200774E2900EAFAFF00EAFAFF00EAFAFF00605F5FB9B9BFC2CFCFD5DAC6C6CD
      D100C5CBCFC4C4CACEC0C0C6C9BEBEC4C900BDC3C8B9B9BFC2B7B7BDC1B4B4BA
      BD00B1B7BAAEAEB3B7ABABB0B3AAAAAFB200AAAFB2A5A5ABAEA3A3ABB09F9FA9
      AE00989FA58E8E959B3939393561619DE800605F5F00EAFAFF00EAFAFF989893
      D900ADABCE00EAFAFF00EAFAFF00EAFAFF00030202B9B9BFC2CFCFD5DAC6C6CD
      D100C5CBCFC4C4CACEC0C0C6C9BEBEC4C900BDC3C8B9B9BFC2B7B7BDC1B4B4BA
      BD00B1B7BAAEAEB3B7ABABB0B3AAAAAFB200AAAFB2A5A5ABAEA4A4A9ACA4A4A8
      A900989B9EA2A2968E9E9E7F68D1D18E5500D49D78D3D39467D4D4854BC2C266
      3200857F7A00EAFAFF00EAFAFF00EAFAFF00272626B9B9BFC2CFCFD5DAC6C6CD
      D100C5CBCFC4C4CACEC0C0C6C9BEBEC4C900BDC3C8B9B9BFC2B7B7BDC1B4B4BA
      BD00B1B7BAAEAEB3B7ABABB0B3AAAAAFB200AAAFB2A5A5ABAEA4A4A9ACA9A9AD
      AF00D7B0B0DADAC3C4D2D2C7C9DEDEC1C100E0C9C9E1E1DBDBF0F0E6E7EEEEE0
      E100EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B9B9BFC2CFCFD5DAC6C6CD
      D100C5CBCFC4C4CACEC0C0C6C9BEBEC4C900BDC3C8B9B9BFC2B7B7BDC1B4B4BA
      BD00B1B7BAAEAEB3B7ABABB0B3AAAAAFB200AAAFB2A5A5ABAEA4A4A9ACA5A5AA
      AC009A9DA09E9E9B92A0A09378B0B0AC6B00B48F63D1D19B61CDCD7A28CACA6C
      13007B5E4100EAFAFF00EAFAFF00EAFAFF00605F5FB9B9BFC2CCCCD2D6C6C6CD
      D100CACFD4C5C5CBCFC4C4CACEBFBFC5C900BEC4C9BABABFC3BABAC0C4B5B5BA
      BE00B4BABDB1B1B7BAAFAFB4B8ABABB0B300ABB0B3AAAAAFB2A5A5ABAEA0A0A4
      A800979B9F8C8C8F933939393B61619DE800605F5F00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202B9B9BFC2CCCCD2D6C6C6CD
      D100CACFD4C5C5CBCFC4C4CACEBFBFC5C900BEC4C9BABABFC3BABAC0C4B5B5BA
      BE00B4BABDB1B1B7BAAFAFB4B8ABABB0B300ABB0B3AAAAAFB2A5A5ABAEA0A0A4
      A800979B9F8C8C8F933939393BCCCC8D45002F292500EAFAFF00EAFAFFDEDEBD
      A600D7C2BC00EAFAFF00EAFAFF00EAFAFF00272626B9B9BFC2CCCCD2D6C6C6CD
      D100CACFD4C5C5CBCFC4C4CACEBFBFC5C900BEC4C9BABABFC3BABAC0C4B5B5BA
      BE00B4BABDB1B1B7BAAFAFB4B8ABABB0B300ABB0B3AAAAAFB2A5A5ABAEA0A0A4
      A800989B9F8C8C8F937B7B7B7DE8E8D5D500EFE5E500EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B9B9BFC2CCCCD2D6C6C6CD
      D100CACFD4C5C5CBCFC4C4CACEBFBFC5C900BEC4C9BABABFC3BABAC0C4B5B5BA
      BE00B4BABDB1B1B7BAAFAFB4B8ABABB0B300ABB0B3AAAAAFB2A5A5ABAEA0A0A4
      A800979B9F8C8C8F933939393B6767CB2E0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00605F5FBEBEC4C9D0D0D6DBCFCFD5
      DA00CBD1D6CACACFD4C5C5CBCFC6C6CDD100C2C8CCC0C0C7CABDBDC2C6BABAC0
      C400B8BEC1B5B5BABEB0B0B6BAAFAFB4B800AEB3B7A8A8ADB1A0A0A4A899999D
      A10092979A85858A8C3939393B61619DE800605F5F00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202BEBEC4C9D0D0D6DBCFCFD5
      DA00CBD1D6CACACFD4C5C5CBCFC6C6CDD100C2C8CCC0C0C7CABDBDC2C6BABAC0
      C400B8BEC1B5B5BABEB0B0B6BAAFAFB4B800AEB3B7A8A8ADB1A0A0A4A899999D
      A10092979A85858A8C3939393BCCCC8D450003020200EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626BEBEC4C9D0D0D6DBCFCFD5
      DA00CBD1D6CACACFD4C5C5CBCFC6C6CDD100C2C8CCC0C0C7CABDBDC2C6BABAC0
      C400B8BEC1B5B5BABEB0B0B6BAAFAFB4B800AEB3B7A8A8ADB1A0A0A4A899999D
      A10092979A85858A8C3939393B9191A8000027262600EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444BEBEC4C9D0D0D6DBCFCFD5
      DA00CBD1D6CACACFD4C5C5CBCFC6C6CDD100C2C8CCC0C0C7CABDBDC2C6BABAC0
      C400B8BEC1B5B5BABEB0B0B6BAAFAFB4B800AEB3B7A8A8ADB1A0A0A4A899999D
      A10092979A85858A8C3939393B6767CB2E0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00605F5FBEBEC4C9D0D0D6DBD0D0D6
      DB00CFD5DACBCBD1D6CBCBD1D6C4C4CACE00C4CACEC0C0C7CABEBEC4C9BDBDC3
      C800B7BDC1B6B6BBC0B5B5BABEB3B3B9BC0003020278787B7E99999DA187878B
      8E00878B8E3939393B3D3D619761619DE800605F5F00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202BEBEC4C9D0D0D6DBD0D0D6
      DB00CFD5DACBCBD1D6CBCBD1D6C4C4CACE00C4CACEC0C0C7CABEBEC4C9BDBDC3
      C800B7BDC1B6B6BBC0B5B5BABEB3B3B9BC0003020278787B7E99999DA187878B
      8E00878B8E3939393B84845E27CCCC8D450003020200EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626BEBEC4C9D0D0D6DBD0D0D6
      DB00CFD5DACBCBD1D6CBCBD1D6C4C4CACE00C4CACEC0C0C7CABEBEC4C9BDBDC3
      C800B7BDC1B6B6BBC0B5B5BABEB3B3B9BC0003020278787B7E99999DA187878B
      8E00878B8E3939393B4E4E59209191A8000027262600EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444BEBEC4C9D0D0D6DBD0D0D6
      DB00CFD5DACBCBD1D6CBCBD1D6C4C4CACE00C4CACEC0C0C7CABEBEC4C9BDBDC3
      C800B7BDC1B6B6BBC0B5B5BABEB3B3B9BC0003020278787B7E99999DA187878B
      8E00878B8E3939393B424281296767CB2E0045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00605F5FC0C0C6C9D0D0D6DBD0D0D6
      DB00D0D6DBCCCCD2D6CBCBD1D6C6C6CDD100C9CED3C4C4CBCEC6C6CCD0C0C0C6
      C900B5BABEAEAEB3B73939393B3939393B00467BBA3939393B87878B8E393939
      3B0039393B4D4D84C361619FE77F7FB6E400605F5F00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C0C0C6C9D0D0D6DBD0D0D6
      DB00D0D6DBCCCCD2D6CBCBD1D6C6C6CDD100C9CED3C4C4CBCEC6C6CCD0C0C0C6
      C900B5BABEAEAEB3B73939393B3939393B00A36C293939393B87878B8E393939
      3B0039393BACAC7131CCCC8B46CDCD95740003020200EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626C0C0C6C9D0D0D6DBD0D0D6
      DB00D0D6DBCCCCD2D6CBCBD1D6C6C6CDD100C9CED3C4C4CBCEC6C6CCD0C0C0C6
      C900B5BABEAEAEB3B73939393B3939393B00636D233939393B87878B8E393939
      3B0039393B6C6C77159393A800ACACB7000027262600EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C0C0C6C9D0D0D6DBD0D0D6
      DB00D0D6DBCCCCD2D6CBCBD1D6C6C6CDD100C9CED3C4C4CBCEC6C6CCD0C0C0C6
      C900B5BABEAEAEB3B73939393B3939393B004F9E1F3939393B87878B8E393939
      3B0039393B5454A81E6969CB2E8989CC660045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00605F5FC4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCCCCD2D600CBD1D6CACACFD4C4C4CACEB9B9BF
      C2002435363939393B46467BBA46467BBA00619FE73939393B3939393B4C4C81
      C000619FE77F7FB6E49595C1E19595C1E100605F5F00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCCCCD2D600CBD1D6CACACFD4C4C4CACEB9B9BF
      C2002435363939393BA3A36C29A3A36C2900CC8B463939393B3939393BA9A972
      3400CC8B46CDCD9574CDCDA492CDCDA4920003020200EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCCCCD2D600CBD1D6CACACFD4C4C4CACEB9B9BF
      C2002435363939393B63636D2363636D230093A8003939393B3939393B686875
      1A0093A800ACACB700B7B7BC00C1C1C5220027262600EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCCCCD2D600CBD1D6CACACFD4C4C4CACEB9B9BF
      C2002435363939393B4F4F9E1F4F4F9E1F0069CB2E3939393B3939393B5252A6
      220069CB2E8989CC669D9DCF859D9DCF850045444400EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00605F5FC4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCFCFD5DA00CACFD4BEBEC4C9B9B9BFC2AFAFB4
      B8000000003E3E6AA155558DD66262A2E7006EA8E67979B1E57979B3E48484B6
      E40095C1E19595C1E19595C1E160605F5F00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCFCFD5DA00CACFD4BEBEC4C9B9B9BFC2AFAFB4
      B8000000008C8C5E25BDBD7E36CCCC874800CC8F5ACCCC936BCCCC916CCDCD9B
      7B00CDA492CDCDA492CDCDA4920303020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCFCFD5DA00CACFD4BEBEC4C9B9B9BFC2AFAFB4
      B80000000055555E1E7C7C8C009696A800009CAF00A8A8B500AAAAB500ADADBB
      0000B7BC00B7B7BC00B7B7BC002727262600EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBD0D0D6DBCFCFD5DA00CACFD4BEBEC4C9B9B9BFC2AFAFB4
      B8000000004545891A5A5AB91C6B6BCB2D0075CB4B8282CC5B8383CC5B8B8BCD
      6E009DCF859D9DCF859D9DCF854545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBCBCBD1D6C4C4CACE00BEC4C9AFAFB4B8AAAAAFB2000000
      00002B4C5846467BBA61619DE27979B1E5008FBCE29595C1E19595C1E19595C1
      E10095C1E19595C1E19595C1E160605F5F00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBCBCBD1D6C4C4CACE00BEC4C9AFAFB4B8AAAAAFB2000000
      00002B4C58A3A36C29C7C78848CCCC936B00CDA38ACDCDA492CDCDA492CDCDA4
      9200CDA492CDCDA492CDCDA4920303020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBCBCBD1D6C4C4CACE00BEC4C9AFAFB4B8AAAAAFB2000000
      00002B4C5863636D238D8DA000A8A8B50000B1BC00B7B7BC00B7B7BC00B7B7BC
      0000B7BC00B7B7BC00C1C1C5222727262600EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00D0D6DBD0D0D6DBCBCBD1D6C4C4CACE00BEC4C9AFAFB4B8AAAAAFB2000000
      00002B4C584F4F9E1F6868C5348282CC5B0095CE7E9D9DCF859D9DCF859D9DCF
      85009DCF859D9DCF859D9DCF854545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C4C4CACED0D0D6DBD0D0D6
      DB00CBD1D6C5C5CBCFC4C4CACEB5B5BABE00B3B9BC000000000000000044446E
      A400619FE77F7FB6E49595C1E19595C1E10095C1E19595C1E19595C1E19595C1
      E10095C1E160605F5F60605F5F00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C4C4CACED0D0D6DBD0D0D6
      DB00CBD1D6C5C5CBCFC4C4CACEB5B5BABE00B3B9BC0000000000000000909064
      3100CC8B46CDCD9574CDCDA492CDCDA49200CDA492CDCDA492CDCDA492CDCDA4
      9200CDA492030302020303020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626C4C4CACED0D0D6DBD0D0D6
      DB00CBD1D6C5C5CBCFC4C4CACEB5B5BABE00B3B9BC0000000000000000595961
      250093A800ACACB700B7B7BC00B7B7BC0000B7BC00B7B7BC00B7B7BC00B7B7BC
      0000C1C522272726262727262600EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBD0D0D6
      DB00CBD1D6C5C5CBCFC4C4CACEB5B5BABE00B3B9BC00000000000000004B4B8B
      2C0069CB2E8989CC669D9DCF859D9DCF85009DCF859D9DCF859D9DCF859D9DCF
      85009DCF85030302024545444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C4C4CACED0D0D6DBC5C5CB
      CF00C5CBCFB5B5BABEAFAFB4B83939393B0039393B44446EA461619FE77F7FB6
      E40095C1E19595C1E103030202030302020095C1E19595C1E19595C1E1030302
      0200605F5F00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C4C4CACED0D0D6DBC5C5CB
      CF00C5CBCFB5B5BABEAFAFB4B83939393B0039393B90906431CCCC8B46CDCD95
      7400CDA492CDCDA492030302020303020200CDA492CDCDA492CDCDA492030302
      020003020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626C4C4CACED0D0D6DBC5C5CB
      CF00C5CBCFB5B5BABEAFAFB4B83939393B0039393B595961259393A800ACACB7
      0000B7BC00C1C1C522272726262727262600C1C522B7B7BC00C1C1C522272726
      260027262600EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C4C4CACED0D0D6DBC5C5CB
      CF00C5CBCFB5B5BABEAFAFB4B83939393B0039393B4B4B8B2C6969CB2E8989CC
      66009DCF859D9DCF850303020245454444009DCF859D9DCF859D9DCF85030302
      020045444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C5C5CBCFC5C5CBCFB5B5BA
      BE00AEB3B73939393B3939393B44446EA400619FE77F7FB6E49595C1E19595C1
      E100828E918686929300EAFAFF00EAFAFF00605F5F60605F5F60605F5F00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202C5C5CBCFC5C5CBCFB5B5BA
      BE00AEB3B73939393B3939393B9090643100CC8B46CDCD9574CDCDA492CDCDA4
      92000720260808202300EAFAFF00EAFAFF00030202030302020303020200EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626C5C5CBCFC5C5CBCFB5B5BA
      BE00AEB3B73939393B3939393B595961250093A800ACACB700B7B7BC00C1C1C5
      22003A4D523C3C4F5200EAFAFF00EAFAFF00272626272726262727262600EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444C5C5CBCFC5C5CBCFB5B5BA
      BE00AEB3B73939393B3939393B4B4B8B2C0069CB2E8989CC669D9DCF859D9DCF
      85006171756666757700EAFAFF00EAFAFF00454444454544444545444400EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202B3B3B9BCAEAEB3B7393939
      3B0039393B454574B161619FE77F7FB6E40095C1E19595C1E160605F5F60605F
      5F00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00030202B3B3B9BCAEAEB3B7393939
      3B0039393B9A9A692CCCCC8B46CDCD957400CDA492CDCDA49203030202030302
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00272626B3B3B9BCAEAEB3B7393939
      3B0039393B5E5E67259393A800ACACB70000B7BC00C1C1C52227272626272726
      2600EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00454444B3B3B9BCAEAEB3B7393939
      3B0039393B4C4C96256969CB2E8989CC66009DCF859D9DCF8545454444454544
      4400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFCDCDCDCE3939393B3F3F6E
      A100619FE77F7FB6E49595C1E19595C1E100605F5F60605F5F00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF3939393B3939393B8C8C5A
      2800CC8B46CDCD9574CDCDA492CDCDA492000302020303020200EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF828282838282828357575E
      1D0093A800ACACB700B7B7BC00C1C1C522002726262727262600EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFFB0B0B0B13939393B484889
      190069CB2E8989CC669D9DCF859D9DCF85000302024545444400EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF030302027F7FB6
      E40095C1E19595C1E1030302020303020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF03030202CDCD95
      7400CDA492CDCDA492030302020303020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF27272626B7B7C1
      2200B7BC00C1C1C522272726262727262600EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF030302028989CC
      66009DCF859D9DCF85454544444545444400EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF60605F
      5F0003020260605F5F00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF030302
      02000302020303020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF272726
      26002726262727262600EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF454544
      44004544444545444400EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF000402020004020200EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00040202000402020404020204040202040402
      0200040202040402020404020204040202000402020404020204040202040402
      020004020204040202040402020404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF0004020204040202A0E0E0E000C0C0C0040402020404020200EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00040202040402020404020200FEFEFEBEFEFEFEBEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBEFEFEFE00FEFEFEBEFEFEFEBEFEFEFEBEFEFE
      FE00FEFEFEACACAEAEACACAEAE0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000402
      0200040202A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C0040402
      020004020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000402
      0200040202A0E0E0E0A0E0E0E00404020200FEFEFEBEFEFEFEBEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBEFEFEFE00FEFEFEBEFEFEFEBEFEFEFEBEFEFE
      FE00FDFDFDACACAEAEACACAEAE0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      80008080800080808000808080008080800080808000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0004020204040202A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C0040402020404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00040202040402020D4DCB
      D500E0E0E0A0E0E0E0A0E0E0E00404020200C6C6C686C6C6C686C6C6C686C6C6
      C600C6C6C686C6C6C686C6C6C686C6C6C600C6C6C686C6C6C686C6C6C6BBFBFB
      FB00FDFDFD9BDBDBDD9BDBDBDD0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      800080808000808080008080800080808000808080008080800080808000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF0004020200040202A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C0040402020004020200EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00040202000402020404020204040202040402
      0200040202040402020404020204040202000402020404020204040202040402
      0200040202040402020404020204040202000402020404020286C6C6C6BDFDFD
      FD00FDFDFD9BDBDBDD9BDBDBDD0404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00040202BFFFFFFFBFFFFFFF00E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C0040402020404020200EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF0004020204040202A0E0E0E000E0E0E004040202BEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBEFEFEFE00FEFEFEBEFEFEFEBEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEACACAEAE00ACAEAE0404020286C6C6C6BDFDFD
      FD00FDFDFD9BDBDBDD9BDBDBDD0404020200EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFA0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      020004020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBDFDFDFD00FEFEFEBEFEFEFEBEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEACACAEAE00ACAEAE0404020286C6C6C6BDFDFD
      FD00FDFDFD9BDBDBDD9BDBDBDD0404020200EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFA0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      0200040202040402020404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BEFEFEFEBEFEFE
      FE00FEFEFEBCFCFCFDBCFCFCFDBBFBFBFC00FCFCFCBCFCFCFCBCFCFCFCBCFCFC
      FC00FDFDFDBCFCFCFCBEFEFEFE9BDBDBDD00DBDBDD0404020286C6C6C6BDFDFD
      FD00FDFDFDACACAEAEACACAEAE0404020200EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      800080808000808080008080800080808000808080008080800080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFA0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      020004020204040202040402020404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBDFDFDFD00FEFEFEBEFEFEFEBEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFE9BDBDBDD00DBDBDD0404020286C6C6C6BDFDFD
      FD00FDFDFDACACAEAEACACAEAE0404020200EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF0080808000808080008080
      8000808080008080800080808000808080008080800080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFBFFFFFFFA0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      0200040202040402020404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBDFDFDFD00FDFDFDBDFDFDFDBDFDFDFDBDFDFD
      FD00FDFDFDBDFDFDFDBDFDFDFD9BDBDBDD00DBDBDD040402020C4C4E4E0C4C4E
      4E004C4E4E0C4C4E4E0C4C4E4E0404020200EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF0080808000808080008080
      80008080800080808000808080008080800080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFBFFFFFFFA0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000E0E0E080C0C0C080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      020004020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBDFDFDFD00FDFEFEBDFDFDFDBDFDFDFDBDFDFD
      FD00FDFDFDBDFDFDFDBDFDFDFD9BDBDBDD00DBDBDD04040202BFFF35358DCD24
      2000FCFEFEACACAEAE0C4C4E4E0404020200EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF008080800080808000808080008080
      800080808000808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFBFFFFFFFBFFFFFFFBFFFFF
      FF00E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000E0E0E0A0E0E0E080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBDFDFDFD00FDFEFEBDFDFEFEBDFDFDFDBDFDFD
      FD00FDFDFDBDFDFDFDBDFDFDFDACACAEAE00ACAEAE04040202BFFF3535BFFF00
      0000FF0000BFFF0000BFFF00000404020200C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFBFFFFFFFBFFFFFFFBFFFFF
      FF00E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000E0E0E0A0E0E0E0A0E0E0E080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BEFEFEFEBEFEFE
      FE00FEFEFEBEFEFEFEBEFEFEFEBDFDFDFD00FDFDFDBDFDFDFDBDFDFDFDBDFDFD
      FD00FDFDFDBDFDFDFDBDFDFDFDACACAEAE00ACAEAE0404020204040202040402
      020004020204040202040402020404020200C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080000000000080808000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFBFFFFFFFBFFFFFFFBFFFFF
      FF00FFFFFFA0E0E0E0A0E0E0E0A0E0E0E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E0040402020C4C4E4E0C4C4E
      4E004C4E4E0C4C4E4E0C4C4E4E0C4C4E4E004C4E4E0C4C4E4E0C4C4E4E0C4C4E
      4E004C4E4E0C4C4E4E0C4C4E4E0C4C4E4E004C4E4E0404020280808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000FFFFFF00FFFFFF00FFFFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFBFFFFFFFBFFFFFFFBFFFFF
      FF00FFFFFFA0E0E0E0BCBCDAE28CCCD6DA00E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BCFCFEFEACACAE
      AE004C4E4EBFFF0000BFFF0000BFFF000000FF0000BFFF00000C4C4E4EBCFCFE
      FE00ACAEAE0C4C4E4EBCFCFEFEACACAEAE004C4E4E0404020280808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000FFFFFF000000000000000000808080000000
      0000000000000000000080808000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFBFFFFFFFBFFFFFFFBFFFFF
      FF00FFFFFF9494AEB200000000000000000000000000000000A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E080C0C0C000C0C0C080C0C0C080C0C0C0040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E004040202BFFF0000BFFF00
      0000FF0000BFFF0000BFFF0000BFFF000000FF0000BFFF0000BFFF0000BFFF00
      0000FF0000BFFF0000BFFF0000BFFF000000FF00000404020280808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF008080800080808000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      800080808000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFFBFFFFFFFBFFFFFFF000000
      0000000000000000000000000080808080008080800000000000000000000000
      0000000000A0E0E0E0A0E0E0E0A0E0E0E000C0C0C080C0C0C080C0C0C0040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E00404020204040202040402
      0200040202040402020404020204040202000402020404020204040202040402
      0200040202040402020404020204040202000402020404020280808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      8000808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00808080000000
      0000808080000000000080808000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      800080808000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF00FFFFFF0000000000000000000000
      0000808080808080808080808080808080008080808080808080808080808080
      80000000000000000000000000A0E0E0E000E0E0E0A0E0E0E080C0C0C0040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E0A0E0E0E000E0E0E09494AEB22C6C8E921C5C7A
      7A00FFFFFFBFFFFFFFBFFFFFFFBAFAFEFE003C9AAEBFFFFFFFBFFFFFFFBFFFFF
      FF00808080808080808080808080808080008080808080808080808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      8000808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000008080800000000000808080000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      800080808000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFFBFFFFFFFBFFFFFFF000000000000000080808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      800080808080808080000000000000000000000000A0E0E0E0A0E0E0E0040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202A0E0E0E0A0E0E0E09494AEB2006C8E921C5C7A7ABFFFFFFFBFFFFF
      FF00FFFFFFBFFFFFFF808080808080808000C0C0C0808080800C0C4E50BFFFFF
      FF00FFFFFFBFFFFFFF0C0C424680808080008080808080808080808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      8000808080008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000008080800000000000808080000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000808080008080
      800080808000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202BFFFFFFF0000000000000000000000008080808080808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      8000808080808080808080808080808080008080808080808000000000000000
      0000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF000402029494AEB22C6C8E92BFFFFFFF00FFFFFFBFFFFFFFBFFFFFFFBFFFFF
      FF0080808080808080808080808080808000C0C0C080808080808080802C2C5A
      6200FFFFFFBFFFFFFFBFFFFFFFBFFFFFFF000C42468080808080808080040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      800080808000808080008080800080808000FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000080808000000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF008080800080808000808080008080
      800080808000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00040202000000000000000080808080008080808080808080808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      8000808080808080808080808080808080008080808080808000000000000000
      0000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF000402021C5C7A7ABFFFFFFFBFFFFFFF00FFFFFFBFFFFFFF80808080808080
      800080808080808080808080808080808000C0C0C080C0C0C080808080808080
      80008080808080808080808080BFFFFFFF00FFFFFFBFFFFFFF0C0C4246040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      800080808000808080008080800080808000FFFFFF00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00808080000000
      000080808000FFFFFF00FFFFFF00808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF000000000000000080808080008080808080808080808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      8000808080808080808080808080808080008080800000000000EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000402
      0200FFFFFFBFFFFFFFBFFFFFFFBFFFFFFF008080808080808080808080808080
      800080808080808080808080808080808000C0C0C080C0C0C080808080808080
      800080808080808080808080808080808000808080BFFFFFFFBFFFFFFFBFFFFF
      FF00FFFFFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      80008080800080808000808080008080800080808000FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00000000000000008080808080808080808080
      8000808080808080808080808080808080008080808080808080808080808080
      80008080808080808080808080000000000000000000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0004020204040202BFFFFF
      FF00FFFFFF1111464A80C0C0C080C0C0C0008080808080808080808080808080
      800080808080808080808080808080808000C0C0C080C0C0C080808080808080
      8000808080808080808080808080808080008080803C3C768224245E6EBFFFFF
      FF00FFFFFF040402020404020200EAFAFF00EAFAFF0080808000808080008080
      8000808080008080800080808000808080008080800080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0000000000000000808080
      8000808080808080808080808080808080008080808080808080808080808080
      8000808080000000000000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000402
      0200E0E0E0A0E0E0E080C0C0C080C0C0C000C0C0C08080808080808080808080
      800080808080808080808080808080808000C0C0C080C0C0C080808080808080
      800080808080808080808080808080808000FAFEFEBAFAFEFEA0E0E0E0A0E0E0
      E00004020200EAFAFF00EAFAFF00EAFAFF00EAFAFF0080808000808080008080
      800080808000808080008080800080808000808080008080800080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000000
      0000000000808080808080808080808080008080808080808080808080000000
      000000000000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00040202A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E080C0C0C000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C080C0C0
      C000C0C0C08080808080808080BAFAFEFE00E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E00404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00000000000000008080808000808080000000000000000000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00040202A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000E0E0E0A0E0E0E080C0C0C080C0C0
      C000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C03474CAD880C0C0C080C0C0
      C000FAFEFEBAFAFEFE9494E2EEA0E0E0E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E00404020200EAFAFF00EAFAFF00EAFAFF00808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF000000000000000000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00040202040402
      0200E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E000C0C0C080C0C0C080C0C0C080C0C0C000C0C0C080C0C0C080C0C0C0BAFAFE
      FE009CE6F2A0E0E0E0A0E0E0E0A0E0E0E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E0000402020404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0004020204040202A0E0E0E0A0E0E0E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E09494E2EE80C0C0C080C0C0C000C0C0C0BAFAFEFE9C9CE6F2A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E000E0E0E0A0E0E0E004040202040402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      800080808000808080008080800080808000808080008080800080808000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF000402020404020200E0E0E0A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E00404020200040202A0E0E0E0A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0A0E0E0E0A0E0E0E0000402020404020200EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      80008080800080808000808080008080800080808000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF0004020204040202A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E00404020200EAFAFF00EAFAFF00040202A0E0E0E0A0E0E0
      E000E0E0E0A0E0E0E0040402020404020200EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF0080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00040202040402
      0200E0E0E00404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00040202A0E0E0
      E000E0E0E00404020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      800080808000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF0004020200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF000402
      0200EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00EAFA
      FF00EAFAFF00EAFAFF00EAFAFF00EAFAFF00424D3E000000000000003E000000
      2800000080000000A00000000100010000000000000A00000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFE0000F0001F0000000000
      FFFFFFFFFFF8000000000000FC183F00FF0003FFFFE0000000FF80003FFFFFFF
      FC0001FFFF800000FFFC1FFC003F0000F800007FFE00000000F0001FFFE003F0
      F000007FF80000000003000000E0001FE000003FF0000000F800078000030000
      E000000FF000000003801803F0000580C000000FF00000000000000003801803
      C0018007F00000000000030000000000C001C007F00000000FFFFF8300000300
      C001C007F0000000000000001FFFFF83C001F003F000000000001F0000000000
      FFFFF003F000000F1F80180300001F00FFFFFE03F000000F000100003F801803
      FFFFFE03F000000F00003F8000010000FFFFFE03F000000F7FE0000700003F80
      FFFFFC03F000000F00070000FFF0001FFFFFF803F000000F007FFFF0000F0000
      FFFFF003F000000FFFFFFFFF81FFFFF8C001C003F000000FFF3FFFFF3FFFFF3F
      C0018003E0000007C003FFFFFC1FFFFCC00100038000000107FFC007800003FF
      C0000007E0000007001FFF0003FF001FE000000FC0000003000000F80003F800
      F000000F8000000103C00003000003F0F800001FC00000030001000003000003
      FC00003FF000000F0000010000010000FC00007FFC00003F0700000300000100
      FF0000FFFF0180FF000100001F000003FF8001FFFFC3C3FFC000010000010000
      FFFFFFFFFFF7EFFF1F00001FF0000100FFFFF8FFFFC003FFFFC003FFFFFFF8FF
      FFFFE03FFF0000FFFF0000FFFFFFE03FFFFF800FFE00003FFE00003FFFFF800F
      FFFE0007F800001FF800001FFFFE0007FFF8000FF000000FF000000FFFF8000F
      FFE0003FF0000007F0000007FFE0003FFF80000FE0000003E0000003FF80000F
      FE00000FC0000003C0000003FE00000FF8000009C0000001C0000001F8000009
      E00000098000000180000001E000000980000001800000008000000080000001
      0000000100000000000000000000000100000003000000000000000000000003
      000000070000000000000000000000070000000F00000000000000000000000F
      0000000F00000000000000000000000F0000000F00000000000000000000000F
      0000007F00000000000000000000007F0000007F00000000000000000000007F
      0000007F00000000000000000000007F0000007F80000000800000000000007F
      0000007F80000001800000010000007F0000007F80000001800000010000007F
      000000FFC0000001C0000001000000FF000000FFC0000003C0000003000000FF
      000001FFE0000007E0000007000001FF000007FFF0000007F0000007000007FF
      00031FFFF800000FF800000F00031FFF000FFFFFFC00001FFC00001F000FFFFF
      803FFFFFFE00007FFE00007F803FFFFFC0FFFFFFFF8001FFFF8001FFC0FFFFFF
      E3FFFFFFFFF007FFFFE007FFE3FFFFFFFFFFFFFFFFFFF8FFFFFFF8FFFFFFF8FF
      E0001FFFFFFFE03FFFFFE03FFFFFE03FC000000FFFFF800FFFFF800FFFFF800F
      80000007FFFE0007FFFE0007FFFE000780000003FFF8000FFFF8000FFFF8000F
      80000001FFE0003FFFE00003FFE0003F00000000FF80001FFF800003FF80007F
      00000000FE000007FE000003FE00000F00000003F8000007F8000003F8000007
      00000003E0000003E0000003E000000700000001800000018000000380000007
      0000000100000001000000030000000700000001000000010000000100000007
      0000000100000001000000010000000700000001000000010000000700000007
      80000001000000010000000F00000007C0000001000000010000003F00000007
      E0000001000000010000007F00000067F00000010000007F0000007F0000007F
      F80000010000007F0000007F0000007FFF8000FF0000007F0000007F0000007F
      FFC0007F0000007F0000007F0000007FFFC0007F0000007F0000007F0000007F
      FFE0003F000000FF000000FF000000FFFFE0003F000000FF000000FF000000FF
      FFFFFFFF000001FF000001FF000001FFFFFFFFFF000007FF000007FF000007FF
      FFFFFFFF00031FFF00031FFF00031FFFFFFFFFFF000FFFFF000FFFFF000FFFFF
      FFFFFFFF803FFFFF803FFFFF803FFFFFFFFFFFFFC0FFFFFFC0FFFFFFC0FFFFFF
      FFFFFFFFE3FFFFFFE3FFFFFFE3FFFFFFFFFFF8FFFFFFF8FFFFFFF8FFFFFFF8FF
      FFFFE03FFFFFE03FFFFFE03FFFFFE03FFFFF800FFFFF800FFFFF800FFFFF800F
      FFFE0007FFFE0007FFFE0007FFFE0007FFF8000FFFF8000FFFF8000FFFF8000F
      FFE0003FFFE0003FFFE00007FFE0001FFF80007FFF80000FFF800003FF800007
      FE00000FFE000007FE000001FE000007F8000007F8000007F8000001F8000007
      E0000003E0000007E0000001E000000780000003800000078000000080000001
      0000000300000007000000400000000000000001000000070000000100000004
      0000000100000007000000010000000700000001000000070000000300000007
      0000000700000007000000030000000700000007000000070000000700000007
      00000067000000070000000F000000070000007F000000670000007F0000007F
      0000007F0000007F0000007F0000007F0000007F0000007F0000007F0000007F
      0000007F0000007F0000007F0000007F0000007F0000007F0000007F0000007F
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000001FF000001FF000001FF000001FF000007FF000007FF000007FF000007FF
      00031FFF00031FFF00031FFF00031FFF000FFFFF000FFFFF000FFFFF000FFFFF
      803FFFFF803FFFFF803FFFFF803FFFFFC0FFFFFFC0FFFFFFC0FFFFFFC0FFFFFF
      E3FFFFFFE3FFFFFFE3FFFFFFE3FFFFFFFFC003FFFFFE7FFFFFFE0000FFE007FF
      FF0000FFFFF81FFFFFF80000FF8001FFFE00003FFFE007FFFFE00000FE00007F
      F800001FFF8001FFFF800000F800001FF000000FFE00007FFE000000F000000F
      F0000007F800001FF8000000E0000007E0000003F0000007F0000000E0000007
      C0000003F0000001F0000000C0000003C0000001F0000000F000000080000001
      80000001F0000001F00000008000000180000000F0000007F000000080000001
      00000000F000000FF00000000000000000000000F000000FF000000000000000
      00000000F000000FF000000F0000000000000000F000000FF000000F00000000
      00000000F000000FF000000F0000000000000000F000000FF000000F00000000
      00000000F000000FF000000F0000000000000000F000000FF000000F00000000
      00000000F000000FF000000F0000000000000000F000000FF000000F00000000
      80000001F800003FE00000070000000180000001FE00007F8000000180000001
      80000001FF8001FFE000000780000003C0000003FFE007FFC0000003C0000003
      E0000007FFF81FFF80000001C0000007E0000007FFFE7FFFC0000003E000000F
      F000000FFFFFFFFFF000000FF000000FF800001FFFFFFFFFFC00003FF800001F
      FE00007FFFFFFFFFFF0180FFFC00007FFF8001FFFFFFFFFFFFC3C3FFFF0000FF
      FFE007FFFFFFFFFFFFF7EFFFFFC003FF00000000000000000000000000000000
      000000000000}
  end
  object ImListOutils: TImageList
    Height = 32
    Width = 32
    Left = 259
    Top = 214
    Bitmap = {
      494C010102000500040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000004000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000004040
      4000404040004040400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040404000FFFF
      FF00FFFFFF00FFFFFF0040404000404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004040400040404000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF003F3F
      3F003F3F3F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00404040004040
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF003F3F3F003F3F3F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00607070006070700000000000000000004040400040404000404040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF003F3F3F003F3F3F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004040400040404000FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF004040400040404000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00203030003F3F3F00FFFFFF00FFFFFF00FFFFFF003F3F3F003F3F3F00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004040400000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF0000FF
      FF0000FFFF0000FFFF000000FF000000FF000000FF000000FF000000FF0000FF
      FF0000FFFF0000FFFF0080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003F3F3F003F3F3F00FFFFFF003F3F3F00FFFFFF003F3F
      3F003F3F3F00FFFFFF00FFFFFF00FFFFFF004040400000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FF
      FF0000FFFF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF0000FFFF0000FFFF0000FFFF00808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF003F3F3F00FFFFFF00FFFFFF004040400000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FF
      FF000000FF000000FF000000FF000000FF0000FFFF0000FFFF000000FF000000
      FF000000FF0000FFFF0000FFFF0000FFFF008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003F3F3F00FFFFFF004040400000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FF
      FF000000FF000000FF000000FF0000FFFF0000FFFF0000FFFF000000FF000000
      FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003F3F3F00FFFFFF004040400000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000FF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000
      FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003F3F3000FFFFFF00404040000000000000000000E0E0
      E000E0E0E000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000FF000000
      FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004F4F4000FFFFFF00E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF000000
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E0000000000000000000000000008080800080808000808080008080
      800080808000808080008080800000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF000000FF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E0000000000000000000000000008080800080808000808080008080
      800080808000808080008080800000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E0000000000000000000000000008080800080808000808080008080
      800080808000808080008080800000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E0000000000000000000000000008080800080808000808080008080
      80008080800080808000808080008080800000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E0000000000000000000000000008080800080808000808080008080
      80008080800080808000808080008080800000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004040400040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E0000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004040
      400040404000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E0000000000000000000000000000000000080808000808080008080
      800080808000808080008080800080808000808080008080800000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004040400040404000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E0000000000000000000000000000000000000000000808080008080
      80008080800080808000808080008080800080808000808080008080800000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004040400040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004040400000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004040
      400040404000FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0E000E0E0E000E0E0
      E000E0E0E000FFFFFF003F3F3000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004040400040404000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003F3F3000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004040400040404000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003F3F3F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004040400040404000FFFF
      FF00FFFFFF00FFFFFF003F3F3000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004040
      400040404000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004040400040404000404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      800080808000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000400000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF00B96EFE6BFF9EBB61E67BDF5E1BEF06AE
      92282321D3911802080A30AC32100002147DE6FFFA7E1DBFDED7FCF7CBCCE64B
      4BD058186C63625410043CA8654C809820AFBA5FF33D93B9148BFB6F37747CBB
      9584742C8B754B6018530C16453A4A4AEFE9598F6DC9379EF46AF0EFA948FF39
      41400841D85716E437AB16A03A4E75AC2A5BF531231FD7AA3E8E4B4A7E9EFF4E
      81A402331B2110090038244617DA13E9A5D4FE4E7FE7EF39AF37D70FC7BFE7FA
      E88851C06C58CD201F2D063424DC805D877F551537F613F4F912F7179F26897F
      38300216875303851490110212C920C07D4E59AD6EFCBC7797AED7EBCF5CE1B4
      7864BC8D883C0E1FC0C4CC106C0E40009017FEB771F38EF1E4FDFAA6D6CCFB78
      303E10A12A44044B4202020261081102DDFAEDFEA1DED17D4CE77751DEFF6BEB
      EEE548105EF02F6367284084A018213C29B736ACF2B69FB093339701FB48BB34
      0019214D6359C19D09A2521834028B00BFFECECD5BF5EDFE9D487DAD7FFEB4FF
      82D8BAA60092294D4119358740899D246767E23BFF310D6CCAB9315699B079B6
      11B024033903270BA202B2110A0A40B8A7D7F3FCF8DCEF82517FB085DCF5BFEF
      C7DC384FB72428C05A03C0801E06D80CDEF327837B63A9248169C7E26B546734
      42A402011291B8331B22F31122710682AEDE477C4FC9CD9BE6EE4FDB3E71FFDD
      C10C6DC629003D015391F3E82809D494FFFFF8FFFFC003FFEA7EDF543005BE3C
      FFFFE03FFF0000FF76B142B040018815FFFF800FFE00003F374AAC19E6FE69CE
      FFFE0007F800001F071C020D60883B9CFFF8000FF000000FD7967BBAAF31F9BD
      FFE0003FF00000077611070A34918426FF80007FE000000364DCFECFCC75CFCF
      FE00000FC00000030C92DD90C4A52EC0F8000007C0000001565D63D4BF37F2FC
      E00000078000000182030582075B91288000000780000000FEDCE8F38DFDE7AE
      0000000700000000AA6C1D00D90EBB1B0000000700000000F3AB4C2BF66FFFDE
      00000007000000006F21631A3A3031230000000700000000ABE8C7E7CFFEDBEB
      0000000700000000240570DA04ED3C350000000700000000BDBD924BFFEBA47E
      0000006700000000141067341C9230C10000007F000000004E747E6F9DF2CCDA
      0000007F0000000010804168A048142B0000007F8000000034C4F9A16D9F3030
      0000007F800000019620C20026EB89A10000007F8000000184AFEEDFD97DDDF8
      000000FFC0000001532C868F0482B8C8000000FFC000000391494612EFB91FFF
      000001FFE0000007D5107B3053518529000007FFF0000007DADCFFEDDF6FDDE7
      00031FFFF800000FF6198841E0280160000FFFFFFC00001F31F7ED3B75639BCB
      803FFFFFFE00007F9742AE2520062099C0FFFFFFFF8001FFFFDFD2F565BCCEE8
      E3FFFFFFFFE007FFC8E00F4D42B4090800000000000000000000000000000000
      000000000000}
  end
  object TiAffichAide: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = TiAffichAideTimer
    Left = 307
    Top = 165
  end
  object ZipMaster1: TZipMaster19
    AddOptions = []
    AddStoreSuffixes = [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR, assJPG, assJPEG, ass7Zp, assMP3, assWMV, assWMA, assDVR, assAVI]
    ConfirmErase = False
    DLL_Load = False
    ExtrOptions = []
    KeepFreeOnAllDisks = 0
    KeepFreeOnDisk1 = 0
    MaxVolumeSize = 0
    MaxVolumeSizeKb = 0
    NoReadAux = False
    SFXOptions = []
    SFXOverwriteMode = ovrAlways
    SpanOptions = []
    Trace = False
    Unattended = False
    UseUTF8 = False
    Verbose = False
    Version = '1.9.0.0113'
    WriteOptions = []
    Left = 947
    Top = 94
  end
end
