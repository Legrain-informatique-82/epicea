unit E2_Patientez;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,ComCtrls,Gr_Librairie_Obj,E2_Librairie_Obj,LibGestionParamXML, DMConstantes;

type
  TPatientTh = class(TThread)
  private
  protected
   procedure Execute ; override;
//   procedure Terminate; override;
  public
  destructor destroy;override;
  end;
  TPatientez = class(TForm)
    Animate1: TAnimate;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    AfficherRech:boolean;
    PatientezDebut,PatientezFin:TTime;
  end;

var
  Patientez: TPatientez;
  PatientTH: TPatientTh;
  Function PatienterAffich(AffichRech:Boolean=false):Boolean;
  Function PatienterFermer(Type_Version:integer=1):Boolean;
  Function PatientThAffich(AffichRech:Boolean=false):Boolean;
  Function PatientThFermer:Boolean;

implementation

{$R *.DFM}

Function PatientThAffich(AffichRech:Boolean):Boolean;
Begin
if PatientTh = nil then PatientTh:=TPatientTh.Create(false);
End;

Function PatientThFermer:Boolean;
Begin
PatientTh.Terminate;
PatientTh.Free;
PatientTh:=nil;
End;

Procedure TPatientTh.Execute;
begin
PatienterAffich(false);
end;

Destructor TPatientTh.destroy;
begin
//PatienterFermer;
inherited;
end;

Function PatienterAffich(AffichRech:Boolean):Boolean;
Begin
try
//ShowMessage('patientez');
if Patientez = nil then Patientez:=TPatientez.Create(nil);
 Patientez.AfficherRech:=AffichRech;
if(Patientez.AfficherRech)then Patientez.Show;
Patientez.PatientezDebut:=time;
Screen.Cursor := crSQLWait;
result:=true;
except
  result:=false;
end;
End;


Function PatienterFermer(Type_Version:integer):Boolean;
Begin
//ShowMessage('ne patientez plus');
if Patientez = nil then Patientez:=TPatientez.Create(nil);
Screen.Cursor := crDefault;
Patientez.Patientezfin:=time;
if Type_Version=0 then
  showmessage('Temp : '+timetostr(Patientez.PatientezFin-Patientez.PatientezDebut));
if Patientez <> nil then
 if Patientez.Visible then
    begin
        Patientez.Close;
    end;
End;

procedure TPatientez.FormShow(Sender: TObject);
begin
Refresh;
Label1.Refresh;

//Animate1.Active:=true;
end;

procedure TPatientez.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Animate1.Active:=false;
end;

procedure TPatientez.FormCreate(Sender: TObject);
begin
//  try
//      InitialiseForm(E.User,Self);
//  except
//      Position:=poScreenCenter;
//      InitialiseFormPosDefaut(self);
//  end;
end;

procedure TPatientez.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
Patientez:=nil;
end;

procedure TPatientez.FormActivate(Sender: TObject);
begin
Patientez.Animate1.Visible:=AfficherRech;
Patientez.Animate1.Active:=AfficherRech;
end;

end.
