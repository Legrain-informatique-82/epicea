unit S2_Sauv;

////////////////////////////////////////////////////////////////////////////////
/////////         Description des param�tres pass� en ligne          ///////////
//   Si c'est un fichier :
//  ListeDesNomsdeDossier;ListedesRepertoireCourant;ListeRepertoireDEstination;ListeRepertoireDEstination2
//
//  D�tails : - la ListeDesNomsdeDossier est la liste de nom de dossier :))
//            - la ListedesRepertoireCourant sont les r�pertoires qu'il faut
//               rendre courant avec setCurrentDir pour pouvoir utiliser
//               le nom du dossier en chemmin relatif dans l'objet ZipMaster
//            - la ListeRepertoireDEstination sont les r�pertoires avec leurs
//                  nom de lectuer vers o� doit aller la sauvegarde
//               * si le RepertoireDEstination est manquant, un repertoire pas defaut
//                  est attribu� : ExtractFilePath(Application.ExeName) + 'Sauvegarde';
//            - la ListeRepertoireDEstination2 sont les r�pertoires avec leurs
//                  nom de lectuer vers o� doit aller la sauvegarde
//               * Aucune action si vide
//  Chaque champ est s�par� par un : ";"
//
//
//  Si ce n'est pas un fichier :
//
//  "NomdeDossier" "RepertoireCourant" "RepertoireDEstination" "RepertoireDEstination2"
//
// D�tails: idem aux listes
//
//
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, OleCtrls,
  //ZipMstr,
  //LibFichRep,
  //LibDates,
  Lib_Chaine,
  FileCtrl,
  FileUtil,
  ComCtrls,
  UMail,
  CopyFile, MyBackup,ShellAPI, AppEvnts, ZipMstr19, ZipMstr;

const

 WM_FINSAUVEGARDE = WM_USER + 1998;

type
  TSauv = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Animate1: TAnimate;
    MyBackupold: TMyBackup;
    ApplicationEvents1: TApplicationEvents;
    MyBackup1: TMyBackup;
    ZipMaster1: TZipMaster19;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ZipMaster2Message(Sender: TObject; ErrCode: Integer;
      Message: String);
    Procedure AppMessage(var Msg:TAGMsg;var Handled:Boolean);
    procedure FormShow(Sender: TObject);
  private
    { D�clarations priv�es }
    HandleEpi:Integer;
  public
    { D�clarations publiques }
    RepertoireDEstinationTmp:String;
    ParamSauvegarde:PChar;
    EnDLL:Boolean;
  end;

var
  Sauv: TSauv;

implementation

uses S2_MsgForm, LibDates, DiversProjets, LibFichRep;

{$R *.DFM}

procedure TSauv.Button1Click(Sender: TObject);
var
ListeDesNomsdeDossier,ListedesRepertoireCourant,ListeRepertoireDEstination,ListeRepertoireDEstination2,ListeEMail:TStringList;
ListeFichiers,ListeFichiersDossier,ListeParamSauvegarde,ListeTexteNomSauvegarde:TStringList;
ListLecteur:TStringList;
Jour,Mois,Heure,HeureAux:string;
H,M,S:string;
AnneeDate,DateStr:String;
NomSauvegarde,RepOrigine,RepDossier,RepDestination,lecteur:string;
NomFichierSauvegarde,NomFichierSauvegardeTmp,NomFicControle:String;
NomdeDossier,RepertoireCourant,RepertoireDEstination,RepertoireDEstination2:String;
MessageFin,retourProcess:String;
i,j,R:integer;
CustomCopyFile:TCustomCopyFile;
F:TSearchRec;
cheminFichierlog:string;
cheminCmd:string;
retourShell:integer;
//thread:TDLLThread;
begin
try
ShowMessage('je rentre en DLL');
if MsgForm = nil then MsgForm:=TMsgForm.Create(self);
//thread:=TDLLThread.DllCreate(false);
MsgForm.Memo1.Lines.Clear;
j:=0;
Animate1.Visible:=true;
Animate1.Active:=true;
Button1.Enabled:=false;
Button2.Enabled:=false;
screen.Cursor:=crHourGlass;
NomSauvegarde:='Sauvegarde';

