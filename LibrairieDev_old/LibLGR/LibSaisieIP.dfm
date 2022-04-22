object SaisieIP: TSaisieIP
  Left = 546
  Top = 352
  BorderStyle = bsToolWindow
  Caption = 'Saisie de l'#39'adresse IP'
  ClientHeight = 114
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EdIP1: TEdit
    Left = 96
    Top = 16
    Width = 41
    Height = 21
    MaxLength = 3
    TabOrder = 0
    OnExit = EdIP1Exit
    OnKeyPress = EdIP1KeyPress
    OnKeyUp = EdIP1KeyUp
  end
  object EdIP2: TEdit
    Left = 141
    Top = 16
    Width = 41
    Height = 21
    MaxLength = 3
    TabOrder = 1
    OnExit = EdIP1Exit
    OnKeyPress = EdIP1KeyPress
    OnKeyUp = EdIP1KeyUp
  end
  object EdIP3: TEdit
    Left = 186
    Top = 16
    Width = 41
    Height = 21
    MaxLength = 3
    TabOrder = 2
    OnExit = EdIP1Exit
    OnKeyPress = EdIP1KeyPress
    OnKeyUp = EdIP1KeyUp
  end
  object EdIP4: TEdit
    Left = 232
    Top = 16
    Width = 41
    Height = 21
    MaxLength = 3
    TabOrder = 3
    OnExit = EdIP1Exit
    OnKeyPress = EdIP1KeyPress
    OnKeyUp = EdIP1KeyUp
  end
  object BtnValider: TButton
    Left = 96
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Valider'
    ModalResult = 1
    TabOrder = 4
  end
  object BtnAnnuler: TButton
    Left = 184
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 5
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 24
    Top = 24
  end
end
