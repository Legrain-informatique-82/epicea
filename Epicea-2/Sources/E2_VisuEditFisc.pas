unit E2_VisuEditFisc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,Printers, OleCtrls, PdfLib_TLB,Gr_Librairie_Obj,E2_Librairie_Obj,DMConstantes;

type
  TVisuEditFisc = class(TForm)
    Pdf1: TPdf;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  VisuEditFisc: TVisuEditFisc;

implementation

{$R *.DFM}

procedure TVisuEditFisc.FormShow(Sender: TObject);
begin
Pdf1.src:='C:\Js\Epicea-2\cerfa\BILAN AGRICOLE REEL.fdf';
end;

procedure TVisuEditFisc.FormDestroy(Sender: TObject);
begin
Pdf1.Free;
DestroyForm(Self,E.User);
VisuEditFisc:=nil;
end;

procedure TVisuEditFisc.FormCreate(Sender: TObject);
begin
  try
      InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

end.
