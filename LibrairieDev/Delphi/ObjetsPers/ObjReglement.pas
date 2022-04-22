unit ObjReglement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,db,
  dbtables,Piece,E2_Decl_Records;

type

  TRecordEcriture=record
     IDEcriture:integer;
     compte:string;
     Tiers:string;
     Libelle:string;
     Montant:currency;
     sens:boolean;
     Date:string;
     TvaDate:string;
     Retour:boolean;
  end;


  TReglementList = class(TComponent)
  private
    { Déclarations privées }
  FIDJournal:Integer;
  FJournal:string;
  FPointee:boolean;
  FNbLignePointee:integer;
  FReste:currency;
  FResteAAfficher:currency;
  FSensReste:boolean;
  FResteInitial:currency;
  FIDPiece:integer;
  FCompte:string;
  FTiers:string;
  FContrePartieCompte:string;
  FContrePartieTiers:string;
  FLibelle:string;
  FDate:string;
  FTvaDate:string;
  FID_Org:integer;
  FIDContrepartie:integer;
  FID_Tmp:integer;
  FReference:string;
  Fmontant:currency;
  FSens:boolean;
  FImputation:currency;
  FVide:boolean;
  FTotalModifiable:boolean;
  FModifiable:boolean;
  FPieceModifiee:boolean;
  FCompteModifiable:boolean;
  FInfosVerrouillage:TVerrouillage;
  FADeverrouiller:boolean;


  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;

    property IDPiece:integer read FIDPiece write FIDPiece;
    property Compte:string read FCompte write FCompte;
    property Tiers:string read FTiers write FTiers;
    property ContrePartieTiers:string read FContrePartieTiers write FContrePartieTiers;
    property ContrePartieCompte:string read FContrePartieCompte write FContrePartieCompte;
    property Libelle:string read FLibelle write FLibelle;
    property Date:string read FDate write FDate;
    property TvaDate:string read FTvaDate  write FTvaDate;
    property ID_Org:integer read FID_Org  write FID_Org;
    property IDContrepartie:integer read FIDContrepartie write FIDContrepartie;
    property ID_Tmp:integer  read  FID_Tmp write FID_Tmp;
    property Reference:string  read FReference  write FReference;
    property montant:currency  read Fmontant  write Fmontant;
    property Sens:boolean  read FSens  write FSens;
    property Imputation:currency read FImputation  write FImputation;
    property Vide:boolean read  FVide write FVide;
    property Pointee:boolean read FPointee write FPointee;
    property NbLignePointee:integer read FNbLignePointee write FNbLignePointee ;
    property Reste:currency read FReste write FReste;
    property ResteAAfficher:currency read FResteAAfficher write FResteAAfficher;
    property SensReste:boolean read FSensReste write FSensReste;
    property ResteInitial:currency read FResteInitial write FResteInitial; 
    property TotalModifiable:boolean read FTotalModifiable write FTotalModifiable;
    property Modifiable:boolean read FModifiable write FModifiable;
    property IDJournal:Integer read FIDJournal write FIDJournal ;
    property Journal:string read FJournal  write FJournal;
    property PieceModifiee:boolean read FPieceModifiee write FPieceModifiee;
    property CompteModifiable:boolean read FCompteModifiable write FCompteModifiable;
    property InfosVerrouillage:TVerrouillage read FInfosVerrouillage write FInfosVerrouillage;
    property ADeverrouiller:boolean read FADeverrouiller write FADeverrouiller;

  published
    { Déclarations publiées }
  end;


    TLettrage = class(TComponent)
  private
    { Déclarations privées }
    FListeLigneDebit:TStringlist;
    FListeLigneCredit:TStringlist;
    FMontantTotalImputationDebit:Currency;
    FMontantTotalImputationCredit:Currency;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;

    property ListeLigneDebit:TStringlist read FListeLigneDebit write FListeLigneDebit;
    property ListeLigneCredit:TStringlist read FListeLigneCredit write FListeLigneCredit;
    property MontantTotalImputationDebit:Currency read FMontantTotalImputationDebit write FMontantTotalImputationDebit;
    property MontantTotalImputationCredit:Currency read FMontantTotalImputationCredit write FMontantTotalImputationCredit;

  published
    { Déclarations publiées }
  end;

    TPointageDebit = class(TComponent)
  private
    { Déclarations privées }
  FLettre:string;
  FImputation:string;
  FPointer:string;
  FSens:string;
  FTiers:String;
  FIDEcriture:integer;
  FInfosVerrouillage:TVerrouillage;
  FEtatPointage:Tdatasetstate;
  FTypeTvaE:boolean;
  FDateTva:Tdatetime;
  FPiece:TPiece;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;

    property Lettre:string read FLettre write FLettre;
    property Imputation:string read FImputation write FImputation;
    property Pointer:string read FPointer write FPointer;
    property Sens:string read FSens write FSens;
    property Tiers:String read FTiers write FTiers;
    property IDEcriture:integer read FIDEcriture write FIDEcriture;
    property InfosVerrouillage:TVerrouillage read FInfosVerrouillage write FInfosVerrouillage;
    property EtatPointage:Tdatasetstate read FEtatPointage write FEtatPointage;
    property TypeTvaE:boolean read FTypeTvaE write FTypeTvaE;
    property DateTva:Tdatetime read FDateTva write FDateTva;
  published
    { Déclarations publiées }
    property Piece:TPiece read FPiece write FPiece;
  end;

    TPointageCredit = class(TPointageDebit)
  private
    { Déclarations privées }
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
  published
    { Déclarations publiées }
  end;

    TPointageList = class(TComponent)
  private
    { Déclarations privées }
  FTiers:string;
  FLettre:string;
  FImputation:string;
  FPointer:string;
  FSens:string;
  FIDEcriture:integer;
  FInfosVerrouillage:TVerrouillage;
  FEtatPointage:Tdatasetstate;
  FTypeTvaE:boolean;
  FDateTva:Tdatetime;
  FPiece:TPiece;
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;

    property Tiers:string read FTiers write FTiers;
    property Lettre:string read FLettre write FLettre;
    property Imputation:string read FImputation write FImputation;
    property Pointer:string read FPointer write FPointer;
    property Sens:string read FSens write FSens;
    property IDEcriture:integer read FIDEcriture write FIDEcriture;
    property InfosVerrouillage:TVerrouillage read FInfosVerrouillage write FInfosVerrouillage;
    property EtatPointage:Tdatasetstate read FEtatPointage write FEtatPointage;
    property TypeTvaE:boolean read FTypeTvaE write FTypeTvaE;
    property DateTva:Tdatetime read FDateTva write FDateTva;
  published
    { Déclarations publiées }
    property Piece:TPiece read FPiece write FPiece;
  end;



  TObjReglement = class(TComponent)
  private
    { Déclarations privées }
  FTableEcriture:TTable;
  FTablePiece:TTable;
  FTaEcritureRegltmp:TTable;
  FTaPieceReglTmp:TTable;
  FPiece:TPiece;
  FListeReglement:TReglementList;
  FCompte:string;
  FTablePlan:tTable;
  FTableTVA:ttable;
  FFirstIDEcritureRegl:integer;
  FNextIDEcritureRegl:integer;
  FIDJournalBanque:String;
  Function DupliqueTableObjet(var TableDest:TTable;TableSource:TTable):boolean;
  Function Empty(Const Value : String) :Boolean;
  
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    function RenvoieInfoSurTableDiverse(valeur:string;TableRech:ttable;ChRech,ChRecup:string):string;
    function NewIDEcriture(TaEcriture:Ttable;ChampID:string):integer;
    function RecupEcritureSurReglementExistant(Reglement:TObjReglement;IDPiece:integer;ChIDPiece,compte,tiers:string):TRecordEcriture;
    Function ArrondiCentieme(Value :Currency) :Currency;
    function RecupIDEcritureTiersSurRef(Ref:string;Tiers:string;var IDEcritureTmp:integer):boolean;
    function FiltrageReglementExistantSurSensEtTiers(Sens:boolean;Tiers,compte:string):Tstringlist;
    function FiltrageReglementExistantSurSensEtIDPiece(Sens:boolean;SelectionIDPieces:string):Tstringlist;

    property FirstIDEcritureRegl:integer read FFirstIDEcritureRegl write FFirstIDEcritureRegl;
    property NextIDEcritureRegl:integer read FNextIDEcritureRegl write FNextIDEcritureRegl;
    property TaPieceReglTmp:TTable read FTaPieceReglTmp write FTaPieceReglTmp;
    property TaEcritureRegltmp:TTable read FTaEcritureRegltmp write FTaEcritureRegltmp;
    property Compte:string read FCompte write FCompte;
    property ListeReglement:TReglementList read FListeReglement write FListeReglement;

  published
    { Déclarations publiées }
   property TableEcriture:Ttable read FTableEcriture write FTableEcriture;
   property Piece:tPiece read FPiece write FPiece;
   property TablePlan:TTable read FTablePlan write FTablePlan;
   property TablePiece:TTable read FTablePiece write FTablePiece;
   property IDJournalBanque:String read FIDJournalBanque write FIDJournalBanque;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Epicea', [TObjReglement,TPointageList]);
