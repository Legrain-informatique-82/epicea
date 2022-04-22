unit LibRessourceString;

interface

const

RetourChariotDouble = #10#13#10#13;
RetourChariotSimple = #10#13;
LigneSeparation='------------------------------------------------------------------------------------------------------------';
CCloture='Clôture';
COuverture='Ouverture';
CMouvement='Mouvements';
CMethode='Méthodes';
CAide='Aide';
CImmo='Immobilisations';
CGestion='Gestion';
CEcriture = 'Ecritures';
C_RepertoireDebuggage = 'C:\Projet\Epicea-2\Debuggage\';
C_FileOccupe = 'Occupe.tmp';
C_Cloture_Exercice = 'Cloture_Exercice_';
C_DateFinInfini = '31/12/2050';

///   ********* à mettre à jour en même temp que la version *********
C_Date='05/04/2011';
//C_Version='Version Test';
C_Version='2.0.0.6';
C_Version_FileName='ConfVerEpi.Lic';
C_Version_FileNameConfirme='EnInstance.Fic';
C_Version_FileNameEnCoursTraitementComptable='Transmis.Fic';
C_TCOGERE = ' Test COGERE';
C_COGERE = ' COGERE';
//////  **************************

resourcestring
// Nomenclature
//NomForm+NomObjet+Sur quoi ça porte
//DAteVersion = 'Version du 31/12/03';
{ isa  le  07/01/04 }

DAteVersion = 'Version du '+C_Date;
//DAteVersion = 'Version du '+C_Date + C_COGERE;
VersionAnterieur = 'Votre version d''Epicéa ne vous permet pas de restaurer cette sauvegarde ';



AppelerServiceMaintenance =RetourChariotDouble +
                          '------------------------------------------------------------------------------------------------------------'+ RetourChariotSimple+
                          'Merci d''appeler le Service de Maintenance : 05 63 30 31 66.'+ RetourChariotSimple +
                          '------------------------------------------------------------------------------------------------------------'+ RetourChariotSimple;
AppelerServiceMaintenanceSimple =RetourChariotsimple +
                          '------------------------------------------------------------------------------------------------------------'+ RetourChariotSimple+
                          'appelez le Service de Maintenance : 05 63 30 31 66.'+ RetourChariotSimple +
                          '------------------------------------------------------------------------------------------------------------'+ RetourChariotSimple;

NumVersion = 'Version : '+C_Version +' '+ RetourChariotSimple +
              '---------------------------------------------------------------------------'+ RetourChariotSimple+
              'Service Maintenance : 05 63 30 31 66.'+ RetourChariotSimple +
              '---------------------------------------------------------------------------'+ RetourChariotSimple;
ParamEntRxSBInfoVersionWarning = 'Fenêtre en lecture seule.' + RetourChariotDouble +
                                 'Vous ne pouvez pas modifier ces informations !!'
                                 + RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
PlanCpt_PMRxSBInfoVersionWarning = 'Gestion du Plan Comptable.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des comptes [F6]'+ RetourChariotSimple +
                                 '* Modifier des comptes [F2]'+ RetourChariotSimple +
                                 '* Supprimer des comptes [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes [F7]'+ RetourChariotSimple +
                                 '* Trier des comptes'+ RetourChariotSimple +
                                 '* Atteindre et sélectionner un compte'+ RetourChariotSimple +
                                 '  en saisissant son numéro ou son libellé à partir de la grille'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
TiersRxSBInfoVersionWarning = 'Gestion du Plan Auxiliaire.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des comptes [F6]'+ RetourChariotSimple +
                                 '* Modifier des comptes [F2]'+ RetourChariotSimple +
                                 '* Supprimer des comptes [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et sélectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son numéro ou son libellé'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
AideTvaRxSBInfoVersionWarning = 'Gestion des Codes Tva.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des codes [F6]'+ RetourChariotSimple +
                                 '* Modifier des codes [F2]'+ RetourChariotSimple +
                                 '* Supprimer des codes [F10]'+ RetourChariotSimple +
                                 '* Visualiser des codes [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et sélectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son numéro ou son libellé'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
TrameRxSBInfoVersionWarning = 'Gestion des Trames.' + RetourChariotDouble +
                                 'En cours de construction !!'+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Disponible courant 2003.'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
PlanCptbaseRxSBInfoVersionWarning = 'Visualisation du Plan Comptable de base.' + RetourChariotSimple +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Atteindre et sélectionner un compte'+ RetourChariotSimple +
                                 '  en saisissant son numéro ou son libellé'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
