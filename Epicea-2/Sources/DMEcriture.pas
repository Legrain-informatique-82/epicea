unit DMEcriture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db,DMPiece,Gr_Librairie_obj, E2_Librairie_obj,E2_AideCompte, LibSql,
  ObjetEdition,
  editions,
  Printers,
  Piece,
  Ecriture_Isa,
  E2_Decl_Records,
  LibDates,
  LibZoneSaisie,
  E2_AideModel,
  DMTTVA,
  E2_LibInfosTable,
  DMrecherche,
  ChoixPeriode,
  Librairie_Isa,
  LibRessourceString,DiversProjets,
  lib_chaine,
  Variants;

const

  C_TypeEditionLigneSimple = 0;
  C_TypeEditionLigneComplet = 1;
  C_TypeEditionLigneSimple_AvecSoldeBanque = 2;
  C_TypeEditionLigneComplet_AvecSoldeBanque = 3;
  C_TypeEditionLigneSimple_AvecPrixUnitaire = 4;
  C_TypeEditionLigneComplet_AvecPrixUnitaire = 5;
type


  TDMEcritures = class(TDataModule)
    TaEcriture: TTable;
    DataEcriture: TDataSource;
    QueryEcriture: TQuery;
    DataQuery: TDataSource;
    QueryEcritureMAXOFID: TIntegerField;
    QueryEcrCompte: TQuery;
    QueryEcrTiers: TQuery;
    DataQueryEcr: TDataSource;
    TaEcriture2: TTable;
    DataEcriture2: TDataSource;
    TaEcritureT: TTable;
    DaEcritureT: TDataSource;
    TaEcritureTMontantTTC: TCurrencyField;
    QueryMinEcriture: TQuery;
    QueryMinEcritureMINOFID: TIntegerField;
    QueryMaxIDLigne: TQuery;
    QueryMaxIDLigneMAXOFID_Ligne: TSmallintField;
    QuSumEcritureBOT: TQuery;
    QuSumEcritureBOTSomDebit: TFloatField;
    QuSumEcritureBOTSomCredit: TFloatField;
    QuSumEcritureBOTSolde: TFloatField;
    DaSumEcritureBOT: TDataSource;
    DaEcritureBal: TDataSource;
    TaEcritureRecup: TTable;
    QuEcrCompteCodeTva: TQuery;
    QuSumEcrCompteCodeTva: TQuery;
    TaEcritureVisu: TTable;
    DaEcritureVisu: TDataSource;
    TaEcritureRecupTotalPiece: TTable;
    QueryEcrJournal: TQuery;
    QuerySumEcrJournal: TQuery;
    QuCptGaucheTSolde: TQuery;
    QuCptDroiteTSolde: TQuery;
    TaEcriture2ID: TIntegerField;
    TaEcriture2ID_Piece: TIntegerField;
    TaEcriture2TypeLigne: TStringField;
    TaEcriture2ID_Ligne: TSmallintField;
    TaEcriture2Date: TDateField;
    TaEcriture2Compte: TStringField;
    TaEcriture2Tiers: TStringField;
    TaEcriture2Libelle: TStringField;
    TaEcriture2Qt1: TFloatField;
    TaEcriture2Qt2: TFloatField;
    TaEcriture2DebitSaisie: TCurrencyField;
    TaEcriture2CreditSaisie: TCurrencyField;
    TaEcriture2ID_Devise: TIntegerField;
    TaEcriture2Debit: TCurrencyField;
    TaEcriture2Credit: TCurrencyField;
    TaEcriture2TvaCode: TStringField;
    TaEcriture2TvaType: TStringField;
    TaEcriture2TvaTaux: TFloatField;
    TaEcriture2TvaDate: TDateField;
    TaEcriture2Rapprochement: TStringField;
    TaEcriture2Validation: TDateField;
    TaEcriture2Qui: TStringField;
    TaEcriture2Quand: TDateTimeField;
    TaEcriture2Num_Cheque: TStringField;
    TaEcriture2Table_Gen: TStringField;
    TaEcriture2Champ_Gen: TStringField;
    TaEcriture2Val_Champ_Gen: TStringField;
    TaEcriture2ID_GESTCO: TFloatField;
    TaEcriture2CODE_GESTCO: TStringField;
    TaEcritureTID: TIntegerField;
    TaEcritureTID_Piece: TIntegerField;
    TaEcritureTTypeLigne: TStringField;
    TaEcritureTID_Ligne: TSmallintField;
    TaEcritureTDate: TDateField;
    TaEcritureTCompte: TStringField;
    TaEcritureTTiers: TStringField;
    TaEcritureTLibelle: TStringField;
    TaEcritureTQt1: TFloatField;
    TaEcritureTQt2: TFloatField;
    TaEcritureTDebitSaisie: TCurrencyField;
    TaEcritureTCreditSaisie: TCurrencyField;
    TaEcritureTID_Devise: TIntegerField;
    TaEcritureTDebit: TCurrencyField;
    TaEcritureTCredit: TCurrencyField;
    TaEcritureTTvaCode: TStringField;
    TaEcritureTTvaType: TStringField;
    TaEcritureTTvaTaux: TFloatField;
    TaEcritureTTvaDate: TDateField;
    TaEcritureTRapprochement: TStringField;
    TaEcritureTValidation: TDateField;
    TaEcritureTQui: TStringField;
    TaEcritureTQuand: TDateTimeField;
    TaEcritureTNum_Cheque: TStringField;
    TaEcritureTTable_Gen: TStringField;
    TaEcritureTChamp_Gen: TStringField;
    TaEcritureTVal_Champ_Gen: TStringField;
    TaEcritureTID_GESTCO: TFloatField;
    TaEcritureTCODE_GESTCO: TStringField;
    TaEcritureVisuID: TIntegerField;
    TaEcritureVisuID_Piece: TIntegerField;
    TaEcritureVisuTypeLigne: TStringField;
    TaEcritureVisuID_Ligne: TSmallintField;
    TaEcritureVisuDate: TDateField;
    TaEcritureVisuCompte: TStringField;
    TaEcritureVisuTiers: TStringField;
    TaEcritureVisuLibelle: TStringField;
    TaEcritureVisuQt1: TFloatField;
    TaEcritureVisuQt2: TFloatField;
    TaEcritureVisuDebitSaisie: TCurrencyField;
    TaEcritureVisuCreditSaisie: TCurrencyField;
    TaEcritureVisuID_Devise: TIntegerField;
    TaEcritureVisuDebit: TCurrencyField;
    TaEcritureVisuCredit: TCurrencyField;
    TaEcritureVisuTvaCode: TStringField;
    TaEcritureVisuTvaType: TStringField;
    TaEcritureVisuTvaTaux: TFloatField;
    TaEcritureVisuTvaDate: TDateField;
    TaEcritureVisuRapprochement: TStringField;
    TaEcritureVisuValidation: TDateField;
    TaEcritureVisuQui: TStringField;
    TaEcritureVisuQuand: TDateTimeField;
    TaEcritureVisuNum_Cheque: TStringField;
    TaEcritureVisuTable_Gen: TStringField;
    TaEcritureVisuChamp_Gen: TStringField;
    TaEcritureVisuVal_Champ_Gen: TStringField;
    TaEcritureVisuID_GESTCO: TFloatField;
    TaEcritureVisuCODE_GESTCO: TStringField;
    TaEcritureBal: TTable;
    TaEcritureBalID: TIntegerField;
    TaEcritureBalID_Piece: TIntegerField;
    TaEcritureBalID_Ligne: TSmallintField;
    TaEcritureBalDate: TDateField;
    TaEcritureBalCompte: TStringField;
    TaEcritureBalTiers: TStringField;
    TaEcritureBalDebitSaisie: TCurrencyField;
    TaEcritureBalCreditSaisie: TCurrencyField;
    TaEcritureBalLibelle: TStringField;
    TaEcritureBalReference: TStringField;
    Ecriture_Isa1: TEcriture_Isa;
    TaEcritureQuAuxRecup: TTable;
    TaEcritureRecherche: TTable;
    TaEcritureBalT: TTable;
    TaEcritureBalTID: TIntegerField;
    TaEcritureBalTID_Piece: TIntegerField;
    TaEcritureBalTID_Ligne: TSmallintField;
    TaEcritureBalTDate: TDateField;
    TaEcritureBalTCompte: TStringField;
    TaEcritureBalTTiers: TStringField;
    TaEcritureBalTLibelle: TStringField;
    TaEcritureBalTDebitSaisie: TCurrencyField;
    TaEcritureBalTCreditSaisie: TCurrencyField;
    TaEcritureBalTReference: TStringField;
    DaEcritureBalT: TDataSource;
    TaEcritureVisuMontant_Tva: TCurrencyField;
    TaEcritureVisuID_GESTANAL: TIntegerField;
    TaEcritureVisuCODE_GESTANAL: TStringField;
    QuRequeteEcr: TQuery;
    TaEcriture2CompteSaisie: TStringField;
    QuEcriture_Edition: TQuery;
    DataSource1: TDataSource;
    TaEcriture_Obj: TTable;
    QuMaxIdEcriture: TQuery;
    Function MaxIdEcriture(AnneeAnterieure:boolean):Integer;
    Function MaxIdEcriture_Exo(ExoSaisie:string;rajout:integer):Integer;
    Function ID_Piece_Avec_Id_Ecriture(IDEcriture:Integer):Integer;
    procedure CreationEcritures(Reglement:TEcriture_Isa;LibelleEcriture,TLigne,Compte:string;Qte1,Qte2:real;Ds,Cs,D,C:Currency;Devise,Ligne:integer;DateRec:tdate);
    procedure DMEcrituresCreate(Sender: TObject);
    procedure DMEcrituresDestroy(Sender: TObject);
    procedure TaEcritureAfterPost(DataSet: TDataSet);
    procedure TaEcriture2BeforeInsert(DataSet: TDataSet);
    procedure TaEcriture2BeforePost(DataSet: TDataSet);
    procedure ChoixSensEtMontant(tableCourante:TDataSet);
    procedure TaEcritureBeforeDelete(DataSet: TDataSet);
    procedure TaEcritureAfterDelete(DataSet: TDataSet);
    procedure TaEcritureBeforePost(DataSet: TDataSet);
//    function BatchMoveSurTaEcriture(Source:TTable;Mode:tbatchMode):integer;
    function VerifIDEcriture(ID:integer;Ecriture:TEcriture_Isa;Suppr:boolean):TErreurSaisie;//Modif
//    function VerifIDPieceSurTaEcriture(IDPiece:integer;Ecriture:TEcriture_Isa;Suppr:boolean):TErreurSaisie;//Modif
    Function CtrlSaisieEcritureBOTiers(CCourant:Tfield):TErreurSaisie;
    procedure TaEcritureTBeforeCancel(DataSet: TDataSet);
//    procedure RechercheMinIdEcriture;
    procedure TaEcritureTBeforePost(DataSet: TDataSet);
    procedure TaEcritureTBeforeInsert(DataSet: TDataSet);
    procedure TaEcritureTBeforeDelete(DataSet: TDataSet);
    procedure FiltragesAideCompteBOT;
    procedure TaEcritureTCalcFields(DataSet: TDataSet);
    procedure TaEcritureTAfterPost(DataSet: TDataSet);
    procedure TaEcritureTAfterDelete(DataSet: TDataSet);
    procedure TaEcritureTBeforeEdit(DataSet: TDataSet);
    procedure TaEcritureBalBeforeInsert(DataSet: TDataSet);
    procedure TaEcritureBalBeforeEdit(DataSet: TDataSet);
    procedure QuGestVisuCompteBeforeInsert(DataSet: TDataSet);
    procedure QuEcrCompteCodeTvaBeforeInsert(DataSet: TDataSet);
    procedure TaEcritureVisuBeforeInsert(DataSet: TDataSet);
    function BatchMove_Liste_SurTaEcriture(Source:TList;Ecriture:TEcriture_Isa):integer;
    procedure ChoixSensEtMontant_SurPointeurListe(CCourant:PIdentifiant_obj);
    function RechercheIDEcritureExistant(ID_Old:integer):boolean;
    procedure TaEcriturePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaEcritureDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaEcritureBalBeforeDelete(DataSet: TDataSet);
    procedure TaEcritureVisuBeforeOpen(DataSet: TDataSet);
    procedure TaEcritureBalBeforeOpen(DataSet: TDataSet);
    procedure TaEcriture2CalcFields(DataSet: TDataSet);
    procedure QuEcriture_EditionFilterRecordCompte(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuEcriture_EditionFilterRecordTiers(DataSet: TDataSet;
      var Accept: Boolean);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
     ErreurEcriture:boolean;
     listeTvaExigible:tlist;
     TvaExigible:PTvaExigible;
     ListeFiltreEdit : TStringList;
  end;

Const

// ************************************************************************** //
// ***************** Requete concernant les écritures************************ //
// ***************** et exécutée par l'objet QuRequeteEcr ******************* //
// ************************************************************************** //

Sum_Compte_DateDeb_DateFin_PourCompte = ' Select Ecr.Compte, ' +
                             ' sum(Ecr.DebitSaisie) as TotDebit, ' +
                             ' Sum(Ecr.CreditSaisie) as TotCredit ' +
                             ' from Ecriture Ecr ' +
                             ' join Piece Pi on (Pi.ID=Ecr.ID_Piece) ' +
                             ' where ' +
                             ' Pi."Date" between :DateDeb and :DateFin ' +
                             ' and Ecr.Compte =:Cpt ' +
                             ' group by Ecr.Compte ';
Sum_Compte_DateDeb_DateFin_PourTiers = ' Select Ecr.Tiers, ' +
                             ' sum(Ecr.DebitSaisie) as TotDebit, ' +
                             ' Sum(Ecr.CreditSaisie) as TotCredit ' +
                             ' from Ecriture Ecr ' +
                             ' join Piece Pi on (Pi.ID=Ecr.ID_Piece) ' +
                             ' where ' +
                             ' Pi."Date" between :DateDeb and :DateFin ' +
                             ' and Ecr.tiers =:Cpt' +
                             ' group by Ecr.tiers ';

var
  DMEcritures: TDMEcritures;
  DebCredEcriture,compteEcriture,TiersEcriture,QteEcriture1,QteEcriture2:string;
  montantEcriture:currency;
  Qt1,Qt2:real;
  dernierlibelle:string;
  MessDerSub:boolean;
  Function EditionEcritureL(TypeEdition,TypeEditionLigne : integer; DemandePeriode:Tperiode; ListeCompte,LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList; overload;
  Function EditionEcritureL(TypeEdition,TypeEditionLigne : integer; DemandePeriode:boolean; ListeCompte,LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList; overload;
  Function EditionEcritureL(TypeEdition,TypeEditionLigne : integer; DemandePeriode:Tperiode; Compte:String;LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;overload;
  Function EditionEcritureL(TypeEdition,TypeEditionLigne : integer; DemandePeriode:boolean; Compte:String;LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;overload
  Function EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne : integer; DemandePeriode:Tperiode; ListeCompte,LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;
  Function EditionEcritureL_AvecPrixUnitaire(TypeEdition,TypeEditionLigne : integer; DemandePeriode:Tperiode; ListeCompte,LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;
  Function DEtailEcritures(TypeDetail:Integer;CompteOuJournal,CodeTVA:String;Affichage,AffichChoixPeriode,AutrePeriode:Boolean;Periode:TPeriode):Boolean;
  Function DetailEcritureJournal(Journal:String;Affichage:Boolean):boolean;
  Function DetailEcritureCompte(cpt:string;Affichage:Boolean;AffichChoixPeriode:Boolean=true;PeriodeDiff:boolean=false):boolean;
  Function DetailEcritureCompteTVA(cptTva,CodeTVA:string;Affichage:Boolean):boolean;
//  Function DetailEcritureTiers(cpt:string;Affichage:Boolean):boolean;
  Function DetailEcritureTiers(cpt:string;Affichage:Boolean;AffichChoixPeriode:Boolean=true;PeriodeDiff:boolean=false):boolean;
  Function PieceEcritureJournal(Modifiable:boolean= true):boolean;
  Function PieceEcritureTiers(Modifiable:boolean= true):boolean;
  Function PieceEcritureCompte(Modifiable:boolean= true):boolean;
  Function PieceEcritureCompteTva(Modifiable:boolean= true):boolean;
  Function NBE:integer;

implementation

uses E2_DetailEcr, E2_TabVisuPiece2, DMBalances,DMTVA,DMPlanCpt,
ModuleTrame,E2_SaisieP_3,DMDiocEtatBalance, DMTier,DMDiocEtatBalanceT,
  DMPointages2, DMAnalytique, E2_Test1,DMExports, DmImportReleves;
{$R *.DFM}

Function EditionEcritureL(TypeEdition,TypeEditionLigne : integer; DemandePeriode:Tperiode; Compte:String;LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;
Var
ListeCompte:TStringList;
Begin
ListeCompte:=TStringList.Create;
ListeCompte.Add(Compte);
DeFiltrageDataSet(dmrech.TaModelRech);
if ((not (typeEditionLigne in [4,5]))and (Infos_TInfosModel(dmrech.TaModelRech,'Compte',[compte]).ID_Journal=4 ))then typeEditionLigne:=typeEditionLigne+2;
case typeEditionLigne of
   2,3:result:=EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne,DemandePeriode,ListeCompte,LigneEdition,DataSet,sautDePage);
   4,5:result:=EditionEcritureL_AvecPrixUnitaire(TypeEdition,TypeEditionLigne,DemandePeriode,ListeCompte,LigneEdition,DataSet,sautDePage);
   else result:=EditionEcritureL(TypeEdition,TypeEditionLigne,DemandePeriode,ListeCompte,LigneEdition,DataSet,sautDePage);
end;//fin du case typeEditionLigne
//if ((typeEditionLigne in [3,4])or(Infos_TInfosModel(dmrech.TaModelRech,'Compte',[compte]).ID_Journal=4 )) then
//  EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne,DemandePeriode,ListeCompte,LigneEdition,DataSet,Site)
//else
//  EditionEcritureL(TypeEdition,TypeEditionLigne,DemandePeriode,ListeCompte,LigneEdition,DataSet,Site);
////EditionEcritureL(TypeEdition,Quand,DataSet,ListeCompte,Site);
End;

Function EditionEcritureL(TypeEdition,TypeEditionLigne : integer; DemandePeriode:boolean; ListeCompte,LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList; overload;
Var
Periode:TPeriode;
Begin
Periode.DateDeb:=e.DatExoDebut;
Periode.Datefin:=e.DatExofin;
Periode.retour:=demandePeriode;
//if ((not (typeEditionLigne in [4,5]))and (Infos_TInfosModel(dmrech.TaModelRech,'Compte',[compte]).ID_Journal=4 ))then typeEditionLigne:=typeEditionLigne+2;
case typeEditionLigne of
   2,3:result:=EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,sautDePage);
   4,5:result:=EditionEcritureL_AvecPrixUnitaire(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,sautDePage);
   else result:=EditionEcritureL(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,sautDePage);
end;//fin du case typeEditionLigne
//if typeEditionLigne in [3,4] then
//  EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,Site)
//else
//  EditionEcritureL(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,Site);
End;

Function EditionEcritureL(TypeEdition,TypeEditionLigne : integer; DemandePeriode:boolean; Compte:String;LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;
Var
ListeCompte:TStringList;
Periode:TPeriode;
Begin
Periode.DateDeb:=e.DatExoDebut;
Periode.Datefin:=e.DatExofin;
Periode.retour:=demandePeriode;
ListeCompte:=TStringList.Create;
ListeCompte.Add(Compte);
DeFiltrageDataSet(dmrech.TaModelRech);
if ((not (typeEditionLigne in [4,5]))and (Infos_TInfosModel(dmrech.TaModelRech,'Compte',[compte]).ID_Journal=4 ))then typeEditionLigne:=typeEditionLigne+2;
case typeEditionLigne of
   2,3:result:=EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,sautDePage);
   4,5:result:=EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,sautDePage);
   else result:=EditionEcritureL(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,sautDePage);
end;//fin du case typeEditionLigne
//if ((typeEditionLigne in [3,4])or(Infos_TInfosModel(dmrech.TaModelRech,'Compte',[compte]).ID_Journal=4 )) then
//  EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,Site)
//else
//  EditionEcritureL(TypeEdition,TypeEditionLigne,Periode,ListeCompte,LigneEdition,DataSet,Site);
End;

Function EditionEcritureL(TypeEdition,TypeEditionLigne : integer; DemandePeriode:Tperiode; ListeCompte,LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;
var
NomFich,Chemin:String;
NomMenuSiteWeb:TfileStream;
ListeValeur,ListeEdition,ListeEditionReduite:TStringList;
ObjPrn:TObjetEdition;
periode:TPeriode;
TotauxReportEtSoldeFin:TTotauxBalance;
ValeurCompte:String;
Nom:string;
Compte:string;
TotDebit,TotCredit, TotQte1,TotQte2 : Currency;
ParamAffichPeriode:TParamAffichPeriode;
TotSoldeReportDebit, TotSoldeReportCredit,
TotSoldeReportQt1, TotSoldeReportQt2,
TotMouvementPeriodeDebit, TotMouvementPeriodeCredit,
TotTotauxDebit, TotTotauxCredit ,
TotTotauxQt1,TotTotauxQt2,
TotSoldeDebit, TotSoldeCredit,
SoldeDebit, SoldeCredit,
TotTotQte1, TotTotQte2 : Currency;
Debut,Fin:TTime;
begin
try//finally
ObjPrn:=TObjetEdition.Create(application.MainForm);
Debut:=Time;
if DemandePeriode.datefin=0 then
  begin
    DemandePeriode.DateDeb:=e.DatExoDebut;
    DemandePeriode.DateFin:=e.DatExoFin;
  end;
 if ((DemandePeriode.Retour) and (TypeEdition<>C_ExportationLiasse))then
   Begin
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(DemandePeriode.DateDeb,DemandePeriode.DateFin,'',ParamAffichPeriode);
   end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := DemandePeriode.DateDeb;
     periode.DateFin := DemandePeriode.DateFin;
    end;
if periode.DateDeb<e.DatExoDebut then
  begin
      periode.Retour:=false;
      showmessage(AccesProcedureRefuse_SurDate);
  end;

  if periode.Retour then
  begin
     Screen.Cursor := crSQLWait;
     if DMEcritures=nil then DMEcritures:=TDMEcritures.Create(Application.MainForm);

     if dataset = nil then
      begin
//          DetailEcritureTiers(DataSet.FindField('Tiers').AsString,false);
        // Prevu pour passer le dataset concerné
      end;
     ListeValeur:=TStringList.Create;
     ListeEdition:=TStringList.Create;
     ListeEditionReduite:=TStringList.Create;

     ObjPrn.FontLigneSeule.Style := [fsBold];

     DMEcritures.QuEcriture_Edition.Close;
     DMEcritures.QuEcriture_Edition.Filtered := true;
     if ListeCompte <> nil then
      begin
       DMEcritures.ListeFiltreEdit.Assign(ListeCompte);
       if ListeCompte.Count > 0 then
        begin
          if TypeCptTiers(ListeCompte.Strings[0]) then
            begin
             DMEcritures.QuEcriture_Edition.OnFilterRecord := DMEcritures.QuEcriture_EditionFilterRecordTiers;
            end
           else
            begin
             DMEcritures.QuEcriture_Edition.OnFilterRecord := DMEcritures.QuEcriture_EditionFilterRecordCompte;
            end;
        end;
      //end;

     DMEcritures.QuEcriture_Edition.SQL.Clear;
     DMEcritures.QuEcriture_Edition.Params.Clear;



     DMEcritures.QuEcriture_Edition.SQL.Add('select distinct E."Date", E.Compte, E.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from Piece P ');
     DMEcritures.QuEcriture_Edition.SQL.Add(' join Ecriture E on (P.ID=E.Id_Piece) ');
     DMEcritures.QuEcriture_Edition.SQL.Add(' where E."Date" between :DateDeb and :DateFin');
     DMEcritures.QuEcriture_Edition.SQL.Add(' union all');
      if ((ListeCompte.Count > 0)and(TypeCptTiers(ListeCompte.Strings[0]))) then
        begin
         DMEcritures.QuEcriture_Edition.SQL.Add(' select distinct E."Date", B.Compte, B.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from "'+E.RepertoireExercice+'BalanceTiers" B');
         DMEcritures.QuEcriture_Edition.SQL.Add(' order by E.Compte,E.Tiers, E."Date", P.Reference, P.Compte ');
        end
       else
        begin
         DMEcritures.QuEcriture_Edition.SQL.Add(' select distinct E."Date", B.Compte, E.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from "'+E.RepertoireExercice+'Balance" B');
         DMEcritures.QuEcriture_Edition.SQL.Add(' order by E.Compte, E."Date", P.Reference, P.Compte ');
        end;

     DMEcritures.QuEcriture_Edition.Params[0].DataType := ftDAte;
     DMEcritures.QuEcriture_Edition.Params[0].AsDate := periode.DateDeb;
     DMEcritures.QuEcriture_Edition.Params[1].DataType := ftDAte;
     DMEcritures.QuEcriture_Edition.Params[1].AsDate := periode.DateFin;
     if not DMEcritures.QuEcriture_Edition.Prepared then
      DMEcritures.QuEcriture_Edition.Prepare;

     DMEcritures.QuEcriture_Edition.Open;
//     if Test1 = nil then Test1 := TTest1.Create(nil);
//     Test1.Show;

     DMEcritures.QuEcriture_Edition.First;
     if  ((DMEcritures.QuEcriture_Edition.recordcount<>0) and (ListeCompte.Count > 0)) then
     begin
      if TypeCptTiers(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString) then
        begin
//         ListeValeur.Add('7;TIERS : '+DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString);
           ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
         ListeValeur.Add('14;Tiers : '+DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString+' - '+
           DMTiers.LibelleDuTiers(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString));
         if Periode.DateDeb<e.DatExoDebut then
           InitialiseTotauxBalance(TotauxReportEtSoldeFin)
         else
           TotauxReportEtSoldeFin:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString); //ier passage dans calcul alors forcer la fermeture des requetes
        end
       else
        begin
//         ListeValeur.Add('13;COMPTE : '+DMEcritures.QuEcriture_Edition.FindField('Compte').AsString + ' - ' + DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString)+';0;12;1');
//         ListeValeur.Add('7;COMPTE : '+DMEcritures.QuEcriture_Edition.FindField('Compte').AsString + ' - ' + DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString));
           ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
         if Periode.DateDeb<e.DatExoDebut then
             InitialiseTotauxBalance(TotauxReportEtSoldeFin)
         else
             TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceParCompte(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Compte').AsString);//ier passage dans sommetotauxbalance donc forcer le close
         ListeValeur.Add('14;Compte : '+DMEcritures.QuEcriture_Edition.FindField('Compte').AsString + ' - ' + DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString));
        end;
     ListeEdition.Add('Compte;Date;Reference;Libelle;C.Partie;Débit;Crédit;Qt1;Qt2');
     ListeEditionReduite.Add('GLivreQte;Compte;Qt1');

     TotSoldeReportDebit := TotauxReportEtSoldeFin.TotalSoldeDebitReport;
     TotSoldeReportCredit := TotauxReportEtSoldeFin.TotalSoldeCreditReport;
     TotSoldeReportQt1:=TotauxReportEtSoldeFin.TotalQt1Report;
     TotSoldeReportQt2:=TotauxReportEtSoldeFin.TotalQt2Report;

     if Periode.DateDeb<e.DatExoDebut then
       begin
         ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ');
         ListeEdition.Add(ValeurCompte+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ');
       end
     else
       begin
         ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report));
         ListeEdition.Add(ValeurCompte+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report));
       end;
//     ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+CurrToStr(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+CurrToStr(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+'; ; ; ');
                 while not DMEcritures.QuEcriture_Edition.Eof do
                   begin

                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin
                         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
                      end
                     else
                      begin
                         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
                      end;

                    if not empty(DMEcritures.QuEcriture_Edition.FindField('Reference').AsString) then
                     begin
                      TotDebit:=DMEcritures.QuEcriture_Edition.FindField('Debit').AsCurrency + TotDebit;
                      TotCredit:=DMEcritures.QuEcriture_Edition.FindField('Credit').AsCurrency +TotCredit;
                      TotQte1:=DMEcritures.QuEcriture_Edition.FindField('Qt1').AsCurrency + TotQte1;
                      TotQte2:=DMEcritures.QuEcriture_Edition.FindField('Qt2').AsCurrency +TotQte2;
                      ListeEdition.Add(GereLibelle(ValeurCompte)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Date').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Reference').AsString+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Libelle').AsString)+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('CompteP').AsString)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Debit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Credit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Qt1').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Qt2').AsString
                                       );
                      ListeValeur.Add('0'+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Date').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Reference').AsString+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Libelle').AsString)+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('CompteP').AsString)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Debit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Credit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Qt1').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Qt2').AsString
                                       );
                     end;
                    DMEcritures.QuEcriture_Edition.Next;
                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin
                        if ValeurCompte <> DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString then
                         begin
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1)+ ' ;' +CurrToStr(TotQte2)+';');

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;


                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ' ;' +CurrToStr(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';');
                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE TIERS  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ' ;' +CurrToStr(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';');
                          if (sautDePage)then ListeValeur.add('20');

                          ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
                          if Periode.DateDeb<e.DatExoDebut then
                            InitialiseTotauxBalance(TotauxReportEtSoldeFin)
                          else
                            TotauxReportEtSoldeFin:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString,false);

                          TotSoldeReportDebit := TotSoldeReportDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotSoldeReportCredit := TotSoldeReportCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
                          TotSoldeReportQt1:=TotSoldeReportQt1+TotauxReportEtSoldeFin.TotalQt1Report;
                          TotSoldeReportQt2:=TotSoldeReportQt2+TotauxReportEtSoldeFin.TotalQt2Report;

                          ListeValeur.Add('12;;');
                          ListeValeur.Add('14;Tiers : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString)+' - '+
           GereLibelle(DMTiers.LibelleDuTiers(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString)));