end;

constructor TReglementList.Create(AOwner :TComponent);
Begin
inherited create(AOwner);
End;

destructor TReglementList.Destroy;
Begin
inherited Destroy;
End;


procedure TReglementList.Loaded;
Begin
inherited loaded;
End;


constructor TPointageList.Create(AOwner :TComponent);
Begin
inherited create(AOwner);
End;

destructor TPointageList.Destroy;
Begin
inherited Destroy;
End;


procedure TPointageList.Loaded;
Begin
inherited loaded;
End;


constructor TObjReglement.Create(AOwner :TComponent);
Begin
inherited create(AOwner);
End;

destructor TObjReglement.Destroy;
Begin
inherited Destroy;
End;


procedure TObjReglement.Loaded;
Begin
DupliqueTableObjet(FTaEcritureRegltmp,FTableEcriture);
DupliqueTableObjet(FTaPieceReglTmp,FTablePiece);
inherited loaded;
End;



function TObjReglement.NewIDEcriture(TaEcriture:Ttable;ChampID:string):integer;
var
QueryID:TQuery;
begin
   try
   QueryID:=tquery.Create(self);
   QueryID.DatabaseName:=TaEcriture.DatabaseName;
   QueryID.SQL.Clear;
   QueryID.SQL.Add('Select max('+ChampID+') as resultat from ' +TaEcriture.TableName+'''');
   QueryID.Open;
   result:=QueryID.FindField('resultat').Asinteger+1;
   finally
   QueryID.close;
   QueryID.Free;
   QueryID:=nil;
   end;//fin du try finally
end;


Function TObjReglement.ArrondiCentieme(Value :Currency) :Currency;
Begin
  Result:= Round(Value * 100) / 100;
end;

Function TObjReglement.DupliqueTableObjet(var TableDest:TTable;TableSource:TTable):boolean;
Begin
result:=true;
  try
  if ((TableDest = nil) and (TableSource<> nil))then
     Begin
      TableDest:=TTable.Create(self);
      TableDest.DatabaseName:=TableSource.DatabaseName;
      TableDest.TableName:=TableSource.TableName;
     // TableDest.open;
     End
     else
     result:=false;
  except
  showmessage('Problème lors de la duplication de la table '+TableSource.TableName);
  result:=false;
  abort;
  end;
End;


//cette fonction permet de récupérer dans un record ou directement dans un objet reglement
//un réglement existant pour pouvoir l'afficher au retour de cette fonction
function TObjReglement.RecupEcritureSurReglementExistant(Reglement:TObjReglement;IDPiece:integer;ChIDPiece,compte,tiers:string):TRecordEcriture;
//var
//taEcritureAux,TaPieceAux:ttable;
//ChampRech:string;
Begin
//if copy(compte,1,1)='+' then
//ChampRech:='Tiers'
//else
//ChampRech:='Compte';
//taEcritureAux:=ttable.Create(self);
//taEcritureAux.DatabaseName:=TableEcriture.DatabaseName;
//taEcritureAux.tableName:=TableEcriture.tableName;
   try
   FTaEcritureRegltmp.Open; //on filtre par rapport à un IDPiece et un compte (ici de réglement)
   FTaEcritureRegltmp.Filtered:=false;
   if not empty(tiers)then
   FTaEcritureRegltmp.Filter:=(''+ChIDPiece+'='''+inttostr(IDPiece)+'''and Tiers ='''+tiers+'''and compte ='''+compte+'''')
   else
   FTaEcritureRegltmp.Filter:=(''+ChIDPiece+'='''+inttostr(IDPiece)+'''and Tiers = null and compte ='''+compte+'''');
   FTaEcritureRegltmp.Filtered:=true;
     if FTaEcritureRegltmp.RecordCount<>0 then
       Begin //si on trouve l'écriture de réglement, on récupère le montant et le sens
          if ((not empty(FTaEcritureRegltmp.findfield('DebitSaisie').asstring))and (FTaEcritureRegltmp.findfield('DebitSaisie').ascurrency<>0))then
          begin //si montant au débit
          result.Montant:= FTaEcritureRegltmp.findfield('DebitSaisie').ascurrency;
          result.Sens:=false;
          end  //fin si montant au débit
          else
          begin //si montant au Crédit
             if ((not empty(FTaEcritureRegltmp.findfield('CreditSaisie').asstring))and (FTaEcritureRegltmp.findfield('CreditSaisie').ascurrency<>0))then
             result.Montant:= FTaEcritureRegltmp.findfield('CreditSaisie').ascurrency;
             result.Sens:=true;
          end; //fin si montant au Crédit
          result.compte:=FTaEcritureRegltmp.findfield('Compte').asstring;
          result.Tiers:=FTaEcritureRegltmp.findfield('Tiers').asstring;
          result.IDEcriture:=FTaEcritureRegltmp.findfield('ID').asinteger;
          result.Libelle:=FTaEcritureRegltmp.findfield('Libelle').asstring;
          result.Date:=FTaEcritureRegltmp.findfield('Date').asstring;
          result.TvaDate:=FTaEcritureRegltmp.findfield('TvaDate').asstring;
       if Reglement<>nil then
          Begin //si passage en paramètre d'un objet reglement,on le rempli
          reglement.FListeReglement.Compte:=result.compte;
          reglement.FListeReglement.Tiers:=result.Tiers;
          Reglement.FListeReglement.ID_Org:=result.IDEcriture;
          Reglement.FListeReglement.Libelle:=result.Libelle;
          Reglement.FListeReglement.Date:=result.Date;
          Reglement.FListeReglement.TvaDate:=result.TvaDate;
          Reglement.FListeReglement.montant:=result.Montant;
          Reglement.FListeReglement.Sens:=result.Sens;
          End;//fin si passage en paramètre d'un objet reglement,on le rempli
       End;//si on trouve l'écriture de réglement
   finally
    FTaEcritureRegltmp.close;
   end;//fin du try finally
End;


Function TObjReglement.RenvoieInfoSurTableDiverse(valeur:string;TableRech:ttable;ChRech,ChRecup:string):string;
var
tableTmp:ttable;
Begin
tableTmp:=ttable.Create(nil);
tableTmp.DatabaseName:= TableRech.DatabaseName;
tableTmp.tableName:= TableRech.tableName;
tableTmp.Open;
tableTmp.first;
result:='';
   if tableTmp.locate(ChRech,valeur,[])then
      result:=tableTmp.FindField(ChRecup).asstring;

tableTmp.close;
tableTmp.free;
End;

Function TObjReglement.Empty(Const Value : String) :Boolean;
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


function TObjReglement.RecupIDEcritureTiersSurRef(Ref:string;Tiers:string;var IDEcritureTmp:integer):boolean;
var
//TableTemp:TTable;
IDPieceTmp:integer;
champ:string;
begin
   try
      try
         result:=false;
         //création de la table piece temporaire pour récupérer l'IDPiece sur la référence proposée
   //      TableTemp:=TTable.create(self);
   //      TableTemp.databaseName:=FTaPieceReglTmp.DatabaseName;
   //      TableTemp.TableName:= FTaPieceReglTmp.TableName;

         FTaPieceReglTmp.open;
           if FTaPieceReglTmp.locate('Reference',ref,[])then
            begin
            IDPieceTmp:=FTaPieceReglTmp.findfield('ID').asinteger;
            result:=true;
            end;
   //      TableTemp.free;
         //création de la table ecriture temporaire pour récupérer l'IDEcriture sur le tiers proposé
         //et l'IDPiece récupéré
   //      TableTemp:=TTable.create(self);
   //      TableTemp.databaseName:=FTaEcritureRegltmp.DatabaseName;
   //      TableTemp.TableName:= FTaEcritureRegltmp.TableName;

         FTaEcritureRegltmp.open;
         FTaEcritureRegltmp.Filtered:=false;
         FTaEcritureRegltmp.filter:=('ID_Piece = '''+inttostr(IDPieceTmp)+'''');
         FTaEcritureRegltmp.Filtered:=true;
         if copy(tiers,1,1)='+'then
         champ:='Tiers'
         else
         champ:='Compte';
           if  FTaEcritureRegltmp.locate(champ,Tiers,[])then
           begin
           IDEcritureTmp:=FTaEcritureRegltmp.findfield('ID').asinteger;
           result:=true;
           end;
      except
      result:=false;
      abort;
      end;//fin du try except
   finally   
     FTaPieceReglTmp.close;
     FTaEcritureRegltmp.Close;
   end;//fin du try finally
   //TableTemp.close;
//TableTemp.free;

end;


function TObjReglement.FiltrageReglementExistantSurSensEtTiers(Sens:boolean;Tiers,compte:string):Tstringlist;
var
QueryTmp:TQuery;
begin
   try
   result:=TStringList.Create;
   QueryTmp:=TQuery.create(self);
   QueryTmp.DataBaseName:=TaEcritureRegltmp.DatabaseName;
   QueryTmp.DataBaseName:=TaPieceReglTmp.DatabaseName;
     QueryTmp.sql.Add('Select Distinct Piece.reference');
     QueryTmp.sql.Add(' from Piece,Ecriture where Piece.journal='''+IDJournalBanque+'''');
     QueryTmp.sql.Add(' and piece.ID in (select ID_Piece from ecriture where compte='''+compte+'''');
     if not empty(tiers)then
     QueryTmp.sql.Add('and Tiers='''+Tiers+''')')
     else
     QueryTmp.sql.Add('and Tiers is null)');
     QueryTmp.sql.Add(' and piece.compte=ecriture.compte');
     if not sens then
       QueryTmp.sql.Add(' and ecriture.DebitSaisie<>0')
     else
       QueryTmp.sql.Add(' and ecriture.CreditSaisie<>0');
   QueryTmp.open;
   QueryTmp.First;
      while not(QueryTmp.EOF ) do
      Begin
      result.Add(QueryTmp.findfield('Reference').asstring);
      QueryTmp.Next;
      End;
   finally
   QueryTmp.Close;
   QueryTmp.Free;
   QueryTmp:=nil;
   end;//fin du try finally
end;


function TObjReglement.FiltrageReglementExistantSurSensEtIDPiece(Sens:boolean;SelectionIDPieces:string):Tstringlist;
var
QueryTmp:TQuery;
begin
   try
   result:=TStringList.Create;
   QueryTmp:=TQuery.create(self);
   QueryTmp.DataBaseName:=TaPieceReglTmp.DatabaseName;
     QueryTmp.sql.Add('Select Piece.reference');
     QueryTmp.sql.Add(' from Piece,ecriture,pointage where piece.ID=ecriture.ID_Piece');
     if  sens then
     begin
       QueryTmp.sql.Add(' and ecriture.ID=pointage.ID_Debit');
       QueryTmp.sql.Add(' and pointage.ID_Credit in ('+SelectionIDPieces+')');
     end
     else
     begin
       QueryTmp.sql.Add(' and ecriture.ID=pointage.ID_Credit');
       QueryTmp.sql.Add(' and pointage.ID_Debit in ('+SelectionIDPieces+')');
     end;
     QueryTmp.sql.Add('group by Piece.Reference');
   QueryTmp.open;
   QueryTmp.First;
      while not(QueryTmp.EOF ) do
      Begin
      result.Add(QueryTmp.findfield('Reference').asstring);
      QueryTmp.Next;
      End;
   finally
   QueryTmp.Close;
   QueryTmp.Free;
   QueryTmp:=nil;
   end;//fin du try finally
end;


constructor TLettrage.Create(AOwner :TComponent);
Begin
inherited create(AOwner);
FListeLigneDebit := TStringList.Create;
FListeLigneCredit := TStringList.Create;
FMontantTotalImputationDebit:=0;
FMontantTotalImputationCredit:=0;
End;

destructor TLettrage.Destroy;
Begin
inherited Destroy;
FListeLigneDebit.Free;
FListeLigneCredit.Free;
End;


procedure TLettrage.Loaded;
Begin
inherited loaded;
End;


constructor TPointageDebit.Create(AOwner :TComponent);
Begin
inherited create(AOwner);
End;

destructor TPointageDebit.Destroy;
Begin
inherited Destroy;
End;


procedure TPointageDebit.Loaded;
Begin
inherited loaded;
End;

constructor TPointageCredit.Create(AOwner :TComponent);
Begin
inherited create(AOwner);
End;

destructor TPointageCredit.Destroy;
Begin
inherited Destroy;
End;


procedure TPointageCredit.Loaded;
Begin
inherited loaded;
End;

end.
