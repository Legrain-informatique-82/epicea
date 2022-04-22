unit DMChargesAPayertmp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Gr_Librairie_obj, E2_Librairie_obj,LibSQL,E2_ChargesAPayer_Isa,
  AideMontant2,DMTVA,DMBalances,DMPiece,DMClotures,RxMemDS,E2_Decl_Records,
LibZoneSaisie;

//ce record sert à récupérer le code erreur suite à la vérification de la saisie

//   TErreurChargesAPayer = record
//   CodeErreur:integer;
//   Retour:boolean;
//end;


//ce record sert à recupérer les paramètres de Mise à jour de la balance après 
l'enregistrement
//ou la suppression d'une charge à payer ou d'un produit à recevoir
type
     TRecupParametres=record
     sens1,sens2,sens3,sens4:string;
     Qte1,Qte2,Qte3,Qte4:string;
     compteTva:string;
end;

type
  TDMChargeAPayer = class(TDataModule)
    TaChAPayer: TTable;
    DataChAPayer: TDataSource;
    TaChAPayer2: TTable;
    DataChAPayer2: TDataSource;
    DataChAPayer3: TDataSource;
    TaChAPayer3: TTable;
    QueryDesignation: TQuery;
    DataDesignation: TDataSource;
    TaRechercheChAPayer: TTable;
    TaChAPayerID: TIntegerField;
    TaChAPayerCompte: TStringField;
    TaChAPayerLibelle: TStringField;
    TaChAPayerSens: TStringField;
    TaChAPayerQte: TFloatField;
    TaChAPayerMontantHT: TCurrencyField;
    TaChAPayerDateSaisie: TDateField;
    TaChAPayerDateExercice: TDateField;
    TaChAPayerCompte2: TStringField;
    TaChAPayerLibelle2: TStringField;
    TaChAPayerTVA: TCurrencyField;
    TaChAPayerDateSysteme: TDateTimeField;
    TaChAPayerDate_Piece: TDateField;
    TaChAPayerReference: TStringField;
    TaChAPayerId_Piece: TIntegerField;
    TaChAPayer2ID: TIntegerField;
    TaChAPayer2Compte: TStringField;
    TaChAPayer2Libelle: TStringField;
    TaChAPayer2Sens: TStringField;
    TaChAPayer2Qte: TFloatField;
    TaChAPayer2MontantHT: TCurrencyField;
    TaChAPayer2DateSaisie: TDateField;
    TaChAPayer2DateExercice: TDateField;
    TaChAPayer2Compte2: TStringField;
    TaChAPayer2Libelle2: TStringField;
    TaChAPayer2TVA: TCurrencyField;
    TaChAPayer2DateSysteme: TDateTimeField;
    TaChAPayer2Date_Piece: TDateField;
    TaChAPayer2Reference: TStringField;
    TaChAPayer2Id_Piece: TIntegerField;
    QueryDesignationId: TIntegerField;
    QueryDesignationCompte2: TStringField;
    QueryDesignationDesignation: TStringField;
    QueryDesignationSens: TStringField;
    TaChAPayer3ID: TIntegerField;
    TaChAPayer3Compte: TStringField;
    TaChAPayer3Libelle: TStringField;
    TaChAPayer3Sens: TStringField;
    TaChAPayer3Qte: TFloatField;
    TaChAPayer3MontantHT: TCurrencyField;
    TaChAPayer3DateSaisie: TDateField;
    TaChAPayer3DateExercice: TDateField;
    TaChAPayer3Compte2: TStringField;
    TaChAPayer3Libelle2: TStringField;
    TaChAPayer3TVA: TCurrencyField;
    TaChAPayer3DateSysteme: TDateTimeField;
    TaChAPayer3Date_Piece: TDateField;
    TaChAPayer3Reference: TStringField;
    TaChAPayer3Id_Piece: TIntegerField;
    TaChAPayerEcritureReference: TTable;
    TaChAPayerReprise: TBooleanField;
    procedure DMChargeAPayerCreate(Sender: TObject);
    procedure DMChargeAPayerDestroy(Sender: TObject);
    procedure FiltrageAffichageGrille(Tag_bis:integer;Compte:String);
    Function  CtrlSaisieChargesAPayer(CCourant:Tfield):TErreurSaisie;
    procedure TaChAPayerAfterPost(DataSet: TDataSet);
    procedure TaChAPayerBeforePost(DataSet: TDataSet);
    procedure TaChAPayerBeforeEdit(DataSet: TDataSet);
    procedure TaChAPayerBeforeDelete(DataSet: TDataSet);
    procedure TaChAPayerAfterDelete(DataSet: TDataSet);
    function  RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
    procedure 
TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;EtatTaChApayer:TDataSetStat
e;Ref:string);
    function CreationListeOD(DateExo:TDateTime;sens:string):TStringList;
    procedure DemandeAffichageReprise;
    procedure CreationODChargeAPayerReprise;
    procedure CreationODChargeAPayerCloture;
    Procedure 
EcritureReference(ID:integer;Changerdate:boolean;Ref:string;Date:Tdatetime);
    procedure FiltragePourOuvertureReprise1(sens:string);
    procedure VerifSaisieFeuilleReprise1(cCourant:tfield);
    procedure TaChAPayer3BeforeDelete(DataSet: TDataSet);
    procedure TaChAPayer3BeforePost(DataSet: TDataSet);
    procedure TaChAPayer3BeforeEdit(DataSet: TDataSet);
    procedure TaChAPayer3BeforeInsert(DataSet: TDataSet);
    procedure InitialisationVariablesTemp;
    procedure Filtrage_EcriturePourNouvelExo(var 
tMem:TRxMemoryData;NouvelleDate:Tdatetime);
    procedure TaChAPayerPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaChAPayerDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
      procedure RecupInfoApresVerif(Tout:boolean);
      procedure VerifTVA;
    procedure TaChAPayer3AfterPost(DataSet: TDataSet);
    procedure TaChAPayer3PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure FiltreVide;
    procedure TaChAPayerBeforeInsert(DataSet: TDataSet);
    function VerifRepriseChargesOuverture_OK(var messageTmp:string):boolean;
    function VerifExistChargesAPayerOuverture(var 
messageTmp:string;Mess:boolean):boolean;
    function VerifExistChargesAPayerCloture(var messageTmp:string;Mess:boolean):boolean;
    function VerifExistChargesAPayerOuvertureAReprendre(var 
messageTmp:string;Mess:boolean):boolean;
    procedure TaChAPayerAfterScroll(DataSet: TDataSet);
    procedure TraitementCloture2000(sender:Tobject);
    procedure CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure CreationODReprise_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure TaChAPayerCalcFields(DataSet: TDataSet);

    procedure BtnImprimerClick(Sender: TObject);

    procedure BtnDetailClick(Sender: TObject);

    procedure BtnImprimerClick(Sender: TObject);

    procedure BtnDetailClick(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Erreur:TErreurSaisie;
    CompteChargeOuProduit,Libelle_CompteChargeOuProduit:string;// Serve à recupérer le 
compte et son libelle
                                                               // de Charges à Payer
    LaisserPasser:boolean;
    Procedure ImportChAPayer(Valeurs:array of const;DataSet:TDataSet);
    Procedure ImportPrARecevoir(Valeurs:array of const;DataSet:TDataSet);
  end;

var
  DMChargeAPayer: TDMChargeAPayer;
  TvaTmp,QteTmp:real;
  MontantTmp,TTCTmp,MontantTTC: Currency;
  CompteTmp,Compte2Tmp,DesignationTmp,Ref: String;
  DatePiece:Tdatetime;
  Mark: TBookMark;
  dernierlibelle:string;
  MessDerSub:boolean;

  
Function VisuListeDM:Boolean;

Function VisuListeDM:Boolean;

implementation
uses DMPlanCpt,E2_AideCompte, E2_Main,DMImportation,DMBaseDonnee;
{$R *.DFM}

Function VisuListeDM:Boolean;

Begin

if VisuListe = nil then VisuListe:=TVisuListe.Create(Application.MainForm);

if DMChargeAPayer = nil then DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);

//VisuListe.BtnDetail.OnClick:=DMChargeAPayer.BtnDetailClick;

