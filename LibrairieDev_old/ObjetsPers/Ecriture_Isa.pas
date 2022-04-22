unit Ecriture_Isa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,db,
  dbtables,
  Piece,
  Grids,
  GrGrid,
  LibSql,
  Gr_Librairie_Obj,
  E2_Decl_Records,
  E2_LibInfosTable,
  referencement,
  E2_Librairie_Obj,
  lib_chaine,
  LibDates,
  DMRecherche_Obj,
  DMConstantes;

type
 TParametreCompte_obj=record
   Tiers:TInfosTiers;
   ComptePointable:boolean;
   ParamCpt:TEnregistrementComplet;
   Partie:TPartieEnregistrement;
   Choix:boolean;
   retour:boolean;
 end;

  TEcriture_Isa = class(TComponent)
  private
    { D�clarations priv�es }

  FListIdentifiant:TList;
  FListeEcriturePiece:Tlist;
  FTableEcriture:TTable;
  FTableTrameL:TTable;
  FParamLigneObj:TParamLigneObj;
  FPiece:TPiece;
  FListeContrepartie:TList;
  FCompteEcriture:string;
  FTiersEcriture:string;
  FSoldeEcriture:currency;
  FSensEcriture:integer;
  FLibelleEcriture:string;
  FDateEcriture:Tdatetime;
  FTableTVA:TTable;
  FTablePlan:tTable;
  FInfosPointage:TPointage;
  FFirstIDEcriture:integer;
  FLastIDEcriture:integer;
  FNextIDEcriture:integer;
  FRecIdentifiant:PIdentifiant_obj;
  FRecordEcriture:PRecordEcriture;
  FDispatcherTva:boolean;
//  Function DupliqueTable:boolean;
  Function Empty(Const Value : String) :Boolean;

  protected
    { D�clarations prot�g�es }
  public
    { D�clarations publiques }
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;

//    Procedure NewEcriture;
//    function RechercheNewIDSurTaEcritureTmp(TableTmp:Ttable;TypeLg:char;var NewID:integer;ChampID:string):boolean;
    function NewIDEcriture(TableEcriture:Ttable;ChampID:string):integer;
//    function NewIDEcriture_Sur_Table_Et_Liste(FiltrerValeur:boolean;Var Valeur:integer):boolean;
    function RecupEcritureSurPieceExistante(IDPiece:integer;ChampIDPiece,ChampTypeLigne:string;Piece:Tpiece):boolean;
//    procedure CorrectTaEcritureTmpSurNewID(ID:integer);
//    procedure InitialiseTaEcritureTmp;
    procedure InitialiseFParamLigneObj;
    procedure InitialiseParamCompte_Obj(var ParametreCompteEcriture:TParametreCompte_obj);
    procedure InitialiseParamLigne_Obj(var Parametre:TParamLigne_Obj);
    procedure InitialiseComplement_Obj(var ComplementLigne:TComplementLigne_Obj);
    procedure InitialiseCreationLigne_Obj(var ParamCreation:TCreation_Obj);
    property ParamLigneObj:TParamLigneObj read FParamLigneObj write FParamLigneObj;
    Function MinMaxTva(TableTva:TTable;ChampRecherche,ValeurRecherche,ChMin,ChMax,ChCode,ChCompte,ChLib:string):TRecupParamTva_obj;
    Function VerifMontantTVA(TaEcritureAux:Ttable;ChoixTable:integer;CompteTva:string;MontantTva:Currency;SensCredit:Boolean):TRetourMontantTva;
    Function ArrondiCentieme(Value :Currency) :Currency;
    property FirstIDEcriture:integer read FFirstIDEcriture write FFirstIDEcriture;
    property NextIDEcriture:integer read FNextIDEcriture write FNextIDEcriture;
    property LastIDEcriture:integer read FLastIDEcriture write FLastIDEcriture;
    property InfosPointage:TPointage read FInfosPointage write FInfosPointage;
    property CompteEcriture:string read FCompteEcriture write FCompteEcriture;
    property TiersEcriture:string read FTiersEcriture write FTiersEcriture;
    property ListIdentifiant:TList read FListIdentifiant write FListIdentifiant;
    property ListeEcriturePiece:TList read FListeEcriturePiece write FListeEcriturePiece;
    property ListeContrepartie:TList read FListeContrepartie write FListeContrepartie;
    property SoldeEcriture:currency read FSoldeEcriture write FSoldeEcriture;
    property SensEcriture:integer read FSensEcriture write FSensEcriture;
    property LibelleEcriture:string read FLibelleEcriture write FLibelleEcriture;
    property DispatcherTva:boolean read FDispatcherTva write FDispatcherTva;
    property DateEcriture:Tdatetime read FDateEcriture write FDateEcriture;
    function Verif_Liste_Grille_SurLigne(rang:integer;Liste:Tlist;Grille:TGrGrid):TerreurListe;
    function Verif_Liste_Grille_Entiere(Liste:Tlist;Grille:TGrGrid):TerreurListe;
    function InfosPiece_SurTypeLigne(TypeLignes:array of Char;Liste:Tlist;CompteTva:string;SensTva:integer;TousSens,TousCompteTva:boolean;ligne:integer):TInfosPiece_SurTypeLigne;
    function Liste_ObjIndexOf(Liste:Tlist;valeur:string;valeurRech:integer):integer;
    Function InteractionLigne_SurListe(Liste:Tlist;rang:integer;IDJournal:integer):TErreurLigne;
    function Verif_Liste_Table_Entiere(Liste:tlist;Table:TTable):TExceptLGR;
    procedure ListIdentifiantAdd_Insert(Valeur:array of const;Add,Remplace:boolean;Rang:integer);

    function VerifMontantTVA_SurListe(Liste:Tlist;ParamTva:TRecupParamTva_Obj;Debit,Credit,Mini,Maxi:currency;Mess:string;SensLigne:integer;A_La_Ligne:boolean):TRetourMontantTva;

    function RecupEcritureSurTrame(IDTrame:integer):boolean;
    function RecupEcritureSurRecord(SourceEcriture:Tlist;SourcePiece:TRecordPiece):TExceptLGR_ImportPiece;
    procedure ListRecordEcritureAdd_Insert(var Liste:Tlist;Valeur:array of const;Add,Remplace:boolean;Rang:integer);
    function RecupSens_Et_SoldeSurEcritureListe(Ligne:integer;Liste:Tlist):TInfosPiece_SurTypeLigne;

    function Recup_MontantTva_Valide(ValeurOrigine,Increment:currency;ParamTva:TRecupParamTva_Obj):TMontantTva_Valide;

    procedure CorrectionLigneTva(LigneGrille,LigneListe:integer;TypeLigneCourante:Char;ForcerModif:boolean;Grille:TgrGrid);
    function ModificationSuppressionLigneTva(TypeLigne:char;var Modif:TModif_Obj;Grille:TgrGrid):boolean;
    { isa  le  18/11/03 }
    procedure ModificationLigneHorsTaxesSurProrataTva(LigneTva:integer;Grille:TGrGrid;Dispatcher:boolean;ChangementTauxNonObligatoire:boolean=true);

    Function CompteEstPointable(Cpt:string):boolean;
    Function RecupListeEcriture_PourAffichage(Liste:Tlist;Rang:integer):string;
    function ExistenceIdemParamTVA(CompteTva:string;Curr:integer):boolean;
    function RecherchePremiereLigneTva(var ligne:integer):boolean;
    function ListIdentifiantIndexOf(valeur,valeurType:string;valeurRech:integer):integer;
    function GestionDesQuantites(compte:string;ValeurExistante:String;SensLigne:boolean;SensCompte:integer=0;PieceModifiable:Boolean=true;ValeurLigne:real=0):String;

  published
    { D�clarations publi�es }
   property TableEcriture:Ttable read FTableEcriture write FTableEcriture;
   property TableTrameL:TTable read FTableTrameL write FTableTrameL;
   property Piece:tPiece read FPiece write FPiece;
   property TableTVA:Ttable read FTableTVA Write FTableTVA;
   property TablePlan:TTable read FTablePlan write FTablePlan;

  end;

procedure Register;
        function gestionDernierIDEcriture(Ecriture:TEcriture_Isa):integer;
        function gestionDerniereReference(Journal:string;Piece:Tpiece;ListeReference:Tstringlist):string;
        Function CopieContenuEcriture_Isa(Source,Dest:TEcriture_isa;AvecCreation:boolean=true):boolean;
        function AssignListIdentifiant(ListeSource:Tlist;ListeDest:Tlist;rang:integer=-1):TExceptLGR;
        function AssignListeEcriturePiece(ListeSource:Tlist;ListeDest:Tlist;rang:integer=-1):TExceptLGR;
        function AssignListeContrepartie(ListeSource:Tlist;ListeDest:Tlist;rang:integer=-1):TExceptLGR;

        function CopieListIdentifiant_DansFichier(ListeSource:Tlist;rang:integer=-1;NomFichier:string=''):Tstringlist;
        function CopieListeContrepartie_DansFichier(ListeSource:Tlist;rang:integer=-1;NomFichier:string=''):Tstringlist;
        function CopieListeEcriturePiece_DansFichier(ListeSource:Tlist;rang:integer=-1;NomFichier:string=''):Tstringlist;
        Function CopieContenuEcriture_Isa_DansFichier(Source:TEcriture_isa;NomFichier:string=''):Tstringlist;


implementation



procedure Register;
begin
  RegisterComponents('Epicea', [TEcriture_Isa]);
end;


Function TEcriture_Isa.Empty(Const Value : String) :Boolean;
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



//Function TEcriture_Isa.DupliqueTable:boolean;
//Begin
//result:=true;
//  if FTableEcriture <> nil then
//     Begin
//      FTaEcrituretmp:=TTable.Create(self);
//      FTaEcrituretmp.DatabaseName:=FTableEcriture.DatabaseName;
//      FTaEcrituretmp.TableName:='EcritureTmp.db';
//      FTaEcrituretmp.open;
//     End
//     else
//     result:=false;
//End;


//Function TEcriture_Isa.RenvoieInfoSurTableDiverse(valeur:string;TableRech:ttable;ChRech,ChRecup:string):string;
//var
//tableTmp:ttable;
//Begin
//tableTmp:=ttable.Create(nil);
//tableTmp.DatabaseName:= TableRech.DatabaseName;
//tableTmp.tableName:= TableRech.tableName;
//tableTmp.Open;
//tableTmp.first;
//result:='';
//   if tableTmp.locate(ChRech,valeur,[])then
//      result:=tableTmp.FindField(ChRecup).asstring;
//
//tableTmp.close;
//tableTmp.free;
//End;



constructor TEcriture_Isa.Create(AOwner :TComponent);
Begin
inherited create(AOwner);
FListIdentifiant:=TList.Create;
FListeContrepartie:=TList.Create;
FListeEcriturePiece:=TList.Create;
End;

destructor TEcriture_Isa.Destroy;
Begin
inherited Destroy;
LibereObjet(tobject(FListIdentifiant));
LibereObjet(tobject(FListeContrepartie));
LibereObjet(tobject(FListeEcriturePiece));
End;


procedure TEcriture_Isa.Loaded;
Begin
inherited loaded;
End;


function TEcriture_Isa.NewIDEcriture(TableEcriture:Ttable;ChampID:string):integer;
var
QueryID:TQuery;
begin
QueryID:=tquery.Create(self);
QueryID.DatabaseName:=TableEcriture.DatabaseName;
QueryID.SQL.Clear;
if piece.anneepiece.PieceAnterieure then
 begin
   QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +TableEcriture.TableName+'');
   QueryID.SQL.Add(' Where '+ChampID+'< ' +Inttostr((strtoint(piece.codeExo)*10000000))+'''');
   QueryID.Open;
   result:=0;
   if QueryID.FindField('resultat').Asinteger = 0 then
   result:=(strtoint(piece.anneepiece.ExoAnterieure)*10000000)+1
   else
   result:=QueryID.FindField('resultat').Asinteger+1;
 end
 else
 begin
   QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +TableEcriture.TableName+'');
//   QueryID.SQL.Add(' Where '+ChampID+'>= ' +IntToStr((strtoint(piece.codeExo)*10000000))+'''');
   QueryID.SQL.Add(' Where '+ChampID+' between ' +IntToStr((strtoint(piece.codeExo)*10000000))+' and ' +IntToStr(((strtoint(piece.codeExo)+1)*10000000))+'''');
   QueryID.Open;
   result:=0;
   if QueryID.FindField('resultat').Asinteger = 0 then
   result:=(strtoint(piece.codeExo)*10000000)+1
   else
   result:=QueryID.FindField('resultat').Asinteger+1;
 end;
QueryID.close;
QueryID.Free;
end;




//function TEcriture_Isa.NewIDEcriture_Sur_Table_Et_Liste(FiltrerValeur:boolean;Var Valeur:integer):boolean;
//var
//ValeurTmp:integer;
//begin
//   try
//   result:=false;
//     if valeur>0 then
//       Begin //si id donn� est sup�rieur � z�ro
//       if FTableEcriture.Active=false then
//       FTableEcriture.Open;//si la table �criture relle n'est pas active je l'ouvre
//         if ((FTableEcriture.Locate('ID',valeur,[])=false)and(FTaEcrituretmp.Locate('ID',valeur,[])=false))then
//         result:=true //si l'id n'existe pas dans aucune des tables, alors on peut l'utiliser
//         else
//           Begin //si l'id existe dans au moins une des listes ou les deux
//             if FTableEcriture.Locate('ID',valeur,[])=true then
//               Begin //si l'id existe dans la table �criture r�elle
//                 valeurtmp:=NewIDEcriture(ftableecriture,'ID');
////                 if valeurtmp=ecriture_Isa1.FirstIDEcriture then
////                 inc(valeurtmp);
//
//                 while FTaEcrituretmp.Locate('ID',valeurtmp,[]) do
//                 inc(valeurtmp,1);
//                 valeur:=valeurtmp;
//                 result:=true;
//               End //fin si l'id existe dans la table �criture r�elle
//             else
//               Begin //si l'id existe dans la table temporaire
//                 valeurtmp:=NewIDEcriture(FTaEcrituretmp,'ID');
//                 if FTableEcriture.Locate('ID',valeurtmp,[])=false then
//                   Begin
//                   valeur:=valeurtmp;
//                   result:=true;
//                   End
//                 else
//                   Begin
//                   valeurtmp:=NewIDEcriture(ftableecriture,'ID');
//                   while FTaEcrituretmp.Locate('ID',valeurtmp,[]) do
//                   inc(valeurtmp,1);
//                   valeur:=valeurtmp;
//                   result:=true;
//                   End;
//               End; //fin si l'id existe dans la liste
//           End;//fin si l'id existe dans au moins une des listes ou les deux
//       End //fin si id donn� est sup�rieur � z�ro
//     else
//       Begin //si id donn� est inf�rieur ou �gal � z�ro
//         valeurtmp:=NewIDEcriture(ftableecriture,'ID');
//         while FTaEcrituretmp.Locate('ID',valeurtmp,[]) do
//         inc(valeurtmp,1);
//         valeur:=valeurtmp;
//         result:=true;
//       End;//fin si id donn� est inf�rieur ou �gal � z�ro
//   except
//   result:=false;
//   end;//fin du try except
//end;





//procedure TEcriture_Isa.CorrectTaEcritureTmpSurNewID(ID:integer);
//Begin
//Inc(ID,FTaEcrituretmp.RecordCount-1);
//FTaEcrituretmp.last;
//   while not(FTaEcrituretmp.BOF) do
//   Begin
//   FTaEcrituretmp.edit;
//   FTaEcrituretmp.FindField('ID').AsInteger:=ID;
//   FTaEcrituretmp.post;
//   FTaEcrituretmp.prior;
//   inc(ID,-1);
//   End;
//
////FTaEcrituretmp.BeforePost:=; {!!!! A remplir si on impl�mente une procedure OnBeforePost}
////FTaEcrituretmp.AfterPost:=;  {ou OnAfterPost!!!!}
//End;


//procedure TEcriture_Isa.CorrectTaEcritureTmpSurNewIDPiece(IDPiece:integer);
//Begin
//TaEcrituretmp.First;
//   try
//     while not(TaEcrituretmp.EOF)do
//        Begin
//        TaEcrituretmp.Edit;
//        TaEcrituretmp.FindField('ID_Piece').asinteger:=IDPiece;
//        TaEcrituretmp.Post;
//        TaEcrituretmp.next;
//        End;
//   except
//   abort;
//   end;//fin du try
//End;

//Procedure TEcriture_Isa.NewEcriture;
//Begin
//FTaEcrituretmp.open;
//FTaEcrituretmp.Insert;
//End;



function TEcriture_Isa.RecupEcritureSurPieceExistante(IDPiece:integer;ChampIDPiece,ChampTypeLigne:string;Piece:Tpiece):boolean;
var
i,IDidentifiant:integer;
TauxMin,TauxMax:real;
//TableTemp:TTable;
QueryTemp:TQuery;
LigneTemp:TParamLigne_Obj;
TypeLigne,Comptetmp:string;
SensCredit,retourTva,ReadOnly:boolean;
begin
try
InitialiseParamLigne_Obj(LigneTemp);
ReadOnly:=false;
QueryTemp:=TQuery.Create(self);
QueryTemp.DatabaseName:=FtableEcriture.DatabaseName;
//TableTemp.tableName:=FtableEcriture.tableName;
//TableTemp.IndexName:='IDLigne';
//TableTemp.Open;
QueryTemp.SQL.Clear;
QueryTemp.SQL.Add('select * from ecriture');
QueryTemp.SQL.Add('where id_piece=:idpiece and id_ligne = 0');
QueryTemp.SQL.Add('order by id_ligne');
QueryTemp.ParamByName('idpiece').asinteger:=IDPiece;
QueryTemp.Open;
result:=false;
Initialise_TList(ListIdentifiant,nil,false);
//ListIdentifiant.Clear;


//TableTemp.Filter:=(''+ChampIDPiece+'='''+inttostr(IDPiece)+''' and ID_Ligne = ''0''');
//TableTemp.Filtered:=true;
  if QueryTemp.RecordCount<>0 then
  begin
     piece.IDContrepartie:=QueryTemp.findfield('ID').asinteger;
     ListIdentifiantAdd_insert([0,QueryTemp.findfield('ID').asinteger,QueryTemp.findfield('ID').asinteger,
     QueryTemp.findfield('Compte').asstring,
     QueryTemp.findfield('Tiers').asstring,QueryTemp.findfield('Libelle').asstring,
     QueryTemp.findfield('Qt1').asstring,QueryTemp.findfield('Qt2').asstring,
     QueryTemp.findfield('DebitSaisie').AsCurrency,QueryTemp.findfield('CreditSaisie').AsCurrency,
     false,QueryTemp.findfield('TypeLigne').asstring[1], False,False,ReadOnly,ReadOnly,ReadOnly,SensCredit,
     retourTva,ligneTemp.TVA.CodeTva,ligneTemp.TVA.TauxMin,ligneTemp.TVA.TauxMax,LigneTemp.TVA.Compte,
     LigneTemp.TVA.Libelle,LigneTemp.TVA.sensCredit,QueryTemp.findfield('TvaCode').asstring,
     QueryTemp.findfield('TvaType').asstring,QueryTemp.findfield('TvaDate').asstring,QueryTemp.findfield('TvaTaux').asstring,QueryTemp.findfield('Montant_Tva').asstring,true,
     QueryTemp.findfield('TvaCode').asstring,QueryTemp.findfield('TvaType').asstring,QueryTemp.findfield('TvaDate').asstring,
     QueryTemp.findfield('TvaTaux').asstring,QueryTemp.findfield('Montant_Tva').asstring,true,true,'','',0],true,false,-1);
     if ((not Empty(QueryTemp.findfield('Tiers').asstring))or(CompteEstPointable(QueryTemp.findfield('Compte').asstring)))then
       begin
        if piece.ListeContrePartieTiers.IndexOf(inttostr(QueryTemp.findfield('ID').asinteger))=-1then
          begin
            piece.ListeContrePartieTiers.Add(inttostr(QueryTemp.findfield('ID').asinteger));
          end;
       end;
  end
  ELSE
    ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);

QueryTemp.SQL.Clear;
QueryTemp.SQL.Add('select * from ecriture');
QueryTemp.SQL.Add('where id_piece=:idpiece and typeligne =''H'' and id_ligne >0');
QueryTemp.SQL.Add('order by id_ligne');
QueryTemp.ParamByName('idpiece').asinteger:=IDPiece;
QueryTemp.Open;

//   TableTemp.Filter:=(''+ChampIDPiece+'='''+inttostr(IDPiece)+'''and Typeligne =''H'' and ID_ligne > ''0''');
   QueryTemp.first;
   i:=1;
   while not QueryTemp.eof do
   begin
     ListIdentifiantAdd_insert([i,QueryTemp.findfield('ID').asinteger,QueryTemp.findfield('ID').asinteger,
     QueryTemp.findfield('Compte').asstring,
     QueryTemp.findfield('Tiers').asstring,QueryTemp.findfield('Libelle').asstring,
     QueryTemp.findfield('Qt1').asstring,QueryTemp.findfield('Qt2').asstring,
     QueryTemp.findfield('DebitSaisie').AsCurrency,QueryTemp.findfield('CreditSaisie').AsCurrency,
     false,QueryTemp.findfield('TypeLigne').asstring[1], False,False,ReadOnly,ReadOnly,ReadOnly,SensCredit,
     retourTva,ligneTemp.TVA.CodeTva,ligneTemp.TVA.TauxMin,ligneTemp.TVA.TauxMax,LigneTemp.TVA.Compte,
     LigneTemp.TVA.Libelle,LigneTemp.TVA.sensCredit,QueryTemp.findfield('TvaCode').asstring,
     QueryTemp.findfield('TvaType').asstring,QueryTemp.findfield('TvaDate').asstring,QueryTemp.findfield('TvaTaux').asstring,QueryTemp.findfield('Montant_Tva').asstring,true,
     QueryTemp.findfield('TvaCode').asstring,QueryTemp.findfield('TvaType').asstring,QueryTemp.findfield('TvaDate').asstring,
     QueryTemp.findfield('TvaTaux').asstring,QueryTemp.findfield('Montant_Tva').asstring,true,true,'','',0],true,false,-1);
     if ((not Empty(QueryTemp.findfield('Tiers').asstring))or(CompteEstPointable(QueryTemp.findfield('Compte').asstring)))then
       begin
        if piece.ListeContrePartieTiers.IndexOf(inttostr(QueryTemp.findfield('ID').asinteger))=-1then
          piece.ListeContrePartieTiers.Add(inttostr(QueryTemp.findfield('ID').asinteger));
       end;
     QueryTemp.Next;
     inc(i);
   end;

