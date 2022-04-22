object ChoixRecup: TChoixRecup
  Left = 383
  Top = 268
  Width = 557
  Height = 275
  Caption = 'R'#233'cup'#233'ration par FTP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 549
    Height = 121
    Align = alTop
    Caption = 'Indiquez le dossier sur lequel porte la restauration'
    TabOrder = 0
    object SpeedButton3: TSpeedButton
      Left = 176
      Top = 40
      Width = 161
      Height = 25
      Hint = 
        'Vous devez s'#233'lectionner un fichier qui se nomme '#39'ParamFtp.txt'#39' '#13 +
        #10'dans le dossier que vous souhaitez restaurer.'
      Caption = 'Choix du dossier'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton3Click
    end
    object Label4: TLabel
      Left = 40
      Top = 79
      Width = 454
      Height = 13
      Caption = 
        'Indiquez le chemin du dossier pour lequel vous souhaitez faire u' +
        'ne restauration.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 121
    Width = 549
    Height = 120
    Align = alClient
    Caption = 'R'#233'cup'#233'ration de la sauvegarde'
    TabOrder = 1
    object BtnRecupere: TButton
      Left = 200
      Top = 36
      Width = 123
      Height = 25
      Caption = 'R'#233'cup'#233'rez'
      Enabled = False
      TabOrder = 0
      OnClick = BtnRecupereClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'paramFtp.txt|*.txt'
    Title = 'recherche fichier paramFtp.txt'
    Left = 72
    Top = 24
  end
end
