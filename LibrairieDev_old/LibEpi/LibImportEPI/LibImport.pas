unit LibImport;

interface

uses
 Classes,Dialogs,SysUtils,
 StrUtils,
 Lib_chaine,
 LibFichRep,
 E2_Librairie_Obj,
 E2_Decl_Records,
 LibZoneSaisie,
 LibDates,
 Gr_Librairie_Obj,
 ChoixPeriode,
 Forms,
 Windows,
 LibRessourceString,
 Controls;

Type

TImportEcriture=record
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
  end;
PImportEcriture=^TImportEcriture;

TImportPiece=record
    ID:integer;//1
    IDJournal:integer;//6
    Reference:string[9];
    Date:Tdate;
    Validation:Tdate;
    Libelle:string[100];
    Compte:string[8];
    Journal:string[2];
    AutoGeneree:boolean;
    retour:boolean;
    TotalPiece:currency;//8
    Code:string[2];
    Echeance:string[10];
    Num:string[3];
    TypePiece:string[3];
    bool:string[1];
end;
PImportPiece=^TImportPiece;


TImportTrame=record //57
    Journal:string[1];
    CodeTrame:string[3];
    Libelle:string[30];
    Vide1:string[5];
    Compte:string[8];
    Vide2:string[2];
    CptBanque:string[8];
end;
PImportTrame=^TImportTrame;

TImportLigneTrame=record //116
    Journal:string[1];
    CodeTrame:string[3];
    Compte:string[8];
    Libelle:string[23];
    Sens:string[1];
    NumLigne:String[3];
    MontantHt:String[10];
    MontantTVA:String[10];
    CodeTVA:string[1];
    TypeTVA:String[1];
    TauxTVA:String[8];
    CompteRepartition:string[8];
    TauxRepartition:string[8];
    Vide1:string[8];
    LibelleRepartition:string[23];
  end;
PImportLigneTrame=^TImportLigneTrame;



TImport_E2FAC = Record
 idTmp:String[5];
 ReferenceInitial:string[9];
 NumPiece:string[5];
 NumLigne:string[3];
 TypePiece:string[1];
 Reference:string[9];
 DatePiece:String[8];
 CompteLigne:String[8];
 Libelle:String[23];
 MontantDebit:String[12];
 MontantCredit:String[12];
 Qte1:String[9];
 Qte2:String[9];
 CodeTVA:String[1];
 TauxTVA:String[6];
 MontantDebitTVA:String[11];
 MontantCreditTVA:String[11];
 DateEcheancePiece:String[8];
 CompteColl:String[8];
 NomTiers:String[30];
 Adr1:String[30];
 Adr2:String[30];
 CodePostal:String[5];
 Ville:String[25];
 ExibiliteTVA:String[1];
 DateLivraisonLigne:String[8];
 { isa  le  12/12/03 }
 Enregistrer:string[1];//'1'(pour oui) ou '0'(pour non)
 CompteTva:string[8];
 { isa  le  12/12/03 }
 RefContrepartie:string[9];
 DateContrepartie:string[8];
 MontantDebitContrepartie:String[11];
 MontantCreditContrepartie:String[11];
 MontantPointage:String[11];
 end;

  PImport_E2FAC=^TImport_E2FAC;

 // Record qui sert à la lecture du fichier E3-CDIV.TXT ( fichier exporté par Epicea dos)
TImport_CDIV = Record
 TypeL:string[3];
 DateSaise:String[10];
 Compte:String[8];
 Libelle:String[23];
 Sens:String[1];
 MontantTotalHt:String[10];
 MontantTVA:String[10];
 Qte1:String[8];
 PrixUnitaire:String[10];
 DateLivraison:String[10];
 String2:String[2];
 DateExoDeb:String[10];
 String3:String[1];
 Date3:String[10];
 String4:String[13];
 ReferenceRep:String[9];
 String5:String[3];
 CompteSecondaire:String[8];
 Qte2:String[8];
 Cloture:String[1];
 end;

// Record qui correspond aux champ de saisie des stocks dans E2Win
// ils sont initialisé dans la procedure ImportationStockEPI_D
TImport_Stock = record
 Compte:String[8];
 Designation:String[100];
 Qte:Currency;
 PrixUnitaire:Currency;
 Decote:Integer;
 PrixTHT:Currency;
 end;

// Pointeur sur TImport_Stock
  PImport_Stock=^TImport_Stock;

TImport_ChAPayer = record
 Compte:String[8];
 Designation:String[100];
 Qte:Currency;
 MontantHt:Currency;
 TVA:Currency;
 Compte2:String[8];
 end;

// Pointeur sur TImport_chAPayer
  PImport_ChAPayer=^TImport_ChAPayer;

TImport_ChPCAvance = record
 Compte:String[8];
 Designation:String[100];
 Qte:Extended;
 MontantHt:Currency;
 Compte2:String[8];
 end;

// Pointeur sur TImport_chAPayer
  PImport_ChPCAvance=^TImport_ChPCAvance;

TImport_Provisions = record
 Compte:String[8];
 Designation:String[100];
 MtTotalProvision:Currency;
 MtBilanOuverture:Currency;
 end;

// Pointeur sur TImport_chAPayer
  PImport_Provisions=^TImport_Provisions;

TImport_ChARepartir = record
 Compte:String[8];
 Designation:String[100];
 MtTotalCharge:Currency;
 MtBilanOuverture:Currency;
 end;

// Pointeur sur TImport_chAPayer
  PImport_ChARepartir=^TImport_ChARepartir;

//**************************************************************************************
// Record qui sert à la lecture du fichier E3-CPLC.TXT ( fichier exporté par Epicea dos)
// Longueur totale : 90 ! ( Plan Comptable )
TImportCPLC = record
 Compte:String[8];
 Libelle:String[30];
 BilanOuvCredit:String[10];
 BilanOuvDebit:String[10];
 CodeTVA:String[1];
 TypeTVA:String[1];
 SensSaisie:String[1];
 String1:String[1];
 Collectif:String[1];
 U1:String[2];
 U2:String[2];
 String2:String[22];
 Immo:String[1];
 end;

// Pointeur sur TImportCPLC
 PImport_Plan = ^TImportCPLC;

//**************************************************************************************
// Record qui sert à la lecture du fichier Planco.TXT ( fichier exporté par SIEA dos)
// Longueur totale : 36 ! ( Plan Comptable )
TImport_BO_SIEA_DOS = record
 Compte:String[8];
 ReportDebit:String[20];
 ReportCredit:String[20];
 MvtDebit:String[20];
 MvtCredit:String[20];
 Libelle:String[50];
 end;

// Pointeur sur TImportCPLC
 PImport_BO_SIEA_DOS = ^TImport_BO_SIEA_DOS;

//**************************************************************************************
// Record qui sert à la lecture du fichier E3-CTVA.TXT ( fichier exporté par Epicea dos)
// Longueur totale : 56 ! ( Code de TVA )
TImportCTVA = record
 CodeTVA:String[1];
 Libelle:String[30];
 TypeTVA:String[1];
 Compte:String[8];
 Taux1:String[8];
 Taux2:String[8];
 end;

// Pointeur sur TImportCPLC
 PImport_Tva = ^TImportCTVA;

//**************************************************************************************
// Record qui sert à la lecture du fichier E3-CPLA.TXT ( fichier exporté par Epicea dos)
// Longueur totale :  ! ( Plan Auxiliaire )
TImportCPLA = record
 Tiers:String[7];
 Nom:String[30];
 CreditDeb:String[10];
 DebitDeb:String[10];
 Compte:String[7];
 TypeTiers:String[1];
 end;

// Pointeur sur TImportCPLC
 PImport_Tiers = ^TImportCPLA;

//**************************************************************************************
// Record qui sert à la lecture du fichier E3-CJOU.TXT ( fichier exporté par Epicea dos)
// Longueur totale :  ! ( Plan Auxiliaire )
TImportCJOU = record
 Journal:String[2];
 Libelle:String[30];
 CodeInterne:String[2];
 Compte:String[7];
 Date:String[10];
 end;

// Pointeur sur TImportCJOU
 PImport_Journaux = ^TImportCJOU;

//**************************************************************************************
// Record qui sert à la lecture du fichier E3-CIMO.TXT ( fichier exporté par Epicea dos)
// Longueur totale :  ! ( Immobilisation )
TImport_CIMO = Record
 NumCpt:string[7];
 CodeImmo:String[3];
 SousCodeImmo:String[1];
 Designation:String[22];
 DateOrg:String[10];
 ValeurAvantReel:String[10];
 ValeurVenale:String[10];
 DureeTotale:String[5];
 ValeurAAmortir:String[10];
 TvaOrg:String[10];
 DateAchatPourReel:String[10];
 DateMiseEnService:String[10];
 NbMoisAmort:String[5];
 TypeEco:String[1];
 TypeFiscal:String[1];
 TauxLineaire:String[10];
 TauxDegressif:String[10];
 DeducSurInvest:String[1];
 MontantDeducSurInvest:String[10];
 ValeurNetteComptable:String[10];
 AmortEco:String[10];
 AmortDerogNonGere:String[10];
 AmortDerog:String[10];
 AmortExcept:String[8];
 MontantCession:String[10];
 DateCession:String[10];
 Rebus:String[1];
 PMVCourtTerme:String[10];
 PMVLongTerme:String[10];
 TVAAReintegreSurVente:String[1];
 MontantTVAAReintegreSurVente:String[10];
 DureeDegressif:String[3]; // En Mois
 Simulation:String[1];
 Economique:String[10];
 end;

 // Pointeur sur TImportCJOU
 PImport_Immo = ^TImport_CIMO;

TImport_Ecriture = Record
    Compte:string[7];
    DatePiece:String[10];
    ID_Piece:String[10];
    Libelle:String[22];
    Debit:String[10];
    Credit:String[10];
    Qt1:String[10];
    Qt2:String[10];
    Code:string[1];
    Journal:string[2];
    TypeLigne:string[3];
    CompteTiers:string[7];
    ID_Ecriture:string[10];
    ID_TVA:string[5];
    TypeTVA:String[1];
    Date2:string[10];
    DateTVA:string[10];
    Nombre:String[10];
    TauxTVA:String[10];
  end;
 PImport_Ecriture=^TImport_Ecriture;


 //**************************************************************************************
// Record qui sert à la lecture du fichier E3-CTVA.TXT ( fichier exporté par une caisse enregistreuse pour Bernard)
// Longueur totale : 85
TImportCaisseEnregistreuse = record
 numPiece:String[5];
 journal:String[2];
 datePiece:String[8];
 vide:String[20];
 compte:String[11];
 libelle:String[25];
 montant:String[13];
 sens:String[1];
 end;

// Pointeur sur TImportCaisseEnregistreuse
 PImportCaisseEnregistreuse = ^TImportCaisseEnregistreuse;


  //**************************************************************************************
// Record qui sert à la lecture du fichier E3-CTVA.TXT ( fichier exporté par une caisse enregistreuse pour Bernard)
// Longueur totale : 85
TImportCaisseEnregistreuseBis = record
 numPiece:String[10];
 journal:String[2];
 compte:String[11];
 datePiece:String[10];
 referenceEcriture:String[100];
 libelle:String[100];
 debit:String[13];
 credit:String[13];
  sens:String[1];
 end;

// Pointeur sur TImportCaisseEnregistreuse
 PImportCaisseEnregistreuseBis = ^TImportCaisseEnregistreuseBis;


//**************************************************************************************
// Record qui sert à la lecture du fichier Leglis.asc ( fichier exporté par SIEA2I )
// Longueur totale :  ! ( Immobilisation )
TImport_CIMO_SIEA2I = Record
 Designation:String[20];
 TypeImmo:String[1];
 TypeFiscal:String[1];
 CodeCompte:String[2];
 DureeTotale:String[2];
 CodeTva:String[1];
 MontantTva:String[12];
 DateAchat:String[10];
 DateAchatPourReel:String[10];//ce champ ne figure pas dans le fichier texte
 ValeurAAmortir:String[12];
 DateCession:String[10];
 MontantCession:String[12];
 AnneeChangement:string[4];
 ValeurAjustee:string[12];
 Conteneur80:String[80];
 Mois_Jour_Changement:string[4];
 Affectation:String[6];
 conteneur11:String[11];{ isa  le  17/02/04 }
// conteneur14:String[14];
 ValeurNetteComptable:String[13];{ isa  le  17/02/04 }
// ValeurNetteComptable:String[10];

 NumCpt:string[8];
 AmortEco:String[10];

// CodeImmo:String[3];
// SousCodeImmo:String[1];
// DateOrg:String[10];
// ValeurAvantReel:String[10];
// ValeurVenale:String[10];
// TvaOrg:String[10];
// DateMiseEnService:String[10];
// NbMoisAmort:String[5];
// TypeEco:String[1];
// TauxLineaire:String[10];
// TauxDegressif:String[10];
// DeducSurInvest:String[1];
// MontantDeducSurInvest:String[10];
// AmortDerogNonGere:String[10];
// AmortDerog:String[10];
// AmortExcept:String[8];
// Rebus:String[1];
// PMVCourtTerme:String[10];
// PMVLongTerme:String[10];
// TVAAReintegreSurVente:String[1];
// MontantTVAAReintegreSurVente:String[10];
// DureeDegressif:String[3]; // En Mois
// Simulation:String[1];
// Economique:String[10];
 end;

   TReleveBancaire_Obj=Class(Tobject)
    Tcompte:string;
    TDesignation:string;
    Tsupplement:string;
    TdateOp:TDate;
    TMontantDebit:currency;
    TMontantCredit:currency;
    TFichierImport:string;
    Tmarque:string;
    private
    property compte:string read Tcompte write Tcompte;
    property Designation:string read TDesignation write TDesignation;
    property supplement:string read Tsupplement write Tsupplement;
    property dateOp:TDate read TdateOp write TdateOp;
    property MontantDebit:currency read TMontantDebit write TMontantDebit;
    property MontantCredit:currency read TMontantCredit write TMontantCredit;
    property FichierImport:string read TFichierImport write TFichierImport;
    property marque:string read Tmarque write Tmarque;

  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;

 // Pointeur sur TImportCJOU
 PImport_CIMO_SIEA2I = ^TImport_CIMO_SIEA2I;


 Procedure ImportationE2FAC(NomFichier:String;Var ListeE2FAC:TList);
 Procedure ImportationCaisseEnregistreuse(NomFichier:String;Var ListeCaisse:TList);
 Procedure ImportationCaisseEnregistreuse_MicoPointe(NomFichier:String;Var ListeCaisse:TList);
  Procedure ImportationCaisseEnregistreuseBernard(NomFichier:String;Var ListeCaisse:TList);
    Procedure ImportationCaisseEnregistreuse_MicroPointeBis(NomFichier:String;Var ListeCaisse:TList);
 Procedure ImportationStockEPI_D(NomFichier:String;Var ListeStock:TList);
 Procedure ImportationChAPayerEPI_D(NomFichier:String;Var ListeChargeAPayer,ListeProduitARecevoir:TList);
 Procedure ImportationChPCAvanceEPI_D(NomFichier:String;Var ListeChargesCAvance,ListeProduitCAVance:TList);
 Procedure ImportationChARepartirEPI_D(NomFichier:String;Var ListeChARepartir:TList);
 Procedure ImportationProvisionsEPI_D(NomFichier:String;Var ListeProvision:TList);
 Procedure ImportationPlanEPI_DOS_ENTIER(NomFichier:String;Var ListeCompte:TList);
 Procedure ImportationBO_SIEA_DOS(NomFichier:String;Var ListeCompte:TList);
 Procedure ImportationCodeTvaEPI_DOS(NomFichier:String;Var ListeCodeTva:TList);
 Procedure ImportationPlanAuxEPI_DOS(NomFichier:String;Var ListeTiers:TList);
 Procedure ImportationJournaux(NomFichier:String;Var ListeJournaux:TList);
 Procedure ImportationImmo(NomFichier:String;Var ListeImmo:TList);
// Procedure ImportationChargesAPayerEPI_D(NomFichier:String;Var ListeChargeAPayer,ListeProduitARecevoir:TList);
// Procedure InitialisePImport_Stock(var Import_Stock:PImport_Stock);
 Procedure ImportationLigneTrameEPI_DOS(NomFichier:String;Var ListePiece:TList);
Procedure ImportationTrameEPI_DOS(NomFichier:String;Var ListePiece:TList);
function recupTotalTiers(ListeTiers:TList):real;
function recupTotalTiersBis(ListeTiers:TList):real;

 //pour Bloquel
Procedure ImportationPieceEPI_DOS_PourBloquel(NomFichier:String;Var ListePiece,ListeOrigine:TList);
 Procedure ImportationEcrituresEPI_DOS_PourBloquel(NomFichier:String;Var ListeEcritures,ListeOrigine:TList);
 /////
 //Pour Cogere
 Procedure ImportationImmo_SIEA2I(NomFichier:String;Var ListeImmo:TList);
Procedure InitialisePImport_E2FAC(var Import_E2FAC:PImport_E2FAC);
function TriListe(LaListe: TStringList; Index1, Index2: Integer): Integer;
implementation

uses DMRecherche, E2_LibInfosTable, LibSQL, DMJournaux, DMPlanCpt, StdVCL,
  DMTier, DMTVA;


Procedure InitialisePImportTrame(var ImportTrame:PImportTrame);
Begin
    ImportTrame.Journal:=C_StrVide;
    ImportTrame.CodeTrame:=C_StrVide;
    ImportTrame.Libelle:=C_StrVide;
    ImportTrame.Vide1:=C_StrVide;
    ImportTrame.Compte:=C_StrVide;
    ImportTrame.Vide2:=C_StrVide;
    ImportTrame.CptBanque:=C_StrVide;
end;


Procedure InitialisePImportLigneTrame(var ImportLigneTrame:PImportLigneTrame);
begin
    ImportLigneTrame.Journal:=C_StrVide;
    ImportLigneTrame.CodeTrame:=C_StrVide;
    ImportLigneTrame.Compte:=C_StrVide;
    ImportLigneTrame.Libelle:=C_StrVide;
    ImportLigneTrame.Sens:=C_StrVide;
    ImportLigneTrame.NumLigne:=C_StrVide;
    ImportLigneTrame.MontantHt:=C_StrVide;
    ImportLigneTrame.MontantTVA:=C_StrVide;
    ImportLigneTrame.CodeTVA:=C_StrVide;
    ImportLigneTrame.TypeTVA:=C_StrVide;
    ImportLigneTrame.TauxTVA:=C_StrVide;
    ImportLigneTrame.CompteRepartition:=C_StrVide;
    ImportLigneTrame.TauxRepartition:=C_StrVide;
    ImportLigneTrame.Vide1:=C_StrVide;
    ImportLigneTrame.LibelleRepartition:=C_StrVide;
end;


Procedure InitialisePImport_E2FAC(var Import_E2FAC:PImport_E2FAC);
Begin
Import_E2FAC.NumPiece:=C_StrVide;  //StrNbCaractere
Import_E2FAC.NumLigne:=C_StrVide;
Import_E2FAC.TypePiece:=C_StrVide;
Import_E2FAC.Reference:=C_StrVide;
Import_E2FAC.DatePiece:=C_StrVide;
Import_E2FAC.CompteLigne:=C_StrVide;
Import_E2FAC.Libelle:=C_StrVide;
Import_E2FAC.MontantDebit:=C_StrVide;
Import_E2FAC.MontantCredit:=C_StrVide;
Import_E2FAC.Qte1:=C_StrVide;
Import_E2FAC.Qte2:=C_StrVide;
Import_E2FAC.CodeTVA:=C_StrVide;
Import_E2FAC.TauxTVA:=C_StrVide;
Import_E2FAC.MontantDebitTVA:=C_StrVide;
Import_E2FAC.MontantCreditTVA:=C_StrVide;
Import_E2FAC.DateEcheancePiece:=C_StrVide;
Import_E2FAC.CompteColl:=C_StrVide;
Import_E2FAC.NomTiers:=C_StrVide;
Import_E2FAC.Adr1:=C_StrVide;
Import_E2FAC.Adr2:=C_StrVide;
Import_E2FAC.CodePostal:=C_StrVide;
Import_E2FAC.Ville:=C_StrVide;
Import_E2FAC.ExibiliteTVA:=C_StrVide;
Import_E2FAC.DateLivraisonLigne:=C_StrVide;
Import_E2FAC.Enregistrer:='0';
Import_E2FAC.CompteTva:=C_StrVide;
Import_E2FAC.RefContrepartie:= C_StrVide;
Import_E2FAC.DateContrepartie:=C_StrVide;
Import_E2FAC.MontantDebitContrepartie:=C_StrVide;
Import_E2FAC.MontantCreditContrepartie:=C_StrVide;
End;

Procedure InitialisePImport_Stock(var Import_Stock:PImport_Stock);
Begin
Import_Stock.Compte:=C_StrVide;
Import_Stock.Decote:=0;
Import_Stock.Designation:=C_StrVide;
Import_Stock.Qte:=0;
Import_Stock.PrixUnitaire:=0;
Import_Stock.Decote:=0;
Import_Stock.PrixTHT:=0;
End;

Procedure InitialisePImport_ChAPayer(var Import_ChAPayer:PImport_ChAPayer);
Begin
Import_ChAPayer.Compte:=C_StrVide;
Import_ChAPayer.Designation:=C_StrVide;
Import_ChAPayer.Qte:=0;
Import_ChAPayer.MontantHt:=0;
Import_ChAPayer.TVA:=0;
Import_ChAPayer.Compte2:=C_StrVide;
End;

Procedure InitialisePImport_ChPCAvance(var Import_ChPCAvance:PImport_ChPCAvance);
Begin
Import_ChPCAvance.Compte:=C_StrVide;
Import_ChPCAvance.Designation:=C_StrVide;
Import_ChPCAvance.Qte:=0.00;
Import_ChPCAvance.MontantHt:=0;
Import_ChPCAvance.Compte2:=C_StrVide;
End;

Procedure InitialisePImport_Provision(Var Import_Provisions:PImport_Provisions);
Begin
Import_Provisions.Compte:=C_StrVide;
Import_Provisions.Designation:=C_StrVide;
Import_Provisions.MtBilanOuverture:=0;
Import_Provisions.MtTotalProvision:=0;
End;

Procedure InitialisePImport_ChARepartir(Var Import_ChARepartir:PImport_ChARepartir);
Begin
Import_ChARepartir.Compte:=C_StrVide;
Import_ChARepartir.Designation:=C_StrVide;
Import_ChARepartir.MtBilanOuverture:=0;
Import_ChARepartir.MtTotalCharge:=0;
End;

Procedure InitialisePImport_Journaux(Var Import_Journaux:PImport_Journaux);
Begin
Import_Journaux.Journal:=C_StrVide;
Import_Journaux.Libelle:=C_StrVide;
Import_Journaux.CodeInterne:=C_StrVide;
Import_Journaux.Compte:=C_StrVide;
Import_Journaux.Date:=C_StrVide;
end;

