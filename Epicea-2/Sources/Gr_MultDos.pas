{***************************************************************
 *
 * Unit Name: Gr_MultDos
 * Purpose  :
 * Author   :  BP
 * History  :
 *
 ****************************************************************}

unit Gr_MultDos;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
	Controls, Dialogs, Forms, Registry, Db, DBTables, Math,stdctrls,

   FileCtrl,
   Gr_Librairie_obj,
   E2_Librairie_obj,
   LibGestionParamXml,
   Menus,
   CreationDossier,
   CreationExo,
   LibFichRep,
   E2_Decl_REcords,
   DMRecherche,
   E2_LibInfosTable,
   DMConstantes,
   Variants,
   DMXMLs,
   LibDates,
   LibZoneSaisie,
   E2_Patientez,
   LibRessourceString,
   Lib_Chaine,
     Gauges,
   DialogEx,
   DMMessagesLGR,
   ShellApi;

var fileLocked:string ='locked.tmp';   

//const MaxDosMenu = 1;
procedure nouvelleBase(Dossier:boolean;Nom_Dossier:string);
procedure CopierStructure(Source,Cible: string);
Function RepertoireNewBD(var NomRep : string):string;
Function RepertoireNewDossier(var NomRep : string):string;
Procedure AjoutExoGestDossier(NomExo,DirExo,Nom_Dossier:string;Indic:Boolean);
Procedure TransfertDonnees(ExoEnCours,NomNewExo,RepNewBD:string);
Procedure AjoutMenu(MultiDos:boolean);
Procedure GestionMenu(MultiDossier:Boolean);
//Procedure MaJDateDossier(NomDoss:string);
Function  CreeNouveauExo(Dir_Nom_Exo:String;Mess,SilenceSiDejaExiste:Boolean):boolean;
Function  CreeNouveauDossier(Dir_Nom_Dos:String;Mess,SilenceSiDejaExiste:Boolean):Boolean;
Function CreeRepertoire (Dir_Nom_Rep:string;SilenceSiDejaCree:Boolean):boolean;
function CreeNomValide_Rep (Dir_Rep:String; Var Nom_Rep:string):boolean;
function CreeNomValide_RepSimple(Dir_Rep:String; Var Nom_Rep:string):boolean;

Function ListeExoDosEnCours(Nom_Dos:string):TstringList;
Procedure CreetableMultiExo(Nom_Dos,Nom_Table:string;ExoList:TStringList);

Procedure Clotur(IDDosEnCours,IDExoEnCours:integer);
Procedure TransfStocksNewExo(var TableOrg,TableDest:TTable);
//function CreLesTables(Base:string;Chemin:string):string;stdcall; external 'CreTable' ;
procedure test(sender: TObject);
Function OuvreExercice(NomDossier,NomExo:string;Gauge:TGauge=nil;Reindexation:boolean=true;SauveXml:boolean=true):TErreurSaisie;
Function Verif_Si_Ouverture_ExoN1(Dossier,Exo:string):boolean;

Function GetUserFromWindows: string;

Function SauveDossier(ListeDossier:TStringList;DblSauv,Mail:String;Texte:string;VerrouDossier:boolean=false):Boolean;
Function SauveDossierAvantFermeture(ListeDossier:TStringList;Texte:string;VerrouDossier:boolean=false):Boolean;
function trouveFichierCloud():boolean;

//Function SauveDossier:Boolean;
Function RenomeDossierAvantRestaurationDossier(RepertoireDossier:String):Boolean;

Function FermerDossier(_E:TEntreprise):Boolean;
Function FermerDossierSauvegarde(_E:TEntreprise;Sauvegarde:boolean):Boolean;

Function ChangerDeDossier(NomDossierAOuvrir,NomExoAOuvrir:String):Boolean;
Function ControleDossierApresRestauration(NomDossier:string):Boolean;
function SauvegardeFermetureAuto(Affiche , Sauvegardefermeture : boolean;Chemin : string):boolean;
function DemandeParametreSauvegardeFermetureAuto(Affiche: boolean ):boolean;
function ControleOuvertureEpiceaLocked(Affiche: boolean;  nomUtilisateur:String ):boolean;
implementation

uses E2_Main,
     E2_AutreDossier,
     E2_GestSauvegarde,
     E2_GestionSauvegarde,
    // LibConvertisseur,
     E2_Logo,
     AideMontant2,
     LibSQL,
//     InfoCreat,
     DMBaseDonnee,
     DMBalances,
     DMProgramme,
     DMParamEnt,
     DMPlanCpt,
     DMCorrection,
     DMPointages2,
     UniteCorrection,
     DMPiece,
     DMEcriture,
     DMClotures,
     DMDiocEtatBalance,DMDiocEtatBalanceT, Windows, Lib1, DiversProjets,
  S2_Sauv, ImportDll, Unit76, E2_OKCreatExoDlg, E2_Cloture_Def,
  E2_DosProtect;

var
Forcefermer:boolean;

//******************* RepertoireNewBD *************************
//Cr�ation du repertoire du nouveau exercice
Function RepertoireNewBD(var NomRep : string):string;
var
Succes:boolean;
Nom,Chemin:string;
Annee:integer;
Reponse : boolean;
begin
result:='';
NomRep:='';
Annee:=(year(now))+1;
Chemin:=E.RepertoireProgram;
Chemin:=copy(DMBD.dbNameDossier.Params[0],6,length(DMBD.dbNameDossier.Params[0]))+'\';
nom:='Dossier'+Inttostr(annee);
Reponse:=InputQuery('Nom du nouvel Exercice','Saisissez votre nom d''exercice',nom);
if (DirectoryExists(Chemin+nom) and Reponse) then  begin
	if (empty(nom)) then
	Application.MessageBox('Ce nom d''exercice n''est pas correct !','Attention',MB_OK+MB_ICONSTOP)
   else
   Application.MessageBox('Cet exercice existe d�j�','Attention',MB_OK+MB_ICONSTOP);
   nom:='';
   while (Reponse and (nom='')) do begin
		Reponse:=InputQuery('Nom du nouvel Exercice','Saisissez un autre nom d''exercice',nom);
		if (DirectoryExists(Chemin+nom) and Reponse) then begin
			if (empty(nom)) then
			Application.MessageBox('Ce nom d''exercice n''est pas correct !','Attention',MB_OK+MB_ICONSTOP)
   		else
			Application.MessageBox('Cet exercice existe d�j�','Attention',MB_OK+MB_ICONSTOP);
         nom:='';
         end;
       end;
      end;

if ((not DirectoryExists(Chemin+nom)) and Reponse) then begin
   AllTrim(nom);
//	while nom[1]=' ' do delete(nom,1,1);
	Succes:=CreateDir(Chemin+nom);
	if Succes then begin
   			result:=(Chemin+Nom);
            NomRep:=Nom;
            end;
	end;

if not Reponse then
		Application.MessageBox('Op�ration annul�e !','Abandon',MB_OK+MB_ICONSTOP);

end;

//******************* RepertoireNewDossier *************************
//Cr�ation du repertoire d'un nouveau dossier
Function RepertoireNewDossier(var NomRep : string):string;
var
Succes:boolean;
Nom,Chemin:string;
Reponse : boolean;

begin
result:='';
NomRep:='';

Reponse:=InputQuery('Nom du nouveau Dossier','Saisissez votre nom de Dossier',nom);
if (DirectoryExists(Chemin+nom) and Reponse) then  begin
	if (empty(nom)) then
	Application.MessageBox('Ce nom d''exercice n''est pas correct !','Attention',MB_OK+MB_ICONSTOP)
   else
   Application.MessageBox('Cet exercice existe d�j�','Attention',MB_OK+MB_ICONSTOP);
   nom:='';
   while (Reponse and (nom='')) do begin
		Reponse:=InputQuery('Nom du nouvel Exercice','Saisissez un autre nom d''exercice',nom);
		if (DirectoryExists(Chemin+nom) and Reponse) then begin
			if (empty(nom)) then
			Application.MessageBox('Ce nom d''exercice n''est pas correct !','Attention',MB_OK+MB_ICONSTOP)
   		else
			Application.MessageBox('Cet exercice existe d�j�','Attention',MB_OK+MB_ICONSTOP);
         nom:='';
         end;
       end;
      end;

if ((not DirectoryExists(Chemin+nom)) and Reponse) then begin
	while nom[1]=' ' do delete(nom,1,1);
	Succes:=CreateDir(Chemin+nom);
	if Succes then begin
   			result:=(Chemin+Nom);
            NomRep:=Nom;
            end;
	end;

if not Reponse then
		Application.MessageBox('Op�ration annul�e !','Abandon',MB_OK+MB_ICONSTOP);

end;

//******************* CopierStructure *************************
//Copie la structure d'une table
procedure CopierStructure(Source,Cible: string);
begin
     with TTable.Create(Application) do
     try
        TableName := Source;
        Open;
        FieldDefs.Update;
        IndexDefs.Update;
        Close;
        TableName := Cible;
        CreateTable
     finally
        Free
     end
end;

//****************************************************************************//
procedure nouvelleBase(Dossier:boolean;Nom_Dossier:string);
var
a:TWin32FindData;
source,RepNewBD:string;
i:integer;
//F: TextFile;
NomRep:string;
begin
showmessage('Proc�dure : Nouvelle Base inutilis�e !!');
//if dossier then {Cr�ation Dossier}
//	begin
//	end
//   else {Cr�ation Exercice}
//   begin
//RepNewBD:=RepertoireNewBD(NomRep);
//if RepNewBD <>'' then begin
//	try
//	i:=FindFirstFile('C:\Js\Epicea-2\Donnees\*.db',a);
//	CopierStructure('c:\JS\Epicea-2\Donnees\'+ a.cFileName,RepNewBD+'\' + a.cFileName);
//	while FindnextFile(i,a) do
//		CopierStructure('c:\JS\Epicea-2\Donnees\'+ a.cFileName,RepNewBD+'\' + a.cFileName);
//
//    AssignFile(F,NomRep+ '.epi');
//    Rewrite(F);
//    Writeln(F, RepNewBD);
//    CloseFile(F);
//    AjoutExoGestDossier(NomRep,RepNewBD,Nom_Dossier,false);
//    //TransfertDonnees('Donnees',NomRep,RepNewBD);
//   except
//   	on EInOutError do Application.MessageBox('Erreur Disque','Erreur',MB_OK+MB_ICONSTOP);
//   	on EStreamError do Application.MessageBox('Erreur m�moire','Erreur',MB_OK+MB_ICONSTOP);
//   end;
//  end;
//  end;
 end;

//*************Copie les info du nouveau exo dans GestDossier*************//
Procedure AjoutExoGestDossier(NomExo,DirExo,Nom_Dossier:string;Indic:Boolean);
var
NewIDTable,IDExo,IDDossier:integer;
RepDossier:string;
begin
//try
//with Main.GestDos do begin
//   if not active then Open;
//   	filtered:=false;
//      filter:=CreeFiltreET(['Nom_Dossier'],[Nom_Dossier]);
//      Filtered:=true;
//      Last;
//      RepDossier:=FindField('Dir_Dossier').AsString;
//  		NewIDTable:= FindField('ID_Table').asInteger +1;
//      IDDossier:=FindField('ID_Dossier').asInteger;
//      if FindField('ID_Table').asInteger=0 then begin
//      	edit;
//      	SetFields([IDDossier,NewIDTable,Nil,Nil,NomExo,DirExo]);
//       TableGerePost(Main.GestDos);
//         end
//      else begin
//      appendRecord([IDDossier,NewIDTable,Nom_Dossier,RepDossier,NomExo,DirExo]);
//      FlushBuffers;
////      TransfertDonnees('Donnees',NomRep,RepNewBD);
//      end;
////      Main.IdDosExo:=IntToStr(IDDossier)+IntToStr(NewIdTable);
//      E.ID_Dos:=IDDossier;
//      refresh;
//      filtered:=false;
//      Filter:='';
////      Close;
//	end;
//except
//  Application.MessageBox('Erreur � la cr�ation','Attention',MB_OK+MB_ICONSTOP);
//end;
showmessage('Proc�dure : AjoutExoGestDossier inutilis�e !!');
end;

//*****************Transfere les donn�es necessaire dans le nouvel exo********//
Procedure TransfertDonnees(ExoEnCours,NomNewExo,RepNewBD:string);
var
TableOrg,TableDest:TTable;
NewBase:TDataBase;
begin
TableOrg:=TTable.Create(Main);
TableDest:=TTable.Create(Main);
NewBase:=TDataBase.Create(Main);
NewBase.DatabaseName:=NomNewExo;
NewBase.Params.Add('PATH='+RepNewBD);
NewBase.Params.Add('ENABLE BCD=FALSE');
NewBase.Params.Add('DEFAULT DRIVER=PARADOX');
NewBase.DriverName:='Standard';
TableOrg.DatabaseName:=ExoEnCours;
TableDest.DatabaseName:=NomNewExo;
//Copie des donnees dans le nouveau dossier//
TableOrg.TableName:='Model.db';
TableDest.TableName:='Model.db';
TableDest.BatchMove(TableOrg,batAppend);
TableOrg.TableName:='PlanCpt.DB';
TableDest.TableName:='PlanCpt.DB';
TableDest.BatchMove(TableOrg,batAppend);
TableOrg.TableName:='Tiers.DB';
TableDest.TableName:='Tiers.DB';
TableDest.BatchMove(TableOrg,batAppend);
TableOrg.Free;
TableDest.Free;
NewBase.Free;
end;

