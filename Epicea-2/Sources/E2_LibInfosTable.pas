unit E2_LibInfosTable;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
Controls, Dialogs,dbTables,db;

Type


TInfos_QSQ223 = record
         Immobilisation:String;
         report:Currency;
         Valeur_a_Amortir:Currency;
         choix:Currency;
         Cumul:Currency;
         Valeur_nette:Currency;
         Type_Amt:String;
         Date_mise_en_service:TDate;
         Achat_Dans_Annee:boolean;
         ID:Integer;
         Ecriture_Cession:Integer;
         Cession_dans_annee:boolean;
         rebut:boolean;
         Date_cession:TDate;
         Mt_Cession:Currency;
         Compte:String;
         Terminee:boolean;
         EnCours:boolean;
         CodeTerminee:String;
         CompteTerminee:String;
         ResultInfos:Boolean;
end;


TInfos_QSQ224 = record
         Immobilisation:String;
         report:Currency;
         Valeur_a_Amortir:Currency;
         choix:Currency;
         Cumul:Currency;
         Valeur_nette:Currency;
         Type_Amt:String;
         Date_mise_en_service:TDate;
         Achat_Dans_Annee:boolean;
         ID:Integer;
         Ecriture_Cession:Integer;
         Cession_dans_annee:boolean;
         rebut:boolean;
         Date_cession:TDate;
         Mt_Cession:Currency;
         Compte:String;
         Terminee:boolean;
         EnCours:boolean;
         CodeTerminee:String;
         CompteTerminee:String;
         ResultInfos:Boolean;
end;


TInfosC_Tva = record
         ID:Integer;
         Classe:String;
         Libelle:String;
         ResultInfos:Boolean;
end;


TInfosConst = record
         ID:Integer;
         NomConst:String;
         TypeConst:Integer;
         VAlpha:String;
         VCurrency:Currency;
         VNumerique:currency;
         VInteger:Integer;
         VBoolean:boolean;
         VDateHeure:TDateTime;
         ResultInfos:Boolean;
end;


TInfosCretables = record
         ID:Integer;
         Nom_Table:String;
         RequeteCreationTable:variant;
         ExerciceOuDossier:String;
         ResultInfos:Boolean;
end;


TInfosDev_Prix = record
         ID_Devise:Integer;
         Date:TDate;
         DeviseBase:currency;
         DeviseEtranger:currency;
         Qui:String;
         Quand:TDateTime;
         ResultInfos:Boolean;
end;


TInfosDevise = record
         ID:Integer;
         Devise:String;
         Libelle:String;
         Qui:String;
         Quand:TDateTime;
         ResultInfos:Boolean;
end;


TInfosDicoE2 = record
         OBJID:Integer;
         VERSION:Integer;
         NAME:String;
         ALIASNAME:String;
         TYPEID:Integer;
         MISCINFO1:Integer;
         MISCINFO2:Integer;
         SRCOBJID:Integer;
         SRCVERSION:Integer;
         DESTOBJID:Integer;
         DESTVERSION:Integer;
         OUTOFDATE:String;
         CREATEDATE:TDateTime;
         LASTUPDATE:TDateTime;
         INFOBLOB:variant;
         MISCINFO3:Integer;
         ResultInfos:Boolean;
end;


TInfosGestDossier = record
         ID_Dossier:Integer;
         ID_Table:Integer;
         Nom_Dossier:String;
         Dir_Dossier:String;
         Nom_Exo:String;
         Dir_Exo:String;
         Annee_Dossier:TDateTime;
         DateUtil:TDateTime;
         Cloture:boolean;
         EXO_BASE:String;
         EXO_SAISIE:String;
         DATE_DEB_EXO:TDate;
         DATE_FIN_EXO:TDate;
         DESIGNATION_DOSSIER:String;
         ResultInfos:Boolean;
end;


TInfosGestProg = record
         ID:currency;
         DateProg:TDate;
         NumLicence:String;
         NomLicence:String;
         TypeLicence:String;
         NumVersion:String;
         NomUser:String;
         TypeVersion:String;
         DivGestProg:String;
         Div2:String;
         ResultInfos:Boolean;
end;


TInfosMessage = record
         ID:Integer;
         Groupe:String;
         Cle:String;
         Message:variant;
         Aide:Integer;
         ResultInfos:Boolean;
end;


TInfosParamCpt = record
         ID:Integer;
         Regime:String;
         Famille:Integer;
         Rac1:String;
         Rac2:String;
         Rac3:String;
         Rac4:String;
         Rac5:String;
         Rac6:String;
         ResultInfos:Boolean;
end;


TInfosParamcpt_Export = record
         REGIME:String;
         FAMILLE:currency;
         RAC1:String;
         RAC2:String;
         RAC3:String;
         RAC4:String;
         RAC5:String;
         RAC6:String;
         ResultInfos:Boolean;
end;


TInfosParamCpt_old = record
         ID:Integer;
         Regime:String;
         Famille:Integer;
         Rac1:String;
         Rac2:String;
         Rac3:String;
         Rac4:String;
         Rac5:String;
         Rac6:String;
         ResultInfos:Boolean;
end;


TInfosParamLia = record
         ID:Integer;
         TypeParamLia:String;
         ID_Ligne:Integer;
         Libelle:String;
         Col1:String;
         Col2:String;
         Col3:String;
         Col4:String;
         Col5:String;
         Col6:String;
         Col7:String;
         Col8:String;
         Col9:String;
         Col10:String;
         Col11:String;
         Col12:String;
         Col13:String;
         Col14:String;
         ResultInfos:Boolean;
end;


TInfosParamLiaOld = record
         ID:Integer;
         TypeParamLiaOld:String;
         ID_Ligne:Integer;
         Libelle:String;
         Col1:String;
         Col2:String;
         Col3:String;
         Col4:String;
         Col5:String;
         Col6:String;
         ResultInfos:Boolean;
end;


TInfosPBilan = record
         Compte:String;
         Intitule:String;
         SoldeReport:String;
         SoldeReportDebit:String;
         SoldeReportCredit:String;
         SoldeMouvement:String;
         SoldeMouvementDebit:String;
         SoldeMouvementCredit:String;
         SoldeFin:String;
         SoldeFinDebit:String;
         SoldeFinCredit:String;
         Regime:String;
         AutreDebit:String;
         AutreCredit:String;
         AutreSolde:String;
         ResultInfos:Boolean;
end;


TInfosPBilanOld = record
         Compte:String;
         Intitule:String;
         SoldeReport:String;
         SoldeReportDebit:String;
         SoldeReportCredit:String;
         SoldeMouvement:String;
         SoldeMouvementDebit:String;
         SoldeMouvementCredit:String;
         SoldeFin:String;
         SoldeFinDebit:String;
         SoldeFinCredit:String;
         ResultInfos:Boolean;
end;


TInfosPeriodeValidite = record
         ID:currency;
         DateDebut:TDate;
         DateFin:TDate;
         ResultInfos:Boolean;
end;


TInfosPlagesAmortissement = record
         ID:currency;
         IDPeriode:currency;
         Coefficient:currency;
         IDPrecedent:currency;
         IDSuivant:currency;
         Duree:TDate;
         DebutPlage:currency;
         FinPlage:currency;
         ResultInfos:Boolean;
end;


TInfosPlanCPTE = record
         Regime:String;
         Compte:String;
         Libelle:String;
         ResultInfos:Boolean;
end;


TInfosT_COM = record
         ID:Integer;
         NOM_VILLE:String;
         CP:String;
         CHEF_LIEU:String;
         ResultInfos:Boolean;
end;


TInfosAtelierDefaut = record
         ID:Integer;
         Code_Atelier:String;
         libelle_Atelier:String;
         Cpt_Plan:String;
         Cpt_Racine:String;
         Code_Activite:String;
         Divers:String;
         ResultInfos:Boolean;
end;


TInfosCdp = record
         Id:Integer;
         Cdp:String;
         LibelleCdp:String;
         Unite:String;
         LibelleUnite:String;
         ResultInfos:Boolean;
end;


TInfosCompteA = record
         Id:Integer;
         IDCdpPere:Integer;
         CompteA:String;
         LibelleA:String;
         Ratio:currency;
         ResultInfos:Boolean;
end;


TInfosCpt_CptA = record
         Id:Integer;
         IDCompteA:Integer;
         IDCdpPere:Integer;
         Compte:String;
         CompteA:String;
         Ratio:currency;
         ResultInfos:Boolean;
end;


TInfosCptAB_Cdp = record
         Id:Integer;
         IDCdp:Integer;
         IDFils:Integer;
         Cdp:String;
         Fils:String;
         Ratio:currency;
         TypeFils:Integer;
         ResultInfos:Boolean;
end;


TInfosDec_Tva = record
         ID:Integer;
         ID_Piece:Integer;
         ID_Ligne:Integer;
         TvaCode:String;
         TvaType:String;
         TvaDate:TDateTime;
         TvaMontantDebit:Currency;
         TvaMontantCredit:Currency;
         En_Attente:boolean;
         Part_Declaration:currency;
         Divers:String;
         ResultInfos:Boolean;
end;


TInfosDet_Cre = record
         ID_Ecriture:Integer;
         Compte:String;
         Creance:boolean;
         Montant:currency;
         ResultInfos:Boolean;
end;


TInfosEcheance = record
         ID:Integer;
         ID_Ecriture:Integer;
         Date:TDate;
         Creance:boolean;
         SaiseMontant:boolean;
         PourCent:currency;
         Montant:currency;
         ResultInfos:Boolean;
end;


TInfosEchEmp = record
         Id_Annuite:Integer;
         Id_Emp:Integer;
         Date:TDate;
         Annuite:Currency;
         Capital:Currency;
         Interets:Currency;
         Assurances:Currency;
         Frais_Divers:Currency;
         Capital_Restant_du:Currency;
         Rembourse:boolean;
         Annule:boolean;
         DateRemboursement:TDate;
         Reference:String;
         ResultInfos:Boolean;
end;


TInfosEcriture = record
         ID:Integer;
         ID_Piece:Integer;
         TypeLigne:String;
         ID_Ligne:Integer;
         Date:TDate;
         Compte:String;
         Tiers:String;
         Libelle:String;
         Qt1:currency;
         Qt2:currency;
         DebitSaisie:Currency;
         CreditSaisie:Currency;
         ID_Devise:Integer;
         Debit:Currency;
         Credit:Currency;
         TvaCode:String;
         TvaType:String;
         TvaTaux:currency;
         TvaDate:TDate;
         Rapprochement:String;
         Validation:TDate;
         Qui:String;
         Quand:TDateTime;
         Num_Cheque:String;
         Table_Gen:String;
         Champ_Gen:String;
         Val_Champ_Gen:String;
         ID_GESTCO:currency;
         CODE_GESTCO:String;
         Montant_Tva:Currency;
         ID_GESTANAL:Integer;
         CODE_GESTANAL:String;
         ResultInfos:Boolean;
end;


TInfosEmprunts = record
         ID:Integer;
         Code_Emp:String;
         Compte_Emp:String;
         Designation_Emp:String;
         CapiResteDu_Emp:Currency;
         CapiTotal_Emp:Currency;
         CodeGr:String;
         DateRealisation:TDate;
         NbPeriode:currency;
         P1:currency;
         PP1:currency;
         P2:currency;
         PP2:currency;
         P3:currency;
         PP3:currency;
         TypeRb:String;
         PeriodeRb:String;
         Differe:currency;
         FraisAnnexe:currency;
         Assurance:currency;
         DatePremEcheance:TDate;
         CapitalRbPE:Currency;
         InteretRbPE:Currency;
         NbRbFait:currency;
         Banque:String;
         Actif:boolean;
         ResultInfos:Boolean;
end;


TInfosGDossier = record
         ID_Dossier:Integer;
         ID_Table:Integer;
         Nom_Dossier:String;
         Dir_Dossier:String;
         Nom_Exo:String;
         Dir_Exo:String;
         Annee_Dossier:TDateTime;
         DateUtil:TDateTime;
         Cloture:boolean;
         EXO_BASE:String;
         EXO_SAISIE:String;
         DATE_DEB_EXO:TDate;
         DATE_FIN_EXO:TDate;
         DESIGNATION_DOSSIER:String;
         ResultInfos:Boolean;
end;


TInfosH_PieceTva = record
         ID:Integer;
         ID_Declaration:Integer;
         Reference_OD:String;
         Debut_Periode:TDateTime;
         Fin_Periode:TDateTime;
         Verrouillee:boolean;
         Deverrouillable:boolean;
         VerrouillageManuel:boolean;
         Divers_Bool:boolean;
         Divers_Str:String;
         ResultInfos:Boolean;
end;


TInfosH_TVA = record
         ID:Integer;
         ID_Ecriture:Integer;
         ID_Piece:Integer;
         ID_Declaration:Integer;
         Part_Declaree:currency;
         Debut_Periode:TDateTime;
         Fin_Periode:TDateTime;
         Verrouillee:boolean;
         Deverrouillable:boolean;
         En_Attente:boolean;
         Date_Tva:TDateTime;
         Reference_OD:String;
         MontantTVA:Currency;
         HTDeclare:Currency;
         Divers:String;
         CodeCompensation:String;
         Taux:currency;
         ResultInfos:Boolean;
end;


TInfosH_Tva_Fin = record
         ID:Integer;
         Id_Declaration:Integer;
         TypeSolde:Integer;
         Compte:String;
         Total:Currency;
         SensCredit:Integer;
         ATraiter:boolean;
         ResultInfos:Boolean;
end;


TInfosH_Tva_Report = record
         ID:Integer;
         Id_Declaration:Integer;
         Compte:String;
         Solde:Currency;
         SensCredit:boolean;
         ATraiter:boolean;
         Code_Choix:Integer;
         ResultInfos:Boolean;
end;


TInfosImmos = record
         ID:Integer;
         Libelle:String;
         Ecriture_Achat:Integer;
         Ecriture_Cession:Integer;
         Compte:String;
         Code:String;
         Sous_Code:String;
         Date_Org:TDate;
         Valeur_Org:Currency;
         Valeur_Venale:Currency;
         Duree:Integer;
         Valeur_a_Amortir:Currency;
         Date_Achat:TDate;
         Date_Mise_en_Service:TDate;
         Duree_Amt:Integer;
         Type_Amt:String;
         Deduc_Invest:boolean;
         Mt_Deduc_Invest:Currency;
         Reprise_deduc_invest:Currency;
         Valeur_Nette:Currency;
         Amort_Eco:Currency;
         Amort_Derog:Currency;
         Mt_Cession:Currency;
         Date_Cession:TDate;
         Rebut:boolean;
         Achat_dans_Annee:boolean;
         Cession_dans_Annee:boolean;
         Duree_Restante:Integer;
         Simulation:String;
         Sous_Compte:boolean;
         Maxi:Currency;
         Mini:Currency;
         Choix:Currency;
         Eco:Currency;
         Terminee:boolean;
         EnCours:boolean;
         CodeTerminee:String;
         CompteTerminee:String;
         TauxAmo:currency;
         Tiers:String;
         ReferenceFacture:String;
         MontantTTC:Currency;
         SousCodeTerminee:String;
         ResultInfos:Boolean;
end;


TInfosLCpt_CptA = record
         Id:Integer;
         IDCompteA:Integer;
         IDCdpPere:Integer;
         IDLigne:Integer;
         CompteA:String;
         Ratio:currency;
         ResultInfos:Boolean;
end;


TInfosModel = record
         ID:Integer;
         Code:String;
         Libelle_Model:String;
         Libelle:String;
         Journal:String;
         Compte:String;
         Compte_Reglement:String;
         Minimun:boolean;
         ID_Devise:Integer;
         ID_Journal:Integer;
         Qui:String;
         Quand:TDateTime;
         CODE_BANQUE_GESTCO:String;
         ResultInfos:Boolean;
end;


TInfosModelL = record
         ID:Integer;
         ID_Model:Integer;
         Ligne:Integer;
         Compte:String;
         Libelle:String;
         Qt1:currency;
         Qt2:currency;
         Montant:Currency;
         Tva:Currency;
         TvaCode:String;
         TvaType:String;
         TvaTaux:currency;
         Qui:String;
         Quand:TDateTime;
         ResultInfos:Boolean;
end;


TInfosParam_Dossier = record
         CLE:String;
         NOM_DOSS:String;
         Adr1:String;
         Adr2:String;
         CP:String;
         VILLE:String;
         REGIME_Agr:String;
         TYPE_SOC:String;
         TYPE_FISC:String;
         PERIODE_TVA:String;
         TVA_DEBIT:String;
         PLAN_AUX:String;
         PERIODE:String;
         TYPE_IMPOT:String;
         TYPE_DEC_FISC:String;
         DATE_DEB_EXO:TDate;
         DATE_FIN_EXO:TDate;
         EXO_SAISIE:String;
         EXO_BASE:String;
         DEVISE_EXO:String;
         DIVParam_Dossier:variant;
         DATE_PREM_DECL_TVA:TDateTime;
         DEROGATOIRE:boolean;
         DATE_PASSAGE_REEL:TDateTime;
         AU_REEL:boolean;
         PARAM_DIV:String;
         UTILISATEUR:String;
         ResultInfos:Boolean;
end;


TInfosPiece = record
         ID:Integer;
         Journal:Integer;
         Reference:String;
         Date:TDate;
         Libelle:String;
         TypePiece:Integer;
         Compte:String;
         ID_Devise:Integer;
         Validation:TDate;
         Qui:String;
         Quand:TDateTime;
         Num_Cheque:String;
         ID_GESTCO:currency;
         CODE_GESTCO:String;
         Table_Gen:String;
         Champ_Gen:String;
         Val_Champ_Gen:String;
         ResultInfos:Boolean;
end;


TInfosPiece_Import = record
         ID:Integer;
         ID_Piece_Import:Integer;
         Nouvel_ID_Piece:Integer;
         Compte:String;
         Libelle:String;
         Debit:Currency;
         Credit:Currency;
         ID_Prog:Integer;
         ResultInfos:Boolean;
end;


TInfosplancpt = record
         Compte:String;
         Libelle:String;
         Debit_Deb:currency;
         Credit_Deb:currency;
         Un1:String;
         Un2:String;
         Qt1_Deb:currency;
         Qt2_Deb:currency;
         PlanSaisie:boolean;
         TvaCode:String;
         TvaType:String;
         TvaDebit:boolean;
         SensCredit:boolean;
         Collectif:boolean;
         Centraliser:boolean;
         Tiers:boolean;
         Rapprochement:boolean;
         Immobilisation:boolean;
         ImmoAmort:boolean;
         ImmoDegressif:boolean;
         Emprunt:boolean;
         Abandonne:boolean;
         Qui:String;
         Quand:TDateTime;
         ID_Affichage:Integer;
         JBanque:String;
         pointable:boolean;
         taux:currency;
         DIVplancpt:String;
         ID_GESTANAL:Integer;
         CODE_GESTANAL:String;
         UtilOuvAuto:boolean;
         ResultInfos:Boolean;
end;


TInfosPointage = record
         ID:currency;
         ID_Debit:Integer;
         ID_Credit:Integer;
         Date:TDate;
         Montant:Currency;
         TvaDate:TDate;
         Validation:TDate;
         Qui:String;
         Quand:TDateTime;
         ResultInfos:Boolean;
end;


TInfosResteDC = record
         ID:Integer;
         ID_Ecriture:Integer;
         ID_Piece:Integer;
         Date:TDate;
         Reference:String;
         Tiers:String;
         Libelle:String;
         Debit:Currency;
         Credit:Currency;
         Sens:String;
         Reste:Currency;
         Lettre:String;
         Montant:Currency;
         Ligne:Integer;
         ResultInfos:Boolean;
end;


TInfosTA_Activite = record
         ID_Activite:Integer;
         Code_Activite:String;
         Libelle_Activite:String;
         ResultInfos:Boolean;
end;


TInfosTA_Affect_Atelier = record
         ID:Integer;
         ID_Atelier:Integer;
         ID_Ligne:Integer;
         Compte:String;
         Libelle:String;
         Code_Atelier:String;
         Ratio:currency;
         ResultInfos:Boolean;
end;


TInfosTA_Atelier = record
         ID_Atelier:Integer;
         Code_Atelier:String;
         Libelle_Atelier:String;
         NB_Unite_Atelier:currency;
         Unite_Atelier:String;
         ID_Activite:Integer;
         Code_Activite:String;
         ResultInfos:Boolean;
end;


TInfosTiers = record
         Tiers:String;
         Nom:String;
         Compte:String;
         TypeTiers:String;
         SensCredit:boolean;
         Rapprochement:boolean;
         TvaDebit:boolean;
         Abandonne:boolean;
         Debit_Deb:Currency;
         Credit_Deb:Currency;
         Adresse1:String;
         Adresse2:String;
         Poste:String;
         Ville:String;
         Pays:String;
         Livr_Adr1:String;
         Livr_Adr2:String;
         Livr_Poste:String;
         Livr_Ville:String;
         Livr_Pays:String;
         Telephone1:String;
         Telephone2:String;
         Telecopie:String;
         Mel:String;
         Qui:String;
         Quand:TDateTime;
         Actif:boolean;
         ID_GESTCO:currency;
         ID_COMMUNICATION:currency;
         CODE_GESTCO:String;
         ID_Affichage:Integer;
         JBanque:String;
         ResultInfos:Boolean;
end;


TInfosTrame = record
         ID:Integer;
         Code:String;
         Libelle_Trame:String;
         Libelle:String;
         Journal:String;
         Compte:String;
         Compte_Reglement:String;
         Minimun:boolean;
         ID_Devise:Integer;
         ID_Journal:Integer;
         Qui:String;
         Quand:TDateTime;
         ResultInfos:Boolean;
end;


TInfosTrameL = record
         ID:Integer;
         ID_Trame:Integer;
         Ligne:Integer;
         Compte:String;
         Libelle:String;
         Qt1:currency;
         Qt2:currency;
         MontantDebit:Currency;
         MontantCredit:Currency;
         TvaCode:String;
         TvaType:String;
         TvaTaux:currency;
         MontantTva:Currency;
         Qui:String;
         Quand:TDateTime;
         TypeLigne:String;
         ResultInfos:Boolean;
end;


TInfosTvaCode = record
         TvaCode:String;
         Classe:String;
         Libelle:String;
         Compte:String;
         Taux_Inf:currency;
         Taux_Supp:currency;
         Qui:String;
         Quand:TDateTime;
         CODE_GESTCO:String;
         ResultInfos:Boolean;
end;


TInfosBalance = record
         Compte:String;
         Tiers:String;
         Debit_Report:currency;
         Credit_Report:currency;
         Debit_Base:currency;
         Credit_Base:currency;
         Debit_Total:currency;
         Credit_Total:currency;
         Qt1_Report:currency;
         Qt2_Report:currency;
         Qt1_Base:currency;
         Qt2_Base:currency;
         Qt1_Total:currency;
         Qt2_Total:currency;
         ID_Affichage:Integer;
         ResultInfos:Boolean;
end;


TInfosBalanceTiers = record
         Compte:String;
         Tiers:String;
         Debit_Report:currency;
         Credit_Report:currency;
         Debit_Base:currency;
         Credit_Base:currency;
         Debit_Total:currency;
         Credit_Total:currency;
         Qt1_Report:currency;
         Qt2_Report:currency;
         Qt1_Base:currency;
         Qt2_Base:currency;
         Qt1_Total:currency;
         Qt2_Total:currency;
         ID_Affichage:Integer;
         ResultInfos:Boolean;
end;


