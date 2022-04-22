object UniteCorrections: TUniteCorrections
  Left = 33
  Top = 0
  Width = 607
  Height = 440
  Caption = 'UniteCorrections'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Patitre: TPanel
    Left = 0
    Top = 0
    Width = 591
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
      Width = 577
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
      Width = 147
      Height = 24
      Alignment = taCenter
      Caption = 'S'#233'lectionnez ...'
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
  object PaBas: TPanel
    Left = 0
    Top = 361
    Width = 591
    Height = 41
    Align = alBottom
    BevelOuter = bvLowered
    Color = 12441823
    TabOrder = 1
    object Gauge1: TGauge
      Left = 64
      Top = 24
      Width = 457
      Height = 14
      Progress = 0
      Visible = False
    end
  end
  object PaTitrePetit: TPanel
    Left = 0
    Top = 28
    Width = 591
    Height = 14
    Align = alTop
    Caption = 'Contr'#244'le g'#233'n'#233'ral'
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6974005
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object PaBtn: TPanel
    Left = 0
    Top = 325
    Width = 591
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 12441823
    TabOrder = 3
    OnResize = PaBtnResize
    object BtnFermer: TButton
      Left = 366
      Top = 0
      Width = 90
      Height = 37
      Caption = 'Fermer [F4]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnFermerClick
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
    object BtnAnnuler: TButton
      Left = 172
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
      OnEnter = BtnAnnulerEnter
      OnExit = BtnAnnulerExit
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 117
    Width = 591
    Height = 208
    Align = alClient
    Color = 12441823
    TabOrder = 4
    object RxLabel2: TRxLabel
      Left = 0
      Top = 106
      Width = 295
      Height = 135
      AutoSize = False
      Caption = 'Pointages'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabel4: TRxLabel
      Left = 296
      Top = 141
      Width = 295
      Height = 67
      AutoSize = False
      Caption = 'Balance'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabel3: TRxLabel
      Left = 296
      Top = 72
      Width = 295
      Height = 67
      AutoSize = False
      Caption = 'Libell'#233's'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabel1: TRxLabel
      Left = 296
      Top = 3
      Width = 295
      Height = 67
      AutoSize = False
      Caption = 'Import E2 Dos'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabAdresse: TRxLabel
      Left = 0
      Top = 3
      Width = 295
      Height = 102
      AutoSize = False
      Caption = 'Immobilisations :'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabel6: TRxLabel
      Left = 0
      Top = 242
      Width = 295
      Height = 67
      AutoSize = False
      Caption = 'R'#233'indexation'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabel7: TRxLabel
      Left = 296
      Top = 209
      Width = 295
      Height = 98
      AutoSize = False
      Caption = 'Pi'#232'ces'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabel8: TRxLabel
      Left = 0
      Top = 310
      Width = 295
      Height = 67
      AutoSize = False
      Caption = 'Plan comptable'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabel9: TRxLabel
      Left = 296
      Top = 309
      Width = 295
      Height = 67
      AutoSize = False
      Caption = 'Analytique'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object RxLabel10: TRxLabel
      Left = 0
      Top = 379
      Width = 295
      Height = 67
      AutoSize = False
      Caption = 'Balance des Tiers'
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object BtnControlPointage: TButton
      Left = 28
      Top = 134
      Width = 231
      Height = 26
      Caption = 'Contr'#244'le des pointages'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = BtnControlPointageClick
    end
    object BtnRecalculPointage: TButton
      Left = 27
      Top = 200
      Width = 231
      Height = 21
      Caption = 'Recalcul des pointages'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 1
      OnClick = BtnRecalculPointageClick
    end
    object BtnBalance: TButton
      Left = 332
      Top = 167
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le de la balance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
      OnClick = BtnBalanceClick
    end
    object BtnLibelleTiers: TButton
      Left = 332
      Top = 98
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le des libell'#233's'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 3
      OnClick = BtnLibelleTiersClick
    end
    object BtnTransfert: TButton
      Left = 332
      Top = 29
      Width = 229
      Height = 25
      Caption = 'Transfert du Code A2 vers A1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 4
      OnClick = BtnTransfertClick
    end
    object BtnCorrectionImmos: TButton
      Left = 28
      Top = 18
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le Acquisitions / Cessions'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 5
      OnClick = BtnCorrectionImmosClick
    end
    object BtnRecalcul: TButton
      Left = 28
      Top = 47
      Width = 229
      Height = 25
      Caption = 'Recalcul des amortissements'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 6
      OnClick = BtnRecalculClick
    end
    object BtnReindexation: TButton
      Left = 28
      Top = 269
      Width = 229
      Height = 25
      Caption = 'R'#233'indexation des tables'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 7
      OnClick = BtnReindexationClick
    end
    object BtnPiece: TButton
      Left = 332
      Top = 236
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le des pi'#232'ces'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 8
      OnClick = BtnPieceClick
    end
    object BtnPlanComptable: TButton
      Left = 28
      Top = 337
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le du plan comptable'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 9
      OnClick = BtnPlanComptableClick
    end
    object BtnAnalytique: TButton
      Left = 332
      Top = 336
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le de l'#39'analytique'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 10
      OnClick = BtnAnalytiqueClick
    end
    object BtnDerogatoire: TButton
      Left = 28
      Top = 77
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le d'#233'rogatoire'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 11
      OnClick = BtnDerogatoireClick
    end
    object BtnBalanceTiers: TButton
      Left = 28
      Top = 402
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le de la balance des Tiers (Report)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 12
      OnClick = BtnBalanceTiersClick
    end
    object BtnEcritures: TButton
      Left = 332
      Top = 268
      Width = 229
      Height = 25
      Caption = 'Contr'#244'le id des '#233'critures'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 13
      OnClick = BtnEcrituresClick
    end
    object BtnControlPointageTiers: TButton
      Left = 27
      Top = 168
      Width = 231
      Height = 21
      Caption = 'Contr'#244'le des pointages Tiers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 14
      OnClick = BtnControlPointageTiersClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 105
    Width = 591
    Height = 12
    Align = alTop
    Caption = 'Liste des contr'#244'les possibles....'
    Color = 7396351
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6974005
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object Panel3: TPanel
    Left = 0
    Top = 42
    Width = 591
    Height = 63
    Align = alTop
    Caption = 'Panel3'
    Color = 12441823
    TabOrder = 6
    object RxLabel5: TRxLabel
      Left = 1
      Top = 1
      Width = 589
      Height = 61
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Color = 10085887
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShadowColor = clHighlightText
      ShadowSize = 0
    end
    object BtnToutControler: TButton
      Left = 152
      Top = 8
      Width = 297
      Height = 49
      Caption = 'Tout contr'#244'ler'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = BtnToutControlerClick
    end
    object BtnChgtReference: TButton
      Left = 459
      Top = 24
      Width = 129
      Height = 25
      Caption = 'Formatage LGR'
      TabOrder = 1
      OnClick = BtnChgtReferenceClick
    end
    object Button1: TButton
      Left = 19
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Contr'#244'le immos report'
      TabOrder = 2
      Visible = False
      OnClick = Button1Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 501
    Top = 9
    object Annuler1: TMenuItem
      Caption = 'Annuler'
      ShortCut = 16449
      Visible = False
    end
    object Fermer1: TMenuItem
      Caption = 'Fermer'
      ShortCut = 115
    end
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 456
    Top = 485
  end
end