//                          ListeValeur.Add('4;Date ;Référence ;Désignation ; C.Partie ; Débit ; Crédit ; Qté 1 ; Qté 2 ');
                          if Periode.DateDeb<e.DatExoDebut then
                            begin
                              ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ');
                              ListeEdition.Add(valeurCompte+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ');
                            end
                          else
                            begin
                              ListeValeur.Add('3;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report));
                              ListeEdition.Add(ValeurCompte+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report));
                            end;
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                         end;
                      end
                     else
                      begin
                        if ValeurCompte <> DMEcritures.QuEcriture_Edition.FindField('Compte').AsString then
                         begin
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1)+ ' ;' +CurrToStr(TotQte2)+';');

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;


                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ' ;' +CurrToStr(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';');
                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ' ;' +CurrToStr(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';');
                          ListeEditionReduite.add('GLivreQte;'+GereLibelle(ValeurCompte)+';'+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report));
                          ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
                          if Periode.DateDeb<e.DatExoDebut then
                            InitialiseTotauxBalance(TotauxReportEtSoldeFin)
                          else
                            TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceParCompte(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Compte').AsString,false);

                          TotSoldeReportDebit := TotSoldeReportDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotSoldeReportCredit := TotSoldeReportCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
                          TotSoldeReportQt1:=TotSoldeReportQt1+TotauxReportEtSoldeFin.TotalQt1Report;
                          TotSoldeReportQt2:=TotSoldeReportQt2+TotauxReportEtSoldeFin.TotalQt2Report;

                          ListeValeur.Add('12;;');
                          ListeValeur.Add('14;Compte : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString) + ' - ' + GereLibelle(DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString)));
//                          ListeValeur.Add('4;Date ;Référence ;Désignation ; C.Partie ; Débit ; Crédit ; Qté 1 ; Qté 2 ');
                          if Periode.DateDeb<e.DatExoDebut then
                            begin
                              ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ');
                              ListeEdition.Add(ValeurCompte+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ');
                            end
                          else
                            begin
                              ListeValeur.Add('3;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report));
                              ListeEdition.Add(ValeurCompte+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report));
                            end;
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                         end;
                      end;
                   end;
                   // Dernier Compte Ou Tiers
                   // Tiers
                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin

                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1)+ ' ;' +CurrToStr(TotQte2)+';');

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;

                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ' ;' +CurrToStr(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';');

                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE TIERS  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ' ;' +CurrToStr(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';');
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                      end
                     else
                      begin // Compte
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1)+ ' ;' +CurrToStr(TotQte2)+';');

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;

                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
                              
                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ' ;' +CurrToStr(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';');

                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ' ;' +CurrToStr(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';');
                          ListeEditionReduite.add('GLivreQte;'+GereLibelle(ValeurCompte)+';'+CurrToStr(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report));
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                      end;

                      // Affichage des totaux généraux
                      if ListeCompte.Count > 1 then
                       begin
                         ListeValeur.Add('12;;');
                         if (sautDePage)then ListeValeur.add('20');
                         ListeValeur.Add('14;Totaux Généraux ');
//                         TotSoldeReportDebit := TotSoldeReportDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
//                         TotSoldeReportCredit := TotSoldeReportCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
//                          TotSoldeReportQt1:=TotSoldeReportQt1+TotauxReportEtSoldeFin.TotalQt1Report;
//                          TotSoldeReportQt2:=TotSoldeReportQt2+TotauxReportEtSoldeFin.TotalQt2Report;

                         if Periode.DateDeb<e.DatExoDebut then
                           ListeValeur.Add('3;;;; @TOTAL SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ; ')
                         else
                           ListeValeur.Add('3;;;; @TOTAL SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotSoldeReportDebit)+';'+E.FormatCurrSansDevise(TotSoldeReportCredit)+';'+E.FormatCurrSansDevise(TotSoldeReportQt1)+';'+E.FormatCurrSansDevise(TotSoldeReportQt2));
                         ListeValeur.Add('3;;;; @TOTAL MOUVEMENTS PERIODE : ;'+E.FormatCurrSansDevise(TotMouvementPeriodeDebit)+';'+E.FormatCurrSansDevise(TotMouvementPeriodeCredit)+'; '+E.FormatCurrSansDevise(TotTotQte1)+ ' ;' +E.FormatCurrSansDevise(TotTotQte2)+';');
                         TotTotauxDebit := TotSoldeReportDebit + TotMouvementPeriodeDebit;
                         TotTotauxCredit := TotSoldeReportCredit + TotMouvementPeriodeCredit;
                         TotTotauxQt1 := TotSoldeReportQt1 + TotTotQte1;
                         TotTotauxQt2 := TotSoldeReportQt2 + TotTotQte2;

                         ListeValeur.Add('3;;;; @TOTAL TOTAUX : ;'+E.FormatCurrSansDevise(TotTotauxDebit)+';'+E.FormatCurrSansDevise(TotTotauxCredit)+';'+E.FormatCurrSansDevise(TotTotauxQt1)+';'+E.FormatCurrSansDevise(TotTotauxQt2));

                         TotSoldeDebit := TotSoldeDebit + TotDebit;
                         TotSoldeCredit := TotSoldeCredit + TotCredit;

                         ListeValeur.Add('4;;;; @TOTAL SOLDE : ;'+E.FormatCurrSansDevise(TotSoldeDebit)+';'+E.FormatCurrSansDevise(TotSoldeCredit)+';'+E.FormatCurrSansDevise(TotTotauxQt1)+';'+E.FormatCurrSansDevise(TotTotauxQt2));

                         DetermineSolde(TotSoldeDebit,TotSoldeCredit);
                         ListeValeur.Add('4;;;; @SOLDE : ;'+E.FormatCurrSansDevise(TotSoldeDebit)+';'+E.FormatCurrSansDevise(TotSoldeCredit)+';'+E.FormatCurrSansDevise(TotTotauxQt1)+';'+E.FormatCurrSansDevise(TotTotauxQt2));

                       end;

     DMEcritures.QuEcriture_Edition.Close;
     DMEcritures.QuEcriture_Edition.Filtered := false;

               case TypeEditionLigne of
                C_TypeEditionLigneSimple:Begin
                                           LigneEdition.Assign(ListeValeur);
                                         End;

                C_TypeEditionLigneComplet:Begin
                                           if ListeCompte.Count = 1 then
                                            begin
                                              if TypeCptTiers(ListeCompte.Strings[0]) then
                                                begin
                                                  ObjPrn.FTitreEdition := 'Ecritures pour le Tiers : '+ ListeCompte.Strings[0];
                                                  Nom:='Ecriture_Tiers';
                                                end
                                               else
                                                begin
                                                  ObjPrn.FTitreEdition := 'Ecritures pour le compte : '+ ListeCompte.Strings[0]+ ' - '+ DMPlan.LibelleDuNumCptPCU(ListeCompte.Strings[0]);
                                                  Nom:='Ecriture_Compte';
                                                end;
                                            end
                                           else
                                            begin
                                              if TypeCptTiers(ListeCompte.Strings[0]) then
                                                begin
                                                  ObjPrn.FTitreEdition := 'Grand Livre des Tiers ';
                                                  Nom:='GdLivre_Tiers';
                                                end
                                               else
                                                begin
                                                  ObjPrn.FTitreEdition := 'Grand Livre des Comptes ';
                                                  Nom:='GdLivre_Comptes';
                                                end;
                                            end;
                                           ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
                                           ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                                           ListeValeur.Insert(0,' Date ; Référence ; Désignation ; C.Partie ; Débit ; Crédit ; Qté 1 ; Qté 2 ');
                                           ListeValeur.Insert(1,'0.7;0.7;2.0;0.8;1;1;0.7;0.7');
                                           ListeValeur.Insert(2,'texte;texte;texte;texte;curr;curr;Float;Float');
                                          End;
                else MessageDlg('EditionEcritureL: Le TypeEditionLigne ('+IntToStr(TypeEditionLigne)+') n''est pas défini !', mtWarning, [mbOK], 0);
               end; //}
     end;
Fin:=Time;
//showmessage('Début : '+timetostr(Debut)+', Fin : '+timetostr(Fin));
if Type_version_execution=ct_developpement then
  showmessage('Temp : '+timetostr(Fin-Debut));
         case TypeEdition of
             C_Exportation: ExportDonnees(ListeEdition,E.RepertoireExportDossier,Nom+'_'+E.NomDossier + E.NomExo + '.Txt') ;
             C_ExportationLiasse:
             begin
                 try
                   result:=ListeEditionReduite;
                 except
                 end;
             end;
           else
             ObjPrn.AffichageImp(ListeValeur);
         end;//fin du case typeedition
//  ListeValeur.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'GrandLivre_'+inttostr(ListeValeur.count)+'.txt');
   end;//si listecompte <>nil
  end; // Fin periode.retour
Screen.Cursor := crDefault;
finally
     LibereObjet(Tobject(ObjPrn));
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
     //Initialise_TStringlist(ListeEditionReduite);
//   ObjPrn.destroy;
end;
End;


Function EditionEcritureL_AvecPrixUnitaire(TypeEdition,TypeEditionLigne : integer; DemandePeriode:Tperiode; ListeCompte,LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;
var
NomFich,Chemin:String;
NomMenuSiteWeb:TfileStream;
ListeValeur,ListeEdition:TStringList;
ObjPrn:TObjetEdition;
periode:TPeriode;
TotauxReportEtSoldeFin:TTotauxBalance;
ValeurCompte:String;
Nom:string;
TotDebit,TotCredit, TotQte1,TotQte2 ,PU1,PU2: Currency;
ParamAffichPeriode:TParamAffichPeriode;
TotSoldeReportDebit, TotSoldeReportCredit,
TotSoldeReportQt1, TotSoldeReportQt2,
TotMouvementPeriodeDebit, TotMouvementPeriodeCredit,
TotTotauxDebit, TotTotauxCredit ,
TotTotauxQt1,TotTotauxQt2,
TotSoldeDebit, TotSoldeCredit,
SoldeDebit, SoldeCredit,
TotTotQte1, TotTotQte2 : Currency;
Debut,Fin:TTime;
begin
try//finally
ObjPrn:=TObjetEdition.Create(application.MainForm);
Debut:=Time;
if DemandePeriode.datefin=0 then
  begin
    DemandePeriode.DateDeb:=e.DatExoDebut;
    DemandePeriode.DateFin:=e.DatExoFin;
  end;
 if DemandePeriode.Retour then
   Begin
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(DemandePeriode.DateDeb,DemandePeriode.DateFin,'',ParamAffichPeriode);
   end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := DemandePeriode.DateDeb;
     periode.DateFin := DemandePeriode.DateFin;
    end;
if periode.DateDeb<e.DatExoDebut then
  begin
      periode.Retour:=false;
      showmessage(AccesProcedureRefuse_SurDate);
  end;

  if periode.Retour then
  begin
     Screen.Cursor := crSQLWait;
     if DMEcritures=nil then DMEcritures:=TDMEcritures.Create(Application.MainForm);

     if dataset = nil then
      begin
//          DetailEcritureTiers(DataSet.FindField('Tiers').AsString,false);
        // Prevu pour passer le dataset concerné
      end;
     ListeValeur:=TStringList.Create;
     ListeEdition:=TStringList.Create;
     ObjPrn.FontLigneSeule.Style := [fsBold];

     DMEcritures.QuEcriture_Edition.Close;
     DMEcritures.QuEcriture_Edition.Filtered := true;
     if ListeCompte <> nil then
      begin
       DMEcritures.ListeFiltreEdit.Assign(ListeCompte);
       if ListeCompte.Count > 0 then
        begin
          if TypeCptTiers(ListeCompte.Strings[0]) then
            begin
             DMEcritures.QuEcriture_Edition.OnFilterRecord := DMEcritures.QuEcriture_EditionFilterRecordTiers;
            end
           else
            begin
             DMEcritures.QuEcriture_Edition.OnFilterRecord := DMEcritures.QuEcriture_EditionFilterRecordCompte;
            end;
        end;
      //end;

     DMEcritures.QuEcriture_Edition.SQL.Clear;
     DMEcritures.QuEcriture_Edition.Params.Clear;



     DMEcritures.QuEcriture_Edition.SQL.Add('select distinct E."Date", E.Compte, E.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from Piece P ');
     DMEcritures.QuEcriture_Edition.SQL.Add(' join Ecriture E on (P.ID=E.Id_Piece) ');
     DMEcritures.QuEcriture_Edition.SQL.Add(' where E."Date" between :DateDeb and :DateFin');
     DMEcritures.QuEcriture_Edition.SQL.Add(' union all');
      if ((ListeCompte.Count > 0)and(TypeCptTiers(ListeCompte.Strings[0]))) then
        begin
         DMEcritures.QuEcriture_Edition.SQL.Add(' select distinct E."Date", B.Compte, B.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from "'+E.RepertoireExercice+'BalanceTiers" B');
         DMEcritures.QuEcriture_Edition.SQL.Add(' order by E.Compte,E.Tiers, E."Date", P.Reference, P.Compte ');
        end
       else
        begin
         DMEcritures.QuEcriture_Edition.SQL.Add(' select distinct E."Date", B.Compte, E.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from "'+E.RepertoireExercice+'Balance" B');
         DMEcritures.QuEcriture_Edition.SQL.Add(' order by E.Compte, E."Date", P.Reference, P.Compte ');
        end;

     DMEcritures.QuEcriture_Edition.Params[0].DataType := ftDAte;
     DMEcritures.QuEcriture_Edition.Params[0].AsDate := periode.DateDeb;
     DMEcritures.QuEcriture_Edition.Params[1].DataType := ftDAte;
     DMEcritures.QuEcriture_Edition.Params[1].AsDate := periode.DateFin;
     if not DMEcritures.QuEcriture_Edition.Prepared then
      DMEcritures.QuEcriture_Edition.Prepare;

     DMEcritures.QuEcriture_Edition.Open;
//     if Test1 = nil then Test1 := TTest1.Create(nil);
//     Test1.Show;

     DMEcritures.QuEcriture_Edition.First;
     if  ((DMEcritures.QuEcriture_Edition.recordcount<>0) and (ListeCompte.Count > 0)) then
     begin
      ListeEdition.Add('Compte;Date;Reference;Libellé;C.Partie;Débit;Crédit;Qt1;P.U.1;Qt2;P.U.2');
      if TypeCptTiers(DMEcritures.QuEcriture_Edition.FindField('tiers').AsString) then
        begin
//         ListeValeur.Add('7;TIERS : '+DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString);
         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
         ListeValeur.Add('14;Tiers : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString)+' - '+
           DMTiers.LibelleDuTiers(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString));
         if Periode.DateDeb<e.DatExoDebut then
           InitialiseTotauxBalance(TotauxReportEtSoldeFin)
         else
           TotauxReportEtSoldeFin:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('tiers').AsString); //ier passage dans calcul alors forcer la fermeture des requetes
        end
       else
        begin
//         ListeValeur.Add('13;COMPTE : '+DMEcritures.QuEcriture_Edition.FindField('Compte').AsString + ' - ' + DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString)+';0;12;1');
//         ListeValeur.Add('7;COMPTE : '+DMEcritures.QuEcriture_Edition.FindField('Compte').AsString + ' - ' + DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString));
         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
         if Periode.DateDeb<e.DatExoDebut then
             InitialiseTotauxBalance(TotauxReportEtSoldeFin)
         else
             TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceParCompte(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Compte').AsString);//ier passage dans sommetotauxbalance donc forcer le close
         ListeValeur.Add('14;Compte : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString) + ' - ' + GereLibelle(DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString)));
        end;

     TotSoldeReportDebit := TotauxReportEtSoldeFin.TotalSoldeDebitReport;
     TotSoldeReportCredit := TotauxReportEtSoldeFin.TotalSoldeCreditReport;
     TotSoldeReportQt1:=TotauxReportEtSoldeFin.TotalQt1Report;
     TotSoldeReportQt2:=TotauxReportEtSoldeFin.TotalQt2Report;

     if Periode.DateDeb<e.DatExoDebut then
       begin
         ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ; ; ');
         ListeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ; ; ');
       end
     else
       begin
         ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt1))+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt2)));
         ListeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt1))+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt2)));
       end;
                 while not DMEcritures.QuEcriture_Edition.Eof do
                   begin

                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin
                         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
                      end
                     else
                      begin
                         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
                      end;

                    if not empty(DMEcritures.QuEcriture_Edition.FindField('Reference').AsString) then
                     begin
                      TotDebit:=DMEcritures.QuEcriture_Edition.FindField('Debit').AsCurrency + TotDebit;
                      TotCredit:=DMEcritures.QuEcriture_Edition.FindField('Credit').AsCurrency +TotCredit;
                      PU1:=GereDivision((DMEcritures.QuEcriture_Edition.FindField('Debit').AsCurrency+DMEcritures.QuEcriture_Edition.FindField('Credit').AsCurrency),DMEcritures.QuEcriture_Edition.FindField('Qt1').AsCurrency);
                      PU2:=GereDivision((DMEcritures.QuEcriture_Edition.FindField('Debit').AsCurrency+DMEcritures.QuEcriture_Edition.FindField('Credit').AsCurrency),DMEcritures.QuEcriture_Edition.FindField('Qt2').AsCurrency);
                      TotQte1:=DMEcritures.QuEcriture_Edition.FindField('Qt1').AsCurrency + TotQte1;
                      TotQte2:=DMEcritures.QuEcriture_Edition.FindField('Qt2').AsCurrency +TotQte2;
                      ListeEdition.Add(GereLibelle(ValeurCompte)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Date').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Reference').AsString+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Libelle').AsString)+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('CompteP').AsString)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Debit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Credit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Qt1').AsString+
                                       ';'+
                                       currtostr_lgr(PU1)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Qt2').AsString+
                                       ';'+
                                       currtostr_lgr(PU2)
                                       );
                      ListeValeur.Add('0'+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Date').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Reference').AsString+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Libelle').AsString)+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('CompteP').AsString)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Debit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Credit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Qt1').AsString+
                                       ';'+
                                       currtostr_lgr(PU1)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Qt2').AsString+
                                       ';'+
                                       currtostr_lgr(PU2)
                                       );
                     end;
                    DMEcritures.QuEcriture_Edition.Next;
                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin
                        if ValeurCompte <> DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString then
                         begin                                                                                                                                    
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1))+';' +E.FormatCurrSansDevise(TotQte2)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2)));

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;


                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;
                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1+TotauxReportEtSoldeFin.TotalQt1Report))+';' +E.FormatCurrSansDevise(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)));
                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE TIERS  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1+TotauxReportEtSoldeFin.TotalQt1Report))+';' +E.FormatCurrSansDevise(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)));
                          if (sautDePage)then ListeValeur.add('20');
                          ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
                          if Periode.DateDeb<e.DatExoDebut then
                            InitialiseTotauxBalance(TotauxReportEtSoldeFin)
                          else
                            TotauxReportEtSoldeFin:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString,false);

                          TotSoldeReportDebit := TotSoldeReportDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotSoldeReportCredit := TotSoldeReportCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
                          TotSoldeReportQt1:=TotSoldeReportQt1+TotauxReportEtSoldeFin.TotalQt1Report;
                          TotSoldeReportQt2:=TotSoldeReportQt2+TotauxReportEtSoldeFin.TotalQt2Report;

                          ListeValeur.Add('12;;');
                          ListeValeur.Add('14;Tiers : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString)+' - '+
           GereLibelle(DMTiers.LibelleDuTiers(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString)));
