unit DMGestProg;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMGestProgr = class(TDataModule)
    TaGestProg: TTable;
    DaGestProg: TDataSource;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  DMGestProgr: TDMGestProgr;

implementation

{$R *.dfm}

end.
