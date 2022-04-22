object E2_TableauDeBord: TE2_TableauDeBord
  Left = 0
  Top = 10
  Width = 1024
  Height = 675
  Caption = 'Tableau de bord'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 1008
    Height = 618
    Align = alClient
    TabOrder = 0
    OnDownloadBegin = WebBrowser1DownloadBegin
    OnDownloadComplete = WebBrowser1DownloadComplete
    ControlData = {
      4C0000002E680000DF3F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 618
    Width = 1008
    Height = 19
    Panels = <>
  end
end
