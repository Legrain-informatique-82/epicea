unit E2_Librairie_Obj;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
	Controls, Dialogs, Forms, Registry, Db, DBTables, gr_Librairie_obj,
   StdCtrls,
   Grids,
   GrDBGrid,
   E2_Decl_Records,
   Lib_Chaine,
   LibFichRep,
   DMXmls,
   DiversProjets,
    E2_InfoComposant,
   LbCipher,
   LbString,
   LibDates;

//Const
//AnneCodeExoDefaut= '06';

Type
  TPAramEnLigne = record
   Retour:Boolean;
   FichierEnParametre:String;
  end;



TParamUtil = class(TObject)
  Function InitParam:TPAramUtil;
  Function InitParamDefaut:TPAramUtil;
  Procedure EnregistrParamUtil(ParamUtil:TParamUtil);
  Function InitRepertoireCreationDossier:String;
 Public
  CouleurDBGrid:TVarColorGrid;
  CouleurPanelCorps:TColor;
  CouleurPanelTitre:TColor;
  CouleurBouton:TColor;
  MonoFenetre:Boolean;
  AfficheTitre:Boolean;

  FocusDesactive:boolean;

  ContourCouleur:TColor;
  ShadowColorOn:TColor;
  TextColorOn:TColor;
  ShadowColorOff:TColor;
  TextColorOff:TColor;
  OldScreenWidth:Integer;
  OldScreenHeight:Integer;

  // ParaMetre Issue de la ligne de commande
  ConstPosition:boolean; // True si le paramètre en ligne : "POSITION"
  maintenance:Boolean; // True si le parametre en ligne : "Maint"
  TypeMaintenance:String; // "Maint" ou "MaintS" si les parametres en ligne : "Maint"
                                       // et "82+Numéro du jour courant "
                                       
  TypeMaintenanceSpeciale:string; // Pointage ou autre { isa  le  27/06/05 }

  GestionSauvegarde:Boolean; // True si le paramètre en ligne : "BACKUP"
  // Parametre icone
  IcoMenuDemarrer:Boolean;
  IcoMenuProgramme:Boolean;
  IcoBureau:Boolean;

  // Assistant Automatique
  AssistantAffichageAuto:Boolean;
  AssistantDelaiAffichage:Integer;

  // Répertoire de Sauvegarde
  RepertoireSauvegarde:String;


  // Repertoire d'Extraction temporaire pour contrôle version sauvegarde
  RepertoireExtraction:string;

  //Affichage sur option de l'identifiant d'une pièce
  AffichIDPiece:boolean;

  // nombre de dossier affiché dans menu
  MaxDosMenu:Integer;

  // repertoire de creation de dossier
  RepertoireCreationDossier:String;

  // Utilisation du plan de Saisie
  PlanDeSaisie:Boolean;

  constructor Create(AOwner :TComponent);
  destructor Destroy;override;
 end;

TEntreprise = Class(TObject)
Private
 FRepertoireImportation:String;
 FRepertoireImportationEpiDos:String;
 FRepertoireImportationSIEA:String;
// FRepertoireImportCourante:String;
 FRepertoireExportation:String;
 Function LitRepertoireImportation:String;
 Procedure EcritRepertoireImportation(Rep:String);
 Function LitRepertoireImportationEpiDos:String;
 Procedure EcritRepertoireImportationEpiDos(Rep:String);
 Function LitRepertoireImportationSIEA:String;
 Procedure EcritRepertoireImportationSIEA(Rep:String);
// Function LitRepertoireImportationCourante:String;
// Procedure EcritRepertoireImportationCourante(Rep:String);
 Function LitRepertoireExportation:String;
 Procedure EcritRepertoireExportation(Rep:String);
Public
    NomUtilisateur :String;
   {Monnaie :String;}

   Regime :String[1];
   ExerciceBase :String[2];
   ExerciceSaisie :String[2];
   IDDevise_ParDefaut : integer;
   Devise :Integer;
   DeviseSigle:String;
   FormatMonnaie:String;
   EditFormat:String;
   ArrondiDebit, ArrondiCredit :String[8];
   ArrondiMontant :Currency;
   ParamArrondisTVA:currency;//isa le 05/03/03

   Possibilite_Affectation:boolean;//isa le 20-05-03
   RemiseAuto:boolean;
   //DatExoDebut, DatExoFin :TDateTime;
   //DatExoDemoDebut, DateExoDemoFin:TDateTime;

   DatExoDebut, DatExoFin :TDate;
   DatExoDemoDebut, DateExoDemoFin:TDate;
   AnneCodeExoDefaut : String;
   PeriodiciteTva:Integer;
   SautDePageAutomatique:boolean;

   RepertoireDossier :String;
   RepertoireExercice :string;
   RepertoireProgram : String;
   RepertoireImportEPI_DOS : string;
   RepertoireExport : string;
   RepertoireRelanceTiers : string;
   RepertoireExportBalance : String;
   RepertoireExportLiasse : String;
   RepertoireExportDossier : String;
   RepertoireComptaWeb : string;
   REpertoireFiscal : String;
   RepertoireImportCourante:String;
   RepertoireDblSauvegarde:String;
   RepertoireSauvegardeFermture:String;
   RepertoireSauvegardeFermtureCloud:String;
   AutoriserSauvegardeFermeture:boolean;
   AfficherMessageSauvegardeFermeture:boolean;
   ParamFTP:TParamFTP;
   RepTelechargementReleve:string;
   CompteBanqueDefaut:string;
   NomExo:String;
   NomDossier:string;
   TypeEntreprise:string[3];
   User:string;
   RaisonSociale:string;
   NomSauvegarde:string;
   ComptePointableCaisseEnregistreuse:string;
   TauxTvaCaisseEnregistreuse:string;
   ExtensionFEC :string;
   SeparateurFEC :string;
   DatePieceFEC :boolean;

   
//   DateDebutDeclarationTVA:TDateTime;
//   DateFinDeclarationTVA:TDateTime;
//   PremiereDateDeclaration:TDateTime;
   DateDebutDeclarationTVA:TDate;
   DateFinDeclarationTVA:TDate;
   PremiereDateDeclaration:TDate;
   DatePassageReel:Tdate;
   DateVersion:string;
   Version:string;
   Exo_A_Verifier:string;
   DAteFinUtilisationEpicea:TDate;

   ID_Dos:Integer;
   ID_Exo:Integer;

   TypeDossier:TTypeDossier;
   TypeDossierdemo:TTypeDossier;
   TypeClient:TTypeClient;
   TypeVersion:TTypeVersion;
   TypeUtilisateur:TTypeUtilisateur;
   PlanAuxT:Boolean;
   Derogatoire:Boolean;
   ExerciceCloture:Boolean;
   AccesOuverture:Boolean;
   AccesCloture:Boolean;
   CalculJourPres:Boolean;
   AutrePeriode:Boolean;
   PeriodeAutre:TPeriode;
   PeriodeAutreImpression:TPeriode;
   TypeEtatExercice:TTypeEtatExercice;
   TypeMAJBalance:TTypeMiseAJourBalance;
   Type_Edition:Integer;
   Type_Version_Test_Client:Boolean;
   ControleDuDossier:Boolean;
   ControleDuDossierEntrant:Boolean;

   constructor Create(AOwner :TComponent);
