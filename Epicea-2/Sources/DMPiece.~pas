//{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y-,Z1}
//{$MINSTACKSIZE $00004000}
//{$MAXSTACKSIZE $00100000}
//{$IMAGEBASE $00400000}
//{$APPTYPE GUI}
unit DMPiece;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  DBTables,
  Db,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  E2_AideCompte,
  Piece,
  LibSql,
  DMChargesRepartir,
  Ecriture_Isa,
  ObjReglement,
  E2_Decl_Records,
  DMBaseDonnee,
  DMRecherche,
  DMPlanCpt,
  DMBalances,
  LibDates,
  E2_LibInfosTable,
  GrGrid,
  Lib_Chaine,
  ComCtrls,
  E2_VisuListeView,DiversProjets,
  LibImport;
type


  PObjetOD= ^TObjetOD;


type

  TDMPieces = class(TDataModule)
    TaPiece: TTable;
    DataPiece: TDataSource;
    QueryPiece: TQuery;
    DataQuery: TDataSource;
    QueryPieceMAXOFID: TIntegerField;
    TaPieceReprise1: TTable;
    TaPieceReprise2: TTable;
    DataReprise1: TDataSource;
    DataReprise2: TDataSource;
    TaPieceConsultation: TTable;
    QueryPieceBOTiers: TQuery;
    QueryMinIDPiece: TQuery;
    QueryMinIDPieceMINOFID: TIntegerField;
    TaPieceBal: TTable;
    DaPieceBal: TDataSource;
    QuVisuGestCompte: TQuery;
    TaPieceVerif: TTable;
    TaPieceLookupReglement: TTable;
    TaPieceVisu: TTable;
    DaPieceVisu: TDataSource;
    TaPieceVisuID: TIntegerField;
    TaPieceVisuJournal: TIntegerField;
    TaPieceVisuReference: TStringField;
    TaPieceVisuDate: TDateField;
    TaPieceVisuTypePiece: TSmallintField;
    TaPieceVisuCompte: TStringField;
    TaPieceVisuID_Devise: TIntegerField;
    TaPieceVisuValidation: TDateField;
    TaPieceVisuQui: TStringField;
    TaPieceVisuQuand: TDateTimeField;
    TaPieceVisuLibelleJournal: TStringField;
    TaPieceRecup: TTable;
    TaPieceObjPiece: TTable;
    TaPieceLookupReglementID: TIntegerField;
    TaPieceLookupReglementJournal: TIntegerField;
    TaPieceLookupReglementReference: TStringField;
    TaPieceLookupReglementDate: TDateField;
    TaPieceLookupReglementTypePiece: TSmallintField;
    TaPieceLookupReglementCompte: TStringField;
    TaPieceLookupReglementID_Devise: TIntegerField;
    TaPieceLookupReglementValidation: TDateField;
    TaPieceLookupReglementQui: TStringField;
    TaPieceLookupReglementQuand: TDateTimeField;
    TaPieceVisuLibelle: TStringField;
    TaPieceLookupReglementLibelle: TStringField;
    QuEtatDeVersement: TQuery;
    QuRecupPieceTvaTypeE: TQuery;
    QuRecupPieceTvaTypeEID: TIntegerField;
    QuRecupPieceTvaTypeEID_Piece: TIntegerField;
    QuRecupPieceTvaTypeETypeLigne: TStringField;
    QuRecupPieceTvaTypeECompte: TStringField;
    QuRecupPieceTvaTypeETvatype: TStringField;
    Piece1: TPiece;
    TaPieceVisuComptePereTiers: TStringField;
    TaPiece_Obj: TTable;

    procedure FiltrageSurIDPiece(Ecriture:TTable;IDPiece:integer);//new
    Function MaxIdPiece(AnneeAnterieure:boolean):Integer;
    procedure DMPiecesCreate(Sender: TObject);
    procedure DMPiecesDestroy(Sender: TObject);
    procedure SuppressionOD(OD:string);
    procedure ModificationOD(OD,Libelle:string);
    procedure AffichageFeuilleReprise(NumButton:Integer;Liste1,Liste2:tstringlist;CaptionFeuille,
    CaptionBtn1,CaptionBtn2:string;Bouton:boolean);
    procedure ModificationDatePiece(OD:string;Date:tdatetime);
    procedure CreationPiece(ID,Journal,TypePiece,ID_Devise:integer;Ref,Lib,Compte,Qui,Table_Gen,Champ_Gen,Val_Champ_Gen,NumCheque,CodeGestco:string;Date,Validation,Echeance:Tdate;Quand:Tdatetime;TableGen:boolean;IDGestco:integer);
    function VerifIDPiece(ID:integer;Piece:tPiece;Suppr:boolean):TErreurSaisie;//modif
    function VerifReference(Ref:string;Piece:tPiece;Suppr:boolean):TErreurSaisie;//modif
    function SuppressionPieceEcriture(Ref:string;Piece:Tobject):string;
    function RecupPieceExistante(Ref:string):TRecordPiece;
    procedure TaPieceReprise1BeforeInsert(DataSet: TDataSet);
    Function PieceBOTiersExiste(Compte:string):TRecordPiece;
    Function IDPieceBOTiers:integer;
    Function SuppressionPiece(IDPiece:integer):boolean;
    function RecupIDEcritureTiersSurRef(Ref:string;var IDEcritureTmp:integer):boolean;//new
    function RechercheIDPieceExistant(ID_Old:integer):boolean;
    function EnvoiePieceEcriture_SurListe(Liste:Tlist;Ecriture:TEcriture_Isa;Debit,Credit:currency;Reglement:boolean;Etat:TDataSetState;VerifRef:boolean):TExceptLGR_ImportPiece;
    procedure Piece1NewPiece(Sender: TObject);
    procedure TaPiecePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaPieceRepriseFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaPieceReprise2FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaPieceVisuBeforeOpen(DataSet: TDataSet);
    procedure TaPieceDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
      //isa le 06/02/03////
    procedure GestionFiltrageParamCpt(journal:integer=-1);
    procedure GestionFiltrageParamCptSurCompte(Compte:string;Journal:integer=-1);
    Function CptExclusDeContexte(Compte:String;IndexContexte:Integer):Boolean;
    procedure TaCompteFilterRecordCorps(DataSet: TDataSet;var Accept: Boolean);
    procedure TaCompteFilterRecordEnTete(DataSet: TDataSet;var Accept: Boolean);

    //sortie de saisieP le 02-07-03 par isa
    function RecupParametreCompte(Compte,ChampRech:string):TParametreCompte_obj;
    function RecherchePossibiliteCreationLigne(var ParametreCompteEcriture:TParametreCompte_Obj;LigneRecherche:integer):TCreation_obj;
    function LigneTvaExisteDeja(Compte:string):boolean;
    /////

    Procedure VisuList_DetailClick(Sender : TObject);
    procedure TaPieceVisuCalcFields(DataSet: TDataSet);
    Procedure GereSuppressionPiece_Import(id_Piece:integer);
    procedure TaPieceAfterPost(DataSet: TDataSet);
    procedure TaPieceBeforeDelete(DataSet: TDataSet);
    function verifCoherenceJournal(idJournal:integer;Journal:string):boolean;
    procedure TaPieceAfterDelete(DataSet: TDataSet);
    procedure TaPiece_ObjBeforeOpen(DataSet: TDataSet);
    Procedure VisuList_EnteteClick(Sender : TObject);

  private
    { Déclarations privées }
    Fvisuperiode:Tperiode;
    function LitPeriode:TPeriode;
    procedure EcritPeriode(Periode:TPeriode);
  public
    { Déclarations publiques }
    MaxOD:string;
    ListeODReprise,ListeODReprise2:TStringList; // Utilisé dans TaPieceRepriseFilterRecord pour
                                // Filtrer la table Pièces lors de l'affichage des reprises
                                // ListeODReprise contient la liste des OD qui viennent d'être crées

   ListeCptExclusEnTete:TStringList;// isa le 06/02/03
   ListeCptExclusCorps:TStringList;// isa le 06/02/03
   ListePieceCreees:TStringList;// isa le 06/02/03
   RetourViewListe:TRetourViewListe;
   function ImportPiece( ValeursMaitre:TRecordPiece; ValeursEsclave:Tlist;ValeursPointage:Tlist;AnneeAnterieure:TPieceAnterieure;ValPieceAutoGen:TValPieceAutoGenere;DataSet:TDataSet;AcceptPieceNul:boolean=false):TExceptLGR_ImportPiece;
   function ImportTrame( ValeursMaitre:TImportTrame; ValeursEsclave:Tlist;AnneeAnterieure:TPieceAnterieure;ValPieceAutoGen:TValPieceAutoGenere;DataSet:TDataSet):TExceptLGR_ImportPiece;
   property VisuPeriode:TPeriode read LitPeriode write EcritPeriode ;
  end;

    function VerificationSiPieceDeDotation(Var Reference:string;DateDeb:Tdate=0;DateFin:Tdate=0):boolean;

//  Function EtatDeVersementExiste(CodeExo:string):TDernierEtatValide;
  Function AffichPieceOuverture:Boolean;
  Function AffichPieceSurPeriode(DateDeb,DateFin:Tdatetime):Boolean;
  Function AffichDetailPieceSurID(id:integer):Boolean;
  Function AffichEntetePieceSurID(id:integer):Boolean;

var
  DMPieces: TDMPieces;
  IDPieceOLD:integer;
implementation

uses DMEcriture,E2_RepriseChargeAPayer2_Isa, E2_Tiers,DMJournaux,
  E2_InfosTrame,DMTier,ModuleTrame, DMTVA, DMPointages2, DMImportation,
  E2_Recherche,
  E2_DetailEcr;
{$R *.DFM}


//Function EtatDeVersementExiste(CodeExo:string):TDernierEtatValide;
//var
//i,RangCourant:integer;
//
//Begin
// if DMPieces = nil then DMPieces:=TDMPieces.Create(Application.MainForm);
// DMPieces.QuEtatDeVersement.Close;
// DMPieces.QuEtatDeVersement.ParamByName('CodeExo').AsString:=CodeExo;
// DMPieces.QuEtatDeVersement.ParamByName('Valeur_Champ_Gener').AsString:=E.ExerciceBase+'V';
// DMPieces.QuEtatDeVersement.open;
// result.Valide:=false;
// result.Nombre:=0;
// result.Nombre:=DMPieces.QuEtatDeVersement.RecordCount;
// case result.Nombre of
//    0:begin
//       result.Valide:=false;
//       result.RangSuivantACreer:=result.Nombre+1;
//       result.CreationSuivantPossible:=true;
//      end;
//    1:begin
//       result.Valide:=not empty(DMPieces.QuEtatDeVersement.FindField('Val_Champ_Gen').AsString);
//       if result.Valide then
//          result.RangSuivantACreer:=result.Nombre+1
//           // Si l'enregistrment est vide, bug des Query
//           else result.RangSuivantACreer:=1;
//       result.CreationSuivantPossible:=true;
//      end;
//    2..4:begin
//           result.Valide:=true;
//           result.RangSuivantACreer:=result.Nombre+1;
//           if result.Nombre = 4 then
//                   result.CreationSuivantPossible:=false;
//         end;
// end;
//// On recupère ici les valeur du dernier état de versement valide
//if result.Valide then
// Begin
//   i:=1;
//   DMPieces.QuEtatDeVersement.First;
//   RangCourant:=strtoint(copy(DMPieces.QuEtatDeVersement.FindField('Champ_Gen').AsString,4,1));
//   result.RangSuivantACreer:=0;
//   result.CreationSuivantPossible:=(RangCourant = i) ;
//   while ((result.CreationSuivantPossible=true) and (not DMPieces.QuEtatDeVersement.EOF)) do
//    Begin
//     result.DatePiece:=DMPieces.QuEtatDeVersement.FindField('Date').AsDateTime;
//     result.Rang:=i;
//     result.Valeur_Champ_Gener:=DMPieces.QuEtatDeVersement.FindField('Val_Champ_Gen').AsString;
//     inc(i);
//     result.RangSuivantACreer:=i;
//     RangCourant:=strtoint(copy(DMPieces.QuEtatDeVersement.FindField('Champ_Gen').AsString,4,1));
//     DMPieces.QuEtatDeVersement.Next;
//     if i < 4 then
//     result.CreationSuivantPossible:=((RangCourant = (i-1)) and (i<=result.Nombre+1))
//     else result.CreationSuivantPossible:=false;
//    End;
//
// End;
//if result.CreationSuivantPossible then
// if result.Valide then result.RangSuivantACreer:=i;
//DMPieces.QuEtatDeVersement.Close;
//
//End;

