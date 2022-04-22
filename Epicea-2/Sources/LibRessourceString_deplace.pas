unit LibRessourceString;

interface

const

RetourChariotDouble = #10#13#10#13;
RetourChariotSimple = #10#13;
LigneSeparation='------------------------------------------------------------------------------------------------------------';
CCloture='Cl�ture';
COuverture='Ouverture';
CMouvement='Mouvements';
CMethode='M�thodes';
CAide='Aide';
CImmo='Immobilisations';
CGestion='Gestion';
CEcriture = 'Ecritures';
C_RepertoireDebuggage = 'C:\Projet\Epicea-2\Debuggage\';
C_FileOccupe = 'Occupe.tmp';
C_Cloture_Exercice = 'Cloture_Exercice_';
C_DateFinInfini = '31/12/2050';

///   ********* � mettre � jour en m�me temp que la version *********
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
//NomForm+NomObjet+Sur quoi �a porte
//DAteVersion = 'Version du 31/12/03';
{ isa  le  07/01/04 }

DAteVersion = 'Version du '+C_Date;
//DAteVersion = 'Version du '+C_Date + C_COGERE;
VersionAnterieur = 'Votre version d''Epic�a ne vous permet pas de restaurer cette sauvegarde ';



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
ParamEntRxSBInfoVersionWarning = 'Fen�tre en lecture seule.' + RetourChariotDouble +
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
                                 '* Atteindre et s�lectionner un compte'+ RetourChariotSimple +
                                 '  en saisissant son num�ro ou son libell� � partir de la grille'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
TiersRxSBInfoVersionWarning = 'Gestion du Plan Auxiliaire.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des comptes [F6]'+ RetourChariotSimple +
                                 '* Modifier des comptes [F2]'+ RetourChariotSimple +
                                 '* Supprimer des comptes [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et s�lectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son num�ro ou son libell�'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
AideTvaRxSBInfoVersionWarning = 'Gestion des Codes Tva.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des codes [F6]'+ RetourChariotSimple +
                                 '* Modifier des codes [F2]'+ RetourChariotSimple +
                                 '* Supprimer des codes [F10]'+ RetourChariotSimple +
                                 '* Visualiser des codes [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et s�lectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son num�ro ou son libell�'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
TrameRxSBInfoVersionWarning = 'Gestion des Trames.' + RetourChariotDouble +
                                 'En cours de construction !!'+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Disponible courant 2003.'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
PlanCptbaseRxSBInfoVersionWarning = 'Visualisation du Plan Comptable de base.' + RetourChariotSimple +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Atteindre et s�lectionner un compte'+ RetourChariotSimple +
                                 '  en saisissant son num�ro ou son libell�'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
Emprunt_IsaRxSBInfoVersionWarning = 'Saisie des Emprunts � l''ouverture.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des emprunts [F6]'+ RetourChariotSimple +
                                 '* Modifier des emprunts [F2]'+ RetourChariotSimple +
                                 '* Supprimer des emprunts [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes d''emprunts [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et s�lectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son num�ro ou son libell�'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met � jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;

StocksRxSBInfoVersionWarning = 'Saisie des Stocks � l''ouverture et � la cl�ture.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des stocks [F6]'+ RetourChariotSimple +
                                 '* Modifier des stocks [F2]'+ RetourChariotSimple +
                                 '* Supprimer des stocks [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de stocks [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et s�lectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son num�ro ou son libell�'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met � jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple +
                                 'G�n�ration Automatique des OD d''ouverture dans le menu'+ RetourChariotSimple +
                                 '>> Ecritures >>'+ RetourChariotSimple +
                                 '       >> Reprise situation de d�but >>'+ RetourChariotSimple +
                                 '                                  >> Stocks >>'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
saisieP_2RxSBInfoVersionWarning = 'Saisie des pi�ces comptables.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Effectuer le r�glement pour la pi�ce en cours [F5]'+ RetourChariotSimple +
                                 '* Ajouter des pi�ces [F6]'+ RetourChariotSimple +
                                 '* Modifier des pi�ces [F2]'+ RetourChariotSimple +
                                 '* Pointer la pi�ce en cours [F9]'+ RetourChariotSimple +
                                 '* Supprimer des pi�ces [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et s�lectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son num�ro ou son libell�'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
BalanceTiersRxSBInfoVersionWarning = 'Visualisations de la balance des Tiers � l''ouverture.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Visualiser des comptes [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
//                                 '* Atteindre et s�lectionner un compte'+ RetourChariotSimple +
//                                 '  en saisissant son num�ro ou son libell�'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
ChargeARepartir_IsaRxSBInfoVersionWarning = 'Saisie des Charges A R�partir � l''ouverture .' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des Charges A R�partir [F6]'+ RetourChariotSimple +
                                 '* Modifier des Charges A R�partir [F2]'+ RetourChariotSimple +
                                 '* Supprimer des Charges A R�partir [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de Charges A R�partir [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met � jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
