unit DmGestionVersions;

interface

uses
  SysUtils, Classes, DBTables, DB, LibSQL,Windows,Controls,Dialogs,DiversProjets, E2_Decl_Records,Forms, ListeModules,
  TaAutorisationsService5, InvokeRegistry, Rio, SOAPHTTPClient,TStringlistLGR;


type
  TDMGestVersion = class(TDataModule)
    TaGestVersion: TTable;
    QuGestionVersion: TQuery;
    QuAutorisation: TQuery;
    TaAutorisation: TTable;

    procedure DMGestVersionCreate(Sender: TObject);
    procedure DMGestVersionDestroy(Sender: TObject);
    procedure EcritAutorisationDansDossierLocal();

  private
    { Déclarations privées }
  public
    { Déclarations publiques }



  end;

   function RecupListeMenuTroncCommun():TStringList;
  function RecupListeMenuTous():TStringList;
  function RecupListeExclusion(Menu:String):TStringList;
  function RecupListeInclusion(Menu:String):TStringList;
  function RecupListeMenu_Exclusion(Exclusion:String):TStringList;
  function RecupListeMenu_Inclusion(Inclusion:String):TStringList;
  function RecupListeInclusionMenu_Type(TypeDistribution:TDistribution):TStringList;
  function RecupListeExclusionMenu_Type(TypeDistribution:TDistribution):TStringList;

  function RecupAutorisation():TListeModuleLGR;
  function RecupAutorisationWs():TListeModuleLGR;


 // procedure DisqueDur(Disque : String ; Var NomVolume, NumSerie : String) ;
var
  DMGestVersion: TDMGestVersion;


   

implementation

uses Gr_Librairie_Obj, DMConstantes, LibFichRep, 
  E2_Librairie_Obj;


{$R *.dfm}


procedure TDMGestVersion.DMGestVersionCreate(Sender: TObject);
begin
  OuvrirTouteTable('',Tcontrol(self));
  Initialise_ExceptLGR(ErreurSaisie);
end;

procedure TDMGestVersion.DMGestVersionDestroy(Sender: TObject);
begin
  FermerTouteTable('',TControl(self));
  DMConst:=nil;
end;


function RecupListeMenuTous():TStringList;
var
i,j:integer;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);
   DMGestVersion.QuGestionVersion.Close;
   DMGestVersion.QuGestionVersion.SQL.Clear;
   DMGestVersion.QuGestionVersion.SQL.Add(' select menu from GestVersion G ');
   DMGestVersion.QuGestionVersion.SQL.Add(' order by menu ');
   DMGestVersion.QuGestionVersion.Prepare;
   DMGestVersion.QuGestionVersion.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListeEx(['menu'],DMGestVersion.QuGestionVersion,';',false,false);
   DMGestVersion.QuGestionVersion.Close;
//   if Result.Count=0 then
//    raise ExceptLGR.Create('Erreur à la récupération de : RecupListeMenuTous',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

function RecupListeMenuTroncCommun():TStringList;
var
i,j:integer;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);
   DMGestVersion.QuGestionVersion.Close;
   DMGestVersion.QuGestionVersion.SQL.Clear;
   DMGestVersion.QuGestionVersion.SQL.Add(' select menu from GestVersion G ');
      DMGestVersion.QuGestionVersion.SQL.Add(' where upper(ex_typeClient) <>''V'' ');
   DMGestVersion.QuGestionVersion.SQL.Add(' order by menu ');
   DMGestVersion.QuGestionVersion.Prepare;
   DMGestVersion.QuGestionVersion.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListeEx(['menu'],DMGestVersion.QuGestionVersion,';',false,false);
   DMGestVersion.QuGestionVersion.Close;
//   if Result.Count=0 then
//    raise ExceptLGR.Create('Erreur à la récupération de : RecupListeMenuTous',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

function RecupListeExclusion(Menu:String):TStringList;
var
i,j:integer;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);
   DMGestVersion.QuGestionVersion.Close;
   DMGestVersion.QuGestionVersion.SQL.Clear;

   DMGestVersion.QuGestionVersion.SQL.Add(' select menu from GestVersion G ');
   DMGestVersion.QuGestionVersion.SQL.Add(' where upper(exclusion) like ''%'+ UpperCase(Menu)+';%''');
   DMGestVersion.QuGestionVersion.SQL.Add(' order by menu ');
   DMGestVersion.QuGestionVersion.Prepare;
   DMGestVersion.QuGestionVersion.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListeEx(['menu'],DMGestVersion.QuGestionVersion,';',false,false);
   DMGestVersion.QuGestionVersion.Close;
