//WinTypes=Windows;WinProcs=Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE;
unit LibFichRep;

interface

Uses
SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
Controls, Dialogs,shellapi,Forms, ShlObj,
ComObj,
ActiveX,
SHFolder,
StdCtrls,
  registry,FileUtil,LibDates,Lib_Chaine,
//  Gr_Librairie_Obj,
  DdeMan,
  LibChoixRep;

const
{ operating system constants }
cOsUnknown = -1;
cOsWin95 = 0;
cOsWin98 = 1;
cOsWin98SE = 2;
cOsWinME = 3;
cOsWinNT = 4;
cOsWin2000 = 5;
cOsWhistler = 6;
C_BarreDTAcheAffiche = 0;
C_BarreDTAcheCache = 1;
C_BarreDTAcheEnable = 2;
C_BarreDTAcheDisable = 3;
type
ShortcutType = (_DESKTOP, _QUICKLAUNCH, _SENDTO, _STARTMENU);

TParamChoixRep=record
   TitreForm:String;
   TitreDialogRep:String;
   RepDefaut:String;
   AfficheRepDefDansEdit:Boolean;
end;

 TResultChoisirRep = Record
  Retour:Boolean;
  RepChoisi:String;
 End;

//******************************************************************************
// Retourne un TStringList d'un type de fichiers dans un répertoire donné
// Trié en ordre alphabétique
// Parametres:
// Masque : '*.*' ou '*.txt' ou Etc...
// Rep:Indique le répertoire dans lequel on fait la recherche
// Attribut : spécifie le type de fichier:
      //faReadOnly	$00000001	Fichiers en lecture seule
      //faHidden	$00000002	Fichiers cachés
      //faSysFile	$00000004	Fichiers système
      //faVolumeID	$00000008	Fichiers d'identification de volume
      //faDirectory	$00000010	Fichiers répertoire
      //faArchive	$00000020	Fichiers archive
      //faAnyFile	$0000003F	Tous les fichiers
// Chemin : Permet de spécifier si l'on veut le chemin complet avec les fichiers mais sans le lecteur
// Lecteur : Permet de spécifier si l'on veut le leceur aussi
//******************************************************************************
Function ListeFic(Masque,Rep:string;Attribut:integer;Chemin,Lecteur:boolean):TStringList;overload;
Function ListeFic(Masque:TStringList;Rep:string;Attribut:integer;Chemin,Lecteur:boolean):TStringList;overload;
function CopyAllFiles(sFrom, sTo: string; Protect: boolean;mess:string=''): boolean;
function CopyAllFilesEx(sFrom, sTo, TitreFenetre: string; Protect: boolean): boolean;
function CopyAllFilesListe(sFrom, sTo:string;listeFichier:Tstringlist): boolean;
//Function ListTypeLecteur(TypeLecteur:integer):TStringList;
Procedure CreerFichierTexte(NomFichier,Texte:String);
Procedure AjouterFichierTexte(NomFichier,Texte:String);
function EffaceDossier2(Dossier: string): Boolean;
function EffaceDossier(Dossier: string): Boolean;
function RenommeDossier(OldNomDossier,NewNomDossier: string): Boolean;
function RenommeFolder(FromFld, ToFld: string): boolean;
function NumSystemExploitation : integer;
procedure CreateShortcut(SourceFileName: string; Location: ShortcutType; SubDirectory : string);
Function FileExistDialog(var NomRep:String;NomFichier: String;OuvrirDialog:Boolean):Boolean;
Function ChercheFileDialog(var NomRep,NomFichier: String;TexteFiltre: String;OuvrirDialog:Boolean;Titre:String):Boolean;
Function CreerDossierDateJour(Chemin,Prefixe:String):String;
procedure SearchInFolder(Folder : string);
Function ChangeExtensionFichier(NomFichier,NewExtension:String):String;
Function RepertoirePere(Directory:String):String;
Function DeleteListFile(ListeFichier:TStringList):Boolean;
Function ChoisirRepertoire(ParamChoixRep:TParamChoixRep):TResultChoisirRep;
procedure PropertiesDialog(filename:String);
Function NumSerieDD(NomDisque:string):Integer;
Procedure GereBarreDesTaches(Action : Integer);
function TypeRepertoirePath(CSIDL_Type:integer): string;
Function RecupListeRepertoireWindows:Tstringlist;
//function RunAsAdmin(hWnd : HWND; aFile : String; aParameters : String;Directory:string='' ; ShowCmd:integer=0):boolean;
//function RunAsAdmin(const Path, Params: string): Boolean;

