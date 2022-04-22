{$DEFINE Diocese}
program Epicea2;

//
//{$R *.RES}




{%ToDo 'Epicea2.todo'}

uses
  FixBDE4GbBug,
  Forms,
  FileUtil,
  commctrl,
  windows,
  dialogs,
  registry,
  sysutils,
  DbTables,
  E2_Logo in 'E2_Logo.pas' {Logo},
  E2_Main in 'E2_Main.pas' {Main},
  Gr_Calculatrice in 'Gr_Calculatrice.pas' {Calculatrice},
  E2_AideCompte in 'E2_AideCompte.pas' {AideCompte},
  Gr_AideDate in 'Gr_AideDate.pas' {AideDate},
  DMImmos in 'DMImmos.pas' {DataModuleImmos: TDataModule},
  E2_ListeAcquis in 'E2_ListeAcquis.pas' {ListeAcquis},
  E2_DetailAcquis in 'E2_DetailAcquis.pas' {DetailAcquis},
  E2_Rebut in 'E2_Rebut.pas' {Rebut},
  E2_Division in 'E2_Division.pas' {Division},
  E2_Amo3Ans in 'E2_Amo3Ans.pas' {Amort5Ans},
  E2_PlusMoinsValues in 'E2_PlusMoinsValues.pas' {PlusMoinsValues},
  E2_AideModel in 'E2_AideModel.pas' {AideModel},
  GestRes in 'GestRes.pas',
  E2_ParamEnt in 'E2_ParamEnt.pas' {ParamEnt},
  DMAide in 'DMAide.pas' {DMAides: TDataModule},
  E2_TabVisuPiece2 in 'E2_TabVisuPiece2.pas' {TabVisuPiece2},
  Gr_MultDos in 'Gr_MultDos.pas',
  E2_AideAssist in 'E2_AideAssist.pas' {AideAssist},
  E2_Tiers in 'E2_Tiers.pas' {Tiers},
  E2_GenerCpt_PM in 'E2_GenerCpt_PM.pas' {GenerCpt_PM},
  E2_BilanOuverture in 'E2_BilanOuverture.pas' {BilanOuverture},
  E2_BalanceTiers in 'E2_BalanceTiers.pas' {BalanceTiers},
  E2_CreatDos in 'E2_CreatDos.pas' {CreatDos},
  E2_ParamProg in 'E2_ParamProg.pas' {ParamProg},
  InfoCreat in 'InfoCreat.pas' {InfoCre},
  E2_AutreDossier in 'E2_AutreDossier.pas' {AutreDossier},
  E2_FinCreat in 'E2_FinCreat.pas' {FinCreat},
  E2_DosProtect in 'E2_DosProtect.pas' {DosProtect},
  E2_OKCreatExoDlg in 'E2_OKCreatExoDlg.pas' {OKCreatExoDlg},
  E2_DepensesEntreprise in 'E2_DepensesEntreprise.pas' {DepensesEntreprise},
  E2_PlanOrg in 'E2_PlanOrg.pas' {PlanCptbase},
  E2_DetailEcr in 'E2_DetailEcr.pas' {DetailEcr},
  DMEcriture in 'DMEcriture.pas' {DMEcritures: TDataModule},
  DMPiece in 'DMPiece.pas' {DMPieces: TDataModule},
  E2_SuprCptGen in 'E2_SuprCptGen.pas' {SuprCptGen},
  DMBalances in 'DMBalances.pas' {DMBalance: TDataModule},
  DMProvision in 'DMProvision.pas' {DMProvisions: TDataModule},
  DMTier in 'DMTier.pas' {DMTiers: TDataModule},
  DMProgramme in 'DMProgramme.pas' {DMProg: TDataModule},
  DMBaseDonnee in 'DMBaseDonnee.pas' {DMBD: TDataModule},
  E2_ChargesCA_Isa in 'E2_ChargesCA_Isa.pas' {ChargeCA_Isa},
  E2_ALire in 'E2_ALire.pas' {ALire},
  ModuleTrame in 'ModuleTrame.pas' {DMTrame: TDataModule},
  UQReport in 'UQReport.pas' {FPrint},
  UEtatTrame in 'UEtatTrame.pas' {FEtatTrame},
  DMDepenses in 'DMDepenses.pas' {DMDepenseEnt: TDataModule},
  DMStocks in 'DMStocks.pas' {DMStock: TDataModule},
  E2_Stocks_Isa in 'E2_Stocks_Isa.pas' {Stocks},
  E2_ChargeRepartir_Isa in 'E2_ChargeRepartir_Isa.pas' {ChargeARepartir_Isa},
  E2_ChargesAPayer_Isa in 'E2_ChargesAPayer_Isa.pas' {ChargesAPayer_Isa},
  E2_Emprunts_Isa2 in 'E2_Emprunts_Isa2.pas' {Emprunt_Isa},
  DMEmprunt in 'DMEmprunt.pas' {DMEmprunts: TDataModule},
  E2_Provisions_Isa in 'E2_Provisions_Isa.pas' {Provisions_Isa},
  E2_RepriseChargesCA in 'E2_RepriseChargesCA.pas' {RepriseChargeCA},
  E2_RepriseChargeAPayer_Isa in 'E2_RepriseChargeAPayer_Isa.pas' {RepriseChargeAPayer_Isa},
  E2_Recherche in 'E2_Recherche.pas' {Recherche},
  DMTVA in 'DMTVA.pas' {DMTVACode: TDataModule},
  DMChargesRepartir in 'DMChargesRepartir.pas' {DMChargeRepartir: TDataModule},
  E2_GesPlanCpt_PM in 'E2_GesPlanCpt_PM.pas' {PlanCpt_PM},
  DMChargesCA in 'DMChargesCA.pas' {DMChargeCA: TDataModule},
  DMChargesAPayer in 'DMChargesAPayer.pas' {DMChargeAPayer: TDataModule},
  DMJournaux in 'DMJournaux.pas' {DMJournal: TDataModule},
  DMPlanCpt in 'DMPlanCpt.pas' {DMPlan: TDataModule},
  Lib1 in '..\..\..\LibrairieDev\Delphi\ObjetsPers\Lib1.pas',
  LibProtect in '..\..\..\LibrairieDev\Delphi\LibLGR\Protection\LibProtect.pas',
  Gr_Librairie_Obj in '..\..\..\LibrairieDev\Delphi\LibLGR\Gr_Librairie_Obj.pas',
  LibSQL in '..\..\..\LibrairieDev\Delphi\LibEpi\LibSQL.pas',
  E2_BalanceNewT in 'E2_BalanceNewT.pas' {BalanceNewT},
  E2_Proprietes in 'E2_Proprietes.pas' {PgProperty},
  E2_CreationJournal in 'E2_CreationJournal.pas' {CreationJournal},
  E2_GestVisu in 'E2_GestVisu.pas' {GestVisu},
  E2_TtmntTVA in 'E2_TtmntTVA.pas' {TtmntTVA},
  E2_SaisieReglement in 'E2_SaisieReglement.pas' {SaisieReglements},
  E2_AideTva in 'E2_AideTva.pas' {AideTva},
  E2_CompLigne in 'E2_CompLigne.pas' {SaisieComplementLigne},
  DMClotures in 'DMClotures.pas' {DMCloture: TDataModule},
  DMParamEnt in 'DMParamEnt.pas' {DMParamEntreprise: TDataModule},
  E2_RepartitionResult in 'E2_RepartitionResult.pas' {RepartitionResult},
  AideMontant2 in 'AideMontant2.pas' {AideMontantTTC2},
  LibDates in '..\..\..\LibrairieDev\Delphi\LibEpi\LibDates.pas',
  DMDevises in 'DMDevises.pas' {DMDevise: TDataModule},
  E2_VisuImmo in 'E2_VisuImmo.pas' {VisuImmo},
  DMImmo_Clot in 'DMImmo_Clot.pas' {DMImmo_Clo: TDataModule},
  E2_SelectionLigne in 'E2_SelectionLigne.pas' {SelectionLigne},
  E2_TranfertSolde in 'E2_TranfertSolde.pas' {TranfertSolde},
  E2_SaisieP_3 in 'E2_SaisieP_3.pas' {saisieP_3},
  E2_Decl_Records in '..\..\..\LibrairieDev\Delphi\LibLGR\E2_Decl_Records.pas',
  LibFichRep in '..\..\..\LibrairieDev\Delphi\ObjetsPers\LibFichRep.pas',
  E2_RepriseChargeAPayer2_Isa in 'E2_RepriseChargeAPayer2_Isa.pas' {RepriseChargeAPayer2_Isa},
  E2_Immo_Ouverture in 'E2_Immo_Ouverture.pas' {Immo_Ouverture},
  DMImmosOuverture in 'DMImmosOuverture.pas' {DMImmos_Ouverture: TDataModule},
  ImportDll in '..\..\..\LibrairieDev\Delphi\DLL\ImportDll.pas',
  DMDiocEtatVersements in 'DMDiocEtatVersements.pas' {DMDiocEtatVersement: TDataModule},
  E2_EtatGestAnal in 'E2_EtatGestAnal.pas' {EtatGestAnal},
  DMDiocEtatGestionAnalytique in 'DMDiocEtatGestionAnalytique.pas' {DMDiocEtatGestionAnal: TDataModule},
  E2_EtatVerse in 'E2_EtatVerse.pas' {EtatVerse},
  UEtatVerse in 'UEtatVerse.pas' {FEtatVers: TQuickRep},
  UEtatGestAnal in 'UEtatGestAnal.pas' {FEtatGestAnal: TQuickRep},
  DMDiocEtatBalanceT in 'DMDiocEtatBalanceT.pas' {DMDiocEtatBalT: TDataModule},
  DMImportation in 'DMImportation.pas' {DMImport: TDataModule},
  lib_chaine in '..\..\..\LibrairieDev\Delphi\LibEpi\Lib_Chaine.pas',
  E2_CptImmos in 'E2_CptImmos.pas' {CptImmos},
  E2_ChoixAmortissement in 'E2_ChoixAmortissement.pas' {ChoixAmortissement},
  E2_ImmoEnCours in 'E2_ImmoEnCours.pas' {ImmoEnCours},
  LibConvertisseur in '..\..\..\LibrairieDev\Delphi\LibEpi\LibConvertisseur.pas' {Convertisseur},
  LibCouleurLab in '..\..\..\LibrairieDev\Delphi\LibEpi\LibCouleurLab.pas' {LibCouleur},
  CreationExo in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationExo.PAS',
  CreationDossier in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationDossier.PAS',
  CreationTrameLDioc in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationTrameLDioc.PAS',
  DMTTVA in 'DMTTVA.pas' {DMTmTVA: TDataModule},
  E2_TauxAmortissement in 'E2_TauxAmortissement.pas' {TauxAmortissement},
  E2_ParamParoisse in 'E2_ParamParoisse.pas' {ParamParoisse},
  E2_Cloture_Def in 'E2_Cloture_Def.pas' {Cloture_Def},
  CreationCodeTVAAgri in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationCodeTVAAgri.PAS',
  E2_InfosTrame in 'E2_InfosTrame.pas' {InfosTrame},
  CreationModel in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationModel.PAS',
  E2_CessionsImmo in 'E2_CessionsImmo.pas' {CessionsImmo},
  E2_BalanceNew in 'E2_BalanceNew.pas' {BalanceNew},
  DMDiocEtatBalance in 'DMDiocEtatBalance.pas' {DMDiocEtatBal: TDataModule},
  E2_DetailPointage in 'E2_DetailPointage.pas' {DetailPointage},
  DMPointages2 in 'DMPointages2.pas' {DMPointage2: TDataModule},
  E2_Pointages2 in 'E2_Pointages2.pas' {Pointages2},
  DMInitTablesEpi in 'DMInitTablesEpi.pas' {DMInitTableEpi: TDataModule},
  E2_InitTableEpi in 'E2_InitTableEpi.pas' {InitTableEpi},
  CreationPlanAgriCOGERE in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationPlanAgriCOGERE.PAS',
  E2_AffectReglement in 'E2_AffectReglement.pas' {AffectReglement},
  E2_ReglementSurListe in 'E2_ReglementSurListe.pas' {ReglementSurListe},
  LibClassObjetSenders in '..\..\..\LibrairieDev\Delphi\LibEpi\LibClassObjetSenders.pas' {LibClassObjetSender: TDataModule},
  E2_RechercheBD in 'E2_RechercheBD.pas' {RechercheBD},
  DMConstantes in 'DMConstantes.pas' {DMConst: TDataModule},
  E2_VisuPointage in 'E2_VisuPointage.pas' {VisuPointage},
  Lib_Genere_LibInfosTable in '..\..\..\LibrairieDev\Delphi\LibEpi\Lib_Genere_LibInfosTable.pas',
  E2_LibInfosTable in 'E2_LibInfosTable.pas',
  DMRecherche in 'DMRecherche.pas' {DMRech: TDataModule},
  E2_Patientez in 'E2_Patientez.pas' {Patientez},
  CreationPlanDioc in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationPlanDioc.PAS',
  CreationTrameDioc in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationTrameDioc.PAS',
  E2_ReglementSurListe2 in 'E2_ReglementSurListe2.pas' {ReglementSurListe2},
  E2_ChoixReglementAuto in 'E2_ChoixReglementAuto.pas' {ChoixReglementAuto},
  ChoixPeriode in '..\..\..\LibrairieDev\Delphi\LibEpi\ChoixPeriode.pas' {Choix_Periode},
  E2_GestionAnalytique in 'E2_GestionAnalytique.pas' {GestionAnalytique},
  UEtatGestionAnal in 'UEtatGestionAnal.pas' {FEtatGestionAnal: TQuickRep},
  DMLiasseFiscale in 'DMLiasseFiscale.pas' {DMLiasseFisc: TDataModule},
  UBilanPassif in 'UBilanPassif.pas' {FBilanPassif: TQuickRep},
  E2_EditionOuverture_Bic in 'E2_EditionOuverture_Bic.pas' {EditionOuverture_Bic},
  E2_Graphes in 'E2_Graphes.pas' {Graphes},
  CreationModelAgri in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationModelAgri.PAS',
  Epicea2_TLB in 'Epicea2_TLB.pas',
  Librairie_Isa in 'Librairie_Isa.pas',
  LibImport in '..\..\..\LibrairieDev\Delphi\LibEpi\LibImportEPI\LibImport.pas',
  LibZoneSaisie in '..\..\..\LibrairieDev\Delphi\ObjetsPers\LibZoneSaisie.pas',
  referencement in '..\..\..\LibrairieDev\Delphi\LibEpi\referencement.pas',
  E2_Infos_Tva_Complementaires in 'E2_Infos_Tva_Complementaires.pas' {Infos_Tva_Complementaire},
  E2_Infos_Tva_Complementaires_ApresCalcul in 'E2_Infos_Tva_Complementaires_ApresCalcul.pas' {Infos_Tva_Complementaires_ApresCalcul},
  DMGestVisus in 'DMGestVisus.pas' {DMGestVisu: TDataModule},
  E2_DescEmp in 'E2_DescEmp.pas' {DescEmp},
  E2_EcheEmprunt in 'E2_EcheEmprunt.pas' {EcheEmprunt},
  DMAnalytique in 'DMAnalytique.pas' {DMAnalytiques: TDataModule},
  E2_SyntheseTVA in 'E2_SyntheseTVA.pas' {SyntheseTVA},
  E2_RapprochementBancaire in 'E2_RapprochementBancaire.pas' {RappBanc},
  DMRapprochementBancaire in 'DMRapprochementBancaire.pas' {DMRappBanc: TDataModule},
  E2_ConfirmImport in 'E2_ConfirmImport.pas' {ConfirmImport},
  E2_Test1 in 'E2_Test1.pas' {Test1},
  DMXMLs in 'DMXMLs.pas' {DMXml: TDataModule},
  LibGestionParamXML in '..\..\..\LibrairieDev\Delphi\LibEpi\LibGestionParamXML.pas',
  E2_GestionSauvegarde in 'E2_GestionSauvegarde.pas' {GestionSauvegarde},
  FRAssistant1 in '..\..\..\LibrairieDev\Delphi\LibLGR\Frame\FRAssistant1.pas' {FRAssistant: TFrame},
  DMConstAnalytique in 'DMConstAnalytique.pas' {DMConstAnal: TDataModule},
  DMExports in 'DMExports.pas' {DMExport: TDataModule},
  CreationConstAnalCOGERE in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationConstAnalCOGERE.PAS',
  CreationPlanAGri in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationPlanAgri.PAS',
  CreationPlanIndus in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationPlanIndus.PAS',
  AffectImmoCptCOGERE in 'AffectImmoCptCOGERE.pas' {AffectImmosCptCOGERE},
  PrintDrv in '..\..\..\LibrairieDev\Delphi\LibLGR\Edition\PrintDrv.pas',
  E2_Librairie_Obj in 'E2_Librairie_Obj.pas',
  LibSaisieIP in '..\..\..\LibrairieDev\Delphi\LibLGR\LibSaisieIP.pas' {SaisieIP},
  E2_ConfirmImportCOGERE in 'E2_ConfirmImportCOGERE.pas' {ConfirmImportCOGERE},
  E2_VisuAPropos in 'E2_VisuAPropos.pas' {VisuAPropos},
  E2_GestSauvegarde in 'E2_GestSauvegarde.pas' {GestSauvegarde},
  LibChoixRep in '..\..\..\LibrairieDev\Delphi\LibLGR\LibChoixRep.pas' {ChoixRep},
  FrPasBtn_Tous in '..\..\..\LibrairieDev\Delphi\LibLGR\Frame\FrPasBtn_Tous.pas' {Frame2: TFrame},
  FrameForm_Complete in '..\..\..\LibrairieDev\Delphi\LibLGR\Frame\FrameForm_Complete.pas' {Frame3: TFrame},
  FM_INIT_COLOR in '..\..\..\LibrairieDev\Delphi\LibLGR\ModeleLGR\FM_INIT_COLOR.pas' {T_INIT_COLOR},
  FM_INIT_EVENT_AFFICH in '..\..\..\LibrairieDev\Delphi\LibLGR\ModeleLGR\FM_INIT_EVENT_AFFICH.pas' {T_INIT_EVENT_AFFICH},
  DMCorrection in 'DMCorrection.pas' {DMcorrections: TDataModule},
  UniteCorrection in 'UniteCorrection.pas' {UniteCorrections},
  ObjetEdition in '..\..\..\LibrairieDev\Delphi\liblgr\edition\ObjetEdition.pas',
  ScruteFichiers in '..\..\..\LibrairieDev\Delphi\LibEpi\ScruteFichiers.pas',
  CalculResultat in 'CalculResultat.pas' {Calcul_Resultat},
  ReindexationTable in 'ReindexationTable.pas' {ReindexationTables},
  DMRepartition in 'DMRepartition.pas' {DMRepart: TDataModule},
  DMRecherche_Obj in 'DMRecherche_Obj.pas' {DMRech_Obj: TDataModule},
  CreationProgramme in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationProgramme.pas',
  E2_AvertissementSuppressionDossier in 'E2_AvertissementSuppressionDossier.pas' {AvertissementSuppressionDossier},
  E2_EditionBilanOuverture in 'E2_EditionBilanOuverture.pas' {EditionOuverture},
  E2_ModifEcriture in 'E2_ModifEcriture.pas' {ModifEcriture},
  DMModifEcritures in 'DMModifEcritures.pas' {DMModifEcriture: TDataModule},
  E2_VisuListeView in 'E2_VisuListeView.pas' {VisuListeView},
  E2_EditionFin in 'E2_EditionFin.pas' {EditionFin},
  E2_EditionFin_Bic in 'E2_EditionFin_Bic.pas' {EditionFin_Bic},
  E2_RegulTva in 'E2_RegulTva.pas' {RegulTVA},
  AD_LIBRAIRIES in '..\..\..\LibrairieDev\Delphi\liblgr\LibLibLGR\AD_LIBRAIRIES.pas',
  E2_VisuListe in 'E2_VisuListe.pas' {VisuListe},
  DMMessagesLGR in 'DMMessagesLGR.pas' {DMMessageLGR: TDataModule},
  LibChoixCompte in 'LibChoixCompte.pas' {LibChoixComptes},
  InputQueryFrm_F in 'InputQueryFrm_F.pas' {Form1},
  Utilisation_deduction in 'Utilisation_deduction.pas' {Utilisation_Deductions},
  RequeteSql in 'RequeteSql.pas' {EditeurRequeteSql},
  MessageLgr in 'MessageLgr.pas' {MessagesLgr},
  Unit76 in 'Unit76.pas' {regeneration},
  WinShellFolder in 'WinShellFolder.pas',
  Deduction in 'Deduction.pas' {Deductions},
  DMDeductions in 'DMDeductions.pas' {DMDeduction: TDataModule},
  BdeInit in 'BdeInit.pas' {BdeInit},
  AnalyseGraphique in 'AnalyseGraphique.pas' {Analyses},
  ImportReleve in 'ImportReleve.pas' {ImportationReleve},
  RapprochementReleve in 'RapprochementReleve.pas' {RapprochementReleves},
  DmImportReleves in 'DmImportReleves.pas' {DMImportReleve: TDataModule},
  ComptesBancaires in 'ComptesBancaires.pas' {E2_ComptesBancaires},
  TStringlistLGR in 'TStringlistLGR.pas',
  DiversProjets in '..\..\..\LibrairieDev\Delphi\LibEpi\DiversProjets.pas',
  DmGestionVersions in 'DmGestionVersions.pas' {DMGestVersion: TDataModule},
  CreationReglementReleve in 'CreationReglementReleve.pas' {CreationReglementReleves},
  BalancesComparatives in 'BalancesComparatives.pas' {BalanceComparative},
  LibRessourceString in '..\..\..\LibrairieDev\Delphi\LibEpi\LibRessourceString.pas',
  R2_ListeFic in 'R2_ListeFic.pas' {ListeVLE},
  RestD3 in 'RestD3.pas' {Rest},
  juridique in 'juridique.pas' {InfosJuridiques},
  CreationPlanAsso in '..\..\..\LibrairieDev\Delphi\LibEpi\CreationPlanAsso.PAS',
  ShellCtrls in '..\..\..\Program Files (x86)\Borland\Delphi7\Demos\ShellControls\ShellCtrls.pas',
  DmTableauBord in 'DmTableauBord.pas' {DmTableauDeBord: TDataModule},
  DatasetVersXml in 'DatasetVersXml.pas',
  LibChoixCompteCoche in 'LibChoixCompteCoche.pas' {LibChoixComptesCoche},
  E2_ChangementTva in 'E2_ChangementTva.pas' {E2_ChangementcodeTva},
  ListeEditions in 'ListeEditions.pas' {E2_ListeEdition},
  E2_ChangementTauxTva in 'E2_ChangementTauxTva.pas' {E2_ChangementtauxDeTva},
  ListeModules in 'ListeModules.pas',
  iAutorisationsEpicea in 'iAutorisationsEpicea.pas',
  ImportReleveEbics in 'ImportReleveEbics.pas' {ImportationReleveEbics},
  rbeSoap in 'rbeSoap.pas',
  TaAutorisationsService1 in 'TaAutorisationsService1.pas',
  ITableauDeBord2 in 'ITableauDeBord2.pas',
  ChoixParametresFEC in 'ChoixParametresFEC.pas' {U_ChoixParametreFEC},
  AfficheWeb in 'AfficheWeb.pas' {AffichageWeb};