//VisuListe.BtnImprimer.OnClick:=DMChargeAPayer.BtnImprimerClick;

//VisuListe.PaGrille.OnResize:=DMChargeAPayer.PaGrilleResize;

//VisuListe.RxLabTitre.Caption:='Visualisation ...'';

//VisuListe.PaTitrePetit.Caption:='Visualisation ...'';

// Ici les traitements sur la table reliée a VisuList

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

// Initialisation de la grille

//GrDbGridInitColonne(VisuListe.GrDBVisu,DMChargeAPayer.Da,DMChargeAPayer.Ta,

//                   ['Titre1','Titre2','Titre3','Titre4','Titre5'],

//                   ['Champ1','Champ2','Champ3','Champ4','Champ5']

//                   ,E.FormatMonnaie,E.EditFormat);

VisuListe.Show;

End;

Function VisuListeDM:Boolean;

Begin

if VisuListe = nil then VisuListe:=TVisuListe.Create(Application.MainForm);

if DMChargeAPayer = nil then 
DMChargeAPayer:=TDMChargeAPayer.Create(Application.MainForm);

//VisuListe.BtnDetail.OnClick:=DMChargeAPayer.BtnDetailClick;

//VisuListe.BtnImprimer.OnClick:=DMChargeAPayer.BtnImprimerClick;

//VisuListe.PaGrille.OnResize:=DMChargeAPayer.PaGrilleResize;

//VisuListe.RxLabTitre.Caption:='Visualisation ...'';

//VisuListe.PaTitrePetit.Caption:='Visualisation ...'';

// Ici les traitements sur la table reliée a VisuList

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

//DMChargeAPayer.;

// Initialisation de la grille

//GrDbGridInitColonne(VisuListe.GrDBVisu,DMChargeAPayer.Da,DMChargeAPayer.Ta,

//                   ['Titre1','Titre2','Titre3','Titre4','Titre5'],

//                   ['Champ1','Champ2','Champ3','Champ4','Champ5']

//                   ,E.FormatMonnaie,E.EditFormat);

VisuListe.Show;

End;

//vérifie la saisie dans la feuille E2_ReprisechargeAPayer
procedure TDMChargeAPayer.VerifSaisieFeuilleReprise1(cCourant:tfield);
begin
case CCourant.Index of
     12: Begin//TaChAPayer3Date_Piece
             If not(empty(ccourant.asstring))Then
             Begin
                  // Vérifier que la date saisie est dans l'année de l'exercice en cours
                  If ((CCourant.AsDateTime < E.DatExoDebut) Or (CCourant.AsDateTime > 
E.DatExoFin)) Then
                  Begin
                       Messagedlg('La date saisie doit appartenir à l''exercice courant 
!!!',mtWarning,[mbok],0);
                       Abort;
                  End;
             End;
     End;
End; // Fin du Case
end;

//filtre la grille de la feuille E2_ReprisechargeAPayer suivant si on veut afficher
//les charges ou les produits
procedure TDMChargeAPayer.FiltragePourOuvertureReprise1(sens:string);
begin
FiltrageDataSet(TaChAPayer3,CreeFiltreET(['DateSaisie','Sens'],[DateToStr(E.DatExoDebut
-1),Sens]));
end;

//Ecrit la reference dans la table charges a payer après avoir créer l'OD
Procedure 
TDMChargeAPayer.EcritureReference(ID:integer;Changerdate:boolean;Ref:string;Date:Tda
tetime);
begin
try
//  TaChAPayer.BeforePost:=nil;
//  TaChAPayer.AfterPost:=nil;

    if TaChAPayerEcritureReference.Locate('ID',ID,[]) then
    begin
      TaChAPayerEcritureReference.Edit;
      TaChAPayerEcritureReference.FindField('Reference').AsString:= Ref;
      if Changerdate=true then
      TaChAPayerEcritureReference.FindField('Date_Piece').Asdatetime:=Date;
      TableGerePost(TaChAPayerEcritureReference);
   end;
  finally
//  TaChAPayer.BeforePost:=TaChAPayerBeforePost;
//  TaChAPayer.AfterPost:=TaChAPayerAfterPost;

  end;
end;

//Création des OD après la reprise des charges
procedure TDMChargeAPayer.CreationODChargeAPayerReprise;
var
NbEnregistrement:integer;
begin
MontantTTC:=0;
TaChAPayer2.Refresh;
   try
       TableGereStartTransaction(TaChAPayer2);
       //filtrage avant la Création des OD de Reprise;
       FiltrageDataSet(TaChAPayer2,'Date_Piece <>null and Date_Piece >= 
'''+DateTimeToStr(E.DatExoDebut)+''' And Date_Piece <= 
'''+DateTimeToStr(E.DatExoFin)+''' And DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 
1)+''' And Reference = ''''');
       NbEnregistrement:=TaChAPayer2.RecordCount;
       TaChAPayer2.first;
       // Tant qu'il reste des enregistrements dans la table TaCAR
        While (Not(NbEnregistrement=0)) Do
        Begin
        MontantTTC:=TaChAPayer2MontantHT.AsCurrency+TaChAPayer2TVA.AsCurrency;
        CreationODReprise_avecObjet(TaChAPayer2,'');
        //une fois l'OD crée, on écrit la référence de cette pièce dans la table des charges à 
payer
        EcritureReference(DMChargeAPayer.TaChAPayer2ID.AsInteger,false,DMImport.Piece
_Import.Reference,e.DatExoDebut);
        TaChAPayer2.Next; //et on continue jusqu'à ce qu'il n'y ai plus de nouvelle charges 
enregistrée sans référence
        NbEnregistrement:=NbEnregistrement-1;
        end;
        TableGereCommit(TaChAPayer2);
        TableGereCommit(DMPieces.TaPiece);
   except
       begin
       showmessage('Problème à l''enregistrement des OD d''ouverture');
       TableGereRollBack(TaChAPayer2);
       TableGereRollBack(DMPieces.TaPiece);
       abort;
       end;
   end;
end;

//création des OD concernant les charges et produits enregistrés dans la clôture
procedure TDMChargeAPayer.CreationODChargeAPayerCloture;
var
NbEnregistrement:integer;
begin
   try
      TableGereStartTransaction(TaChAPayer);
      // filtrage avant la Creation des OD de Cloture pour soustraire les charges ou produits 
avant de les
      //réenregistrer suite à la création des OD
      FiltrageDataSet(TaChAPayer,'DateSaisie = '''+DateTimeToStr(E.DatExoFin)+''' And 
Reference = ''''');
      NbEnregistrement:=TaChAPayer.RecordCount;
      TaChAPayer.First;
      While (Not(NbEnregistrement=0)) Do
        Begin
        MontantTTC:=TaChAPayerMontantHT.AsCurrency+TaChAPayerTVA.AsCurrency;
        InitialisationVariablesTemp;//mise à zéro des variables temporaires
        //remplissage des variables temporaires
        TvaTmp:=TaChAPayerTVA.AsFloat;
        Compte2Tmp:=TaChAPayerCompte2.AsString;
        CompteTmp:=TaChAPayerCompte.AsString;
        MontantTmp:=TaChAPayerMontantHT.AsCurrency;
        TTCTmp:=MontantTTC;
        QteTmp:=TaChAPayerQte.AsFloat;
        DesignationTmp:=TaChAPayerLibelle2.AsString;
        ref:=TaChAPayerReference.AsString;
        //////////////////
//      pour tous les nouvelles charges ou produits enregistrée dans la clôture
//      on soustrait de la balance le montant de ces charges 1 par 1
//      pour pouvoir les mettre à jour de nouveau en créant les OD de clôture
        if TaChAPayerSens.AsString='C'then  //traitement porte sur les charges
        TraitementMAJBalance(21,true,dsbrowse,'');
        if TaChAPayerSens.AsString='D'then  //traitement porte sur les produits
        TraitementMAJBalance(22,true,dsbrowse,'');
        TaChAPayer.next;
        NbEnregistrement:=NbEnregistrement-1;
        end;
       // filtrage avant la Creation des OD de Cloture.Ce filtrage intervient après la 
