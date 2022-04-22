object InfosProtect: TInfosProtect
  Left = 529
  Top = 281
  Width = 596
  Height = 425
  Caption = 'InfosProtect'
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
  object LaNumDD: TLabel
    Left = 88
    Top = 14
    Width = 71
    Height = 16
    Caption = 'LaNumDD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 55
    Height = 13
    Caption = 'Identifiant : '
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 31
    Height = 13
    Caption = 'Nom : '
  end
  object Label3: TLabel
    Left = 272
    Top = 72
    Width = 45
    Height = 13
    Caption = 'Pr'#233'nom : '
  end
  object Label4: TLabel
    Left = 16
    Top = 120
    Width = 70
    Height = 13
    Caption = 'Nom Soci'#233't'#233' : '
  end
  object Label5: TLabel
    Left = 288
    Top = 176
    Width = 66
    Height = 13
    Caption = 'Code Postal : '
  end
  object Label6: TLabel
    Left = 16
    Top = 176
    Width = 28
    Height = 13
    Caption = 'Ville : '
  end
  object Label7: TLabel
    Left = 16
    Top = 296
    Width = 98
    Height = 13
    Caption = 'Num'#233'ro de licence : '
  end
  object EdNom: TEdit
    Left = 136
    Top = 64
    Width = 121
    Height = 19
    BevelEdges = [beRight, beBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    Text = 'EdNom'
  end
  object EdPrenom: TEdit
    Left = 392
    Top = 64
    Width = 121
    Height = 19
    BevelEdges = [beRight, beBottom]
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Text = 'EdPrenom'
  end
  object EdNomSoc: TEdit
    Left = 136
    Top = 112
    Width = 121
    Height = 19
    BevelEdges = [beRight, beBottom]
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    Text = 'EdNomSoc'
  end
  object Edcp: TEdit
    Left = 408
    Top = 168
    Width = 121
    Height = 19
    BevelEdges = [beRight, beBottom]
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    Text = 'EdCp'
  end
  object EdVille: TEdit
    Left = 136
    Top = 168
    Width = 121
    Height = 19
    BevelEdges = [beRight, beBottom]
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    Text = 'EdVille'
  end
  object EdNumLic: TEdit
    Left = 136
    Top = 288
    Width = 121
    Height = 19
    BevelEdges = [beRight, beBottom]
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 5
    Text = 'EdNumLic'
  end
end
