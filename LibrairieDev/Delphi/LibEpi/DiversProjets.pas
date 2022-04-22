unit DiversProjets;

interface
uses
   Windows, Messages, SysUtils, Classes, Graphics,
    dialogs,
    Variants,
    LbCipher,
    LbString,
    FileUtil,DBTables,
    Controls;

Const

fileLocked:string ='locked.tmp';

C_ExtensionFEC = '.csv';
C_SeparateurFEC = '|';
C_DatePieceFEC = false;

C_ComptePointableCaisseEnregistreuse = '411';
C_TauxTvaCaisseEnregistreuse = '19.6';
RetourChariotDouble = #10#13#10#13;
RetourChariotSimple = #10#13;
 C_ParamFTP = 'ParamFTP.txt';
connexionInvalide = '- Vos paramètres de connexion ne sont pas valides (login ou mot de passe)'+
                     retourchariotsimple+'Vous pouvez les renseigner dans le menu "outils/propriété" d''Epicéa.'+
                     retourchariotDouble+'- Ou vous n''êtes pas connecté à internet.';

Type

  TTypeDossier = (VerDiocese,VerAgricole,VerGeneral,
                  VerDiocAdmin,
                  VerDemoAgri,VerDemoDioc,VerDemoGeneral,
                  VerInconnu,
                  VerAgriClot,VerGeneClot,VerDiocClot);

  TTypeClient= (CL_Inconnu,CL_Cogere,CL_Normal,CL_Isa,CL_Association,CL_Education
  //,CL_Demo,CL_Saisie_Normal,CL_Saisie_Demo,CL_Saisie_Cogere,CL_Normal_2,CL_Normal_3     //23/09/2010
  );

  TTypeUtilisateur=(U_Inconnu,U_Normal,U_Demo,U_Comptable,U_SuperComptable,U_LibreService,U_legrain);
  TTypeVersion=(V_Inconnu,N1,N2,N3,N4);  //

TParamFTP= record
  Source:string;
  Dest:string;
  Fichier:string;
  Serveur:string;
  Login :string;
  PassWord :string;
  Effacer : string;
  Auto : string;
  Prevenir:string[1];
end;

  TDistribution=record
     TypeVersion:TTypeVersion;
     TypeClient:TTypeClient;
     TypeDossier:TTypeDossier;
     TypeUtilisateur:TTypeUtilisateur;
  end;

  TVersionEpi=record
     Version:String;
     Date:String;
  end;


Function GetUserFromWindows(): string;
function creationDirectory(repertoire : string):integer;
Function LitFichierParamFTP(FileName:string;Var ParamFTP:TParamFTP;AfficheMessage:boolean;
         nomDossier,ServeurFTP:String;ParamFTP_Entreprise:TParamFTP;RepertoireDossier:string):boolean;overload;
function LitFichierParamFTP(FileName:string;Var ParamFTP:TParamFTP;AfficheMessage:boolean):boolean;overload;
procedure EcritFichierParamFTP(ParamFTP,ParamFTP_Entreprise:TParamFTP);
procedure InitParamFTP(Var ParamFTP:TParamFTP;nomDossier,ServeurFTP:String);
Procedure AjouterFichierTexte(NomFichier,Texte:String);

procedure Initialise_TDistribution(var TypeDistribution:TDistribution);
procedure Initialise_TVersionEpi(var VersionEpi:TVersionEpi);


   Function TypeDossierToInt(TypeDossier:TTypeDossier):Integer;
   Function TypeDossierToStr(TypeDossier:TTypeDossier):string;
   Function IntToTypeDossier(Rang:Integer):TTypeDossier;
   Function TypeClientToInt(TypeClient:TTypeClient):Integer;
   Function TypeClientToStr(TypeClient:TTypeClient):string;
   Function TypeClientToStrLibelle(TypeClient:TTypeClient):string;
   Function IntToTypeClient(Rang:Integer):TTypeClient;
   Function StrToTypeClient(ClientStr:string):TTypeClient;
   Function TypeUtilisateurToInt(TypeUtilisateur:TTypeUtilisateur):Integer;
Function TypeUtilisateurToLibelle(TypeUtilisateur:TTypeUtilisateur):string;
  Function TypeUtilisateurToStr(TypeUtilisateur:TTypeUtilisateur):string;
  Function IntToTypeUtilisateur(Rang:Integer):TTypeUtilisateur;
  Function StrToTypeUtilisateur(UtilisateurStr:string):TTypeUtilisateur;

  Function TypeVersionToInt(TypeVersion:TTypeVersion):Integer;