MAJBalance'' 
       FiltrageDataSet(TaChAPayer2,'DateSaisie = '''+DateTimeToStr(E.DatExoFin)+''' And 
Reference = ''''');
       NbEnregistrement:=TaChAPayer2.RecordCount;
       TaChAPayer2.first;
       // Tant qu'il reste des enregistrements dans la table TaCAR
        While (Not(NbEnregistrement=0)) Do
        Begin
        TaChAPayer2.Refresh;
        MontantTTC:=TaChAPayer2MontantHT.AsCurrency+TaChAPayer2TVA.AsCurrency;
        CreationODCloture_avecObjet(TaChAPayer2,'');
        //une fois l'OD crée, on écrit la référence de cette pièce dans la table des charges à 
payer
        EcritureReference(DMChargeAPayer.TaChAPayer2ID.AsInteger,true,DMImport.Piece_
Import.Reference,e.DatExoFin);
        TaChAPayer2.Next; //et on continue jusqu'à ce qu'il n'y ai plus de nouvelle charges 
enregistrée sans référence
        NbEnregistrement:=NbEnregistrement-1;
        end;
        TableGereCommit(TaChAPayer2);
        TableGereCommit(DMPieces.TaPiece);
   except
       begin
       showmessage('Problème à l''enregistrement des OD d''ouverture');
       TableGereRollBack(TaChAPayer2);
       TableGereRollBack(DMPieces.TaPiece);
       abort;
       end;
   end;
   TaChAPayer.Filtered:=false;
   TaChAPayer.filter:='';
   TaChAPayer.Filtered:=true;
end;


//mise à zéro des variables temporaires
procedure TDMChargeAPayer.InitialisationVariablesTemp;
begin
TvaTmp:=0;
Compte2Tmp:='';
CompteTmp:='';
MontantTmp:=0;
TTCTmp:=0;
QteTmp:=0;
DesignationTmp:='';
ref:='';
end;


//prépare les listes d'OD à afficher dans ''E2_RepriseChargesAPayer2_Isa''
//passe les paramètres d'affichage de cette fenêtre (caption, boutons,etc...)
//Cette fenêtre sert à afficher les OD des différents menu d'ouverture et de clôture
//les paramètres d'affichage sont passés au moment de la demande d'affichage de cette 
fenêtre
procedure TDMChargeAPayer.DemandeAffichageReprise;
var
numTag,NumButton:integer;
Liste1,Liste2:TStringList;
begin
numTag:=0;
NumButton:=1;
if liste1=nil then liste1:=TStringList.Create;
if liste2=nil then liste2:=TStringList.Create;
numtag:=strtoint(copy(inttostr(tag),1,1));
NumButton:=strtoint(copy(inttostr(tag),2,1));
if numtag=1 then
 begin
   liste1:=CreationListeOD(E.DatExoDebut-1,'C');
   liste2:= CreationListeOD(E.DatExoDebut-1,'D');
   DMPieces.AffichageFeuilleReprise(NumButton,liste1,liste2,'OD de Reprise des Charges A 
Payer et Produits A Recevoir',
   'OD de Reprise Charges A Payer','OD de Reprise Produits A Recevoir',true);
 end;
if numtag=2 then
  begin
    liste1:=CreationListeOD(E.datexofin,'C');
    liste2:=CreationListeOD(E.datexofin,'D');
    DMPieces.AffichageFeuilleReprise(NumButton,liste1,liste2,'OD Clôture des Charges A 
Payer et Produits A Recevoir',
    'OD Clôture Charges A Payer','OD Clôture Produits A Recevoir',true);
  end;
liste1.Free;
liste2.Free;
end;


//crée la liste des OD à afficher dans ''E2_RepriseChargesAPayer2_Isa'
//l'appel de cette fonction se fait dans ''DemandeAffichageReprise''
function TDMChargeAPayer.CreationListeOD(DateExo:TDateTime;sens:string):TStringList;
begin
TaChAPayer.Filtered := False;
TaChAPayer.Filter := ('DateSaisie = '''+DateTimeToStr(DateExo)+''' And Reference <> '''' 
And Sens = '''+sens+'''');
TaChAPayer.Filtered := True;
result:=TStringList.Create;
result.Clear;
  While (Not(TaChAPayer.EOF)) Do
     Begin
         If result.IndexOf(TaChAPayerReference.AsString) = -1 Then
            result.Add(TaChAPayerReference.AsString);
         TaChAPayer.Next;
     End;
end;


//******************* TDMChargeAPayer.TraitementMAJBalance *************************
//Permet de mettre à jour la balance à la fois lors de l'enregistrement d'une nouvelle
//charges ou produit en ajout, mais aussi en soustraction avant la création d'une OD
//car la création de l'OD génère une mise à jour de la balance elle aussi.
procedure 
TDMChargeAPayer.TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;EtatTaChA
payer:TDataSetState;Ref:string);
var
param:TRecupParametres; //nom du champ(Debit ou Credit)et du champ Quantité
begin
try
if Ch_Pr= 0 then
param:=RecupParametreMAJBalance(self.tag)//récupération des paramètres de MAJ 
Balance
else
param:=RecupParametreMAJBalance(Ch_Pr);//récupération des paramètres de MAJ 
Balance
with param do
   begin //Début du with   
    if empty(Ref) then
    begin
    //mise à jour balance pour le compte de charges A Payer
    DMBalance.MAJBalance(Suppression,qte1,sens1,TaChAPayerCompte.AsString,
    compteTmp,TaChAPayerQte.AsFloat,QteTmp,MontantTTC,TTCTmp,EtatTaChApayer);
    if ((TaChAPayerTVA.AsCurrency<>0) or(TvaTmp<>0))then
      DMBalance.MAJBalance(Suppression,qte2,sens2,compteTva,
      compteTva,0,0,TaChAPayerTVA.AsCurrency,TvaTmp,EtatTaChApayer);
    end
    else
       begin //si la charge a une OD
           case self.Tag of
           11,12:begin//si ouverture, MAJ balance d'ouverture (Report)
                 DMBalance.MAJBalance(Suppression,qte1,sens1,TaChAPayerCompte.AsString,
                 compteTmp,TaChAPayerQte.AsFloat,QteTmp,MontantTTC,TTCTmp,EtatTaChA
payer);//MAJ Balance pour compte de charges ou de produits
                 //s'il y a de la tva sur la charge
                 if((TaChAPayerTVA.AsCurrency<>0) or(TvaTmp<>0))then
                 DMBalance.MAJBalance(Suppression,qte2,sens2,compteTva,
                 compteTva,0,0,TaChAPayerTVA.AsCurrency,TvaTmp,EtatTaChApayer);
                 end;
           21,22:begin//si clôture, MAJ balance de clôture (Base)
                 DMBalance.MAJBalance(Suppression,qte1,sens1,TaChAPayerCompte.AsString,
                 compteTmp,TaChAPayerQte.AsFloat,QteTmp,MontantTTC,TTCTmp,dsinsert);//
MAJ Balance pour compte de charges ou de produits
                 end;
           end;//fin du case
       end;// FIN si la charge a une OD
end;//fin du with
except
  abort;
end;
end;


