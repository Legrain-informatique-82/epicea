object FormChoixRepDest: TFormChoixRepDest
  Left = 638
  Top = 343
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Choix du r'#233'pertoire de destination'
  ClientHeight = 348
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 296
    Width = 86
    Height = 13
    Caption = 'Nouveau dossier :'
    Layout = tlBottom
  end
  object ShellTreeView1: TShellTreeView
    Left = 32
    Top = 24
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
    Top = 256
    Width = 89
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object ButtonAnnuler: TButton
    Left = 168
    Top = 256
    Width = 89
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    TabOrder = 2
    OnClick = ButtonAnnulerClick
  end
  object ButtonCreerRep: TButton
    Left = 232
    Top = 296
    Width = 73
    Height = 22
    Caption = 'Cr'#233'er'
    TabOrder = 4
    OnClick = ButtonCreerRepClick
  end
  object EditCreerRep: TEdit
    Left = 104
    Top = 296
    Width = 121
    Height = 21
    TabOrder = 3
  end
end
