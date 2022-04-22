unit DMConstantes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibSQL,Gr_Librairie_Obj,E2_Decl_Records,LibZoneSaisie,E2_LibInfosTable
  ,Lib_Chaine,E2_Librairie_Obj;

type

TInitObjet = Class(TObject)
protected
  TypeConst:Integer;
Public
   TypeInitialisation:string;
   NomEcran:String;
   TypeObjet:string;
   NomObjet:String;
   constructor Create(AOwner :TComponent);
   Procedure InitObjet(Valeur:String);
private
End;

TObjetPos = Class(TInitObjet)
Public
   Top:Integer;
   Left:Integer;
   Width:Integer;
   Heigth:Integer;
   Etat:String;
   constructor Create(AOwner :TComponent);
End;

  TDMConst = class(TDataModule)
    TaConstEditionRelanceTiers: TTable;
    TaConstPosObjet: TTable;
    TaConstJournalLettre: TTable;
    TaConstJournalReserve: TTable;
    TaConst: TTable;
    QuConst: TQuery;
    procedure DMConstCreate(Sender: TObject);
    procedure DMConstDestroy(Sender: TObject);
    Function Gestion_AppelFonction_TypeReference(Dataset:TDataset;Control :Tcomponent):TValeurConstante;
    Procedure InitialiseObjetPosObjetLec(Objet:TObject;ObjetPos:TObjetPos);
    Procedure InitialiseObjetPosObjetEcr(Objet:TObject;ObjetPos:TObjetPos);
    Procedure InitialiseObjetPosDataSetLec(DataSet:TDataSet;ObjetPos:TObjetPos);
    Procedure InitialiseObjetPosDataSetEcr(DataSet:TDataSet;ObjetPos:TObjetPos);
    Procedure BtnMAJPosConstClick(Sender: TObject);
    Procedure AfficheMenuConstPos(Form:TForm);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMConst: TDMConst;
  ErreurSaisie:TExceptLGR;

  Function ListeVarEditionRelanceTiers:TStringList;
  Function ListeJournalLettre:TStringList;
  Function ListeJournalLettre_ID_Journal:TStringList;
  Function ListeJournalLettre_Plusieurs_Journal:TStringList;
  Function ListeJournalReserve:TStringList;
  Function ListeJournalReserveID:TStringList;
  Procedure InitialiseFormPosDefaut(Form:TForm);
  Function DM_C_NomAliasProgram:String;
  Function DM_C_NomAliasDemo:String;
  Function DM_C_NomAliasExoDemo:String;
  Function DM_C_CompteArrondiDebit:String;
  Function DM_C_CompteArrondiCredit:String;
  Function DM_C_ArrondiMontant:Currency;
  Function DM_C_ParamArrondisTVA:Currency;
  Function DM_C_CompteTVADeduiteAReverser:String;
  Function DM_C_CompteTVAExceptionnelDebit:String;
  Function DM_C_CompteTVAExceptionnelCredit:String;
  Function DM_C_CompteTVAPourReport:String;
  Function DM_C_CompteTVAPourRemboursement:String;
  Function DM_C_CompteTVAAPayer:String;
  Function DM_C_CompteTVAAcompteVerse:String;
  Function DM_C_CodeTVADefautBienEtService:String;
  Function DM_C_CodeTVADefautAutoLiquide:String;
  Function DM_C_CodeTVADefautFranchise:String;
  Function DM_C_ListeCTVAAchat:tstringlist;
  Function DM_C_ListeCTVAVente:tstringlist;
  Function DM_C_ListeCTVANonImposable:tstringlist;
  Function DM_C_ListeCTVAAutoLiquide:tstringlist;
  Function DM_C_ListeCTVAImposeDeduite:tstringlist;
  Function DM_C_CompteDeResultBenef:String;
  Function DM_C_CompteDeResultPerte:String;
  Function DM_C_CompteChargeARepartir:String;
  Function DM_C_CompteTVACollectee:String; // 44571
  Function DM_C_CompteTVAAutreBiensServices_A1:String; // 44566
  Function DM_C_CompteTVAAutreBiensServices_A2:String; // 44565
  Function DM_C_CompteTVAAchatImmo_I1:String; // 44562
  Function DM_C_CompteTVAVente_V3:String; // 445713
  Function DM_C_CompteTVAVente_V4:String; // 445714
  Function DM_C_CompteTVAVente_V8:String; // 445718
  Function DM_C_CompteTVAVente_V9:String; // 445719
  Function DM_C_CompteChargeConstateeDAvance:String; // 486
  Function DM_C_CompteProduitConstateDAvance:String; // 487
  Function DM_C_CompteAmortDerogatoire:String; // 145
  Function DM_C_CompteChargeAPayerDefaut:String; // 4081
  Function DM_C_CompteProduitARecevoirDefaut:String; // 4181
  Function DM_C_CompteProvisionsDefaut:String; // 1518
  Function DM_C_CompteTVAChargeAPayer:String; // 44586
  Function DM_C_CompteTVAProduitARecevoir:String; // 44587
  Function DM_C_ListeCptObligatoire:TStringList;
  Function DM_C_ListeFenetre:tstringlist; // Liste des fenêtres du programme
  Function DM_C_CompteRepartitionResultatAssocie:String; // 455
  Function DM_C_CompteRepartitionResultatIndividuelle:String; // 1012
  Function DM_C_NomAliasDossier:String;
  Function DM_C_NomAliasExercice:String;
  Function DM_C_NomAliasExoN1:String;
  Function DM_C_NomFichierImportE2_FAC:String; // IMPORTATION E2_FAC
  Function DM_C_NomFichierImportCAISSE:String; // IMPORTATION CAISSE
  Function DM_C_NomFichierImportCAISSEB:String; // IMPORTATION CAISSE B
  
  Function DM_C_NomFichierImportCAISSEMpFacture:String; // IMPORTATION CAISSE Micro Pointe Facture
  Function DM_C_NomFichierImportCAISSEMpTicket:String; // IMPORTATION CAISSE Micro Pointe Ticket
  Function DM_C_NomFichierImportCAISSEMpCarte:String; // IMPORTATION CAISSE Micro Pointe Carte
  Function DM_C_NomFichierImportCAISSEMpCheque:String; // IMPORTATION CAISSE Micro Pointe Cheque
  Function DM_C_NomFichierImportCAISSEMpEspece:String; // IMPORTATION CAISSE Micro Pointe Espèce
  Function DM_C_NomFichierImportCAISSEMPVirement:String; // IMPORTATION CAISSE Micro pointe Virement

  Function DM_C_NomFichierImportSARA:String; // IMPORTATION SARA
  Function DM_C_NomBilanAGRReel:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanAGRReel2144:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanAGRReel2145:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanAGRReel2146:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanAGRReel21462:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanAGRReelOuverture:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanBICReelOuverture:String; // Nom du fichier PDF pour les resultats

  Function DM_C_ListeCTVAIntracommunautaire:TStringList; // C,L,N,E classe intracommunautaire
  Function DM_C_ListeZonePourSommeTotauxBilan(NomZoneBilan:string):TStringList;
  Function DM_C_ListeZoneTotauxBilan:TStringList;
  Function DM_C_ListeZoneTotauxBilanOuverture:TStringList;
  Function DM_C_ListeZonePourSommeTotauxBilanOuverture(NomZoneBilan:string):TStringList;
  
  Function DM_C_ListeCaractereCorrect_SQL:tstringlist;
  Function DM_C_ListeEcranVerrouilleExoCloture:TStringList;
  Function DM_C_ListeEcranVerrouilleN1:TStringList;
  Function DM_C_ListeEcranVerrouilleOuverture:TStringList;
  Function DM_C_PourcentageTvaRegle:Currency;
  //*****Bic****
  Function DM_C_ListeZoneTotauxBilan_Bic:TStringList;
  Function DM_C_ListeZonePourSommeTotauxBilan_Bic(NomZoneBilan:string):TStringList;
  Function DM_C_ListeZonePourSommeTotauxBilanOuverture_Bic(NomZoneBilan:string;Dataset:Tdataset=nil):TStringList;
  Function DM_C_ListeZoneTotauxBilanOuverture_Bic:TStringList;
  
  Function DM_C_NomBilanBICReel:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanBICReel2050:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanBICReel2051:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanBICReel2052:String; // Nom du fichier PDF pour les resultats
  Function DM_C_NomBilanBICReel2053:String; // Nom du fichier PDF pour les resultats
  Function DM_C_Delimiteur:Char;
  Function DM_C_DateFinVersionNonProtegee:string;
  Function DM_C_ListeCodeTvaNonModifiableSiDeclare:tstringlist;
  Function DM_C_DateFinDemo:string;
  Function DM_C_DateDebutDemo:string;
  Function DM_C_CodeExoDemo:string;
  Function DM_C_ServeurFTP:String;

