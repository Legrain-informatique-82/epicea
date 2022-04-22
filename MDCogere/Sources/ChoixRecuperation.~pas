unit ChoixRecuperation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus,ShellAPI,FileUtil, StdCtrls,lib_chaine, Buttons;

Const
RepDef = 'RepDef';
FichierInit = 'MDCOGERE.ini';
RepDest = 'RepDest';
CheminRepDest = 'C:\LGRDOSS\EPICEA';
ProgRestauration = 'RestaureLGR.exe';
ProgSauvegarde='SauvegardeLGR.exe';
RepertoireSauvegarde = 'Sauvegarde\';
ProgCompta = 'Epicea2.exe';
ServeurDefaut='monftp-1.net';
FichierParamftp='paramftp.txt';

type
  TInfoRestaure = Record
   NomDossier:String;
   RepertoireDossier:string;
   RepertoireOrigine:String;
   RepertoireDestination:String;
   RepertoireFichierSauvegarde:String;
   FichierParam:string;
  end;

Type
  TPAramEnLigne = record
   Retour:Boolean;
   FichierEnParametre:String;
  end;


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

  TParamLibChoixRepAffiche = Record
   TitreForm:String;
   TitreDialogRep:String;
   RepDefaut:String;
   AfficheRepDefDansEdit:Boolean;
  end;

type
  TChoixRecup = class(TForm)
    GroupBox1: TGroupBox;
    SpeedButton3: TSpeedButton;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    BtnRecupere: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BtnRecupereClick(Sender: TObject);
  private
    { Déclarations privées }
    ListeParam : TStringList;
    RepertoireApplication:String;
    InfoRestaure:TInfoRestaure;
  public
    { Déclarations publiques }
    ParamEnLigne : TPAramEnLigne;
  end;

var
  ChoixRecup: TChoixRecup;
  FichierEnParametre:string;
  ParamLibChoixRepAffiche:TParamLibChoixRepAffiche;


//Function ParamEnLigneLec(Index:Integer):TPAramEnLigne;
//function ShellExecuteAndWait(
//                             vHandle     : HWND;
//                             vOperation  : string;
//                             vFichier    : string;
//                             vParametres : string;
//                             vRepertoire : string;
//                             vAffichage  : Integer;
//                             vDuree      : DWORD
//                            ) : Cardinal;
implementation

uses Unit1, DiversProjets;

{$R *.dfm}
//function ShellExecuteAndWait(
//                             vHandle     : HWND;
//                             vOperation  : string;
//                             vFichier    : string;
//                             vParametres : string;
//                             vRepertoire : string;
//                             vAffichage  : Integer;
//                             vDuree      : DWORD
//                            ) : Cardinal;
//var
//  vSEInfo   : TShellExecuteInfo;
//begin
//  Initialisation de la structure ShellExecuteInfo
//  ZeroMemory(@vSEInfo, SizeOf(vSEInfo));
//
//  Remplissage de la structure ShellExecuteInfo
//  vSEInfo.cbSize       := SizeOf(vSEInfo);
//  vSEInfo.fMask        := SEE_MASK_NOCLOSEPROCESS;
//  vSEInfo.Wnd          := vHandle;
//  vSEInfo.lpVerb       := PAnsiChar(vOperation);
//  vSEInfo.lpFile       := PAnsiChar(vFichier);
//  vSEInfo.lpParameters := PAnsiChar(vParametres);
//  vSEInfo.lpDirectory  := PAnsiChar(vRepertoire);
//  vSEInfo.nShow        := vAffichage;
//
//  Execution
//  if ShellExecuteEx(@vSEInfo) then
//  begin
//    ShellExecuteEx OK : attendre la fin du process
//    Result := WaitForSingleObject(vSEInfo.hProcess, vDuree);
//  end
//  else
//  begin
//    ShellExecuteEx KO : renvoyer l'erreur
//    Result := GetLastError();
//  end;
//end;
//
//Function ParamEnLigneLec(Index:Integer):TPAramEnLigne;
//var
//i:integer;
//Begin
//Result.Retour:=false;
//Result.FichierEnParametre :='';
//   case Index of
//      // Ne mettre ici que le traitement avant toute création d'objet !!!
//      1:for i:=0 to ParamCount do
//       // Section Alphabétique
//         begin
//         if i > 0 then
//         Result.FichierEnParametre :=Result.FichierEnParametre+' '+ParamStr(i);
//         if str_fini_par( UpperCase(Result.FichierEnParametre),'.ZLG') then
//          begin
//           Result.FichierEnParametre:=TrimLeft(Result.FichierEnParametre);
//           Result.FichierEnParametre:=TrimRight(Result.FichierEnParametre);
//           Result.Retour:=True;
//
//          end;
//         end;
//   end;
//End;
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


