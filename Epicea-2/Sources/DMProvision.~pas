unit DMProvision;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  Grids,
  DBGrids,
  Db,
  DBTables,
  E2_AideCompte,
  LibSQL,
  Menus,
  Buttons,
  Gr_MiseAJourBalance,
  RxMemDS,
  DMClotures,
  LibDates,
  E2_Decl_Records,
  Editions,
  ShellApi,
  DMConstantes,
  LibRessourceString,
  ObjetEdition,
  lib_chaine,E2_VisuListeView;

type
  TParamDMProvision=Record
   Quand:Integer;
   ProvisionDataStateChange:TNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
   CompteProvision:String;
   AfficheListe:Boolean;
  end;

  TInfosDMProvision=Record
    Retour:Boolean;
   end;

  TDMProvisions = class(TDataModule)
    DataProvision: TDataSource;
    TaProvision: TTable;
    TaProvisionID: TIntegerField;
    TaProvisionCompte: TStringField;
    TaProvisionDesignation: TStringField;
    TaProvisionMtTotalProvision: TCurrencyField;
    TaProvisionMtBilanOuverture: TCurrencyField;
    TaProvisionDateSysteme: TDateTimeField;
    TaProvisionReference: TStringField;
    TaProvisionMontantReprise: TCurrencyField;
    TaProvisionDateSaisie: TDateField;
    TaProvisionReprise: TBooleanField;
    TaProvisionMtRestant: TCurrencyField;
    QuListeValRupt: TQuery;
    QuSousTotal: TQuery;
    QuTotalG: TQuery;
    QuProvisionsEdition: TQuery;
    QuProvisions_Edition: TQuery;
    procedure DMProvisionCreate(Sender: TObject);
    Function CtrlSaisieProvisions(CCourant:Tfield): TErreurSaisie;
    procedure DMProvisionDestroy(Sender: TObject);
//    procedure BeforePost2_TaProvision(DataSet: TDataSet);
    procedure TaProvisionBeforePost(DataSet: TDataSet);
    procedure TaProvisionBeforeDelete(DataSet: TDataSet);
    procedure TaProvisionAfterPost(DataSet: TDataSet);
    procedure AfterEnregistrementModif;
    procedure TaProvisionAfterDelete(DataSet: TDataSet);
    function FiltrageTablePourRepriseCloture:boolean;
    function FiltrageTablePourRepriseouverture:boolean;
    Procedure EcritureReference(ID:integer;Ref:string);
    procedure TaProvisionBeforeEdit(DataSet: TDataSet);
    procedure CreationODChargeCloture;
    procedure CreationODChargeOuverture;
//    function FiltragePourOuvertureReprise:Boolean;
    function CreationListeOD:TStringList;
    procedure DemandeAffichageReprise;
   // function FiltrageSurComptePourOD(compte:string):TCompte1;
    procedure FiltrageAffichageGrille(Quand_L:integer);
    procedure Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
    procedure TaProvisionPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaProvisionDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaProvisionBeforeInsert(DataSet: TDataSet);

    procedure TaProvBeforeEIDOuv_Abort(DataSet: TDataSet);
    procedure TaProvBeforeEIDClo_Abort(DataSet: TDataSet);

    Procedure TraitementCloture5000(sender:Tobject);
    procedure CreationODOuverture_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure TaProvisionAfterInsert(DataSet: TDataSet);
    procedure TaProvisionCalcFields(DataSet: TDataSet);
    procedure TaProvisionFilterRecordPourNouvelExo(DataSet: TDataSet;
      var Accept: Boolean);
    Procedure GestionAccesProvisions;
    procedure QuProvisions_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure EventValider(Sender: TObject);
  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;
  public
    { Déclarations publiques }
    CompteProvision:string;
    ListeEdit:TStringList;
    Quand:Integer;
    AfficheListe:Boolean;
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
    Procedure ImportProvisions(Valeurs:array of const;DataSet:TDataSet);
  end;

    function VerifRepriseProvisions(var messageTmp:Tmessages):boolean;
    function VerifExistProvisions(var messageTmp:Tmessages;Mess:boolean):boolean;
    function VerifExistProvisionsAReprendre(var messageTmp:Tmessages;Mess:boolean):boolean;

  Function InitialiseDMProvision(ParamDMProvision:TParamDMProvision):TInfosDMProvision;
  Function EditionProvision(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionProvisionsL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;ListeCompte:TStringList;Site:TEditLien):Boolean;overload;
  Function EditionProvisionsL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;Compte:String;Site:TEditLien):Boolean;overload;

  Function AffichProvisionsSurPeriode(Quand:integer):Boolean;
var
  DMProvisions: TDMProvisions;
  EtatTable:TDataSetState;
  MontantTmp,MontantTmp1: Currency;
  DesignationTmp,compteTmp: String;
  OD,compte:string;
  montantBilan:currency;
  affichageOD:boolean;

implementation

 uses DMPiece, DMBalances,DMEcriture,DMPlanCpt, E2_Main,
  DMImportation,DMBaseDonnee, DMRecherche,E2_LibInfosTable;

 {$R *.DFM}

Function InitialiseDMProvision(ParamDMProvision:TParamDMProvision):TInfosDMProvision;
Begin
 if DMProvisions=nil then DMProvisions:=TDMProvisions.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 DMProvisions.Quand := ParamDMProvision.Quand;
 DMProvisions.OnGEstInterfaceEvent := ParamDMProvision.GEstInterfaceEvent;
 DMProvisions.CompteProvision := ParamDMProvision.CompteProvision;
 DMProvisions.AfficheListe:=ParamDMProvision.AfficheListe;
 if DMProvisions.AfficheListe then
   begin
        AffichProvisionsSurPeriode(DMProvisions.Quand);
        if ((DMPieces.RetourViewListe.retour)and(not empty(DMPieces.RetourViewListe.VisuListeView.ItemCourantValeurCol(0)))) then
           DMProvisions.CompteProvision:=DMPieces.RetourViewListe.VisuListeView.ItemCourantValeurCol(0);
   end;
  case DMProvisions.DataProvision.State of
    dsBrowse:Begin
              DMProvisions.FiltrageAffichageGrille(DMProvisions.Quand);
              DMProvisions.DataProvision.OnStateChange:=ParamDMProvision.ProvisionDataStateChange;
             End;
    dsInsert,dsEdit:Begin

                    End;
  end;
End;


Function EditionProvisionsL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;Compte:String;Site:TEditLien):Boolean;
Var
ListeCompte:TStringList;
Begin
ListeCompte:=TStringList.Create;
ListeCompte.Add(Compte);
EditionProvisionsL(TypeEdition,Quand,DataSet,ListeCompte,Site);
End;

