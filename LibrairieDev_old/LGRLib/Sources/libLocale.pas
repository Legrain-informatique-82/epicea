unit libLocale;

interface
uses
Controls,
SysUtils,
Classes,
Windows,
ShellAPI,
Forms,
Dialogs;

type
   TDetailDate = Record
     Date_:TDate;
     an:word;
     mois:word;
     jour:word;
     DateWord:word;
     AnStr:string;
     JourStr:string;
     MoisStr:string;
     Valide:boolean;
     DateStr:String;
     Vide:Boolean;
     DateReal:Real;
     DatePourSQLStr:String;
     DateStrFormat:String;
     JourMois:string;
     MoisAnnee:string;
   end;

    TDetailTime = Record
     Time_:TTime;
     Heure : word;
     minute:word;
     Seconde:word;
     HeureWord:word;
     HeureStr:string;
     MinuteStr:string;
     SecondeStr:string;
     Valide:boolean;
     HoraireStr:String;
     Vide:Boolean;
     HeureReal:Real;
     HeureStrFormate:String;
    end;


  Function DateInfosLgr(Date:TDate;FormatReduit:boolean=false):TDetailDate;overload;
  Function DateInfosLgr(Date:TDate;Separateur:String;FormatReduit:boolean=false):TDetailDate;overload;
  Function ListTypeLecteur(TypeLecteur:integer):TStringList;
  function CopyAllFiles(sFrom, sTo: string; Protect: boolean): boolean;
  function CopyAllFilesEx(sFrom, sTo, TitreFenetre: string; Protect: boolean): boolean;
  Procedure AjouterFichierTexte(NomFichier,Texte:String);
  Function HeureInfos(Horaire:TTime;Separateur:String):TDetailTime;
  function monSplit(chaine : String; delimiteur : string) : TStringList;
  
implementation


Function DateInfosLgr(Date:TDate;Separateur:String;FormatReduit:boolean):TDetailDate;
var
DetailDate:TDetailDAte;
Begin
DetailDate:=DateInfosLgr(Date);
result.DateStrFormat:=DetailDate.JourStr+separateur+DetailDate.MoisStr+separateur+DetailDate.AnStr;
End;

Function DateInfosLgr(Date:TDate;FormatReduit:boolean):TDetailDate;
var
DateStr:string;
An,Mois,Jour:Word;
Begin
try
  result.Vide:=false;
  result.Valide:=true;
  DateStr:=DateToStr(Date);
  if date=0 then result.Vide:=true;
  DecodeDate(Date,An,Mois,Jour);
  result.an:=An;
  result.mois:=Mois;
  result.jour:=Jour;
  result.AnStr:=InttoStr(An);
  result.MoisStr:=IntToStr(Mois);
  if Mois < 10 then result.MoisStr:='0'+result.MoisStr;
  result.JourStr:=IntToStr(Jour);
  if Jour < 10 then result.JourStr:='0'+result.JourStr;
  result.Date_:=Date;
  result.DateStr:=DateStr;
  if FormatReduit then
    begin
      result.AnStr:=copy(result.AnStr,3,2);
      result.DateStr:=result.JourStr+'/'+result.MoisStr+'/'+result.AnStr;
    end;
  result.DateReal := (Date);
  result.DatePourSQLStr:=result.MoisStr+'/'+result.JourStr+'/'+result.AnStr;
  result.DateStrFormat:= result.JourStr+'/'+result.MoisStr+'/'+result.AnStr;
  result.JourMois:=result.JourStr+'/'+result.MoisStr;
  result.MoisAnnee:=result.MoisStr+'/'+result.AnStr;
except
  result.Valide:=False;
end;

End;


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

function CopyAllFiles(sFrom, sTo: string; Protect: boolean): boolean;
{ Copies files or directory to another directory. }
var
  F: TShFileOpStruct;
  ResultVal: integer;
  tmp1, tmp2: string;