//   if Result.Count=0 then
//    raise ExceptLGR.Create('Erreur à la récupération de : RecupListeExclusion',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;


function RecupListeInclusion(Menu:String):TStringList;
var
i,j:integer;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);
   DMGestVersion.QuGestionVersion.Close;
   DMGestVersion.QuGestionVersion.SQL.Clear;

   DMGestVersion.QuGestionVersion.SQL.Add(' select menu  from GestVersion G ');
   DMGestVersion.QuGestionVersion.SQL.Add(' where upper(inclusion) like ''%'+ UpperCase(Menu)+';%''');
   DMGestVersion.QuGestionVersion.SQL.Add(' order by menu ');
   DMGestVersion.QuGestionVersion.Prepare;
   DMGestVersion.QuGestionVersion.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListeEx(['menu'],DMGestVersion.QuGestionVersion,';',false,false);
   DMGestVersion.QuGestionVersion.Close;
//   if Result.Count=0 then
//    raise ExceptLGR.Create('Erreur à la récupération de : RecupListeInclusion',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

function RecupListeMenu_Exclusion(Exclusion:String):TStringList;
var
i,j:integer;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);
   DMGestVersion.QuGestionVersion.Close;
   DMGestVersion.QuGestionVersion.SQL.Clear;

   DMGestVersion.QuGestionVersion.SQL.Add(' select menu from GestVersion G ');
   DMGestVersion.QuGestionVersion.SQL.Add(' where upper(exclusion) like ''%'+ UpperCase(Exclusion)+';%''');
   DMGestVersion.QuGestionVersion.SQL.Add(' order by menu ');
   DMGestVersion.QuGestionVersion.Prepare;
   DMGestVersion.QuGestionVersion.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListeEx(['menu'],DMGestVersion.QuGestionVersion,';',false,false);
   DMGestVersion.QuGestionVersion.Close;
//   if Result.Count=0 then
//    raise ExceptLGR.Create('Erreur à la récupération de : RecupListeMenu_Exclusion',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;


function RecupListeMenu_Inclusion(Inclusion:String):TStringList;
var
i,j:integer;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);
   DMGestVersion.QuGestionVersion.Close;
   DMGestVersion.QuGestionVersion.SQL.Clear;

   DMGestVersion.QuGestionVersion.SQL.Add(' select menu from GestVersion G ');
   DMGestVersion.QuGestionVersion.SQL.Add(' where upper(Inclusion) like ''%'+ UpperCase(Inclusion)+';%''');
   DMGestVersion.QuGestionVersion.SQL.Add(' order by menu ');
   DMGestVersion.QuGestionVersion.Prepare;
   DMGestVersion.QuGestionVersion.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListeEx(['menu'],DMGestVersion.QuGestionVersion,';',false,false);
   DMGestVersion.QuGestionVersion.Close;
//   if Result.Count=0 then
//    raise ExceptLGR.Create('Erreur à la récupération de : RecupListeMenu_Inclusion',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

function RecupListeExclusionMenu_Type(TypeDistribution:TDistribution):TStringList;
var
i,j:integer;
version,client,utilisateur,typeDossier:string;
nouvelleAutorisation:boolean;
or_:string;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);

   version:=TypeVersionToStr(TypeDistribution.TypeVersion);
   client:=TypeClientToStr(TypeDistribution.TypeClient);
   utilisateur:=TypeUtilisateurToStr(TypeDistribution.TypeUtilisateur);
   typeDossier:=TypeDossierToStr(TypeDistribution.TypeDossier);

   DMGestVersion.QuGestionVersion.Close;
   DMGestVersion.QuGestionVersion.SQL.Clear;
   nouvelleAutorisation:=FileExists(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'autorisation.db');
   // select Menu from GestVersion G
 //where upper(inclusion_type) like '%N%;%'
