unit DMAide;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL;

type

  TParamDMAideEnLigne=Record
    Unite:string;
    control:string;
    Etat:TDatasetstate;
  end;

  TDMAides = class(TDataModule)
    taAssist: TTable;
    daAssist: TDataSource;
    TaMessage: TTable;
    DaMessage: TDataSource;
    procedure DataModuleAideDestroy(Sender: TObject);
    procedure DataModuleAideCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMAides: TDMAides;

  Procedure Initialise_ParamDMAideEnLigne(Var ParamDMAideEnLigne:TParamDMAideEnLigne);
implementation

{$R *.DFM}

Procedure Initialise_ParamDMAideEnLigne(Var ParamDMAideEnLigne:TParamDMAideEnLigne);
Begin
  ParamDMAideEnLigne.control:='';
  ParamDMAideEnLigne.Unite:='';
  ParamDMAideEnLigne.Etat:=dsInactive;
end;


procedure TDMAides.DataModuleAideCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
end;

procedure TDMAides.DataModuleAideDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMAides:=nil;
end;


end.
