unit DMDevises;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL;

type
  TDMDevise = class(TDataModule)
    TaDevise: TTable;
    DaDevise: TDataSource;
    procedure DMDeviseCreate(Sender: TObject);
    procedure DMDeviseDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMDevise: TDMDevise;

Function DeviseSigle(IndexDevise:Integer):String;

implementation

{$R *.DFM}
Function DeviseSigle(IndexDevise:Integer):String;
Begin
try
 result:='';
 if DMDevise = nil then DMDevise:=TDMDevise.Create(Application.mainForm);
 if not DMDevise.TaDevise.Active then DMDevise.TaDevise.Open;
 if DMDevise.TaDevise.Locate('ID',IndexDevise,[]) then
 result:=chr(DMDevise.TaDevise.findfield('Devise').AsInteger);
except
 ShowMessage('Un problème est survenu pendant la récupération du sigle de la devise');
 result:='';
end;
End;


procedure TDMDevise.DMDeviseCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
end;

procedure TDMDevise.DMDeviseDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMDevise:=nil;
end;

end.
