{-----------------------------------------------------------------------------
 Unit Name: DMStocks
 Author:    Blanc Philippe
 Purpose:
 History:
 Initialisation de la Function InitialiseDMStocks avec TParamDMStocks
   Quand:Integer; Détermine si l'on est en Ouverture ou en cloture
   StocksDataStateChange:TNotifyEvent; : évènement à lier avec le dataset
   GEstInterfaceEvent:TGEstInterfaceEvent; évènement à lier avec le DataModule
                                           CEt évènement doit être créé dans le DM


   Création de l'évènement OnGEstInterfaceEvent
  private
     Déclarations privées
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

  Protected
     Déclarations protégées
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
-----------------------------------------------------------------------------}


unit DMStocks;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  LibSQL,
  DMPlanCpt,
  StdCtrls,
  E2_Decl_Records,
  RxMemDS,
  DMConstantes,
  DMRecherche,
  E2_LibInfosTable,
  Editions,
  ShellApi,
  LibDates,
  LibRessourceString,
  ObjetEdition,
  Lib_chaine,E2_VisuListeView;

type
//  TGEstInterfaceEvent=procedure(CCourant:Tfield;sender:TObject = nil) of object;
  TCtrlSaisie = function (CCourant:Tfield;appel:integer):TErreurSaisie of object;

  TEssaiStock = class (TDataModule)
//   ControleSaisie:function (CCourant:Tfield;appel:integer):TErreurSaisie of object;
//    Function CtrlSaisieStock(CCourant:Tfield;appel:integer):TErreurSaisie;

   Public
   ResultControleSaisie : Boolean;
   CodeResultControleSaisie : Integer;
   ControleSaisie:Function (CCourant:Tfield;appel:integer):TErreurSaisie of object;
end;

  TParamDMStocks=Record
   Quand:Integer;
   StocksDataStateChange:TNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
  end;

  TInfosDMStocks=Record
    NbStocksOuverture:Integer;
    ResteStocksOuvertureAReprendre:Boolean;
    NbStocksOuvertureAReprendre:Integer;
    NbStocksCloture:Integer;
   end;

  TDMStock = class(TDataModule)
    DataStock: TDataSource;
    TaStock: TTable;
    TaStockID: TIntegerField;
    TaStockCompte: TStringField;
    TaStockQte: TFloatField;
    TaStockPrix_Unitaire: TFloatField;
    TaStockDecote: TSmallintField;
    TaStockMontantTotalHT: TFloatField;
    TaStockActif: TBooleanField;
    TaStockDate_Saisie: TDateField;
    TaStockDate_ID_Exercice: TDateField;
    TaStockDate_Piece: TDateField;
    TaStockReference: TStringField;
    TaStockConsultation: TTable;
    DataStockConsultation: TDataSource;
    TaStockConsultationID: TIntegerField;
    TaStockConsultationCompte: TStringField;
    TaStockConsultationQte: TFloatField;
    TaStockConsultationPrix_Unitaire: TFloatField;
    TaStockConsultationDecote: TSmallintField;
    TaStockConsultationMontantTotalHT: TFloatField;
    TaStockConsultationActif: TBooleanField;
    TaStockConsultationDate_Saisie: TDateField;
    TaStockConsultationDate_ID_Exercice: TDateField;
    TaStockConsultationDate_Piece: TDateField;
    TaStockConsultationReference: TStringField;
    TaStock2: TTable;
    TaStock2ID: TIntegerField;
    TaStock2Compte: TStringField;
    TaStock2Qte: TFloatField;
    TaStock2Prix_Unitaire: TFloatField;
    TaStock2Decote: TSmallintField;
    TaStock2MontantTotalHT: TFloatField;
    TaStock2Actif: TBooleanField;
    TaStock2Date_Saisie: TDateField;
    TaStock2Date_ID_Exercice: TDateField;
    TaStock2Date_Piece: TDateField;
    TaStock2Reference: TStringField;
    TaStockDesignation: TStringField;
    TaStockConsultationDesignation: TStringField;
    TaStock2Designation: TStringField;
    Tastocks3: TTable;
    Tastocks3ID: TIntegerField;
    Tastocks3Compte: TStringField;
    Tastocks3Designation: TStringField;
    Tastocks3Qte: TFloatField;
    Tastocks3Prix_Unitaire: TCurrencyField;
    Tastocks3Decote: TSmallintField;
    Tastocks3MontantTotalHT: TCurrencyField;
    Tastocks3Actif: TBooleanField;
    Tastocks3Date_Saisie: TDateField;
    Tastocks3Date_ID_Exercice: TDateField;
    Tastocks3Date_Piece: TDateField;
    Tastocks3Reference: TStringField;
    TaStockEcritureReference: TTable;
    TaStockMaint: TTable;
    TaStockMaintS: TTable;
    QuListeValRupt: TQuery;
    QuSousTotal: TQuery;
    QuTotalG: TQuery;
    QuListeValRuptcompte: TStringField;
    QuListeValRuptLibelle: TStringField;
    QuStocksEdition: TQuery;
    QuStocks_Edition:TQuery;
    procedure DMStockCreate(Sender: TObject);
    procedure DMStockDestroy(Sender: TObject);
    procedure DemandeAffichageReprise(Situation:Tdatetime;Caption:string);
    function CreationListeOD(DateExo:TDateTime):TStringList;
    procedure CreationODStockOuverture;
    Procedure EcritureReference(ID:integer;Changerdate:boolean;Ref:string;Date:Tdatetime);
    Function CtrlSaisieStock(CCourant:Tfield;appel:integer):TErreurSaisie;
    procedure TaStockBeforePost(DataSet: TDataSet);
    procedure TaStockAfterPost(DataSet: TDataSet);
    procedure TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;EtatTaStock:TDataSetState;Ref:string);
    function  RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
    procedure TaStockBeforeEdit(DataSet: TDataSet);
    procedure TaStockBeforeDelete(DataSet: TDataSet);
    procedure TaStockAfterInsert(DataSet: TDataSet);
    procedure TaStockAfterEdit(DataSet: TDataSet);
    function FiltragePourAffichageOD(Situation:TDateTime;Dataset:TDataset=nil):Boolean;
    procedure CreationODStockCloture;
    procedure TaStockAfterDelete(DataSet: TDataSet);
    function CalculPrixUnitaire:boolean;
    function CalculDecote:boolean;
    function calculMontantTotal:boolean;
    procedure TaStockPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaStockDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaStockBeforeClose(DataSet: TDataSet);
    procedure TaStockBeforeInsert(DataSet: TDataSet);
    procedure TaStockBeforeEIDOuv_Abort(DataSet: TDataSet);
    procedure TaStockBeforeEIDClo_Abort(DataSet: TDataSet);
    procedure TraitementCloture1001(sender:Tobject);
    procedure TraitementCloture1000(sender:Tobject);
    procedure TraitementCloture1002(sender:Tobject);
    procedure Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
    procedure TaStockAfterOpen(DataSet: TDataSet);
    procedure CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure CreationODReprise_avecObjet(TableEnCours:TTable;ODModif:string);
    Function ListeCptStocksUtiliseManuellement(Ouverture:Boolean):TStringList;
    procedure TaStockBeforeCancel(DataSet: TDataSet);
    procedure TaCompteFilterRecordCompteImmobilisable(DataSet: TDataSet; var Accept: Boolean);
    procedure GestionFiltrageParamCpt;
    procedure QuListeValRuptCalcFields(DataSet: TDataSet);
    Procedure GestionAccesStocks;
    procedure QuStocks_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    Procedure AnnuleRepriseStocks(DataSet:TDataSet);
  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

  Protected
    { Déclarations protégées }

  public
    { Déclarations publiques }
    DernierChampSaisi:integer;
    EssaiStock:TEssaiStock;
    ListeEdit:TStringList;
    Quand:Integer;
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
    Procedure ImportStocks(Valeurs:array of const;DataSet:TDataSet);
  end;

var
  DMStock: TDMStock;
  EtatTable:tdatasetstate;
  dernierlibelle:string;
  MessDerSub:boolean;
  InfosStock,InfosStockTmp:TInfosStock;
  Function InitialiseDMStocks(ParamDMStocks:TParamDMStocks):TInfosDMStocks;
  Function EditionStock(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionStockL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;ListeCompte:TStringList;Relance:boolean=false):TStringList;overload;
  Function EditionStockL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;Compte:String;Relance:boolean=false):TStringList;overload;

  function VerifRepriseStockOuverture_OK(var messageTmp:TMessages):boolean;
  function VerifExistStockCloture(var messageTmp:TMessages):boolean;
  function VerifExistStockOuverture(var messageTmp:TMessages):boolean;

implementation

uses DMPiece, E2_AideCompte,DMBalances,E2_Main,
  DMImportation,DMBaseDonnee, DMDiocEtatBalance;

{$R *.DFM}

