object Analyses: TAnalyses
  Left = 224
  Top = 234
  Width = 870
  Height = 640
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
    Left = 8
    Top = 8
    Width = 497
    Height = 249
    TabOrder = 0
    object PaCptIntit: TPanel
      Left = 1
      Top = 1
      Width = 495
      Height = 14
      Cursor = crHandPoint
      Align = alTop
      BorderWidth = 2
      Caption = 'Charges et produits'
      Color = 7396351
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6974005
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Button1: TButton
      Left = 392
      Top = 184
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 1
      OnClick = Button1Click
    end
    object DBChart1: TDBChart
      Left = 8
      Top = 24
      Width = 344
      Height = 202
      AllowPanning = pmNone
      AllowZoom = False
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      BackWall.Pen.Visible = False
      Title.Text.Strings = (
        'Analyse des charges et des produits')
      AxisVisible = False
      ClipPoints = False
      Frame.Visible = False
      Legend.DividingLines.Visible = True
      Legend.TextStyle = ltsPlain
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      View3DWalls = False
      TabOrder = 2
      object Series1: TPieSeries
        Cursor = crArrow
        Marks.ArrowLength = 8
        Marks.Visible = True
        DataSource = DataSource1
        PercentFormat = '##0.##,%'
        SeriesColor = clRed
        Title = 'Charges et produits'
        ValueFormat = '#,##0.##'
        XLabelsSource = 'charges'
        Circled = True
        OtherSlice.Text = 'Autre'
        PieValues.DateTime = False
        PieValues.Name = 'Sectoriel '
        PieValues.Multiplier = 1.000000000000000000
        PieValues.Order = loNone
        PieValues.ValueSource = 'charges;Produits'
      end
    end
  end
  object QuCharges: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      
        'select sum(E1.debitSaisie)-sum(E1.creditSaisie)as charges,0 as i' +
        'd'
      'from Ecriture E1'
      'where E1.compte like('#39'6%'#39')and E1."date">=:dateDebut')
    Left = 432
    Top = 136
    ParamData = <
      item
        DataType = ftDate
        Name = 'dateDebut'
        ParamType = ptInput
        Value = 0d
      end>
    object QuChargescharges: TCurrencyField
      FieldName = 'charges'
      Origin = 'DOSSIER."Ecriture.DB".DebitSaisie'
    end
    object QuChargesid: TFloatField
      FieldName = 'id'
    end
    object QuChargesProduits: TCurrencyField
      FieldKind = fkLookup
      FieldName = 'Produits'
      LookupDataSet = QuProduits
      LookupKeyFields = 'id'
      LookupResultField = 'produits'
      KeyFields = 'id'
      Lookup = True
    end
  end
  object QuProduits: TQuery
    DatabaseName = 'Dossier'
    SQL.Strings = (
      
        'select sum(E2.creditSaisie)-sum(E2.debitSaisie)as produits,0 as ' +
        'id'
      'from Ecriture E2'
      'where  E2.compte like('#39'7%'#39')and E2."date">=:dateDebut')
    Left = 472
    Top = 136
    ParamData = <
      item
        DataType = ftDate
        Name = 'dateDebut'
        ParamType = ptInput
        Value = 0d
      end>
  end
  object DataSource1: TDataSource
    DataSet = QuCharges
    Left = 464
    Top = 184
  end
end