Function TypeVersionToLibelle(TypeVersion:TTypeVersion):string;
  Function TypeVersionToStr(TypeVersion:TTypeVersion):string;
  Function IntToTypeVersion(Rang:Integer):TTypeVersion;
  Function StrToTypeVersion(VersionStr:string):TTypeVersion;
  function verifDistribution(cheminFichier:string):TDistribution;
  procedure Decrypt(var valeur,numero:string);
  Function ListTypeLecteur(TypeLecteur:integer):TStringList;
  procedure DisqueDur(Disque : String ; Var NomVolume, NumSerie : String) ;
  procedure InitListeType(var DistributionCourante:Tdistribution);


  Var
   Key128           : TKey128;
   TypeDistribution:TDistribution;
   getUser:string;

implementation


//uses     FileCtrl;

//uses  LibFichRep;


procedure InitParamFTP(Var ParamFTP:TParamFTP;nomDossier,ServeurFTP:String);
begin
  ParamFTP.Source:='';
  ParamFTP.Dest:='/sauvegarde_epicea/'+NomDossier;
  ParamFTP.Serveur:=ServeurFTP;
  ParamFTP.Login:='';
  ParamFTP.PassWord:='';
  ParamFTP.Effacer:='o';
  ParamFTP.Auto:='a';
  ParamFTP.Prevenir:='0';
end;

procedure EcritFichierParamFTP(ParamFTP,ParamFTP_Entreprise:TParamFTP);
var
text:TextFile;
begin
  try //finally
      try//except
        if (ParamFTP.Fichier=EmptyStr) then ParamFTP.Fichier:=ParamFTP_Entreprise.Fichier;
        if not FileExists(ParamFTP.Fichier)then
          begin
             AjouterFichierTexte(ParamFTP.Fichier,'');
             if not FileExists(ParamFTP.Fichier)then SysUtils.Abort;;
          end;
        AssignFile(text,ParamFTP.Fichier);
        Rewrite(text);
        Writeln(text,ParamFTP.Source);
        Writeln(text,ParamFTP.Dest);
        Writeln(text,ParamFTP.Login);
        Writeln(text,ParamFTP.PassWord);
        Writeln(text,ParamFTP.Serveur);
        Writeln(text,ParamFTP.Effacer);
        Writeln(text,ParamFTP.Auto);
        if (ParamFTP.prevenir=EmptyStr)then ParamFTP.prevenir:='0';
        if not(ord(ParamFTP.prevenir[1]) in [49,50])then ParamFTP.prevenir:='0';
        Writeln(text,ParamFTP.prevenir);
      except
        showmessage('Le fichier '+ParamFTP.Fichier+' n''existe pas');
      end;
  finally
    CloseFile(text);
  end;
end;

function LitFichierParamFTP(FileName:string;Var ParamFTP:TParamFTP;AfficheMessage:boolean):boolean;
begin
    LitFichierParamFTP(FileName,ParamFTP,AfficheMessage,'','monftp-1.net',ParamFTP,'');
end;

Function LitFichierParamFTP(FileName:string;Var ParamFTP:TParamFTP;AfficheMessage:boolean;
         nomDossier,ServeurFTP:String;ParamFTP_Entreprise:TParamFTP;RepertoireDossier:string):boolean;
var
text:TextFile;
Begin
  try //finally
      try//except
        result:=true;
        InitParamFTP(ParamFTP,nomDossier,ServeurFTP);
        if (filename=EmptyStr)then filename:=ParamFTP_Entreprise.Fichier;
        if not FileExists(FileName)then
          begin
             ParamFTP_Entreprise.Fichier := RepertoireDossier + C_ParamFTP;
             FileName:=ParamFTP_Entreprise.Fichier;
             if not FileExists(FileName)then
               begin
                 AjouterFichierTexte(filename,'');
                 if not FileExists(FileName)then SysUtils.Abort;
                 EcritFichierParamFTP(ParamFTP,ParamFTP_Entreprise);
               end;
          end;

        AssignFile(text,filename);
        Reset(text);
        Readln(text,ParamFTP.Source);
        Readln(text,ParamFTP.Dest);
        Readln(text,ParamFTP.Login);
        Readln(text,ParamFTP.PassWord);
        Readln(text,ParamFTP.Serveur);
        Readln(text,ParamFTP.Effacer);
        Readln(text,ParamFTP.Auto);
        Readln(text,ParamFTP.prevenir);
        //if(ParamFTP.Dest='/')then ParamFTP.Dest:='sauvegarde_epicea/'+nomDossier;
        result:=not ((ParamFTP.Login=EmptyStr) or (ParamFTP.Serveur=EmptyStr) or (ParamFTP.PassWord=EmptyStr));
        if (not result and AfficheMessage) then
          //MessageBox(PansiChar(connexionInvalide),Parent,pAnsiChar('Adresse FTP invalide'),MB_ICONWARNING);
          showmessage(connexionInvalide);
      except
        showmessage('Le fichier '+FileName+' n''existe pas');
      end;
  finally
    CloseFile(text);
  end;