Emprunt_IsaRxSBInfoVersionWarning = 'Saisie des Emprunts à l''ouverture.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des emprunts [F6]'+ RetourChariotSimple +
                                 '* Modifier des emprunts [F2]'+ RetourChariotSimple +
                                 '* Supprimer des emprunts [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes d''emprunts [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et sélectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son numéro ou son libellé'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met à jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;

StocksRxSBInfoVersionWarning = 'Saisie des Stocks à l''ouverture et à la clôture.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des stocks [F6]'+ RetourChariotSimple +
                                 '* Modifier des stocks [F2]'+ RetourChariotSimple +
                                 '* Supprimer des stocks [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de stocks [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et sélectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son numéro ou son libellé'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met à jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple +
                                 'Génération Automatique des OD d''ouverture dans le menu'+ RetourChariotSimple +
                                 '>> Ecritures >>'+ RetourChariotSimple +
                                 '       >> Reprise situation de début >>'+ RetourChariotSimple +
                                 '                                  >> Stocks >>'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
saisieP_2RxSBInfoVersionWarning = 'Saisie des pièces comptables.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Effectuer le règlement pour la pièce en cours [F5]'+ RetourChariotSimple +
                                 '* Ajouter des pièces [F6]'+ RetourChariotSimple +
                                 '* Modifier des pièces [F2]'+ RetourChariotSimple +
                                 '* Pointer la pièce en cours [F9]'+ RetourChariotSimple +
                                 '* Supprimer des pièces [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et sélectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son numéro ou son libellé'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
BalanceTiersRxSBInfoVersionWarning = 'Visualisations de la balance des Tiers à l''ouverture.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Visualiser des comptes [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et sélectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son numéro ou son libellé'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
ChargeARepartir_IsaRxSBInfoVersionWarning = 'Saisie des Charges A Répartir à l''ouverture .' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des Charges A Répartir [F6]'+ RetourChariotSimple +
                                 '* Modifier des Charges A Répartir [F2]'+ RetourChariotSimple +
                                 '* Supprimer des Charges A Répartir [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de Charges A Répartir [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met à jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
ChargeCA_IsaRxSBInfoVersionWarning = 'Saisie des Produits et Charges constatés d''avances à l''ouverture .' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des Produits et Charges constatés d''avances [F6]'+ RetourChariotSimple +
                                 '* Modifier des Produits et Charges constatés d''avances [F2]'+ RetourChariotSimple +
                                 '* Supprimer des Produits et Charges constatés d''avances [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de Produits et Charges constatés d''avances [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met à jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple +
                                 'Génération Automatique des OD d''ouverture dans le menu'+ RetourChariotSimple +
                                 '>> Ecritures >>'+ RetourChariotSimple +
                                 '       >> Reprise situation de début >>'+ RetourChariotSimple +
                                 '                                  >> Charges et produits constatés d''avances >>'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
ChargesAPayer_IsaRxSBInfoVersionWarning = 'Saisie des Charges à payer et des Produits à recevoir à l''ouverture .' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des Charges à payer et des Produits à recevoir [F6]'+ RetourChariotSimple +
                                 '* Modifier des Charges à payer et des Produits à recevoir [F2]'+ RetourChariotSimple +
                                 '* Supprimer des Charges à payer et des Produits à recevoir [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de Charges à payer et de Produits à recevoir [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met à jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple +
                                 'Génération Automatique des OD d''ouverture dans le menu'+ RetourChariotSimple +
                                 '>> Ecritures >>'+ RetourChariotSimple +
                                 '       >> Reprise situation de début >>'+ RetourChariotSimple +
                                 '                                  >> Charges à payer et des Produits à recevoir  >>'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
Provisions_IsaRxSBInfoVersionWarning = 'Saisie des Provisions à l''ouverture.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des provisions [F6]'+ RetourChariotSimple +
                                 '* Modifier des provisions [F2]'+ RetourChariotSimple +
                                 '* Supprimer des provisions [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de provisions [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met à jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
DeductionRxSBInfoVersionWarning = 'Saisie des déductions pour investissement.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des déductions [F6]'+ RetourChariotSimple +
                                 '* Modifier des déductions [F2]'+ RetourChariotSimple +
                                 '* Supprimer des déductions [F10]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
UtilisationDeductionRxSBInfoVersionWarning = 'Saisie de l''utilisation des déductions pour investissement.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des utilisation de déductions [F6]'+ RetourChariotSimple +
                                 '* Modifier des utilisation de déductions [F2]'+ RetourChariotSimple +
                                 '* Supprimer des utilisation de déductions [F10]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;

