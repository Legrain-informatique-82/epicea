unit DMModels;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,Gr_Librairie;

type
TRecupJournal=record
Journal:string;
ID:integer;
end;

type
  TDMModel = class(TDataModule)
    TaModel: TTable;
    DataSource1: TDataSource;
    function RecupJournal(code:string):TRecupJournal;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMModel: TDMModel;

implementation

{$R *.DFM}

function TDMModel.RecupJournal(code:string):TRecupJournal;
var
TabValeur:array [0..3]of variant;
begin
TabValeur[0]:='Journal';
TabValeur[2]:='ID';
  try
  RecupInfosTableSurInfos(TaModel,['Code',code],TabValeur);
  except
  abort;
  end;//fin du try
result.ID:=TabValeur[3];
result.Journal:=TabValeur[1];
//showmessage(TabValeur[3]);
//showmessage(TabValeur[1]);

end;


end.