QueryTemp.SQL.Clear;
QueryTemp.SQL.Add('select * from ecriture');
QueryTemp.SQL.Add('where id_piece=:idpiece and typeligne =''T'' and id_ligne >0');
QueryTemp.SQL.Add('order by id_ligne');
QueryTemp.ParamByName('idpiece').asinteger:=IDPiece;
QueryTemp.Open;

//  TableTemp.Filter:=(''+ChampIDPiece+'='''+inttostr(IDPiece)+'''and Typeligne =''T'' and ID_ligne > ''0''');
  if QueryTemp.RecordCount>0 then
  begin
   ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
   inc(i);
  end;

   QueryTemp.first;
   while not QueryTemp.eof do
   begin
  //r�cup�rer les parametres tva complet avec montantMini et Maxi
     ListIdentifiantAdd_insert([i,QueryTemp.findfield('ID').asinteger,QueryTemp.findfield('ID').asinteger,
     QueryTemp.findfield('Compte').asstring,
     QueryTemp.findfield('Tiers').asstring,QueryTemp.findfield('Libelle').asstring,
     QueryTemp.findfield('Qt1').asstring,QueryTemp.findfield('Qt2').asstring,
     QueryTemp.findfield('DebitSaisie').AsCurrency,QueryTemp.findfield('CreditSaisie').AsCurrency,
     false,QueryTemp.findfield('TypeLigne').asstring[1], False,False,ReadOnly,ReadOnly,ReadOnly,SensCredit,
     retourTva,ligneTemp.TVA.CodeTva,ligneTemp.TVA.TauxMin,ligneTemp.TVA.TauxMax,LigneTemp.TVA.Compte,
     LigneTemp.TVA.Libelle,LigneTemp.TVA.sensCredit,QueryTemp.findfield('TvaCode').asstring,
     QueryTemp.findfield('TvaType').asstring,QueryTemp.findfield('TvaDate').asstring,QueryTemp.findfield('TvaTaux').asstring,QueryTemp.findfield('Montant_Tva').asstring,false,
     QueryTemp.findfield('TvaCode').asstring,QueryTemp.findfield('TvaType').asstring,QueryTemp.findfield('TvaDate').asstring,
     QueryTemp.findfield('TvaTaux').asstring,QueryTemp.findfield('Montant_Tva').asstring,true,true,'','',0],true,false,-1);
     QueryTemp.Next;
     inc(i);
   end;
finally
 if QueryTemp<>nil then
   begin
     QueryTemp.close;
     QueryTemp.free;
     QueryTemp:=nil;
   end;
end;//fin du try finally
End;