//                          ListeValeur.Add('4;Date ;Référence ;Désignation ; C.Partie ; Débit ; Crédit ; Qté 1 ; Qté 2 ');
                          if Periode.DateDeb<e.DatExoDebut then
                              begin
                                ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ; ; ');
                                ListeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ; ; ');
                              end
                          else
                              begin
                                 ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt1))+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt2)));
                                 ListeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt1))+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt2)));
                              end;
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                         end;
                      end
                     else
                      begin
                        if ValeurCompte <> DMEcritures.QuEcriture_Edition.FindField('Compte').AsString then
                         begin
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1))+';' +E.FormatCurrSansDevise(TotQte2)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2)));
                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;


                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;
                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1+TotauxReportEtSoldeFin.TotalQt1Report))+';' +E.FormatCurrSansDevise(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)));
                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1+TotauxReportEtSoldeFin.TotalQt1Report))+';' +E.FormatCurrSansDevise(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)));
                          ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
                          if Periode.DateDeb<e.DatExoDebut then
                            InitialiseTotauxBalance(TotauxReportEtSoldeFin)
                          else
                            TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceParCompte(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Compte').AsString,false);

                          TotSoldeReportDebit := TotSoldeReportDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotSoldeReportCredit := TotSoldeReportCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
                          TotSoldeReportQt1:=TotSoldeReportQt1+TotauxReportEtSoldeFin.TotalQt1Report;
                          TotSoldeReportQt2:=TotSoldeReportQt2+TotauxReportEtSoldeFin.TotalQt2Report;

                          ListeValeur.Add('12;;');
                          ListeValeur.Add('14;Compte : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString) + ' - ' + GereLibelle(DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString)));
//                          ListeValeur.Add('4;Date ;Référence ;Désignation ; C.Partie ; Débit ; Crédit ; Qté 1 ; Qté 2 ');
                          if Periode.DateDeb<e.DatExoDebut then
                              begin
                                ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ; ; ');
                                ListeEdition.Add(ValeurCompte+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ; ; ');
                              end
                          else
                              begin
                                ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt1))+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt2)));
                                ListeEdition.Add(ValeurCompte+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt1Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt1))+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotauxReportEtSoldeFin.TotalSoldeCreditReport,TotSoldeReportQt2)));
                              end;
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                         end;
                      end;
                   end;
                   // Dernier Compte Ou Tiers
                   // Tiers
                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin

                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1))+';' +E.FormatCurrSansDevise(TotQte2)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2)));
                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;

                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;
                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1+TotauxReportEtSoldeFin.TotalQt1Report))+';' +E.FormatCurrSansDevise(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)));

                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE TIERS  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1+TotauxReportEtSoldeFin.TotalQt1Report))+';' +E.FormatCurrSansDevise(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)));
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                      end
                     else
                      begin // Compte
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1))+';' +E.FormatCurrSansDevise(TotQte2)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2)));

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;

                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1+TotauxReportEtSoldeFin.TotalQt1Report))+';' +E.FormatCurrSansDevise(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)));

                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+';'+E.FormatCurrSansDevise(TotQte1+TotauxReportEtSoldeFin.TotalQt1Report)+ ';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte1+TotauxReportEtSoldeFin.TotalQt1Report))+';' +E.FormatCurrSansDevise(TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)+';'+E.FormatCurrSansDevise(GereDivision(TotDebit+TotCredit,TotQte2+TotauxReportEtSoldeFin.TotalQt2Report)));
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                      end;

                      // Affichage des totaux généraux
                      if ListeCompte.Count > 1 then
                       begin
                         ListeValeur.Add('12;;');
                         if (sautDePage)then ListeValeur.add('20');
                         ListeValeur.Add('14;Totaux Généraux ');
                         if Periode.DateDeb<e.DatExoDebut then
                           ListeValeur.Add('3;;;; @TOTAL SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ; ; ')
                         else
                           ListeValeur.Add('3;;;; @TOTAL SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotSoldeReportDebit)+';'+E.FormatCurrSansDevise(TotSoldeReportCredit)+';'+E.FormatCurrSansDevise(TotSoldeReportQt1)+';'+E.FormatCurrSansDevise(GereDivision(TotSoldeReportDebit+TotSoldeReportCredit,TotSoldeReportQt1))+';'+E.FormatCurrSansDevise(TotSoldeReportQt2)+';'+E.FormatCurrSansDevise(GereDivision(TotSoldeReportDebit+TotSoldeReportCredit,TotSoldeReportQt2)));

                         ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotMouvementPeriodeDebit)+';'+E.FormatCurrSansDevise(TotMouvementPeriodeCredit)+';'+E.FormatCurrSansDevise(TotTotQte1)+ ';'+E.FormatCurrSansDevise(GereDivision(TotMouvementPeriodeDebit+TotMouvementPeriodeCredit,TotTotQte1))+';' +E.FormatCurrSansDevise(TotTotQte2)+';'+E.FormatCurrSansDevise(GereDivision(TotMouvementPeriodeDebit+TotMouvementPeriodeCredit,TotTotQte2)));
                         TotTotauxDebit := TotSoldeReportDebit + TotMouvementPeriodeDebit;
                         TotTotauxCredit := TotSoldeReportCredit + TotMouvementPeriodeCredit;
                         TotTotauxQt1 := TotSoldeReportQt1 + TotTotQte1;
                         TotTotauxQt2 := TotSoldeReportQt2 + TotTotQte2;

                         ListeValeur.Add('3;;;; @TOTAL TOTAUX : ;'+E.FormatCurrSansDevise(TotTotauxDebit)+';'+E.FormatCurrSansDevise(TotTotauxCredit)+';'+E.FormatCurrSansDevise(TotTotauxQt1)+';'+E.FormatCurrSansDevise(GereDivision(TotTotauxDebit+TotTotauxCredit,TotTotauxQt1))+';'+E.FormatCurrSansDevise(TotTotauxQt2)+';'+E.FormatCurrSansDevise(GereDivision(TotTotauxDebit+TotTotauxCredit,TotTotauxQt2)));

                         TotSoldeDebit := TotSoldeDebit + TotDebit;
                         TotSoldeCredit := TotSoldeCredit + TotCredit;

                         ListeValeur.Add('4;;;; @TOTAL SOLDE : ;'+E.FormatCurrSansDevise(TotSoldeDebit)+';'+E.FormatCurrSansDevise(TotSoldeCredit)+';'+E.FormatCurrSansDevise(TotTotauxQt1)+';'+E.FormatCurrSansDevise(GereDivision(TotSoldeDebit+TotSoldeCredit,TotTotauxQt1))+';'+E.FormatCurrSansDevise(TotTotauxQt2)+';'+E.FormatCurrSansDevise(GereDivision(TotSoldeDebit+TotSoldeCredit,TotTotauxQt2)));

                         DetermineSolde(TotSoldeDebit,TotSoldeCredit);
                         ListeValeur.Add('4;;;; @SOLDE : ;'+E.FormatCurrSansDevise(TotSoldeDebit)+';'+E.FormatCurrSansDevise(TotSoldeCredit)+';'+E.FormatCurrSansDevise(TotTotauxQt1)+';'+E.FormatCurrSansDevise(GereDivision(TotSoldeDebit+TotSoldeCredit,TotTotauxQt1))+';'+E.FormatCurrSansDevise(TotTotauxQt2)+';'+E.FormatCurrSansDevise(GereDivision(TotSoldeDebit+TotSoldeCredit,TotTotauxQt2)));

                       end;

     DMEcritures.QuEcriture_Edition.Close;
     DMEcritures.QuEcriture_Edition.Filtered := false;
     case TypeEditionLigne of
      C_TypeEditionLigneSimple_AvecPrixUnitaire:Begin
                                 LigneEdition.Assign(ListeValeur);
                                 ObjPrn.Orientation:=poLandscape;
                               End;

      C_TypeEditionLigneComplet_AvecPrixUnitaire:Begin
                                 if ListeCompte.Count = 1 then
                                  begin
                                    if TypeCptTiers(ListeCompte.Strings[0]) then
                                      begin
                                        ObjPrn.FTitreEdition := 'Ecritures pour le Tiers : '+ ListeCompte.Strings[0];
                                        Nom:='Ecriture_Tiers';
                                      end
                                     else
                                      begin
                                        ObjPrn.FTitreEdition := 'Ecritures pour le compte : '+ ListeCompte.Strings[0]+ ' - '+ DMPlan.LibelleDuNumCptPCU(ListeCompte.Strings[0]);
                                        Nom:='Ecriture_Compte';
                                      end;
                                  end
                                 else
                                  begin
                                    if TypeCptTiers(ListeCompte.Strings[0]) then
                                      begin
                                        ObjPrn.FTitreEdition := 'Grand Livre des Tiers ';
                                        Nom:='GdLivre_Tiers';
                                      end
                                     else
                                      begin
                                        ObjPrn.FTitreEdition := 'Grand Livre des Comptes ';
                                        Nom:='GdLivre_Comptes';
                                      end;
                                  end;
                                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
                                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                                 ObjPrn.Orientation:=poLandscape;
                                 ListeValeur.Insert(0,' Date ; Référence ; Désignation ; C.Partie ; Débit ; Crédit ; Qté 1 ; PU1 ; Qté 2 ; PU2 ');
                                 ListeValeur.Insert(1,'0.7;0.8;2.0;0.8;1.0;1.0;1.0;1.0;1.0;1.0');
//                                 ListeValeur.Insert(2,'texte;texte;texte;texte;curr;curr;Float;curr;Float;curr');
                                 ListeValeur.Insert(2,'texte;texte;texte;texte;curr;curr;curr;curr;curr;curr');
                                End;
      else MessageDlg('EditionEcritureL: Le TypeEditionLigne ('+IntToStr(TypeEditionLigne)+') n''est pas défini !', mtWarning, [mbOK], 0);
     end; //}
     end;
Fin:=Time;
//showmessage('Début : '+timetostr(Debut)+', Fin : '+timetostr(Fin));
if Type_version_execution=ct_developpement then
  showmessage('Temp : '+timetostr(Fin-Debut));

         case TypeEdition of
             C_Exportation: ExportDonnees(ListeEdition,E.RepertoireExportDossier,Nom+'_'+E.NomDossier + E.NomExo + '.Txt')
           else
             ObjPrn.AffichageImp(ListeValeur);
         end;//fin du case typeedition
//  ListeValeur.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'GrandLivre_'+inttostr(ListeValeur.count)+'.txt');
   end;//si listecompte <>nil
  end; // Fin periode.retour
Screen.Cursor := crDefault;
finally
     LibereObjet(Tobject(ObjPrn));
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
//   ObjPrn.destroy;
end;
End;

Function EditionEcritureL_avecSoldeBanque(TypeEdition,TypeEditionLigne : integer; DemandePeriode:Tperiode; ListeCompte,LigneEdition:TStringList;DataSet:TDataSet;sautDePage:boolean):TStringList;
var
NomFich,Chemin:String;
NomMenuSiteWeb:TfileStream;
ListeValeur,ListeEdition:TStringList;
ObjPrn:TObjetEdition;
periode:TPeriode;
TotauxReportEtSoldeFin:TTotauxBalance;
ValeurCompte:String;
Nom:string;
TotDebit,TotCredit, TotQte1,TotQte2 : Currency;
ParamAffichPeriode:TParamAffichPeriode;
TotSoldeReportDebit, TotSoldeReportCredit,
TotSoldeReportQt1, TotSoldeReportQt2,
TotMouvementPeriodeDebit, TotMouvementPeriodeCredit,
TotTotauxDebit, TotTotauxCredit ,
TotTotauxQt1,TotTotauxQt2,
TotSoldeDebit, TotSoldeCredit,
SoldeDebit, SoldeCredit,
TotTotQte1, TotTotQte2 : Currency;
Debut,Fin:TTime;
SoldeCreditBanque,SoldeDebitBanque:currency;
idJournal:integer;
begin
try//finally
ObjPrn:=TObjetEdition.Create(application.MainForm);
Debut:=Time;
if DemandePeriode.datefin=0 then
  begin
    DemandePeriode.DateDeb:=e.DatExoDebut;
    DemandePeriode.DateFin:=e.DatExoFin;
  end;
 if DemandePeriode.Retour then
   Begin
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(DemandePeriode.DateDeb,DemandePeriode.DateFin,'',ParamAffichPeriode);
   end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := DemandePeriode.DateDeb;
     periode.DateFin := DemandePeriode.DateFin;
    end;
if periode.DateDeb<e.DatExoDebut then
  begin
      periode.Retour:=false;
      showmessage(AccesProcedureRefuse_SurDate);
  end;

  if periode.Retour then
  begin
     Screen.Cursor := crSQLWait;
     if DMEcritures=nil then DMEcritures:=TDMEcritures.Create(Application.MainForm);

     if dataset = nil then
      begin
//          DetailEcritureTiers(DataSet.FindField('Tiers').AsString,false);
        // Prevu pour passer le dataset concerné
      end;
     ListeValeur:=TStringList.Create;
     ListeEdition:=TStringList.Create;
     ObjPrn.FontLigneSeule.Style := [fsBold];

     DMEcritures.QuEcriture_Edition.Close;
     DMEcritures.QuEcriture_Edition.Filtered := true;
     if ListeCompte <> nil then
      begin
       DMEcritures.ListeFiltreEdit.Assign(ListeCompte);
       if ListeCompte.Count > 0 then
        begin
          if TypeCptTiers(ListeCompte.Strings[0]) then
            begin
             DMEcritures.QuEcriture_Edition.OnFilterRecord := DMEcritures.QuEcriture_EditionFilterRecordTiers;
            end
           else
            begin
             DMEcritures.QuEcriture_Edition.OnFilterRecord := DMEcritures.QuEcriture_EditionFilterRecordCompte;
            end;
        end;

     DMEcritures.QuEcriture_Edition.SQL.Clear;
     DMEcritures.QuEcriture_Edition.Params.Clear;



     DMEcritures.QuEcriture_Edition.SQL.Add('select distinct E."Date", E.Compte, E.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from Piece P ');
     DMEcritures.QuEcriture_Edition.SQL.Add(' join Ecriture E on (P.ID=E.Id_Piece) ');
     DMEcritures.QuEcriture_Edition.SQL.Add(' where E."Date" between :DateDeb and :DateFin');
     DMEcritures.QuEcriture_Edition.SQL.Add(' union all');
      if ((ListeCompte<> nil)and(ListeCompte.Count > 0)and(TypeCptTiers(ListeCompte.Strings[0]))) then
        begin
         DMEcritures.QuEcriture_Edition.SQL.Add(' select distinct E."Date", B.Compte, B.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from "'+E.RepertoireExercice+'BalanceTiers" B');
         DMEcritures.QuEcriture_Edition.SQL.Add(' order by E.Compte,E.Tiers,E."Date" ,E.Credit,E.Debit ,P.Reference asc, P.Compte ');
        end
       else
        begin
         DMEcritures.QuEcriture_Edition.SQL.Add(' select distinct E."Date", B.Compte, E.Tiers, E.Libelle, E.Debit, E.Credit, P.Reference, P.Compte as CompteP, E.Qt1, E.Qt2 from "'+E.RepertoireExercice+'Balance" B');
         DMEcritures.QuEcriture_Edition.SQL.Add(' order by E.Compte, E."Date",E.Credit,E.Debit , P.Reference asc, P.Compte ');
        end;

     DMEcritures.QuEcriture_Edition.Params[0].DataType := ftDAte;
     DMEcritures.QuEcriture_Edition.Params[0].AsDate := periode.DateDeb;
     DMEcritures.QuEcriture_Edition.Params[1].DataType := ftDAte;
     DMEcritures.QuEcriture_Edition.Params[1].AsDate := periode.DateFin;
     if not DMEcritures.QuEcriture_Edition.Prepared then
      DMEcritures.QuEcriture_Edition.Prepare;

     DMEcritures.QuEcriture_Edition.Open;
//     if Test1 = nil then Test1 := TTest1.Create(nil);
//     Test1.Show;

     DMEcritures.QuEcriture_Edition.First;
     if  ((ListeCompte<> nil) and (DMEcritures.QuEcriture_Edition.recordcount<>0) and (ListeCompte.Count > 0)) then
     begin
     ListeEdition.Add('Compte;Date;Reference;Libelle;C.Partie;Débit;Crédit;Solde débit;Solde crédit');
      if TypeCptTiers(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString) then
        begin
