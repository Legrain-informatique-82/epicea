//WinTypes=Windows;WinProcs=Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE;
unit LibFichRep;

interface

Uses
SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
Controls, Dialogs,shellapi,Forms, ShlObj,ComObj,ActiveX,
  registry
  //,  QFileCtrls{,FileUtil,LibDates,Lib_Chaine,Gr_Librairie_Obj}
  ;

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

type
ShortcutType = (_DESKTOP, _QUICKLAUNCH, _SENDTO, _STARTMENU);

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
Function ListeFic(Masque,Rep:string;Attribut:integer;Chemin,Lecteur:boolean):TStringList;


{Connaître les répertoires des dossiers de Windows

  Constantes utilisé pour connaitre l'emplacement des répertoires Windows

  CSIDL_DESKTOP
  CSIDL_INTERNET 
  CSIDL_PROGRAMS 
  CSIDL_CONTROLS
  CSIDL_PRINTERS 
  CSIDL_PERSONAL
  CSIDL_FAVORITES 
  CSIDL_STARTUP
  CSIDL_RECENT 
  CSIDL_SENDTO 
  CSIDL_BITBUCKET 
  CSIDL_STARTMENU 
  CSIDL_DESKTOPDIRECTORY 
  CSIDL_DRIVES 
  CSIDL_NETWORK 
  CSIDL_NETHOOD
  CSIDL_FONTS 
  CSIDL_TEMPLATES 
  CSIDL_COMMON_STARTMENU    CSIDL_COMMON_PROGRAMS 
  CSIDL_COMMON_STARTUP 
  CSIDL_COMMON_DESKTOPDIRECTORY 
  CSIDL_APPDATA 
  CSIDL_PRINTHOOD 
  CSIDL_ALTSTARTUP 
  CSIDL_COMMON_ALTSTARTUP
  CSIDL_COMMON_FAVORITES
  CSIDL_INTERNET_CACHE
  CSIDL_COOKIES
  CSIDL_HISTORY
}
//Function RepertoireWindows(TypeRepertoire : Integer):String;


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
Function ListeFic(Masque,Rep:string;Attribut:integer;Chemin,Lecteur:boolean):TStringList;
var
F:TSearchRec;
Repertoire,lect:string;
ListAux:TStringList;
begin
// if ListAux=nil then
 ListAux:=TStringList.Create;
 if ListAux.count>0 then  ListAux.Clear;
 ListAux.Sort;
Repertoire:=copy(Rep,4,length(Rep));
Lect:=copy(Rep,1,3);
 if FindFirst(Rep+Masque,Attribut,F) =0 then
 Begin
   if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
   if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
   if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
   if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
 End;

 while FindNext(F)=0 do
       Begin
        if ((chemin=false) and (lecteur=false)) then  ListAux.Add(F.Name);
        if ((chemin=true) and (lecteur=false)) then  ListAux.Add(Repertoire+F.Name);
        if ((chemin=false) and (lecteur=true)) then  ListAux.Add(Lect+Repertoire+F.Name);
        if ((chemin=true) and (lecteur=true)) then  ListAux.Add(Rep+F.Name);
       End;
 FindClose(F.FindHandle);
result:=ListAux;
end;


end.