begin
  FillChar(F, SizeOf(F), #0);
  Screen.Cursor := crHourGlass;
  try
    F.Wnd   := 0;
    F.wFunc := FO_COPY;
    { Add an extra null char }
    tmp1    := sFrom + #0;
    tmp2    := sTo + #0;
    F.pFrom := PChar(tmp1);
    F.pTo   := PChar(tmp2);
    F.lpszProgressTitle:=PChar('Sauvegarde du dossier en cours ...');
    if Protect then
      F.fFlags := FOF_RENAMEONCOLLISION or FOF_SIMPLEPROGRESS
 //     F.fFlags := FOF_SIMPLEPROGRESS or FOF_NOCONFIRMATION
    else
      F.fFlags :=FOF_SIMPLEPROGRESS or FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION;
//      F.fFlags :=FOF_SIMPLEPROGRESS or FOF_FILESONLY or FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION;

    F.fAnyOperationsAborted := False;
    F.hNameMappings := nil;
    Resultval := ShFileOperation(F);
    Result := (ResultVal = 0);
  finally
    Screen.Cursor := crDefault;
  end;
end;

function CopyAllFilesEx(sFrom, sTo, TitreFenetre: string; Protect: boolean): boolean;
{ Copies files or directory to another directory. }
var
  F: TShFileOpStruct;
  ResultVal: integer;
  tmp1, tmp2: string;
begin
  result:=false;
  FillChar(F, SizeOf(F), #0);
  Screen.Cursor := crHourGlass;
  try
    F.Wnd   := 0;
    F.wFunc := FO_COPY;
    { Add an extra null char }
    tmp1    := sFrom + #0;
    tmp2    := sTo + #0;
    F.pFrom := PChar(tmp1);
    F.pTo   := PChar(tmp2);
    F.lpszProgressTitle:=PChar(TitreFenetre);//PChar('Sauvegarde du dossier en cours ...');
    if Protect then
      F.fFlags := FOF_RENAMEONCOLLISION or FOF_SIMPLEPROGRESS
    else
      F.fFlags :=FOF_SIMPLEPROGRESS or FOF_FILESONLY or FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION;

    F.fAnyOperationsAborted := False;
    F.hNameMappings := nil;
    Resultval := ShFileOperation(F);
    Result := (ResultVal = 0);
  finally
    Screen.Cursor := crDefault;
  end;
end;

Procedure AjouterFichierTexte(NomFichier,Texte:String);
var F: TextFile;
begin
try
    if NomFichier='' then NomFichier:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'error.txt';
    AssignFile(F, NomFichier);//A partir de maintenant, F désigne le fichier portant comme nom le nom récupéré par OpenDialog1
    if FileExists(NomFichier) then
     begin
      append(F);
     end
    else
    Rewrite(F);
    Writeln(F,Texte);
    CloseFile(F); // ferme le fichier
except;
 Showmessage('Erreur lors de la modification du fichier : '+NomFichier);
 abort;
end;
//    Flush(F);
End;

Function HeureInfos(Horaire:TTime;Separateur:String):TDetailTime;
var
HoraireStr:string;
Heure,Minute,Seconde,MSeconde:Word;
Begin
try
  result.Vide:=false;
  result.Valide:=true;
  HoraireStr:=TimeToStr(Date);
  if date=0 then result.Vide:=true;
  DecodeTime(Horaire,Heure,Minute,Seconde,MSeconde);
  result.Heure:=Heure;
  result.minute:=Minute;
  result.Seconde:=Seconde;
  result.HeureStr:=InttoStr(Heure);
  result.MinuteStr:=IntToStr(Minute);
  result.SecondeStr:=IntToStr(Seconde);
  result.Time_:=Horaire;
  result.HoraireStr:=HoraireStr;
  result.HeureStrFormate:=result.HeureStr+Separateur+result.MinuteStr+Separateur+result.SecondeStr;
except
  result.Valide:=False;
end;

End;

function monSplit(chaine : String; delimiteur : string) : TStringList;
var
L : TStringList;
begin
  L:=TStringList.create;
  L.text := StringReplace(chaine, delimiteur, #13#10, [rfReplaceAll]);
 
  monSplit:=L;
end;

end.