//         ListeValeur.Add('7;TIERS : '+DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString);
         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
         ListeValeur.Add('14;Tiers : '+DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString+' - '+
           DMTiers.LibelleDuTiers(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString));
         if Periode.DateDeb<e.DatExoDebut then
           InitialiseTotauxBalance(TotauxReportEtSoldeFin)
         else
           TotauxReportEtSoldeFin:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString); //ier passage dans calcul alors forcer la fermeture des requetes
        end
       else
        begin
//         ListeValeur.Add('13;COMPTE : '+DMEcritures.QuEcriture_Edition.FindField('Compte').AsString + ' - ' + DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString)+';0;12;1');
//         ListeValeur.Add('7;COMPTE : '+DMEcritures.QuEcriture_Edition.FindField('Compte').AsString + ' - ' + DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString));
         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
         if Periode.DateDeb<e.DatExoDebut then
             InitialiseTotauxBalance(TotauxReportEtSoldeFin)
         else
             TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceParCompte(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('compte').AsString);//ier passage dans sommetotauxbalance donc forcer le close
         ListeValeur.Add('14;Compte : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString) + ' - '
         + GereLibelle(DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString)));
        end;
     //
                          SoldeCreditBanque:=0;
                          SoldeDebitBanque:=0;
     DeFiltrageDataSet(dmrech.TaModelRech);
     idJournal:=-1;
     idJournal:=Infos_TInfosModel(dmrech.TaModelRech,'Compte',[DMEcritures.QuEcriture_Edition.FindField('Compte').AsString]).ID_Journal;

     TotSoldeReportDebit := TotauxReportEtSoldeFin.TotalSoldeDebitReport;
     TotSoldeReportCredit := TotauxReportEtSoldeFin.TotalSoldeCreditReport;
     TotSoldeReportQt1:=TotauxReportEtSoldeFin.TotalQt1Report;
     TotSoldeReportQt2:=TotauxReportEtSoldeFin.TotalQt2Report;

     if Periode.DateDeb<e.DatExoDebut then
         begin
           ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ');
           listeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ');
         end
     else
         begin
           ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));
           listeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));
         end;
//     ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+CurrToStr(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+CurrToStr(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+'; ; ; ');
                 while not DMEcritures.QuEcriture_Edition.Eof do
                   begin
                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin
                         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
                      end
                     else
                      begin
                         ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
                      end;

                    if not empty(DMEcritures.QuEcriture_Edition.FindField('Reference').AsString) then
                     begin
                      TotDebit:=DMEcritures.QuEcriture_Edition.FindField('Debit').AsCurrency + TotDebit;
                      TotCredit:=DMEcritures.QuEcriture_Edition.FindField('Credit').AsCurrency +TotCredit;
                      TotQte1:=DMEcritures.QuEcriture_Edition.FindField('Qt1').AsCurrency + TotQte1;
                      TotQte2:=DMEcritures.QuEcriture_Edition.FindField('Qt2').AsCurrency +TotQte2;

                      //if idjournal=4 then
                      if strtoint_lgr(copy(valeurcompte,1,1)) in[1,2,3,4,5] then
                        begin
                          SoldeCreditBanque:=TotauxReportEtSoldeFin.TotalSoldeCreditReport+TotCredit;
                          SoldeDebitBanque:=TotauxReportEtSoldeFin.TotalSoldeDebitReport+TotDebit;
                        end
                      else
                        begin
                          SoldeCreditBanque:=0;
                          SoldeDebitBanque:=0;
                        end;
                      DetermineSolde(SoldeDebitBanque,SoldeCreditBanque);
                      ListeEdition.Add(GereLibelle(ValeurCompte)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Date').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Reference').AsString+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Libelle').AsString)+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('CompteP').AsString)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Debit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Credit').AsString+
                                       ';'+
                                       currtostr_lgr(SoldeDebitBanque)+
                                       ';'+
                                       currtostr_lgr(SoldeCreditBanque)
                                       );
                      ListeValeur.Add('0'+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Date').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Reference').AsString+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Libelle').AsString)+
                                       ';'+
                                       GereLibelle(DMEcritures.QuEcriture_Edition.FindField('CompteP').AsString)+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Debit').AsString+
                                       ';'+
                                       DMEcritures.QuEcriture_Edition.FindField('Credit').AsString+
                                       ';'+
                                       currtostr_lgr(SoldeDebitBanque)+
                                       ';'+
                                       currtostr_lgr(SoldeCreditBanque)
                                       );
                     end;
                    DMEcritures.QuEcriture_Edition.Next;
                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin
                        if ValeurCompte <> DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString then
                         begin
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;


                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');
                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE TIERS  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');
                          if (sautDePage)then ListeValeur.add('20');
                          ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString;
                          if Periode.DateDeb<e.DatExoDebut then
                            InitialiseTotauxBalance(TotauxReportEtSoldeFin)
                          else
                            TotauxReportEtSoldeFin:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString,false);

                          TotSoldeReportDebit := TotSoldeReportDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotSoldeReportCredit := TotSoldeReportCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
                          TotSoldeReportQt1:=TotSoldeReportQt1+TotauxReportEtSoldeFin.TotalQt1Report;
                          TotSoldeReportQt2:=TotSoldeReportQt2+TotauxReportEtSoldeFin.TotalQt2Report;

                          ListeValeur.Add('12;;');
                          ListeValeur.Add('14;Tiers : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString)+' - '+
           GereLibelle(DMTiers.LibelleDuTiers(DMEcritures.QuEcriture_Edition.FindField('Tiers').AsString)));
//                          ListeValeur.Add('4;Date ;Référence ;Désignation ; C.Partie ; Débit ; Crédit ; Qté 1 ; Qté 2 ');
                          if Periode.DateDeb<e.DatExoDebut then
                              begin
                                ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ');
                                ListeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ');
                              end
                          else
                              begin
                                ListeValeur.Add('3;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));
                                ListeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));
                              end;
                           DeFiltrageDataSet(dmrech.TaModelRech);
                           idJournal:=-1;
                           idJournal:=Infos_TInfosModel(dmrech.TaModelRech,'Compte',[DMEcritures.QuEcriture_Edition.FindField('Compte').AsString]).ID_Journal;

                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                         end;
                      end
                     else
                      begin
                        if ValeurCompte <> DMEcritures.QuEcriture_Edition.FindField('Compte').AsString then
                         begin
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;


                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');
                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');
                          ValeurCompte:=DMEcritures.QuEcriture_Edition.FindField('Compte').AsString;
                          if Periode.DateDeb<e.DatExoDebut then
                            InitialiseTotauxBalance(TotauxReportEtSoldeFin)
                          else
                            TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceParCompte(Periode.DateDeb,Periode.DateFin,DMEcritures.QuEcriture_Edition.FindField('Compte').AsString,false);

                          TotSoldeReportDebit := TotSoldeReportDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotSoldeReportCredit := TotSoldeReportCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
                          TotSoldeReportQt1:=TotSoldeReportQt1+TotauxReportEtSoldeFin.TotalQt1Report;
                          TotSoldeReportQt2:=TotSoldeReportQt2+TotauxReportEtSoldeFin.TotalQt2Report;

                          ListeValeur.Add('12;;');
                          ListeValeur.Add('14;Compte : '+GereLibelle(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString) + ' - ' +
                           GereLibelle(DMPlan.LibelleDuNumCptPCU(DMEcritures.QuEcriture_Edition.FindField('Compte').AsString)));
//                          ListeValeur.Add('4;Date ;Référence ;Désignation ; C.Partie ; Débit ; Crédit ; Qté 1 ; Qté 2 ');
                          if Periode.DateDeb<e.DatExoDebut then
                              begin
                                ListeValeur.Add('4;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ');
                                ListeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;; ND ; ND ; ; ');
                              end
                          else
                              begin
                                ListeValeur.Add('3;;;; @SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));
                                ListeEdition.Add(GereLibelle(ValeurCompte)+';;;SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;;'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeDebitReport)+';'+E.FormatCurrSansDevise(TotauxReportEtSoldeFin.TotalSoldeCreditReport)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));
                              end;
                          SoldeCreditBanque:=0;
                          SoldeDebitBanque:=0;
                           DeFiltrageDataSet(dmrech.TaModelRech);
                           idJournal:=-1;
                           idJournal:=Infos_TInfosModel(dmrech.TaModelRech,'Compte',[DMEcritures.QuEcriture_Edition.FindField('Compte').AsString]).ID_Journal;
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                         end;
                      end;
                   end;
                   // Dernier Compte Ou Tiers
                   // Tiers
                    if TypeCptTiers(ListeCompte.Strings[0]) then
                      begin

                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;

                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');

                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE TIERS  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                      end
                     else
                      begin // Compte
                          ListeValeur.Add('3;;;; @MOUVEMENTS PERIODE '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');

                          TotMouvementPeriodeDebit := TotMouvementPeriodeDebit + TotDebit;
                          TotMouvementPeriodeCredit := TotMouvementPeriodeCredit + TotCredit;

                          TotDebit := TotDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
                          TotCredit := TotCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;

                          TotTotQte1 := TotTotQte1 + TotQte1;
                          TotTotQte2 := TotTotQte2 + TotQte2;

                          ListeValeur.Add('3;;;; @TOTAUX  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');

                          DetermineSolde(TotDebit,TotCredit);

                          TotSoldeDebit := TotSoldeDebit + TotDebit;
                          TotSoldeCredit := TotSoldeCredit + TotCredit;

                          ListeValeur.Add('4;;;; @SOLDE COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+E.FormatCurrSansDevise(TotDebit)+';'+E.FormatCurrSansDevise(TotCredit)+'; '+CurrToStr(0)+ ' ;' +CurrToStr(0)+';');
                          TotDebit:=0;
                          TotCredit:=0;
                          TotQte1:=0;
                          TotQte2:=0;
                      end;

                      // Affichage des totaux généraux
                      if ListeCompte.Count > 1 then
                       begin
                         ListeValeur.Add('12;;');
                         if (sautDePage)then ListeValeur.add('20');
                         ListeValeur.Add('14;Totaux Généraux ');
//                         TotSoldeReportDebit := TotSoldeReportDebit + TotauxReportEtSoldeFin.TotalSoldeDebitReport;
//                         TotSoldeReportCredit := TotSoldeReportCredit + TotauxReportEtSoldeFin.TotalSoldeCreditReport;
//                          TotSoldeReportQt1:=TotSoldeReportQt1+TotauxReportEtSoldeFin.TotalQt1Report;
//                          TotSoldeReportQt2:=TotSoldeReportQt2+TotauxReportEtSoldeFin.TotalQt2Report;

                         if Periode.DateDeb<e.DatExoDebut then
                           ListeValeur.Add('3;;;; @TOTAL SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ; ND ; ND ; ; ; ')
                         else
                           ListeValeur.Add('3;;;; @TOTAL SOLDE REPORT DEBUT (le '+DateToSTr(periode.DateDeb)+') ;'+E.FormatCurrSansDevise(TotSoldeReportDebit)+';'+E.FormatCurrSansDevise(TotSoldeReportCredit)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));
                         ListeValeur.Add('3;;;; @TOTAL MOUVEMENTS PERIODE : ;'+E.FormatCurrSansDevise(TotMouvementPeriodeDebit)+';'+E.FormatCurrSansDevise(TotMouvementPeriodeCredit)+'; '+E.FormatCurrSansDevise(0)+ ' ;' +E.FormatCurrSansDevise(0)+';');
                         TotTotauxDebit := TotSoldeReportDebit + TotMouvementPeriodeDebit;
                         TotTotauxCredit := TotSoldeReportCredit + TotMouvementPeriodeCredit;
                         TotTotauxQt1 := TotSoldeReportQt1 + TotTotQte1;
                         TotTotauxQt2 := TotSoldeReportQt2 + TotTotQte2;

                         ListeValeur.Add('3;;;; @TOTAL TOTAUX : ;'+E.FormatCurrSansDevise(TotTotauxDebit)+';'+E.FormatCurrSansDevise(TotTotauxCredit)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));

                         TotSoldeDebit := TotSoldeDebit + TotDebit;
                         TotSoldeCredit := TotSoldeCredit + TotCredit;

                         ListeValeur.Add('4;;;; @TOTAL SOLDE : ;'+E.FormatCurrSansDevise(TotSoldeDebit)+';'+E.FormatCurrSansDevise(TotSoldeCredit)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));

                         DetermineSolde(TotSoldeDebit,TotSoldeCredit);
                         ListeValeur.Add('4;;;; @SOLDE : ;'+E.FormatCurrSansDevise(TotSoldeDebit)+';'+E.FormatCurrSansDevise(TotSoldeCredit)+';'+E.FormatCurrSansDevise(0)+';'+E.FormatCurrSansDevise(0));

                       end;

     DMEcritures.QuEcriture_Edition.Close;
     DMEcritures.QuEcriture_Edition.Filtered := false;
     case TypeEditionLigne of
      C_TypeEditionLigneSimple,
      C_TypeEditionLigneSimple_AvecSoldeBanque:Begin
                                 LigneEdition.Assign(ListeValeur);
                               End;

      C_TypeEditionLigneComplet,
      C_TypeEditionLigneComplet_AvecSoldeBanque:Begin
                                 if ListeCompte.Count = 1 then
                                  begin
                                    if TypeCptTiers(ListeCompte.Strings[0]) then
                                      begin
                                        ObjPrn.FTitreEdition := 'Ecritures pour le Tiers : '+ ListeCompte.Strings[0];
                                        Nom:='Ecriture_Tiers';
                                      end
                                     else
                                      begin
                                        ObjPrn.FTitreEdition := 'Ecritures pour le compte : '+ ListeCompte.Strings[0]+ ' - '+ DMPlan.LibelleDuNumCptPCU(ListeCompte.Strings[0]);
                                        Nom:='Ecriture_Cpt';
                                      end;
                                  end
                                 else
                                  begin
                                    if TypeCptTiers(ListeCompte.Strings[0]) then
                                      begin
                                        ObjPrn.FTitreEdition := 'Grand Livre des Tiers ';
                                        Nom:='GdLivre_Tiers';
                                      end
                                     else
                                      begin
                                        ObjPrn.FTitreEdition := 'Grand Livre des Comptes ';
                                        Nom:='GdLivre_Cpt';
                                      end;
                                  end;
                                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
                                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                                 ListeValeur.Insert(0,' Date ; Référence ; Désignation ; C.Partie ; Débit ; Crédit ; Solde Débit ; Solde Crédit ');
                                 ListeValeur.Insert(1,'0.7;0.7;1.5;0.7;1.0;1.0;1.0;1.0');
                                 ListeValeur.Insert(2,'texte;texte;texte;texte;curr;curr;curr;curr');
                                End;
      else MessageDlg('EditionEcritureL: Le TypeEditionLigne ('+IntToStr(TypeEditionLigne)+') n''est pas défini !', mtWarning, [mbOK], 0);
     end; //}
     end;
Fin:=Time;
//showmessage('Début : '+timetostr(Debut)+', Fin : '+timetostr(Fin));
if Type_version_execution=ct_developpement then
  showmessage('Temp : '+timetostr(Fin-Debut));
         case TypeEdition of
             C_Exportation: ExportDonnees(ListeEdition,E.RepertoireExportDossier,Nom+'_'+E.NomDossier + E.NomExo + '.Txt')
           else
             ObjPrn.AffichageImp(ListeValeur);
         end;//fin du case typeedition
//  ListeValeur.SaveToFile(IncludeTrailingPathDelimiter(e.RepertoireDossier)+'GrandLivre_'+inttostr(ListeValeur.count)+'.txt');
         end;//si listecompte <>nil
      end;// Fin periode.retour

Screen.Cursor := crDefault;
finally
     LibereObjet(Tobject(ObjPrn));
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
//   ObjPrn.destroy;
end;
End;

Function NBE:integer;
begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
 result:=DMEcritures.TaEcritureVisu.RecordCount;
end;

Function PieceEcritureJournal(Modifiable:boolean):boolean;
var
IDL,IDP,ID:string;
begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
if DMEcritures.QueryEcrJournal.RecordCount > 0 then begin
   if TabVisuPiece2 = Nil then TabVisuPiece2:= TTabVisuPiece2.Create(Application.MainForm);
   IDP:=DMEcritures.QueryEcrJournal.FieldValues['ID_Piece'];
//   IDL:=DMEcritures.QueryEcrTiers.FieldValues['ID_Ligne'];
//   ID:= IDP + IDL;
   TabVisuPiece2.Modifiable:=Modifiable;
   TabVisuPiece2.Tag:=StrToInt(IDP);
   TabVisuPiece2.AppellantDetailEcr:=(Screen.ActiveForm = DetailEcr);
   TabVisuPiece2.show;
   end
   else MessageBox(0,'Ligne vide non affectée à une pièce !!','Attention',MB_OK+MB_ICONSTOP)

end;

Function PieceEcritureTiers(Modifiable:boolean):boolean;
var
IDL,IDP,ID:string;
begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
if DMEcritures.QueryEcrTiers.RecordCount > 0 then begin
   if TabVisuPiece2 = Nil then TabVisuPiece2:= TTabVisuPiece2.Create(Application.MainForm);
   IDP:=DMEcritures.QueryEcrTiers.FieldValues['ID_Piece'];
//   IDL:=DMEcritures.QueryEcrTiers.FieldValues['ID_Ligne'];
//   ID:= IDP + IDL;
   TabVisuPiece2.Modifiable:=Modifiable;
   TabVisuPiece2.Tag:=StrToInt(IDP);
   TabVisuPiece2.AppellantDetailEcr:=(Screen.ActiveForm = DetailEcr);
   TabVisuPiece2.show;
   end
   else MessageBox(0,'Ligne vide non affectée à une pièce !!','Attention',MB_OK+MB_ICONSTOP)

end;

Function PieceEcritureCompte(Modifiable:boolean):boolean;
var
IDL,IDP,ID:string;
begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
if DMEcritures.QueryEcrCompte.RecordCount > 0 then begin
   if TabVisuPiece2 = Nil then
   TabVisuPiece2:= TTabVisuPiece2.Create(Application.MainForm);
   IDP:=DMEcritures.QueryEcrCompte.FieldValues['ID_Piece'];
   TabVisuPiece2.Modifiable:=Modifiable;
   TabVisuPiece2.AppellantDetailEcr:=(Screen.ActiveForm = DetailEcr);
   TabVisuPiece2.Tag:=StrToInt(IDP);
   TabVisuPiece2.show;
   end
   else MessageBox(0,'Ligne vide non affectée à une pièce !!','Attention',MB_OK+MB_ICONSTOP)

end;

Function PieceEcritureCompteTva(Modifiable:boolean):boolean;
var
IDL,IDP,ID:string;
begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
if DMEcritures.QuEcrCompteCodeTva.RecordCount > 0 then begin
   if TabVisuPiece2 = Nil then
   TabVisuPiece2:= TTabVisuPiece2.Create(Application.MainForm);
   TabVisuPiece2.Modifiable:=Modifiable;
   IDP:=DMEcritures.QuEcrCompteCodeTva.FieldValues['ID_Piece'];
   TabVisuPiece2.Tag:=StrToInt(IDP);
   TabVisuPiece2.AppellantDetailEcr:=(Screen.ActiveForm = DetailEcr);
   TabVisuPiece2.show;
   end
   else MessageBox(0,'Ligne vide non affectée à une pièce !!','Attention',MB_OK+MB_ICONSTOP)

end;

//      C_Detail_Tiers = 1;
//      C_Detail_Compte = 2;
//      C_Detail_CompteTva = 3;
//      C_Detail_Journal = 4;

Function DEtailEcritures(TypeDetail:Integer;CompteOuJournal,CodeTVA:String;Affichage,AffichChoixPeriode,AutrePeriode:Boolean;Periode:TPeriode):Boolean;
var
TotauxReportEtSoldeFin:TTotauxBalance;
//Periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
Begin
try
 Screen.Cursor := crSQLWait;
    if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
    case TypeDetail of
     C_Detail_Tiers:Begin

                    End;

     C_Detail_Compte:Begin
                       try
                       DMEcritures.QueryEcrCompte.Active:=false;
//                       Periode.DateDeb:=E.DatExoDebut;
//                       Periode.DateFin:=E.DatExoFin;
//                       if AutrePeriode then Periode:=PeriodeAutre;
//                       Periode.Retour:=true;
//                       AutrePeriode := false;

                       if AffichChoixPeriode then
                        begin
                          Initialise_ParamAffichPeriode(ParamAffichPeriode);
                          Periode:=ChoixPeriodeAffich(strtodate('01/01/1980'),Periode.DateFin,'',ParamAffichPeriode);

