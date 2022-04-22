program E2_Epicea2_PM;
//
//uses
//  Forms,
//  E2_Main in 'E2_Main.pas' {Main},
//  DMAide in 'DMAide.pas' {DMAides: TDataModule},
//  DMBalances in 'DMBalances.pas' {DMBalance: TDataModule},
//  AideMontant2 in 'AideMontant2.pas' {AideMontantTTC2},
//  DMChargesAPayer in 'DMChargesAPayer.pas' {DMChargeAPayer: TDataModule},
//  DMChargesCA in 'DMChargesCA.pas' {DMChargeCA: TDataModule},
//  DMChargesRepartir in 'DMChargesRepartir.pas' {DMChargeRepartir: TDataModule},
//  DMClotures in 'DMClotures.pas' {DMCloture: TDataModule},
//  DMDepenses in 'DMDepenses.pas' {DMDepenseEnt: TDataModule},
//  DMDevises in 'DMDevises.pas' {DMDevise: TDataModule},
//  DMEcriture in 'DMEcriture.pas' {DMEcritures: TDataModule},
//  DMEmprunt in 'DMEmprunt.pas' {DMEmprunts: TDataModule},
//  DMImmo_Clot in 'DMImmo_Clot.pas' {DMImmo_Clo: TDataModule},
//  DMImmos in 'DMImmos.pas' {DataModuleImmos: TDataModule},
//  DMJournaux in 'DMJournaux.pas' {DMJournal: TDataModule},
//  DMModels in 'DMModels.pas' {DMModel: TDataModule},
//  DMProvision in 'DMProvision.pas' {DMProvisions: TDataModule},
//  DMReglement in 'DMReglement.pas' {DMReglements: TDataModule},
//  DMReport in 'DMReport.pas' {daReport: TDataModule},
//  DMStocks in 'DMStocks.pas' {DMStock: TDataModule},
//  DMTier in 'DMTier.pas' {DMTiers: TDataModule},
//  DMTmntTVA in 'DMTmntTVA.pas' {DMTtmntTVA: TDataModule},
//  DMTVA in 'DMTVA.pas' {DMTVACode: TDataModule};
//
//{$R *.RES}
//
//begin
//  Application.Initialize;
//  Application.CreateForm(TAideMontantTTC2, AideMontantTTC2);
//  Application.CreateForm(TDMAides, DMAides);
//  Application.CreateForm(TDMBalance, DMBalance);
//  Application.CreateForm(TDMChargeAPayer, DMChargeAPayer);
//  Application.CreateForm(TDMChargeCA, DMChargeCA);
//  Application.CreateForm(TDMChargeRepartir, DMChargeRepartir);
//  Application.CreateForm(TDMCloture, DMCloture);
//  Application.CreateForm(TDMDepenseEnt, DMDepenseEnt);
//  Application.CreateForm(TDMDevise, DMDevise);
//  Application.CreateForm(TDMEcritures, DMEcritures);
//  Application.CreateForm(TDMEmprunts, DMEmprunts);
//  Application.CreateForm(TDMImmo_Clo, DMImmo_Clo);
//  Application.CreateForm(TDataModuleImmos, DataModuleImmos);
//  Application.CreateForm(TDMJournal, DMJournal);
//  Application.CreateForm(TDMModel, DMModel);
//  Application.CreateForm(TDMProvisions, DMProvisions);
//  Application.CreateForm(TDMReglements, DMReglements);
//  Application.CreateForm(TdaReport, daReport);
//  Application.CreateForm(TDMStock, DMStock);
//  Application.CreateForm(TDMTiers, DMTiers);
//  Application.CreateForm(TDMTtmntTVA, DMTtmntTVA);
//  Application.CreateForm(TDMTVACode, DMTVACode);
//  Application.CreateForm(TMain, Main);
//  Application.Run;
uses
  //ShareMem,
  Forms,
  E2_Logo in 'E2_Logo.pas' {Logo},
  E2_Main in 'E2_Main.pas' {Main},
  Gr_Calculatrice in 'Gr_Calculatrice.pas' {Calculatrice},
  E2_AideCompte in 'E2_AideCompte.pas' {AideCompte},
  E2_AideLibelle in 'E2_AideLibelle.pas' {AideLibelle},
  E2_AideTrame in 'E2_AideTrame.pas' {AideTrame},
  Gr_AideDate in 'Gr_AideDate.pas' {AideDate},
  E2_VisuAPropos in '..\E2_VisuAPropos.pas' {VisuAPropos},
  E2_ListeImmos in 'E2_ListeImmos.pas' {ListeImmos},
  E2_DetailImmo in 'E2_DetailImmo.pas' {DetailImmo},
  DMImmos in 'DMImmos.pas' {DataModuleImmos: TDataModule},
  E2_ListeAcquis in 'E2_ListeAcquis.pas' {ListeAcquis},
  E2_DetailAcquis in 'E2_DetailAcquis.pas' {DetailAcquis},
  E2_Rebut in 'E2_Rebut.pas' {Rebut},
  E2_Division in 'E2_Division.pas' {Division},
  E2_Amo3Ans in 'E2_Amo3Ans.pas' {Amort5Ans},
  E2_PlusMoinsValues in 'E2_PlusMoinsValues.pas' {PlusMoinsValues},
  RB_Librairie in 'RB_Librairie.pas',
  E2_AideModel in 'E2_AideModel.pas' {AideModel},
  GestRes in 'GestRes.pas',
  GestMenu in 'GestMenu.pas' {E2_GestMenu},
  E2_ParamEnt in 'E2_ParamEnt.pas' {ParamEnt},
  DMAide in 'DMAide.pas' {DMAides: TDataModule},
  E2_TabVisuPiece2 in 'E2_TabVisuPiece2.pas' {TabVisuPiece2},
  E2_TransFond in 'E2_TransFond.pas' {TransFond},
  Gr_MultDos in 'Gr_MultDos.pas',
  E2_AideAssist in 'E2_AideAssist.pas' {AideAssist},
  E2_Tiers in 'E2_Tiers.pas' {Tiers},
  QR_ECheancier in 'QR_ECheancier.pas' {QREcheancier},
  DMReport in 'DMReport.pas' {daReport: TDataModule},
  E2_ChoixMenu in 'E2_ChoixMenu.pas' {ChMenu},
  E2_GenerCpt_PM in 'E2_GenerCpt_PM.pas' {GenerCpt_PM},
  E2_BilanOuverture in 'E2_BilanOuverture.pas' {BilanOuverture},
  E2_BalanceTiers in 'E2_BalanceTiers.pas' {BalanceTiers},
  E2_CreatDos in 'E2_CreatDos.pas' {CreatDos},
  E2_ParamProg in 'E2_ParamProg.pas' {ParamProg},
  InfoCreat in 'InfoCreat.pas' {InfoCre},
  E2_AutreDossier in 'E2_AutreDossier.pas' {AutreDossier},
  Gr_MiseAJourBalance in 'Gr_MiseAJourBalance.pas',
  E2_FinCreat in 'E2_FinCreat.pas' {FinCreat},
  E2_DosProtect in 'E2_DosProtect.pas' {DosProtect},
  E2_OKCreatExoDlg in 'E2_OKCreatExoDlg.pas' {OKCreatExoDlg},
  E2_DepensesEntreprise in 'E2_DepensesEntreprise.pas' {DepensesEntreprise},
  E2_CreationCompte_PM in 'E2_CreationCompte_PM.pas' {CreationCompte_PM},
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
  E2_Trame in 'E2_Trame.pas' {Trame},
  UQReport in 'UQReport.pas' {FPrint},
  UEtatTrame in 'UEtatTrame.pas' {FEtatTrame},
  UEtatTiers in 'UEtatTiers.pas' {FEtatTiers},
  UEtatChargesRepartir in 'UEtatChargesRepartir.pas' {FEtatChargesRepartir},
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
  Lib1 in '..\..\..\Philippe\Composant\Objets personnels\Lib1.pas',
  DMPointages in 'DMPointages.pas' {DMPointage: TDataModule},
  E2_Librairie_Obj in 'E2_Librairie_Obj.pas',
  Gr_Librairie_Obj in 'Gr_Librairie_Obj.pas',
  UEtatStock in 'UEtatStock.pas' {FEtatStock},
  E2_VBalOuv in 'E2_VBalOuv.pas' {VBalOuv},
  LibRessourceString in 'LibRessourceString.pas',
  LibSQL in '..\..\..\Philippe\Composant\Librairies\LibSQL.pas',
  UString in '..\..\..\Philippe\Composant\Librairies\UString.pas',
  E2_BalanceNew in 'E2_BalanceNew.pas' {BalanceNew},
  E2_Proprietes in 'E2_Proprietes.pas' {PgProperty},
  E2_CreationJournal in 'E2_CreationJournal.pas' {CreationJournal},
  E2_GestVisu in 'E2_GestVisu.pas' {GestVisu},
  DMTmntTVA in 'DMTmntTVA.pas' {DMTtmntTVA: TDataModule},
  E2_TtmntTVA in 'E2_TtmntTVA.pas' {TtmntTVA},
  DMParamDossier in 'DMParamDossier.pas' {DMParamDoss: TDataModule},
  E2_SaisieReglement in 'E2_SaisieReglement.pas' {SaisieReglements},
  E2_Menu in 'E2_Menu.pas' {Form1},
  E2_AideTva in 'E2_AideTva.pas' {AideTva},
  E2_CompLigne in 'E2_CompLigne.pas' {SaisieComplementLigne},
  E2_Pointages in 'E2_Pointages.pas' {Pointages},
  LibZoneSaisie in '..\..\..\Philippe\Composant\Objets Personnels\LibZoneSaisie.pas',
  DMClotures in 'DMClotures.pas' {DMCloture: TDataModule},
  DMParamEnt in 'DMParamEnt.pas' {DMParamEntreprise: TDataModule},
  E2_RepartitionResult in 'E2_RepartitionResult.pas' {RepartitionResult},
  AideMontant2 in 'AideMontant2.pas' {AideMontantTTC2},
  E2_AssistantClotureDef in 'E2_AssistantClotureDef.pas' {AssistantClotureDef},
  LibDates in '..\..\..\Philippe\Composant\Librairies\LibDates.pas',
  DMDevises in 'DMDevises.pas' {DMDevise: TDataModule},
  E2_VisuImmo in 'E2_VisuImmo.pas' {VisuImmo},
  DMImmo_Clot in 'DMImmo_Clot.pas' {DMImmo_Clo: TDataModule},
  E2_SelectionLigne in 'E2_SelectionLigne.pas' {SelectionLigne},
  E2_TranfertSolde in 'E2_TranfertSolde.pas' {TranfertSolde},
  E2_Graphes in 'E2_Graphes.pas' {Graphes},
  E2_SaisieP_3 in 'E2_SaisieP_3.pas' {saisieP_3},
  E2_Decl_Records in 'E2_Decl_Records.pas',
  saisieReglement_LibRessourceString in 'saisieReglement_LibRessourceString.pas',
  LibFichRep in '..\..\..\Philippe\Composant\Objets personnels\LibFichRep.pas',
  E2_RepriseChargeAPayer2_Isa in 'E2_RepriseChargeAPayer2_Isa.pas' {RepriseChargeAPayer2_Isa};