function TEcriture_Isa.RecupEcritureSurTrame(IDTrame:integer):boolean;
var
i,numLigne:integer;
TableTemp:TTable;
TiersEcriture,CompteEcriture,CompteTva:string;
AjoutLigne:boolean;
Tab:variant;
begin
try
AjoutLigne:=false;
TableTemp:=ttable.Create(self);
TableTemp.DatabaseName:=FTableTrameL.DatabaseName;
TableTemp.tableName:=FTableTrameL.tableName;
TableTemp.filter:='ID_Trame='''+inttostr(IDTrame)+'''';
TableTemp.filtered:=true;
TableTemp.Open;
result:=false;
Initialise_TList(ListIdentifiant,nil,false);
//ListIdentifiant.Clear;
ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);

   try
   if TableTemp.RecordCount<>0 then
      begin//s'il y a des lignes pour cette trame
      TableTemp.filter:='ID_Trame='''+inttostr(IDTrame)+'''and TypeLigne=''H''';
      TableTemp.first; //si la ligne de trame n'est pas une ligne TVA
      i:=1;
      numLigne:=1;
      if TableTemp.RecordCount=0 then
         ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
      while not TableTemp.eof do
         begin
            if copy(TableTemp.findfield('Compte').asstring,1,1)='+'then
              begin
              if not empty(RenvoieInfoSurTableDiverse(TableTemp.findfield('Compte').asstring,piece.TableTiers,'Tiers',['compte'],Tab)) then
                 begin
                 CompteEcriture:=tab[0];
                 TiersEcriture:=TableTemp.findfield('Compte').asstring;
                 end
              else
                 Begin
                   showmessage('Le tiers de la trame n''existe pas dans le plan auxiliaire');
                   abort;
                 End;
              end
            else
              begin
              compteEcriture:=TableTemp.findfield('Compte').asstring;
              TiersEcriture:='';
              end;

            ListIdentifiantAdd_insert([i,0,numLigne,
            compteEcriture,TiersEcriture,TableTemp.findfield('Libelle').asstring,
            TableTemp.findfield('Qt1').asstring,TableTemp.findfield('Qt2').asstring,
            TableTemp.findfield('MontantDebit').ascurrency,TableTemp.findfield('MontantCredit').ascurrency,false,
            TableTemp.findfield('TypeLigne').asstring, False,False,false,false,false,false,false,'',0,0,'','',
            false,TableTemp.findfield('TvaCode').asstring,TableTemp.findfield('TvaType').asstring,
            datetostr(Piece.DateLivraison),TableTemp.findfield('TvaTaux').asfloat,TableTemp.findfield('MontantTva').ascurrency,true,
            TableTemp.findfield('TvaCode').asstring,TableTemp.findfield('TvaType').asstring,
            datetostr(Piece.DateLivraison),TableTemp.findfield('TvaTaux').asfloat,TableTemp.findfield('MontantTva').ascurrency,true,true,'','',0],true,false,-1);
            inc(i);
            inc(numLigne);
          TableTemp.Next;
         end;// fin du while TableTemp.eof

      TableTemp.filter:='ID_Trame='''+inttostr(IDTrame)+'''and TypeLigne=''T''';
      if TableTemp.RecordCount<>0 then
        begin
        ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
        inc(i);
        end;

      TableTemp.first;
      while not TableTemp.eof do
         begin
         
              compteEcriture:=TableTemp.findfield('Compte').asstring;
              TiersEcriture:='';
              ListIdentifiantAdd_insert([i,0,numLigne,
              compteEcriture,TiersEcriture,TableTemp.findfield('Libelle').asstring,
              TableTemp.findfield('Qt1').asstring,TableTemp.findfield('Qt2').asstring,
              TableTemp.findfield('MontantDebit').ascurrency,TableTemp.findfield('MontantCredit').ascurrency,
              false,TableTemp.findfield('TypeLigne').asstring, False,False,false,false,false,false,false,'',0,0,'','',
              false,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
            inc(i);
            inc(numLigne);
           TableTemp.Next;
         end;
      end
      else
        ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
      //fin s'il y a des lignes pour cette trame
   except
     Initialise_TList(ListIdentifiant,nil,false);
//     ListIdentifiant.Clear;
     ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
     ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
     abort;
   end;//fin du try except
finally
 if TableTemp<>nil then
   begin
     TableTemp.close;
     TableTemp.free;
     TableTemp:=nil;
   end;
end;//fin du try finally
End;

//
//procedure TEcriture_Isa.InitialiseTaEcritureTmp;
//var
//Ouverture:boolean;
//Begin
//Ouverture:=TaEcritureTmp.Active;
//  if ouverture then
//  TaEcritureTmp.close;
//TaEcritureTmp.EmptyTable;
//TaEcritureTmp.Active:=Ouverture;
//End;

//
//Procedure TEcriture_Isa.SupprEcriture;
//Begin
////if FTaEcrituretmp.Active=false then
////    FTaEcrituretmp.open;
//FTaEcrituretmp.Delete;
//End;


//Procedure TEcriture_Isa.SupprEcritures;
//Begin
//InitialiseTaEcritureTmp;
//End;



//Procedure TEcriture_Isa.LigneContrePartie(VarRec:Array of const);
//Begin
//FTaEcrituretmp.InsertRecord(VarRec);
//End;


//Procedure TEcriture_Isa.LigneTVA(VarRec:Array of const);
//Begin
//FTaEcrituretmp.InsertRecord(VarRec);
//End;



Function TEcriture_Isa.MinMaxTva(TableTva:TTable;ChampRecherche,ValeurRecherche,ChMin,ChMax,ChCode,ChCompte,ChLib:string):TRecupParamTva_obj;
var
TableTemp:Ttable;
Begin
TableTemp:=TTable.Create(self);
TableTemp.DatabaseName:=TableTva.DatabaseName;
TableTemp.TableName:=TableTva.TableName;
TableTemp.Open;
result.TauxMin:=0;
result.TauxMax:=0;
result.Retour:=TableTemp.Locate(ChampRecherche,ValeurRecherche,[]);
 if result.Retour then
  begin
    result.TauxMin:=TableTemp.FindField(ChMin).AsFloat;
    result.TauxMax:=TableTemp.FindField(ChMax).AsFloat;
    result.Compte:= TableTemp.FindField(ChCompte).Asstring;
    result.Libelle:= TableTemp.FindField(ChLib).Asstring;
    result.CodeTva:= TableTemp.FindField(ChCode).Asstring;
  end;
TableTemp.close;
TableTemp.free;
End;

//Verifie l'existence ou non de lignes d�pendante ou compl�mentaire avec la ligne en cours
//Function TEcriture_Isa.InteractionLigne(TaEcriture:ttable;TypeL:Char;Ligne:TParamLigneObj;LaisserPasserTva:boolean):TErreurLigne;
//var
//TableTmp:ttable;
//CodeTva,TvaCodeCompl:string;
//MontantTVA:Currency;
//Begin
//CodeTva:='';
//TvaCodeCompl:='';
//result.Retour:=true;
//Result.CodeErreur:=0;
////tableTmp:=ttable.Create(self);
////tableTmp.DatabaseName:= TaEcriture.DatabaseName;
////tableTmp.tableName:= TaEcriture.tableName;
////tableTmp.Open;
//   if not TaEcrituretmp.active then
//   TaEcrituretmp.open;
//InitialiseFParamLigneObj;
//FParamLigneObj:=Ligne;
//   case ord(TypeL) of
//    {H} 72,104:Begin
//                if FParamLigneObj.IDJournal in [1,2] then
//                  begin//si journal in [1,2]
//                    if not empty(FParamLigneObj.CompteTva) then
//                      begin
//                      TaEcrituretmp.Filter:='TypeLigne=''T'' and Compte='''+FParamLigneObj.CompteTva+'''';
//                      TaEcrituretmp.Filtered:=true;
//                      result.Retour:=TaEcrituretmp.RecordCount > 0 ;
//                      if not Result.Retour then
//                         Begin
//                            Result.CodeErreur:=2001;{Ligne de TVA non trouv�e}
//                         End
//                         else
//                         Begin {Ligne de TVA trouv�e}
//                            MontantTVA:=TotalCompte(TaEcrituretmp,FParamLigneObj.CompteTva,FParamLigneObj.SensCredit,false);
//                            if (montanttva=0) then
//                               begin
//                               result.retour:=false;
//                               result.codeErreur:=2003;{Montant tva =0, on laisse passer}
//                               end
//                            else
//                            begin
//                              Result.Retour:=VerifMontantTVA(TaEcrituretmp,1,FParamLigneObj.CompteTva,MontantTVA,FParamLigneObj.SensCredit).retour;
//                              if not result.Retour then
//                                begin
//                                   if LaisserPasserTva then
//                                      Begin
//                                      result.retour:=false;
//                                      result.codeErreur:=2004;{Erreur dans le total Tva, mais on laisse passer}
//                                      End
//                                   else
//                                    Result.CodeErreur:=2002;{Erreur dans le total TVA }
//                                end;
//                            end;
//                         End;
//                      TaEcrituretmp.Filtered:=False;
//                      TaEcrituretmp.Filter:='';
//                      end;
//                  end;// fin si journal in [1,2]
//               End;
//    {T} 84,116:Begin
//                if FParamLigneObj.IDJournal in [1,2] then
//                  begin
//                     CodeTva:=RenvoieInfoSurTableDiverse(FParamLigneObj.CompteTva,FTableTVA,'Compte','TvaCode');
//                     if not empty(CodeTva) then
//                     begin//si on trouve un code tva pour la ligne TVA en cours de v�rification
//                     TaEcrituretmp.Filter:='TypeLigne=''H''';
//                     TaEcrituretmp.Filtered:=true;
//                     TaEcrituretmp.First;
//                        while not(TaEcrituretmp.EOF)do
//                        Begin//recherche sur ligne H d'un codeTva = au code tva de la ligne Tva en cours de v�rification
//                           TvaCodeCompl:= TaEcrituretmp.findfield('TvaCode').asstring;
//                           if not empty(TvaCodeCompl) then
//                           begin
//                              if TvaCodeCompl=CodeTva then
//                              begin
//                              result.Retour:=true;
//                              break;
//                              end;
//                           end
//                           else
//                              if ((RenvoieInfoSurTableDiverse(TaEcrituretmp.findfield('Compte').asstring,FTablePlan,'Compte','TvaCode'))=(CodeTva)) then
//                              begin
//                              result.Retour:=true;
//                              break;
//                              end;
//                        TaEcrituretmp.Next;
//                        End;//fin recherche sur ligne H d'un codeTva = au code tva de la ligne Tva en cours de v�rification
//                     if not Result.Retour then
//                        Begin //s'il n'y a pas de ligne H ayant ce code tva
//                           Result.CodeErreur:=1001;{Ligne de Hors Taxe non trouv�e}
//                        End //fin s'il n'y a pas de ligne H ayant ce code tva
//                        else
//                        Begin {Ligne de Hors Taxe trouv�e}
//                        //calcul du total des montants tva sur toutes les lignes HT ayant ce code tva
//                          MontantTVA:=TotalCompte(TaEcrituretmp,FParamLigneObj.CompteTva,FParamLigneObj.SensCredit,false);
//                          Result.Retour:=VerifMontantTVA(TaEcrituretmp,1,FParamLigneObj.CompteTva,MontantTVA,FParamLigneObj.SensCredit).retour;
//                          if not result.Retour then
//                          Result.CodeErreur:=1002;{Erreur dans le total TVA }
//                        End;
//                     TaEcrituretmp.Filtered:=False;
//                     TaEcrituretmp.Filter:='';
//                     end;//fin si la ligne Hors taxe d�pend d'une ligne TVA
//                  end;//fin si journal in [1,2]
//               End;
//    {X} 88,122:Begin
//                 TaEcrituretmp.Filter:='TypeLigne=''H''';
//                 TaEcrituretmp.Filtered:=true;
//                 result.Retour:=TaEcrituretmp.RecordCount > 0 ;
//                 if not Result.Retour then
//                    Begin
//                       Result.CodeErreur:=3001;{Ligne de Hors taxe non trouv�e}
//                    End;
//               End;
//   end;//fin du case of type ligne
//if totalcompte(TaEcrituretmp,'',false,false)<>totalcompte(TaEcrituretmp,'',true,false)then
//begin
//Result.CodeErreur:=4001;{Erreur dans l'Equilibrage de la pi�ce }
//result.Retour:=false;
//end;
////tableTmp.close;
////tableTmp.free;
//
//End;

//Function TEcriture_Isa.TotalCompte(TaEcritureAux:TTable;Compte:string;SensCredit,TypeLigne:boolean):Currency;
//var
//TableTmp:ttable;
//Begin
////tableTmp:=ttable.Create(self);
////tableTmp.DatabaseName:= TaEcritureAux.DatabaseName;
////tableTmp.tableName:= TaEcritureAux.tableName;
////tableTmp.Open;
//if FTaEcrituretmp.Active=false then
//  FTaEcrituretmp.Open;
//
//result:=0;
//FTaEcrituretmp.Filtered:=false;
// if not empty(compte)then
// begin
//   if typeligne then
//      FTaEcrituretmp.Filter:='Compte='''+Compte+'''and TypeLigne<>''X'''
//      else
//      FTaEcrituretmp.Filter:='Compte='''+Compte+'''';
// end
// else
// if typeligne then
//   FTaEcrituretmp.Filter:='TypeLigne<>''X''';
// FTaEcrituretmp.Filtered:=true;
//
// FTaEcrituretmp.First;
// while not FTaEcrituretmp.EOF do
//       Begin
//        if SensCredit then
//           Begin
//              result:=FTaEcrituretmp.findField('Credit').AsCurrency+Result;
//           End
//           else
//           Begin
//              result:=FTaEcrituretmp.findField('Debit').AsCurrency+Result;
//           End;
//         FTaEcrituretmp.Next;
//       End;
// FTaEcrituretmp.Filtered:=false;
// FTaEcrituretmp.Filter:='';
// FTaEcrituretmp.Filtered:=true;
////tableTmp.close;
////tableTmp.free;
//
//End;


//Function TEcriture_Isa.VerifEquilibre(TaEcritureAux:TTable):boolean;
//var
//TableTmp:ttable;
//Begin
//tableTmp:=ttable.Create(self);
//tableTmp.DatabaseName:= TaEcritureAux.DatabaseName;
//tableTmp.tableName:= TaEcritureAux.tableName;
//tableTmp.Open;
//result:=true;
//if totalcompte
//
//end;


Function TEcriture_Isa.VerifMontantTVA(TaEcritureAux:Ttable;ChoixTable:integer;CompteTva:string;MontantTva:Currency;SensCredit:Boolean):TRetourMontantTva;
//var
//TableTemp:TTable;
//MontantTVAMin,MontantTVAMax:Currency;
//MinMaxTaux:TRecupParamTva_obj;
//CodeTva,CodeTvaCompl:string;
//Traitement:boolean;
Begin
//CodeTva:='';
//result.retour:=false;
//TableTemp:=TTable.Create(self);
//TableTemp.DatabaseName:=TaEcritureAux.DatabaseName;
//TableTemp.TableName:= TaEcritureAux.TableName;
//TableTemp.open;
////on r�cup�re le taux mini et maxi du compte tva
// if ((FTableTVA <> nil)and (not empty(CompteTva))) then
// begin
// MinMaxTaux:=MinMaxTva(FTableTva,'Compte',CompteTva,'Taux_inf','Taux_Supp','TvaCode','Compte','Libelle');
// result.retour:=MinMaxTaux.Retour;
// end;
// //on recherche la ligne Tva correspondante dans la table temporaire
// if ChoixTable=1 then
// begin
// if ((result.retour)and (TableTemp.Locate('Compte',CompteTva,[]))) then
// CodeTva:=RenvoieInfoSurTableDiverse(CompteTva,FTableTVA,'Compte','TvaCode');
// end
// else
// Begin
// if ((result.retour)and (FTableTva.Locate('Compte',CompteTva,[]))) then
// CodeTva:=RenvoieInfoSurTableDiverse(CompteTva,FTableTVA,'Compte','TvaCode');
// End;
//
// if not empty(CodeTva) then
// begin //si on trouve un codetva pour la ligne TVA
// TableTemp.Filter:='TypeLigne=''H''';
// TableTemp.Filtered:=true;
// TableTemp.First;
// MontantTVAMin:=0;
// MontantTVAMax:=0;
//   while not(tableTemp.EOF)do
//   Begin//recherche sur ligne H d'un codeTva = au code tva de la ligne Tva en cours de v�rification
//      CodeTvaCompl:='';
//      Traitement:=false;
//      CodeTvaCompl:=tableTemp.FindField('TvaCode').asstring;
//
//      if not empty(CodeTvaCompl)then
//      begin
//         if CodeTvaCompl=CodeTva then
//         Traitement:=true;//ligne H d�pend de la ligne tva en cours
//      end
//      else
//      if ((RenvoieInfoSurTableDiverse(tableTemp.findfield('Compte').asstring,FTablePlan,'Compte','TvaCode'))=(CodeTva)) then
//      Traitement:=true;//ligne H d�pend de la ligne tva en cours
//
//      if Traitement then
//       Begin //si ligne H d�pend de la ligne tva en cours
//       result.RetourMontantMaxi:=0;
//        if SensCredit then
//           Begin
//              Result.RetourMontant:=TableTemp.findField('Credit').AsCurrency+Result.RetourMontant;
//              MontantTVAMin:=TableTemp.findField('Credit').AsCurrency*MinMaxTaux.TauxMin/100+MontantTVAMin;
//              MontantTVAMax:=TableTemp.findField('Credit').AsCurrency*MinMaxTaux.TauxMax/100+MontantTVAMax;
//           End
//           else
//           Begin
//              Result.RetourMontant:=TableTemp.findField('Debit').AsCurrency+Result.RetourMontant;
//              MontantTVAMin:=TableTemp.findField('Debit').AsCurrency*MinMaxTaux.TauxMin/100+MontantTVAMin;
//              MontantTVAMax:=TableTemp.findField('Debit').AsCurrency*MinMaxTaux.TauxMax/100+MontantTVAMax;
//           End;
//       result.RetourMontant:=ArrondiCentieme(result.RetourMontant);
//       MontantTVAMin:=ArrondiCentieme(MontantTVAMin);
//       MontantTVAMax:=ArrondiCentieme(MontantTVAMax);
//       End;//fin si ligne H d�pend de la ligne tva en cours
//   tableTemp.Next;
//   End;//fin recherche sur ligne H d'un codeTva = au code tva de la ligne Tva en cours de v�rification
// end;//fin si on trouve un codetva pour la ligne TVA
// if ((result.RetourMontant<0)and(MontantTva<0)) then
//   result.retour:=((MontantTva>=MontantTVAMax) and (MontantTva<=MontantTVAMin))
// else
//   result.retour:=((MontantTva <= MontantTVAMax) and (MontantTva>=MontantTVAMin));
//TableTemp.close;
//TableTemp.Free;
End;

Function TEcriture_Isa.ArrondiCentieme(Value :Currency) :Currency;
Begin
  Result:= Round(Value * 100) / 100;
end;


//procedure TEcriture_Isa.BeforePostEcritureTmp(DataSet: TDataSet);
//Begin
//TaEcrituretmp.Database.StartTransaction;
//TaEcrituretmp.Database.TransIsolation:=tiDirtyRead;
//End;


//procedure TEcriture_Isa.AfterPostEcritureTmp(DataSet: TDataSet);
//Begin
//TaEcrituretmp.Database.Commit;
//End;


//procedure TEcriture_Isa.PostErrorEcritureTmp(DataSet: TDataSet;
//E: EDatabaseError; var Action: TDataAction);
//Begin
//TaEcrituretmp.Database.Rollback;
//End;
//
//procedure TEcriture_Isa.BeforeDeleteEcritureTmp(DataSet: TDataSet);
//Begin
//TaEcrituretmp.Database.StartTransaction;
//TaEcrituretmp.Database.TransIsolation:=tiDirtyRead;
//End;


//procedure TEcriture_Isa.AfterDeleteEcritureTmp(DataSet: TDataSet);
//Begin
//TaEcrituretmp.Database.Commit;
//End;


//procedure TEcriture_Isa.DeleteErrorEcritureTmp(DataSet: TDataSet;
//E: EDatabaseError; var Action: TDataAction);
//Begin
//TaEcrituretmp.Database.Rollback;
//End;


//function TEcriture_Isa.EnregistrementLigne(Etat:TDataSetState;ID,ID_Piece,ID_Ligne,Id_devise:integer;
//    TLigne,Cpt,Tiers,Lib,TvaCode,TvaType,Rap,Qui:string;Date,TvaDate,Val,Quand:tdate;
//    Qt1,Qt2,DebS,CredS,Deb,Cred,TvaTaux:real):boolean;
//Begin
//   try
//   if not TaEcrituretmp.active then
//   TaEcrituretmp.open;
//result:=true;
//      case etat of
//      dsinsert:Begin//si id_ligne existe deja
//                 if TaEcrituretmp.State=dsbrowse then
//                 begin
//                    if TvaDate<>0 then
//                    TaEcrituretmp.AppendRecord([ID,ID_Piece,TLigne,ID_Ligne,Date,Cpt,Tiers,Lib,Qt1,Qt2,
//                    DebS,CredS,Id_devise,Deb,Cred,TvaCode,TvaType,TvaTaux,TvaDate,Rap,null,Qui,Quand])
//                    else
//                    TaEcrituretmp.AppendRecord([ID,ID_Piece,TLigne,ID_Ligne,Date,Cpt,Tiers,Lib,Qt1,Qt2,
//                    DebS,CredS,Id_devise,Deb,Cred,TvaCode,TvaType,TvaTaux,null,Rap,null,Qui,Quand]);
//                 end
//                 else
//                 begin
//                 abort;
//                 result:=false;
//                 end;
//              end;
//      dsedit: Begin
//               if TaEcrituretmp.State=dsbrowse then
//                  begin
//                  if TaEcrituretmp.Locate('ID_Ligne',ID_Ligne,[])then
//                      begin
//                      ID:=TaEcrituretmp.findfield('ID').asinteger;
//                      SupprEcriture;
//                        if TvaDate<>0 then
//                        TaEcrituretmp.AppendRecord([ID,ID_Piece,TLigne,ID_Ligne,Date,Cpt,Tiers,Lib,Qt1,Qt2,
//                        DebS,CredS,Id_devise,Deb,Cred,TvaCode,TvaType,TvaTaux,TvaDate,Rap,null,Qui,Quand])
//                        else
//                        TaEcrituretmp.AppendRecord([ID,ID_Piece,TLigne,ID_Ligne,Date,Cpt,Tiers,Lib,Qt1,Qt2,
//                        DebS,CredS,Id_devise,Deb,Cred,TvaCode,TvaType,TvaTaux,null,Rap,null,Qui,Quand]);
//                      end
//                      else
//                      begin
//                      abort;
//                      result:=false;
//                      end;
//                  end
//               else
//               begin
//               abort;
//               result:=false;
//               end;
//             End;
//      end;//fin du case etat
//   except
//   abort;
//   result:=false;
//   end;//fin du try except
//End;

//function TEcriture_Isa.RechercheNewIDSurTaEcritureTmp(TableTmp:Ttable;TypeLg:char;var NewID:integer;ChampID:string):boolean;
//var
//Req:tquery;
//Begin
//req:=TQuery.Create(self);
//req.DatabaseName:=TaEcrituretmp.DatabaseName;
//req.SQL.Clear;
//   try
//      try
//      if typeLg in ['H','X'] then
//      req.SQL.Add('Select max('+ChampID+') as resultat from ' +TaEcrituretmp.TableName+' where TypeLigne<>''T''');
//
//      if typeLg in ['T'] then
//      req.SQL.Add('Select min('+ChampID+') as resultat from ' +TaEcrituretmp.TableName+' where TypeLigne='''+TypeLg+'''');
//
//      req.Open;
//      if typeLg in ['H','X'] then
//      NewID:=req.FindField('resultat').Asinteger+1
//      else
//         if typeLg in ['T'] then
//         NewID:=req.FindField('resultat').Asinteger-1;
//      result:=true
//      except
//      showmessage('Probl�me rencontr� lors de la r�cup�ration du nouvel Identifiant !!!');
//      result:=false;
//      abort;
//      end; //fin du except
//   finally
//   req.close;
//   req.free;
//   end;//fin du finally
//End;


procedure TEcriture_Isa.InitialiseFParamLigneObj;
Begin
FParamLigneObj.CompteValide:=false;
FParamLigneObj.TvaMini:=0;
FParamLigneObj.TvaMaxi:=0;
FParamLigneObj.CompteTva:='';
FParamLigneObj.Qt1:=true;
FParamLigneObj.Qt2:=true;
FParamLigneObj.SensCredit:=false;
End;


//procedure TEcriture_Isa.TransformeIdNegatifSurTaEcritureTmp(Max:integer);
//var
//tableTmp:ttable;
//i,Rec:integer;
//Begin
//tableTmp:=ttable.Create(self);
//tableTmp.DatabaseName:= TaEcritureTmp.DatabaseName;
//tableTmp.tableName:= TaEcritureTmp.tableName;
//tableTmp.Open;
//tableTmp.Filter:='ID<''0''';
//tableTmp.Filtered:=true;
//Rec:=tableTmp.recordcount;
//i:=1;
//tableTmp.first;
//   while i<=rec do
//     Begin
//     tableTmp.edit;
//     tableTmp.FindField('ID').asinteger:=abs(tableTmp.FindField('ID').asinteger)+Max;
//     tableTmp.Post;
//     tableTmp.Next;
//     inc(i);
//     End;
//TaEcrituretmp.Refresh;
//tableTmp.close;
//tableTmp.free;
//End;


//procedure TEcriture_Isa.CorrigeTaEcritureTmpSurID_Org(IDLigne,ID_Org:integer);
//var
//tableTmp:ttable;
//i,Rec:integer;
//Begin
//tableTmp:=ttable.Create(self);
//tableTmp.DatabaseName:= FTaEcrituretmp.DatabaseName;
//tableTmp.tableName:= FTaEcrituretmp.tableName;
//tableTmp.Open;
//if  tableTmp.Locate('ID',IDLigne,[]) then
//Begin
//tableTmp.edit;
//tableTmp.FindField('ID').asinteger:=ID_Org;
//tableTmp.Post;
//End;
//tableTmp.close;
//tableTmp.free;
//end;


//procedure TEcriture_Isa.DecaleIdLigneSurTaEcritureTmp(IDDepart:integer);
//var
//tableTmp:ttable;
//IDLigne:integer;
//Begin
//tableTmp:=ttable.Create(self);
//tableTmp.DatabaseName:= TaEcritureTmp.DatabaseName;
//tableTmp.tableName:= TaEcritureTmp.tableName;
//tableTmp.Open;
//tableTmp.first;
//IDLigne:=1;
//   while not(tableTmp.EOF) do
//     Begin
//     tableTmp.edit;
//     tableTmp.FindField('ID_Ligne').asinteger:=IDLigne;
//     tableTmp.Post;
//     tableTmp.Next;
//     inc(IDLigne);
//     End;
//tableTmp.first;
//if ((IDDepart <>-1)and (tableTmp.FindField('ID').asinteger<>IDDepart)) then
//begin //si demande gestion des d�calage par rapport � FirstIDEcriture
//   while not(tableTmp.EOF) do
//     Begin
//     tableTmp.edit;
//     tableTmp.FindField('ID').asinteger:=IDDepart;
//     tableTmp.Post;
//     tableTmp.Next;
//     inc(IDDepart);
//     End;
//end;
//
//TaEcrituretmp.Refresh;
//tableTmp.close;
//tableTmp.free;
//End;


//R�cup�re le code tva dans table de Recherche par rapport � un compte



//procedure TEcriture_Isa.ChangeComplementLigneSurIdEcriture(IDEcriture:integer);
//Begin
//   try
//   if not TaEcrituretmp.active then
//   TaEcrituretmp.open;
//    if TaEcrituretmp.Locate('ID',IDEcriture,[])then
//      Begin
//      TaEcrituretmp.Edit;
//      TaEcrituretmp.FindField('TvaCode').asstring:='';
//      TaEcrituretmp.FindField('TvaDate').AsDateTime:=0;
//      TaEcrituretmp.FindField('Tvatype').asstring:='';
//      TaEcrituretmp.FindField('TvaTaux').asfloat:=0;
//      TaEcrituretmp.post;
//      End;
//   except
//    //
//    abort;
//   end;
//End;


function TEcriture_Isa.Verif_Liste_Grille_SurLigne(rang:integer;Liste:tlist;Grille:TGRGrid):TerreurListe;
Begin
  result.CodeErreur:=0;
  result.Retour:=true;
  if ((liste<>nil) and (grille<>nil)) then
    Begin
      if ((liste.Count<>0) and(grille.rowcount<>0)and (rang>=0))then
        Begin
          if Pidentifiant_obj(liste.items[rang])^.Ligne.Compte<>grille.Cells[1,rang]then
           Begin
            result.CodeErreur:=1000;
            exit;
           End;
          if Pidentifiant_obj(liste.items[rang])^.Ligne.Libelle<>grille.Cells[2,rang]then
           Begin
            result.CodeErreur:=2000;
            exit;
           End;
          if Pidentifiant_obj(liste.items[rang])^.Ligne.Qt1<>grille.Cells[3,rang]then
           Begin
            result.CodeErreur:=3000;
            exit;
           End;
          if Pidentifiant_obj(liste.items[rang])^.Ligne.Qt2<>grille.Cells[4,rang]then
           Begin
            result.CodeErreur:=4000;
            exit;
           End;
          if currtostr(Pidentifiant_obj(liste.items[rang])^.Ligne.Debit)<>grille.Cells[5,rang]then
           Begin
            result.CodeErreur:=5000;
            exit;
           End;
          if currtostr(Pidentifiant_obj(liste.items[rang])^.Ligne.Credit)<>grille.Cells[6,rang]then
           Begin
            result.CodeErreur:=6000;
            exit;
           End;
        if result.CodeErreur>0 then
          result.Retour:=false;
        End
      else
        Begin
          result.CodeErreur:=9000;//grille ou liste vide
          result.Retour:=false;
        End;
    End
  else
    Begin
      result.CodeErreur:=9001;//grille ou liste pas cr��e
      result.Retour:=false;
    End;
End;


function TEcriture_Isa.Verif_Liste_Grille_Entiere(Liste:Tlist;Grille:TGrGrid):TerreurListe;
var
i:integer;
Begin
  if ((liste<>nil) and (grille<>nil)) then
    Begin//si liste cr��e et grille cr��e
      if liste.Count=grille.RowCount then
        Begin
          for i:=1 to grille.RowCount-1 do
          Begin
            result:=Verif_Liste_Grille_SurLigne(i,liste,grille);
          End;
        End
      else
        begin
        result.CodeErreur:=9002;//longueur liste <> longueur grille
        result.Retour:=false;
        end;
    end//fin si liste cr��e et grille cr��e
  else
    Begin
      result.CodeErreur:=9001;//grille ou liste pas cr��e
      result.Retour:=false;
    End;
End;


function TEcriture_Isa.InfosPiece_SurTypeLigne(TypeLignes:array of Char;Liste:Tlist;CompteTva:string;SensTva:integer;TousSens,TousCompteTva:boolean;ligne:integer):TInfosPiece_SurTypeLigne;
var
i,j,RangCptTva:integer;
compteRecup:string;
tab:variant;
maxLigne:integer;
SensLigne:integer;
Begin
  try
  result.Debit:=0;
  result.Credit:=0;
  result.Solde:=0;
  result.montanttva:=0;
  result.NbLigne:=0;
  result.SensSoldeCredit:=0;
  result.SenssoldeTva:=0;
  sensligne:=0;
  result.IndexLignes:=TListInteger.Create;
  if Ligne<>-1 then
    begin
      maxLigne:=ligne;
    end
  else
    begin
      ligne:=0;
      maxLigne:=Liste.count-1;
    end;
    if Liste<>nil then
      Begin//si liste cr��e
        for i:=ligne to maxLigne do
          Begin //for longueur liste
            for j:=0 to high(typeLignes)do
              Begin //for longueur typeLignes
                if Pidentifiant_obj(Liste.items[i])^.Ligne.TypeLigne=typeLignes[j] then
                   Begin //si typeLigne correspondent
                   if (Pidentifiant_obj(Liste.items[i])^.Ligne.debit<Pidentifiant_obj(Liste.items[i])^.Ligne.credit) then
                     sensligne:=C_SensSoldeCredit
                   else
                     if Pidentifiant_obj(Liste.items[i])^.Ligne.debit>Pidentifiant_obj(Liste.items[i])^.Ligne.credit then
                       sensligne:=C_SensSoldeDebit;
                     if ((not empty(CompteTva))or(TousCompteTva))then
                        Begin //si codetva rempli
                        if (typeLignes[j]='T')then
                          Begin ///si type ligne TVA
                          if TousCompteTva then
                             begin//si tous comptes tva confondus
                             if (TousSens) then
                               Begin
                                  result.Debit:=Result.Debit+Pidentifiant_obj(Liste.items[i])^.Ligne.Debit;
                                  result.Credit:=Result.Credit+Pidentifiant_obj(Liste.items[i])^.Ligne.credit;
                                  result.IndexLignes.Add(i);
                               End
                             else
                              if sensligne=SensTva then
                                Begin
                                  result.Debit:=Result.Debit+Pidentifiant_obj(Liste.items[i])^.Ligne.Debit;
                                  result.Credit:=Result.Credit+Pidentifiant_obj(Liste.items[i])^.Ligne.credit;
                                  result.IndexLignes.Add(i);
                                End;
                             end//fin si tous comptes tva confondus
                           else
                             begin//si compte tva d�fini
                             if ((TousSens)and(CompteTva=Pidentifiant_obj(Liste.items[i])^.Ligne.Compte)) then
                               Begin
                                  result.Debit:=Result.Debit+Pidentifiant_obj(Liste.items[i])^.Ligne.Debit;
                                  result.Credit:=Result.Credit+Pidentifiant_obj(Liste.items[i])^.Ligne.credit;
                                  result.IndexLignes.Add(i);
                               End
                             else
                              if ((CompteTva=Pidentifiant_obj(Liste.items[i])^.Ligne.Compte)and(sensligne=SensTva)) then
                                Begin
                                  result.Debit:=Result.Debit+Pidentifiant_obj(Liste.items[i])^.Ligne.Debit;
                                  result.Credit:=Result.Credit+Pidentifiant_obj(Liste.items[i])^.Ligne.credit;
                                  result.IndexLignes.Add(i);
                                End;
                             end;//fin si compte tva d�fini
                          End;///fin si type ligne TVA
                        if (typeLignes[j]='H')then
                          Begin///si type ligne Hors Taxes
                          RenvoieInfoSurTableDiverse(Pidentifiant_obj(Liste.items[i])^.Ligne.Complement.CodeTvaCompl,FTableTVA,'TvaCode',['Compte'],Tab);
                          compteRecup:=Tab[0];
                          if ((toussens)and(CompteTva=compteRecup)) then
                            Begin
                                result.Debit:=Result.Debit+Pidentifiant_obj(Liste.items[i])^.Ligne.Debit;
                                result.Credit:=Result.Credit+Pidentifiant_obj(Liste.items[i])^.Ligne.credit;
                                if Pidentifiant_obj(Liste.items[i])^.Ligne.credit>0 then
                                  result.montanttva:=result.montanttva+Pidentifiant_obj(Liste.items[i])^.Ligne.Complement.MontantTva
                                else
                                  if Pidentifiant_obj(Liste.items[i])^.Ligne.debit>0 then
                                    result.montanttva:=result.montanttva-Pidentifiant_obj(Liste.items[i])^.Ligne.Complement.MontantTva;
                                result.IndexLignes.Add(i);
                            End
                          else
                            if ((CompteTva=compteRecup)and(sensligne=sensTva)) then
                              Begin
                                result.Debit:=Result.Debit+Pidentifiant_obj(Liste.items[i])^.Ligne.Debit;
                                result.Credit:=Result.Credit+Pidentifiant_obj(Liste.items[i])^.Ligne.credit;
                                if Pidentifiant_obj(Liste.items[i])^.Ligne.credit>0 then
                                  result.montanttva:=result.montanttva+Pidentifiant_obj(Liste.items[i])^.Ligne.Complement.MontantTva
                                else
                                  result.montanttva:=result.montanttva-Pidentifiant_obj(Liste.items[i])^.Ligne.Complement.MontantTva;
                                result.IndexLignes.Add(i);
                              End;
                          End; ///fin si type ligne Hors Taxes
                        end//fin si compte tva rempli
                     else
                        Begin //si compte tva pas rempli ,
                        //sert � conna�tre le solde de la pi�ce uniquement
                         result.Debit:=Result.Debit+Pidentifiant_obj(Liste.items[i])^.Ligne.Debit;
                         result.Credit:=Result.Credit+Pidentifiant_obj(Liste.items[i])^.Ligne.credit;
                         result.IndexLignes.Add(i);
                        End;//fin si compte tva pas rempli
                   End;//fin si typeLigne correspondent
              End;//fin for longueur typeLignes
          End;//fin for longueur liste
      if result.Debit>result.Credit then
        Begin  //si solde d�biteur
          result.Solde:=abs(result.Debit-result.Credit);
          result.SensSoldeCredit:=C_SensSoldeDebit;
        End
      else
       if result.Debit<result.Credit then
        Begin//si le solde est cr�diteur
          result.Solde:=abs(result.Credit-result.Debit);
          result.SensSoldeCredit:=C_SensSoldeCredit;
        End
        else
          if result.Debit=result.Credit then
            Begin//si le solde est nul, le sens est ind�termin� !!!!!!!!!
             result.Solde:=0;
             result.SensSoldeCredit:=C_SensSoldeNul;
            End;
      if result.montanttva>0 then
        result.SenssoldeTva:=1
      else
        if result.montanttva<0 then
          result.SenssoldeTva:=-1;
      result.montanttva:=abs(result.montanttva);
      End;//fin si liste cr��e
  finally
   result.NbLigne:=result.IndexLignes.Count;
  end;//fin du try finally
End;


function TEcriture_Isa.Liste_ObjIndexOf(Liste:Tlist;valeur:string;valeurRech:integer):integer;
var
i:integer;
Begin
result:=-1;
i:=0;
   while i<= Liste.Count-1 do
   begin
     case valeurRech of
     0: if inttostr(Pidentifiant_obj(Liste.items[i])^.IDLigne)=valeur then
        begin
        result:=i;
        i:=Liste.Count-1;
        end;
     1: if inttostr(Pidentifiant_obj(Liste.items[i])^.ID_Tmp)=valeur then
        begin
        result:=i;
        i:=Liste.Count-1;
        end;
     9: if Pidentifiant_obj(Liste.items[i])^.Ligne.TypeLigne=valeur then
        begin
        result:=i;
        i:=Liste.Count-1;
        end;
     end;//fin du case
   inc(i);
   end;
End;


Function TEcriture_Isa.InteractionLigne_SurListe(Liste:Tlist;rang:integer;IDJournal:integer):TErreurLigne;
var
MessageLGR:TMessageLGR;
MontantTVA:currency;
CodeTva:string;
InfosLignePieceH,InfosLignePieceT:TInfosPiece_SurTypeLigne;
MinTva,MaxTva:currency;
tab:variant;
SensLigne:integer;
conteneurVerrou_Piece,conteneurVerrou_Ligne:TVerrouillage;
DateTva_Valide:Tdatetime;
MontantTva_Valide:TMontantTva_Valide;
Begin
SensLigne:=0;
Initialise_TErreurLigne(result);
if liste.count>rang then
begin//si ligne recherch�e valide
     //v�rifier le verrouillage de la pi�ce
     conteneurVerrou_Piece:=Piece.RetourneInfosVerrouillageSurPiece(piece,piece.FirstIDPiece,Piece.DateSaisie);
     result.retour:=not conteneurVerrou_Piece.PieceVerrouillee;
     if not result.retour then
       Begin//si Piece verrouill�e
         if conteneurVerrou_Piece.Deverrouillable then
           begin//si deverrouillable, on propose de supprimer la derni�re d�claration
              if Application.MessageBox(PChar('La pi�ce  '+Piece.Reference+' fait partie d''une d�claration de TVA, si vous la modifiez, vous devez supprimer la derni�re d�claration de TVA, Voulez-vous enregistrer ces modifications ?'),'Erreur de TVA',MB_YESNO + MB_DEFBUTTON2) = mryes then
                begin //si on veut supprimer la derni�re d�claration
                  Result.CodeErreur:=12000;//code de suppression de la derni�re d�claration
                  //abort;
                end//fin si on veut supprimer la derni�re d�claration
              else
                abort;
           end//fin si deverrouillable
         else
           Begin//si non deverrouillable
             Messagedlg('La pi�ce '+Piece.Reference+' fait partie d''une d�claration de TVA non modifiable, vous ne pouvez donc pas modifier cette pi�ce',MtConfirmation,[mbok],0);
             abort;
           End;//fin si non deverrouillable
       End;//fin si Piece verrouill�e
   if result.retour then
   case ord(Pidentifiant_obj(Liste.items[rang])^.Ligne.TypeLigne) of
    {H} 72,104:Begin
                if IDJournal in [1,2] then
                  begin//si journal in [1,2]
                    if ((not empty(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl))and
                    ((UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'L')and
                       (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'E')and
                       (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'C')and
                       (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'M')and
                       (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'F')and
                       (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'N')))then
                      begin //rechercher s'il existe une ligne TVA du m�me code
                      SensLigne:=RecupSens_Et_SoldeSurEcritureListe(rang,FListIdentifiant).SensSoldeCredit;
                      RenvoieInfoSurTableDiverse(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,FTableTVA,'TvaCode',['Compte'],Tab);
                      InfosLignePieceT:=InfosPiece_SurTypeLigne(['T'],Liste,tab[0],SensLigne,true,false,-1);
                      Result.Retour:=not((InfosLignePieceT.NbLigne=0)and(InfosLignePieceT.Solde<>0));
                      if ((result.retour)and(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.MontantTva<e.ParamArrondisTVA)) then
                        Begin
                          if Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaType<>'D' then
                            Begin
                               Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaType:='D';
                               if datevalide(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaDate)then
                                 DateTva_Valide:=strtodate(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaDate)
                               else
                                 DateTva_Valide:=Piece.DateLivraison;
                               //if not DateDsIntervale(e.DateDebutDeclarationTVA,DateTva_Valide,e.DateFinDeclarationTVA,MessageLGR)then
                               if (e.DateDebutDeclarationTVA>DateTva_Valide)and(piece.AnneePiece.PieceAnterieure=false) then
                                 DateTva_Valide:=e.DateDebutDeclarationTVA;
                               Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaDate:=datetostr(DateTva_Valide);
                            End;
                        End;
                      if ((Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl<>'')and(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl[1]<>'T'))
                      and((result.retour)and(((InfosLignePieceT.Solde=0))or
                          ((Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.MontantTva=0)))) then
                      InitialiseComplement_Obj(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement);
                      end;
                  if((UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'L')and
                   (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'E')and
                   (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'C')and
                   (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'M')and
                   (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'F')and
                   (UpperCase(copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl,1,1))<>'N')) then
                      begin //rechercher s'il existe une ligne TVA du m�me code
                      if not result.retour then
                         Begin
                            Result.CodeErreur:=12001;{Ligne de TVA non trouv�e}
                            result.CompteConcerne:=Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl;
                            result.MessageErreur.MessageErreur:='Il manque une ligne de Tva sur le compte '+result.CompteConcerne+'. Vous devez corriger la pi�ce '+Piece.Reference+'.'
                         End;
                      end;//fin rechercher s'il existe une ligne TVA du m�me code
                if ((not empty(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.CodeTvaCompl))and(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaType='D')) then
                   begin//si ligne contient de la tva sur d�bit
                   if (e.DateDebutDeclarationTVA> strtodate(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaDate))and
                   (piece.AnneePiece.PieceAnterieure=false) then
                       Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaDate:=datetostr(e.DateDebutDeclarationTVA);
                     if datevalide(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaDate) then
                       conteneurVerrou_Ligne:=Piece.RetourneInfosVerrouillageSurPiece(piece,piece.FirstIDPiece,strtodate(Pidentifiant_obj(Liste.items[rang])^.Ligne.Complement.TvaDate))
                     else
                       conteneurVerrou_Ligne:=Piece.RetourneInfosVerrouillageSurPiece(piece,piece.FirstIDPiece,0);
                     result.retour:=(not conteneurVerrou_Ligne.PeriodeVerrouillee)or(piece.AnneePiece.PieceAnterieure=true);
                     if not result.retour then
                       Begin//si Periode Verrouillee
                         if conteneurVerrou_Ligne.PeriodeDeverrouillable then
                           begin//si periode deverrouillable
                              if Application.MessageBox(PChar('La date d''exigibilit� de la TVA de la ligne '+inttostr(rang)+' fait partie d''une d�claration de TVA, si vous la conservez, vous devez supprimer la derni�re d�claration de TVA, Voulez-vous la conserver ?'),'Erreur de TVA',MB_YESNO + MB_DEFBUTTON2) = mryes then
                                begin //si on veut supprimer la derni�re d�claration
                                  Result.CodeErreur:=12000;//code de suppression de la derni�re d�claration
                                  //abort;
                                end//fin si on veut supprimer la derni�re d�claration
                              else
                                abort;
                           end//fin si periode deverrouillable
                         else
                           Begin//si non deverrouillable
                             Messagedlg('La date d''exigibilit� de la TVA de la ligne '+inttostr(rang)+' fait partie d''une d�claration de TVA non modifiable, vous ne pouvez donc pas enregistrer la pi�ce '+Piece.Reference+' avec de la tva exigible dans cette p�riode',MtConfirmation,[mbok],0);
                             abort;
                           End;//fin si non deverrouillable
                       End;//fin si Periode Verrouillee
                   end;//fin si ligne contient de la tva sur d�bit
                  end;// fin si journal in [1,2]
                  if IDJournal in [3] then
                    begin//si journal in [3]
                      InfosLignePieceH:=InfosPiece_SurTypeLigne(['H','T','X'],Liste,'',0,false,false,-1);
                         if ((InfosLignePieceH.NbLigne>0)and (((InfosLignePieceH.Debit<>0)or(InfosLignePieceH.Credit<>0)))) then
                           begin
                             result.Retour:=InfosLignePieceH.Solde=0 ;
                             if not result.Retour then
                               begin
                                result.CodeErreur:=3001;//piece pas �quilibr�e
                                result.MessageErreur.MessageErreur:='Attention !!, La pi�ce '+Piece.Reference+' n''est pas �quilibr�e, Vous devez la corriger.';
                               end;
                           end
                         else
                           Begin
                             result.CodeErreur:=3002;//pi�ce vide;
                             result.MessageErreur.MessageErreur:='Attention !!, La pi�ce '+Piece.Reference+' est vide, Vous devez la compl�ter. ';
                             result.Retour:=false;
                           End;
                    end;//fin si journal in [3]
               End;//fin si typeligne H
    {T} 84,116:Begin
                if IDJournal in [1,2] then
                  begin
                  SensLigne:=RecupSens_Et_SoldeSurEcritureListe(rang,FListIdentifiant).SensSoldeCredit;
                    InfosLignePieceH:=InfosPiece_SurTypeLigne(['H'],Liste,Pidentifiant_obj(Liste.items[rang])^.Ligne.Compte,SensLigne,true,false,-1);
                    InfosLignePieceT:=InfosPiece_SurTypeLigne(['T'],Liste,Pidentifiant_obj(Liste.items[rang])^.Ligne.Compte,sensligne,true,false,-1);
//                    MinTva:=ArrondiCentieme(InfosLignePieceH.Solde*Pidentifiant_obj(Liste.items[rang])^.Ligne.TVA.TauxMin/100);
//                    MaxTva:=ArrondiCentieme(InfosLignePieceH.Solde*Pidentifiant_obj(Liste.items[rang])^.Ligne.TVA.TauxMax/100);
                    //if ((InfosLignePieceT.Solde>=MinTva) and (InfosLignePieceT.Solde<=MaxTva)and(InfosLignePieceH.SensSoldeCredit=InfosLignePieceT.SensSoldeCredit)) then
                    MontantTva_Valide:=Recup_MontantTva_Valide(InfosLignePieceT.Solde,0,Pidentifiant_obj(Liste.items[rang])^.Ligne.TVA);
                    if ((MontantTva_Valide.retour) and(InfosLignePieceH.SensSoldeCredit=InfosLignePieceT.SensSoldeCredit)) then
                       Begin
                         result.CodeErreur:=12005;// Montant tva OK
                         result.retour:=true;
                       End
                    else
                      Begin//si montant tva valide
                          if (InfosLignePieceT.Solde+0.02<MontantTva_Valide.MontantMini)then
                             Begin //si tva inf�rieur au minimum
                               result.CompteConcerne:=Pidentifiant_obj(Liste.items[rang])^.Ligne.Compte;
                               if copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.TVA.CodeTva,1,1)='V' then
                                  begin //si tva sur ventes
                                    result.CodeErreur:=120062;// Montant tva faux sur ventes,
                                    result.MessageErreur.MessageErreur:='Attention !!, Montant de Tva incoh�rent sur le compte '+result.CompteConcerne+'. Vous devez le corriger.';
                                    result.MessageErreur.MessageQuestion:='Attention !!, Montant de Tva incoh�rent sur le compte '+result.CompteConcerne+'. Voulez-vous le conserver ?'
                                  end
                               else
                                 if (InfosLignePieceH.SensSoldeCredit<>InfosLignePieceT.SensSoldeCredit) then
                                  begin
                                    result.CodeErreur:=120061;// Montant tva faux sur inversement,
                                    result.MessageErreur.MessageErreur:='Attention !!, Montant de Tva incoh�rent sur le compte '+result.CompteConcerne+'. Voulez-vous le conserver ?';
                                  end
                                 else
                                  Begin
                                     result.CodeErreur:=120060;// Montant tva faux,
                                     result.MessageErreur.MessageErreur:='Attention !!, Montant de Tva incoh�rent sur le compte '+result.CompteConcerne+'. Voulez-vous le conserver ?';
                                  End;
                               result.retour:=false;
                               result.CompteConcerne:=Pidentifiant_obj(Liste.items[rang])^.Ligne.Compte;
                               result.Modif.NewRow:=rang;
                             End;//fin si tva inf�rieur au minimum
                          if (InfosLignePieceT.Solde-0.02>MontantTva_Valide.MontantMaxi) then
                             Begin //si tva sup�rieur au maximum
                               result.CompteConcerne:=Pidentifiant_obj(Liste.items[rang])^.Ligne.Compte;
                               if (copy(Pidentifiant_obj(Liste.items[rang])^.Ligne.TVA.CodeTva,1,1)='V')then
                                  begin
                                    result.CodeErreur:=120072;// Montant tva sup�rieur au maxi sur ventes
                                    result.MessageErreur.MessageErreur:='Attention !!, Montant de Tva incoh�rent sur le compte '+result.CompteConcerne+'. Vous devez le corriger.';
                                    result.MessageErreur.MessageQuestion:='Attention !!, Montant de Tva incoh�rent sur le compte '+result.CompteConcerne+'. Voulez-vous le conserver ?';
                                  end
                               else
                                 if (InfosLignePieceH.SensSoldeCredit<>InfosLignePieceT.SensSoldeCredit) then
                                   begin
                                     result.CodeErreur:=120071;// Montant tva sup�rieur au maxi
                                     result.MessageErreur.MessageErreur:='Attention !!, Montant de Tva incoh�rent sur le compte '+result.CompteConcerne+'. Voulez-vous le conserver ?';
                                   end
                                 else
                                   begin
                                     result.CodeErreur:=120070;// Montant tva sup�rieur au maxi sur inversement
                                     result.MessageErreur.MessageErreur:='Attention !!, Montant de Tva incoh�rent sur le compte '+result.CompteConcerne+'. Voulez-vous le conserver ?';
                                   end;
                               result.retour:=false;
                               result.Modif.NewRow:=rang;
                             End;//fin si tva sup�rieur au maximum
                      End;//fin si montant tva valide
                  end;//fin si journal in [1,2]
               End;
    {X} 88,122:Begin
                    InfosLignePieceH:=InfosPiece_SurTypeLigne(['H','T'],Liste,'',0,false,false,-1);
                    result.retour:=InfosLignePieceH.Solde<>0;
                    if result.retour then
                      begin
                        if Pidentifiant_obj(Liste.items[rang])^.Ligne.debit>Pidentifiant_obj(Liste.items[rang])^.Ligne.Credit then
                        Result.retour:=InfosLignePieceH.Solde=Pidentifiant_obj(Liste.items[rang])^.Ligne.Debit
                        else
                        Result.retour:=InfosLignePieceH.Solde=Pidentifiant_obj(Liste.items[rang])^.Ligne.Credit;
                      end;
                    if not result.retour then
                      begin
                       result.CodeErreur:=12008;{Piece pas �quilibr�e}
                       result.MessageErreur.MessageErreur:='Attention !!, La pi�ce '+Piece.Reference+' n''est pas �quilibr�e, Vous devez la corriger.';
                       InfosLignePieceH:=InfosPiece_SurTypeLigne(['H'],Liste,'',0,false,false,-1);
                         if InfosLignePieceH.NbLigne=0 then
                            begin
                              result.CodeErreur:=12009;{Piece pas �quilibr�e, pas de lignes H trouv�es}
                              result.MessageErreur.MessageErreur:='Attention !!, La pi�ce '+Piece.Reference+' est vide, Vous devez la compl�ter. ';
                            end;
                         if (InfosLignePieceH.solde=0) then
                            begin
                              result.CodeErreur:=120010;{Piece avec solde =0 }
                              result.MessageErreur.MessageErreur:='Attention !!, La pi�ce '+Piece.Reference+' a un solde nul, la ligne de contrepartie de peut pas �tre cr��e. ';
                            end;
                      end;
               End;
   end;//fin du case of type ligne