//                          if not Periode.Retour then
//                           begin
//                            abort;
//                           end;
                        end;

                       DMEcritures.QueryEcrCompte.ParamByName('Cpte').AsString:=CompteOuJournal;
                       DMEcritures.QueryEcrCompte.ParamByName('DateDeb').AsDate:=Periode.DateDeb;
                       DMEcritures.QueryEcrCompte.ParamByName('DateFin').AsDate:=Periode.DateFin;

                       DMEcritures.QueryEcrCompte.Open;

                       result:=DMEcritures.QueryEcrCompte.RecordCount> 0;

                       if Affichage and Periode.Retour then
                       begin
                         if result then
                           begin//s'il y des ecritures
                           if (DetailEcr = nil) then DetailEcr:=TDetailEcr.Create(Application.MainForm);
                           DetailEcr.Tag:=2;
                           DMEcritures.QueryEcrCompte.Active:=false;

                           GrDbGridInitColonne(DetailEcr.GrDbDetail,
                                               DMEcritures.DataQueryEcr,
                                               DMEcritures.QueryEcrCompte,
                                              ['Référence','Libellé','Date','Qté 1','Qté 2','Débit','Crédit'],
                                              ['Reference','Libelle','Date','Qt1','Qt2','DebitSaisie','CreditSaisie']
                                              ,E.FormatMonnaie,E.EditFormat);

                           DetailEcr.TiersEnCours:='';
                           DetailEcr.CompteEnCours:= CompteOuJournal;

                           DeFiltrageDataSet(DMRech.TaPlanCptRech);
                           DetailEcr.Caption:='Détail des écritures pour le compte : '+CompteOuJournal + ' - ' + Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[CompteOuJournal]).Libelle;

                           TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceParCompte(Periode.DateDeb,Periode.DateFin,CompteOuJournal);

                           if (Periode.DateDeb >= E.DatExoDebut) then
                            begin
                              DetailEcr.Panel7.Caption:='Solde Report Début ( le '+DateToStr(Periode.DateDeb)+' ) :   ';
                              DetailEcr.Panel2.Caption:='Solde Fin Période ( le '+DateToStr(Periode.DateFin)+' ) :   ';
                              DetailEcr.Panel3.Caption:='Totaux des mouvements ( du '+DateToStr(Periode.DateDeb)+' au '+DateToStr(Periode.DateFin)+' ) :   ';

                              DetailEcr.GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitReport);
                              DetailEcr.GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditReport);

                              DetailEcr.GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitTotal);
                              DetailEcr.GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditTotal);

                              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalDebitBase);
                              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalCreditBase);
                            end
                           else
                            begin
                              DetailEcr.Panel7.Caption:='Pas de calcul pour le Solde Report Début (Hors Période !)   ';
                              DetailEcr.Panel2.Caption:='Pas de calcul pour le Solde Fin (Hors Période !)   ';
                              DetailEcr.Panel3.Caption:='Totaux des mouvements ( du '+DateToStr(Periode.DateDeb)+' au '+DateToStr(Periode.DateFin)+' ) :   ';

                              DetailEcr.GrGrid1.cells[0,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
                              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitReport);
                              DetailEcr.GrGrid1.cells[1,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
                              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditReport);

                              DetailEcr.GrGrid2.cells[0,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
                              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitTotal);
                              DetailEcr.GrGrid2.cells[1,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
                              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditTotal);

                              DMEcritures.QuRequeteEcr.Close;
                              DMEcritures.QuRequeteEcr.SQL.Clear;
                              DMEcritures.QuRequeteEcr.SQL.Add(Sum_Compte_DateDeb_DateFin_PourCompte);
                              DMEcritures.QuRequeteEcr.ParamByName('DateDeb').AsDateTime := Periode.DateDeb;
                              DMEcritures.QuRequeteEcr.ParamByName('DateFin').AsDateTime := Periode.DateFin;
                              DMEcritures.QuRequeteEcr.ParamByName('Cpt').AsString := CompteOuJournal;
                              DMEcritures.QuRequeteEcr.Open;

                              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',DMEcritures.QuRequeteEcr.FieldByName('TotDebit').AsCurrency);
                              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',DMEcritures.QuRequeteEcr.FieldByName('TotCredit').AsCurrency);
                //              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalDebitBase);
                //              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalCreditBase);
                            end;


                           DetailEcr.AppellantVisuPiece:=(Screen.ActiveForm = TabVisuPiece2);

                           DetailEcr.Show;
                           end//fin s'il y des ecritures
                         else
                            showmessage('Il n''y a pas d''écriture sur ce compte pour la période du : '+
                                        dateInfos(Periode.DateDeb,'/').DateStrFormat +
                                        ' au '+
                                        dateInfos(Periode.DateFin,'/').DateStrFormat);
                       end;
                // PB le 27/10/03       else
                // PB le 27/10/03         QueryEcrCompte.Open;
                       Finally
                        Screen.Cursor := crDefault;
                       end;
                     End;

     C_Detail_CompteTva:Begin

                        End;

     C_Detail_Journal:Begin

                      End;

    else
    MessageDlg('Function DetailEcritures : le TypeDetail est indéfini !', mtError, [mbOK], 0);
    end;
Finally
end;
//
End;

Function DetailEcritureJournal(Journal:String;Affichage:Boolean):boolean;
Begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
with DMEcritures do
     begin
       // Totaux et solde des lignes
       QuerySumEcrJournal.Active:=false;
       QuerySumEcrJournal.Params[0].AsString:=Journal;
       QuerySumEcrJournal.Active:=true;
       // Détails des lignes
       QueryEcrJournal.Active:=false;
       DataQueryEcr.DataSet:=QueryEcrJournal;
       QueryEcrJournal.Params[0].AsString:=Journal;
       QueryEcrJournal.Active:=true;
       result:=QueryEcrJournal.RecordCount> 0;
       if (DetailEcr = nil) then DetailEcr:=TDetailEcr.Create(Application.MainForm);
       DetailEcr.Tag:=4;
       DetailEcr.PeriodeEcr.DateDeb:=E.DatExoDebut;
       DetailEcr.PeriodeEcr.DateFin:=E.DatExoFin;
       DetailEcr.PeriodeEcr.Retour:=true;
       QueryEcrJournal.Active:=False;

       //Librairie_Isa.
       GrDbGridInitColonne(DetailEcr.GrDbDetail,DataQueryEcr,QueryEcrJournal,
                   ['Référence','Libellé','Date',' Qté1','Qté2','Débit','Crédit'],
                   ['Reference','Libelle','Date','Qt1','Qt2','DebitSaisie','CreditSaisie']
                   ,E.FormatMonnaie,E.EditFormat);


         DetailEcr.TiersEnCours:='';
         DetailEcr.Caption:='Détail des écritures pour le Journal : '+Journal;
       if Affichage then
       begin
          DetailEcr.AppellantVisuPiece:=(Screen.ActiveForm = TabVisuPiece2);
         if result then
           DetailEcr.Show
         else
           showmessage('Il n''y a pas d''écriture sur ce journal dans la période choisie');
       end;
     end;
End;

Function DetailEcritureCompteTVA(cptTva,CodeTVA:string;Affichage:Boolean):boolean;
var
TotauxReportEtSoldeFin:TTotauxBalance;
ListeCodeTva:TStringList;
begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
with DMEcritures do
     begin

       // Totaux et solde des lignes
       QuSumEcrCompteCodeTva.Active:=false;
       QuSumEcrCompteCodeTva.Params[0].AsString:=CodeTva;
       QuSumEcrCompteCodeTva.Active:=true;
       // Détails des lignes
       QuEcrCompteCodeTva.Active:=false;
       DataQueryEcr.DataSet:=QuEcrCompteCodeTva;
       QuEcrCompteCodeTva.Params[0].AsString:=CodeTva;
       QuEcrCompteCodeTva.Active:=true;

       result:=QuEcrCompteCodeTva.RecordCount> 0;
       if (DetailEcr = nil) then DetailEcr:=TDetailEcr.Create(Application.MainForm);
       DetailEcr.Tag:=3;
       DetailEcr.PeriodeEcr.DateDeb:=E.DatExoDebut;
       DetailEcr.PeriodeEcr.DateFin:=E.DatExoFin;
       DetailEcr.PeriodeEcr.Retour:=true;
       //Librairie_Isa.
       GrDbGridInitColonne(DetailEcr.GrDbDetail,DataQueryEcr,QuEcrCompteCodeTva,
                   ['Référence','Libellé','Date',' Qté1','Qté2','Débit','Crédit'],
                   ['Reference','Libelle','Date','Qt1','Qt2','Debit','Credit']
                   ,E.FormatMonnaie,E.EditFormat);

         DetailEcr.TiersEnCours:='';
         DetailEcr.Caption:='Détail des écritures pour le code TVA : '+CodeTva+' - Compte associé : '+CptTva + ' - '+DMPlan.LibelleDuNumCptPCU(CptTva);

       if Affichage then
       begin
         if result then
           begin//s'il y des ecritures
           ListeCodeTva:=TStringList.Create;
           ListeCodeTva.Add(CodeTva);
           TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceCalc(E.DatExoDebut,E.DatExoFin,ChampTableVersListe('Compte',QuEcrCompteCodeTva),'Compte',false);
           ListeCodeTva.Free;
           ListeCodeTva:=nil;
           DetailEcr.GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitReport);
           DetailEcr.GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditReport);

           DetailEcr.GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitTotal);
           DetailEcr.GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditTotal);

           DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalDebitBase);
           DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalCreditBase);

           DetailEcr.AppellantVisuPiece:=(Screen.ActiveForm = TabVisuPiece2);

           DetailEcr.Show;
           end//fin s'il y des ecritures
         else
           showmessage('Il n''y a pas d''écriture sur ce compte dans la période choisie');
       end;
     end;

end;

Function DetailEcritureCompte(cpt:string;Affichage:Boolean;AffichChoixPeriode:Boolean;PeriodeDiff:boolean):boolean;
var
TotauxReportEtSoldeFin:TTotauxBalance;
Periode,PeriodeAutre_Tmp:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
with DMEcritures do
     begin
       try
        Screen.Cursor := crSQLWait;
       QueryEcrCompte.Active:=false;
       Periode.DateDeb:=E.DatExoDebut;
       Periode.DateFin:=E.DatExoFin;
       if E.AutrePeriode then Periode:=E.PeriodeAutre;
       Periode.Retour:=true;

       QueryEcrCompte.ParamByName('Cpte').AsString:=cpt;
       QueryEcrCompte.ParamByName('DateDeb').AsDate:=Periode.DateDeb;
       QueryEcrCompte.ParamByName('DateFin').AsDate:=Periode.DateFin;
if ((affichage) and (not AffichChoixPeriode)) then
  AffichChoixPeriode:=((ParamUtil.maintenance)and(ParamUtil.TypeMaintenance='MaintS')){ isa  le  09/03/05 }
else
  if ((AffichChoixPeriode)and(PeriodeDiff)) then
    begin
      Periode.DateDeb:=strtodate('01/01/1980');//je ne le fais que si affichChoixPeriode était déjà valide donc demande explicite
      Periode.DateFin:=e.DatExoDebut-1;
    end;

       E.PeriodeAutre.Retour:=E.AutrePeriode; { isa  le  06/10/04 }
       PeriodeAutre_Tmp:=E.PeriodeAutre;
       E.AutrePeriode := false;

       if AffichChoixPeriode then
        begin
          Initialise_ParamAffichPeriode(ParamAffichPeriode);
          Periode:=ChoixPeriodeAffich(Periode.DateDeb,Periode.DateFin,'',ParamAffichPeriode);
          if Periode.Retour then
           begin
            QueryEcrCompte.ParamByName('DateDeb').AsDate:=Periode.DateDeb;
            QueryEcrCompte.ParamByName('DateFin').AsDate:=Periode.DateFin;
           end;
        end;

       QueryEcrCompte.Open;

       result:=QueryEcrCompte.RecordCount> 0;

       if (DetailEcr = nil) then DetailEcr:=TDetailEcr.Create(Application.MainForm);
       DetailEcr.Tag:=2;
       DetailEcr.PeriodeEcr:=Periode;
       if Affichage and Periode.Retour then
       begin
         if result then
           begin//s'il y des ecritures
           QueryEcrCompte.Active:=false;

           //Librairie_Isa.
           GrDbGridInitColonne(DetailEcr.GrDbDetail,DataQueryEcr,QueryEcrCompte,
                              ['Référence','Libellé','Date','Qté 1','Qté 2','Débit','Crédit'],
                              ['Reference','Libelle','Date','Qt1','Qt2','DebitSaisie','CreditSaisie']
                              ,E.FormatMonnaie,E.EditFormat);

           DetailEcr.TiersEnCours:='';
           DetailEcr.CompteEnCours:= cpt;

           DeFiltrageDataSet(DMRech.TaPlanCptRech);
           DetailEcr.Caption:='Détail des écritures pour le compte : '+cpt + ' - ' + Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[cpt]).Libelle;

           TotauxReportEtSoldeFin:=DMDiocEtatBal.SommeTotauxBalanceParCompte(Periode.DateDeb,Periode.DateFin,Cpt);

           if (Periode.DateDeb >= E.DatExoDebut) then
            begin
              DetailEcr.Panel7.Caption:='Solde Report Début ( le '+DateToStr(Periode.DateDeb)+' ) :   ';
              DetailEcr.Panel2.Caption:='Solde Fin Période ( le '+DateToStr(Periode.DateFin)+' ) :   ';
              DetailEcr.Panel3.Caption:='Totaux des mouvements ( du '+DateToStr(Periode.DateDeb)+' au '+DateToStr(Periode.DateFin)+' ) :   ';

              DetailEcr.GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitReport);
              DetailEcr.GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditReport);

              DetailEcr.GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitTotal);
              DetailEcr.GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditTotal);

              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalDebitBase);
              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalCreditBase);
            end
           else
            begin
              DetailEcr.Panel7.Caption:='Pas de calcul pour le Solde Report Début (Hors Période !)   ';
              DetailEcr.Panel2.Caption:='Pas de calcul pour le Solde Fin (Hors Période !)   ';
              DetailEcr.Panel3.Caption:='Totaux des mouvements ( du '+DateToStr(Periode.DateDeb)+' au '+DateToStr(Periode.DateFin)+' ) :   ';

              DetailEcr.GrGrid1.cells[0,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitReport);
              DetailEcr.GrGrid1.cells[1,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditReport);

              DetailEcr.GrGrid2.cells[0,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitTotal);
              DetailEcr.GrGrid2.cells[1,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditTotal);

              DMEcritures.QuRequeteEcr.Close;
              DMEcritures.QuRequeteEcr.SQL.Clear;
              DMEcritures.QuRequeteEcr.SQL.Add(Sum_Compte_DateDeb_DateFin_PourCompte);
              DMEcritures.QuRequeteEcr.ParamByName('DateDeb').AsDateTime := Periode.DateDeb;
              DMEcritures.QuRequeteEcr.ParamByName('DateFin').AsDateTime := Periode.DateFin;
              DMEcritures.QuRequeteEcr.ParamByName('Cpt').AsString := cpt;
              DMEcritures.QuRequeteEcr.Open;

              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',DMEcritures.QuRequeteEcr.FieldByName('TotDebit').AsCurrency);
              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',DMEcritures.QuRequeteEcr.FieldByName('TotCredit').AsCurrency);
//              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalDebitBase);
//              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalCreditBase);
            end;


           DetailEcr.AppellantVisuPiece:=(Screen.ActiveForm = TabVisuPiece2);

           DetailEcr.Show;
           end//fin s'il y des ecritures
         else
            showmessage('Il n''y a pas d''écriture sur ce compte pour la période du : '+
                        dateInfos(Periode.DateDeb,'/').DateStrFormat +
                        ' au '+
                        dateInfos(Periode.DateFin,'/').DateStrFormat);
       end;
// PB le 27/10/03       else
// PB le 27/10/03         QueryEcrCompte.Open;
       Finally
        E.PeriodeAutre:=PeriodeAutre_Tmp;
        E.AutrePeriode:=E.PeriodeAutre.Retour;
        Screen.Cursor := crDefault;
       end;
     end;

end;

Function DetailEcritureTiers(cpt:string;Affichage:Boolean;AffichChoixPeriode:Boolean;PeriodeDiff:boolean):boolean;
var
TotauxReportEtSoldeFin:TTotauxBalance;
Periode,PeriodeAutre_Tmp:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
Requete:string;
begin
if (DMEcritures = nil) then DMEcritures:=TDMEcritures.Create(Application.MainForm);
with DMEcritures do
     begin
       try//finally

       Screen.Cursor := crSQLWait;
       QueryEcrTiers.Active:=false;
       QueryEcrTiers.sql.Clear;
       Requete:='select E.ID,E.ID_Piece,P."Date",P.Quand,E.Quand,P.Reference,E.Id_Ligne,E."Date",E.Compte,E.Libelle,E.DebitSaisie,E.CreditSaisie,'+
                ' E.Qt1,E.Qt2'+
                ' From'+
                ' Piece P'+
                ' Join Ecriture E On (P.Id = E.Id_Piece )'+
                ' where'+
                ' E.Tiers=(:Tier)';
//                'and E."Date" >=:DateDeb and E."Date" <=:DateFin'+
//                'order by P."Date",P.Quand,E.Quand';
       QueryEcrTiers.sql.Add(requete);
       Periode.DateDeb:=E.DatExoDebut;
       Periode.DateFin:=E.DatExoFin;
//       QueryEcrTiers.ParamByName('DateDeb').AsDate:=Periode.DateDeb;
//       QueryEcrTiers.ParamByName('DateFin').AsDate:=Periode.DateFin;
if ((affichage) and (not AffichChoixPeriode)) then
  AffichChoixPeriode:=e.TypeClient=cl_isa
else
  if ((AffichChoixPeriode)and(PeriodeDiff)) then
    begin
      Periode.DateDeb:=strtodate('01/01/1980');//je ne le fais que si affichChoixPeriode était déjà valide donc demande explicite
      Periode.DateFin:=e.DatExoDebut-1;
    end;
//       if e.TypeClient=cl_isa then
       begin
         QueryEcrTiers.sql.Add(' and E."Date" >=:DateDeb and E."Date" <=:DateFin');

       if E.AutrePeriode then Periode:=E.PeriodeAutre;
       Periode.Retour:=true;

       QueryEcrTiers.ParamByName('Tier').AsString:=cpt;
       QueryEcrTiers.ParamByName('DateDeb').AsDate:=Periode.DateDeb;
       QueryEcrTiers.ParamByName('DateFin').AsDate:=Periode.DateFin;

       E.PeriodeAutre.Retour:=E.AutrePeriode; { isa  le  06/10/04 }
       PeriodeAutre_Tmp:=E.PeriodeAutre;
       E.AutrePeriode := false;

       if AffichChoixPeriode then
        begin
          Initialise_ParamAffichPeriode(ParamAffichPeriode);
          Periode:=ChoixPeriodeAffich(Periode.DateDeb,Periode.DateFin,'',ParamAffichPeriode);
          if Periode.Retour then
           begin
            QueryEcrTiers.ParamByName('DateDeb').AsDate:=Periode.DateDeb;
            QueryEcrTiers.ParamByName('DateFin').AsDate:=Periode.DateFin;
           end;
        end;
       end;//fin si version isa pour test

       QueryEcrTiers.Active:=false;
       QueryEcrTiers.sql.Add(' order by P."Date",P.Quand,E.Quand');
       QueryEcrTiers.Params[0].AsString:=cpt;

       QueryEcrTiers.Open;
       result:=QueryEcrTiers.RecordCount> 0;

       if (DetailEcr = nil) then DetailEcr:=TDetailEcr.Create(Application.MainForm);
       DetailEcr.Tag:=1;
       DetailEcr.PeriodeEcr:=Periode;
      if affichage then
         begin
          if result then
            begin//s'il y a des écritures
            QueryEcrTiers.Active:=false;

            //Librairie_Isa.
            GrDbGridInitColonne(DetailEcr.GrDbDetail,DataQueryEcr,QueryEcrTiers,
                               ['Référence','Libellé','Date','Qté 1','Qté 2','Débit','Crédit'],
                               ['Reference','Libelle','Date','Qt1','Qt2','DebitSaisie','CreditSaisie']
                               ,E.FormatMonnaie,E.EditFormat);
            DeFiltrageDataSet(dmrech.TaTiersRech);
            DetailEcr.TiersEnCours:=cpt;
            DetailEcr.Caption:='Détail des écritures pour le compte de Tiers : '+cpt + ' - '+ Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[Cpt]).Nom;

           TotauxReportEtSoldeFin:=DMDiocEtatBalT.SommeTotauxBalanceParTiers(Periode.DateDeb,Periode.DateFin,Cpt);
           if (Periode.DateDeb >= E.DatExoDebut) then
            begin
              DetailEcr.Panel7.Caption:='Solde Report Début ( le '+DateToStr(Periode.DateDeb)+' ) :   ';
              DetailEcr.Panel2.Caption:='Solde Fin Période ( le '+DateToStr(Periode.DateFin)+' ) :   ';
              DetailEcr.Panel3.Caption:='Totaux des mouvements ( du '+DateToStr(Periode.DateDeb)+' au '+DateToStr(Periode.DateFin)+' ) :   ';

              DetailEcr.GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitReport);
              DetailEcr.GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditReport);

              DetailEcr.GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitTotal);
              DetailEcr.GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditTotal);

              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalDebitBase);
              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalCreditBase);
            end
           else
            begin
              DetailEcr.Panel7.Caption:='Pas de calcul pour le Solde Report Début (Hors Période !)   ';
              DetailEcr.Panel2.Caption:='Pas de calcul pour le Solde Fin (Hors Période !)   ';
              DetailEcr.Panel3.Caption:='Totaux des mouvements ( du '+DateToStr(Periode.DateDeb)+' au '+DateToStr(Periode.DateFin)+' ) :   ';

              DetailEcr.GrGrid1.cells[0,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitReport);
              DetailEcr.GrGrid1.cells[1,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditReport);

              DetailEcr.GrGrid2.cells[0,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitTotal);
              DetailEcr.GrGrid2.cells[1,0]:='xxxxxxxxxxxxxxxxxxxxxxxx';
              //FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditTotal);

              DMEcritures.QuRequeteEcr.Close;
              DMEcritures.QuRequeteEcr.SQL.Clear;
              DMEcritures.QuRequeteEcr.SQL.Add(Sum_Compte_DateDeb_DateFin_PourTiers);
              DMEcritures.QuRequeteEcr.ParamByName('DateDeb').AsDateTime := Periode.DateDeb;
              DMEcritures.QuRequeteEcr.ParamByName('DateFin').AsDateTime := Periode.DateFin;
              DMEcritures.QuRequeteEcr.ParamByName('Cpt').AsString := cpt;
              DMEcritures.QuRequeteEcr.Open;

              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',DMEcritures.QuRequeteEcr.FieldByName('TotDebit').AsCurrency);
              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',DMEcritures.QuRequeteEcr.FieldByName('TotCredit').AsCurrency);