RepOrigine:=ExtractFilePath(Application.ExeName);
RepDestination:='C:\lgrdoss\Epicea\'+'Sauvegarde';

RepDestination:=RepOrigine+'Sauvegarde';

//RepertoireDEstinationTmp := ExtractFilePath(Application.ExeName)+'SauvTmp';
RepertoireDEstinationTmp := 'C:\lgrdoss\Epicea\'+'SauvTmp';
if not DirectoryExists(RepertoireDEstinationTmp) then ForceDirectories(RepertoireDEstinationTmp);

ListeFichiers:=TStringList.create;
ListeFichiers.Clear;

ListeFichiersDossier:=TStringList.create;
ListeFichiersDossier.Clear;

ListeTexteNomSauvegarde:=TStringList.create;
ListeTexteNomSauvegarde.Clear;

ListeParamSauvegarde:=TStringList.create;
ListeParamSauvegarde.Clear;

ListeDesNomsdeDossier:=TStringList.create;
ListeDesNomsdeDossier.Clear;

ListedesRepertoireCourant:=TStringList.create;
ListedesRepertoireCourant.Clear;

ListeRepertoireDEstination:=TStringList.create;
ListeRepertoireDEstination.Clear;

ListeRepertoireDEstination2:=TStringList.create;
ListeRepertoireDEstination2.Clear;

ListeEMail:=TStringList.Create;
ListeEMail.Clear;

ListLecteur:=TStringList.Create;
ListLecteur.Clear;
//showmessage('Nombre de param : '+InttoStr(ParamCount));
if not DirectoryExists(RepDestination) then ForceDirectories(RepDestination);
if EnDLL then
   Begin
//     ShowMEssage(ParamSauvegarde);
      if FileExists(ParamSauvegarde) then
           ListeParamSauvegarde.LoadFromFile(ParamSauvegarde)
           else
            begin
             MessageDlg('Le nom du fichier n''est pas correct !', mtError, [mbOK], 0);
             if EnDll then
             ModalResult:=MRAbort
             else
             self.Close;
//             Application.Terminate;
             abort;
            end;
      For i:=0 to ListeParamSauvegarde.Count - 1 do
       begin
        ListeDesNomsdeDossier.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],1,';'));
       //showmessage('ListeDesNomsdeDossier : '+str_getstringelement(ListeParamSauvegarde.Strings[i],1,';'));
        ListedesRepertoireCourant.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],2,';'));
//       showmessage('ListedesRepertoireCourant : '+str_getstringelement(ListeParamSauvegarde.Strings[i],2,';'));
        ListeRepertoireDEstination.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],3,';'));
//       showmessage('ListeRepertoireDEstination : '+str_getstringelement(ListeParamSauvegarde.Strings[i],3,';'));
        ListeRepertoireDEstination2.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],4,';'));
        //ListeRepertoireDEstination2.Add('');
//        showmessage('ListeRepertoireDEstination2 : '+str_getstringelement(ListeParamSauvegarde.Strings[i],4,';'));
       ListeEMail.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],5,';'));
//       showmessage('ListeEMail : '+str_getstringelement(ListeParamSauvegarde.Strings[i],5,';'));
        ListeTexteNomSauvegarde.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],6,';'));
//       showmessage('ListeTexteNomSauvegarde : '+str_getstringelement(ListeParamSauvegarde.Strings[i],6,';'));
       end;
   end
  else
   Begin
    if ParamCount = 1 then
     begin
      if FileExists(ParamStr(1)) then
           ListeParamSauvegarde.LoadFromFile(ParamStr(1))
           else
            begin
             MessageDlg('Le nom du fichier n''est pas correct !', mtError, [mbOK], 0);
             if EnDll then
             ModalResult:=MRAbort
             else
             self.Close;