Procedure InitialisePImport_Immo(Var Import_Immo:PImport_Immo);
Begin
Import_Immo.NumCpt:=C_StrVide;
Import_Immo.CodeImmo:=C_StrVide;
Import_Immo.SousCodeImmo:=C_StrVide;
Import_Immo.Designation:=C_StrVide;
Import_Immo.DateOrg:=C_StrVide;
Import_Immo.ValeurAvantReel:=C_StrVide;
Import_Immo.ValeurVenale:=C_StrVide;
Import_Immo.DureeTotale:=C_StrVide;
Import_Immo.ValeurAAmortir:=C_StrVide;
Import_Immo.TvaOrg:=C_StrVide;
Import_Immo.DateAchatPourReel:=C_StrVide;
Import_Immo.DateMiseEnService:=C_StrVide;
Import_Immo.NbMoisAmort:=C_StrVide;
Import_Immo.TypeEco:=C_StrVide;
Import_Immo.TypeFiscal:=C_StrVide;
Import_Immo.TauxLineaire:=C_StrVide;
Import_Immo.TauxDegressif:=C_StrVide;
Import_Immo.DeducSurInvest:=C_StrVide;
Import_Immo.MontantDeducSurInvest:=C_StrVide;
Import_Immo.ValeurNetteComptable:=C_StrVide;
Import_Immo.AmortEco:=C_StrVide;
Import_Immo.AmortDerogNonGere:=C_StrVide;
Import_Immo.AmortDerog:=C_StrVide;
Import_Immo.AmortExcept:=C_StrVide;
Import_Immo.MontantCession:=C_StrVide;
Import_Immo.DateCession:=C_StrVide;
Import_Immo.Rebus:=C_StrVide;
Import_Immo.PMVCourtTerme:=C_StrVide;
Import_Immo.PMVLongTerme:=C_StrVide;
Import_Immo.TVAAReintegreSurVente:=C_StrVide;
Import_Immo.MontantTVAAReintegreSurVente:=C_StrVide;
Import_Immo.DureeDegressif:=C_StrVide;
Import_Immo.Simulation:=C_StrVide;
Import_Immo.Economique:=C_StrVide;
end;

procedure InitialisePImport_Ecriture(Var Import_Ecriture:PImport_Ecriture);
begin
    Import_Ecriture.Compte:=C_StrVide;
    Import_Ecriture.DatePiece:=C_StrVide;
    Import_Ecriture.ID_Piece:=C_StrVide;
    Import_Ecriture.Libelle:=C_StrVide;
    Import_Ecriture.Debit:=C_StrVide;
    Import_Ecriture.Credit:=C_StrVide;
    Import_Ecriture.Qt1:=C_StrVide;
    Import_Ecriture.Qt2:=C_StrVide;
    Import_Ecriture.Code:=C_StrVide;
    Import_Ecriture.Journal:=C_StrVide;
    Import_Ecriture.TypeLigne:=C_StrVide;
    Import_Ecriture.CompteTiers:=C_StrVide;
    Import_Ecriture.ID_Ecriture:=C_StrVide;
    Import_Ecriture.ID_TVA:=C_StrVide;
    Import_Ecriture.TypeTVA:=C_StrVide;
    Import_Ecriture.Date2:=C_StrVide;
    Import_Ecriture.DateTVA:=C_StrVide;
    Import_Ecriture.Nombre:=C_StrVide;
    Import_Ecriture.TauxTVA:=C_StrVide;
end;

Procedure InitialisePImport_CIMO_SIEA2I(Var Import_IMO_SIEA2I:PImport_CIMO_SIEA2I);
Begin
 Import_IMO_SIEA2I.Designation:=C_StrVide;
 Import_IMO_SIEA2I.TypeImmo:=C_StrVide;
 Import_IMO_SIEA2I.TypeFiscal:=C_StrVide;
 Import_IMO_SIEA2I.CodeCompte:=C_StrVide;
 Import_IMO_SIEA2I.DureeTotale:=C_StrVide;
 Import_IMO_SIEA2I.CodeTva:=C_StrVide;
 Import_IMO_SIEA2I.MontantTva:=C_StrVide;
 Import_IMO_SIEA2I.DateAchatPourReel:=C_StrVide;
 Import_IMO_SIEA2I.ValeurAAmortir:=C_StrVide;
 Import_IMO_SIEA2I.DateCession:=C_StrVide;
 Import_IMO_SIEA2I.MontantCession:=C_StrVide;
 Import_IMO_SIEA2I.AnneeChangement:=C_StrVide;
 Import_IMO_SIEA2I.ValeurAjustee:=C_StrVide;
 Import_IMO_SIEA2I.Conteneur80:=C_StrVide;
 Import_IMO_SIEA2I.Mois_Jour_Changement:=C_StrVide;
 Import_IMO_SIEA2I.Affectation:=C_StrVide;
 Import_IMO_SIEA2I.conteneur11:=C_StrVide;
 Import_IMO_SIEA2I.ValeurNetteComptable:=C_StrVide;
 Import_IMO_SIEA2I.NumCpt:=C_StrVide;
 Import_IMO_SIEA2I.AmortEco:=C_StrVide;
end;

Procedure InitialisePImport_BO_SIEA_DOS(Var Import_BO_SIEA_DOS:PImport_BO_SIEA_DOS);
Begin
 Import_BO_SIEA_DOS.Compte:=C_StrVide;
 Import_BO_SIEA_DOS.MvtDebit:='0';
 Import_BO_SIEA_DOS.MvtCredit:='0';
 Import_BO_SIEA_DOS.ReportDebit:='0';
 Import_BO_SIEA_DOS.ReportCredit:='0';
 Import_BO_SIEA_DOS.Libelle:=C_StrVide;
end;

Procedure ImportationE2FAC(NomFichier:String;Var ListeE2FAC:TList);
var
  Fichier: TextFile;
  Import_E2FAC,Tva_A_Replacer:PImport_E2FAC;
  conteneurDebit,conteneurCredit:currency;
  ListeTva_A_Replacer:TList;
  i,j:integer;
  trouve,TvaAReplacer:boolean;
Begin
If ListeE2FAC = nil then
 Begin
  Showmessage('La Liste d''importation d''E2FAC est nil!');
  abort;
 End;
 ListeTva_A_Replacer:=TList.Create;
 ListeE2FAC.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);

 while not Eof(Fichier) do
  begin
   New(Import_E2FAC);
   InitialisePImport_E2FAC(Import_E2FAC);
    TvaAReplacer:=false;
   ReadLn(Fichier,
          Import_E2FAC.NumPiece,
          Import_E2FAC.NumLigne,
          Import_E2FAC.TypePiece,
          Import_E2FAC.Reference,
          Import_E2FAC.DatePiece,
          Import_E2FAC.CompteLigne,
          Import_E2FAC.Libelle,
          Import_E2FAC.MontantDebit,
          Import_E2FAC.MontantCredit,
          Import_E2FAC.Qte1,
          Import_E2FAC.Qte2,
          Import_E2FAC.CodeTVA,
          Import_E2FAC.TauxTVA,
          Import_E2FAC.MontantDebitTVA,
          Import_E2FAC.MontantCreditTVA,
          Import_E2FAC.DateEcheancePiece,
          Import_E2FAC.CompteColl,
          Import_E2FAC.NomTiers,
          Import_E2FAC.Adr1,
          Import_E2FAC.Adr2,
          Import_E2FAC.CodePostal,
          Import_E2FAC.Ville,
          Import_E2FAC.ExibiliteTVA,
          Import_E2FAC.DateLivraisonLigne,
          Import_E2FAC.RefContrepartie,
          Import_E2FAC.DateContrepartie,
          Import_E2FAC.MontantDebitContrepartie,
          Import_E2FAC.MontantCreditContrepartie,                   //  Import_E2FAC.Reference:=Import_E2FAC.TypePiece+'00000000';
          Import_E2FAC.MontantPointage);
       if(str_souschaine(trim(Import_E2FAC.Reference),1,4)<>'')then
           while(Length(trim(Import_E2FAC.Reference))<9 )do
           begin

              Import_E2FAC.Reference:=str_souschaine(Import_E2FAC.Reference,1,4)+'0'+ trim(str_souschaine(Import_E2FAC.Reference,5,10));
           end;
       if(Length(trim(Import_E2FAC.RefContrepartie))>0)then
           while(Length(trim(Import_E2FAC.RefContrepartie))<9 )do
           begin
              Import_E2FAC.RefContrepartie:=str_souschaine(Import_E2FAC.RefContrepartie,1,4)+'0'+ trim(str_souschaine(Import_E2FAC.RefContrepartie,5,10));
           end;
       Import_E2FAC.MontantDebit:=ChangeDecimalSeparator(Import_E2FAC.MontantDebit);
       Import_E2FAC.MontantCredit:=ChangeDecimalSeparator(Import_E2FAC.MontantCredit);
       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebit);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCredit);
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebit:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCredit:=currtostr(conteneurCredit);

       conteneurDebit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantDebitTVA));
       conteneurCredit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantCreditTVA));
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitTVA:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditTVA:=currtostr(conteneurCredit);

       Import_E2FAC.TauxTVA:=ChangeDecimalSeparator(Import_E2FAC.TauxTVA);

       TvaAReplacer:=((strtocurr_lgr(Import_E2FAC.MontantDebit)>0)and(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0))or
       ((strtocurr_lgr(Import_E2FAC.MontantCredit)>0)and(strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0));

       if ((strtocurr_lgr(Import_E2FAC.MontantDebit)-strtocurr_lgr(Import_E2FAC.MontantCredit)=0)
       and ((strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0)or(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0)))or
        (TvaAReplacer) then
       begin //si ligne à zéro, on garde la tva pour une prochaine ligne
           i:=0;
           while (i<ListeTva_A_Replacer.Count)and(trouve=false) do
           begin
             trouve:=(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.CodeTVA=Import_E2FAC.CodeTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[i])^.TauxTVA=Import_E2FAC.TauxTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[i])^.NumPiece=Import_E2FAC.NumPiece);
             if not trouve then inc(i);
           end;
           if not trouve then
             begin
               new(Tva_A_Replacer);
               Tva_A_Replacer.NumPiece:=Import_E2FAC.NumPiece;
               Tva_A_Replacer.CodeTVA:=Import_E2FAC.CodeTVA;
               Tva_A_Replacer.TauxTVA:=Import_E2FAC.TauxTVA;
               Tva_A_Replacer.MontantDebitTVA:=Import_E2FAC.MontantDebitTVA;
               Tva_A_Replacer.MontantCreditTVA:=Import_E2FAC.MontantCreditTVA;
               ListeTva_A_Replacer.add(Tva_A_Replacer);
             end
           else
             begin
               PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantDebitTVA)+strtocurr_lgr(Import_E2FAC.MontantDebitTVA));
               PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantCreditTVA)+strtocurr_lgr(Import_E2FAC.MontantCreditTVA));
             end;
           Import_E2FAC.MontantDebitTVA:='0';
           Import_E2FAC.MontantCreditTVA:='0';
       end;

       Import_E2FAC.Libelle:=str_ImportDosToWin(Import_E2FAC.Libelle);
       Import_E2FAC.NomTiers:=str_ImportDosToWin(Import_E2FAC.NomTiers);
       Import_E2FAC.Adr1:=str_ImportDosToWin(Import_E2FAC.Adr1);
       Import_E2FAC.Adr2:=str_ImportDosToWin(Import_E2FAC.Adr2);
       Import_E2FAC.Ville:=str_ImportDosToWin(Import_E2FAC.Ville);
       Import_E2FAC.CompteColl:=str_ImportDosToWin(Import_E2FAC.CompteColl);

       Import_E2FAC.CompteLigne:=str_ImportDosToWin(Import_E2FAC.CompteLigne);


       Import_E2FAC.Qte1:=ChangeDecimalSeparator(Import_E2FAC.Qte1);
       Import_E2FAC.Qte2:=ChangeDecimalSeparator(Import_E2FAC.Qte2);
       if ((((ord(Import_E2FAC.CodeTVA[1])=66)or(ord(Import_E2FAC.CodeTVA[1])=86))) and (VerifNumeric(Import_E2FAC.TauxTVA).VideOUZero)) then
        begin
          Import_E2FAC.CodeTVA:='';
          Import_E2FAC.ExibiliteTVA:='';
        end;
       try
       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebitContrepartie);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCreditContrepartie);
       except
          conteneurDebit:=0;
          conteneurCredit:=0;
       end;
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitContrepartie:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditContrepartie:=currtostr(conteneurCredit);
       Import_E2FAC.MontantPointage:=Import_E2FAC.MontantPointage;
   ListeE2FAC.Add(Import_E2FAC);
  end;
//rechercher dans les lignes existantes, une ligne du même code tva pour lui rajouter cette partie de tva
  j:=0;
  while (j<=ListeTva_A_Replacer.Count-1)do
//        while (ListeTva_A_Replacer.Count<>0)do
    begin
       i:=0;
       while (i<=ListeE2FAC.count-1) and (j<=ListeTva_A_Replacer.Count-1)and ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)>0)
             or(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)>0)) do
         begin            //  PImport_E2FAC(ListeTva_A_Replacer.Items[j])^
            if (PImport_E2FAC(ListeE2FAC.Items[i])^.CodeTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.CodeTVA)
              and(PImport_E2FAC(ListeE2FAC.Items[i])^.TauxTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.TauxTVA)
              and (PImport_E2FAC(ListeE2FAC.Items[i])^.NumPiece=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.NumPiece) then
              begin
                 if strtocurr_lgr(PImport_E2FAC(ListeE2FAC.Items[i])^.MontantDebit)>0 then
                   begin
                       PImport_E2FAC(ListeE2FAC.Items[i])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeE2FAC.Items[i])^.MontantDebitTVA)+
                         strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA));
                       PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA:='0';
                   end
                 else
                 if strtocurr_lgr(PImport_E2FAC(ListeE2FAC.Items[i])^.MontantCredit)>0 then
                 begin
                   PImport_E2FAC(ListeE2FAC.Items[i])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeE2FAC.Items[i])^.MontantCreditTVA)+
                     strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA));
                   PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA:='0';
                 end;
              end;
            if ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)=0) and (strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)=0)) then
               begin
                 ListeTva_A_Replacer.Delete(j);
                 if j>0 then
                   dec(j);
               end;
            inc(i);
         end;
    inc(j);
    end;
CloseFile(Fichier); // ferme le fichier
Initialise_TList(ListeTva_A_Replacer);
End;


Procedure ImportationCaisseEnregistreuse(NomFichier:String;Var ListeCaisse:TList);
var
  Fichier: TextFile;
  Import_E2FAC,Tva_A_Replacer:PImport_E2FAC;
  conteneurDebit,conteneurCredit:currency;
  ListeTva_A_Replacer:TList;
  i,j,numLigne,NumPiece,k:integer;
  trouve,TvaAReplacer:boolean;
  listeIn,liste5,listeAutre,listeTemp,listeTva,listeContrepartie,listePointage:TStringlist;
  NumPieceEncours,NumPieceOld,TypePiece,ligneEnCours,
  codeTva,tauxTva,tauxTvaDefaut,ligneContrepartie,DatePiece,lignePointage,ligneContrepartieReglement,conteneur:string;
  sep:char;
    conteneurTVADebit,conteneurTVACredit:currency;
    tauxDecrit:boolean;
Begin
try
sep:=';';
listeIn:=TStringList.Create;
liste5:=TStringList.Create;
listeAutre:=TStringList.Create;
listeTemp :=TStringList.Create;
listeTva :=TStringList.Create;
listeContrepartie:=TStringList.Create;
listePointage:=TStringList.Create;
tauxTvaDefaut:=e.TauxTvaCaisseEnregistreuse;
If ListeCaisse = nil then
 Begin
  Showmessage('La Liste d''importation de la caisse est nulle!');
  abort;
 End;
 if(listeIn.Count>0)then tauxDecrit:=Str_Count_Str(listeIn[0],sep)>7;
 ListeTva_A_Replacer:=TList.Create;
 ListeCaisse.Clear;

 listeIn.CustomSort(TriListe);
 liste5.CustomSort(TriListe);
 listeAutre.CustomSort(TriListe);
 listeTemp.CustomSort(TriListe);

 listeIn.Sorted:=true;
  listeIn.Sort;
 listeIn.LoadFromFile(NomFichier);
  listeIn.Sort; //la liste doit être triée par compte pour que les 44 arrivent en premier s'il y en a
  liste5.Sorted:=true;
  liste5.Sort;
  listeAutre.Sorted:=true;
  listeAutre.Sort;
  listeTva.Sorted:=true;
  listeTva.Sort;
 i:=0;
 numLigne:=2;
 NumPieceEncours:='';
 NumPiece:=0;
 NumPieceOld:='';
 TypePiece:='';
 conteneur:='';
  while (i<=listeIn.Count-1) do  //parcourir toutes la liste pour trouver les comptes de tva si plusieurs, il faut absolument
  //qu'il y ai les taux avec
  begin
     ligneEnCours:=listeIn[i];
     if(str_commence_par(GetStringElement(ligneEnCours,4,sep),'44'))then
     begin
         if(conteneur<>GetStringElement(ligneEnCours,4,sep))and(not Empty(conteneur))and (not tauxDecrit)then
           begin
               ShowMessage('Il existe plusieurs compte de tva et il manque le taux de tva applicable à chaque lignes de hors taxe.');
               abort;
           end;
         conteneur:=GetStringElement(ligneEnCours,4,sep);
     end;
     inc(i);
  end;
  if(not empty(conteneur))then
  //recherche le taux de tva applicable par rapport au compte de Tva
    begin
        DeFiltrageDataSet( DMRech.TaTvaCodeRech);
        tauxTvaDefaut:=CurrToStr_Lgr(Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'compte',[conteneur]).Taux_Supp);
        if(empty(tauxTvaDefaut))then showmessage('Le compte de tva '+conteneur+' est mal paramètré dans vos codes tva');
    end;

  i:=0;
  while (i<=listeIn.Count-1) do   //premier parcours pour mettre un numero de pièce et mettre les comptes 5 dans
  //une liste et les autres dans une autre
  begin
      codeTva:='';
      tauxTva:='';
      DatePiece:='';
      ligneEnCours:=listeIn[i];
      if(trim(ligneEnCours)<>EmptyStr)then
        begin
            if(NumPieceOld<>GetStringElement(ligneEnCours,1,sep))then
            begin
              numLigne:=0;
              inc(NumPiece);
            end;
             NumPieceOld:=GetStringElement(ligneEnCours,1,sep);

            DatePiece:=GetStringElement(ligneEnCours,1,sep);
            DatePiece:=dateInfos_Str(DatePiece);
            DatePiece:=str_souschaine(DatePiece,1,6)+str_souschaine(DatePiece,9,2)  ;
            NumPieceEncours:='0'+DatePiece;
            NumPieceEncours:=str_remplacesouschaine(DatePiece,'/','');

            if(str_commence_par(GetStringElement(ligneEnCours,4,sep),'5'))then
               begin
               TypePiece:='';
                    //on récupère le journal par rapport à l'ID_Journal s'il est renseigné
                   DeFiltrageDataSet( DMRech.TaModelRech);
                  TypePiece:=Infos_TInfosModel(dmrech.TaModelRech,'compte',[GetStringElement(ligneEnCours,4,sep),'5']).Journal;
                  if(TypePiece='')then TypePiece:='OD0' else
                     TypePiece:='T'+TypePiece;
               end
               else if(str_commence_par(GetStringElement(ligneEnCours,4,sep),'44'))then
               begin
                 TypePiece:='VT0';
                 if(tauxDecrit)then tauxTva:=GetStringElement(ligneEnCours,8,sep)
                 else tauxTva:=tauxTvaDefaut;
               end
               else
                 begin
                    TypePiece:='VT0';
                     if(tauxDecrit)then tauxTva:=GetStringElement(ligneEnCours,8,sep)
                     else tauxTva:=tauxTvaDefaut;
                    codeTva:='V';
                 end;
            ligneEnCours:=IntToStr_Lgr(NumPiece)+sep+TypePiece+NumPieceEncours+sep+DatePiece+sep+GetStringElement(ligneEnCours,4,sep)+sep+
            GetStringElement(ligneEnCours,5,sep)+sep+GetStringElement(ligneEnCours,6,sep)+sep+GetStringElement(ligneEnCours,7,sep)+sep+codeTva+sep+tauxTva+sep+'0'+sep+'0';
//            ligneEnCours:=NumPieceEncours+IntToStr_Lgr(NumPiece)+sep+TypePiece+'000001'+sep+DatePiece+sep+GetStringElement(ligneEnCours,4,sep)+sep+
//            GetStringElement(ligneEnCours,5,sep)+sep+GetStringElement(ligneEnCours,6,sep)+sep+GetStringElement(ligneEnCours,7,sep)+sep+codeTva+sep+tauxTva+sep+'0'+sep+'0';
            if(str_commence_par(TypePiece,'T')or(str_commence_par(TypePiece,'O')))then liste5.Add(ligneEnCours)
            else if(str_commence_par(GetStringElement(ligneEnCours,4,sep),'44'))then
                 listeTva.Add(ligneEnCours)
            else listeAutre.add(ligneEnCours);
            inc(numLigne);
        end;
      inc(i);
  end;

  listeAutre.sorted:=false;
 while (listeTva.Count>0) do  //parcourir toutes les lignes de tva pour les intégrer
 //dans les lignes de ht
  begin
     i:=0;
     while i<listeAutre.Count do
     begin
        if(GetStringElement(listeAutre[i],1,sep)=GetStringElement(listeTva[0],1,sep))
        and(GetStringElement(listeAutre[i],9,sep)=GetStringElement(listeTva[0],9,sep))then
          begin
             ligneEnCours:=listeAutre[i];
             conteneurTVADebit:=StrToCurr_Lgr(GetStringElement(listeTva[0],6,sep))+StrToCurr_Lgr(GetStringElement(ligneEnCours,10,sep));
             ligneEnCours:=str_Setstringelement(ligneEnCours,10,sep,CurrToStr(conteneurTVADebit));
             conteneurTVACredit:=StrToCurr_Lgr(GetStringElement(listeTva[0],7,sep))+StrToCurr_Lgr(GetStringElement(ligneEnCours,11,sep));
             ligneEnCours:=str_Setstringelement(ligneEnCours,11,sep,CurrToStr(conteneurTVACredit));
             listeAutre[i]:=ligneEnCours;
             listeTva.Delete(0);

             i:=listeIn.Count;
          end;
         inc(i);
     end;
  end;

listeIn.clear;
NumPieceOld:='';
 i:=0;
 numLigne:=2;
 if(listeAutre.count>0)then
 begin
 while (i<=listeAutre.Count-1) do   //deuxième parcours pour mettre différentes infos dans liste autres
  begin
      if(NumPieceOld<>GetStringElement(listeAutre[i],1,sep)) and (NumPieceOld<>'')then
      begin
      ligneContrepartie:=NumPieceOld+sep+GetStringElement(ligneEnCours,2,sep)+sep
      +GetStringElement(ligneEnCours,3,sep)+';'+e.ComptePointableCaisseEnregistreuse+';Ventes Caisse '+GetStringElement(ligneEnCours,3,sep)+sep+
      CurrToStr_Lgr(conteneurCredit)+sep+CurrToStr_Lgr(conteneurDebit)+sep+sep+sep+sep+sep+'1';
        listeIn.add(ligneContrepartie);
        listeContrepartie.add(ligneContrepartie);
        numLigne:=2;
        conteneurDebit:=0;
        conteneurCredit:=0;
      end;
      ligneEnCours:=listeAutre[i];
      conteneurDebit:=conteneurDebit+StrToCurr_Lgr(GetStringElement(ligneEnCours,6,sep))+StrToCurr_Lgr(GetStringElement(ligneEnCours,10,sep));
      conteneurCredit:=conteneurCredit+StrToCurr_Lgr(GetStringElement(ligneEnCours,7,sep))+StrToCurr_Lgr(GetStringElement(ligneEnCours,11,sep));
      ligneEnCours:=ligneEnCours+sep+IntToStr(numLigne);
      NumPieceOld:=GetStringElement(ligneEnCours,1,sep);
      listeIn.Add(ligneEnCours);
      inc(i);
      inc(numLigne);
  end;
        ligneContrepartie:=NumPieceOld+sep+GetStringElement(ligneEnCours,2,sep)+sep
      +GetStringElement(ligneEnCours,3,sep)+sep+e.ComptePointableCaisseEnregistreuse+sep+'Ventes Caisse '+GetStringElement(ligneEnCours,3,sep)+sep+
      CurrToStr_Lgr(conteneurCredit)+sep+CurrToStr_Lgr(conteneurDebit)+sep+sep+sep+sep+sep+'1';
        listeIn.add(ligneContrepartie);
        listeContrepartie.add(ligneContrepartie);
