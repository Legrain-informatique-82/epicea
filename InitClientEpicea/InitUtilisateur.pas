unit InitUtilisateur;

interface
                              // MD5Api,
uses windows,SysUtils,classes, dialogs,
//DCPcrypt2, DCPblockciphers, DCPblowfish,DCPsha256,
LbCipher,LbString;

procedure DisqueDur(Disque : String ; Var NomVolume, NumSerie : String) ;
Function ListTypeLecteur(TypeLecteur:integer):TStringList;
procedure modifFichierClient(Chemin,numero,typeClient:string);

procedure Encrypt(var typeClient,numero:string);
procedure Decrypt(var typeClient,numero:string);


type
  TEncryption = (eBf, eBfCbc, eDes, eDesCbc, e3Des, e3DesCbc, eRdl, eRdlCbc);


var

  Key128           : TKey128;
  Plaintext        :String;
  CipherText       :String;
implementation


procedure DisqueDur(Disque : String ; Var NomVolume, NumSerie : String) ;
{ Récupération des caractéristiques du disque dur }
{     Entrée  : Disque  ===>  C:\                 }
{     Sortie  : NomVolume : Label du disque       }
{               NumSerie  : Numéro de série       }
 
Var
    VolumeName         : Array [0..MAX_PATH-1] of Char ;
    FileSystemName     : Array [0..MAX_PATH-1] of Char ;
    VolumeSerialNo     : DWord ;
    MaxComponentLength : Dword ;
    FileSystemFlags    : Dword ;
begin
      GetVolumeInformation(PChar(Disque),VolumeName,MAX_PATH,@VolumeSerialNo,
                         MaxComponentLength,FileSystemFlags,
                         FileSystemName,MAX_PATH) ;
    NomVolume := VolumeName ;
    NumSerie  := IntToHex(HiWord(VolumeSerialNo),4)+'-'+
                 IntToHex(LoWord(VolumeSerialNo),4);

end;

procedure modifFichierClient(Chemin,numero,typeClient:string);
var F: TextFile;
valeur:string;
begin
     // Encryptage du typeClient dans le fichier
    AssignFile(F, Chemin);
    Rewrite(F);
    Encrypt(typeClient,numero);
    Writeln(F,typeClient);
    CloseFile(F); // ferme le fichier

//    //Decryptage du typeClient pour essai
//    AssignFile(F, Chemin);
//    Reset(f);
//    Readln(F,typeClient);
//    CloseFile(f);
//    decrypt(typeClient,numero);
end;


Function ListTypeLecteur(TypeLecteur:integer):TStringList;
var
i:integer;
Nom:PChar;
Begin
result:=TStringList.create;
for i:=0 to 31 do
  begin
	Nom:=Pchar(char(i+65)+':\');
   case GetDriveType(Nom) of
      DRIVE_FIXED: begin
                  if DRIVE_FIXED = TypeLecteur then Result.Add(nom);
                  end;
      DRIVE_REMOTE:begin
                  if DRIVE_REMOTE = TypeLecteur then Result.Add(nom);
                  end;
      DRIVE_REMOVABLE:begin
                  if DRIVE_REMOVABLE = TypeLecteur then Result.Add(nom);
                  end;
      DRIVE_CDROM:begin
                  if DRIVE_CDROM = TypeLecteur then Result.Add(nom);
                  end;
      DRIVE_RAMDISK:begin
                  if DRIVE_RAMDISK = TypeLecteur then Result.Add(nom);
                  end;
   end;

  end;
End;




procedure Encrypt(var typeClient,numero:string);
begin
//  RefreshKeys;
  GenerateLMDKey(Key128, SizeOf(Key128), numero);
//  case TEncryption(cbxEncryption.ItemIndex) of
    //eBf      :
    CipherText := BFEncryptStringEx(typeClient, Key128, True);
//    eBfCbc   : CipherText := BFEncryptStringCBCEx(PlainText, Key128, True);
//    eDes     : CipherText := DESEncryptStringEx(PlainText, Key64, True);
//    eDesCbc  : CipherText := DESEncryptStringCBCEx(PlainText, Key64, True);
//    e3Des    : CipherText := TripleDESEncryptStringEx(PlainText, Key128, True);
//    e3DesCbc : CipherText := TripleDESEncryptStringCBCEx(PlainText, Key128, True);
//    eRdl     : CipherText := RDLEncryptStringEx(PlainText, Key128, 16, True);
//    eRdlCbc  : CipherText := RDLEncryptStringCBCEx(PlainText, Key128, 16, True);
//  end;
  typeClient:=CipherText;
  //showmessage(typeClient);

end;

procedure Decrypt(var typeClient,numero:string);
begin
//  RefreshKeys;
  GenerateLMDKey(Key128, SizeOf(Key128), numero);
  CipherText := typeClient;
//  case TEncryption(cbxEncryption.ItemIndex) of
//    eBf      :
    typeClient := BFEncryptStringEx(CipherText, Key128, False);
//    eBfCbc   : PlainText := BFEncryptStringCBCEx(CipherText, Key128, False);
//    eDes     : PlainText := DESEncryptStringEx(CipherText, Key64, False);
//    eDesCbc  : PlainText := DESEncryptStringCBCEx(CipherText, Key64, False);
//    e3Des    : PlainText := TripleDESEncryptStringEx(CipherText, Key128, False);
//    e3DesCbc : PlainText := TripleDESEncryptStringCBCEx(CipherText, Key128, False);
//    eRdl     : PlainText := RDLEncryptStringEx(CipherText, Key128, 16, False);
//    eRdlCbc  : PlainText := RDLEncryptStringCBCEx(CipherText, Key128, 16, False);
//  end;
  //showmessage(typeClient);
end;



end.

