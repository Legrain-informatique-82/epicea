unit LibInternet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,Ras,registry,NMsmtp;

const
  RAS_MaxEntryName      =  256;
  RAS_MaxDeviceName     =  128;
  RAS_MaxDeviceType     =  16;

type
  HRASConn = DWORD;

  PRASConn = ^TRASConn;
  TRASConn = record
     dwSize: DWORD;
     rasConn: HRASConn;     // handle de la connexion
     szEntryName: Array[0..RAS_MaxEntryName] of Char;
     szDeviceType : Array[0..RAS_MaxDeviceType] of Char;
     szDeviceName : array [0..RAS_MaxDeviceName] of char;
  end;

  PRASConnStatus = ^TRASConnStatus;
  TRASConnStatus = record
    dwSize: LongInt;
    rasConnstate: Word;
    dwError: LongInt;
    szDeviceType: Array[0..RAS_MaxDeviceType] of Char;
    szDeviceName: Array[0..RAS_MaxDeviceName] of Char;
  end;


//var
// entête des fonctions que l'on souhaite utiliser et qui seront issu de la
// dll RASAPI32.dll
function RasEnumConnections(RASConn: PrasConn;           { buffer receant les données }
                            var BufSize: DWord;           { taille du buffer }
                            var Connections: DWord        { nombre de connexions }
                            ): LongInt; stdcall;
function RasHangUp(RASConn: hrasConn): LongInt; stdcall;      { handle de la connection à déconnecter }
function RasGetConnectStatus(RASConn: hrasConn;        { handle to Remote Access Connection of interest }
                             RASConnStatus: PRASConnStatus        { buffer to receive status data }
                             ): LongInt; stdcall;

Function ListeConnection:TStringList;
Procedure ActiverConnection(NomConnections:string);
procedure NouvelleConnectionI;
Function Detection_Connexion : Boolean;
Procedure Mail_EnvoiEMail(NMSMTP:TNMSMTP);

implementation

const
  RAS_DLL = 'RASAPI32.dll';

var
toto:integer;

// indispensable pour pouvoir utiliser les fonctions de la dll RASAPI32.dll :

function RasEnumConnections; external RAS_DLL name 'RasEnumConnectionsA';
function RasHangUp; external RAS_DLL name 'RasHangUpA';
function RasGetConnectStatus; external RAS_DLL name 'RasGetConnectStatusA';

//Function ListeConnection:TStringList;
//var
//  TabRasConn      :array[1..100]of TRASConn;
//  //Mettre plus de 10 si vous risquez d'avoir plus de 10 connexions !
//  NbConnections   : DWord;// servira à indiquer le nombre de connexions
//  BufSize : DWord;
//  i       :integer;
//
////implementation
////
////Function ListeConnection:TStringList;
//begin
//if result=nil then result:=TStringList.Create;
//result.Clear;
//    TabRasconn[1].dwSize := Sizeof(TRasconn);
//    BufSize := Sizeof(TabRasconn);
//    // RasEnumConnections permet de récupérer dans le tableau TabRasConn les
//    // caractéristiques des connexions en cours
//    if RasEnumConnections(@TabRasConn, BufSize, NbConnections)<>0 then ShowMessage('erreur RasEnumConnections');
//    if NbConnections>0 then
//      for i:=1 to NbConnections do
//      begin
//        // pour chaque connexion, on affiche ses caractéristiques
//        result.Add(string(TabRasconn[i].szEntryName)+' '
//                  +string(TabRasconn[i].szDeviceType)+' '
//                  +string(TabRasconn[i].szDeviceName));
//      end;
//
//end;

Function ListeConnection:TStringList;
var
    Entries  : array [0..15] of TRASENTRYNAME;
    cb       : DWORD;
    cEntries : DWORD;
    dwRet    : DWORD;
    Buf      : array [0..127] of char;
    I        : Integer;
begin
   if Result=nil then
    Result:=TStringList.Create;
    Result.Clear;
    FillChar(Entries, SizeOf(Entries), 0);
    Entries[0].dwSize := SizeOf(TRASENTRYNAME);
    cb := SizeOf(Entries);
    cEntries := 0;
    dwRet := RasEnumEntriesA(NIL, NIL, @Entries[0], @cb, @cEntries);
    if dwRet <> 0 then begin
        RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));
        ShowMessage('Erreur lors de la récupération des connections !');
    end;
    for I := 0 to cEntries - 1 do
        Result.Add(Entries[I].szEntryName);
end;

Procedure ActiverConnection(NomConnections:string);
begin
Winexec(PChar('rundll rnaui.dll,RnaDial '+NomConnections),SW_NORMAL);
end;

procedure NouvelleConnectionI;
var
    EntryName : String;
    dwRet     : DWORD;
    Buf       : Array [0..127] of char;
begin
    dwRet := RasCreatePhonebookEntryA(Application.Handle, nil);
    if dwRet <> 0 then begin
        RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));
//        LogMessage(Buf);
    end
    else begin
        EntryName :='';// EntryNameCombobox.Text;
//        LoadPhoneBook;
//        SelectPhoneBookEntry(EntryName);
    end;
end;

Function Detection_Connexion : Boolean;
Var
 Reg: Treginifile;
 buff : integer;
Begin
 Reg:=TreginiFile.Create('');
 Reg.rootkey:=HKEY_LOCAL_MACHINE;
 Reg.OpenKey('System\CurrentControlSet\Services\RemoteAccess', False) ;
 Reg.ReadBinaryData('Remote Connection',buff,16);
  if buff = 1 then  Detection_Connexion:=True else
  Detection_Connexion:=False;
End;

Procedure Mail_EnvoiEMail(NMSMTP:TNMSMTP);
begin
if not Detection_Connexion then
  showmessage('Attention, Vous n''êtes pas connecté à Internet !')
  else
  begin
//  if not NMSMTP.Connected then
   NMSMTP.SendMail
//   else
//   NMSMTP.Disconnect;
  end;
end;

end.
