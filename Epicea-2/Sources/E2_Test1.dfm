object Test1: TTest1
  Left = 266
  Top = 290
  Width = 803
  Height = 482
  Caption = 'Test1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object RxLabel1: TRxLabel
    Left = 480
    Top = 32
    Width = 47
    Height = 13
    Caption = 'RxLabel1'
  end
  object CheckBox1: TCheckBox
    Left = 56
    Top = 16
    Width = 97
    Height = 17
    Caption = 'Ouverture V'#233'rouill'#233
    TabOrder = 0
  end
  object CheckBox2: TCheckBox
    Left = 56
    Top = 48
    Width = 97
    Height = 17
    Caption = 'Cl'#244'ture v'#233'rouill'#233
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 126
    Width = 795
    Height = 329
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DMEcritures.DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DateEdit1: TDateEdit
    Left = 296
    Top = 32
    Width = 121
    Height = 21
    NumGlyphs = 2
    TabOrder = 3
    OnChange = DateEdit1Change
  end
end
