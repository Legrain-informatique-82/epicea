unit E2_FinCreat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,Gr_Librairie_Obj,E2_Librairie_Obj,
  LibGestionParamXML, DMConstantes;

type
  TFinCreat = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FinCreat: TFinCreat;

implementation

uses E2_Main,E2_CreatDos, E2_ParamEnt, E2_AutreDossier;
{$R *.DFM}

procedure TFinCreat.SpeedButton1Click(Sender: TObject);
var
NomDos,NomExo:string;
begin
NomDos:=E.NomDossier;
NomExo:=E.NomExo;
if CreatDos <> nil then
   if CreatDos.Visible then CreatDos.Close;
if ParamEnt <> nil then
   if ParamEnt.visible then ParamEnt.close;
Main.OuvreExo(NomDos,NomExo,false);
FinCreat.close;
end;

procedure TFinCreat.SpeedButton2Click(Sender: TObject);
begin
if CreatDos <> nil then
   if CreatDos.Visible then CreatDos.Close;
if ParamEnt <> nil then
   if ParamEnt.visible then ParamEnt.close;
if (AutreDossier = nil) then AutreDossier:=TAutreDossier.Create(self);
   AutreDossier.showModal;
FinCreat.close;
end;

procedure TFinCreat.SpeedButton3Click(Sender: TObject);
begin
if ParamEnt <> nil then
   if ParamEnt.visible then ParamEnt.close;
if CreatDos <> nil then
   if CreatDos.Visible then CreatDos.SetFocus;
//Main.Nouveau1Click(Main.Menu.Items[0].Items[Main.Menu.Items[0].Count-1].Items[0]);
FinCreat.close;
end;

procedure TFinCreat.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TFinCreat.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
FinCreat:=nil;
end;

end.