Function EditionProvisionsL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;ListeCompte:TStringList;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
NomMenuSiteWeb:TfileStream;
Qte:Integer;
Decote:Integer;
MtBilanOuverture,MtTotalProvision,TotalRepriseCpt,TotalSoldeCpt:Currency;
MontantREprise,SoldeFin:Currency;
ListeValeur:TStringList;
ValeurCompte:String;
ObjPrn:TObjetEdition;
TitreCompte:string;
Begin
try
 ObjPrn:=TObjetEdition.Create(application.MainForm);
 Chemin :=E.RepertoireComptaWeb;
 case Quand of
    C_Ouverture:NomFich:='ProvisionsOuv';
    C_Cloture:NomFich:='ProvisionsClo';
 end;


 if DMProvisions=nil then DMProvisions:=TDMProvisions.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
   // Inutile dans Stocks pour l'instant
  end;
 ListeValeur:=TStringList.Create;
 ObjPrn.FontLigneSeule.Style := [fsBold];

 DMProvisions.QuProvisions_Edition.OnFilterRecord :=nil;

 if ListeCompte <> nil then
  begin
   TitreCompte:='Du compte :'+ListeCompte.Strings[0]+' au compte :'+ListeCompte.Strings[ListeCompte.count-1];
   DMProvisions.ListeEdit.Assign(ListeCompte);
   DeFiltrageDataSet(DMProvisions.QuProvisions_Edition);
   DMProvisions.QuProvisions_Edition.OnFilterRecord :=DMProvisions.QuProvisions_EditionFilterRecord;
   FiltrageDataSet(DMProvisions.QuProvisions_Edition,'');
  end
 else
   begin
     DMProvisions.QuProvisions_Edition.OnFilterRecord :=nil;
     TitreCompte:=' Tous les comptes ';
   end;

 case Quand of
    C_Ouverture:begin
                 DMProvisions.QuProvisions_Edition.SQL.Clear;
                 DMProvisions.QuProvisions_Edition.Params.Clear;
                 DMProvisions.QuProvisions_Edition.SQL.Add('select * from Provisions.db ');
                 DMProvisions.QuProvisions_Edition.SQL.Add(' where DateSaisie <=:DateANouveau');
                 DMProvisions.QuProvisions_Edition.SQL.Add(' order by compte');
                 DMProvisions.QuProvisions_Edition.Params[0].DataType := ftDAte;
                 DMProvisions.QuProvisions_Edition.Params[0].AsDate := E.DatExoDebut -1;
                 DMProvisions.QuProvisions_Edition.Open;

                 MtBilanOuverture:=0;
                 MtTotalProvision:=0;
                 if DMProvisions.QuProvisions_Edition.recordcount<>0 then
                 begin//s'il y a des lignes à imprimer
                 DMProvisions.QuProvisions_Edition.First;
                 while not DMProvisions.QuProvisions_Edition.Eof do
                   begin
                    ValeurCompte:=DMProvisions.QuProvisions_Edition.FindField('Compte').AsString;
                    MtTotalProvision:=DMProvisions.QuProvisions_Edition.FindField('MtTotalProvision').AsCurrency + MtTotalProvision;
                    MtBilanOuverture:=DMProvisions.QuProvisions_Edition.FindField('MtTotalProvision').AsCurrency + MtBilanOuverture;
                    ListeValeur.Add('0'+
                                     ';'+
                                     DMProvisions.QuProvisions_Edition.FindField('Compte').AsString+
                                     ';'+
                                     GereLibelle(DMProvisions.QuProvisions_Edition.FindField('Designation').AsString)+
                                     ';'+
                                     DMProvisions.QuProvisions_Edition.FindField('MtTotalProvision').AsString+
                                     ';'+
                                     DMProvisions.QuProvisions_Edition.FindField('MtBilanOuverture').AsString
                                     );
                    DMProvisions.QuProvisions_Edition.Next;
                    if ValeurCompte <> DMProvisions.QuProvisions_Edition.FindField('Compte').AsString then
                     begin
                      ListeValeur.Add('1;; @TOTAL DU COMPTE '+ValeurCompte+' : ;'+CurrToStr(MtTotalProvision)+';' +CurrToStr(MtBilanOuverture)+';');
                      ValeurCompte:=DMProvisions.QuProvisions_Edition.FindField('Compte').AsString;
                      MtTotalProvision:=0;
                     end;
                   end;
                  ListeValeur.Add('1;; @TOTAL DU COMPTE '+ValeurCompte+' : ; ' +CurrToStr(MtTotalProvision)+';'+CurrToStr(MtBilanOuverture));
                  MtTotalProvision:=0;
                 DMProvisions.QuProvisions_Edition.Close;
                 ObjPrn.FTitreEdition := 'Etat des Provisions à l''ouverture';
                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ListeValeur.Insert(0,' Compte ; Désignation ; Total Provision ; Montant Bilan d''Ouverture ');
                 ListeValeur.Insert(1,'0.6;2.2;1.8;1.8');
                 ListeValeur.Insert(2,'texte;texte;curr;curr');
                 end;//fin s'il y a des lignes à imprimer
                 ObjPrn.AffichageImp(ListeValeur);
                end;

    C_Cloture: begin
                 DMProvisions.QuProvisions_Edition.SQL.Clear;
                 DMProvisions.QuProvisions_Edition.Params.Clear;
                 DMProvisions.QuProvisions_Edition.SQL.Add('select * from Provisions.db ');
                 DMProvisions.QuProvisions_Edition.SQL.Add(' where DateSaisie <=:DateANouveau');
                 DMProvisions.QuProvisions_Edition.SQL.Add(' order by compte');
                 DMProvisions.QuProvisions_Edition.Params[0].DataType := ftDAte;
                 DMProvisions.QuProvisions_Edition.Params[0].AsDate := E.DatExoFin;
                 DMProvisions.QuProvisions_Edition.Open;

                 MontantREprise:=0;
                 SoldeFin:=0;

                 MtBilanOuverture:=0;
                 MtTotalProvision:=0;

                 TotalRepriseCpt:=0;
                 TotalSoldeCpt:=0;

                 if DMProvisions.QuProvisions_Edition.recordcount<>0 then
                 begin//s'il y a des lignes à imprimer
                 DMProvisions.QuProvisions_Edition.First;
                 while not DMProvisions.QuProvisions_Edition.Eof do
                   begin
                    ValeurCompte:=DMProvisions.QuProvisions_Edition.FindField('Compte').AsString;
                    MtTotalProvision:=DMProvisions.QuProvisions_Edition.FindField('MtTotalProvision').AsCurrency + MtTotalProvision;
                    MtBilanOuverture:=DMProvisions.QuProvisions_Edition.FindField('MtBilanOuverture').AsCurrency + MtBilanOuverture;
                    MontantREprise:=DMProvisions.QuProvisions_Edition.FindField('MontantReprise').Ascurrency;
                    TotalRepriseCpt := MontantREprise + TotalRepriseCpt;
                    SoldeFin:=DMProvisions.QuProvisions_Edition.FindField('MtBilanOuverture').AsCurrency-DMProvisions.QuProvisions_Edition.FindField('MontantReprise').Ascurrency;
                    TotalSoldeCpt := SoldeFin + TotalSoldeCpt;
                    ListeValeur.Add('0'+
                                     ';'+
                                     DMProvisions.QuProvisions_Edition.FindField('Compte').AsString+
                                     ';'+
                                     GereLibelle(DMProvisions.QuProvisions_Edition.FindField('Designation').AsString)+
                                     ';'+
                                     DMProvisions.QuProvisions_Edition.FindField('MtTotalProvision').AsString+
                                     ';'+
                                     DMProvisions.QuProvisions_Edition.FindField('MtBilanOuverture').AsString+
                                     ';'+
                                     DMProvisions.QuProvisions_Edition.FindField('MontantReprise').AsString+
                                     ';'+
                                     CurrToStr(SoldeFin)
                                     );
                    DMProvisions.QuProvisions_Edition.Next;
                    if ValeurCompte <> DMProvisions.QuProvisions_Edition.FindField('Compte').AsString then
                     begin
                      ListeValeur.Add('1;; @TOTAL DU COMPTE '+
                                         ValeurCompte+' : ;'+
                                         CurrToStr(MtTotalProvision)+';'+
                                         CurrToStr(MtBilanOuverture)+';'+
                                         CurrToStr(TotalRepriseCpt)+';'+
                                         CurrToStr(TotalSoldeCpt));
                      ValeurCompte:=DMProvisions.QuProvisions_Edition.FindField('Compte').AsString;
                      MtTotalProvision:=0;
                      MtBilanOuverture:=0;
                      TotalRepriseCpt:=0;
                      TotalSoldeCpt :=0;
                     end;
                   end;
                      ListeValeur.Add('1;; @TOTAL DU COMPTE '+
                                         ValeurCompte+' : ;'+
                                         CurrToStr(MtTotalProvision)+';'+
                                         CurrToStr(MtBilanOuverture)+';'+
                                         CurrToStr(TotalRepriseCpt)+';'+
                                         CurrToStr(TotalSoldeCpt));
                  MtTotalProvision:=0;
                 DMProvisions.QuProvisions_Edition.Close;
                 ObjPrn.FTitreEdition := 'Etat des Provisions à la clôture';
                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ListeValeur.Insert(0,' Compte ; Désignation ; Total Provision ; Mt Bilan d''Ouv. ; Reprise ; Solde Fin ');
                 ListeValeur.Insert(1,'0.6;2;1.2;1.2;1.2;1.2');
                 ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr');
                 end;//fin s'il y a des lignes à imprimer
                 ObjPrn.AffichageImp(ListeValeur);
                end;
 end;
Finally
   DeFiltrageDataSet(DMProvisions.QuProvisions_Edition);
   DMProvisions.QuProvisions_Edition.OnFilterRecord :=nil;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
End;


