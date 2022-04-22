unit DMImportation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DMJournaux,
  DMPlanCpt,DMTier,ModuleTrame,DMTVA, Db, DBTables, Piece, Ecriture_Isa,E2_Librairie_Obj,
  E2_Decl_Records,DMBalances,Gr_Librairie_Obj,ObjReglement,LibSql,E2_aidecompte,
  stdctrls,E2_LibInfosTable,DMRecherche,referencement,LibFichRep,LibImport,DMInitTablesEpi
  ,Lib_chaine,LibDates,DMEcriture,
  LibZoneSaisie,
  ComCtrls,
  DMConstantes,
  Variants,
  AffectImmoCptCOGERE,
  CreationPlanAgriCOGERE,
  CreationConstAnalCOGERE,
  E2_VisuListeView,
  E2_Patientez,DiversProjets,
  LibRessourceString;

const
C_IMPORT_EPIDOS = 1;
C_IMPORT_BLOQUEL = 2;
C_IMPORT_SARA = 3;
C_IMPORT_E2_FAC = 4;
C_IMPORT_CAISSE = 5;
C_IMPORT_CAISSE_2 = 6;
C_IMPORT_CAISSEBis = 7;



type
   TProcImport= Procedure (NomFichier:String;Var ListeEcritures,ListeOrigine:TList) of object;
    TMtBilanOuvertureImport = Class(TObject)
     Libelle:String;
     MtDebit:Currency;
     MtCredit:Currency;
    public
     { Déclarations publiques }
     constructor Create(AOwner :TComponent);
     destructor Destroy;
    end;





  TDMImport = class(TDataModule)
    Ecriture_Import: TEcriture_Isa;
    TaEcriture_Import: TTable;
    TaPiece_Import: TTable;
    Piece_Import: TPiece;
    TaResultImport: TTable;
    DaResultImport: TDataSource;
    TaResultImportSoldeDebitBalImport: TCurrencyField;
    TaResultImportSoldeCreditBalImport: TCurrencyField;
    TaResultImportCompte: TStringField;
    Ta_PieceImportExistante: TTable;
    OpenDialog1: TOpenDialog;
    Ta_PieceImportExistanteReference: TStringField;
    Ta_PieceImportExistanteNouvel_ID_Piece: TIntegerField;
    Ta_PieceImportExistanteID_Piece_Import: TIntegerField;
    Ta_PieceImportExistanteID_Prog: TIntegerField;
    Ta_PieceImportExistanteID: TIntegerField;
    Ta_PieceImportExistanteCompte: TStringField;
    Ta_PieceImportExistanteLibelle: TStringField;
    Ta_PieceImportExistanteDebit: TCurrencyField;
    Ta_PieceImportExistanteCredit: TCurrencyField;
    TaPiece_Deja_Importee: TTable;
    QuResultImport: TQuery;
    TaResultImportSoldeDebitReport: TCurrencyField;
    TaResultImportSoldeCreditReport: TCurrencyField;
    TaResultImportLibelle: TStringField;
    procedure DMImportCreate(Sender: TObject);
    procedure DMImportDestroy(Sender: TObject);
    procedure Piece_ImportNewPiece(Sender: TObject);
    Function EnregistrementPiece(Reglement:boolean;ListeReglement:tstringlist;var OD:TstringList;var ListeReglementSurListe:tlist):TExceptLGR_ImportPiece;
    function RecupPieceEcriture_SurRecords(AutoFiltrage:boolean;SourcePiece:TRecordPiece;SourceEcriture:Tlist;ValPieceAutoGen:TValPieceAutoGenere;NumCheque,CodeGestCo:string;IDGestCo:integer;AcceptPieceNul:boolean=false):TExceptLGR_ImportPiece;
    function PreparationEnregistrementComplet():TExceptLGR_ImportPiece;
    function RecupParamLigne(LCourante:integer;TypeL:Char;Cpt:string;List:boolean):TParamLigne_obj;
    Function Import_Stocks(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_Plan_Entier(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_CodeTva(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_Tiers(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_ChAPayer(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_PrARecevoir(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_ChCAvance(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_PrCAvance(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_Provision(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_ChARepartir(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_Journaux(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_Immo(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function Import_BalanceOuverture(DataSet:TDataSet;Confirmation:Boolean):Boolean;
    Function InitDataSetResultImport(TypeImport:Integer):Boolean;
    procedure TaResultImportCalcFields(DataSet: TDataSet);
    procedure TaResultImportFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    Procedure AffichRapportImport(ListeFichier:TStringList;ViewList:TListView);//TaResultImport
    function AfficheListe_PieceImportExistante(ListePiece:Tstringlist;ID_Programme:integer):Tstringlist;
    Procedure EnregistreNouvellePieceImporte(NouvellePiece:TInfosPiece_Import);
    Procedure AffichRapportImport_Isa(ListeFichier:TStringList;ViewList:TListView;ParamAffich:TParamAffichage);

    Function Import_Immo_SIEA2I(DataSet:TDataSet;Confirmation:Boolean;NomFicBal:String;var CheminImport,NomFicImmos:String):Texceptlgr;
    Function Import_BO_SIEA_DOS(DataSet:TDataSet;Confirmation:Boolean;Var CheminImport,NomFic:String):Boolean;
    Function Import_BO_SIEA_DOS_MAJCPT(DataSet:TDataSet;Confirmation:Boolean;Var CheminImport,NomFic:String):Boolean;
    Function Import_SoldeCptImmos_SIEA_DOS(var Repertoire,NomFichier:string;Dataset:TDataset):Tstringlist;

    Function Import_Trame(DataSet:TDataSet;Confirmation:Boolean;NomFichier:string):Boolean;
    function AffichePiece_AvantEnregistrement(Ecriture: TEcriture_Isa):Tstringlist;
    Function Import_Piece_SurType(DataSet:TDataSet;Confirmation:Boolean;NomFichier:string;TypeImport:integer):TExceptLGR;
    Function RemplissageListeErreurSurImportationPiece(IDPiece:integer;ListeOrigine:Tlist;var ListeErreur:Tstringlist;Erreur:Texceptlgr):Tstringlist;
    procedure Ta_PieceImportExistanteCalcFields(DataSet: TDataSet);
    procedure Ta_PieceImportExistanteFilterRecordPourE2_Fac_et_Sara(DataSet: TDataSet;
      var Accept: Boolean);
    procedure Ta_PieceImportExistanteFilterRecordPourBLOQUEL(DataSet: TDataSet;
      var Accept: Boolean);
    Procedure VerifCreationPieceEcriture;
    procedure QuResultImportCalcFields(DataSet: TDataSet);
    procedure QuResultImportFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    Function RemplissageListeErreurSurImportationPointage(RefDebit,RefCredit:String;ListeOrigine:Tlist;var ListeErreur:Tstringlist;Erreur:Texceptlgr):Tstringlist;
    Procedure Import_Piece_SurTypeMicroPointe(NomFichier:String;Var Liste:TList);
  private
    { Déclarations privées }
    ListeCompteBilanOuverture:TStringList;
  public
    { Déclarations publiques }
    AnneeAnterieure:TPieceAnterieure;
    PieceEcriture_En_Attente:TEcriture_Isa;
    EtatPiece_En_Attente:TDataSetState;
    messageTmp:boolean;
    ListeFiltreCompteBilanOuverture:TStringList;
  end;

    function SuppressionPieceImportee(idPiece:integer):TExceptLGR;
    Function ImportationEcrituresEPI_DOS(FichierImport:TList;Var ListeEcritures:TList;ListeErreur:Tstringlist;TypeImport:integer):TExceptLGR_ImportPiece;
    Function ImportationPieceEPI_DOS(FichierImport:Tlist;Var ListePiece:TList;ListeErreur:Tstringlist;TypeImport:integer):TExceptLGR_ImportPiece;
    Function ChoisirRepImportation(var RepertoireImportDefaut:String;NomImport:String):Boolean;
    Function SupprimeFichierApresImportation(NomFichier,Repertoire:String):TExceptLGR;
    Function SupprimeFichierApresImportationMicroPointe(NomFichier,Repertoire:String):TExceptLGR;
    procedure CreationTiers(SourceEcriture:PRecordEcriture;Reference:String);overload;
    function CreationTiers(SourcePiece:TRecordPiece):TRecordPiece;overload;

var
  DMImport: TDMImport;
  DebCredEcriture,compteEcriture,TiersEcriture,QteEcriture:string;
  montantEcriture:currency;
  ListePointages:TStringList;
  EcriturePiece:TRecordEcriture;
  messageTmp:boolean;
  ListeReglementSurListe:Tlist;
  ListePieceImportExistanteFilterRecord:Tstringlist;

implementation

uses  DMPointages2, DMStocks, DMBaseDonnee, E2_InitTableEpi,
  DMChargesAPayer, DMChargesCA, DMProvision, DMChargesRepartir, DMPiece,
  DMTTVA, DMImmosOuverture,
    DMParamEnt,
DMDiocEtatBalance, Gr_MultDos;


{$R *.DFM}

Constructor TMtBilanOuvertureImport.Create(AOwner : TComponent);
Begin
inherited create;
MtDebit := 0;
MtCredit := 0;
Libelle := '';
End;

Destructor TMtBilanOuvertureImport.Destroy;
Begin
inherited destroy;
End;


function TDMImport.RecupPieceEcriture_SurRecords(AutoFiltrage:boolean;SourcePiece:TRecordPiece;SourceEcriture:Tlist;ValPieceAutoGen:TValPieceAutoGenere;NumCheque,CodeGestCo:string;IDGestCo:integer;AcceptPieceNul:boolean):TExceptLGR_ImportPiece;
var
editTemp:Tedit;
MessDerSub:boolean;
FindID,i:integer;
TotalPiece:currency;
TypeTiers:string;

Begin
try//except
try//finally
if DMPieces=nil then DMPieces:=TDMPieces.create(application.Mainform);
if DMEcritures=nil then DMEcritures:=TDMEcritures.create(application.Mainform);

 GestMessageLGR.ModeTrace:=true;
 Initialise_ExceptLGR(result.erreur,GestMessageLGR);

 result.erreur.NomModule:='RecupPieceEcriture_SurRecords';
 result.Erreur.GestMessageLGR.Enregistrement:=true;
 result.Erreur.NomDossier:=e.NomDossier;

result.erreur.retour:=true;
result.erreur.NumErreur:=0;
editTemp:=Tedit.Create(self);
 edittemp.parent:=Application.MainForm;

//Piece_Import.NouvellePiece(false);

Piece_Import.AcceptPieceNul:=AcceptPieceNul;
EtatPiece_En_Attente:=DMPieces.Piece1.EtatPiece;
PieceEcriture_En_Attente:=DMEcritures.Ecriture_Isa1;
PieceEcriture_En_Attente.Piece:=DMPieces.Piece1;

CopieContenuEcriture_Isa(Ecriture_Import,DMEcritures.Ecriture_Isa1);
CopieContenuPiece(Piece_Import,DMPieces.Piece1);

if aidecompte=nil then
  aidecompte:=Taidecompte.Create(self);
//à partir des 2 records, on récupère toutes les infos nécessaires pour créer une nouvelle
//pièces avec ces écritures

if ((empty(SourcePiece.Journal))and(sourcepiece.IDJournal=0))then
  raise ExceptLGR.Create('Le journal et le numero du journal sont vides, vous ne pouvez pas créer la pièce '+SourcePiece.reference+'.',1000,true,mtError,result.erreur);
defiltragedataset(dmrech.TaModelRech);
//si le journal n'est pas renseigné
if empty(SourcePiece.Journal)then
  //on récupère le journal par rapport à l'ID_Journal s'il est renseigné
if (SourcePiece.IDJournal = 4)and(not empty(SourcePiece.compte)) then
  SourcePiece.Journal:=Infos_TInfosModel(dmrech.TaModelRech,'compte',[SourcePiece.compte]).Journal
else
  SourcePiece.Journal:=Infos_TInfosModel(dmrech.TaModelRech,'ID_Journal',[SourcePiece.IDJournal]).Journal;
defiltragedataset(dmrech.TaModelRech);
//si le journal n'est pas renseigné
if sourcepiece.IDJournal=0 then
  //on récupère le journal par défaut sur paramètre du compte
  sourcepiece.IDJournal:=Infos_TInfosModel(dmrech.TaModelRech,'Journal',[SourcePiece.Journal]).ID_Journal;
if ((sourcepiece.IDJournal=0)or(Infos_TInfosModel(dmrech.TaModelRech,'Journal',[SourcePiece.Journal]).ID_Journal<>sourcepiece.IDJournal)) then
  Begin
   try

    if sourcepiece.IDJournal=4 then
    begin
      if(str_commence_par(sourcePiece.Journal,'B'))then
        DMJournal.ImportJournaux([0,SourcePiece.Journal,'Journal '+SourcePiece.Journal,'Journal '+SourcePiece.Journal,SourcePiece.Journal,nil,SourcePiece.Compte,nil,nil,nil,'LGR_IMPORT',now,nil],DMJournal.TaJournal)
      else
         SourcePiece.Journal:=Infos_TInfosModel(dmrech.TaModelRech,'compte',[SourcePiece.compte]).Journal;
    end
    else
    if sourcepiece.IDJournal=3 then
      begin
          if(str_commence_par(sourcePiece.Journal,'O'))then
            DMJournal.ImportJournaux([0,SourcePiece.Journal,'Journal '+SourcePiece.Journal,'Journal '+SourcePiece.Journal,SourcePiece.Journal,nil,SourcePiece.Compte,nil,nil,nil,'LGR_IMPORT',now,nil],DMJournal.TaJournal)
          else
             begin
             FiltrageDataSet(DMREch.TaModelRech,'id = 3');
             if(DMREch.TaModelRech.RecordCount>0)then
               SourcePiece.Journal:=DMREch.TaModelRech.findfield('Journal').asstring;
             end;
      end
    else
      DMJournal.ImportJournaux([0,SourcePiece.Journal,'Journal '+SourcePiece.Journal,'Journal '+SourcePiece.Journal,SourcePiece.Journal,nil,nil,nil,nil,nil,'LGR_IMPORT',now,nil],DMJournal.TaJournal);
    sourcepiece.IDJournal:=Infos_TInfosModel(dmrech.TaModelRech,'Journal',[SourcePiece.Journal]).ID_Journal;
   except
       raise ExceptLGR.Create('Le journal :'+SourcePiece.Journal+' n''a pas pu être créé.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1004,true,mtError,result.erreur);
   end;
  End;


if AnneeAnterieure.PieceAnterieure then
 begin
   if ((not empty(SourcePiece.Reference))and(copy(SourcePiece.Reference,3,2)=AnneeAnterieure.ExoAnterieure)and(not Piece_Import.RechercheReference(Piece_Import.TablePiece,sourcePiece.Reference,'Reference','ID', FindID)))then
     SourcePiece.Reference:=sourcePiece.Reference
   else
     SourcePiece.Reference:=Piece_Import.NewReference(TaPiece_Import,'Reference',SourcePiece.Journal,AnneeAnterieure.ExoAnterieure,SourcePiece.Reference)
 end
else
 begin
 try
   if not ((not empty(SourcePiece.Reference))and(copy(SourcePiece.Reference,3,2)=Piece_Import.CodeExo)and(not Piece_Import.RechercheReference(Piece_Import.TablePiece,sourcePiece.Reference,'Reference','ID', FindID)))then
      begin
        if not empty(Copy(sourcePiece.Reference,1,2)) then
          sourcePiece.Reference:=Copy(sourcePiece.Reference,1,2)+Piece_Import.CodeExo+Copy(sourcePiece.Reference,5,length(sourcePiece.Reference)-2);
        if ((Piece_Import.RechercheReference(Piece_Import.TablePiece,sourcePiece.Reference,'Reference','ID', FindID))or (empty(sourcePiece.Reference))) then
          sourcePiece.Reference:=Piece_Import.NewReference(TaPiece_Import,'Reference',sourcePiece.Journal,Piece_Import.CodeExo,sourcePiece.Reference);
      end;
 except
    raise ExceptLGR.Create('La référence n''a pas pu être créée ',1005,true,mtError,result.erreur);
 end;
 end;
if sourcePiece.IDJournal=3 then
  sourcePiece.Compte:='';

   // * rajouter vérif sur dateSaisie et datelivraison si pas dans période vérouillée
   //surtout s'il y des lignes de tva

//variable à remplir
Piece_Import.Journal:=SourcePiece.Journal;
Piece_Import.IDJournal:=sourcepiece.IDJournal;
Piece_Import.ValPieceAutoGen:=ValPieceAutoGen;
Piece_Import.NumCheque:=NumCheque;
Piece_Import.CodeGestCo:=CodeGestCo;
Piece_Import.IDGestCo:=IDGestCo;
Piece_Import.AnneePiece:=AnneeAnterieure;

CopieContenuEcriture_Isa(Ecriture_Import,DMEcritures.Ecriture_Isa1);
CopieContenuPiece(Piece_Import,DMPieces.Piece1);

//vérifier que le compte existe, sinon le créer
if ((AutoFiltrage)and(((not sourcePiece.Trame)or(not empty(sourcePiece.compte))) )and(sourcePiece.IDJournal<>3)) then
  begin
      edittemp.Text:=sourcePiece.Compte;
      if not empty(sourcePiece.Tiers) then
        edittemp.Text:=trim(sourcePiece.Tiers);
      //creation tiers
      CreationTiers(SourcePiece);
      //fin creation tiers
      DMPieces.GestionFiltrageParamCpt(SourcePiece.IDJournal);
      MessDerSub:=false;
      if not empty(SourcePiece.Tiers) then
          begin
              if not AideCompteDansContexte(edittemp.Text,editTemp,['Rac1'],false,MessDerSub,true,false,true,false,1)then
                raise ExceptLGR.Create('Le compte '+edittemp.Text+' n''est pas cohérent dans ce contexte.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1001,false,mtError,result.erreur);
              SourcePiece.Tiers:=edittemp.Text;
          end
      else
          begin
              if ((not AideCompteDansContexte(edittemp.Text,editTemp,['Rac1'],false,MessDerSub,true,true,true,true,0))or(Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[edittemp.Text]).Collectif))then
                raise ExceptLGR.Create('Le compte '+edittemp.Text+' n''est pas cohérent dans ce contexte.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1001,false,mtError,result.erreur);
              if ((copy(edittemp.Text,1,1)='4') and(piece_Import.idjournal in [1,2])and (not DMPlan.CptEstPointable(edittemp.Text)))then
                raise ExceptLGR.Create('Le compte '+edittemp.Text+' n''est pas pointable.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1002,True,mtError,result.erreur);
              sourcePiece.Compte:=edittemp.Text;
          end;
  end;//fin si autofiltrage ou pas une trame ou pas une OD
if ((copy(sourcePiece.Compte,1,1)='+')or(not empty(sourcePiece.Tiers)))then
begin
if not empty(sourcePiece.Tiers) then
  begin
    Piece_Import.ComptePlan:=Infos_TInfosTiers(dmrech.TatiersRech,'Tiers',[sourcePiece.Tiers]).Compte;
    Piece_Import.Compte:=sourcePiece.Tiers;
    Piece_Import.Tiers:=sourcePiece.Tiers;
  end
else
  begin
    Piece_Import.ComptePlan:=Infos_TInfosTiers(dmrech.TatiersRech,'Tiers',[sourcePiece.Compte]).Compte;
    Piece_Import.Compte:=sourcePiece.Compte;
    Piece_Import.Tiers:=sourcePiece.Compte;
  end;
end
else
  Begin
      Piece_Import.ComptePlan:=sourcePiece.Compte;
      Piece_Import.Compte:=sourcePiece.Compte;
      Piece_Import.Tiers:=sourcePiece.Tiers;
  End;
if empty(SourcePiece.Libelle)then
 SourcePiece.Libelle:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'compte',[Piece_Import.ComptePlan]).Libelle;

Piece_Import.reference:=SourcePiece.reference;

Piece_Import.EtatPiece:=dsinsert;
if Piece_Import.VerifDateSaisie(SourcePiece.Date) then
  Piece_Import.DateSaisie:=SourcePiece.Date
else
  raise ExceptLGR.Create('La date de la pièce n''est pas cohérente dans ce contexte.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1003,true,mtError,result.erreur);
if sourcePiece.Validation=0 then
  sourcePiece.Validation:=SourcePiece.Date;
Piece_Import.DateLivraison:=sourcePiece.Validation;
Piece_Import.DateEcheance:=strtodate_lgr(sourcePiece.Echeance,SourcePiece.Date);
Piece_Import.FirstIDPiece:=0;
Piece_Import.Libelle:=SourcePiece.Libelle;
Piece_Import.PieceModifiable:=true;

CopieContenuEcriture_Isa(Ecriture_Import,DMEcritures.Ecriture_Isa1);
CopieContenuPiece(Piece_Import,DMPieces.Piece1);

//vérifier la validité des comptes et libellés des lignes avant de les enregistrer dans la liste/
if AutoFiltrage then
  begin
  for i:=0 to sourceEcriture.Count-1 do
    Begin//si
      DMPieces.GestionFiltrageParamCptSurCompte(Piece_Import.Compte,Piece_Import.IDJournal);
      MessDerSub:=false;
      if not empty(PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers)then
        Begin
      //creation tiers
      CreationTiers(PRecordEcriture(SourceEcriture.Items[i]),SourcePiece.Reference);
      //fin creation tiers
          if (FTvaCompteDeTva(PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers)and(Piece_Import.IDJournal in [1,2]))then
            DMPieces.ListeCptExclusCorps.Add(PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers);
          edittemp.Text:=PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers;
          if not AideCompteDansContexte(edittemp.Text,editTemp,['Rac1'],false,MessDerSub,true,true,true,true,1)then
            raise ExceptLGR.Create('Le compte '+edittemp.Text+' n''est pas cohérent dans ce contexte.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1001,true,mtError,result.erreur);
          if DMPieces.CptExclusDeContexte(PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers,2)then
            raise ExceptLGR.Create('Le compte '+PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers+' n''est pas cohérent dans ce contexte.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1001,true,mtError,result.erreur);
            PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers:=edittemp.Text
        End
      else
      if not empty(PRecordEcriture(SourceEcriture.Items[i])^.Compte)then
        Begin
          if (FTvaCompteDeTva(PRecordEcriture(SourceEcriture.Items[i])^.Compte)and(Piece_Import.IDJournal in [1,2]))then
            DMPieces.ListeCptExclusCorps.Add(PRecordEcriture(SourceEcriture.Items[i])^.Compte);
          edittemp.Text:=PRecordEcriture(SourceEcriture.Items[i])^.Compte;
          if ((not AideCompteDansContexte(edittemp.Text,editTemp,['Rac1'],false,MessDerSub,true,true,true,true,0))or(Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[edittemp.Text]).Collectif))then
            raise ExceptLGR.Create('Le compte '+edittemp.Text+' n''est pas cohérent dans ce contexte.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1001,true,mtError,result.erreur);
          if DMPieces.CptExclusDeContexte(PRecordEcriture(SourceEcriture.Items[i])^.Compte,2)then
            raise ExceptLGR.Create('Le compte '+PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers+' n''est pas cohérent dans ce contexte.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1001,true,mtError,result.erreur);
          PRecordEcriture(SourceEcriture.Items[i])^.Compte:=edittemp.Text
        End;
    End;//fin si
  end;
CopieContenuEcriture_Isa(Ecriture_Import,DMEcritures.Ecriture_Isa1);
CopieContenuPiece(Piece_Import,DMPieces.Piece1);

  result:=Ecriture_Import.RecupEcritureSurRecord(sourceEcriture,SourcePiece);
  if not result.Erreur.retour then
    raise ExceptLGR.Create(result.mess,result.Erreur.NumErreur,true,mtError,result.erreur);

      //sur liste des écritures
      // * vérifier si chaque compte existe
      // * vérifier si dateTva n'est pas dans période vérrouillée
finally
   edittemp.free;
//CopieContenuEcriture_Isa(DMEcritures.Ecriture_Isa1,Ecriture_Import);
//CopieContenuPiece(DMPieces.Piece1,Piece_Import);

//   Piece_Import:=DMPieces.Piece1;
//   Ecriture_Import:=DMEcritures.Ecriture_Isa1;
end;//fin du try finally
except

   DMEcritures.Ecriture_Isa1:=PieceEcriture_En_Attente;
   DMPieces.Piece1:=PieceEcriture_En_Attente.Piece;
   messageTmp:=false;
   abort;
end;//fin du try except
End;


procedure TDMImport.DMImportCreate(Sender: TObject);
begin
ListePieceImportExistanteFilterRecord:=TSTringList.create;

ListeFiltreCompteBilanOuverture:=TSTringList.create;
ListeCompteBilanOuverture:=TSTringList.create;
OuvrirTouteTable('',TControl(self));

//remplir Piece_Import.AnneePiece.PieceAnterieure
AnneeAnterieure.PieceAnterieure:=false;
AnneeAnterieure.ExoAnterieure:=e.ExerciceSaisie;
Piece_ImportNewPiece(Piece_Import);
//Piece_Import.AnneePiece:=AnneeAnterieure;

end;

procedure TDMImport.DMImportDestroy(Sender: TObject);
begin
ListeFiltreCompteBilanOuverture.free;
ListeCompteBilanOuverture.free;
//FreeAndNil(ListePieceImportExistanteFilterRecord);
LibereObjet(Tobject(ListePieceImportExistanteFilterRecord));
FermerTouteTable('',TControl(self));
DMImport.Piece_Import.free;
DMImport := nil;
end;



procedure TDMImport.Piece_ImportNewPiece(Sender: TObject);
var
i:integer;
begin
{Nettoyage :libère les éléments de la liste }
Initialise_TList(Ecriture_Import.ListIdentifiant,DMImport,false);
Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMImport,false);
Initialise_TList(DMImport.Ecriture_Import.ListeContrepartie,DMImport,false);
//for i:=0 to Ecriture_Import.ListIdentifiant.count-1 do
// begin
//   dispose(Ecriture_Import.ListIdentifiant.Items[i]);
// end;

Piece_Import.IDContrepartie:=-1;
Piece_Import.Reglement:=false;
Piece_Import.ComptePlan:='';
Piece_Import.tiers:='';
Piece_Import.Modifier_Confirmer:=false;
Piece_Import.Modifier_EnAttente:=false;
Piece_Import.EtatPiece:=dsBrowse;
Piece_Import.FirstIDPiece:=0;
Piece_Import.PieceModifiable:=true;
if Piece_Import.trame<>nil then
Piece_Import.trame.IDTrame:=0;
//si on souhaite une gestion par défaut
Piece_Import.Defaut:=true;
case e.TypeDossier of
  VerAgricole:begin
               //si la tva doit être gérée
               Piece_Import.TVA_A_Gerer:=true;
              end;
  VerDiocese:begin
               //si la tva doit être gérée
               Piece_Import.TVA_A_Gerer:=false;
              end;
end;//fin du case typeversion
//DateConfirmee:=false;
Initialise_TList(Ecriture_Import.ListIdentifiant,DMImport,false);
//Ecriture_Import.ListIdentifiant.Clear;
Ecriture_Import.FirstIDEcriture:=0;
Ecriture_Import.NextIDEcriture:=0;
Ecriture_Import.DispatcherTva:=false;
messageTmp:=true;
Piece_Import.AnneePiece:=AnneeAnterieure;



Piece_Import.FiltrageTablePieceSurPieceAnterieure(Piece_Import.AnneePiece.PieceAnterieure);
if Piece_Import.AnneePiece.PieceAnterieure then
 begin
   Piece_Import.DateDebutExo:=strtodate_Lgr('01/01/1899');
   Piece_Import.DateFinExo:=E.DatExoDebut-1;
   Piece_Import.CodeExo:=E.ExerciceSaisie;
   end
 else
  begin
   Piece_Import.DateDebutExo:=E.DatExoDebut;
   Piece_Import.DateFinExo:=E.DatExoFin;
   Piece_Import.CodeExo:=E.ExerciceSaisie;
  end;

end;





Function TDMImport.EnregistrementPiece(Reglement:boolean;ListeReglement:tstringlist;var OD:TstringList;var ListeReglementSurListe:tlist):TExceptLGR_ImportPiece;
var
ContrePartie:TParametreCompte_obj;
LignCPartie:TParamLigne_obj;
cptTiers,Cpt:string;
TotalDebit,TotalCredit:currency;
i,ID_Temp:integer;
QueryTmp:TQuery;
ListeTmp:TStringList;
Tab,tabTmp:variant;
PieceReglement:TPiece;
EcritureReglement:TEcriture_Isa;
idtmp,rang,IDPointage:integer;
infosEcriture:TInfosEcriture;
begin
try
Initialise_ExceptLGR(Result.erreur,GestMessageLGR);
//result.Erreur.GestMessageLGR:=GestMessageLGR;
result.Erreur.NomModule:='EnregistrementPiece';

if DMPointage2 = nil then DMPointage2:=TDMPointage2.Create(Application);
ListeTmp:=TStringList.Create;
ID_Temp:=-1;
QueryTmp:=TQuery.create(self);
QueryTmp.DataBaseName:=DMPointage2.TaPointage.DatabaseName;

totaldebit:=0;
totalcredit:=0;

if ListePointages=nil then
ListePointages:=tstringlist.Create;
ListePointages.Clear;
  try
   if Piece_Import.EtatPiece in [dsedit,dsinsert]  then
   Begin //si DMPieces.Piece1.EtatPiece in [dsedit,dsinsert]
       TableGereStartTransaction(TaEcriture_Import);
       Result:=PreparationEnregistrementComplet;
       result:=DMPieces.EnvoiePieceEcriture_SurListe(Ecriture_Import.ListIdentifiant,Ecriture_Import,0,0,false,Piece_Import.EtatPiece,false);
       OD.Add(Piece_Import.Reference);
       if Reglement then
       Begin //s'il y a eu réglement de cette pièce
        if ListeReglement<>nil then
          for i:=1 to ListeReglement.Count-1 do
          Begin// début boucle sur la liste des réglements éventuels
            if not(ListeReglement.Objects[i]as TReglementList).vide then
              begin//si la ligne de réglement n'est pas vide
              PieceReglement:=TPiece.Create(self);
              PieceReglement.NouvellePiece(false);
              EcritureReglement:=TEcriture_Isa.Create(self);
              EcritureReglement.Piece:=PieceReglement;
              // on doit créer la pièce de réglement
                //et ses écritures, puis créer le pointages et le reste de chaque ligne d'écriture créées
                //1)Récupérer tous les paramètres pièce et écriture de chaque réglement, puis
                //créer les lignes d'écriture dans table temporaire
               // pieceReglement:=DMPieces.Piece1;
                (PieceReglement as Tpiece).CodeExo:=Piece_Import.CodeExo;
                (PieceReglement as Tpiece).DateDebutExo:=Piece_Import.DateDebutExo;
                (PieceReglement as Tpiece).DateFinExo:=Piece_Import.DateFinExo;
                (PieceReglement as Tpiece).FirstIDPiece:=(PieceReglement as Tpiece).NewIDPiece(TaPiece_Import,'ID',true);
                (PieceReglement as Tpiece).Reference:=(ListeReglement.Objects[i]as TReglementList).Reference;
                (PieceReglement as Tpiece).Libelle:=(ListeReglement.Objects[i]as TReglementList).Libelle;
                if not empty((ListeReglement.Objects[i]as TReglementList).Date)then
                (PieceReglement as Tpiece).DateSaisie:=strtodate_Lgr((ListeReglement.Objects[i]as TReglementList).Date)
                else
                (PieceReglement as Tpiece).DateSaisie:=Piece_Import.DateSaisie;
                (PieceReglement as Tpiece).DateLivraison:=Piece_Import.DateLivraison;
                (PieceReglement as Tpiece).IDJournal:=(ListeReglement.Objects[i]as TReglementList).IDJournal;
                (PieceReglement as Tpiece).Journal:=(ListeReglement.Objects[i]as TReglementList).Journal;
                (PieceReglement as Tpiece).Sens:=(ListeReglement.Objects[i]as TReglementList).Sens;
                (PieceReglement as Tpiece).Montant:=(ListeReglement.Objects[i]as TReglementList).montant;
                (PieceReglement as Tpiece).Compte:=(ListeReglement.Objects[i]as TReglementList).ContrePartieCompte;
                (PieceReglement as Tpiece).ContrePartieTiers:=(ListeReglement.Objects[i]as TReglementList).ContrePartieTiers;
                (PieceReglement as Tpiece).ComptePlan:=Piece_Import.ComptePlan;
                (PieceReglement as Tpiece).Tiers:=Piece_Import.Tiers;
                (PieceReglement as Tpiece).IDContrepartie:=EcritureReglement.NewIDEcriture(TaEcriture_Import,'ID');
                if (PieceReglement as Tpiece).Sens then
                   begin
                   TotalDebit:=0;
                   TotalCredit:=(PieceReglement as Tpiece).Montant;
                   end
                else
                   Begin
                   TotalDebit:=(PieceReglement as Tpiece).Montant;
                   TotalCredit:=0;
                   End;
                (EcritureReglement as TEcriture_Isa).FirstIDEcriture:=(PieceReglement as Tpiece).IDContrepartie+1;
                (EcritureReglement as TEcriture_Isa).CompteEcriture:=(ListeReglement.Objects[i]as TReglementList).ContrePartieCompte;
                (EcritureReglement as TEcriture_Isa).TiersEcriture:=(ListeReglement.Objects[i]as TReglementList).ContrePartieTiers;
                //2)déclencher la création réelle de la pièce et ses écritures + MAJ Balance
                DMPieces.EnvoiePieceEcriture_SurListe(Ecriture_Import.ListIdentifiant,EcritureReglement,TotalDebit,TotalCredit,true,dsinsert,false);
                OD.Add((PieceReglement as Tpiece).Reference);
                //3)Déclencher la création du pointage et le reste de chaque ligne d'écriture
                if (ListeReglement.Objects[i]as TReglementList).imputation<>0then
                   begin //s'il y a une imputation
                   Tab:=VarArrayCreate([0,4],varVariant);
                   //récupérer tous les paramétres nécessaire pour créer le pointage
                   //et recréer le reste de chaque idEcriture du pointage
                     if (PieceReglement as Tpiece).Sens then
                       begin //si la pièce appelante est au crédit
                       tab[0]:=(PieceReglement as Tpiece).IDContrepartie;
                       tab[1]:=Piece_Import.IDContrepartie;
                       end //fin si la pièce appelante est au crédit
                     else
                       Begin //si la pièce appelante est au débit
                       tab[0]:=Piece_Import.IDContrepartie;
                       tab[1]:=(PieceReglement as Tpiece).IDContrepartie;
                       End;//fin si la pièce appelante est au débit
                   tab[2]:=(PieceReglement as Tpiece).DateSaisie;
                   tab[3]:=(ListeReglement.Objects[i]as TReglementList).Imputation;
    ///***A Revoir *********
                   tab[4]:=(PieceReglement as Tpiece).DateSaisie;///***A Revoir *********
                   if not empty((PieceReglement as Tpiece).Tiers)then
                   IDPointage:=CreationPointageSurIDEcriture(tab,(PieceReglement as Tpiece).Tiers,true).Id_Piece
                   else
                   IDPointage:=CreationPointageSurIDEcriture(tab,(PieceReglement as Tpiece).compte,true).Id_Piece;
                   if IDPointage<>-1 then
                   ListePointages.Add(inttostr(IDPointage));
                   Tab:=Unassigned;
                   end;//fin s'il y a une imputation
               // End;
              PieceReglement.Destroy;
              EcritureReglement.Destroy;
              end;//fin si la ligne de réglement n'est pas vide
          End;// fin boucle sur la liste des réglements éventuels
       end;//fin s'il y a eu réglement de cette pièce
         TableGereCommit(TaEcriture_Import);
         TableGereCommit(DMBalance.TaBalance);

   end;//fin si DMPieces.Piece1.EtatPiece in [dsedit,dsinsert]
   except
   TableGereRollBack(TaEcriture_Import);
   TableGereRollBack(DMBalance.TaBalance);
   abort;
   end;//fin du try
finally
   if  ListeTmp<>nil then
   begin
   ListeTmp.free;
   ListeTmp:=nil;
   end;
   if  QueryTmp<>nil then
   Begin
   QueryTmp.free;
   QueryTmp:=nil;
   End;
   DMEcritures.Ecriture_Isa1:=PieceEcriture_En_Attente;
   DMPieces.Piece1:=PieceEcriture_En_Attente.Piece;
   DMPieces.Piece1.EtatPiece:=EtatPiece_En_Attente;
end;//fin du try finally
End;


Function TDMImport.PreparationEnregistrementComplet():TExceptLGR_ImportPiece;
var
ctrlSaisieLigne:TErreurLigne;
TotalPiece:TInfosPiece_SurTypeLigne;
i:integer;
tab:variant;
begin
Initialise_ExceptLGR(Result.erreur,GestMessageLGR);
//result.Erreur.GestMessageLGR:=GestMessageLGR;
result.Erreur.NomModule:='PreparationEnregistrementComplet';
  try
   TotalPiece:=Ecriture_Import.InfosPiece_SurTypeLigne(['H','T'],Ecriture_Import.ListIdentifiant,'',0,false,false,-1);
   //isa le 30082007
//   if (Piece_Import.AcceptPieceNul=false)and((((TotalPiece.debit=0) and (TotalPiece.Credit=0)))or(TotalPiece.nbligne=0)) then
   if ((Piece_Import.AcceptPieceNul=false)and ((TotalPiece.solde=0) and (TotalPiece.debit=0) and (TotalPiece.Credit=0))or(TotalPiece.nbligne=0)) then
     begin
       messageTmp:=false;
       raise ExceptLGR.Create('La pièce '+Piece_Import.Reference+' a un solde nul, vous ne pouvez pas la créer',1000,true,mtError,result.Erreur);
     end;

   if (((TotalPiece.debit=0) and (TotalPiece.Credit=0))or(TotalPiece.nbligne=0)) then
     begin
       messageTmp:=false;
       if TotalPiece.nbligne=0 then
         raise ExceptLGR.Create('La pièce '+Piece_Import.Reference+' n''a pas de ligne, vous ne pouvez pas la créer',1000,true,mtError,result.Erreur)
       else
         raise ExceptLGR.Create('La pièce '+Piece_Import.Reference+' n''a que des lignes à 0, vous ne pouvez pas la créer',1000,true,mtError,result.Erreur)
     end;

   TotalPiece:=Ecriture_Import.InfosPiece_SurTypeLigne(['H','T','X'],Ecriture_Import.ListIdentifiant,'',0,false,false,-1);
   if TotalPiece.SensSoldeCredit<>C_SensSoldeNul then
     begin
       messageTmp:=false;
       raise ExceptLGR.Create('La pièce '+Piece_Import.Reference+' n''est pas équilibrée, vous ne pouvez pas la créer',1000,true,mtError,result.Erreur);
     end;
     for i:=0 to Ecriture_Import.ListIdentifiant.Count-1 do
     begin

     end;
      ////////vérifier interaction entre lignes
        if Piece_Import.IDjournal in [1,2,3,4] then
            begin //si journal [1,2,4]
            for i:=0 to Ecriture_Import.ListIdentifiant.Count-1 do
                 Begin//Début du for sur count ListIdentifiant
                 ctrlSaisieLigne.CodeErreur:=0;
                 ctrlSaisieLigne.Retour:=true;
                 ctrlSaisieLigne:=Ecriture_Import.InteractionLigne_SurListe(Ecriture_Import.ListIdentifiant,i,Piece_Import.IDJournal);
                 if ctrlSaisieLigne.Retour=false then
                    case ctrlSaisieLigne.CodeErreur of
                    12000:begin
                            if not DMTmTVA.Suppression_Derniere_Declaration_Tva_Deverrouillable('',false,false,false).retour then
                              abort;
                          end;
                    12001:Begin
                             raise ExceptLGR.Create(ctrlSaisieLigne.MessageErreur.MessageErreur,ctrlSaisieLigne.CodeErreur,true,mtError,result.Erreur);
                          End;
                     3001,
                    12008,120010:Begin
                    //isa le 30082007
                             if not Piece_Import.AcceptPieceNul then raise ExceptLGR.Create(ctrlSaisieLigne.MessageErreur.MessageErreur,ctrlSaisieLigne.CodeErreur,true,mtError,result.Erreur);
//                             raise ExceptLGR.Create(ctrlSaisieLigne.MessageErreur.MessageErreur,ctrlSaisieLigne.CodeErreur,true,mtError,result.Erreur);
                          End;
                     3002,
                    12009:Begin
                             raise ExceptLGR.Create(ctrlSaisieLigne.MessageErreur.MessageErreur,ctrlSaisieLigne.CodeErreur,true,mtError,result.Erreur);
                          End;
                    120062,
                    120072:Begin
                           if ((e.TypeEtatExercice=ET_Importation) or (((ParamUtil.maintenance)and (ParamUtil.TypeMaintenance='MaintS'))))then
                               begin
                                 if Application.MessageBox(PChar(ctrlSaisieLigne.MessageErreur.MessageQuestion),'Erreur de TVA',MB_YESNO + MB_DEFBUTTON2) = IDno then
                                   Begin
                                    abort;
                                   End
                               end
                           else
                             raise ExceptLGR.Create(ctrlSaisieLigne.MessageErreur.MessageErreur,ctrlSaisieLigne.CodeErreur,true,mtError,result.Erreur);
                          End;
                    120061,
                    120071,
                    120060,
                    120070:Begin
                           if Application.MessageBox(PChar(ctrlSaisieLigne.MessageErreur.MessageErreur),'Erreur de TVA',MB_YESNO + MB_DEFBUTTON2) = IDno then
                             Begin
                              abort;
                             End;
                          End;
                    end;//fin du case ctrlSaisieLigne

                 End;//fin du for sur count ListIdentifiant
            end;//fin si journal [1,2,4]
  except
    DMImport.AffichePiece_AvantEnregistrement(Ecriture_Import);
    abort;
  end;//fin du try except
end;

function TDMImport.RecupParamLigne(LCourante:integer;TypeL:Char;Cpt:string;List:boolean):TParamLigne_obj;
var
tab:variant;
Begin
Ecriture_Import.InitialiseParamLigne_obj(result);
with PIdentifiant_obj(Ecriture_Import.ListIdentifiant.Items[LCourante])^.ligne do
   begin //début du with
   result.TVA.Retour:=true;
   result.TVA.CodeTva:=Complement.CodeTvaCompl;
   RenvoieInfoSurTableDiverse(Complement.CodeTvaCompl,DMTVACode.TaTvaCode,'TvaCode',['Taux_Inf','Taux_Supp','Compte','Libelle'],tab);
    if UpperCase(Complement.CodeTvaCompl)='C1' then
      begin
      result.TVA.TauxMin:=Complement.TvaTaux;
      result.TVA.TauxMax:=Complement.TvaTaux;
      end
    else
      Begin
      result.TVA.TauxMin:=tab[0];
      result.TVA.TauxMax:=tab[1];
      result.TVA.Compte:=tab[2];
      result.TVA.Libelle:=tab[3];
      result.TVA.sensCredit:=result.SensCredit;
      End;
   TVA.Retour:=result.TVA.Retour;
   TVA.CodeTva:=result.TVA.CodeTva;
   TVA.TauxMin:=result.TVA.TauxMin;
   TVA.TauxMax:=result.TVA.TauxMax;
   TVA.Compte:=result.TVA.Compte;
   TVA.Libelle:=result.TVA.Libelle;
   TVA.sensCredit:=result.TVA.sensCredit;
   end;//fin du with
End;



Function TDMImport.Import_Stocks(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 Compte,Designation:String;
 OldTagDM:Integer;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
if DMStock = nil then DMStock:=TDMStock.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les stocks d''ouverture d''Epicéa-2 DOS ?'),mtconfirmation, [mbYes,mbno],0,MB_DEFBUTTON2) = mryes then
begin
//     gère la suppression des stocks avant importation
       if DMStock=nil then DMStock:=TDMStock.Create(application.MainForm);
       FiltrageDataSet(DMStock.TaStock,'Date_Saisie= '''+datetostr(E.DatExoDebut-1)+'''');
       DMStock.TaStock.first;
       while DMStock.TaStock.RecordCount<>0 do
         Begin
           TableGereDelete(DMStock.TaStock);
         end;
//     end;


  Liste:=TList.Create;
  ListeErreur:=TStringList.Create;
  ListeErreur.Clear;
  if FileExistDialog(E.RepertoireImportCourante,'E3-CDIV.TXT',true) then
   begin
     ImportationStockEPI_D(E.RepertoireImportCourante+'E3-CDIV.TXT',Liste);
     for i:=0 to Liste.Count-1 do
      begin
        Compte:=PImport_Stock(Liste.Items[i])^.Compte;
        Designation:=str_ImportDosToWin(PImport_Stock(Liste.Items[i])^.Designation);
        try
        DMStock.ImportStocks([0,
                              Compte,
                              Designation,
                              currtostr(PImport_Stock(Liste.Items[i])^.Qte),
                              currtostr(PImport_Stock(Liste.Items[i])^.PrixUnitaire),
                              currtostr(PImport_Stock(Liste.Items[i])^.Decote),
                              currtostr(PImport_Stock(Liste.Items[i])^.PrixTHT)],
                              DataSet);
        except
         ListeErreur.Add(Compte+' '+Designation
                               +' '+CurrToStr(PImport_Stock(Liste.Items[i])^.Qte)+' '+CurrToStr(PImport_Stock(Liste.Items[i])^.PrixUnitaire)+' '+
                               IntToStr(PImport_Stock(Liste.Items[i])^.Decote)+' '+CurrToStr(PImport_Stock(Liste.Items[i])^.PrixTHT));
        end;
      end;
   end;
  if ListeErreur.Count=0 then
   ListeErreur.Add(IntToStr(Liste.count)+' Stocks importés avec succès !');
  ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CDIV_JNL_STOCKS.TXT');
  Liste.Free;
  ListeErreur.Free;
  showmessage('Fin de l''importation des Stocks !');
end;
except

showmessage('Erreur durant l''importation des Stocks d''Epicéa-2 DOS');
abort;
end;
finally
 E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally



End;

Function TDMImport.Import_ChAPayer(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 ListeChAPayer,ListePrARecevoir:TList;
 ListeErreur:TStringList;
 Compte,Compte2,Designation2:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
if DMChargeAPayer = nil then DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;
  
if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les charges à payer d''ouverture d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
begin
//     gère la suppression des charges à payer avant importation
       if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(application.MainForm);
       DMChargeAPayer.Tag := 11; // Initialisation du tag pour les Charges Payer à l'ouverture
       FiltrageDataSet(DMChargeAPayer.TaChAPayer,'Sens=''C''and DateSaisie= '''+datetostr(E.DatExoDebut-1)+'''');
       DMChargeAPayer.TaChAPayer.first;
       while DMChargeAPayer.TaChAPayer.RecordCount<>0 do
         Begin
           TableGereDelete(DMChargeAPayer.TaChAPayer);
         end;
//     end;


  ListeChAPayer:=TList.Create;
  ListePrARecevoir:=TList.Create;
  ListeErreur:=TStringList.Create;
  ListeErreur.Clear;
  if FileExistDialog(E.RepertoireImportCourante,'E3-CDIV.TXT',true) then
   begin
     ImportationChAPayerEPI_D(E.RepertoireImportCourante+'E3-CDIV.TXT',ListeChAPayer,ListePrARecevoir);
     for i:=0 to ListeChAPayer.Count-1 do
      begin
        Compte:=PImport_ChAPayer(ListeChAPayer.Items[i])^.Compte;
        Designation2:=str_ImportDosToWin(PImport_ChAPayer(ListeChAPayer.Items[i])^.Designation);
        Compte2:=PImport_ChAPayer(ListeChAPayer.Items[i])^.Compte2;
//        if Compte2 = '6016' then
//         showmessage('stop');
        try
        DMChargeAPayer.ImportChAPayer([0,
                                       Compte,
                                       nil,
                                       nil,
                                       currtostr(PImport_ChAPayer(ListeChAPayer.Items[i])^.Qte),
                                       currtostr(PImport_ChAPayer(ListeChAPayer.Items[i])^.MontantHt),
                                       nil,
                                       nil,
                                       Compte2,
                                       Designation2,
                                       currtostr(PImport_ChAPayer(ListeChAPayer.Items[i])^.TVA)
                                       ],DataSet);
        except
         ListeErreur.Add(Compte+' '+
                         Designation2+' '+
                         CurrToStr(PImport_ChAPayer(ListeChAPayer.Items[i])^.Qte)+' '+
                         CurrToStr(PImport_ChAPayer(ListeChAPayer.Items[i])^.MontantHt)+' '+
                         CurrToStr(PImport_ChAPayer(ListeChAPayer.Items[i])^.TVA)+' '+
                         Compte2
                         );
        end;
      end;
   end;
  if ListeErreur.Count=0 then
   ListeErreur.Add(IntToStr(ListeChAPayer.count)+' Charges à payer importées avec succès !');
  ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CDIV_JNL_CAP.TXT');
  ListeChAPayer.Free;
  ListePrARecevoir.Free;
  ListeErreur.Free;
  showmessage('Fin de l''importation des Charges à payer !');
end;
except
showmessage('Erreur durant l''importation des Charges à payer d''Epicéa-2 DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;


Function TDMImport.Import_PrARecevoir(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 ListeChAPayer,ListePrARecevoir:TList;
 ListeErreur:TStringList;
 Compte,Compte2,Designation2:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
if DMChargeAPayer = nil then DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;
if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les produits à recevoir d''ouverture d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
begin
//     gère la suppression des produits à recevoir avant importation
       if DMChargeAPayer=nil then DMChargeAPayer:=TDMChargeAPayer.Create(application.MainForm);
       FiltrageDataSet(DMChargeAPayer.TaChAPayer,'Sens=''D''and DateSaisie= '''+datetostr(E.DatExoDebut-1)+'''');
       DMChargeAPayer.Tag := 12; // Initialisation du tag pour les produits à recevoir à l'ouverture
       DMChargeAPayer.TaChAPayer.first;
       while DMChargeAPayer.TaChAPayer.RecordCount<>0 do
         Begin
           TableGereDelete(DMChargeAPayer.TaChAPayer);
         end;
//     end;


  ListeChAPayer:=TList.Create;
  ListePrARecevoir:=TList.Create;
  ListeErreur:=TStringList.Create;
  ListeErreur.Clear;
  if FileExistDialog(E.RepertoireImportCourante,'E3-CDIV.TXT',true) then
   begin
     ImportationChAPayerEPI_D(E.RepertoireImportCourante+'E3-CDIV.TXT',ListeChAPayer,ListePrARecevoir);
     for i:=0 to ListePrARecevoir.Count-1 do
      begin
        Compte:=PImport_ChAPayer(ListePrARecevoir.Items[i])^.Compte;
        Designation2:=str_ImportDosToWin(PImport_ChAPayer(ListePrARecevoir.Items[i])^.Designation);
        Compte2:=PImport_ChAPayer(ListePrARecevoir.Items[i])^.Compte2;
//        if Compte2 = '6016' then
//         showmessage('stop');
        try
        DMChargeAPayer.ImportPrARecevoir([0,
                                       Compte,
                                       nil,
                                       nil,
                                       currtostr(PImport_ChAPayer(ListePrARecevoir.Items[i])^.Qte),
                                       currtostr(PImport_ChAPayer(ListePrARecevoir.Items[i])^.MontantHt),
                                       nil,
                                       nil,
                                       Compte2,
                                       Designation2,
                                       currtostr(PImport_ChAPayer(ListePrARecevoir.Items[i])^.TVA)
                                       ],DataSet);
        except
         ListeErreur.Add(Compte+' '+
                         Designation2+' '+
                         CurrToStr(PImport_ChAPayer(ListePrARecevoir.Items[i])^.Qte)+' '+
                         CurrToStr(PImport_ChAPayer(ListePrARecevoir.Items[i])^.MontantHt)+' '+
                         CurrToStr(PImport_ChAPayer(ListePrARecevoir.Items[i])^.TVA)+' '+
                         Compte2
                         );
        end;
      end;
   end;
  if ListeErreur.Count=0 then
   ListeErreur.Add(IntToStr(ListePrARecevoir.count)+' Produits à Recevoir importées avec succès !');
  ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CDIV_JNL_PAR.TXT');
  ListeChAPayer.Free;
  ListePrARecevoir.Free;
  ListeErreur.Free;
  showmessage('Fin de l''importation des Produits à Recevoir !');
end;
except
showmessage('Erreur durant l''importation des Produits à Recevoir d''Epicéa-2 DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_ChCAvance(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 ListeChCAvance,ListePrCAvance:TList;
 ListeErreur:TStringList;
 Compte,Compte2,Designation2:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
if DMChargeCA = nil then DMChargeCA:=TDMChargeCA.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;
if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les charges constatées d''avance d''ouverture d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
begin
//     begin //gère la suppression des charges constatées d''avance avant importation
       if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.Create(application.MainForm);
       FiltrageDataSet(DMChargeCA.TaPCA,'Sens=''D''and DateSaisie= '''+datetostr(E.DatExoDebut-1)+'''');
       DMChargeCA.Tag := 11; // Initialisation du tag pour les Charges Payer à l'ouverture
       DMChargeCA.TaPCA.first;
       while DMChargeCA.TaPCA.RecordCount<>0 do
         Begin
           TableGereDelete(DMChargeCA.TaPCA);
         end;
//     end;


  ListeChCAvance:=TList.Create;
  ListePrCAvance:=TList.Create;
  ListeErreur:=TStringList.Create;
  ListeErreur.Clear;
  if FileExistDialog(E.RepertoireImportCourante,'E3-CDIV.TXT',true) then
   begin
     ImportationChPCAvanceEPI_D(E.RepertoireImportCourante+'E3-CDIV.TXT',ListeChCAvance,ListePrCAvance);
     for i:=0 to ListeChCAvance.Count-1 do
      begin
        Compte:=PImport_ChPCAvance(ListeChCAvance.Items[i])^.Compte;
        Designation2:=str_ImportDosToWin(PImport_ChPCAvance(ListeChCAvance.Items[i])^.Designation);
        Compte2:=PImport_ChPCAvance(ListeChCAvance.Items[i])^.Compte2;
        try
        DMChargeCA.ImportChCAvance([0,
                                       Compte,
                                       nil,
                                       nil,
                                       currtostr(PImport_ChPCAvance(ListeChCAvance.Items[i])^.Qte),
                                       currtostr(PImport_ChPCAvance(ListeChCAvance.Items[i])^.MontantHt),
                                       nil,
                                       nil,
                                       Compte2,
                                       Designation2
                                       ],DataSet);
        except
         ListeErreur.Add(Compte+' '+
                         Designation2+' '+
                         CurrToStr(PImport_ChPCAvance(ListeChCAvance.Items[i])^.Qte)+' '+
                         CurrToStr(PImport_ChPCAvance(ListeChCAvance.Items[i])^.MontantHt)+' '+
                         Compte2
                         );
        end;
      end;
   end;
  if ListeErreur.Count=0 then
   ListeErreur.Add(IntToStr(ListeChCAvance.count)+' Charges constatées d''avance importées avec succès !');
  ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CDIV_JNL_CCA.TXT');
  ListeChCAvance.Free;
  ListePrCAvance.Free;
  ListeErreur.Free;
  showmessage('Fin de l''importation des Charges constatées d''avance !');
end;
except
showmessage('Erreur durant l''importation des Charges constatées d''avance d''Epicéa-2 DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;


Function TDMImport.Import_PrCAvance(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 ListeChCAvance,ListePrCAvance:TList;
 ListeErreur:TStringList;
 Compte,Compte2,Designation2:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
if DMChargeCA = nil then DMChargeCA:=TDMChargeCA.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les produits constatées d''avance d''ouverture d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
begin
     ///begin //gère suppression des produits à recevoir avant importation
       if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.Create(application.MainForm);
       FiltrageDataSet(DMChargeCA.TaPCA,'Sens=''C''and DateSaisie= '''+datetostr(E.DatExoDebut-1)+'''');
       DMChargeCA.Tag := 12; // Initialisation du tag pour les Charges Payer à l'ouverture
       DMChargeCA.TaPCA.first;
       while DMChargeCA.TaPCA.RecordCount<>0 do
         Begin
           TableGereDelete(DMChargeCA.TaPCA);
         end;
     //end;


  ListeChCAvance:=TList.Create;
  ListePrCAvance:=TList.Create;
  ListeErreur:=TStringList.Create;
  ListeErreur.Clear;
  if FileExistDialog(E.RepertoireImportCourante,'E3-CDIV.TXT',true) then
   begin
     ImportationChPCAvanceEPI_D(E.RepertoireImportCourante+'E3-CDIV.TXT',ListeChCAvance,ListePrCAvance);
     for i:=0 to ListePrCAvance.Count-1 do
      begin
        Compte:=PImport_ChPCAvance(ListePrCAvance.Items[i])^.Compte;
        Designation2:=str_ImportDosToWin(PImport_ChPCAvance(ListePrCAvance.Items[i])^.Designation);
        Compte2:=PImport_ChPCAvance(ListePrCAvance.Items[i])^.Compte2;
        try
        DMChargeCA.ImportPrCAvance([0,
                                       Compte,
                                       nil,
                                       nil,
                                       currtostr(PImport_ChPCAvance(ListePrCAvance.Items[i])^.Qte),
                                       currtostr(PImport_ChPCAvance(ListePrCAvance.Items[i])^.MontantHt),
                                       nil,
                                       nil,
                                       Compte2,
                                       Designation2
                                       ],DataSet);
        except
         ListeErreur.Add(Compte+' '+
                         Designation2+' '+
                         CurrToStr(PImport_ChPCAvance(ListePrCAvance.Items[i])^.Qte)+' '+
                         CurrToStr(PImport_ChPCAvance(ListePrCAvance.Items[i])^.MontantHt)+' '+
                         Compte2
                         );
        end;
      end;
   end;
  if ListeErreur.Count=0 then
   ListeErreur.Add(IntToStr(ListePrCAvance.count)+' Produits constatées d''avance importées avec succès !');
  ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CDIV_JNL_PCA.TXT');
  ListeChCAvance.Free;
  ListePrCAvance.Free;
  ListeErreur.Free;
  showmessage('Fin de l''importation des Produits constatées d''avance !');
end;
except
showmessage('Erreur durant l''importation des Produits constatées d''avance d''Epicéa-2 DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_Provision(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 ListeProvision:TList;
 ListeErreur:TStringList;
 Compte,Designation:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
if DMProvisions = nil then DMProvisions:=TDMProvisions.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les Provisions d''ouverture d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
begin
     /////// gère la suppression des provision avant importation
       DMProvisions.Tag := C_Ouverture; // Initialisation du tag pour les Provisions à l'ouverture
       FiltrageDataSet(DMProvisions.TaProvision,'DateSaisie= '''+datetostr(E.DatExoDebut-1)+'''');
       DMProvisions.TaProvision.first;
       while DMProvisions.TaProvision.RecordCount<>0 do
         Begin
           TableGereDelete(DMProvisions.TaProvision);
         end;
     /////

  ListeProvision:=TList.Create;
  ListeErreur:=TStringList.Create;
  ListeErreur.Clear;
  if FileExistDialog(E.RepertoireImportCourante,'E3-CDIV.TXT',true) then
   begin
     ImportationProvisionsEPI_D(E.RepertoireImportCourante+'E3-CDIV.TXT',ListeProvision);
     for i:=0 to ListeProvision.Count-1 do
      begin
        Compte:=PImport_Provisions(ListeProvision.Items[i])^.Compte;
        Designation:=str_ImportDosToWin(PImport_Provisions(ListeProvision.Items[i])^.Designation);
        try
        DMProvisions.ImportProvisions([0,
                                       Compte,
                                       Designation,
                                       currtostr(PImport_Provisions(ListeProvision.Items[i])^.MtTotalProvision),
                                       currtostr(PImport_Provisions(ListeProvision.Items[i])^.MtBilanOuverture)
                                       ],DataSet);
        except
         ListeErreur.Add(Compte+' '+
                         Designation+' '+
                         CurrToStr(PImport_Provisions(ListeProvision.Items[i])^.MtTotalProvision)+' '+
                         CurrToStr(PImport_Provisions(ListeProvision.Items[i])^.MtBilanOuverture)
                         );
        end;
      end;
   end;
  if ListeErreur.Count=0 then
   ListeErreur.Add(IntToStr(ListeProvision.count)+' Provisions importées avec succès !');
  ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CDIV_JNL_PRV.TXT');
  ListeProvision.Free;
  ListeErreur.Free;
  showmessage('Fin de l''importation des Provisions!');
end;
except
showmessage('Erreur durant l''importation des Provisions d''Epicéa-2 DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_ChARepartir(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 ListeChARepartir:TList;
 ListeErreur:TStringList;
 Compte,Designation:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
if DMChargeRepartir = nil then DMChargeRepartir:=TDMChargeRepartir.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;
if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les Charges à répartir d''ouverture d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
begin
      DMChargeRepartir.Tag:=C_Ouverture;
//     gère la suppression des charges à repartir avant importation
       FiltrageDataSet(DMChargeRepartir.TaCar,'DateSaisie= '''+datetostr(E.DatExoDebut-1)+''''); 
       DMChargeRepartir.TaCar.first;
       while DMChargeRepartir.TaCar.RecordCount<>0 do
         Begin
           TableGereDelete(DMChargeRepartir.TaCar);
         end;
//     end;


  ListeChARepartir:=TList.Create;
  ListeErreur:=TStringList.Create;
  ListeErreur.Clear;
  if FileExistDialog(E.RepertoireImportCourante,'E3-CDIV.TXT',true) then
   begin
     ImportationChARepartirEPI_D(E.RepertoireImportCourante+'E3-CDIV.TXT',ListeChARepartir);
     for i:=0 to ListeChARepartir.Count-1 do
      begin
        Compte:=PImport_ChARepartir(ListeChARepartir.Items[i])^.Compte;
        Designation:=str_ImportDosToWin(PImport_ChARepartir(ListeChARepartir.Items[i])^.Designation);
        try
        DMChargeRepartir.ImportsChargeRepartir([0,
                                            Compte,
                                            Designation,
                                            currtostr(PImport_ChARepartir(ListeChARepartir.Items[i])^.MtTotalCharge),
                                            currtostr(PImport_ChARepartir(ListeChARepartir.Items[i])^.MtBilanOuverture)
                                            ],DataSet);
        except
         ListeErreur.Add(Compte+' '+
                         Designation+' '+
                         CurrToStr(PImport_ChARepartir(ListeChARepartir.Items[i])^.MtTotalCharge)+' '+
                         CurrToStr(PImport_ChARepartir(ListeChARepartir.Items[i])^.MtBilanOuverture)
                         );
        end;
      end;
   end;
  if ListeErreur.Count=0 then
   ListeErreur.Add(IntToStr(ListeChARepartir.count)+' Charges à répartir importées avec succès !');
  ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CDIV_JNL_CAR.TXT');
  ListeChARepartir.Free;
  ListeErreur.Free;
  showmessage('Fin de l''importation des Charges à répartir !');
end;
except
showmessage('Erreur durant l''importation des Charges à répartir d''Epicéa-2 DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_Plan_Entier(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 Compte,Libelle,U1,U2,CodeTVa,TvaType:String;
 TvaDebit,SensCredit,Collectif,Immobilisation,Pointable:Boolean;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer le plan comptable d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
    try
//      if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
       begin
        E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

        if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
         E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
       end;
    except

    end;
    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
    if FileExistDialog(E.RepertoireImportCourante,'E3-CPLC.TXT',true) then
     begin
       ImportationPlanEPI_DOS_ENTIER(E.RepertoireImportCourante+'E3-CPLC.TXT',Liste);
       // Attention, ici, on vide toutes les tables dossier et exercice
       InitDataBase(DMBD.dbNameProg,DMBD.dbNameDossier,DMBD.dbNameExo,false);
       InitTableEpi.SelectionnerTableAvantImport(nil);
       DataSet.refresh;

       for i:=0 to Liste.Count-1 do
        begin
          Compte:=PImport_Plan(Liste.Items[i])^.Compte;
          Compte:=str_supprespaces(Compte);
          Libelle:=PImport_Plan(Liste.Items[i])^.Libelle;
          TvaType :=PImport_Plan(Liste.Items[i] )^.TypeTVA;
          TvaDebit:=(PImport_Plan(Liste.Items[i] )^.TypeTVA = 'D');
          SensCredit:=(PImport_Plan(Liste.Items[i] )^.SensSaisie = 'C');
          Collectif:=(PImport_Plan(Liste.Items[i])^.Collectif = '*');
          Pointable:=Collectif;
          Immobilisation:=(PImport_Plan(Liste.Items[i])^.Immo = '*');
          U1:=PImport_Plan(Liste.Items[i])^.U1;
          U2:=PImport_Plan(Liste.Items[i])^.U2;
          CodeTVa:=PImport_Plan(Liste.Items[i])^.CodeTVA;
          if not empty(CodeTva) then
                 case ord(CodeTva[1]) of
                    49:CodeTva:='I1';
                    50:CodeTva:='A2';
                    51:CodeTva:='V3';
                    52:CodeTva:='V4';
                    53:CodeTva:='V5';
                    54:CodeTva:='V6';
                    55:CodeTva:='V7';
                    56:CodeTva:='V8';
                    57:CodeTva:='V9';
                    // code TVa DOS qui ne sont pas dans la liste mais qui sont définis en dur !!
                    65:CodeTva:='C1';// Le code A de Dos devient C1 dans Windows
                    69:CodeTva:='E1';
                    76:CodeTva:='L1';
                    78:CodeTva:='N1';
                    77:CodeTva:='M1';

                 end;

          try

          DMPlan.Import_Plan([Compte,
                              Libelle,
                              0,
                              0,
                              U1,
                              U2,
                              0,
                              0,
                              False, // PlanSaisie
                              CodeTVA, // TvaCode
                              TvaType, // TvaType
                              TvaDebit,// TvaDebit
                              SensCredit,// SensCredit
                              Collectif, // Collectif
                              False, // Centraliser
                              False, // Tiers
                              False, // Rapprochement
                              Immobilisation, // Immo
                              False, // ImmoAmmort
                              False, // ImmoDegressif
                              False,// Emprunt
                              False, // Abandonne
                              E.User,
                              now,
                              0,
                              nil,
                              Pointable, // A Traiter pointable
                              0,
                              nil],dataSet);
          except
           ListeErreur.Add(Compte+' '+
                           Libelle+' '+
                           '0.00'+' '+
                           '0.00'+' '+
                           PImport_Plan(Liste.Items[i])^.CodeTVA+' '+
                           PImport_Plan(Liste.Items[i])^.TypeTVA+' '+
                           PImport_Plan(Liste.Items[i])^.SensSaisie+' '+
                           PImport_Plan(Liste.Items[i])^.Collectif+' '+
                           PImport_Plan(Liste.Items[i])^.U1+' '+
                           PImport_Plan(Liste.Items[i])^.U2+' '+
                           PImport_Plan(Liste.Items[i])^.Immo);
          end;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' compte du Plan comptable Epicea-2 DOS importés avec succès !');
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CPLC_JNL.TXT');
    Liste.Free;
    ListeErreur.Free;

    showmessage('Fin de l''importation du plan comptable !');
  end;
except;
showmessage('Erreur durant l''importation du plan comptable d''Epicéa-2 DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_BO_SIEA_DOS(DataSet:TDataSet;Confirmation:Boolean;Var CheminImport,NomFic:String):Boolean;
var
 i,IndexDelimiter:integer;
 Liste:TList;
 ListeErreur:TStringList;
 Compte,Libelle,U1,U2,CodeTVa,TvaType:String;
 TvaDebit,SensCredit,Collectif,Immobilisation,Pointable:Boolean;
 TypeEtatExerciceTmp:TTypeEtatExercice;
 NomFichier:String;
 ReportDebit,ReportCredit:Currency;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMPlan = nil then
         DMPlan:=TDMPlan.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationSIEA then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationSIEA)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationSIEA;

      if ChoisirRepImportation(E.RepertoireImportCourante,'SIEA DOS') then
       E.RepertoireImportationSIEA := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;


  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les montants de la Balance d''Ouverture de SIEA DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
//    NomFichier:=NomFic;
    if ChercheFileDialog(CheminImport,NomFic,'Fichiers export SIEA (*.asc)|*.asc',true,'Indiquez le fichier de la balance.') then
//    if ChercheFileDialog(CheminImport,NomFichier,'Fichiers export SIEA (*.asc)|*.asc',true,'Indiquez le fichier de la balance.') then
     begin
//       NomFic:=ExtractFileName(NomFichier);
//       CheminImport:=ExtractFileDir(NomFichier);
       ImportationBO_SIEA_DOS(CheminImport+NomFic,Liste);
//       DataSet.refresh;

       for i:=0 to Liste.Count-1 do
        begin
          Compte:=PImport_BO_SIEA_DOS(Liste.Items[i])^.Compte;
          Compte:=str_supprespaces(Compte);
          Libelle:=PImport_BO_SIEA_DOS(Liste.Items[i])^.Libelle;
          ReportDebit:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportDebit))+StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.MvtDebit));
          ReportCredit:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportCredit))+StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.MvtCredit));

          DetermineSolde(ReportDebit,ReportCredit);
          try
          DMPlan.Import_BO_SIEA_DOS([Compte,
                                        Libelle,
                                        ReportDebit,
                                        ReportCredit],
                                        DataSet);
          except
           ListeErreur.Add(Compte+' '+
                           Libelle+' '+
                           PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportDebit+' '+
                           PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportCredit);
          end;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' compte de la Balance d''Ouverture SIEA DOS importés avec succès !');
//     IndexDelimiter :=LastDelimiter('\',NomFichier);
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_SIEA)+ChangeExtensionFichier('2'+NomFic,'txt'));
    Liste.Free;
    ListeErreur.Free;

    showmessage('Fin de l''importation de la Balance d''Ouverture de SIEA DOS!');
  end;
except;
showmessage('Erreur durant l''importation de la Balalnce d''Ouverure de SIEA DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_BO_SIEA_DOS_MAJCPT(DataSet:TDataSet;Confirmation:Boolean;Var CheminImport,NomFic:String):Boolean;
var
 i,IndexDelimiter:integer;
 Liste:TList;
 ListeErreur:TStringList;
 Compte,Libelle,U1,U2,CodeTVa,TvaType:String;
 TvaDebit,SensCredit,Collectif,Immobilisation,Pointable:Boolean;
 TypeEtatExerciceTmp:TTypeEtatExercice;
// NomFichier:String;
 ReportDebit,ReportCredit:Currency;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMPlan = nil then
         DMPlan:=TDMPlan.Create(Application.MainForm);

  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationSIEA then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationSIEA)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationSIEA;

      if ChoisirRepImportation(E.RepertoireImportCourante,'SIEA DOS') then
       E.RepertoireImportationSIEA := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir mettre à jour les comptes avec la Balance d''Ouverture de SIEA DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
//    NomFichier:=NomFic;
    if ChercheFileDialog(CheminImport,NomFic,'Fichiers export SIEA (*.asc)|*.asc',true,'Indiquez le fichier de la balance.') then
     begin
//       NomFic:=ExtractFileName(NomFichier);
//       CheminImport:=ExtractFileDir(NomFichier);
       ImportationBO_SIEA_DOS(CheminImport+NomFic,Liste);
       Screen.Cursor := crHourGlass;
//       DataSet.refresh;

       for i:=0 to Liste.Count-1 do
        begin
          Compte:=PImport_BO_SIEA_DOS(Liste.Items[i])^.Compte;
          Compte:=str_supprespaces(Compte);
          Libelle:=PImport_BO_SIEA_DOS(Liste.Items[i])^.Libelle;
//          ReportDebit:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportDebit));
//          ReportCredit:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportCredit));
          try
          DMPlan.Import_BO_SIEA_DOS_MAJ([Compte,
                                         Libelle],
                                         DataSet);
          except
           ListeErreur.Add(Compte+' '+
                           Libelle);
          end;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' compte pour mise à jour des comptes du plan de la Balance d''Ouverture SIEA DOS importés avec succès !');
//     IndexDelimiter :=LastDelimiter('\',NomFic);
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_SIEA)+ChangeExtensionFichier('1'+NomFic,'txt'));
//    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,'JOURNAL-')+ChangeExtensionFichier(ExtractFieldName(NomFic,IndexDelimiter),'txt'));
    Liste.Free;
    ListeErreur.Free;

    showmessage('Fin de la mise à jour des comptes du plan comptable!');
  end;
except;
showmessage('Erreur durant la mise à jour des comptes du plan comptable');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_CodeTva(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 Compte,Libelle,CodeTVa,TypeTva,classe:String;
 Taux1,Taux2:Currency;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les codes TVA d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
    if FileExistDialog(E.RepertoireImportCourante,'E3-CTVA.TXT',true) then
     begin
       ImportationCodeTvaEPI_DOS(E.RepertoireImportCourante+'E3-CTVA.TXT',Liste);
       // Code créé obligatoirement dans Epi Win
       classe:='C';
       DMTVACode.ImportCodeTVA(['C1',classe,'Acquisition CEE','',0,0,'LGR_IMPORT',now,''],dataSet);
       classe:='E';
       DMTVACode.ImportCodeTVA(['E1',classe,'Exportation','',0,0,'LGR_IMPORT',now,''],dataSet);
       classe:='L';
       DMTVACode.ImportCodeTVA(['L1',classe,'Livraison CEE','',0,0,'LGR_IMPORT',now,''],dataSet);
       classe:='N';
       DMTVACode.ImportCodeTVA(['N1',classe,'Vente non Imposable','',0,0,'LGR_IMPORT',now,''],dataSet);

       for i:=0 to Liste.Count-1 do
        begin
          CodeTVa:=PImport_Tva(Liste.Items[i])^.CodeTVA;
          Compte:=PImport_Tva(Liste.Items[i])^.Compte;
          Libelle:=PImport_Tva(Liste.Items[i])^.Libelle;
          TypeTva:=PImport_Tva(Liste.Items[i])^.TypeTVA;
          Taux1:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_Tva(Liste.Items[i] )^.Taux1));
          Taux2:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_Tva(Liste.Items[i])^.Taux2));
          if not empty(CodeTva) then
                 case ord(CodeTva[1]) of
                    49:CodeTva:='I1';
                    50:CodeTva:='A1';
                    51:CodeTva:='V3';
                    52:CodeTva:='V4';
                    53:CodeTva:='V5';
                    54:CodeTva:='V6';
                    55:CodeTva:='V7';
                    56:CodeTva:='V8';
                    57:CodeTva:='V9';
                 end;
          classe:=CodeTva[1];
          try
           DMTVACode.ImportCodeTVA([CodeTVA,
                                    classe,
                                    Libelle,
                                    Compte,
                                    Taux1,
                                    Taux2,
                                    'LGR_IMPORT',
                                    now,
                                    ''],dataSet);
          except
           ListeErreur.Add(CodeTVA+' '+
                           CodeTva[1]+' '+
                           Libelle+' '+
                           Compte+' '+
                           CurrToStr(Taux1)+' '+
                           CurrToStr(Taux2));
          end;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' codes TVA Epicea-2 DOS importés avec succès !');
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CTVA_JNL.TXT');
    Liste.Free;
    ListeErreur.Free;
    showmessage('Fin de l''importation des codes TVA!');
  end;
except;
showmessage('Erreur importation codes TVA ');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;


Function TDMImport.Import_Tiers(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 Tiers,Nom,Compte,TypeTiers:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMTiers = nil then DMTiers:=TDMTiers.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les Tiers d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
//         gère suppression des tiers avant importation
           filtrageDataset(DMTiers.TaTiersGest,'');
             DMTiers.TaTiersGest.first;
             while DMTiers.TaTiersGest.RecordCount<>0 do
               Begin
                 TableGereDelete(DMTiers.TaTiersGest);
               end;
//         end;


    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
    if FileExistDialog(E.RepertoireImportCourante,'E3-CPLA.TXT',true) then
     begin
       ImportationPlanAuxEPI_DOS(E.RepertoireImportCourante+'E3-CPLA.TXT',Liste);

       for i:=0 to Liste.Count-1 do
        begin
          Tiers:=PImport_Tiers(Liste.Items[i])^.Tiers;
          Nom:=PImport_Tiers(Liste.Items[i])^.Nom;
          Compte:=PImport_Tiers(Liste.Items[i])^.Compte;
          TypeTiers:=PImport_Tiers(Liste.Items[i])^.TypeTiers;
          try
           DMTiers.ImportTiers([Tiers,
                                Nom,
                                Compte,
                                TypeTiers,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                nil,
                                'LGR_IMPORT',
                                now,
                                true],dataSet);
          except
           ListeErreur.Add(Tiers+' '+
                           Nom+' '+
                           Compte+' '+
                           TypeTiers);
          end;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' Tiers du plan auxiliaire Epicea-2 DOS importés avec succès !');
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CPLA_JNL.TXT');
    Liste.Free;
    ListeErreur.Free;
    showmessage('Fin de l''importation des Tiers du plan auxiliaire !');
  end;
except;
showmessage('Erreur importation Tiers du plan auxiliaire  ');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_Journaux(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 Journal,Libelle,CodeInterne,Nom,Compte:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMJournal = nil then DMJournal:=TDMJournal.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les Journaux d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
    if FileExistDialog(E.RepertoireImportCourante,'E3-CJOU.TXT',true) then
     begin
       ImportationJournaux(E.RepertoireImportCourante+'E3-CJOU.TXT',Liste);

       for i:=0 to Liste.Count-1 do
        begin
          Journal:=PImport_Journaux(Liste.Items[i])^.Journal;
          Libelle:=PImport_Journaux(Liste.Items[i])^.Libelle;
          CodeInterne:=PImport_Journaux(Liste.Items[i])^.CodeInterne;
          If ((copy(CodeInterne,1,1)='T')and(copy(Journal,1,1)='O')) then Journal:='B'+copy(Journal,2,length(Journal));
          Compte:=PImport_Journaux(Liste.Items[i])^.Compte;
          try
           DMJournal.ImportJournaux([0,
                                Journal,
                                Libelle,
                                Libelle,
                                Journal,
                                Compte,
                                nil,
                                nil,
                                nil,
                                nil,
                                'LGR_IMPORT',
                                now,
                                nil],dataSet);
          except
           ListeErreur.Add(Journal+' '+
                           Libelle+' '+
                           Libelle+' '+
                           Journal+' '+
                           Compte);
          end;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' Journaux d''Epicea-2 DOS importés avec succès !');
     
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CJOU_JNL.TXT');
    Liste.Free;
    ListeErreur.Free;
    showmessage('Fin de l''importation des Journaux !');
  end;
except;
showmessage('Erreur importation Journaux !');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function TDMImport.Import_Immo(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 InfosImmos:TInfosImmos;
 DateCession:string;
// Journal,Libelle,CodeInterne,Nom,Compte:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
 MessageLGR:TMessageLGR;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMJournal = nil then
         DMJournal:=TDMJournal.Create(Application.MainForm);

  if DMImmos_Ouverture = nil then DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les Immobilisations d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
//     gère suppression de toutes les immos avant importation
       DMImmos_Ouverture.taDetailImmo.Close;
       DMImmos_Ouverture.taDetailImmo.MasterSource:=nil;
       DMImmos_Ouverture.taDetailImmo.MasterFields:='';
       DefiltrageDataset(DMImmos_Ouverture.taDetailImmo);
       DMImmos_Ouverture.taDetailImmo.first;
       while DMImmos_Ouverture.taDetailImmo.RecordCount<>0 do
         Begin
           TableGereDelete(DMImmos_Ouverture.taDetailImmo);
         end;
       DMImmos_Ouverture.taDetailImmo.MasterSource:=DMImmos_Ouverture.daRecupImmosSurCpt;
       DMImmos_Ouverture.taDetailImmo.MasterFields:='ID';

//         end;


    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
    if FileExistDialog(E.RepertoireImportCourante,'E3-CIMO.TXT',true) then
     begin
       ImportationImmo(E.RepertoireImportCourante+'E3-CIMO.TXT',Liste);

       for i:=0 to Liste.Count-1 do
        begin
          try
           Initialise_TInfosImmos(InfosImmos);
           DateCession:='';
           DMImmos_Ouverture.Importation:=true;
           // Affectation des valeurs
           InfosImmos.Libelle:=PImport_Immo(Liste.Items[i])^.Designation;
           InfosImmos.Ecriture_Achat:=0;
           InfosImmos.Ecriture_Cession:=0;
           InfosImmos.Compte:=PImport_Immo(Liste.Items[i])^.NumCpt;
           InfosImmos.Code:=PImport_Immo(Liste.Items[i])^.CodeImmo;
           InfosImmos.Sous_Code:=PImport_Immo(Liste.Items[i])^.SousCodeImmo;
           if DateValide(PImport_Immo(Liste.Items[i])^.DateOrg) then
           InfosImmos.Date_Org:=strtodate_Lgr(PImport_Immo(Liste.Items[i])^.DateOrg);
           InfosImmos.Valeur_Org:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.ValeurAvantReel)));
           InfosImmos.Valeur_Venale:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.ValeurVenale)));
           InfosImmos.Type_Amt:=PImport_Immo(Liste.Items[i])^.TypeFiscal;
           InfosImmos.Duree:=StrToInt_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.DureeTotale)));
           InfosImmos.Valeur_a_Amortir:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.ValeurAAmortir)));
           if InfosImmos.Valeur_a_Amortir=0 then InfosImmos.Type_Amt:='N';
           if DateValide(PImport_Immo(Liste.Items[i])^.DateAchatPourReel) then
           InfosImmos.Date_Achat:=strtodate_Lgr(PImport_Immo(Liste.Items[i])^.DateAchatPourReel);
           if InfosImmos.Date_Org=0 then InfosImmos.Date_Org:=InfosImmos.Date_Achat;
           if DateValide(PImport_Immo(Liste.Items[i])^.DateMiseEnService) then
           InfosImmos.Date_Mise_en_Service:=strtodate_Lgr(PImport_Immo(Liste.Items[i])^.DateMiseEnService);
           InfosImmos.Duree_Amt:=StrToInt_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.NbMoisAmort)));
           InfosImmos.Mt_Deduc_Invest:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.MontantDeducSurInvest)));
           InfosImmos.Reprise_deduc_invest:=0;
           InfosImmos.Valeur_Nette:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.ValeurNetteComptable)));
           InfosImmos.Amort_Eco:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.AmortEco)));
           InfosImmos.Amort_Derog:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.AmortDerog)));
           if InfosImmos.Type_Amt='N' then
           begin
             InfosImmos.Amort_Eco:=0;
             InfosImmos.Amort_Derog:=0;
             InfosImmos.Duree_Amt:=0;
           end;
           InfosImmos.Mt_Cession:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.MontantCession)));
           InfosImmos.Achat_dans_Annee:=false;
           InfosImmos.Cession_dans_Annee:=false;
           if DateValide(PImport_Immo(Liste.Items[i])^.DateCession) then
             begin
               DateCession:=PImport_Immo(Liste.Items[i])^.DateCession;
             end;
           InfosImmos.Duree_Restante:=StrToInt_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.DureeDegressif)));
           InfosImmos.Simulation:=PImport_Immo(Liste.Items[i])^.Simulation;
           InfosImmos.TauxAmo:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_Immo(Liste.Items[i])^.TauxDegressif)))/100;
           if InfosImmos.Amort_Derog<>0 then
             begin
              ModifChampDerogatoire;
              e.Derogatoire:=true;
             end;
            DMImmos_Ouverture.ImportImmos([InfosImmos.ID,
                                           InfosImmos.Libelle,
                                           nil,
                                           nil,
                                           InfosImmos.Compte,
                                           InfosImmos.Code,
                                           InfosImmos.Sous_Code,
//                                           nil,
                                           datetostr(InfosImmos.Date_Org),
                                           InfosImmos.Valeur_Org,
                                           InfosImmos.Valeur_Venale,
                                           InfosImmos.Duree,
                                           InfosImmos.Valeur_a_Amortir,
                                           datetostr(InfosImmos.Date_Achat),
                                           datetostr(InfosImmos.Date_Mise_en_Service),
                                           InfosImmos.Duree_Amt,
                                           InfosImmos.Type_Amt,
                                           InfosImmos.Deduc_Invest,
                                           InfosImmos.Mt_Deduc_Invest,
                                           nil,
                                           InfosImmos.Valeur_Nette,
                                           InfosImmos.Amort_Eco,
                                           InfosImmos.Amort_Derog,
                                           InfosImmos.Mt_Cession,
                                           DateCession,
                                           InfosImmos.Rebut,
                                           nil,
                                           nil,
                                           InfosImmos.Duree_Restante,
                                           InfosImmos.Simulation,
                                           nil,
                                           nil,
                                           nil,
                                           nil,
                                           nil,
                                           nil,
                                           nil,
                                           nil,
                                           nil,
                                           InfosImmos.TauxAmo,
                                           nil,
                                           nil,
                                           nil
                                           ],DataSet);

          except
            showmessage('L"immobilisation  '+str_supprespaces(PImport_Immo(Liste.Items[i])^.NumCpt)+' '+PImport_Immo(Liste.Items[i])^.CodeImmo+' '+trim(PImport_Immo(Liste.Items[i])^.SousCodeImmo)+' n"a pas pu être importée correctement, voir liste des erreurs');
            ListeErreur.Add(str_supprespaces(PImport_Immo(Liste.Items[i])^.NumCpt)+' '+
                            PImport_Immo(Liste.Items[i])^.CodeImmo+' '+
                            PImport_Immo(Liste.Items[i])^.SousCodeImmo+' '+
                            PImport_Immo(Liste.Items[i])^.Designation+' '+
                            PImport_Immo(Liste.Items[i])^.DateOrg+' '+
                            PImport_Immo(Liste.Items[i])^.ValeurAvantReel+' '+
                            PImport_Immo(Liste.Items[i])^.ValeurVenale+' '+
                            PImport_Immo(Liste.Items[i])^.DureeTotale+' '+
                            PImport_Immo(Liste.Items[i])^.ValeurAAmortir+' '+
                            PImport_Immo(Liste.Items[i])^.TvaOrg+' '+
                            PImport_Immo(Liste.Items[i])^.DateAchatPourReel+' '+
                            PImport_Immo(Liste.Items[i])^.DateMiseEnService+' '+
                            PImport_Immo(Liste.Items[i])^.NbMoisAmort+' '+
                            PImport_Immo(Liste.Items[i])^.TypeEco+' '+
                            PImport_Immo(Liste.Items[i])^.TypeFiscal+' '+
                            PImport_Immo(Liste.Items[i])^.TauxLineaire+' '+
                            PImport_Immo(Liste.Items[i])^.TauxDegressif+' '+
                            PImport_Immo(Liste.Items[i])^.DeducSurInvest+' '+
                            PImport_Immo(Liste.Items[i])^.MontantDeducSurInvest+' '+
                            PImport_Immo(Liste.Items[i])^.ValeurNetteComptable+' '+
                            PImport_Immo(Liste.Items[i])^.AmortEco+' '+
                            PImport_Immo(Liste.Items[i])^.AmortDerogNonGere+' '+
                            PImport_Immo(Liste.Items[i])^.AmortDerog+' '+
                            PImport_Immo(Liste.Items[i])^.AmortExcept+' '+
                            PImport_Immo(Liste.Items[i])^.MontantCession+' '+
                            PImport_Immo(Liste.Items[i])^.DateCession+' '+
                            PImport_Immo(Liste.Items[i])^.Rebus+' '+
                            PImport_Immo(Liste.Items[i])^.PMVCourtTerme+' '+
                            PImport_Immo(Liste.Items[i])^.PMVLongTerme+' '+
                            PImport_Immo(Liste.Items[i])^.TVAAReintegreSurVente+' '+
                            PImport_Immo(Liste.Items[i])^.MontantTVAAReintegreSurVente+' '+
                            PImport_Immo(Liste.Items[i])^.DureeDegressif+' '+
                            PImport_Immo(Liste.Items[i])^.Simulation+' '+
                            PImport_Immo(Liste.Items[i])^.Economique);
          end;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' Immobilisations d''Epicea-2 DOS importés avec succès !');
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CIMO_JNL.TXT');
    Liste.Free;
    ListeErreur.Free;
    showmessage('Fin de l''importation des Immobilisations !');
  end;
except;
showmessage('Erreur importation Immobilisations !');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;




Function TDMImport.InitDataSetResultImport(TypeImport:Integer):Boolean;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 MtDebit,MtCredit:Currency;
 Compte,Libelle,U1,U2,CodeTVa:String;
 TvaDebit,SensCredit,Collectif,Immobilisation,Pointable:Boolean;
 MtBilanOuvertureImport:TMtBilanOuvertureImport;
Begin
case TypeImport of
   C_IMPORT_EPIDOS:Begin
                     Liste:=TList.Create;
                     ListeErreur:=TStringList.Create;
                     ListeErreur.Clear;
                     TaResultImport.Close;
                     if FileExistDialog(E.RepertoireImportCourante,'E3-CPLC.TXT',true) then
                         begin
                           ListeCompteBilanOuverture.Clear;
                           ImportationPlanEPI_DOS_ENTIER(E.RepertoireImportCourante+'E3-CPLC.TXT',Liste);
                           for i:=0 to Liste.Count-1 do
                            begin
                              try
                                Compte:=QueDesChiffres(PImport_Plan(Liste.Items[i])^.Compte);
//                                if compte = '131' then
//                                  showmessage('131 Impo');
                                MtBilanOuvertureImport:=TMtBilanOuvertureImport.Create(self);
                                Libelle:=PImport_Plan(Liste.Items[i])^.Libelle;
                                MtDebit:=StrToCurr_Lgr(ChangeDecimalSeparator(str_supprespaces(PImport_Plan(Liste.Items[i])^.BilanOuvDebit)));
                                MtCredit:=StrToCurr_Lgr(ChangeDecimalSeparator(str_supprespaces(PImport_Plan(Liste.Items[i])^.BilanOuvCredit)));
//                                MtDebit:=StrToCurr_Lgr(PImport_Plan(Liste.Items[i])^.BilanOuvDebit);
//                                MtCredit:=StrToCurr_Lgr(PImport_Plan(Liste.Items[i])^.BilanOuvCredit);

                                MtBilanOuvertureImport.Libelle :=Libelle;
                                MtBilanOuvertureImport.MtDebit :=MtDebit;
                                MtBilanOuvertureImport.MtCredit :=MtCredit;
                                ListeCompteBilanOuverture.AddObject(Compte,MtBilanOuvertureImport);
                              except
                               ListeErreur.Add(Compte+' '+
                                               Libelle+' '+
                                               PImport_Plan(Liste.Items[i])^.BilanOuvDebit+' '+
                                               PImport_Plan(Liste.Items[i])^.BilanOuvCredit+' '+
                                               PImport_Plan(Liste.Items[i])^.CodeTVA+' '+
                                               PImport_Plan(Liste.Items[i])^.TypeTVA+' '+
                                               PImport_Plan(Liste.Items[i])^.SensSaisie+' '+
                                               PImport_Plan(Liste.Items[i])^.Collectif+' '+
                                               PImport_Plan(Liste.Items[i])^.U1+' '+
                                               PImport_Plan(Liste.Items[i])^.U2+' '+
                                               PImport_Plan(Liste.Items[i])^.Immo);
                              end;
                            end;
                         end;
                        if ListeErreur.Count=0 then
                         ListeErreur.Add(IntToStr(Liste.count)+' compte de la balance d''ouverture Epicea-2 DOS importés avec succès !');
                        ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CPLC_BAL_JNL.TXT');
                        Liste.Free;
                        ListeErreur.Free;
                        TaResultImport.Open;
//                        showmessage('Fin de l''importation de la balance d''ouverture !');
                                         End;

   end;

//
//TaResultImport
End;

Function TDMImport.Import_BalanceOuverture(DataSet:TDataSet;Confirmation:Boolean):Boolean;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 MtDebit,MtCredit:Currency;
 Compte,Libelle,U1,U2,CodeTVa:String;
 TvaDebit,SensCredit,Collectif,Immobilisation,Pointable:Boolean;
 MtBilanOuvertureImport:TMtBilanOuvertureImport;
 TypeEtatExerciceTmp:TTypeEtatExercice;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
    DMPlan.TaPlanBO.BeforeEdit := nil;
    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
    if FileExistDialog(E.RepertoireImportCourante,'E3-CPLC.TXT',true) then
       begin
         ImportationPlanEPI_DOS_ENTIER(E.RepertoireImportCourante+'E3-CPLC.TXT',Liste);
         for i:=0 to Liste.Count-1 do
          begin
            try
              Compte:=QueDesChiffres(PImport_Plan(Liste.Items[i])^.Compte);
              MtBilanOuvertureImport:=TMtBilanOuvertureImport.Create(self);
              Libelle:=PImport_Plan(Liste.Items[i])^.Libelle;
              MtDebit:=StrToCurr_Lgr(ChangeDecimalSeparator(str_supprespaces(PImport_Plan(Liste.Items[i])^.BilanOuvDebit)));
              MtCredit:=StrToCurr_Lgr(ChangeDecimalSeparator(str_supprespaces(PImport_Plan(Liste.Items[i])^.BilanOuvCredit)));

              MtBilanOuvertureImport.Libelle :=Libelle;
              MtBilanOuvertureImport.MtDebit :=MtDebit;
              MtBilanOuvertureImport.MtCredit :=MtCredit;
              if (not str_commence_par(Compte,'6') and not str_commence_par(Compte,'7')) then
               begin
                  DMPlan.Import_BilanOuverture([Compte,
                                                nil,
                                                MtDebit,
                                                MtCredit],
                                                DataSet);
               end;
            except
             ListeErreur.Add(Compte+' '+
                             Libelle+' '+
                             PImport_Plan(Liste.Items[i])^.BilanOuvDebit+' '+
                             PImport_Plan(Liste.Items[i])^.BilanOuvCredit+' '+
                             PImport_Plan(Liste.Items[i])^.CodeTVA+' '+
                             PImport_Plan(Liste.Items[i])^.TypeTVA+' '+
                             PImport_Plan(Liste.Items[i])^.SensSaisie+' '+
                             PImport_Plan(Liste.Items[i])^.Collectif+' '+
                             PImport_Plan(Liste.Items[i])^.U1+' '+
                             PImport_Plan(Liste.Items[i])^.U2+' '+
                             PImport_Plan(Liste.Items[i])^.Immo);
            end;
          end;
       end;
      if ListeErreur.Count=0 then
       ListeErreur.Add(IntToStr(Liste.count)+' compte de la balance d''ouverture Epicea-2 DOS importés avec succès !');
      ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'E3-CPLC_BAL_JNL.TXT');
      Liste.Free;
      ListeErreur.Free;
      showmessage('Fin de l''importation de la balance d''ouverture !');
except
end;
finally
    DMPlan.TaPlanBO.BeforeEdit := DMPlan.TaPlanBOBeforeEdit;
    E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;
End;

//End;

procedure TDMImport.TaResultImportCalcFields(DataSet: TDataSet);
var
i:integer;
TotauxBalance:TTotauxBalance;
begin
  if(ListeCompteBilanOuverture<>nil)then
  begin
      i:=ListeCompteBilanOuverture.IndexOf(TaResultImportCompte.AsString);
      //if TaResultImportCompte.AsString = '131' then
      // showmessage('131 '+IntToStr(ListeCompteBilanOuverture.IndexOf(TaResultImportCompte.AsString)));
      TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(e.DatExoDebut,e.DatExoFin,TaResultImport.findfield('').AsString,false);
      TaResultImportSoldeDebitReport.AsCurrency:=TotauxBalance.TotalSoldeDebitReport;
      TaResultImportSoldeCreditReport.AsCurrency:=TotauxBalance.TotalSoldeCreditReport;
      TaResultImportLibelle.AsString:=DMPlan.LibelleDuNumCpt(TaResultImportCompte.AsString) ;
      if i <> -1 then
       begin
        TaResultImportSoldeDebitBalImport.AsCurrency :=TMtBilanOuvertureImport(ListeCompteBilanOuverture.Objects[i]).MtDebit;
        TaResultImportSoldeCreditBalImport.AsCurrency :=TMtBilanOuvertureImport(ListeCompteBilanOuverture.Objects[i]).MtCredit;
       end;
   end;
end;

procedure TDMImport.TaResultImportFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  accept := ListeFiltreCompteBilanOuverture.IndexOf(TaResultImportCompte.AsString) <> -1;
end;

Procedure TDMImport.AffichRapportImport(ListeFichier:TStringList;ViewList:TListView);
var
ListeFichierImport,ListeFichierImport2:TStringList;
i:integer;
Begin
  ListeFichierImport:=TStringList.Create;
  ListeFichierImport2:=TStringList.Create;
  if VisuListeView = nil then VisuListeView:=TVisuListeView.create(Application.MAinForm);
  VisuListeView.ListView1.Items.Clear;
  VisuListeView.ListView1.Columns.Clear;
  if ListeFichier = nil then
    ListeFichierImport2 := ListeFic('*.txt',CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS),1,False,False)
  else
    ListeFichierImport2.Assign(ListeFichier);
//  ListeFichierImport2 := ListeFichier;//il faut assigner sinon les deux listes pointe sur le même espace mémoire et
//à la libération de l'un on libère à moitié l'autre d'où les problèmes de libération de liste par la suite

  VisuListeView.ListView1.Columns.Add.Caption :='Etat général de l''importation';
  VisuListeView.ListView1.Column[0].Width := 500;
  For i:=0 to ListeFichierImport2.Count-1 do
   begin
     ListeFichierImport.LoadFromFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+ListeFichierImport2.Strings[i]);
     ListeFichierImport.Insert(0,'        '+ListeFichierImport2.Strings[i]);
     if ViewList = nil then
      InitLisViewAvecListe(VisuListeView.ListView1,[''],[ListeFichierImport],false)
     else InitLisViewAvecListe(ViewList,[''],[ListeFichierImport],FAlse)
   end;
  if ViewList = nil then VisuListeView.ShowModal;
Initialise_TStringlist(ListeFichierImport2);
Initialise_TStringlist(ListeFichierImport);
End;


function TDMImport.AfficheListe_PieceImportExistante(ListePiece:Tstringlist;ID_Programme:integer):Tstringlist;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 filtre:string;
 Exception:TExceptLGR;
begin
try//except
filtre:='';
  if ((listePiece<>nil)and(listePiece.Count<>0)) then
    begin//si liste non vide
      Initialise_ExceptLGR(Exception,GestMessageLGR);
      //Exception.GestMessageLGR:=GestMessageLGR;
      Exception.NomModule:='AfficheListe_PieceImport';
      result:=TStringList.Create;   // ID,,,,,,ID_Prog
      case ID_Programme of
        C_IMPORT_BLOQUEL:DMImport.Ta_PieceImportExistante.OnFilterRecord:=Ta_PieceImportExistanteFilterRecordPourBLOQUEL;
        C_IMPORT_Sara,C_IMPORT_CAISSE,C_IMPORT_CAISSEBis,
        C_IMPORT_E2_Fac:DMImport.Ta_PieceImportExistante.OnFilterRecord:=Ta_PieceImportExistanteFilterRecordPourE2_Fac_et_Sara;
      end;//fin du case  ID_Programme
      ListePieceImportExistanteFilterRecord.Assign(listePiece);
      //      CreeFiltreOU('Libelle',[listePiece]);
//      if filtre='-1' then
//       raise ExceptLGR.Create('Le filtre est mal construit ',1000,true,mtError,Exception);
      filtre:='(ID_Prog = '''+inttostr(ID_Programme)+''' )';
      FiltrageDataSet(DMImport.Ta_PieceImportExistante,filtre);
      result:=ChampTableVersListeEx(['ID_Piece_Import','Libelle','Compte','Reference'],DMImport.Ta_PieceImportExistante,';',true);
      ReEnableControls(DMImport.Ta_PieceImportExistante);
      Initialise_TParamAffichage(ParamAffichage);
      ParamAffichage.AffichModal := true;
      ParamAffichage.Titre:='Ces Pièces ont déjà été importées';
      ParamAffichage.GestionAffichForm.Caption := 'Pièces déjà importées';
      //Compte:=
      if result.Count<>0 then
        AfficheVisuListView(ParamAffichage,['ID Import','Ref. Importee','Compte','Référence Epicea W'],
                                         [100,100,100,100],//[200,250,40,150]
                                         [result],
                                         [taLeftJustify,taRightJustify,taRightJustify,taRightJustify],
                                         [2..4],
                                         [1],[0]);
      for i:=0 to result.Count-1 do
        begin
          case ID_Programme of
            C_IMPORT_BLOQUEL:result.Strings[i]:=str_getstringelement(result.Strings[i],2,';');
            else result.Strings[i]:=str_getstringelement(result.Strings[i],2,';');
          end;//fin du case id_Programme

        end;
    end;//fin si liste non vide
except
  abort;
end;//fin except
end;


Procedure TDMImport.EnregistreNouvellePieceImporte(NouvellePiece:TInfosPiece_Import);
begin
//
try//except
  if dmimport.TaPiece_Deja_Importee.active=false then dmimport.TaPiece_Deja_Importee.open;
  TableGereStartTransaction(dmimport.TaPiece_Deja_Importee);
  NouvellePiece.ID:=MaxId_Query(dmimport.TaPiece_Deja_Importee,'ID');
  dmimport.TaPiece_Deja_Importee.AppendRecord([NouvellePiece.ID,
                                                 NouvellePiece.ID_Piece_Import,
                                                 NouvellePiece.Nouvel_ID_Piece,
                                                 NouvellePiece.compte,
                                                 NouvellePiece.Libelle,
                                                 abs(NouvellePiece.Debit),
                                                 abs(NouvellePiece.Credit),
                                                 NouvellePiece.ID_Prog]);
  dmimport.TaPiece_Deja_Importee.FlushBuffers;
except
  TableGereRollBack(dmimport.TaPiece_Deja_Importee);
  abort;
end;//fin except

end;



Procedure TDMImport.AffichRapportImport_Isa(ListeFichier:TStringList;ViewList:TListView;ParamAffich:TParamAffichage);
var
ListeFichierImport,ListeFichierImport2:TStringList;
i:integer;
Begin
  ListeFichierImport:=TStringList.Create;
  ListeFichierImport2:=TStringList.Create;
  if VisuListeView = nil then VisuListeView:=TVisuListeView.create(Application.MAinForm);
  VisuListeView.ListView1.Items.Clear;
  VisuListeView.ListView1.Columns.Clear;
  VisuListeView.PaBas.Visible:=false;
  VisuListeView.Caption:=ParamAffich.Titre;
  VisuListeView.RxLabTitre.Caption:=ParamAffich.TitrePetit;
  if ListeFichier = nil then
    ListeFichierImport2 := ListeFic('*.txt',CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS),1,False,False)
  else
  ListeFichierImport2.Assign(ListeFichier);
//  ListeFichierImport2 := ListeFichier;

  VisuListeView.ListView1.Columns.Add.Caption :='Etat général de l''importation';
  VisuListeView.ListView1.Column[0].Width := 500;
  For i:=0 to ListeFichierImport2.Count-1 do
   begin
     ListeFichierImport.LoadFromFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+ListeFichierImport2.Strings[i]);
     ListeFichierImport.Insert(0,'        '+ListeFichierImport2.Strings[i]);
     if ViewList = nil then
      InitLisViewAvecListe(VisuListeView.ListView1,[''],[ListeFichierImport],false)
     else InitLisViewAvecListe(ViewList,[''],[ListeFichierImport],FAlse)
   end;
  if ViewList = nil then
  begin
    //
    VisuListeView.ShowModal;
  end;
Initialise_TStringlist(ListeFichierImport2);
Initialise_TStringlist(ListeFichierImport);
End;

Function TDMImport.Import_Immo_SIEA2I(DataSet:TDataSet;Confirmation:Boolean;NomFicBal:String;var CheminImport,NomFicImmos:String):Texceptlgr;
var
 i:integer;
 Liste:TList;
 ListeErreur:TStringList;
 InfosImmos:TInfosImmos;
 DateCession:string;
// Journal,Libelle,CodeInterne,Nom,Compte:String;
 TypeEtatExerciceTmp:TTypeEtatExercice;
// NomFichier:String;
 IndexDelimiter:Integer;
 paramFichierImmos:TparamFichier;
Begin
Initialise_ExceptLGR(Result);
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMJournal = nil then
         DMJournal:=TDMJournal.Create(Application.MainForm);

  if DMImmos_Ouverture = nil then
         DMImmos_Ouverture:=TDMImmos_Ouverture.Create(Application.MainForm);

  try
//  showmessage(inttostr(AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationSIEA)));
//    if E.RepertoireImportCourante <> E.RepertoireImportationSIEA then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationSIEA)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationSIEA;

      if ChoisirRepImportation(E.RepertoireImportCourante,'SIEA DOS') then
       E.RepertoireImportationSIEA := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les Immobilisations de SIEA2I DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
//    paramFichierImmos.Repertoire:=CheminImport;
    if ChercheFileDialog(CheminImport,NomFicImmos,'Fichiers export SIEA (*.asc)|*.asc',true,'Indiquez le fichier des immobilisations.') then
//    if FileExistDialog(E.RepertoireImportEPI_DOS,'Leglis.ASC',true) then
     begin
       ImportationImmo_SIEA2I(CheminImport+NomFicImmos,Liste);
       // On passe le nom du fichier de la balance
       paramFichierImmos.NomFichierBal := NomFicBal;
       paramFichierImmos.NomFichier := NomFicImmos;
       paramFichierImmos.Repertoire := CheminImport;

       if AffichAffectImmosCptCOGERE(Liste,paramFichierImmos) then
        begin
           for i:=0 to Liste.Count-1 do
    //       for i:=-1 to -2 do
            begin
              try
               Initialise_TInfosImmos(InfosImmos);
               DMImmos_Ouverture.Importation:=true;
               // Affectation des valeurs
               InfosImmos.Libelle:=str_ImportDosToWin(PImport_CIMO_SIEA2I(Liste.Items[i])^.Designation);
               InfosImmos.Ecriture_Achat:=0;
               InfosImmos.Ecriture_Cession:=0;
               InfosImmos.Compte:=PImport_CIMO_SIEA2I(Liste.Items[i])^.NumCpt;
               InfosImmos.Duree:=StrToInt_Lgr(trim(PImport_CIMO_SIEA2I(Liste.Items[i])^.DureeTotale));
               InfosImmos.Duree:=InfosImmos.Duree*12;
               InfosImmos.Valeur_a_Amortir:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_CIMO_SIEA2I(Liste.Items[i])^.ValeurAAmortir)));
               if DateValide(PImport_CIMO_SIEA2I(Liste.Items[i])^.DateAchatPourReel) then
               //par défaut, la DateAchatPourReel est initialisé avec la date_Achat sauf s'il y a une date de changement
               //dans ce cas, elle prend la date de changement  { isa  le  17/02/04 fait avec denis}
               InfosImmos.Date_Mise_en_Service:=strtodate_Lgr(PImport_CIMO_SIEA2I(Liste.Items[i])^.DateAchatPourReel);

               if DateValide(PImport_CIMO_SIEA2I(Liste.Items[i])^.DateAchat) then
               InfosImmos.Date_Achat:=strtodate_Lgr(PImport_CIMO_SIEA2I(Liste.Items[i])^.DateAchat);
               if InfosImmos.Date_Org=0 then InfosImmos.Date_Org:=InfosImmos.Date_Achat;
              // InfosImmos.Date_Mise_en_Service:=InfosImmos.Date_Achat; { isa  le  17/02/04 fait avec denis}
               if InfosImmos.Valeur_a_Amortir=0 then
                 begin
                     InfosImmos.Duree_Amt:=0;
                     InfosImmos.Type_Amt:='N';
                     InfosImmos.Valeur_Nette:=0;
                     InfosImmos.Amort_Eco:=0;
                     InfosImmos.Amort_Derog:=0;
                 end
               else
                 begin
                     InfosImmos.Duree_Amt:=InfosImmos.Duree;
                     InfosImmos.Type_Amt:=PImport_CIMO_SIEA2I(Liste.Items[i])^.TypeFiscal;
                     InfosImmos.Valeur_Nette:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_CIMO_SIEA2I(Liste.Items[i])^.ValeurNetteComptable)));
                     if InfosImmos.Valeur_Nette>InfosImmos.Valeur_a_Amortir then
                       raise ExceptLGR.Create('La valeur nette de l''immobilisation '+InfosImmos.Compte+'  '+InfosImmos.Libelle+' est supérieur à la valeur à amortir',1000,true,mtError,Result);
                     InfosImmos.Amort_Eco:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_CIMO_SIEA2I(Liste.Items[i])^.AmortEco)));
                     if InfosImmos.Amort_Eco>InfosImmos.Valeur_a_Amortir then
                       raise ExceptLGR.Create('L''amortissement économique d''ouverture de l''immobilisation '+InfosImmos.Compte+'  '+InfosImmos.Libelle+' est supérieur à la valeur à amortir',1000,true,mtError,Result);
                     InfosImmos.Mt_Cession:=StrToCurr_Lgr(trim(ChangeDecimalSeparator(PImport_CIMO_SIEA2I(Liste.Items[i])^.MontantCession)));
                 end;
               InfosImmos.Achat_dans_Annee:=false;
               InfosImmos.Cession_dans_Annee:=false;
               if InfosImmos.Mt_Cession=0 then DateCession:='';
               if DateValide(PImport_Immo(Liste.Items[i])^.DateCession) then
                 begin
                   DateCession:=PImport_Immo(Liste.Items[i])^.DateCession;
                 end;
           if InfosImmos.Amort_Derog<>0 then
             begin
              ModifChampDerogatoire;
              e.Derogatoire:=true;
             end;
               if DateValide(PImport_CIMO_SIEA2I(Liste.Items[i])^.DateCession) then
               InfosImmos.Date_Cession:=strtodate_Lgr(PImport_CIMO_SIEA2I(Liste.Items[i])^.DateCession);
               DMImmos_Ouverture.TypechoisiPourCompte.choisi:=true;
               DMImmos_Ouverture.TypechoisiPourCompte.compte:=InfosImmos.Compte;
                DMImmos_Ouverture.ImportImmos([InfosImmos.ID,
                                               InfosImmos.Libelle,
                                               nil,
                                               nil,
                                               InfosImmos.Compte,
                                               InfosImmos.Code,
                                               InfosImmos.Sous_Code,
    //                                           nil,
                                               datetostr(InfosImmos.Date_Org),
                                               InfosImmos.Valeur_Org,
                                               InfosImmos.Valeur_Venale,
                                               InfosImmos.Duree,
                                               InfosImmos.Valeur_a_Amortir,
                                               datetostr(InfosImmos.Date_Achat),
                                               datetostr(InfosImmos.Date_Mise_en_Service),
                                               InfosImmos.Duree_Amt,
                                               InfosImmos.Type_Amt,
                                               InfosImmos.Deduc_Invest,
                                               InfosImmos.Mt_Deduc_Invest,
                                               nil,
                                               InfosImmos.Valeur_Nette,
                                               InfosImmos.Amort_Eco,
                                               InfosImmos.Amort_Derog,
                                               InfosImmos.Mt_Cession,
                                               DateCession,
                                               InfosImmos.Rebut,
                                               nil,
                                               nil,
                                               InfosImmos.Duree_Restante,
                                               InfosImmos.Simulation,
                                               nil,
                                               nil,
                                               nil,
                                               nil,
                                               nil,
                                               nil,
                                               nil,
                                               nil,
                                               nil,
                                               InfosImmos.TauxAmo,
                                               nil,
                                               nil,
                                               nil
                                               ],DataSet);

              except
                showmessage('L"immobilisation  '+str_supprespaces(PImport_Immo(Liste.Items[i])^.NumCpt)+' '+PImport_Immo(Liste.Items[i])^.CodeImmo+' '+trim(PImport_Immo(Liste.Items[i])^.SousCodeImmo)+' n"a pas pu être importée correctement, voir liste des erreurs');
                ListeErreur.Add(str_supprespaces(PImport_Immo(Liste.Items[i])^.NumCpt)+' '+
                                PImport_Immo(Liste.Items[i])^.CodeImmo+' '+
                                PImport_Immo(Liste.Items[i])^.SousCodeImmo+' '+
                                PImport_Immo(Liste.Items[i])^.Designation+' '+
                                PImport_Immo(Liste.Items[i])^.DateOrg+' '+
                                PImport_Immo(Liste.Items[i])^.ValeurAvantReel+' '+
                                PImport_Immo(Liste.Items[i])^.ValeurVenale+' '+
                                PImport_Immo(Liste.Items[i])^.DureeTotale+' '+
                                PImport_Immo(Liste.Items[i])^.ValeurAAmortir+' '+
                                PImport_Immo(Liste.Items[i])^.TvaOrg+' '+
                                PImport_Immo(Liste.Items[i])^.DateAchatPourReel+' '+
                                PImport_Immo(Liste.Items[i])^.DateMiseEnService+' '+
                                PImport_Immo(Liste.Items[i])^.NbMoisAmort+' '+
                                PImport_Immo(Liste.Items[i])^.TypeEco+' '+
                                PImport_Immo(Liste.Items[i])^.TypeFiscal+' '+
                                PImport_Immo(Liste.Items[i])^.TauxLineaire+' '+
                                PImport_Immo(Liste.Items[i])^.TauxDegressif+' '+
                                PImport_Immo(Liste.Items[i])^.DeducSurInvest+' '+
                                PImport_Immo(Liste.Items[i])^.MontantDeducSurInvest+' '+
                                PImport_Immo(Liste.Items[i])^.ValeurNetteComptable+' '+
                                PImport_Immo(Liste.Items[i])^.AmortEco+' '+
                                PImport_Immo(Liste.Items[i])^.AmortDerogNonGere+' '+
                                PImport_Immo(Liste.Items[i])^.AmortDerog+' '+
                                PImport_Immo(Liste.Items[i])^.AmortExcept+' '+
                                PImport_Immo(Liste.Items[i])^.MontantCession+' '+
                                PImport_Immo(Liste.Items[i])^.DateCession+' '+
                                PImport_Immo(Liste.Items[i])^.Rebus+' '+
                                PImport_Immo(Liste.Items[i])^.PMVCourtTerme+' '+
                                PImport_Immo(Liste.Items[i])^.PMVLongTerme+' '+
                                PImport_Immo(Liste.Items[i])^.TVAAReintegreSurVente+' '+
                                PImport_Immo(Liste.Items[i])^.MontantTVAAReintegreSurVente+' '+
                                PImport_Immo(Liste.Items[i])^.DureeDegressif+' '+
                                PImport_Immo(Liste.Items[i])^.Simulation+' '+
                                PImport_Immo(Liste.Items[i])^.Economique);
              end;
            end;
        end
       else
        begin
         abort;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' Immobilisations d''Epicea-2 DOS importés avec succès !');
//     IndexDelimiter :=LastDelimiter('\',paramFichierImmos.NomFichier);
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_SIEA)+ChangeExtensionFichier(NomFicImmos,'txt'));
//    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireImportEPI_DOS,'JOURNAL-')+'E3-CIMO_JNL.TXT');
    Liste.Free;
    ListeErreur.Free;
    showmessage('Fin de l''importation des Immobilisations !');
  end;
except;
showmessage('Erreur importation Immobilisations !');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;


function SuppressionPieceImportee(idPiece:integer):TExceptLGR;
begin
    try
    if DMImport=nil then DMImport:=TDMImport.Create(application.MainForm);
    result.NumErreur:=0;
    result.retour:=true;
    defiltrageDataset(DMImport.Ta_PieceImportExistante );
    if DMImport.Ta_PieceImportExistante.Locate('Nouvel_ID_Piece',idPiece,[]) then
      DMImport.Ta_PieceImportExistante.delete;
    except
      result.retour:=false;
      abort;
    end;
end;


Function TDMImport.Import_Trame(DataSet:TDataSet;Confirmation:Boolean;NomFichier:string):Boolean;
var
listePieceAImporter,ListePieceAEnlever:Tstringlist;
ValPieceAutoGen:TValPieceAutoGenere;
AnneeAnterieure:TPieceAnterieure;
 i:integer;
 ListeMaitreImport,ListeEsclaveImport:TList;
 ListeErreur:TStringList;
 Tiers,Nom,Compte,TypeTiers,message_:String;
ErreurImportTrame:TExceptLGR_ImportPiece;
NouvellePiece:TInfosPiece_Import;
ParamAffichage:TParamAffichage;
 TypeEtatExerciceTmp:TTypeEtatExercice;
 ListeCree:Tstringlist;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMPieces = nil then DMPieces:=TDMPieces.Create(Application.MainForm);
  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationEpiDos then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationEpiDos)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationEpiDos;

      if ChoisirRepImportation(E.RepertoireImportCourante,'EPICEA-2 DOS') then
       E.RepertoireImportationEpiDos := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

  if Messagedlg_lgr(PChar('Êtes-vous sûr de vouloir importer les trames d''Epicéa-2 DOS ?'),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
     /////// gère la suppression des trames avant importation
       DeFiltrageDataSet(DMTrame.TaTrame);
       DMTrame.TaTrame.first;
       while DMTrame.TaTrame.RecordCount<>0 do
         Begin
           TableGereDelete(DMTrame.TaTrame);
         end;
     /////
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;
    DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
    ListeCree:=Tstringlist.create;
       DMImport.VerifCreationPieceEcriture;
    DMImport.Piece_Import.NouvellePiece(false);

    AnneeAnterieure.PieceAnterieure:=false;
//    AnneeAnterieure.ExoAnterieure:='02';
    ValPieceAutoGen.Table_Gen:='Importation Trame';
    ValPieceAutoGen.Champ_Gen:=NomFichier;
    ValPieceAutoGen.Val_Champ_Gen:=';'+Nous;
    message_:='';
    if FileExistDialog(E.RepertoireImportCourante,'\E3-Ctrx.txt',true) then //on traite la liste des pièces
     begin//si fichier d'exportation DOS existe
       ImportationTrameEPI_DOS(E.RepertoireImportCourante+'\E3-Ctrx.txt',ListeMaitreImport);
       if FileExistDialog(E.RepertoireImportCourante,'\E3-Ctra.txt',true) then //on traite la liste des écritures
         begin //si fichier d'exportation Ecritures DOS existe
            ImportationLigneTrameEPI_DOS(E.RepertoireImportCourante+'\E3-Ctra.txt',ListeEsclaveImport);
            listePieceAImporter:=TStringList.Create;
            ListePieceAEnlever:=TStringList.Create;
//            for i:=0 to ListeMaitreImport.Count -1 do
//              listePieceAImporter.Add(inttostr(PRecordPiece(ListeMaitreImport.Items[i])^.ID));
//            ListePieceAEnlever:=AfficheListe_PieceImportExistante(listePieceAImporter);
            for i:=0 to ListeMaitreImport.Count-1 do
             begin//début boucle for
               try
                 ErreurImportTrame:=DMPieces.ImportTrame(PImportTrame(ListeMaitreImport.Items[i])^,ListeEsclaveImport,AnneeAnterieure,ValPieceAutoGen,nil);
                 ListeCree.add(PImportTrame(ListeMaitreImport.Items[i])^.CodeTrame);
                 ListeErreur.Add('La trame '+PImportTrame(ListeMaitreImport.Items[i])^.CodeTrame+' - '+PImportTrame(ListeMaitreImport.Items[i])^.Libelle +' a été importée avec succès') ;
                 TableGereCommit(DMImport.Piece_Import.TablePiece);
                 TableGereCommit(DMBalance.TaBalance);
               except
                  ListeErreur.Add('La trame '+PImportTrame(ListeMaitreImport.Items[i])^.CodeTrame+' - '+PImportTrame(ListeMaitreImport.Items[i])^.Libelle+' n"a pas pu être importée pour la raison suivante : '+ErreurImportTrame.Mess);
               end;//fin du try except
             end;//fin boucle for
         end;//fin si fichier d'exportation Ecritures DOS existe
     end;//fin si fichier d'exportation DOS existe
    if ListeErreur.Count=0 then
      ListeErreur.Add(IntToStr(ListeMaitreImport.count)+' Trame Epicea-2 DOS importés avec succès !');
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_EPIDOS)+'Import_Trame.TXT');
     { isa  le  11/08/04 }
      {Nettoyage :libère les éléments de la liste }
      Initialise_TList(ListeMaitreImport);
      Initialise_TList(ListeEsclaveImport);
    { isa  le  11/08/04 }
    Initialise_TStringlist(listeErreur,DMImport,false);
//    ListeErreur.Clear;
    //affichage des pièces créées
    if ((ListeCree<>nil )and(ListeCree.count<>0)) then
      begin
//        DMPieces.AffichageFeuilleReprise(0,ListeCree,nil,'Affichage des nouvelles Trame créées','','',false);
//        message_:='';
      end
    else
       message_:='Aucune trame n''a été importée.'+#13+#10+''+#13+#10;
    if Messagedlg_lgr(message_+'Souhaitez-vous visualiser le rapport d''importation ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
      begin
        ListeErreur.Add('Import_Trame.TXT');
        Initialise_TParamAffichage(ParamAffichage);
        ParamAffichage.AffichModal := true;
        ParamAffichage.Titre:='Rapport d''importation des trames';
        ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
        DMImport.AffichRapportImport_Isa(ListeErreur,nil,ParamAffichage);
      end;
      Initialise_TStringlist(ListeErreur);
      Initialise_TStringlist(ListeCree);
  end;
except;
if dmtrame<>nil then
  dmtrame.SupprLigneTrame(dmtrame.Trame1.IDTrame);
TableGereRollBack(DMImport.Piece_Import.TablePiece);
TableGereRollBack(DMBalance.TaBalance);
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;


Function TDMImport.Import_SoldeCptImmos_SIEA_DOS(var Repertoire,NomFichier:string;Dataset:TDataset):Tstringlist;
var
 i:integer;
 IndexDelimiter:integer;
 Liste:TList;
 ListeErreur:TStringList;
 Compte:String;
 TvaDebit,SensCredit,Collectif,Immobilisation,Pointable:Boolean;
 TypeEtatExerciceTmp:TTypeEtatExercice;
 ReportDebit,ReportCredit:Currency;
Begin
try//finally
try//except
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMPlan = nil then
         DMPlan:=TDMPlan.Create(Application.MainForm);

  try
//    if E.RepertoireImportCourante <> E.RepertoireImportationSIEA then
   if AnsiCompareFileName(E.RepertoireImportCourante,E.RepertoireImportationSIEA)<>0 then
     begin
      E.RepertoireImportCourante:=E.RepertoireImportationSIEA;

      if ChoisirRepImportation(E.RepertoireImportCourante,'SIEA DOS') then
       E.RepertoireImportationSIEA := E.RepertoireImportCourante;
     end;
  except
    abort;
  end;

    Liste:=TList.Create;
    ListeErreur:=TStringList.Create;
    result:=TStringList.Create;
    ListeErreur.Clear;
    if ChercheFileDialog(Repertoire,NomFichier,'Fichiers export SIEA (*.asc)|*.asc',true,'Indiquez le fichier de la balance.') then
     begin

       ImportationBO_SIEA_DOS(Repertoire+NomFichier,Liste);
       for i:=0 to Liste.Count-1 do
        begin
          Compte:=PImport_BO_SIEA_DOS(Liste.Items[i])^.Compte;
          Compte:=str_supprespaces(Compte);
          
////
           while ((length(Compte)>3) and (not DAtaSet.Locate('Compte',Compte,[]))) do
             begin
              if ((not DAtaSet.Locate('Compte',Compte,[])) and (copy(Compte,length(Compte),1)='0')) then
               begin
                Delete(Compte,length(Compte),1);
               end
               else
                exit;
             end;
////
          //on ne récupère les soldes que pour les comptes d'immos sans prendre en compte les comptes
          //d'amortissement
          if ((((copy(compte,1,2) ='13')or(copy(compte,1,1) ='2')))and
              not(((copy(compte,1,2) ='28')or(copy(compte,1,3) ='139'))))then
            Begin
//                ReportDebit:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportDebit));
//                ReportCredit:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportCredit));

          ReportDebit:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportDebit))+StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.MvtDebit));
          ReportCredit:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportCredit))+StrToCurr_Lgr(ChangeDecimalSeparator(PImport_BO_SIEA_DOS(Liste.Items[i])^.MvtCredit));

                DetermineSolde(ReportDebit,ReportCredit);
                try
                result.Add(Compte+';'+currtostr(ReportDebit)+';'+currtostr(ReportCredit)+';')
                except
                 ListeErreur.Add(Compte+' '+
                                 PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportDebit+' '+
                                 PImport_BO_SIEA_DOS(Liste.Items[i])^.ReportCredit);
                end;
            end;
        end;
     end;
    if ListeErreur.Count=0 then
     ListeErreur.Add(IntToStr(Liste.count)+' compte de la Balance d''Ouverture SIEA DOS importés avec succès !');
     IndexDelimiter :=LastDelimiter('\',NomFichier);
    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_SIEA)+ChangeExtensionFichier('3'+NomFichier,'txt'));
//    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireImportEPI_DOS,'JOURNAL-')+ChangeExtensionFichier(ExtractFieldName(NomFichier,IndexDelimiter),'txt'));
    Liste.Free;
    ListeErreur.Free;

//    showmessage('Fin de l''importation de la Balance d''Ouverture de SIEA DOS!');
  //end;
except;
showmessage('La récupération des soldes de la balance pour les comptes immobilisables '+RetourChariotSimple+'n''a pas pu s''effectuer correctement');
//showmessage('Erreur durant l''importation de la Balalnce d''Ouverure de SIEA DOS');
abort;
end;
finally
E.TypeEtatExercice:=TypeEtatExerciceTmp;
end;//fin finally
End;

Function ImportationPointageEPI_DOS(FichierImport:TList;Var ListePointage:TList;ListeErreur:Tstringlist;TypeImport:integer):TExceptLGR_ImportPiece;
var
  Import_Pointage:Pinfos_Pointage;
  i,J:Integer;
  CodeTva,CodeTvaCorrespondant:string;
  TotalTva:currency;
  conteneur:currency;
begin
try//finally
Try//except
 ListePointage:=Tlist.create;
 ListePointage.Clear;

 GestMessageLGR.ModeTrace:=true;
// result.Erreur.GestMessageLGR:=GestMessageLGR;
Initialise_ExceptLGR(Result.erreur,GestMessageLGR);
 result.Erreur.NomModule:='Fichier des pointages';
 result.Erreur.GestMessageLGR.Enregistrement:=true;
 result.Erreur.NomDossier:=e.NomDossier;

 if FichierImport.Count=0 then
     raise ExceptLGR.Create('Le fichier des pointage est vide',1003,true,mtError,result.Erreur);
 for i:=0 to FichierImport.Count-1 do
  begin
  if (PImport_E2FAC(FichierImport.Items[i])^.TypePiece[1]='P') then
    begin
       try
         new(Import_Pointage);
         initialise_TInfosPointage(Import_Pointage);
         Import_Pointage.RefCredit:=trim(PImport_E2FAC(FichierImport.Items[i])^.Reference);
         Import_Pointage.RefDebit:=trim(PImport_E2FAC(FichierImport.Items[i])^.RefContrepartie);
         Import_Pointage.DateMaitre:=StrToDate_Lgr(PImport_E2FAC(FichierImport.Items[i])^.DatePiece);
         Import_Pointage.DateEsclave:=StrToDate_Lgr(PImport_E2FAC(FichierImport.Items[i])^.DateContrepartie);
         conteneur:=StrToCurr_Lgr(PImport_E2FAC(FichierImport.Items[i])^.MontantDebitContrepartie)+StrToCurr_Lgr(PImport_E2FAC(FichierImport.Items[i])^.MontantCreditContrepartie) ;
         Import_Pointage.MontantDebit:=conteneur;
         conteneur:=StrToCurr_Lgr(PImport_E2FAC(FichierImport.Items[i])^.MontantDebit)+StrToCurr_Lgr(PImport_E2FAC(FichierImport.Items[i])^.MontantCredit) ;
         Import_Pointage.MontantCredit:=conteneur;
         conteneur:=StrToCurr_Lgr(PImport_E2FAC(FichierImport.Items[i])^.MontantPointage) ;
         Import_Pointage.MontantPointage:=conteneur;
         Import_Pointage.Tiers:=trim(PImport_E2FAC(FichierImport.Items[i])^.CompteLigne);
         ListePointage.Add(Import_Pointage);
         PImport_E2FAC(FichierImport.Items[i])^.Enregistrer[1]:='1';
       except
          DMImport.RemplissageListeErreurSurImportationPiece(StrToInt_Lgr(PImport_E2FAC(FichierImport.Items[i])^.NumPiece),FichierImport,ListeErreur,result.Erreur);
       end;
    end;
  end;

except
  //abort;
end;//fin du try except
finally
  result.Erreur.GestMessageLGR.Enregistrement:=false;
//  Initialise_TStringlist(ListeCodeTva);
end;
End;

Function ImportationEcrituresEPI_DOS(FichierImport:TList;Var ListeEcritures:TList;ListeErreur:Tstringlist;TypeImport:integer):TExceptLGR_ImportPiece;
var
  //Import_Ecritures:PImport_Ecriture; //record déclaré dans DeclRecord
  Import_Ecritures:PRecordEcriture;
  i,J,k:Integer;
  CodeTva,CodeTvaCorrespondant:string;
  TotalTva:currency;
  ListeTvaCodePourCompte:TTvaCodePourCompte;
  trouve,ligneEstVide:boolean;

begin
try//finally
Try//except
 ListeEcritures:=Tlist.create;
 ListeEcritures.Clear;

 GestMessageLGR.ModeTrace:=true;
// result.Erreur.GestMessageLGR:=GestMessageLGR;
Initialise_ExceptLGR(Result.erreur,GestMessageLGR);
 result.Erreur.NomModule:='Fichier des ecritures';
 result.Erreur.GestMessageLGR.Enregistrement:=true;
 result.Erreur.NomDossier:=e.NomDossier;
 if FichierImport.Count=0 then
     raise ExceptLGR.Create('Le fichier des ecritures est vide',1002,true,mtError,result.Erreur);
 ligneEstVide:=false;
 for i:=0 to FichierImport.Count-1 do
  begin
  if (PImport_E2FAC(FichierImport.Items[i])^.TypePiece[1]<>'P')and
     ((trim(PImport_E2FAC(FichierImport.Items[i])^.NumLigne)<>'1')or(PImport_E2FAC(FichierImport.Items[i])^.TypePiece[1]='O')) then
    begin
       try
       // CompteColl => compte comptable raccroché à un tiers (ex: 401)
       // CompteLigne => Tiers si compteColl rempli, sinon compte comptable
       new(Import_Ecritures);
       Initialise_TRecordEcriture(Import_Ecritures^);
          if not empty(Trim(PImport_E2FAC(FichierImport.Items[i])^.CompteColl)) then
            Begin
              Import_Ecritures.Compte:=trim(PImport_E2FAC(FichierImport.Items[i])^.CompteColl);
              Import_Ecritures.CompteTiers:=Trim(PImport_E2FAC(FichierImport.Items[i])^.CompteLigne);
            end
          else
            Import_Ecritures.Compte:=Trim(PImport_E2FAC(FichierImport.Items[i])^.CompteLigne);

       Import_Ecritures.ID_Piece:=StrToInt_Lgr(PImport_E2FAC(FichierImport.Items[i])^.NumPiece);
       Import_Ecritures.Libelle:=Trim(PImport_E2FAC(FichierImport.Items[i])^.Libelle);
       if ((not empty(Import_Ecritures.Libelle))and(TypeImport=C_IMPORT_BLOQUEL)) then
         Import_Ecritures.Libelle:='Facture n° : '+PImport_E2FAC(FichierImport.Items[i])^.NumPiece+'_'+Trim(PImport_E2FAC(FichierImport.Items[i])^.Libelle);

       if not VerifNumeric(PImport_E2FAC(FichierImport.Items[i])^.MontantDebit).VideOUZero then
         Import_Ecritures.MontantHt:=-StrToCurr_Lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.MontantDebit))
       else
         Import_Ecritures.MontantHt:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.MontantCredit));
       if not VerifNumeric(PImport_E2FAC(FichierImport.Items[i])^.Qte1).VideOUZero then
         Import_Ecritures.Qt1:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.Qte1));
       if not VerifNumeric(PImport_E2FAC(FichierImport.Items[i])^.Qte2).VideOUZero then
         Import_Ecritures.Qt2:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.Qte2));

       if not VerifNumeric(PImport_E2FAC(FichierImport.Items[i])^.MontantDebitTVA).VideOUZero then
         Import_Ecritures.MontantTVA:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.MontantDebitTVA))
       else
         Import_Ecritures.MontantTVA:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.MontantCreditTVA));

       ligneEstVide:=(Import_Ecritures.MontantHt=0) and (Import_Ecritures.MontantTVA=0);

       if(not ligneEstVide)then
           begin //si ligne n'est pas vide
           Import_Ecritures.TypeLigne:='H';
           Import_Ecritures.TypeTVA:=PImport_E2FAC(FichierImport.Items[i])^.ExibiliteTVA;
           if empty(Import_Ecritures.TypeTVA) then Import_Ecritures.TypeTVA:='E';{ vu avec denis le  07/03/05 }
           if ((Import_Ecritures.TypeTVA<>'D')and(Import_Ecritures.TypeTVA<>'E'))then
             Import_Ecritures.TypeTVA:='E';
             //raise ExceptLGR.Create('Le type de tva '+Import_Ecritures.TypeTVA[1]+' ne correspond à aucun type connu',1001,true,mtError,result.Erreur);
           Import_Ecritures.DateTVA:=PImport_E2FAC(FichierImport.Items[i])^.DateLivraisonLigne;

           if not VerifNumeric(PImport_E2FAC(FichierImport.Items[i])^.TauxTVA).VideOUZero then
             Import_Ecritures.TauxTVA:=StrToCurr_Lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.TauxTVA));
           Import_Ecritures.NomTiers:=Trim(PImport_E2FAC(FichierImport.Items[i])^.NomTiers);
           if empty(Import_Ecritures.NomTiers)then
             Import_Ecritures.NomTiers:=copy(Import_Ecritures.CompteTiers,2,length(Import_Ecritures.CompteTiers)-1);
           Import_Ecritures.Addresse1:=PImport_E2FAC(FichierImport.Items[i])^.Adr1;
           Import_Ecritures.Addresse2:=PImport_E2FAC(FichierImport.Items[i])^.Adr2;
           Import_Ecritures.CodePostal:=PImport_E2FAC(FichierImport.Items[i])^.CodePostal;
           Import_Ecritures.Ville:=PImport_E2FAC(FichierImport.Items[i])^.Ville;
           CodeTva:='';
           if ((ord(PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1])=65)and(VerifNumeric(PImport_E2FAC(FichierImport.Items[i])^.TauxTVA).VideOUZero))then
               raise ExceptLGR.Create('Pour un Code TVA intracommunautaire, le taux est obligatoire.'+RetourChariotSimple+
           'La pièce '+PImport_E2FAC(FichierImport.Items[i])^.Reference+' ne peut pas être créée',1001,true,mtError,result.Erreur);
           if ((ord(PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1])=77))then
           begin
              if(Import_Ecritures.MontantTVA<>0) and (Import_Ecritures.MontantHt<>0)then
               begin
                   Import_Ecritures.TauxTVA:=(100*Import_Ecritures.MontantTVA)/Import_Ecritures.MontantHt;
               end;
               if(Import_Ecritures.TauxTVA=0) then
                  raise ExceptLGR.Create('Pour un Code TVA autoliquidée, le taux est obligatoire.'+RetourChariotSimple+
           'La pièce '+PImport_E2FAC(FichierImport.Items[i])^.Reference+' ne peut pas être créée',1001,true,mtError,result.Erreur);
           end;
           if not empty(PImport_E2FAC(FichierImport.Items[i])^.CodeTVA)then
             begin //si code non vide
                 case ord(PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1])of
                   {I=>I}  73:CodeTvaCorrespondant:=PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1];
                   {B=>A}  66:CodeTvaCorrespondant:='A' ;
                   {V=>V}  86:CodeTvaCorrespondant:=PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1];
                   {L=>L}  76:CodeTvaCorrespondant:=PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1];
                   {E=>E}  69:CodeTvaCorrespondant:=PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1];
                   {A=>C}  65:CodeTvaCorrespondant:='C';
                   {N=>N}  78:CodeTvaCorrespondant:=PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1];
                   {M=>M}  77:CodeTvaCorrespondant:=PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1];
                   {T=>T}  84:CodeTvaCorrespondant:=PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1];
                 else
                   begin
                     if ( FCodeTvaExist(PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1]))then CodeTvaCorrespondant:=PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1]
                     else
                       raise ExceptLGR.Create('le code Tva '+PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1]+' ne correspond à aucun code Tva dans Epicéa windows.'+RetourChariotSimple+
           'La pièce '+PImport_E2FAC(FichierImport.Items[i])^.Reference+' ne peut pas être créée',1001,true,mtError,result.Erreur) ;
                   end;
                 end;//fin du case
    //En profiter pour contrôler que le type tva corresponde au compte,
    //les comptes 6 type A ou C ou N
    //les comptes 7 type E ou L ou N ou V
    //les comptes 2  type C ou I ou N
    //les comptes 609 et 709 type A ou C ou E ou L ou N ou V.
                  trouve:=false;
                 try
                 if(str_commence_par(Import_Ecritures.Compte,'44'))then
                 begin
                      codeTva:=FTvaRecupCodeTva(Import_Ecritures.Compte);
                      trouve:=not empty(codeTva);
                 end
                 else
                   begin
                     ListeTvaCodePourCompte:=DMPlan.TvaCodePourCompte(31,e.Regime,Import_Ecritures.Compte);
                     for k:=0 to  ListeTvaCodePourCompte.ListeCode.Count-1 do
                       begin
                           if ListeTvaCodePourCompte.ListeCode.strings[k][1] = CodeTvaCorrespondant[1]
                           then trouve:=true;
                       end;
                 end;
                 if(not trouve)then abort;
    //             if(ListeTvaCodePourCompte.ListeCode.IndexOf(PImport_E2FAC(FichierImport.Items[i])^.CodeTVA)=-1)then abort;
                 //case ord(PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1])of
    //               {I=>I}  73:if(not str_commence_par(Import_Ecritures.Compte,'2'))then abort;//compte de type 2
    //               {B=>A}  66:if(not str_commence_par(Import_Ecritures.Compte,'6')and not str_commence_par(Import_Ecritures.Compte,'709'))then abort;//compte de type 6 , 709
    //               {V=>V}  86,76,69:if(not str_commence_par(Import_Ecritures.Compte,'7')and not str_commence_par(Import_Ecritures.Compte,'609'))then abort;//compte de type 7,609
    ////               {L=>L}  76:if(not str_commence_par(Import_Ecritures.Compte,'7')and not str_commence_par(Import_Ecritures.Compte,'609'))then abort;//compte de type 7,609
    ////               {E=>E}  69:if(not str_commence_par(Import_Ecritures.Compte,'2'))then abort;//compte de type 7, 609
    //               {A=>C}  65:if(not str_commence_par(Import_Ecritures.Compte,'2')and not str_commence_par(Import_Ecritures.Compte,'6')
    //                           and not str_commence_par(Import_Ecritures.Compte,'709'))then abort;//compte de type 6 ,2 ,709
    //               {N=>N}  78:if(not str_commence_par(Import_Ecritures.Compte,'2')and not str_commence_par(Import_Ecritures.Compte,'6')
    //                          and not str_commence_par(Import_Ecritures.Compte,'7'))then abort;//compte de type 6 ,7 ,2
    //             end;//fin du case sur code tva
                 except
                     raise ExceptLGR.Create('le code Tva '+PImport_E2FAC(FichierImport.Items[i])^.CodeTVA[1]+' ne correspond pas au type de compte : '+Import_Ecritures.Compte+'.'+RetourChariotSimple+
                     'La pièce '+PImport_E2FAC(FichierImport.Items[i])^.Reference+' ne peut pas être créée',1001,true,mtError,result.Erreur) ;
                 end;
                 if CodeTvaCorrespondant<>'C' then
                   CodeTva:=FTvaRecupCodeTva_SurClasse(CodeTvaCorrespondant,PImport_E2FAC(FichierImport.Items[i])^.TauxTVA)
                 else
                   CodeTva:=FTvaRecupCodeTva_SurClasse(CodeTvaCorrespondant,'0');
                 if not empty(CodeTva)then
                   begin
                     Import_Ecritures.CodeTVA:=CodeTva;
                   end
                 else
                   begin
                     raise ExceptLGR.Create('Aucun code Tva de Classe -'+CodeTvaCorrespondant+'- ne correspond au taux '+PImport_E2FAC(FichierImport.Items[i])^.TauxTVA+RetourChariotSimple+
           'La pièce '+PImport_E2FAC(FichierImport.Items[i])^.Reference+' ne peut pas être créée',1001,true,mtError,result.Erreur) ;
                   end;
             end//fin si code non vide
           else
             if not empty(PImport_E2FAC(FichierImport.Items[i])^.CompteTva)then
                 begin //si Compte tva non vide
                     CodeTva:=FTvaRecupCodeTva(PImport_E2FAC(FichierImport.Items[i])^.CompteTva);
                     if not empty(CodeTva)then
                       Import_Ecritures.CodeTVA:=CodeTva
                     else
                        raise ExceptLGR.Create('Aucun code Tva ne correspond au Compte tva '+PImport_E2FAC(FichierImport.Items[i])^.CompteTva+RetourChariotSimple+
           'La pièce '+PImport_E2FAC(FichierImport.Items[i])^.Reference+' ne peut pas être créée',1001,true,mtError,result.Erreur) ;
                 end;//fin si Compte tva non vide
             ListeEcritures.Add(Import_Ecritures);
             PImport_E2FAC(FichierImport.Items[i])^.Enregistrer[1]:='1';
             end;//fin si ligne n'est pas vide
       except
          DMImport.RemplissageListeErreurSurImportationPiece(StrToInt_Lgr(PImport_E2FAC(FichierImport.Items[i])^.NumPiece),FichierImport,ListeErreur,result.Erreur);
       end;
    end;
  end;

except
  //abort;
end;//fin du try except
finally
  result.Erreur.GestMessageLGR.Enregistrement:=false;
//  Initialise_TStringlist(ListeCodeTva);
end;
End;

Function ImportationPieceEPI_DOS(FichierImport:Tlist;Var ListePiece:TList;ListeErreur:Tstringlist;TypeImport:integer):TExceptLGR_ImportPiece;
var
  Import_Piece:PRecordPiece; //record déclaré dans DeclRecord
  i:Integer;
  ListePieceEnregistrer:Tstringlist;
  Debit,Credit:currency;
begin
try//except
 GestMessageLGR.ModeTrace:=true;
 Initialise_ExceptLGR(Result.erreur,GestMessageLGR);
// result.Erreur.GestMessageLGR:=GestMessageLGR;
 result.Erreur.NomModule:='Fichier des pièces';
 ListePieceEnregistrer:=Tstringlist.Create;
 ListePiece:=Tlist.create;
 ListePiece.Clear;
 if FichierImport.Count=0 then
     raise ExceptLGR.Create('Le fichier des pièces est vide',1001,true,mtError,result.Erreur);
 for i:=0 to FichierImport.Count-1 do
  begin
     if ((trim(PImport_E2FAC(FichierImport.Items[i])^.NumLigne)='1')and(ListePieceEnregistrer.IndexOf(PImport_E2FAC(FichierImport.Items[i])^.NumPiece)=-1)) then
        begin
            try
              new(Import_Piece);
              Debit:=0;
              Credit:=0;
              Initialise_TRecordPiece(Import_Piece^);
                case ord(PImport_E2FAC(FichierImport.Items[i])^.TypePiece[1])of
                  {V}86:Import_Piece.IDJournal:=2;
                  {T}84:Import_Piece.IDJournal:=4;
                  {O}79:Import_Piece.IDJournal:=3;
                  {A}65:Import_Piece.IDJournal:=1;
                end;//fin du case typepiece
                Import_Piece.Date:=strtodate_Lgr(PImport_E2FAC(FichierImport.Items[i])^.DatePiece);
                Import_Piece.ID:=StrToInt_Lgr(PImport_E2FAC(FichierImport.Items[i])^.NumPiece);
                Import_Piece.Reference:=PImport_E2FAC(FichierImport.Items[i])^.Reference;
                Import_Piece.ReferenceInitiale:=PImport_E2FAC(FichierImport.Items[i])^.ReferenceInitial;
                case TypeImport of
//                   C_IMPORT_BLOQUEL:Import_Piece.Libelle:=PImport_E2FAC(FichierImport.Items[i])^.Libelle+' - Facture n° : '+PImport_E2FAC(FichierImport.Items[i])^.NumPiece;
                   C_IMPORT_BLOQUEL:Import_Piece.Libelle:='Facture n° : '+PImport_E2FAC(FichierImport.Items[i])^.NumPiece+'_'+PImport_E2FAC(FichierImport.Items[i])^.Libelle;
                   C_IMPORT_CAISSE,C_IMPORT_CAISSEBis:Import_Piece.Libelle:='caisse du '+PImport_E2FAC(FichierImport.Items[i])^.DatePiece;
                   C_IMPORT_E2_FAC,
                   C_IMPORT_EPIDOS:Import_Piece.Libelle:=trim(PImport_E2FAC(FichierImport.Items[i])^.Libelle)+' - n° : '+PImport_E2FAC(FichierImport.Items[i])^.Reference;
                   else Import_Piece.Libelle:=PImport_E2FAC(FichierImport.Items[i])^.Libelle;
                end;//fin du case
                //Import_Piece.Num:=strtointPImport_E2FAC(FichierImport.Items[i])^.
                Import_Piece.Journal:=copy(PImport_E2FAC(FichierImport.Items[i])^.Reference,1,2);
                Import_Piece.Echeance:=PImport_E2FAC(FichierImport.Items[i])^.DateEcheancePiece;
                Import_Piece.TypePiece:=PImport_E2FAC(FichierImport.Items[i])^.TypePiece;
                if Import_Piece.TypePiece <>'O' then
                begin
                  Debit:=strtocurr_lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.MontantDebit));
                  Credit:=strtocurr_lgr(ChangeDecimalSeparator(PImport_E2FAC(FichierImport.Items[i])^.MontantCredit));
                  Import_Piece.TotalPiece:=DetermineSolde(Debit,Credit);
                end;
      //          Import_Piece.bool:=PImport_E2FAC(FichierImport.Items[i])^.

      //   */**  CompteColl => compte comptable raccroché à un tiers (ex: 401)  **//*
      //   */**  CompteLigne => Tiers si compteColl rempli, sinon compte comptable  **//*

               if Import_Piece.TypePiece <>'O' then
                 begin//si autre pièce que OD pour laquelle il n'y a pas de compte d'entête
                     if not empty(Trim(PImport_E2FAC(FichierImport.Items[i])^.CompteColl)) then
                        Begin
                          Import_Piece.Compte:=Trim(PImport_E2FAC(FichierImport.Items[i])^.CompteColl);
                          Import_Piece.Tiers:=Trim(PImport_E2FAC(FichierImport.Items[i])^.CompteLigne);
                        end
                      else
                        begin
                          if str_commence_par(PImport_E2FAC(FichierImport.Items[i])^.CompteLigne,'+') then
                            Begin
                                Import_Piece.Compte:='';
                                //Infos_TInfosTiers(dmrech.TatiersRech,'Tiers',[sourcePiece.Tiers]).Compte;
                                Import_Piece.Tiers:=Trim(PImport_E2FAC(FichierImport.Items[i])^.CompteLigne);
                            end
                          else
                            Import_Piece.Compte:=Trim(PImport_E2FAC(FichierImport.Items[i])^.CompteLigne);
                        end;
                    Import_Piece.NomTiers:=Trim(PImport_E2FAC(FichierImport.Items[i])^.NomTiers);
                    if not empty(Import_Piece.Tiers)then
                    begin
                      if ((DMTiers.CptDuTiers(Import_Piece.Tiers)<>Import_Piece.Compte) and (not empty(DMTiers.CptDuTiers(Import_Piece.Tiers)))) then
                        Import_Piece.Compte:=DMTiers.CptDuTiers(Import_Piece.Tiers);
                    end;
                    if empty(Import_Piece.NomTiers)then
                      Import_Piece.NomTiers:=copy(Import_Piece.Tiers,2,length(Import_Piece.Tiers)-1);
                    Import_Piece.Addresse1:=PImport_E2FAC(FichierImport.Items[i])^.Adr1;
                    Import_Piece.Addresse2 :=PImport_E2FAC(FichierImport.Items[i])^.Adr2;
                    Import_Piece.CodePostal:=PImport_E2FAC(FichierImport.Items[i])^.CodePostal;
                    Import_Piece.Ville:=PImport_E2FAC(FichierImport.Items[i])^.Ville;
                  end;//fin si autre pièce que OD pour laquelle il n'y a pas de compte d'entête
                ListePiece.Add(Import_Piece);
                PImport_E2FAC(FichierImport.Items[i])^.Enregistrer[1]:='1';
                ListePieceEnregistrer.Add(PImport_E2FAC(FichierImport.Items[i])^.NumPiece);
            except
              DMImport.RemplissageListeErreurSurImportationPiece(StrToInt_Lgr(PImport_E2FAC(FichierImport.Items[i])^.NumPiece),FichierImport,ListeErreur,result.Erreur);
            end;
        end;
  end;
except
  abort;
end;
End;



function TDMImport.AffichePiece_AvantEnregistrement(Ecriture: TEcriture_Isa):Tstringlist;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 filtre:string;
 Exception:TExceptLGR;
begin
try//except
  if ((Ecriture.ListIdentifiant<>nil)and(Ecriture.ListIdentifiant.Count<>0)) then
    begin//si liste non vide
    Initialise_ExceptLGR(exception,GestMessageLGR);
//      Exception.GestMessageLGR:=GestMessageLGR;
      Exception.NomModule:='AffichePiece_AvantEnregistrement';
      result:=TStringList.Create;
      for i:=0 to Ecriture.ListIdentifiant.Count-1 do
        Begin
           result.Add(Ecriture.RecupListeEcriture_PourAffichage(Ecriture.ListIdentifiant,i));
        end;
      Initialise_TParamAffichage(ParamAffichage);
      ParamAffichage.AffichModal := true;
      ParamAffichage.Titre:='Liste des écritures de la pièce '+Ecriture.Piece.Reference;
      ParamAffichage.GestionAffichForm.Caption := 'Pièces déjà importées';
      //Compte:=
      if result.Count<>0 then
        AfficheVisuListView(ParamAffichage,['Compte','Tiers','Libellé','Qt1','Qt2','Débit','Crédit','TypeLigne','Code Tva','Type','TvaDate','Taux','MontantTVA'],
                                         [80,80,100,30,30,80,80,20,80,20,80,60,80],//
                                         [result],
                                         [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                         taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                         taLeftJustify,taLeftJustify,taLeftJustify],
                                         [1..13],
                                         [],[]);
      for i:=0 to result.Count-1 do
        begin
          result.Strings[i]:=str_getstringelement(result.Strings[i],1,';');
        end;
    end;//fin si liste non vide
except
  abort;
end;//fin except
end;



Function ChoisirRepImportation(var RepertoireImportDefaut:String;NomImport:String):Boolean;
var
ResultChoisirRep:TResultChoisirRep;
ParamChoixRep:TParamChoixRep;
Begin
 try
  result := False;
  if DMImport = nil then
         DMImport:=TDMImport.Create(Application.MainForm);
  ParamChoixRep.RepDefaut := IncludeTrailingPathDelimiter(RepertoireImportDefaut);
  ParamChoixRep.TitreForm :='Emplacement du dossier '+NomImport+' à importer.';
  ResultChoisirRep:=ChoisirRepertoire(ParamChoixRep);
  if ResultChoisirRep.Retour then
   begin
    RepertoireImportDefaut := IncludeTrailingPathDelimiter(ResultChoisirRep.RepChoisi);
    result := true;
//    showmessage(E.RepertoireImportEPI_DOS);
   end
   else
   begin
//    Messagedlg_lgr('Importation abandonnée !', mtWarning, [mbOK], 0);
    abort;
   end;
  except
    Messagedlg_lgr('Importation abandonnée !', mtWarning, [mbOK], 0);
//    Messagedlg_lgr('Importation abandonnée pour erreur inconnue!', mtWarning, [mbOK], 0);
    abort;
  end;
End;


Procedure TDMImport.Import_Piece_SurTypeMicroPointe(NomFichier:String;Var Liste:TList);
var
trouveFichier:boolean;
  ListeCaisse,ListeMP:TList;
  i,num:integer;
  numPieceCourant:string;
begin
    ListeMP:=TList.Create;
    ListeMP.clear;
    ListeCaisse:=TList.Create;
    ListeCaisse.clear;

    NomFichier:=e.RepertoireImportCourante+DM_C_NomFichierImportCAISSEMpFacture;
    trouveFichier:=FileExists(NomFichier);
    if(trouveFichier)then
      begin
        ImportationCaisseEnregistreuse_MicroPointeBis(NomFichier,ListeMP);
        ListeCaisse.Assign(ListeMP);
        for i:=0 to ListeCaisse.Count-1 do
        begin
            liste.add(ListeCaisse.Items[i]) ;
        end;
        ListeMP.Clear;
      end;

    NomFichier:=e.RepertoireImportCourante+DM_C_NomFichierImportCAISSEMpTicket;
    trouveFichier:=FileExists(NomFichier);
    if(trouveFichier)then
      begin
        ImportationCaisseEnregistreuse_MicroPointeBis(NomFichier,ListeMP);
        ListeCaisse.Assign(ListeMP);
        for i:=0 to ListeCaisse.Count-1 do
        begin
            liste.add(ListeCaisse.Items[i]) ;
        end;
        ListeMP.Clear;
      end;

    NomFichier:=e.RepertoireImportCourante+DM_C_NomFichierImportCAISSEMpCarte;
    trouveFichier:=FileExists(NomFichier);
    if(trouveFichier)then
      begin
        ImportationCaisseEnregistreuse_MicroPointeBis(NomFichier,ListeMP);
        ListeCaisse.Assign(ListeMP);
        for i:=0 to ListeCaisse.Count-1 do
        begin
            liste.add(ListeCaisse.Items[i]) ;
        end;
        ListeMP.Clear;
      end;

 
    NomFichier:=e.RepertoireImportCourante+DM_C_NomFichierImportCAISSEMPVirement;
    trouveFichier:=FileExists(NomFichier);
    if(trouveFichier)then
      begin
        ImportationCaisseEnregistreuse_MicroPointeBis(NomFichier,ListeMP);
        ListeCaisse.Assign(ListeMP);
        for i:=0 to ListeCaisse.Count-1 do
        begin
            liste.add(ListeCaisse.Items[i]) ;
        end;
        ListeMP.Clear;
      end;

   NomFichier:=e.RepertoireImportCourante+DM_C_NomFichierImportCAISSEMpCheque;
    trouveFichier:=FileExists(NomFichier);
    if(trouveFichier)then
      begin
        ImportationCaisseEnregistreuse_MicroPointeBis(NomFichier,ListeMP);
        ListeCaisse.Assign(ListeMP);
        for i:=0 to ListeCaisse.Count-1 do
        begin
            liste.add(ListeCaisse.Items[i]) ;
        end;
        ListeMP.Clear;
      end;


    NomFichier:=e.RepertoireImportCourante+DM_C_NomFichierImportCAISSEMpEspece;
    trouveFichier:=FileExists(NomFichier);
    if(trouveFichier)then
      begin
        ImportationCaisseEnregistreuse_MicroPointeBis(NomFichier,ListeMP);
        ListeCaisse.Assign(ListeMP);
        for i:=0 to ListeCaisse.Count-1 do
        begin
            liste.add(ListeCaisse.Items[i]) ;
        end;
        ListeMP.Clear;
      end;

      //change num piece pour rendre unique dans fichier
      num:=0;
      numPieceCourant:='';
      for i:=0 to liste.Count-1 do
      begin
         if(numPieceCourant='')or(numPieceCourant<>PImport_E2FAC(liste.Items[i]).ReferenceInitial)then inc(num);
         numPieceCourant:=PImport_E2FAC(liste.Items[i]).ReferenceInitial;
         PImport_E2FAC(liste.Items[i]).NumPiece:=IntToStr_Lgr(num);

      end;
end;

Function TDMImport.Import_Piece_SurType(DataSet:TDataSet;Confirmation:Boolean;NomFichier:string;TypeImport:integer):TExceptLGR;
var
listePieceAImporter,ListePieceAEnlever:Tstringlist;
ValPieceAutoGen:TValPieceAutoGenere;
AnneeAnterieure:TPieceAnterieure;
 i,j,Aug,P,l:integer;
 ListeMaitreImport,ListeEsclaveImport,ListePointageImport:TList;
 ListeErreur,ListeErreurPointage:TStringList;
 Tiers,Nom,Compte,TypeTiers,message_:String;
ErreurImportPiece:TExceptLGR_ImportPiece;
NouvellePiece:TInfosPiece_Import;
ParamAffichage:TParamAffichage;
 TypeEtatExerciceTmp:TTypeEtatExercice;
 ListeCree:Tstringlist;
 NomFic:String;
  Liste,ListeMP:TList;
debut,fin:TTime;
CountPiece:integer;
Importer:boolean;
QueryTmp:TQuery;
ARecordPiece:PRecordPiece;
ARecordEcriture:PRecordEcriture;
Pointage:Pinfos_Pointage;
D:integer;
Tab:variant;
filtreTemp,NouvelleReference:string;
infosPointages:TinfosPointages;
continuer:boolean;
InfoResteDCSurEcriture:TInfoResteDCSurEcriture;
trouveFichier:boolean;
Begin
try//finally
try//except
// result.NumErreur:=0;
// result.retour:=true;
QueryTmp:=TQuery.create(application.MainForm);
QueryTmp.DataBaseName:=DM_C_NomAliasDossier;
QueryTmp.Name:='ImportationPointage';
 Importer:=true;
 GestMessageLGR.ModeTrace:=true;
 Initialise_ExceptLGR(result,GestMessageLGR);
// result.GestMessageLGR:=GestMessageLGR;
 result.NomModule:='Import_Piece_SurType';
 result.GestMessageLGR.ModulePrincipal:='Import_Piece_SurType';
 result.GestMessageLGR.Enregistrement:=true;
 result.NomDossier:=e.NomDossier;

debut:=time;
fin:=0;
    TypeEtatExerciceTmp:=E.TypeEtatExercice;
    E.TypeEtatExercice:=ET_Importation;
  if DMPieces = nil then
         DMPieces:=TDMPieces.Create(Application.MainForm);

  NomFic:=NomFichier;
  try
    E.RepertoireImportCourante := E.RepertoireImportation;
    if ChoisirRepImportation(E.RepertoireImportCourante,'Importation') then
       E.RepertoireImportation := E.RepertoireImportCourante;
  except
    abort;
  end;

// PB le 17/12/03  E.RepertoireImportEPI_DOS:=IncludeTrailingPathDelimiter(E.RepertoireImportEPI_DOS);
  message_:='';

  case TypeImport of
    C_IMPORT_BLOQUEL:  Begin
                          ErreurImportPiece.Mess:='Êtes-vous sûr de vouloir importer les pièces de la facturation ?';
                          result.GestMessageLGR.FichierMessage:='Import_Bloquel.txt';
                          //GestMessageLGR.RepertoireMessage :=CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_BLOQUEL);
                          result.GestMessageLGR.Enregistrement:=true;
                          result.GestMessageLGR.ModulePrincipal:='Importation Bloquel';
                       end;
    C_IMPORT_E2_FAC:  Begin
                          ErreurImportPiece.Mess:='Êtes-vous sûr de vouloir importer les nouvelles factures ?';
                          result.GestMessageLGR.FichierMessage:='ImportE2_Fac.txt';
                          //GestMessageLGR.RepertoireMessage :=CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_E2FAC);
                          result.GestMessageLGR.Enregistrement:=true;
                          result.GestMessageLGR.ModulePrincipal:='Importation E2_Fac';
                       end;
    C_IMPORT_CAISSE:  Begin
                          ErreurImportPiece.Mess:='Êtes-vous sûr de vouloir importer les nouvelles factures de la caisse ?';
                          result.GestMessageLGR.FichierMessage:='ImportCaisse.txt';
                          //GestMessageLGR.RepertoireMessage :=CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_E2FAC);
                          result.GestMessageLGR.Enregistrement:=true;
                          result.GestMessageLGR.ModulePrincipal:='Importation CAISSE';
                       end;
    C_IMPORT_CAISSEBis:  Begin
                          ErreurImportPiece.Mess:='Êtes-vous sûr de vouloir importer les nouvelles factures de la caisse Micro pointe ?';
                          result.GestMessageLGR.FichierMessage:='ImportCaisseMicroPointe.txt';
                          //GestMessageLGR.RepertoireMessage :=CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_E2FAC);
                          result.GestMessageLGR.Enregistrement:=true;
                          result.GestMessageLGR.ModulePrincipal:='Importation CAISSE B';
                       end;
    C_IMPORT_CAISSE_2:  Begin
                          ErreurImportPiece.Mess:='Êtes-vous sûr de vouloir importer les nouvelles factures de la caisse ?';
                          result.GestMessageLGR.FichierMessage:='ximport.txt';
                          //GestMessageLGR.RepertoireMessage :=CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_E2FAC);
                          result.GestMessageLGR.Enregistrement:=true;
                          result.GestMessageLGR.ModulePrincipal:='Importation CAISSE B';
                       end;
    C_IMPORT_SARA:  Begin
                          ErreurImportPiece.Mess:='Êtes-vous sûr de vouloir importer les Mouvements de SARA pour DOS ?';
                          result.GestMessageLGR.FichierMessage:='ImportSARA.txt';
                          //GestMessageLGR.RepertoireMessage :=CreerDossierDateJour(E.RepertoireDossier,C_REP_JOURNAL_IMP_SARA);
                          result.GestMessageLGR.Enregistrement:=true;
                          result.GestMessageLGR.ModulePrincipal:='Importation SARA';
                       end;
  end;//fin du case
//    //Première boucle for pour augmenter l'importation { isa  le  24/02/04 à enlever !!!!!!!!!!}
  if Messagedlg_lgr(PChar(ErreurImportPiece.Mess),mtconfirmation, [mbyes,mbno],0) = mryes then
  begin
    ListeErreur:=TStringList.Create;
    ListeErreur.Clear;

    ListeErreurPointage:=TStringList.Create;
    ListeErreurPointage.Clear;

    DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
    ListeCree:=Tstringlist.create;
    ListeCree.clear;

    ListeMP:=TList.Create;
    ListeMP.clear;

    Liste:=TList.Create;
    Liste.clear;
       DMImport.VerifCreationPieceEcriture;
    DMImport.Piece_Import.NouvellePiece(false);
    DMImport.Ecriture_Import.DispatcherTva:=(TypeImport in [C_IMPORT_E2_FAC,C_IMPORT_CAISSE,C_IMPORT_CAISSE_2,C_IMPORT_SARA,C_IMPORT_CAISSEBis]);
    AnneeAnterieure.PieceAnterieure:=false;

    if(TypeImport=C_IMPORT_CAISSEbis)then
    begin
    trouveFichier:=DirectoryExists(E.RepertoireImportCourante);
       //trouveFichier:=reper(E.RepertoireImportCourante,'Veuillez indiquer le répertoire contenant le fichier d''importation.',0);
    end
    else
      trouveFichier:=FileExistDialog(E.RepertoireImportCourante,NomFichier,true);

    
// PB le 17/12/03    if FileExistDialog(E.RepertoireImportEPI_DOS,NomFichier,true) then //on traite la liste des pièces
    if trouveFichier then //on traite la liste des pièces
     begin//si fichier d'exportation DOS existe
// PB le 17/12/03       NomFic:=IncludeTrailingPathDelimiter(E.RepertoireImportEPI_DOS)+NomFichier;
      PatienterAffich;
       NomFic:=IncludeTrailingPathDelimiter(E.RepertoireImportCourante)+NomFichier;
  case TypeImport of
    C_IMPORT_BLOQUEL: Begin
                         ImportationPieceEPI_DOS_PourBloquel(NomFic,ListeMaitreImport,Liste);
                         ImportationEcrituresEPI_DOS_PourBloquel(NomFic,ListeMaitreImport,Liste);
                      end;
    C_IMPORT_E2_FAC:  Begin
                         ImportationE2FAC(E.RepertoireImportCourante+NomFichier,Liste);
// PB le 17/12/03                         ImportationE2FAC(E.RepertoireImportEPI_DOS+NomFichier,Liste);
                      end;
    C_IMPORT_CAISSE:  Begin
                         ImportationCaisseEnregistreuse(E.RepertoireImportCourante+NomFichier,Liste);
// PB le 17/12/03
                      end;
    C_IMPORT_CAISSE_2:  Begin
                         ImportationCaisseEnregistreuseBernard(E.RepertoireImportCourante+NomFichier,Liste);
// PB le 17/12/03
                      end;
    C_IMPORT_CAISSEbis:  Begin
                             Import_Piece_SurTypeMicroPointe(E.RepertoireImportCourante+NomFichier,Liste);
// PB le 17/12/03
                      end;
    C_IMPORT_SARA:  Begin
                         ImportationE2FAC(E.RepertoireImportCourante+NomFichier,Liste);
// PB le 17/12/03                         ImportationE2FAC(E.RepertoireImportEPI_DOS+NomFichier,Liste);
                      end;
  end;//fin du case
        if Liste.Count=0 then   SupprimeFichierApresImportation(NomFichier,E.RepertoireImportCourante);
        ErreurImportPiece:=ImportationPieceEPI_DOS(Liste,ListeMaitreImport,ListeErreur,TypeImport);
        ErreurImportPiece:=ImportationEcrituresEPI_DOS(Liste,ListeEsclaveImport,ListeErreur,TypeImport);
        ErreurImportPiece:=ImportationPointageEPI_DOS(Liste,ListePointageImport,ListeErreur,TypeImport);
        listePieceAImporter:=TStringList.Create;
        ListePieceAEnlever:=TStringList.Create;
        for i:=0 to ListeMaitreImport.Count -1 do
          begin
          if (TypeImport=C_IMPORT_CAISSE)or(TypeImport=C_IMPORT_CAISSEbis) then
              listePieceAImporter.Add(PRecordPiece(ListeMaitreImport.Items[i])^.ReferenceInitiale)
              else
          if not empty(PRecordPiece(ListeMaitreImport.Items[i])^.reference) then
            listePieceAImporter.Add(PRecordPiece(ListeMaitreImport.Items[i])^.reference)
          else
              listePieceAImporter.Add(inttostr(PRecordPiece(ListeMaitreImport.Items[i])^.ID));
          end;
       ListePieceAEnlever:=AfficheListe_PieceImportExistante(listePieceAImporter,TypeImport);
    CountPiece:=0;

    ////// !!!!!!!!!!!!!!!!!!!!!!!!
//    for Aug:=0 to 5000 do   { isa  le  29/07/04 pour test}//
//      begin
        for i:=0 to ListeMaitreImport.Count-1 do
           begin//début boucle for
               try
                 initialise_TExceptLGR_ImportPiece(ErreurImportPiece);
                 //if Type_version_execution=CT_DISTRIBUTION then
                   begin //si version distribution
                      case TypeImport of
                         C_IMPORT_CAISSE,C_IMPORT_CAISSEBis:importer:=ListePieceAEnlever.IndexOf(PRecordPiece(ListeMaitreImport.Items[i])^.ReferenceInitiale)=-1;
                         else importer:=ListePieceAEnlever.IndexOf(PRecordPiece(ListeMaitreImport.Items[i])^.reference)=-1;
                      end;//fin du case
                   end;//fin si version distribution
                 if importer then
                   begin
                       ErreurImportPiece:=DMPieces.ImportPiece(PRecordPiece(ListeMaitreImport.Items[i])^,ListeEsclaveImport,ListePointageImport,AnneeAnterieure,ValPieceAutoGen,nil,true);
                        Initialise_TInfosPiece_Import(NouvellePiece);
                       NouvellePiece.ID_Piece_Import:=PRecordPiece(ListeMaitreImport.Items[i])^.ID;
                       NouvellePiece.Compte:=PRecordPiece(ListeMaitreImport.Items[i])^.Compte;
                       if (TypeImport=C_IMPORT_CAISSE)or(TypeImport=C_IMPORT_CAISSEbis) then
                         NouvellePiece.Libelle:=PRecordPiece(ListeMaitreImport.Items[i])^.ReferenceInitiale
                       else
                         NouvellePiece.Libelle:=PRecordPiece(ListeMaitreImport.Items[i])^.Reference;
                       NouvellePiece.ID_Prog:=TypeImport;
                       NouvellePiece.Nouvel_ID_Piece:=ErreurImportPiece.Id_Piece;
                       EnregistreNouvellePieceImporte(nouvellePiece);
                       NouvelleReference:=Infos_TInfosPiece(dmrech.TaPieceRech,'id',[nouvellePiece.Nouvel_ID_Piece]).Reference;
                       ListeCree.add(NouvelleReference);
                       TableGereCommit(DMImport.Piece_Import.TablePiece);
                       TableGereCommit(DMBalance.TaBalance);
                       inc(CountPiece);
                   end;

               except
                 RemplissageListeErreurSurImportationPiece(PRecordPiece(ListeMaitreImport.Items[i])^.ID,liste,ListeErreur,ErreurImportPiece.Erreur);
               end;//fin du try except
           end;//fin boucle for
                       TableGereStartTransaction(DMImport.Piece_Import.TablePiece);
                       TableGereStartTransaction(DMBalance.TaBalance);
                       DMPieces.TaPiece.FlushBuffers;


                      for P:=0 to ListePointageImport.Count -1 do  //traitement des pointages
                        begin
                         try
                         TableGereStartTransaction(DMImport.Piece_Import.TablePiece);
                         TableGereStartTransaction(DMBalance.TaBalance);
                         DMPieces.TaPiece.FlushBuffers;
                           Pointage:=ListePointageImport.Items[P];

                           initialise_TExceptLGR_ImportPiece(ErreurImportPiece);
                           //rechercher les identfiants des lignes concernées
//
                           FiltrageDataSet(DMRech.TaPiece_ImportRech,CreeFiltreOU('libelle',[Pointage.RefDebit]));
                           if(DMRech.TaPiece_ImportRech.RecordCount<>0)then pointage.idPieceDebit:=DMRech.TaPiece_ImportRech.findfield('nouvel_id_piece').AsInteger;
                           if(pointage.idPieceDebit=0)then
                           begin
                               ErreurImportPiece.Erreur.Mess:='La pièce n° '+pointage.RefDebit+' n''existe pas';
                              ErreurImportPiece.Erreur.retour:=false;
                              abort;
                           end;

                           FiltrageDataSet(DMRech.TaPiece_ImportRech,CreeFiltreOU('libelle',[Pointage.RefCredit]));
                           if(DMRech.TaPiece_ImportRech.RecordCount<>0)then pointage.idPieceCredit:=DMRech.TaPiece_ImportRech.findfield('nouvel_id_piece').AsInteger;
                           if(pointage.idPieceCredit=0)then
                           begin
                               ErreurImportPiece.Erreur.Mess:='La pièce n° '+pointage.RefCredit+' n''existe pas';
                              ErreurImportPiece.Erreur.retour:=false;
                              abort;
                           end;
                           if(str_commence_par(Pointage.Tiers,'+'))then
                           begin
                               filtreTemp:=CreeFiltreET(['id_Piece','Tiers','DebitSaisie'],[IntToStr_Lgr(Pointage.idPieceDebit),trim(Pointage.Tiers),CurrToStr_Lgr(Pointage.MontantDebit)]);
                               FiltrageDataSet(DMRech.TaEcritureRech,filtreTemp);
                               if(DMRech.TaEcritureRech.RecordCount<>0)then pointage.ID_Debit:=DMRech.TaEcritureRech.findfield('id').AsInteger;
                               filtreTemp:=CreeFiltreET(['id_Piece','Tiers','CreditSaisie'],[IntToStr_Lgr(Pointage.idPieceCredit),trim(Pointage.Tiers),CurrToStr_Lgr(Pointage.MontantCredit)]);
                               FiltrageDataSet(DMRech.TaEcritureRech,filtreTemp);
                               if(DMRech.TaEcritureRech.RecordCount<>0)then pointage.ID_Credit:=DMRech.TaEcritureRech.findfield('id').AsInteger;
                           end
                           else
                           begin
                               filtreTemp:=CreeFiltreET(['id_Piece','compte','DebitSaisie'],[IntToStr_Lgr(Pointage.idPieceDebit),trim(Pointage.Tiers),CurrToStr_Lgr(Pointage.MontantDebit)]);
                               FiltrageDataSet(DMRech.TaEcritureRech,filtreTemp);
                               if(DMRech.TaEcritureRech.RecordCount<>0)then pointage.ID_Debit:=DMRech.TaEcritureRech.findfield('id').AsInteger;
                               filtreTemp:=CreeFiltreET(['id_Piece','compte','CreditSaisie'],[IntToStr_Lgr(Pointage.idPieceCredit),trim(Pointage.Tiers),CurrToStr_Lgr(Pointage.MontantCredit)]);
                               FiltrageDataSet(DMRech.TaEcritureRech,filtreTemp);
                               if(DMRech.TaEcritureRech.RecordCount<>0)then pointage.ID_Credit:=DMRech.TaEcritureRech.findfield('id').AsInteger;
                           end;

                           Tab:=VarArrayCreate([0,4],varVariant);
                           tab[0]:=pointage.ID_Debit;
                           tab[1]:=pointage.ID_Credit;
                           tab[2]:=pointage.DateMaitre;
                           tab[3]:=pointage.MontantPointage;
                           tab[4]:=pointage.DateEsclave;
                           continuer:=true;
                           infosPointages:=DMPointage2.FiltragePointageSurEcriture(QueryTmp,inttostr(pointage.ID_Debit),
                           true,true,true,pointage.ID_Credit);

                           IF QueryTmp.Recordcount<>0 then
                              begin
                                 if(infosPointages.MontantPointage=pointage.MontantPointage)then continuer:=false
                                 else begin
                                    ErreurImportPiece.Erreur.Mess:='Le pointage entre la pièce '+pointage.RefDebit+' et la pièce '+pointage.RefCredit+' existe déjà';
                                    ErreurImportPiece.Erreur.retour:=false;
                                    abort;
                                 end;
                              end else
                              begin
                                  //vérifier le reste de chaque ecriture
                                  InfoResteDCSurEcriture:=DMPointage2.InfosPointageSurResteDC(pointage.ID_Debit);
                                  if(InfoResteDCSurEcriture.Reste<pointage.MontantPointage)then
                                  begin
                                    ErreurImportPiece.Erreur.Mess:='Le montant du pointage est supérieur au reste de la ligne "'+inttostr(pointage.ID_Debit)+'"';
                                    ErreurImportPiece.Erreur.retour:=false;
                                    abort;
                                  end;
                                  InfoResteDCSurEcriture:=DMPointage2.InfosPointageSurResteDC(pointage.ID_Credit);
                                  if(InfoResteDCSurEcriture.Reste<pointage.MontantPointage)then
                                  begin
                                    ErreurImportPiece.Erreur.Mess:='Le montant du pointage est supérieur au reste de la ligne "'+inttostr(pointage.ID_Credit)+'"';
                                    ErreurImportPiece.Erreur.retour:=false;
                                    abort;
                                  end;
                              end;
                          initialise_TExceptLGR_ImportPiece(ErreurImportPiece);
                          if(continuer)then
                            begin
                                ErreurImportPiece:=(CreationPointageSurIDEcriture(tab,pointage.Tiers,true));
                                if(ErreurImportPiece.Id_Piece=-1)  then abort;
                            end;
                           Tab:=Unassigned;
                       except
                            RemplissageListeErreurSurImportationPointage(pointage.RefDebit,pointage.RefCredit,liste,ListeErreurPointage,ErreurImportPiece.Erreur);
                       end;
                        TableGereCommit(DMImport.Piece_Import.TablePiece);
                        TableGereCommit(DMBalance.TaBalance);
                        end;

            {Nettoyage :libère les éléments de la liste }
      Initialise_TList(ListeMaitreImport);   //Initialise_TList(ListeMaitreImport,false);
      Initialise_TList(ListeEsclaveImport);  //Initialise_TList(ListeEsclaveImport,false);
      Initialise_TList(ListePointageImport);
      Initialise_TList(Liste);             


     end//fin si fichier d'exportation DOS existe
    else
        raise ExceptLGR.Create('',1000,false,mtError,ErreurImportPiece.Erreur);

    ListeErreur.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,'JOURNAL-')+'Import_Piece.TXT');
    ListeErreurPointage.SaveToFile(CreerDossierDateJour(E.RepertoireDossier,'JOURNAL-')+'Import_Pointage.TXT');
    //affichage des pièces créées
   fin:=time;
//   PatienterFermer;
    if ((ListeCree<>nil )and(ListeCree.count<>0)) then
      begin
        DMPieces.AffichageFeuilleReprise(0,ListeCree,nil,'Affichage des nouvelles pièces créées','','',false);
        message_:='';
      end
    else
       message_:='Aucune pièce n''a été importée.'+#13+#10+''+#13+#10;
//   showmessage('Debut : '+timetostr(debut)+ '- Fin : '+timetostr(fin)+' Nb de pièces : '+inttostr(CountPiece));
   if ListeErreur.Count<>0 then
     begin//si fichier erreur non vide
            ListeErreur.Add('Import_Piece.TXT');
            ListeErreur.SaveToFile(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Import_Piece.TXT');
        if Messagedlg_lgr(message_+'Souhaitez-vous visualiser le rapport d''importation ?', mtWarning, [mbYes,mbNo], 0) = mrYes then
          begin
            Initialise_TParamAffichage(ParamAffichage);
            ParamAffichage.AffichModal := true;
            ParamAffichage.Titre:='Rapport d''importation des pièces';
            ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
            if ListeErreur.Count<>0 then
              AfficheVisuListView(ParamAffichage,['Erreur','N° Pièce','N° Ligne','Type Pièce','Référence','Date Pièce','Compte','Libellé','Débit','Crédit','Qt1','Qt2','Code Tva','Taux','TVA Débit','TVA Crédit','Echéance','Tiers','Nom','Adresse 1','Adresse 2','Code P.','Ville','TvaDate','Livraison',''],
                                               [40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40],//
                                               [ListeErreur],
                                               [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                               [1..26],
                                               [],[]);
          end;
    end;//fin si fichier erreur non vide
   if ListeErreurPointage.Count<>0 then
     begin//si fichier erreur non vide
            ListeErreurPointage.Add('Import_Piece.TXT');
            ListeErreurPointage.SaveToFile(IncludeTrailingPathDelimiter(E.RepertoireDossier)+'Import_Pointage.TXT');
        if Messagedlg_lgr(message_+'Souhaitez-vous visualiser le rapport d''importation des pointages?', mtWarning, [mbYes,mbNo], 0) = mrYes then
          begin
            Initialise_TParamAffichage(ParamAffichage);
            ParamAffichage.AffichModal := true;
            ParamAffichage.Titre:='Rapport d''importation des pointages';
            ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
            if ListeErreurPointage.Count<>0 then
              AfficheVisuListView(ParamAffichage,['Erreur','N° Pièce','N° Ligne','Type Pièce','Référence','Date Pièce','Compte','Libellé','Débit','Crédit',
              'RefContrepartie','DateContrepartie','MontantDebitContrepartie','MontantCreditContrepartie','Montant pointage',''],
                                               [40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40],//
                                               [ListeErreurPointage],
                                               [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,
                                               taLeftJustify],
                                               [1..16],
                                               [],[]);
          end;
    end;//fin si fichier erreur non vide
     if Type_version_execution=CT_DISTRIBUTION then
       begin
         if(TypeImport=C_IMPORT_CAISSEBis)then
          SupprimeFichierApresImportationMicroPointe(NomFichier,E.RepertoireImportCourante)
         else
          SupprimeFichierApresImportation(NomFichier,E.RepertoireImportCourante);
       end;
  end;
except;
  abort;
end;
finally
QueryTmp.close;
QueryTmp.free;
 E.TypeEtatExercice:=TypeEtatExerciceTmp;
 E.RepertoireImportation :=E.RepertoireImportCourante;
 result.GestMessageLGR.Enregistrement:=false;
 GestMessageLGR.ModeTrace:=true;
 PatienterFermer;
end;//fin finally
End;


Function TDMImport.RemplissageListeErreurSurImportationPiece(IDPiece:integer;ListeOrigine:Tlist;var ListeErreur:Tstringlist;Erreur:Texceptlgr):Tstringlist;
var
j:integer;
begin
  result:=TStringList.Create;
  result.Sorted:=true;
  result.Clear;
  for j:=0 to ListeOrigine.count-1 do
    begin
      if StrToInt_Lgr(PImport_E2FAC(ListeOrigine.items[j])^.NumPiece)=IDPiece then
         begin
         result.Add(Trim(Erreur.Mess) +';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.NumPiece+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.NumLigne+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.TypePiece+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Reference+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.DatePiece+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.CompteLigne+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Libelle+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantDebit+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantCredit+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Qte1+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Qte2+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.CodeTVA+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.TauxTVA+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantDebitTVA+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantCreditTVA+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.DateEcheancePiece+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.CompteColl+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.NomTiers+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Adr1+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Adr2+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.CodePostal+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Ville+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.ExibiliteTVA+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.DateLivraisonLigne+
                           ';Rejetée'
                            );
         end;//fin si ligne de la pièce en cours
    end;//fin boucle for
    for j:=0 to Result.Count-1 do
      ListeErreur.Add(Result.Strings[j]);
end;


Function TDMImport.RemplissageListeErreurSurImportationPointage(RefDebit,RefCredit:string;ListeOrigine:Tlist;var ListeErreur:Tstringlist;Erreur:Texceptlgr):Tstringlist;
var
j:integer;
begin
  result:=TStringList.Create;
  result.Sorted:=true;
  result.Clear;
  for j:=0 to ListeOrigine.count-1 do
    begin
      if (PImport_E2FAC(ListeOrigine.items[j])^.TypePiece='P')and(PImport_E2FAC(ListeOrigine.items[j])^.Reference=RefCredit)
      and(PImport_E2FAC(ListeOrigine.items[j])^.RefContrepartie=RefDebit) then
         begin
         result.Add(Trim(Erreur.Mess) +';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.NumPiece+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.NumLigne+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.TypePiece+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Reference+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.DatePiece+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.CompteLigne+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.Libelle+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantDebit+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantCredit+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.RefContrepartie+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.DateContrepartie+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantDebitContrepartie+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantCreditContrepartie+
                           ';'+
                           PImport_E2FAC(ListeOrigine.Items[j])^.MontantPointage+
                           ';Rejetée'
                            );
         end;//fin si ligne de la pièce en cours
    end;//fin boucle for
    for j:=0 to Result.Count-1 do
      ListeErreur.Add(Result.Strings[j]);
end;

procedure TDMImport.Ta_PieceImportExistanteCalcFields(DataSet: TDataSet);
begin
DeFiltrageDataSet(dmrech.TaPieceRech);
if dmrech.TaPieceRech.RecordCount<>0 then
  Ta_PieceImportExistanteReference.AsString:=Infos_TInfosPiece(dmrech.TaPieceRech,'id',[Ta_PieceImportExistante.FindField('Nouvel_id_Piece').AsString]).Reference;
end;

Function SupprimeFichierApresImportation(NomFichier,Repertoire:String):TExceptLGR;
begin
    try
      CopyFile(PChar(IncludeTrailingPathDelimiter(Repertoire)+NomFichier),PChar(IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier),false);
      DeleteFile(IncludeTrailingPathDelimiter(Repertoire)+NomFichier);
    except
      on EInOutError do
      Messagedlg_lgr('Erreur d''E-S du fichier '+IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier,mtError,[mbOk],0);
    end;
end;


Function SupprimeFichierApresImportationMicroPointe(NomFichier,Repertoire:String):TExceptLGR;
begin
    try
    NomFichier:=DM_C_NomFichierImportCAISSEMpFacture;
      CopyFile(PChar(IncludeTrailingPathDelimiter(Repertoire)+NomFichier),PChar(IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier),false);
      DeleteFile(IncludeTrailingPathDelimiter(Repertoire)+NomFichier);
    NomFichier:=DM_C_NomFichierImportCAISSEMpTicket;
      CopyFile(PChar(IncludeTrailingPathDelimiter(Repertoire)+NomFichier),PChar(IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier),false);
      DeleteFile(IncludeTrailingPathDelimiter(Repertoire)+NomFichier);
    NomFichier:=DM_C_NomFichierImportCAISSEMpCarte;
      CopyFile(PChar(IncludeTrailingPathDelimiter(Repertoire)+NomFichier),PChar(IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier),false);
      DeleteFile(IncludeTrailingPathDelimiter(Repertoire)+NomFichier);
    NomFichier:=DM_C_NomFichierImportCAISSEMpCheque;
      CopyFile(PChar(IncludeTrailingPathDelimiter(Repertoire)+NomFichier),PChar(IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier),false);
      DeleteFile(IncludeTrailingPathDelimiter(Repertoire)+NomFichier);
    NomFichier:=DM_C_NomFichierImportCAISSEMpEspece;
      CopyFile(PChar(IncludeTrailingPathDelimiter(Repertoire)+NomFichier),PChar(IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier),false);
      DeleteFile(IncludeTrailingPathDelimiter(Repertoire)+NomFichier);
    NomFichier:=DM_C_NomFichierImportCAISSEMPVirement;
      CopyFile(PChar(IncludeTrailingPathDelimiter(Repertoire)+NomFichier),PChar(IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier),false);
      DeleteFile(IncludeTrailingPathDelimiter(Repertoire)+NomFichier);
    except
      on EInOutError do
      Messagedlg_lgr('Erreur d''E-S du fichier '+IncludeTrailingPathDelimiter(Repertoire)+'OLD_'+NomFichier,mtError,[mbOk],0);
    end;
end;


procedure TDMImport.Ta_PieceImportExistanteFilterRecordPourE2_Fac_et_Sara(DataSet: TDataSet;
  var Accept: Boolean);
begin
//ListePieceImportExistanteFilterRecord
accept:=ListePieceImportExistanteFilterRecord.indexof(DataSet.FindField('Libelle').asstring)<>-1;
end;


procedure TDMImport.Ta_PieceImportExistanteFilterRecordPourBLOQUEL(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=ListePieceImportExistanteFilterRecord.indexof(DataSet.FindField('Libelle').asstring)<>-1;
end;


Procedure TDMImport.VerifCreationPieceEcriture;
begin
if DMImport.Piece_Import=nil then
  DMImport.Piece_Import:=Tpiece.Create(Application.MainForm);
if DMImport.Ecriture_Import=nil then
  DMImport.Ecriture_Import:=TEcriture_Isa.Create(Application.MainForm);
//DMImport.Piece_Import.NouvellePiece(false);
end;



function CreationTiers(SourcePiece:TRecordPiece):TRecordPiece;overload;
var
TypeTiers:String[2];
editTemp:Tedit;
begin
try
editTemp:=Tedit.Create(application.MainForm);
edittemp.parent:=Application.MainForm;
//creation tiers
  if not empty(SourcePiece.Tiers) then
    begin//on regarde si le tiers existe, sinon on le crée directement
      if DMTiers = nil then DMTiers:=TDMTiers.Create(Application.MainForm);
      //if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
      if aidecompte=nil then aidecompte:=Taidecompte.Create(application.MainForm);
      DMTiers.Tag := 1; // Initialisation du tag pour les tiers
      DMTiers.TaTiersGest.AfterScroll := nil;
      DMTiers.TaTiersGest.findfield('Tiers').ReadOnly:=false;
      DMTiers.daTiersGest.OnStateChange := nil;
      DeFiltrageDataSet(dmrech.TaTiersRech);
      DeFiltrageDataSet(DMTiers.TaTiersGest);
      DMPlan.FiltrageAideCompte(96,nil,DMTiers.TaTiersGestFilterRecordAideCompte);
//      DMPieces.GestionFiltrageParamCpt(SourcePiece.IDJournal);
      edittemp.Text:=sourcePiece.Compte;
      if ((not empty(SourcePiece.Tiers))and(not empty(SourcePiece.Compte)))then
      begin
      if (not dmplan.CptEstCollectif(SourcePiece.Compte)) then
      begin
      ShowMessage('Le compte '+SourcePiece.Compte+' n''est pas collectif.'+RetourChariotSimple+'Vous devez en sélectionner un autre pour importer la facture '+sourcePiece.Reference);
      if not(AideCompteDansContexte(editTemp.Text,editTemp,['Rac1','Rac2','Rac3','Rac4','Rac5'],true,MessDerSub,true,true,false,true,0))then
         raise ExceptLGR.Create('Le compte '+SourcePiece.Compte+' n''est pas collectif.'+RetourChariotSimple+'Vous devez aller dans la gestion du plan comptable pour le rendre collectif '+RetourChariotSimple+'avant de vous en servir dans la gestion des Tiers.'+RetourChariotSimple+
       'La pièce '+SourcePiece.Reference+' ne peut pas être créée',1001,true,mtError);
      end;
      SourcePiece.Compte:=editTemp.Text;
      if not dmrech.TaTiersRech.Locate('Tiers',SourcePiece.Tiers,[]) then
         begin
             TypeTiers:=str_souschaine(SourcePiece.Compte,1,2);
             case strtoint_lgr(TypeTiers) of
                40:TypeTiers:='F';
                41:TypeTiers:='C';
                42:TypeTiers:='P';
                43:TypeTiers:='O';
                45:TypeTiers:='A';
                46:TypeTiers:='D';
                47:TypeTiers:='T';
             end;
         DMTiers.ImportTiers([sourcePiece.Tiers,
                      sourcePiece.NomTiers,
                      sourcePiece.Compte,
                      TypeTiers,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      sourcePiece.Addresse1,
                      sourcePiece.Addresse2,
                      sourcePiece.CodePostal,
                      sourcePiece.Ville,
                      sourcePiece.pays,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      'Import_E2Fac',
                      now,
                      true],DMTiers.TaTiersGest);
         DMTiers.TaTiersGest.Refresh;
         DMTiers.TaTiersGest.EnableControls;
         end;
      end;
    end;
finally
edittemp.free;
result:=sourcePiece;
end;
//fin creation tiers
end;

procedure CreationTiers(SourceEcriture:PRecordEcriture;Reference:String);
var
TypeTiers:String[2];
editTemp:Tedit;
begin
try
editTemp:=Tedit.Create(application.MainForm);
edittemp.parent:=Application.MainForm;
//creation tiers
  if not empty(SourceEcriture.CompteTiers) then
    begin//on regarde si le tiers existe, sinon on le crée directement
      if DMTiers = nil then DMTiers:=TDMTiers.Create(Application.MainForm);
      //if DMPlan = nil then DMPlan:=TDMPlan.Create(Application.MainForm);
      if aidecompte=nil then aidecompte:=Taidecompte.Create(application.MainForm);
      DMTiers.Tag := 1; // Initialisation du tag pour les tiers
      DMTiers.TaTiersGest.AfterScroll := nil;
      DMTiers.TaTiersGest.findfield('Tiers').ReadOnly:=false;
      DMTiers.daTiersGest.OnStateChange := nil;
      DeFiltrageDataSet(dmrech.TaTiersRech);
      DeFiltrageDataSet(DMTiers.TaTiersGest);
      DMPlan.FiltrageAideCompte(96,nil,DMTiers.TaTiersGestFilterRecordAideCompte);
      edittemp.Text:=SourceEcriture.Compte;
      if ((not empty(SourceEcriture.CompteTiers))and(not empty(SourceEcriture.Compte)))then
      begin

      if (not dmrech.TaTiersRech.Locate('Tiers',SourceEcriture.CompteTiers,[]) )and(not dmplan.CptEstCollectif(SourceEcriture.Compte)) then
      begin
      ShowMessage('Le compte '+SourceEcriture.Compte+' n''est pas collectif.'+RetourChariotSimple+'Vous devez en sélectionner un autre pour importer la facture '+Reference);
      if not(AideCompteDansContexte(editTemp.Text,editTemp,['Rac1','Rac2','Rac3','Rac4','Rac5'],true,MessDerSub,true,true,false,true,0))then
        raise ExceptLGR.Create('Le compte '+SourceEcriture.Compte+' n''est pas collectif.'+RetourChariotSimple+'Vous devez aller dans la gestion du plan comptable pour le rendre collectif '+RetourChariotSimple+'avant de vous en servir dans la gestion des Tiers.'+RetourChariotSimple+
       'La pièce '+Reference+' ne peut pas être créée',1001,true,mtError);
      end;
      SourceEcriture.Compte:=editTemp.Text;

      //if not dmplan.CptEstCollectif(SourceEcriture.Compte) then
      if not dmrech.TaTiersRech.Locate('Tiers',SourceEcriture.CompteTiers,[]) then
         begin
             TypeTiers:=str_souschaine(SourceEcriture.Compte,1,2);
             case strtoint_lgr(TypeTiers) of
                40:TypeTiers:='F';
                41:TypeTiers:='C';
                42:TypeTiers:='P';
                43:TypeTiers:='O';
                45:TypeTiers:='A';
                46:TypeTiers:='D';
                47:TypeTiers:='T';
             end;
         DMTiers.ImportTiers([SourceEcriture.CompteTiers,
                      SourceEcriture.NomTiers,
                      SourceEcriture.Compte,
                      TypeTiers,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      SourceEcriture.Addresse1,
                      SourceEcriture.Addresse2,
                      SourceEcriture.CodePostal,
                      SourceEcriture.Ville,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      nil,
                      'Import_E2Fac',
                      now,
                      true],DMTiers.TaTiersGest);
         DMTiers.TaTiersGest.Refresh;
         DMTiers.TaTiersGest.EnableControls;
         end;
      end;
      end;
//fin creation tiers
finally
editTemp.free;
end;
end;

procedure TDMImport.QuResultImportCalcFields(DataSet: TDataSet);
var
i:integer;
begin
  if(ListeCompteBilanOuverture<>nil)then
  begin
      i:=ListeCompteBilanOuverture.IndexOf(TaResultImportCompte.AsString);
      //if TaResultImportCompte.AsString = '131' then
      // showmessage('131 '+IntToStr(ListeCompteBilanOuverture.IndexOf(TaResultImportCompte.AsString)));
      if i <> -1 then
       begin
        QuResultImport.FindField('SoldeDebitBalImport').AsCurrency :=TMtBilanOuvertureImport(ListeCompteBilanOuverture.Objects[i]).MtDebit;
        QuResultImport.FindField('SoldeCreditBalImport').AsCurrency :=TMtBilanOuvertureImport(ListeCompteBilanOuverture.Objects[i]).MtCredit;
       end;
   end;
end;

procedure TDMImport.QuResultImportFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ListeFiltreCompteBilanOuverture.IndexOf(TaResultImportCompte.AsString) <> -1;
end;




end.