{$R *.RES}

begin
//  ActionEntreeTab:= True;

  Logo:= TLogo.Create(Application);
  Logo.Show;
  Logo.Update;

  Application.Title := 'Epicea-2';

  Application.Title := 'Epicea-2 - Logiciel de comptabilité -';
  Application.CreateForm(TDMBD, DMBD);
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TDMPlan, DMPlan);
  Application.CreateForm(TDMAides, DMAides);
  Application.CreateForm(TDMJournal, DMJournal);
  Application.CreateForm(TDMPieces, DMPieces);
  Application.CreateForm(TDMEcritures, DMEcritures);
  Application.CreateForm(TDMBalance, DMBalance);
  Application.CreateForm(TDMProvisions, DMProvisions);
  Application.CreateForm(TDMTiers, DMTiers);
  Application.CreateForm(TDMProg, DMProg);
  Application.CreateForm(TDMTrame, DMTrame);
  Application.CreateForm(TDMDepenseEnt, DMDepenseEnt);
  Application.CreateForm(TDMStock, DMStock);
  Application.CreateForm(TDMEmprunts, DMEmprunts);
  Application.CreateForm(TDMTVACode, DMTVACode);
  Application.CreateForm(TDMChargeRepartir, DMChargeRepartir);
  Application.CreateForm(TRecherche, Recherche);
  Application.CreateForm(TDMChargeCA, DMChargeCA);
  Application.CreateForm(TDMChargeAPayer, DMChargeAPayer);
  Application.CreateForm(TDMTtmntTVA, DMTtmntTVA);
  Application.CreateForm(TDMParamDoss, DMParamDoss);
  Application.CreateForm(TDMPointage, DMPointage);
  Application.CreateForm(TDMCloture, DMCloture);
  Application.CreateForm(TDMParamEntreprise, DMParamEntreprise);
  Application.CreateForm(TDMDevise, DMDevise);
  Application.CreateForm(TDataModuleImmos, DataModuleImmos);
  Application.CreateForm(TDMImmo_Clo, DMImmo_Clo);
  Application.CreateForm(TRepriseChargeAPayer2_Isa, RepriseChargeAPayer2_Isa);
  Logo.Hide;
  Logo.Free;

  Application.Run;

{  Application.Initialize;

  Application.Run;}
end.