Function AffichPieceOuverture:Boolean;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
 PeriodeAutre_Tmp:TPeriode;
begin
  Try
    List1:=TStringList.Create;
    if DMPieces = nil then DMPieces:=TDMPieces.Create(Application.MainForm);
    if DMRech = nil then DMRech:=TDMRech.Create(Application.MainForm);
    
//    FiltrageDataSet(DMPieces.TaPieceVisu,'ID < ' + E.ExerciceSaisie + '0000000');
//    List1:=ChampTableVersListeEx(['LibelleJournal','Reference','Compte','Date','Libelle'],DMPieces.TaPieceVisu,';',true);
    FiltrageDataSet(DMRech.TaPieceRech,'ID < ' + E.ExerciceSaisie + '0000000');
    List1:=ChampTableVersListeEx(['Journal','Reference','Compte','Date','Libelle'],DMRech.TaPieceRech,';',true);
    DeFiltrageDataSet(DMRech.TaModelRech);
        for i:=0 to List1.Count-1 do
          list1.Strings[i]:=str_Setstringelement(list1.Strings[i],1,';',Infos_TInfosModel(DMRech.TaModelRech,'id_journal',[str_getstringelement(list1.Strings[i],1,';')]).Journal);

    DeFiltrageDataSet(DMRech.TaPieceRech);
    Initialise_TParamAffichage(ParamAffichage);
    ParamAffichage.AffichModal := true;
    ParamAffichage.EventButtonDetailClick :=DMPieces.VisuList_DetailClick;
    ParamAffichage.EventListViewDbleClick :=DMPieces.VisuList_DetailClick;
    ParamAffichage.Titre:='Liste des pièces à l''ouverture';
    ParamAffichage.GestionAffichForm.Caption := 'Liste des pièces à l''ouverture';
    PeriodeAutre_Tmp:=E.PeriodeAutre;
    E.AutrePeriode:=True;
    E.PeriodeAutre.Retour:=true;
    E.PeriodeAutre.DateDeb := StrToDAte_lgr('01/01/1970');
    E.PeriodeAutre.DateFin := E.DatExoDebut-1;
    DMPieces.VisuPeriode:=E.PeriodeAutre;
    DMPieces.RetourViewListe:=AfficheVisuListView(ParamAffichage,['Journal','Référence','Compte','Date','Libelle'],
                                       [50,50,50,100,200],
                                       [List1],
                                       [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                       [1..3,5],
                                       [0],
                                       [4]);
  Finally
    E.PeriodeAutre:=PeriodeAutre_Tmp;
    E.AutrePeriode:=PeriodeAutre_Tmp.Retour;
    ParamAffichage.EventButtonDetailClick :=nil;
    DeFiltrageDataSet(DMPieces.TaPieceVisu);
    Initialise_TStringlist(list1);
//    List1.Free;
  end;
End;

Procedure TDMPieces.VisuList_DetailClick(Sender : TObject);
var
PeriodeAutre_Tmp:TPeriode;
cpt:string;
listeRetour:Tstringlist;
Begin
try
listeRetour:=VisuListeView.ItemCourantValeurRow;
if (listeRetour=nil)or(listeRetour.count<2) then exit;
e.PeriodeAutreImpression.Retour:=true;
E.PeriodeAutreImpression.DateDeb:=0;
E.PeriodeAutreImpression.DateFin:=e.DatExoFin;
PeriodeAutre_Tmp:=E.PeriodeAutre;
e.AutrePeriode:=true;
E.PeriodeAutre:=E.PeriodeAutreImpression;
DeFiltrageDataSet(DMPieces.TaPieceVisu);
    if DMPieces.TaPieceVisu.Locate('REference',listeRetour.Strings[1],[]) then
     begin
      if DetailEcritureCompte(DMPieces.TaPieceVisuComptePereTiers.AsString,false,false) then
         case DetailEcr.Tag of                                 //
            1:begin
              if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMPieces.TaPieceVisu.FindField('id').AsString,[]) then
                PieceEcritureTiers;
              end;
            2:begin
              if DMEcritures.QueryEcrCompte.Locate('ID_Piece',DMPieces.TaPieceVisu.FindField('id').AsString,[]) then
                PieceEcritureCompte;
              end;
         end;
     end;
Finally
    E.PeriodeAutre:=PeriodeAutre_Tmp;
    E.AutrePeriode:=PeriodeAutre_Tmp.Retour;
end;
End;


procedure TDMPieces.ModificationDatePiece(OD:string;Date:tdatetime);
var
nul:integer; //cette variable ne sert qu'à passer une variable integer dans une procedure
//générale, qui fait appel dans certain cas à une variable integer pour comptabiliser les pointages
//d'une pièce, ici elle ne sert pas
conteneur:TPieceAnterieure;
PieceAnneeAnterieureTmp:TPieceAnterieure;
Begin
try
  try
   if TaPiece.Locate('Reference',OD,[]) then
     BEGIN //si on trouve l'OD
         PieceAnneeAnterieureTmp:=DMPieces.Piece1.AnneePiece;
         conteneur:=DMPieces.Piece1.AnneePiece;
         conteneur.PieceAnterieure:=false;
         DMPieces.Piece1.AnneePiece:=Conteneur;
         FiltrageSurIDPiece(DMEcritures.TaEcriture,TaPiece.findfield('ID').asinteger);
        DMEcritures.TaEcriture.AfterPost:=nil;
        if DMEcritures.TaEcriture.RecordCount<>0 then
        begin //s'il y a des lignes d'écritures
        DMEcritures.TaEcriture.First;
           while not (DMEcritures.TaEcriture.EOF) do
           begin //tant qu'il y a des enregistrements
              try
              DMEcritures.TaEcriture.Edit;
              DMEcritures.TaEcriture.FindField('Date').asdatetime:=date;
              DMEcritures.TaEcriture.FindField('Quand').asdatetime:=now;
              TableGerePost(DMEcritures.TaEcriture);
              except
                begin
                showmessage('L''OD n''a pas pu être modifié !!!');
                abort;
                end;
              end;//fin except
            DMEcritures.TaEcriture.Next;
           end;//fin tant qu'il y a des enregistrements
        DMPieces.TaPiece.Edit;
        DMPieces.TaPiece.FindField('Date').asdatetime:=date;
        DMPieces.TaPiece.FindField('Quand').asdatetime:=now;
        TableGerePost(DMPieces.TaPiece);
        end//fin s'il y a des lignes d'écriture
        else
        begin //S'il n'y a pas de lignes d'écriture
         showmessage('Attention, aucune ecriture n''a été trouvé pour la pièce, problème de mise à jour des ecritures et des pièces !!!');
         abort;
        end;// fin S'il n'y a pas de lignes d'écriture

     end //FIN si on trouve l'OD
     else //si on trouve pas l'OD
     begin
     showmessage('Attention !!!, la piece n''existe pas ');
     abort;
     end;
  except
    tableGereRollBack(TaPiece);
    TableGereRollBack(DMBalance.TaBalance);
    abort;
  end;
finally
DMPieces.Piece1.AnneePiece:=PieceAnneeAnterieureTmp;
DMEcritures.TaEcriture.AfterPost:=DMEcritures.TaEcritureAfterPost;
DMEcritures.TaEcriture.Filter:='';
DMEcritures.TaEcriture.Filtered:=false;
end;//fin du try finally
end;


// PB ---> Voir avec Isa si ok // le 16/08/2002
procedure TDMPieces.AffichageFeuilleReprise(NumButton:integer;Liste1,Liste2:tstringlist;
CaptionFeuille,CaptionBtn1,CaptionBtn2:string;Bouton:boolean);
begin
try//finally
ListeODReprise:=TStringList.Create;
ListeODReprise2:=TStringList.Create;
TaPieceReprise1.OnFilterRecord:=TaPieceRepriseFilterRecord;
TaPieceReprise2.OnFilterRecord:=TaPieceReprise2FilterRecord;
    Try//except
    if not ((((liste1<>nil)and(liste1.count<>0)))or(((liste2<>nil)and(liste2.count<>0))))then abort;
    if (liste2=nil)then
    begin
    //FiltrageSurODPourReprise(Liste1,1);
    ListeODReprise.Assign(Liste1);

    end
    else
    begin
    ListeODReprise.Assign(Liste1);
    //FiltrageSurODPourReprise(Liste1,1);
        if liste2.Count<>0 then
        ListeODReprise2.Assign(Liste2)
    //    FiltrageSurODPourReprise(Liste2,2)
        else
        begin
        liste2.Add('OD0000000');
        ListeODReprise2.Assign(Liste2);
    //    FiltrageSurODPourReprise(Liste2,2);
        end;
    end;
    if RepriseChargeAPayer2_Isa=nil then
       RepriseChargeAPayer2_Isa:=tRepriseChargeAPayer2_Isa.Create(Application.MainForm);
       RepriseChargeAPayer2_Isa.Caption:=CaptionFeuille;
       if NumButton=1
        then RepriseChargeAPayer2_Isa.SBCCA.Down:=true
          else if NumButton=2
            then RepriseChargeAPayer2_Isa.SBPCA.Down:=true;
       RepriseChargeAPayer2_Isa.SBCCA.Visible:=Bouton;
       RepriseChargeAPayer2_Isa.SBCCA.Caption:=CaptionBtn1;
       RepriseChargeAPayer2_Isa.SBPCA.Visible:=Bouton ;
       RepriseChargeAPayer2_Isa.SBPCA.Caption:=CaptionBtn2;

       RepriseChargeAPayer2_Isa.Showmodal;
    except
      //
    end;
finally
Initialise_TStringlist(ListePieceCreees,DMPieces,false);
//if ListePieceCreees<>nil then
//ListePieceCreees.clear;
TaPieceReprise1.OnFilterRecord:=nil;
TaPieceReprise2.OnFilterRecord:=nil;
Initialise_TStringlist(ListeODReprise);
Initialise_TStringlist(ListeODReprise2);

//ListeODReprise.Free;
//ListeODReprise2.Free;
end;//fin du try finally
end;