{Connaître les répertoires des dossiers de Windows

  Constantes utilisé pour connaitre l'emplacement des répertoires Windows

CSIDL_WINDOWS ;36;C:\WINDOWS
CSIDL_SYSTEM ;37;C:\WINDOWS\SYSTEM
CSIDL_PROGRAM_FILES ;38;C:\Program Files
CSIDL_MYPICTURES ;39;C:\Mes documents\Mes images
CSIDL_PROGRAM_FILES_COMMON ;43;C:\Program Files\Fichiers communs
CSIDL_COMMON_DOCUMENTS ;46;
CSIDL_DESKTOP ;0;C:\WINDOWS\Bureau
CSIDL_INTERNET ;1;
CSIDL_PROGRAMS ;2;C:\WINDOWS\Menu Démarrer\Programmes
CSIDL_CONTROLS ;3;
CSIDL_PRINTERS ;4;
CSIDL_PERSONAL ;5;C:\Mes documents
CSIDL_FAVORITES ;6;C:\WINDOWS\Favoris
CSIDL_STARTUP ;7;C:\WINDOWS\Menu Démarrer\Programmes\Démarrage
CSIDL_RECENT ;8;C:\WINDOWS\Recent
CSIDL_SENDTO ;9;C:\WINDOWS\SendTo
CSIDL_STARTMENU ;11;C:\WINDOWS\Menu Démarrer
CSIDL_NETWORK ;18;
CSIDL_NETHOOD ;19;C:\WINDOWS\Voisinage réseau
CSIDL_FONTS ;20;C:\WINDOWS\FONTS
CSIDL_COMMON_STARTMENU ;22;
CSIDL_COMMON_PROGRAMS ;23;C:\WINDOWS\All Users\Menu Démarrer\Programmes
CSIDL_COMMON_STARTUP ;24;
CSIDL_COMMON_DESKTOPDIRECTORY ;25;C:\WINDOWS\All users\Bureau
CSIDL_APPDATA ;26;C:\WINDOWS\Application Data
CSIDL_PRINTHOOD ;27;C:\WINDOWS\PrintHood
CSIDL_ALTSTARTUP ;29;
CSIDL_COMMON_ALTSTARTUP ;30;
CSIDL_COMMON_FAVORITES ;31;
CSIDL_TEMPLATES ;
CSIDL_INTERNET_CACHE ;32;C:\WINDOWS\Temporary Internet Files
CSIDL_COOKIES ;33;C:\WINDOWS\Cookies
CSIDL_HISTORY ;34;C:\WINDOWS\Historique
}
Function RepertoireWindows(TypeRepertoire : Integer):String;


implementation

//******************************************************************************
// Retourne un TStringList d'un type de fichiers dans un répertoire donné
// Trié en ordre alphabétique
// Parametres:
// Masque : '*.*' ou '*.txt' ou Etc...
// Rep:Indique le répertoire dans lequel on fait la recherche
// Attribut : spécifie le type de fichier:
      //faReadOnly	$00000001	Fichiers en lecture seule
      //faHidden	$00000002	Fichiers cachés
      //faSysFile	$00000004	Fichiers système
      //faVolumeID	$00000008	Fichiers d'identification de volume
      //faDirectory	$00000010	Fichiers répertoire
      //faArchive	$00000020	Fichiers archive
      //faAnyFile	$0000003F	Tous les fichiers
//******************************************************************************
Function ListeFic(Masque,Rep:string;Attribut:integer;Chemin,Lecteur:boolean):TStringList;overload;
var
F:TSearchRec;
Repertoire,lect:string;
ListAux:TStringList;
begin
// if ListAux=nil then
 ListAux:=TStringList.Create;
 if ListAux.count>0 then  ListAux.Clear;
 ListAux.Sort;