// C_Ouverture = 0;
// C_Cloture = 1;
// C_Mouvement = 2;
Function InitialiseDMStocks(ParamDMStocks:TParamDMStocks):TInfosDMStocks;
Begin
 if DMStock=nil then DMStock:=TDMStock.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 result.NbStocksCloture:=0;
 result.NbStocksOuverture:=0;
 result.NbStocksOuvertureAReprendre:=0;
 result.ResteStocksOuvertureAReprendre:=false;
 DMStock.Quand := ParamDMStocks.Quand;
 if DMStock.Quand = C_InfoEpicea then
  begin
     FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie'],['true',datetostr(E.DatExoDebut-1)]));
     Result.NbStocksOuverture:= DMRech.TaStockRech.RecordCount;

     
     FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie'],['true',datetostr(E.DatExoFin)]));
     Result.NbStocksCloture := DMRech.TaStockRech.RecordCount;

  end;
     //tronc commun
     FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie','Reference'],['True',DateToStr(E.DatExoDebut - 1),'']));
     Result.ResteStocksOuvertureAReprendre := DMRech.TaStockRech.RecordCount <> 0;
     Result.NbStocksOuvertureAReprendre := DMRech.TaStockRech.RecordCount;
     //fin tronc commun
     
 DMStock.OnGEstInterfaceEvent := ParamDMStocks.GEstInterfaceEvent;
  case DMStock.DataStock.State of
    dsBrowse:Begin
              case DMStock.Quand of
                  C_Ouverture : FiltrageDataSet(DMStock.TaStock,CreeFiltreET(['Actif','Date_Saisie'],['true',datetostr(E.DatExoDebut-1)]));
                  C_Cloture : FiltrageDataSet(DMStock.TaStock,CreeFiltreET(['Actif','Date_Saisie'],['true',datetostr(E.DatExoFin)]));
              end;//fin du case
              DMStock.DataStock.OnStateChange:=ParamDMStocks.StocksDataStateChange;
             End;
    dsInsert,dsEdit:Begin

                    End;
  end;
End;

Function EditionStockL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;Compte:String;Relance:boolean):TStringList;
Var
ListeCompte:TStringList;
Begin
ListeCompte:=TStringList.Create;
ListeCompte.Add(Compte);
result:=EditionStockL(TypeEdition,Quand,DataSet,ListeCompte,relance);
End;

Function EditionStockL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;ListeCompte:TStringList;Relance:boolean):TStringList;
var
NomFich,Chemin:String;
NomMenuSiteWeb:TfileStream;
Qte:Integer;
Decote:Integer;
TotalPrix_Unitaire,TotalQte,TotalMontantTotalHT:Currency;
TotalGenPrix_Unitaire,TotalGenQte,TotalGenMontantTotalHT:Currency;
ListeValeur:TStringList;
ListeEdition:TStringList;
ValeurCompte:String;
ObjPrn:TObjetEdition;
TitreCompte:string;
Delimiteur:Char;
Begin
try
// Delimiteur:=DM_C_Delimiteur;
 Delimiteur:=';';
 ObjPrn:=TObjetEdition.Create(application.MainForm);
 Chemin :=E.RepertoireComptaWeb;
 case Quand of
    C_Ouverture:NomFich:='StocksOuv';
    C_Cloture:NomFich:='StocksClo';
 end;


 if DMStock=nil then DMStock:=TDMStock.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
   // Inutile dans Stocks pour l'instant
  end;
 ListeValeur:=TStringList.Create;
 ListeEdition:=TStringList.Create;
 ObjPrn.FontLigneSeule.Style := [fsBold];

 DMStock.QuStocks_Edition.OnFilterRecord :=nil;
 
 if ListeCompte <> nil then
  begin
   TitreCompte:='Du compte :'+ListeCompte.Strings[0]+' au compte :'+ListeCompte.Strings[ListeCompte.count-1];
   DMStock.ListeEdit.Assign(ListeCompte);
   DeFiltrageDataSet(DMStock.QuStocks_Edition);
   DMStock.QuStocks_Edition.OnFilterRecord :=DMStock.QuStocks_EditionFilterRecord;
   FiltrageDataSet(DMStock.QuStocks_Edition,'');
  end
 else
  begin
    DMStock.QuStocks_Edition.OnFilterRecord :=nil;
    TitreCompte:=' Tous les comptes ';
  end;

 case Quand of
    C_Ouverture:begin

                 DMStock.QuStocks_Edition.SQL.Clear;
                 DMStock.QuStocks_Edition.Params.Clear;
                 DMStock.QuStocks_Edition.SQL.Add('select * from stock.db ');
                 DMStock.QuStocks_Edition.SQL.Add(' where Actif=true and Date_Saisie =:DateANouveau');
                 DMStock.QuStocks_Edition.SQL.Add(' order by compte');
                 DMStock.QuStocks_Edition.Params[0].DataType := ftDAte;
                 DMStock.QuStocks_Edition.Params[0].AsDate := E.DatExoDebut -1;
                 DMStock.QuStocks_Edition.Open;
                 if DMStock.QuStocks_Edition.recordcount<>0 then
                 begin
                 TotalPrix_Unitaire:=0;
                 TotalQte:=0;
                 TotalMontantTotalHT:=0;
                    ListeEdition.Add('Stocks'+
                                     Delimiteur+
                                     'Compte'+
                                     Delimiteur+
                                     'Désignation'+
                                     Delimiteur+
                                     'Qté'+
                                     Delimiteur+
                                     'Prix Unitaire'+
                                     Delimiteur+
                                     'Décote'+
                                     Delimiteur+
                                     'Montant HT'
                                     );

                 DMStock.QuStocks_Edition.First;
                 while not DMStock.QuStocks_Edition.Eof do
                   begin
                    ValeurCompte:=DMStock.QuStocks_Edition.FindField('Compte').AsString;
                    TotalMontantTotalHT:=DMStock.QuStocks_Edition.FindField('MontantTotalHT').AsCurrency + TotalMontantTotalHT;
                    TotalPrix_Unitaire:=DMStock.QuStocks_Edition.FindField('Prix_Unitaire').AsCurrency +TotalPrix_Unitaire;
                    TotalQte:=DMStock.QuStocks_Edition.FindField('Qte').AsCurrency +TotalQte;
                    ListeEdition.Add('Stocks'+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Compte').AsString+
                                     Delimiteur+
                                     GereLibelle(DMStock.QuStocks_Edition.FindField('Designation').AsString)+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Qte').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Prix_Unitaire').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Decote').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('MontantTotalHT').AsString
                                     );
                    ListeValeur.Add('0'+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Compte').AsString+
                                     Delimiteur+
                                     GereLibelle(DMStock.QuStocks_Edition.FindField('Designation').AsString)+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Qte').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Prix_Unitaire').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Decote').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('MontantTotalHT').AsString
                                     );
                    DMStock.QuStocks_Edition.Next;
                    if ValeurCompte <> DMStock.QuStocks_Edition.FindField('Compte').AsString then
                     begin
                      ListeValeur.Add('1'+Delimiteur+Delimiteur+' @TOTAL DU COMPTE  '+ValeurCompte+' : '+delimiteur+CurrToStr(TotalQte)+delimiteur+CurrToStr(TotalPrix_Unitaire)+delimiteur+delimiteur+' '+CurrToStr(TotalMontantTotalHT)+delimiteur);
                      ValeurCompte:=DMStock.QuStocks_Edition.FindField('Compte').AsString;
                      TotalGenPrix_Unitaire:=TotalGenPrix_Unitaire+TotalPrix_Unitaire;
                      TotalGenQte:=TotalGenQte+TotalQte;
                      TotalGenMontantTotalHT:=TotalGenMontantTotalHT+TotalMontantTotalHT;
                      TotalPrix_Unitaire:=0;
                      TotalQte:=0;
                      TotalMontantTotalHT:=0;
                     end;
                   end;
                 ListeValeur.Add('1'+Delimiteur+Delimiteur+' @TOTAL DU COMPTE  '+ValeurCompte+' : '+delimiteur+CurrToStr(TotalQte)+delimiteur+CurrToStr(TotalPrix_Unitaire)+delimiteur+delimiteur+' '+CurrToStr(TotalMontantTotalHT)+delimiteur);
                 TotalGenPrix_Unitaire:=TotalGenPrix_Unitaire+TotalPrix_Unitaire;
                 TotalGenQte:=TotalGenQte+TotalQte;
                 TotalGenMontantTotalHT:=TotalGenMontantTotalHT+TotalMontantTotalHT;
                 ListeValeur.Add('1'+Delimiteur+Delimiteur+' @TOTAL GENERAL : '+delimiteur+CurrToStr(TotalGenQte)+delimiteur+CurrToStr(TotalGenPrix_Unitaire)+delimiteur+delimiteur+' '+CurrToStr(TotalGenMontantTotalHT)+delimiteur);
                 TotalPrix_Unitaire:=0;
                 TotalQte:=0;
                 TotalMontantTotalHT:=0;
                 DMStock.QuStocks_Edition.Close;
                 ObjPrn.FTitreEdition := 'Etat des Stocks à l''ouverture';
                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ListeValeur.Insert(0,' Compte '+Delimiteur+' Désignation '+Delimiteur+' Qté '+Delimiteur+' Prix Unitaire '+Delimiteur+' Décote '+Delimiteur+' Montant Total HT ');
                 ListeValeur.Insert(1,'0.6'+Delimiteur+'2'+Delimiteur+'0.8'+Delimiteur+'1.0'+Delimiteur+'0.5'+Delimiteur+'1.8');
                 ListeValeur.Insert(2,'texte'+Delimiteur+'texte'+Delimiteur+'Float'+Delimiteur+'curr'+Delimiteur+'curr'+Delimiteur+'curr');
                 ObjPrn.FDelimiteur:=Delimiteur;
                 end;
                 ObjPrn.AffichageImp(ListeValeur);
                end;

    C_Cloture: begin
                 DMStock.QuStocks_Edition.SQL.Clear;
                 DMStock.QuStocks_Edition.Params.Clear;
                 DMStock.QuStocks_Edition.SQL.Add('select * from stock.db ');
                 DMStock.QuStocks_Edition.SQL.Add(' where Actif=true and Date_Saisie =:DateANouveau');
                 DMStock.QuStocks_Edition.SQL.Add(' order by compte');
                 DMStock.QuStocks_Edition.Params[0].DataType := ftDAte;
                 DMStock.QuStocks_Edition.Params[0].AsDate := E.DatExoFin;
                 DMStock.QuStocks_Edition.Open;
                 if DMStock.QuStocks_Edition.recordcount<>0 then
                 begin
                    ListeEdition.Add('Stocks'+
                                     Delimiteur+
                                     'Compte'+
                                     Delimiteur+
                                     'Désignation'+
                                     Delimiteur+
                                     'Qté'+
                                     Delimiteur+
                                     'Prix Unitaire'+
                                     Delimiteur+
                                     'Décote'+
                                     Delimiteur+
                                     'Montant HT'
                                     );
                 TotalPrix_Unitaire:=0;
                 TotalQte:=0;
                 TotalMontantTotalHT:=0;
              DMStock.QuStocks_Edition.First;
                 while not DMStock.QuStocks_Edition.Eof do
                   begin
                    ValeurCompte:=DMStock.QuStocks_Edition.FindField('Compte').AsString;
                    TotalMontantTotalHT:=DMStock.QuStocks_Edition.FindField('MontantTotalHT').AsCurrency + TotalMontantTotalHT;
                    TotalPrix_Unitaire:=DMStock.QuStocks_Edition.FindField('Prix_Unitaire').AsCurrency +TotalPrix_Unitaire;
                    TotalQte:=DMStock.QuStocks_Edition.FindField('Qte').AsCurrency +TotalQte;
                    ListeEdition.Add('Stocks'+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Compte').AsString+
                                     Delimiteur+
                                     GereLibelle(DMStock.QuStocks_Edition.FindField('Designation').AsString)+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Qte').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Prix_Unitaire').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Decote').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('MontantTotalHT').AsString
                                     );
                    ListeValeur.Add('0'+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Compte').AsString+
                                     Delimiteur+
                                     GereLibelle(DMStock.QuStocks_Edition.FindField('Designation').AsString)+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Qte').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Prix_Unitaire').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('Decote').AsString+
                                     Delimiteur+
                                     DMStock.QuStocks_Edition.FindField('MontantTotalHT').AsString
                                     );
                    DMStock.QuStocks_Edition.Next;
                    if ValeurCompte <> DMStock.QuStocks_Edition.FindField('Compte').AsString then
                     begin
                      ListeValeur.Add('1'+Delimiteur+Delimiteur+' @TOTAL DU COMPTE  '+ValeurCompte+' : '+Delimiteur+CurrToStr(TotalQte)+Delimiteur+CurrToStr(TotalPrix_Unitaire)+Delimiteur+' '+delimiteur+CurrToStr(TotalMontantTotalHT)+Delimiteur);
                      ValeurCompte:=DMStock.QuStocks_Edition.FindField('Compte').AsString;
                      TotalGenPrix_Unitaire:=TotalGenPrix_Unitaire+TotalPrix_Unitaire;
                      TotalGenQte:=TotalGenQte+TotalQte;
                      TotalGenMontantTotalHT:=TotalGenMontantTotalHT+TotalMontantTotalHT;
                      TotalPrix_Unitaire:=0;
                      TotalQte:=0;
                      TotalMontantTotalHT:=0;
                     end;
                   end;
                   
                ListeValeur.Add('1;; @TOTAL DU COMPTE  '+ValeurCompte+' : '+Delimiteur+CurrToStr(TotalQte)+Delimiteur+CurrToStr(TotalPrix_Unitaire)+Delimiteur+' '+delimiteur+CurrToStr(TotalMontantTotalHT)+Delimiteur);
                TotalGenPrix_Unitaire:=TotalGenPrix_Unitaire+TotalPrix_Unitaire;
                TotalGenQte:=TotalGenQte+TotalQte;
                TotalGenMontantTotalHT:=TotalGenMontantTotalHT+TotalMontantTotalHT;
                ListeValeur.Add('1'+Delimiteur+Delimiteur+' @TOTAL GENERAL : '+delimiteur+CurrToStr(TotalGenQte)+delimiteur+CurrToStr(TotalGenPrix_Unitaire)+delimiteur+delimiteur+' '+CurrToStr(TotalGenMontantTotalHT)+delimiteur);
                TotalPrix_Unitaire:=0;
                TotalQte:=0;
                TotalMontantTotalHT:=0;
                DMStock.QuStocks_Edition.Close;
                ObjPrn.FTitreEdition := 'Etat des Stocks à la clôture';
                ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoFin).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier;
                ListeValeur.Insert(0,' Compte '+Delimiteur+' Désignation '+Delimiteur+' Qté '+Delimiteur+' Prix Unitaire '+Delimiteur+' Décote '+Delimiteur+' Montant Total HT ');
                ListeValeur.Insert(1,'0.6'+Delimiteur+'2'+Delimiteur+'0.8'+Delimiteur+'1.0'+Delimiteur+'0.5'+Delimiteur+'1.8');
                ListeValeur.Insert(2,'texte'+Delimiteur+'texte'+Delimiteur+'Float'+Delimiteur+'curr'+Delimiteur+'curr'+Delimiteur+'curr');
                ObjPrn.FDelimiteur:=Delimiteur;
                end;
          if(relance)then
            result:=ListeEdition
          else
          ObjPrn.AffichageImp(ListeValeur);
                end;
 end;