procedure TDMPieces.ModificationOD(OD,Libelle:string);
var
nul,I:integer;
conteneur:TPieceAnterieure;
PieceAnneeAnterieureTmp:TPieceAnterieure;
begin
try
  try
    if TaPiece.Locate('Reference',OD,[]) then
    BEGIN //si on trouve l'OD
        PieceAnneeAnterieureTmp:=DMPieces.Piece1.AnneePiece;
        conteneur:=DMPieces.Piece1.AnneePiece;
        conteneur.PieceAnterieure:=false;
        DMPieces.Piece1.AnneePiece:=Conteneur;
       FiltrageSurIDPiece(DMEcritures.TaEcriture,TaPiece.findfield('ID').asinteger);
       DMEcritures.TaEcriture.AfterPost:=nil;
       if DMEcritures.TaEcriture.RecordCount<>0 then
       begin //s'il y a des lignes d'écritures
       DMEcritures.TaEcriture.First;
          while not (DMEcritures.TaEcriture.EOF) do
          begin //tant qu'il y a des enregistrements
             try
             DMEcritures.TaEcriture.Edit;
             DMEcritures.TaEcriture.FindField('Libelle').AsString:=Libelle;
             TableGerePost(DMEcritures.TaEcriture);
             except
               begin
               showmessage('L''OD n''a pas pu être modifié !!!');
               abort;
               end;
             end;//fin except
           DMEcritures.TaEcriture.Next;
          end;//fin tant qu'il y a des enregistrements
       DMPieces.TaPiece.Edit;
       DMPieces.TaPiece.FindField('Libelle').asstring:=Libelle;
       TableGerePost(DMPieces.TaPiece);
       end//fin s'il y a des lignes d'écriture
       else
       begin //S'il n'y a pas de lignes d'écriture
        showmessage('Attention, aucune ecriture n''a été trouvé pour la pièce, problème de mise à jour des ecritures et des pièces !!!');
        abort;
       end;// fin S'il n'y a pas de lignes d'écriture
       
    end //FIN si on trouve l'OD
    else //si on trouve pas l'OD
    begin
    showmessage('Attention !!!, la pièce n''existe pas ');
    abort;
    end;
  except
     TableGereRollBack(TaPiece);
     TableGereRollBack(DMBalance.TaBalance);
     abort;
  end;
finally
  DMPieces.Piece1.AnneePiece:=PieceAnneeAnterieureTmp;
  DMEcritures.TaEcriture.Filter:='';
  DMEcritures.TaEcriture.Filtered:=false;
  DMEcritures.TaEcriture.AfterPost:=DMEcritures.TaEcritureAfterPost;
end;//fin du try finally
end;



procedure TDMPieces.SuppressionOD(OD:string);
var
I:integer;
nul:integer;//cette variable ne sert qu'à passer une variable integer dans une procedure
//générale, qui fait appel dans certain cas à une variable integer pour comptabiliser les pointages
//d'une pièce, ici elle ne sert pas
conteneur:TPieceAnterieure;
PieceAnneeAnterieureTmp:TPieceAnterieure;
tab:variant;
Begin
TableGereStartTransaction(TaPiece);
try
     try
       Initialise_Tlist(DMEcritures.listeTvaExigible,DMPieces,false);
       //DMEcritures.listeTvaExigible.Clear;//initialisation avant suppression
       PieceAnneeAnterieureTmp:=DMPieces.Piece1.AnneePiece;
       conteneur:=DMPieces.Piece1.AnneePiece;
       conteneur.PieceAnterieure:=false;
       DMPieces.Piece1.AnneePiece:=Conteneur;
   if TaPiece.Locate('Reference',OD,[]) then
      begin//si od à supprimer trouvée
      FiltrageSurIDPiece(DMEcritures.TaEcriture,TaPiece.findfield('ID').asinteger);
      DMEcritures.TaEcriture.first;
         for I:=1 to DMEcritures.TaEcriture.RecordCount do
         begin
           if ((not empty(DMEcritures.TaEcriture.findfield('TvaCode').asstring))and(DMEcritures.TaEcriture.findfield('typeligne').asstring<>'T'))then
              begin
                new(DMEcritures.TvaExigible);
                DMEcritures.TvaExigible.CompteTva:=RenvoieInfoSurTableDiverse(DMEcritures.TaEcriture.findfield('TvaCode').asstring,DMTVACode.TaTvaCode,'TvaCode',['Compte'],tab);;
                if DMEcritures.TaEcriture.findfield('TvaType').asstring='D'then
                begin
                if DMEcritures.TaEcriture.findfield('TvaDate').asdatetime>=E.PremiereDateDeclaration then
                  DMEcritures.TvaExigible.exigible:=true
                else
                  DMEcritures.TvaExigible.exigible:=false;
                end
                else
                  DMEcritures.TvaExigible.exigible:=true;
                DMEcritures.TvaExigible.IDEcriture:=DMEcritures.TaEcriture.findfield('ID').asinteger;
                DMEcritures.TvaExigible.IDPiece:=DMEcritures.TaEcriture.findfield('ID_Piece').asinteger;
                DMEcritures.TvaExigible.MontantTva:=DMEcritures.TaEcriture.findfield('Montant_Tva').AsCurrency;
                DMEcritures.listeTvaExigible.Add(DMEcritures.TvaExigible);
              end;
           TableGereDelete(DMEcritures.TaEcriture);
         end;//fin du while
      TableGereDelete(TaPiece);
      end//fin si od à supprimer trouvée
   else
       begin
       showmessage('L''OD n''existe pas, problème de mise à jour des pièces');
       abort;
       end;
  except
      begin
      showmessage('Problème à la suppression des OD ');
      TableGereRollBack(TaPiece);
      TableGereRollBack(DMBalance.TaBalance);
      abort;
      end;
  end;//fin du try except
finally
 DMPieces.Piece1.AnneePiece:=PieceAnneeAnterieureTmp;
 DMEcritures.TaEcriture.Filter:='';
 DMEcritures.TaEcriture.Filtered:=false;
end;//fin du try finally
end;