TInfosChargeAPayer = record
         ID:Integer;
         Compte:String;
         Libelle:String;
         Sens:String;
         Qte:currency;
         MontantHT:Currency;
         DateSaisie:TDate;
         DateExercice:TDate;
         Compte2:String;
         Libelle2:String;
         TVA:Currency;
         DateSysteme:TDateTime;
         Date_Piece:TDate;
         Reference:String;
         Id_Piece:Integer;
         ResultInfos:Boolean;
end;


TInfosChargesRepartir = record
         ID:Integer;
         Compte:String;
         Designation:String;
         MtTotalCharge:Currency;
         MtBilanOuverture:Currency;
         DateSysteme:TDateTime;
         Reference:String;
         MontantReprise:Currency;
         DateSaisie:TDate;
         ResultInfos:Boolean;
end;


TInfosDepensesEntreprises = record
         ID:Integer;
         Compte:String;
         Libelle:String;
         Sens:String;
         Qte:currency;
         MontantHT:Currency;
         DateSaisie:TDate;
         DateExercice:TDate;
         Compte2:String;
         Libelle2:String;
         TVA:Currency;
         DatePiece:TDate;
         Reference:String;
         DateSysteme:TDateTime;
         ResultInfos:Boolean;
end;


TInfosImmos_clot = record
         ID:Integer;
         Code:currency;
         Reference_OP:String;
         COMPTE:String;
         Contrepartie:String;
         Designation:String;
         Quantite:Integer;
         Montant:Currency;
         TVA:Currency;
         Date:TDate;
         Type_Immo:currency;
         ResultInfos:Boolean;
end;


TInfosPCA = record
         ID:Integer;
         Compte:String;
         Libelle:String;
         Sens:String;
         Qte:currency;
         MontantHT:Currency;
         DateSaisie:TDate;
         DateExercice:TDate;
         Compte2:String;
         Libelle2:String;
         DateSysteme:TDateTime;
         Date_Piece:TDate;
         Reference:String;
         ResultInfos:Boolean;
end;


TInfosProvisions = record
         ID:Integer;
         Compte:String;
         Designation:String;
         MtTotalProvision:Currency;
         MtBilanOuverture:Currency;
         DateSysteme:TDateTime;
         Reference:String;
         MontantReprise:Currency;
         DateSaisie:TDate;
         ResultInfos:Boolean;
end;


TInfosReglemnt = record
         ID:Integer;
         ID_Debit:Integer;
         ID_Credit:Integer;
         Date:TDate;
         Montant:currency;
         TvaDate:TDate;
         Validation:TDate;
         Qui:String;
         Quand:TDateTime;
         ResultInfos:Boolean;
end;


TInfosReport = record
         Compte:String;
         Tiers:String;
         Debit_Report:currency;
         Credit_Report:currency;
         Debit_Base:currency;
         Credit_Base:currency;
         Debit_Total:currency;
         Credit_Total:currency;
         Qt1_Report:currency;
         Qt2_Report:currency;
         Qt1_Base:currency;
         Qt2_Base:currency;
         Qt1_Total:currency;
         Qt2_Total:currency;
         ID_Affichage:Integer;
         ResultInfos:Boolean;
end;


TInfosStock = record
         ID:Integer;
         Compte:String;
         Designation:String;
         Qte:currency;
         Prix_Unitaire:Currency;
         Decote:Integer;
         MontantTotalHT:Currency;
         Actif:boolean;
         Date_Saisie:TDate;
         Date_ID_Exercice:TDate;
         Date_Piece:TDate;
         Reference:String;
         ResultInfos:Boolean;
end;


TInfosTA_Atelier_Activite = record
         ID_Atelier:Integer;
         ID_Activite:Integer;
         Ratio:currency;
         ResultInfos:Boolean;
end;


TInfosTA_Compte_Atelier = record
         Compte:String;
         ID_Atelier:Integer;
         Libelle:String;
         Ratio:currency;
         ResultInfos:Boolean;
end;


TInfosTA_Ecriture_Atelier = record
         ID_Ligne:Integer;
         ID_Atelier:Integer;
         Libelle:String;
         Ratio:currency;
         ResultInfos:Boolean;
end;


TInfosTa_MessageLGR = record
         ID_Message:Integer;
         Ecran:String;
         Composant:String;
         Cle:String;
         MessageLGR:String;
         Titre:string;
         Afficher:boolean;
         Divers:string;
         ResultInfos:Boolean;
end;