end;


 i:=0;
 j:=0;
 numLigne:=2;
 NumPieceOld:='';
 liste5.sorted:=false;
 while (i<=liste5.Count-1) do   //deuxième parcours pour mettre différentes infos dans liste des comptes 5
  begin
      ligneEnCours:=liste5[i];inc(NumPiece);
       NumPieceOld:=GetStringElement(ligneEnCours,1,sep);
      ligneEnCours:=str_Setstringelement(ligneEnCours,1,sep,IntToStr(NumPiece));
      ligneEnCours:=ligneEnCours+sep+'1';
      conteneurDebit:=StrToCurr_Lgr(GetStringElement(ligneEnCours,6,sep));
      conteneurCredit:=StrToCurr_Lgr(GetStringElement(ligneEnCours,7,sep));
      ligneContrepartie:=GetStringElement(ligneEnCours,1,sep)+sep+GetStringElement(ligneEnCours,2,sep)+sep
      +GetStringElement(ligneEnCours,3,sep)+';'+e.ComptePointableCaisseEnregistreuse+';Caisse du '+GetStringElement(ligneEnCours,3,sep)+sep+
      CurrToStr_Lgr(conteneurCredit)+sep+CurrToStr_Lgr(conteneurDebit)+sep+sep+sep+sep+sep+'2';
        listeIn.add(ligneContrepartie);
        listeIn.Add(ligneEnCours);
        lignePointage:='';
        for j:=0 to listeContrepartie.count-1 do
        begin
           if(GetStringElement(listeContrepartie[j],1,sep)=NumPieceOld)then
             begin
             ligneContrepartieReglement:=ligneContrepartie;
             ligneContrepartie:=listeContrepartie[j];
              lignePointage:=GetStringElement(ligneContrepartieReglement,1,sep)+sep+'P'+sep+GetStringElement(ligneContrepartieReglement,2,sep)+sep+GetStringElement(ligneContrepartieReglement,4,sep)
              +sep+GetStringElement(ligneContrepartieReglement,3,sep)+sep+GetStringElement(ligneContrepartieReglement,6,sep)+sep+GetStringElement(ligneContrepartieReglement,7,sep)+sep+
              GetStringElement(ligneContrepartie,2,sep)+sep+GetStringElement(ligneContrepartie,3,sep)+sep+GetStringElement(ligneContrepartie,6,sep)+sep+GetStringElement(ligneContrepartie,7,sep)+sep+'3';
              listeIn.add(lignePointage);
             end;
        end;
      inc(i);

  end;

 i:=0;
  listeIn.sorted:=false;
 listeIn.CustomSort(TriListe);
 while (i<=listeIn.Count-1) do
  begin
   New(Import_E2FAC);
   InitialisePImport_E2FAC(Import_E2FAC);
    TvaAReplacer:=false;
    if(GetStringElement(listeIn[i],2,sep)[1]<>'P')then
    begin
        Import_E2FAC.NumPiece:=GetStringElement(listeIn[i],1,sep);
        Import_E2FAC.NumLigne:=GetStringElement(listeIn[i],12,sep);
        Import_E2FAC.TypePiece:=GetStringElement(listeIn[i],2,sep)[1];
        Import_E2FAC.Reference:=GetStringElement(listeIn[i],2,sep);
         if(Import_E2FAC.TypePiece='V')or(Import_E2FAC.TypePiece='O')then
         begin
            Import_E2FAC.Reference:=str_souschaine(Import_E2FAC.Reference,1,2)+'0000001';
         end;
        Import_E2FAC.ReferenceInitial:=GetStringElement(listeIn[i],2,sep);
        Import_E2FAC.DatePiece:=GetStringElement(listeIn[i],3,sep);
        Import_E2FAC.CompteLigne:=GetStringElement(listeIn[i],4,sep);
        Import_E2FAC.Libelle:=GetStringElement(listeIn[i],5,sep);
        Import_E2FAC.MontantDebit:=GetStringElement(listeIn[i],6,sep);
        Import_E2FAC.MontantCredit:=GetStringElement(listeIn[i],7,sep);
        Import_E2FAC.Qte1:='';
        Import_E2FAC.Qte2:='';
        Import_E2FAC.CodeTVA:=GetStringElement(listeIn[i],8,sep);
        Import_E2FAC.TauxTVA:=GetStringElement(listeIn[i],9,sep);
        Import_E2FAC.MontantDebitTVA:=GetStringElement(listeIn[i],10,sep);
        Import_E2FAC.MontantCreditTVA:=GetStringElement(listeIn[i],11,sep);
        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.DatePiece;
        Import_E2FAC.CompteColl:='';
        Import_E2FAC.NomTiers:='';
        Import_E2FAC.Adr1:='';
        Import_E2FAC.Adr2:='';
        Import_E2FAC.CodePostal:='';
        Import_E2FAC.Ville:='';
        Import_E2FAC.ExibiliteTVA:='D';
        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.DatePiece;
        Import_E2FAC.RefContrepartie:='';
        Import_E2FAC.DateContrepartie:='';
        Import_E2FAC.MontantDebitContrepartie:='';
        Import_E2FAC.MontantCreditContrepartie:='';
        Import_E2FAC.MontantPointage:='';
    end
    else
    begin

        Import_E2FAC.NumPiece:=GetStringElement(listeIn[i],1,sep);
        Import_E2FAC.NumLigne:='1';
        Import_E2FAC.TypePiece:=GetStringElement(listeIn[i],2,sep)[1];
        Import_E2FAC.Reference:=GetStringElement(listeIn[i],3,sep);
        Import_E2FAC.DatePiece:=GetStringElement(listeIn[i],5,sep);
        Import_E2FAC.CompteLigne:=GetStringElement(listeIn[i],4,sep);
        Import_E2FAC.Libelle:='';
        Import_E2FAC.MontantDebit:=GetStringElement(listeIn[i],6,sep);
        Import_E2FAC.MontantCredit:=GetStringElement(listeIn[i],7,sep);
        Import_E2FAC.Qte1:='';
        Import_E2FAC.Qte2:='';
        Import_E2FAC.CodeTVA:='';
        Import_E2FAC.TauxTVA:='';
        Import_E2FAC.MontantDebitTVA:='';
        Import_E2FAC.MontantCreditTVA:='';
        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.DatePiece;
        Import_E2FAC.CompteColl:='';
        Import_E2FAC.NomTiers:='';
        Import_E2FAC.Adr1:='';
        Import_E2FAC.Adr2:='';
        Import_E2FAC.CodePostal:='';
        Import_E2FAC.Ville:='';
        Import_E2FAC.ExibiliteTVA:='D';
        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.DatePiece;
        Import_E2FAC.RefContrepartie:=GetStringElement(listeIn[i],8,sep);
        Import_E2FAC.DateContrepartie:=GetStringElement(listeIn[i],9,sep);
        Import_E2FAC.MontantDebitContrepartie:=GetStringElement(listeIn[i],10,sep);
        Import_E2FAC.MontantCreditContrepartie:=GetStringElement(listeIn[i],11,sep);
        conteneurDebit:=StrToCurr_Lgr(GetStringElement(listeIn[i],6,sep));
        conteneurCredit:=StrToCurr_Lgr(GetStringElement(listeIn[i],7,sep));
        conteneurDebit:=DetermineSolde(conteneurDebit,conteneurCredit);
        Import_E2FAC.MontantPointage:=CurrToStr_Lgr(conteneurDebit);
    end;

       if(str_souschaine(trim(Import_E2FAC.Reference),1,4)<>'')then
           while(Length(trim(Import_E2FAC.Reference))<9 )do
           begin

              Import_E2FAC.Reference:=str_souschaine(Import_E2FAC.Reference,1,4)+'0'+ trim(str_souschaine(Import_E2FAC.Reference,5,10));
           end;
       if(Length(trim(Import_E2FAC.RefContrepartie))>0)then
           while(Length(trim(Import_E2FAC.RefContrepartie))<9 )do
           begin
              Import_E2FAC.RefContrepartie:=str_souschaine(Import_E2FAC.RefContrepartie,1,4)+'0'+ trim(str_souschaine(Import_E2FAC.RefContrepartie,5,10));
           end;
       Import_E2FAC.MontantDebit:=ChangeDecimalSeparator(Import_E2FAC.MontantDebit);
       Import_E2FAC.MontantCredit:=ChangeDecimalSeparator(Import_E2FAC.MontantCredit);
       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebit);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCredit);
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebit:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCredit:=currtostr(conteneurCredit);

       conteneurDebit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantDebitTVA));
       conteneurCredit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantCreditTVA));
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitTVA:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditTVA:=currtostr(conteneurCredit);

       Import_E2FAC.TauxTVA:=ChangeDecimalSeparator(Import_E2FAC.TauxTVA);

       TvaAReplacer:=((strtocurr_lgr(Import_E2FAC.MontantDebit)>0)and(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0))or
       ((strtocurr_lgr(Import_E2FAC.MontantCredit)>0)and(strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0));

       if ((strtocurr_lgr(Import_E2FAC.MontantDebit)-strtocurr_lgr(Import_E2FAC.MontantCredit)=0)
       and ((strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0)or(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0)))or
        (TvaAReplacer) then
       begin //si ligne à zéro, on garde la tva pour une prochaine ligne
           j:=0;
           while (j<ListeTva_A_Replacer.Count)and(trouve=false) do
           begin
             trouve:=(PImport_E2FAC(ListeTva_A_Replacer.items[j])^.CodeTVA=Import_E2FAC.CodeTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[j])^.TauxTVA=Import_E2FAC.TauxTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[j])^.NumPiece=Import_E2FAC.NumPiece);
             if not trouve then inc(j);
           end;
           if not trouve then
             begin
               new(Tva_A_Replacer);
               Tva_A_Replacer.NumPiece:=Import_E2FAC.NumPiece;
               Tva_A_Replacer.CodeTVA:=Import_E2FAC.CodeTVA;
               Tva_A_Replacer.TauxTVA:=Import_E2FAC.TauxTVA;
               Tva_A_Replacer.MontantDebitTVA:=Import_E2FAC.MontantDebitTVA;
               Tva_A_Replacer.MontantCreditTVA:=Import_E2FAC.MontantCreditTVA;
               ListeTva_A_Replacer.add(Tva_A_Replacer);
             end
           else
             begin
               PImport_E2FAC(ListeTva_A_Replacer.items[j])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[j])^.MontantDebitTVA)+strtocurr_lgr(Import_E2FAC.MontantDebitTVA));
               PImport_E2FAC(ListeTva_A_Replacer.items[j])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[j])^.MontantCreditTVA)+strtocurr_lgr(Import_E2FAC.MontantCreditTVA));
             end;
           Import_E2FAC.MontantDebitTVA:='0';
           Import_E2FAC.MontantCreditTVA:='0';
       end;

       Import_E2FAC.Libelle:=str_ImportDosToWin(Import_E2FAC.Libelle);
       Import_E2FAC.NomTiers:=str_ImportDosToWin(Import_E2FAC.NomTiers);
       Import_E2FAC.Adr1:=str_ImportDosToWin(Import_E2FAC.Adr1);
       Import_E2FAC.Adr2:=str_ImportDosToWin(Import_E2FAC.Adr2);
       Import_E2FAC.Ville:=str_ImportDosToWin(Import_E2FAC.Ville);
       Import_E2FAC.CompteColl:=str_ImportDosToWin(Import_E2FAC.CompteColl);

       Import_E2FAC.CompteLigne:=str_ImportDosToWin(Import_E2FAC.CompteLigne);


       Import_E2FAC.Qte1:=ChangeDecimalSeparator(Import_E2FAC.Qte1);
       Import_E2FAC.Qte2:=ChangeDecimalSeparator(Import_E2FAC.Qte2);
       if ((((ord(Import_E2FAC.CodeTVA[1])=66)or(ord(Import_E2FAC.CodeTVA[1])=86))) and (VerifNumeric(Import_E2FAC.TauxTVA).VideOUZero)) then
        begin
          Import_E2FAC.CodeTVA:='';
          Import_E2FAC.ExibiliteTVA:='';
        end;

       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebitContrepartie);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCreditContrepartie);
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitContrepartie:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditContrepartie:=currtostr(conteneurCredit);
       Import_E2FAC.MontantPointage:=Import_E2FAC.MontantPointage;
   ListeCaisse.Add(Import_E2FAC);
   inc(i);
  end;
  i:=0;

//rechercher dans les lignes existantes, une ligne du même code tva pour lui rajouter cette partie de tva
  j:=0;
  while (j<=ListeTva_A_Replacer.Count-1)do
//        while (ListeTva_A_Replacer.Count<>0)do
    begin
       i:=0;
       while (i<=ListeCaisse.count-1) and (j<=ListeTva_A_Replacer.Count-1)and ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)>0)
             or(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)>0)) do
         begin            //  PImport_E2FAC(ListeTva_A_Replacer.Items[j])^
            if (PImport_E2FAC(ListeCaisse.Items[i])^.CodeTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.CodeTVA)
              and(PImport_E2FAC(ListeCaisse.Items[i])^.TauxTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.TauxTVA)
              and (PImport_E2FAC(ListeCaisse.Items[i])^.NumPiece=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.NumPiece) then
              begin
                 if strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebit)>0 then
                   begin
                       PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebitTVA)+
                         strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA));
                       PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA:='0';
                   end
                 else
                 if strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantCredit)>0 then
                 begin
                   PImport_E2FAC(ListeCaisse.Items[i])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantCreditTVA)+
                     strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA));
                   PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA:='0';
                 end;
              end;
            if ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)=0) and (strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)=0)) then
               begin
                 ListeTva_A_Replacer.Delete(j);
                 if j>0 then
                   dec(j);
               end;
            inc(i);
         end;
    inc(j);
    end;
  finally
    //CloseFile(Fichier); // ferme le fichier
     Initialise_TStringlist(liste5);
      Initialise_TStringlist(listeAutre);
       Initialise_TStringlist(listeIn);
       Initialise_TStringlist(listeTemp);
       Initialise_TStringlist(listeTva);
       Initialise_Tstringlist(listeContrepartie);
       Initialise_Tstringlist(listePointage);
     Initialise_TList(ListeTva_A_Replacer);
  end;
End;

Procedure ImportationCaisseEnregistreuse_MicoPointe(NomFichier:String;Var ListeCaisse:TList);
var
  Fichier: TextFile;
  Import_E2FAC,Tva_A_Replacer:PImport_E2FAC;
  conteneurDebit,conteneurCredit:currency;
  ListeTva_A_Replacer:TList;
  i,j,numLigne,NumPiece,k:integer;
  trouve,TvaAReplacer:boolean;
  listeIn,liste5,listeAutre,listeTemp,listeTva,listeContrepartie,listePointage:TStringlist;
  NumPieceEncours,NumPieceOld,TypePiece,ligneEnCours,
  codeTva,tauxTva,tauxTvaDefaut,ligneContrepartie,DatePiece,lignePointage,ligneContrepartieReglement,conteneur:string;
  sep:char;
    conteneurTVADebit,conteneurTVACredit:currency;
    tauxDecrit:boolean;
Begin
try
sep:=';';
listeIn:=TStringList.Create;
liste5:=TStringList.Create;
listeAutre:=TStringList.Create;
listeTemp :=TStringList.Create;
listeTva :=TStringList.Create;
listeContrepartie:=TStringList.Create;
listePointage:=TStringList.Create;
tauxTvaDefaut:=e.TauxTvaCaisseEnregistreuse;
If ListeCaisse = nil then
 Begin
  Showmessage('La Liste d''importation de la caisse est nulle!');
  abort;
 End;
 if(listeIn.Count>0)then tauxDecrit:=Str_Count_Str(listeIn[0],sep)>7;
 ListeTva_A_Replacer:=TList.Create;
 ListeCaisse.Clear;

 listeIn.CustomSort(TriListe);
 liste5.CustomSort(TriListe);
 listeAutre.CustomSort(TriListe);
 listeTemp.CustomSort(TriListe);

 listeIn.Sorted:=true;
  listeIn.Sort;
 listeIn.LoadFromFile(NomFichier);
  listeIn.Sort; //la liste doit être triée par compte pour que les 44 arrivent en premier s'il y en a
  liste5.Sorted:=true;
  liste5.Sort;
  listeAutre.Sorted:=true;
  listeAutre.Sort;
  listeTva.Sorted:=true;
  listeTva.Sort;
 i:=0;
 numLigne:=2;
 NumPieceEncours:='';
 NumPiece:=0;
 NumPieceOld:='';
 TypePiece:='';
 conteneur:='';
  while (i<=listeIn.Count-1) do  //parcourir toutes la liste pour trouver les comptes de tva si plusieurs, il faut absolument
  //qu'il y ai les taux avec
  begin
     ligneEnCours:=listeIn[i];
     if(str_commence_par(GetStringElement(ligneEnCours,3,sep),'44'))then
     begin
         if(conteneur<>GetStringElement(ligneEnCours,3,sep))and(not Empty(conteneur))and (not tauxDecrit)then
           begin
               ShowMessage('Il existe plusieurs compte de tva et il manque le taux de tva applicable à chaque lignes de hors taxe.');
               abort;
           end;
         conteneur:=GetStringElement(ligneEnCours,3,sep);
     end;
     inc(i);
  end;
  if(not empty(conteneur))then
  //recherche le taux de tva applicable par rapport au compte de Tva
    begin
        DeFiltrageDataSet( DMRech.TaTvaCodeRech);
        tauxTvaDefaut:=CurrToStr_Lgr(Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'compte',[conteneur]).Taux_Supp);
        if(empty(tauxTvaDefaut))then showmessage('Le compte de tva '+conteneur+' est mal paramètré dans vos codes tva');
    end;

  i:=0;
  while (i<=listeIn.Count-1) do   //premier parcours pour mettre un numero de pièce et mettre les comptes 5 dans
  //une liste et les autres dans une autre
  begin
      codeTva:='';
      tauxTva:='';
      DatePiece:='';
      ligneEnCours:=listeIn[i];
      if(trim(ligneEnCours)<>EmptyStr)then
        begin
            if(NumPieceOld<>GetStringElement(ligneEnCours,1,sep))then
            begin
              numLigne:=0;
              inc(NumPiece);
            end;
             NumPieceOld:=GetStringElement(ligneEnCours,1,sep);

            DatePiece:=GetStringElement(ligneEnCours,1,sep);
            DatePiece:=dateInfos_Str(DatePiece);
            DatePiece:=str_souschaine(DatePiece,1,6)+str_souschaine(DatePiece,9,2)  ;
            NumPieceEncours:='0'+DatePiece;
            NumPieceEncours:=str_remplacesouschaine(DatePiece,'/','');

            if(str_commence_par(GetStringElement(ligneEnCours,4,sep),'5'))then
               begin
               TypePiece:='';
                    //on récupère le journal par rapport à l'ID_Journal s'il est renseigné
                   DeFiltrageDataSet( DMRech.TaModelRech);
                  TypePiece:=Infos_TInfosModel(dmrech.TaModelRech,'compte',[GetStringElement(ligneEnCours,4,sep),'5']).Journal;
                  if(TypePiece='')then TypePiece:='OD0' else
                     TypePiece:='T'+TypePiece;
               end
               else if(str_commence_par(GetStringElement(ligneEnCours,3,sep),'44'))then
               begin
                 TypePiece:='VT0';
                 if(tauxDecrit)then tauxTva:=GetStringElement(ligneEnCours,8,sep)
                 else tauxTva:=tauxTvaDefaut;
               end
               else
                 begin
                    TypePiece:='VT0';
                     if(tauxDecrit)then tauxTva:=GetStringElement(ligneEnCours,8,sep)
                     else tauxTva:=tauxTvaDefaut;
                    codeTva:='V';
                 end;
            ligneEnCours:=IntToStr_Lgr(NumPiece)+sep+TypePiece+NumPieceEncours+sep+DatePiece+sep+GetStringElement(ligneEnCours,4,sep)+sep+
            GetStringElement(ligneEnCours,5,sep)+sep+GetStringElement(ligneEnCours,6,sep)+sep+GetStringElement(ligneEnCours,7,sep)+sep+codeTva+sep+tauxTva+sep+'0'+sep+'0';
//            ligneEnCours:=NumPieceEncours+IntToStr_Lgr(NumPiece)+sep+TypePiece+'000001'+sep+DatePiece+sep+GetStringElement(ligneEnCours,4,sep)+sep+
//            GetStringElement(ligneEnCours,5,sep)+sep+GetStringElement(ligneEnCours,6,sep)+sep+GetStringElement(ligneEnCours,7,sep)+sep+codeTva+sep+tauxTva+sep+'0'+sep+'0';
            if(str_commence_par(TypePiece,'T')or(str_commence_par(TypePiece,'O')))then liste5.Add(ligneEnCours)
            else if(str_commence_par(GetStringElement(ligneEnCours,4,sep),'44'))then
                 listeTva.Add(ligneEnCours)
            else listeAutre.add(ligneEnCours);
            inc(numLigne);
        end;
      inc(i);
  end;

  listeAutre.sorted:=false;
 while (listeTva.Count>0) do  //parcourir toutes les lignes de tva pour les intégrer
 //dans les lignes de ht
  begin
     i:=0;
     while i<listeAutre.Count do
     begin
        if(GetStringElement(listeAutre[i],1,sep)=GetStringElement(listeTva[0],1,sep))
        and(GetStringElement(listeAutre[i],9,sep)=GetStringElement(listeTva[0],9,sep))then
          begin
             ligneEnCours:=listeAutre[i];
             conteneurTVADebit:=StrToCurr_Lgr(GetStringElement(listeTva[0],6,sep))+StrToCurr_Lgr(GetStringElement(ligneEnCours,10,sep));
             ligneEnCours:=str_Setstringelement(ligneEnCours,10,sep,CurrToStr(conteneurTVADebit));
             conteneurTVACredit:=StrToCurr_Lgr(GetStringElement(listeTva[0],7,sep))+StrToCurr_Lgr(GetStringElement(ligneEnCours,11,sep));
             ligneEnCours:=str_Setstringelement(ligneEnCours,11,sep,CurrToStr(conteneurTVACredit));
             listeAutre[i]:=ligneEnCours;
             listeTva.Delete(0);

             i:=listeIn.Count;
          end;
         inc(i);
     end;
  end;