end;

Procedure AjouterFichierTexte(NomFichier,Texte:String);
var F: TextFile;
message_:string;
begin
try
message_:='Erreur lors de la modification du fichier : '+NomFichier;
    if NomFichier='' then
    begin
      message_:='Le fichier '+NomFichier+' n''existe pas';
      abort;
    end;
    //NomFichier:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'error.txt';
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
 Showmessage(message_);
 abort;
end;
//    Flush(F);
End;

procedure Initialise_TDistribution(var TypeDistribution:TDistribution);
begin
     TypeDistribution.TypeVersion:=V_Inconnu;
     TypeDistribution.TypeClient:=CL_Inconnu;
     TypeDistribution.TypeDossier:=VerInconnu;
     TypeDistribution.TypeUtilisateur:=U_Inconnu;
end;

procedure Initialise_TVersionEpi(var VersionEpi:TVersionEpi);
begin
     VersionEpi.Version:='';
     VersionEpi.Date:='';
end;

Function TypeDossierToInt(TypeDossier:TTypeDossier):Integer;
Begin
result:=ord(TypeDossier);
End;

Function TypeDossierToStr(TypeDossier:TTypeDossier):string;
Begin
result:='VerDemoAgri';
case TypeDossierToInt(TypeDossier) of
  0:result:='VerDiocese';
  1:result:='VerAgricole';
  2:result:='VerGeneral';
  3:result:='VerDiocAdmin';
  4:result:='VerDemoAgri';
  5:result:='VerDemoDioc';
  6:result:='VerDemoGeneral';
  7:result:='VerInconnu';
  8:result:='VerAgriClot';
  9:result:='VerGeneClot';
  10:result:='VerDiocClot';
else showMessage('Une erreur est survenu lors de la récupération du type du dossier');
end;
End;

Function IntToTypeDossier(Rang:Integer):TTypeDossier;
Begin
result:=VerDemoAgri;
case Rang of
  0:result:=VerDiocese;
  1:result:=VerAgricole;
  2:result:=VerGeneral;
  3:result:=VerDiocAdmin;
  4:result:=VerDemoAgri;
  5:result:=VerDemoDioc;
  6:result:=VerDemoGeneral;
  7:result:=VerInconnu;
  8:result:=VerAgriClot;
  9:result:=VerGeneClot;
  10:result:=VerDiocClot;
else showMessage('Une erreur est survenu lors de la récupération du type du dossier');
end;
End;

Function TypeClientToInt(TypeClient:TTypeClient):Integer;
Begin
result:=ord(TypeClient);
End;

Function TypeClientToStr(TypeClient:TTypeClient):string;
Begin
result:='CL_Inconnu';
case TypeClient of
  CL_Inconnu:result:='CL_Inconnu';
  CL_Cogere:result:='CL_Cogere';
  CL_Normal:result:='CL_Normal';
  CL_Isa:result:='CL_Isa';
  CL_Association:result:='CL_Association';
  CL_Education:result:='CL_Education'
else showMessage('Une erreur est survenu lors de la récupération du type de client');
end;
end;

Function TypeClientToStrLibelle(TypeClient:TTypeClient):string;
Begin
result:='?';
case TypeClient of
  CL_Inconnu:result:='?';
  CL_Cogere:result:='COGERE';
  CL_Normal:result:='GENERALE';
  CL_Isa:result:='ISA';
  CL_Association:result:='ASSOCIATION';
  CL_Education:result:='EDUCATION'
else showMessage('Une erreur est survenu lors de la récupération du type de client');
end;
End;

