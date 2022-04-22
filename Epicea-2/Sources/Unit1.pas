unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, E2_Librairie_obj,Gr_Librairie_obj;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
    try
	InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
    end;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 DestroyForm(Self,E.user);
end;

end.