//             Application.Terminate;
             abort;
            end;
      For i:=0 to ListeParamSauvegarde.Count - 1 do
       begin
    //   showmessage(str_getstringelement(ListeParamSauvegarde.Strings[i],1,';'));
        ListeDesNomsdeDossier.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],1,';'));
    //   showmessage(str_getstringelement(ListeParamSauvegarde.Strings[i],2,';'));
        ListedesRepertoireCourant.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],2,';'));
        ListeRepertoireDEstination.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],3,';'));
        ListeRepertoireDEstination2.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],4,';'));
        ListeEMail.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],5,';'));
        ListeTexteNomSauvegarde.Add(str_getstringelement(ListeParamSauvegarde.Strings[i],6,';'));
       end;
    end
    else
     begin
      if ParamCount > 0 then ListeDesNomsdeDossier.Add(ParamStr(1));//;NomSauvegarde:=ParamStr(1);
      if ParamCount > 1 then ListedesRepertoireCourant.Add(ParamStr(2));//RepOrigine:=
      if ParamCount > 2 then ListeRepertoireDEstination.Add(ParamStr(3));//RepDestination:=
      if ParamCount > 3 then ListeRepertoireDEstination2.Add(ParamStr(4));//Lecteur:=
      if ParamCount > 4 then ListeRepertoireDEstination2.Add(ParamStr(5));//Email:=
      if ParamCount > 5 then ListeRepertoireDEstination2.Add(ParamStr(6));//TextNomSauvegarde:=
     end;
   end;
Lecteur :='a';
//DateInfos(now).DateStr
RepDossier:=RepOrigine;
//Delete(RepDossier,LastDelimiter('\',RepOrigine),length(RepDossier));

RepDossier:=RepDossier+'\';
RepOrigine:=RepOrigine+'\';

//param2 : RepOrigine : C:\PROJET\EPICEA-2\EXECUTION\Sauvegarde\Demo\Demo\
//showmessage('param2 : RepOrigine : '+RepOrigine);//
//ListeFichiers:=ListeFic('*.*',RepOrigine,faAnyFile,true,true);
//ListeFichiers.Add('c:\Projet\Epicea-2\Execution\Demo\Ecriture.DB');
//showmessage(ListeFichiers.Strings[0]);

//param3 : RepDossier : C:\PROJET\EPICEA-2\EXECUTION\Sauvegarde\Demo\
//showmessage('param3 : RepDossier : '+RepDossier);

