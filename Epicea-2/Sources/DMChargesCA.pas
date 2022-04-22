unit DMChargesCA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  LibSQL,
  DMBalances,
  DMPiece,
  E2_ChargesCA_Isa,
  DMClotures,
  RxMemDS,
  E2_Decl_Records,
  LibDates,
  DMRecherche,
  editions,
  shellapi,
  ObjetEdition,
  LibRessourceString,
  lib_chaine,
  E2_VisuListeView,
  DMTVA;


type
  TParamDMChargeCA=Record
   Quoi,Quand:Integer;
   ChargeCADataStateChange:TNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
  end;

  TInfosDMChargeCA=Record
    Retour:Boolean;
    NbChargeCAOuverture:Integer;
    ResteChargeCAOuvertureAReprendre:Boolean;
    NbChargeCAOuvertureAReprendre:Integer;
    NbChargeCACloture:Integer;
   end;

//ce record sert à recupérer les paramètres de Mise à jour de la balance après l'enregistrement
//ou la suppression d'une charge à payer ou d'un produit à recevoir
     TRecupParametres=record
     sens1,sens2,sens3,sens4:string;
     Qte1,Qte2,Qte3,Qte4:string;
     compteTva:string;
     end;
  TDMChargeCA = class(TDataModule)
    TaPCA: TTable;
    TaPCAID: TIntegerField;
    TaPCACompte: TStringField;
    TaPCASens: TStringField;
    TaPCAQte: TFloatField;
    TaPCAMontantHT: TCurrencyField;
    TaPCADateSaisie: TDateField;
    TaPCADateExercice: TDateField;
    TaPCACompte2: TStringField;
    TaPCADateSysteme: TDateTimeField;
    TaPCADate_Piece: TDateField;
    TaPCAReference: TStringField;
    DataPCA: TDataSource;
    DataPCA2: TDataSource;
    TaPCA2: TTable;
    DataDesignation: TDataSource;
    TaPCA3: TTable;
    DataPCA3: TDataSource;
    TaPCA2ID: TIntegerField;
    TaPCA2Compte: TStringField;
    TaPCA2Sens: TStringField;
    TaPCA2Qte: TFloatField;
    TaPCA2MontantHT: TCurrencyField;
    TaPCA2DateSaisie: TDateField;
    TaPCA2DateExercice: TDateField;
    TaPCA2Compte2: TStringField;
    TaPCA2DateSysteme: TDateTimeField;
    TaPCA2Date_Piece: TDateField;
    TaPCA2Reference: TStringField;
    TaPCA3ID: TIntegerField;
    TaPCA3Compte: TStringField;
    TaPCA3Sens: TStringField;
    TaPCA3Qte: TFloatField;
    TaPCA3MontantHT: TCurrencyField;
    TaPCA3DateSaisie: TDateField;
    TaPCA3DateExercice: TDateField;
    TaPCA3Compte2: TStringField;
    TaPCA3DateSysteme: TDateTimeField;
    TaPCA3Date_Piece: TDateField;
    TaPCA3Reference: TStringField;
    QueryDesignation: TQuery;
    QueryDesignationCompte2: TStringField;
    QueryDesignationCompte: TStringField;
    QueryDesignationId: TIntegerField;
    TaPCALibelle: TStringField;
    TaPCALibelle2: TStringField;
    TaPCA2Libelle: TStringField;
    TaPCA2Libelle2: TStringField;
    TaPCA3Libelle: TStringField;
    TaPCA3Libelle2: TStringField;
    QueryDesignationLibelle2: TStringField;
    TaPCAEcritureReference: TTable;
    TaPCAReprise: TBooleanField;
    QuChargeCAEdition: TQuery;
    QuListeValRupt: TQuery;
    QuSousTotal: TQuery;
    QuTotalG: TQuery;
    procedure DMChargeCACreate(Sender: TObject);
    procedure DMChargeCADestroy(Sender: TObject);
    procedure FiltrageAffichageGrille(Tag_bis:integer);
    Function  CtrlSaisieChargesCA(CCourant:Tfield):TErreurSaisie;
    procedure TaPCAAfterPost(DataSet: TDataSet);
    procedure TaPCABeforePost(DataSet: TDataSet);
    procedure TaPCABeforeEdit(DataSet: TDataSet);
    procedure TaPCABeforeDelete(DataSet: TDataSet);
    procedure TaPCAAfterDelete(DataSet: TDataSet);
    function  RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
    procedure TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;EtatTaPCA:TDataSetState;Ref:string);
    function CreationListeOD(DateExo:TDateTime;sens:string):TStringList;
    procedure DemandeAffichageReprise;
    procedure CreationODChargeCAReprise;
    procedure CreationODChargeCACloture;
    Procedure EcritureReference(ID:integer;date:boolean;Ref:string);
    procedure FiltragePourOuvertureReprise1(sens:string);
    procedure VerifSaisieFeuilleReprise1(cCourant:tfield);
    procedure TaPCA3BeforeDelete(DataSet: TDataSet);
    procedure TaPCA3BeforePost(DataSet: TDataSet);
    procedure TaPCA3BeforeEdit(DataSet: TDataSet);
    procedure TaPCA3BeforeInsert(DataSet: TDataSet);
    procedure InitialisationVariablesTemp;
    procedure Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
    procedure TaPCAPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure RecupInfoApresVerif(tout:boolean);
    procedure TaPCA3AfterPost(DataSet: TDataSet);
    procedure TaPCA3PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaPCADeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaPCABeforeInsert(DataSet: TDataSet);
    // Procedure branché lorsque E.AccesCloture = false et/ou E.AccesOuverture = false
    procedure TaPCABeforeEIDOuv_Abort(DataSet: TDataSet);
    procedure TaPCABeforeEIDClo_Abort(DataSet: TDataSet);

    Procedure TraitementCloture3000(sender:Tobject);
    procedure CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure CreationODReprise_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure TaPCACalcFields(DataSet: TDataSet);
    procedure GestionAccesChargesCA;

    procedure GestionFiltrageAideCompte(sender:tobject);

  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;
    QuandQuoi:Integer;
  public
    { Déclarations publiques }
    CompteDeChargeOuDeProduit:string;
    LibelleCompteDeChargeOuDeProduit:string;
    LaisserPasser:boolean;
    Quand,Quoi:Integer;
    ListeEditCompte,ListeEditCompte2:TStringList;
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
    Procedure ImportChCAvance(Valeurs:array of const;DataSet:TDataSet);
    Procedure ImportPrCAvance(Valeurs:array of const;DataSet:TDataSet);
    procedure QuChargeCAFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  end;