Finally
   DeFiltrageDataSet(DMStock.QuStocks_Edition);
   DMStock.QuStocks_Edition.OnFilterRecord :=nil;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
End;

Function EditionStock(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
Begin

 Chemin :=E.RepertoireComptaWeb;
 case Quand of
    C_Ouverture:NomFich:='StocksOuv';
    C_Cloture:NomFich:='StocksClo';
 end;


 if DMStock=nil then DMStock:=TDMStock.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
   // Inutile dans Stocks pour l'instant 
  end;
 case Quand of
    C_Ouverture:begin
                 DMStock.QuListeValRupt.SQL.Clear;
                 DMStock.QuListeValRupt.SQL.Add('select distinct compte from stock.db where ');
                 DMStock.QuListeValRupt.SQL.Add('Actif=true and Date_Saisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMStock.QuListeValRupt.Open;

                 DMStock.QuSousTotal.SQL.Clear;
                 DMStock.QuSousTotal.Params.Clear;
                 DMStock.QuSousTotal.SQL.Add('select sum(qte), sum(prix_unitaire),0,sum(MontantTotalHT) ');
                 DMStock.QuSousTotal.SQL.Add('from stock.db where compte =:compte ');
                 DMStock.QuSousTotal.SQL.Add('and Actif=true and Date_Saisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMStock.QuSousTotal.Params[0].DataType := ftString;
                 DMStock.QuSousTotal.Open;

                 DMStock.QuTotalG.SQL.Clear;
                 DMStock.QuTotalG.SQL.Add('select sum(MontantTotalHT) from stock.db where ');
                 DMStock.QuTotalG.SQL.Add(' Actif=true and Date_Saisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMStock.QuTotalG.Open;

                 DMStock.QuStocksEdition.SQL.Clear;
                 DMStock.QuStocksEdition.SQL.Add('Select * from Stock where ');
                 DMStock.QuStocksEdition.SQL.Add('Actif=true and Date_Saisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMStock.QuStocksEdition.Open;
                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := false;
                                    // EditStock(Chemin,NomFich,DMStock.QuStocksEdition,'Compte',DMStock.QuListeValRupt,DMStock.QuSousTotal,DMStock.QuTotalG,DateToStr(E.DatExoDebut),Site);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///C:/Js/Epicea-2/Sources/Stock.xml'),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := false;
                                     //LienEditStock(NomMenuSiteWeb,Chemin,NomFich,DMStock.QuStocksEdition,'Compte',DMStock.QuListeValRupt,DMStock.QuSousTotal,DMStock.QuTotalG,DateToStr(E.DatExoDebut),Site);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///C:/Js/Epicea-2/Sources/Stock.xml'),nil,sw_show);
                                 End;
                 end;
                 DMStock.QuListeValRupt.Close;
                 DMStock.QuSousTotal.Close;
                 DMStock.QuTotalG.Close;
                 DMStock.QuStocksEdition.Close;
                end;

    C_Cloture: begin
                 DMStock.QuListeValRupt.SQL.Clear;
                 DMStock.QuListeValRupt.SQL.Add('select distinct compte from stock.db where ');
                 DMStock.QuListeValRupt.SQL.Add('Actif=true and Date_Saisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMStock.QuListeValRupt.Open;

                 DMStock.QuSousTotal.SQL.Clear;
                 DMStock.QuSousTotal.Params.Clear;
                 DMStock.QuSousTotal.SQL.Add('select sum(qte), sum(prix_unitaire),0,sum(MontantTotalHT) ');
                 DMStock.QuSousTotal.SQL.Add('from stock.db where compte =:compte ');
                 DMStock.QuSousTotal.SQL.Add('and Actif=true and Date_Saisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMStock.QuSousTotal.Params[0].DataType := ftString;
                 DMStock.QuSousTotal.Open;

                 DMStock.QuTotalG.SQL.Clear;
                 DMStock.QuTotalG.SQL.Add('select sum(MontantTotalHT) from stock.db where ');
                 DMStock.QuTotalG.SQL.Add(' Actif=true and Date_Saisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMStock.QuTotalG.Open;

                 DMStock.QuStocksEdition.SQL.Clear;
                 DMStock.QuStocksEdition.SQL.Add('Select * from Stock where ');
                 DMStock.QuStocksEdition.SQL.Add('Actif=true and Date_Saisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMStock.QuStocksEdition.Open;

                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := False;
                                     //EditStock(Chemin,NomFich,DMStock.QuStocksEdition,'Compte',DMStock.QuListeValRupt,DMStock.QuSousTotal,DMStock.QuTotalG,DateToStr(E.DatExoFin),Site);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///'+Chemin+NomFich+'.xml'),nil,sw_show);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///C:/Js/Epicea-2/Sources/Stock.xml'),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := False;
                                     //EditStock(Chemin,NomFich,DMStock.QuStocksEdition,'Compte',DMStock.QuListeValRupt,DMStock.QuSousTotal,DMStock.QuTotalG,DateToStr(E.DatExoFin),Site);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///C:/Js/Epicea-2/Sources/Stock.xml'),nil,sw_show);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///'+E.RepertoireComptaWeb+NomFich+'.xml'),nil,sw_show);
                                 End;
                 end;
                 DMStock.QuListeValRupt.Close;
                 DMStock.QuSousTotal.Close;
                 DMStock.QuTotalG.Close;
                 DMStock.QuStocksEdition.Close;
                end;
 end;
End;

function TDMStock.CalculPrixUnitaire:boolean;
begin
result:=false;
  if empty(TaStockPrix_Unitaire.asstring)then
  TaStockPrix_Unitaire.AsCurrency:=0;
  if TaStockPrix_Unitaire.AsCurrency<>0 then
    begin
    TaStockMontantTotalHT.AsCurrency:=TaStockQte.AsCurrency*(TaStockPrix_Unitaire.AsCurrency-
    ((TaStockPrix_Unitaire.AsCurrency * TaStockDecote.AsInteger) /100));
    result:=true;
    TaStockMontantTotalHT.AsCurrency:=arrondicentieme(TaStockMontantTotalHT.AsCurrency);
    end
    else
    Begin
    TaStockMontantTotalHT.AsCurrency:=0;
    End;
end;

function TDMStock.CalculDecote:boolean;
begin
result:=false;
  if empty(TaStockDecote.asstring)then
  TaStockDecote.AsFloat:=0;
  if TaStockPrix_Unitaire.AsCurrency<>0 then
    begin
    TaStockMontantTotalHT.AsCurrency:=TaStockQte.AsCurrency*(TaStockPrix_Unitaire.AsCurrency-
    ((TaStockPrix_Unitaire.AsCurrency * TaStockDecote.AsInteger) /100));
    result:=true;
    TaStockMontantTotalHT.AsCurrency:=arrondicentieme(TaStockMontantTotalHT.AsCurrency);
    if empty(TaStockMontantTotalHT.Asstring)then
    TaStockMontantTotalHT.AsCurrency:=0;
    if empty(TaStockPrix_Unitaire.Asstring)then
    TaStockPrix_Unitaire.AsCurrency:=0;
    result:=not ((TaStockMontantTotalHT.AsCurrency=0) and (TaStockPrix_Unitaire.AsCurrency=0));
    end
  else
    if (TaStockMontantTotalHT.AsCurrency<>0)or (not(empty(TaStockMontantTotalHT.AsString))) then
      begin
      TaStockPrix_Unitaire.AsCurrency:=(100*TaStockMontantTotalHT.AsCurrency)/
      (TaStockQte.AsFloat*(100- TaStockDecote.AsInteger));
      result:=true;
      TaStockPrix_Unitaire.AsCurrency:=arrondicentieme(TaStockPrix_Unitaire.AsCurrency);
      if empty(TaStockMontantTotalHT.Asstring)then
    TaStockMontantTotalHT.AsCurrency:=0;
    if empty(TaStockPrix_Unitaire.Asstring)then
    TaStockPrix_Unitaire.AsCurrency:=0;
      result:=not ((TaStockMontantTotalHT.AsCurrency=0) and (TaStockPrix_Unitaire.AsCurrency=0));
      end;
end;


function TDMStock.calculMontantTotal:boolean;
begin
result:=false;
 if empty(TaStockMontantTotalHT.asstring) then
   TaStockMontantTotalHT.AsCurrency:=0;
 if TaStockMontantTotalHT.AsCurrency<>0 then
   begin
   TaStockPrix_Unitaire.AsCurrency:=(100*TaStockMontantTotalHT.AsCurrency)/
   (TaStockQte.AsFloat*(100- TaStockDecote.AsInteger));
   result:=true;
   TaStockPrix_Unitaire.AsCurrency:=arrondicentieme(TaStockPrix_Unitaire.AsCurrency);
   end
   else
   begin
   TaStockPrix_Unitaire.AsCurrency:=0;
   end;
end;

Function TDMStock.CtrlSaisieStock(CCourant:Tfield;appel:integer):TErreurSaisie;
var
RetourEnregistrement:TEnregistrementComplet;
begin // initialisation des variables de retour de fonction
CtrlSaisieStock.CodeErreur:=0;
CtrlSaisieStock.Retour:=True;
  if TaStock.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
        case CCourant.Index of
        1: Begin     //Compte stocks
         GestionFiltrageParamCpt;
         if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
            Begin
              CtrlSaisieStock.CodeErreur:=1001;
              CtrlSaisieStock.Retour:=false;
            End
            else
            if Quand = C_Ouverture then
               begin
               if VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCourant.DataSet) then
                begin
                 if assigned(FOnGEstInterfaceEvent) then FOnGEstInterfaceEvent(CCourant);
                 CtrlSaisieStock.CodeErreur:=1001;  //Compte déjà utilisé dans BO
                 CtrlSaisieStock.Retour:=false;
                end;
               end
             else
            Begin
              RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaStockCompte.AsString);
                  if not(empty(RetourEnregistrement.Libelle)) then
                  begin
                     if (empty(TaStockDesignation.AsString)) then
                     TaStockDesignation.AsString:=RetourEnregistrement.Libelle
                     else
                       if (TaStockDesignation.AsString=trim(dernierlibelle)) then
                       TaStockDesignation.AsString:=RetourEnregistrement.Libelle;
                  DernierLibelle:=RetourEnregistrement.Libelle;
                  end;
            end;

       end;
        2: Begin     // Designation du stock
                // Le champ est vide, affectation du libellé utilisateur par défaut
          If Empty(CCourant.AsString) then
             begin
             RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaStockCompte.AsString);
                if not(empty(RetourEnregistrement.Libelle)) then
                begin
                   ccourant.AsString:=RetourEnregistrement.Libelle;
                   DernierLibelle:=RetourEnregistrement.Libelle;
                end;
             end
          else//s'il est rempli, on regarde si le libelle ne correspond pas au dernier
          //compte saisi !!! si oui, on lui affecte le libelle correspond au nouveau compte
          //saisi
             begin
               if ccourant.AsString=DernierLibelle then
               RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaStockCompte.AsString);
                if not(empty(RetourEnregistrement.Libelle)) then
                   begin
                   ccourant.AsString:=RetourEnregistrement.Libelle;
                   DernierLibelle:=RetourEnregistrement.Libelle;
                   end;
             end;
        end;
        3: begin//si champ n°3 (Qté)
            If (Empty(CCourant.AsString))or (trim(ccourant.AsString)='0') then
             CCourant.AsString:='1';
           end;//fin si champ n°3 (Qté)
        4: begin//si champ n°4 (Prix_Unitaire)
               if appel=1 then //si appel colExit
                CalculPrixUnitaire
           end;//fin si champ n°4 (Prix_Unitaire)
        5: begin//si champ n°5 (Decote)
             if appel=1 then
             CalculDecote;
           end;//fin si champ n°5 (Decote)
        6: begin//si champ n°6 (Montant HT)
             if appel=1 then
             calculMontantTotal;
           end;//fin si champ n°6 (Montant HT)
        end;//fin du case.ccourant
  end; //fin etat insertion ou modif
//  Erreur:=result;
//EssaiStock.ResultControleSaisie:=result.Retour;
//EssaiStock.CodeResultControleSaisie:=result.CodeErreur;
end;

procedure TDMStock.DemandeAffichageReprise(Situation:Tdatetime;Caption:string);
begin
DMPieces.AffichageFeuilleReprise(0,CreationListeOD(Situation),nil,Caption,'','',false);
end;


function TDMStock.CreationListeOD(DateExo:TDateTime):TStringList;
begin
try
FiltrageDataSet(TaStock,'Date_Saisie = '''+DateTimeToStr(DateExo)+''' And Reference <> ''''');
result:=TStringList.Create;
result.Clear;
  While (Not(TaStock.EOF)) Do
     Begin
         If result.IndexOf(TaStockReference.AsString) = -1 Then
            result.Add(TaStockReference.AsString);
         TaStock.Next;
     End;
except
  result.clear;
end;//fin du try except
end;

procedure TDMStock.CreationODStockOuverture;
var
SoldeCompte:TSoldeCompte;
Except_LGR:TExceptLGR;
ParamAffichage:TParamAffichage;
NbEnregistrement,i:integer;
begin
Initialise_ExceptLGR(Except_LGR);
    try
    // On filtre la table pour la reprise à l'ouverture
    FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie','Reference'],['True',DateToStr(E.DatExoDebut - 1),'']));
    TableGereStartTransaction(DMRech.TaStockRech);
    if DMRech.TaStockRech.RecordCount<>0then
       begin
       NbEnregistrement:=DMRech.TaStockRech.RecordCount;
       DMRech.TaStockRech.first;
       // Tant qu'il reste des enregistrements dans la table TaStockConsultation
        While (Not(NbEnregistrement=0)) Do
        Begin
         Except_LGR:=PossibiliteRepriseCompte(DMRech.TaStockRech.findfield('Compte').Asstring,DMRech.TaStockRech,'D','Stocks');
//           try//except
//               Except_LGR.retour:=true;
//               Except_LGR.NumErreur:=0;
//               SoldeCompte:=DMBalance.RetourneSoldeCompteAvantReprise(DMRech.TaStockRech.findfield('Compte').Asstring,DMRech.TaStockRech,0,'D');
//               if ((SoldeCompte.SoldeBO.Retour)and(SoldeCompte.SoldeBalance.Retour)) then //importation
//                 begin
//                    if ((SoldeCompte.SoldeBO.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeBO.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                      raise ExceptLGR.Create('',1,false,mtError,Except_LGR);
//                    if ((SoldeCompte.SoldeCharge.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeCharge.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                      raise ExceptLGR.Create('',2,false,mtError,Except_LGR);
//                 end
//               else
//               if ((SoldeCompte.Soldecharge.Retour)and(SoldeCompte.SoldeBalance.Retour)) then //normal
//                 begin
//                    if ((SoldeCompte.SoldeCharge.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeCharge.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                      raise ExceptLGR.Create('',3,false,mtError,Except_LGR);
//                 end
//               else
//                  raise ExceptLGR.Create('',4,false,mtError,Except_LGR);
//           except
//             case Except_LGR.NumErreur of
//               1,2,3:begin
//                       if (MessageDlg('il existe une différence entre vos stocks, le solde de la '+#13+#10+'balance et le solde du bilan d''''ouverture '+#13+#10+'sur le compte :'+#13+#10+'Vous ne pouvez pas reprendre vos stocks sur ce '+#13+#10+'compte'+#13+#10+'Souhaitez vous visualiser ces différences ?', mtWarning, [mbYes,mbNo], 0) = mrYes) then
//                         begin
//                            Initialise_TParamAffichage(ParamAffichage);
//                            ParamAffichage.AffichModal := true;
//                            ParamAffichage.Titre:='Liste des Soldes du compte '+DMRech.TaStockRech.findfield('Compte').Asstring;
//                            ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
//                            AfficheVisuListView(ParamAffichage,['Ecran','Compte','Débit','Crédit'],
//                                                               [200,200,150,150],
//                                                               [SoldeCompte.ListeSolde],
//                                                               [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify],
//                                                               [1..2],
//                                                               [3..4],[0]);
//                         end;
//                     end;
//               4:begin
//                   MessageDlg('il existe une différence entre le solde de la balance et le solde '+#13+#10+'de vos stocks sur le compte :'+DMRech.TaStockRech.findfield('Compte').Asstring+#13+#10+'Vous ne pouvez reprendre vos stocks pour ce compte. ', mtWarning, [mbOK], 0);
//                 end;
//             end;//fin du case ExceptLGR
//           end;
         if Except_LGR.retour then
           begin
              CreationODReprise_avecObjet(DMRech.TaStockRech,'');
              EcritureReference(DMRech.TaStockRech.findfield('ID').AsInteger,true,DMImport.Piece_Import.Reference,e.DatExoDebut);
           end;
        DMRech.TaStockRech.Next;
        dec(NbEnregistrement);
        end;
        TableGereCommit(DMRech.TaStockRech);
        TableGereCommit(DMPieces.TaPiece);
       end;
       except
       TableGereRollBack(DMRech.TaStockRech);
       TableGereRollBack(DMPieces.TaPiece);
       showmessage('Problème à l''enregistrement des OD d''ouverture');
       abort;
       end;//fin du try
end;


procedure TDMStock.CreationODStockCloture;
var
NbEnregistrement:integer;
begin
   try
      FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie','Reference'],['True',DateToStr(E.DatExoFin),'']));
      TableGereStartTransaction(DMRech.TaStockRech);

      NbEnregistrement:=DMRech.TaStockRech.RecordCount;
      DMRech.TaStockRech.First;
      While (Not(NbEnregistrement=0)) Do
          Begin
          Remplit_TInfosStock(DMRech.TaStockRech,InfosStock);
          Remplit_TInfosStock(DMRech.TaStockRech,InfosStockTmp);
          CreationODCloture_avecObjet(DMRech.TaStockRech,'');
          EcritureReference(DMRech.TaStockRech.findfield('ID').AsInteger,true,DMImport.Piece_Import.Reference,e.DatExoFin);
          TraitementMAJBalance(C_Cloture,true,dsbrowse,'');
          DMRech.TaStockRech.next;
          NbEnregistrement:=NbEnregistrement-1;
          end;
    TableGereCommit(DMRech.TaStockRech);
    TableGereCommit(DMPieces.TaPiece);
   except
       begin
       showmessage('Problème à l''enregistrement des OD de clôture');
       TableGereRollBack(DMRech.TaStockRech);
       TableGereRollBack(DMPieces.TaPiece);
       abort;
       end;
   end;
end;

Procedure TDMStock.EcritureReference(ID:integer;Changerdate:boolean;Ref:string;Date:Tdatetime);
begin
    if TaStockEcritureReference.Locate('ID',ID,[]) then
    begin
    TaStockEcritureReference.Edit;
    TaStockEcritureReference.FindField('Reference').AsString:=Ref;
    if Changerdate=true then
    TaStockEcritureReference.FindField('Date_Piece').Asdatetime:=Date;
    TableGerePost(TaStockEcritureReference);
    end;
end;

procedure TDMStock.DMStockCreate(Sender: TObject);
begin
ListeEdit:=TStringList.Create;
OuvrirTouteTable('',Tcontrol(self));
MessDerSub:=true;
end;

procedure TDMStock.DMStockDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
ListeEdit.Free;
//DMStock.EssaiStock.Free;
DMStock:=nil;
end;



procedure TDMStock.TaStockBeforePost(DataSet: TDataSet);
var
Annee,Mois,Jour:word;
DateCourante:Tdatetime;
I:integer;
controleSaisie:TErreurSaisie;
retour:boolean;
begin
if DataSet.State in [dsinsert,dsedit] then
   begin
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,
        ET_Maint:    Begin
                       for i:=1 to 3 do //de compte à MontantHT
                         begin
                         controleSaisie:=CtrlSaisieStock(DataSet.Fields[i],2);
                             if controleSaisie.Retour=false then
                               case controleSaisie.CodeErreur of
                                  1001,1002:begin
                                              if assigned(FOnGEstInterfaceEvent) then
                                               FOnGEstInterfaceEvent(DataSet.Fields[i]);
//                                              DataSet.Fields[i].FocusControl;
                                              abort;//champ code emprunt
                                            end;
                               end;//fin du case
                         end;
                    if not (DernierChampSaisi in [4..6]) then DernierChampSaisi:=4;
                       case DernierChampSaisi of
                       4:begin
                         retour:=CalculPrixUnitaire;
                         if retour=false then
                           begin
                           Application.Messagebox(Pchar('Vous devez saisir un prix unitaire !'),'Erreur de saisie',0);
                            if assigned(FOnGEstInterfaceEvent) then
                             FOnGEstInterfaceEvent(DataSet.Fields[4]);
//                           dataset.Fields[4].focuscontrol;
                           abort;
                           end;
                         end;
                       5:begin
                         retour:=CalculDecote;
                         if retour=false then
                            Begin
                           Application.Messagebox(Pchar('Le montant total doit être supérieur à zéro !'),'Erreur de saisie',0);
                            if assigned(FOnGEstInterfaceEvent) then
                             FOnGEstInterfaceEvent(DataSet.Fields[6]);
//                           dataset.Fields[6].focuscontrol;
                           abort;
                           end;
                         end;
                       6:begin
                         retour:=calculMontantTotal;
                         if retour=false then
                           begin
                           Application.Messagebox(Pchar('Vous devez saisir un montant total !'),'Erreur de saisie',0);
                            if assigned(FOnGEstInterfaceEvent) then
                             FOnGEstInterfaceEvent(DataSet.Fields[6]);
//                           dataset.Fields[6].focuscontrol;
                           abort;
                           end;
                         end;
                       end;//fin du case
                     end;
        ET_EnCloture,
        ET_MaintS:   Begin
                       //
                     end;
        ET_Cloture:  Begin
                       //
                     end;
        ET_Inconnu:  Begin
                       //
                     end;
      end;//fin du case E.TypeEtatExercice

   try
      if DataSet.State=dsinsert then
      begin //si table en insertion
      DataSet.findfield('ID').AsInteger:=MaxId_Query(TaStock,'ID');
      DataSet.findfield('Actif').AsBoolean:=true;
         case Quand of
         C_Ouverture:begin //si ouverture
                 DataSet.findfield('Date_Saisie').AsDateTime:=e.DatExoDebut-1;
                 datecourante:=e.DatExoDebut;
                 DecodeDate(datecourante,annee,mois,jour);
                 DataSet.findfield('Date_ID_Exercice').AsDateTime:=EncodeDate(annee-1,mois,jour);
           end;//fin si ouverture
         C_Cloture:begin//si cloture
                 TaStockDate_Saisie.AsDateTime:=E.DatExoFin;
                 TaStockDate_ID_Exercice.AsDateTime:=E.DatExoDebut;
           end;//fin si cloture
         end;//fin du case ouverture/cloture
      end;//fin table en insertion
      except
      DataSet.EnableControls;
      showmessage('Problème à l''écriture dans la table Stock !!!');
      abort;
      end;//fin du try

TableGereStartTransaction(DataSet);
//Mise à jour de la balance
   try
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,ET_EnCloture,
        ET_Maint:    Begin
                        TraitementMAJBalance(Quand,false,EtatTable,TaStockReference.AsString);
                           if EtatTable =dsEdit then
                             if not(empty(TaStockReference.AsString)) then
                                 begin //si modif et OD
                                    if (trim(TaStockCompte.AsString)<>trim(InfosStockTmp.Compte))or
                                   (TaStockMontantTotalHT.AsCurrency<>InfosStockTmp.MontantTotalHT)or
                                   (TaStockQte.AsFloat<>InfosStockTmp.Qte)then
                                   begin
                                   DMPieces.SuppressionOD(TaStockReference.AsString);
                                   TaStockReference.AsString:='';
                                   TaStockDate_Piece.asstring:='';
                                   end
                                   else
                                   if trim(TaStockDesignation.asstring)<>trim(InfosStockTmp.Designation) then
                                   DMPieces.ModificationOD(TaStockReference.AsString,TaStockDesignation.asstring);
                                 end;//fin si modif et OD
                       DMPlan.GestionCompteEnCoursDeSaisie(DMStock.TaStock.findField('Compte').AsString,DMStock,false);
                     end;
      end;//fin du case typeEtatExercice
   except
         TableGereRollback(DataSet);
         TableGereRollback(DMPieces.TaPiece);
   showmessage('Problème à la mise à jour de la balance !!!');
   abort;
   end;//fin du try
   end;//fin si insertion ou modification
end;


function  TDMStock.RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
begin
   with result do
   begin
    case tag_module of
         C_Ouverture:begin //ouverture
            sens1:='Debit_Report';
            Qte1:='Qt1_Report';
            end;
         C_Cloture:begin //Cloture
            sens1:='Debit_Base';
            Qte1:='Qt1_Base';
            end;
         end;//fin du case
   end;//fin du with
end;


procedure TDMStock.TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;EtatTaStock:TDataSetState;Ref:string);
var
param:TRecupParametres; //nom du champ(Debit ou Credit)et du champ Quantité
begin
if Ch_Pr= 0 then
param:=RecupParametreMAJBalance(Quand)//récupération des paramètres de MAJ Balance
else
param:=RecupParametreMAJBalance(Ch_Pr);//récupération des paramètres de MAJ Balance
with param do
   begin //Début du with
    if empty(Ref) then
    begin
    //mise à jour balance pour le compte de stock
    DMBalance.MAJBalance(Suppression,qte1,sens1,TaStockCompte.AsString,
    InfosStockTmp.Compte,TaStockQte.AsFloat,InfosStockTmp.Qte,TaStockMontantTotalHT.AsCurrency,
    InfosStockTmp.MontantTotalHT,EtatTaStock);
    end
    else
       begin //si la charge a une OD
           case Quand of
           C_Ouverture:begin//si ouverture
                 DMBalance.MAJBalance(Suppression,qte1,sens1,TaStockCompte.AsString,
                 InfosStockTmp.Compte,TaStockQte.AsFloat,InfosStockTmp.Qte,TaStockMontantTotalHT.AsCurrency,
                 InfosStockTmp.MontantTotalHT,EtatTaStock);//MAJ Balance pour compte de stock
                 end;
//           C_Cloture:begin//si cloture
//                 DMBalance.MAJBalance(Suppression,qte1,sens1,TaStockCompte.AsString,
//                 InfosStockTmp.Compte,TaStockQte.AsFloat,InfosStockTmp.Qte,TaStockMontantTotalHT.AsCurrency,
//                 InfosStockTmp.MontantTotalHT,dsinsert);//MAJ Balance pour compte de stock
//                 end;
           end;//fin du case
       end;// FIN si la charge a une OD
end;//fin du with
end;


procedure TDMStock.TaStockAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
EtatTable:=DataSet.State;
MessDerSub:=true;
DeFiltrageDataSet(DMRech.TaStockRech);
if AideCompte=nil then AideCompte:=TAideCompte.create(Application.MainForm);
AideCompte.ListeCompteUtiliseEcranAppelant:=ChampTableVersListe('Compte',DMRech.TaStockRech);
end;

function TDMStock.FiltragePourAffichageOD(Situation:TDateTime;Dataset:TDataset):Boolean;
begin
if Dataset=nil then
  begin
    FiltrageDataSet(TaStock,CreeFiltreET(['Actif','Date_Saisie'],['True',DateToStr(Situation)]));
    result:=TaStock.RecordCount <> 0;
  end
else
  begin
    FiltrageDataSet(Dataset,CreeFiltreET(['Actif','Date_Saisie'],['True',DateToStr(Situation)]));
    result:=Dataset.RecordCount <> 0;
  end;
end;



procedure TDMStock.TaStockBeforeEdit(DataSet: TDataSet);
var
   messagetmp: String;
begin
case Quand of
   C_Ouverture:messagetmp := 'Attention, la reprise de ce stock a été éffectuée !!!'+#10#13+'La modification de ce stock entraînera la modification de l''OD de reprise et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de ce stock ?';
   C_Cloture:messagetmp := 'Attention, l''OD de clôture de ce stock a été éffectuée !!!'+#10#13+'La modification de ce stock entraînera la modification de l''OD de clôture et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de ce stock ?';
end;
      // Si le compte possède une OD
      If TaStockReference.AsString <> '' Then
           If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
                abort;
 Remplit_TInfosStock(TaStock,InfosStockTmp);
end;

procedure TDMStock.TaStockBeforeDelete(DataSet: TDataSet);
var
   messagetmp: String;
begin
try
  case Quand of
     C_Ouverture:Begin
                   if VerifSiCompteSaisieDsBO(DataSet.FindField('Compte').AsString,False,DataSet) then
                    begin
                     Messagedlg(CompteImporte_DossierDos,mtInformation,[mbok],0);
                     Abort;
                    end;
                  if empty(TaStockReference.AsString) then
                    messagetmp :='Êtes-vous sûr de vouloir supprimer ce stock ?'
                  else
                    messagetmp :='Attention, la reprise de ce stock a été effectuée !!!'+#10#13+'La suppression de ce stock entraînera la suppression de l''OD et la mise à jour de la balance !!!'+#10#13+'Confirmer la suppression de ce stock ?';
                 End;

     C_Cloture:Begin
                  if empty(TaStockReference.AsString) then
                    messagetmp :='Êtes-vous sûr de vouloir supprimer ce stock ?'
                  else
                    messagetmp :='Êtes-vous sûr de vouloir supprimer ce stock ?'+#10#13+'La suppression de ce stock entraînera la suppression de l''OD et la mise à jour de la balance !!!'+#10#13+'Confirmer la suppression de ce stock ?';
               End;
  end;
case E.TypeEtatExercice of
 ET_Importation:begin
                end;
  ET_Normal:    begin
                    If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
                      abort;
                end;
end;//fin du case E.TypeEtatExercice

       TableGereStartTransaction(DataSet);
       Remplit_TInfosStock(TaStock,InfosStockTmp);
       if not(empty(TaStockReference.AsString)) then
          begin//si le stock à une OD
             try
               DMPieces.SuppressionOD(TaStockReference.AsString);
             except
               showmessage('Problème à la suppression d''un stock');
               abort;
             end;//fin du try
          end;// fin si la charge ou produit à une OD

          try
            TraitementMAJBalance(Quand,true,dsBrowse,TaStockReference.AsString);
          except
           TableGereRollBack(DataSet);
           TableGereRollBack(DMPieces.TaPiece);
          showmessage('Problème à la Mise A Jour de la balance après une suppression d''OD ');
          abort;
          end;//fin du try
except
 TableGereRollBack(DataSet);
 TableGereRollBack(DMPieces.TaPiece);
 abort;
end;//fin du try
end;

procedure TDMStock.TaStockAfterInsert(DataSet: TDataSet);
begin
EtatTable:=DataSet.State;
end;

procedure TDMStock.TaStockAfterEdit(DataSet: TDataSet);
begin
EtatTable:=DataSet.State;
end;

procedure TDMStock.TaStockAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
if @DataStock.OnStateChange<>nil then DataStock.OnStateChange(DataSet);
end;

procedure TDMStock.TaStockPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
 TableGereRollBack(dataset);
 TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMStock.TaStockDeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
 TableGereRollBack(dataset);
 TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMStock.TaStockBeforeClose(DataSet: TDataSet);
begin
if Dataset.State in [dsEdit,dsInsert] then
   dataBaseError('Vous devez fermer la table : Stocks !!');
end;

procedure TDMStock.TaStockBeforeInsert(DataSet: TDataSet);
var
CtrlSaisie:TExceptLGR;
begin
if assigned(FOnGEstInterfaceEvent) then FOnGEstInterfaceEvent(dataset.Fields[1]);
//CtrlSaisie.GestMessageLGR:=GestMessageLGR;
//raise ExceptLGR.Create('Test',0,true,mtError,CtrlSaisie);
//abort;
//  dataset.Fields[1].focuscontrol;
end;

procedure TDMStock.TaStockBeforeEIDOuv_Abort(DataSet: TDataSet);
Begin
if not e.AccesOuverture then
 MessageDlg('Vous ne pouvez plus modifier les stocks d''ouverture !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les stocks d''ouverture !', mtError, [mbOK], 0);
abort;
End;

procedure TDMStock.TaStockBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesCloture then
 MessageDlg('Vous ne pouvez plus modifier les stocks de clôture !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les stocks de clôture !', mtError, [mbOK], 0);
abort;
End;

function VerifRepriseStockOuverture_OK(var messageTmp:TMessages):boolean;
Begin
result:=false;
if DMStock=nil then DMStock:=TDMStock.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
    // On filtre la table pour savoir s'il reste des stocks à reprendre à l'ouverture
    FiltrageDataSet(DMRech.TaStockRech,CreeFiltreET(['Actif','Date_Saisie','Reference'],['True',DateToStr(E.DatExoDebut - 1),'']));
    result:=DMRech.TaStockRech.RecordCount=0;
    if not result then
       messageTmp.MessageErreur:='Tous les stocks d''ouverture n''ont pas été repris.'+#10#13#10#13+' Vous devez les reprendre avant la clôture définitive.'
    else
       messageTmp.MessageErreur:='OK';
  except
   showmessage('Problème lors de la vérification de la reprise de stocks d''ouverture');
   abort;
  end;
End;


function VerifExistStockCloture(var messageTmp:TMessages):boolean;
Begin
result:=false;
if DMStock=nil then DMStock:=TDMStock.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
    FiltrageDataSet(DMRech.TaStockRech,'Date_Saisie = '''+DatetimeToStr(E.DatExoFin)+'''');
    result:=DMRech.TaStockRech.RecordCount<>0;
    if not result then
      begin
         messageTmp.MessageErreur:='Aucun stock de fin d''exercice n''est enregistré. '+#10#13#10#13;
         messageTmp.MessageQuestion:='Voulez-vous les saisir maintenant ?';
      end
    else
         messageTmp.MessageErreur:='OK';
  except
   showmessage('Problème lors de la vérification des stocks de clôture ');
   abort;
  end;
End;


function VerifExistStockOuverture(var messageTmp:TMessages):boolean;
Begin
result:=false;
if DMStock=nil then DMStock:=TDMStock.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
    FiltrageDataSet(DMRech.TaStockRech,'Date_Saisie = '''+DatetimeToStr(E.DatExodebut-1)+'''');
    result:=DMRech.TaStockRech.RecordCount<>0;
    if not result then
       begin
         messageTmp.MessageErreur:='Aucun stock d''ouverture n''est enregistré !'+
                      #10#13+
                      'Ce sont les stocks que vous avez constatés à la fin de l''exercice précédent'+
                      #10#13#10#13+
                      'Si vous n''avez pas de stock, vous pouvez sauter cette étape. '+
                      #10#13#10#13;
        messageTmp.MessageQuestion:='Cliquez sur le bouton ouverture pour les saisir maintenant.';
      end
    else
     begin
         messageTmp.MessageErreur:='Des stocks d''ouverture ont été saisis'+
                      #10#13#10#13+
                      'Pensez à vérifier si vous avez effectué leur reprise !!';
     end;
  except
   showmessage('Problème lors de la vérification des stocks de clôture ');
   abort;
  end;
End;


Procedure TDMStock.ImportStocks(Valeurs:array of const;DataSet:TDataSet);
Begin
case Quand of
   // ouverture
   C_Ouverture:Begin
      try
       ImportTable(Valeurs,DataSet);
      except
       abort;
      end;
     End;
   // Cloture
   C_Cloture:Begin
      try
       ImportTable(Valeurs,DataSet);
      except
       abort;
      end;
     End;
end;
End;


procedure TDMStock.TraitementCloture1001(sender:Tobject);
Begin
 main.StoksdeFin1Click(main.StoksdeFin1);
End;

procedure TDMStock.TraitementCloture1000(sender:Tobject);
Begin
 main.RepriseStoks1Click(main.RepriseStoks1);
End;

procedure TDMStock.TraitementCloture1002(sender:Tobject);
Begin
 main.Stoks1Click(main.Stoks1);
End;


procedure TDMStock.Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
begin
   try
   FiltrageDataSet(DMRech.TaStockRech,'Date_Saisie = '''+DatetimeToStr(E.DatExoFin)+'''');
   TableGereStartTransaction(dmrech.TaStockRech);
   if DMRech.TaStockRech.RecordCount<>0 then
      begin
      tMem.LoadFromDataSet( DMRech.TaStockRech,0,lmCopy);
      tMem.First;
      while not(tMem.EOF) do
         begin
         tMem.edit;
         tMem.FindField('Date_Saisie').AsDateTime:=NouvelleDate;
         tMem.FindField('Date_ID_Exercice').AsDateTime:=NouvelleDate;
         tMem.FindField('Date_Piece').Asstring:='';
         tMem.FindField('Reference').Asstring:='';
         tMem.Post;
         tMem.Next;
         end;
      end;
   TableGereCommit(dmrech.TaStockRech);
   TableGereCommit(DMPieces.TaPiece);
   except
   TableGereRollBack(dmrech.TaStockRech);
   TableGereRollBack(DMPieces.TaPiece);
   showmessage('Problème à l''écriture dans la nouvelle table '+DMRech.TaStockRech.TableName);
   abort;
   end;//fin du try
end;



procedure TDMStock.CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
ValPieceAutoGen:TValPieceAutoGenere;
cptVariation:Tcompte1;
Begin
   try
     try
       cptVariation:=dmplan.FiltrageSurComptePourOD(1,1,TableEnCours.findfield('Compte').AsString,e.regime);
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoFin;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=TableEnCours.findfield('Designation').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);

       //remplissage de 2 lignes pour l'OD
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,TableEnCours.findfield('MontantTotalHT').AsCurrency,0,TableEnCours.findfield('Compte').asstring),0,-TableEnCours.findfield('MontantTotalHT').AsCurrency,0,'','',0,'',''],true,false,-1);
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CptVariation.CompteDotation,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantTotalHT').AsCurrency,CptVariation.CompteDotation),0,TableEnCours.findfield('MontantTotalHT').AsCurrency,0,'','',0,'',''],true,false,-1);

//       DMImport.ExecutionDuFiltrageAideCompteSuivantContexte(DMStock,SourcePiece);

       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMStock,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;



procedure TDMStock.CreationODReprise_avecObjet(TableEnCours:TTable;ODModif:string);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
ValPieceAutoGen:TValPieceAutoGenere;
cptVariation:Tcompte1;
Begin
   try
     try
       cptVariation:=dmplan.FiltrageSurComptePourOD(1,1,TableEnCours.findfield('Compte').AsString,e.regime);
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoDebut;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=TableEnCours.findfield('Designation').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);


       //remplissage de 2 lignes pour l'OD
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantTotalHT').AsCurrency,TableEnCours.findfield('Compte').asstring),0,TableEnCours.findfield('MontantTotalHT').AsCurrency,0,'','',0,'',''],true,false,-1);
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CptVariation.CompteDotation,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,TableEnCours.findfield('MontantTotalHT').AsCurrency,0,CptVariation.CompteDotation),0,-TableEnCours.findfield('MontantTotalHT').AsCurrency,0,'','',0,'',''],true,false,-1);

       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMStock,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;

procedure TDMStock.TaStockAfterOpen(DataSet: TDataSet);
begin
TaStockCompte.ValidChars := ['0'..'9'];
TaStockDecote.ValidChars := ['0'..'9'];

//FormateMonnaieField(DataSet,E.FormatMonnaie,E.EditFormat);
TaStockMontantTotalHT.DisplayFormat:=E.FormatMonnaie;
TaStockMontantTotalHT.EditFormat:=E.EditFormat;
//
TaStockPrix_Unitaire.DisplayFormat:=E.FormatMonnaie;
TaStockPrix_Unitaire.EditFormat:=E.EditFormat;

end;

// Retourne une liste des comptes de stocks dont le solde de la balance
// ne correspond pas aux totaux des stocks utilisés dans les écrans d'ouverture ou clôture
Function TDMStock.ListeCptStocksUtiliseManuellement(Ouverture:Boolean):TStringList;
var
ListeCpt:TStringList;
TotauxBalance:TTotauxBalance;
QueryTotauxRepris,QueryTotauxNonRepris:TQuery;
rang:Integer;
strTmp:string;
begin
  ListeCpt:=TStringList.Create;
  Result:=TstringList.Create;
  Result.Clear;
  ListeCpt:=DMPlan.FiltrageParamCPT(1,E.Regime);
  FiltrageDataSet(DMREch.TaBalanceRech,CreeFiltreOU('Compte',[ListeCpt]));
  // Result reçoit la liste des comptes de stocks présent dans la balance
  Result:=ChampTableVersListe('Compte',DMREch.TaBalanceRech);
    //////////// on recup les stocks repris à l'ouverture
        QueryTotauxRepris:=TQuery.Create(self);
        QueryTotauxRepris.DatabaseName:=DMRech.TaStockRech.DatabaseName;
        QueryTotauxRepris.SQL.Add('select compte,sum(MontantTotalHT) as MontantReport from Stock ');
        QueryTotauxRepris.SQL.Add('where Reference <>'''' and Date_Saisie <:DateCourante');
        QueryTotauxRepris.SQL.Add('group by Compte');
        QueryTotauxRepris.ParamByName('DateCourante').AsDate:=e.DatExoDebut;
        QueryTotauxRepris.Open;
        QueryTotauxRepris.First;
   //////////// on recup les stocks non repris
        QueryTotauxNonRepris:=TQuery.Create(self);
        QueryTotauxNonRepris.DatabaseName:=DMRech.TaStockRech.DatabaseName;
        QueryTotauxNonRepris.SQL.Add('select compte,sum(MontantTotalHT) as MontantReport from Stock ');
        QueryTotauxNonRepris.SQL.Add('where (Reference is null) or (Reference <>'''' and Date_Saisie >=:DateCourante)');
        QueryTotauxNonRepris.SQL.Add('group by Compte');
        QueryTotauxNonRepris.ParamByName('DateCourante').AsDate:=e.DatExoDebut;
        QueryTotauxNonRepris.Open;
        QueryTotauxNonRepris.First;
    ///un même compte peut se trouver dans les deux listes, ce qui implique qu'on ne peut
    //l'enlever sans vérifier le montant dans la deuxième liste     
/////// on traite les stocks repris à l'ouverture
        while not QueryTotauxRepris.EOF do
          begin //debut du while QueryTotauxRepris
           if not empty(QueryTotauxRepris.findfield('Compte').AsString)  then
             if not (QueryTotauxNonRepris.Locate('compte',QueryTotauxRepris.findfield('Compte').AsString,[])) then
             begin //s'il y a des stocks repris et s'il ne font pas partie aussi de ceux non repris
             TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,QueryTotauxRepris.findfield('Compte').AsString);
             // Si le Montant est égal et le solde dans le bon sens, on enlève de la liste
                 if ((TotauxBalance.SoldeFin = 0)) then
                      begin
                       Rang:=Result.IndexOf(QueryTotauxRepris.FindField('Compte').AsString);
                       if rang <> -1 then result.Delete(rang);
                      end;
             end;//fin s'il y a des stocks repris et s'il ne font pas partie aussi de ceux non repris
           QueryTotauxRepris.Next;
          end;//fin du while QueryTotauxRepris
/////// fin on traite les stocks repris à l'ouverture

/////// on traite les stocks non repris
        while not QueryTotauxNonRepris.EOF do
          begin//Debut du while QueryTotauxNonRepris
            if not empty(QueryTotauxNonRepris.findfield('Compte').AsString)  then
            begin//s'il y a des stocks non repris
             TotauxBalance:=DMDiocEtatBal.SommeTotauxBalanceParCompte(E.DatExoDebut,E.DatExoFin,QueryTotauxNonRepris.findfield('Compte').AsString);
             // Si le Montant est égal et le solde dans le bon sens, on enlève de la liste
                 if ((TotauxBalance.SoldeFin = QueryTotauxNonRepris.findfield('MontantReport').AsCurrency) and (TotauxBalance.SoldeDebitCreditFin)) then
                      begin
                       Rang:=Result.IndexOf(QueryTotauxNonRepris.FindField('Compte').AsString);
                       if rang <> -1 then result.Delete(rang);
                      end;
            end;//fin s'il y a des stocks non repris
           QueryTotauxNonRepris.Next;
          end;//fin du while QueryTotauxNonRepris
///////fin  Si on traite les stocks non repris
     QueryTotauxRepris.Close;
     QueryTotauxRepris.Free;
     QueryTotauxNonRepris.Close;
     QueryTotauxNonRepris.Free;
End;

procedure TDMStock.TaStockBeforeCancel(DataSet: TDataSet);
begin
DMPlan.GestionCompteEnCoursDeSaisie(DMStock.TaStock.findField('Compte').AsString,DMStock,false);
end;


procedure TDMStock.TaCompteFilterRecordCompteImmobilisable(DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
  if DataSet.Name <> 'quLibelle' then
   begin
     try
       accept:=((not (DataSet.findField('Immobilisation').AsBoolean)) and (length(DataSet.FindField('Compte').AsString) > 2));
//      if ((ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
//         accept:=DataSet.FindField('PlanSaisie').asBoolean and accept;
      if ((accept) and (ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
         accept:=DataSet.FindField('PlanSaisie').asBoolean;
     except
       accept:=false;
     end;
   end;
  end;
end;


procedure TDMStock.GestionFiltrageParamCpt;
var
ListeCpt:TStringList;
begin
   try
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(Application.MainForm);
   if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);

   ListeCpt:=TStringList.Create;
   ListeCpt:=DMPlan.FiltrageParamCPT(1,e.Regime);
   DMPlan.TaCompte.OnFilterRecord:=TaCompteFilterRecordCompteImmobilisable;
   AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
   finally
   if ListeCpt<>nil then
   ListeCpt.Free;
   end;//fin du try finally
End;


procedure TDMStock.QuListeValRuptCalcFields(DataSet: TDataSet);
begin
QuListeValRuptLibelle.AsString := DMPlan.LibelleDuNumCpt(QuListeValRuptcompte.AsString);
end;

Procedure TDMStock.GestionAccesStocks;
Begin
  case Quand of
     C_Ouverture:Begin
                  if E.AccesOuverture then
                   begin
                    TaStock.BeforeInsert := TaStockBeforeInsert;
                    TaStock.BeforeEdit := TaStockBeforeEdit;
                    TaStock.BeforeDelete := TaStockBeforeDelete;
                   end
                  else
                   begin
                    TaStock.BeforeInsert := TaStockBeforeEIDOuv_Abort;
                    TaStock.BeforeEdit := TaStockBeforeEIDOuv_Abort;
                    TaStock.BeforeDelete := TaStockBeforeEIDOuv_Abort;
                   end;
                 End;

     C_Cloture:Begin
                  if E.AccesCloture then
                   begin
                    TaStock.BeforeInsert := TaStockBeforeInsert;
                    TaStock.BeforeEdit := TaStockBeforeEdit;
                    TaStock.BeforeDelete := TaStockBeforeDelete;
                   end
                  else
                   begin
                    TaStock.BeforeInsert := TaStockBeforeEIDClo_Abort;
                    TaStock.BeforeEdit := TaStockBeforeEIDClo_Abort;
                    TaStock.BeforeDelete := TaStockBeforeEIDClo_Abort;
                   end;
               End;
  end;

End;

procedure TDMStock.QuStocks_EditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ListeEdit.IndexOf(DAtaSet.findField('Compte').AsString) <> -1;
end;



Procedure TDMStock.AnnuleRepriseStocks(DataSet:TDataSet);
begin
TableGereStartTransaction(DataSet);
//Mise à jour de la balance
   try
     DataSet.First;
     while (not DataSet.Eof)do
     begin
//      TraitementMAJBalance(Quand,false,EtatTable,DataSet.findfield('Reference').AsString);
//         if EtatTable =dsEdit then
           if not(empty(DataSet.findfield('Reference').AsString)) then
               begin //si modif et OD
                 DMPieces.SuppressionOD(DataSet.findfield('Reference').AsString);
                 TableGereEdit(dataset);
                 DataSet.findfield('Reference').AsString:='';
                 DataSet.findfield('Date_Piece').asstring:='';
                 TableGerePost(dataset);
               end;//fin si modif et OD
     DataSet.next;
     end;
     TableGereCommit(dataset);
     TableGereCommit(DMPieces.TaPiece);
   except
     TableGereRollback(DataSet);
     TableGereRollback(DMPieces.TaPiece);
     showmessage('Problème à la suppression des reprises des stocks ');
     abort;
   end;//fin du try

end;
end.