//   Function TypeDossierToInt(TypeDossier:TTypeDossier):Integer;
//   Function TypeDossierToStr(TypeDossier:TTypeDossier):string;
//   Function IntToTypeDossier(Rang:Integer):TTypeDossier;
//   Function TypeClientToInt(TypeClient:TTypeClient):Integer;
//   Function TypeClientToStr(TypeClient:TTypeClient):string;
//   Function IntToTypeClient(Rang:Integer):TTypeClient;
//   Function StrToTypeClient(ClientStr:string):TTypeClient;
   Function FormatCurr(Value : Extended):String;
   Function FormatCurrSansDevise(Value : Extended):String;
   Procedure InitTEntreprise(Var Entreprise:TEntreprise);
   Procedure VerifTEntreprise();
   Property RepertoireImportation:String Read LitRepertoireImportation Write EcritRepertoireImportation;
//   Property RepertoireImportationCourante:String Read LitRepertoireImportationCourante Write EcritRepertoireImportationCourante;
   Property RepertoireImportationSIEA:String Read LitRepertoireImportationSIEA Write EcritRepertoireImportationSIEA;
   Property RepertoireImportationEpiDos:String Read LitRepertoireImportationEpiDos Write EcritRepertoireImportationEpiDos;
   Property RepertoireExportation:String Read LitRepertoireExportation Write EcritRepertoireExportation;
End;


//   Function TypeDossierToInt(TypeDossier:TTypeDossier):Integer;
//   Function TypeDossierToStr(TypeDossier:TTypeDossier):string;
//   Function IntToTypeDossier(Rang:Integer):TTypeDossier;
////   Function TypeClientToInt(TypeClient:TTypeClient):Integer;
//   Function TypeClientToStr(TypeClient:TTypeClient):string;
//   Function IntToTypeClient(Rang:Integer):TTypeClient;
//   Function StrToTypeClient(ClientStr:string):TTypeClient;
//   Function TypeUtilisateurToInt(TypeUtilisateur:TTypeUtilisateur):Integer;
//  Function TypeUtilisateurToStr(TypeUtilisateur:TTypeUtilisateur):string;
//  Function IntToTypeUtilisateur(Rang:Integer):TTypeUtilisateur;
//  Function StrToTypeUtilisateur(UtilisateurStr:string):TTypeUtilisateur;
//
//  Function TypeVersionToInt(TypeVersion:TTypeVersion):Integer;
//  Function TypeVersionToStr(TypeVersion:TTypeVersion):string;
//  Function IntToTypeVersion(Rang:Integer):TTypeVersion;
//  Function StrToTypeVersion(VersionStr:string):TTypeVersion;

{Gestion des Messages dans Epicea-2}
Function MessageArgs(const Groupe :String; const Cle :String;
	const Args: array of const; Var Chaine :String) :Boolean;
Function AfficheMessageArgs(const Groupe :String; const Cle :String;
	AType: TMsgDlgType; AButtons: TMsgDlgButtons; const Args: array of const) : Word;
Function AfficheMessage(const Groupe :String; const Cle :String;
	AType: TMsgDlgType; AButtons: TMsgDlgButtons) : Word;

Function Question(const Groupe :String; const Cle :String) :Boolean;
Function Confirmation(const Groupe :String; const Cle :String) :Boolean;
Procedure Information(const Groupe :String; const Cle :String);
Procedure Erreur(const Groupe :String; const Cle :String);
Procedure Attention(const Groupe :String; const Cle :String);

Function QuestionArgs(const Groupe :String; const Cle :String; const Args: array of const) :Boolean;
Function ConfirmationArgs(const Groupe :String; const Cle :String; const Args: array of const) :Boolean;
Procedure InformationArgs(const Groupe :String; const Cle :String; const Args: array of const);
Procedure ErreurArgs(const Groupe :String; const Cle :String; const Args: array of const);
Procedure AttentionArgs(const Groupe :String; const Cle :String; const Args: array of const);

Procedure AfficheCalculatrice(Control : TControl);

Procedure Espion(Ligne :String);
Procedure EspionF(Ligne :String; const Args: array of const);
Function TypeHTTVA(LigneHT :Boolean) :String;
Function FormatFloat1(Montant :Double; DebitCredit, Credit, Logique :Boolean) :String;
Procedure EnregDataSet(Dataset :TDataSet; Insert, Post :Boolean;
	const KeyChamp: array of String;
	const KeyValues: array of const);
Function TypeCptTiers(Cpt:string):boolean;
Function ParamEnLigneLec(Index:Integer):TPAramEnLigne;
Function DetermineSolde(var Debit,Credit:Currency):Currency;
Function DetermineQte_SurMouvement_et_ClasseCpt(var Qte:real;Debit,Credit:Currency;Cpt:string):currency;
Function DetermineQte_SurClasseCpt(QteDebit,QteCredit:real;Cpt:string):real;
Function AfficheInfoComposantForm(Maintenance:boolean;TypeMaintenance:string):string;
Function DetermineSoldeValeurReelle(var Debit,Credit:Currency):currency;
Function DetermineSoldeSimple(Debit,Credit:Currency):currency;

function VersionMaintenance:boolean;
procedure GestionDesParametresRegionnaux;
function GetRepertoireLGR:Pchar;
function GetWindowsLanguage(LCTYPE: LCTYPE {type of information}): string;
//function verifDistribution(cheminFichier:string):TDistribution;
//procedure Decrypt(var valeur,numero:string);

Var
   E :TEntreprise;
   GestMessageLGR:TGestMessageLGR;
   AfficheEspion :Boolean;
   ParamUtil:TParamUtil;
   LastWincontrol:TWincontrol;
   LastZoneEdit:TWincontrol;
   MessageLGR:TMessageLGR;
   Type_version_execution:Integer;
   //Key128           : TKey128;
//   TypeDistribution:TDistribution;

implementation

uses LibZoneSaisie,DMConstantes,LibRessourceString, Windows,Gr_Calculatrice,
  E2_Main, DmGestionVersions;
var
Form1:TInfoComposant;

Function TEntreprise.LitRepertoireImportation:String;
Begin
Result:=FRepertoireImportation;
End;

Procedure TEntreprise.EcritRepertoireImportation(Rep:String);
Begin
if not empty(Rep) then
  FRepertoireImportation := IncludeTrailingPathDelimiter(Rep);
End;

Function TEntreprise.LitRepertoireImportationEpiDos:String;
Begin
Result := FRepertoireImportationEpiDos;
End;

Procedure TEntreprise.EcritRepertoireImportationEpiDos(Rep:String);
Begin
if not empty(Rep) then
  FRepertoireImportationEpiDos := IncludeTrailingPathDelimiter(Rep);
End;

Function TEntreprise.LitRepertoireImportationSIEA:String;
Begin
Result := FRepertoireImportationSIEA;
End;

