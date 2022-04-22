unit AnalyseGraphique;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, TeeProcs, Chart, ExtCtrls, DB,
  DBTables, DbChart;

type
  TAnalyses = class(TForm)
    Panel1: TPanel;
    PaCptIntit: TPanel;
    Button1: TButton;
    DBChart1: TDBChart;
    QuCharges: TQuery;
    QuProduits: TQuery;
    Series1: TPieSeries;
    QuChargescharges: TCurrencyField;
    QuChargesid: TFloatField;
    QuChargesProduits: TCurrencyField;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Analyses: TAnalyses;

implementation

uses E2_Librairie_Obj;

{$R *.dfm}

procedure TAnalyses.Button1Click(Sender: TObject);
begin
QuCharges.ParamByName('dateDebut').AsDate:=e.DatExoDebut;
QuProduits.ParamByName('dateDebut').AsDate:=e.DatExoDebut;
QuProduits.Open;
QuCharges.Open;

//  //Effacement des séries
//  Chart1.SeriesList.Clear;
//  for i := 1 to StringGrid1.RowCount - 1 do
//  begin
//    //1 ligne = 1 série
//    cs := TLineSeries.Create(Self);
//    cs.Title := StringGrid1.Cells[0, i];
//    //NE SURTOUT PAS OUBLIER CECI :
//    cs.ParentChart := Chart1;
//    for j := 1 to StringGrid1.ColCount - 1 do
//      //Ajout des valeurs à la série
//      cs.Add(StrToIntDef(StringGrid1.Cells[j, i], 0), StringGrid1.Cells[j, 0]);
//  end;

end;

end.