ChargeCA_IsaRxSBInfoVersionWarning = 'Saisie des Produits et Charges constat�s d''avances � l''ouverture .' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des Produits et Charges constat�s d''avances [F6]'+ RetourChariotSimple +
                                 '* Modifier des Produits et Charges constat�s d''avances [F2]'+ RetourChariotSimple +
                                 '* Supprimer des Produits et Charges constat�s d''avances [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de Produits et Charges constat�s d''avances [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met � jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple +
                                 'G�n�ration Automatique des OD d''ouverture dans le menu'+ RetourChariotSimple +
                                 '>> Ecritures >>'+ RetourChariotSimple +
                                 '       >> Reprise situation de d�but >>'+ RetourChariotSimple +
                                 '                                  >> Charges et produits constat�s d''avances >>'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
ChargesAPayer_IsaRxSBInfoVersionWarning = 'Saisie des Charges � payer et des Produits � recevoir � l''ouverture .' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des Charges � payer et des Produits � recevoir [F6]'+ RetourChariotSimple +
                                 '* Modifier des Charges � payer et des Produits � recevoir [F2]'+ RetourChariotSimple +
                                 '* Supprimer des Charges � payer et des Produits � recevoir [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de Charges � payer et de Produits � recevoir [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met � jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple +
                                 'G�n�ration Automatique des OD d''ouverture dans le menu'+ RetourChariotSimple +
                                 '>> Ecritures >>'+ RetourChariotSimple +
                                 '       >> Reprise situation de d�but >>'+ RetourChariotSimple +
                                 '                                  >> Charges � payer et des Produits � recevoir  >>'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
Provisions_IsaRxSBInfoVersionWarning = 'Saisie des Provisions � l''ouverture.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des provisions [F6]'+ RetourChariotSimple +
                                 '* Modifier des provisions [F2]'+ RetourChariotSimple +
                                 '* Supprimer des provisions [F10]'+ RetourChariotSimple +
                                 '* Visualiser des comptes de provisions [F7]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Met � jour la balance d''ouverture'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
DeductionRxSBInfoVersionWarning = 'Saisie des d�ductions pour investissement.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des d�ductions [F6]'+ RetourChariotSimple +
                                 '* Modifier des d�ductions [F2]'+ RetourChariotSimple +
                                 '* Supprimer des d�ductions [F10]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
UtilisationDeductionRxSBInfoVersionWarning = 'Saisie de l''utilisation des d�ductions pour investissement.' + RetourChariotDouble +
                                 'Vous pouvez :'+ RetourChariotDouble +
                                 '* Ajouter des utilisation de d�ductions [F6]'+ RetourChariotSimple +
                                 '* Modifier des utilisation de d�ductions [F2]'+ RetourChariotSimple +
                                 '* Supprimer des utilisation de d�ductions [F10]'+ RetourChariotSimple +
                                 '* Aide Contextuelle [F1]'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;

ChangementExerciceDefinitifWarning = 'Vous allez changer d�finitivement d''exercice.' + RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Avez-vous fait une double sauvegarde de s�curit� pour archivage ? '+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotDouble+
                                 'Le changement d''exercice est une op�ration d�finitive, vous ne pourrez pas l''annuler'+ RetourChariotSimple +
                                 '(sinon par restauration d''une sauvegarde)'+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Voulez-vous commencer le changement d''exercice maintenant ?'+ RetourChariotSimple +
                                 '(si vous n''avez pas fait de sauvegarde r�pondez - NON -)';

ChangementExerciceDefinitifWarning2 = 'Pour accepter le rapport de cl�ture et continuer le changement d''exercice.' + RetourChariotSimple +
                                 'cliquez sur le bouton "Oui". '+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Pour abandonner le changement d''exercice'+ RetourChariotSimple +
                                 'Cliquez sur le bouton "Non".'+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Pour revenir au rapport de cl�ture'+ RetourChariotSimple +
                                 'Cliquez sur le bouton "Annuler".'+ RetourChariotDouble +
                                 '---------------------------------------------------------------------------'+ RetourChariotDouble+
                                 'Acceptez-vous le rapport de cl�ture ?'+ RetourChariotSimple ;