//or upper(exclusion_type) like '%N%;%'
  //order by Menu

   DMGestVersion.QuGestionVersion.SQL.Add(' select Menu from GestVersion G where');

   //si on travail sur nouvelle autorisation, le type client et le niveau de la version ne sont plus nécessaire
   if(nouvelleAutorisation=false)then
     begin
      DMGestVersion.QuGestionVersion.SQL.Add(' upper(exclusion_type) like ''%'+ UpperCase(Client)+';%''');
      or_:='or';
     end;
   if(nouvelleAutorisation=false) then
     begin
      DMGestVersion.QuGestionVersion.SQL.Add(or_+'  upper(exclusion_type) like ''%'+ UpperCase(version)+';%''');
      or_:='or';
     end;
      
   DMGestVersion.QuGestionVersion.SQL.Add(or_+' upper(exclusion_type) like ''%'+ UpperCase(utilisateur)+';%''');
   DMGestVersion.QuGestionVersion.SQL.Add(' or upper(exclusion_type) like ''%'+ UpperCase(typeDossier)+';%''');
   DMGestVersion.QuGestionVersion.SQL.Add(' order by Menu ');
   DMGestVersion.QuGestionVersion.Prepare;
   DMGestVersion.QuGestionVersion.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListeEx(['Menu'],DMGestVersion.QuGestionVersion,';',false,false);
   DMGestVersion.QuGestionVersion.Close;
//   if Result.Count=0 then
//    raise ExceptLGR.Create('Erreur à la récupération de : RecupListeExclusionMenu_Type',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

function RecupListeInclusionMenu_Type(TypeDistribution:TDistribution):TStringList;
var
i,j:integer;
version,client,utilisateur,typeDossier:string;
nouvelleAutorisation:boolean;
or_:string;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);
   DMGestVersion.QuGestionVersion.Close;
   DMGestVersion.QuGestionVersion.SQL.Clear;

   version:=TypeVersionToStr(TypeDistribution.TypeVersion);
   client:=TypeClientToStr(TypeDistribution.TypeClient);
   utilisateur:=TypeUtilisateurToStr(TypeDistribution.TypeUtilisateur);
   typeDossier:=TypeDossierToStr(TypeDistribution.TypeDossier);

   nouvelleAutorisation:=FileExists(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'autorisation.db');


   DMGestVersion.QuGestionVersion.SQL.Add(' select Menu from GestVersion G where ');
      //si on travail sur nouvelle autorisation, le type client et le niveau de la version ne sont plus nécessaire
   if(nouvelleAutorisation=false)then
     begin
       DMGestVersion.QuGestionVersion.SQL.Add(' upper(inclusion_type) like ''%'+ UpperCase(Client)+';%''');
        or_:='or';
     end;
   if(nouvelleAutorisation=false)then
     begin
        DMGestVersion.QuGestionVersion.SQL.Add(or_+' upper(inclusion_type) like ''%'+ UpperCase(version)+';%''');
        or_:='or';
     end;
   DMGestVersion.QuGestionVersion.SQL.Add(or_+' upper(inclusion_type) like ''%'+ UpperCase(utilisateur)+';%''');
      DMGestVersion.QuGestionVersion.SQL.Add(' or upper(inclusion_type) like ''%'+ UpperCase(typeDossier)+';%''');
   DMGestVersion.QuGestionVersion.SQL.Add(' order by Menu ');
   DMGestVersion.QuGestionVersion.Prepare;
   DMGestVersion.QuGestionVersion.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListeEx(['Menu'],DMGestVersion.QuGestionVersion,';',false,false);
   DMGestVersion.QuGestionVersion.Close;
//   if Result.Count=0 then
//    raise ExceptLGR.Create('Erreur à la récupération de : RecupListeInclusionMenu_Type',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;



//procedure DisqueDur(Disque : String ; Var NomVolume, NumSerie : String) ;
//{ Récupération des caractéristiques du disque dur }
//{     Entrée  : Disque  ===>  C:\                 }
//{     Sortie  : NomVolume : Label du disque       }
//{               NumSerie  : Numéro de série       }
//
//Var
//    VolumeName         : Array [0..MAX_PATH-1] of Char ;
//    FileSystemName     : Array [0..MAX_PATH-1] of Char ;
//    VolumeSerialNo     : DWord ;
//    MaxComponentLength : Dword ;
//    FileSystemFlags    : Dword ;
//begin
//      GetVolumeInformation(PChar(Disque),VolumeName,MAX_PATH,@VolumeSerialNo,
//                         MaxComponentLength,FileSystemFlags,
//                         FileSystemName,MAX_PATH) ;
//    NomVolume := VolumeName ;
//    NumSerie  := IntToHex(HiWord(VolumeSerialNo),4)+'-'+
//                 IntToHex(LoWord(VolumeSerialNo),4);
//end;



