unit Piece;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,dbtables,
  db,
//  LibDeclRecord_Obj,
  E2_Decl_Records,
  E2_LibInfosTable,
  Libsql,
  DMRecherche,
  LibDates,
  lib_chaine,
//  E2_Librairie_Obj,
  GR_Librairie_Obj;

//const    { User-defined message }
//unit Piece;
//
//interface
//

//  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,dbtables,
//  db,E2_Decl_Records,E2_LibInfosTable,Libsql,DMRecherche,LibDates,E2_Librairie_Obj,GR_Librairie_Obj;
//
//const    { User-defined message }

type
  //////////////////////////Nouvel Objet ** MODIFICATION ** ////////////////////
  TModification = class(TComponent)
  private
    { Déclarations privées }
      FOnNewModification :TNotifyEvent;
  protected
    { Déclarations protégées }
    FAppelantName:String;
    FAppelantObjet:TComponent;
    FModif:integer;//(incrémenté par des constantes)
    FCodeModif:integer;//incrémenté par des constantes suivants l'objet modifié
    Fmessage:String;
    FAffichMessage:boolean;

  public
    { Déclarations publiques }
    Constructor Create(AOwner :TComponent); override;
    Destructor Destroy;override;
    procedure NouvelleModification;
//    property IDTrame_Ligne:integer read FIDTrame_Ligne write FIDTrame_Ligne;

  published
    { Déclarations publiées }
   Property OnNewModification :TNotifyEvent Read FOnNewModification Write FOnNewModification;
  end;

  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////Nouvel Objet ** TRAME ** ////////////////////
  TTrame = class(TComponent)
  private
    { Déclarations privées }
      FOnNewTrame :TNotifyEvent;

  protected
    { Déclarations protégées }
    FIDTrame:integer;
    FCodeTrame:string;
    FLibelleTrame:string;
    FLibellePiece:string;
    FConserveMontant:boolean;
    FConserveQte:boolean;
    FCptRepartition:string;
    FLibelleRepartition:string;
    FTauxRepartition:Real;
    FCptBanque:string;
    FIDTrame_Ligne:integer;
    FTrameACharger:boolean;
    FTableTrame:TTable;
    FTableTrame_Ligne:TTable;
    FErreurTrame:TExceptLGR_ImportPiece;
  public
    { Déclarations publiques }
    Constructor Create(AOwner :TComponent); override;
    Destructor Destroy;override;
    procedure Loaded; override;
    procedure NouvelleTrame(Partiel:boolean);
    function NewID(TableRef:TTable;ChampRech:string):integer;
    property TrameACharger:boolean read FTrameACharger write FTrameACharger;
    property IDTrame:integer read FIDTrame write FIDTrame;
    property CodeTrame:string read FCodeTrame write FCodeTrame;
    property LibelleTrame:string read FLibelleTrame write FLibelleTrame;
    property LibellePiece:string read FLibellePiece write FLibellePiece;
    property ConserveMontant:boolean read FConserveMontant write FConserveMontant;
    property IDTrame_Ligne:integer read FIDTrame_Ligne write FIDTrame_Ligne;
    property ConserveQte:boolean read FConserveQte write FConserveQte;
    property CptRepartition:string read FCptRepartition write FCptRepartition;
    property LibelleRepartition:string read FLibelleRepartition write FLibelleRepartition;
    property TauxRepartition:Real read FTauxRepartition write FTauxRepartition;
    property CptBanque:string read FCptBanque write FCptBanque;
    property ErreurTrame:TExceptLGR_ImportPiece read FErreurTrame write FErreurTrame;
  published
    { Déclarations publiées }
    property TableTrame:TTable read FTableTrame write FTableTrame;
   property TableTrame_Ligne:TTable read FTableTrame_Ligne write FTableTrame_Ligne;
   Property OnNewTrame :TNotifyEvent Read FOnNewTrame Write FOnNewTrame;
  end;


///////////////////////////////////////////////////////////////////////////////////
                   // OBJET PIECE
///////////////////////////////////////////////////////////////////////////////////
  TPieceStateChange=procedure (EtatPiece:TDataSetState) of object;
  TPiece = class(TComponent)

  private
    { Déclarations privées }
      FOnNewPiece :TNotifyEvent;
//      FOnNewEcriture:TNotifyEvent;
      FOnStateChange:TPieceStateChange;

  protected
    { Déclarations protégées }
    FListeEcritures:Tstringlist;
    FTrame:Ttrame;
    FDefaut:boolean;
    FTVA_A_Gerer:boolean;
    FDateDebutExo:tdate;
    FDateFinExo:tdate;
    FCodeExo:string;
    FAnneePiece:TPieceAnterieure;
    FTiers:string;
    FComptePlan:string;
    FContrePartieTiers:string;
    FInfosPointage:TPointage;
    FPieceModifiable:boolean;
    FNbrPointage:integer;
    FReference:string;
    FJournal:string;
    FIDJournal:integer;
    FIDContrepartie:integer;
    FContrepartie:integer;
    FListeContrePartieTiers:Tstringlist; //[0:Interdit,1:Obligatoire,-1:facultatif]
    FNewReference:string;
    FNewIDPiece:integer;
    FLibelle:string;
    FDernierLibelleSaisi:string;
    FCompte:string;
    FMontant:currency;
    FSens:boolean;
    FSensPourReglement:boolean;
    FMontantPourReglement:currency;
    FDateSaisie:tdatetime;
    FDateLivraison:tdatetime;
    FDateEcheance:tdatetime;
    FQuand:tdatetime;
    FQui:string;
    FTablePiece:Ttable;
    FIRefTaPiece:integer;
    FTableJournal:Ttable;
    FIndexJournal:integer;
    FTablePlan:Ttable;
    FIndexCompte:integer;
    FTableTiers:Ttable;
    FICompteTiers:integer;
    FILibTiers:integer;
    FILibTaPlan:integer;
    FEtatPiece:TDataSetState;
    FFirstIDPiece:integer;
    FLastIDPiece:integer;
    FModifier_Confirmer:boolean;
    FModifier_EnAttente:boolean;
    FInserer:boolean;
    FReglement:boolean;
    FInfosVerrouillage:TVerrouillage;
    FTypeTvaE:boolean;
    FSuppDerniereDeclTva:boolean;
    FValPieceAutoGen:TValPieceAutoGenere;
    FNumCheque:string;
    FIDGestCo:integer;
    FCodeGestCo:string;
    FSuppressionParticulieres:boolean;
    FSuppression_Pour_Modif:boolean;
    FAcceptPieceNul:boolean;
    Function Empty(Const Value : String) :Boolean;
    procedure setEtatPiece(Etat:TDataSetState);
    Procedure SetCompte(compteSaisie:string);
    Function GetCompte:string;
  public
    { Déclarations publiques }
    Constructor Create(AOwner :TComponent); override;
    Destructor Destroy;override;
    procedure Loaded; override;
    Function NewReference(TablePiece:Ttable;ChampRef:string;JournalTmp,CodeExoPiece,OldReference:string):string;
    function NewIDPiece(TablePiece:Ttable;ChampID:string;MinMax:boolean):integer;
    Function VerifJournal(TableJournal:TTable;ChampJournal:string;CreerNewRef:boolean):boolean;
    Function VerifDatesExo:boolean;
    Function VerifDateSaisie(DateTmp:Tdate):boolean;
    Function EmptyCompte:boolean;
    Function EmptyLibelle:boolean;
    Function InitLibelle(TableCompte:ttable;IndexCompte:integer;ILibCompte:integer;PrendreDernierLib:boolean):boolean;
    procedure NouvellePiece(Partiel:boolean);
    Function RechercheReference(TablePiece:ttable;ValeurRef,ChampRef,ChampIDPiece:string;var RecupID:Integer):boolean;
    Function EmptyReference:boolean;
    function RenvoieIDJournal(CodeJournal:string):integer;
    function RenvoieCodeJournal(ID:Integer):string;
    function RetourneInfosVerrouillageSurPiece(Piece:Tpiece;IDPiece:integer;DatePiece:Tdatetime):TVerrouillage;
    function RetourneInfosVerrouillageSurPointage(Piece:Tpiece;DatePiece:TdateTime;infosDebit:TInfosEcriture;infosCredit:TInfosEcriture):TVerrouillage;
    function RetourneInfosEtatVersementSurPiece(IDPiece:integer;DatePiece:Tdatetime):TVerrouillage;
    function Verification_TvaDeclare_Pointage(Suppression:boolean;IDEcriture_Debit,IDEcriture_Credit:integer):TerreurTva;
    function Verification_TvaDeclare_Pointage_new(Suppression:boolean;IDEcriture_Debit,IDEcriture_Credit:integer):TerreurTva;
    function Recup_DateTva_Valide(Var TvaDate:String):TDetailDate;

    procedure InitialiseInfosVerrouillage(var Verrou:TVerrouillage);
    procedure InitialiseInfosPointage(var Pointage:TPointage);
    procedure FiltrageTablePieceSurPieceAnterieure(Anterieure:boolean);
    procedure initialiseValPieceAutoGen(var ValPieceAutoGen:TValPieceAutoGenere);
    property IDJournal:integer read FIDJournal write FIDJournal;
    property FirstIDPiece:integer read FFirstIDPiece write FFirstIDPiece;
    property LastIDPiece:integer read FLastIDPiece write FLastIDPiece;
    property NbrPointage:integer read FNbrPointage write FNbrPointage;
    property EtatPiece:TDataSetState read FEtatPiece  write setEtatPiece;
    property PieceModifiable:boolean read FPieceModifiable write FPieceModifiable;
    property ComptePlan:string read FComptePlan write FComptePlan;
    property ContrePartieTiers:string read FContrePartieTiers write FContrePartieTiers;
    property Tiers:string read FTiers write FTiers;
    property Montant:currency read FMontant write FMontant;
    property MontantPourReglement:currency read FMontantPourReglement write FMontantPourReglement;
    property Sens:boolean read FSens write FSens;
    property SensPourReglement:boolean read FSensPourReglement write FSensPourReglement;
    property InfosPointage:TPointage read FInfosPointage write FInfosPointage;
    property IDContrepartie:integer read FIDContrepartie write FIDContrepartie;
    property Modifier_Confirmer:boolean read FModifier_Confirmer write FModifier_Confirmer;
    property Modifier_EnAttente:boolean read FModifier_EnAttente write FModifier_EnAttente;
    property Inserer:boolean read FInserer write FInserer;
    property Reglement:boolean read FReglement write FReglement;
    property InfosVerrouillage:TVerrouillage read FInfosVerrouillage write FInfosVerrouillage;
    property TypeTvaE:boolean read FTypeTvaE write FTypeTvaE;
    property SuppDerniereDeclTva:boolean read FSuppDerniereDeclTva write FSuppDerniereDeclTva;
    property AnneePiece:TPieceAnterieure read FAnneePiece write FAnneePiece;
    property Defaut:boolean read FDefaut write FDefaut;
    property TVA_A_Gerer:boolean read FTVA_A_Gerer write FTVA_A_Gerer;
    property ValPieceAutoGen:TValPieceAutoGenere read FValPieceAutoGen write FValPieceAutoGen;
    property NumCheque:string read FNumCheque write FNumCheque;
    property IDGestCo:integer read FIDGestCo write FIDGestCo;
    property CodeGestCo:string read FCodeGestCo write FCodeGestCo;
    property SuppressionParticulieres:boolean read FSuppressionParticulieres write FSuppressionParticulieres;
    property ListeEcritures:Tstringlist read FListeEcritures write FListeEcritures;
    property ListeContrePartieTiers:Tstringlist read FListeContrePartieTiers write FListeContrePartieTiers;
    property Suppression_Pour_Modif:boolean read FSuppression_Pour_Modif write FSuppression_Pour_Modif;
    property AcceptPieceNul:boolean read FAcceptPieceNul write FAcceptPieceNul;

    Procedure StateChange(Piece:TPiece);
    function CalculsoldePiece(Piece:Tpiece):TInfos_Piece;
    procedure SuppressionObjetPiece(Piece:Tpiece);


  published
    { Déclarations publiées }

   Property Trame:TTrame read FTrame write FTrame;
   Property DateDebutExo:Tdate read FDateDebutExo write FDateDebutExo;
   property DateFinExo:tdate read FDateFinExo write FDateFinExo;
   property CodeExo:string read FCodeExo write FCodeExo;
   property Reference:string read FReference write FReference;
   property Contrepartie:integer read  FContrepartie write FContrepartie;
   property Journal:string read FJournal write FJournal;
   property Libelle:string read FLibelle write FLibelle;
   property DernierLibelleSaisi:string read FDernierLibelleSaisi write FDernierLibelleSaisi;
   property Compte:string read FCompte write FCompte;