Procedure Initialise_TInfosC_Tva(var InfosC_Tva:TInfosC_Tva);
Procedure Remplit_TInfosC_Tva(DataSet:TDataSet;var InfosC_Tva:TInfosC_Tva);
Function Infos_TInfosC_Tva(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosC_Tva;
Procedure Initialise_TInfosConst(var InfosConst:TInfosConst);
Procedure Remplit_TInfosConst(DataSet:TDataSet;var InfosConst:TInfosConst);
Function Infos_TInfosConst(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosConst;
Procedure Initialise_TInfosCretables(var InfosCretables:TInfosCretables);
Procedure Remplit_TInfosCretables(DataSet:TDataSet;var InfosCretables:TInfosCretables);
Function Infos_TInfosCretables(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCretables;
Procedure Initialise_TInfosDev_Prix(var InfosDev_Prix:TInfosDev_Prix);
Procedure Remplit_TInfosDev_Prix(DataSet:TDataSet;var InfosDev_Prix:TInfosDev_Prix);
Function Infos_TInfosDev_Prix(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDev_Prix;
Procedure Initialise_TInfosDevise(var InfosDevise:TInfosDevise);
Procedure Remplit_TInfosDevise(DataSet:TDataSet;var InfosDevise:TInfosDevise);
Function Infos_TInfosDevise(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDevise;
Procedure Initialise_TInfosDicoE2(var InfosDicoE2:TInfosDicoE2);
Procedure Remplit_TInfosDicoE2(DataSet:TDataSet;var InfosDicoE2:TInfosDicoE2);
Function Infos_TInfosDicoE2(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDicoE2;
Procedure Initialise_TInfosGestDossier(var InfosGestDossier:TInfosGestDossier);
Procedure Remplit_TInfosGestDossier(DataSet:TDataSet;var InfosGestDossier:TInfosGestDossier);
Function Infos_TInfosGestDossier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosGestDossier;
Procedure Initialise_TInfosGestProg(var InfosGestProg:TInfosGestProg);
Procedure Remplit_TInfosGestProg(DataSet:TDataSet;var InfosGestProg:TInfosGestProg);
Function Infos_TInfosGestProg(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosGestProg;
Procedure Initialise_TInfosMessage(var InfosMessage:TInfosMessage);
Procedure Remplit_TInfosMessage(DataSet:TDataSet;var InfosMessage:TInfosMessage);
Function Infos_TInfosMessage(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosMessage;
Procedure Initialise_TInfosParamCpt(var InfosParamCpt:TInfosParamCpt);
Procedure Remplit_TInfosParamCpt(DataSet:TDataSet;var InfosParamCpt:TInfosParamCpt);
Function Infos_TInfosParamCpt(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamCpt;
Procedure Initialise_TInfosParamcpt_Export(var InfosParamcpt_Export:TInfosParamcpt_Export);
Procedure Remplit_TInfosParamcpt_Export(DataSet:TDataSet;var InfosParamcpt_Export:TInfosParamcpt_Export);
Function Infos_TInfosParamcpt_Export(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamcpt_Export;
Procedure Initialise_TInfosParamCpt_old(var InfosParamCpt_old:TInfosParamCpt_old);
Procedure Remplit_TInfosParamCpt_old(DataSet:TDataSet;var InfosParamCpt_old:TInfosParamCpt_old);
Function Infos_TInfosParamCpt_old(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamCpt_old;
Procedure Initialise_TInfosParamLia(var InfosParamLia:TInfosParamLia);
Procedure Remplit_TInfosParamLia(DataSet:TDataSet;var InfosParamLia:TInfosParamLia);
Function Infos_TInfosParamLia(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamLia;
Procedure Initialise_TInfosParamLiaOld(var InfosParamLiaOld:TInfosParamLiaOld);
Procedure Remplit_TInfosParamLiaOld(DataSet:TDataSet;var InfosParamLiaOld:TInfosParamLiaOld);
Function Infos_TInfosParamLiaOld(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamLiaOld;
Procedure Initialise_TInfosPBilan(var InfosPBilan:TInfosPBilan);
Procedure Remplit_TInfosPBilan(DataSet:TDataSet;var InfosPBilan:TInfosPBilan);
Function Infos_TInfosPBilan(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPBilan;
Procedure Initialise_TInfosPBilanOld(var InfosPBilanOld:TInfosPBilanOld);
Procedure Remplit_TInfosPBilanOld(DataSet:TDataSet;var InfosPBilanOld:TInfosPBilanOld);
Function Infos_TInfosPBilanOld(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPBilanOld;
Procedure Initialise_TInfosPeriodeValidite(var InfosPeriodeValidite:TInfosPeriodeValidite);
Procedure Remplit_TInfosPeriodeValidite(DataSet:TDataSet;var InfosPeriodeValidite:TInfosPeriodeValidite);
Function Infos_TInfosPeriodeValidite(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPeriodeValidite;
Procedure Initialise_TInfosPlagesAmortissement(var InfosPlagesAmortissement:TInfosPlagesAmortissement);
Procedure Remplit_TInfosPlagesAmortissement(DataSet:TDataSet;var InfosPlagesAmortissement:TInfosPlagesAmortissement);
Function Infos_TInfosPlagesAmortissement(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPlagesAmortissement;
Procedure Initialise_TInfosPlanCPTE(var InfosPlanCPTE:TInfosPlanCPTE);
Procedure Remplit_TInfosPlanCPTE(DataSet:TDataSet;var InfosPlanCPTE:TInfosPlanCPTE);
Function Infos_TInfosPlanCPTE(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPlanCPTE;
Procedure Initialise_TInfosT_COM(var InfosT_COM:TInfosT_COM);
Procedure Remplit_TInfosT_COM(DataSet:TDataSet;var InfosT_COM:TInfosT_COM);
Function Infos_TInfosT_COM(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosT_COM;
Procedure Initialise_TInfosAtelierDefaut(var InfosAtelierDefaut:TInfosAtelierDefaut);
Procedure Remplit_TInfosAtelierDefaut(DataSet:TDataSet;var InfosAtelierDefaut:TInfosAtelierDefaut);
Function Infos_TInfosAtelierDefaut(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosAtelierDefaut;
Procedure Initialise_TInfosCdp(var InfosCdp:TInfosCdp);
Procedure Remplit_TInfosCdp(DataSet:TDataSet;var InfosCdp:TInfosCdp);
Function Infos_TInfosCdp(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCdp;
Procedure Initialise_TInfosCompteA(var InfosCompteA:TInfosCompteA);
Procedure Remplit_TInfosCompteA(DataSet:TDataSet;var InfosCompteA:TInfosCompteA);
Function Infos_TInfosCompteA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCompteA;
Procedure Initialise_TInfosCpt_CptA(var InfosCpt_CptA:TInfosCpt_CptA);
Procedure Remplit_TInfosCpt_CptA(DataSet:TDataSet;var InfosCpt_CptA:TInfosCpt_CptA);
Function Infos_TInfosCpt_CptA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCpt_CptA;
Procedure Initialise_TInfosCptAB_Cdp(var InfosCptAB_Cdp:TInfosCptAB_Cdp);
Procedure Remplit_TInfosCptAB_Cdp(DataSet:TDataSet;var InfosCptAB_Cdp:TInfosCptAB_Cdp);
Function Infos_TInfosCptAB_Cdp(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCptAB_Cdp;
Procedure Initialise_TInfosDec_Tva(var InfosDec_Tva:TInfosDec_Tva);
Procedure Remplit_TInfosDec_Tva(DataSet:TDataSet;var InfosDec_Tva:TInfosDec_Tva);
Function Infos_TInfosDec_Tva(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDec_Tva;
Procedure Initialise_TInfosDet_Cre(var InfosDet_Cre:TInfosDet_Cre);
Procedure Remplit_TInfosDet_Cre(DataSet:TDataSet;var InfosDet_Cre:TInfosDet_Cre);
Function Infos_TInfosDet_Cre(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDet_Cre;
Procedure Initialise_TInfosEcheance(var InfosEcheance:TInfosEcheance);
Procedure Remplit_TInfosEcheance(DataSet:TDataSet;var InfosEcheance:TInfosEcheance);
Function Infos_TInfosEcheance(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosEcheance;
Procedure Initialise_TInfosEchEmp(var InfosEchEmp:TInfosEchEmp);
Procedure Remplit_TInfosEchEmp(DataSet:TDataSet;var InfosEchEmp:TInfosEchEmp);
Function Infos_TInfosEchEmp(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosEchEmp;
Procedure Initialise_TInfosEcriture(var InfosEcriture:TInfosEcriture);
Procedure Remplit_TInfosEcriture(DataSet:TDataSet;var InfosEcriture:TInfosEcriture);
Function Infos_TInfosEcriture(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosEcriture;
Procedure Initialise_TInfosEmprunts(var InfosEmprunts:TInfosEmprunts);
Procedure Remplit_TInfosEmprunts(DataSet:TDataSet;var InfosEmprunts:TInfosEmprunts);
Function Infos_TInfosEmprunts(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosEmprunts;
Procedure Initialise_TInfosGDossier(var InfosGDossier:TInfosGDossier);
Procedure Remplit_TInfosGDossier(DataSet:TDataSet;var InfosGDossier:TInfosGDossier);
Function Infos_TInfosGDossier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosGDossier;
Procedure Initialise_TInfosH_PieceTva(var InfosH_PieceTva:TInfosH_PieceTva);
Procedure Remplit_TInfosH_PieceTva(DataSet:TDataSet;var InfosH_PieceTva:TInfosH_PieceTva);
Function Infos_TInfosH_PieceTva(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosH_PieceTva;
Procedure Initialise_TInfosH_TVA(var InfosH_TVA:TInfosH_TVA);
Procedure Remplit_TInfosH_TVA(DataSet:TDataSet;var InfosH_TVA:TInfosH_TVA);
Function Infos_TInfosH_TVA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosH_TVA;
Procedure Initialise_TInfosH_Tva_Fin(var InfosH_Tva_Fin:TInfosH_Tva_Fin);
Procedure Remplit_TInfosH_Tva_Fin(DataSet:TDataSet;var InfosH_Tva_Fin:TInfosH_Tva_Fin);
Function Infos_TInfosH_Tva_Fin(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosH_Tva_Fin;
Procedure Initialise_TInfosH_Tva_Report(var InfosH_Tva_Report:TInfosH_Tva_Report);
Procedure Remplit_TInfosH_Tva_Report(DataSet:TDataSet;var InfosH_Tva_Report:TInfosH_Tva_Report);
Function Infos_TInfosH_Tva_Report(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosH_Tva_Report;
Procedure Initialise_TInfosImmos(var InfosImmos:TInfosImmos);
Procedure Remplit_TInfosImmos(DataSet:TDataSet;var InfosImmos:TInfosImmos);
Function Infos_TInfosImmos(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosImmos;
Procedure Initialise_TInfosLCpt_CptA(var InfosLCpt_CptA:TInfosLCpt_CptA);
Procedure Remplit_TInfosLCpt_CptA(DataSet:TDataSet;var InfosLCpt_CptA:TInfosLCpt_CptA);
Function Infos_TInfosLCpt_CptA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosLCpt_CptA;
Procedure Initialise_TInfosModel(var InfosModel:TInfosModel);
Procedure Remplit_TInfosModel(DataSet:TDataSet;var InfosModel:TInfosModel);
Function Infos_TInfosModel(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosModel;
Procedure Initialise_TInfosModelL(var InfosModelL:TInfosModelL);
Procedure Remplit_TInfosModelL(DataSet:TDataSet;var InfosModelL:TInfosModelL);
Function Infos_TInfosModelL(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosModelL;
Procedure Initialise_TInfosParam_Dossier(var InfosParam_Dossier:TInfosParam_Dossier);
Procedure Remplit_TInfosParam_Dossier(DataSet:TDataSet;var InfosParam_Dossier:TInfosParam_Dossier);
Function Infos_TInfosParam_Dossier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParam_Dossier;
Procedure Initialise_TInfosPiece(var InfosPiece:TInfosPiece);
Procedure Remplit_TInfosPiece(DataSet:TDataSet;var InfosPiece:TInfosPiece);
Function Infos_TInfosPiece(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPiece;
Procedure Initialise_TInfosPiece_Import(var InfosPiece_Import:TInfosPiece_Import);
Procedure Remplit_TInfosPiece_Import(DataSet:TDataSet;var InfosPiece_Import:TInfosPiece_Import);
Function Infos_TInfosPiece_Import(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPiece_Import;
Procedure Initialise_TInfosplancpt(var Infosplancpt:TInfosplancpt);
Procedure Remplit_TInfosplancpt(DataSet:TDataSet;var Infosplancpt:TInfosplancpt);
Function Infos_TInfosplancpt(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosplancpt;
Procedure Initialise_TInfosPointage(var InfosPointage:TInfosPointage);
Procedure Remplit_TInfosPointage(DataSet:TDataSet;var InfosPointage:TInfosPointage);
Function Infos_TInfosPointage(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPointage;
Procedure Initialise_TInfosResteDC(var InfosResteDC:TInfosResteDC);
Procedure Remplit_TInfosResteDC(DataSet:TDataSet;var InfosResteDC:TInfosResteDC);
Function Infos_TInfosResteDC(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosResteDC;
Procedure Initialise_TInfosTA_Activite(var InfosTA_Activite:TInfosTA_Activite);
Procedure Remplit_TInfosTA_Activite(DataSet:TDataSet;var InfosTA_Activite:TInfosTA_Activite);
Function Infos_TInfosTA_Activite(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Activite;
Procedure Initialise_TInfosTA_Affect_Atelier(var InfosTA_Affect_Atelier:TInfosTA_Affect_Atelier);
Procedure Remplit_TInfosTA_Affect_Atelier(DataSet:TDataSet;var InfosTA_Affect_Atelier:TInfosTA_Affect_Atelier);
Function Infos_TInfosTA_Affect_Atelier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Affect_Atelier;
Procedure Initialise_TInfosTA_Atelier(var InfosTA_Atelier:TInfosTA_Atelier);
Procedure Remplit_TInfosTA_Atelier(DataSet:TDataSet;var InfosTA_Atelier:TInfosTA_Atelier);
Function Infos_TInfosTA_Atelier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Atelier;
Procedure Initialise_TInfosTiers(var InfosTiers:TInfosTiers);
Procedure Remplit_TInfosTiers(DataSet:TDataSet;var InfosTiers:TInfosTiers);
Function Infos_TInfosTiers(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTiers;
Procedure Initialise_TInfosTrame(var InfosTrame:TInfosTrame);
Procedure Remplit_TInfosTrame(DataSet:TDataSet;var InfosTrame:TInfosTrame);
Function Infos_TInfosTrame(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTrame;
Procedure Initialise_TInfosTrameL(var InfosTrameL:TInfosTrameL);
Procedure Remplit_TInfosTrameL(DataSet:TDataSet;var InfosTrameL:TInfosTrameL);
Function Infos_TInfosTrameL(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTrameL;
Procedure Initialise_TInfosTvaCode(var InfosTvaCode:TInfosTvaCode);
Procedure Remplit_TInfosTvaCode(DataSet:TDataSet;var InfosTvaCode:TInfosTvaCode);
Function Infos_TInfosTvaCode(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTvaCode;
Procedure Initialise_TInfosBalance(var InfosBalance:TInfosBalance);
Procedure Remplit_TInfosBalance(DataSet:TDataSet;var InfosBalance:TInfosBalance);
Function Infos_TInfosBalance(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosBalance;
Procedure Initialise_TInfosBalanceTiers(var InfosBalanceTiers:TInfosBalanceTiers);
Procedure Remplit_TInfosBalanceTiers(DataSet:TDataSet;var InfosBalanceTiers:TInfosBalanceTiers);
Function Infos_TInfosBalanceTiers(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosBalanceTiers;
Procedure Initialise_TInfosChargeAPayer(var InfosChargeAPayer:TInfosChargeAPayer);
Procedure Remplit_TInfosChargeAPayer(DataSet:TDataSet;var InfosChargeAPayer:TInfosChargeAPayer);
Function Infos_TInfosChargeAPayer(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosChargeAPayer;
Procedure Initialise_TInfosChargesRepartir(var InfosChargesRepartir:TInfosChargesRepartir);
Procedure Remplit_TInfosChargesRepartir(DataSet:TDataSet;var InfosChargesRepartir:TInfosChargesRepartir);
Function Infos_TInfosChargesRepartir(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosChargesRepartir;
Procedure Initialise_TInfosDepensesEntreprises(var InfosDepensesEntreprises:TInfosDepensesEntreprises);
Procedure Remplit_TInfosDepensesEntreprises(DataSet:TDataSet;var InfosDepensesEntreprises:TInfosDepensesEntreprises);
Function Infos_TInfosDepensesEntreprises(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDepensesEntreprises;
Procedure Initialise_TInfosImmos_clot(var InfosImmos_clot:TInfosImmos_clot);
Procedure Remplit_TInfosImmos_clot(DataSet:TDataSet;var InfosImmos_clot:TInfosImmos_clot);
Function Infos_TInfosImmos_clot(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosImmos_clot;
Procedure Initialise_TInfosPCA(var InfosPCA:TInfosPCA);
Procedure Remplit_TInfosPCA(DataSet:TDataSet;var InfosPCA:TInfosPCA);
Function Infos_TInfosPCA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPCA;
Procedure Initialise_TInfosProvisions(var InfosProvisions:TInfosProvisions);
Procedure Remplit_TInfosProvisions(DataSet:TDataSet;var InfosProvisions:TInfosProvisions);
Function Infos_TInfosProvisions(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosProvisions;
Procedure Initialise_TInfosReglemnt(var InfosReglemnt:TInfosReglemnt);
Procedure Remplit_TInfosReglemnt(DataSet:TDataSet;var InfosReglemnt:TInfosReglemnt);
Function Infos_TInfosReglemnt(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosReglemnt;
Procedure Initialise_TInfosReport(var InfosReport:TInfosReport);
Procedure Remplit_TInfosReport(DataSet:TDataSet;var InfosReport:TInfosReport);
Function Infos_TInfosReport(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosReport;
Procedure Initialise_TInfosStock(var InfosStock:TInfosStock);
Procedure Remplit_TInfosStock(DataSet:TDataSet;var InfosStock:TInfosStock);
Function Infos_TInfosStock(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosStock;
Procedure Initialise_TInfosTA_Atelier_Activite(var InfosTA_Atelier_Activite:TInfosTA_Atelier_Activite);
Procedure Remplit_TInfosTA_Atelier_Activite(DataSet:TDataSet;var InfosTA_Atelier_Activite:TInfosTA_Atelier_Activite);
Function Infos_TInfosTA_Atelier_Activite(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Atelier_Activite;
Procedure Initialise_TInfosTA_Compte_Atelier(var InfosTA_Compte_Atelier:TInfosTA_Compte_Atelier);
Procedure Remplit_TInfosTA_Compte_Atelier(DataSet:TDataSet;var InfosTA_Compte_Atelier:TInfosTA_Compte_Atelier);
Function Infos_TInfosTA_Compte_Atelier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Compte_Atelier;
Procedure Initialise_TInfosTA_Ecriture_Atelier(var InfosTA_Ecriture_Atelier:TInfosTA_Ecriture_Atelier);
Procedure Remplit_TInfosTA_Ecriture_Atelier(DataSet:TDataSet;var InfosTA_Ecriture_Atelier:TInfosTA_Ecriture_Atelier);
Function Infos_TInfosTA_Ecriture_Atelier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Ecriture_Atelier;
Procedure Initialise_TInfosTa_MessageLGR(var InfosTa_MessageLGR:TInfosTa_MessageLGR);
Procedure Remplit_TInfosTa_MessageLGR(DataSet:TDataSet;var InfosTa_MessageLGR:TInfosTa_MessageLGR);
Function Infos_TInfosTa_MessageLGR(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTa_MessageLGR;
implementation

Uses
  LibSQL;






Procedure Initialise_TInfosC_Tva(var InfosC_Tva:TInfosC_Tva);
Begin
InfosC_Tva.ID:=0;
InfosC_Tva.Classe:='';
InfosC_Tva.Libelle:='';
end;
Procedure Remplit_TInfosC_Tva(DataSet:TDataSet;var InfosC_Tva:TInfosC_Tva);
Begin
Initialise_TInfosC_Tva(InfosC_Tva);
InfosC_Tva.ID:=DataSet.FindField('ID').AsInteger;
InfosC_Tva.Classe:=DataSet.FindField('Classe').AsString;
InfosC_Tva.Libelle:=DataSet.FindField('Libelle').AsString;
end;
Function Infos_TInfosC_Tva(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosC_Tva;
Begin
Initialise_TInfosC_Tva(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosC_Tva(DataSet,result);
end;
Procedure Initialise_TInfosConst(var InfosConst:TInfosConst);
Begin
InfosConst.ID:=0;
InfosConst.NomConst:='';
InfosConst.TypeConst:=0;
InfosConst.VAlpha:='';
InfosConst.VCurrency:=0;
InfosConst.VNumerique:=0.00;
InfosConst.VInteger:=0;
InfosConst.VBoolean:=false;
InfosConst.VDateHeure:=0;
end;
Procedure Remplit_TInfosConst(DataSet:TDataSet;var InfosConst:TInfosConst);
Begin
Initialise_TInfosConst(InfosConst);
InfosConst.ID:=DataSet.FindField('ID').AsInteger;
InfosConst.NomConst:=DataSet.FindField('NomConst').AsString;
InfosConst.TypeConst:=DataSet.FindField('Type').AsInteger;
InfosConst.VAlpha:=DataSet.FindField('VAlpha').AsString;
InfosConst.VCurrency:=DataSet.FindField('VCurrency').AsCurrency;
InfosConst.VNumerique:=DataSet.FindField('VNumerique').AsFloat;
InfosConst.VInteger:=DataSet.FindField('VInteger').AsInteger;
InfosConst.VBoolean:=DataSet.FindField('VBoolean').Asboolean;
InfosConst.VDateHeure:=DataSet.FindField('VDateHeure').AsDateTime;
end;
Function Infos_TInfosConst(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosConst;
Begin
Initialise_TInfosConst(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosConst(DataSet,result);
end;
Procedure Initialise_TInfosCretables(var InfosCretables:TInfosCretables);
Begin
InfosCretables.ID:=0;
InfosCretables.Nom_Table:='';
InfosCretables.RequeteCreationTable:='';
InfosCretables.ExerciceOuDossier:='';
end;
Procedure Remplit_TInfosCretables(DataSet:TDataSet;var InfosCretables:TInfosCretables);
Begin
Initialise_TInfosCretables(InfosCretables);
InfosCretables.ID:=DataSet.FindField('ID').AsInteger;
InfosCretables.Nom_Table:=DataSet.FindField('Nom_Table').AsString;
InfosCretables.RequeteCreationTable:=DataSet.FindField('RequeteCreationTable').AsVariant;
InfosCretables.ExerciceOuDossier:=DataSet.FindField('ExerciceOuDossier').AsString;
end;
Function Infos_TInfosCretables(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCretables;
Begin
Initialise_TInfosCretables(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosCretables(DataSet,result);
end;
Procedure Initialise_TInfosDev_Prix(var InfosDev_Prix:TInfosDev_Prix);
Begin
InfosDev_Prix.ID_Devise:=0;
InfosDev_Prix.Date:=0;
InfosDev_Prix.DeviseBase:=0.00;
InfosDev_Prix.DeviseEtranger:=0.00;
InfosDev_Prix.Qui:='';
InfosDev_Prix.Quand:=0;
end;
Procedure Remplit_TInfosDev_Prix(DataSet:TDataSet;var InfosDev_Prix:TInfosDev_Prix);
Begin
Initialise_TInfosDev_Prix(InfosDev_Prix);
InfosDev_Prix.ID_Devise:=DataSet.FindField('ID_Devise').AsInteger;
InfosDev_Prix.Date:=DataSet.FindField('Date').AsDateTime;
InfosDev_Prix.DeviseBase:=DataSet.FindField('DeviseBase').AsFloat;
InfosDev_Prix.DeviseEtranger:=DataSet.FindField('DeviseEtranger').AsFloat;
InfosDev_Prix.Qui:=DataSet.FindField('Qui').AsString;
InfosDev_Prix.Quand:=DataSet.FindField('Quand').AsDateTime;
end;
Function Infos_TInfosDev_Prix(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDev_Prix;
Begin
Initialise_TInfosDev_Prix(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosDev_Prix(DataSet,result);
end;
Procedure Initialise_TInfosDevise(var InfosDevise:TInfosDevise);
Begin
InfosDevise.ID:=0;
InfosDevise.Devise:='';
InfosDevise.Libelle:='';
InfosDevise.Qui:='';
InfosDevise.Quand:=0;
end;
Procedure Remplit_TInfosDevise(DataSet:TDataSet;var InfosDevise:TInfosDevise);
Begin
Initialise_TInfosDevise(InfosDevise);
InfosDevise.ID:=DataSet.FindField('ID').AsInteger;
InfosDevise.Devise:=DataSet.FindField('Devise').AsString;
InfosDevise.Libelle:=DataSet.FindField('Libelle').AsString;
InfosDevise.Qui:=DataSet.FindField('Qui').AsString;
InfosDevise.Quand:=DataSet.FindField('Quand').AsDateTime;
end;
Function Infos_TInfosDevise(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDevise;
Begin
Initialise_TInfosDevise(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosDevise(DataSet,result);
end;
Procedure Initialise_TInfosDicoE2(var InfosDicoE2:TInfosDicoE2);
Begin
InfosDicoE2.OBJID:=0;
InfosDicoE2.VERSION:=0;
InfosDicoE2.NAME:='';
InfosDicoE2.ALIASNAME:='';
InfosDicoE2.TYPEID:=0;
InfosDicoE2.MISCINFO1:=0;
InfosDicoE2.MISCINFO2:=0;
InfosDicoE2.SRCOBJID:=0;
InfosDicoE2.SRCVERSION:=0;
InfosDicoE2.DESTOBJID:=0;
InfosDicoE2.DESTVERSION:=0;
InfosDicoE2.OUTOFDATE:='';
InfosDicoE2.CREATEDATE:=0;
InfosDicoE2.LASTUPDATE:=0;
InfosDicoE2.INFOBLOB:='';
InfosDicoE2.MISCINFO3:=0;
end;
Procedure Remplit_TInfosDicoE2(DataSet:TDataSet;var InfosDicoE2:TInfosDicoE2);
Begin
Initialise_TInfosDicoE2(InfosDicoE2);
InfosDicoE2.OBJID:=DataSet.FindField('OBJID').AsInteger;
InfosDicoE2.VERSION:=DataSet.FindField('VERSION').AsInteger;
InfosDicoE2.NAME:=DataSet.FindField('NAME').AsString;
InfosDicoE2.ALIASNAME:=DataSet.FindField('ALIASNAME').AsString;
InfosDicoE2.TYPEID:=DataSet.FindField('TYPEID').AsInteger;
InfosDicoE2.MISCINFO1:=DataSet.FindField('MISCINFO1').AsInteger;
InfosDicoE2.MISCINFO2:=DataSet.FindField('MISCINFO2').AsInteger;
InfosDicoE2.SRCOBJID:=DataSet.FindField('SRCOBJID').AsInteger;
InfosDicoE2.SRCVERSION:=DataSet.FindField('SRCVERSION').AsInteger;
InfosDicoE2.DESTOBJID:=DataSet.FindField('DESTOBJID').AsInteger;
InfosDicoE2.DESTVERSION:=DataSet.FindField('DESTVERSION').AsInteger;
InfosDicoE2.OUTOFDATE:=DataSet.FindField('OUTOFDATE').AsString;
InfosDicoE2.CREATEDATE:=DataSet.FindField('CREATEDATE').AsDateTime;
InfosDicoE2.LASTUPDATE:=DataSet.FindField('LASTUPDATE').AsDateTime;
InfosDicoE2.INFOBLOB:=DataSet.FindField('INFOBLOB').AsVariant;
InfosDicoE2.MISCINFO3:=DataSet.FindField('MISCINFO3').AsInteger;
end;
Function Infos_TInfosDicoE2(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDicoE2;
Begin
Initialise_TInfosDicoE2(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosDicoE2(DataSet,result);
end;
Procedure Initialise_TInfosGestDossier(var InfosGestDossier:TInfosGestDossier);
Begin
InfosGestDossier.ID_Dossier:=0;
InfosGestDossier.ID_Table:=0;
InfosGestDossier.Nom_Dossier:='';
InfosGestDossier.Dir_Dossier:='';
InfosGestDossier.Nom_Exo:='';
InfosGestDossier.Dir_Exo:='';
InfosGestDossier.Annee_Dossier:=0;
InfosGestDossier.DateUtil:=0;
InfosGestDossier.Cloture:=false;
InfosGestDossier.EXO_BASE:='';
InfosGestDossier.EXO_SAISIE:='';
InfosGestDossier.DATE_DEB_EXO:=0;
InfosGestDossier.DATE_FIN_EXO:=0;
InfosGestDossier.DESIGNATION_DOSSIER:='';
end;
Procedure Remplit_TInfosGestDossier(DataSet:TDataSet;var InfosGestDossier:TInfosGestDossier);
Begin
Initialise_TInfosGestDossier(InfosGestDossier);
InfosGestDossier.ID_Dossier:=DataSet.FindField('ID_Dossier').AsInteger;
InfosGestDossier.ID_Table:=DataSet.FindField('ID_Table').AsInteger;
InfosGestDossier.Nom_Dossier:=DataSet.FindField('Nom_Dossier').AsString;
InfosGestDossier.Dir_Dossier:=DataSet.FindField('Dir_Dossier').AsString;
InfosGestDossier.Nom_Exo:=DataSet.FindField('Nom_Exo').AsString;
InfosGestDossier.Dir_Exo:=DataSet.FindField('Dir_Exo').AsString;
InfosGestDossier.Annee_Dossier:=DataSet.FindField('Annee_Dossier').AsDateTime;
InfosGestDossier.DateUtil:=DataSet.FindField('DateUtil').AsDateTime;
InfosGestDossier.Cloture:=DataSet.FindField('Cloture').Asboolean;
InfosGestDossier.EXO_BASE:=DataSet.FindField('EXO_BASE').AsString;
InfosGestDossier.EXO_SAISIE:=DataSet.FindField('EXO_SAISIE').AsString;
InfosGestDossier.DATE_DEB_EXO:=DataSet.FindField('DATE_DEB_EXO').AsDateTime;
InfosGestDossier.DATE_FIN_EXO:=DataSet.FindField('DATE_FIN_EXO').AsDateTime;
InfosGestDossier.DESIGNATION_DOSSIER:=DataSet.FindField('DESIGNATION_DOSSIER').AsString;
end;
Function Infos_TInfosGestDossier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosGestDossier;
Begin
Initialise_TInfosGestDossier(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosGestDossier(DataSet,result);
end;
Procedure Initialise_TInfosGestProg(var InfosGestProg:TInfosGestProg);
Begin
InfosGestProg.ID:=0.00;
InfosGestProg.DateProg:=0;
InfosGestProg.NumLicence:='';
InfosGestProg.NomLicence:='';
InfosGestProg.TypeLicence:='';
InfosGestProg.NumVersion:='';
InfosGestProg.NomUser:='';
InfosGestProg.TypeVersion:='';
InfosGestProg.DivGestProg:='';
InfosGestProg.Div2:='';
end;
Procedure Remplit_TInfosGestProg(DataSet:TDataSet;var InfosGestProg:TInfosGestProg);
Begin
Initialise_TInfosGestProg(InfosGestProg);
InfosGestProg.ID:=DataSet.FindField('ID').AsFloat;
InfosGestProg.DateProg:=DataSet.FindField('DateProg').AsDateTime;
InfosGestProg.NumLicence:=DataSet.FindField('NumLicence').AsString;
InfosGestProg.NomLicence:=DataSet.FindField('NomLicence').AsString;
InfosGestProg.TypeLicence:=DataSet.FindField('TypeLicence').AsString;
InfosGestProg.NumVersion:=DataSet.FindField('NumVersion').AsString;
InfosGestProg.NomUser:=DataSet.FindField('NomUser').AsString;
InfosGestProg.TypeVersion:=DataSet.FindField('TypeVersion').AsString;
InfosGestProg.DivGestProg:=DataSet.FindField('Div').AsString;
InfosGestProg.Div2:=DataSet.FindField('Div2').AsString;
end;
Function Infos_TInfosGestProg(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosGestProg;
Begin
Initialise_TInfosGestProg(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosGestProg(DataSet,result);
end;
Procedure Initialise_TInfosMessage(var InfosMessage:TInfosMessage);
Begin
InfosMessage.ID:=0;
InfosMessage.Groupe:='';
InfosMessage.Cle:='';
InfosMessage.Message:='';
InfosMessage.Aide:=0;
end;
Procedure Remplit_TInfosMessage(DataSet:TDataSet;var InfosMessage:TInfosMessage);
Begin
Initialise_TInfosMessage(InfosMessage);
InfosMessage.ID:=DataSet.FindField('ID').AsInteger;
InfosMessage.Groupe:=DataSet.FindField('Groupe').AsString;
InfosMessage.Cle:=DataSet.FindField('Cle').AsString;
InfosMessage.Message:=DataSet.FindField('Message').AsVariant;
InfosMessage.Aide:=DataSet.FindField('Aide').AsInteger;
end;
Function Infos_TInfosMessage(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosMessage;
Begin
Initialise_TInfosMessage(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosMessage(DataSet,result);
end;
Procedure Initialise_TInfosParamCpt(var InfosParamCpt:TInfosParamCpt);
Begin
InfosParamCpt.ID:=0;
InfosParamCpt.Regime:='';
InfosParamCpt.Famille:=0;
InfosParamCpt.Rac1:='';
InfosParamCpt.Rac2:='';
InfosParamCpt.Rac3:='';
InfosParamCpt.Rac4:='';
InfosParamCpt.Rac5:='';
InfosParamCpt.Rac6:='';
end;
Procedure Remplit_TInfosParamCpt(DataSet:TDataSet;var InfosParamCpt:TInfosParamCpt);
Begin
Initialise_TInfosParamCpt(InfosParamCpt);
InfosParamCpt.ID:=DataSet.FindField('ID').AsInteger;
InfosParamCpt.Regime:=DataSet.FindField('Regime').AsString;
InfosParamCpt.Famille:=DataSet.FindField('Famille').AsInteger;
InfosParamCpt.Rac1:=DataSet.FindField('Rac1').AsString;
InfosParamCpt.Rac2:=DataSet.FindField('Rac2').AsString;
InfosParamCpt.Rac3:=DataSet.FindField('Rac3').AsString;
InfosParamCpt.Rac4:=DataSet.FindField('Rac4').AsString;
InfosParamCpt.Rac5:=DataSet.FindField('Rac5').AsString;
InfosParamCpt.Rac6:=DataSet.FindField('Rac6').AsString;
end;
Function Infos_TInfosParamCpt(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamCpt;
Begin
Initialise_TInfosParamCpt(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosParamCpt(DataSet,result);
end;
Procedure Initialise_TInfosParamcpt_Export(var InfosParamcpt_Export:TInfosParamcpt_Export);
Begin
InfosParamcpt_Export.REGIME:='';
InfosParamcpt_Export.FAMILLE:=0.00;
InfosParamcpt_Export.RAC1:='';
InfosParamcpt_Export.RAC2:='';
InfosParamcpt_Export.RAC3:='';
InfosParamcpt_Export.RAC4:='';
InfosParamcpt_Export.RAC5:='';
InfosParamcpt_Export.RAC6:='';
end;
Procedure Remplit_TInfosParamcpt_Export(DataSet:TDataSet;var InfosParamcpt_Export:TInfosParamcpt_Export);
Begin
Initialise_TInfosParamcpt_Export(InfosParamcpt_Export);
InfosParamcpt_Export.REGIME:=DataSet.FindField('REGIME').AsString;
InfosParamcpt_Export.FAMILLE:=DataSet.FindField('FAMILLE').AsFloat;
InfosParamcpt_Export.RAC1:=DataSet.FindField('RAC1').AsString;
InfosParamcpt_Export.RAC2:=DataSet.FindField('RAC2').AsString;
InfosParamcpt_Export.RAC3:=DataSet.FindField('RAC3').AsString;
InfosParamcpt_Export.RAC4:=DataSet.FindField('RAC4').AsString;
InfosParamcpt_Export.RAC5:=DataSet.FindField('RAC5').AsString;
InfosParamcpt_Export.RAC6:=DataSet.FindField('RAC6').AsString;
end;
Function Infos_TInfosParamcpt_Export(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamcpt_Export;
Begin
Initialise_TInfosParamcpt_Export(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosParamcpt_Export(DataSet,result);
end;
Procedure Initialise_TInfosParamCpt_old(var InfosParamCpt_old:TInfosParamCpt_old);
Begin
InfosParamCpt_old.ID:=0;
InfosParamCpt_old.Regime:='';
InfosParamCpt_old.Famille:=0;
InfosParamCpt_old.Rac1:='';
InfosParamCpt_old.Rac2:='';
InfosParamCpt_old.Rac3:='';
InfosParamCpt_old.Rac4:='';
InfosParamCpt_old.Rac5:='';
InfosParamCpt_old.Rac6:='';
end;
Procedure Remplit_TInfosParamCpt_old(DataSet:TDataSet;var InfosParamCpt_old:TInfosParamCpt_old);
Begin
Initialise_TInfosParamCpt_old(InfosParamCpt_old);
InfosParamCpt_old.ID:=DataSet.FindField('ID').AsInteger;
InfosParamCpt_old.Regime:=DataSet.FindField('Regime').AsString;
InfosParamCpt_old.Famille:=DataSet.FindField('Famille').AsInteger;
InfosParamCpt_old.Rac1:=DataSet.FindField('Rac1').AsString;
InfosParamCpt_old.Rac2:=DataSet.FindField('Rac2').AsString;
InfosParamCpt_old.Rac3:=DataSet.FindField('Rac3').AsString;
InfosParamCpt_old.Rac4:=DataSet.FindField('Rac4').AsString;
InfosParamCpt_old.Rac5:=DataSet.FindField('Rac5').AsString;
InfosParamCpt_old.Rac6:=DataSet.FindField('Rac6').AsString;
end;
Function Infos_TInfosParamCpt_old(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamCpt_old;
Begin
Initialise_TInfosParamCpt_old(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosParamCpt_old(DataSet,result);
end;
Procedure Initialise_TInfosParamLia(var InfosParamLia:TInfosParamLia);
Begin
InfosParamLia.ID:=0;
InfosParamLia.TypeParamLia:='';
InfosParamLia.ID_Ligne:=0;
InfosParamLia.Libelle:='';
InfosParamLia.Col1:='';
InfosParamLia.Col2:='';
InfosParamLia.Col3:='';
InfosParamLia.Col4:='';
InfosParamLia.Col5:='';
InfosParamLia.Col6:='';
InfosParamLia.Col7:='';
InfosParamLia.Col8:='';
InfosParamLia.Col9:='';
InfosParamLia.Col10:='';
InfosParamLia.Col11:='';
InfosParamLia.Col12:='';
InfosParamLia.Col13:='';
InfosParamLia.Col14:='';
end;
Procedure Remplit_TInfosParamLia(DataSet:TDataSet;var InfosParamLia:TInfosParamLia);
Begin
Initialise_TInfosParamLia(InfosParamLia);
InfosParamLia.ID:=DataSet.FindField('ID').AsInteger;
InfosParamLia.TypeParamLia:=DataSet.FindField('Type').AsString;
InfosParamLia.ID_Ligne:=DataSet.FindField('ID_Ligne').AsInteger;
InfosParamLia.Libelle:=DataSet.FindField('Libelle').AsString;
InfosParamLia.Col1:=DataSet.FindField('Col1').AsString;
InfosParamLia.Col2:=DataSet.FindField('Col2').AsString;
InfosParamLia.Col3:=DataSet.FindField('Col3').AsString;
InfosParamLia.Col4:=DataSet.FindField('Col4').AsString;
InfosParamLia.Col5:=DataSet.FindField('Col5').AsString;
InfosParamLia.Col6:=DataSet.FindField('Col6').AsString;
InfosParamLia.Col7:=DataSet.FindField('Col7').AsString;
InfosParamLia.Col8:=DataSet.FindField('Col8').AsString;
InfosParamLia.Col9:=DataSet.FindField('Col9').AsString;
InfosParamLia.Col10:=DataSet.FindField('Col10').AsString;
InfosParamLia.Col11:=DataSet.FindField('Col11').AsString;
InfosParamLia.Col12:=DataSet.FindField('Col12').AsString;
InfosParamLia.Col13:=DataSet.FindField('Col13').AsString;
InfosParamLia.Col14:=DataSet.FindField('Col14').AsString;
end;
Function Infos_TInfosParamLia(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamLia;
Begin
Initialise_TInfosParamLia(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosParamLia(DataSet,result);
end;
Procedure Initialise_TInfosParamLiaOld(var InfosParamLiaOld:TInfosParamLiaOld);
Begin
InfosParamLiaOld.ID:=0;
InfosParamLiaOld.TypeParamLiaOld:='';
InfosParamLiaOld.ID_Ligne:=0;
InfosParamLiaOld.Libelle:='';
InfosParamLiaOld.Col1:='';
InfosParamLiaOld.Col2:='';
InfosParamLiaOld.Col3:='';
InfosParamLiaOld.Col4:='';
InfosParamLiaOld.Col5:='';
InfosParamLiaOld.Col6:='';
end;
Procedure Remplit_TInfosParamLiaOld(DataSet:TDataSet;var InfosParamLiaOld:TInfosParamLiaOld);
Begin
Initialise_TInfosParamLiaOld(InfosParamLiaOld);
InfosParamLiaOld.ID:=DataSet.FindField('ID').AsInteger;
InfosParamLiaOld.TypeParamLiaOld:=DataSet.FindField('Type').AsString;
InfosParamLiaOld.ID_Ligne:=DataSet.FindField('ID_Ligne').AsInteger;
InfosParamLiaOld.Libelle:=DataSet.FindField('Libelle').AsString;
InfosParamLiaOld.Col1:=DataSet.FindField('Col1').AsString;
InfosParamLiaOld.Col2:=DataSet.FindField('Col2').AsString;
InfosParamLiaOld.Col3:=DataSet.FindField('Col3').AsString;
InfosParamLiaOld.Col4:=DataSet.FindField('Col4').AsString;
InfosParamLiaOld.Col5:=DataSet.FindField('Col5').AsString;
InfosParamLiaOld.Col6:=DataSet.FindField('Col6').AsString;
end;
Function Infos_TInfosParamLiaOld(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParamLiaOld;
Begin
Initialise_TInfosParamLiaOld(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosParamLiaOld(DataSet,result);
end;
Procedure Initialise_TInfosPBilan(var InfosPBilan:TInfosPBilan);
Begin
InfosPBilan.Compte:='';
InfosPBilan.Intitule:='';
InfosPBilan.SoldeReport:='';
InfosPBilan.SoldeReportDebit:='';
InfosPBilan.SoldeReportCredit:='';
InfosPBilan.SoldeMouvement:='';
InfosPBilan.SoldeMouvementDebit:='';
InfosPBilan.SoldeMouvementCredit:='';
InfosPBilan.SoldeFin:='';
InfosPBilan.SoldeFinDebit:='';
InfosPBilan.SoldeFinCredit:='';
InfosPBilan.Regime:='';
InfosPBilan.AutreDebit:='';
InfosPBilan.AutreCredit:='';
InfosPBilan.AutreSolde:='';
end;
Procedure Remplit_TInfosPBilan(DataSet:TDataSet;var InfosPBilan:TInfosPBilan);
Begin
Initialise_TInfosPBilan(InfosPBilan);
InfosPBilan.Compte:=DataSet.FindField('Compte').AsString;
InfosPBilan.Intitule:=DataSet.FindField('Intitule').AsString;
InfosPBilan.SoldeReport:=DataSet.FindField('SoldeReport').AsString;
InfosPBilan.SoldeReportDebit:=DataSet.FindField('SoldeReportDebit').AsString;
InfosPBilan.SoldeReportCredit:=DataSet.FindField('SoldeReportCredit').AsString;
InfosPBilan.SoldeMouvement:=DataSet.FindField('SoldeMouvement').AsString;
InfosPBilan.SoldeMouvementDebit:=DataSet.FindField('SoldeMouvementDebit').AsString;
InfosPBilan.SoldeMouvementCredit:=DataSet.FindField('SoldeMouvementCredit').AsString;
InfosPBilan.SoldeFin:=DataSet.FindField('SoldeFin').AsString;
InfosPBilan.SoldeFinDebit:=DataSet.FindField('SoldeFinDebit').AsString;
InfosPBilan.SoldeFinCredit:=DataSet.FindField('SoldeFinCredit').AsString;
InfosPBilan.Regime:=DataSet.FindField('Regime').AsString;
InfosPBilan.AutreDebit:=DataSet.FindField('AutreDebit').AsString;
InfosPBilan.AutreCredit:=DataSet.FindField('AutreCredit').AsString;
InfosPBilan.AutreSolde:=DataSet.FindField('AutreSolde').AsString;
end;
Function Infos_TInfosPBilan(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPBilan;
Begin
Initialise_TInfosPBilan(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPBilan(DataSet,result);
end;
Procedure Initialise_TInfosPBilanOld(var InfosPBilanOld:TInfosPBilanOld);
Begin
InfosPBilanOld.Compte:='';
InfosPBilanOld.Intitule:='';
InfosPBilanOld.SoldeReport:='';
InfosPBilanOld.SoldeReportDebit:='';
InfosPBilanOld.SoldeReportCredit:='';
InfosPBilanOld.SoldeMouvement:='';
InfosPBilanOld.SoldeMouvementDebit:='';
InfosPBilanOld.SoldeMouvementCredit:='';
InfosPBilanOld.SoldeFin:='';
InfosPBilanOld.SoldeFinDebit:='';
InfosPBilanOld.SoldeFinCredit:='';
end;
Procedure Remplit_TInfosPBilanOld(DataSet:TDataSet;var InfosPBilanOld:TInfosPBilanOld);
Begin
Initialise_TInfosPBilanOld(InfosPBilanOld);
InfosPBilanOld.Compte:=DataSet.FindField('Compte').AsString;
InfosPBilanOld.Intitule:=DataSet.FindField('Intitule').AsString;
InfosPBilanOld.SoldeReport:=DataSet.FindField('SoldeReport').AsString;
InfosPBilanOld.SoldeReportDebit:=DataSet.FindField('SoldeReportDebit').AsString;
InfosPBilanOld.SoldeReportCredit:=DataSet.FindField('SoldeReportCredit').AsString;
InfosPBilanOld.SoldeMouvement:=DataSet.FindField('SoldeMouvement').AsString;
InfosPBilanOld.SoldeMouvementDebit:=DataSet.FindField('SoldeMouvementDebit').AsString;
InfosPBilanOld.SoldeMouvementCredit:=DataSet.FindField('SoldeMouvementCredit').AsString;
InfosPBilanOld.SoldeFin:=DataSet.FindField('SoldeFin').AsString;
InfosPBilanOld.SoldeFinDebit:=DataSet.FindField('SoldeFinDebit').AsString;
InfosPBilanOld.SoldeFinCredit:=DataSet.FindField('SoldeFinCredit').AsString;
end;
Function Infos_TInfosPBilanOld(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPBilanOld;
Begin
Initialise_TInfosPBilanOld(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPBilanOld(DataSet,result);
end;
Procedure Initialise_TInfosPeriodeValidite(var InfosPeriodeValidite:TInfosPeriodeValidite);
Begin
InfosPeriodeValidite.ID:=0.00;
InfosPeriodeValidite.DateDebut:=0;
InfosPeriodeValidite.DateFin:=0;
end;
Procedure Remplit_TInfosPeriodeValidite(DataSet:TDataSet;var InfosPeriodeValidite:TInfosPeriodeValidite);
Begin
Initialise_TInfosPeriodeValidite(InfosPeriodeValidite);
InfosPeriodeValidite.ID:=DataSet.FindField('ID').AsFloat;
InfosPeriodeValidite.DateDebut:=DataSet.FindField('DateDebut').AsDateTime;
InfosPeriodeValidite.DateFin:=DataSet.FindField('DateFin').AsDateTime;
end;
Function Infos_TInfosPeriodeValidite(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPeriodeValidite;
Begin
Initialise_TInfosPeriodeValidite(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPeriodeValidite(DataSet,result);
end;
Procedure Initialise_TInfosPlagesAmortissement(var InfosPlagesAmortissement:TInfosPlagesAmortissement);
Begin
InfosPlagesAmortissement.ID:=0.00;
InfosPlagesAmortissement.IDPeriode:=0.00;
InfosPlagesAmortissement.Coefficient:=0.00;
InfosPlagesAmortissement.IDPrecedent:=0.00;
InfosPlagesAmortissement.IDSuivant:=0.00;
InfosPlagesAmortissement.Duree:=0;
InfosPlagesAmortissement.DebutPlage:=0.00;
InfosPlagesAmortissement.FinPlage:=0.00;
end;
Procedure Remplit_TInfosPlagesAmortissement(DataSet:TDataSet;var InfosPlagesAmortissement:TInfosPlagesAmortissement);
Begin
Initialise_TInfosPlagesAmortissement(InfosPlagesAmortissement);
InfosPlagesAmortissement.ID:=DataSet.FindField('ID').AsFloat;
InfosPlagesAmortissement.IDPeriode:=DataSet.FindField('IDPeriode').AsFloat;
InfosPlagesAmortissement.Coefficient:=DataSet.FindField('Coefficient').AsFloat;
InfosPlagesAmortissement.IDPrecedent:=DataSet.FindField('IDPrecedent').AsFloat;
InfosPlagesAmortissement.IDSuivant:=DataSet.FindField('IDSuivant').AsFloat;
InfosPlagesAmortissement.Duree:=DataSet.FindField('Duree').AsDateTime;
InfosPlagesAmortissement.DebutPlage:=DataSet.FindField('DebutPlage').AsFloat;
InfosPlagesAmortissement.FinPlage:=DataSet.FindField('FinPlage').AsFloat;
end;
Function Infos_TInfosPlagesAmortissement(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPlagesAmortissement;
Begin
Initialise_TInfosPlagesAmortissement(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPlagesAmortissement(DataSet,result);
end;
Procedure Initialise_TInfosPlanCPTE(var InfosPlanCPTE:TInfosPlanCPTE);
Begin
InfosPlanCPTE.Regime:='';
InfosPlanCPTE.Compte:='';
InfosPlanCPTE.Libelle:='';
end;
Procedure Remplit_TInfosPlanCPTE(DataSet:TDataSet;var InfosPlanCPTE:TInfosPlanCPTE);
Begin
Initialise_TInfosPlanCPTE(InfosPlanCPTE);
InfosPlanCPTE.Regime:=DataSet.FindField('Regime').AsString;
InfosPlanCPTE.Compte:=DataSet.FindField('Compte').AsString;
InfosPlanCPTE.Libelle:=DataSet.FindField('Libelle').AsString;
end;
Function Infos_TInfosPlanCPTE(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPlanCPTE;
Begin
Initialise_TInfosPlanCPTE(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPlanCPTE(DataSet,result);
end;
Procedure Initialise_TInfosT_COM(var InfosT_COM:TInfosT_COM);
Begin
InfosT_COM.ID:=0;
InfosT_COM.NOM_VILLE:='';
InfosT_COM.CP:='';
InfosT_COM.CHEF_LIEU:='';
end;
Procedure Remplit_TInfosT_COM(DataSet:TDataSet;var InfosT_COM:TInfosT_COM);
Begin
Initialise_TInfosT_COM(InfosT_COM);
InfosT_COM.ID:=DataSet.FindField('ID').AsInteger;
InfosT_COM.NOM_VILLE:=DataSet.FindField('NOM_VILLE').AsString;
InfosT_COM.CP:=DataSet.FindField('CP').AsString;
InfosT_COM.CHEF_LIEU:=DataSet.FindField('CHEF_LIEU').AsString;
end;
Function Infos_TInfosT_COM(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosT_COM;
Begin
Initialise_TInfosT_COM(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosT_COM(DataSet,result);
end;
Procedure Initialise_TInfosAtelierDefaut(var InfosAtelierDefaut:TInfosAtelierDefaut);
Begin
InfosAtelierDefaut.ID:=0;
InfosAtelierDefaut.Code_Atelier:='';
InfosAtelierDefaut.libelle_Atelier:='';
InfosAtelierDefaut.Cpt_Plan:='';
InfosAtelierDefaut.Cpt_Racine:='';
InfosAtelierDefaut.Code_Activite:='';
InfosAtelierDefaut.Divers:='';
end;
Procedure Remplit_TInfosAtelierDefaut(DataSet:TDataSet;var InfosAtelierDefaut:TInfosAtelierDefaut);
Begin
Initialise_TInfosAtelierDefaut(InfosAtelierDefaut);
InfosAtelierDefaut.ID:=DataSet.FindField('ID').AsInteger;
InfosAtelierDefaut.Code_Atelier:=DataSet.FindField('Code_Atelier').AsString;
InfosAtelierDefaut.libelle_Atelier:=DataSet.FindField('libelle_Atelier').AsString;
InfosAtelierDefaut.Cpt_Plan:=DataSet.FindField('Cpt_Plan').AsString;
InfosAtelierDefaut.Cpt_Racine:=DataSet.FindField('Cpt_Racine').AsString;
InfosAtelierDefaut.Code_Activite:=DataSet.FindField('Code_Activite').AsString;
InfosAtelierDefaut.Divers:=DataSet.FindField('Divers').AsString;
end;
Function Infos_TInfosAtelierDefaut(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosAtelierDefaut;
Begin
Initialise_TInfosAtelierDefaut(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosAtelierDefaut(DataSet,result);
end;
Procedure Initialise_TInfosCdp(var InfosCdp:TInfosCdp);
Begin
InfosCdp.Id:=0;
InfosCdp.Cdp:='';
InfosCdp.LibelleCdp:='';
InfosCdp.Unite:='';
InfosCdp.LibelleUnite:='';
end;
Procedure Remplit_TInfosCdp(DataSet:TDataSet;var InfosCdp:TInfosCdp);
Begin
Initialise_TInfosCdp(InfosCdp);
InfosCdp.Id:=DataSet.FindField('Id').AsInteger;
InfosCdp.Cdp:=DataSet.FindField('Cdp').AsString;
InfosCdp.LibelleCdp:=DataSet.FindField('LibelleCdp').AsString;
InfosCdp.Unite:=DataSet.FindField('Unite').AsString;
InfosCdp.LibelleUnite:=DataSet.FindField('LibelleUnite').AsString;
end;
Function Infos_TInfosCdp(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCdp;
Begin
Initialise_TInfosCdp(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosCdp(DataSet,result);
end;
Procedure Initialise_TInfosCompteA(var InfosCompteA:TInfosCompteA);
Begin
InfosCompteA.Id:=0;
InfosCompteA.IDCdpPere:=0;
InfosCompteA.CompteA:='';
InfosCompteA.LibelleA:='';
InfosCompteA.Ratio:=0.00;
end;
Procedure Remplit_TInfosCompteA(DataSet:TDataSet;var InfosCompteA:TInfosCompteA);
Begin
Initialise_TInfosCompteA(InfosCompteA);
InfosCompteA.Id:=DataSet.FindField('Id').AsInteger;
InfosCompteA.IDCdpPere:=DataSet.FindField('IDCdpPere').AsInteger;
InfosCompteA.CompteA:=DataSet.FindField('CompteA').AsString;
InfosCompteA.LibelleA:=DataSet.FindField('LibelleA').AsString;
InfosCompteA.Ratio:=DataSet.FindField('Ratio').AsFloat;
end;
Function Infos_TInfosCompteA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCompteA;
Begin
Initialise_TInfosCompteA(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosCompteA(DataSet,result);
end;
Procedure Initialise_TInfosCpt_CptA(var InfosCpt_CptA:TInfosCpt_CptA);
Begin
InfosCpt_CptA.Id:=0;
InfosCpt_CptA.IDCompteA:=0;
InfosCpt_CptA.IDCdpPere:=0;
InfosCpt_CptA.Compte:='';
InfosCpt_CptA.CompteA:='';
InfosCpt_CptA.Ratio:=0.00;
end;
Procedure Remplit_TInfosCpt_CptA(DataSet:TDataSet;var InfosCpt_CptA:TInfosCpt_CptA);
Begin
Initialise_TInfosCpt_CptA(InfosCpt_CptA);
InfosCpt_CptA.Id:=DataSet.FindField('Id').AsInteger;
InfosCpt_CptA.IDCompteA:=DataSet.FindField('IDCompteA').AsInteger;
InfosCpt_CptA.IDCdpPere:=DataSet.FindField('IDCdpPere').AsInteger;
InfosCpt_CptA.Compte:=DataSet.FindField('Compte').AsString;
InfosCpt_CptA.CompteA:=DataSet.FindField('CompteA').AsString;
InfosCpt_CptA.Ratio:=DataSet.FindField('Ratio').AsFloat;
end;
Function Infos_TInfosCpt_CptA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCpt_CptA;
Begin
Initialise_TInfosCpt_CptA(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosCpt_CptA(DataSet,result);
end;
Procedure Initialise_TInfosCptAB_Cdp(var InfosCptAB_Cdp:TInfosCptAB_Cdp);
Begin
InfosCptAB_Cdp.Id:=0;
InfosCptAB_Cdp.IDCdp:=0;
InfosCptAB_Cdp.IDFils:=0;
InfosCptAB_Cdp.Cdp:='';
InfosCptAB_Cdp.Fils:='';
InfosCptAB_Cdp.Ratio:=0.00;
InfosCptAB_Cdp.TypeFils:=0;
end;
Procedure Remplit_TInfosCptAB_Cdp(DataSet:TDataSet;var InfosCptAB_Cdp:TInfosCptAB_Cdp);
Begin
Initialise_TInfosCptAB_Cdp(InfosCptAB_Cdp);
InfosCptAB_Cdp.Id:=DataSet.FindField('Id').AsInteger;
InfosCptAB_Cdp.IDCdp:=DataSet.FindField('IDCdp').AsInteger;
InfosCptAB_Cdp.IDFils:=DataSet.FindField('IDFils').AsInteger;
InfosCptAB_Cdp.Cdp:=DataSet.FindField('Cdp').AsString;
InfosCptAB_Cdp.Fils:=DataSet.FindField('Fils').AsString;
InfosCptAB_Cdp.Ratio:=DataSet.FindField('Ratio').AsFloat;
InfosCptAB_Cdp.TypeFils:=DataSet.FindField('TypeFils').AsInteger;
end;
Function Infos_TInfosCptAB_Cdp(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosCptAB_Cdp;
Begin
Initialise_TInfosCptAB_Cdp(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosCptAB_Cdp(DataSet,result);
end;
Procedure Initialise_TInfosDec_Tva(var InfosDec_Tva:TInfosDec_Tva);
Begin
InfosDec_Tva.ID:=0;
InfosDec_Tva.ID_Piece:=0;
InfosDec_Tva.ID_Ligne:=0;
InfosDec_Tva.TvaCode:='';
InfosDec_Tva.TvaType:='';
InfosDec_Tva.TvaDate:=0;
InfosDec_Tva.TvaMontantDebit:=0;
InfosDec_Tva.TvaMontantCredit:=0;
InfosDec_Tva.En_Attente:=false;
InfosDec_Tva.Part_Declaration:=0.00;
InfosDec_Tva.Divers:='';
end;
Procedure Remplit_TInfosDec_Tva(DataSet:TDataSet;var InfosDec_Tva:TInfosDec_Tva);
Begin
Initialise_TInfosDec_Tva(InfosDec_Tva);
InfosDec_Tva.ID:=DataSet.FindField('ID').AsInteger;
InfosDec_Tva.ID_Piece:=DataSet.FindField('ID_Piece').AsInteger;
InfosDec_Tva.ID_Ligne:=DataSet.FindField('ID_Ligne').AsInteger;
InfosDec_Tva.TvaCode:=DataSet.FindField('TvaCode').AsString;
InfosDec_Tva.TvaType:=DataSet.FindField('TvaType').AsString;
InfosDec_Tva.TvaDate:=DataSet.FindField('TvaDate').AsDateTime;
InfosDec_Tva.TvaMontantDebit:=DataSet.FindField('TvaMontantDebit').AsCurrency;
InfosDec_Tva.TvaMontantCredit:=DataSet.FindField('TvaMontantCredit').AsCurrency;
InfosDec_Tva.En_Attente:=DataSet.FindField('En_Attente').Asboolean;
InfosDec_Tva.Part_Declaration:=DataSet.FindField('Part_Declaration').AsFloat;
InfosDec_Tva.Divers:=DataSet.FindField('Divers').AsString;
end;
Function Infos_TInfosDec_Tva(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDec_Tva;
Begin
Initialise_TInfosDec_Tva(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosDec_Tva(DataSet,result);
end;
Procedure Initialise_TInfosDet_Cre(var InfosDet_Cre:TInfosDet_Cre);
Begin
InfosDet_Cre.ID_Ecriture:=0;
InfosDet_Cre.Compte:='';
InfosDet_Cre.Creance:=false;
InfosDet_Cre.Montant:=0.00;
end;
Procedure Remplit_TInfosDet_Cre(DataSet:TDataSet;var InfosDet_Cre:TInfosDet_Cre);
Begin
Initialise_TInfosDet_Cre(InfosDet_Cre);
InfosDet_Cre.ID_Ecriture:=DataSet.FindField('ID_Ecriture').AsInteger;
InfosDet_Cre.Compte:=DataSet.FindField('Compte').AsString;
InfosDet_Cre.Creance:=DataSet.FindField('Creance').Asboolean;
InfosDet_Cre.Montant:=DataSet.FindField('Montant').AsFloat;
end;
Function Infos_TInfosDet_Cre(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDet_Cre;
Begin
Initialise_TInfosDet_Cre(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosDet_Cre(DataSet,result);
end;
Procedure Initialise_TInfosEcheance(var InfosEcheance:TInfosEcheance);
Begin
InfosEcheance.ID:=0;
InfosEcheance.ID_Ecriture:=0;
InfosEcheance.Date:=0;
InfosEcheance.Creance:=false;
InfosEcheance.SaiseMontant:=false;
InfosEcheance.PourCent:=0.00;
InfosEcheance.Montant:=0.00;
end;
Procedure Remplit_TInfosEcheance(DataSet:TDataSet;var InfosEcheance:TInfosEcheance);
Begin
Initialise_TInfosEcheance(InfosEcheance);
InfosEcheance.ID:=DataSet.FindField('ID').AsInteger;
InfosEcheance.ID_Ecriture:=DataSet.FindField('ID_Ecriture').AsInteger;
InfosEcheance.Date:=DataSet.FindField('Date').AsDateTime;
InfosEcheance.Creance:=DataSet.FindField('Creance').Asboolean;
InfosEcheance.SaiseMontant:=DataSet.FindField('SaiseMontant').Asboolean;
InfosEcheance.PourCent:=DataSet.FindField('PourCent').AsFloat;
InfosEcheance.Montant:=DataSet.FindField('Montant').AsFloat;
end;
Function Infos_TInfosEcheance(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosEcheance;
Begin
Initialise_TInfosEcheance(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosEcheance(DataSet,result);
end;
Procedure Initialise_TInfosEchEmp(var InfosEchEmp:TInfosEchEmp);
Begin
InfosEchEmp.Id_Annuite:=0;
InfosEchEmp.Id_Emp:=0;
InfosEchEmp.Date:=0;
InfosEchEmp.Annuite:=0;
InfosEchEmp.Capital:=0;
InfosEchEmp.Interets:=0;
InfosEchEmp.Assurances:=0;
InfosEchEmp.Frais_Divers:=0;
InfosEchEmp.Capital_Restant_du:=0;
InfosEchEmp.Rembourse:=false;
InfosEchEmp.Annule:=false;
InfosEchEmp.DateRemboursement:=0;
InfosEchEmp.Reference:='';
end;
Procedure Remplit_TInfosEchEmp(DataSet:TDataSet;var InfosEchEmp:TInfosEchEmp);
Begin
Initialise_TInfosEchEmp(InfosEchEmp);
InfosEchEmp.Id_Annuite:=DataSet.FindField('Id_Annuite').AsInteger;
InfosEchEmp.Id_Emp:=DataSet.FindField('Id_Emp').AsInteger;
InfosEchEmp.Date:=DataSet.FindField('Date').AsDateTime;
InfosEchEmp.Annuite:=DataSet.FindField('Annuite').AsCurrency;
InfosEchEmp.Capital:=DataSet.FindField('Capital').AsCurrency;
InfosEchEmp.Interets:=DataSet.FindField('Interets').AsCurrency;
InfosEchEmp.Assurances:=DataSet.FindField('Assurances').AsCurrency;
InfosEchEmp.Frais_Divers:=DataSet.FindField('Frais_Divers').AsCurrency;
InfosEchEmp.Capital_Restant_du:=DataSet.FindField('Capital_Restant_du').AsCurrency;
InfosEchEmp.Rembourse:=DataSet.FindField('Rembourse').Asboolean;
InfosEchEmp.Annule:=DataSet.FindField('Annule').Asboolean;
InfosEchEmp.DateRemboursement:=DataSet.FindField('DateRemboursement').AsDateTime;
InfosEchEmp.Reference:=DataSet.FindField('Reference').AsString;
end;
Function Infos_TInfosEchEmp(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosEchEmp;
Begin
Initialise_TInfosEchEmp(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosEchEmp(DataSet,result);
end;
Procedure Initialise_TInfosEcriture(var InfosEcriture:TInfosEcriture);
Begin
InfosEcriture.ID:=0;
InfosEcriture.ID_Piece:=0;
InfosEcriture.TypeLigne:='';
InfosEcriture.ID_Ligne:=0;
InfosEcriture.Date:=0;
InfosEcriture.Compte:='';
InfosEcriture.Tiers:='';
InfosEcriture.Libelle:='';
InfosEcriture.Qt1:=0.00;
InfosEcriture.Qt2:=0.00;
InfosEcriture.DebitSaisie:=0;
InfosEcriture.CreditSaisie:=0;
InfosEcriture.ID_Devise:=0;
InfosEcriture.Debit:=0;
InfosEcriture.Credit:=0;
InfosEcriture.TvaCode:='';
InfosEcriture.TvaType:='';
InfosEcriture.TvaTaux:=0.00;
InfosEcriture.TvaDate:=0;
InfosEcriture.Rapprochement:='';
InfosEcriture.Validation:=0;
InfosEcriture.Qui:='';
InfosEcriture.Quand:=0;
InfosEcriture.Num_Cheque:='';
InfosEcriture.Table_Gen:='';
InfosEcriture.Champ_Gen:='';
InfosEcriture.Val_Champ_Gen:='';
InfosEcriture.ID_GESTCO:=0.00;
InfosEcriture.CODE_GESTCO:='';
InfosEcriture.Montant_Tva:=0;
InfosEcriture.ID_GESTANAL:=0;
InfosEcriture.CODE_GESTANAL:='';
end;
Procedure Remplit_TInfosEcriture(DataSet:TDataSet;var InfosEcriture:TInfosEcriture);
Begin
Initialise_TInfosEcriture(InfosEcriture);
InfosEcriture.ID:=DataSet.FindField('ID').AsInteger;
InfosEcriture.ID_Piece:=DataSet.FindField('ID_Piece').AsInteger;
InfosEcriture.TypeLigne:=DataSet.FindField('TypeLigne').AsString;
InfosEcriture.ID_Ligne:=DataSet.FindField('ID_Ligne').AsInteger;
InfosEcriture.Date:=DataSet.FindField('Date').AsDateTime;
InfosEcriture.Compte:=DataSet.FindField('Compte').AsString;
InfosEcriture.Tiers:=DataSet.FindField('Tiers').AsString;
InfosEcriture.Libelle:=DataSet.FindField('Libelle').AsString;
InfosEcriture.Qt1:=DataSet.FindField('Qt1').AsFloat;
InfosEcriture.Qt2:=DataSet.FindField('Qt2').AsFloat;
InfosEcriture.DebitSaisie:=DataSet.FindField('DebitSaisie').AsCurrency;
InfosEcriture.CreditSaisie:=DataSet.FindField('CreditSaisie').AsCurrency;
InfosEcriture.ID_Devise:=DataSet.FindField('ID_Devise').AsInteger;
InfosEcriture.Debit:=DataSet.FindField('Debit').AsCurrency;
InfosEcriture.Credit:=DataSet.FindField('Credit').AsCurrency;
InfosEcriture.TvaCode:=DataSet.FindField('TvaCode').AsString;
InfosEcriture.TvaType:=DataSet.FindField('TvaType').AsString;
InfosEcriture.TvaTaux:=DataSet.FindField('TvaTaux').AsFloat;
InfosEcriture.TvaDate:=DataSet.FindField('TvaDate').AsDateTime;
InfosEcriture.Rapprochement:=DataSet.FindField('Rapprochement').AsString;
InfosEcriture.Validation:=DataSet.FindField('Validation').AsDateTime;
InfosEcriture.Qui:=DataSet.FindField('Qui').AsString;
InfosEcriture.Quand:=DataSet.FindField('Quand').AsDateTime;
InfosEcriture.Num_Cheque:=DataSet.FindField('Num_Cheque').AsString;
InfosEcriture.Table_Gen:=DataSet.FindField('Table_Gen').AsString;
InfosEcriture.Champ_Gen:=DataSet.FindField('Champ_Gen').AsString;
InfosEcriture.Val_Champ_Gen:=DataSet.FindField('Val_Champ_Gen').AsString;
InfosEcriture.ID_GESTCO:=DataSet.FindField('ID_GESTCO').AsFloat;
InfosEcriture.CODE_GESTCO:=DataSet.FindField('CODE_GESTCO').AsString;
InfosEcriture.Montant_Tva:=DataSet.FindField('Montant_Tva').AsCurrency;
InfosEcriture.ID_GESTANAL:=DataSet.FindField('ID_GESTANAL').AsInteger;
InfosEcriture.CODE_GESTANAL:=DataSet.FindField('CODE_GESTANAL').AsString;
end;
Function Infos_TInfosEcriture(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosEcriture;
Begin
Initialise_TInfosEcriture(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosEcriture(DataSet,result);
end;
Procedure Initialise_TInfosEmprunts(var InfosEmprunts:TInfosEmprunts);
Begin
InfosEmprunts.ID:=0;
InfosEmprunts.Code_Emp:='';
InfosEmprunts.Compte_Emp:='';
InfosEmprunts.Designation_Emp:='';
InfosEmprunts.CapiResteDu_Emp:=0;
InfosEmprunts.CapiTotal_Emp:=0;
InfosEmprunts.CodeGr:='';
InfosEmprunts.DateRealisation:=0;
InfosEmprunts.NbPeriode:=0.00;
InfosEmprunts.P1:=0.00;
InfosEmprunts.PP1:=0.00;
InfosEmprunts.P2:=0.00;
InfosEmprunts.PP2:=0.00;
InfosEmprunts.P3:=0.00;
InfosEmprunts.PP3:=0.00;
InfosEmprunts.TypeRb:='';
InfosEmprunts.PeriodeRb:='';
InfosEmprunts.Differe:=0.00;
InfosEmprunts.FraisAnnexe:=0.00;
InfosEmprunts.Assurance:=0.00;
InfosEmprunts.DatePremEcheance:=0;
InfosEmprunts.CapitalRbPE:=0;
InfosEmprunts.InteretRbPE:=0;
InfosEmprunts.NbRbFait:=0.00;
InfosEmprunts.Banque:='';
InfosEmprunts.Actif:=false;
end;
Procedure Remplit_TInfosEmprunts(DataSet:TDataSet;var InfosEmprunts:TInfosEmprunts);
Begin
Initialise_TInfosEmprunts(InfosEmprunts);
InfosEmprunts.ID:=DataSet.FindField('ID').AsInteger;
InfosEmprunts.Code_Emp:=DataSet.FindField('Code_Emp').AsString;
InfosEmprunts.Compte_Emp:=DataSet.FindField('Compte_Emp').AsString;
InfosEmprunts.Designation_Emp:=DataSet.FindField('Designation_Emp').AsString;
InfosEmprunts.CapiResteDu_Emp:=DataSet.FindField('CapiResteDu_Emp').AsCurrency;
InfosEmprunts.CapiTotal_Emp:=DataSet.FindField('CapiTotal_Emp').AsCurrency;
InfosEmprunts.CodeGr:=DataSet.FindField('CodeGr').AsString;
InfosEmprunts.DateRealisation:=DataSet.FindField('DateRealisation').AsDateTime;
InfosEmprunts.NbPeriode:=DataSet.FindField('NbPeriode').AsFloat;
InfosEmprunts.P1:=DataSet.FindField('P1').AsFloat;
InfosEmprunts.PP1:=DataSet.FindField('PP1').AsFloat;
InfosEmprunts.P2:=DataSet.FindField('P2').AsFloat;
InfosEmprunts.PP2:=DataSet.FindField('PP2').AsFloat;
InfosEmprunts.P3:=DataSet.FindField('P3').AsFloat;
InfosEmprunts.PP3:=DataSet.FindField('PP3').AsFloat;
InfosEmprunts.TypeRb:=DataSet.FindField('TypeRb').AsString;
InfosEmprunts.PeriodeRb:=DataSet.FindField('PeriodeRb').AsString;
InfosEmprunts.Differe:=DataSet.FindField('Differe').AsFloat;
InfosEmprunts.FraisAnnexe:=DataSet.FindField('FraisAnnexe').AsFloat;
InfosEmprunts.Assurance:=DataSet.FindField('Assurance').AsFloat;
InfosEmprunts.DatePremEcheance:=DataSet.FindField('DatePremEcheance').AsDateTime;
InfosEmprunts.CapitalRbPE:=DataSet.FindField('CapitalRbPE').AsCurrency;
InfosEmprunts.InteretRbPE:=DataSet.FindField('InteretRbPE').AsCurrency;
InfosEmprunts.NbRbFait:=DataSet.FindField('NbRbFait').AsFloat;
InfosEmprunts.Banque:=DataSet.FindField('Banque').AsString;
InfosEmprunts.Actif:=DataSet.FindField('Actif').Asboolean;
end;
Function Infos_TInfosEmprunts(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosEmprunts;
Begin
Initialise_TInfosEmprunts(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosEmprunts(DataSet,result);
end;
Procedure Initialise_TInfosGDossier(var InfosGDossier:TInfosGDossier);
Begin
InfosGDossier.ID_Dossier:=0;
InfosGDossier.ID_Table:=0;
InfosGDossier.Nom_Dossier:='';
InfosGDossier.Dir_Dossier:='';
InfosGDossier.Nom_Exo:='';
InfosGDossier.Dir_Exo:='';
InfosGDossier.Annee_Dossier:=0;
InfosGDossier.DateUtil:=0;
InfosGDossier.Cloture:=false;
InfosGDossier.EXO_BASE:='';
InfosGDossier.EXO_SAISIE:='';
InfosGDossier.DATE_DEB_EXO:=0;
InfosGDossier.DATE_FIN_EXO:=0;
InfosGDossier.DESIGNATION_DOSSIER:='';
end;
Procedure Remplit_TInfosGDossier(DataSet:TDataSet;var InfosGDossier:TInfosGDossier);
Begin
Initialise_TInfosGDossier(InfosGDossier);
InfosGDossier.ID_Dossier:=DataSet.FindField('ID_Dossier').AsInteger;
InfosGDossier.ID_Table:=DataSet.FindField('ID_Table').AsInteger;
InfosGDossier.Nom_Dossier:=DataSet.FindField('Nom_Dossier').AsString;
InfosGDossier.Dir_Dossier:=DataSet.FindField('Dir_Dossier').AsString;
InfosGDossier.Nom_Exo:=DataSet.FindField('Nom_Exo').AsString;
InfosGDossier.Dir_Exo:=DataSet.FindField('Dir_Exo').AsString;
InfosGDossier.Annee_Dossier:=DataSet.FindField('Annee_Dossier').AsDateTime;
InfosGDossier.DateUtil:=DataSet.FindField('DateUtil').AsDateTime;
InfosGDossier.Cloture:=DataSet.FindField('Cloture').Asboolean;
InfosGDossier.EXO_BASE:=DataSet.FindField('EXO_BASE').AsString;
InfosGDossier.EXO_SAISIE:=DataSet.FindField('EXO_SAISIE').AsString;
InfosGDossier.DATE_DEB_EXO:=DataSet.FindField('DATE_DEB_EXO').AsDateTime;
InfosGDossier.DATE_FIN_EXO:=DataSet.FindField('DATE_FIN_EXO').AsDateTime;
InfosGDossier.DESIGNATION_DOSSIER:=DataSet.FindField('DESIGNATION_DOSSIER').AsString;
end;
Function Infos_TInfosGDossier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosGDossier;
Begin
Initialise_TInfosGDossier(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosGDossier(DataSet,result);
end;
Procedure Initialise_TInfosH_PieceTva(var InfosH_PieceTva:TInfosH_PieceTva);
Begin
InfosH_PieceTva.ID:=0;
InfosH_PieceTva.ID_Declaration:=0;
InfosH_PieceTva.Reference_OD:='';
InfosH_PieceTva.Debut_Periode:=0;
InfosH_PieceTva.Fin_Periode:=0;
InfosH_PieceTva.Verrouillee:=false;
InfosH_PieceTva.Deverrouillable:=false;
InfosH_PieceTva.VerrouillageManuel:=false;
InfosH_PieceTva.Divers_Bool:=false;
InfosH_PieceTva.Divers_Str:='';
end;
Procedure Remplit_TInfosH_PieceTva(DataSet:TDataSet;var InfosH_PieceTva:TInfosH_PieceTva);
Begin
Initialise_TInfosH_PieceTva(InfosH_PieceTva);
InfosH_PieceTva.ID:=DataSet.FindField('ID').AsInteger;
InfosH_PieceTva.ID_Declaration:=DataSet.FindField('ID_Declaration').AsInteger;
InfosH_PieceTva.Reference_OD:=DataSet.FindField('Reference_OD').AsString;
InfosH_PieceTva.Debut_Periode:=DataSet.FindField('Debut_Periode').AsDateTime;
InfosH_PieceTva.Fin_Periode:=DataSet.FindField('Fin_Periode').AsDateTime;
InfosH_PieceTva.Verrouillee:=DataSet.FindField('Verrouillee').Asboolean;
InfosH_PieceTva.Deverrouillable:=DataSet.FindField('Deverrouillable').Asboolean;
InfosH_PieceTva.VerrouillageManuel:=DataSet.FindField('VerrouillageManuel').Asboolean;
InfosH_PieceTva.Divers_Bool:=DataSet.FindField('Divers_Bool').Asboolean;
InfosH_PieceTva.Divers_Str:=DataSet.FindField('Divers_Str').AsString;
end;
Function Infos_TInfosH_PieceTva(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosH_PieceTva;
Begin
Initialise_TInfosH_PieceTva(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosH_PieceTva(DataSet,result);
end;
Procedure Initialise_TInfosH_TVA(var InfosH_TVA:TInfosH_TVA);
Begin
InfosH_TVA.ID:=0;
InfosH_TVA.ID_Ecriture:=0;
InfosH_TVA.ID_Piece:=0;
InfosH_TVA.ID_Declaration:=0;
InfosH_TVA.Part_Declaree:=0.00;
InfosH_TVA.Debut_Periode:=0;
InfosH_TVA.Fin_Periode:=0;
InfosH_TVA.Verrouillee:=false;
InfosH_TVA.Deverrouillable:=false;
InfosH_TVA.En_Attente:=false;
InfosH_TVA.Date_Tva:=0;
InfosH_TVA.Reference_OD:='';
InfosH_TVA.MontantTVA:=0;
InfosH_TVA.HTDeclare:=0;
InfosH_TVA.Divers:='';
InfosH_TVA.CodeCompensation:='';
InfosH_TVA.Taux:=0.00;
end;
Procedure Remplit_TInfosH_TVA(DataSet:TDataSet;var InfosH_TVA:TInfosH_TVA);
Begin
Initialise_TInfosH_TVA(InfosH_TVA);
InfosH_TVA.ID:=DataSet.FindField('ID').AsInteger;
InfosH_TVA.ID_Ecriture:=DataSet.FindField('ID_Ecriture').AsInteger;
InfosH_TVA.ID_Piece:=DataSet.FindField('ID_Piece').AsInteger;
InfosH_TVA.ID_Declaration:=DataSet.FindField('ID_Declaration').AsInteger;
InfosH_TVA.Part_Declaree:=DataSet.FindField('Part_Declaree').AsFloat;
InfosH_TVA.Debut_Periode:=DataSet.FindField('Debut_Periode').AsDateTime;
InfosH_TVA.Fin_Periode:=DataSet.FindField('Fin_Periode').AsDateTime;
InfosH_TVA.Verrouillee:=DataSet.FindField('Verrouillee').Asboolean;
InfosH_TVA.Deverrouillable:=DataSet.FindField('Deverrouillable').Asboolean;
InfosH_TVA.En_Attente:=DataSet.FindField('En_Attente').Asboolean;
InfosH_TVA.Date_Tva:=DataSet.FindField('Date_Tva').AsDateTime;
InfosH_TVA.Reference_OD:=DataSet.FindField('Reference_OD').AsString;
InfosH_TVA.MontantTVA:=DataSet.FindField('MontantTVA').AsCurrency;
InfosH_TVA.HTDeclare:=DataSet.FindField('HTDeclare').AsCurrency;
InfosH_TVA.Divers:=DataSet.FindField('Divers').AsString;
InfosH_TVA.CodeCompensation:=DataSet.FindField('CodeCompensation').AsString;
InfosH_TVA.Taux:=DataSet.FindField('Taux').AsFloat;
end;
Function Infos_TInfosH_TVA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosH_TVA;
Begin
Initialise_TInfosH_TVA(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosH_TVA(DataSet,result);
end;
Procedure Initialise_TInfosH_Tva_Fin(var InfosH_Tva_Fin:TInfosH_Tva_Fin);
Begin
InfosH_Tva_Fin.ID:=0;
InfosH_Tva_Fin.Id_Declaration:=0;
InfosH_Tva_Fin.TypeSolde:=0;
InfosH_Tva_Fin.Compte:='';
InfosH_Tva_Fin.Total:=0;
InfosH_Tva_Fin.SensCredit:=0;
InfosH_Tva_Fin.ATraiter:=false;
end;
Procedure Remplit_TInfosH_Tva_Fin(DataSet:TDataSet;var InfosH_Tva_Fin:TInfosH_Tva_Fin);
Begin
Initialise_TInfosH_Tva_Fin(InfosH_Tva_Fin);
InfosH_Tva_Fin.ID:=DataSet.FindField('ID').AsInteger;
InfosH_Tva_Fin.Id_Declaration:=DataSet.FindField('Id_Declaration').AsInteger;
InfosH_Tva_Fin.TypeSolde:=DataSet.FindField('TypeSolde').AsInteger;
InfosH_Tva_Fin.Compte:=DataSet.FindField('Compte').AsString;
InfosH_Tva_Fin.Total:=DataSet.FindField('Total').AsCurrency;
InfosH_Tva_Fin.SensCredit:=DataSet.FindField('SensCredit').AsInteger;
InfosH_Tva_Fin.ATraiter:=DataSet.FindField('ATraiter').Asboolean;
end;
Function Infos_TInfosH_Tva_Fin(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosH_Tva_Fin;
Begin
Initialise_TInfosH_Tva_Fin(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosH_Tva_Fin(DataSet,result);
end;
Procedure Initialise_TInfosH_Tva_Report(var InfosH_Tva_Report:TInfosH_Tva_Report);
Begin
InfosH_Tva_Report.ID:=0;
InfosH_Tva_Report.Id_Declaration:=0;
InfosH_Tva_Report.Compte:='';
InfosH_Tva_Report.Solde:=0;
InfosH_Tva_Report.SensCredit:=false;
InfosH_Tva_Report.ATraiter:=false;
InfosH_Tva_Report.Code_Choix:=0;
end;
Procedure Remplit_TInfosH_Tva_Report(DataSet:TDataSet;var InfosH_Tva_Report:TInfosH_Tva_Report);
Begin
Initialise_TInfosH_Tva_Report(InfosH_Tva_Report);
InfosH_Tva_Report.ID:=DataSet.FindField('ID').AsInteger;
InfosH_Tva_Report.Id_Declaration:=DataSet.FindField('Id_Declaration').AsInteger;
InfosH_Tva_Report.Compte:=DataSet.FindField('Compte').AsString;
InfosH_Tva_Report.Solde:=DataSet.FindField('Solde').AsCurrency;
InfosH_Tva_Report.SensCredit:=DataSet.FindField('SensCredit').Asboolean;
InfosH_Tva_Report.ATraiter:=DataSet.FindField('ATraiter').Asboolean;
InfosH_Tva_Report.Code_Choix:=DataSet.FindField('Code_Choix').AsInteger;
end;
Function Infos_TInfosH_Tva_Report(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosH_Tva_Report;
Begin
Initialise_TInfosH_Tva_Report(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosH_Tva_Report(DataSet,result);
end;
Procedure Initialise_TInfosImmos(var InfosImmos:TInfosImmos);
Begin
InfosImmos.ID:=0;
InfosImmos.Libelle:='';
InfosImmos.Ecriture_Achat:=0;
InfosImmos.Ecriture_Cession:=0;
InfosImmos.Compte:='';
InfosImmos.Code:='';
InfosImmos.Sous_Code:='';
InfosImmos.Date_Org:=0;
InfosImmos.Valeur_Org:=0;
InfosImmos.Valeur_Venale:=0;
InfosImmos.Duree:=0;
InfosImmos.Valeur_a_Amortir:=0;
InfosImmos.Date_Achat:=0;
InfosImmos.Date_Mise_en_Service:=0;
InfosImmos.Duree_Amt:=0;
InfosImmos.Type_Amt:='';
InfosImmos.Deduc_Invest:=false;
InfosImmos.Mt_Deduc_Invest:=0;
InfosImmos.Reprise_deduc_invest:=0;
InfosImmos.Valeur_Nette:=0;
InfosImmos.Amort_Eco:=0;
InfosImmos.Amort_Derog:=0;
InfosImmos.Mt_Cession:=0;
InfosImmos.Date_Cession:=0;
InfosImmos.Rebut:=false;
InfosImmos.Achat_dans_Annee:=false;
InfosImmos.Cession_dans_Annee:=false;
InfosImmos.Duree_Restante:=0;
InfosImmos.Simulation:='';
InfosImmos.Sous_Compte:=false;
InfosImmos.Maxi:=0;
InfosImmos.Mini:=0;
InfosImmos.Choix:=0;
InfosImmos.Eco:=0;
InfosImmos.Terminee:=false;
InfosImmos.EnCours:=false;
InfosImmos.CodeTerminee:='';
InfosImmos.CompteTerminee:='';
InfosImmos.TauxAmo:=0.00;
InfosImmos.Tiers:='';
InfosImmos.ReferenceFacture:='';
InfosImmos.MontantTTC:=0;
InfosImmos.SousCodeTerminee:='';
end;
Procedure Remplit_TInfosImmos(DataSet:TDataSet;var InfosImmos:TInfosImmos);
Begin
Initialise_TInfosImmos(InfosImmos);
InfosImmos.ID:=DataSet.FindField('ID').AsInteger;
InfosImmos.Libelle:=DataSet.FindField('Libelle').AsString;
InfosImmos.Ecriture_Achat:=DataSet.FindField('Ecriture_Achat').AsInteger;
InfosImmos.Ecriture_Cession:=DataSet.FindField('Ecriture_Cession').AsInteger;
InfosImmos.Compte:=DataSet.FindField('Compte').AsString;
InfosImmos.Code:=DataSet.FindField('Code').AsString;
InfosImmos.Sous_Code:=DataSet.FindField('Sous_Code').AsString;
InfosImmos.Date_Org:=DataSet.FindField('Date_Org').AsDateTime;
InfosImmos.Valeur_Org:=DataSet.FindField('Valeur_Org').AsCurrency;
InfosImmos.Valeur_Venale:=DataSet.FindField('Valeur_Venale').AsCurrency;
InfosImmos.Duree:=DataSet.FindField('Duree').AsInteger;
InfosImmos.Valeur_a_Amortir:=DataSet.FindField('Valeur_a_Amortir').AsCurrency;
InfosImmos.Date_Achat:=DataSet.FindField('Date_Achat').AsDateTime;
InfosImmos.Date_Mise_en_Service:=DataSet.FindField('Date_Mise_en_Service').AsDateTime;
InfosImmos.Duree_Amt:=DataSet.FindField('Duree_Amt').AsInteger;
InfosImmos.Type_Amt:=DataSet.FindField('Type_Amt').AsString;
InfosImmos.Deduc_Invest:=DataSet.FindField('Deduc_Invest').Asboolean;
InfosImmos.Mt_Deduc_Invest:=DataSet.FindField('Mt_Deduc_Invest').AsCurrency;
InfosImmos.Reprise_deduc_invest:=DataSet.FindField('Reprise_deduc_invest').AsCurrency;
InfosImmos.Valeur_Nette:=DataSet.FindField('Valeur_Nette').AsCurrency;
InfosImmos.Amort_Eco:=DataSet.FindField('Amort_Eco').AsCurrency;
InfosImmos.Amort_Derog:=DataSet.FindField('Amort_Derog').AsCurrency;
InfosImmos.Mt_Cession:=DataSet.FindField('Mt_Cession').AsCurrency;
InfosImmos.Date_Cession:=DataSet.FindField('Date_Cession').AsDateTime;
InfosImmos.Rebut:=DataSet.FindField('Rebut').Asboolean;
InfosImmos.Achat_dans_Annee:=DataSet.FindField('Achat_dans_Annee').Asboolean;
InfosImmos.Cession_dans_Annee:=DataSet.FindField('Cession_dans_Annee').Asboolean;
InfosImmos.Duree_Restante:=DataSet.FindField('Duree_Restante').AsInteger;
InfosImmos.Simulation:=DataSet.FindField('Simulation').AsString;
InfosImmos.Sous_Compte:=DataSet.FindField('Sous_Compte').Asboolean;
InfosImmos.Maxi:=DataSet.FindField('Maxi').AsCurrency;
InfosImmos.Mini:=DataSet.FindField('Mini').AsCurrency;
InfosImmos.Choix:=DataSet.FindField('Choix').AsCurrency;
InfosImmos.Eco:=DataSet.FindField('Eco').AsCurrency;
InfosImmos.Terminee:=DataSet.FindField('Terminee').Asboolean;
InfosImmos.EnCours:=DataSet.FindField('EnCours').Asboolean;
InfosImmos.CodeTerminee:=DataSet.FindField('CodeTerminee').AsString;
InfosImmos.CompteTerminee:=DataSet.FindField('CompteTerminee').AsString;
InfosImmos.TauxAmo:=DataSet.FindField('TauxAmo').AsFloat;
InfosImmos.Tiers:=DataSet.FindField('Tiers').AsString;
InfosImmos.ReferenceFacture:=DataSet.FindField('ReferenceFacture').AsString;
InfosImmos.MontantTTC:=DataSet.FindField('MontantTTC').AsCurrency;
InfosImmos.SousCodeTerminee:=DataSet.FindField('SousCodeTerminee').AsString;
end;
Function Infos_TInfosImmos(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosImmos;
Begin
Initialise_TInfosImmos(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosImmos(DataSet,result);
end;
Procedure Initialise_TInfosLCpt_CptA(var InfosLCpt_CptA:TInfosLCpt_CptA);
Begin
InfosLCpt_CptA.Id:=0;
InfosLCpt_CptA.IDCompteA:=0;
InfosLCpt_CptA.IDCdpPere:=0;
InfosLCpt_CptA.IDLigne:=0;
InfosLCpt_CptA.CompteA:='';
InfosLCpt_CptA.Ratio:=0.00;
end;
Procedure Remplit_TInfosLCpt_CptA(DataSet:TDataSet;var InfosLCpt_CptA:TInfosLCpt_CptA);
Begin
Initialise_TInfosLCpt_CptA(InfosLCpt_CptA);
InfosLCpt_CptA.Id:=DataSet.FindField('Id').AsInteger;
InfosLCpt_CptA.IDCompteA:=DataSet.FindField('IDCompteA').AsInteger;
InfosLCpt_CptA.IDCdpPere:=DataSet.FindField('IDCdpPere').AsInteger;
InfosLCpt_CptA.IDLigne:=DataSet.FindField('IDLigne').AsInteger;
InfosLCpt_CptA.CompteA:=DataSet.FindField('CompteA').AsString;
InfosLCpt_CptA.Ratio:=DataSet.FindField('Ratio').AsFloat;
end;
Function Infos_TInfosLCpt_CptA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosLCpt_CptA;
Begin
Initialise_TInfosLCpt_CptA(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosLCpt_CptA(DataSet,result);
end;
Procedure Initialise_TInfosModel(var InfosModel:TInfosModel);
Begin
InfosModel.ID:=0;
InfosModel.Code:='';
InfosModel.Libelle_Model:='';
InfosModel.Libelle:='';
InfosModel.Journal:='';
InfosModel.Compte:='';
InfosModel.Compte_Reglement:='';
InfosModel.Minimun:=false;
InfosModel.ID_Devise:=0;
InfosModel.ID_Journal:=0;
InfosModel.Qui:='';
InfosModel.Quand:=0;
InfosModel.CODE_BANQUE_GESTCO:='';
end;
Procedure Remplit_TInfosModel(DataSet:TDataSet;var InfosModel:TInfosModel);
Begin
Initialise_TInfosModel(InfosModel);
InfosModel.ID:=DataSet.FindField('ID').AsInteger;
InfosModel.Code:=DataSet.FindField('Code').AsString;
InfosModel.Libelle_Model:=DataSet.FindField('Libelle_Model').AsString;
InfosModel.Libelle:=DataSet.FindField('Libelle').AsString;
InfosModel.Journal:=DataSet.FindField('Journal').AsString;
InfosModel.Compte:=DataSet.FindField('Compte').AsString;
InfosModel.Compte_Reglement:=DataSet.FindField('Compte_Reglement').AsString;
InfosModel.Minimun:=DataSet.FindField('Minimun').Asboolean;
InfosModel.ID_Devise:=DataSet.FindField('ID_Devise').AsInteger;
InfosModel.ID_Journal:=DataSet.FindField('ID_Journal').AsInteger;
InfosModel.Qui:=DataSet.FindField('Qui').AsString;
InfosModel.Quand:=DataSet.FindField('Quand').AsDateTime;
InfosModel.CODE_BANQUE_GESTCO:=DataSet.FindField('CODE_BANQUE_GESTCO').AsString;
end;
Function Infos_TInfosModel(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosModel;
Begin
Initialise_TInfosModel(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosModel(DataSet,result);
end;
Procedure Initialise_TInfosModelL(var InfosModelL:TInfosModelL);
Begin
InfosModelL.ID:=0;
InfosModelL.ID_Model:=0;
InfosModelL.Ligne:=0;
InfosModelL.Compte:='';
InfosModelL.Libelle:='';
InfosModelL.Qt1:=0.00;
InfosModelL.Qt2:=0.00;
InfosModelL.Montant:=0;
InfosModelL.Tva:=0;
InfosModelL.TvaCode:='';
InfosModelL.TvaType:='';
InfosModelL.TvaTaux:=0.00;
InfosModelL.Qui:='';
InfosModelL.Quand:=0;
end;
Procedure Remplit_TInfosModelL(DataSet:TDataSet;var InfosModelL:TInfosModelL);
Begin
Initialise_TInfosModelL(InfosModelL);
InfosModelL.ID:=DataSet.FindField('ID').AsInteger;
InfosModelL.ID_Model:=DataSet.FindField('ID_Model').AsInteger;
InfosModelL.Ligne:=DataSet.FindField('Ligne').AsInteger;
InfosModelL.Compte:=DataSet.FindField('Compte').AsString;
InfosModelL.Libelle:=DataSet.FindField('Libelle').AsString;
InfosModelL.Qt1:=DataSet.FindField('Qt1').AsFloat;
InfosModelL.Qt2:=DataSet.FindField('Qt2').AsFloat;
InfosModelL.Montant:=DataSet.FindField('Montant').AsCurrency;
InfosModelL.Tva:=DataSet.FindField('Tva').AsCurrency;
InfosModelL.TvaCode:=DataSet.FindField('TvaCode').AsString;
InfosModelL.TvaType:=DataSet.FindField('TvaType').AsString;
InfosModelL.TvaTaux:=DataSet.FindField('TvaTaux').AsFloat;
InfosModelL.Qui:=DataSet.FindField('Qui').AsString;
InfosModelL.Quand:=DataSet.FindField('Quand').AsDateTime;
end;
Function Infos_TInfosModelL(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosModelL;
Begin
Initialise_TInfosModelL(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosModelL(DataSet,result);
end;
Procedure Initialise_TInfosParam_Dossier(var InfosParam_Dossier:TInfosParam_Dossier);
Begin
InfosParam_Dossier.CLE:='';
InfosParam_Dossier.NOM_DOSS:='';
InfosParam_Dossier.Adr1:='';
InfosParam_Dossier.Adr2:='';
InfosParam_Dossier.CP:='';
InfosParam_Dossier.VILLE:='';
InfosParam_Dossier.REGIME_Agr:='';
InfosParam_Dossier.TYPE_SOC:='';
InfosParam_Dossier.TYPE_FISC:='';
InfosParam_Dossier.PERIODE_TVA:='';
InfosParam_Dossier.TVA_DEBIT:='';
InfosParam_Dossier.PLAN_AUX:='';
InfosParam_Dossier.PERIODE:='';
InfosParam_Dossier.TYPE_IMPOT:='';
InfosParam_Dossier.TYPE_DEC_FISC:='';
InfosParam_Dossier.DATE_DEB_EXO:=0;
InfosParam_Dossier.DATE_FIN_EXO:=0;
InfosParam_Dossier.EXO_SAISIE:='';
InfosParam_Dossier.EXO_BASE:='';
InfosParam_Dossier.DEVISE_EXO:='';
InfosParam_Dossier.DIVParam_Dossier:='';
InfosParam_Dossier.DATE_PREM_DECL_TVA:=0;
InfosParam_Dossier.DEROGATOIRE:=false;
InfosParam_Dossier.DATE_PASSAGE_REEL:=0;
InfosParam_Dossier.AU_REEL:=false;
InfosParam_Dossier.PARAM_DIV:='';
InfosParam_Dossier.UTILISATEUR:='';
end;
Procedure Remplit_TInfosParam_Dossier(DataSet:TDataSet;var InfosParam_Dossier:TInfosParam_Dossier);
Begin
Initialise_TInfosParam_Dossier(InfosParam_Dossier);
InfosParam_Dossier.CLE:=DataSet.FindField('CLE').AsString;
InfosParam_Dossier.NOM_DOSS:=DataSet.FindField('NOM_DOSS').AsString;
InfosParam_Dossier.Adr1:=DataSet.FindField('Adr1').AsString;
InfosParam_Dossier.Adr2:=DataSet.FindField('Adr2').AsString;
InfosParam_Dossier.CP:=DataSet.FindField('CP').AsString;
InfosParam_Dossier.VILLE:=DataSet.FindField('VILLE').AsString;
InfosParam_Dossier.REGIME_Agr:=DataSet.FindField('REGIME_Agr').AsString;
InfosParam_Dossier.TYPE_SOC:=DataSet.FindField('TYPE_SOC').AsString;
InfosParam_Dossier.TYPE_FISC:=DataSet.FindField('TYPE_FISC').AsString;
InfosParam_Dossier.PERIODE_TVA:=DataSet.FindField('PERIODE_TVA').AsString;
InfosParam_Dossier.TVA_DEBIT:=DataSet.FindField('TVA_DEBIT').AsString;
InfosParam_Dossier.PLAN_AUX:=DataSet.FindField('PLAN_AUX').AsString;
InfosParam_Dossier.PERIODE:=DataSet.FindField('PERIODE').AsString;
InfosParam_Dossier.TYPE_IMPOT:=DataSet.FindField('TYPE_IMPOT').AsString;
InfosParam_Dossier.TYPE_DEC_FISC:=DataSet.FindField('TYPE_DEC_FISC').AsString;
InfosParam_Dossier.DATE_DEB_EXO:=DataSet.FindField('DATE_DEB_EXO').AsDateTime;
InfosParam_Dossier.DATE_FIN_EXO:=DataSet.FindField('DATE_FIN_EXO').AsDateTime;
InfosParam_Dossier.EXO_SAISIE:=DataSet.FindField('EXO_SAISIE').AsString;
InfosParam_Dossier.EXO_BASE:=DataSet.FindField('EXO_BASE').AsString;
InfosParam_Dossier.DEVISE_EXO:=DataSet.FindField('DEVISE_EXO').AsString;
InfosParam_Dossier.DIVParam_Dossier:=DataSet.FindField('DIV').AsVariant;
InfosParam_Dossier.DATE_PREM_DECL_TVA:=DataSet.FindField('DATE_PREM_DECL_TVA').AsDateTime;
InfosParam_Dossier.DEROGATOIRE:=DataSet.FindField('DEROGATOIRE').Asboolean;
InfosParam_Dossier.DATE_PASSAGE_REEL:=DataSet.FindField('DATE_PASSAGE_REEL').AsDateTime;
InfosParam_Dossier.AU_REEL:=DataSet.FindField('AU_REEL').Asboolean;
InfosParam_Dossier.PARAM_DIV:=DataSet.FindField('PARAM_DIV').AsString;
InfosParam_Dossier.UTILISATEUR:=DataSet.FindField('UTILISATEUR').AsString;
end;
Function Infos_TInfosParam_Dossier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosParam_Dossier;
Begin
Initialise_TInfosParam_Dossier(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosParam_Dossier(DataSet,result);
end;
Procedure Initialise_TInfosPiece(var InfosPiece:TInfosPiece);
Begin
InfosPiece.ID:=0;
InfosPiece.Journal:=0;
InfosPiece.Reference:='';
InfosPiece.Date:=0;
InfosPiece.Libelle:='';
InfosPiece.TypePiece:=0;
InfosPiece.Compte:='';
InfosPiece.ID_Devise:=0;
InfosPiece.Validation:=0;
InfosPiece.Qui:='';
InfosPiece.Quand:=0;
InfosPiece.Num_Cheque:='';
InfosPiece.ID_GESTCO:=0.00;
InfosPiece.CODE_GESTCO:='';
InfosPiece.Table_Gen:='';
InfosPiece.Champ_Gen:='';
InfosPiece.Val_Champ_Gen:='';
end;
Procedure Remplit_TInfosPiece(DataSet:TDataSet;var InfosPiece:TInfosPiece);
Begin
Initialise_TInfosPiece(InfosPiece);
InfosPiece.ID:=DataSet.FindField('ID').AsInteger;
InfosPiece.Journal:=DataSet.FindField('Journal').AsInteger;
InfosPiece.Reference:=DataSet.FindField('Reference').AsString;
InfosPiece.Date:=DataSet.FindField('Date').AsDateTime;
InfosPiece.Libelle:=DataSet.FindField('Libelle').AsString;
InfosPiece.TypePiece:=DataSet.FindField('TypePiece').AsInteger;
InfosPiece.Compte:=DataSet.FindField('Compte').AsString;
InfosPiece.ID_Devise:=DataSet.FindField('ID_Devise').AsInteger;
InfosPiece.Validation:=DataSet.FindField('Validation').AsDateTime;
InfosPiece.Qui:=DataSet.FindField('Qui').AsString;
InfosPiece.Quand:=DataSet.FindField('Quand').AsDateTime;
InfosPiece.Num_Cheque:=DataSet.FindField('Num_Cheque').AsString;
InfosPiece.ID_GESTCO:=DataSet.FindField('ID_GESTCO').AsFloat;
InfosPiece.CODE_GESTCO:=DataSet.FindField('CODE_GESTCO').AsString;
InfosPiece.Table_Gen:=DataSet.FindField('Table_Gen').AsString;
InfosPiece.Champ_Gen:=DataSet.FindField('Champ_Gen').AsString;
InfosPiece.Val_Champ_Gen:=DataSet.FindField('Val_Champ_Gen').AsString;
end;
Function Infos_TInfosPiece(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPiece;
Begin
Initialise_TInfosPiece(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPiece(DataSet,result);
end;
Procedure Initialise_TInfosPiece_Import(var InfosPiece_Import:TInfosPiece_Import);
Begin
InfosPiece_Import.ID:=0;
InfosPiece_Import.ID_Piece_Import:=0;
InfosPiece_Import.Nouvel_ID_Piece:=0;
InfosPiece_Import.Compte:='';
InfosPiece_Import.Libelle:='';
InfosPiece_Import.Debit:=0;
InfosPiece_Import.Credit:=0;
InfosPiece_Import.ID_Prog:=0;
end;
Procedure Remplit_TInfosPiece_Import(DataSet:TDataSet;var InfosPiece_Import:TInfosPiece_Import);
Begin
Initialise_TInfosPiece_Import(InfosPiece_Import);
InfosPiece_Import.ID:=DataSet.FindField('ID').AsInteger;
InfosPiece_Import.ID_Piece_Import:=DataSet.FindField('ID_Piece_Import').AsInteger;
InfosPiece_Import.Nouvel_ID_Piece:=DataSet.FindField('Nouvel_ID_Piece').AsInteger;
InfosPiece_Import.Compte:=DataSet.FindField('Compte').AsString;
InfosPiece_Import.Libelle:=DataSet.FindField('Libelle').AsString;
InfosPiece_Import.Debit:=DataSet.FindField('Debit').AsCurrency;
InfosPiece_Import.Credit:=DataSet.FindField('Credit').AsCurrency;
InfosPiece_Import.ID_Prog:=DataSet.FindField('ID_Prog').AsInteger;
end;
Function Infos_TInfosPiece_Import(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPiece_Import;
Begin
Initialise_TInfosPiece_Import(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPiece_Import(DataSet,result);
end;
Procedure Initialise_TInfosplancpt(var Infosplancpt:TInfosplancpt);
Begin
Infosplancpt.Compte:='';
Infosplancpt.Libelle:='';
Infosplancpt.Debit_Deb:=0.00;
Infosplancpt.Credit_Deb:=0.00;
Infosplancpt.Un1:='';
Infosplancpt.Un2:='';
Infosplancpt.Qt1_Deb:=0.00;
Infosplancpt.Qt2_Deb:=0.00;
Infosplancpt.PlanSaisie:=false;
Infosplancpt.TvaCode:='';
Infosplancpt.TvaType:='';
Infosplancpt.TvaDebit:=false;
Infosplancpt.SensCredit:=false;
Infosplancpt.Collectif:=false;
Infosplancpt.Centraliser:=false;
Infosplancpt.Tiers:=false;
Infosplancpt.Rapprochement:=false;
Infosplancpt.Immobilisation:=false;
Infosplancpt.ImmoAmort:=false;
Infosplancpt.ImmoDegressif:=false;
Infosplancpt.Emprunt:=false;
Infosplancpt.Abandonne:=false;
Infosplancpt.Qui:='';
Infosplancpt.Quand:=0;
Infosplancpt.ID_Affichage:=0;
Infosplancpt.JBanque:='';
Infosplancpt.pointable:=false;
Infosplancpt.taux:=0.00;
Infosplancpt.DIVplancpt:='';
Infosplancpt.ID_GESTANAL:=0;
Infosplancpt.CODE_GESTANAL:='';
Infosplancpt.UtilOuvAuto:=false;
end;
Procedure Remplit_TInfosplancpt(DataSet:TDataSet;var Infosplancpt:TInfosplancpt);
Begin
Initialise_TInfosplancpt(Infosplancpt);
Infosplancpt.Compte:=DataSet.FindField('Compte').AsString;
Infosplancpt.Libelle:=DataSet.FindField('Libelle').AsString;
Infosplancpt.Debit_Deb:=DataSet.FindField('Debit_Deb').AsFloat;
Infosplancpt.Credit_Deb:=DataSet.FindField('Credit_Deb').AsFloat;
Infosplancpt.Un1:=DataSet.FindField('Un1').AsString;
Infosplancpt.Un2:=DataSet.FindField('Un2').AsString;
Infosplancpt.Qt1_Deb:=DataSet.FindField('Qt1_Deb').AsFloat;
Infosplancpt.Qt2_Deb:=DataSet.FindField('Qt2_Deb').AsFloat;
Infosplancpt.PlanSaisie:=DataSet.FindField('PlanSaisie').Asboolean;
Infosplancpt.TvaCode:=DataSet.FindField('TvaCode').AsString;
Infosplancpt.TvaType:=DataSet.FindField('TvaType').AsString;
Infosplancpt.TvaDebit:=DataSet.FindField('TvaDebit').Asboolean;
Infosplancpt.SensCredit:=DataSet.FindField('SensCredit').Asboolean;
Infosplancpt.Collectif:=DataSet.FindField('Collectif').Asboolean;
Infosplancpt.Centraliser:=DataSet.FindField('Centraliser').Asboolean;
Infosplancpt.Tiers:=DataSet.FindField('Tiers').Asboolean;
Infosplancpt.Rapprochement:=DataSet.FindField('Rapprochement').Asboolean;
Infosplancpt.Immobilisation:=DataSet.FindField('Immobilisation').Asboolean;
Infosplancpt.ImmoAmort:=DataSet.FindField('ImmoAmort').Asboolean;
Infosplancpt.ImmoDegressif:=DataSet.FindField('ImmoDegressif').Asboolean;
Infosplancpt.Emprunt:=DataSet.FindField('Emprunt').Asboolean;
Infosplancpt.Abandonne:=DataSet.FindField('Abandonne').Asboolean;
Infosplancpt.Qui:=DataSet.FindField('Qui').AsString;
Infosplancpt.Quand:=DataSet.FindField('Quand').AsDateTime;
Infosplancpt.ID_Affichage:=DataSet.FindField('ID_Affichage').AsInteger;
Infosplancpt.JBanque:=DataSet.FindField('JBanque').AsString;
Infosplancpt.pointable:=DataSet.FindField('pointable').Asboolean;
Infosplancpt.taux:=DataSet.FindField('taux').AsFloat;
Infosplancpt.DIVplancpt:=DataSet.FindField('DIV').AsString;
Infosplancpt.ID_GESTANAL:=DataSet.FindField('ID_GESTANAL').AsInteger;
Infosplancpt.CODE_GESTANAL:=DataSet.FindField('CODE_GESTANAL').AsString;
Infosplancpt.UtilOuvAuto:=DataSet.FindField('UtilOuvAuto').Asboolean;
end;
Function Infos_TInfosplancpt(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosplancpt;
Begin
Initialise_TInfosplancpt(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosplancpt(DataSet,result);
end;
Procedure Initialise_TInfosPointage(var InfosPointage:TInfosPointage);
Begin
InfosPointage.ID:=0.00;
InfosPointage.ID_Debit:=0;
InfosPointage.ID_Credit:=0;
InfosPointage.Date:=0;
InfosPointage.Montant:=0;
InfosPointage.TvaDate:=0;
InfosPointage.Validation:=0;
InfosPointage.Qui:='';
InfosPointage.Quand:=0;
end;
Procedure Remplit_TInfosPointage(DataSet:TDataSet;var InfosPointage:TInfosPointage);
Begin
Initialise_TInfosPointage(InfosPointage);
InfosPointage.ID:=DataSet.FindField('ID').AsFloat;
InfosPointage.ID_Debit:=DataSet.FindField('ID_Debit').AsInteger;
InfosPointage.ID_Credit:=DataSet.FindField('ID_Credit').AsInteger;
InfosPointage.Date:=DataSet.FindField('Date').AsDateTime;
InfosPointage.Montant:=DataSet.FindField('Montant').AsCurrency;
InfosPointage.TvaDate:=DataSet.FindField('TvaDate').AsDateTime;
InfosPointage.Validation:=DataSet.FindField('Validation').AsDateTime;
InfosPointage.Qui:=DataSet.FindField('Qui').AsString;
InfosPointage.Quand:=DataSet.FindField('Quand').AsDateTime;
end;
Function Infos_TInfosPointage(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPointage;
Begin
Initialise_TInfosPointage(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPointage(DataSet,result);
end;
Procedure Initialise_TInfosResteDC(var InfosResteDC:TInfosResteDC);
Begin
InfosResteDC.ID:=0;
InfosResteDC.ID_Ecriture:=0;
InfosResteDC.ID_Piece:=0;
InfosResteDC.Date:=0;
InfosResteDC.Reference:='';
InfosResteDC.Tiers:='';
InfosResteDC.Libelle:='';
InfosResteDC.Debit:=0;
InfosResteDC.Credit:=0;
InfosResteDC.Sens:='';
InfosResteDC.Reste:=0;
InfosResteDC.Lettre:='';
InfosResteDC.Montant:=0;
InfosResteDC.Ligne:=0;
end;
Procedure Remplit_TInfosResteDC(DataSet:TDataSet;var InfosResteDC:TInfosResteDC);
Begin
Initialise_TInfosResteDC(InfosResteDC);
InfosResteDC.ID:=DataSet.FindField('ID').AsInteger;
InfosResteDC.ID_Ecriture:=DataSet.FindField('ID_Ecriture').AsInteger;
InfosResteDC.ID_Piece:=DataSet.FindField('ID_Piece').AsInteger;
InfosResteDC.Date:=DataSet.FindField('Date').AsDateTime;
InfosResteDC.Reference:=DataSet.FindField('Reference').AsString;
InfosResteDC.Tiers:=DataSet.FindField('Tiers').AsString;
InfosResteDC.Libelle:=DataSet.FindField('Libelle').AsString;
InfosResteDC.Debit:=DataSet.FindField('Debit').AsCurrency;
InfosResteDC.Credit:=DataSet.FindField('Credit').AsCurrency;
InfosResteDC.Sens:=DataSet.FindField('Sens').AsString;
InfosResteDC.Reste:=DataSet.FindField('Reste').AsCurrency;
InfosResteDC.Lettre:=DataSet.FindField('Lettre').AsString;
InfosResteDC.Montant:=DataSet.FindField('Montant').AsCurrency;
InfosResteDC.Ligne:=DataSet.FindField('Ligne').AsInteger;
end;
Function Infos_TInfosResteDC(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosResteDC;
Begin
Initialise_TInfosResteDC(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosResteDC(DataSet,result);
end;
Procedure Initialise_TInfosTA_Activite(var InfosTA_Activite:TInfosTA_Activite);
Begin
InfosTA_Activite.ID_Activite:=0;
InfosTA_Activite.Code_Activite:='';
InfosTA_Activite.Libelle_Activite:='';
end;
Procedure Remplit_TInfosTA_Activite(DataSet:TDataSet;var InfosTA_Activite:TInfosTA_Activite);
Begin
Initialise_TInfosTA_Activite(InfosTA_Activite);
InfosTA_Activite.ID_Activite:=DataSet.FindField('ID_Activite').AsInteger;
InfosTA_Activite.Code_Activite:=DataSet.FindField('Code_Activite').AsString;
InfosTA_Activite.Libelle_Activite:=DataSet.FindField('Libelle_Activite').AsString;
end;
Function Infos_TInfosTA_Activite(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Activite;
Begin
Initialise_TInfosTA_Activite(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTA_Activite(DataSet,result);
end;
Procedure Initialise_TInfosTA_Affect_Atelier(var InfosTA_Affect_Atelier:TInfosTA_Affect_Atelier);
Begin
InfosTA_Affect_Atelier.ID:=0;
InfosTA_Affect_Atelier.ID_Atelier:=0;
InfosTA_Affect_Atelier.ID_Ligne:=0;
InfosTA_Affect_Atelier.Compte:='';
InfosTA_Affect_Atelier.Libelle:='';
InfosTA_Affect_Atelier.Code_Atelier:='';
InfosTA_Affect_Atelier.Ratio:=0.00;
end;
Procedure Remplit_TInfosTA_Affect_Atelier(DataSet:TDataSet;var InfosTA_Affect_Atelier:TInfosTA_Affect_Atelier);
Begin
Initialise_TInfosTA_Affect_Atelier(InfosTA_Affect_Atelier);
InfosTA_Affect_Atelier.ID:=DataSet.FindField('ID').AsInteger;
InfosTA_Affect_Atelier.ID_Atelier:=DataSet.FindField('ID_Atelier').AsInteger;
InfosTA_Affect_Atelier.ID_Ligne:=DataSet.FindField('ID_Ligne').AsInteger;
InfosTA_Affect_Atelier.Compte:=DataSet.FindField('Compte').AsString;
InfosTA_Affect_Atelier.Libelle:=DataSet.FindField('Libelle').AsString;
InfosTA_Affect_Atelier.Code_Atelier:=DataSet.FindField('Code_Atelier').AsString;
InfosTA_Affect_Atelier.Ratio:=DataSet.FindField('Ratio').AsFloat;
end;
Function Infos_TInfosTA_Affect_Atelier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Affect_Atelier;
Begin
Initialise_TInfosTA_Affect_Atelier(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTA_Affect_Atelier(DataSet,result);
end;
Procedure Initialise_TInfosTA_Atelier(var InfosTA_Atelier:TInfosTA_Atelier);
Begin
InfosTA_Atelier.ID_Atelier:=0;
InfosTA_Atelier.Code_Atelier:='';
InfosTA_Atelier.Libelle_Atelier:='';
InfosTA_Atelier.NB_Unite_Atelier:=0.00;
InfosTA_Atelier.Unite_Atelier:='';
InfosTA_Atelier.ID_Activite:=0;
InfosTA_Atelier.Code_Activite:='';
end;
Procedure Remplit_TInfosTA_Atelier(DataSet:TDataSet;var InfosTA_Atelier:TInfosTA_Atelier);
Begin
Initialise_TInfosTA_Atelier(InfosTA_Atelier);
InfosTA_Atelier.ID_Atelier:=DataSet.FindField('ID_Atelier').AsInteger;
InfosTA_Atelier.Code_Atelier:=DataSet.FindField('Code_Atelier').AsString;
InfosTA_Atelier.Libelle_Atelier:=DataSet.FindField('Libelle_Atelier').AsString;
InfosTA_Atelier.NB_Unite_Atelier:=DataSet.FindField('NB_Unite_Atelier').AsFloat;
InfosTA_Atelier.Unite_Atelier:=DataSet.FindField('Unite_Atelier').AsString;
InfosTA_Atelier.ID_Activite:=DataSet.FindField('ID_Activite').AsInteger;
InfosTA_Atelier.Code_Activite:=DataSet.FindField('Code_Activite').AsString;
end;
Function Infos_TInfosTA_Atelier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Atelier;
Begin
Initialise_TInfosTA_Atelier(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTA_Atelier(DataSet,result);
end;
Procedure Initialise_TInfosTiers(var InfosTiers:TInfosTiers);
Begin
InfosTiers.Tiers:='';
InfosTiers.Nom:='';
InfosTiers.Compte:='';
InfosTiers.TypeTiers:='';
InfosTiers.SensCredit:=false;
InfosTiers.Rapprochement:=false;
InfosTiers.TvaDebit:=false;
InfosTiers.Abandonne:=false;
InfosTiers.Debit_Deb:=0;
InfosTiers.Credit_Deb:=0;
InfosTiers.Adresse1:='';
InfosTiers.Adresse2:='';
InfosTiers.Poste:='';
InfosTiers.Ville:='';
InfosTiers.Pays:='';
InfosTiers.Livr_Adr1:='';
InfosTiers.Livr_Adr2:='';
InfosTiers.Livr_Poste:='';
InfosTiers.Livr_Ville:='';
InfosTiers.Livr_Pays:='';
InfosTiers.Telephone1:='';
InfosTiers.Telephone2:='';
InfosTiers.Telecopie:='';
InfosTiers.Mel:='';
InfosTiers.Qui:='';
InfosTiers.Quand:=0;
InfosTiers.Actif:=false;
InfosTiers.ID_GESTCO:=0.00;
InfosTiers.ID_COMMUNICATION:=0.00;
InfosTiers.CODE_GESTCO:='';
InfosTiers.ID_Affichage:=0;
InfosTiers.JBanque:='';
end;
Procedure Remplit_TInfosTiers(DataSet:TDataSet;var InfosTiers:TInfosTiers);
Begin
Initialise_TInfosTiers(InfosTiers);
InfosTiers.Tiers:=DataSet.FindField('Tiers').AsString;
InfosTiers.Nom:=DataSet.FindField('Nom').AsString;
InfosTiers.Compte:=DataSet.FindField('Compte').AsString;
InfosTiers.TypeTiers:=DataSet.FindField('Type').AsString;
InfosTiers.SensCredit:=DataSet.FindField('SensCredit').Asboolean;
InfosTiers.Rapprochement:=DataSet.FindField('Rapprochement').Asboolean;
InfosTiers.TvaDebit:=DataSet.FindField('TvaDebit').Asboolean;
InfosTiers.Abandonne:=DataSet.FindField('Abandonne').Asboolean;
InfosTiers.Debit_Deb:=DataSet.FindField('Debit_Deb').AsCurrency;
InfosTiers.Credit_Deb:=DataSet.FindField('Credit_Deb').AsCurrency;
InfosTiers.Adresse1:=DataSet.FindField('Adresse1').AsString;
InfosTiers.Adresse2:=DataSet.FindField('Adresse2').AsString;
InfosTiers.Poste:=DataSet.FindField('Poste').AsString;
InfosTiers.Ville:=DataSet.FindField('Ville').AsString;
InfosTiers.Pays:=DataSet.FindField('Pays').AsString;
InfosTiers.Livr_Adr1:=DataSet.FindField('Livr_Adr1').AsString;
InfosTiers.Livr_Adr2:=DataSet.FindField('Livr_Adr2').AsString;
InfosTiers.Livr_Poste:=DataSet.FindField('Livr_Poste').AsString;
InfosTiers.Livr_Ville:=DataSet.FindField('Livr_Ville').AsString;
InfosTiers.Livr_Pays:=DataSet.FindField('Livr_Pays').AsString;
InfosTiers.Telephone1:=DataSet.FindField('Telephone1').AsString;
InfosTiers.Telephone2:=DataSet.FindField('Telephone2').AsString;
InfosTiers.Telecopie:=DataSet.FindField('Telecopie').AsString;
InfosTiers.Mel:=DataSet.FindField('Mel').AsString;
InfosTiers.Qui:=DataSet.FindField('Qui').AsString;
InfosTiers.Quand:=DataSet.FindField('Quand').AsDateTime;
InfosTiers.Actif:=DataSet.FindField('Actif').Asboolean;
InfosTiers.ID_GESTCO:=DataSet.FindField('ID_GESTCO').AsFloat;
InfosTiers.ID_COMMUNICATION:=DataSet.FindField('ID_COMMUNICATION').AsFloat;
InfosTiers.CODE_GESTCO:=DataSet.FindField('CODE_GESTCO').AsString;
InfosTiers.ID_Affichage:=DataSet.FindField('ID_Affichage').AsInteger;
InfosTiers.JBanque:=DataSet.FindField('JBanque').AsString;
end;
Function Infos_TInfosTiers(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTiers;
Begin
Initialise_TInfosTiers(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTiers(DataSet,result);
end;
Procedure Initialise_TInfosTrame(var InfosTrame:TInfosTrame);
Begin
InfosTrame.ID:=0;
InfosTrame.Code:='';
InfosTrame.Libelle_Trame:='';
InfosTrame.Libelle:='';
InfosTrame.Journal:='';
InfosTrame.Compte:='';
InfosTrame.Compte_Reglement:='';
InfosTrame.Minimun:=false;
InfosTrame.ID_Devise:=0;
InfosTrame.ID_Journal:=0;
InfosTrame.Qui:='';
InfosTrame.Quand:=0;
end;
Procedure Remplit_TInfosTrame(DataSet:TDataSet;var InfosTrame:TInfosTrame);
Begin
Initialise_TInfosTrame(InfosTrame);
InfosTrame.ID:=DataSet.FindField('ID').AsInteger;
InfosTrame.Code:=DataSet.FindField('Code').AsString;
InfosTrame.Libelle_Trame:=DataSet.FindField('Libelle_Trame').AsString;
InfosTrame.Libelle:=DataSet.FindField('Libelle').AsString;
InfosTrame.Journal:=DataSet.FindField('Journal').AsString;
InfosTrame.Compte:=DataSet.FindField('Compte').AsString;
InfosTrame.Compte_Reglement:=DataSet.FindField('Compte_Reglement').AsString;
InfosTrame.Minimun:=DataSet.FindField('Minimun').Asboolean;
InfosTrame.ID_Devise:=DataSet.FindField('ID_Devise').AsInteger;
InfosTrame.ID_Journal:=DataSet.FindField('ID_Journal').AsInteger;
InfosTrame.Qui:=DataSet.FindField('Qui').AsString;
InfosTrame.Quand:=DataSet.FindField('Quand').AsDateTime;
end;
Function Infos_TInfosTrame(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTrame;
Begin
Initialise_TInfosTrame(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTrame(DataSet,result);
end;
Procedure Initialise_TInfosTrameL(var InfosTrameL:TInfosTrameL);
Begin
InfosTrameL.ID:=0;
InfosTrameL.ID_Trame:=0;
InfosTrameL.Ligne:=0;
InfosTrameL.Compte:='';
InfosTrameL.Libelle:='';
InfosTrameL.Qt1:=0.00;
InfosTrameL.Qt2:=0.00;
InfosTrameL.MontantDebit:=0;
InfosTrameL.MontantCredit:=0;
InfosTrameL.TvaCode:='';
InfosTrameL.TvaType:='';
InfosTrameL.TvaTaux:=0.00;
InfosTrameL.MontantTva:=0;
InfosTrameL.Qui:='';
InfosTrameL.Quand:=0;
InfosTrameL.TypeLigne:='';
end;
Procedure Remplit_TInfosTrameL(DataSet:TDataSet;var InfosTrameL:TInfosTrameL);
Begin
Initialise_TInfosTrameL(InfosTrameL);
InfosTrameL.ID:=DataSet.FindField('ID').AsInteger;
InfosTrameL.ID_Trame:=DataSet.FindField('ID_Trame').AsInteger;
InfosTrameL.Ligne:=DataSet.FindField('Ligne').AsInteger;
InfosTrameL.Compte:=DataSet.FindField('Compte').AsString;
InfosTrameL.Libelle:=DataSet.FindField('Libelle').AsString;
InfosTrameL.Qt1:=DataSet.FindField('Qt1').AsFloat;
InfosTrameL.Qt2:=DataSet.FindField('Qt2').AsFloat;
InfosTrameL.MontantDebit:=DataSet.FindField('MontantDebit').AsCurrency;
InfosTrameL.MontantCredit:=DataSet.FindField('MontantCredit').AsCurrency;
InfosTrameL.TvaCode:=DataSet.FindField('TvaCode').AsString;
InfosTrameL.TvaType:=DataSet.FindField('TvaType').AsString;
InfosTrameL.TvaTaux:=DataSet.FindField('TvaTaux').AsFloat;
InfosTrameL.MontantTva:=DataSet.FindField('MontantTva').AsCurrency;
InfosTrameL.Qui:=DataSet.FindField('Qui').AsString;
InfosTrameL.Quand:=DataSet.FindField('Quand').AsDateTime;
InfosTrameL.TypeLigne:=DataSet.FindField('TypeLigne').AsString;
end;
Function Infos_TInfosTrameL(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTrameL;
Begin
Initialise_TInfosTrameL(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTrameL(DataSet,result);
end;
Procedure Initialise_TInfosTvaCode(var InfosTvaCode:TInfosTvaCode);
Begin
InfosTvaCode.TvaCode:='';
InfosTvaCode.Classe:='';
InfosTvaCode.Libelle:='';
InfosTvaCode.Compte:='';
InfosTvaCode.Taux_Inf:=0.00;
InfosTvaCode.Taux_Supp:=0.00;
InfosTvaCode.Qui:='';
InfosTvaCode.Quand:=0;
InfosTvaCode.CODE_GESTCO:='';
end;
Procedure Remplit_TInfosTvaCode(DataSet:TDataSet;var InfosTvaCode:TInfosTvaCode);
Begin
Initialise_TInfosTvaCode(InfosTvaCode);
InfosTvaCode.TvaCode:=DataSet.FindField('TvaCode').AsString;
InfosTvaCode.Classe:=DataSet.FindField('Classe').AsString;
InfosTvaCode.Libelle:=DataSet.FindField('Libelle').AsString;
InfosTvaCode.Compte:=DataSet.FindField('Compte').AsString;
InfosTvaCode.Taux_Inf:=DataSet.FindField('Taux_Inf').AsFloat;
InfosTvaCode.Taux_Supp:=DataSet.FindField('Taux_Supp').AsFloat;
InfosTvaCode.Qui:=DataSet.FindField('Qui').AsString;
InfosTvaCode.Quand:=DataSet.FindField('Quand').AsDateTime;
InfosTvaCode.CODE_GESTCO:=DataSet.FindField('CODE_GESTCO').AsString;
end;
Function Infos_TInfosTvaCode(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTvaCode;
Begin
Initialise_TInfosTvaCode(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTvaCode(DataSet,result);
end;
Procedure Initialise_TInfosBalance(var InfosBalance:TInfosBalance);
Begin
InfosBalance.Compte:='';
InfosBalance.Tiers:='';
InfosBalance.Debit_Report:=0.00;
InfosBalance.Credit_Report:=0.00;
InfosBalance.Debit_Base:=0.00;
InfosBalance.Credit_Base:=0.00;
InfosBalance.Debit_Total:=0.00;
InfosBalance.Credit_Total:=0.00;
InfosBalance.Qt1_Report:=0.00;
InfosBalance.Qt2_Report:=0.00;
InfosBalance.Qt1_Base:=0.00;
InfosBalance.Qt2_Base:=0.00;
InfosBalance.Qt1_Total:=0.00;
InfosBalance.Qt2_Total:=0.00;
InfosBalance.ID_Affichage:=0;
end;
Procedure Remplit_TInfosBalance(DataSet:TDataSet;var InfosBalance:TInfosBalance);
Begin
Initialise_TInfosBalance(InfosBalance);
InfosBalance.Compte:=DataSet.FindField('Compte').AsString;
InfosBalance.Tiers:=DataSet.FindField('Tiers').AsString;
InfosBalance.Debit_Report:=DataSet.FindField('Debit_Report').AsFloat;
InfosBalance.Credit_Report:=DataSet.FindField('Credit_Report').AsFloat;
InfosBalance.Debit_Base:=DataSet.FindField('Debit_Base').AsFloat;
InfosBalance.Credit_Base:=DataSet.FindField('Credit_Base').AsFloat;
InfosBalance.Debit_Total:=DataSet.FindField('Debit_Total').AsFloat;
InfosBalance.Credit_Total:=DataSet.FindField('Credit_Total').AsFloat;
InfosBalance.Qt1_Report:=DataSet.FindField('Qt1_Report').AsFloat;
InfosBalance.Qt2_Report:=DataSet.FindField('Qt2_Report').AsFloat;
InfosBalance.Qt1_Base:=DataSet.FindField('Qt1_Base').AsFloat;
InfosBalance.Qt2_Base:=DataSet.FindField('Qt2_Base').AsFloat;
InfosBalance.Qt1_Total:=DataSet.FindField('Qt1_Total').AsFloat;
InfosBalance.Qt2_Total:=DataSet.FindField('Qt2_Total').AsFloat;
InfosBalance.ID_Affichage:=DataSet.FindField('ID_Affichage').AsInteger;
end;
Function Infos_TInfosBalance(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosBalance;
Begin
Initialise_TInfosBalance(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosBalance(DataSet,result);
end;
Procedure Initialise_TInfosBalanceTiers(var InfosBalanceTiers:TInfosBalanceTiers);
Begin
InfosBalanceTiers.Compte:='';
InfosBalanceTiers.Tiers:='';
InfosBalanceTiers.Debit_Report:=0.00;
InfosBalanceTiers.Credit_Report:=0.00;
InfosBalanceTiers.Debit_Base:=0.00;
InfosBalanceTiers.Credit_Base:=0.00;
InfosBalanceTiers.Debit_Total:=0.00;
InfosBalanceTiers.Credit_Total:=0.00;
InfosBalanceTiers.Qt1_Report:=0.00;
InfosBalanceTiers.Qt2_Report:=0.00;
InfosBalanceTiers.Qt1_Base:=0.00;
InfosBalanceTiers.Qt2_Base:=0.00;
InfosBalanceTiers.Qt1_Total:=0.00;
InfosBalanceTiers.Qt2_Total:=0.00;
InfosBalanceTiers.ID_Affichage:=0;
end;
Procedure Remplit_TInfosBalanceTiers(DataSet:TDataSet;var InfosBalanceTiers:TInfosBalanceTiers);
Begin
Initialise_TInfosBalanceTiers(InfosBalanceTiers);
InfosBalanceTiers.Compte:=DataSet.FindField('Compte').AsString;
InfosBalanceTiers.Tiers:=DataSet.FindField('Tiers').AsString;
InfosBalanceTiers.Debit_Report:=DataSet.FindField('Debit_Report').AsFloat;
InfosBalanceTiers.Credit_Report:=DataSet.FindField('Credit_Report').AsFloat;
InfosBalanceTiers.Debit_Base:=DataSet.FindField('Debit_Base').AsFloat;
InfosBalanceTiers.Credit_Base:=DataSet.FindField('Credit_Base').AsFloat;
InfosBalanceTiers.Debit_Total:=DataSet.FindField('Debit_Total').AsFloat;
InfosBalanceTiers.Credit_Total:=DataSet.FindField('Credit_Total').AsFloat;
InfosBalanceTiers.Qt1_Report:=DataSet.FindField('Qt1_Report').AsFloat;
InfosBalanceTiers.Qt2_Report:=DataSet.FindField('Qt2_Report').AsFloat;
InfosBalanceTiers.Qt1_Base:=DataSet.FindField('Qt1_Base').AsFloat;
InfosBalanceTiers.Qt2_Base:=DataSet.FindField('Qt2_Base').AsFloat;
InfosBalanceTiers.Qt1_Total:=DataSet.FindField('Qt1_Total').AsFloat;
InfosBalanceTiers.Qt2_Total:=DataSet.FindField('Qt2_Total').AsFloat;
InfosBalanceTiers.ID_Affichage:=DataSet.FindField('ID_Affichage').AsInteger;
end;
Function Infos_TInfosBalanceTiers(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosBalanceTiers;
Begin
Initialise_TInfosBalanceTiers(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosBalanceTiers(DataSet,result);
end;
Procedure Initialise_TInfosChargeAPayer(var InfosChargeAPayer:TInfosChargeAPayer);
Begin
InfosChargeAPayer.ID:=0;
InfosChargeAPayer.Compte:='';
InfosChargeAPayer.Libelle:='';
InfosChargeAPayer.Sens:='';
InfosChargeAPayer.Qte:=0.00;
InfosChargeAPayer.MontantHT:=0;
InfosChargeAPayer.DateSaisie:=0;
InfosChargeAPayer.DateExercice:=0;
InfosChargeAPayer.Compte2:='';
InfosChargeAPayer.Libelle2:='';
InfosChargeAPayer.TVA:=0;
InfosChargeAPayer.DateSysteme:=0;
InfosChargeAPayer.Date_Piece:=0;
InfosChargeAPayer.Reference:='';
InfosChargeAPayer.Id_Piece:=0;
end;
Procedure Remplit_TInfosChargeAPayer(DataSet:TDataSet;var InfosChargeAPayer:TInfosChargeAPayer);
Begin
Initialise_TInfosChargeAPayer(InfosChargeAPayer);
InfosChargeAPayer.ID:=DataSet.FindField('ID').AsInteger;
InfosChargeAPayer.Compte:=DataSet.FindField('Compte').AsString;
InfosChargeAPayer.Libelle:=DataSet.FindField('Libelle').AsString;
InfosChargeAPayer.Sens:=DataSet.FindField('Sens').AsString;
InfosChargeAPayer.Qte:=DataSet.FindField('Qte').AsFloat;
InfosChargeAPayer.MontantHT:=DataSet.FindField('MontantHT').AsCurrency;
InfosChargeAPayer.DateSaisie:=DataSet.FindField('DateSaisie').AsDateTime;
InfosChargeAPayer.DateExercice:=DataSet.FindField('DateExercice').AsDateTime;
InfosChargeAPayer.Compte2:=DataSet.FindField('Compte2').AsString;
InfosChargeAPayer.Libelle2:=DataSet.FindField('Libelle2').AsString;
InfosChargeAPayer.TVA:=DataSet.FindField('TVA').AsCurrency;
InfosChargeAPayer.DateSysteme:=DataSet.FindField('DateSysteme').AsDateTime;
InfosChargeAPayer.Date_Piece:=DataSet.FindField('Date_Piece').AsDateTime;
InfosChargeAPayer.Reference:=DataSet.FindField('Reference').AsString;
InfosChargeAPayer.Id_Piece:=DataSet.FindField('Id_Piece').AsInteger;
end;
Function Infos_TInfosChargeAPayer(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosChargeAPayer;
Begin
Initialise_TInfosChargeAPayer(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosChargeAPayer(DataSet,result);
end;
Procedure Initialise_TInfosChargesRepartir(var InfosChargesRepartir:TInfosChargesRepartir);
Begin
InfosChargesRepartir.ID:=0;
InfosChargesRepartir.Compte:='';
InfosChargesRepartir.Designation:='';
InfosChargesRepartir.MtTotalCharge:=0;
InfosChargesRepartir.MtBilanOuverture:=0;
InfosChargesRepartir.DateSysteme:=0;
InfosChargesRepartir.Reference:='';
InfosChargesRepartir.MontantReprise:=0;
InfosChargesRepartir.DateSaisie:=0;
end;
Procedure Remplit_TInfosChargesRepartir(DataSet:TDataSet;var InfosChargesRepartir:TInfosChargesRepartir);
Begin
Initialise_TInfosChargesRepartir(InfosChargesRepartir);
InfosChargesRepartir.ID:=DataSet.FindField('ID').AsInteger;
InfosChargesRepartir.Compte:=DataSet.FindField('Compte').AsString;
InfosChargesRepartir.Designation:=DataSet.FindField('Designation').AsString;
InfosChargesRepartir.MtTotalCharge:=DataSet.FindField('MtTotalCharge').AsCurrency;
InfosChargesRepartir.MtBilanOuverture:=DataSet.FindField('MtBilanOuverture').AsCurrency;
InfosChargesRepartir.DateSysteme:=DataSet.FindField('DateSysteme').AsDateTime;
InfosChargesRepartir.Reference:=DataSet.FindField('Reference').AsString;
InfosChargesRepartir.MontantReprise:=DataSet.FindField('MontantReprise').AsCurrency;
InfosChargesRepartir.DateSaisie:=DataSet.FindField('DateSaisie').AsDateTime;
end;
Function Infos_TInfosChargesRepartir(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosChargesRepartir;
Begin
Initialise_TInfosChargesRepartir(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosChargesRepartir(DataSet,result);
end;
Procedure Initialise_TInfosDepensesEntreprises(var InfosDepensesEntreprises:TInfosDepensesEntreprises);
Begin
InfosDepensesEntreprises.ID:=0;
InfosDepensesEntreprises.Compte:='';
InfosDepensesEntreprises.Libelle:='';
InfosDepensesEntreprises.Sens:='';
InfosDepensesEntreprises.Qte:=0.00;
InfosDepensesEntreprises.MontantHT:=0;
InfosDepensesEntreprises.DateSaisie:=0;
InfosDepensesEntreprises.DateExercice:=0;
InfosDepensesEntreprises.Compte2:='';
InfosDepensesEntreprises.Libelle2:='';
InfosDepensesEntreprises.TVA:=0;
InfosDepensesEntreprises.DatePiece:=0;
InfosDepensesEntreprises.Reference:='';
InfosDepensesEntreprises.DateSysteme:=0;
end;
Procedure Remplit_TInfosDepensesEntreprises(DataSet:TDataSet;var InfosDepensesEntreprises:TInfosDepensesEntreprises);
Begin
Initialise_TInfosDepensesEntreprises(InfosDepensesEntreprises);
InfosDepensesEntreprises.ID:=DataSet.FindField('ID').AsInteger;
InfosDepensesEntreprises.Compte:=DataSet.FindField('Compte').AsString;
InfosDepensesEntreprises.Libelle:=DataSet.FindField('Libelle').AsString;
InfosDepensesEntreprises.Sens:=DataSet.FindField('Sens').AsString;
InfosDepensesEntreprises.Qte:=DataSet.FindField('Qte').AsFloat;
InfosDepensesEntreprises.MontantHT:=DataSet.FindField('MontantHT').AsCurrency;
InfosDepensesEntreprises.DateSaisie:=DataSet.FindField('DateSaisie').AsDateTime;
InfosDepensesEntreprises.DateExercice:=DataSet.FindField('DateExercice').AsDateTime;
InfosDepensesEntreprises.Compte2:=DataSet.FindField('Compte2').AsString;
InfosDepensesEntreprises.Libelle2:=DataSet.FindField('Libelle2').AsString;
InfosDepensesEntreprises.TVA:=DataSet.FindField('TVA').AsCurrency;
InfosDepensesEntreprises.DatePiece:=DataSet.FindField('DatePiece').AsDateTime;
InfosDepensesEntreprises.Reference:=DataSet.FindField('Reference').AsString;
InfosDepensesEntreprises.DateSysteme:=DataSet.FindField('DateSysteme').AsDateTime;
end;
Function Infos_TInfosDepensesEntreprises(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosDepensesEntreprises;
Begin
Initialise_TInfosDepensesEntreprises(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosDepensesEntreprises(DataSet,result);
end;
Procedure Initialise_TInfosImmos_clot(var InfosImmos_clot:TInfosImmos_clot);
Begin
InfosImmos_clot.ID:=0;
InfosImmos_clot.Code:=0.00;
InfosImmos_clot.Reference_OP:='';
InfosImmos_clot.COMPTE:='';
InfosImmos_clot.Contrepartie:='';
InfosImmos_clot.Designation:='';
InfosImmos_clot.Quantite:=0;
InfosImmos_clot.Montant:=0;
InfosImmos_clot.TVA:=0;
InfosImmos_clot.Date:=0;
InfosImmos_clot.Type_Immo:=0.00;
end;
Procedure Remplit_TInfosImmos_clot(DataSet:TDataSet;var InfosImmos_clot:TInfosImmos_clot);
Begin
Initialise_TInfosImmos_clot(InfosImmos_clot);
InfosImmos_clot.ID:=DataSet.FindField('ID').AsInteger;
InfosImmos_clot.Code:=DataSet.FindField('Code').AsFloat;
InfosImmos_clot.Reference_OP:=DataSet.FindField('Reference_OP').AsString;
InfosImmos_clot.COMPTE:=DataSet.FindField('COMPTE').AsString;
InfosImmos_clot.Contrepartie:=DataSet.FindField('Contrepartie').AsString;
InfosImmos_clot.Designation:=DataSet.FindField('Designation').AsString;
InfosImmos_clot.Quantite:=DataSet.FindField('Quantite').AsInteger;
InfosImmos_clot.Montant:=DataSet.FindField('Montant').AsCurrency;
InfosImmos_clot.TVA:=DataSet.FindField('TVA').AsCurrency;
InfosImmos_clot.Date:=DataSet.FindField('Date').AsDateTime;
InfosImmos_clot.Type_Immo:=DataSet.FindField('Type_Immo').AsFloat;
end;
Function Infos_TInfosImmos_clot(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosImmos_clot;
Begin
Initialise_TInfosImmos_clot(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosImmos_clot(DataSet,result);
end;
Procedure Initialise_TInfosPCA(var InfosPCA:TInfosPCA);
Begin
InfosPCA.ID:=0;
InfosPCA.Compte:='';
InfosPCA.Libelle:='';
InfosPCA.Sens:='';
InfosPCA.Qte:=0.00;
InfosPCA.MontantHT:=0;
InfosPCA.DateSaisie:=0;
InfosPCA.DateExercice:=0;
InfosPCA.Compte2:='';
InfosPCA.Libelle2:='';
InfosPCA.DateSysteme:=0;
InfosPCA.Date_Piece:=0;
InfosPCA.Reference:='';
end;
Procedure Remplit_TInfosPCA(DataSet:TDataSet;var InfosPCA:TInfosPCA);
Begin
Initialise_TInfosPCA(InfosPCA);
InfosPCA.ID:=DataSet.FindField('ID').AsInteger;
InfosPCA.Compte:=DataSet.FindField('Compte').AsString;
InfosPCA.Libelle:=DataSet.FindField('Libelle').AsString;
InfosPCA.Sens:=DataSet.FindField('Sens').AsString;
InfosPCA.Qte:=DataSet.FindField('Qte').AsFloat;
InfosPCA.MontantHT:=DataSet.FindField('MontantHT').AsCurrency;
InfosPCA.DateSaisie:=DataSet.FindField('DateSaisie').AsDateTime;
InfosPCA.DateExercice:=DataSet.FindField('DateExercice').AsDateTime;
InfosPCA.Compte2:=DataSet.FindField('Compte2').AsString;
InfosPCA.Libelle2:=DataSet.FindField('Libelle2').AsString;
InfosPCA.DateSysteme:=DataSet.FindField('DateSysteme').AsDateTime;
InfosPCA.Date_Piece:=DataSet.FindField('Date_Piece').AsDateTime;
InfosPCA.Reference:=DataSet.FindField('Reference').AsString;
end;
Function Infos_TInfosPCA(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosPCA;
Begin
Initialise_TInfosPCA(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosPCA(DataSet,result);
end;
Procedure Initialise_TInfosProvisions(var InfosProvisions:TInfosProvisions);
Begin
InfosProvisions.ID:=0;
InfosProvisions.Compte:='';
InfosProvisions.Designation:='';
InfosProvisions.MtTotalProvision:=0;
InfosProvisions.MtBilanOuverture:=0;
InfosProvisions.DateSysteme:=0;
InfosProvisions.Reference:='';
InfosProvisions.MontantReprise:=0;
InfosProvisions.DateSaisie:=0;
end;
Procedure Remplit_TInfosProvisions(DataSet:TDataSet;var InfosProvisions:TInfosProvisions);
Begin
Initialise_TInfosProvisions(InfosProvisions);
InfosProvisions.ID:=DataSet.FindField('ID').AsInteger;
InfosProvisions.Compte:=DataSet.FindField('Compte').AsString;
InfosProvisions.Designation:=DataSet.FindField('Designation').AsString;
InfosProvisions.MtTotalProvision:=DataSet.FindField('MtTotalProvision').AsCurrency;
InfosProvisions.MtBilanOuverture:=DataSet.FindField('MtBilanOuverture').AsCurrency;
InfosProvisions.DateSysteme:=DataSet.FindField('DateSysteme').AsDateTime;
InfosProvisions.Reference:=DataSet.FindField('Reference').AsString;
InfosProvisions.MontantReprise:=DataSet.FindField('MontantReprise').AsCurrency;
InfosProvisions.DateSaisie:=DataSet.FindField('DateSaisie').AsDateTime;
end;
Function Infos_TInfosProvisions(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosProvisions;
Begin
Initialise_TInfosProvisions(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosProvisions(DataSet,result);
end;
Procedure Initialise_TInfosReglemnt(var InfosReglemnt:TInfosReglemnt);
Begin
InfosReglemnt.ID:=0;
InfosReglemnt.ID_Debit:=0;
InfosReglemnt.ID_Credit:=0;
InfosReglemnt.Date:=0;
InfosReglemnt.Montant:=0.00;
InfosReglemnt.TvaDate:=0;
InfosReglemnt.Validation:=0;
InfosReglemnt.Qui:='';
InfosReglemnt.Quand:=0;
end;
Procedure Remplit_TInfosReglemnt(DataSet:TDataSet;var InfosReglemnt:TInfosReglemnt);
Begin
Initialise_TInfosReglemnt(InfosReglemnt);
InfosReglemnt.ID:=DataSet.FindField('ID').AsInteger;
InfosReglemnt.ID_Debit:=DataSet.FindField('ID_Debit').AsInteger;
InfosReglemnt.ID_Credit:=DataSet.FindField('ID_Credit').AsInteger;
InfosReglemnt.Date:=DataSet.FindField('Date').AsDateTime;
InfosReglemnt.Montant:=DataSet.FindField('Montant').AsFloat;
InfosReglemnt.TvaDate:=DataSet.FindField('TvaDate').AsDateTime;
InfosReglemnt.Validation:=DataSet.FindField('Validation').AsDateTime;
InfosReglemnt.Qui:=DataSet.FindField('Qui').AsString;
InfosReglemnt.Quand:=DataSet.FindField('Quand').AsDateTime;
end;
Function Infos_TInfosReglemnt(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosReglemnt;
Begin
Initialise_TInfosReglemnt(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosReglemnt(DataSet,result);
end;
Procedure Initialise_TInfosReport(var InfosReport:TInfosReport);
Begin
InfosReport.Compte:='';
InfosReport.Tiers:='';
InfosReport.Debit_Report:=0.00;
InfosReport.Credit_Report:=0.00;
InfosReport.Debit_Base:=0.00;
InfosReport.Credit_Base:=0.00;
InfosReport.Debit_Total:=0.00;
InfosReport.Credit_Total:=0.00;
InfosReport.Qt1_Report:=0.00;
InfosReport.Qt2_Report:=0.00;
InfosReport.Qt1_Base:=0.00;
InfosReport.Qt2_Base:=0.00;
InfosReport.Qt1_Total:=0.00;
InfosReport.Qt2_Total:=0.00;
InfosReport.ID_Affichage:=0;
end;
Procedure Remplit_TInfosReport(DataSet:TDataSet;var InfosReport:TInfosReport);
Begin
Initialise_TInfosReport(InfosReport);
InfosReport.Compte:=DataSet.FindField('Compte').AsString;
InfosReport.Tiers:=DataSet.FindField('Tiers').AsString;
InfosReport.Debit_Report:=DataSet.FindField('Debit_Report').AsFloat;
InfosReport.Credit_Report:=DataSet.FindField('Credit_Report').AsFloat;
InfosReport.Debit_Base:=DataSet.FindField('Debit_Base').AsFloat;
InfosReport.Credit_Base:=DataSet.FindField('Credit_Base').AsFloat;
InfosReport.Debit_Total:=DataSet.FindField('Debit_Total').AsFloat;
InfosReport.Credit_Total:=DataSet.FindField('Credit_Total').AsFloat;
InfosReport.Qt1_Report:=DataSet.FindField('Qt1_Report').AsFloat;
InfosReport.Qt2_Report:=DataSet.FindField('Qt2_Report').AsFloat;
InfosReport.Qt1_Base:=DataSet.FindField('Qt1_Base').AsFloat;
InfosReport.Qt2_Base:=DataSet.FindField('Qt2_Base').AsFloat;
InfosReport.Qt1_Total:=DataSet.FindField('Qt1_Total').AsFloat;
InfosReport.Qt2_Total:=DataSet.FindField('Qt2_Total').AsFloat;
InfosReport.ID_Affichage:=DataSet.FindField('ID_Affichage').AsInteger;
end;
Function Infos_TInfosReport(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosReport;
Begin
Initialise_TInfosReport(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosReport(DataSet,result);
end;
Procedure Initialise_TInfosStock(var InfosStock:TInfosStock);
Begin
InfosStock.ID:=0;
InfosStock.Compte:='';
InfosStock.Designation:='';
InfosStock.Qte:=0.00;
InfosStock.Prix_Unitaire:=0;
InfosStock.Decote:=0;
InfosStock.MontantTotalHT:=0;
InfosStock.Actif:=false;
InfosStock.Date_Saisie:=0;
InfosStock.Date_ID_Exercice:=0;
InfosStock.Date_Piece:=0;
InfosStock.Reference:='';
end;
Procedure Remplit_TInfosStock(DataSet:TDataSet;var InfosStock:TInfosStock);
Begin
Initialise_TInfosStock(InfosStock);
InfosStock.ID:=DataSet.FindField('ID').AsInteger;
InfosStock.Compte:=DataSet.FindField('Compte').AsString;
InfosStock.Designation:=DataSet.FindField('Designation').AsString;
InfosStock.Qte:=DataSet.FindField('Qte').AsFloat;
InfosStock.Prix_Unitaire:=DataSet.FindField('Prix_Unitaire').AsCurrency;
InfosStock.Decote:=DataSet.FindField('Decote').AsInteger;
InfosStock.MontantTotalHT:=DataSet.FindField('MontantTotalHT').AsCurrency;
InfosStock.Actif:=DataSet.FindField('Actif').Asboolean;
InfosStock.Date_Saisie:=DataSet.FindField('Date_Saisie').AsDateTime;
InfosStock.Date_ID_Exercice:=DataSet.FindField('Date_ID_Exercice').AsDateTime;
InfosStock.Date_Piece:=DataSet.FindField('Date_Piece').AsDateTime;
InfosStock.Reference:=DataSet.FindField('Reference').AsString;
end;
Function Infos_TInfosStock(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosStock;
Begin
Initialise_TInfosStock(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosStock(DataSet,result);
end;
Procedure Initialise_TInfosTA_Atelier_Activite(var InfosTA_Atelier_Activite:TInfosTA_Atelier_Activite);
Begin
InfosTA_Atelier_Activite.ID_Atelier:=0;
InfosTA_Atelier_Activite.ID_Activite:=0;
InfosTA_Atelier_Activite.Ratio:=0.00;
end;
Procedure Remplit_TInfosTA_Atelier_Activite(DataSet:TDataSet;var InfosTA_Atelier_Activite:TInfosTA_Atelier_Activite);
Begin
Initialise_TInfosTA_Atelier_Activite(InfosTA_Atelier_Activite);
InfosTA_Atelier_Activite.ID_Atelier:=DataSet.FindField('ID_Atelier').AsInteger;
InfosTA_Atelier_Activite.ID_Activite:=DataSet.FindField('ID_Activite').AsInteger;
InfosTA_Atelier_Activite.Ratio:=DataSet.FindField('Ratio').AsFloat;
end;
Function Infos_TInfosTA_Atelier_Activite(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Atelier_Activite;
Begin
Initialise_TInfosTA_Atelier_Activite(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTA_Atelier_Activite(DataSet,result);
end;
Procedure Initialise_TInfosTA_Compte_Atelier(var InfosTA_Compte_Atelier:TInfosTA_Compte_Atelier);
Begin
InfosTA_Compte_Atelier.Compte:='';
InfosTA_Compte_Atelier.ID_Atelier:=0;
InfosTA_Compte_Atelier.Libelle:='';
InfosTA_Compte_Atelier.Ratio:=0.00;
end;
Procedure Remplit_TInfosTA_Compte_Atelier(DataSet:TDataSet;var InfosTA_Compte_Atelier:TInfosTA_Compte_Atelier);
Begin
Initialise_TInfosTA_Compte_Atelier(InfosTA_Compte_Atelier);
InfosTA_Compte_Atelier.Compte:=DataSet.FindField('Compte').AsString;
InfosTA_Compte_Atelier.ID_Atelier:=DataSet.FindField('ID_Atelier').AsInteger;
InfosTA_Compte_Atelier.Libelle:=DataSet.FindField('Libelle').AsString;
InfosTA_Compte_Atelier.Ratio:=DataSet.FindField('Ratio').AsFloat;
end;
Function Infos_TInfosTA_Compte_Atelier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Compte_Atelier;
Begin
Initialise_TInfosTA_Compte_Atelier(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTA_Compte_Atelier(DataSet,result);
end;
Procedure Initialise_TInfosTA_Ecriture_Atelier(var InfosTA_Ecriture_Atelier:TInfosTA_Ecriture_Atelier);
Begin
InfosTA_Ecriture_Atelier.ID_Ligne:=0;
InfosTA_Ecriture_Atelier.ID_Atelier:=0;
InfosTA_Ecriture_Atelier.Libelle:='';
InfosTA_Ecriture_Atelier.Ratio:=0.00;
end;
Procedure Remplit_TInfosTA_Ecriture_Atelier(DataSet:TDataSet;var InfosTA_Ecriture_Atelier:TInfosTA_Ecriture_Atelier);
Begin
Initialise_TInfosTA_Ecriture_Atelier(InfosTA_Ecriture_Atelier);
InfosTA_Ecriture_Atelier.ID_Ligne:=DataSet.FindField('ID_Ligne').AsInteger;
InfosTA_Ecriture_Atelier.ID_Atelier:=DataSet.FindField('ID_Atelier').AsInteger;
InfosTA_Ecriture_Atelier.Libelle:=DataSet.FindField('Libelle').AsString;
InfosTA_Ecriture_Atelier.Ratio:=DataSet.FindField('Ratio').AsFloat;
end;
Function Infos_TInfosTA_Ecriture_Atelier(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTA_Ecriture_Atelier;
Begin
Initialise_TInfosTA_Ecriture_Atelier(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTA_Ecriture_Atelier(DataSet,result);
end;


Procedure Initialise_TInfosTa_MessageLGR(var InfosTa_MessageLGR:TInfosTa_MessageLGR);
Begin
InfosTa_MessageLGR.ID_Message:=0;
InfosTa_MessageLGR.Ecran:='';
InfosTa_MessageLGR.Composant:='';
InfosTa_MessageLGR.Cle:='';
InfosTa_MessageLGR.MessageLGR:='';
InfosTa_MessageLGR.Titre:='';
InfosTa_MessageLGR.Afficher:=true;
InfosTa_MessageLGR.Divers:='';
end;
Procedure Remplit_TInfosTa_MessageLGR(DataSet:TDataSet;var InfosTa_MessageLGR:TInfosTa_MessageLGR);
Begin
Initialise_TInfosTa_MessageLGR(InfosTa_MessageLGR);
InfosTa_MessageLGR.ID_Message:=DataSet.FindField('ID_Message').AsInteger;
InfosTa_MessageLGR.Ecran:=DataSet.FindField('Ecran').AsString;
InfosTa_MessageLGR.Composant:=DataSet.FindField('Composant').AsString;
InfosTa_MessageLGR.Cle:=DataSet.FindField('Cle').AsString;
InfosTa_MessageLGR.MessageLGR:=DataSet.FindField('MessageLGR').AsString;
InfosTa_MessageLGR.Titre:=DataSet.FindField('Titre').AsString;
InfosTa_MessageLGR.Afficher:=DataSet.FindField('Afficher').AsBoolean;
InfosTa_MessageLGR.Divers:=DataSet.FindField('Divers').AsString;
end;
Function Infos_TInfosTa_MessageLGR(DataSet:TDataSet;ChampRech:String;const ValeurRech:array of variant):TInfosTa_MessageLGR;
Begin
Initialise_TInfosTa_MessageLGR(result);
result.ResultInfos:=GrLocate(DataSet,ChampRech,ValeurRech);
if result.ResultInfos then
Remplit_TInfosTa_MessageLGR(DataSet,result);
end;


End.