//              DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalDebitBase);
//              DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalCreditBase);
            end;

//           DetailEcr.GrGrid1.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitReport);
//           DetailEcr.GrGrid1.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditReport);
//
//           DetailEcr.GrGrid2.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeDebitTotal);
//           DetailEcr.GrGrid2.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalSoldeCreditTotal);
//
//           DetailEcr.GrGrid3.cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalDebitBase);
//           DetailEcr.GrGrid3.cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',TotauxReportEtSoldeFin.TotalCreditBase);

           DetailEcr.AppellantVisuPiece:=(Screen.ActiveForm = TabVisuPiece2);

            DetailEcr.Show;
            end //fin s'il y a des écritures
          else
            showmessage('Il n''y a pas d''écriture sur ce tiers dans la période choisie');
         end;
       Finally
//        E.PeriodeAutre:=PeriodeAutre_Tmp;
//        E.AutrePeriode:=E.PeriodeAutre.Retour;
        Screen.Cursor := crDefault;
       end;//fin du finally
     end;//fin du with
end;


Function TDMEcritures.MaxIdEcriture(AnneeAnterieure:boolean):Integer;
var
QueryID:TQuery;
ChampID:string;
messagelgr:string;
begin
  try//finally
      try//except
      ChampID:='ID';
      QueryID:=tquery.Create(self);
      QueryID.DatabaseName:=TaEcriture.DatabaseName;
      QueryID.SQL.Clear;
//      if(empty(E.ExerciceSaisie) or (E.ExerciceSaisie='0'))then
//        begin
//            messagelgr = 'Le code exercice de saisie n''a pas pu être récupéré, l''écriture ne peut pas être créée !!!'+
//                     RetourChariotDouble+'Relancez le programme Epicéa ou contacter le service de maintenance';
//            ShowMessage(messagelgr);
//            abort;
//        end;
      if AnneeAnterieure then
       begin
         QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +TaEcriture.TableName+'');
         QueryID.SQL.Add(' Where '+ChampID+'< ' +Inttostr((StrToInt_Lgr(E.ExerciceSaisie)*10000000))+'''');
         QueryID.Open;
         result:=0;
         if QueryID.FindField('resultat').Asinteger = 0 then
         result:=((StrToInt_Lgr(E.ExerciceSaisie)-1)*10000000)+1
         else
         result:=QueryID.FindField('resultat').Asinteger+1;
       end
       else
       begin
         QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +TaEcriture.TableName+'');
         QueryID.SQL.Add(' Where '+ChampID+' between ' +Inttostr((StrToInt_Lgr(E.ExerciceSaisie)*10000000))+' and ' +IntToStr(((StrToInt_Lgr(E.ExerciceSaisie)+1)*10000000))+'''');
      //   QueryID.SQL.Add(' Where '+ChampID+'>= ' +IntToStr((StrToInt_Lgr(E.ExerciceSaisie)*10000000))+'''');
         QueryID.Open;
         result:=0;
         if QueryID.FindField('resultat').Asinteger = 0 then
         result:=(StrToInt_Lgr(E.ExerciceSaisie)*10000000)+1
         else
         result:=QueryID.FindField('resultat').Asinteger+1;
       end;
      except

      end;
  finally
  QueryID.close;
  QueryID.Free;
  QueryID:=nil;
  end;
end;

Function TDMEcritures.MaxIdEcriture_Exo(ExoSaisie:string;rajout:integer):Integer;
var
messagelgr:string;
begin
  try//finally
      try//except
         QuMaxIdEcriture.close;
         QuMaxIdEcriture.ParamByName('id1').AsInteger:=(StrToInt_Lgr(ExoSaisie)*10000000);
         QuMaxIdEcriture.ParamByName('id2').AsInteger:=((StrToInt_Lgr(ExoSaisie)+1)*10000000);
         QuMaxIdEcriture.Open;
         result:=0;
         if QuMaxIdEcriture.FindField('resultat').Asinteger = 0 then
         result:=(StrToInt_Lgr(ExoSaisie)*10000000)+rajout
         else
         result:=QuMaxIdEcriture.FindField('resultat').Asinteger+rajout;

      except

      end;
  finally
    QuMaxIdEcriture.close;
  end;
end;

Function TDMEcritures.ID_Piece_Avec_Id_Ecriture(IDEcriture:Integer):Integer;
Begin
result:=0;
DefiltrageDataSet(DMRech.TaEcritureRech);
if DMRech.TaEcritureRech.Locate('ID',IDEcriture,[]) then
 result:=DMRech.TaEcritureRech.findfield('ID_Piece').AsInteger;
DeFiltrageDataSet(DMRech.TaEcritureRech); 
End;


procedure TDMEcritures.CreationEcritures(Reglement:TEcriture_Isa;LibelleEcriture,TLigne,Compte:string;Qte1,Qte2:real;Ds,Cs,D,C:Currency;Devise,Ligne:integer;DateRec:tdate);
var
IDEcriture,IdPiece:integer;
TypeLigne:string[1];
creationReste:TInfosCreationReste;
begin
   try
      TableGereStartTransaction(TaEcriture);
      if ((reglement<>nil)and(Reglement.Piece<>nil))then
         begin //si on travail sur une pièce de réglement
         //création ligne tiers
            TaEcriture.AppendRecord([Reglement.Piece.IDContrepartie,Reglement.Piece.FirstIDPiece,'H',
            2,Reglement.Piece.DateSaisie,Reglement.piece.compteplan,Reglement.Piece.Tiers,Reglement.piece.Libelle,null,null,Ds,Cs,Devise,D,C,
            null,null,0,null,null,null,e.NomUtilisateur,now,null,null,null,null,null,null,0]);
            TaEcriture.FlushBuffers;
            initialise_InfosCreationReste(creationReste);
            creationReste.DatePiece:=Reglement.Piece.DateSaisie;
            creationReste.IDEcriture:=Reglement.Piece.IDContrepartie;
            creationReste.IDPiece:=Reglement.Piece.FirstIDPiece;
            creationReste.Pointage.MontantPointage:=0;
            creationReste.Libelle:=Reglement.piece.Libelle;
            creationReste.MontantDebit:=Ds;
            creationReste.MontantCredit:=Cs;
            if not empty(Reglement.Piece.Tiers)then
              creationReste.tiers:=Reglement.Piece.Tiers
            else
              if dmplan.cptEstPointable(Reglement.Piece.comptePlan)then
                creationReste.tiers:=Reglement.Piece.comptePlan;
            creationReste.Reference:=Reglement.Piece.Reference;
            if creationReste.MontantDebit <>0 then
              begin
                creationReste.reste.Reste:=creationReste.MontantDebit;
                creationReste.reste.sensReste:=false;
              end
            else
              begin
                creationReste.reste.Reste:=creationReste.MontantCredit;
                creationReste.reste.sensReste:=true;
              end;
            DMPointage2.GestionDuReste(creationReste,false);
         //création ligne réglement
         if reglement.piece.idjournal<>3 then
          TypeLigne:='X'
         else
          TypeLigne:='H';
            TaEcriture.AppendRecord([Reglement.FirstIDEcriture,Reglement.Piece.FirstIDPiece,TypeLigne,
            1,Reglement.Piece.DateSaisie,reglement.CompteEcriture,reglement.TiersEcriture,Reglement.piece.Libelle ,null,null,Cs,Ds,Devise,C,D,
            null,null,0,null,null,null,e.NomUtilisateur,now,null,null,null,null,null,null,0]);
            TaEcriture.FlushBuffers;
         end//fin si on travail sur une pièce de réglement
      else
         begin//si on travail sur une pièce normale
         IDEcriture:=MaxIdEcriture(DMPieces.Piece1.AnneePiece.PieceAnterieure);
         //if(IDEcriture<10000000)then abort;
         idpiece:=DMPieces.MaxIdPiece(DMPieces.Piece1.AnneePiece.PieceAnterieure);
         TaEcriture.AppendRecord([IDEcriture,idpiece,TLigne,
         ligne,DateRec,compte,null,LibelleEcriture,Qte1,Qte2,Ds,Cs,Devise,D,C,
         null,null,0,null,null,null,null,now,null,null,null,null,null,null,0]);
         TaEcriture.FlushBuffers;
         end;//fin si on travail sur une pièce normale
   except
      begin
        TableGereRollBack(TaEcriture);
        TableGereRollBack(DMBalance.TaBalance);
        showmessage('Erreur d''Ecritures');
        abort;
      end;
   end;
end;

procedure TDMEcritures.DMEcrituresCreate(Sender: TObject);
begin
ListeFiltreEdit:=TStringList.Create;
OuvrirTouteTable('',TControl(self));
TaEcritureTTvaType.ValidChars:=['E','e','D','d'];
MessDerSub:=true;

//PieceAnterieure:=false;
listeTvaExigible:=Tlist.create;

TaEcritureTCompte.ValidChars:=['0'..'9'];

TaEcritureTDebitSaisie.DisplayFormat:=E.FormatMonnaie;
TaEcritureTDebitSaisie.EditFormat:='0.00 ;-0.00 ';

TaEcritureTCreditSaisie.DisplayFormat:=E.FormatMonnaie;
TaEcritureTCreditSaisie.EditFormat:='0.00 ;-0.00 ';

TaEcritureTTvaTaux.DisplayFormat:=E.FormatMonnaie;
TaEcritureTTvaTaux.EditFormat:='0.00 ;-0.00 ';

TaEcritureTMontantTTC.DisplayFormat:=E.FormatMonnaie;
TaEcritureTMontantTTC.EditFormat:='0.00 ;-0.00 ';

TaEcriture2DebitSaisie.DisplayFormat:=E.FormatMonnaie;
TaEcriture2DebitSaisie.EditFormat:='0.00 ;-0.00 ';

TaEcriture2CreditSaisie.DisplayFormat:=E.FormatMonnaie;
TaEcriture2CreditSaisie.EditFormat:='0.00 ;-0.00 ';

TaEcriture2Debit.DisplayFormat:=E.FormatMonnaie;
TaEcriture2Debit.EditFormat:='0.00 ;-0.00 ';

TaEcriture2Credit.DisplayFormat:=E.FormatMonnaie;
TaEcriture2Credit.EditFormat:='0.00 ;-0.00 ';

TaEcritureBalDebitSaisie.DisplayFormat:=E.FormatMonnaie;
TaEcritureBalCreditSaisie.DisplayFormat:=E.FormatMonnaie;

TaEcritureBalTDebitSaisie.DisplayFormat:=E.FormatMonnaie;
TaEcritureBalTCreditSaisie.DisplayFormat:=E.FormatMonnaie;
//TaEcritureBalDebit.DisplayFormat:=E.FormatMonnaie;
//TaEcritureBalCredit.DisplayFormat:=E.FormatMonnaie;
if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);
end;

procedure TDMEcritures.DMEcrituresDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
if listeTvaExigible<>nil then
  listeTvaExigible.Free;
ListeFiltreEdit.Free;
DMEcritures := nil;
end;

procedure TDMEcritures.ChoixSensEtMontant(tableCourante:TDataSet);
var
sens:boolean;
begin
DebCredEcriture:='';
montantEcriture:=0;
QteEcriture1:='';
QteEcriture2:='';
  if (tableCourante.FindField('DebitSaisie').AsCurrency<>0) or
 (not empty(tableCourante.FindField('DebitSaisie').Asstring))and
 (tableCourante.FindField('CreditSaisie').AsCurrency=0) or
 ( empty(tableCourante.FindField('CreditSaisie').Asstring)) then
    sens:=false
 else
  if (tableCourante.FindField('DebitSaisie').AsCurrency=0) or
 (empty(tableCourante.FindField('DebitSaisie').asstring))and
 (tableCourante.FindField('CreditSaisie').AsCurrency<>0) or
 (not empty(tableCourante.FindField('CreditSaisie').asstring)) then
     sens:=true;
Qt1:=tableCourante.FindField('Qt1').Asfloat;
Qt2:=tableCourante.FindField('Qt2').Asfloat;

  if DMPieces.Piece1.AnneePiece.PieceAnterieure then
     Begin
       if not sens then
           begin
           DebCredEcriture:='Debit_Report';
           QteEcriture1:='Qt1_Report';
           QteEcriture2:='Qt2_Report';
           montantEcriture:=tableCourante.FindField('DebitSaisie').AsCurrency;
           end
       else
            begin
            DebCredEcriture:='Credit_Report';
            QteEcriture1:='Qt1_Report';
            QteEcriture2:='Qt2_Report';
            montantEcriture:= tableCourante.FindField('CreditSaisie').AsCurrency;
            end;
     End
  else
     Begin
       if not sens then
           begin
           DebCredEcriture:='Debit_Base';
           QteEcriture1:='Qt1_Base';
           QteEcriture2:='Qt2_Base';
           montantEcriture:=tableCourante.FindField('DebitSaisie').AsCurrency;
           end
       else
            begin
            DebCredEcriture:='Credit_Base';
           QteEcriture1:='Qt1_Base';
           QteEcriture2:='Qt2_Base';
            montantEcriture:= tableCourante.FindField('CreditSaisie').AsCurrency;
            end;
     End;
end;

procedure TDMEcritures.TaEcritureAfterPost(DataSet: TDataSet);
var
rang,i,j:integer;
montantTva:currency;
begin
rang:=-1;
    try
    if DMPieces.Piece1.AnneePiece.PieceAnterieure then
      Begin//si pièce année antérieure
        if ((not(copy(compteEcriture,1,1)='6'))and (((not empty(TiersEcriture))or (DMPlan.CptEstPointable(compteEcriture)))) and (not(copy(compteEcriture,1,1)='7')and (not(copy(compteEcriture,1,1)='+'))))then
          DMBalance.MAJBalance_AvecQuantite( false,QteEcriture1,QteEcriture2,DebCredEcriture,compteEcriture,compteEcriture,Qt1,Qt2,Qt1,Qt2,montantEcriture,montantEcriture,dsInsert);
        i:=0;
        while (i<listeTvaExigible.count) do
          begin
           if ((PTvaExigible(listeTvaExigible.Items[i])^.CompteTva=compteEcriture) and(PTvaExigible(listeTvaExigible.items[i])^.exigible))then
             begin//si rang <>-1 (on regarde si on trouve une tva exigible pour ce compte en cours de mise à jour)
             if copy(compteEcriture,1,3)='445'then //compte de tva si date d'exigibilité dans prochaine déclaration
                begin
                //récupérer pour le compte tva courant le montant total exigible
                montantTva:=0;
                J:=0;
                while j<=listeTvaExigible.count-1 do
                  Begin
                    if ((PTvaExigible(listeTvaExigible.items[j])^.exigible)and(PTvaExigible(listeTvaExigible.items[j])^.CompteTva=compteEcriture))then
                       begin
                         montantTva:=montantTva+PTvaExigible(listeTvaExigible.items[j])^.MontantTva;
                         listeTvaExigible.delete(j);
                         dec(j);
                         if i>=0 then
                          dec(i);
                       end;
                    inc(j);
                  End;
                montantEcriture:=abs(montantTva);
                DMBalance.MAJBalance_AvecQuantite(false,QteEcriture1,QteEcriture2,DebCredEcriture,compteEcriture,
                 compteEcriture,Qt1,Qt2,Qt1,Qt2,montantEcriture,montantEcriture,dsInsert)
                end;
             end//fin si rang <>-1
           else
             if (PTvaExigible(listeTvaExigible.Items[i])^.CompteTva=compteEcriture) then
               begin
                 DMTmTVA.GestionDeclarationAvantOuverture(false,PTvaExigible(listeTvaExigible.items[i])^.IDEcriture,PTvaExigible(listeTvaExigible.items[i])^.IDPiece,E.PremiereDateDeclaration-1);
                 listeTvaExigible.delete(i);
                 if i>=0 then
                  Dec(i);
               end;
           inc(i)
          end;//fin du while listeTvaExigible
      End//fin si pièce année antérieure
    else
    if not(copy(compteEcriture,1,1)='+')then
    DMBalance.MAJBalance_AvecQuantite( false,QteEcriture1,QteEcriture2,DebCredEcriture,compteEcriture,compteEcriture,Qt1,Qt2,Qt1,Qt2,montantEcriture,montantEcriture,dsInsert);

    if not empty(TiersEcriture)then
    DMBalance.MAJBalanceDesTiers(false,QteEcriture1,DebCredEcriture,TiersEcriture,compteEcriture,TiersEcriture,0,0,montantEcriture,montantEcriture,dsinsert);
    if (dataset is ttable) then
      (dataset as ttable).FlushBuffers;
    except
    showmessage('Erreur de mise à jour balance');
    TableGereRollBack(dataset);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
    end;
end;

procedure TDMEcritures.TaEcriture2BeforeInsert(DataSet: TDataSet);
begin
Abort;//empêche une insertion dans la table ecritures
end;

procedure TDMEcritures.TaEcriture2BeforePost(DataSet: TDataSet);
begin
  If trim(TaEcriture2.FindField('Libelle').AsString) = '' Then
  Begin
       Messagedlg('Le libellé doit être obligatoirement renseigné !!!',MtWarning,[mbok],0);
       Abort;
  End;
end;

procedure TDMEcritures.TaEcritureBeforeDelete(DataSet: TDataSet);
begin
try
TiersEcriture:='';
     compteEcriture:=DataSet.FindField('compte').AsString;
     TiersEcriture:=DataSet.FindField('Tiers').AsString;
     ChoixSensEtMontant(dataset);
 if ((not empty(TiersEcriture))or(DMPlan.CptEstPointable(compteEcriture)))then
    begin
      DMPointage2.SupprimeResteSurIDEcriture(DataSet.FindField('ID').AsInteger);
    end;
if DMAnalytiques=nil then DMAnalytiques:=TDMAnalytiques.create(application.Mainform);
 if not GestionSuppressionRelation_Ecriture_Atelier(DataSet.FindField('ID').AsInteger,0) then
   abort;
 if not GestionSuppressionRelationReleveBancaire(DataSet.FindField('ID').AsInteger)then
   abort;
except
   TableGereRollBack(dataset);
   TableGereRollBack(DMBalance.TaBalance);  
   abort;
end;
end;

procedure TDMEcritures.TaEcritureAfterDelete(DataSet: TDataSet);
var
rang,i,j:integer;
montantTva:currency;
begin
rang:=-1;
   try
    if DMPieces.Piece1.AnneePiece.PieceAnterieure then
      Begin
        if ((not(copy(compteEcriture,1,1)='6'))and (((not empty(TiersEcriture))or (DMPlan.CptEstPointable(compteEcriture)))) and (not(copy(compteEcriture,1,1)='7')and (not(copy(compteEcriture,1,1)='+'))))then
             DMBalance.MAJBalance_AvecQuantite(true,QteEcriture1,QteEcriture2,DebCredEcriture,compteEcriture,
              compteEcriture,Qt1,Qt2,Qt1,Qt2,montantEcriture,montantEcriture,dsbrowse);
        i:=0;
        while (i<listeTvaExigible.count) do
          begin
           if ((PTvaExigible(listeTvaExigible.Items[i])^.CompteTva=compteEcriture) and(PTvaExigible(listeTvaExigible.items[i])^.exigible))then
             begin
             if copy(compteEcriture,1,3)='445'then //compte de tva si date d'exigibilité dans prochaine déclaration
                begin
                //récupérer pour le compte tva courant le montant total exigible
                montantTva:=0;
                j:=0;
                while j<=listeTvaExigible.count-1 do
                  Begin
                    if ((PTvaExigible(listeTvaExigible.items[j])^.exigible)and(PTvaExigible(listeTvaExigible.items[j])^.CompteTva=compteEcriture))then
                       begin
                         montantTva:=montantTva+PTvaExigible(listeTvaExigible.items[j])^.MontantTva;
                         listeTvaExigible.delete(j);
                         dec(j);
                         if i>=0 then dec(i);
                       end;
                    inc(j);
                  End;
                montantEcriture:=abs(montantTva);
                DMBalance.MAJBalance_AvecQuantite(true,QteEcriture1,QteEcriture2,DebCredEcriture,compteEcriture,
                 compteEcriture,Qt1,Qt2,Qt1,Qt2,montantEcriture,montantEcriture,dsbrowse)
               end;
             end
           else
             if (PTvaExigible(listeTvaExigible.Items[i])^.CompteTva=compteEcriture)then
               begin
                 DMTmTVA.GestionDeclarationAvantOuverture(true,PTvaExigible(listeTvaExigible.items[i])^.IDEcriture,PTvaExigible(listeTvaExigible.items[i])^.IDPiece,E.PremiereDateDeclaration-1);
                 listeTvaExigible.delete(i);
                 if i>=0 then dec(i);
               end;
           inc(i)
          end;
      End
    else
    if not(copy(compteEcriture,1,1)='+')then
     DMBalance.MAJBalance_AvecQuantite(true,QteEcriture1,QteEcriture2,DebCredEcriture,compteEcriture,
     compteEcriture,Qt1,Qt2,Qt1,Qt2,montantEcriture,montantEcriture,dsbrowse);
    if not empty(TiersEcriture)then
      begin
       DMBalance.MAJBalanceDesTiers(true,QteEcriture1,DebCredEcriture,TiersEcriture,
       compteEcriture,TiersEcriture,0,0,montantEcriture,montantEcriture,dsbrowse);
      end;
    if dataset is ttable then
    (dataset as ttable).FlushBuffers;//problème car si je me sert d'un autre dataset voir importation
    // le flushbuffers ne se fait pas sur la bonne table !!!
   except
      begin
      showmessage('Erreur de mise à jour de la balance après suppression');
      TableGereRollBack(dataset);
      TableGereRollBack(DMBalance.TaBalance);
      abort;
      end;
   end;
end;