rep:=IncludeTrailingPathDelimiter(Rep);
Repertoire:=copy(Rep,4,length(Rep));
Lect:=copy(Rep,1,3);
//showmessage(Rep+Masque);
 if FindFirst(Rep+Masque,Attribut,F) =0 then
 Begin
   if F.Attr = faDirectory then
    begin
      if not ((F.Name = '.') or (F.Name = '..')) then
       begin
        if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
        if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
        if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
        if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
       end;
     end
    else
     begin
       if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
       if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
       if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
       if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
     end;
 End;

 while FindNext(F)=0 do
       Begin
         if F.Attr = faDirectory then
          begin
           if not ((F.Name = '.') or (F.Name = '..')) then
            begin
             if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
             if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
             if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
             if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
            end;
          end
         else
          begin
            if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
            if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
            if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
            if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
          end;
       End;
 FindClose(F.FindHandle);
result:=ListAux;
end;


Function ListeFic(Masque:TStringList;Rep:string;Attribut:integer;Chemin,Lecteur:boolean):TStringList;overload;
var
F:TSearchRec;
Repertoire,lect:string;
ListAux:TStringList;
i:integer;
begin
// if ListAux=nil then
 ListAux:=TStringList.Create;
 if ListAux.count>0 then  ListAux.Clear;
 ListAux.Sort;
rep:=IncludeTrailingPathDelimiter(Rep);
Repertoire:=copy(Rep,4,length(Rep));
Lect:=copy(Rep,1,3);
//showmessage(Rep+Masque);
i:=0;
while i<=Masque.Count-1 do
  begin
       if FindFirst(Rep+Masque[i],Attribut,F) =0 then
       Begin
         if F.Attr = faDirectory then
          begin
            if not ((F.Name = '.') or (F.Name = '..')) then
             begin
              if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
              if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
              if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
              if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
             end;
           end
          else
           begin
             if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
             if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
             if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
             if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
           end;
       End;
     inc(i);  
  end;

 while FindNext(F)=0 do
       Begin
         if F.Attr = faDirectory then
          begin
           if not ((F.Name = '.') or (F.Name = '..')) then
            begin
             if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
             if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
             if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
             if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
            end;
          end
         else
          begin
            if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
            if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
            if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
            if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
          end;
       End;
 FindClose(F.FindHandle);
result:=ListAux;
end;

function CopyAllFiles(sFrom, sTo: string; Protect: boolean;mess:string): boolean;
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
    if mess<>'' then
       F.lpszProgressTitle:=PChar(mess)
    else
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


function CopyAllFilesListe(sFrom, sTo:string;listeFichier:Tstringlist): boolean;
{ Copies files or directory to another directory. }
var
  hFind : TSearchRec;
  i:integer;
  filename:TstringList;