Function IntToTypeClient(Rang:Integer):TTypeClient;
Begin
result:=CL_Inconnu;
case Rang of
  0:result:=CL_Inconnu;
  1:result:=CL_Cogere;
  2:result:=CL_Normal;
  3:result:=CL_Isa ;
  4:result:=CL_Association;
  5:result:=CL_Education
//  ;
//  4:result:=CL_Demo;
//  5:result:=CL_Saisie_Normal;
//  6:result:=CL_Saisie_Demo;
//  7:result:=CL_Saisie_Cogere;
//  8:result:=CL_Normal_2;
//  9:result:=CL_Normal_3
else showMessage('Une erreur est survenu lors de la récupération du type de client');
end;
End;


Function StrToTypeClient(ClientStr:string):TTypeClient;
Begin
result:=CL_Inconnu;
if uppercase(ClientStr) ='CL_INCONNU' then result:=CL_Inconnu;     //23/09/2010
if uppercase(ClientStr) ='CL_COGERE' then result:=CL_Cogere;
if uppercase(ClientStr) ='CL_NORMAL' then result:=CL_Normal;
if uppercase(ClientStr) ='CL_ISA' then result:=CL_Isa;
if uppercase(ClientStr) ='CL_ASSOCIATION' then result:=CL_Association;
if uppercase(ClientStr) ='CL_EDUCATION' then result:=CL_Education;
//if uppercase(ClientStr) ='CL_DEMO' then result:=CL_Demo;
//if uppercase(ClientStr) ='CL_SAISIE_NORMAL' then result:=CL_Saisie_Normal;
//if uppercase(ClientStr) ='CL_SAISIE_DEMO' then result:=CL_Saisie_Demo;
//if uppercase(ClientStr) ='CL_SAISIE_COGERE' then result:=CL_Saisie_Cogere;
//if uppercase(ClientStr) ='CL_NORMAL_2' then result:=CL_Normal_2;
//if uppercase(ClientStr) ='CL_NORMAL_3' then result:=CL_Normal_3;
if result=CL_Inconnu then
 showMessage('Une erreur est survenu lors de la récupération du type de client');
End;


//gestion des types Utilisateurs////////////////
////////////////////////////
Function TypeUtilisateurToInt(TypeUtilisateur:TTypeUtilisateur):Integer;
Begin
result:=ord(TypeUtilisateur);
End;

Function TypeUtilisateurToLibelle(TypeUtilisateur:TTypeUtilisateur):string;
Begin
result:='?';
case TypeUtilisateurToInt(TypeUtilisateur) of
  0:result:='?';
  1:result:='GENERAL';
  2:result:='DEMO';
  3:result:='COMPTABLE';
  4:result:='EXPER COMPTABLE';
  5:result:='LIBRE SERVICE';
  6:result:='LEGRAIN';
else showMessage('Une erreur est survenu lors de la récupération du type de Utilisateur');
end;
End;
Function TypeUtilisateurToStr(TypeUtilisateur:TTypeUtilisateur):string;
Begin
result:='U_Inconnu';
case TypeUtilisateurToInt(TypeUtilisateur) of
  0:result:='U_Inconnu';
  1:result:='U_Normal';
  2:result:='U_Demo';
  3:result:='U_Comptable';
  4:result:='U_SuperComptable';
  5:result:='U_LibreService';
  6:result:='U_legrain';
else showMessage('Une erreur est survenu lors de la récupération du type de Utilisateur');
end;
End;

Function IntToTypeUtilisateur(Rang:Integer):TTypeUtilisateur;
Begin
result:=U_Inconnu;
case Rang of
  0:result:=U_Inconnu;
  1:result:=U_Normal;
  2:result:=U_Demo;
  3:result:=U_Comptable;
  4:result:=U_SuperComptable ;
  5:result:=U_LibreService;
  6:result:=U_legrain
else showMessage('Une erreur est survenu lors de la récupération du type de Utilisateur');
if (result=U_Inconnu) then  showMessage('Une erreur est survenu lors de la récupération du type de Utilisateur');
end;
End;


