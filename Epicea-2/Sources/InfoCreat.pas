unit InfoCreat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls,Gr_Librairie_obj,E2_Librairie_Obj, ExtCtrls,
  LibGestionParamXML, DMConstantes;

type
  TInfoCre = class(TForm)
    RichEdit1: TRichEdit;
    Panel1: TPanel;
    Imprime: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImprimeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  InfoCre: TInfoCre;

implementation

{$R *.DFM}

procedure TInfoCre.FormShow(Sender: TObject);
begin
self.top:=0;
self.Left:=0;
end;

procedure TInfoCre.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(self,E.USer);
InfoCre:=nil;
end;

procedure TInfoCre.ImprimeClick(Sender: TObject);
begin
RichEdit1.Print(self.Caption);
end;

procedure TInfoCre.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

end.