implementation


{$R *.DFM}

Function ListeVarEditionRelanceTiers:TStringList;
Begin
 if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
 result:=TStringList.Create;
 FiltrageDataSet(DMConst.TaConstEditionRelanceTiers,'Type = 1');
 result:=ChampTableVersListe('VAlpha',DMConst.TaConstEditionRelanceTiers);
End;

// Retourne la liste des lettres valides pour la création d'un journal (DMJournaux)
Function ListeJournalLettre:TStringList;
Begin
 if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
 result:=TStringList.Create;
 FiltrageDataSet(DMConst.TaConstJournalLettre,'Type = 3');
 result:=ChampTableVersListe('VAlpha',DMConst.TaConstJournalLettre);
End;

// Retourne la liste des ID_Journaux pour chaque catégorie de lettre (par classe de journaux)
Function ListeJournalLettre_ID_Journal:TStringList;
Begin
 if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
 result:=TStringList.Create;
 FiltrageDataSet(DMConst.TaConstJournalLettre,'Type = 3');
 result:=ChampTableVersListe('Vinteger',DMConst.TaConstJournalLettre);
End;

// Retourne une liste de booleen qui indique si l'on peut créer plus d'un journal
// ou pas, c'est fonction de chaque catégorie de lettre (par classe de journaux)
Function ListeJournalLettre_Plusieurs_Journal:TStringList;
Begin
 if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
 result:=TStringList.Create;
 FiltrageDataSet(DMConst.TaConstJournalLettre,'Type = 3');
 result:=ChampTableVersListe('VBoolean',DMConst.TaConstJournalLettre);
End;

// Retourne la liste des Journaux réservé
Function ListeJournalReserve:TStringList;
Begin
 if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
 result:=TStringList.Create;
 FiltrageDataSet(DMConst.TaConstJournalReserve,'Type = 4');
 result:=ChampTableVersListe('VAlpha',DMConst.TaConstJournalReserve);
End;

// retourne la liste des identifiants réservé à certain journaux
// La valeur 0 indique que l'on peut générer un ID libre
Function ListeJournalReserveID:TStringList;
Begin
 if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
 result:=TStringList.Create;
 FiltrageDataSet(DMConst.TaConstJournalReserve,'Type = 4');
 result:=ChampTableVersListe('VInteger',DMConst.TaConstJournalReserve);
End;

// Retourne le nom d'alias par défaut de la Base Programme
Function DM_C_NomAliasProgram:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomAliasProgram']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomAliasProgram',mtError,[mbOK],0);
   abort;
  end;
End;

// Retourne le nom d'alias par défaut de la base du dossier Démo
Function DM_C_NomAliasDemo:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomAliasDemo']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomAliasDemo',mtError,[mbOK],0);
   abort;
  end;
