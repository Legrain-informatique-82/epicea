object InputQueryFrm: TInputQueryFrm
  Left = 548
  Top = 423
  AutoScroll = False
  Caption = 'InputQueryFrm'
  ClientHeight = 119
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object LabelErreur: TLabel
    Left = 8
    Top = 56
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 82
    Width = 482
    Height = 37
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object LaAide: TLabel
      Left = 2
      Top = 2
      Width = 478
      Height = 33
      Cursor = crHelp
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object PaBtn: TPanel
    Left = 0
    Top = 48
    Width = 482
    Height = 34
    Align = alBottom
    TabOrder = 1
    OnResize = PaBtnResize
    DesignSize = (
      482
      34)
    object BitBtnOk: TBitBtn
      Left = 254
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtnCancel: TBitBtn
      Left = 362
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object PaEdits: TPanel
    Left = 0
    Top = 18
    Width = 482
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      482
      30)
    object CurrEd: TCurrencyEdit
      Left = 10
      Top = 6
      Width = 168
      Height = 21
      AutoSize = False
      Constraints.MinWidth = 150
      TabOrder = 1
      Value = -1.000000000000000000
      Visible = False
      OnChange = CurrEdChange
    end
    object EditInput: TEdit
      Left = 8
      Top = 5
      Width = 464
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Constraints.MinWidth = 150
      MaxLength = 255
      TabOrder = 2
      OnChange = EditInputChange
      OnKeyDown = EditInputKeyDown
      OnKeyPress = EditInputKeyPress
    end
    object DateEdit1: TDateEdit
      Left = 8
      Top = 7
      Width = 119
      Height = 21
      AutoSelect = False
      DialogTitle = 'Choisir une date'
      NumGlyphs = 2
      TabOrder = 0
      Visible = False
      OnAcceptDate = DateEdit1AcceptDate
      OnChange = DateEdit1Change
      OnExit = DateEdit1Exit
    end
    object CbInput: TComboBox
      Left = 10
      Top = 6
      Width = 463
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Visible = False
      OnChange = CbInputChange
    end
  end
  object PaLegende: TPanel
    Left = 0
    Top = 0
    Width = 482
    Height = 18
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object LabelLegende: TLabel
      Left = 8
      Top = 0
      Width = 474
      Height = 18
      Align = alClient
      Caption = '<L'#233'gende>'
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 8
      Height = 18
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
end