end;//fin si ligne recherch�e valide
End;

function TEcriture_Isa.Verif_Liste_Table_Entiere(Liste:tlist;Table:TTable):TExceptLGR;
var
i,conteneur:integer;
ChampCompte:string;
Begin
try
  result.GestMessageLGR:=GestMessageLGR;
  result.NomModule:='Verif_Liste_Table_Entiere';
  if ((liste<>nil) and (table<>nil)) then
    Begin//si liste et table cr��es
      if ((liste.Count<>0) and (table.RecordCount<>0))then
        Begin//si liste et table remplie
          for i:=0 to liste.count-1 do
            Begin//d�but de boucle for
            if ((Pidentifiant_obj(liste.items[i])^.Ligne.Enregistrer)and(Pidentifiant_obj(liste.items[i])^.ligne.TypeLigne<>'V'))then
               begin//si la ligne � �t� enregistr�e dans la table
                 conteneur:=Pidentifiant_obj(liste.items[i])^.ID_Tmp;
                 if table.Locate('ID',Pidentifiant_obj(liste.items[i])^.ID_Tmp,[])then
                     Begin//si on trouve l'enregistrement dans la table
                          if Pidentifiant_obj(liste.items[i])^.Ligne.TypeLigne<>table.FindField('TypeLigne').asstring then
                            raise ExceptLGR.Create('Probl�me sur TypeLigne',1000,false,mtError,result);
                          if Pidentifiant_obj(liste.items[i])^.Ligne.Compte<>table.FindField('Compte').asstring then
                            raise ExceptLGR.Create('Probl�me sur Compte',2000,false,mtError,result);
                          if Pidentifiant_obj(liste.items[i])^.Ligne.Tiers<>table.FindField('Tiers').asstring then
                            raise ExceptLGR.Create('Probl�me sur Tiers',3000,false,mtError,result);
                          if Pidentifiant_obj(liste.items[i])^.Ligne.Debit<>table.FindField('DebitSaisie').ascurrency then
                            raise ExceptLGR.Create('Probl�me sur D�bit',4000,false,mtError,result);
                          if Pidentifiant_obj(liste.items[i])^.Ligne.Credit<>table.FindField('CreditSaisie').ascurrency then
                            raise ExceptLGR.Create('Probl�me sur Cr�dit',5000,false,mtError,result);
                          if Pidentifiant_obj(liste.items[i])^.Ligne.TypeLigne<>'T' then
                             if Pidentifiant_obj(liste.items[i])^.Ligne.complement.CodeTvaCompl<>table.FindField('TvaCode').asstring then
                            raise ExceptLGR.Create('Probl�me sur Code Tva',6000,false,mtError,result);
                     End//fin si on trouve l'enregistrement dans la table
                 else
                     Begin//si on ne trouve pas l'enregistrement dans la table
                       raise ExceptLGR.Create('Probl�me sur ID Ligne liste pas trouv�e dans table',9002,false,mtError,result);
                     End;//fin si on ne trouve pas l'enregistrement dans la table
               end;//fin si la ligne � �t� enregistr�e dans la table
            End;//fin de boucle for
        End//si liste et table remplie
      else
        Begin//si liste ou table vide
          raise ExceptLGR.Create('Probl�me sur liste vide ou table vide',9000,false,mtError,result);
        End;//fin si liste ou table vide
    End//fin si liste et table cr��es
  else
    Begin//si liste ou table nil
      raise ExceptLGR.Create('Probl�me sur grille ou liste pas cr��e',9001,false,mtError,result);
    End;//fin si liste ou table nil
except
  showmessage(result.Mess);
  abort;
end;
End;

procedure TEcriture_Isa.InitialiseCreationLigne_Obj(var ParamCreation:TCreation_Obj);
Begin
ParamCreation.Existe:=false;
ParamCreation.Acreer:=false;
ParamCreation.NumLigne:=0;
ParamCreation.TypeLigne:='V';
ParamCreation.CodeTva:='';
ParamCreation.CompteTva:='';
ParamCreation.LibelleTva:='';
ParamCreation.SensCredit:=false;
End;


procedure TEcriture_Isa.InitialiseComplement_Obj(var ComplementLigne:TComplementLigne_Obj);
Begin
ComplementLigne.CodeTvaCompl:='';
ComplementLigne.rempli:=false;
ComplementLigne.TvaDate:='';
ComplementLigne.TvaTaux:=0;
ComplementLigne.TvaType:='';
ComplementLigne.MontantTva:=0;
//
end;

procedure TEcriture_Isa.InitialiseParamLigne_Obj(var Parametre:TParamLigne_Obj);
Begin
 Parametre.init:=false;
 Parametre.TypeLigne:=chr(0);
 Parametre.Tiers:='';
 Parametre.Compte:='';
 Parametre.Libelle:='';
 Parametre.Qt1:='';
 Parametre.Qt2:='';
 Parametre.SensCredit:=false;
 Parametre.Credit:=0;
 Parametre.Debit:=0;
 Parametre.Ligne.Appartient:=false;
 Parametre.Ligne.Derniere:=false;

 Parametre.ChampCompte.readOnly:=false;
 Parametre.ChampQt1.readOnly:=false;
 Parametre.ChampQt2.readOnly:=false;

 Parametre.TVA.Retour:=false;
 Parametre.TVA.CodeTva:='';
 Parametre.TVA.TauxMin:=0;
 Parametre.TVA.TauxMax:=0;
 Parametre.TVA.Compte:='';
 Parametre.TVA.Libelle:='';
 Parametre.TVA.sensCredit:=false;
 Parametre.TVA.MontantMaxi:=0;
 Parametre.TVA.MontantMini:=0;
 Parametre.TVA.MontantReel:=0;

 InitialiseComplement_Obj(Parametre.Complement);
 InitialiseComplement_Obj(Parametre.ComplementTmp);

 end;


procedure TEcriture_Isa.InitialiseParamCompte_Obj(var ParametreCompteEcriture:TParametreCompte_obj);
Begin
 //initialise parametre compte (Tiers)
 Initialise_TInfosTiers(ParametreCompteEcriture.Tiers);
 //initialise ParametreCompteEcriture compte (Tiers)
 ParametreCompteEcriture.ParamCpt.Libelle:='';
 ParametreCompteEcriture.ParamCpt.Debit_Deb:=0;
 ParametreCompteEcriture.ParamCpt.Credit_Deb:=0;
 ParametreCompteEcriture.ParamCpt.Un1:='';
 ParametreCompteEcriture.ParamCpt.Un2:='';
 ParametreCompteEcriture.ParamCpt.Qt1_Deb:=0;
 ParametreCompteEcriture.ParamCpt.Qt2_Deb:=0;
 ParametreCompteEcriture.ParamCpt.PlanSaisie:=false;
 ParametreCompteEcriture.ParamCpt.TvaCode:='';
 ParametreCompteEcriture.ParamCpt.TvaType:='';
 ParametreCompteEcriture.ParamCpt.TvaDebit:=false;
 ParametreCompteEcriture.ParamCpt.SensCredit:=C_Nul;
 ParametreCompteEcriture.ParamCpt.Collectif:=false;
 ParametreCompteEcriture.ParamCpt.Centraliser:=false;
 ParametreCompteEcriture.ParamCpt.Tiers:=false;
 ParametreCompteEcriture.ParamCpt.Rapprochement:=false;
 ParametreCompteEcriture.ParamCpt.Immobilisation:=false;
 ParametreCompteEcriture.ParamCpt.ImmoAmort:=false;
 ParametreCompteEcriture.ParamCpt.ImmoDegressif:=false;
 ParametreCompteEcriture.ParamCpt.Emprunt:=false;
 ParametreCompteEcriture.ParamCpt.Abandonne:=false;
 ParametreCompteEcriture.ParamCpt.Qui:='';
 ParametreCompteEcriture.ParamCpt.Quand:=0;
 ParametreCompteEcriture.ParamCpt.CodeRetour:=false;
 //initialise ParametreCompteEcriture compte
 ParametreCompteEcriture.Choix:=false;
 ParametreCompteEcriture.retour:=false;
 //initialise ParametreCompteEcriture partie
 ParametreCompteEcriture.Partie.Partie:='';
 ParametreCompteEcriture.Partie.codeRetour:=false;
End;

procedure TEcriture_Isa.ListIdentifiantAdd_Insert(Valeur:array of const;Add,Remplace:boolean;Rang:integer);
var
i,rangTmp:integer;
typeligne:Char;
tableTemp:ttable;
retourboolean:TRetourBool;
RetourTranstypage:TTypeTranstypage;
Begin
    //with saisiep do