procedure TDMEcritures.TaEcritureBeforePost(DataSet: TDataSet);
begin
compteEcriture:='';
    ChoixSensEtMontant(TaEcriture);
    compteEcriture:= TaEcriture.FindField('Compte').AsString;
    TiersEcriture:= TaEcriture.FindField('Tiers').AsString;
    
end;

function TDMEcritures.VerifIDEcriture(ID:integer;Ecriture:TEcriture_Isa;Suppr:boolean):TErreurSaisie;
var
TableTemp:TTable;
begin
TableTemp:=TTable.create(self);
TableTemp.databaseName:=TaEcriture.DatabaseName;
TableTemp.TableName:=TaEcriture.TableName;
TableTemp.open;
result.Retour:=true;
result.CodeErreur:=0;
   try
     result.Retour:= not (TableTemp.Locate('ID',ID,[]));
     if not result.Retour then
       Begin
       result.Retour:=false;
       result.CodeErreur:=3002;
       End
     else
       if ((result.Retour)and(not Suppr)) then
       result.Retour:=Ecriture.NewIDEcriture(TaEcriture,'ID')=ID;
     if not result.Retour then
       result.CodeErreur:=3001;
   except
   result.CodeErreur:=3002;
   abort;
   end;//fin du try
End;


//function TDMEcritures.VerifIDPieceSurTaEcriture(IDPiece:integer;Ecriture:TEcriture_Isa;Suppr:boolean):TErreurSaisie;
////var
////i:integer;
//
//Begin
////result.Retour:=true;
////   try
////     Ecriture.TaEcrituretmp.First;
////     while ((not(Ecriture.TaEcrituretmp.EOF))and (result.Retour)) do
////     begin
////     result.Retour:= Ecriture.TaEcrituretmp.findfield('ID_Piece').asinteger =IDPiece;
////     Ecriture.TaEcrituretmp.next;
////     end;
////     if not result.Retour then
////       if Suppr then
////       result.CodeErreur:=4002
////       else
////       result.CodeErreur:=4001;
////   except
////   result.CodeErreur:=4002;
////   abort;
////   end;//fin du try
//
//End;


Function TDMEcritures.CtrlSaisieEcritureBOTiers(CCourant:Tfield):TErreurSaisie;
var
RetourEnregistrement:TEnregistrementComplet;
ClassCpt:Integer;
begin
// initialisation des variables de retour de fonction
CtrlSaisieEcritureBOTiers.CodeErreur:=0;
CtrlSaisieEcritureBOTiers.Retour:=True;
  if TaEcritureT.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification

    if not VerifNumCptIntegrite(TaEcritureTCompte.AsString,False,False).vide then
    begin
       ClassCpt:=VerifNumCptIntegrite(TaEcritureTCompte.AsString,False,False).Classe;
       RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaEcritureTCompte.AsString);
   End
   else
   begin
      ClassCpt:=0;
   end;
        case CCourant.Index of

        5: begin // si champ compte pas vide
            if not empty(CCourant.AsString) then
             begin
              FiltragesAideCompteBOT;
              if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
               Begin
                  CtrlSaisieEcritureBOTiers.CodeErreur:=1000;  //Compte vide
                  CtrlSaisieEcritureBOTiers.Retour:=False;
               End
               else
               Begin
                if empty(TaEcritureTLibelle.AsString) then
                            TaEcritureTLibelle.AsString:=DMPlan.LibelleDuNumCptPCU(CCourant.AsString);
                if ((not empty(CCourant.AsString)) and (CCourant.AsString[1]='4')) then
                 begin
                 TaEcritureTTypeLigne.AsString:='T';
                 TaEcritureTTvaCode.AsString:=FTvaRecupCodeTva(CCourant.AsString);
                 TaEcritureTTvaType.AsString:='D';
                 end
                  else
                 begin
                  TaEcritureTTypeLigne.AsString:='H';
//                 RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaEcritureTCompte.AsString);
//                 TaEcritureTTvaCode.AsString:=RetourEnregistrement.TvaCode;
//                 TaEcritureTTvaType.AsString:=RetourEnregistrement.TvaType;
                 end;
                  //               RecupInfoApresVerif(true);
               end;
             end;
           end;//fin champ compte
        7: begin//si champ n°2(Désignation)
            If Empty(CCourant.AsString) then {1}
               begin
                if not(empty(TaEcritureTCompte.AsString)) then
                 begin                      {2}
                  if not(empty(DMPlan.LibelleDuNumCptPCU(TaEcritureTCompte.AsString))) then
                  begin
                     ccourant.AsString:=DMPlan.LibelleDuNumCptPCU(TaEcritureTCompte.AsString);
                     DernierLibelle:=DMPlan.LibelleDuNumCptPCU(TaEcritureTCompte.AsString);
                  end;
                 end                        {2}
                 else
                 begin                      {2}
                   ccourant.AsString:='Opération de l''année précédente';
                   DernierLibelle:='Opération de l''année précédente';
                 end;                       {2}
               end                           {1}
            else//s'il est rempli, on regarde si le libelle ne correspond pas au dernier
            //compte saisi !!! si oui, on lui affecte le libelle correspond au nouveau compte
            //saisi
               begin                         {1}
                 if ccourant.AsString=DernierLibelle then
                  if not(empty(DMPlan.LibelleDuNumCptPCU(TaEcritureTCompte.AsString))) then
                     begin
                     ccourant.AsString:=DMPlan.LibelleDuNumCptPCU(TaEcritureTCompte.AsString);
                     DernierLibelle:=DMPlan.LibelleDuNumCptPCU(TaEcritureTCompte.AsString);
                     end;
               end;//fin champ n°2 vide      {1}
            // Les codes d'erreurs suivant ne servent qu'a gérer les déplacement ds la grille de saisie
            if not(empty(TaEcritureTCompte.AsString)) then
               Begin
//                case StrToInt_Lgr(TaEcritureTCompte.AsString[1]) of
                case ClassCpt of
                   4:begin
                        CtrlSaisieEcritureBOTiers.CodeErreur:=7100;
                        CtrlSaisieEcritureBOTiers.Retour:=False;
                     end;
                   6:begin
                        CtrlSaisieEcritureBOTiers.CodeErreur:=7200;
                        CtrlSaisieEcritureBOTiers.Retour:=False;
                     end;
                   7:begin
                        CtrlSaisieEcritureBOTiers.CodeErreur:=7300;
                        CtrlSaisieEcritureBOTiers.Retour:=False;
                     end;
                end;{Fin du Case}
               End
               else
               Begin
                 CtrlSaisieEcritureBOTiers.CodeErreur:=7400;
                 CtrlSaisieEcritureBOTiers.Retour:=False;
               End;
           end;//fin si champ n°2(Désignation)

          // Débit Saisie
          10:Begin
               if not VerifFNumeric(CCourant).VideOUZero then
                begin
                  if not(empty(TaEcritureTCompte.AsString)) then
                     Begin
                      case StrToInt_Lgr(TaEcritureTCompte.AsString[1]) of
                         4:begin
                              CtrlSaisieEcritureBOTiers.CodeErreur:=10100;
                              CtrlSaisieEcritureBOTiers.Retour:=False;
                              Messagebox(0,Pchar('La saisie de recettes ou de dépenses n''est pas autorisée pour les comptes de TVA !!!'),'Erreur de saisie',0);
                              CCourant.AsInteger:=0;
                           end;
                         6:begin
//                              CtrlSaisieEcritureBOTiers.CodeErreur:=7200;
//                              CtrlSaisieEcritureBOTiers.Retour:=False;
                           end;
                         7:begin
//                              CtrlSaisieEcritureBOTiers.CodeErreur:=7300;
//                              CtrlSaisieEcritureBOTiers.Retour:=False;
                           end;
                      end;{Fin du Case}

                     End
                     else
                     Begin
//                       CtrlSaisieEcritureBOTiers.CodeErreur:=7400;
//                       CtrlSaisieEcritureBOTiers.Retour:=False;
                     End;
                if not VerifFNumeric(TaEcritureTCreditSaisie).VideOUZero then
                   Begin
                     CtrlSaisieEcritureBOTiers.CodeErreur:=10500;
                     CtrlSaisieEcritureBOTiers.Retour:=False;
                     TaEcritureTCreditSaisie.AsCurrency:=0;
                   End;

                end
               else
                begin

                end;

            End;

          // Crédit Saisie
          11:Begin
               if not VerifFNumeric(CCourant).VideOUZero then
                begin
                  if not(empty(TaEcritureTCompte.AsString)) then
                     Begin
                      case StrToInt_Lgr(TaEcritureTCompte.AsString[1]) of
                         4:begin
                              CtrlSaisieEcritureBOTiers.CodeErreur:=11100;
                              CtrlSaisieEcritureBOTiers.Retour:=False;
                              Messagebox(0,Pchar('La saisie de recettes ou de dépenses n''est pas autorisée pour les comptes de TVA !!!'),'Erreur de saisie',0);
                              CCourant.AsInteger:=0;
                           end;
                         6:begin
//                              CtrlSaisieEcritureBOTiers.CodeErreur:=7200;
//                              CtrlSaisieEcritureBOTiers.Retour:=False;
                           end;
                         7:begin
//                              CtrlSaisieEcritureBOTiers.CodeErreur:=7300;
//                              CtrlSaisieEcritureBOTiers.Retour:=False;
                           end;
                      end;{Fin du Case}
                     End
                     else
                     Begin
//                       CtrlSaisieEcritureBOTiers.CodeErreur:=7400;
//                       CtrlSaisieEcritureBOTiers.Retour:=False;
                     End;
                if not VerifFNumeric(TaEcritureTDebitSaisie).VideOUZero then
                   Begin
                     CtrlSaisieEcritureBOTiers.CodeErreur:=11500;
                     CtrlSaisieEcritureBOTiers.Retour:=False;
                     TaEcritureTDebitSaisie.AsCurrency:=0;
                   End;
                end
               else
                begin

                end;

             End;
           // TVA Montant (TvaTaux);
          17:Begin
              if not empty(TaEcritureTCompte.AsString) then
              begin
                 ClassCpt:=StrToInt_Lgr(TaEcritureTCompte.AsString[1]);
                 RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaEcritureTCompte.AsString);
             End
             else
             begin
                ClassCpt:=0;
             end;
                if not VerifFNumeric(CCourant).VideOUZero then
                 begin
                  case ClassCpt of
                     4:Begin
                        TaEcritureTTypeLigne.AsString:='T';
                        TaEcritureTTvaCode.AsString:=RetourEnregistrement.TvaCode;
                        TaEcritureTTvaType.AsString:='D';
                        TaEcritureTTvaDate.Required:=true;
                        CtrlSaisieEcritureBOTiers.CodeErreur:=17100;
                        CtrlSaisieEcritureBOTiers.Retour:=False;
                       End;

                     6..7:Begin
                           TaEcritureTTypeLigne.AsString:='H';
                           TaEcritureTTvaCode.AsString:=RetourEnregistrement.TvaCode;
                           TaEcritureTTvaCode.Required:=true;
                           TaEcritureTTvaType.AsString:=RetourEnregistrement.TvaType;
                           if RetourEnregistrement.TvaType='E' then
                              Begin
                               CtrlSaisieEcritureBOTiers.CodeErreur:=17200;
                               CtrlSaisieEcritureBOTiers.Retour:=False;
                              End;
                           if RetourEnregistrement.TvaType='D' then
                              Begin
                               TaEcritureTTvaDate.Required:=true;
                               CtrlSaisieEcritureBOTiers.CodeErreur:=17300;
                               CtrlSaisieEcritureBOTiers.Retour:=False;
                              End;
                          end;
                     0:Begin
                        CtrlSaisieEcritureBOTiers.CodeErreur:=17400;
                        CtrlSaisieEcritureBOTiers.Retour:=False;
//                        Messagebox(0,Pchar('Vous ne pouvez pas saisir de TVA si aucun compte n''est défini !!!'),'Erreur de saisie',0);
                       End;

                  end;{Fin du Case}
                 end
                 else
                 Begin // Si montant TVA Vide
                  case ClassCpt of
                     4:Begin
                        TaEcritureTTypeLigne.AsString:='T';
                        TaEcritureTTvaCode.AsString:=RetourEnregistrement.TvaCode;
                        TaEcritureTTvaType.AsString:='D';
                        TaEcritureTTvaDate.Required:=true;
                        CtrlSaisieEcritureBOTiers.CodeErreur:=17500;
                        CtrlSaisieEcritureBOTiers.Retour:=False;
                       End;

                     6..7:Begin
                           TaEcritureTTypeLigne.AsString:='H';
                           TaEcritureTTvaCode.AsString:='';
                           TaEcritureTTvaType.AsString:='';
                           TaEcritureTTvaDate.AsString:=null;
                          end;
                     0:Begin
                        CtrlSaisieEcritureBOTiers.CodeErreur:=17600;
                        CtrlSaisieEcritureBOTiers.Retour:=False;
//                        Messagebox(0,Pchar('Vous ne pouvez pas saisir de TVA si aucun compte n''est défini !!!'),'Erreur de saisie',0);
                       End;

                  end;{Fin du Case}
                 TaEcritureTTvaCode.Required:=false;
                 TaEcritureTTvaDate.Required:=false;
                 End;

              End;
           // TVA Code;
          15:Begin
              if not empty(TaEcritureTCompte.AsString) then
              begin
                 ClassCpt:=StrToInt_Lgr(TaEcritureTCompte.AsString[1]);
                 RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaEcritureTCompte.AsString);
              End
              else
              begin
                ClassCpt:=0;
              end;
//                if not empty(CCourant.AsString) then
//                 begin
              case ClassCpt of
                 4:Begin
                    if empty(CCourant.AsString) then
                    TaEcritureTTvaCode.AsString:=RetourEnregistrement.TvaCode;
                    TaEcritureTTvaType.AsString:='D';
                    TaEcritureTTvaDate.Required:=true;
                    CtrlSaisieEcritureBOTiers.CodeErreur:=15100;
                    CtrlSaisieEcritureBOTiers.Retour:=False;
                   End;

                 6..7:Begin
                       if ((empty(CCourant.AsString) and (not VerifFNumeric(TaEcritureTTvaTaux).VideOUZero))) then
                           TaEcritureTTvaCode.AsString:=RetourEnregistrement.TvaCode;
                       if empty(TaEcritureTTvaType.AsString) then
                       TaEcritureTTvaType.AsString:=RetourEnregistrement.TvaType;
                       if RetourEnregistrement.TvaType='E' then
                          Begin
                           CtrlSaisieEcritureBOTiers.CodeErreur:=15200;
                           CtrlSaisieEcritureBOTiers.Retour:=False;
                          End;
                       if RetourEnregistrement.TvaType='D' then
                          Begin
                           TaEcritureTTvaDate.Required:=true;
                           CtrlSaisieEcritureBOTiers.CodeErreur:=15300;
                           CtrlSaisieEcritureBOTiers.Retour:=False;
                          End;
                      end;
                 0:Begin
                    CtrlSaisieEcritureBOTiers.CodeErreur:=15400;
                    CtrlSaisieEcritureBOTiers.Retour:=False;
//                        Messagebox(0,Pchar('Vous ne pouvez pas saisir de TVA si aucun compte n''est défini !!!'),'Erreur de saisie',0);
                   End;

              end;{Fin du Case}
//                 end
//                 else
//                 Begin
//                 TaEcritureTTvaCode.Required:=false;
//                 TaEcritureTTvaDate.Required:=false;
//                 End;

             End;
           // TVA Type;
          16:Begin
              if not empty(TaEcritureTCompte.AsString) then
              begin
                 ClassCpt:=StrToInt_Lgr(TaEcritureTCompte.AsString[1]);
                 RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaEcritureTCompte.AsString);
              End
              else
              begin
                ClassCpt:=0;
              end;
              case ClassCpt of
                 4:Begin
                    if empty(CCourant.AsString) then
                    TaEcritureTTvaCode.AsString:=RetourEnregistrement.TvaCode;
                    TaEcritureTTvaType.AsString:='D';
                    TaEcritureTTvaDate.Required:=true;
                    CtrlSaisieEcritureBOTiers.CodeErreur:=16100;
                    CtrlSaisieEcritureBOTiers.Retour:=False;
                   End;

                 6..7:Begin
                       if ((empty(CCourant.AsString) and (not VerifFNumeric(TaEcritureTTvaTaux).VideOUZero))) then
                           TaEcritureTTvaCode.AsString:=RetourEnregistrement.TvaCode;
                       if empty(TaEcritureTTvaType.AsString) then
                       TaEcritureTTvaType.AsString:=RetourEnregistrement.TvaType;
                       if RetourEnregistrement.TvaType='E' then
                          Begin
                           CtrlSaisieEcritureBOTiers.CodeErreur:=16200;
                           CtrlSaisieEcritureBOTiers.Retour:=False;
                          End;
                       if RetourEnregistrement.TvaType='D' then
                          Begin
                           TaEcritureTTvaDate.Required:=true;
                           CtrlSaisieEcritureBOTiers.CodeErreur:=16300;
                           CtrlSaisieEcritureBOTiers.Retour:=False;
                          End;
                      end;
                 0:Begin
                    CtrlSaisieEcritureBOTiers.CodeErreur:=16400;
                    CtrlSaisieEcritureBOTiers.Retour:=False;
//                        Messagebox(0,Pchar('Vous ne pouvez pas saisir de TVA si aucun compte n''est défini !!!'),'Erreur de saisie',0);
                   End;
              end;{Fin du Case}
             End;
           // TVA Date;
          18:Begin
              if not empty(TaEcritureTCompte.AsString) then
              begin
                 ClassCpt:=StrToInt_Lgr(TaEcritureTCompte.AsString[1]);
                 RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaEcritureTCompte.AsString);
              End
              else
              begin
                ClassCpt:=0;
              end;
              case ClassCpt of
                 4:Begin
                    if empty(CCourant.AsString) then
                     begin
                       CtrlSaisieEcritureBOTiers.CodeErreur:=18100;
                       CtrlSaisieEcritureBOTiers.Retour:=False;
                       Messagebox(0,Pchar('Vous devez définir une date de livraison pour la TVA de type "D"'),'Erreur de saisie',0);
                     end
                     else if CCourant.AsDateTime < E.DatExoDebut then
                      begin
                       CtrlSaisieEcritureBOTiers.CodeErreur:=18200;
                       CtrlSaisieEcritureBOTiers.Retour:=False;
                       Messagebox(0,Pchar('Pour être prise en compte dans le calcul TVA, la date de livraison doit se situer après le '+ DateToStr(E.DatExoDebut)),'Erreur de saisie',0);
                      end;

                   End;

                 6..7:Begin
                      end;
                 0:Begin
                    CtrlSaisieEcritureBOTiers.CodeErreur:=18600;
                    CtrlSaisieEcritureBOTiers.Retour:=False;
//                        Messagebox(0,Pchar('Vous ne pouvez pas saisir de TVA si aucun compte n''est défini !!!'),'Erreur de saisie',0);
                   End;
              end;{Fin du Case}
             End;


//        4: begin//si champ n°3 (Qté)
//            If (Empty(CCourant.AsString)) and (ccourant.ReadOnly=false) then
//             cCourant.AsString:='0';
//           end;//fin si champ n°3 (Qté)
//        5: begin//si champ n°4 (Montant HT)
//             If (Empty(CCourant.AsString)) or (ccourant.AsString='0') then
//             Begin // si champ n°4 vide ou =0
//             CtrlSaisieEcritureBOTiers.CodeErreur:=5100;
//             CtrlSaisieEcritureBOTiers.Retour:=False;
//             Messagebox(0,Pchar('La saisie du montant HT est obligatoire !!!'),'Erreur de saisie',0);
//             end;//fin  si champ n°4 vide ou =0
//           end;//fin si champ n°4 (Montant HT)
        end;//fin du case.ccourant
  end; //fin etat insertion ou modif

end;




procedure TDMEcritures.TaEcritureTBeforeCancel(DataSet: TDataSet);
begin
//
end;

procedure TDMEcritures.TaEcritureTBeforePost(DataSet: TDataSet);
var
i:integer;
ControleSaisie:TErreurSaisie;
begin
if VerifFNumeric(TaEcritureTCreditSaisie).VideOUZero and VerifFNumeric(TaEcritureTDebitSaisie).VideOUZero and VerifFNumeric(TaEcritureTTvaTaux).VideOUZero then
   begin
   Messagebox(0,Pchar('Vous devez saisir au moins un montant !!!'),'Erreur de saisie',0);
   abort;
   end;