procedure TChoixRecup.FormActivate(Sender: TObject);
var
repertoireTemp:Pchar;
begin
//repertoireTemp:=Pchar(GetTempDir);
//ShowMessage(repertoireTemp);
  if ParamEnLigne.Retour then
  begin
      Restauration.EdFichierSauvegarde.Text:=ParamEnLigne.FichierEnParametre;
      Restauration.RecupParamFichierSauvegarde(ParamEnLigne.FichierEnParametre);
  end;
InfoRestaure.RepertoireFichierSauvegarde:=Restauration.EdFichierSauvegarde.Text;

end;

procedure TChoixRecup.SpeedButton3Click(Sender: TObject);
var
input:string;
rang:integer;
sDirEXE:string;
listeParam:TStringlist;
begin
//if InfoRestaure.NomDossier='' then
    begin
    ParamLibChoixRepAffiche.RepDefaut:=CheminRepDest;
    ParamLibChoixRepAffiche.TitreDialogRep:='Choisir le répertoire du dossier à restaurer.'+
    RetourChariotSimple+'Ceci afin de récupérer le fichier de paramètrage "paramFtp.txt" contenu dans le dossier.';
       //OpenDialog1.InitialDir:='C:\LGRDOSS\EPICEA';
       if BrowseDirectory(ParamLibChoixRepAffiche.RepDefaut,ParamLibChoixRepAffiche.TitreDialogRep,0) then
        if(FileExists(IncludeTrailingPathDelimiter(ParamLibChoixRepAffiche.RepDefaut)+FichierParamftp))then
        //if(OpenDialog1.Execute)then
            begin
             InfoRestaure.FichierParam:=IncludeTrailingPathDelimiter(ParamLibChoixRepAffiche.RepDefaut)+FichierParamftp;
             InfoRestaure.RepertoireDossier:=ParamLibChoixRepAffiche.RepDefaut
            end
        else
         exit;

         rang:= Str_Count_Str(InfoRestaure.RepertoireDossier,PathDelim)-1;
         InfoRestaure.NomDossier:=str_remplacesouschaine(InfoRestaure.RepertoireDossier,
         ExtractFilePath(InfoRestaure.RepertoireDossier),'');

        Restauration.LaDossier.Caption:=  InfoRestaure.NomDossier;
        listeParam:=Tstringlist.create;
        listeParam.LoadFromFile(InfoRestaure.FichierParam);
        listeParam.Strings[0]:=IncludeTrailingPathDelimiter(RepertoireApplication+RepertoireSauvegarde+InfoRestaure.NomDossier);
        listeParam.SaveToFile(InfoRestaure.FichierParam);
    end;
label4.Caption:=InfoRestaure.FichierParam;
BtnRecupere.Enabled:=Restauration.EssaiConnection(InfoRestaure.FichierParam);

if (InfoRestaure.NomDossier='')then Restauration.LaDossier.Caption:= 'Le nom du dossier n''a pas pu être récupéré'+#10#13+
  'à partir du nom de cette sauvegarde';

end;

procedure TChoixRecup.BtnRecupereClick(Sender: TObject);
var accede:boolean;
continuer:integer;
paramftp:TParamFTP;
fichierSauvegarde:string;
listeParam:Tstringlist;
retourShell:cardinal;
begin
accede:=false;
if(MessageDlg('La récupération de la(des) sauvegarde(s) depuis l''adresse FTP : &peut-être longue.',mtInformation,mbOKCancel,0)=mrOk)then
begin
  try //finally
//     PatienterAffich(true);
     if LitFichierParamFTP(InfoRestaure.FichierParam,paramftp,true,InfoRestaure.NomDossier,'monftp-1.net',paramftp,InfoRestaure.RepertoireDossier)then
       begin
//         if EssaiConnection then
//           begin
//               try//finally
//                    if MessageLGR.Afficher then
//                      continuer:=MsgDlgBox(db)
//                    else continuer:=mrCust1;
//                 if db.CheckBox then
//                   begin
//                     MessageLGR.Afficher:=not StrToBool_Lgr(IntToStr(hiWord(continuer)),true);
//                     DM_EcritMessageLGR(MessageLGR);
//                   end;
//                if LoWord(continuer)=mrCust1 then
//                 begin
//                    e.ParamFTP.Source:=IncludeTrailingPathDelimiter(ParamUtil.RepertoireSauvegarde)+e.nomdossier;
//                   // e.ParamFTP.Dest:='/';
//                    EcritFichierParamFTP(e.ParamFTP);
                    retourShell:=(ShellExecuteAndWait(Application.Handle,'','envoi_ftp.exe',PChar('"'+InfoRestaure.FichierParam+'" ga'),
                           PChar(RepertoireApplication),SW_SHOWNORMAL,INFINITE));
                    if (retourShell = NO_ERROR )  then
                        begin
                            listeParam:=Tstringlist.create;
                            listeParam.LoadFromFile(InfoRestaure.FichierParam);
                            if(listeParam.count<>0)then
                            Restauration.RecupParamFichierSauvegarde(listeParam.Strings[0]);
//                              EdFichierSauvegarde.Text:=listeParam.Strings[0];
                       end;
       end
  finally

  end;
end;
end;


end.
