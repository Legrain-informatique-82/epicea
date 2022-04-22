unit DMTTVA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,LibZoneSaisie,LibSql,Gr_Librairie_Obj,E2_Librairie_Obj,
  E2_Decl_Records,LibDates,DMPiece,GrDBGrid,Librairie_Isa,
  E2_LibInfosTable,DMRecherche,DMBaseDonnee,DMBalances,DMConstantes,E2_VisuListeView,
  editions,lib_chaine,shellapi,ChoixPeriode,
  ObjetEdition,
  LibRessourceString,
  LibFichRep,
  E2_Patientez;

type

  TEcritureDeclaree=Class(Tobject)
    FPartDeclaree:currency;
    FId:integer;
    FMontantDeclare:currency;
    FHTDeclare:currency;
  Private

  public
    { Déclarations publiques }
    property PartDeclaree:currency read FPartDeclaree write FPartDeclaree;
    property Id:integer read FId write FId;
    property MontantDeclare:currency read FMontantDeclare write FMontantDeclare;
    property HTDeclare:currency read FHTDeclare write FHTDeclare;
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;


  
  TDMTmTVA = class(TDataModule)
    TaDec_Tva: TTable;
    DaDec_Tva: TDataSource;
    QuH_TvaVerouillageDefinitif: TQuery;
    QuMaitre_ParcoursEcritureTypeE: TQuery;
    DaQuMaitre_ParcoursEcritureTypeE: TDataSource;
    TaResteDC_Tva1: TTable;
    QuMaitre_ParcoursEcritureTypeEId: TIntegerField;
    QuMaitre_ParcoursEcritureTypeEId_Piece: TIntegerField;
    QuMaitre_ParcoursEcritureTypeEtypeligne: TStringField;
    QuMaitre_ParcoursEcritureTypeEtvaCode: TStringField;
    QuMaitre_ParcoursEcritureTypeEmontant_tva: TCurrencyField;
    TaResteDC_Tva1SoldeTiers: TCurrencyField;
    TaResteDC_Tva1ID_Piece: TIntegerField;
    TaResteDC_Tva1ID_Ecriture: TIntegerField;
    TaResteDC_Tva1ID: TIntegerField;
    QuMaitre_ParcoursEcritureTypeEMontantTiers: TCurrencyField;
    QuMaitre_ParcoursEcritureTypeEMontantPointe_Tiers: TCurrencyField;
    TaResteDC_Tva1Debit: TCurrencyField;
    TaResteDC_Tva1Credit: TCurrencyField;
    TaResteDC_Tva1Reste: TCurrencyField;
    QuMaitre_ParcoursEcritureTypeENouveauPointage: TCurrencyField;
    QuMaitre_ParcoursEcritureTypeENouveauProrataPointage: TFloatField;
    QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit: TCurrencyField;
    QuMaitre_ParcoursEcritureTypeEPart_Declaree: TFloatField;
    QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit: TCurrencyField;
    TaResteDC_Tva1SensSolde: TBooleanField;
    QuParcoursEcritureTypeD: TQuery;
    QuParcoursEcritureTypeDID: TIntegerField;
    QuParcoursEcritureTypeDId_Piece: TIntegerField;
    QuParcoursEcritureTypeDtypeligne: TStringField;
    QuParcoursEcritureTypeDtvaCode: TStringField;
    QuParcoursEcritureTypeDmontant_tva: TCurrencyField;
    QuParcoursEcritureTypeDDate: TDateField;
    QuParcoursEcritureTypeDTvaDebit: TCurrencyField;
    QuParcoursEcritureTypeDTvaCredit: TCurrencyField;
    QuParcoursEcritureTypeDDebit: TCurrencyField;
    QuParcoursEcritureTypeDCredit: TCurrencyField;
    QuMaitre_ParcoursEcritureTypeEProrataEnAttente: TFloatField;
    QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit: TCurrencyField;
    QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit: TCurrencyField;
    QuSupprDerniereDeclaration: TQuery;
    QuSumPointageDansPeriodeDebit: TQuery;
    TaResteDC_Tva1MontantPointe: TCurrencyField;
    QuParcoursEcritureTypeD_EnAttente: TQuery;
    QuParcoursEcritureTypeD_EnAttenteID: TIntegerField;
    QuParcoursEcritureTypeD_EnAttenteId_Piece: TIntegerField;
    QuParcoursEcritureTypeD_EnAttentetypeligne: TStringField;
    QuParcoursEcritureTypeD_EnAttentetvaCode: TStringField;
    QuParcoursEcritureTypeD_EnAttentemontant_tva: TCurrencyField;
    QuParcoursEcritureTypeD_EnAttenteDate: TDateField;
    QuParcoursEcritureTypeD_EnAttenteTvaDebit: TCurrencyField;
    QuParcoursEcritureTypeD_EnAttenteTvaCredit: TCurrencyField;
    QuParcoursEcritureTypeD_EnAttenteDebit: TCurrencyField;
    QuParcoursEcritureTypeD_EnAttenteCredit: TCurrencyField;
    TaH_TVA: TTable;
    QuDec_Tva: TQuery;
    DaQuDec_Tva: TDataSource;
    QuH_PieceTVARecherche: TQuery;
    QuSumPartDeclaree: TQuery;
    TaEcritureContrepartie: TTable;
    TaEcritureContrepartieTypeLigne: TStringField;
    TaEcritureContrepartieID: TIntegerField;
    TaEcritureContrepartieID_Piece: TIntegerField;
    TaEcritureContrepartieID_Ligne: TSmallintField;
    TaEcritureContrepartieCompte: TStringField;
    TaEcritureContrepartieTiers: TStringField;
    QuSumPartDeclareeid_ecriture: TIntegerField;
    QuDec_TvaID: TIntegerField;
    QuDec_Tvaid_piece: TIntegerField;
    QuDec_Tvaid_Ligne: TIntegerField;
    QuDec_TvaTvaCode: TStringField;
    QuDec_TvaTvaType: TStringField;
    QuDec_TvaTvaDate: TDateTimeField;
    QuDec_TvaTvaMontantDebit: TCurrencyField;
    QuDec_TvaTvaMontantCredit: TCurrencyField;
    QuDec_TvaEn_Attente: TBooleanField;
    QuDec_TvaPart_Declaration: TFloatField;
    QuDec_Tvareference: TStringField;
    QuDec_TvaCompteContrepartie: TStringField;
    QuDec_TvaDatePiece: TDateField;
    QuDec_TvaLibellePiece: TStringField;
    QuDec_TvaHTDebit: TCurrencyField;
    QuDec_TvaHTCredit: TCurrencyField;
    QuDec_Tvalibelle: TStringField;
    QuDec_TvaPart_Declare_Calc: TFloatField;
    QuDec_TvaID_Contrepartie: TIntegerField;
    QuDec_TvaCompteHT: TStringField;
    QuDec_Tva_VisuListe: TQuery;
    DaQuDec_Tva_VisuListe: TDataSource;
    QuParcoursEcritureTypeD_EnAttenteTvaDate: TDateField;
    QuParcoursEcritureTypeDTvaDate: TDateField;
    DaSupprDerniereDeclaration: TDataSource;
    QuSumPointageDansPeriodeCredit: TQuery;
    QuSumPointageDansPeriodeCreditTvaDateCredit: TDateField;
    QuSumPointageDansPeriodeDebitTvaDateDebit: TDateField;
    QuSumPointageDansPeriodeDebitMontantPointeDebit: TCurrencyField;
    QuSumPointageDansPeriodeCreditMontantPointeCredit: TCurrencyField;
    QuMaxFin_Periode: TQuery;
    QuMaxFin_Periodefin_Periode: TDateTimeField;
    QuVerifDateDecl: TQuery;
    QuDec_TvaHT_Declare_Debit: TCurrencyField;
    QuDec_TvaHT_Declare_Credit: TCurrencyField;
    QuDec_TvaHT_Declare: TCurrencyField;
    QuMaitre_ParcoursEcritureTypeESensTva: TBooleanField;
    QuMaitre_ParcoursEcritureTypeEDebitSaisie: TCurrencyField;
    QuMaitre_ParcoursEcritureTypeECreditSaisie: TCurrencyField;
    QuParcoursEcritureTypeD_EnAttenteTvaDateCalc: TDateTimeField;
    QuParcoursEcritureTypeDTvaDateCalc: TDateTimeField;
    QuMaitre_ParcoursEcritureTypeESensTiers: TBooleanField;
    QuSumParCode_Dec_Tva: TQuery;
    DaSumParCode_Dec_Tva: TDataSource;
    Ta_H_Tva_Fin: TTable;
    Ta_H_Tva_Report: TTable;
    QuSumParCode_Dec_TvaTvaCode: TStringField;
    QuSumParCode_Dec_TvaEn_Attente: TBooleanField;
    QuSumParCode_Dec_TvaHTDebit: TCurrencyField;
    QuSumParCode_Dec_TvaHTCredit: TCurrencyField;
    QuSumParCode_Dec_TvaHT_declare_Debit: TCurrencyField;
    QuSumParCode_Dec_TvaHT_Declare_Credit: TCurrencyField;
    QuSumParCode_Dec_TvaHT_Declare: TCurrencyField;
    QuSumParCode_Dec_TvaTvaMontantDebit: TCurrencyField;
    QuSumParCode_Dec_TvaTvaMontantCredit: TCurrencyField;
    QuSumParCode_Dec_TvaTvaDeclare: TCurrencyField;
    QuMAJ_H_Tva_Fin: TQuery;
    QuMAJ_H_Tva_Report: TQuery;
    QuMaxDebut_Periode: TQuery;
    TaH_PieceTVA: TTable;
    UpdateSQL1: TUpdateSQL;
    QuListeHistoriqueDeclaration: TQuery;
    QuTVAEdition: TQuery;
    QuTotalG1: TQuery;
    QuListeJournal: TQuery;
    QuParcoursEcritureTypeOD: TQuery;
    QuParcoursEcritureTypeODID: TIntegerField;
    QuParcoursEcritureTypeODId_Piece: TIntegerField;
    QuParcoursEcritureTypeODTypeLigne: TStringField;
    QuParcoursEcritureTypeODDate: TDateField;
    QuParcoursEcritureTypeODTvaDebit: TCurrencyField;
    QuParcoursEcritureTypeODTvaCredit: TCurrencyField;
    QuParcoursEcritureTypeODTvaDateCalc: TDateField;
    QuDetailHistoriqueDeclaration: TQuery;
    QuDetailHistoriqueDeclarationLibelle: TStringField;
    QuDetailHistoriqueDeclarationTvaTaux: TFloatField;
    QuDetailHistoriqueDeclarationTvacode: TStringField;
    QuDetailHistoriqueDeclarationTvaType: TStringField;
    QuDetailHistoriqueDeclarationcompte: TStringField;
    QuDetailHistoriqueDeclarationReference: TStringField;
    QuDetailHistoriqueDeclarationdebut_Periode: TDateTimeField;
    QuDetailHistoriqueDeclarationfin_Periode: TDateTimeField;
    QuDetailHistoriqueDeclarationEn_Attente: TBooleanField;
    QuDetailHistoriqueDeclarationDeverrouillable: TBooleanField;
    QuDetailHistoriqueDeclarationreference_od: TStringField;
    QuDetailHistoriqueDeclarationDate_Tva: TDateTimeField;
    QuDetailHistoriqueDeclarationPart_Declaree: TFloatField;
    QuDetailHistoriqueDeclarationmontant_tva: TCurrencyField;
    QuDetailHistoriqueDeclarationTvaCodeCalc: TStringField;
    QuDetailHistoriqueDeclarationTvaTypeCalc: TStringField;
    QuDetailHistoriqueDeclarationMtTvaCalc: TCurrencyField;
    QuDetailHistoriqueDeclarationHTDeclareCalc: TCurrencyField;
    QuDetailHistoriqueDeclarationDebitSaisie: TCurrencyField;
    QuDetailHistoriqueDeclarationCreditSaisie: TCurrencyField;
    QuDetailHistoriqueDeclarationTvaCodeRecup: TStringField;
    QuParcoursEcritureTypeODTvaCodeRecup: TStringField;
    QuSumPointageDebit: TQuery;
    QuSumPointageCredit: TQuery;
    QuSumPointageDebitTvaDateDebit: TDateField;
    QuSumPointageCreditTvaDateCredit: TDateField;
    TaResteDC_Tva1DateTva: TDateField;
    QuMaitre_ParcoursEcritureTypeETvaDate: TDateField;
    QuVerifAcceptTva: TQuery;
    QuVerifAcceptTvaPartDeclaree: TFloatField;
    QuVerifAcceptTvaId_Ecriture: TIntegerField;
    QuTVAEditionID: TIntegerField;
    QuTVAEditionid_piece: TIntegerField;
    QuTVAEditionid_Ligne: TIntegerField;
    QuTVAEditionTvaCode: TStringField;
    QuTVAEditionTvaType: TStringField;
    QuTVAEditionTvaDate: TDateTimeField;
    QuTVAEditionTvaMontantDebit: TCurrencyField;
    QuTVAEditionTvaMontantCredit: TCurrencyField;
    QuTVAEditionEn_Attente: TBooleanField;
    QuTVAEditionPart_Declaration: TFloatField;
    QuTVAEditionreference: TStringField;
    QuTVAEditionCompteContrepartie: TStringField;
    QuTVAEditionDatePiece: TDateField;
    QuTVAEditionLibellePiece: TStringField;
    QuTVAEditionCompteHT: TStringField;
    QuTVAEditionHTDebit: TCurrencyField;
    QuTVAEditionHTCredit: TCurrencyField;
    QuTVAEditionTaux: TFloatField;
    QuTVAEditionlibelle: TStringField;
    QuTVAEditionPart_Declare_Calc: TCurrencyField;
    QuTVAEditionHT_Declare_Debit: TCurrencyField;
    QuTVAEditionHT_Declare_Credit: TCurrencyField;
    QuTVAEditionHT_Declare: TCurrencyField;
    QuTVAEditionID_Contrepartie: TIntegerField;
    QuParcoursEcritureTypeODDebit: TCurrencyField;
    QuParcoursEcritureTypeODCredit: TCurrencyField;
    QuParcoursEcritureTypeODDebitSaisie: TCurrencyField;
    QuParcoursEcritureTypeODCreditSaisie: TCurrencyField;
    QuDec_Tvajournal: TIntegerField;
    QuTVAEditionjournal: TIntegerField;
    QuSumParCode_Dec_Tva_SurOD: TQuery;
    StringField1: TStringField;
    BooleanField1: TBooleanField;
    CurrencyField1: TCurrencyField;
    CurrencyField2: TCurrencyField;
    CurrencyField3: TCurrencyField;
    CurrencyField4: TCurrencyField;
    CurrencyField5: TCurrencyField;
    CurrencyField6: TCurrencyField;
    CurrencyField7: TCurrencyField;
    CurrencyField8: TCurrencyField;
    QuSumParCode_Dec_TvaHt_Declare_Debit_OD: TCurrencyField;
    QuSumParCode_Dec_TvaHt_Declare_Credit_OD: TCurrencyField;
    QuSumParCode_Dec_TvaHT_Declare_DebitCalc: TCurrencyField;
    QuSumParCode_Dec_TvaHT_Declare_CreditCalc: TCurrencyField;
    QuSumParCode_Dec_TvaHT_Declare_OD: TCurrencyField;
    QuSumParCode_Dec_TvaHT_DeclareCalc: TCurrencyField;
    QueryTvaDeclare: TQuery;
    QuSumPartDeclareeSUMOFMontantTva: TCurrencyField;
    QuSumPartDeclareeSUMOFpart_declaree: TFloatField;
    QuMaitre_ParcoursEcritureTypeEMontantDeclaree: TCurrencyField;
    QuDetailHistoriqueDeclarationmontanttva: TCurrencyField;
    QuDetailHistoriqueDeclarationHtDeclare: TCurrencyField;
    QuParcoursH_TvaTypeRegul: TQuery;
    QuParcoursH_TvaTypeRegulMontantTva: TCurrencyField;
    QuDec_TvaDivers: TStringField;
    QuCorrectionDeclarationTVA: TQuery;
    QuCorrectionDeclarationTVAId_ecriture: TIntegerField;
    QuCorrectionDeclarationTVApart_declaree: TFloatField;
    QuCorrectionDeclarationTVAmontanttva: TCurrencyField;
    QuCorrectionDeclarationTVAHTDeclare: TCurrencyField;
    QuCorrectionDeclarationTVAid_piece: TIntegerField;
    QuParcoursH_TvaTypeRegulCodeCompensation: TStringField;
    QuVerifAcceptTvamontanttva: TCurrencyField;
    QuVerifAcceptTvamontant_tva: TCurrencyField;
    QuParcoursH_TvaTypeRegulhtDeclare: TCurrencyField;
    QuDec_TvaTauxReel: TFloatField;
    QuDec_TvaTaux: TFloatField;
    QuSumParCode_Dec_Tvadivers: TStringField;
    QuSumParCode_Dec_Tva_SurODDivers: TStringField;
    QuParcoursH_TvaTypeRegulid_declaration: TIntegerField;
    QuResteDC_Tva: TQuery;
    QuResteDC_TvaID: TIntegerField;
    QuResteDC_TvaID_Ecriture: TIntegerField;
    QuResteDC_TvaID_Piece: TIntegerField;
    QuResteDC_TvaDebit: TCurrencyField;
    QuResteDC_TvaCredit: TCurrencyField;
    QuResteDC_TvaReste: TCurrencyField;
    QuResteDC_TvaSoldeTiers: TCurrencyField;
    QuResteDC_TvaSensSolde: TBooleanField;
    QuResteDC_TvaMontantPointe: TCurrencyField;
    QuResteDC_TvaDateTva: TDateField;
    procedure DMTmTVACreate(Sender: TObject);
    procedure DMTmTVADestroy(Sender: TObject);
    function VAliderDeclarationTVA(DateDeb,DateFin:TDatetime;GenerPieceTVA:boolean;AffichParamTVA:TForceAffichage):TExceptLGR;
    procedure GestionDeclarationAvantOuverture(Supp:boolean;IDEcriture,IDPiece:integer;Periode:Tdatetime);
    Procedure TraitementCloture1(Sender:TObject);
    procedure TaResteDC_Tva1CalcFields(DataSet: TDataSet);
    procedure QuMaitre_ParcoursEcritureTypeECalcFields(DataSet: TDataSet);
    procedure QuParcoursEcritureTypeDCalcFields(DataSet: TDataSet);
    function Suppression_Derniere_Declaration_Tva_Deverrouillable(ReferenceForce:string;deverrouiller,Confirmation:boolean;ForceSuppression:boolean;RemplaceParMessage:boolean=True):TExceptLGR;
    procedure MAJ_DateDeclarationTVA(var debut,fin:tdate);
    procedure QuDec_TvaAfterOpen(DataSet: TDataSet);
    procedure QuDec_TvaCalcFields(DataSet: TDataSet);
    procedure QuParcoursEcritureTypeD_EnAttenteCalcFields(
      DataSet: TDataSet);
    procedure PaGrilleResizePour_AffichInfoDeclarationTVA(Sender: TObject);
    procedure BtnDetailClick(Sender: TObject);
    function GenererPieceTva(var reference:string;ListeADeclaree:PSolde_A_Declarer):boolean;
    function Verif_Si_Date_HorsDeclarationExistante(DateDeb_,DateFin_:Tdatetime;MessageAffich:boolean):TexceptLgr;
    function RecupCodeTva_A_Exclure(ListeClasse:Tstringlist):Tfiltre;
    procedure QuSumParCode_Dec_TvaCalcFields(DataSet: TDataSet);
    procedure QuSumParCode_Dec_TvaAfterOpen(DataSet: TDataSet);

    function Affect_Ta_H_Tva_Report(ListeReport:Tlist;id_declaration:integer):TExceptLGR;
    function Recup_Ta_H_Tva_Report(Var ListeReport:Tlist;id_declaration:integer):TExceptLGR;
    function Vide_Ta_H_Tva_Report(id_Declaration:integer):TExceptLGR;
    Function Compare_Ta_H_Tva_Report(ListeReport:Tlist;id_declaration:integer):TExceptLGR;

    function Affect_Ta_H_Tva_Fin(RSolde_A_Decl:PSolde_A_Declarer;id_declaration:integer):TExceptLGR;
    function Recup_Ta_H_Tva_Fin(Var RSolde_A_Decl:PSolde_A_Declarer;id_declaration:integer):TExceptLGR;
    function Vide_Ta_H_Tva_Fin(id_Declaration:integer):TExceptLGR;
    Function Compare_Ta_H_Tva_Fin(RSolde_A_Decl:PSolde_A_Declarer;id_declaration:integer):TExceptLGR;
    Function PieceTvaExisteDansPeriode(DateDeb,DateFin:tdatetime):TExceptLGR;

    procedure Visualisation_DeclarationTVAClick(Sender: TObject);

    procedure QuParcoursEcritureTypeODCalcFields(DataSet: TDataSet);
    procedure QuDetailHistoriqueDeclarationCalcFields(DataSet: TDataSet);
//    procedure QuParcoursEcritureTypeOD_EnAttenteCalcFields(
//      DataSet: TDataSet);
    procedure QuMaitre_ParcoursEcritureTypeEFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuMaitre_ParcoursEcritureTypeDFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);

    procedure QuParcoursEcritureTypeD_EnAttenteBeforeOpen(
      DataSet: TDataSet);
    procedure QuTVAEditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuTVAEditionCalcFields(DataSet: TDataSet);
    procedure QuTVAEditionAfterOpen(DataSet: TDataSet);
    procedure Impression_DeclarationTVAClick(Sender: TObject);
    procedure QuSumParCode_Dec_TvaBeforeOpen(DataSet: TDataSet);
    Procedure PrepareQuDec_tva(FinPeriode:Tdate=0);
    procedure QuDetailHistoriqueDeclarationFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    Function VerifEcritureDeclaree(idEcriture:integer):boolean;
    Function VerifPieceDeclaree(idPiece:integer):boolean;
    procedure QuResteDC_TvaCalcFields(DataSet: TDataSet);
    procedure Afficherlasynthse1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    {Requete}

      DetailTVAAffichGlobal:TDetailTVAAffich;
      TotauxReport:Treport;
      ListeReports:Tlist;
      InfosAvantValidation:PSolde_A_Declarer;
      doublerLigne:string;
      Soldearrondi_Imposable,Soldearrondi_Deductible:currency;
      ListeFilterRecordEdition:TStringList;
      periode:Tperiode;
      liste:TStringList;
  end;
//Const
//// Remonte les Sommes triées par Code de Tva en distinguant les montants à déclarer de ceux non à déclarer
//// Ordre croissant sur Code TVa
//RqDec_Tva_SommeTvaParCode_1=
//      'select TvaCode,TvaCode.Libelle ,En_Attente ,sum(tvaMontantDebit) as TottvaMontantDebit,sum(tvaMontantCredit) as TottvaMontantCredit'+
//      ' from dec_tva'+
//      ' join TvaCode on (TvaCode.TvaCode = dec_tva.TvaCode)'+
//      ' group by TvaCode,TvaCode.Libelle,En_Attente'+
//      ' Order by TvaCode';
////        'select TvaCode ,En_Attente ,sum(tvaMontantDebit) as TottvaMontantDebit,sum(tvaMontantCredit) as TottvaMontantCredit from dec_tva'+
////        ' group by TvaCode,En_Attente'+
////        ' Order by TvaCode';
//
//// Remonte les Somme trié par Code de Tva en distinguant les montant a déclaré de ceux non a déclarée
//// Ordre décroissant sur Code TVa
//RqDec_Tva_SommeTvaParCode_2=
//        'select TvaCode ,En_Attente ,sum(tvaMontantDebit) as TottvaMontantDebit,sum(tvaMontantCredit) as TottvaMontantCredit from dec_tva'+
//        ' group by TvaCode,En_Attente'+
//        ' Order by TvaCode Desc';
{ isa  le  24/10/03 }
  Function EditionSyntheseTVAL(TypeEdition : integer; DemandePeriode:Boolean;PeriodeParam:TPeriode; CodeTva:TStringList;DataSet:TDataSet;direct:boolean=false):Boolean;overload;
  Function EditionSyntheseTVAL(TypeEdition : integer; DemandePeriode:Boolean;PeriodeParam:TPeriode; CodeTva:String;DataSet:TDataSet;direct:boolean=false):Boolean;overload;
{ isa  le  24/10/03 }
  Function EditionJournauxTvaL(TypeEdition : integer; DemandePeriode:Boolean; CodeTva:TStringList;DataSet:TDataSet;Detail:boolean=true):Boolean;overload;
  Function EditionJournauxTvaL(TypeEdition : integer; DemandePeriode:Boolean; CodeTva:String;DataSet:TDataSet;Detail:boolean=true):Boolean;overload;