ContinuerOuAnnuler             = RetourChariotDouble+
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Cliquez sur "Ok" pour continuer ou bien Annuler'+ RetourChariotSimple+
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple;
RappelEpuration                = 'Attention, l''�puration est une op�ration d�finitive qui consiste �' + RetourChariotSimple +
                                 '"SUPPRIMER" les �critures sur des exercices cl�tur�s'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Si votre dossier est volumineux (nombreuses �critures chaque ann�e, plusieurs'+ RetourChariotSimple +
                                 'ann�es enregistr�es) son �puration permettra � Epic�a de travailler plus'+ RetourChariotSimple +
                                 'rapidement et de r�duire la taille des sauvegardes.'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'Les �critures �pur�es ne pourront plus �tre consult�es dans Epic�a'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotSimple+
                                 'SI VOUS N''AVEZ PAS DE PROBLEMES DE LENTEURS DANS EPICEA, L''EPURATION N''EST'+ RetourChariotSimple +
                                 'SANS DOUTE PAS UTILE.'+ RetourChariotSimple +
                                 '---------------------------------------------------------------------------'+ RetourChariotDouble+
                                 'Une lenteur dans Epic�a peut avoir diff�rentes causes, n''h�sitez pas � nous'+ RetourChariotSimple+
                                 'contacter avant de faire une �puration.'+ RetourChariotSimple ;

                  // Commun
EditionUlterieure =RetourChariotSimple+'---------------------------------------------------------------------------'+ RetourChariotSimple+
                   'Edition disponible dans une version ult�rieure.'+ RetourChariotSimple +
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
ErrInterne ='Erreur Interne Epic�a : ';
// Tiers

////****Penser � changer le nom des constantes en suivant la nomenclature *****

/// Attention, on te surveille du coin de l'oeil !!!!!///////

HintEdnom = 'Nom du Tiers en cours';
Item0Liste1 = 'C=Client';
Item1Liste1 = 'F=Fournisseur';
Item2Liste1 = 'D=Client & Fournisseur';
Item3Liste1 = 'P=Personnel';
Item4Liste1 = 'O=Organisme Sociaux';
Item5Liste1 = 'A=Associ�s';
Item6Liste1 = 'T=Tous';

//SaisieReglementGrReglementCommaTextDebit = '," ",Compte,R�f�rence,Date,Libelle,Encaisser,Pointages,Reste,Imputation';
//SaisieReglementGrReglementCommaTextCredit = '," ",Compte,R�f�rence,Date,Libelle,D�caisser,Pointages,Reste,Imputation';
SaisieReglementGrReglementCommaTextDebit = ',Compte,R�f�rence,Date,Libelle,Encaisser,Pointages,Reste,Imputation';
SaisieReglementGrReglementCommaTextCredit = ',Compte,R�f�rence,Date,Libelle,D�caisser,Pointages,Reste,Imputation';

SaisieReglementhcCompteLibelleCompte='Reste � R�gler : ';
//GrAmortissementCommaText = '," ",Lin�aire,D�gressif';
GrAmortissementCommaText = ',Lin�aire,D�gressif';
SuppressionDesPointages='Attention, si vous choisissez de modifier cette pi�ce, tous les pointages associ�s � cette pi�ce seront supprim�s, Confirmez-vous votre choix !';
Mettre_A_Jour_Date_Livraison1='Voulez-vous mettre � jour la date de livraison de toutes les lignes de cette pi�ce ?';
Mettre_A_Jour_Date_Livraison2='Attention, en r�pondant NON, '+ RetourChariotSimple +
                              'la TVA sur D�bit de cette pi�ce sera d�clar�e avant la date de la facture.'+ RetourChariotSimple +
                              'Ce n''est pas une situation normale. Nous vous reposons la question :'+ RetourChariotSimple +
                              'Souhaitez-vous que la TVA sur D�bit de cette pi�ce soit d�clar�e A LA MEME DATE que la facture ?';
CompteImporte_DossierDos = ' Ce compte ne peut pas �tre supprim� car il fait partie d''une importation d''un dossier DOS !';
//Acces aux Ecrans
AccesEcranRefuse_General='Cet �cran n''est pas disponible dans le contexte actuel';
//Acces aux procedure
AccesProcedureRefuse_General='Cette proc�dure n''est pas disponible dans le contexte actuel';
AccesProcedureRefuse_SurDate='Cette proc�dure n''est pas disponible dans la p�riode que vous avez s�lectionn�e';
VersionUlterieur='Cette proc�dure n''est pas disponible dans cette version';

LibelleRegulTva='R�gularisation pour arrondis de tva                                                                     ';
StringVideDixCaractere='          ';
StringVideCentsCaractere='                                                                                                    ';
Desole='D�sol�, aucune information ne r�pond � votre demande.';
AccesRefuseExoN1='Vous ne pouvez pas acc�der � ce menu, sur cet exercice'+#13+#10+'tant que l''exercice pr�c�dent n''est pas clotur�.';
EmpecheSuppressionDerniereDeclarationTVA='Pour supprimer la derni�re d�claration de tva, vous devez passer par le menu "Gestion - TVA".';
Nous='LeGrain S.A.';

// Remonte les Sommes tri�es par Code de Tva en distinguant les montants a d�clarer de ceux non a d�clarer
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

// Remonte les Sommes tri�es par Code de Tva en distinguant les montants a d�clarer de ceux non a d�clarer
// Ordre d�croissant sur Code TVa
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
