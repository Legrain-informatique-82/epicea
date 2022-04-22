unit DMReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TdaReport = class(TDataModule)
    taEchEmprunt: TTable;
    DataSource1: TDataSource;
    procedure daReportCreate(Sender: TObject);
    procedure daReportDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  daReport: TdaReport;

implementation

{$R *.DFM}

procedure TdaReport.daReportCreate(Sender: TObject);
begin
taEchEmprunt.Close;
taEchEmprunt.open;
end;

procedure TdaReport.daReportDestroy(Sender: TObject);
begin
taEchEmprunt.Close;
daReport:=nil;
end;

end.
