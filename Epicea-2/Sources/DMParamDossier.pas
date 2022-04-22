unit DMParamDossier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL;

type
  TDMParamDoss = class(TDataModule)
    TaParamDoss: TTable;
    DaParamDoss: TDataSource;
    procedure DMParamDossCreate(Sender: TObject);
    procedure DMParamDossDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMParamDoss: TDMParamDoss;



implementation

{$R *.DFM}


procedure TDMParamDoss.DMParamDossCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
//TaParamDoss.Database.Session.AddPassword('toto');
end;

procedure TDMParamDoss.DMParamDossDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
end;


end.
