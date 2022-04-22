unit UDMFtp;

interface

uses
  SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient,Windows,
  //IdFTP,
  IdFTPList, Dialogs, Forms, Controls, ComCtrls, StdCtrls, LibFichRep,
  IdIntercept, IdLogBase, IdLogFile, IdAntiFreezeBase, IdAntiFreeze, StrUtils,
  IdFTP,IdFTPCommon;

type
  TInfosFtp = record
    nomDossier:string;
    RepSource:String;
    RepDest:String;
    Login:String;
    PassWord:String;
    Adresse:String;
    FichierParam:String;
    Effacer:string;
    Get:String;
  end;



  TDMFtp = class(TDataModule)
    IdFTP1: TIdFTP;
    procedure IdFTP1Disconnected(Sender: TObject);
    procedure IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure IdFTP1AfterClientLogin(Sender: TObject);
    procedure IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
  private
   { Déclarations privées }
  public
    { Déclarations publiques }
   end;

var
  DMFtp: TDMFtp;
  ControlRetourInfoEnCour:TWinControl;       //Fichier en cours (TStaticText)
  ControlRetourInfo:TWinControl;             //barre d'état  (TStatusBar)
  ControlRetourInfoNbFich:TWinControl;       //formulaire (TForm)
  ProgressBarFich,                           //Barre de progression du fichier en cours
  ProgressBar:TWinControl;                   //Barre de progression du total
  Fich : TSearchRec;
  Nbfich,                                    //nombre de fichier dans le répertoire source
  a_envoyer:integer;
  creation_rep:boolean;
  total_remote_file_size:int64;
     DMInfosFtp:TInfosFtp;                      //Paramètre pour l'envoi


  Function Init_InfosFtp(Var InfosFtp:TInfosFtp;defaut:boolean):Boolean;
  //initialise les informations reltives à la connexion
  //Si defaut=true tous les paramètres sont initialisés à partir du contenu du fichier
  //FTPparam.txt
  //1ère ligne : Répertoire source
  //2ème ligne : Répertoire destination
  //3ème ligne : Login
  //4ème ligne : PassWord
  //5ème ligne : Adresse du serveur FTP
  //6ème ligne : si 'o' ou 'O' supprime le contenu du repertoire destination avant le transfert

  Function Transfert_FTP (FTP:TIdFTP; Rep_Source,Rep_Dest:string;effacer:boolean=false):Integer;
  //copie les fichiers contenus dans rep_source dans le repertoire rep_dest du serveur FTP
  //est contenu dans ListeFich dans dossier
  //renvoi -1 en cas d'erreur

  Function Suppr_Fich (FTP:TIdFTP):Integer;
  //supprime les fichiers dans le repertoire courant

  Function Creer_Rep (FTP:TIdFTP; rep:string):Integer;
  //creer le repertoire rep dans le repertoire courant
  //rep devient le repertoire courant
  //Si le rep exixte déja rep devient le repertoire courant
  //renvoi -1 en cas d'erreur

  Function Liste_Rep (chemin:string):TStringList;
  //renvoi la liste des réperoire composant un chemin Unix (avec '/')

  Function Get_FTP (FTP:TIdFTP; Rep_Source,Rep_Dest:string;effacer:boolean=false):String;

  Function Changer_Rep (FTP:TIdFTP; rep:string):Integer;

  function RecupListFichier(FTP:TIdFTP;liste:Tstringlist;ParamEx:string;Details:boolean):boolean;

  Function Str_Count_Str(SubStr,Str:string):integer;

implementation

uses DiversProjets;