listeIn.clear;
NumPieceOld:='';
 i:=0;
 numLigne:=2;
 if(listeAutre.count>0)then
 begin
 while (i<=listeAutre.Count-1) do   //deuxième parcours pour mettre différentes infos dans liste autres
  begin
      if(NumPieceOld<>GetStringElement(listeAutre[i],1,sep)) and (NumPieceOld<>'')then
      begin
      ligneContrepartie:=NumPieceOld+sep+GetStringElement(ligneEnCours,2,sep)+sep
      +GetStringElement(ligneEnCours,3,sep)+';'+e.ComptePointableCaisseEnregistreuse+';Ventes Caisse '+GetStringElement(ligneEnCours,3,sep)+sep+
      CurrToStr_Lgr(conteneurCredit)+sep+CurrToStr_Lgr(conteneurDebit)+sep+sep+sep+sep+sep+'1';
        listeIn.add(ligneContrepartie);
        listeContrepartie.add(ligneContrepartie);
        numLigne:=2;
        conteneurDebit:=0;
        conteneurCredit:=0;
      end;
      ligneEnCours:=listeAutre[i];
      conteneurDebit:=conteneurDebit+StrToCurr_Lgr(GetStringElement(ligneEnCours,6,sep))+StrToCurr_Lgr(GetStringElement(ligneEnCours,10,sep));
      conteneurCredit:=conteneurCredit+StrToCurr_Lgr(GetStringElement(ligneEnCours,7,sep))+StrToCurr_Lgr(GetStringElement(ligneEnCours,11,sep));
      ligneEnCours:=ligneEnCours+sep+IntToStr(numLigne);
      NumPieceOld:=GetStringElement(ligneEnCours,1,sep);
      listeIn.Add(ligneEnCours);
      inc(i);
      inc(numLigne);
  end;
        ligneContrepartie:=NumPieceOld+sep+GetStringElement(ligneEnCours,2,sep)+sep
      +GetStringElement(ligneEnCours,3,sep)+sep+e.ComptePointableCaisseEnregistreuse+sep+'Ventes Caisse '+GetStringElement(ligneEnCours,3,sep)+sep+
      CurrToStr_Lgr(conteneurCredit)+sep+CurrToStr_Lgr(conteneurDebit)+sep+sep+sep+sep+sep+'1';
        listeIn.add(ligneContrepartie);
        listeContrepartie.add(ligneContrepartie);
end;


 i:=0;
 j:=0;
 numLigne:=2;
 NumPieceOld:='';
 liste5.sorted:=false;
 while (i<=liste5.Count-1) do   //deuxième parcours pour mettre différentes infos dans liste des comptes 5
  begin
      ligneEnCours:=liste5[i];inc(NumPiece);
       NumPieceOld:=GetStringElement(ligneEnCours,1,sep);
      ligneEnCours:=str_Setstringelement(ligneEnCours,1,sep,IntToStr(NumPiece));
      ligneEnCours:=ligneEnCours+sep+'1';
      conteneurDebit:=StrToCurr_Lgr(GetStringElement(ligneEnCours,6,sep));
      conteneurCredit:=StrToCurr_Lgr(GetStringElement(ligneEnCours,7,sep));
      ligneContrepartie:=GetStringElement(ligneEnCours,1,sep)+sep+GetStringElement(ligneEnCours,2,sep)+sep
      +GetStringElement(ligneEnCours,3,sep)+';'+e.ComptePointableCaisseEnregistreuse+';Caisse du '+GetStringElement(ligneEnCours,3,sep)+sep+
      CurrToStr_Lgr(conteneurCredit)+sep+CurrToStr_Lgr(conteneurDebit)+sep+sep+sep+sep+sep+'2';
        listeIn.add(ligneContrepartie);
        listeIn.Add(ligneEnCours);
        lignePointage:='';
        for j:=0 to listeContrepartie.count-1 do
        begin
           if(GetStringElement(listeContrepartie[j],1,sep)=NumPieceOld)then
             begin
             ligneContrepartieReglement:=ligneContrepartie;
             ligneContrepartie:=listeContrepartie[j];
              lignePointage:=GetStringElement(ligneContrepartieReglement,1,sep)+sep+'P'+sep+GetStringElement(ligneContrepartieReglement,2,sep)+sep+GetStringElement(ligneContrepartieReglement,4,sep)
              +sep+GetStringElement(ligneContrepartieReglement,3,sep)+sep+GetStringElement(ligneContrepartieReglement,6,sep)+sep+GetStringElement(ligneContrepartieReglement,7,sep)+sep+
              GetStringElement(ligneContrepartie,2,sep)+sep+GetStringElement(ligneContrepartie,3,sep)+sep+GetStringElement(ligneContrepartie,6,sep)+sep+GetStringElement(ligneContrepartie,7,sep)+sep+'3';
              listeIn.add(lignePointage);
             end;
        end;
      inc(i);

  end;

 i:=0;
  listeIn.sorted:=false;
 listeIn.CustomSort(TriListe);
 while (i<=listeIn.Count-1) do
  begin
   New(Import_E2FAC);
   InitialisePImport_E2FAC(Import_E2FAC);
    TvaAReplacer:=false;
    if(GetStringElement(listeIn[i],2,sep)[1]<>'P')then
    begin
        Import_E2FAC.NumPiece:=GetStringElement(listeIn[i],1,sep);
        Import_E2FAC.NumLigne:=GetStringElement(listeIn[i],12,sep);
        Import_E2FAC.TypePiece:=GetStringElement(listeIn[i],2,sep)[1];
        Import_E2FAC.Reference:=GetStringElement(listeIn[i],2,sep);
         if(Import_E2FAC.TypePiece='V')or(Import_E2FAC.TypePiece='O')then
         begin
            Import_E2FAC.Reference:=str_souschaine(Import_E2FAC.Reference,1,2)+'0000001';
         end;
        Import_E2FAC.ReferenceInitial:=GetStringElement(listeIn[i],2,sep);
        Import_E2FAC.DatePiece:=GetStringElement(listeIn[i],3,sep);
        Import_E2FAC.CompteLigne:=GetStringElement(listeIn[i],4,sep);
        Import_E2FAC.Libelle:=GetStringElement(listeIn[i],5,sep);
        Import_E2FAC.MontantDebit:=GetStringElement(listeIn[i],6,sep);
        Import_E2FAC.MontantCredit:=GetStringElement(listeIn[i],7,sep);
        Import_E2FAC.Qte1:='';
        Import_E2FAC.Qte2:='';
        Import_E2FAC.CodeTVA:=GetStringElement(listeIn[i],8,sep);
        Import_E2FAC.TauxTVA:=GetStringElement(listeIn[i],9,sep);
        Import_E2FAC.MontantDebitTVA:=GetStringElement(listeIn[i],10,sep);
        Import_E2FAC.MontantCreditTVA:=GetStringElement(listeIn[i],11,sep);
        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.DatePiece;
        Import_E2FAC.CompteColl:='';
        Import_E2FAC.NomTiers:='';
        Import_E2FAC.Adr1:='';
        Import_E2FAC.Adr2:='';
        Import_E2FAC.CodePostal:='';
        Import_E2FAC.Ville:='';
        Import_E2FAC.ExibiliteTVA:='D';
        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.DatePiece;
        Import_E2FAC.RefContrepartie:='';
        Import_E2FAC.DateContrepartie:='';
        Import_E2FAC.MontantDebitContrepartie:='';
        Import_E2FAC.MontantCreditContrepartie:='';
        Import_E2FAC.MontantPointage:='';
    end
    else
    begin

        Import_E2FAC.NumPiece:=GetStringElement(listeIn[i],1,sep);
        Import_E2FAC.NumLigne:='1';
        Import_E2FAC.TypePiece:=GetStringElement(listeIn[i],2,sep)[1];
        Import_E2FAC.Reference:=GetStringElement(listeIn[i],3,sep);
        Import_E2FAC.DatePiece:=GetStringElement(listeIn[i],5,sep);
        Import_E2FAC.CompteLigne:=GetStringElement(listeIn[i],4,sep);
        Import_E2FAC.Libelle:='';
        Import_E2FAC.MontantDebit:=GetStringElement(listeIn[i],6,sep);
        Import_E2FAC.MontantCredit:=GetStringElement(listeIn[i],7,sep);
        Import_E2FAC.Qte1:='';
        Import_E2FAC.Qte2:='';
        Import_E2FAC.CodeTVA:='';
        Import_E2FAC.TauxTVA:='';
        Import_E2FAC.MontantDebitTVA:='';
        Import_E2FAC.MontantCreditTVA:='';
        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.DatePiece;
        Import_E2FAC.CompteColl:='';
        Import_E2FAC.NomTiers:='';
        Import_E2FAC.Adr1:='';
        Import_E2FAC.Adr2:='';
        Import_E2FAC.CodePostal:='';
        Import_E2FAC.Ville:='';
        Import_E2FAC.ExibiliteTVA:='D';
        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.DatePiece;
        Import_E2FAC.RefContrepartie:=GetStringElement(listeIn[i],8,sep);
        Import_E2FAC.DateContrepartie:=GetStringElement(listeIn[i],9,sep);
        Import_E2FAC.MontantDebitContrepartie:=GetStringElement(listeIn[i],10,sep);
        Import_E2FAC.MontantCreditContrepartie:=GetStringElement(listeIn[i],11,sep);
        conteneurDebit:=StrToCurr_Lgr(GetStringElement(listeIn[i],6,sep));
        conteneurCredit:=StrToCurr_Lgr(GetStringElement(listeIn[i],7,sep));
        conteneurDebit:=DetermineSolde(conteneurDebit,conteneurCredit);
        Import_E2FAC.MontantPointage:=CurrToStr_Lgr(conteneurDebit);
    end;

       if(str_souschaine(trim(Import_E2FAC.Reference),1,4)<>'')then
           while(Length(trim(Import_E2FAC.Reference))<9 )do
           begin

              Import_E2FAC.Reference:=str_souschaine(Import_E2FAC.Reference,1,4)+'0'+ trim(str_souschaine(Import_E2FAC.Reference,5,10));
           end;
       if(Length(trim(Import_E2FAC.RefContrepartie))>0)then
           while(Length(trim(Import_E2FAC.RefContrepartie))<9 )do
           begin
              Import_E2FAC.RefContrepartie:=str_souschaine(Import_E2FAC.RefContrepartie,1,4)+'0'+ trim(str_souschaine(Import_E2FAC.RefContrepartie,5,10));
           end;
       Import_E2FAC.MontantDebit:=ChangeDecimalSeparator(Import_E2FAC.MontantDebit);
       Import_E2FAC.MontantCredit:=ChangeDecimalSeparator(Import_E2FAC.MontantCredit);
       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebit);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCredit);
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebit:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCredit:=currtostr(conteneurCredit);

       conteneurDebit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantDebitTVA));
       conteneurCredit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantCreditTVA));
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitTVA:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditTVA:=currtostr(conteneurCredit);

       Import_E2FAC.TauxTVA:=ChangeDecimalSeparator(Import_E2FAC.TauxTVA);

       TvaAReplacer:=((strtocurr_lgr(Import_E2FAC.MontantDebit)>0)and(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0))or
       ((strtocurr_lgr(Import_E2FAC.MontantCredit)>0)and(strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0));

       if ((strtocurr_lgr(Import_E2FAC.MontantDebit)-strtocurr_lgr(Import_E2FAC.MontantCredit)=0)
       and ((strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0)or(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0)))or
        (TvaAReplacer) then
       begin //si ligne à zéro, on garde la tva pour une prochaine ligne
           j:=0;
           while (j<ListeTva_A_Replacer.Count)and(trouve=false) do
           begin
             trouve:=(PImport_E2FAC(ListeTva_A_Replacer.items[j])^.CodeTVA=Import_E2FAC.CodeTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[j])^.TauxTVA=Import_E2FAC.TauxTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[j])^.NumPiece=Import_E2FAC.NumPiece);
             if not trouve then inc(j);
           end;
           if not trouve then
             begin
               new(Tva_A_Replacer);
               Tva_A_Replacer.NumPiece:=Import_E2FAC.NumPiece;
               Tva_A_Replacer.CodeTVA:=Import_E2FAC.CodeTVA;
               Tva_A_Replacer.TauxTVA:=Import_E2FAC.TauxTVA;
               Tva_A_Replacer.MontantDebitTVA:=Import_E2FAC.MontantDebitTVA;
               Tva_A_Replacer.MontantCreditTVA:=Import_E2FAC.MontantCreditTVA;
               ListeTva_A_Replacer.add(Tva_A_Replacer);
             end
           else
             begin
               PImport_E2FAC(ListeTva_A_Replacer.items[j])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[j])^.MontantDebitTVA)+strtocurr_lgr(Import_E2FAC.MontantDebitTVA));
               PImport_E2FAC(ListeTva_A_Replacer.items[j])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[j])^.MontantCreditTVA)+strtocurr_lgr(Import_E2FAC.MontantCreditTVA));
             end;
           Import_E2FAC.MontantDebitTVA:='0';
           Import_E2FAC.MontantCreditTVA:='0';
       end;

       Import_E2FAC.Libelle:=str_ImportDosToWin(Import_E2FAC.Libelle);
       Import_E2FAC.NomTiers:=str_ImportDosToWin(Import_E2FAC.NomTiers);
       Import_E2FAC.Adr1:=str_ImportDosToWin(Import_E2FAC.Adr1);
       Import_E2FAC.Adr2:=str_ImportDosToWin(Import_E2FAC.Adr2);
       Import_E2FAC.Ville:=str_ImportDosToWin(Import_E2FAC.Ville);
       Import_E2FAC.CompteColl:=str_ImportDosToWin(Import_E2FAC.CompteColl);

       Import_E2FAC.CompteLigne:=str_ImportDosToWin(Import_E2FAC.CompteLigne);


       Import_E2FAC.Qte1:=ChangeDecimalSeparator(Import_E2FAC.Qte1);
       Import_E2FAC.Qte2:=ChangeDecimalSeparator(Import_E2FAC.Qte2);
       if ((((ord(Import_E2FAC.CodeTVA[1])=66)or(ord(Import_E2FAC.CodeTVA[1])=86))) and (VerifNumeric(Import_E2FAC.TauxTVA).VideOUZero)) then
        begin
          Import_E2FAC.CodeTVA:='';
          Import_E2FAC.ExibiliteTVA:='';
        end;

       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebitContrepartie);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCreditContrepartie);
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitContrepartie:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditContrepartie:=currtostr(conteneurCredit);
       Import_E2FAC.MontantPointage:=Import_E2FAC.MontantPointage;
   ListeCaisse.Add(Import_E2FAC);
   inc(i);
  end;
  i:=0;

//rechercher dans les lignes existantes, une ligne du même code tva pour lui rajouter cette partie de tva
  j:=0;
  while (j<=ListeTva_A_Replacer.Count-1)do
//        while (ListeTva_A_Replacer.Count<>0)do
    begin
       i:=0;
       while (i<=ListeCaisse.count-1) and (j<=ListeTva_A_Replacer.Count-1)and ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)>0)
             or(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)>0)) do
         begin            //  PImport_E2FAC(ListeTva_A_Replacer.Items[j])^
            if (PImport_E2FAC(ListeCaisse.Items[i])^.CodeTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.CodeTVA)
              and(PImport_E2FAC(ListeCaisse.Items[i])^.TauxTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.TauxTVA)
              and (PImport_E2FAC(ListeCaisse.Items[i])^.NumPiece=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.NumPiece) then
              begin
                 if strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebit)>0 then
                   begin
                       PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebitTVA)+
                         strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA));
                       PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA:='0';
                   end
                 else
                 if strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantCredit)>0 then
                 begin
                   PImport_E2FAC(ListeCaisse.Items[i])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantCreditTVA)+
                     strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA));
                   PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA:='0';
                 end;
              end;
            if ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)=0) and (strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)=0)) then
               begin
                 ListeTva_A_Replacer.Delete(j);
                 if j>0 then
                   dec(j);
               end;
            inc(i);
         end;
    inc(j);
    end;
  finally
    //CloseFile(Fichier); // ferme le fichier
     Initialise_TStringlist(liste5);
      Initialise_TStringlist(listeAutre);
       Initialise_TStringlist(listeIn);
       Initialise_TStringlist(listeTemp);
       Initialise_TStringlist(listeTva);
       Initialise_Tstringlist(listeContrepartie);
       Initialise_Tstringlist(listePointage);
     Initialise_TList(ListeTva_A_Replacer);
  end;
End;

function recupTotalTiers(ListeTiers:TList):real;
var
i:integer;
total:currency;
begin
result:=0;
  for i:=0 to ListeTiers.count-1 do
  begin
     result:=result+ StrToCurr_Lgr(PImportCaisseEnregistreuse(ListeTiers.Items[i]).montant);
  end;

end;

function recupTotalTiersBis(ListeTiers:TList):real;
var
i:integer;
total:currency;
begin
result:=0;
  for i:=0 to ListeTiers.count-1 do
  begin
     result:=result+ (StrToCurr_Lgr(PImportCaisseEnregistreuseBis(ListeTiers.Items[i]).debit)+StrToCurr_Lgr(PImportCaisseEnregistreuseBis(ListeTiers.Items[i]).credit));
  end;

end;


Procedure ImportationCaisseEnregistreuse_MicroPointeBis(NomFichier:String;Var ListeCaisse:TList);
var
  Fichier: TextFile;
  Import_Caisse,Import_CaisseTmp:PImportCaisseEnregistreuseBis;
  Import_E2FAC,Tva_A_Replacer:PImport_E2FAC;
  conteneurDebit,conteneurCredit:currency;
  ListeTva_A_Replacer,listeTemp1,listeTemp2,listeTiersBanque,listeCompteBanque:TList;
  ListeASupprimer,listeEcriture,listeEditable:TStringList;
  i,j,k,l,maxPiece,maxLignePiece,idPieceTmp,nbTiers:integer;
  numPieceCourant:string[10];
  journal,codeTva,typePiece:string;
    trouve,TvaAReplacer:boolean;
    total,totalRestant,partTiers:currency;
    tauxTiers:real;
  sep:char;
Begin
try
sep:=';';
if(DMJournal=nil)then DMJournal:=TDMJournal.Create(Application.MainForm);
if(DMPlan=nil)then DMPlan:=TDMPlan.Create(application.MainForm);
if(DMTiers=nil)then DMTiers:=TDMTiers.Create(Application.MainForm);
if(DMTVACode=nil)then DMTVACode:=TDMTVACode.create(Application.MainForm);
ListeASupprimer:=TStringList.Create;
listeEcriture:=TStringList.Create;
listeEditable:=TStringList.Create;

If ListeCaisse = nil then
 Begin
  Showmessage('La Liste d''importation de la caisse est nil!');
  abort;
 End;

 ListeTva_A_Replacer:=TList.Create;
 listeTemp1:=TList.Create;
  listeTemp2:=TList.Create;
listeTiersBanque:=TList.Create;
listeCompteBanque:=Tlist.create;
maxLignePiece:=1;

listeEcriture.LoadFromFile(NomFichier);
  for i:=0 to listeEcriture.Count-1 do
      begin
      new(Import_Caisse);
        Import_Caisse.numPiece:=trim(GetStringElement(listeEcriture.Strings[i],1,sep));
        Import_Caisse.journal:=trim(GetStringElement(listeEcriture.Strings[i],2,sep));
        Import_Caisse.compte:=trim(GetStringElement(listeEcriture.Strings[i],3,sep));
        Import_Caisse.datePiece:=trim(GetStringElement(listeEcriture.Strings[i],4,sep));
        Import_Caisse.referenceEcriture:=trim(GetStringElement(listeEcriture.Strings[i],5,sep));
        Import_Caisse.libelle:=trim(GetStringElement(listeEcriture.Strings[i],6,sep));
        Import_Caisse.debit:=trim(GetStringElement(listeEcriture.Strings[i],7,sep));
        Import_Caisse.credit:=trim(GetStringElement(listeEcriture.Strings[i],8,sep));
        if(VerifNumeric(Import_Caisse.debit).VideOUZero) then Import_Caisse.sens:='C' else Import_Caisse.sens:='D';
             if(Import_Caisse.numPiece<>'')then
             begin
                 if(str_commence_par(Import_Caisse.compte,'+'))then
                 begin

                 end
                 else
                 if(not DMPlan.CompteExistePCU(Import_Caisse.compte)and(str_commence_par(Import_Caisse.compte,'44')or str_commence_par(Import_Caisse.compte,'5')))then
                 begin
                      ShowMessage('le compte '+Import_Caisse.compte+' n''existe pas dans le plan comptable, l''importation est abandonnée.'+RetourChariotDouble+
                      'Corrigez le problème et relancez l''importation !');
                      abort;
                 end;
                  listeTemp1.Add(Import_Caisse);
             end;
      end;


 i:=0;
 idPieceTmp:=0;
 if(listeTemp1.Count>0)then numPieceCourant:=PImportCaisseEnregistreuseBis(listeTemp1.Items[1])^.numPiece;
   while (i<=listeTemp1.Count-1) do   //parcours liste  et pour chaque pièce remplir une autre liste avec ces lignes
   begin
      if(PImportCaisseEnregistreuseBis(listeTemp1.Items[i])^.numPiece<>numPieceCourant)then
      begin //changement de pièce
          for j:=0 to listeTemp2.Count-1 do
          begin
             ListeCaisse.Add(listeTemp2.Items[j]);
          end;
          numPieceCourant:=PImportCaisseEnregistreuseBis(listeTemp1.Items[i])^.numPiece;

          for j:=0 to listeTemp2.Count-1 do
          begin
             Tva_A_Replacer:=PImport_E2FAC(listeTemp2.Items[j]);
             if(str_commence_par(Tva_A_Replacer.CompteLigne,'44'))then
             begin
                //rechercher le compte de vente correspond au paramètre de cette ligne de tva
                for k:=0 to listeTemp2.Count-1 do
                begin
                    Import_E2FAC:=PImport_E2FAC(listeTemp2.Items[k]);
                    if(Tva_A_Replacer.NumPiece=Import_E2FAC.NumPiece)and(not str_commence_par(Import_E2FAC.compteLigne,'44'))and((Tva_A_Replacer.CodeTVA=Import_E2FAC.CodeTVA)and(Tva_A_Replacer.TauxTVA=Import_E2FAC.TauxTVA))then
                      begin
                         // on recupère le montant tva de la ligne de tva pour l'attribuer à la ligne de vente
                         //ensuite on supprime cette ligne de tva de la liste des lignes
                         idPieceTmp:=ListeCaisse.IndexOf(Import_E2FAC);

                         PImport_E2FAC(ListeCaisse.Items[idPieceTmp]).MontantDebitTVA:=Tva_A_Replacer.MontantDebit;
                         PImport_E2FAC(ListeCaisse.Items[idPieceTmp]).MontantCreditTVA:=Tva_A_Replacer.MontantCredit;

                         Tva_A_Replacer.MontantDebit:='0.00';
                         Tva_A_Replacer.MontantCredit:='0.00';
//                         if(idPieceTmp<>-1)then
//                         begin
//                            ListeCaisse.Items[idPieceTmp]:=Import_E2FAC;
//                         end;
                         if(ListeCaisse.IndexOf(Tva_A_Replacer)<>-1)then
                            ListeCaisse.Remove(Tva_A_Replacer);