Function TDMPieces.MaxIdPiece(AnneeAnterieure:boolean):Integer;
var
QueryID:TQuery;
ChampID:string;
begin
ChampID:='ID';
QueryID:=tquery.Create(self);
QueryID.DatabaseName:=TaPiece.DatabaseName;
QueryID.SQL.Clear;
if AnneeAnterieure then
 begin
   QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +TaPiece.TableName+'');
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
   QueryID.SQL.Add('Select Max('+ChampID+') as resultat from ' +TaPiece.TableName+'');
   QueryID.SQL.Add(' Where '+ChampID+' between ' +Inttostr((StrToInt_Lgr(E.ExerciceSaisie)*10000000))+' and ' +IntToStr(((StrToInt_Lgr(E.ExerciceSaisie)+1)*10000000))+'''');
//   QueryID.SQL.Add(' Where '+ChampID+'>= ' +IntToStr((StrToInt_Lgr(E.ExerciceSaisie)*10000000))+'''');
   QueryID.Open;
   result:=0;
   if QueryID.FindField('resultat').Asinteger = 0 then
   result:=(StrToInt_Lgr(E.ExerciceSaisie)*10000000)+1
   else
   result:=QueryID.FindField('resultat').Asinteger+1;
 end;
QueryID.close;
QueryID.Free;
QueryID:=nil;
end;

function TDMPieces.EnvoiePieceEcriture_SurListe(Liste:Tlist;Ecriture:TEcriture_Isa;Debit,Credit:currency;Reglement:boolean;Etat:TDataSetState;VerifRef:boolean):TExceptLGR_ImportPiece;
var
IDPiece,IDEcriture:integer;
ErreurListe:TerreurListe;
ExceptLGR:TExceptLGR;
DebutMess,FinMess:string;
Begin
   try
Initialise_ExceptLGR(ExceptLGR,GestMessageLGR);
//ExceptLGR.GestMessageLGR:=GestMessageLGR;
ExceptLGR.NomModule:='EnvoiePieceEcriture_SurListe';
      TableGereStartTransaction(TaPiece);
      if VerifReference(ecriture.Piece.Reference,ecriture.Piece,false).Retour=false then
        Begin

        DebutMess:='La référence "'+ecriture.Piece.Reference+'" n''est plus valide, elle va être automatiquement remplacée par la référence "';
          if ecriture.Piece.AnneePiece.PieceAnterieure then
            ecriture.Piece.Reference:=ecriture.Piece.NewReference(ecriture.Piece.TablePiece,'Reference',ecriture.Piece.journal,ecriture.Piece.AnneePiece.ExoAnterieure,ecriture.Piece.Reference)
          else
            ecriture.Piece.Reference:=ecriture.Piece.NewReference(ecriture.Piece.TablePiece,'Reference',ecriture.Piece.journal,ecriture.Piece.CodeExo,ecriture.Piece.Reference);
           FinMess:=ecriture.Piece.Reference+'"';
            if(ecriture.piece.IDJournal<>3 ) and (ecriture.piece.IDJournal<>4 ) then showmessage(DebutMess+FinMess);
       End;

      Initialise_Tlist(DMEcritures.listeTvaExigible,DMPieces,false);
//      DMEcritures.listeTvaExigible.Clear;//initialisation avant envoie des écritures
      if Ecriture.Piece.LastIDPiece=0 then
        Ecriture.Piece.FirstIDPiece:=Ecriture.Piece.NewIDPiece(tapiece,'ID',true)
      else
        begin
            if VerifIDPiece(Ecriture.Piece.LastIDPiece,Ecriture.Piece,true).retour then
              Ecriture.Piece.FirstIDPiece:=Ecriture.Piece.LastIDPiece
            else
              Ecriture.Piece.FirstIDPiece:=Ecriture.Piece.NewIDPiece(tapiece,'ID',true)
        end;
      if not reglement then
      DMEcritures.BatchMove_Liste_SurTaEcriture(liste,ecriture)
      else
      DMEcritures.CreationEcritures(Ecriture,'','','',0,0,credit,debit,credit,debit,e.Devise,0,0);
      //Après écriture dans la vraie table, vérifie que toute la liste y figure bien
      if liste<>nil then
        begin
        ExceptLGR:=ecriture.Verif_Liste_Table_Entiere(liste,DMEcritures.TaEcriture);
//        if Result.Erreur.Retour=false then
//          abort;
        end;
            if VerifReference(ecriture.Piece.Reference,ecriture.Piece,false).Retour=false then
        Begin
          showmessage('La référence n''est plus valide, elle va être automatiquement remplacée !!!');
          if ecriture.Piece.AnneePiece.PieceAnterieure then
            ecriture.Piece.Reference:=ecriture.Piece.NewReference(ecriture.Piece.TablePiece,'Reference',ecriture.Piece.journal,ecriture.Piece.AnneePiece.ExoAnterieure,ecriture.Piece.Reference)
          else
            ecriture.Piece.Reference:=ecriture.Piece.NewReference(ecriture.Piece.TablePiece,'Reference',ecriture.Piece.journal,ecriture.Piece.CodeExo,ecriture.Piece.Reference);
        End;
      if ((reglement)and(ecriture.Piece.IDJournal=3)) then
          CreationPiece(ecriture.Piece.FirstIDPiece,ecriture.Piece.IDJournal,0,e.Devise,ecriture.Piece.reference,
          ecriture.Piece.Libelle,'',e.NomUtilisateur,ecriture.Piece.ValPieceAutoGen.Table_Gen,ecriture.Piece.ValPieceAutoGen.Champ_Gen,ecriture.Piece.ValPieceAutoGen.Val_Champ_Gen,'','',ecriture.piece.DateSaisie,ecriture.piece.DateLivraison,ecriture.piece.DateEcheance,now,ecriture.Piece.ValPieceAutoGen.TableGen,0)
      else
      //*** si on veut enregistrer la dateEcheance, il faut modifier ces 2 lignes en plaçant la variable
      //ecriture.Piece.DateEcheance à l'endroit correspondant dans la table pièce quand le champ sera créé { isa  le  06/05/04 }
      CreationPiece(ecriture.Piece.FirstIDPiece,ecriture.Piece.IDJournal,0,e.Devise,ecriture.Piece.reference,
      ecriture.Piece.Libelle,ecriture.Piece.compte,e.NomUtilisateur,ecriture.Piece.ValPieceAutoGen.Table_Gen,ecriture.Piece.ValPieceAutoGen.Champ_Gen,ecriture.Piece.ValPieceAutoGen.Val_Champ_Gen,'','',ecriture.piece.DateSaisie,ecriture.piece.DateLivraison,ecriture.piece.DateEcheance,now,ecriture.Piece.ValPieceAutoGen.TableGen,0);
       if e.TypeClient=cl_isa then
         AffichDetailPieceSurID(Ecriture.Piece.FirstIDPiece);

//      Piece.IDContrepartie:=ecriture.Piece.FirstIDPiece;
      except
      TableGereRollBack(TaPiece);
      TableGereRollBack(DMBalance.TaBalance);
      showmessage('Problème à l''enregistrement de la pièce !!!');
      result.Erreur:=ExceptLGR;
      abort;
      end;//fin du try
End;


procedure TDMPieces.DMPiecesCreate(Sender: TObject);
begin
ListeCptExclusEnTete:=TStringList.Create;// isa le 06/02/03
ListeCptExclusCorps:=TStringList.Create;// isa le 06/02/03
ListePieceCreees:=TStringList.Create;{ isa  le  27/10/03 }
ListePieceCreees.add('1');
ListePieceCreees.clear;
OuvrirTouteTable('',TControl(self));
if DMJournal=nil then DMJournal:=TDMJournal.create(application.Mainform);
if DMTVACode=nil then DMTVACode:=TDMTVACode.create(application.Mainform);
if DMPointage2=nil then DMPointage2:=TDMPointage2.Create(Application.MainForm);

end;

procedure TDMPieces.DMPiecesDestroy(Sender: TObject);
begin
Initialise_TStringlist(ListeCptExclusEnTete);{ isa  le  20/08/04 }
//if ListeCptExclusEnTete<>nil then
//begin
//ListeCptExclusEnTete.Free;// isa le 06/02/03
//ListeCptExclusEnTete:=nil;
//end;
Initialise_TStringlist(ListeCptExclusCorps);{ isa  le  20/08/04 }
//if ListeCptExclusCorps<>nil then
//begin
//ListeCptExclusCorps.Free;// isa le 06/02/03
//ListeCptExclusCorps:=nil;
//end;
Initialise_TStringlist(ListePieceCreees);{ isa  le  20/08/04 }
//if ListePieceCreees<>nil then
//Begin
//ListePieceCreees.free;
//ListePieceCreees:=nil;
//End;
if DMPlan<>nil then
  DMPlan.TaCompte.OnFilterRecord:=DMPlan.TaCompteFilterRecord;

FermerTouteTable('',TControl(self));
DMPieces:=nil;
end;


procedure TDMPieces.CreationPiece(ID,Journal,TypePiece,ID_Devise:integer;Ref,Lib,Compte,Qui,Table_Gen,Champ_Gen,Val_Champ_Gen,NumCheque,CodeGestco:string;Date,Validation,Echeance:Tdate;Quand:Tdatetime;TableGen:boolean;IDGestco:integer);
Begin
   try
   TableGereInsert(TaPiece);
     TaPiece.FindField('ID').AsInteger:=ID;
     TaPiece.FindField('Journal').AsInteger:=Journal;
     TaPiece.FindField('Reference').AsString:=Ref;
     TaPiece.FindField('Date').AsDateTime:=Date;
     TaPiece.FindField('Libelle').AsString:=Lib;
     TaPiece.FindField('TypePiece').AsInteger:=TypePiece;
     TaPiece.FindField('Compte').AsString:=Compte;
     TaPiece.FindField('ID_Devise').AsInteger:=ID_Devise;
     TaPiece.FindField('Validation').AsDateTime:=validation;
     TaPiece.FindField('Echeance').AsDateTime:=Echeance;
     TaPiece.FindField('Qui').AsString:=Qui;
     TaPiece.FindField('Quand').AsDateTime:=Quand;
     TaPiece.FindField('Num_Cheque').AsString:=NumCheque;
     TaPiece.FindField('ID_GESTCO').AsFloat:=IDGestco;
     TaPiece.FindField('CODE_GESTCO').AsString:=CodeGestco;
     TaPiece.FindField('Table_Gen').AsString:=Table_Gen;
     TaPiece.FindField('Champ_Gen').AsString:=Champ_Gen;
     TaPiece.FindField('Val_Champ_Gen').AsString:=Val_Champ_Gen;
   //TaPiece.AppendRecord([ID,Journal,Ref,Date,Lib,TypePiece,Compte,ID_Devise,validation,Qui,Quand,NumCheque,IDGestco,CodeGestco,Table_Gen,Champ_Gen,Val_Champ_Gen,Echeance]);
   TableGerePost(TaPiece);
   TaPiece.FlushBuffers;
   except
   TableGereRollBack(TaPiece);
   TableGereRollBack(DMBalance.TaBalance);
   showmessage('Problème à la création de la pièce !!!');
   abort;
   end;//fin du try
End;

function TDMPieces.VerifIDPiece(ID:integer;Piece:tPiece;Suppr:boolean):TErreurSaisie;
begin
  try
  if not TaPieceVerif.Active then
    TaPieceVerif.open;
  result.Retour:=true;
  result.CodeErreur:=0;
     try
       result.Retour:=not(TaPieceVerif.Locate('ID',ID,[]));
       if not result.Retour then
          Begin
          result.Retour:=false;
          result.CodeErreur:=2002;
          End
       else
         if ((result.Retour)and(not Suppr)) then
         result.Retour:=piece.NewIDPiece(tapiece,'ID',not Piece.AnneePiece.PieceAnterieure)=ID;
       if not result.Retour then
         result.CodeErreur:=1001;
     except
     result.CodeErreur:=1002;
     abort;
     end;//fin du try
  finally
  TaPieceVerif.close;
  end;
End;

//vérifie si la référence  de l'objet piece est correcte, sinon on recupère une nouvelle valide
function TDMPieces.VerifReference(Ref:string;Piece:tPiece;Suppr:boolean):TErreurSaisie;
var
TableTemp:TTable;
conteneur:string;
begin
  try
  if not TaPieceVerif.Active then
    TaPieceVerif.open;
    result.Retour:=true;
    result.CodeErreur:=0;
       try
       if piece.EtatPiece=dsedit then
         Begin
           //
         End
       else
         result.Retour:=not (TaPieceVerif.Locate('Reference',ref,[]));
         if not result.Retour then
           Begin
           result.CodeErreur:=2002;
           End
         else
           if ((result.Retour)and(not Suppr)) then
             Begin
              if Piece.AnneePiece.PieceAnterieure then
                conteneur:=piece.NewReference(tapiece,'Reference',piece.Journal,Piece.AnneePiece.ExoAnterieure,ref)
              else
                conteneur:=piece.NewReference(tapiece,'Reference',piece.Journal,Piece.CodeExo,ref);
             result.Retour:=conteneur=ref;
             End;
         if not result.Retour then
           result.CodeErreur:=2001;
       except
       result.CodeErreur:=2002;
       abort;
       end;//fin du try
  finally
    TaPieceVerif.close;
  end;//fin du try finally
End;

function TDMPieces.SuppressionPieceEcriture(Ref:string;Piece:Tobject):string;
var
I,IDEcritureTmp,IDPieceTmp:integer;
Req:Tquery;
TableTempPiece,TableTempEcriture:TTable;
ListeTmp:TStringList;
TabIDSupprime:array [0..2]of integer;
tab:variant;
begin
ListeTmp:=TStringList.Create;
Initialise_TList(DMEcritures.listeTvaExigible,DMPieces,false);
//DMEcritures.listeTvaExigible.Clear;//initialisation avant suppression
TabIDSupprime[0]:=-1;
TabIDSupprime[1]:=-1;
TabIDSupprime[2]:=-1;
//initialise table piece temporaire
//TableTempPiece:=TTable.create(self);
//TableTempPiece.databaseName:=TaPiece.DatabaseName;
//TableTempPiece.TableName:=TaPiece.TableName;
TaPiece_Obj.open;
//initialise table Ecriture temporaire
//TableTempEcriture:=TTable.create(self);
//TableTempEcriture.databaseName:=DMEcritures.TaEcriture.DatabaseName;
//TableTempEcriture.TableName:=DMEcritures.TaEcriture.TableName;
dmecritures.TaEcriture_Obj.open;
//initialise Query pointage temporaire
Req:=TQuery.Create(self);
req.DatabaseName:=DMPointage2.TaPointage.DatabaseName;
req.sql.Clear;

result:='';
IDEcritureTmp:=0;
IDPieceTmp:=0;
   try
   dmecritures.TaEcriture_Obj.BeforeDelete:=DMEcritures.TaEcritureBeforeDelete;
   dmecritures.TaEcriture_Obj.AfterDelete:=DMEcritures.TaEcritureAfterDelete;
   
   TaPiece_Obj.beforeDelete:=DMPieces.TaPieceBeforeDelete;
   TaPiece_Obj.AfterDelete:=DMPieces.TaPieceAfterDelete;
     try
        if TaPiece_Obj.Locate('Reference',Ref,[]) then
         begin //si on localise la piece portant cette référence
         req.SQL.Clear;
         req.SQL.Add('select Pointage.id from piece,Ecriture,pointage');
         req.SQL.Add('where ((piece.ID=ecriture.ID_Piece) and (piece.reference='''+ref+''')');
         req.SQL.Add('and((ecriture.id=pointage.ID_Debit) or (ecriture.id=Pointage.ID_Credit)))');
         req.Open;

           if (piece is TPiece)then
             begin //si c'est un object TPiece
                 with (piece as TPiece)do
                  if req.RecordCount<>0 then
                    begin//on filtre la requete puis on la passe dans la procédure de suppression
                    ListeTmp.AddObject('',piece);
                    DMPointage2.SupprimePointageSurEcriture(req,ListeTmp,0);
                    end;
              end //fin si c'est un object TPiece
            else
            if (piece is TReglementList)then
              Begin //si c'est un object TObjReglement
                 with (piece as TReglementList) do
                  if req.RecordCount<>0 then
                   begin//on filtre la requete puis on la passe dans la procédure de suppression
                   ListeTmp.AddObject('',piece);
                   DMPointage2.SupprimePointageSurEcriture(req,ListeTmp,0);
                   end;
              End;//fin si c'est un object TObjReglement
         FiltrageSurIDPiece(dmecritures.TaEcriture_Obj,TaPiece_Obj.findfield('ID').asinteger);
         if dmecritures.TaEcriture_Obj.recordcount>0 then
         begin
         dmecritures.TaEcriture_Obj.first;
         while not(dmecritures.TaEcriture_Obj.eof) do
            begin
              if ((not empty(dmecritures.TaEcriture_Obj.findfield('TvaCode').asstring))and( dmecritures.TaEcriture_Obj.findfield('TypeLigne').asstring<>'T'))then
                 begin
                 new(DMEcritures.TvaExigible);
                 DMEcritures.TvaExigible.CompteTva:=RenvoieInfoSurTableDiverse(dmecritures.TaEcriture_Obj.findfield('TvaCode').asstring,DMTVACode.TaTvaCode,'TvaCode',['Compte'],tab);;
                 if  dmecritures.TaEcriture_Obj.findfield('TvaType').asstring='D'then
                 begin
                 if dmecritures.TaEcriture_Obj.findfield('TvaDate').asdatetime>=E.PremiereDateDeclaration then
                   DMEcritures.TvaExigible.exigible:=true
                 else
                   DMEcritures.TvaExigible.exigible:=false;
                 end
                 else
                   DMEcritures.TvaExigible.exigible:=true;
                 DMEcritures.TvaExigible.IDEcriture:=dmecritures.TaEcriture_Obj.findfield('ID').asinteger;
                 DMEcritures.TvaExigible.IDPiece:=dmecritures.TaEcriture_Obj.findfield('ID_Piece').asinteger;
                 if dmecritures.TaEcriture_Obj.findfield('DebitSaisie').AsCurrency<>0 then
                   DMEcritures.TvaExigible.MontantTva:=-dmecritures.TaEcriture_Obj.findfield('Montant_Tva').AsCurrency
                 else
                   DMEcritures.TvaExigible.MontantTva:=dmecritures.TaEcriture_Obj.findfield('Montant_Tva').AsCurrency;
                 DMEcritures.listeTvaExigible.Add(DMEcritures.TvaExigible);
                 end;

            TableGereDelete(dmecritures.TaEcriture_Obj);
            dmecritures.TaEcriture_Obj.first;
            end;
         end;
         //GereSuppressionPiece_Import(TaPiece_Obj.findfield('ID').asinteger);
         TableGereDelete(TaPiece_Obj);
         result:=Ref;
         end;//fin si on localise la piece portant cette référence
     except
         showmessage('Problème à la suppression des OD ');
         TableGereRollBack(TaPiece_Obj);
         TableGereRollBack(DMBalance.TaBalance);
         abort;
     end;//fin du try except
   finally
   DMEcritures.TaEcriture.Filter:='';
   DMEcritures.TaEcriture.Filtered:=false;
   TaPiece_Obj.Close;
Req.Free;
Req:=nil;
//   TableTempPiece.free;
//   TableTempPiece:=nil;
   dmecritures.TaEcriture_Obj.Close;
//   TableTempEcriture.free;
//   TableTempEcriture:=nil;
   Initialise_TStringlist(ListeTmp);
//   ListeTmp.Free;
   end;//fin du try finally
End;


function TDMPieces.RecupPieceExistante(Ref:string):TRecordPiece;
Begin
result.Retour:=false;
   try
   if not TaPieceVerif.active then
   TaPieceVerif.Open;
      if TaPieceVerif.Locate('Reference',Ref,[]) then
      begin
      result.ID:=TaPieceVerif.findfield('ID').asinteger;
      result.idJournal:=TaPieceVerif.findfield('Journal').asinteger;
      result.Reference:= TaPieceVerif.findfield('Reference').asstring;
      result.journal:=copy(result.Reference,1,2);
      result.Date:=TaPieceVerif.findfield('Date').AsDateTime;
      result.Validation:=TaPieceVerif.findfield('Validation').AsDateTime;
      result.Quand:=TaPieceVerif.findfield('Quand').AsDateTime;
      //result.Echeance:=TaPieceVerif.findfield('Date').asstring;//en attend d'y
      result.Echeance:=TaPieceVerif.findfield('Echeance').asstring;//mettre le bon champ quand il sera crée
      result.Libelle:=TaPieceVerif.findfield('Libelle').asstring;
      result.Compte:=TaPieceVerif.findfield('Compte').asstring;
      result.AutoGeneree:=not empty(TaPieceVerif.findfield('Table_Gen').asstring);
      result.Table_Gen:=TaPieceVerif.findfield('Table_Gen').asstring;
      result.Champ_Gen:=TaPieceVerif.findfield('Champ_Gen').asstring;
      result.Val_Champ_Gen:=TaPieceVerif.findfield('Val_Champ_Gen').asstring;
      result.Retour:=true;
      end;
   finally
   TaPieceVerif.close;
   end;
End;

procedure TDMPieces.TaPieceReprise1BeforeInsert(DataSet: TDataSet);
begin
abort;
end;

//Philippe Bilan Ouverture Tiers

Function TDMPieces.PieceBOTiersExiste(Compte:string):TRecordPiece;
begin
QueryPieceBOTiers.Close;
QueryPieceBOTiers.ParamByName('Cpt').AsString:=Compte;
QueryPieceBOTiers.Open;
result.retour:=(QueryPieceBOTiers.RecordCount > 0);
result.ID:=QueryPieceBOTiers.findField('ID').AsInteger;
end;

Function TDMPieces.IDPieceBOTiers:integer;
begin
 try
  QueryMinIDPiece.Close;
  QueryMinIDPiece.Open;
  Result:=QueryMinIDPieceMINOFID.AsInteger;
  if Result>=0 then result:=-1
  else result:=result-1;
 except

 end;
end;

Function TDMPieces.SuppressionPiece(IDPiece:integer):boolean;
begin
try
  result:=TaPiece.Locate('ID',IntToStr(IDPiece),[]);
  if result
     then
      begin
        TableGereDelete(TaPiece);
      end;
except
  TableGereRollBack(TaPiece);
  TableGereRollBack(DMBalance.TaBalance);
end;

end;

procedure TDMPieces.FiltrageSurIDPiece(Ecriture:TTable;IDPiece:integer);
var
sens:boolean;
begin
   Ecriture.Filtered:=false;
   Ecriture.filter:=('ID_Piece = '''+inttostr(IDPiece)+'''');
   Ecriture.Filtered:=true;
   Ecriture.First;
end;



function TDMPieces.RecupIDEcritureTiersSurRef(Ref:string;var IDEcritureTmp:integer):boolean;
var
TableTemp:TTable;
IDPieceTmp:integer;
begin
  try
     try
        result:=true;
        if not TaPieceVerif.active then
        TaPieceVerif.Open;
          if TaPieceVerif.locate('Reference',ref,[])then
           IDPieceTmp:=TaPieceVerif.findfield('ID').asinteger;
        if not DMEcritures.TaEcritureRecup.active then
        DMEcritures.TaEcritureRecup.open;
        DMEcritures.TaEcritureRecup.filter:=('ID_Piece = '''+inttostr(IDPieceTmp)+'''');
        DMEcritures.TaEcritureRecup.Filtered:=true;
     except
     result:=false;
     abort;
     end;//fin du try except
  finally
  TaPieceVerif.close;
  DMEcritures.TaEcritureRecup.close;
  end;
end;

function TDMPieces.RechercheIDPieceExistant(ID_Old:integer):boolean;
var
TableTemp:TTable;
Begin
result:=false;
   try
      try
      TableTemp:=Ttable.Create(self);
      TableTemp.DatabaseName:=TaPiece.DatabaseName;
      tabletemp.TableName:=TaPiece.TableName;
      tabletemp.open;
      if tabletemp.Locate('ID',ID_Old,[])then
        result:=true;
      except
        showmessage('Problème lors de la vérification de l"Identifiant d"une pièce existante');
        abort;
      end;//fin du try except
   finally
   tableTemp.Free;
   end;//fin du try finally
End;

procedure TDMPieces.Piece1NewPiece(Sender: TObject);
var
conteneurVerrou:TVerrouillage;
begin
{Nettoyage :libère les éléments de la liste ainsi que la liste }
Initialise_TList(DMEcritures.Ecriture_Isa1.ListIdentifiant,DMPieces,false);
Initialise_TList(DMEcritures.Ecriture_Isa1.ListeContrepartie,DMPieces,false);
Initialise_TList(DMEcritures.Ecriture_Isa1.ListeEcriturePiece,DMPieces,false);
//DMEcritures.Ecriture_Isa1.ListIdentifiant.Clear;
Piece1.InitialiseInfosVerrouillage(conteneurVerrou);
Piece1.InfosVerrouillage:=conteneurVerrou;

DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],true,false,-1);
DMEcritures.Ecriture_Isa1.FirstIDEcriture:=0;
DMEcritures.Ecriture_Isa1.NextIDEcriture:=0;
DMEcritures.Ecriture_Isa1.DispatcherTva:=false;

case e.TypeDossier of
  VerAgricole:begin
               //si la tva doit être gérée
               piece1.TVA_A_Gerer:=true;
              end;
  VerDiocese:begin
               //si la tva doit être gérée
               piece1.TVA_A_Gerer:=false;
              end;
end;//fin du case typeversion
//Piece_Import.FiltrageTablePieceSurPieceAnterieure(Piece_Import.AnneePiece.PieceAnterieure);
if Piece1.AnneePiece.PieceAnterieure then
 begin
   Piece1.DateDebutExo:=StrToDate('01/01/1899');
   Piece1.DateFinExo:=E.DatExoDebut-1;
   Piece1.CodeExo:=E.ExerciceSaisie;
   end
 else
  begin
   Piece1.DateDebutExo:=E.DatExoDebut;
   Piece1.DateFinExo:=E.DatExoFin;
   Piece1.CodeExo:=E.ExerciceSaisie;
  end;
//DateConfirmee:=false;
end;

procedure TDMPieces.TaPiecePostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;


function VerificationSiPieceDeDotation(Var Reference:string;DateDeb:Tdate;DateFin:Tdate):boolean;
var
TableTemp:Ttable;
mess:TMessageLGR;
Begin
//Vérifier si la pièce de dotation existe déjà, si oui récupérer sa référence pour
//pouvoir la supprimer
//faire un fitre sur la table pièce
if DateDeb=0 then DateDeb:=e.DatExoDebut;
if DateFin=0 then DateFin:=e.DatExoFin;

if DMPieces=nil then DMPieces:=TDMPieces.Create(application.MainForm);
result:=false;
FiltrageDataSet(DMPieces.TaPieceConsultation,'Table_Gen = ''Immos.db''');
DMPieces.TaPieceConsultation.First;
while ((not DMPieces.TaPieceConsultation.Eof)and(not result)) do
  Begin
  if DateDsIntervale(DateDeb,DMPieces.TaPieceConsultation.findfield('date').AsDateTime,DateFin,mess) then
    Reference:=DMPieces.TaPieceConsultation.findfield('Reference').asstring
  else
    Reference:='';
    result:=not empty(reference);
    DMPieces.TaPieceConsultation.next;
  end;
DeFiltrageDataSet(DMPieces.TaPieceConsultation);  
End;

procedure TDMPieces.TaPieceRepriseFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if ((not((csDestroying)in dataset.ComponentState))and(ListeODReprise<>nil)) then
Begin//si
accept:=ListeODReprise.IndexOf(DataSet.findfield('Reference').AsString) <> -1;
end;
end;

procedure TDMPieces.TaPieceReprise2FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if ((not((csDestroying)in dataset.ComponentState))and(ListeODReprise2<>nil)) then
Begin//si
accept:=ListeODReprise2.IndexOf(DataSet.findfield('Reference').AsString) <> -1;
end;
end;

procedure TDMPieces.TaPieceVisuBeforeOpen(DataSet: TDataSet);
begin
if DMJournal = nil then  DMJournal:=TDMJournal.Create(application.MainForm); 
end;

procedure TDMPieces.TaPieceDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMPieces.GestionFiltrageParamCpt(journal:integer);
var
ListeCpt:TStringList;
begin
   try
   ListeCpt:=TStringList.Create;
   if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);