function RecupAutorisation():TListeModuleLGR;
var
listeModule:TListeModuleLGR;
Begin
  try
   if (DMGestVersion = nil) then DMGestVersion:=TDMGestVersion.Create(Application.MainForm);
   DMGestVersion.QuAutorisation.Close;
   DMGestVersion.QuAutorisation.DatabaseName:=DM_C_NomAliasDossier;
   DMGestVersion.QuAutorisation.SQL.Clear;

   DMGestVersion.QuAutorisation.SQL.Add(' select a.fichier,a.date_der_synchro from autorisation a ');
   DMGestVersion.QuAutorisation.Prepare;
   DMGestVersion.QuAutorisation.Open;
   DMGestVersion.QuAutorisation.First;
   listeModule:=TListeModuleLGR.Create;
   if(DMGestVersion.QuAutorisation.RecordCount<>0)then
   begin 
       listeModule.fichier:=DMGestVersion.QuAutorisation.findfield('fichier').AsString;
       listeModule.dateDerValidation:=DMGestVersion.QuAutorisation.findfield('date_der_synchro').AsDateTime;
   end
   else
   begin
       // il n'y a pas d'autorisations pour ce dossier
       ShowMessage('Il n''y a pas d''autorisation pour ce dossier');
   end;

   DMGestVersion.QuAutorisation.Close;
   result:= listeModule;
  except
     abort;
  end;
End;


function RecupAutorisationWs():TListeModuleLGR;
var
listeModule:TListeModuleLGR;
autorisationService:TaAutorisationsService;
parametre:findByDossierTypeProduit;
reponse:findByDossierTypeProduitResponse;
ddd:modules;
i,l:integer;
retour:TListeModuleLGR;
Begin
  try
  retour:=TListeModuleLGR.Create;
  autorisationService:=GetTaAutorisationsService();
  parametre :=findByDossierTypeProduit.Create;
  parametre.arg0:=e.NomDossier;
  parametre.arg1:=3;
  reponse:=findByDossierTypeProduitResponse.Create;
  reponse:=autorisationService.findByDossierTypeProduit(parametre);

ddd:=reponse.return.modules;
l:=Length(ddd);
retour.dateDerValidation:=now;
for i:=0 to l-1 do
begin
      retour.listeModule.Add(ddd[i].nom);
end;
   result:= retour;

  except
     abort;
  end;
End;

procedure TDMGestVersion.EcritAutorisationDansDossierLocal();
var
liste:TListeModuleLGR;
insert:boolean;
begin
  try
   insert:=true;
//              QuAutorisation.Database.TransIsolation:=tiDirtyRead;
//              QuAutorisation.Database.StartTransaction;

   liste:=RecupAutorisationWs();
  Liste.fichier:=liste.ReturnFichierAutorisationsServeur(liste.listeModule);
  TableGereOpen(TaAutorisation);
  insert:=TaAutorisation.RecordCount=0;
  if(insert)then
  begin
     TableGereInsert(TaAutorisation);
     TaAutorisation.FindField('fichier').AsString:=Liste.fichier;
      TaAutorisation.FindField('date_der_synchro').AsDateTime:=Liste.dateDerValidation;
      TableGerePost(TaAutorisation);

  end
  else
  begin
    TableGereEdit(TaAutorisation);
     TaAutorisation.FindField('fichier').AsString:=Liste.fichier;
      TaAutorisation.FindField('date_der_synchro').AsDateTime:=Liste.dateDerValidation;
      TableGerePost(TaAutorisation);
  end;
//   QuAutorisation.Close;
//   QuAutorisation.DatabaseName:=DM_C_NomAliasDossier;
//   QuAutorisation.Close;
//   QuAutorisation.SQL.Clear;
//
//   QuAutorisation.SQL.Add('select count(*)as nb from autorisation');
//
//   QuAutorisation.Open;
//   QuAutorisation.First;
//   insert:=QuAutorisation.FindField('nb').AsInteger<0;
//
//   QuAutorisation.Close;
//   QuAutorisation.SQL.Clear;
//   if(insert)then
//   begin
//        QuAutorisation.SQL.Add(' insert into autorisation (fichier,date_der_synchro)values(:fichier,:date_der)  ');
//   end
//   else
//   begin
//      QuAutorisation.SQL.Add(' update autorisation set fichier=:fichier,date_der_synchro=:date_der  ');
//   end;
//   QuAutorisation.ParamByName('fichier').AsString:=Liste.fichier;
//   QuAutorisation.ParamByName('date_der').AsDateTime:=Liste.dateDerValidation;
//   QuAutorisation.Prepare;
//   QuAutorisation.ExecSQL;
//
//            QuAutorisation.Database.Commit;
//            QuAutorisation.FlushBuffers
   except

   end;
end;



end.