//    with saisiep_2 do
    begin
    new(FRecIdentifiant);
       for i:=0 to high(valeur)do
       begin//D�but boucle
       RetourTranstypage:=VTypeTranstypage(valeur[i],valeur[i].vtype);
           if  RetourTranstypage.retour then
           begin //si RetourTranstypage.retour=true
               case i mod 41 of
               0:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.IDLigne:=strtoint(RetourTranstypage.valeur);
               1:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.ID_Tmp:=strtoint(RetourTranstypage.valeur);
               2:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.ID_Ord:=strtoint(RetourTranstypage.valeur);
               3:FRecIdentifiant^.Ligne.Compte:=RetourTranstypage.valeur;
               4:FRecIdentifiant^.Ligne.tiers:=RetourTranstypage.valeur;
               5:FRecIdentifiant^.Ligne.Libelle:=RetourTranstypage.valeur;
               6:FRecIdentifiant^.Ligne.Qt1:=RetourTranstypage.valeur;
               7:FRecIdentifiant^.Ligne.Qt2:=RetourTranstypage.valeur;
               8:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.Ligne.Debit:=strtocurr(RetourTranstypage.valeur);
               9:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.Ligne.Credit:=strtocurr(RetourTranstypage.valeur);
              10:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.init:=retourboolean.valeur;
                end;
              11:FRecIdentifiant^.Ligne.TypeLigne:=RetourTranstypage.valeur[1];
              12:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.Ligne.Appartient:=retourboolean.valeur;
                end;
             13:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.Ligne.Derniere:=retourboolean.valeur;
                end;
             14:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.ChampCompte.readOnly:=retourboolean.valeur;
                end;
             15:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.ChampQt1.readOnly:=retourboolean.valeur;
                end;
             16:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.ChampQt2.readOnly:=retourboolean.valeur;
                end;
             17:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.SensCredit:=retourboolean.valeur;
                end;
             18:begin
                 retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.TVA.Retour:=retourboolean.valeur;
                end;
             19:FRecIdentifiant^.Ligne.TVA.CodeTva:=RetourTranstypage.valeur;
             20:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.Ligne.TVA.TauxMin:=strtofloat(RetourTranstypage.valeur);
             21:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.Ligne.TVA.TauxMax:=strtofloat(RetourTranstypage.valeur);
             22:FRecIdentifiant^.Ligne.TVA.Compte:=RetourTranstypage.valeur;
             23:FRecIdentifiant^.Ligne.TVA.Libelle:=RetourTranstypage.valeur;
             24:begin
                retourboolean:=strtobool(RetourTranstypage.valeur);
                if retourboolean.retour then
                FRecIdentifiant^.Ligne.TVA.sensCredit:=retourboolean.valeur;
                end;
             25:FRecIdentifiant^.Ligne.Complement.CodeTvaCompl:=RetourTranstypage.valeur;
             26:FRecIdentifiant^.Ligne.Complement.TvaType:=RetourTranstypage.valeur;
             27:FRecIdentifiant^.Ligne.Complement.TvaDate:=RetourTranstypage.valeur;
             28:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.Ligne.Complement.TvaTaux:=strtofloat(RetourTranstypage.valeur);
             29:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.Ligne.Complement.MontantTva:=strtoCurr(RetourTranstypage.valeur);
             30:begin
                 retourboolean:=strtobool(RetourTranstypage.valeur);
                 if retourboolean.retour then
                 FRecIdentifiant^.Ligne.Complement.rempli:=retourboolean.valeur;
                 end;
             31:FRecIdentifiant^.Ligne.ComplementTmp.CodeTvaCompl:=RetourTranstypage.valeur;
             32:FRecIdentifiant^.Ligne.ComplementTmp.TvaType:=RetourTranstypage.valeur;
             33:FRecIdentifiant^.Ligne.ComplementTmp.TvaDate:=RetourTranstypage.valeur;
             34:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.Ligne.ComplementTmp.TvaTaux:=strtofloat(RetourTranstypage.valeur);
             35:if not empty(RetourTranstypage.valeur)then FRecIdentifiant^.Ligne.Complement.MontantTva:=strtoCurr(RetourTranstypage.valeur);
             36:begin
                 retourboolean:=strtobool(RetourTranstypage.valeur);
                 if retourboolean.retour then
                 FRecIdentifiant^.Ligne.ComplementTmp.rempli:=retourboolean.valeur;
                 end;
             37:begin
                 retourboolean:=strtobool(RetourTranstypage.valeur);
                 if retourboolean.retour then
                 FRecIdentifiant^.Ligne.Enregistrer:=retourboolean.valeur;
                 end;
             38:FRecIdentifiant^.InfosTrame.CptRepartion:=RetourTranstypage.valeur;
             39:FRecIdentifiant^.InfosTrame.LibelleRepartion:=RetourTranstypage.valeur;
             40: if not empty(RetourTranstypage.valeur)then
                   FRecIdentifiant^.InfosTrame.TauxRepartion:=strtofloat(RetourTranstypage.valeur);
              end;//fin du case
           end;// fin si RetourTranstypage.retour=true
       end;//fin de boucle
    Piece.InitialiseInfosPointage(FRecIdentifiant.infosPointages);
    if Add then
    ListIdentifiant.Add(FRecIdentifiant)
    else
    if ((rang<>-1)and(remplace)) then
    Begin
    ListIdentifiant.delete(rang);
    ListIdentifiant.Insert(rang,FRecIdentifiant)
    End
    else
      if ((rang<>-1)and(not remplace)) then
      begin
      ListIdentifiant.Insert(rang,FRecIdentifiant);
//         if tableecriture<>nil then
//         GereDecalageTableTemporaire(rang,tableecriture,true);
      end;
    end;
End;


Function TEcriture_Isa.VerifMontantTVA_SurListe(Liste:Tlist;ParamTva:TRecupParamTva_Obj;Debit,Credit,Mini,Maxi:currency;Mess:string;SensLigne:integer;A_La_Ligne:boolean):TRetourMontantTva;
//Cette fonction permet pour une ligne T donn� (index)de v�rifier si son montant TVA est
//coh�rent ,sinon elle renvoie faux (Les montants sont toujours calcul�s).
var
infosLigneH:TInfosPiece_SurTypeLigne;
tab:variant;
rang:integer;
Begin
try
InitialiseRetourMontantTVA(result);
//V�rifier que les Tva soient enti�rement remplies comme les lignes H
 if not empty(ParamTva.CodeTva) then
   begin //si on trouve un codetva pour la ligne TVA
     RenvoieInfoSurTableDiverse(ParamTva.CodeTva,FTableTVA,'TvaCode',['Compte'],Tab);
rang:=Liste.count-1;
     while rang>-1 do
       begin
         if not A_La_Ligne then
           rang:=-1;
           { isa  le  17/08/04 }
         infosLigneH:=InfosPiece_SurTypeLigne(['H'],Liste,tab[0],sensligne,true,false,rang);
         if infosLigneH.SensSoldeCredit=C_SensSoldeCredit then
           Begin
             result.SensCredit:=C_SensSoldeCredit;
             result.RetourMontantMaxi:=result.RetourMontantMaxi+Arrondi(infosLigneH.Solde*ParamTva.TauxMax/100,2);
             result.RetourMontantMini:=result.RetourMontantMini+Arrondi(infosLigneH.Solde*ParamTva.TauxMin/100,2);
             result.retourMontantReel:=result.retourMontantReel+infosLigneH.MontantTva;

             result.RetourMontantMaxi_extended:=result.RetourMontantMaxi_extended+(infosLigneH.Solde*ParamTva.TauxMax/100);
             result.RetourMontantMini_extended:=result.RetourMontantMini_extended+(infosLigneH.Solde*ParamTva.TauxMin/100);

             result.SensCreditReel:=infosLigneH.SenssoldeTva;
             result.retour:=((SensLigne=result.SensCredit)and(Credit>=result.RetourMontantMini) and (Credit<=result.RetourMontantMaxi));
           End
           else
            if infosLigneH.SensSoldeCredit=C_SensSoldeDebit then
              Begin
                result.SensCredit:=C_SensSoldeDebit;
                result.RetourMontantMaxi:=result.RetourMontantMaxi+Arrondi(infosLigneH.Solde*ParamTva.TauxMax/100,2);
                result.RetourMontantMini:=result.RetourMontantMini+Arrondi(infosLigneH.Solde*ParamTva.TauxMin/100,2);
                result.retourMontantReel:=result.retourMontantReel+infosLigneH.MontantTva;
             result.RetourMontantMaxi_extended:=result.RetourMontantMaxi_extended+(infosLigneH.Solde*ParamTva.TauxMax/100);
             result.RetourMontantMini_extended:=result.RetourMontantMini_extended+(infosLigneH.Solde*ParamTva.TauxMin/100);

                result.SensCreditReel:=infosLigneH.SenssoldeTva;
                result.retour:=((SensLigne=result.SensCredit)and(Debit>=result.RetourMontantMini) and (Debit<=result.RetourMontantMaxi));
              End
              else
              if infosLigneH.SensSoldeCredit=C_SensSoldeNul then
              Begin
                result.SensCredit:=C_SensSoldeNul;
                result.RetourMontantMaxi:=result.RetourMontantMaxi+0;
                result.RetourMontantMini:=result.RetourMontantMini+0;
                result.retourMontantReel:=result.retourMontantReel+infosLigneH.MontantTva;
             result.RetourMontantMaxi_extended:=result.RetourMontantMaxi_extended+0;
             result.RetourMontantMini_extended:=result.RetourMontantMini_extended+0;

                result.SensCreditReel:=infosLigneH.SenssoldeTva;
                result.retour:=((SensLigne=result.SensCredit)and(Credit>=result.RetourMontantMini) and (Credit<=result.RetourMontantMaxi));
                if result.retour then
                  result.retour:=((SensLigne=result.SensCredit)and(Debit>=result.RetourMontantMini) and (Debit<=result.RetourMontantMaxi));
              End;
         dec(rang);
       end;//fin du while
       result.FourchetteModifier:=not((Mini=result.RetourMontantMini)and(Maxi=result.RetourMontantMaxi));
//       result.FourchetteModifier:=not((ParamTva.MontantMini=result.RetourMontantMini)and(ParamTva.MontantMaxi=result.RetourMontantMaxi));
   end;
finally
//
end;//fin du try finally
End;


function TEcriture_Isa.RecupEcritureSurRecord(SourceEcriture:Tlist;SourcePiece:TRecordPiece):TExceptLGR_ImportPiece;
var
i,j,x,CountListe:integer;
TauxMin,TauxMax:real;
LigneTemp:TParamLigne_Obj;
InfosTvaCode:TInfosTvaCode;
Comptetmp,TiersTmp,LibelleTmp,CompteTva,LibelleTva:string;
Debit,credit:currency;
MontantTVA:real;
SensCredit,retourTva,ReadOnly:boolean;
Tab:variant;
TotalPiece:TInfosPiece_SurTypeLigne;
LigneACreer:TCreation_obj;
InfosLignePieceH,InfosLignePieceT:TInfosPiece_SurTypeLigne;
sensligne:integer;
ParametreCompteEcriture:TParametreCompte_Obj;
trouve:boolean;
VerifMontantTVA:TRetourMontantTva;
ParamTva:TRecupParamTva_obj;
modif:TModif_obj;
Qt1Tmp,Qt2Tmp:string;
Exception:TExceptLGR;
ListeCodeTva:Tstringlist;
begin
//try//finally
//ListeCodeTva:=Tstringlist.Create;
 GestMessageLGR.ModeTrace:=true;
 Exception.GestMessageLGR:=GestMessageLGR;
 Exception.NomModule:='RecupEcritureSurRecord';
 Exception.GestMessageLGR.Enregistrement:=true;
 Exception.NomDossier:=e.NomDossier;
   try//Except
   //result.Erreur.GestMessageLGR:=GestMessageLGR;
   InitialiseParamLigne_Obj(LigneTemp);
   InitialiseCreationLigne_obj(LigneACreer);
   ReadOnly:=false;
   result.Erreur.retour:=true;
   Initialise_TList(ListIdentifiant,nil,false);

//   ListIdentifiant.Clear;
   trouve:=false;
   //s'il y a une contrepartie, la r�cup�rer
   //sinon cr�e une ligne vide
   CountListe:=SourceEcriture.Count-1;
   i:=0;
   while i<=CountListe  do
     begin//d�but de la boucle for
     //r�cup�rer tous les parametres de la ligne avant de la rentrer dans la liste d�finitive
     debit:=0;
     credit:=0;
     comptetmp:='';
     tiersTmp:='';
     libelleTmp:='';
     CompteTva:='';
     LibelleTva:='';
     MontantTVA:=0;
     Qt1Tmp:='';
     Qt2Tmp:='';
     InfosTvaCode:=Infos_TInfosTvaCode(TableTVA,'TvaCode',['']); //raz de la valeur
     if PRecordEcriture(SourceEcriture.Items[i])^.Qt1<>0 then
       Qt1Tmp:=currtostr(PRecordEcriture(SourceEcriture.Items[i])^.Qt1);
     if PRecordEcriture(SourceEcriture.Items[i])^.Qt2<>0 then
       Qt2Tmp:=currtostr(PRecordEcriture(SourceEcriture.Items[i])^.Qt2);
     if empty(PRecordEcriture(SourceEcriture.Items[i])^.CompteTiers)then
       begin//si tiers pas remplie,verifier si on a pass� un compte de tiers dans compte
       if TypeCptTiers(PRecordEcriture(SourceEcriture.Items[i])^.compte)then
         Begin
           TiersTmp:=PRecordEcriture(SourceEcriture.Items[i])^.compte;
           DeFiltrageDataSet(Piece.TableTiers);
           Comptetmp:=Infos_TInfosTiers(Piece.TableTiers,'Tiers',[PRecordEcriture(SourceEcriture.Items[i])^.compte]).Compte;
         End
       else
         Begin
           comptetmp:=PRecordEcriture(SourceEcriture.Items[i])^.compte;
         End;
       end
     else
       Begin //si compte de tiers remplie, v�rifier si compte correspond
           TiersTmp:=PRecordEcriture(SourceEcriture.Items[i])^.compteTiers;
           if not empty(Infos_TInfosTiers(Piece.TableTiers,'Tiers',[PRecordEcriture(SourceEcriture.Items[i])^.compteTiers]).Compte)then
             PRecordEcriture(SourceEcriture.Items[i])^.compte:=Infos_TInfosTiers(Piece.TableTiers,'Tiers',[PRecordEcriture(SourceEcriture.Items[i])^.compteTiers]).Compte;
           Comptetmp:=PRecordEcriture(SourceEcriture.Items[i])^.compte;
           DeFiltrageDataSet(Piece.TableTiers);
       End;
         if empty(PRecordEcriture(SourceEcriture.Items[i])^.Libelle) then
           LibelleTmp:=strtostr_lgr(SourcePiece.Libelle,'',RenvoieInfoSurTableDiverse(comptetmp,FTablePlan,'Compte',['Libelle'],Tab))
//           LibelleTmp:=strtostr_lgr(RenvoieInfoSurTableDiverse(comptetmp,FTablePlan,'Compte',['Libelle'],Tab),'',SourcePiece.Libelle)
         else
           LibelleTmp:=strtostr_lgr(PRecordEcriture(SourceEcriture.Items[i])^.Libelle,'',SourcePiece.Libelle);;
     if PRecordEcriture(SourceEcriture.Items[i])^.MontantHt<0 then
        Debit:=abs(PRecordEcriture(SourceEcriture.Items[i])^.MontantHt)
     else
        credit:=abs(PRecordEcriture(SourceEcriture.Items[i])^.MontantHt);
     try
     if ((empty(PRecordEcriture(SourceEcriture.Items[i])^.DateTVA))or(strtodate(PRecordEcriture(SourceEcriture.Items[i])^.DateTVA)=0)) then
       PRecordEcriture(SourceEcriture.Items[i])^.DateTVA:=datetostr(SourcePiece.Validation);
     except
       PRecordEcriture(SourceEcriture.Items[i])^.DateTVA:=datetostr(SourcePiece.Validation);
     end;
     if i=0 then
        begin//si i=0, voir si ligne de contrepartie
           if PRecordEcriture(SourceEcriture.Items[i])^.TypeLigne='X' then
              begin//si ligne de contrepartie, l'enregistrer dans la liste
                 if not empty(compteTmp)then
                 ListIdentifiantAdd_insert([i,0,0,compteTmp,TiersTmp,LibelleTmp,
                 Qt1Tmp,Qt2Tmp,
                 Debit,Credit,false,PRecordEcriture(SourceEcriture.Items[i])^.typeligne, False,False,
                 false,false,false,credit>0,retourTva,ligneTemp.TVA.CodeTva,ligneTemp.TVA.TauxMin,ligneTemp.TVA.TauxMax,LigneTemp.TVA.Compte,
                 LigneTemp.TVA.Libelle,LigneTemp.TVA.sensCredit,PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA,
                 PRecordEcriture(SourceEcriture.Items[i])^.TypeTVA,PRecordEcriture(SourceEcriture.Items[i])^.DateTVA,
                 0,PRecordEcriture(SourceEcriture.Items[i])^.montantTva,true,PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA,
                 PRecordEcriture(SourceEcriture.Items[i])^.TypeTVA,PRecordEcriture(SourceEcriture.Items[i])^.DateTVA,
                 0,PRecordEcriture(SourceEcriture.Items[i])^.montantTva,true,true,PRecordEcriture(SourceEcriture.Items[i])^.CptRepartition,PRecordEcriture(SourceEcriture.Items[i])^.LibelleRepartition,PRecordEcriture(SourceEcriture.Items[i])^.TauxRepartition],true,false,-1);
              end//fin si ligne de contrepartie, l'enregistrer dans la liste
           ELSE //sinon, enregistrer une ligne vide pour laisser la place pour la ligne de contrepartie
               begin
                 ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
                 ListRecordEcritureAdd_Insert(SourceEcriture,['V','','','',0,0,0,0,'','',0,'',''],true,false,0);
               end;
        end //fin si i=0, voir si ligne de contrepartie
     else
        begin//si i<>0 (autres lignes que la ligne de contrepartie)
         if SourcePiece.IDJournal in [1,2,3]then
            begin //si pi�ce d'achat ou de vente ou d'OD et compte Pouvant g�n�rer de la TVA (6 ou 7)
            //traiter la cr�ation de la ligne de tva si n�cessaire
             if ((PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA<>0)or(PRecordEcriture(SourceEcriture.Items[i])^.TauxTVA<>0)
             or(PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA[1]='T')) then
               Begin
                 if not((copy(PRecordEcriture(SourceEcriture.Items[i])^.Compte,1,1)='2')or
                 (copy(PRecordEcriture(SourceEcriture.Items[i])^.Compte,1,1)='6')or
                 (copy(PRecordEcriture(SourceEcriture.Items[i])^.Compte,1,1)='7')or (PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA[1]='T'))then
                          begin
                            result.Erreur.NumErreur:=5;
                            result.Mess:='Le compte '+PRecordEcriture(SourceEcriture.Items[i])^.Compte+' ne peut pas attendre de la Tva.';
                            raise ExceptLGR.Create(result.Mess,result.Erreur.NumErreur,false,mtError,Exception);
                          end;
                 if ((not empty(PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA))or(not empty(PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA))) then
                   Begin
                     if not empty(PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA)then
                        begin
                        InfosTvaCode:=Infos_TInfosTvaCode(TableTVA,'TvaCode',[PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA]);
                        if InfosTvaCode.resultinfos then
                        comptetva:=InfosTvaCode.Compte
                        else
                          begin
                            result.Erreur.NumErreur:=1;
                            result.Mess:='Le code de tva : '+PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA+' ne correspond � aucun code tva existant';
                            raise ExceptLGR.Create(result.Mess,result.Erreur.NumErreur,false,mtError,Exception);
                          end;
                        if ((not empty(PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA))and(CompteTva<>PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA))then
                          begin
                            result.Mess:='Le compte de tva : '+PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA+' ne correspond pas au compte li� au code tva saisi';
                            result.Erreur.NumErreur:=2;
                            raise ExceptLGR.Create(result.Mess,result.Erreur.NumErreur,false,mtError,Exception);
                          end;
                        end
                     else
                     if not empty(PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA)then
                        begin
                          InfosTvaCode:=Infos_TInfosTvaCode(TableTVA,'compte',[PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA]);
                          if InfosTvaCode.resultinfos then
                          CompteTva:=PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA
                          else
                            if ((PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA=DM_C_CompteTVAProduitARecevoir)or(PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA=DM_C_CompteTVAChargeAPayer))then
                               begin
                                 InfosTvaCode.resultinfos:=true;
                                 CompteTva:=PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA;
                               end
                            else
                              Begin
                                result.Mess:='Le compte de tva '+PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA+' n"est li� � aucun Code de tva existant';
                                result.Erreur.NumErreur:=3;
                                raise ExceptLGR.Create(result.Mess,result.Erreur.NumErreur,false,mtError,Exception);
                              End;
                          if not empty(PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA)then
                            begin
                            if PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA<>InfosTvaCode.TvaCode then
                              Begin
                                result.Mess:='Le Code de tva '+PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA+' ne correspond pas au code de tva li� au compte de tva saisi';
                                result.Erreur.NumErreur:=4;
                                raise ExceptLGR.Create(result.Mess,result.Erreur.NumErreur,false,mtError,Exception);
                              End;
                            end;
                        end;
                     //libelletva:=InfosTvaCode.Libelle;
                     libelletva:=SourcePiece.Libelle;{ isa  le  08/01/04 }
                     MontantTVA:=abs(PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA);

                     if empty(PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA)then
                       PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA:=InfosTvaCode.TvaCode;
                     if empty(PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA)then
                       PRecordEcriture(SourceEcriture.Items[i])^.CompteTVA:=InfosTvaCode.Compte;
                     if empty(PRecordEcriture(SourceEcriture.Items[i])^.TypeTVA)then
                       PRecordEcriture(SourceEcriture.Items[i])^.TypeTVA:=Infos_TInfosplancpt(Tableplan,'compte',[PRecordEcriture(SourceEcriture.Items[i])^.Compte]).TvaType;
                     if empty(PRecordEcriture(SourceEcriture.Items[i])^.TypeTVA)then
                       PRecordEcriture(SourceEcriture.Items[i])^.TypeTVA:='D';
                     if empty(PRecordEcriture(SourceEcriture.Items[i])^.DateTVA)then
                       PRecordEcriture(SourceEcriture.Items[i])^.DateTVA:=datetostr(piece.DateLivraison);
                     if (PRecordEcriture(SourceEcriture.Items[i])^.TauxTVA=0) and (PRecordEcriture(SourceEcriture.Items[i])^.MontantHt<>0)  then
                       PRecordEcriture(SourceEcriture.Items[i])^.TauxTVA:=Arrondi((MontantTVA*100)/abs(PRecordEcriture(SourceEcriture.Items[i])^.MontantHt),2);
                     if ((MontantTVA=0)and (not DispatcherTva)and(PRecordEcriture(SourceEcriture.Items[i])^.TauxTVA<>0))then
                       Begin
                          PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA:=arrondi((abs(PRecordEcriture(SourceEcriture.Items[i])^.MontantHt)*(PRecordEcriture(SourceEcriture.Items[i])^.TauxTVA))/100,2);
                       if PRecordEcriture(SourceEcriture.Items[i])^.MontantHt<0 then
                          PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA:=-PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA;
                       montanttva:=abs(PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA);
                       End
                     else
                     if ((montanttva<>0)or(DispatcherTva)) then
                       Begin
                          if ((PRecordEcriture(SourceEcriture.Items[i])^.MontantHt<0)) then
                             PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA:=-(abs(PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA))
                          else
                             PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA:=abs(PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA);
                       End;
                     if(CompteTva<>'')then
                     begin
                         ListRecordEcritureAdd_Insert(SourceEcriture,['T',CompteTva,'',libelletva,0,0,PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA,0,'',InfosTvaCode.TvaCode,
                         0,'',''],true,false,-1);
                         if DispatcherTva then PRecordEcriture(SourceEcriture.Items[i])^.MontantTVA:=0;
                         inc(CountListe);
                     end;
                   End//si code tva ou compte tva
                 else
                   begin
                      result.Mess:='Les param�tres Tva ne sont pas correctement remplis';
                      result.Erreur.NumErreur:=4;
                      raise ExceptLGR.Create(result.Mess,result.Erreur.NumErreur,false,mtError,Exception);
                   end;
               End;//fin traiter la cr�ation de la ligne de tva si n�cessaire
             //traiter la ligne en cours
             if PRecordEcriture(SourceEcriture.Items[i])^.TypeLigne='H' then
               begin
                if not empty(compteTmp)then
                ListIdentifiantAdd_insert([i,0,0,compteTmp,TiersTmp,LibelleTmp,
                Qt1Tmp,Qt2Tmp,
                Debit,Credit,false,PRecordEcriture(SourceEcriture.Items[i])^.typeligne, False,False,
                false,false,false,credit>0,retourTva,InfosTvaCode.TvaCode,InfosTvaCode.Taux_Inf,InfosTvaCode.Taux_Supp,InfosTvaCode.Compte,
                InfosTvaCode.Libelle,credit>0,PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA,
                PRecordEcriture(SourceEcriture.Items[i])^.TypeTVA,PRecordEcriture(SourceEcriture.Items[i])^.DateTVA,
                PRecordEcriture(SourceEcriture.Items[i])^.TauxTVA,montantTva,true,PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA,
                PRecordEcriture(SourceEcriture.Items[i])^.TypeTVA,PRecordEcriture(SourceEcriture.Items[i])^.DateTVA,
                PRecordEcriture(SourceEcriture.Items[i])^.TauxTVA,montantTva,true,true,PRecordEcriture(SourceEcriture.Items[i])^.CptRepartition,PRecordEcriture(SourceEcriture.Items[i])^.LibelleRepartition,PRecordEcriture(SourceEcriture.Items[i])^.TauxRepartition],true,false,-1);
                Pidentifiant_obj(ListIdentifiant.items[j])^.Ligne.TVA.MontantReel:=montantTva;
               end
             else
             if PRecordEcriture(SourceEcriture.Items[i])^.TypeLigne='T' then
                begin
                InfosTvaCode:=Infos_TInfosTvaCode(TableTVA,'tvacode',[PRecordEcriture(SourceEcriture.Items[i])^.CodeTVA]);
                     j:=1;
                     while ((j<=ListIdentifiant.count-1)and(not trouve)) do
                       begin
                         if Pidentifiant_obj(ListIdentifiant.items[j])^.Ligne.compte=InfosTvaCode.Compte then
                          begin
                            trouve:=true;
                          end;
                        inc(j);
                       end;
                     if not trouve then
                      begin
                        if not empty(compteTmp)then
                        ListIdentifiantAdd_insert([i,0,0,compteTmp,TiersTmp,LibelleTmp,
                        Qt1Tmp,Qt2Tmp,
                        Debit,Credit,false,PRecordEcriture(SourceEcriture.Items[i])^.typeligne, False,False,
                        false,false,false,credit<>0,true,InfosTvaCode.TvaCode,InfosTvaCode.Taux_Inf,InfosTvaCode.Taux_Supp,InfosTvaCode.Compte,
                        InfosTvaCode.Libelle,credit<>0,'','','',0,0,true,'','','',0,0,true,true,PRecordEcriture(SourceEcriture.Items[i])^.CptRepartition,PRecordEcriture(SourceEcriture.Items[i])^.LibelleRepartition,PRecordEcriture(SourceEcriture.Items[i])^.TauxRepartition],true,false,-1);
                      end;
                   trouve:=false;
                end;
            end//fin si pi�ce d'achat ou de vente ou d'OD
         else
            Begin//si autres pi�ces (Banque)
                if not empty(compteTmp)then
                ListIdentifiantAdd_insert([i,0,0,compteTmp,TiersTmp,LibelleTmp,
                Qt1Tmp,Qt2Tmp,
                Debit,Credit,false,'H', False,False,
                false,false,false,credit>0,retourTva,ligneTemp.TVA.CodeTva,ligneTemp.TVA.TauxMin,ligneTemp.TVA.TauxMax,LigneTemp.TVA.Compte,
                LigneTemp.TVA.Libelle,LigneTemp.TVA.sensCredit,'','','',0,0,true,'','','',0,0,true,true,PRecordEcriture(SourceEcriture.Items[i])^.CptRepartition,PRecordEcriture(SourceEcriture.Items[i])^.LibelleRepartition,PRecordEcriture(SourceEcriture.Items[i])^.TauxRepartition],true,false,-1);
            End;//fin si autres pi�ces (Banque)
         end;//fin si i<>0 (autres lignes que la ligne de contrepartie)

     CountListe:=SourceEcriture.Count-1;
     inc(i);
     end;//fin de la boucle while
    //Traitement pour supprimer les lignes de TVA qui ne seraient li�es � aucune ligne de Hors Taxe
    //initialisation des variables pour qu'elles rentrent dans la boucle, en sachant qu'elles seront initialis�es � zero
    //d�s le d�part
    modif.ASupprimer:=true;
    modif.NewRow:=1;
    while ((modif.ASupprimer)and(modif.NewRow<>-1)) do
      begin
          if piece.IDJournal in [1,2] then//cette partie ne concerne que les pi�ces d'achat ou de vente
            Begin
              InitialiseModifObj(modif);
              ModificationSuppressionLigneTva('H',modif,nil);
              if ((modif.ASupprimer)and(modif.NewRow<>-1))then
                ListIdentifiant.Delete(modif.NewRow);
              for x:=0 to ListIdentifiant.count-1 do
                begin
                  if Pidentifiant_obj(ListIdentifiant.items[x])^.Ligne.TypeLigne='T' then
                    ModificationLigneHorsTaxesSurProrataTva(x,nil,DispatcherTva,false);
                end;
            end
          else
            InitialiseModifObj(modif);
     end;
   if SourcePiece.IDJournal in [1,2,4]then
     Begin
       TotalPiece:=InfosPiece_SurTypeLigne(['H','T'],ListIdentifiant,'',0,false,false,-1);
       if ((TotalPiece.Solde<>SourcePiece.TotalPiece)and(SourcePiece.Trame=false)) then
        begin
         result.Mess:='Le total de la pi�ce r�cup�r�e  '+SourcePiece.Reference+' n''est pas �gal au total calcul�';
         raise ExceptLGR.Create(result.Mess,result.Erreur.NumErreur,false,mtError,Exception);;
        end;
       if(ListIdentifiant.Count=0)then
       begin
          result.Mess:='La pi�ce '+SourcePiece.Reference+' n''a pas de ligne';
          raise ExceptLGR.Create(result.Mess,result.Erreur.NumErreur,false,mtError,Exception);

       end;
       Pidentifiant_obj(ListIdentifiant.items[0])^.Ligne.TypeLigne:='X';
       Pidentifiant_obj(ListIdentifiant.items[0])^.Ligne.Compte:=Piece.ComptePlan;
       Pidentifiant_obj(ListIdentifiant.items[0])^.Ligne.Tiers:=Piece.Tiers;
       Pidentifiant_obj(ListIdentifiant.items[0])^.Ligne.Libelle:=piece.Libelle;
       case TotalPiece.SensSoldeCredit of
        0:;
        -1:Begin
            Pidentifiant_obj(ListIdentifiant.items[0])^.Ligne.Credit:=TotalPiece.Solde;
            Pidentifiant_obj(ListIdentifiant.items[0])^.Ligne.SensCredit:=true;
          End;
        1:Begin
            Pidentifiant_obj(ListIdentifiant.items[0])^.Ligne.Debit:=TotalPiece.Solde;
            Pidentifiant_obj(ListIdentifiant.items[0])^.Ligne.SensCredit:=false;
          End;
       end;//fin du case
     End;
   Except
     result.Erreur.retour:=false;
   end;//fin du try Except