End;

// Retourne le nom d'alias par défaut de la base de l'exercice Démo
Function DM_C_NomAliasExoDemo:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomAliasExoDemo']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomAliasExoDemo',mtError,[mbOK],0);
   abort;
  end;
End;


Function DM_C_NomAliasDossier:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomAliasDossier']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomAliasDossier',mtError,[mbOK],0);
   abort;
  end;
End;

// Retourne le nom d'alias par défaut de la base de l'exercice
Function DM_C_NomAliasExercice:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomAliasExercice']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomAliasExercice',mtError,[mbOK],0);
   abort;
  end;
End;

// Retourne le nom d'alias par défaut de la base de l'ExoN1
Function DM_C_NomAliasExoN1:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomAliasExoN1']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomAliasExoN1',mtError,[mbOK],0);
   abort;
  end;
End;
Function DM_C_CompteArrondiDebit:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteArrondiDebit']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteArrondiDebit',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CompteArrondiCredit:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteArrondiCredit']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteArrondiCredit',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_ArrondiMontant:Currency;
Begin
   result:= 0.1;
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['ArrondiMontant']).VCurrency;
  except
   MessageDlg('Erreur à la récupération de : ArrondiMontant',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_ParamArrondisTVA:Currency;
Begin
   result:= 0.5;
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['ParamArrondisTVA']).VCurrency;
  except
   MessageDlg('Erreur à la récupération de : ParamArrondisTVA',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVADeduiteAReverser:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVADeduiteAReverser']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVADeduiteAReverser',mtError,[mbOK],0);
   abort;
  end;
End;
Function DM_C_CompteTVAExceptionnelDebit:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAExceptionnelDebit']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAExceptionnelDebit',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CompteTVAExceptionnelCredit:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAExceptionnelCredit']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAExceptionnelCredit',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CompteTVAPourReport:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAPourReport']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAPourReport',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CompteTVAPourRemboursement:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAPourRemboursement']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAPourRemboursement',mtError,[mbOK],0);
   abort;
  end;
End;


Function DM_C_CompteTVAAPayer:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAAPayer']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAAPayer',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CompteTVAAcompteVerse:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAAcompteVerse']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAAcompteVerse',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CodeTVADefautBienEtService:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CodeTVADefautBienEtService']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CodeTVADefautBienEtService',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CodeTVADefautAutoLiquide:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CodeTVADefautAutoLiquide']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CodeTVADefautAutoLiquide',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CodeTVADefautFranchise:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CodeTVADefautFranchise']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CodeTVADefautFranchise',mtError,[mbOK],0);
   abort;
  end;
End;

Procedure InitialiseFormPosDefaut(Form:TForm);
var
ObjetPos:TObjetPos;
Begin
 ObjetPos:=TObjetPos.Create(Form);
 if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
 DMConst.InitialiseObjetPosObjetLec(Form,ObjetPos);
 DMConst.InitialiseObjetPosDataSetLec(DMConst.TaConstPosObjet,ObjetPos);
 DMConst.InitialiseObjetPosObjetEcr(Form,ObjetPos);
 ObjetPos.Free;
End;

Constructor TInitObjet.Create(AOwner :TComponent);
begin
  inherited create;
  TypeConst:=2;
end;

Procedure TInitObjet.InitObjet(Valeur:String);
Begin
  TypeInitialisation:=GetStringElement(Valeur,1,';');
  NomEcran:=GetStringElement(Valeur,2,';');
  TypeObjet:=GetStringElement(Valeur,3,';');
  NomObjet:=GetStringElement(Valeur,4,';');
End;

Constructor TObjetPos.Create(AOwner :TComponent);
begin
  inherited create(Aowner);
  TypeObjet:='FORM';
  TypeInitialisation:='POSITION';
  top:=0;
  Left:=0;
  Width:=0;
  Heigth:=0;
end;

procedure TDMConst.DMConstCreate(Sender: TObject);
begin
  OuvrirTouteTable('',Tcontrol(self));
  Initialise_ExceptLGR(ErreurSaisie);
end;

procedure TDMConst.DMConstDestroy(Sender: TObject);
begin
  FermerTouteTable('',TControl(self));
  DMConst:=nil;
end;

Function TDMConst.Gestion_AppelFonction_TypeReference(Dataset:TDataset;Control :Tcomponent):TValeurConstante;
var
i:integer;
DetailDate:TDetailDate;
TableConsult:TDataset;
Begin
if dataset = nil then abort;
if not DataSet.Active then abort;
if not DAtaSet.Filtered then abort;

result.ListeReference:=TStringList.Create;
result.ListeResult:=TStringList.Create;
TableConsult:=TTable.create(self);
result.ListeReference.Clear;
result.ListeResult.Clear;

DataSet.First;
while not DataSet.EOF do
 begin
   if UpperCase(GetStringElement(DataSet.FindField('NomConst').AsString,2,';')) = UpperCase('TABLE') then
    begin
      result.ListeReference.add(DataSet.FindField('VAlpha').AsString);

//      result.ListeResult.;
    end;
   if UpperCase(GetStringElement(DataSet.FindField('NomConst').AsString,2,';')) = UpperCase('DATE') then
    begin
    end;
 end;

TableConsult.Free;
End;

Procedure TDMConst.InitialiseObjetPosObjetLec(Objet:TObject;ObjetPos:TObjetPos);
Begin
if Objet = nil then
 begin
   Showmessage('TDMConst.InitialiseObjetPosObjetLec : Objet Nil');
   abort;
 end;

