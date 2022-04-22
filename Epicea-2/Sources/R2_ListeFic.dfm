object ListeVLE: TListeVLE
  Left = 482
  Top = 209
  ActiveControl = SGList
  Align = alRight
  BorderStyle = bsToolWindow
  Caption = 'ListeVLE'
  ClientHeight = 556
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Pabas: TPanel
    Left = 0
    Top = 515
    Width = 429
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 96
      Top = 8
      Width = 89
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 216
      Top = 8
      Width = 89
      Height = 25
      Cancel = True
      Caption = 'Annuler'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object SGList: TStringGrid
    Left = 0
    Top = 17
    Width = 429
    Height = 498
    Align = alClient
    ColCount = 2
    DefaultColWidth = 200
    FixedCols = 0
    RowCount = 40
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 429
    Height = 17
    Align = alTop
    TabOrder = 2
    object HeaderControl1: THeaderControl
      Left = 1
      Top = 1
      Width = 427
      Height = 17
      Sections = <
        item
          Alignment = taCenter
          ImageIndex = -1
          Text = 'Liste Origine'
          Width = 200
        end
        item
          Alignment = taCenter
          ImageIndex = -1
          Text = 'Votre liste'
          Width = 200
        end>
    end
  end
end
