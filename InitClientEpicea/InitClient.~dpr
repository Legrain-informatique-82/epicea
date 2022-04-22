program InitClient;

uses  Forms,
  windows,
  dialogs,
  sysUtils,
  Classes,
  InitUtilisateur in 'InitUtilisateur.pas',  DiversProjets in '..\..\LibrairieDev\Delphi\LibEpi\DiversProjets.pas';

{$E .exe}
{$R *.res}
var
nomVolume,numero:string;
cheminFichier,Retour:string;
Distribution:TDistribution;             //"C:\Program Files\Lgr\Epicea\InitClient.txt" V_Complete¤CL_Normal¤U_Comptable
//typeClient:TTypeClient;
//typeVersion:TTypeVersion;
//TypeUtilisateur:TTYpeUtilisateur;
//listetypeClient,listetypeVersion,listeTypeUtilisateur:String;
RetourChariotSimple:string;
listeRetour:TStringlist;
//Version,client,utilisateur:integer;
begin
  Application.Initialize;
  Application.Title := 'InitClient ';
  Application.Run;
  RetourChariotSimple:=#10#13;

  Initialise_TDistribution(distribution);


//  ListetypeClient:=TypeClientToStr(cl_inconnu)+' : '+inttostr(TypeClientToInt(cl_inconnu))+RetourChariotSimple+
//              TypeClientToStr(CL_Cogere)+' : '+inttostr(TypeClientToInt(CL_Cogere))+RetourChariotSimple+
//              TypeClientToStr(CL_Normal)+' : '+inttostr(TypeClientToInt(CL_Normal))+RetourChariotSimple+
//              TypeClientToStr(CL_Isa)+' : '+inttostr(TypeClientToInt(CL_Isa));
//
//  ListetypeVersion:=TypeVersionToStr(V_Inconnu)+' : '+inttostr(TypeVersionToInt(V_Inconnu))+RetourChariotSimple+
//               TypeVersionToStr(V_Complete)+' : '+inttostr(TypeVersionToInt(V_Complete))+RetourChariotSimple+
//               TypeVersionToStr(V_Saisie)+' : '+inttostr(TypeVersionToInt(V_Saisie))+RetourChariotSimple+
//               TypeVersionToStr(V_SSImmos)+' : '+inttostr(TypeVersionToInt(V_SSImmos))+RetourChariotSimple+
//               TypeVersionToStr(V_4)+' : '+inttostr(TypeVersionToInt(V_4));
//
//  ListeTypeUtilisateur:=TypeUtilisateurToStr(U_Inconnu)+' : '+inttostr(TypeUtilisateurToInt(U_Inconnu))+RetourChariotSimple+
//                   TypeUtilisateurToStr(U_Normal)+' : '+inttostr(TypeUtilisateurToInt(U_Normal))+RetourChariotSimple+
//                   TypeUtilisateurToStr(U_Demo)+' : '+inttostr(TypeUtilisateurToInt(U_Demo))+RetourChariotSimple+
//                   TypeUtilisateurToStr(U_Comptable)+' : '+inttostr(TypeUtilisateurToInt(U_Comptable))+RetourChariotSimple+
//                   TypeUtilisateurToStr(U_SuperComptable)+' : '+inttostr(TypeUtilisateurToInt(U_SuperComptable));

  if(ParamCount=2) then
  begin;
  cheminFichier:=ParamStr(1);
  listeRetour:=TStringList.create;
        ExtractStrings([','],[' '],PansiChar(ParamStr(2)),listeRetour);
        if(listeRetour.Count<3)then
        begin
             showmessage('Les paramètres ne sont pas complets.');
             exit;
        end;
        distribution.TypeVersion:=StrToTypeVersion(listeRetour.strings[0]);
        distribution.TypeClient:=StrToTypeClient(listeRetour.strings[1]);
        distribution.TypeUtilisateur:=StrToTypeUtilisateur(listeRetour.strings[2]);
  Application.Title := 'InitClient '+ParamStr(1)+'   '+ParamStr(2);
  //showmessage(ParamStr(1)+'   '+ParamStr(2));
  end
  else
    if(ParamCount=1) then
      begin
        if(ParamStr(1)='lgr')and (InputBox('Mot de passe','Indiquez le mot de passe','******')='lepelet')then
          begin
                Initialise_TDistribution(distribution);
                distribution.typeClient:=CL_Normal;
                distribution.typeVersion:=N4;
                distribution.TypeUtilisateur:=U_Normal;
                InitListeType(distribution) ;

//            typeClient:=CL_Normal;
//            typeVersion:=V_Complete;
//            TypeUtilisateur:=U_Normal;
//
//            Version:= TypeVersionToInt(typeVersion);
//            client:= TypeClientToInt(typeClient);
//            utilisateur:=TypeUtilisateurToInt(TypeUtilisateur);

            cheminFichier:=IncludeTrailingPathDelimiter(ExtractFileDir(application.ExeName))+'InitClient.txt';

//            typeVersion:= IntToTypeVersion(StrToIntDef(InputBox('Type de Version',ListetypeVersion,inttostr(Version)),0));
//            typeClient:=IntToTypeClient(StrToIntDef(InputBox('Type de client',ListetypeClient,inttostr(client)),0));
//            TypeUtilisateur:=IntToTypeUtilisateur(StrToIntDef(InputBox('Type d''utilisateur',ListeTypeUtilisateur,inttostr(utilisateur)),0));
          end;
      end
    else
        begin
          exit;
        end;
 // IncludeTrailingPathDelimiter(ExtractFileDrive(application.ExeName))
 if(distribution.typeClient<>cl_inconnu )and(distribution.typeVersion<>v_inconnu)
    and(distribution.TypeUtilisateur<>u_inconnu)then
 begin
      DisqueDur(ListTypeLecteur(DRIVE_FIXED).Strings[0],nomVolume,numero);
       //ouvrir le fichier, ecrire le type de client + le numéro du disque
      // puis, crypter le fichier
      Retour:=TypeVersionToStr(distribution.typeVersion)+','+ typeclienttostr(distribution.typeClient)+
        ','+typeUtilisateurtostr(distribution.TypeUtilisateur);
     // showmessage(Retour);
      modifFichierClient(cheminFichier,numero,Retour);
  end;

end.
