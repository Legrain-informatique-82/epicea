{//////// le 29-04-03  Modif_Isa
j'ai rajouter le record  TTypeImmo ,  et modifié  TSuppressionImmos et tous ceux qui le contienne
///////}
unit E2_Decl_Records;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
     Controls, Dialogs, LibFichRep,Forms, Registry, stdctrls,dbgrids,grids,menus,buttons,
     RXCtrls,
     Gr_Librairie_Obj,
     TStringlistLGR,
     ImportDll,
     //E2_LibInfosTable,
     db;
//,GrGrid;


 Const
 // Liste des clés utilisé dans le fichier XML
 C_QueryUser1 = 'QueryUser1';
 C_QueryUser2 = 'QueryUser2';
 CXML_RepImportation = 'RepImportation';
 CXML_RepImportationEpiDos = 'RepImportationEpiDos';
 CXML_RepImportationSIEA = 'RepImportationSIEA';
 CXML_RepExportation = 'RepExportation';
 CXML_RepExportationBalance = 'RepExportationBalance';
 CXML_RepExportationLiasse = 'RepExportationLiasse';
 CXML_RepExportationDossier = 'RepExportationDossier';
 CXML_RepRelanceTiers = 'RepRelanceTiers';
 CXML_DateVersion = 'DateVersion';
 CXML_Exo_A_Verifier ='Exo_A_Verifier'; 
 CXML_DirDos = 'DirDos';
 CXML_PlanDeSaisie = 'PlanDeSaisie';
 CXML_RepDblSauvegarde = 'RepDblSauvegarde';
 CXML_RepSauvegardeFermeture = 'RepSauvegardeFermeture';
 CXML_RepSauvegardeFermetureCloud = 'RepSauvegardeFermetureCloud'; 
 CXML_ParamFTP = 'ParamFTP';
 CXML_RepTelechargementReleve = 'RepTelechargementReleve';
 CXML_CompteBanqueDefaut = 'CompteBanqueDefaut';
 CXML_NomSauvegarde = 'TextNomSauvegarde';

  CXML_ComptePointableCaisseEnregistreuse = 'ComptePointableCaisseEnregistreuse';
   CXML_TauxTvaCaisseEnregistreuse = 'TauxTvaCaisseEnregistreuse';
// Constante des Répertoire par défaut

 // Autre Constante utilisé partout dans le programme
 
 C_ValeurCleVide = '000000000000000000000000';
 C_NomDossierDemo = 'Demo';
 C_NomExoDemo = 'ExoDemo';
 C_NomUtilDefaut = 'Anonyme';

 C_RepDossierDefaut = 'C:\LGRDOSS\EPICEA';
 C_RepImportation = 'Importation\';
 C_RepImportationEpiDos = 'C:\Cedi\';
 C_RepImportationSIEA = 'Importation\';
 C_RepExportation = 'Exportation\';
 C_RepExportationLiasse = 'ExportationLiasse\';
 C_repTelechargementReleve = '';

 //C_CompteBanqueDefaut =

 C_REP_JOURNAL_IMP_SIEA = 'JOURNAL_IMPORT_SIEA-';
 C_REP_JOURNAL_IMP_EPIDOS = 'JOURNAL_IMPORT_EPIDOS-';
 C_REP_JOURNAL_IMP_E2FAC = 'JOURNAL_IMPORT_E2FAC-';
 C_REP_JOURNAL_IMP_SARA = 'JOURNAL_IMPORT_SARA-';
 C_REP_JOURNAL_IMP_BLOQUEL = 'JOURNAL_IMPORT_BLOQUEL-';

 WM_PROTECTMESSAGE=WM_user + 1997;
 C_SensSoldeCredit=1;
 C_SensSoldeDebit=-1;
 C_SensSoldeNul=0;

 C_Reglement_Saisie_P=0;
 C_Reglement_Pointage=1;
 C_StrVide = '';
 C_MarqueDefaut='001';// Rapprochement bancaire
 C_MaxNbJournaux = 36;

 C_EditionSimple = 0;
 C_EditionWeb = 1;
 C_EditionSimpleLiee = 2;
 C_Exportation=3;
 C_ExportationImprimable=4;
 C_ExportationLiasse=5;

 C_InfoEpicea = -1;
 C_Ouverture = 0;
 C_Cloture = 1;
 C_Mouvement = 2;
 C_Ecriture = 3;

 C_ChargeCA = 1;
 C_ProduitCA = 2;

 C_ChargesAPayer = 1;
 C_ProduitsARecevoir = 2;

   const
      C_DEBUT_CHG_COEF = '01/01/1996';
      C_FIN_CHG_COEF = '01/01/1997';
      C_IMMOS = 0;
      C_ACQUIS_EXO = 1;
      C_REBUT = 2;
      C_DIVISION = 3;
      C_ACQUISITION_Terminee = 4;
      C_ACQUISITION_En_Cours=5;
      C_CESSION = 6;
      C_CESSION_EXO = 7;
      C_DESCRIPTION_simple=8;
      C_DESCRIPTION_En_Cours=9;
      C_ACQUISITION_Simple=10;
      C_DESCRIPTION_Terminee=11;
      //type infos pour remplissage liste (TInfos)
      T_Cession=1;
      T_ImmosEnCours=2;

      C_ImmoCourante=0;
      C_SelectionSurToutes=1;
      C_SelectionSurImmo=2;
      C_SelectionSurSub=3;

      C_NbPointageMaxi = 25; // NE PAS CHANGER !!!!!!!!!!!!!!!
      C_True=2;
      C_False=1;
      C_Nul=0;

      //// Constantes servant au calcul tva (historique des choix)
      C_Calcul=0;
      C_APayer=1;
      C_Report=2;
      C_Remboursement=3;
      C_Id_Decl_Tmp=-2;

      /// constantes pour la déclaration de TVA
      AffichRien=-1;
      AffichCalcul=0;
      ReCalcul=1;

      TvaSurD=0;
      TvaSurE=1;
      TvaSurE_D=2;

      Rien=0;
      En_attente=1;
      Pas_En_Attente=2;
      /// fin des constantes pour la déclaration de TVA

      // constante définissant le type de dossier à restaurer // PB le 18/09/03
      CT_DOSSIER_COURANT = 0; //
      CT_DOSSIER_AUTRE = 1;
      CT_DOSSIER_IMPORTE = 2;

      // Constante déterminant le type de version qu'on veut exécuter

      CT_DEVELOPPEMENT = 1;
      CT_DISTRIBUTION = 0;

      //nb max de dossiers par défaut
      CT_MaxDosMenu=5;

      // Type Impression
      C_IMP_MOZiLLA_LOCAL =2;
      C_IMP_MOZILLA_WEB = 1;
      C_IMP_NORMAL = 0;

      // Type de détail
      C_Detail_Tiers = 1;
      C_Detail_Compte = 2;
      C_Detail_CompteTva = 3;
      C_Detail_Journal = 4;

      //type de marquage
      C_Cocher=0;
      C_Decocher=1;
      C_Inverse=2;

      //Liste des constantes qui représentent les numéros de tables de la bd program
      C_IPlanCpt=213;

      // Liste des constantes utilisée dans l'affichage des infos sur Epicéa - E2_InfosEpicea
      C_InfosDossier = 'InfosDossier';
      C_InfosStocks = 'InfosStocks';
      C_InfosEmprunts = 'InfosEmprunts';

      // type de calcul pour DMRapprochementBancaise
      C_CalculerTout = 0;
      C_CalculerReportReleveBanque = 1;
      C_CalculerTotalMvtCompte = 2;
      C_CalculerSoldeCompte = 3;
      C_CalculerTotalMvtCompteNonMarque = 4;
      C_CalculerSoldeReleveBanque = 5;

Type
  TGEstInterfaceEvent=procedure(CCourant:Tfield;sender:TObject = nil) of object;
  TGrNotifyEvent= procedure (Sender: TObject) of object;
  TGrProcedure = Procedure (indice:integer )of object;
  PJournauxTva=^TJournauxTva;
  PInfoLigneTva=^TInfoLigneTva;
  PListErreur=^TListErreur;
  PListCloture=^TerreurCloture;
  PTvaExigible=^TTvaExigible;
  PIdentifiant_obj= ^Identifiant_obj;
  PRecordEcriture= ^TRecordEcriture;
  PRecordPiece= ^TRecordPiece;
  PReglement_Sur_Liste=^TReglement_Sur_Liste;
  PEcriture_A_Regler=^TEcriture_A_Regler;
  PSolde_A_Traiter=^TSolde_A_Traiter;
  PParam_InfosComplTva=^TParam_InfosComplTva;
  PSolde_A_Declarer=^TSolde_A_Declarer;
  PInfos_Piece=^TInfos_Piece;
//  PAdresseTraitement=procedure (sender:TObject)of object;
  PAdresseTraitement=pointer;
  PListeResteAffect=^TListeResteAffect;
  Pstringlist=^Tstringlist;
//  TTypeDossier = (VerDiocese,VerAgricole,VerGeneral,
//                  VerDiocAdmin,
//                  VerDemoAgri,VerDemoDioc,VerDemoGeneral,
//                  VerInconnu,
//                  VerAgriClot,VerGeneClot,VerDiocClot);
//
//  TTypeClient= (CL_Inconnu,CL_Cogere,CL_Normal,CL_Isa
//  //,CL_Demo,CL_Saisie_Normal,CL_Saisie_Demo,CL_Saisie_Cogere,CL_Normal_2,CL_Normal_3     //23/09/2010
//  );
//
//  TTypeUtilisateur=(U_Inconnu,U_Normal,U_Demo,U_Comptable,U_SuperComptable);
//  TTypeVersion=(V_Inconnu,V_Complete,V_Saisie,V_SSImmos,V_4);

  TTypeFenetre=(F_DetailAcquis,F_VisuImmo,F_Division,F_Rebut,F_ChoixAmortissement,F_Cession,F_inconnu,F_EcheEmprunt,F_DescEmp);

  TBooleanNul=integer;

  TExecProc = procedure of object;
  TExecFBoolean = function:boolean;
  TExecFDataset = Function : TDataSet of object ;
  TExecMethode = class of TDataModule;
  TFiltreAideCompte1=procedure (Famille:integer);
  TFiltreAideCompte2=procedure (Famille:integer;Compte:string);
  TTypeEtatExercice = (ET_Importation,ET_Normal,ET_EnCloture,ET_Maint,ET_MaintS,ET_Cloture,ET_Inconnu);
  TTypeMiseAJourBalance=(MAJ_Report,MAJ_Normal,MAJ_Base);
  TtypeImmos=(C_Toutes,C_Sub,C_Immo,C_NonIndique);
  TTypeAmort=(C_Degessif,C_Lineaire,C_Tout);
  TtypeEmprunts=(C_Tous,C_EnCours,C_Finis);
  TtypeRapprochement=(C_TousRapp,C_EnCoursRapp,C_NonMarques,C_Marques,C_abandonne);
  TGestionAffichForm = record
   Affich:Boolean;
   Caption:String;

  end;

  retourCompteBancaire=record
  site:string;
  compte:string;
  journal:string;
  login:string;
  password:string;
  retour:boolean;
  Arecupere:boolean;
end;

    TParamAfficheReleve=record
    Titre:string;
    SousTitre:string;
    Direct:boolean;
    DateFinReleve:TDate;
    Journal:string;
    libelleJournal:string;
    Marque:string;
  end;

 TMessages=Record
    MessageErreur:string;
    MessageQuestion:string;
 end;

  //record de retour de la plus grande référence dans une liste de différentes références données
 TReference=record
   Reference:string;
   retour:boolean;
 end;

  TRetourCtrlSaisieImmo=record
    EditAmoEco_Enabled:boolean;
    EditAmoDerog_Enabled:boolean;
    Btn_Enregistrer_Enabled:boolean;
    RgTypeAmo_ItemIndex:integer;
    DateAcquis:Tdatetime;
  end;

  TerreurListe=record   // Pourrait être remplacer par TErreurSasie dans le programme
    CodeErreur:integer; // car très peut utilisé !!!!
    Retour:boolean;
  end;

  TErreurTva=record
    CodeErreur:integer;
    Retour:boolean;
    Messages:string;
    SupprODDecl:boolean;
    Continuer:boolean;
//    Verrouillee:boolean;
//    Deverrouillable:boolean;
  end;


  TReste=record
    ResteInitial:currency;
    Reste:currency;
    SensReste:boolean;
  end;

  TinfosPointageS=record
    Pointee:boolean;
    NbLignePointee:integer;
    Dataset:TDataSet;
    MontantPointage:currency;
    Lettre:string[1];
    Ligne:integer;
    TvaSurE:boolean;
  end;

  TTvaExigible=record
    IDEcriture:integer;
    IDPiece:integer;
    CompteTva:string;
    MontantTva:currency;
    exigible:boolean;
  end;

  TChoix=record
    Complementchoix:currency;
    choixDefaut:currency;
    ChoixItem:integer;
    Tag:integer;
  end;

  TAmortImmo=record
    compte:string;
    TypeAmort:string[1];
    Mini:currency;
    Maxi:currency;
    Choix:currency;
    Derog:currency;
    EcoTheorique:currency;
    EcoRepartition:currency;
    EcoObligatoire:currency;
    Report_Eco:currency;
    Report_Derog:currency;
    MiniAnnee:currency;
    VNC:currency;
    Report:Currency;
    Gerer_Derog:boolean;
  end;

  TDernierValide=record
    DernierCpt:string;
    DernierLibelle:string;
  end;


   TErreurSaisie=record
   CodeErreur:integer;
   retour:boolean;
 end;

  TListErreur=record
    Erreur:TErreurSaisie;
    CompteImmo:string;
    ComptePlan:string;
    SoldeImmo:currency;
    SoldePlan:currency;
    messages:string;
  end;

  TerreurCloture=record
    ListErreur:TList;
    CodeVerif:integer;
    erreur:TErreurSaisie;
    AdresseTraitement:PAdresseTraitement;
    messages:Tmessages;
    TitreBouton:string;
    TitreListe:string;
    Obligatoire:boolean;
  end;

//  TDistribution=record
//     TypeVersion:TTypeVersion;
//     TypeClient:TTypeClient;
//     TypeDossier:TTypeDossier;
//     TypeUtilisateur:TTypeUtilisateur;
//  end;


  TRecordEcriture=record
    TypeLigne:string[1];
    Compte:string[8];
    CompteTiers:string[8];
    Libelle:string[100];
    Qt1:currency;//8
    Qt2:currency;//8
    MontantHt:currency;//8
    MontantTVA:currency;//8
    CompteTVA:string[8];
    CodeTVA:string[2];
    TauxTVA:currency;//8
    TypeTVA:String[1];
    DateTVA:string[10];
    ID_Piece:integer;
    CptRepartition:string;
    LibelleRepartition:string;
    TauxRepartition:real;
    //rajout pour création Tiers
    NomTiers:string[30];
    Addresse1:string[30];
    Addresse2:string[30];
    CodePostal:string[5];
    Ville:string[25];
    //
  end;

  TObjetOD=record
    TypeLigne:string[1];
    compteEcriture:string;
    LibEcriture:string;
    Qte1:real;
    Qte2:real;
    DebitSaisie:currency;
    CreditSaisie:currency;
    Debit:currency;
    Credit:currency;
    ID_Devise:integer;
  end;

  TRecordPiece=record
    ID:integer;//1
    IDJournal:integer;//6
    ReferenceInitiale:string[9];
    Reference:string[9];
    Date:Tdate;
    Validation:Tdate;
    Quand:Tdate;
    Libelle:string[100];
    Compte:string[8];
    Journal:string[2];
    AutoGeneree:boolean;
    retour:boolean;
    TotalPiece:currency;//8
    Code:string[2];
    Echeance:string[10];
    Num:string[3];
    TypePiece:string[1];
    bool:string[1];
    Trame:boolean;
    Tiers:string[8];
    NomTiers:string[30];
    Addresse1:string[30];
    Addresse2:string[30];
    CodePostal:string[5];
    Ville:string[25];
    Pays:String[25];
    Telephone:String[14];
    Table_Gen:string[50];
    Champ_Gen:string[50];
    Val_Champ_Gen:string[100];
end;


  TJournauxTva = record
    TypeTva: char;
    CodeTva:string[2];
    SoldeHT_TypeEtCode:currency;
    SoldeTVA_TypeEtCode:currency;
    SoldeTTC_TypeEtCode:currency;
  end;

  TFiltre=record
    filtre:string;
    Requete:string;
    filtrer:boolean;
  end;

  TInfoLigneTva = record
   MontantLigne:currency;
   TypeTva:char;
   CodeTva:String[2];
   SensCredit:Boolean;
   DansPeriode:Boolean;
   PourcentageTvaLigne:Extended;
   MontantTvaLigne:currency;
   PourcentagePointe:extended;
   PourcentageApplique:extended;
   MontantTvaDeclare:currency;
  end;

  TRecupInfosTVA=record
    CompteTVA:string;
    CodeTVA:string;
    Taux_Inf:currency;
    Taux_Supp:currency;
    CodeRetour:integer;
  end;


  TTvaCodePourCompte = record
   Retour:Boolean;
   ListeClasse:TStringList;
   ListeCode:TStringList;
   ListeCompteTVA:TStringList;
   end;

  TPartieEnregistrement=record
    Partie:variant;
    codeRetour:boolean;
  end;

  TEnregistrementComplet=record
  Compte:string;
  Libelle:string;
  Debit_Deb:extended;
  Credit_Deb:extended;
  Un1:string;
  Un2:string;
  Qt1_Deb:extended;
  Qt2_Deb:extended;
  PlanSaisie:boolean;
  TvaCode:string;
  TvaType:string;
  TvaDebit:boolean;
  SensCredit:TBooleanNul;
  Collectif:Boolean;
  Centraliser:Boolean;
  Tiers:Boolean;
  Rapprochement:Boolean;
  Immobilisation:Boolean;
  ImmoAmort:Boolean;
  ImmoDegressif:Boolean;
  Emprunt:Boolean;
  Abandonne:Boolean;
  Qui:string;
  Quand:TDateTime;
  CodeRetour:boolean;
  end;

 TComplementLigne_obj=record
   CodeTvaCompl:string;
   TvaType:string;
   TvaDate:string;
   TvaTaux:real;
   MontantTva:currency;
   rempli:boolean;
   ModifUtilisateur:boolean;
 end;

  TPointage=record
    infosPointage:TinfosPointageS;
    InfosReste:TReste;
  end;


 TParamChamp_obj=record
   readOnly:boolean;
  end;

 TModif_obj=record
  ASupprimer:boolean;
  NewRow:integer;
  SupprAutomatique:boolean;
  ModifAutomatique:boolean;
 end;

  TErreurLigne = record
    CodeErreur:integer;
    Retour:boolean;
    Modif:TModif_obj;
    CompteConcerne:string;
    MessageErreur:TMessages;
  end;

  TRecupParamTva_obj = record
   Retour:Boolean;
   CodeTva:string;
   TauxMin:Real;
   TauxMax:Real;
   Compte:string;
   Libelle:string;
   sensCredit:boolean;
   MontantMini:currency;
   MontantMaxi:currency;
   MontantReel:currency;
  end;

 TCreation_obj=record
   Existe:boolean;
   Acreer:boolean;
   NumLigne:integer;
   NumLigneConcernee:integer;
   CompteConcerne:string;
   TypeLigne:Char;
   CodeTva:string;
   CompteTva:string;
   LibelleTva:string;
   SensCredit:boolean;
   MontantDefaut:currency;
 end;

 TBlocLigne_obj=record
   Appartient:boolean;
   Derniere:boolean;
 end;

 TParamLigne_obj=record
   Enregistrer:boolean;
   init:boolean;
   TypeLigne:Char;
   Ligne:TBlocLigne_obj;
   Compte:string;
   Tiers:string;
   Libelle:string;
   Qt1,Qt2:string;
   Debit:currency;
   Credit:currency;
   ChampCompte:TParamChamp_obj;
   ChampQt1:TParamChamp_obj;
   ChampQt2:TParamChamp_obj;
   SensCredit:boolean;
   TVA:TRecupParamTva_obj;
   Complement:TComplementLigne_obj;
   ComplementTmp:TComplementLigne_obj;
 end;
 
  TInfosTrameSupp=Record
    CptRepartion:string;
    LibelleRepartion:string;
    TauxRepartion:real;
  end;



 Identifiant_obj=record
   IDLigne:integer;
   ID_Tmp:integer;
   ID_Ord:integer;
   LigneCourante:string;
   Ligne:TParamLigne_obj;
   infosPointages:Tpointage;
   InfosTrame:TInfosTrameSupp;
 end;

 TRetourMontantTva= record
  retour:boolean;
  FourchetteModifier:boolean;
  RetourMontantMini:currency;
  RetourMontantMaxi:currency;
  retourMontantReel:currency;
  RetourMontantMini_extended:extended;
  RetourMontantMaxi_extended:extended;
  SensCredit:Integer;
  SensCreditReel:integer;
end;

  TParamLigneObj = record
    CompteValide:Boolean;
    IDJournal:integer;
    TvaMini:real;
    TvaMaxi:real;
    CompteTva:string;
    CodeTva:string;
    Qt1:Boolean;
    Qt2:Boolean;
    SensCredit:Boolean;{vrai : Credit ; Faux : Debit}
  end;

  TInfosPiece_SurTypeLigne=record
    Debit:currency;
    Credit:currency;
    montanttva:currency;
    SenssoldeTva:integer;
    Solde:currency;
    SensSoldeCredit:integer;
    NbLigne:integer;
    IndexLignes:TListInteger;
  end;

  TValPieceAutoGenere=record
     Table_Gen:string;
     Champ_Gen:string;
     Val_Champ_Gen:string;
     TableGen:boolean;
   end;


   TRecupParametres=record
     sens1,sens2,sens3:string;
     Qte1,Qte2,Qte3:string;
     compteVariation:TStringList;
   end;
   TPieceAnterieure =record
   PieceAnterieure:boolean;
   ExoAnterieure:string[2];
 end;

  TVerrouillage=record
    PieceVerrouillee:boolean;
    PeriodeVerrouillee:boolean;
    PeriodeDeverrouillable:boolean;
    Deverrouillable:boolean;
  end;


  TResteDCInfoLettrageEnCours = record
   TotalMontantImputationSensD:currency;
   TotalMontantImputationSensC:currency;
   SoldeTotalImputation:currency;
   SoldeTotalImputationAuDebit:Boolean;
   TotalDebitMvt:currency;
   TotalCreditMvt:Currency;
   SoldeMvt:currency;
   SoldeMvtAuDebit:Boolean;
   TotalResteCredit:currency;
   TotalResteDebit:currency;
   SoldeReste:currency;
   SoldeResteAuDebit:boolean;
   Equilibre:boolean;
  end;



// TParametreCompte_obj=record
//   Tiers:TInfosTiers;
//   ComptePointable:boolean;
//   ParamCpt:TEnregistrementComplet;
//   Partie:TPartieEnregistrement;
//   Choix:boolean;
//   retour:boolean;
// end;

  TInfoResteDCSurCompte = Record
    NBLignePointee:Integer;
    NBLigneResteAPointer:Integer;
    NBLigneResteAPointerDebit:Integer;
    NBLigneResteAPointerCredit:Integer;
    NBLignePartiellementPointee:integer;
    ComptePointable:Boolean;
    Compte:String;
    MessageCpt:string;
    DataSetResult:TDataSet;
  end;

TInfoResteDCSurEcriture = record
    ResteAPointee:boolean;
    NBLignePointee:Integer;
    NBLigneResteAPointer:Integer;
    Reste:currency;
end;

  TInfosCreationReste=record
    reste:TReste;
    Pointage:TinfosPointageS;
    IDEcriture:integer;
    IDPiece:integer;
    DatePiece:Tdate;
    Reference:string;
    Tiers:string;
    Libelle:string;
    MontantDebit:currency;
    MontantCredit:currency;
  end;

  TCompteAmortissement=record
    compteDotation:string;
    CompteAmort:string;
  end;

  TSuppressionImmos=record
    ImmosASupprimer:Tstringlist;
    CessionsASupprimer:Tstringlist;
    supprimerImmos:boolean;
    supprimerCessions:boolean;
    reference:string;
  end;

    TChangtExo=record
       CheminBase:string;
       NomBase:string;
       ExoBase:string;
       ExoSaisie:string;
       ExoDebut:TDate;
       ExoFin:TDate;
       Cloture:boolean;
       retour:boolean;
       IDDos:integer;
       IDExo:integer;
    end;

   TDernierEtatValide = record
      Valide:boolean;
      Nombre:integer;
      Rang:integer;
      DateDeb:TDate;
      DateFin:TDate;
      DatePiece:TDate;
      RangSuivantACreer:integer;
      CreationSuivantPossible:boolean;
      Valeur_Champ_Gener:string;
      end;

   TInfosEtatVersement = record
      Existe:boolean;
      Rang:integer;
      NumOD:string;
      LibelleOD:string;
      DatePiece:TDate;
      Valeur_Champ_Gener:string;
      end;

   TTotaux= record
    Credit:currency;
    Debit:currency;
    Solde:currency;
    end;

    TTotauxGeneric = record
      Total1 : currency;
      Total2 : currency;
      Total3 : currency;
      Total4 : currency;
      Total5 : currency;
      Total6 : currency;
      Total7 : currency;
      Total8 : currency;
      Total9 : currency;
      Total10 : currency;
    end;

  TTotauxBalance=record
    //Report
    TotalDebitReport:currency;
    TotalCreditReport:currency;
    TotalQt1Report:Real;
    TotalQt2Report:Real;
    SoldeReport:currency;
    SoldeDebitCreditReport:Boolean;
    TotalSoldeDebitReport:currency;
    TotalSoldeCreditReport:currency;
    //Base
    TotalDebitBase:currency;
    TotalCreditBase:currency;
    TotalQt1Base:Real;
    TotalQt2Base:Real;
    SoldeBase:currency;
    SoldeDebitCreditBase:Boolean;
    TotalDebitFin:currency;
    TotalCreditFin:currency;
    //Fin
    SoldeFin:currency;
    SoldeFinQt1:Real;
    SoldeFinQt2:Real;
    SoldeDebitCreditFin:Boolean;
    SoldeQt1DebitCreditFin:Boolean;
    SoldeQt2DebitCreditFin:Boolean;
    TotalSoldeDebitTotal:currency;
    TotalSoldeCreditTotal:currency;
    end;

 TTotauxCompte = record
    TotalDebit:Currency;
    TotalCredit:Currency;
    Solde:Currency;
    SoldeDebit:Currency;
    SoldeCredit:Currency;
    SoldeEnDebit:Boolean;
    end;

 TDetailDate = Record
     Date_:TDate;
     an:word;
     mois:word;
     jour:word;
     DateWord:word;
     AnStr:PChar;
     JourStr:PChar;
     MoisStr:PChar;
     Valide:boolean;
     DateStr:PChar;
     Vide:Boolean;
     end;

//TVarColorGrid= Record
//    LigneContour:TColor;
//    CelActiveContour:TColor;
//    CelActiveColorFond:TColor;
//    CelActiveColorFont:TColor;
//    CelActiveSAisieColorFont:TColor;
//    CelActiveSAisieColorFond:TColor;
//    CelFixeColorFond:TColor;
//    CelFixeColorFont:TColor;
//    GrilleColorFond:TColor;
//    GrilleColorFont:TColor;
//    end;
//

  TParamAffichCompte=record
  //Tous : boolean;
  ListeClasse:array of integer;
  Tiers : boolean;
  Filtrer: boolean;
  Regrouper : integer;
  Dataset:TDataset;
  sautDePage:boolean;
  titreSautDePage:string;
  ListeChamps: TStringList;
  ListeChampsArray: Array of string;
  Titre:string;
  SousTitre:string;
  FiltreNbChiffre:integer;
  TitreChamp:TStringList;
  longueurChamp:TStringList;
  longueurChampArray: Array of integer;
  EventButtonAjouterClick:TNotifyEvent;
  EventButtonSupprimerClick:TNotifyEvent;
  ListeItemAction:TStringlistLGR1;
  retourEntier:boolean;

end;

TValeurConstante = record
   ListeResult:TStringList;
   ListeReference:TStringList;
   end;

TResultStrList = Record
 Liste : TStringList;
 Result : Boolean;
 Regrouper : integer;
 SautDePage:boolean;
 end;

TInfosJournal = record
  ID : integer;
  Code : string;
  Libelle_Model : string;
  Libelle  : string;
  Journal : string;
  Compte :  string;
  Compte_Reglement : string;
  Minimum : Boolean;
  ID_Devise : Integer;
  ID_Journal : integer;
  Qui : String;
  Quand : TDate;
  CODE_BANQUE_GESTCO  : string;
  ResultInfos:boolean;
end;


TParamAffichPointage = record
 Reference:String;
 ID_Reste_Appelant:Integer;
 SensAppelant:string[1];
 ID_Ecriture_Appelant:Integer;
 ID_Piece_Appelant:Integer;
 DateDeb:TDate;
 DateFin:TDate;
 CptTiers:string;
 ALettrer:Boolean;
 Montant_Appelant:currency;
 Reste_Appelant:currency;
 Acces:boolean;
end;

TEtatFiltre = Record
 Filtre:String;
 Filtree:Boolean;
 OnFilterRecord:TFilterRecordEvent;
end;

TListeResteAffect=record
  ID_Ligne_Appelant:integer;
  ID_Reste:integer;
  Lettre:string;
  Validation:boolean;
  Montant:currency;
end;

TEcriture_A_Regler=record
  ID_Ecriture:integer;
  Tiers_:string;
  Montant:currency;
  Sens:integer;
  CompteReglement:string;
  TvaSurE:boolean;
end;

TReglement_Sur_Liste=record
  ID_Reglement:integer;
  Reference:string;
  journal:string;
  IDJournal:integer;
  ListeContrepartie:Tstringlist;
  Tiers:string;
  MontantTotal:currency;
  Sens:integer;
  CompteReglement:string;
  Libelle:string;
  DateReglement:Tdatetime;
end;

TEtatFiche = record
 WindowState:TWindowState;
 Position:TPosition;
 Height:Integer;
 Top:Integer;
 Left:Integer;
 Width:Integer;
end;

  TInfos_Piece=record
    Compte:string;
    Total:TTotaux;
    SensSolde:integer;
    Retour:boolean;
    ID_Piece:Integer;
  end;

  TPeriode = record
   DateDeb:TDate;
   DateFin:TDate;
   Retour:Boolean;
  end;

  TCompte1=record
   CompteDotation:string;
   CompteReprise:string;
  end;

  TParam_InfosComplTva=record
    Compte_A_Traiter:string;
    CodeDefaut:integer;
  end;

  TSolde_A_Traiter=record
    Compte:string;
    Total:TTotauxBalance;
    Code:integer;
    ATraiter:boolean;
    NomPanel:string;
    GestionAffichForm:TGestionAffichForm;
  end;

  TReport=record
    Totaux:TTotauxBalance;
    Retour:boolean;
  end;

  TSolde_A_Declarer=record
    Calcul:Tinfos_piece;
    Declaration:Currency;
    CompteArrondis:string;
    APayer:TInfos_Piece;
    Report:TInfos_Piece;
    Remboursement:TInfos_Piece;
    DeduiteAReverser:TInfos_Piece;
    AcompteVerse:TInfos_Piece;
  end;

  TMontantTva_Valide=record
    retour:boolean;
    MontantTva:currency;
    MontantMini:currency;
    MontantMaxi:currency;
  end;

  TRemboursement=record
    NbRemb:integer;
    NbRembP1:integer;
    NbRembP2:integer;
    NbRembP3:integer;
    Differe:integer;
    TypeRemb:integer;
    Duree_Mois:integer;
    IncDate:integer;
    Retour:boolean;
  end;

  TCalcul=record
    Total:currency;
    SensTotal:integer;
    Retour:boolean;
  end;

  TParamAfficheChoixEditionTVA = record
   ListeCodeTVA : TStringList;
  end;
//  	InfoStr : array [1..InfoNum] of String =

  //rajouter le 29-04-03 par isa
  TTypeImmo=record
    devenirAmortissable:boolean;
    Amortissable:boolean;
    Degressif:boolean;
  end;

 TForceAffichage=record
   Affiche:boolean;
   Force:boolean;
 end;

 TParamEntDiv = record
  ForceReglement:Boolean;
 end;

 TInfoTable = record
   NBRecord:Integer;
   InfosFiltre:TFiltre
 end;

 TParamHistorique= record
   Periode:TPeriode;
   Id_Decl:integer;
 end;

 TDetailTVAAffich= record
   Calculer:integer;
   Periode:TPeriode;
   ListeCodes:Tstringlist;
   SensImposeDeduiteDebitCredit:boolean;
   TypeTvaAffich:integer;
   En_Attente:integer;
   ForceHistorique:boolean;
 end;

 TInfosTiersSaisie = Record
  Tiers:String;
  CodeTiers:String;
  TypeTiers:String;
  Compte:String;
  Retour:Boolean;
 end;

 TInfosBascule=record
   DateDeb:TdateTime;
   DateFin:TdateTime;
   ExoSaisie:string[2];
 end;

 TExceptLGR_ImportPiece = record
   Erreur:TExceptLGR;
   Mess:string;
   Id_Piece:integer;
  end;
 TExceptLGR_ImportPointage = record
   Erreur:TExceptLGR;
   Mess:string;
   Id_PieceDebit:integer;
   Id_PieceCredit:integer;
   Id_EcritureDebit:integer;
   Id_EcritureCredit:integer;
  end;

  TSoldeCompte=record
    SoldeCharge:Tcalcul;
    SoldeBalance:Tcalcul;
    SoldeBO:Tcalcul;
    ListeSolde:Tstringlist;
  end;

  TParamAffichage=Record
   EtatFiche:TEtatFiche;
   GestionAffichForm:TGestionAffichForm;
   Titre:String;
   TitrePetit:String;
   AffichModal:Boolean;
   InfosSup:string;
   EventButtonValiderClick:TNotifyEvent;
   EventButtonDetailClick:TNotifyEvent;
   EventButtonImprimerClick:TNotifyEvent;
   EventListViewDbleClick:TNotifyEvent;
   EventSyntheseClick:TNotifyEvent;
  end;

  TParamEdition=record
   Titre:String;
   TitrePetit:String;
   AffichDefaut:boolean;
  end;


  TEnsembleByte = set of Byte;
  TabString=array of string;
  TabInteger=array of integer;
  TabStringList=array of TStringList;
  TabAlignment=Array of TAlignment;

  TParametreEdition=record
    ParamEdition:TParamEdition;
    TabTitreColonne:array of string;
    LargeurCol:array of integer;
    TabList:array of Tstringlist;
    Alignement:Array of TAlignment;
  end;

  TParamFichier=Record
    NomFichier:string;
    NomFichierBal:String;
    Repertoire:string;
  end;

  TRetourListeErreur=record
    ListErreur:TList;
    NbProcedure:integer;
  end;

  TTotauxRappBanc = Record
   SoldeReportDebit:Currency;
   SoldeReportCredit:Currency;
   SoldeReportReleveBanqueDebit:Currency;
   SoldeReportReleveBanqueCredit:Currency;
   TotalMvtCompteDebit:Currency;
   TotalMvtCompteCredit:Currency;
   SoldeCompteDebit:Currency;
   SoldeCompteCredit:Currency;
   TotalMvtCompteNonMarqueDebit:Currency;
   TotalMvtCompteNonMarqueCredit:Currency;
   SoldeReleveBanqueDebit:Currency;
   SoldeReleveBanqueCredit:Currency;
  end;
//  TEditLien = record        //ensemble des paramètres concernant les lien internes du site
//      lien : boolean;       //si lien=true il y a des liens internes
//      grd_livre_cg,         //nom du fichier xml contenant le grand livre des comptes généraux
//      grd_livre_tiers,      //nom du fichier xml contenant le grand livre des tiers
//      journal_piece:string; //nom du fichier xml contenant le journal des pièces
//  end;

//var
//  TypeVersion:TTypeVersion;





      procedure InitialiseRetourMontantTVA(Var MontantTVA:TRetourMontantTva);
      procedure InitialiseSuppressionImmo(Var SuppressionImmo:TSuppressionImmos);
      procedure InitialiseListeCloture(Var ListeCloture:TerreurCloture);
      procedure InitialiseTotauxGeneric(Var ListeCloture:TTotauxGeneric);
      procedure InitialiseModifObj(Var Modif:TModif_obj);
      procedure InitialiseTotauxBalance(Var TotauxBalance:TTotauxBalance);
      procedure initialise_InfosCreationReste(var InfosCreationReste:TInfosCreationReste);
      procedure initialiseInfosPiece_SurTypeLigne(var InfosPiece_SurTypeLigne:TInfosPiece_SurTypeLigne);
      Procedure Initialise_ResteDCInfoLettrageEnCours(var ResteDCInfoLettrageEnCours : TResteDCInfoLettrageEnCours);
      Procedure Initialise_TInfosJournal(var InfosJournal : TInfosJournal);
      Procedure Initialise_TParamAffichPointage(var ParamAffichPointage:TParamAffichPointage);
      Procedure Remplit_TParamAffichPointage(DataSet:TDataSet;var ParamAffichPointage:TParamAffichPointage);
      Procedure Initialise_TErreurLigne(var ErreurLigne : TErreurLigne);
      procedure Initialise_TReglement_Sur_Liste(var Reglement_Sur_Liste:TReglement_Sur_Liste);
      procedure Initialise_TRecordPiece(var RecordPiece:TRecordPiece);
      procedure Initialise_TRecordEcriture(var RecordEcriture:TRecordEcriture);
      procedure initialise_TInfos_Piece(var infosPiece:TInfos_Piece);
      procedure initialise_TEcriture_A_Regler(var Ecriture_A_Regler:TEcriture_A_Regler);
      procedure initialiserAmortissement(var AmortImmo:TAmortImmo);
      procedure initialiserChoix(var Choix:TChoix);
      procedure initialise_TParamEntDiv(var ParamEntDiv:TParamEntDiv);
      procedure initialise_Tparamhistorique(Var ParamHistorique:TparamHistorique);
      procedure initialise_TDetailTVAAffich(Var DetailTVAAffich:TDetailTVAAffich);
      procedure initialise_TinfosBascule(Var InfosBascule:TInfosBascule);
      procedure initialise_TExceptLGR_ImportPiece(var ExceptLGR_ImportPiece:TExceptLGR_ImportPiece);
      procedure initialise_TSoldeCompte(Var SoldeCompte:TSoldeCompte);
      procedure initialise_TCalcul(Var Calcul:TCalcul);
      procedure Initialise_TParamAffichage(var ParamAffichage:TParamAffichage);
      procedure Initialise_Periode(Var Periode:Tperiode);
      Procedure Initialise_TotauxRappBanc(Var TotauxRappBanc:TTotauxRappBanc);
      Procedure Initialise_TotauxCompte(Var TotauxCompte:TTotauxCompte);
      Procedure Initialise_complementLigne_Obj(var complementLigne_Obj:TcomplementLigne_Obj);
      Procedure Initialise_retourCompteBancaire(var retourCompte : retourCompteBancaire);
//      procedure Initialise_TDistribution(var TypeDistribution:TDistribution);
//      Function numVersion:TNumVersion;
//      Function numVersionComplete:String;
implementation

uses lib_chaine;
//var
//C_Date:string;
//C_Version:string;
//C_messageVersion:string;



procedure InitialiseRetourMontantTVA(Var MontantTVA:TRetourMontantTva);
Begin
MontantTVA.SensCredit:=C_SensSoldeNul;
MontantTVA.SensCreditReel:=C_SensSoldeNul;
MontantTVA.retour:=false;
MontantTVA.RetourMontantMaxi:=0;
MontantTVA.RetourMontantMini:=0;
MontantTVA.retourMontantReel:=0;
MontantTVA.RetourMontantMaxi_extended:=0;
MontantTVA.RetourMontantMini_extended:=0;
MontantTVA.FourchetteModifier:=false;
End;

procedure InitialiseSuppressionImmo(Var SuppressionImmo:TSuppressionImmos);
Begin
Initialise_TStringlist(SuppressionImmo.ImmosASupprimer,nil,false);
Initialise_TStringlist(SuppressionImmo.CessionsASupprimer,nil,false);
SuppressionImmo.reference:='';
SuppressionImmo.supprimerImmos:=false;
SuppressionImmo.supprimerCessions:=false;
End;


procedure InitialiseListeCloture(Var ListeCloture:TerreurCloture);
Begin
ListeCloture.AdresseTraitement:=nil;
ListeCloture.erreur.CodeErreur:=0;
ListeCloture.erreur.retour:=true;
ListeCloture.ListErreur:=nil;
ListeCloture.messages.MessageErreur:='';
ListeCloture.messages.MessageQuestion:='';
ListeCloture.TitreBouton:='';
ListeCloture.TitreListe:='';
ListeCloture.Obligatoire:=false;
End;

procedure InitialiseTotauxGeneric(Var ListeCloture:TTotauxGeneric);
Begin
ListeCloture.Total1:=0;
ListeCloture.Total2:=0;
ListeCloture.Total3:=0;
ListeCloture.Total4:=0;
ListeCloture.Total5:=0;
ListeCloture.Total6:=0;
ListeCloture.Total7:=0;
ListeCloture.Total8:=0;
ListeCloture.Total9:=0;
ListeCloture.Total10:=0;
End;

procedure InitialiseTotauxBalance(Var TotauxBalance:TTotauxBalance);
Begin
//Report
TotauxBalance.TotalDebitReport:=0;
TotauxBalance.TotalCreditReport:=0;

TotauxBalance.SoldeReport:=0;
TotauxBalance.SoldeDebitCreditReport:=false;

TotauxBalance.TotalSoldeDebitReport:=0;
TotauxBalance.TotalSoldeCreditReport:=0;

TotauxBalance.TotalQt1Report:=0;
TotauxBalance.TotalQt2Report:=0;

//Base
TotauxBalance.TotalDebitBase:=0;
TotauxBalance.TotalCreditBase:=0;

TotauxBalance.SoldeBase:=0;
TotauxBalance.SoldeDebitCreditBase:=false;

TotauxBalance.TotalQt1Base:=0;
TotauxBalance.TotalQt2Base:=0;

TotauxBalance.TotalDebitFin:=0;
TotauxBalance.TotalCreditFin:=0;

//Fin
TotauxBalance.SoldeFin:=0;
TotauxBalance.SoldeDebitCreditFin:=false;

TotauxBalance.TotalSoldeDebitTotal:=0;
TotauxBalance.TotalSoldeCreditTotal:=0;

TotauxBalance.SoldeFinQt1:=0;
TotauxBalance.SoldeFinQt2:=0;
TotauxBalance.SoldeQt1DebitCreditFin:=false;
TotauxBalance.SoldeQt2DebitCreditFin:=false;

End;

procedure InitialiseModifObj(Var Modif:TModif_obj);
Begin
Modif.ASupprimer:=false;
Modif.NewRow:=-1;
Modif.SupprAutomatique:=false;
Modif.ModifAutomatique:=false;
End;

procedure initialise_InfosCreationReste(var InfosCreationReste:TInfosCreationReste);
Begin
  InfosCreationReste.reste.ResteInitial:=0;
  InfosCreationReste.reste.Reste:=0;
  InfosCreationReste.reste.SensReste:=false;

  InfosCreationReste.Pointage.Pointee:=false;
  InfosCreationReste.Pointage.NbLignePointee:=0;
  InfosCreationReste.Pointage.Dataset:=nil;
  InfosCreationReste.Pointage.MontantPointage:=0;
  InfosCreationReste.Pointage.Lettre:='';
  InfosCreationReste.Pointage.Ligne:=0;

  InfosCreationReste.IDEcriture:=0;
  InfosCreationReste.IDPiece:=0;
  InfosCreationReste.DatePiece:=0;
  InfosCreationReste.Reference:='';
  InfosCreationReste.Tiers:='';
  InfosCreationReste.Libelle:='';
  InfosCreationReste.MontantDebit:=0;
  InfosCreationReste.MontantCredit:=0;
End;


procedure initialiseInfosPiece_SurTypeLigne(var InfosPiece_SurTypeLigne:TInfosPiece_SurTypeLigne);
Begin
  InfosPiece_SurTypeLigne.Debit:=0;
  InfosPiece_SurTypeLigne.Credit:=0;
  InfosPiece_SurTypeLigne.Solde:=0;
  InfosPiece_SurTypeLigne.SensSoldeCredit:=0;
  InfosPiece_SurTypeLigne.NbLigne:=0;
  InfosPiece_SurTypeLigne.IndexLignes:=nil;
  InfosPiece_SurTypeLigne.montanttva:=0;
  InfosPiece_SurTypeLigne.SenssoldeTva:=0;
End;

Procedure Initialise_ResteDCInfoLettrageEnCours(var ResteDCInfoLettrageEnCours : TResteDCInfoLettrageEnCours);
Begin
ResteDCInfoLettrageEnCours.Equilibre:=false;
ResteDCInfoLettrageEnCours.TotalMontantImputationSensC:=-1;
ResteDCInfoLettrageEnCours.TotalMontantImputationSensD:=-2;
ResteDCInfoLettrageEnCours.SoldeTotalImputation:=0;
ResteDCInfoLettrageEnCours.SoldeTotalImputationAuDebit:=false;
ResteDCInfoLettrageEnCours.TotalDebitMvt:=0;
ResteDCInfoLettrageEnCours.TotalCreditMvt:=0;
ResteDCInfoLettrageEnCours.SoldeMvt:=0;
ResteDCInfoLettrageEnCours.SoldeMvtAuDebit:=false;
ResteDCInfoLettrageEnCours.TotalResteCredit:=0;
ResteDCInfoLettrageEnCours.TotalResteDebit:=0;
ResteDCInfoLettrageEnCours.SoldeReste:=0;
ResteDCInfoLettrageEnCours.SoldeResteAuDebit:=false;
End;

Procedure Initialise_TInfosJournal(var InfosJournal : TInfosJournal);
Begin
  InfosJournal.ID := -1;
  InfosJournal.Code :='';
  InfosJournal.Libelle_Model :='';
  InfosJournal.Libelle  :='';
  InfosJournal.Journal :='';
  InfosJournal.Compte :='';
  InfosJournal.Compte_Reglement :='';
  InfosJournal.Minimum :=false;
  InfosJournal.ID_Devise :=-1;
  InfosJournal.ID_Journal :=-1;
  InfosJournal.Qui :='';
  InfosJournal.Quand :=0;
  InfosJournal.CODE_BANQUE_GESTCO  :='';
  InfosJournal.ResultInfos:=false;
end;

Procedure Initialise_TParamAffichPointage(var ParamAffichPointage:TParamAffichPointage);
Begin
ParamAffichPointage.Reference:='';
ParamAffichPointage.ID_Reste_Appelant:=0;
ParamAffichPointage.ID_Ecriture_Appelant:=0;
ParamAffichPointage.ID_Piece_Appelant:=0;
ParamAffichPointage.DateDeb:=0;
ParamAffichPointage.DateFin:=0;
ParamAffichPointage.CptTiers:='';
ParamAffichPointage.ALettrer:=false;
ParamAffichPointage.SensAppelant:='';
ParamAffichPointage.Montant_Appelant:=0;
ParamAffichPointage.Reste_Appelant:=0;
End;

Procedure Remplit_TParamAffichPointage(DataSet:TDataSet;var ParamAffichPointage:TParamAffichPointage);
Begin
//
End;




Procedure Initialise_TErreurLigne(var ErreurLigne : TErreurLigne);
begin
  ErreurLigne.CodeErreur:=0;
  ErreurLigne.Retour:=true;
  InitialiseModifObj(ErreurLigne.Modif);
  ErreurLigne.CompteConcerne:='';
  ErreurLigne.MessageErreur.MessageErreur:='';
  ErreurLigne.MessageErreur.MessageQuestion:='';
end;

procedure Initialise_TReglement_Sur_Liste(var Reglement_Sur_Liste:TReglement_Sur_Liste);
begin
  Reglement_Sur_Liste.ID_Reglement:=-1;
  Reglement_Sur_Liste.Reference:='0';
  Reglement_Sur_Liste.journal:='';
  Reglement_Sur_Liste.IDJournal:=-1;
  Reglement_Sur_Liste.ListeContrepartie:=TStringList.Create;
  Reglement_Sur_Liste.Tiers:='';
  Reglement_Sur_Liste.MontantTotal:=0;
  Reglement_Sur_Liste.Sens:=-1;
  Reglement_Sur_Liste.CompteReglement:='';
  Reglement_Sur_Liste.Libelle:='';
  Reglement_Sur_Liste.DateReglement:=0;
end;

procedure Initialise_TRecordPiece(var RecordPiece:TRecordPiece);
begin
    RecordPiece.ID:=0;
    RecordPiece.IDJournal:=0;
    RecordPiece.Reference:=C_StrVide;
    RecordPiece.Date:=0;
    RecordPiece.Validation:=0;
    RecordPiece.Libelle:=C_StrVide;
    RecordPiece.Compte:=C_StrVide;
    RecordPiece.Journal:=C_StrVide;
    RecordPiece.AutoGeneree:=false;
    RecordPiece.retour:=false;
    RecordPiece.TotalPiece:=0;
    RecordPiece.Code:=C_StrVide;
    RecordPiece.Echeance:=C_StrVide;
    RecordPiece.Num:=C_StrVide;
    RecordPiece.TypePiece:=C_StrVide;
    RecordPiece.bool:=C_StrVide;
    RecordPiece.Trame:=false;
    RecordPiece.Tiers:=C_StrVide;
    RecordPiece.NomTiers:=C_StrVide;
    RecordPiece.Addresse1:=C_StrVide;
    RecordPiece.Addresse2:=C_StrVide;
    RecordPiece.CodePostal:=C_StrVide;
    RecordPiece.Ville:=C_StrVide;
    RecordPiece.Pays:=C_StrVide;
    RecordPiece.Table_Gen:=C_StrVide;
    RecordPiece.Telephone:=C_StrVide;
    RecordPiece.Champ_Gen:=C_StrVide;
    RecordPiece.Val_Champ_Gen:=C_StrVide;
end;

procedure Initialise_TRecordEcriture(var RecordEcriture:TRecordEcriture);
begin
    RecordEcriture.ID_Piece:=0;
    RecordEcriture.TypeLigne:=C_StrVide;
    RecordEcriture.Compte:=C_StrVide;
    RecordEcriture.CompteTiers:=C_StrVide;
    RecordEcriture.Libelle:=C_StrVide;
    RecordEcriture.Qt1:=0;
    RecordEcriture.Qt2:=0;
    RecordEcriture.MontantHt:=0;
    RecordEcriture.MontantTVA:=0;
    RecordEcriture.CompteTVA:=C_StrVide;
    RecordEcriture.CodeTVA:=C_StrVide;
    RecordEcriture.TauxTVA:=0;
    RecordEcriture.DateTVA:=C_StrVide;
    RecordEcriture.TypeTVA:=C_StrVide;
    RecordEcriture.CptRepartition:=C_StrVide;
    RecordEcriture.LibelleRepartition:=C_StrVide;
    RecordEcriture.TauxRepartition:=0;
    RecordEcriture.NomTiers:=C_StrVide;
    RecordEcriture.Addresse1:=C_StrVide;
    RecordEcriture.Addresse2:=C_StrVide;
    RecordEcriture.CodePostal:=C_StrVide;
    RecordEcriture.Ville:=C_StrVide;
end;

procedure initialise_TInfos_Piece(var infosPiece:TInfos_Piece);
Begin
infosPiece.Retour:=false;
infosPiece.Compte:='';
infosPiece.SensSolde:=0;
infosPiece.Total.Debit:=0;
infosPiece.Total.Credit:=0;
infosPiece.Total.Solde:=0;
End;


procedure initialise_TEcriture_A_Regler(var Ecriture_A_Regler:TEcriture_A_Regler);
begin
  Ecriture_A_Regler.ID_Ecriture:=-1;
  Ecriture_A_Regler.Tiers_:='';
  Ecriture_A_Regler.Montant:=0;
  Ecriture_A_Regler.Sens:=0;
  Ecriture_A_Regler.CompteReglement:='';
  Ecriture_A_Regler.TvaSurE:=false;
end;
procedure initialiserAmortissement(var AmortImmo:TAmortImmo);
Begin
    AmortImmo.compte:='';
    AmortImmo.TypeAmort:='';
    AmortImmo.Mini:=0;
    AmortImmo.Maxi:=0;
    AmortImmo.Choix:=0;
    AmortImmo.Derog:=0;
    AmortImmo.EcoTheorique:=0;
    AmortImmo.EcoObligatoire:=0;
    AmortImmo.EcoRepartition:=0;
    AmortImmo.Report_Derog:=0;
    AmortImmo.Report_Eco:=0;
    AmortImmo.MiniAnnee:=0;
    AmortImmo.VNC:=0;
    AmortImmo.Report:=0;
    AmortImmo.Gerer_Derog:=false;
End;

procedure initialiserChoix(var Choix:TChoix);
Begin
    Choix.Complementchoix:=0;
    Choix.choixDefaut:=0;
    Choix.ChoixItem:=-1;
    Choix.Tag:=-1;
  end;

procedure initialise_TParamEntDiv(var ParamEntDiv:TParamEntDiv);
Begin
ParamEntDiv.ForceReglement:=true;
End;

procedure initialise_Tparamhistorique(Var ParamHistorique:TparamHistorique);
Begin
ParamHistorique.Periode.DateDeb:=0;
ParamHistorique.Periode.DateFin:=0;
ParamHistorique.Id_Decl:=0;
ParamHistorique.Periode.Retour:=true;
End;


procedure initialise_TDetailTVAAffich(Var DetailTVAAffich:TDetailTVAAffich);
Begin
DetailTVAAffich.Calculer:=-1;
DetailTVAAffich.Periode.DateDeb:=0;
DetailTVAAffich.Periode.DateFin:=0;
DetailTVAAffich.Periode.Retour:=true;
DetailTVAAffich.ListeCodes:=Tstringlist.Create;
DetailTVAAffich.TypeTvaAffich:=-1;
DetailTVAAffich.ForceHistorique:=false;
DetailTVAAffich.En_Attente:=-1;
DetailTVAAffich.SensImposeDeduiteDebitCredit:=false;
End;

procedure initialise_TinfosBascule(Var InfosBascule:TInfosBascule);
begin
InfosBascule.DateDeb:=0;
InfosBascule.DateFin:=0;
InfosBascule.ExoSaisie:='';
end;

procedure initialise_TExceptLGR_ImportPiece(var ExceptLGR_ImportPiece:TExceptLGR_ImportPiece);
begin
ExceptLGR_ImportPiece.Erreur.retour:=true;
ExceptLGR_ImportPiece.Erreur.NumErreur:=0;
ExceptLGR_ImportPiece.Mess:='';
ExceptLGR_ImportPiece.Id_Piece:=-1;
end;


procedure initialise_TSoldeCompte(Var SoldeCompte:TSoldeCompte);
Begin
initialise_TCalcul(SoldeCompte.SoldeCharge);
initialise_TCalcul(SoldeCompte.SoldeBalance);
initialise_TCalcul(SoldeCompte.SoldeBO);
SoldeCompte.ListeSolde:=nil;
end;

procedure initialise_TCalcul(Var Calcul:TCalcul);
begin
Calcul.Total:=0;
Calcul.SensTotal:=0;
Calcul.Retour:=false;
end;


procedure Initialise_TParamAffichage(var ParamAffichage:TParamAffichage);
begin
ParamAffichage.EtatFiche.WindowState:=wsNormal;
ParamAffichage.EtatFiche.Position:=poOwnerFormCenter;
ParamAffichage.EtatFiche.Height:=0;
ParamAffichage.EtatFiche.Top:=0;
ParamAffichage.EtatFiche.Left:=0;
ParamAffichage.EtatFiche.Width:=0;

ParamAffichage.GestionAffichForm.Affich:=true;
ParamAffichage.GestionAffichForm.Caption:='';
ParamAffichage.Titre:='';
ParamAffichage.TitrePetit:='';
ParamAffichage.InfosSup:='';
ParamAffichage.AffichModal:=false;
ParamAffichage.EventButtonValiderClick:=nil;
ParamAffichage.EventButtonDetailClick:=nil;
ParamAffichage.EventListViewDbleClick:=nil;
ParamAffichage.EventButtonImprimerClick:=nil;
ParamAffichage.EventSyntheseClick:=nil;
end;


procedure Initialise_Periode(Var Periode:Tperiode);
begin
Periode.DateDeb:=0;
Periode.DateFin:=0;
Periode.Retour:=false;
end;

Procedure Initialise_TotauxRappBanc(Var TotauxRappBanc:TTotauxRappBanc);
Begin
   TotauxRappBanc.SoldeReportDebit:=0;
   TotauxRappBanc.SoldeReportCredit:=0;
   TotauxRappBanc.SoldeReportReleveBanqueDebit:=0;
   TotauxRappBanc.SoldeReportReleveBanqueCredit:=0;
   TotauxRappBanc.TotalMvtCompteDebit:=0;
   TotauxRappBanc.TotalMvtCompteCredit:=0;
   TotauxRappBanc.SoldeCompteDebit:=0;
   TotauxRappBanc.SoldeCompteCredit:=0;
   TotauxRappBanc.TotalMvtCompteNonMarqueDebit:=0;
   TotauxRappBanc.TotalMvtCompteNonMarqueCredit:=0;
   TotauxRappBanc.SoldeReleveBanqueDebit:=0;
   TotauxRappBanc.SoldeReleveBanqueCredit:=0;
End;

Procedure Initialise_TotauxCompte(Var TotauxCompte:TTotauxCompte);
Begin
   TotauxCompte.TotalDebit:=0;
   TotauxCompte.TotalCredit:=0;
   TotauxCompte.Solde:=0;
   TotauxCompte.SoldeDebit:=0;
   TotauxCompte.SoldeCredit:=0;
   TotauxCompte.SoldeEnDebit:=false;
End;

Procedure Initialise_complementLigne_Obj(var complementLigne_Obj:TcomplementLigne_Obj);
begin
   complementLigne_Obj.CodeTvaCompl:='';
   complementLigne_Obj.TvaType:='';
   complementLigne_Obj.TvaDate:='';
   complementLigne_Obj.TvaTaux:=0;
   complementLigne_Obj.MontantTva:=0;
   complementLigne_Obj.rempli:=false;
   complementLigne_Obj.ModifUtilisateur:=false;
end;

//procedure Initialise_TDistribution(var TypeDistribution:TDistribution);
//begin
//     TypeDistribution.TypeVersion:=V_Inconnu;
//     TypeDistribution.TypeClient:=CL_Inconnu;
//     TypeDistribution.TypeDossier:=VerInconnu;
//     TypeDistribution.TypeUtilisateur:=U_Inconnu;
//end;


//  Function numVersion:PNumVersion;
//  var
//  retour:string;
//  begin
//      retour:=RenvoieNumVersion();
//      if(C_Version='')then
//      begin
//        result:=RenvoieNumVersion;
//        C_Version:=result.Version;
//        C_Date:=result.DateVersion;
//        C_messageVersion:=result.messageVersion;
//      end;
//      result.Version:=C_Version;
//      result.DateVersion:=C_Date;
//      result.messageVersion:=C_messageVersion;
//  end;

Procedure Initialise_retourCompteBancaire(var retourCompte : retourCompteBancaire);
Begin
  retourCompte.site:='';
  retourCompte.compte:='';
  retourCompte.journal:='';
  retourCompte.login:='';
  retourCompte.password:='';
  retourCompte.retour:=false;
  retourCompte.Arecupere:=false;
end;
end.
