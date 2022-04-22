object AffichageWeb: TAffichageWeb
  Left = 333
  Top = 314
  Width = 1305
  Height = 584
  Caption = 'AffichageWeb'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1289
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 560
      Top = 16
      Width = 86
      Height = 13
      Caption = 'URL ou Fichier ....'
    end
    object editURL: TEdit
      Left = 663
      Top = 8
      Width = 353
      Height = 25
      TabOrder = 0
      Text = 'editURL'
      OnKeyDown = editURLKeyDown
    end
    object btnnext: TButton
      Left = 24
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnnext'
      TabOrder = 1
      OnClick = btnnextClick
    end
    object btnback: TButton
      Left = 128
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnback'
      TabOrder = 2
      OnClick = btnbackClick
    end
    object btnrefresh: TButton
      Left = 216
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnrefresh'
      TabOrder = 3
      OnClick = btnrefreshClick
    end
    object btnHome: TButton
      Left = 320
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnHome'
      TabOrder = 4
      OnClick = btnHomeClick
    end
    object btnStop: TButton
      Left = 416
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnStop'
      TabOrder = 5
      OnClick = btnStopClick
    end
    object btnLoad: TButton
      Left = 1016
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btnLoad'
      TabOrder = 6
      OnClick = btnLoadClick
    end
    object btnQuit: TButton
      Left = 1208
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btnQuit'
      TabOrder = 7
      OnClick = btnQuitClick
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 41
    Width = 1289
    Height = 505
    Align = alClient
    TabOrder = 1
    OnTitleChange = WebBrowser1TitleChange
    ControlData = {
      4C000000021F0000810F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
