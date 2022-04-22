unit DMGestProg;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMGestProgr = class(TDataModule)
    TaGestProg: TTable;
    DaGestProg: TDataSource;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMGestProgr: TDMGestProgr;

implementation

{$R *.dfm}

end.