if journal=-1 then journal:=DMPieces.Piece1.IDJournal;

   if Journal in [1,2] then
     Begin//si OP entête
       ListeCptExclusEnTete.Clear;// PB
       ListeCptExclusEnTete:=DMPlan.ListeCompteExclusEnteteEtPiece(23,e.Regime);// PB
       DMPlan.TaCompte.OnFilterRecord:=TaCompteFilterRecordEnTete;// PB
       ListeCpt:=DMPlan.FiltrageParamCPT(24,e.Regime);
     end
   else
     if Journal in [3] then
       //si OD entête
       ListeCpt:=DMPlan.FiltrageParamCPT(28,e.Regime)
   else
     if Journal in [4] then
       //si OD entête
       ListeCpt:=DMPlan.FiltrageParamCPT(101,e.Regime);

   AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
//   aidecompte.InitialiseCompte;
   finally
   Initialise_TStringlist(listeCpt);
//   DMPlan.TaCompte.OnFilterRecord:=nil;
   end;//fin du try finally
End;




procedure TDMPieces.GestionFiltrageParamCptSurCompte(Compte:string;Journal:integer);
var
ListeCpt:TStringList;
begin
   try
   ListeCptExclusCorps.Clear;
   ListeCpt:=TStringList.Create;
   if DMPlan=nil then DMPlan:=TDMPlan.Create(Application.MainForm);
      DMPlan.TaCompte.OnFilterRecord:=DMPlan.TaCompteFilterRecord;// PB