{$R *.dfm}
  Function Init_InfosFtp(Var InfosFtp:TInfosFtp;defaut:boolean):Boolean;
  //initialise les informations reltives à la connexion
  //Si defaut=true tous les paramètres sont initialisés à partir du contenu du fichier
  //FTPparam.txt
  //1ère ligne de FTPparam.txt : Répertoire source
  //2ème ligne de FTPparam.txt : Répertoire destination
  //3ème ligne de FTPparam.txt : Login
  //4ème ligne de FTPparam.txt : PassWord
  //5ème ligne de FTPparam.txt : Adresse du serveur FTP
  //6ème ligne : si 'o' ou 'O' supprime le contenu du repertoire destination avant le transfert
      var ListeParam:TStringList;
  begin
      ListeParam:=TStringList.Create;
      DMInfosFtp.FichierParam:=InfosFtp.FichierParam;
      if DMFtp = nil then DMFtp := TDMFtp.Create(nil);
      if defaut<>true then begin
          //initialisation à partir des paramètres de la ligne de commande
          if LastDelimiter('\',InfosFtp.RepSource)<>length(InfosFtp.RepSource) then
              InfosFtp.RepSource:=InfosFtp.RepSource+'\';
          DMInfosFtp.RepSource  :=InfosFtp.RepSource;
          DMInfosFtp.RepDest    :=InfosFtp.RepDest;
          DMInfosFtp.Effacer    :=InfosFtp.Effacer;
          DMInfosFtp.Get        := InfosFtp.Get;
          DMInfosFtp.FichierParam:=InfosFtp.FichierParam;
          if (InfosFtp.PassWord<>'') and (InfosFtp.Login<>'')
                                     and (InfosFtp.Adresse<>'') then begin
              //initialisation à partir de InfosFtp
              DMFtp.IdFTP1.Username := InfosFtp.Login;
              DMFtp.IdFTP1.Password := InfosFtp.PassWord;
              DMFtp.IdFTP1.Host     := InfosFtp.Adresse;
          end
          else begin
              //initialisation à partir du fichier InfosFtp.FichierParam
              try
//                  ListeParam.LoadFromFile(InfosFtp.FichierParam);
//                  DMFtp.IdFTP1.Username := ListeParam.Strings[0];
//                  DMFtp.IdFTP1.Password := ListeParam.Strings[1];
//                  DMFtp.IdFTP1.Host     := ListeParam.Strings[2];
                  ListeParam.LoadFromFile(InfosFtp.FichierParam);
              if ListeParam.Count < 6 then
                abort;
                  DMInfosFtp.RepSource   :=ListeParam.Strings[0];
                  DMInfosFtp.RepDest    := ListeParam.Strings[1];
                  DMFtp.IdFTP1.Username := ListeParam.Strings[2];
                  DMFtp.IdFTP1.Password := ListeParam.Strings[3];
                  DMFtp.IdFTP1.Host     := ListeParam.Strings[4];
                  DMInfosFtp.Effacer    := ListeParam.Strings[5];
                  DMInfosFtp.RepSource:=IncludeTrailingPathDelimiter(DMInfosFtp.RepSource);

                  except
                      showmessage('Impossible de trouver les paramètres dans le fichier : '
                                      + InfosFtp.FichierParam);
                      abort;
                  end;
          end;
      end
      else begin
      //paramètres par défaut dans le fichier FTPparam.txt
          try
              if ListeParam.Count < 6 then
                abort;
              //initialisation à partir du fichier FTPparam.txt
              ListeParam.LoadFromFile('FTPparam.txt');
              DMFtp.IdFTP1.Username := ListeParam.Strings[0];
              DMFtp.IdFTP1.Password := ListeParam.Strings[1];
              DMFtp.IdFTP1.Host     := ListeParam.Strings[2];
              DMInfosFtp.Effacer    := ListeParam.Strings[3];
              DMInfosFtp.RepSource  := ListeParam.Strings[4];
              DMInfosFtp.RepDest    := ListeParam.Strings[5];
              if LastDelimiter('\',ListeParam.Strings[5])<>length(ListeParam.Strings[5]) then
                  DMInfosFtp.RepDest:=ListeParam.Strings[5]+'\';

          except
              showmessage('Impossible de trouver les paramètres dans le fichier : '
                              + 'FTPparam.txt');
              abort;
          end;
      end;
      ListeParam.Free;
      DMInfosFtp.FichierParam:=InfosFtp.FichierParam;
      Init_InfosFtp:=true;
  end;

  Function Transfert_FTP (FTP:TIdFTP; Rep_Source,Rep_Dest:string;effacer:boolean=false):Integer;
  //copie les fichiers contenus dans rep_source dans le repertoire rep_dest du serveur FTP
  //est contenu dans ListeFich dans dossier
  //renvoi -1 en cas d'erreur
      var I,
          Res,                        //resultat de la fonction
          Nbfich,                     //nombre de fichier dans le répertoire source
          Retour : Integer;           //pour tester les valeurs de retour
      var ListeFich : TStringList;    //liste des fichiers à envoyer
      var Chemin_Source : string;     //Chemin complet de fichiers à envoyer
  begin
      FTP.Noop;
      Res:=0;

      Retour:=Creer_Rep(FTP,Rep_Dest);
     // if(effacer) then//suppression des fichiers du répertoire courant
     //   Suppr_Fich(FTP);
      if Retour<>-1 then begin
        if FileExists(AnsiLeftStr(Rep_Source,Length(Rep_Source)-1)) then begin
          //transfert d'un fichier
           try
           if(DMInfosFtp.Effacer='o') then
                Suppr_Fich(FTP);
           except
           end;
          rep_source := AnsiLeftStr(Rep_Source,Length(Rep_Source)-1);  // suppression du dernier anti slash
          (ProgressBar as TProgressBar).Max:=1;
          (ProgressBar as TProgressBar).Step:=1;
          (ControlRetourInfoNbFich as TForm).Caption :='0 fichier(s) envoyé(s) sur '+inttostr(1);
          chemin_source:=rep_source;
          
          (ControlRetourInfoEnCour as TStaticText).Caption:=rep_source;
          ftp.Put(chemin_source,ExtractFileName(rep_source));
          (ProgressBar as TProgressBar).StepIt;
          (ControlRetourInfoNbFich as TForm).Caption :=
          inttostr(1)+' fichier(s) envoyé(s) sur '+inttostr(1);
          (ControlRetourInfoEnCour as TStaticText).Caption:='';
          ShowMessage('Transfert terminé');
        end
        else if DirectoryExists(Rep_Source) then begin
          //transfert d'un repertoire
          ListeFich:=TStringList.Create;
          ListeFich:=ListeFic('*.*',Rep_Source,faAnyFile,false,false);

          if Retour<>-1 then begin
            //le répertoire destination est correct
            if(DMInfosFtp.Effacer<>'o') then
            //if (DMInfosFtp.Effacer='o') or (DMInfosFtp.Effacer='O') then
                //suppression avant transfert
               try
                Suppr_Fich(FTP);
               except
               end;
            Nbfich:=ListeFich.Count-1;
            if Nbfich>1 then begin
                //i y a au moins un fichier à tranférer
                (ProgressBar as TProgressBar).Max:=Nbfich-1;
                (ProgressBar as TProgressBar).Step:=1;
                (ControlRetourInfoNbFich as TForm).Caption :='0 fichier(s) envoyé(s) sur '+inttostr(Nbfich-1);
                for I:=2 to Nbfich do begin
                  //transfert des fichiers
                  chemin_source:=rep_source+ListeFich.Strings[i];
                  (ControlRetourInfoEnCour as TStaticText).Caption:=ListeFich.Strings[i];
                  ftp.Put(chemin_source,ListeFich.Strings[i]);
                  (ProgressBar as TProgressBar).StepIt;
                  (ControlRetourInfoNbFich as TForm).Caption :=
                  inttostr(I-1)+' fichier(s) envoyé(s) sur '+inttostr(Nbfich-1);
                end;
                (ControlRetourInfoEnCour as TStaticText).Caption:='';
                ShowMessage('Transfert terminé');
            end
            else
              //Aucun fichier trouvé dans le répertoire source
              (ControlRetourInfoEnCour as TStaticText).Caption:='Aucun fichier trouvé';
          end // fin Retour<>-1
        end  //fin if dossier
      end
      else
          //erreur : répertoire destination incorrect
          Res:=-1;

      ListeFich.Free;
      Transfert_FTP:=res;
  end;

  Function Get_FTP (FTP:TIdFTP; Rep_Source,Rep_Dest:string;effacer:boolean=false):String;
  //copie les fichiers contenus dans rep_source dans le repertoire rep_dest sur la machine locale
  //renvoi -1 en cas d'erreur
      var I,J,
          Res,                        //resultat de la fonction
          Nbfich,                     //nombre de fichier dans le répertoire source
          Retour,nb : Integer;           //pour tester les valeurs de retour
      //var ListeFich : TStringList;    //liste des fichiers à envoyer
      var Chemin_Source : string;     //Chemin complet de fichiers à envoyer
      var ListeFichierFTP : TStringList;  //liste des fichiers contenu dans le repertoire courant du ftp
      termine:boolean;
  begin
      FTP.Noop;
      Res:=0;
      termine:=true;
        //result:=Rep_Source;
        //changer de répertoire sur le ftp
        while(Str_Count_Str('.',Rep_Dest)>0)do
          Rep_Dest:=ExtractFileDir(Rep_Dest);

        if((DirectoryExists(Rep_Dest))or(CreateDir(Rep_Dest)))then
        begin
        Changer_Rep(FTP,Rep_Source);
        //recup du contenu du répertoire
        ListeFichierFTP:=TStringList.Create;
        RecupListFichier(ftp,ListeFichierFTP,'*.*',false);
        //FTP.List(ListeFichierFTP,'*.*',false);
        Nbfich:=ListeFichierFTP.Count-1;
        if Nbfich>=0 then begin
          (ProgressBar as TProgressBar).Max:=Nbfich+1;
          (ProgressBar as TProgressBar).Step:=1;
          (ControlRetourInfoNbFich as TForm).Caption := inttostr(I+1)+' fichier(s) reçu(s) sur '+inttostr(Nbfich+1);
          nb:=0 ;
          for I:=0 to Nbfich do begin
              (ControlRetourInfoEnCour as TStaticText).Caption:=ListeFichierFTP.Strings[i];
              //total_remote_file_size := TIdFTPListItem(ListeFichierFTP[i]).Size;
              FTP.TransferType:=ftBinary;
              total_remote_file_size := FTP.Size(ListeFichierFTP.Strings[i]);
              try
              //showmessage('repDestEnvoie : '+Rep_Dest);
              FTP.Get(ListeFichierFTP.Strings[i],Rep_Dest+ListeFichierFTP.Strings[i]);
              result:=ListeFichierFTP.Strings[i];
              inc(nb);
              except
                  if Application.MessageBox(Pchar('La sauvegarde "'+ListeFichierFTP.Strings[i]+'" que vous souhaitez télécharger est déjà sur votre ordinateur.'+
                  #10#13+' Souhaitez vous la restaurer ?'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes then
                    result:=ListeFichierFTP.Strings[i]
                  else result:='';
                  termine:=false;
              end;
              (ProgressBar as TProgressBar).StepIt;
              (ControlRetourInfoNbFich as TForm).Caption :=
              inttostr(nb)+' fichier(s) reçu(s) sur '+inttostr(Nbfich+1);
              total_remote_file_size := 0;
          end;
          (ControlRetourInfoEnCour as TStaticText).Caption:='';
          if (termine)then ShowMessage('Transfert terminé');
          application.Terminate;
          //else ShowMessage('Vous pouvez "Quitter"');
        end
        else
          begin
          //Aucun fichier trouvé dans le répertoire source
          (ControlRetourInfoEnCour as TStaticText).Caption:='Aucun fichier trouvé';
           ShowMessage('Aucun fichier trouvé');
          end;
        end
        else
          showmessage('Répertoire non existant : '+Rep_Dest);
        ListeFichierFTP.Free;
  end;


Function Str_Count_Str(SubStr,Str:string):integer;
// Compte combien  de fois existe SubStr dans Str
var
i:integer;
Begin
  try
    result:=0;
//    i:=0;
//    while(i<Length(Str)-1)do
//    begin
//       if(str[i]=substr)then
//         begin
//           inc(result);
//           delete(str,i,length(SubStr));
//           i:=0;
//         end
//         else inc(i);
//    end;

    While pos(SubStr,Str) > 0 do
     begin
       inc(result);
       delete(Str,pos(SubStr,Str),length(SubStr));
     end;
  except;
   result:=0;
  end;
End;


  Function Suppr_Fich (FTP:TIdFTP):Integer;
  //supprime les fichiers dans le repertoire actuel
      var ListeFTP, ListeRep,ListeFichier : TStringList;  //liste des fichiers contenu dans le repertoire courant
      var I,Nbfich : Integer;     //nombre de fichiers dans le répertoire courant
      fichier,Rep,RepInitial:string;
  begin
      try
      ListeFTP:=TStringList.Create;
      ListeRep:=TStringList.Create;
      ListeFichier:=TStringList.Create;
      //suppression des fichier

      RecupListFichier(ftp,listeFTP,'*.*',false);
      //FTP.List(listeFTP,'*.*',false);


      if ListeFTP.Count>0 then begin
          Nbfich:=ListeFTP.Count-1;
          for I:=0 to Nbfich do begin
              try
              //suppresion
              FTP.Delete(listeFTP.Strings[i]);
              except
              end;
          end;
      end;
      //suppression des repertoires

      RecupListFichier(ftp,ListeFichier,'',false);
      RepInitial:=ftp.RetrieveCurrentDir;
      while  ListeFichier.Count>0 do
        begin
          Nbfich:=0;
          rep:=ftp.RetrieveCurrentDir;
            while Nbfich <= ListeFichier.Count-1 do
              begin
                  if ExtractFileExt(ListeFichier.Strings[Nbfich])<>'' then
                    begin
                      ftp.delete(ListeFichier.Strings[Nbfich]);
                      rep:=ftp.RetrieveCurrentDir;
                    end
                  else
                     begin
                       ftp.ChangeDir(ListeFichier.Strings[Nbfich]);
                       if not RecupListFichier(ftp,ListeFichier,'',false) then
                         begin
                           if not RecupListFichier(ftp,ListeFichier,'*',false)then
                             begin
                                 rep:=ftp.RetrieveCurrentDir;
                                 ftp.ChangeDirUp;
                                 ftp.RemoveDir(rep);
                                 if not RecupListFichier(ftp,ListeFichier,'',false) then
                                     RecupListFichier(ftp,ListeFichier,'*',false);
                             end;
                         end;
                       Nbfich:=ListeFichier.Count-1;
                     end;
                 inc(Nbfich);
              end;
//              if rep=ftp.RetrieveCurrentDir then
//                begin
                  while (ftp.RetrieveCurrentDir<>RepInitial)
                    and(not RecupListFichier(ftp,ListeFichier,'',false))
                      and(not RecupListFichier(ftp,ListeFichier,'*',false)) do
                    begin
                      rep:=ftp.RetrieveCurrentDir;
                      ftp.ChangeDirUp;
                      ftp.RemoveDir(rep);
                    end;
                  rep:=ftp.RetrieveCurrentDir;
                  RecupListFichier(ftp,ListeFichier,'',false);
//                end;
        end;
        ftp.ChangeDir(RepInitial);

 except
 end;
      ListeFTP.Free;
      ListeRep.Free;
      Suppr_Fich:=0;
  end;

  Function Liste_Rep (chemin:string) : TStringList;
  //renvoi la liste des réperoire composant un chemin Unix (avec '/')
      var longueur,         //longueur totale du chemin
          position,         //position actuelle dans le traitement
          dernier:integer;  //position du dernier '/'
      var rep:string;       //repertoire à ajouter à la liste
      var e : string;
  begin
      Liste_Rep:=TStringList.Create;
      longueur:=length(chemin);
     // if (chemin='/') or (StrComp(PChar(chemin),PChar('//'))<>0) then begin
     //   Liste_Rep.Add(chemin);
     // end
    //  else begin
        if chemin[1]='/' then begin
          //le chemin commence par '/'
          position:=2;
          dernier:=1;
        end
        else begin
          position:=1;
          dernier:=0;
        end;
        while position<=longueur do begin
          if chemin[position]<>'/' then
              position:=position+1
          else begin
              //ajout du répertoire à la liste
              rep:=copy(chemin,dernier+1,position-dernier);
              dernier:=position;
              Liste_Rep.Add(rep);
              position:=position+1;
          end;
        end;
     // end;
  end;

  Function Creer_Rep (FTP:TIdFTP; rep:string):Integer;
  //creer le repertoire rep dans le repertoire courant
  //rep devient le repertoire courant
  //Si le rep exixte déja rep devient le repertoire courant
  //renvoi -1 en cas d'erreur
      var ListeRep : TStringList;      //liste des répertoires du repertoire courant
      var  i  : Integer;
      slash:string;
  begin
      Creer_Rep:=0;
      slash:='/';
      if (AnsiCompareText(PChar(rep),PChar(''))<>0) and (AnsiCompareText(PChar(rep),PChar(slash))<>0) then begin
        ListeRep:=TStringList.Create;

        if LastDelimiter('/',rep)<>length(rep) then
          rep:=rep+'/';

        ListeRep.AddStrings(Liste_Rep(rep));
        for i:=0 to ListeRep.Count-1 do begin
          try
            FTP.ChangeDir(ListeRep[i]);
          except
            //le repertoire existe pas donc il faut le créer
            FTP.MakeDir(ListeRep[i]);
            FTP.ChangeDir(ListeRep[i]);
          end;
        end;

        if FTP.LastCmdResult.NumericCode<>250 then
          //erreur : le répertoire n'a pas été créer ou impossible d'y accéder
          Creer_Rep:=-1;
        ListeRep.Free;
      end;
  end;

  Function Changer_Rep (FTP:TIdFTP; rep:string):Integer;
  //rep devient le repertoire courant sur le serveur ftp
  //renvoi -1 en cas d'erreur
      var ListeRep : TStringList;      //liste des répertoires du repertoire courant
      var  i  : Integer;
       slash:string;
  begin
      Changer_Rep:=0;
      slash:='/';
      if (AnsiCompareText(PChar(rep),PChar(''))<>0) and (AnsiCompareText(PChar(rep),PChar(slash))<>0) then begin

        ListeRep:=TStringList.Create;

        if LastDelimiter('/',rep)<>length(rep) then
          rep:=rep+'/';

        ListeRep.AddStrings(Liste_Rep(rep));
        for i:=0 to ListeRep.Count-1 do begin
            FTP.ChangeDir(ListeRep[i]);
        end;

        if FTP.LastCmdResult.NumericCode<>250 then
          //erreur : le répertoire n'a pas été créer ou impossible d'y accéder
          Changer_Rep:=-1;
        ListeRep.Free;
      end;
  end;

  procedure TDMFtp.IdFTP1Disconnected(Sender: TObject);
  begin
      try
          DMFtp.IdFTP1.CheckForDisconnect();
      except
          showmessage('La connexion a été interrompue');
      end;
  end;

  procedure TDMFtp.IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;const AStatusText: String);
      //Mise à jours de la barre d'état
  begin
      if ControlRetourInfo <> nil then begin
         (ControlRetourInfo as TStatusBar).SimplePanel:=true;
         (ControlRetourInfo as TStatusBar).SimpleText := AStatusText;
      end;
  end;

  procedure TDMFtp.IdFTP1AfterClientLogin(Sender: TObject);
      //debut du transfert
      var tmp:string;
      text:TextFile;
      paramFtp:TParamFTP;
  begin
      if not creation_rep then begin
        if DMInfosFtp.Get='o' then begin
          tmp := DMInfosFtp.RepDest;
          DMInfosFtp.RepDest := DMInfosFtp.RepSource;
          DMInfosFtp.RepSource := tmp;
//          showmessage('RepSource : '+DMInfosFtp.RepSource);
//          showmessage('RepDest : '+DMInfosFtp.RepDest);
          DMInfosFtp.RepSource:=Get_FTP(DMFtp.IdFTP1,DMInfosFtp.RepSource,DMInfosFtp.RepDest);
        end
        else begin
          Transfert_FTP(DMFtp.IdFTP1,DMInfosFtp.RepSource,DMInfosFtp.RepDest);
        end;
      end;
      if(FileExists(DMInfosFtp.FichierParam)and
        (FileExists(IncludeTrailingPathDelimiter(ExtractFileDir(DMInfosFtp.RepDest))+DMInfosFtp.RepSource)))then
      begin
            //showmessage('file existe : '+IncludeTrailingPathDelimiter(ExtractFileDir(DMInfosFtp.RepDest))+DMInfosFtp.RepSource);
          LitFichierParamFTP(DMInfosFtp.FichierParam,paramFtp,false,'','',paramFtp,PathDelim);
          paramFtp.Source:=IncludeTrailingPathDelimiter(ExtractFileDir(DMInfosFtp.RepDest))+DMInfosFtp.RepSource;
          paramFtp.Fichier:=DMInfosFtp.FichierParam;
          EcritFichierParamFTP(paramFtp,paramFtp);
      end;

      //showmessage('RepSource après : '+IncludeTrailingPathDelimiter(ExtractFileDir(DMInfosFtp.RepDest))+DMInfosFtp.RepSource);


  end;

  //Avancement de la barre de progression pour le fichier en cours
  procedure TDMFtp.IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
  var x:integer;
  begin
      if (total_remote_file_size<>0) then begin
        (ProgressBarFich as TProgressBar).Max:=total_remote_file_size;
      end else begin
        (ProgressBarFich as TProgressBar).Max:=AWorkCountMax;
      end;
      (ProgressBarFich as TProgressBar).Position:=0;
  end;

  procedure TDMFtp.IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
  begin
      (ProgressBarFich as TProgressBar).Position:=AWorkCount;
  end;


  function RecupListFichier(FTP:TIdFTP;liste:Tstringlist;ParamEx:string;Details:boolean):boolean;
  begin
    try
     liste.Clear;
     FTP.List(liste,ParamEx,Details);
     result:=true;
    except
      result:=false;
    end;
  end;
end.