ChangementExerciceDefinitifWarning = 'Vous allez changer définitivement d''exercice.' + RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Avez-vous fait une double sauvegarde de sécurité pour archivage ? '+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotDouble+
                                 'Le changement d''exercice est une opération définitive, vous ne pourrez pas l''annuler'+ RetourChariotSimple +
                                 '(sinon par restauration d''une sauvegarde)'+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Voulez-vous commencer le changement d''exercice maintenant ?'+ RetourChariotSimple +
                                 '(si vous n''avez pas fait de sauvegarde répondez - NON -)';

ChangementExerciceDefinitifWarning2 = 'Pour accepter le rapport de clôture et continuer le changement d''exercice.' + RetourChariotSimple +
                                 'cliquez sur le bouton "Oui". '+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Pour abandonner le changement d''exercice'+ RetourChariotSimple +
                                 'Cliquez sur le bouton "Non".'+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Pour revenir au rapport de clôture'+ RetourChariotSimple +
                                 'Cliquez sur le bouton "Annuler".'+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotDouble+
                                 'Acceptez-vous le rapport de clôture ?'+ RetourChariotSimple ;
ContinuerOuAnnuler             = RetourChariotDouble+
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Cliquez sur "Ok" pour continuer ou bien Annuler'+ RetourChariotSimple+
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
RappelEpuration                = 'Attention, l''épuration est une opération définitive qui consiste à' + RetourChariotSimple +
                                 '"SUPPRIMER" les écritures sur des exercices clôturés'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Si votre dossier est volumineux (nombreuses écritures chaque année, plusieurs'+ RetourChariotSimple +
                                 'années enregistrées) son épuration permettra à Epicéa de travailler plus'+ RetourChariotSimple +
                                 'rapidement et de réduire la taille des sauvegardes.'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Les écritures épurées ne pourront plus être consultées dans Epicéa'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'SI VOUS N''AVEZ PAS DE PROBLEMES DE LENTEURS DANS EPICEA, L''EPURATION N''EST'+ RetourChariotSimple +
                                 'SANS DOUTE PAS UTILE.'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotDouble+
                                 'Une lenteur dans Epicéa peut avoir différentes causes, n''hésitez pas à nous'+ RetourChariotSimple+
                                 'contacter avant de faire une épuration.'+ RetourChariotSimple ;

                  // Commun
EditionUlterieure =RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Edition disponible dans une version ultérieure.'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciCtrlS=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ Ctrl + S ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciCtrlP=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ Ctrl + P ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciEsc=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ ESC ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF1=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F1 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF2=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F2 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF3=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F3 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF4=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F4 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF5=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F5 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF6=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F6 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF7=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F7 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF8=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F2 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF9=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F9 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF10=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F10 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF11=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F11 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF12=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Raccourci Clavier : [ F12 ].'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciAucun=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Pas de Raccourci Clavier.'+ RetourChariotSimple +
                   '---------------------------------------------------------------------------';

HintRaccourciF1F7=RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                  'Aide : [ F1 ].           Visualisation : [ F7 ].'+ RetourChariotSimple +
                  '---------------------------------------------------------------------------';



// Message d''erreur
ErrInterne ='Erreur Interne Epicéa : ';
// Tiers

////****Penser à changer le nom des constantes en suivant la nomenclature *****

/// Attention, on te surveille du coin de l'oeil !!!!!///////

HintEdnom = 'Nom du Tiers en cours';
Item0Liste1 = 'C=Client';
Item1Liste1 = 'F=Fournisseur';
Item2Liste1 = 'D=Client & Fournisseur';
Item3Liste1 = 'P=Personnel';
Item4Liste1 = 'O=Organisme Sociaux';
Item5Liste1 = 'A=Associés';
Item6Liste1 = 'T=Tous';

//SaisieReglementGrReglementCommaTextDebit = '," ",Compte,Référence,Date,Libelle,Encaisser,Pointages,Reste,Imputation';
//SaisieReglementGrReglementCommaTextCredit = '," ",Compte,Référence,Date,Libelle,Décaisser,Pointages,Reste,Imputation';
SaisieReglementGrReglementCommaTextDebit = ',Compte,Référence,Date,Libelle,Encaisser,Pointages,Reste,Imputation';
SaisieReglementGrReglementCommaTextCredit = ',Compte,Référence,Date,Libelle,Décaisser,Pointages,Reste,Imputation';

SaisieReglementhcCompteLibelleCompte='Reste à Régler : ';
//GrAmortissementCommaText = '," ",Linéaire,Dégressif';
GrAmortissementCommaText = ',Linéaire,Dégressif';
SuppressionDesPointages='Attention, si vous choisissez de modifier cette pièce, tous les pointages associés à cette pièce seront supprimés, Confirmez-vous votre choix !';
Mettre_A_Jour_Date_Livraison1='Voulez-vous mettre à jour la date de livraison de toutes les lignes de cette pièce ?';
Mettre_A_Jour_Date_Livraison2='Attention, en répondant NON, '+ RetourChariotSimple +
                              'la TVA sur Débit de cette pièce sera déclarée avant la date de la facture.'+ RetourChariotSimple +
                              'Ce n''est pas une situation normale. Nous vous reposons la question :'+ RetourChariotSimple +
                              'Souhaitez-vous que la TVA sur Débit de cette pièce soit déclarée A LA MEME DATE que la facture ?';
CompteImporte_DossierDos = ' Ce compte ne peut pas être supprimé car il fait partie d''une importation d''un dossier DOS !';
//Acces aux Ecrans
AccesEcranRefuse_General='Cet écran n''est pas disponible dans le contexte actuel';
//Acces aux procedure
AccesProcedureRefuse_General='Cette procédure n''est pas disponible dans le contexte actuel';
AccesProcedureRefuse_SurDate='Cette procédure n''est pas disponible dans la période que vous avez sélectionnée';
VersionUlterieur='Cette procédure n''est pas disponible dans cette version';

LibelleRegulTva='Régularisation pour arrondis de tva                                                                     ';
StringVideDixCaractere='          ';
StringVideCentsCaractere='                                                                                                    ';
Desole='Désolé, aucune information ne répond à votre demande.';
AccesRefuseExoN1='Vous ne pouvez pas accéder à ce menu, sur cet exercice'+#13+#10+'tant que l''exercice précédent n''est pas cloturé.';
EmpecheSuppressionDerniereDeclarationTVA='Pour supprimer la dernière déclaration de tva, vous devez passer par le menu "Gestion - TVA".';
Nous='LeGrain S.A.';

// Remonte les Sommes triées par Code de Tva en distinguant les montants a déclarer de ceux non a déclarer
// Ordre croissant sur Code TVa
RqDec_Tva_SommeTvaParCode_1=
      'select TvaCode,TvaCode.Libelle ,En_Attente ,sum(tvaMontantDebit) as TottvaMontantDebit,sum(tvaMontantCredit) as TottvaMontantCredit'+
      ' from dec_tva'+
      ' join TvaCode on (TvaCode.TvaCode = dec_tva.TvaCode)'+
      ' group by TvaCode,TvaCode.Libelle,En_Attente'+
      ' Order by TvaCode';
//        'select TvaCode ,En_Attente ,sum(tvaMontantDebit) as TottvaMontantDebit,sum(tvaMontantCredit) as TottvaMontantCredit from dec_tva'+
//        ' group by TvaCode,En_Attente'+
//        ' Order by TvaCode';

// Remonte les Sommes triées par Code de Tva en distinguant les montants a déclarer de ceux non a déclarer
// Ordre décroissant sur Code TVa
RqDec_Tva_SommeTvaParCode_2=
      'select TvaCode,TvaCode.Libelle,En_Attente ,sum(tvaMontantDebit) as TottvaMontantDebit,sum(tvaMontantCredit) as TottvaMontantCredit'+
      ' from dec_tva'+
      ' join TvaCode on (TvaCode.TvaCode = dec_tva.TvaCode)'+
      ' join Piece P on (id_piece=P.id)'+
      ' where tvacode=:Code and P."Date"> :datefin and tvaDate <= :datefin and tvatype = ''D'''+
      ' group by TvaCode,TvaCode.Libelle,En_Attente '+
      ' Order by TvaCode';

RqDec_Tva_SommeTvaParCode_3=
      'select TvaCode,TvaCode.Libelle,En_Attente ,sum(tvaMontantDebit) as TottvaMontantDebit,sum(tvaMontantCredit) as TottvaMontantCredit'+
      ' from dec_tva'+
      ' join TvaCode on (TvaCode.TvaCode = dec_tva.TvaCode)'+
      ' join Piece P on (id_piece=P.id)'+
      ' where tvacode=:Code and P."Date"<= :datefin '+
      ' group by TvaCode,TvaCode.Libelle,En_Attente  '+
      ' Order by TvaCode';

RqDec_Tva_SommeTvaParCode_4=
      ' select D.*,P."Date" as DatePiece from dec_tva D'+
      ' join Piece P on (D.id_piece=P.id)'+
      ' where tvacode=:Code and P."Date" >:datefin and tvadate <=:datefin and tvatype = ''D'''+
      ' Order by TvaCode';

ChampNonModifiable='Ce champ n''est pas modifiable dans ce contexte';


implementation

end.