//                         ListeASupprimer.Add(Tva_A_Replacer.idTmp);
                      end;
                end;
             end;
          end;
          listeTemp2.Clear;
          Import_Caisse:=nil;
          maxLignePiece:=1;
          listeTiersBanque.clear;
      end
      else
      begin //sinon on rempli une liste temp
            New(Import_E2FAC);
            InitialisePImport_E2FAC(Import_E2FAC);
            numPieceCourant:=PImportCaisseEnregistreuseBis(listeTemp1.Items[i])^.numPiece;

            InitialisePImport_E2FAC(Import_E2FAC);
            Import_Caisse:=PImportCaisseEnregistreuseBis(listeTemp1.Items[i]);

            //////////////////Pièce de banques ///////////////
            if(Import_Caisse.journal[1]='B')or(Import_Caisse.journal[1]='C')then
            begin

               if(str_commence_par(Import_Caisse.compte,'+'))then
                 begin //garder cette infos pour pouvoir créer autant de pièce avec qu'il y a de compte de banque
                     new(Import_CaisseTmp);
//                    Import_CaisseTmp.numPiece:=Import_Caisse.numPiece;
                    Import_CaisseTmp.numPiece:=IntToStr_Lgr(maxPiece);

                    Import_CaisseTmp.compte:=Import_Caisse.compte;
                    Import_CaisseTmp.libelle:=Import_Caisse.libelle;
                    Import_CaisseTmp.debit:=Import_Caisse.debit;
                    Import_CaisseTmp.credit:=Import_Caisse.credit;
                    Import_CaisseTmp.sens:=Import_Caisse.sens;
                    Import_CaisseTmp.datePiece:=Import_Caisse.datePiece;
                    Import_CaisseTmp.numPiece:=Import_Caisse.numPiece;
                    listeTiersBanque.Add(Import_CaisseTmp);
//                    incPiece:=1;
                 end
               else
                 begin//pour les autres comptes (compte de banque) rechercher le journal correspondant
                    journal:=DMJournal.JournalDuCompte(Import_Caisse.compte);
                    total:=recupTotalTiersBis(listeTiersBanque);
                    totalRestant:=total;
                    if(Empty(journal))then
                    begin
                        ShowMessage('le compte de banque '+Import_Caisse.compte+' n''est lié à aucun journal, l''importation est abandonnée.'+RetourChariotDouble+
                        'Corrigez le problème et relancez l''importation !');
                        abort;
                    end
                    else begin
                        New(Import_E2FAC);
                        InitialisePImport_E2FAC(Import_E2FAC);
//                        Import_E2FAC.NumPiece:=Import_Caisse.numPiece;
                        Import_E2FAC.NumPiece:=IntToStr_Lgr(maxPiece);
                        Import_E2FAC.NumLigne:='1';
                        Import_E2FAC.TypePiece:='T';
                        Import_E2FAC.DatePiece:=Import_CaisseTmp.DatePiece;
                        //Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                        Import_E2FAC.ReferenceInitial:=Import_Caisse.journal+Import_Caisse.numPiece;
                        Import_E2FAC.Reference:='T1'+Import_E2FAC.NumPiece;

                        Import_E2FAC.CompteLigne:=Import_Caisse.compte;
                        Import_E2FAC.Libelle:=Import_Caisse.libelle;

                        Import_E2FAC.MontantDebit:='0';
                        Import_E2FAC.MontantCredit:='0';

                        Import_E2FAC.MontantDebit:=Import_Caisse.debit;
                        Import_E2FAC.MontantCredit:=Import_Caisse.credit;
                        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;
                        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;
                        Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                        inc(idPieceTmp);
                        listeTemp2.Add(Import_E2FAC);
                        totalRestant:= StrToCurr_Lgr(Import_Caisse.debit)+StrToCurr_Lgr(Import_Caisse.credit);
                        for nbTiers:=0 to listeTiersBanque.Count-1 do
                        begin
                            //On traite la ligne de tiers
                            Import_CaisseTmp:=PImportCaisseEnregistreuseBis(listeTiersBanque.Items[nbTiers]);
                            New(Import_E2FAC);
                            InitialisePImport_E2FAC(Import_E2FAC);
                            //Import_E2FAC.NumPiece:=Import_CaisseTmp.numPiece;
                            Import_E2FAC.NumPiece:=IntToStr_Lgr(maxPiece);
                            Import_E2FAC.NumLigne:=IntToStr_Lgr(nbTiers+2);
                            Import_E2FAC.TypePiece:='T';
                            Import_E2FAC.DatePiece:=Import_CaisseTmp.datePiece;
                            //Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                            Import_E2FAC.ReferenceInitial:=Import_Caisse.journal+Import_Caisse.numPiece;
                            Import_E2FAC.Reference:='T1'+Import_E2FAC.NumPiece;

                            Import_E2FAC.CompteLigne:=Import_CaisseTmp.compte;
                            Import_E2FAC.Libelle:=Import_CaisseTmp.libelle;

                            Import_E2FAC.MontantDebit:='0';
                            Import_E2FAC.MontantCredit:='0';
                            //
                            if(total>0) then
                                tauxTiers:=(StrToCurr_Lgr(Import_CaisseTmp.debit)+StrToCurr_Lgr(Import_CaisseTmp.credit))*100/total;
                            partTiers:=(StrToCurr_Lgr(Import_CaisseTmp.debit)+StrToCurr_Lgr(Import_CaisseTmp.credit))*(tauxTiers/100);
                            totalRestant:=totalRestant-partTiers;
                            if(Import_CaisseTmp.sens='D')then
                            Import_E2FAC.MontantDebit:=CurrToStr_Lgr(partTiers)  //le montant est celui correspondant au compte de banque
                            else
                            Import_E2FAC.MontantCredit:=CurrToStr_Lgr(partTiers);
                            Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;

                            Import_E2FAC.CompteColl:=DMTiers.CptDuTiers(Import_CaisseTmp.compte);
                            Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;

                            Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                            inc(idPieceTmp);
                            listeTemp2.Add(Import_E2FAC);

                            if(listeTiersBanque.count-1=nbTiers) and (totalRestant<>0)then
                            begin
                                if(Import_CaisseTmp.sens='D')then
                                Import_E2FAC.MontantDebit:=CurrToStr_Lgr(partTiers+totalRestant)  //le montant est celui correspondant au compte de banque
                                else
                                Import_E2FAC.MontantCredit:=CurrToStr_Lgr(partTiers+totalRestant);
                            end;
                        end;
                        inc(maxPiece);// on incremente pour la ligne de banque suivante si besoin qui
                            // impliquera de créer une nouvelle pièce de banque, donc nouveau numero
                    end;
                 end;

            end;
            //////////////////Pièce de ventes ///////////////
            if(Import_Caisse.journal='FT')or(Import_Caisse.journal='VE')then
            begin
               if(str_commence_par(Import_Caisse.compte,'+'))then
                 begin //ligne de contrepartie
                        New(Import_E2FAC);
                        InitialisePImport_E2FAC(Import_E2FAC);
                        Import_E2FAC.NumPiece:=Import_Caisse.numPiece;
                        Import_E2FAC.NumLigne:=IntToStr_Lgr(1);
                        Import_E2FAC.TypePiece:='V';
                        Import_E2FAC.DatePiece:=Import_Caisse.datePiece;
                        //Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                        Import_E2FAC.ReferenceInitial:=Import_Caisse.journal+Import_Caisse.numPiece;
                        Import_E2FAC.Reference:=Import_Caisse.journal+Import_E2FAC.NumPiece;

                        Import_E2FAC.CompteLigne:=Import_Caisse.compte;
                        Import_E2FAC.Libelle:=Import_Caisse.libelle;

                        Import_E2FAC.MontantDebit:='0';
                        Import_E2FAC.MontantCredit:='0';

                        Import_E2FAC.MontantDebit:=Import_Caisse.debit;
                        Import_E2FAC.MontantCredit:=Import_Caisse.credit;
                        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;

                        Import_E2FAC.CompteColl:=DMTiers.CptDuTiers(trim(Import_Caisse.compte));
                        if(Import_E2FAC.CompteColl='')then Import_E2FAC.CompteColl:='411';
                        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;

                        Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                        inc(idPieceTmp);
                        listeTemp2.Add(Import_E2FAC);
                 end;
               if(str_commence_par(Import_Caisse.compte,'44'))then
                 begin //ligne de tva
                        New(Import_E2FAC);
                        InitialisePImport_E2FAC(Import_E2FAC);
                        Import_E2FAC.NumPiece:=Import_Caisse.numPiece;
                        inc(maxLignePiece);
                        Import_E2FAC.NumLigne:=IntToStr_Lgr(maxLignePiece);
                        Import_E2FAC.TypePiece:='V';

                        Import_E2FAC.DatePiece:=Import_Caisse.datePiece;
                        //Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                        Import_E2FAC.ReferenceInitial:=Import_Caisse.journal+Import_Caisse.numPiece;
                        Import_E2FAC.Reference:='VT'+Import_E2FAC.NumPiece;

                        Import_E2FAC.CompteLigne:=Import_Caisse.compte;
                        //rechercher dans les codetva pour retrouver le taux et le codetva correspondant à ce compte
                        codeTva:=FTvaRecupCodeTva(Import_Caisse.compte);

                        Import_E2FAC.CodeTVA:=codeTva;
                        Import_E2FAC.TauxTVA:=FloatToStr_Lgr(FTvaTauxTva(codeTva));

                        Import_E2FAC.Libelle:=Import_Caisse.libelle;
                        Import_E2FAC.MontantDebit:='0';
                        Import_E2FAC.MontantCredit:='0';


                        Import_E2FAC.MontantDebit:=Import_Caisse.debit;  //le montant est celui correspondant au compte de banque
                        Import_E2FAC.MontantCredit:=Import_Caisse.credit;
                        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;

                        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;

                        Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                        inc(idPieceTmp);
                        listeTemp2.Add(Import_E2FAC);
                 end;
               if(str_commence_par(Import_Caisse.compte,'6')or str_commence_par(Import_Caisse.compte,'7'))then
                 begin //ligne de ventes
                        New(Import_E2FAC);
                        InitialisePImport_E2FAC(Import_E2FAC);

                        Import_E2FAC.NumPiece:=Import_Caisse.numPiece;
                        inc(maxLignePiece);
                        Import_E2FAC.NumLigne:=IntToStr_Lgr(maxLignePiece);
                        Import_E2FAC.TypePiece:='V';

                        Import_E2FAC.DatePiece:=Import_Caisse.datePiece;
                        //Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                        Import_E2FAC.ReferenceInitial:=Import_Caisse.journal+Import_Caisse.numPiece;
                        Import_E2FAC.Reference:=Import_Caisse.journal+Import_E2FAC.NumPiece;

                        Import_E2FAC.CompteLigne:=Import_Caisse.compte;
                        //rechercher le parametrage du compte au niveau codetva et taux dans plancpt pour faire le parallèle avec
                        // les lignes de tva
                        Import_E2FAC.CodeTVA:=DMPlan.CodeDeTvaDuCompte(Import_E2FAC.CompteLigne);
                        Import_E2FAC.TauxTVA:=FloatToStr_Lgr(DMPlan.TauxDeTvaDuCompte(Import_E2FAC.CompteLigne));

                        Import_E2FAC.Libelle:=Import_Caisse.libelle;
                        Import_E2FAC.MontantDebit:='0';
                        Import_E2FAC.MontantCredit:='0';

                        Import_E2FAC.MontantDebit:=Import_Caisse.debit;
                        Import_E2FAC.MontantCredit:=Import_Caisse.credit;
                        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;

                        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;

                        Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                        inc(idPieceTmp);
                        listeTemp2.Add(Import_E2FAC);
                 end; //fin si //ligne de ventes
            end; //fin if(Import_Caisse.journal='VE')then
      inc(i);
      end;//fin //sinon on rempli une liste temp

  end; //fin du while  (i<=listeTemp1.Count-1)
  //traiter les dernières lignes
//      if(PImportCaisseEnregistreuse(listeTemp1.Items[i])^.numPiece<>numPieceCourant)then
//      begin //changement de pièce
          for j:=0 to listeTemp2.Count-1 do
          begin
             ListeCaisse.Add(listeTemp2.Items[j]);
          end;

          for j:=0 to listeTemp2.Count-1 do
          begin
             Tva_A_Replacer:=PImport_E2FAC(listeTemp2.Items[j]);
             if(str_commence_par(Tva_A_Replacer.CompteLigne,'44'))then
             begin
                //rechercher le compte de vente correspond au paramètre de cette ligne de tva
                for k:=0 to listeTemp2.Count-1 do
                begin
                    Import_E2FAC:=PImport_E2FAC(listeTemp2.Items[k]);
                    if(Tva_A_Replacer.NumPiece=Import_E2FAC.NumPiece)and(not str_commence_par(Import_E2FAC.compteLigne,'44'))and((Tva_A_Replacer.CodeTVA=Import_E2FAC.CodeTVA)and(Tva_A_Replacer.TauxTVA=Import_E2FAC.TauxTVA))then
                      begin
                         // on recupère le montant tva de la ligne de tva pour l'attribuer à la ligne de vente
                         //ensuite on supprime cette ligne de tva de la liste des lignes
                         idPieceTmp:=ListeCaisse.IndexOf(Import_E2FAC);

                         PImport_E2FAC(ListeCaisse.Items[idPieceTmp]).MontantDebitTVA:=Tva_A_Replacer.MontantDebit;
                         PImport_E2FAC(ListeCaisse.Items[idPieceTmp]).MontantCreditTVA:=Tva_A_Replacer.MontantCredit;
                         Tva_A_Replacer.MontantDebit:='0.00';
                         Tva_A_Replacer.MontantCredit:='0.00';
//                         if(idPieceTmp<>-1)then
//                         begin
//                            ListeCaisse.Items[idPieceTmp]:=Import_E2FAC;
//                         end;
                         if(ListeCaisse.IndexOf(Tva_A_Replacer)<>-1)then
                            ListeCaisse.Remove(Tva_A_Replacer);
                         //ListeASupprimer.Add(Tva_A_Replacer.idTmp);
                      end;
                end;
             end;
          end;
for l:=0 to ListeCaisse.count-1 do
 begin
    Tva_A_Replacer:=PImport_E2FAC(ListeCaisse.Items[l]);
    listeEditable.Add(Tva_A_Replacer.idTmp+';'+Tva_A_Replacer.NumPiece+';'+Tva_A_Replacer.NumLigne+';'+Tva_A_Replacer.CompteLigne+';'+Tva_A_Replacer.CodeTVA+';'+Tva_A_Replacer.MontantDebit+';'+Tva_A_Replacer.MontantCredit+';'+Tva_A_Replacer.MontantDebitTVA+';'+Tva_A_Replacer.MontantCreditTVA);
 end;
    listeEditable.SaveToFile('C:\LGRDOSS\EPICEA\listeEditableCaisse.txt'); 
for l:=0 to ListeCaisse.count-1 do
 begin
     Import_E2FAC:=PImport_E2FAC(ListeCaisse.Items[l]);
       if(str_souschaine(trim(Import_E2FAC.Reference),1,4)<>'')then
           while(Length(trim(Import_E2FAC.Reference))<9 )do
           begin

              Import_E2FAC.Reference:=str_souschaine(Import_E2FAC.Reference,1,2)+'0'+ trim(str_souschaine(Import_E2FAC.Reference,3,10));
           end;
       if(Length(trim(Import_E2FAC.RefContrepartie))>0)then
           while(Length(trim(Import_E2FAC.RefContrepartie))<9 )do
           begin
              Import_E2FAC.RefContrepartie:=str_souschaine(Import_E2FAC.RefContrepartie,1,2)+'0'+ trim(str_souschaine(Import_E2FAC.RefContrepartie,3,10));
           end;
       Import_E2FAC.MontantDebit:=ChangeDecimalSeparator(Import_E2FAC.MontantDebit);
       Import_E2FAC.MontantCredit:=ChangeDecimalSeparator(Import_E2FAC.MontantCredit);
       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebit);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCredit);
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebit:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCredit:=currtostr(conteneurCredit);

       conteneurDebit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantDebitTVA));
       conteneurCredit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantCreditTVA));
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitTVA:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditTVA:=currtostr(conteneurCredit);

       Import_E2FAC.TauxTVA:=ChangeDecimalSeparator(Import_E2FAC.TauxTVA);

       TvaAReplacer:=((strtocurr_lgr(Import_E2FAC.MontantDebit)>0)and(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0))or
       ((strtocurr_lgr(Import_E2FAC.MontantCredit)>0)and(strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0));

       if ((strtocurr_lgr(Import_E2FAC.MontantDebit)-strtocurr_lgr(Import_E2FAC.MontantCredit)=0)
       and ((strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0)or(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0)))or
        (TvaAReplacer) then
       begin //si ligne à zéro, on garde la tva pour une prochaine ligne
           i:=0;
           while (i<ListeTva_A_Replacer.Count)and(trouve=false) do
           begin
             trouve:=(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.CodeTVA=Import_E2FAC.CodeTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[i])^.TauxTVA=Import_E2FAC.TauxTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[i])^.NumPiece=Import_E2FAC.NumPiece);
             if not trouve then inc(i);
           end;
           if not trouve then
             begin
               new(Tva_A_Replacer);
               Tva_A_Replacer.NumPiece:=Import_E2FAC.NumPiece;
               Tva_A_Replacer.CodeTVA:=Import_E2FAC.CodeTVA;
               Tva_A_Replacer.TauxTVA:=Import_E2FAC.TauxTVA;
               Tva_A_Replacer.MontantDebitTVA:=Import_E2FAC.MontantDebitTVA;
               Tva_A_Replacer.MontantCreditTVA:=Import_E2FAC.MontantCreditTVA;
               ListeTva_A_Replacer.add(Tva_A_Replacer);
             end
           else
             begin
               PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantDebitTVA)+strtocurr_lgr(Import_E2FAC.MontantDebitTVA));
               PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantCreditTVA)+strtocurr_lgr(Import_E2FAC.MontantCreditTVA));
             end;
           Import_E2FAC.MontantDebitTVA:='0';
           Import_E2FAC.MontantCreditTVA:='0';
       end;

       Import_E2FAC.Libelle:=str_ImportDosToWin(Import_E2FAC.Libelle);
       Import_E2FAC.NomTiers:=str_ImportDosToWin(Import_E2FAC.NomTiers);
       Import_E2FAC.Adr1:=str_ImportDosToWin(Import_E2FAC.Adr1);
       Import_E2FAC.Adr2:=str_ImportDosToWin(Import_E2FAC.Adr2);
       Import_E2FAC.Ville:=str_ImportDosToWin(Import_E2FAC.Ville);
       Import_E2FAC.CompteColl:=str_ImportDosToWin(Import_E2FAC.CompteColl);

       Import_E2FAC.CompteLigne:=str_ImportDosToWin(Import_E2FAC.CompteLigne);


       Import_E2FAC.Qte1:=ChangeDecimalSeparator(Import_E2FAC.Qte1);
       Import_E2FAC.Qte2:=ChangeDecimalSeparator(Import_E2FAC.Qte2);
       if ((((ord(Import_E2FAC.CodeTVA[1])=66)or(ord(Import_E2FAC.CodeTVA[1])=86))) and (VerifNumeric(Import_E2FAC.TauxTVA).VideOUZero)) then
        begin
          Import_E2FAC.CodeTVA:='';
          Import_E2FAC.ExibiliteTVA:='';
        end;
       try
       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebitContrepartie);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCreditContrepartie);
       except
          conteneurDebit:=0;
          conteneurCredit:=0;
       end;
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitContrepartie:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditContrepartie:=currtostr(conteneurCredit);
       Import_E2FAC.MontantPointage:=Import_E2FAC.MontantPointage;
 end;


 //rechercher dans les lignes existantes, une ligne du même code tva pour lui rajouter cette partie de tva
  j:=0;
  while (j<=ListeTva_A_Replacer.Count-1)do
//        while (ListeTva_A_Replacer.Count<>0)do
    begin
       i:=0;
       while (i<=ListeCaisse.count-1) and (j<=ListeTva_A_Replacer.Count-1)and ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)>0)
             or(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)>0)) do
         begin            //  PImport_E2FAC(ListeTva_A_Replacer.Items[j])^
            if (PImport_E2FAC(ListeCaisse.Items[i])^.CodeTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.CodeTVA)
              and(PImport_E2FAC(ListeCaisse.Items[i])^.TauxTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.TauxTVA)
              and (PImport_E2FAC(ListeCaisse.Items[i])^.NumPiece=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.NumPiece) then
              begin
                 if strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebit)>0 then
                   begin
                       PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebitTVA)+
                         strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA));
                       PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA:='0';
                   end
                 else
                 if strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantCredit)>0 then
                 begin
                   PImport_E2FAC(ListeCaisse.Items[i])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantCreditTVA)+
                     strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA));
                   PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA:='0';
                 end;
              end;
            if ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)=0) and (strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)=0)) then
               begin
                 ListeTva_A_Replacer.Delete(j);
                 if j>0 then
                   dec(j);
               end;
            inc(i);
         end;
    inc(j);
    end;

  finally
    Initialise_Tstringlist(ListeASupprimer);
    Initialise_Tstringlist(listeEcriture);
    Initialise_Tstringlist(listeEditable);

//    Initialise_TList(ListeTva_A_Replacer);
//    Initialise_TList(listeTemp1);
//    Initialise_TList(listeTemp2);
//    Initialise_TList(listeTiersBanque);
  end;
End;



Procedure ImportationCaisseEnregistreuseBernard(NomFichier:String;Var ListeCaisse:TList);
var
  Fichier: TextFile;
  Import_Caisse,Import_CaisseTmp:PImportCaisseEnregistreuse;
  Import_E2FAC,Tva_A_Replacer:PImport_E2FAC;
  conteneurDebit,conteneurCredit:currency;
  ListeTva_A_Replacer,listeTemp1,listeTemp2,listeTiersBanque,listeCompteBanque:TList;
  ListeASupprimer:TStringList;
  i,j,k,l,maxPiece,maxLignePiece,idPieceTmp,nbTiers:integer;
  numPieceCourant:string[5];
  journal,codeTva,typePiece:string;
    trouve,TvaAReplacer:boolean;
    total,totalRestant,partTiers:currency;
    tauxTiers:real;
Begin
try
if(DMJournal=nil)then DMJournal:=TDMJournal.Create(Application.MainForm);
if(DMPlan=nil)then DMPlan:=TDMPlan.Create(application.MainForm);
if(DMTiers=nil)then DMTiers:=TDMTiers.Create(Application.MainForm);
if(DMTVACode=nil)then DMTVACode:=TDMTVACode.create(Application.MainForm);
ListeASupprimer:=TStringList.Create;

If ListeCaisse = nil then
 Begin
  Showmessage('La Liste d''importation de la caisse est nil!');
  abort;
 End;

 ListeTva_A_Replacer:=TList.Create;
 listeTemp1:=TList.Create;
  listeTemp2:=TList.Create;