Function StrToTypeUtilisateur(UtilisateurStr:string):TTypeUtilisateur;
Begin
result:=U_Inconnu;
if uppercase(UtilisateurStr) ='U_INCONNU' then result:=U_Inconnu;
if uppercase(UtilisateurStr) ='U_NORMAL' then result:=U_Normal;
if uppercase(UtilisateurStr) ='U_DEMO' then result:=U_Demo;
if uppercase(UtilisateurStr) ='U_COMPTABLE' then result:=U_Comptable;
if uppercase(UtilisateurStr) ='U_SUPERCOMPTABLE' then result:=U_SuperComptable;
if uppercase(UtilisateurStr) ='U_LIBRESERVICE' then result:=U_LibreService;
if uppercase(UtilisateurStr) ='U_LEGRAIN' then result:=U_legrain;
if result=U_Inconnu then
 showMessage('Une erreur est survenu lors de la récupération du type de Utilisateur');
End;


//gestion des types Distributions////////////////
////////////////////////////
Function TypeVersionToInt(TypeVersion:TTypeVersion):Integer;
Begin
result:=ord(TypeVersion);
End;

Function TypeVersionToStr(TypeVersion:TTypeVersion):string;
Begin
result:='V_Inconnu';
case TypeVersionToInt(TypeVersion) of
  0:result:='V_Inconnu';
  1:result:='N1';
  2:result:='N2';
  3:result:='N3';
  4:result:='N4';
else showMessage('Une erreur est survenu lors de la récupération du type de Version');
end;
End;
Function TypeVersionToLibelle(TypeVersion:TTypeVersion):string;
Begin
result:='V_Inconnu';
case TypeVersionToInt(TypeVersion) of
  0:result:='?';
  1:result:='1';
  2:result:='2';
  3:result:='3';
  4:result:='4';
else showMessage('Une erreur est survenu lors de la récupération du type de Version');
end;
End;

Function IntToTypeVersion(Rang:Integer):TTypeVersion;
Begin
result:=V_Inconnu;
case Rang of
  0:result:=V_Inconnu;
  1:result:=N1;
  2:result:=N2;
  3:result:=N3;
  4:result:=N4;
  //5:result:=ASSO;
else showMessage('Une erreur est survenu lors de la récupération du type de Version');
end;
End;


Function StrToTypeVersion(VersionStr:string):TTypeVersion;
Begin
result:=V_Inconnu;
if uppercase(VersionStr) ='V_INCONNU' then result:=V_Inconnu;
if uppercase(VersionStr) ='N1' then result:=N1;
if uppercase(VersionStr) ='N2' then result:=N2;
if uppercase(VersionStr) ='N3' then result:=N3;
if uppercase(VersionStr) ='N4' then result:=N4;
//if uppercase(VersionStr) ='ASSO' then result:=ASSO;
if result=V_Inconnu then
  BEGIN
    showMessage('Une erreur est survenu lors de la récupération du type de Version');
  END
End;


procedure Decrypt(var valeur,numero:string);
var
 CipherText:string;
begin
  GenerateLMDKey(Key128, SizeOf(Key128), numero);
//   CipherText:=valeur;
  valeur:=BFEncryptStringEx(valeur, Key128, False);
end;


function verifDistribution(cheminFichier:string):TDistribution;
var
nomVolume,numero:string;
text:TextFile;
valeur:string;
listeRetour:TStringlist;
begin
//     IncludeTrailingPathDelimiter(ExtractFileDrive(application.ExeName))
Initialise_TDistribution(TypeDistribution);
DisqueDur(ListTypeLecteur(DRIVE_FIXED).Strings[0],nomVolume,numero);
result.TypeUtilisateur:=U_Demo;
result.TypeClient:=CL_Normal;
result.TypeVersion:=N4;
listeRetour:=Tstringlist.create;
if(fileexists(cheminFichier))then
    begin
        AssignFile(text,cheminFichier);
        Reset(text);
        Readln(text,valeur);
        CloseFile(text);
        Decrypt(valeur,numero);
        ExtractStrings([','],[' '],PansiChar(valeur),listeRetour);
        if(listeRetour.Count<3)then exit;

        result.TypeVersion:=StrToTypeVersion(listeRetour.strings[0]);
        result.TypeClient:=StrToTypeClient(listeRetour.strings[1]);
        if(result.TypeVersion=V_Inconnu)then result.TypeUtilisateur:=U_Demo
        else
        result.TypeUtilisateur:=StrToTypeUtilisateur(listeRetour.strings[2]);
    end;
//showMessage(e.TypeClientToStr(result));
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