//   property Compte:string read GetCompte write SetCompte;
   property DateSaisie:tdatetime read FDateSaisie write FDateSaisie;
   property DateLivraison:tdatetime read FDateLivraison write FDateLivraison;
   property DateEcheance:tdatetime read FDateEcheance write FDateEcheance;
   property Quand:tdatetime read FQuand write FQuand;
   property Qui:string read FQui write FQui;
   property TableJournal:Ttable read FTableJournal write FTableJournal;
   property IndexJournal:integer read FIndexJournal write FIndexJournal;
   Property OnNewPiece :TNotifyEvent Read FOnNewPiece Write FOnNewPiece;
//   Property OnNewEcriture:TNotifyEvent Read FOnNewEcriture Write FOnNewEcriture;
   property TablePlan:Ttable read FTablePlan write FTablePlan;
   property TableTiers:Ttable read FTableTiers write FTableTiers;
   property IndexCompte:integer read FIndexCompte write FIndexCompte;
   property ICompteTiers:integer read FICompteTiers write FICompteTiers;
   property ILibTiers:integer read  FILibTiers write FILibTiers;
   property ILibTaPlan:integer read FILibTaPlan write FILibTaPlan;
   property TablePiece:ttable read FTablePiece write FTablePiece;
   property IRefTaPiece:integer read FIRefTaPiece write FIRefTaPiece;
   Property OnStateChange :TPieceStateChange Read FOnStateChange Write FOnStateChange;


  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure Register;

   Function CopieContenuPiece(Source,Dest:TPiece;AvecCreation:boolean=true):boolean;
   Function CopieContenuPiece_DansFichier(Source:TPiece;NomFichier:string=''):Tstringlist;
   Function CopieContenuTrame_DansFichier(Source:TTrame;NomFichier:string=''):Tstringlist;
   Function CopieContenuTrame(Source,Dest:TTrame;AvecCreation:boolean=true):boolean;

implementation
uses Ecriture_Isa,
DMPiece,
DMPlanCpt,
E2_AideCompte,
  E2_Patientez;

procedure Register;
begin
  RegisterComponents('Epicea', [TPiece,TTrame,TModification]);
end;