//ListeFichiersDossier:=ListeFic('*.*',RepDossier,faAnyFile,true,true);
NomSauvegarde:='Demo';
//showmessage(ExtractRelativePath('Demo','C:\PROJET\EPICEA-2\EXECUTION\Sauvegarde\Demo\Ecriture.DB'));
SetCurrentDir('C:\PROJET\EPICEA-2\EXECUTION\Sauvegarde\'+NomSauvegarde);
ListeFichiersDossier.Add(NomSauvegarde + '\*.*');
//ListeFichiersDossier.Add('c:\..\..\..\Projet\Epicea-2\Execution\Demo\Ecriture.DB');
//showmessage(ListeFichiersDossier.Strings[0]);

Heure:=TimeToStr(now);
HeureAux := Heure;
H:= HeureInfos(now,'').HeureStr ;
M:=HeureInfos(now,'').MinuteStr;
S:=HeureInfos(now,'').SecondeStr;

CustomCopyFile:=TCustomCopyFile.Create(nil);
while pos(':',Heure) > 0 do delete(Heure,pos(':',Heure),1);

Jour:=DateInfos(now).JourStr;
Mois:=DateInfos(now).MoisStr;
AnneeDate :=DateInfos(now).AnStr;
DateStr:=DateInfos(now).DateStr;
cheminFichierlog:=IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'RestaurationSuivi.txt';
//showmessage('cheminFichierlog : '+cheminFichierlog);

for i:=0 to ListeDesNomsdeDossier.Count-1 do
 begin
 //showmessage('ListeDesNomsdeDossier.count : '+inttostr(ListeDesNomsdeDossier.Count));
   MessageFin:='';
   self.Caption := 'Sauvegarde de : '+ ListeDesNomsdeDossier.Strings[i];
   NomFichierSauvegarde:=ListeDesNomsdeDossier.Strings[i]+Jour+Mois+DateInfos(now).AnStr+'-'+Heure+ListeTexteNomSauvegarde.Strings[i]+'.zlg';
   ZipMaster1.ZipFilename:=RepertoireDEstinationTmp +'\'+NomFichierSauvegarde;
//   showmessage('ZipMaster1.ZipFilename : '+ZipMaster1.ZipFilename);

   with ZipMaster1 do
   begin
     j:=0;
     //showmessage('RepDestination : '+RepDestination);
     AddOptions:=[];
     AddOptions:=AddOptions+[ZipMstr19.AddRecurseDirs];  { we want recursion }
     AddOptions:=AddOptions+[ZipMstr19.AddDirNames];  { we want dirnames }
     AddOptions:=AddOptions-[ZipMstr19.AddEncrypt]; // don't forget to turn this off!
//      inc(j);
//      Showmessage(IntToStr(j));
     FSpecArgs.Clear;
//      inc(j);
     // Showmessage('ListedesRepertoireCourant.Strings[i] : '+ListedesRepertoireCourant.Strings[i]);
     SetCurrentDir(ListedesRepertoireCourant.Strings[i]);
//      inc(j);
//      Showmessage(IntToStr(j));
     ListeFichiersDossier.Clear;
//      inc(j);
//      Showmessage(IntToStr(j));
     ListeFichiersDossier.Add(ListeDesNomsdeDossier.Strings[i]);
//      inc(j);
//      Showmessage(IntToStr(j));
//     ListeFichiersDossier.Add(ListeDesNomsdeDossier.Strings[i] + '\*.*');
     try
//         FSpecArgs.Assign(ListeFichiers); { specify filenames }
//         Add;
      FSpecArgs.Add(ListeFichiersDossier.Strings[i] +'\*.*'); { specify filenames }
//      inc(j);
//      Showmessage(IntToStr(j));
      ZipMaster1.AddCompLevel:=9;
      try
//       MsgForm.Show;
//      inc(j);
      //Showmessage('Avant add');
////cheminCmd:=Pchar(ExtractFilePath(Application.ExeName)+' '+ZipMaster1.ZipFilename+' '+
////  IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+ListeDesNomsdeDossier.Strings[i]);
//  retourShell:=0;
//  cheminCmd:=Pchar('a -t7z '+ZipMaster1.ZipFilename+' '+
//    IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+ListeDesNomsdeDossier.Strings[i]);
//      retourShell:=shellExecute(handle,'Open',Pchar(ExtractFilePath(Application.ExeName)+'7za.exe'),Pchar(cheminCmd),nil,SW_SHOWNORMAL);
//      cheminCmd:=Pchar('l '+ZipMaster1.ZipFilename);
//      if(retourShell>32)then
//        retourShell:=shellExecute(handle,'Open',Pchar(ExtractFilePath(Application.ExeName)+'7za.exe'),Pchar(cheminCmd),nil,SW_SHOWNORMAL);
      ////ShellExecute(handle,'Open',Pchar(ExtractFilePath(Application.ExeName)+'Zzip.bat'),Pchar(cheminCmd),nil,SW_SHOWNORMAL);
        ////showmessage(inttostr(retourShell));
      ////cheminCmd:=Pchar('x '+ZipMaster1.ZipFilename+' -y -o"C:\poubelle\sauvegarde\"');
      ////retourShell:=ShellExecute(handle,'Open',Pchar(ExtractFilePath(Application.ExeName)+'7za.exe'),Pchar(cheminCmd),nil,SW_SHOWNORMAL);
       //showmessage(inttostr(retourShell));
      Add;
      //Showmessage('Apr�s add : '+IntToStr(r));
//      Showmessage(IntToStr(j));
        //if( retourShell<=32)then abort;
        if ZipMaster1.Count <> CustomCopyFile.GetDirectoryCount(IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+
       IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i])) then
         begin
//         showmessage(Inttostr(ZipMaster1.ErrCode));
          abort;
         end;
      except
//       showmessage('error');
        raise;

//       Application.Terminate;
      end;