if ObjetPos = nil then
 begin
   Showmessage('TDMConst.InitialiseObjetPosObjetLec : ObjetPos Nil');
   abort;
 end;
 case RecupClassTypeComponent(TComponent(Objet)) of
    GTform:Begin
            ObjetPos.NomEcran:=TForm(Objet).Name;
            ObjetPos.NomObjet:=TForm(Objet).Name;

            ObjetPos.Top:=0;
            if TForm(Objet).Top >=0 then
              ObjetPos.Top:=TForm(Objet).Top;

            ObjetPos.Left:=0;
            if TForm(Objet).Left >=0 then
              ObjetPos.Left:=TForm(Objet).Left;

            ObjetPos.Heigth:=Screen.Height;
            if TForm(Objet).Height <= Screen.Height then
            ObjetPos.Heigth:=TForm(Objet).Height;

            ObjetPos.Width:=Screen.Width;
            if TForm(Objet).Width <= Screen.Width then
            ObjetPos.Width:=TForm(Objet).Width;

            ObjetPos.Etat:=FormEtatStr(TForm(Objet));
           End;
 end;
End;

Procedure TDMConst.InitialiseObjetPosObjetEcr(Objet:TObject;ObjetPos:TObjetPos);
Begin
if Objet = nil then
 begin
   Showmessage('TDMConst.InitialiseObjetPosObjetEcr : Objet Nil');
   abort;
 end;

if ObjetPos = nil then
 begin
   Showmessage('TDMConst.InitialiseObjetPosObjetEcr : ObjetPos Nil');
   abort;
 end;

 case RecupClassTypeComponent(TComponent(Objet)) of
    GTform:Begin
            TForm(Objet).Top:=ScreenAjuste800600_DefinitionCourante_Vertical(ObjetPos.Top);
            TForm(Objet).Left:=ScreenAjuste800600_DefinitionCourante_Horizon(ObjetPos.Left);
            TForm(Objet).Height:=ScreenAjuste800600_DefinitionCourante_Vertical(ObjetPos.Heigth);
            TForm(Objet).Width:=ScreenAjuste800600_DefinitionCourante_Horizon(ObjetPos.Width);
            TForm(Objet).WindowState:=FormEtatStrToWState(ObjetPos.Etat);
           End;

 end;
End;

Procedure TDMConst.InitialiseObjetPosDataSetLec(DataSet:TDataSet;ObjetPos:TObjetPos);
Begin
if DataSet = nil then
 begin
   Showmessage('TDMConst.InitialiseObjetPosDataSetLec : DataSet Nil');
   abort;
 end;

if ObjetPos = nil then
 begin
   Showmessage('TDMConst.InitialiseObjetPosDataSetLec : ObjetPos Nil');
   abort;
 end;

 FiltrageDataset(DataSet,'Type = 2  and '+CreeFiltreET(['NomConst'],['POSITION;'+ObjetPos.NomEcran+';FORM;'+ObjetPos.NomObjet]));
 if DataSet.RecordCount = 1 then
    Begin
      ObjetPos.Top:=StrToInt(GetStringElement(DataSet.FindField('VAlpha').AsString,1,';'));
      ObjetPos.Left:=StrToInt(GetStringElement(DataSet.FindField('VAlpha').AsString,2,';'));

      if GetStringElement(DataSet.FindField('VAlpha').AsString,3,';') <> 'MAX' then
       ObjetPos.Heigth:=StrToInt(GetStringElement(DataSet.FindField('VAlpha').AsString,3,';'))
      else
       ObjetPos.Heigth:=screen.Height;

      if GetStringElement(DataSet.FindField('VAlpha').AsString,4,';') <> 'MAX' then
       ObjetPos.Width:=StrToInt(GetStringElement(DataSet.FindField('VAlpha').AsString,4,';'))
      else
       ObjetPos.Width:=screen.Width;

       ObjetPos.Etat:=GetStringElement(DataSet.FindField('VAlpha').AsString,5,';');
    End
     else
    Begin
      ObjetPos.Top:=150;
      ObjetPos.Left:=40;
      ObjetPos.Heigth:=600 - ObjetPos.Top;
      ObjetPos.Width:=760;
      ObjetPos.Etat:='WsNormal';
    End;

End;

Procedure TDMConst.InitialiseObjetPosDataSetEcr(DataSet:TDataSet;ObjetPos:TObjetPos);
Begin
if DataSet = nil then
 begin
   Showmessage('TDMConst.InitialiseObjetPosDataSetEcr : DataSet Nil');
   abort;
 end;

if ObjetPos = nil then
 begin
   Showmessage('TDMConst.InitialiseObjetPosDataSetEcr : ObjetPos Nil');
   abort;
 end;
 FiltrageDataset(DataSet,'Type = 2  and '+CreeFiltreET(['NomConst'],['POSITION;'+ObjetPos.NomEcran+';FORM;'+ObjetPos.NomObjet]));
 if DataSet.RecordCount = 1 then
    Begin
      DataSet.Edit;
      DataSet.FindField('VAlpha').AsString:=IntToStr(ObjetPos.Top)+';'+
                                            IntToStr(ObjetPos.Left)+';';
      if ObjetPos.Heigth = screen.Height then
           DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+'MAX;'
           else
           DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+IntToStr(ObjetPos.Heigth)+';';
      if ObjetPos.Width = screen.Width then
           DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+'MAX;'
           else
           DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+IntToStr(ObjetPos.Width)+';';

      DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+ObjetPos.Etat;
      TableGerePost(DataSet);