listeTiersBanque:=TList.Create;
listeCompteBanque:=Tlist.create;

 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    new(Import_Caisse);
    ReadLn(Fichier,Import_Caisse.numPiece,
                   Import_Caisse.journal,
                   Import_Caisse.datePiece,
                   Import_Caisse.vide,
                   Import_Caisse.compte,
                   Import_Caisse.libelle,
                   Import_Caisse.montant,
                   Import_Caisse.sens);

       Import_Caisse.numPiece:=trim(Import_Caisse.numPiece);
       Import_Caisse.journal:=trim(Import_Caisse.journal);
       Import_Caisse.datePiece:=trim(Import_Caisse.datePiece);
       Import_Caisse.vide:=trim(Import_Caisse.vide);
       Import_Caisse.compte:=trim(Import_Caisse.compte);

       Import_Caisse.libelle:=trim(Import_Caisse.libelle);
       Import_Caisse.montant:=trim(Import_Caisse.montant);
       Import_Caisse.sens:=trim(Import_Caisse.sens);
       if(Import_Caisse.numPiece<>'')then
       begin
           if(str_commence_par(Import_Caisse.compte,'+'))then
           begin

           end
           else
           if(not DMPlan.CompteExistePCU(Import_Caisse.compte))then
           begin
                ShowMessage('le compte '+Import_Caisse.compte+' n''exite pas dans le plan comptable, l''importation est abandonnée.'+RetourChariotDouble+
                'Corrigez le problème et relancez l''importation !');
                abort;
           end;
            listeTemp1.Add(Import_Caisse);
       end;
  end;

 CloseFile(Fichier); // ferme le fichier

 i:=0;
 idPieceTmp:=0;
 if(listeTemp1.Count>0)then numPieceCourant:=PImportCaisseEnregistreuse(listeTemp1.Items[1])^.numPiece;
  if(listeTemp1.Count>0)then maxPiece:=StrToInt_Lgr(PImportCaisseEnregistreuse(listeTemp1.Items[listeTemp1.Count-1])^.numPiece)+1; //calcul le max de pièce de cet import pour pouvoir rajouter
  //des numéros pour créer les pièces de banque en plus.

  while (i<=listeTemp1.Count-1) do   //parcours liste  et pour chaque pièce remplir une autre liste avec ces lignes
  begin
      if(PImportCaisseEnregistreuse(listeTemp1.Items[i])^.numPiece<>numPieceCourant)then
      begin //changement de pièce
          for j:=0 to listeTemp2.Count-1 do
          begin
             ListeCaisse.Add(listeTemp2.Items[j]);
          end;
          numPieceCourant:=PImportCaisseEnregistreuse(listeTemp1.Items[i])^.numPiece;

          for j:=0 to listeTemp2.Count-1 do
          begin
             Tva_A_Replacer:=PImport_E2FAC(listeTemp2.Items[j]);
             if(str_commence_par(Tva_A_Replacer.CompteLigne,'44'))then
             begin
                //rechercher le compte de vente correspond au paramètre de cette ligne de tva
                for k:=0 to listeTemp2.Count-1 do
                begin
                    Import_E2FAC:=PImport_E2FAC(listeTemp2.Items[k]);
                    if(Tva_A_Replacer.NumPiece=Import_E2FAC.NumPiece)and(not str_commence_par(Import_E2FAC.compteLigne,'44'))and((Tva_A_Replacer.CodeTVA=Import_E2FAC.CodeTVA)and(Tva_A_Replacer.TauxTVA=Import_E2FAC.TauxTVA))then
                      begin
                         // on recupère le montant tva de la ligne de tva pour l'attribuer à la ligne de vente
                         //ensuite on supprime cette ligne de tva de la liste des lignes
                         idPieceTmp:=ListeCaisse.IndexOf(Import_E2FAC);

                         PImport_E2FAC(ListeCaisse.Items[idPieceTmp]).MontantDebitTVA:=Tva_A_Replacer.MontantDebit;
                         PImport_E2FAC(ListeCaisse.Items[idPieceTmp]).MontantCreditTVA:=Tva_A_Replacer.MontantCredit;
//                         if(idPieceTmp<>-1)then
//                         begin
//                            ListeCaisse.Items[idPieceTmp]:=Import_E2FAC;
//                         end;
                         if(ListeCaisse.IndexOf(Tva_A_Replacer)<>-1)then ListeCaisse.Remove(Tva_A_Replacer);
//                         ListeASupprimer.Add(Tva_A_Replacer.idTmp);
                      end;
                end;
             end;
          end;
          listeTemp2.Clear;
          Import_Caisse:=nil;
          maxLignePiece:=1;
          listeTiersBanque.clear;
      end
      else
      begin //sinon on rempli une liste temp
            New(Import_E2FAC);
            InitialisePImport_E2FAC(Import_E2FAC);
            numPieceCourant:=PImportCaisseEnregistreuse(listeTemp1.Items[i])^.numPiece;

            InitialisePImport_E2FAC(Import_E2FAC);
            Import_Caisse:=PImportCaisseEnregistreuse(listeTemp1.Items[i]);

            //////////////////Pièce de banques ///////////////
            if(Import_Caisse.journal='BQ')then
            begin

               if(str_commence_par(Import_Caisse.compte,'+'))then
                 begin //garder cette infos pour pouvoir créer autant de pièce avec qu'il y a de compte de banque
                     new(Import_CaisseTmp);
//                    Import_CaisseTmp.numPiece:=Import_Caisse.numPiece;
                    Import_CaisseTmp.numPiece:=IntToStr_Lgr(maxPiece);

                    Import_CaisseTmp.compte:=Import_Caisse.compte;
                    Import_CaisseTmp.libelle:=Import_Caisse.libelle;
                    Import_CaisseTmp.montant:=Import_Caisse.montant;
                    Import_CaisseTmp.sens:=Import_Caisse.sens;
                    Import_CaisseTmp.datePiece:=Import_Caisse.datePiece;
                    Import_CaisseTmp.numPiece:=Import_Caisse.numPiece;
                    listeTiersBanque.Add(Import_CaisseTmp);
//                    incPiece:=1;
                 end
               else
                 begin//pour les autres comptes (compte de banque) rechercher le journal correspondant
                    journal:=DMJournal.JournalDuCompte(Import_Caisse.compte);
                    total:=recupTotalTiers(listeTiersBanque);
                    totalRestant:=total;
                    if(Empty(journal))then
                    begin
                        ShowMessage('le compte de banque '+Import_Caisse.compte+' n''est lié à aucun journal, l''importation est abandonnée.'+RetourChariotDouble+
                        'Corrigez le problème et relancez l''importation !');
                        abort;
                    end
                    else begin
                        New(Import_E2FAC);
                        InitialisePImport_E2FAC(Import_E2FAC);
//                        Import_E2FAC.NumPiece:=Import_Caisse.numPiece;
                        Import_E2FAC.NumPiece:=IntToStr_Lgr(maxPiece);
                        Import_E2FAC.NumLigne:='1';
                        Import_E2FAC.TypePiece:='T';
                        Import_E2FAC.DatePiece:=Import_CaisseTmp.DatePiece;
                        Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                        Import_E2FAC.ReferenceInitial:=Import_E2FAC.NumPiece+str_remplacesouschaine(Import_E2FAC.datePiece,'/','');
                        Import_E2FAC.Reference:='T1'+Import_E2FAC.NumPiece;

                        Import_E2FAC.CompteLigne:=Import_Caisse.compte;
                        Import_E2FAC.Libelle:=Import_Caisse.libelle;

                        Import_E2FAC.MontantDebit:='0';
                        Import_E2FAC.MontantCredit:='0';

                        if(Import_Caisse.sens='D')then
                        Import_E2FAC.MontantDebit:=Import_Caisse.montant
                        else
                        Import_E2FAC.MontantCredit:=Import_Caisse.montant;
                        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;
                        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;
                        Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                        inc(idPieceTmp);
                        listeTemp2.Add(Import_E2FAC);
                        totalRestant:= StrToCurr_Lgr(Import_Caisse.montant);
                        for nbTiers:=0 to listeTiersBanque.Count-1 do
                        begin
                            //On traite la ligne de tiers
                            Import_CaisseTmp:=PImportCaisseEnregistreuse(listeTiersBanque.Items[nbTiers]);
                            New(Import_E2FAC);
                            InitialisePImport_E2FAC(Import_E2FAC);
                            //Import_E2FAC.NumPiece:=Import_CaisseTmp.numPiece;
                            Import_E2FAC.NumPiece:=IntToStr_Lgr(maxPiece);
                            Import_E2FAC.NumLigne:=IntToStr_Lgr(nbTiers+2);
                            Import_E2FAC.TypePiece:='T';
                            Import_E2FAC.DatePiece:=Import_CaisseTmp.datePiece;
                            Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                            Import_E2FAC.ReferenceInitial:=Import_E2FAC.NumPiece+'_'+str_remplacesouschaine(Import_E2FAC.datePiece,'/','');
                            Import_E2FAC.Reference:='T1'+Import_E2FAC.NumPiece;

                            Import_E2FAC.CompteLigne:=Import_CaisseTmp.compte;
                            Import_E2FAC.Libelle:=Import_CaisseTmp.libelle;

                            Import_E2FAC.MontantDebit:='0';
                            Import_E2FAC.MontantCredit:='0';
                            //
                            if(total>0) then
                                tauxTiers:=StrToCurr_Lgr(Import_CaisseTmp.montant)*100/total;
                            partTiers:=StrToCurr_Lgr(Import_Caisse.montant)*(tauxTiers/100);
                            totalRestant:=totalRestant-partTiers;
                            if(Import_CaisseTmp.sens='D')then
                            Import_E2FAC.MontantDebit:=CurrToStr_Lgr(partTiers)  //le montant est celui correspondant au compte de banque
                            else
                            Import_E2FAC.MontantCredit:=CurrToStr_Lgr(partTiers);
                            Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;

                            Import_E2FAC.CompteColl:=DMTiers.CptDuTiers(Import_CaisseTmp.compte);
                            Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;

                            Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                            inc(idPieceTmp);
                            listeTemp2.Add(Import_E2FAC);

                            if(listeTiersBanque.count-1=nbTiers) and (totalRestant<>0)then
                            begin
                                if(Import_CaisseTmp.sens='D')then
                                Import_E2FAC.MontantDebit:=CurrToStr_Lgr(partTiers+totalRestant)  //le montant est celui correspondant au compte de banque
                                else
                                Import_E2FAC.MontantCredit:=CurrToStr_Lgr(partTiers+totalRestant);
                            end;
                        end;
                        inc(maxPiece);// on incremente pour la ligne de banque suivante si besoin qui
                            // impliquera de créer une nouvelle pièce de banque, donc nouveau numero
                    end;
                 end;

            end;
            //////////////////Pièce de ventes ///////////////
            if(Import_Caisse.journal='VT')then
            begin
               if(str_commence_par(Import_Caisse.compte,'+'))then
                 begin //ligne de contrepartie
                        New(Import_E2FAC);
                        InitialisePImport_E2FAC(Import_E2FAC);
                        Import_E2FAC.NumPiece:=Import_Caisse.numPiece;
                        inc(maxLignePiece);
                        Import_E2FAC.NumLigne:=IntToStr_Lgr(maxLignePiece);
                        Import_E2FAC.TypePiece:='V';
                        Import_E2FAC.DatePiece:=Import_Caisse.datePiece;
                        Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                        Import_E2FAC.ReferenceInitial:=Import_E2FAC.NumPiece+'_'+str_remplacesouschaine(Import_E2FAC.datePiece,'/','');
                        Import_E2FAC.Reference:='VT'+Import_E2FAC.NumPiece;

                        Import_E2FAC.CompteLigne:=Import_Caisse.compte;
                        Import_E2FAC.Libelle:=Import_Caisse.libelle;

                        Import_E2FAC.MontantDebit:='0';
                        Import_E2FAC.MontantCredit:='0';

                        if(Import_Caisse.sens='D')then
                        Import_E2FAC.MontantDebit:=Import_Caisse.montant
                        else
                        Import_E2FAC.MontantCredit:=Import_Caisse.montant;
                        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;

                        Import_E2FAC.CompteColl:=DMTiers.CptDuTiers(trim(Import_Caisse.compte));
                        if(Import_E2FAC.CompteColl='')then Import_E2FAC.CompteColl:='411';
                        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;

                        Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                        inc(idPieceTmp);
                        listeTemp2.Add(Import_E2FAC);
                 end;
               if(str_commence_par(Import_Caisse.compte,'44'))then
                 begin //ligne de tva
                        New(Import_E2FAC);
                        InitialisePImport_E2FAC(Import_E2FAC);
                        Import_E2FAC.NumPiece:=Import_Caisse.numPiece;
                        inc(maxLignePiece);
                        Import_E2FAC.NumLigne:=IntToStr_Lgr(maxLignePiece);
                        Import_E2FAC.TypePiece:='V';
                        
                        Import_E2FAC.DatePiece:=Import_Caisse.datePiece;
                        Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                        Import_E2FAC.ReferenceInitial:=Import_E2FAC.NumPiece+'_'+str_remplacesouschaine(Import_E2FAC.datePiece,'/','');
                        Import_E2FAC.Reference:='VT'+Import_E2FAC.NumPiece;

                        Import_E2FAC.CompteLigne:=Import_Caisse.compte;
                        //rechercher dans les codetva pour retrouver le taux et le codetva correspondant à ce compte
                        codeTva:=FTvaRecupCodeTva(Import_Caisse.compte);

                        Import_E2FAC.CodeTVA:=codeTva;
                        Import_E2FAC.TauxTVA:=FloatToStr_Lgr(FTvaTauxTva(codeTva));
                        
                        Import_E2FAC.Libelle:=Import_Caisse.libelle;
                        Import_E2FAC.MontantDebit:='0';
                        Import_E2FAC.MontantCredit:='0';

                        if(Import_Caisse.sens='D')then
                        Import_E2FAC.MontantDebit:=Import_Caisse.montant  //le montant est celui correspondant au compte de banque
                        else
                        Import_E2FAC.MontantCredit:=Import_Caisse.montant;
                        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;

                        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;

                        Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                        inc(idPieceTmp);
                        listeTemp2.Add(Import_E2FAC);
                 end;
               if(str_commence_par(Import_Caisse.compte,'7'))then
                 begin //ligne de ventes
                        New(Import_E2FAC);
                        InitialisePImport_E2FAC(Import_E2FAC);

                        Import_E2FAC.NumPiece:=Import_Caisse.numPiece;
                        inc(maxLignePiece);
                        Import_E2FAC.NumLigne:=IntToStr_Lgr(maxLignePiece);
                        Import_E2FAC.TypePiece:='V';

                        Import_E2FAC.DatePiece:=Import_Caisse.datePiece;
                        Import_E2FAC.DatePiece:=str_souschaine(Import_E2FAC.datePiece,7,2)+'/'+str_souschaine(Import_E2FAC.datePiece,5,2)+'/'+str_souschaine(Import_E2FAC.datePiece,3,2);
                        Import_E2FAC.ReferenceInitial:=Import_E2FAC.NumPiece+'_'+str_remplacesouschaine(Import_E2FAC.datePiece,'/','');
                        Import_E2FAC.Reference:='VT'+Import_E2FAC.NumPiece;

                        Import_E2FAC.CompteLigne:=Import_Caisse.compte;
                        //rechercher le parametrage du compte au niveau codetva et taux dans plancpt pour faire le parallèle avec
                        // les lignes de tva
                        Import_E2FAC.CodeTVA:=DMPlan.CodeDeTvaDuCompte(Import_E2FAC.CompteLigne);
                        Import_E2FAC.TauxTVA:=FloatToStr_Lgr(DMPlan.TauxDeTvaDuCompte(Import_E2FAC.CompteLigne));

                        Import_E2FAC.Libelle:=Import_Caisse.libelle;
                        Import_E2FAC.MontantDebit:='0';
                        Import_E2FAC.MontantCredit:='0';

                        if(Import_Caisse.sens='D')then
                        Import_E2FAC.MontantDebit:=Import_Caisse.montant  //le montant est celui correspondant au compte de banque
                        else
                        Import_E2FAC.MontantCredit:=Import_Caisse.montant;
                        Import_E2FAC.DateEcheancePiece:=Import_E2FAC.datePiece;

                        Import_E2FAC.DateLivraisonLigne:=Import_E2FAC.datePiece;

                        Import_E2FAC.idTmp:=IntToStr_Lgr(idPieceTmp);
                        inc(idPieceTmp);
                        listeTemp2.Add(Import_E2FAC);
                 end; //fin si //ligne de ventes
            end; //fin if(Import_Caisse.journal='VT')then
      inc(i);
      end;//fin //sinon on rempli une liste temp

  end; //fin du while  (i<=listeTemp1.Count-1)


//traiter les dernières lignes
//      if(PImportCaisseEnregistreuse(listeTemp1.Items[i])^.numPiece<>numPieceCourant)then
//      begin //changement de pièce
          for j:=0 to listeTemp2.Count-1 do
          begin
             ListeCaisse.Add(listeTemp2.Items[j]);
          end;

          for j:=0 to listeTemp2.Count-1 do
          begin
             Tva_A_Replacer:=PImport_E2FAC(listeTemp2.Items[j]);
             if(str_commence_par(Tva_A_Replacer.CompteLigne,'44'))then
             begin
                //rechercher le compte de vente correspond au paramètre de cette ligne de tva
                for k:=0 to listeTemp2.Count-1 do
                begin
                    Import_E2FAC:=PImport_E2FAC(listeTemp2.Items[k]);
                    if(Tva_A_Replacer.NumPiece=Import_E2FAC.NumPiece)and(not str_commence_par(Import_E2FAC.compteLigne,'44'))and((Tva_A_Replacer.CodeTVA=Import_E2FAC.CodeTVA)and(Tva_A_Replacer.TauxTVA=Import_E2FAC.TauxTVA))then
                      begin
                         // on recupère le montant tva de la ligne de tva pour l'attribuer à la ligne de vente
                         //ensuite on supprime cette ligne de tva de la liste des lignes
                         idPieceTmp:=ListeCaisse.IndexOf(Import_E2FAC);

                         PImport_E2FAC(ListeCaisse.Items[idPieceTmp]).MontantDebitTVA:=Tva_A_Replacer.MontantDebit;
                         PImport_E2FAC(ListeCaisse.Items[idPieceTmp]).MontantCreditTVA:=Tva_A_Replacer.MontantCredit;
//                         if(idPieceTmp<>-1)then
//                         begin
//                            ListeCaisse.Items[idPieceTmp]:=Import_E2FAC;
//                         end;
                         if(ListeCaisse.IndexOf(Tva_A_Replacer)<>-1)then ListeCaisse.Remove(Tva_A_Replacer);
//                         ListeASupprimer.Add(Tva_A_Replacer.idTmp);
                      end;
                end;
             end;
          end;
//          listeTemp2.Clear;
//          Import_Caisse:=nil;
//          maxLignePiece:=0;
//          listeTiersBanque.clear;
//      end

 i:=0;

 for l:=0 to ListeCaisse.count-1 do
 begin
     Import_E2FAC:=PImport_E2FAC(ListeCaisse.Items[l]);
       if(str_souschaine(trim(Import_E2FAC.Reference),1,4)<>'')then
           while(Length(trim(Import_E2FAC.Reference))<9 )do
           begin

              Import_E2FAC.Reference:=str_souschaine(Import_E2FAC.Reference,1,2)+'0'+ trim(str_souschaine(Import_E2FAC.Reference,3,10));
           end;
       if(Length(trim(Import_E2FAC.RefContrepartie))>0)then
           while(Length(trim(Import_E2FAC.RefContrepartie))<9 )do
           begin
              Import_E2FAC.RefContrepartie:=str_souschaine(Import_E2FAC.RefContrepartie,1,2)+'0'+ trim(str_souschaine(Import_E2FAC.RefContrepartie,3,10));
           end;
       Import_E2FAC.MontantDebit:=ChangeDecimalSeparator(Import_E2FAC.MontantDebit);
       Import_E2FAC.MontantCredit:=ChangeDecimalSeparator(Import_E2FAC.MontantCredit);
       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebit);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCredit);
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebit:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCredit:=currtostr(conteneurCredit);

       conteneurDebit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantDebitTVA));
       conteneurCredit:=strtocurr_lgr(ChangeDecimalSeparator(Import_E2FAC.MontantCreditTVA));
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitTVA:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditTVA:=currtostr(conteneurCredit);

       Import_E2FAC.TauxTVA:=ChangeDecimalSeparator(Import_E2FAC.TauxTVA);

       TvaAReplacer:=((strtocurr_lgr(Import_E2FAC.MontantDebit)>0)and(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0))or
       ((strtocurr_lgr(Import_E2FAC.MontantCredit)>0)and(strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0));

       if ((strtocurr_lgr(Import_E2FAC.MontantDebit)-strtocurr_lgr(Import_E2FAC.MontantCredit)=0)
       and ((strtocurr_lgr(Import_E2FAC.MontantDebitTVA)>0)or(strtocurr_lgr(Import_E2FAC.MontantCreditTVA)>0)))or
        (TvaAReplacer) then
       begin //si ligne à zéro, on garde la tva pour une prochaine ligne
           i:=0;
           while (i<ListeTva_A_Replacer.Count)and(trouve=false) do
           begin
             trouve:=(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.CodeTVA=Import_E2FAC.CodeTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[i])^.TauxTVA=Import_E2FAC.TauxTVA)
               and (PImport_E2FAC(ListeTva_A_Replacer.items[i])^.NumPiece=Import_E2FAC.NumPiece);
             if not trouve then inc(i);
           end;
           if not trouve then
             begin
               new(Tva_A_Replacer);
               Tva_A_Replacer.NumPiece:=Import_E2FAC.NumPiece;
               Tva_A_Replacer.CodeTVA:=Import_E2FAC.CodeTVA;
               Tva_A_Replacer.TauxTVA:=Import_E2FAC.TauxTVA;
               Tva_A_Replacer.MontantDebitTVA:=Import_E2FAC.MontantDebitTVA;
               Tva_A_Replacer.MontantCreditTVA:=Import_E2FAC.MontantCreditTVA;
               ListeTva_A_Replacer.add(Tva_A_Replacer);
             end
           else
             begin
               PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantDebitTVA)+strtocurr_lgr(Import_E2FAC.MontantDebitTVA));
               PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.items[i])^.MontantCreditTVA)+strtocurr_lgr(Import_E2FAC.MontantCreditTVA));
             end;
           Import_E2FAC.MontantDebitTVA:='0';
           Import_E2FAC.MontantCreditTVA:='0';
       end;

       Import_E2FAC.Libelle:=str_ImportDosToWin(Import_E2FAC.Libelle);
       Import_E2FAC.NomTiers:=str_ImportDosToWin(Import_E2FAC.NomTiers);
       Import_E2FAC.Adr1:=str_ImportDosToWin(Import_E2FAC.Adr1);
       Import_E2FAC.Adr2:=str_ImportDosToWin(Import_E2FAC.Adr2);
       Import_E2FAC.Ville:=str_ImportDosToWin(Import_E2FAC.Ville);
       Import_E2FAC.CompteColl:=str_ImportDosToWin(Import_E2FAC.CompteColl);

       Import_E2FAC.CompteLigne:=str_ImportDosToWin(Import_E2FAC.CompteLigne);


       Import_E2FAC.Qte1:=ChangeDecimalSeparator(Import_E2FAC.Qte1);
       Import_E2FAC.Qte2:=ChangeDecimalSeparator(Import_E2FAC.Qte2);
       if ((((ord(Import_E2FAC.CodeTVA[1])=66)or(ord(Import_E2FAC.CodeTVA[1])=86))) and (VerifNumeric(Import_E2FAC.TauxTVA).VideOUZero)) then
        begin
          Import_E2FAC.CodeTVA:='';
          Import_E2FAC.ExibiliteTVA:='';
        end;
       try
       conteneurDebit:=strtocurr_lgr(Import_E2FAC.MontantDebitContrepartie);
       conteneurCredit:=strtocurr_lgr(Import_E2FAC.MontantCreditContrepartie);
       except
          conteneurDebit:=0;
          conteneurCredit:=0;
       end;
       determineSolde(conteneurDebit,conteneurCredit);
       Import_E2FAC.MontantDebitContrepartie:=currtostr(conteneurDebit);
       Import_E2FAC.MontantCreditContrepartie:=currtostr(conteneurCredit);
       Import_E2FAC.MontantPointage:=Import_E2FAC.MontantPointage;
 end;

