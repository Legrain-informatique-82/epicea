unit C_Edit_1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TEdit1 = class(TEdit)
  private
    { D�clarations priv�es }
  protected
    { D�clarations prot�g�es }
  public
    { D�clarations publiques }
  published
    { D�clarations publi�es }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('essai', [TEdit1]);
end;

end.