var
 ParamEnLigne:TParamEnLigne;
 sDirEXE: string;
 Registre:TRegistry;


{$R *.TLB}

{$R *.RES}

begin

  sDirEXE := ExtractFileDir(Application.ExeName);
  Session.NetFiledir:=sDirEXE;

  BDE_ReInitLocalShare; //enlev� le 29/06/2014 pour pouvoir ouvrir plusieurs instances d'�pic�a
  Session.SaveConfigFile ;

//if  (LocalShareIsTrue ) then  showmessage('le param�tre "Local Share" est � True !!!');

  DecimalSeparator:='.';
  ThousandSeparator:=#32;
//
  Session.NetFiledir:=sDirEXE;
Session.PrivateDir:=GetTempDir; //enlev� le 29/06/2014 pour pouvoir ouvrir plusieurs instances d'�pic�a



  ForceDirectories(ExtractFilePath(Application.ExeName)+ 'ComptaWeb');
  Application.CreateForm(TDMXml, DMXml);
  Application.CreateForm(TDMMessageLGR, DMMessageLGR);
  //  Application.CreateForm(TMain, Main);
  DMXml.GenereConfigUtil(ExtractFilePath(Application.ExeName)+ 'ComptaWeb\');




   try
  SetLastError(NO_ERROR);
  CreateMutex (nil, False, 'MonMutexProject1');
  //if GetLastError<>ERROR_ALREADY_EXISTS then
  begin
  Logo:= TLogo.Create(Application);
  Logo.Tag:=0;
  Logo.Show;
  Logo.Update;

  Application.Title := 'Epic�a-2 - Logiciel de comptabilit� -';

  Application.CreateForm(TDMBD, DMBD);
  ParamEnLigne:=ParamEnLigneLec(1);

     if ParamEnLigne.Retour then
      begin

      CorrectionMultiDossier(nil,false);

     //  showmessage('ParamEnLigne.FichierEnParametre :'+ParamEnLigne.FichierEnParametre);
       LitGestDossierFichier(ParamEnLigne.FichierEnParametre,E,True);

       OuvreExercice(E.NomDossier,E.NomExo,nil,true,false);

       Application.CreateForm(TMain, Main);
      end
     else
      begin
       if DosProtectAffiche(E.User) then
          begin
              try
              CorrectionMultiDossier(nil,false);
                if ((Type_version_execution<>CT_DEVELOPPEMENT) and (E.ControleDuDossier)and (E.ControleDuDossierEntrant)and(E.ID_Dos<>0)) then
                 begin
                      if DateDsIntervale(strtodate('15/12/2006'),StrToDate_Lgr(GetStringElement(E.DateVersion,1,'-'),0),now)then

                      E.DateVersion:=numVersion.DateVersion+'-'+numVersion.Version;
//                         E.DateVersion:=C_Date+'-'+C_Version;

                      if (E.DateVersion<>numVersion.DateVersion+'-'+numVersion.Version)then
                        Begin
                          try//finally
                              try //except
//                               //showmessage('Version : '+E.DateVersion);
//              //                 PatienterAffich(true);
//                 // showmessage('Correction du dossier, Veuillez patientez s''il vous plait');
//                               if CorrectionTotal(logo.Gauge1,false).retour=false then
//                                   raise ExceptLGR.Create('',0,false,mtError);
//                              E.DateVersion:=numVersion.DateVersion+'-'+numVersion.Version;
                              except
                                  //MessageDlg('Le contr�le du dossier ne s''est pas d�roul� correctement Erreur N� :'+inttostr(RetourCorrectionDossier.NumErreur) , mtWarning, [mbOK], 0);
                              end;
                          finally
              //              PatienterFermer;
                          end;
                        end
                      else
                      //if ((E.ControleDuDossier)and(e.TypeClient=cl_isa)) then
                      if (E.ControleDuDossierEntrant and e.ControleDuDossier) then
                        begin
//                  //showmessage('R�indexation du dossier, Veuillez patientez s''il vous plait');
//                        ReindexationTableProc(nil,logo.Gauge1,true,false);
//                        CorrectionDesTiers_ou_Libelle(false,nil,false);
//                        CorrectionDesTiers_ou_Libelle(true,nil,false);
                        end;
                  end;
              except
              end;
            E.ControleDuDossier:=true;
            E.ControleDuDossierEntrant:=true;
            Application.CreateForm(TMain, Main);
          end;
      end;
  DemandeParametreSauvegardeFermetureAuto(e.AfficherMessageSauvegardeFermeture);
//  Application.CreateForm(TMain, Main);
//  Application.CreateForm(TDMAides, DMAides);
//  Application.CreateForm(TDMPointage2, DMPointage2);
//  Application.CreateForm(TDMTiers, DMTiers);
//  Application.CreateForm(TDMTrame, DMTrame);
////  Application.CreateForm(TDMTVACode, DMTVACode);
//  Application.CreateForm(TDMConstAnal, DMConstAnal);
//  Application.CreateForm(TDMDiocEtatBalT, DMDiocEtatBalT);
//  //  Application.CreateForm(TDMTmTVA, DMTmTVA);
//  Application.CreateForm(TDMImport, DMImport);
//  Application.CreateForm(TDMInitTableEpi, DMInitTableEpi);
//  Application.CreateForm(TLibClassObjetSender, LibClassObjetSender);
  Logo.Hide;
  Logo.Free;
  Logo:=nil;

  Application.Run;
  end
//else
// begin
//  showmessage('Epic�a est d�j� en cours d''ex�cution !');
//
////  BringWindowToTop(
////  FindWindow(
// end;
   except
    Application.Terminate;
   end;

end.