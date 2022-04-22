object MsgForm: TMsgForm
  Left = 323
  Top = 359
  Width = 493
  Height = 320
  Align = alRight
  Caption = 'Etat de la sauvegarde'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 485
    Height = 245
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 245
    Width = 485
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 176
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Fermer'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
