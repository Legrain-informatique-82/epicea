unit E2_Graphes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Series, TeEngine, ExtCtrls, TeeProcs, Chart, DBChart,DMTier,DB, TeeFunci,DMDiocEtatVersements;

type
  TGraphes = class(TForm)
    DBChart2: TDBChart;
    BarSeries1: TBarSeries;
    TeeFunction1: TMultiplyTeeFunction;
    Series1: TBarSeries;
    TeeFunction2: TMultiplyTeeFunction;
    Series2: TBarSeries;
    TeeFunction3: TAddTeeFunction;
    function Serie:integer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Graphes: TGraphes;

Function AfficheGraphe(DataSet:TDataSet;ChampValeurs,ChampValeursTitre,ChampLibelle,TitreGraphe:string):Boolean;

implementation

//uses E2_Graphes;

{$R *.DFM}

Function AfficheGraphe(DataSet:TDataSet;ChampValeurs,ChampValeursTitre,ChampLibelle,TitreGraphe:string):Boolean;
Begin
 if (Graphes = nil) then Graphes:=TGraphes.Create(Application.MainForm);
 Graphes.DBChart2.Title.Text.Clear;
 Graphes.DBChart2.Title.Text.Add(TitreGraphe);
 Graphes.DBChart2.ActiveSeriesLegend(0).Clear;
 Graphes.DBChart2.ActiveSeriesLegend(0).DataSource:=nil;
 Graphes.DBChart2.ActiveSeriesLegend(0).XLabelsSource:=ChampValeursTitre;
 Graphes.DBChart2.ActiveSeriesLegend(0).YValues.ValueSource:=ChampLibelle;  { <-- champ des valeurs des barres }
 Graphes.DBChart2.ActiveSeriesLegend(0).XValues.ValueSource:=ChampValeurs;
//  Graphes.DBChart2.ActiveSeriesLegend(0).
 Graphes.DBChart2.ActiveSeriesLegend(0).DataSource:=DataSet;
 Graphes.show;
//if DMBalance=nil then DMBalance:=TDMBalance.create(Application.MainForm);
//DMBalance.QuBalanceAffich.Close;
//DMBalance.QuBalanceAffich.Open;

End;

function TGraphes.Serie:integer;
Begin
//
End;

procedure TGraphes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end;

end;

end.