//finally
//  Initialise_TStringlist(ListeCodeTva);
//end;
End;

procedure TEcriture_Isa.ListRecordEcritureAdd_Insert(var Liste:Tlist;Valeur:array of const;Add,Remplace:boolean;Rang:integer);
var
i,rangTmp:integer;
typeligne:Char;
retourboolean:TRetourBool;
RetourTranstypage:TTypeTranstypage;
Begin
    begin
    new(FRecordEcriture);
    Initialise_TRecordEcriture(FRecordEcriture^);
       for i:=0 to high(valeur)do
       begin//D�but boucle
       RetourTranstypage:=VTypeTranstypage(valeur[i],valeur[i].vtype);
           if  RetourTranstypage.retour then
           begin //si RetourTranstypage.retour=true
               case i mod 14 of
               0:FRecordEcriture^.TypeLigne:=RetourTranstypage.valeur[1];
               1:FRecordEcriture^.Compte:=RetourTranstypage.valeur;
               2:FRecordEcriture^.CompteTiers:=RetourTranstypage.valeur;
               3:FRecordEcriture^.Libelle:=RetourTranstypage.valeur;
               4:FRecordEcriture^.Qt1:=strtofloat_lgr(RetourTranstypage.valeur);
               5:FRecordEcriture^.Qt2:=strtofloat_lgr(RetourTranstypage.valeur);
               6:FRecordEcriture^.MontantHt:=strtocurr_lgr(RetourTranstypage.valeur);
               7:FRecordEcriture^.MontantTVA:=strtocurr_lgr(RetourTranstypage.valeur);
               8:FRecordEcriture^.CompteTVA:=RetourTranstypage.valeur;
               9:FRecordEcriture^.CodeTVA:=RetourTranstypage.valeur;
              10:FRecordEcriture^.TauxTVA:=strtocurr_lgr(RetourTranstypage.valeur);
              11 :FRecordEcriture^.TypeTVA:=RetourTranstypage.valeur;
              12:FRecordEcriture^.DateTVA:=RetourTranstypage.valeur;
              13:FRecordEcriture^.ID_Piece:=strtoint_lgr(RetourTranstypage.valeur);
              end;//fin du case
           end;// fin si RetourTranstypage.retour=true
        FRecordEcriture^.Qt1:=Strtocurr_lgr(GestionDesQuantites(FRecordEcriture^.Compte,Currtostr(FRecordEcriture^.Qt1),FRecordEcriture^.MontantHt>0));
        FRecordEcriture^.Qt2:=Strtocurr_lgr(GestionDesQuantites(FRecordEcriture^.Compte,Currtostr(FRecordEcriture^.Qt2),FRecordEcriture^.MontantHt>0));
       end;//fin de boucle
if liste=nil then
  begin
    if ((Add)and(rang=-1)) then
    ListeEcriturePiece.Add(FRecordEcriture)
    else
    if ((rang<>-1)and(remplace)) then
    Begin
    ListeEcriturePiece.delete(rang);
    ListeEcriturePiece.Insert(rang,FRecordEcriture)
    End
    else
      if ((rang<>-1)and(not remplace)) then
      ListeEcriturePiece.Insert(rang,FRecordEcriture);
  end
else
  Begin
    if ((Add)and(rang=-1)) then
    Liste.Add(FRecordEcriture)
    else
    if ((rang<>-1)and(remplace)) then
    Begin
    Liste.delete(rang);
    Liste.Insert(rang,FRecordEcriture)
    End
    else
      if ((rang<>-1)and(not remplace)) then
      begin
      Liste.Insert(rang,FRecordEcriture);
      end;
  End;


    end;
End;


function TEcriture_Isa.RecupSens_Et_SoldeSurEcritureListe(Ligne:integer;Liste:Tlist):TInfosPiece_SurTypeLigne;
Begin
  try
  initialiseInfosPiece_SurTypeLigne(result);
  if liste<>nil then
    Begin
       if Pidentifiant_obj(liste.items[Ligne])^.Ligne.Credit>Pidentifiant_obj(liste.items[Ligne])^.Ligne.Debit then
         begin
           result.SensSoldeCredit:=1;
           result.Solde:=Pidentifiant_obj(liste.items[Ligne])^.Ligne.Credit-Pidentifiant_obj(liste.items[Ligne])^.Ligne.Debit;
         end
       else
         begin
         if Pidentifiant_obj(liste.items[Ligne])^.Ligne.Credit<Pidentifiant_obj(liste.items[Ligne])^.Ligne.Debit then
           result.SensSoldeCredit:=-1;
           result.Solde:=Pidentifiant_obj(liste.items[Ligne])^.Ligne.Debit-Pidentifiant_obj(liste.items[Ligne])^.Ligne.Credit;
         end;
    End;
  except
    showmessage('Probl�me rencontr� lors de la r�cup�ration du sens du Ecriture dans la liste');
    abort;
  end;
End;



function gestionDernierIDEcriture(Ecriture:TEcriture_Isa):integer;
Var
i:integer;
valeurtmp:TReference;
ValeurNew:integer;
ListeTmp:Tstringlist;
begin
  try
  try
  ListeTmp:=Tstringlist.Create;
  ValeurNew:= ecriture.NewIDEcriture(Ecriture.TableEcriture,'ID');
  if Ecriture.ListIdentifiant.Count<>0 then
  begin
  //r�cup�rer tous les identifiant dans une stringlist
  for i:=1 to Ecriture.ListIdentifiant.Count-1 do
    Begin//si
      if ((Pidentifiant_obj(Ecriture.ListIdentifiant.Items[i])^.Ligne.TypeLigne<>'V')and(Pidentifiant_obj(Ecriture.ListIdentifiant.Items[i])^.ID_Ord<>0)) then
        Begin//si
          if ListeTmp.IndexOf(inttostr(Pidentifiant_obj(Ecriture.ListIdentifiant.Items[i])^.ID_Ord))=-1 then
            ListeTmp.Add(inttostr(Pidentifiant_obj(Ecriture.ListIdentifiant.Items[i])^.ID_Ord))
          else
            abort;
        End;//fin si
    End;//fin si
    if ListeTmp.IndexOf(inttostr(ValeurNew))<>-1 then
    begin
      valeurtmp:=MaxID_EcritureDansListe(ListeTmp);
      if valeurtmp.retour then
        begin
        if valeurtmp.retour then
           result:= strtoint(valeurtmp.Reference);
        end;
    end
    else
    result:=ValeurNew;
  end
  else
  result:=ValeurNew;
  except
    showmessage('Probl�me rencontr� lors de la gestion des Identifiants d''Ecriture');
    abort;
  end;
  finally
    ListeTmp.Free;
    ListeTmp:=nil;
  end;
end;


function gestionDerniereReference(Journal:string;Piece:Tpiece;ListeReference:Tstringlist):string;
Var
valeurtmp:TReference;
ValeurNew:string;
begin
// PB 27/07/02

ValeurNew:= Piece.NewReference(piece.TablePiece,'Reference',Journal,piece.CodeExo,Piece.Reference);
//ValeurNew:= ObjReglement1.Piece.NewReference(ObjReglement1.Piece.TablePiece,'Reference',Journal,ObjReglement1.Piece.CodeExo,ObjReglement1.Piece.Reference);
if ListeReference.Count<>0 then
begin
  if ListeReference.IndexOf(ValeurNew)<>-1 then
  begin
    valeurtmp:=MaxReferenceDansListe(journal,1,2,ListeReference);
    if valeurtmp.retour then
      begin
//  PB 27/07/02
//      valeurtmp:=New_Reference_Epicea(valeurtmp.Reference,Journal,ObjReglement1.Piece.CodeExo);
      valeurtmp:=New_Reference_Epicea(valeurtmp.Reference,Journal,piece.CodeExo);
      if valeurtmp.retour then
         result:= valeurtmp.Reference;
      end;
  end
  else
  result:=ValeurNew;
end
else
result:=ValeurNew;

end;

function TEcriture_Isa.Recup_MontantTva_Valide(ValeurOrigine,Increment:currency;ParamTva:TRecupParamTva_Obj):TMontantTva_Valide;
var
InfosLignePieceH:TInfosPiece_SurTypeLigne;
MontantTva_ALaLigne,MontantTva_Total:TRetourMontantTva;
IncrementMinimalMini,IncrementMinimalMaxi:currency;
Begin
result.MontantTva:=0;
result.retour:=true;
MontantTva_Total:=VerifMontantTVA_SurListe(ListIdentifiant,ParamTva,0,0,0,0,'',0,false);
MontantTva_ALaLigne:=VerifMontantTVA_SurListe(ListIdentifiant,ParamTva,0,0,0,0,'',0,true);
result.MontantMini:=MontantTva_Total.RetourMontantMini;
result.MontantMaxi:=MontantTva_Total.RetourMontantMaxi;
//((1/1000)*MontantTva_Total.RetourMontantMini)
//if ((ValeurOrigine+increment+0.01>=MontantTva_Total.RetourMontantMini)and (ValeurOrigine+increment<>0)and(ValeurOrigine+increment-0.01<=MontantTva_ALaLigne.RetourMontantMaxi))then
{ isa  le  06/01/04 }
if arrondi((int(((1/10000)*MontantTva_Total.RetourMontantMini)*10000)/10000),2)=0 then IncrementMinimalMini:=0.01 else IncrementMinimalMini:=0;
if arrondi((int(((1/10000)*MontantTva_Total.RetourMontantMaxi)*10000)/10000),2)=0 then IncrementMinimalMaxi:=0.01 else IncrementMinimalMaxi:=0;
//if ((ValeurOrigine+increment+IncrementMinimal+(int(((1/1000)*MontantTva_Total.RetourMontantMini)*1000)/1000)>=MontantTva_Total.RetourMontantMini) and (ValeurOrigine+increment<>0)and(ValeurOrigine+increment-IncrementMinimal-arrondi(int(((1/1000)*MontantTva_Total.RetourMontantMaxi)*1000)/1000,2)<=MontantTva_Total.RetourMontantMaxi))then
{ isa  le  06/01/04 }
if ((ValeurOrigine+increment+IncrementMinimalMini+arrondi((int(((1/1000)*MontantTva_Total.RetourMontantMini)*1000)/1000),2)>=
MontantTva_Total.RetourMontantMini) and (ValeurOrigine+increment<>0)and(ValeurOrigine+increment-IncrementMinimalMaxi-
arrondi(int(((1/1000)*MontantTva_Total.RetourMontantMaxi)*1000)/1000,2)<=MontantTva_Total.RetourMontantMaxi))then
  begin
    result.MontantTva:=ValeurOrigine+increment;
    Piece.Modifier_EnAttente:=true;{ isa  le  23/01/04 }
  end
else
  begin
    result.MontantTva:=ValeurOrigine;
    result.retour:=false;
  end;
End;


function TEcriture_Isa.ModificationSuppressionLigneTva(TypeLigne:char;var Modif:TModif_Obj;Grille:TgrGrid):boolean;
var
LastLigne,NewLigne:TParamLigne_obj;
i,j,SensLigne,sensLigneTva:integer;
InfosLignePieceH:TInfosPiece_SurTypeLigne;
MontantTVA:TRetourMontantTva;
ParamTVA:TRecupParamTva_obj;
Begin
SensLigne:=0;
result:=true; //represente s'il y a eu un changement (si action result:=false)
//parcourir toutes les lignes TVA pour savoir s'il y a au moins une ligne H pour chacune d'elles
for i:=1 to ListIdentifiant.count-1 do
  Begin //Debut du for sur longueur liste
    SensLigne:=RecupSens_Et_SoldeSurEcritureListe(i,ListIdentifiant).SensSoldeCredit;
    if Pidentifiant_obj(ListIdentifiant.Items[i])^.Ligne.TypeLigne='T'then
      Begin //si ligne T, Rechercher les lignes H correspondantes
        InfosLignePieceH:=InfosPiece_SurTypeLigne(['H'],ListIdentifiant,Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Compte,SensLigne,true,false,-1);
        if ((InfosLignePieceH.NbLigne=0)or(InfosLignePieceH.Solde=0)) then
          begin//s'il la ligne TVA ne doit plus exister
            result:=false;
            modif.ASupprimer:=true;
            modif.SupprAutomatique:=true;
            modif.NewRow:=i;
            break;
          end//fin s'il la ligne TVA ne doit plus exister
        else
          Begin //si la ligne TVA doit �ventuellement �tre modifi�e
            if Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.SensCredit then
            sensLigneTva:=1
            else
            sensLigneTva:=-1;
            MontantTVA:=VerifMontantTVA_SurListe(ListIdentifiant,Pidentifiant_obj(ListIdentifiant.Items[i])^.Ligne.TVA,Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Debit,Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Credit,0,0,'',sensLigneTva,false);
            if ((not montantTva.retour)or(montantTva.FourchetteModifier)) then
              begin//si le montantTva ne correspond plus au mini calcul�
              result:=false;
              if montantTva.SensCreditReel=0 then
                begin//si ligne tva doit �tre supprim�e
                   modif.ASupprimer:=true;
                   modif.SupprAutomatique:=true;
                   modif.NewRow:=i;
                   break;
                end//fin si ligne tva doit �tre supprim�e
              else
                begin//si ligne tva doit �tre concerv�e
                if montantTva.SensCreditReel=1 then
                  begin
                  Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.SensCredit:=true;
                  end
                else
                  begin
                  Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.SensCredit:=false;
                  end;
                if ((typeligne<>'T')or(SensLigne=0)) then
                  begin
                    Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.tva.MontantMini:=montantTva.RetourMontantMini;
                    Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.tva.MontantMaxi:=montantTva.RetourMontantMaxi;
                    Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.tva.MontantReel:=montantTva.retourMontantReel;
                    CorrectionLigneTva(i,i,TypeLigne,false,Grille);
                  end;
                end;//fin si ligne tva doit �tre concerv�e
              end;//fin si le montantTva ne correspond plus au mini calcul�
          End;//fin si la ligne TVA doit �ventuellement �tre modifi�e
      End;//si ligne T, Rechercher les lignes H correspondantes
  End;//fin du for sur longueur liste
End;