procedure InitListeType(var DistributionCourante:Tdistribution);
var
listetypeClient,listetypeVersion,listeTypeUtilisateur:String;
Version,client,utilisateur:integer;
begin

  ListetypeClient:=TypeClientToStr(cl_inconnu)+' : '+inttostr(TypeClientToInt(cl_inconnu))+RetourChariotSimple+
              TypeClientToStr(CL_Cogere)+' : '+inttostr(TypeClientToInt(CL_Cogere))+RetourChariotSimple+
              TypeClientToStr(CL_Normal)+' : '+inttostr(TypeClientToInt(CL_Normal))+RetourChariotSimple+
              TypeClientToStr(CL_Isa)+' : '+inttostr(TypeClientToInt(CL_Isa))+RetourChariotSimple+
              TypeClientToStr(CL_Association)+' : '+inttostr(TypeClientToInt(CL_Association))+RetourChariotSimple+
              TypeClientToStr(CL_Education)+' : '+inttostr(TypeClientToInt(CL_Education));

  ListetypeVersion:=TypeVersionToStr(V_Inconnu)+' : '+inttostr(TypeVersionToInt(V_Inconnu))+RetourChariotSimple+
             TypeVersionToStr(N1)+' : '+inttostr(TypeVersionToInt(N1))+RetourChariotSimple+
               TypeVersionToStr(N2)+' : '+inttostr(TypeVersionToInt(N2))+RetourChariotSimple+
               TypeVersionToStr(N3)+' : '+inttostr(TypeVersionToInt(N3))+RetourChariotSimple+
               TypeVersionToStr(N4)+' : '+inttostr(TypeVersionToInt(N4))+RetourChariotSimple;
               //TypeVersionToStr(ASSO)+' : '+inttostr(TypeVersionToInt(ASSO))+RetourChariotSimple ;

  ListeTypeUtilisateur:=TypeUtilisateurToStr(U_Inconnu)+' : '+inttostr(TypeUtilisateurToInt(U_Inconnu))+RetourChariotSimple+
                   TypeUtilisateurToStr(U_Normal)+' : '+inttostr(TypeUtilisateurToInt(U_Normal))+RetourChariotSimple+
                   TypeUtilisateurToStr(U_Demo)+' : '+inttostr(TypeUtilisateurToInt(U_Demo))+RetourChariotSimple+
                   TypeUtilisateurToStr(U_Comptable)+' : '+inttostr(TypeUtilisateurToInt(U_Comptable))+RetourChariotSimple+
                   TypeUtilisateurToStr(U_SuperComptable)+' : '+inttostr(TypeUtilisateurToInt(U_SuperComptable))+RetourChariotSimple+
                   TypeUtilisateurToStr(U_LibreService)+' : '+inttostr(TypeUtilisateurToInt(U_LibreService))+RetourChariotSimple+
                   TypeUtilisateurToStr(U_legrain)+' : '+inttostr(TypeUtilisateurToInt(U_legrain));


            Version:= TypeVersionToInt(DistributionCourante.typeVersion);
            client:= TypeClientToInt(DistributionCourante.typeClient);
            utilisateur:=TypeUtilisateurToInt(DistributionCourante.TypeUtilisateur);


            DistributionCourante.typeVersion:= IntToTypeVersion(StrToIntDef(InputBox('Type de Version',ListetypeVersion,inttostr(Version)),0));
            DistributionCourante.typeClient:=IntToTypeClient(StrToIntDef(InputBox('Type de client',ListetypeClient,inttostr(client)),0));
            DistributionCourante.TypeUtilisateur:=IntToTypeUtilisateur(StrToIntDef(InputBox('Type d''utilisateur',ListeTypeUtilisateur,inttostr(utilisateur)),0));

end;

Function GetUserFromWindows(): string;
Var
   UserName : string;
   UserNameLen : Dword;
Begin
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   if(getUser<>'')then result:=getUser
   else
       begin
           If GetUserName(PChar(UserName), UserNameLen) Then
             Result := Copy(UserName,1,UserNameLen - 1)
           Else
             Result := 'Unknown';
       end;
     userName:=Result;
End;

function creationDirectory(repertoire : string):integer;
begin
result:=0;
  // Try to create a new subdirectory in the current directory
  // Switch off I/O error checking
  {$IOChecks off}
  ForceDirectories(repertoire);

  // Did the directory get created OK?
  result := IOResult;
  if result <> 0
  then ShowMessageFmt('Le répertoire '+repertoire+' n''a pas pu être créé. Erreur : %d',[error]);
end;


end.