Function TPiece.Empty(Const Value : String) :Boolean;
// Retourne vrai si la valeur est vide ou pleine d'espace
Var i :Integer;
Begin
	Result:= True;
	i:= 1;
	While Result And (i <= Length(Value)) Do
	Begin
		Result:= (Value[i] <= #32) or (Value[i] >= #124);
		Inc(i);
	End;
End;

Constructor TPiece.Create(AOwner :TComponent);
begin
inherited create(AOwner);
FListeEcritures:=tstringlist.create;
FListeContrePartieTiers:=tstringlist.create;
end;

Destructor TPiece.Destroy;
begin
inherited destroy;
LibereObjet(Tobject(FListeEcritures));
LibereObjet(Tobject(FListeContrePartieTiers));
end;


procedure TPiece.Loaded;
Begin
inherited loaded;
//NouvellePiece;
End;


//Renvoie une nouvelle reference en fonction du journal et du code Exo (Max +1)
Function TPiece.NewReference(TablePiece:Ttable;ChampRef:string;JournalTmp,CodeExoPiece,OldReference:string):string;
var
QueryRef:TQuery;
begin
try//finally
  QueryRef:=tquery.Create(self);
  queryRef.DatabaseName:=tablepiece.DatabaseName;
  queryref.SQL.Clear;
  //si oldreference remplie, on verifie si elle peut-être nouvelle reference
  if not empty(OldReference)then
    begin
    //décomposer la référence pour voir si elle est correcte
    if ((copy(OldReference,1,4)=JournalTmp+CodeExoPiece)and(length(oldreference)=9)) then
      begin//si début de référence correct
        queryref.SQL.Add('Select reference from ' +tablepiece.TableName+' where '+ChampRef+ ' like('''+OldReference+''')');
        queryref.Open;
        if queryref.RecordCount<>0 then
          begin
            queryref.close;
            queryref.SQL.Clear;
            queryref.SQL.Add('Select max('+ChampRef+') as resultat from ' +tablepiece.TableName+' where '+ChampRef+ ' like('''+JournalTmp+CodeExoPiece+'%'')');
            queryref.Open;
          end
        else
          begin
            result:=OldReference;
            exit;
          end;
      end
    else
      begin
         queryref.close;
         queryref.SQL.Clear;
         queryref.SQL.Add('Select max('+ChampRef+') as resultat from ' +tablepiece.TableName+' where '+ChampRef+ ' like('''+JournalTmp+CodeExoPiece+'%'')');
         queryref.Open;
      end;
    end
  else //sinon on en cherche une nouvelle
    begin
    queryref.SQL.Add('Select max('+ChampRef+') as resultat from ' +tablepiece.TableName+' where '+ChampRef+ ' like('''+JournalTmp+CodeExoPiece+'%'')');
    queryref.Open;
    end;
  result:=queryref.FindField('resultat').ASString;
  if trim(result)='' then
     begin
      result := JournalTmp+CodeExoPiece+'00001';
     end
     else
     begin
     delete(result,1,length(JournalTmp)+ length(JournalTmp));
     result:=inttostr(strtoint(result)+1);
     while length(result) < 5 do
           Begin
           Result:='0'+Result;
           End;
    result:=JournalTmp+CodeExoPiece+result;
     end;
finally
  queryref.close;
  queryref.Free;
  queryref:=nil;
end;//fin du try finally
end;

Function TPiece.VerifJournal(TableJournal:TTable;ChampJournal:string;CreerNewRef:boolean):boolean;
var
OldFilter:string;
Filtered:boolean;
Begin
OldFilter:=TableJournal.Filter;
Filtered:=TableJournal.Filtered;
TableJournal.Filtered:=false;
result:=TableJournal.Locate(ChampJournal,Journal,[]);
TableJournal.Filter:=OldFilter;
TableJournal.Filtered:=Filtered;

End;

Function TPiece.VerifDatesExo:boolean;
var
TestDate1:string;
TestDate2:Tdate;
Begin
   try
     TestDate1:=DateTostr(FDateDebutExo);
     TestDate2:=strtodate(testdate1);
     TestDate1:=DateTostr(FDateFinExo);
     TestDate2:=strtodate(testdate1);
     result:=((DateTostr(FDateDebutExo)<>'30/12/1899') and (DateTostr(FDateFinExo) <> '30/12/1899'));
     if result then result:=FDateDebutExo < FDateFinExo;
   except
     result:=false;
   end;//fin du try
End;


Function TPiece.VerifDateSaisie(DateTmp:Tdate):boolean;
var
TestDate:string;
Begin
result:=false;
  try
  TestDate:=DateTostr(DateTmp);
  if verifdatesExo then
    Begin
      if AnneePiece.PieceAnterieure then
        result:=(DateTmp<FDateDebutExo)
      else
        result:=((DateTmp>=FDateDebutExo) and  (DateTmp<=FDateFinExo));
    End;
  except
  result:=false;
  end;//fin du try
End;


procedure TPiece.NouvellePiece(Partiel:boolean);
Begin

if not partiel then
  Begin//si
    FCompte:='';
    FIDJournal:=0;
    FJournal:='';
    FLibelle:='';
  End;//fin si
  
if FTablePiece=nil then
begin
  FTablePiece:=TTable.Create(application.MainForm);
  FTablePiece.TableName:=DMRech.TaPieceRech.TableName;
  FTablePiece.DatabaseName:=DMRech.TaPieceRech.DatabaseName;
  FTablePiece.Open;
end;
if FTableJournal=nil then
begin
  FTableJournal:=TTable.Create(application.MainForm);
  FTableJournal.TableName:=DMRech.TaModelRech.TableName;
  FTableJournal.DatabaseName:=DMRech.TaModelRech.DatabaseName;
  FTableJournal.Open;
end;
if FTablePlan=nil then
begin
  FTablePlan:=TTable.Create(application.MainForm);
  FTablePlan.TableName:=DMRech.TaPlanCptRech.TableName;
  FTablePlan.DatabaseName:=DMRech.TaPlanCptRech.DatabaseName;
  FTablePlan.Open;
end;
if FTableTiers=nil then
begin
  FTableTiers:=TTable.Create(application.MainForm);
  FTableTiers.TableName:=DMRech.TaTiersRech.TableName;
  FTableTiers.DatabaseName:=DMRech.TaTiersRech.DatabaseName;
  FTableTiers.Open;
end;






if trame=nil then trame:=TTrame.Create(application.MainForm);
  trame.NouvelleTrame(partiel);

FAcceptPieceNul:=false; //isa le 30082007
FTiers:='';
FComptePlan:='';
FReference:='';
FICompteTiers:=0;
FILibTiers:=1;
FIndexCompte:=0;
FILibTaPlan:=1;
FIndexJournal:=4;
FIRefTaPiece:=2;
//DisposeTStringlist(FListeEcritures); { isa  le  04/08/04 }
//FListeEcritures.clear;
Initialise_TStringlist(FListeEcritures,nil,false);
//FListeEcritures:=tstringlist.create;

//DisposeTStringlist(FListeContrePartieTiers);{ isa  le  04/08/04 }
//FListeContrePartieTiers.clear;
Initialise_TStringlist(FListeContrePartieTiers,nil,false);
//FListeContrePartieTiers:=tstringlist.create;

FDernierLibelleSaisi:='';
FDateSaisie:=0;
FDefaut:=true;
EtatPiece:=dsBrowse;
FFirstIDPiece:=0;
FLastIDPiece:=0;
FIDContrepartie:=-1;
//FDernierLibelleSaisi:='';
FModifier_Confirmer:=false;
FModifier_EnAttente:=false;
FMontant:=0;
FNbrPointage:=0;
FNewIDPiece:=0;
FNewReference:='';
FPieceModifiable:=true;
FReglement:=false;
FSens:=false;
FTVA_A_Gerer:=true;
FTypeTvaE:=false;
FSuppDerniereDeclTva:=false;

FInfosPointage.infosPointage.Pointee:=false;
FInfosPointage.infosPointage.NbLignePointee:=0;
FInfosPointage.InfosReste.Reste:=0;
FInfosPointage.InfosReste.SensReste:=false;
initialiseValPieceAutoGen(FValPieceAutoGen);
FNumCheque:='';
FCodeGestCo:='';
FIDGestCo:=0;
FSuppression_Pour_Modif:=false;
 if Assigned(FOnNewPiece) then FOnNewPiece(Self);
// if assigned(FOnNewEcriture) then FOnNewEcriture(self);
End;

Function TPiece.EmptyCompte:boolean;
Begin
result:=empty(FCompte);
End;

Function TPiece.EmptyLibelle:boolean;
Begin
result:=empty(FLibelle);
End;

Function TPiece.InitLibelle(TableCompte:ttable;IndexCompte:integer;ILibCompte:integer;PrendreDernierLib:boolean):boolean;
var
TableTmp:ttable;
Begin
TableTmp:=ttable.Create(self);
TableTmp.DatabaseName:=TableCompte.DatabaseName;
TableTmp.tablename:=TableCompte.tablename;
tableTmp.Open;
result:=false;
if ((not empty(FDernierLibelleSaisi))and(PrendreDernierLib))then
  FLibelle:=FDernierLibelleSaisi
else
if not EmptyCompte then
      Begin
       if TableTmp.locate(TableTmp.Fields[IndexCompte].FieldName,FCompte,[]) then
          Begin
            FLibelle:=TableTmp.Fields[ILibCompte].AsString;
            if PrendreDernierLib then
              FDernierLibelleSaisi:=FLibelle;
          end;
      End;
result:=not EmptyLibelle;
tableTmp.close;
tableTmp.free;
tableTmp:=nil;
End;

//recherche dans la table piece si la reférence saisie existe déjà. Si oui, renvoie l'ID de
//la piece contenant cette référence.
Function TPiece.RechercheReference(TablePiece:ttable;ValeurRef,ChampRef,ChampIDPiece:string;var RecupID:Integer):boolean;
var
TableTmp:ttable;
Begin
result:=true;
TableTmp:=ttable.Create(self);
TableTmp.DatabaseName:=tablepiece.DatabaseName;
TableTmp.TableName:=tablepiece.TableName;
TableTmp.Open;
   try
      if TableTmp.Locate(ChampRef,ValeurRef,[]) then
      begin
       RecupID:=TableTmp.FindField(ChampIDPiece).asinteger;
      end
      else
      result:=false;
   except
   abort;
   result:=false;
   end;
TableTmp.Close;
TableTmp.Free;
tableTmp:=nil;
end;

Function TPiece.EmptyReference:boolean;
Begin
 result:=empty(FReference);
End;

function TPiece.RenvoieIDJournal(CodeJournal:string):integer;
Begin
result:=0;
if TableJournal.Locate('Code',CodeJournal,[]) then
result:=TableJournal.findfield('ID_Journal').AsInteger;
End;

function TPiece.RenvoieCodeJournal(ID:Integer):string;
Begin
result:='';
if TableJournal.Locate('ID',ID,[]) then
result:=TableJournal.findfield('Code').Asstring;
End;


function TPiece.NewIDPiece(TablePiece:Ttable;ChampID:string;MinMax:boolean):integer;
var
QueryID:TQuery;
begin
QueryID:=tquery.Create(self);
QueryID.DatabaseName:=tablepiece.DatabaseName;
QueryID.SQL.Clear;
if anneepiece.PieceAnterieure then
 begin
   QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +tablepiece.TableName+'');
   QueryID.SQL.Add(' Where '+ChampID+'< ' +Inttostr((strtoint(codeExo)*10000000))+'''');
   QueryID.Open;
   result:=0;
   if QueryID.FindField('resultat').Asinteger = 0 then
   result:=(strtoint(anneepiece.ExoAnterieure)*10000000)+1
   else
   result:=QueryID.FindField('resultat').Asinteger+1;
 end
 else
 begin
   QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +tablepiece.TableName+'');
//   QueryID.SQL.Add(' Where '+ChampID+'>= ' +IntToStr((strtoint(codeExo)*10000000))+'''');
   QueryID.SQL.Add(' Where '+ChampID+' between ' +IntToStr((strtoint(codeExo)*10000000))+' and ' +IntToStr(((strtoint(codeExo)+1)*10000000))+'''');
   QueryID.Open;
   result:=0;
   if QueryID.FindField('resultat').Asinteger = 0 then
   result:=(strtoint(codeExo)*10000000)+1
   else
   result:=QueryID.FindField('resultat').Asinteger+1;
 end;
//if MinMax then
//  QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +tablepiece.TableName+'''')
//else
//  QueryID.SQL.Add('Select Min('+ChampID+') as resultat from ' +tablepiece.TableName+'''');
//QueryID.Open;
//result:=0;
//if QueryID.FindField('resultat').Asinteger = 0 then
//result:=(strtoint(codeExo)*10000000);
//else
//result:=QueryID.FindField('resultat').Asinteger+1;
//if MinMax then
//   Begin
//     if QueryID.FindField('resultat').Asinteger=-1 then
//       result:=1
//     else
//       result:=QueryID.FindField('resultat').Asinteger+1;
//   End
//else
//   Begin
//      if QueryID.FindField('resultat').Asinteger=1 then
//        result:=-1
//      else
//        result:=QueryID.FindField('resultat').Asinteger-1;
//   End;
//if result = 1 then
//if anneepiece.PieceAnterieure then
//  result:=(strtoint(anneepiece.ExoAnterieure)*10000000)+result
//  else Result:=(strtoint(codeExo)*10000000)+result;
//if result = -1 then Result:=-(strtoint(codeExo)*10000000)-result;
//if result = 1 then Result:=(strtoint(codeExo)*10000000)+result;
QueryID.close;
QueryID.Free;
QueryID:=nil;
end;



procedure TPiece.InitialiseInfosPointage(var Pointage:TPointage);
Begin
   Pointage.infosPointage.Pointee:=false;
   Pointage.infosPointage.NbLignePointee:=0;
   Pointage.infosPointage.Dataset:=nil;
   Pointage.infosPointage.Lettre:='';
   Pointage.infosPointage.Ligne:=0;
   Pointage.infosPointage.MontantPointage:=0;
   Pointage.infosPointage.TvaSurE:=false;
   Pointage.InfosReste.Reste:=0;
   Pointage.InfosReste.ResteInitial:=0;
   Pointage.InfosReste.SensReste:=false;
End;

//cette fonction permet de rechercher si la pièce passée en paramètre est verrouillée et si la date passée en paramètre
//fait partie d'une période déclarée
//de plus, si on passe un objet pièce, on vérifie s'il contient une liste de lignes pointables dans son corps et pour chacune d'elles
//on verifie si elle fait partie d'une déclaration ou si la date de cette pièce fait partie d'une période verrouillée.
function TPiece.RetourneInfosVerrouillageSurPiece(Piece:Tpiece;IDPiece:integer;DatePiece:Tdatetime):TVerrouillage;
var
InfosH_TVA:TInfosH_TVA;
GestErreur:TErreurTva;
A:integer;
Requete_H_TVA,Requete_H_PieceTVA:TQuery;
MessageLGR:TMessageLGR;
Begin
InitialiseInfosVerrouillage(result);
GestErreur.SupprODDecl:=false;
GestErreur.Continuer:=true;
GestErreur.CodeErreur:=0;
GestErreur.Messages:='';
GestErreur.Retour:=true;
  try//finally
  try//except
  Requete_H_TVA:=TQuery.Create(application.MainForm);
  Requete_H_TVA.DatabaseName:=DMRech.TaH_TVARech.DatabaseName;

  Requete_H_PieceTVA:=TQuery.Create(application.MainForm);
  Requete_H_PieceTVA.DatabaseName:=DMRech.TaH_TVARech.DatabaseName;

  //regarder si pièce pointée avec une autre pièce comprenant de la tva sur E
  if piece <>nil then
  begin//si on veut gérer les pointages liés à la pièce à vérifier
  if Piece.ListeContrePartieTiers<>nil then
    Begin//si la pièce à vérifier contient des écritures pointables
       A:=0;
       while ((((not GestErreur.SupprODDecl)or(not gesterreur.Continuer))) and (a<Piece.ListeContrePartieTiers.count))do
         begin
           FiltrageDataSet(dmrech.TaPointageRech,'id_debit='''+Piece.ListeContrePartieTiers.Strings[a]+''' or id_credit='''+Piece.ListeContrePartieTiers.Strings[a]+'''');
           dmrech.TaPointageRech.First;
           if dmrech.TaPointageRech.RecordCount<>0 then
             begin//si pointage trouvé pour écriture listecontrepartie en cours
             if dmrech.TaPointageRech.findfield('id_debit').asstring<>Piece.ListeContrePartieTiers.Strings[a] then
               GestErreur:=Verification_TvaDeclare_Pointage_new(true,dmrech.TaPointageRech.findfield('id_debit').asinteger,strtoint(Piece.ListeContrePartieTiers.Strings[a]))
             else
               GestErreur:=Verification_TvaDeclare_Pointage_new(true,strtoint(Piece.ListeContrePartieTiers.Strings[a]),dmrech.TaPointageRech.findfield('id_Credit').asinteger);
             if not GestErreur.Retour then
               Begin//si problème tva rencontré
                  Result.PeriodeVerrouillee:=true;
                  if not gesterreur.Continuer then
                    Begin//si on ne peut pas supprimer l'od de déclaration
                      Result.PeriodeDeverrouillable:=false;
                    End//fin si on ne peut pas supprimer l'od de déclaration
                  else
                    Begin//si
                      if GestErreur.SupprODDecl then
                        Result.PeriodeDeverrouillable:=true;
                    End;//fin si
               End;//fin si problème tva rencontré
             end;//fin si pointage trouvé pour écriture listecontrepartie en cours
           inc(a);
           dmrech.TaPointageRech.Next;
         end;
    End;//fin si la pièce à vérifier contient des écritures pointables
  end;//fin si on veut gérer les pointages liés à la pièce à vérifier


  // Recherche pour savoir si la datePiece est dans une période déclarée ou
  //recherche si periode deverrouillable dans le cas d'une piece de banque qui ferait
  //partie d'une période déclarée non déverrouillable
  if result.PeriodeVerrouillee=false then
    begin//si on n'a pas déjà trouvé que la période était verrouillée à cause d'un pointage dans une période déclarée
      Requete_H_TVA.close;
      Requete_H_TVA.SQL.clear;
      Requete_H_TVA.SQL.Add('select  max(fin_Periode)as resultat from h_tva where En_Attente=false and ID_Declaration<>0 ');
      Requete_H_TVA.open;

      Requete_H_PieceTVA.close;
      Requete_H_PieceTVA.SQL.clear;
      Requete_H_PieceTVA.SQL.Add('select  max(fin_Periode)as resultat from h_Piecetva where  ((ID_Declaration<>0)or(Divers_Str=''Cloture'')) ');
      Requete_H_PieceTVA.open;

      if ((Requete_H_TVA.RecordCount>0)and(Requete_H_TVA.findfield('resultat').asdatetime<>0)) then
//      if Requete_H_TVA.RecordCount>0 then
        begin //si on trouve une date de fin_période dans H_Tva
        //vérif sur H_TVA
        Result.PeriodeVerrouillee:=DateDsIntervale(0,DatePiece,Requete_H_TVA.findfield('resultat').asdatetime,MessageLGR);
        if not Result.PeriodeVerrouillee then
          begin
          //vérif sur H_PieceTVA
          if Requete_H_PieceTVA.RecordCount>0 then
             Result.PeriodeVerrouillee:=DateDsIntervale(0,DatePiece,Requete_H_PieceTVA.findfield('resultat').asdatetime,MessageLGR);
          end;
        if Result.PeriodeVerrouillee then
          begin //vérif sur H_TVA
            Requete_H_TVA.close;
            Requete_H_TVA.SQL.clear;
            Requete_H_TVA.SQL.Add('select fin_periode from h_tva where en_attente=false and  ID_Declaration<>0 and deverrouillable=false order by fin_periode ');
            Requete_H_TVA.open;
            if Requete_H_TVA.RecordCount<>0 then
            begin
              Requete_H_TVA.first;
              while ((result.PeriodeDeverrouillable)and (not(Requete_H_TVA.EOF)))  do
                begin
                  result.PeriodeDeverrouillable:=DatePiece>Requete_H_TVA.FindField('fin_periode').asdatetime;
                  Requete_H_TVA.next;
                end;
            end;
          end;//fin vérif sur H_TVA
        if not Result.PeriodeDeverrouillable then
          begin //vérif sur H_PieceTVA
            Requete_H_PieceTVA.close;
            Requete_H_PieceTVA.SQL.clear;
            Requete_H_PieceTVA.SQL.Add('select fin_periode from h_Piecetva where  ((ID_Declaration<>0)or(Divers_Str=''Cloture'')) and deverrouillable=false order by fin_periode ');
            Requete_H_PieceTVA.open;
            if Requete_H_PieceTVA.RecordCount<>0 then
            begin
              Requete_H_PieceTVA.first;
              while ((result.PeriodeDeverrouillable)and (not(Requete_H_PieceTVA.EOF)))  do
                begin
                  result.PeriodeDeverrouillable:=DatePiece>Requete_H_PieceTVA.FindField('fin_periode').asdatetime;
                  Requete_H_PieceTVA.next;
                end;
            end;
          end;//fin vérif sur H_PieceTVA

        end;//fin si on trouve une date de fin_période dans H_Tva
    end;//fin si on n'a pas déjà trouvé que la période était verrouillée à cause d'un pointage dans une période déclarée

  // Recherche pour savoir si la piece fait partie d'une déclaration TVA
  FiltrageDataSet(DMRech.TaH_TVARech,'En_Attente=faux and ID_Declaration<>0 and id_piece='+inttostr(IDPiece));
  Result.PieceVerrouillee:=DMRech.TaH_TVARech.RecordCount>0;

  // Recherche pour savoir si la piece est non dévérrouillable
  // cad qu'elle fait partie d'une déclaration antérieure à la dernière déclaration
  // non dévérouillable
  FiltrageDataSet(DMRech.TaH_TVARech,'id_piece='+inttostr(IDPiece)+' and ID_Declaration<>0 and En_Attente=faux and deverrouillable = faux ');
  Result.Deverrouillable:=DMRech.TaH_TVARech.RecordCount=0;
  except
    abort;
  end;//fin du try except
  finally
     if Requete_H_TVA<>nil then Requete_H_TVA.Free;
     if Requete_H_PieceTVA<>nil then Requete_H_PieceTVA.Free;
  end;//fin du try finally
End;



function TPiece.RetourneInfosVerrouillageSurPointage(Piece:Tpiece;DatePiece:TdateTime;infosDebit:TInfosEcriture;infosCredit:TInfosEcriture):TVerrouillage;
var
InfosH_TVA:TInfosH_TVA;
GestErreur:TErreurTva;
A:integer;
Requete_H_TVA,Requete_H_PieceTVA,Requete_Pointage:TQuery;
MessageLGR:TMessageLGR;
Begin
InitialiseInfosVerrouillage(result);
GestErreur.SupprODDecl:=false;
GestErreur.Continuer:=true;
GestErreur.CodeErreur:=0;
GestErreur.Messages:='';
GestErreur.Retour:=true;
  try//finally
  try//except
  Requete_H_TVA:=TQuery.Create(application.MainForm);
  Requete_H_TVA.DatabaseName:=DMRech.TaH_TVARech.DatabaseName;

  Requete_H_PieceTVA:=TQuery.Create(application.MainForm);
  Requete_H_PieceTVA.DatabaseName:=DMRech.TaH_TVARech.DatabaseName;

  Requete_Pointage:=TQuery.Create(application.MainForm);
  Requete_Pointage.DatabaseName:=DMRech.TaEcritureRech.DatabaseName;
  
  //regarder si pièce pointée avec une autre pièce comprenant de la tva sur E
  if piece <>nil then
  begin//si on veut gérer les pointages liés à la pièce à vérifier
  if Piece.ListeContrePartieTiers<>nil then
    Begin//si la pièce à vérifier contient des écritures pointables
       A:=0;
       while ((((not GestErreur.SupprODDecl)or(not gesterreur.Continuer))) and (a<Piece.ListeContrePartieTiers.count))do
         begin
           FiltrageDataSet(dmrech.TaPointageRech,'id_debit='''+Piece.ListeContrePartieTiers.Strings[a]+''' or id_credit='''+Piece.ListeContrePartieTiers.Strings[a]+'''');
           dmrech.TaPointageRech.First;
           if dmrech.TaPointageRech.RecordCount<>0 then
             begin//si pointage trouvé pour écriture listecontrepartie en cours
             if dmrech.TaPointageRech.findfield('id_debit').asstring<>Piece.ListeContrePartieTiers.Strings[a] then
               GestErreur:=Verification_TvaDeclare_Pointage_new(true,dmrech.TaPointageRech.findfield('id_debit').asinteger,strtoint(Piece.ListeContrePartieTiers.Strings[a]))
             else
               GestErreur:=Verification_TvaDeclare_Pointage_new(true,strtoint(Piece.ListeContrePartieTiers.Strings[a]),dmrech.TaPointageRech.findfield('id_Credit').asinteger);
             if not GestErreur.Retour then
               Begin//si problème tva rencontré
                  Result.PeriodeVerrouillee:=true;
                  if not gesterreur.Continuer then
                    Begin//si on ne peut pas supprimer l'od de déclaration
                      Result.PeriodeDeverrouillable:=false;
                    End//fin si on ne peut pas supprimer l'od de déclaration
                  else
                    Begin//si
                      if GestErreur.SupprODDecl then
                        Result.PeriodeDeverrouillable:=true;
                    End;//fin si
               End;//fin si problème tva rencontré
             end;//fin si pointage trouvé pour écriture listecontrepartie en cours
           inc(a);
           dmrech.TaPointageRech.Next;
         end;
    End;//fin si la pièce à vérifier contient des écritures pointables
  end;
  // Recherche pour savoir si la datePiece est dans une période déclarée ou
  //recherche si periode deverrouillable dans le cas d'une piece de banque qui ferait
  //partie d'une période déclarée non déverrouillable
  if result.PeriodeVerrouillee=false then
    begin//si on n'a pas déjà trouvé que la période était verrouillée à cause d'un pointage dans une période déclarée
      Requete_H_TVA.close;
      Requete_H_TVA.SQL.clear;
      Requete_H_TVA.SQL.Add('select  max(fin_Periode)as resultat from h_tva where En_Attente=false and ID_Declaration<>0 ');
      Requete_H_TVA.open;

      Requete_H_PieceTVA.close;
      Requete_H_PieceTVA.SQL.clear;
      Requete_H_PieceTVA.SQL.Add('select  max(fin_Periode)as resultat from h_Piecetva where  ((ID_Declaration<>0)or(Divers_Str=''Cloture'')) ');
      Requete_H_PieceTVA.open;

      if ((Requete_H_TVA.RecordCount>0)and(Requete_H_TVA.findfield('resultat').asdatetime<>0)) then
//      if Requete_H_TVA.RecordCount>0 then
        begin //si on trouve une date de fin_période dans H_Tva
        //vérif sur H_TVA
        Result.PeriodeVerrouillee:=DateDsIntervale(0,DatePiece,Requete_H_TVA.findfield('resultat').asdatetime,MessageLGR);
        if not Result.PeriodeVerrouillee then
          begin
          //vérif sur H_PieceTVA
          if Requete_H_PieceTVA.RecordCount>0 then
             Result.PeriodeVerrouillee:=DateDsIntervale(0,DatePiece,Requete_H_PieceTVA.findfield('resultat').asdatetime,MessageLGR);
          end;
        if Result.PeriodeVerrouillee then
          begin //vérif sur H_TVA
            Requete_H_TVA.close;
            Requete_H_TVA.SQL.clear;
            Requete_H_TVA.SQL.Add('select fin_periode from h_tva where en_attente=false and  ID_Declaration<>0 and deverrouillable=false order by fin_periode ');
            Requete_H_TVA.open;
            if Requete_H_TVA.RecordCount<>0 then
            begin
              Requete_H_TVA.first;
              while ((result.PeriodeDeverrouillable)and (not(Requete_H_TVA.EOF)))  do
                begin
                  result.PeriodeDeverrouillable:=DatePiece>Requete_H_TVA.FindField('fin_periode').asdatetime;
                  Requete_H_TVA.next;
                end;
            end;
          end;//fin vérif sur H_TVA
        if not Result.PeriodeDeverrouillable then
          begin //vérif sur H_PieceTVA
            Requete_H_PieceTVA.close;
            Requete_H_PieceTVA.SQL.clear;
            Requete_H_PieceTVA.SQL.Add('select fin_periode from h_Piecetva where  ((ID_Declaration<>0)or(Divers_Str=''Cloture'')) and deverrouillable=false order by fin_periode ');
            Requete_H_PieceTVA.open;
            if Requete_H_PieceTVA.RecordCount<>0 then
            begin
              Requete_H_PieceTVA.first;
              while ((result.PeriodeDeverrouillable)and (not(Requete_H_PieceTVA.EOF)))  do
                begin
                  result.PeriodeDeverrouillable:=DatePiece>Requete_H_PieceTVA.FindField('fin_periode').asdatetime;
                  Requete_H_PieceTVA.next;
                end;
            end;
          end;//fin vérif sur H_PieceTVA

        end;//fin si on trouve une date de fin_période dans H_Tva
    end;//fin si on n'a pas déjà trouvé que la période était verrouillée à cause d'un pointage dans une période déclarée

  //TODO est-ce que l'on peut pointer une pièce d'achat d'une période déclarée avec tva sur E avec une pièce de banque d'une période déclarée aussi
  //dans ce cas, le programme ne dit rien, mais par contre, après on arrive plus à le supprimer car il considère qu'il fait partie d'une déclaration

  // Recherche pour savoir si la piece fait partie d'une déclaration TVA
  Requete_Pointage.SQL.Clear;
  Requete_Pointage.SQL.Add('select e.id,sum (Montant)as MontantPointe ');
  Requete_Pointage.SQL.Add(' ,(select count(e3.id) from ecriture e3 where e3.id_piece=e.id_piece and exists');
  Requete_Pointage.SQL.Add(' (select id_ecriture from h_tva where id_ecriture=e3.id and ');
  Requete_Pointage.SQL.Add(' ID_Declaration<>0 and En_Attente=false and deverrouillable = false))as deverouillable');
  Requete_Pointage.SQL.Add(' ,(select count(e3.id) from ecriture e3 where e3.id_piece=e.id_piece and exists');
  Requete_Pointage.SQL.Add(' (select id_ecriture from h_tva where id_ecriture=e3.id and ');
  Requete_Pointage.SQL.Add(' ID_Declaration<>0 and En_Attente=false))as id_declare');
  Requete_Pointage.SQL.Add('from pointage P');
  Requete_Pointage.SQL.Add(' join ecriture e on (e.id =P.id_credit)');
  Requete_Pointage.SQL.Add(' join piece pi on (pi.id=e.id_piece)');
  Requete_Pointage.SQL.Add(' where (id_credit=:idCredit )');
  Requete_Pointage.SQL.Add(' and exists(select id from ecriture e2 where e2.tvatype=''E'' and e2.id_piece=pi.id)');
  Requete_Pointage.SQL.Add(' and (Pointage."TvaDate" between :DateDebCredit and :DateFinCredit)');
  Requete_Pointage.SQL.Add(' and id_debit=:idDebit');
  Requete_Pointage.SQL.Add(' group by e.id');
  Requete_Pointage.SQL.Add(' having sum(montant)<>0');
  Requete_Pointage.SQL.Add(' union ');
  Requete_Pointage.SQL.Add(' select e.id,sum (Montant)as MontantPointe ');
  Requete_Pointage.SQL.Add(' ,(select count(e3.id) from ecriture e3 where e3.id_piece=e.id_piece and exists');
  Requete_Pointage.SQL.Add(' (select id_ecriture from h_tva where id_ecriture=e3.id and ');
  Requete_Pointage.SQL.Add(' ID_Declaration<>0 and En_Attente=false and deverrouillable = false))as deverouillable');
  Requete_Pointage.SQL.Add(' ,(select count(e3.id) from ecriture e3 where e3.id_piece=e.id_piece and exists');
  Requete_Pointage.SQL.Add(' (select id_ecriture from h_tva where id_ecriture=e3.id and ');
  Requete_Pointage.SQL.Add(' ID_Declaration<>0 and En_Attente=false))as id_declare');
  Requete_Pointage.SQL.Add('from pointage P');
  Requete_Pointage.SQL.Add(' join ecriture e on (e.id =P.id_debit)');
  Requete_Pointage.SQL.Add(' join piece pi on (pi.id=e.id_piece)');
  Requete_Pointage.SQL.Add(' where (id_debit=:idDebit )');
  Requete_Pointage.SQL.Add(' and exists(select id from ecriture e2 where e2.tvatype=''E'' and e2.id_piece=pi.id)');
  Requete_Pointage.SQL.Add(' and (Pointage."Date" between :DateDebDebit and :DateFinDebit)');
  Requete_Pointage.SQL.Add(' and id_credit=:idCredit');
  Requete_Pointage.SQL.Add(' group by e.id');
  Requete_Pointage.SQL.Add(' having sum(montant)<>0');
  Requete_Pointage.ParamByName('idCredit').AsInteger:=infosCredit.ID;
  Requete_Pointage.ParamByName('DateDebCredit').Asdatetime :=infosCredit.Date;
  Requete_Pointage.ParamByName('DateFinCredit').Asdatetime :=infosCredit.Date;
  Requete_Pointage.ParamByName('idDebit').AsInteger :=infosDebit.ID;
  Requete_Pointage.ParamByName('DateDebDebit').Asdatetime :=infosDebit.Date;
  Requete_Pointage.ParamByName('DateFinDebit').Asdatetime :=infosDebit.Date;
  if Requete_H_PieceTVA.RecordCount<>0 then
    begin
      Requete_Pointage.ParamByName('DateFinCredit').Asdatetime :=Requete_H_PieceTVA.findfield('resultat').asdatetime;
      Requete_Pointage.ParamByName('DateFinDebit').Asdatetime :=Requete_H_PieceTVA.findfield('resultat').asdatetime;
    end;
  Requete_Pointage.Prepare;
  Requete_Pointage.Open;
  Result.PieceVerrouillee:=((Requete_Pointage.RecordCount>0)and(Requete_Pointage.FindField('id_declare').AsInteger>0));
  if Result.PieceVerrouillee then
    result.Deverrouillable:=Requete_Pointage.FindField('deverouillable').AsInteger<1;
//  FiltrageDataSet(DMRech.TaH_TVARech,'En_Attente=faux and ID_Declaration<>0 and id_piece='+inttostr(IDPiece));
//  Result.PieceVerrouillee:=DMRech.TaH_TVARech.RecordCount>0;

//  // Recherche pour savoir si la piece est non dévérrouillable
//  // cad qu'elle fait partie d'une déclaration antérieure à la dernière déclaration
//  // non dévérouillable
//  FiltrageDataSet(DMRech.TaH_TVARech,'id_piece='+inttostr(IDPiece)+' and ID_Declaration<>0 and En_Attente=faux and deverrouillable = faux ');
//  Result.Deverrouillable:=DMRech.TaH_TVARech.RecordCount=0;
  except
    abort;
  end;//fin du try except
  finally
     if Requete_H_TVA<>nil then Requete_H_TVA.Free;
     if Requete_H_PieceTVA<>nil then Requete_H_PieceTVA.Free;
     if Requete_Pointage <> nil then Requete_Pointage.Free;
  end;//fin du try finally
End;

procedure TPiece.InitialiseInfosVerrouillage(var Verrou:TVerrouillage);
Begin
Verrou.Deverrouillable:=true;
verrou.PeriodeVerrouillee:=false;
verrou.PeriodeDeverrouillable:=true;
verrou.PieceVerrouillee:=false;
End;


procedure TPiece.FiltrageTablePieceSurPieceAnterieure(Anterieure:boolean);
Begin
if not TablePiece.active then
TablePiece.open;
TablePiece.Filtered:=false;
  if anterieure then
    TablePiece.Filter:='ID<''0'''
  else
    TablePiece.Filter:='ID>=''0''';
TablePiece.Filtered:=true;
End;

////////////  ** Objet Trame **  ///////////

procedure TTrame.NouvelleTrame(Partiel:boolean);
Begin
if not partiel then
  Begin//si
    FCodeTrame:='';
    FLibelleTrame:='';
    FIDTrame:=0;
    FTrameACharger:=false;
  End;//fin si
if FTableTrame = nil then
begin
  FTableTrame:=TTable.Create(Application.MainForm);
  FTableTrame.TableName:=DMRech.TaTrameRech.TableName;
  FTableTrame.DatabaseName:=DMRech.TaTrameRech.DatabaseName;
  FTableTrame.Open;
end;
if FTableTrame_Ligne = nil then
begin
  FTableTrame_Ligne:=TTable.Create(Application.MainForm);
  FTableTrame_Ligne.TableName:=DMRech.TaTrameLRech.TableName;
  FTableTrame_Ligne.DatabaseName:=DMRech.TaTrameLRech.DatabaseName;
  //FTableTrame_Ligne.Open;
end;
FCptBanque:='';
FCptRepartition:='';
FLibelleRepartition:='';
FTauxRepartition:=0;
FConserveQte:=true;
FConserveMontant:=true;
FIDTrame_Ligne:=0;
FErreurTrame.Erreur.NumErreur:=0;
FErreurTrame.Erreur.retour:=true;
FErreurTrame.Id_Piece:=0;
FErreurTrame.Mess:='';
 if Assigned(FOnNewTrame) then FOnNewTrame(Self);
End;


Constructor TTrame.Create(AOwner :TComponent);
begin
inherited create(AOwner);
end;

Destructor TTrame.Destroy;
begin
inherited destroy;
end;


procedure TTrame.Loaded;
Begin
inherited loaded;
//NouvelleTrame;
End;

function TTrame.NewID(TableRef:TTable;ChampRech:string):integer;
var
QueryRech:TQuery;
Begin
  try
  QueryRech:=TQuery.Create(self);
  QueryRech.DatabaseName:=TableRef.DatabaseName;
  QueryRech.SQL.Add('Select Max('+ChampRech+') as resultat from ' +TableRef.TableName+'');
  QueryRech.open;
  result:=QueryRech.findfield('resultat').asinteger+1;
  finally
    QueryRech.free;
  end;//fin du try finally
End;


Function CopieContenuTrame(Source,Dest:TTrame;AvecCreation:boolean):boolean;
var
VarErreurTrame:TExceptLGR_ImportPiece;
ExceptLGRTmp:TExceptLGR;
Begin
try
if source<>nil then
begin //si source <>nil
if ((dest=nil)and(AvecCreation)) then
  dest:=TTrame.create(application.MainForm);
if Dest=nil then exit;
  Dest.IDTrame:=Source.IDTrame;
  Dest.CodeTrame:=Source.CodeTrame;
  Dest.LibelleTrame:=Source.LibelleTrame;
  Dest.LibellePiece:=Source.LibellePiece;
  Dest.ConserveMontant:=Source.ConserveMontant;
  Dest.ConserveQte:=Source.ConserveQte;
  Dest.CptRepartition:=Source.CptRepartition;
  Dest.LibelleRepartition:=Source.LibelleRepartition;
  Dest.TauxRepartition:=Source.TauxRepartition;
  Dest.CptBanque:=Source.CptBanque;
  Dest.IDTrame_Ligne:=Source.IDTrame_Ligne;
  Dest.TrameACharger:=Source.TrameACharger;
  Dest.TableTrame:=Source.TableTrame;
  Dest.TableTrame_Ligne:=Source.TableTrame_Ligne;
//
  Initialise_ExceptLGR(VarErreurTrame.Erreur,nil);
  VarErreurTrame.Erreur.GestMessageLGR:=TGestMessageLGR.Create(application.MainForm);
  if Source.ErreurTrame.Erreur.GestMessageLGR<>nil then
    Source.ErreurTrame.Erreur.GestMessageLGR.CopieContenu_GestMEssageLGR(Source.ErreurTrame.Erreur.GestMessageLGR,VarErreurTrame.Erreur.GestMessageLGR);
//
  VarErreurTrame.Erreur.Mess:=Source.ErreurTrame.Erreur.Mess;
  VarErreurTrame.Erreur.NomDossier:=Source.ErreurTrame.Erreur.NomDossier;
  VarErreurTrame.Erreur.NomModule:=Source.ErreurTrame.Erreur.NomModule;
  VarErreurTrame.Erreur.NumErreur:=Source.ErreurTrame.Erreur.NumErreur;
  VarErreurTrame.Erreur.retour:=Source.ErreurTrame.Erreur.retour;
  VarErreurTrame.Id_Piece:=Source.ErreurTrame.Id_Piece;
  VarErreurTrame.Mess:=Source.ErreurTrame.Mess;
  Dest.ErreurTrame:=VarErreurTrame;
end;//fin si source <>nil
////
except
  showmessage('Erreur Interne sur CopieContenuTrame : ');
end;
end;


Function CopieContenuTrame_DansFichier(Source:TTrame;NomFichier:string):Tstringlist;
var
VarErreurTrame:TExceptLGR_ImportPiece;
Begin
try
if source<>nil then
begin //si source <>nil
Result:=Tstringlist.create;
  Result.add(source.Name);
  Result.Add('IDTrame = '+inttostr(Source.IDTrame));
  Result.Add('CodeTrame = '+Source.CodeTrame);
  Result.Add('LibelleTrame = '+Source.LibelleTrame);
  Result.Add('LibellePiece = '+Source.LibellePiece);
  Result.Add('ConserveMontant = '+str_bool2str(Source.ConserveMontant));
  Result.Add('ConserveQte = '+str_bool2str(Source.ConserveQte));
  Result.Add('CptRepartition = '+Source.CptRepartition);
  Result.Add('LibelleRepartition = '+Source.LibelleRepartition);
  Result.Add('TauxRepartition = '+currtostr(Source.TauxRepartition));
  Result.Add('CptBanque = '+Source.CptBanque);
  Result.Add('IDTrame_Ligne = '+inttostr(Source.IDTrame_Ligne));
  Result.Add('TrameACharger = '+str_bool2str(Source.TrameACharger));
    if source.TableTrame=nil then
      Result.Add('TableTrame = Nil')
    else
      Result.Add('TableTrame = '+source.TableTrame.TableName);
    if source.TableTrame_Ligne=nil then
      Result.Add('TableTrame_Ligne = Nil')
    else
      Result.Add('TableTrame_Ligne = '+source.TableTrame_Ligne.TableName);
//
  Result.Add('ErreurTrame.Erreur.Mess = '+Source.ErreurTrame.Erreur.Mess);
  Result.Add('ErreurTrame.Erreur.NomDossier = '+Source.ErreurTrame.Erreur.NomDossier);
  Result.Add('ErreurTrame.Erreur.NomModule = '+Source.ErreurTrame.Erreur.NomModule);
  Result.Add('ErreurTrame.Erreur.NumErreur = '+inttostr(Source.ErreurTrame.Erreur.NumErreur));
  Result.Add('ErreurTrame.Erreur.retour = '+str_bool2str(Source.ErreurTrame.Erreur.retour));
  Result.Add('ErreurTrame.Id_Piece = '+inttostr(Source.ErreurTrame.Id_Piece));
  Result.Add('ErreurTrame.Mess = '+Source.ErreurTrame.Mess);
  Result.Add('--------------------');
    if empty(nomfichier)then nomfichier:='C:\Projet\Epicea-2\Execution\Exportation\Piece_Courante.txt';
    Result.SaveToFile(nomfichier);
end;//fin si source <>nil
////
except
  showmessage('Erreur Interne sur CopieContenuTrame_DansFichier : ');
end;
end;


//fin des trames



function TPiece.RetourneInfosEtatVersementSurPiece(IDPiece:integer;DatePiece:Tdatetime):TVerrouillage;
Begin
  InitialiseInfosVerrouillage(result);
End;


procedure TPiece.initialiseValPieceAutoGen(var ValPieceAutoGen:TValPieceAutoGenere);
Begin
ValPieceAutoGen.Champ_Gen:='';
ValPieceAutoGen.Table_Gen:='';
ValPieceAutoGen.TableGen:=false;
ValPieceAutoGen.Val_Champ_Gen:='';
End;

Procedure TPiece.StateChange(Piece:TPiece);
begin
if Assigned(FOnStateChange) then FOnStateChange(FEtatPiece);
end;


procedure TPiece.setEtatPiece(Etat:TDataSetState);
Begin
 FEtatPiece:=Etat;
 StateChange(self);
End;


function TPiece.CalculsoldePiece(Piece:Tpiece):TInfos_Piece;
var
i:integer;
Begin
initialise_TInfos_Piece(result);
  if ListeEcritures<>nil then
    Begin
      for i:=0 to ListeEcritures.Count-1 do
        Begin
          case TEcriture_Isa(ListeEcritures.Objects[i]).SensEcriture of
            1:result.Total.Credit:=result.Total.Credit+TEcriture_Isa(ListeEcritures.Objects[i]).SoldeEcriture;
           -1:result.Total.Debit:=result.Total.Debit+TEcriture_Isa(ListeEcritures.Objects[i]).SoldeEcriture;
          end;//fin du case sensecriture
        End;
      result.Total.Solde:=abs(result.Total.Debit-result.Total.Credit);
      if result.Total.Debit>result.Total.Credit then
        result.SensSolde:=-1
      else
        if result.Total.Debit<result.Total.Credit then
          result.SensSolde:=1;
    End;
End;


procedure Tpiece.SuppressionObjetPiece(Piece:Tpiece);
var
i:integer;
Begin
  if piece<>nil then
    Begin//si piece existante
      if piece.ListeEcritures<>nil then
        Begin//si liste ecritures existante
           for i:=0 to piece.ListeEcritures.Count-1 do
             Begin//Début boucle for
                if piece.ListeEcritures.Objects[i]<>nil then
                  Begin
                    piece.ListeEcritures.Objects[i].Free;
                    piece.ListeEcritures.Objects[i]:=nil;
                  End;
             End;//fin boucle for
        End;//fin si liste ecritures existante
    piece.Free;
    piece:=nil;
    End;//fin si piece existante
End;



//cette fonction récupère des infos sur les 2 pièces en cours de pointage. si une des pièces contient de la tva sur E et
//que la date pièce de l'autre est dans une période déclarée,
//ou que celle qui contient de la tva sur E n'est pas tout simplement verrouillée (c'est à dire qu'elle fasse elle-même partie d'une déclaration)
//si verrouillée, on doit regarder si on peut supprimer la dernière déclaration ou empêcher la
//modification de ce pointage. et vice versa
//cette fonction est appelé dans "Piece" dans la fonction "RetourneInfosVerrouillageSurPiece"
//Le paramètre "Suppression" sert à savoir si la vérif porte sur un l'enregitrement d'un nouveau pointage,
//ou la suppression d'un pointage existant
function TPiece.Verification_TvaDeclare_Pointage(Suppression:boolean;IDEcriture_Debit,IDEcriture_Credit:integer):TerreurTva;
var
TvaSurEDebit,TvaSurECredit:boolean;
infosDebit,infosCredit:TInfosEcriture;
infosVerrouillage:TVerrouillage;
PartieMessage:string;
PieceMaitre:boolean;
Begin//si

TvaSurEDebit:=false;
TvaSurECredit:=false;
result.CodeErreur:=0;
result.Retour:=true;
result.Messages:='';
result.SupprODDecl:=false;
result.Continuer:=true;

DMRech.TaEcritureRech.Refresh;
DMRech.TaPieceRech.Refresh;
DMRech.TaResteDCRech.Refresh;

DeFiltrageDataSet(DMRech.TaEcritureRech);
defiltrageDataset(dmrech.TaPieceRech);
infosDebit:=Infos_TInfosEcriture(DMRech.TaEcritureRech,'id',[IDEcriture_Debit]);
infosCredit:=Infos_TInfosEcriture(DMRech.TaEcritureRech,'id',[IDEcriture_Credit]);
//on Traite la pièce côté Débit et on regarde si la pièce coté credit contient de la tva sur E
FiltrageDataSet(DMRech.TaEcritureRech,'TypeLigne<>''T'' and TvaType=''E''  and TvaCode is not null and id_Piece = '+inttostr(infosDebit.ID_Piece));
if DMRech.TaEcritureRech.recordcount>0 then
  //si la pièce coté credit contient de la tva sur E
  TvaSurEDebit:=IDEcriture_Debit<>DMRech.TaEcritureRech.FindField('ID').asinteger;
PartieMessage:='pointage entre les pièces :'+Infos_TInfosPiece(dmrech.TaPieceRech,'ID',[infosDebit.ID_Piece]).Reference+' et '+Infos_TInfosPiece(dmrech.TaPieceRech,'ID',[infosCredit.ID_Piece]).Reference;
if TvaSurEDebit then
begin
InitialiseInfosVerrouillage(infosVerrouillage);
//on récupère les infosverrouillage de la pièce avec la date de la pièce opposée
//pour à la fois voir si la pièce au débit est verrouillée et si la date de la pièce opposée est dans une période verrouillée
infosVerrouillage:=RetourneInfosVerrouillageSurPiece(nil,infosDebit.ID_Piece,infosCredit.Date);
if Suppression then
  Begin//si verif avant suppression d'un pointage
    if infosVerrouillage.PieceVerrouillee then
      Begin//si pièce fait partie du déclaration tva
        if infosVerrouillage.Deverrouillable then
          Begin//si déclaration supprimable
            result.Retour:=false;
            result.Messages:='Si vous supprimez le '+PartieMessage+', la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
            result.SupprODDecl:=true;
          End//fin si déclaration supprimable
        else
          Begin//si déclaration non deverrouillable
            result.Retour:=false;
            result.Messages:='Le '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, vous ne pouvez pas supprimer ce pointage';
            result.SupprODDecl:=false;
            result.Continuer:=false;
          End;//fin si déclaration non deverrouillable
      End//fin si pièce fait partie du déclaration tva
    else
    if infosVerrouillage.PeriodeVerrouillee then
      Begin//si pièce fait partie du déclaration tva
        if infosVerrouillage.PeriodeDeverrouillable then
          Begin//si déclaration supprimable
            //result.CodeErreur:=
            result.Retour:=false;
            result.Messages:='Si vous supprimez le '+PartieMessage+' la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
            result.SupprODDecl:=true;
          End//fin si déclaration supprimable
        else
          Begin//si déclaration non deverrouillable
            result.Retour:=false;
            result.Messages:='Le '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, vous ne pouvez pas supprimer ce pointage';
            result.SupprODDecl:=false;
            result.Continuer:=false;
          End;//fin si déclaration non deverrouillable
      End;//fin si pièce fait partie du déclaration tva
  End//fin si verif avant suppression d'un pointage
else
  Begin//si verif avant ajout d'un pointage
    if infosVerrouillage.PeriodeVerrouillee then
      Begin//si date fait partie d'une période déclarée
        if infosVerrouillage.PeriodeDeverrouillable then
          Begin//si déclaration supprimable
            result.Retour:=false;
            result.Messages:='Si vous créez le '+PartieMessage+' la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
            result.SupprODDecl:=true;
          End//fin si déclaration supprimable
        else
          Begin//si déclaration non deverrouillable
            result.Retour:=false;
            result.Messages:='La date du '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, si vous créez ce pointage, la TVA sera déclarée dans la prochaine période de tva, voulez-vous continuer ?';
          End;//fin si déclaration non deverrouillable
      End;//fin si date fait partie d'une période déclarée
  End;//fin si verif avant ajout d'un pointage
end;//fin si trouvé de la tva sur E dans pièce débit
if result.Continuer then
  Begin//si
    //on Traite la pièce côté credit et on regarde si la pièce coté débit contient de la tva sur E
    FiltrageDataSet(DMRech.TaEcritureRech,'TypeLigne<>''T'' and TvaType=''E'' and TvaCode is not null and id_Piece = '+inttostr(infosCredit.ID_Piece));
    if DMRech.TaEcritureRech.recordcount>0 then
    ///i la pièce coté débit contient de la tva sur E
      TvaSurECredit:=IDEcriture_Credit<>DMRech.TaEcritureRech.FindField('ID').asinteger;
    if TvaSurECredit then
      begin
      InitialiseInfosVerrouillage(infosVerrouillage);
      //on récupère les infosverrouillage de la pièce opposée
      //pour à la fois voir si la pièce au credit est verrouillée et si la date de la pièce opposée est dans une période verrouillée
      infosVerrouillage:=RetourneInfosVerrouillageSurPiece(nil,infosCredit.ID_Piece,infosDebit.Date);
      if Suppression then
        Begin//si verif avant suppression d'un pointage
          if infosVerrouillage.PieceVerrouillee then
            Begin//si pièce fait partie du déclaration tva
              if infosVerrouillage.Deverrouillable then
                Begin//si déclaration supprimable
                  result.Retour:=false;
                  result.Messages:='Si vous supprimez le '+PartieMessage+', la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
                  result.SupprODDecl:=true;
                End//fin si déclaration supprimable
              else
                Begin//si déclaration non deverrouillable
                  result.Retour:=false;
                  result.Messages:='Le '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, vous ne pouvez pas supprimer ce pointage';
                  result.SupprODDecl:=false;
                  result.Continuer:=false;
                End;//fin si déclaration non deverrouillable
            End//fin si pièce fait partie du déclaration tva
          else
          if infosVerrouillage.PeriodeVerrouillee then
            Begin//si pièce fait partie du déclaration tva
              if infosVerrouillage.PeriodeDeverrouillable then
                Begin//si déclaration supprimable
                  //result.CodeErreur:=
                  result.Retour:=false;
                  result.Messages:='Si vous supprimez le '+PartieMessage+',la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
                  result.SupprODDecl:=true;
                End//fin si déclaration supprimable
              else
                Begin//si déclaration non deverrouillable
                  result.Retour:=false;
                  result.Messages:='Le '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, vous ne pouvez pas supprimer ce pointage';
                  result.SupprODDecl:=false;
                  result.Continuer:=false;
                End;//fin si déclaration non deverrouillable
            End;//fin si pièce fait partie du déclaration tva
        End//fin si verif avant suppression d'un pointage
      else
        Begin//si verif avant ajout d'un pointage
          if infosVerrouillage.PeriodeVerrouillee then
            Begin//si date fait partie d'une période déclarée
              if infosVerrouillage.PeriodeDeverrouillable then
                Begin//si déclaration supprimable
                  result.Retour:=false;
                  result.Messages:='Si vous créez le '+PartieMessage+',la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
                  result.SupprODDecl:=true;
                End//fin si déclaration supprimable
              else
                Begin//si déclaration non deverrouillable
                  result.Retour:=false;
                  result.Messages:='La date du '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, si vous créez ce pointage, la TVA sera déclarée dans la prochaine période de tva, voulez-vous continuer ?';
                End;//fin si déclaration non deverrouillable
            End;//fin si date fait partie d'une période déclarée
        End;//fin si verif avant ajout d'un pointage
      end;//fin si tva sur E trouvé dans pièce Credit
  End;//fin si
End;//fin si


function TPiece.Verification_TvaDeclare_Pointage_new(Suppression:boolean;IDEcriture_Debit,IDEcriture_Credit:integer):TerreurTva;
var
TvaSurEDebit,TvaSurECredit:boolean;
infosDebit,infosCredit:TInfosEcriture;
infosVerrouillage:TVerrouillage;
PartieMessage:string;
PieceMaitre:boolean;
Begin//si

TvaSurEDebit:=false;
TvaSurECredit:=false;
result.CodeErreur:=0;
result.Retour:=true;
result.Messages:='';
result.SupprODDecl:=false;
result.Continuer:=true;

DMRech.TaEcritureRech.Refresh;
DMRech.TaPieceRech.Refresh;
DMRech.TaResteDCRech.Refresh;

DeFiltrageDataSet(DMRech.TaEcritureRech);
defiltrageDataset(dmrech.TaPieceRech);
infosDebit:=Infos_TInfosEcriture(DMRech.TaEcritureRech,'id',[IDEcriture_Debit]);
infosCredit:=Infos_TInfosEcriture(DMRech.TaEcritureRech,'id',[IDEcriture_Credit]);
//on Traite la pièce côté Débit et on regarde si la pièce coté credit contient de la tva sur E
FiltrageDataSet(DMRech.TaEcritureRech,'TypeLigne<>''T'' and TvaType=''E''  and TvaCode is not null and id_Piece = '+inttostr(infosDebit.ID_Piece));
if DMRech.TaEcritureRech.recordcount>0 then
  //si la pièce coté credit contient de la tva sur E
  TvaSurEDebit:=IDEcriture_Debit<>DMRech.TaEcritureRech.FindField('ID').asinteger;
PartieMessage:='pointage entre les pièces :'+Infos_TInfosPiece(dmrech.TaPieceRech,'ID',[infosDebit.ID_Piece]).Reference+' et '+Infos_TInfosPiece(dmrech.TaPieceRech,'ID',[infosCredit.ID_Piece]).Reference;
if TvaSurEDebit then
begin
InitialiseInfosVerrouillage(infosVerrouillage);
//on récupère les infosverrouillage de la pièce avec la date de la pièce opposée
//pour à la fois voir si la pièce au débit est verrouillée et si la date de la pièce opposée est dans une période verrouillée
infosVerrouillage:=RetourneInfosVerrouillageSurPointage(nil,infosDebit.ID_Piece,infosDebit,infosCredit);
//infosVerrouillage:=RetourneInfosVerrouillageSurPiece(nil,infosDebit.ID_Piece,infosCredit.Date);
if Suppression then
  Begin//si verif avant suppression d'un pointage
    if infosVerrouillage.PieceVerrouillee then
      Begin//si pièce fait partie du déclaration tva
        if infosVerrouillage.Deverrouillable then
          Begin//si déclaration supprimable
            result.Retour:=false;
            result.Messages:='Si vous supprimez le '+PartieMessage+', la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
            result.SupprODDecl:=true;
          End//fin si déclaration supprimable
        else
          Begin//si déclaration non deverrouillable
            result.Retour:=false;
            result.Messages:='Le '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, vous ne pouvez pas supprimer ce pointage';
            result.SupprODDecl:=false;
            result.Continuer:=false;
          End;//fin si déclaration non deverrouillable
      End//fin si pièce fait partie du déclaration tva
    else
    if infosVerrouillage.PeriodeVerrouillee then
      Begin//si pièce fait partie du déclaration tva
        if infosVerrouillage.PeriodeDeverrouillable then
          Begin//si déclaration supprimable
            //result.CodeErreur:=
            result.Retour:=false;
            result.Messages:='Si vous supprimez le '+PartieMessage+' la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
            result.SupprODDecl:=true;
          End//fin si déclaration supprimable
        else
          Begin//si déclaration non deverrouillable
            result.Retour:=false;
            result.Messages:='Le '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, vous ne pouvez pas supprimer ce pointage';
            result.SupprODDecl:=false;
            result.Continuer:=false;
          End;//fin si déclaration non deverrouillable
      End;//fin si pièce fait partie du déclaration tva
  End//fin si verif avant suppression d'un pointage
else
  Begin//si verif avant ajout d'un pointage
    if infosVerrouillage.PeriodeVerrouillee then
      Begin//si date fait partie d'une période déclarée
        if infosVerrouillage.PeriodeDeverrouillable then
          Begin//si déclaration supprimable
            result.Retour:=false;
            result.Messages:='Si vous créez le '+PartieMessage+' la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
            result.SupprODDecl:=true;
          End//fin si déclaration supprimable
        else
          Begin//si déclaration non deverrouillable
            result.Retour:=false;
            result.Messages:='La date du '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, si vous créez ce pointage, la TVA sera déclarée dans la prochaine période de tva, voulez-vous continuer ?';
          End;//fin si déclaration non deverrouillable
      End;//fin si date fait partie d'une période déclarée
  End;//fin si verif avant ajout d'un pointage
end;//fin si trouvé de la tva sur E dans pièce débit
if result.Continuer then
  Begin//si
    //on Traite la pièce côté credit et on regarde si la pièce coté débit contient de la tva sur E
    FiltrageDataSet(DMRech.TaEcritureRech,'TypeLigne<>''T'' and TvaType=''E'' and TvaCode is not null and id_Piece = '+inttostr(infosCredit.ID_Piece));
    if DMRech.TaEcritureRech.recordcount>0 then
    ///i la pièce coté débit contient de la tva sur E
      TvaSurECredit:=IDEcriture_Credit<>DMRech.TaEcritureRech.FindField('ID').asinteger;
    if TvaSurECredit then
      begin
      InitialiseInfosVerrouillage(infosVerrouillage);
      //on récupère les infosverrouillage de la pièce opposée
      //pour à la fois voir si la pièce au credit est verrouillée et si la date de la pièce opposée est dans une période verrouillée
        infosVerrouillage:=RetourneInfosVerrouillageSurPointage(nil,infosCredit.ID_Piece,infosDebit,infosCredit);
//      infosVerrouillage:=RetourneInfosVerrouillageSurPiece(nil,infosCredit.ID_Piece,infosDebit.Date);
      if Suppression then
        Begin//si verif avant suppression d'un pointage
          if infosVerrouillage.PieceVerrouillee then
            Begin//si pièce fait partie du déclaration tva
              if infosVerrouillage.Deverrouillable then
                Begin//si déclaration supprimable
                  result.Retour:=false;
                  result.Messages:='Si vous supprimez le '+PartieMessage+', la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
                  result.SupprODDecl:=true;
                End//fin si déclaration supprimable
              else
                Begin//si déclaration non deverrouillable
                  result.Retour:=false;
                  result.Messages:='Le '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, vous ne pouvez pas supprimer ce pointage';
                  result.SupprODDecl:=false;
                  result.Continuer:=false;
                End;//fin si déclaration non deverrouillable
            End//fin si pièce fait partie du déclaration tva
          else
          if infosVerrouillage.PeriodeVerrouillee then
            Begin//si pièce fait partie du déclaration tva
              if infosVerrouillage.PeriodeDeverrouillable then
                Begin//si déclaration supprimable
                  //result.CodeErreur:=
                  result.Retour:=false;
                  result.Messages:='Si vous supprimez le '+PartieMessage+',la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
                  result.SupprODDecl:=true;
                End//fin si déclaration supprimable
              else
                Begin//si déclaration non deverrouillable
                  result.Retour:=false;
                  result.Messages:='Le '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, vous ne pouvez pas supprimer ce pointage';
                  result.SupprODDecl:=false;
                  result.Continuer:=false;
                End;//fin si déclaration non deverrouillable
            End;//fin si pièce fait partie du déclaration tva
        End//fin si verif avant suppression d'un pointage
      else
        Begin//si verif avant ajout d'un pointage
          if infosVerrouillage.PeriodeVerrouillee then
            Begin//si date fait partie d'une période déclarée
              if infosVerrouillage.PeriodeDeverrouillable then
                Begin//si déclaration supprimable
                  result.Retour:=false;
                  result.Messages:='Si vous créez le '+PartieMessage+',la dernière déclaration TVA sera supprimée, voulez-vous continuer ? ';
                  result.SupprODDecl:=true;
                End//fin si déclaration supprimable
              else
                Begin//si déclaration non deverrouillable
                  result.Retour:=false;
                  result.Messages:='La date du '+PartieMessage+' fait partie d''une déclaration TVA non deverrouillable, si vous créez ce pointage, la TVA sera déclarée dans la prochaine période de tva, voulez-vous continuer ?';
                End;//fin si déclaration non deverrouillable
            End;//fin si date fait partie d'une période déclarée
        End;//fin si verif avant ajout d'un pointage
      end;//fin si tva sur E trouvé dans pièce Credit
  End;//fin si
End;//fin si


function TPiece.Recup_DateTva_Valide(Var TvaDate:String):TDetailDate;
Begin
initialiserDetailDate(result);
if DateValide(tvadate)then
  Begin

  End
else
  Begin

  end;
End;


Procedure TPiece.SetCompte(compteSaisie:string);
var
valide:boolean;
MessDerSub:boolean;
Begin
DMPieces.GestionFiltrageParamCpt;
MessDerSub:=false;
if not empty(compteSaisie) then
  begin//si compte rempli
    valide:= AideCompteDansContexte(compteSaisie,nil,['Rac1'],false,MessDerSub,false,true,true,true,0);
    if valide then valide:=not DMPieces.CptExclusDeContexte(compteSaisie,1);
    if valide then
      if copy(compteSaisie,1,1)='4'then
        valide:=DMPlan.CptEstPointable(compteSaisie);
  end; //fin si compte rempli
if valide then Fcompte:=compteSaisie;
MessDerSub:=true;
end;


Function TPiece.GetCompte:string;
Begin
  result:=Fcompte;
end;


Function CopieContenuPiece(Source,Dest:TPiece;AvecCreation:boolean):boolean;
var
VarAnneePiece:TPieceAnterieure;
VarInfosPointage:TPointage;
VarInfosVerrouillage:TVerrouillage;
VarValPieceAutoGen:TValPieceAutoGenere;
Begin
try
if ((Dest=nil)and(AvecCreation)) then
  Dest:=TPiece.Create(application.MainForm);

if Dest=nil then exit;

    AssignStringListeEX(source.ListeEcritures,dest.ListeEcritures);
    CopieContenuTrame(source.Trame,dest.Trame,AvecCreation);
    Dest.Defaut:=source.Defaut;
    Dest.TVA_A_Gerer:=source.TVA_A_Gerer;
    Dest.DateDebutExo:=source.DateDebutExo;
    Dest.DateFinExo:=source.DateFinExo;
    Dest.CodeExo:=source.CodeExo;
//
    VarAnneePiece.ExoAnterieure:=source.AnneePiece.ExoAnterieure;
    VarAnneePiece.PieceAnterieure:=source.AnneePiece.PieceAnterieure;
    Dest.AnneePiece:=VarAnneePiece;
//
    Dest.Tiers:=source.Tiers;
    Dest.ComptePlan:=source.ComptePlan;
    Dest.ContrePartieTiers:=source.ContrePartieTiers;
//
    VarInfosPointage.infosPointage.Dataset:=Source.InfosPointage.infosPointage.Dataset;
    VarInfosPointage.infosPointage.Lettre:=Source.InfosPointage.infosPointage.Lettre;
    VarInfosPointage.infosPointage.Ligne:=Source.InfosPointage.infosPointage.Ligne;
    VarInfosPointage.infosPointage.MontantPointage:=Source.InfosPointage.infosPointage.MontantPointage;
    VarInfosPointage.infosPointage.NbLignePointee:=Source.InfosPointage.infosPointage.NbLignePointee;
    VarInfosPointage.infosPointage.Pointee:=Source.InfosPointage.infosPointage.Pointee;
    VarInfosPointage.infosPointage.TvaSurE:=Source.InfosPointage.infosPointage.TvaSurE;
    VarInfosPointage.InfosReste.Reste:=Source.InfosPointage.InfosReste.Reste;
    VarInfosPointage.InfosReste.ResteInitial:=Source.InfosPointage.InfosReste.ResteInitial;
    VarInfosPointage.InfosReste.SensReste:=Source.InfosPointage.InfosReste.SensReste;
    Dest.InfosPointage:=VarInfosPointage;
//
    Dest.PieceModifiable:=source.PieceModifiable;
    Dest.NbrPointage:=source.NbrPointage;
    Dest.Reference:=source.Reference;
    Dest.Journal:=source.Journal;
    Dest.IDJournal:=source.IDJournal;
    Dest.IDContrepartie:=source.IDContrepartie;
    Dest.Contrepartie:=source.Contrepartie;
    AssignStringListeEX(source.ListeContrePartieTiers,dest.ListeContrePartieTiers);//[0:Interdit,1:Obligatoire,-1:facultatif]
    Dest.FNewReference:=source.FNewReference;
    Dest.FNewIDPiece:=source.FNewIDPiece;
    Dest.Libelle:=source.Libelle;
    Dest.DernierLibelleSaisi:=source.DernierLibelleSaisi;
    Dest.Compte:=source.Compte;
    Dest.Montant:=source.Montant;
    Dest.Sens:=source.Sens;
    Dest.SensPourReglement:=source.SensPourReglement;
    Dest.MontantPourReglement:=source.MontantPourReglement;
    Dest.DateSaisie:=source.DateSaisie;
    Dest.DateLivraison:=source.DateLivraison;
    Dest.DateEcheance:=source.DateEcheance;
    Dest.Quand:=source.Quand;
    Dest.Qui:=source.Qui;
    Dest.TablePiece:=source.TablePiece;
    Dest.IRefTaPiece:=source.IRefTaPiece;
    Dest.TableJournal:=source.TableJournal;
    Dest.IndexJournal:=source.IndexJournal;
    Dest.TablePlan:=source.TablePlan;
    Dest.IndexCompte:=source.IndexCompte;
    Dest.TableTiers:=source.TableTiers;
    Dest.ICompteTiers:=source.ICompteTiers;
    Dest.ILibTiers:=source.ILibTiers;
    Dest.ILibTaPlan:=source.ILibTaPlan;
    Dest.EtatPiece:=source.EtatPiece;
    Dest.FirstIDPiece:=source.FirstIDPiece;
    Dest.LastIDPiece:=source.LastIDPiece;
    Dest.Modifier_Confirmer:=source.Modifier_Confirmer;
    Dest.Modifier_EnAttente:=source.Modifier_EnAttente;
    Dest.Inserer:=source.Inserer;
    Dest.Reglement:=source.Reglement;
//
    VarInfosVerrouillage.Deverrouillable:=source.InfosVerrouillage.Deverrouillable;
    VarInfosVerrouillage.PeriodeDeverrouillable:=source.InfosVerrouillage.PeriodeDeverrouillable;
    VarInfosVerrouillage.PeriodeVerrouillee:=source.InfosVerrouillage.PeriodeVerrouillee;
    VarInfosVerrouillage.PieceVerrouillee:=source.InfosVerrouillage.PieceVerrouillee;
    Dest.InfosVerrouillage:=VarInfosVerrouillage;
//
    Dest.TypeTvaE:=source.TypeTvaE;
    Dest.SuppDerniereDeclTva:=source.SuppDerniereDeclTva;
//
    VarValPieceAutoGen.Champ_Gen:=source.ValPieceAutoGen.Champ_Gen;
    VarValPieceAutoGen.TableGen:=source.ValPieceAutoGen.TableGen;
    VarValPieceAutoGen.Table_Gen:=source.ValPieceAutoGen.Table_Gen;
    VarValPieceAutoGen.Val_Champ_Gen:=source.ValPieceAutoGen.Val_Champ_Gen;
    Dest.ValPieceAutoGen:=VarValPieceAutoGen;
//
    Dest.NumCheque:=source.NumCheque;
    Dest.IDGestCo:=source.IDGestCo;
    Dest.CodeGestCo:=source.CodeGestCo;
    Dest.SuppressionParticulieres:=source.SuppressionParticulieres;
    Dest.Suppression_Pour_Modif:=source.Suppression_Pour_Modif;
except
  showmessage('Erreur Interne sur CopieContenuPiece : ');
end;
end;


Function CopieContenuPiece_DansFichier(Source:TPiece;NomFichier:string):Tstringlist;
var
VarAnneePiece:TPieceAnterieure;
VarInfosPointage:TPointage;
VarInfosVerrouillage:TVerrouillage;
VarValPieceAutoGen:TValPieceAutoGenere;
i:integer;
listeTmp:Tstringlist;
Begin
try
Result:=Tstringlist.Create;
Initialise_TStringlist(result,nil,false);

listeTmp:=Tstringlist.Create;
Initialise_TStringlist(listeTmp,nil,false);

//    AssignStringListeEX(source.ListeEcritures,Result.ListeEcritures);
    listeTmp:=CopieContenuTrame_DansFichier(source.Trame);
    if listeTmp<>nil then
      begin
        for i :=0 to listeTmp.count-1 do
          result.add(listeTmp.Strings[i]);
      end;
    Initialise_TStringlist(listeTmp,nil,false);
    Result.Add(Source.Name);

    Result.Add('Defaut = '+str_bool2str(source.Defaut));
    Result.Add('TVA_A_Gerer = '+str_bool2str(source.TVA_A_Gerer));
    Result.Add('DateDebutExo = '+datetostr(source.DateDebutExo));
    Result.Add('DateFinExo = '+datetostr(source.DateFinExo));
    Result.Add('CodeExo = '+source.CodeExo);
//
    Result.Add('AnneePiece.ExoAnterieure = '+source.AnneePiece.ExoAnterieure);
    Result.Add('AnneePiece.PieceAnterieure = '+str_bool2str(source.AnneePiece.PieceAnterieure));
//
    Result.Add('Tiers = '+source.Tiers);
    Result.Add('ComptePlan = '+source.ComptePlan);
    Result.Add('ContrePartieTiers = '+source.ContrePartieTiers);
//
    if Source.InfosPointage.infosPointage.Dataset=nil then
      Result.Add('InfosPointage.infosPointage.Dataset = Nil')
    else
      Result.Add('InfosPointage.infosPointage.Dataset = '+Source.InfosPointage.infosPointage.Dataset.Name);
    Result.Add('InfosPointage.infosPointage.Lettre = '+Source.InfosPointage.infosPointage.Lettre);
    Result.Add('InfosPointage.infosPointage.Ligne = '+inttostr(Source.InfosPointage.infosPointage.Ligne));
    Result.Add('InfosPointage.infosPointage.MontantPointage = '+currtostr(Source.InfosPointage.infosPointage.MontantPointage));
    Result.Add('InfosPointage.infosPointage.NbLignePointee = '+inttostr(Source.InfosPointage.infosPointage.NbLignePointee));
    Result.Add('InfosPointage.infosPointage.Pointee = '+str_bool2str(Source.InfosPointage.infosPointage.Pointee));
    Result.Add('InfosPointage.infosPointage.TvaSurE = '+str_bool2str(Source.InfosPointage.infosPointage.TvaSurE));
    Result.Add('InfosPointage.InfosReste.Reste = '+currtostr(Source.InfosPointage.InfosReste.Reste));
    Result.Add('InfosPointage.InfosReste.ResteInitial = '+currtostr(Source.InfosPointage.InfosReste.ResteInitial));
    Result.Add('InfosPointage.InfosReste.SensReste = '+str_bool2str(Source.InfosPointage.InfosReste.SensReste));
//
    Result.Add('PieceModifiable = '+str_bool2str(source.PieceModifiable));
    Result.Add('NbrPointage = '+inttostr(source.NbrPointage));
    Result.Add('Reference = '+source.Reference);
    Result.Add('Journal = '+source.Journal);
    Result.Add('IDJournal = '+inttostr(source.IDJournal));
    Result.Add('IDContrepartie = '+inttostr(source.IDContrepartie));
    Result.Add('Contrepartie = '+inttostr(source.Contrepartie));
//    AssignStringListeEX(source.ListeContrePartieTiers,Result.ListeContrePartieTiers);//[0:Interdit,1:Obligatoire,-1:facultatif]
    Result.Add('FNewReference = '+source.FNewReference);
    Result.Add('FNewIDPiece = '+inttostr(source.FNewIDPiece));
    Result.Add('Libelle = '+source.Libelle);
    Result.Add('DernierLibelleSaisi = '+source.DernierLibelleSaisi);
    Result.Add('Compte = '+source.Compte);
    Result.Add('Montant = '+currtostr(source.Montant));
    Result.Add('Sens = '+str_bool2str(source.Sens));
    Result.Add('SensPourReglement = '+str_bool2str(source.SensPourReglement));
    Result.Add('MontantPourReglement = '+currtostr(source.MontantPourReglement));
    Result.Add('DateSaisie = '+datetostr(source.DateSaisie));
    Result.Add('DateLivraison = '+Datetostr(source.DateLivraison));
    Result.Add('DateEcheance = '+datetostr(source.DateEcheance));
    Result.Add('Quand = '+datetostr(source.Quand));
    Result.Add('Qui = '+source.Qui);
    if source.TablePiece=nil then
      Result.Add('TablePiece = Nil')
    else
      Result.Add('TablePiece = '+source.TablePiece.TableName);
    Result.Add('IRefTaPiece = '+inttostr(source.IRefTaPiece));
    if source.TableJournal=nil then
      Result.Add('TableJournal = Nil')
    else
      Result.Add('TableJournal = '+source.TableJournal.TableName);
    Result.Add('IndexJournal = '+inttostr(source.IndexJournal));
    if source.TablePlan=nil then
      Result.Add('TablePlan = Nil')
    else
      Result.Add('TablePlan = '+source.TablePlan.TableName);
    Result.Add('IndexCompte = '+inttostr(source.IndexCompte));
    if source.TableTiers=nil then
      Result.Add('TableTiers = Nil')
    else
      Result.Add('TableTiers = '+source.TableTiers.TableName);
    Result.Add('ICompteTiers = '+inttostr(source.ICompteTiers));
    Result.Add('ILibTiers = '+inttostr(source.ILibTiers));
    Result.Add('ILibTaPlan = '+inttostr(source.ILibTaPlan));
     case source.EtatPiece of
        dsinactive:Result.Add('EtatPiece = dsinactive');
        dsBrowse:Result.Add('EtatPiece = dsBrowse');
        dsEdit:Result.Add('EtatPiece = dsEdit');
        dsInsert:Result.Add('EtatPiece = dsInsert');
     end;
    Result.Add('FirstIDPiece = '+inttostr(source.FirstIDPiece));
    Result.Add('LastIDPiece = '+inttostr(source.LastIDPiece));
    Result.Add('Modifier_Confirmer = '+str_bool2str(source.Modifier_Confirmer));
    Result.Add('Modifier_EnAttente = '+str_bool2str(source.Modifier_EnAttente));
    Result.Add('Inserer = '+str_bool2str(source.Inserer));
    Result.Add('Reglement = '+str_bool2str(source.Reglement));
//
    Result.Add('InfosVerrouillage.Deverrouillable = '+str_bool2str(source.InfosVerrouillage.Deverrouillable));
    Result.Add('InfosVerrouillage.PeriodeDeverrouillable = '+str_bool2str(source.InfosVerrouillage.PeriodeDeverrouillable));
    Result.Add('InfosVerrouillage.PeriodeVerrouillee = '+str_bool2str(source.InfosVerrouillage.PeriodeVerrouillee));
    Result.Add('InfosVerrouillage.PieceVerrouillee = '+str_bool2str(source.InfosVerrouillage.PieceVerrouillee));
//
    Result.Add('TypeTvaE = '+str_bool2str(source.TypeTvaE));
    Result.Add('SuppDerniereDeclTva = '+str_bool2str(source.SuppDerniereDeclTva));
//
    Result.Add('ValPieceAutoGen.Champ_Gen = '+source.ValPieceAutoGen.Champ_Gen);
    Result.Add('ValPieceAutoGen.TableGen = '+str_bool2str(source.ValPieceAutoGen.TableGen));
    Result.Add('ValPieceAutoGen.Table_Gen = '+source.ValPieceAutoGen.Table_Gen);
    Result.Add('ValPieceAutoGen.Val_Champ_Gen = '+source.ValPieceAutoGen.Val_Champ_Gen);
//
    Result.Add('NumCheque = '+source.NumCheque);
    Result.Add('IDGestCo = '+inttostr(source.IDGestCo));
    Result.Add('CodeGestCo = '+source.CodeGestCo);
    Result.Add('SuppressionParticulieres = '+str_bool2str(source.SuppressionParticulieres));
    Result.Add('Suppression_Pour_Modif = '+str_bool2str(source.Suppression_Pour_Modif));
    Result.Add('--------------------');
    if empty(nomfichier)then nomfichier:='C:\Projet\Epicea-2\Execution\Exportation\Piece_Courante.txt';
    Result.SaveToFile(nomfichier);
Initialise_TStringlist(listeTmp);
except
  showmessage('Erreur Interne sur CopieContenuPiece_DansFichier : ');
end;
end;



  //////////////////////////Nouvel Objet ** MODIFICATION ** ////////////////////

Constructor TModification.Create(AOwner :TComponent);
Begin
inherited create(AOwner);
End;


Destructor TModification.Destroy;
Begin
inherited destroy;
End;

procedure TModification.NouvelleModification;
Begin
//si propriétés les initialiser

 if Assigned(FOnNewModification) then FOnNewModification(Self);
End;



end.

