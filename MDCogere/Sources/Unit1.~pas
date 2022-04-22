unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ShellApi,
  Mask,
  FileUtil,
  Lib_Chaine,
  ToolEdit,DiversProjets, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP, Menus, ExtCtrls;


Const
RepDef = 'RepDef';
FichierInit = 'MDCOGERE.ini';
RepDest = 'RepDest';

RepRechercheFTP = 'RepRechercheFTP';
RepRecherche2 = 'RepRecherche2';
RepRecherche3 = 'RepRecherche3';
RepRecherche4 = 'RepRecherche4';

CheminRepDest = 'C:\LGRDOSS\EPICEA';
ProgRestauration = 'RestaureLGR.exe';
ProgSauvegarde='SauvegardeLGR.exe';
RepertoireSauvegarde = 'Sauvegarde\';
ProgCompta = 'Epicea2.exe';
ServeurDefaut='monftp-1.net';
FichierParamftp='paramftp.txt';
//C_Version_FileName='ConfVerEpi.Lic';
//C_Version_FileNameConfirme='EnInstance.Fic';

type
  TInfoRestaure = Record
   NomDossier:String;
   RepertoireDossier:string;
   RepertoireOrigine:String;
   RechercheFTP:string;
   Recherche1:String;
   Recherche2:String;
   Recherche3:String;
   Recherche4:String;
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
  TRestauration = class(TForm)
    ODParamFTP: TOpenDialog;
    IdFTP1: TIdFTP;
    ODRecherche1: TOpenDialog;
    Panel1: TPanel;
    btnAnnuler: TButton;
    ODRecherche2: TOpenDialog;
    ODRecherche3: TOpenDialog;
    GrRestauration: TPanel;
    EdFichierSauvegarde: TEdit;
    CBSecours: TCheckBox;
    chLancerEpicea: TCheckBox;
    Label2: TLabel;
    DirectoryEdit1: TDirectoryEdit;
    choixdudossier2: TSpeedButton;
    Label3: TLabel;
    LaDossier: TLabel;
    BtnValider: TButton;
    BtnLanceEpi: TButton;
    PaSoldeFin1: TPanel;
    Panel3: TPanel;
    GrFTP: TGroupBox;
    ChoixDossier: TSpeedButton;
    Label4: TLabel;
    BtnRecupere: TButton;
    GrRechercher: TGroupBox;
    spChercher1: TSpeedButton;
    Lachercher1: TLabel;
    Lachercher2: TLabel;
    spChercher2: TSpeedButton;
    Lachercher3: TLabel;
    spChercher3: TSpeedButton;
    Label1: TLabel;
    Panel4: TPanel;
    MainMenu1: TMainMenu;
    Versiondu231120102: TMenuItem;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Lachercher4: TLabel;
    spChercher4: TSpeedButton;
    Label7: TLabel;
    cbConserveCheminFTP: TCheckBox;
    Label8: TLabel;
    EdCheminDossierFTP: TEdit;
    ODRecherche4: TOpenDialog;
    EdNomSauvegarde: TEdit;
    Label6: TLabel;
    Label9: TLabel;
    procedure spChercher1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ODRecherche1FolderChange(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
    procedure BtnLanceEpiClick(Sender: TObject);
    procedure btnAnnulerClick(Sender: TObject);
    procedure DirectoryEdit1AfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure RecupParamFichierSauvegarde(FileName:string='');
    procedure RecupParamFichierSauvegarde2(FileName:string='');
    procedure RecupParamFichierSauvegarde3(FileName:string='');
    procedure RecupParamFichierSauvegardeFTP(FileName:string='');
    procedure RecupParamFichierSauvegarde4(FileName:string='');
    procedure FormActivate(Sender: TObject);
    procedure choixdudossier2Click(Sender: TObject);
    procedure BtnRecupereClick(Sender: TObject);
    procedure ODParamFTPFolderChange(Sender: TObject);
    procedure ChoixDossierClick(Sender: TObject);
    function EssaiConnection(FichierParam:string):boolean;
    procedure DirFichierFtpButtonClick(Sender: TObject);
    procedure ODRecherche2FolderChange(Sender: TObject);
    procedure ODRecherche3FolderChange(Sender: TObject);
    procedure spChercher2Click(Sender: TObject);
    procedure spChercher3Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Rcuprationlocale1Click(Sender: TObject);
    procedure RcuprationparFTP1Click(Sender: TObject);
    procedure EnabledGrFTP(enabled:Boolean);
    procedure EnabledGrRechercher(enabled:Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EnabledGrRestauration(enabled:Boolean);
    procedure ODRecherche4FolderChange(Sender: TObject);
    procedure spChercher4Click(Sender: TObject);
    procedure initialiseCheminFTP(afficheDialogue:boolean);
    function ControleVersionSauvegarde(Sauvegarde:string):boolean;
    function verifVersion(cheminFichier:string):TVersionEpi;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
    ListeParam : TStringList;
    RepertoireApplication:String;
    InfoRestaure:TInfoRestaure;
//    conserverCheminFtp:boolean;
  public
    { Déclarations publiques }
    ParamEnLigne : TPAramEnLigne;
    ControlDesactive:boolean;
  end;

var
  Restauration: TRestauration;
  FichierEnParametre:string;
  ParamLibChoixRepAffiche:TParamLibChoixRepAffiche;

Function DateInfos(Date:TDate;FormatReduit:boolean=true;Separateur:string=''):TDetailDate;
Function HeureInfos(Horaire:TTime;Separateur:String=''):TDetailTime;
Function ParamEnLigneLec(Index:Integer):TPAramEnLigne;
function ShellExecuteAndWait(
                             vHandle     : HWND;
                             vOperation  : string;
                             vFichier    : string;
                             vParametres : string;
                             vRepertoire : string;
                             vAffichage  : Integer;
                             vDuree      : DWORD
                            ) : Cardinal;



implementation
uses Math, ImportDll,  WinShellFolder, RechercheRepDest,ZipMstr,LibRessourceString,
  LibDates;
// START Section de l'expert ressource chaîne
resourcestring
  SMC_Main_Chercher = 'Chercher ...';
  SMC_Main_DSolLeFichier = 'Désolé, le fichier : [ ';
  SMC_Main_Epi = '.epi';
  SMC_Main_Epi1 = '.epi"';
  SMC_Main_EstIntrouvable = ' ] est introuvable !';
  SMC_Main_FaireUneSauvegardeDeSecours = 'Faire une sauvegarde de secours ?';
  SMC_Main_Merci = 'Merci.';
  SMC_Main_Ouvrir = 'Ouvrir : [ ';
  SMC_Main_Restaurer = 'restaurer.';
  SMC_Main_SauvLog = 'SauvLog';
  SMC_Main_SiEpiceaEstEnCoursDUtilisationVe = 'Si Epicea est en cours d''''utilisation, veuillez le fermer avant de ';
  SMC_Main_SLectionnezLeFichierRestaurerEnC = 'Sélectionnez le fichier à restaurer en cliquant sur le bouton ';
  SMC_Main_Txt = '.txt';

// END  Section de l'expert ressource chaîne

{$R *.dfm}
function GetTempDossier: String;
{-----------------------------------------------------------------------------------}
{renvoie le dossier "temporaire de Windows"                                         }
{ cette fonction renvoie :le dossier temporaire en fonction des critères suivants:  }
{1.	le chemin spécifié par la variable d'environement TMP                       }
{2.	le chemin spécifié par la variable d'environement TEMP  si TMP non défini   }
{3.	le dossier courant si aucune des deux variables TMP et TEMP ne sont définies}
{-----------------------------------------------------------------------------------}
var
  Dossier: array[0..MAX_PATH] of Char;
begin
  result:='';
  if GetTempPath(SizeOf(Dossier), Dossier)<>0 then Result := StrPas(Dossier);
end;


procedure TRestauration.spChercher1Click(Sender: TObject);
begin
//ODRecherche1.FileName:='';
if ODRecherche1.Execute then
 begin
      RecupParamFichierSauvegarde;
      if( ExtractFileExt(ODRecherche1.FileName)<>'')then  Lachercher1.caption:=ExtractFileDir(ODRecherche1.FileName)
      else Lachercher1.caption:=ODRecherche1.FileName;
 end;
ODRecherche1.InitialDir:=ODRecherche1.FileName;
ODRecherche1.FileName:='';
end;


procedure TRestauration.FormCreate(Sender: TObject);
var
i:integer;
begin
// initialisation
//conserverCheminFtp:=false;
InfoRestaure.NomDossier:='';
InfoRestaure.RepertoireDestination:='';
InfoRestaure.RepertoireOrigine:='';
LaDossier.Caption:= '';
RepertoireApplication:= IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
if not FileExists(RepertoireApplication+FichierInit) then
  AjouterFichierTexte(RepertoireApplication+FichierInit,'RepDest=C:\LGRDOSS\EPICEA');
//  showmessage(RepertoireApplication+ ProgCompta);
Restauration.Position:=poScreenCenter;
ControlDesactive:=false;
ListeParam := TStringList.Create;
if FileExists(RepertoireApplication+FichierInit) then
 Begin
  ListeParam.LoadFromFile(RepertoireApplication+FichierInit);
 End;
for i:=0 to ListeParam.Count - 1 do
 begin
  if ListeParam.Names[i]=RepDef then InfoRestaure.Recherche1 := ListeParam.ValueFromIndex[i];
  if ListeParam.Names[i]=RepDest then InfoRestaure.RepertoireDestination:= ListeParam.ValueFromIndex[i];
  if ListeParam.Names[i]=RepDest then InfoRestaure.RechercheFTP:= ListeParam.ValueFromIndex[i];
//  if ListeParam.Names[i]=RepRecherche1 then InfoRestaure.Recherche1:= ListeParam.ValueFromIndex[i];
  if ListeParam.Names[i]=RepRecherche2 then InfoRestaure.Recherche2:= ListeParam.ValueFromIndex[i];
  if ListeParam.Names[i]=RepRecherche3 then InfoRestaure.Recherche3:= ListeParam.ValueFromIndex[i];
  if ListeParam.Names[i]=RepRecherche4 then InfoRestaure.Recherche4:= ListeParam.ValueFromIndex[i];
  if ListeParam.Names[i]=RepRechercheFTP then InfoRestaure.RechercheFTP:= ListeParam.ValueFromIndex[i];
 end;
cbConserveCheminFTP.Checked:=InfoRestaure.RechercheFTP<>'';
if InfoRestaure.RepertoireDestination='' then InfoRestaure.RepertoireDestination:=CheminRepDest;
DirectoryEdit1.Text := InfoRestaure.RepertoireDestination;
DirectoryEdit1.InitialDir:=InfoRestaure.RepertoireDestination;;
BtnLanceEpi.Enabled := False;

if(InfoRestaure.Recherche1='')then InfoRestaure.Recherche1:=IncludeTrailingPathDelimiter(RepertoireApplication)+'Sauvegarde';
if(InfoRestaure.Recherche2='')then InfoRestaure.Recherche2:=IncludeTrailingPathDelimiter(RepertoireApplication)+'Sauvegarde';
if(InfoRestaure.Recherche3='')then InfoRestaure.Recherche3:=IncludeTrailingPathDelimiter(RepertoireApplication)+'Sauvegarde';
if(InfoRestaure.Recherche4='')then InfoRestaure.Recherche4:=IncludeTrailingPathDelimiter(RepertoireApplication)+'Sauvegarde';
if(InfoRestaure.RechercheFTP='')then InfoRestaure.RechercheFTP:=IncludeTrailingPathDelimiter(CheminRepDest);

ODRecherche1.InitialDir := InfoRestaure.Recherche1;
ODRecherche2.InitialDir := InfoRestaure.Recherche2;
ODRecherche3.InitialDir := InfoRestaure.Recherche3;
ODRecherche4.InitialDir := InfoRestaure.Recherche4;
ODParamFTP.InitialDir := InfoRestaure.RechercheFTP;

end;


procedure TRestauration.FormDeactivate(Sender: TObject);
var
i:integer;
valeur:string;
begin
// Sauvegarde des paramètres
i:=ListeParam.IndexOfName(RepDef);
if i <> - 1 then
 begin
  if ListeParam.Names[i] = RepDef then ListeParam.ValueFromIndex[i]:=ODRecherche1.InitialDir;
 end
 else
 begin
  ListeParam.Add(RepDef+'='+ ODRecherche1.InitialDir);
 end;

i:=ListeParam.IndexOfName(RepRecherche2);
if i <> - 1 then
 begin
  if ListeParam.Names[i] = RepRecherche2 then ListeParam.ValueFromIndex[i]:=ODRecherche2.InitialDir;
 end
 else
 begin
  ListeParam.Add(RepRecherche2+'='+ ODRecherche2.InitialDir);
 end;

i:=ListeParam.IndexOfName(RepRecherche3);
if i <> - 1 then
 begin
  if ListeParam.Names[i] = RepRecherche3 then ListeParam.ValueFromIndex[i]:=ODRecherche3.InitialDir;
 end
 else
 begin
  ListeParam.Add(RepRecherche3+'='+ ODRecherche3.InitialDir);
 end;

i:=ListeParam.IndexOfName(RepRecherche4);
if i <> - 1 then
 begin
  if ListeParam.Names[i] = RepRecherche4 then ListeParam.ValueFromIndex[i]:=ODRecherche4.InitialDir;
 end
 else
 begin
  ListeParam.Add(RepRecherche4+'='+ ODRecherche4.InitialDir);
 end;

if(cbConserveCheminFTP.Checked)then
begin
RecupParamFichierSauvegardeFTP(InfoRestaure.RechercheFTP);
end
else ODParamFTP.InitialDir:='';
//if(conserverCheminFtp)then
begin
//RecupParamFichierSauvegardeFTP(InfoRestaure.RechercheFTP);
i:=ListeParam.IndexOfName(RepRechercheFTP);
valeur:=InfoRestaure.RechercheFTP;
if not str_commence_par(valeur,ODParamFTP.InitialDir)then
   valeur:=ODParamFTP.InitialDir;
if i <> - 1 then
 begin
  if ListeParam.Names[i] = RepRechercheFTP then ListeParam.ValueFromIndex[i]:=ODParamFTP.InitialDir;
 end
 else
 begin
  ListeParam.Add(RepRechercheFTP+'='+ ODParamFTP.InitialDir);
 end;
end;


i:=ListeParam.IndexOfName(RepDest);
if i <> - 1 then
 begin
  if ListeParam.Names[i] = RepDest then ListeParam.ValueFromIndex[i]:=InfoRestaure.RepertoireDestination;
 end
 else
 begin
  ListeParam.Add(RepDest+'='+ InfoRestaure.RepertoireDestination);
 end;

// Fin de sauvegarde des parametres
ListeParam.SaveToFile(RepertoireApplication+FichierInit);
ListeParam.Free;
end;


procedure TRestauration.ODRecherche1FolderChange(Sender: TObject);
begin
ODRecherche1.Title := 'Rechercher une sauvegarde';
//ODRecherche1.Title := GetCurrentDir;
//if(sender = nil)then
//   spChercher1.Hint:=ODRecherche1.InitialDir
//else
//  spChercher1.Hint:=ODRecherche1.FileName;

//Lachercher1.caption:=str_n_prem_char(ODRecherche1.FileName,60);
end;

procedure TRestauration.BtnValiderClick(Sender: TObject);
var
result, ProposerSauver:boolean;
ListeDossier:TStringList;
NomFicSauvegarde:string;
retourShell:cardinal;
NumError, Epi_handle, Rest_Handle :word;
texte,messageFichier,dateRest:string;
begin
try
dateRest:=DateInfos(Date).JourStr+'-'+DateInfos(Date).MoisStr+'-'+DateInfos(Date).AnStr+' à '+HeureInfos(Time,'').HeureStr+'-'+HeureInfos(Time,'').MinuteStr+'-'+HeureInfos(Time,'').SecondeStr;
messageFichier:='Le '+dateRest+',restauration de la sauvegarde : '+#10+IncludeTrailingPathDelimiter(EdFichierSauvegarde.Text)+EdNomSauvegarde.Text;
ListeDossier:=TStringList.Create;
if not FileExists(IncludeTrailingPathDelimiter(EdFichierSauvegarde.Text)+EdNomSauvegarde.Text) then
 begin
  MessageDlg(SMC_Main_SLectionnezLeFichierRestaurerEnC+#13+#10+SMC_Main_Chercher, mtWarning, [mbOK], 0);
  exit;
 end;
ControleVersionSauvegarde(IncludeTrailingPathDelimiter(EdFichierSauvegarde.Text)+EdNomSauvegarde.Text);
texte:='-AvantRestauration';
MessageDlg(SMC_Main_SiEpiceaEstEnCoursDUtilisationVe+#13+#10+SMC_Main_Restaurer+#13+#10+''+#13+#10+SMC_Main_Merci, mtWarning, [mbOK], 0);

result:=false;

ProposerSauver:=DirectoryExists(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+InfoRestaure.NomDossier);

if ProposerSauver then
  BtnLanceEpi.Enabled := False;
  ProposerSauver:=CBSecours.Checked;

 if ((ProposerSauver) and (MessageDlg(SMC_Main_FaireUneSauvegardeDeSecours, mtConfirmation, [mbYes,mbNo], 0) = mrYes)) then
  begin
      NomFicSauvegarde:=SMC_Main_SauvLog+InfoRestaure.NomDossier+DateInfos(Date).DateStrFormat+HeureInfos(Time,'').HeureStrFormate+texte+SMC_Main_Txt;
      ListeDossier.Add(InfoRestaure.NomDossier+';'+InfoRestaure.RepertoireDestination+';'+RepertoireApplication+RepertoireSauvegarde+InfoRestaure.NomDossier+';;;'+texte+';');

      ListeDossier.SaveToFile(RepertoireApplication + RepertoireSauvegarde+NomFicSauvegarde);

       result:=(AfficheSauvegarde_ancienne(True,PChar(RepertoireApplication + RepertoireSauvegarde+NomFicSauvegarde)) = MrOk);

       if result then
        // retourShell:=AfficheRestauration(true,PChar(InfoRestaure.NomDossier+';'+InfoRestaure.RepertoireDestination+';'+InfoRestaure.RepertoireFichierSauvegarde));
        retourShell:=(ShellExecuteAndWait(Application.Handle,'',RepertoireApplication+ ProgRestauration,
                 '"'+InfoRestaure.NomDossier+'" "'+InfoRestaure.RepertoireDestination+'" "'+InfoRestaure.RepertoireFichierSauvegarde +'"','',SW_SHOWNORMAL,
                                      INFINITE));

      if (retourShell = NO_ERROR )  then
     //  if (retourShell = mrok )  then
        begin
         AjouterFichierTexte(IncludeTrailingPathDelimiter(RepertoireApplication)+'RestaurationSuivi.txt',messageFichier);
         if(chLancerEpicea.Checked)then BtnLanceEpi.Click
         else BtnLanceEpi.Visible:=true;
         end;
  end
 else
  begin
//    retourShell:=ShellExecuteAndWait(Application.Handle,nil,PChar(RepertoireApplication+ ProgRestauration),
//             PChar('"'+InfoRestaure.NomDossier+'" "'+InfoRestaure.RepertoireDestination+'" "'+InfoRestaure.RepertoireFichierSauvegarde +'"'),nil,sw_show);
//         retourShell:=AfficheRestauration(true,PChar(InfoRestaure.NomDossier+';'+InfoRestaure.RepertoireDestination+';'+InfoRestaure.RepertoireFichierSauvegarde));
     retourShell:=(ShellExecuteAndWait(Application.Handle,'',RepertoireApplication+ ProgRestauration,
             '"'+InfoRestaure.NomDossier+'" "'+InfoRestaure.RepertoireDestination+'" "'+InfoRestaure.RepertoireFichierSauvegarde +'"','',SW_SHOWNORMAL,
                                  INFINITE));
     if (retourShell = NO_ERROR )  then
     //if (retourShell = mrok )  then
       begin
       AjouterFichierTexte(IncludeTrailingPathDelimiter(RepertoireApplication)+'RestaurationSuivi.txt',messageFichier);
       if(chLancerEpicea.Checked)then BtnLanceEpi.Click
       else BtnLanceEpi.Visible:=true;
       end;
   end;
   BtnLanceEpi.Enabled := True;
//BtnLanceEpi.Caption :=SMC_Main_Ouvrir+IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+
//              InfoRestaure.NomDossier+SMC_Main_Epi+' ]';

finally
  ListeDossier.Free;
end;
end;

function ShellExecuteAndWait(
                             vHandle     : HWND;
                             vOperation  : string;
                             vFichier    : string;
                             vParametres : string;
                             vRepertoire : string;
                             vAffichage  : Integer;
                             vDuree      : DWORD
                            ) : Cardinal;
var
  vSEInfo   : TShellExecuteInfo;
begin
  //Initialisation de la structure ShellExecuteInfo
  ZeroMemory(@vSEInfo, SizeOf(vSEInfo));

  //Remplissage de la structure ShellExecuteInfo
  vSEInfo.cbSize       := SizeOf(vSEInfo);
  vSEInfo.fMask        := SEE_MASK_NOCLOSEPROCESS;
  vSEInfo.Wnd          := vHandle;
  vSEInfo.lpVerb       := PAnsiChar(vOperation);
  vSEInfo.lpFile       := PAnsiChar(vFichier);
  vSEInfo.lpParameters := PAnsiChar(vParametres);
  vSEInfo.lpDirectory  := PAnsiChar(vRepertoire);
  vSEInfo.nShow        := vAffichage;

  //Execution
  if ShellExecuteEx(@vSEInfo) then
  begin
    //ShellExecuteEx OK : attendre la fin du process
    Result := WaitForSingleObject(vSEInfo.hProcess, vDuree);
  end
  else
  begin
    //ShellExecuteEx KO : renvoyer l'erreur
    Result := GetLastError();
  end;
end;


procedure TRestauration.BtnLanceEpiClick(Sender: TObject);
var
repertoireTemp:Pchar;
begin
repertoireTemp:=Pchar(GetTempDir);
if FileExists(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+
              IncludeTrailingPathDelimiter(InfoRestaure.NomDossier)+
              InfoRestaure.NomDossier+SMC_Main_Epi) then
  begin
//showmessage('Répertoire temp : '+repertoireTemp);
//showmessage('chemin programme compta : '+PChar(RepertoireApplication+ ProgCompta));
//showmessage('Chemin fichier .epi : '+PChar('"'+IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+
//              IncludeTrailingPathDelimiter(InfoRestaure.NomDossier)+InfoRestaure.NomDossier+SMC_Main_Epi1));

    if (ShellExecute(Application.Handle,nil,PChar(RepertoireApplication+ ProgCompta),PChar('"'+IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+
              IncludeTrailingPathDelimiter(InfoRestaure.NomDossier)+InfoRestaure.NomDossier+SMC_Main_Epi1),repertoireTemp,sw_show) > 32) then ;
  end
  else
  begin
   MessageDlg(SMC_Main_DSolLeFichier+InfoRestaure.NomDossier+SMC_Main_Epi+SMC_Main_EstIntrouvable, mtWarning, [mbOK], 0);
  end;
Application.Terminate;
end;


procedure TRestauration.btnAnnulerClick(Sender: TObject);
begin
Application.Terminate;
end;


Function DateInfos(Date:TDate;FormatReduit:boolean;Separateur:string):TDetailDate;
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
      result.DateStr:=result.JourStr+Separateur+result.MoisStr+Separateur+result.AnStr;
    end;
  result.DateReal := (Date);
  result.DatePourSQLStr:=result.MoisStr+Separateur+result.JourStr+Separateur+result.AnStr;
  result.DateStrFormat:= result.JourStr+Separateur+result.MoisStr+Separateur+result.AnStr;
  result.JourMois:=result.JourStr+Separateur+result.MoisStr;
  result.MoisAnnee:=result.MoisStr+Separateur+result.AnStr;
except
  result.Valide:=False;
end;

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


procedure TRestauration.DirectoryEdit1AfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
InfoRestaure.RepertoireDestination:=Name;
end;




Function ParamEnLigneLec(Index:Integer):TPAramEnLigne;
var
i:integer;
Begin
Result.Retour:=false;
Result.FichierEnParametre :='';
   case Index of
      // Ne mettre ici que le traitement avant toute création d'objet !!!
      1:for i:=0 to ParamCount do
       // Section Alphabétique
         begin
         if i > 0 then
         Result.FichierEnParametre :=Result.FichierEnParametre+' '+ParamStr(i);
         if str_fini_par( UpperCase(Result.FichierEnParametre),'.ZLG') then
          begin
           Result.FichierEnParametre:=TrimLeft(Result.FichierEnParametre);
           Result.FichierEnParametre:=TrimRight(Result.FichierEnParametre);
           Result.Retour:=True;

          end;
         end;
   end;
End;

procedure TRestauration.RecupParamFichierSauvegardeFTP(FileName:string);
var
TextTmp:String;
input:string;
i:integer;
 begin
  if FileName<>'' then ODParamFTP.FileName:=fileName;
  InfoRestaure.RepertoireFichierSauvegarde := ODParamFTP.FileName;
  //InfoRestaure.RechercheFTP:=ODParamFTP.FileName;
  EdFichierSauvegarde.Text := ExtractFileDir(InfoRestaure.RepertoireFichierSauvegarde);
  EdNomSauvegarde.Text := ExtractFileName(InfoRestaure.RepertoireFichierSauvegarde);
  TextTmp:=ExtractFileName(ODParamFTP.FileName);
  i:=str_position('-',TextTmp);
  TextTmp:=str_n_prem_char(TextTmp,i-9) ;
  InfoRestaure.NomDossier:=TextTmp;
  choixdudossier2.Visible:=InfoRestaure.NomDossier='';
  EnabledGrRestauration(InfoRestaure.NomDossier<>'');
  choixdudossier2.Click;
  

  if InfoRestaure.NomDossier<>'' then
    LaDossier.Caption:= InfoRestaure.NomDossier;

  InfoRestaure.RepertoireOrigine:=ExtractFileDir(ODParamFTP.FileName);
  ODParamFTP.InitialDir := InfoRestaure.RechercheFTP;
 end;

 procedure TRestauration.RecupParamFichierSauvegarde(FileName:string);
var
TextTmp:String;
input:string;
i:integer;
 begin

  if FileName<>'' then ODRecherche1.FileName:=fileName;
  InfoRestaure.RepertoireFichierSauvegarde := ODRecherche1.FileName;
  InfoRestaure.Recherche1:=ODRecherche1.FileName;
  EdFichierSauvegarde.Text := ExtractFileDir(InfoRestaure.RepertoireFichierSauvegarde);
  EdNomSauvegarde.Text := ExtractFileName(InfoRestaure.RepertoireFichierSauvegarde);
  TextTmp:=ExtractFileName(ODRecherche1.FileName);
  edNomSauvegarde.Text :=TextTmp;
  i:=str_position('-',TextTmp);
  TextTmp:=str_n_prem_char(TextTmp,i-9) ;
  InfoRestaure.NomDossier:=TextTmp;
  choixdudossier2.Visible:=InfoRestaure.NomDossier='';
  EnabledGrRestauration(InfoRestaure.NomDossier<>'');
  choixdudossier2.Click;

  if InfoRestaure.NomDossier<>'' then
    LaDossier.Caption:= InfoRestaure.NomDossier;


  if( ExtractFileExt(ODRecherche1.FileName)<>'')then  ODRecherche1.FileName:=ExtractFileDir(ODRecherche1.FileName);
  InfoRestaure.RepertoireOrigine:=ODRecherche1.FileName;
  ODRecherche1.InitialDir := InfoRestaure.RepertoireOrigine;
 end;

 procedure TRestauration.RecupParamFichierSauvegarde2(FileName:string);
var
TextTmp:String;
input:string;
i:integer;
 begin
  if FileName<>'' then ODRecherche2.FileName:=fileName;
  InfoRestaure.RepertoireFichierSauvegarde := ODRecherche2.FileName;
    InfoRestaure.Recherche2:=ODRecherche2.FileName;
  EdFichierSauvegarde.Text := ExtractFileDir(InfoRestaure.RepertoireFichierSauvegarde);
  EdNomSauvegarde.Text := ExtractFileName(InfoRestaure.RepertoireFichierSauvegarde);
  TextTmp:=ExtractFileName(ODRecherche2.FileName);
  i:=str_position('-',TextTmp);
  TextTmp:=str_n_prem_char(TextTmp,i-9) ;
  InfoRestaure.NomDossier:=TextTmp;
  choixdudossier2.Visible:=InfoRestaure.NomDossier='';
  EnabledGrRestauration(InfoRestaure.NomDossier<>'');
  choixdudossier2.Click;

  if InfoRestaure.NomDossier<>'' then
    LaDossier.Caption:= InfoRestaure.NomDossier;

  InfoRestaure.RepertoireOrigine:=ExtractFileDir(ODRecherche2.FileName);
  ODRecherche2.InitialDir := InfoRestaure.RepertoireOrigine;
 end;

 procedure TRestauration.RecupParamFichierSauvegarde3(FileName:string);
var
TextTmp:String;
input:string;
i:integer;
 begin
  if FileName<>'' then ODRecherche3.FileName:=fileName;
  InfoRestaure.RepertoireFichierSauvegarde := ODRecherche3.FileName;
    InfoRestaure.Recherche3:=ODRecherche3.FileName;
  EdFichierSauvegarde.Text := ExtractFileDir(InfoRestaure.RepertoireFichierSauvegarde);
  EdNomSauvegarde.Text := ExtractFileName(InfoRestaure.RepertoireFichierSauvegarde);
  TextTmp:=ExtractFileName(ODRecherche3.FileName);
  i:=str_position('-',TextTmp);
  TextTmp:=str_n_prem_char(TextTmp,i-9) ;
  InfoRestaure.NomDossier:=TextTmp;
  choixdudossier2.Visible:=InfoRestaure.NomDossier='';
  EnabledGrRestauration(InfoRestaure.NomDossier<>'');
  choixdudossier2.Click;

  if InfoRestaure.NomDossier<>'' then
    LaDossier.Caption:= InfoRestaure.NomDossier;

  InfoRestaure.RepertoireOrigine:=ExtractFileDir(ODRecherche3.FileName);
  ODRecherche3.InitialDir := InfoRestaure.RepertoireOrigine;
 end;

procedure TRestauration.RecupParamFichierSauvegarde4(FileName:string);
var
TextTmp:String;
input:string;
i:integer;
 begin
  if FileName<>'' then ODRecherche4.FileName:=fileName;
  InfoRestaure.RepertoireFichierSauvegarde := ODRecherche4.FileName;
    InfoRestaure.Recherche4:=ODRecherche4.FileName;
  EdFichierSauvegarde.Text := ExtractFileDir(InfoRestaure.RepertoireFichierSauvegarde);
  EdNomSauvegarde.Text := ExtractFileName(InfoRestaure.RepertoireFichierSauvegarde);
  TextTmp:=ExtractFileName(ODRecherche4.FileName);
  i:=str_position('-',TextTmp);
  TextTmp:=str_n_prem_char(TextTmp,i-9) ;
  InfoRestaure.NomDossier:=TextTmp;
  choixdudossier2.Visible:=InfoRestaure.NomDossier='';
  EnabledGrRestauration(InfoRestaure.NomDossier<>'');
  choixdudossier2.Click;

  if InfoRestaure.NomDossier<>'' then
    LaDossier.Caption:= InfoRestaure.NomDossier;

  InfoRestaure.RepertoireOrigine:=ExtractFileDir(ODRecherche4.FileName);
  ODRecherche4.InitialDir := InfoRestaure.RepertoireOrigine;
 end;

procedure TRestauration.FormActivate(Sender: TObject);
var
repertoireTemp:Pchar;
titleSupp:string;
begin
  if ParamEnLigne.Retour then
  begin
      Restauration.EdNomSauvegarde.Text:=ExtractFileName(ParamEnLigne.FichierEnParametre);
      Restauration.EdFichierSauvegarde.Text:=ExtractFileDir(ParamEnLigne.FichierEnParametre);
      Restauration.RecupParamFichierSauvegarde(ParamEnLigne.FichierEnParametre);
  end;
InfoRestaure.RepertoireFichierSauvegarde:= IncludeTrailingPathDelimiter(Restauration.EdFichierSauvegarde.Text)+Restauration.EdNomSauvegarde.Text;

laChercher1.Caption:=ODRecherche1.InitialDir;
laChercher2.Caption:=ODRecherche2.InitialDir;
laChercher3.Caption:=ODRecherche3.InitialDir;
laChercher4.Caption:=ODRecherche4.InitialDir;

ChoixDossier.Hint:=ODParamFTP.InitialDir;

ODRecherche1FolderChange(nil);
ODRecherche2FolderChange(nil);
ODRecherche3FolderChange(nil);
ODRecherche4FolderChange(nil);

EnabledGrRechercher(InfoRestaure.NomDossier='');
EnabledGrFTP(false);
EnabledGrRestauration(InfoRestaure.NomDossier<>'');

titleSupp:= 'Version n° '+numVersion.Version+'  du '+numVersion.DateVersion;
  MainMenu1.items[0].caption:=titleSupp;
end;


procedure TRestauration.choixdudossier2Click(Sender: TObject);
var
input:string;
begin
if InfoRestaure.NomDossier='' then
    begin
        LaDossier.Caption:= 'Le nom du dossier n''a pas pu être récupéré'+#10#13+'à partir du nom de cette sauvegarde';
        input:=InputBox('Indiquez le nom du dossier','','');
              if input<>'' then
                begin
                  InfoRestaure.NomDossier := input;
                  LaDossier.Caption:=  InfoRestaure.NomDossier;
                end;
        choixdudossier2.Visible:= InfoRestaure.NomDossier='';
        if (InfoRestaure.NomDossier='')then LaDossier.Caption:= 'Le nom du dossier n''a pas pu être récupéré'+#10#13+'à partir du nom de cette sauvegarde';
    end;
end;

procedure TRestauration.BtnRecupereClick(Sender: TObject);
var accede:boolean;
continuer:integer;
paramftpLoc:TParamFTP;
fichierSauvegarde:string;
listeParam:Tstringlist;
retourShell:cardinal;
begin
accede:=false;
EdFichierSauvegarde.Text:='';
EdNomSauvegarde.Text:='';
//if(MessageDlg('La récupération de la(des) sauvegarde(s) depuis l''adresse FTP : &peut-être longue.',mtInformation,mbOKCancel,0)=mrOk)then
begin
  try //finally
//     PatienterAffich(true);
     //InitParamFTP(paramftpLoc,'','');
     if LitFichierParamFTP(InfoRestaure.FichierParam,paramftpLoc,true,InfoRestaure.NomDossier,'monftp-1.net',paramftpLoc,InfoRestaure.RepertoireDossier)then
       begin
                    retourShell:=(ShellExecuteAndWait(Application.Handle,'','envoi_ftp.exe',PChar('"'+InfoRestaure.FichierParam+'" ga'),
                           PChar(RepertoireApplication),SW_SHOWNORMAL,INFINITE));
                    if (retourShell = NO_ERROR )  then
                        begin
                            LitFichierParamFTP(InfoRestaure.FichierParam,paramftpLoc,true,InfoRestaure.NomDossier,
                            'monftp-1.net',paramftpLoc,InfoRestaure.RepertoireDossier);
                            //listeParam:=Tstringlist.create;
                            //listeParam.LoadFromFile(InfoRestaure.FichierParam);
                            //if(listeParam.count<>0)then
                              //RecupParamFichierSauvegardeFTP(InfoRestaure.RechercheFTP);
                            if(Str_Count_Str('.zlg',paramftpLoc.Source)>0)then
                              RecupParamFichierSauvegardeFTP(paramftpLoc.Source);
//                              EdFichierSauvegarde.Text:=listeParam.Strings[0];
                       end;
       end
  finally

  end;
end;
end;


procedure TRestauration.ODParamFTPFolderChange(Sender: TObject);
begin
ODParamFTP.Title := GetCurrentDir;
InfoRestaure.RechercheFTP:=ExtractFileDir(ODParamFTP.FileName);
end;

procedure TRestauration.ChoixDossierClick(Sender: TObject);
begin
    initialiseCheminFTP(true);
end;

procedure TRestauration.initialiseCheminFTP(afficheDialogue:boolean);
var
input:string;
rang:integer;
sDirEXE:string;
listeParam:TStringlist;
choixRep:TFormChoixRepDest;
retour:boolean;
begin

//str_position('.',InfoRestaure.RechercheFTP)<>0
// if(afficheDialogue)or((FileExists(InfoRestaure.RechercheFTP))and(IncludeTrailingPathDelimiter(InfoRestaure.RechercheFTP)<>IncludeTrailingPathDelimiter(CheminRepDest)))then
 if(afficheDialogue)or(FileExists(InfoRestaure.RechercheFTP))then
   begin
          begin
            EdCheminDossierFTP.Text:='';
            InfoRestaure.FichierParam:='';
            InfoRestaure.NomDossier:='';
            BtnRecupere.Enabled:=false;

          while(Str_Count_Str('.',InfoRestaure.RechercheFTP)>0) do
            InfoRestaure.RechercheFTP:=ExtractFileDir(InfoRestaure.RechercheFTP);
          ParamLibChoixRepAffiche.RepDefaut:=InfoRestaure.RechercheFTP;
          ParamLibChoixRepAffiche.TitreDialogRep:='Cliquez 1 fois sur le dossier à restaurer'+RetourChariotSimple+
          'puis cliquez sur "OK".'+RetourChariotSimple+'(ne cliquez pas sur un exercice du dossier).';
          if(afficheDialogue)then
             retour:=BrowseDirectory(ParamLibChoixRepAffiche.RepDefaut,ParamLibChoixRepAffiche.TitreDialogRep,0);

            if (retour)or(not afficheDialogue) then
             begin
            // conserverCheminFtp:=true;
              if(FileExists(IncludeTrailingPathDelimiter(ParamLibChoixRepAffiche.RepDefaut)+FichierParamftp))then
              //if(OpenDialog1.Execute)then
                  begin
                   InfoRestaure.FichierParam:=IncludeTrailingPathDelimiter(ParamLibChoixRepAffiche.RepDefaut)+FichierParamftp;
                   InfoRestaure.RepertoireDossier:=ParamLibChoixRepAffiche.RepDefaut;
                   InfoRestaure.RechercheFTP :=ParamLibChoixRepAffiche.RepDefaut;
                  end
              else
               begin
                 showmessage('Les paramètres FTP du dossier "'+ExtractFileName(ParamLibChoixRepAffiche.RepDefaut)+'" sont introuvables.'+retourchariotsimple+
                 'Vous pouvez les renseigner dans le menu "outils/propriétés" d''Epicéa.');
                 exit;
               end;
              end;
               rang:= Str_Count_Str(InfoRestaure.RepertoireDossier,PathDelim)-1;
               InfoRestaure.NomDossier:=str_remplacesouschaine(InfoRestaure.RepertoireDossier,
               ExtractFilePath(InfoRestaure.RepertoireDossier),'');

              LaDossier.Caption:=  InfoRestaure.NomDossier;
              listeParam:=Tstringlist.create;
              listeParam.LoadFromFile(InfoRestaure.FichierParam);
              listeParam.Strings[0]:=IncludeTrailingPathDelimiter(RepertoireApplication+RepertoireSauvegarde+InfoRestaure.NomDossier);
              listeParam.SaveToFile(InfoRestaure.FichierParam);
          end;
      EdCheminDossierFTP.Text:=ExtractFileDir(InfoRestaure.FichierParam);
      BtnRecupere.Enabled:=EssaiConnection(InfoRestaure.FichierParam);

      if (InfoRestaure.NomDossier='')then LaDossier.Caption:= 'Le nom du dossier n''a pas pu être récupéré'+#10#13+
        'à partir du nom de cette sauvegarde';
  end;
end;

function TRestauration.EssaiConnection(FichierParam:string):boolean;
var
listeParam:TStringlist;
ParamFTP:TParamFTP;
begin
result:=false;
if(FileExists(FichierParam))then
    begin
        listeParam:=Tstringlist.create;
        InitParamFTP(ParamFTP,'','monftp-1.net');
        LitFichierParamFTP(FichierParam,ParamFTP,false);

          IdFTP1.Host:=ParamFTP.Serveur;
          IdFTP1.Password:=ParamFTP.PassWord;
          IdFTP1.Username:=ParamFTP.Login;
          try
          IdFTP1.Connect();
          result:=true;
          IdFTP1.Quit;
          except
             application.MessageBox(Pansichar(connexionInvalide),'Adresse FTP invalide',MB_ICONWARNING);
             result:=false;
          end;
    end;
end;

procedure TRestauration.DirFichierFtpButtonClick(Sender: TObject);
var
input:string;
rang:integer;
sDirEXE:string;
listeParam:TStringlist;
begin
//if InfoRestaure.NomDossier='' then
//    begin
//         DirFichierFtp.InitialDir :='C:\LGRDOSS\EPICEA';

//        if(FileExists(IncludeTrailingPathDelimiter(DirFichierFtp.Text)+'paramftp.txt'))then
//            begin
//             InfoRestaure.FichierParam:=IncludeTrailingPathDelimiter(DirFichierFtp.Text)+'paramftp.txt';
//             InfoRestaure.RepertoireDossier:=DirFichierFtp.Text;
//            end
//        else
//         exit;
//
//         rang:= Str_Count_Str(InfoRestaure.RepertoireDossier,PathDelim)-1;
//         InfoRestaure.NomDossier:=str_remplacesouschaine(InfoRestaure.RepertoireDossier,
//         ExtractFilePath(InfoRestaure.RepertoireDossier),'');
//
//        LaDossier.Caption:=  InfoRestaure.NomDossier;
//        listeParam:=Tstringlist.create;
//        listeParam.LoadFromFile(InfoRestaure.FichierParam);
//        listeParam.Strings[0]:=IncludeTrailingPathDelimiter(RepertoireApplication+RepertoireSauvegarde+InfoRestaure.NomDossier);
//        listeParam.SaveToFile(InfoRestaure.FichierParam);
//    end;
//label4.Caption:=InfoRestaure.FichierParam;
//BtnRecupere.Enabled:=EssaiConnection(InfoRestaure.FichierParam);
//
//if (InfoRestaure.NomDossier='')then LaDossier.Caption:= 'Le nom du dossier n''a pas pu être récupéré'+#10#13+
//  'à partir du nom de cette sauvegarde';


end;


procedure TRestauration.ODRecherche2FolderChange(Sender: TObject);
begin
//ODRecherche2.Title := GetCurrentDir;
ODRecherche2.Title := 'Rechercher une sauvegarde';
//if(sender = nil)then
//   spChercher2.Hint:=ODRecherche2.InitialDir
//else
//  spChercher2.Hint:=ODRecherche2.FileName;
//Lachercher2.caption:=str_n_prem_char(spChercher2.Hint,60);
end;

procedure TRestauration.ODRecherche3FolderChange(Sender: TObject);
begin
ODRecherche3.Title := 'Rechercher une sauvegarde';
//if(sender = nil)then
//   spChercher3.Hint:=ODRecherche3.InitialDir
//else
//  spChercher3.Hint:=ODRecherche3.FileName;
//laChercher3.caption:=str_n_prem_char(spChercher3.Hint,60);
end;

procedure TRestauration.spChercher2Click(Sender: TObject);
begin
if ODRecherche2.Execute then
 begin
      RecupParamFichierSauvegarde2;
      if( ExtractFileExt(ODRecherche2.FileName)<>'')then  Lachercher2.caption:=ExtractFileDir(ODRecherche2.FileName)
      else Lachercher2.caption:=ODRecherche2.FileName;
 end;
ODRecherche2.InitialDir:=ODRecherche2.FileName;
ODRecherche2.FileName:='';
end;

procedure TRestauration.spChercher3Click(Sender: TObject);
begin
if ODRecherche3.Execute then
 begin
      RecupParamFichierSauvegarde3;
      if( ExtractFileExt(ODRecherche3.FileName)<>'')then  Lachercher3.caption:=ExtractFileDir(ODRecherche3.FileName)
      else Lachercher3.caption:=ODRecherche3.FileName;
 end;
ODRecherche3.InitialDir:=ODRecherche3.FileName;
ODRecherche3.FileName:='';
end;

procedure TRestauration.Quitter1Click(Sender: TObject);
begin
btnAnnuler.Click;
end;

procedure TRestauration.Rcuprationlocale1Click(Sender: TObject);
begin
GrRechercher.Enabled:=true;
GrFTP.Enabled:=false;
EnabledGrRechercher(GrRechercher.Enabled);
EnabledGrFTP(GrFTP.Enabled);
end;

procedure TRestauration.RcuprationparFTP1Click(Sender: TObject);
begin
GrRechercher.Enabled:=false;
GrFTP.Enabled:=true;
EnabledGrRechercher(GrRechercher.Enabled);
EnabledGrFTP(GrFTP.Enabled);
end;

procedure TRestauration.EnabledGrFTP(enabled:Boolean);
var i:integer;
begin
grFTP.Visible:=enabled;
if(not enabled)then
begin
   SpeedButton2.font.Size:=8;
   SpeedButton2.font.Style:=[];
   SpeedButton2.Font.Color:=clWindowText;
end
else
begin
   SpeedButton2.font.Size:=12;
   SpeedButton2.font.Style:=[fsBold];
   SpeedButton2.Font.Color:=clBlue;
end;
end;

procedure TRestauration.EnabledGrRestauration(enabled:Boolean);
var i:integer;
begin
for i:=0 to GrRestauration.ControlCount-1 do
begin
   GrRestauration.Controls[i].Enabled:=enabled;
end;
end;

procedure TRestauration.EnabledGrRechercher(enabled:Boolean);
var i:integer;
font:TFont;
begin
GrRechercher.Visible:=enabled;
if(not enabled)then
begin
   SpeedButton1.font.Size:=8;
   SpeedButton1.font.Style:=[];
   SpeedButton1.Font.Color:=clWindowText;
end
else
begin
   SpeedButton1.font.Size:=12;
   SpeedButton1.font.Style:=[fsBold];
   SpeedButton1.Font.Color:=clBlue;
end;
end;
procedure TRestauration.SpeedButton1Click(Sender: TObject);
begin
  EnabledGrRechercher(true);
  EnabledGrftp(false);
  EnabledGrRestauration(false);
end;

procedure TRestauration.SpeedButton2Click(Sender: TObject);
begin
  EnabledGrRechercher(false);
  EnabledGrftp(true);
  EnabledGrRestauration(false);
  //EdCheminDossierFTP.Text:=InfoRestaure.RechercheFTP;
  initialiseCheminFTP(false);
end;

procedure TRestauration.ODRecherche4FolderChange(Sender: TObject);
begin
ODRecherche4.Title := 'Rechercher une sauvegarde';
//if(sender = nil)then
//   spChercher4.Hint:=ODRecherche4.InitialDir
//else
//  spChercher4.Hint:=ODRecherche4.FileName;
//Lachercher4.caption:=str_n_prem_char(spChercher4.Hint,60);
end;

procedure TRestauration.spChercher4Click(Sender: TObject);
begin
if ODRecherche4.Execute then
 begin
      RecupParamFichierSauvegarde4;
      if( ExtractFileExt(ODRecherche4.FileName)<>'')then  Lachercher4.caption:=ExtractFileDir(ODRecherche4.FileName)
      else Lachercher4.caption:=ODRecherche4.FileName;
 end;
ODRecherche4.InitialDir:=ODRecherche4.FileName;
ODRecherche4.FileName:='';
end;



function TRestauration.ControleVersionSauvegarde(Sauvegarde:string):boolean;
var
F: TextFile;
Ligne,valeur:string;
zip:TZipMaster;
trouve:boolean;
VersionEpi:TVersionEpi ;
begin
try//finally
//gestion des contrôles de version
if(ControlDesactive) then
begin
  result:=true;
  exit;
end;
VersionEpi:=verifVersion(IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'InitVersion.txt');
if FileExists(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileName)then
  DeleteFile(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileName);
zip:=TZipMaster.Create(self);
zip.ZipFilename:=Sauvegarde;
zip.FSpecArgs.Add(InfoRestaure.NomDossier+'/'+C_Version_FileName);
zip.FSpecArgs.Add(InfoRestaure.NomDossier+'/'+C_Version_FileNameConfirme);
zip.ExtrBaseDir:=ExcludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination);
if not DirectoryExists(ExcludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination))then
  CreateDir(ExcludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination));
trouve:=false;
zip.Extract;
if FileExists(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileName)then
begin
  AssignFile(F, IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileName);
  reset(f);
  Readln(F,Ligne);
  trouve:=Ligne<=Str_ChaineToHEXA(VersionEpi.Version);
  Str_ChaineToHEXA(VersionEpi.Version);
  CloseFile(F);
end
else
  if FileExists(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileNameConfirme)then
    trouve:=false //ça veut dire qu'il manque un fichier de contrôle
  else
    trouve:=true;
if not DirectoryExists(ExcludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination))then
  showmessage('Problème rencontré lors du contrôle de version de la sauvegarde');
if not trouve then
begin
   showmessage('Version N° '+VersionEpi.Version+'  du '+VersionEpi.Date +retourChariotDouble+ VersionAnterieurRestauration+AppelerServiceMaintenance);
   abort;
end;
//fin gestion des contrôles de version
ControleVersionSauvegarde :=true;
//showmessage('contrôle version ok');
finally
if FileExists(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileName)then
  DeleteFile(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileName);
if FileExists(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileNameConfirme)then
  DeleteFile(IncludeTrailingPathDelimiter(InfoRestaure.RepertoireDestination)+C_Version_FileNameConfirme);
  zip.Free;
end;
end;


function TRestauration.verifVersion(cheminFichier:string):TVersionEpi;
var
nomVolume,numero:string;
text:TextFile;
valeur:string;
listeRetour:TStringlist;
begin
////     IncludeTrailingPathDelimiter(ExtractFileDrive(application.ExeName))
//Initialise_TVersionEpi(result);
//DisqueDur(ListTypeLecteur(DRIVE_FIXED).Strings[0],nomVolume,numero);
//result.Version:='';
//result.Date:='';
//listeRetour:=Tstringlist.create;
//if(fileexists(cheminFichier))then
//    begin
//        AssignFile(text,cheminFichier);
//        Reset(text);
//        Readln(text,valeur);
//        CloseFile(text);
//        Decrypt(valeur,numero);
//        ExtractStrings([','],[' '],PansiChar(valeur),listeRetour);
//        if(listeRetour.Count<2)then exit;
//
//        result.Version:=listeRetour.strings[0];
//        result.Date:=listeRetour.strings[1];
//
//    end;
//showMessage(e.TypeClientToStr(result));
result.Version:=numVersion.Version;
result.Date:=numVersion.DateVersion;
end;
procedure TRestauration.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  valeur:string;
begin
if ((Shift = [ssCtrl])and(Key=67)) then
begin
 valeur:=InputBox('Indiquer le mot de passe','','*******');
 if (valeur='lepelet')or(valeur=IntToSTr(LibDates.NbDeJours(StrToDate('01/01/'+LibDates.DateInfos(Date).AnStr),Date)+82+11)) then
begin
  ControlDesactive:=true;
end
else ControlDesactive:=false;

end;
end;

end.
