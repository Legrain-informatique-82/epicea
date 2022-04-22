object FormChoixRepDest: TFormChoixRepDest
  Left = 638
  Top = 343
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Choix du dossier'
  ClientHeight = 319
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 0
    Width = 312
    Height = 42
    Align = alClient
    TabOrder = 0
    object laMessageTitre: TLabel
      Left = 1
      Top = 1
      Width = 310
      Height = 40
      Align = alClient
      Caption = 'Cliquez sur le dossier de votre choix...'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 42
    Width = 312
    Height = 277
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 1
    object ShellTreeView1: TShellTreeView
      Left = 32
      Top = 10
      Width = 249
      Height = 209
      ObjectTypes = [otFolders]
      Root = 'rfMyComputer'
      UseShellImages = True
      AutoRefresh = False
      HideSelection = False
      Indent = 19
      ParentColor = False
      ParentShowHint = False
      RightClickSelect = True
      ShowHint = False
      ShowRoot = False
      TabOrder = 0
    end
    object ButtonOK: TButton
      Left = 64
      Top = 242
      Width = 89
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 1
      OnClick = ButtonOKClick
    end
    object ButtonAnnuler: TButton
      Left = 168
      Top = 242
      Width = 89
      Height = 25
      Cancel = True
      Caption = 'Annuler'
      TabOrder = 2
      OnClick = ButtonAnnulerClick
    end
  end
end
