unit DMTier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,GR_Librairie_obj,E2_Librairie_obj,LibSQL,LibZoneSaisie,E2_Decl_Records,DMRecherche,
  E2_LibInfosTable,Editions,ShellApi,lib_chaine,ChoixPeriode,libdates,
  Provider,DBClient,ObjetEdition;

Const

 C_TiersFilterRecordTous = 1;
 C_TiersFilterRecordResteAPointerNonNullPointable = 2;
 C_TiersFilterRecordResteAPointerNonNullTous = 3;
 C_TiersFilterRecordNullTous = 4;

type
  TDMTiers = class(TDataModule)
    TaTiers: TTable;
    DaTiers: TDataSource;
    TaTiersTiers: TStringField;
    TaTiersCompte: TStringField;
    TaTiersType: TStringField;
    TaTiersSensCredit: TBooleanField;
    TaTiersTvaDebit: TBooleanField;
    TaTiersActif: TBooleanField;
    TaTiersBal: TTable;
    DaTiersBal: TDataSource;
    TaTiersBalTiers: TStringField;
    TaTiersBalCompte: TStringField;
    TaTiersBalType: TStringField;
    TaTiersBalDebit_Deb: TFloatField;
    TaTiersBalCredit_Deb: TFloatField;
    TaTiersGest: TTable;
    DaTiersGest: TDataSource;
    TaTiersGestTiers: TStringField;
    TaTiersGestNom: TStringField;
    TaTiersGestCompte: TStringField;
    TaTiersGestType: TStringField;
    TaTiersGestSensCredit: TBooleanField;
    TaTiersGestRapprochement: TBooleanField;
    TaTiersGestTvaDebit: TBooleanField;
    TaTiersGestAbandonne: TBooleanField;
    TaTiersGestDebit_Deb: TCurrencyField;
    TaTiersGestCredit_Deb: TCurrencyField;
    TaTiersGestAdresse1: TStringField;
    TaTiersGestAdresse2: TStringField;
    TaTiersGestPoste: TStringField;
    TaTiersGestVille: TStringField;
    TaTiersGestPays: TStringField;
    TaTiersGestLivr_Adr1: TStringField;
    TaTiersGestLivr_Adr2: TStringField;
    TaTiersGestLivr_Poste: TStringField;
    TaTiersGestLivr_Ville: TStringField;
    TaTiersGestLivr_Pays: TStringField;
    TaTiersGestTelephone1: TStringField;
    TaTiersGestTelephone2: TStringField;
    TaTiersGestTelecopie: TStringField;
    TaTiersGestMel: TStringField;
    TaTiersGestQui: TStringField;
    TaTiersGestQuand: TDateTimeField;
    TaTiersGestActif: TBooleanField;
    TaTiersGestID_GESTCO: TFloatField;
    TaTiersGestID_COMMUNICATION: TFloatField;
    TaTiersGestCODE_GESTCO: TStringField;
    TaTiersBalNom: TStringField;
    TaTiersNom: TStringField;
    TaTiersBalDebit_Deb_Bal_Tiers: TCurrencyField;
    TaTiersBalCredit_Deb_Bal_Tiers: TCurrencyField;
    TaTiersBalSolde_Debut_Bal_Tiers: TCurrencyField;
    TaTiersGestID_Affichage: TIntegerField;
    TaTiersGestJBanque: TStringField;
    TaTiersGestNbLigneNonPointe: TIntegerField;
    TaTiersGestNbLigneTotalementPointe: TIntegerField;
    TaTiersGestNbLignePartiPointe: TIntegerField;
    TaTiersGestSoldeCompte: TCurrencyField;
    TaTiersGestSoldeReste: TCurrencyField;
    QuTiers_Compte_Pointable: TQuery;
    QuTiers_Compte_PointableTiers: TStringField;
    DaTiers_Compte_Pointable: TDataSource;
    QuTiers_Compte_PointableNom: TStringField;
    QuTiers_Compte_PointableCompte: TStringField;
    QuTiers_Compte_PointableType: TStringField;
    QuTiers_Compte_PointableActif: TBooleanField;
    QuPlanAuxEdition: TQuery;
    QuGrandLivreTiersEdition: TQuery;
    QuListeValRupt: TQuery;
    QuSousTotal1: TQuery;
    QuTotalG: TQuery;
    QuSousTotal3: TQuery;
    QuSousTotal2: TQuery;
    QuReport: TQuery;
    QuGrandLivreTiersEditionID: TIntegerField;
    QuGrandLivreTiersEditionID_Piece: TIntegerField;
    QuGrandLivreTiersEditionTypeLigne: TStringField;
    QuGrandLivreTiersEditionID_Ligne: TSmallintField;
    QuGrandLivreTiersEditionDate: TDateField;
    QuGrandLivreTiersEditionCompte: TStringField;
    QuGrandLivreTiersEditionTiers: TStringField;
    QuGrandLivreTiersEditionLibelle: TStringField;
    QuGrandLivreTiersEditionQt1: TFloatField;
    QuGrandLivreTiersEditionQt2: TFloatField;
    QuGrandLivreTiersEditionDebitSaisie: TCurrencyField;
    QuGrandLivreTiersEditionCreditSaisie: TCurrencyField;
    QuGrandLivreTiersEditionID_Devise: TIntegerField;
    QuGrandLivreTiersEditionDebit: TCurrencyField;
    QuGrandLivreTiersEditionCredit: TCurrencyField;
    QuGrandLivreTiersEditionTvaCode: TStringField;
    QuGrandLivreTiersEditionTvaType: TStringField;
    QuGrandLivreTiersEditionTvaTaux: TFloatField;
    QuGrandLivreTiersEditionTvaDate: TDateField;
    QuGrandLivreTiersEditionRapprochement: TStringField;
    QuGrandLivreTiersEditionValidation: TDateField;
    QuGrandLivreTiersEditionQui: TStringField;
    QuGrandLivreTiersEditionQuand: TDateTimeField;
    QuGrandLivreTiersEditionNum_Cheque: TStringField;
    QuGrandLivreTiersEditionTable_Gen: TStringField;
    QuGrandLivreTiersEditionChamp_Gen: TStringField;
    QuGrandLivreTiersEditionVal_Champ_Gen: TStringField;
    QuGrandLivreTiersEditionID_GESTCO: TFloatField;
    QuGrandLivreTiersEditionCODE_GESTCO: TStringField;
    QuGrandLivreTiersEditionMontant_Tva: TCurrencyField;
    QuGrandLivreTiersEditionID_GESTANAL: TIntegerField;
    QuGrandLivreTiersEditionCODE_GESTANAL: TStringField;
    QuGrandLivreTiersEditionID_1: TIntegerField;
    QuGrandLivreTiersEditionJournal: TIntegerField;
    QuGrandLivreTiersEditionReference: TStringField;
    QuGrandLivreTiersEditionDate_1: TDateField;
    QuGrandLivreTiersEditionLibelle_1: TStringField;
    QuGrandLivreTiersEditionTypePiece: TSmallintField;
    QuGrandLivreTiersEditionCompte_1: TStringField;
    QuGrandLivreTiersEditionID_Devise_1: TIntegerField;
    QuGrandLivreTiersEditionValidation_1: TDateField;
    QuGrandLivreTiersEditionQui_1: TStringField;
    QuGrandLivreTiersEditionQuand_1: TDateTimeField;
    QuGrandLivreTiersEditionNum_Cheque_1: TStringField;
    QuGrandLivreTiersEditionID_GESTCO_1: TFloatField;
    QuGrandLivreTiersEditionCODE_GESTCO_1: TStringField;
    QuGrandLivreTiersEditionTable_Gen_1: TStringField;
    QuGrandLivreTiersEditionChamp_Gen_1: TStringField;
    QuGrandLivreTiersEditionVal_Champ_Gen_1: TStringField;
    QuGrandLivreTiersEditionSoldeDeb: TCurrencyField;
    QuGrandLivreTiersEditionSoldeCre: TCurrencyField;
    QuGrandLivreTiersEditionReferencePiece: TStringField;
    TaTierslookup: TTable;
    QuTiers_Compte_PointableTotDebit: TCurrencyField;
    QuTiers_Compte_PointableTotCredit: TCurrencyField;
    QuTiers_Compte_PointableTotReste: TCurrencyField;
    QuTiers_Compte_PointableSolde: TCurrencyField;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    QuPointageDansPeriode: TQuery;
    procedure ModuleCadreCreate(Sender: TObject);
    procedure ModuleCadreDestroy(Sender: TObject);