//rechercher dans les lignes existantes, une ligne du même code tva pour lui rajouter cette partie de tva
  j:=0;
  while (j<=ListeTva_A_Replacer.Count-1)do
//        while (ListeTva_A_Replacer.Count<>0)do
    begin
       i:=0;
       while (i<=ListeCaisse.count-1) and (j<=ListeTva_A_Replacer.Count-1)and ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)>0)
             or(strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)>0)) do
         begin            //  PImport_E2FAC(ListeTva_A_Replacer.Items[j])^
            if (PImport_E2FAC(ListeCaisse.Items[i])^.CodeTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.CodeTVA)
              and(PImport_E2FAC(ListeCaisse.Items[i])^.TauxTVA=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.TauxTVA)
              and (PImport_E2FAC(ListeCaisse.Items[i])^.NumPiece=PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.NumPiece) then
              begin
                 if strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebit)>0 then
                   begin
                       PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebitTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantDebitTVA)+
                         strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA));
                       PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA:='0';
                   end
                 else
                 if strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantCredit)>0 then
                 begin
                   PImport_E2FAC(ListeCaisse.Items[i])^.MontantCreditTVA:=currtostr_lgr(strtocurr_lgr(PImport_E2FAC(ListeCaisse.Items[i])^.MontantCreditTVA)+
                     strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA));
                   PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA:='0';
                 end;
              end;
            if ((strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantCreditTVA)=0) and (strtocurr_lgr(PImport_E2FAC(ListeTva_A_Replacer.Items[j])^.MontantDebitTVA)=0)) then
               begin
                 ListeTva_A_Replacer.Delete(j);
                 if j>0 then
                   dec(j);
               end;
            inc(i);
         end;
    inc(j);
    end;

  finally
    Initialise_Tstringlist(ListeASupprimer);
//    Initialise_TList(ListeTva_A_Replacer);
//    Initialise_TList(listeTemp1);
//    Initialise_TList(listeTemp2);
//    Initialise_TList(listeTiersBanque);
  end;
End;




Procedure ImportationStockEPI_D(NomFichier:String;Var ListeStock:TList);
var
  Fichier: TextFile;
  Import_CDIV:TImport_CDIV;
  Import_Stock:PImport_Stock;
begin
If ListeStock = nil then
 Begin
  Showmessage('La Liste d''importation des stocks est nil!');
  abort;
 End;
 ListeStock.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    ReadLn(Fichier,Import_CDIV.TypeL,Import_CDIV.DateSaise,Import_CDIV.Compte,Import_CDIV.Libelle
           ,Import_CDIV.Sens,Import_CDIV.MontantTotalHt,Import_CDIV.MontantTVA,Import_CDIV.Qte1,Import_CDIV.PrixUnitaire);

    if StrToInt(Import_CDIV.TypeL)=3 then
     begin
       new(Import_Stock);
       InitialisePImport_Stock(Import_Stock);
       Import_Stock.Compte:=trim(Import_CDIV.Compte);
       Import_Stock.Designation:=trim(Import_CDIV.Libelle);
       if StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))> 0 then
         Import_Stock.Qte:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))
       else
         Import_Stock.Qte:=1;
       if StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.PrixUnitaire)) > 0 then
         Import_Stock.PrixUnitaire:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.PrixUnitaire))
       else
         Import_Stock.PrixUnitaire:=0;
       Import_Stock.Decote:=Trunc(StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTVA)));
       Import_Stock.PrixTHT:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTotalHt));

        if (ArrondiCentieme((Import_Stock.Qte*(Import_Stock.PrixUnitaire*Import_Stock.Decote)/100))<>Import_Stock.PrixTHT) then
          Begin
            Import_Stock.Qte:=1;
            Import_Stock.PrixUnitaire:=Import_Stock.PrixTHT;
            Import_Stock.Decote:=0;
          end;
       if Import_Stock.PrixUnitaire = 0 then
        begin
         if Import_Stock.Qte = 1 then
          begin
            Import_Stock.PrixUnitaire:=Import_Stock.PrixTHT;
          end;
        end;
       ListeStock.Add(Import_Stock);
     end;
  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier

//
End;

//Procedure ImportationChAPayerEPI_D(NomFichier:String;Var ListeStock:TList);
//var
//  Fichier: TextFile;
//  Import_CDIV:TImport_CDIV;
//  Import_Stock:PImport_Stock;
//begin
//If ListeStock = nil then
// Begin
//  Showmessage('La Liste d''importation des stocks est nil!');
//  abort;
// End;
// ListeStock.Clear;
// AssignFile(Fichier, NomFichier);
// Reset(Fichier);
// while not Eof(Fichier) do
//  begin
//    ReadLn(Fichier,Import_CDIV.TypeL,Import_CDIV.DateSaise,Import_CDIV.Compte,Import_CDIV.Libelle
//           ,Import_CDIV.Sens,Import_CDIV.MontantTotalHt,Import_CDIV.MontantTVA,Import_CDIV.Qte1,Import_CDIV.PrixUnitaire);
//
//    if StrToInt(Import_CDIV.TypeL)=4 then
//     begin
//       new(Import_Stock);
//       InitialisePImport_Stock(Import_Stock);
//       Import_Stock.Compte:=trim(Import_CDIV.Compte);
//       Import_Stock.Designation:=trim(Import_CDIV.Libelle);
//       if StrToCurr_Lgr(Import_CDIV.Qte1)> 0.00 then
//       Import_Stock.Qte:=StrToCurr_Lgr(Import_CDIV.Qte1)
//       else
//       Import_Stock.Qte:=1;
////       if StrToCurr_Lgr(Import_CDIV.PrixUnitaire) > 0.00 then
////       Import_Stock.PrixUnitaire:=StrToCurr_Lgr(Import_CDIV.PrixUnitaire)
////        else
//       Import_Stock.PrixUnitaire:=StrToCurr_Lgr(Import_CDIV.PrixUnitaire);
//       if Import_Stock.PrixUnitaire = 0 then
//        begin
//         if Import_Stock.Qte = 1 then
//          begin
//            Import_Stock.PrixUnitaire:=StrToCurr_Lgr(Import_CDIV.MontantTotalHt);
//          end;
//        end;
//       Import_Stock.Decote:=0;
//       Import_Stock.PrixTHT:=StrToCurr_Lgr(Import_CDIV.MontantTotalHt);
//       ListeStock.Add(Import_Stock);
//     end;
//  end;
//// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
// CloseFile(Fichier); // ferme le fichier
//
////
//End;

Procedure ImportationPlanEPI_DOS_ENTIER(NomFichier:String;Var ListeCompte:TList);
var
  Fichier: TextFile;
  Import_Plan:PImport_Plan;
begin
If ListeCompte = nil then
 Begin
  Showmessage('La Liste d''importation des comptes est nil!');
  abort;
 End;
 ListeCompte.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    new(Import_Plan);
    ReadLn(Fichier,Import_Plan.Compte,
                   Import_Plan.Libelle,
                   Import_Plan.BilanOuvCredit,
                   Import_Plan.BilanOuvDebit,
                   Import_Plan.CodeTVA,
                   Import_Plan.TypeTVA,
                   Import_Plan.SensSaisie,
                   Import_Plan.Collectif,
                   Import_Plan.String1,
                   Import_Plan.U1,
                   Import_Plan.U2,
                   Import_Plan.String2,
                   Import_Plan.Immo);
       Import_Plan.Libelle:=str_ImportDosToWin(Import_Plan.Libelle);
       ListeCompte.Add(Import_Plan);
  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier
End;

Procedure ImportationBO_SIEA_DOS(NomFichier:String;Var ListeCompte:TList);
var
  Fichier: TextFile;
  Text:STring;
  Separateur:STring[1];
  Import_BO_SIEA_DOS:PImport_BO_SIEA_DOS;
  i,NbSep:integer;
begin                             
If ListeCompte = nil then
 Begin
  Showmessage('La Liste d''importation des comptes est nil!');
  abort;
 End;
 ListeCompte.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    new(Import_BO_SIEA_DOS);
    // Si taille des colonnes fixes
//    ReadLn(Fichier,Import_BO_SIEA_DOS.Compte,
//                   Separateur,
//                   Import_BO_SIEA_DOS.ReportDebit,
//                   Separateur,
//                   Import_BO_SIEA_DOS.ReportCredit,
//                   Separateur,
//                   Import_BO_SIEA_DOS.MvtDebit,
//                   Separateur,
//                   Import_BO_SIEA_DOS.MvtCredit,
//                   Separateur,
//                   Import_BO_SIEA_DOS.Libelle);
    Readln(Fichier,Text);
    NbSep:=Str_Count_Str(',',Text);
//    for i:=1 to NbSep do
    for i:=1 to NbSep+1 do{ isa  le  13/02/04 }
     begin
      case i of
        1:Import_BO_SIEA_DOS.Compte := str_QueDesChiffres(str_getstringelement(Text,i,','));
        2:Import_BO_SIEA_DOS.ReportDebit := str_getstringelement(Text,i,',');
        3:Import_BO_SIEA_DOS.ReportCredit := str_getstringelement(Text,i,',');
        { isa  le  06/11/03 }
        4:Import_BO_SIEA_DOS.MvtDebit := str_getstringelement(Text,i,',');
        5:Import_BO_SIEA_DOS.MvtCredit := str_getstringelement(Text,i,',');
        { isa  le  06/11/03 }
        6:Import_BO_SIEA_DOS.Libelle:=str_ImportDosToWin(str_getstringelement(Text,i,','));
      else ;
      end;


     end;
//       Import_BO_SIEA_DOS.Compte := str_QueDesChiffres(Import_BO_SIEA_DOS.Compte);
//       Import_BO_SIEA_DOS.Libelle:=str_ImportDosToWin(Import_BO_SIEA_DOS.Libelle);
       ListeCompte.Add(Import_BO_SIEA_DOS);
  end;
 CloseFile(Fichier); // ferme le fichier
End;

Procedure ImportationCodeTvaEPI_DOS(NomFichier:String;Var ListeCodeTva:TList);
var
  Fichier: TextFile;
  Import_Tva:PImport_Tva;
begin
If ListeCodeTva = nil then
 Begin
  Showmessage('La Liste d''importation des Codes Tva est nil!');
  abort;
 End;
 ListeCodeTva.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    new(Import_Tva);

    ReadLn(Fichier,Import_Tva.CodeTVA,
                   Import_Tva.Libelle,
                   Import_Tva.TypeTVA,
                   Import_Tva.Compte,
                   Import_Tva.Taux1,
                   Import_Tva.Taux2);
       Import_Tva.Libelle:=str_ImportDosToWin(Import_Tva.Libelle);
       ListeCodeTva.Add(Import_Tva);
  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier
End;

Procedure ImportationPlanAuxEPI_DOS(NomFichier:String;Var ListeTiers:TList);
var
  Fichier: TextFile;
  Import_Tiers:PImport_Tiers;
begin
If ListeTiers = nil then
 Begin
  Showmessage('La Liste d''importation des Tiers est nil!');
  abort;
 End;
 ListeTiers.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    new(Import_Tiers);

    ReadLn(Fichier,Import_Tiers.Tiers,
                   Import_Tiers.Nom,
                   Import_Tiers.CreditDeb,
                   Import_Tiers.DebitDeb,
                   Import_Tiers.Compte,
                   Import_Tiers.TypeTiers);
       Import_Tiers.Nom:=str_ImportDosToWin(Import_Tiers.Nom);
       ListeTiers.Add(Import_Tiers);
  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier

End;


Procedure ImportationChAPayerEPI_D(NomFichier:String;Var ListeChargeAPayer,ListeProduitARecevoir:TList);
var
  Fichier: TextFile;
  Import_CDIV:TImport_CDIV;
  Import_ChAPayer:PImport_ChAPayer;
begin
If ListeChargeAPayer = nil then
 Begin
  Showmessage('La Liste d''importation des Charges à Payer et Produits à recevoir est nil!');
  abort;
 End;
 ListeChargeAPayer.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    ReadLn(Fichier,Import_CDIV.TypeL,
                   Import_CDIV.DateSaise,
                   Import_CDIV.Compte,
                   Import_CDIV.Libelle,
                   Import_CDIV.Sens,
                   Import_CDIV.MontantTotalHt,
                   Import_CDIV.MontantTVA,
                   Import_CDIV.Qte1,
                   Import_CDIV.PrixUnitaire,
                   Import_CDIV.DateLivraison,
                   Import_CDIV.String2,
                   Import_CDIV.DateExoDeb,
                   Import_CDIV.String3,
                   Import_CDIV.Date3,
                   Import_CDIV.String4,
                   Import_CDIV.ReferenceRep,
                   Import_CDIV.String5,
                   Import_CDIV.CompteSecondaire
                   );

    // Charges à payer;
    if StrToInt(Import_CDIV.TypeL)=9 then
     begin

       new(Import_ChAPayer);
       InitialisePImport_ChAPayer(Import_ChAPayer);
       Import_ChAPayer.Compte:=trim(Import_CDIV.Compte);
       Import_ChAPayer.Designation:=trim(Import_CDIV.Libelle);

       if StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))> 0 then
       Import_ChAPayer.Qte:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))
       else
       Import_ChAPayer.Qte:=1;
       Import_ChAPayer.MontantHt:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTotalHt));
       Import_ChAPayer.TVA:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTVA));
       Import_ChAPayer.Compte2:=trim(Import_CDIV.CompteSecondaire);
       ListeChargeAPayer.Add(Import_ChAPayer);
     end;

    // Produit a recevoir
    if StrToInt(Import_CDIV.TypeL)=10 then
     begin

       new(Import_ChAPayer);
       InitialisePImport_ChAPayer(Import_ChAPayer);
       Import_ChAPayer.Compte:=trim(Import_CDIV.Compte);
       Import_ChAPayer.Designation:=trim(Import_CDIV.Libelle);

       if StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))> 0 then
       Import_ChAPayer.Qte:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))
       else
       Import_ChAPayer.Qte:=1;
       Import_ChAPayer.MontantHt:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTotalHt));
       Import_ChAPayer.TVA:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTVA));
       Import_ChAPayer.Compte2:=Import_CDIV.CompteSecondaire;
       ListeProduitARecevoir.Add(Import_ChAPayer);
     end;

  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier

//
End;

Procedure ImportationChPCAvanceEPI_D(NomFichier:String;Var ListeChargesCAvance,ListeProduitCAVance:TList);
var
  Fichier: TextFile;
  Import_CDIV:TImport_CDIV;
  Import_ChPCAvance:PImport_ChPCAvance;
begin
If ListeChargesCAvance = nil then
 Begin
  Showmessage('La Liste d''importation des Charges constatées d''avance est nil!');
  abort;
 End;
 ListeChargesCAvance.Clear;
 ListeProduitCAVance.clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    ReadLn(Fichier,Import_CDIV.TypeL,
                   Import_CDIV.DateSaise,
                   Import_CDIV.Compte,
                   Import_CDIV.Libelle,
                   Import_CDIV.Sens,
                   Import_CDIV.MontantTotalHt,
                   Import_CDIV.MontantTVA,
                   Import_CDIV.Qte1,
                   Import_CDIV.PrixUnitaire,
                   Import_CDIV.DateLivraison,
                   Import_CDIV.String2,
                   Import_CDIV.DateExoDeb,
                   Import_CDIV.String3,
                   Import_CDIV.Date3,
                   Import_CDIV.String4,
                   Import_CDIV.ReferenceRep,
                   Import_CDIV.String5,
                   Import_CDIV.CompteSecondaire
                   );

    // Charges Constatées d'avance;
    if StrToInt(Import_CDIV.TypeL)=13 then
     begin

       new(Import_ChPCAvance);
       InitialisePImport_ChPCAvance(Import_ChPCAvance);
       Import_ChPCAvance.Compte:=trim(Import_CDIV.Compte);
       Import_ChPCAvance.Designation:=trim(Import_CDIV.Libelle);

       if StrToFloat_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))> 0 then
       Import_ChPCAvance.Qte:=StrToFloat_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))
       else
       Import_ChPCAvance.Qte:=1;
       Import_ChPCAvance.MontantHt:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTotalHt));
       Import_ChPCAvance.Compte2:=trim(Import_CDIV.CompteSecondaire);
       ListeChargesCAvance.Add(Import_ChPCAvance);
     end;

    // Produit Constatés d'avance
    if StrToInt(Import_CDIV.TypeL)=14 then
     begin

       new(Import_ChPCAvance);
       InitialisePImport_ChPCAvance(Import_ChPCAvance);
       Import_ChPCAvance.Compte:=trim(Import_CDIV.Compte);
       Import_ChPCAvance.Designation:=trim(Import_CDIV.Libelle);

       if StrToFloat_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))> 0 then
       Import_ChPCAvance.Qte:=StrToFloat_Lgr(ChangeDecimalSeparator(Import_CDIV.Qte1))
       else
       Import_ChPCAvance.Qte:=1;
       Import_ChPCAvance.MontantHt:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTotalHt));
       Import_ChPCAvance.Compte2:=Import_CDIV.CompteSecondaire;
       ListeProduitCAVance.Add(Import_ChPCAvance);
     end;

  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier

//
End;

Procedure ImportationProvisionsEPI_D(NomFichier:String;Var ListeProvision:TList);
var
  Fichier: TextFile;
  Import_CDIV:TImport_CDIV;
  Import_Provision:PImport_Provisions;
  AffichMessage:Boolean;
begin
If ListeProvision = nil then
 Begin
  Showmessage('La Liste d''importation des Provisions est nil!');
  abort;
 End;
 ListeProvision.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 AffichMessage:=true;
 while not Eof(Fichier) do
  begin
    ReadLn(Fichier,Import_CDIV.TypeL,Import_CDIV.DateSaise,Import_CDIV.Compte,Import_CDIV.Libelle
           ,Import_CDIV.Sens,Import_CDIV.MontantTotalHt,Import_CDIV.Qte1,Import_CDIV.PrixUnitaire,Import_CDIV.MontantTVA);
    //ici, montanttva est utilisé pour récupérer le bilan d'ouverture
    if StrToInt(Import_CDIV.TypeL)=11 then
     begin
       new(Import_Provision);
       InitialisePImport_Provision(Import_Provision);
       Import_Provision.Compte:=trim(Import_CDIV.Compte);
       Import_Provision.Designation:=trim(Import_CDIV.Libelle);
       Import_Provision.MtBilanOuverture:=0;
       Import_Provision.MtTotalProvision:=0;
//       if AffichMessage then
//        Showmessage('A verifier avec Denis, le champ MtBilanOuverture');
       AffichMessage:=false;// A verifier avec Denis
       Import_Provision.MtBilanOuverture:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTVA));
       Import_Provision.MtTotalProvision:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTotalHt));
       ListeProvision.Add(Import_Provision);
     end;
  end;
 CloseFile(Fichier); 

End;

Procedure ImportationChARepartirEPI_D(NomFichier:String;Var ListeChARepartir:TList);
var
  Fichier: TextFile;
  Import_CDIV:TImport_CDIV;
  Import_ChARepartir:PImport_ChARepartir;
  AffichMessage:Boolean;
begin
If ListeChARepartir = nil then
 Begin
  Showmessage('La Liste d''importation des Charges à répartir est nil!');
  abort;
 End;
 ListeChARepartir.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 AffichMessage:=true;
 while not Eof(Fichier) do
  begin
    ReadLn(Fichier,Import_CDIV.TypeL,Import_CDIV.DateSaise,Import_CDIV.Compte,Import_CDIV.Libelle
           ,Import_CDIV.Sens,Import_CDIV.MontantTotalHt,Import_CDIV.Qte1,Import_CDIV.PrixUnitaire,Import_CDIV.MontantTVA);
    //ici, montanttva est utilisé pour récupérer le bilan d'ouverture
    
    if StrToInt(Import_CDIV.TypeL)=12 then
     begin
       new(Import_ChARepartir);
       InitialisePImport_ChARepartir(Import_ChARepartir);
       Import_ChARepartir.Compte:=trim(Import_CDIV.Compte);
       Import_ChARepartir.Designation:=trim(Import_CDIV.Libelle);
       Import_ChARepartir.MtBilanOuverture:=0;
       Import_ChARepartir.MtTotalCharge:=0;
//       if AffichMessage then
//        Showmessage('A verifier avec Denis, le champ MtBilanTotalCharge');
       AffichMessage:=false;// A verifier avec Denis
       Import_ChARepartir.MtTotalCharge:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTotalHt));
       Import_ChARepartir.MtBilanOuverture:=StrToCurr_Lgr(ChangeDecimalSeparator(Import_CDIV.MontantTVA));
       ListeChARepartir.Add(Import_ChARepartir);
     end;
  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier

//
End;

Procedure ImportationJournaux(NomFichier:String;Var ListeJournaux:TList);
var
  Fichier: TextFile;
  Import_Journaux:PImport_Journaux;
begin
If ListeJournaux = nil then
 Begin
  Showmessage('La Liste d''importation des Journaux est nil!');
  abort;
 End;
 ListeJournaux.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    new(Import_Journaux);
    ReadLn(Fichier,Import_Journaux.Journal,
                   Import_Journaux.Libelle,
                   Import_Journaux.CodeInterne,
                   Import_Journaux.Compte,
                   Import_Journaux.Date);
       Import_Journaux.Libelle:=str_ImportDosToWin(Import_Journaux.Libelle);
       ListeJournaux.Add(Import_Journaux);
  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier
End;

Procedure ImportationImmo(NomFichier:String;Var ListeImmo:TList);
var
  Fichier: TextFile;
  Import_Immo:PImport_Immo;
begin
If ListeImmo = nil then
 Begin
  Showmessage('La Liste d''importation des Immos est nil!');
  abort;
 End;
 ListeImmo.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 while not Eof(Fichier) do
  begin
    new(Import_Immo);
    ReadLn(Fichier,Import_Immo.NumCpt,
                   Import_Immo.CodeImmo,
                   Import_Immo.SousCodeImmo,
                   Import_Immo.Designation,
                   Import_Immo.DateOrg,
                   Import_Immo.ValeurAvantReel,
                   Import_Immo.ValeurVenale,
                   Import_Immo.DureeTotale,
                   Import_Immo.ValeurAAmortir,
                   Import_Immo.TvaOrg,
                   Import_Immo.DateAchatPourReel,
                   Import_Immo.DateMiseEnService,
                   Import_Immo.NbMoisAmort,
                   Import_Immo.TypeEco,
                   Import_Immo.TypeFiscal,
                   Import_Immo.TauxLineaire,
                   Import_Immo.TauxDegressif,
                   Import_Immo.DeducSurInvest,
                   Import_Immo.MontantDeducSurInvest,
                   Import_Immo.ValeurNetteComptable,
                   Import_Immo.AmortEco,
                   Import_Immo.AmortDerogNonGere,
                   Import_Immo.AmortDerog,
                   Import_Immo.AmortExcept,
                   Import_Immo.MontantCession,
                   Import_Immo.DateCession,
                   Import_Immo.Rebus,
                   Import_Immo.PMVCourtTerme,
                   Import_Immo.PMVLongTerme,
                   Import_Immo.TVAAReintegreSurVente,
                   Import_Immo.MontantTVAAReintegreSurVente,
                   Import_Immo.DureeDegressif,
                   Import_Immo.Simulation,
                   Import_Immo.Economique
                   );
       Import_Immo.Designation:=str_ImportDosToWin(Import_Immo.Designation);
       Import_Immo.NumCpt:=str_ImportDosToWin(Import_Immo.NumCpt);

       if Import_Immo.DateMiseEnService = '00/00/0000' then
          Import_Immo.DateMiseEnService := Import_Immo.DateAchatPourReel;

       try
          StrToInt(str_supprespaces(Import_Immo.NumCpt));
