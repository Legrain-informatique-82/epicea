unit LibSaisieIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  E2_Librairie_Obj,
  shellApi,
//  LibZoneSaisie,
  StdCtrls, ExtCtrls;

type
  TSaisieIP = class(TForm)
    EdIP1: TEdit;
    EdIP2: TEdit;
    EdIP3: TEdit;
    EdIP4: TEdit;
    BtnValider: TButton;
    BtnAnnuler: TButton;
    Timer1: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdIP1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure EdIP1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdIP1Exit(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  SaisieIP: TSaisieIP;

  Function SaisieIPAffiche:Boolean;

implementation

{$R *.dfm}
Function SaisieIPAffiche:Boolean;
Var
AddresseIP:String;
Begin
if SaisieIP = nil then SaisieIP:=TSaisieIP.Create(Application);
 if SaisieIP.ShowModal = mrOk then
  begin
   AddresseIP :=SaisieIP.EdIP1.Text +
                '.'+
                SaisieIP.EdIP2.Text +
                '.'+
                SaisieIP.EdIP3.Text +
                '.'+
                SaisieIP.EdIP4.Text;
   if ShellExecute(Application.Handle,nil,PChar(E.RepertoireProgram+'VNC\WinVNC.exe'),
             nil,nil,sw_show)>32 then
              begin
               SaisieIP.Timer1.Enabled := true;
              end;
  end;
//
End;


procedure TSaisieIP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key = VK_RETURN) then
  PostMessage(Handle,WM_NEXTDLGCTL,0,0);
// WinSuivPrec(Handle,key,[nil]);
if key = VK_ESCAPE then BtnAnnuler.Click;
end;

procedure TSaisieIP.EdIP1KeyPress(Sender: TObject; var Key: Char);
begin
if key = #46 then
  PostMessage(Handle,WM_NEXTDLGCTL,0,0);
//  WinSuivPrec(Handle,VK_RETURN,[nil]);
if not (key in [#48..#57]) then
 key:=#0;
if (((Sender as TEdit).SelStart = 2) and ((key in [#48..#57]))) then
  PostMessage(Handle,WM_NEXTDLGCTL,0,0);
//  WinSuivPrec(Handle,VK_RETURN,[nil]);
end;

procedure TSaisieIP.FormShow(Sender: TObject);
begin
EdIP1.SetFocus;
end;

procedure TSaisieIP.EdIP1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
AdresseIp:String;
begin
   AdresseIP :=SaisieIP.EdIP1.Text +
                '.'+
                SaisieIP.EdIP2.Text +
                '.'+
                SaisieIP.EdIP3.Text +
                '.'+
                SaisieIP.EdIP4.Text;
   self.Caption := 'Saisie de l''adresse IP : '+AdresseIP;
end;

procedure TSaisieIP.EdIP1Exit(Sender: TObject);
begin
if length((Sender as TEdit).Text) = 0  then
 (Sender as TEdit).Text := '0';
end;

procedure TSaisieIP.Timer1Timer(Sender: TObject);
var
AddresseIP:String;
begin
   AddresseIP :=SaisieIP.EdIP1.Text +
                '.'+
                SaisieIP.EdIP2.Text +
                '.'+
                SaisieIP.EdIP3.Text +
                '.'+
                SaisieIP.EdIP4.Text;
Timer1.Enabled := false;
ShellExecute(Application.Handle,nil,PChar(E.RepertoireProgram+'VNC\WinVNC.exe'),
             PChar('-connect '+ AddresseIP),nil,sw_show);
end;

end.