if journal=-1 then journal:=DMPieces.Piece1.IDJournal;

   if Journal in [1,2] then //achat, vente
     begin
//   ListeCpt:=DMPlan.FiltrageParamCPTSurCompte(24,compte,e.Regime);
   Initialise_TStringlist(ListeCptExclusCorps,DMPieces,false);
//   ListeCptExclusCorps.Clear;// PB
   ListeCptExclusCorps.Assign(DMPlan.ListeCompteExclusEnteteEtPiece(26,e.Regime));// { isa  le  24/08/04 }
   ListeCptExclusCorps.Add(compte);
   DMPlan.TaCompte.OnFilterRecord:=TaCompteFilterRecordCorps;// PB

   ListeCpt:=DMPlan.FiltrageParamCPT(25,e.Regime);
   end;
   if Journal in [3] then  //OD
//   ListeCpt:=DMPlan.FiltrageParamCPT(26,e.Regime);
   ListeCpt:=DMPlan.FiltrageParamCPT(28,e.Regime);
   if Journal in [4] then //banque
//   ListeCpt:=DMPlan.FiltrageParamCPT(24,e.Regime);
   ListeCpt:=DMPlan.FiltrageParamCPT(27,e.Regime);
   
   AideCompteFiltreTaCompte(CreeFiltreOU('Compte',[ListeCpt]),true);
//   aidecompte.InitialiseCompte;
   finally
        Initialise_TStringlist(listeCpt);
   end;//fin du try finally
End;



procedure TDMPieces.TaCompteFilterRecordEnTete(DataSet: TDataSet;
  var Accept: Boolean); //PB
begin
//try
if not((csDestroying)in dataset.ComponentState) then
  begin
  if ListeCptExclusEnTete<>nil then
    begin
    if DataSet = DMPlan.TaCompte then
      begin
      accept:=ListeCptExclusEnTete.IndexOf(copy(DataSet['Compte'],1,3)) = -1;
      if accept then
            accept:=ListeCptExclusEnTete.IndexOf(copy(DataSet['Compte'],1,3)+'*') = -1;
      if accept then
    //    if length(DataSet['Compte'])>2 then
          accept:=((DataSet.FindField('Pointable').AsBoolean) and not (DataSet.FindField('collectif').AsBoolean) and ((length(DataSet.FindField('Compte').AsString) > 2)));
