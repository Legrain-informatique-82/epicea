object Form1: TForm1
  Left = 436
  Top = 331
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FTP'
  ClientHeight = 401
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object LabelServeur: TLabel
    Left = 8
    Top = 16
    Width = 60
    Height = 13
    Caption = 'Serveur FTP'
  end
  object LabelUtilisateur: TLabel
    Left = 8
    Top = 48
    Width = 46
    Height = 13
    Caption = 'Utilisateur'
  end
  object LabelPassWord: TLabel
    Left = 8
    Top = 80
    Width = 64
    Height = 13
    Caption = 'Mot de passe'
  end
  object LabelSource: TLabel
    Left = 320
    Top = 16
    Width = 34
    Height = 13
    Caption = 'Source'
  end
  object LabelDestination: TLabel
    Left = 320
    Top = 48
    Width = 53
    Height = 13
    Caption = 'Destination'
  end
  object ButtonChoixRep: TSpeedButton
    Left = 632
    Top = 16
    Width = 23
    Height = 22
    Hint = 'Choix du r'#233'pertoire source'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = ButtonChoixRepClick
  end
  object SpeedButtonChoixRepDest: TSpeedButton
    Left = 632
    Top = 48
    Width = 23
    Height = 22
    Hint = 'Choix du r'#233'pertoire de destination'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButtonChoixRepDestClick
  end
  object GroupBoxFich: TGroupBox
    Left = 152
    Top = 160
    Width = 377
    Height = 73
    Caption = 'Progression'
    TabOrder = 13
  end
  object ButtonTransfert: TButton
    Left = 280
    Top = 336
    Width = 97
    Height = 25
    Caption = 'Envoyer'
    TabOrder = 8
    OnClick = ButtonTransfertClick
  end
  object ButtonQuitter: TButton
    Left = 384
    Top = 336
    Width = 97
    Height = 25
    Cancel = True
    Caption = 'Quitter'
    TabOrder = 9
    OnClick = ButtonQuitterClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 382
    Width = 688
    Height = 19
    Hint = 'Etat de la connexion'
    Panels = <>
    ParentShowHint = False
    ShowHint = True
  end
  object EditServeur: TEdit
    Left = 88
    Top = 16
    Width = 145
    Height = 21
    Hint = 'Adresse du serveur FTP'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = EditServeurChange
  end
  object EditUtilisateur: TEdit
    Left = 88
    Top = 48
    Width = 145
    Height = 21
    Hint = 'Nom d'#39'utilisateur'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnChange = EditUtilisateurChange
  end
  object EditPassWord: TEdit
    Left = 88
    Top = 80
    Width = 145
    Height = 21
    Hint = 'Mot de passe'
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 2
    OnChange = EditPassWordChange
  end
  object CheckBoxEffacer: TCheckBox
    Left = 320
    Top = 80
    Width = 337
    Height = 17
    BiDiMode = bdLeftToRight
    Caption = 
      '      Effacer le contenu du r'#233'pertoire de destination avant d'#39'en' +
      'voyer'
    ParentBiDiMode = False
    TabOrder = 5
  end
  object EditSource: TEdit
    Left = 384
    Top = 16
    Width = 241
    Height = 21
    Hint = 'Chemin du r'#233'pertoire '#224' envoyer'
    AutoSelect = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnChange = EditSourceChange
  end
  object EditDestination: TEdit
    Left = 384
    Top = 48
    Width = 241
    Height = 21
    Hint = 'Chemin du r'#233'pertoire o'#249' les fichiers doivent '#234'tre envoyer'
    AutoSelect = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnChange = EditDestinationChange
  end
  object ButtonChargeParam: TButton
    Left = 152
    Top = 120
    Width = 185
    Height = 25
    Caption = 'Charger les param'#232'tres par d'#233'faut'
    TabOrder = 6
    OnClick = ButtonChargeParamClick
  end
  object ButtonEnregistreParam: TButton
    Left = 352
    Top = 120
    Width = 177
    Height = 25
    Caption = 'Enregistrer les param'#232'tres'
    TabOrder = 7
    OnClick = ButtonEnregistreParamClick
  end
  object GroupBoxTotal: TGroupBox
    Left = 152
    Top = 248
    Width = 377
    Height = 73
    Caption = 'Progression totale'
    TabOrder = 11
  end
  object ProgressBarFich: TProgressBar
    Left = 168
    Top = 180
    Width = 345
    Height = 21
    Align = alCustom
    TabOrder = 14
  end
  object ProgressBarTotal: TProgressBar
    Left = 168
    Top = 272
    Width = 345
    Height = 21
    TabOrder = 15
  end
  object StaticText1: TStaticText
    Left = 336
    Top = 208
    Width = 4
    Height = 4
    Constraints.MaxWidth = 1000
    TabOrder = 10
  end
  object LabelFichEnCours: TStaticText
    Left = 192
    Top = 208
    Width = 141
    Height = 17
    Caption = 'Fichier en cours de transfert :'
    TabOrder = 16
  end
  object Button1: TButton
    Left = 176
    Top = 336
    Width = 97
    Height = 25
    Caption = 'R'#233'cup'#233'rer'
    TabOrder = 17
    OnClick = Button1Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 8
    Top = 336
  end
  object XPManifest1: TXPManifest
    Left = 72
    Top = 336
  end
  object IdAntiFreeze1: TIdAntiFreeze
    IdleTimeOut = 50
    OnlyWhenIdle = False
    Left = 40
    Top = 336
  end
end