//******************* TDMChargeAPayer.TaChAPayerBeforePost *************************
//Contrôle de la saisie, mise à jour de la balance, ouverture d'une transaction
procedure TDMChargeAPayer.TaChAPayerBeforePost(DataSet: TDataSet);
var
Annee,Mois,Jour:word;
DateCourante:Tdatetime;
I:integer;
controleSaisie:TErreurSaisie;
begin
////Contrôle la saisie////////
if DataSet.State in [dsinsert,dsedit] then
   begin
   for i:=8 to 9 do
     begin
     controleSaisie:=CtrlSaisieChargesAPayer(TaChAPayer.Fields[i]);
     if controleSaisie.Retour=false then
           case controleSaisie.CodeErreur of
           8100:begin
                  //Focus sur compte2
                  LaisserPasser:=false;
                  if not empty(DataSet.Fields[8].asstring)then
                    begin
                    if application.MessageBox(Pchar('Ce compte n''est pas cohérent dans ce 
context, voulez-vous continuer'),'Erreur de saisie',MB_ICONWARNING 
+MB_YESNO+MB_DEFBUTTON1)=mrno then
                      Begin//si
                        DataSet.Fields[8].FocusControl;//isa 5-11-02
                        abort;
                      End//fin si
                    else
                      LaisserPasser:=true;  
                    end
                  else
                    Begin//si
                        DataSet.Fields[8].FocusControl;//isa 5-11-02
                        abort;
                    End;//fin si

                end;
           8101:begin
                  DataSet.Fields[8].FocusControl;
                  abort;//champ code emprunt
                end;
           end;//fin du case
     end;//fin du i=8 à 10
   for i:=4 to 5 do
     begin
     controleSaisie:=CtrlSaisieChargesAPayer(TaChAPayer.Fields[i]);
     if controleSaisie.Retour=false then
           case controleSaisie.CodeErreur of
           5100:begin
                 DataSet.Fields[5].FocusControl;
                  abort;//champ code emprunt
                end;
           end;//fin du case
   end;//fin du i=4 to 5

   controleSaisie:=CtrlSaisieChargesAPayer(TaChAPayer.Fields[10]);
////fin du Contrôle de la saisie////////

/////Remplissage des champs hors saisie////////
   try
      if DataSet.State=dsinsert then
      begin //si table en insertion
      TaChAPayerID.AsInteger:=MaxId_Query(TaChAPayer,'ID');
      TaChAPayerCompte.AsString:=CompteChargeOuProduit; //PB le 29/12/2002

      TaChAPayerLibelle.AsString:=DMPlan.LibelleDuNumCptPCU(CompteChargeOuProduit); 
//PB le 29/12/2002
//      TaChAPayerCompte.AsString:=ChargesAPayer_Isa.NumCpt.Text; PB le 29/12/2002
//      TaChAPayerLibelle.AsString:=ChargesAPayer_Isa.EdLibelle.Text; PB le 29/12/2002
      TaChAPayerDateSysteme.AsDateTime:=now;
         case self.Tag of
         1,11,12:begin //si ouverture
                 TaChAPayerDateSaisie.AsDateTime:=e.DatExoDebut-1;
                 datecourante:=e.DatExoDebut;
                 DecodeDate(datecourante,annee,mois,jour);
                 TaChAPayerDateExercice.AsDateTime:=EncodeDate(annee-1,mois,jour);
                    case self.Tag of
                    11:TaChAPayerSens.Asstring:='C';
                    12:TaChAPayerSens.Asstring:='D';
                    end;//fin du case
                 end;//fin si ouverture
         2,21,22:begin//si cloture
                 TaChAPayerDateSaisie.AsDateTime:=E.DatExoFin;
                 TaChAPayerDateExercice.AsDateTime:=E.DatExoDebut;
                    case self.Tag of
                    21:TaChAPayerSens.Asstring:='C';
                    22:TaChAPayerSens.Asstring:='D';
                    end;//fin du case
                 end;//fin si cloture
         end;//fin du case ouverture/cloture
      end;//fin table en insertion
      except
      showmessage('Problème à l''écriture dans la table Charges A Payer !!!');
      abort;
      end;//fin du try
/////fin du Remplissage des champs hors saisie////////


   //Mise à jour de la balance
   TableGereStartTransaction(TaChAPayer);
   try
   MontantTTC:=TaChAPayerMontantHT.AsCurrency+TaChAPayerTVA.AsCurrency;
    TraitementMAJBalance(self.tag,false,DataSet.State,ref);
       if DataSet.State =dsEdit then //si en modification
         if not(empty(ref)) then //si OD créée
             begin //si la modification porte sur un champ autre que la désignation
             //on supprime l'OD
                if (trim(TaChAPayerCompte2.AsString)<>trim(Compte2Tmp))or
               (TaChAPayerMontantHT.AsCurrency<>MontantTmp)or(TaChAPayerQte.AsFloat<
>QteTmp)
               or (TaChAPayerTVA.AsFloat<>TvaTmp)then
               begin
               DMPieces.SuppressionOD(TaChAPayerReference.AsString);
               TaChAPayerReference.AsString:='';
               TaChAPayerDate_Piece.Asstring:='';
               TaChAPayerDateSysteme.AsDateTime:=now;
               end
               else //sinon, on modifie l'OD uniquement
               if trim(TaChAPayerLibelle2.asstring)<>trim(DesignationTmp) then
               DMPieces.ModificationOD(TaChAPayerReference.AsString,TaChAPayerLibelle2.
asstring);
             end;//fin si modif et OD
   except
   //si problème, annule toutes les écritures (Suppression ou modif OD, MAJ 
Balance,enregistrement charge)
   TableGereRollback(DataSet);
   TableGereRollback(DMPieces.TaPiece);
   showmessage('Problème à la mise à jour de la balance !!!');
   abort;
   end;//fin du try
   end;
end;

//sert à contrôler la saisie, à proposer une liste dans certain cas,
//à remplir un champ vide par défaut dans certain cas
//enfin, renvoie un code erreur si la saisie reste invalide
Function TDMChargeAPayer.CtrlSaisieChargesAPayer(CCourant:Tfield):TErreurSaisie;
var
RetourEnregistrement:TEnregistrementComplet;
begin // initialisation des variables de retour de fonction
CtrlSaisieChargesAPayer.CodeErreur:=0;
CtrlSaisieChargesAPayer.Retour:=True;
  if TaChAPayer.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
        case CCourant.Index of
        8: begin // si champ n° 1 (compte2)
        ChargesAPayer_Isa.GestionFiltrageAideCompte(ccourant);//on filtre aideCompte par
        //rapport au compte de charges pour y afficher les comptes de reprise correspondants
           if LaisserPasser=false then
             begin
             if 
AideCompteDansContexte_LaisserPasser(CCourant.AsString,ccourant,['Rac1','Rac2','Rac3'
,'Rac4','Rac5'],false,false,MessDerSub,LaisserPasser,true,true,false,true,0)=false then
               begin
                 if not LaisserPasser then
                   begin
                   CtrlSaisieChargesAPayer.CodeErreur:=8100;  //Compte vide
                   CtrlSaisieChargesAPayer.Retour:=False;
                   end;
               end;
             end;
                //Récupére les paramètres du compte de reprise séléctionné, et en fonction
             //initialise certains champs comme la Quantité ou la tva, si champ libellé vide,
             //rempli par défaut avec le libellé du compte
             if result.retour then
              begin
               if VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCourant.DataSet) then
                 begin
                   LaisserPasser:=false;
                   CCourant.FocusControl;
                   CtrlSaisieChargesAPayer.CodeErreur:=8200;  //Compte déjà utilisé dans BO
                   CtrlSaisieChargesAPayer.Retour:=False;
                 end else
               RecupInfoApresVerif(true);
             end
           end;//fin champ n°1
// //rapport au compte de charges pour y afficher les comptes de reprise correspondants
        9: begin//si champ n°2(Désignation)
            // Le champ est vide, affectation du libellé utilisateur par défaut
            If Empty(CCourant.AsString) then
               begin
               RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaChAPayerCompte
2.AsString);
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
                 RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaChAPayerCompt
e2.AsString);
                  if not(empty(RetourEnregistrement.Libelle)) then
                     begin
                     ccourant.AsString:=RetourEnregistrement.Libelle;
                     DernierLibelle:=RetourEnregistrement.Libelle;
                     end;
               end;//fin champ n°2 vide
           end;//fin si champ n°2(Désignation)
        4: begin//si champ n°3 (Qté)
            If (Empty(CCourant.AsString)) and (ccourant.ReadOnly=false) then
             cCourant.AsString:='0';
           end;//fin si champ n°3 (Qté)
        5: begin//si champ n°4 (Montant HT)
             if VerifFNumeric(CCourant).VideOUZero then // PB le 05/08/2002
             Begin // si champ n°4 vide ou =0
             CtrlSaisieChargesAPayer.CodeErreur:=5100;
             CtrlSaisieChargesAPayer.Retour:=False;
             Application.Messagebox(Pchar('La saisie du montant HT est obligatoire !!!'),'Erreur 
de saisie',0);
             end;//fin  si champ n°4 vide ou =0
           end;//fin si champ n°4 (Montant HT)
        10:begin//si champ n°5 (TVA)
             If (Empty(CCourant.AsString)) and (ccourant.ReadOnly=false) then
             Begin // si champ n°5 vide et pas en lecture seule
             cCourant.AsString:='0';
             end;//fin si champ n°5 vide et pas en lecture seule
             if not VerifFNumeric(CCourant).VideOUZero then // PB le 05/08/2002
             Begin // si champ n°5 pas vide
             // vérifie la cohérence du montant tva saisie avec le montant calculé en fonction
             // des taux récupérés. si incohérent,envoie message et AideMontantTTC
             VerifTVA;
             end;//fin si champ n°5 pas vide
           end;//fin si champ n° 5 (TVA)
        end;//fin du case.ccourant
  end; //fin etat insertion ou modif
end;


//filtre la grille suivant si on est sur la fenêtre d'ouverture ou de clôture
procedure TDMChargeAPayer.FiltrageAffichageGrille(Tag_bis:integer;Compte:String);
begin
 case Tag_bis of
    1,11,12 : 
FiltrageDataSet(TaChAPayer,CreeFiltreET(['Compte','DateSaisie'],[Compte,datetostr(E.DatEx
oDebut-1)]));
    2,21,22 : 
FiltrageDataSet(TaChAPayer,CreeFiltreET(['Compte','DateSaisie'],[Compte,DateToStr(E.Dat
ExoFin)]));
 end;//fin du case
end;



//ouverture des tables et initialisation de certains champs
procedure TDMChargeAPayer.DMChargeAPayerCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
TaChAPayerCompte2.ValidChars := ['0'..'9'];
TaChAPayerMontantHT.DisplayFormat:=E.FormatMonnaie;
TaChAPayerMontantHT.EditFormat:='0.00 ;-0.00 ';

TaChAPayer3Compte2.ValidChars := ['0'..'9'];

TaChAPayer3MontantHT.DisplayFormat:=E.FormatMonnaie;
TaChAPayer3MontantHT.EditFormat:='0.00 ;-0.00 ';

TaChAPayerTVA.DisplayFormat:=E.FormatMonnaie;
TaChAPayerTVA.EditFormat:='0.00 ;-0.00 ';

MessDerSub:=true;
end;


//Fermeture des tables
procedure TDMChargeAPayer.DMChargeAPayerDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
end;



//permet de récupérer des paramètres de MAJ de balance suivant si elle intervient à 
l'ouverture
//ou à la clôture, si elle porte sur une charge ou un produit
function  
TDMChargeAPayer.RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
begin
   with result do
   begin
    case tag_module of
         11:begin //ouverture-Charges
            sens1:='Credit_Report';
            Qte1:='Qt2_Report';
            sens2:='Debit_Report';
            Qte2:='Qt1_Report';
            compteTva:='44586'
            end;
         21:begin //Cloture-Charges
            sens1:='Credit_Base';
            Qte1:='Qt2_Base';
            sens2:='Debit_Base';
            Qte2:='Qt1_Base';
            compteTva:='44586'
            end;
         12:begin //ouverture-Produits
            sens1:='Debit_Report';
            Qte1:='Qt1_Report';
            sens2:='Credit_Report';
            Qte2:='Qt2_Report';
            compteTva:='44587'
            end;
         22:begin //Cloture-Produits
            sens1:='Debit_Base';
            Qte1:='Qt1_Base';
            sens2:='Credit_Base';
            Qte2:='Qt2_Base';
            compteTva:='44587'

            end;
         end;//fin du case
   end;//fin du with
end;

//fini la transaction, récupère l'ID de la dernière ligne de la grille, filtre la grille en fonction
//du nouvel enregistrement écrit et mise à zéro des variables temporaires
procedure TDMChargeAPayer.TaChAPayerAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
DataChAPayer.OnStateChange(TaChAPayer);
InitialisationVariablesTemp;
MessDerSub:=true;
end;

//Rempli les variables temporaires avant la modification, envoie un message de 
confirmation
//si la charges dépend d'une OD,
procedure TDMChargeAPayer.TaChAPayerBeforeEdit(DataSet: TDataSet);
var
   messagetmp: String;
begin
if inttostr(self.Tag) < inttostr(2) then
if VerifSiCompteSaisieDsBO(CompteChargeOuProduit,true,DataSet) then
  begin
    abort;  //Compte déjà utilisé dans BO
  end;
      //Prépare un message suivant si la modif porte sur une charge ou un produit
      Case self.Tag Of
      11,21: messagetmp := 'Attention, la reprise de cette charge à payer a été effectuée 
!!!'+#10#13+'La modification de cette charge à payer entraînera la modification de l''OD de 
reprise et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de cette charge 
à payer ?';
      12,22: messagetmp := 'Attention, la reprise de ce produit à recevoir a été effectuée 
!!!'+#10#13+'La modification de ce produit à recevoir entraînera la modification de l''OD de 
reprise et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de ce produit à 
recevoir ?';
      End; // Fin du Case

      // Si le compte possède une OD, envoie du message de confirmation
      If DMChargeAPayer.TaChAPayerReference.AsString <> '' Then
           If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
                abort;
//mise à zéro des variables temporaires
InitialisationVariablesTemp;
//remplissages des variables temporaires avant modification
TvaTmp:=TaChAPayerTVA.AsFloat;
Compte2Tmp:=TaChAPayerCompte2.AsString;
CompteTmp:=TaChAPayerCompte.AsString;
MontantTmp:=TaChAPayerMontantHT.AsCurrency;
TTCTmp:=TaChAPayerMontantHT.AsCurrency+TaChAPayerTVA.AsCurrency;
QteTmp:=TaChAPayerQte.AsFloat;
DesignationTmp:=TaChAPayerLibelle2.AsString;
ref:=TaChAPayerReference.AsString;
end;


//Prépare un message de confirmation de suppression si la charge ou le produit dépend 
d'une
//OD, mise à zéro des variables temporaires et remplissage de ces variables avant 
suppression
//commence une transaction

procedure TDMChargeAPayer.TaChAPayerBeforeDelete(DataSet: TDataSet);
var
   messagetmp: String;
begin
      Case self.Tag Of
      11,21:begin
            if empty(TaChAPayerReference.AsString) then
            messagetmp :='Êtes-vous sûr de supprimer cette charge à payer ?'
            else
            messagetmp :='Attention, la reprise de cette charge à payer a été effectuée 
!!!'+#10#13+'La suppression de cette charge à payer entraînera la suppression de l''OD de 
reprise et la mise à jour de la balance !!!'+#10#13+'Confirmer la suppression de cette charge 
à payer ?';
            end;
      12,22:begin
            if empty(TaChAPayerReference.AsString) then
            messagetmp :='Êtes-vous sûr de supprimer ce produit à recevoir ?'
            else
            messagetmp := 'Attention, la reprise de ce produit à recevoir a été éffectuée 
!!!'+#10#13+'La modification de ce produit à recevoir entraînera la modification de l''OD de 
reprise et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de ce produit à 
recevoir ?';
            end;
      End; // Fin du Case
      If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
        abort
      else
      begin
      //mise à zéro des variables temporaires
      InitialisationVariablesTemp;
      //remplissages des variables temporaires avant suppression
      TvaTmp:=TaChAPayerTVA.AsFloat;
      Compte2Tmp:=TaChAPayerCompte2.AsString;
      CompteTmp:=TaChAPayerCompte.AsString;
      MontantTmp:=TaChAPayerMontantHT.AsCurrency;
      TTCTmp:=TaChAPayerMontantHT.AsCurrency+TaChAPayerTVA.AsCurrency;
      QteTmp:=TaChAPayerQte.AsFloat;
      DesignationTmp:=TaChAPayerLibelle2.AsString;
      ref:=TaChAPayerReference.AsString;
      LaisserPasser:=false;

      //Début de transaction
      TableGereStartTransaction(TaChAPayer);
      if not(empty(ref)) then
         begin//si la charge ou produit à une OD
            try
              DMPieces.SuppressionOD(ref);//suppression de l'OD
            except
              showmessage('Problème à la suppression d''une charge');
              abort;
            end;//fin du try
         end;// fin si la charge ou produit à une OD
         try
           //Mise à jour de la balance d'ouverture en soustraction
           TraitementMAJBalance(self.tag,true,dsBrowse,ref);
         except
         //si problème, annule toutes les écritures (Suppression OD, MAJ Balance,suppression 
charge)
         TableGereRollback(DataSet);
         TableGereRollback(DMPieces.TaPiece);
         showmessage('Problème à la Mise A Jour de la balance après une suppression d''OD 
');
         abort;
         end;//fin du try
      end;
end;


//fini la transaction, récupère l'ID de la dernière ligne de la grille, déclenche un
//changement d'Etat pour gérer les boutons, mise à zéro des variables temporaires
procedure TDMChargeAPayer.TaChAPayerAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
DataChAPayer.OnStateChange(TaChAPayer);
InitialisationVariablesTemp;
end;


//empèche la suppression d'une charge ou d'un produit dans fenêtre de reprise
procedure TDMChargeAPayer.TaChAPayer3BeforeDelete(DataSet: TDataSet);
begin
abort;
end;


//vérifie la saisie de la date de reprise dans E2_repriseChargesAPayer_Isa ,ouvre une 
transaction
//supprime l'OD si date enlevé, modifie l'OD si date modifiée
procedure TDMChargeAPayer.TaChAPayer3BeforePost(DataSet: TDataSet);
var
messages:string;
begin
messages:='Problème à la suppression ou la modification de l''OD ';
   try
   VerifSaisieFeuilleReprise1(TaChAPayer3Date_Piece);
   except
   abort;
   end;
   TableGereStartTransaction(DataSet);
   if TaChAPayer3.State = dsedit then
   try
     if (datepiece<>TaChAPayer3Date_Piece.AsDateTime) and 
(not(empty(TaChAPayer3Reference.AsString))) then
       if empty(TaChAPayer3Date_Piece.asstring) then
         begin
         if application.MessageBox(Pchar('Attention, la suppression de la date entraînera la 
suppression de l''OD de reprise et la modification de la balance !!!'+#10#13+'Confirmer la 
suppression de la date ?'),'Confirmation',MB_YESNO+MB_DEFBUTTON1)=mryes then
             Begin
               DMPieces.SuppressionOD(TaChAPayer3Reference.AsString);
               TaChAPayer3Reference.AsString:='';
               TaChAPayer3Date_Piece.Asstring:='';
               TaChAPayer3DateSysteme.AsDateTime:=now;
             end
           Else
             begin
               TaChAPayer3.Cancel;
               messages:='';
               abort;
             end;
         end
       else
         begin
         if application.MessageBox(Pchar('Attention, la modification de la date entraînera la 
modification de l''OD de reprise et la modification de la balance !!!'+#10#13+'Confirmer la 
modification de la date ?'),'Confirmation',MB_YESNO+MB_DEFBUTTON1)=mryes then
             Begin
               DMPieces.ModificationDatePiece(TaChAPayer3Reference.AsString,TaChAPayer
3Date_Piece.asdatetime);
             end
           Else
             begin
               TaChAPayer3.Cancel;
               messages:='';
               abort;
             end;
         end;
   except
   TableGereRollBack(DataSet);
   TableGereRollBack(DMPieces.TaPiece);
   if not empty(messages)then
     showmessage(messages);
   TaChAPayer3.Refresh;
   abort;
   end;//fin du try
end;

//remplissage d'une variable temporaire avant modification
procedure TDMChargeAPayer.TaChAPayer3BeforeEdit(DataSet: TDataSet);
begin
datepiece:=TaChAPayer3Date_Piece.AsDateTime;
end;


//empèche l'insertion d'une charge ou d'un produit dans fenêtre de reprise
procedure TDMChargeAPayer.TaChAPayer3BeforeInsert(DataSet: TDataSet);
begin
abort;
end;

//filtre les charges ou produits de clôture qui ne sont pas repris
procedure TDMChargeAPayer.Filtrage_EcriturePourNouvelExo(var 
tMem:TRxMemoryData;NouvelleDate:Tdatetime);
var
Filtre:string;
begin
   try
   //filtre les charges ou produits de clôture
   Filtre:=TaChAPayer.Filter;
   if TaChAPayer.active=false then
     TaChAPayer.open;
   TaChAPayer.Filtered:=false;
   TaChAPayer.Filter:='';
   TaChAPayer.filter:=('DateSaisie='''+datetostr(E.DatExoFin)+'''');
   TaChAPayer.Filtered:=true;

   if TaChAPayer.RecordCount<>0 then
      begin
      tMem.LoadFromDataSet(TaChAPayer,0,lmCopy);
      tMem.First;
      while not(tMem.EOF) do
         begin
         //change la date de saisie avec la nouvelle date d'Exo
         tMem.edit;
         tMem.FindField('DateSaisie').AsDateTime:=NouvelleDate;
         tMem.FindField('DateSysteme').AsDateTime:=now;
         tMem.FindField('Date_Piece').Asstring:='';
         tMem.FindField('Reference').Asstring:='';
         tMem.FindField('Id_Piece').Asstring:='';
         tMem.Post;
         TaChAPayer.FlushBuffers;
         tMem.Next;
         end;
      end;
   except
   showmessage('Problème à l''écriture dans la nouvelle table '+TaChAPayer.tableName);
   abort;
   end;//fin du try
end;


//si erreur à l'enregistrement de la charge ou du produit, annule toutes les écritures
//(MAJ balance, Suppression ou Modif d'OD, enregistrement de la charges)
procedure TDMChargeAPayer.TaChAPayerPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;


//si erreur à la suppression de la charge ou du produit, annule toutes les écritures
//(MAJ balance, Suppression OD, suppression de la charges)
procedure TDMChargeAPayer.TaChAPayerDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;


//Récupére les paramètres du compte de reprise séléctionné, et en fonction de ces 
paramètres
//initialise certains champs comme la Quantité ou la tva, si champ libellé vide, le remplie par
//défaut avec le libellé du compte
procedure TDMChargeAPayer.RecupInfoApresVerif(Tout:boolean);
var
RetourEnregistrement:TEnregistrementComplet;
begin
   //Récupère tous les paramètres d'un compte
   RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaChAPayerCompte2.AsStri
ng);
       if empty(RetourEnregistrement.Un1) then//si pas de paramètre Quantité
       begin
       if TaChAPayer.Fields[4].ReadOnly=false then
       TaChAPayer.Fields[4].asstring:='';
       TaChAPayer.Fields[4].ReadOnly:=true;
       end
       else
       TaChAPayer.Fields[4].ReadOnly:=false;//si paramètre Quantité
       ////////////////////////////
       if empty(RetourEnregistrement.TvaCode) then//si pas de paramètre TVA
       begin
       if TaChAPayer.Fields[10].ReadOnly=false then
       TaChAPayer.Fields[10].asstring:='';
       TaChAPayer.Fields[10].ReadOnly:=true;
       end
      else
       TaChAPayer.Fields[10].ReadOnly:=false;//si paramètre TVA
       ///////////////////////
       if tout then
       begin
          if not(empty(RetourEnregistrement.Libelle)) then //Si paramètre libellé
          begin
             if (empty(TaChAPayerLibelle2.AsString)) then//si libellé de la grille vide
             TaChAPayerLibelle2.AsString:=RetourEnregistrement.Libelle
             //remplir par défaut avec le libellé
             else //si libellé de la  grille pas vide, vérifie que le libellé ne correspond
             //pas au libellé de l'ancien compte saisie
               if (TaChAPayerLibelle2.AsString=trim(dernierlibelle)) then
               TaChAPayerLibelle2.AsString:=RetourEnregistrement.Libelle;
               DernierLibelle:=RetourEnregistrement.Libelle;
          end;
       end;
 end;

//Récupère les paramètres du compte de reprise séléctionné. Si paramètre TVA trouvé, 
vérifie
// la cohérence du montant tva saisie avec le montant calculé en fonction des taux 
récupéré
//si le montant saisi ne rentre pas dans la fourchette calculée, envoie d'un message et de la
//fenêtre ''AideMontantTTC''pour aider l'utilisateur à saisir son montant TVA
procedure TDMChargeAPayer.VerifTVA;
var
RetourTva:TRecupMiniMaxTva;
resultat:TAideMontantTTC2RetFunction;
RetourEnregistrement:TEnregistrementComplet;
Tva:currency;
Recuperer:boolean;
begin//si champ TVA rempli
Recuperer:=true;
resultat.Retour:=true;
             //Récupère tous les paramètres d'un compte
             RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaChAPayerCompte2
.AsString);
             if RetourEnregistrement.CodeRetour then
                begin//si le compte a été trouvé
                   if not(empty(RetourEnregistrement.TvaCode))then
                   begin //si il y a un code tva
                   //récupère les paramètre du codeTva trouvé dans les paramètre du compte
                   RetourTva:=FTvaRecupMiniMaxTva(RetourEnregistrement.TvaCode);
                   case retourtva.CodeRetour of  //vérifie que la tva saisie rentre dans la 
fourchette
                   //des calculs fais à partir des taux récupérés
                   1:begin //le calcul porte sur 1 seul taux (Taux_Inf)
                       if 
calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA<>TaChAPay
erTVA.AsCurrency then
                       begin
//                       Messagedlg('Le taux de TVA est incohérent !!!',MtWarning,[mbok],0);
                       if application.MessageBox(Pchar('Le taux de TVA est incohérent, voulez-
vous continuer ?'),'Attention',MB_ICONWARNING 
+MB_YESNO+MB_DEFBUTTON2)=mryes then
                       Recuperer:=false
                       else
                       resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaChAPayerMontantHT.
AsCurrency,TaChAPayerTVA.AsCurrency],4,True,[TaChAPayerTVA],[4],E.DeviseSigle[1]);
                       end
                       else
                       Recuperer:=false;
                     end;
                   2:begin //le calcul porte sur 1 seul taux (Taux_Supp)
                       if 
calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA<>TaChAP
ayerTVA.AsCurrency then
                       begin
//                       Messagedlg('Le taux de TVA est incohérent !!!',MtWarning,[mbok],0);
                       if application.MessageBox(Pchar('Le taux de TVA est incohérent, voulez-
vous continuer ?'),'Attention',MB_ICONWARNING 
+MB_YESNO+MB_DEFBUTTON2)=mryes then
                       Recuperer:=false
                       else
                       resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,TaChAPayerMontantH
T.AsCurrency,TaChAPayerTVA.AsCurrency],4,True,[TaChAPayerTVA],[4],E.DeviseSigle[1])
;
//                       
resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,
TaChAPayerTVA.AsFloat]);
                       end
                       else
                       Recuperer:=false;
                     end;
                  12:begin //le calcul porte sur 2 taux (Taux_Inf et taux_Supp)
                       if 
(calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA>DMCharge
APayer.TaChAPayerTVA.AsCurrency)or
                        (calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,13)
.TVA<TaChAPayerTVA.AsCurrency)then
                       begin
                       if application.MessageBox(Pchar('Le taux de TVA est incohérent, voulez-
vous continuer ?'),'Attention',MB_ICONWARNING 
+MB_YESNO+MB_DEFBUTTON2)=mryes then
                        Recuperer:=false
                       else
                       resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaChAPayerMontantHT.
AsCurrency,TaChAPayerTVA.AsCurrency,retourtva.Taux_Supp,0,DMChargeAPayer.TaChA
PayerMontantHT.AsCurrency,DMChargeAPayer.TaChAPayerTVA.AsCurrency],4,True,[TaC
hAPayerTVA],[4],E.DeviseSigle[1]);
//                       
resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,Ta
ChAPayerTVA.AsFloat,retourtva.Taux_Supp,0,DMChargeAPayer.TaChAPayerMontantHT.
AsCurrency,DMChargeAPayer.TaChAPayerTVA.AsFloat]);
                       end
                       else
                       Recuperer:=false;
                     end;
                   0:begin //le calcul porte sur 1 seul taux (Taux_Inf)
                       if application.MessageBox(Pchar('Le code de TVA 
'''''+RetourEnregistrement.TvaCode+''''' n''est lié à aucun taux, Etes-vous sûr de vouloir 
continuer ?'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mryes 
then
                         Recuperer:=false
                       else
                         begin
                           resultat.HT:=TaChAPayerMontantHT.AsCurrency;
                           resultat.TVA:=0;
                         end;
                     end;
                   end;//fin du case retourTva

                   /////Si erreur de saisie rencontrée et nouveaux montants tva récupérés
                   if (Recuperer) and (resultat.Retour) then
                   begin
                      TaChAPayer.Fields[5].AsCurrency:=resultat.HT;
                      TaChAPayer.Fields[10].AsCurrency:=resultat.TVA;
                       case retourtva.CodeRetour of
                      1:begin
                          if 
calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA>TaChAPaye
rTVA.AsFloat then
                            if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer 
votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;
                        end;
                      2:begin
                          if 
calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA<TaChAPa
yerTVA.AsFloat then
                          if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer 
votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;                     end;
                     12:begin
                          if 
(calcultva(retourtva.Taux_Inf,0,TaChAPayerMontantHT.AsCurrency,0,13).TVA>DMCharge
APayer.TaChAPayerTVA.AsFloat)or
                           (calcultva(retourtva.Taux_Supp,0,TaChAPayerMontantHT.AsCurrency,0,1
3).TVA<TaChAPayerTVA.AsFloat)then
                          if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer 
votre choix',MtWarning,[mbyes,mbno],0)=mrno then
                            abort;
                        end;
                      end;//fin du case retourTva
                   end
                   else
                   if resultat.Retour=false then
                    if Messagedlg('Le taux de TVA est incohérent !!! Voulez-vous confirmer votre 
choix',MtWarning,[mbyes,mbno],0)=mrno then
                      abort;
                   end;
                end;//fin si le compte a été trouvé
end;

//ferme la transaction
procedure TDMChargeAPayer.TaChAPayer3AfterPost(DataSet: TDataSet);
begin
//TaChAPayer3.Database.Commit;
end;

//si erreur, annule toutes les écritures(MAJ Balance, enregistrement date,
//modification ou suppression d'OD)
procedure TDMChargeAPayer.TaChAPayer3PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMChargeAPayer.FiltreVide;
Begin
FiltrageDataSet(TaChAPayer,CreeFiltreEt(['ID'],['-1']));
End;

procedure TDMChargeAPayer.TaChAPayerBeforeInsert(DataSet: TDataSet);
begin
  dataset.Fields[8].focuscontrol;
if inttostr(self.Tag) < inttostr(2) then
if VerifSiCompteSaisieDsBO(CompteChargeOuProduit,true,DataSet) then
  begin
    abort;  //Compte déjà utilisé dans BO
  end;
LaisserPasser:=false;  
end;


function TDMChargeAPayer.VerifRepriseChargesOuverture_OK(var 
messageTmp:string):boolean;
Begin
  result:=false;
  try
   result:=VerifExistChargesAPayerOuvertureAReprendre(messagetmp,false);
     if not result then
         messageTmp:='Toutes Les Charges à Payer ou Produits à Recevoir d''ouverture n''ont 
pas été repris.'+#10#13#10#13+'Voulez-vous les reprendre avant la clôture définitive ?'
      else
         messageTmp:='OK';         
  except
   showmessage('problème lors de la vérification des reprises de Charges à Payer et Produits 
à Recevoir d''ouverture');
   abort;
  end;
End;

function TDMChargeAPayer.VerifExistChargesAPayerOuverture(var 
messageTmp:string;Mess:boolean):boolean;
Begin
  try
     if not TaRechercheChAPayer.Active then
       TaRechercheChAPayer.open;
     TaRechercheChAPayer.Filtered := False;
     TaRechercheChAPayer.Filter := ('DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 
1)+'''');
     TaRechercheChAPayer.Filtered := True;
     result:= TaRechercheChAPayer.RecordCount<>0 ;
      if ((not result)and(mess)) then
         messageTmp:='Aucune Charge à Payer ou Produit à Recevoir d''ouverture n''ont été 
saisis'
      else
         messageTmp:='OK';
  except
   showmessage('problème lors de la vérification de l''existence des Charges à Payer et 
Produits à Recevoir d''ouverture');
   abort;
  end;
End;

function TDMChargeAPayer.VerifExistChargesAPayerCloture(var 
messageTmp:string;Mess:boolean):boolean;
Begin
  try
     if not TaRechercheChAPayer.Active then
       TaRechercheChAPayer.open;
     TaRechercheChAPayer.Filtered := False;
     TaRechercheChAPayer.Filter := ('DateSaisie = '''+DateTimeToStr(E.DatExofin)+'''');
     TaRechercheChAPayer.Filtered := True;
     result:= TaRechercheChAPayer.RecordCount<>0;
      if ((not result)and(mess)) then
         messageTmp:='Aucune Charge à Payer ou Produit à Recevoir de clôture n''ont été 
saisis'
      else
         messageTmp:='OK';
  except
   showmessage('problème lors de la vérification de l''existence des Charges à Payer et 
Produits à Recevoir de clôture');
   abort;
  end;
End;


function TDMChargeAPayer.VerifExistChargesAPayerOuvertureAReprendre(var 
messageTmp:string;Mess:boolean):boolean;
Begin
  try
     if not TaRechercheChAPayer.Active then
       TaRechercheChAPayer.open;
     TaRechercheChAPayer.Filtered := False;
     TaRechercheChAPayer.Filter := ('Date_Piece=null and DateSaisie = 
'''+DateTimeToStr(E.DatExoDebut - 1)+'''');
     TaRechercheChAPayer.Filtered := True;
     result:= TaRechercheChAPayer.RecordCount=0 ;
      if ((not result)and(mess)) then
         messageTmp:='Il reste des Charges à Payer ou des Produits à Recevoir d''ouverture à 
reprendre'
      else
         messageTmp:='OK';
  except
   showmessage('problème lors de la vérification de l''existence des reprises des Charges à 
Payer et Produits à Recevoir d''ouverture');
   abort;
  end;
end;
procedure TDMChargeAPayer.TaChAPayerAfterScroll(DataSet: TDataSet);
begin
if ((DataSet.State = dsBrowse) and (not varisNull(DataSet['Compte2']))) then

TaChAPayerTVA.ReadOnly:=empty(DMPlan.CodeDeTvaDuCompte(DataSet['Compte2']))
else TaChAPayerTVA.ReadOnly:=false;
end;


procedure TDMChargeAPayer.TraitementCloture2000(sender:Tobject);
Begin
main.Chargespayeretproduitsrecevoir2Click(main.Chargespayeretproduitsrecevoir2);
End;


procedure 
TDMChargeAPayer.CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
var
OD:string;
ListeOd:TStringList;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
tab:variant;
ValPieceAutoGen:TValPieceAutoGenere;
compteTvaTemp:string;
Begin
   try
     try
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoFin;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=TableEnCours.findfield('Libelle2').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('Sens').AsString='C' then
//       if copy(TableEnCours.findfield('Compte2').AsString,1,1)='6' then //si l'OD concerne 
une charge
          begin
          //remplissage de 2 lignes pour l'OD avec peut-être de la TVA
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCour
s.findfield('Compte2').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,-
TableEnCours.findfield('MontantHT').AsCurrency,-
TableEnCours.findfield('TVA').AsCurrency,'44586','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCour
s.findfield('Compte').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,MontantTTC,0,'','',0,'',''
],true,false,-1);
          end
        else
//        if copy(TableEnCours.findfield('Compte2').AsString,1,1)='7' then //si l'OD concerne 
un produit
       if TableEnCours.findfield('Sens').AsString='D' then
          Begin
          //remplissage de 2 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCour
s.findfield('Compte2').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfiel
d('MontantHT').AsCurrency,TableEnCours.findfield('TVA').AsCurrency,'44587','',0,'',''],true,fal
se,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCour
s.findfield('Compte').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,-
MontantTTC,0,'','',0,'',''],true,false,-1);
          End;

       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Imp
ort.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
     Begin
        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
     End;
   end;//fin du try finally
End;




procedure 
TDMChargeAPayer.CreationODReprise_avecObjet(TableEnCours:TTable;ODModif:string);
var
OD:string;
ListeOd:TStringList;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
tab:variant;
ValPieceAutoGen:TValPieceAutoGenere;
compteTvaTemp:string;
Begin
   try
     try
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=TableEnCours.findfield('Date_Piece').AsDateTime;;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=TableEnCours.findfield('Libelle2').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('Sens').AsString='C' then
//       if copy(TableEnCours.findfield('Compte2').AsString,1,1)='6' then //si l'OD concerne 
une charge
          begin
          //remplissage de 2 lignes pour l'OD avec peut-être de la TVA
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCour
s.findfield('Compte2').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfiel
d('MontantHT').AsCurrency,TableEnCours.findfield('TVA').AsCurrency,'44586','',0,'',''],true,fal
se,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCour
s.findfield('Compte').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,-
MontantTTC,0,'','',0,'',''],true,false,-1);
          end
        else
       if TableEnCours.findfield('Sens').AsString='D' then
//        if copy(TableEnCours.findfield('Compte2').AsString,1,1)='7' then //si l'OD concerne 
un produit
          Begin
          //remplissage de 2 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCour
s.findfield('Compte2').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,-
TableEnCours.findfield('MontantHT').AsCurrency,-
TableEnCours.findfield('TVA').AsCurrency,'44587','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCour
s.findfield('Compte').asstring,'','',TableEnCours.findfield('Qte').asfloat,0,MontantTTC,0,'','',0,'',''
],true,false,-1);
          End;
//       
DMImport.ExecutionDuFiltrageAideCompteSuivantContexte(DMChargeAPayer,SourcePiece
);

       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Imp
ort.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
     Begin
        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
     End;
   end;//fin du try finally
End;


//procedure TDMChargeAPayer.FiltrageAideCompteGeneral;
//begin
//// FiltrageAideCompte(
//end;


procedure TDMChargeAPayer.TaChAPayerCalcFields(DataSet: TDataSet);
begin
TaChAPayerReprise.AsBoolean:=not empty(DataSet.FindField('Reference').AsString);
end;

Procedure TDMChargeAPayer.ImportChAPayer(Valeurs:array of const;DataSet:TDataSet);
var
ErreurSaisie:TExceptLGR;
Begin
// On effectue un controle sur le tag du DataModule qui doit être en bonne position
// Pour être certain que les bons traitements se feront
  case self.Tag of
  11:begin//si ouverture et charges à payer
      try
       CompteChargeOuProduit:=string(valeurs[1].VAnsiString);
       ImportTable(Valeurs,DataSet);
      except
       abort;
      end;
     end;
  12:begin//si ouverture et produits à recevoir
      Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des 
Charges à Payer',0,true,mtError,ErreurSaisie);
     end;
  21,22:begin//si clôture
         Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des 
Charges à Payer',0,true,mtError,ErreurSaisie);
        end;
  end;
End;

Procedure TDMChargeAPayer.ImportPrARecevoir(Valeurs:array of 
const;DataSet:TDataSet);
var
ErreurSaisie:TExceptLGR;
Begin
// On effectue un controle sur le tag du DataModule qui doit être en bonne position
// Pour être certain que les bons traitements se feront
  case self.Tag of
  11:begin//si ouverture et charges à payer
      Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des 
Produits à Recevoir',0,true,mtError,ErreurSaisie);
     end;
  12:begin//si ouverture et produits à recevoir
      try
       CompteChargeOuProduit:=string(valeurs[1].VAnsiString);
       ImportTable(Valeurs,DataSet);
      except
       abort;
      end;
     end;
  21,22:begin//si clôture
         Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des 
Produits à Recevoir',0,true,mtError,ErreurSaisie);
        end;
  end;
End;

procedure TDMChargeAPayer.BtnImprimerClick(Sender: TObject);


Begin

//

End;
procedure TDMChargeAPayer.BtnDetailClick(Sender: TObject);


Begin

//

End;
procedure TDMChargeAPayer.BtnImprimerClick(Sender: TObject);


Begin

//

End;
procedure TDMChargeAPayer.BtnDetailClick(Sender: TObject);


Begin

//

End;
end.