//          accept:=((DataSet['Pointable']) and not (DataSet['collectif']) and ((length(DataSet.FindField('Compte').AsString) > 2)));
          if ((accept) and (ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
             accept:=DataSet.FindField('PlanSaisie').asBoolean;
      end;
    if Recherche <> nil then
     begin
       if DataSet = Recherche.RxQueryRec then
         begin
         accept:=ListeCptExclusEnTete.IndexOf(copy(DataSet['Compte'],1,3)) = -1;
         if accept then
               accept:=ListeCptExclusEnTete.IndexOf(copy(DataSet['Compte'],1,3)+'*') = -1;
         if accept then
       //    if length(DataSet['Compte'])>2 then
//             accept:=((DataSet['Pointable']) and not (DataSet['collectif']) and ((length(DataSet.FindField('Compte').AsString) > 2)));
             accept:=((DataSet.FindField('Pointable').AsBoolean) and not (DataSet.FindField('collectif').AsBoolean) and ((length(DataSet.FindField('Compte').AsString) > 2)));
          if ((accept) and (ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
             accept:=DataSet.FindField('PlanSaisie').asBoolean;
         end;
     end;
    end;
  end;
//except
//accept:=false;
//end;
end;

procedure TDMPieces.TaCompteFilterRecordCorps(DataSet: TDataSet;
  var Accept: Boolean); //PB
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
  if ListeCptExclusCorps<>nil then
    begin
    if (DataSet = DMPlan.TaCompte) then
      begin
       try
          accept:=ListeCptExclusCorps.IndexOf(copy(DataSet.FindField('Compte').AsString,1,3)) = -1;
          if accept then
                accept:=ListeCptExclusCorps.IndexOf(copy(DataSet.FindField('Compte').AsString,1,3)+'*') = -1;
          if accept then
      //      if length(DataSet['Compte'])>2 then
              accept:=((DataSet.FindField('Compte').AsString <> DMPieces.Piece1.Compte) and ((length(DataSet.FindField('Compte').AsString) > 2)));
          if ((accept) and (ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
             accept:=DataSet.FindField('PlanSaisie').asBoolean;
       except
        accept:=false;
       end;
      end;
    if Recherche <> nil then
     begin
       if DataSet = Recherche.RxQueryRec then
         begin
             accept:=ListeCptExclusCorps.IndexOf(copy(DataSet.FindField('Compte').AsString,1,3)) = -1;
             if accept then
                   accept:=ListeCptExclusCorps.IndexOf(copy(DataSet.FindField('Compte').AsString,1,3)+'*') = -1;
             if accept then
         //      if length(DataSet['Compte'])>2 then
                 accept:=((DataSet.FindField('Compte').AsString <> DMPieces.Piece1.Compte) and ((length(DataSet.FindField('Compte').AsString) > 2)));
            if ((accept) and (ParamUtil.PlanDeSaisie = true) and (DMPLan.AideCompteVisible = true)) then
               accept:=DataSet.FindField('PlanSaisie').asBoolean;
         end;
     end;
    end;
  end;
end;

Function TDMPieces.CptExclusDeContexte(Compte:String;IndexContexte:Integer):Boolean;
var
partieCompte:string;
Begin  // PB
if(str_commence_par(compte,'+'))then partieCompte:=compte else partieCompte:=copy(Compte,1,3);
  case IndexContexte of
     1:Begin // Result = vrai si le compte est ds la liste ( En-Tête de la Pièce )
        result:=((ListeCptExclusEnTete.IndexOf(partieCompte) <> -1)or (ListeCptExclusEnTete.IndexOf(Compte) <> -1));
        if result then showmessage('Le Compte : ' + Compte + ' n''est pas utilisable dans ce contexte !');
      End;

     2:Begin // Result = vrai si le compte est ds la liste ( Corps de la Pièce )
        result:=((ListeCptExclusCorps.IndexOf(partieCompte) <> -1)or(ListeCptExclusCorps.IndexOf(Compte) <> -1));
        if not result then result:= Compte = DMPieces.Piece1.Compte;
        if result then showmessage('Le Compte : ' + Compte + ' n''est pas utilisable dans ce contexte !');
      End;
  end;//fin du case
end;


function TDMPieces.ImportPiece(ValeursMaitre:TRecordPiece;ValeursEsclave:Tlist;ValeursPointage:Tlist;AnneeAnterieure:TPieceAnterieure;
ValPieceAutoGen:TValPieceAutoGenere;DataSet:TDataSet;AcceptPieceNul:boolean):TExceptLGR_ImportPiece;
var
listeFactice:Tlist;
i:integer;
Begin
  try
     try
       listeFactice:=nil;
       initialise_TExceptLGR_ImportPiece(result);
       GestMessageLGR.ModeTrace:=true;
Initialise_ExceptLGR(result.Erreur,GestMessageLGR);
//       result.Erreur.GestMessageLGR:=GestMessageLGR;
       result.Erreur.NomModule:='ImportPiece';
       result.Erreur.GestMessageLGR.Enregistrement:=true;
       result.Erreur.NomDossier:=e.NomDossier;
       
       DMImport.AnneeAnterieure:=AnneeAnterieure;
       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;

       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       //remplissage des autres lignes
       Initialise_Tlist(DMImport.Ecriture_Import.ListeEcriturePiece,DMPieces,false);
       for i:=0 to ValeursEsclave.count-1 do
       Begin
         if PRecordEcriture(ValeursEsclave.Items[i])^.ID_Piece=ValeursMaitre.ID then
           AssignListeEcriturePiece(ValeursEsclave,DMImport.Ecriture_Import.ListeEcriturePiece,i);
           //DMImport.Ecriture_Import.ListeEcriturePiece.Add(PRecordEcriture(ValeursEsclave.Items[i]));
       End;
     try
     //remplissage dans la liste de l'objet ecriture et dans l'objet pièce
     result:=DMImport.RecupPieceEcriture_SurRecords(true,ValeursMaitre,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0,AcceptPieceNul);
     except
       abort;
     end;
     //enregistrement de la pièce et des écritures
     result:=DMImport.EnregistrementPiece(false,nil,ListePieceCreees,listeFactice);
     result.Id_Piece:=DMImport.Piece_Import.FirstIDPiece;
     except
      if DMImport.messageTmp then
        showmessage('Problème à l''enregistrement de la pièce '+DMImport.Piece_Import.Reference+' !');
      abort;
     end;//fin du try except
  finally
  Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMPieces,false);

   DMEcritures.Ecriture_Isa1:=DMImport.PieceEcriture_En_Attente;
   DMPieces.Piece1:=DMImport.PieceEcriture_En_Attente.Piece;
  end;//fin du try finally
End;


function TDMPieces.RecupParametreCompte(Compte,ChampRech:string):TParametreCompte_obj;
Begin
result.Choix:=true;//si c'est un tiers =true, si c'est un compte=false;
result.retour:=true;
 try

   if copy(compte,1,1)='+' then
      begin //si c'est un compte de tiers
      result.Tiers:=Infos_TInfosTiers(DMrech.TaTiersRech,'Tiers',[Compte]);
      //result.Tiers:=DmTiersRecupRecordTiersComplet(compte);   // PB
         if result.Tiers.ResultInfos=false then
         result.retour:=false
         else
         if not empty(result.Tiers.Compte)then
         Begin //si le compte de tiers est rempli
            if empty(ChampRech)then
              begin //si champ de recherche vide,renvoie enregistrement complet
              result.ParamCpt:=DmPlanRecupEnregistrementComplet(result.Tiers.Compte);
                if result.ParamCpt.CodeRetour=false then
                result.retour:=false;
              end //fin si champ de recherche vide
            else
              begin //si champ de recherche rempli, renvoie que valeur de ce champ
              result.Partie:=DmPlanRecupPartieEnregistrement(result.Tiers.Compte,ChampRech);
                if result.Partie.CodeRetour=false then
                result.retour:=false;
              end;//fin si champ de recherche rempli,
         End;//fin si le compte de tiers est rempli
      end //fin si c'est un compte de tiers
   else
      Begin //si c'est un compte normal
      if empty(ChampRech)then
        begin //si champ de recherche rempli, renvoie que valeur de ce champ
        result.ParamCpt:=DmPlanRecupEnregistrementComplet(Compte);
          if result.ParamCpt.CodeRetour=false then
          result.retour:=false;
        end //fin si champ de recherche rempli,
      else
        begin //si champ de recherche vide,renvoie enregistrement complet
        result.Partie:=DmPlanRecupPartieEnregistrement(Compte,ChampRech);
          if result.Partie.CodeRetour=false then
          result.retour:=false;
        end; //fin si champ de recherche vide
      result.Choix:=false;
      End; //fin si c'est un compte normal

 except
 result.retour:=false;
 end;//fin du try
End;




function TDMPieces.RecherchePossibiliteCreationLigne(var ParametreCompteEcriture:TParametreCompte_Obj;LigneRecherche:integer):TCreation_obj;
var
i:integer;
ParamCptEcriture:TParametreCompte_obj;
compteTvaTmp:string;
tab:variant;
MontantTVA:TRetourMontantTva;
InfosLignePieceH:TInfosPiece_SurTypeLigne;
begin
DMEcritures.Ecriture_Isa1.InitialiseCreationLigne_obj(result);
if LigneRecherche<>-1 then
  i:=LigneRecherche
else
  i:=1;
result.Acreer:=false;
result.Existe:=false;
  //while i<=grgrid1.Rowcount-1 do
  while i<=DMEcritures.Ecriture_Isa1.ListIdentifiant.count-1 do
    with Pidentifiant_obj(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^ do
    begin //recherche des parametres tva et existence de ses parametres dans
    //les lignes déjà créées
    //ParamCptEcriture:=RecupParametreCompte(grgrid1.Cells[1,i],'');
    ParamCptEcriture:=RecupParametreCompte(Pidentifiant_obj(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.ligne.compte,'');
         if not empty(Pidentifiant_obj(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.ligne.Complement.CodeTvaCompl) then
         begin
         CompteTvaTmp:=RenvoieInfoSurTableDiverse(ligne.Complement.CodeTvaCompl,DMEcritures.Ecriture_Isa1.TableTVA,'TvaCode',['Compte'],tab);
         if not empty(CompteTvaTmp)then
            begin
            if not empty(CompteTvaTmp)then
              begin
              result.Existe:=LigneTvaExisteDeja(CompteTvaTmp);
              result.Acreer:=true;
              end;
                if ((result.Acreer) and (not result.Existe)) then
                Begin
                DMEcritures.Ecriture_Isa1.InitialiseParamCompte_obj(ParametreCompteEcriture);
                result.NumLigneConcernee:=i;
                result.CompteConcerne:=Pidentifiant_obj(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.ligne.Compte;
                result.CodeTva:=ligne.Complement.CodeTvaCompl;
                result.CompteTva:=CompteTvaTmp;
                result.LibelleTva:=Ligne.TVA.Libelle;
               //recupérer la tva de chaque ligne, si <>0 la prendre par défaut sinon la calculer
                InfosLignePieceH:=DMEcritures.Ecriture_Isa1.InfosPiece_SurTypeLigne(['H'],DMEcritures.Ecriture_Isa1.ListIdentifiant,result.CompteTva,0,true,false,-1);
                if InfosLignePieceH.montanttva<>0 then
                  begin
                    result.MontantDefaut:=InfosLignePieceH.montanttva;
                    case InfosLignePieceH.SenssoldeTva of
                      -1:result.SensCredit:=false;
                       0:result.SensCredit:=false;
                       1:result.SensCredit:=true;
                    end;//fin du case InfosLignePieceH.SenssoldeTva

                  end;
               ParametreCompteEcriture:=ParamCptEcriture;
                  if InfosLignePieceH.SenssoldeTva=0 then
                    begin
                       result.Acreer:=false;
                       result.Existe:=false;
                    end
                  else
                  I:=DMEcritures.Ecriture_Isa1.ListIdentifiant.count-1;
                //I:=grgrid1.Rowcount;
                //I:=DMEcritures.Ecriture_Isa1.ListIdentifiant.count;
                End;
            end;
         end;
    if LigneRecherche<>-1 then
      i:=DMEcritures.Ecriture_Isa1.ListIdentifiant.count
    else
    inc(i);
    if result.Existe then result.Acreer:=false;
    end;//fin de la boucle
end;


function TDMPieces.LigneTvaExisteDeja(Compte:string):boolean;
var
i:integer;
begin
result:=false;
i:=1;
   //while ((not result) and  (i<=grgrid1.RowCount-1)) do
   while ((not result) and  (i<=DMEcritures.Ecriture_Isa1.ListIdentifiant.count-1)) do
   begin //si la ligne TVA de ce compte existe déjà
   //result:=Compte=grgrid1.Cells[1,i];
   result:=compte=Pidentifiant_obj(DMEcritures.Ecriture_Isa1.ListIdentifiant.items[i])^.ligne.compte;
   inc(i);
   end;
end;





procedure TDMPieces.TaPieceVisuCalcFields(DataSet: TDataSet);
begin
TaPieceVisuComptePereTiers.AsString := TaPieceVisuCompte.AsString;
if empty(TaPieceVisuComptePereTiers.AsString) then    { isa  le  11/05/04 }
  begin //je récupère n'importe lequel des comptes de l'od car il n'y a pas de compte Pere
  //dans une OD. et pour afficher le détail d'une pièce, il me faut un compte obligatoirement
      DeFiltrageDataSet(DMRech.TaEcritureRech);
      if GrLocate(DMRech.TaEcritureRech,'id_Piece',[TaPieceVisu.FindField('Id').AsString]) then
      TaPieceVisuComptePereTiers.AsString := DMRech.TaEcritureRech.findField('Compte').AsString;
  end
else
if TypeCptTiers(TaPieceVisuCompte.AsString) then
  begin
      DeFiltrageDataSet(DMRech.TaTiersRech);
      if GrLocate(DMRech.TaTiersRech,'Tiers',[TaPieceVisuCompte.AsString]) then
      TaPieceVisuComptePereTiers.AsString := DMRech.TaTiersRech.findField('Compte').AsString;
  end;
end;


Procedure TDMPieces.GereSuppressionPiece_Import(id_Piece:integer);
begin
try//except
  FiltrageDataSet(DMImport.Ta_PieceImportExistante,'Nouvel_ID_Piece = '+inttostr(id_Piece));
  if DMImport.Ta_PieceImportExistante.RecordCount<>0 then
    while not DMImport.Ta_PieceImportExistante.Eof do
      DMImport.Ta_PieceImportExistante.Delete;
except
  abort;
end;//fin except
end;


procedure TDMPieces.TaPieceAfterPost(DataSet: TDataSet);
begin
if ParamUtil.AffichIDPiece then
  if Piece1.IDJournal in [1,2] then
    Begin
       MessageDlg('Vous venez d''enregistrer la pièce :'+piece1.Reference +#13+#10+'ID : '+inttostr(piece1.FirstIDPiece), mtConfirmation, [mbOK], 0);
    end;
end;

procedure TDMPieces.TaPieceBeforeDelete(DataSet: TDataSet);
begin
IDPieceOLD:=DataSet.findfield('id').asinteger;
end;



function TDMPieces.ImportTrame( ValeursMaitre:TImportTrame; ValeursEsclave:Tlist;AnneeAnterieure:TPieceAnterieure;ValPieceAutoGen:TValPieceAutoGenere;DataSet:TDataSet):TExceptLGR_ImportPiece;
var
listeFactice:Tlist;
i:integer;
//LigneTrame:Tlist;
EntetePiece:PrecordPiece;
CorpsPiece:PrecordEcriture;
TrameTmp:TTrame;
Begin
  try
     try
       listeFactice:=nil;
//       TrameTmp:=TTrame.Create(application.MainForm);
//       CopieContenuTrame(Dmtrame.Trame1,TrameTmp);
//       TrameTmp:=Dmtrame.Trame1;
       Dmtrame.Trame1.NouvelleTrame(false);
       initialise_TExceptLGR_ImportPiece(result);
       DMImport.AnneeAnterieure:=AnneeAnterieure;
       //récupération de l'entête de la pièce en fonction de la trame
       new(EntetePiece);
       Initialise_TRecordPiece(EntetePiece^);
       EntetePiece.Compte:=Trim(ValeursMaitre.Compte);
       case ord(ValeursMaitre.journal[1]) of
         65:EntetePiece.IDJournal:=1;//A pour achat
         86:EntetePiece.IDJournal:=2;//V pour vente
         84:EntetePiece.IDJournal:=4;//T réglement
         79:EntetePiece.IDJournal:=3;//O pour OD
       end;//fin du case journal
       EntetePiece.Date:=e.DatExoDebut;
       EntetePiece.Libelle:=Trim(ValeursMaitre.Libelle);
       EntetePiece.Trame:=true;
       DMTrame.Trame1.CodeTrame:=Trim(ValeursMaitre.CodeTrame);
       DMTrame.Trame1.LibelleTrame:=Trim(ValeursMaitre.Libelle);
       DMTrame.Trame1.CptBanque:=Trim(ValeursMaitre.CptBanque);
       dmtrame.Trame1.IDTrame:=dmtrame.Trame1.NewID(dmtrame.TaTrame_Obj,'ID');

       ///////
       //récupération des lignes de trame dans la liste des écritures
       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       //remplissage des autres lignes
       for i:=0 to ValeursEsclave.count-1 do
       Begin
         if ((PImportLigneTrame(ValeursEsclave.Items[i])^.CodeTrame=ValeursMaitre.CodeTrame)and(verifCoherenceJournal(EntetePiece.IDJournal,PImportLigneTrame(ValeursEsclave.Items[i])^.journal[1]))) then
           begin
             new(CorpsPiece);
             Initialise_TRecordEcriture(CorpsPiece^);
             CorpsPiece.TypeLigne:='H';
             CorpsPiece.Compte:=trim(PImportLigneTrame(ValeursEsclave.Items[i])^.Compte);
             CorpsPiece.Libelle:=Trim(PImportLigneTrame(ValeursEsclave.Items[i])^.Libelle);
             if not empty(PImportLigneTrame(ValeursEsclave.Items[i])^.MontantHt)then
             begin
               if PImportLigneTrame(ValeursEsclave.Items[i])^.Sens='D' then
                 CorpsPiece.MontantHt:=-StrToCurr_lgr(PImportLigneTrame(ValeursEsclave.Items[i])^.MontantHt)
               else
                 CorpsPiece.MontantHt:=StrToCurr_lgr(PImportLigneTrame(ValeursEsclave.Items[i])^.MontantHt);
             end;
             if not empty(PImportLigneTrame(ValeursEsclave.Items[i])^.MontantTVA)then
             begin
               if PImportLigneTrame(ValeursEsclave.Items[i])^.Sens='D' then
                 CorpsPiece.MontantTVA:=-StrToCurr_lgr(PImportLigneTrame(ValeursEsclave.Items[i])^.MontantTVA)
               else
                 CorpsPiece.MontantTVA:=StrToCurr_lgr(PImportLigneTrame(ValeursEsclave.Items[i])^.MontantTVA);
             end;
            if not empty(PImportLigneTrame(ValeursEsclave.Items[i])^.CodeTVA) then
                 case ord(PImportLigneTrame(ValeursEsclave.Items[i])^.CodeTVA[1]) of
                    49:CorpsPiece.CodeTVA:='I1';
                    50:CorpsPiece.CodeTVA:='A1';
                    51:CorpsPiece.CodeTVA:='V3';
                    52:CorpsPiece.CodeTVA:='V4';
                    53:CorpsPiece.CodeTVA:='V5';
                    54:CorpsPiece.CodeTVA:='V6';
                    55:CorpsPiece.CodeTVA:='V7';
                    56:CorpsPiece.CodeTVA:='V8';
                    57:CorpsPiece.CodeTVA:='V9';
                 end;
             DeFiltrageDataSet(dmrech.TaPlanCptRech);
             DeFiltrageDataSet(dmrech.TaTvaCodeRech);
             if not empty (trim(CorpsPiece.CodeTVA)) then
               begin
               if Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[CorpsPiece.Compte]).taux>0 then
                 CorpsPiece.TauxTVA:=Infos_TInfosplancpt(dmrech.TaPlanCptRech,'Compte',[CorpsPiece.Compte]).taux
               else
                 if Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[CorpsPiece.CodeTVA]).ResultInfos then
                   CorpsPiece.TauxTVA:=Infos_TInfosTvaCode(dmrech.TaTvaCodeRech,'TvaCode',[CorpsPiece.CodeTVA]).Taux_Supp;
               end;
             CorpsPiece.TypeTVA:=PImportLigneTrame(ValeursEsclave.Items[i])^.TypeTVA;
             CorpsPiece.CptRepartition:=Trim(PImportLigneTrame(ValeursEsclave.Items[i])^.CompteRepartition) ;
             CorpsPiece.LibelleRepartition:=Trim(PImportLigneTrame(ValeursEsclave.Items[i])^.LibelleRepartition) ;
             if not empty(PImportLigneTrame(ValeursEsclave.Items[i])^.TauxRepartition)then
               CorpsPiece.TauxRepartition:=StrToFloat_Lgr(PImportLigneTrame(ValeursEsclave.Items[i])^.TauxRepartition) ;
             DMImport.Ecriture_Import.ListeEcriturePiece.Add(CorpsPiece);
           end;
       End;
     try
     //remplissage dans la liste de l'objet ecriture et dans l'objet pièce

     result:=DMImport.RecupPieceEcriture_SurRecords(true,EntetePiece^,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
     except
       abort;
     end;
     //enregistrement de la pièce et des écritures
        try
          TableGereStartTransaction(dmtrame.TaTrame);
          //faire des vérif avant enregistrement de la trame
          if dmtrame=nil then dmtrame:=Tdmtrame.Create(Application.MainForm);
          dmtrame.Trame1.IDTrame:=dmtrame.Trame1.NewID(dmtrame.TaTrame_Obj,'ID');
          result:=DMTrame.EnvoieTrame_TrameLigne_SurListe(DMImport.Ecriture_Import.ListIdentifiant,DMImport.Ecriture_Import);
        except
          abort;
        end;//fin du try except
     except
//      if DMImport.messageTmp then
//        showmessage('Problème à l''enregistrement de la trame '+dmtrame.Trame1.CodeTrame+' !');

      abort;
     end;//fin du try except
  finally
  Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMPieces,false);
//  CopieContenuTrame(TrameTmp,Dmtrame.Trame1);
//  libereobjet(Tobject(TrameTmp));
   DMEcritures.Ecriture_Isa1:=DMImport.PieceEcriture_En_Attente;
   DMPieces.Piece1:=DMImport.PieceEcriture_En_Attente.Piece;
  end;//fin du try finally
End;

function TDMPieces.verifCoherenceJournal(idJournal:integer;Journal:string):boolean;
begin
   case idjournal of
     1:result:=ord(Journal[1])=65;//A pour achat
     2:result:=ord(Journal[1])=86;//V pour vente
     4:result:=ord(Journal[1])=84;//T réglement
     3:result:=ord(Journal[1])=79;//O pour OD
   else
     result:=false;  
   end;//fin du case journal
end;

procedure TDMPieces.TaPieceAfterDelete(DataSet: TDataSet);
begin
if not DMPieces.Piece1.Suppression_Pour_Modif then
  begin//si vraie suppression
    try
      if not SuppressionPieceImportee(IDPieceOLD).retour then
        abort;
    except
      TableGereRollBack(TaPiece);
      TableGereRollBack(DMBalance.TaBalance);
      abort;
    end;
  end;//fin si vraie suppression
end;


Function AffichPieceSurPeriode(DateDeb,DateFin:Tdatetime):Boolean;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
begin
  Try
    List1:=TStringList.Create;
    if DMPieces = nil then DMPieces:=TDMPieces.Create(Application.MainForm);
    if DMRech = nil then DMRech:=TDMRech.Create(Application.MainForm);

//    FiltrageDataSet(DMPieces.TaPieceVisu,'Date >='''+datetostr(DateDeb)+''' and Date <='''+datetostr(Datefin)+'''' );
//    List1:=ChampTableVersListeEx(['LibelleJournal','Reference','Compte','Date','Libelle'],DMPieces.TaPieceVisu,';',true);
    FiltrageDataSet(DMRech.TaPieceRech,'Date >='''+datetostr(DateDeb)+''' and Date <='''+datetostr(Datefin)+'''' );
    List1:=ChampTableVersListeEx(['Journal','Reference','Compte','Date','Libelle'],DMRech.TaPieceRech,';',true);
    DeFiltrageDataSet(DMRech.TaModelRech);
        for i:=0 to List1.Count-1 do
          list1.Strings[i]:=str_Setstringelement(list1.Strings[i],1,';',Infos_TInfosModel(DMRech.TaModelRech,'id_journal',[str_getstringelement(list1.Strings[i],1,';')]).Journal);
    DeFiltrageDataSet(DMRech.TaPieceRech);
    Initialise_TParamAffichage(ParamAffichage);
    ParamAffichage.AffichModal := true;
    ParamAffichage.EventButtonDetailClick :=DMPieces.VisuList_DetailClick;
    ParamAffichage.EventListViewDbleClick :=DMPieces.VisuList_DetailClick;
    ParamAffichage.Titre:='Liste des pièces';
    ParamAffichage.GestionAffichForm.Caption :='Liste des pièces de la période du '+datetostr(DateDeb)+' au '+datetostr(Datefin);

    Initialise_Periode(e.PeriodeAutre);
    E.AutrePeriode:=True;
    E.PeriodeAutre.DateDeb:=dateDeb;
    E.PeriodeAutre.DateFin:=DateFin;
    DMPieces.VisuPeriode:=e.PeriodeAutre;
    DMPieces.RetourViewListe:=AfficheVisuListView(ParamAffichage,['Journal','Référence','Compte','Date','Libelle'],
                                       [50,50,50,100,200],
                                       [List1],
                                       [taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                       [1..3,5],
                                       [0],
                                       [4]);
  Finally
    E.AutrePeriode:=False;
    ParamAffichage.EventButtonDetailClick :=nil;
    DeFiltrageDataSet(DMPieces.TaPieceVisu);
    Initialise_TStringlist(List1);
//    List1.Free;
  end;
End;

function TDMPieces.LitPeriode:TPeriode;
begin
Initialise_Periode(result);
if FVisuPeriode.Retour then
  begin
      result.DateDeb:=FVisuPeriode.DateDeb;
      result.DateFin:=FVisuPeriode.DateFin;
      result.retour:=FVisuPeriode.retour;
  end;
end;
procedure TDMPieces.EcritPeriode(Periode:TPeriode);
var
PeriodeInit:Tperiode;
begin
if Periode.Retour then
  begin
      FVisuPeriode:=Periode;
  end
else
  begin
      Initialise_Periode(PeriodeInit);
      Fvisuperiode:=PeriodeInit;
  end;
end;

procedure TDMPieces.TaPiece_ObjBeforeOpen(DataSet: TDataSet);
begin
if dmecritures<>nil then
  dmecritures.TaEcriture_Obj.IndexName:='Piece_';
end;



Function AffichDetailPieceSurID(id:integer):Boolean;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;

begin

  Try
    List1:=TStringList.Create;
    if DMPieces = nil then DMPieces:=TDMPieces.Create(Application.MainForm);
    if DMRech = nil then DMRech:=TDMRech.Create(Application.MainForm);

    DMRech.TaEcritureRech.Refresh;
    FiltrageDataSet(DMRech.TaEcritureRech,'ID_Piece= '+inttostr_lgr(id) );
    List1:=ChampTableVersListeEx(['id_piece','TypeLigne','id_Ligne','Date','compte','tiers','Libelle',
                     'Qt1','Qt2','DebitSaisie','CreditSaisie','TvaCode','Tvatype','TvaTaux',
                     'TvaDate','Rapprochement','Validation','Table_Gen','Champ_Gen',
                     'Val_Champ_Gen','Montant_TVA','id_gestanal','Code_gestanal'],DMRech.TaEcritureRech,';',true);
    Initialise_TParamAffichage(ParamAffichage);
    ParamAffichage.AffichModal := true;
    ParamAffichage.EventButtonDetailClick :=DMPieces.VisuList_EnteteClick;
    ParamAffichage.EventListViewDbleClick :=DMPieces.VisuList_EnteteClick;
    ParamAffichage.Titre:='Liste des écritures de la pièce "'+inttostr_lgr(id)+'"';
    ParamAffichage.GestionAffichForm.Caption :='Liste des écritures d''une pièce';

//    E.AutrePeriode:=True;
//    Initialise_Periode(e.PeriodeAutre);
    DMPieces.VisuPeriode:=e.PeriodeAutre;
    DMPieces.RetourViewListe:=AfficheVisuListView(ParamAffichage,['id_piece','TypeLigne','Ligne','Date','Compte','Tiers','Libelle','Qt1',
                                                                  'Qt2','DebitSaisie','CreditSaisie','TvaCode','Tvatype','TvaTaux','TvaDate',
                                                                  'Rapprochement','Validation','Table_Gen','Champ_Gen','Val_Champ_Gen','TVA','ID_gestanal',
                                                                  'Code_gestanal'],
                                       [10,20,20,70,50,50,50,20,
                                        20,50,50,20,20,50,70,
                                        20,50,50,50,50,50,20,
                                        50],
                                       [List1],
                                       [taRightJustify,taLeftJustify,taRightJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taRightJustify,
                                       taRightJustify,taRightJustify,taRightJustify,taLeftJustify,taLeftJustify,taRightJustify,taLeftJustify,
                                       taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taRightJustify,taRightJustify,
                                       taLeftJustify],
                                       [2,5..7,12..13,16,18..20,23],
                                       [1,3,8..11,14,21..22],
                                       [4,15,17]);
  Finally
//    E.AutrePeriode:=False;
    ParamAffichage.EventButtonDetailClick :=nil;
    DeFiltrageDataSet(DMRech.TaEcritureRech);
    DeFiltrageDataSet(DMPieces.TaPieceVisu);
    Initialise_TStringlist(List1);
//    List1.Free;
  end;
End;

Function AffichEntetePieceSurID(id:integer):Boolean;
var
 i:integer;
 Liste:TList;
 Compte,Designation:String;
 ParamAffichage:TParamAffichage;
 List1:TStringList;
begin
  Try
    List1:=TStringList.Create;
    if DMPieces = nil then DMPieces:=TDMPieces.Create(Application.MainForm);
    if DMRech = nil then DMRech:=TDMRech.Create(Application.MainForm);

    DMRech.TaEcritureRech.Refresh;
    FiltrageDataSet(DMRech.TaPieceRech,'ID= '+inttostr_lgr(id) );
    List1:=ChampTableVersListeEx(['id','Reference','TypePiece','Journal','Date','compte','Libelle',
                     'Validation','Table_Gen','Champ_Gen','Val_Champ_Gen'],DMRech.TaPieceRech,';',true);
    Initialise_TParamAffichage(ParamAffichage);
    ParamAffichage.AffichModal := true;
    ParamAffichage.EventButtonDetailClick :=DMPieces.VisuList_DetailClick;
    ParamAffichage.EventListViewDbleClick :=DMPieces.VisuList_DetailClick;
    ParamAffichage.Titre:='Entête de la pièce "'+inttostr_lgr(id)+'"';
    ParamAffichage.GestionAffichForm.Caption :='Entête d''une pièce';

//    E.AutrePeriode:=True;
//    Initialise_Periode(e.PeriodeAutre);
    DMPieces.VisuPeriode:=e.PeriodeAutre;
    DMPieces.RetourViewListe:=AfficheVisuListView(ParamAffichage,['id','Reference','TypePiece','Journal','Date','compte',
                                                                  'Libelle','Validation','Table_Gen','Champ_Gen','Val_Champ_Gen'],
                                       [70,70,20,20,70,70,
                                        100,70,50,50,50],
                                       [List1],
                                       [taRightJustify,taLeftJustify,taLeftJustify,taRightJustify,taLeftJustify,taLeftJustify,
                                        taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify,taLeftJustify],
                                       [2,3,6..7,9..11],
                                       [1,4],
                                       [5,8]);
  Finally
//    E.AutrePeriode:=False;
    DeFiltrageDataSet(DMRech.TaEcritureRech);
    ParamAffichage.EventButtonDetailClick :=nil;
    DeFiltrageDataSet(DMPieces.TaPieceVisu);
    Initialise_TStringlist(List1);
//    List1.Free;
  end;
End;

Procedure TDMPieces.VisuList_EnteteClick(Sender : TObject);
var
PeriodeAutre_Tmp:TPeriode;
Begin
try
 AffichEntetePieceSurID(strtoint_lgr(VisuListeView.ItemCourantValeurRow.Strings[0]));
Finally
end;
End;

end.

