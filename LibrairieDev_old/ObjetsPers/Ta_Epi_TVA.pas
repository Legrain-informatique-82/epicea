unit Ta_Epi_TVA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TTa_Epi_TVA = class(TTable)
  private
    { D�clarations priv�es }
  protected
    { D�clarations prot�g�es }
  public
    { D�clarations publiques }
    Constructor Create(AOwner :TComponent); override;
	 Destructor Destroy;override;
  published
    { D�clarations publi�es }
  end;

//procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TableEpi', [TTa_Epi_TVA]);
end;

Constructor TTa_Epi_TVA.Create(AOwner :TComponent);
begin
inherited create(AOwner);
end;        

Destructor TTa_Epi_TVA.Destroy;
begin
inherited destroy;
end;
end.