case Dataset.State of
  dsEdit:Begin
            TaEcritureTTiers.AsString:=DMTiers.TaTiersBalTiers.AsString;
            // Verification des champs saisi pour Ecriture
            // Champ Compte
            ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[5]);
            if not ControleSaisie.Retour then
               Begin
                Dataset.Fields[5].FocusControl;
                abort;
               End;
            // Champ Libellé
            ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[7]);
            if not ControleSaisie.Retour then
               Begin
                case ControleSaisie.CodeErreur of
                   7100,7200,7300:Dataset.Fields[7].AsString:=DMPlan.LibelleDuNumCptPCU(Dataset.Fields[5].AsString);
                   7400:Dataset.Fields[7].AsString:='Opération de l''année précédente';
                end;
               End;
            // Champ Debit Saisie
            ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[10]);
            if not ControleSaisie.Retour then
               Begin
                case ControleSaisie.CodeErreur of
                   10100:;// Compte de TVA
                   10500:;// les champ credit saisie et debit saisie ont tous les 2 une valeur
                end;
               End;
            // Champ Credit Saisie
            ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[11]);
            if not ControleSaisie.Retour then
               Begin
                case ControleSaisie.CodeErreur of
                   11100:;// Compte de TVA
                   11500:;// les champ credit saisie et debit saisie ont tous les 2 une valeur
                end;
               End;
            // Champ TvaCode, TvaType, TvaTaux(Montant Tva), TvaDate (Date de Livraison)
            for i:=15 to 18 do
             begin
              ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[i]);
            if not ControleSaisie.Retour then
               Begin
                case ControleSaisie.CodeErreur of
                   17400:begin
                          Messagebox(0,Pchar('Vous ne pouvez pas saisir de TVA si aucun compte n''est défini !!!'),'Erreur de saisie',0);
                          Dataset.Fields[5].FocusControl;
                          abort;
                         end;
                   17500:begin
                          Messagebox(0,Pchar('Le montant TVA est obligatoire pour les comptes de TVA !!!'),'Erreur de saisie',0);
                          Dataset.Fields[16].FocusControl;
                          abort;
                         end;
                   11500:;
                end;{ fin du case}
               end;
             end;
         End;

  dsInsert:Begin
           // On s'assure que la pièce à déjà été créée
           if DMPieces.PieceBOTiersExiste(DMTiers.TaTiersBalTiers.AsString).retour then
               Begin
            QueryEcriture.Close;
            QueryEcriture.Open;
            TaEcritureTID.AsInteger:=QueryEcritureMAXOFID.AsInteger+1;

            TaEcritureTID_Piece.AsInteger:=DMPieces.PieceBOTiersExiste(DMTiers.TaTiersBalTiers.AsString).ID;

            QueryMaxIDLigne.Close;
            QueryMaxIDLigne.ParamByName('IDP').AsInteger:=DMPieces.PieceBOTiersExiste(DMTiers.TaTiersBalTiers.AsString).ID;
            QueryMaxIDLigne.Open;

            TaEcritureTID_Ligne.AsInteger:=QueryMaxIDLigneMAXOFID_Ligne.AsInteger;
            TaEcritureTTiers.AsString:=DMTiers.TaTiersBalTiers.AsString;
            TaEcritureTDate.AsDateTime:=E.DatExoFin;
            TaEcritureTQuand.AsDateTime:=now;
            TaEcritureTQui.AsString:=E.NomUtilisateur;
            // Verification des champs saisi pour Ecriture
            // Champ Compte
            ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[5]);
            if not ControleSaisie.Retour then
               Begin
                Dataset.Fields[5].FocusControl;
                abort;
               End;
            // Champ Libellé
            ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[7]);
            if not ControleSaisie.Retour then
               Begin
                case ControleSaisie.CodeErreur of
                   7100,7200,7300:Dataset.Fields[7].AsString:=DMPlan.LibelleDuNumCptPCU(Dataset.Fields[5].AsString);
                   7400:Dataset.Fields[7].AsString:='Opération de l''année précédente';
                end;
               End;
            // Champ Debit Saisie
            ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[10]);
            if not ControleSaisie.Retour then
               Begin
                case ControleSaisie.CodeErreur of
                   10100:;// Compte de TVA
                   10500:;// les champ credit saisie et debit saisie ont tous les 2 une valeur
                end;
               End;
            // Champ Credit Saisie
            ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[11]);
            if not ControleSaisie.Retour then
               Begin
                case ControleSaisie.CodeErreur of
                   11100:;// Compte de TVA
                   11500:;// les champ credit saisie et debit saisie ont tous les 2 une valeur
                end;
               End;
            // Champ TvaCode, TvaType, TvaTaux(Montant Tva), TvaDate (Date de Livraison)
            for i:=15 to 18 do
             begin
              ControleSaisie:=CtrlSaisieEcritureBOTiers(Dataset.Fields[i]);
            if not ControleSaisie.Retour then
               Begin
                case ControleSaisie.CodeErreur of
                   17400:begin
                          Messagebox(0,Pchar('Vous ne pouvez pas saisir de TVA si aucun compte n''est défini !!!'),'Erreur de saisie',0);
                          Dataset.Fields[5].FocusControl;
                          abort;
                         end;
                   17500:begin
                          Messagebox(0,Pchar('Le montant TVA est obligatoire pour les comptes de TVA !!!'),'Erreur de saisie',0);
                          Dataset.Fields[16].FocusControl;
                          abort;
                         end;
                   11500:;
                end;{fin du case}
               end;
             end;
             end
              else
             begin
              showMessage('Erreur à la création de la pièce Bilan Ouverture Tiers');
              abort;
             end;
           End;
end;

end;

procedure TDMEcritures.TaEcritureTBeforeInsert(DataSet: TDataSet);
begin
FiltragesAideCompteBOT;
if not DMPieces.PieceBOTiersExiste(DMTiers.TaTiersBalTiers.AsString).retour then
   Begin
    DMPieces.CreationPiece(DMPieces.IDPieceBOTiers,-1,-1,E.Devise,
    'Piece_N-1','',DMTiers.TaTiersBalTiers.AsString,E.NomUtilisateur,'','','','','',
    JourPrecedent(E.DatExoDebut,1).Date_,now,now,now,false,0);
   End
   else
   Begin

   End;


end;

procedure TDMEcritures.TaEcritureTBeforeDelete(DataSet: TDataSet);
begin
try
 case TaEcritureT.RecordCount of
   0:Begin

     End;
   1:Begin
      if DMPieces.PieceBOTiersExiste(DMTiers.TaTiersBalTiers.AsString).retour then
       Begin
          DMPieces.SuppressionPiece(TaEcritureTID_Piece.AsInteger);
       End;
     End;
 end;

//   if TaEcritureT.RecordCount=1 then
//   begin
//    if DMPieces.PieceBOTiersExiste(DMTiers.TaTiersBalTiers.AsString).retour then
//       Begin
//         DMPieces.SuppressionPiece(TaEcritureTID_Piece.AsInteger);
//       End
//       else
//       Begin
//        if TaEcritureT.RecordCount>1 then TaEcritureTAfterPost(Dataset);
//       End;
//   end;
 except

 end;
end;

procedure TDMEcritures.FiltragesAideCompteBOT;
var
ListeCpt:TStringList;
begin
ListeCpt:=TStringList.Create;
ListeCpt:= DMPlan.FiltrageParamCPT(97,E.Regime);
AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
//AideCompte.InitialiseCompte;
ListeCpt.Free;
end;

procedure TDMEcritures.TaEcritureTCalcFields(DataSet: TDataSet);
begin
if not VerifFNumeric(TaEcritureTDebitSaisie).VideOUZero then TaEcritureTMontantTTC.AsCurrency:=TaEcritureTDebitSaisie.AsCurrency+TaEcritureTTvaTaux.AsCurrency;
if not VerifFNumeric(TaEcritureTCreditSaisie).VideOUZero then TaEcritureTMontantTTC.AsCurrency:=TaEcritureTCreditSaisie.AsCurrency+TaEcritureTTvaTaux.AsCurrency;
end;

procedure TDMEcritures.TaEcritureTAfterPost(DataSet: TDataSet);
begin
TaEcritureTTvaDate.Required:=False;
TaEcritureTTvaCode.Required:=False;
// Mise à jour des totaux dans la table Tiers
DMTiers.TaTiersBal.Edit;
if DMPieces.PieceBOTiersExiste(DMTiers.TaTiersBalTiers.AsString).retour then
    Begin
     QuSumEcritureBOT.Close;
     QuSumEcritureBOT.ParamByName('IDPiece').AsInteger:=DMPieces.PieceBOTiersExiste(DMTiers.TaTiersBalTiers.AsString).ID;
     QuSumEcritureBOT.Open;
     DMTiers.TaTiersBalCredit_Deb.AsCurrency:=QuSumEcritureBOTSomCredit.AsCurrency;
     DMTiers.TaTiersBalDebit_Deb.AsCurrency:=QuSumEcritureBOTSomDebit.AsCurrency;
    end;
TableGerePost(DMTiers.TaTiersBal);
MessDerSub:=true;
end;

procedure TDMEcritures.TaEcritureTAfterDelete(DataSet: TDataSet);
begin
try
 case TaEcritureT.RecordCount of
   0:Begin
          DMTiers.TaTiersBal.Edit;
          DMTiers.TaTiersBalCredit_Deb.AsCurrency:=0;
          DMTiers.TaTiersBalDebit_Deb.AsCurrency:=0;
          TableGerePost(DMTiers.TaTiersBal);
     End;

 else TaEcritureTAfterPost(Dataset);

 end;
 except

 end;

end;

procedure TDMEcritures.TaEcritureTBeforeEdit(DataSet: TDataSet);
begin
FiltragesAideCompteBOT;
end;

procedure TDMEcritures.TaEcritureBalBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMEcritures.TaEcritureBalBeforeEdit(DataSet: TDataSet);
begin
abort;
end;

procedure TDMEcritures.QuGestVisuCompteBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMEcritures.QuEcrCompteCodeTvaBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMEcritures.TaEcritureVisuBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

// Mise à jour de la table écriture à partir de la liste
// Ligne d'indice 0 = Ligne de contre partie
// Les lignes de type X sont en principe les lignes de contre partie
// !!! Elles ne doivent, en principe, pas exister dans le corps de la pièce !!!
// Toutes les lignes T (TVA) doivent se trouver en fin de pièce
function TDMEcritures.BatchMove_Liste_SurTaEcriture(Source:TList;Ecriture:TEcriture_Isa):integer;
var
i,IDEcriture,IMax,IMin,rang:integer;
ListDelete:Tstringlist;
compteTva:string;
tab:variant;
creationReste:TInfosCreationReste;
DateTva:Tdatetime;
strtmp:string;
begin
try
if DMBalance=nil then DMBalance:=TDMBalance.create(application.Mainform);
if DMPointage2=nil then DMPointage2:=TDMPointage2.create(application.Mainform);
ListDelete:=TStringList.Create;
result:=0;
TiersEcriture:='';
  if (source<>nil) and (TaEcriture<>nil) then
   begin
   if TaEcriture.active then
     TaEcriture.close;
   TaEcriture.Open;
   TableGereStartTransaction(TaEcriture);
        try
        i:=0;
        while i<=source.Count-1 do
          Begin
          if ((PIdentifiant_obj(source.Items[i])^.Ligne.TypeLigne ='V')or(((PIdentifiant_obj(source.Items[i])^.Ligne.Debit=0))and(PIdentifiant_obj(source.Items[i])^.Ligne.Credit=0)))then
            begin
//            if Ecriture.Piece.AcceptPieceNul then   //isa le 30082007
//               PIdentifiant_obj(source.Items[i])^.Ligne.Enregistrer:=true
//            else
               PIdentifiant_obj(source.Items[i])^.Ligne.Enregistrer:=false;
            end
            else
               PIdentifiant_obj(source.Items[i])^.Ligne.Enregistrer:=true;
          inc(i);
          End;

         //Mise en ordre du corps de la pièce
         //avec les lignes T(TVA) toujours à la fin de la pièce
        IMin:=1;
        IMax:=source.count-1;
        while IMin<IMax do
          Begin
            if PIdentifiant_obj(source.Items[IMax])^.Ligne.TypeLigne='T'then
              dec(IMax)
            else
              Begin
                if PIdentifiant_obj(source.Items[IMin])^.Ligne.TypeLigne<>'T'then
                  inc(IMin)
                else
                  Begin
                    if PIdentifiant_obj(source.Items[IMin])^.Ligne.TypeLigne='T'then
                      Begin
                        source.Exchange(IMin,IMax);
                        dec(IMax);
                        inc(IMin);
                      End;
                  End;
              End;
          End;

        for i:=0 to source.Count-1 do
          Begin//for longueur du source
          //remplissage de la table ecriture par rapport à la liste
          if PIdentifiant_obj(source.Items[i])^.Ligne.Enregistrer then
            begin
               if PIdentifiant_obj(source.Items[i])^.ID_Ord<>0 then
                 Begin
                   //rechercher dans table ecriture si l'id old n'existe pas
                   if (RechercheIDEcritureExistant(PIdentifiant_obj(source.Items[i])^.ID_Ord)or(PIdentifiant_obj(source.Items[i])^.ID_Ord < 10000000))then
                     begin
                     IDEcriture:=ecriture.NewIDEcriture(taecriture,'ID');
                     end
                     else
                     IDEcriture:=PIdentifiant_obj(source.Items[i])^.ID_Ord;
                 End
                 else
                     IDEcriture:=ecriture.NewIDEcriture(taecriture,'ID');
                 PIdentifiant_obj(source.Items[i])^.ID_Tmp:=IDEcriture;
                 if PIdentifiant_obj(source.Items[i])^.ID_Ord<>IDEcriture then
                   begin
                   if DMPointage2.ListeID_Appelant<>nil then
                     Begin//si ListeID_Appelant existe
                       rang:=0;
                       while rang<>-1 do
                         begin
                           rang:=DMPointage2.ListResteAffect_IndexOf([inttostr(PIdentifiant_obj(source.Items[i])^.ID_Ord)],[1],DMPointage2.ListeID_Appelant);
                           if rang<>-1 then
                             PListeResteAffect(DMPointage2.ListeID_Appelant.Items[rang])^.ID_Ligne_Appelant:=IDEcriture;
                         end;//fin du while rang
                     End;//fin si ListeID_Appelant existe
                   PIdentifiant_obj(source.Items[i])^.ID_Ord:=IDEcriture;
                   end;
                 with PIdentifiant_obj(source.Items[i])^ do
                 begin
                 if ((not empty(PIdentifiant_obj(source.Items[i])^.ligne.Complement.CodeTvaCompl))and (Ecriture.Piece.IDJournal in [1,2])and( PIdentifiant_obj(source.Items[i])^.ligne.TypeLigne<>'T')) then
                   begin
                   new(TvaExigible);
                   compteTva:=RenvoieInfoSurTableDiverse(PIdentifiant_obj(source.Items[i])^.ligne.Complement.CodeTvaCompl,DMTVACode.TaTvaCode,'TvaCode',['Compte'],tab);
                   TvaExigible.CompteTva:=compteTva;

                   if PIdentifiant_obj(source.Items[i])^.ligne.Complement.TvaType='D' then
                   begin
                     if datevalide(PIdentifiant_obj(source.Items[i])^.ligne.Complement.TvaDate) then
                       datetva:=StrToDate_Lgr(PIdentifiant_obj(source.Items[i])^.ligne.Complement.TvaDate)
                     else
                       datetva:=0;

                     TvaExigible.exigible:=(datetva>=E.PremiereDateDeclaration);
                   end
                   else
                     TvaExigible.exigible:=true;
                   TvaExigible.IDEcriture:=IDEcriture;
                   TvaExigible.IDPiece:=ecriture.Piece.FirstIDPiece;
                   if PIdentifiant_obj(source.Items[i])^.ligne.Debit<>0 then
                     TvaExigible.MontantTva:=-PIdentifiant_obj(source.Items[i])^.ligne.Complement.MontantTva
                   else
                     TvaExigible.MontantTva:=PIdentifiant_obj(source.Items[i])^.ligne.Complement.MontantTva;
                   listeTvaExigible.Add(TvaExigible);
                   end;
                 if ((not (Ecriture.Piece.IDJournal in [1,2]))or(Ligne.TypeLigne<>'H'))then
                   Ecriture.InitialiseComplement_Obj(ligne.Complement);
                 TaEcriture.AppendRecord([IDEcriture,ecriture.Piece.FirstIDPiece,Ligne.TypeLigne,
                 i,ecriture.Piece.DateSaisie,ligne.Compte,ligne.tiers,ligne.Libelle,ligne.Qt1,ligne.Qt2,
                 ligne.Debit,ligne.Credit,e.Devise,ligne.Debit,ligne.Credit,
                 ligne.Complement.CodeTvaCompl,ligne.Complement.TvaType,ligne.Complement.TvaTaux,
                 PIdentifiant_obj(source.Items[i])^.ligne.Complement.TvaDate,null,null,e.NomUtilisateur,now,
                 null,null,null,null,null,null,ligne.Complement.MontantTva]);

                 if ((not empty(ligne.tiers))or(DMPlan.CptEstPointable(ligne.Compte)))then
                   begin
                      initialise_InfosCreationReste(creationReste);
                      creationReste.DatePiece:=ecriture.Piece.DateSaisie;
                      creationReste.IDEcriture:=IDEcriture;
                      creationReste.IDPiece:=ecriture.Piece.FirstIDPiece;
                      creationReste.Pointage.MontantPointage:=0;
                      creationReste.Libelle:=ligne.Libelle;
                      creationReste.MontantDebit:=ligne.Debit;
                      creationReste.MontantCredit:=ligne.Credit;
                      if empty(ligne.tiers) then
                        creationReste.tiers:=ligne.Compte
                      else
                        creationReste.tiers:=ligne.tiers;
                      creationReste.Reference:=ecriture.Piece.Reference;
                      if creationReste.MontantDebit <>0 then
                        begin
                          creationReste.reste.Reste:=creationReste.MontantDebit;
                          creationReste.reste.sensReste:=false;
                        end
                      else
                        begin
                          creationReste.reste.Reste:=creationReste.MontantCredit;
                          creationReste.reste.sensReste:=true;
                        end;
                      DMPointage2.GestionDuReste(creationReste,false);
                     //transformé le 19-05-03 par isa
                     if ((((Ligne.TypeLigne='X')and(ecriture.Piece.IDJournal in [1,2])))or(((Ligne.TypeLigne='H')and(not (ecriture.Piece.IDJournal in [1,2])))))then
                       begin
//                         if ((Ligne.TypeLigne='H')and(not (ecriture.Piece.IDJournal in [1,2]))) then
//                           ecriture.ListeContrepartie.Add();
                         ecriture.Piece.IDContrepartie:=idecriture;
                         ecriture.FirstIDEcriture:=idecriture;
                       end;
                   end;
                 TaEcriture.FlushBuffers;
                 end;
           end;//fin du typeligne<>V
          End;//fin for longueur du source
        except
        showmessage('Erreur d''Ecriture dans Table Ecritures');
        TableGereRollBack(TaEcriture);
        TableGereRollBack(DMBalance.TaBalance);
        for i:=0 to ListDelete.Count-1 do
        Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,True,'','',0],false,false,StrToInt_Lgr(ListDelete.Strings[i]));
        abort;
        end;//fin du try
   end;//fin si source <> nil
finally
ListDelete.free;
end;//fin du try finally
End;


procedure TDMEcritures.ChoixSensEtMontant_SurPointeurListe(CCourant:PIdentifiant_obj);
var
sens:boolean;
begin
//DebCredEcriture:='';   //Ne pas utiliser comme cela car la gestion des quantités n'est pas faites
//montantEcriture:=0;    //sur cette procédure !!!!!!!
//QteEcriture1:='';
//QteEcriture2:='';
//  if ((ccourant.Ligne.Debit>0) and (ccourant.Ligne.credit=0)) then
//    sens:=false
// else
//  if ((ccourant.Ligne.Debit=0) and (ccourant.Ligne.credit>0)) then
//     sens:=true;
//
//
//  if DMPieces.Piece1.AnneePiece.PieceAnterieure then
//     Begin
//       if not sens then
//           begin
//           DebCredEcriture:='Debit_Report';
//           QteEcriture1:='Qt1_Report';
//           QteEcriture2:='Qt2_Report';
//           montantEcriture:=ccourant.Ligne.Debit;
//           end
//       else
//            begin
//            DebCredEcriture:='Credit_Report';
//            QteEcriture1:='Qt1_Report';
//            QteEcriture2:='Qt2_Report';
//            montantEcriture:= ccourant.Ligne.credit;
//            end;
//     End
//  else
//     Begin
//       if not sens then
//           begin
//           DebCredEcriture:='Debit_Base';
//           QteEcriture1:='Qt1_Base';
//           QteEcriture2:='Qt2_Base';
//           montantEcriture:=ccourant.Ligne.Debit;
//           end
//       else
//            begin
//            DebCredEcriture:='Credit_Base';
//            QteEcriture1:='Qt1_Base';
//            QteEcriture2:='Qt2_Base';
//            montantEcriture:= ccourant.Ligne.credit;
//            end;
//     End;
end;


function TDMEcritures.RechercheIDEcritureExistant(ID_Old:integer):boolean;
var
TableTemp:TTable;
Begin
result:=false;
   try
      try
      TableTemp:=Ttable.Create(self);
      TableTemp.DatabaseName:=TaEcriture.DatabaseName;
      tabletemp.TableName:=TaEcriture.TableName;
      tabletemp.open;
      if tabletemp.Locate('ID',ID_Old,[])then
        result:=true;
      except
        showmessage('Problème lors de la vérification de l"Identifiant d"une écriture existante');
        abort;
      end;//fin du try except
   finally
   tableTemp.Free;
   end;//fin du try finally
End;

procedure TDMEcritures.TaEcriturePostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  TableGereRollBack(dataset);
  TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMEcritures.TaEcritureDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  TableGereRollBack(dataset);
  TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMEcritures.TaEcritureBalBeforeDelete(DataSet: TDataSet);
begin
abort;
end;



procedure TDMEcritures.TaEcritureVisuBeforeOpen(DataSet: TDataSet);
begin
FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
TaEcritureVisuTvaTaux.DisplayFormat := ',0.00 %;';
end;

procedure TDMEcritures.TaEcritureBalBeforeOpen(DataSet: TDataSet);
begin
if DMPieces = nil then
   DMPieces:=TDMPieces.Create(application.MainForm);
end;


procedure TDMEcritures.TaEcriture2CalcFields(DataSet: TDataSet);
begin
if not empty(TaEcriture2.findfield('Tiers').asstring)then
  TaEcriture2.findfield('CompteSaisie').asstring:=TaEcriture2.findfield('Tiers').asstring
else
  TaEcriture2.findfield('CompteSaisie').asstring:=TaEcriture2.findfield('Compte').asstring;
end;

procedure TDMEcritures.QuEcriture_EditionFilterRecordCompte(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=(ListeFiltreEdit.IndexOf(DataSet.findField('Compte').AsString) <> -1);
end;

procedure TDMEcritures.QuEcriture_EditionFilterRecordTiers(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=(ListeFiltreEdit.IndexOf(DataSet.findField('Tiers').AsString) <> -1);
end;
end.
