unit DmImportReleves;

interface

uses
  SysUtils, Classes, DB,Forms, Controls,DBTables,Dialogs,DialogEx,
  E2_LibInfosTable,LibChoixCompte,ComCtrls,E2_Decl_Records,GrDBGrid,
  DBClient,Windows, DBXpress, SqlExpr;

type
 TCompteBancaire=Class(Tobject)
    id:integer;
    journal:string;
    codeBancaire:string;
    login:string;
    password:string;
    iban:string;
    codeBic:string;
    site:string;
    code_banque:string;
    code_guichet:string;
    compte_banque:string;

    private
    protected
    property Tid:integer read id write id;
    property Tjournal:string read journal write journal;
    property TcodeBancaire:String read codeBancaire write codeBancaire;
    property Tlogin:String read login write login;
    property Tpassword:String read password write password;
    property Tiban:String read iban write iban;
    property TcodeBic:String read codeBic write codeBic;
    property Tsite:String read site write site;
    property Tcode_banque:String read code_banque write code_banque;
    property Tcode_guichet:String read code_guichet write code_guichet;
    property Tcompte_banque:String read compte_banque write compte_banque;

  public
    { D�clarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;

  end;


  TLigneImportReleve=Class(Tobject)
    COMPTE:string;
    JOURNAL:string;
    BANKID:string;
    BRANCHID:string;
    ACCTID:string;
    DTPOSTED:string;
    DEBIT:string;
    CREDIT:string;
    FITID:string;
    NAME:string;
    MEMO:string;
    DOUBLON:boolean;
    IMPORT:boolean;
    IDLIGNE_ORIGINE:integer;

    private
    protected
    property TCOMPTE:String read COMPTE write COMPTE;
    property TJOURNAL:string read JOURNAL write JOURNAL;
    property TBANKID:String read BANKID write BANKID;
    property TBRANCHID:String read BRANCHID write BRANCHID;
    property TACCTID:String read ACCTID write ACCTID;
    property TDTPOSTED:String read DTPOSTED write DTPOSTED;
    property TDEBIT:String read DEBIT write DEBIT;
    property TCREDIT:String read CREDIT write CREDIT;
    property TFITID:String read FITID write FITID;
    property TNAME:String read NAME write NAME;
    property TMEMO:String read MEMO write MEMO;
    property TDOUBLON:boolean read DOUBLON write DOUBLON;
    property TIMPORT:boolean read IMPORT write IMPORT;

  public
    { D�clarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;

  TLigneReleve=Class(Tobject)
    IDENTIFIANT:integer;
    COMPTE:string;
    DATEOP:Tdate;
    DEBIT:Currency;
    CREDIT:Currency;
    DESIGNATION:string;
    SUPPLEMENT:string;
    REFERENCE:string;
    MARQUE:string;
    RAPPROCHEMENT:string;
    ID_ECRITURE:integer;
    CPTTIERS:string;

    private
    protected
    property TIDENTIFIANT:integer read IDENTIFIANT write IDENTIFIANT;
    property TCOMPTE:String read COMPTE write COMPTE;
    property TDATEOP:Tdate read DATEOP write DATEOP;
    property TDEBIT:Currency read DEBIT write DEBIT;
    property TCREDIT:Currency read CREDIT write CREDIT;
    property TDESIGNATION:String read DESIGNATION write DESIGNATION;
    property TSUPPLEMENT:String read SUPPLEMENT write SUPPLEMENT;
    property TREFERENCE:String read REFERENCE write REFERENCE;
    property TMARQUE:String read MARQUE write MARQUE;
    property TRAPPROCHEMENT:String read RAPPROCHEMENT write RAPPROCHEMENT;
    property TID_ECRITURE:integer read ID_ECRITURE write ID_ECRITURE;
    property TCPTTIERS:string read CPTTIERS write CPTTIERS;

  public
    { D�clarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;

    TLigneRapprochement=Class(Tobject)
    IDENTIFIANT:integer;
    COMPTE:string;
    DATEOP:TDate;
    DEBIT:currency;
    CREDIT:currency;
    DESIGNATION:string;
    REFERENCE:string;
    MARQUE:string;
    RAPPROCHEMENT:string;

    private
    protected
    property TIDENTIFIANT:integer read IDENTIFIANT write IDENTIFIANT;
    property TCOMPTE:String read COMPTE write COMPTE;
    property TDATEOP:Tdate read DATEOP write DATEOP;
    property TDEBIT:currency read DEBIT write DEBIT;
    property TCREDIT:currency read CREDIT write CREDIT;
    property TDESIGNATION:String read DESIGNATION write DESIGNATION;
    property TREFERENCE:String read REFERENCE write REFERENCE;
    property TMARQUE:String read MARQUE write MARQUE;
    property TRAPPROCHEMENT:String read RAPPROCHEMENT write RAPPROCHEMENT;

  public
    { D�clarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;

   TMarquageReleve=Class(Tobject)
    Marque:String;
    IdEcriture:integer;
    IdReleve:integer;
    private
    property TMarque:String read Marque write Marque;
    property TIdEcriture:integer read IdEcriture write IdEcriture;
    property TIdReleve:integer read IdReleve write IdReleve;
  public
    { D�clarations publiques }
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;

  TDMImportReleve = class(TDataModule)
    QuEcr_RappBanc: TQuery;
    DaEcr_RappBanc: TDataSource;
    DaReleve: TDataSource;
    QuListeMarque: TQuery;
    QuReleve: TQuery;
    TaEcr_RappBanc: TTable;
    TaReleve: TTable;
    TaEcrTemp: TTable;
    TaReleveTemp: TTable;
    TaComptesBancaire: TTable;
    DaComptesBancaires: TDataSource;
    TaCompteBancaireTemp: TTable;
    QuMaxMarque: TQuery;
    DataReleve: TDataSource;
    TaReleveReglement: TTable;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    DateField1: TDateField;
    CurrencyField1: TCurrencyField;
    CurrencyField2: TCurrencyField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    IntegerField2: TIntegerField;
    StringField8: TStringField;
    BooleanField1: TBooleanField;
    ClientDataSet1: TClientDataSet;
    TaReleveID: TIntegerField;
    TaRelevecompte: TStringField;
    TaRelevedateOp: TDateField;
    TaReleveDebit: TCurrencyField;
    TaReleveCredit: TCurrencyField;
    TaRelevedesignation: TStringField;
    TaRelevesupplement: TStringField;
    TaRelevemarque: TStringField;
    TaReleveReference: TStringField;
    TaRelevedivers: TStringField;
    TaReleverapprochement: TStringField;
    TaReleveid_Ecriture: TIntegerField;
    TaRelevecptTiers: TStringField;
    TaReleveAbandon: TBooleanField;
    QuReleveEbics: TQuery;
    TaReleveEbics: TTable;
    TaReleveEbics_maxID: TTable;
    QuLigneComplementEbics: TQuery;
    TaComplementEbics: TTable;
    TaComplementEbics_maxID: TTable;
    TaReleveEbicsTraite: TTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    Function ListeMarque(CompteBanque:String):TStringList;
    procedure TaEcr_FilterRecord_Tous(DataSet: TDataSet;
    var Accept: Boolean);
    procedure TaEcr_FilterRecord_NonMarque(DataSet: TDataSet;
    var Accept: Boolean);

    procedure TaEcr_FilterRecord_EnCours(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcr_FilterRecord_DemarquageEnCours(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcr_FilterRecord_Marque(DataSet: TDataSet;
      var Accept: Boolean);

    procedure TaReleve_FilterRecord_Tous(DataSet: TDataSet;
    var Accept: Boolean);
    procedure TaReleve_FilterRecord_NonMarque(DataSet: TDataSet;
    var Accept: Boolean);

    procedure TaReleve_FilterRecord_EnCours(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaReleve_FilterRecord_DemarquageEnCours(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaReleve_FilterRecord_Marque(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaEcr_BeforePost(DataSet: TDataSet);
    procedure TaReleveBeforeInsert(DataSet: TDataSet);
    procedure TaReleveBeforeDelete(DataSet: TDataSet);
    procedure TaEcr_BeforeDelete(DataSet: TDataSet);
    procedure TaEcr_BeforeInsert(DataSet: TDataSet);
    procedure MarquageEcriture(champ:string;marque:string;identifiant:integer;commit:boolean=false);
    Procedure MarquageReleve(champ:string;marque:string;identifiant:integer;commit:boolean=false);
    procedure RefreshQuery(compte:string);
    procedure MarquerEcriture(marque:string;identifiant:integer;commit:boolean);
    procedure MarquerReleve(marque:string;identifiant:integer;commit:boolean);
    function ImportLignesReleve(listeLignes:Tstringlist;ForceAffiche:boolean;commit:boolean=true):boolean;
    function verifComptesBancaire(compteBancaire:string;ForceAffiche:boolean=true;commit:boolean=false):TInfosModel;
    function VerifSiDoublon(reference:string;compte:string):boolean;
    Function CtrlSaisieComptesBancaires(CCourant:Tfield):TErreurSaisie;
    procedure TaComptesBancaireAfterPost(DataSet: TDataSet);
    procedure TaComptesBancaireBeforePost(DataSet: TDataSet);
    function GestionRelationMarqueRapprochement(MarqueReleve,Rapprochement:string;Update:boolean;idEnCours:integer):boolean;
    procedure AffichageListeRelation(MarqueReleve,Rapprochement:string;idEnCours:integer);
    function MaxMarque(Rapprochement:string):string;
    procedure DeleteLigneReleve(identifiant:integer);
    procedure CreationReglement(DBGridReleve: TGrDBGrid;marquageAuto:boolean=false;afficheChoix:boolean=false);
    procedure CreationReglementUneLigne(DBGridReleve: TGrDBGrid;marquageAuto:boolean;afficheChoix:boolean=false);
    procedure TaReleveReglementAfterPost(DataSet: TDataSet);
    procedure TaReleveReglement_FilterRecord_CptRempli(DataSet: TDataSet;
               var Accept: Boolean);
    procedure TaReleveReglement_FilterRecord_AnnuleAffectation(DataSet: TDataSet;
               var Accept: Boolean);
    procedure TaReleveReglement_FilterRecord_EnCours(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaReleveReglement_FilterRecord_Abandonne(DataSet: TDataSet;
       var Accept: Boolean);
    procedure TaReleveReglementBeforePost(DataSet: TDataSet);
    Function CtrlSaisieReleveBancaire(CCourant:Tfield):TErreurSaisie;
    procedure TaReleveBeforePost(DataSet: TDataSet);
    function recupDerniereDateReleveCompte(compteBancaire:string):tdate;
    function listeCompteBancaire():Tstringlist;
    procedure initialisePiece(var SourcePiece:TRecordPiece; var listeFactice:Tlist);
    procedure creationPieceReglement(var SourcePiece:TRecordPiece; marquageAuto:boolean ;var ValPieceAutoGen:TValPieceAutoGenere; var listeFactice:Tlist ;var compteAppelant:Tstringlist ; var ListeOd:Tstringlist; afficheChoix : boolean) ;
    procedure creationMarquageReleve(listeOd :TStringList ;marquageAuto,uneLigneParPiece:boolean );

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    ListeMarquageEcritureEnCours,ListeMarquageReleveEnCours:TStringList;
    ListeMarqueReleve,listeMarqueEnCours:TstringList;
    ListeMarquageAuto:TstringList;
    ToutesMarques,Abandonne:boolean;
    MarqueCourante:String;
    tiersCourant:string;
    DateFinReleve:TDate;
    CompteReglement:string;
  end;

var
  DMImportReleve: TDMImportReleve;

  Function EditionEtatPointageReleveL(Compte:String;TypeEdition : integer;typeRapprochement:TtypeRapprochement; DataSet:TDataSet):Boolean;
  Function CalculTotauxRappBanc(CompteBanque:String;TypeCalcul:Integer;DateDeb,DateFin:Tdate):TTotauxRappBanc;
  function GestionSuppressionRelationReleveBancaire(id_ecriture:integer):boolean;

implementation

uses LibSQL, E2_Librairie_Obj,  DMConstantes,
    DMRecherche, InputQueryFrm_F,
    LibDates, Gr_Librairie_Obj, lib_chaine, LibRessourceString,
  E2_VisuListeView, ObjetEdition, E2_Main, DMDiocEtatBalance,
  DMRapprochementBancaire, DMPiece, DMImportation, DMTVA, DMBaseDonnee,
  DMJournaux, ExRxDBGrid, DMTier, E2_ChoixReglementAuto, E2_AideCompte,
  DMRecherche_Obj;

{$R *.dfm}

constructor TCompteBancaire.Create(AOwner :TComponent);
Begin
inherited create;
End;

destructor TCompteBancaire.Destroy;
Begin
inherited Destroy;
End;




constructor TLigneImportReleve.Create(AOwner :TComponent);
Begin
inherited create;
End;

destructor TLigneImportReleve.Destroy;
Begin
inherited Destroy;
End;

constructor TLigneReleve.Create(AOwner :TComponent);
Begin
inherited create;
MARQUE:=C_StrVide;
RAPPROCHEMENT:=C_StrVide;
End;

destructor TLigneReleve.Destroy;
Begin
inherited Destroy;
End;
constructor TLigneRapprochement.Create(AOwner :TComponent);
Begin
inherited create;
MARQUE:=C_StrVide;
RAPPROCHEMENT:=C_StrVide;
End;

destructor TLigneRapprochement.Destroy;
Begin
inherited Destroy;
End;


constructor TMarquageReleve.Create(AOwner :TComponent);
Begin
inherited create;
End;

destructor TMarquageReleve.Destroy;
Begin
inherited Destroy;
End;

procedure TDMImportReleve.DataModuleCreate(Sender: TObject);
begin
OuvrirTouteTable('',Tcontrol(self));
ListeMarquageEcritureEnCours:=TStringList.Create;
ListeMarquageEcritureEnCours.Sorted:=true;
ListeMarquageEcritureEnCours.Duplicates:= dupIgnore;

ListeMarquageReleveEnCours:=TStringList.Create;
ListeMarquageReleveEnCours.Sorted:=true;
ListeMarquageReleveEnCours.Duplicates:= dupIgnore;

ListeMarqueReleve:=TStringList.Create;
ListeMarqueReleve.Sorted:=true;
ListeMarqueReleve.Duplicates:= dupIgnore;


listeMarqueEnCours:=TStringList.Create;
listeMarqueEnCours.Sorted:=true;
listeMarqueEnCours.Duplicates:= dupIgnore;

ListeMarquageAuto:=Tstringlist.Create;
ToutesMarques:=false;
end;

procedure TDMImportReleve.DataModuleDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
initialise_tstringlist(ListeMarquageEcritureEnCours);
initialise_tstringlist(ListeMarquageReleveEnCours);
initialise_tstringlist(ListeMarqueReleve);
initialise_tstringlist(ListeMarquageAuto);
initialise_tstringlist(listeMarqueEnCours);
DMImportReleve := nil;
end;

Function TDMImportReleve.ListeMarque(CompteBanque:String):TStringList;
//Var
//I:Integer;
Begin
Result:=TStringList.Create;
Result.Clear;
if ToutesMarques then
  begin
      QuListeMarque.Close;
      QuListeMarque.ParamByName('Compte').AsString := CompteBanque;
      QuListeMarque.ParamByName('DateFin').AsDate:=DMImportReleve.DateFinReleve;
      QuListeMarque.ParamByName('Rapprochement').AsString:=DMImportReleve.MarqueCourante;
      QuListeMarque.Open;
      QuListeMarque.First;

       while not DMImportReleve.QuListeMarque.EOF do
         begin
         // Permet d'�crire les date de dbut et de fin
           if trim(DMImportReleve.QuListeMarque.FindField('marque').AsString)<>'' then
             Result.Add(DMImportReleve.QuListeMarque.FindField('marque').AsString);
           DMImportReleve.QuListeMarque.Next;
         end;
  end
else
  result.Assign(listeMarqueEnCours);
end;


//table rapprochement relev�
procedure TDMImportReleve.TaReleve_FilterRecord_Tous(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
accept:=DAtaSet.findField('DateOP').asdatetime<=DMImportReleve.DateFinReleve;
if accept then
  accept:=(DAtaSet.findField('Rapprochement').AsString = '')or(DAtaSet.findField('Rapprochement').AsString = MarqueCourante);

if accept then
   Accept:=(((ListeMarqueReleve.IndexOf(DAtaSet.findField('marque').AsString) <> -1)or
 (ListeMarquageReleveEnCours.IndexOf(DAtaSet.findField('id').AsString) <> -1)
          or ((DAtaSet.findField('marque').AsString = '')and(DAtaSet.findField('Rapprochement').AsString = ''))));
end;

end;

procedure TDMImportReleve.TaReleve_FilterRecord_NonMarque(DataSet: TDataSet;
  var Accept: Boolean);
Begin
if not((csDestroying)in dataset.ComponentState) then
begin
Accept:=(DAtaSet.findField('marque').AsString = '')and (DAtaSet.findField('Rapprochement').AsString = '');
if accept then
  accept:=DAtaSet.findField('DateOP').asdatetime<=DMImportReleve.DateFinReleve;
end;

End;

procedure TDMImportReleve.TaReleve_FilterRecord_EnCours(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
accept:=(DAtaSet.findField('Rapprochement').AsString = '')or(DAtaSet.findField('Rapprochement').AsString = MarqueCourante);
if accept then
  Accept:=(((ListeMarquageReleveEnCours.IndexOf(DAtaSet.findField('ID').AsString) <> -1)
          or ((DAtaSet.findField('marque').AsString = '')and(DAtaSet.findField('Rapprochement').AsString = ''))));
if accept then
  accept:=DAtaSet.findField('DateOP').asdatetime<=DMImportReleve.DateFinReleve;
end;

end;


procedure TDMImportReleve.TaReleve_FilterRecord_DemarquageEnCours(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
Accept:=(ListeMarquageReleveEnCours.IndexOf(DAtaSet.findField('ID').AsString) <> -1);
if accept then
  accept:=DAtaSet.findField('DateOP').asdatetime<=DMImportReleve.DateFinReleve;
end;

end;

// A n'utiliser que lors du d�mmarquage des marques en cours !!!!!!!!!!!
//
procedure TDMImportReleve.TaReleve_FilterRecord_Marque(DataSet: TDataSet;
  var Accept: Boolean);
Begin
if not((csDestroying)in dataset.ComponentState) then
begin
accept:=(DAtaSet.findField('Rapprochement').AsString = '')or(DAtaSet.findField('Rapprochement').AsString = MarqueCourante);
if accept then
  Accept:=(DAtaSet.findField('marque').AsString <> '')
  and ((ListeMarqueReleve.IndexOf(DAtaSet.findField('marque').AsString) <> -1)or
   (ListeMarquageReleveEnCours.IndexOf(DAtaSet.findField('id').AsString) <> -1));
if accept then
  accept:=DAtaSet.findField('DateOp').asdatetime<=DMImportReleve.DateFinReleve;
end;

End;

//table rapprochement bancaire
procedure TDMImportReleve.TaEcr_FilterRecord_Tous(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
if accept then
  accept:=(DAtaSet.findField('Rapprochement').AsString = '')or(DAtaSet.findField('Rapprochement').AsString = MarqueCourante);
if accept then
   Accept:=(((ListeMarqueReleve.IndexOf(DAtaSet.findField('MarqueReleve').AsString) <> -1)
   or (ListeMarquageEcritureEnCours.IndexOf(DAtaSet.findField('id').AsString) <> -1)
          or ((DAtaSet.findField('MarqueReleve').AsString = '')
             and(DAtaSet.findField('Rapprochement').AsString = ''))));
end;

end;

procedure TDMImportReleve.TaEcr_FilterRecord_NonMarque(DataSet: TDataSet;
  var Accept: Boolean);
Begin
if not((csDestroying)in dataset.ComponentState) then
begin
Accept:=(DAtaSet.findField('MarqueReleve').AsString = '')and(DAtaSet.findField('Rapprochement').AsString = '');
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
end;


End;


procedure TDMImportReleve.TaEcr_FilterRecord_EnCours(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
accept:=(DAtaSet.findField('Rapprochement').AsString = '')or(DAtaSet.findField('Rapprochement').AsString = MarqueCourante);

if accept then
  Accept:=(((ListeMarquageEcritureEnCours.IndexOf(DAtaSet.findField('ID').AsString) <> -1)
          or ((DAtaSet.findField('MarqueReleve').AsString = '')
            and(DAtaSet.findField('Rapprochement').AsString = ''))));
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
end;


end;


procedure TDMImportReleve.TaEcr_FilterRecord_DemarquageEnCours(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
Accept:=(ListeMarquageEcritureEnCours.IndexOf(DAtaSet.findField('ID').AsString) <> -1);
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
end;


end;

// A n'utiliser que lors du d�mmarquage des marques en cours !!!!!!!!!!!
//
procedure TDMImportReleve.TaEcr_FilterRecord_Marque(DataSet: TDataSet;
  var Accept: Boolean);
Begin
if not((csDestroying)in dataset.ComponentState) then
begin
accept:=(DAtaSet.findField('Rapprochement').AsString = '')or(DAtaSet.findField('Rapprochement').AsString = MarqueCourante);
if accept then
  Accept:=(DAtaSet.findField('MarqueReleve').AsString <> '')
  and ((ListeMarqueReleve.IndexOf(DAtaSet.findField('MarqueReleve').AsString) <> -1)or
     (ListeMarquageEcritureEnCours.IndexOf(DAtaSet.findField('id').AsString) <> -1));
if accept then
  accept:=DAtaSet.findField('Date').asdatetime<=e.DatExoFin;
end;


End;

procedure TDMImportReleve.TaEcr_BeforePost(DataSet: TDataSet);
Var
I:Integer;
begin
I:=ListeMarquageEcritureEnCours.IndexOf(DAtaSet.findField('ID').AsString);
if ((I <> -1) and (DAtaSet.findField('MarqueReleve').AsString = '' )) then
    ListeMarquageEcritureEnCours.Delete(I);
I:=listeMarqueEnCours.IndexOf(DAtaSet.findField('MarqueReleve').AsString);
if (I <> -1) then  listeMarqueEnCours.Delete(I);
if DAtaSet.findField('MarqueReleve').AsString <> '' then
 begin
  ListeMarquageEcritureEnCours.Add(DAtaSet.findField('ID').AsString);
  listeMarqueEnCours.Add(DAtaSet.findField('MarqueReleve').AsString);

  //MarqueCourante:=DAtaSet.findField('MarqueReleve').AsString;
 end;
end;


procedure TDMImportReleve.TaReleveBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMImportReleve.TaReleveBeforeDelete(DataSet: TDataSet);
begin
Showmessage('Veuillez utiliser - Saisie Pi�ce - pour supprimer une pi�ce !');
abort;
end;

procedure TDMImportReleve.TaEcr_BeforeDelete(DataSet: TDataSet);
begin
Showmessage('Veuillez utiliser - Saisie Pi�ce - pour supprimer une pi�ce !');
abort;
end;

procedure TDMImportReleve.TaEcr_BeforeInsert(DataSet: TDataSet);
begin
abort;
end;



procedure TDMImportReleve.MarquageEcriture(champ:string;marque:string;identifiant:integer;commit:boolean);
var
i:integer;
OldMarque:string;
begin
try
  try
    if(TaEcr_RappBanc.Locate('id',identifiant,[]))then
      begin
        TableGereStartTransaction(DMImportReleve.TaEcr_RappBanc);
          TableGereEdit(TaEcr_RappBanc);
          OldMarque:= TaEcr_RappBanc.FindField(champ).AsString;
          TaEcr_RappBanc.FindField(champ).AsString := marque;
          TableGerePost(TaEcr_RappBanc);
          if (marque = C_StrVide) then
            begin
              i:=DMImportReleve.ListeMarquageEcritureEnCours.IndexOf(TaEcr_RappBanc.FindField('id').AsString);
              if i<>-1 then DMImportReleve.ListeMarquageEcritureEnCours.Delete(i);
              i:=DMImportReleve.listeMarqueEnCours.IndexOf(OldMarque);
              if i<>-1 then DMImportReleve.listeMarqueEnCours.Delete(i);
            end;
      end
    else
      abort;
  except
    Showmessage('Le marquage n''a pas pu s''effectu� !!!');
    TableGereRollBack(TaEcr_RappBanc);
    abort;
  end;
finally
   if commit then TableGereCommit(TaEcr_RappBanc);
//    if (marque <> C_StrVide)
//        then DMImportReleve.MarqueCourante:=marque;
end;
end;

procedure TDMImportReleve.MarquageReleve(champ:string;marque:string;identifiant:integer;commit:boolean);
var
i:integer;
OldMarque:string;
begin
try
  try
    if(TaReleve.Locate('id',identifiant,[]))then
      begin
        TableGereStartTransaction(DMImportReleve.TaReleve);
          TableGereEdit(TaReleve);
           OldMarque:=TaReleve.FindField(champ).AsString;
          TaReleve.FindField(champ).AsString := marque;
          TableGerePost(TaReleve);
          if (marque = C_StrVide) then
            begin
              i:=DMImportReleve.ListeMarquageReleveEnCours.IndexOf(TaReleve.FindField('id').AsString);
              if i<>-1 then DMImportReleve.ListeMarquageReleveEnCours.Delete(i);
              i:=DMImportReleve.listeMarqueEnCours.IndexOf(OldMarque);
              if i<>-1 then DMImportReleve.listeMarqueEnCours.Delete(i);
              //rechercher le marque auto correspondant, s'il existe pour le supprimer
            end;

      end
    else
      abort;
  except
    Showmessage('Le marquage n''a pas pu s''effectu� !!!');
    TableGereRollBack(TaReleve);
    abort;
  end;
finally
   if commit then TableGereCommit(TaReleve);
//       if (marque <> C_StrVide)
//        then DMImportReleve.MarqueCourante:=marque;
end;
end;


procedure TDMImportReleve.RefreshQuery(compte:string);
begin
ListeMarqueReleve:=ListeMarque(compte);
TableGereClose(QuEcr_RappBanc);
TableGereClose(QuReleve);
QuEcr_RappBanc.open;
QuReleve.open;
end;

procedure TDMImportReleve.MarquerEcriture(marque:string;identifiant:integer;commit:boolean);
begin
  try
     if TaEcrTemp.Locate('id',identifiant,[]) then
       begin
           TableGereStartTransaction(TaEcrTemp);
           TableGereEdit(TaEcrTemp);
           TaEcrTemp.FindField('MarqueReleve').asstring:=marque;
           TableGerePost(TaEcrTemp);
           if commit then TableGereCommit(TaEcrTemp);
       end;
  except
    TableGereRollBack(taEcrTemp);
  end;
end;

procedure TDMImportReleve.MarquerReleve(marque:string;identifiant:integer;commit:boolean);
begin
  try
     if TaReleveTemp.Locate('id',identifiant,[]) then
       begin
           TableGereStartTransaction(TaReleveTemp);
           TableGereEdit(TaReleveTemp);
           TaReleveTemp.FindField('MarqueReleve').asstring:=marque;
           TableGerePost(TaReleveTemp);
           if commit then TableGereCommit(TaReleveTemp);
       end;
  except
    TableGereRollBack(TaReleveTemp);
  end;
end;

function TDMImportReleve.ImportLignesReleve(listeLignes:Tstringlist;ForceAffiche:boolean;commit:boolean):boolean;
var
i:integer;
ligne:TLigneImportReleve;
format:TFormatSettings;
A,M,J : word;
DateOp:TDateTime;
infosModel:TInfosModel;
Query:Tquery;
begin
try //finally
try
result:=true;
Query:=TQuery.Create(self);
//showmessage('avant open');
TaReleveTemp.Open;
//showmessage('apr�s open');
TableGereStartTransaction(TaReleveTemp);
Query.SQL.Clear;
Query.SQL.Add('update ta_releve_ebics set traite=true where id=:idOrigine ');

if(listeLignes.Count>0)then
  for i:=0 to listeLignes.Count-1 do
  begin

       DateOp:=0;
       ligne:=TLigneImportReleve(listeLignes.Objects[i]);
       if ligne.IMPORT then
          begin
//             showmessage('avant v�rif compte bancaire');
             infosModel:=verifComptesBancaire(ligne.BANKID+'-'+ligne.BRANCHID+'-'+ligne.ACCTID,ForceAffiche,commit);
//             showmessage('apres v�rif compte bancaire');
//             showmessage('infosModel.compte :'+infosModel.compte);
             if infosModel.compte='' then
             begin
               showmessage('Le compte comptable li� au compte bancaire : '+ligne.BANKID+'-'+ligne.BRANCHID+'-'+ligne.ACCTID+' n''est pas valide'+
                 #10#13+'Abandon de l''importation du relev�');
               abort;
             end;
             TableGereInsert(TaReleveTemp);
             TaReleveTemp.FindField('id').AsInteger:=MaxId_Query(TaReleveTemp,'Id');
//             showmessage('MaxId_Query :'+TaReleveTemp.FindField('id').AsString);
             TaReleveTemp.FindField('Compte').AsString:=infosModel.compte;

             TaReleveTemp.FindField('DateOp').AsString:=ligne.DTPOSTED;

             TaReleveTemp.FindField('reference').AsString:=ligne.FITID;
             TaReleveTemp.FindField('credit').AsString:=abs(QueDesChiffres(ligne.CREDIT));
             TaReleveTemp.FindField('Debit').AsString:=abs(QueDesChiffres(ligne.DEBIT));
             TaReleveTemp.FindField('designation').AsString:=ligne.NAME;
             TaReleveTemp.FindField('supplement').AsString:=ligne.MEMO;
             TaReleveTemp.FindField('code_banque').AsString:=ligne.BANKID;
             TaReleveTemp.FindField('code_guichet').AsString:=ligne.BRANCHID;
             TaReleveTemp.FindField('compte_banque').AsString:=ligne.ACCTID;
             tableGerePost(TaReleveTemp);


             TableGereOpen(TaReleveEbicsTraite);
             try
//             Query.close;
//             Query.ParamByName('idOrigine').AsInteger:=ligne.IDLIGNE_ORIGINE;
//             Query.ExecSQL;
//             Query.close;

             if(TaReleveEbicsTraite.Locate('id',IntToStr_Lgr(ligne.IDLIGNE_ORIGINE),[]))then
               begin
                  TableGereEdit(TaReleveEbicsTraite);
                  TaReleveEbicsTraite.FindField('traite').AsBoolean:=true;
                  TableGerePost(TaReleveEbicsTraite);
               end;
             except
                tableGereRollBack(TaReleveEbicsTraite);
             end;
          end;
  end;
if commit then TableGereCommit(TaReleveTemp);
except
   result:=false;
   TableGereRollBack(TaReleveEbics);
   TableGereRollBack(TaReleveTemp);
end;
finally
  Query.Close;
  Query.Free;
end;
end;


function TDMImportReleve.verifComptesBancaire(compteBancaire:string;ForceAffiche:boolean;commit:boolean):TInfosModel;
var
requete:TQuery;
infosJournal:TInfosModel;
ParamAffichCompte:TParamAffichCompte;
begin
try//finally
    if DMRech=nil then DMRech:=TDMRech.Create(self);
    DeFiltrageDataSet(DMRech.TaModelRech);
    requete:=TQuery.Create(self);
    requete.DatabaseName:=DM_C_NomAliasDossier;
    requete.SQL.Add('select c.journal,M.compte,M.libelle from ComptesBancaire.db c');
    requete.SQL.Add(' join model.db M on m.Journal=c.journal');
    requete.SQL.Add(' where codeBancaire like :compteBancaire');
    requete.ParamByName('compteBancaire').AsString:=compteBancaire;
    requete.open;
    infosJournal.ResultInfos:=requete.RecordCount> 0;
    if infosJournal.ResultInfos then
      begin
         infosJournal.journal:=requete.findfield('journal').asstring;
         infosJournal.Libelle:=requete.findfield('Libelle').asstring;
         infosJournal.Compte:=requete.findfield('compte').asstring;
      end;
    if (not infosJournal.ResultInfos) and (ForceAffiche)then
       begin
                  InitialiseParamAffichCompte(ParamAffichCompte);
                  ParamAffichCompte.Titre:='S�lectionnez un journal de banque';
                  ParamAffichCompte.Tiers:=false;
                  requete.close;
                  requete.SQL.Clear;
                  requete.DatabaseName := DM_C_NomAliasDossier;
                  requete.SQL.Add('select code,libelle_model,journal,compte from model.db');
                  requete.Open;
                  ParamAffichCompte.Dataset:=requete;

                  ParamAffichCompte.Filtrer:=false;
                  ParamAffichCompte.FiltreNbChiffre := 0;
                  ParamAffichCompte.ListeChamps.Add('code');
                  ParamAffichCompte.ListeChamps.Add('libelle_model');
                  ParamAffichCompte.ListeChamps.Add('journal');
                  ParamAffichCompte.ListeChamps.Add('compte');
                  ParamAffichCompte.EventButtonAjouterClick:=nil;
                  ParamAffichCompte.EventButtonSupprimerClick:=nil;

          MyInputQuery_F1(self,'Journal de banque','Indiquer le journal de banque li� au compte bancaire :'+compteBancaire,
          infosJournal.Journal,ParamAffichCompte,'',[#0],10);
          infosJournal:=Infos_TInfosModel(DMRech.TaModelRech,'Journal',[infosJournal.Journal]);
          if infosJournal.ResultInfos then
            result:=infosJournal
          else Initialise_TInfosModel(result);
//          showmessage('Apres recuperation du compte : '+result.Compte);
          if result.Compte<>'' then
          begin
            try
            TaCompteBancaireTemp.Open;
              TableGereStartTransaction(TaCompteBancaireTemp);
              //mettre � jour la table de relation compteBancaire
              if TaCompteBancaireTemp.Locate('codeBancaire',compteBancaire,[])then
              begin
//                 showmessage('avant mise � jour compte bancaire');
                 TableGereEdit(TaCompteBancaireTemp);
                 TaCompteBancaireTemp.FindField('journal').AsString:=infosJournal.Journal;
                 TableGerePost(TaCompteBancaireTemp);
                 TableGereCommit(TaCompteBancaireTemp);
//                 showmessage('avant mise � jour compte bancaire');
              end
              else
              begin
//              showmessage('avant insertion compte bancaire');
                TableGereInsert(TaCompteBancaireTemp);
                 TaCompteBancaireTemp.FindField('id').AsInteger:=MaxId_Query(TaCompteBancaireTemp,'Id');
                 TaCompteBancaireTemp.FindField('journal').AsString:=infosJournal.Journal;
                 TaCompteBancaireTemp.FindField('codeBancaire').AsString:=compteBancaire;
                 TaCompteBancaireTemp.FindField('login').AsString:='login';
                 TaCompteBancaireTemp.FindField('passWord').AsString:='passWord';
                 TaCompteBancaireTemp.FindField('site').AsString:='site';
                 TableGerePost(TaCompteBancaireTemp);
                 TableGereCommit(TaCompteBancaireTemp);
//                 showmessage('apres insertion compte bancaire');
              end;
            except
                TableGereRollBack(TaCompteBancaireTemp);
            end;
          end;
       end
    else
       result:=infosJournal;
finally
if commit then TableGereCommit(TaCompteBancaireTemp);
requete.Close;
requete.Free;
LibereParamAffichCompte(ParamAffichCompte);
end;
end;

function TDMImportReleve.VerifSiDoublon(reference:string;compte:string):boolean;
var
requete:TQuery;
begin
try//finally
result:=false;
    requete:=TQuery.Create(self);
    requete.DatabaseName:=DM_C_NomAliasDossier;
    requete.SQL.Add('select id from ta_releveBancaire.db ');
    requete.SQL.Add(' where reference like :reference');
//    if compte<>'' then
//      requete.SQL.Add(' and compte like :compte');

    requete.ParamByName('reference').AsString:=reference;

//    if compte<>'' then
//       requete.ParamByName('compte').AsString:=compte;

    requete.open;
    result:=requete.RecordCount> 0;
finally
requete.close;
  requete.free;
end;
end;


Function TDMImportReleve.CtrlSaisieComptesBancaires(CCourant:Tfield):TErreurSaisie;
var
i:integer;
requete:Tquery;
begin // initialisation des variables de retour de fonction
try//finally
requete:=TQuery.Create(self);
case CCourant.DataSet.State of
   dsedit:Begin
             case CCourant.Index of
                1:Begin //Journal
                     requete.DatabaseName:=DM_C_NomAliasDossier;
                     requete.sql.Add('select journal from model.db');
                     requete.sql.Add(' where journal like :Journal');
                     requete.ParamByName('Journal').asstring:=Ccourant.text;
                     requete.Open;
                     if requete.RecordCount=0 then
                       begin
                         result.retour:=false;
                         result.CodeErreur:=1000;
                       end;
                  end;
             end;
          end;
end;
finally
  requete.Close;
  requete.Free;
end;
end;

procedure TDMImportReleve.TaComptesBancaireAfterPost(DataSet: TDataSet);
begin
TableGereCommit(dataset);
end;

procedure TDMImportReleve.TaComptesBancaireBeforePost(DataSet: TDataSet);
var
i:integer;
Erreur:TErreurSaisie;
begin
for i:= 0 to Dataset.FieldCount-1 do
case Dataset.State of
   dsEdit:Begin
            Erreur:=CtrlSaisieComptesBancaires(Dataset.Fields[i]);
            if Erreur.Retour= false then
               begin
                case Erreur.CodeErreur of
                   1000:Begin
                        messagedlg('Ce journal de banque n''est pas valide',Dialogs.MtWarning,[Dialogs.mbOK],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
               end;
              end;
            end;
end;
end;

function TDMImportReleve.GestionRelationMarqueRapprochement(MarqueReleve,Rapprochement:string;Update:boolean;idEnCours:integer):boolean;
var
 db : TMsgDlgParams;
  MessageLGR:TMessageLGR;
  Retour:integer;
  Requete:TQuery;
  ParamAffichage:TParamAffichage;
  ListeAAfficher:Tstringlist;
begin
try//finally
try//except
   result:=true;
   InitMsgDlgParams(db);
   requete:=TQuery.Create(self);
   ListeAAfficher:=TStringList.Create;
    requete.close;
    requete.DatabaseName:=DM_C_NomAliasDossier;
    requete.SQL.Clear;
    requete.SQL.Add(' select cast(''Releve'' as varchar(10))as typeLigne,R.compte,dateOp,Debit,Credit,designation,marque,rapprochement from ta_releveBancaire R ');
    requete.SQL.Add(' where rapprochement=:rapprochement and marque=:marqueReleve ');
    requete.SQL.Add(' Union');
    requete.SQL.Add(' select  cast(''Ecriture'' as varchar(10))as typeEcriture,E.compte,E."Date",E.DebitSaisie,E.CreditSaisie,E.Libelle,E.MarqueReleve,E.Rapprochement from Ecriture E ');
    requete.SQL.Add(' where rapprochement=:rapprochement and marqueReleve=:marqueReleve and id<>:idEcriture');
    requete.ParamByName('rapprochement').AsString:=Rapprochement;
    requete.ParamByName('marqueReleve').AsString:=MarqueReleve;
    requete.ParamByName('idEcriture').AsInteger:=idEnCours;
    requete.open;
    result:=requete.RecordCount=0;
   if( not result)then
       begin
             With db Do
             Begin
              CheckBox        := false;
              lpszText        := Pansichar('La ligne que vous souhaitez modifier est en relation avec une ou plusieurs lignes de d''�criture ou de relev�. '+RetourChariotSimple+
                  'Souhaitez-vous afficher cette liste ?');
              lpszCaption     := Pansichar('Relation avec les relev�s');
              DlgBtn          := [mbCust1,mbCust2,mbCust3];
              DefaultBtn      := mbCust3;
              CustBtnText[mbCust1] := 'Annuler la suppression';
              CustBtnText[mbCust2] := 'Afficher la liste';
              CustBtnText[mbCust3] := 'Ignorer et continuer';
             End;
             Retour:=mrCust3;
             if (not Update)  then Retour:=MsgDlgBox(db);
              result:=(retour=mrCust3);
              if Retour=mrCust2 then
                begin
                  ListeAAfficher:=ChampTableVersListeEx(['typeLigne','compte','dateOp','Debit','Credit','Designation','marque','rapprochement'],requete,';',true);

                  //afficher la liste des lignes concern�es
                  Initialise_TParamAffichage(ParamAffichage);
                        ParamAffichage.AffichModal := true;
                        ParamAffichage.Titre:='Liste des lignes en relation avec la ligne � d�marquer ';
                        ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
                        AfficheVisuListView(ParamAffichage,['typeLigne','compte','dateOp','Debit','Credit','Designation','marqueReleve','rapprochement'],
                                                           [100,100,100,100,100,100,100,100],
                                                           [ListeAAfficher],
                                                           [taLeftJustify,taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                                           [1,2,6..8],
                                                           [4,5],[3]);
                end;
              if Update then
                begin
                    requete.close;
                    requete.DatabaseName:=DM_C_NomAliasDossier;
                    requete.SQL.Clear;
//                    TableGereStartTransaction(DMImportReleve.TaEcrTemp);
                    requete.SQL.Add(' update ta_releveBancaire set rapprochement=null,marque=null ');
                    requete.SQL.Add(' where rapprochement=:rapprochement and marque=:marqueReleve');
                    requete.ParamByName('rapprochement').AsString:=Rapprochement;
                    requete.ParamByName('marqueReleve').AsString:=MarqueReleve;
                    requete.ExecSQL;

//                    requete.close;
//                    requete.SQL.Clear;
//                    requete.SQL.Add(' update ecriture set rapprochement=null,marqueReleve=null ');
//                    requete.SQL.Add(' where rapprochement=:rapprochement and marqueReleve=:marqueReleve and id<>:idEcriture');
//                    requete.ParamByName('rapprochement').AsString:=Rapprochement;
//                    requete.ParamByName('marqueReleve').AsString:=MarqueReleve;
//                     requete.ParamByName('idEcriture').AsInteger:=idEnCours;
//                    requete.ExecSQL;
//                    TableGereCommit(DMImportReleve.TaEcrTemp);
                end;
       end;
except
   result:=false;
end;
finally
  ListeAAfficher.free;
  requete.close;
  requete.free;
end;
end;


procedure TDMImportReleve.AffichageListeRelation(MarqueReleve,Rapprochement:string;idEnCours:integer);
var
  Requete:TQuery;
  ParamAffichage:TParamAffichage;
  ListeAAfficher:Tstringlist;
begin
try//finally

   requete:=TQuery.Create(self);
   ListeAAfficher:=TStringList.Create;
    requete.close;
    requete.DatabaseName:=DM_C_NomAliasDossier;
    requete.SQL.Clear;
    requete.SQL.Add(' select cast(''Releve'' as varchar(10))as typeLigne,R.compte,dateOp,Debit,Credit,designation,marque,rapprochement from ta_releveBancaire R ');
    requete.SQL.Add(' where rapprochement=:rapprochement and marque=:marqueReleve ');
    requete.SQL.Add(' Union');
    requete.SQL.Add(' select  cast(''Ecriture'' as varchar(10))as typeEcriture,E.compte,E."Date",E.DebitSaisie,E.CreditSaisie,E.Libelle,E.MarqueReleve,E.Rapprochement from Ecriture E ');
    requete.SQL.Add(' where rapprochement=:rapprochement and marqueReleve=:marqueReleve and id<>:idEcriture');
    requete.ParamByName('rapprochement').AsString:=Rapprochement;
    requete.ParamByName('marqueReleve').AsString:=MarqueReleve;
    requete.ParamByName('idEcriture').AsInteger:=idEnCours;
    requete.open;
    if requete.RecordCount<>0 then
      begin
        ListeAAfficher:=ChampTableVersListeEx(['typeLigne','compte','dateOp','Debit','Credit','Designation','marque','rapprochement'],requete,';',true);

        //afficher la liste des lignes concern�es
        Initialise_TParamAffichage(ParamAffichage);
              ParamAffichage.AffichModal := true;
              ParamAffichage.Titre:='Liste des lignes en relation avec la ligne de rapprochement en cours ';
              ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
              AfficheVisuListView(ParamAffichage,['typeLigne','compte','dateOp','Debit','Credit','Designation','marqueReleve','rapprochement'],
                                                 [100,100,100,100,100,100,100,100],
                                                 [ListeAAfficher],
                                                 [taLeftJustify,taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                                 [1,2,6..8],
                                                 [4,5],[3]);
       end;
finally
  ListeAAfficher.free;
  requete.close;
  requete.free;
end;
end;

function TDMImportReleve.MaxMarque(Rapprochement:string):string;
var
max:integer;
begin
max:=0;
QuMaxMarque.close;
QuMaxMarque.ParamByName('Rapprochement').AsString:=Rapprochement;
QuMaxMarque.open;
    if QuMaxMarque.RecordCount>0 then
      max:=QuMaxMarque.findfield('maxMarque').AsInteger;
    result:=IntToStr_Comble(max+1,5);
QuMaxMarque.close;    
end;


procedure TDMImportReleve.DeleteLigneReleve(identifiant:integer);
begin
if identifiant<>-1 then
DeFiltrageDataSet(TaReleveTemp);
if TaReleveTemp.Locate('id',identifiant,[]) then
  TableGereDelete(TaReleveTemp);
end;




Function EditionEtatPointageReleveL(Compte:String;TypeEdition : integer;typeRapprochement:TtypeRapprochement; DataSet:TDataSet):Boolean;
 var NomFich,Chemin:String;
     marque:string;
 var date:TDate;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
TotauxRappBanc:TTotauxRappBanc;
TotDebitSaisie,TotCreditSaisie:currency;
TotDebitSaisieMarque,TotCreditSaisieMarque:currency;
Libelle:string;
Begin
try//finally
  Chemin :=E.RepertoireComptaWeb;
  NomFich:='EtatDeRapprochement';
  date:=e.DatExoDebut;
   ObjPrn:=TObjetEdition.Create(application.MainForm);
 ListeValeur:=TStringList.Create;
TotDebitSaisie:=0;
TotCreditSaisie:=0;
TotDebitSaisieMarque:=0;
TotCreditSaisieMarque:=0;

      if DMImportReleve=nil then DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
      ProtectObjetNil([dataSet]);
      if dataset = nil then begin
         // Prevu pour passer le dataset concern�
      end;
      case typeRapprochement of     //C_TousRapp,C_EnCoursRapp,C_NonMarques,C_Marques
        C_NonMarques:begin
            DataSet.OnFilterRecord:=DMImportReleve.TaReleve_FilterRecord_NonMarque;
          end;
        C_Marques:begin
            DataSet.OnFilterRecord:=DMImportReleve.TaReleve_FilterRecord_Marque;
          end;
        C_TousRapp:begin
            DataSet.OnFilterRecord:=DMImportReleve.TaReleve_FilterRecord_Tous;
          end;
        C_EnCoursRapp:begin
            DataSet.OnFilterRecord:=DMImportReleve.TaReleve_FilterRecord_EnCours;
          end;
      end;
      DataSet.Filtered:=true;
      DataSet.close;
      DataSet.open;
      //TotauxRappBanc:=CalculTotauxRappBanc(Compte,C_CalculerTout,e.DatExoDebut,e.DatExoFin);
      DeFiltrageDataSet(DMrech.TaModelRech);
      if GrLocate(DMrech.TaModelRech,'Compte',[Compte]) then
        Libelle:=DMrech.TaModelRech.findField('Journal').AsString + ' : '+DMrech.TaModelRech.findField('Libelle_Model').AsString;
      ListeValeur.Add('9;; Compte : '+Compte+' - '+GereLibelle(Libelle) );
//      if typeRapprochement in [C_NonMarques,C_TousRapp] then//mouvement non marqu�s ou tous
//        ListeValeur.Add('4;; @Solde sur votre compta. (au '+DateToSTr(E.DatExoDebut)+') ;'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeReportDebit)+';'+E.FormatCurrSansDevise(TotauxRappBanc.SoldeReportCredit)+'');
          if not dataset.Active then dataset.Open;
          dataset.First;
          while not dataset.Eof do
            begin
              ListeValeur.Add('0'+
                               ';'+
                               dataset.FindField('DateOP').AsString+
                               ';'+
                               GereLibelle(dataset.FindField('Designation').AsString)+
                               ';'+
                               dataset.FindField('Debit').AsString+
                               ';'+
                               dataset.FindField('Credit').AsString+
                               ';'+
                               dataset.FindField('Marque').AsString +
                               ';'+
                               dataset.FindField('Rapprochement').AsString
                               );
      //        ListeValeur.Add('16');
              if(dataset.FindField('Marque').AsString='')then
                begin
                   TotDebitSaisie:=TotDebitSaisie+dataset.FindField('Debit').Ascurrency;
                   TotCreditSaisie:=TotCreditSaisie+dataset.FindField('Credit').Ascurrency;
                end
              else
                begin
                   TotDebitSaisieMarque:=TotDebitSaisieMarque+dataset.FindField('Debit').Ascurrency;
                   TotCreditSaisieMarque:=TotCreditSaisieMarque+dataset.FindField('Credit').Ascurrency;
                end;
              dataset.Next;
            end;
          ListeValeur.Add('16');

      case typeRapprochement of
        C_NonMarques:begin
               ListeValeur.Add('4;; @Mouvements non point�s au '+DateToSTr(DMImportReleve.DateFinReleve)+' :  ;'+E.FormatCurrSansDevise(TotDebitSaisie)+';'+E.FormatCurrSansDevise(TotCreditSaisie)+'');
               DetermineSolde(TotDebitSaisie,TotCreditSaisie);
               ListeValeur.Add('4;; @Solde des Mouvements non point�s au : '+DateToSTr(DMImportReleve.DateFinReleve)+' :  ;'+E.FormatCurrSansDevise(TotDebitSaisie)+';'+E.FormatCurrSansDevise(TotCreditSaisie)+'');
               ObjPrn.FSousTitreEdition:='Mouvements non point�s au '+DateToSTr(DMImportReleve.DateFinReleve);
          end;
        C_Marques:begin
               ListeValeur.Add('4;; @Mouvements point�s au : '+DateToSTr(DMImportReleve.DateFinReleve)+' : ;'+E.FormatCurrSansDevise(TotDebitSaisieMarque)+';'+E.FormatCurrSansDevise(TotCreditSaisieMarque)+'');
               DetermineSolde(TotDebitSaisieMarque,TotCreditSaisieMarque);
               ListeValeur.Add('4;; @Solde des Mouvements point�s au : '+DateToSTr(DMImportReleve.DateFinReleve)+' :  ;'+E.FormatCurrSansDevise(TotDebitSaisieMarque)+';'+E.FormatCurrSansDevise(TotCreditSaisieMarque)+'');
               ObjPrn.FSousTitreEdition:='Mouvements d�j� point�s au '+DateToSTr(DMImportReleve.DateFinReleve);
          end
      else
        begin
               ListeValeur.Add('4;; @Mouvements point�s au : '+DateToSTr(DMImportReleve.DateFinReleve)+' : ;'+E.FormatCurrSansDevise(TotDebitSaisieMarque)+';'+E.FormatCurrSansDevise(TotCreditSaisieMarque)+'');
               DetermineSolde(TotDebitSaisieMarque,TotCreditSaisieMarque);
               ListeValeur.Add('4;; @Solde des Mouvements point�s au : '+DateToSTr(DMImportReleve.DateFinReleve)+' :  ;'+E.FormatCurrSansDevise(TotDebitSaisieMarque)+';'+E.FormatCurrSansDevise(TotCreditSaisieMarque)+'');
               ListeValeur.Add('4;; @Mouvements non point�s au '+DateToSTr(DMImportReleve.DateFinReleve)+' :  ;'+E.FormatCurrSansDevise(TotDebitSaisie)+';'+E.FormatCurrSansDevise(TotCreditSaisie)+'');
               DetermineSolde(TotDebitSaisie,TotCreditSaisie);
               ListeValeur.Add('4;; @Solde des Mouvements non point�s au : '+DateToSTr(DMImportReleve.DateFinReleve)+' :  ;'+E.FormatCurrSansDevise(TotDebitSaisie)+';'+E.FormatCurrSansDevise(TotCreditSaisie)+'');
               ObjPrn.FSousTitreEdition:='Tous les Mouvements au '+DateToSTr(DMImportReleve.DateFinReleve);
        end;
      end;//fin du case typeAffichage

              dataset.Close;
              ObjPrn.FTitreEdition := ' Pointage des relev�s bancaires';
              //ObjPrn.FTitre2Edition :='P�riode du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
              ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
              ListeValeur.Insert(0,' Date ; Libell� ; D�caissement ; Encaissement ; Pointage ; Rapprochement ');
              ListeValeur.Insert(1,'0.8;2.5;1.1;1.1;0.8;0.8');
              ListeValeur.Insert(2,'texte;texte;curr;curr;texte;texte');
             ObjPrn.AffichageImp(ListeValeur);
finally
 LibereObjet(tobject(ObjPrn));
//if ObjPrn <> nil then
// begin
//  ObjPrn.Free;
//  ObjPrn := nil;
// end;
end;
End;

Function CalculTotauxRappBanc(CompteBanque:String;TypeCalcul:Integer;DateDeb,DateFin:Tdate):TTotauxRappBanc;
var
  SoldeDebit,SoldeCredit:Currency;
  TotauxCompte_:TTotauxCompte;
  TotauxReport_:TTotauxBalance;
Debut,Fin:TTime;
Begin
      Debut:=Time;
  if DMRappBanc=nil then DMRappBanc:=TDMRappBanc.Create(Application.MainForm);
  if DMDiocEtatBal = nil then DMDiocEtatBal:=TDMDiocEtatBal.Create(Application.MainForm);
  Initialise_TotauxRappBanc(Result);
  InitialiseTotauxBalance(TotauxReport_);
  Initialise_TotauxCompte(TotauxCompte_);
  case TypeCalcul of
      C_CalculerTout:Begin
                       TotauxReport_:=DMDiocEtatBal.SommeTotauxBalanceParCompte(DateDeb,DateFin,CompteBanque);
                       TotauxCompte_:=DMRappBanc.SommeRappNonMarqueAvantDate(CompteBanque,DateDeb-1);

                       // Si le solde de la balance report debut est d�biteur
                       // alors on ajoute a ce solde le solde cr�diteur des mvt non marqu� avant date
                       // et on soustrait � ce solde le solde d�biteur des mvt !
                       if TotauxReport_.SoldeDebitCreditReport then
                        begin
                         SoldeDebit:=TotauxReport_.TotalSoldeDebitReport + TotauxCompte_.SoldeCredit - TotauxCompte_.SoldeDebit;
                         SoldeCredit :=0;
                         if SoldeDebit < 0 then
                          begin
                           SoldeCredit := - SoldeDebit;
                           SoldeDebit := 0;
                          end;
                        end
                       else
                       // Si le solde de la balance report d�but est Cr�diteur
                       // alors on soustrait � ce solde le solde cr�diteur des mvt non marqu� avant date
                       // et on ajoute � ce solde le solde d�biteur des mvt !
                        begin
                         SoldeDebit := 0;
                         SoldeCredit:=TotauxReport_.TotalSoldeCreditReport - TotauxCompte_.SoldeCredit + TotauxCompte_.SoldeDebit;
                         if SoldeCredit < 0 then
                          Begin
                           SoldeDebit := - SoldeCredit;
                           SoldeCredit := 0;
                          End;

                        end;

                        result.SoldeReportDebit:=TotauxReport_.TotalDebitReport;
                        result.SoldeReportCredit:=TotauxReport_.TotalCreditReport;
                        DetermineSolde(result.SoldeReportDebit,result.SoldeReportCredit);

                        result.SoldeReportReleveBanqueDebit := SoldeDebit;
                        result.SoldeReportReleveBanqueCredit := SoldeCredit;

                        result.TotalMvtCompteDebit := TotauxReport_.TotalDebitFin;
                        result.TotalMvtCompteCredit := TotauxReport_.TotalCreditFin;

                        result.SoldeCompteDebit := TotauxReport_.TotalSoldeDebitTotal;
                        result.SoldeCompteCredit := TotauxReport_.TotalSoldeCreditTotal;

                     End;
      C_CalculerReportReleveBanque:;
      C_CalculerTotalMvtCompte:;
      C_CalculerSoldeCompte:;
      C_CalculerTotalMvtCompteNonMarque:;
      C_CalculerSoldeReleveBanque:begin
                                   TotauxReport_:=DMDiocEtatBal.SommeTotauxBalanceParCompte(DateDeb,DateFin,CompteBanque);
                                   TotauxCompte_:=DMRappBanc.SommeRappNonMarqueAvantDate(CompteBanque,DateFin);

                                    result.SoldeReportDebit:=TotauxReport_.TotalDebitReport;
                                    result.SoldeReportCredit:=TotauxReport_.TotalCreditReport;
                                    DetermineSolde(result.SoldeReportDebit,result.SoldeReportCredit);

                                   Result.TotalMvtCompteNonMarqueDebit:=TotauxCompte_.TotalDebit;
                                   Result.TotalMvtCompteNonMarqueCredit:=TotauxCompte_.TotalCredit;
                                   if TotauxReport_.SoldeDebitCreditFin then
                                    begin
                                     Result.SoldeReleveBanqueDebit:=TotauxReport_.TotalSoldeDebitTotal + TotauxCompte_.TotalCredit - TotauxCompte_.TotalDebit;
                                     Result.SoldeReleveBanqueCredit:=0;
                                     if Result.SoldeReleveBanqueDebit < 0 then
                                      begin
                                        Result.SoldeReleveBanqueCredit:= -Result.SoldeReleveBanqueDebit;
                                        Result.SoldeReleveBanqueDebit :=0;
                                      end;
                                    end
                                   else
                                    begin
                                     Result.SoldeReleveBanqueCredit:=TotauxReport_.TotalSoldeCreditTotal - TotauxCompte_.TotalCredit + TotauxCompte_.TotalDebit;
                                     Result.SoldeReleveBanqueDebit:=0;
                                     if Result.SoldeReleveBanqueCredit < 0 then
                                      begin
                                        Result.SoldeReleveBanqueDebit:= -Result.SoldeReleveBanqueCredit;
                                        Result.SoldeReleveBanqueCredit :=0;
                                      end;
                                    end;

                                  end;
  else MessageDlg('CalculTotauxRappBanc:TypeCalcul inconnu',  Dialogs.mtWarning, [Dialogs.mbOK], 0);;
  end;

     Fin:=Time;

End;


procedure TDMImportReleve.CreationReglement(DBGridReleve: TGrDBGrid;marquageAuto:boolean;afficheChoix:boolean);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
tab:variant;
ValPieceAutoGen:TValPieceAutoGenere;
compteTvaTemp:string;
i:integer;
sensContrepartie:integer;
cpt,tiers,libelleEcriture:string;
requete:TQuery;
id_piece:integer;
compteAppelant:Tstringlist;
DateAPrendre:Tdatetime;
typeTvaE,SupprOD:boolean;
mess:TMessageLGR;
ReferenceTmp,LibelleTmp,CompteReglement:string;
MarqueAuto,Filtre:string;
LibelleExistant:boolean;
Begin
sensContrepartie:=0;
typeTvaE:=false;
SupprOD:=false;
MarqueAuto:='';
requete:=TQuery.Create(application.MainForm);
 compteAppelant:=tstringlist.Create;
 compteAppelant.Duplicates:=dupIgnore;
   try
     try
     //filtrage table sur ligne rempli cptTiers
     TaReleveReglement.OnFilterRecord:=TaReleveReglement_FilterRecord_CptRempli;
     TaReleveReglement.DisableControls;
     //FiltrageDataSet(TaReleveReglement,'cptTiers<>'''' and cptTiers is not null');

     TaReleveReglement.First;
     if(TaReleveReglement.RecordCount<>0)then
        begin
                      initialisePiece(SourcePiece,listeFactice);
        end
        else begin
                Application.MessageBox(Pchar('Aucune ligne n''est affect�e.'),'Attention',MB_ICONWARNING);
                DMImport.messageTmp:=false;
                abort;
             end;
     while(not TaReleveReglement.eof) do
       begin
             cpt:='';
             tiers:='';
             libelleEcriture:='';
           if(str_commence_par(TaReleveReglement.FindField('cptTiers').Asstring,'+'))then
             begin
                tiers:=TaReleveReglement.FindField('cptTiers').Asstring;
                cpt:=DMTiers.CptDuTiers(tiers);
                compteAppelant.Add(tiers);
             end
           else
              begin
                cpt:=TaReleveReglement.FindField('cptTiers').Asstring;
                compteAppelant.Add(cpt);
              end;
              libelleEcriture:=TaReleveReglement.FindField('designation').AsString;
              if(TaReleveReglement.FindField('supplement').AsString<>'')then
                libelleEcriture:=libelleEcriture+'-'+TaReleveReglement.FindField('supplement').AsString;
           if(TaReleveReglement.FindField('debit').AsCurrency<>0) then
              begin
              SourcePiece.TotalPiece:=SourcePiece.TotalPiece+TaReleveReglement.FindField('debit').AsCurrency-TaReleveReglement.FindField('credit').AsCurrency;
              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',cpt,tiers,libelleEcriture,0,0,
              TaReleveReglement.FindField('debit').AsCurrency,0,'','',0,'',''],true,false,-1);
              end
            else
              Begin
              SourcePiece.TotalPiece:=SourcePiece.TotalPiece+TaReleveReglement.FindField('debit').AsCurrency-TaReleveReglement.FindField('credit').AsCurrency;
              DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',cpt,tiers,libelleEcriture,0,0,
               -TaReleveReglement.FindField('credit').AsCurrency,0,'','',0,'',''],true,false,-1);
              End;
          TaReleveReglement.Next;
       end;
// appelle fenetre piece
           ListeOd:=TStringList.Create;
creationPieceReglement(SourcePiece, marquageAuto,ValPieceAutoGen,listeFactice,compteAppelant,ListeOd,afficheChoix);
creationMarquageReleve(ListeOd,marquageAuto,false);
//   if DateDsIntervale(e.DatExoDebut,SourcePiece.Date,e.DatExoFin,mess) then
//     DateAPrendre:=SourcePiece.Date
//   else
//     Begin
//       if SourcePiece.Date<e.DatExoDebut then
//         DateAPrendre:=e.DatExoDebut
//       else
//         DateAPrendre:=e.DatExoFin;
//     End;
//   CompteReglement:=SourcePiece.Compte;
//   ReferenceTmp:=SourcePiece.Reference;
//   LibelleTmp:=SourcePiece.Libelle;
//   if(ChoixReglementAuto=nil)then ChoixReglementAuto:=TChoixReglementAuto.create(application.MainForm);
//   ChoixReglementAuto.EdCompteReglement.ReadOnly:=true;
//   ChoixReglementAuto.BtnTiersNonDetailleEnter(nil);
//   ChoixReglementAuto.PaChoix.Visible:=false;
//   ChoixReglementAuto.PaAide.Visible:=false;
//   ChoixReglementAuto.Panel7.Visible:=false;
//   if(ChoixReglementAffiche(compteAppelant,DateAPrendre,CompteReglement,ReferenceTmp,LibelleTmp,SourcePiece.TotalPiece,typeTvaE,SupprOD)<>0)then
//        begin
//
//           sourcePiece.Date:=DateAPrendre;
//           sourcePiece.Libelle:=LibelleTmp;
//           if(SourcePiece.TotalPiece<0)then sensContrepartie:=1
//           else  sensContrepartie:=-1;
//           SourcePiece.TotalPiece:=abs(SourcePiece.TotalPiece);
//           DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,
//           ValPieceAutoGen,'','',0);
//              case sensContrepartie of
//                 -1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[0])^.Ligne.Debit:=SourcePiece.TotalPiece;
//                  0:abort;
//                  1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[0])^.Ligne.Credit:=SourcePiece.TotalPiece;
//               end;//fin du case sens
//           ListeOd:=TStringList.Create;
//           DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
//
//           //remonter la pi�ce cr��e pour r�cup�rer les id_ecriture et les mettre dans
//           //la table taReleve sur les lignes correspondantes qui ont servis � cr�er la pi�ce
//           if(listeOd.count<>0)then
//             begin
//
//                 id_piece:=-1;
//                 requete.close;
//                 requete:=TQuery.Create(application.MainForm);
//                 requete.DatabaseName:=DM_C_NomAliasDossier;
//                 requete.SQL.Clear;
//                 requete.SQL.Add('select id from piece where reference like '''+listeod.strings[0]+'''');
//                 requete.open;
//                 if(requete.RecordCount<>0)then id_piece:= requete.findfield('id').asinteger;
//                 if(id_piece<>-1)then TaReleveReglement.First;
//                 TableGereStartTransaction(TaReleveReglement);
//
//                 MarqueAuto:=DMImportReleve.MaxMarque(MarqueCourante);
//                 while(not TaReleveReglement.eof) do
//                 begin
////                    requete.Close;
////                    requete.free;
////                    requete:=TQuery.Create(application.MainForm);
////                    requete.SQL.Clear;
////                     requete.DatabaseName:=DM_C_NomAliasDossier;
//
//                    LibelleExistant:=false;
//                    libelleEcriture:=TaReleveReglement.FindField('designation').AsString;
//                    //requete.SQL.Add('select id,libelle,(debitsaisie+creditsaisie)as ht from ecriture where id_piece=:id_piece ');
//                    Filtre:='id_piece='+requete.findfield('id').AsString;
//
////                    if(libelleEcriture<>'')then
////                    begin
////                        filtre:=filtre+' and upper(libelle)='''+libelleEcriture+''' and creditsaisie='+;
////
////
////                        requete.SQL.Add(' and upper(libelle) like :libelle ');
////                        LibelleExistant:=true;
////                    end;
//
//                    if(TaReleveReglement.findfield('debit').AsCurrency<>0)then
//                      begin
//                        filtre:=filtre+' and creditsaisie='+TaReleveReglement.findfield('debit').AsString;
////                        requete.SQL.Add(' and (creditsaisie)=:montant');
////                        requete.ParamByName('montant').AsCurrency:=TaReleveReglement.findfield('debit').AsCurrency;
//                      end
//                    else
//                      begin
//                        filtre:=filtre+' and debitsaisie='+TaReleveReglement.findfield('credit').AsString;
////                        requete.SQL.Add(' and (debitsaisie)=:montant');
////                        requete.ParamByName('montant').AsCurrency:=TaReleveReglement.findfield('credit').AsCurrency;
//                      end;
//
//                    //requete.SQL.Add(' and ecriture."date"=:dateOp');
//
//                   // requete.ParamByName('id_piece').AsInteger:=id_piece;
//                    if(libelleEcriture<>'')then
//                    begin
//                        if(TaReleveReglement.FindField('supplement').AsString<>'')then
//                           libelleEcriture:=libelleEcriture+'-'+TaReleveReglement.FindField('supplement').AsString;
//                        filtre:=filtre+' and libelle='''+libelleEcriture+'''';
//                    end;
//                    //requete.ParamByName('libelle').AsString:=str_souschaine(libelleEcriture,1,100);
//                   // requete.ParamByName('dateOp').AsDate:=TaReleveReglement.findfield('dateOp').AsDateTime;
////                    showmessage('id pi�ce'+ requete.ParamByName('id_piece').AsString);
////                    showmessage('libelle'+ requete.ParamByName('libelle').AsString);
////                    showmessage('montant'+ requete.ParamByName('montant').AsString);
//                    FiltrageDataSet(DMRech.TaEcritureRech,filtre);
//                    DMRech.TaEcritureRech.First;
//                    //requete.open;
//
//                    //requete.first;
//                   // while(not requete.eof)do
//                    if(DMRech.TaEcritureRech.RecordCount<>0)then
//                      begin
//                         TableGereStartTransaction(TaReleveReglement);
//                         TableGereEdit(TaReleveReglement);
//                         TaReleveReglement.FindField('id_ecriture').AsInteger:=DMRech.TaEcritureRech.findfield('id').AsInteger;
//                         if(marquageAuto)and(MarqueCourante<>'')then
//                           begin
//                             TaReleveReglement.FindField('marque').AsString:=MarqueAuto;
//                             TaReleveReglement.FindField('Rapprochement').AsString:=MarqueCourante;
//                           end;
//                         TableGerePost(TaReleveReglement);
//                         TableGereCommit(TaReleveReglement); 
//                      end;
//                    TaReleveReglement.first;
//                 end;
//
//                    if(marquageAuto)and(MarqueCourante<>'')then
//                      begin
//                          requete.Close;
//                          requete.SQL.Clear;
//                          requete.SQL.Add('select id from ecriture where id_piece=:id_piece and upper(typeligne)=''X''');
//                          requete.ParamByName('id_piece').AsInteger:=id_piece;
//                          requete.open;
//
//                          if(requete.RecordCount>0)then
//                          begin
//                             MarquageEcriture('marqueReleve',MarqueAuto,requete.findfield('id').AsInteger);
//                             MarquageEcriture('Rapprochement',MarqueCourante,requete.findfield('id').AsInteger);
//                          end;
//                      end;
//             end;
//          TableGereCommit(TaReleveReglement);
//          end;
     except
       TableGereRollBack(TaReleveReglement);
       //TableGereClose(TaReleveReglement);
       if DMImport.messageTmp then
         showmessage('Probl�me lors de l''enregistrement d''une pi�ce');
       abort;
     end;//fin du try except
   finally

    TaReleveReglement.OnFilterRecord:=nil;
    TaReleveReglement.EnableControls;
    DeFiltrageDataSet(TaReleveReglement);

    TableGereClose(TaReleveReglement);
    tablegereOpen(TaReleveReglement);

    DeFiltrageDataSet(DMRech.TaEcritureRech);
    ChoixReglementAuto.free;
     requete.SQL.clear;
      requete.Close;
      requete.Free;
      Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMImportReleve,false);
   end;//fin du try finally
End;

procedure TDMImportReleve.initialisePiece(var SourcePiece:TRecordPiece; var listeFactice:Tlist);
var
ValPieceAutoGen:TValPieceAutoGenere;
begin
          listeFactice:=nil;
           DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
           ValPieceAutoGen:=ValAutoPieceGenere(DMImportReleve.TaReleve);
           SourcePiece.TotalPiece:=0;
           SourcePiece.IDJournal:=4;
           SourcePiece.Date:=TaReleveReglement.FindField('dateOp').AsDateTime;
           SourcePiece.Validation:=SourcePiece.Date;
           SourcePiece.Compte:=TaReleveReglement.FindField('compte').AsString;
           //r�cup�rer le journal de banque � partir du compte
           SourcePiece.Journal:=Infos_TInfosModel(dmrech.TaModelRech,'compte',
             [TaReleveReglement.FindField('compte').AsString]).Journal;


           SourcePiece.Reference:='';
           if(TaReleveReglement.RecordCount>1)then
             SourcePiece.Libelle:=DMJournal.LibelleDuJournal(SourcePiece.Journal)
           else
             SourcePiece.Libelle:=TaReleveReglement.FindField('designation').AsString+'-'+
             TaReleveReglement.FindField('supplement').AsString;
           DMImport.VerifCreationPieceEcriture;
           DMImport.Piece_Import.NouvellePiece(false);

           if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
           DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
           DMImport.Ecriture_Import.ListeEcriturePiece.Clear;

           //remplissage ligne vide
           DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,
             ['X',SourcePiece.Compte,'',SourcePiece.Libelle,0,0,0,0,'','',0,'',''],true,false,-1);

end;


procedure TDMImportReleve.creationMarquageReleve(listeOd :TStringList ;marquageAuto,uneLigneParPiece:boolean );
var
requete:TQuery;
id_piece:integer;
MarqueAuto,Filtre:string;
LibelleExistant:boolean;
libelleEcriture:string;
begin
 try //finally
   requete:=TQuery.Create(self);
           //remonter la pi�ce cr��e pour r�cup�rer les id_ecriture et les mettre dans
           //la table taReleve sur les lignes correspondantes qui ont servis � cr�er la pi�ce
           while(listeOd.count<>0)do
             begin

                 id_piece:=-1;

                 requete.close;
                 requete:=TQuery.Create(application.MainForm);
                 requete.DatabaseName:=DM_C_NomAliasDossier;
                 requete.SQL.Clear;
                 requete.SQL.Add('select id from piece where reference like '''+listeod.strings[0]+'''');
                 requete.open;
                 if(requete.RecordCount<>0)then id_piece:= requete.findfield('id').asinteger;
                 if(id_piece<>-1)then TaReleveReglement.First;
                 TableGereStartTransaction(TaReleveReglement);

                 MarqueAuto:=DMImportReleve.MaxMarque(MarqueCourante);
                 while(not TaReleveReglement.eof) do
                 begin
                    LibelleExistant:=false;
                    libelleEcriture:=TaReleveReglement.FindField('designation').AsString;
                    Filtre:='id_piece='+requete.findfield('id').AsString;

                    if(TaReleveReglement.findfield('debit').AsCurrency<>0)then
                      begin
                        filtre:=filtre+' and creditsaisie='+TaReleveReglement.findfield('debit').AsString;
                      end
                    else
                      begin
                        filtre:=filtre+' and debitsaisie='+TaReleveReglement.findfield('credit').AsString;
                      end;

                    if(libelleEcriture<>'')then
                    begin
                        if(TaReleveReglement.FindField('supplement').AsString<>'')then
                           libelleEcriture:=libelleEcriture+'-'+TaReleveReglement.FindField('supplement').AsString;
                        filtre:=filtre+' and libelle='''+libelleEcriture+'''';
                    end;

                    FiltrageDataSet(DMRech.TaEcritureRech,filtre);
                    DMRech.TaEcritureRech.First;

                    if(DMRech.TaEcritureRech.RecordCount<>0)then
                      begin
                         TableGereStartTransaction(TaReleveReglement);
                         TableGereEdit(TaReleveReglement);
                         TaReleveReglement.FindField('id_ecriture').AsInteger:=DMRech.TaEcritureRech.findfield('id').AsInteger;
                         if(marquageAuto)and(MarqueCourante<>'')then
                           begin
                             TaReleveReglement.FindField('marque').AsString:=MarqueAuto;
                             TaReleveReglement.FindField('Rapprochement').AsString:=MarqueCourante;
                           end;
                         TableGerePost(TaReleveReglement);
                         TableGereCommit(TaReleveReglement);
                      end;
                   if(uneLigneParPiece)then TaReleveReglement.Last
                   else  TaReleveReglement.first;
                 end;

                    if(marquageAuto)and(MarqueCourante<>'')then
                      begin
                          requete.Close;
                          requete.SQL.Clear;
                          requete.SQL.Add('select id from ecriture where id_piece=:id_piece and upper(typeligne)=''X''');
                          requete.ParamByName('id_piece').AsInteger:=id_piece;
                          requete.open;

                          if(requete.RecordCount>0)then
                          begin
                             MarquageEcriture('marqueReleve',MarqueAuto,requete.findfield('id').AsInteger);
                             MarquageEcriture('Rapprochement',MarqueCourante,requete.findfield('id').AsInteger);
                          end;
                      end;
                      listeOd.Delete(0);
             end;
finally
  TableGereCommit(TaReleveReglement);
  requete.Close;
  requete:=nil;
end;//fin finally
end;


procedure TDMImportReleve.creationPieceReglement(var SourcePiece:TRecordPiece; marquageAuto:boolean ;var ValPieceAutoGen:TValPieceAutoGenere; var listeFactice:Tlist ;var compteAppelant:Tstringlist ; var ListeOd:Tstringlist; afficheChoix : boolean);
var
//ListeOd:TStringList;
//SourcePiece:TRecordPiece;
//listeFactice:Tlist;
tab:variant;
//ValPieceAutoGen:TValPieceAutoGenere;
//compteTvaTemp:string;
//i:integer;
sensContrepartie:integer;
cpt,tiers,libelleEcriture:string;
//requete:TQuery;
id_piece:integer;
//compteAppelant:Tstringlist;
DateAPrendre:Tdatetime;
typeTvaE,SupprOD:boolean;
mess:TMessageLGR;
ReferenceTmp,LibelleTmp,CompteReglement:string;
//MarqueAuto,Filtre:string;
retourAffiche:boolean;
Begin
 try //finally

   if DateDsIntervale(e.DatExoDebut,SourcePiece.Date,e.DatExoFin,mess) then
     DateAPrendre:=SourcePiece.Date
   else
     Begin
       if SourcePiece.Date<e.DatExoDebut then
         DateAPrendre:=e.DatExoDebut
       else
         DateAPrendre:=e.DatExoFin;
     End;
   CompteReglement:=SourcePiece.Compte;
   ReferenceTmp:=SourcePiece.Reference;
   LibelleTmp:=SourcePiece.Libelle;
   if(ChoixReglementAuto=nil)then ChoixReglementAuto:=TChoixReglementAuto.create(application.MainForm);
   ChoixReglementAuto.EdCompteReglement.ReadOnly:=true;
   ChoixReglementAuto.BtnTiersNonDetailleEnter(nil);
   ChoixReglementAuto.PaChoix.Visible:=false;
   ChoixReglementAuto.PaAide.Visible:=false;
   ChoixReglementAuto.Panel7.Visible:=false;
   retourAffiche:=true;
   if((afficheChoix) and (ChoixReglementAffiche(compteAppelant,DateAPrendre,CompteReglement,ReferenceTmp,LibelleTmp,SourcePiece.TotalPiece,typeTvaE,SupprOD)<>0))then
        begin
        retourAffiche:=true;
        end;
   if(retourAffiche)then
   begin
           sourcePiece.Date:=DateAPrendre;
           sourcePiece.Libelle:=LibelleTmp;
           if(SourcePiece.TotalPiece<0)then sensContrepartie:=1
           else  sensContrepartie:=-1;
           SourcePiece.TotalPiece:=abs(SourcePiece.TotalPiece);
           DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,
           ValPieceAutoGen,'','',0);
              case sensContrepartie of
                 -1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[0])^.Ligne.Debit:=SourcePiece.TotalPiece;
                  0:abort;
                  1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[0])^.Ligne.Credit:=SourcePiece.TotalPiece;
               end;//fin du case sens

           DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);


          //TableGereCommit(TaReleveReglement);
          end;
finally

end;//fin finally
end;

procedure TDMImportReleve.CreationReglementUneLigne(DBGridReleve: TGrDBGrid;marquageAuto:boolean;afficheChoix:boolean);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
tab:variant;
ValPieceAutoGen:TValPieceAutoGenere;
compteTvaTemp:string;
filtreCourant:TFilterRecordEvent;
i:integer;
sensContrepartie:integer;
cpt,tiers,libelleEcriture:string;
requete:TQuery;
id_piece:integer;
compteAppelant:Tstringlist;
DateAPrendre:Tdatetime;
typeTvaE,SupprOD:boolean;
mess:TMessageLGR;
ReferenceTmp,LibelleTmp,CompteReglement:string;
MarqueAuto,Filtre:string;
LibelleExistant:boolean;
Begin
sensContrepartie:=0;
typeTvaE:=false;
SupprOD:=false;
MarqueAuto:='';
requete:=TQuery.Create(application.MainForm);
 compteAppelant:=tstringlist.Create;
 compteAppelant.Duplicates:=dupIgnore;
   try
                           ListeOd:=TStringList.Create;
     try
     //filtrage table sur ligne rempli cptTiers
     filtreCourant:=TaReleveReglement.OnFilterRecord;
     TaReleveReglement.OnFilterRecord:=TaReleveReglement_FilterRecord_CptRempli;
     TaReleveReglement.DisableControls;
     //FiltrageDataSet(TaReleveReglement,'cptTiers<>'''' and cptTiers is not null');

     TaReleveReglement.First;
     if(TaReleveReglement.RecordCount<>0)then
        begin
           while(not TaReleveReglement.eof) do
             begin //while not TaReleveReglement.eof
            Initialise_TRecordPiece(SourcePiece);
           initialisePiece(SourcePiece,listeFactice);
                  cpt:='';
                   tiers:='';
                   libelleEcriture:='';
                 if(str_commence_par(TaReleveReglement.FindField('cptTiers').Asstring,'+'))then
                   begin
                      tiers:=TaReleveReglement.FindField('cptTiers').Asstring;
                      cpt:=DMTiers.CptDuTiers(tiers);
                      compteAppelant.Add(tiers);
                   end
                 else
                    begin
                      cpt:=TaReleveReglement.FindField('cptTiers').Asstring;
                      compteAppelant.Add(cpt);
                    end;
                    libelleEcriture:=TaReleveReglement.FindField('designation').AsString;
                    if(TaReleveReglement.FindField('supplement').AsString<>'')then
                      libelleEcriture:=libelleEcriture+'-'+TaReleveReglement.FindField('supplement').AsString;
                 if(TaReleveReglement.FindField('debit').AsCurrency<>0) then
                    begin
                    SourcePiece.TotalPiece:=SourcePiece.TotalPiece+TaReleveReglement.FindField('debit').AsCurrency-TaReleveReglement.FindField('credit').AsCurrency;
                    DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',cpt,tiers,libelleEcriture,0,0,
                    TaReleveReglement.FindField('debit').AsCurrency,0,'','',0,'',''],true,false,-1);
                    end
                  else
                    Begin
                    SourcePiece.TotalPiece:=SourcePiece.TotalPiece+TaReleveReglement.FindField('debit').AsCurrency-TaReleveReglement.FindField('credit').AsCurrency;
                    DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',cpt,tiers,libelleEcriture,0,0,
                     -TaReleveReglement.FindField('credit').AsCurrency,0,'','',0,'',''],true,false,-1);
                    End;
                    SourcePiece.Libelle:=libelleEcriture;
                    creationPieceReglement(SourcePiece, marquageAuto,ValPieceAutoGen,listeFactice,compteAppelant,ListeOd,afficheChoix);
                TaReleveReglement.next;
             end;//fin while not TaReleveReglement.eof

creationMarquageReleve(ListeOd,marquageAuto,true);
        end
        else begin
                Application.MessageBox(Pchar('Aucune ligne n''est affect�e.'),'Attention',MB_ICONWARNING);
                DMImport.messageTmp:=false;
                abort;
             end;

// appelle fenetre piece


//   if DateDsIntervale(e.DatExoDebut,SourcePiece.Date,e.DatExoFin,mess) then
//     DateAPrendre:=SourcePiece.Date
//   else
//     Begin
//       if SourcePiece.Date<e.DatExoDebut then
//         DateAPrendre:=e.DatExoDebut
//       else
//         DateAPrendre:=e.DatExoFin;
//     End;
//   CompteReglement:=SourcePiece.Compte;
//   ReferenceTmp:=SourcePiece.Reference;
//   LibelleTmp:=SourcePiece.Libelle;
//   if(ChoixReglementAuto=nil)then ChoixReglementAuto:=TChoixReglementAuto.create(application.MainForm);
//   ChoixReglementAuto.EdCompteReglement.ReadOnly:=true;
//   ChoixReglementAuto.BtnTiersNonDetailleEnter(nil);
//   ChoixReglementAuto.PaChoix.Visible:=false;
//   ChoixReglementAuto.PaAide.Visible:=false;
//   ChoixReglementAuto.Panel7.Visible:=false;
//   if(ChoixReglementAffiche(compteAppelant,DateAPrendre,CompteReglement,ReferenceTmp,LibelleTmp,SourcePiece.TotalPiece,typeTvaE,SupprOD)<>0)then
//        begin
//
//           sourcePiece.Date:=DateAPrendre;
//           sourcePiece.Libelle:=LibelleTmp;
//           if(SourcePiece.TotalPiece<0)then sensContrepartie:=1
//           else  sensContrepartie:=-1;
//           SourcePiece.TotalPiece:=abs(SourcePiece.TotalPiece);
//           DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,
//           ValPieceAutoGen,'','',0);
//              case sensContrepartie of
//                 -1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[0])^.Ligne.Debit:=SourcePiece.TotalPiece;
//                  0:abort;
//                  1:PIdentifiant_obj(DMImport.Ecriture_Import.ListIdentifiant.Items[0])^.Ligne.Credit:=SourcePiece.TotalPiece;
//               end;//fin du case sens
//           ListeOd:=TStringList.Create;
//           DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
//
//           //remonter la pi�ce cr��e pour r�cup�rer les id_ecriture et les mettre dans
//           //la table taReleve sur les lignes correspondantes qui ont servis � cr�er la pi�ce
//           if(listeOd.count<>0)then
//             begin
//
//                 id_piece:=-1;
//                 requete.close;
//                 requete:=TQuery.Create(application.MainForm);
//                 requete.DatabaseName:=DM_C_NomAliasDossier;
//                 requete.SQL.Clear;
//                 requete.SQL.Add('select id from piece where reference like '''+listeod.strings[0]+'''');
//                 requete.open;
//                 if(requete.RecordCount<>0)then id_piece:= requete.findfield('id').asinteger;
//                 if(id_piece<>-1)then TaReleveReglement.First;
//                 TableGereStartTransaction(TaReleveReglement);
//
//                 MarqueAuto:=DMImportReleve.MaxMarque(MarqueCourante);
//                 while(not TaReleveReglement.eof) do
//                 begin
//                    LibelleExistant:=false;
//                    libelleEcriture:=TaReleveReglement.FindField('designation').AsString;
//                    Filtre:='id_piece='+requete.findfield('id').AsString;
//
//                    if(TaReleveReglement.findfield('debit').AsCurrency<>0)then
//                      begin
//                        filtre:=filtre+' and creditsaisie='+TaReleveReglement.findfield('debit').AsString;
//                      end
//                    else
//                      begin
//                        filtre:=filtre+' and debitsaisie='+TaReleveReglement.findfield('credit').AsString;
//                      end;
//
//                    if(libelleEcriture<>'')then
//                    begin
//                        if(TaReleveReglement.FindField('supplement').AsString<>'')then
//                           libelleEcriture:=libelleEcriture+'-'+TaReleveReglement.FindField('supplement').AsString;
//                        filtre:=filtre+' and libelle='''+libelleEcriture+'''';
//                    end;
//
//                    FiltrageDataSet(DMRech.TaEcritureRech,filtre);
//                    DMRech.TaEcritureRech.First;
//
//                    if(DMRech.TaEcritureRech.RecordCount<>0)then
//                      begin
//                         TableGereStartTransaction(TaReleveReglement);
//                         TableGereEdit(TaReleveReglement);
//                         TaReleveReglement.FindField('id_ecriture').AsInteger:=DMRech.TaEcritureRech.findfield('id').AsInteger;
//                         if(marquageAuto)and(MarqueCourante<>'')then
//                           begin
//                             TaReleveReglement.FindField('marque').AsString:=MarqueAuto;
//                             TaReleveReglement.FindField('Rapprochement').AsString:=MarqueCourante;
//                           end;
//                         TableGerePost(TaReleveReglement);
//                         TableGereCommit(TaReleveReglement);
//                      end;
//                    TaReleveReglement.first;
//                 end;
//
//                    if(marquageAuto)and(MarqueCourante<>'')then
//                      begin
//                          requete.Close;
//                          requete.SQL.Clear;
//                          requete.SQL.Add('select id from ecriture where id_piece=:id_piece and upper(typeligne)=''X''');
//                          requete.ParamByName('id_piece').AsInteger:=id_piece;
//                          requete.open;
//
//                          if(requete.RecordCount>0)then
//                          begin
//                             MarquageEcriture('marqueReleve',MarqueAuto,requete.findfield('id').AsInteger);
//                             MarquageEcriture('Rapprochement',MarqueCourante,requete.findfield('id').AsInteger);
//                          end;
//                      end;
//             end;
//          TableGereCommit(TaReleveReglement);
//          end;
     except
       TableGereRollBack(TaReleveReglement);
       if DMImport.messageTmp then
         showmessage('Probl�me lors de l''enregistrement d''une pi�ce');
       abort;
     end;//fin du try except
   finally

    TaReleveReglement.OnFilterRecord:=filtreCourant;
    TaReleveReglement.EnableControls;
//    FiltrageDataSet(TaReleveReglement);

    TableGereClose(TaReleveReglement);
    tablegereOpen(TaReleveReglement);

    DeFiltrageDataSet(DMRech.TaEcritureRech);
    ChoixReglementAuto.free;
     requete.SQL.clear;
      requete.Close;
      requete.Free;
      Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMImportReleve,false);
   end;//fin du try finally
End;


procedure TDMImportReleve.TaReleveReglementAfterPost(DataSet: TDataSet);
begin
if(not empty(DataSet.findfield('cptTiers').asstring))then
  tiersCourant:=DataSet.findfield('cptTiers').asstring;
end;

procedure TDMImportReleve.TaReleveReglement_FilterRecord_CptRempli(DataSet: TDataSet;
  var Accept: Boolean);
Begin
if not((csDestroying)in dataset.ComponentState) then
begin
Accept:=(DAtaSet.findField('abandon').AsBoolean = false)and(DAtaSet.findField('cptTiers').AsString <> '')and
 (DAtaSet.findField('id_ecriture').AsString = '') and
  (DAtaSet.findField('marque').AsString = '')and (DAtaSet.findField('Rapprochement').AsString = '');
if accept then
  accept:=DAtaSet.findField('DateOP').asdatetime<=DMImportReleve.DateFinReleve;
end;

End;

procedure TDMImportReleve.TaReleveReglement_FilterRecord_EnCours(DataSet: TDataSet;
  var Accept: Boolean);
Begin
if not((csDestroying)in dataset.ComponentState) then
begin
Accept:=(DAtaSet.findField('abandon').AsBoolean = false)and (DAtaSet.findField('id_ecriture').AsString='')
  and(DAtaSet.findField('marque').AsString = '')and (DAtaSet.findField('Rapprochement').AsString = '');
if accept then
  accept:=DAtaSet.findField('DateOP').asdatetime<=DMImportReleve.DateFinReleve;
end;

End;

procedure TDMImportReleve.TaReleveReglement_FilterRecord_AnnuleAffectation(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
Accept:=(DAtaSet.findField('cptTiers').AsString<>'')and(DAtaSet.findField('id_ecriture').AsString='');
if accept then
  accept:=DAtaSet.findField('DateOP').asdatetime<=DMImportReleve.DateFinReleve;
end;
end;


procedure TDMImportReleve.TaReleveReglement_FilterRecord_Abandonne(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
begin
  Accept:=(DAtaSet.findField('abandon').AsBoolean=true);
  if accept then
    accept:=DAtaSet.findField('DateOP').asdatetime<=DMImportReleve.DateFinReleve
end;
end;


function GestionSuppressionRelationReleveBancaire(id_ecriture:integer):boolean;
var
requete:TQuery;
begin
  try//finally
    try//except
        result:=true;
        if(DMImportReleve=nil)then DMImportReleve:=TDMImportReleve.Create(application.MainForm);
        requete:=TQuery.Create(application.MainForm);
        requete.DatabaseName:=DM_C_NomAliasDossier;
        requete.SQL.Clear;
        requete.SQL.add('update ta_releveBancaire set id_ecriture=null,cptTiers=null where id_ecriture=:id');
        requete.ParamByName('id').AsInteger:=id_ecriture;
        requete.ExecSQL;
    except
      result:=false;
      showmessage('Erreur lors de la mise � jour de la table des relev�s bancaire');
    end;//fin except
  finally
    requete.close;
    requete.free;
  end;
end;

procedure TDMImportReleve.TaReleveReglementBeforePost(DataSet: TDataSet);
begin
try
CtrlSaisieReleveBancaire( DataSet.FindField('cptTiers'));
except
  abort;
end;
end;

Function TDMImportReleve.CtrlSaisieReleveBancaire(CCourant:Tfield):TErreurSaisie;
begin // initialisation des variables de retour de fonction
try
CtrlSaisieReleveBancaire.CodeErreur:=0;
CtrlSaisieReleveBancaire.Retour:=True;
if( CCourant.FieldName='cptTiers')and (not empty(CCourant.AsString))then
  begin
        DMPieces.GestionFiltrageParamCptSurCompte(CompteReglement);
        if (AideCompteDansContexte(CCourant.AsString,CCourant,['Rac1'],false,MessDerSub,true,true,true,true,1)) then
        begin
           if(Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[CCourant.AsString]).Collectif)then
           begin
             showmessage('Le compte '+CCourant.AsString+' n''est pas coh�rent dans ce contexte');
             abort;
           end;
        end
        else
             begin
               showmessage('Le compte '+CCourant.AsString+' n''est pas coh�rent dans ce contexte');
               abort;
             end;
  end;
except
   CCourant.FocusControl;
   abort;
end;
end;

procedure TDMImportReleve.TaReleveBeforePost(DataSet: TDataSet);
Var
I:Integer;
begin
I:=ListeMarquageReleveEnCours.IndexOf(DAtaSet.findField('ID').AsString);
if ((I <> -1) and (DAtaSet.findField('Marque').AsString = '' )) then
    ListeMarquageReleveEnCours.Delete(I);
I:=listeMarqueEnCours.IndexOf(DAtaSet.findField('Marque').AsString);
if (I <> -1) then  listeMarqueEnCours.Delete(I);
if DAtaSet.findField('Marque').AsString <> '' then
 begin
  ListeMarquageReleveEnCours.Add(DAtaSet.findField('ID').AsString);
  listeMarqueEnCours.Add(DAtaSet.findField('Marque').AsString);

  //MarqueCourante:=DAtaSet.findField('MarqueReleve').AsString;
 end;
end;

function TDMImportReleve.recupDerniereDateReleveCompte(compteBancaire:string):tdate;
var
compte,guichet,banque:string;
begin
banque:=str_getstringelement(compteBancaire,1,'-');
guichet:=str_getstringelement(compteBancaire,2,'-');
compte:=str_getstringelement(compteBancaire,3,'-');
result:=e.DatExoDebut;
QuReleveEbics.Close;
QuReleveEbics.SQL.Clear;
QuReleveEbics.SQL.Add('Select max(dateOP) as NewDate from Ta_relevebancaire ');
QuReleveEbics.SQL.Add(' where code_banque like :code_banque and code_guichet like :code_guichet and compte_Banque like :compte_Banque');
QuReleveEbics.ParamByName('code_banque').AsString:=banque;
QuReleveEbics.ParamByName('code_guichet').AsString:=guichet;
QuReleveEbics.ParamByName('compte_Banque').AsString:=compte;
QuReleveEbics.Open;
QuReleveEbics.First;
if(QuReleveEbics.RecordCount>0) and (QuReleveEbics.findfield('NewDate').AsDateTime<>0)then
  result:=QuReleveEbics.findfield('NewDate').AsDateTime+1;
end;


function TDMImportReleve.listeCompteBancaire():Tstringlist;
var
CompteBancaire:TCompteBancaire;
begin

   result:=TStringList.Create;
   TableGereOpen(DMRech.TaComptesBancaire);
   DeFiltrageDataSet(DMRech.TaComptesBancaire);
   DMRech.TaComptesBancaire.First;
   while not(DMRech.TaComptesBancaire.Eof) do
   begin
   CompteBancaire:=TCompteBancaire.Create(self);
      CompteBancaire.id:= DMRech.TaComptesBancaire.findfield('id').asinteger;
      CompteBancaire.journal:= DMRech.TaComptesBancaire.findfield('journal').AsString;
      CompteBancaire.codeBancaire:= DMRech.TaComptesBancaire.findfield('codeBancaire').AsString;
      CompteBancaire.login:= DMRech.TaComptesBancaire.findfield('login').AsString;
      CompteBancaire.password:= DMRech.TaComptesBancaire.findfield('password').AsString;
      CompteBancaire.iban:= DMRech.TaComptesBancaire.findfield('iban').AsString;
      CompteBancaire.codeBic:= DMRech.TaComptesBancaire.findfield('codeBic').AsString;
      CompteBancaire.site:= DMRech.TaComptesBancaire.findfield('site').AsString;
      CompteBancaire.code_banque:= DMRech.TaComptesBancaire.findfield('code_banque').AsString;
      CompteBancaire.code_guichet:= DMRech.TaComptesBancaire.findfield('code_guichet').AsString;
      CompteBancaire.compte_banque:= DMRech.TaComptesBancaire.findfield('compte_banque').AsString;
      result.AddObject(CompteBancaire.codeBancaire+' - '+CompteBancaire.journal,CompteBancaire);
      DMRech.TaComptesBancaire.Next;
   end;

//   result:=ChampTableVersListeEx(DMRech.TaComptesBancaire,';',false);

end;


end.