Procedure TEntreprise.EcritRepertoireImportationSIEA(Rep:String);
Begin
if not empty(Rep) then
  FRepertoireImportationSIEA := IncludeTrailingPathDelimiter(Rep);
End;

//Function TEntreprise.LitRepertoireImportationCourante:String;
//Begin
//Result := FRepertoireImportCourante;
//End;
//
//Procedure TEntreprise.EcritRepertoireImportationCourante(Rep:String);
//Begin
//FRepertoireImportCourante := Rep;
//End;

Function TEntreprise.LitRepertoireExportation:String;
Begin
Result:=FRepertoireExportation;
End;

Procedure TEntreprise.EcritRepertoireExportation(Rep:String);
Begin
if not empty(Rep) then
  FRepertoireExportation := IncludeTrailingPathDelimiter(Rep);
End;

function GetRepertoireLGR:Pchar;
var
RepertoireLGR:string;
Liste:Tstringlist;
i,j:integer;
begin
Liste:=TStringList.create;
ExtractStrings(['\'],[],Pchar(uppercase(E.RepertoireProgram)),Liste);
if liste.Count<>0 then
begin
     i:=liste.IndexOf('LGR');
     if i<>-1 then
       begin
         for j:=0 to i do
         RepertoireLGR:=RepertoireLGR+liste.Strings[j]+'\';
       end;
end;
result:=Pchar(RepertoireLGR);
End;

Constructor TEntreprise.Create(AOwner :TComponent);
begin

inherited create;
     NomUtilisateur :=C_NomUtilDefaut;
   {Monnaie :String;}
   Regime :='A';
   AnneCodeExoDefaut:=DM_C_CodeExoDemo;
   ExerciceBase :=AnneCodeExoDefaut;
   ExerciceSaisie :=AnneCodeExoDefaut;
   IDDevise_ParDefaut :=2; // Voir dans la table des devises (ID)
   Devise :=-1;
//   DeviseSigle:='€';
   DeviseSigle:=currencyStringEpicea;

   FormatMonnaie:=',0.00 '+DeviseSigle+';-,0.00 '+DeviseSigle+';,0.00 '+DeviseSigle;
   EditFormat:='0.00 ;-0.00 ';

//   FormatMonnaie:=',0'+DecimalSeparator+'00 '+DeviseSigle+';-,0'+DecimalSeparator+'00 '+DeviseSigle+';,0'+DecimalSeparator+'00 '+DeviseSigle;
//   EditFormat:='0'+DecimalSeparator+'00 ;-0'+DecimalSeparator+'00 ';

   ArrondiDebit:='658';
   ArrondiCredit :='758';

   ArrondiMontant :=0.01;
   ParamArrondisTVA:=0.5;

//   ArrondiMontant :=0.01;
//   ParamArrondisTVA:=0.5;
   // Valeurs par défaut
   DatExoDebut:=StrToDate('01/01/20'+AnneCodeExoDefaut);
   DatExoFin :=StrToDate('31/12/20'+AnneCodeExoDefaut);
   //
   DatExoDemoDebut:=StrToDate(DM_C_DateDebutDemo);
   DateExoDemoFin:=StrToDate(DM_C_DateFinDemo);

//   DatExoDemoDebut:=StrToDate('01/01/20'+AnneCodeExoDefaut);
//   DateExoDemoFin:=StrToDate('31/12/20'+AnneCodeExoDefaut);

   RaisonSociale:='';
//// Valeurs spéciale
//   DatExoDebut:=StrToDate('01/07/2001');
//   DatExoFin :=StrToDate('30/06/20'+AnneCodeExoDefaut);
//   DatExoDemoDebut:=StrToDate('01/07/2001');
//   DateExoDemoFin:=StrToDate('30/06/20'+AnneCodeExoDefaut);
   RepertoireProgram :=ExtractFilePath(Application.ExeName);
   RepertoireImportation := RepertoireProgram + 'Importation';
   RepertoireExportation := RepertoireProgram + 'Exportation';
   RepertoireExportBalance := RepertoireProgram + 'Exportation\';
   RepertoireExportLiasse := RepertoireProgram + 'ExportationLiasse\';
   RepertoireRelanceTiers := RepertoireProgram + 'Exportation\';
 //  ParamFTP.Fichier := RepertoireDossier + C_ParamFTP;
//   showmessage(RepertoireImportation);
   RepertoireDossier :=RepertoireProgram + 'Demo\';
   RepertoireExercice :=RepertoireProgram + 'Demo\ExoDemo\';
   RepertoireImportEPI_DOS := RepertoireProgram + 'Importation\';
   RepertoireExport := RepertoireProgram + 'Exportation';
   RepertoireExportDossier:='';
   RepertoireComptaWeb := RepertoireProgram + 'ComptaWeb\';
   REpertoireFiscal := RepertoireProgram + 'Fiscal\';
   NomExo:=C_NomExoDemo;
   NomDossier:=C_NomDossierDemo;
   TypeEntreprise:='';
   User:=C_NomUtilDefaut;

   // Valeurs par défaut
   DateDebutDeclarationTVA:=StrToDate('01/01/20'+AnneCodeExoDefaut);
   DateFinDeclarationTVA:=StrToDate('31/12/20'+AnneCodeExoDefaut);
   PremiereDateDeclaration:=DatExoDebut; // date à partir de laquelle on prend en compte la TVA !!!
   PeriodiciteTva:=0;
//// Valeurs spéciale
//   DateDebutDeclarationTVA:=StrToDate('01/01/2002');
//   DateFinDeclarationTVA:=StrToDate('31/12/2002');
//   PremiereDateDeclaration:=StrToDate('01/01/2002'); // date à partir de laquelle on prend en compte la TVA !!!
   ID_Dos:=0;
   ID_Exo:=0;
   PlanAuxT:=true;
   TypeDossier:=VerDemoAgri;
   TypeDossierdemo:=VerDemoAgri;
   Derogatoire:=true;
   ExerciceCloture:=false;
   Possibilite_Affectation:=true;
   RemiseAuto:=true;
   SautDePageAutomatique:=true;
   AccesOuverture:=true;
   AccesCloture:=true;
   CalculJourPres:=true;

   AutrePeriode:=False; { isa  le  06/10/04 }
   PeriodeAutre.DateDeb := DatExoDebut;
   PeriodeAutre.DateFin := DatExoFin;
   
   PeriodeAutreImpression.retour:=false;
   PeriodeAutreImpression.DateDeb := 0;
   PeriodeAutreImpression.DateFin := DatExoFin;

   TypeEtatExercice:=ET_Normal;
   Type_Edition:=C_IMP_NORMAL;
   TypeMAJBalance:=MAJ_Normal;
  //  TypeMAJBalance:=MAJ_Report;

//Initialise_TDistribution(TypeDistribution);
//TypeDistribution:=verifDistribution(IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'InitClient.txt');
//TypeVersion:=TypeDistribution.TypeVersion;
//TypeClient:=TypeDistribution.TypeClient;
//TypeUtilisateur:=TypeDistribution.TypeUtilisateur;

//showmessage('verif Distribution');
//TypeVersion:=V_Complete;
////TypeClient:=CL_Normal;
//TypeClient:=CL_Cogere;
//TypeUtilisateur:=U_Normal;


//showmessage('après verif TypeClient : '+TypeClientToStr(TypeClient));



//  Type_Version_Test_Client:=true;
  Type_Version_Test_Client:=False;

  ControleDuDossier:=True; // A utiliser pour empêcher le controle du dossier lors de l'ouverture de celui-ci !!
  ControleDuDossierEntrant:=true;
//  if ((Type_version_execution=ct_developpement)or(TypeClient=Cl_isa)) then
//    DAteFinUtilisationEpicea:=encodeDate(2008,01,01) // Cette date permet la protection temporaire d'épicéa
//  else
    DAteFinUtilisationEpicea:=strtodate_lgr(DM_C_DateFinVersionNonProtegee); // Cette date permet la protection temporaire d'épicéa

  RepertoireDblSauvegarde:=C_StrVide;
  RepertoireSauvegardeFermture:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'SauvegardeFermeture';
  RepertoireSauvegardeFermtureCloud:='';  
  AutoriserSauvegardeFermeture:=true;
  AfficherMessageSauvegardeFermeture:=true;
end;


//Function TypeDossierToInt(TypeDossier:TTypeDossier):Integer;
//Begin
//result:=ord(TypeDossier);
//End;
//
//Function TypeDossierToStr(TypeDossier:TTypeDossier):string;
//Begin
//result:='VerDemoAgri';
//case TypeDossierToInt(TypeDossier) of
//  0:result:='VerDiocese';
//  1:result:='VerAgricole';
//  2:result:='VerGeneral';
//  3:result:='VerDiocAdmin';
//  4:result:='VerDemoAgri';
//  5:result:='VerDemoDioc';
//  6:result:='VerDemoGeneral';
//  7:result:='VerInconnu';
//  8:result:='VerAgriClot';
//  9:result:='VerGeneClot';
//  10:result:='VerDiocClot';
//else showMessage('Une erreur est survenu lors de la récupération du type du dossier');
//end;
//End;
//
//Function IntToTypeDossier(Rang:Integer):TTypeDossier;
//Begin
//result:=VerDemoAgri;
//case Rang of
//  0:result:=VerDiocese;
//  1:result:=VerAgricole;
//  2:result:=VerGeneral;
//  3:result:=VerDiocAdmin;
//  4:result:=VerDemoAgri;
//  5:result:=VerDemoDioc;
//  6:result:=VerDemoGeneral;
//  7:result:=VerInconnu;
//  8:result:=VerAgriClot;
//  9:result:=VerGeneClot;
//  10:result:=VerDiocClot;
//else showMessage('Une erreur est survenu lors de la récupération du type du dossier');
//end;
//End;
//
////Function TypeClientToInt(TypeClient:TTypeClient):Integer;
////Begin
////result:=ord(TypeClient);
////End;
//
//Function TypeClientToStr(TypeClient:TTypeClient):string;
//Begin
//result:='CL_Inconnu';
//case TypeClient of
//  CL_Inconnu:result:='CL_Inconnu';
//  CL_Cogere:result:='CL_Cogere';
//  CL_Normal:result:='CL_Normal';
//  CL_Isa:result:='CL_Isa'
////  ;
////  4:result:='CL_Demo';
////  5:result:='CL_Saisie_Normal';
////  6:result:='CL_Saisie_Demo';
////  7:result:='CL_Saisie_Cogere';
////  8:result:='CL_Normal_2';
////  9:result:='CL_Normal_3'
//else showMessage('Une erreur est survenu lors de la récupération du type de client');
//end;
//End;
//
//Function IntToTypeClient(Rang:Integer):TTypeClient;
//Begin
//result:=CL_Inconnu;
//case Rang of
//  0:result:=CL_Inconnu;
//  1:result:=CL_Cogere;
//  2:result:=CL_Normal;
//  3:result:=CL_Isa
////  ;
////  4:result:=CL_Demo;
////  5:result:=CL_Saisie_Normal;
////  6:result:=CL_Saisie_Demo;
////  7:result:=CL_Saisie_Cogere;
////  8:result:=CL_Normal_2;
////  9:result:=CL_Normal_3
//else showMessage('Une erreur est survenu lors de la récupération du type de client');
//end;
//End;
//
//
//Function StrToTypeClient(ClientStr:string):TTypeClient;
//Begin
//result:=CL_Inconnu;
//if uppercase(ClientStr) ='CL_INCONNU' then result:=CL_Inconnu;     //23/09/2010
//if uppercase(ClientStr) ='CL_COGERE' then result:=CL_Cogere;
//if uppercase(ClientStr) ='CL_NORMAL' then result:=CL_Normal;
//if uppercase(ClientStr) ='CL_ISA' then result:=CL_Isa;
////if uppercase(ClientStr) ='CL_DEMO' then result:=CL_Demo;
////if uppercase(ClientStr) ='CL_SAISIE_NORMAL' then result:=CL_Saisie_Normal;
////if uppercase(ClientStr) ='CL_SAISIE_DEMO' then result:=CL_Saisie_Demo;
////if uppercase(ClientStr) ='CL_SAISIE_COGERE' then result:=CL_Saisie_Cogere;
////if uppercase(ClientStr) ='CL_NORMAL_2' then result:=CL_Normal_2;
////if uppercase(ClientStr) ='CL_NORMAL_3' then result:=CL_Normal_3;
//if result=CL_Inconnu then
// showMessage('Une erreur est survenu lors de la récupération du type de client');
//End;

Function TEntreprise.FormatCurr(Value : Extended):String;
Begin
result := FormatFloat(FormatMonnaie + ';; ',Value);
End;

Function TEntreprise.FormatCurrSansDevise(Value : Extended):String;
var
Forma:string;
newValeur:string;
Begin
Forma:=',0.00;-,0.00;,0.00';
//Forma:= ',0'+DecimalSeparator+'00;-,0'+DecimalSeparator+'00;,0'+DecimalSeparator+'00 ';
result :=FormatFloat(Forma + ';; ',Value);
//newValeur:= StringReplace(result,#32,' ',[rfReplaceAll]);
newValeur:= StringReplace(result,' ',#32,[rfReplaceAll]);
if newValeur<>result then showmessage('différence');
//showmessage();
End;

Procedure TEntreprise.VerifTEntreprise();
Begin
Initialise_TDistribution(TypeDistribution);
TypeDistribution.TypeVersion:=N4;
TypeDistribution.TypeClient:=CL_Normal;
TypeDistribution.TypeUtilisateur:=U_Normal;
//showmessage('type version : '+TypeVersionToStr(TypeDistribution.TypeVersion));
TypeDistribution:=verifDistribution(IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+'InitClient.txt');
TypeVersion:=TypeDistribution.TypeVersion;
TypeClient:=TypeDistribution.TypeClient;
TypeUtilisateur:=TypeDistribution.TypeUtilisateur;
end;

Procedure TEntreprise.InitTEntreprise(Var Entreprise:TEntreprise);
Begin
if Entreprise = nil then
 begin
  Showmessage('Entreprise est nil');
  abort;
 end;
    Entreprise.NomUtilisateur :='LGR';
   {Monnaie :String;}

   Entreprise.Regime :='';
//   Entreprise.ExerciceBase :='';
//   Entreprise.ExerciceSaisie :='';
   Entreprise.Devise :=-1;
   Entreprise.DeviseSigle:='';
   Entreprise.FormatMonnaie:='';
   Entreprise.EditFormat:='';
   Entreprise.ArrondiDebit:='0';
   Entreprise.ArrondiCredit :='0';
   Entreprise.ArrondiMontant :=0;
   Entreprise.ParamArrondisTVA:=0;
//   Entreprise.DatExoDebut:=0;
//   Entreprise.DatExoFin :=0;
//   Entreprise.DatExoDemoDebut:=0;
//   Entreprise.DateExoDemoFin:=0;

//   RepertoireProgram :='';
//   RepertoireDossier :='';
//   RepertoireExercice :='';
//   RepertoireImportEPI_DOS := '';
//   Entreprise.NomExo:='';
//   Entreprise.NomDossier:='';
//   Entreprise.TypeEntreprise:='';
   Entreprise.User:='LGR';
   Entreprise.RaisonSociale:='';
   // Valeurs par défaut
   Entreprise.DateDebutDeclarationTVA:=0;
   Entreprise.DateFinDeclarationTVA:=0;
   Entreprise.PremiereDateDeclaration:=0;
   Entreprise.DatePassageReel:=0;
   Entreprise.DateVersion:='';
   Entreprise.Exo_A_Verifier:='';
      
//   Entreprise.ID_Dos:=0;
//   Entreprise.ID_Exo:=0;
   Entreprise.PlanAuxT:=true;
   Entreprise.TypeDossier:=VerInconnu;
   Entreprise.TypeDossierdemo:=VerInconnu;
   Entreprise.Derogatoire:=False;
   Entreprise.ExerciceCloture:=false;
   Entreprise.AccesOuverture:=true;
   Entreprise.AccesCloture:=true;
//AccesOuverture:=true;
//AccesCloture:=true;
   Entreprise.ControleDuDossier := true;
   Entreprise.ControleDuDossierEntrant:=true;
//   TypeClient:=CL_Inconnu;
End;

Function CouleurDBGridDefaut:TVarColorGrid;
Begin
  result.LigneContour:=clGreen;
  result.CelActiveContour:=$0000E600;
  result.CelActiveColorFond:=clactiveBorder;
  result.CelActiveColorFont:=clWhite;
  result.CelActiveSAisieColorFont:=clBlack;
  result.CelActiveSAisieColorFond:=$0000E600;
  result.CelFixeColorFond:=clBtnFace;
  result.CelFixeColorFont:=clWindowText;
  result.GrilleColorFond:=$00EAFAFF;
  result.GrilleColorFont:=clWindowText;
End;

constructor TParamUtil.Create(AOwner :TComponent);
Begin
inherited create;
self.CouleurDBGrid:=CouleurDBGridDefaut;
self.ContourCouleur:=clRed;
self.ShadowColorOn:=clRed;
self.TextColorOn:=clRed;
self.ShadowColorOff:=clBtnHighlight;
self.TextColorOff:=clWindowText;
self.CouleurPanelTitre:=$00EAFAFF;
self.CouleurPanelCorps:=$00BADCDC;
OldScreenWidth:=Screen.Width;
OldScreenHeight:=Screen.Height;
ConstPosition:=false;
maintenance:=false;
TypeMaintenance:='';
GestionSauvegarde:=false;
IcoMenuDemarrer:=False;
IcoMenuProgramme:=True;
IcoBureau:=False;
AfficheTitre:=true;
AssistantAffichageAuto:=False;
AssistantDelaiAffichage:=60;
RepertoireSauvegarde:=ExtractFilePath(Application.ExeName)+ 'Sauvegarde\';
RepertoireExtraction:=ExtractFilePath(Application.ExeName)+ 'Extraction\';
MaxDosMenu:=CT_MaxDosMenu;
InitRepertoireCreationDossier;
//RepertoireCreationDossier:=ExtractFilePath(Application.ExeName);
PlanDeSaisie:=False;
End;

destructor TParamUtil.Destroy;
Begin
inherited Destroy;
//if RepertoireCreationDossier <> ExtractFilePath(Application.ExeName) then
  DMXml.ModifieItemProgramme('RepertoireCreation',RepertoireCreationDossier);
End;


Function TParamUtil.InitParamDefaut:TPAramUtil;
Begin
result:=TParamUtil.Create(Application.MainForm);
result.CouleurPanelTitre:=$00EAFAFF;
result.CouleurPanelCorps:=$00BADCDC;
//result.AffichIDPiece:=false;
result.AffichIDPiece:=True;
PlanDeSaisie:=False;
//Result.Free;
End;


Function TParamUtil.InitParam:TPAramUtil;
Begin
//
End;


Procedure TParamUtil.EnregistrParamUtil(ParamUtil:TParamUtil);
Begin
//
End;

Function TParamUtil.InitRepertoireCreationDossier:String;
var
TextTmp:String;
Begin
try
  result:='';
  TextTmp:='';
  RepertoireCreationDossier:=C_RepDossierDefaut;

//  RepertoireCreationDossier:=ExtractFilePath(Application.ExeName);
  try
   TextTmp:=DMXml.RetourneValItemProgramme('RepertoireCreation');
  except

  end;
Finally
  if not empty(TextTmp) then RepertoireCreationDossier:=TextTmp;
   if not str_fini_par(RepertoireCreationDossier,'\') then
     RepertoireCreationDossier := RepertoireCreationDossier + '\';

  result:=RepertoireCreationDossier;
end;
End;


//******************************************************************************
Procedure Espion(Ligne :String);
// Affiche la ligne dans la fenêtre espion
Var
	form :TForm;
Begin
//	if (AfficheEspion) then Begin
//      if (VisuEspion = Nil) then
//         VisuEspion:= TVisuEspion.Create(Application.MainForm);
//
//      VisuEspion.mmEspion.Lines.Add(DateTimeToStr(Now) + ' : ' + Ligne);
//      if Not (VisuEspion.Visible) then Begin
//         form:= Screen.ActiveForm;
//         VisuEspion.Visible:= True;
//         form.SetFocus;
//      End;
//   End;
End;

//******************************************************************************
Procedure EspionF(Ligne :String; const Args: array of const);
// Affiche la ligne avec des paramètres dans la fenêtre espion
Begin
	if (AfficheEspion) then
		Espion(Format(Ligne, Args));
End;


//******************************************************************************
Function MessageArgs(const Groupe :String; const Cle :String;
	const Args: array of const; Var Chaine :String) :Boolean;
// Recherche le message dans la table des messages
// et aussi, grâce à Jacques, nous pouvons créer un message qui serait manquant
Begin
//   with DMAides.taMessage do Begin
//   	Result:= FindKey([Groupe, cle]);
//
//   	if (Not Result)
//      And (MessageDlg('Le Message : ' + Groupe + '; ' + Cle + ' n''existe pas.'
//      	+	#13 + 'Voulez-vous le créer ?', mtConfirmation, mbYesNo, 0) = mrYes) then
//         	Result:= AfficheNouveauMessage(Groupe, Cle, Args);
//
//      Chaine:= '';
//      if (Result) then Begin
//         try
//            FmtStr(Chaine, FindField('Message').AsString, Args);
//         except
//            Chaine:= '';
//         end;
//      End;
//   End;
End;

//******************************************************************************
Function AfficheMessageArgs(const Groupe :String; const Cle :String;
	AType: TMsgDlgType; AButtons: TMsgDlgButtons;
	const Args: array of const) : Word;
// Permet d'afficher les messages à l'utilisateur
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   MessageArgs(Groupe, Cle, Args, Chaine);
//   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//  	Result:= MessageDlg(Chaine, aType, aButtons, nHelp);
End;

//******************************************************************************
Function AfficheMessage(const Groupe :String; const Cle :String;
	AType: TMsgDlgType; AButtons: TMsgDlgButtons) : Word;
// Affiche un message sans arguments
   Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   MessageArgs(Groupe, Cle, [''], Chaine);
//   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//  	Result:= MessageDlg(Chaine, aType, aButtons, nHelp);
End;

//******************************************************************************
Function Question(const Groupe :String; const Cle :String) :Boolean;
// affiche une question sans argument
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   MessageArgs(Groupe, Cle, [''], Chaine);
//   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//  	Result:= (MessageDlg(Chaine, mtConfirmation, mbYesNo, nHelp) = mrYes);
  	Result:= (MessageDlg('Vous n''utilisez pas la dernière subdivision !'+#10#13 + 'Confirmez-vous votre choix ?', mtConfirmation, mbYesNo, nHelp) = mrYes);
End;

//******************************************************************************
Function Confirmation(const Groupe :String; const Cle :String) :Boolean;
// Demande confirmation
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   MessageArgs(Groupe, Cle, [''], Chaine);
//   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//  	Result:= (MessageDlg(Chaine, mtConfirmation, mbOkCancel, nHelp) = mrOk);
End;

//******************************************************************************
Procedure Information(const Groupe :String; const Cle :String);
// Affiche un message d'information
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   if MessageArgs(Groupe, Cle, [''], Chaine) Then Begin
//	   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//   	MessageDlg(Chaine, mtInformation, [mbOk], nHelp);
//   End;
End;

//******************************************************************************
Procedure Erreur(const Groupe :String; const Cle :String);
// Affiche un message d'erreur
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   if MessageArgs(Groupe, Cle, [''], Chaine) Then Begin
//	   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//   	MessageDlg(Chaine, mtError, [mbOk], nHelp);
//   End;
End;

//******************************************************************************
Procedure Attention(const Groupe :String; const Cle :String);
// Message d'alerte
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   if MessageArgs(Groupe, Cle, [''], Chaine) Then Begin
//	   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//   	MessageDlg(Chaine, mtWarning, [mbOk], nHelp);
//   End;
End;

//******************************************************************************
Function QuestionArgs(const Groupe :String; const Cle :String; const Args: array of const) :Boolean;
// Pose une question avec un argument
Var
  Chaine :String;
   nHelp :LongInt;
Begin
//   MessageArgs(Groupe, Cle, Args, Chaine);
//   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//  	Result:= (MessageDlg(Chaine, mtConfirmation, mbYesNo, nHelp) = mrYes);
End;

//******************************************************************************
Function ConfirmationArgs(const Groupe :String; const Cle :String; const Args: array of const) :Boolean;
// Message de confirmation
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   MessageArgs(Groupe, Cle, Args, Chaine);
//   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//   Result:= (MessageDlg(Chaine, mtConfirmation, mbOkCancel, nHelp) = mrOk);
End;

//******************************************************************************
Procedure InformationArgs(const Groupe :String; const Cle :String; const Args: array of const);
// Information avec argument
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   MessageArgs(Groupe, Cle, Args, Chaine);
//   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//  	MessageDlg(Chaine, mtInformation, [mbOk], nHelp);
End;

//******************************************************************************
Procedure ErreurArgs(const Groupe :String; const Cle :String; const Args: array of const);
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   if MessageArgs(Groupe, Cle, Args, Chaine) Then Begin
//	   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//   	MessageDlg(Chaine, mtError, [mbOk], nHelp);
//   End;
End;

//******************************************************************************
Procedure AttentionArgs(const Groupe :String; const Cle :String; const Args: array of const);
Var
   Chaine :String;
   nHelp :LongInt;
Begin
//   if MessageArgs(Groupe, Cle, Args, Chaine) Then Begin
//	   nHelp:= DMAides.taMessage.FindField('Aide').AsInteger;
//
//   	MessageDlg(Chaine, mtWarning, [mbOk], nHelp);
//   End;
End;

//******************************************************************************
Function TypeHTTVA(LigneHT :Boolean) :String;
// Retourne la famille de la ligne d'écriture / TVA
Begin
	if (LigneHT) Then Result:= 'H'
   Else					Result:= 'T'
End;

//******************************************************************************
Procedure AfficheCalculatrice(Control : TControl);
// Gère la valeur de la calculatrice
Begin
CalculatriceAffiche(Control);
End;

//******************************************************************************
Function FormatFloat1(Montant :Double; DebitCredit, Credit, Logique :Boolean) :String;
// Retourne une chaine avec le montant formaté + D ou C
Begin
//	if DebitCredit And Logique then Begin
//   	if (Montant < 0) then Begin
//      	Montant:= -Montant;
//         Credit:= False;
//      End
//      Else Credit:= True
//   End;
//
//	Result:= FormatFloat('# ##0.00;-# ##0.00;""', Montant);
//
//   If (Montant <> 0) and (DebitCredit) then Begin
//   	if (Credit) then 	Result:= Result + ' C'
//      Else					Result:= Result + ' D'
//   End;
End;

//******************************************************************************
Procedure EnregDataSet(Dataset :TDataSet; Insert, Post :Boolean;
	const KeyChamp: array of String;
	const KeyValues: array of const);
// Permet de mettre à jour une table avec plusieurs champs différents
Var i :longInt;
Begin
//	Try
//		if (Insert) then DataSet.Insert
//   	Else if Not (DataSet.State in [dsEdit, dsInsert]) then
//      	DataSet.Edit;
//
//		for i := 0 to High(KeyValues) do Begin
//   		if (i <= High(KeyChamp)) then
//	   		DataSet.FindField(KeyChamp[i]).AssignValue(KeyValues[i]);
//	   End;
//
//      if (DataSet.FindField('Qui') <> Nil) then Begin
//		   DataSet.FindField('Qui').AsString:= E.NomUtilisateur;
//      	DataSet.FindField('Quand').asDateTime:= Now;
//      End;
//
//   	if (Post) then DataSet.Post;
//
//   Except
//   End;
End;

//******************************************************************************

Function TypeCptTiers(Cpt:string):boolean;
Begin
result:=false;
if not empty(cpt) then
 result:=copy(Cpt,1,1)='+';
End;

//******************************************************************************
//******************************************************************************
// Liste des paramètres possible sur la ligne de commande

//  "POSITION" : Permet l'affichage du menu "Modifier Const Pos"

//  "Maint" : Active l'écran de maintenance [Ctrl+Maj+F7] avec les objets dont les
//            noms se termine par : "Maint" (Utilisateur)

//  "82+Numéro du jour courant" : Active l'écran de maintenance [Ctrl+Maj+F7] avec tous les objets (Maintenance)
//                                seulement si le paramètre "Maint" est écrit avant !!
//                               ( Mais plus tard, qu'avec les objet se terminant par MaintS )

//******************************************************************************
//******************************************************************************
Function ParamEnLigneLec(Index:Integer):TPAramEnLigne;
var
i:integer;
Begin
Result.Retour:=false;
Result.FichierEnParametre :=C_StrVide;
if Index=0 then
 begin
    for i:=0 to ParamCount do
     begin
       // Section Alphabétique
       // Donne accès à l'écran de Maintenance utilisateur
       // et n'affiche que les objet finissant par 'Maint'
       if ParamStr(i) = 'Maint' then
        begin
        Main.FormateCaptionMain(' - Vous êtes en version Maintenance !');
         //Application.MainForm.caption:=Application.MainForm.caption+' - Vous êtes en version Maintenance !';
         ParamUtil.maintenance:=true;
         ParamUtil.TypeMaintenance:='Maint';
        end;
       // Initialise ParamUtil.ContPosition à true pour
       // permettre l'affichage automatique du menu de modification des constantes d'affichage (type2)
       // Voir aussi dans Main.ChangementForm
       if ParamStr(i) = 'POSITION' then
        begin
        Main.FormateCaptionMain('**');
        // Application.MainForm.caption:=Application.MainForm.caption+'**';
         ParamUtil.ConstPosition:=true;
        end;
       // Permet de faire apparaitre l'écran de gestion de restauration avant d'ouvrir
       // le dossier en cours.
       if ParamStr(i) = 'BACKUP' then
        begin
         ParamUtil.GestionSauvegarde:=true;
        end;
       // Section numérique
       if not Empty(QueDesChiffres(ParamStr(i))) then
       begin
        if ParamUtil.maintenance = true then
         begin
           if  (strtoint_lgr(ParamStr(i)))  = (LibDates.NbDeJours(StrToDate('01/01/'+DateInfos(Date).AnStr),Date)+82) then
            begin
            Main.FormateCaptionMain(' - Spéciale -');
             //Application.MainForm.caption:=Application.MainForm.caption+' - Spéciale -';
             ParamUtil.TypeMaintenance:='MaintS';
            end;
         end;
       end;
       //permet de taper en ligne le type client que l'on veut executer
       if ((uppercase(copy(ParamStr(i),1,3)) = 'CL_')and (e.TypeClient=cl_isa)) then
        begin
         e.TypeClient:=StrToTypeClient(ParamStr(i));
        end;
       //permet de taper en ligne le type de version que l'on veut executer
       if (uppercase(copy(ParamStr(i),1,3)) = 'CT_') then
        begin
         if(UpperCase(ParamStr(i))='CT_DEVELOPPEMENT') then
           Type_version_execution:=CT_DEVELOPPEMENT
         else
            Type_version_execution:=CT_DISTRIBUTION;
        end;
     end;

 end
else
 begin
   case Index of
      // Ne mettre ici que le traitement avant toute création d'objet !!!
      1:for i:=0 to ParamCount do
       // Section Alphabétique
         begin
         if i > 0 then
         Result.FichierEnParametre :=Result.FichierEnParametre+' '+ParamStr(i);
         if str_fini_par(Result.FichierEnParametre,'.epi') then
          begin
           Result.FichierEnParametre:=TrimLeft(Result.FichierEnParametre);
           Result.FichierEnParametre:=TrimRight(Result.FichierEnParametre);
           Result.Retour:=True;
          end;
           if ParamStr(i) = 'BACKUP' then
            begin
             ParamUtil.GestionSauvegarde:=true;
            end;
         end;
      2:begin
         ParamUtil.maintenance:=true;
         Main.FormateCaptionMain(' - Spéciale (Programmation)-[Main.ParamEnLigneLec(2)]');
         //Application.MainForm.caption:=Application.MainForm.caption+' - Spéciale (Programmation)-[Main.ParamEnLigneLec(2)]';
         ParamUtil.TypeMaintenance:='MaintS';
        end;
   end;

 end;

End;


// calcule le solde entre 2 montants
Function DetermineSoldeSimple(Debit,Credit:Currency):currency;
Begin
  Debit:=Debit-Credit;
  if Debit < 0 then
   begin
    result:=Debit;
    Credit:=abs(Debit);
    Debit := 0;
   end
   else
   begin
     Credit:=0;
     result:=Debit;
   end;

End;

// Détermine et calcule le solde entre 2 montants
Function DetermineSoldeValeurReelle(var Debit,Credit:Currency):currency;
Begin
  Debit:=Debit-Credit;
  if Debit < 0 then
   begin
    result:=Debit;
    Credit:=abs(Debit);
    Debit := 0;
   end
   else
   begin
     Credit:=0;
     result:=Debit;
   end;

End;

// Détermine et calcule le solde entre 2 montants
Function DetermineSolde(var Debit,Credit:Currency):currency;
Begin
  Debit:=Debit-Credit;
  if Debit < 0 then
   begin
    Credit:=abs(Debit);
    result:=Credit;
    Debit := 0;
   end
   else
   begin
     Credit:=0;
     result:=Debit;
   end;

End;

// Détermine et calcule le sens d'une quantité suivant le solde des mouvements rattachés et le type de compte
Function DetermineQte_SurMouvement_et_ClasseCpt(var Qte:real;Debit,Credit:Currency;Cpt:string):currency;
var
signe:integer;
Begin
  DetermineSolde(Debit,Credit);
  if Debit <> 0 then
   begin
     if copy(cpt,1,1)[1] ='7' then
       qte:=-qte;
   end
   else
  if Credit <> 0 then
   begin
     if copy(cpt,1,1)[1] in ['1','6'] then
       qte:=-qte;
   end;
result:=Qte;
End;

// Détermine et calcule le solde d'une quantité suivant le type de compte
Function DetermineQte_SurClasseCpt(QteDebit,QteCredit:real;Cpt:string):real;
var
Qtedeb,QteCred:currency;
Begin
result:=0;
Qtedeb:=QteDebit;
QteCred:=QteCredit;
if not empty(cpt) then
  begin
    if copy(cpt,1,1)[1] ='7' then
       result:=DetermineSolde(QteCred,Qtedeb)
    else
    if copy(cpt,1,1)[1] in ['1','6'] then
       result:=DetermineSolde(Qtedeb,QteCred);
  end;
End;

Function AfficheInfoComposantForm(Maintenance:boolean;TypeMaintenance:string):string;
Begin
if Maintenance then
 begin
    if form1 = nil then
    Application.CreateForm(TInfoComposant,Form1);
    //Form1:=TInfoComposant.CreateNew(application.MainForm);
    Form1.Maintenance:=true;
    Form1.NomMaint:=TypeMaintenance;
    Form1.Maintenance:=Maintenance;
    if maintenance then
     if TypeMaintenance = 'Maint' then
       Form1.ListBox3.OnClick:=Form1.ListBox3Click_Maint
     else
     if TypeMaintenance = 'MaintS' then
       Form1.ListBox3.OnClick:=Form1.ListBox3Click
     else Form1.ListBox3.OnClick:=nil;

    Form1.Visible:=false;
    Form1.showmodal;
    Form1.free;
    Form1:=nil;
 end
 else
 begin
  Showmessage('Vous devez être en Maintenance pour accéder à cette fonctionnalité !');
 end;
End;



function VersionMaintenance:boolean;
begin
  result := (((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')));
end;




procedure GestionDesParametresRegionnaux;
begin
//
end;


procedure Decrypt(var valeur,numero:string);
var
 CipherText:string;
begin
  GenerateLMDKey(Key128, SizeOf(Key128), numero);
//   CipherText:=valeur;
  valeur:=BFEncryptStringEx(valeur, Key128, False);
end;
//
//
//function verifDistribution(cheminFichier:string):TDistribution;
//var
//nomVolume,numero:string;
//text:TextFile;
//valeur:string;
//listeRetour:TStringlist;
//begin
////     IncludeTrailingPathDelimiter(ExtractFileDrive(application.ExeName))
//Initialise_TDistribution(TypeDistribution);
//DisqueDur(ListTypeLecteur(DRIVE_FIXED).Strings[0],nomVolume,numero);
//result.TypeUtilisateur:=U_Demo;
//result.TypeClient:=CL_Normal;
//result.TypeVersion:=V_Complete;
//listeRetour:=Tstringlist.create;
//if(fileexists(cheminFichier))then
//    begin
//        AssignFile(text,cheminFichier);
//        Reset(text);
//        Readln(text,valeur);
//        CloseFile(text);
//        Decrypt(valeur,numero);
//        ExtractStrings(['¤'],[' '],PansiChar(valeur),listeRetour);
//        if(listeRetour.Count<3)then exit;
//
//        result.TypeVersion:=StrToTypeVersion(listeRetour.strings[0]);
//        result.TypeClient:=StrToTypeClient(listeRetour.strings[1]);
//        result.TypeUtilisateur:=StrToTypeUtilisateur(listeRetour.strings[2]);
//    end;
////showMessage(e.TypeClientToStr(result));
//end;


////gestion des types Utilisateurs////////////////
//////////////////////////////
//Function TypeUtilisateurToInt(TypeUtilisateur:TTypeUtilisateur):Integer;
//Begin
//result:=ord(TypeUtilisateur);
//End;
//
//Function TypeUtilisateurToStr(TypeUtilisateur:TTypeUtilisateur):string;
//Begin
//result:='U_Inconnu';
//case TypeUtilisateurToInt(TypeUtilisateur) of
//  0:result:='U_Inconnu';
//  1:result:='U_Normal';
//  2:result:='U_Demo';
//  3:result:='U_Comptable';
//  4:result:='U_SuperComptable'
//else showMessage('Une erreur est survenu lors de la récupération du type de Utilisateur');
//end;
//End;
//
//Function IntToTypeUtilisateur(Rang:Integer):TTypeUtilisateur;
//Begin
//result:=U_Inconnu;
//case Rang of
//  0:result:=U_Inconnu;
//  1:result:=U_Normal;
//  2:result:=U_Demo;
//  3:result:=U_Comptable;
//  4:result:=U_SuperComptable
//else showMessage('Une erreur est survenu lors de la récupération du type de Utilisateur');
//end;
//End;
//
//
//Function StrToTypeUtilisateur(UtilisateurStr:string):TTypeUtilisateur;
//Begin
//result:=U_Inconnu;
//if uppercase(UtilisateurStr) ='U_INCONNU' then result:=U_Inconnu;
//if uppercase(UtilisateurStr) ='U_NORMAL' then result:=U_Normal;
//if uppercase(UtilisateurStr) ='U_DEMO' then result:=U_Demo;
//if uppercase(UtilisateurStr) ='U_COMPTABLE' then result:=U_Comptable;
//if uppercase(UtilisateurStr) ='U_SUPERCOMPTABLE' then result:=U_SuperComptable;
//if result=U_Inconnu then
// showMessage('Une erreur est survenu lors de la récupération du type de Utilisateur');
//End;
//
//
////gestion des types Distributions////////////////
//////////////////////////////
//Function TypeVersionToInt(TypeVersion:TTypeVersion):Integer;
//Begin
//result:=ord(TypeVersion);
//End;
//
//Function TypeVersionToStr(TypeVersion:TTypeVersion):string;
//Begin
//result:='V_Inconnu';
//case TypeVersionToInt(TypeVersion) of
//  0:result:='V_Inconnu';
//  1:result:='V_Complete';
//  2:result:='V_Saisie';
//  3:result:='V_SSImmos';
//  4:result:='V_4'
//else showMessage('Une erreur est survenu lors de la récupération du type de Version');
//end;
//End;
//
//Function IntToTypeVersion(Rang:Integer):TTypeVersion;
//Begin
//result:=V_Inconnu;
//case Rang of
//  0:result:=V_Inconnu;
//  1:result:=V_Complete;
//  2:result:=V_Saisie;
//  3:result:=V_SSImmos;
//  4:result:=V_4
//else showMessage('Une erreur est survenu lors de la récupération du type de Version');
//end;
//End;
//
//
//Function StrToTypeVersion(VersionStr:string):TTypeVersion;
//Begin
//result:=V_Inconnu;
//if uppercase(VersionStr) ='V_INCONNU' then result:=V_Inconnu;
//if uppercase(VersionStr) ='V_COMPLETE' then result:=V_Complete;
//if uppercase(VersionStr) ='V_SAISIE' then result:=V_Saisie;
//if uppercase(VersionStr) ='V_SSIMMOS' then result:=V_SSImmos;
//if uppercase(VersionStr) ='V_4' then result:=V_4;
//if result=V_Inconnu then
// showMessage('Une erreur est survenu lors de la récupération du type de Version');
//End;


function GetWindowsLanguage(LCTYPE: LCTYPE {type of information}): string;
var
  Buffer : PChar;
  Size : integer;
begin
  Size := GetLocaleInfo (LOCALE_USER_DEFAULT, LCType, nil, 0);
  GetMem(Buffer, Size);
  try
    GetLocaleInfo (LOCALE_USER_DEFAULT, LCTYPE, Buffer, Size);
    Result := string(Buffer);
  finally
    FreeMem(Buffer);
  end;
end;
end.