var
  DMChargeCA: TDMChargeCA;
  CompteEdit:string;
  TvaTmp,QteTmp:real;
  MontantTmp: Currency;
  CompteTmp,Compte2Tmp,DesignationTmp,Ref: String;
  DatePiece:Tdatetime;
  Mark: TBookMark;
  dernierlibelle:string;
  MessDerSub:boolean;
  Function InitialiseDMChargeCA(ParamDMChargeCA:TParamDMChargeCA):TInfosDMChargeCA;
  Function EditionChargeCA(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;

    function VerifRepriseChargesCAOuverture_OK(var messageTmp:Tmessages):boolean;
    function VerifExistChargesCAOuverture(var messageTmp:Tmessages;Mess:boolean):boolean;
    function VerifExistChargesCACloture(var messageTmp:Tmessages;Mess:boolean):boolean;
    function VerifExistChargesCAOuvertureAReprendre(var messageTmp:Tmessages;Mess:boolean):boolean;

    Function EditionChargeCAL(TypeEdition : integer; Quand, Quoi : integer; DataSet:TDataSet;Compte,compte2:String;Site:TEditLien):Boolean;overload;
    Function EditionChargeCAL(TypeEdition : integer; Quand, Quoi : integer; DataSet:TDataSet;ListeCompte,ListeCompte2:TStringList;Site:TEditLien):Boolean;overload;

implementation

uses DMPlanCpt,E2_AideCompte, E2_Main, DMImportation,DMBaseDonnee,
  DMChargesAPayer;
{$R *.DFM}

Function InitialiseDMChargeCA(ParamDMChargeCA:TParamDMChargeCA):TInfosDMChargeCA;
Begin
 if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 result.NbChargeCACloture:=0;
 result.NbChargeCAOuverture:=0;
 result.NbChargeCAOuvertureAReprendre:=0;
 result.ResteChargeCAOuvertureAReprendre:=false;

//   FiltrageDataSet(DMChargeCA.TaPCA,CreeFiltreET(['DateSaisie','Reference'],[DateToStr(E.DatExoDebut -1),'']));
//  if DMChargeCA.TaPCA.recordcount <> 0 then abort; // PB le 28/07/03 ( <> remplace = )
// except
//  Messagedlg('Attention !!!'+#10#13+'Toutes les Charges et Produits constatés d''avance de l''Ouverture n''ont pas été repris !!!',MtWarning,[mbok],0);
//  if application.MessageBox(Pchar('Attention !!!'+#10#13+'Toutes les Charges et Produits constatés d''avance de l''Ouverture n''ont pas été repris, voulez-vous continuer !!!'),'Suppression',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON2)=mrno then
//    begin
//      DeFiltrageDataSet(DMChargeCA.TaPCA);


 // Initialisation du QuoiQuand (remplace le tag)
 DMChargeCA.QuandQuoi := StrToInt_Lgr(inttostr(ParamDMChargeCA.Quand+1)+inttostr(ParamDMChargeCA.Quoi));
 DMChargeCA.Tag := DMChargeCA.QuandQuoi;
 DMChargeCA.Quand:=ParamDMChargeCA.Quand;
 DMChargeCA.Quoi := ParamDMChargeCA.Quoi;

 DMChargeCA.OnGEstInterfaceEvent := ParamDMChargeCA.GEstInterfaceEvent;
  case DMChargeCA.DataPCA.State of
    dsBrowse:Begin
              DMChargeCA.FiltrageAffichageGrille(DMChargeCA.QuandQuoi);
              DMChargeCA.DataPCA.OnStateChange:=ParamDMChargeCA.ChargeCADataStateChange;
             End;
    dsInsert,dsEdit:Begin

                    End;
  end;
End;

Function EditionChargeCA(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
ParamDMChargeCA:TParamDMChargeCA;
Begin
  Chemin :=E.RepertoireComptaWeb;
 if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.Create(Application.MainForm);
//ParamDMChargeCA.
//InitialiseDMChargeCA(ParamDMChargeCA)
 case Quand of
    C_Ouverture: case DMChargeCA.Tag of
                    11:NomFich:='ChargesCAOuv';
                    12:NomFich:='ProduitsCAOuv';
                 end;
    C_Cloture : case DMChargeCA.Tag of
                    21:NomFich:='ChargesCAClo';
                    22:NomFich:='ProduitsCAClo';
                end;
 end;

 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
   // Inutile dans ChargeRepartir pour l'instant
  end;
 case Quand of
    C_Ouverture:begin
                 DMChargeCA.QuListeValRupt.SQL.Clear;
                 DMChargeCA.QuListeValRupt.SQL.Add('select distinct compte from PCA.db where ');
                 DMChargeCA.QuListeValRupt.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                // DMChargeCA.QuListeValRupt.SQL.Add(' and compte='''+DMChargeCA.CompteDeChargeOuDeProduit+'''');
                 case DMChargeCA.Tag of
                    11:DMChargeCA.QuListeValRupt.SQL.Add(' and Sens=''D''');
                    12:DMChargeCA.QuListeValRupt.SQL.Add(' and Sens=''C''');
                 end;

                 DMChargeCA.QuListeValRupt.Open;
                               DMChargeCA.QuSousTotal.SQL.Clear;
                 DMChargeCA.QuSousTotal.Params.Clear;
                 DMChargeCA.QuSousTotal.SQL.Add('select sum(MontantHT) as MontantHT,0 ');
                 DMChargeCA.QuSousTotal.SQL.Add('from PCA.db where compte =:compte ');
                 DMChargeCA.QuSousTotal.SQL.Add('and DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMChargeCA.QuSousTotal.Params[0].DataType := ftString;
                 case DMChargeCA.Tag of
                    11:DMChargeCA.QuSousTotal.SQL.Add(' and Sens=''D''');
                    12:DMChargeCA.QuSousTotal.SQL.Add(' and Sens=''C''');
                 end;
                 DMChargeCA.QuSousTotal.Open;

                 DMChargeCA.QuTotalG.SQL.Clear;
                 DMChargeCA.QuTotalG.SQL.Add('select sum(MontantHT) as MontantHT,0 from PCA.db where ');
                 DMChargeCA.QuTotalG.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 case DMChargeCA.Tag of
                   11:DMChargeCA.QuTotalG.SQL.Add(' and Sens=''D''');
                    12:DMChargeCA.QuTotalG.SQL.Add(' and Sens=''C''');
                 end;
                 DMChargeCA.QuTotalG.Open;

                 DMChargeCA.QuChargeCAEdition.SQL.Clear;
                 DMChargeCA.QuChargeCAEdition.SQL.Add('Select * from PCA where ');
                 DMChargeCA.QuChargeCAEdition.SQL.Add('DateSaisie = '''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 case DMChargeCA.Tag of
                    11:DMChargeCA.QuChargeCAEdition.SQL.Add(' and Sens=''D''');
                    12:DMChargeCA.QuChargeCAEdition.SQL.Add(' and Sens=''C''');
                 end;
                 DMChargeCA.QuChargeCAEdition.Open;

                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := false;
                                     //case DMChargeCA.Tag of
                                        //11: EditChargeConstateesAvance(Chemin,NomFich,DMChargeCA.QuChargeCAEdition,'Compte',DMChargeCA.QuListeValRupt,DMChargeCA.QuSousTotal,DMChargeCA.QuTotalG,DateToStr(E.DatExoDebut),Site);
                                        //12: EditProduitConstatesAvance(Chemin,NomFich,DMChargeCA.QuChargeCAEdition,'Compte',DMChargeCA.QuListeValRupt,DMChargeCA.QuSousTotal,DMChargeCA.QuTotalG,DateToStr(E.DatExoDebut),Site);
                                     //end;
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := True;
                                     //LienEditC...
                                     //case DMChargeCA.Tag of
                                       // 11: EditChargeConstateesAvance(Chemin,NomFich,DMChargeCA.QuChargeCAEdition,'Compte',DMChargeCA.QuListeValRupt,DMChargeCA.QuSousTotal,DMChargeCA.QuTotalG,DateToStr(E.DatExoDebut),Site);
                                      //  12: EditProduitConstatesAvance(Chemin,NomFich,DMChargeCA.QuChargeCAEdition,'Compte',DMChargeCA.QuListeValRupt,DMChargeCA.QuSousTotal,DMChargeCA.QuTotalG,DateToStr(E.DatExoDebut),Site);
                                     //end;
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///'+Chemin+NomFich+'.xml'),nil,sw_show);
                                 End;
                 end;
                 DMChargeCA.QuListeValRupt.Close;
                 DMChargeCA.QuSousTotal.Close;
                 DMChargeCA.QuTotalG.Close;
                 DMChargeCA.QuChargeCAEdition.Close;
    end;

    C_Cloture: begin
                 DMChargeCA.QuListeValRupt.SQL.Clear;
                 DMChargeCA.QuListeValRupt.SQL.Add('select distinct compte from PCA.db where ');
                 DMChargeCA.QuListeValRupt.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
              //   DMChargeCA.QuListeValRupt.SQL.Add(' and compte='''+DMChargeCA.CompteDeChargeOuDeProduit+'''');
                case DMChargeCA.Tag of
                    21:DMChargeCA.QuListeValRupt.SQL.Add(' and Sens=''D''');
                    22:DMChargeCA.QuListeValRupt.SQL.Add(' and Sens=''C''');
                end;
                 DMChargeCA.QuListeValRupt.Open;

                 DMChargeCA.QuSousTotal.SQL.Clear;
                 DMChargeCA.QuSousTotal.Params.Clear;
                 DMChargeCA.QuSousTotal.SQL.Add('select sum(MontantHT) as MontantHT,0 ');
                 DMChargeCA.QuSousTotal.SQL.Add('from PCA.db where compte =:compte ');
                 DMChargeCA.QuSousTotal.SQL.Add('and DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 DMChargeCA.QuSousTotal.Params[0].DataType := ftString;
                 case DMChargeCA.Tag of
                    21:DMChargeCA.QuSousTotal.SQL.Add(' and Sens=''D''');
                    22:DMChargeCA.QuSousTotal.SQL.Add(' and Sens=''C''');
                 end;
                 DMChargeCA.QuSousTotal.Open;

                 DMChargeCA.QuTotalG.SQL.Clear;
                 DMChargeCA.QuTotalG.SQL.Add('select sum(MontantHT) as MontantHT,0 from PCA.db where ');
                 DMChargeCA.QuTotalG.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 case DMChargeCA.Tag of
                    21:DMChargeCA.QuTotalG.SQL.Add(' and Sens=''D''');
                    22:DMChargeCA.QuTotalG.SQL.Add(' and Sens=''C''');
                 end;
                 DMChargeCA.QuTotalG.Open;

                 DMChargeCA.QuChargeCAEdition.SQL.Clear;
                 DMChargeCA.QuChargeCAEdition.SQL.Add('Select * from PCA where ');
                 DMChargeCA.QuChargeCAEdition.SQL.Add('DateSaisie = '''+DateInfos(E.DatExoFin).DatePourSQLStr+'''');
                 case DMChargeCA.Tag of
                    21:DMChargeCA.QuChargeCAEdition.SQL.Add(' and Sens=''D''');
                    22:DMChargeCA.QuChargeCAEdition.SQL.Add(' and Sens=''C''');
                 end;
                 DMChargeCA.QuChargeCAEdition.Open;

                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := False;
//                                     case DMChargeCA.Tag of
//                                        21: EditChargeConstateesAvance(Chemin,NomFich,DMChargeCA.QuChargeCAEdition,'Compte',DMChargeCA.QuListeValRupt,DMChargeCA.QuSousTotal,DMChargeCA.QuTotalG,DateToStr(E.DatExoFin),Site);
//                                        22: EditProduitConstatesAvance(Chemin,NomFich,DMChargeCA.QuChargeCAEdition,'Compte',DMChargeCA.QuListeValRupt,DMChargeCA.QuSousTotal,DMChargeCA.QuTotalG,DateToStr(E.DatExoFin),Site);
//                                     end;
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := False;
                                     //LienEditC...
//                                     case DMChargeCA.Tag of
//                                        21: EditChargeConstateesAvance(Chemin,NomFich,DMChargeCA.QuChargeCAEdition,'Compte',DMChargeCA.QuListeValRupt,DMChargeCA.QuSousTotal,DMChargeCA.QuTotalG,DateToStr(E.DatExoFin),Site);
//                                        22: EditProduitConstatesAvance(Chemin,NomFich,DMChargeCA.QuChargeCAEdition,'Compte',DMChargeCA.QuListeValRupt,DMChargeCA.QuSousTotal,DMChargeCA.QuTotalG,DateToStr(E.DatExoFin),Site);
//                                     end;
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///'+Chemin+NomFich+'.xml'),nil,sw_show);
                                 End;
                 end;
                 DMChargeCA.QuListeValRupt.Close;
                 DMChargeCA.QuSousTotal.Close;
                 DMChargeCA.QuTotalG.Close;
                 DMChargeCA.QuChargeCAEdition.Close;
        end;
 end;
End;


//ouvre les tables et initialise certains champs
procedure TDMChargeCA.DMChargeCACreate(Sender: TObject);
begin
TaPCA.AfterScroll:=nil;

OuvrirTouteTable('',TControl(self));

TaPCACompte2.ValidChars := ['0'..'9'];
TaPCAMontantHT.DisplayFormat:=E.FormatMonnaie;
TaPCAMontantHT.EditFormat:='0.00 ;-0.00 ';

TaPCA3Compte2.ValidChars := ['0'..'9'];
TaPCA3MontantHT.DisplayFormat:=E.FormatMonnaie;
TaPCA3MontantHT.EditFormat:='0.00 ;-0.00 ';

TaPCAQte.ReadOnly:=true;
MessDerSub:=true;
ListeEditCompte:=TStringList.Create;
ListeEditCompte2:=TStringList.Create;
end;

//ferme les tables
procedure TDMChargeCA.DMChargeCADestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
ListeEditCompte.Free;
ListeEditCompte2.Free;
DMChargeCA:=nil;
end;


//vérifie la saisie dans la feuille E2_ReprisechargeCA
procedure TDMChargeCA.VerifSaisieFeuilleReprise1(cCourant:tfield);
begin
case CCourant.Index of
     11: Begin//TaChAPayer3Date_Piece
             If not(empty(ccourant.asstring)) Then
             Begin
//              ccourant.asstring:=AnneeDefaut(E.DatExoDebut,E.DatExoFin,ccourant.asstring).DateStr;
                  // Vérifier que la date saisie est dans l'année de l'exercice en cours
                  If ((CCourant.AsDateTime < E.DatExoDebut) Or (CCourant.AsDateTime > E.DatExoFin)) Then
                  Begin
                       Messagedlg('La date saisie doit appartenir à l''exercice courant !!!',mtWarning,[mbok],0);
                       Abort;
                  End;
             End;
     End;
End; // Fin du Case
end;


//filtre la grille de la feuille E2_ReprisechargeCA suivant si on veut afficher
//les charges ou les produits
procedure TDMChargeCA.FiltragePourOuvertureReprise1(sens:string);
begin
FiltrageDataSet(TaPCA3,CreeFiltreET(['DateSaisie','Sens'],[DateToStr(E.DatExoDebut-1),Sens]));
end;

//Ecrit la reference dans la table charges a payer après avoir créer l'OD
Procedure TDMChargeCA.EcritureReference(ID:integer;date:boolean;Ref:string);
begin
  try
    if TaPCAEcritureReference.Locate('ID',ID,[]) then
    begin
      TaPCAEcritureReference.Edit;
      TaPCAEcritureReference.FindField('Reference').AsString:= Ref;
      if date=true then
      TaPCAEcritureReference.FindField('Date_Piece').Asdatetime:=e.DatExoFin;
      TableGerePost(TaPCAEcritureReference);
   end;
  finally
  //
  end;
end;

//Création des OD après la reprise des charges
procedure TDMChargeCA.CreationODChargeCAReprise;
var
SoldeCompte:TSoldeCompte;
Except_LGR:TExceptLGR;
ParamAffichage:TParamAffichage;
NbEnregistrement:integer;
Ecran:string;
begin
   try
       Initialise_ExceptLGR(Except_LGR);
       TableGereStartTransaction(TaPCA2);
       FiltrageDataSet(TaPCA2,'Date_Piece <>null and Date_Piece >= '''+DateTimeToStr(E.DatExoDebut)+''' And Date_Piece <= '''+DateTimeToStr(E.DatExoFin)+''' And DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 1)+''' And Reference = ''''');
       NbEnregistrement:=TaPCA2.RecordCount;
       TaPCA2.first;
       // Tant qu'il reste des enregistrements dans la table TaCAR
        While (Not(NbEnregistrement=0)) Do
        Begin
             if TaPCA2.findfield('Sens').Asstring[1]='C'then
               Ecran:='charges constatées d''avance'
             else
               Ecran:='produits constatés d''avance';
         Except_LGR:=PossibiliteRepriseCompte(TaPCA2.findfield('Compte').Asstring,TaPCA2,TaPCA2.findfield('Sens').Asstring[1],Ecran);
//           try//except
//               Except_LGR.retour:=true;
//               Except_LGR.NumErreur:=0;
//               SoldeCompte:=DMBalance.RetourneSoldeCompteAvantReprise(TaPCA2.findfield('Compte').Asstring,TaPCA2,0,TaPCA2.findfield('Sens').Asstring[1]);
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
//                       if (MessageDlg('il existe une différence entre vos '+Ecran+', le solde de la '+#13+#10+'balance et le solde du bilan d''''ouverture '+#13+#10+'sur le compte :'+#13+#10+'Vous ne pouvez pas reprendre vos '+Ecran+' sur ce '+#13+#10+'compte'+#13+#10+'Souhaitez vous visualiser ces différences ?', mtWarning, [mbYes,mbNo], 0) = mrYes) then
//                         begin
//                            Initialise_TParamAffichage(ParamAffichage);
//                            ParamAffichage.AffichModal := true;
//                            ParamAffichage.Titre:='Liste des Soldes du compte '+TaPCA2.findfield('Compte').Asstring;
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
//                   MessageDlg('il existe une différence entre le solde de la balance et le solde '+#13+#10+'de vos '+Ecran+' sur le compte :'+TaPCA2.findfield('Compte').Asstring+#13+#10+'Vous ne pouvez reprendre vos '+Ecran+' pour ce compte. ', mtWarning, [mbOK], 0);
//                 end;
//             end;//fin du case ExceptLGR
//           end;
         if Except_LGR.retour then
           begin
              CreationODReprise_avecObjet(TaPCA2,'');
              //une fois l'OD crée, on écrit la référence de cette pièce dans la table des chargesCA
              EcritureReference(TaPCA2ID.AsInteger,false,DMImport.Piece_Import.Reference);
           end;
        TaPCA2.Next;//et on continue jusqu'à ce qu'il n'y ai plus de nouvelle charges enregistrée sans référence
        NbEnregistrement:=NbEnregistrement-1;
        end;
       TableGereCommit(TaPCA2);
       TableGereCommit(DMPieces.TaPiece);
   except
       TableGereCommit(TaPCA2);
       TableGereCommit(DMPieces.TaPiece);
       showmessage('Problème à l''enregistrement des OD d''ouverture');
       abort;
   end;
end;

//création des OD concernant les charges et produits enregistrés dans la clôture
procedure TDMChargeCA.CreationODChargeCACloture;
var
NbEnregistrement:integer;
begin
   try
      TableGereStartTransaction(TaPCA2);
      // filtrage avant la Creation des OD de Cloture pour soustraire les charges ou produits avant de les
      //réenregistrer suite à la création des OD
      FiltrageDataSet(TaPCA,'DateSaisie = '''+DateTimeToStr(E.DatExoFin)+''' And Reference = ''''');
      NbEnregistrement:=TaPCA.RecordCount;
      TaPCA.First;
      While (Not(NbEnregistrement=0)) Do
        Begin
        InitialisationVariablesTemp;//mise à zéro des variables temporaires
        //remplissage des variables temporaires
        Compte2Tmp:=TaPCACompte2.AsString;
        CompteTmp:=TaPCACompte.AsString;
        MontantTmp:=TaPCAMontantHT.AsCurrency;
        QteTmp:=TaPCAQte.AsFloat;
        DesignationTmp:=TaPCALibelle2.AsString;
        ref:=TaPCAReference.AsString;
        //////////////////
//      pour tous les nouvelles charges ou produits enregistrés dans la clôture
//      on soustrait de la balance le montant de ces charges 1 par 1
//      pour pouvoir les mettre à jour de nouveau en créant les OD de clôture
        if TaPCASens.AsString='D'then //traitement porte sur les charges
        TraitementMAJBalance(21,true,dsbrowse,'');
        if TaPCASens.AsString='C'then //traitement porte sur les produits
        TraitementMAJBalance(22,true,dsbrowse,'');
        TaPCA.next;
        NbEnregistrement:=NbEnregistrement-1;
        end;
       FiltrageDataSet(TaPCA2,'DateSaisie = '''+DateTimeToStr(E.DatExoFin)+''' And Reference = ''''');
       NbEnregistrement:=TaPCA2.RecordCount;
       TaPCA2.first;
       // Tant qu'il reste des enregistrements dans la table TaCAR
        While (Not(NbEnregistrement=0)) Do
        Begin
        CreationODCloture_avecObjet(TaPCA2,'');
         //une fois l'OD crée, on écrit la référence de cette pièce dans la table des chargesCA
        EcritureReference(TaPCA2ID.AsInteger,true,DMImport.Piece_Import.Reference);
        TaPCA2.Next;//et on continue jusqu'à ce qu'il n'y ai plus de nouvelle charges enregistrée sans référence
        NbEnregistrement:=NbEnregistrement-1;
        end;
       TableGereCommit(TaPCA2);
       TableGereCommit(DMPieces.TaPiece);
   except
       begin
       showmessage('Problème à l''enregistrement des OD d''ouverture');
       TableGereRollBack(TaPCA2);
       TableGereRollBack(DMPieces.TaPiece);
       abort;
       end;
   end;
   DeFiltrageDataSet(TaPCA);
end;


//mise à zéro des variables temporaires
procedure TDMChargeCA.InitialisationVariablesTemp;
begin
Compte2Tmp:='';
CompteTmp:='';
MontantTmp:=0;
QteTmp:=0;
DesignationTmp:='';
ref:='';
end;



//prépare les listes d'OD à afficher dans ''E2_RepriseChargesAPayer2_Isa''
//passe les paramètres d'affichage de cette fenêtre (caption, boutons,etc...)
//Cette fenêtre sert à afficher les OD des différents menu d'ouverture et de clôture
//les paramètres d'affichage sont passés au moment de la demande d'affichage de cette fenêtre
procedure TDMChargeCA.DemandeAffichageReprise;
var
numTag,NumButton:integer;
Liste1,Liste2:TStringList;
begin
numTag:=0;
NumButton:=1;
numtag:=StrToInt_Lgr(copy(inttostr(tag),1,1));
NumButton:=StrToInt_Lgr(copy(inttostr(tag),2,1));
if numtag=1 then
begin
  liste1:=CreationListeOD(E.DatExoDebut-1,'D');
  liste2:= CreationListeOD(E.DatExoDebut-1,'C');
  DMPieces.AffichageFeuilleReprise(NumButton,liste1,liste2,'OD de Reprise des Charges et Produits Constatés d''avances',
      'OD de Reprise Charges Constatées d''avances','OD de Reprise Produits Constatés d''avances',true);
end;
if numtag=2 then
begin
  liste1:=CreationListeOD(E.datexofin,'D');
  liste2:=CreationListeOD(E.datexofin,'C');
  DMPieces.AffichageFeuilleReprise(NumButton,liste1,liste2,'OD Clôture Charges et Produits Constatés d''avances',
  'OD Clôture Charges Constatées d''avances','OD Clôture Produits Constatés d''avances',true);
end;
//liste1.Free;
//liste2.Free;
end;


//crée la liste des OD à afficher dans ''E2_RepriseChargesAPayer2_Isa'
//l'appel de cette fonction se fait dans ''DemandeAffichageReprise''
function TDMChargeCA.CreationListeOD(DateExo:TDateTime;sens:string):TStringList;
begin
try
FiltrageDataSet(TaPCA,'DateSaisie = '''+DateTimeToStr(DateExo)+''' And Reference <> '''' And Sens = '''+sens+'''');
result:=TStringList.Create;
result.Clear;
  While (Not(TaPCA.EOF)) Do
     Begin
         If result.IndexOf(TaPCAReference.AsString) = -1 Then
            result.Add(TaPCAReference.AsString);
         TaPCA.Next;
     End;
except
   result.clear;
end;
end;


//******************* TDMChargeAPayer.TraitementMAJBalance *************************
//Permet de mettre à jour la balance à la fois lors de l'enregistrement d'une nouvelle
//charges ou produit en ajout, mais aussi en soustraction avant la création d'une OD
//car la création de l'OD génère une mise à jour de la balance elle aussi.
procedure TDMChargeCA.TraitementMAJBalance(Ch_Pr:integer;Suppression:boolean;EtatTaPCA:TDataSetState;Ref:string);
var
param:TRecupParametres; //nom du champ(Debit ou Credit)et du champ Quantité
begin
if Ch_Pr= 0 then
param:=RecupParametreMAJBalance(self.tag)//récupération des paramètres de MAJ Balance
else
param:=RecupParametreMAJBalance(Ch_Pr);//récupération des paramètres de MAJ Balance
with param do
   begin //Début du with   
    if empty(Ref) then
    begin
    //mise à jour balance pour le compte de charges A Payer
    DMBalance.MAJBalance(Suppression,qte1,sens1,TaPCACompte.AsString,
    compteTmp,TaPCAQte.AsFloat,QteTmp,TaPCAMontantHT.AsCurrency,montantTmp,EtatTaPCA);
    end
    else
       begin //si la charge a une OD
           case self.Tag of
           11,12:begin//si ouverture
                 DMBalance.MAJBalance(Suppression,qte1,sens1,TaPCACompte.AsString,
                 compteTmp,TaPCAQte.AsFloat,QteTmp,TaPCAMontantHT.AsCurrency,
                 montantTmp,EtatTaPCA);//MAJ Balance pour compte de charges ou de produits
                 end;
           21,22:begin//si cloture
                 DMBalance.MAJBalance(Suppression,qte1,sens1,TaPCACompte.AsString,
                 compteTmp,TaPCAQte.AsFloat,QteTmp,TaPCAMontantHT.AsCurrency,
                 montantTmp,dsinsert);//MAJ Balance pour compte de charges ou de produits
                 end;
           end;//fin du case
       end;// FIN si la charge a une OD
end;//fin du with
end;


//******************* TDMChargeAPayer.TaChAPayerBeforePost *************************
//Contrôle de la saisie, mise à jour de la balance, ouverture d'une transaction
procedure TDMChargeCA.TaPCABeforePost(DataSet: TDataSet);
var
Annee,Mois,Jour:word;
DateCourante:Tdatetime;
I:integer;
controleSaisie:TErreurSaisie;
begin
if DataSet.State in [dsinsert,dsedit] then
   begin
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,
        ET_Maint:    Begin
                           for i:=8 to 9 do //compte2 et libelle2
                             begin
                             controleSaisie:=CtrlSaisieChargesCA(TaPCA.Fields[i]);
                             if controleSaisie.Retour=false then
                                   case controleSaisie.CodeErreur of
                                   8100,8101:begin
                                          //Focus sur compte2
                                          LaisserPasser:=false;
                                          if ((not empty(DataSet.Fields[8].asstring))and(controleSaisie.CodeErreur<>8101))then
                                            begin
                                            if application.MessageBox(Pchar('Ce compte n''est pas cohérent dans ce context, voulez-vous continuer'),'Erreur de saisie',MB_ICONWARNING +MB_YESNO+MB_DEFBUTTON1)=mrno then
                                              Begin//si
                                                if assigned(FOnGEstInterfaceEvent) then
                                                 FOnGEstInterfaceEvent(DataSet.Fields[8]);
//                                                DataSet.Fields[8].FocusControl;//isa 5-11-02
                                                abort;
                                              End//fin si
                                            else
                                              LaisserPasser:=true;
                                            end
                                          else
                                            Begin//si
                                                if assigned(FOnGEstInterfaceEvent) then
                                                 FOnGEstInterfaceEvent(DataSet.Fields[8]);
//                                                DataSet.Fields[8].FocusControl;//isa 5-11-02
                                                abort;
                                            End;//fin si

                                        end;
                                   8200:begin
                                          if assigned(FOnGEstInterfaceEvent) then
                                           FOnGEstInterfaceEvent(DataSet.Fields[8]);
//                                          DataSet.Fields[8].FocusControl;
                                          abort;//champ code emprunt
                                        end;
                                   end;//fin du case
                             end;//fin du i=8 à 10
                           for i:=4 to 5 do //Qte et Montant
                             begin
                             controleSaisie:=CtrlSaisieChargesCA(DataSet.Fields[i]);
                             case controleSaisie.CodeErreur of
                                   5100:begin
                                          if assigned(FOnGEstInterfaceEvent) then
                                           FOnGEstInterfaceEvent(DataSet.Fields[5]);
//                                          DataSet.Fields[5].FocusControl;
                                          abort;//champ code emprunt
                                        end;
                                   end;//fin du case
                           end;//fin du i=4 to 5
                           ////fin du Contrôle de la saisie////////
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

   /////Remplissage des champs hors saisie////////
   try
      if DataSet.State=dsinsert then
      begin //si table en insertion
      TaPCAID.AsInteger:= MaxId_Query(TaPCA,'ID');
      TaPCACompte.AsString:=CompteDeChargeOuDeProduit;
      TaPCALibelle.AsString:=LibelleCompteDeChargeOuDeProduit;
      TaPCADateSysteme.AsDateTime:=now;
         case self.Tag of
         1,11,12:begin //si ouverture
                 TaPCADateSaisie.AsDateTime:=e.DatExoDebut-1;
                 datecourante:=e.DatExoDebut;
                 DecodeDate(datecourante,annee,mois,jour);
                 TaPCADateExercice.AsDateTime:=EncodeDate(annee-1,mois,jour);
                    case self.Tag of
                    11:TaPCASens.Asstring:='D';
                    12:TaPCASens.Asstring:='C';
                    end;//fin du case
                 end;//fin si ouverture
         2,21,22:begin//si cloture
                 TaPCADateSaisie.AsDateTime:=E.DatExoFin;
                 TaPCADateExercice.AsDateTime:=E.DatExoDebut;
                    case self.Tag of
                    21:TaPCASens.Asstring:='D';
                    22:TaPCASens.Asstring:='C';
                    end;//fin du case
                 end;//fin si cloture
         end;//fin du case ouverture/cloture
      end;//fin table en insertion
      except
      showmessage('Problème à l''écriture dans la table Charges A Payer !!!');
      abort;
      end;//fin du try
  /////fin du Remplissage des champs hors saisie////////
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,ET_EnCloture,
        ET_Maint:    Begin
                        // Mise à jour de la balance
                        TableGereStartTransaction(DataSet);
                        try
                          TraitementMAJBalance(self.tag,false,DataSet.State,ref);
                             if DataPCA.State =dsEdit then
                               if not(empty(ref)) then
                                   begin //si modif et OD
                                      if (trim(TaPCACompte2.AsString)<>trim(Compte2Tmp))or
                                     (TaPCAMontantHT.AsCurrency<>MontantTmp)or(TaPCAQte.AsFloat<>QteTmp)then
                                     begin //si la modification porte sur un champ autre que la désignation
                                   //on supprime l'OD
                                     DMPieces.SuppressionOD(TaPCAReference.AsString);
                                     TaPCAReference.AsString:='';
                                     TaPCADate_Piece.asstring:='';
                                     TaPCADateSysteme.AsDateTime:=now;
                                     end
                                     else  //sinon, on modifie l'OD uniquement
                                     if trim(TaPCALibelle2.asstring)<>trim(DesignationTmp) then
                                     DMPieces.ModificationOD(TaPCAReference.AsString,TaPCALibelle2.asstring);
                                   end;//fin si modif et OD

                         except
                         //si problème, annule toutes les écritures (Suppression ou modif OD, MAJ Balance,enregistrement charge)
                         TableGereRollback(DataSet);
                         TableGereRollback(DMPieces.TaPiece);
                         showmessage('Problème à la mise à jour de la balance !!!');
                         abort;
                         end;//fin du try
                     end;
      end;//fin du case typeEtatExercice
   end;//fin si insertion ou modification
end;

//sert à contrôler la saisie, à proposer une liste dans certain cas,
//à remplir un champ vide par défaut dans certain cas
//enfin, renvoie un code erreur si la saisie reste invalide
Function TDMChargeCA.CtrlSaisieChargesCA(CCourant:Tfield):TErreurSaisie;
var
RetourEnregistrement:TEnregistrementComplet;
begin // initialisation des variables de retour de fonction
CtrlSaisieChargesCA.CodeErreur:=0;
CtrlSaisieChargesCA.Retour:=True;
  if TaPCA.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
        case CCourant.Index of
        8: begin // si champ n° 1 (compte2)
         if DMChargeCA.LaisserPasser then
           DMChargeCA.LaisserPasser:=(CCourant.AsString=Compte2Tmp);
         GestionFiltrageAideCompte(ccourant);//on filtre aideCompte par
        //rapport au compte de charges pour y afficher les comptes de reprise correspondants
           if DMChargeCA.LaisserPasser=false then
             begin//si non laisserPasser
                //if not VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCourant.DataSet,Quand=C_Ouverture) then
                // begin//si pas existant dans ouverture
                   if AideCompteDansContexte_LaisserPasser(CCourant.AsString,ccourant,['Rac1','Rac2','Rac3','Rac4'],false,false,MessDerSub,LaisserPasser,true,true,false,true,0)=false then
                      Begin //si compte pas ok
                        if not LaisserPasser then
                          begin//si pas laisserPasser après aidecompte
                            if ((not DMPlan.CompteExistePCU(CCourant.AsString))or(VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCourant.DataSet,Quand=C_Ouverture))) then
                              CtrlSaisieChargesCA.CodeErreur:=8101  //Compte emprunt non existant ou déjà utilisé ailleurs
                            else
                              CtrlSaisieChargesCA.CodeErreur:=8100;  //Compte emprunt hors contexte
                            CtrlSaisieChargesCA.Retour:=False;
                          end;//fin (si pas laisserPasser après aidecompte)
//                        else
//                        begin//si laisser passer, on ne laisse pas passer les comptes collectifs ou rattaché à code tva
//                          if (DMPlan.CptEstCollectif(CCourant.AsString))or(FTvaCompteDeTva(CCourant.AsString)or (Length(CCourant.AsString)<3))then
//                             begin//si Compte hors contexte
//                                showmessage('Ce compte n''est pas correct dans le contexte');
//                                CtrlSaisieChargesCA.CodeErreur:=8100;  //Compte hors contexte
//                                CtrlSaisieChargesCA.Retour:=False;
//                             end;//fin si Compte hors contexte
//                        end;// Fin (si laisser passer, on ne laisse pas passer les comptes collectifs ou rattaché à code tva)
                      End;//fin si compte pas ok
                 //end//fin si pas existant dans ouverture
//               else
//                 begin//si déjà dans ouverture
//                    CtrlSaisieChargesCA.CodeErreur:=8101;  //Compte emprunt déjà utilisé ailleurs
//                    CtrlSaisieChargesCA.Retour:=False;
//                 end;//fin si déjà dans ouverture
             end;//fin si non laisserPasser
           if result.retour then
             Begin
             if (CCourant.AsString=CompteDeChargeOuDeProduit)then
             begin
               showmessage('Ce compte n''est pas correct dans le contexte');
               CtrlSaisieChargesCA.CodeErreur:=8200;
               CtrlSaisieChargesCA.Retour:=False;
             end
             else RecupInfoApresVerif(true);
              //if inttostr(self.Tag) < inttostr(2) then
               //begin
                //if VerifSiCompteSaisieDsBO(CCourant.AsString,true,CCOurant.DataSet,Quand=C_Ouverture) then
                  //begin
//                    LaisserPasser:=false;
//                    if assigned(FOnGEstInterfaceEvent) then
//                     FOnGEstInterfaceEvent(CCourant);
////                    CCourant.FocusControl;
//                    CtrlSaisieChargesCA.CodeErreur:=8200;  //Compte déjà utilisé dans BO
//                    CtrlSaisieChargesCA.Retour:=False;
                  //end else
                //RecupInfoApresVerif(true);
               //end
               //else

             end;
           end;//fin champ n°1
        9: begin//si champ n°2(Désignation)
            If Empty(CCourant.AsString) then
               begin
               RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaPCACompte2.AsString);
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
                 RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaPCACompte2.AsString);
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
             If (Empty(CCourant.AsString)) or (ccourant.AsString='0') then
             Begin // si champ n°4 vide ou =0
             CtrlSaisieChargesCA.CodeErreur:=5100;
             CtrlSaisieChargesCA.Retour:=False;
             Application.Messagebox(Pchar('La saisie du montant HT est obligatoire !!!'),'Erreur de saisie',0);
             end;//fin  si champ n°4 vide ou =0
           end;//fin si champ n°4 (Montant HT)
        end;//fin du case.ccourant
  end; //fin etat insertion ou modif
//  Erreur:=result;
end;


//filtre la grille suivant si on est sur la fenêtre d'ouverture ou de clôture
//et si on souhaite travailler sur les charges ou plutôt sur les produits
procedure TDMChargeCA.FiltrageAffichageGrille(Tag_bis:integer);
begin
case Tag_bis of
   11,12 : FiltrageDataSet(TaPCA,CreeFiltreET(['Compte','DateSaisie'],[CompteDeChargeOuDeProduit,datetostr(E.DatExoDebut-1)]));
   21,22 : FiltrageDataSet(TaPCA,CreeFiltreET(['Compte','DateSaisie'],[CompteDeChargeOuDeProduit,datetostr(E.DatExoFin)]));
end;//fin du case
end;


//permet de récupérer des paramètres de MAJ de balance suivant si elle intervient à l'ouverture
//ou à la clôture, si elle porte sur une charge ou un produit
function  TDMChargeCA.RecupParametreMAJBalance(tag_module:integer):TRecupParametres;
begin
   with result do
   begin
    case tag_module of
         11:begin //ouverture-Charges
            sens1:='Debit_Report';
            Qte1:='Qt1_Report';
            end;
         21:begin //Cloture-Charges
            sens1:='Debit_Base';
            Qte1:='Qt1_Base';
            end;
         12:begin //ouverture-Produits
            sens1:='Credit_Report';
//            Qte1:='Qt2_Report';
            Qte1:='Qt1_Report';
            end;
         22:begin //Cloture-Produits
            sens1:='Credit_Base';
//            Qte1:='Qt2_Base';
            Qte1:='Qt1_Base';
            end;
         end;//fin du case
   end;//fin du with
end;

//fini la transaction, récupère l'ID de la dernière ligne de la grille, filtre la grille en fonction
//du nouvel enregistrement écrit et mise à zéro des variables temporaires
procedure TDMChargeCA.TaPCAAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
 FiltrageAffichageGrille(self.Tag);
 InitialisationVariablesTemp;
 MessDerSub:=true;
end;

//Rempli les variables temporaires avant la modification, envoie un message de confirmation
//si la charges dépend d'une OD,
procedure TDMChargeCA.TaPCABeforeEdit(DataSet: TDataSet);
var
   messagetmp: String;
begin
if inttostr(self.Tag) < inttostr(2) then
if VerifSiCompteSaisieDsBO(CompteDeChargeOuDeProduit,true,DataSet) then
  begin
    abort;  //Compte déjà utilisé dans BO
  end;
//enlève la lecture seule sur le champ Quantité
      //Prépare un message suivant si la modif porte sur une charge ou un produit
      Case self.Tag Of
      11,21: messagetmp := 'Attention, la reprise de cette charge Constatée d''avance a été éffectuée !!!'+#10#13+'La modification de cette charge à payer entraînera la modification de l''OD de reprise et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de cette charge à payer ?';
      12,22: messagetmp := 'Attention, la reprise de ce produit Constaté d''avance a été éffectuée !!!'+#10#13+'La modification de ce produit à recevoir entraînera la modification de l''OD de reprise et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de ce produit à recevoir ?';
      End; // Fin du Case

      // Si le compte possède une OD, envoie du message de confirmation
      If TaPCAReference.AsString <> '' Then
           If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
                abort;
//mise à zéro des variables temporaires
InitialisationVariablesTemp;
//remplissages des variables temporaires avant modification
Compte2Tmp:=TaPCACompte2.AsString;
CompteTmp:=TaPCACompte.AsString;
MontantTmp:=TaPCAMontantHT.AsCurrency;
QteTmp:=TaPCAQte.AsFloat;
DesignationTmp:=TaPCALibelle2.AsString;
ref:=TaPCAReference.AsString;
DMChargeCA.LaisserPasser:=false;
end;

//Prépare un message de confirmation de suppression si la charge ou le produit dépend d'une
//OD, mise à zéro des variables temporaires et remplissage de ces variables avant suppression
//commence une transaction
procedure TDMChargeCA.TaPCABeforeDelete(DataSet: TDataSet);
var
   messagetmp: String;
begin
try//except
      Case self.Tag Of
      11,21:begin
            if Self.tag = 11 then
             begin
               if VerifSiCompteSaisieDsBO(DataSet.FindField('Compte').AsString,False,DataSet) then
                begin
                 Messagedlg(CompteImporte_DossierDos,mtInformation,[mbok],0);
                 Abort;
                end;
             end;

            if empty(TaPCAReference.AsString) then
              messagetmp :='Êtes-vous sûr de supprimer cette charge Constatée d''avance ?'
            else
              if self.tag=21 then
                messagetmp :='Êtes-vous sûr de supprimer cette charge Constatée d''avance ?'+#10#13+'La suppression de cette charge à payer entraînera la suppression de l''OD et la mise à jour de la balance !!!'+#10#13+'Confirmer la suppression de cette charge à payer ?'
              else
                messagetmp :='Attention, la reprise de cette charge Constatée d''avance a été effectuée !!!'+#10#13+'La suppression de cette charge à payer entraînera la suppression de l''OD et la mise à jour de la balance !!!'+#10#13+'Confirmer la suppression de cette charge à payer ?';
            end;
      12,22:begin
            if Self.tag = 12 then
             begin
               if VerifSiCompteSaisieDsBO(DataSet.FindField('Compte').AsString,False,DataSet) then
                begin
                 Messagedlg(CompteImporte_DossierDos,mtInformation,[mbok],0);
                 Abort;
                end;
             end;
            if empty(TaPCAReference.AsString) then
            messagetmp :='Êtes-vous sûr de supprimer ce produit Constaté d''avance ?'
            else
            IF self.tag=22 then
              messagetmp := 'Êtes-vous sûr de supprimer ce produit Constaté d''avance ?'+#10#13+'La suppression de ce produit à recevoir entraînera la suppression de l''OD et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de ce produit à recevoir ?'
            else
              messagetmp := 'Attention, la reprise de ce produit Constaté d''avancea été éffectuée !!!'+#10#13+'La suppression de ce produit à recevoir entraînera la suppression de l''OD et la mise à jour de la balance !!!'+#10#13+'Confirmer la modification de ce produit à recevoir ?';
            end;
      End; // Fin du Case
Case E.TypeEtatExercice of
 ET_Importation:begin
                  //
                end;
  ET_Normal:    begin
                  If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
                    abort;
                end;
end;//fin du case E.TypeEtatExercice
      //mise à zéro des variables temporaires
      InitialisationVariablesTemp;
      //remplissages des variables temporaires avant suppression
      Compte2Tmp:=TaPCACompte2.AsString;
      CompteTmp:=TaPCACompte.AsString;
      MontantTmp:=TaPCAMontantHT.AsCurrency;
      QteTmp:=TaPCAQte.AsFloat;
      DesignationTmp:=TaPCALibelle2.AsString;
      ref:=TaPCAReference.AsString;

      ////////Début de transaction
      TableGereStartTransaction(TaPCA);
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
          case self.tag of
             11,12:TraitementMAJBalance(self.tag,true,dsBrowse,ref);
          end;//fin du case
        except
        //si problème, annule toutes les écritures (Suppression OD, MAJ Balance,suppression charge)
         TableGereRollback(DataSet);
         TableGereRollback(DMPieces.TaPiece);
        showmessage('Problème à la Mise A Jour de la balance après une suppression d''OD ');
        abort;
        end;//fin du try
except
 TableGereRollback(DataSet);
 TableGereRollback(DMPieces.TaPiece);
 abort;
end;
end;

//fini la transaction, récupère l'ID de la dernière ligne de la grille, déclenche un
//changement d'Etat pour gérer les boutons, mise à zéro des variables temporaires
procedure TDMChargeCA.TaPCAAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);

if @DataPCA.OnStateChange<>nil then DataPCA.OnStateChange(DataSet);
InitialisationVariablesTemp;
end;

//empèche la suppression d'une charge ou d'un produit dans fenêtre de reprise
procedure TDMChargeCA.TaPCA3BeforeDelete(DataSet: TDataSet);
begin
abort;
end;


//vérifie la saisie de la date de reprise dans E2_repriseChargesCA ,ouvre une transaction
//supprime l'OD si date enlevé, modifie l'OD si date modifiée
procedure TDMChargeCA.TaPCA3BeforePost(DataSet: TDataSet);
var
messages:string;
begin
messages:='Problème à la suppression ou la modification de l''OD ';
   try
   VerifSaisieFeuilleReprise1(TaPCA3Date_Piece);
   except
   abort;
   end;
//   TaPCA3.Database.StartTransaction;
//   TaPCA3.Database.TransIsolation:=tiDirtyRead;
   if TaPCA3.State = dsedit then
   try
     if (datepiece<>TaPCA3Date_Piece.AsDateTime) and (not(empty(TaPCA3Reference.AsString))) then
       if empty(TaPCA3Date_Piece.asstring) then
         begin
         if application.MessageBox(Pchar('Attention, la suppression de la date entraînera la suppression de l''OD de reprise et la modification de la balance !!!'+#10#13+'Confirmer la suppression de la date ?'),'Confirmation',MB_YESNO+MB_DEFBUTTON1)=mryes then
           Begin
             DMPieces.SuppressionOD(TaPCA3Reference.AsString);
             TaPCA3Reference.AsString:='';
             TaPCA3Date_Piece.asstring:='';
             TaPCA3DateSysteme.AsDateTime:=now;
           end
         Else
           begin
             TaPCA3.Cancel;
             messages:='';
             abort;
           end;
         end
       else
         begin
          if application.MessageBox(Pchar('Attention, la modification de la date entraînera la modification de l''OD de reprise et la modification de la balance !!!'+#10#13+'Confirmer la modification de la date ?'),'Confirmation',MB_YESNO+MB_DEFBUTTON1)=mryes then
             Begin
               DMPieces.ModificationDatePiece(TaPCA3Reference.AsString,TaPCA3Date_Piece.asdatetime);
             end
           Else
             begin
               TaPCA3.Cancel;
               messages:='';
               abort;
             end;
         end;
   except
   TableGereRollBack(DataSet);
   TableGereRollBack(DMPieces.TaPiece);
   if not empty(messages)then
     showmessage(messages);
   TaPCA3.Refresh;
   abort;
   end;//fin du try
end;


//remplissage d'une variable temporaire avant modification
procedure TDMChargeCA.TaPCA3BeforeEdit(DataSet: TDataSet);
begin
TableGereStartTransaction(TaPCA3);
datepiece:=TaPCA3Date_Piece.AsDateTime;
end;


//empèche l'insertion d'une charge ou d'un produit dans fenêtre de reprise
procedure TDMChargeCA.TaPCA3BeforeInsert(DataSet: TDataSet);
begin
abort;
end;

//filtre les charges ou produits de clôture qui ne sont pas repris
procedure TDMChargeCA.Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
var
Filtre:string;
begin
   try
   //filtre les charges ou produits de clôture
   Filtre:=TaPCA.Filter;
   if TaPCA.active=false then
     TaPCA.open;
   FiltrageDataSet(TaPCA,'(DateSaisie<='''+datetostr(E.DatExoFin)+'''and reference ='''')or (DateSaisie='''+datetostr(E.DatExoFin)+''')');
   if TaPCA.RecordCount<>0 then
     begin
     tMem.LoadFromDataSet(TaPCA,0,lmCopy);
     tMem.First;
     while not(tMem.EOF) do
        begin//change la date de saisie avec la nouvelle date d'Exo
        tMem.edit;
        tMem.FindField('DateSaisie').AsDateTime:=NouvelleDate;
        tMem.FindField('DateSysteme').AsDateTime:=now;
        tMem.FindField('Date_Piece').Asstring:='';
        tMem.FindField('Reference').Asstring:='';
        tMem.Post;
        TaPCA.FlushBuffers;
        tmem.FieldCount;
        tMem.Next;
        end;
     end;
   FiltrageDataSet(TaPCA,Filtre);
   except
   showmessage('Problème à l''écriture dans la nouvelle table '+TaPCA.tableName);
   abort;
   end;//fin du try
end;

//si erreur à l'enregistrement de la charge ou du produit, annule toutes les écritures
//(MAJ balance, Suppression ou Modif d'OD, enregistrement de la charges)
procedure TDMChargeCA.TaPCAPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;

//Récupére les paramètres du compte de reprise séléctionné, et en fonction de ces paramètres
//initialise certains champs comme la Quantité , si champ libellé vide, le remplie par
//défaut avec le libellé du compte
procedure TDMChargeCA.RecupInfoApresVerif(tout:boolean);
var
RetourEnregistrement:TEnregistrementComplet;
begin
//Récupère tous les paramètres d'un compte
RetourEnregistrement:=DmPlanRecupEnregistrementComplet(TaPCACompte2.AsString);
       if empty(RetourEnregistrement.Un1) then //si pas de paramètre Quantité
       begin
       if TaPCA.Fields[4].ReadOnly=false then
       TaPCA.Fields[4].asstring:='';
       TaPCA.Fields[4].ReadOnly:=true;
       end
       else
       TaPCA.Fields[4].ReadOnly:=false; //si paramètre Quantité

       if tout then
       begin
          if not(empty(RetourEnregistrement.Libelle)) then//Si paramètre libellé
          begin
             if (empty(TaPCALibelle2.AsString)) then//si libellé de la grille vide
             TaPCALibelle2.AsString:=RetourEnregistrement.Libelle
             //remplir par défaut avec le libellé
             else //si libellé de la  grille pas vide, vérifie que le libellé ne correspond
             //pas au libellé de l'ancien compte saisie
               if (TaPCALibelle2.AsString=trim(dernierlibelle)) then
               TaPCALibelle2.AsString:=RetourEnregistrement.Libelle;
               DernierLibelle:=RetourEnregistrement.Libelle;
          end;
       end;
Compte2Tmp:=TaPCACompte2.AsString;
end;


//ferme la transaction
procedure TDMChargeCA.TaPCA3AfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
end;


//si erreur, annule toutes les écritures(MAJ Balance, enregistrement date,
//modification ou suppression d'OD)
procedure TDMChargeCA.TaPCA3PostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
   TableGereRollBack(DataSet);
   TableGereRollBack(DMPieces.TaPiece);
end;


//si erreur à la suppression de la charge ou du produit, annule toutes les écritures
//(MAJ balance, Suppression OD, suppression de la charges)
procedure TDMChargeCA.TaPCADeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMChargeCA.TaPCABeforeInsert(DataSet: TDataSet);
begin
if assigned(FOnGEstInterfaceEvent) then
 FOnGEstInterfaceEvent(DataSet.Fields[8]);
//  dataset.Fields[8].focuscontrol;
if inttostr(self.Tag) < inttostr(2) then
if VerifSiCompteSaisieDsBO(CompteDeChargeOuDeProduit,true,DataSet) then
  begin
    abort;  //Compte déjà utilisé dans BO
  end;
DMChargeCA.LaisserPasser:=false;
end;

procedure TDMChargeCA.TaPCABeforeEIDOuv_Abort(DataSet: TDataSet);
Begin
case self.tag of
   11:Begin
        if not e.AccesOuverture then
         MessageDlg('Vous ne pouvez plus modifier les Charges Constatées d''Avance d''ouverture !', mtInformation, [mbOK], 0)
         else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Charges Constatées d''Avance d''ouverture !', mtError, [mbOK], 0);
        abort;
      End;

   12:Begin
        if not e.AccesOuverture then
         MessageDlg('Vous ne pouvez plus modifier les Produits Constatées d''Avance d''ouverture !', mtInformation, [mbOK], 0)
         else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Produits Constatées d''Avance d''ouverture !', mtError, [mbOK], 0);
        abort;
      End;
end;
End;

procedure TDMChargeCA.TaPCABeforeEIDClo_Abort(DataSet: TDataSet);
Begin
case self.tag of
   21:Begin
        if not e.AccesCloture then
         MessageDlg('Vous ne pouvez plus modifier les Charges Constatées d''Avance de clôture !', mtInformation, [mbOK], 0)
         else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Charges Constatées d''Avance de clôture !', mtError, [mbOK], 0);
        abort;
      End;

   22:Begin
        if not e.AccesOuverture then
         MessageDlg('Vous ne pouvez plus modifier les Produits Constatées d''Avance de clôture !', mtInformation, [mbOK], 0)
         else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Produits Constatées d''Avance de clôture !', mtError, [mbOK], 0);
        abort;
      End;
end;
End;


function VerifRepriseChargesCAOuverture_OK(var messageTmp:Tmessages):boolean;
Begin
  result:=false;
if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);

  try
   result:= VerifExistChargesCAOuvertureAReprendre(messagetmp,false);
     if not result then
        begin
         messageTmp.MessageErreur:='Toutes Les Charges ou Produits Constatés d''avances d''ouverture n''ont pas été repris.'+#10#13#10#13;
         messageTmp.MessageQuestion:=' Voulez-vous les reprendre avant la clôture définitive ?';
        end
      else
         messageTmp.MessageErreur:='OK';
  except
   showmessage('problème lors de la vérification des reprises de Charges et Produits Constatés d''avances d''ouverture');
   abort;
  end;
End;

function VerifExistChargesCAOuverture(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
result:=false;
if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
   FiltrageDataSet(DMrech.TaPCARech,'DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 1)+'''');
   result:= DMrech.TaPCARech.RecordCount<>0 ;
   if ((not result)and(mess)) then
         messageTmp.MessageErreur:='Aucune Charge ou Produit constatés d''avance d''ouverture n''ont été saisis'
      else
         messageTmp.MessageErreur:='OK';
  except
   result:=false;
   showmessage('problème lors de la vérification de l''existence des Charges ou Produits constatés d''avance d''ouverture');
   abort;
  end;
End;

function VerifExistChargesCACloture(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
result:=false;
if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
    FiltrageDataSet(DMrech.TaPCARech,'DateSaisie = '''+DateTimeToStr(E.DatExofin)+'''');
    result:= DMrech.TaPCARech.RecordCount<>0;
    if ((not result)and(mess)) then
         messageTmp.MessageErreur:='Aucune Charge ou Produit constatés d''avance de clôture n''ont été saisis'
      else
         messageTmp.MessageErreur:='OK';
  except
   showmessage('problème lors de la vérification de l''existence des Charges ou Produits constatés d''avance de clôture');
   abort;
  end;
End;


function VerifExistChargesCAOuvertureAReprendre(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
result:=false;
if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
    FiltrageDataSet(DMrech.TaPCARech,'Date_Piece=null and DateSaisie = '''+DateTimeToStr(E.DatExoDebut - 1)+'''');
    result:= DMrech.TaPCARech.RecordCount=0;
      if ((not result)and(mess)) then
         messageTmp.MessageErreur:='Il reste des Charges ou Produits constatés d''avance d''ouverture à reprendre'
      else
         messageTmp.MessageErreur:='OK';
  except
   result:=false;
   showmessage('problème lors de la vérification de l''existence des reprises des Charges ou Produits constatés d''avance d''ouverture');
   abort;
  end;
end;


Procedure TDMChargeCA.TraitementCloture3000(sender:Tobject);
Begin
 main.Chargesetproduitsconstatsdavances1Click(main.Chargesetproduitsconstatsdavances1);
End;


procedure TDMChargeCA.CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
ValPieceAutoGen:TValPieceAutoGenere;
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
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
//       Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece);
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('Sens').AsString='D' then
//       if copy(TableEnCours.findfield('Compte2').AsString,1,1)='6' then //si l'OD concerne une charge
          begin
          //remplissage de 2 lignes pour l'OD avec peut-être de la TVA
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('Compte2').asstring),0,TableEnCours.findfield('MontantHT').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,TableEnCours.findfield('MontantHT').AsCurrency,0,TableEnCours.findfield('Compte').asstring),0,-TableEnCours.findfield('MontantHT').AsCurrency,0,'','',0,'',''],true,false,-1);
          end
        else
       if TableEnCours.findfield('Sens').AsString='C' then
//        if copy(TableEnCours.findfield('Compte2').AsString,1,1)='7' then //si l'OD concerne un produit
          Begin
          //remplissage de 2 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,TableEnCours.findfield('MontantHT').AsCurrency,0,TableEnCours.findfield('Compte2').asstring),0,-TableEnCours.findfield('MontantHT').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('Compte').asstring),0,TableEnCours.findfield('MontantHT').AsCurrency,0,'','',0,'',''],true,false,-1);
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
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMChargeCA,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;



procedure TDMChargeCA.CreationODReprise_avecObjet(TableEnCours:TTable;ODModif:string);
var
ListeOd:TStringList;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
ValPieceAutoGen:TValPieceAutoGenere;
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
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('Sens').AsString='D' then
//       if copy(TableEnCours.findfield('Compte2').AsString,1,1)='6' then //si l'OD concerne une charge
          begin
          //remplissage de 2 lignes pour l'OD avec peut-être de la TVA
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,TableEnCours.findfield('MontantHT').AsCurrency,0,TableEnCours.findfield('Compte2').asstring),0,-TableEnCours.findfield('MontantHT').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('Compte').asstring),0,TableEnCours.findfield('MontantHT').AsCurrency,0,'','',0,'',''],true,false,-1);
          end
        else
        if TableEnCours.findfield('Sens').AsString='C' then
//        if copy(TableEnCours.findfield('Compte2').AsString,1,1)='7' then //si l'OD concerne un produit
          Begin
          //remplissage de 2 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte2').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,0,TableEnCours.findfield('MontantHT').AsCurrency,TableEnCours.findfield('Compte2').asstring),0,TableEnCours.findfield('MontantHT').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',TableEnCours.findfield('Compte').asstring,'','',DetermineQte_Cpt(TableEnCours.findfield('Qte').asfloat,TableEnCours.findfield('MontantHT').AsCurrency,0,TableEnCours.findfield('Compte').asstring),0,-TableEnCours.findfield('MontantHT').AsCurrency,0,'','',0,'',''],true,false,-1);
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
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMChargeCA,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;

   end;//fin du try finally
End;


procedure TDMChargeCA.TaPCACalcFields(DataSet: TDataSet);
begin
TaPCAReprise.AsBoolean:=not empty(DataSet.FindField('Reference').AsString);
end;

Procedure TDMChargeCA.ImportChCAvance(Valeurs:array of const;DataSet:TDataSet);
var
ErreurSaisie:TExceptLGR;
Begin
Initialise_ExceptLGR(ErreurSaisie);
// On effectue un controle sur le tag du DataModule qui doit être en bonne position
// Pour être certain que les bons traitements se feront
  case self.Tag of
  11:begin//si ouverture et charges à payer
      try
       if DataSet.State in [dsEdit,dsInsert] then
        begin
          Raise ExceptLGR.Create('Vous devez enregistrer la saisie en cours avant l''importation des Charges à Payer',0,true,mtError,ErreurSaisie);
        end;
        CompteDeChargeOuDeProduit:=string(valeurs[1].VAnsiString);
        LibelleCompteDeChargeOuDeProduit:=string(valeurs[2].VAnsiString);
        DataSet.DisableControls;
        DataSet.Close;
        DataSet.FindField('Qte').ReadOnly := false;
        DataSet.Open;
        ImportTable(Valeurs,DataSet);
        DataSet.DisableControls;
        DataSet.Close;
        DataSet.FindField('Qte').ReadOnly := True;
        DataSet.Open;
        ReEnableControls(DataSet);
      except
       abort;
      end;
     end;
  12:begin//si ouverture et produits à recevoir
      Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des Charges à Payer',0,true,mtError,ErreurSaisie);
     end;
  21,22:begin//si clôture
         Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des Charges à Payer',0,true,mtError,ErreurSaisie);
        end;
  end;
End;

Procedure TDMChargeCA.ImportPrCAvance(Valeurs:array of const;DataSet:TDataSet);
var
ErreurSaisie:TExceptLGR;
Begin
Initialise_ExceptLGR(ErreurSaisie);
// On effectue un controle sur le tag du DataModule qui doit être en bonne position
// Pour être certain que les bons traitements se feront
  case self.Tag of
  11:begin//si ouverture et charges à payer
      Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des Produits à Recevoir',0,true,mtError,ErreurSaisie);
     end;
  12:begin//si ouverture et produits à recevoir
      try
       if DataSet.State in [dsEdit,dsInsert] then
        begin
          Raise ExceptLGR.Create('Vous devez enregistrer la saisie en cours avant l''importation des Produits à Recevoir',0,true,mtError,ErreurSaisie);
        end;
        CompteDeChargeOuDeProduit:=string(valeurs[1].VAnsiString);
        LibelleCompteDeChargeOuDeProduit:=string(valeurs[2].VAnsiString);
        DataSet.DisableControls;
        DataSet.Close;
        DataSet.FindField('Qte').ReadOnly := false;
        DataSet.Open;
        ImportTable(Valeurs,DataSet);
        DataSet.DisableControls;
        DataSet.Close;
        DataSet.FindField('Qte').ReadOnly := True;
        DataSet.Open;
        ReEnableControls(DataSet);
      except
       abort;
      end;
     end;
  21,22:begin//si clôture
         Raise ExceptLGR.Create('Erreur sur le tag ('+IntToStr(Tag)+') lors de l''importation des Produits à Recevoir',0,true,mtError,ErreurSaisie);
        end;
  end;
End;

procedure TDMChargeCA.GestionAccesChargesCA;
Begin
  case self.tag of
     11,12:Begin
            if E.AccesOuverture then
             begin
              TaPCA.BeforeInsert := TaPCABeforeInsert;
              TaPCA.BeforeEdit := TaPCABeforeEdit;
              TaPCA.BeforeDelete := TaPCABeforeDelete;
             end
            else
             begin
              TaPCA.BeforeInsert := TaPCABeforeEIDOuv_Abort;
              TaPCA.BeforeEdit := TaPCABeforeEIDOuv_Abort;
              TaPCA.BeforeDelete := TaPCABeforeEIDOuv_Abort;
             end;
           End;

     21,22:Begin
            if E.AccesCloture then
             begin
              TaPCA.BeforeInsert := TaPCABeforeInsert;
              TaPCA.BeforeEdit := TaPCABeforeEdit;
              TaPCA.BeforeDelete := TaPCABeforeDelete;
             end
            else
             begin
              TaPCA.BeforeInsert := TaPCABeforeEIDClo_Abort;
              TaPCA.BeforeEdit := TaPCABeforeEIDClo_Abort;
              TaPCA.BeforeDelete := TaPCABeforeEIDClo_Abort;
             end;
           End;
  end;

End;



procedure TDMChargeCA.GestionFiltrageAideCompte(sender:tobject);
begin
  case self.tag of
     11,21:Begin //charges
              AideCompte.FiltrageAideCompteSurCompte(13,DMChargeCA.CompteDeChargeOuDeProduit);
           End;

     12,22:Begin//produits
              AideCompte.FiltrageAideCompteSurCompte(14,DMChargeCA.CompteDeChargeOuDeProduit);
           End;
  end;//fin du case self.tag
end;

Function EditionChargeCAL(TypeEdition : integer; Quand, Quoi : integer; DataSet:TDataSet;Compte,compte2:String;Site:TEditLien):Boolean;
Var
ListeCompte,ListeCompte2:TStringList;
Begin
ListeCompte:=TStringList.Create;
ListeCompte.Add(Compte);
ListeCompte2:=TStringList.Create;
ListeCompte2.Add(Compte2);
EditionChargeCAL(TypeEdition,Quand,Quoi,DataSet,ListeCompte,ListeCompte2,Site);
End;

Function EditionChargeCAL(TypeEdition : integer; Quand, Quoi : integer; DataSet:TDataSet;ListeCompte,ListeCompte2:TStringList;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
NomMenuSiteWeb:TfileStream;
TotQteCompte2,TotMontantHTCompte2,TotQteCompte,TotMontantHTCompte:currency;
TotGENQte,TotGENMontantHT:currency;
ListeValeur:TStringList;
ObjPrn:TObjetEdition;
TitreCompte,ValeurCompte,ValeurCompte2:string;
LibelleQuand:string;
Begin
try
 ObjPrn:=TObjetEdition.Create(application.MainForm);
 Chemin :=E.RepertoireComptaWeb;
 
TotQteCompte2:=0;
TotMontantHTCompte2:=0;
TotQteCompte:=0;
TotMontantHTCompte:=0;
TotGENQte:=0;
TotGENMontantHT:=0;

 case Quand of
    C_Ouverture: begin
                     LibelleQuand:='à l''ouverture';
                     case DMChargeCA.Tag of
                        11:NomFich:='ChargesCAOuv';
                        12:NomFich:='ProduitsCAOuv';
                     end;
                 end;
    C_Cloture : begin
                    LibelleQuand:='à la clôture';
                    case DMChargeCA.Tag of
                        21:NomFich:='ChargesCAClo';
                        22:NomFich:='ProduitsCAClo';
                    end;
                end;
 end;


 if DMChargeCA=nil then DMChargeCA:=TDMChargeCA.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
   // Inutile dans Stocks pour l'instant
  end;
 ListeValeur:=TStringList.Create;
 ObjPrn.FontLigneSeule.Style := [fsBold];

 DMChargeCA.QuChargeCAEdition.Filtered:=false;
 DMChargeCA.QuChargeCAEdition.OnFilterRecord :=nil;

   if ListeCompte2<>nil then
     DMChargeCA.ListeEditCompte2.Assign(ListeCompte2);

 if ListeCompte <> nil then
  begin
   TitreCompte:='Du compte :'+ListeCompte.Strings[0]+' au compte :'+ListeCompte.Strings[ListeCompte.count-1];
   DMChargeCA.ListeEditCompte.Assign(ListeCompte);
   DMChargeCA.QuChargeCAEdition.OnFilterRecord :=DMChargeCA.QuChargeCAFilterRecord;
   DMChargeCA.QuChargeCAEdition.Filtered:=true;
  end
 else
  begin
    case quoi of
      1: TitreCompte:=' Toutes les charges constatées d''avance';
      2: TitreCompte:=' Tous les produits constatés d''avance';
    end;//fin du case quoi
  end;

 //tronc commun au 2 états
 DMChargeCA.QuChargeCAEdition.Params.Clear;
 DMChargeCA.QuChargeCAEdition.SQL.Clear;
 DMChargeCA.QuChargeCAEdition.SQL.Add('select * from PCA.db ');
 DMChargeCA.QuChargeCAEdition.SQL.Add(' where DateSaisie =:DateANouveau');
 case Quoi of
    1:begin
        DMChargeCA.QuChargeCAEdition.SQL.Add(' and Sens=''D''');
        ObjPrn.FTitreEdition := 'Etat des charges constatées d''avance '+LibelleQuand;
      end;
    2:begin
        DMChargeCA.QuChargeCAEdition.SQL.Add(' and Sens=''C''');
        ObjPrn.FTitreEdition := 'Etat des produits constatés d''avance '+LibelleQuand;
      end;
 end;
 DMChargeCA.QuChargeCAEdition.SQL.Add(' order by compte,compte2');
 DMChargeCA.QuChargeCAEdition.Params[0].DataType := ftDAte;
 //fin du tronc commun au 2 états

 case Quand of
    C_Ouverture:begin
                 DMChargeCA.QuChargeCAEdition.Params[0].AsDate := E.DatExoDebut -1;
                 DMChargeCA.QuChargeCAEdition.Open;
                 if DMChargeCA.QuChargeCAEdition.recordcount<>0 then
                 begin
                 DMChargeCA.QuChargeCAEdition.First;
                 ValeurCompte:=DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString;
                 ListeValeur.Add('9;COMPTE : '+ValeurCompte);
                 while not DMChargeCA.QuChargeCAEdition.Eof do
                   begin
                    TotQteCompte2:=TotQteCompte2+DMChargeCA.QuChargeCAEdition.FindField('Qte').AsCurrency;
                    TotMontantHTCompte2:=TotMontantHTCompte2+DMChargeCA.QuChargeCAEdition.FindField('MontantHT').AsCurrency;
                    TotQteCompte:=TotQteCompte+DMChargeCA.QuChargeCAEdition.FindField('Qte').AsCurrency;
                    TotMontantHTCompte:=TotMontantHTCompte+DMChargeCA.QuChargeCAEdition.FindField('MontantHT').AsCurrency;
                    TotGENQte:=TotGENQte+DMChargeCA.QuChargeCAEdition.FindField('Qte').AsCurrency;
                    TotGENMontantHT:=TotGENMontantHT+DMChargeCA.QuChargeCAEdition.FindField('MontantHT').AsCurrency;
                    ValeurCompte2:=DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString;
                    ListeValeur.Add('0'+
                                     ';  '+
                                     ';'+
                                     GereLibelle(DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString)+
                                     ';'+
                                     GereLibelle(DMChargeCA.QuChargeCAEdition.FindField('Libelle2').AsString)+
                                     ';'+
                                     DMChargeCA.QuChargeCAEdition.FindField('Qte').AsString+
                                     ';'+
                                     DMChargeCA.QuChargeCAEdition.FindField('MontantHT').AsString
                                     );
                    DMChargeCA.QuChargeCAEdition.Next;
                    if ((ValeurCompte <> DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString)or(ValeurCompte2<>DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString)) then
                     begin
                      if ValeurCompte<>DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString then
                        begin
                            ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2));
                            ListeValeur.Add('1;;; @TOTAL DU COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+CurrToStr(TotQteCompte)+';'+CurrToStr(TotMontantHTCompte));
                            ValeurCompte:=DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString;
                            TotQteCompte:=0;
                            TotMontantHTCompte:=0;
                            ValeurCompte:=DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString;
                            ListeValeur.Add('9;COMPTE : '+ValeurCompte);
                        end
                      else
                      if ValeurCompte2<>DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString then
                        begin
                            ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2));
                            ValeurCompte2:=DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString;
                            TotQteCompte2:=0;
                            TotMontantHTCompte2:=0;
                        end;
                     end;
                   end;
                 ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2));
                 ListeValeur.Add('1;;; @TOTAL DU COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+CurrToStr(TotQteCompte)+';'+CurrToStr(TotMontantHTCompte));
                 ListeValeur.Add('1;;; @TOTAL GENERAL   : ;'+CurrToStr(TotGENQte)+';'+CurrToStr(TotGENMontantHT));
                 DMChargeCA.QuChargeCAEdition.Close;
                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ListeValeur.Insert(0,' Compte ; Compte reprise ; Libellé ; Qté ; Montant Total ');
                 ListeValeur.Insert(1,'1;1.2;2;0.6;1');
                 ListeValeur.Insert(2,'texte;texte;texte;curr;curr');
                 end;
                 ObjPrn.AffichageImp(ListeValeur);
                end;

    C_Cloture: begin
                 DMChargeCA.QuChargeCAEdition.Params[0].AsDate := E.DatExoFin;
                 DMChargeCA.QuChargeCAEdition.Open;
                 if DMChargeCA.QuChargeCAEdition.recordcount<>0 then
                 begin
                 DMChargeCA.QuChargeCAEdition.First;
                 ValeurCompte:=DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString;
                 ListeValeur.Add('9;COMPTE : '+ValeurCompte);
                 while not DMChargeCA.QuChargeCAEdition.Eof do
                   begin
                    TotQteCompte2:=TotQteCompte2+DMChargeCA.QuChargeCAEdition.FindField('Qte').AsCurrency;
                    TotMontantHTCompte2:=TotMontantHTCompte2+DMChargeCA.QuChargeCAEdition.FindField('MontantHT').AsCurrency;
                    TotQteCompte:=TotQteCompte+DMChargeCA.QuChargeCAEdition.FindField('Qte').AsCurrency;
                    TotMontantHTCompte:=TotMontantHTCompte+DMChargeCA.QuChargeCAEdition.FindField('MontantHT').AsCurrency;
                    TotGENQte:=TotGENQte+DMChargeCA.QuChargeCAEdition.FindField('Qte').AsCurrency;
                    TotGENMontantHT:=TotGENMontantHT+DMChargeCA.QuChargeCAEdition.FindField('MontantHT').AsCurrency;
                    ValeurCompte2:=DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString;
                    ListeValeur.Add('0'+
                                     ';  '+
                                     ';'+
                                     GereLibelle(DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString)+
                                     ';'+
                                     GereLibelle(DMChargeCA.QuChargeCAEdition.FindField('Libelle2').AsString)+
                                     ';'+
                                     DMChargeCA.QuChargeCAEdition.FindField('Qte').AsString+
                                     ';'+
                                     DMChargeCA.QuChargeCAEdition.FindField('MontantHT').AsString
                                     );
                    DMChargeCA.QuChargeCAEdition.Next;
                    if ((ValeurCompte <> DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString)or(ValeurCompte2<>DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString)) then
                     begin
                      if ValeurCompte<>DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString then
                        begin
                            ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2));
                            ListeValeur.Add('1;;; @TOTAL DU COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+CurrToStr(TotQteCompte)+';'+CurrToStr(TotMontantHTCompte));
                            ValeurCompte:=DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString;
                            TotQteCompte:=0;
                            TotMontantHTCompte:=0;
                            ValeurCompte:=DMChargeCA.QuChargeCAEdition.FindField('Compte').AsString;
                            ListeValeur.Add('9;COMPTE : '+ValeurCompte);
                        end
                      else
                      if ValeurCompte2<>DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString then
                        begin
                            ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2));
                            ValeurCompte2:=DMChargeCA.QuChargeCAEdition.FindField('Compte2').AsString;
                            TotQteCompte2:=0;
                            TotMontantHTCompte2:=0;
                        end;
                     end;
                   end;
                 ListeValeur.Add('1;;; @Total du compte de reprise  '+GereLibelle(ValeurCompte2)+' : ;'+CurrToStr(TotQteCompte2)+';'+CurrToStr(TotMontantHTCompte2));
                 ListeValeur.Add('1;;; @TOTAL DU COMPTE  '+GereLibelle(ValeurCompte)+' : ;'+CurrToStr(TotQteCompte)+';'+CurrToStr(TotMontantHTCompte));
                 ListeValeur.Add('1;;; @TOTAL GENERAL   : ;'+CurrToStr(TotGENQte)+';'+CurrToStr(TotGENMontantHT));
                 DMChargeCA.QuChargeCAEdition.Close;
                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ListeValeur.Insert(0,' Compte ; Compte reprise ; Libellé ; Qté ; Montant Total ');
                 ListeValeur.Insert(1,'1;1.2;2;0.6;1');
                 ListeValeur.Insert(2,'texte;texte;texte;curr;curr');
                 end;
                 ObjPrn.AffichageImp(ListeValeur);
                end;
 end;
Finally
   DeFiltrageDataSet(DMChargeCA.QuChargeCAEdition);
   DMChargeCA.QuChargeCAEdition.OnFilterRecord :=nil;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
End;

procedure TDMChargeCA.QuChargeCAFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ListeEditCompte.IndexOf(DAtaSet.findField('compte').AsString) <> -1;
//if accept then
//  accept := ListeEditCompte2.IndexOf(DAtaSet.findField('compte2').AsString) <> -1;
end;


end.