//       for j:=0 to ZipMaster1.ZipContents.Count -1 do
//        begin
//           NomFicControle:=PChar(ZipMaster1.ZipContents.Items[j]);
//            if FindFirst(NomFicControle,faAnyFile,F) = 0 then
//             if F.Attr <> faDirectory then
//              begin
//               if FileUnlock(F.FindHandle,F.Size, F.Size) <> 0 then
//                begin
//                 Showmessage('Un fichier est occup�, impossible de sauvegarder !');
//                 abort;
//                end;
//              end;
//
//
//    //       if CustomCopyFile.IsDirectoryInUse(ListedesRepertoireCourant.Strings[i]) then
//    //        begin
//        //     if ZipMaster1.f
//    //        end;
//        end;

      // section de recopie
//      inc(j);
//      Showmessage(IntToStr(j));
      ListLecteur.Clear;
//      inc(j);
//      Showmessage(IntToStr(j));
      ListLecteur:=ListTypeLecteur(DRIVE_REMOVABLE);
//      inc(j);
//      Showmessage(IntToStr(j));
//      showmessage('Nombre de ListLecteur : ' +inttostr(ListLecteur.Count));
//      showmessage(ListeRepertoireDEstination.Strings[i]);
//      showmessage(ExtractFileDrive(ListeRepertoireDEstination.Strings[i])+'\');
      if ListLecteur.IndexOf(ExtractFileDrive(ListeRepertoireDEstination.Strings[i])+'\') <> -1 then
       begin
//      inc(j);
//      Showmessage(IntToStr(j));

        MyBackup1.DrivePath :=ListeRepertoireDEstination.Strings[i];
//      inc(j);
//      Showmessage(IntToStr(j)+MyBackup1.DrivePath);
        MyBackup1.FilesPath :=RepertoireDEstinationTmp +'\';
//      inc(j);
//      Showmessage(IntToStr(j)+MyBackup1.FilesPath);
        MyBackup1.FilesToBackup.Clear;
//      inc(j);
//      Showmessage(IntToStr(j));
        MyBackup1.FilesToBackup.Add(ZipFilename);
//      inc(j);
//      Showmessage(IntToStr(j)+ZipFilename);
//      showmessage(ListeRepertoireDEstination.Strings[i][1]);
        While not MyBackup1.DiskInDrive(ListeRepertoireDEstination.Strings[i][1]) do
         begin
         if MessageDlg('Vous devez ins�rer une disquette dans le lecteur : '+ExtractFileDrive(ListeRepertoireDEstination.Strings[i]), mtWarning, [mbOK,mbCancel], 0) = mrCancel then
          begin
           break;
           abort;
          end;
         end;
        // showmessage('avant backup rep1');
        MyBackup1.Backup;
        
         //showmessage('apr�s backup rep1');
       end
      else
       begin
//        showmessage(ZipMaster1.ZipFilename);
//        Showmessage(ListeRepertoireDEstination.Strings[i]+'\'+NomFichierSauvegarde);
        if CopyAllFiles(ZipMaster1.ZipFilename,ListeRepertoireDEstination.Strings[i]+'\'+NomFichierSauvegarde,False) then
         else;
//        CopyFile(ListeRepertoireDEstination.Strings[i]+'\'+NomFichierSauvegarde,ZipMaster1.ZipFilename);
       end;
      if not str_Empty(ListeRepertoireDEstination2.Strings[i])then
       begin
       showmessage('repertoire 2 : '+ListeRepertoireDEstination2.Strings[i]);
        ListLecteur.Clear;
        ListLecteur:=ListTypeLecteur(DRIVE_REMOVABLE);
        if ListLecteur.IndexOf(ExtractFileDrive(ListeRepertoireDEstination2.Strings[i])+'\') <> -1 then
         begin
          MyBackup1.DrivePath :=ListeRepertoireDEstination2.Strings[i];
          MyBackup1.FilesPath :=RepertoireDEstinationTmp +'\';
//      inc(j);
//      Showmessage(IntToStr(j)+MyBackup1.DrivePath);
          MyBackup1.FilesToBackup.Clear;
          MyBackup1.FilesToBackup.Add(ZipFilename);
//      inc(j);
//      Showmessage(IntToStr(j)+'ZipFilename'+ZipFilename);
//      showmessage(ListeRepertoireDEstination2.Strings[i][1]);
          While not MyBackup1.DiskInDrive(ListeRepertoireDEstination2.Strings[i][1]) do
           begin
           if MessageDlg('Vous devez ins�rer une disquette dans le lecteur : '+ExtractFileDrive(ListeRepertoireDEstination2.Strings[i]), mtWarning, [mbOK,mbCancel], 0) = mrCancel then
            begin
             break;
             abort;
            end;
           end;
          showmessage('Avant Backup rep 2');
          MyBackup1.Backup;
          showmessage('apr�s Backup rep 2');
         end
        else
         begin
          if CopyAllFiles(ZipMaster1.ZipFilename,ListeRepertoireDEstination2.Strings[i]+'\'+NomFichierSauvegarde,False) then

           else;
//          CopyFile(ZipMaster1.ZipFilename,ListeRepertoireDEstination2.Strings[i]+'\'+NomFichierSauvegarde);
         end;
       end;

      if (ListeEMail<>nil)and(ListeEMail.Count>0)and (not str_Empty(ListeEMail.Strings[i])) then
       begin
        SendMail('Maintenance Epic�a-2 - '+ListeDesNomsdeDossier.Strings[i],
          'Ci-joint mon dossier : '+ListeDesNomsdeDossier.Strings[i]+' pour le programme Epic�a-2 Win',
          ListeRepertoireDEstination.Strings[i]+'\'+NomFichierSauvegarde,
          '',
          '',
          '',
          ListeEMail.Strings[i]);
       end;
      except
        raise;
      end;
   end; { end with }
//   ListeFic('*.*',RepertoireDEstinationTmp +'\'+IncludeTrailingPathDelimiter(NomFichierSauvegarde),faAnyFile,false,false);
//  if( retourShell<=32)then
  if ZipMaster1.Count <> CustomCopyFile.GetDirectoryCount(IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i])) then
   begin
    MessageDlg('Une erreur s''est produite lors de la tentative de sauvegarde !'+
                #10#13#10#13+
                ' Abandon de la Sauvegarde ! '+
                #10#13#10#13+
                IntToStr(ZipMaster1.Count)+
                ' Fichiers / '+
                IntToStr(CustomCopyFile.GetDirectoryCount(IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i])))+
  //              IntToStr(ListeFic('*.*',IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i]),faAnyFile,false,false).Count)+
                ' Fichiers.'+
                ' [ '+
                IntToStr(ZipMaster1.SuccessCnt)+
                ' ] '
                , mtError, [mbOK], 0)
  end
  else
   begin
  Animate1.Stop;
 // ShowMessage(cheminFichierlog);
  AjouterFichierTexte(cheminFichierlog,'Le '+Jour+'-'+Mois+'-'+DateInfos(now).AnStr+' � '+H+'-'+M+'-'+S+
    ', sauvegarde du Dossier : '+ListeDesNomsdeDossier.Strings[i]+#10+'Nom de la sauvegarde : '+
    ListeRepertoireDEstination.Strings[i]+'\'+NomFichierSauvegarde);
  ShowMessage('Sauvegarde Termin�e'+
              #10#13#10#13+
              IntToStr(ZipMaster1.Count)+
              ' Fichiers / '+
              IntToStr(CustomCopyFile.GetDirectoryCount(IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i])))+
