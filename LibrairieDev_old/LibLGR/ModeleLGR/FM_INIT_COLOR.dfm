object T_INIT_COLOR: TT_INIT_COLOR
  Left = 0
  Top = 0
  Width = 788
  Height = 253
  Caption = 'T_INIT_COLOR'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object La_AP_Modele_ArrierePlanEdit: TLabel
    Left = 72
    Top = 272
    Width = 385
    Height = 37
    AutoSize = False
    Caption = 'La_AP_Modele_ArrierePlanEdit'
    Color = 210
    ParentColor = False
    Layout = tlBottom
    Visible = False
  end
  object Btn_Modele_FM_INIT_COLOR: TButton
    Left = 80
    Top = 328
    Width = 233
    Height = 25
    Caption = 'Btn_Modele_FM_INIT_COLOR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabStop = False
    Visible = False
  end
  object Ed_Modele_FM_INIT_COLOR: TEdit
    Left = 344
    Top = 288
    Width = 121
    Height = 21
    TabStop = False
    TabOrder = 1
    Text = 'Ed_Modele_FM_INIT_COLOR'
    Visible = False
    OnEnter = Ed_Modele_FM_INIT_COLOREnter
    OnExit = Ed_Modele_FM_INIT_COLORExit
  end
end