//      ObjetPos.Top:=StrToInt(GetStringElement(DataSet.FindField('VAlpha').AsString,1,';'));
//      ObjetPos.Left:=StrToInt(GetStringElement(DataSet.FindField('VAlpha').AsString,2,';'));
//
//      if GetStringElement(DataSet.FindField('VAlpha').AsString,3,';') <> 'MAX' then
//       ObjetPos.Heigth:=StrToInt(GetStringElement(DataSet.FindField('VAlpha').AsString,3,';'))
//      else
//       ObjetPos.Heigth:=screen.Height;
//
//      if GetStringElement(DataSet.FindField('VAlpha').AsString,4,';') <> 'MAX' then
//       ObjetPos.Width:=StrToInt(GetStringElement(DataSet.FindField('VAlpha').AsString,4,';'))
//      else
//       ObjetPos.Width:=screen.Width;
//
//       ObjetPos.Etat:=GetStringElement(DataSet.FindField('VAlpha').AsString,5,';');
    End
     else
    Begin
    try
      DataSet.Insert;

      DataSet.FindField('ID').AsInteger:=MaxId_Query(TTable(DataSet),'ID');

      DataSet.FindField('NomConst').AsString:='POSITION;'+ObjetPos.NomEcran+';FORM;'+ObjetPos.NomObjet;

      DataSet.FindField('Type').AsInteger:=ObjetPos.TypeConst;

      DataSet.FindField('VAlpha').AsString:=IntToStr(ObjetPos.Top)+';'+
                                            IntToStr(ObjetPos.Left)+';';
      if ObjetPos.Heigth = screen.Height then
           DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+'MAX;'
           else
           DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+IntToStr(ObjetPos.Heigth)+';';
      if ObjetPos.Width = screen.Width then
           DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+'MAX;'
           else
           DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+IntToStr(ObjetPos.Width)+';';

      DataSet.FindField('VAlpha').AsString:=DataSet.FindField('VAlpha').AsString+ObjetPos.Etat;
      TableGerePost(DataSet);
    except
     DataSet.Cancel;
    end;

//      ObjetPos.Top:=150;
//      ObjetPos.Left:=40;
//      ObjetPos.Heigth:=600 - ObjetPos.Top;
//      ObjetPos.Width:=760;
//      ObjetPos.Etat:='WsNormal';
    End;
End;

Procedure TDMConst.BtnMAJPosConstClick(Sender: TObject);
var
ObjetPos:TObjetPos;
Begin
ObjetPos:=TObjetPos.Create(self);
 DMConst.InitialiseObjetPosObjetLec(Screen.ActiveForm,ObjetPos);
 DMConst.InitialiseObjetPosDataSetEcr(DMConst.TaConstPosObjet,ObjetPos);
ObjetPos.Free;
//ShowMessage('Pas encore implémenté');
End;

Procedure TDMConst.AfficheMenuConstPos(Form:TForm);
Begin
if Form.PopupMenu <> nil then
 if Form.PopupMenu.Items[Form.PopupMenu.Items.Count-1].Caption <> 'Modifier Const Pos' then
  //ConstruitPopMenu(Form.PopupMenu.Items.Count,'Modifier Const Pos',Form.PopupMenu.Items,Form,DMConst.BtnMAJPosConstClick);
End;

Function DM_C_ListeCTVAAchat:tstringlist;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''ListeCTVAAchat''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : ListeCTVAAchat',0,true,mtError,ErreurSaisie);
  except
//   MessageDlg('Erreur à la récupération de : ListeCTVAAchat',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_ListeCTVAVente:tstringlist;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''ListeCTVAVente''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : ListeCTVAVente',0,true,mtError,ErreurSaisie);
  except
//   MessageDlg('Erreur à la récupération de : ListeCTVAAchat',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_ListeCTVAAutoLiquide:tstringlist;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''ListeCTVAAutoLiquide''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : ListeCTVAAutoLiquide',0,true,mtError,ErreurSaisie);
  except
//   MessageDlg('Erreur à la récupération de : ListeCTVAAchat',mtError,[mbOK],0);
   abort;
  end;
End;


Function DM_C_ListeCTVANonImposable:tstringlist;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''ListeCTVANonImposable''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : ListeCTVANonImposable',0,true,mtError,ErreurSaisie);
  except
//   MessageDlg('Erreur à la récupération de : ListeCTVAAchat',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_ListeCTVAImposeDeduite:tstringlist;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''ListeCTVAImposeDeduite''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : ListeCTVAImposeDeduite',0,true,mtError,ErreurSaisie);
  except
//   MessageDlg('Erreur à la récupération de : ListeCTVAAchat',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CompteDeResultBenef:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteDeResultBenef']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteDeResultBenef',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteDeResultPerte:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteDeResultPerte']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteDeResultPerte',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteChargeARepartir:String;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteChargeARepartir']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteChargeARepartir',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVACollectee:String; // 44571
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVACollectee']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVACollectee',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAAutreBiensServices_A1:String; // 44566
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAAutreBiensServices_A1']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAAutreBiensServices_A1',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAAutreBiensServices_A2:String; // 44565
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAAutreBiensServices_A2']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAAutreBiensServices_A2',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAAchatImmo_I1:String; // 44562
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAAchatImmo_I1']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAAchatImmo_I1',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAVente_V3:String; // 445713
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAVente_V3']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAVente_V3',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAVente_V4:String; // 445714
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAVente_V4']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAVente_V4',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAVente_V8:String; // 445718
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAVente_V8']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAVente_V8',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAVente_V9:String; // 445719
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAVente_V9']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAVente_V9',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteChargeConstateeDAvance:String; // 486
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteChargeConstateeDAvance']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteChargeConstateeDAvance',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteProduitConstateDAvance:String; // 487
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteProduitConstateDAvance']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteProduitConstateDAvance',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteAmortDerogatoire:String; // 145
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteAmortDerogatoire']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteAmortDerogatoire',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteChargeAPayerDefaut:String; // 4081
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteChargeAPayerDefaut']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteChargeAPayerDefaut',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteProduitARecevoirDefaut:String; // 4181
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteProduitARecevoirDefaut']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteProduitARecevoirDefaut',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteProvisionsDefaut:String; // 1518
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteProvisionsDefaut']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteProvisionsDefaut',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAChargeAPayer:String; // 44586
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAChargeAPayer']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAChargeAPayer',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteTVAProduitARecevoir:String; // 44587
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteTVAProduitARecevoir']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteTVAProduitARecevoir',mtError,[mbOK],0);
   abort;
  end;
