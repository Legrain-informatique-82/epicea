

unit DllThread;
 
interface
 
Uses
  Classes, ExtCtrls,Dialogs;
 
Type
  TDLLThread = class(TThread)

  private
    CheckTimer       : TTimer;
    festActif : boolean;
    procedure DoSynchronizeCheck(Sender : TObject);
  protected
  Public
   Constructor DllCreate(CreateSuspended: Boolean);
   property estActif:boolean read festActif;
    Destructor Destroy; Override;
    Procedure DllSynchronize(Method : TThreadMethod);
  end;
 
implementation

uses SysUtils;
 
{ TDLLThread }
 
constructor TDLLThread.DllCreate(CreateSuspended: Boolean);
begin
  CheckTimer := TTimer.Create(nil);

  CheckTimer.Interval := 1;
  CheckTimer.Enabled := FALSE;
  festActif:=CheckTimer.Enabled;
  CheckTimer.OnTimer := DoSynchronizeCheck;
  inherited Create(CreateSuspended);
end;
 
destructor TDLLThread.Destroy;
begin
  CheckTimer.Free;
  inherited;
end;
 
procedure TDLLThread.DllSynchronize(Method: TThreadMethod);
begin
  CheckTimer.Enabled := TRUE;
  festActif:=CheckTimer.Enabled;
  Synchronize(Method);
end;
 
procedure TDLLThread.DoSynchronizeCheck(Sender: TObject);
begin
  CheckTimer.Enabled := CheckSynchronize;
  festActif:=CheckTimer.Enabled;
  showmessage('CheckTimer.Enabled : '+BoolToStr(estActif));
end;
 
end.
 