procedure TEcriture_Isa.CorrectionLigneTva(LigneGrille,LigneListe:integer;TypeLigneCourante:Char;ForcerModif:boolean;Grille:TgrGrid);
var
tab:variant;
LastSensLigne:boolean;
Begin
LastSensLigne:=false;
  try
    if ((TypeLigneCourante<>'T')and(Pidentifiant_obj(ListIdentifiant.items[LigneGrille])^.Ligne.TVA.Compte=Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Tva.Compte))then
      Begin//si ligne courante n'est pas une ligne de tva
        if Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.SensCredit then
          Begin //si nouvelle tva au credit
             if grille<>nil then
             begin
               Grille.Cells[5,LigneGrille]:='';
             //grgrid1.Cells[6,LigneGrille]:=currtostr(Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.Tva.MontantMini);
               Grille.Cells[6,LigneGrille]:=e.FormatCurrSansDevise(Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Tva.MontantReel);
             end;
             Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Debit:=0;
             Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Credit:=Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantReel;
             //Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.Credit:=Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantMini;
          End //fin si nouvelle tva au credit
        else
          Begin//si nouvelle tva au Debit
             //grgrid1.Cells[5,LigneGrille]:=currtostr(Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantMini);
             if grille<>nil then
             begin
             Grille.Cells[5,LigneGrille]:=e.FormatCurrSansDevise(Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantReel);
             Grille.Cells[6,LigneGrille]:='';
             end;
             //Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.Debit:=Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantMini;
             Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Debit:=Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantReel;
             Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Credit:=0;
          End;//fin si nouvelle tva au Debit
      End //fin si ligne courante n'est pas une ligne de tva
    else
     if Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.TypeLigne='T'then
      begin//si ligne courante est une ligne de tva
      if Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Credit<>0 then
         LastSensLigne:=true;
//      if ((Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.TypeLigne='T')and(((Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.Debit=0)and(Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.credit=0))or (ForcerModif)or(LastSensLigne<>Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.SensCredit))) then
//        Begin//si ligne TVA pas remplie
        if Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.SensCredit then
          Begin //si nouvelle tva au credit
             //grgrid1.Cells[6,LigneGrille]:=currtostr(Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantMini);
             if grille<>nil then
             begin
             grille.Cells[6,LigneGrille]:=e.FormatCurrSansDevise(Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantReel);
             grille.Cells[5,LigneGrille]:='';
             end;
             Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Debit:=0;
             Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Credit:=Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantReel;
             //Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.Credit:=Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantMini;
          End //fin si nouvelle tva au credit
        else
          Begin//si nouvelle tva au Debit
             //grgrid1.Cells[5,LigneGrille]:=currtostr(Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantMini);
             if grille<>nil then
             begin
             grille.Cells[5,LigneGrille]:=e.FormatCurrSansDevise(Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantReel);
             grille.Cells[6,LigneGrille]:='';
             end;
             Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.credit:=0;
             Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.Debit:=Pidentifiant_obj(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantReel;
             //Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.Debit:=Pidentifiant(ListIdentifiant.items[LigneListe])^.Ligne.TVA.MontantMini;
          End;//fin si nouvelle tva au Debit
        //End; //fin si ligne TVA pas remplie
      end;//fin si ligne courante est une ligne de tva
  except
     //
  end;//fin du try except
End;


Function TEcriture_Isa.CompteEstPointable(Cpt:string):boolean;
var
InfosPlanCpt:TInfosPlanCpt;
Begin
result:=false;
DeFiltrageDataSet(Piece.TableTiers);
DeFiltrageDataSet(TablePlan);
  try
  if str_commence_par(cpt,'+') then
   begin
     result:=Infos_TInfosTiers(Piece.TableTiers,'Tiers',[cpt]).ResultInfos;
//     result:=VerifIfExist(DMTiers.TaTiers,'Tiers',Cpt);
   end
   else
   begin
     InfosPlanCpt:=Infos_TInfosplancpt(TablePlan,'Compte',[cpt]);
     if InfosPlanCpt.ResultInfos then
      result:=((InfosPlanCpt.pointable) and (not(InfosPlanCpt.Collectif)));
//    if result then result:=Pointable.AsBoolean and not Collectif.AsBoolean;
//     if TaPlanCptRecherche.Locate('Compte',cpt,[])then
//       result:=((TaPlanCptRecherche.FindField('Pointable').asboolean)and(not TaPlanCptRecherche.FindField('collectif').asboolean));
   end;
  except
    result:=false;
    abort;
  end;
End;

procedure TEcriture_Isa.ModificationLigneHorsTaxesSurProrataTva(LigneTva:integer;Grille:TGrGrid;Dispatcher:boolean;ChangementTauxNonObligatoire:boolean);
var
sensLigneTva,i,DerniereLigne,signe:integer;
InfosLignePieceH,sens_Et_SoldeLigne:TInfosPiece_SurTypeLigne;
MontantTVACredit,MontantTVADebit,cumulMontantTva,RepartMontantTva:currency;
Exception:TExceptLGR ;
Begin
 GestMessageLGR.ModeTrace:=true;
 Exception.GestMessageLGR:=GestMessageLGR;
 Exception.NomModule:='ModificationLigneHorsTaxesSurProrataTva';
 Exception.GestMessageLGR.Enregistrement:=true;
 Exception.NomDossier:=e.NomDossier;
signe:=1;
sensLigneTva:=0;
MontantTVADebit:=0;
MontantTVACredit:=0;
RepartMontantTva:=0;
cumulMontantTva:=0;
DerniereLigne:=-1;
//r�cup�rer le montant et le sens de la ligne Tva courante
if Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.debit<Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.credit then
   begin
   sensLigneTva:=1;
   MontantTVACredit:=Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.credit;
   cumulMontantTva:=MontantTVACredit;
   end
else
   if Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.debit>Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.credit then
     begin
      sensLigneTva:=-1;
      MontantTVADebit:=Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.debit;
      cumulMontantTva:=MontantTVADebit;
     end;
//avec ce sens, r�cup�rer le total des lignes horstaxes concern�es
InfosLignePieceH:=InfosPiece_SurTypeLigne(['H'],ListIdentifiant,Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.Compte,SensLigneTva,true,false,-1);
//si le montant de la ligne de tva est different du total des tva des lignes hors taxes alors
//pour chacune d'elles, recalculer le montant tva (((montantTva*HT)/Total HT))
//parcourir toutes les lignes TVA pour savoir s'il y a au moins une ligne H pour chacune d'elles
if (((InfosLignePieceH.MontantTva<>MontantTVACredit)and(InfosLignePieceH.SenssoldeTva=1))or (Dispatcher)or((InfosLignePieceH.MontantTva<>MontantTVADebit)and(InfosLignePieceH.SenssoldeTva=-1))) then
begin //si le montant de la ligne de tva est different du total des tva des lignes hors taxes

//  if (((InfosLignePieceH.Debit=0)and(InfosLignePieceH.Credit<>0)))or(((InfosLignePieceH.Debit<>0)and(InfosLignePieceH.Credit=0)))then
  if ((not ChangementTauxNonObligatoire)or ( (((InfosLignePieceH.Debit=0)and(InfosLignePieceH.Credit<>0)))or(((InfosLignePieceH.Debit<>0)and(InfosLignePieceH.Credit=0))) ))then
    begin//s'il n'y a pas de lignes hors taxes qui s'inversent
    for i:=0 to ListIdentifiant.Count-1 do
      Begin //debut du for
         if ((Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.TypeLigne='H')and(Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.tva.Compte=Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.Compte)
         and ((Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Debit<>0)or(Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Credit<>0)))then
           Begin
            if (((InfosLignePieceH.Debit=0)and(InfosLignePieceH.Credit<>0)))or(((InfosLignePieceH.Debit<>0)and(InfosLignePieceH.Credit=0))) then
              begin//si changer taux
                  sens_Et_SoldeLigne:=RecupSens_Et_SoldeSurEcritureListe(i,ListIdentifiant);
                  if ((sens_Et_SoldeLigne.SensSoldeCredit=-1)and(InfosLignePieceH.Debit<>0)) then//si debit
                    Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva:=arrondi((MontantTVADebit*Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Debit)/InfosLignePieceH.Debit,2)
                  else   //si credit
                    if ((sens_Et_SoldeLigne.SensSoldeCredit=1)and(InfosLignePieceH.Credit<>0)) then
                      Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva:=arrondi((MontantTVACredit*Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.credit)/InfosLignePieceH.Credit,2);
                  DerniereLigne:=i;
                  if (sens_Et_SoldeLigne.Solde<>0) then
                    Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.TvaTaux:=arrondi((Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva*100)/sens_Et_SoldeLigne.Solde,2);
                  cumulMontantTva:=cumulMontantTva-Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                  RepartMontantTva:=RepartMontantTva-Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
              end//fin si changer taux
            else
              if not ChangementTauxNonObligatoire then
              begin //si pas besoin de ChangerTaux
                  sens_Et_SoldeLigne:=RecupSens_Et_SoldeSurEcritureListe(i,ListIdentifiant);
                  if sens_Et_SoldeLigne.SensSoldeCredit=-1 then//si debit
                    begin
                    Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva:=arrondi((Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Debit*Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.TvaTaux)/100,2);
                    if sensLigneTva = 1 then
                      begin
                        cumulMontantTva:=cumulMontantTva+Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                        RepartMontantTva:=RepartMontantTva-Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                      end
                    else
                    if sensLigneTva = -1 then
                      begin
                        cumulMontantTva:=cumulMontantTva-Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                        RepartMontantTva:=RepartMontantTva+Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                      end;
                    end
                  else   //si credit
                  if sens_Et_SoldeLigne.SensSoldeCredit=1 then
                    begin
                      Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva:=arrondi((Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.credit*Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.TvaTaux)/100,2);
                    if sensLigneTva = 1 then
                      begin
                        cumulMontantTva:=cumulMontantTva-Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                        RepartMontantTva:=RepartMontantTva+Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                      end
                    else
                    if sensLigneTva = -1 then
                      begin
                       cumulMontantTva:=cumulMontantTva+Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                       RepartMontantTva:=RepartMontantTva-Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.MontantTva;
                      end
                    end;
                  DerniereLigne:=i;
              end //fin si pas besoin de ChangerTaux
           End;
      End;//fin de la boucle du for
    if ((cumulMontantTva<>0)and(DerniereLigne<>-1)) then
       if not (((InfosLignePieceH.Debit=0)and(InfosLignePieceH.Credit<>0)))or(((InfosLignePieceH.Debit<>0)and(InfosLignePieceH.Credit=0))) then
         begin //si existance de ligne inverse pour un m�me code tva
                if(sensLigneTva<>sens_Et_SoldeLigne.SensSoldeCredit)then signe:=-1
                else signe:=1;
                if sens_Et_SoldeLigne.SensSoldeCredit=-1 then
                   begin
                     Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.MontantTva:=Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.MontantTva+(signe*cumulMontantTva);
                     if Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Debit<>0 then
                       Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.TvaTaux:=arrondi((Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.MontantTva*100)/Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Debit,2);
                   end
                else
                   begin
                     Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.MontantTva:=Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.MontantTva+(signe*cumulMontantTva);
                     if Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Credit<>0 then
                       Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.TvaTaux:=arrondi((Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.MontantTva*100)/Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Credit,2);
                   end;
         end//fin si existance de ligne inverse pour un m�me code tva
       else
       Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.MontantTva:=Pidentifiant_obj(ListIdentifiant.items[DerniereLigne])^.Ligne.Complement.MontantTva+cumulMontantTva;
    end//fin s'il n'y a pas de lignes hors taxes qui s'inversent
  else
    begin
//      showmessage('');
      if Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.debit<Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.credit then
           Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.credit:=InfosLignePieceH.MontantTva
      else
         if Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.debit>Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.credit then
            Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.debit:=InfosLignePieceH.MontantTva;
      Pidentifiant_obj(ListIdentifiant.items[LigneTva])^.Ligne.tva.MontantReel:=InfosLignePieceH.MontantTva;
      if Grille<>nil then
        CorrectionLigneTva(ligneTva,lignetva,'T',true,Grille);
      raise ExceptLGR.Create('Vous ne pouvez pas changer directement le montant TVA sur une ligne qui concerne plusieurs lignes hors taxes de sens oppos�. Pour cela, vous pouvez changer la ligne TVA en passant par le compl�ment de chaque ligne concern�e par ce compte de TVA.',0,true,mtError,Exception);
    end;
end;//fin si le montant de la ligne de tva est different du total des tva des lignes hors taxes
End;

Function TEcriture_Isa.RecupListeEcriture_PourAffichage(Liste:Tlist;Rang:integer):string;
Begin
result:='';
//  result:=result+inttostr(Pidentifiant_obj(liste.items[Rang])^.IDLigne)+';';
//  result:=result+inttostr(Pidentifiant_obj(liste.items[Rang])^.ID_Tmp)+';';
//  result:=result+inttostr(Pidentifiant_obj(liste.items[Rang])^.ID_Ord)+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.Compte+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.tiers+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.Libelle+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.Qt1+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.Qt2+';';
  result:=result+Currtostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.Debit)+';';
  result:=result+Currtostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.Credit)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.init)+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.TypeLigne+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.Ligne.Appartient)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.Ligne.Derniere)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.ChampCompte.readOnly)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.ChampQt1.readOnly)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.ChampQt2.readOnly)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.SensCredit)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.TVA.Retour)+';';
//  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.TVA.CodeTva+';';
//  result:=result+Floattostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.TVA.TauxMin)+';';
//  result:=result+Floattostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.TVA.TauxMax)+';';
//  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.TVA.Compte+';';
//  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.TVA.Libelle+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.TVA.sensCredit)+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.Complement.CodeTvaCompl+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.Complement.TvaType+';';
  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.Complement.TvaDate+';';
  result:=result+Floattostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.Complement.TvaTaux)+';';
  result:=result+Floattostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.Complement.MontantTva)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.ligne.Complement.rempli)+';';
//  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.ComplementTmp.CodeTvaCompl+';';
//  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.ComplementTmp.TvaType+';';
//  result:=result+Pidentifiant_obj(liste.items[Rang])^.Ligne.ComplementTmp.TvaDate+';';
//  result:=result+Floattostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.ComplementTmp.TvaTaux)+';';
//  result:=result+Floattostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.ComplementTmp.MontantTva)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.ligne.ComplementTmp.rempli)+';';
//  result:=result+Booltostr(Pidentifiant_obj(liste.items[Rang])^.Ligne.Enregistrer)+';';
//  result:=result+Pidentifiant_obj(liste.items[Rang])^.InfosTrame.CptRepartion+';';
//  result:=result+Pidentifiant_obj(liste.items[Rang])^.InfosTrame.LibelleRepartion+';';
//  result:=result+Floattostr(Pidentifiant_obj(liste.items[Rang])^.InfosTrame.TauxRepartion)+';';
End;


function TEcriture_Isa.ExistenceIdemParamTVA(CompteTva:string;Curr:integer):boolean;
var
I:integer;
Begin
result:=false;
i:=1;
while ((not result)and(i<=ListIdentifiant.Count-1)) do
   Begin
   if ((i=curr) and (i+1<=ListIdentifiant.Count-1))then
   inc(i);
     if ((Pidentifiant_obj(ListIdentifiant.Items[i])^.Ligne.TVA.Compte=CompteTva)and (Pidentifiant_obj(ListIdentifiant.Items[i])^.Ligne.TypeLigne<>'T')) then
     result:=true;
   inc(i);
   End;
End;

function TEcriture_Isa.RecherchePremiereLigneTva(var ligne:integer):boolean;
var
Lignetmp:integer;
Begin
result:=false;
 Lignetmp:=ListIdentifiantIndexOf('T','',2);
 if Lignetmp<>-1 then
 Begin
 ligne:=Lignetmp;
 result:=true;
 End;
End;


function TEcriture_Isa.ListIdentifiantIndexOf(valeur,valeurType:string;valeurRech:integer):integer;
var
i:integer;
Begin
result:=-1;
i:=0;
   while i<= ListIdentifiant.Count-1 do
   begin
     case valeurRech of
     1: if inttostr(Pidentifiant_obj(ListIdentifiant.items[i])^.IDLigne)=valeur then
        begin
        result:=i;
        i:=ListIdentifiant.Count-1;
        end;
     2: if Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.TypeLigne=valeur then
        begin
        result:=i;
        i:=ListIdentifiant.Count-1;
        end;
     3:if empty(valeurtype) then
          Begin
            if ((Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.CodeTvaCompl <> valeur) and (Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.TvaTaux=0)) then
               begin
               result:=i;
               i:=ListIdentifiant.Count-1;
               end;
          End
        else
          Begin
            if ((Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.CodeTvaCompl <> valeur) and (Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.CodeTvaCompl =valeurType) and (Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.TvaTaux=0)) then
               begin
               result:=i;
               i:=ListIdentifiant.Count-1;
               end;
          End;
     4: if Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Compte=valeur then
        begin
        result:=i;
        i:=ListIdentifiant.Count-1;
        end;
    24: if ((Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.Complement.TvaType=valeur)and(Pidentifiant_obj(ListIdentifiant.items[i])^.Ligne.TypeLigne='H')) then
        begin
        result:=i;
        i:=ListIdentifiant.Count-1;
        end;
     end;//fin du case
   inc(i);
   end;
End;

Function CopieContenuEcriture_Isa(Source,Dest:TEcriture_isa;AvecCreation:boolean):boolean;
var
varParamLigneObj:TParamLigneObj;
VarInfosPointage:TPointage;
VarPIdentifiant_obj:PIdentifiant_obj;
VarPRecordEcriture:PRecordEcriture;
VarPEcriture_A_Regler:PEcriture_A_Regler;
Begin
try
if source<>nil then
begin //si source <>nil
if ((Dest=nil)and(aveccreation)) then
  Dest:=TEcriture_isa.Create(application.MainForm);
if Dest=nil then exit;
//  AssignListeEX(Source.ListIdentifiant,Dest.ListIdentifiant,VarPIdentifiant_obj);
  AssignListIdentifiant(Source.ListIdentifiant,Dest.ListIdentifiant);
//  AssignListeEX(Source.ListeEcriturePiece,Dest.ListeEcriturePiece,VarPRecordEcriture);
  AssignListeEcriturePiece(Source.ListeEcriturePiece,Dest.ListeEcriturePiece);
  Dest.TableEcriture:=Source.TableEcriture;
  Dest.TableTrameL:=Source.TableTrameL;
//
  varParamLigneObj.CodeTva:=Source.ParamLigneObj.CodeTva;
  varParamLigneObj.CompteTva:=Source.ParamLigneObj.CompteTva;
  varParamLigneObj.CompteValide:=Source.ParamLigneObj.CompteValide;
  varParamLigneObj.IDJournal:=Source.ParamLigneObj.IDJournal;
  varParamLigneObj.Qt1:=Source.ParamLigneObj.Qt1;
  varParamLigneObj.Qt2:=Source.ParamLigneObj.Qt2;
  varParamLigneObj.SensCredit:=Source.ParamLigneObj.SensCredit;
  varParamLigneObj.TvaMaxi:=Source.ParamLigneObj.TvaMaxi;
  varParamLigneObj.TvaMini:=Source.ParamLigneObj.TvaMini;
  Dest.ParamLigneObj:=varParamLigneObj;
//
  CopieContenuPiece(Source.Piece,Dest.Piece,AvecCreation);
  
  //AssignListeEX(Source.ListeContrepartie,Dest.ListeContrepartie,VarPEcriture_A_Regler);
  AssignListeContrepartie(Source.ListeContrepartie,Dest.ListeContrepartie);
  Dest.CompteEcriture:=Source.CompteEcriture;
  Dest.TiersEcriture:=Source.TiersEcriture;
  Dest.SoldeEcriture:=Source.SoldeEcriture;
  Dest.SensEcriture:=Source.SensEcriture;
  Dest.LibelleEcriture:=Source.LibelleEcriture;
  Dest.DateEcriture:=Source.DateEcriture;
  Dest.TableTVA:=Source.TableTVA;
  Dest.TablePlan:=Source.TablePlan;
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
  Dest.FirstIDEcriture:=Source.FirstIDEcriture;
  Dest.LastIDEcriture:=Source.LastIDEcriture;
  Dest.NextIDEcriture:=Source.NextIDEcriture;
  Dest.FRecIdentifiant:=Source.FRecIdentifiant;
  Dest.FRecordEcriture:=Source.FRecordEcriture;
  Dest.DispatcherTva:=Source.DispatcherTva;
end;//fin si source <>nil
except
  showmessage('Erreur Interne sur CopieContenuEcriture_Isa : ');
end;
end;


function AssignListIdentifiant(ListeSource:Tlist;ListeDest:Tlist;rang:integer):TExceptLGR;
var
i,j:integer;
P:PIdentifiant_obj;
Begin
try
result.retour:=true;
if ListeDest= nil then ListeDest:=TList.Create;
if ListeSource= nil then abort;
j:=0;
if rang<>-1 then
  j:=rang
else
begin
 Initialise_Tlist(ListeDest,nil,false);
 rang:=ListeSource.count-1;
end;
   for i:=j to rang do
     begin
       new(P);
//
               P.IDLigne:=PIdentifiant_obj(ListeSource.Items[i])^.IDLigne;
               P.ID_Tmp:=PIdentifiant_obj(ListeSource.Items[i])^.ID_Tmp;
               P.ID_Ord:=PIdentifiant_obj(ListeSource.Items[i])^.ID_Ord;
               p.Ligne.Compte:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Compte;
               p.Ligne.tiers:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Tiers;
               p.Ligne.Libelle:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Libelle;
               p.Ligne.Qt1:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Qt1;
               p.Ligne.Qt2:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Qt2;
               p.Ligne.Debit:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Debit;
               p.Ligne.Credit:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Credit;
               P.Ligne.init:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.init;
               P.Ligne.TypeLigne:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TypeLigne;
               P.Ligne.Ligne.Appartient:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Ligne.Appartient;
               P.Ligne.Ligne.Derniere:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Ligne.Derniere;
               P.Ligne.ChampCompte.readOnly:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ChampCompte.readOnly;
               P.Ligne.ChampQt1.readOnly:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ChampQt1.readOnly;
               P.Ligne.ChampQt2.readOnly:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ChampQt2.readOnly;
               P.Ligne.SensCredit:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.SensCredit;
               P.Ligne.TVA.Retour:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.Retour;
               P.Ligne.TVA.CodeTva:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.CodeTva;
               P.Ligne.TVA.TauxMin:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.TauxMin;
               P.Ligne.TVA.TauxMax:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.TauxMax;
               P.Ligne.TVA.Compte:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.Compte;
               P.Ligne.TVA.Libelle:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.Libelle;
               P.Ligne.TVA.sensCredit:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.sensCredit;
               P.Ligne.Complement.CodeTvaCompl:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.CodeTvaCompl;
               P.Ligne.Complement.TvaType:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.TvaType;
               P.Ligne.Complement.TvaDate:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.TvaDate;
               P.Ligne.Complement.TvaTaux:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.TvaTaux;
               P.Ligne.Complement.MontantTva:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.MontantTva;
               P.Ligne.Complement.rempli:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.rempli;
               P.Ligne.ComplementTmp.CodeTvaCompl:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.CodeTvaCompl;
               P.Ligne.ComplementTmp.TvaType:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.TvaType;
               P.Ligne.ComplementTmp.TvaDate:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.TvaDate;
               P.Ligne.ComplementTmp.TvaTaux:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.TvaTaux;
               P.Ligne.Complement.MontantTva:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.MontantTva;
               P.Ligne.ComplementTmp.rempli:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.rempli;
               P.Ligne.Enregistrer:=PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Enregistrer;
               P.InfosTrame.CptRepartion:=PIdentifiant_obj(ListeSource.Items[i])^.InfosTrame.CptRepartion;
               P.InfosTrame.LibelleRepartion:=PIdentifiant_obj(ListeSource.Items[i])^.InfosTrame.LibelleRepartion;
               P.InfosTrame.TauxRepartion:=PIdentifiant_obj(ListeSource.Items[i])^.InfosTrame.TauxRepartion;