end;


Function DM_C_ListeCptObligatoire:TStringList;
var
i,j,rang:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''Compte*''');
   result:=TStringList.Create;
   ChampTableVersVarListe('VAlpha',DMConst.TaConst,result);
//   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
//   For i:=1 to j do
//     begin
//      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
//     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeCptObligatoire',0,true,mtError,ErreurSaisie)
   else
     begin
         rang:=-1;//initialisé au cas où le typeEntreprise ne correspond à aucun des 2
         if  e.TypeEntreprise ='IND' then rang:=result.IndexOf(DM_C_CompteRepartitionResultatAssocie);
         if  e.TypeEntreprise ='SOC' then rang:=result.IndexOf(DM_C_CompteRepartitionResultatIndividuelle);
         if rang<>-1 then result.Delete(rang);
     end;
  except
//   MessageDlg('Erreur à la récupération de : ListeCTVAAchat',mtError,[mbOK],0);
   abort;
  end;
End;

// Retourne Une liste des fenêtres
Function DM_C_ListeFenetre:tstringlist;
var
i,j:integer;
Begin
  try
   result:=TStringList.Create;
   Result.Add('Ouverture - Immos'); //0
   Result.Add('Ouverture - Emprunts'); //1
   Result.Add('Ouverture - Stocks');   //2
   Result.Add('Ouverture - Charges A Répartir');  //3
   Result.Add('Ouverture - Charges Constatées d''Avance');  //4
   Result.Add('Ouverture - Produits Constatés d''Avance'); //5
   Result.Add('Ouverture - Charges A Payer');  //6
   Result.Add('Ouverture - Produits A Recevoir');  //7
   Result.Add('Ouverture - Provisions');  //8
   Result.Add('Ouverture - Dettes et Créances - Pièces');  //9
   Result.Add('Ouverture - Dettes et Créances - Ecritures');  //10
   Result.Add('Ouverture - Balance - Soldes Report');   //11
   Result.Add('Mouvement - Saisie pièces - Ecritures');   //12
//   Result.Add('');
//   Result.Add('');
//   Result.Add('');
//   Result.Add('');
  except
   MessageDlg('Erreur à la génération de la Liste des Ecrans',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CompteRepartitionResultatIndividuelle:String; // 1012
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteRepartitionResultatIndividuelle']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteRepartitionResultatIndividuelle',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_CompteRepartitionResultatAssocie:String; // 455
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CompteRepartitionResultatAssocie']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : CompteRepartitionResultatAssocie',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportSARA:String; // IMPORTATION SARA
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportSARA']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportSARA',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportE2_FAC:String; // IMPORTATION E2_FAC
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportE2_FAC']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportE2_FAC',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportCAISSE:String; // IMPORTATION CAISSE B
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportCAISSE']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportCAISSE',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportCAISSEB:String; // IMPORTATION CAISSE
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportCAISSEB']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportCAISSEB',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportCAISSEMPFacture:String; // IMPORTATION CAISSE Micro pointe Facture
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportCAISSEMPFacture']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportCAISSEMPFacture',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportCAISSEMPTicket:String; // IMPORTATION CAISSE Micro pointe Ticket
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportCAISSEMPTicket']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportCAISSEMPTicket',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportCAISSEMPCarte:String; // IMPORTATION CAISSE Micro pointe Facture
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportCAISSEMPCarte']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportCAISSEMPCarte',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportCAISSEMPCheque:String; // IMPORTATION CAISSE Micro pointe Chèque
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportCAISSEMPCheque']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportCAISSEMPCheque',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportCAISSEMPEspece:String; // IMPORTATION CAISSE Micro pointe Espece
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportCAISSEMPEspece']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportCAISSEMPEspece',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomFichierImportCAISSEMPVirement:String; // IMPORTATION CAISSE Micro pointe Virement
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomFichierImportCAISSEMPVirement']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomFichierImportCAISSEMPVirement',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanAGRReel:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanAGRReel']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanAGRReel',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanAGRReelOuverture:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanAGRReelOuverture']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanAGRReelOuverture',mtError,[mbOK],0);
   abort;
  end;
end;


Function DM_C_NomBilanBICReelOuverture:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanBICReelOuverture']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanBICReelOuverture',mtError,[mbOK],0);
   abort;
  end;
end;


Function DM_C_NomBilanAGRReel2144:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanAGRReel2144']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanAGRReel2144',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanAGRReel2145:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanAGRReel2145']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanAGRReel2145',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanAGRReel2146:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanAGRReel2146']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanAGRReel2146',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanAGRReel21462:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanAGRReel21462']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanAGRReel21462',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_ListeCTVAIntracommunautaire:TStringList; // C,L,N,E classe intracommunautaire
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''ListeCTVAIntracommunautaire''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : ListeCTVAIntracommunautaire',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

Function DM_C_ListeZonePourSommeTotauxBilan(NomZoneBilan:string):TStringList;
// Retourne sous forme de liste les différents éléments à
// additionner ou soustraire de la table ParamLia
// en fonction de : NomZoneBilan
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 6 and NomConst='''+NomZoneBilan+'''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeZonePourSommeTotauxBilan',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

Function DM_C_ListeZoneTotauxBilan:TStringList;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   DeFiltrageDataSet(DMConst.QuConst);
   DMConst.QuConst.Close;
   DMConst.QuConst.SQL.Clear;
   DMConst.QuConst.SQL.Add(' select * from Const C ');
   DMConst.QuConst.SQL.Add(' where Type = 6 ');
   DMConst.QuConst.SQL.Add(' order by C.VNumerique ');
   DMConst.QuConst.Prepare;
   DMConst.QuConst.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListe('NomConst',DMConst.QuConst);
   DMConst.QuConst.Close;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeZoneTotauxBilan',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;


Function DM_C_ListeZonePourSommeTotauxBilanOuverture(NomZoneBilan:string):TStringList;
// Retourne sous forme de liste les différents éléments à
// additionner ou soustraire de la table ParamLia
// en fonction de : NomZoneBilan
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   DeFiltrageDataSet(DMConst.QuConst);
   DMConst.QuConst.Close;
   DMConst.QuConst.SQL.Clear;
   DMConst.QuConst.SQL.Add(' select * from const ');
   DMConst.QuConst.SQL.Add(' where not (nomconst in (select nomconst from const where type=8))');
   DMConst.QuConst.SQL.Add(' and type=6 ');
   DMConst.QuConst.SQL.Add(' union ');
   DMConst.QuConst.SQL.Add(' select * from const ');
   DMConst.QuConst.SQL.Add(' where type=8 and VAlpha<>''+;'' and VAlpha<>''-;''');
   DMConst.QuConst.SQL.Add(' order by VNumerique ');
   DMConst.QuConst.Prepare;
   DMConst.QuConst.Open;
   FiltrageDataSet(DMConst.QuConst,'NomConst='''+NomZoneBilan+'''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.QuConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.QuConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeZonePourSommeTotauxBilanOuverture',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

Function DM_C_ListeZoneTotauxBilanOuverture:TStringList;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   DeFiltrageDataSet(DMConst.QuConst);
   DMConst.QuConst.Close;
   DMConst.QuConst.SQL.Clear;
   DMConst.QuConst.SQL.Add(' select * from const ');
   DMConst.QuConst.SQL.Add(' where not (nomconst in (select nomconst from const where type=8))');
   DMConst.QuConst.SQL.Add(' and type=6 ');
   DMConst.QuConst.SQL.Add(' union ');
   DMConst.QuConst.SQL.Add(' select * from const ');
   DMConst.QuConst.SQL.Add(' where type=8 and VAlpha<>''+;'' and VAlpha<>''-;''');
   DMConst.QuConst.SQL.Add(' order by VNumerique ');
   DMConst.QuConst.Prepare;
   DMConst.QuConst.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListe('NomConst',DMConst.QuConst);
   DMConst.QuConst.Close;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeZoneTotauxBilanOuverture',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