Function EditionProvision(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
Begin

 Chemin :=E.RepertoireComptaWeb;
 case Quand of
    C_Ouverture:NomFich:='ProvisionsOuv';
    C_Cloture:NomFich:='ProvisionsClo';
 end;


 if DMProvisions=nil then DMProvisions:=TDMProvisions.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
   // Inutile dans Stocks pour l'instant
  end;

 case Quand of
    C_Ouverture:begin
                 DMProvisions.QuListeValRupt.SQL.Clear;
                 DMProvisions.QuListeValRupt.SQL.Add('select distinct compte from provisions where ');
                 DMProvisions.QuListeValRupt.SQL.Add('DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMProvisions.QuListeValRupt.Open;

                 DMProvisions.QuSousTotal.SQL.Clear;
                 DMProvisions.QuSousTotal.Params.Clear;
                 DMProvisions.QuSousTotal.SQL.Add('select sum(MtTotalProvision), sum(MtBilanOuverture) ');
                 DMProvisions.QuSousTotal.SQL.Add('from provisions where compte =:compte and ');
                 DMProvisions.QuSousTotal.SQL.Add('DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMProvisions.QuSousTotal.Params[0].DataType := ftString;
                 DMProvisions.QuSousTotal.Open;

                 DMProvisions.QuTotalG.SQL.Clear;
                 DMProvisions.QuTotalG.SQL.Add('select sum(MtTotalProvision), sum(MtBilanOuverture) from provisions where ');
                 DMProvisions.QuTotalG.SQL.Add('DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMProvisions.QuTotalG.Open;

                 DMProvisions.QuProvisionsEdition.SQL.Clear;
                 DMProvisions.QuProvisionsEdition.SQL.Add('Select * from provisions where ');
                 DMProvisions.QuProvisionsEdition.SQL.Add('DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMProvisions.QuProvisionsEdition.Open;
                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := false;
                                     //EditProvision(Chemin,NomFich,DMProvisions.QuProvisionsEdition,'Compte',DMProvisions.QuListeValRupt,DMProvisions.QuSousTotal,DMProvisions.QuTotalG,DateToStr(E.DatExoDebut),Site,C_Ouverture);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///C:/Js/Epicea-2/Sources/Stock.xml'),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := false;
                                    // LienEditProvision(NomMenuSiteWeb,Chemin,NomFich,DMProvisions.QuProvisionsEdition,'Compte',DMProvisions.QuListeValRupt,DMProvisions.QuSousTotal,DMProvisions.QuTotalG,DateToStr(E.DatExoDebut),Site);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///C:/Js/Epicea-2/Sources/Stock.xml'),nil,sw_show);
                                 End;
                 end;
                 DMProvisions.QuListeValRupt.Close;
                 DMProvisions.QuSousTotal.Close;
                 DMProvisions.QuTotalG.Close;
                 DMProvisions.QuProvisionsEdition.Close;
    end;

    C_Cloture: begin
                 DMProvisions.QuListeValRupt.SQL.Clear;
                 DMProvisions.QuListeValRupt.SQL.Add('select distinct compte from provisions where ');
                 DMProvisions.QuListeValRupt.SQL.Add('DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMProvisions.QuListeValRupt.Open;

                 DMProvisions.QuSousTotal.SQL.Clear;
                 DMProvisions.QuSousTotal.Params.Clear;
                 DMProvisions.QuSousTotal.SQL.Add('select sum(MtTotalProvision), sum(MtBilanOuverture),sum(MontantReprise),sum(MtBilanOuverture)-sum(MontantReprise) MontantFin ');
                 DMProvisions.QuSousTotal.SQL.Add('from provisions where compte =:compte and ');
                 DMProvisions.QuSousTotal.SQL.Add('DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMProvisions.QuSousTotal.Params[0].DataType := ftString;
                 DMProvisions.QuSousTotal.Open;

                 DMProvisions.QuTotalG.SQL.Clear;
                 DMProvisions.QuTotalG.SQL.Add('select sum(MtTotalProvision), sum(MtBilanOuverture),sum(MontantReprise),sum(MtBilanOuverture)-sum(MontantReprise) from provisions where ');
                 DMProvisions.QuTotalG.SQL.Add('DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMProvisions.QuTotalG.Open;

                 DMProvisions.QuProvisionsEdition.SQL.Clear;
                 DMProvisions.QuProvisionsEdition.SQL.Add('Select pro.*,(MtBilanOuverture-MontantReprise) as MontantFin from provisions pro where ');
                 DMProvisions.QuProvisionsEdition.SQL.Add('DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMProvisions.QuProvisionsEdition.Open;
                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := false;
                                     //EditProvision(Chemin,NomFich,DMProvisions.QuProvisionsEdition,'Compte',DMProvisions.QuListeValRupt,DMProvisions.QuSousTotal,DMProvisions.QuTotalG,DateToStr(E.DatExoFin),Site,C_Cloture);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///C:/Js/Epicea-2/Sources/Stock.xml'),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := false;
                                    // LienEditProvision(NomMenuSiteWeb,Chemin,NomFich,DMProvisions.QuProvisionsEdition,'Compte',DMProvisions.QuListeValRupt,DMProvisions.QuSousTotal,DMProvisions.QuTotalG,DateToStr(E.DatExoFin),Site);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
//                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///C:/Js/Epicea-2/Sources/Stock.xml'),nil,sw_show);
                                 End;
                 end;
                 DMProvisions.QuListeValRupt.Close;
                 DMProvisions.QuSousTotal.Close;
                 DMProvisions.QuTotalG.Close;
                 DMProvisions.QuProvisionsEdition.Close;
    end;
 end;
End;


procedure TDMProvisions.Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
var
QueryCalcul:Tquery;
begin
try
   try
   if dmrech.TaProvisionsRech.Active then dmrech.TaProvisionsRech.Close;
   dmrech.TaProvisionsRech.OnFilterRecord:=TaProvisionFilterRecordPourNouvelExo;
   FiltrageDataSet(dmrech.TaProvisionsRech,'');
//   FiltrageDataSet(dmrech.TaChargesRepartirRech,'MontantReprise<MtBilanOuverture');
   QueryCalcul:=tquery.Create(self);
   QueryCalcul.DatabaseName:= dmrech.TaProvisionsRech.DatabaseName;
   QueryCalcul.SQL.Add('select (MtBilanOuverture-MontantReprise)as resultat from Provisions.db where MontantReprise<MtBilanOuverture');
   QueryCalcul.open;
   TableGereStartTransaction(dmrech.TaProvisionsRech);
   if dmrech.TaProvisionsRech.RecordCount<>0 then
      begin
      tMem.LoadFromDataSet( dmrech.TaProvisionsRech,0,lmCopy);
      QueryCalcul.First;
      tMem.First;
      while not(tMem.EOF) do
         begin
         tMem.edit;
         tMem.FindField('MontantReprise').AsFloat:=0;
         tMem.FindField('MtBilanOuverture').AsFloat:=QueryCalcul.FindField('resultat').AsFloat;
         tMem.FindField('DateSysteme').AsDateTime:=now;
         tMem.FindField('DateSaisie').AsDateTime:=NouvelleDate;
         tMem.FindField('Reference').Asstring:='';
         tMem.Post;
         tMem.Next;
         QueryCalcul.Next;
         end;
      end;
      TableGereCommit(dmrech.TaProvisionsRech);
      TableGereCommit(DMPieces.TaPiece);
   except
   DeFiltrageDataSet(dmrech.TaProvisionsRech);
   dmrech.TaProvisionsRech.OnFilterRecord:=nil;
   TableGereRollBack(dmrech.TaProvisionsRech);
   TableGereRollBack(DMPieces.TaPiece);
   showmessage('Problème à l''écriture dans la nouvelle table '+dmrech.TaProvisionsRech.TableName);
   abort;
   end;//fin du try
finally
   DeFiltrageDataSet(dmrech.TaProvisionsRech);
end;
end;

function TDMProvisions.CreationListeOD:TStringList;
begin
try
FiltrageDataSet(DMRech.TaProvisionsRech,'Reference <> ''''');
result:=TStringList.Create;
result.Clear;
 While (Not(DMRech.TaProvisionsRech.EOF)) Do
   Begin
   If result.IndexOf(DMRech.TaProvisionsRech.findfield('Reference').AsString) = -1 Then
      result.Add(DMRech.TaProvisionsRech.findfield('Reference').AsString);
   DMRech.TaProvisionsRech.Next;
   End;
except
  result.clear;
end;//fin du try except     
end;


procedure TDMProvisions.DemandeAffichageReprise;
begin
DMPieces.AffichageFeuilleReprise(0,CreationListeOD,nil,'Reprise des Provisions','','',false);
end;


procedure TDMProvisions.CreationODChargeOuverture;
var
SoldeCompte:TSoldeCompte;
Except_LGR:TExceptLGR;
ParamAffichage:TParamAffichage;
begin
Initialise_ExceptLGR(Except_LGR);
    try
    TableGereStartTransaction(DMRech.TaProvisionsRech);
    DMRech.TaProvisionsRech.first;
    // Tant qu'il reste des enregistrements dans la table TaCAR
     While (Not(DMRech.TaProvisionsRech.EOF)) Do
     Begin
         Except_LGR:=PossibiliteRepriseCompte(DMRech.TaProvisionsRech.findfield('Compte').Asstring,DMRech.TaProvisionsRech,'C','provisions');
//     try//except
//         Except_LGR.retour:=true;
//         Except_LGR.NumErreur:=0;
//         SoldeCompte:=DMBalance.RetourneSoldeCompteAvantReprise(DMRech.TaProvisionsRech.findfield('Compte').Asstring,DMRech.TaProvisionsRech,0,'C');
//         if ((SoldeCompte.SoldeBO.Retour)and(SoldeCompte.SoldeBalance.Retour)) then //importation
//           begin
//              if ((SoldeCompte.SoldeBO.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeBO.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                raise ExceptLGR.Create('',1,false,mtError,Except_LGR);
//              if ((SoldeCompte.SoldeCharge.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeCharge.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                raise ExceptLGR.Create('',2,false,mtError,Except_LGR);
//           end
//         else
//         if ((SoldeCompte.Soldecharge.Retour)and(SoldeCompte.SoldeBalance.Retour)) then //normal
//           begin
//              if ((SoldeCompte.SoldeCharge.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeCharge.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                raise ExceptLGR.Create('',3,false,mtError,Except_LGR);
//           end
//         else
//            raise ExceptLGR.Create('',4,false,mtError,Except_LGR);
//     except
//       case Except_LGR.NumErreur of
//         1,2,3:begin
//                 if (MessageDlg('il existe une différence entre vos provisions, le solde de la '+#13+#10+'balance et le solde du bilan d''''ouverture '+#13+#10+'sur le compte :'+#13+#10+'Vous ne pouvez pas reprendre vos provisions sur ce '+#13+#10+'compte'+#13+#10+'Souhaitez vous visualiser ces différences ?', mtWarning, [mbYes,mbNo], 0) = mrYes) then
//                   begin
//                      Initialise_TParamAffichage(ParamAffichage);
//                      ParamAffichage.AffichModal := true;
//                      ParamAffichage.Titre:='Liste des Soldes du compte '+DMRech.TaProvisionsRech.findfield('Compte').Asstring;
//                      ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
//                      AfficheVisuListView(ParamAffichage,['Ecran','Compte','Débit','Crédit'],
//                                                         [200,200,150,150],
//                                                         [SoldeCompte.ListeSolde],
//                                                         [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify],
//                                                         [1..2],
//                                                         [3..4],[0]);
//                   end;
//               end;
//         4:begin
//             MessageDlg('il existe une différence entre le solde de la balance et le solde '+#13+#10+'de vos provisions sur le compte :'+DMRech.TaProvisionsRech.findfield('Compte').Asstring+#13+#10+'Vous ne pouvez reprendre vos provisions pour ce compte. ', mtWarning, [mbOK], 0);
//           end;
//       end;//fin du case ExceptLGR
//     end;
     if Except_LGR.retour then
       begin
           CreationODOuverture_avecObjet(DMRech.TaProvisionsRech,'');
           EcritureReference(DMRech.TaProvisionsRech.findfield('ID').AsInteger,DMImport.Piece_Import.Reference);
       end;
     DMRech.TaProvisionsRech.Next;
     end;
        TableGereCommit(DMRech.TaProvisionsRech);
        TableGereCommit(DMPieces.TaPiece);
    except
       begin
       showmessage('Problème à l''enregistrement des OD d''ouverture');
        TableGereRollBack(DMRech.TaProvisionsRech);
        TableGereRollBack(DMPieces.TaPiece);
       abort;
    end;
    end;
end;


procedure TDMProvisions.CreationODChargeCloture;
begin
    try
    TableGereStartTransaction(DMRech.TaProvisionsRech);

    DMRech.TaProvisionsRech.First;
        While (Not(DMRech.TaProvisionsRech.EOF)) Do
        Begin
        DMBalance.MAJBalance(true,'Qt2_base','Credit_base',DMRech.TaProvisionsRech.findfield('Compte').AsString,DMRech.TaProvisionsRech.findfield('Compte').AsString,
        0,0,DMRech.TaProvisionsRech.findfield('MtBilanOuverture').AsCurrency,DMRech.TaProvisionsRech.findfield('MtBilanOuverture').AsCurrency,dsbrowse);
        CreationODCloture_avecObjet(DMRech.TaProvisionsRech,'');
        EcritureReference(DMRech.TaProvisionsRech.findfield('ID').AsInteger,DMImport.Piece_Import.Reference);;
        DMRech.TaProvisionsRech.next;
        end;
        TableGereCommit(DMRech.TaProvisionsRech);
        TableGereCommit(DMPieces.TaPiece);
    except
        begin
        showmessage('Problème à l''enregistrement des OD de clôture');
        TableGereRollBack(DMRech.TaProvisionsRech);
        TableGereRollBack(DMPieces.TaPiece);
        abort;
        end;
    end;
end;






//******************* FiltrageTablePourReprise *************************
//cette procedure sert dans la fenêtre de repriseChargeARepartir
//pour filtrer la table Tacar en fonction de la date ExoFin
//***********************************************************************
function TDMProvisions.FiltrageTablePourRepriseCloture:boolean;
begin
     FiltrageDataSet(DMRech.TaProvisionsRech,'DateSaisie = '''+DatetimeToStr(E.DatExoFin)+''' And Reference = ''''');
     result:=DMRech.TaProvisionsRech.recordcount<>0;
end;



//******************* TDMChargeRepartir.FiltrageTablePourRepriseouverture *************************
//cette procedure permet de recuperer les enregistrements crées à l'ouverture
///*********************************************************************************
function TDMProvisions.FiltrageTablePourRepriseouverture:boolean;
begin
     FiltrageDataSet(DMRech.TaProvisionsRech,'DateSaisie = '''+DatetimeToStr(E.DatExoDebut-1)+''' And MontantReprise <> 0 And Reference = ''''');
     result:=DMRech.TaProvisionsRech.recordcount<>0;
end;


//******************* EcritureReference *************************
//Cette fonction permet d'Ecrire la réference crée à la fermeture
//de la fenêtre des charges à Répartir (Clôture)
//***************************************************************
Procedure TDMProvisions.EcritureReference(ID:integer;Ref:string);
begin
try
TaProvision.BeforePost:=nil;
TaProvision.AfterPost:=nil;
TaProvision.BeforeEdit:=nil;
TaProvision.DisableControls;
  if TaProvision.Locate('ID',ID,[]) then
    begin
    TaProvision.Edit;
    TaProvision.findfield('Reference').Value:= ref;
    TableGerePost(TaProvision);
   end;
finally
TaProvision.EnableControls;
TaProvision.BeforePost:=TaProvisionBeforePost;
TaProvision.AfterPost:=TaProvisionAfterPost;
TaProvision.BeforeEdit:=TaProvisionBeforeEdit;
end;//fin du try finally
end;

//******************* TDMChargeRepartir.CtrlSaisieChargesRepartir *************************
//Cette fonction sert à vérifier tous les champs saisis avant l'enregistrement
//dans la table 'ChargesARepartir'

Function TDMProvisions.CtrlSaisieProvisions(CCourant:Tfield):TErreurSaisie;
var
infosCompte:TInfosplancpt;
begin // initialisation des variables de retour de fonction
 CtrlSaisieProvisions.CodeErreur:=0;
 CtrlSaisieProvisions.Retour:=True;
  if TaProvision.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
    case self.Quand of
    C_Ouverture: begin  // si ouverture
           case CCourant.Index of
           1:Begin
               AideCompte.FiltrageAideCompte(11);
               if AideCompteDansContexte(CCourant.AsString,CCourant,['Rac1'],false,MessDerSub,true,true,false,true,0)=False then
                 Begin
                   Result.CodeErreur:=1001;
                   Result.Retour:=false;
                 End
                 else
                 if self.Quand = C_Ouverture then
                    begin
                    if VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCourant.DataSet) then
                     begin
                      Result.CodeErreur:=1001;  //Compte déjà utilisé dans BO
                      Result.Retour:=false;
                     end;
                    end
              end;
           2: begin // si champ n° 3 (désignation)
               If Empty(CCourant.AsString) then
                Begin // si champ vide
                infosCompte:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[CompteProvision]);
                  if not (empty(infosCompte.Libelle)) then
                  ccourant.AsString:=infosCompte.Libelle +' N°: '+ IntTOStr(ccourant.DataSet.RecordCount+1)
                  else
                  begin
                  CtrlSaisieProvisions.CodeErreur:=2100;
                  CtrlSaisieProvisions.Retour:=False;
                  Application.Messagebox(Pchar('La saisie de la désignation est obligatoire !!!'),'Erreur de saisie',0);
                  end;
                end;//fin champ vide
               end;//fin champ3
           3: begin // si champ n° 3 (Montant total de la charge)
               if Empty(CCourant.AsString)or (CCourant.AsFloat =0) then
                  Begin // si champ vide
                  CtrlSaisieProvisions.CodeErreur:=3100;
                  CtrlSaisieProvisions.Retour:=False;
                  Application.Messagebox(Pchar('La saisie du Montant Total de la provision est obligatoire !!!'),'Erreur de saisie',0);
                  end; //fin champ vide
               end;//fin champ 3
            4: begin  // si champ n° 4 (Montant du Bilan d''Ouverture)
                if Empty(CCourant.AsString)or (CCourant.AsFloat <=0) then
                  Begin // si champ vide
                     if (not(empty(TaProvisionMtTotalProvision.AsString)))and (TaProvisionMtTotalProvision.asfloat>0) then
                     CCourant.AsFloat:=TaProvisionMtTotalProvision.AsFloat
                     else
                     begin
                     CtrlSaisieProvisions.CodeErreur:=4100;
                     CtrlSaisieProvisions.Retour:=False;
                     Application.Messagebox(Pchar('La saisie du Montant du Bilan d''Ouverture est obligatoire et ne peut être égale à ''0'' !!!'),'Erreur de saisie',0);
                     end;
                  end; //fin champ vide
                if CCourant.AsFloat > CCourant.DataSet.Fields[3].AsFloat then
                   Begin // si champ 4 > champ 3
                  CtrlSaisieProvisions.CodeErreur:=4102;
                  CtrlSaisieProvisions.Retour:=False;
                  Application.Messagebox(Pchar('La saisie du Montant du Bilan d''Ouverture doit être inferieur ou égal à celui du total charges '' !!!'),'Erreur de saisie',0);
                  end; //fin champ 4 > champ 3
               end;//fin champ 5
           end;//fin du case
       end; // fin du case de l'ouverture
       C_Cloture: begin //si clôture
             case CCourant.Index of
           2: begin // si champ n° 3 (désignation)
               If Empty(CCourant.AsString) then
                Begin // si champ vide
                infosCompte:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[CompteProvision]);
                  if not (empty(infosCompte.Libelle)) then
                  ccourant.AsString:=infosCompte.Libelle + IntTOStr(ccourant.DataSet.RecordCount)
                  else
                  begin
                  CtrlSaisieProvisions.CodeErreur:=2200;
                  CtrlSaisieProvisions.Retour:=False;
                  Application.Messagebox(Pchar('La saisie de la désignation est obligatoire !!!'),'Erreur de saisie',0);
                  end;
                end;//fin champ vide
               end;//fin champ3
              3: begin // si champ n° 4 (Montant total de la charge)
                  if Empty(CCourant.AsString)or (CCourant.AsFloat =0) then
                    Begin // si champ vide
                    CtrlSaisieProvisions.CodeErreur:=3200;
                    CtrlSaisieProvisions.Retour:=False;
                    Application.Messagebox(Pchar('La saisie du Montant Total de la Charge est obligatoire !!!'),'Erreur de saisie',0);
                    end; //fin champ vide
                  if  ((not(Empty(CCourant.AsString))) and ((CCourant.AsFloat >0) and (TaProvisionDateSaisie.AsDateTime>E.DatExoDebut))) then
                     begin //si champ ok
                      TaProvisionMtBilanOuverture.AsFloat:=CCourant.AsFloat;
                     end;
                  if  ((not(Empty(CCourant.AsString))) and ((CCourant.AsFloat >0) and (DateInfos(TaProvisionDateSaisie.AsDateTime).Vide))) then
                     begin //si champ ok
                      TaProvisionMtBilanOuverture.AsFloat:=CCourant.AsFloat;
                     end;
//                  if  not(Empty(CCourant.AsString)) and (CCourant.AsFloat >0) then
//                     begin //si champ ok
//                      TaProvisionMtBilanOuverture.AsFloat:=CCourant.AsFloat;
//                     end;
                  end;//fin champ 3
               4: begin  // si champ n° 4 (Montant restant à reprendre)
                   if Empty(CCourant.AsString)or (CCourant.AsFloat <=0) then
                     Begin // si champ vide
                        if (not(empty(TaProvisionMtTotalProvision.AsString)))and (TaProvisionMtTotalProvision.asfloat>0) then
                        CCourant.AsFloat:=TaProvisionMtTotalProvision.AsFloat
                        else
                        begin
                        CtrlSaisieProvisions.CodeErreur:=4200;
                        CtrlSaisieProvisions.Retour:=False;
                        Application.Messagebox(Pchar('La saisie du Montant du Bilan d''Ouverture est obligatoire et ne peut être égale à ''0'' !!!'),'Erreur de saisie',0);
                        end;
                     end; //fin champ vide
                     if CCourant.AsFloat > CCourant.DataSet.Fields[3].AsFloat then
                        Begin // si champ 4 > champ 3
                       CtrlSaisieProvisions.CodeErreur:=4202;
                       CtrlSaisieProvisions.Retour:=False;
                       Application.Messagebox(Pchar('La saisie du Montant du Bilan d''Ouverture doit être inferieur ou égal à celui du total charges '' !!!'),'Erreur de saisie',0);
                       end; //fin champ 4 > champ 3
                  end;//fin champ 4
               7: begin //si champ n°7 (Montant reprise)
                    if Empty(CCourant.AsString) then
                    begin //si champ vide
                     CCourant.AsFloat:=0;
                    end; //fin champ vide
                    if CCourant.AsFloat >cCourant.DataSet.Fields[4].AsFloat then
                    begin //si champ 7 sup au champ N°4
                    CtrlSaisieProvisions.CodeErreur:=7203;
                    CtrlSaisieProvisions.Retour:=False;
                    Application.Messagebox(Pchar('La saisie du Montant de la reprise doit être inférieure ou égale à celle restant à reprendre !!!'),'Erreur de saisie',0);
                    end; //fin champ 7 sup au champ N°4
                  end;//fin champ 7
             end;//fin du case
          end //fin du case de la clôture
  end; //fin de l'état insertion ou modification
end;
end;

//******************* TDMChargeRepartir.DMChargeRepartirCreate *************************
//cette procedure permet d'ouvrir toutes les tables et de créer des formats type de saisie
///*********************************************************************************
procedure TDMProvisions.DMProvisionCreate(Sender: TObject);
begin
ListeEdit:=TStringList.Create;
OuvrirTouteTable('',TControl(self));
 TaProvision.FindField('MtTotalProvision').ValidChars:=['0'..'9',decimalseparator];
 TaProvision.FindField('MtBilanOuverture').ValidChars:=['0'..'9',decimalseparator];
 TaProvision.FindField('MontantReprise').ValidChars:=['0'..'9',decimalseparator];

 TaProvisionMtTotalProvision.DisplayFormat:=E.FormatMonnaie;
 TaProvisionMtTotalProvision.EditFormat:='0.00 ;-0.00 ';

 TaProvisionMtBilanOuverture.DisplayFormat:=E.FormatMonnaie;
 TaProvisionMtBilanOuverture.EditFormat:='0.00 ;-0.00 ';

 TaProvisionMontantReprise.DisplayFormat:=E.FormatMonnaie;
 TaProvisionMontantReprise.EditFormat:='0.00 ;-0.00 ';
end;

//******************* TDMChargeRepartir.DMChargeRepartirDestroy *************************
//cette procedure permet de fermer toutes tables
///*********************************************************************************
procedure TDMProvisions.DMProvisionDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
ListeEdit.Free;
DMProvisions:=nil;
end;


//******************* TDMChargeRepartir.TaCarBeforePost *************************
//Cette procedure permet de faire une vérification des saisie. Elle concerne l'ouverture
///*********************************************************************************
procedure TDMProvisions.TaProvisionBeforePost(DataSet: TDataSet);
var
I:integer;
RetourFonction:TErreurSaisie;
begin
EtatTable:=TaProvision.State;
  case TaProvision.State of
  dsInsert: begin
             TaProvisionID.AsInteger := MaxId_Query(TaProvision,'ID');
             TaProvisionCompte.AsString := CompteProvision;
             TaProvisionDateSysteme.AsDateTime := Now;
                if self.Quand = C_Ouverture then
                TaProvisionDateSaisie.AsDateTime := E.DatExoDebut-1;
                if self.Quand= C_Cloture then
                TaProvisionDateSaisie.AsDateTime := E.DatExoFin;
            end;// fin de l'état insertion
  dsEdit: begin // etat modification
            TaProvisionDateSysteme.AsDateTime := Now;
          end; //fin de modification
  end;//fin du case
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,
        ET_Maint:    Begin
                        //début de la boucle de vérification des saisies
                        for I:=1 to 4 do //vérification du champ 1 à 4
                           begin
                           RetourFonction:=CtrlSaisieProvisions(TaProvision.Fields[I]);
                             if  RetourFonction.Retour=false then
                                 case  RetourFonction.CodeErreur of
                                     1001,2100,3100,4100,4102,4200,4202,2200,3200:
                                       begin // erreur de saisie, resaisir
                      //                 DataSet.Fields[i].FocusControl;
                                       abort;
                                       end;
                                 end;//fin du case
                           end; //fin boucle
                           if self.Quand=C_Cloture then
                           begin  //si clôture
                           RetourFonction:=CtrlSaisieProvisions(TaProvision.Fields[7]);
                             if  RetourFonction.Retour=false then
                               begin
                                 if RetourFonction.CodeErreur= 7203 then
                                 abort; //continue la vérification sur le champ 7
                               end;
                           end;
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

TableGereStartTransaction(DataSet);
   try
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,ET_EnCloture,
        ET_Maint:    Begin
                       if TaProvision.State=dsinsert then //si insert
                          begin
                           if self.Quand=C_Ouverture then
                               begin //si ouverture
                                   //Mise à jour balance sans OD
                                   DMBalance.MAJBalance(false,'Qt2_Report','Credit_Report',TaProvisionCompte.AsString,TaProvisionCompte.AsString,
                                   0,0,TaProvisionMtBilanOuverture.AsCurrency,TaProvisionMtBilanOuverture.AsCurrency,dsInsert);
                             end//fin ouverture
                           else
                             Begin
                                 //Mise à jour balance sans OD
                                   DMBalance.MAJBalance(false,'Qt2_base','Credit_base',TaProvisionCompte.AsString,TaProvisionCompte.AsString,
                                   0,0,TaProvisionMtBilanOuverture.AsCurrency,TaProvisionMtBilanOuverture.AsCurrency,dsInsert);
                             End;

                          end;//fin si insert
                        if TaProvision.State=dsedit then //si modif
                        AfterEnregistrementModif;
                     end;
      end;//fin du case typeEtatExercice
   except
     TableGereRollBack(DataSet);
     TableGereRollBack(DMPieces.TaPiece);
     showmessage('Problème à la mise à jour de la balance !!!');
     abort;
   end;//fin du try
end;


//******************* TDMChargeRepartir.TaCarBeforeDelete *************************
//
///*********************************************************************************
procedure TDMProvisions.TaProvisionBeforeDelete(DataSet: TDataSet);
var
messagetmp:string;
begin
try//except
OD:='';
compte:='';
montantBilan:=0;
compte:=TaProvisionCompte.AsString;
montantBilan:=TaProvisionMtBilanOuverture.AsCurrency;
OD:=TaProvisionReference.AsString;
   case self.Quand of
      C_Ouverture: begin // si ouverture
           if VerifSiCompteSaisieDsBO(DataSet.FindField('Compte').AsString,False,DataSet) then
            begin
             Messagedlg(CompteImporte_DossierDos,mtInformation,[mbok],0);
             Abort;
            end;

           //si la charge n'a pas de référence
           if trim(TaProvisionReference.AsString) = '' then
             begin
                 messagetmp:='Êtes-vous sûr de supprimer cette provision ?';
//                 if MessageDlg(,mtConfirmation,[mbYes,mbNo],0)= mrno then
//                  abort;
             end//fin de charge n'a pas de référence
            else //si la charge a une référence
             begin
                 messagetmp:='Attention, la reprise de cette provision a été effectué !!!'
                 +#10#13+'La suppression de cette provision entraînera la suppression de l''OD de reprise et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la suppression de cette provision à répartir ?';
//                 if MessageDlg(,mtConfirmation,[mbYes,mbNo],0)=mrno then
//                 abort;
             end; //fin charge a une référence
         end;//fin ouverture
      C_Cloture: begin // si clôture
           //si charge saisie dans l'ouverture
           if TaProvisionDateSaisie.AsDateTime=E.DatExoDebut-1 then
             begin
               MessageDlg('Opération impossible car cette provision a été saisie dans le menu Ouverture !!!'
               +#10#13+'La suppression de cette provision ne peut se faire que dans le menu d'+#39+'ouverture !!!',mtWarning,[mbOK],0);
               abort;
             end//fin charge saisie dans ouverture
           else
             begin //si charge saisie dans clôture
             //si charge n'a pas de référence
                 if TaProvisionReference.AsString='' then
                 begin
                      messagetmp:='Êtes-vous sûr de vouloir supprimer cette provision ?';
//                      if MessageDlg(,mtConfirmation,[mbYes,mbNo],0)=mrno then
//                      abort;
                 end//fin charge n'a pas de référence
                 else //si charge a une référence
                  begin
                       messagetmp:='Êtes-vous sûr de supprimer cette provision ?'+#10#13+
                       'La suppression de cette provision entraînera la suppression de l''OD et la mise à jour de la balance !!!'+
                       #10#13+'Confirmer la suppression de cette provision à répartir ?';
//                       If Messagedlg(,mtconfirmation,[mbyes,mbno],0) = mrno Then
//                        abort;
                  end;//fin charge a une référence
             end;//fin saisie dans clôture
         end;// fin Clôture
   end;// fin du case.Quand
Case E.TypeEtatExercice of
 ET_Importation:begin
                  //
                end;
  ET_Normal:    begin
                  if not empty(messageTmp)then
                    If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
                       abort;
                end;
end;//fin du case
TableGereStartTransaction(TaProvision);
case self.Quand of
         C_Ouverture: begin // si ouverture
                try
                 DMBalance.MAJBalance(true,'Qt2_Report','Credit_Report',TaProvisionCompte.AsString,
                 compte,0,0,montantBilan,montantBilan,dsBrowse);
                 if trim(OD) <> '' then //si la charge a une référence
                     // suppression en plus de l'OD
                     DMPieces.SuppressionOD(OD);
                except
                   begin
                   TableGereRollBack(TaProvision);
                   TableGereRollBack(DMPieces.TaPiece);
                   showmessage('Problème à la mise à jour de la balance d''ouverture');
                   abort;
                   end;
                end;
            end;//fin ouverture
         C_Cloture: begin // si clôture
               try
               if not empty(OD)then //si charge a une référence
                 DMPieces.SuppressionOD(TaProvisionReference.AsString)
               else
                 DMBalance.MAJBalance(true,'Qt2_base','Credit_base',TaProvisionCompte.AsString,
                 compte,0,0,montantBilan,montantBilan,dsBrowse);
               except
                  begin
                   TableGereRollBack(TaProvision);
                   TableGereRollBack(DMPieces.TaPiece);
                   showmessage('Problème à la suppression de l''OD ');
                   abort;
                  end;
               end;
            end;// fin Clôture
      end;// fin du case.Quand
except
 TableGereRollBack(TaProvision);
 TableGereRollBack(DMPieces.TaPiece);
 abort;
end;
end;


//******************* TDMChargeRepartir.TaCarAfterPost *************************
//
///*********************************************************************************
procedure TDMProvisions.TaProvisionAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
end;


//******************* TDMChargeRepartir.AfterEnregistrementModif *************************
//
///*********************************************************************************
procedure TDMProvisions.AfterEnregistrementModif;
var
ODModif:string;
CompteReprise:TCompte1;
begin
try
ODModif:='';
ODModif:=TaProvisionReference.AsString;
  case self.Quand of
     C_Ouverture:begin //si ouverture
          //Mise à jour balance ouverture
            DMBalance.MAJBalance(false,'Qt2_Report','Credit_Report',
            TaProvisionCompte.AsString,compteTmp,0,0,
            TaProvisionMtBilanOuverture.AsCurrency,MontantTmp,dsedit);
          if trim(TaProvisionReference.AsString)<>'' then
          begin //si la charge a une OD
              //si le montantBilanOuverture a été modifié
            if MontantTmp<>TaProvisionMtBilanOuverture.AsCurrency then
             Begin
                //Modification Piece,Ecriture (Suppression)
                DMPieces.SuppressionOD(TaProvisionReference.AsString);
                TaProvisionReference.AsString:='';
                TaProvisionMontantReprise.AsFloat:=0;
                TaProvisionDateSysteme.AsDateTime:=now;
              end
              else //si la désignation a été modifié
              If DesignationTmp <> TaProvisionDesignation.AsString then
              begin
              //Modification Piece, Ecriture (Libelle)
              DMPieces.ModificationOD(TaProvisionReference.AsString,TaProvisionDesignation.AsString);
              end;

          end;//fin la charge a une OD
      end;//fin ouverture
    C_Cloture:begin //si clôture
    CompteReprise:=dmplan.FiltrageSurComptePourOD(11,2,TaProvisionCompte.AsString,e.regime);
        if empty(TaProvisionReference.AsString) then
          begin //si la charge n'a pas d'OD
          //Mise à jour balance
            DMBalance.MAJBalance(false,'Qt2_base','Credit_base',
            TaProvisionCompte.AsString,compteTmp,0,0,
            TaProvisionMtBilanOuverture.AsCurrency,MontantTmp,dsedit);
          end //fin si la charge n'a pas d'OD
        else
        if not  empty(TaProvisionReference.AsString) then
          begin //si la charge a une OD
           if TaProvisionDateSaisie.AsDateTime=E.DatExoFin then
             begin //si ligne de clôture
               if (TaProvisionMtTotalProvision.AsCurrency<>MontantTmp) or (TaProvisionMontantReprise.AsCurrency<>MontantTmp1) then
                 begin//si montant a changé
                     DMPieces.SuppressionOD(ODModif);
                     CreationODCloture_avecObjet(TaProvision,ODModif);
                     affichageOD:=true;
                end//fin montant a changé
                 else
                 if TaProvisionDesignation.AsString<>DesignationTmp then
                   begin //si désignation a changé
                     DMPieces.ModificationOD(ODModif,TaProvisionDesignation.AsString);
                   end;//fin désignation a changé
             end//fin ligne de clôture
             else
             begin//si ligne d'ouverture
               if TaProvisionMontantReprise.AsCurrency<>0 then
               begin //si montant reprise renseigné
                  DMPieces.SuppressionOD(ODModif);
                  CreationODCloture_avecObjet(TaProvision,ODModif);
                  affichageOD:=true;
               end //fin montant reprise renseigné
               else
               begin //si montant reprise pas renseigné
                 DMPieces.SuppressionOD(ODModif);
                 //TaProvision.Edit;
                 TaProvisionReference.Asstring:='';
                 TaProvisionDateSysteme.AsDateTime:=now;
                 //TableGerePost(TaProvision);
               end;//fin montant reprise pas renseigné
             end;// fin ligne d'ouverture
          end;  //fin la charge a une OD
      end;//fin clôture
  end;//fin du case.Quand
except
   TableGereRollback(TaProvision);
   TableGereRollback(DMPieces.TaPiece);
   abort;
end;
end;


//******************* TDMChargeRepartir.TaCarAfterDelete *************************
//on déclenche un changement de state,
///*********************************************************************************
procedure TDMProvisions.TaProvisionAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
if @DataProvision.OnStateChange<>nil then DataProvision.OnStateChange(DataSet);
end;



//******************* TDMChargeRepartir.TaCarAfterEdit *************************
//  de suite après une modification on met une variable à true
///*********************************************************************************
procedure TDMProvisions.TaProvisionBeforeEdit(DataSet: TDataSet);
begin
   case self.Quand of
      C_Ouverture: begin // si ouverture
           if VerifSiCompteSaisieDsBO(CompteProvision,true,DataSet) then
              begin
                abort;  //Compte déjà utilisé dans BO
              end;

           //si la charge n'a pas de référence
           if not empty(TaProvisionReference.AsString) then
             begin
                 if MessageDlg('Attention, la reprise de cette provision a été effectué !!!'
                 +#10#13+'La modification de cette provision entraînera la suppression de l''OD de reprise et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la modification de cette provision ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
                 abort;
             end; //fin charge a une référence
         end;//fin ouverture
      C_Cloture: begin // si clôture
           //si charge saisie dans l'ouverture
           if ((TaProvisionDateSaisie.AsDateTime=E.DatExoDebut-1)and(not empty(TaProvisionReference.AsString))) then
             begin
                 if MessageDlg('Attention, la reprise de cette provision a été effectué !!!'
                 +#10#13+'La modification de cette provision entraînera la suppression de l''OD de reprise et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la modification de cette provision ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
                 abort;
             end//fin charge saisie dans ouverture
           else
             if ((TaProvisionDateSaisie.AsDateTime>E.DatExoDebut-1)and(not empty(TaProvisionReference.AsString))) then
             begin //si charge saisie dans clôture
             //si charge n'a pas de référence
                 if TaProvisionMontantReprise.AsCurrency=0 then
                 begin
                 if MessageDlg('Attention, la modification de cette provision entraînera la suppression de l''OD de clôture et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la modification de cette provision ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
                 abort;
                 end//fin charge n'a pas de référence
                 else //si charge a une référence
                  begin
                 if MessageDlg('Attention, la reprise de cette provision a été effectué !!!'
                 +#10#13+'La modification de cette provision entraînera la suppression de l''OD de reprise et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la modification de cette provision ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
                 abort;
                  end;//fin charge a une référence
             end;//fin saisie dans clôture
         end;// fin Clôture
   end;// fin du case.Quand

   compteTmp:=TaProvisionCompte.AsString;
   MontantTmp := TaProvisionMtBilanOuverture.AsCurrency;
   MontantTmp1 := TaProvisionMontantReprise.AsCurrency;
   DesignationTmp := TaProvisionDesignation.AsString;
end;


procedure TDMProvisions.TaProvBeforeEIDOuv_Abort(DataSet: TDataSet);
Begin
if not e.AccesOuverture then
 MessageDlg('Vous ne pouvez plus modifier les stocks d''ouverture !', mtInformation, [mbOK], 0)
 else
 MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Provisions d''ouverture !', mtError, [mbOK], 0);
abort;
End;

procedure TDMProvisions.TaProvBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesCloture then
 MessageDlg('Vous ne pouvez plus modifier les stocks de clôture !', mtInformation, [mbOK], 0)
 else
 MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Provisions de clôture !', mtError, [mbOK], 0);
abort;
End;


procedure TDMProvisions.FiltrageAffichageGrille(Quand_L:integer);
begin
   case Quand_L of
            C_Ouverture : FiltrageDataSet(TaProvision,CreeFiltreET(['Compte','DateSaisie'],[CompteProvision,datetostr(E.DatExoDebut-1)]));
            C_Cloture : FiltrageDataSet(TaProvision,'Compte = '''+CompteProvision+'''');
   end;//fin du case
end;

//function TDMProvisions.FiltrageSurComptePourOD(compte:string):TCompte1;
//var
//Liste1:TStringList;
//begin
//Liste1:=TStringList.Create;
//liste1:=DMPlan.FiltrageParamCPTSurComptePourOD(11,2,compte,e.Regime);
// result.CompteReprise :=liste1[1];
// result.CompteDotation:=liste1[0];
//liste1.Free;
//end;






procedure TDMProvisions.TaProvisionPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(TaProvision);
TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMProvisions.TaProvisionDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(TaProvision);
TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMProvisions.TaProvisionBeforeInsert(DataSet: TDataSet);
begin
  case self.Quand of
     C_Ouverture:Begin
                  if VerifSiCompteSaisieDsBO(CompteProvision,true,DataSet) then
                    begin
                      abort;  //Compte déjà utilisé dans BO
                    end;
                 End;

     C_Cloture:Begin

               End;
  end;

if assigned(FOnGEstInterfaceEvent) then
 FOnGEstInterfaceEvent(DataSet.Fields[2]);
//  dataset.Fields[2].focuscontrol;
end;


function VerifRepriseProvisions(var messageTmp:Tmessages):boolean;
Begin
if DMProvisions=nil then DMProvisions:=TDMProvisions.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
   result:=VerifExistProvisionsAReprendre(messageTmp,false);
     if not result then
       begin
         messageTmp.MessageErreur:='Toutes les provisions n''ont pas été reprises.'+#10#13#10#13;
         messageTmp.MessageQuestion:='Voulez-vous les reprendre avant la clôture définitive ?';
       end
  except
   showmessage('problème lors de la vérification des reprises des provisions');
   abort;
  end;
End;


function VerifExistProvisions(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
if DMProvisions=nil then DMProvisions:=TDMProvisions.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
     DeFiltrageDataSet(DMRech.TaProvisionsRech);
     result:= DMRech.TaProvisionsRech.RecordCount<>0 ;
      if ((not result)and(mess)) then
         messageTmp.MessageErreur:='Aucune provision n''a été saisie';
  except
   showmessage('problème lors de la vérification de l''existence des provisions');
   abort;
  end;
End;


function VerifExistProvisionsAReprendre(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
if DMProvisions=nil then DMProvisions:=TDMProvisions.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
   result:= VerifExistprovisions(messageTmp,false);
   if result then
     begin
       FiltrageDataSet(DMRech.TaProvisionsRech,'DateSaisie = '''+DatetimeToStr(E.DatExoDebut-1)+''' And (MontantReprise=null or MontantReprise=0) And Reference = ''''');
       result:= dmrech.TaProvisionsRech.RecordCount=0 ;
          if ((not result)and(mess)) then
             messageTmp.MessageErreur:='Il reste des provisions à reprendre'
          else
             messageTmp.MessageErreur:='OK';
     end
   else
     result:=true;
   except
   showmessage('problème lors de la vérification de l''existence des reprises des provisions');
   abort;
  end;
end;


Procedure TDMProvisions.TraitementCloture5000(sender:Tobject);
begin
main.Provisions2Click(nil);
End;


procedure TDMProvisions.CreationODOuverture_avecObjet(TableEnCours:TTable;ODModif:string);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
ValPieceAutoGen:TValPieceAutoGenere;
CompteReprise:TCompte1;
begin
   try
     try
       CompteReprise:=dmplan.FiltrageSurComptePourOD(11,2,TableEnCours.findfield('Compte').AsString,e.regime);
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoDebut;
//       SourcePiece.Date:=e.DatExoFin;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=TableEnCours.findfield('Designation').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       //remplissage de 2 lignes pour l'OD
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').AsString,'','',0,0,-TableEnCours.findfield('MontantReprise').AsCurrency,0,'','',0,'',''],true,false,-1);
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteReprise.CompteReprise,'','',0,0,TableEnCours.findfield('MontantReprise').AsCurrency,0,'','',0,'',''],true,false,-1);
       SourcePiece.TotalPiece:=TableEnCours.findfield('MontantReprise').AsCurrency;
       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMProvisions,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;


procedure TDMProvisions.CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
ValPieceAutoGen:TValPieceAutoGenere;
CompteReprise:TCompte1;
Begin
   try
     try
       CompteReprise:=dmplan.FiltrageSurComptePourOD(11,2,TableEnCours.findfield('Compte').AsString,e.regime);
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoFin;
       SourcePiece.Validation:=e.DatExoFin;
       SourcePiece.Libelle:=TableEnCours.findfield('Designation').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('MontantReprise').Ascurrency<>0 then
          begin
          //remplissage de 4 lignes pour l'OD
         if(TableEnCours.findfield('DateSaisie').AsDateTime>e.DatExoDebut)then
         begin
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').AsString,'','',0,0,TableEnCours.findfield('MtBilanOuverture').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteReprise.CompteDotation,'','',0,0,-TableEnCours.findfield('MtBilanOuverture').AsCurrency,0,'','',0,'',''],true,false,-1);
         end;
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').AsString,'','',0,0,-TableEnCours.findfield('MontantReprise').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteReprise.CompteReprise,'','',0,0,TableEnCours.findfield('MontantReprise').AsCurrency,0,'','',0,'',''],true,false,-1);
          SourcePiece.TotalPiece:=TableEnCours.findfield('MtBilanOuverture').AsCurrency+TableEnCours.findfield('MontantReprise').AsCurrency;
          end
        else
          Begin
          //remplissage de 2 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').AsString,'','',0,0,TableEnCours.findfield('MtBilanOuverture').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteReprise.CompteDotation,'','',0,0,-TableEnCours.findfield('MtBilanOuverture').AsCurrency,0,'','',0,'',''],true,false,-1);
          SourcePiece.TotalPiece:=TableEnCours.findfield('MtBilanOuverture').AsCurrency;
          End;
       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMProvisions,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;


procedure TDMProvisions.TaProvisionAfterInsert(DataSet: TDataSet);
begin
InitChampAfterInsert([nil,nil,nil,0,0,nil,nil,0,nil],DataSet);
end;

procedure TDMProvisions.TaProvisionCalcFields(DataSet: TDataSet);
begin
TaProvisionReprise.AsBoolean:=not empty(DataSet.FindField('Reference').AsString);
TaProvisionMtRestant.AsCurrency:=TaProvisionMtBilanOuverture.AsCurrency-TaProvisionMontantReprise.AsCurrency;
end;

procedure TDMProvisions.TaProvisionFilterRecordPourNouvelExo(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
accept:=dmrech.TaProvisionsRech.FindField('MontantReprise').AsCurrency
         < dmrech.TaProvisionsRech.FindField('MtBilanOuverture').AsCurrency;

end;

Procedure TDMProvisions.ImportProvisions(Valeurs:array of const;DataSet:TDataSet);
Begin
case self.Quand of
   // ouverture
   C_Ouverture:Begin
      try
       CompteProvision := string(valeurs[1].VAnsiString);
       ImportTable(Valeurs,DataSet);
      except
       abort;
      end;
     End;
   // Cloture
   C_Cloture:Begin
      try
       CompteProvision := string(valeurs[1].VAnsiString);
       ImportTable(Valeurs,DataSet);
      except
       abort;
      end;
     End;
end;
End;

Procedure TDMProvisions.GestionAccesProvisions;
begin
  case self.Quand of
     C_Ouverture:Begin
                  if E.AccesOuverture then
                   begin
                    TaProvision.BeforeInsert := TaProvisionBeforeInsert;
                    TaProvision.BeforeEdit := TaProvisionBeforeEdit;
                    TaProvision.BeforeDelete := TaProvisionBeforeDelete;
                   end
                  else
                   begin
                    TaProvision.BeforeInsert := TaProvBeforeEIDOuv_Abort;
                    TaProvision.BeforeEdit := TaProvBeforeEIDOuv_Abort;
                    TaProvision.BeforeDelete := TaProvBeforeEIDOuv_Abort;
                   end;
                 End;

     C_Cloture:Begin
                  if E.AccesCloture then
                   begin
                    TaProvision.BeforeInsert := TaProvisionBeforeInsert;
                    TaProvision.BeforeEdit := TaProvisionBeforeEdit;
                    TaProvision.BeforeDelete := TaProvisionBeforeDelete;
                   end
                  else
                   begin
                    TaProvision.BeforeInsert := TaProvBeforeEIDClo_Abort;
                    TaProvision.BeforeEdit := TaProvBeforeEIDClo_Abort;
                    TaProvision.BeforeDelete := TaProvBeforeEIDClo_Abort;
                   end;
               End;
  end;

End;
procedure TDMProvisions.QuProvisions_EditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
 accept := ListeEdit.IndexOf(DAtaSet.findField('Compte').AsString) <> -1;
end;


Function AffichProvisionsSurPeriode(Quand:integer):Boolean;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
 Requete:TQuery;
 PeriodeAutre_Tmp:TPeriode;
begin
  Try
Initialise_TParamAffichage(ParamAffichage);
  Requete:=Tquery.Create(application.MainForm);
  List1:=TStringList.Create;
  ParamAffichage.Titre:='Liste des Comptes utilisés dans l''exercice.';
  Requete.DatabaseName:=DM_C_NomAliasExercice;
  Requete.SQL.Clear;
  ParamAffichage.GestionAffichForm.Caption:='Selectionnez un compte';
  Requete.SQL.Add('Select distinct Compte');
  Requete.SQL.Add('from Provisions where DateSaisie <=:DateFin');

  if DMPieces = nil then DMPieces:=TDMPieces.Create(Application.MainForm);

  ParamAffichage.TitrePetit:='Liste des provisions de l''ouverture';
  Requete.SQL.Add(' Order by Compte');
  Requete.ParamByName('DateFin').AsDate:=E.DatExoFin;
  Requete.open;
  if Requete.recordcount<>0 then
    begin
    List1:=ChampTableVersListeEx(['Compte'],Requete,';',true);
    ParamAffichage.AffichModal := true;
    ParamAffichage.EventButtonValiderClick:=DMProvisions.EventValider;
    ParamAffichage.EventButtonDetailClick :=ParamAffichage.EventButtonValiderClick;
    ParamAffichage.EventListViewDbleClick :=ParamAffichage.EventButtonValiderClick;

    ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;

    PeriodeAutre_Tmp:=e.PeriodeAutre;

//    E.AutrePeriode:=True;
    Initialise_Periode(e.PeriodeAutre);
    DMPieces.VisuPeriode:=e.PeriodeAutre;
    DMPieces.RetourViewListe:=AfficheVisuListView(ParamAffichage,['Compte'],
                                       [100],
                                       [List1],
                                       [taLeftJustify],
                                       [1],
                                       [],
                                       []);
    end
  else showmessage(Desole);
  Finally
    LibereObjet(TObject(Requete));
    E.PeriodeAutre:=PeriodeAutre_Tmp;
    E.AutrePeriode:=PeriodeAutre_Tmp.Retour;
//    E.AutrePeriode:=False;
    ParamAffichage.EventButtonDetailClick :=nil;
//    DeFiltrageDataSet(DMRech.TaChargeAPayerRech);
    LibereObjet(TObject(List1));
  end;
End;


procedure TDMProvisions.EventValider(Sender: TObject);
begin
if VisuListeView<>nil then
  Begin
    if VisuListeView.Visible then
      Begin
        if VisuListeView.FormState = [fsmodal] then
        VisuListeView.ModalResult:=mrok
        else
        VisuListeView.close;
      end;
  end;
end;


end.