//              IntToStr(ListeFic('*.*',IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i]),faAnyFile,false,false).Count)+
              ' Fichiers. '+
              ' [ '+
              IntToStr(ZipMaster1.SuccessCnt)+
              ' ] '+
              #10#13#10#13+
              'Vos donn�es ont �t� enregistr�es dans le fichier : '+ #10#13#10#13+ListeRepertoireDEstination.Strings[i]+'\'+NomFichierSauvegarde);
  end;
  self.Refresh;
  Animate1.Refresh;
end;
  ListeFichiers.free;
  ListeFichiersDossier.Free;
  CustomCopyFile.Free;
//  ShowMessage('Sauvegarde Termin�e'+#10#13#10#13+'Vos donn�es ont �t� enregistr�es dans le fichier : '+ #10#13#10#13+ZipMaster1.ZipFilename);
   if EnDll then
   ModalResult:=MROk
   else
   self.Close;

  except
           AjouterFichierTexte(RepDestination+'\GestSauvError'+NomSauvegarde+'.log',NomSauvegarde +';'+DateStr+';'+HeureAux+';'+ZipMaster1.ZipFilename+';');
           deleteFile(IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i]));
      Animate1.Stop;
      MessageDlg('Sauvegarde d�fectueuse !'+
                  #10#13#10#13+
                  IntToStr(ZipMaster1.Count)+
                  ' Fichiers / '+
                  IntToStr(CustomCopyFile.GetDirectoryCount(IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i])))+
    //              IntToStr(ListeFic('*.*',IncludeTrailingPathDelimiter(ListedesRepertoireCourant.Strings[i])+IncludeTrailingPathDelimiter(ListeFichiersDossier.Strings[i]),faAnyFile,false,false).Count)+
                  ' Fichiers.'+
                  ' [ '+
                  IntToStr(ZipMaster1.SuccessCnt)+
                  ' ] '+
                  #10#13#10#13+
                  ' Merci d''appeler le service de maintenance !'+
                  #10#13#10#13+
                  ' Pour recommencer la sauvegarde, sortez d''abord d''Epic�a ! '
                  , mtError, [mbOK], 0);
      MsgForm.Memo1.Lines.SaveToFile(ListeRepertoireDEstination.Strings[i]+'\'+NomFichierSauvegarde+'.txt');
      MsgForm.ShowModal;
  //         ShowMessage('Une erreur s''est produite lors de la tentative de sauvegarde !');
           ListeFichiers.free;
           ListeFichiersDossier.Free;
     if EnDll then
     ModalResult:=MRAbort
     else
     self.Close;
  end;
end;

procedure TSauv.Button2Click(Sender: TObject);
begin
 if EnDll then
 ModalResult:=MRAbort
 else
 self.Close;

//  Self.Close;
//  Application.Terminate;
end;

procedure TSauv.FormDestroy(Sender: TObject);
begin
screen.Cursor:=crDefault;
if DirectoryExists(RepertoireDEstinationTmp) then ClearDir(RepertoireDEstinationTmp,true);
// WM_FINSAUVEGARDE = WM_USER + 1998;
//MessageBoxExW()
//PostMessage(HandleEpi,WM_FINSAUVEGARDE,0,0);
//SendNotifyMessage(HandleEpi,WM_FINSAUVEGARDE,0,0);
//SendMessage(HandleEpi,WM_FINSAUVEGARDE,0,0)
Sauv := nil;
end;

procedure TSauv.FormCreate(Sender: TObject);
begin
//if EnDLL = false then
// begin
//  if ParamCount = 0 then
//   Begin
//   showmessage('Cette application ne peut �tre lanc�e qu''� partir d''Epic�a2 !');
//   Application.Terminate;
//   End;
// end;
//Application.OnMessage := AppMessage;
end;

procedure TSauv.ZipMaster2Message(Sender: TObject; ErrCode: Integer;
  Message: String);
begin
   try
      MsgForm.Memo1.Lines.Add(Message);
   except
      ShowMessage('Memo Plein - Mais la sauvegarde continue ...');
   end;
   if ErrCode > 0 then
      ShowMessage('Message d''erreur de la DLL: ' + Message);
//if 'could not open for reading' then
//
//showmessage(Message+' '+IntToStr(ZipMaster1.ErrCode));
end;

Procedure TSauv.AppMessage(var Msg:TAGMsg;var Handled:Boolean);
Begin
if Msg.message = WM_FINSAUVEGARDE then
 begin
  HandleEpi:=Msg.wParam;
  Showmessage('envoye d''�pic�a');
 end;
End;

procedure TSauv.FormShow(Sender: TObject);
begin
  if EnDLL = false then
   begin
    if ParamCount = 0 then
     Begin
     showmessage('Cette application ne peut �tre lanc�e qu''� partir d''Epic�a2 !');
     Self.Close;
//     Application.Terminate;
     End;
   end;
end;

end.