//
Function DM_C_ListeCaractereCorrect_SQL:tstringlist;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''ListeCaractereCorrect_SQL''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : ListeCaractereCorrect_SQL',0,true,mtError,ErreurSaisie);
  except
//   MessageDlg('Erreur à la récupération de : ListeCTVAAchat',mtError,[mbOK],0);
   abort;
  end;
End;



Function DM_C_ListeEcranVerrouilleExoCloture:TStringList;
var
i,j,rang:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''EcranVerrouilleExoCloture''');
   result:=TStringList.Create;
   ChampTableVersVarListe('VAlpha',DMConst.TaConst,result);
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeEcranVerrouilleExoCloture',0,true,mtError,ErreurSaisie)
  except
   abort;
  end;
End;


Function DM_C_ListeEcranVerrouilleN1:TStringList;
var
i,j,rang:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''EcranVerrouilleN1''');
   result:=TStringList.Create;
   ChampTableVersVarListe('VAlpha',DMConst.TaConst,result);
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeEcranVerrouilleN1',0,true,mtError,ErreurSaisie)
  except
   abort;
  end;
End;

Function DM_C_ListeEcranVerrouilleOuverture:TStringList;
var
i,j,rang:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''EcranVerrouilleOuverture''');
   result:=TStringList.Create;
   ChampTableVersVarListe('VAlpha',DMConst.TaConst,result);
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeEcranVerrouilleOuverture',0,true,mtError,ErreurSaisie);
DeFiltrageDataSet(DMConst.TaConst);
  except
   abort;
  end;
End;

Function DM_C_PourcentageTvaRegle:Currency;
var F: TextFile;
Ligne:string;
Begin
result:= 0.95;
  try
   if FileExists(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'PourcentageTvaRegle.txt') then
     begin
        AssignFile(F, IncludeTrailingPathDelimiter(E.RepertoireDossier)+'PourcentageTvaRegle.txt');
        append(F);
        reset(F);
        Readln(F,Ligne);
        result:=StrToCurr_Lgr(Ligne,0.95);
        CloseFile(F);
     end
   else
     begin
       if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
       FiltrageDataSet(DMConst.TaConst,'Type = 5');
       result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['PourcentageTvaRegle']).VCurrency;
     end;
  except
   MessageDlg('Erreur à la récupération de : PourcentageTvaRegle',mtError,[mbOK],0);
   abort;
  end;
End;


Function DM_C_ListeZoneTotauxBilan_Bic:TStringList;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   DeFiltrageDataSet(DMConst.QuConst);
   DMConst.QuConst.Close;
   DMConst.QuConst.SQL.Clear;
   DMConst.QuConst.SQL.Add(' select * from Const C ');
   DMConst.QuConst.SQL.Add(' where Type = 7 ');
   DMConst.QuConst.SQL.Add(' order by C.VNumerique ');
   DMConst.QuConst.Prepare;
   DMConst.QuConst.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListe('NomConst',DMConst.QuConst);
   DMConst.QuConst.Close;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeZoneTotauxBilan_Bic',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

Function DM_C_ListeZoneTotauxBilanOuverture_Bic:TStringList;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   DeFiltrageDataSet(DMConst.QuConst);
   DMConst.QuConst.Close;
   DMConst.QuConst.SQL.Clear;
   DMConst.QuConst.SQL.Add(' select * from const  ');
   DMConst.QuConst.SQL.Add(' where not (nomconst in (select nomconst from const where type=9))');
   DMConst.QuConst.SQL.Add(' and type=7 ');
   DMConst.QuConst.SQL.Add(' union ');
   DMConst.QuConst.SQL.Add(' select * from const  ');
   DMConst.QuConst.SQL.Add(' where type=9 ');
   DMConst.QuConst.SQL.Add(' order by VNumerique ');
   DMConst.QuConst.Prepare;
   DMConst.QuConst.Open;
   result:=TStringList.Create;
   result:=ChampTableVersListe('NomConst',DMConst.QuConst);
   result.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'DM_C_ListeZoneTotauxBilanOuverture_Bic.txt');
//   DMConst.QuConst.Close; le laisser ouvert pour le filtrer dans procédure  "DM_C_ListeZonePourSommeTotauxBilanOuverture_Bic"
//sinon, si je dois reconstruire la requete à chaque coups, ça plante !!!
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeZoneTotauxBilanOuverture_Bic',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

Function DM_C_ListeZonePourSommeTotauxBilanOuverture_Bic(NomZoneBilan:string;Dataset:Tdataset):TStringList;
// Retourne sous forme de liste les différents éléments à
// additionner ou soustraire de la table ParamLia
// en fonction de : NomZoneBilan
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   if dataset=nil then //on utilise par défaut Quconst
      Begin
       DeFiltrageDataSet(DMConst.QuConst);
       DMConst.QuConst.Close;
       DMConst.QuConst.SQL.Clear;
       DMConst.QuConst.SQL.Add(' select * from const  ');
       DMConst.QuConst.SQL.Add(' where not (nomconst in (select nomconst from const where type=9))');
       DMConst.QuConst.SQL.Add(' and type=7 ');
       DMConst.QuConst.SQL.Add(' union ');
       DMConst.QuConst.SQL.Add(' select * from const  ');
       DMConst.QuConst.SQL.Add(' where type=9 ');
       DMConst.QuConst.SQL.Add(' order by VNumerique ');
       DMConst.QuConst.Prepare;
       DMConst.QuConst.Open;
       FiltrageDataSet(DMConst.QuConst,'Nomconst = '''+NomZoneBilan+'''');
      end
   else
     FiltrageDataSet(Dataset,'Nomconst = '''+NomZoneBilan+'''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.QuConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.QuConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeZonePourSommeTotauxBilanOuverture_Bic',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

Function DM_C_ListeZonePourSommeTotauxBilan_Bic(NomZoneBilan:string):TStringList;
// Retourne sous forme de liste les différents éléments à
// additionner ou soustraire de la table ParamLia
// en fonction de : NomZoneBilan
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 7 and NomConst='''+NomZoneBilan+'''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : DM_C_ListeZonePourSommeTotauxBilan_Bic',0,true,mtError,ErreurSaisie);
  except
     abort;
  end;
End;

//
//
Function DM_C_NomBilanBICReel:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanBICReel']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanBICReel',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanBICReel2050:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanBICReel2050']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanBICReel2050',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanBICReel2051:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanBICReel2051']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanBICReel2051',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanBICReel2052:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanBICReel2052']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanBICReel2052',mtError,[mbOK],0);
   abort;
  end;
end;

Function DM_C_NomBilanBICReel2053:String; // Nom du fichier PDF pour les resultats
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['NomBilanBICReel2053']).VAlpha;
   if Empty(Result) then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération de : NomBilanBICReel2053',mtError,[mbOK],0);
   abort;
  end;
end;


Function DM_C_Delimiteur:Char;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['Delimiteur']).VAlpha[1];
   if (Result='') then
    raise ExceptLGR.Create('',0,false,mtError,ErreurSaisie);
  except
   MessageDlg('Erreur à la récupération du : Delimiteur',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_DateFinVersionNonProtegee:string;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['DateFinVersionNonProtegee']).VAlpha;
  except
   MessageDlg('Erreur à la récupération de : DateFinVersionNonProtegee',mtError,[mbOK],0);
   abort;
  end;
End;


Function DM_C_DateFinDemo:string;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['DateFinDemo']).VAlpha;
  except
   MessageDlg('Erreur à la récupération de : DateFinDemo',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_DateDebutDemo:string;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['DateDebutDemo']).VAlpha;
  except
   MessageDlg('Erreur à la récupération de : DateDebutDemo',mtError,[mbOK],0);
   abort;
  end;
End;

Function DM_C_CodeExoDemo:string;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['CodeExoDemo']).VAlpha;
  except
   MessageDlg('Erreur à la récupération de : CodeExoDemo',mtError,[mbOK],0);
   abort;
  end;
End;


Function DM_C_ListeCodeTvaNonModifiableSiDeclare:tstringlist;
var
i,j:integer;
Begin
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5 and NomConst=''ListeCodeTvaNonModifiableSiDeclare''');
   result:=TStringList.Create;
   j:=Str_Count_Str(';',DMConst.TaConst.findField('VAlpha').AsString);
   For i:=1 to j do
     begin
      Result.Add(str_getstringelement(DMConst.TaConst.findField('VAlpha').AsString,i,';'));
     end;
   if Result.Count=0 then
    raise ExceptLGR.Create('Erreur à la récupération de : ListeCodeTvaNonModifiableSiDeclare',0,true,mtError,ErreurSaisie);
  except
   abort;
  end;
End;

Function DM_C_ServeurFTP:String;
Begin
   result:= 'monftp-1.net';
  try
   if (DMConst = nil) then DMConst:=TDMConst.Create(Application.MainForm);
   FiltrageDataSet(DMConst.TaConst,'Type = 5');
   result:= Infos_TInfosConst(DMConst.TaConst,'NomConst',['ServeurFTP']).VAlpha;
  except
   MessageDlg('Erreur à la récupération de : ServeurFTP',mtError,[mbOK],0);
   abort;
  end;
End;

end.