//******************************************************************************
    function StrListe(TableCtrl:TTable;nomChamp:string):TStringList;
//******************************************************************************
    procedure TaTiersGestBeforePost(DataSet: TDataSet);
    procedure TaTiersGestPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaTiersGestAfterPost(DataSet: TDataSet);
    procedure TaTiersGestBeforeDelete(DataSet: TDataSet);
    procedure TaTiersGestDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaTiersGestAfterDelete(DataSet: TDataSet);
    Function GenerCodeTiers(NomTiers:String):String;
    procedure TaTiersGestBeforeInsert(DataSet: TDataSet);
    procedure TaTiersGestBeforeEdit(DataSet: TDataSet);
    procedure TaTiersBalCalcFields(DataSet: TDataSet);
    procedure TaTiersGestCalcFields(DataSet: TDataSet);
    Function CtrlSaisieTiers(CCourant:Tfield):TErreurSaisie;
    procedure TaTiersGestFilterRecordAideCompte(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuGrandLivreTiersEditionCalcFields(DataSet: TDataSet);
    procedure QuGrandLivreTiersEditionBeforeOpen(DataSet: TDataSet);

    procedure QuTiers_Compte_PointableFilterRecordTous(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuTiers_Compte_PointableFilterRecordResteAPointerNonNullTous(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuTiers_Compte_PointableFilterRecordResteAPointerNonNullPointable(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuTiers_Compte_PointableFilterRecordNullTous(DataSet: TDataSet;
      var Accept: Boolean);
    Function AffecteFilterRecord(NumFilterRecord : integer):Integer;
    procedure QuTiers_Compte_PointableBeforeOpen(DataSet: TDataSet);
    function LibelleDuTiers(TiersSaisie:string):string;
    function CptDuTiers(TiersSaisie:string):string;
    procedure QuPlanAuxEditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
     ListeEdit:Tstringlist;
     Procedure ImportTiers(Valeurs:array of const;DataSet:TDataSet);

  end;

  Function EditionPlanAux(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionGrandLivreTiers(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionPlanAuxL(TypeEdition : integer; DataSet:TDataSet;ListeCompte:TStringList):Boolean;

var
  DMTiers: TDMTiers;
  MessTiersCompteOK:boolean;
  ActiveMessTiersCompteOK : Boolean; // Active ou désactive les message de compatibilé type et compte
  ListeIdEcr,ListeSoldeDeb,ListeSoldeCre:TStringList;     //pour edition grand livre des tiers
  SoldeDeb,SoldeCre:Currency;                             //pour edition grand livre des tiers
  TiersCalcSoldes,filtres:string;
                           //pour edition grand livre des tiers

implementation

uses DMEcriture, DMPlanCpt, E2_AideCompte,DMBalances, DMPointages2,
  DMDiocEtatBalance,LibRessourceString,DMExports,DMConstantes;

{$R *.DFM}

Function EditionGrandLivreTiers(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var NomFich,Chemin,
      Cpt1,Cpt2:String;
  var periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
Begin

  Chemin :=E.RepertoireComptaWeb;
  NomFich:='GrandLivreTiers';
  Cpt1:='+A';
  DMTiers.QuTotalG.SQL.Clear;
  DMTiers.QuTotalG.SQL.Add('select distinct tiers from ecriture order by tiers');
  DMTiers.QuTotalG.Open;
  DMTiers.QuTotalG.Last;
  Cpt2:=DMTiers.QuTotalG.findfield('tiers').AsString;
  DMTiers.QuTotalG.Close;
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  if periode.Retour then begin
      if DMTiers=nil then DMTiers:=TDMTiers.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

      DMTiers.QuListeValRupt.SQL.Clear;
      DMTiers.QuListeValRupt.SQL.Add('select distinct tiers from ecriture');
      DMTiers.QuListeValRupt.SQL.Add(' where tiers between '''+Cpt1+''' and '''+cpt2+'''');
      DMTiers.QuListeValRupt.SQL.Add(' and ecriture."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMTiers.QuListeValRupt.SQL.Add(' order by tiers');
      DMTiers.QuListeValRupt.Open;

      //report debut
      DMTiers.QuReport.SQL.Clear;
      DMTiers.QuReport.Params.Clear;
      DMTiers.QuReport.SQL.Add('select cast(b.debit_report as numeric)+ ');
      DMTiers.QuReport.SQL.Add('  (select cast(sum(e.debitsaisie) as numeric) ');
      DMTiers.QuReport.SQL.Add('  from "'+E.RepertoireExercice+'BalanceTiers" b, ecriture e, piece p ');
      DMTiers.QuReport.SQL.Add('  where e.compte=b.compte and p.id=e.id_piece and b.tiers= :tiers and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''' ');
      DMTiers.QuReport.SQL.Add('  ) as TotDebit ');
      DMTiers.QuReport.SQL.Add(',cast(b.credit_report as numeric)+ ');
      DMTiers.QuReport.SQL.Add('  (select cast(sum(e.Creditsaisie) as numeric) ');
      DMTiers.QuReport.SQL.Add('  from "'+E.RepertoireExercice+'BalanceTiers" b, ecriture e, piece p ');
      DMTiers.QuReport.SQL.Add('  where e.compte=b.compte and p.id=e.id_piece and b.tiers= :tiers and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''' ');
      DMTiers.QuReport.SQL.Add('  ) as TotCredit ');
      DMTiers.QuReport.SQL.Add('from "'+E.RepertoireExercice+'BalanceTiers" b, ecriture e, piece p ');
      DMTiers.QuReport.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and b.tiers= :tiers ');
      DMTiers.QuReport.Params[0].DataType := ftString;
      DMTiers.QuReport.Open;

      //mouvement de la periode
      DMTiers.QuSousTotal1.SQL.Clear;
      DMTiers.QuSousTotal1.Params.Clear;
      DMTiers.QuSousTotal1.SQL.Add('select sum(debitsaisie),sum(creditsaisie),0,0 from ecriture where tiers= :tiers');
      DMTiers.QuSousTotal1.SQL.Add(' and ecriture."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMTiers.QuSousTotal1.Params[0].DataType := ftString;
      DMTiers.QuSousTotal1.Open;

      //total des mouvements
      DMTiers.QuSousTotal2.SQL.Clear;
      DMTiers.QuSousTotal2.Params.Clear;
      DMTiers.QuSousTotal2.SQL.Add('select distinct cast(b.debit_report as numeric)+ ');
      DMTiers.QuSousTotal2.SQL.Add('  (select cast(sum(e.debitsaisie) as numeric) ');
      DMTiers.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal2.SQL.Add('  where p.id=e.id_piece and tiers= :tiers and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMTiers.QuSousTotal2.SQL.Add('  (Select  cast(sum(e.DebitSaisie) as numeric)');
      DMTiers.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal2.SQL.Add('  where p.id=e.id_piece');
      DMTiers.QuSousTotal2.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and tiers= :tiers )');

      DMTiers.QuSousTotal2.SQL.Add(', cast(b.credit_report as numeric)+ ');
      DMTiers.QuSousTotal2.SQL.Add('  (select cast(sum(e.Creditsaisie) as numeric) ');
      DMTiers.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal2.SQL.Add('  where p.id=e.id_piece and tiers= :tiers and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMTiers.QuSousTotal2.SQL.Add('  (Select  cast(sum(e.creditSaisie) as numeric)');
      DMTiers.QuSousTotal2.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal2.SQL.Add('  where p.id=e.id_piece');
      DMTiers.QuSousTotal2.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and tiers= :tiers )');

      DMTiers.QuSousTotal2.SQL.Add(',0,0 ');

      DMTiers.QuSousTotal2.SQL.Add('from "'+E.RepertoireExercice+'BalanceTiers" b, ecriture e, piece p ');
      DMTiers.QuSousTotal2.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and tiers= :tiers ');
      DMTiers.QuSousTotal2.Params[0].DataType := ftString;
      DMTiers.QuSousTotal2.Open;

      //solde du compte
      DMTiers.QuSousTotal3.SQL.Clear;
      DMTiers.QuSousTotal3.Params.Clear;
      DMTiers.QuSousTotal3.SQL.Add('select distinct (cast(b.debit_report as numeric)+ ');
      DMTiers.QuSousTotal3.SQL.Add('  (select cast(sum(e.debitsaisie) as numeric) ');
      DMTiers.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('  where p.id=e.id_piece and tiers= :tiers and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMTiers.QuSousTotal3.SQL.Add('  (Select  cast(sum(e.DebitSaisie) as numeric)');
      DMTiers.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('  where p.id=e.id_piece');
      DMTiers.QuSousTotal3.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and tiers= :tiers )');
      DMTiers.QuSousTotal3.SQL.Add(' )-( ');
      DMTiers.QuSousTotal3.SQL.Add('  cast(b.credit_report as numeric)+ ');
      DMTiers.QuSousTotal3.SQL.Add('  (select cast(sum(e.Creditsaisie) as numeric) ');
      DMTiers.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('  where p.id=e.id_piece and tiers= :tiers and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMTiers.QuSousTotal3.SQL.Add('  (Select  cast(sum(e.creditSaisie) as numeric)');
      DMTiers.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('  where p.id=e.id_piece');
      DMTiers.QuSousTotal3.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and tiers= :tiers )');
      DMTiers.QuSousTotal3.SQL.Add('),(cast(b.credit_report as numeric)+ ');
      DMTiers.QuSousTotal3.SQL.Add('  (select cast(sum(e.Creditsaisie) as numeric) ');
      DMTiers.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('  where p.id=e.id_piece and tiers= :tiers and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMTiers.QuSousTotal3.SQL.Add('  (Select cast(sum(e.creditSaisie) as numeric)');
      DMTiers.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('  where p.id=e.id_piece');
      DMTiers.QuSousTotal3.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and tiers= :tiers )');
      DMTiers.QuSousTotal3.SQL.Add(' )-( ');
      DMTiers.QuSousTotal3.SQL.Add('  cast(b.debit_report as numeric)+ ');
      DMTiers.QuSousTotal3.SQL.Add('  (select cast(sum(e.debitsaisie) as numeric) ');
      DMTiers.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('  where p.id=e.id_piece and tiers= :tiers and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMTiers.QuSousTotal3.SQL.Add('  (Select  cast(sum(e.DebitSaisie) as numeric)');
      DMTiers.QuSousTotal3.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('  where p.id=e.id_piece');
      DMTiers.QuSousTotal3.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and tiers= :tiers )');

      DMTiers.QuSousTotal3.SQL.Add('),0,0 ');

      DMTiers.QuSousTotal3.SQL.Add('from "'+E.RepertoireExercice+'BalanceTiers" b, ecriture e, piece p ');
      DMTiers.QuSousTotal3.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and tiers= :tiers ');
      DMTiers.QuSousTotal3.Params[0].DataType := ftString;
      DMTiers.QuSousTotal3.Open;

      //Total Général
      DMTiers.QuTotalG.SQL.Clear;
      DMTiers.QuTotalG.SQL.Add('select distinct(select cast(sum(b.debit_report) as numeric) ');
      DMTiers.QuTotalG.SQL.Add('  from "'+E.RepertoireExercice+'BalanceTiers" b ');
      DMTiers.QuTotalG.SQL.Add('  where b.tiers between '''+Cpt1+''' and '''+cpt2+''')+  ');
      DMTiers.QuTotalG.SQL.Add('  (select cast(sum(e.debitsaisie) as numeric) ');
      DMTiers.QuTotalG.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuTotalG.SQL.Add('  where p.id=e.id_piece and tiers between '''+Cpt1+''' and '''+cpt2+''' and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMTiers.QuTotalG.SQL.Add('  (Select  cast(sum(e.DebitSaisie) as numeric)');
      DMTiers.QuTotalG.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuTotalG.SQL.Add('  where p.id=e.id_piece');
      DMTiers.QuTotalG.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and tiers between '''+Cpt1+''' and '''+cpt2+''' )');

      DMTiers.QuTotalG.SQL.Add(', (select cast(sum(b.credit_report) as numeric) ');
      DMTiers.QuTotalG.SQL.Add('  from "'+E.RepertoireExercice+'BalanceTiers" b ');
      DMTiers.QuTotalG.SQL.Add('  where b.tiers between '''+Cpt1+''' and '''+cpt2+''')+  ');
      DMTiers.QuTotalG.SQL.Add('  (select cast(sum(e.Creditsaisie) as numeric) ');
      DMTiers.QuTotalG.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuTotalG.SQL.Add('  where p.id=e.id_piece and tiers between '''+Cpt1+''' and '''+cpt2+''' and p."date"<'''+DateInfos(periode.DateDeb).DatePourSQLStr+''')+ ');
      DMTiers.QuTotalG.SQL.Add('  (Select  cast(sum(e.creditSaisie) as numeric)');
      DMTiers.QuTotalG.SQL.Add('  from ecriture e, piece p ');
      DMTiers.QuTotalG.SQL.Add('  where p.id=e.id_piece');
      DMTiers.QuTotalG.SQL.Add('  and p."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and p."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+''' and tiers between '''+Cpt1+''' and '''+cpt2+''' )');
      DMTiers.QuTotalG.SQL.Add(',0,0 ');
      DMTiers.QuTotalG.SQL.Add('from "'+E.RepertoireExercice+'BalanceTiers" b, ecriture e, piece p ');
      DMTiers.QuTotalG.SQL.Add('where e.compte=b.compte and p.id=e.id_piece and tiers between '''+Cpt1+''' and '''+cpt2+''' ');
      DMTiers.QuTotalG.Open;

//      //Total Général
//      DMTiers.QuTotalG.SQL.Clear;
//      DMTiers.QuTotalG.SQL.Add('Select  sum(Ecr.DebitSaisie)+BalanceTiers.Debit_Report as TotDebit, Sum(Ecr.CreditSaisie)+BalanceTiers.Credit_Report as TotCredit,0,0 ');
//      DMTiers.QuTotalG.SQL.Add('from Ecriture Ecr ');
//      DMTiers.QuTotalG.SQL.Add('join "'+E.RepertoireExercice+'BalanceTiers" on(Ecr.Compte=BalanceTiers.Compte) ');
//      DMTiers.QuTotalG.SQL.Add(' where tiers between '''+Cpt1+''' and '''+cpt2+'''');
//      DMTiers.QuTotalG.SQL.Add(' and Ecr."Date" >='''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and Ecr."Date" <='''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
//      DMTiers.QuTotalG.Open;

      DMTiers.QuGrandLivreTiersEdition.SQL.Clear;
      DMTiers.QuGrandLivreTiersEdition.SQL.Add('select * from ecriture,piece where id_piece=piece.id');
      DMTiers.QuGrandLivreTiersEdition.SQL.Add(' and tiers between '''+Cpt1+''' and '''+cpt2+'''');
      DMTiers.QuGrandLivreTiersEdition.SQL.Add(' and ecriture."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMTiers.QuGrandLivreTiersEdition.Open;


      case TypeEdition  of
          C_EditionSimple:Begin
                              Site.lien := false;
//                              EditGrandLivreTiers(Chemin,NomFich,DMTiers.QuGrandLivreTiersEdition,'tiers',DMTiers.QuListeValRupt,DMTiers.QuReport,DMTiers.QuSousTotal1,DMTiers.QuSousTotal2,DMTiers.QuSousTotal3,DMTiers.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),cpt1,cpt2,Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
          C_EditionWeb: Begin
                            Site.lien := false;
                            //EditDetteCreanceTiers(NomMenuSiteWeb,Chemin,NomFich,DMPointage2.QuStocksEdition,'Compte',DMPointage2.QuListeValRupt,DMStock.QuTotalG,DateToStr(now),Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
      end;
      DMTiers.QuListeValRupt.Close;
      DMTiers.QuReport.Close;
      DMTiers.QuSousTotal1.Close;
      DMTiers.QuSousTotal2.Close;
      DMTiers.QuSousTotal3.Close;
      DMTiers.QuTotalG.Close;
      DMTiers.QuGrandLivreTiersEdition.Close;
  end;
End;

Function EditionPlanAux(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var
    NomFich,
    Chemin,
    Cpt1,Cpt2:String;
Begin

 Chemin :=E.RepertoireComptaWeb;
 NomFich:='PlanAux';
// Cpt1:='+0';
// Cpt2:='+Z';

 if DMTiers=nil then DMTiers:=TDMTiers.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
  end;

  DMTiers.QuPlanAuxEdition.SQL.Clear;
  DMTiers.QuPlanAuxEdition.SQL.Add('select * from Tiers');
//  DMTiers.QuPlanAuxEdition.SQL.Add('where tiers between '''+Cpt1+''' and '''+cpt2+'''');
  DMTiers.QuPlanAuxEdition.SQL.Add('order by tiers ');
  DMTiers.QuPlanAuxEdition.Open;

   case TypeEdition  of
      C_EditionSimple:Begin
          Site.lien := false;
//          EditPlanAux(Chemin,NomFich,DMTiers.QuPlanAuxEdition,Site);
          ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
      End;
      C_EditionWeb:Begin
          Site.lien := false;
         // LienEditPlanAux(NomMenuSiteWeb,Chemin,NomFich,DMTiers.QuPlanAuxEdition,Site);
          ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
      end;
  end;
  DMTiers.QuPlanAuxEdition.Close;
End;


Function EditionPlanAuxL(TypeEdition : integer; DataSet:TDataSet;ListeCompte:TStringList):Boolean;
var
ListeValeur:TStringList;
ValeurCompte:String;
ObjPrn:TObjetEdition;
ListeEdition:Tstringlist;
Begin
try
 Screen.Cursor := crSQLWait;
 ListeValeur:=TStringList.Create;
 ListeEdition:=TStringList.Create;
 ObjPrn:=TObjetEdition.Create(application.MainForm);

 if DMTiers=nil then DMTiers:=TDMTiers.Create(Application.MainForm);

 if dataset <> nil then
  begin
   if ListeCompte = nil then
    begin
     ValeurCompte:=dataSet.FindField('Tiers').AsString;
     DMtiers.ListeEdit:=ChampTableVersListe('Tiers',dataSet);
     dataSet.Locate('Tiers',ValeurCompte,[]);
     ReEnableControls(DataSet);
    end
    else
    begin
    if ListeCompte.Count>0 then
      ValeurCompte:=ListeCompte.Strings[0];
    DMTiers.ListeEdit.Assign(ListeCompte);
    //showmessage(ErrInterne+': EditionPlanAuxL : ne pas passer un dataset et une liste !');
    end;
  end
 else
  begin
   if ListeCompte <> nil then
     DMTiers.ListeEdit.Assign(ListeCompte);
  end;

 DMTiers.QuPlanAuxEdition.OnFilterRecord:=DMTiers.QuPlanAuxEditionFilterRecord;
 DMTiers.QuPlanAuxEdition.Filtered:=true;

  DMTiers.QuPlanAuxEdition.SQL.Clear;
  DMTiers.QuPlanAuxEdition.SQL.Add('select * from Tiers');
  DMTiers.QuPlanAuxEdition.SQL.Add('order by tiers ');
  DMTiers.QuPlanAuxEdition.Open;

  ListeEdition.Add(' Tiers ; nom ; compte ; type ; actif ; adresse1 ; adresse2 ; poste ; ville ; pays ; adresse liv. 1 ; adresse liv. 2 ; poste liv. ;'+
  ' ville liv. ; pays liv ; téléphone 1 ; téléphone 2 ; télécopie ; email ');

 if DMTiers.QuPlanAuxEdition.RecordCount <> 0 then
  begin
    DMTiers.QuPlanAuxEdition.First;
    while not DMTiers.QuPlanAuxEdition.Eof do
      begin
        ListeEdition.Add(GereLibelle(DMTiers.QuPlanAuxEdition.FindField('tiers').AsString)+
                         ';'+
                         GereLibelle(DMTiers.QuPlanAuxEdition.FindField('nom').AsString)+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('compte').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('type').AsString+
                         ';'+
                         str_bool2str_FR(DMTiers.QuPlanAuxEdition.FindField('actif').AsBoolean)+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('adresse1').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('adresse2').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('poste').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('ville').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('pays').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('livr_adr1').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('livr_adr2').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('livr_poste').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('livr_ville').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('livr_pays').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('telephone1').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('telephone2').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('telecopie').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('mel').AsString
                         );
                         
        ListeValeur.Add('16'+
                         ';'+
                         GereLibelle(DMTiers.QuPlanAuxEdition.FindField('tiers').AsString)+
                         ';'+
                         GereLibelle(DMTiers.QuPlanAuxEdition.FindField('nom').AsString)+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('compte').AsString+
                         ';'+
                         DMTiers.QuPlanAuxEdition.FindField('type').AsString+
                         ';'+
                         str_bool2str_LGR(DMTiers.QuPlanAuxEdition.FindField('actif').AsBoolean,'x','')
                         );
        DMTiers.QuPlanAuxEdition.Next;
      end;
        DMTiers.QuPlanAuxEdition.Close;

        ObjPrn.FTitreEdition := 'Extrait du plan auxiliaire';

        ListeValeur.Add('7'+
                        ';'+
                        '');
        ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
        ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
        ListeValeur.Insert(0,' tiers ; nom ; compte ; type ; actif ');
        ListeValeur.Insert(1,'2;3;1;0.5;0.5');
        ListeValeur.Insert(2,'texte;texte;texte;texte;texte');
     end;//s'il y a des données à imprimer
       if TypeEdition=C_Exportation then
         ExportDonnees(ListeEdition,E.RepertoireExportDossier,'PlanAux_'+E.NomDossier + E.NomExo + '.Txt')
       else
         ObjPrn.AffichageImp(ListeValeur);
Finally
 Screen.Cursor := crDefault;
 LibereObjet(tobject(ObjPrn));
 Initialise_TStringlist(Listevaleur);
 Initialise_TStringlist(ListeEdition);
 DMTiers.QuPlanAuxEdition.OnFilterRecord:=nil;
end;
End;


procedure TDMTiers.ModuleCadreCreate(Sender: TObject);
begin
if DMBalance=nil then DMBalance:=TDMBalance.Create(application.MainForm); 
if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(application.MainForm);
ListeEdit:=TStringList.Create;
OuvrirTouteTable('',TControl(self));
TaTiersBalCompte.ValidChars:=['0'..'9'];
TaTiersBalDebit_Deb.DisplayFormat:=E.FormatMonnaie;
TaTiersBalDebit_Deb.EditFormat:='0.00 ;-0.00 ';

TaTiersBalCredit_Deb.DisplayFormat:=E.FormatMonnaie;
TaTiersBalCredit_Deb.EditFormat:='0.00 ;-0.00 ';

// Venant de la balance des Tiers
TaTiersBalDebit_Deb_Bal_Tiers.DisplayFormat:=E.FormatMonnaie;
TaTiersBalCredit_Deb_Bal_Tiers.DisplayFormat:=E.FormatMonnaie;
TaTiersBalSolde_Debut_Bal_Tiers.DisplayFormat:=',0.00 '+E.DeviseSigle+' Crédit;,0.00 '+E.DeviseSigle+'  Débit;,0.00 '+E.DeviseSigle+'    Null';

ActiveMessTiersCompteOK := true;
DeFiltrageDataSet(DMRech.TaEcritureRech);

end;

procedure TDMTiers.ModuleCadreDestroy(Sender: TObject);
var
i:integer;
begin
FermerTouteTable('',TControl(self));
 try
   for i:=0 to componentcount-1 do
     if components[i].className = 'TQuery' then
         (components[i]as TQuery).close;
 except
//  DatabaseError :
   begin
     showmessage('Query inconnue dans la fenêtre'+Name);
     Destroy;
   end;
 end;
Initialise_TStringlist(ListeEdit,self);
DMTiers:=nil;
end;

{*******************     Creation de Liste             *************************
           cette procedure sert à créer une stringList...
*******************************************************************************}
function TDMTiers.StrListe(TableCtrl:TTable;nomChamp:string):TStringList;
begin
//  FiltrageTable(TableCtrl,'champ1 = valeur1');// si besoin ...
  result:=TStringList.Create;
  result.Clear;
   While Not(TableCtrl.EOF) Do
   Begin
{******** traitements éventuels ******************}
     result.Add(TableCtrl.findfield(nomChamp).AsString);
     TableCtrl.Next;
   End;
end;


Function TDMTiers.GenerCodeTiers(NomTiers:String):String;
var
   codetmp : string;
   i : integer;
begin
DeFiltrageDataSet(DMRech.TaTiersRech);
result:='';
If not(empty(NomTiers)) Then
   begin
     // Proposer en fonction du nom saisie un code Tiers
     codetmp := UpperCase(concat('+',copy(NomTiers,1,7)));
     if Infos_TInfosTiers(DMRech.TaTiersRech,'Tiers',[codetmp]).ResultInfos then
     begin
          i := 2;
          codetmp := concat('+', copy(NomTiers,1,7-length(inttostr(i))),inttostr(i));
          While Infos_TInfosTiers(DMRech.TaTiersRech,'Tiers',[codetmp]).ResultInfos = true do
          begin
               i := i+ 1;
               codetmp:=UpperCase(concat('+', copy(NomTiers,1,7-length(inttostr(i))),inttostr(i)));
          end;
     End;
     result:=(UpperCase((COPY(codetmp,2,7)))) ;
   end;
end;


Function TDMTiers.CtrlSaisieTiers(CCourant:Tfield):TErreurSaisie;
var
ch:Char;
begin
{initialisation des variables de retour de fonction}
  result.CodeErreur:=0;
  result.Retour:=True;
{si table en état insertion ou modification}
  if TaTiersGest.State in [dsinsert,dsEdit] then
  begin
    case CCourant.Index of
      0:Begin {Champ Tiers}
          case TaTiersGest.State of
             dsinsert:Begin
                        If Empty(CCourant.AsString) then
                         Begin
                           result.CodeErreur:=100;
                           result.Retour:=False;
                           Messagedlg('La Saisie du code est obligatoire',mtwarning,[mbok],0);
                         end
                         else
                         begin
                          if copy(CCourant.AsString,1,1)<>'+' then ccourant.AsString:='+'+ccourant.AsString;
                          if Infos_TInfosTiers(DMRech.TaTiersRech,'Tiers',[ccourant.AsString]).ResultInfos then
//                          if VerififExist(TaTiersRech,'Nom','+'+ccourant.AsString)=true then
                          begin
//                            Application.Messagebox(Pchar('Le Code de Tiers : '+ccourant.AsString+' existe déjà !'),'Erreur de saisie',1);
                            Messagedlg('Le Code de Tiers : '+ccourant.AsString+' existe déjà !',mtwarning,[mbOk],0);
                              result.CodeErreur:=101;
                              result.Retour:=False;
//                              abort;
                          end
                          else {existe pas }
                          begin
//                            if ccourant.AsString<>Str_StringAcceptSQL(ccourant.AsString,DM_C_ListeCaractereCorrect_SQL)then
//                              begin
//                                Messagedlg('Le Code de Tiers : '+ccourant.AsString+' n''est pas correct'+RetourChariotSimple+
//                                'les caractères : '+RetourChariotSimple
//                                +RetourListeCaractereNonCorrectString(DM_C_ListeCaractereCorrect_SQL).text+
//                                ' ne sont pas acceptés',mtwarning,[mbOk],0);
//                                result.CodeErreur:=101;
//                                result.Retour:=False;
//                              end
//                            else
                              begin
                                result.CodeErreur:=0;
                                result.Retour:=True;
                              end;
                          end;
                         end;
                      End;

             dsEdit:Begin

                    End;
          end;
        End;

      1: begin {champ Nom}
{si vide}  If Empty(CCourant.AsString) then
           Begin
             result.CodeErreur:=1100;
             result.Retour:=False;
             Messagedlg('La Saisie du nom est obligatoire',mtwarning,[mbok],0);
           end
{pas vide} else
           begin
           case TaTiersGest.State of
             dsinsert:Begin
                       {existe }
                       if Infos_TInfosTiers(DMRech.TaTiersRech,'Nom',[ccourant.AsString]).ResultInfos then
                       begin
                         if Messagedlg('Le nom de Tiers : '+ccourant.AsString+' existe déjà !'+#10#13+'Voulez-Vous le conserver ?',mtwarning,[mbNo,mbYes],0)=mrYes then
                          begin
//                           if ((TaTiersGestTiers.ReadOnly = false) and (not empty(TaTiersGestTiers.AsString))) then
                           if TaTiersGestTiers.ReadOnly = false then
                            begin
                             If Empty(CCourant.AsString) then
                               Begin
                                 TaTiersGestTiers.AsString:='+'+GenerCodeTiers(CCourant.AsString);
                               end;
                            end;
                           result.CodeErreur:=1104;
                           result.Retour:=True;
                          end
                          else
                          begin {Choix non sur un nom double}
                           result.CodeErreur:=1101;
                           result.Retour:=False;
                          end;
                       end
                       else {existe pas }
                       begin
                         if TaTiersGestTiers.ReadOnly = false then
                          if empty(TaTiersGestTiers.AsString) then
                            TaTiersGestTiers.AsString:='+'+GenerCodeTiers(CCourant.AsString);
                         result.CodeErreur:=1104;
                         result.Retour:=True;
                       end;
                      end;
              dsEdit:Begin
                       FiltrageDataSet(DMRech.TaTiersRech,'Nom='''+ccourant.AsString+''' and Tiers <> '''+TaTiersGest.findField('Tiers').AsString+'''');
                       if DMRech.TaTiersRech.RecordCount>0 then
                          begin
//                            if Messagedlg('Ce nom de Tiers existe déjà !'+#10#13+'Confirmez-vous votre choix ?',mtwarning,[mbNo,mbYes],0)=mrYes then
                            if Messagedlg('Ce nom de Tiers existe déjà !'+#10#13+'Voulez-Vous le conserver ?',mtwarning,[mbNo,mbYes],0)=mrYes then
                             begin
                              if ((TaTiersGestTiers.ReadOnly = false) and (not empty(TaTiersGestTiers.AsString))) then
                                TaTiersGestTiers.AsString:='+'+GenerCodeTiers(CCourant.AsString);
                              result.CodeErreur:=1104;
                              result.Retour:=True;
                             end
                             else
                             begin {Choix non sur un nom double}
                              result.CodeErreur:=1101;
                              result.Retour:=False;
                             end;
                          end;
                       DeFiltrageDataSet(DMRech.TaTiersRech);
                      end;
           end;
           end;
         end; {fin champ n°1}
    2:Begin {Champ Compte}
       if tatiersGest.State=dsedit then MessDerSub:=false;
       DMPlan.FiltrageAideCompte(96,nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//       AideCompte.FiltrageAideCompte(96);
      if empty(CCourant.AsString) then
       begin
//           Application.MessageBox(Pchar('Vous devez saisir un compte !'),'Attention',0);
           result.CodeErreur:=2003;
           result.Retour:=False;
       end
       else
      IF not DMPlan.CptEstCollectif(CCourant.AsString) then
       begin
         if DMPlan.CptDevenirPointable(ccourant.AsString) then
          begin
           Application.MessageBox(Pchar('Le compte : '+ccourant.AsString+' n''est pas collectif !'+#10#13#10#13+' Vous devez aller dans la gestion du plan comptable pour le rendre collectif'),'Attention',0);
           result.CodeErreur:=2002;
           result.Retour:=False;
          end
         else
          begin
             Application.MessageBox(Pchar('Le compte : '+ccourant.AsString+' ne peut pas être collectif !'),'Attention',0);
             result.CodeErreur:=2002;
             result.Retour:=False;
          end;
       end
       else
       if AideCompteDansContexte(CCourant.AsString,CCourant,['Rac1','Rac2','Rac3','Rac4','Rac5'],false,MessDerSub,true,true,false,true,0)=false then
       begin
        result.CodeErreur:=2000;
        result.Retour:=False;
       end
       else
       begin
        if not empty(TaTiersGestType.AsString)
           then ch:=TaTiersGestType.AsString[1]
           else ch:='T';
        case ord(ch) of
          67:begin
              DMPlan.FiltrageAideCompteSurCompte(96,'41',nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//              AideCompte.FiltrageAideCompteSurCompte(96,'41');{C}
             end;
          68:begin
              DMPlan.FiltrageAideCompteSurCompte(96,'46',nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//              AideCompte.FiltrageAideCompteSurCompte(96,'46');{D}
             end;
          69:begin
              DMPlan.FiltrageAideCompteSurCompte(96,'44',nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//              AideCompte.FiltrageAideCompteSurCompte(96,'44');{D}
             end;
          70:begin
              DMPlan.FiltrageAideCompteSurCompte(96,'40',nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//              AideCompte.FiltrageAideCompteSurCompte(96,'40');{F}
             end;
          80:begin
              DMPlan.FiltrageAideCompteSurCompte(96,'42',nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//              AideCompte.FiltrageAideCompteSurCompte(96,'42');{P}
             end;
          65:begin
              DMPlan.FiltrageAideCompteSurCompte(96,'45',nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//              AideCompte.FiltrageAideCompteSurCompte(96,'45');{A}
             end;
          79:begin
              DMPlan.FiltrageAideCompteSurCompte(96,'43',nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//              AideCompte.FiltrageAideCompteSurCompte(96,'43');{O}
             end;
          84:begin
               DMPlan.FiltrageAideCompte(96,nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//               AideCompte.FiltrageAideCompte(96);{T}
              end;
        end;
       if not AideCompteExiste(ccourant.AsString,nil) then
       begin
        if MessTiersCompteOK=true then
         if MessageDlg('ATTENTION !'+#13+#10+'Le type de Tiers : '+TaTiersGestType.AsString+' ne correspond pas avec le compte : '+CCourant.AsString+' .'+#13+#10+'Confirmez-vous votre choix ?',mtWarning,[mbYes,mbNo],0) = mrno then
         begin
           result.CodeErreur:=2000;
           result.Retour:=False;
         end
         else MessTiersCompteOK:=false;
       end
       end;
//       if DMPlan.PossedeEcritureDirect(ccourant.AsString) and not DMPlan.CptTiers(ccourant.AsString) then
       if DMPlan.PossedeEcritureDirect(ccourant.AsString) then
        begin
           Application.MessageBox(Pchar('Vous ne pouvez pas associer de Tiers au compte : '+ccourant.AsString+#10#13#10#13+' car il possède des écritures'),'Attention',0);
           result.CodeErreur:=2001;
           result.Retour:=False;
        end;

      End;

    3:Begin {Champ type}
       CCourant.AsString:=UpperCase(CCourant.AsString);
       case VerifNumCptIntegrite(TaTiersGestCompte.asstring,false,false).Classe of
          0..3,5..9:begin
                      result.CodeErreur:=3101;
                      result.Retour:=False;
                    end;
          4:Begin
             if length(TaTiersGestCompte.asstring)=1 then
                begin
                      result.CodeErreur:=3102;
                      result.Retour:=False;
                end;
             if length(TaTiersGestCompte.asstring)>1 then
                begin
                  if CCourant.AsString='F' then
                     Begin
                         if copy(TaTiersGestCompte.asstring,1,2)='40' then
                         begin
                          result.CodeErreur:=0;
                          result.Retour:=True;
                         end
                         else
                         begin
                         if MessTiersCompteOK then
                            begin
                             MessageDlg('Les comptes de Tiers de type F devraient être associés aux comptes Fournisseurs : 40xxxx',mtwarning,[mbok],0);
                             result.CodeErreur:=3140;
                             result.Retour:=False;
                            end
                            else
                            begin
                             result.CodeErreur:=0;
                             result.Retour:=True;
                            end;
                         end;
                     End;
                  if CCourant.AsString='C' then
                     Begin
                       if copy(TaTiersGestCompte.asstring,1,2)='41' then
                         begin
                          result.CodeErreur:=0;
                          result.Retour:=True;
                         end
                         else
                         begin
                         if MessTiersCompteOK then
                          begin
                            MessageDlg('Les comptes de Tiers de type C devraient être associés aux comptes Clients : 41xxxx',mtwarning,[mbok],0);
                            result.CodeErreur:=3141;
                            result.Retour:=False;
                            end
                            else
                            begin
                             result.CodeErreur:=0;
                             result.Retour:=True;
                            end;
                         end;
                     End;
                  if CCourant.AsString='P' then
                     Begin
                        if copy(TaTiersGestCompte.asstring,1,2)='42' then
                         begin
                          result.CodeErreur:=0;
                          result.Retour:=True;
                         end
                         else
                         begin
                         if MessTiersCompteOK then
                          begin
                            MessageDlg('Les comptes de Tiers de type P devraient être associés aux comptes de Personnel : 42xxxx',mtwarning,[mbok],0);
                            result.CodeErreur:=3142;
                            result.Retour:=False;
                            end
                            else
                            begin
                             result.CodeErreur:=0;
                             result.Retour:=True;
                            end;
                         end;
                     End;
                  if CCourant.AsString='O' then
                    begin
                         if copy(TaTiersGestCompte.asstring,1,2)='43' then
                         begin
                          result.CodeErreur:=0;
                          result.Retour:=True;
                         end
                         else
                         begin
                         if MessTiersCompteOK then
                          begin
                            MessageDlg('Les comptes de Tiers de type O devraient être associés aux comptes Organismes Sociaux : 43xxxx',mtwarning,[mbok],0);
                            result.CodeErreur:=3143;
                            result.Retour:=False;
                            end
                            else
                            begin
                             result.CodeErreur:=0;
                             result.Retour:=True;
                            end;
                         end;
                     End;
                  if CCourant.AsString='A' then
                     Begin
                       if copy(TaTiersGestCompte.asstring,1,2)='45' then
                         begin
                          result.CodeErreur:=0;
                          result.Retour:=True;
                         end
                         else
                         begin
                         if MessTiersCompteOK then
                          begin
                            MessageDlg('Les comptes de Tiers de type A devraient être associés aux comptes Associés : 45xxxx',mtwarning,[mbok],0);
                            result.CodeErreur:=3145;
                            result.Retour:=False;
                            end
                            else
                            begin
                             result.CodeErreur:=0;
                             result.Retour:=True;
                            end;
                         end;
                     End;
                  if CCourant.AsString='D' then
                     Begin
                       if ((copy(TaTiersGestCompte.asstring,1,2)='46') or (copy(TaTiersGestCompte.asstring,1,3)='472')) then
                         begin
                          result.CodeErreur:=0;
                          result.Retour:=True;
                         end
                         else
                         begin
                         if MessTiersCompteOK then
                          begin
                            MessageDlg('Les comptes de Tiers de type D devraient être associés aux comptes Client & Fournisseurs : 46xxxx',mtwarning,[mbok],0);
                            result.CodeErreur:=3146;
                            result.Retour:=False;
                            end
                            else
                            begin
                             result.CodeErreur:=0;
                             result.Retour:=True;
                            end;
                         end;
                     End;
                  if CCourant.AsString='E' then
                     Begin
                       if (copy(TaTiersGestCompte.asstring,1,2)='44') then
                         begin
                          result.CodeErreur:=0;
                          result.Retour:=True;
                         end
                         else
                         begin
                         if MessTiersCompteOK then
                          begin
                            MessageDlg('Les comptes de Tiers de type D devraient être associés aux comptes Client & Fournisseurs : 46xxxx',mtwarning,[mbok],0);
                            result.CodeErreur:=3144;
                            result.Retour:=False;
                            end
                            else
                            begin
                             result.CodeErreur:=0;
                             result.Retour:=True;
                            end;
                         end;
                     End;
                  if CCourant.AsString='T' then
                     Begin
                       if ((copy(TaTiersGestCompte.asstring,1,1)='4')) then
                         begin
                          result.CodeErreur:=0;
                          result.Retour:=True;
                         end
                         else
                         begin
                          MessageDlg('Les comptes de Tiers doivent être associés aux comptes de la classe 4',mtwarning,[mbok],0);
                          result.CodeErreur:=3147;
                          result.Retour:=False;
                         end;
                     End;
                end;
           End;
       end;{ Fin du case de classe}
      End;
    end;{fin du case.ccourant}
  end; {fin etat insertion ou modif}
end;


{*******************    Table1BeforePost            ****************************
       Cette procedure permet de faire une vérification des saisie.
   Commence la transaction: quand plusieurs choses doivent se faire en chaîne,
 si un problème se présente sur une des actions, toutes les actions entreprises
    seront annulées...
*******************************************************************************}

procedure TDMTiers.TaTiersGestBeforePost(DataSet: TDataSet);
var
  i:integer;
  RetourFonction:TErreurSaisie;
begin
  case TaTiersGest.State of
  dsInsert: begin
  {**************************************************************************
           voir si traitements à faire (recherches ou autre...)
           par ex : Table1DateSysteme.AsDateTime := Now;
  **************************************************************************}
            end;
  dsEdit: begin
  {**************************************************************************
           voir si traitements à faire (recherches ou autre...)
           par ex : Table1DateSysteme.AsDateTime := Now;
  **************************************************************************}
          end;
  end;//fin du case

// *******  début de la boucle de vérification des saisies *****************
  for i:=0 to 3 do //vérification des champs (ici, 0 à 3 par ex.)
     begin
       RetourFonction:=CtrlSaisieTiers(DataSet.Fields[i]);
       if  RetourFonction.Retour=false then
           case  RetourFonction.CodeErreur of
               100,101:  // par exemple : vide ou n'existe pas...
                 begin //  re-saisir
                   if ActiveMessTiersCompteOK then // Attention ici, l'utilisation de la variable ActiveMessTiersCompteOK
                                                   // à été détournée pour éviter d'afficher un message provoqué
                                                   // par le changement de Focus dans la form E2_Tiers !!!!
                      DataSet.Fields[i].FocusControl;
                   abort;
                 end;
               1100,1101:  // par exemple : vide ou n'existe pas...
                 begin //  re-saisir
                   DataSet.Fields[i].FocusControl;
                   abort;
                 end;
               2001,2002:Begin  // Le compte du plan Cpt possède des écritures et n'était pas déjà Tiers=true
                   DataSet.Fields[i].FocusControl;
                   abort;
                    End;
               2003:Begin
                     MessageDlg('La saisie du compte est obligatoire!',mtError,[mbOK],0);
                     DataSet.Fields[i].FocusControl;
                     abort;
                    end;

               3101,3102,3140,3141,3142,3143,3144,3145,3146,3147:
                 begin //  re-saisir
                   DataSet.Fields[i].FocusControl;
                   abort;
                 end;
           end; //fin case
     end; //fin boucle
{***************  on commence la transaction  ******************************}

  TableGereStartTransaction(TaTiersGest);
   try
      if TaTiersGest.State=dsinsert then
      begin
{ici, plusieurs traitements à faire sur d'autres tables de la base de données}
//       if DMPlan.CptDevenirPointable(DataSet.FindField('Compte').AsString) then
//         MiseAJourPlanPourCptCollectif(DataSet.FindField('Compte').AsString,true)
//       else
//       abort;
      end;
      if TaTiersGest.State=dsedit then
      begin
{ici, plusieurs traitements à faire sur d'autres tables de la base de données}
//       if DMPlan.CptDevenirPointable(DataSet.FindField('Compte').AsString) then
//         MiseAJourPlanPourCptCollectif(DataSet.FindField('Compte').AsString,true)
//       else
//       abort;
      end;
   except
     TableGereRollBack(TaTiersGest);
     showmessage('Problèmes' + ' à l''enregistrement du Tiers' + ' !!!');
     DataSet.Fields[0].FocusControl;
     abort;
   end;//fin du try
end;

procedure TDMTiers.TaTiersGestPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(TaTiersGest);
MessTiersCompteOK:=true and ActiveMessTiersCompteOK;
end;

procedure TDMTiers.TaTiersGestAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
MessTiersCompteOK:=true and ActiveMessTiersCompteOK;
end;


{*******************************************************************************
                        idem pour le Delete...
*******************************************************************************}
procedure TDMTiers.TaTiersGestBeforeDelete(DataSet: TDataSet);
var
CompteTiersPlusDeTiers:Boolean;
begin
case E.TypeEtatExercice of
 ET_Importation:;
 ET_Normal:if MessageDlg('Êtes-Vous sûr de vouloir supprimer le tiers : '+DataSet.FindField('Tiers').AsString,mtConfirmation,[mbYes,mbNo],0) = mrNo then
              abort;

end;//fin du case

//if DetailEcritureTiers(DataSet.FindField('Tiers').AsString,false) then
if DMPlan.PossedeEcriture(DataSet.FindField('Tiers').AsString)then
 begin
   Messagedlg(PChar('Impossible de supprimer le Tiers : '+DataSet.FindField('Tiers').AsString+' - '+DataSet.FindField('Nom').AsString+#13#10#13#10+'Ce Tiers possède des écritures.'),MtWarning,[mbok],0);
   abort;
 end;
 FiltrageDataSet(DMRech.TaTiersRech,'Compte='''+TaTiersGest.findField('Compte').AsString+'''');
 CompteTiersPlusDeTiers:=(DMRech.TaTiersRech.RecordCount <=1);
 DeFiltrageDataSet(DMRech.TaTiersRech);



{***************      traitements éventuels... *****************************}
{***************  on commence la transaction  ******************************}
TableGereStartTransaction(TaTiersGest);
//  case self.Tag of    // par exemple ...
//     1: begin
            try
            if CompteTiersPlusDeTiers then
            MiseAJourPlanPourCptCollectif(DataSet.FindField('Compte').AsString,false);
            except
               begin
{*********  on annule la transaction (=ttes les actions) *******************}
                 TableGereRollBack(TaTiersGest);
                 showmessage('Problèmes à la suppression!!!');
                 abort;
               end;
            end;
//        end;
//     2: begin
//           try
//{***************        traitements à faire     *****************************}
//{ici, plusieurs traitements à faire sur d'autres tables de la base de données}
//           except
//              begin
//{*********  on annule la transaction (=ttes les actions) *******************}
//                TaTiersGest.Database.Rollback;
//                showmessage('Problèmes !!!');
//                abort;
//              end;
//           end;
//        end;
//    end;
end;


procedure TDMTiers.TaTiersGestDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(TaTiersGest);
end;

procedure TDMTiers.TaTiersGestAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
end;

procedure TDMTiers.TaTiersGestBeforeInsert(DataSet: TDataSet);
begin
  case self.tag of
     0,1:Begin
           MessTiersCompteOK:=true and ActiveMessTiersCompteOK;
         End;
     2:abort;
  end;
end;

procedure TDMTiers.TaTiersGestBeforeEdit(DataSet: TDataSet);
begin
case self.tag of
     0,1:Begin
           MessTiersCompteOK:=true and ActiveMessTiersCompteOK;
         End;
     2:abort;
  end;
end;

procedure TDMTiers.TaTiersBalCalcFields(DataSet: TDataSet);
begin
TaTiersBalSolde_Debut_Bal_Tiers.AsCurrency:=TaTiersBalCredit_Deb_Bal_Tiers.AsCurrency-TaTiersBalDebit_Deb_Bal_Tiers.AsCurrency;
end;

procedure TDMTiers.TaTiersGestCalcFields(DataSet: TDataSet); //isa le 17-10-02
//var
//ResteDCInfoLettrageEnCours:TResteDCInfoLettrageEnCours;
//InfoResteDCSurCompte:TInfoResteDCSurCompte;
begin
//  ResteDCInfoLettrageEnCours:=DMPointage2.CalculLettrageEnCours('',TaTiersGestTiers.AsString,'',0,'');
//  InfoResteDCSurCompte:=RecupDetteCreance(TaTiersGestTiers.AsString,'',[''],E.DatExoDebut,E.DatExoFin,0,0,nil);
//  TaTiersGestNbLigneNonPointe.AsInteger:=InfoResteDCSurCompte.NBLigneResteAPointer;
//  TaTiersGestNbLigneTotalementPointe.AsInteger:=InfoResteDCSurCompte.NBLignePointee;
//  TaTiersGestNbLignePartiPointe.AsInteger:=InfoResteDCSurCompte.NBLignePartiellementPointee;
//  TaTiersGestSoldeCompte.AsCurrency:=ResteDCInfoLettrageEnCours.SoldeMvt;
//  TaTiersGestSoldeReste.AsCurrency:=ResteDCInfoLettrageEnCours.SoldeReste;

//
end;

procedure TDMTiers.TaTiersGestFilterRecordAideCompte(DataSet: TDataSet;
  var Accept: Boolean);
begin
if  ((dataset<>nil)and(not((csDestroying)in dataset.ComponentState))) then
  begin
  if DataSet.Name <> 'quLibelle' then
   begin
     try
       accept:=DataSet.FindField('Collectif').AsBoolean;
     except
       accept:=true;
     end;
   end;
  end;
end;

Procedure TDMTiers.ImportTiers(Valeurs:array of const;DataSet:TDataSet);
Begin
  try
   ActiveMessTiersCompteOK := False;
   ImportTable(Valeurs,DataSet);
   ActiveMessTiersCompteOK := true;
  except
   ActiveMessTiersCompteOK := true;
   abort;
  end;
End;

procedure TDMTiers.QuGrandLivreTiersEditionCalcFields(DataSet: TDataSet);
begin
 QuGrandLivreTiersEditionReferencePiece.AsString:=QuGrandLivreTiersEditionReference.AsString+' '+QuGrandLivreTiersEditionLibelle_1.AsString;
 if ListeIdEcr.IndexOf(QuGrandLivreTiersEditionID.AsString)=-1 then begin
    //ecriture non deja traitée
    if TiersCalcSoldes<>QuGrandLivreTiersEditionTiers.AsString then begin
        SoldeDeb:=0;
        SoldeCre:=0;
    end;
    QuGrandLivreTiersEditionSoldeDeb.AsCurrency:=SoldeDeb+QuGrandLivreTiersEditionDebitSaisie.AsCurrency-SoldeCre;
    QuGrandLivreTiersEditionSoldeCre.AsCurrency:=SoldeCre+QuGrandLivreTiersEditionCreditSaisie.AsCurrency-SoldeDeb;
    if QuGrandLivreTiersEditionSoldeDeb.AsCurrency<0 then begin
    //ne rien afficher du cote négatif
        SoldeDeb:=0;
        QuGrandLivreTiersEditionSoldeDeb.AsCurrency:=0;
    end
    else
        SoldeDeb:=QuGrandLivreTiersEditionSoldeDeb.AsCurrency;

    if QuGrandLivreTiersEditionSoldeCre.AsCurrency<0 then begin
    //ne rien afficher du cote négatif
        SoldeCre:=0;
        QuGrandLivreTiersEditionSoldeCre.AsCurrency:=0;
    end
    else
        SoldeCre:=QuGrandLivreTiersEditionSoldeCre.AsCurrency;

    if SoldeDeb>SoldeCre then
        QuGrandLivreTiersEditionSoldeCre.AsCurrency:=0
    else
        QuGrandLivreTiersEditionSoldeDeb.AsCurrency:=0;

    TiersCalcSoldes:=QuGrandLivreTiersEdition.findfield('tiers').AsString;
    ListeIdEcr.Add(QuGrandLivreTiersEditionID.AsString);
    ListeSoldeDeb.Add(CurrToStr(SoldeDeb));
    ListeSoldeCre.Add(CurrToStr(SoldeCre));
  end
  else begin
    //ecriture déja traitée ;on reprend son solde
    QuGrandLivreTiersEditionSoldeDeb.AsCurrency:=StrToCurr_lgr(ListeSoldeDeb[ListeIdEcr.IndexOf(QuGrandLivreTiersEditionID.AsString)]);
    QuGrandLivreTiersEditionSoldeCre.AsCurrency:=StrToCurr_lgr(ListeSoldeCre[ListeIdEcr.IndexOf(QuGrandLivreTiersEditionID.AsString)]);
  end;
end;

procedure TDMTiers.QuGrandLivreTiersEditionBeforeOpen(DataSet: TDataSet);
begin
ListeIdEcr:=TStringList.Create;
ListeSoldeDeb:=TStringList.Create;
ListeSoldeCre:=TStringList.Create;
end;

procedure TDMTiers.QuTiers_Compte_PointableFilterRecordTous(DataSet: TDataSet;
  var Accept: Boolean);
begin
// tous les comptes pointables
accept:=true;
end;

procedure TDMTiers.QuTiers_Compte_PointableFilterRecordResteAPointerNonNullTous(DataSet: TDataSet;
  var Accept: Boolean);
begin
// Tous ceux qui ont un Reste A Pointer non nul, mais qui n'ont pas forcemment des lignes
// pointables sur le moment
accept:=((QuTiers_Compte_PointableTotReste.AsCurrency > 0));
       // and
       // (QuTiers_Compte_PointableSolde.AsCurrency = QuTiers_Compte_PointableTotReste.AsCurrency));
end;

// Tous ceux qui ont un Reste A Pointer non nul et qui ont des lignes
// pointables sur le moment
procedure TDMTiers.QuTiers_Compte_PointableFilterRecordResteAPointerNonNullPointable(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=((QuTiers_Compte_PointableTotReste.AsCurrency > 0) and
        (Abs(QuTiers_Compte_PointableSolde.AsCurrency) <> QuTiers_Compte_PointableTotReste.AsCurrency));
end;

procedure TDMTiers.QuTiers_Compte_PointableFilterRecordNullTous(DataSet: TDataSet;
  var Accept: Boolean);
begin
// Tous ceux qui ont un Reste A Pointer nul
accept:=((QuTiers_Compte_PointableTotReste.AsCurrency = 0));
end;


Function TDMTiers.AffecteFilterRecord(NumFilterRecord : integer):Integer;
Begin
result:=0;
case NumFilterRecord of
   C_TiersFilterRecordTous:
             QuTiers_Compte_Pointable.OnFilterRecord := QuTiers_Compte_PointableFilterRecordTous;

   C_TiersFilterRecordResteAPointerNonNullTous:
             QuTiers_Compte_Pointable.OnFilterRecord := QuTiers_Compte_PointableFilterRecordResteAPointerNonNullTous;

   C_TiersFilterRecordResteAPointerNonNullPointable:
             QuTiers_Compte_Pointable.OnFilterRecord := QuTiers_Compte_PointableFilterRecordResteAPointerNonNullPointable;

   C_TiersFilterRecordNullTous:
             QuTiers_Compte_Pointable.OnFilterRecord := QuTiers_Compte_PointableFilterRecordNullTous;
else
 MessageDlg('Le numéro du FilterRecord '+IntTostr(NumFilterRecord)+' est invalide !', mtError, [mbOK], 0); ;
end;

End;

procedure TDMTiers.QuTiers_Compte_PointableBeforeOpen(DataSet: TDataSet);
begin
QuTiers_Compte_Pointable.ParamByName('DateFin').AsDate:=e.DatExoFin;
end;


function TDMTiers.LibelleDuTiers(TiersSaisie:string):string;
begin
  result:='';
  DeFiltrageDataSet(DMRech.TaTiersRech);
  result:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[TiersSaisie]).Nom;
end;

function TDMTiers.CptDuTiers(TiersSaisie:string):string;
begin
  result:='';
  DeFiltrageDataSet(DMRech.TaTiersRech);
  result:=Infos_TInfosTiers(dmrech.TaTiersRech,'Tiers',[TiersSaisie]).Compte;
end;
procedure TDMTiers.QuPlanAuxEditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ListeEdit.IndexOf(DAtaSet.findField('Tiers').AsString) <> -1;
end;

end.