var
  DMTmTVA: TDMTmTVA;
  ListeId_PointageDejaTraiter:TStringList;
  ListeIdLigneDecTvaPourVerrouillage:TStringList;


  Function CalculDeclarationTva(DateDeb,DateFin:TDate;avecControle:boolean=true):Boolean;
  Function DeclarationTVATypeD(DateDeb,DateFin:TDate):Boolean;
  Function DeclarationTVATypeE(DateDeb,DateFin:TDate):Boolean;
  Function DeclarationTVATypeOD(DateDeb,DateFin:TDate):Boolean;

  Function DeclarationTVATypeRegulation(DateDeb,DateFin:TDate):Boolean;

  Function AffichInfoDeclarationTVA(Requete:String;Affiche:boolean=true):Boolean;
  Function AffichDetailDeclarationTVA(DetailTVAAffich:TDetailTVAAffich):boolean;
  Function CalculReport(affichage:boolean;Var ListeReport:Tlist;DateDeb,DateFin:Tdate):TReport;
  Function AfficheListeHistoriqueDeclarationTVA:TParamHistorique;
  Function AfficheDetailHistoriqueDeclarationTVA(ParamHistorique:TParamHistorique):boolean;
  Function AffichDeclarationTVASurPeriode(DetailTVAAffich:TDetailTVAAffich):boolean;


  Function EditionJournauxTVA(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;

  procedure VerrouillageDeclaration_Exercice(Fin:Tdatetime);
  function Verif_SiDeclarationTvaAJour(var MessageTmp:Tmessages):TErreurSaisie;
  Function AfficheSyntheseHistoriqueDeclarationTVA(fichier:string;periode:Tperiode):boolean;

implementation

uses E2_Main,DMParamEnt, E2_VisuListe,DMEcriture, DMImportation,E2_Infos_Tva_Complementaires,
  DMDiocEtatBalance,E2_Infos_Tva_Complementaires_ApresCalcul,DMTVA,
  E2_DetailEcr,
  DMPointages2,
  DMCorrection,
  DMExports,
  LibClassObjetSenders,Menus, ComCtrls;

{$R *.DFM}

Function EditionJournauxTVA(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var NomFich,Chemin:string;
  var periode:TPeriode;
  var classe:string;      //classe du code TVA
  var ListeClasseVente,
      ListeClasseAchat,
      ListeClasseNonImposable:TStringList;
ParamAffichPeriode:TParamAffichPeriode;
Begin

  ListeClasseVente := TStringList.Create;
  ListeClasseAchat := TStringList.Create;
  ListeClasseNonImposable := TStringList.Create;
  Chemin := E.RepertoireComptaWeb;
  NomFich:='JournauxTVA';
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  if periode.Retour then begin
      if DMTmTVA=nil then DMTmTVA:=TDMTmTVA.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

      ListeClasseVente:=DM_C_ListeCTVAVente;
      ListeClasseAchat:=DM_C_ListeCTVAAchat;
      ListeClasseNonImposable:=DM_C_ListeCTVANonImposable;

      DMTmTVA.QuListeJournal.Open;
      DMTmTVA.QuListeJournal.First;
      case TypeEdition  of
          C_EditionSimple:Begin
                              Site.lien := false;
//                              ToutTVADebut(Chemin,NomFich);

                              while not DMTmTVA.QuListeJournal.Eof do begin
                                  classe:=DMTmTVA.QuListeJournal.FindField('Classe').AsString;

                                  if (ListeClasseNonImposable.IndexOf(classe)<>-1) and (classe<>'C') then begin
                                  //edition avec le HT uniquement
                                      if (ListeClasseVente.IndexOf(classe)<>-1) and (classe<>'C') then begin
                                          //credit-debit
                                          DMTmTVA.QuTVAEdition.SQL.Clear;
                                          //DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.id reference,p.compte tiers,p.libelle,');
                                          DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.reference,p.compte tiers,p.libelle,');
                                          DMTmTVA.QuTVAEdition.SQL.Add('-(sum(e.debitsaisie)-sum(e.creditsaisie))+(sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100)) ttc,');
                                          DMTmTVA.QuTVAEdition.SQL.Add('-sum(e.debitsaisie)+sum(e.creditsaisie) ht,');
                                          DMTmTVA.QuTVAEdition.SQL.Add('-sum((e.debitsaisie*tvataux)/100)+sum((e.creditsaisie*tvataux)/100) tva');
                                          DMTmTVA.QuTVAEdition.SQL.Add('from ecriture e, piece p');
                                          DMTmTVA.QuTVAEdition.SQL.Add(' where e.id_piece=p.id ');
                                          DMTmTVA.QuTVAEdition.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                          DMTmTVA.QuTVAEdition.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                          DMTmTVA.QuTVAEdition.SQL.Add(' group by p."date",p.Reference,p.compte,p.libelle ');
                                          DMTmTVA.QuTVAEdition.Open;

                                          DMTmTVA.QuTotalG1.SQL.Clear;
                                          DMTmTVA.QuTotalG1.SQL.Add('select ');
                                          DMTmTVA.QuTotalG1.SQL.Add('-sum(e.debitsaisie)+sum(e.creditsaisie) ht');
                                          DMTmTVA.QuTotalG1.SQL.Add('from ecriture e, piece p');
                                          DMTmTVA.QuTotalG1.SQL.Add(' where e.id_piece=p.id ');
                                          DMTmTVA.QuTotalG1.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                          DMTmTVA.QuTotalG1.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                          DMTmTVA.QuTotalG1.Open;
                                       end
                                       else begin
                                          //debit-credit
                                          DMTmTVA.QuTVAEdition.SQL.Clear;
                                          //DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.id reference,p.compte tiers,p.libelle,');
                                          DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.reference,p.compte tiers,p.libelle,');
                                          DMTmTVA.QuTVAEdition.SQL.Add('(sum(e.debitsaisie)-sum(e.creditsaisie))+(sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100)) ttc,');
                                          DMTmTVA.QuTVAEdition.SQL.Add('sum(e.debitsaisie)-sum(e.creditsaisie) ht,');
                                          DMTmTVA.QuTVAEdition.SQL.Add('sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100) tva');
                                          DMTmTVA.QuTVAEdition.SQL.Add('from ecriture e, piece p');
                                          DMTmTVA.QuTVAEdition.SQL.Add(' where e.id_piece=p.id ');
                                          DMTmTVA.QuTVAEdition.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                          DMTmTVA.QuTVAEdition.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                          DMTmTVA.QuTVAEdition.SQL.Add(' group by p."date",p.Reference,p.compte,p.libelle ');
                                          DMTmTVA.QuTVAEdition.Open;

                                          DMTmTVA.QuTotalG1.SQL.Clear;
                                          DMTmTVA.QuTotalG1.SQL.Add('select ');
                                          DMTmTVA.QuTotalG1.SQL.Add('sum(e.debitsaisie)-sum(e.creditsaisie) ht');
                                          DMTmTVA.QuTotalG1.SQL.Add('from ecriture e, piece p');
                                          DMTmTVA.QuTotalG1.SQL.Add(' where e.id_piece=p.id ');
                                          DMTmTVA.QuTotalG1.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                          DMTmTVA.QuTotalG1.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                          DMTmTVA.QuTotalG1.Open;
                                     end;
                                     
                                      if DMTmTVA.QuTVAEdition.Fields[0].AsString<>'' then
//                                          EditTVAcourt(Chemin,NomFich,DMTmTVA.QuTVAEdition,DMTmTVA.QuTotalG1,DMTmTVA.QuListeJournal.FindField('Libelle').AsString,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),true,Site);
                                  end;

                                  if (ListeClasseVente.IndexOf(classe)<>-1) and (classe<>'C') then begin
                                  //Edition avec TTC, HT et TVA
                                      DMTmTVA.QuTVAEdition.SQL.Clear;
                                      //DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.id reference,p.compte tiers,p.libelle,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.reference,p.compte tiers,p.libelle,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('-(sum(e.debitsaisie)-sum(e.creditsaisie))+(sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100)) ttc,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('-sum(e.debitsaisie)+sum(e.creditsaisie) ht,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('-sum((e.debitsaisie*tvataux)/100)+sum((e.creditsaisie*tvataux)/100) tva');
                                      DMTmTVA.QuTVAEdition.SQL.Add('from ecriture e, piece p');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' where e.id_piece=p.id ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' group by p."date",p.Reference,p.compte,p.libelle ');
                                      DMTmTVA.QuTVAEdition.Open;

                                      DMTmTVA.QuTotalG1.SQL.Clear;
                                      DMTmTVA.QuTotalG1.SQL.Add('select ');
                                      DMTmTVA.QuTotalG1.SQL.Add('-(sum(e.debitsaisie)-sum(e.creditsaisie))+(sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100)) ttc,');
                                      DMTmTVA.QuTotalG1.SQL.Add('-sum(e.debitsaisie)+sum(e.creditsaisie) ht,');
                                      DMTmTVA.QuTotalG1.SQL.Add('-sum((e.debitsaisie*tvataux)/100)+sum((e.creditsaisie*tvataux)/100) tva');
                                      DMTmTVA.QuTotalG1.SQL.Add('from ecriture e, piece p');
                                      DMTmTVA.QuTotalG1.SQL.Add(' where e.id_piece=p.id ');
                                      DMTmTVA.QuTotalG1.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                      DMTmTVA.QuTotalG1.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                      DMTmTVA.QuTotalG1.Open;

                                      if DMTmTVA.QuTVAEdition.Fields[0].AsString<>'' then
//                                          EditTVA(Chemin,NomFich,DMTmTVA.QuTVAEdition,DMTmTVA.QuTotalG1,DMTmTVA.QuListeJournal.FindField('Libelle').AsString,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),true,Site);
                                  end;

                                  if (ListeClasseAchat.IndexOf(classe)<>-1) and (Classe<>'C') then begin
                                  //Editions avec TTC et détails
                                      DMTmTVA.QuTVAEdition.SQL.Clear;
                                      //DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.id reference,p.compte tiers,p.libelle,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.reference,p.compte tiers,p.libelle,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('(sum(e.debitsaisie)-sum(e.creditsaisie))+(sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100)) ttc,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('sum(e.debitsaisie)-sum(e.creditsaisie) ht,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100) tva');
                                      DMTmTVA.QuTVAEdition.SQL.Add('from ecriture e, piece p');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' where e.id_piece=p.id ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' group by p."date",p.Reference,p.compte,p.libelle ');
                                      DMTmTVA.QuTVAEdition.Open;

                                      DMTmTVA.QuTotalG1.SQL.Clear;
                                      DMTmTVA.QuTotalG1.SQL.Add('select ');
                                      DMTmTVA.QuTotalG1.SQL.Add('(sum(e.debitsaisie)-sum(e.creditsaisie))+(sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100)) ttc,');
                                      DMTmTVA.QuTotalG1.SQL.Add('sum(e.debitsaisie)-sum(e.creditsaisie) ht,');
                                      DMTmTVA.QuTotalG1.SQL.Add('sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100) tva');
                                      DMTmTVA.QuTotalG1.SQL.Add('from ecriture e, piece p');
                                      DMTmTVA.QuTotalG1.SQL.Add(' where e.id_piece=p.id ');
                                      DMTmTVA.QuTotalG1.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                      DMTmTVA.QuTotalG1.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                      DMTmTVA.QuTotalG1.Open;

                                      if DMTmTVA.QuTVAEdition.Fields[0].AsString<>'' then
                                         //EditTVAlong(Chemin,NomFich,DMTmTVA.QuTVAEdition,DMTmTVA.QuTotalG1,DMTmTVA.QuListeJournal.FindField('Libelle').AsString,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),true,Site);
//                                          EditTVA(Chemin,NomFich,DMTmTVA.QuTVAEdition,DMTmTVA.QuTotalG1,DMTmTVA.QuListeJournal.FindField('Libelle').AsString,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),true,Site);
                                  end;

                                  if classe='C' then begin
                                  //TTC, HT, et TVA
                                      DMTmTVA.QuTVAEdition.SQL.Clear;
                                      //DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.id reference,p.compte tiers,p.libelle,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('select p."date",p.reference,p.compte tiers,p.libelle,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('-(sum(e.debitsaisie)-sum(e.creditsaisie))+(sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100)) ttc,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('-sum(e.debitsaisie)+sum(e.creditsaisie) ht,');
                                      DMTmTVA.QuTVAEdition.SQL.Add('-sum((e.debitsaisie*tvataux)/100)+sum((e.creditsaisie*tvataux)/100) tva');
                                      DMTmTVA.QuTVAEdition.SQL.Add('from ecriture e, piece p');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' where e.id_piece=p.id ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                      DMTmTVA.QuTVAEdition.SQL.Add(' group by p."date",p.Reference,p.compte,p.libelle ');
                                      DMTmTVA.QuTVAEdition.Open;

                                      DMTmTVA.QuTotalG1.SQL.Clear;
                                      DMTmTVA.QuTotalG1.SQL.Add('select ');
                                      DMTmTVA.QuTotalG1.SQL.Add('-(sum(e.debitsaisie)-sum(e.creditsaisie))+(sum((e.debitsaisie*tvataux)/100)-sum((e.creditsaisie*tvataux)/100)) ttc,');
                                      DMTmTVA.QuTotalG1.SQL.Add('-sum(e.debitsaisie)+sum(e.creditsaisie) ht,');
                                      DMTmTVA.QuTotalG1.SQL.Add('-sum((e.debitsaisie*tvataux)/100)+sum((e.creditsaisie*tvataux)/100) tva');
                                      DMTmTVA.QuTotalG1.SQL.Add('from ecriture e, piece p');
                                      DMTmTVA.QuTotalG1.SQL.Add(' where e.id_piece=p.id ');
                                      DMTmTVA.QuTotalG1.SQL.Add(' and p."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+''' ');
                                      DMTmTVA.QuTotalG1.SQL.Add(' and e.tvacode='''+DMTmTVA.QuListeJournal.FindField('TvaCode').AsString+''' and typeligne=''H'' ');
                                      DMTmTVA.QuTotalG1.Open;

                                      if DMTmTVA.QuTVAEdition.Fields[0].AsString<>'' then begin
//                                          EditTVA(Chemin,NomFich,DMTmTVA.QuTVAEdition,DMTmTVA.QuTotalG1,DMTmTVA.QuListeJournal.FindField('Libelle').AsString+' déductibles',DateToStr(periode.DateDeb),DateToStr(periode.DateFin),true,Site);
//                                          EditTVA(Chemin,NomFich,DMTmTVA.QuTVAEdition,DMTmTVA.QuTotalG1,DMTmTVA.QuListeJournal.FindField('Libelle').AsString+' déclarables',DateToStr(periode.DateDeb),DateToStr(periode.DateFin),true,Site);
                                      end;
                                  end;

                                  DMTmTVA.QuListeJournal.Next;
                              end;

//                              ToutTVAFin(Chemin,NomFich);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
          C_EditionWeb: Begin
                            Site.lien := false;
                            //EditPlusValueComptable(Chemin,NomFich,DataModuleImmos.QuImmosEdition,DataModuleImmos.QuTotalG1,DataModuleImmos.QuTotalG2,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
      end;
      Initialise_TStringlist(ListeClasseAchat);
      Initialise_TStringlist(ListeClasseVente);
      Initialise_TStringlist(ListeClasseNonImposable);
      DMTmTVA.QuListeJournal.Close;
      DMTmTVA.QuTotalG1.Close;
      DMTmTVA.QuTVAEdition.Close;
  end;
End;

Function AffichInfoDeclarationTVA(Requete:String;Affiche:boolean):Boolean;
var
i:integer;
Begin
if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);
if DMTmTVA.QuDec_Tva_VisuListe.Active then DMTmTVA.QuDec_Tva_VisuListe.Close;
DMTmTVA.QuDec_Tva_VisuListe.SQL.Clear;
DMTmTVA.QuDec_Tva_VisuListe.SQL.Add(Requete);

if affiche then
  begin
      if VisuListe = nil then VisuListe:=TVisuListe.Create(Application.MainForm);
      VisuListe.GrDBVisu.DefaultDrawing:=False;
      VisuListe.RxLabTitre.Caption:='Totaux par Code TVA';
      VisuListe.PaTitrePetit.Caption:='Listes par Code TVA';
      DMTmTVA.QuDec_Tva_VisuListe.open;
      DMTmTVA.QuDec_Tva_VisuListe.first;
      while not DMTmTVA.QuDec_Tva_VisuListe.eof do
       begin
         DMTmTVA.QuDec_Tva_VisuListe.findfield('TottvaMontantDebit').ascurrency;
         DMTmTVA.QuDec_Tva_VisuListe.findfield('TottvaMontantCredit').ascurrency;
         DMTmTVA.QuDec_Tva_VisuListe.next;
       end;
       DMTmTVA.QuDec_Tva_VisuListe.close;
      //Librairie_Isa.
      GrDbGridInitColonne(VisuListe.GrDBVisu,DMTmTVA.DaQuDec_Tva_VisuListe,DMTmTVA.QuDec_Tva_VisuListe,
                         ['Code TVA','Libellé','Montant Total Débit','Montant Total Crédit','En Attente'],
                         ['TvaCode','Libelle','TottvaMontantDebit','TottvaMontantCredit','En_Attente']
                         ,E.FormatMonnaie,E.EditFormat);
      visuliste.PaGrille.OnResize:=DMTmTVA.PaGrilleResizePour_AffichInfoDeclarationTVA;
      visuliste.BtnDetail.OnClick:=DMTmTVA.BtnDetailClick;
      VisuListe.Show;
  end;
End;


Function CalculDeclarationTva(DateDeb,DateFin:TDate;avecControle:boolean):Boolean;
var
Debut,Fin:TTime;
begin
  try//finally
      Try//except
//      Debut:=Time;
//showmessage('rentre dans calcul');
      result:=true;
      if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);
      DMTmTVA.QuDec_Tva.Close;
      DMTmTVA.QuSumParCode_Dec_Tva.close;

      DMBalance.TaBalance.Refresh;
      DMEcritures.TaEcriture.Refresh;
      DMPieces.TaPiece.Refresh;
      DMTmTVA.TaH_TVA.Refresh;
      defiltrageDataset(DMRech.TaH_TVARech);
      DMRech.TaH_TVARech.Refresh;
      DMTmTVA.TaDec_Tva.Refresh;
      if avecControle then ReinitialisationH_Tva_AvantControle;
      //permet de corriger les écarts de tva causés par les arrondis
      Debut:=Time;
      if avecControle then
        if ModificationTableH_TVA(true,false,false).retour=false then abort;
      Fin:=Time;
      AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'CorrectionTVA.txt','Debut : '+TimeToStr(Debut)
      +' - Fin : '+TimeToStr(Fin));
      //permet de corriger les écarts de tva causés par les arrondis
      PatienterAffich;
      Debut:=Time;
      if ((ControleTVASurType(false,false).retour=false)and(avecControle)) then
        begin
          if CorrectionTVASurTypeD(false).retour=false then abort;
        end;
      PatienterFermer;
      PatienterAffich;
      DeclarationTVATypeD(DateDeb,DateFin);
      DeclarationTVATypeE(DateDeb,DateFin);
      DeclarationTVATypeOD(DateDeb,DateFin);
      DeclarationTVATypeRegulation(DateDeb,DateFin);

      if ((DateFin>=e.DatExoDebut)and(avecControle)) then
       begin
        if ControleTVAEnAttente(nil,DateDeb,DateFin,false,false,false,true).retour=false then
           ControleTVAEnAttente(nil,DateDeb,DateFin,false,false,true,false);
       end
      else
        if avecControle then
          DeleteFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'ControleTvaEnAttente.txt');
      if DMTmTVA.QuDec_Tva_VisuListe.Active then DMTmTVA.QuDec_Tva_VisuListe.refresh else DMTmTVA.QuDec_Tva_VisuListe.Close;
      DMTmTVA.QuDec_Tva_VisuListe.SQL.Clear;
      DMTmTVA.QuDec_Tva_VisuListe.SQL.Add(RqDec_Tva_SommeTvaParCode_1);
      DMTmTVA.QuDec_Tva_VisuListe.Open;
      except
        result:=false;
        abort;
      end;
  finally
  PatienterFermer;
      Fin:=Time;
      AjouterFichierTexte(IncludeTrailingPathDelimiter(e.RepertoireProgram)+'CorrectionTVA.txt','Debut : '+TimeToStr(Debut)
      +' - Fin : '+TimeToStr(Fin));
//     Fin:=Time;
//     showmessage('Debut : '+timetostr(debut)+ '- Fin : '+timetostr(fin));
  end;
End;

Function DeclarationTVATypeD(DateDeb,DateFin:TDate):Boolean;
var
Tva_Attente:boolean;
id:integer;
ExceptLGR_:TExceptLGR;
//MessageLGR:TMessageLGR;
Accept:boolean;
Begin
try//finally
   try//except
   try
   if not DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(DateDeb,DateFin,false).retour then
   except
     // pour ne pas perpétuer l'exception
   end;
   if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);

     DMTmTVA.QuParcoursEcritureTypeD.Close;
     DMTmTVA.QuParcoursEcritureTypeD.ParamByName('DAteFin').AsDate:=DateFin;
     DMTmTVA.QuParcoursEcritureTypeD.Open ;
     DMTmTVA.QuParcoursEcritureTypeD.first;

      while not(DMTmTVA.QuParcoursEcritureTypeD.eof) do
        Begin // Remplissage Ta_Dec

          Accept := true;
          if DMTmTVA.QuVerifAcceptTva.Locate('ID_Ecriture',DMTmTVA.QuParcoursEcritureTypeD.FindField('Id').AsInteger,[]) then
            accept:=((DMTmTVA.QuVerifAcceptTvamontanttva.AsCurrency<DMTmTVA.QuVerifAcceptTvamontant_tva.AsCurrency)and(DMTmTVA.QuVerifAcceptTvaPartDeclaree.AsFloat < 1.00));
            if not accept then
              accept := not DMTmTVA.QueryTvaDeclare.Locate('id_ecriture',DMTmTVA.QuParcoursEcritureTypeD.FindField('Id').AsInteger,[]);
        if accept then
          begin
//          if (DMTmTVA.QuParcoursEcritureTypeD.FindField('Id').AsInteger=50001583) then
//            ShowMessage('accepté');
          Tva_Attente:=false;
                 begin//s'il y a de la tva à déclarer
                 id:=DMTmTVA.TaDec_Tva.RecordCount+1;
                 DMTmTVA.TaDec_Tva.AppendRecord([id,
                       DMTmTVA.QuParcoursEcritureTypeD.FindField('Id_Piece').AsInteger,
                       DMTmTVA.QuParcoursEcritureTypeD.FindField('Id').AsInteger,
                       DMTmTVA.QuParcoursEcritureTypeD.FindField('TvaCode').AsString,
                       'D',
                       DMTmTVA.QuParcoursEcritureTypeD.FindField('TvaDateCalc').AsDateTime,
                       arrondi(DMTmTVA.QuParcoursEcritureTypeDTvaDebit.ascurrency,2),
                       arrondi(DMTmTVA.QuParcoursEcritureTypeDTvaCredit.ascurrency,2),
      //                 DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.ascurrency,
      //                 DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.ascurrency,
                       Tva_Attente,1]);
                 DMTmTVA.TaDec_Tva.FlushBuffers;
                 end;//fin s'il y a de la tva à déclarer
             end;
           DMTmTVA.QuParcoursEcritureTypeD.Next;

        End;

     DMTmTVA.QuParcoursEcritureTypeD_EnAttente.Close;
     DMTmTVA.QuParcoursEcritureTypeD_EnAttente.ParamByName('DAteFin').AsDate:=DateFin;
     DMTmTVA.QuParcoursEcritureTypeD_EnAttente.Open;
     DMTmTVA.QuParcoursEcritureTypeD_EnAttente.first;

      while not(DMTmTVA.QuParcoursEcritureTypeD_EnAttente.eof) do
        Begin // Remplissage Ta_Dec

        Tva_Attente:=true;
//        if DateDsIntervale(DateDeb,DMTmTVA.QuParcoursEcritureTypeD_EnAttente.FindField('TvaDate').AsDateTime,datefin,MessageLGR) then
          Accept := true;
          if DMTmTVA.QuVerifAcceptTva.Locate('ID_Ecriture',DMTmTVA.QuParcoursEcritureTypeD_EnAttente.FindField('Id').AsInteger,[]) then
            accept:=((DMTmTVA.QuVerifAcceptTvamontanttva.AsCurrency<DMTmTVA.QuVerifAcceptTvamontant_tva.AsCurrency)and(DMTmTVA.QuVerifAcceptTvaPartDeclaree.AsFloat < 1.00));
            if not accept then
              accept := not DMTmTVA.QueryTvaDeclare.Locate('id_ecriture',DMTmTVA.QuParcoursEcritureTypeD_EnAttente.FindField('Id').AsInteger,[]);
            if accept then
              begin
                   begin//s'il y a de la tva à déclarer
                   id:=DMTmTVA.TaDec_Tva.RecordCount+1;
                   DMTmTVA.TaDec_Tva.AppendRecord([id,
                         DMTmTVA.QuParcoursEcritureTypeD_EnAttente.FindField('Id_Piece').AsInteger,
                         DMTmTVA.QuParcoursEcritureTypeD_EnAttente.FindField('Id').AsInteger,
                         DMTmTVA.QuParcoursEcritureTypeD_EnAttente.FindField('TvaCode').AsString,
                         'D',
                         DMTmTVA.QuParcoursEcritureTypeD_EnAttente.FindField('TvaDateCalc').AsDateTime,
                         arrondi(DMTmTVA.QuParcoursEcritureTypeD_EnAttenteTvaDebit.ascurrency,2),
                         arrondi(DMTmTVA.QuParcoursEcritureTypeD_EnAttenteTvaCredit.ascurrency,2),
        //                 DMTmTVA.QuParcoursEcritureTypeD_EnAttenteTvaDebit.ascurrency,
        //                 DMTmTVA.QuParcoursEcritureTypeD_EnAttenteTvaCredit.ascurrency,
                         Tva_Attente,1]);
                   DMTmTVA.TaDec_Tva.FlushBuffers;
                   end;//fin s'il y a de la tva à déclarer
               end;
           DMTmTVA.QuParcoursEcritureTypeD_EnAttente.Next;

        End;
   except
     abort;
   end;//fin du try except
finally
//DMTmTVA.QuDec_Tva.close;
DMTmTVA.PrepareQuDec_tva(DateFin);
DMTmTVA.QuDec_Tva.open;
end;//fin du try finally
End;

Function DeclarationTVATypeE(DateDeb,DateFin:TDate):Boolean;
var
id:integer;
ExceptLGR_:TExceptLGR;
En_Attente:boolean;
Begin
try//finally
   try//except
//ChampTableVersListeEx(['Id_Piece','TvaCode','TvaDate','Reference','tvaMontantDebit','TvaMontantCredit'],DMTmTVA.tah_tva,';').SaveToFile('C:\Js\tah_tva_AvantCalcul.txt');

   try
   if not DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(DateDeb,DateFin,false).retour then
   except
     // pour ne pas perpétuer l'exception
   end;
   if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);
      DMTmTVA.QuSumPointageDansPeriodeDebit.ParamByName('FinPeriode').AsDateTime:=DateFin;
      DMTmTVA.QuSumPointageDansPeriodeCredit.ParamByName('FinPeriode').AsDateTime:=DateFin;
      //on doit le fermer pour qu'à la récupération du lookup elle soit réouverte et donc raffraîchit
      DMTmTVA.QuSumPartDeclaree.Close;
      DMTmTVA.QuSumPartDeclaree.open;
      ////
      DMTmTVA.QuResteDC_Tva.close;
      DMTmTVA.QuResteDC_Tva.open;

      DMTmTVA.QuMaitre_ParcoursEcritureTypeE.Close;
      DMTmTVA.QuMaitre_ParcoursEcritureTypeE.ParamByName('DAteFin').AsDate:=DateFin;
      if DMTmTVA.QuMaitre_ParcoursEcritureTypeE.active then DMTmTVA.QuMaitre_ParcoursEcritureTypeE.Refresh else
        DMTmTVA.QuMaitre_ParcoursEcritureTypeE.Open;
      DMTmTVA.QuMaitre_ParcoursEcritureTypeE.first;
//
      while not(DMTmTVA.QuMaitre_ParcoursEcritureTypeE.eof) do
        Begin // Remplissage Ta_Dec

        //if(DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('Id_Piece').AsInteger=120001761)then showmessage('id : 120001761');
         En_Attente:=(((((Infos_TInfosTvaCode(DMRech.TaTvaCodeRech,'tvaCode',[DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('TvaCode').AsString]).Classe[1] in ['E','L','N'])
         and(not(VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeEProrataEnAttente).VideOUZero))))
         or(((not(VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeEProrataEnAttente).VideOUZero))and((not(VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit).VideOUZero))
         or(not(VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit).VideOUZero)))))));
         if ((abs(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.ascurrency-DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.ascurrency)<e.ParamArrondisTVA)
         and(DMTmTVA.QuMaitre_ParcoursEcritureTypeEMontantPointe_Tiers.AsCurrency<>DMTmTVA.QuMaitre_ParcoursEcritureTypeEMontantTiers.AsCurrency)
         and(not(((VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit).VideOUZero)and(VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit).VideOUZero))))) then
           En_Attente:=not En_Attente;
          if (((((Infos_TInfosTvaCode(DMRech.TaTvaCodeRech,'tvaCode',[DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('TvaCode').AsString]).Classe[1] in ['E','L','N'])and(not(VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeEProrataEnAttente).VideOUZero))))or(((not(VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeEProrataEnAttente).VideOUZero))and((DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.AsCurrency>=0.01)or(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.AsCurrency>=0.01)))))) then
           begin//s'il y a de la tva en attente
             id:=DMTmTVA.TaDec_Tva.RecordCount+1;
             DMTmTVA.TaDec_Tva.AppendRecord([id,
                   DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('Id_Piece').AsInteger,
                   DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('Id').AsInteger,
                   DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('TvaCode').AsString,
                   'E',
                   DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('TvaDate').AsDateTime,
                   arrondi(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.ascurrency,2),
                   arrondi(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.ascurrency,2),
//                   DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.ascurrency,
//                   DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.ascurrency,
                   En_Attente,DMTmTVA.QuMaitre_ParcoursEcritureTypeEProrataEnAttente.asfloat]);
             DMTmTVA.TaDec_Tva.FlushBuffers;
           end;//fin s'il y a de la tva en attente
         if En_attente then
           begin
           En_Attente:=VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeENouveauPointage).VideOUZero;
           if ((abs(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.ascurrency-DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.ascurrency)<e.ParamArrondisTVA)and(not(((VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit).VideOUZero)and(VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit).VideOUZero))))) then
             En_Attente:=not En_Attente;
           end;
          if not VerifFNumeric(DMTmTVA.QuMaitre_ParcoursEcritureTypeENouveauPointage).VideOUZero then
           begin//s'il y a de la tva à déclarer
           id:=DMTmTVA.TaDec_Tva.RecordCount+1;
           DMTmTVA.TaDec_Tva.AppendRecord([id,
                 DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('Id_Piece').AsInteger,
                 DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('Id').AsInteger,
                 DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('TvaCode').AsString,
                 'E',
                 DMTmTVA.QuMaitre_ParcoursEcritureTypeE.FindField('TvaDate').AsDateTime,
                 arrondi(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.ascurrency,2),
                 arrondi(DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.ascurrency,2),
//                 DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.ascurrency,
//                 DMTmTVA.QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.ascurrency,
                 En_Attente,DMTmTVA.QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.asfloat]);
           DMTmTVA.TaDec_Tva.FlushBuffers;
           end;//fin s'il y a de la tva à déclarer
           DMTmTVA.QuMaitre_ParcoursEcritureTypeE.Next;
        End;
   except
     abort;
   end;//fin du try except
finally
//DMTmTVA.QuDec_Tva.close;
DMTmTVA.PrepareQuDec_tva(DateFin);
DMTmTVA.QuDec_Tva.open;
end;//fin du try finally
End;



procedure TDMTmTVA.DMTmTVACreate(Sender: TObject);
begin
  ListeId_PointageDejaTraiter:=TStringList.Create;
  ListeFilterRecordEdition:=TStringList.Create;
  ListeIdLigneDecTvaPourVerrouillage:=TStringList.Create;
  ListeReports:=tlist.Create;
  //TaPointageParcours.OnFilterRecord:=nil;
  OuvrirTouteTable('',TControl(self));
  liste:=TStringlist.Create;
end;

procedure TDMTmTVA.DMTmTVADestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
  Initialise_TStringlist(ListeId_PointageDejaTraiter);
  Initialise_TStringlist(ListeFilterRecordEdition);
  Initialise_TStringlist(liste);
  Initialise_TStringlist(ListeIdLigneDecTvaPourVerrouillage);
  Initialise_Tlist(ListeReports);
  DMTmTVA:=nil;
end;


function TDMTmTVA.VAliderDeclarationTVA(DateDeb,DateFin:TDatetime;GenerPieceTVA:boolean;AffichParamTVA:TForceAffichage):TExceptLGR;
var
Id,ID_Declaration:Integer;
totauxbalance:ttotauxbalance;
Param:TSolde_A_Traiter;
ListeADeclare:Tlist;//PInfos_Piece
FilterTemp,Ref,Marque:string;
i:integer;
filtre:Tfiltre;
ForceAffiche:TForceAffichage;
SoldeArrondi,Solde_Fin:currency;
ListeTmpDeductible,ListeTmpVente,ListeTmp2,ListeCodeTVA:TStringList;
StrTmp:String;
DeduiteAReverserTmp:TInfos_Piece;
AcompteVerseTmp:TInfos_Piece;
Begin
try//finally
    ListeADeclare:=tlist.Create;
    ListeADeclare.clear;

    ListeCodeTVA:=TStringList.Create;
    ListeCodeTVA.Clear;
    ListeCodeTVA:=ChampTableVersListeEx(['TvaCode','Libelle'],DMREch.TaTvaCodeRech,' - ',False);

    ListeTmpVente:=TStringList.Create;
    ListeTmpVente.Clear;
    ListeTmpVente :=DM_C_ListeCTVAVente;

    ListeTmpDeductible:=TStringList.Create;
    ListeTmpDeductible.Clear;
    ListeTmpDeductible :=DM_C_ListeCTVAAchat;

    ListeTmp2:=TStringList.Create;
    ListeTmp2.Clear;
    ListeTmp2 :=DM_C_ListeCTVAImposeDeduite;

Initialise_ExceptLGR(result);
filtre:=DMTmTVA.RecupCodeTva_A_Exclure(nil);
Soldearrondi_Deductible:=0;
Soldearrondi_Imposable:=0;
FilterTemp:=QuDec_Tva.Filter;
result.retour:=true;
doublerLigne:='';
if not TaDec_Tva.Active then TaDec_Tva.Open
 else TaDec_Tva.Refresh;
if not TaH_TVA.Active then TaH_TVA.Open
 else TaH_TVA.Refresh;

if filtre.filtrer then
  FiltrageDataSet(QuDec_Tva,'En_Attente = faux and not ('+Filtre.filtre+') ')
else
  FiltrageDataSet(QuDec_Tva,'En_Attente = faux');

  try//except
    
    //Param.Total.SoldeReport:=-(TotauxReport.Totaux.SoldeFin); //isa le 16-05-03
    Param.Total.SoldeReport:=TotauxReport.Totaux.SoldeFin;
    Param.Total.SoldeDebitCreditReport:=TotauxReport.Totaux.SoldeDebitCreditFin;
    try
    SoldeArrondi:=0;
/////////
    DMTmTVA.QuDec_Tva_VisuListe.SQL.Clear;
    DMTmTVA.QuDec_Tva_VisuListe.SQL.Add(RqDec_Tva_SommeTvaParCode_1);
    DMTmTVA.QuDec_Tva_VisuListe.Open;


    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
         if ListeTmp2.IndexOf(StrTmp) = -1 then
           begin
             if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
               Begin
                 if ListeTmpVente.IndexOf(StrTmp)<>-1 then
                    Soldearrondi_Imposable:=Soldearrondi_Imposable+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency-DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2))
                 else
                    if ListeTmpDeductible.IndexOf(StrTmp)<>-1 then
                    Soldearrondi_Deductible:=Soldearrondi_Deductible+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency-DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
               End;
           end;
      end;
    //Soldearrondi_Deductible
////////
    //// compte 44552 tva déduite à reverser   je l'ajoute
//      totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut-1,DateFin,DM_C_CompteTVADeduiteAReverser);
      totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,DateFin,DM_C_CompteTVADeduiteAReverser);
      if totauxbalance.SoldeFin <>0 then
        Begin
           if totauxbalance.SoldeDebitCreditFin then
             begin
               Soldearrondi_Imposable:=Soldearrondi_Imposable-(totauxbalance.SoldeFin);
               DeduiteAReverserTmp.Total.Solde:=totauxbalance.SoldeFin;
               DeduiteAReverserTmp.SensSolde:=1;
             end
           else
             begin
               Soldearrondi_Imposable:=Soldearrondi_Imposable+(totauxbalance.SoldeFin);
               DeduiteAReverserTmp.Total.Solde:=-totauxbalance.SoldeFin;
               DeduiteAReverserTmp.SensSolde:=-1;
             end;
           DeduiteAReverserTmp.Retour:=true;
           DeduiteAReverserTmp.Compte:= DM_C_CompteTVADeduiteAReverser;
        End;
        SoldeArrondi:=Soldearrondi_Imposable-Soldearrondi_Deductible;
    ///  //compte 44581 acompte versé je le soustrait
//         totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut-1,DateFin,DM_C_CompteTVAAcompteVerse);
         totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,DateFin,DM_C_CompteTVAAcompteVerse);
         if totauxbalance.SoldeFin<>0 then
         Begin
          if totauxbalance.SoldeDebitCreditFin then
            begin
              SoldeArrondi:=SoldeArrondi-(totauxbalance.SoldeFin );
              AcompteVerseTmp.Total.Solde:=totauxbalance.SoldeFin;
              AcompteVerseTmp.SensSolde:=1;
            end
          else
            begin
              SoldeArrondi:=SoldeArrondi+(totauxbalance.SoldeFin );
              AcompteVerseTmp.Total.Solde:=-totauxbalance.SoldeFin;
              AcompteVerseTmp.SensSolde:=-1;
            end;
          AcompteVerseTmp.Retour:=true;
          AcompteVerseTmp.Compte:= DM_C_CompteTVAAcompteVerse;
         End;


    ///
Param.Total.SoldeBase:=SoldeArrondi;
    finally
      DeFiltrageDataSet(DMTmTVA.QuDec_Tva);
    end;

    if ((Soldearrondi_Imposable=0)and(Soldearrondi_Deductible=0)) then
      Begin
        showmessage('Le calcul fait apparaître un solde nul, il n''y a pas de tva à déclarée pour cette période');
        //abort;
      End;

    Param.Total.SoldeDebitCreditBase:=Param.Total.SoldeBase<0;

    if Param.Total.SoldeDebitCreditReport then//débiteur
      Param.Total.SoldeFin:=-Param.Total.SoldeReport+Param.Total.SoldeBase
    else //créditeur
      Param.Total.SoldeFin:=Param.Total.SoldeReport+Param.Total.SoldeBase;

//    if Param.Total.SoldeDebitCreditReport then//débiteur
//      Param.Total.SoldeFin:=-Param.Total.SoldeReport+Soldearrondi_Imposable-Soldearrondi_Deductible+AcompteVerseTmp.Total.Solde
//    else //créditeur
//      Param.Total.SoldeFin:=Param.Total.SoldeReport+Soldearrondi_Imposable-Soldearrondi_Deductible+AcompteVerseTmp.Total.Solde;;

    Param.Total.SoldeDebitCreditFin:=Param.Total.SoldeFin<0;

    Param.ATraiter:=true;
    Param.GestionAffichForm.Affich := AffichParamTVA.Affiche;

    ForceAffiche:=AffichParamTVA;
    begin
        try
          InfosAvantValidation:=AffichInfoComplementairesTVA_AvantValidation(Param,ForceAffiche);
        except
          abort;
        end;
    if ((InfosAvantValidation=nil)and(((Soldearrondi_Imposable=0)and(Soldearrondi_Deductible=0)))) then abort;
      if InfosAvantValidation<>nil then
         begin
         InfosAvantValidation.AcompteVerse:=AcompteVerseTmp;
         InfosAvantValidation.DeduiteAReverser:=DeduiteAReverserTmp;
         //préparer les totaux (report inversé+solde) des lignes à créer dans pièce de tva
          for i:=0 to ListeReports.count-1 do
            Begin
              if PSolde_A_Traiter(ListeReports.Items[i])^.ATraiter then
                Begin
                  if PSolde_A_Traiter(ListeReports.Items[i])^.Compte=InfosAvantValidation.APayer.Compte then
                    Begin
                    //dans tous les cas
                    InfosAvantValidation.APayer.Retour:=true;
                    //if TotauxReport.Totaux.SoldeDebitCreditReport then//si débiteur
                    if PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
                      Solde_Fin:=InfosAvantValidation.APayer.Total.Solde+(PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin)
                    else
                      Solde_Fin:=InfosAvantValidation.APayer.Total.Solde-PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
                    if ((Solde_Fin<>0)or(PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin=0)) then
                      InfosAvantValidation.APayer.Total.Solde:=Solde_Fin
                    else
                      begin
                        InfosAvantValidation.APayer.Total.Solde:=PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
                        doublerLigne:=InfosAvantValidation.APayer.Compte;
                      end;
                    if InfosAvantValidation.APayer.Total.Solde<0 then
                      InfosAvantValidation.APayer.SensSolde:=-1;
                    if InfosAvantValidation.APayer.Total.Solde>0 then
                      InfosAvantValidation.APayer.SensSolde:=1;
                    if InfosAvantValidation.APayer.Total.Solde=0 then
                      InfosAvantValidation.APayer.SensSolde:=0;
                    End;
                  if PSolde_A_Traiter(ListeReports.Items[i])^.Compte=InfosAvantValidation.Report.Compte then
                    Begin
                      InfosAvantValidation.Report.Retour:=true;
                      //si je dois de la tva, calcul au débit
                      if PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
                        begin//si report au débit
                              Solde_Fin:=InfosAvantValidation.Report.Total.Solde+PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
     //                         InfosAvantValidation.Report.Total.Solde:=InfosAvantValidation.Report.Total.Solde+PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
                        end//fin si report au débit
                      else
                        begin//si report au Crédit
                             Solde_Fin:=-InfosAvantValidation.Report.Total.Solde-PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
     //                         InfosAvantValidation.Report.Total.Solde:=-InfosAvantValidation.Report.Total.Solde-PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
                        end;//fin si report au Crédit
                    if ((Solde_Fin<>0)or(PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin=0)) then
                      InfosAvantValidation.Report.Total.Solde:=Solde_Fin
                    else
                      begin
                        InfosAvantValidation.Report.Total.Solde:=PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
                        doublerLigne:=InfosAvantValidation.Report.Compte;
                      end;
                     if InfosAvantValidation.Report.Total.Solde<0 then
                      InfosAvantValidation.Report.SensSolde:=-1;
                    if InfosAvantValidation.Report.Total.Solde>0 then
                      InfosAvantValidation.Report.SensSolde:=1;
                    if InfosAvantValidation.Report.Total.Solde=0 then
                      InfosAvantValidation.Report.SensSolde:=0;
                    End;
                  if PSolde_A_Traiter(ListeReports.Items[i])^.Compte=InfosAvantValidation.Remboursement.Compte then
                    Begin
                      InfosAvantValidation.Remboursement.Retour:=true;
                      //si je dois de la tva, calcul au débit
                      if PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
                        begin//si report au débit
                             Solde_Fin:=InfosAvantValidation.Remboursement.Total.Solde+PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
     //                        InfosAvantValidation.Remboursement.Total.Solde:=InfosAvantValidation.Remboursement.Total.Solde+PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
                        end//fin si report au débit
                      else
                        begin//si report au crédit
                             Solde_Fin:=-InfosAvantValidation.Remboursement.Total.Solde+PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
     //                        InfosAvantValidation.Remboursement.Total.Solde:=-InfosAvantValidation.Remboursement.Total.Solde+PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
                        end;//fin si report au crédit
                    if ((Solde_Fin<>0)or(PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin=0)) then
                      InfosAvantValidation.Remboursement.Total.Solde:=Solde_Fin
                    else
                      begin
                        InfosAvantValidation.Remboursement.Total.Solde:=PSolde_A_Traiter(ListeReports.Items[i])^.Total.SoldeFin;
                        doublerLigne:=InfosAvantValidation.Remboursement.Compte;
                      end;
                    if InfosAvantValidation.Remboursement.Total.Solde<0 then
                      InfosAvantValidation.Remboursement.SensSolde:=-1;
                    if InfosAvantValidation.Remboursement.Total.Solde>0 then
                      InfosAvantValidation.Remboursement.SensSolde:=1;
                    if InfosAvantValidation.Remboursement.Total.Solde=0 then
                      InfosAvantValidation.Remboursement.SensSolde:=0;
                    End;
                End;
            End;
         end
       else
//       abort;
   end;
    //
  if GenerPieceTVA then
   begin
    QuMaxFin_Periode.Close;
    QuMaxFin_Periode.Open;
    // Controle si on peut passer la pièce de tva par rapport aux diverses dates
    //**************************************************************************
    if ((((QuMaxFin_Periode.FindField('Fin_Periode').AsDateTime+1) <> E.DateDebutDeclarationTVA))and(QuMaxFin_Periode.FindField('Fin_Periode').AsDateTime<>0)) then
      begin
       MessageDlg('La date de début de votre déclaration n"est pas cohérente, la pièce TVA ne peut pas être générée !',mtWarning,[mbOK],0);
        abort;
      end;
    if (E.DateFinDeclarationTVA > E.DatExoFin) then
      begin
       MessageDlg('La date de fin de votre déclaration n"est pas cohérente, la pièce TVA ne peut pas être générée !',mtWarning,[mbOK],0);
        abort;
      end;
    //**************************************************************************
    TableGereStartTransaction(TaH_TVA);
    //créer la pièce de tva
      //créer l'od de déclaration Tva
      ///////////////////////////////
    try
    if not GenererPieceTva(ref,InfosAvantValidation) then
      raise ExceptLGR.Create('Problème lors de l"enregistrement de la déclaration TVA, la pièce de déclaration va être supprimée.',1,true,mtError,result);
    except
      if not empty(ref) then
        begin
          DMPieces.SuppressionOD(ref);
          TableGerecommit(dmpieces.TaPiece);
          TableGerecommit(DMBalance.TaBalance);
        end;
      ref:='';
      abort;
    end;
    //fin création pièce tva


    //verrouille la déclaration précédente (qui pour le moment est la dernière)
    QuMaxDebut_Periode.Close;
    QuMaxDebut_Periode.Open;
    QuMaxFin_Periode.Close;
    QuMaxFin_Periode.Open;

        QuSupprDerniereDeclaration.Close;
        QuSupprDerniereDeclaration.sql.Clear;
        QuSupprDerniereDeclaration.sql.Add('Update h_tva set deverrouillable=false where Debut_Periode=:Debut and Fin_Periode=:Fin');
        QuSupprDerniereDeclaration.ParamByName('Debut').AsDateTime:=QuMaxDebut_Periode.findfield('Debut_Periode').AsDateTime;
        QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime;
        QuSupprDerniereDeclaration.ExecSQL;

    //fin du verrouillage de la précédente
//    ID_Declaration:=MaxId_Query(TaH_TVA,'ID_Declaration');
    ID_Declaration:=MaxId_Query(TaH_PieceTVA,'ID_Declaration');//il faut travailler sur cette table pour récupérer
    //le nouvel id car la table H_Tva n'est pas toujours alimentée, notamment quand il n'y a pas de tva à déclaré
    //mais que des reliquats de tva du ou à payer.

    { isa  le  04/08/04 je le met en premier au cas où il y aurait un plantage, c'est à partir de cette table que l'on
    vérifie l'existance d'une déclaration et donc la possibilité de suppression si nécessaire}
    //alimenter l'historique des pièces de Tva
           id:=MaxId_Query(TaH_PieceTVA,'ID');
           TaH_PieceTVA.AppendRecord([id,
           ID_Declaration,Ref,
           DAteDeb,DateFin,true,
           true,false,false,'OK']);
           TaH_PieceTVA.FlushBuffers;
    // fin de l'alimentation de l'historique des pièces de TVA

//    // alimentation de l'historique des lignes déclarées
//    TaDec_Tva.First;
//    while not TaDec_Tva.EOF do
//      begin//début du while not TaDec_Tva.EOF
//        begin//si pas tva en attente
//           id:=MaxId_Query(TaH_TVA,'ID');
//           TaH_TVA.AppendRecord([id,
//           TaDec_Tva.FindField('ID_Ligne').AsInteger,
//           TaDec_Tva.FindField('ID_Piece').AsInteger,
//           ID_Declaration,
//           TaDec_Tva.FindField('Part_declaration').asfloat,DAteDeb,DateFin,true,
//           true,TaDec_Tva.FindField('En_Attente').asboolean,
//           TaDec_Tva.FindField('TvaDate').asdatetime,Ref,
//           abs(TaDec_Tva.FindField('TvaMontantDebit').ascurrency-TaDec_Tva.FindField('TvaMontantCredit').ascurrency),
//           abs(TaDec_Tva.FindField('TvaMontantDebit').ascurrency-TaDec_Tva.FindField('TvaMontantCredit').ascurrency)]);
//        end;//fin si pas tva en attente
//       TaDec_Tva.Next;
//      end;//fin du while not TaDec_Tva.EOF
    // alimentation de l'historique des lignes déclarées
    QuDec_Tva.First;
    Marque:='Ok';
    while not QuDec_Tva.EOF do
      begin//début du while not TaDec_Tva.EOF
        begin//si pas tva en attente
           if QuDec_Tva.FindField('ID_Ligne').AsInteger<>0 then
             begin// traitement lignes normales
                 id:=MaxId_Query(TaH_TVA,'ID');
                 TaH_TVA.AppendRecord([id,
                 QuDec_Tva.FindField('ID_Ligne').AsInteger,
                 QuDec_Tva.FindField('ID_Piece').AsInteger,
                 ID_Declaration,
                 QuDec_Tva.FindField('Part_declaration').asfloat,DAteDeb,DateFin,true,
                 true,QuDec_Tva.FindField('En_Attente').asboolean,
                 QuDec_Tva.FindField('TvaDate').asdatetime,Ref,
                 abs(QuDec_Tva.FindField('TvaMontantDebit').ascurrency-QuDec_Tva.FindField('TvaMontantCredit').ascurrency),
                 QuDec_Tva.FindField('HT_Declare').ascurrency,'',Marque]);
            Marque:='';
             end;//fin traitement lignes normales
        end;//fin si pas tva en attente
       QuDec_Tva.Next;
      end;//fin du while not TaDec_Tva.EOF
      TaH_TVA.FlushBuffers;
      //fin de l'alimentation de l'historique des lignes déclarées

      //traiter les lignes de compensation pour changer l'id déclaration (-2) avec le celui de la déclaration réélle à laquelle
      //ils appartiennent
       try
           FiltrageDataSet(TaH_TVA,'ID_declaration=-2');
           TaH_TVA.First;
           while not(TaH_TVA.eof)do
             Begin//taitement des lignes de régulation
                   TaH_TVA.edit;
                   TaH_TVA.findfield('ID_Declaration').AsInteger:=ID_Declaration;
                   TaH_TVA.findfield('Reference_OD').Asstring:=Ref;
                   TaH_TVA.findfield('En_attente').Asboolean:=false;
                   TaH_TVA.findfield('Date_Tva').asdatetime:=DateFin;
                   TableGerePost(TaH_TVA);
             end;//fin taitement des lignes de régulation

           FiltrageDataSet(TaH_TVA,'ID_declaration=-3');
           TaH_TVA.First;
           while not(TaH_TVA.eof)do
             Begin//taitement des lignes de régulation
                   TaH_TVA.edit;
                   TaH_TVA.findfield('ID_Declaration').AsInteger:=ID_Declaration;
                   TaH_TVA.findfield('Reference_OD').Asstring:=Ref;
                   TaH_TVA.findfield('En_attente').Asboolean:=false;
                   TaH_TVA.findfield('Date_Tva').asdatetime:=DateFin;
                   TableGerePost(TaH_TVA);
             end;//fin taitement des lignes de régulation
      except
        DeFiltrageDataSet(TaH_TVA);
        abort;
      end;
      TaH_TVA.FlushBuffers;
      // mise à jour de l'id déclaration de l'historique des reports
      FiltrageDataSet(Ta_H_Tva_Report,CreeFiltreOU('id_declaration',[inttostr(C_Id_Decl_Tmp)]));
      Ta_H_Tva_Report.First;
      while not(Ta_H_Tva_Report.recordcount=0)do
        Begin
         Ta_H_Tva_Report.edit;
         Ta_H_Tva_Report.FindField('id_declaration').AsInteger:=ID_Declaration;
         TableGerePost(Ta_H_Tva_Report);
        End;
//        QuMAJ_H_Tva_Report.close;
//        QuMAJ_H_Tva_Report.sql.Clear;
//        QuMAJ_H_Tva_Report.sql.add('Update H_Tva_Report set id_declaration =:newID where id_declaration=:OldID');
//        QuMAJ_H_Tva_Report.ParamByName('OldID').asinteger:=C_Id_Decl_Tmp;
//        QuMAJ_H_Tva_Report.ParamByName('newID').asinteger:=ID_Declaration;
//        QuMAJ_H_Tva_Report.ExecSQL;
      // mise à jour de l'id déclaration de l'historique des montants déclarés
      FiltrageDataSet(Ta_H_Tva_Fin,CreeFiltreOU('id_declaration',[inttostr(C_Id_Decl_Tmp)]));
      Ta_H_Tva_Fin.First;
      while not(Ta_H_Tva_Fin.recordcount=0)do
        Begin
         Ta_H_Tva_Fin.edit;
         Ta_H_Tva_Fin.FindField('id_declaration').AsInteger:=ID_Declaration;
         TableGerePost(Ta_H_Tva_Fin);
        End;

//        QuMAJ_H_Tva_Fin.close;
//        QuMAJ_H_Tva_Fin.sql.Clear;
//        QuMAJ_H_Tva_Fin.sql.add('update H_Tva_Fin set id_declaration=:newID where id_declaration=:OldID');
//        QuMAJ_H_Tva_Fin.ParamByName('OldID').asinteger:=C_Id_Decl_Tmp;
//        QuMAJ_H_Tva_Fin.ParamByName('newID').asinteger:=ID_Declaration;
//        QuMAJ_H_Tva_Fin.ExecSQL;

      //MAJ des dates debut et fin déclaration
      MAJ_DateDeclarationTVA(e.DateDebutDeclarationTVA,e.DateFinDeclarationTVA);
      TaH_TVA.FlushBuffers;
      TaH_TVA.Refresh;
      TableGereCommit(TaH_TVA);
      TableGereCommit(DMBalance.TaBalance);
      //initialiser les reports
      InitialiseTotauxBalance(TotauxReport.Totaux);
      TotauxReport.Retour:=true;
    end;
  except
    if not empty(ref) then
    begin
      showmessage('Problème lors de l"enregistrement de la déclaration TVA, la pièce de déclaration va être supprimée');
      Suppression_Derniere_Declaration_Tva_Deverrouillable(ref,true,false,true,false);
    end;
    TableGereRollBack(TaH_TVA);
    TableGereRollBack(DMBalance.TaBalance);
    if(TaH_TVA.state in [dsedit,dsinsert]) then
      TaH_TVA.Cancel;
    result.retour:=false;
  end;
finally
FiltrageDataSet(QuDec_Tva,FilterTemp);
deFiltrageDataSet(TaH_TVA);
DeFiltrageDataSet(Ta_H_Tva_Report);
DeFiltrageDataSet(Ta_H_Tva_Fin);


Initialise_TList(ListeADeclare);
Initialise_TStringlist(ListeTmp2);
Initialise_TStringlist(ListeCodeTVA);
Initialise_TStringlist(ListeTmpDeductible);
Initialise_TStringlist(ListeTmpVente);

//if ListeTmp2<>nil then ListeTmp2.Free;{ isa  le  29/07/04 }
//if ListeCodeTVA<>nil then ListeCodeTVA.Free;{ isa  le  29/07/04 }
if CorrectionDeclarationTVA(false).retour=false then
  abort;
if Type_version_execution=ct_distribution then
  begin
    if VerifCoherence_HTVA(false).retour=false then
        abort;
  end;
// DMcorrections.QuCorrectionInsert.Close;
// DMcorrections.QuCorrectionInsert.DatabaseName:=DM_C_NomAliasDossier;                                           //  Debut_Periode,Fin_Periode,
// DMcorrections.QuCorrectionInsert.SQL.Clear;
// DMcorrections.QuCorrectionInsert.SQL.add('delete from h_tva where id_declaration=-3');
// DMcorrections.QuCorrectionInsert.ExecSQL;
// DMcorrections.QuCorrectionInsert.Close;

end;//fin du try finally
End;


function Verif_SiDeclarationTvaAJour(var MessageTmp:Tmessages):TErreurSaisie;
var
PeriodeDecl:integer;
DerniereDeclarationExo:Tdatetime;
dateFinAnneeCivile:tdatetime;
anneeMoinsUn:integer;
begin
if DMTmTVA=nil then DMTmTVA:=TDMTmTVA.create(Application.MainForm);
//vérifier si la dernière déclaration TVA de l'exercice a été passée
  DMTmTVA.MAJ_DateDeclarationTVA(e.DateDebutDeclarationTVA,e.DateFinDeclarationTVA);
  result.Retour:=true;
  result.CodeErreur:=0;
//  if ((e.DateFinDeclarationTVA<e.DatExoFin)and(e.DatExoFin-e.DateFinDeclarationTVA<>10)) then
if ((dateinfos(e.DatExoFin).mois=12)and(dateinfos(e.DatExoFin).jour=31))then
   dateFinAnneeCivile:=e.DatExoFin
else
  begin
      anneeMoinsUn:=dateinfos(e.DatExoFin).an-1;
      dateFinAnneeCivile:=strtodate_lgr('31/12/'+inttostr(anneeMoinsUn),e.DatExoFin);
  end;
if e.DateDebutDeclarationTVA<=(dateFinAnneeCivile - 10) then
  Begin
       result.Retour:=false;
       result.CodeErreur:=1001;
  end;
if result.retour=false then
  begin
    MessageTmp.MessageErreur:='En considérant les déclarations passées par le programme, il apparaît que vous n''êtes pas à jour dans vos déclarations de TVA.'+RetourChariotDouble;
    MessageTmp.MessageQuestion:='Souhaitez-vous stopper la clôture afin de vérifier vos déclarations ?';
  end;
End;



//sert à stocker des écritures d'ouverture comportant de la TVA qui n'est plus exigible
procedure TDMTmTVA.GestionDeclarationAvantOuverture(Supp:boolean;IDEcriture,IDPiece:integer;Periode:Tdatetime);
var
messages:string;
Begin
 try
 if not supp then
   begin

   TaH_TVA.AppendRecord([MaxId_Query(TaH_TVA,'ID'),IDEcriture,IDPiece,0,1,Periode,Periode,true,false,false]);
   messages:='Problème rencontré lors de l''enregistrement de la Tva non exigible à l''ouverture.'
   end
 else
    Begin
      //repérer la ligne à supprimer
      if TaH_TVA.Locate('ID_Ecriture',IDEcriture,[]) then
        TableGereDelete(TaH_TVA);
      messages:='Problème rencontré lors de la suppression d''une part de Tva non exigible à l''ouverture.'
    End;
 except
   if not empty(messages)then
     showmessage(messages);
   TableGereRollBack(TaH_TVA);  
   abort;
 end;
End;


Procedure TDMTmTVA.TraitementCloture1(Sender:TObject);
Begin
 Main.Nouvelledclaration1Click(self);
End;

procedure TDMTmTVA.TaResteDC_Tva1CalcFields(DataSet: TDataSet);
begin
//  TaResteDC_TvaSoldeTiers.AsCurrency:=abs(TaResteDC_TvaCredit.AsCurrency-TaResteDC_TvaDebit.AsCurrency);
//  if not (VerifFNumeric(TaResteDC_TvaCredit).VideOUZero)then
//    TaResteDC_TvaSensSolde.AsBoolean:=true
//  else
//  if not VerifFNumeric(TaResteDC_TvaDebit).VideOUZero then
//    TaResteDC_TvaSensSolde.AsBoolean:=false;
//  //recupérer la date maxi de pointage hors période pour affichage correct des dates de tva
//  QuSumPointageDebit.close;
//  QuSumPointageDebit.ParamByName('ID_Ecriture').AsInteger:=TaResteDC_TvaID_Ecriture.AsInteger;
//  QuSumPointageDebit.open;
//  //recupérer la date maxi de pointage hors période pour affichage correct des dates de tva
//  QuSumPointageCredit.close;
//  QuSumPointageCredit.ParamByName('ID_Ecriture').AsInteger:=TaResteDC_TvaID_Ecriture.AsInteger;
//  QuSumPointageCredit.open;
//
//  //recupérer le montantPointé Jusqu'à période
//  QuSumPointageDansPeriodeDebit.close;
//  QuSumPointageDansPeriodeDebit.ParamByName('ID_Ecriture').AsInteger:=TaResteDC_TvaID_Ecriture.AsInteger;
//  QuSumPointageDansPeriodeDebit.open;
//  //recupérer le montantPointé Jusqu'à période
//  QuSumPointageDansPeriodeCredit.close;
//  QuSumPointageDansPeriodeCredit.ParamByName('ID_Ecriture').AsInteger:=TaResteDC_TvaID_Ecriture.AsInteger;
//  QuSumPointageDansPeriodeCredit.open;
//
//
//  if not VerifFNumeric(QuSumPointageDansPeriodeDebit.findfield('MontantPointeDebit')).VideOUZero then
//    TaResteDC_TvaMontantPointe.AsCurrency:=QuSumPointageDansPeriodeDebit.findfield('MontantPointeDebit').ascurrency
//  else
//    if not VerifFNumeric(QuSumPointageDansPeriodeCredit.findfield('MontantPointeCredit')).VideOUZero then
//      TaResteDC_TvaMontantPointe.AsCurrency:=QuSumPointageDansPeriodeCredit.findfield('MontantPointeCredit').ascurrency;
//
//  if TaResteDC_TvaSensSolde.AsBoolean then
//    begin
//      TaResteDC_TvaDateTva.AsDateTime:=QuSumPointageDansPeriodeCreditTvaDateCredit.AsDateTime;
//      if TaResteDC_TvaDateTva.AsDateTime=0  then //si pas de pointages dans période
//         TaResteDC_TvaDateTva.AsDateTime:=QuSumPointageCreditTvaDateCredit.AsDateTime;
//    end
//  else
//    begin
//      TaResteDC_TvaDateTva.AsDateTime:=QuSumPointageDansPeriodeDebitTvaDateDebit.AsDateTime;
//      if TaResteDC_TvaDateTva.AsDateTime=0  then //si pas de pointages dans période
//         TaResteDC_TvaDateTva.AsDateTime:=QuSumPointageDebitTvaDateDebit.AsDateTime;
//    end;
end;

procedure TDMTmTVA.QuMaitre_ParcoursEcritureTypeECalcFields(DataSet: TDataSet);
var
//MessageLGR:TMessageLGR;
partTvaDejaDeclaree:real;
begin
//if e.TypeClient=cl_isa then
//begin
//if(QuMaitre_ParcoursEcritureTypeEId.AsInteger=120006561)then showmessage('id : 120006561 est passée');
//if(QuMaitre_ParcoursEcritureTypeEId_Piece.AsInteger=120001761)then showmessage('id : 120001761 est passée');
partTvaDejaDeclaree:=0;
if QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency<>0 then
  partTvaDejaDeclaree:= QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat/QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency;
//  //si nouveau pointage pas déjà déclaré dans la période
  QuMaitre_ParcoursEcritureTypeENouveauPointage.AsCurrency:=QuMaitre_ParcoursEcritureTypeEMontantPointe_Tiers.AsCurrency-(QuMaitre_ParcoursEcritureTypeEPart_Declaree.AsFloat*QuMaitre_ParcoursEcritureTypeEMontantTiers.AsCurrency);
  QuMaitre_ParcoursEcritureTypeESensTva.AsBoolean:=VerifFNumeric(QuMaitre_ParcoursEcritureTypeECreditSaisie).VideOUZero;
  //si nouveau pointage pas déjà déclaré dans la période
  if QuMaitre_ParcoursEcritureTypeENouveauPointage.AsCurrency > 0 then
    QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat:=(QuMaitre_ParcoursEcritureTypeENouveauPointage.AsCurrency/QuMaitre_ParcoursEcritureTypeEMontantTiers.AsCurrency);
  //calcul du prorata pour calcul de la tva en attente pour la période
  QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat:=0;
  if arrondi(QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat+QuMaitre_ParcoursEcritureTypeEPart_Declaree.AsFloat,11)<1 then
   QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat:=1-(QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat+QuMaitre_ParcoursEcritureTypeEPart_Declaree.AsFloat);
//  //calcul du prorata pour calcul de la tva en attente pour la période

//si QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat<=0 alors dernière partie de réglement,
//donc on prend la part restante de la tva
  if QuMaitre_ParcoursEcritureTypeESensTva.AsBoolean then
    begin
    if QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat<=0 then
      begin
        if (QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat)>0 then
          QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.AsCurrency:=QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat
        else
          QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.AsCurrency:=0;
        QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.AsCurrency:=0;
      end
    else
      begin
        QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.AsCurrency:=arrondi(QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat*QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency,2);
        QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.AsCurrency:=QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat-QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.AsCurrency;
        if QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.AsCurrency<0 then
          QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.AsCurrency:=0;
      end;
    end
  else
    begin
    if QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat<=0 then
      begin
        if (QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat)>0 then
          QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.AsCurrency:=QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat
        else
          QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.AsCurrency:=0;
        QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.AsCurrency:=0;
      end
    else
      begin
        QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.AsCurrency:=arrondi(QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat*QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency,2);
        QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.AsCurrency:=QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat-QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.AsCurrency;
        if QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.AsCurrency<0 then
          QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.AsCurrency:=0;
      end;
    end;
  if QuMaitre_ParcoursEcritureTypeETvaDate.AsDateTime=0 then
    begin
       QuMaitre_ParcoursEcritureTypeETvaDate.asstring:=C_DateFinInfini;
    end;
if QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsCurrency>QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency then
   showmessage('montant tva déclarée supérieur au montant total de la tva de la ligne '+QuMaitre_ParcoursEcritureTypeEId.AsString);
//end
//else
//begin//si autre type client
//partTvaDejaDeclaree:=0;
//if QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency<>0 then
//  partTvaDejaDeclaree:= QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat/QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency;
////  //si nouveau pointage pas déjà déclaré dans la période
//  QuMaitre_ParcoursEcritureTypeENouveauPointage.AsCurrency:=QuMaitre_ParcoursEcritureTypeEMontantPointe_Tiers.AsCurrency-(QuMaitre_ParcoursEcritureTypeEPart_Declaree.AsFloat*QuMaitre_ParcoursEcritureTypeEMontantTiers.AsCurrency);
//  QuMaitre_ParcoursEcritureTypeESensTva.AsBoolean:=VerifFNumeric(QuMaitre_ParcoursEcritureTypeECreditSaisie).VideOUZero;
//  //si nouveau pointage pas déjà déclaré dans la période
//  if QuMaitre_ParcoursEcritureTypeENouveauPointage.AsCurrency > 0 then
//    QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat:=(QuMaitre_ParcoursEcritureTypeENouveauPointage.AsCurrency/QuMaitre_ParcoursEcritureTypeEMontantTiers.AsCurrency);
//  //calcul du prorata pour calcul de la tva en attente pour la période
//   QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat:=1-(QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat+QuMaitre_ParcoursEcritureTypeEPart_Declaree.AsFloat);
////  //calcul du prorata pour calcul de la tva en attente pour la période
//
////si QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat<=0 alors dernière partie de réglement,
////donc on prend la part restante de la tva
//  if QuMaitre_ParcoursEcritureTypeESensTva.AsBoolean then
//    begin
//    if QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat<=0 then
//      begin
//        if (QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat)>0 then
//          QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.AsCurrency:=QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat
//        else
//          QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.AsCurrency:=0;
//        QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.AsCurrency:=0;
//      end
//    else
//      begin
//        QuMaitre_ParcoursEcritureTypeETva_A_DeclareeDebit.AsCurrency:=QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat*QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency;
//        QuMaitre_ParcoursEcritureTypeETva_En_Attente_Debit.AsCurrency:=QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat*QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency;
//      end;
//    end
//  else
//    begin
//    if QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat<=0 then
//      begin
//        if (QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat)>0 then
//          QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.AsCurrency:=QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency-QuMaitre_ParcoursEcritureTypeEMontantDeclaree.AsFloat
//        else
//          QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.AsCurrency:=0;
//        QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.AsCurrency:=0;
//      end
//    else
//      begin
//        QuMaitre_ParcoursEcritureTypeETva_A_DeclareeCredit.AsCurrency:=QuMaitre_ParcoursEcritureTypeENouveauProrataPointage.AsFloat*QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency;
//        QuMaitre_ParcoursEcritureTypeETva_En_Attente_Credit.AsCurrency:=QuMaitre_ParcoursEcritureTypeEProrataEnAttente.AsFloat*QuMaitre_ParcoursEcritureTypeEmontant_tva.AsCurrency;
//      end;
//    end;
//  if QuMaitre_ParcoursEcritureTypeETvaDate.AsDateTime=0 then
//    begin
//       QuMaitre_ParcoursEcritureTypeETvaDate.asstring:=C_DateFinInfini;
//    end;
//end;//fin si autre type client
end;

procedure TDMTmTVA.QuParcoursEcritureTypeDCalcFields(DataSet: TDataSet);
begin
try
if not VerifFNumeric(QuParcoursEcritureTypeDDebit).VideOUZero then
   QuParcoursEcritureTypeDTvaDebit.AsCurrency:=QuParcoursEcritureTypeDmontant_tva.AsCurrency
 else
  if not VerifFNumeric(QuParcoursEcritureTypeDCredit).VideOUZero then
   QuParcoursEcritureTypeDTvaCredit.AsCurrency:=QuParcoursEcritureTypeDmontant_tva.AsCurrency;

// if QuParcoursEcritureTypeDTvaDate.AsDateTime>e.DateFinDeclarationTVA then
//    QuParcoursEcritureTypeDTvaDateCalc.asstring:=C_DateFinInfini
//  else
    QuParcoursEcritureTypeDTvaDateCalc.AsDateTime:=QuParcoursEcritureTypeDTvaDate.AsDateTime;
Except
ShowMessage('Problème sur calcfield');
end;
end;



function TDMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable(ReferenceForce:string;deverrouiller,Confirmation:boolean;ForceSuppression:boolean;RemplaceParMessage:boolean):TExceptLGR;
var
messages:string;
idSupprime:integer;
supprimer:boolean;
Begin
result.retour:=true;
result.NumErreur:=0;
supprimer:=true;
idSupprime:=-1;
try//finally
  try//except
//if ((RemplaceParMessage)and (e.TypeClient=cl_isa)and(not((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')))) then
if ((RemplaceParMessage)and(not((ParamUtil.maintenance) and (ParamUtil.TypeMaintenance='MaintS')))) then
    raise ExceptLGR.Create(EmpecheSuppressionDerniereDeclarationTVA,result.NumErreur,true,mtError,Result);
  Initialise_ExceptLGR(result);
    //récupérer la référence de la dernière od de déclaration tva
    TableGereStartTransaction(DMTmTVA.TaH_TVA);
    //récupère la dernière période tva
    QuMaxDebut_Periode.Close;
    QuMaxDebut_Periode.Open;
    QuMaxFin_Periode.Close;
    QuMaxFin_Periode.Open;
    //modification de cette procédure le 29-06-03 par isa suite à accord avec denis et phil, je ne regarde plus si
    //la déclaration est non déverrouillable si j'interviens par le biais de dmtva par contre si on passe par tout autre écran
    // je regarde si dernière non déverrouillable. Ensuite, je ne rends plus la nouvelle dernière deverrouillable suite à une suppression
    //il n'y a qu'à la création que la denière déclaration sera deverrouillable
    if ((QuMaxDebut_Periode.recordcount<>0)and(QuMaxFin_Periode.recordcount<>0))then
      if ((QuMaxDebut_Periode.findfield('Debut_Periode').AsDateTime<>0)and(QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime<>0))then
        begin
        if not((QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime<e.DatExoDebut)or(QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime>e.DatExoFin)) then
          begin
              //raise ExceptLGR.Create('Pour supprimer la dernière déclaration tva, vous devez revenir sur l''exercice dont elle dépend.', result.NumErreur,true,mtError,Result);
                QuSupprDerniereDeclaration.Close;
                QuSupprDerniereDeclaration.sql.Clear;
                if ForceSuppression then
                  QuSupprDerniereDeclaration.sql.Add('select * from H_PieceTva where Debut_Periode=:Debut and Fin_Periode=:Fin and verrouillageManuel=false')
                else
                  QuSupprDerniereDeclaration.sql.Add('select * from H_PieceTva where Debut_Periode=:Debut and Fin_Periode=:Fin and deverrouillable=true and verrouillageManuel=false');
                QuSupprDerniereDeclaration.ParamByName('Debut').AsDateTime:=QuMaxDebut_Periode.findfield('Debut_Periode').AsDateTime;
                QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime;
                QuSupprDerniereDeclaration.open;
            //AfficheInfoComposant('H_PieceTVA, recherche dans période',QuSupprDerniereDeclaration,true);
            if QuSupprDerniereDeclaration.recordcount<>0 then
              begin
                ReferenceForce:=QuSupprDerniereDeclaration.findfield('Reference_OD').asstring;
                idSupprime:=QuSupprDerniereDeclaration.findfield('id_declaration').asinteger;
              end;
          end;
        end;

    if empty(ReferenceForce)then
      raise ExceptLGR.Create('Il n''y a pas de pièce de TVA à supprimer !!!',1,true,mtError,result)
    else
      if Confirmation then
         begin
            if Application.MessageBox(PChar('Etes-vous sûr de vouloir supprimer la pièce de tva n°: '+ReferenceForce),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = idyes then
              supprimer:=true
            else
              supprimer:=false;
         end
      else
          supprimer:=true;

      if supprimer then
        begin
          //AfficheInfoComposant('TaPiece, recherche dans tablePiece',dmpieces.TaPiece,true);
          FiltrageDataSet(dmrech.TaPieceRech,'reference ='''+ReferenceForce+'''');
          if dmrech.TaPieceRech.RecordCount<>0 then
            DMPieces.SuppressionOD(ReferenceForce);
        //suppression de l'historique des lignes déclarées de la dernière période
              QuSupprDerniereDeclaration.Close;
              QuSupprDerniereDeclaration.sql.Clear;

              if ForceSuppression then
                QuSupprDerniereDeclaration.sql.Add('Delete from H_Tva where ((Debut_Periode=:Debut and Fin_Periode=:Fin) or (id_declaration=:id))')
              else
                QuSupprDerniereDeclaration.sql.Add('Delete from H_Tva where((Debut_Periode=:Debut and Fin_Periode=:Fin) or (id_declaration=:id)) and deverrouillable=true');
              QuSupprDerniereDeclaration.ParamByName('Debut').AsDateTime:=QuMaxDebut_Periode.findfield('Debut_Periode').AsDateTime;
              QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime;
              QuSupprDerniereDeclaration.ParamByName('id').AsInteger:=idsupprime;
              QuSupprDerniereDeclaration.ExecSQL;
        //fin suppression de l'historique des lignes déclarées de la dernière période

        //suppression de l'historique de la pièce de tva de la dernière période
          if idSupprime<>-1 then
            begin
               QuSupprDerniereDeclaration.Close;
               QuSupprDerniereDeclaration.sql.Clear;
               QuSupprDerniereDeclaration.sql.Add('Delete from H_PieceTva where id_declaration=:id');
               QuSupprDerniereDeclaration.ParamByName('id').Asinteger:=idSupprime;
               QuSupprDerniereDeclaration.ExecSQL;
            end;
        //fin de la suppression de l'historique de la pièce de tva de la dernière période
        end
      else
        raise ExceptLGR.Create('',1,false,mtError,result);

    //
    Vide_Ta_H_Tva_Fin(idSupprime);
    Vide_Ta_H_Tva_Report(idSupprime);
      //initialiser les reports
    QuMaxDebut_Periode.Close;
    QuMaxDebut_Periode.Open;
    QuMaxFin_Periode.Close;
    QuMaxFin_Periode.Open;

    //*******  on ne rend plus deverrouillable à la suite d'une suppression  /////*******
//    if deverrouiller then
//      begin
//        QuSupprDerniereDeclaration.Close;
//        QuSupprDerniereDeclaration.sql.Clear;
//        QuSupprDerniereDeclaration.sql.Add('Update h_tva set deverrouillable=true where Debut_Periode=:Debut and Fin_Periode=:Fin');
//        QuSupprDerniereDeclaration.ParamByName('Debut').AsDateTime:=QuMaxDebut_Periode.findfield('Debut_Periode').AsDateTime;
//        QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime;
//        QuSupprDerniereDeclaration.ExecSQL;
//      end;
    TaH_PieceTVA.open;
    TaH_PieceTVA.FlushBuffers;
    TaH_TVA.open;
    TaH_TVA.FlushBuffers;

    TableGereCommit(DMTmTVA.TaH_TVA);
    TableGereCommit(DMBalance.TaBalance);
    MAJ_DateDeclarationTVA(e.DateDebutDeclarationTVA,e.DateFinDeclarationTVA);
    InitialiseTotauxBalance(TotauxReport.Totaux);
    TotauxReport.Retour:=true;

  except
     TableGereRollBack(DMTmTVA.TaH_TVA);
     TableGereRollBack(DMBalance.TaBalance);
     if result.retour then
        showmessage('Problème lors de la suppression_Derniere_Declaration_Tva_Deverrouillable : Contactez le service maintenance.');
     result.retour:=false;
  end;
finally
    QuSupprDerniereDeclaration.Close;
    QuSupprDerniereDeclaration.sql.Clear;
    QuSupprDerniereDeclaration.sql.Add('select * from H_Tva ');
    QuSupprDerniereDeclaration.open;
//    if TaDec_Tva.active then
//      TaDec_Tva.Refresh;
end;
End;

procedure TDMTmTVA.MAJ_DateDeclarationTVA(var debut,fin:tdate);
var
DateDebDefaut:TdateTime;
Begin
//il faut aller chercher les date debut et fin période de la dernière declaration tva
//puis les incrémenter selon le cas
QuMaxFin_Periode.Close;
QuMaxFin_Periode.Open;
DateDebDefaut:=e.PremiereDateDeclaration;
if QuMaxFin_Periode.RecordCount<>0 then
  if QuMaxFin_Periodefin_Periode.AsDateTime<>0 then
  begin
    DateDebDefaut:=QuMaxFin_Periodefin_Periode.AsDateTime+1;
  end;
Debut:=DateDebDefaut;
// PB le 18/02/04    case PeriodiciteTVA of
    case E.PeriodiciteTVA of
       1:Begin //déclaration mensuelle
           fin:=Moissuivant(Debut,0).Date_-1;
          End;
       3:Begin //déclaration trimestrielle
            fin:=Moissuivant(Debut,2).Date_-1;
          End;
       12:Begin //déclaration annuelle
//            if DateInfos(Debut).Valide then
//             if
            fin:=Moissuivant(Debut,11).Date_-1;
          End;
    else MessageDlg('DMTmTVA.MAJ_DateDeclarationTVA : Attention, la périodicité de la tva n''est pas définie.'+#13+#10+''+#13+#10+'Veuillez contacter Le Grain SA !', mtError, [mbOK], 0);
    end; //fin case
if fin>e.DatExoFin then fin:=e.DatExoFin;
End;

procedure TDMTmTVA.QuDec_TvaAfterOpen(DataSet: TDataSet);
begin
TaEcritureContrepartie.Open;
TFloatField(QuDec_Tva.FindField('Part_Declare_calc')).DisplayFormat:='##0.00 "%"';
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;

procedure TDMTmTVA.QuDec_TvaCalcFields(DataSet: TDataSet);
var
TauxTva:real;
begin
QuDec_Tva.findfield('Taux').AsFloat:=QuDec_Tva.findfield('TauxReel').AsFloat;
QuDec_TvaPart_Declare_Calc.AsFloat:=QuDec_TvaPart_Declaration.AsFloat * 100;
QuDec_TvaHT_Declare_Debit.AsCurrency:=arrondi(QuDec_TvaHTDebit.AsCurrency*QuDec_TvaPart_Declaration.AsFloat,2);
QuDec_TvaHT_Declare_Credit.AsCurrency:=arrondi(QuDec_TvaHTCredit.AsCurrency*QuDec_TvaPart_Declaration.AsFloat,2);
//QuDec_TvaHT_Declare_Debit.AsCurrency:=QuDec_TvaHTDebit.AsCurrency*QuDec_TvaPart_Declaration.AsFloat;
//QuDec_TvaHT_Declare_Credit.AsCurrency:=QuDec_TvaHTCredit.AsCurrency*QuDec_TvaPart_Declaration.AsFloat;
if not(QuDec_Tva.findfield('Journal').Asinteger in [1,2]) then
 begin
  QuDec_Tva.findfield('HT_Declare').AsCurrency:=0;
  QuDec_TvaHT_Declare_Debit.AsCurrency:=0;
  QuDec_TvaHT_Declare_Credit.AsCurrency:=0;
 end
else
  QuDec_TvaHT_Declare.AsCurrency:=QuDec_TvaHT_Declare_Credit.AsCurrency-QuDec_TvaHT_Declare_Debit.AsCurrency;
if QuDec_TvaDivers.asstring<>'' then
  Begin//si ligne de régulation
     TauxTva:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[QuDec_TvaTvaCode.AsString]).Taux_Supp;
     QuDec_TvaHT_Declare_Debit.AsCurrency:=0;
     QuDec_TvaHT_Declare_Credit.AsCurrency:=0;
     if TauxTva<>0 then
       begin
        if QuDec_TvaTvaMontantDebit.AsCurrency<>0 then
          begin
            QuDec_TvaHT_Declare_Debit.AsCurrency:=arrondi((QuDec_TvaTvaMontantDebit.AsCurrency*100)/TauxTva,2);
            QuDec_Tva.findfield('HT_Declare').AsCurrency:=QuDec_TvaHT_Declare_Debit.AsCurrency;
          end
        else
          begin
            QuDec_TvaHT_Declare_Credit.AsCurrency:=arrondi((QuDec_TvaTvaMontantCredit.AsCurrency*100)/TauxTva,2);
            QuDec_Tva.findfield('HT_Declare').AsCurrency:=QuDec_TvaHT_Declare_Credit.AsCurrency;
          end;
         QuDec_Tva.findfield('Taux').AsFloat:=TauxTva;
       end;
  end;
QuDec_TvaHT_Declare.AsCurrency:=abs(QuDec_TvaHT_Declare.AsCurrency);
end;

procedure TDMTmTVA.QuParcoursEcritureTypeD_EnAttenteCalcFields(
  DataSet: TDataSet);
begin
if not VerifFNumeric(QuParcoursEcritureTypeD_EnAttenteDebit).VideOUZero then
   QuParcoursEcritureTypeD_EnAttenteTvaDebit.AsCurrency:=QuParcoursEcritureTypeD_EnAttentemontant_tva.AsCurrency
 else
  if not VerifFNumeric(QuParcoursEcritureTypeD_EnAttenteCredit).VideOUZero then
   QuParcoursEcritureTypeD_EnAttenteTvaCredit.AsCurrency:=QuParcoursEcritureTypeD_EnAttentemontant_tva.AsCurrency;

// if QuParcoursEcritureTypeD_EnAttenteTvaDate.AsDateTime>e.DateFinDeclarationTVA then
//    QuParcoursEcritureTypeD_EnAttenteTvaDateCalc.asstring:='C_DateFinInfini
//  else
    QuParcoursEcritureTypeD_EnAttenteTvaDateCalc.AsDateTime:=QuParcoursEcritureTypeD_EnAttenteTvaDate.AsDateTime;
end;


procedure TDMTmTVA.PaGrilleResizePour_AffichInfoDeclarationTVA(Sender: TObject);
begin
  FormateTailleColonne(visuliste.GrDBVisu,19,[2,6,3,3,1]);
  WinShape(screen.ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TDMTmTVA.BtnDetailClick(Sender: TObject);
//var
//DetailTVAAffich:TDetailTVAAffich;
begin
  //DetailEcritureCompteTVA('',visuliste.GrDBVisu.datasource.DataSet.findfield('TvaCode').asstring,true);
  initialise_TDetailTVAAffich(DetailTVAAffichGlobal);
  DetailTVAAffichGlobal.Periode.DateDeb:=e.DateDebutDeclarationTVA;
  DetailTVAAffichGlobal.Periode.DateFin:=e.DateFinDeclarationTVA;
  DetailTVAAffichGlobal.Calculer:=AffichCalcul;
  DetailTVAAffichGlobal.ListeCodes.Clear;
  DetailTVAAffichGlobal.ListeCodes.Add(visuliste.GrDBVisu.datasource.DataSet.findfield('TvaCode').asstring);
  if visuliste.GrDBVisu.datasource.DataSet.findfield('En_attente').AsBoolean then
    DetailTVAAffichGlobal.En_Attente:=En_attente
  else
    DetailTVAAffichGlobal.En_Attente:=Pas_En_Attente;
  AffichDeclarationTVASurPeriode(DetailTVAAffichGlobal);
end;



function TDMTmTVA.GenererPieceTva(var reference:string;ListeADeclaree:PSolde_A_Declarer):boolean;
var
//Q:TQuery;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang,i:integer;
ValPieceAutoGen:TValPieceAutoGenere;
compteComptable1,compteComptable2:TCompteAmortissement;
ListOD:TStringList;
CumulDerog,SoldeArrondi:currency;
Tab:variant;
compte_A_Solder,CompteTVA,filtre:string;
Begin
  try
     try
       result:=true;
       listeFactice:=nil;
       ListOD:=TStringList.Create;
       ListOD.Add(' ');
       ListOD.clear;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TaH_TVA);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DateFinDeclarationTVA;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:='Déclaration de la TVA du '+datetostr(e.DateDebutDeclarationTVA)+' au '+datetostr(e.DateFinDeclarationTVA);
       SourcePiece.Compte:='';
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=reference;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;

       //création ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if ListeADeclaree<>nil then
          begin
          SoldeArrondi:=arrondi(ListeADeclaree.Calcul.Total.Solde,2);
          if not empty(ListeADeclaree.CompteArrondis)then
            begin
              if SoldeArrondi-ListeADeclaree.Declaration <>0 then
              Begin
                  DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.CompteArrondis,'',SourcePiece.Libelle,0,0,SoldeArrondi-ListeADeclaree.Declaration,0,'','',0,'',''],true,false,-1);
              End;
            end;
          if ListeADeclaree=nil then abort;
            if ListeADeclaree.APayer.Retour then
              begin//s'il y a un arrondis
                if ((ListeADeclaree.APayer.SensSolde=1)or(ListeADeclaree.APayer.SensSolde=-1)) then
                  DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.APayer.compte,'',SourcePiece.Libelle,0,0,arrondi(ListeADeclaree.APayer.Total.Solde,2),0,'','',0,'',''],true,false,-1);
                  if doublerLigne=ListeADeclaree.APayer.compte then
                    DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.APayer.compte,'',SourcePiece.Libelle,0,0,-arrondi(ListeADeclaree.APayer.Total.Solde,2),0,'','',0,'',''],true,false,-1);
              end;//fin s'il y a un arrondis
            if ListeADeclaree.Remboursement.Retour then
              begin
                if ((ListeADeclaree.Remboursement.SensSolde =1)or(ListeADeclaree.Remboursement.SensSolde =-1)) then
                    DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.Remboursement.Compte,'',SourcePiece.Libelle,0,0,arrondi(ListeADeclaree.Remboursement.Total.Solde,2),0,'','',0,'',''],true,false,-1);
                  if doublerLigne=ListeADeclaree.Remboursement.compte then
                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.Remboursement.Compte,'',SourcePiece.Libelle,0,0,-arrondi(ListeADeclaree.Remboursement.Total.Solde,2),0,'','',0,'',''],true,false,-1);           end;
            if ListeADeclaree.Report.Retour then
              begin
                if ((ListeADeclaree.Report.SensSolde =1)or(ListeADeclaree.Report.SensSolde =-1)) then
                    DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.Report.Compte,'',SourcePiece.Libelle,0,0,arrondi(ListeADeclaree.Report.Total.Solde,2),0,'','',0,'',''],true,false,-1);
                  if doublerLigne=ListeADeclaree.Report.compte then
                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.Report.Compte,'',SourcePiece.Libelle,0,0,-arrondi(ListeADeclaree.Report.Total.Solde,2),0,'','',0,'',''],true,false,-1);
              end;
            if ListeADeclaree.AcompteVerse.Retour then
              begin
                if ((ListeADeclaree.AcompteVerse.SensSolde =1)or(ListeADeclaree.AcompteVerse.SensSolde =-1)) then
                    DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.AcompteVerse.Compte,'',SourcePiece.Libelle,0,0,arrondi(ListeADeclaree.AcompteVerse.Total.Solde,2),0,'','',0,'',''],true,false,-1);
              end;
            if ListeADeclaree.DeduiteAReverser.Retour then
              begin
                if ((ListeADeclaree.DeduiteAReverser.SensSolde =1)or(ListeADeclaree.DeduiteAReverser.SensSolde =-1)) then
                    DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',ListeADeclaree.DeduiteAReverser.Compte,'',SourcePiece.Libelle,0,0,arrondi(ListeADeclaree.DeduiteAReverser.Total.Solde,2),0,'','',0,'',''],true,false,-1);
              end;
            end;//si liste <> nil
         //on doit répertorier ici tous les codes tva concernés par de la tva
         filtre:=QuDec_Tva_VisuListe.filter;
         FiltrageDataSet(QuDec_Tva_VisuListe,QuDec_Tva.Filter);
         QuDec_Tva_VisuListe.First;
         while not(QuDec_Tva_VisuListe.eof)do
           begin
             if not(QuDec_Tva_VisuListe.FindField('En_Attente').AsBoolean)then
             Begin
                SoldeArrondi:=0;
                CompteTVA:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[QuDec_Tva_VisuListe.FindField('TvaCode').asstring]).Compte;
                if not empty(CompteTVA)then
                  Begin
                   //SoldeArrondi:=arrondi(QuDec_Tva_VisuListe.FindField('TottvaMontantDebit').ascurrency,2)-arrondi(QuDec_Tva_VisuListe.FindField('TottvaMontantCredit').ascurrency,2);
                   SoldeArrondi:=arrondi(QuDec_Tva_VisuListe.FindField('TottvaMontantDebit').ascurrency-QuDec_Tva_VisuListe.FindField('TottvaMontantCredit').ascurrency,2);
                   if SoldeArrondi<>0 then
                     DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteTVA,'',SourcePiece.Libelle,0,0,SoldeArrondi,0,'','',0,'',''],true,false,-1);
                  End;
             End;
             QuDec_Tva_VisuListe.Next;
           end;

     DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
     //Ecrire dans la pièce les infos dans TableGen,ChampGen,etc...pour reconnaître que
     //c'est une pièce générée automatiquement
     DMImport.EnregistrementPiece(false,nil,listod,listeFactice);
     reference:=DMImport.Piece_Import.Reference;
     DMPieces.AffichageFeuilleReprise(0,ListOd,nil,'Affichage de la pièce de déclaration de la TVA','','',false);
     InfosAvantValidation:=nil;
     Soldearrondi_Imposable:=0;
     Soldearrondi_Deductible:=0;
     except
      showmessage('Problème à l''enregistrement de la pièce de déclaration de la TVA !');
      result:=false;
      abort;
     end;//fin du try except
  finally
  Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMTmTVA,false);
//    if ListOD<>nil then
//      ListOD.free;
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        FiltrageDataSet(QuDec_Tva_VisuListe,filtre);
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
  end;//fin du try finally
End;

Function CalculReport(affichage:boolean;Var ListeReport:Tlist;DateDeb,DateFin:Tdate):TReport;
var
parametres,Resultat:Tlist;
InfosComplTva:PParam_InfosComplTva;
i:integer;
SourcePiece:PRecordPiece;
ValPieceAutoGen:TValPieceAutoGenere;
AnneeAnterieure:TPieceAnterieure;
ListeFiltre:TStringList;
ListeEsclave:TList;
compteExceptionnel:string;
SoldeExceptionnel:currency;
ReportDeductible,ReportImposable:TTotauxBalance;
begin
try
try
if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);
parametres:=TList.Create;
if ListeReport<>nil then ListeReport:=nil;
ListeReport:=TList.Create;
ListeReport.Clear;
ListeFiltre:=TStringList.Create;
ListeEsclave:=TList.Create;
InitialiseTotauxBalance(result.Totaux);
InitialiseTotauxBalance(ReportDeductible);
InitialiseTotauxBalance(ReportImposable);
result.Retour:=true;
//0=reporter
//1=Laisser
//2=OD Exceptionnelle

new(InfosComplTva);
InfosComplTva.Compte_A_Traiter:=DM_C_CompteTVAPourReport;//'44567';
InfosComplTva.CodeDefaut:=0;
parametres.Add(InfosComplTva);

new(InfosComplTva);
InfosComplTva.Compte_A_Traiter:=DM_C_CompteTVAPourRemboursement;//'44583';
InfosComplTva.CodeDefaut:=1;
parametres.Add(InfosComplTva);

new(InfosComplTva);
InfosComplTva.Compte_A_Traiter:=DM_C_CompteTVAAPayer;//'44551';
InfosComplTva.CodeDefaut:=0;
parametres.Add(InfosComplTva);

Resultat:=AffichInfoComplementairesTVA(parametres,Affichage);
if Resultat<>nil then
  Begin
    for i:=0 to Resultat.count-1 do
    if PSolde_A_Traiter(Resultat.Items[i])^.ATraiter then
      Begin
        case PSolde_A_Traiter(Resultat.Items[i])^.Code of
          0:Begin//si Reprise dans calcul
              ListeFiltre.Add(PSolde_A_Traiter(Resultat.Items[i])^.Compte);
              ListeReport.Add(PSolde_A_Traiter(Resultat.Items[i]));
            End;//fin si Reprise dans calcul
          1:Begin//si laisser
              //
            End;//fin si laisser
          2:Begin//si créer OD exceptionnelle
              if DMPieces = nil then
                     DMPieces:=TDMPieces.Create(Application.MainForm);
              ListeEsclave.Clear;
              DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

//              ValPieceAutoGen.TableGen:=true;
//              ValPieceAutoGen.Table_Gen:='Pièce Créée le '+datetostr(now);
              AnneeAnterieure.PieceAnterieure:=false;
              AnneeAnterieure.ExoAnterieure:='';
              new(SourcePiece);
              Initialise_TRecordPiece(SourcePiece^);
              with PRecordPiece(sourcepiece)^ do
                begin
                   ID:=1;
                   Date:=e.DateFinDeclarationTVA;
                   Validation:=SourcePiece.Date;
                   Libelle:='Solde du compte '+PSolde_A_Traiter(Resultat.Items[i])^.compte+' vers le compte '+compteExceptionnel;
                   Journal:='OD';
                end;
              if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
                DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create
              else
                DMImport.Ecriture_Import.ListeEcriturePiece.Clear;
              if not PSolde_A_Traiter(Resultat.Items[i])^.Total.SoldeDebitCreditFin then
                begin
                  compteExceptionnel:=DM_C_CompteTVAExceptionnelCredit;//'771';
                  SoldeExceptionnel:=PSolde_A_Traiter(Resultat.Items[i])^.Total.SoldeFin;
                  //remplissage des 2 lignes de l'OD
                  DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(ListeEsclave,['H',PSolde_A_Traiter(Resultat.Items[i])^.compte,'','',0,0,-PSolde_A_Traiter(Resultat.Items[i])^.Total.SoldeFin,0,'','',0,'',datetostr(SourcePiece.Validation),SourcePiece.id],true,false,-1);
                  DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(ListeEsclave,['H',compteExceptionnel,'','',0,0,SoldeExceptionnel,0,'','',0,'',datetostr(SourcePiece.Date),SourcePiece.id],true,false,-1);
                end
              else
                begin
                  compteExceptionnel:=DM_C_CompteTVAExceptionnelDebit;//'671';
                  SoldeExceptionnel:=-PSolde_A_Traiter(Resultat.Items[i])^.Total.SoldeFin;
                  //remplissage des 2 lignes de l'OD
                  DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(ListeEsclave,['H',PSolde_A_Traiter(Resultat.Items[i])^.compte,'','',0,0,PSolde_A_Traiter(Resultat.Items[i])^.Total.SoldeFin,0,'','',0,'',datetostr(SourcePiece.Validation),SourcePiece.id],true,false,-1);
                  DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(ListeEsclave,['H',compteExceptionnel,'','',0,0,SoldeExceptionnel,0,'','',0,'',datetostr(SourcePiece.Date),SourcePiece.id],true,false,-1);
                end;

              //////
              DMPieces.ImportPiece(sourcepiece^,ListeEsclave,nil,AnneeAnterieure,ValPieceAutoGen,nil);
              if DMPieces.ListePieceCreees.count<>0 then
                begin
//                    showmessage('La pièce '+DMPieces.ListePieceCreees.Strings[0]+' a été créée.');
                  DMPieces.AffichageFeuilleReprise(0,DMPieces.ListePieceCreees,nil,'Affichage des nouvelles pièces créées','','',false);
                end;
            End;//fin si créer OD exceptionnelle
        end;//fin du case code
      End;
     if ListeFiltre<>nil then
       if  ListeFiltre.Count<>0 then
         begin
           for i:=0 to ListeFiltre.Count-1 do
             Begin
               if ListeFiltre.Strings[i]=DM_C_CompteTVAAPayer then// +  Débit (-) Crédit(+)
                 begin
                   if dateDeb<e.DatExoDebut then
                     ReportImposable:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,DateFin,ListeFiltre.Strings[i])
                   else
                     ReportImposable:=DMDiocEtatBal.SommeTotauxBalanceParCompte(DateDeb,DateFin,ListeFiltre.Strings[i]);
                   ListeFiltre.delete(i);
                  if ReportImposable.SoldeDebitCreditBase then
                    ReportImposable.SoldeBase:=-ReportImposable.SoldeBase;
                  if ReportImposable.SoldeDebitCreditReport then
                    ReportImposable.SoldeReport:=-ReportImposable.SoldeReport;
                  if ReportImposable.SoldeDebitCreditFin then
                    ReportImposable.SoldeFin:=-ReportImposable.SoldeFin;
                 end;
             End;//fin du for
             if ListeFiltre.count<>0 then //-  Débit (+) Crédit(-) pour les autres reports
                begin  //
                   if dateDeb<e.DatExoDebut then
                      ReportDeductible:=DMDiocEtatBal.SommeTotauxBalanceCalc(e.DatExoDebut,DateFin,ListeFiltre,'Compte')
                   else
                      ReportDeductible:=DMDiocEtatBal.SommeTotauxBalanceCalc(DateDeb,DateFin,ListeFiltre,'Compte');
                  //on gére d'abort les reports 44567 et 44583
                  if ReportDeductible.SoldeDebitCreditBase then
                    ReportDeductible.SoldeBase:=-ReportDeductible.SoldeBase;
                  if ReportDeductible.SoldeDebitCreditReport then
                    ReportDeductible.SoldeReport:=-ReportDeductible.SoldeReport;
                  if ReportDeductible.SoldeDebitCreditFin then
                    ReportDeductible.SoldeFin:=-ReportDeductible.SoldeFin;
                end;
            //////on gérer maintenant le solde de tous
            Result.Totaux.SoldeBase:=ReportImposable.SoldeBase+ReportDeductible.SoldeBase;
            Result.Totaux.SoldeReport:=ReportImposable.SoldeReport+ReportDeductible.SoldeReport;
            Result.Totaux.SoldeFin:=Result.Totaux.SoldeReport+Result.Totaux.SoldeBase;

            Result.Totaux.SoldeDebitCreditBase:=Result.Totaux.SoldeBase<0;
            Result.Totaux.SoldeDebitCreditReport:=Result.Totaux.SoldeReport<0;
            Result.Totaux.SoldeDebitCreditFin:=Result.Totaux.SoldeFin<0;

            Result.Totaux.SoldeBase:=abs(Result.Totaux.SoldeBase);
            Result.Totaux.SoldeReport:=abs(Result.Totaux.SoldeReport);
            Result.Totaux.SoldeFin:=abs(Result.Totaux.SoldeFin);

         end;//fin si liste remplie
  End
else
  Begin
  abort;
  End;
except
  result.Retour:=false;
  if ListeReport<>nil then
  ListeReport.clear;
end;
finally
if ListeFiltre<>nil then ListeFiltre.free;
if ListeEsclave<>nil then ListeEsclave.Free;
end;//fin du try finally
End;


function TDMTmTVA.Verif_Si_Date_HorsDeclarationExistante(DateDeb_,DateFin_:Tdatetime;MessageAffich:boolean):TexceptLgr;
Begin
  try
Initialise_ExceptLGR(result);
    result.NumErreur:=0;
    QuVerifDateDecl.Close;
    QuVerifDateDecl.SQL.Clear;
    QuVerifDateDecl.SQL.Add('select * from h_Piecetva where ((Debut_Periode<=:DateDeb and Fin_Periode>=:DateDeb)or (Debut_Periode<=:DateFin and Fin_Periode>=:DateFin))');
    QuVerifDateDecl.ParamByName('DateDeb').AsDateTime:=DateDeb_;
    QuVerifDateDecl.ParamByName('DateFin').AsDateTime:=DateFin_;
    QuVerifDateDecl.open;
    result.retour:=QuVerifDateDecl.RecordCount=0;
    if not result.retour then
      if not empty(QuVerifDateDecl.findfield('Reference_OD').asstring) then
        raise ExceptLGR.Create('Ces dates font partie d''une période déclarée et dont la pièce Tva a été générée !',101,MessageAffich,mtError,result)
      else
        raise ExceptLGR.Create('Ces dates font partie d''une période déclarée !',102,MessageAffich,mtError,result);
    QuVerifDateDecl.Close;
  except
    result.retour:=false;
  end;
End;

function TDMTmTVA.RecupCodeTva_A_Exclure(ListeClasse:Tstringlist):Tfiltre;
var
TvaCode:TStringList;
Begin
 try//finally
 Result.filtrer:=true;
  //récupérer tous les codes intracommunautaires
  try//except
  TvaCode:=FTvaCodeIntracommunautaire(ListeClasse);
  if TvaCode<>nil then
   if TvaCode.Count<>0 then
      result.filtre:=CreeFiltreOU('TvaCode',[TvaCode]);
  except
    result.filtrer:=false;
  end;//fin du try except
 finally
   if TvaCode<>nil then TvaCode.Free;
 end;//fin du try finally

End;


procedure TDMTmTVA.QuSumParCode_Dec_TvaCalcFields(DataSet: TDataSet);
var
TauxTva:real;
begin
//  QuSumParCode_Dec_Tva.FindField('Part_Declare_Calc').AsFloat:=QuSumParCode_Dec_Tva.FindField('Part_Declaration').AsFloat * 100;
//  QuSumParCode_Dec_Tva.FindField('HT_Declare_Debit').AsCurrency:=QuSumParCode_Dec_Tva.FindField('HTDebit').AsCurrency*QuSumParCode_Dec_Tva.FindField('Part_Declaration').AsFloat;

//  QuSumParCode_Dec_Tva.FindField('HT_Declare_Credit').AsCurrency:=QuSumParCode_Dec_Tva.FindField('HTCredit').AsCurrency*QuSumParCode_Dec_Tva.FindField('Part_Declaration').AsFloat;
//  QuSumParCode_Dec_Tva.FindField('HT_Declare').AsCurrency:=QuSumParCode_Dec_Tva.FindField('HT_Declare_Credit').AsCurrency-QuSumParCode_Dec_Tva.FindField('HT_Declare_Debit').AsCurrency;
//  QuSumParCode_Dec_Tva.FindField('HT_Declare').AsCurrency:=abs(QuSumParCode_Dec_Tva.FindField('HT_Declare').AsCurrency);
QuSumParCode_Dec_Tva.FindField('HT_Declare_DebitCalc').AsCurrency:=(abs(QuSumParCode_Dec_Tva.FindField('HT_Declare_Debit').AsCurrency)-abs(QuSumParCode_Dec_Tva.FindField('HT_Declare_Debit_OD').AsCurrency));
QuSumParCode_Dec_Tva.FindField('HT_Declare_CreditCalc').AsCurrency:=(abs(QuSumParCode_Dec_Tva.FindField('HT_Declare_Credit').AsCurrency)-abs(QuSumParCode_Dec_Tva.FindField('HT_Declare_Credit_OD').AsCurrency));
QuSumParCode_Dec_Tva.FindField('HT_DeclareCalc').AsCurrency:=(abs(QuSumParCode_Dec_Tva.FindField('HT_Declare').AsCurrency)-abs(QuSumParCode_Dec_Tva.FindField('HT_Declare_OD').AsCurrency));
if QuSumParCode_Dec_Tva.FindField('Divers').asstring<>'' then
  Begin //si ligne de régulation
     TauxTva:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[QuSumParCode_Dec_Tva.FindField('TvaCode').AsString]).Taux_Supp;
     QuSumParCode_Dec_Tva.FindField('HT_Declare_DebitCalc').AsCurrency:=0;
     QuSumParCode_Dec_Tva.FindField('HT_Declare_CreditCalc').AsCurrency:=0;
     if TauxTva<>0 then
       begin
        if QuSumParCode_Dec_Tva.FindField('TvaMontantDebit').AsCurrency<>0 then
            QuSumParCode_Dec_Tva.FindField('HT_Declare_DebitCalc').AsCurrency:=arrondi((QuSumParCode_Dec_Tva.FindField('TvaMontantDebit').AsCurrency*100)/TauxTva,2)
        else
            QuSumParCode_Dec_Tva.FindField('HT_Declare_CreditCalc').AsCurrency:=arrondi((QuSumParCode_Dec_Tva.FindField('TvaMontantCredit').AsCurrency*100)/TauxTva,2);
       end;
  end;//fin si ligne de régulation
end;

procedure TDMTmTVA.QuSumParCode_Dec_TvaAfterOpen(DataSet: TDataSet);
begin
TaEcritureContrepartie.Open;
end;


function TDMTmTVA.Affect_Ta_H_Tva_Report(ListeReport:Tlist;id_declaration:integer):TExceptLGR;
var
i:integer;
id:integer;
Begin
  try
    ProtectObjetNil([ListeReport]);
    TableGereStartTransaction(Ta_H_Tva_Report);
    for i:=0 to ListeReport.Count-1 do
      Begin
       id:=MaxId_Query(Ta_H_Tva_Report,'id');
       Ta_H_Tva_Report.AppendRecord([id,
                                     id_declaration,
                                     PSolde_A_Traiter(listeReport.items[i])^.Compte,
                                     PSolde_A_Traiter(listeReport.items[i])^.Total.SoldeFin,
                                     PSolde_A_Traiter(listeReport.items[i])^.Total.SoldeDebitCreditFin,
                                     PSolde_A_Traiter(listeReport.items[i])^.ATraiter,
                                     PSolde_A_Traiter(listeReport.items[i])^.Code]);
      End;
    TableGereCommit(Ta_H_Tva_Report);
  except
    TableGereRollBack(Ta_H_Tva_Report);
    abort;
  end;
End;

function TDMTmTVA.Recup_Ta_H_Tva_Report(Var ListeReport:Tlist;id_declaration:integer):TExceptLGR;
var
Solde_A_Traiter:PSolde_A_Traiter;
Begin
try
  try
    Result.retour := true;
    ProtectObjetNil([ListeReport]);
    ListeReport.Clear;
    FiltrageDataSet(Ta_H_Tva_Report,'ID_Declaration = '+IntTostr(id_declaration));
    if Ta_H_Tva_Report.RecordCount = 0 then
      begin
       Abort;
      end;

    if Ta_H_Tva_Report.RecordCount > 0 then
      begin
        Ta_H_Tva_Report.First;
        while not Ta_H_Tva_Report.EOF do
         begin
           new(Solde_A_Traiter);
           Solde_A_Traiter.Compte := Ta_H_Tva_Report.findField('Compte').AsString;
           Solde_A_Traiter.Total.SoldeFin := Ta_H_Tva_Report.findField('Solde').AsCurrency;
           Solde_A_Traiter.Total.SoldeDebitCreditFin := Ta_H_Tva_Report.findField('SensCredit').AsBoolean;
           Solde_A_Traiter.ATraiter := Ta_H_Tva_Report.findField('ATraiter').AsBoolean;
           Solde_A_Traiter.Code := Ta_H_Tva_Report.findField('Code_Choix').AsInteger;
           listeReport.Add(Solde_A_Traiter);
           Ta_H_Tva_Report.Next;
         end;
      end;
  except
    Result.retour := false;
    //ListeReport:=nil;
    //abort;
  end;
  finally
    DeFiltrageDataSet(Ta_H_Tva_Report);
  end;
End;

function TDMTmTVA.Vide_Ta_H_Tva_Report(id_Declaration:integer):TExceptLGR;
Begin
  try
    try
      Result.retour := true;
      TableGereStartTransaction(Ta_H_Tva_Report);
      FiltrageDataSet(Ta_H_Tva_Report,'ID_Declaration = '+IntTostr(id_declaration));
      while Ta_H_Tva_Report.RecordCount >0 do begin
        Ta_H_Tva_Report.Delete;
      end;
      TableGereCommit(Ta_H_Tva_Report);
    except
      TableGereRollBack(Ta_H_Tva_Report);
      Result.retour := false;
      abort;
    end;
  finally
    DeFiltrageDataSet(Ta_H_Tva_Report);
  end;
End;

Function TDMTmTVA.Compare_Ta_H_Tva_Report(ListeReport:Tlist;id_declaration:integer):TExceptLGR;
var
ListeReportTmp:TList;
i:integer;
Begin
  try
    try
Initialise_ExceptLGR(result);
      Result.retour := true;
      ProtectObjetNil([ListeReport]);
      ListeReportTmp:=TList.Create;
      if not Recup_Ta_H_Tva_Report(ListeReportTmp,id_declaration).retour then
        begin
         abort;
        end
       else
        begin  // Comparaison
          for i:=0 to ListeReport.Count-1 do
            begin
             if PSolde_A_Traiter(ListeReport.Items[i])^.Compte <> PSolde_A_Traiter(ListeReportTmp.Items[i])^.Compte then
                    raise ExceptLGR.Create('',1,False,mtError,Result);
             if PSolde_A_Traiter(ListeReport.Items[i])^.Total.SoldeFin <> PSolde_A_Traiter(ListeReportTmp.Items[i])^.Total.SoldeFin then
                    raise ExceptLGR.Create('',2,False,mtError,Result);
             if PSolde_A_Traiter(ListeReport.Items[i])^.Total.SoldeDebitCreditFin <> PSolde_A_Traiter(ListeReportTmp.Items[i])^.Total.SoldeDebitCreditFin then
                    raise ExceptLGR.Create('',3,False,mtError,Result);
//             if PSolde_A_Traiter(ListeReport.Items[i])^.ATraiter <> PSolde_A_Traiter(ListeReportTmp.Items[i])^.ATraiter then
//                    raise ExceptLGR.Create('',4,False,mtError,Result);
//             if PSolde_A_Traiter(ListeReport.Items[i])^.Code <> PSolde_A_Traiter(ListeReportTmp.Items[i])^.Code then
//                    raise ExceptLGR.Create('',5,False,mtError,Result);
            end;
        end;
    except
       Result.retour := False;
    end;
  finally
   ListeReportTmp.Free;
  end;
End;

function TDMTmTVA.Affect_Ta_H_Tva_Fin(RSolde_A_Decl:PSolde_A_Declarer;id_declaration:integer):TExceptLGR;
var
i:integer;
Begin
  try
    if RSolde_A_Decl = nil then
      Begin
       Showmessage('RSolde_A_Decl est nil !');
       abort;
      End;
       TableGereStartTransaction(Ta_H_Tva_Fin);
       // Traitement Calcul
       Ta_H_Tva_Fin.AppendRecord([MaxId_Query(Ta_H_Tva_Fin,'id'),
                                  id_declaration,
                                  C_Calcul,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Compte,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Total.Solde,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.SensSolde,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Retour]);
       // Traitement A_Payer
       Ta_H_Tva_Fin.AppendRecord([MaxId_Query(Ta_H_Tva_Fin,'id'),
                                  id_declaration,
                                  C_APayer,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Compte,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Total.Solde,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.APayer.SensSolde,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Retour]);
       // Traitement Report
       Ta_H_Tva_Fin.AppendRecord([MaxId_Query(Ta_H_Tva_Fin,'id'),
                                  id_declaration,
                                  C_Report,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Report.Compte,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Report.Total.Solde,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Report.SensSolde,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Report.Retour]);
       // Traitement Remboursement
       Ta_H_Tva_Fin.AppendRecord([MaxId_Query(Ta_H_Tva_Fin,'id'),
                                  id_declaration,
                                  C_Remboursement,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Compte,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Total.Solde,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.SensSolde,
                                  PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Retour]);
    TableGereCommit(Ta_H_Tva_Fin);
  except
    TableGereRollBack(Ta_H_Tva_Fin);
    abort;
  end;

End;

function TDMTmTVA.Recup_Ta_H_Tva_Fin(Var RSolde_A_Decl:PSolde_A_Declarer;id_declaration:integer):TExceptLGR;
Begin
try
  try
    result.retour:=True;
    if RSolde_A_Decl = nil then
      Begin
       Showmessage('RSolde_A_Decl est nil !');
       abort;
      End;
    FiltrageDataSet(Ta_H_Tva_Fin,'ID_Declaration = '+IntTostr(id_declaration));
    if Ta_H_Tva_Fin.RecordCount = 0 then
     Begin
      abort;
     End;

    if Ta_H_Tva_Fin.RecordCount > 0 then
     Begin//si historique rempli
      Ta_H_Tva_Fin.First;
      while Not Ta_H_Tva_Fin.EOF do
        begin
          case Ta_H_Tva_Fin.FindField('TypeSolde').AsInteger of
               // Traitement Calcul
             C_Calcul:Begin
                       PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Compte :=Ta_H_Tva_Fin.FindField('Compte').AsString;
                       PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Total.Solde := Ta_H_Tva_Fin.FindField('Total').AsCurrency;
                       PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.SensSolde := Ta_H_Tva_Fin.FindField('SensCredit').AsInteger;
                       PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Retour := Ta_H_Tva_Fin.FindField('ATraiter').AsBoolean;

                      End;
               // Traitement A_Payer
             C_APayer:Begin
                       PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Compte:=Ta_H_Tva_Fin.FindField('Compte').AsString;
                       PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Total.Solde:= Ta_H_Tva_Fin.FindField('Total').AsCurrency;
                       PSolde_A_Declarer(RSolde_A_Decl)^.APayer.SensSolde:= Ta_H_Tva_Fin.FindField('SensCredit').AsInteger;
                       PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Retour:= Ta_H_Tva_Fin.FindField('ATraiter').AsBoolean;
                      End;
              // Traitement Report
             C_Report:Begin
                       PSolde_A_Declarer(RSolde_A_Decl)^.Report.Compte:=Ta_H_Tva_Fin.FindField('Compte').AsString;
                       PSolde_A_Declarer(RSolde_A_Decl)^.Report.Total.Solde:= Ta_H_Tva_Fin.FindField('Total').AsCurrency;
                       PSolde_A_Declarer(RSolde_A_Decl)^.Report.SensSolde:= Ta_H_Tva_Fin.FindField('SensCredit').AsInteger;
                       PSolde_A_Declarer(RSolde_A_Decl)^.Report.Retour:= Ta_H_Tva_Fin.FindField('ATraiter').AsBoolean;

                      End;
              // Traitement Remboursement
             C_Remboursement:Begin
                               PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Compte:=Ta_H_Tva_Fin.FindField('Compte').AsString;
                               PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Total.Solde:= Ta_H_Tva_Fin.FindField('Total').AsCurrency;
                               PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.SensSolde:= Ta_H_Tva_Fin.FindField('SensCredit').AsInteger;
                               PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Retour:= Ta_H_Tva_Fin.FindField('ATraiter').AsBoolean;
                             End;
          end;//fin du case
        Ta_H_Tva_Fin.next;
        end;//fin du while
     End;//fin si historique rempli
  except
   //RSolde_A_Decl := nil;
   result.retour:=false;
   //abort;
  end;
  finally
    DeFiltrageDataSet(Ta_H_Tva_Fin);
  end;
End;

function TDMTmTVA.Vide_Ta_H_Tva_Fin(id_Declaration:integer):TExceptLGR;
Begin
  try
    try
      Result.retour := true;
      TableGereStartTransaction(Ta_H_Tva_Fin);
      FiltrageDataSet(Ta_H_Tva_Fin,'ID_Declaration = '+IntTostr(id_declaration));
      while Ta_H_Tva_Fin.RecordCount >0 do begin
        Ta_H_Tva_Fin.Delete;
      end;
      TableGereCommit(Ta_H_Tva_Fin);
    except
      TableGereRollBack(Ta_H_Tva_Fin);
      Result.retour := false;
      abort;
    end;
  finally
    DeFiltrageDataSet(Ta_H_Tva_Fin);
  end;
End;

Function TDMTmTVA.Compare_Ta_H_Tva_Fin(RSolde_A_Decl:PSolde_A_Declarer;id_declaration:integer):TExceptLGR;
var
RSolde_A_DeclTmp:PSolde_A_Declarer;
Begin
  try
    try
Initialise_ExceptLGR(result);
      new(RSolde_A_DeclTmp);
      Result.retour := true;
      if RSolde_A_Decl = nil then
        Begin
         Showmessage('RSolde_A_Decl est nil !');
         abort;
        End;
      if not Recup_Ta_H_Tva_Fin(RSolde_A_DeclTmp,id_declaration).retour then
        begin
         abort;
        end
       else
        begin  // Comparaison
          // Traitement Calcul
          if PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Compte <> PSolde_A_Declarer(RSolde_A_DeclTmp)^.Calcul.Compte then
                    raise ExceptLGR.Create('',10,False,mtError,Result);
          if arrondi(PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Total.Solde,2) <> arrondi(PSolde_A_Declarer(RSolde_A_DeclTmp)^.Calcul.Total.Solde,2) then
                    raise ExceptLGR.Create('',11,False,mtError,Result);
          if PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.SensSolde <> PSolde_A_Declarer(RSolde_A_DeclTmp)^.Calcul.SensSolde then
                    raise ExceptLGR.Create('',12,False,mtError,Result);
//          PSolde_A_Declarer(RSolde_A_Decl)^.Calcul.Retour := Ta_H_Tva_Fin.FindField('ATraiter').AsBoolean;
          // Traitement A_Payer
          if PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Compte <> PSolde_A_Declarer(RSolde_A_DeclTmp)^.APayer.Compte then
                    raise ExceptLGR.Create('',20,False,mtError,Result);
//          if arrondi(PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Total.Solde,2) <> arrondi(PSolde_A_Declarer(RSolde_A_DeclTmp)^.APayer.Total.Solde,2) then
//                    raise ExceptLGR.Create('',21,False,mtError,Result);
          if PSolde_A_Declarer(RSolde_A_Decl)^.APayer.SensSolde <> PSolde_A_Declarer(RSolde_A_DeclTmp)^.APayer.SensSolde then
                    raise ExceptLGR.Create('',22,False,mtError,Result);
//          PSolde_A_Declarer(RSolde_A_Decl)^.APayer.Retour:= Ta_H_Tva_Fin.FindField('ATraiter').AsBoolean;
          // Traitement Report
          if PSolde_A_Declarer(RSolde_A_Decl)^.Report.Compte <> PSolde_A_Declarer(RSolde_A_DeclTmp)^.Report.Compte then
                    raise ExceptLGR.Create('',30,False,mtError,Result);
//          if arrondi(PSolde_A_Declarer(RSolde_A_Decl)^.Report.Total.Solde,2) <>  arrondi(PSolde_A_Declarer(RSolde_A_DeclTmp)^.Report.Total.Solde,2) then
//                    raise ExceptLGR.Create('',31,False,mtError,Result);
          if PSolde_A_Declarer(RSolde_A_Decl)^.Report.SensSolde <> PSolde_A_Declarer(RSolde_A_DeclTmp)^.Report.SensSolde then
                    raise ExceptLGR.Create('',32,False,mtError,Result);
//          PSolde_A_Declarer(RSolde_A_Decl)^.Report.Retour:= Ta_H_Tva_Fin.FindField('ATraiter').AsBoolean;
          // Traitement Remboursement
          if PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Compte <> PSolde_A_Declarer(RSolde_A_DeclTmp)^.Remboursement.Compte then
                    raise ExceptLGR.Create('',40,False,mtError,Result);
//          if arrondi(PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Total.Solde,2) <> arrondi(PSolde_A_Declarer(RSolde_A_DeclTmp)^.Remboursement.Total.Solde,2) then
//                    raise ExceptLGR.Create('',41,False,mtError,Result);
          if PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.SensSolde <> PSolde_A_Declarer(RSolde_A_DeclTmp)^.Remboursement.SensSolde then
                    raise ExceptLGR.Create('',42,False,mtError,Result);
//          PSolde_A_Declarer(RSolde_A_Decl)^.Remboursement.Retour:= Ta_H_Tva_Fin.FindField('ATraiter').AsBoolean;
        end;
    except
       Result.retour := False;
    end;
  finally

  end;
End;


Function TDMTmTVA.PieceTvaExisteDansPeriode(DateDeb,DateFin:tdatetime):TExceptLGR;
Begin
//

End;


Function AfficheListeHistoriqueDeclarationTVA:TParamHistorique;
var
ParamAffichage:TParamAffichage;
List1:TStringList;
creationDatamodule:boolean;
RetourVisuListe:TRetourViewListe;
begin
try
List1:=TStringList.Create;
creationDatamodule:=false;
if DMTmTVA= nil then
begin
  DMTmTVA:=TDMTmTVA.Create(application.MainForm);
  creationDatamodule:=true;
end;
DMTmTVA.QuListeHistoriqueDeclaration.OnCalcFields:=nil;
DMTmTVA.QuListeHistoriqueDeclaration.close;
DMTmTVA.QuListeHistoriqueDeclaration.SQL.Clear;
DMTmTVA.QuListeHistoriqueDeclaration.SQL.Add('select distinct id_declaration,debut_Periode,fin_Periode,reference_od');
DMTmTVA.QuListeHistoriqueDeclaration.SQL.Add('from H_Piecetva.db');
//DMTmTVA.QuListeHistoriqueDeclaration.SQL.Add('from H_tva.db');
DMTmTVA.QuListeHistoriqueDeclaration.Open;

List1:=ChampTableVersListeEx(['id_Declaration','debut_Periode','fin_Periode','reference_od'],DMTmTVA.QuListeHistoriqueDeclaration,';',true);
Initialise_TParamAffichage(ParamAffichage);
ParamAffichage.AffichModal := true;
ParamAffichage.Titre:='Liste des historiques de déclaration de TVA';
result.Periode.Retour:=List1.Count<>0;
if result.Periode.Retour then
  begin
     if VisuListeView=nil then VisuListeView:=TVisuListeView.Create(application.MainForm);
     ParamAffichage.EventButtonDetailClick:=VisuListeView.BtnEnregistrerClick;
     ParamAffichage.EventButtonValiderClick:=nil;
     ParamAffichage.EventListViewDbleClick:=VisuListeView.BtnEnregistrerClick;
     ParamAffichage.EventSyntheseClick:=nil;
     VisuListeView.PopupMenu1.OnPopup:=DMTmTVA.PopupMenu1Popup;
     RetourVisuListe:=AfficheVisuListView(ParamAffichage,['Declaration','debut de Periode','fin de Periode','reference pièce'],
                                      [200,200,200,200],
                                      [List1],
                                      [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                      [1],
                                      [4],[2,3]);
     result.Periode.Retour:=RetourVisuListe.Retour;
     if RetourVisuListe.Retour then
        begin
           result.Id_Decl:=StrToInt_Lgr(RetourVisuListe.VisuListeView.ItemCourantValeurCol(0));
           result.Periode.DateDeb:=StrToDate_Lgr(dateInfos_Str(RetourVisuListe.VisuListeView.ItemCourantValeurCol(1)));
           result.Periode.DateFin:=StrToDate_Lgr(dateInfos_Str(RetourVisuListe.VisuListeView.ItemCourantValeurCol(2)));
           AfficheDetailHistoriqueDeclarationTVA(result);
        end;
  End;
finally
  if list1<>nil then list1.free;
  if creationDatamodule then
  begin
//    if DMTmTVA<>nil then
//      DMTmTVA.free;
  end;
end;//fin du try finally
End;

Function AfficheDetailHistoriqueDeclarationTVA(ParamHistorique:TParamHistorique):boolean;
var
ParamAffichage:TParamAffichage;
List1:TStringList;
i:integer;
chemin:string;
begin
try
List1:=TStringList.Create;
with DMTmTVA.QuDetailHistoriqueDeclaration do
 Begin
  close;
  SQL.Clear;
//  SQL.add('Select E.*,P.Reference,H.debut_Periode,H.fin_Periode,');
  SQL.add('Select E.libelle,E.Tvataux,E.tvacode,E.tvaType,E.compte,E.montant_tva,E.DebitSaisie,E.creditSaisie,P.Reference,H.debut_Periode,H.fin_Periode,');
  SQL.add('(select TvaCode from TvaCode T where T.compte=E.compte)as TvaCodeRecup,');
  SQL.add('H.En_Attente,H.Deverrouillable,H.reference_od,H.Date_Tva,H.Part_Declaree,H.montanttva,H.HtDeclare');
  SQL.add('from H_Tva.db H');
  SQL.add('join Ecriture E on (E.id=H.id_ecriture)');
  SQL.add('join Piece P on (P.id=H.id_piece)');
  if ParamHistorique.Id_Decl<>-1 then
    begin
      SQL.add('and ((E.compte in (select distinct compte from TvaCode) and H.id_declaration =:id)');
      SQL.add('or (H.id_declaration =:id))');
      SQL.add(' union');
      SQL.add(' select '''+LibelleRegulTva+''',Taux,CodeCompensation,''E '','''+StringVideDixCaractere+''',sum(montanttva)as montanttva,0,0,'''+StringVideDixCaractere+''',debut_Periode,fin_Periode,');
      SQL.add(' '''+StringVideDixCaractere+''',false,false,'''+StringVideDixCaractere+''',Date_Tva,1,sum(montanttva)as montanttva,cast(sum(HtDeclare) as Money) from h_tva');
      SQL.add('where divers is not null and id_declaration =:id');
      SQL.add('Group by CodeCompensation,Date_Tva,debut_Periode,fin_Periode,taux');
      ParamByName('id').asinteger:=ParamHistorique.Id_Decl;
    end
  else
    begin
      SQL.add('and ((E.compte in (select distinct compte from TvaCode) and debut_periode =:deb and Fin_periode=:Fin)');
      SQL.add('or(debut_periode =:deb and Fin_periode=:Fin))');
      SQL.add(' union');
      SQL.add(' select '''+LibelleRegulTva+''',Taux,CodeCompensation,''E '','''+StringVideDixCaractere+''',sum(montanttva)as montanttva,0,0,'''+StringVideDixCaractere+''',debut_Periode,fin_Periode,');
      SQL.add(' '''+StringVideDixCaractere+''',false,false,'''+StringVideDixCaractere+''',Date_Tva,1,sum(montanttva)as montanttva,cast(sum(HtDeclare) as Money) from h_tva');
      SQL.add(' where divers is not null and id_declaration=-2');
      SQL.add('Group by CodeCompensation,Date_Tva,debut_Periode,fin_Periode,Taux');
      ParamByName('Deb').asdatetime:=ParamHistorique.Periode.DateDeb;
      ParamByName('Fin').asdatetime:=ParamHistorique.Periode.DateFin;
    end;
  Open;
 End;
List1:=ChampTableVersListeEx(['TvaCodeCalc','TvaTypeCalc','Part_Declaree','Date_Tva','Reference','Compte','Libelle','En_Attente','HTDeclareCalc','MtTvaCalc','TvaTaux'],DMTmTVA.QudetailHistoriqueDeclaration,';',true);
        for i:=0 to List1.Count-1 do
          begin
            if str_getstringelement(list1.Strings[i],4,';')=C_DateFinInfini then
                 ParamAffichage.InfosSup:='Les dates Tva "'+C_DateFinInfini+'" concernent les lignes dont la date de déclaration '+RetourChariotSimple+'est inconnue à ce jour. '+RetourChariotSimple+'Ex : Tva sur encaissement d''une pièce non réglée !!';
            if str_getstringelement(list1.Strings[i],8,';')='Vrai' then
              begin
                 list1.Strings[i]:=str_Setstringelement(list1.Strings[i],8,';','Non');
              end
            else
            if str_getstringelement(list1.Strings[i],8,';')='Faux' then
              begin
                 list1.Strings[i]:=str_Setstringelement(list1.Strings[i],8,';','Oui');
              end;
          end;

result:=list1.count<>0;
if result then
  Begin
     if VisuListeView=nil then VisuListeView:=TVisuListeView.Create(application.MainForm);
    Initialise_TParamAffichage(ParamAffichage);
     ParamAffichage.AffichModal := true;
     ParamAffichage.Titre:='Historique de la déclaration n° : '+inttostr(ParamHistorique.Id_Decl) ;
     ParamAffichage.TitrePetit:='  DU '+datetostr(ParamHistorique.Periode.DateDeb)+' AU '+datetostr(ParamHistorique.Periode.DateFin);
     if FileExists(e.RepertoireExportation+'')then
         ParamAffichage.EventButtonDetailClick:=DMTmTVA.Visualisation_DeclarationTVAClick;
     ParamAffichage.EventButtonDetailClick:=DMTmTVA.Visualisation_DeclarationTVAClick;
     ParamAffichage.EventButtonValiderClick:=nil;
     ParamAffichage.EventListViewDbleClick:=DMTmTVA.Visualisation_DeclarationTVAClick;
     chemin:=IncludeTrailingPathDelimiter(e.RepertoireExportDossier)
       +'Synt-TVA_'+DateInfos(ParamHistorique.Periode.DateDeb,'-',true).DateStrFormat+'_au_'+
       DateInfos(ParamHistorique.Periode.DateFin,'-',true).DateStrFormat+'_'+E.NomDossier + E.NomExo + '.Txt';
     if FileExists(chemin)then
        begin
          ParamAffichage.EventSyntheseClick:=DMTmTVA.Afficherlasynthse1Click;
        end;
     DMTmTVA.periode:=ParamHistorique.Periode;
     result:=AfficheVisuListView(ParamAffichage,['Code','Type','Part','Date Tva','Piece','Compte','Libellé','Declare','HT Déclaré','Mt Tva','Taux'],
                                        [40,20,30,70,70,70,100,60,70,70,50],
                                        [List1],
                                        [taLeftJustify,taLeftJustify,taRightJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,taRightJustify],
                                        [1..3,5..8],
                                        [9..11],[4]).Retour;
  End;
finally
//  FreeAndNil(list1);
  LibereObjet(TObject(list1));
  ParamAffichage.EventButtonDetailClick:=nil;
end;//fin du try finally
End;


Function AffichDetailDeclarationTVA(DetailTVAAffich:TDetailTVAAffich):boolean;
var
ParamAffichage:TParamAffichage;
List1:TStringList;
listeCodeTmp:TStringList;
filtre:Tfiltre;
Creationfiltre:string;
stringTmp:string;
TypeEdition:string;
Titre,Titre2:string;
i:integer;
begin
try
DMTmTVA.DetailTVAAffichGlobal:=DetailTVAAffich;
List1:=TStringList.Create;
listeCodeTmp:=TStringList.Create;
with DMTmTVA.QuDec_Tva do
 Begin
  filtre.filtre:=Filter;
  filtre.filtrer:=Filtered;
  close;
  Open;
 End;
 titre:='';
 Titre2:='';
 TypeEdition:=inttostr(DMTmTVA.DetailTVAAffichGlobal.En_Attente)+inttostr(DMTmTVA.DetailTVAAffichGlobal.TypeTvaAffich);
 //on traite le parametre "En_Attent"
 case DMTmTVA.DetailTVAAffichGlobal.En_Attente of
  Rien:;
  En_attente: begin
                  Creationfiltre:= CreeFiltreET(['En_Attente'],['true']);
              end;
  Pas_En_Attente:begin
                  Creationfiltre:= CreeFiltreET(['En_Attente'],['false']);
                 end;
 end;//fin du case En_attente
 //on traite le paramètre "TypeTvaAffich"
 case DMTmTVA.DetailTVAAffichGlobal.TypeTvaAffich of
   TvaSurD:Begin
             stringTmp:='D';
             if not empty(Creationfiltre) then
               Creationfiltre:=Creationfiltre+ 'and ('+CreeFiltreOu('TvaType',[stringTmp])+')'
             else
               Creationfiltre:=CreeFiltreOu('TvaType',[stringTmp]);
           End;
   TvaSurE:Begin
             stringTmp:='E';
             if not empty(Creationfiltre) then
               Creationfiltre:=Creationfiltre+ 'and ('+CreeFiltreOu('TvaType',[stringTmp])+')'
             else
               Creationfiltre:=CreeFiltreOu('TvaType',[stringTmp]);
           End;
   TvaSurE_D:Begin
             End;
 end;//fin du case
//on traite la liste des codes tva à afficher
if ((DMTmTVA.DetailTVAAffichGlobal.ListeCodes<>nil)and(DMTmTVA.DetailTVAAffichGlobal.ListeCodes.count<>0)) then
  begin//si liste des codes remplie
    for i:=0 to DMTmTVA.DetailTVAAffichGlobal.ListeCodes.count-1 do
      listeCodeTmp.add(str_getstringelement(DMTmTVA.DetailTVAAffichGlobal.ListeCodes.Strings[i],1,';'));
    if not empty(Creationfiltre)then
      Creationfiltre:=Creationfiltre+ 'and ('+CreeFiltreOu('TvaCode',[listeCodeTmp])+')'
    else
      Creationfiltre:=CreeFiltreou('TvaCode',[listeCodeTmp]);
    FiltrageDataSet(DMTmTVA.QuDec_Tva,Creationfiltre);
  end//fin si liste des codes remplie
else
  Begin
     if not empty (Creationfiltre)then
       FiltrageDataSet(DMTmTVA.QuDec_Tva,Creationfiltre)
     else
       DeFiltrageDataSet(DMTmTVA.QuDec_Tva);
  End;
//EditionJournauxTvaL(C_EditionSimple,false,DetailTVAAffich.ListeCodes,DMTmTVA.QuDec_Tva);
    Initialise_TParamAffichage(ParamAffichage);

        ParamAffichage.AffichModal := true;
        ParamAffichage.EventButtonDetailClick:= DMTmTVA.Visualisation_DeclarationTVAClick;
        ParamAffichage.EventButtonValiderClick:=DMTmTVA.Visualisation_DeclarationTVAClick ;
        ParamAffichage.EventListViewDbleClick:=DMTmTVA.Visualisation_DeclarationTVAClick ;
        ParamAffichage.EventButtonImprimerClick:=DMTmTVA.Impression_DeclarationTVAClick;
        ParamAffichage.TitrePetit:='DU '+datetostr(DMTmTVA.DetailTVAAffichGlobal.Periode.DateDeb)+' AU '+datetostr(DMTmTVA.DetailTVAAffichGlobal.Periode.DateFin);
        List1:=ChampTableVersListeEx(['TvaCode','TvaType','Part_declaration','TvaDate','Reference','CompteHT','Libelle','En_Attente','HT_Declare','TvaMontantDebit','TvaMontantCredit','Taux'],DMTmTVA.QuDec_Tva,';',true);
//        List1:=ChampTableVersListeEx(['TvaCode','TvaType','Part_declaration','TvaDate','Reference','CompteHT','Libelle','En_Attente','HT_DeclareCalc','TvaMontantDebit','TvaMontantCredit','Taux'],DMTmTVA.QuDec_Tva,';',true);

        for i:=0 to List1.Count-1 do
          begin
            if str_getstringelement(list1.Strings[i],4,';')=C_DateFinInfini then
                 ParamAffichage.InfosSup:='Les dates Tva "'+C_DateFinInfini+'" concernent les lignes dont la date de déclaration '+RetourChariotSimple+'est inconnue à ce jour. '+RetourChariotSimple+'Ex : Tva sur encaissement d''une pièce non réglée !!';
            if str_getstringelement(list1.Strings[i],8,';')='Vrai' then
              begin
                 list1.Strings[i]:=str_Setstringelement(list1.Strings[i],8,';','Non');
              end
            else
            if str_getstringelement(list1.Strings[i],8,';')='Faux' then
              begin
                 list1.Strings[i]:=str_Setstringelement(list1.Strings[i],8,';','Oui');
              end;
          end;
        if ((DMTmTVA.DetailTVAAffichGlobal.ListeCodes<>nil)and(DMTmTVA.DetailTVAAffichGlobal.ListeCodes.count=1)) then
           ParamAffichage.Titre:='Détail code : '+str_getstringelement(DMTmTVA.DetailTVAAffichGlobal.ListeCodes.Strings[0],1,';')+' - ' +Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[str_getstringelement(DMTmTVA.DetailTVAAffichGlobal.ListeCodes.Strings[0],1,';')]).Libelle
        else
          ParamAffichage.Titre:='Détail de Tous les journaux TVA ';
        result:=AfficheVisuListView(ParamAffichage,['Code','Type','Part','Date Tva','Piece','Compte','Libellé','Declare','HT Déclaré','Tva Débit','Tva Crédit','Taux'],
                                            [40,20,30,70,70,70,100,60,70,70,70,50],
                                            [List1],
                                            [taLeftJustify,taLeftJustify,taRightJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,taRightJustify,taRightJustify],
                                            [1..3,5..8],
                                            [9..12],[4]).Retour;

finally
  LibereObjet(TObject(list1));
//  FreeAndNil(list1);
  ParamAffichage.EventButtonDetailClick:=nil;
  ParamAffichage.EventButtonImprimerClick:=nil;
  if ((filtre.filtrer)and(not empty(filtre.filtre))) then
    FiltrageDataSet(DMTmTVA.QuDec_Tva,filtre.filtre)
  else
    DeFiltrageDataSet(DMTmTVA.QuDec_Tva);
end;//fin du try finally
End;


Function AffichDeclarationTVASurPeriode(DetailTVAAffich:TDetailTVAAffich):boolean;
var
ParamHistorique:TParamHistorique;
begin
//EditionJournauxTvaL(C_EditionSimple,false,DetailTVAAffich.ListeCodes,DMTmTVA.QuDec_Tva);
initialise_Tparamhistorique(ParamHistorique);
try
 if DetailTVAAffich.ForceHistorique then
   Begin//forcer l'affichage de l'historique s'il existe ou la liste des historiques
      ParamHistorique.Periode:=DetailTVAAffich.Periode;
      //regarder s'il existe une déclaration dans cette période
      if not AfficheDetailHistoriqueDeclarationTVA(ParamHistorique) then
        //sinon, afficher la liste des historiques
         ParamHistorique:=AfficheListeHistoriqueDeclarationTVA;
   End
 else
   Begin// forcer le calcul de la période ou l'affichage du calcul en cours
     case DetailTVAAffich.Calculer of
       0:Begin //afficher le calcul en cours
           AffichDetailDeclarationTVA(DetailTVAAffich);
         End;
       1:Begin //calculer
           if not CalculDeclarationTva(DetailTVAAffich.Periode.DateDeb,DetailTVAAffich.Periode.DateFin) then
             abort;
           AffichDetailDeclarationTVA(DetailTVAAffich);
         End;
     end;//fin du case calculer
   End;
except
  showmessage('Erreur Interne lors de l"affichage de la déclaration');
end;//fin du try finally
End;


procedure TDMTmTVA.Visualisation_DeclarationTVAClick(Sender: TObject);
begin
try//finally
try//except
e.AutrePeriode:=true;
e.PeriodeAutre.DateDeb:=0;
e.PeriodeAutre.DateFin:=strtodate(C_DateFinInfini);
e.PeriodeAutreImpression.Retour:=true;
E.PeriodeAutreImpression.DateDeb:=0;
E.PeriodeAutreImpression.DateFin:=e.PeriodeAutre.DateFin;
if DetailEcritureCompte(VisuListeView.ItemCourantValeurCol(5),False,False) then
  begin
      if DMEcritures.QueryEcrCompte.Locate('Reference',VisuListeView.ItemCourantValeurCol(4),[]) then
        PieceEcritureCompte;
  end;
except
  showmessage('Pas de détail disponible');
end;
finally
e.AutrePeriode:=false;
e.PeriodeAutre.DateDeb:=0;
e.PeriodeAutre.DateFin:=0;
end;//fin finally
end;




procedure VerrouillageDeclaration_Exercice(Fin:Tdatetime);
Begin
if DMTmTVA=nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);
  try
  //Rendre non deverrouillable toutes les déclarations TVA de l'année (soit celles comprisent entre Debut et fin
  //passé en parametre
/////on traite la table H_Tva
        DMTmTVA.QuSupprDerniereDeclaration.Close;
        DMTmTVA.QuSupprDerniereDeclaration.sql.Clear;
        DMTmTVA.QuSupprDerniereDeclaration.sql.Add('Update h_tva set deverrouillable=false where Fin_Periode<=:Fin');
//        DMTmTVA.QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=DMTmTVA.QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime;
        DMTmTVA.QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=fin;
        DMTmTVA.QuSupprDerniereDeclaration.ExecSQL;
///// on traite la table H_PieceTva
        /// champ  " deverrouillable "
        DMTmTVA.QuSupprDerniereDeclaration.Close;
        DMTmTVA.QuSupprDerniereDeclaration.sql.Clear;
        DMTmTVA.QuSupprDerniereDeclaration.sql.Add('Update h_Piecetva set deverrouillable=false where Fin_Periode<=:Fin');
//        DMTmTVA.QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=DMTmTVA.QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime;
        DMTmTVA.QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=fin;
        DMTmTVA.QuSupprDerniereDeclaration.ExecSQL;

        /// champ  " VerrouillageManuel "
        DMTmTVA.QuSupprDerniereDeclaration.Close;
        DMTmTVA.QuSupprDerniereDeclaration.sql.Clear;
        DMTmTVA.QuSupprDerniereDeclaration.sql.Add('Update h_Piecetva set VerrouillageManuel=true where Fin_Periode<=:Fin');
//        DMTmTVA.QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=DMTmTVA.QuMaxFin_Periode.findfield('Fin_Periode').AsDateTime;
        DMTmTVA.QuSupprDerniereDeclaration.ParamByName('Fin').AsDateTime:=fin;
        DMTmTVA.QuSupprDerniereDeclaration.ExecSQL;
  except
    abort;
  end;
end;

Function DeclarationTVATypeOD(DateDeb,DateFin:TDate):Boolean;
var
Tva_Attente:boolean;
id:integer;
ExceptLGR_:TExceptLGR;
accept:boolean;
Begin
try//finally
   try//except
   try
   if not DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(DateDeb,DateFin,false).retour then
       //raise ExceptLGR.Create('Ces dates font déjà partie d''une période déclarée !',0,true,mtError,ExceptLGR_);
   except
     // pour ne pas perpétuer l'exception
   end;
   if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);

     DMTmTVA.QuParcoursEcritureTypeOD.Close;
     DMTmTVA.QuParcoursEcritureTypeOD.ParamByName('DAteFin').AsDate:=DateFin;
     DMTmTVA.QuParcoursEcritureTypeOD.Open;
     DMTmTVA.QuParcoursEcritureTypeOD.first;

      while not(DMTmTVA.QuParcoursEcritureTypeOD.eof) do
        Begin // Remplissage Ta_Dec
        Tva_Attente:=false;
          Accept := true;
          if DMTmTVA.QuVerifAcceptTva.Locate('ID_Ecriture',DMTmTVA.QuParcoursEcritureTypeOD.FindField('Id').AsInteger,[]) then
            accept:=((DMTmTVA.QuVerifAcceptTvamontanttva.AsCurrency<DMTmTVA.QuVerifAcceptTvamontant_tva.AsCurrency)and(DMTmTVA.QuVerifAcceptTvaPartDeclaree.AsFloat < 1.00));
            if not accept then
              accept := not DMTmTVA.QueryTvaDeclare.Locate('id_ecriture',DMTmTVA.QuParcoursEcritureTypeOD.FindField('Id').AsInteger,[]);
            if accept then
              begin
                   begin//s'il y a de la tva à déclarer
                   id:=DMTmTVA.TaDec_Tva.RecordCount+1;
                   DMTmTVA.TaDec_Tva.AppendRecord([id,
                         DMTmTVA.QuParcoursEcritureTypeOD.FindField('Id_Piece').AsInteger,
                         DMTmTVA.QuParcoursEcritureTypeOD.FindField('Id').AsInteger,
                         DMTmTVA.QuParcoursEcritureTypeOD.FindField('TvaCodeRecup').AsString,
                         'D',
                         DMTmTVA.QuParcoursEcritureTypeOD.FindField('TvaDateCalc').AsDateTime,
        //                 DMTmTVA.QuParcoursEcritureTypeODTvaDebit.ascurrency,
        //                 DMTmTVA.QuParcoursEcritureTypeODTvaCredit.ascurrency,
                         arrondi(DMTmTVA.QuParcoursEcritureTypeODTvaDebit.ascurrency,2),
                         arrondi(DMTmTVA.QuParcoursEcritureTypeODTvaCredit.ascurrency,2),
                         Tva_Attente,1]);
                   DMTmTVA.TaDec_Tva.FlushBuffers;
                   end;//fin s'il y a de la tva à déclarer
               end;
           DMTmTVA.QuParcoursEcritureTypeOD.Next;
        End;

//     DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.Close;
//     DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.ParamByName('DAteFin').AsDate:=DateFin;
//     DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.Open;
//     DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.first;
//
//      while not(DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.eof) do
//        Begin // Remplissage Ta_Dec
//        Tva_Attente:=true;
//           begin//s'il y a de la tva à déclarer
//           id:=DMTmTVA.TaDec_Tva.RecordCount+1;
//           DMTmTVA.TaDec_Tva.AppendRecord([id,
//                 DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.FindField('Id_Piece').AsInteger,
//                 DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.FindField('Id').AsInteger,
//                 DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.FindField('TvaCodeRecup').AsString,
//                 'D',
//                 DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.FindField('TvaDateCalc').AsDateTime,
//                 arrondi(DMTmTVA.QuParcoursEcritureTypeOD_EnAttenteTvaDebit.ascurrency,2),
//                 arrondi(DMTmTVA.QuParcoursEcritureTypeOD_EnAttenteTvaCredit.ascurrency,2),
//                 Tva_Attente,1]);
//           DMTmTVA.TaDec_Tva.FlushBuffers;
//           end;//fin s'il y a de la tva à déclarer
//           DMTmTVA.QuParcoursEcritureTypeOD_EnAttente.Next;
//        End;

   except
     abort;
   end;//fin du try except
finally
//DMTmTVA.QuDec_Tva.close;
DMTmTVA.PrepareQuDec_tva(DateFin);
DMTmTVA.QuDec_Tva.open;
end;//fin du try finally
End;




procedure TDMTmTVA.QuParcoursEcritureTypeODCalcFields(DataSet: TDataSet);
begin
//Dans les od, je travail sur DebitSaisie et CreditSaisie qui sont des champs réels de la table
//et je crée Debit et Credit en champ calculés pour les laisser vide car c'est ceux la qu'on utilise
//dans l'affichage de la synthése tva en tant que montantHt, hors dans les od, il n'y a pas de hors taxe
QuParcoursEcritureTypeODDebit.AsCurrency:=0;
QuParcoursEcritureTypeODCredit.AsCurrency:=0;
if not VerifFNumeric(QuParcoursEcritureTypeODDebitSaisie).VideOUZero then
   QuParcoursEcritureTypeODTvaDebit.AsCurrency:=QuParcoursEcritureTypeODDebitSaisie.AsCurrency
 else
  if not VerifFNumeric(QuParcoursEcritureTypeODCreditSaisie).VideOUZero then
   QuParcoursEcritureTypeODTvaCredit.AsCurrency:=QuParcoursEcritureTypeODCreditSaisie.AsCurrency;
  if ((QuParcoursEcritureTypeODDate.AsDateTime>e.DateFinDeclarationTVA)or(QuParcoursEcritureTypeODDate.AsDateTime=0))then
    QuParcoursEcritureTypeODTvaDateCalc.Asstring:=C_DateFinInfini
  else
    QuParcoursEcritureTypeODTvaDateCalc.AsDateTime:=QuParcoursEcritureTypeODDate.AsDateTime;
end;

procedure TDMTmTVA.QuDetailHistoriqueDeclarationCalcFields(
  DataSet: TDataSet);
begin
if empty(QuDetailHistoriqueDeclarationTvaCode.AsString) then
  Begin
    QuDetailHistoriqueDeclarationTvaCodeCalc.AsString:=QuDetailHistoriqueDeclarationTvaCodeRecup.AsString;
    QuDetailHistoriqueDeclarationTvaTypeCalc.AsString:='D';
    QuDetailHistoriqueDeclarationMtTvaCalc.Ascurrency:=((QuDetailHistoriqueDeclarationdebitSaisie.ascurrency+QuDetailHistoriqueDeclarationcreditSaisie.ascurrency)*QuDetailHistoriqueDeclarationPart_declaree.ascurrency);
    QuDetailHistoriqueDeclarationHTDeclareCalc.Ascurrency:=0;
  end
else
  Begin
    QuDetailHistoriqueDeclarationTvaCodeCalc.AsString:=QuDetailHistoriqueDeclarationTvaCode.AsString;
    QuDetailHistoriqueDeclarationTvaTypeCalc.AsString:=QuDetailHistoriqueDeclarationTvaType.AsString;
    QuDetailHistoriqueDeclarationmtTvaCalc.Ascurrency:=(QuDetailHistoriqueDeclarationMontant_Tva.ascurrency*QuDetailHistoriqueDeclarationPart_declaree.asfloat);
    QuDetailHistoriqueDeclarationHTDeclareCalc.Ascurrency:=((QuDetailHistoriqueDeclarationdebitSaisie.ascurrency+QuDetailHistoriqueDeclarationcreditSaisie.ascurrency)*QuDetailHistoriqueDeclarationPart_declaree.ascurrency);
  end;
//if Type_version_execution=CT_DEVELOPPEMENT then
//  begin
    QuDetailHistoriqueDeclarationMtTvaCalc.Ascurrency:=QuDetailHistoriqueDeclarationmontanttva.Ascurrency;
    QuDetailHistoriqueDeclarationHTDeclareCalc.Ascurrency:=QuDetailHistoriqueDeclarationHtDeclare.Ascurrency;
//  end;
end;

//procedure TDMTmTVA.QuParcoursEcritureTypeOD_EnAttenteCalcFields(
//  DataSet: TDataSet);
//begin
////Dans les od, je travail sur DebitSaisie et CreditSaisie qui sont des champs réels de la table
////et je crée Debit et Credit en champ calculés pour les laisser vide car c'est ceux la qu'on utilise
////dans l'affichage de la synthése tva en tant que montantHt, hors dans les od, il n'y a pas de hors taxe
//QuParcoursEcritureTypeOD_EnAttenteDebit.AsCurrency:=0;
//QuParcoursEcritureTypeOD_EnAttenteCredit.AsCurrency:=0;
//if not VerifFNumeric(QuParcoursEcritureTypeOD_EnAttenteDebitSaisie).VideOUZero then
//   QuParcoursEcritureTypeOD_EnAttenteTvaDebit.AsCurrency:=QuParcoursEcritureTypeOD_EnAttenteDebitSaisie.AsCurrency
// else
//  if not VerifFNumeric(QuParcoursEcritureTypeOD_EnAttenteCreditSaisie).VideOUZero then
//   QuParcoursEcritureTypeOD_EnAttenteTvaCredit.AsCurrency:=QuParcoursEcritureTypeOD_EnAttenteCreditSaisie.AsCurrency;
//  if ((QuParcoursEcritureTypeOD_EnAttenteDate.AsDateTime>e.DateFinDeclarationTVA)or(QuParcoursEcritureTypeOD_EnAttenteDate.AsDateTime=0)) then
//    QuParcoursEcritureTypeOD_EnAttenteTvaDateCalc.Asstring:=C_DateFinInfini
//  else
//    QuParcoursEcritureTypeOD_EnAttenteTvaDateCalc.AsDateTime:=QuParcoursEcritureTypeOD_EnAttenteDate.AsDateTime;
//
//end;


Function EditionSyntheseTVAL(TypeEdition : integer; DemandePeriode:Boolean;PeriodeParam:TPeriode; CodeTva:TStringList;DataSet:TDataSet;direct:boolean):Boolean;overload;
var
periode:TPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
ListeCodeTVA,ListeCodeTVATmp,ListeTmp,ListeTmp2:TStringList;
ListeEdition:TStringList;
j,k,rang:integer;
StrTmp:String;
LibelleTmp:string;
HTTmp,TVATmp:currency;
totauxbalance:Ttotauxbalance;
solde,Soldearrondi:currency;
// TVA DEDUCTIBLE
TotTVADeductibleL1,TotTVADeductibleL2,TotTVADeductibleL3:currency;
TotHTDeductibleL1,TotHTDeductibleL2,TotHTDeductibleL3:currency;
TotReportL4:currency;
// Tva auto liquidée
TotAutoLiquideL1:currency;
TotTVAautoLiquideL1:currency;
// OPERATION NON IMPOSABLE
TotOpNonImposableL1,TotOpNonImposableL2,TotOpNonImposableL3,TotOpNonImposableL3Bis,TotOpNonImposableL4:currency;
TotalHT,TotalDue,TotalCredit:currency;
ForceAffichage:TForceAffichage;
ParamAffichPeriode:TParamAffichPeriode;
begin
try
    ObjPrn:=TObjetEdition.Create(application.MainForm);
ForceAffichage.Affiche:=false;
ForceAffichage.Force:=false;
TotalDue:=0;
TotalCredit:=0;
TotTVADeductibleL1:=0;
TotTVADeductibleL2:=0;
TotTVADeductibleL3:=0;
TotHTDeductibleL1:=0;
TotHTDeductibleL2:=0;
TotHTDeductibleL3:=0;
TotAutoLiquideL1:=0;
TotTVAautoLiquideL1:=0;
TotReportL4:=0;
// OPERATION NON IMPOSABLE
TotOpNonImposableL1:=0;
TotOpNonImposableL2:=0;
TotOpNonImposableL3:=0;
TotOpNonImposableL4:=0;
LibelleTmp:='';
HTTmp:=0;
TVATmp:=0;
TotalHT:=0;

 if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(Application.MainForm);
///
 if DemandePeriode then
   begin
     try
         DMTmTVA.MAJ_DateDeclarationTVA(Periode.DateDeb,Periode.DateFin);
         e.DateDebutDeclarationTVA:=Periode.DateDeb;
         e.DateFinDeclarationTVA:=Periode.DateFin;
         if Choix_Periode = nil then Choix_Periode:=TChoix_Periode.Create(Application.MainForm);
         Choix_Periode.EdDateDeb.OnExit:=LibClassObjetSender.SenderOnDateDebExit;
         Choix_Periode.EdDateFin.OnExit:=LibClassObjetSender.SenderOnDateFinExit;
         Initialise_ParamAffichPeriode(ParamAffichPeriode);
         Periode:=ChoixPeriodeAffich(Periode.DateDeb,Periode.DateFin,'Dates de votre prochaine déclaration TVA !',ParamAffichPeriode);
     finally
       Choix_Periode.EdDateDeb.OnExit:=Choix_Periode.EdDateDebExit;
       Choix_Periode.EdDateFin.OnExit:= Choix_Periode.EdDateFinExit;
     end;//fin du try finally
   end
 else
    if PeriodeParam.Retour then
      begin
         periode.Retour := true;
         periode.DateDeb := PeriodeParam.DateDeb;
         periode.DateFin := PeriodeParam.DateFin;
      end
    else
        begin
         periode.Retour := true;
         periode.DateDeb := E.DateDebutDeclarationTVA;
         periode.DateFin := E.DateFinDeclarationTVA;
        end;
  if periode.Retour then
   begin
    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
//        DMTmTVA.ListeFilterRecordEdition.clear;
//        if CodeTva<>nil then      // Tous les Comptes
//         begin
//          DMTmTVA.ListeFilterRecordEdition.Assign(CodeTva);
//          DMTmTVA. .OnFilterRecord:=DMTmTVA. FilterRecord;
//         end
//        else
//          DMTmTVA. .OnFilterRecord:=nil;

//// à remettre dès que testé
 if DemandePeriode then
  begin
   ViderTable(DMTmTVA.TaDec_Tva);
   //DMTmTVA.TotauxReport:=CalculReport(False,DMTmTVA.listeReports,Periode.DateDeb,Periode.DateFin);
   //sauvegarder historique des reports
   PatienterAffich;
   CalculDeclarationTva(Periode.DateDeb,Periode.DateFin);
   PatienterFermer;
   DMTmTVA.VAliderDeclarationTVA(Periode.DateDeb,Periode.DateFin,false,ForceAffichage);
  end;

// OPERATIONS IMPOSABLES
     ListeValeur.Add('5; OPERATIONS IMPOSABLES ');

    ListeCodeTVA:=TStringList.Create;
    ListeCodeTVATmp:=TStringList.Create;

    ListeCodeTVATmp.clear;
    ListeCodeTVA.Clear;
    ListeCodeTVA:=ChampTableVersListeEx(['TvaCode','Libelle'],DMREch.TaTvaCodeRech,' - ',FAlse);

    if DMTmTVA.QuDec_Tva_VisuListe.Active then DMTmTVA.QuDec_Tva_VisuListe.Close;
    if DMTmTVA.QuDec_Tva.Active then DMTmTVA.QuDec_Tva.Close;
    DMTmTVA.QuDec_Tva_VisuListe.SQL.Clear;
    DMTmTVA.QuDec_Tva_VisuListe.SQL.Add(RqDec_Tva_SommeTvaParCode_1);
    DMTmTVA.QuDec_Tva_VisuListe.Open;
    if DMTmTVA.QuSumParCode_Dec_Tva.Active then
      DMTmTVA.QuSumParCode_Dec_Tva.Close;
    DMTmTVA.QuSumParCode_Dec_Tva.open;
    
    ListeTmp:=TStringList.Create;
    ListeTmp.Clear;
    ListeTmp :=DM_C_ListeCTVAVente;
    ListeTmp2:=TStringList.Create;
    ListeTmp2.Clear;
    ListeTmp2 :=DM_C_ListeCTVAImposeDeduite;
    j:=2;
    ListeEdition.Add('Type;Code tva/Libellé; H.Taxe; Tva');
    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
       // Si le Code de TVA est dans la liste des classes TVA de Ventes
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         // Si le code de TVA est dans la liste des classes TVA ImposeDeduite (Cf classe C et CodeTva C1(Acquisition CEE))
         // Ce cas inverse le signe des montant à déclarer car c'est une acquisition parmi les ventes !!!
         if ListeTmp2.IndexOf(StrTmp) <> -1 then
           begin
             LibelleTmp := ListeCodeTVA.Strings[i];
             if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
              Begin
               if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
                HTTmp :=arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency,2)-arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency,2)
               else
                HTTmp := 0;
              Soldearrondi:=(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency-DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
              TVATmp:= Soldearrondi;
              End;
           end
           else
           begin
             LibelleTmp := ListeCodeTVA.Strings[i];
             if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
              Begin
               if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
                HTTmp:= arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency,2)-arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency,2)
               else
                HTTmp:= 0;
              Soldearrondi:=(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency-DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency,2));
              TVATmp:= Soldearrondi ;
              End;
           end;
          ListeValeur.Add('0'+';'+GereLibelle(LibelleTmp)+';'+currtostr(HTTmp)+';'+currtostr(TVATmp));
          ListeEdition.Add('OPERATIONS IMPOSABLES'+';'+GereLibelle(LibelleTmp)+';'+currtostr(HTTmp)+';'+currtostr(TVATmp));
          LibelleTmp:='';
          TotalDue:=TotalDue+TVATmp;
          TotalHT:=TotalHT+HTTmp;
          HTTmp:=0;
          TVATmp:=0;
         end;
      end;
          LibelleTmp:='TVA antérieurement déduite à reverser (Cpt : '+DM_C_CompteTVADeduiteAReverser+')';
          HTTmp:=0;
          TVATmp:=0;
//      totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut-1,Periode.DateFin,DM_C_CompteTVADeduiteAReverser);
      totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,Periode.DateFin,DM_C_CompteTVADeduiteAReverser);
      if totauxbalance.SoldeDebitCreditFin then
        TVATmp:= -totauxbalance.SoldeFin
      else
        TVATmp:= totauxbalance.SoldeFin;
     ListeValeur.Add('0'+';'+GereLibelle(LibelleTmp)+';'+currtostr(HTTmp)+';'+currtostr(TVATmp));
     ListeEdition.Add('OPERATIONS IMPOSABLES'+';'+GereLibelle(LibelleTmp)+';'+currtostr(HTTmp)+';'+currtostr(TVATmp));
     TotalDue:=TotalDue+TVATmp;
     ListeValeur.Add('1; @TOTAL BRUTE DUE :  ;'+CurrToStr(TotalHT) +';'+CurrToStr(TotalDue));
     ListeEdition.Add(';TOTAL BRUTE DUE :  ;'+CurrToStr(TotalHT) +';'+CurrToStr(TotalDue));


    ListeValeur.Add('5; TVA DEDUCTIBLE ');

    //rajouter les code A* sauf CodeTVADefautBienEtService
    FiltrageDataSet(DMREch.TaTvaCodeRech,CreeFiltreOU('TvaCode',['A*']));
    ListeCodeTVATmp:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    rang:=ListeCodeTVATmp.IndexOf(DM_C_CodeTVADefautBienEtService);
    if rang<>-1 then  ListeCodeTVATmp.Delete(rang);
    DeFiltrageDataSet(DMREch.TaTvaCodeRech);

/// Report du Crédit antérieur

    ListeTmp.Clear;
    ListeTmp :=DM_C_ListeCTVAAchat;
    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         if StrTmp = 'I' then
          Begin
          /// Biens constituant des immobilisations
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
               TotTVADeductibleL1:=TotTVADeductibleL1+arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL1:=TotHTDeductibleL1+(arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency,2));
          End;
         if StrTmp = 'A' then
          Begin
          /// Autres biens et services
           if Copy(ListeCodeTVA.Strings[i],1,2) = DM_C_CodeTVADefautBienEtService then
            Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL2:=TotHTDeductibleL2+(arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency,2));
            End
            else
            Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotTVADeductibleL3:=TotTVADeductibleL3+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL3:=TotHTDeductibleL3+(arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency,2));
            End;
          End;
         if StrTmp = 'C' then
          Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotTVADeductibleL2:=TotTVADeductibleL2+(arrondi(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency,2));
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotHTDeductibleL2:=TotHTDeductibleL2+(arrondi(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency,2));
          End;
        end;
     end;
    // Col HT
    ListeValeur.Add('0'+'; Biens constituant des immobilisations ;'+currtostr(TotHTDeductibleL1)+';'+currtostr(TotTVADeductibleL1));
    ListeEdition.Add('TVA DEDUCTIBLE;Biens constituant des immobilisations ;'+currtostr(TotHTDeductibleL1)+';'+currtostr(TotTVADeductibleL1));
    ListeValeur.Add('0'+'; Autres biens et services ;'+currtostr(TotHTDeductibleL2)+';'+currtostr(TotTVADeductibleL2));
    ListeEdition.Add('TVA DEDUCTIBLE;Autres biens et services ;'+currtostr(TotHTDeductibleL2)+';'+currtostr(TotTVADeductibleL2));
    ListeValeur.Add('0'+'; Ommissions ou compléments de déductions ;'+currtostr(TotHTDeductibleL3)+';'+currtostr(TotTVADeductibleL3));
    ListeEdition.Add('TVA DEDUCTIBLE;Ommissions ou compléments de déductions ;'+currtostr(TotHTDeductibleL3)+';'+currtostr(TotTVADeductibleL3));
    for i:=0 to DMTmTVA.ListeReports.Count-1  do
      Begin
        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAPourReport then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
             if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
               TotReportL4:=PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin
             else
               TotReportL4:=-PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin;
           end;

        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAPourRemboursement then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
             if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
               TotReportL4:=TotReportL4+PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin
             else
               TotReportL4:=TotReportL4-PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.Soldefin;
           end;
      End;
   ListeValeur.Add('0'+'; Report du Crédit antérieur (Cpt : '+DM_C_CompteTVAPourReport+' ou '+DM_C_CompteTVAPourRemboursement+') ;'+CurrToStr(0)+';'+currtostr(TotReportL4));
   ListeEdition.Add('TVA DEDUCTIBLE;Report du Crédit antérieur (Cpt : '+DM_C_CompteTVAPourReport+' ou '+DM_C_CompteTVAPourRemboursement+') ;'+CurrToStr(0)+';'+currtostr(TotReportL4));
   TotalCredit:=TotTVADeductibleL1+TotTVADeductibleL2+TotTVADeductibleL3+TotReportL4;

   ListeValeur.Add('1; @TOTAL TVA DEDUCTIBLE  :  ;'+CurrToStr(TotHTDeductibleL1+TotHTDeductibleL2+TotHTDeductibleL3) +';'+CurrToStr(TotalCredit));
   ListeEdition.Add(';TOTAL TVA DEDUCTIBLE  :  ;'+CurrToStr(TotHTDeductibleL1+TotHTDeductibleL2+TotHTDeductibleL3) +';'+CurrToStr(TotalCredit));

///////////////   OPERATIONS NON IMPOSABLES //////////////
     ListeValeur.Add('5; TVA AUTOLIQUIDEE SUR IMPORTATIONS');

    //créer et remplir la liste des codes tva correspondant aux Tva auto liquidées
    FiltrageDataSet(DMREch.TaTvaCodeRech,CreeFiltreOU('TvaCode',['M*']));
    ListeCodeTVATmp:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    rang:=ListeCodeTVATmp.IndexOf(DM_C_CodeTVADefautFranchise);
    if rang<>-1 then  ListeCodeTVATmp.Delete(rang);
    DeFiltrageDataSet(DMREch.TaTvaCodeRech);


     ListeTmp.Clear;
     ListeTmp :=DM_C_ListeCTVAAutoLiquide;

     TotAutoLiquideL1:=0;
     TotTVAautoLiquideL1:=0;

    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         if StrTmp = 'M' then
          Begin
            if GrLocate(DMTmTVA.QuDec_Tva_VisuListe,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotTVAautoLiquideL1:=TotTVAautoLiquideL1+(DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantDebit').AsCurrency - DMTmTVA.QuDec_Tva_VisuListe.findField('TottvaMontantCredit').AsCurrency);
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotAutoLiquideL1:=TotAutoLiquideL1+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
          End;
        end;
     end;

    ListeValeur.Add('0'+'; Tva Autoliquidée sur importations ;'+currtostr(TotAutoLiquideL1)+';'+currtostr(TotTVAautoLiquideL1));

    ListeEdition.Add('TVA AUTOLIQUIDEE SUR IMPORTATIONS;Tva Autoliquidée sur importations ;'+currtostr(TotAutoLiquideL1)+';'+currtostr(TotTVAautoLiquideL1));



     ListeValeur.Add('5; OPERATIONS NON IMPOSABLES ');

    //créer et remplir la liste des codes tva correspondant aux Autres opérations non imposables
    FiltrageDataSet(DMREch.TaTvaCodeRech,CreeFiltreOU('TvaCode',['N*']));
    ListeCodeTVATmp:=ChampTableVersListe('TvaCode',DMREch.TaTvaCodeRech);
    rang:=ListeCodeTVATmp.IndexOf(DM_C_CodeTVADefautFranchise);
    if rang<>-1 then  ListeCodeTVATmp.Delete(rang);
    DeFiltrageDataSet(DMREch.TaTvaCodeRech);


     ListeTmp.Clear;
     ListeTmp :=DM_C_ListeCTVANonImposable;

     TotOpNonImposableL1:=0;
     TotOpNonImposableL2:=0;
     TotOpNonImposableL3:=0;
     TotOpNonImposableL3Bis:=0;
     TotOpNonImposableL4:=0;

    for i:=0 to ListeCodeTVA.Count -1 do
     begin
       StrTmp:=Copy(ListeCodeTVA.Strings[i],1,1);
       if ListeTmp.IndexOf(StrTmp) <> -1 then
        begin
         if StrTmp = 'L' then
          Begin
            if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
             TotOpNonImposableL4:=TotOpNonImposableL4+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
          End;
         if (StrTmp = 'N')or(StrTmp = 'F') then
           if Copy(ListeCodeTVA.Strings[i],1,2) = DM_C_CodeTVADefautFranchise then
              Begin
                if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
                   //Debit - crédit (est inversé par rapport aux autres lignes voir contraintes Declaration tva)
                   TotOpNonImposableL1:=TotOpNonImposableL1+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency);
              End
           else
              Begin
                if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
                   TotOpNonImposableL3:=TotOpNonImposableL3+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
                if (StrTmp = 'F')then
                begin
                  if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
                    TotOpNonImposableL3Bis:=TotOpNonImposableL3Bis+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
                end;
              End;
         if StrTmp = 'E' then
            Begin
              if GrLocate(DMTmTVA.QuSumParCode_Dec_Tva,'TvaCode;En_Attente',[copy(ListeCodeTVA.Strings[i],1,2),False]) then
                  TotOpNonImposableL2:=TotOpNonImposableL2+(DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_CreditCalc').AsCurrency-DMTmTVA.QuSumParCode_Dec_Tva.findField('HT_Declare_DebitCalc').AsCurrency);
            End;
        end;
     end;
    ListeValeur.Add('0'+'; Achats en franchise ;'+currtostr(TotOpNonImposableL1)+';'+currtostr(0));
    ListeValeur.Add('0'+'; Exportations hors CEE ;'+currtostr(TotOpNonImposableL2)+';'+currtostr(0));
    ListeValeur.Add('0'+'; Autres opérations non imposables ;'+currtostr(TotOpNonImposableL3)+';'+currtostr(0));
    if(TotOpNonImposableL3Bis<>0)then ListeValeur.Add('0'+';-------Dont ventes en Franchise ;'+currtostr(TotOpNonImposableL3Bis)+';'+currtostr(0));
    ListeValeur.Add('0'+'; Livraisons intracommunautaires ;'+currtostr(TotOpNonImposableL4)+';'+currtostr(0));

    ListeEdition.Add('OPERATIONS NON IMPOSABLES;Achats en franchise ;'+currtostr(TotOpNonImposableL1)+';'+currtostr(0));
    ListeEdition.Add('OPERATIONS NON IMPOSABLES;Exportations hors CEE ;'+currtostr(TotOpNonImposableL2)+';'+currtostr(0));
    ListeEdition.Add('OPERATIONS NON IMPOSABLES;Autres opérations non imposables ;'+currtostr(TotOpNonImposableL3)+';'+currtostr(0));
    if(TotOpNonImposableL3Bis<>0)then ListeEdition.Add('0'+'OPERATIONS NON IMPOSABLES;-------Dont ventes en Franchise ;'+currtostr(TotOpNonImposableL3Bis)+';'+currtostr(0));
    ListeEdition.Add('OPERATIONS NON IMPOSABLES;Livraisons intracommunautaires ;'+currtostr(TotOpNonImposableL4)+';'+currtostr(0));

////////////////  CALCUL DE LA TVA DUE OU DU CREDIT  ///////////

     ListeValeur.Add('7; ');//je crée plusieurs lignes vides 
     ListeValeur.Add('7; ');

     ListeValeur.Add('10; CALCUL DE LA TVA DUE OU DU CREDIT ');

    ///Ligne acompte verses 44581
//     totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut-1,Periode.DateFin,DM_C_CompteTVAAcompteVerse);
     totauxbalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,Periode.DateFin,DM_C_CompteTVAAcompteVerse);
     if not totauxbalance.SoldeDebitCreditFin then
       totauxbalance.SoldeFin:=(-1*totauxbalance.SoldeFin);
   TVATmp:=0;
    for i:=0 to DMTmTVA.ListeReports.Count-1  do
      Begin
        ///Ligne Tva à payer période précédente 44551
        if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Compte=DM_C_CompteTVAAPayer then
         if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.ATraiter then
           begin
              if PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeDebitCreditFin then
                 TVATmp:=(-1*PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeFin)
              else
                 TVATmp:=(PSolde_A_Traiter(DMTmTVA.ListeReports.Items[i])^.Total.SoldeFin);
           end;
      end;

    ListeValeur.Add('0'+'; TVA Due ;'+CurrToStr(0)+';'+currtostr(TotalDue));
    ListeValeur.Add('0'+'; - TVA déductible ;'+CurrToStr(0)+';'+currtostr(TotalCredit));
    ListeValeur.Add('0'+'; - Acomptes versés (Cpt : '+DM_C_CompteTVAAcompteVerse+') ;'+CurrToStr(0)+';'+currtostr(totauxbalance.SoldeFin));
    ListeValeur.Add('0'+'; TVA à payer de la période précédente (Cpt : '+ DM_C_CompteTVAAPayer+') ;'+CurrToStr(0)+';'+currtostr(TVATmp));

    ListeEdition.Add('CALCUL DE LA TVA DUE OU DU CREDIT;TVA Due ;'+CurrToStr(0)+';'+currtostr(TotalDue));
    ListeEdition.Add('CALCUL DE LA TVA DUE OU DU CREDIT;- TVA déductible ;'+CurrToStr(0)+';'+currtostr(TotalCredit));
    ListeEdition.Add('CALCUL DE LA TVA DUE OU DU CREDIT;- Acomptes versés (Cpt : '+DM_C_CompteTVAAcompteVerse+') ;'+CurrToStr(0)+';'+currtostr(totauxbalance.SoldeFin));
    ListeEdition.Add('CALCUL DE LA TVA DUE OU DU CREDIT;TVA à payer de la période précédente (Cpt : '+ DM_C_CompteTVAAPayer+') ;'+CurrToStr(0)+';'+currtostr(TVATmp));

    //solde:=(SommeColonneFormate(GrGrid4,1,1,1))-(SommeColonneFormate(GrGrid4,1,2,2))-(SommeColonneFormate(GrGrid4,1,3,3))+(SommeColonneFormate(GrGrid4,1,4,4));
    solde:=TotalDue-TotalCredit-totauxbalance.SoldeFin+TVATmp;
        if solde>0 then
          ///Ligne solde à payer
         begin
            ListeValeur.Add('1; @SOLDE A PAYER :  ;'+CurrToStr(0)+';'+CurrToStr(abs(solde)));
            ListeValeur.Add('1; @OU CREDIT DE TVA :  ;'+CurrToStr(0)+';'+CurrToStr(0));
            ListeEdition.Add(';SOLDE A PAYER :  ;'+CurrToStr(0)+';'+CurrToStr(abs(solde)));
            ListeEdition.Add(';OU CREDIT DE TVA :  ;'+CurrToStr(0)+';'+CurrToStr(0));
         end
        else
          begin
          ///Ligne Crédit de TVA
            ListeValeur.Add('1; @SOLDE A PAYER :                  ;'+CurrToStr(0)+';'+CurrToStr(0));
            ListeValeur.Add('1; @OU CREDIT DE TVA :               ;'+CurrToStr(0)+';'+CurrToStr(abs(solde)));
            ListeEdition.Add(';SOLDE A PAYER :                  ;'+CurrToStr(0)+';'+CurrToStr(0));
            ListeEdition.Add(';OU CREDIT DE TVA :               ;'+CurrToStr(0)+';'+CurrToStr(abs(solde)));
          end;



/////////
     ObjPrn.FTitreEdition := 'SYNTHESE TVA ';
     ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
     ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
     ListeValeur.Insert(0,' Code Tva / Libellé ; HT ; TVA ');
     ListeValeur.Insert(1,'5;1;1');
     ListeValeur.Insert(2,'texte;curr;curr');

     case TypeEdition of
       C_Exportation,C_ExportationImprimable:
       begin
          if direct then
            begin
              if not DirectoryExists(e.RepertoireExportDossier)then
                begin
                    if not CreateDir(e.RepertoireExportDossier) then
                      Raise exception.CreateFmt('Erreur lors de la tentative de création du dossier '+e.RepertoireExportDossier,['']);
                end;
              if TypeEdition=C_ExportationImprimable then
                ListeValeur.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExportDossier)+'Synt-TVA_'+DateInfos(Periode.DateDeb,'-',true).DateStrFormat+'_au_'+DateInfos(Periode.DateFin,'-',true).DateStrFormat+'_'+E.NomDossier + E.NomExo + '.Txt')
              else
                ListeEdition.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireExportDossier)+'Synt-TVA_'+DateInfos(Periode.DateDeb,'-',true).DateStrFormat+'_au_'+DateInfos(Periode.DateFin,'-',true).DateStrFormat+'_'+E.NomDossier + E.NomExo +'_Simple.Txt');
            end
          else
            if TypeEdition=C_ExportationImprimable then
              ExportDonnees(ListeValeur,E.RepertoireExportDossier,'Synt-TVA_'+DateInfos(Periode.DateDeb,'-',true).DateStrFormat+'_au_'+DateInfos(Periode.DateFin,'-',true).DateStrFormat+'_'+E.NomDossier + E.NomExo + '.Txt')
            else
              ExportDonnees(ListeEdition,E.RepertoireExportDossier,'Synt-TVA_'+DateInfos(Periode.DateDeb,'-',true).DateStrFormat+'_au_'+DateInfos(Periode.DateFin,'-',true).DateStrFormat+'_'+E.NomDossier + E.NomExo +'_Simple.Txt');
       end
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;//fin du case TypeEdition
  end;//fin du periode.retour
finally
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;

Function EditionSyntheseTVAL(TypeEdition : integer; DemandePeriode:Boolean;PeriodeParam:TPeriode; CodeTva:String;DataSet:TDataSet;direct:boolean):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
Initialise_ExceptLGR(Retour);
   Maliste:=TStringList.Create;
   if not empty (CodeTva)then
     Maliste.Add(CodeTva)
   else
     raise ExceptLGR.Create('Aucun CodeTva n''est defini !',1000,true,mtError,Retour);
   EditionSyntheseTVAL(TypeEdition,DemandePeriode,PeriodeParam,Maliste,DataSet,direct);
  except
     abort;
  end;
end;

procedure TDMTmTVA.QuMaitre_ParcoursEcritureTypeEFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
  var
  i:Integer;
  //liste:TStringlist;
begin

//Accept := (QuMaitre_ParcoursEcritureTypeEId.AsInteger = Query1Id_Ecriture.AsInteger)and
//           (Query1PartDeclaree.AsInteger < 1 ));
//if QuMaitre_ParcoursEcritureTypeEId.AsInteger = Query1Id_Ecriture.AsInteger then
//  Accept := Query1PartDeclaree.AsInteger < 1 ;
//Accept := false;
//if DataSet = QuParcoursEcritureTypeD_EnAttente then
//if DataSet.FindField('Id').AsInteger = Query1Id_Ecriture.AsInteger then
i:= DataSet.FindField('Id').AsInteger;
//if(i=120006561)then showmessage('id : 120006561 est passée');
Accept := true;
if QuVerifAcceptTva.Locate('ID_Ecriture',DataSet.FindField('Id').AsInteger,[]) then
//  Accept := QuVerifAcceptTvaPartDeclaree.AsFloat < 1.00 ;
  accept:=(((QuVerifAcceptTvamontanttva.AsCurrency<QuVerifAcceptTvamontant_tva.AsCurrency)
    or(QuVerifAcceptTvamontanttva.AsCurrency=0))and(QuVerifAcceptTvaPartDeclaree.AsFloat < 1.00));
    //if(QuVerifAcceptTvaPartDeclaree.AsFloat > 1.00) then
    //liste.Add('id : '+IntToStr_Lgr(DataSet.FindField('Id').AsInteger)+' part :'+FloatToStr_Lgr(QuVerifAcceptTvaPartDeclaree.AsFloat));
  if not accept then
    accept := not QueryTvaDeclare.Locate('id_ecriture',DataSet.FindField('Id').AsInteger,[]);
//   if DMRech.TaH_TVARech.Locate('ID_Ecriture',DataSet.FindField('Id').AsInteger,[]) then
//    accept := DMRech.TaH_TVARech.FindField('En_Attente').AsBoolean;
//Accept := Query1.Locate('ID_Ecriture',DataSet.FindField('Id').AsInteger,[]);
//AjouterFichierTexte(E.REpertoireFiscal+'testTVA.txt',IntToStr(i) +
//                    ' - '+
//                    CurrToStr(Query1PartDeclaree.AsFloat)+
//                    ' - '+
//                    str_bool2str(Accept)+
////                    DataSet.FindField('Part_Declaree').AsString+
//                    ' - '+
//                    Query1Id_Ecriture.AsString
//                    );
if accept then
 begin
//  Accept := Query1PartDeclaree.AsFloat < 1.00 ;
 end;
//if(i=120006561)then showmessage('acceptée : '+BoolToStr(accept));
 //liste.SaveToFile(e.RepertoireDossier+'/listeErreursTva.txt');
end;


procedure TDMTmTVA.QuMaitre_ParcoursEcritureTypeDFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
  var
  i:Integer;
begin
try
i:= DataSet.FindField('Id').AsInteger;
Accept := true;
if QuVerifAcceptTva.Locate('ID_Ecriture',DataSet.FindField('Id').AsInteger,[]) then
  accept:=((QuVerifAcceptTvamontanttva.AsCurrency<QuVerifAcceptTvamontant_tva.AsCurrency)and(QuVerifAcceptTvaPartDeclaree.AsFloat < 1.00));
  if not accept then
    accept := not QueryTvaDeclare.Locate('id_ecriture',DataSet.FindField('Id').AsInteger,[]);

if (i=50001583)then showmessage('accept = '+BoolToStr(accept));
except
ShowMessage('Problème sur QuMaitre_ParcoursEcritureTypeEFilterRecord');
end;


end;
procedure TDMTmTVA.QuParcoursEcritureTypeD_EnAttenteBeforeOpen(
  DataSet: TDataSet);
begin
QueryTvaDeclare.close;
QueryTvaDeclare.Open;
QuVerifAcceptTva.Close;
QuVerifAcceptTva.Open;
end;


Function EditionJournauxTvaL(TypeEdition : integer; DemandePeriode:Boolean; CodeTva:TStringList;DataSet:TDataSet;Detail:boolean):Boolean;
var
periode:TPeriode;
i,rang,j:integer;
ObjPrn:TObjetEdition;
Tva,HtDeclare,TvaDebit,TvaCredit,Part,Taux:currency;
TotHtDeclare,TotTva:currency;
LibelleTmp,CodeTvaTmp,CodeTvaReduit,PointVirguleAvant:string;
ListeValeur,ListeCodeTvaSansSens,ListeTvaImposeDeduite:Tstringlist;
TitreCompte:string;
EnAttenteString:string;
EnAttentebool:boolean;
ForceAffichage:TForceAffichage;
ParamAffichPeriode:TParamAffichPeriode;
SQL_Initial:string;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
ForceAffichage.Affiche:=false;
ForceAffichage.Force:=false;
 if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(Application.MainForm);
///
 if DemandePeriode then
   begin
     try
         DMTmTVA.MAJ_DateDeclarationTVA(Periode.DateDeb,Periode.DateFin);
         e.DateDebutDeclarationTVA:=Periode.DateDeb;
         e.DateFinDeclarationTVA:=Periode.DateFin;
         if Choix_Periode = nil then Choix_Periode:=TChoix_Periode.Create(Application.MainForm);
         Choix_Periode.EdDateDeb.OnExit:=LibClassObjetSender.SenderOnDateDebExit;
         Choix_Periode.EdDateFin.OnExit:=LibClassObjetSender.SenderOnDateFinExit;
         Initialise_ParamAffichPeriode(ParamAffichPeriode);
         Periode:=ChoixPeriodeAffich(Periode.DateDeb,Periode.DateFin,'Dates de votre prochaine déclaration TVA !',ParamAffichPeriode);
     finally
       Choix_Periode.EdDateDeb.OnExit:=Choix_Periode.EdDateDebExit;
       Choix_Periode.EdDateFin.OnExit:= Choix_Periode.EdDateFinExit;
     end;//fin du try finally
   end
 else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DateDebutDeclarationTVA;
     periode.DateFin := E.DateFinDeclarationTVA;
    end;
  if periode.Retour then
   begin
    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeCodeTvaSansSens:=TStringList.Create;
    ListeTvaImposeDeduite:=TStringList.Create;
    if CodeTva<>nil then
      for i:=0 to CodeTva.count-1 do
        ListeCodeTvaSansSens.Add(str_getstringelement(codetva.Strings[i],1,';'));
    if dataset <> nil then
      begin
        // Prevu pour passer le dataset concerné
//        if not (dataset is TQuery) then   raise ExceptLGR.Create('Attention, le dataset n''est pas une Query !!! ',1000,true,mtError,Result);
        DMTmTVA.QuTVAEdition:=(dataset as TQuery);
        for j:=0 to DMTmTVA.QuTVAEdition.SQL.Count-1 do
          begin
            if LowerCase(trim(copy(DMTmTVA.QuTVAEdition.SQL[j],1,5)))='order' then
              begin
                SQL_Initial:=DMTmTVA.QuTVAEdition.SQL[j];
                DMTmTVA.QuTVAEdition.SQL[j]:='order by D.En_attente,D.tvaCode,P."date",D.tvaDate,P.reference';
              end;
          end;
      end
    else
      begin
       //on branche un filter record sur requete en passant une liste
        DMTmTVA.ListeFilterRecordEdition.clear;
        if CodeTva<>nil then      // Tous les codes Tva
         begin
          TitreCompte:='Du code tva :'+codetva.Strings[0]+' au code :'+Codetva.Strings[Codetva.count-1];
          DMTmTVA.ListeFilterRecordEdition.Assign(Codetva);
          DMTmTVA.QuTVAEdition.OnFilterRecord:=DMTmTVA.QuTVAEditionFilterRecord;
          DMTmTVA.QuTVAEdition.filtered:=true;
         end
        else
          begin
            DMTmTVA.QuTVAEdition.OnFilterRecord:=nil;
            Titrecompte:=' Tous les codes ';
          end;
          DMTmTVA.QuTVAEdition.Close;
          DMTmTVA.QuTVAEdition.ParamByName('DateFin').AsDate := Periode.DateFin;
        end;
 if DemandePeriode then
  begin
   ViderTable(DMTmTVA.TaDec_Tva);
   //DMTmTVA.TotauxReport:=CalculReport(False,DMTmTVA.listeReports,Periode.DateDeb,Periode.DateFin);
   //sauvegarder historique des reports
   PatienterAffich;
   CalculDeclarationTva(Periode.DateDeb,Periode.DateFin);
   PatienterFermer;
   DMTmTVA.VAliderDeclarationTVA(Periode.DateDeb,Periode.DateFin,false,ForceAffichage);
  end;

          DMTmTVA.QuTVAEdition.Open;
          DMTmTVA.QuTVAEdition.first;

          if DMTmTVA.QuTVAEdition.recordcount<>0 then
          begin
          HtDeclare:=0;
          TvaDebit:=0;
          TvaCredit:=0;
          Tva:=0;
          Part:=0;
          Taux:=0;
          TotHtDeclare:=0;
          TotTva:=0;
//
          EnAttenteBool:=DMTmTVA.QuTVAEdition.FindField('En_attente').Asboolean;
          if EnAttenteBool then
            EnAttenteString:=' TVA EN ATTENTE '
          else
            EnAttenteString:=' TVA A DECLARER ';
          ListeValeur.Add('10;'+EnAttenteString);
          if detail then
            ListeValeur.Add('12;');
          if detail then PointVirguleAvant:=';;;;;'
          else
            PointVirguleAvant:='';

          CodeTvaTmp:=DMTmTVA.QuTVAEdition.FindField('TvaCode').AsString;
          libelleTmp:=GereLibelle(Infos_TInfosTvaCode(DMRech.TaTvaCodeRech,'tvacode',[codeTvaTmp]).Libelle);
          //je traite les code 'C*' en double quand je ne suis pas sur une séléction de code tva
          //et que je demande donc tous les journaux de tva
          if detail then
            begin
              if ((DM_C_ListeCTVAImposeDeduite.IndexOf(copy(CodeTvaTmp,1,1))<>-1)and(CodeTva.count=0)) then
                ListeValeur.Add('9; CODE TVA : '+CodeTvaTmp+' - '+GereLibelle(libelleTmp)+' - Déductible -')//je traite les codes 'C*'
              else
                ListeValeur.Add('9; CODE TVA : '+CodeTvaTmp+' - '+GereLibelle(libelleTmp)+' - ');//je traite les codes 'C*'
            end;
          with DMTmTVA.QuTVAEdition do     //FindField('').Asstring
              begin
                  while not Eof do
                    begin
                          CodeTvaReduit:=copy(codeTvaTmp,1,1);
                          TvaDebit:=arrondi(FindField('TvaMontantDebit').AsCurrency,2);
                          TvaCredit:=arrondi(FindField('TvaMontantCredit').AsCurrency,2);
//                          if CodeTva.count>0 then
//                            begin
//                              rang:=ListeCodeTvaSansSens.IndexOf(CodeTvaTmp);
//                              if rang=-1 then rang:=ListeCodeTvaSansSens.IndexOf(copy(CodeTvaTmp,1,1)+'*');
//                              if rang=-1 then   raise ExceptLGR.Create('Problème de paramètrage des codes tva (en programmation)',1000,true,mtError);
//                              if ((CodeTva.count<rang)or(str_getstringelement(CodeTva.Strings[rang],1,';')<>ListeCodeTvaSansSens.Strings[rang])) then
//                                  raise ExceptLGR.Create('Problème de paramètrage des codes tva (en programmation)',1000,true,mtError);
//                              if str_getstringelement(CodeTva.Strings[rang],2,';')='0' then
//                                begin
//                                  Tva:=TvaDebit-TvaCredit;
//                                  HtDeclare:=arrondi((FindField('HT_Declare_Debit').AsCurrency-FindField('HT_Declare_Credit').AsCurrency),2);
//                                end;
//                              if str_getstringelement(CodeTva.Strings[rang],2,';')='1' then
//                                begin
//                                  Tva:=TvaCredit-TvaDebit;
//                                  HtDeclare:=arrondi((FindField('HT_Declare_Credit').AsCurrency-FindField('HT_Declare_Debit').AsCurrency),2);
//                                end;
//                            end
//                          else
                            begin
                              if DM_C_ListeCTVAVente.IndexOf(CodeTvaReduit)<>-1 then
                                begin
                                   if DM_C_ListeCTVAImposeDeduite.IndexOf(CodeTvaReduit)<>-1 then
                                     begin
                                       Tva:=TvaDebit-TvaCredit;
                                       HtDeclare:=arrondi((FindField('HT_Declare_Debit').AsCurrency-FindField('HT_Declare_Credit').AsCurrency),2);
                                     end
                                   else
                                     begin
                                       Tva:=TvaCredit-TvaDebit;
                                       HtDeclare:=arrondi((FindField('HT_Declare_Credit').AsCurrency-FindField('HT_Declare_Debit').AsCurrency),2);
                                     end;
                                end//fin du
                              else
                              if DM_C_ListeCTVAAchat.IndexOf(CodeTvaReduit)<>-1 then
                                begin
                                   Tva:=TvaDebit-TvaCredit;
                                   HtDeclare:=arrondi((FindField('HT_Declare_Debit').AsCurrency-FindField('HT_Declare_Credit').AsCurrency),2);
                                end//fin du
                              else
                              if DM_C_ListeCTVANonImposable.IndexOf(CodeTvaReduit)<>-1 then
                                begin
                                   if CodeTvaReduit='L' then
                                     begin
                                       Tva:=TvaCredit-TvaDebit;
                                       HtDeclare:=arrondi((FindField('HT_Declare_Credit').AsCurrency-FindField('HT_Declare_Debit').AsCurrency),2);
                                     end;
                                   if CodeTvaReduit='N' then
                                     if DM_C_CodeTVADefautFranchise=CodeTvaReduit then
                                       begin
                                         Tva:=TvaDebit-TvaCredit;
                                         HtDeclare:=arrondi((FindField('HT_Declare_Debit').AsCurrency-FindField('HT_Declare_Credit').AsCurrency),2);
                                       end
                                     else
                                       begin
                                         Tva:=TvaCredit-TvaDebit;
                                         HtDeclare:=arrondi((FindField('HT_Declare_Credit').AsCurrency-FindField('HT_Declare_Debit').AsCurrency),2);
                                       end;
                                   if CodeTvaReduit='E' then
                                     begin
                                       Tva:=TvaCredit-TvaDebit;
                                       HtDeclare:=arrondi((FindField('HT_Declare_Credit').AsCurrency-FindField('HT_Declare_Debit').AsCurrency),2);
                                     end;
                                end;//fin du
                            end;
                          //HtDeclare:=arrondi(FindField('HT_Declare').AsCurrency,2);
                          Part:=arrondi(FindField('Part_declaration').AsCurrency,2);
                          Taux:=arrondi(FindField('Taux').AsCurrency,2);
                          if detail then
                          begin
                          ListeValeur.Add('0'+
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('DatePiece').Asstring+          // D/ Piece
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('TvaDate').Asstring+          // D/ Tva
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('Reference').Asstring+          // Réf.Pièce
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('CompteContrepartie').Asstring+          // Tiers
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('CompteHT').Asstring+          // Compte
                                           ';'+
                                           GereLibelle(DMTmTVA.QuTVAEdition.FindField('Libelle').Asstring)+          // Libellé
                                           ';'+
                                           currtostr(HtDeclare)+          // Ht Déclaré
                                           ';'+
                                           currtostr(Tva)+          // Tva   TvaMontantCredit
                                           ';'+
                                           currtostr(Taux)+          // Taux
                                           ';'+
                                           currtostr(Part)+          // Part
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('TvaType').Asstring          // T
                                           );
//                                           ';'+
//                                           currtostr(0)          //
                          //si code 'C' je garde la ligne pour la générer en déductible et en déclarable
                          //pour qu'elle s'annule
                          if ((DM_C_ListeCTVAImposeDeduite.IndexOf(CodeTvaReduit)<>-1)and(CodeTva.count=0)) then
                             ListeTvaImposeDeduite.Add('0'+
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('DatePiece').Asstring+          // D/ Piece
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('TvaDate').Asstring+          // D/ Tva
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('Reference').Asstring+          // Réf.Pièce
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('CompteContrepartie').Asstring+          // Tiers
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('CompteHT').Asstring+          // Compte
                                           ';'+
                                           GereLibelle(DMTmTVA.QuTVAEdition.FindField('Libelle').Asstring)+          // Libellé
                                           ';'+
                                           currtostr(HtDeclare)+          // Ht Déclaré
                                           ';'+
                                           currtostr(Tva)+          // Tva   TvaMontantCredit
                                           ';'+
                                           currtostr(Taux)+          // Taux
                                           ';'+
                                           currtostr(Part)+          // Part
                                           ';'+
                                           DMTmTVA.QuTVAEdition.FindField('TvaType').Asstring          // T
                                           );
                          end;//fin si detail
                          TotHtDeclare:=TotHtDeclare+HtDeclare;
                          TotTva:=TotTva+Tva;
                          HtDeclare:=0;
                          TvaDebit:=0;
                          TvaCredit:=0;
                          Tva:=0;
                          Part:=0;
                          Taux:=0;
                            next;
                    if ((CodeTvaTmp<>DMTmTVA.QuTVAEdition.FindField('TvaCode').AsString)or(EnAttenteBool<> DMTmTVA.QuTVAEdition.FindField('En_attente').Asboolean)) then
                      begin
                      if DM_C_ListeCTVAImposeDeduite.IndexOf(copy(CodeTvaTmp,1,1))<>-1 then
                        begin //si on travail sur code 'C*'
                           ListeValeur.Add('1;'+PointVirguleAvant+' @TOTAL CODE TVA '+CodeTvaTmp+' - Déductible - '+EnAttenteString+' - : ;'+E.FormatCurrSansDevise(TotHtDeclare)+';'+E.FormatCurrSansDevise(TotTva));
                          if detail then
                            ListeValeur.Add('12;');
                           if ((DM_C_ListeCTVAImposeDeduite.IndexOf(copy(FindField('TvaCode').AsString,1,1))=-1)and(ListeTvaImposeDeduite.Count<>0)) then
                             begin //si changement de type de code, donc je génére mes ligne de 'C*' en déclarable
                               ListeValeur.Add('9; CODE TVA : '+CodeTvaTmp+' - '+GereLibelle(libelleTmp)+' - Déclarable -');
                               if detail then
                                 begin
                                   while ListeTvaImposeDeduite.count <>0 do
                                     begin
                                       ListeValeur.Add(ListeTvaImposeDeduite.Strings[0]);
                                       ListeTvaImposeDeduite.Delete(0);
                                     end;
                                 end//fin si detail
                               else
                                 begin
                                 ListeValeur.Add('1;'+PointVirguleAvant+' @TOTAL CODE TVA '+CodeTvaTmp+' - Déclarable - '+EnAttenteString+' - : ;'+E.FormatCurrSansDevise(TotHtDeclare)+';'+E.FormatCurrSansDevise(TotTva));
                                 ListeValeur.Add('12;');
                                 end;
                               end;
                          ListeValeur.Add('1;'+PointVirguleAvant+' @TOTAL CODE TVA '+CodeTvaTmp+' - Déclarable - '+EnAttenteString+' - : ;'+E.FormatCurrSansDevise(TotHtDeclare)+';'+E.FormatCurrSansDevise(TotTva));
                          if detail then
                            ListeValeur.Add('12;');
                         end
                       else
                          begin
                          ListeValeur.Add('1;'+PointVirguleAvant+' @TOTAL CODE TVA '+CodeTvaTmp+' - '+EnAttenteString+' - : ;'+E.FormatCurrSansDevise(TotHtDeclare)+';'+E.FormatCurrSansDevise(TotTva));
                          if detail then
                            ListeValeur.Add('12;');
                          end;
                        if EnAttenteBool<> DMTmTVA.QuTVAEdition.FindField('En_attente').Asboolean then
                            begin
                                ListeValeur.Add('15;');
                                EnAttenteBool:=DMTmTVA.QuTVAEdition.FindField('En_attente').Asboolean;
                                if EnAttenteBool then
                                  EnAttenteString:=' TVA EN ATTENTE '
                                else
                                  EnAttenteString:=' TVA A DECLARER ';
                                ListeValeur.Add('10;'+EnAttenteString);
                                if detail then
                                  ListeValeur.Add('12;');
                            end;
                       CodeTvaTmp:=FindField('TvaCode').AsString;
                       libelleTmp:=GereLibelle(Infos_TInfosTvaCode(DMRech.TaTvaCodeRech,'tvacode',[codeTvaTmp]).Libelle);
                        if detail then
                          Begin
                            if ((DM_C_ListeCTVAImposeDeduite.IndexOf(copy(CodeTvaTmp,1,1))<>-1)and(CodeTva.count=0)) then
                              ListeValeur.Add('9; CODE TVA : '+CodeTvaTmp+' - '+GereLibelle(libelleTmp)+' - Déductible -')//je traite les codes 'C*'
                            else
                              ListeValeur.Add('9; CODE TVA : '+CodeTvaTmp+' - '+GereLibelle(libelleTmp)+' - ');
                          end;
                       TotHtDeclare:=0;
                       TotTva:=0;
                      end;
                    end;//fin du while not DMTmTVA.QuTVAEdition.eof
                    ListeValeur.Add('1;'+PointVirguleAvant+' @TOTAL CODE TVA '+CodeTvaTmp+' - '+EnAttenteString+' - : ;'+E.FormatCurrSansDevise(TotHtDeclare)+';'+E.FormatCurrSansDevise(TotTva));
                    if detail then
                      ListeValeur.Add('12;');
                 ObjPrn.FTitreEdition := ' JOURNAUX DE TVA ';
                 ObjPrn.FSousTitreEdition:='';
                 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
                 if detail then
                   begin
                       ListeValeur.Insert(0,' D/ Piece ; D/ Tva ; Réf.Pièce ; Tiers ; Compte ; Libellé ; Ht Déclaré ; Tva ; Tx. ; Pt. ; T. ');
                       ListeValeur.Insert(1,'0.6;0.6;0.7;0.7;0.7;1.7;0.8;0.7;0.3;0.3;0.2');
                       ListeValeur.Insert(2,'texte;texte;texte;texte;texte;texte;Curr;Curr;float;float;texte');
                   end
                 else
                   Begin
                       ListeValeur.Insert(0,' Code Tva  ; Ht Déclaré ; Tva ');
                       ListeValeur.Insert(1,'3.6;1.0;1.0');
                       ListeValeur.Insert(2,'texte;Curr;Curr');
                   end;
              end;//fin du with
          end;
          ObjPrn.AffichageImp(ListeValeur);
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;  
end;

Function EditionJournauxTvaL(TypeEdition : integer; DemandePeriode:Boolean; CodeTva:String;DataSet:TDataSet;Detail:boolean):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
Initialise_ExceptLGR(Retour);
   Maliste:=TStringList.Create;
   if not empty (CodeTva)then
     Maliste.Add(CodeTva)
   else
     raise ExceptLGR.Create('Aucun CodeTva n''est defini !',1000,true,mtError,Retour);
   EditionJournauxTvaL(TypeEdition,DemandePeriode,Maliste,DataSet,Detail);
  except
     abort;
  end;
end;

procedure TDMTmTVA.QuTVAEditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListeFilterRecordEdition.IndexOf(DataSet.FindField('Tvacode').AsString) <> -1;
  end;
end;



procedure TDMTmTVA.QuTVAEditionCalcFields(DataSet: TDataSet);
begin
DataSet.findfield('Part_Declare_Calc').AsFloat:=DataSet.findfield('Part_Declaration').AsFloat * 100;
DataSet.findfield('HT_Declare_Debit').AsCurrency:=DataSet.findfield('HTDebit').AsCurrency*DataSet.findfield('Part_Declaration').AsFloat;
DataSet.findfield('HT_Declare_Credit').AsCurrency:=DataSet.findfield('HTCredit').AsCurrency*DataSet.findfield('Part_Declaration').AsFloat;
if not(DataSet.findfield('Journal').Asinteger in [1,2]) then
  begin
  DataSet.findfield('HT_Declare').AsCurrency:=0;
  DataSet.findfield('HT_Declare_Debit').AsCurrency:=0;
  DataSet.findfield('HT_Declare_Credit').AsCurrency:=0;
  end
else
  DataSet.findfield('HT_Declare').AsCurrency:=DataSet.findfield('HT_Declare_Credit').AsCurrency-DataSet.findfield('HT_Declare_Debit').AsCurrency;
DataSet.findfield('HT_Declare').AsCurrency:=abs(DataSet.findfield('HT_Declare').AsCurrency);
end;

procedure TDMTmTVA.QuTVAEditionAfterOpen(DataSet: TDataSet);
begin
TaEcritureContrepartie.Open;
TFloatField(DataSet.FindField('Part_Declare_calc')).DisplayFormat:='##0.00 "%"';
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
end;


procedure TDMTmTVA.Impression_DeclarationTVAClick(Sender: TObject);
var
detail:boolean;
begin
try//finally
try//except
  if MessageDlg('Voulez-vous imprimer le détail, plutôt que la synthèse des '+#13+#10+'journaux de TVA ?', mtWarning, [mbYes,mbNo], 0)=mryes then
    EditionJournauxTvaL(C_EditionSimple,false,DetailTVAAffichGlobal.ListeCodes,DMTmTVA.QuDec_Tva,true)
  else
    EditionJournauxTvaL(C_EditionSimple,false,DetailTVAAffichGlobal.ListeCodes,DMTmTVA.QuDec_Tva,false);
except
  showmessage('Pas d''impression disponible');
end;
finally
//
end;//fin finally
end;


procedure TDMTmTVA.QuSumParCode_Dec_TvaBeforeOpen(DataSet: TDataSet);
begin
QuSumParCode_Dec_Tva_SurOD.close;
QuSumParCode_Dec_Tva_SurOD.Open;
end;


constructor TEcritureDeclaree.Create(AOwner :TComponent);
Begin
inherited create;
End;

destructor TEcritureDeclaree.Destroy;
Begin
inherited Destroy;
End;



Function DeclarationTVATypeRegulation(DateDeb,DateFin:TDate):Boolean;
var
id:integer;
ExceptLGR_:TExceptLGR;
//MessageLGR:TMessageLGR;
MontantDebit,MontantCredit:currency;
Begin
try//finally
   try//except
   try
   if not DMTmTVA.Verif_Si_Date_HorsDeclarationExistante(DateDeb,DateFin,false).retour then
   except
     // pour ne pas perpétuer l'exception
   end;
   if DMTmTVA = nil then DMTmTVA:=TDMTmTVA.Create(application.MainForm);


     DMTmTVA.QuParcoursH_TvaTypeRegul.Close;
     DMTmTVA.QuParcoursH_TvaTypeRegul.Open ;
     DMTmTVA.QuParcoursH_TvaTypeRegul.first;
//     str_getstringelement(DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Divers').asstring,1,'_');
      while not(DMTmTVA.QuParcoursH_TvaTypeRegul.eof) do
        Begin // Remplissage Ta_Dec
           begin//s'il y a de la tva à déclarer
           id:=DMTmTVA.TaDec_Tva.RecordCount+1;
           MontantDebit:=0;
           MontantCredit:=0;
           if DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('id_declaration').asinteger=-2 then
             begin
                 if DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Montanttva').ascurrency<0 then
                   MontantDebit:=abs(DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Montanttva').ascurrency)
                 else
                   MontantCredit:=abs(DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Montanttva').ascurrency);
             end
           else
             Begin
                 if DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Montanttva').ascurrency>0 then
                   MontantDebit:=abs(DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Montanttva').ascurrency)
                 else
                   MontantCredit:=abs(DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Montanttva').ascurrency);
             end;
//           DMTmTVA.TaDec_Tva.AppendRecord([id,
//                 0,
//                 0,
//                 str_getstringelement(DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Divers').asstring,1,'_'),
//                 'E',
//                 '',
//                 MontantDebit,
//                 MontantCredit,
//                 false,0,
//                 DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('Divers').asstring]);
           DMTmTVA.TaDec_Tva.AppendRecord([id,
                 0,
                 0,
                 DMTmTVA.QuParcoursH_TvaTypeRegul.findfield('CodeCompensation').asstring,
                 'E',
                 datetostr(DateFin),
                 MontantDebit,
                 MontantCredit,
                 false,1,
                 'OK']);
           DMTmTVA.TaDec_Tva.FlushBuffers;
           end;//fin s'il y a de la tva à déclarer
           DMTmTVA.QuParcoursH_TvaTypeRegul.Next;
        End;
   except
     abort;
   end;//fin du try except
finally
//DMTmTVA.QuDec_Tva.close;
DMTmTVA.PrepareQuDec_tva(DateFin);
DMTmTVA.QuDec_Tva.open;
end;//fin du try finally
End;


Procedure TDMTmTVA.PrepareQuDec_tva(FinPeriode:Tdate);
begin
QuDec_Tva.close;
QuDec_Tva.SQL.clear;
QuDec_Tva.SQL.Add('select D.*,P.journal,P.reference,P.compte as CompteContrepartie,P."Date" as DatePiece,P.Libelle as LibellePiece,');
QuDec_Tva.SQL.Add('E.compte as CompteHT,E.Debitsaisie as HTDebit, E.creditsaisie as HTCredit,E.TvaTaux as TauxReel,E.libelle from Dec_Tva D');
QuDec_Tva.SQL.Add('join piece P on (P.id=D.id_piece)');
QuDec_Tva.SQL.Add('join Ecriture E on (E.id=D.id_Ligne)');
QuDec_Tva.SQL.Add('union');
QuDec_Tva.SQL.Add('select D1.*,id,'''+StringVideDixCaractere+''','''+StringVideDixCaractere+''','''+DateTostr(FinPeriode)+''','''+LibelleRegulTva+''',');
QuDec_Tva.SQL.Add(''''+StringVideDixCaractere+''',0,0,0,'''+LibelleRegulTva+'''  from Dec_Tva D1');
QuDec_Tva.SQL.Add('where divers is not null and d1.TvamontantDebit<>0');
QuDec_Tva.SQL.Add('union');
QuDec_Tva.SQL.Add('select D1.*,id,'''+StringVideDixCaractere+''','''+StringVideDixCaractere+''','''+DateTostr(FinPeriode)+''','''+LibelleRegulTva+''',');
QuDec_Tva.SQL.Add(''''+StringVideDixCaractere+''',0,0,0,'''+LibelleRegulTva+'''  from Dec_Tva D1');
QuDec_Tva.SQL.Add('where divers is not null and d1.TvamontantCredit<>0');
QuDec_Tva.SQL.Add('order by D.En_attente,D.TvaCode,D.tvaDate,P.reference');
QuDec_Tva.Prepare;
end;
            //
procedure TDMTmTVA.QuDetailHistoriqueDeclarationFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
accept:=((dataset.FindField('TvaCode').AsString<>'') or ((dataset.FindField('TvaCodeRecup').AsString<>'')and(dataset.FindField('montanttva').Ascurrency<>0)));
end;




Function TDMTmTVA.VerifEcritureDeclaree(idEcriture:integer):boolean;
var
Requete:TQuery;
Begin
try//finally
result:=false;
Requete:=TQuery.Create(self);
Requete.DatabaseName:=DM_C_NomAliasDossier;
Requete.sql.Clear;
Requete.sql.add('Select id_ecriture from h_tva ');
Requete.sql.add('where id_ecriture='+inttostr_lgr(idEcriture)+' and en_attente=false and id_declaration>0');
Requete.Open;
result:=Requete.recordcount<>0;
finally
Requete.close;
LibereObjet(Tobject(Requete));
end;//fin finally
end;


Function TDMTmTVA.VerifPieceDeclaree(idPiece:integer):boolean;
var
Requete:TQuery;
Begin
try//finally
result:=false;
Requete:=TQuery.Create(self);
Requete.DatabaseName:=DM_C_NomAliasDossier;
Requete.sql.Clear;
Requete.sql.add('Select id_piece from h_tva ');
Requete.sql.add('where id_piece='+inttostr_lgr(idPiece)+' and en_attente=false and id_declaration>0');
Requete.Open;
result:=Requete.recordcount<>0;
finally
Requete.close;
LibereObjet(Tobject(Requete));
end;//fin finally
end;

procedure TDMTmTVA.QuResteDC_TvaCalcFields(DataSet: TDataSet);
begin
  QuResteDC_TvaSoldeTiers.AsCurrency:=abs(QuResteDC_TvaCredit.AsCurrency-QuResteDC_TvaDebit.AsCurrency);
  if not (VerifFNumeric(QuResteDC_TvaCredit).VideOUZero)then
    QuResteDC_TvaSensSolde.AsBoolean:=true
  else
  if not VerifFNumeric(QuResteDC_TvaDebit).VideOUZero then
    QuResteDC_TvaSensSolde.AsBoolean:=false;
  //recupérer la date maxi de pointage hors période pour affichage correct des dates de tva
  QuSumPointageDebit.close;
  QuSumPointageDebit.ParamByName('ID_Ecriture').AsInteger:=QuResteDC_TvaID_Ecriture.AsInteger;
  QuSumPointageDebit.open;
  //recupérer la date maxi de pointage hors période pour affichage correct des dates de tva
  QuSumPointageCredit.close;
  QuSumPointageCredit.ParamByName('ID_Ecriture').AsInteger:=QuResteDC_TvaID_Ecriture.AsInteger;
  QuSumPointageCredit.open;

  //recupérer le montantPointé Jusqu'à période
  QuSumPointageDansPeriodeDebit.close;
  QuSumPointageDansPeriodeDebit.ParamByName('ID_Ecriture').AsInteger:=QuResteDC_TvaID_Ecriture.AsInteger;
  QuSumPointageDansPeriodeDebit.open;
  //recupérer le montantPointé Jusqu'à période
  QuSumPointageDansPeriodeCredit.close;
  QuSumPointageDansPeriodeCredit.ParamByName('ID_Ecriture').AsInteger:=QuResteDC_TvaID_Ecriture.AsInteger;
  QuSumPointageDansPeriodeCredit.open;


  if not VerifFNumeric(QuSumPointageDansPeriodeDebit.findfield('MontantPointeDebit')).VideOUZero then
    QuResteDC_TvaMontantPointe.AsCurrency:=QuSumPointageDansPeriodeDebit.findfield('MontantPointeDebit').ascurrency
  else
    if not VerifFNumeric(QuSumPointageDansPeriodeCredit.findfield('MontantPointeCredit')).VideOUZero then
      QuResteDC_TvaMontantPointe.AsCurrency:=QuSumPointageDansPeriodeCredit.findfield('MontantPointeCredit').ascurrency;

  if QuResteDC_TvaSensSolde.AsBoolean then
    begin
      QuResteDC_TvaDateTva.AsDateTime:=QuSumPointageDansPeriodeCreditTvaDateCredit.AsDateTime;
      if QuResteDC_TvaDateTva.AsDateTime=0  then //si pas de pointages dans période
         QuResteDC_TvaDateTva.AsDateTime:=QuSumPointageCreditTvaDateCredit.AsDateTime;
    end
  else
    begin
      QuResteDC_TvaDateTva.AsDateTime:=QuSumPointageDansPeriodeDebitTvaDateDebit.AsDateTime;
      if QuResteDC_TvaDateTva.AsDateTime=0  then //si pas de pointages dans période
         QuResteDC_TvaDateTva.AsDateTime:=QuSumPointageDebitTvaDateDebit.AsDateTime;
    end;
end;

procedure TDMTmTVA.Afficherlasynthse1Click(Sender: TObject);
var
chemin:string;
begin
chemin:=IncludeTrailingPathDelimiter(e.RepertoireExportDossier)
       +'Synt-TVA_'+DateInfos(Periode.DateDeb,'-',true).DateStrFormat+'_au_'+
       DateInfos(Periode.DateFin,'-',true).DateStrFormat+'_'+E.NomDossier + E.NomExo + '.Txt';
//Afficher la synthèse correspond à la période si elle existe
AfficheSyntheseHistoriqueDeclarationTVA(chemin,
       periode);
end;

Function AfficheSyntheseHistoriqueDeclarationTVA(fichier:string;periode:Tperiode):boolean;
var
ParamAffichage:TParamAffichage;
List1:TStringList;
i:integer;
libelle:string;
ObjPrn:TObjetEdition;
begin
try
ObjPrn:=TObjetEdition.Create(application.MainForm);
List1:=TStringList.Create;
result:=false;
if not FileExists(fichier)then exit;
List1.LoadFromFile(fichier);

if (List1.count<>0) and (GetStringElement(list1.Strings[0],1,';')<>'Type') then
  begin
     ObjPrn.FTitreEdition := 'SYNTHESE TVA ';
     ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
     ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;

    ObjPrn.AffichageImp(List1);
  end
else
    begin
        List1.delete(0);
        i:=0;
        if List1.count<>0 then libelle:=GetStringElement(list1.Strings[0],1,';');
        while i<=List1.count-1 do
          begin
            list1.Strings[i]:=list1.Strings[i]+';';
            if (libelle<>GetStringElement(list1.Strings[i],1,';'))and (not empty(libelle)) then
              begin
                if str_commence_par(GetStringElement(list1.Strings[i],2,';'),'SOLDE') then
                  begin
                    list1.Insert(i,';;;;');
                    inc(i);
                    list1.Insert(i,';------------------------------------;------------------------------------;------------------------------------;------------------------------------');
                    inc(i);
                  end;
                list1.Insert(i,';------------------------------------;------------------------------------;------------------------------------;------------------------------------');
                inc(i,2);
                if GetStringElement(list1.Strings[i-1],1,';')='' then
                  list1.Insert(i,';------------------------------------;------------------------------------;------------------------------------;------------------------------------');
              end;
            libelle:=GetStringElement(list1.Strings[i],1,';');
            inc(i);
          end;
        result:=true;
        Initialise_TParamAffichage(ParamAffichage);
        ParamAffichage.AffichModal := true;
        ParamAffichage.Titre:='Synthèse de la déclaration de TVA du '+datetostr(periode.DateDeb)+' au '+datetostr(periode.DateFin) ;
        
             if VisuListeView=nil then VisuListeView:=TVisuListeView.Create(application.MainForm);
             ParamAffichage.EventButtonDetailClick:=VisuListeView.BtnEnregistrerClick;
             ParamAffichage.EventButtonValiderClick:=nil;
             ParamAffichage.EventListViewDbleClick:=VisuListeView.BtnEnregistrerClick;
             result:=AfficheVisuListView(ParamAffichage,['Type','Code tva/Libellé',' H.Taxe',' Tva'],
                                              [200,200,200,200],
                                              [List1],
                                              [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                              [1,2],
                                              [3,4],[]).Retour;
    end;
finally
  if list1<>nil then list1.free;
  LibereObjet(Tobject(ObjPrn));
end;//fin du try finally
End;


procedure TDMTmTVA.PopupMenu1Popup(Sender: TObject);
var
ligne:string;
begin
           Periode.DateDeb:=StrToDate_Lgr(dateInfos_Str(VisuListeView.ItemCourantValeurCol(1)));
           Periode.DateFin:=StrToDate_Lgr(dateInfos_Str(VisuListeView.ItemCourantValeurCol(2)));
  if FileExists(IncludeTrailingPathDelimiter(e.RepertoireExportDossier)
       +'Synt-TVA_'+DateInfos(Periode.DateDeb,'-',true).DateStrFormat+'_au_'+
       DateInfos(Periode.DateFin,'-',true).DateStrFormat+'_'+E.NomDossier + E.NomExo + '.Txt') then
         begin
           TMenuItem(VisuListeView.FindComponent('Afficherlasynthse1')).Visible:=true;
           VisuListeView.Afficherlasynthse1.OnClick:=Afficherlasynthse1Click;
         end
       else
         begin
           TMenuItem(VisuListeView.FindComponent('Afficherlasynthse1')).Visible:=false;
           VisuListeView.Afficherlasynthse1.OnClick:=nil;
         end
end;




end.