//          if Import_Immo.DateOrg
          ListeImmo.Add(Import_Immo);
       except
         //
       end;
  end;
// showmessage(Import_CDIV.TypeL+' '+Import_CDIV.DateSaise+' '+Import_CDIV.Compte+' '+Import_CDIV.Libelle);
 CloseFile(Fichier); // ferme le fichier
End;






 Procedure ImportationEcrituresEPI_DOS_PourBloquel(NomFichier:String;Var ListeEcritures,ListeOrigine:TList);
var
  Fichier: TextFile;
  Import_Ecritures:PRecordEcriture; //record déclaré dans DeclRecord
  AffichMessage:Boolean;
  Ligne:string;
  Import_E2FAC:PImport_E2FAC;
  i:integer;
  Recuperateur:string;
  DateFormat10:string;
begin
 ListeEcritures:=Tlist.create;
 ListeEcritures.Clear;
// AssignFile(Fichier, NomFichier);
 AssignFile(Fichier,NomFichier);
 Reset(Fichier);
 AffichMessage:=true;
 i:=1;
 while not Eof(Fichier) do
  begin
       ligne:='';
       Readln(fichier,Ligne);
       //récupération uniquement des lignes H ou T qui correspondent au corps de la pièce
       //la ligne de contrepartie sera créée automatiquement avec les infos d'entête de pièce
      // if ((str_getstringelement(ligne,2,';')='H')or(str_getstringelement(ligne,2,';')='T')) then
       if str_getstringelement(ligne,2,';')='H' then
         Begin
          //// Remplissage de la liste d'origine pour rentrer dans le même fonctionnement que l'import E2_fac ou Sara
          New(Import_E2FAC);
          InitialisePImport_E2FAC(Import_E2FAC);
          inc(i);
          InitialisePImport_E2FAC(Import_E2FAC);
          Import_E2FAC.NumPiece:=inttostr(strtoint_lgr(str_getstringelement(ligne,1,';')));
          Import_E2FAC.NumLigne:=inttostr(i);
          Import_E2FAC.TypePiece:=str_getstringelement(ligne,7,';')[1];

          Import_E2FAC.CompteLigne:=str_getstringelement(ligne,3,';');
//          if str_commence_par(Import_E2FAC.CompteLigne,'+')then
//            begin
//              delete(Import_E2FAC.CompteLigne,1,1);
//              Import_E2FAC.CompteLigne:='+'+Import_E2FAC.CompteLigne;
//            end;
          Import_E2FAC.Libelle:=str_getstringelement(ligne,4,';');
          Recuperateur:=str_getstringelement(ligne,7,';');
          Import_E2FAC.MontantDebit:=copy(recuperateur,(length(recuperateur)-12)+1,12);
          ChangeDecimalSeparator(Import_E2FAC.MontantDebit);
          Recuperateur:=str_getstringelement(ligne,8,';');
          Import_E2FAC.MontantCredit:=copy(recuperateur,(length(recuperateur)-12)+1,12);
          ChangeDecimalSeparator(Import_E2FAC.MontantCredit);
          Import_E2FAC.Qte1:=ChangeDecimalSeparator(str_getstringelement(ligne,5,';'));
          Import_E2FAC.Qte2:=ChangeDecimalSeparator(str_getstringelement(ligne,6,';'));
//          Import_E2FAC.CodeTVA,
          if str_getstringelement(ligne,11,';')<>'471' then
            Import_E2FAC.CompteTva:=str_getstringelement(ligne,11,';');
          if ChangeDecimalSeparator(str_getstringelement(ligne,10,';'))<>DecimalSeparator+'00' then
            Import_E2FAC.TauxTVA:=ChangeDecimalSeparator(str_getstringelement(ligne,10,';'));
          recuperateur:=str_getstringelement(ligne,9,';');
          recuperateur:=copy(recuperateur,(length(recuperateur)-12)+1,12);
          if StrToCurr_Lgr(ChangeDecimalSeparator(recuperateur))<0 then
            Import_E2FAC.MontantDebitTVA:=ChangeDecimalSeparator(recuperateur)
          else
            Import_E2FAC.MontantCreditTVA:=ChangeDecimalSeparator(recuperateur);
          Import_E2FAC.ExibiliteTVA:=str_getstringelement(ligne,13,';');

          //Récup date 'jjMMAAAA' au format 'jj/MM/AA'
          Import_E2FAC.DateLivraisonLigne:=Str_String_To_DateString(str_getstringelement(ligne,12,';'));

          ListeOrigine.Add(Import_E2FAC);
         end;
  end;
 CloseFile(Fichier); // ferme le fichier
End;


Procedure ImportationPieceEPI_DOS_PourBloquel(NomFichier:String;Var ListePiece,ListeOrigine:TList);
var
  Fichier: TextFile;
  Import_Piece:PRecordPiece; //record déclaré dans DeclRecord
  AffichMessage:Boolean;
  Ligne:string;
  Import_E2FAC:PImport_E2FAC;
  Montant:currency;
begin
 ListePiece:=Tlist.create;
 ListePiece.Clear;
 //AssignFile(Fichier, NomFichier);
 AssignFile(Fichier,NomFichier);
 Reset(Fichier);
 AffichMessage:=true;
 while not Eof(Fichier) do
  begin
       ligne:='';
       Readln(fichier,Ligne);
       //récupération de la ligne de contrepartie "qui sert d'entête de pièce"
       if not((str_getstringelement(ligne,2,';')='H')or(str_getstringelement(ligne,2,';')='T')) then
         Begin
          //// Remplissage de la liste d'origine pour rentrer dans le même fonctionnement que l'import E2_fac ou Sara
          New(Import_E2FAC);
          InitialisePImport_E2FAC(Import_E2FAC);
          Import_E2FAC.NumPiece:=inttostr(strtoint_lgr(str_getstringelement(ligne,1,';')));
          Import_E2FAC.NumLigne:=inttostr(1);
          Import_E2FAC.TypePiece:=str_getstringelement(ligne,7,';');
          //Import_E2FAC.Reference,

          //Récup date 'jjMMAAAA' au format 'jj/MM/AA'
          Import_E2FAC.DatePiece:=Str_String_To_DateString(str_getstringelement(ligne,3,';'));
          Import_E2FAC.DateEcheancePiece:=Str_String_To_DateString(str_getstringelement(ligne,4,';'));
          Import_E2FAC.CompteLigne:=str_getstringelement(ligne,6,';');
          if str_commence_par(Import_E2FAC.CompteLigne,'T')then
            begin
              delete(Import_E2FAC.CompteLigne,1,1);
              Import_E2FAC.CompteLigne:='+'+Import_E2FAC.CompteLigne;
            end;
          Import_E2FAC.Libelle:=str_getstringelement(ligne,5,';');
          Montant:= StrToCurr_Lgr(ChangeDecimalSeparator(str_getstringelement(ligne,8,';')));
          Import_E2FAC.MontantDebit:=currtostr(Montant);
          Montant:= StrToCurr_Lgr(ChangeDecimalSeparator(str_getstringelement(ligne,9,';')));
          Import_E2FAC.MontantCredit:=currtostr(Montant);
//          Import_E2FAC.Qte1,
//          Import_E2FAC.Qte2,
//          Import_E2FAC.CodeTVA,
//          Import_E2FAC.TauxTVA,
//          Import_E2FAC.MontantDebitTVA,
//          Import_E2FAC.MontantCreditTVA,
//          Import_E2FAC.DateEcheancePiece,
//          Import_E2FAC.CompteColl,
//          Import_E2FAC.NomTiers,
//          Import_E2FAC.Adr1,
//          Import_E2FAC.Adr2,
//          Import_E2FAC.CodePostal,
//          Import_E2FAC.Ville,
//          Import_E2FAC.ExibiliteTVA,

          //Récup date 'jjMMAAAA' au format 'jj/MM/AA'
          Import_E2FAC.DateLivraisonLigne:=Str_String_To_DateString(str_getstringelement(ligne,4,';'));

           ListeOrigine.Add(Import_E2FAC);
         end;
  end;
 CloseFile(Fichier); // ferme le fichier
End;


Procedure ImportationImmo_SIEA2I(NomFichier:String;Var ListeImmo:TList);
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
  Fichier: TextFile;
  Import_Immo:PImport_CIMO_SIEA2I;
  valeurNetteTmp:string[10];
  Exception:TExceptLGR;
  DatePassageReelTmp:Tdate;
  NePlusDemander:boolean;
begin
try //finally
try//except
Initialise_ExceptLGR(Exception);
If ListeImmo = nil then
 Begin
  Showmessage('La Liste d''importation des Immos est nil!');
  abort;
 End;
 ListeImmo.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 DatePassageReelTmp:=e.DatePassageReel;
 NePlusDemander:=false;
 while not Eof(Fichier) do
  begin
    new(Import_Immo);
    valeurNetteTmp:=C_StrVide;
    InitialisePImport_CIMO_SIEA2I(Import_Immo);
    ReadLn(Fichier,Import_Immo.Designation,
                   Import_Immo.TypeImmo,
                   Import_Immo.TypeFiscal,
                   Import_Immo.CodeCompte,
                   Import_Immo.DureeTotale,
                   Import_Immo.CodeTva,
                   Import_Immo.MontantTva,
                   Import_Immo.DateAchat,
                   Import_Immo.ValeurAAmortir,
                   Import_Immo.DateCession,
                   Import_Immo.MontantCession,
                   Import_Immo.AnneeChangement,
                   Import_Immo.ValeurAjustee,
                   Import_Immo.Conteneur80,
                   Import_Immo.Mois_Jour_Changement,
                   Import_Immo.Affectation,
                   Import_Immo.conteneur11,
                   Import_Immo.ValeurNetteComptable);
       //Import_Immo.NumCpt à remplir après séléction dans écran
       { isa  le  29/09/03 à enlever après test}
//       Import_Immo.NumCpt:='2154';
Import_Immo.MontantTva:=ChangeDecimalSeparator(Import_Immo.MontantTva);
Import_Immo.DureeTotale:=ChangeDecimalSeparator(Import_Immo.DureeTotale);
Import_Immo.ValeurAAmortir:=ChangeDecimalSeparator(Import_Immo.ValeurAAmortir);
Import_Immo.MontantCession:=ChangeDecimalSeparator(Import_Immo.MontantCession);
Import_Immo.ValeurAjustee:=ChangeDecimalSeparator(Import_Immo.ValeurAjustee);
Import_Immo.ValeurNetteComptable:=ChangeDecimalSeparator(Import_Immo.ValeurNetteComptable);

       while ((Length(valeurNetteTmp)<10)and(Length(Import_Immo.ValeurNetteComptable)>0)and(copy(Import_Immo.ValeurNetteComptable,Length(Import_Immo.ValeurNetteComptable),1)[1] in ['0'..'9',DecimalSeparator])) do
         Begin
            valeurNetteTmp:=copy(Import_Immo.ValeurNetteComptable,Length(Import_Immo.ValeurNetteComptable),1)+valeurNetteTmp;
            Delete(Import_Immo.ValeurNetteComptable,Length(Import_Immo.ValeurNetteComptable),1)
         end;
       Import_Immo.ValeurNetteComptable:=valeurNetteTmp;
       Import_Immo.ValeurNetteComptable:=QueDesChiffres(Import_Immo.ValeurNetteComptable);
       Import_Immo.ValeurAAmortir:= ChangeDecimalSeparator(Import_Immo.ValeurAAmortir);
//       if ((Import_Immo.DateCession = '  /  /    ')and(StrToCurr_Lgr(Import_Immo.ValeurAAmortir)>0)and(import_immo.TypeImmo='I')) then
       if ((Import_Immo.DateCession = '  /  /    ')and(import_immo.TypeImmo='I')) then
        begin
//         if not empty(Import_Immo.AnneeChangement) then
//           begin
////             Import_Immo.AmortEco:=currtostr(StrToCurr_Lgr(ChangeDecimalSeparator(Import_Immo.ValeurAAmortir))-StrToCurr_Lgr(ChangeDecimalSeparator(Import_Immo.ValeurAjustee)));
////             Import_Immo.ValeurNetteComptable:=Import_Immo.ValeurAjustee;
//             { isa  le  17/02/04 fait avec denis}
//
//             Import_Immo.ValeurAAmortir:=Import_Immo.ValeurAjustee;
//             Import_Immo.AmortEco:=currtostr(StrToCurr_Lgr(ChangeDecimalSeparator(Import_Immo.ValeurAAmortir))-StrToCurr_Lgr(ChangeDecimalSeparator(Import_Immo.ValeurNetteComptable)));
//           end
//         else


         Import_Immo.Designation:=str_ImportDosToWin(Import_Immo.Designation);

         str_supprespaces(Import_Immo.DureeTotale);
         if empty(Import_Immo.DureeTotale)then Import_Immo.DureeTotale:='0';
         case ord(Import_Immo.TypeFiscal[1]) of
           83,115:Import_Immo.TypeFiscal:='N';
            65,97:Import_Immo.TypeFiscal:='L';
           79,111:Import_Immo.TypeFiscal:='';//si 'O' on vide
         end;//fin du case typeAmt
         Import_Immo.MontantTva:= ChangeDecimalSeparator(Import_Immo.MontantTva);
         Import_Immo.MontantCession:= ChangeDecimalSeparator(Import_Immo.MontantCession);
         Import_Immo.ValeurAjustee:= ChangeDecimalSeparator(Import_Immo.ValeurAjustee);
         Import_Immo.ValeurNetteComptable:= ChangeDecimalSeparator(Import_Immo.ValeurNetteComptable);
         Import_Immo.AmortEco:= ChangeDecimalSeparator(Import_Immo.AmortEco);
          { isa  le  11/03/04  fait avec denis}
          Import_Immo.DateAchatPourReel:=Str_String_To_DateString(copy(Import_Immo.Mois_Jour_Changement,3,2)+copy(Import_Immo.Mois_Jour_Changement,1,2)+Import_Immo.AnneeChangement,0) ;
          try
            if not DateValide(Import_Immo.DateAchatPourReel)then
               raise ExceptLGR.Create('',1000,false,mtError,Exception);
            if ((DatePassageReelTmp=0) and(NePlusDemander=false)and (not empty(Import_Immo.DateAchatPourReel))) then
               begin//afficher choisir période pour récupérer une date de passage au réel
                if Application.MessageBox('Nous avons détecté une ou plusieurs date(s) de réajustement '+#13+#10+'sur le fichier SIEA d''''importation des immobilisations.'+#13+#10+'Si sur SIEA vous aviez utilisé la date de réajutement comme une date de passage au réel,'+#13+#10+'merci d''indiquer cette date sur l''écran suivant.'+#13+#10+'Pour cela, cliquez sur OUI, sinon cliquez sur NON.'+#13+#10+'Voulez-vous saisir une date de passage au réel ?','Attention',MB_ICONQUESTION+MB_YESNO + MB_DEFBUTTON1) = IDyes then
                    begin
                      Initialise_ParamAffichPeriode(ParamAffichPeriode);
                      ParamAffichPeriode.PreAffichage:=false;
                      ParamAffichPeriode.RenvoieDateDefaut:=false;
                      ParamAffichPeriode.AffichDateFin:=false;                                                                                                                                                                                                                                                                                                                                                           
                      periode:=ChoixPeriodeAffich(0,0,'Date de passage au réel SIEA',ParamAffichPeriode);
//                      periode:=ChoixPeriodeAffich(StrToDate_Lgr(Import_Immo.DateAchatPourReel),0,'Indiquer la date de passage au réel',ParamAffichPeriode);
                      if periode.Retour then DatePassageReelTmp:=periode.DateDeb;
                      NePlusDemander:=true;
                    end
                else
                  NePlusDemander:=true;
                  //if periode.Retour=false then   raise ExceptLGR.Create('L''importation de ces immobilisations requiert une date de passage au réel.'+RetourChariotSimple+'Si vous ne l''indiquez pas, l''importation ne peut pas se faire',1000,true,mtError,Exception);
               end;
            if ((StrToDate_Lgr(Import_Immo.DateAchatPourReel)=DatePassageReelTmp)or(Import_Immo.ValeurAjustee=Import_Immo.ValeurAAmortir)) then
              begin
                if StrToDate_Lgr(Import_Immo.DateAchatPourReel)=DatePassageReelTmp then //si passage au réel, date achat change
                  Import_Immo.DateAchat:=datetostr(StrToDate_Lgr(Import_Immo.DateAchatPourReel)+1);
                Import_Immo.DateAchatPourReel:=datetostr(StrToDate_Lgr(Import_Immo.DateAchatPourReel)+1);
                Import_Immo.ValeurAAmortir:=Import_Immo.ValeurAjustee; //dans les 2 cas, valeurAAmortir prend valeur ajutéé
              end
            else
               Import_Immo.DateAchatPourReel:=Import_Immo.DateAchat;
                  {  isa  le  11/03/04  fait avec denis}
          except
            Import_Immo.DateAchatPourReel:=Import_Immo.DateAchat;//si date non valide ou vide, prend date d'achat
          end;
          Import_Immo.AmortEco:=currtostr(StrToCurr_Lgr(ChangeDecimalSeparator(Import_Immo.ValeurAAmortir))-StrToCurr_Lgr(ChangeDecimalSeparator(Import_Immo.ValeurNetteComptable)));
         try
            if not empty(Import_Immo.TypeFiscal[1]) then // typeAmort = '' alors on ne prend pas en compte
              ListeImmo.Add(Import_Immo);
         except
           //
         end;
        end;
  end;
except
  abort;
end;//fin du try except
finally
 CloseFile(Fichier); // ferme le fichier
end;//fin du try finally
End;


Procedure ImportationTrameEPI_DOS(NomFichier:String;Var ListePiece:TList);
var
  Fichier: TextFile;
  Import_Trame:PImportTrame; //record déclaré dans 
  AffichMessage:Boolean;
  conteneur:Integer;
begin
 ListePiece:=Tlist.create;
 
 ListePiece.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 AffichMessage:=true;
 while not Eof(Fichier) do
  begin
       new(Import_Trame);
       InitialisePImportTrame(Import_Trame);
       ReadLn(Fichier,Import_Trame.Journal,
                      Import_Trame.CodeTrame,
                      Import_Trame.Libelle,
                      Import_Trame.Vide1,
                      Import_Trame.Compte,
                      Import_Trame.Vide2,
                      Import_Trame.CptBanque);
       Import_Trame.Libelle:=str_ImportDosToWin(Import_Trame.Libelle);
       Import_Trame.CodeTrame:=str_ImportDosToWin(Import_Trame.CodeTrame);
       { isa  le  24/12/03 }
        if  empty(import_Trame.Vide2)then
           ListePiece.Add(Import_Trame);
       { isa  le  24/12/03 }

  end;
 CloseFile(Fichier); // ferme le fichier
End;




Procedure ImportationLigneTrameEPI_DOS(NomFichier:String;Var ListePiece:TList);
var
  Fichier: TextFile;
  Import_LigneTrame:PImportLigneTrame; //record déclaré dans DeclRecord
  AffichMessage:Boolean;
  conteneur:Integer;
begin
 ListePiece:=Tlist.create;
 ListePiece.Clear;
 AssignFile(Fichier, NomFichier);
 Reset(Fichier);
 AffichMessage:=true;
 while not Eof(Fichier) do
  begin
       new(Import_LigneTrame);
       InitialisePImportLigneTrame(Import_LigneTrame);
       ReadLn(Fichier,Import_LigneTrame.Journal,
                      Import_LigneTrame.CodeTrame,
                      Import_LigneTrame.Compte,
                      Import_LigneTrame.Libelle,
                      Import_LigneTrame.sens,
                      Import_LigneTrame.NumLigne,
                      Import_LigneTrame.MontantHT,
                      Import_LigneTrame.MontantTVA,
                      Import_LigneTrame.CodeTva,
                      Import_LigneTrame.TypeTva,
                      Import_LigneTrame.TauxTva,
                      Import_LigneTrame.CompteRepartition,
                      Import_LigneTrame.TauxRepartition,
                      Import_LigneTrame.Vide1,
                      Import_LigneTrame.LibelleRepartition);
                      
       Import_LigneTrame.CodeTrame:=str_ImportDosToWin(Import_LigneTrame.CodeTrame);
       Import_LigneTrame.Libelle:=str_ImportDosToWin(Import_LigneTrame.Libelle);
       Import_LigneTrame.LibelleRepartition:=str_ImportDosToWin(Import_LigneTrame.LibelleRepartition);
       Import_LigneTrame.MontantHT:=ChangeDecimalSeparator(Import_LigneTrame.MontantHT);
       Import_LigneTrame.MontantTVA:=ChangeDecimalSeparator(Import_LigneTrame.MontantTVA);
       Import_LigneTrame.TauxTva:=ChangeDecimalSeparator(Import_LigneTrame.TauxTva);
       Import_LigneTrame.TauxRepartition:=ChangeDecimalSeparator(Import_LigneTrame.TauxRepartition);
       ListePiece.Add(Import_LigneTrame);
  end;
 CloseFile(Fichier); // ferme le fichier
End;



Procedure ImportationReleveOFX(NomFichier:String;Var ListeMouvement:TList);
var
  Fichier: TextFile;
  lignes:TStrings;
  ligneTmp:string;
  Mouvement:TReleveBancaire_Obj;
begin
try //finally
try//except

If ListeMouvement = nil then
 Begin
  Showmessage('La Liste d''importation du relevé est nil!');
  abort;
 End;
 ListeMouvement.Clear;
 lignes.LoadFromFile(NomFichier);
// AssignFile(Fichier, NomFichier);
// Reset(Fichier);
// while not Eof(Fichier) do
//  begin
//    Mouvement:=TReleveBancaire_Obj.Create(application.MainForm);
//    ReadLn(Fichier,ligneTmp);
//  end;
except
  abort;
end;//fin du try except
finally
 CloseFile(Fichier); // ferme le fichier
end;//fin du try finally
End;

constructor TReleveBancaire_Obj.Create(AOwner :TComponent);
Begin
inherited create;
End;

destructor TReleveBancaire_Obj.Destroy;
Begin
inherited Destroy;
End;


// Tri personnalisé
function TriListe(LaListe: TStringList; Index1, Index2: Integer): Integer;
var
  sTmp1, sTmp2: string;
begin
// Chaines à comparer
  sTmp1 := GetStringElement(LaListe[Index1],1,';')+GetStringElement(LaListe[Index1],12,';');
  sTmp2 := GetStringElement(LaListe[Index2],1,';')+GetStringElement(LaListe[Index2],12,';');
// Valeur de retour pour classement
  if sTmp1 > sTmp2 then
    Result := 1
  else if sTmp1 < sTmp2 then
      Result := -1
  else
      Result := 0;
end;
end.