Procedure GestionMenu(MultiDossier:Boolean);
var
InfosGestDossier:TInfosGestDossier;
DossierDecrit:Boolean;
rang:Integer;
DosCount:Integer;
Begin
  If DMProg = nil then DMProg:=TDMProg.Create(Application);
  DMProg.QuGestDossierMenuDossier.Close;
  DMProg.QuGestDossierMenuDossier.Open;
  DMProg.QuGestDossierMenuExercice.Close;
  DMProg.QuGestDossierMenuExercice.Open;
  if DMProg.QuGestDossierMenuDossier.RecordCount > 0 then
   begin
    DMProg.QuGestDossierMenuDossier.First;
    DeFiltrageDataSet(DMRech.TaGestDossierRech);
    InfosGestDossier:=Infos_TInfosGestDossier(DMRech.TaGestDossierRech,'Nom_Dossier',[DMProg.QuGestDossierMenuDossier.FindField('Nom_Dossier').AsString]);
    DossierDecrit:= not empty(InfosGestDossier.EXO_SAISIE);
    Main.Menu.Items[0].Items[0].Caption:=DMProg.QuGestDossierMenuDossier.FindField('Nom_Dossier').AsString;
    Main.Menu.Items[0].Items[0].OnClick:=Main.mnMethodesClick;
    FiltrageDataSet(DMProg.QuGestDossierMenuExercice,'Nom_Dossier = '''+DMProg.QuGestDossierMenuDossier.FindField('Nom_Dossier').AsString+'''');
    DMProg.QuGestDossierMenuExercice.First;
    // On y ajoute le dernier exo utilis� pour ce dossier
    if ((DossierDecrit) and (true)) then
     begin
      if (DMProg.QuGestDossierMenuExercice.RecordCount > 0) then
       begin
        Main.Menu.Items[0].Items[0].Add(NewItem(DMProg.QuGestDossierMenuExercice.FindField('Nom_Exo').AsString,0,false,true,Main.mnOuvrirClick,0,'Exo0'));
       end;
      if DMProg.QuGestDossierMenuExercice.RecordCount > 1 then
       begin
        DMProg.QuGestDossierMenuExercice.Next;
        Main.Menu.Items[0].Items[0].Add(NewItem(DMProg.QuGestDossierMenuExercice.FindField('Nom_Exo').AsString,0,false,true,Main.mnOuvrirClick,0,'Exo1'));
       end;
                                                                              // (E.TypeClient<>CL_Saisie_Demo)
      if (DMProg.QuGestDossierMenuExercice.RecordCount < 2)and (e.TypeUtilisateur<>u_Demo) then  //23/09/2010

//       if (DMProg.QuGestDossierMenuExercice.RecordCount < 2) then
      begin
         Main.Menu.Items[0].Items[0].Add(NewLine);
         Main.Menu.Items[0].Items[0].Add(NewItem('Nouvel Exercice',0,false,true,Main.Nouveau1Click,0,'NewExo'));
       end;
                                // (E.TypeClient<>CL_Saisie_Demo)
       if(e.TypeUtilisateur<>u_Demo) then     //23/09/2010
       begin
       Main.Menu.Items[0].Items[0].Add(NewLine);
       Main.Menu.Items[0].Items[0].Add(NewItem('Autres Exercices ...',0,false,true,Main.mnOuvrirClick,0,'Exo2'));
       end;
     end
    else
     begin
      Main.Menu.Items[0].Items[0].Add(NewItem(DMProg.QuGestDossierMenuExercice.FindField('Nom_Exo').AsString + ' : Description Entreprise ...',0,false,true,Main.mnOuvrirForceClick,0,'Exo0Desc'));
     end;
   end;
if MultiDossier then
begin
  if Main.Menu.Items[0].Count < 6 then
   begin
     Main.Menu.Items[0].Add(NewLine);
     Main.Menu.Items[0].Add(NewItem('Multi-Dossier',0,false,true,Main.mnMethodesClick,0,'Multi'));
     rang:=Main.Menu.Items[0].Count-1;
   end
   else
   begin
    rang:=Main.Menu.Items[0].Count-1;
    Main.Menu.Items[0].Delete(Rang);
    Main.Menu.Items[0].Add(NewItem('Multi-Dossier',0,false,true,Main.mnMethodesClick,0,'Multi'));
  end;
  Main.Menu.Items[0].Items[rang].Add(NewItem('Nouveau Dossier',0,false,true,Main.CreationNewDossierClick,0,'NewDossier'));
  Main.Menu.Items[0].Items[rang].Add(NewLine);
  // Traitement des dossiers � afficher !
  DMProg.QuGestDossierMenuDossier.Next;
  DosCount := 1;
//  rang:=rang+1;
  While ((not DMProg.QuGestDossierMenuDossier.Eof) and (DosCount <= PAramUtil.MaxDosMenu)) do
   begin

    DeFiltrageDataSet(DMRech.TaGestDossierRech);
    InfosGestDossier:=Infos_TInfosGestDossier(DMRech.TaGestDossierRech,'Nom_Dossier',[DMProg.QuGestDossierMenuDossier.FindField('Nom_Dossier').AsString]);
    DossierDecrit:= not empty(InfosGestDossier.EXO_SAISIE);
     // On ajoute l'item du dossier
     Main.Menu.Items[0].Items[rang].Add(NewItem(DMProg.QuGestDossierMenuDossier.FindField('Nom_Dossier').AsString,0,false,true,Main.mnMethodesClick,0,'Dossier'+IntToStr(DosCount)));

    Main.Menu.Items[0].Items[rang].Items[DosCount+1].Caption:=DMProg.QuGestDossierMenuDossier.FindField('Nom_Dossier').AsString;
    Main.Menu.Items[0].Items[rang].Items[DosCount+1].OnClick:=Main.mnMethodesClick;
    FiltrageDataSet(DMProg.QuGestDossierMenuExercice,'Nom_Dossier = '''+DMProg.QuGestDossierMenuDossier.FindField('Nom_Dossier').AsString+'''');
    DMProg.QuGestDossierMenuExercice.First;
    // On y ajoute le dernier exo utilis� pour ce dossier
    if ((DossierDecrit) and (true)) then
     begin
      if (DMProg.QuGestDossierMenuExercice.RecordCount > 0) then
       begin
        Main.Menu.Items[0].Items[rang].Items[DosCount+1].Add(NewItem(DMProg.QuGestDossierMenuExercice.FindField('Nom_Exo').AsString,0,false,true,Main.mnOuvrirClick,0,'Exo0'));
       end;
      if DMProg.QuGestDossierMenuExercice.RecordCount > 1 then
       begin
        DMProg.QuGestDossierMenuExercice.Next;
        Main.Menu.Items[0].Items[rang].Items[DosCount+1].Add(NewItem(DMProg.QuGestDossierMenuExercice.FindField('Nom_Exo').AsString,0,false,true,Main.mnOuvrirClick,0,'Exo1'));
       end;

      if DMProg.QuGestDossierMenuExercice.RecordCount < 2 then
       begin
         Main.Menu.Items[0].Items[rang].Items[DosCount+1].Add(NewLine);
         Main.Menu.Items[0].Items[rang].Items[DosCount+1].Add(NewItem('Nouvel Exercice',0,false,true,Main.Nouveau1Click,0,'NewExo'));
       end;

       Main.Menu.Items[0].Items[rang].Items[DosCount+1].Add(NewLine);
       Main.Menu.Items[0].Items[rang].Items[DosCount+1].Add(NewItem('Autres Exercices ...',0,false,true,Main.mnOuvrirClick,0,'Exo2'));
     end
    else
     begin
      Main.Menu.Items[0].Items[rang].Items[DosCount+1].Add(NewItem(DMProg.QuGestDossierMenuExercice.FindField('Nom_Exo').AsString + ' : Description Entreprise ...',0,false,true,Main.mnOuvrirForceClick,0,'Exo0Desc'));
     end;
   

    DMProg.QuGestDossierMenuDossier.Next;
    inc(DosCount);
   end;
  // Fin Traitement des dossiers � afficher !
  Main.Menu.Items[0].Items[rang].Add(NewLine);
  Main.Menu.Items[0].Items[rang].Add(NewItem('Autres Dossiers ...',0,false,true,Main.mnOuvrirClick,0,'Dos'));
end;
End;

//****************************************************************************//
Procedure AjoutMenu(MultiDos:boolean);
var
i,j,rang,NExo,NDossier,NumDossier,NumExo:integer;
ListExo,ListDossier,ListNExo:TStringList;
DosSup,DossierDecrit:Boolean;
begin                     // or (e.typeclient=cl_saisie)
//if (e.typeclient=cl_demo)or(e.TypeClient=CL_Saisie_Demo) //23/09/2010
if(e.TypeUtilisateur=u_Demo)  then MultiDos:=false;  
GestionMenu(MultiDos);
end;
//begin
//try
//  If DMProg = nil then DMProg:=TDMProg.Create(Application);
//  DMProg.QuGestDossierMenu.Close;
//  DMProg.QuGestDossierMenu.Open;
//  if DMProg.QuGestDossierMenu.RecordCount > 0 then
//   begin // Pas Premi�re utilisation
//    DMProg.QuGestDossierMenu.First;
//    // On remplit d'abord l'item de menu du dossier ouvert en dernier, c'est
//    // � dire le dossier courant, sauf d�mo !!
//    DossierDecrit:=not empty(DMProg.QuGestDossierMenu.FindField('EXO_SAISIE').AsString);
//    NDossier:=DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsInteger;
//    NExo:=DMProg.QuGestDossierMenu.FindField('ID_Table').AsInteger;
//    Main.Menu.Items[0].Items[0].Caption:=DMProg.QuGestDossierMenu.FindField('Nom_Dossier').AsString;
//    Main.Menu.Items[0].Items[0].OnClick:=Main.mnMethodesClick;
//    // On y ajoute le dernier exo utilis� pour ce dossier
//    if DossierDecrit then
//    Main.Menu.Items[0].Items[0].Add(NewItem(DMProg.QuGestDossierMenu.FindField('Nom_Exo').AsString,0,false,true,Main.mnOuvrirClick,0,'Exo0'))
//    else
//    Main.Menu.Items[0].Items[0].Add(NewItem(DMProg.QuGestDossierMenu.FindField('Nom_Exo').AsString + ' : Description Entreprise ...',0,false,true,Main.mnOuvrirClick,0,'Exo0Desc'));
//    DMProg.ListeDossierTableTraiteMenu.Add(DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsString+DMProg.QuGestDossierMenu.FindField('ID_Table').AsString);
//// PB le 19/10/03    DMProg.QuGestDossierMenu.Refresh;
//    //    DMProg.QuGestDossierMenu.Next;
//    // Si le dossier contient deux exercice non clotur�
//    if DMProg.QuGestDossierMenu.Locate('ID_Dossier',NDossier,[]) then
//      begin
//       if ((DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsInteger = NDossier)
//           and (DMProg.QuGestDossierMenu.FindField('ID_Table').AsInteger <> NExo)) then
//           begin
//             Main.Menu.Items[0].Items[0].Add(NewItem(DMProg.QuGestDossierMenu.FindField('Nom_Exo').AsString,0,false,true,Main.mnOuvrirClick,0,'Exo1'));
////             DMProg.QuGestDossierMenu.Next;
//           end; // Fin Si le dossier contient deux exercice non clotur�
////           else
//           begin
//            if DossierDecrit then
//             begin
//              Main.Menu.Items[0].Items[0].Add(NewLine);
//              Main.Menu.Items[0].Items[0].Add(NewItem('Autres Exercices ...',0,false,true,Main.mnOuvrirClick,0,'Exo2'));
//             end;
//           end; // Fin Si le dossier ne contient pas deux exercice non clotur�
//       DMProg.ListeDossierTableTraiteMenu.Add(DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsString+DMProg.QuGestDossierMenu.FindField('ID_Table').AsString);
//// PB le 19/10/03       DMProg.QuGestDossierMenu.Refresh;
//     end
//     else
//     // On ajoute le menu Autre exercice ...
//     if DossierDecrit then
//      begin
//       Main.Menu.Items[0].Items[0].Add(NewLine);
//       Main.Menu.Items[0].Items[0].Add(NewItem('Autres Exercices ...',0,false,true,Main.mnOuvrirClick,0,'Exo2'));
//        if (DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsInteger > 0) then
//         begin // Si dossier non import�!!
//           Main.Menu.Items[0].Items[0].Add(NewLine);
//           Main.Menu.Items[0].Items[0].Add(NewItem('Nouvel Exercice',0,false,true,Main.Nouveau1Click,0,'NewExo'));
//         end;
//      end;
//    DMProg.QuGestDossierMenu.Refresh;
//   end  // Fin Pas Premi�re utilisation
//   else
//   begin // Premi�re utilisation
//   end; // Fin Premi�re utilisation
//except
// if DMProg <> nil then
//  if DMProg.QuGestDossierMenu.Active then DMProg.QuGestDossierMenu.Close;
//end;
////ListExo:=TStringList.Create;
////ListNExo:=TStringList.Create;
////ListDossier:=TStringList.Create;
////if not Main.GestDos.Active then Main.GestDos.Open;
////if Main.GestDos.RecordCount > 0 then
////begin //Pas premi�re utilisation
////  Main.gestDos.IndexName:='Date_Util';
////  Main.GestDos.First;
////  while not Main.GestDos.EOF do
////    begin
////    if ListDossier.IndexOf(Main.GestDos.FindField('Nom_Dossier').AsString)= -1 then
////      begin
////       ListDossier.Add(Main.GestDos.FindField('Nom_Dossier').AsString);
////       ListExo.Add(Main.GestDos.FindField('Nom_Exo').AsString);
////       ListNExo.Add('1');
////       Main.GestDos.Next;
////       if not Main.gestDos.eof then
////         if ListDossier.Strings[ListDossier.Count-1]=Main.GestDos.FindField('Nom_Dossier').AsString then
////           begin
//////          if ListExo.IndexOf(Main.GestDos.FindField('Nom_Exo').AsString)= -1 then
////            ListExo.Add(Main.GestDos.FindField('Nom_Exo').AsString);
////            ListNExo.Strings[ListDossier.Count-1]:='2';
////           end;
////      end
////      else
////      Main.GestDos.Next;
////end;
////
////Main.Menu.Items[0].Items[0].Caption:=ListDossier.Strings[0];
////Main.Menu.Items[0].Items[0].OnClick:=Main.mnMethodesClick;
////
//////if Main.GestDos.locate('Nom_Exo',ListExo.strings[0],[]) then
////Main.Menu.Items[0].Items[0].Add(NewItem(ListExo.strings[0],0,false,true,Main.mnOuvrirClick,0,'Exo0'));
//////	Main.Menu.Items[0].Items[0].Add(NewItem(Main.GestDos.findField('Nom_Exo').asString,0,false,true,Main.mnOuvrirClick,0,'Exo0'));
//////Main.GestDos.Next;
//////if not Main.GestDos.EOF then begin
//////	if Main.GestDos.findField('Nom_Exo').asString = ListExo.strings[1] then
////if ListNExo.Strings[0]='2' then
////   	Main.Menu.Items[0].Items[0].Add(NewItem(ListExo.strings[1],0,false,true,Main.mnOuvrirClick,0,'Exo1'))
////      else
////      Main.Menu.Items[0].Items[0].Add(NewItem('Nouveau Exercice',0,false,true,Main.Nouveau1Click,0,'NewExo'));
////
//////   	Main.Menu.Items[0].Items[0].Add(NewItem(Main.GestDos.findField('Nom_Exo').asString,0,false,true,Main.mnOuvrirClick,0,'Exo1'));
//////   end;
////Main.Menu.Items[0].Items[0].Add(NewItem('Autres Exercices ...',0,false,true,Main.mnOuvrirClick,0,'Exo2'));
////
////ListDossier.Delete(0);
////if ListNExo.Strings[0]='1' then
////		ListExo.Delete(0)
////      else begin
////		ListExo.Delete(0);
////		ListExo.Delete(0);
////      end;
////ListNExo.Delete(0);
////end; // Fin Premi�re utilisation
//////********MultiDossier***************//
//if Multidos then
//begin
//  if Main.Menu.Items[0].Count < 6 then
//   begin
//     Main.Menu.Items[0].Add(NewLine);
//     Main.Menu.Items[0].Add(NewItem('Multi-Dossier',0,false,true,Main.mnMethodesClick,0,'Multi'));
//     rang:=Main.Menu.Items[0].Count-1;
//   end
//   else
//   begin
//    rang:=Main.Menu.Items[0].Count-1;
//    Main.Menu.Items[0].Delete(Rang);
//    Main.Menu.Items[0].Add(NewItem('Multi-Dossier',0,false,true,Main.mnMethodesClick,0,'Multi'));
//  end;
//  Main.Menu.Items[0].Items[rang].Add(NewItem('Nouveau Dossier',0,false,true,Main.CreationNewDossierClick,0,'NewDossier'));
//  Main.Menu.Items[0].Items[rang].Add(NewLine);
//  DosSup:=false;
//  NumDossier:=0;
////  if (not DMProg.QuGestDossierMenu.eof) then
////    begin
////      inc(rang);
////    end;
////  While ((not DMProg.QuGestDossierMenu.eof) and (NumDossier <= MaxDosMenu)) do
//While ((DMProg.QuGestDossierMenu.RecordCount > 0) and (NumDossier < ParamUtil.MaxDosMenu)) do
//  begin //
//     inc(NumDossier);
//     NumExo:=0;
//    DossierDecrit:=not empty(DMProg.QuGestDossierMenu.FindField('EXO_SAISIE').AsString);
//     NDossier:=DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsInteger;
//     NExo:=DMProg.QuGestDossierMenu.FindField('ID_Table').AsInteger;
//     // On ajoute l'item du dossier
//     Main.Menu.Items[0].Items[rang].Add(NewItem(DMProg.QuGestDossierMenu.FindField('Nom_Dossier').AsString,0,false,true,Main.mnMethodesClick,0,'Dossier'+IntToStr(NumDossier)));
////     // On y ajoute le dernier exo utilis� pour ce dossier
//     if DossierDecrit then
//     Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewItem(DMProg.QuGestDossierMenu.FindField('Nom_Exo').AsString,0,false,true,Main.mnOuvrirClick,0,'Exo0'))
//     else
//     Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewItem(DMProg.QuGestDossierMenu.FindField('Nom_Exo').AsString + ' : Description Entreprise ...',0,false,true,Main.mnOuvrirClick,0,'Exo0Desc'));
//     DMProg.ListeDossierTableTraiteMenu.Add(DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsString+DMProg.QuGestDossierMenu.FindField('ID_Table').AsString);
//// PB le 19/10/03    DMProg.QuGestDossierMenu.Refresh;
////    DMProg.QuGestDossierMenu.Next;
//    // Si le dossier contient deux exercice non clotur�
//    if DMProg.QuGestDossierMenu.Locate('ID_Dossier',NDossier,[]) then
//    begin
////     // Si le dossier contient deux exercice non clotur�
//     if ((DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsInteger = NDossier)
//          and (DMProg.QuGestDossierMenu.FindField('ID_Table').AsInteger <> NExo)) then
//          begin
//            Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewItem(DMProg.QuGestDossierMenu.FindField('Nom_Exo').AsString,0,false,true,Main.mnOuvrirClick,0,'Exo1'));
////            DMProg.QuGestDossierMenu.Next;
//          end; // Fin Si le dossier contient deux exercice non clotur�
////          else
//          begin
//           if DossierDecrit then
//            begin
//              Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewLine);
//              Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewItem('Autres Exercices ...',0,false,true,Main.mnOuvrirClick,0,'Exo2'));
//            end;
//          end; // Fin Si le dossier ne contient pas deux exercice non clotur�
//     DMProg.ListeDossierTableTraiteMenu.Add(DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsString+DMProg.QuGestDossierMenu.FindField('ID_Table').AsString);
//// PB le 19/10/03    DMProg.QuGestDossierMenu.Refresh;
//     end
//     else
//      // On ajoute le menu Autre exercice ...
//      if DossierDecrit then
//      begin
//        Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewLine);
//        Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewItem('Autres Exercices ...',0,false,true,Main.mnOuvrirClick,0,'Exo2'));
//        if (DMProg.QuGestDossierMenu.FindField('ID_Dossier').AsInteger > 0) then
//         begin // Si dossier non import�!!
//          Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewLine);
//          Main.Menu.Items[0].Items[rang].Items[NumDossier+1].Add(NewItem('Nouvel Exercice',0,false,true,Main.Nouveau1Click,0,'NewExo'));
//         end;
//      end;
//     DMProg.QuGestDossierMenu.Refresh; // PB le 19/10/03 
//    end; // Fin du While
// Main.Menu.Items[0].Items[rang].Add(NewLine);
// Main.Menu.Items[0].Items[rang].Add(NewItem('Autres Dossiers ...',0,false,true,Main.mnOuvrirClick,0,'Dos'));
//end;
////
////  if ListDossier.Count > MaxDosMenu then
////  begin
////   NDossier:=MaxDosMenu;
////   DosSup:=true;
////  end
////  else
////  NDossier:=ListDossier.Count;
////
////  for i:=0 to NDossier+1 do begin
////          case i of
////        0:Main.Menu.Items[0].Items[rang].Add(NewItem('Nouveau Dossier',0,false,true,Main.Button2Click,0,'NewDossier'));
////        1:if NDossier>0 then Main.Menu.Items[0].Items[rang].Add(NewLine);
////        2..11:if NDossier>0 then begin
////                  Main.Menu.Items[0].Items[rang].Add(NewItem(ListDossier.Strings[i-2],0,false,true,nil,0,'Dossier'+IntToStr(i)));
////              j:=StrToInt(ListNExo.strings[i-2]);
////              if Main.GestDos.locate('Nom_Exo',ListExo.strings[0],[]) then
////                  if Main.GestDos.findField('Nom_Exo').asString='' then begin
////                                                  Main.Menu.Items[0].Items[rang].Items[i].Add(NewItem('Nouveau Exercice',0,false,true,Main.Nouveau1Click,0,'NewExo'));
////                  end else begin
////                          Main.Menu.Items[0].Items[rang].Items[i].Add(NewItem(Main.GestDos.findField('Nom_Exo').asString,0,false,true,Main.mnOuvrirClick,0,'Exo0'));
////                  end;
////                          Main.GestDos.Next;
////              if ((not Main.GestDos.EOF) and (j=2)) then begin
////              if Main.GestDos.findField('Nom_Exo').asString = ListExo.strings[1] then
////                          Main.Menu.Items[0].Items[rang].Items[i].Add(NewItem(Main.GestDos.findField('Nom_Exo').asString,0,false,true,Main.mnOuvrirClick,0,'Exo1'));
////                 end;
////              if ((j=1) and ((Main.Menu.Items[0].Items[rang].Items[i].Items[0]).Caption<>'Nouveau Exercice')) then
////              Main.Menu.Items[0].Items[rang].Items[i].Add(NewItem('Nouveau Exercice',0,false,true,Main.Nouveau1Click,0,'NewExo'));
////                  Main.Menu.Items[0].Items[rang].Items[i].Add(NewItem('Autres Exercices ...',0,false,true,Main.mnOuvrirClick,0,'Exo2'));
////              if j=1 then ListExo.delete(0)
////                 else
////                  begin
////                 ListExo.delete(0);
////                 ListExo.delete(0);
////                 end;
////              end;
////     end;
////  end;
////end;
//
////if (DMProg.QuGestDossierMenu.RecordCount > 0) then
////  begin
////   Main.Menu.Items[0].Items[rang].Add(NewLine);
////   Main.Menu.Items[0].Items[rang].Add(NewItem('Autres Dossiers ...',0,false,true,Main.mnOuvrirClick,0,'Dos'));
////  end;
//
////Main.gestDos.IndexName:='';
//////Main.GestDos.Close;
////ListExo.Free;
////ListNExo.Free;
////ListDossier.Free;
//end;

//****************************************************************************//
//Procedure MaJDateDossier(NomDoss:string);
//var
//HeureUtil:TDateTime;
//FiltreOld,index_old:String;
//Begin
//FiltreOld:=Main.gestDos.Filter;
//Main.GestDos.Filtered:=false;
//index_old:=Main.GestDos.IndexName;
//Main.GestDos.IndexName:='Date_Util';
//Main.GestDos.First;
//HeureUtil:=Main.GestDos.findfield('DateUtil').AsDateTime;
//if HeureUtil >= now then
//   begin
//   MessageDlg('Attention, votre ordinateur '+#13+#10+'semble avoir un probl�me d'+#39+'horloge.'+#13+#10+'Un de vos dossier semble avoir une date de '+#13+#10+'derni�re utilisation incorrecte.',mtWarning,[mbOK],0);
//   HeureUtil:=HeureUtil+1;
//   end
//   else HeureUtil:=Now;
//Main.GestDos.IndexName:=index_old;
//Main.GestDos.Filter:=CreeFiltreET(['Nom_Dossier'],[NomDoss]);
//Main.GestDos.Filtered:=True;
//Main.GestDos.First;
//While Not Main.GestDos.EOF do begin
//	Main.gestDos.edit;
//        Main.GestDos.FieldValues['DateUtil']:=HeureUtil;
//	Main.gestDos.Post;
//        Main.gestDos.FlushBuffers;
//	Main.GestDos.Next;
//	end;
//Main.GestDos.Filtered:=false;
//Main.GestDos.Filter:=FiltreOld;
//end;

//****************************************************************************//
Function  CreeNouveauExo(Dir_Nom_Exo:String;Mess,SilenceSiDejaExiste:Boolean):boolean;
var
//QExo:TQuery;
//NewBase:TDataBase;
i:integer;
aux,Nom:string;
Intitule:array[0..79] of Char;
begin
result:=false;
If E.TypeDossier in [VerdemoAgri,VerDemoGeneral,VerDemoDioc] then
 SilenceSiDejaExiste:=true;
if CreeRepertoire(Dir_Nom_Exo,SilenceSiDejaExiste) then begin
try
CreateTablesExo(Dir_Nom_Exo);
//Cr�ation Base tmp et Query
//NewBase:=TDataBase.Create(Main);
//QExo:=TQuery.Create(Main);
//NewBase.DatabaseName:=Dir_Nom_Exo;
//NewBase.Params.Add('PATH='+Dir_Nom_Exo);
//NewBase.Params.Add('ENABLE BCD=FALSE');
//NewBase.Params.Add('DEFAULT DRIVER=PARADOX');
//CreateTablesExo(NewBase.DatabaseName);
//Qexo.DatabaseName:=NewBase.DatabaseName;
//Nom:=copy(Dir_Nom_Exo,LastDelimiter('\',Dir_Nom_Exo)+1,length(Dir_Nom_Exo));
//	if (InfoCre = nil) then
//   InfoCre:=TInfoCre.Create(Main);
//   InfoCre.Caption:='Rapport de la cr�ation de l''exercice : '+Nom;
//	InfoCre.show;
//
////QExo.Prepare;
//InfoCre.RichEdit1.Lines.Add('      Cr�ation des Tables de l''exercice : '+Nom);
//InfoCre.RichEdit1.Lines.Add('________________________________________________________ ');
//InfoCre.RichEdit1.Lines.Add(' ');
//for i:=1 to 15 do begin
//    QExo.SQL.Clear;
//    Qexo.SQL.LoadFromFile(ExtractFilePath(Application.ExeName)+'Data\1\Table'+IntTOStr(i)+'.txt');
//    aux:=copy(QExo.SQL.Strings[0],13,length(QExo.SQL.Strings[0]));
//    InfoCre.RichEdit1.Lines.Add('Cr�ation table '+aux+':       OK');
//    QExo.ExecSQL;
//end;
//InfoCre.RichEdit1.Lines.Add(' ');
//InfoCre.RichEdit1.Lines.Add('---------------------------------------------------------');
//InfoCre.RichEdit1.Lines.Add(' ');
//InfoCre.RichEdit1.Lines.Add('      Cr�ation des Indexs de l''exercice : '+Nom);
//for i:=1 to 23 do begin
//    QExo.SQL.Clear;
//    Qexo.SQL.LoadFromFile(ExtractFilePath(Application.ExeName)+'Data\1\Index'+IntTOStr(i)+'.txt');
//    aux:=copy(QExo.SQL.Strings[1],3,length(QExo.SQL.Strings[1]));
//    InfoCre.RichEdit1.Lines.Add('Cr�ation Index de la table '+aux+':       OK');
//    QExo.ExecSQL;
//end;
////Intitule:='Rapport de la cr�ation du Dossier : '+ Ptr(Nom);
//Nom:='Rapport de la cr�ation de l''exercice : '+ nom;
//StrPCopy(Intitule,Nom);
if mess then
if Application.MessageBox('Voulez-vous imprimer le rapport de c�ation',Intitule,MB_YESNO + MB_SYSTEMMODAL + MB_ICONQUESTION+MB_DEFBUTTON2)=IDYES then;
//   InfoCre.RichEdit1.Print('Rapport de cr�ation de l''exercice : '+Nom);
result:=true;
except
      result:=false;
//      InfoCre.RichEdit1.Lines.Delete(InfoCre.RichEdit1.Lines.Count-1);
//    InfoCre.RichEdit1.Lines.Add('Cr�ation table '+aux+':       Erreur');
//Nom:='Erreur � la cr�ation de l''exercice : '+ Nom;
//StrPCopy(Intitule,Nom);
if Application.MessageBox('Voulez-vous imprimer le rapport de c�ation',Intitule,MB_YESNO + MB_SYSTEMMODAL + MB_ICONQUESTION+MB_DEFBUTTON2)=IDYES then;
//   InfoCre.RichEdit1.Print('Rapport de cr�ation de l''exercice : '+Nom);
end;
//InfoCre.Free;
//InfoCre:=nil;
//Destruction Base et Query
//QExo.Free;
//NewBase.Free;
end else result := false;
end;

//****************************************************************************//
Function  CreeNouveauDossier(Dir_Nom_Dos:String;Mess,SilenceSiDejaExiste:Boolean):boolean;
var
QExo:TQuery;
NewBase:TDataBase;
i:integer;
aux,Nom,StrPCptOrg,StrPCptDest:string;
Intitule,PCptOrg,PCptDest:array[0..255] of Char;
ListTableCree:TStringList;
begin
If E.TypeDossier in [VerdemoAgri,VerDemoGeneral,VerDemoDioc] then
 SilenceSiDejaExiste:=true;
if CreeRepertoire(Dir_Nom_Dos,SilenceSiDejaExiste) then
begin
    Nom:=copy(Dir_Nom_Dos,LastDelimiter('\',Dir_Nom_Dos)+1,length(Dir_Nom_Dos));
  try
    ListTableCree:=TStringList.Create;
    //Cr�ation Base tmp et Query
    NewBase:=TDataBase.Create(application);
    QExo:=TQuery.Create(application);
    NewBase.DatabaseName:=Dir_Nom_Dos;
    NewBase.Params.Add('PATH='+Dir_Nom_Dos);
    NewBase.Params.Add('ENABLE BCD=FALSE');
    NewBase.Params.Add('DEFAULT DRIVER=PARADOX');
    CreateTables(NewBase.DatabaseName);
    UpdateTables(NewBase.DatabaseName);

    ListTableCree:=ListeFic('*.db',Dir_Nom_Dos,faAnyFile,false,false);
//            if (InfoCre = nil) then
//       InfoCre:=TInfoCre.Create(application);
//       InfoCre.Caption:='Rapport de la cr�ation du dossier : '+Nom;
//    InfoCre.RichEdit1.Lines.Add('      Cr�ation des Tables du dossier : '+Nom);
//    InfoCre.RichEdit1.Lines.Add('________________________________________________________');
//    InfoCre.RichEdit1.Lines.Add(' ');
//    for i:=0 to ListTableCree.Count-1 do
//     begin
//      InfoCre.RichEdit1.Lines.Add('Cr�ation table '+ListTableCree.Strings[i]+':'+ StringOfChar(#9,4)+'OK');
//     end;
//    InfoCre.RichEdit1.Lines.Add(' ');
//    InfoCre.RichEdit1.Lines.Add('________________________________________________________ ');
//    InfoCre.RichEdit1.Lines.Add(' ');
//    Nom:='Cr�ation du dossier : '+ nom;
//    StrPCopy(Intitule,Nom);
//    if mess then
//    if Application.MessageBox('Voulez-vous voir le rapport de c�ation',Intitule,MB_YESNO + MB_SYSTEMMODAL + MB_ICONQUESTION+MB_DEFBUTTON2)=IDYES then
//            InfoCre.showModal;
    result:=true;
  except
     ListTableCree.Free;
     result:=false;
//     Nom:='Cr�ation du dossier : '+ nom;
//     StrPCopy(Intitule,Nom);
//     if mess then
//       if Application.MessageBox('Voulez-vous voir le rapport de c�ation',Intitule,MB_YESNO + MB_SYSTEMMODAL + MB_ICONQUESTION+MB_DEFBUTTON2)=IDYES then
//            InfoCre.show;
  end;
  ListTableCree.Free;
  //Destruction Base et Query
  QExo.Free;
  NewBase.Free;
  end
  else
  begin
//    Nom:='Cr�ation du dossier : '+ nom;
//    StrPCopy(Intitule,Nom);
    Application.MessageBox('Erreur lors de la c�ation de votre dossier',Intitule,MB_OK + MB_SYSTEMMODAL + MB_ICONWARNING);
    result:=false;
  end;
end;

//****************************************************************************//
Function CreeRepertoire (Dir_Nom_Rep:string;SilenceSiDejaCree:Boolean):boolean;
Var
nomRep,DirRep:string;
begin
result:=false;
try
  NomRep:=copy(Dir_Nom_Rep,LastDelimiter('\',Dir_Nom_Rep)+1,length(Dir_Nom_Rep));
  if LastDelimiter('\',Dir_Nom_Rep) = length(Dir_Nom_Rep) then
    DirRep:=copy(Dir_Nom_Rep,1,LastDelimiter('\',Dir_Nom_Rep))
    else
    DirRep:=copy(Dir_Nom_Rep,1,LastDelimiter('\',Dir_Nom_Rep));

  if SilenceSiDejaCree then
  begin
   if DirectoryExists(Dir_Nom_Rep) then
    begin
     result:=true;
    end
    else
    begin
//     if (CreeNomValide_Rep('',Dir_Nom_Rep)) then
//      begin
        ForceDirectories(Dir_Nom_Rep);
        result:=true;
//      end
//      else
//      Result:=false;
    end;
  end
    else
  begin
     if (CreeNomValide_Rep(DirRep,NomRep)) then
      begin
        ForceDirectories(DirRep+NomRep);
        result:=true;
      end
      else
      Result:=false;
  end;
except
 result:=false;
end;
end;

//****************************************************************************//
function CreeNomValide_Rep(Dir_Rep:String;Var Nom_Rep:string):boolean;
type
TChrInterdit=set of char;
var
ChrInterdit:TChrInterdit;//[#42,#46,47,58,60,62,63,92,124];
i:integer;
NomOk,continuer:boolean;
begin
ChrInterdit:=[#42,#46,#47,#58,#60,#62,#63,#92,#124];
if not DirectoryExists(Dir_Rep+Nom_Rep) then begin
   NomOk:=Nom_Rep <> '';
   continuer:=true;
   for i:=1 to length(Nom_Rep) do
       if Nom_Rep[i] in ChrInterdit then
                     begin
                     NomOk:=false;
                     if ((Nom_Rep[i]=#46) and (i=1)) then NomOk:=true;
                     end;
   while ((Continuer=true) and (NomOk=false)) do
      begin
      Continuer:=InputQuery('Le nom saisie doit suivre la syntaxe des noms de r�pertoires','Saisissez un nouveau nom',Nom_Rep);
      NomOk:=true;
      for i:=1 to length(Nom_Rep) do
          if Nom_Rep[i] in ChrInterdit then
                     begin
                     NomOk:=false;
                     if ((Nom_Rep[i]=#46) and (i=1)) then NomOk:=true;
                     end;
      end;
   Result:=((Continuer=true) and (NomOk=true));
   end
   else begin
   NomOk:=false;
   continuer:=true;
   Application.messageBox('Les Dossiers ou Exercices sont des r�pertoires, ils doivent �tre unique','Ce nom existe d�j�',16);
   while ((Continuer=true) and (NomOk=false)) do
      begin
      Continuer:=InputQuery('Le nom saisie doit suivre la syntaxe des noms de r�pertoires','Saisissez un nouveau nom',Nom_Rep);
      NomOk:=true;
      for i:=1 to length(Nom_Rep) do
          if Nom_Rep[i] in ChrInterdit then
                     begin
                     NomOk:=false;
                     if ((Nom_Rep[i]=#46) and (i=1)) then NomOk:=true;
                     end;
      end;
   Result:=((Continuer=true) and (NomOk=true));

   end;
end;

function CreeNomValide_RepSimple(Dir_Rep:String;Var Nom_Rep:string):boolean;
type
TChrInterdit=set of char;
var
ChrAutorise:TChrInterdit;//[#42,#46,47,58,60,62,63,92,124];
i:integer;
NomOk,continuer:boolean;
begin
ChrAutorise:=[#8,#48..#57,#65..#90,#97..#122];
if not DirectoryExists(Dir_Rep+Nom_Rep) then
   begin
     NomOk:=not empty(Nom_Rep);
     continuer:=true;
     for i:=1 to length(Nom_Rep) do
         if not(Nom_Rep[i] in ChrAutorise) then
                       begin
                       NomOk:=false;
                       end;
     while ((Continuer=true) and (NomOk=false)) do
        begin
        Continuer:=InputQuery('Le nom saisie doit suivre la syntaxe des noms de r�pertoires','Saisissez un nouveau nom',Nom_Rep);
        NomOk:=empty(Nom_Rep);
        for i:=1 to length(Nom_Rep) do
            if not (Nom_Rep[i] in ChrAutorise) then
                       begin
                       NomOk:=false;
                       end;
        end;
     Result:=((Continuer=true) and (NomOk=true));
   end
   else
   begin
     NomOk:=false;
     continuer:=true;
     Application.messageBox('Les Dossiers ou Exercices sont des r�pertoires, ils doivent �tre unique','Ce nom existe d�j�',16);
     while ((Continuer=true) and (NomOk=false)) do
        begin
        Continuer:=InputQuery('Le nom saisie doit suivre la syntaxe des noms de r�pertoires','Saisissez un nouveau nom',Nom_Rep);
        NomOk:=empty(Nom_Rep);
        for i:=1 to length(Nom_Rep) do
            if not(Nom_Rep[i] in ChrAutorise) then
                       begin
                       NomOk:=false;
                       end;
        end;
     Result:=((Continuer=true) and (NomOk=true));
   end;
end;

//****************************************************************************//
Function ListeExoDosEnCours(Nom_Dos:string):TstringList;
var
OldFiltre:string;
i:integer;
TmpStrList:TStringList;
begin
showmessage('Function  : ListeExoDosEnCours inutilis�e !!');
//OldFiltre:='';
//TmpStrList:=TStringList.Create;
//TmpStrList.Clear;
//with Main.GestDos do begin
//     if not Main.GestDos.Active then Main.GestDos.open else
//        begin
//        if Filtered then begin
//        OldFiltre:=Filter;
//        Filtered:=false;
//        end
//        end;
//     Filter:=CreeFiltreET(['Nom_Dossier'],[Nom_dos]);
//     Filtered:=true;
//     Main.GestDos.First;
//     for i:=0 to Main.GestDos.RecordCount - 1 do begin
//         TmpStrList.Add(Main.GestDos.findField('Dir_Exo').AsString);
//         next;
//         end;
//if OldFiltre <>'' then begin
//   Filtered:=false;
//   Filter:=OldFiltre;
//   Filtered:=true;
//     end;
//   end;
//result:=TmpStrList;
////TmpStrList.free;
end;

//****************************************************************************//
Procedure CreetableMultiExo(Nom_Dos,Nom_Table:string; ExoList : TStringList);
//var
////Deb,Fin:TDateTime;
//i:integer;
//BaseTmp:TDataBase;
//TableTmp:TTable;
//QueryTmp:TQuery;
//FOrg,FDest:array[0..255] of Char;
begin
//  if ((ExoList.Count > 0) and (Main.gestDos.Locate('Dir_Exo',ExoList.Strings[0],[]))) then
//     begin
////     Deb:=now;
//     //Initialisation de la base et table temporaire
//     TableTmp:=TTable.Create(Main);
//     BaseTmp:=TDataBase.Create(Main);
//     QueryTmp:=TQuery.Create(Main);
//     BaseTmp.DatabaseName:='Tmp';
//     BaseTmp.Params.Add('PATH='+E.RepertoireProgram+'Tmp');
//     BaseTmp.Params.Add('ENABLE BCD=FALSE');
//     BaseTmp.Params.Add('DEFAULT DRIVER=PARADOX');
//     BaseTmp.DriverName:='Standard';
//     TableTmp.DatabaseName:='Tmp';
//     QueryTmp.DatabaseName:='Tmp';
//     TableTmp.TableName:=Nom_Table+'Tmp.db';
//     //Initialisation de la base et table de parcours
//     DMBD.DbParcours.Close;
//     DMBD.DbParcours.DatabaseName:=main.gestDos.findField('Nom_Exo').AsString+'x';
//     DMBD.DbParcours.Params.Add('PATH='+main.gestDos.findField('Dir_Exo').AsString);
//     DMBD.DbParcours.Params.Add('ENABLE BCD=FALSE');
//     DMBD.DbParcours.Params.Add('DEFAULT DRIVER=PARADOX');
//     DMBD.DbParcours.DriverName:='Standard';
//     DMBD.DbParcours.Connected:=true;
//     DMBD.TaParcours.DatabaseName:=DMBD.DbParcours.DatabaseName;
//     DMBD.TaParcours.TableName:=Nom_Table+'.db';
//     //Mise en place des donnees et de la table servant aux recherche
//     CopierStructure(Main.gestDos.findField('Dir_Exo').AsString+'\'+Nom_Table+'.db',E.RepertoireProgram+'\Tmp\'+Nom_Table+'Tmp.db');
//     TableTmp.BatchMove(DMBD.TaParcours,batAppend);
//     StrPCopy(FOrg,E.RepertoireProgram+'Tmp\'+TableTmp.TableName);
//     StrPCopy(FDest,E.RepertoireProgram+'Tmp\'+Nom_Table+'Aux.db');
//     copyFile(FOrg,Fdest,False);
//
//     queryTmp.sql.Clear;
//     QueryTmp.sql.Add('Delete From "'+Nom_Table+'tmp.db" ');
//     queryTmp.ExecSQL;
//
//     queryTmp.sql.Clear;
//     QueryTmp.sql.Add('Alter Table "'+Nom_Table+'Aux.db" ADD ID_Dossier integer, Add ID_Table integer');
//     queryTmp.ExecSQL;
//     queryTmp.sql.Clear;
//     QueryTmp.sql.Add('update "'+Nom_Table+'Aux.db" set ID_Dossier='+Main.gestDos.findField('ID_Dossier').AsString+',ID_Table='+Main.gestDos.findField('ID_Table').AsString+' where Id_Dossier is null');
//     queryTmp.ExecSQL;
//     For i:=1 to ExoList.Count - 1 do
//      begin
//       if (Main.gestDos.Locate('Dir_Exo',ExoList.Strings[i],[])) then
//       begin
//       DMBD.DbParcours.Close;
//       DMBD.DbParcours.DatabaseName:=Main.gestDos.findField('Nom_Exo').AsString+'x';
//       DMBD.DbParcours.Params[0]:=('PATH='+Main.gestDos.findField('Dir_Exo').AsString);
//       DMBD.DbParcours.Connected:=true;
//       DMBD.TaParcours.DatabaseName:=DMBD.DbParcours.DatabaseName;
//       DMBD.TaParcours.TableName:=Nom_Table+'.db';
//
//
//     TableTmp.BatchMove(DMBD.TaParcours,batAppend);
//
//     queryTmp.sql.Clear;
//     QueryTmp.sql.Add('Alter Table "'+Nom_Table+'Tmp.db" ADD ID_Dossier integer, Add ID_Table integer');
//     queryTmp.ExecSQL;
//
//     queryTmp.sql.Clear;
//     QueryTmp.sql.Add('INSERT INTO "'+Nom_Table+'Aux.db" SELECT * FROM "'+Nom_Table+'Tmp.db"');
//     queryTmp.ExecSQL;
//
//     queryTmp.sql.Clear;
//     QueryTmp.sql.Add('Alter Table "'+Nom_Table+'Tmp.db" Drop ID_Dossier , Drop ID_Table');
//     queryTmp.ExecSQL;
//
//     queryTmp.sql.Clear;
//     QueryTmp.sql.Add('update "'+Nom_Table+'Aux.db" set ID_Dossier='+Main.gestDos.findField('ID_Dossier').AsString+',ID_Table='+Main.gestDos.findField('ID_Table').AsString+' where Id_Dossier is null');
//     queryTmp.ExecSQL;
//     queryTmp.sql.Clear;
//     QueryTmp.sql.Add('Delete From "'+Nom_Table+'tmp.db" ');
//     queryTmp.ExecSQL;
//       end;
//      end;
//     end;
//TableTmp.Close;
//TableTmp.Free;
//queryTmp.sql.Clear;
//QueryTmp.sql.Add('DROP TABLE "'+Nom_Table+'tmp.db" ');
//queryTmp.ExecSQL;
//queryTmp.Free;
//BaseTmp.Close;
//BaseTmp.Free;
////Fin:=Now-Deb;
////Main.Button4.Caption:=DateTimeTostr(Fin);
//DMBD.DbParcours.Close;
//DMBD.DbParcours.Params.Clear;
end;

//****************************************************************************//
//               Section qui gere le transgert des donn�es n�cessaire         //
//               � l'exercice suivant                                         //
//****************************************************************************//
Procedure Clotur(IDDosEnCours,IDExoEnCours:integer);
var
ExoEnCours,ExoSuivant:string;
ListeExo:TStringList;
TableOrg,TableDest:TTable;
ID,Dat:String;
i:integer;
begin
//ID:='1';
//Main.gestDos.Close;
//Main.gestDos.Open;
//Main.gestDos.Filtered:=False;
//Main.GestDos.Filter:=CreeFiltreET(['ID_Dossier','Cloture'],[ID,'false']);
//Main.gestDos.Filtered:=true;
//
//Main.gestDos.Last;
//
//TableOrg:=TTable.Create(Main);
//TableDest:=TTable.Create(Main);
//DMBD.DbParcours.Close;
//DMBD.DbParcours.Params.Clear;
//DMBD.DbParcours.DatabaseName:=Main.gestDos.findField('Nom_Exo').AsString+'x';
//DMBD.DbParcours.Params.Add('PATH='+Main.gestDos.findField('Dir_Exo').AsString);
//DMBD.DbParcours.Params.Add('ENABLE BCD=FALSE');
//DMBD.DbParcours.Params.Add('DEFAULT DRIVER=PARADOX');
//DMBD.DbParcours.DriverName:='Standard';
//DMBD.DbParcours.Connected:=true;
//TableDest.DatabaseName:=DMBD.DbParcours.DatabaseName;
//TableOrg.DatabaseName:=DMBD.dbNameExo.DatabaseName;
////Stocks
//    TransfStocksNewExo(TableOrg,TableDest);
////TableDest.TableName:='Stock.db';
////TableOrg.TableName:='Stock.db';
////
////
////
////TableOrg.Active:=true;
////TableDest.Active:=true;
////TableOrg.Filtered:=false;
////Dat:=DateToStr(E.DatExoFin);
////TableOrg.Filter:=CreeFiltreET(['Date_Saisie'],[Dat]);
////TableOrg.Filtered:=true;
////
////TableOrg.First;
////i:=1;
////while not TableOrg.EOF do begin
////      TableDest.AppendRecord([i,TableOrg.findField('Compte').AsString,TableOrg.findField('Designation'),TableOrg.findField('Qte').AsFloat,TableOrg.findField('Prix_Unitaire').AsFloat,TableOrg.findField('Decote').AsInteger,TableOrg.findField('MontantTotalHT').AsFloat,true,TableOrg.findField('Date_Saisie').AsDateTime,TableOrg.findField('Date_ID_Exercice').AsDateTIme,Null,Null]);
////      i:=i+1;
////      TableOrg.Next;
////end;
////TableOrg.Close;
////TableDest.close;
//// fin
//DMBD.DbParcours.Close;
//DMBD.DbParcours.Params.Clear;
////ListeExo:=ListeExoDosEnCours(DosEnCours);
////ExoEnCours:=
end;

Procedure TransfStocksNewExo(var TableOrg,TableDest:TTable);
var
i:integer;
Dat:String;
begin
TableDest.TableName:='Stock.db';
TableOrg.TableName:='Stock.db';


    //    TransfStocksNewExo(TableOrg,TableDest);

TableOrg.Active:=true;
TableDest.Active:=true;
TableOrg.Filtered:=false;
Dat:=DateToStr(E.DatExoFin);
TableOrg.Filter:=CreeFiltreET(['Date_Saisie'],[Dat]);
TableOrg.Filtered:=true;

TableOrg.First;
i:=1;
while not TableOrg.EOF do begin
      TableDest.AppendRecord([i,TableOrg.findField('Compte').AsString,TableOrg.findField('Designation'),TableOrg.findField('Qte').AsFloat,TableOrg.findField('Prix_Unitaire').AsFloat,TableOrg.findField('Decote').AsInteger,TableOrg.findField('MontantTotalHT').AsFloat,true,TableOrg.findField('Date_Saisie').AsDateTime,TableOrg.findField('Date_ID_Exercice').AsDateTIme,Null,Null]);
      TableDest.FlushBuffers;
      i:=i+1;
      TableOrg.Next;
end;
TableOrg.Close;
TableDest.close;
//TableDest.Open;
//TableOrg.Open;
//TableOrg.Filtered:=false;
//TableOrg.Filter:=CreeFiltreET(['Date_Saisie'],[E.DatExoFin]);
//TableOrg.Filtered:=true;
//
//TableOrg.First;
//i:=1;
//while not TableOrg.EOF do begin
//      TableDest.AppendRecord([i,TableOrg.findField('Compte').AsString,TableOrg.findField('Designation'),TableOrg.findField('Qte').AsFloat,TableOrg.findField('Prix_Unitaire').AsFloat,TableOrg.findField('Decote').AsInteger,TableOrg.findField('MontantTotalHT').AsFloat,true,TableOrg.findField('Date_Saisie').AsDateTime,TableOrg.findField('Date_ID_Exercice').AsDateTIme,Null,Null]);
//      i:=i+1;
//      TableOrg.Next;
//end;
//TableOrg.Close;
//TableDest.close;
end;

procedure test(sender: TObject);
begin
 showmessage('click');
end;


Function GetUserFromWindows: string;
Var
   UserName : string;
   UserNameLen : Dword;
Begin
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   If GetUserName(PChar(UserName), UserNameLen) Then
     Result := Copy(UserName,1,UserNameLen - 1)
   Else
     Result := 'Unknown';
End;

function ControleOuvertureEpiceaLocked(Affiche: boolean; nomUtilisateur:String ):boolean;
var
Param:string;
continuer:integer;
 db_Message : TMsgDlgParams;
  MessageLGR_Controle:TMessageLGR;
 ecran:TComponent ;
begin
try//finally
  try//except
    if(Affiche)then
      begin
          if(Application.MainForm<>nil)then ecran:=Application.MainForm else ecran:=DosProtect;
          db_Message:=initMessageLGR(ecran,'','Dossier Occup�','Ce dossier est actuellement utilis� par '+nomUtilisateur+
          RetourChariotDouble+'Si c''est bien le cas, demandez � '+nomUtilisateur+' de fermer ce dossier, puis cliquez sur "Ouvrir". '
          +RetourChariotDouble+'Si ce n''est pas le cas, cliquez directement sur "Ouvrir".'
          +RetourChariotDouble+'Pour abandonner l''ouverture du dossier, cliquez sur "Annuler".','Choix de forcer l''ouverture d''un dossier occup�',
          [mbCancel,mbCust1],mbCancel,MessageLGR_Controle);
          db_Message.CustBtnText[mbCust1] := 'Ouvrir';
          db_Message.CheckBox:=false;

          continuer:=-1;
          if(MsgDlgBox(db_Message)=mrCancel)then result:=false else result := true;
//          continuer:=MsgDlgBox(db_Message);
//          case LoWord(continuer) of
//          mrCust1: begin
//              retour:=true;
//            end;
//          mrCancel: begin
//              retour:=false;
//            end;
//          end;//fin case

      end;//fin si Affiche

  except

  end;
finally
//
end;
end;


Function OuvreExercice(NomDossier,NomExo:string;Gauge:TGauge;Reindexation:boolean;SauveXml:boolean):TErreurSaisie;
var
InfosGestDossier:TInfosGestDossier;
InfosParam_Dossier:TInfosParam_Dossier;
InfosBascule:TInfosBascule;
Dossier_Corrige:boolean;
RetourCorrectionDossier:Texceptlgr;
Debut,Fin:TTime;
cheminFichierTemp,nomUtilisateur,cheminDossier:string;
F:textfile;

Begin
 try // Finally
  try

     Forcefermer:=false;
    // Enregistrement des donn�es XML a faire quand on passe d'un dossier � l'autre
      Debut:=Time;                    //Showmessage('');
    if SauveXml then
      SauveXMLAvantFermer;
          InitParamFTP(E.paramFTP,e.NomDossier,DM_C_ServeurFTP);
          E.paramFTP.Fichier:='';
//    Showmessage('Apres_SauveXMLAvantFermer');
  GestionGauge(10,gauge,40,0,'Chargement du dossier');

    // Fin de l'Enregistrement des donn�es XML a faire quand au passe d'un dossier � l'autre
    if DMParamEntreprise = nil then DMParamEntreprise:=TDMParamEntreprise.Create(Application.MainForm);
    if DMrech = nil then DMrech:=TDMrech.Create(Application.MainForm);
    if DMBD = nil then DMBD:=TDMBD.Create(Application.MainForm);
    DMBD.CloseAllTAble;

    DeFiltrageDataSet(DMRech.TaGestDossierRech);
    DMRech.TaGestDossierRech.Refresh;
    InfosGestDossier:=Infos_TInfosGestDossier(DMRech.TaGestDossierRech,'Nom_Dossier;Nom_Exo',[NomDossier,NomExo]);
    cheminDossier:=e.RepertoireDossier;

       //!!!!!!!!!!!!!!!!!!!!!!!v�rifier si dossier d�j� utilis� par autre utilisateur. rajouter en 2014 modifier en 2015 !!!!!!!!!!!!!!!!!!!!!!!!!!!
    if(InfosGestDossier.ResultInfos )and( cheminDossier<>InfosGestDossier.Dir_Dossier)then
      cheminDossier:=InfosGestDossier.Dir_Dossier;
    cheminFichierTemp:=IncludeTrailingPathDelimiter(cheminDossier)+fileLocked;

    //showmessage('cheminFichierTemp '+cheminFichierTemp);

    if(FileExists(cheminFichierTemp))then
    begin
      assignfile(f,cheminFichierTemp);
      reset(F);
      while not eof(F) do begin
        readln(F,nomUtilisateur);
      end;
      closefile(F);

      if( nomUtilisateur= GetUserFromWindows)then DeleteFile(Pchar(cheminFichierTemp))
      else begin
      if(not ControleOuvertureEpiceaLocked(true,nomUtilisateur))then
        begin
          Forcefermer:=true;
          abort;
        end;
      end;
    end;
    if(DirectoryExists(e.RepertoireDossier))then
       CreerFichierTexte(cheminFichierTemp,GetUserFromWindows);
       //!!!!!!!!!!!!!!!!!!!!!!!v�rifier si dossier d�j� utilis� par autre utilisateur. rajouter en 2014 modifier en 2015 !!!!!!!!!!!!!!!!!!!!!!!!!!!



    { isa  le  27/04/04 }
    E.DateVersion:='';
    E.Exo_A_Verifier:='';{ isa  le  14/02/05 }
    { isa  le  27/04/04 }

  { isa  le  06/01/05 }                                           // (e.TypeClient=cl_demo)or(e.TypeClient=CL_Saisie_Demo)
    if ((InfosGestDossier.ResultInfos)and((e.TypeUtilisateur=u_Demo))) then //23/09/2010
        InfosGestDossier.ResultInfos:=false;
  { isa  le  06/01/05 }
   if FileExists(IncludeTrailingPathDelimiter(InfosGestDossier.Dir_Dossier)+C_Version_FileNameEnCoursTraitementComptable) then
   begin
        Application.MessageBox(Pchar('Attention, Vous avez transmis votre dossier � votre comptable ou une tierce personne.'+
        retourChariotDouble+LigneSeparation+
        retourChariotDouble+'Vous ne devez pas le modifier.'+
        retourChariotDouble+LigneSeparation),'Attention',MB_ICONWARNING);

   end;
   if(InfosGestDossier.ResultInfos) and (ExerciceEpure(InfosGestDossier.Dir_Exo))then
   begin
        Application.MessageBox(Pchar('Attention !!! Exercice �pur�'),'Attention',MB_ICONWARNING);
   end;
    if InfosGestDossier.ResultInfos then
       begin
//    Showmessage('InfosGestDossier.ResultInfos');
         // Initialisation des param�tres du dossier venant de GestDossier
         // La description entreprise n'est peut-�tre pas faite !!!
          E.RepertoireExercice:=IncludeTrailingPathDelimiter(InfosGestDossier.Dir_Exo);
          E.RepertoireDossier:=IncludeTrailingPathDelimiter(InfosGestDossier.Dir_Dossier);
          E.RepertoireExportDossier := '';
          E.NomExo:=InfosGestDossier.Nom_Exo;
          E.NomDossier:=InfosGestDossier.Nom_Dossier;
          E.ID_Dos:=InfosGestDossier.ID_Dossier;
          E.ID_Exo:=InfosGestDossier.ID_Table;
          E.DatExoDebut:=InfosGestDossier.DATE_DEB_EXO;
          E.DatExoFin:=InfosGestDossier.DATE_FIN_EXO;
          E.ExerciceBase:=InfosGestDossier.EXO_BASE;
          E.ExerciceSaisie:=InfosGestDossier.EXO_SAISIE;
          E.ExerciceCloture:=InfosGestDossier.Cloture;
//isa le 11/12/2008
           E.RepertoireImportationEpiDos := C_RepImportationEpiDos;
          E.RepertoireImportationSIEA := E.RepertoireProgram + C_RepImportationSIEA;
          E.RepertoireImportation := E.RepertoireDossier + C_RepImportation;
          E.RepertoireImportEPI_DOS := E.RepertoireProgram + 'Importation\';
          E.RepertoireExportBalance := E.RepertoireProgram + C_RepExportation;
          E.RepertoireExportLiasse := E.RepertoireProgram + C_RepExportationLiasse;
          E.RepertoireRelanceTiers := E.RepertoireDossier + C_RepExportation;
          E.RepertoireDblSauvegarde:= C_StrVide;
          E.RepertoireSauvegardeFermture:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'SauvegardeFermeture';
          E.RepertoireSauvegardeFermtureCloud:='';
          E.CompteBanqueDefaut := C_StrVide;
          //E.NomSauvegarde :=C_StrVide;  //param�tre au programme
//isa
          E.paramFTP.Fichier:=IncludeTrailingPathDelimiter(InfosGestDossier.Dir_Dossier)+C_ParamFTP;
//          AjouterFichierTexte('C:\messagesEpicea','(OuvreExercice)IncludeTrailingPathDelimiter(InfosGestDossier.Dir_Dossier)+C_ParamFTP : '+E.ParamFTP.Fichier);
          case Type_version_execution of
            CT_DEVELOPPEMENT:Begin

                             End;

            CT_DISTRIBUTION:Begin
                              if E.DatExoFin > E.DAteFinUtilisationEpicea then
                               begin
                                Application.MessageBox(Pchar('ATTENTION,'+#13+#10+''+#13+#10+'VOTRE PROGRAMME N''EST PAS PROTEGE !'+AppelerServiceMaintenance),'Attention',MB_ICONWARNING);
                               // MessageDlg('ATTENTION,'+#13+#10+''+#13+#10+'VOTRE PROGRAMME N''EST PAS PROTEGE !'+AppelerServiceMaintenance, mtWarning, [mbOK], 0);
                                abort;
                               end;

                            End;

          else showmessage('Le type de l''ex�cutable n''est pas d�fini !');
          end;
  GestionGauge(10,gauge,-1,-1,'');

          //
//          E.RaisonSociale:=Infos_TInfosParam_Dossier(dmrech.TaParam_DossierRech,'Cle',[1]).NOM_DOSS;
          //
//          E.AccesOuverture := not E.ExerciceCloture;
//          if E.ID_Exo > 1 then E.AccesOuverture := false;
//
//          E.AccesCloture := not E.ExerciceCloture;


          DMBD.InitBDDossier(E.RepertoireDossier);
          DMBD.InitBDExercice(E.RepertoireExercice);
//Showmessage('Apres_InitBDExercice');

          GenereDMDossier;
//Showmessage('Apres_GenereDMDossier');

//          if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);
//          if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.create(application.MainForm);
//          if DMEcritures = nil then DMEcritures :=TDMEcritures.Create(application.MainForm);
//          if DMPieces = nil then DMPieces:= TDMPieces.Create(application.MainForm);

          //mise � jour des parametres du dossier (dates debut, fin et exo_Saisie) et
          //mise � jour de la balance si ouverture de l'exo N+1
          try
            InfosBascule.DateDeb:=InfosGestDossier.DATE_DEB_EXO;
            InfosBascule.DateFin:=InfosGestDossier.DATE_FIN_EXO;
            InfosBascule.ExoSaisie:=InfosGestDossier.EXO_SAISIE;


            if ((GestDossierDatesRemplies(NomDossier,NomExo))and(ParamEntrepriseRemplis=2))then
               begin
//                  Showmessage('Avant_MiseAJourParamDossier_SurOuvertureExo');
                  DMParamEntreprise.MiseAJourParamDossier_SurOuvertureExo(InfosBascule);
                  FermerTouteTable('',TControl(DMParamEntreprise));
                  DMBD.CloseAllTAble;
//                  Showmessage('Apres_CloseAllTAble');
                  if Verif_Si_Ouverture_ExoN1(NomDossier,NomExo) then
                    Begin //si on ouvre N+1
                    //Showmessage('Avant_MiseAJourGlobalBalance_N_vers_N1');
                      //initialiser la base sur l'exo N pour r�cup�rer les infos � mettre sur N+1
                      try
                      CreateTablesExo(ChercheInfos_ExoN(e.NomDossier).Dir_Exo);
                      DMBD.InitBDExercice(ChercheInfos_ExoN(e.NomDossier).Dir_Exo);
                      //mise � jour de la balance d'ouverture de N+1
                      DMBalance.MiseAJourGlobalBalance_N_vers_N1(false);
                      DMBalance.MiseAJourGlobalBalanceTiers_N_vers_N1;
                      DMBalance.MiseAJourDuResultatDansN1(false);
                      except
                      end;
                      //Showmessage('Apres_MiseAJourGlobalBalance_N_vers_N1');
                    end //fin si on ouvre N+1
                    else
                    begin
                      DMBD.InitBDExercice(ChercheInfos_ExoN(e.NomDossier).Dir_Exo);
                      if(E.ControleDuDossier)then DMBalance.ControlBalanceTiersReport2(gauge,true);
                      coherenceImmosReport(gauge,false,1);
                      CorrectionPlanComptableTauxTva(false);
                    end;
               end;
          except
            showmessage('Probl�me � v�rif si ExoN+1');
          end;
          E.AccesOuverture := not E.ExerciceCloture;
          if E.ID_Exo > 1 then E.AccesOuverture := false;

          E.AccesCloture := not E.ExerciceCloture;

          DMBD.CloseAllTAble;
          FermerTouteTable('',TControl(DMParamEntreprise));

          DMBD.InitBDDossier(E.RepertoireDossier);
          DMBD.InitBDExercice(E.RepertoireExercice);
//          Showmessage('Apres_InitBDExercice_2');
  GestionGauge(10,gauge,-1,-1,'');

          DMParamEntreprise.taParamDossierChampLectureSeule(DMParamEntreprise.taParamDoss,E.TypeDossier,0);
          Init_E_Entreprise_Avec_TaParamEntreprise;
//          Showmessage('Apres_Init_E_Entreprise_Avec_TaParamEntreprise');

  //        E.PlanAuxT:=PlanAuxT;
  //        E.TypeDossier:=DossierTypeDossier;
  //        E.TypeEntreprise:=DossierTypeEntreprise;
  //        E.Regime:=DossierTypeRegime;
          DMBD.Verif_Init_Table_De_Base_Dossier_Non_Vide(E.RepertoireDossier);
//          Showmessage('Apres_Verif_Init_Table_De_Base_Dossier_Non_Vide');
          DMBD.Verif_Init_Table_De_Base_Exercice_Non_Vide(E.RepertoireExercice);
//          Showmessage('Apres_Verif_Init_Table_De_Base_Exercice_Non_Vide');
          GEstDossierMaJDateUtilDossier(InfosGestDossier.Nom_Dossier,InfosGestDossier.Nom_Exo,E.RaisonSociale);
//          Showmessage('Apres_GEstDossierMaJDateUtilDossier');
          DMBD.OpenAllTAble;
//          Showmessage('Apres_OpenAllTAble');
          try
          // Importation EPIDOS
           try
           E.ParamFTP.Fichier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_ParamFTP);
           E.RepTelechargementReleve:=DMXml.RetourneValVarDos(E.NomDossier,CXML_RepTelechargementReleve);
           except
           end;
             if empty(E.ParamFTP.Fichier) then
                E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;
//             AjouterFichierTexte('C:\messagesEpicea','(DMXml.RetourneValVarDos(E.NomDossier,CXML_ParamFTP))E.RepertoireDossier + C_ParamFTP : '+E.ParamFTP.Fichier);
           LitFichierParamFTP(e.ParamFTP.Fichier,e.ParamFTP,false,e.NomDossier,DM_C_ServeurFTP,e.ParamFTP,e.RepertoireDossier);
           if ((e.ParamFTP.PassWord='') or (e.ParamFTP.Login=''))and (e.ParamFTP.Serveur<>DM_C_ServeurFTP) then
             begin
               InitParamFTP(E.paramftp,e.NomDossier,DM_C_ServeurFTP);
               EcritFichierParamFTP(E.paramftp,E.paramftp);
             end
           else
           if e.ParamFTP.Serveur<>DM_C_ServeurFTP then
              begin
                e.ParamFTP.Serveur:=DM_C_ServeurFTP ;
                if e.ParamFTP.Effacer='' then e.ParamFTP.Effacer:='o';
                e.ParamFTP.Auto:='a';
                EcritFichierParamFTP(e.ParamFTP,E.paramftp);
              end;

           E.RepertoireImportationEpiDos := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportationEpiDos);
//          Showmessage('Apres_RetourneValVarDos_RepertoireImportationEpiDos');
          // Importation SIEA
          E.RepertoireImportationSIEA := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportationSIEA);
//          Showmessage('Apres_RetourneValVarDos_RepertoireImportationSIEA');
          // Importation En G�n�ral
          E.RepertoireImportation := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportation);
//          Showmessage('Apres_RetourneValVarDos_RepertoireImportation');
          E.RepertoireImportEPI_DOS := DMXml.RetourneValVarDos(E.NomDossier,'DirImp');
//          Showmessage('Apres_RetourneValVarDos_RepertoireImportEPI_DOS');
          E.DateVersion:=DMXml.RetourneValVarDos(E.NomDossier,CXML_DateVersion);
          E.Exo_A_Verifier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_Exo_A_Verifier);
//          Showmessage('Apres_RetourneValVarDos_DateVersion');
         E.RepertoireExportBalance := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationBalance);
         E.RepertoireExportLiasse := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationLiasse);

         E.RepertoireExportDossier := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationDossier);

         E.RepertoireRelanceTiers := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepRelanceTiers);
         // fichier de param�tres FTP

//          Showmessage('Apres_RetourneValVarDos_RepertoireExportBalance');
         E.RepertoireDblSauvegarde:= DMXml.RetourneValVarDos(E.NomDossier,CXML_RepDblSauvegarde);
         E.RepertoireSauvegardeFermture:= DMXml.RetourneValItemProgramme(CXML_RepSauvegardeFermeture);
         E.RepertoireSauvegardeFermtureCloud:= DMXml.RetourneValItemProgramme(CXML_RepSauvegardeFermetureCloud);

         E.ExtensionFEC := DMXml.RetourneValVarDos(E.NomDossier,CXML_ExtensionFEC);
         E.SeparateurFEC := DMXml.RetourneValVarDos(E.NomDossier,CXML_SeparateurFEC);
         E.DatePieceFEC := StrToBool_Lgr(DMXml.RetourneValVarDos(E.NomDossier,CXML_DatePieceFEC),false);

         E.CompteBanqueDefaut := DMXml.RetourneValVarDos(E.NomDossier,CXML_CompteBanqueDefaut);
         E.TauxTvaCaisseEnregistreuse := DMXml.RetourneValVarDos(E.NomDossier,CXML_TauxTvaCaisseEnregistreuse);
         E.ComptePointableCaisseEnregistreuse := DMXml.RetourneValVarDos(E.NomDossier,CXML_ComptePointableCaisseEnregistreuse);
   if (empty(E.CompteBanqueDefaut ))and(str_recherchesouschaine(Uppercase(E.RepertoireProgram),'LGR\EPICEA').retour=true)then
                E.CompteBanqueDefaut := Infos_TInfosModel(DMRech.TaModelRech,'journal',['B1']).Compte;


                  if empty(E.ExtensionFEC) then  E.ExtensionFEC := C_ExtensionFEC;
        if empty(E.SeparateurFEC) then  E.SeparateurFEC := C_SeparateurFEC;

          if empty(E.TauxTvaCaisseEnregistreuse) then  E.TauxTvaCaisseEnregistreuse := C_TauxTvaCaisseEnregistreuse;
          if empty(E.ComptePointableCaisseEnregistreuse) then E.ComptePointableCaisseEnregistreuse :=C_ComptePointableCaisseEnregistreuse;
          E.NomSauvegarde :=DMXml.RetourneValItemProgramme(CXML_NomSauvegarde);
//          ShowMessage('Ouverture du dossier r�ussie.');
//         Showmessage('Apres_RetourneValVarDos_RepertoireDblSauvegarde');
         except
          // Importation EPIDOS
          if empty(E.RepertoireImportationEpiDos) then
                E.RepertoireImportationEpiDos := C_RepImportationEpiDos;

          // Importation SIEA
          if empty(E.RepertoireImportationSIEA) then
                E.RepertoireImportationSIEA := E.RepertoireProgram + C_RepImportationSIEA;

          // Importation En G�n�ral
          if empty(E.RepertoireImportation) then
                E.RepertoireImportation := E.RepertoireDossier + C_RepImportation;

         if empty(E.RepertoireImportEPI_DOS) then
             E.RepertoireImportEPI_DOS := E.RepertoireProgram + 'Importation\';

         // Repertoire Exportation Balance
          if empty(E.RepertoireExportBalance) then
                E.RepertoireExportBalance := E.RepertoireProgram + C_RepExportation;

          // fichier de param�tres FTP
          if empty(E.ParamFTP.Fichier) then
                E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;
//          AjouterFichierTexte('C:\messagesEpicea','E.RepertoireDossier + C_ParamFTP : '+E.ParamFTP.Fichier)

         // Repertoire Exportation Relance des tiers
          if empty(E.RepertoireRelanceTiers) then
                E.RepertoireRelanceTiers := E.RepertoireDossier + C_RepExportation;

         // Repertoire Exportation liasse
          if empty(E.RepertoireExportLiasse) then
                E.RepertoireExportLiasse := E.RepertoireProgram + C_RepExportationLiasse;

         // Repertoire Exportation Dossier
          if empty(E.RepertoireExportDossier) then
                E.RepertoireExportDossier := E.RepertoireDossier + C_RepExportation;

   if (empty(E.CompteBanqueDefaut ))and(str_recherchesouschaine(Uppercase(E.RepertoireProgram),'LGR\EPICEA').retour=true)then
                E.CompteBanqueDefaut := Infos_TInfosModel(DMRech.TaModelRech,'journal',['B1']).Compte;

                        if empty(E.ExtensionFEC) then  E.ExtensionFEC := C_ExtensionFEC;
        if empty(E.SeparateurFEC) then  E.SeparateurFEC := C_SeparateurFEC;

        
          if empty(E.TauxTvaCaisseEnregistreuse) then  E.TauxTvaCaisseEnregistreuse := C_TauxTvaCaisseEnregistreuse;
          if empty(E.ComptePointableCaisseEnregistreuse) then E.ComptePointableCaisseEnregistreuse :=C_ComptePointableCaisseEnregistreuse;

          E.NomSauvegarde :='';
         E.RepertoireDblSauvegarde:= C_StrVide;
         E.RepertoireSauvegardeFermture:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'SauvegardeFermeture';
         E.RepertoireSauvegardeFermtureCloud:='';


         E.ExtensionFEC := '.csv';
         E.SeparateurFEC := '|';
         E.DatePieceFEC := false;

         end;
         //ShowMessage('Ouverture du dossier r�ussie.');
       end
    else
       begin
  GestionGauge(10,gauge,-1,-1,'');

         E.ID_Dos:=0;
         E.ID_Exo:=0;
         E.DatExoDebut:=E.DatExoDemoDebut;
         E.DatExoFin:=E.DateExoDemoFin;
         E.TypeDossier:=E.TypeDossierdemo;
         E.PlanAuxT:=true;
         InitParamFTP(e.paramFTP,e.NomDossier,DM_C_ServeurFTP);
         e.paramFTP.Fichier:='';
         case E.TypeDossierdemo of
         VerDemoAgri,VerDemoGeneral:
                     begin
                     case E.TypeDossierdemo of
                       VerDemoAgri:begin
                                     E.Regime:='A';
                                   end;
                       VerDemoGeneral:begin
                                     E.Regime:='I';
                                   end;
                     end;

                      E.RepertoireExercice:=E.RepertoireProgram + 'Demo\ExoDemo\';
                      E.RepertoireDossier:=E.RepertoireProgram + 'Demo\';
                      E.NomDossier:=DM_C_NomAliasDemo;
                      E.NomExo:=DM_C_NomAliasExoDemo;
                      E.ParamFTP.Fichier:=E.RepertoireDossier+c_paramFTP;
//                      AjouterFichierTexte('C:\messagesEpicea','E.RepertoireDossier + C_ParamFTP : '+E.ParamFTP.Fichier);
                     end;
         VerDemoDioc:begin
                      E.Regime:='D';
                      E.RepertoireExercice:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
                      E.RepertoireDossier:=E.RepertoireProgram+ 'DosParoisse\';
                      E.NomDossier:='DosParoisse';
                      E.NomExo:='ExoParoisse';
                     end;
         end;
         ///
         DMBD.CloseAllTAble;
         DMBD.InitBDDossier(E.RepertoireDossier);
         DMBD.InitBDExercice(E.RepertoireExercice);

         GenereDMDossier;

        if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm);
        if DMDiocEtatBal=nil then DMDiocEtatBal:=TDMDiocEtatBal.create(application.MainForm);

         // cr�� si nescessaire l'enregistrement dans TaParamDoss, pour la description d'entreprise
         DMParamEntreprise.taParamDossAfterOpen(DMParamEntreprise.taParamDoss);

         Init_E_Entreprise_Avec_TaParamEntreprise;

         case E.TypeDossierdemo of
         VerDemoAgri,VerDemoGeneral:
                     begin
                     case E.TypeDossierdemo of
                       VerDemoAgri:begin
                                     E.Regime:='A';
                                   end;
                       VerDemoGeneral:begin
                                     E.Regime:='I';
                                   end;
                     end;

                      E.RepertoireExercice:=E.RepertoireProgram + 'Demo\ExoDemo\';
                      E.RepertoireDossier:=E.RepertoireProgram + 'Demo\';
                      E.NomDossier:=DM_C_NomAliasDemo;
                      E.NomExo:=DM_C_NomAliasExoDemo;
                     end;
         VerDemoDioc:begin
                      E.Regime:='D';
                      E.RepertoireExercice:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
                      E.RepertoireDossier:=E.RepertoireProgram+ 'DosParoisse\';
                      E.NomDossier:='DosParoisse';
                      E.NomExo:='ExoParoisse';
                     end;
         end;
         DMBD.Verif_Init_Table_De_Base_Dossier_Non_Vide(E.RepertoireDossier);
         DMBD.Verif_Init_Table_De_Base_Exercice_Non_Vide(E.RepertoireExercice);
         DMBD.OpenAllTAble;
  GestionGauge(10,gauge,-1,-1,'');
         try
          // Importation EPIDOS
          E.RepertoireImportationEpiDos := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportationEpiDos);

          // Importation SIEA
          E.RepertoireImportationSIEA := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportationSIEA);

          // Importation En G�n�ral
          E.RepertoireImportation := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportation);

         E.RepertoireImportEPI_DOS := DMXml.RetourneValVarDos(E.NomDossier,'DirImp');

         E.DateVersion:=DMXml.RetourneValVarDos(E.NomDossier,CXML_DateVersion);

         E.Exo_A_Verifier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_Exo_A_Verifier);

         E.RepertoireExportBalance := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationBalance);

         E.RepertoireExportLiasse := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationLiasse);

         E.RepertoireRelanceTiers  := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepRelanceTiers);

         // fichier de param�tres FTP
         E.ParamFTP.Fichier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_ParamFTP);
//         AjouterFichierTexte('C:\messagesEpicea','DMXml.RetourneValVarDos(E.NomDossier,CXML_ParamFTP) : '+E.ParamFTP.Fichier);
          if empty(E.ParamFTP.Fichier) then
                E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;
//          AjouterFichierTexte('C:\messagesEpicea','E.RepertoireDossier + C_ParamFTP : '+E.ParamFTP.Fichier);
         E.RepTelechargementReleve:=DMXml.RetourneValVarDos(E.NomDossier,CXML_RepTelechargementReleve);

         E.RepertoireDblSauvegarde:= DMXml.RetourneValVarDos(E.NomDossier,CXML_RepDblSauvegarde);
         E.RepertoireSauvegardeFermture:= DMXml.RetourneValItemProgramme(CXML_RepSauvegardeFermeture);
          E.RepertoireSauvegardeFermtureCloud:= DMXml.RetourneValItemProgramme(CXML_RepSauvegardeFermetureCloud);

          
         E.ExtensionFEC := DMXml.RetourneValVarDos(E.NomDossier,CXML_ExtensionFEC);
         E.SeparateurFEC := DMXml.RetourneValVarDos(E.NomDossier,CXML_SeparateurFEC);
         E.DatePieceFEC := StrToBool_Lgr(DMXml.RetourneValVarDos(E.NomDossier,CXML_DatePieceFEC),false);

         E.CompteBanqueDefaut := DMXml.RetourneValVarDos(E.NomDossier,CXML_CompteBanqueDefaut);
         E.NomSauvegarde :=DMXml.RetourneValItemProgramme(CXML_NomSauvegarde);
         E.RepertoireExportDossier := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationLiasse);

         E.ComptePointableCaisseEnregistreuse := DMXml.RetourneValVarDos(E.NomDossier,CXML_ComptePointableCaisseEnregistreuse);
         E.TauxTvaCaisseEnregistreuse := DMXml.RetourneValVarDos(E.NomDossier,CXML_TauxTvaCaisseEnregistreuse);
         except
          // Importation EPIDOS
          if empty(E.RepertoireImportationEpiDos) then
                E.RepertoireImportationEpiDos := C_RepImportationEpiDos;

          // Importation SIEA
          if empty(E.RepertoireImportationSIEA) then
                E.RepertoireImportationSIEA := E.RepertoireProgram + C_RepImportationSIEA;

          // Importation En G�n�ral
          if empty(E.RepertoireImportation) then
                E.RepertoireImportation := E.RepertoireDossier + C_RepImportation;

         if empty(E.RepertoireImportEPI_DOS) then
             E.RepertoireImportEPI_DOS := E.RepertoireProgram + 'Importation\';

         // Repertoire Exportation Balance
          if empty(E.RepertoireExportBalance) then
                E.RepertoireExportBalance := E.RepertoireProgram + C_RepExportation;

         // Repertoire Exportation Relance des tiers
          if empty(E.RepertoireRelanceTiers) then
                E.RepertoireRelanceTiers := E.RepertoireDossier + C_RepExportation;

          // fichier de param�tres FTP
          if empty(E.ParamFTP.Fichier) then
                E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;
//          AjouterFichierTexte('C:\messagesEpicea','E.RepertoireDossier + C_ParamFTP : '+E.ParamFTP.Fichier);
          if empty(e.RepTelechargementReleve)then
               E.RepTelechargementReleve:=DMXml.RetourneValVarDos(E.NomDossier,CXML_RepTelechargementReleve);

         // Repertoire Exportation liasse
          if empty(E.RepertoireExportLiasse) then
                E.RepertoireExportLiasse := E.RepertoireProgram + C_RepExportationLiasse;

         // Repertoire Exportation Dossier
          if empty(E.RepertoireExportDossier) then
                E.RepertoireExportDossier := E.RepertoireDossier + C_RepExportation;

         // Compte de banque par d�faut
   if (empty(E.CompteBanqueDefaut ))and(str_recherchesouschaine(Uppercase(E.RepertoireProgram),'LGR\EPICEA').retour=true)then
                E.CompteBanqueDefaut := Infos_TInfosModel(DMRech.TaModelRech,'journal',['B1']).Compte;

                  if empty(E.ExtensionFEC) then  E.ExtensionFEC := C_ExtensionFEC;
        if empty(E.SeparateurFEC) then  E.SeparateurFEC := C_SeparateurFEC;

          if empty(E.TauxTvaCaisseEnregistreuse) then  E.TauxTvaCaisseEnregistreuse := C_TauxTvaCaisseEnregistreuse;
          if empty(E.ComptePointableCaisseEnregistreuse) then E.ComptePointableCaisseEnregistreuse :=C_ComptePointableCaisseEnregistreuse;
                          
          E.NomSauvegarde :='';
         E.RepertoireDblSauvegarde:= C_StrVide;
         E.RepertoireSauvegardeFermture:=IncludeTrailingPathDelimiter(E.RepertoireProgram)+'SauvegardeFermeture';
          E.RepertoireSauvegardeFermtureCloud:='';
         end;
       AfficheAvertDemo;
       end;
//      showmessage('avant verif');
      if ((Type_version_execution<>CT_DEVELOPPEMENT) and (E.ControleDuDossier)and(E.ID_Dos<>0)) then
//      AjouterFichierTexte(e.RepertoireProgram+'-Rapport.txt',e.NomDossier+' - 1');
//      if ((Type_version_execution<>CT_DEVELOPPEMENT) and (E.ControleDuDossier)) then
       begin
//        showmessage('Devrait controler');
      AjouterFichierTexte(e.RepertoireProgram+'-Rapport.txt',e.NomDossier+' - 2');
//        if ((E.DateVersion<>C_Date+'-'+C_Version)and(E.DateVersion<>'14/10/04-1.2.0.19')) then
        if gauge<>nil then
          begin
            if DateDsIntervale(strtodate('15/12/2006'),StrToDate_Lgr(GetStringElement(E.DateVersion,1,'-'),0),now)then
//               E.DateVersion:=C_Date+'-'+C_Version;
               E.DateVersion:=numVersion.DateVersion+'-'+numVersion.Version;
            if (E.DateVersion<>numVersion.DateVersion+'-'+numVersion.Version)then
                Begin
                  try//finally
                      try //except
//                       //showmessage('Version : '+E.DateVersion);
//                       //showmessage('Correction du dossier, Veuillez patientez s''il vous plait');
//                       PatienterAffich(true);
//                       RetourCorrectionDossier:=CorrectionTotal(gauge,false);
//      //                 AjouterFichierTexte(e.RepertoireProgram+'-Rapport.txt',e.NomDossier+' - 3');
//                       if RetourCorrectionDossier.retour=false then
//                         abort;
//                      E.DateVersion:=numVersion.DateVersion+'-'+numVersion.Version;
                      except
                          //MessageDlg('Le contr�le du dossier ne s''est pas d�roul� correctement Erreur N� :'+inttostr(RetourCorrectionDossier.NumErreur) , mtWarning, [mbOK], 0);
                      end;
                  finally
                    PatienterFermer;
                  end;
                end
              else
//      //        if ((E.ControleDuDossier)and(e.TypeClient=cl_isa)and (Reindexation)) then
//              if ((E.ControleDuDossier)and (Reindexation)) then
//                begin
//                  //showmessage('R�indexation du dossier, Veuillez patientez s''il vous plait');
//                  ReindexationTableProc(nil,Gauge,true,false);
//                  CorrectionDesTiers_ou_Libelle(false,nil,false);
//                  CorrectionDesTiers_ou_Libelle(true,nil,false);
//                end;
          end;
        //           E.DateVersion:=C_Date+'-'+C_Version;
//        if not VerifCoherence_ResteDC_Ecriture.retour then
//         Begin
//          CorrectionDesPointages;
//         End;


       end;
       E.ControleDuDossier := true;
//       GenereDMDossier;
//      showmessage('apres verif');

  except
  if(not Forcefermer)then
  begin
         DMBD.CloseAllTAble;
         E.ID_Dos:=0;
         E.ID_Exo:=0;
         E.DatExoDebut:=E.DatExoDemoDebut;
         E.DatExoFin:=E.DateExoDemoFin;
         E.TypeDossier:=E.TypeDossierdemo;
         E.PlanAuxT:=true;
         case E.TypeDossierdemo of
         VerDemoAgri,VerDemoGeneral:
                     begin
                     case E.TypeDossierdemo of
                       VerDemoAgri:begin
                                     E.Regime:='A';
                                   end;
                       VerDemoGeneral:begin
                                     E.Regime:='I';
                                   end;
                     end;
                      E.RepertoireExercice:=E.RepertoireProgram + 'Demo\ExoDemo\';
                      E.RepertoireDossier:=E.RepertoireProgram + 'Demo\';
                      E.NomDossier:=DM_C_NomAliasDemo;
                      E.NomExo:=DM_C_NomAliasExoDemo;
                     end;
         VerDemoDioc:begin
                      E.Regime:='D';
                      E.RepertoireExercice:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
                      E.RepertoireDossier:=E.RepertoireProgram+ 'DosParoisse\';
                      E.NomDossier:='DosParoisse';
                      E.NomExo:='ExoParoisse';
                     end;
         end;
         DMBD.CloseAllTAble;
         DMBD.InitBDDossier(E.RepertoireDossier);
         DMBD.InitBDExercice(E.RepertoireExercice);
         Init_E_Entreprise_Avec_TaParamEntreprise;

         case E.TypeDossierdemo of
         VerDemoAgri,VerDemoGeneral:
                     begin
                     case E.TypeDossierdemo of
                       VerDemoAgri:begin
                                     E.Regime:='A';
                                   end;
                       VerDemoGeneral:begin
                                     E.Regime:='I';
                                   end;
                     end;

                      E.RepertoireExercice:=E.RepertoireProgram + 'Demo\ExoDemo\';
                      E.RepertoireDossier:=E.RepertoireProgram + 'Demo\';
                      E.NomDossier:=DM_C_NomAliasDemo;
                      E.NomExo:=DM_C_NomAliasExoDemo;
                     end;
         VerDemoDioc:begin
                      E.Regime:='D';
                      E.RepertoireExercice:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
                      E.RepertoireDossier:=E.RepertoireProgram+ 'DosParoisse\';
                      E.NomDossier:='DosParoisse';
                      E.NomExo:='ExoParoisse';
                     end;
         end;

         DMBD.Verif_Init_Table_De_Base_Dossier_Non_Vide(E.RepertoireDossier);
         DMBD.Verif_Init_Table_De_Base_Exercice_Non_Vide(E.RepertoireExercice);
         DMBD.OpenAllTAble;
          // Importation EPIDOS
          if empty(E.RepertoireImportationEpiDos) then
                E.RepertoireImportationEpiDos := C_RepImportationEpiDos;

          // Importation SIEA
          if empty(E.RepertoireImportationSIEA) then
                E.RepertoireImportationSIEA := E.RepertoireProgram + C_RepImportationSIEA;

          // Importation En G�n�ral
          if empty(E.RepertoireImportation) then
                E.RepertoireImportation := E.RepertoireDossier + C_RepImportation;

         if empty(E.RepertoireImportEPI_DOS) then
             E.RepertoireImportEPI_DOS := E.RepertoireProgram + 'Importation\';

         // Repertoire Exportation Balance
          if empty(E.RepertoireExportBalance) then
                E.RepertoireExportBalance := E.RepertoireProgram + C_RepExportation;

         // Repertoire Exportation Relance des tiers
          if empty(E.RepertoireRelanceTiers) then
                E.RepertoireRelanceTiers := E.RepertoireDossier + C_RepExportation;


          // fichier de param�tres FTP
          if empty(E.ParamFTP.Fichier) then
                E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;
//          AjouterFichierTexte('C:\messagesEpicea','E.RepertoireDossier + C_ParamFTP : '+E.ParamFTP.Fichier);
          
         // Repertoire Exportation Liasse
          if empty(E.RepertoireExportLiasse) then
                E.RepertoireExportLiasse := E.RepertoireProgram + C_RepExportationLiasse;

         // Repertoire Exportation Dossier
          if empty(E.RepertoireExportDossier) then
                E.RepertoireExportDossier := E.RepertoireDossier + C_RepExportation;

                         // Compte de banque par d�faut
   if (empty(E.CompteBanqueDefaut ))and(str_recherchesouschaine(Uppercase(E.RepertoireProgram),'LGR\EPICEA').retour=true)then
                E.CompteBanqueDefaut := Infos_TInfosModel(DMRech.TaModelRech,'journal',['B1']).Compte;


        if empty(E.ExtensionFEC) then  E.ExtensionFEC := C_ExtensionFEC;
        if empty(E.SeparateurFEC) then  E.SeparateurFEC := C_SeparateurFEC;
                
          if empty(E.TauxTvaCaisseEnregistreuse) then  E.TauxTvaCaisseEnregistreuse := C_TauxTvaCaisseEnregistreuse;
          if empty(E.ComptePointableCaisseEnregistreuse) then E.ComptePointableCaisseEnregistreuse :=C_ComptePointableCaisseEnregistreuse;


          E.NomSauvegarde :='';
         E.RepertoireDblSauvegarde:= C_StrVide;
         E.RepertoireSauvegardeFermture:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'SauvegardeFermeture';
          E.RepertoireSauvegardeFermtureCloud:='';

       AfficheAvertDemo;
       end
       else         DosProtect.ModalResult:=mrcancel;
  end;//fin except

 Finally
          e.PeriodeAutre.retour:=false;
          e.PeriodeAutre.DateDeb:=e.DatExoDebut;
          e.PeriodeAutre.DateFin:=e.DatExoFin;
          e.PeriodeAutreImpression.retour:=false;
          e.PeriodeAutreImpression.DateDeb:=0;
          e.PeriodeAutreImpression.DateFin:=e.DatExoFin;

  DMXML.AjouteDossier(E.NomDossier,E.RepertoireDossier);
  // v�rification de l'environnement de syst�me de r�pertoire
  // Concernant le dossier en cours
  // Repertoire de Sauvegarde
  if not DirectoryExists(PAramUtil.RepertoireSauvegarde+E.NomDossier) then
           ForceDirectories(PAramUtil.RepertoireSauvegarde+E.NomDossier);

  // Cr�ation du Fichier CE-CPAR.txt pour permettre l'exportation des fichiers
  // d'�change entre Epicea et : Sara, E2-Fac.
  CreerFichierTexte(E.RepertoireDossier+'CE-CPAR.fic','');
  if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
    case E.TypeDossier of
      VerAgricole,
      VerGeneral,
      VerDemoGeneral,
      VerDemoAgri:begin
                    try
                    if DMPlan <> nil then DMPlan.GestionDesComptesObligatoireDsPlanCpt(false);
                    except
                    end;
                  end;
      VerDiocese:begin

                  end;

    end;//fin du case
 //si pas d�j� faite, d�clencher correction du dossier (suivant date de mise � jour=date version)
      Fin:=Time;
      AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'OuvertureDossier.txt','Debut : '+TimeToStr(Debut)
      +' - Fin : '+TimeToStr(Fin));
     //ShowMessage('Ouverture du dossier r�ussie.');
GestionGauge(0,gauge,0,0,'',false);
if (Main<>nil) then Main.EdDossierTransmis1.Visible:=FileExists(IncludeTrailingPathDelimiter(InfosGestDossier.Dir_Dossier)+C_Version_FileNameEnCoursTraitementComptable);
if (Main<>nil) then Main.EdDossierTransmis2.Visible:=FileExists(IncludeTrailingPathDelimiter(InfosGestDossier.Dir_Dossier)+C_Version_FileNameEnCoursTraitementComptable);
if (Main<>nil) then Main.EdExerciceEpure.Visible:=(ExerciceEpure(InfosGestDossier.Dir_Exo));
 end;//fin finally
End;


//V�rifie si l'ouverture en cours concerne l'exo N+1
Function Verif_Si_Ouverture_ExoN1(Dossier,Exo:string):boolean;
var
ExoN1:TInfosGestDossier;
Begin
try//except
  ExoN1:=ChercheInfos_ExoN1(dossier);
  result:=((ExoN1.Nom_Dossier=dossier)and(ExoN1.Nom_Exo=Exo));
except
  result:=false;
end;//fin except
end;

// Les param�tres � passer pour sauver un dossier sont :
// Nomdudossier
// Repertoire du dossier

function trouveFichierCloud():boolean;
var
datefichier:tdate;
retour:boolean;
nomFichier:string;
begin
retour:=false;
nomFichier:='.csync_journal.db';
if(FileExists(IncludeTrailingPathDelimiter(e.RepertoireSauvegardeFermtureCloud)+nomFichier)) then retour:=true;
if(retour)then
begin
datefichier:=FileDateToDateTime(FileAge(IncludeTrailingPathDelimiter(e.RepertoireSauvegardeFermtureCloud)+nomFichier)) ;
if(CompareDate(datefichier,now-15)>0)then retour:=false;
end;
   result:=retour;
end;

Function SauveDossierAvantFermeture(ListeDossier:TStringList;Texte:string;VerrouDossier:boolean):Boolean;
var
    Aux,
    NomDuDossier,
    RepertoireDuDossier,
    RepSauvCopie,
    RepSauveZip,
    NomFicSauvegarde,
    RepACopier:
    String;
    //f:TextFile;
    ligne:string;
    ProgSauvegarde:
    PChar;

    DateFic:TDate;

  StartupInfo: TStartupinfo;

  ProcessInfo: TProcessInformation;
  Handle1 : Integer;
  fileExist:boolean;

begin
fileExist:=FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable);
if fileExist then
  DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable));

CreeRepertoire(IncludeTrailingPathDelimiter(E.RepertoireSauvegardeFermture),true) ;
if(trouveFichierCloud)then CreeRepertoire(IncludeTrailingPathDelimiter(E.RepertoireSauvegardeFermtureCloud),true) ;

if ListeDossier = nil then
 begin
   ListeDossier:=TStringList.Create;
   ListeDossier.Clear;
   ListeDossier.Add(E.NomDossier+';'+RepertoirePere(E.RepertoireDossier)+';'+IncludeTrailingPathDelimiter(E.RepertoireSauvegardeFermture)+E.Nomdossier+';'+ParamUtil.RepertoireSauvegarde+E.Nomdossier+';;'+Texte+';');
    //ListeDossier.Add(E.NomDossier+';'+RepertoirePere(E.RepertoireDossier)+';'+ParamUtil.RepertoireSauvegarde+E.Nomdossier+';;;'+Texte+';');
 end;
if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName) then
  DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName));
if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName) then
  DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameConfirme));

AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName,Str_ChaineToHEXA(numVersion.Version));
AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameConfirme,Str_ChaineToHEXA(e.DateVersion));

NomFicSauvegarde:='SauvLog'+E.NomDossier+Texte+'.txt';
DateFic:=Date;
ListeDossier.SaveToFile(IncludeTrailingPathDelimiter(E.RepertoireSauvegardeFermture)+NomFicSauvegarde);
//NomFicSauvegarde:='SauvLog'+E.NomDossier+Texte+'.txt';
//DateFic:=Date;
//ListeDossier.SaveToFile(E.RepertoireSauvegardeFermture+NomFicSauvegarde);

result:=(AfficheSauvegardeFermeture(True,PChar(IncludeTrailingPathDelimiter(E.RepertoireSauvegardeFermture)+NomFicSauvegarde)) = MrOk);
//Showmessage(str_bool2str(result));
if ((result) and (VerrouDossier))or(fileExist)then
  AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable,Str_ChaineToHEXA(LibDates.DateInfos(now).DateStr));
End;


Function SauveDossier(ListeDossier:TStringList;DblSauv,Mail:String;Texte:string;VerrouDossier:boolean):Boolean;
var
    Aux,
    NomDuDossier,
    RepertoireDuDossier,
    RepSauvCopie,
    RepSauveZip,
    NomFicSauvegarde,
    RepACopier:
    String;
    //f:TextFile;
    ligne:string;
    ProgSauvegarde:
    PChar;
        cheminFichierTemp:string;
    DateFic:TDate;

  StartupInfo: TStartupinfo;

  ProcessInfo: TProcessInformation;
  Handle1 : Integer;
  fileExist:boolean;

begin
fileExist:=FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable);
if fileExist then
  DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable));
           //supprimer le fichier Locked
                cheminFichierTemp:=IncludeTrailingPathDelimiter(e.RepertoireDossier)+fileLocked;
                if(FileExists(cheminFichierTemp))then
                begin
                   DeleteFile(pchar(cheminFichierTemp));
                end;

if ListeDossier = nil then
 begin
   ListeDossier:=TStringList.Create;
   ListeDossier.Clear;
   ListeDossier.Add(E.NomDossier+';'+RepertoirePere(E.RepertoireDossier)+';'+ParamUtil.RepertoireSauvegarde+E.Nomdossier+';'+DblSauv+';'+Mail+';'+Texte+';');
//   ListeDossier.Add(E.NomDossier+';'+RepertoirePere(E.RepertoireDossier)+';'+ParamUtil.RepertoireSauvegarde+E.Nomdossier+';'+'A:\'+';');
 end;
if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName) then
  DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName));
if FileExists(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName) then
  DeleteFile(Pchar(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameConfirme));

AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileName,Str_ChaineToHEXA(numVersion.Version));
AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameConfirme,Str_ChaineToHEXA(e.DateVersion));

NomFicSauvegarde:='SauvLog'+E.NomDossier+LibDates.DateInfos(Date,'').DateStrFormat+HeureInfos(Time,'').HeureStrFormate+Texte+'.txt';
DateFic:=Date;
ListeDossier.SaveToFile(ParamUtil.RepertoireSauvegarde+NomFicSauvegarde);
//showmessage(ParamUtil.RepertoireSauvegarde+NomFicSauvegarde);
//  Chemin et nom du preogramme de sauvegarde
// ProgSauvegarde:=PChar(E.RepertoireProgram+'SauvegardeLGR.exe');


//Handle1 := ShellExecute(Application.Handle,nil,ProgSauvegarde,
//             PChar('"'+ParamUtil.RepertoireSauvegarde+NomFicSauvegarde+'"'),nil,sw_show);
//result:=(Handle1 > 32);
//if result then
// begin
// end;

result:=(AfficheSauvegarde(True,PChar(ParamUtil.RepertoireSauvegarde+NomFicSauvegarde)) = MrOk);
//Showmessage(str_bool2str(result));
if ((result) and (VerrouDossier))or(fileExist)then
  AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireDossier)+C_Version_FileNameEnCoursTraitementComptable,Str_ChaineToHEXA(LibDates.DateInfos(now).DateStr));
End;

Function RenomeDossierAvantRestaurationDossier(RepertoireDossier:String):Boolean;
var
Tmp:String;
Begin
//!!!!!!!!!!!!!!!!!!!Ne doit �tre fait que sur dossier non actif !!!!!!!!!!!!!!!
try
  result:=False;
  if DirectoryExists(RepertoireDossier) then
   begin
    Tmp:=RepertoireDossier;
    delete(Tmp,length(RepertoireDossier),1);
    result:=RenommeDossier(Tmp,tmp+'_T');
    if result then showmessage('ok');
   end;
except
 showmessage('RenomeDossierAvantRestaurationDossier : Erreur lors de la tentative de changement de nom du r�pertoire du dossier : ' + RepertoireDossier);
 abort;
end;
// RenameFile()
//if CopyAllFilesEx(RepDossier,ExtractFilePath(Application.ExeName)+'Sauvegarde\'+NomDossier+'_R','Pr�paration de la sauvegarde ...',false) then
// begin
//  if CopyAllFilesEx(ExtractFilePath(Application.ExeName)+'Sauvegarde\'+NomDossier,Rep_RepDossier,'Restauration en cours ...',false) then
//  MessageDlg('Restauration termin�e !',mtInformation,[mbOk],0)
//  else MessageDlg('Restauration abandonn�e !',mtError,[mbOk],0);
////    ShowMessage('Restauration termin�e !');

End;

function DemandeParametreSauvegardeFermetureAuto(Affiche: boolean ):boolean;
var
Param:string;
continuer:integer;
 db_SauvegardeFermeture : TMsgDlgParams;
  MessageLGR_Sauvegarde:TMessageLGR;

begin
try//finally
  try//except
    if(Affiche)then
      begin
      db_SauvegardeFermeture:=initMessageLGR(Application.MainForm,'','SauvegardeFermetureAuto2','Souhaitez-vous qu''Epic�a vous propose de faire une sauvegarde � chaque fermeture d''un dossier'
            +' (ou du programme). '
            +RetourChariotDouble+'Vous pouvez modifier ce choix et r�gler les param�tres de cette sauvegarde dans le menu "Outils/Propri�t�s/Sauvegardes Fermeture"'
            +RetourChariotDouble+'(Si vous choisissez Ignorer, Epic�a vous reposera la question au prochain lancement d''Epic�a)',
           'Choix pour les sauvegardes avant fermeture des dossiers (ou du programme)',[mbYes,mbNo,mbCust1],mbYes,MessageLGR_Sauvegarde);
      db_SauvegardeFermeture.CustBtnText[mbCust1] := 'Ignorer';
      db_SauvegardeFermeture.CheckBox:=false;

      continuer:=-1;
      continuer:=MsgDlgBox(db_SauvegardeFermeture);
case LoWord(continuer) of
mrYes: begin
     e.AutoriserSauvegardeFermeture:=true;
     e.AfficherMessageSauvegardeFermeture:=false;
  end;
mrCust1: begin
     e.AutoriserSauvegardeFermeture:=false;
     e.AfficherMessageSauvegardeFermeture:=true;
  end;
mrNo: begin
     e.AutoriserSauvegardeFermeture:=false;
     e.AfficherMessageSauvegardeFermeture:=false;
  end;
end;//fin case
      MessageLGR_Sauvegarde.Afficher:=not StrToBool_Lgr(IntToStr(hiWord(continuer)),true);
      DM_EcritMessageLGR(MessageLGR_Sauvegarde);

      end;//fin si sauvegardeFermeture

  except
    //ShowMessage('probl�me d''ex�cution');
  end;
finally
//
end;
end;

function SauvegardeFermetureAuto(Affiche , Sauvegardefermeture : boolean;Chemin : string):boolean;
var
Param:string;
continuer:integer;
 db_SauvegardeFermeture : TMsgDlgParams;
  MessageLGR_Sauvegarde:TMessageLGR;

begin
try//finally
try//except
if(Sauvegardefermeture)then
begin
//db_SauvegardeFermeture:=initMessageLGR(Application.MainForm,'','SauvegardeFermeture','Souhaitez-vous qu''Epic�a vous propose de faire une sauvegarde � chaque fermeture d''un dossier'
//      +' (ou du programme. '
//      +RetourChariotDouble+'(Si vous choisissez Ignorer, Epic�a vous reposera la question au prochain lancement d''Epic�a)'
//      +RetourChariotDouble+'Vous pouvez modifiez ce choix et r�gler les param�tres de cette sauvegarde dans le menu "Outils/Propri�t�s/Sauvegardes Fermeture"',
//      'Choix pour les sauvegardes avant fermeture des dossiers (ou du programme)',[mbYes,mbNo,mbCust1],mbYes,MessageLGR_Sauvegarde);
//db_SauvegardeFermeture.CustBtnText[mbCust1] := 'Ignorer';
//
//
//continuer:=-1;
//if MessageLGR_Sauvegarde.Afficher then
//  continuer:=MsgDlgBox(db_SauvegardeFermeture)else continuer:=MAKELong(mrCust1,1);
//   if db_SauvegardeFermeture.CheckBox then
//       begin
//         MessageLGR_Sauvegarde.Afficher:=not StrToBool_Lgr(IntToStr(hiWord(continuer)),true);
//         DM_EcritMessageLGR(MessageLGR_Sauvegarde);
//       end;
//case LoWord(continuer) of
//mrCust1: begin
     SauveDossierAvantFermeture(nil,'-SauvegardeAvantFermeture-');
//  end;
//end;//fin case
end;//fin si sauvegardeFermeture

except
  //ShowMessage('probl�me d''ex�cution');
end;
finally
//
end;
end;

//function SauvegardeFermetureAuto(Affiche , Sauvegardefermeture : boolean;Chemin : string):boolean;
//var
//Param:string;
//continuer:integer;
// db_SauvegardeFermeture : TMsgDlgParams;
//  MessageLGR_Sauvegarde:TMessageLGR;
//
//begin
//try//finally
//try//except
//if(Sauvegardefermeture)then
//begin
//db_SauvegardeFermeture:=initMessageLGR(Application.MainForm,'','SauvegardeFermeture','Souhaitez-vous qu''Epic�a vous propose de faire une sauvegarde � chaque fermeture d''un dossier'
//      +' (ou du programme. '
//      +RetourChariotDouble+'(Si vous choisissez Ignorer, Epic�a vous reposera la question au prochain lancement d''Epic�a)'
//      +RetourChariotDouble+'Vous pouvez modifiez ce choix et r�gler les param�tres de cette sauvegarde dans le menu "Outils/Propri�t�s/Sauvegardes Fermeture"',
//      'Choix pour les sauvegardes avant fermeture des dossiers (ou du programme)',[mbYes,mbNo,mbCust1],mbYes,MessageLGR_Sauvegarde);
//db_SauvegardeFermeture.CustBtnText[mbCust1] := 'Ignorer';
//
//
//continuer:=-1;
//if MessageLGR_Sauvegarde.Afficher then
//  continuer:=MsgDlgBox(db_SauvegardeFermeture)else continuer:=MAKELong(mrCust1,1);
//   if db_SauvegardeFermeture.CheckBox then
//       begin
//         MessageLGR_Sauvegarde.Afficher:=not StrToBool_Lgr(IntToStr(hiWord(continuer)),true);
//         DM_EcritMessageLGR(MessageLGR_Sauvegarde);
//       end;
//case LoWord(continuer) of
//mrCust1: begin
//     SauveDossierAvantFermeture(nil,'-SauvegardeAvantFermeture-');
//  end;
//end;//fin case
//end;//fin si sauvegardeFermeture
//
//except
//  //ShowMessage('probl�me d''ex�cution');
//end;
//finally
////
//end;
//end;

Function FermerDossierSauvegarde(_E:TEntreprise;Sauvegarde:boolean):Boolean;
begin
  FermerDossier(_E);
  if(Sauvegarde)then SauvegardeFermetureAuto(true,e.AutoriserSauvegardeFermeture,e.RepertoireSauvegardeFermture);
end;

Function FermerDossier(_E:TEntreprise):Boolean;
var
cheminFichierTemp:string;
Begin
result:=True;
 try

  if main <> nil then
   begin
    if Main.Shape1 <> nil then
    Main.Shape1.Parent:=Main.Panel4;
    if Main.Shape2 <> nil then
    Main.Shape2.Parent:=Main.Panel4;
    Result:=false;
    while Main.mnAffichage.Count > 0 do
     begin
       Main.mnAffichage.Delete(0);
     end;
    if Main.ListForm <> nil then
    Main.ListForm.Clear;
   end;
  GEstDossierMaJDateUtilDossier(_E.NomDossier,_E.NomExo,_E.RaisonSociale);
//  try
    DMProg.SauveGestDossierFichier(_E.NomDossier);
//  except
//  end;
  ExecuteProcInit('InitialiseTable_A_Nil');  //Convertisseur,
  result:=DetruitTouteFormNonShowModal([main,
                       AutreDossier,
                       Logo,
                       AideMontantTTC2,
                       GestSauvegarde,
                       GestionSauvegarde,
                       UniteCorrections,
                       regeneration,Cloture_Def,
                       Patientez]);
                       //,OKCreatExoDlg
  if result then
  begin
    DMBD.CloseAllTAbleExo('');
    DMBD.CloseAllTAbleDossier('');
    if DMEcritures <> nil then
    DMEcritures.Free;
    if DMDiocEtatBal <> nil then
    DMDiocEtatBal.Free;
    if DMDiocEtatBalT <> nil then
    DMDiocEtatBalT.Free;
    if DMPieces <> nil then
    DMPieces.Free;

    if(not Forcefermer)then
    begin //si fermeture ferm�e suite � message car autre utilisateur sur dossier
      cheminFichierTemp:=IncludeTrailingPathDelimiter(e.RepertoireDossier)+fileLocked;
      if(FileExists(cheminFichierTemp))then
      begin
         DeleteFile(pchar(cheminFichierTemp));
      end;
    end;
  end;
  //ShowMessage('Fermeture du dossier r�ussie.');
 except
  result:=false;
 end;
//showmessage(Main.Shape1.Parent.Name);
End;

Function ChangerDeDossier(NomDossierAOuvrir,NomExoAOuvrir:String):Boolean;
Begin
result:=FermerDossier(E);
if Result then
 result:=OuvreExercice(NomDossierAOuvrir,NomExoAOuvrir).retour;
End;

Function ControleDossierApresRestauration(NomDossier:String):Boolean;
Begin
//
End;

end.