begin 
sFrom:=IncludeTrailingPathDelimiter(sFrom);
sTo:=IncludeTrailingPathDelimiter(sTo);
filename:=TstringList.create;
if(not DirectoryExists(sTo))then CreateDir(sTo);

          if FindFirst( sFrom + '*.*', FaAnyFile, hFind ) = 0 then
              begin
                  repeat
                      if (hFind.Name <> '.') and (hFind.Name <> '..') then
                      begin
                          if ( hFind.Attr and faDirectory ) <> faDirectory then { c'est un fichier = copie }
                          begin
                            filename.clear;
                            ExtractStrings(['.'],[' '],PAnsiChar(hFind.Name),filename);
                             if(listeFichier.IndexOf(lowercase(filename.Strings[0]))<>-1)then
                               CopyFile(sFrom+hFind.Name,sTo+hFind.Name,nil);
                         end
                         else
                         begin
                            filename.clear;
                            ExtractStrings(['.'],[' '],PAnsiChar(hFind.Name),filename);
                            if(listeFichier.IndexOf(lowercase(filename.Strings[0]))<>-1)then
                              begin
                                CreateDir( sTo + hFind.Name );
                                CopyAllFilesListe(sFrom + hFind.Name,sTo + hFind.Name,listeFichier);
                              end;
                        end;
                     end;

                  until FindNext(hFind) <> 0;

                  SysUtils.FindClose(hFind);
                  Application.ProcessMessages

              end;
end;

//Function ListTypeLecteur(TypeLecteur:integer):TStringList;
//var
//i:integer;
//Nom:PChar;
//Begin
//result:=TStringList.create;
//for i:=0 to 31 do
//  begin
//	Nom:=Pchar(char(i+65)+':\');
//   case GetDriveType(Nom) of
//      DRIVE_FIXED: begin
//                  if DRIVE_FIXED = TypeLecteur then Result.Add(nom);
//                  end;
//      DRIVE_REMOTE:begin
//                  if DRIVE_REMOTE = TypeLecteur then Result.Add(nom);
//                  end;
//      DRIVE_REMOVABLE:begin
//                  if DRIVE_REMOVABLE = TypeLecteur then Result.Add(nom);
//                  end;
//      DRIVE_CDROM:begin
//                  if DRIVE_CDROM = TypeLecteur then Result.Add(nom);
//                  end;
//      DRIVE_RAMDISK:begin
//                  if DRIVE_RAMDISK = TypeLecteur then Result.Add(nom);
//                  end;
//   end;
//  end;
//End;

Procedure CreerFichierTexte(NomFichier,Texte:String);
var F: TextFile;
begin
    AssignFile(F, NomFichier);//A partir de maintenant, F désigne le fichier portant comme nom le nom récupéré par OpenDialog1
    Rewrite(F); // ouvre le fichier dans le but d'être réécrit. Le fichier peut ne pas encore exister sur le disque dur
    Writeln(F,Texte);
    CloseFile(F); // ferme le fichier
End;

Procedure AjouterFichierTexte(NomFichier,Texte:String);
var F: TextFile;
begin
try
    if Str_Empty(NomFichier) then NomFichier:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'error.txt';
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



function EffaceDossier2(Dossier: string): Boolean;
Begin
 cleardir(Dossier,true);
End;

function EffaceDossier(Dossier: string): Boolean;
var FileOpStruct: TShFileOpStruct;
    begin
        FileOpStruct.Wnd := 0;
        FileOpStruct.wFunc := FO_DELETE;
        FileOpStruct.pFrom := PChar(Dossier);
        FileOpStruct.pTo := nil;
        FileOpStruct.fFlags := FOF_NOCONFIRMATION or FOF_SILENT;
        FileOpStruct.lpszProgressTitle := nil;
        Result := ShFileOperation(FileOpStruct) = 0;
    end;

function RenommeDossier(OldNomDossier,NewNomDossier: string): Boolean;
var FileOpStruct: TShFileOpStruct;
    begin
    FillChar (FileOpStruct, SizeOf (FileOpStruct), 0);

        FileOpStruct.Wnd := 0;
        FileOpStruct.wFunc := FO_RENAME;
        FileOpStruct.pFrom := PChar(OldNomDossier);
        FileOpStruct.pTo := PChar(NewNomDossier);
        FileOpStruct.fFlags :=FOF_NOCONFIRMATION or FOF_SILENT or FOF_ALLOWUNDO OR FOF_FILESONLY;
        FileOpStruct.lpszProgressTitle := nil;
        Result := ShFileOperation(FileOpStruct) = 0;
end;


function RenommeFolder(FromFld, ToFld: string): boolean;
var fos: TSHFileopStruct;
var retour : integer;
begin 
// il faut supprimer les antislashs de fin sinon vous aurez droit à un message d'erreur 
  FromFld := ExcludeTrailingPathDelimiter(Trim(FromFld)); 
  ToFld := ExcludeTrailingPathDelimiter(Trim(ToFld)); 

  FillChar(fos, SizeOf(fos),0); 
  with fos do 
  begin 
    wFunc := FO_RENAME;
    pFrom := PChar(FromFld+#0);
    pTo   := PChar(ToFld+#0); 
    fFlags := FOF_MULTIDESTFILES or FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_RENAMEONCOLLISION or FOF_WANTMAPPINGHANDLE
    or FOF_NOCONFIRMMKDIR or FOF_NOERRORUI;
  end;
  retour:= ShFileOperation(fos);
 // showmessage('retour : '+IntToStr(retour));
  Result := retour=0;
end;


function NumSystemExploitation : integer;
var
  osVerInfo : TOSVersionInfo;
  majorVer, minorVer : Integer;


begin
  result := cOsUnknown;
{ set operating system type flag }
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(osVerInfo) then
  begin
    majorVer := osVerInfo.dwMajorVersion;
    minorVer := osVerInfo.dwMinorVersion;
    case osVerInfo.dwPlatformId of VER_PLATFORM_WIN32_NT : { Windows NT/2000 }
    begin
      if majorVer <= 4 then
      result := cOsWinNT
      else if (majorVer = 5) AND (minorVer= 0) then
      result := cOsWin2000
      else if (majorVer = 5) AND (minorVer = 1) then
      result := cOsWhistler
      else
      result := cOsUnknown;
    end;
    VER_PLATFORM_WIN32_WINDOWS : { Windows 9x/ME }
    begin
    if (majorVer = 4) AND (minorVer = 0) then
    result := cOsWin95
    else if (majorVer = 4) AND (minorVer = 10) then
    begin
    if osVerInfo.szCSDVersion[1] = 'A' then
    result := cOsWin98SE
    else
    result := cOsWin98;
    end
    else if (majorVer = 4) AND (minorVer = 90) then
    result := cOsWinME
    else
    result := cOsUnknown;
    end;
  else
  result := cOsUnknown;
  end;
  end
  else
  result := cOsUnknown;
end;

procedure CreateShortcut(SourceFileName: string; Location: ShortcutType; SubDirectory : string);
var
  MyObject : IUnknown;
  MySLink : IShellLink;
  MyPFile : IPersistFile;
  Directory, LinkName : string;
  WFileName : WideString;
  MyReg, QuickLaunchReg : TRegIniFile;


begin
  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink := MyObject as IShellLink;
  MyPFile := MyObject as IPersistFile; 
  MySLink.SetPath(PChar(SourceFileName)); 
  MyReg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer'); 
  try 
    LinkName := ChangeFileExt(SourceFileName, '.lnk'); 
    LinkName := ExtractFileName(LinkName); 
    case Location of 
    _DESKTOP : Directory := MyReg.ReadString('Shell Folders', 'Desktop', ''); 
    _STARTMENU : Directory := MyReg.ReadString('Shell Folders', 'Start Menu', ''); 
    _SENDTO : Directory := MyReg.ReadString('Shell Folders', 'SendTo', ''); 
    _QUICKLAUNCH: 
    begin 
     QuickLaunchReg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\GrpConv');
     try 
      Directory := QuickLaunchReg.ReadString('MapGroups', 'Quick Launch', ''); 
      finally 
      QuickLaunchReg.Free; 
      end; 
   end;
  end;
   if Directory <> '' then
   begin
   if SubDirectory <> '' then
    WFileName := Directory + '\'+ SubDirectory +'\' + LinkName
    else
    WFileName := Directory + '\' + LinkName;
    MyPFile.Save(PWChar(WFileName), False);
   end;
   finally
   MyReg.Free;
  end;
end;

Function FileExistDialog(var NomRep:string;NomFichier: String;OuvrirDialog:Boolean):Boolean;
Begin
result:=false;
if not FileExists(IncludeTrailingPathDelimiter(NomRep)+NomFichier) then
 begin
  Showmessage(IncludeTrailingPathDelimiter(NomRep)+NomFiChier + ' est introuvable !');
  result:=BrowseDirectory(NomRep,'Veuillez indiquer un répertoire correct.',0);
  while (result and (not FileExists(IncludeTrailingPathDelimiter(NomRep)+NomFichier))) do
   begin
      Showmessage(IncludeTrailingPathDelimiter(NomRep)+NomFiChier + ' est introuvable !');
      result:=BrowseDirectory(NomRep,'Veuillez indiquer le répertoire contenant le fichier : '+NomFichier,0);
   end;
 end
 else
 begin
  result:=true;
 end;
End;

Function ChercheFileDialog(var NomRep,NomFichier: String;TexteFiltre: String;OuvrirDialog:Boolean;Titre:String):Boolean;
var
OpenDial:TOpenDialog;
Begin
result:=false;
if not FileExists(NomRep+NomFichier) then
 begin
  try
    OpenDial:=TOpenDialog.Create(Application);
    OpenDial.InitialDir := NomRep;
    OpenDial.Filter := TexteFiltre;
    if not Str_Empty(Titre) then
           OpenDial.Title := Titre;
    result:=OpenDial.Execute;
  //  Showmessage(NomRep+'\'+NomFiChier + ' est introuvable !');
  //  result:=BrowseDirectory(NomRep,'Veuillez indiquer un répertoire correct.',0);
    NomFichier:=OpenDial.FileName;
    while (result and (not FileExists(NomFichier))) do
     begin
  //      Showmessage(NomRep+'\'+NomFiChier + ' est introuvable !');
        result:=OpenDial.Execute;
        NomFichier:=OpenDial.FileName;
  //      result:=BrowseDirectory(NomRep,'Veuillez indiquer le répertoire contenant le fichier : '+NomFichier,0);
     end;
  Finally
   if Result then
    begin
     NomFichier := ExtractFileName(OpenDial.FileName);
     NomRep := IncludeTrailingPathDelimiter(ExtractFileDir(OpenDial.FileName));
    end;
  end;
 end
 else
 begin
  result:=true;
 end;
OpenDial.Free;
End;

Function CreerDossierDateJour(Chemin,Prefixe:String):String;
Var
DateStr:string;
Begin
result:='c:\';
DateStr:=str_remplacesouschaine(DateInfos(date).DateStr,DateSeparator,'-');
Chemin :=IncludeTrailingPathDelimiter(Chemin);
if not DirExists(Chemin+Prefixe+DateStr) then
 begin
   if not CreateDir(Chemin+Prefixe+DateStr) then
      Raise exception.CreateFmt('Erreur lors de la tentative de création d''un dossier Date',[''])
      else
      result:=Chemin+Prefixe+DateStr+'\';
 end
 else
 Begin
   result:=Chemin+Prefixe+DateStr+'\';
 End;

End;


Function RepertoireWindows(TypeRepertoire : Integer):String;
var
  pidl: PItemIDList;
  Path: array[0..MAX_PATH] of char;
begin
  //replace CSIDL_HISTORY with the constants above
  SHGetSpecialFolderLocation(application.Handle, CSIDL_DESKTOP, pidl);
  SHGetPathFromIDList(pidl,path);
  result:=path;
  if Str_Empty(path) then
  ShowMessage('Répertoire windows inconnu ! ('+IntTosTr(TypeRepertoire)+')');
end;

procedure SearchInFolder(Folder : string);
begin
  with TDDEClientConv.Create(Application.MainForm) do
  begin
    ConnectMode := ddeManual;
    ServiceApplication := 'Explorer.exe';
    SetLink('Folders', 'AppProperties');
    OpenLink;
    ExecuteMacro(PChar('[FindFolder(, '+ Folder+')]'), False);
    CloseLink;
    Free;
  end;
end;

Function ChangeExtensionFichier(NomFichier,NewExtension:String):String;
Begin
 result:=str_remplacesouschaine(NomFichier,str_n_der_char(NomFichier,4),'.'+NewExtension);
End;

// Retourne le pere d'un Repertoire
Function RepertoirePere(Directory:String):String;
//Var
//i:integer;
Begin
result:=Directory;
if str_fini_par(result,'\') then
   Result:=str_Suppr_N_Car_ADroite(result,1);
   
 While not str_fini_par(result,'\') do
  begin
   Result:=str_Suppr_N_Car_ADroite(result,1);
   if length(Result) = 0 then exit;
  end;

if str_fini_par(result,'\') then
   Result:=str_Suppr_N_Car_ADroite(result,1);
End;

Function DeleteListFile(ListeFichier:TStringList):Boolean;
var
i:integer;
Begin
if ListeFichier<>nil then
//ProtectObjetNil([ListeFichier]);
for i:=0 to ListeFichier.count-1 do
 begin
   DeleteFile(PChar(ListeFichier.Strings[i]));
 end;
End;

Function ChoisirRepertoire(ParamChoixRep:TParamChoixRep):TResultChoisirRep;
var
ParamLibChoixRepAffiche:TParamLibChoixRepAffiche;
ResultChoixRep:TResultChoixRep;
Begin
ParamLibChoixRepAffiche.AfficheRepDefDansEdit := ParamChoixRep.AfficheRepDefDansEdit;
ParamLibChoixRepAffiche.RepDefaut := ParamChoixRep.RepDefaut;
ParamLibChoixRepAffiche.TitreForm := ParamChoixRep.TitreForm;
ParamLibChoixRepAffiche.TitreDialogRep := ParamChoixRep.TitreDialogRep;
ResultChoixRep:=LibChoixRepAffiche(ParamLibChoixRepAffiche);
Result.Retour :=ResultChoixRep.Retour;
Result.RepChoisi := ResultChoixRep.RepChoisi;
//if ResultChoixRep.Retour then
// begin
//  result.RepChoisi :=ResultChoixRep.RepChoisi;
//  result.Retour := ResultChoixRep.Retour;
// end;
End;

procedure PropertiesDialog(filename:String);
var
 sei: TShellExecuteInfo;

begin
 FillChar(sei, SizeOf(sei), 0);
 sei.cbSize := SizeOf(sei);
 sei.lpFile := PChar(filename);
 sei.lpVerb := 'properties';
 sei.fMask := SEE_MASK_INVOKEIDLIST;

ShellExecuteEx(@sei);
end;

Function NumSerieDD(NomDisque:string):Integer;
var
  SerialNum : pdword; a, b : dword;
  Buffer : array [0..255] of char;
begin
 try
  result:=0;
  if GetVolumeInformation(PChar(Lowercase(NomDisque)), Buffer, SizeOf(Buffer), SerialNum, a, b, nil,0) then
    Result := SerialNum^;
 except
  result:=0;
 end;
end;

//37. Activer/désactiver/cacher/montrer la barre des tâches

Procedure GereBarreDesTaches(Action : Integer);
var
  HTaskbar : HWND;
begin
HTaskBar:=FindWindow('Shell_TrayWnd',nil);
case Action of
  C_BarreDTAcheAffiche:  ShowWindow(HTaskbar,SW_SHOW); //Show the taskbar
  C_BarreDTAcheCache:  ShowWindow(HTaskbar,SW_HIDE); //Hide the taskbar
  C_BarreDTAcheEnable:  EnableWindow(HTaskBar,True); //Enable the taskbar
  C_BarreDTAcheDisable:  EnableWindow(HTaskBar,False); //Disable the taskbar
else ;
end;









end;


function TypeRepertoirePath(CSIDL_Type:integer): string;
var
  P: PChar;
begin
  { par exemple
    si CSIDL_Type=CSIDL_PERSONAL = Mes Documents
    alors, renvoie l'emplacement de 'Mes Documents' s'il existe, sinon renvoie
    le répertoire en cours.  }
  P := nil;
  try
    P := AllocMem(MAX_PATH);
    if SHGetFolderPath(0, CSIDL_Type, 0, 0, P) = S_OK then
      Result := P
    else
      Result := '';
  finally
    FreeMem(P);
  end;
end;


Function RecupListeRepertoireWindows:Tstringlist;
//var
//i:integer;
//ListeEdit:Tstringlist;
begin
Result:=TStringList.Create;
//ListeEdit:=TStringList.Create;

Result.Add('CSIDL_WINDOWS ;'+inttostr(  CSIDL_WINDOWS));
Result.Add('CSIDL_SYSTEM ;'+inttostr(  CSIDL_SYSTEM));
Result.Add('CSIDL_PROGRAM_FILES ;'+inttostr(  CSIDL_PROGRAM_FILES));
Result.Add('CSIDL_MYPICTURES ;'+inttostr(  CSIDL_MYPICTURES));
Result.Add('CSIDL_PROGRAM_FILES_COMMON ;'+inttostr(  CSIDL_PROGRAM_FILES_COMMON));
Result.Add('CSIDL_COMMON_DOCUMENTS ;'+inttostr(  CSIDL_COMMON_DOCUMENTS));
Result.Add('CSIDL_DESKTOP ;'+inttostr(  CSIDL_DESKTOP));
Result.Add('CSIDL_INTERNET ;'+inttostr(  CSIDL_INTERNET));
Result.Add('CSIDL_PROGRAMS ;'+inttostr(  CSIDL_PROGRAMS));
Result.Add('CSIDL_CONTROLS ;'+inttostr(  CSIDL_CONTROLS));
Result.Add('CSIDL_PRINTERS ;'+inttostr(  CSIDL_PRINTERS));
Result.Add('CSIDL_PERSONAL ;'+inttostr(  CSIDL_PERSONAL));
Result.Add('CSIDL_FAVORITES ;'+inttostr(  CSIDL_FAVORITES));
Result.Add('CSIDL_STARTUP ;'+inttostr(  CSIDL_STARTUP));
Result.Add('CSIDL_RECENT ;'+inttostr(  CSIDL_RECENT));
Result.Add('CSIDL_SENDTO ;'+inttostr(  CSIDL_SENDTO));
Result.Add('CSIDL_STARTMENU ;'+inttostr(  CSIDL_STARTMENU));
Result.Add('CSIDL_NETWORK ;'+inttostr(  CSIDL_NETWORK));
Result.Add('CSIDL_NETHOOD ;'+inttostr(  CSIDL_NETHOOD));
Result.Add('CSIDL_FONTS ;'+inttostr(  CSIDL_FONTS));
Result.Add('CSIDL_COMMON_STARTMENU ;'+inttostr(  CSIDL_COMMON_STARTMENU));
Result.Add('CSIDL_COMMON_PROGRAMS ;'+inttostr(  CSIDL_COMMON_PROGRAMS));
Result.Add('CSIDL_COMMON_STARTUP ;'+inttostr(  CSIDL_COMMON_STARTUP));
Result.Add('CSIDL_COMMON_DESKTOPDIRECTORY ;'+inttostr(  CSIDL_COMMON_DESKTOPDIRECTORY));
Result.Add('CSIDL_APPDATA ;'+inttostr(  CSIDL_APPDATA));
Result.Add('CSIDL_PRINTHOOD ;'+inttostr(  CSIDL_PRINTHOOD));
Result.Add('CSIDL_ALTSTARTUP ;'+inttostr(  CSIDL_ALTSTARTUP));
Result.Add('CSIDL_COMMON_ALTSTARTUP ;'+inttostr(  CSIDL_COMMON_ALTSTARTUP));
Result.Add('CSIDL_COMMON_FAVORITES ;'+inttostr(  CSIDL_COMMON_FAVORITES));
Result.Add('CSIDL_INTERNET_CACHE ;'+inttostr(  CSIDL_INTERNET_CACHE));
Result.Add('CSIDL_COOKIES ;'+inttostr(  CSIDL_COOKIES));
Result.Add('CSIDL_HISTORY ;'+inttostr(  CSIDL_HISTORY));
//for i:=0 to result.Count-1 do
//  listeEdit.Add(result.Strings[i]+';'+TypeRepertoirePath(strtoint_lgr(str_getstringelement(result.strings[i],2,';'))));
//listeedit.SaveToFile('C:\ListeRepertoiresWindows.txt');
//Initialise_TStringlist(ListeEdit);
end;

//function RunAsAdmin(hWnd : HWND; aFile : String; aParameters : String;Directory:string ; ShowCmd:integer):boolean;
//Var
// Sei : TShellExecuteInfoA;
//begin
// Fillchar(sei,SizeOf(sei),0);
// sei.cbSize := SizeOf(sei);
// sei.Wnd    := hWnd;
// sei.fMask  := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
// sei.lpfile := PChar(aFile);
// sei.lpVerb := 'runas';
// sei.lpParameters := PChar(aParameters);
// sei.nShow := SW_SHOWNORMAL;
// if not ShellExecuteEx(@sei) then
//  RaiseLastOSError;
//end;


//function RunAsAdmin(const Path, Params: string): Boolean;
//var
//  sei: TShellExecuteInfo;
//begin
//  FillChar(sei, SizeOf(sei), 0);
//  sei.cbSize := SizeOf(sei);
//  sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
//  sei.lpVerb := PChar('runas');
//  sei.lpFile := PChar(ExtractFileName(Path));
//  sei.lpDirectory := PChar(ExtractFilePath(Path));
//  sei.lpParameters := PChar(Params);
//  sei.nShow := SW_SHOWNORMAL;
//  Result := ShellExecuteEx(@sei);
//end;


//// choisir et lancer un executable en mode administrateur
//if OpenDialog1.Execute then
// RunAsAdmin(self.Handle,OpenDialog1.FileName,'');


end.