//
       ListeDest.Add(P);
     end;
except
   raise ExceptLGR.Create('AssignListIdentifiant : L"objet source est nil !!!',1,true,mtError,result)
end;
End;




function AssignListeEcriturePiece(ListeSource:Tlist;ListeDest:Tlist;rang:integer):TExceptLGR;
var
i,j:integer;
P:PRecordEcriture;
Begin
try
result.retour:=true;
if ListeDest= nil then ListeDest:=TList.Create;
if ListeSource= nil then abort;
j:=0;
if rang<>-1 then
  j:=rang
else
begin
 Initialise_Tlist(ListeDest,nil,false);
 rang:=ListeSource.count-1;
end;
   for i:=j to rang do
     begin
       new(P);
//         
               P.TypeLigne:=PRecordEcriture(ListeSource.Items[i])^.TypeLigne;
               P.Compte:=PRecordEcriture(ListeSource.Items[i])^.Compte;
               P.CompteTiers:=PRecordEcriture(ListeSource.Items[i])^.CompteTiers;
               P.Libelle:=PRecordEcriture(ListeSource.Items[i])^.Libelle;
               P.Qt1:=PRecordEcriture(ListeSource.Items[i])^.Qt1;
               P.Qt2:=PRecordEcriture(ListeSource.Items[i])^.Qt2;
               P.MontantHt:=PRecordEcriture(ListeSource.Items[i])^.MontantHt;
               P.MontantTVA:=PRecordEcriture(ListeSource.Items[i])^.MontantTVA;
               P.CompteTVA:=PRecordEcriture(ListeSource.Items[i])^.CompteTVA;
               P.CodeTVA:=PRecordEcriture(ListeSource.Items[i])^.CodeTVA;
               P.TauxTVA:=PRecordEcriture(ListeSource.Items[i])^.TauxTVA;
               P.TypeTVA:=PRecordEcriture(ListeSource.Items[i])^.TypeTVA;
               P.DateTVA:=PRecordEcriture(ListeSource.Items[i])^.DateTVA;
               p.Addresse1:=PRecordEcriture(ListeSource.Items[i])^.Addresse1;
               p.Addresse2:=PRecordEcriture(ListeSource.Items[i])^.Addresse2;
               P.CodePostal:=PRecordEcriture(ListeSource.Items[i])^.CodePostal;
               P.CptRepartition:=PRecordEcriture(ListeSource.Items[i])^.CptRepartition;
               P.LibelleRepartition:=PRecordEcriture(ListeSource.Items[i])^.LibelleRepartition;
               P.NomTiers:=PRecordEcriture(ListeSource.Items[i])^.NomTiers;
               P.TauxRepartition:=PRecordEcriture(ListeSource.Items[i])^.TauxRepartition;
               P.Ville:=PRecordEcriture(ListeSource.Items[i])^.ville;
               P.ID_Piece:=PRecordEcriture(ListeSource.Items[i])^.ID_Piece;
//
       ListeDest.Add(P);
     end;
except
   raise ExceptLGR.Create('AssignListeEcriturePiece : L"objet source est nil !!!',1,true,mtError,result)
end;
End;

function AssignListeContrepartie(ListeSource:Tlist;ListeDest:Tlist;rang:integer):TExceptLGR;
var
i,j:integer;
P:PEcriture_A_Regler;
Begin
try
result.retour:=true;
if ListeDest= nil then ListeDest:=TList.Create;
if ListeSource= nil then abort;
j:=0;
if rang<>-1 then
  j:=rang
else
begin
 Initialise_Tlist(ListeDest,nil,false);
 rang:=ListeSource.count-1;
end;
   for i:=j to rang do
     begin
       new(P);//

               P.CompteReglement:=PEcriture_A_Regler(ListeSource.Items[i])^.CompteReglement;
               P.ID_Ecriture:=PEcriture_A_Regler(ListeSource.Items[i])^.ID_Ecriture;
               P.Montant:=PEcriture_A_Regler(ListeSource.Items[i])^.Montant;
               P.Sens:=PEcriture_A_Regler(ListeSource.Items[i])^.Sens;
               P.Tiers_:=PEcriture_A_Regler(ListeSource.Items[i])^.Tiers_;
               P.TvaSurE:=PEcriture_A_Regler(ListeSource.Items[i])^.TvaSurE;
//
       ListeDest.Add(P);
     end;
except
   raise ExceptLGR.Create('AssignListeContrepartie : L"objet source est nil !!!',1,true,mtError,result)
end;
End;



///pour d�buggage
function CopieListIdentifiant_DansFichier(ListeSource:Tlist;rang:integer;NomFichier:string):TStringlist;
var
i,j:integer;
Begin
try
result:=TStringList.Create;
if ListeSource= nil then abort;
j:=0;
if rang<>-1 then
  j:=rang
else
 rang:=ListeSource.count-1;
Result.Add('ListIdentifiant.count = '+inttostr(ListeSource.count));

   for i:=j to rang do
     begin
//
               Result.Add('rang = '+inttostr(i));
               Result.Add('IDLigne='+inttostr(PIdentifiant_obj(ListeSource.Items[i])^.IDLigne));
               Result.Add('ID_Tmp='+inttostr(PIdentifiant_obj(ListeSource.Items[i])^.ID_Tmp));
               Result.Add('ID_Ord='+inttostr(PIdentifiant_obj(ListeSource.Items[i])^.ID_Ord));
               Result.Add('Ligne.Compte='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Compte);
               Result.Add('Ligne.Tiers='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Tiers);
               Result.Add('Ligne.Libelle='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Libelle);
               Result.Add('Ligne.Qt1='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Qt1);
               Result.Add('Ligne.Qt2='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Qt2);
               Result.Add('Ligne.Debit='+currtostr(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Debit));
               Result.Add('Ligne.Credit='+currtostr(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Credit));
               Result.Add('Ligne.init='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.init));
               Result.Add('Ligne.TypeLigne='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TypeLigne);
               Result.Add('Ligne.Ligne.Appartient='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Ligne.Appartient));
               Result.Add('Ligne.Ligne.Derniere='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Ligne.Derniere));
               Result.Add('Ligne.ChampCompte.readOnly='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ChampCompte.readOnly));
               Result.Add('Ligne.ChampQt1.readOnly='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ChampQt1.readOnly));
               Result.Add('Ligne.ChampQt2.readOnly='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ChampQt2.readOnly));
               Result.Add('Ligne.SensCredit='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.SensCredit));
               Result.Add('Ligne.TVA.Retour='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.Retour));
               Result.Add('Ligne.TVA.CodeTva='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.CodeTva);
               Result.Add('Ligne.TVA.TauxMin='+floattostr(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.TauxMin));
               Result.Add('Ligne.TVA.TauxMax='+floattostr(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.TauxMax));
               Result.Add('Ligne.TVA.Compte='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.Compte);
               Result.Add('Ligne.TVA.Libelle='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.Libelle);
               Result.Add('Ligne.TVA.sensCredit='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.TVA.sensCredit));
               Result.Add('Ligne.Complement.CodeTvaCompl='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.CodeTvaCompl);
               Result.Add('Ligne.Complement.TvaType='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.TvaType);
               Result.Add('Ligne.Complement.TvaDate='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.TvaDate);
               Result.Add('Ligne.Complement.TvaTaux='+floattostr(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.TvaTaux));
               Result.Add('Ligne.Complement.MontantTva='+currtostr(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.MontantTva));
               Result.Add('Ligne.Complement.rempli='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.rempli));
               Result.Add('Ligne.ComplementTmp.CodeTvaCompl='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.CodeTvaCompl);
               Result.Add('Ligne.ComplementTmp.TvaType='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.TvaType);
               Result.Add('Ligne.ComplementTmp.TvaDate='+PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.TvaDate);
               Result.Add('Ligne.ComplementTmp.TvaTaux='+floattostr(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.TvaTaux));
               Result.Add('Ligne.Complement.MontantTva='+currtostr(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Complement.MontantTva));
               Result.Add('Ligne.ComplementTmp.rempli='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.ComplementTmp.rempli));
               Result.Add('Ligne.Enregistrer='+str_bool2str(PIdentifiant_obj(ListeSource.Items[i])^.Ligne.Enregistrer));
               Result.Add('InfosTrame.CptRepartion='+PIdentifiant_obj(ListeSource.Items[i])^.InfosTrame.CptRepartion);
               Result.Add('InfosTrame.LibelleRepartion='+PIdentifiant_obj(ListeSource.Items[i])^.InfosTrame.LibelleRepartion);
               Result.Add('InfosTrame.TauxRepartion='+floattostr(PIdentifiant_obj(ListeSource.Items[i])^.InfosTrame.TauxRepartion));
               Result.Add('------------------');
//
     end;
    if empty(nomfichier)then nomfichier:='C:\Projet\Epicea-2\Execution\Exportation\Piece_Courante.txt';
    Result.SaveToFile(nomfichier);
except
   showmessage('CopieListIdentifiant_DansFichier : L"objet source est nil !!!');
end;
End;


function CopieListeContrepartie_DansFichier(ListeSource:Tlist;rang:integer;NomFichier:string):Tstringlist;
var
i,j:integer;
Begin
try
Result:=TStringList.Create;
if ListeSource= nil then abort;
j:=0;
if rang<>-1 then
  j:=rang
else
 rang:=ListeSource.count-1;
result.Add('ListeContrepartie.count = '+inttostr(ListeSource.count));

   for i:=j to rang do
     begin
         Result.Add('rang = '+inttostr(i));
         Result.Add('CompteReglement = '+PEcriture_A_Regler(ListeSource.Items[i])^.CompteReglement);
         Result.Add('ID_Ecriture = '+inttostr(PEcriture_A_Regler(ListeSource.Items[i])^.ID_Ecriture));
         Result.Add('Montant = '+currtostr(PEcriture_A_Regler(ListeSource.Items[i])^.Montant));
         Result.Add('Sens = '+inttostr(PEcriture_A_Regler(ListeSource.Items[i])^.Sens));
         Result.Add('Tiers_ = '+PEcriture_A_Regler(ListeSource.Items[i])^.Tiers_);
         Result.Add('TvaSurE = '+str_bool2str(PEcriture_A_Regler(ListeSource.Items[i])^.TvaSurE));
         Result.Add('------------------');
//
     end;
    if empty(nomfichier)then nomfichier:='C:\Projet\Epicea-2\Execution\Exportation\Piece_Courante.txt';
    Result.SaveToFile(nomfichier);
except
   showmessage('CopieListeContrepartie_DansFichier : L"objet source est nil !!!');
end;
End;


function CopieListeEcriturePiece_DansFichier(ListeSource:Tlist;rang:integer;NomFichier:string):Tstringlist;
var
i,j:integer;
Begin
try
result:=Tstringlist.Create;
if ListeSource= nil then abort;
j:=0;
if rang<>-1 then
  j:=rang
else
 rang:=ListeSource.count-1;

Result.Add('ListeEcriturePiece.count = '+inttostr(ListeSource.count));
   for i:=j to rang do
     begin
//
         Result.Add('rang = '+inttostr(i));
         Result.Add('TypeLigne = '+PRecordEcriture(ListeSource.Items[i])^.TypeLigne);
         Result.Add('Compte = '+PRecordEcriture(ListeSource.Items[i])^.Compte);
         Result.Add('CompteTiers = '+PRecordEcriture(ListeSource.Items[i])^.CompteTiers);
         Result.Add('Libelle = '+PRecordEcriture(ListeSource.Items[i])^.Libelle);
         Result.Add('Qt1 = '+currtostr(PRecordEcriture(ListeSource.Items[i])^.Qt1));
         Result.Add('Qt2 = '+currtostr(PRecordEcriture(ListeSource.Items[i])^.Qt2));
         Result.Add('MontantHt = '+currtostr(PRecordEcriture(ListeSource.Items[i])^.MontantHt));
         Result.Add('MontantTVA = '+currtostr(PRecordEcriture(ListeSource.Items[i])^.MontantTVA));
         Result.Add('CompteTVA = '+PRecordEcriture(ListeSource.Items[i])^.CompteTVA);
         Result.Add('CodeTVA = '+PRecordEcriture(ListeSource.Items[i])^.CodeTVA);
         Result.Add('TauxTVA = '+currtostr(PRecordEcriture(ListeSource.Items[i])^.TauxTVA));
         Result.Add('TypeTVA = '+PRecordEcriture(ListeSource.Items[i])^.TypeTVA);
         Result.Add('DateTVA = '+PRecordEcriture(ListeSource.Items[i])^.DateTVA);
         Result.Add('Addresse1 = '+PRecordEcriture(ListeSource.Items[i])^.Addresse1);
         Result.Add('Addresse2 = '+PRecordEcriture(ListeSource.Items[i])^.Addresse2);
         Result.Add('CptRepartition = '+PRecordEcriture(ListeSource.Items[i])^.CodePostal);
         Result.Add('CptRepartition = '+PRecordEcriture(ListeSource.Items[i])^.CptRepartition);
         Result.Add('LibelleRepartition = '+PRecordEcriture(ListeSource.Items[i])^.LibelleRepartition);
         Result.Add('NomTiers = '+PRecordEcriture(ListeSource.Items[i])^.NomTiers);
         Result.Add('TauxRepartition = '+floattostr(PRecordEcriture(ListeSource.Items[i])^.TauxRepartition));
         Result.Add('ville = '+PRecordEcriture(ListeSource.Items[i])^.ville);
         Result.Add('ID_Piece = '+inttostr(PRecordEcriture(ListeSource.Items[i])^.ID_Piece));
         Result.Add('------------------');
//
     end;
    if empty(nomfichier)then nomfichier:='C:\Projet\Epicea-2\Execution\Exportation\Piece_Courante.txt';
    Result.SaveToFile(nomfichier);
except
   showmessage('AssignListeEcriturePiece : L"objet source est nil !!!');
end;
End;


Function CopieContenuEcriture_Isa_DansFichier(Source:TEcriture_isa;NomFichier:string):Tstringlist;
var
varParamLigneObj:TParamLigneObj;
VarInfosPointage:TPointage;
VarPIdentifiant_obj:PIdentifiant_obj;
VarPRecordEcriture:PRecordEcriture;
VarPEcriture_A_Regler:PEcriture_A_Regler;
listeTmp:Tstringlist;
i:integer;
Begin
try
if source<>nil then
begin //si source <>nil
result:=Tstringlist.Create;
Initialise_TStringlist(result,nil,false);

listeTmp:=Tstringlist.Create;
Initialise_TStringlist(listeTmp,nil,false);

  result.Add(source.Name);
  Result.Add('------ Pi�ce ------');

  listeTmp:=CopieContenuPiece_DansFichier(Source.Piece);
    if listeTmp<>nil then
      begin
        for i :=0 to listeTmp.count-1 do
          result.add(listeTmp.Strings[i]);
      end;
  Initialise_TStringlist(listeTmp,nil,false);

  Result.Add('------ Ecriture ------');

  listeTmp:=CopieListIdentifiant_DansFichier(Source.ListIdentifiant);
    if listeTmp<>nil then
      begin
        for i :=0 to listeTmp.count-1 do
          result.add(listeTmp.Strings[i]);
      end;
  Initialise_TStringlist(listeTmp,nil,false);

  listeTmp:=CopieListeEcriturePiece_DansFichier(Source.ListeEcriturePiece);
    if listeTmp<>nil then
      begin
        for i :=0 to listeTmp.count-1 do
          result.add(listeTmp.Strings[i]);
      end;
  Initialise_TStringlist(listeTmp,nil,false);

  listeTmp:=CopieListeContrepartie_DansFichier(Source.ListeContrepartie);
    if listeTmp<>nil then
      begin
        for i :=0 to listeTmp.count-1 do
          result.add(listeTmp.Strings[i]);
      end;
  Initialise_TStringlist(listeTmp,nil,false);

  if source.TableEcriture=nil then
    Result.Add('TableEcriture = Nil')
  else
    Result.Add('TableEcriture = '+source.TableEcriture.TableName);
  if source.TableTrameL=nil then
    Result.Add('TableTrameL = Nil')
  else
    Result.Add('TableTrameL = '+source.TableTrameL.TableName);
//
  result.Add('ParamLigneObj.CodeTva = '+Source.ParamLigneObj.CodeTva);
  result.Add('ParamLigneObj.CompteTva = '+Source.ParamLigneObj.CompteTva);
  result.Add('ParamLigneObj.CompteValide = '+str_bool2str(Source.ParamLigneObj.CompteValide));
  result.Add('ParamLigneObj.IDJournal = '+inttostr(Source.ParamLigneObj.IDJournal));
  result.Add('ParamLigneObj.Qt1 = '+str_bool2str(Source.ParamLigneObj.Qt1));
  result.Add('ParamLigneObj.Qt2 = '+str_bool2str(Source.ParamLigneObj.Qt2));
  result.Add('ParamLigneObj.SensCredit = '+str_bool2str(Source.ParamLigneObj.SensCredit));
  result.Add('ParamLigneObj.TvaMaxi = '+floattostr(Source.ParamLigneObj.TvaMaxi));
  result.Add('ParamLigneObj.TvaMini = '+floattostr(Source.ParamLigneObj.TvaMini));
  Result.Add('------------------');
//

  result.Add(source.Name+'- suite');
  result.Add('CompteEcriture = '+Source.CompteEcriture);
  result.Add('TiersEcriture = '+Source.TiersEcriture);
  result.Add('SoldeEcriture = '+currtostr(Source.SoldeEcriture));
  result.Add('SensEcriture = '+inttostr(Source.SensEcriture));
  result.Add('LibelleEcriture = '+Source.LibelleEcriture);
  result.Add('DateEcriture = '+Datetostr(Source.DateEcriture));
  if source.TableTVA=nil then
    Result.Add('TableTVA = Nil')
  else
    Result.Add('TableTVA = '+source.TableTVA.TableName);
  if source.TablePlan=nil then
    Result.Add('TablePlan = Nil')
  else
    Result.Add('TablePlan = '+source.TablePlan.TableName);
//
  if Source.InfosPointage.infosPointage.Dataset=nil then
    Result.Add('InfosPointage.infosPointage.Dataset = Nil')
  else
    Result.Add('InfosPointage.infosPointage.Dataset = '+source.InfosPointage.infosPointage.Dataset.Name);
  result.Add('InfosPointage.infosPointage.Lettre = '+Source.InfosPointage.infosPointage.Lettre);
  result.Add('InfosPointage.infosPointage.Ligne = '+inttostr(Source.InfosPointage.infosPointage.Ligne));
  result.Add('InfosPointage.infosPointage.MontantPointage = '+currtostr(Source.InfosPointage.infosPointage.MontantPointage));
  result.Add('InfosPointage.infosPointage.NbLignePointee = '+inttostr(Source.InfosPointage.infosPointage.NbLignePointee));
  result.Add('InfosPointage.infosPointage.Pointee = '+str_bool2str(Source.InfosPointage.infosPointage.Pointee));
  result.Add('InfosPointage.infosPointage.TvaSurE = '+str_bool2str(Source.InfosPointage.infosPointage.TvaSurE));
  result.Add('InfosPointage.InfosReste.Reste = '+currtostr(Source.InfosPointage.InfosReste.Reste));
  result.Add('InfosPointage.InfosReste.ResteInitial = '+currtostr(Source.InfosPointage.InfosReste.ResteInitial));
  result.Add('InfosPointage.InfosReste.SensReste = '+str_bool2str(Source.InfosPointage.InfosReste.SensReste));
  result.Add('FirstIDEcriture = '+inttostr(Source.FirstIDEcriture));
  result.Add('LastIDEcriture = '+inttostr(Source.LastIDEcriture));
  result.Add('NextIDEcriture = '+inttostr(Source.NextIDEcriture));
  result.Add('DispatcherTva = '+str_bool2str(Source.DispatcherTva));
      Result.Add('-------------------');

    if empty(nomfichier)then nomfichier:='C:\Projet\Epicea-2\Execution\Exportation\Piece_Courante.txt';
    Result.SaveToFile(nomfichier);
end;//fin si source <>nil
except
  showmessage('Erreur Interne sur CopieContenuEcriture_Isa_DansFichier : ');
end;
end;


function TEcriture_Isa.GestionDesQuantites(compte:string;ValeurExistante:String;SensLigne:boolean;SensCompte:integer;PieceModifiable:Boolean;ValeurLigne:real):String;
var
SensLigneConverti:integer;
begin
result:=ValeurExistante;
if PieceModifiable then
 PieceModifiable:=((Piece.EtatPiece=dsinsert)or(((Piece.EtatPiece=dsedit)and(((Piece.Modifier_Confirmer)or(Piece.Modifier_EnAttente))))));
if PieceModifiable then
  begin
      SensLigneConverti:=C_Nul;
      //g�rer l'affichage des quantit�s
      //si senscompte est ind�termin�, alors r�cup�rer les param�tres du compte
      if SensCompte=C_Nul then
        Begin
          DeFiltrageDataSet(TablePlan);
          if Infos_TInfosplancpt(TablePlan,'Compte',[compte]).SensCredit then
            SensCompte:=C_True
          else
            SensCompte:=C_False;
        end;

      if (SensLigne)  then
        SensLigneConverti:=C_True
      else
        SensLigneConverti:=C_False;

      if ((SensCompte<>SensLigneConverti)and (valeurLigne<>0) and(SensLigneConverti<>C_Nul)) then
       begin
         if StrToCurr_Lgr(ValeurExistante)>0 then
           ValeurExistante:='-'+ValeurExistante;
       end
      else
        if SensLigneConverti<>C_Nul  then
         begin
         if StrToCurr_Lgr(ValeurExistante)<0 then
           ValeurExistante:=str_Suppr_N_Car_AGauche(ValeurExistante,1);
         end;
      result:=ValeurExistante;
  end;//fin si pi�ce modifiable
end;


end.

